/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

#define TABLE_GLOVES "\
CREATE TABLE IF NOT EXISTS `loadout_gloves` (\
    `id`          INT(11)     AUTO_INCREMENT PRIMARY KEY,\
    `displayName` VARCHAR(64)                   NOT NULL,\
    `itemId`      INT(11)                       NOT NULL,\
    CONSTRAINT `loadout_gloves_id_uindex`          UNIQUE (`id`),\
    CONSTRAINT `loadout_gloves_displayName_uindex` UNIQUE (`displayName`),\
    CONSTRAINT `loadout_gloves_itemId_uindex`      UNIQUE (`itemId`)\
);"
#define TABLE_GLOVE_SKINS "\
CREATE TABLE IF NOT EXISTS `loadout_glove_skins` (\
    `id`          INT(11)     AUTO_INCREMENT PRIMARY KEY,\
    `displayName` VARCHAR(64)                   NOT NULL,\
    `gloveId`     INT(11)                       NOT NULL,\
    `paintId`     INT(11)                       NOT NULL,\
    CONSTRAINT `loadout_glove_skins_id_uindex` UNIQUE (`id`),\
    CONSTRAINT `loadout_glove_skins_loadout_gloves_id_fk` FOREIGN KEY (`gloveId`) REFERENCES `loadout_gloves` (`id`) ON UPDATE CASCADE\
);"
#define TABLE_KNIVES "\
CREATE TABLE IF NOT EXISTS `loadout_knives` (\
    `id`          INT(11)     AUTO_INCREMENT PRIMARY KEY,\
    `displayName` VARCHAR(64)                   NOT NULL,\
    `itemName`    VARCHAR(64)                   NOT NULL,\
    `itemId`      INT(11)                       NOT NULL,\
    CONSTRAINT `loadout_knives_id_uindex`          UNIQUE (`id`),\
    CONSTRAINT `loadout_knives_displayName_uindex` UNIQUE (`displayName`),\
    CONSTRAINT `loadout_knives_itemName_uindex`    UNIQUE (`itemName`),\
    CONSTRAINT `loadout_knives_itemId_uindex`      UNIQUE (`itemId`)\
);"
#define TABLE_SKINS "\
CREATE TABLE IF NOT EXISTS `loadout_skins` (\
    `id`          INT(11)     AUTO_INCREMENT PRIMARY KEY,\
    `displayName` VARCHAR(64)                   NOT NULL,\
    `skinId`      INT(11)                       NOT NULL,\
    `weapons`     TEXT                          NOT NULL,\
    CONSTRAINT `loadout_skins_id_uindex` UNIQUE (`id`)\
);"
#define TABLE_USER_SKINS "\
CREATE TABLE IF NOT EXISTS `loadout_user_skins` (\
    `steamId`     VARCHAR(64)                NOT NULL,\
    `weapon`      VARCHAR(64)                NOT NULL,\
    `skinId`      VARCHAR(16)                NOT NULL,\
    `skinPattern` INT(11)       DEFAULT 0    NOT NULL,\
    `skinFloat`   DECIMAL(9, 8) DEFAULT 0.01 NOT NULL,\
    `statTrak`    INT(11)       DEFAULT 0    NOT NULL,\
    CONSTRAINT `loadout_user_skins_steamId_weapon_uindex` UNIQUE (`steamId`, `weapon`)\
);"

#define GET_GLOVES "SELECT * FROM `loadout_gloves` ORDER BY `displayName`;"
#define GET_GLOVE_SKINS "SELECT * FROM `loadout_glove_skins`;"
#define GET_KNIVES "SELECT * FROM `loadout_knives` ORDER BY `displayName`;"
#define SEARCH_WEAPON_SKINS "SELECT * FROM `loadout_skins` WHERE `displayName` LIKE \"%s%%\" ORDER BY `displayName`;"
#define GET_USER_SKINS "SELECT `weapon`, `skinId`, `skinPattern`, `skinFloat`, `statTrak` FROM `loadout_user_skins` WHERE `steamId`='%s';"
#define SET_USER_SKIN "\
INSERT INTO `loadout_user_skins` (`steamId`, `weapon`, `skinId`, `skinPattern`, `skinFloat`, `statTrak`) VALUES ('%s', '%s', '%s', '%i', '%f', '%i')\
ON DUPLICATE KEY UPDATE `skinId`='%s', `skinPattern`='%i', `skinFloat`='%f', `statTrak`='%i';"

