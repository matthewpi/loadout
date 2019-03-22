/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

/**
 * Backend_GetUserSkins
 * ?
 */
public void Backend_GetUserSkins(const int client, const char[] steamId) {
    char query[512];
    Format(query, sizeof(query), GET_USER_SKINS, steamId);

    if(g_hDatabase != INVALID_HANDLE) {
        g_hDatabase.Query(Callback_GetUserSkins, query, client);
    } else {
        LogMessage("%s Database is an invalid handle, skipping Backend_GetUserSkins(int, char[]) for \"%N\"", CONSOLE_PREFIX, client);
    }
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
        if(floatValue < ITEM_FLOAT_MIN) {
            floatValue = ITEM_FLOAT_MIN;
        }

        Item item = new Item();
        item.SetWeapon(weapon);
        item.SetSkinID(skinId);
        item.SetPattern(pattern);
        item.SetFloat(floatValue);
        item.SetStatTrak(statTrak);
        item.SetNametag(nametag);

        // Handles all actual skins
        g_hPlayerItems[client][i] = item;
        i++;
    }
}

/**
 * Backend_SearchSkins
 * ?
 */
public void Backend_SearchSkins(const int client, const char[] skinQuery) {
    if(g_hDatabase == INVALID_HANDLE) {
        LogMessage("%s Database is an invalid handle, skipping Backend_SearchSkins(int, char[]) for \"%N\"", CONSOLE_PREFIX, client);
        return;
    }

    int skinQueryLen = strlen(skinQuery) * 2 + 1;
    char[] escapedSkinQuery = new char[skinQueryLen];

    g_hDatabase.Escape(skinQuery, escapedSkinQuery, skinQueryLen);

    char query[512];
    Format(query, sizeof(query), SEARCH_WEAPON_SKINS, escapedSkinQuery);

    g_hDatabase.Query(Callback_SearchSkins, query, client);
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
            item.SetDefaults(client, g_cSkinWeapon[client]);
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

    if(!IsClientValid(client)) {
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

    menu.ExitBackButton = true;

    g_hSkinMenus[client] = menu;

    menu.Display(client, 0);
}

/**
 * Backend_RandomSkin
 * ?
 */
public void Backend_RandomSkin(const int client) {
    if(g_hDatabase == INVALID_HANDLE) {
        LogMessage("%s Database is an invalid handle, skipping Backend_RandomSkin(int) for \"%N\"", CONSOLE_PREFIX, client);
        return;
    }

    int skinId = GetRandomInt(1, g_iSkinCount);

    char query[512];
    Format(query, sizeof(query), GET_WEAPON_SKIN, skinId);
    g_hDatabase.Query(Callback_RandomSkin, query, client);
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
        item.SetDefaults(client, g_cSkinWeapon[client]);
        i = validItems + 1;
    }

    char skinIdChar[16];
    IntToString(skinId, skinIdChar, sizeof(skinIdChar));
    item.SetSkinID(skinIdChar);
    g_hPlayerItems[client][i] = item;

    Skins_Refresh(client, g_cSkinWeapon[client]);
    PrintToChat(client, "%s Applying \x10%s\x01 to \x07%t\x01.", PREFIX, name, g_cSkinWeapon[client]);
    Skins_FilterMenu(client);
}
