/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

#define GET_USER_GROUPS "SELECT user_groups.id, user_groups.name, user_groups.tag, user_groups.immunity, user_groups.flags FROM `user_groups`;"
#define GET_USER "SELECT users.id, users.username, users.steamId, users.group, UNIX_TIMESTAMP(users.createdAt) FROM `users` WHERE users.steamId='%s' LIMIT 1;"
#define INSERT_USER "INSERT INTO `users` (`username`, `steamId`) VALUES ('%s', '%s');"
#define GET_KNIVES "SELECT * FROM `cs_knives`;"
#define GET_GLOVES "SELECT * FROM `cs_gloves`;"
#define GET_GLOVE_SKINS "SELECT * FROM `cs_glove_skins`;"

Database g_hDatabase;

public void Backend_Connnection(Database database, const char[] error, any data) {
    if(database == null) {
        SetFailState("%s Failed to connect to server.  Error: %s", CONSOLE_PREFIX, error);
        return;
    }

    g_hDatabase = database;
    LogMessage("%s Connected to database.", CONSOLE_PREFIX);
    Backend_LoadGroups();
    Backend_LoadGloves();
    Backend_LoadKnives();

    for(int i = 1; i <= MaxClients; i++) {
        if(!IsClientValid(i)) {
            continue;
        }

        OnClientPutInServer(i);
        OnClientCookiesCached(i);

        char steamId[64];
        GetClientAuthId(i, AuthId_Steam2, steamId, sizeof(steamId));
        Backend_GetUser(i, steamId);
    }

    CreateTimer(15.0, Timer_TagAll, _, TIMER_REPEAT);
}

public void Backend_LoadGroups() {
    g_hDatabase.Query(Callback_LoadGroups, GET_USER_GROUPS);
}

void Callback_LoadGroups(Database database, DBResultSet results, const char[] error, any data) {
    if(results == null) {
        LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_LoadGroups", (strlen(error) > 0 ? error : "Unknown."));
        return;
    }

    int idIndex;
    int nameIndex;
    int tagIndex;
    int immunityIndex;
    int flagsIndex;
    if(!results.FieldNameToNum("id", idIndex)) { LogError("%s Failed to locate \"id\" field in table \"user_groups\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("name", nameIndex)) { LogError("%s Failed to locate \"name\" field in table \"user_groups\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("tag", tagIndex)) { LogError("%s Failed to locate \"tag\" field in table \"user_groups\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("immunity", immunityIndex)) { LogError("%s Failed to locate \"immunity\" field in table \"user_groups\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("flags", flagsIndex)) { LogError("%s Failed to locate \"flags\" field in table \"user_groups\".", CONSOLE_PREFIX); return; }

    while(results.FetchRow()) {
        int id = results.FetchInt(idIndex);
        char name[32];
        char tag[16];
        int immunity = results.FetchInt(immunityIndex);
        char flags[26];

        results.FetchString(nameIndex, name, sizeof(name));
        results.FetchString(tagIndex, tag, sizeof(tag));
        results.FetchString(flagsIndex, flags, sizeof(flags));

        Group group = new Group();
        group.SetID(id);
        group.SetName(name);
        group.SetTag(tag);
        group.SetImmunity(immunity);
        group.SetFlags(flags);

        g_hGroups[id] = group;
    }
}

public void Backend_GetUser(int client, const char[] steamId) {
    char query[512];
    Format(query, sizeof(query), GET_USER, steamId);
    g_hDatabase.Query(Callback_GetUser, query, client);
}

