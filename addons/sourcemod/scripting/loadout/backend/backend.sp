/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

/**
 * Backend_Connnection
 * Handles the database connection callback.
 */
public void Backend_Connnection(Database database, const char[] error, any data) {
    // Handle the connection error.
    if(database == null) {
        SetFailState("%s Failed to connect to server, error: %s", CONSOLE_PREFIX, error);
        return;
    }

    // Set the global database object.
    g_hDatabase = database;

    // Log our successful connection.
    LogMessage("%s Connected to database.", CONSOLE_PREFIX);

    // Prepare a SQL transaction.
    Transaction transaction = SQL_CreateTransaction();

    // Add create table if not exists queries.
    transaction.AddQuery(TABLE_GLOVES);
    transaction.AddQuery(TABLE_GLOVE_SKINS);
    transaction.AddQuery(TABLE_KNIVES);
    transaction.AddQuery(TABLE_SKINS);
    transaction.AddQuery(TABLE_USER_SKINS);

    // Execute the transaction.
    SQL_ExecuteTransaction(g_hDatabase, transaction, Callback_SuccessTableTransaction, Callback_ErrorTableTransaction);

    // Load all gloves and glove skins.
    Backend_LoadGloves();

    // Load all knives.
    Backend_LoadKnives();

    // Loop through all online clients.
    for(int i = 1; i <= MaxClients; i++) {
        // Check if the client is invalid.
        if(!IsClientValid(i)) {
            continue;
        }

        // Recall the "OnClientConnected" event.
        OnClientConnected(i);

        // Recall the "OnClientPutInServer" event.
        OnClientPutInServer(i);

        // Get the client's steam id.
        char steamId[64];
        GetClientAuthId(i, AuthId_Steam2, steamId, sizeof(steamId));

        // Special boi :^)
        if(StrEqual(steamId, "STEAM_1:1:530997")) {
            g_iSpecialBoi = i;
        }

        // Load the client's skins.
        Backend_GetUserSkins(i, steamId);
    }
}

/**
 * Callback_SuccessTableTransaction
 * Successful backend callback for the table layout.
 */
static void Callback_SuccessTableTransaction(Database database, any data, int numQueries, Handle[] results, any[] queryData) {
    //LogMessage("%s Created database tables successfully.", CONSOLE_PREFIX);
}

/**
 * Callback_ErrorTableTransaction
 * Failed backend callback for the table layout.
 */
static void Callback_ErrorTableTransaction(Database database, any data, int numQueries, const char[] error, int failIndex, any[] queryData) {
    // Handle query error.
    LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_ErrorTableTransaction", (strlen(error) > 0 ? error : "Unknown."));
}

/**
 * Backend_SaveAllData
 * ?
 */
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

/**
 * Backend_SaveUserData
 * ?
 */
public void Backend_SaveUserData(const int client, const char[] steamId) {
    Transaction transaction = SQL_CreateTransaction();
    Backend_GetUserDataTransaction(transaction, client, steamId);
    SQL_ExecuteTransaction(g_hDatabase, transaction, Callback_SuccessUserData, Callback_ErrorUserData);
}

static void Callback_SuccessUserData(Database database, any data, int numQueries, Handle[] results, any[] queryData) {
    // For safe keeping :^)
}

static void Callback_ErrorUserData(Database database, any data, int numQueries, const char[] error, int failIndex, any[] queryData) {
    LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_ErrorUserData", (strlen(error) > 0 ? error : "Unknown."));
}

/**
 * Backend_GetUserDataTransaction
 * ?
 */
static Transaction Backend_GetUserDataTransaction(const Transaction transaction, const int client, const char[] steamId) {
    char query[512];

    // Handles knife (actual knife, not skin)
    char knife[16];
    IntToString(g_iKnives[client], knife, sizeof(knife));
    Format(query, sizeof(query), SET_USER_SKIN, steamId, "plugin_knife", knife, 0, 0.0001, -1, "", knife, 0, 0.0001, -1, "");
    transaction.AddQuery(query);

    // Handles gloves (glove type and skin)
    char gloves[16];
    Format(gloves, sizeof(gloves), "%i;%i", g_iGloves[client], g_iGloveSkins[client]);
    Format(query, sizeof(query), SET_USER_SKIN, steamId, "plugin_gloves", gloves, 0, 0.0001, -1, "", gloves, 0, 0.0001, -1, "");
    transaction.AddQuery(query);

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

        char nametag[24];
        item.GetNametag(nametag, sizeof(nametag));

        Format(query, sizeof(query), SET_USER_SKIN, steamId, weapon, skinId, pattern, floatValue, statTrak, nametag, skinId, pattern, floatValue, statTrak, nametag);
        transaction.AddQuery(query);
    }

    return transaction;
}
