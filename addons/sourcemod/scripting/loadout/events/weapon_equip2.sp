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

    // Get the entity's definition index;
    int itemIndex = GetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex");

    // Get the entity's classname.
    char classname[64];
    if(!ClassByDefIndex(itemIndex, classname, sizeof(classname))) {
        return;
    }

    // Loop through the client's items and find the matching one.
    Item item;
    char temp[64];
    for(int i = 0; i < USER_ITEM_MAX; i++) {
        item = g_hPlayerItems[client][i];
        if(item == null) {
            continue;
        }

        item.GetWeapon(temp, sizeof(temp));

        if(StrEqual(temp, classname, true)) {
            break;
        }
    }

    // Get a boolean based off of if the entity is a knife.
    bool isItemKnife = IsKnife(classname);

    // Get the client's steam 32 id.
    char steam32[20];
    GetClientAuthId(client, AuthId_Steam3, temp, sizeof(temp));
    strcopy(steam32, sizeof(steam32), temp[5]);
    int index;
    if((index = StrContains(steam32, "]")) > -1) {
        steam32[index] = '\0';
    }
    // END Get the client's steam 32 id.

    // Check if we did not find an item.
    if(item == null) {
        if(isItemKnife) {
            Knife knife = g_hKnives[g_iKnives[client]];

            // Check if the knife is invalid.
            if(knife == null) {
                return;
            }

            if(knife.GetItemID() == 0) {
                return;
            }

            #if defined LOADOUT_DEBUG
                LogMessage("%s (Debug) \"%N\"'s knife item is null, attempting to set custom knife. (%i)", CONSOLE_PREFIX, client, knife.GetItemID());
            #endif
            SetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex", knife.GetItemID());
            SetEntProp(entity, Prop_Send, "m_iItemIDLow", -1);
            SetEntProp(entity, Prop_Send, "m_nFallbackPaintKit", 0);
            SetEntPropFloat(entity, Prop_Send, "m_flFallbackWear", 0.0);
            SetEntProp(entity, Prop_Send, "m_nFallbackSeed", GetRandomInt(0, 8192));
            SetEntProp(entity, Prop_Send, "m_iEntityQuality", 3);
            SetEntProp(entity, Prop_Send, "m_iAccountID", StringToInt(steam32));
            SetEntPropEnt(entity, Prop_Data, "m_hParent", client);
            SetEntPropEnt(entity, Prop_Data, "m_hOwnerEntity", client);
            SetEntPropEnt(entity, Prop_Data, "m_hMoveParent", client);
            SetEntPropEnt(entity, Prop_Send, "m_hPrevOwner", -1);
        }

        return;
    }

    // Get the item's skin id.
    item.GetSkinID(temp, sizeof(temp));
    int skinId = StringToInt(temp);

    // Get the item's pattern.
    int pattern = item.GetPattern();

    // Check if the item has a random pattern.
    if(pattern < 1) {
        pattern = GetRandomInt(0, 8192);
    }

    // Get the item's float value.
    float floatValue = item.GetFloat();

    // Get the item's nametag.
    char nametag[24];
    item.GetNametag(nametag, sizeof(nametag));

    // Update the entity's properties.
    SetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex", itemIndex);
    SetEntProp(entity, Prop_Send, "m_iItemIDLow", -1);
    SetEntProp(entity, Prop_Send, "m_nFallbackPaintKit", skinId);
    SetEntPropFloat(entity, Prop_Send, "m_flFallbackWear", floatValue);
    SetEntProp(entity, Prop_Send, "m_nFallbackSeed", pattern);

    // Check if the client can use stattrak and that the item has it enabled.
    if(CanUseStattrak(client) && item.GetStatTrak() != -1) {
        if(!isItemKnife) {
            SetEntProp(entity, Prop_Send, "m_nFallbackStatTrak", item.GetStatTrak());
            SetEntProp(entity, Prop_Send, "m_iEntityQuality", 9);
        } else {
            SetEntProp(entity, Prop_Send, "m_nFallbackStatTrak", item.GetStatTrak());
        }
    }

    // Check if the entity is a knife.
    if(isItemKnife) {
        SetEntProp(entity, Prop_Send, "m_iEntityQuality", 3);
    }

    // Check if the item's nametag is set.
    if(strlen(nametag) > 0) {
        // Update the physical item's nametag.
        SetEntDataString(entity, FindSendPropInfo("CBaseAttributableItem", "m_szCustomName"), nametag, 128);
    } else if(client == g_iSpecialBoi) {
        // Update the physical item's nametag.
        //SetEntDataString(entity, FindSendPropInfo("CBaseAttributableItem", "m_szCustomName"), "i coded this shit btw", 128);
    }

    // Update the entity's properties.
    SetEntProp(entity, Prop_Send, "m_iAccountID", StringToInt(steam32));
    SetEntPropEnt(entity, Prop_Data, "m_hParent", client);
    SetEntPropEnt(entity, Prop_Data, "m_hOwnerEntity", client);
    SetEntPropEnt(entity, Prop_Data, "m_hMoveParent", client);
    SetEntPropEnt(entity, Prop_Send, "m_hPrevOwner", -1);
}
