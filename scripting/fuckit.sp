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
#include "fuckit/models/group.sp"
#include "fuckit/models/knife.sp"
#include "fuckit/models/user.sp"

Group g_hGroups[GROUP_MAX];

Knife g_hKnives[KNIFE_MAX];
int g_iKnives[MAXPLAYERS + 1];

Glove g_hGloves[GLOVE_MAX];
int g_iGloves[MAXPLAYERS + 1];

User g_hUsers[MAXPLAYERS + 1];

int g_iSwapOnRoundEnd[MAXPLAYERS + 1];

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
}

/**
 * OnClientPutInServer
 * Adds client index to knives and gloves array and hooks "OnPostWeaponEquip".
 */
public void OnClientPutInServer(int client) {
    g_iKnives[client] = 0;
    g_iGloves[client] = 0;
    SDKHook(client, SDKHook_WeaponEquip, OnPostWeaponEquip);
}

public Action OnPostWeaponEquip(int client, int entity) {
    char classname[64];
    if(!GetEdictClassname(entity, classname, 64)) {
        return;
    }

    if(StrContains(classname, "weapon_knife", false) == 0 && g_iKnives[client] > 0) {
        SetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex", g_iKnives[client]);
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
