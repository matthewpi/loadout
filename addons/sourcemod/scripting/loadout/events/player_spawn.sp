/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

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

    Skins_RefreshAll(client, false);

    if(g_iGloves[client] != 0 && g_iGloveSkins[client] != 0) {
        Gloves_Refresh(client);
    }

    return Plugin_Continue;
}
