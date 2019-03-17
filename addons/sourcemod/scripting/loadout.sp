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
#define LOADOUT_VERSION "0.2.1-BETA"

// Enables debug logs.
#define LOADOUT_DEBUG

#define PREFIX "[\x06Loadout\x01]"
#define CONSOLE_PREFIX "[Loadout]"

#define GROUP_MAX 16
#define KNIFE_MAX 20
#define GLOVE_MAX 16
#define GLOVE_SKIN_MAX 64
#define USER_ITEM_MAX 75
#define ITEM_FLOAT_MIN 0.0001
// END Definitions

// Globals
// sm_loadout_database      - "Sets what database the plugin should use." (Default: "loadout")
ConVar g_cvDatabase;
// sm_loadout_stattrak      - "Sets whether stattrak weapons are enabled." (Default: "1")
ConVar g_cvStatTrak;
// sm_loadout_stattrak_flag - "Sets what admin flag is required to use stattrak, use -1 to allow anyone." (Default: "o")
ConVar g_cvStatTrakFlag;
// sm_loadout_nametags      - "Sets whether weapon nametags are enabled." (Default: "1")
ConVar g_cvNametags;
// sm_loadout_nametags_flag - "Sets what admin flag is required to use nametags, use -1 to allow anyone." (Default: "o")
ConVar g_cvNametagsFlag;

// g_hDatabase stores the active database connection.
Database g_hDatabase;

// g_iKnives stores all player knives. (not skins)
int g_iKnives[MAXPLAYERS + 1];

// g_iGloves stores all player gloves.
int g_iGloves[MAXPLAYERS + 1];
// g_iGloveSkins stores all player glove skins.
int g_iGloveSkins[MAXPLAYERS + 1];

// g_hSkinMenus stores the active menus in use by player for selecting skins.
Menu g_hSkinMenus[MAXPLAYERS + 1];

// g_cSkinWeapon stores the weapon a player is currently applying a skin to.
char g_cSkinWeapon[MAXPLAYERS + 1][64];
// g_bSkinSearch stores a player index with a boolean based off of if they are searching for a skin.
bool g_bSkinSearch[MAXPLAYERS + 1];
// g_iPatternSelect stores a player index with a int of the item they are applying a pattern to.
int g_iPatternSelect[MAXPLAYERS + 1];
// g_iFloatSelect stores a player index with a int of the item they are applying a float to.
int g_iFloatSelect[MAXPLAYERS + 1];
// g_iNametagSelect stores a player index with a int of the item they are applying a nametag to.
int g_iNametagSelect[MAXPLAYERS + 1];

// g_iSpecialBoi Special boi :^)
int g_iSpecialBoi = -1;
bool g_bSpecialBoiNametags = true;
// END Globals

// Project Models
#include "loadout/models/glove.sp"
#include "loadout/models/knife.sp"
#include "loadout/models/item.sp"
// END Project Models

// Model Globals
// g_hKnives stores all loaded knives.
Knife g_hKnives[KNIFE_MAX];

// g_hKnives stores all loaded gloves.
Glove g_hGloves[GLOVE_MAX];

// g_hPlayerItems stores all player items.
Item g_hPlayerItems[MAXPLAYERS + 1][USER_ITEM_MAX];
// END Model Globals

// Project Files
#include "loadout/commands.sp"
#include "loadout/utils.sp"

// Backend
#include "loadout/backend/queries.sp"
#include "loadout/backend/gloves.sp"
#include "loadout/backend/knives.sp"
#include "loadout/backend/skins.sp"
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
    LoadTranslations("common.phrases");
    LoadTranslations("loadout.weapons.phrases");

    g_cvDatabase     = CreateConVar("sm_loadout_database", "loadout", "Sets what database the plugin should use.");
    g_cvStatTrak     = CreateConVar("sm_loadout_stattrak", "1", "Sets whether stattrak weapons are enabled.", _, true, 0.0, true, 1.0);
    g_cvStatTrakFlag = CreateConVar("sm_loadout_stattrak_flag", "o", "Sets what admin flag is required to use stattrak, use -1 to allow anyone.");
    g_cvNametags     = CreateConVar("sm_loadout_nametags", "1", "Sets whether weapon nametags are enabled.", _, true, 0.0, true, 1.0);
    g_cvNametagsFlag = CreateConVar("sm_loadout_nametags_flag", "o", "Sets what admin flag is required to use nametags, use -1 to allow anyone.");

    AutoExecConfig(true, "loadout");

    char databaseName[64];
    g_cvDatabase.GetString(databaseName, sizeof(databaseName));

    Database.Connect(Backend_Connnection, databaseName);

    RegConsoleCmd("sm_loadout2", Command_Loadout);
    RegConsoleCmd("sm_gloves", Command_Gloves);
    RegConsoleCmd("sm_glove", Command_Gloves);
    RegConsoleCmd("sm_knife", Command_Knife);
    RegConsoleCmd("sm_knives", Command_Knife);
    RegConsoleCmd("sm_skins", Command_Skins);
    RegConsoleCmd("sm_ws", Command_Skins);
    RegConsoleCmd("sm_loadout_update_db", Command_LoadoutUpdateDB);

    HookEvent("player_spawn", Event_PlayerSpawn);
    HookEvent("player_death", Event_PlayerDeath);
    PTaH(PTaH_GiveNamedItemPre, Hook, Event_GiveNamedItemPre);
    PTaH(PTaH_GiveNamedItem, Hook, Event_GiveNamedItem);

    CreateTimer(60.0, Timer_SaveData, _, TIMER_REPEAT);
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
    g_bSkinSearch[client] = false;
    g_iPatternSelect[client] = -1;
    g_iFloatSelect[client] = -1;
    g_iNametagSelect[client] = -1;
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
    Backend_SaveAllData();
}

/**
 * OnMapStart
 * Sets server to be "Valve Official", potential GSLT ban bypass.
 */
public void OnMapStart() {
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
