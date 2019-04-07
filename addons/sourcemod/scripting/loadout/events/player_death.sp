/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

/**
 * Event_PlayerDeath
 * Increments a player's stattrak.
 */
public Action Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast) {
    int client = GetClientOfUserId(event.GetInt("userid"));

    // Check if the client is invalid.
    if(!IsClientValid(client)) {
        return Plugin_Continue;
    }

    int attacker = GetClientOfUserId(event.GetInt("attacker"));

    // Check if the attacker is invalid.
    if(!IsClientValid(attacker)) {
        return Plugin_Continue;
    }

    // Check if the attacker can use stattrak.
    if(!CanUseStattrak(attacker)) {
        return Plugin_Continue;
    }

    // Get the attacker's weapon.
    char classname[64];
    event.GetString("weapon", classname, sizeof(classname), "");
    Format(classname, sizeof(classname), "weapon_%s", classname);

    // Check if the weapon name is invalid.
    if(strlen(classname) < 1) {
        return Plugin_Continue;
    }

    // Get the attacker's weapon.
    Item item = null;
    if(!g_smPlayerItems[attacker].GetValue(classname, item)) {
        return Plugin_Continue;
    }

    // Increment the item's stattrak.
    int statTrak = item.GetStatTrak();
    if(statTrak != 133337) {
        statTrak++;
        item.SetStatTrak(statTrak);
    }

    return Plugin_Continue;
}
