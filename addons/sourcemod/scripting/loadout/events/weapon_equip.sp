/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

/**
 * OnPostWeaponEquip
 * Handles setting a client's knife.
 */
public Action OnPostWeaponEquip(const int client, const int entity) {
    // Check if the client is invalid.
    if(!IsClientValid(client)) {
        return;
    }

    // Get the entity's classname.
    char classname[64];
    if(!GetEdictClassname(entity, classname, 64)) {
        return;
    }

    // Get the entity's definition index;
    int itemIndex = GetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex");

    // Because Valve doesn't know how to do anything properly..
    if(itemIndex == 23) {
        classname = "weapon_mp5sd";
    } else if(itemIndex == 60) {
        classname = "weapon_m4a1_silencer";
    } else if(itemIndex == 61) {
        classname = "weapon_usp_silencer";
    } else if(itemIndex == 63) {
        classname = "weapon_cz75a";
    }

    // Check if the item is a knife.
    bool isKnife = false;
    int definitionIndex = -1;
    if(IsKnife(classname) && g_iKnives[client] > 0) {
        Knife knife = g_hKnives[g_iKnives[client]];

        // Check if the knife item is null.
        if(knife == null) {
            return;
        }

        // Get the knife's classname.
        knife.GetItemName(classname, sizeof(classname));

        // Get the knife's definition index.
        definitionIndex = knife.GetItemID();

        // Update the isKnife variable.
        isKnife = true;
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

    if(!isKnife && item == null) {
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

    int skinId = 0;
    int pattern = 0;
    float floatValue = 0.0001;
    bool statTrak = false;
    if(item != null) {
        char skinIdChar[16];
        item.GetSkinID(skinIdChar, sizeof(skinIdChar));
        skinId = StringToInt(skinIdChar);

        // Get the item's pattern.
        pattern = item.GetPattern();

        // Check if the item wants a random pattern.
        if(pattern < 1) {
            pattern = GetRandomInt(0, 8192);
        }

        floatValue = item.GetFloat();

        statTrak = CanUseStattrak(client) && item.GetStatTrak() != -1;

        // Make sure the float value is not below the configured minimum.
        if(floatValue < 0.0001) {
            floatValue = 0.0001;
        }
    }

    char steam32[20];
    char temp[20];
    GetClientAuthId(client, AuthId_Steam3, temp, sizeof(temp));
    strcopy(steam32, sizeof(steam32), temp[5]);
    int index;
    if((index = StrContains(steam32, "]")) > -1) {
        steam32[index] = '\0';
    }

    // Check if the item is not a knife.
    SetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex", definitionIndex);
    SetEntProp(entity, Prop_Send, "m_iItemIDLow", -1);

    if(item != null) {
        SetEntProp(entity, Prop_Send, "m_nFallbackPaintKit", skinId);
        SetEntPropFloat(entity, Prop_Send, "m_flFallbackWear", floatValue);
        SetEntProp(entity, Prop_Send, "m_nFallbackSeed", pattern);

        // Check if the item is not a knife.
        if(!isKnife) {
            // Check if stattrak is enabled.
            if(statTrak) {
                SetEntProp(entity, Prop_Send, "m_nFallbackStatTrak", item.GetStatTrak());
                SetEntProp(entity, Prop_Send, "m_iEntityQuality", 9);
            }
        } else if(statTrak) {
            SetEntProp(entity, Prop_Send, "m_nFallbackStatTrak", item.GetStatTrak());
        }
    }

    if(isKnife) {
        SetEntProp(entity, Prop_Send, "m_iEntityQuality", 3);
    }

    // Get the item's nametag.
    char nametag[24];

    if(item != null) {
        item.GetNametag(nametag, sizeof(nametag));
    }

    // Check if the item's nametag is set.
    if(strlen(nametag) > 0) {
        // Update the physical item's nametag.
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
