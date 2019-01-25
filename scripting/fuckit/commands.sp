/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

public Action Command_Admins(const int client, const int args) {
	PrintToChat(client, "%s Admin List", PREFIX);

	for(int i = 1; i < sizeof(g_hUsers); i++) {
		User user = g_hUsers[i];

		if(user == null || user.GetGroup() == 0) {
			continue;
		}

		Group group = g_hGroups[user.GetGroup()];
		if(group == null) {
			continue;
		}

		char groupName[32];
		group.GetName(groupName, sizeof(groupName));

		PrintToChat(client, "%s \"\x07%N\x01\" \x10%s\x01", PREFIX, client, groupName);
	}
}

public Action Command_Groups(const int client, const int args) {
	PrintToChat(client, "%s Group List", PREFIX);

	for(int i = 1; i < sizeof(g_hGroups); i++) {
		Group group = g_hGroups[i];

		if(group == null) {
			continue;
		}

		char name[32];
		group.GetName(name, sizeof(name));
		char tag[16];
		group.GetTag(tag, sizeof(tag));
		char flags[26];
		group.GetFlags(flags, sizeof(flags));

		PrintToChat(client, "%s %i \x10%s \x01\"\x07%s\x01\" \x0E%i\x01 | \x09%s\x01", PREFIX, group.GetID(), name, tag, group.GetImmunity(), flags);
	}

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
	Skins_Menu(client);
	return Plugin_Handled;
}

public Action Command_Respawn(const int client, const int args) {
	char command[64] = "sm_respawn";
	if(!IsClientValid(client)) {
		ReplyToCommand(client, "%s You must be a client to execute this command.", CONSOLE_PREFIX);
		return Plugin_Handled;
	}

	if(args != 1) {
		PrintToChat(client, "%s \x07Usage: \x01%s <#userid;target>", PREFIX, command);
		LogCommand(client, -1, command, "");
		return Plugin_Handled;
	}

	char potentialTarget[64];
	GetCmdArg(1, potentialTarget, sizeof(potentialTarget));

	char targetName[MAX_TARGET_LENGTH];
	int targets[MAXPLAYERS];
	bool tnIsMl;

	int targetCount = ProcessTargetString(potentialTarget, client, targets, MAXPLAYERS, COMMAND_FILTER_CONNECTED, targetName, sizeof(targetName), tnIsMl);

	if(targetCount <= 0) {
		ReplyToTargetError(client, targetCount);
		LogCommand(client, -1, command, "");
		return Plugin_Handled;
	}

	for(int target = 1; target < sizeof(targets); target++) {
		if(!IsClientValid(target) || IsPlayerAlive(target) || GetClientTeam(target) == CS_TEAM_SPECTATOR) {
			continue;
		}

		CS_RespawnPlayer(target);
	}
	return Plugin_Handled;
}

public Action Command_Team_T(const int client, const int args) {
	return TeamCommand(client, args, "sm_team_t", CS_TEAM_T, "Terrorist");
}

public Action Command_Team_CT(const int client, const int args) {
	return TeamCommand(client, args, "sm_team_ct", CS_TEAM_CT, "Counter Terrorist");
}

public Action Command_Team_Spec(const int client, const int args) {
	return TeamCommand(client, args, "sm_team_spec", CS_TEAM_SPECTATOR, "Spectator");
}

Action TeamCommand(const int client, const int args, const char[] command, const int commandTeam, const char[] commandTeamName) {
	if(!IsClientValid(client)) {
		ReplyToCommand(client, "%s You must be a client to execute this command.", CONSOLE_PREFIX);
		return Plugin_Handled;
	}

	if(args != 1 && args != 2) {
		PrintToChat(client, "%s \x07Usage: \x01%s <#userid;target> [true (on round end)]", PREFIX, command);
		LogCommand(client, -1, command, "");
		return Plugin_Handled;
	}

	char target[64];
	GetCmdArg(1, target, sizeof(target));

	char targetName[MAX_TARGET_LENGTH];
	int targets[MAXPLAYERS];
	bool tnIsMl;

	int targetCount = ProcessTargetString(target, client, targets, MAXPLAYERS, COMMAND_FILTER_CONNECTED, targetName, sizeof(targetName), tnIsMl);

	if(targetCount <= 0) {
		ReplyToTargetError(client, targetCount);
		LogCommand(client, -1, command, "");
		return Plugin_Handled;
	}

	if(targetCount > 2) {
		PrintToChat(client, "%s \x07Too many clients were found.", PREFIX);
		LogCommand(client, -1, command, "");
		return Plugin_Handled;
	}

	bool swapOnRoundEnd = false;

	if(args == 2) {
		char canSwap[512];
		GetCmdArg(2, canSwap, sizeof(canSwap));

		if(StrEqual(canSwap, "true", false)) {
			swapOnRoundEnd = true;
		}
	}

	int targetId = targets[0];

	if(GetClientTeam(targetId) != commandTeam) {
		if(swapOnRoundEnd) {
			g_iSwapOnRoundEnd[targetId] = commandTeam;
			PrintToChat(client, "%s \x05%s \x01will be swapped to the \x07%s \x01team on round end.", PREFIX, targetName, commandTeamName);
		} else {
			ChangeClientTeam(targetId, commandTeam);
			PrintToChat(client, "%s \x05%s \x01has been swapped to the \x07%s \x01team", PREFIX, targetName, commandTeamName);
		}
	} else {
		PrintToChat(client, "%s \x05%s \x01is already on the \x07%s \x01team", PREFIX, targetName, commandTeamName);
	}

	LogCommand(client, targetId, command, "(Target: '%s')", targetName);
	return Plugin_Handled;
}