void Callback_GetUser(Database database, DBResultSet results, const char[] error, int client) {
    if(results == null) {
        LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_GetUser", (strlen(error) > 0 ? error : "Unknown."));
        return;
    }

    int idIndex;
    int usernameIndex;
    int steamIdIndex;
    int groupIndex;
    int createdAtIndex;
    if(!results.FieldNameToNum("id", idIndex)) { LogError("%s Failed to locate \"id\" field in table \"users\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("username", usernameIndex)) { LogError("%s Failed to locate \"username\" field in table \"users\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("steamId", steamIdIndex)) { LogError("%s Failed to locate \"steamId\" field in table \"users\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("group", groupIndex)) { LogError("%s Failed to locate \"group\" field in table \"users\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("UNIX_TIMESTAMP(users.createdAt)", createdAtIndex)) { LogError("%s Failed to locate \"createdAt\" field in table \"users\".", CONSOLE_PREFIX); return; }

    while(results.FetchRow()) {
        int id = results.FetchInt(idIndex);
        char username[32];
        char steamId[64];
        int group = results.FetchInt(groupIndex);
        int createdAt = results.FetchInt(createdAtIndex);

        results.FetchString(usernameIndex, username, sizeof(username));
        results.FetchString(steamIdIndex, steamId, sizeof(steamId));

        User user = new User();
        user.SetID(id);
        user.SetUsername(username);
        user.SetSteamID(steamId);
        user.SetGroup(group);
        user.SetCreatedAt(createdAt);

        g_hUsers[client] = user;
        SetTagDelayed(client);
    }
    // TODO: Create user if they don't exist?
}

public void Backend_CreateUser(int client, const char[] name, const char[] steamId) {
    char query[512];
    Format(query, sizeof(query), INSERT_USER, name, steamId);
    g_hDatabase.Query(Callback_GetUser, query, client);
}

public void Backend_LoadKnives() {
    g_hDatabase.Query(Callback_LoadKnives, GET_KNIVES);
}

void Callback_LoadKnives(Database database, DBResultSet results, const char[] error, any data) {
    if(results == null) {
        LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_LoadGroups", (strlen(error) > 0 ? error : "Unknown."));
        return;
    }

    int idIndex;
    int nameIndex;
    int itemIdIndex;
    if(!results.FieldNameToNum("id", idIndex)) { LogError("%s Failed to locate \"id\" field in table \"cs_knives\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("displayName", nameIndex)) { LogError("%s Failed to locate \"displayName\" field in table \"cs_knives\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("itemId", itemIdIndex)) { LogError("%s Failed to locate \"itemId\" field in table \"cs_knives\".", CONSOLE_PREFIX); return; }

    while(results.FetchRow()) {
        int id = results.FetchInt(idIndex);
        char name[64];
        int itemId = results.FetchInt(itemIdIndex);

        results.FetchString(nameIndex, name, sizeof(name));

        Knife knife = new Knife();
        knife.SetID(id);
        knife.SetName(name);
        knife.SetItemID(itemId);

        g_hKnives[id] = knife;
    }
}

public void Backend_LoadGloves() {
    g_hDatabase.Query(Callback_LoadGloves, GET_GLOVES);
}

void Callback_LoadGloves(Database database, DBResultSet results, const char[] error, any data) {
    if(results == null) {
        LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_LoadGloves", (strlen(error) > 0 ? error : "Unknown."));
        return;
    }

    int idIndex;
    int nameIndex;
    int itemIdIndex;
    if(!results.FieldNameToNum("id", idIndex)) { LogError("%s Failed to locate \"id\" field in table \"cs_gloves\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("displayName", nameIndex)) { LogError("%s Failed to locate \"displayName\" field in table \"cs_gloves\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("itemId", itemIdIndex)) { LogError("%s Failed to locate \"itemId\" field in table \"cs_gloves\".", CONSOLE_PREFIX); return; }

    while(results.FetchRow()) {
        int id = results.FetchInt(idIndex);
        char name[64];
        int itemId = results.FetchInt(itemIdIndex);

        results.FetchString(nameIndex, name, sizeof(name));

        Glove glove = new Glove();
        glove.SetID(id);
        glove.SetName(name);
        glove.SetItemID(itemId);

        g_hGloves[id] = glove;
    }

    g_hDatabase.Query(Callback_LoadGloveSkins, GET_GLOVE_SKINS);
}

