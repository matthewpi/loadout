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

        if(g_hDatabase != INVALID_HANDLE) {
            SQL_ExecuteTransaction(g_hDatabase, transaction, Callback_SuccessUserData, Callback_ErrorUserData);
        } else {
            LogMessage("%s Database is an invalid handle, skipping Backend_SaveAllData()", CONSOLE_PREFIX);
        }
    }
}

/**
 * Backend_SaveUserData
 * ?
 */
public void Backend_SaveUserData(const int client, const char[] steamId) {
    Transaction transaction = SQL_CreateTransaction();
    Backend_GetUserDataTransaction(transaction, client, steamId);

    if(g_hDatabase != INVALID_HANDLE) {
        SQL_ExecuteTransaction(g_hDatabase, transaction, Callback_SuccessUserData, Callback_ErrorUserData);
    } else {
        LogMessage("%s Database is an invalid handle, skipping Backend_SaveUserData(int, char[]) for \"%N\"", CONSOLE_PREFIX, client);
    }
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

public void Backend_Seed() {
    if(g_hDatabase == INVALID_HANDLE) {
        LogMessage("%s Database is an invalid handle, skipping Backend_Seed().", CONSOLE_PREFIX);
    }

    // Prepare a SQL transaction.
    Transaction transaction = SQL_CreateTransaction();

    // Create tables if they don't exist.
    transaction.AddQuery(TABLE_GLOVES);
    transaction.AddQuery(TABLE_GLOVE_SKINS);
    transaction.AddQuery(TABLE_KNIVES);
    transaction.AddQuery(TABLE_SKINS);
    transaction.AddQuery(TABLE_USER_SKINS);


    // Prisma Case
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (657, 'Angry Mob (Five-Seven)', 837, 'weapon_five_seven;');");
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (658, 'Emperor (M4A4)', 844, 'weapon_m4a1;');");
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (659, 'Skull Crusher (Revolver)', 843, 'weapon_revolver;');");
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (660, 'Incinegator (XM1014)', 850, 'weapon_xm1014;');");
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (661, 'Momentum (AUG)', 845, 'weapon_aug;');");
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (662, 'Light Rail (Deagle)', 841, 'weapon_deagle;');");
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (663, 'Gauss (MP5)', 846, 'weapon_mp5sd;');");
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (664, 'Bamboozle (Tec 9)', 839, 'weapon_tec9;');");
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (665, 'Moonrise (UMP45)', 851, 'weapon_ump45;');");
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (666, 'Atheris (AWP)', 838, 'weapon_awp;');");
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (667, 'Mischief (MP7)', 847, 'weapon_mp7;');");
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (668, 'Crypsis (FAMAS)', 835, 'weapon_famas;');");
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (669, 'Akoben (Galil)', 842, 'weapon_galilar;');");
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (670, 'Verdigris (P250)', 848, 'weapon_p250;');");
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (671, 'Off World (P90)', 849, 'weapon_p90;');");
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (672, 'Uncharted (AK47)', 836, 'weapon_ak47;');");
    transaction.AddQuery("INSERT IGNORE INTO `loadout_skins` (`id`, `displayName`, `skinId`, `weapons`) VALUES (673, 'Whitefish (MAC10)', 840, 'weapon_mac10;');");

    // Execute the transaction.
    SQL_ExecuteTransaction(g_hDatabase, transaction, Callback_SuccessSeedTransaction, Callback_ErrorSeedTransaction);
}


/**
 * Callback_SuccessSeedTransaction
 * Successful backend callback for the seeder.
 */
static void Callback_SuccessSeedTransaction(Database database, any data, int numQueries, Handle[] results, any[] queryData) {
    LogMessage("%s Database seeded successfully.", CONSOLE_PREFIX);
}

/**
 * Callback_ErrorSeedTransaction
 * Failed backend callback for the seeder.
 */
static void Callback_ErrorSeedTransaction(Database database, any data, int numQueries, const char[] error, int failIndex, any[] queryData) {
    // Handle query error.
    LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_ErrorSeedTransaction", (strlen(error) > 0 ? error : "Unknown."));
}
