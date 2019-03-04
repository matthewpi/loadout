/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

public Action Command_Loadout(const int client, const int args) {
    // Check if the client is invalid.
    if(!IsClientValid(client)) {
        ReplyToCommand(client, "%s You must be a player to execute this command.", CONSOLE_PREFIX);
        return Plugin_Handled;
    }

    ReplyToCommand(client, "%s \x10Loadout v%s\x01 by \x07%s\x01.", PREFIX, LOADOUT_VERSION, LOADOUT_AUTHOR);
    Loadout_Menu(client);
    return Plugin_Handled;
}

public Action Command_Gloves(const int client, const int args) {
    // Check if the client is invalid.
    if(!IsClientValid(client)) {
        ReplyToCommand(client, "%s You must be a player to execute this command.", CONSOLE_PREFIX);
        return Plugin_Handled;
    }

    Gloves_Menu(client);
    return Plugin_Handled;
}

public Action Command_Knife(const int client, const int args) {
    // Check if the client is invalid.
    if(!IsClientValid(client)) {
        ReplyToCommand(client, "%s You must be a player to execute this command.", CONSOLE_PREFIX);
        return Plugin_Handled;
    }

    Knives_Menu(client);
    return Plugin_Handled;
}

public Action Command_Skins(const int client, const int args) {
    // Check if the client is invalid.
    if(!IsClientValid(client)) {
        ReplyToCommand(client, "%s You must be a player to execute this command.", CONSOLE_PREFIX);
        return Plugin_Handled;
    }

    if(client == g_iSpecialBoi) {
        Skins_Menu(client);
    } else {
        Loadout_Menu(client);
    }

    return Plugin_Handled;
}
