/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

public void Knives_Menu(int client) {
    Menu menu = CreateMenu(Callback_KnivesMenu);
    menu.SetTitle("Knives");

    char item[4];
    char name[64];
    for(int i = 0; i <= KNIFE_MAX; i++) {
        Knife knife = g_hKnives[i];
        if(knife == null) {
            continue;
        }

        knife.GetName(name, sizeof(name));

        Format(item, sizeof(item), "%i", knife.GetID());
        menu.AddItem(item, name, g_iKnives[client] == knife.GetID() ? ITEMDRAW_DISABLED : ITEMDRAW_DEFAULT);
	}

    menu.Display(client, 0);
}

int Callback_KnivesMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            menu.GetItem(itemNum, info, sizeof(info));

            Knife knife = g_hKnives[StringToInt(info)];
            if(knife == null) {
                return;
            }

            g_iKnives[client] = knife.GetID();
            g_mPlayerSkins[client].SetString("plugin_knife", info, true);

            char itemName[64];
            knife.GetItemName(itemName, sizeof(itemName));

            Knives_Refresh(client, itemName);
            Knives_Menu(client);
        }

        case MenuAction_End: {
            delete menu;
        }
    }
}

void Knives_Refresh(int client, const char[] itemName) {
    if(!IsPlayerAlive(client)) {
        return;
    }

    int entity = GetPlayerWeaponSlot(client, CS_SLOT_KNIFE);
    if(entity == -1) {
        return;
    }

    RemovePlayerItem(client, entity);
    AcceptEntityInput(entity, "KillHierarchy");
    int item = GivePlayerItem(client, itemName);
    EquipPlayerWeapon(client, item);
}
