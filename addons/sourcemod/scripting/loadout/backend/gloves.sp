/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

/**
 * Backend_LoadGloves
 * ?
 */
public void Backend_LoadGloves() {
    if(g_hDatabase != INVALID_HANDLE) {
        g_hDatabase.Query(Callback_LoadGloves, GET_GLOVES);
    } else {
        LogMessage("%s Database is an invalid handle, skipping Backend_LoadGloves()", CONSOLE_PREFIX);
    }
}

static void Callback_LoadGloves(Database database, DBResultSet results, const char[] error, any data) {
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

static void Callback_LoadGloveSkins(Database database, DBResultSet results, const char[] error, any data) {
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
