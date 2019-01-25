/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

public void LogCommand(const int client, const int target, const char[] command, const char[] extra, any...) {
	if(strlen(extra) > 0) {
		char buffer[512];
		VFormat(buffer, sizeof(buffer), extra, 5);

		LogAction(client, target, "%N executed command '%s' %s", client, command, buffer);
	} else {
		LogAction(client, target, "%N executed command '%s'", client, command);
	}
}

public bool IsClientValid(const int client) {
    if(client <= 0 || client > MaxClients || !IsClientConnected(client) || !IsClientInGame(client) || IsFakeClient(client)) {
        return false;
    }

    return true;
}
