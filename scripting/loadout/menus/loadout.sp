/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

public void Loadout_Menu(int client) {
    Menu menu = CreateMenu(Callback_LoadoutMenu);
    menu.SetTitle("Loadout");

    menu.AddItem("knives", "Knives");
    menu.AddItem("gloves", "Gloves");
    menu.AddItem("skins", "Skins");
    menu.AddItem("items", "Items");

    menu.Display(client, 0);
}

int Callback_LoadoutMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            menu.GetItem(itemNum, info, sizeof(info));

            if(StrEqual(info, "knives")) {
                Knives_Menu(client);
            } else if(StrEqual(info, "gloves")) {
                Gloves_Menu(client);
            } else if(StrEqual(info, "skins")) {
                Skins_Menu(client);
            } else if(StrEqual(info, "items")) {
                Loadout_ItemsMenu(client);
            }
        }

        case MenuAction_End: {
            delete menu;
        }
    }
}

public void Loadout_ItemsMenu(int client) {
    Menu menu = CreateMenu(Callback_LoadoutItemsMenu);
    menu.SetTitle("Items");

    Item item;
    char weapon[64];
    char info[8];
    char display[64];
    for(int i = 0; i < USER_ITEM_MAX; i++) {
        item = g_hPlayerItems[client][i];
        if(item == null) {
            continue;
        }

        item.GetWeapon(weapon, sizeof(weapon));

        Format(info, sizeof(info), "%i", i);
        Format(display, sizeof(display), "%t", weapon);
        menu.AddItem(info, display);
    }

    menu.ExitBackButton = true;
    menu.Display(client, 0);
}

int Callback_LoadoutItemsMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[8];
            menu.GetItem(itemNum, info, sizeof(info));

            int i = StringToInt(info);

            Item item = g_hPlayerItems[client][i];
            if(item == null) {
                return;
            }

            Loadout_ItemInfoMenu(client, item, i);
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

public void Loadout_ItemInfoMenu(int client, Item item, int i) {
    char weapon[64];
    item.GetWeapon(weapon, sizeof(weapon));

    Menu menu = CreateMenu(Callback_LoadoutItemInfoMenu);
    menu.SetTitle("%t", weapon);

    char itemInfo[32];
    char itemDisplay[32];

    Format(itemInfo, sizeof(itemInfo), "pattern;%i", i);
    Format(itemDisplay, sizeof(itemDisplay), "Pattern: %i", item.GetPattern());
    menu.AddItem(itemInfo, itemDisplay);

    Format(itemInfo, sizeof(itemInfo), "float;%i", i);
    Format(itemDisplay, sizeof(itemDisplay), "Float: %f", item.GetFloat());
    menu.AddItem(itemInfo, itemDisplay);

    if(CanUseStattrak(client)) {
        if(item.GetStatTrak() == -1) {
            Format(itemInfo, sizeof(itemInfo), "statTrakDisabled;%i", i);
            Format(itemDisplay, sizeof(itemDisplay), "StatTrak: %s", "Disabled");
            menu.AddItem(itemInfo, itemDisplay);
        } else {
            Format(itemInfo, sizeof(itemInfo), "statTrak;%i", i);
            Format(itemDisplay, sizeof(itemDisplay), "StatTrak: %i", item.GetStatTrak());
            menu.AddItem(itemInfo, itemDisplay);
        }
    }

    menu.ExitBackButton = true;
    menu.Display(client, 0);
}

int Callback_LoadoutItemInfoMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            menu.GetItem(itemNum, info, sizeof(info));

            char sections[2][32];
            ExplodeString(info, ";", sections, 2, 32, true);

            int itemId = StringToInt(sections[1]);

            Item item = g_hPlayerItems[client][itemId];
            if(item == null) {
                return;
            }

            char weapon[64];
            item.GetWeapon(weapon, sizeof(weapon));

            if(StrEqual(sections[0], "pattern")) {

            } else if(StrEqual(sections[0], "float")) {

            } else if(StrEqual(sections[0], "statTrakDisabled")) {
                item.SetStatTrak(0);
                g_hPlayerItems[client][itemId] = item;
                PrintToChat(client, "%s \x04Enabling\x01 StatTrak for \x10%t\x01.", PREFIX, weapon);
                Skins_Refresh(client, weapon);
            } else if(StrEqual(sections[0], "statTrak")) {
                item.SetStatTrak(-1);
                g_hPlayerItems[client][itemId] = item;
                PrintToChat(client, "%s \x02Disabling\x01 StatTrak for \x10%t\x01.", PREFIX, weapon);
                Skins_Refresh(client, weapon);
            }

            Loadout_ItemInfoMenu(client, item, itemId);
        }

        case MenuAction_Cancel: {
            if(itemNum == MenuCancel_ExitBack) {
                Loadout_ItemsMenu(client);
            }
        }

        case MenuAction_End: {
            delete menu;
        }
    }
}
