/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

#include <clientprefs>
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
#include "fuckit/models/group.sp"
#include "fuckit/models/knife.sp"
#include "fuckit/models/user.sp"

Group g_hGroups[GROUP_MAX];

Knife g_hKnives[KNIFE_MAX];
int g_iKnives[MAXPLAYERS + 1];

Glove g_hGloves[GLOVE_MAX];
int g_iGloves[MAXPLAYERS + 1];
int g_iGloveSkins[MAXPLAYERS + 1];

Menu g_hSkinMenus[MAXPLAYERS + 1];
char g_cSkinWeapon[MAXPLAYERS + 1][64];
int g_iSkinWeaponPaint[MAXPLAYERS + 1];
bool g_bSkinSearch[MAXPLAYERS + 1];

User g_hUsers[MAXPLAYERS + 1];

int g_iSwapOnRoundEnd[MAXPLAYERS + 1];

Handle g_hKnifeCookie;
Handle g_hGloveCookie;

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

    g_hKnifeCookie = RegClientCookie("fuckit_knife", "Knife ID for FuckIt", CookieAccess_Protected);
    g_hGloveCookie = RegClientCookie("fuckit_gloves", "Gloves ID for FuckIt", CookieAccess_Protected);

    Database.Connect(Backend_Connnection, "development");

    RegConsoleCmd("sm_admins", Command_Admins);
    RegConsoleCmd("sm_groups", Command_Groups);
    RegConsoleCmd("sm_gloves", Command_Gloves);
    RegConsoleCmd("sm_knife", Command_Knife);
    RegConsoleCmd("sm_skins", Command_Skins);
    RegAdminCmd("sm_respawn", Command_Respawn, ADMFLAG_SLAY, "Respawns a dead player.");
    RegAdminCmd("sm_team_t", Command_Team_T, ADMFLAG_CHAT, "Swap a client to the terrorist team.");
    RegAdminCmd("sm_team_ct", Command_Team_CT, ADMFLAG_CHAT, "Swap a client to the counter-terrorist team.");
    RegAdminCmd("sm_team_spec", Command_Team_Spec, ADMFLAG_CHAT, "Swap a client to the spectator team.");

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
 * OnClientPutInServer
 * Adds client index to knives and gloves array and hooks "OnPostWeaponEquip".
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

    int definitionIndex = -1;
    if(StrContains(classname, "weapon_knife", false) == 0 && g_iKnives[client] > 0) {
        definitionIndex = g_iKnives[client];
        SetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex", definitionIndex);
    }

    // TODO: Add ammo thingy
    if((StrContains(g_cSkinWeapon[client], "weapon_knife") != -1 && StrContains(classname, "weapon_knife") != -1) || StrEqual(classname, g_cSkinWeapon[client])) {
        if(definitionIndex == -1) {
            for(int i = 1; i < sizeof(g_cWeaponClasses); i++) {
                if(StrEqual(g_cWeaponClasses[i], classname)) {
                    definitionIndex = g_iWeaponDefIndex[i];
                }
            }

            if(definitionIndex == -1) {
                PrintToChat(client, "%s Welp fuck %s", PREFIX);
                return;
            }
        }

        SetEntProp(entity, Prop_Send, "m_iItemIDLow", -1);
        SetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex", definitionIndex);
        SetEntProp(entity, Prop_Send, "m_nFallbackPaintKit", g_iSkinWeaponPaint[client]);
        SetEntPropFloat(entity, Prop_Send, "m_flFallbackWear", 0.01);
        SetEntProp(entity, Prop_Send, "m_nFallbackSeed", GetRandomInt(0, 8192));
        SetEntPropEnt(entity, Prop_Data, "m_hParent", client);
        SetEntPropEnt(entity, Prop_Data, "m_hOwnerEntity", client);
        SetEntPropEnt(entity, Prop_Data, "m_hMoveParent", client);
        SetEntPropEnt(entity, Prop_Send, "m_hPrevOwner", -1);
    }
}

/**
 * OnClientSettingsChanged
 * Prevents clients from being able to modify their clantag if a custom one is specified.
 */
public void OnClientSettingsChanged(int client) {
    if(g_hUsers[client] == null && IsClientInGame(client)) {
        CS_SetClientClanTag(client, "");
    } else {
        SetTag(client);
    }
}

/**
 * OnClientCookiesCached
 * Loads client's cookies into memory.
 */
public void OnClientCookiesCached(int client) {
    g_iKnives[client] = 0;
    g_iGloves[client] = 0;
    g_bSkinSearch[client] = false;

    char knife[8];
    char gloves[16];
    GetClientCookie(client, g_hKnifeCookie, knife, sizeof(knife));
    GetClientCookie(client, g_hGloveCookie, gloves, sizeof(gloves));

    char gloveSections[2][8];
    ExplodeString(gloves, ";", gloveSections, 2, 8, true);

    g_iKnives[client] = StringToInt(knife);
    g_iGloves[client] = StringToInt(gloveSections[0]);
    g_iGloveSkins[client] = StringToInt(gloveSections[1]);
}

/**
 * OnClientAuthorized
 * Prints chat message when a client connects and loads the client's data from the backend.
 */
public void OnClientAuthorized(int client, const char[] auth) {
    if(StrEqual(auth, "BOT", true)) {
        return;
    }

    PrintToChatAll("%s \x05%N \x01has connected. (%s)", PREFIX, client, auth);
    PrintToServer("%s %N has connected. (%s)", CONSOLE_PREFIX, client, auth);
    Backend_GetUser(client, auth);
}

/**
 * OnClientDisconnect
 * Prints chat message when a client disconnects.
 */
public void OnClientDisconnect(int client) {
    char steamId[64];
    GetClientAuthId(client, AuthId_Steam2, steamId, sizeof(steamId), true);

    PrintToChatAll("%s \x05%N \x01has disconnected. (%s)", PREFIX, client, steamId);
    PrintToServer("%s %N has disconnected. (%s)", CONSOLE_PREFIX, client, steamId);
}

/**
 * OnClientDisconnect_Post
 * Deletes memory allocation for the client's data if it is loaded.
 */
public void OnClientDisconnect_Post(int client) {
    if(g_hUsers[client] == null) {
        return;
    }

    delete g_hUsers[client];
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

/**
 * SetTag
 * Sets a client's clantag to the one specified in their group.
 */
public void SetTag(int client) {
    if(!IsClientValid(client)) {
        return;
    }

    User user = g_hUsers[client];
    if(user == null) {
        return;
    }

    Group group = g_hGroups[user.GetGroup()];
    if(group == null) {
        return;
    }

    char groupTag[16];
    group.GetTag(groupTag, sizeof(groupTag));

    CS_SetClientClanTag(client, groupTag);
}

/**
 * SetTagDelayed
 * Runs a delayed timer that updates
 */
public void SetTagDelayed(int client) {
    if(!IsClientValid(client)) {
        return;
    }

    CreateTimer(7.5, Timer_Tag, client);
}

/**
 * Timer_Tag
 * Handles SetTagDelayed()
 */
public Action Timer_Tag(Handle timer, int client) {
    SetTag(client);
}

/**
 * Timer_TagAll
 * Sets all player's clantag to the one specified in their group.
 */
public Action Timer_TagAll(Handle timer) {
    for(int client = 1; client <= MaxClients; client++) {
        if(!IsClientValid(client) || g_hUsers[client] == null) {
            continue;
        }

        SetTag(client);
    }
}
