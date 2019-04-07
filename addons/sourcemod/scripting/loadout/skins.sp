/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

/**
 * Skins_Refresh
 * ?
 */
public void Skins_Refresh(const int client, const char[] weapon) {
    if(!IsClientValid(client)) {
        return;
    }

    if(!IsPlayerAlive(client)) {
        return;
    }

    // Check if the weapon is a knife.
    if(IsKnife(weapon)) {
        // Use the Knives_Refresh handler to refresh the knife.
        Knives_Refresh(client);
        return;
    }

    int size = GetEntPropArraySize(client, Prop_Send, "m_hMyWeapons");

    char weaponClass[64];
    for(int i = 0; i < size; i++) {
        int entity = GetEntPropEnt(client, Prop_Send, "m_hMyWeapons", i);

        // Check if the entity is invalid.
        if(entity == -1) {
            continue;
        }

        // Get the entity's classname.
        if(!GetWeaponClass(entity, weaponClass, sizeof(weaponClass))) {
            continue;
        }

        // Check if the entity's classname matches the one we want to refresh.
        if(!StrEqual(weapon, weaponClass)) {
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
        break;
    }
}

/**
 * Skins_RefreshAll
 * ?
 */
public void Skins_RefreshAll(const int client) {
    if(!IsClientValid(client)) {
        return;
    }

    if(!IsPlayerAlive(client)) {
        return;
    }

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

        Item item = null;
        if(!g_smPlayerItems[client].GetValue(weaponClass, item)) {
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

/**
 * Timer_WeaponAmmo
 * Resets weapon ammo on an entity.
 */
static Action Timer_WeaponAmmo(Handle timer, DataPack pack) {
    ResetPack(pack);

    int client = pack.ReadCell();
    int offset = pack.ReadCell();
    int ammo = pack.ReadCell();

    if(IsClientValid(client) && IsPlayerAlive(client)) {
        SetEntData(client, offset, ammo, 4, true);
    }
}
