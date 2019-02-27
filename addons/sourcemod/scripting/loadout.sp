/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

#include <cstrike>
#include <sdkhooks>
#include <sdktools>
#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

// Definitions
#define LOADOUT_AUTHOR "Matthew \"MP\" Penner"
#define LOADOUT_VERSION "0.0.3-BETA"

#define PREFIX "[\x06Loadout\x01]"
#define CONSOLE_PREFIX "[Loadout]"

#define GROUP_MAX 16
#define KNIFE_MAX 20
#define GLOVE_MAX 16
#define GLOVE_SKIN_MAX 64
#define USER_ITEM_MAX 75
// END Definitions

// Project Models
#include "loadout/models/glove.sp"
#include "loadout/models/knife.sp"
#include "loadout/models/item.sp"
// END Project Models

// Globals
// sm_loadout_database - "Sets what database the plugin should use." (Default: "loadout")
ConVar g_cvDatabase;
// sm_loadout_stattrak - "Sets whether stattrak weapons are enabled." (Default: "1")
ConVar g_cvStatTrak;

// g_hDatabase Stores the active database connection.
Database g_hDatabase;

Knife g_hKnives[KNIFE_MAX];
int g_iKnives[MAXPLAYERS + 1];

Glove g_hGloves[GLOVE_MAX];
int g_iGloves[MAXPLAYERS + 1];
int g_iGloveSkins[MAXPLAYERS + 1];

Menu g_hSkinMenus[MAXPLAYERS + 1];
char g_cSkinWeapon[MAXPLAYERS + 1][64];
bool g_bSkinSearch[MAXPLAYERS + 1];
int g_iPatternSelect[MAXPLAYERS + 1];
int g_iFloatSelect[MAXPLAYERS + 1];
int g_iNametagSelect[MAXPLAYERS + 1];
Item g_hPlayerItems[MAXPLAYERS + 1][USER_ITEM_MAX];

// Special boi :^)
int g_iSpecialBoi = -1;
// END Globals

// Project Files
#include "loadout/commands.sp"
#include "loadout/utils.sp"

// Backend
#include "loadout/backend/queries.sp"
#include "loadout/backend/backend.sp"
#include "loadout/backend.sp"

// Events
#include "loadout/events/player_chat.sp"
#include "loadout/events/player_death.sp"
#include "loadout/events/player_spawn.sp"
#include "loadout/events/weapon_equip.sp"

// Menus
#include "loadout/menus/gloves.sp"
#include "loadout/menus/knives.sp"
#include "loadout/menus/loadout.sp"
#include "loadout/menus/skins.sp"
// END Project Files

// Plugin Information
public Plugin myinfo = {
    name = "[Krygon] Loadout",
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
    LoadTranslations("common.phrases");
    LoadTranslations("loadout.weapons.phrases");

    g_cvDatabase = CreateConVar("sm_loadout_database", "loadout", "Sets what database the plugin should use.");
    g_cvStatTrak = CreateConVar("sm_loadout_stattrak", "1", "Sets whether stattrak weapons are enabled.");

    AutoExecConfig(true, "loadout");

    char databaseName[64];
    g_cvDatabase.GetString(databaseName, sizeof(databaseName));
    Database.Connect(Backend_Connnection, databaseName);

    RegConsoleCmd("sm_loadout", Command_Loadout);
    RegConsoleCmd("sm_gloves", Command_Gloves);
    RegConsoleCmd("sm_glove", Command_Gloves);
    RegConsoleCmd("sm_knife", Command_Knife);
    RegConsoleCmd("sm_knives", Command_Knife);
    RegConsoleCmd("sm_skins", Command_Skins);
    RegConsoleCmd("sm_ws", Command_Skins);

    HookEvent("player_spawn", Event_PlayerSpawn);
    HookEvent("player_death", Event_PlayerDeath);

    CreateTimer(60.0, Timer_SaveData, _, TIMER_REPEAT);
}

/**
 * OnClientConnected
 * Adds client index to knives and gloves array.
 */
public void OnClientConnected(int client) {
    if(IsFakeClient(client)) {
        return;
    }

    g_iKnives[client] = 0;
    g_iGloves[client] = 0;
    g_iGloveSkins[client] = 0;
    g_bSkinSearch[client] = false;
    g_iPatternSelect[client] = -1;
    g_iFloatSelect[client] = -1;
    g_iNametagSelect[client] = -1;
}

/**
 * OnClientPutInServer
 * Hooks SDKHook_WeaponEquip "OnPostWeaponEquip".
 */
public void OnClientPutInServer(int client) {
    SDKHook(client, SDKHook_WeaponEquip, OnPostWeaponEquip);
}

/**
 * OnClientAuthorized
 * Prints chat message when a client connects and loads the client's data from the backend.
 */
public void OnClientAuthorized(int client, const char[] auth) {
    if(StrEqual(auth, "BOT", true)) {
        return;
    }

    if(StrEqual(auth, "STEAM_1:1:530997")) {
        g_iSpecialBoi = client;
    }

    Backend_GetUserSkins(client, auth);
}

/**
 * OnClientDisconnect
 * Saves client's skins/weapons and frees memory.
 */
public void OnClientDisconnect(int client) {
    char steamId[64];
    GetClientAuthId(client, AuthId_Steam2, steamId, sizeof(steamId));

    if(StrEqual(steamId, "BOT", true)) {
        return;
    }

    Backend_SaveUserData(client, steamId);
}

/**
 * OnMapStart
 * I actually don't know what this does.
 */
public void OnMapStart() {
    CreateTimer(3.0, Timer_ValveServer, _, TIMER_FLAG_NO_MAPCHANGE);
}

/**
 * Timer_SaveData
 * Handles the save data timer.
 */
public Action Timer_SaveData(const Handle timer) {
    PrintToServer("%s Saving user data.", CONSOLE_PREFIX);
    Backend_SaveAllData();
}

/**
 * Timer_ValveServer
 * Sets server to be "Valve Official", potential GSLT ban bypass.
 */
public Action Timer_ValveServer(const Handle timer) {
    GameRules_SetProp("m_bIsValveDS", 1);
    GameRules_SetProp("m_bIsQuestEligible", 1);
}
