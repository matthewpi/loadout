/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

/**
 * Backend_GetSkinCount
 * ?
 */
public void Backend_GetSkinCount() {
    if(g_dbLoadout == INVALID_HANDLE) {
        LogMessage("%s Database is an invalid handle, skipping Backend_GetSkinCount()", CONSOLE_PREFIX);
        return;
    }

    g_dbLoadout.Query(Callback_GetSkinCount, GET_SKIN_COUNT);
}

static void Callback_GetSkinCount(Database database, DBResultSet results, const char[] error, any data) {
    if(results == null) {
        LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_GetSkinCount", (strlen(error) > 0 ? error : "Unknown."));
        return;
    }

    int countIndex;
    if(!results.FieldNameToNum("count", countIndex)) { LogError("%s Failed to locate \"count\" field in table \"loadout_skins\".", CONSOLE_PREFIX); return; }

    results.FetchRow();
    int count = results.FetchInt(countIndex);

    if(count == 0) {
        LogError("%s Failed to find any weapon skins, please initialize the database by running `sm_loadout_update_db`.", CONSOLE_PREFIX);
        return;
    }

    g_iSkinCount = count;
}

/**
 * Backend_SearchSkins
 * ?
 */
public void Backend_SearchSkins(const int client, const char[] skinQuery) {
    if(g_dbLoadout == INVALID_HANDLE) {
        LogMessage("%s Database is an invalid handle, skipping Backend_SearchSkins(int, char[]) for \"%N\"", CONSOLE_PREFIX, client);
        return;
    }

    int skinQueryLen = strlen(skinQuery) * 2 + 1;
    char[] escapedSkinQuery = new char[skinQueryLen];

    g_dbLoadout.Escape(skinQuery, escapedSkinQuery, skinQueryLen);

    char query[512];
    Format(query, sizeof(query), SEARCH_WEAPON_SKINS, escapedSkinQuery);

    g_dbLoadout.Query(Callback_SearchSkins, query, client);
}

static void Callback_SearchSkins(Database database, DBResultSet results, const char[] error, int client) {
    if(results == null) {
        LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_SearchSkins", (strlen(error) > 0 ? error : "Unknown."));
        return;
    }

    if(!IsClientValid(client)) {
        return;
    }

    if(results.RowCount == 0 || results.FieldCount == 0) {
        PrintToChat(client, "%s No results found.", PREFIX);
        return;
    }

    int nameIndex;
    int skinIdIndex;
    if(!results.FieldNameToNum("displayName", nameIndex)) { LogError("%s Failed to locate \"displayName\" field in table \"loadout_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("skinId", skinIdIndex)) { LogError("%s Failed to locate \"skinId\" field in table \"loadout_skins\".", CONSOLE_PREFIX); return; }

    if(results.RowCount == 1) {
        // Switch to the first row.
        results.FetchRow();

        // Get the query data.
        char name[64];
        int skinId = results.FetchInt(skinIdIndex);
        results.FetchString(nameIndex, name, sizeof(name));

        // Get or create the players item.
        Item item = null;
        if(!g_smPlayerItems[client].GetValue(g_cLoadoutWeapon[client], item)) {
            item = new Item();
            item.SetDefaults(client, g_cLoadoutWeapon[client]);
            g_smPlayerItems[client].SetValue(g_cLoadoutWeapon[client], item);
        }

        // Get the item's skinId.
        char skinIdChar[16];
        IntToString(skinId, skinIdChar, sizeof(skinIdChar));
        item.SetSkinID(skinIdChar);

        // Refresh the client's item.
        Skins_Refresh(client, g_cLoadoutWeapon[client]);

        // Send a message to the client.
        PrintToChat(client, "%s Applying \x10%s\x01 to \x07%t\x01.", PREFIX, name, g_cLoadoutWeapon[client]);

        // Show the filter menu to the client.
        Skins_FilterMenu(client);
        return;
    }

    Menu menu = CreateMenu(Callback_SkinsSkinMenu);
    menu.SetTitle("Loadout | Skins");

    while(results.FetchRow()) {
        char name[64];
        int skinId = results.FetchInt(skinIdIndex);

        results.FetchString(nameIndex, name, sizeof(name));

        char itemId[8];
        IntToString(skinId, itemId, sizeof(itemId));

        menu.AddItem(itemId, name);
    }

    // Enable the menu's ExitBack button.
    menu.ExitBackButton = true;

    // Add the menu to the array.
    g_mFilterMenus[client] = menu;

    // Display the menu to the client.
    menu.Display(client, 0);
}

/**
 * Backend_RandomSkin
 * ?
 */
public void Backend_RandomSkin(const int client) {
    if(g_dbLoadout == INVALID_HANDLE) {
        LogMessage("%s Database is an invalid handle, skipping Backend_RandomSkin(int) for \"%N\"", CONSOLE_PREFIX, client);
        return;
    }

    int skinId = GetRandomInt(1, g_iSkinCount);

    char query[512];
    Format(query, sizeof(query), GET_WEAPON_SKIN, skinId);
    g_dbLoadout.Query(Callback_RandomSkin, query, client);
}

static void Callback_RandomSkin(Database database, DBResultSet results, const char[] error, int client) {
    if(results == null) {
        LogError("%s Query failure. %s >> %s", CONSOLE_PREFIX, "Callback_RandomSkin", (strlen(error) > 0 ? error : "Unknown."));
        return;
    }

    if(!IsClientValid(client)) {
        return;
    }

    if(results.RowCount == 0 || results.FieldCount == 0) {
        PrintToChat(client, "%s No results found.", PREFIX);
        return;
    }

    int nameIndex;
    int skinIdIndex;
    if(!results.FieldNameToNum("displayName", nameIndex)) { LogError("%s Failed to locate \"displayName\" field in table \"loadout_skins\".", CONSOLE_PREFIX); return; }
    if(!results.FieldNameToNum("skinId", skinIdIndex)) { LogError("%s Failed to locate \"skinId\" field in table \"loadout_skins\".", CONSOLE_PREFIX); return; }

    // Switch to the first row.
    results.FetchRow();

    // Get the query data.
    char name[64];
    int skinId = results.FetchInt(skinIdIndex);
    results.FetchString(nameIndex, name, sizeof(name));

    // Get or create the players item.
    Item item = null;
    if(!g_smPlayerItems[client].GetValue(g_cLoadoutWeapon[client], item)) {
        item = new Item();
        item.SetDefaults(client, g_cLoadoutWeapon[client]);
        g_smPlayerItems[client].SetValue(g_cLoadoutWeapon[client], item);
    }

    // Get the item's skinId.
    char skinIdChar[16];
    IntToString(skinId, skinIdChar, sizeof(skinIdChar));
    item.SetSkinID(skinIdChar);

    // Refresh the client's item.
    Skins_Refresh(client, g_cLoadoutWeapon[client]);

    // Send a message to the client.
    PrintToChat(client, "%s Applying \x10%s\x01 to \x07%t\x01.", PREFIX, name, g_cLoadoutWeapon[client]);

    Skins_FilterMenu(client);
}
