/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

public void Gloves_Menu(const int client) {
    Menu menu = CreateMenu(Callback_GlovesMenu);
    menu.SetTitle("Gloves");

    char item[8];
    char name[64];
    for(int i = 0; i < GLOVE_MAX; i++) {
        Glove glove = g_hGloves[i];
        if(glove == null) {
            continue;
        }

        Format(item, sizeof(item), "%i", glove.GetID());
        glove.GetName(name, sizeof(name));

        menu.AddItem(item, name);
    }

    // Enable the menu exit back button.
    menu.ExitBackButton = true;

    // Display the menu to the client.
    menu.Display(client, 0);
}

int Callback_GlovesMenu(const Menu menu, const MenuAction action, const int client, const int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            menu.GetItem(itemNum, info, sizeof(info));

            int gloveId = StringToInt(info);

            Glove glove = g_hGloves[gloveId];
            if(glove == null) {
                return;
            }

            g_iGloves[client] = gloveId;
            Gloves_SubMenu(client, glove);
        }

        case MenuAction_Cancel: {
            if(itemNum == MenuCancel_ExitBack) {
                Loadout_Menu(client);
            }
        }

        case MenuAction_End: {
            delete menu;
        }
    }
}

void Gloves_SubMenu(const int client, const Glove glove, const int position = -1) {
    if(glove == null) {
        return;
    }

    char title[64];
    glove.GetName(title, sizeof(title));

    Menu menu = CreateMenu(Callback_GlovesSubMenu);
    menu.SetTitle(title);

    GloveSkin skins[GLOVE_SKIN_MAX + 1];
    glove.GetSkins(skins, sizeof(skins));

    char item[8];
    char name[64];
    for(int i = 0; i < GLOVE_SKIN_MAX; i++) {
        GloveSkin skin = skins[i];
        if(skin == null) {
            continue;
        }

        Format(item, sizeof(item), "%i", i);
        skin.GetName(name, sizeof(name));

        menu.AddItem(item, name);
    }

    // Enable the menu exit back button.
    menu.ExitBackButton = true;

    // Display the menu to the client.
    if(position == -1) {
        menu.Display(client, 0);
    } else {
        menu.DisplayAt(client, position, 0);
    }
}

int Callback_GlovesSubMenu(const Menu menu, const MenuAction action, const int client, const int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            menu.GetItem(itemNum, info, sizeof(info));

            Glove glove = g_hGloves[g_iGloves[client]];
            if(glove == null) {
                return;
            }

            int skinIndex = StringToInt(info);
            g_iGloveSkins[client] = skinIndex;

            // Get the selected glove skin.
            GloveSkin skin = glove.GetSkin(g_iGloveSkins[client]);
            if(skin == null) {
                return;
            }

            char gloveName[64];
            glove.GetName(gloveName, sizeof(gloveName));

            char skinName[64];
            skin.GetName(skinName, sizeof(skinName));

            PrintToChat(client, "%s Setting your gloves to \x10%s | %s\x01.", PREFIX, gloveName, skinName);
            Gloves_Refresh(client);
            Gloves_SubMenu(client, g_hGloves[g_iGloves[client]], GetMenuSelectionPosition());
        }

        case MenuAction_Cancel: {
            if(itemNum == MenuCancel_ExitBack) {
                Gloves_Menu(client);
            }
        }

        case MenuAction_End: {
            delete menu;
        }
    }
}

public void Gloves_Refresh(const int client) {
    Glove glove = g_hGloves[g_iGloves[client]];
    if(glove == null) {
        return;
    }

    GloveSkin skin = glove.GetSkin(g_iGloveSkins[client]);
    if(skin == null) {
        return;
    }

    int active = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
    if(active != -1) {
        SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", -1);
    }

    // Find existing gloves.
    int entity = GetEntPropEnt(client, Prop_Send, "m_hMyWearables");

    // Delete existing gloves.
    if(entity != -1) {
        AcceptEntityInput(entity, "KillHierarchy");
    }

    char armTemp[2];
    GetEntPropString(client, Prop_Send, "m_szArmsModel", armTemp, sizeof(armTemp));

    if(armTemp[0]) {
        SetEntPropString(client, Prop_Send, "m_szArmsModel", "");

        #if defined LOADOUT_DEBUG
            LogMessage("%s (Debug) Fixing arms for \"%N\".", CONSOLE_PREFIX, client);
        #endif
    }

    entity = CreateEntityByName("wearable_item");

    if(entity != -1) {
        SetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex", glove.GetItemID());
        SetEntProp(entity, Prop_Send, "m_iItemIDLow", -1);
        SetEntProp(entity, Prop_Send, "m_nFallbackPaintKit", skin.GetPaintID());
        SetEntPropFloat(entity, Prop_Send, "m_flFallbackWear", 0.0001);
        SetEntProp(entity, Prop_Send, "m_nFallbackSeed", GetRandomInt(0, 8192));
        SetEntProp(entity, Prop_Send, "m_bInitialized", 1);
        SetEntPropEnt(entity, Prop_Data, "m_hParent", client);
        SetEntPropEnt(entity, Prop_Data, "m_hOwnerEntity", client);
        SetEntPropEnt(entity, Prop_Data, "m_hMoveParent", client);
        SetEntProp(client, Prop_Send, "m_nBody", 1);
        DispatchSpawn(entity);
        SetEntPropEnt(client, Prop_Send, "m_hMyWearables", entity);

        #if defined LOADOUT_DEBUG
            LogMessage("%s (Debug) Applied entity properties for \"%N\"'s gloves.", CONSOLE_PREFIX, client);
        #endif
    }

    #if defined LOADOUT_DEBUG
    else {
        LogMessage("%s (Debug) Failed to create \"wearable_item\" for \"%N\".", CONSOLE_PREFIX, client);
    }
    #endif

    if(active != -1) {
        DataPack pack;
        CreateDataTimer(0.1, Timer_Reactivate, pack);
        pack.WriteCell(client);
        pack.WriteCell(active);
    }
}

Action Timer_Reactivate(Handle timer, DataPack pack) {
    int client;
    int active;

    pack.Reset();
    client = pack.ReadCell();
    active = pack.ReadCell();

    if(!IsClientInGame(client)) {
        return;
    }

    if(!IsPlayerAlive(client)) {
        return;
    }

    if(!IsValidEntity(active)) {
        return;
    }


    #if defined LOADOUT_DEBUG
        LogMessage("%s (Debug) Updating \"%N\"'s active weapon.", CONSOLE_PREFIX, client);
    #endif

    SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", active);
}
