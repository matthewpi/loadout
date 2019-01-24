/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

public Action Command_Admins(int client, int args) {
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

        char name[32];
        user.GetUsername(name, sizeof(name));

        char groupName[32];
        group.GetName(groupName, sizeof(groupName));

        PrintToChat(client, "         - %i \x10%s \x0E%i\x01", PREFIX, user.GetID(), name, groupName);
    }
}

public Action Command_Groups(int client, int args) {
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

        PrintToChat(client, "%s %i \x10%s \x01\"\x07%s\x01\" \x0E%i\x01 | \x09%s", PREFIX, group.GetID(), name, tag, group.GetImmunity(), flags);
    }

    return Plugin_Handled;
}

public Action Command_Gloves(int client, int args) {
    Gloves_Menu(client);
    return Plugin_Handled;
}

public Action Command_Knife(int client, int args) {
    Knives_Menu(client);
    return Plugin_Handled;
}

public Action Command_Skins(int client, int args) {
    PrintToChat(client, "%s sm_skins", PREFIX);
    return Plugin_Handled;
}
