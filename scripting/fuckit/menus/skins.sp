/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

public void Skins_Menu(int client) {
    Menu menu = CreateMenu(Callback_SkinsMenu);
    menu.SetTitle("FuckIt Skins");

    // TODO: Load CS:GO weapons.

    menu.Display(client, 0);
}

int Callback_SkinsMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {

        }

        case MenuAction_End: {
            delete menu;
        }
    }
}

void Skins_SubMenu(int client) {
    Menu menu = CreateMenu(Callback_SkinsSubMenu);
    menu.SetTitle("FuckIt Skins");

    // TODO: Load weapon skins (20-50) or pull from cache.

    menu.ExitBackButton = true;
    menu.Display(client, 0);
}

int Callback_SkinsSubMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {

        }

        case MenuAction_Cancel: {
            if(itemNum == MenuCancel_ExitBack) {
                Skins_Menu(client);
            }
        }

        case MenuAction_End: {
            delete menu;
        }
    }
}
