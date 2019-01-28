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

        Format(item, sizeof(item), "%i", knife.GetItemID());
        menu.AddItem(item, name, g_iKnives[client] == knife.GetItemID() ? ITEMDRAW_DISABLED : ITEMDRAW_DEFAULT);
	}

    menu.Display(client, 0);
}

int Callback_KnivesMenu(Menu menu, MenuAction action, int client, int itemNum) {
    switch(action) {
        case MenuAction_Select: {
            char info[32];
            menu.GetItem(itemNum, info, sizeof(info));

            g_iKnives[client] = StringToInt(info);
            g_mPlayerSkins[client].SetString("plugin_knife", info, true);

            Knives_Refresh(client);
            Knives_Menu(client);
        }

        case MenuAction_End: {
            delete menu;
        }
    }
}

void Knives_Refresh(int client) {
    if(!IsPlayerAlive(client)) {
        return;
    }

    int entity = GetPlayerWeaponSlot(client, CS_SLOT_KNIFE);
    if(entity == -1) {
        return;
    }

    RemovePlayerItem(client, entity);
    AcceptEntityInput(entity, "Kill");
    GivePlayerItem(client, "weapon_knife");
}
