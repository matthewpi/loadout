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
    g_dbLoadout = database;

    // Log our successful connection.
    LogMessage("%s Connected to database.", CONSOLE_PREFIX);

    // Reload all data.
    Backend_Reload();
}

/**
 * Backend_Reload
 * Reloads all gloves, knives, and user data.
 */
public void Backend_Reload() {
    // Get the total skin count.
    Backend_GetSkinCount();

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
 * Backend_Seed
 * Seeds the database.
 */
public void Backend_Seed(const int client) {
    if(g_dbLoadout == INVALID_HANDLE) {
        LogMessage("%s Database is an invalid handle, skipping Backend_Seed().", CONSOLE_PREFIX);
    }

    // Prepare a SQL transaction.
    Transaction transaction = new Transaction();
    transaction = AddQueriesToTransaction(transaction);

    // Execute the transaction.
    SQL_ExecuteTransaction(g_dbLoadout, transaction, Callback_SuccessSeedTransaction, Callback_ErrorSeedTransaction, client, DBPrio_Normal);

    // Reload all data.
    Backend_Reload();
}


/**
 * Callback_SuccessSeedTransaction
 * Successful backend callback for the seeder.
 */
static void Callback_SuccessSeedTransaction(Database database, int client, int numQueries, Handle[] results, any[] queryData) {
    LogMessage("%s Database seeded successfully.", CONSOLE_PREFIX);
    PrintToChat(client, "%s Database seeded successfully.", PREFIX);
}

/**
 * Callback_ErrorSeedTransaction
 * Failed backend callback for the seeder.
 */
static void Callback_ErrorSeedTransaction(Database database, int client, int numQueries, const char[] error, int failIndex, any[] queryData) {
    // Handle query error.
    LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_ErrorSeedTransaction", (strlen(error) > 0 ? error : "Unknown."));
    PrintToChat(client, "%s Error: %s", PREFIX, (strlen(error) > 0 ? error : "Unknown."));
}
