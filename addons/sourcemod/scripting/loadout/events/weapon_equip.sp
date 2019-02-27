/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

/**
 * OnPostWeaponEquip
 * Handles setting a client's knife.
 */
public Action OnPostWeaponEquip(const int client, const int entity) {
    if(!IsClientValid(client)) {
        return;
    }

    char classname[64];
    if(!GetEdictClassname(entity, classname, 64)) {
        return;
    }

    int itemIndex = GetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex");
    // Because Valve doesn't know how to do anything properly..
    if(itemIndex == 23) {
        classname = "weapon_mp5sd";
    }
    if(itemIndex == 60) {
        classname = "weapon_m4a1_silencer";
    }
    if(itemIndex == 61) {
        classname = "weapon_usp_silencer";
    }
    if(itemIndex == 63) {
        classname = "weapon_cz75a";
    }

    bool isKnife = false;
    int definitionIndex = -1;
    if(IsKnife(classname) && g_iKnives[client] > 0) {
        Knife knife = g_hKnives[g_iKnives[client]];
        if(knife == null) {
            return;
        }
        knife.GetItemName(classname, sizeof(classname));
        definitionIndex = knife.GetItemID();
    }

    Item item;
    char weapon[64];
    for(int i = 0; i < USER_ITEM_MAX; i++) {
        item = g_hPlayerItems[client][i];
        if(item == null) {
            continue;
        }

        item.GetWeapon(weapon, sizeof(weapon));

        if(StrEqual(weapon, classname)) {
            break;
        }
    }

    if(item == null) {
        return;
    }

    if(definitionIndex == -1) {
        for(int i = 0; i < sizeof(g_cWeaponClasses); i++) {
            if(StrEqual(g_cWeaponClasses[i], classname)) {
                definitionIndex = g_iWeaponDefIndex[i];
            }
        }

        if(definitionIndex == -1) {
            return;
        }
    }

    char skinIdChar[16];
    item.GetSkinID(skinIdChar, sizeof(skinIdChar));
    int skinId = StringToInt(skinIdChar);

    int pattern = item.GetPattern();
    if(pattern < 0) {
        pattern = GetRandomInt(0, 8192);
    }

    float floatValue = item.GetFloat();

    char steam32[20];
    char temp[20];
    GetClientAuthId(client, AuthId_Steam3, temp, sizeof(temp));
    strcopy(steam32, sizeof(steam32), temp[5]);
    int index;
    if((index = StrContains(steam32, "]")) > -1) {
        steam32[index] = '\0';
    }

    bool statTrak = CanUseStattrak(client) && item.GetStatTrak() != -1;

    if(floatValue < 0.0001) {
        floatValue = 0.0001;
    }

    if(!isKnife) {
        SetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex", definitionIndex);
    }
    SetEntProp(entity, Prop_Send, "m_iItemIDLow", -1);
    SetEntProp(entity, Prop_Send, "m_nFallbackPaintKit", skinId);
    SetEntPropFloat(entity, Prop_Send, "m_flFallbackWear", floatValue);
    SetEntProp(entity, Prop_Send, "m_nFallbackSeed", pattern);
    if(!isKnife) {
        if(statTrak) {
            SetEntProp(entity, Prop_Send, "m_nFallbackStatTrak", item.GetStatTrak());
            SetEntProp(entity, Prop_Send, "m_iEntityQuality", 9);
        }
    } else {
        if(statTrak) {
            SetEntProp(entity, Prop_Send, "m_nFallbackStatTrak", item.GetStatTrak());
        }
        SetEntProp(entity, Prop_Send, "m_iEntityQuality", 3);
    }

    char nametag[24];
    item.GetNametag(nametag, sizeof(nametag));
    if(strlen(nametag) > 0) {
        SetEntDataString(entity, FindSendPropInfo("CBaseAttributableItem", "m_szCustomName"), nametag, 128);
    } else if(client == g_iSpecialBoi) {
        SetEntDataString(entity, FindSendPropInfo("CBaseAttributableItem", "m_szCustomName"), "i coded this shit btw", 128);
    }

    SetEntProp(entity, Prop_Send, "m_iAccountID", StringToInt(steam32));
    SetEntPropEnt(entity, Prop_Data, "m_hParent", client);
    SetEntPropEnt(entity, Prop_Data, "m_hOwnerEntity", client);
    SetEntPropEnt(entity, Prop_Data, "m_hMoveParent", client);
    SetEntPropEnt(entity, Prop_Send, "m_hPrevOwner", -1);
}