Database g_hDatabase;

public void Backend_Connnection(Database database, const char[] error, any data) {
    if(database == null) {
        SetFailState("%s Failed to connect to server.  Error: %s", CONSOLE_PREFIX, error);
        return;
    }

    g_hDatabase = database;
    LogMessage("%s Connected to database.", CONSOLE_PREFIX);

    g_hDatabase.Query(Callback_TableCreate, TABLE_GLOVES);
    g_hDatabase.Query(Callback_TableCreate, TABLE_GLOVE_SKINS);
    g_hDatabase.Query(Callback_TableCreate, TABLE_KNIVES);
    g_hDatabase.Query(Callback_TableCreate, TABLE_SKINS);
    g_hDatabase.Query(Callback_TableCreate, TABLE_USER_SKINS);

    Backend_LoadGloves();
    Backend_LoadKnives();

    for(int i = 1; i <= MaxClients; i++) {
        if(!IsClientValid(i)) {
            continue;
        }

        OnClientConnected(i);
        OnClientPutInServer(i);

        char steamId[64];
        GetClientAuthId(i, AuthId_Steam2, steamId, sizeof(steamId));
        Backend_GetUserSkins(i, steamId);
    }
}

void Callback_TableCreate(Database database, DBResultSet results, const char[] error, any data) {
    if(results == null) {
        LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_TableCreate", (strlen(error) > 0 ? error : "Unknown."));
        return;
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
    if(!results.FieldNameToNum("id", idIndex)) { LogError("%s Failed to locate \"id\" field in table \"loadout_gloves\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("displayName", nameIndex)) { LogError("%s Failed to locate \"displayName\" field in table \"loadout_gloves\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("itemId", itemIdIndex)) { LogError("%s Failed to locate \"itemId\" field in table \"loadout_gloves\".", CONSOLE_PREFIX); return; }

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
    if(!results.FieldNameToNum("id", idIndex)) { LogError("%s Failed to locate \"id\" field in table \"loadout_glove_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("displayName", nameIndex)) { LogError("%s Failed to locate \"displayName\" field in table \"loadout_glove_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("gloveId", gloveIdIndex)) { LogError("%s Failed to locate \"gloveId\" field in table \"loadout_glove_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("paintId", paintIdIndex)) { LogError("%s Failed to locate \"paintId\" field in table \"loadout_glove_skins\".", CONSOLE_PREFIX); return; }

    GloveSkin skins[GLOVE_SKIN_MAX + 1];
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

    int gloveSkins[GLOVE_MAX + 1];
    for(int i = 0; i < sizeof(g_hGloves); i++) {
        Glove glove = g_hGloves[i];
        if(glove == null) {
            continue;
        }

        gloveSkins[glove.GetID()] = 1;
    }

    for(int i = 0; i < sizeof(skins); i++) {
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
    int itemNameIndex;
    int itemIdIndex;
    if(!results.FieldNameToNum("id", idIndex)) { LogError("%s Failed to locate \"id\" field in table \"loadout_knives\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("displayName", nameIndex)) { LogError("%s Failed to locate \"displayName\" field in table \"loadout_knives\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("itemName", itemNameIndex)) { LogError("%s Failed to locate \"itemName\" field in table \"loadout_knives\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("itemId", itemIdIndex)) { LogError("%s Failed to locate \"itemId\" field in table \"loadout_knives\".", CONSOLE_PREFIX); return; }

    while(results.FetchRow()) {
        int id = results.FetchInt(idIndex);
        char name[64];
        char itemName[64];
        int itemId = results.FetchInt(itemIdIndex);

        results.FetchString(nameIndex, name, sizeof(name));
        results.FetchString(itemNameIndex, itemName, sizeof(itemName));

        Knife knife = new Knife();
        knife.SetID(id);
        knife.SetName(name);
        knife.SetItemName(itemName);
        knife.SetItemID(itemId);

        g_hKnives[id] = knife;
    }
}

public void Backend_GetUserSkins(int client, const char[] steamId) {
    char query[512];
    Format(query, sizeof(query), GET_USER_SKINS, steamId);
    g_hDatabase.Query(Callback_GetUserSkins, query, client);
}

void Callback_GetUserSkins(Database database, DBResultSet results, const char[] error, int client) {
    if(results == null) {
        LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_GetUserSkins", (strlen(error) > 0 ? error : "Unknown."));
        return;
    }

    int weaponIndex;
    int skinIdIndex;
    int patternIndex;
    int floatIndex;
    int statTrakIndex;
    if(!results.FieldNameToNum("weapon", weaponIndex)) { LogError("%s Failed to locate \"weapon\" field in table \"loadout_user_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("skinId", skinIdIndex)) { LogError("%s Failed to locate \"skinId\" field in table \"loadout_user_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("skinPattern", patternIndex)) { LogError("%s Failed to locate \"skinPattern\" field in table \"loadout_user_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("skinFloat", floatIndex)) { LogError("%s Failed to locate \"skinFloat\" field in table \"loadout_user_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("statTrak", statTrakIndex)) { LogError("%s Failed to locate \"statTrak\" field in table \"loadout_user_skins\".", CONSOLE_PREFIX); return; }

    int i = 0;
    while(results.FetchRow()) {
        char weapon[64];
        char skinId[16];
        int pattern = results.FetchInt(patternIndex);
        float floatValue = results.FetchFloat(floatIndex);
        int statTrak = results.FetchInt(statTrakIndex);

        results.FetchString(weaponIndex, weapon, sizeof(weapon));
        results.FetchString(skinIdIndex, skinId, sizeof(skinId));

        // Handles knife type (not skin)
        if(StrEqual(weapon, "plugin_knife", true)) {
            g_iKnives[client] = StringToInt(skinId);
        }

        // Handles gloves
        if(StrEqual(weapon, "plugin_gloves", true)) {
            char gloveSections[2][8];
            ExplodeString(skinId, ";", gloveSections, 2, 8, true);

            g_iGloves[client] = StringToInt(gloveSections[0]);
            g_iGloveSkins[client] = StringToInt(gloveSections[1]);
        }

        Item item = new Item();
        item.SetWeapon(weapon);
        item.SetSkinID(skinId);
        item.SetPattern(pattern);
        item.SetFloat(floatValue);
        item.SetStatTrak(statTrak);

        // Handles all actual skins
        g_hPlayerItems[client][i] = item;
        i++;
    }
}

public void Backend_SearchSkins(int client, const char[] skinQuery) {
    int skinQueryLen = strlen(skinQuery) * 2 + 1;
    char[] escapedSkinQuery = new char[skinQueryLen];

    g_hDatabase.Escape(skinQuery, escapedSkinQuery, skinQueryLen);

    char query[512];
    Format(query, sizeof(query), SEARCH_WEAPON_SKINS, escapedSkinQuery);

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

    if(results.RowCount == 0) {
        PrintToChat(client, "%s No results found.", PREFIX);
    }

    int nameIndex;
    int skinIdIndex;
    if(!results.FieldNameToNum("displayName", nameIndex)) { LogError("%s Failed to locate \"displayName\" field in table \"loadout_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("skinId", skinIdIndex)) { LogError("%s Failed to locate \"skinId\" field in table \"loadout_skins\".", CONSOLE_PREFIX); return; }

    if(results.RowCount == 1) {
        results.FetchRow();

        char name[64];
        int skinId = results.FetchInt(skinIdIndex);

        results.FetchString(nameIndex, name, sizeof(name));

        int i;
        Item item;
        char weapon[64];
        int validItems = 0;
        for(i = 0; i < USER_ITEM_MAX; i++) {
            item = g_hPlayerItems[client][i];
            if(item == null) {
                continue;
            }

            item.GetWeapon(weapon, sizeof(weapon));
            validItems++;

            if(StrEqual(weapon, g_cSkinWeapon[client])) {
                break;
            }
        }

        if(item == null) {
            item = new Item();
            item.SetWeapon(g_cSkinWeapon[client]);
            item.SetPattern(0);
            item.SetFloat(0.01);
            item.SetStatTrak(0);
            i = validItems + 1;
        }

        char skinIdChar[16];
        IntToString(skinId, skinIdChar, sizeof(skinIdChar));
        item.SetSkinID(skinIdChar);
        g_hPlayerItems[client][i] = item;

        Skins_Refresh(client, g_cSkinWeapon[client]);
        PrintToChat(client, "%s Applying \x10%s\x01 to \x07%t\x01.", PREFIX, name, g_cSkinWeapon[client]);
        return;
    }

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

public void Backend_SaveAllData() {
    Transaction transaction;

    for(int i = 1; i <= MaxClients; i++) {
        if(!IsClientValid(i)) {
            continue;
        }

        transaction = SQL_CreateTransaction();

        char steamId[64];
        GetClientAuthId(i, AuthId_Steam2, steamId, sizeof(steamId));
        Backend_GetUserDataTransaction(transaction, i, steamId);
        SQL_ExecuteTransaction(g_hDatabase, transaction, Callback_SuccessUserData, Callback_ErrorUserData);
    }
}

public void Backend_SaveUserData(int client, const char[] steamId) {
    Transaction transaction = SQL_CreateTransaction();
    Backend_GetUserDataTransaction(transaction, client, steamId);
    SQL_ExecuteTransaction(g_hDatabase, transaction, Callback_SuccessUserData, Callback_ErrorUserData);
}

void Callback_SuccessUserData(Database database, any data, int numQueries, Handle[] results, any[] queryData) {
    // For safe keeping :^)
}

void Callback_ErrorUserData(Database database, any data, int numQueries, const char[] error, int failIndex, any[] queryData) {
    LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_ErrorUserData", (strlen(error) > 0 ? error : "Unknown."));
}

Transaction Backend_GetUserDataTransaction(Transaction transaction, int client, const char[] steamId) {
    char query[512];

    // Handles knife (actual knife, not skin)
    char knife[16];
    if(g_iKnives[client]) {
        IntToString(g_iKnives[client], knife, sizeof(knife));
        Format(query, sizeof(query), SET_USER_SKIN, steamId, "plugin_knife", knife, 0, 0.01, 0, knife, 0, 0.01, 0);
        transaction.AddQuery(query);
    }

    // Handles gloves (glove type and skin)
    char gloves[16];
    if(g_iGloves[client] && g_iGloveSkins[client]) {
        Format(gloves, sizeof(gloves), "%i;%i", g_iGloves[client], g_iGloveSkins[client]);
        Format(query, sizeof(query), SET_USER_SKIN, steamId, "plugin_gloves", gloves, 0, 0.01, 0, gloves, 0, 0.01, 0);
        transaction.AddQuery(query);
    }

    // Handle weapon and knife skins
    for(int i = 0; i < USER_ITEM_MAX; i++) {
        Item item = g_hPlayerItems[client][i];
        if(item == null) {
            continue;
        }

        char weapon[64];
        item.GetWeapon(weapon, sizeof(weapon));

        char skinId[16];
        item.GetSkinID(skinId, sizeof(skinId));

        int pattern = item.GetPattern();
        float floatValue = item.GetFloat();
        int statTrak = item.GetStatTrak();

        Format(query, sizeof(query), SET_USER_SKIN, steamId, weapon, skinId, pattern, floatValue, statTrak, skinId, pattern, floatValue, statTrak);
        transaction.AddQuery(query);
    }

    return transaction;
}
