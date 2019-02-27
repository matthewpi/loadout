/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

#define TABLE_GLOVES "\
CREATE TABLE IF NOT EXISTS `loadout_gloves` (\
    `id`          INT(11)     AUTO_INCREMENT PRIMARY KEY,\
    `displayName` VARCHAR(64)                   NOT NULL,\
    `itemId`      INT(11)                       NOT NULL,\
    CONSTRAINT `loadout_gloves_id_uindex`          UNIQUE (`id`),\
    CONSTRAINT `loadout_gloves_displayName_uindex` UNIQUE (`displayName`),\
    CONSTRAINT `loadout_gloves_itemId_uindex`      UNIQUE (`itemId`)\
);"
#define TABLE_GLOVE_SKINS "\
CREATE TABLE IF NOT EXISTS `loadout_glove_skins` (\
    `id`          INT(11)     AUTO_INCREMENT PRIMARY KEY,\
    `displayName` VARCHAR(64)                   NOT NULL,\
    `gloveId`     INT(11)                       NOT NULL,\
    `paintId`     INT(11)                       NOT NULL,\
    CONSTRAINT `loadout_glove_skins_id_uindex` UNIQUE (`id`),\
    CONSTRAINT `loadout_glove_skins_loadout_gloves_id_fk` FOREIGN KEY (`gloveId`) REFERENCES `loadout_gloves` (`id`) ON UPDATE CASCADE\
);"
#define TABLE_KNIVES "\
CREATE TABLE IF NOT EXISTS `loadout_knives` (\
    `id`          INT(11)     AUTO_INCREMENT PRIMARY KEY,\
    `displayName` VARCHAR(64)                   NOT NULL,\
    `itemName`    VARCHAR(64)                   NOT NULL,\
    `itemId`      INT(11)                       NOT NULL,\
    CONSTRAINT `loadout_knives_id_uindex`          UNIQUE (`id`),\
    CONSTRAINT `loadout_knives_displayName_uindex` UNIQUE (`displayName`),\
    CONSTRAINT `loadout_knives_itemName_uindex`    UNIQUE (`itemName`),\
    CONSTRAINT `loadout_knives_itemId_uindex`      UNIQUE (`itemId`)\
);"
#define TABLE_SKINS "\
CREATE TABLE IF NOT EXISTS `loadout_skins` (\
    `id`          INT(11)     AUTO_INCREMENT PRIMARY KEY,\
    `displayName` VARCHAR(64)                   NOT NULL,\
    `skinId`      INT(11)                       NOT NULL,\
    `weapons`     TEXT                          NOT NULL,\
    CONSTRAINT `loadout_skins_id_uindex` UNIQUE (`id`)\
);"
#define TABLE_USER_SKINS "\
CREATE TABLE IF NOT EXISTS `loadout_user_skins` (\
    `steamId`     VARCHAR(64)                    NOT NULL,\
    `weapon`      VARCHAR(64)                    NOT NULL,\
    `skinId`      VARCHAR(16)                    NOT NULL,\
    `skinPattern` INT(11)         DEFAULT 0      NOT NULL,\
    `skinFloat`   DECIMAL(12, 11) DEFAULT 0.0001 NOT NULL,\
    `statTrak`    INT(11)         DEFAULT -1     NOT NULL,\
    `nametag`     VARCHAR(24)     DEFAULT ''     NOT NULL,\
    CONSTRAINT `loadout_user_skins_steamId_weapon_uindex` UNIQUE (`steamId`, `weapon`)\
);"

#define GET_GLOVES "SELECT * FROM `loadout_gloves` ORDER BY `displayName`;"
#define GET_GLOVE_SKINS "SELECT * FROM `loadout_glove_skins`;"
#define GET_KNIVES "SELECT * FROM `loadout_knives` ORDER BY `displayName`;"
#define SEARCH_WEAPON_SKINS "SELECT * FROM `loadout_skins` WHERE `displayName` LIKE \"%s%%\" ORDER BY `displayName`;"
#define GET_USER_SKINS "SELECT `weapon`, `skinId`, `skinPattern`, `skinFloat`, `statTrak`, `nametag` FROM `loadout_user_skins` WHERE `steamId`='%s';"
#define SET_USER_SKIN "INSERT INTO `loadout_user_skins` (`steamId`, `weapon`, `skinId`, `skinPattern`, `skinFloat`, `statTrak`, `nametag`) VALUES ('%s', '%s', '%s', %i, %f, %i, '%s') ON DUPLICATE KEY UPDATE `skinId`='%s', `skinPattern`=%i, `skinFloat`=%f, `statTrak`=%i, `nametag`='%s';"
