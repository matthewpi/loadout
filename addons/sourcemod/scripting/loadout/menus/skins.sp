/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

public void Skins_Menu(const int client) {
    Menu menu = CreateMenu(Callback_SkinsMenu, MENU_ACTIONS_DEFAULT);
    menu.SetTitle("Loadout | Skins");

    if(IsPlayerAlive(client)) {
        int size = GetEntPropArraySize(client, Prop_Send, "m_hMyWeapons");

        char weaponClass[32];
        char weaponName[32];
        bool hasKnife = false;
        for(int i = 0; i < size; i++) {
            int entity = GetEntPropEnt(client, Prop_Send, "m_hMyWeapons", i);

            if(entity != -1 && GetWeaponClass(entity, weaponClass, sizeof(weaponClass))) {
                Format(weaponName, sizeof(weaponName), "%T", weaponClass, client);

                if(IsKnife(weaponClass)) {
                    if(!hasKnife) {
                        menu.AddItem(weaponClass, weaponName, (IsKnife(weaponClass) && g_iKnives[client] == 0) ? ITEMDRAW_DISABLED : ITEMDRAW_DEFAULT);
                        hasKnife = true;
                    }
                } else {
                    menu.AddItem(weaponClass, weaponName);
                }
            }
        }
    }

    menu.AddItem("", "", ITEMDRAW_SPACER);
    menu.AddItem("pistols", "Pistols");
    menu.AddItem("heavy", "Heavy");
    menu.AddItem("smg", "SMG");
    menu.AddItem("rifles", "Rifles");
    menu.AddItem("knives", "Knives");

    menu.ExitBackButton = true;
    menu.Display(client, 0);
}

int Callback_SkinsMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            menu.GetItem(itemNum, info, sizeof(info));

            if(StrEqual(info, "pistols")) {
                Skins_PistolMenu(client);
            } else if(StrEqual(info, "heavy")) {
                Skins_HeavyMenu(client);
            } else if(StrEqual(info, "smg")) {
                Skins_SMGMenu(client);
            } else if(StrEqual(info, "rifles")) {
                Skins_RifleMenu(client);
            } else if(StrEqual(info, "knives")) {
                Skins_KnifeMenu(client);
            }/* else if(StrEqual(info, "inventory")) {
                Skins_InventoryMenu(client);
            }*/ else {
                g_cLoadoutWeapon[client] = info;
                Skins_FilterMenu(client);
            }
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

