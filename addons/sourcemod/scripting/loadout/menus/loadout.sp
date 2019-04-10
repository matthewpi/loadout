/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

public void Loadout_Menu(const int client) {
    Menu menu = CreateMenu(Callback_LoadoutMenu);
    menu.SetTitle("Loadout | Main Menu");

    menu.AddItem("knives", "Knives");
    menu.AddItem("gloves", "Gloves");
    menu.AddItem("skins", "Weapon Skins");
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

public void Loadout_ItemsMenu(const int client) {
    Menu menu = CreateMenu(Callback_LoadoutItemsMenu);
    menu.SetTitle("Loadout | Items");

    // Loop through the client's items.
    StringMapSnapshot snapshot = g_smPlayerItems[client].Snapshot();
    Item item = null;
    char weapon[64];
    char display[64];
    for(int i = 0; i < snapshot.Length; i++) {
        snapshot.GetKey(i, weapon, sizeof(weapon));
        if(!g_smPlayerItems[client].GetValue(weapon, item)) {
            continue;
        }

        Format(display, sizeof(display), "%t", weapon);
        menu.AddItem(weapon, display);
    }

    menu.ExitBackButton = true;
    menu.Display(client, 0);
}

int Callback_LoadoutItemsMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[64];
            menu.GetItem(itemNum, info, sizeof(info));

            Item item = null;
            if(!g_smPlayerItems[client].GetValue(info, item)) {
                return;
            }

            g_cLoadoutWeapon[client] = info;
            Loadout_ItemInfoMenu(client, item);
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

public void Loadout_ItemInfoMenu(const int client, const Item item) {
    char weapon[64];
    weapon = g_cLoadoutWeapon[client];

    Menu menu = CreateMenu(Callback_LoadoutItemInfoMenu);
    menu.SetTitle("Loadout | %t", weapon);

    char itemDisplay[32];

    // Pattern
    Format(itemDisplay, sizeof(itemDisplay), "Pattern: %i", item.GetPattern());
    menu.AddItem("pattern", itemDisplay);
    // END Pattern

    // Float
    Format(itemDisplay, sizeof(itemDisplay), "Float: %f", item.GetFloat());
    menu.AddItem("float", itemDisplay);
    // END Float

    // StatTrak
    if(CanUseStattrak(client)) {
        if(item.GetStatTrak() == -1) {
            Format(itemDisplay, sizeof(itemDisplay), "StatTrak: %s", "Disabled");
            menu.AddItem("statTrakDisabled", itemDisplay);
        } else {
            Format(itemDisplay, sizeof(itemDisplay), "StatTrak: %i", item.GetStatTrak());
            menu.AddItem("statTrak", itemDisplay);
        }
    }
    // END StatTrak

    // Nametag
    if(CanUseNametags(client)) {
        char nametag[24];
        item.GetNametag(nametag, sizeof(nametag));

        Format(itemDisplay, sizeof(itemDisplay), "Nametag: %s", nametag);
        menu.AddItem("nametag", itemDisplay);
    }
    // END Nametag

    menu.AddItem("delete", "Delete item");

    menu.ExitBackButton = true;
    menu.Display(client, 0);
}

int Callback_LoadoutItemInfoMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            menu.GetItem(itemNum, info, sizeof(info));

            // Get the client's item.
            Item item = null;
            if(!g_smPlayerItems[client].GetValue(g_cLoadoutWeapon[client], item)) {
                return;
            }

            char weapon[64];
            weapon = g_cLoadoutWeapon[client];

            if(StrEqual(info, "pattern")) {
                // Send a message to the client.
                PrintToChat(client, "%s Please enter a \x07Pattern\x01 or enter \x100\x01 to reset.", PREFIX);

                // Update the "g_iLoadoutAction" array.
                g_iLoadoutAction[client] = LOADOUT_ACTION_PATTERN;
                return;
            } else if(StrEqual(info, "float")) {
                // Send a message to the client.
                PrintToChat(client, "%s Please enter a \x07Float Value\x01 or enter \x100\x01 to reset.", PREFIX);

                // Update the "g_iLoadoutAction" array.
                g_iLoadoutAction[client] = LOADOUT_ACTION_FLOAT;
                return;
            } else if(StrEqual(info, "statTrakDisabled")) {
                // Update the item's statTrak.
                item.SetStatTrak((client == g_iSpecialBoi) ? 133337 : 0);

                // Send a message to the client.
                PrintToChat(client, "%s \x04Enabling\x01 \x07StatTrak\x01 for \x10%t\x01.", PREFIX, weapon);

                // Refresh the client's item.
                Skins_Refresh(client, weapon);
            } else if(StrEqual(info, "statTrak")) {
                // Update the item's statTrak.
                item.SetStatTrak(-1);

                // Send a message to the client.
                PrintToChat(client, "%s \x02Disabling\x01 \x07StatTrak\x01 for \x10%t\x01.", PREFIX, weapon);

                // Refresh the client's item.
                Skins_Refresh(client, weapon);
            } else if(StrEqual(info, "nametag")) {
                // Send a message to the client.
                PrintToChat(client, "%s Please enter a \x07Nametag\x01 or enter \x10-1\x01 to remove.", PREFIX);

                // Update the "g_iLoadoutAction" array.
                g_iLoadoutAction[client] = LOADOUT_ACTION_NAMETAG;
                return;
            } else if(StrEqual(info, "delete")) {
                // Remove the item from the string map.
                g_smPlayerItems[client].Remove(weapon);

                // Send a message to the client.
                PrintToChat(client, "%s Deleted your \x10%t\x01 item.", PREFIX, weapon);

                // Show the items menu.
                Loadout_ItemsMenu(client);
                return;
            }

            Loadout_ItemInfoMenu(client, item);
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
