/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

char g_cWeaponClasses[][] = {
    "weapon_awp",
    "weapon_ak47",
    "weapon_m4a1",
    "weapon_m4a1_silencer",
    "weapon_deagle",
    "weapon_usp_silencer",
    "weapon_hkp2000",
    "weapon_glock",
    "weapon_elite",
    "weapon_p250",
    "weapon_cz75a",
    "weapon_fiveseven",
    "weapon_tec9",
    "weapon_revolver",
    "weapon_nova",
    "weapon_xm1014",
    "weapon_mag7",
    "weapon_sawedoff",
    "weapon_m249",
    "weapon_negev",
    "weapon_mp9",
    "weapon_mac10",
    "weapon_mp7",
    "weapon_ump45",
    "weapon_p90",
    "weapon_bizon",
    "weapon_famas",
    "weapon_galilar",
    "weapon_ssg08",
    "weapon_aug",
    "weapon_sg556",
    "weapon_scar20",
    "weapon_g3sg1",
    "weapon_knife_karambit",
    "weapon_knife_m9_bayonet",
    "weapon_bayonet",
    "weapon_knife_survival_bowie",
    "weapon_knife_butterfly",
    "weapon_knife_flip",
    "weapon_knife_push",
    "weapon_knife_tactical",
    "weapon_knife_falchion",
    "weapon_knife_gut",
    "weapon_knife_ursus",
    "weapon_knife_gypsy_jackknife",
    "weapon_knife_stiletto",
    "weapon_knife_widowmaker",
    "weapon_mp5sd"
};

int g_iWeaponDefIndex[] = {
    9,
    7,
    16,
    60,
    1,
    61,
    32,
    4,
    2,
    36,
    63,
    3,
    30,
    64,
    35,
    25,
    27,
    29,
    14,
    28,
    34,
    17,
    33,
    24,
    19,
    26,
    10,
    13,
    40,
    8,
    39,
    38,
    11,
    507,
    508,
    500,
    514,
    515,
    505,
    516,
    509,
    512,
    506,
    519,
    520,
    522,
    523,
    23
};

public void LogCommand(const int client, const int target, const char[] command, const char[] extra, any...) {
	if(strlen(extra) > 0) {
		char buffer[512];
		VFormat(buffer, sizeof(buffer), extra, 5);

		LogAction(client, target, "%N executed command '%s' %s", client, command, buffer);
	} else {
		LogAction(client, target, "%N executed command '%s'", client, command);
	}
}

public bool IsClientValid(const int client) {
    if(client <= 0 || client > MaxClients || !IsClientConnected(client) || !IsClientInGame(client) || IsFakeClient(client)) {
        return false;
    }

    return true;
}

stock bool ClassByDefIndex(int index, char[] class, int size) {
	switch(index) {
		case 42: {
			FormatEx(class, size, "weapon_knife");
			return true;
		}

		case 59: {
			FormatEx(class, size, "weapon_knife_t");
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

stock bool GetWeaponClass(int entity, char[] weaponClass, int size) {
    int id = GetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex");
    return ClassByDefIndex(id, weaponClass, size);
}
