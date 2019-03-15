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

    // Check if the client is invalid.
    if(!IsClientValid(client)) {
        return Plugin_Continue;
    }

    // Check if the client is dead.
    if(!IsPlayerAlive(client)) {
        return Plugin_Continue;
    }

    // Check if the client has gloves equipped.
    if(g_iGloves[client] != 0 && g_iGloveSkins[client] != 0) {
        // Refresh the client's physical gloves.
        Gloves_Refresh(client);
    }

    // Check if the client has a knife equipped.
    if(g_iKnives[client] != 0) {
        // Refresh the client's physical knife.
        Knives_Refresh(client);
    }

    // Refresh the client's physical skins.
    Skins_RefreshAll(client);

    return Plugin_Continue;
}
