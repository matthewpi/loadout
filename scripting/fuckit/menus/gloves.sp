/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

public void Gloves_Menu(int client) {
    Menu menu = CreateMenu(Callback_GlovesMenu);
    menu.SetTitle("FuckIt Gloves");

    char item[8];
    char name[64];
    for(int i = 1; i < sizeof(g_hGloves); i++) {
        Glove glove = g_hGloves[i];

        if(glove == null) {
            continue;
        }

        Format(item, sizeof(item), "%i", i);
        glove.GetName(name, sizeof(name));

        menu.AddItem(item, name);
    }

    menu.Display(client, 0);
}

int Callback_GlovesMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            menu.GetItem(itemNum, info, sizeof(info));

            Glove glove = g_hGloves[StringToInt(info)];
            if(glove == null) {
                return;
            }

            g_iGloves[client] = StringToInt(info);
            Gloves_SubMenu(client, glove);
        }

        case MenuAction_End: {
            delete menu;
        }
    }
}

void Gloves_SubMenu(int client, Glove glove) {
    Menu menu = CreateMenu(Callback_GlovesSubMenu);
    menu.SetTitle("FuckIt Gloves");

    GloveSkin skins[16];
    glove.GetSkins(skins, sizeof(skins));

    char item[8];
    char name[64];
    for(int i = 1; i < sizeof(skins); i++) {
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

int Callback_GlovesSubMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            menu.GetItem(itemNum, info, sizeof(info));

            Glove glove = g_hGloves[g_iGloves[client]];
            if(glove == null) {
                return;
            }

            GloveSkin skin = glove.GetSkin(StringToInt(info));

            Gloves_Refresh(client, skin);
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

void Gloves_Refresh(int client, GloveSkin skin) {
    Glove glove = g_hGloves[g_iGloves[client]];
    if(glove == null) {
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
        SetEntPropEnt(client, Prop_Send, "m_hMyWearables", entity);
        SetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex", glove.GetItemID());
        SetEntProp(entity, Prop_Send, "m_iItemIDLow", -1);
        SetEntProp(entity, Prop_Send, "m_nFallbackPaintKit", skin.GetPaintID());
        SetEntPropFloat(entity, Prop_Send, "m_flFallbackWear", 0.01);
        SetEntProp(entity, Prop_Send, "m_nFallbackSeed", GetRandomInt(0, 8192));
        SetEntProp(entity, Prop_Send, "m_bInitialized", 1);
        SetEntPropEnt(entity, Prop_Data, "m_hParent", client);
        SetEntPropEnt(entity, Prop_Data, "m_hOwnerEntity", client);
        SetEntPropEnt(entity, Prop_Data, "m_hMoveParent", client);
        SetEntProp(client, Prop_Send, "m_nBody", 1);
        DispatchSpawn(entity);
    }

    int active = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
    SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", -1);

    DataPack pack;
    CreateDataTimer(0.1, Timer_Reactivate, pack);
    pack.WriteCell(client);

    if(IsValidEntity(active)) {
        pack.WriteCell(active);
    } else {
        pack.WriteCell(-1);
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
