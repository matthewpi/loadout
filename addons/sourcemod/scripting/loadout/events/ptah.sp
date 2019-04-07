/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

/**
 * Event_GiveNamedItemPre
 * ?
 */
public Action Event_GiveNamedItemPre(int client, char classname[64], CEconItemView &item, bool &ignoredCEconItemView, bool &originIsNull, float origin[3]) {
    if(!IsClientValid(client)) {
        return Plugin_Continue;
    }

    if(g_iKnives[client] == 0) {
        return Plugin_Continue;
    }

    if(!IsKnife(classname)) {
        return Plugin_Continue;
    }

    Knife knife = g_hKnives[g_iKnives[client]];
    if(knife == null) {
        return Plugin_Continue;
    }

    ignoredCEconItemView = true;
    knife.GetItemName(classname, sizeof(classname));

    return Plugin_Changed;
}

/**
 * Event_GiveNamedItem
 * ?
 */
public void Event_GiveNamedItem(const int client, const char[] cn, const CEconItemView itemView, int entity, bool originIsNull, const float origin[3]) {
    // Check if the client is invalid.
    if(!IsClientValid(client)) {
        return;
    }

    // Check if the entity is invalid.
    if(!IsValidEntity(entity)) {
        return;
    }

    // Get the item's definition index.
    int itemIndex = GetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex");

    // Get the entity's classname.
    char classname[64];
    if(!ClassByDefIndex(itemIndex, classname, sizeof(classname))) {
        return;
    }

    // Get the user's item.
    Item item = null;
    if(!g_smPlayerItems[client].GetValue(classname, item)) {
        return;
    }

    // Get a boolean based off of if the entity is a knife.
    bool isItemKnife = IsKnife(classname);

    // Check if the item is a knife.
    if(isItemKnife) {
        // Equip the entity.
        EquipPlayerWeapon(client, entity);
    }

    // Get the client's steam 32 id.
    char steam32[20];
    char temp[64];
    GetClientAuthId(client, AuthId_Steam3, temp, sizeof(temp));
    strcopy(steam32, sizeof(steam32), temp[5]);
    int index;
    if((index = StrContains(steam32, "]")) > -1) {
        steam32[index] = '\0';
    }
    // END Get the client's steam 32 id.

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
        SetEntDataString(entity, FindSendPropInfo("CBaseAttributableItem", "m_szCustomName"), "i coded this shit btw", 128);
    }

    // Update the entity's properties.
    SetEntProp(entity, Prop_Send, "m_iAccountID", StringToInt(steam32));
    SetEntPropEnt(entity, Prop_Data, "m_hOwnerEntity", client);
    SetEntPropEnt(entity, Prop_Send, "m_hPrevOwner", client);
}

/**
 * Event_CanUseWeapon
 * ?
 */
public bool Event_CanUseWeapon(const int client, const int weapon, const bool pickup) {
    if(IsClientValid(client) && IsEntityKnife(weapon)) {
        #if defined LOADOUT_DEBUG
            //LogMessage("%s (Debug) Event_CanUseWeapon: true.", CONSOLE_PREFIX);
        #endif
        return true;
    }

    #if defined LOADOUT_DEBUG
        //LogMessage("%s (Debug) Event_CanUseWeapon: pickup. (%i)", CONSOLE_PREFIX, pickup);
    #endif
    return pickup;
}
