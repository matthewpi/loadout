/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

public void Skins_Menu(const int client) {
    Menu menu = CreateMenu(Callback_SkinsMenu, MENU_ACTIONS_DEFAULT);
    menu.SetTitle("Skins");

    menu.AddItem("pistols", "Pistols");
    menu.AddItem("heavy", "Heavy");
    menu.AddItem("smg", "SMG");
    menu.AddItem("rifles", "Rifles");
    menu.AddItem("knives", "Knives");

    if(IsPlayerAlive(client)) {
        menu.AddItem("inventory", "Inventory");
    }

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
            } else if(StrEqual(info, "inventory")) {
                Skins_InventoryMenu(client);
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

void Skins_PistolMenu(const int client) {
    Menu menu = CreateMenu(Callback_SkinsWeaponMenu);
    menu.SetTitle("Pistols");

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

void Skins_HeavyMenu(const int client) {
    Menu menu = CreateMenu(Callback_SkinsWeaponMenu);
    menu.SetTitle("Heavy");

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

void Skins_SMGMenu(const int client) {
    Menu menu = CreateMenu(Callback_SkinsWeaponMenu);
    menu.SetTitle("SMG");

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

void Skins_RifleMenu(const int client) {
    Menu menu = CreateMenu(Callback_SkinsWeaponMenu);
    menu.SetTitle("Rifles");

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

void Skins_KnifeMenu(const int client) {
    Menu menu = CreateMenu(Callback_SkinsWeaponMenu);
    menu.SetTitle("Knives");

    char name[64];
    char itemName[64];
    for(int i = 0; i < KNIFE_MAX; i++) {
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

void Skins_InventoryMenu(const int client) {
    Menu menu = CreateMenu(Callback_SkinsWeaponMenu);
    menu.SetTitle("Inventory");

    int size = GetEntPropArraySize(client, Prop_Send, "m_hMyWeapons");

    char weaponClass[32];
    char weaponName[32];
    for(int i = 0; i < size; i++) {
        int entity = GetEntPropEnt(client, Prop_Send, "m_hMyWeapons", i);

        if(entity != -1 && GetWeaponClass(entity, weaponClass, sizeof(weaponClass))) {
            Format(weaponName, sizeof(weaponName), "%T", weaponClass, client);
            menu.AddItem(weaponClass, weaponName, (StrContains(weaponClass, "weapon_knife") != -1 && g_iKnives[client] == 0) ? ITEMDRAW_DISABLED : ITEMDRAW_DEFAULT);
        }
    }

    menu.ExitBackButton = true;
    menu.Display(client, 0);
}

int Callback_SkinsWeaponMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            menu.GetItem(itemNum, info, sizeof(info));

            g_cSkinWeapon[client] = info;
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
    //menu.AddItem("random", "Random");
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
                g_bSkinSearch[client] = true;
                PrintToChat(client, "%s Enter the name of the skin you would like.", PREFIX);
            } else if(StrEqual(info, "random", true)) {
                Backend_RandomSkin(client);
            } else if(StrEqual(info, "default", true)) {
                int i;
                Item item;
                char weapon[64];
                for(i = 0; i < USER_ITEM_MAX; i++) {
                    item = g_hPlayerItems[client][i];
                    if(item == null) {
                        continue;
                    }

                    item.GetWeapon(weapon, sizeof(weapon));

                    if(StrEqual(weapon, g_cSkinWeapon[client])) {
                        break;
                    }
                }

                if(item == null) {
                    return 0;
                }

                PrintToChat(client, "%s Removing skin from \x07%t\x01.", PREFIX, g_cSkinWeapon[client]);
                g_hPlayerItems[client][i] = null;
                Skins_Refresh(client, g_cSkinWeapon[client]);
            } else {
                if(strlen(info) < 1 || strlen(info) > 24) {
                    return 0;
                }

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

    return 0;
}

public int Callback_SkinsSkinMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            char displayName[64];
            menu.GetItem(itemNum, info, sizeof(info), _, displayName, sizeof(displayName));

            int i;
            Item item;
            char weapon[64];
            int validItems = 0;
            for(i = 0; i < USER_ITEM_MAX; i++) {
                item = g_hPlayerItems[client][i];
                if(item == null) {
                    continue;
                }

                item.GetWeapon(weapon, sizeof(weapon));

                if(StrEqual(weapon, g_cSkinWeapon[client])) {
                    break;
                }

                validItems++;
            }

            if(item == null) {
                PrintToChat(client, "%s Creating a new item..", PREFIX);
                item = new Item();
                item.SetDefaults(client, g_cSkinWeapon[client]);
                i = validItems + 1;
            }

            // Update the item's skin.
            item.SetSkinID(info);

            // Update the "g_hPlayerItems" array.
            g_hPlayerItems[client][i] = item;

            // Send a message to the client.
            PrintToChat(client, "%s Applying \x10%s\x01 to \x07%t\x01.", PREFIX, displayName, g_cSkinWeapon[client]);

            // Refresh the client's weapon.
            Skins_Refresh(client, g_cSkinWeapon[client]);

            // Redisplay the menu.
            g_hSkinMenus[client].DisplayAt(client, GetMenuSelectionPosition(), 0);
        }

        case MenuAction_Cancel: {
            if(itemNum == MenuCancel_ExitBack) {
                Skins_Menu(client);
            }
        }

        case MenuAction_End: {
            //delete menu;
        }
    }
}

public void Skins_Refresh(const int client, const char[] weapon) {
    if(IsKnife(weapon)) {
        #if defined LOADOUT_DEBUG
            LogMessage("%s (Debug) Skins_Refresh(): item is a knife, using Knives_Refresh().", CONSOLE_PREFIX);
        #endif
        Knives_Refresh(client, weapon);
        return;
    }

    int size = GetEntPropArraySize(client, Prop_Send, "m_hMyWeapons");

    char weaponClass[64];
    for(int i = 0; i < size; i++) {
        int entity = GetEntPropEnt(client, Prop_Send, "m_hMyWeapons", i);

        if(entity == -1 || !GetWeaponClass(entity, weaponClass, sizeof(weaponClass))) {
            continue;
        }

        if(!StrEqual(weapon, weaponClass)) {
            continue;
        }

        bool isKnife = IsKnife(weapon);

        int offset = -1;
        int ammo = -1;
        int clip = -1;
        int reserve = -1;

        if(!isKnife) {
            offset = FindDataMapInfo(client, "m_iAmmo") + (GetEntProp(entity, Prop_Data, "m_iPrimaryAmmoType") * 4);
            ammo = GetEntData(client, offset);
            clip = GetEntProp(entity, Prop_Send, "m_iClip1");
            reserve = GetEntProp(entity, Prop_Send, "m_iPrimaryReserveAmmoCount");
        }

        RemovePlayerItem(client, entity);
        AcceptEntityInput(entity, "KillHierarchy");

        if(isKnife) {
            GivePlayerItem(client, "weapon_knife");
        } else {
            entity = GivePlayerItem(client, weaponClass);

            if(clip != -1) {
                SetEntProp(entity, Prop_Send, "m_iClip1", clip);
            }

            if(reserve != -1) {
                SetEntProp(entity, Prop_Send, "m_iPrimaryReserveAmmoCount", reserve);
            }

            if(offset != -1 && ammo != -1) {
                DataPack pack;
                CreateDataTimer(0.1, Timer_WeaponAmmo, pack);
                pack.WriteCell(client);
                pack.WriteCell(offset);
                pack.WriteCell(ammo);
            }

            EquipPlayerWeapon(client, entity);
        }
        break;
    }
}

void Skins_RefreshAll(const int client) {
    int size = GetEntPropArraySize(client, Prop_Send, "m_hMyWeapons");

    char weaponClass[64];
    for(int i = 0; i < size; i++) {
        int entity = GetEntPropEnt(client, Prop_Send, "m_hMyWeapons", i);

        if(entity == -1 || !GetWeaponClass(entity, weaponClass, sizeof(weaponClass))) {
            continue;
        }

        if(IsKnife(weaponClass)) {
            continue;
        }

        char weapon[64];
        bool matched = false;
        for(int j = 0; j < USER_ITEM_MAX; j++) {
            Item item = g_hPlayerItems[client][j];
            if(item == null) {
                continue;
            }

            item.GetWeapon(weapon, sizeof(weapon));

            if(StrEqual(weapon, weaponClass)) {
                matched = true;
            }
        }

        if(!matched) {
            continue;
        }

        int offset = FindDataMapInfo(client, "m_iAmmo") + (GetEntProp(entity, Prop_Data, "m_iPrimaryAmmoType") * 4);
        int ammo = GetEntData(client, offset);
        int clip = GetEntProp(entity, Prop_Send, "m_iClip1");
        int reserve = GetEntProp(entity, Prop_Send, "m_iPrimaryReserveAmmoCount");

        RemovePlayerItem(client, entity);
        AcceptEntityInput(entity, "KillHierarchy");

        entity = GivePlayerItem(client, weaponClass);

        if(clip != -1) {
            SetEntProp(entity, Prop_Send, "m_iClip1", clip);
        }

        if(reserve != -1) {
            SetEntProp(entity, Prop_Send, "m_iPrimaryReserveAmmoCount", reserve);
        }

        if(offset != -1 && ammo != -1) {
            DataPack pack;
            CreateDataTimer(0.1, Timer_WeaponAmmo, pack);
            pack.WriteCell(client);
            pack.WriteCell(offset);
            pack.WriteCell(ammo);
        }
    }
}

static Action Timer_WeaponAmmo(Handle timer, DataPack pack) {
    ResetPack(pack);

    int client = pack.ReadCell();
    int offset = pack.ReadCell();
    int ammo = pack.ReadCell();

    if(IsClientValid(client) && IsPlayerAlive(client)) {
        SetEntData(client, offset, ammo, 4, true);
    }
}
