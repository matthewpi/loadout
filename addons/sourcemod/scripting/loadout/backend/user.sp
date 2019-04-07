/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

/**
 * Backend_GetUserSkins
 * ?
 */
public void Backend_GetUserSkins(const int client, const char[] steamId) {
    if(g_dbLoadout == INVALID_HANDLE) {
        LogMessage("%s Database is an invalid handle, skipping Backend_GetUserSkins(int, char[]) for \"%N\"", CONSOLE_PREFIX, client);
        return;
    }

    char query[512];
    Format(query, sizeof(query), GET_USER_SKINS, steamId);
    g_dbLoadout.Query(Callback_GetUserSkins, query, client);
}

static void Callback_GetUserSkins(Database database, DBResultSet results, const char[] error, int client) {
    if(results == null) {
        LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_GetUserSkins", (strlen(error) > 0 ? error : "Unknown."));
        return;
    }

    int weaponIndex;
    int skinIdIndex;
    int patternIndex;
    int floatIndex;
    int statTrakIndex;
    int nametagIndex;
    if(!results.FieldNameToNum("weapon", weaponIndex)) { LogError("%s Failed to locate \"weapon\" field in table \"loadout_user_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("skinId", skinIdIndex)) { LogError("%s Failed to locate \"skinId\" field in table \"loadout_user_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("skinPattern", patternIndex)) { LogError("%s Failed to locate \"skinPattern\" field in table \"loadout_user_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("skinFloat", floatIndex)) { LogError("%s Failed to locate \"skinFloat\" field in table \"loadout_user_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("statTrak", statTrakIndex)) { LogError("%s Failed to locate \"statTrak\" field in table \"loadout_user_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("nametag", nametagIndex)) { LogError("%s Failed to locate \"nametag\" field in table \"loadout_user_skins\".", CONSOLE_PREFIX); return; }

    int i = 0;
    while(results.FetchRow()) {
        char weapon[64];
        char skinId[16];
        int pattern = results.FetchInt(patternIndex);
        float floatValue = results.FetchFloat(floatIndex);
        int statTrak = results.FetchInt(statTrakIndex);
        char nametag[24];

        results.FetchString(weaponIndex, weapon, sizeof(weapon));
        results.FetchString(skinIdIndex, skinId, sizeof(skinId));
        results.FetchString(nametagIndex, nametag, sizeof(nametag));

        // Handles knife type (not skin)
        if(StrEqual(weapon, "plugin_knife", true)) {
            g_iKnives[client] = StringToInt(skinId);
            continue;
        }

        // Handles gloves
        if(StrEqual(weapon, "plugin_gloves", true)) {
            char gloveSections[2][8];
            ExplodeString(skinId, ";", gloveSections, 2, 8, true);

            g_iGloves[client] = StringToInt(gloveSections[0]);
            g_iGloveSkins[client] = StringToInt(gloveSections[1]);
            continue;
        }

        // Make sure the float value is not below the configured minimum.
        if(floatValue < LOADOUT_DEFAULT_FLOAT) {
            floatValue = LOADOUT_DEFAULT_FLOAT;
        }

        Item item = new Item();
        item.SetWeapon(weapon);
        item.SetSkinID(skinId);
        item.SetPattern(pattern);
        item.SetFloat(floatValue);
        item.SetStatTrak(statTrak);
        item.SetNametag(nametag);

        // Handles all actual skins
        g_smPlayerItems[client].SetValue(weapon, item, true);
        i++;
    }

    #if defined LOADOUT_DEBUG
        LogMessage("%s (Debug) Loaded skins for \"%N\" (%i).", CONSOLE_PREFIX, client, i);
    #endif
}

/**
 * Backend_SaveUserData
 * ?
 */
public void Backend_SaveUserData(const int client, const char[] steamId) {
    Transaction transaction = new Transaction();
    Backend_GetUserDataTransaction(transaction, client, steamId);

    if(g_dbLoadout != INVALID_HANDLE) {
        SQL_ExecuteTransaction(g_dbLoadout, transaction, Callback_SuccessUserData, Callback_ErrorUserData);
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
 * Loads all user's skins into a transaction.
 */
public Transaction Backend_GetUserDataTransaction(const Transaction transaction, const int client, const char[] steamId) {
    char query[512];

    // Handles knife (actual knife, not skin)
    char knife[16];
    IntToString(g_iKnives[client], knife, sizeof(knife));
    Format(query, sizeof(query), SET_USER_SKIN, steamId, "plugin_knife", knife, 0, LOADOUT_DEFAULT_FLOAT, -1, "", knife, 0, LOADOUT_DEFAULT_FLOAT, -1, "");
    transaction.AddQuery(query);

    // Handles gloves (glove type and skin)
    char gloves[16];
    Format(gloves, sizeof(gloves), "%i;%i", g_iGloves[client], g_iGloveSkins[client]);
    Format(query, sizeof(query), SET_USER_SKIN, steamId, "plugin_gloves", gloves, 0, LOADOUT_DEFAULT_FLOAT, -1, "", gloves, 0, LOADOUT_DEFAULT_FLOAT, -1, "");
    transaction.AddQuery(query);

    // Handle weapon and knife skins
    StringMapSnapshot snapshot = g_smPlayerItems[client].Snapshot();
    Item item = null;
    char weapon[64];
    for(int i = 0; i < snapshot.Length; i++) {
        snapshot.GetKey(i, weapon, sizeof(weapon));
        if(!g_smPlayerItems[client].GetValue(weapon, item)) {
            continue;
        }

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

        transaction = new Transaction();

        char steamId[64];
        GetClientAuthId(i, AuthId_Steam2, steamId, sizeof(steamId));
        Backend_GetUserDataTransaction(transaction, i, steamId);

        if(g_dbLoadout != INVALID_HANDLE) {
            SQL_ExecuteTransaction(g_dbLoadout, transaction, Callback_SuccessUserData, Callback_ErrorUserData);
        } else {
            LogMessage("%s Database is an invalid handle, skipping Backend_SaveAllData()", CONSOLE_PREFIX);
        }

        transaction = null;
    }
}
