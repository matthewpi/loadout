/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

/**
 * Gloves_Refresh
 * ?
 */
public void Gloves_Refresh(const int client) {
    if(!IsClientValid(client)) {
        return;
    }

    if(!IsPlayerAlive(client)) {
        return;
    }

    if(g_iGloves[client] == 0) {
        int active = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
        if(active != -1) {
            SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", -1);
        }

        // Find existing gloves.
        int entity = GetEntPropEnt(client, Prop_Send, "m_hMyWearables");

        // Delete existing gloves.
        if(entity != -1) {
            AcceptEntityInput(entity, "KillHierarchy");
        }

        char armTemp[2];
        GetEntPropString(client, Prop_Send, "m_szArmsModel", armTemp, sizeof(armTemp));

        if(armTemp[0]) {
            SetEntPropString(client, Prop_Send, "m_szArmsModel", "");

            #if defined LOADOUT_DEBUG
                LogMessage("%s (Debug) Fixing arms for \"%N\".", CONSOLE_PREFIX, client);
            #endif
        }

        entity = CreateEntityByName("wearable_item");

        if(entity != -1) {
            SetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex", (GetClientTeam(client) == CS_TEAM_T ? 5028 : 5029));
            SetEntProp(entity, Prop_Send, "m_bInitialized", 1);
            SetEntPropEnt(entity, Prop_Data, "m_hParent", client);
            SetEntPropEnt(entity, Prop_Data, "m_hOwnerEntity", client);
            SetEntPropEnt(entity, Prop_Data, "m_hMoveParent", client);
            SetEntProp(client, Prop_Send, "m_nBody", 1);
            DispatchSpawn(entity);
            SetEntPropEnt(client, Prop_Send, "m_hMyWearables", entity);

            #if defined LOADOUT_DEBUG
                LogMessage("%s (Debug) Applied entity properties for \"%N\"'s gloves.", CONSOLE_PREFIX, client);
            #endif
        }

        #if defined LOADOUT_DEBUG
        else {
            LogMessage("%s (Debug) Failed to create \"wearable_item\" for \"%N\".", CONSOLE_PREFIX, client);
        }
        #endif

        if(active != -1) {
            DataPack pack;
            CreateDataTimer(0.1, Timer_Reactivate, pack);
            pack.WriteCell(client);
            pack.WriteCell(active);
        }
        return;
    }

    // Get the player's gloves.
    Glove glove = g_hGloves[g_iGloves[client]];
    if(glove == null) {
        return;
    }

    // Get the player's glove skin.
    GloveSkin skin = glove.GetSkin(g_iGloveSkins[client]);
    if(skin == null) {
        return;
    }

    int active = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
    if(active != -1) {
        SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", -1);
    }

    // Find existing gloves.
    int entity = GetEntPropEnt(client, Prop_Send, "m_hMyWearables");

    // Delete existing gloves.
    if(entity != -1) {
        AcceptEntityInput(entity, "KillHierarchy");
    }

    // Get the player's arms model.
    char armTemp[2];
    GetEntPropString(client, Prop_Send, "m_szArmsModel", armTemp, sizeof(armTemp));

    // Reapply the player's arms.
    if(armTemp[0]) {
        SetEntPropString(client, Prop_Send, "m_szArmsModel", "");

        #if defined LOADOUT_DEBUG
            LogMessage("%s (Debug) Fixing arms for \"%N\".", CONSOLE_PREFIX, client);
        #endif
    }

    entity = CreateEntityByName("wearable_item");

    if(entity != -1) {
        SetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex", glove.GetItemID());
        SetEntProp(entity, Prop_Send, "m_iItemIDLow", -1);
        SetEntProp(entity, Prop_Send, "m_nFallbackPaintKit", skin.GetPaintID());
        SetEntPropFloat(entity, Prop_Send, "m_flFallbackWear", 0.0001);
        SetEntProp(entity, Prop_Send, "m_nFallbackSeed", GetRandomInt(0, 8192));
        SetEntProp(entity, Prop_Send, "m_bInitialized", 1);
        SetEntPropEnt(entity, Prop_Data, "m_hParent", client);
        SetEntPropEnt(entity, Prop_Data, "m_hOwnerEntity", client);
        SetEntPropEnt(entity, Prop_Data, "m_hMoveParent", client);
        SetEntProp(client, Prop_Send, "m_nBody", 1);
        DispatchSpawn(entity);
        SetEntPropEnt(client, Prop_Send, "m_hMyWearables", entity);

        #if defined LOADOUT_DEBUG
            LogMessage("%s (Debug) Applied entity properties for \"%N\"'s gloves.", CONSOLE_PREFIX, client);
        #endif
    }

    #if defined LOADOUT_DEBUG
    else {
        LogMessage("%s (Debug) Failed to create \"wearable_item\" for \"%N\".", CONSOLE_PREFIX, client);
    }
    #endif

    // Check if the player has a weapon.
    if(active != -1) {
        DataPack pack;
        CreateDataTimer(0.1, Timer_Reactivate, pack);
        pack.WriteCell(client);
        pack.WriteCell(active);
    }
}

/**
 * Timer_Reactivate
 * Reactivates the player's weapon after gloves were applied.
 */
static Action Timer_Reactivate(Handle timer, DataPack pack) {
    int client;
    int active;

    pack.Reset();
    client = pack.ReadCell();
    active = pack.ReadCell();

    if(!IsClientInGame(client)) {
        return;
    }

    if(!IsPlayerAlive(client)) {
        return;
    }

    if(!IsValidEntity(active)) {
        return;
    }

    SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", active);

    #if defined LOADOUT_DEBUG
        LogMessage("%s (Debug) \"gloves.sp\": Reactivated \"%N\"'s weapon.", CONSOLE_PREFIX, client);
    #endif
}
