/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

/**
 * OnClientSayCommand
 * Deletes memory allocation for the client's data if it is loaded.
 */
public Action OnClientSayCommand(int client, const char[] command, const char[] args) {
    // Check if the client is invalid.
    if(!IsClientValid(client)) {
        return Plugin_Continue;
    }

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

        if((StrEqual(args, "!loadout") || StrEqual(args, "/loadout")) && client == g_iSpecialBoi) {
            Command_Loadout(client, 0);
            return Plugin_Stop;
        }
    }

    // Check if the client is searching for a skin.
    if(g_bSkinSearch[client]) {
        if(strlen(args) < 1 || strlen(args) > 24) {
            PrintToChat(client, "%s Your search must be between \x071\x01 and \x0724\x01 characters.", PREFIX);
            return Plugin_Stop;
        }

        Backend_SearchSkins(client, args);

        g_bSkinSearch[client] = false;
        return Plugin_Stop;
    }

    // Check if the client is selecting a pattern.
    if(g_iPatternSelect[client] != -1) {
        if(strlen(args) < 1 || strlen(args) > 4) {
            PrintToChat(client, "%s Your \x07Pattern\x01 must be between \x071\x01 and \x074\x01 characters.", PREFIX);
            return Plugin_Stop;
        }

        Item item = g_hPlayerItems[client][g_iPatternSelect[client]];
        if(item == null) {
            PrintToChat(client, "%s Failed to locate item.", PREFIX);
            return Plugin_Stop;
        }

        int patternIndex = StringToInt(args);

        char weapon[64];
        item.GetWeapon(weapon, sizeof(weapon));

        item.SetPattern(patternIndex);
        g_hPlayerItems[client][g_iPatternSelect[client]] = item;

        if(IsKnife(weapon)) {
            Knives_Refresh(client);
        } else {
            Skins_Refresh(client, weapon);
        }

        PrintToChat(client, "%s Set \x07Pattern\x01 on \x10%t\x01 to \x07%i\x01.", PREFIX, weapon, patternIndex);
        Loadout_ItemInfoMenu(client, item, g_iPatternSelect[client]);

        g_iPatternSelect[client] = -1;
        return Plugin_Stop;
    }

    // Check if the client is selecting a float.
    if(g_iFloatSelect[client] != -1) {
        if(strlen(args) < 1 || strlen(args) > 10) {
            PrintToChat(client, "%s Your \x07Float Value\x01 must be between \x071\x01 and \x0710\x01 characters.", PREFIX);
            return Plugin_Stop;
        }

        Item item = g_hPlayerItems[client][g_iFloatSelect[client]];
        if(item == null) {
            PrintToChat(client, "%s Failed to locate item.", PREFIX);
            return Plugin_Stop;
        }

        float floatValue = StringToFloat(args);
        if(floatValue < 0.0001) {
            floatValue = 0.0001;
        }

        char weapon[64];
        item.GetWeapon(weapon, sizeof(weapon));

        item.SetFloat(floatValue);
        g_hPlayerItems[client][g_iFloatSelect[client]] = item;

        if(IsKnife(weapon)) {
            Knives_Refresh(client);
        } else {
            Skins_Refresh(client, weapon);
        }

        PrintToChat(client, "%s Set \x07Float Value\x01 on \x10%t\x01 to \x07%f\x01.", PREFIX, weapon, floatValue);
        Loadout_ItemInfoMenu(client, item, g_iFloatSelect[client]);

        g_iFloatSelect[client] = -1;
        return Plugin_Stop;
    }

    // Check if the client is selecting a nametag.
    if(g_iNametagSelect[client] != -1) {
        if(strlen(args) < 1 || strlen(args) > 24) {
            PrintToChat(client, "%s Your \x07Nametag\x01 must be between \x071\x01 and \x0724\x01 characters.", PREFIX);
            return Plugin_Stop;
        }

        Item item = g_hPlayerItems[client][g_iNametagSelect[client]];
        if(item == null) {
            PrintToChat(client, "%s Failed to locate item.", PREFIX);
            return Plugin_Stop;
        }

        char weapon[64];
        item.GetWeapon(weapon, sizeof(weapon));

        if(StrEqual(args, "-1")) {
            item.SetNametag("");
            PrintToChat(client, "%s Removed \x07Nametag\x01 on \x10%t\x01.", PREFIX, weapon, args);
        } else {
            item.SetNametag(args);
            PrintToChat(client, "%s Set \x07Nametag\x01 on \x10%t\x01 to \x07%s\x01.", PREFIX, weapon, args);
        }

        g_hPlayerItems[client][g_iNametagSelect[client]] = item;

        if(IsKnife(weapon)) {
            Knives_Refresh(client);
        } else {
            Skins_Refresh(client, weapon);
        }

        Loadout_ItemInfoMenu(client, item, g_iNametagSelect[client]);

        g_iNametagSelect[client] = -1;
        return Plugin_Stop;
    }

    return Plugin_Continue;
}
