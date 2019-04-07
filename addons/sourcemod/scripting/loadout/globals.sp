/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

/* -------------------------------- */
/*              ConVars             */
/* -------------------------------- */
// sm_loadout_database - "Sets what database the plugin should use." (Default: "loadout")
ConVar g_cvDatabase;

// sm_loadout_official - "Should we set the server to Valve Official?" (Default: "0")
ConVar g_cvOfficial;

// sm_loadout_patterns - "Sets whether custom patterns are enabled." (Default: "1")
ConVar g_cvPatterns;
// sm_loadout_patterns_flag - "What admin flag is required to use custom patterns, '-' to allow anyone." (Default: "-")
ConVar g_cvPatternsFlag;

// sm_loadout_floats - "Sets whether custom floats are enabled." (Default: "1")
ConVar g_cvFloats;
// sm_loadout_floats_flag - "What admin flag is required to use custom floats, '-' to allow anyone." (Default: "-")
ConVar g_cvFloatsFlag;

// sm_loadout_stattrak - "Sets whether StatTrak is enabled." (Default: "1")
ConVar g_cvStatTrak;
// sm_loadout_stattrak_flag - "What admin flag is required to use StatTrak, '-' to allow anyone." (Default: "-")
ConVar g_cvStatTrakFlag;

// sm_loadout_nametags - "Sets whether custom nametags are enabled." (Default: "1")
ConVar g_cvNametags;
// sm_loadout_nametags_flag - "What admin flag is required to use custom nametags, '-' to allow anyone." (Default: "-")
ConVar g_cvNametagsFlag;
/* -------------------------------- */



/* -------------------------------- */
/*              Backend             */
/* -------------------------------- */
// g_dbLoadout stores the active database connection.
Database g_dbLoadout;

// g_iSkinCount stores the total skin count in the database.
int g_iSkinCount = -1;

// g_hKnives stores all loaded knives.
Knife g_hKnives[LOADOUT_KNIFE_MAX];

// g_hGloves stores all loaded gloves.
Glove g_hGloves[LOADOUT_GLOVE_MAX];

// g_iKnives stores player knives.
int g_iKnives[MAXPLAYERS + 1];

// g_iGloves stores player gloves.
int g_iGloves[MAXPLAYERS + 1];

// g_iGloveSkins stores player glove skins.
int g_iGloveSkins[MAXPLAYERS + 1];

// g_smPlayerItems stores all player items.
StringMap g_smPlayerItems[MAXPLAYERS + 1];
/* -------------------------------- */



/* -------------------------------- */
/*              Other               */
/* -------------------------------- */
// g_iSpecialBoi
int g_iSpecialBoi = -1;

// g_cLoadoutWeapon stores the currently selected menu item.
char g_cLoadoutWeapon[MAXPLAYERS + 1][64];

// g_iLoadoutAction
int g_iLoadoutAction[MAXPLAYERS + 1];

// g_smWeaponIndex stores a weapons and their definition index.
StringMap g_smWeaponIndex;

// g_mFilterMenus
Menu g_mFilterMenus[MAXPLAYERS + 1];

// g_cWeaponClasses and g_iWeaponDefIndex
char g_cWeaponClasses[][] = {
    /* 0*/ "weapon_awp", /* 1*/ "weapon_ak47", /* 2*/ "weapon_m4a1", /* 3*/ "weapon_m4a1_silencer", /* 4*/ "weapon_deagle", /* 5*/ "weapon_usp_silencer", /* 6*/ "weapon_hkp2000", /* 7*/ "weapon_glock", /* 8*/ "weapon_elite",
    /* 9*/ "weapon_p250", /*10*/ "weapon_cz75a", /*11*/ "weapon_fiveseven", /*12*/ "weapon_tec9", /*13*/ "weapon_revolver", /*14*/ "weapon_nova", /*15*/ "weapon_xm1014", /*16*/ "weapon_mag7", /*17*/ "weapon_sawedoff",
    /*18*/ "weapon_m249", /*19*/ "weapon_negev", /*20*/ "weapon_mp9", /*21*/ "weapon_mac10", /*22*/ "weapon_mp7", /*23*/ "weapon_ump45", /*24*/ "weapon_p90", /*25*/ "weapon_bizon", /*26*/ "weapon_famas", /*27*/ "weapon_galilar",
    /*28*/ "weapon_ssg08", /*29*/ "weapon_aug", /*30*/ "weapon_sg556", /*31*/ "weapon_scar20", /*32*/ "weapon_g3sg1", /*33*/ "weapon_knife_karambit", /*34*/ "weapon_knife_m9_bayonet", /*35*/ "weapon_bayonet",
    /*36*/ "weapon_knife_survival_bowie", /*37*/ "weapon_knife_butterfly", /*38*/ "weapon_knife_flip", /*39*/ "weapon_knife_push", /*40*/ "weapon_knife_tactical", /*41*/ "weapon_knife_falchion", /*42*/ "weapon_knife_gut",
    /*43*/ "weapon_knife_ursus", /*44*/ "weapon_knife_gypsy_jackknife", /*45*/ "weapon_knife_stiletto", /*46*/ "weapon_knife_widowmaker", /*47*/ "weapon_mp5sd"
};

// g_iWeaponDefIndex and g_cWeaponClasses
int g_iWeaponDefIndex[] = {
    /* 0*/ 9, /* 1*/ 7, /* 2*/ 16, /* 3*/ 60, /* 4*/ 1, /* 5*/ 61, /* 6*/ 32, /* 7*/ 4, /* 8*/ 2,
    /* 9*/ 36, /*10*/ 63, /*11*/ 3, /*12*/ 30, /*13*/ 64, /*14*/ 35, /*15*/ 25, /*16*/ 27, /*17*/ 29,
    /*18*/ 14, /*19*/ 28, /*20*/ 34, /*21*/ 17, /*22*/ 33, /*23*/ 24, /*24*/ 19, /*25*/ 26, /*26*/ 10, /*27*/ 13,
    /*28*/ 40, /*29*/ 8, /*30*/ 39, /*31*/ 38, /*32*/ 11, /*33*/ 507, /*34*/ 508, /*35*/ 500,
    /*36*/ 514, /*37*/ 515, /*38*/ 505, /*39*/ 516, /*40*/ 509, /*41*/ 512, /*42*/ 506,
    /*43*/ 519, /*44*/ 520, /*45*/ 522, /*46*/ 523, /*47*/ 23
};
/* -------------------------------- */
