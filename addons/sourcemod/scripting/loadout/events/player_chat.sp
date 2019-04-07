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

    if(g_iLoadoutAction[client] == LOADOUT_ACTION_NONE) {
        return Plugin_Continue;
    }

    if(StrEqual(args, "!abort")) {
        PrintToChat(client, "%s Aborted.", PREFIX);
        g_iLoadoutAction[client] = LOADOUT_ACTION_NONE;
        return Plugin_Stop;
    }

    if(g_iLoadoutAction[client] == LOADOUT_ACTION_SEARCH) {
        if(strlen(args) < 1 || strlen(args) > 24) {
            PrintToChat(client, "%s Your \x10Search\x01 must be between \x071\x01 and \x0724\x01 characters.", PREFIX);
            return Plugin_Stop;
        }

        // Search the database for the skin.
        Backend_SearchSkins(client, args);
    } else if(g_iLoadoutAction[client] == LOADOUT_ACTION_PATTERN) {
        if(strlen(args) < 1 || strlen(args) > 4) {
            PrintToChat(client, "%s Your \x07Pattern\x01 must be between \x071\x01 and \x074\x01 characters.", PREFIX);
            return Plugin_Stop;
        }

        // Convert the arguments to an integer.
        int patternIndex = StringToInt(args);

        // Check if the pattern is below 0.
        if(patternIndex < 0) {
            PrintToChat(client, "%s Your \x07Pattern\x01 must be a positive integer.", PREFIX);
            return Plugin_Stop;
        }

        // Get the user's item.
        Item item = null;
        if(!g_smPlayerItems[client].GetValue(g_cLoadoutWeapon[client], item)) {
            PrintToChat(client, "%s Failed to locate item.", PREFIX);
            g_iLoadoutAction[client] = LOADOUT_ACTION_NONE;
            return Plugin_Stop;
        }

        // Update the item's pattern.
        item.SetPattern(patternIndex);

        // Refresh the client's item.
        Skins_Refresh(client, g_cLoadoutWeapon[client]);

        // Send a message to the client.
        PrintToChat(client, "%s Set \x07Pattern\x01 on \x10%t\x01 to \x07%i\x01.", PREFIX, g_cLoadoutWeapon[client], patternIndex);

        // Reopen the menu.
        // TODO: Open the menu.
    } else if(g_iLoadoutAction[client] == LOADOUT_ACTION_FLOAT) {
        if(strlen(args) < 1 || strlen(args) > 10) {
            PrintToChat(client, "%s Your \x07Float Value\x01 must be between \x071\x01 and \x0710\x01 characters.", PREFIX);
            return Plugin_Stop;
        }

        // Convert the arguments to a float value.
        float floatValue = StringToFloat(args);
        if(floatValue < 0.0001) {
            floatValue = 0.0001;
        }

        // Get the user's item.
        Item item = null;
        if(!g_smPlayerItems[client].GetValue(g_cLoadoutWeapon[client], item)) {
            PrintToChat(client, "%s Failed to locate item.", PREFIX);
            g_iLoadoutAction[client] = LOADOUT_ACTION_NONE;
            return Plugin_Stop;
        }

        // Update the item's pattern.
        item.SetFloat(floatValue);

        // Refresh the client's item.
        Skins_Refresh(client, g_cLoadoutWeapon[client]);

        // Send a message to the client.
        PrintToChat(client, "%s Set \x07Float Value\x01 on \x10%t\x01 to \x07%f\x01.", PREFIX, g_cLoadoutWeapon[client], floatValue);

        // Reopen the menu.
        // TODO: Open the menu.
    } else if(g_iLoadoutAction[client] == LOADOUT_ACTION_STATTRAK) {

    } else if(g_iLoadoutAction[client] == LOADOUT_ACTION_NAMETAG) {
        if(strlen(args) < 1 || strlen(args) > 24) {
            PrintToChat(client, "%s Your \x07Nametag\x01 must be between \x071\x01 and \x0724\x01 characters.", PREFIX);
            return Plugin_Stop;
        }

        // Get the user's item.
        Item item = null;
        if(!g_smPlayerItems[client].GetValue(g_cLoadoutWeapon[client], item)) {
            PrintToChat(client, "%s Failed to locate item.", PREFIX);
            g_iLoadoutAction[client] = LOADOUT_ACTION_NONE;
            return Plugin_Stop;
        }

        // Check if the input is "-1".
        if(StrEqual(args, "-1")) {
            item.SetNametag("");
            PrintToChat(client, "%s Removed \x07Nametag\x01 on \x10%t\x01.", PREFIX, g_cLoadoutWeapon[client], args);
        } else {
            item.SetNametag(args);
            PrintToChat(client, "%s Set \x07Nametag\x01 on \x10%t\x01 to \x07%s\x01.", PREFIX, g_cLoadoutWeapon[client], args);
        }

        // Refresh the client's item.
        Skins_Refresh(client, g_cLoadoutWeapon[client]);

        // Reopen the menu.
        // TODO: Open the menu.
    }

    g_iLoadoutAction[client] = LOADOUT_ACTION_NONE;
    return Plugin_Stop;
}
