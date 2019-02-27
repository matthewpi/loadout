/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

public void Gloves_Menu(const int client) {
    Menu menu = CreateMenu(Callback_GlovesMenu);
    menu.SetTitle("Gloves");

    char item[8];
    char name[64];
    for(int i = 0; i <= GLOVE_MAX; i++) {
        Glove glove = g_hGloves[i];
        if(glove == null) {
            continue;
        }

        Format(item, sizeof(item), "%i", glove.GetID());
        glove.GetName(name, sizeof(name));

        menu.AddItem(item, name);
    }

    menu.ExitBackButton = true;
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

void Gloves_SubMenu(const int client, const Glove glove) {
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
    for(int i = 0; i <= GLOVE_SKIN_MAX; i++) {
        GloveSkin skin = skins[i];
        if(skin == null) {
            continue;
        }

        Format(item, sizeof(item), "%i", i);
        skin.GetName(name, sizeof(name));

        menu.AddItem(item, name);
    }

    menu.ExitBackButton = true;
    menu.Display(client, 0);
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

            Gloves_Refresh(client);
            Gloves_SubMenu(client, g_hGloves[g_iGloves[client]]);
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

    // Find existing gloves.
    int entity = GetEntPropEnt(client, Prop_Send, "m_hMyWearables");

    // Delete existing gloves.
    if(entity != -1) {
        AcceptEntityInput(entity, "KillHierarchy");
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
    }

    int active = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
    SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", -1);

    if(IsValidEntity(active)) {
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

    SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", active);
}
