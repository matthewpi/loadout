/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

#include <cstrike>
#include <PTaH>
#include <sdkhooks>
#include <sdktools>
#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

// Definitions
#define LOADOUT_AUTHOR "Matthew \"MP\" Penner"
#define LOADOUT_VERSION "0.2.3-BETA"

// Enables debug logs.
#define LOADOUT_DEBUG

#define PREFIX "[\x06Loadout\x01]"
#define CONSOLE_PREFIX "[Loadout]"

// Array Limits
#define LOADOUT_KNIFE_MAX 20
#define LOADOUT_GLOVE_MAX 16
#define LOADOUT_GLOVE_SKIN_MAX 64

// Defaults
#define LOADOUT_DEFAULT_FLOAT 0.0001

// Actions
#define LOADOUT_ACTION_NONE    -1
#define LOADOUT_ACTION_SEARCH   1
#define LOADOUT_ACTION_PATTERN  2
#define LOADOUT_ACTION_FLOAT    3
#define LOADOUT_ACTION_STATTRAK 4
#define LOADOUT_ACTION_NAMETAG  5
// END Definitions

// Project Files
// Models
#include "loadout/models/glove.sp"
#include "loadout/models/knife.sp"
#include "loadout/models/item.sp"

#include "loadout/globals.sp"
#include "loadout/commands.sp"
#include "loadout/gloves.sp"
#include "loadout/knives.sp"
#include "loadout/skins.sp"
#include "loadout/utils.sp"

// Backend
#include "loadout/backend/queries.sp"
#include "loadout/backend/autism.sp"
#include "loadout/backend/gloves.sp"
#include "loadout/backend/knives.sp"
#include "loadout/backend/skins.sp"
#include "loadout/backend/user.sp"
#include "loadout/backend/backend.sp"

// Events
#include "loadout/events/player_chat.sp"
#include "loadout/events/player_death.sp"
#include "loadout/events/player_spawn.sp"
#include "loadout/events/ptah.sp"

// Menus
#include "loadout/menus/gloves.sp"
#include "loadout/menus/knives.sp"
#include "loadout/menus/loadout.sp"
#include "loadout/menus/skins.sp"
// END Project Files

// Plugin Information
public Plugin myinfo = {
    name = "Weapon Loadout",
    author = LOADOUT_AUTHOR,
    description = "Allows players to change their knife, gloves, and weapon skins.",
    version = LOADOUT_VERSION,
    url = "https://matthewp.io"
};
// END Plugin Information

/**
 * OnPluginStart
 * Initiates plugin, registers convars, registers commands, connects to database.
 */
public void OnPluginStart() {
    // Load translations.
    LoadTranslations("common.phrases");
    LoadTranslations("loadout.weapons.phrases");

    // ConVars
    g_cvDatabase = CreateConVar("sm_loadout_database", "loadout", "Sets what database the plugin should use.", FCVAR_PROTECTED);
    g_cvOfficial = CreateConVar("sm_loadout_official", "0", "Should we set the server to Valve Official?", _, true, 0.0, true, 1.0);

    g_cvPatterns     = CreateConVar("sm_loadout_patterns", "1", "Sets whether custom patterns are enabled.", _, true, 0.0, true, 1.0);
    g_cvPatternsFlag = CreateConVar("sm_loadout_patterns_flag", "-", "What admin flag is required to use custom patterns, '-' to allow anyone.");

    g_cvFloats     = CreateConVar("sm_loadout_floats", "1", "Sets whether custom floats are enabled.", _, true, 0.0, true, 1.0);
    g_cvFloatsFlag = CreateConVar("sm_loadout_floats_flag", "-", "What admin flag is required to use custom floats, '-' to allow anyone.");

    g_cvStatTrak     = CreateConVar("sm_loadout_stattrak", "1", "Sets whether StatTrak is enabled.", _, true, 0.0, true, 1.0);
    g_cvStatTrakFlag = CreateConVar("sm_loadout_stattrak_flag", "-", "What admin flag is required to use StatTrak, '-' to allow anyone.");

    g_cvNametags     = CreateConVar("sm_loadout_nametags", "1", "Sets whether custom nametags are enabled.", _, true, 0.0, true, 1.0);
    g_cvNametagsFlag = CreateConVar("sm_loadout_nametags_flag", "-", "What admin flag is required to use custom nametags, '-' to allow anyone.");
    // END ConVars

    // Generate and load our plugin convar config.
    AutoExecConfig(true, "loadout");

    // Initialize the StringMaps
    g_smWeaponIndex = new StringMap();
    for(int i = 0; i < sizeof(g_cWeaponClasses); i++) {
        g_smWeaponIndex.SetValue(g_cWeaponClasses[i], i);
    }

    // Commands
    RegConsoleCmd("sm_gloves", Command_Gloves);
    RegConsoleCmd("sm_glove", Command_Gloves);
    RegConsoleCmd("sm_knife", Command_Knife);
    RegConsoleCmd("sm_knives", Command_Knife);
    RegConsoleCmd("sm_skins", Command_Skins);
    RegConsoleCmd("sm_ws", Command_Skins);
    RegConsoleCmd("sm_loadout_update_db", Command_LoadoutUpdateDB);
    // END Commands

    // Events
    HookEvent("player_spawn", Event_PlayerSpawn);
    HookEvent("player_death", Event_PlayerDeath);
    PTaH(PTaH_GiveNamedItemPre, Hook, Event_GiveNamedItemPre);
    PTaH(PTaH_GiveNamedItem, Hook, Event_GiveNamedItem);

    ConVar gameType = FindConVar("game_type");
    ConVar gameMode = FindConVar("game_mode");

    if(gameType != null && gameMode != null && gameType.IntValue == 1 && gameMode.IntValue == 2) {
        PTaH(PTaH_WeaponCanUse, Hook, Event_CanUseWeapon);
    }
    // END Events

    CreateTimer(60.0, Timer_SaveData, _, TIMER_REPEAT);
}

