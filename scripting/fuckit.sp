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

#define PREFIX " \x08[\x06FuckIt\x08]\x01"
#define CONSOLE_PREFIX "[FuckIt]"
// This might need to be increased depending on the number of groups.
#define GROUP_MAX 16
// This might need to be increased if Valve keeps adding knives.
#define KNIFE_MAX 20
// This might need to be increased if Valve keeps adding gloves.
#define GLOVE_MAX 16
// This might need to be increased if Valve keeps adding glove skins.
#define GLOVE_SKIN_MAX 64

#include "fuckit/models/glove.sp"
#include "fuckit/models/knife.sp"

Knife g_hKnives[KNIFE_MAX];
int g_iKnives[MAXPLAYERS + 1];

Glove g_hGloves[GLOVE_MAX];
int g_iGloves[MAXPLAYERS + 1];
int g_iGloveSkins[MAXPLAYERS + 1];

Menu g_hSkinMenus[MAXPLAYERS + 1];
char g_cSkinWeapon[MAXPLAYERS + 1][64];
bool g_bSkinSearch[MAXPLAYERS + 1];
StringMap g_mPlayerSkins[MAXPLAYERS + 1];

#include "fuckit/utils.sp"
#include "fuckit/backend.sp"
#include "fuckit/commands.sp"
#include "fuckit/menus/gloves.sp"
#include "fuckit/menus/knives.sp"
#include "fuckit/menus/skins.sp"

public Plugin myinfo = {
    name = "FuckIt",
    author = "Matthew \"MP\" Penner",
    description = "",
    version = "0.0.1-DEV",
    url = "https://matthewp.io"
};

public void OnPluginStart() {
    LoadTranslations("common.phrases");
    LoadTranslations("fuckit.weapons.phrases");

    Database.Connect(Backend_Connnection, "development");

    RegConsoleCmd("sm_gloves", Command_Gloves);
    RegConsoleCmd("sm_knife", Command_Knife);
    RegConsoleCmd("sm_skins", Command_Skins);
    RegConsoleCmd("sm_ws", Command_Skins);
    RegConsoleCmd("sm_save", Command_Save);

    HookEvent("player_spawn", Event_PlayerSpawn);
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
        int knifeEntity = GetPlayerWeaponSlot(client, CS_SLOT_KNIFE);

        if(knifeEntity != -1) {
            int currentKnife = GetEntProp(knifeEntity, Prop_Send, "m_iItemDefinitionIndex");

            if(g_iKnives[client] != currentKnife) {
                Knives_Refresh(client);
            }
        }
    }

    if(g_iGloves[client] != 0 && g_iGloveSkins[client] != 0) {
        Gloves_Refresh(client);
    }

    return Plugin_Continue;
}

/**
 * OnClientConnected
 * Adds client index to knives and gloves array.
 */
public void OnClientConnected(int client) {
    g_iKnives[client] = 0;
    g_iGloves[client] = 0;
    g_bSkinSearch[client] = false;
    g_mPlayerSkins[client] = new StringMap();
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
    if(itemIndex == 61) {
        classname = "weapon_usp_silencer";
    }
    if(itemIndex == 63) {
        classname = "weapon_cz75a";
    }

    PrintToChat(client, "%s %s", PREFIX, classname);

    int definitionIndex = -1;
    if(StrContains(classname, "weapon_knife") == 0 && g_iKnives[client] > 0) {
        definitionIndex = g_iKnives[client];
        SetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex", definitionIndex);
    }

    char itemName[64];
    bool isKnife = false;
    if(StrContains(classname, "weapon_knife") != -1) {
        isKnife = true;
        for(int i = 1; i < KNIFE_MAX; i++) {
            Knife knife = g_hKnives[i];
            if(knife == null) {
                continue;
            }

            if(knife.GetItemID() == g_iKnives[client]) {
                knife.GetItemName(itemName, sizeof(itemName));
            }
        }
    }

    int skinId = 0;
    if((isKnife && g_mPlayerSkins[client].GetValue(itemName, skinId) && skinId != 0) || (g_mPlayerSkins[client].GetValue(classname, skinId) && skinId != 0)) {
        PrintToChat(client, "%s %s", PREFIX, classname);
        if(isKnife) {
            PrintToChat(client, "%s - Knife", PREFIX);
        }

        if(definitionIndex == -1) {
            for(int i = 1; i < sizeof(g_cWeaponClasses); i++) {
                if(StrEqual(g_cWeaponClasses[i], classname)) {
                    definitionIndex = g_iWeaponDefIndex[i];
                }
            }

            if(definitionIndex == -1) {
                return;
            }
        }

        PrintToChat(client, "%s - Definition Index: %i", PREFIX, definitionIndex);
        PrintToChat(client, "%s - Paint Kit: %i", PREFIX, skinId);

        SetEntProp(entity, Prop_Send, "m_iItemIDLow", -1);
        SetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex", definitionIndex);
        SetEntProp(entity, Prop_Send, "m_nFallbackPaintKit", skinId);
        SetEntPropFloat(entity, Prop_Send, "m_flFallbackWear", 0.01);
        SetEntProp(entity, Prop_Send, "m_nFallbackSeed", GetRandomInt(0, 8192));
        SetEntPropEnt(entity, Prop_Data, "m_hParent", client);
        SetEntPropEnt(entity, Prop_Data, "m_hOwnerEntity", client);
        SetEntPropEnt(entity, Prop_Data, "m_hMoveParent", client);
        SetEntPropEnt(entity, Prop_Send, "m_hPrevOwner", -1);
    }
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
    if(g_mPlayerSkins[client] == null) {
        return;
    }

    char steamId[64];
    GetClientAuthId(client, AuthId_Steam2, steamId, sizeof(steamId));

    Backend_SetUserSkins(client, steamId);
}

/**
 * OnClientDisconnect_Post
 * Deletes memory allocation for the client's data if it is loaded.
 */
public Action OnClientSayCommand(int client, const char[] command, const char[] args) {
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
