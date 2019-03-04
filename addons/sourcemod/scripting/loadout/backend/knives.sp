/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

/**
 * Backend_LoadKnives
 * ?
 */
public void Backend_LoadKnives() {
    g_hDatabase.Query(Callback_LoadKnives, GET_KNIVES);
}

static void Callback_LoadKnives(Database database, DBResultSet results, const char[] error, any data) {
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
