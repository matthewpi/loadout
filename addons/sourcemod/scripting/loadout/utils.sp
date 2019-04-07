/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

/**
 * IsClientValid
 * Returns true if the client is valid. (in game, connected, isn't fake)
 */
stock bool IsClientValid(const int client) {
    if(client <= 0 || client > MaxClients || !IsClientConnected(client) || !IsClientInGame(client) || IsFakeClient(client)) {
        return false;
    }

    return true;
}

/**
 * CanUse
 * Underlying logic for all "CanUse" functions.
 */
static bool CanUse(const int client, const ConVar convar, const ConVar flagConvar) {
    // Check if stattrak is disabled.
    if(!convar.BoolValue) {
        return false;
    }

    // Special Boi :^)
    if(client == g_iSpecialBoi) {
        return true;
    }

    // Get the client's adminId.
    AdminId adminId = GetUserAdmin(client);
    if(adminId == INVALID_ADMIN_ID) {
        return false;
    }

    // Get the admin flag convar value.
    char buffer[2];
    flagConvar.GetString(buffer, sizeof(buffer));

    // Check if the flag is enabled.
    if(!StrEqual(buffer, "-", true)) {
        // Get the admin flag from the convar.
        AdminFlag flag;
        if(!FindFlagByChar(buffer[0], flag)) {
            char name[64];
            flagConvar.GetName(name, sizeof(name));

            LogMessage("%s Failed to get admin flag from \"%s\".", CONSOLE_PREFIX, name);
            return false;
        }

        // Check if the client does not have the flag.
        if(!GetAdminFlag(adminId, flag)) {
            return false;
        }
    }

    return true;
}

/**
 * CanUsePatterns
 * Returns true if the client can use custom patterns.
 */
stock bool CanUsePatterns(const int client) {
    return CanUse(client, g_cvPatterns, g_cvPatternsFlag);
}

/**
 * CanUseFloats
 * Returns true if the client can use custom floats.
 */
stock bool CanUseFloats(const int client) {
    return CanUse(client, g_cvFloats, g_cvFloatsFlag);
}

/**
 * CanUseStattrak
 * Returns true if the client can use stattrak.
 */
stock bool CanUseStattrak(const int client) {
    return CanUse(client, g_cvStatTrak, g_cvStatTrakFlag);
}

/**
 * CanUseNametags
 * Returns true if the client can use custom nametags.
 */
stock bool CanUseNametags(const int client) {
    return CanUse(client, g_cvNametags, g_cvNametagsFlag);
}

/**
 * ClassByDefIndex
 * Gets a weapon's class by definition index.
 */
stock bool ClassByDefIndex(const int index, char[] buffer, const int maxlen) {
    switch(index) {
        case 23: {
            FormatEx(buffer, maxlen, "weapon_mp5sd");
            return true;
        }

        case 42: {
            FormatEx(buffer, maxlen, "weapon_knife");
            return true;
        }

        case 59: {
            FormatEx(buffer, maxlen, "weapon_knife_t");
            return true;
        }

        case 60: {
            FormatEx(buffer, maxlen, "weapon_m4a1_silencer");
            return true;
        }

        case 61: {
            FormatEx(buffer, maxlen, "weapon_usp_silencer");
            return true;
        }

        case 63: {
            FormatEx(buffer, maxlen, "weapon_cz75a");
            return true;
        }

        case 64: {
            FormatEx(buffer, maxlen, "weapon_revolver");
            return true;
        }

        default: {
            for(int i = 0; i < sizeof(g_iWeaponDefIndex); i++) {
                if(g_iWeaponDefIndex[i] == index) {
                    FormatEx(buffer, maxlen, g_cWeaponClasses[i]);
                    return true;
                }
            }
        }
    }

    return false;
}

/**
 * GetWeaponClass
 * Gets a entity's weapon class.
 */
stock bool GetWeaponClass(const int entity, char[] buffer, const int maxlen) {
    int id = GetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex");
    return ClassByDefIndex(id, buffer, maxlen);
}

/**
 * IsKnife
 * Returns true if the classname represents a knife.
 */
stock bool IsKnife(const char[] classname) {
    if((StrContains(classname, "knife") > -1 && strcmp(classname, "weapon_knifegg") != 0) || StrContains(classname, "bayonet") > -1) {
        return true;
    }

    return false;
}

/**
 * IsEntityKnife
 * ?
 */
stock bool IsEntityKnife(const int entity) {
    char classname[64];

    if(!GetWeaponClass(entity, classname, sizeof(classname))) {
        return false;
    }

    return IsKnife(classname);
}

/**
 * GetWeaponIndex
 * ?
 */
stock int GetWeaponIndex(const int entity) {
    char classname[64];

    if(!GetWeaponClass(entity, classname, sizeof(classname))) {
        return -1;
    }

    int index;
    if(!g_smWeaponIndex.GetValue(classname, index)) {
        return -1;
    }

    return index;
}