void Callback_LoadGloveSkins(Database database, DBResultSet results, const char[] error, any data) {
    if(results == null) {
        LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_LoadGloveSkins", (strlen(error) > 0 ? error : "Unknown."));
        return;
    }

    int idIndex;
    int nameIndex;
    int gloveIdIndex;
    int paintIdIndex;
    if(!results.FieldNameToNum("id", idIndex)) { LogError("%s Failed to locate \"id\" field in table \"cs_glove_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("displayName", nameIndex)) { LogError("%s Failed to locate \"displayName\" field in table \"cs_glove_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("gloveId", gloveIdIndex)) { LogError("%s Failed to locate \"gloveId\" field in table \"cs_glove_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("paintId", paintIdIndex)) { LogError("%s Failed to locate \"paintId\" field in table \"cs_glove_skins\".", CONSOLE_PREFIX); return; }

    GloveSkin skins[GLOVE_SKIN_MAX];
    while(results.FetchRow()) {
        int id = results.FetchInt(idIndex);
        char name[64];
        int gloveId = results.FetchInt(gloveIdIndex);
        int paintId = results.FetchInt(paintIdIndex);

        results.FetchString(nameIndex, name, sizeof(name));

        GloveSkin skin = new GloveSkin();
        skin.SetID(id);
        skin.SetName(name);
        skin.SetGloveID(gloveId);
        skin.SetPaintID(paintId);

        skins[id] = skin;
    }

    int gloveSkins[GLOVE_MAX];
    for(int i = 1; i < sizeof(g_hGloves); i++) {
        Glove glove = g_hGloves[i];

        if(glove == null) {
            continue;
        }

        gloveSkins[glove.GetID()] = 1;
    }

    for(int i = 1; i < sizeof(skins); i++) {
        GloveSkin skin = skins[i];
        if(skin == null) {
            continue;
        }

        Glove glove = g_hGloves[skin.GetGloveID()];
        if(glove == null) {
            continue;
        }

        glove.AddSkin(gloveSkins[glove.GetID()], skin);
        gloveSkins[glove.GetID()]++;
    }
}

public void Backend_SearchSkins(int client, const char[] skinQuery) {
    int skinQueryLen = strlen(skinQuery) * 2 + 1;
    char[] escapedSkinQuery = new char[skinQueryLen];

    g_hDatabase.Escape(skinQuery, escapedSkinQuery, skinQueryLen);

    char query[512];
    Format(query, sizeof(query), "SELECT * FROM `cs_skins` WHERE cs_skins.displayName LIKE \"%s%%\";", escapedSkinQuery);

    g_hDatabase.Query(Callback_SearchSkins, query, client);
}

void Callback_SearchSkins(Database database, DBResultSet results, const char[] error, int client) {
    if(results == null) {
        LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_SearchSkins", (strlen(error) > 0 ? error : "Unknown."));
        return;
    }

    if(!IsClientValid(client)) {
        return;
    }

    int nameIndex;
    int skinIdIndex;
    if(!results.FieldNameToNum("displayName", nameIndex)) { LogError("%s Failed to locate \"displayName\" field in table \"cs_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("skinId", skinIdIndex)) { LogError("%s Failed to locate \"skinId\" field in table \"cs_skins\".", CONSOLE_PREFIX); return; }

    Menu menu = CreateMenu(Callback_SkinsSkinMenu);
    menu.SetTitle("Filtered Skins");

    while(results.FetchRow()) {
        char name[64];
        int skinId = results.FetchInt(skinIdIndex);

        results.FetchString(nameIndex, name, sizeof(name));

        char itemId[8];
        IntToString(skinId, itemId, sizeof(itemId));

        menu.AddItem(itemId, name);
    }

    if(!IsClientValid(client)) {
        return;
    }

    menu.ExitBackButton = true;
    menu.Display(client, 0);
    g_hSkinMenus[client] = menu;
}