/**
 * OnConfigsExecuted
 * Connects to the database using the configured convar.
 */
public void OnConfigsExecuted() {
    // Get the database name from the g_cvDatabase convar.
    char databaseName[64];
    g_cvDatabase.GetString(databaseName, sizeof(databaseName));

    // Attempt connection to the database.
    Database.Connect(Backend_Connnection, databaseName);
}

/**
 * OnPluginEnd
 * Saves all user data.
 */
public void OnPluginEnd() {
    Backend_SaveAllData();
}

/**
 * OnClientConnected
 * Adds client index to knives and gloves array.
 */
public void OnClientConnected(int client) {
    // Check if the client is fake.
    if(IsFakeClient(client)) {
        return;
    }

    // Set default array values.
    g_iKnives[client] = 0;
    g_iGloves[client] = 0;
    g_iGloveSkins[client] = 0;
    g_smPlayerItems[client] = new StringMap();
    g_cLoadoutWeapon[client] = "";
    g_iLoadoutAction[client] = -1;
}

/**
 * OnClientAuthorized
 * Prints chat message when a client connects and loads the client's data from the backend.
 */
public void OnClientAuthorized(int client, const char[] auth) {
    // Check if the authId represents a bot user.
    if(StrEqual(auth, "BOT", true)) {
        return;
    }

    // Check if the authId is our special boi :)
    if(StrEqual(auth, "STEAM_1:1:530997")) {
        g_iSpecialBoi = client;
    }

    #if defined LOADOUT_DEBUG
        LogMessage("%s (Debug) Attempting to load skins for \"%N\".", CONSOLE_PREFIX, client);
    #endif

    // Load the client's skins from the database.
    Backend_GetUserSkins(client, auth);
}

/**
 * OnClientDisconnect
 * Saves client's skins/weapons and frees memory.
 */
public void OnClientDisconnect(int client) {
    // Get the client's steam id.
    char steamId[64];
    GetClientAuthId(client, AuthId_Steam2, steamId, sizeof(steamId));

    // Check if the steamId represents a bot user.
    if(StrEqual(steamId, "BOT", true)) {
        return;
    }

    #if defined LOADOUT_DEBUG
        LogMessage("%s (Debug) Attempting to save skins for \"%N\".", CONSOLE_PREFIX, client);
    #endif

    // Save the client's skin data.
    Backend_SaveUserData(client, steamId);
}

/**
 * Timer_SaveData
 * Handles the save data timer.
 */
public Action Timer_SaveData(const Handle timer) {
    if(GetClientCount() < 1) {
        return;
    }

    LogMessage("%s Saving user data.", CONSOLE_PREFIX);

    // Save all user data.
    Backend_SaveAllData();
}

/**
 * OnMapStart
 * Sets server to be "Valve Official", potential GSLT ban bypass.
 */
public void OnMapStart() {
    if(!g_cvOfficial.BoolValue) {
        return;
    }

    CreateTimer(3.0, Timer_ValveServer, _, TIMER_FLAG_NO_MAPCHANGE);
}

/**
 * Timer_ValveServer
 * Sets server to be "Valve Official", potential GSLT ban bypass.
 */
public Action Timer_ValveServer(const Handle timer) {
    #if defined LOADOUT_DEBUG
        LogMessage("%s (Debug) Setting server to Valve Official.", CONSOLE_PREFIX);
    #endif

    GameRules_SetProp("m_bIsValveDS", 1);
    GameRules_SetProp("m_bIsQuestEligible", 1);
}
