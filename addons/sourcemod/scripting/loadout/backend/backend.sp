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
        SetFailState("%s Failed to connect to server.  Error: %s", CONSOLE_PREFIX, error);
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
