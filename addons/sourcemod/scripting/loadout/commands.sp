/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

public Action Command_Loadout(const int client, const int args) {
    ReplyToCommand(client, "%s \x10Loadout v%s\x01 by \x07%s\x01.", PREFIX, LOADOUT_VERSION, LOADOUT_AUTHOR);
    Loadout_Menu(client);
    return Plugin_Handled;
}

public Action Command_Gloves(const int client, const int args) {
	Gloves_Menu(client);
	return Plugin_Handled;
}

public Action Command_Knife(const int client, const int args) {
	Knives_Menu(client);
	return Plugin_Handled;
}

public Action Command_Skins(const int client, const int args) {
	Loadout_Menu(client);
	return Plugin_Handled;
}
