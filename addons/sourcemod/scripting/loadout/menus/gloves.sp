/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

void Gloves_Menu(const int client, const int position = -1) {
    Menu menu = CreateMenu(Callback_GlovesMenu);
    menu.SetTitle("Loadout | Gloves");

    char item[8];
    char name[64];
    for(int i = 0; i < LOADOUT_GLOVE_MAX; i++) {
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
    if(position == -1) {
        menu.Display(client, 0);
    } else {
        menu.DisplayAt(client, position, 0);
    }
}

int Callback_GlovesMenu(const Menu menu, const MenuAction action, const int client, const int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            menu.GetItem(itemNum, info, sizeof(info));

            int gloveId = StringToInt(info);

            if(gloveId == 1) {
                g_iGloves[client] = 0;
                g_iGloveSkins[client] = 0;
                Gloves_Refresh(client);
                Gloves_Menu(client, GetMenuSelectionPosition());
                PrintToChat(client, "%s Removed your current glove selection.", PREFIX);
                return;
            }

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

    GloveSkin skins[LOADOUT_GLOVE_SKIN_MAX + 1];
    glove.GetSkins(skins, sizeof(skins));

    char item[8];
    char name[64];
    for(int i = 0; i < LOADOUT_GLOVE_SKIN_MAX; i++) {
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
