/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

/**
 * Knives_Refresh
 * Refreshes a client's knife.
 */
public void Knives_Refresh(const int client) {
    if(!IsClientValid(client)) {
        return;
    }

    if(!IsPlayerAlive(client)) {
        return;
    }

    int entity = GetPlayerWeaponSlot(client, CS_SLOT_KNIFE);

    while(entity > 0) {
        RemovePlayerItem(client, entity);
        AcceptEntityInput(entity, "Kill");
        entity = GetPlayerWeaponSlot(client, CS_SLOT_KNIFE);
    }

    entity = GivePlayerItem(client, "weapon_knife");
    EquipPlayerWeapon(client, entity);
}
