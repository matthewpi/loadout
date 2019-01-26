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

public Action Command_Save(const int client, const int args) {
    char steamId[64];
    GetClientAuthId(client, AuthId_Steam2, steamId, sizeof(steamId));

    Backend_SetUserSkins(client, steamId);
    return Plugin_Handled;
}
