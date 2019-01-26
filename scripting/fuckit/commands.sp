/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

public Action Command_Gloves(const int client, const int args) {
	Gloves_Menu(client);
	return Plugin_Handled;
}

public Action Command_Knife(const int client, const int args) {
	Knives_Menu(client);
	return Plugin_Handled;
}

public Action Command_Skins(const int client, const int args) {
	Skins_Menu(client);
	return Plugin_Handled;
}
