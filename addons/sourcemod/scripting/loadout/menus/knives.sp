/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

void Knives_Menu(const int client, const int position = -1) {
    Menu menu = CreateMenu(Callback_KnivesMenu);
    menu.SetTitle("Knives");

    char item[4];
    char name[64];
    for(int i = 0; i < KNIFE_MAX; i++) {
        Knife knife = g_hKnives[i];
        if(knife == null) {
            continue;
        }

        knife.GetName(name, sizeof(name));

        Format(item, sizeof(item), "%i", knife.GetID());
        menu.AddItem(item, name, g_iKnives[client] == knife.GetID() ? ITEMDRAW_DISABLED : ITEMDRAW_DEFAULT);
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

            char itemName[64];
            knife.GetItemName(itemName, sizeof(itemName));

            PrintToChat(client, "%s Setting your knife to \x10%t\x01.", PREFIX, itemName);
            Knives_Refresh(client, itemName);
            Knives_Menu(client, GetMenuSelectionPosition());
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

void Knives_Refresh(const int client, const char[] itemName) {
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
