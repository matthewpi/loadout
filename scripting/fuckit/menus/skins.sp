/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

public void Skins_Menu(int client) {
    Menu menu = CreateMenu(Callback_SkinsMenu, MENU_ACTIONS_DEFAULT);
    menu.SetTitle("FuckIt Skins");

    menu.AddItem("pistols", "Pistols");
    menu.AddItem("heavy", "Heavy");
    menu.AddItem("smg", "SMG");
    menu.AddItem("rifles", "Rifles");

    if(IsPlayerAlive(client)) {
        menu.AddItem("", "", ITEMDRAW_SPACER);
        menu.AddItem("inventory", "Inventory");
    }

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
            } else if(StrEqual(info, "inventory")) {
                Skins_InventoryMenu(client);
            }
        }

        case MenuAction_End: {
            delete menu;
        }
    }
}

void Skins_PistolMenu(int client) {
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

void Skins_HeavyMenu(int client) {
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

void Skins_SMGMenu(int client) {
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

void Skins_RifleMenu(int client) {
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

void Skins_InventoryMenu(int client) {
    Menu menu = CreateMenu(Callback_SkinsWeaponMenu);
    menu.SetTitle("Inventory");

    int size = GetEntPropArraySize(client, Prop_Send, "m_hMyWeapons");

    char weaponClass[32];
    char weaponName[32];
    for(int i = 0; i < size; i++) {
        int entity = GetEntPropEnt(client, Prop_Send, "m_hMyWeapons", i);

        if(entity != -1 && GetWeaponClass(entity, weaponClass, sizeof(weaponClass))) {
            Format(weaponName, sizeof(weaponName), "%T", weaponClass, client);
            menu.AddItem(weaponClass, weaponName, (StrContains(weaponClass, "weapon_knife") && g_iKnives[client] == 0) ? ITEMDRAW_DISABLED : ITEMDRAW_DEFAULT);
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

void Skins_FilterMenu(int client) {
    Menu menu = CreateMenu(Callback_SkinsFilterMenu);
    menu.SetTitle("Skin Filter");

    menu.AddItem("search", "Search..");

    char alphabet[26][1] = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" };
    for(int i = 0; i < sizeof(alphabet); i++) {
        menu.AddItem(alphabet[i], alphabet[i]);
    }

    menu.ExitBackButton = true;
    menu.Display(client, 0);
}

int Callback_SkinsFilterMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            menu.GetItem(itemNum, info, sizeof(info));

            if(StrEqual(info, "search", true)) {
                g_bSkinSearch[client] = true;
                PrintToChat(client, "%s Enter the name of the skin you would like.", PREFIX);
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

int Callback_SkinsSkinMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            menu.GetItem(itemNum, info, sizeof(info));

            g_mPlayerSkins[client].SetValue(g_cSkinWeapon[client], StringToInt(info), true);
            Skins_Refresh(client, g_cSkinWeapon[client]);
            g_hSkinMenus[client].Display(client, 0);
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

void Skins_Refresh(int client, const char[] weapon) {
    int size = GetEntPropArraySize(client, Prop_Send, "m_hMyWeapons");

    char weaponClass[32];
    for(int i = 0; i < size; i++) {
        int entity = GetEntPropEnt(client, Prop_Send, "m_hMyWeapons", i);

        if(entity == -1 || !GetWeaponClass(entity, weaponClass, sizeof(weaponClass))) {
            continue;
        }

        if(!StrEqual(weapon, weaponClass)) {
            continue;
        }

        RemovePlayerItem(client, entity);
        AcceptEntityInput(entity, "Kill");

        if(StrContains(weapon, "weapon_knife") != -1) {
            GivePlayerItem(client, "weapon_knife");
        } else {
            GivePlayerItem(client, weapon);
        }
    }
}