static void Skins_PistolMenu(const int client) {
    Menu menu = CreateMenu(Callback_SkinsWeaponMenu);
    menu.SetTitle("Loadout | Pistols");

    char weaponName[32];

    Format(weaponName, sizeof(weaponName), "%t", "weapon_cz75a");
    menu.AddItem("weapon_cz75a", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_deagle");
    menu.AddItem("weapon_deagle", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_elite");
    menu.AddItem("weapon_elite", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_fiveseven");
    menu.AddItem("weapon_fiveseven", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_glock");
    menu.AddItem("weapon_glock", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_hkp2000");
    menu.AddItem("weapon_hkp2000", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_p250");
    menu.AddItem("weapon_p250", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_tec9");
    menu.AddItem("weapon_tec9", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_usp_silencer");
    menu.AddItem("weapon_usp_silencer", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_revolver");
    menu.AddItem("weapon_revolver", weaponName);

    menu.ExitBackButton = true;
    menu.Display(client, 0);
}

static void Skins_HeavyMenu(const int client) {
    Menu menu = CreateMenu(Callback_SkinsWeaponMenu);
    menu.SetTitle("Loadout | Heavy");

    char weaponName[32];

    Format(weaponName, sizeof(weaponName), "%t", "weapon_nova");
    menu.AddItem("weapon_nova", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_m249");
    menu.AddItem("weapon_bizon", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_mag7");
    menu.AddItem("weapon_mag7", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_negev");
    menu.AddItem("weapon_negev", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_sawedoff");
    menu.AddItem("weapon_sawedoff", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_xm1014");
    menu.AddItem("weapon_xm1014", weaponName);

    menu.ExitBackButton = true;
    menu.Display(client, 0);
}

static void Skins_SMGMenu(const int client) {
    Menu menu = CreateMenu(Callback_SkinsWeaponMenu);
    menu.SetTitle("Loadout | SMG");

    char weaponName[32];

    Format(weaponName, sizeof(weaponName), "%t", "weapon_bizon");
    menu.AddItem("weapon_bizon", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_mac10");
    menu.AddItem("weapon_mac10", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_mp5sd");
    menu.AddItem("weapon_mp5sd", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_mp7");
    menu.AddItem("weapon_mp7", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_mp9");
    menu.AddItem("weapon_mp9", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_p90");
    menu.AddItem("weapon_p90", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_ump45");
    menu.AddItem("weapon_ump45", weaponName);

    menu.ExitBackButton = true;
    menu.Display(client, 0);
}

static void Skins_RifleMenu(const int client) {
    Menu menu = CreateMenu(Callback_SkinsWeaponMenu);
    menu.SetTitle("Loadout | Rifles");

    char weaponName[32];

    Format(weaponName, sizeof(weaponName), "%t", "weapon_ak47");
    menu.AddItem("weapon_ak47", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_aug");
    menu.AddItem("weapon_aug", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_awp");
    menu.AddItem("weapon_awp", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_famas");
    menu.AddItem("weapon_famas", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_g3sg1");
    menu.AddItem("weapon_g3sg1", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_galilar");
    menu.AddItem("weapon_galilar", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_m4a1");
    menu.AddItem("weapon_m4a1", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_m4a1_silencer");
    menu.AddItem("weapon_m4a1_silencer", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_scar20");
    menu.AddItem("weapon_scar20", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_sg556");
    menu.AddItem("weapon_sg556", weaponName);

    Format(weaponName, sizeof(weaponName), "%t", "weapon_ssg08");
    menu.AddItem("weapon_ssg08", weaponName);

    menu.ExitBackButton = true;
    menu.Display(client, 0);
}

static void Skins_KnifeMenu(const int client) {
    Menu menu = CreateMenu(Callback_SkinsWeaponMenu);
    menu.SetTitle("Loadout | Knives");

    char name[64];
    char itemName[64];
    for(int i = 0; i < LOADOUT_KNIFE_MAX; i++) {
        Knife knife = g_hKnives[i];
        if(knife == null || knife.GetItemID() == 0) {
            continue;
        }

        knife.GetName(name, sizeof(name));
        knife.GetItemName(itemName, sizeof(itemName));

        menu.AddItem(itemName, name);
	}

    menu.ExitBackButton = true;
    menu.Display(client, 0);
}

int Callback_SkinsWeaponMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            menu.GetItem(itemNum, info, sizeof(info));

            g_cLoadoutWeapon[client] = info;
            Skins_FilterMenu(client);
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

public void Skins_FilterMenu(const int client) {
    Menu menu = CreateMenu(Callback_SkinsFilterMenu);
    menu.SetTitle("Skin Filter");

    menu.AddItem("search", "Search..");
    menu.AddItem("random", "Random");
    menu.AddItem("default", "Default");

    char alphabet[26][1] = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" };
    for(int i = 0; i < sizeof(alphabet); i++) {
        menu.AddItem(alphabet[i], alphabet[i]);
    }

    menu.ExitBackButton = true;
    menu.Display(client, 0);
}

static int Callback_SkinsFilterMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            menu.GetItem(itemNum, info, sizeof(info));

            if(StrEqual(info, "search", true)) {
                // Update the "g_iLoadoutAction" array.
                g_iLoadoutAction[client] = LOADOUT_ACTION_SEARCH;

                // Send a message to the client.
                PrintToChat(client, "%s Enter the name of the skin you would like.", PREFIX);
            } else if(StrEqual(info, "random", true)) {
                // Get a random skin from the database.
                Backend_RandomSkin(client);
            } else if(StrEqual(info, "default", true)) {
                // Remove the weapon from the map.
                g_smPlayerItems[client].Remove(g_cLoadoutWeapon[client]);

                // Send a message to the client.
                PrintToChat(client, "%s Removing skin from \x07%t\x01.", PREFIX, g_cLoadoutWeapon[client]);

                // Refresh the weapon.
                Skins_Refresh(client, g_cLoadoutWeapon[client]);
            } else {
                if(strlen(info) != 1) {
                    return;
                }

                // Search the database using the letter categories.
                Backend_SearchSkins(client, info);
            }
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

public int Callback_SkinsSkinMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            char displayName[64];
            menu.GetItem(itemNum, info, sizeof(info), _, displayName, sizeof(displayName));

            // Get the client's item.
            Item item = null;
            if(!g_smPlayerItems[client].GetValue(g_cLoadoutWeapon[client], item)) {
                item = new Item();
                item.SetDefaults(client, g_cLoadoutWeapon[client]);
                g_smPlayerItems[client].SetValue(g_cLoadoutWeapon[client], item);
            }

            // Update the item's skin.
            item.SetSkinID(info);

            // Send a message to the client.
            PrintToChat(client, "%s Applying \x10%s\x01 to \x07%t\x01.", PREFIX, displayName, g_cLoadoutWeapon[client]);

            // Refresh the client's weapon.
            Skins_Refresh(client, g_cLoadoutWeapon[client]);

            // Redisplay the menu.
            g_mFilterMenus[client].DisplayAt(client, GetMenuSelectionPosition(), 0);
        }

        case MenuAction_Cancel: {
            if(itemNum == MenuCancel_ExitBack) {
                Skins_FilterMenu(client);
            }
        }

        case MenuAction_End: {
            //delete menu;
        }
    }
}
