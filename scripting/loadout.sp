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

#define LOADOUT_VERSION "0.0.2-BETA"
#define LOADOUT_AUTHOR "Matthew \"MP\" Penner"

#define PREFIX "[\x06Loadout\x01]"
#define CONSOLE_PREFIX "[Loadout]"
// This might need to be increased depending on the number of groups.
#define GROUP_MAX 16
// This might need to be increased if Valve keeps adding knives.
#define KNIFE_MAX 20
// This might need to be increased if Valve keeps adding gloves.
#define GLOVE_MAX 16
// This might need to be increased if Valve keeps adding glove skins.
#define GLOVE_SKIN_MAX 64
#define USER_ITEM_MAX 75

#include "loadout/models/glove.sp"
#include "loadout/models/knife.sp"
#include "loadout/models/item.sp"

ConVar g_cvDatabase;
ConVar g_cvStatTrak;

Knife g_hKnives[KNIFE_MAX + 1];
int g_iKnives[MAXPLAYERS + 1];

Glove g_hGloves[GLOVE_MAX + 1];
int g_iGloves[MAXPLAYERS + 1];
int g_iGloveSkins[MAXPLAYERS + 1];

Menu g_hSkinMenus[MAXPLAYERS + 1];
char g_cSkinWeapon[MAXPLAYERS + 1][64];
bool g_bSkinSearch[MAXPLAYERS + 1];
Item g_hPlayerItems[MAXPLAYERS + 1][USER_ITEM_MAX + 1];

#include "loadout/utils.sp"
#include "loadout/backend.sp"
#include "loadout/commands.sp"
#include "loadout/menus/gloves.sp"
#include "loadout/menus/knives.sp"
#include "loadout/menus/loadout.sp"
#include "loadout/menus/skins.sp"

public Plugin myinfo = {
    name = "Loadout (Knives, Gloves, Skins)",
    author = LOADOUT_AUTHOR,
    description = "Allows players to change their knife, gloves, and weapon skins.",
    version = LOADOUT_VERSION,
    url = "https://matthewp.io"
};

public void OnPluginStart() {
    LoadTranslations("common.phrases");
    LoadTranslations("loadout.weapons.phrases");

    g_cvDatabase = CreateConVar("sm_loadout_database", "loadout", "Sets what database the plugin should use.");
    g_cvStatTrak = CreateConVar("sm_loadout_stattrak", "0", "Sets whether stattrak weapons are enabled.");

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
 * Event_PlayerSpawn
 * Gives a player their selected knife and glove skin.
 */
public Action Event_PlayerSpawn(Event event, const char[] name, bool dontBroadcast) {
    int client = GetClientOfUserId(event.GetInt("userid"));

    if(!IsClientValid(client) || !IsPlayerAlive(client)) {
        return Plugin_Continue;
    }

    if(g_iKnives[client] != 0) {
        char itemName[64];
        g_hKnives[g_iKnives[client]].GetItemName(itemName, sizeof(itemName));
        Knives_Refresh(client, itemName);
    }

    if(g_iGloves[client] != 0 && g_iGloveSkins[client] != 0) {
        Gloves_Refresh(client);
    }

    return Plugin_Continue;
}

/**
 * Event_PlayerDeath
 * Increments a player's stattrak.
 */
public Action Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast) {
    int enemy = GetClientOfUserId(event.GetInt("userid"));
    if(!IsClientValid(enemy)) {
        return Plugin_Continue;
    }

    int attacker = GetClientOfUserId(event.GetInt("attacker"));
    if(!CanUseStattrak(attacker)) {
        return Plugin_Continue;
    }

    char classname[64];
    event.GetString("weapon", classname, sizeof(classname), "");
    Format(classname, sizeof(classname), "weapon_%s", classname);

    if(!IsClientValid(attacker) || strlen(classname) < 1) {
        return Plugin_Continue;
    }

    Item item;
    char weapon[64];
    for(int i = 0; i < USER_ITEM_MAX; i++) {
        item = g_hPlayerItems[attacker][i];
        if(item == null) {
            continue;
        }

        item.GetWeapon(weapon, sizeof(weapon));

        if(StrEqual(weapon, classname)) {
            break;
        }
    }

    if(item == null) {
        return Plugin_Continue;
    }

    int statTrak = item.GetStatTrak();
    statTrak++;
    item.SetStatTrak(statTrak);
    return Plugin_Continue;
}

/**
 * OnClientConnected
 * Adds client index to knives and gloves array.
 */
public void OnClientConnected(int client) {
    g_iKnives[client] = 0;
    g_iGloves[client] = 0;
    g_iGloveSkins[client] = 0;
    g_bSkinSearch[client] = false;
}

/**
 * OnClientPutInServer
 * Hooks SDKHook_WeaponEquip "OnPostWeaponEquip".
 */
public void OnClientPutInServer(int client) {
    SDKHook(client, SDKHook_WeaponEquip, OnPostWeaponEquip);
}

/**
 * OnPostWeaponEquip
 * Handles setting a client's knife.
 */
