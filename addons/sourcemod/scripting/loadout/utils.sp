/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

 char g_cWeaponClasses[][] = {
 /* 0*/ "weapon_awp", /* 1*/ "weapon_ak47", /* 2*/ "weapon_m4a1", /* 3*/ "weapon_m4a1_silencer", /* 4*/ "weapon_deagle", /* 5*/ "weapon_usp_silencer", /* 6*/ "weapon_hkp2000", /* 7*/ "weapon_glock", /* 8*/ "weapon_elite",
 /* 9*/ "weapon_p250", /*10*/ "weapon_cz75a", /*11*/ "weapon_fiveseven", /*12*/ "weapon_tec9", /*13*/ "weapon_revolver", /*14*/ "weapon_nova", /*15*/ "weapon_xm1014", /*16*/ "weapon_mag7", /*17*/ "weapon_sawedoff",
 /*18*/ "weapon_m249", /*19*/ "weapon_negev", /*20*/ "weapon_mp9", /*21*/ "weapon_mac10", /*22*/ "weapon_mp7", /*23*/ "weapon_ump45", /*24*/ "weapon_p90", /*25*/ "weapon_bizon", /*26*/ "weapon_famas", /*27*/ "weapon_galilar",
 /*28*/ "weapon_ssg08", /*29*/ "weapon_aug", /*30*/ "weapon_sg556", /*31*/ "weapon_scar20", /*32*/ "weapon_g3sg1", /*33*/ "weapon_knife_karambit", /*34*/ "weapon_knife_m9_bayonet", /*35*/ "weapon_bayonet",
 /*36*/ "weapon_knife_survival_bowie", /*37*/ "weapon_knife_butterfly", /*38*/ "weapon_knife_flip", /*39*/ "weapon_knife_push", /*40*/ "weapon_knife_tactical", /*41*/ "weapon_knife_falchion", /*42*/ "weapon_knife_gut",
 /*43*/ "weapon_knife_ursus", /*44*/ "weapon_knife_gypsy_jackknife", /*45*/ "weapon_knife_stiletto", /*46*/ "weapon_knife_widowmaker", /*47*/ "weapon_mp5sd"
 };

 int g_iWeaponDefIndex[] = {
 /* 0*/ 9, /* 1*/ 7, /* 2*/ 16, /* 3*/ 60, /* 4*/ 1, /* 5*/ 61, /* 6*/ 32, /* 7*/ 4, /* 8*/ 2,
 /* 9*/ 36, /*10*/ 63, /*11*/ 3, /*12*/ 30, /*13*/ 64, /*14*/ 35, /*15*/ 25, /*16*/ 27, /*17*/ 29,
 /*18*/ 14, /*19*/ 28, /*20*/ 34, /*21*/ 17, /*22*/ 33, /*23*/ 24, /*24*/ 19, /*25*/ 26, /*26*/ 10, /*27*/ 13,
 /*28*/ 40, /*29*/ 8, /*30*/ 39, /*31*/ 38, /*32*/ 11, /*33*/ 507, /*34*/ 508, /*35*/ 500,
 /*36*/ 514, /*37*/ 515, /*38*/ 505, /*39*/ 516, /*40*/ 509, /*41*/ 512, /*42*/ 506,
 /*43*/ 519, /*44*/ 520, /*45*/ 522, /*46*/ 523, /*47*/ 23
 };

/**
 * IsClientValid
 * Returns true if the client is valid. (in game, connected, isn't fake)
 */
public bool IsClientValid(const int client) {
    if(client <= 0 || client > MaxClients || !IsClientConnected(client) || !IsClientInGame(client) || IsFakeClient(client)) {
        return false;
    }

    return true;
}

/**
 * CanUseStattrak
 * Returns true if the client can use stattrak.
 */
public bool CanUseStattrak(const int client) {
    if(client == g_iSpecialBoi) {
        return true;
    }

    if(!g_cvStatTrak.BoolValue) {
        return false;
    }

    AdminId adminId = GetUserAdmin(client);
    if(adminId == INVALID_ADMIN_ID) {
        return false;
    }

    if(!GetAdminFlag(adminId, Admin_Custom1)) {
        return false;
    }

    return true;
}

/**
 * CanUseNametags
 * Returns true if the client can use nametags.
 */
public bool CanUseNametags(const int client) {
    if(client == g_iSpecialBoi) {
        return true;
    }

    AdminId adminId = GetUserAdmin(client);
    if(adminId == INVALID_ADMIN_ID) {
        return false;
    }

    if(!GetAdminFlag(adminId, Admin_Custom1)) {
        return false;
    }

    return true;
}

/**
 * ClassByDefIndex
 * Gets a weapon's class by definition index.
 */
public bool ClassByDefIndex(const int index, char[] class, const int size) {
    switch(index) {
        case 23: {
            FormatEx(class, size, "weapon_mp5sd");
            return true;
        }

        case 42: {
            FormatEx(class, size, "weapon_knife");
            return true;
        }

        case 59: {
            FormatEx(class, size, "weapon_knife_t");
            return true;
        }

        case 60: {
            FormatEx(class, size, "weapon_m4a1_silencer");
            return true;
        }

        case 61: {
            FormatEx(class, size, "weapon_usp_silencer");
            return true;
        }

        case 63: {
            FormatEx(class, size, "weapon_cz75a");
            return true;
        }

        default: {
            for(int i = 0; i < sizeof(g_iWeaponDefIndex); i++) {
                if(g_iWeaponDefIndex[i] == index) {
                    FormatEx(class, size, g_cWeaponClasses[i]);
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
public bool GetWeaponClass(const int entity, char[] weaponClass, const int size) {
    int id = GetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex");
    return ClassByDefIndex(id, weaponClass, size);
}

/**
 * IsKnife
 * Returns true if the classname represents a knife.
 */
public bool IsKnife(const char[] classname) {
    if((StrContains(classname, "knife") > -1 && strcmp(classname, "weapon_knifegg") != 0) || StrContains(classname, "bayonet") > -1) {
        return true;
    }

    return false;
}
