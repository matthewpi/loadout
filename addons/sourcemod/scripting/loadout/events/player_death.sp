/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

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
    if(!IsClientValid(attacker) || !CanUseStattrak(attacker)) {
        return Plugin_Continue;
    }

    char classname[64];
    event.GetString("weapon", classname, sizeof(classname), "");
    Format(classname, sizeof(classname), "weapon_%s", classname);

    if(strlen(classname) < 1) {
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