public Action OnPostWeaponEquip(int client, int entity) {
    char classname[64];
    if(!GetEdictClassname(entity, classname, 64)) {
        return;
    }

    int itemIndex = GetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex");
    // Because Valve doesn't know how to do anything properly..
    if(itemIndex == 23) {
        classname = "weapon_mp5sd";
    }
    if(itemIndex == 60) {
        classname = "weapon_m4a1_silencer";
    }
    if(itemIndex == 61) {
        classname = "weapon_usp_silencer";
    }
    if(itemIndex == 63) {
        classname = "weapon_cz75a";
    }

    bool isKnife = false;
    int definitionIndex = -1;
    if(IsKnife(classname) && g_iKnives[client] > 0) {
        Knife knife = g_hKnives[g_iKnives[client]];
        if(knife == null) {
            return;
        }
        knife.GetItemName(classname, sizeof(classname));
        definitionIndex = knife.GetItemID();
    }

    Item item;
    char weapon[64];
    for(int i = 0; i < USER_ITEM_MAX; i++) {
        item = g_hPlayerItems[client][i];
        if(item == null) {
            continue;
        }

        item.GetWeapon(weapon, sizeof(weapon));

        if(StrEqual(weapon, classname)) {
            break;
        }
    }

    if(item == null) {
        return;
    }

    if(definitionIndex == -1) {
        for(int i = 0; i < sizeof(g_cWeaponClasses); i++) {
            if(StrEqual(g_cWeaponClasses[i], classname)) {
                definitionIndex = g_iWeaponDefIndex[i];
            }
        }

        if(definitionIndex == -1) {
            return;
        }
    }

    char skinIdChar[16];
    item.GetSkinID(skinIdChar, sizeof(skinIdChar));
    int skinId = StringToInt(skinIdChar);

    int pattern = item.GetPattern();
    if(pattern < 0) {
        pattern = GetRandomInt(0, 8192);
    }

    float floatValue = item.GetFloat();

    char steam32[20];
    char temp[20];
    GetClientAuthId(client, AuthId_Steam3, temp, sizeof(temp));
    strcopy(steam32, sizeof(steam32), temp[5]);
    int index;
    if((index = StrContains(steam32, "]")) > -1) {
        steam32[index] = '\0';
    }

    bool statTrak = CanUseStattrak(client) && item.GetStatTrak() != -1;

    if(!isKnife) {
        SetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex", definitionIndex);
    }
    SetEntProp(entity, Prop_Send, "m_iItemIDLow", -1);
    SetEntProp(entity, Prop_Send, "m_nFallbackPaintKit", skinId);
    SetEntPropFloat(entity, Prop_Send, "m_flFallbackWear", floatValue);
    SetEntProp(entity, Prop_Send, "m_nFallbackSeed", pattern);
    if(statTrak) {
        SetEntProp(entity, Prop_Send, "m_nFallbackStatTrak", item.GetStatTrak());
    }
    if(!isKnife) {
        if(statTrak) {
            SetEntProp(entity, Prop_Send, "m_iEntityQuality", 9);
        }
    } else {
        SetEntProp(entity, Prop_Send, "m_iEntityQuality", 3);
    }
    SetEntProp(entity, Prop_Send, "m_iAccountID", StringToInt(steam32));
    SetEntPropEnt(entity, Prop_Data, "m_hParent", client);
    SetEntPropEnt(entity, Prop_Data, "m_hOwnerEntity", client);
    SetEntPropEnt(entity, Prop_Data, "m_hMoveParent", client);
    SetEntPropEnt(entity, Prop_Send, "m_hPrevOwner", -1);
}

/**
 * OnClientAuthorized
 * Prints chat message when a client connects and loads the client's data from the backend.
 */
public void OnClientAuthorized(int client, const char[] auth) {
    if(StrEqual(auth, "BOT", true)) {
        return;
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
    Backend_SaveUserData(client, steamId);
}

/**
 * OnClientSayCommand
 * Deletes memory allocation for the client's data if it is loaded.
 */
public Action OnClientSayCommand(int client, const char[] command, const char[] args) {
    // Check if the user typed a command.
    if(strlen(args) > 0) {
        // If the command is a public showing command from this plugin, handle it then hide the message.
        if(StrEqual(args, "!ws") || StrEqual(args, "!skins")) {
            Command_Skins(client, 0);
            return Plugin_Stop;
        }

        if(StrEqual(args, "!knife") || StrEqual(args, "!knives")) {
            Command_Knife(client, 0);
            return Plugin_Stop;
        }

        if(StrEqual(args, "!glove") || StrEqual(args, "!gloves")) {
            Command_Gloves(client, 0);
            return Plugin_Stop;
        }
    }

    if(g_bSkinSearch[client]) {
        if(strlen(args) < 1 || strlen(args) > 24) {
            PrintToChat(client, "%s Your search must be between \x071\x01 and \x0724\x01 characters.", PREFIX);
            return Plugin_Stop;
        }

        Backend_SearchSkins(client, args);

        g_bSkinSearch[client] = false;
        return Plugin_Stop;
    }

    return Plugin_Continue;
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
public Action Timer_SaveData(Handle timer) {
    PrintToServer("%s Saving user data.", CONSOLE_PREFIX);
    Backend_SaveAllData();
}

/**
 * Timer_ValveServer
 * Sets server to be "Valve Official", potential GSLT ban bypass.
 */
public Action Timer_ValveServer(Handle timer) {
    GameRules_SetProp("m_bIsValveDS", 1);
    GameRules_SetProp("m_bIsQuestEligible", 1);
}
