create table cs_glove_skins
(
  id          int auto_increment,
  displayName varchar(64) not null,
  gloveId     int         not null,
  paintId     int         not null,
  constraint cs_glove_skins_id_uindex
    unique (id),
  constraint cs_glove_skins_cs_gloves_id_fk
    foreign key (gloveId) references cs_gloves (id)
      on update cascade
);

alter table cs_glove_skins
  add primary key (id);

INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (1, 'Bronzed', 1, 10008);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (2, 'Case Hardened', 1, 10060);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (3, 'Charred', 1, 10006);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (4, 'Emerald', 1, 10057);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (5, 'Guerrilla', 1, 10039);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (6, 'Mangrove', 1, 10058);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (7, 'Rattler', 1, 10059);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (8, 'Snakebite', 1, 10007);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (9, 'Convoy', 2, 10015);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (10, 'Crimson Weave', 2, 10016);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (11, 'Diamondback', 2, 10040);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (12, 'Imperial Plaid', 2, 10042);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (13, 'King Snake', 2, 10041);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (14, 'Lunar Weave', 2, 10013);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (15, 'Overtake', 2, 10043);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (16, 'Racing Green', 2, 10044);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (17, 'Arboreal', 3, 10056);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (18, 'Badlands', 3, 10036);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (19, 'Cobalt Skulls', 3, 10053);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (20, 'Duct Tape', 3, 10055);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (21, 'Leather', 3, 10009);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (22, 'Overprint', 3, 10054);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (23, 'Slaughter', 3, 10021);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (24, 'Spruce DDPAT', 3, 10010);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (27, 'Bronzed', 4, 10008);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (28, 'Case Hardened', 4, 10060);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (29, 'Charred', 4, 10006);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (30, 'Emerald', 4, 10057);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (31, 'Guerrilla', 4, 10039);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (32, 'Mangrove', 4, 10058);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (33, 'Rattler', 4, 10059);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (34, 'Snakebite', 4, 10007);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (35, 'Boom!', 5, 10027);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (36, 'Cool Mint', 5, 10028);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (37, 'Eclipse', 5, 10024);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (38, 'Polygon', 5, 10052);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (39, 'POW!', 5, 10049);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (40, 'Spearmint', 5, 10026);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (41, 'Transport', 5, 10051);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (42, 'Turtle', 5, 10050);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (43, 'Buckshot', 6, 10062);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (44, 'Crimson Kimono', 6, 10033);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (45, 'Crimson Web', 6, 10061);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (46, 'Emerald Web', 6, 10034);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (47, 'Fade', 6, 10063);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (48, 'Forest DDPAT', 6, 10030);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (49, 'Foundation', 6, 10035);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (50, 'Mogul', 6, 10064);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (51, 'Amphibious', 7, 10045);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (52, 'Arid', 7, 10019);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (53, 'Bronze Morph', 7, 10046);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (54, 'Hedge Maze', 7, 10038);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (55, 'Omega', 7, 10047);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (56, 'Pandora''s Box', 7, 10037);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (57, 'Superconductor', 7, 10018);
INSERT INTO csgo_dev.cs_glove_skins (id, displayName, gloveId, paintId) VALUES (58, 'Vice', 7, 10048);
create table cs_gloves
(
  id          int auto_increment,
  displayName varchar(64) not null,
  itemId      int         not null,
  constraint cs_gloves_displayName_uindex
    unique (displayName),
  constraint cs_gloves_id_uindex
    unique (id),
  constraint cs_gloves_itemId_uindex
    unique (itemId)
);

alter table cs_gloves
  add primary key (id);

INSERT INTO csgo_dev.cs_gloves (id, displayName, itemId) VALUES (1, 'Bloodhound', 5027);
INSERT INTO csgo_dev.cs_gloves (id, displayName, itemId) VALUES (2, 'Driver', 5031);
INSERT INTO csgo_dev.cs_gloves (id, displayName, itemId) VALUES (3, 'Hand Wraps', 5032);
INSERT INTO csgo_dev.cs_gloves (id, displayName, itemId) VALUES (4, 'Hydra', 5035);
INSERT INTO csgo_dev.cs_gloves (id, displayName, itemId) VALUES (5, 'Moto', 5033);
INSERT INTO csgo_dev.cs_gloves (id, displayName, itemId) VALUES (6, 'Specialist', 5034);
INSERT INTO csgo_dev.cs_gloves (id, displayName, itemId) VALUES (7, 'Sport', 5030);
INSERT INTO csgo_dev.cs_gloves (id, displayName, itemId) VALUES (8, 'Default', 0);
create table cs_knives
(
  id          int auto_increment,
  displayName varchar(64) not null,
  itemId      int         not null,
  constraint cs_knives_displayName_uindex
    unique (displayName),
  constraint cs_knives_id_uindex
    unique (id),
  constraint cs_knives_itemId_uindex
    unique (itemId)
);

alter table cs_knives
  add primary key (id);

INSERT INTO csgo_dev.cs_knives (id, displayName, itemId) VALUES (1, 'Bayonet', 500);
INSERT INTO csgo_dev.cs_knives (id, displayName, itemId) VALUES (2, 'Bowie', 514);
INSERT INTO csgo_dev.cs_knives (id, displayName, itemId) VALUES (3, 'Butterfly', 515);
INSERT INTO csgo_dev.cs_knives (id, displayName, itemId) VALUES (4, 'Falchion', 512);
INSERT INTO csgo_dev.cs_knives (id, displayName, itemId) VALUES (5, 'Flip', 505);
INSERT INTO csgo_dev.cs_knives (id, displayName, itemId) VALUES (6, 'Gut', 506);
INSERT INTO csgo_dev.cs_knives (id, displayName, itemId) VALUES (7, 'Huntsman', 509);
INSERT INTO csgo_dev.cs_knives (id, displayName, itemId) VALUES (8, 'Karambit', 507);
INSERT INTO csgo_dev.cs_knives (id, displayName, itemId) VALUES (9, 'M9 Bayonet', 508);
INSERT INTO csgo_dev.cs_knives (id, displayName, itemId) VALUES (10, 'Navaja', 520);
INSERT INTO csgo_dev.cs_knives (id, displayName, itemId) VALUES (11, 'Shadow Daggers', 516);
INSERT INTO csgo_dev.cs_knives (id, displayName, itemId) VALUES (12, 'Stiletto', 522);
INSERT INTO csgo_dev.cs_knives (id, displayName, itemId) VALUES (13, 'Talon', 523);
INSERT INTO csgo_dev.cs_knives (id, displayName, itemId) VALUES (14, 'Ursus', 519);
INSERT INTO csgo_dev.cs_knives (id, displayName, itemId) VALUES (15, 'Default', 0);
create table cs_skins
(
  id          int auto_increment,
  displayName varchar(64) not null,
  skinId      int         not null,
  weapons     text        not null,
  constraint cs_skins_id_uindex
    unique (id),
  constraint cs_skins_skinId_uindex
    unique (skinId)
);

alter table cs_skins
  add primary key (id);

INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (1, 'Night Stripe', 735, 'weapon_knife_ursus;weapon_knife_gypsy_jackknife;weapon_knife_stiletto;weapon_knife_widowmaker;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (2, 'Eye of Athena', 723, 'weapon_famas;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (3, 'Snek-9', 722, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (4, 'Survivalist', 721, 'weapon_revolver;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (5, 'Devourer', 720, 'weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (6, 'Powercore', 719, 'weapon_mp7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (7, 'PAW', 718, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (8, 'Traction', 717, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (9, 'Toy Soldier', 716, 'weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (10, 'Capillary', 715, 'weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (11, 'Nightmare', 714, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (12, 'Warhawk', 713, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (13, 'High Seas', 712, 'weapon_g3sg1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (14, 'Code Red', 711, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (15, 'Shred', 710, 'weapon_elite;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (16, 'Eco', 709, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (17, 'Amber Slipstream', 708, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (18, 'Neon Rider', 707, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (19, 'Oxide Blaze', 706, 'weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (20, 'Cortex', 705, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (21, 'Arctic Wolf', 704, 'weapon_ump45;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (22, 'SWAG-7', 703, 'weapon_mag7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (23, 'Aloha', 702, 'weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (24, 'Grip', 701, 'weapon_revolver;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (25, 'Urban Hazard', 700, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (26, 'Wild Six', 699, 'weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (27, 'Lionfish', 698, 'weapon_negev;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (28, 'Black Sand', 697, 'weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (29, 'Bloodsport', 696, 'weapon_mp7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (30, 'Neo-Noir', 695, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (31, 'Moonrise', 694, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (32, 'Flame Test', 693, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (33, 'Night Riot', 692, 'weapon_bizon;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (34, 'Mortis', 691, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (35, 'Stymphalian', 690, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (36, 'Ziggy', 689, 'weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (37, 'Exposure', 688, 'weapon_ump45;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (38, 'Tacticat', 687, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (39, 'Phantom', 686, 'weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (40, 'Jungle Slipstream', 685, 'weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (41, 'Cracked Opal', 684, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (42, 'Llama Cannon', 683, 'weapon_revolver;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (43, 'Oceanic', 682, 'weapon_mac10;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (44, 'Leaded Glass', 681, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (45, 'Off World', 680, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (46, 'Goo', 679, 'weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (47, 'See Ya Later', 678, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (48, 'Hunter', 677, 'weapon_g3sg1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (49, 'High Roller', 676, 'weapon_bizon;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (50, 'The Empress', 675, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (51, 'Triqua', 674, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (52, 'Morris', 673, 'weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (53, 'Metal Flowers', 672, 'weapon_ump45;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (54, 'Cut Out', 671, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (55, 'Death''s Head', 670, 'weapon_ssg08;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (56, 'Death Grip', 669, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (57, 'Red Rock', 668, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (58, 'Woodsman', 667, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (59, 'Hard Water', 666, 'weapon_mag7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (60, 'Aloha', 665, 'weapon_mac10;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (61, 'Hellfire', 664, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (62, 'Briefing', 663, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (63, 'Oni Taiji', 662, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (64, 'Sugar Rush', 661, 'weapon_galilar;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (65, 'Hyper Beast', 660, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (66, 'Macabre', 659, 'weapon_famas;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (67, 'Cobra Strike', 658, 'weapon_elite;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (68, 'Blueprint', 657, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (69, 'Orbit Mk01', 656, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (70, 'Zander', 655, 'weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (71, 'Seasons', 654, 'weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (72, 'Neo-Noir', 653, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (73, 'Scaffold', 652, 'weapon_ump45;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (74, 'Last Dive', 651, 'weapon_mac10;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (75, 'Ripple', 650, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (76, 'Akoben', 649, 'weapon_mp7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (77, 'Emerald Poison Dart', 648, 'weapon_m249;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (78, 'Crimson Tsunami', 647, 'weapon_galilar;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (79, 'Capillary', 646, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (80, 'Oxide Blaze', 645, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (81, 'Decimator', 644, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (82, 'Xiangliu', 643, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (83, 'Blueprint', 642, 'weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (84, 'Jungle Slipstream', 641, 'weapon_bizon;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (85, 'Fever Dream', 640, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (86, 'Bloodsport', 639, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (87, 'Wasteland Princess', 638, 'weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (88, 'Cyrex', 637, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (89, 'Shallow Grave', 636, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (90, 'Turf', 635, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (91, 'Gila', 634, 'weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (92, 'Sonar', 633, 'weapon_mag7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (93, 'Buzz Kill', 632, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (94, 'Flashback', 631, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (95, 'Sand Scale', 630, 'weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (96, 'Black Sand', 629, 'weapon_galilar;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (97, 'Stinger', 628, 'weapon_g3sg1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (98, 'Cirrus', 627, 'weapon_mp7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (99, 'Mecha Industries', 626, 'weapon_famas;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (100, 'Royal Consorts', 625, 'weapon_elite;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (101, 'Dragonfire', 624, 'weapon_ssg08;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (102, 'Ironwork', 623, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (103, 'Polymer', 622, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (104, 'Slipstream', 616, 'weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (105, 'Briefing', 615, 'weapon_ump45;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (106, 'Fuel Injector', 614, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (107, 'Triarch', 613, 'weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (108, 'Powercore', 612, 'weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (109, 'Grim', 611, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (110, 'Dazzle', 610, 'weapon_negev;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (111, 'Airlock', 609, 'weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (112, 'Petroglyph', 608, 'weapon_mag7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (113, 'Weasel', 607, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (114, 'Ventilator', 606, 'weapon_g3sg1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (115, 'Scumbria', 605, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (116, 'Roll Cage', 604, 'weapon_famas;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (117, 'Directive', 603, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (118, 'Imprint', 602, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (119, 'Syd Mead', 601, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (120, 'Neon Revolution', 600, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (121, 'Ice Cap', 599, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (122, 'Aerial', 598, 'weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (123, 'Bloodsport', 597, 'weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (124, 'Limelight', 596, 'weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (125, 'Reboot', 595, 'weapon_revolver;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (126, 'Harvester', 594, 'weapon_bizon;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (127, 'Chopper', 593, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (128, 'Iron Clad', 592, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (129, 'Imperial Dragon', 591, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (130, 'Exo', 590, 'weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (131, 'Carnivore', 589, 'weapon_mac10;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (132, 'Desolate Space', 588, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (133, 'Mecha Industries', 587, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (134, 'Wasteland Rebel', 586, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (135, 'Violent Daimyo', 585, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (136, 'Phobos', 584, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (137, 'Aristocrat', 583, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (138, 'Freehand', 582, 'weapon_knife_karambit;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (139, 'Freehand', 581, 'weapon_knife_m9_bayonet;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (140, 'Freehand', 580, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (141, 'Bright Water', 579, 'weapon_knife_m9_bayonet;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (142, 'Bright Water', 578, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (143, 'Autotronic', 577, 'weapon_knife_m9_bayonet;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (144, 'Autotronic', 576, 'weapon_knife_karambit;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (145, 'Autotronic', 575, 'weapon_knife_gut;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (146, 'Autotronic', 574, 'weapon_knife_flip;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (147, 'Autotronic', 573, 'weapon_bayonet;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (148, 'Gamma Doppler (Phase 1)', 569, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (149, 'Gamma Doppler (Phase 2)', 570, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (150, 'Gamma Doppler (Phase 3)', 571, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (151, 'Gamma Doppler (Phase 4)', 572, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (152, 'Gamma Doppler (Emerald)', 568, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (153, 'Black Laminate', 567, 'weapon_knife_m9_bayonet;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (154, 'Black Laminate', 566, 'weapon_knife_karambit;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (155, 'Black Laminate', 565, 'weapon_knife_gut;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (156, 'Black Laminate', 564, 'weapon_knife_flip;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (157, 'Black Laminate', 563, 'weapon_bayonet;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (158, 'Lore', 562, 'weapon_knife_m9_bayonet;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (159, 'Lore', 561, 'weapon_knife_karambit;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (160, 'Lore', 560, 'weapon_knife_gut;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (161, 'Lore', 559, 'weapon_knife_flip;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (162, 'Lore', 558, 'weapon_bayonet;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (163, 'Black Tie', 557, 'weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (164, 'Primal Saber', 556, 'weapon_ump45;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (165, 'Re-Entry', 555, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (166, 'Ghost Crusader', 554, 'weapon_ssg08;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (167, 'Atlas', 553, 'weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (168, 'Fubar', 552, 'weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (169, 'Asiimov', 551, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (170, 'Oceanic', 550, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (171, 'Bioleak', 549, 'weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (172, 'Chantico''s Fire', 548, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (173, 'Spectre', 547, 'weapon_m249;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (174, 'Firefight', 546, 'weapon_galilar;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (175, 'Orange Crash', 545, 'weapon_g3sg1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (176, 'Ventilators', 544, 'weapon_elite;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (177, 'Red Astor', 543, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (178, 'Judgement of Anubis', 542, 'weapon_bizon;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (179, 'Fleet Flock', 541, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (180, 'Ultraviolet', 621, 'weapon_knife_falchion;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (181, 'Ultraviolet', 620, 'weapon_knife_tactical;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (182, 'Lead Conduit', 540, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (183, 'Jambiya', 539, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (184, 'Necropos', 538, 'weapon_ssg08;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (185, 'Hyper Beast', 537, 'weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (186, 'Impire', 536, 'weapon_mp7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (187, 'Praetorian', 535, 'weapon_mag7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (188, 'Lapis Gator', 534, 'weapon_mac10;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (189, 'The Battlestar', 533, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (190, 'Royal Legion', 532, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (191, 'Triumvirate', 530, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (192, 'Valence', 529, 'weapon_famas;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (193, 'Cartel', 528, 'weapon_elite;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (194, 'Kumicho Dragon', 527, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (195, 'Photic Zone', 526, 'weapon_bizon;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (196, 'Elite Build', 525, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (197, 'Fuel Injector', 524, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (198, 'Amber Fade', 523, 'weapon_revolver;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (199, 'Fade', 522, 'weapon_revolver;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (200, 'Teclu Burner', 521, 'weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (201, 'Avalanche', 520, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (202, 'Tiger Moth', 519, 'weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (203, 'Outbreak', 518, 'weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (204, 'Yorick', 517, 'weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (205, 'Shapewood', 516, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (206, 'Imperial', 515, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (207, 'Power Loader', 514, 'weapon_negev;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (208, 'Royal Paladin', 512, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (209, 'The Executioner', 511, 'weapon_g3sg1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (210, 'Retrobution', 510, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (211, 'Corinthian', 509, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (212, 'Fuel Rod', 508, 'weapon_bizon;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (213, 'Ricochet', 507, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (214, 'Point Disarray', 506, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (215, 'Scumbria', 505, 'weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (216, 'Kill Confirmed', 504, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (217, 'Big Iron', 503, 'weapon_ssg08;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (218, 'Green Marine', 502, 'weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (219, 'Wingshot', 501, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (220, 'Special Delivery', 500, 'weapon_mp7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (221, 'Cobalt Core', 499, 'weapon_mag7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (222, 'Rangeen', 498, 'weapon_mac10;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (223, 'Golden Coil', 497, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (224, 'Nebula Crusader', 496, 'weapon_m249;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (225, 'Wraiths', 495, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (226, 'Stone Cold', 494, 'weapon_galilar;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (227, 'Flux', 493, 'weapon_g3sg1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (228, 'Survivor Z', 492, 'weapon_famas;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (229, 'Dualing Dragons', 491, 'weapon_elite;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (230, 'Frontside Misty', 490, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (231, 'Torque', 489, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (232, 'Riot', 488, 'weapon_ump45;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (233, 'Cyrex', 487, 'weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (234, 'Elite Build', 486, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (235, 'Handgun', 485, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (236, 'Ranger', 484, 'weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (237, 'Loudmouth', 483, 'weapon_negev;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (238, 'Ruby Poison Dart', 482, 'weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (239, 'Nemesis', 481, 'weapon_mp7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (240, 'Evil Daimyo', 480, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (241, 'Bunsen Burner', 479, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (242, 'Rocket Pop', 478, 'weapon_galilar;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (243, 'Neural Net', 477, 'weapon_famas;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (244, 'Yellow Jacket', 476, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (245, 'Hyper Beast', 475, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (246, 'Aquamarine Revenge', 474, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (247, 'Seabird', 473, 'weapon_mag7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (248, 'Impact Drill', 472, 'weapon_m249;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (249, 'Daybreak', 471, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (250, 'Sunset Storm å¼', 470, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (251, 'Sunset Storm å£±', 469, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (252, 'Midnight Storm', 468, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (253, 'Mint Kimono', 467, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (254, 'Crimson Kimono', 466, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (255, 'Orange Kimono', 465, 'weapon_g3sg1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (256, 'Neon Kimono', 464, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (257, 'Terrace', 463, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (258, 'Counter Terrace', 462, 'weapon_mag7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (259, 'Aqua Terrace', 460, 'weapon_galilar;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (260, 'Bamboo Forest', 459, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (261, 'Bamboo Shadow', 458, 'weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (262, 'Bamboo Print', 457, 'weapon_bizon;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (263, 'Hydroponic', 456, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (264, 'Akihabara Accept', 455, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (265, 'Para Green', 454, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (266, 'Emerald', 453, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (267, 'Shipping Forecast', 452, 'weapon_m249;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (268, 'Sun in Leo', 451, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (269, 'Moon in Libra', 450, 'weapon_elite;weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (270, 'Poseidon', 449, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (271, 'Pandora''s Box', 448, 'weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (272, 'Duelist', 447, 'weapon_elite;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (273, 'Medusa', 446, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (274, 'Hot Rod', 445, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (275, 'Daedalus', 444, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (276, 'Pathfinder', 443, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (277, 'Asterion', 442, 'weapon_mp7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (278, 'Minotaur''s Labyrinth', 441, 'weapon_ump45;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (279, 'Icarus Fell', 440, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (280, 'Hades', 439, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (281, 'Chronos', 438, 'weapon_g3sg1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (282, 'Twilight Galaxy', 437, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (283, 'Grand Prix', 436, 'weapon_ump45;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (284, 'Pole Position', 435, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (285, 'Origami', 434, 'weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (286, 'Neon Rider', 433, 'weapon_mac10;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (287, 'Man-o''-war', 432, 'weapon_negev;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (288, 'Heat', 431, 'weapon_mag7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (289, 'Hyper Beast', 430, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (290, 'Djinn', 429, 'weapon_famas;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (291, 'Eco', 428, 'weapon_galilar;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (292, 'Monkey Business', 427, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (293, 'Valence', 426, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (294, 'Bronze Deco', 425, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (295, 'Worm God', 424, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (296, 'Armor Core', 423, 'weapon_mp7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (297, 'Elite Build', 422, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (298, 'Doppler (Phase 1)', 418, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (299, 'Doppler (Phase 2)', 419, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (300, 'Doppler (Phase 2)', 618, 'weapon_knife_butterfly;weapon_knife_push;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (301, 'Doppler (Phase 3)', 420, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (302, 'Doppler (Phase 4)', 421, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (303, 'Doppler (Sapphire)', 416, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (304, 'Doppler (Sapphire)', 619, 'weapon_knife_butterfly;weapon_knife_push;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (305, 'Doppler (Ruby)', 415, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (306, 'Doppler (Black Pearl)', 417, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (307, 'Doppler (Black Pearl)', 617, 'weapon_knife_butterfly;weapon_knife_push;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (308, 'Rust Coat', 414, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (309, 'Marble Fade', 413, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (310, 'Damascus Steel', 411, 'weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (311, 'Damascus Steel', 410, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (312, 'Tiger Tooth', 409, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (313, 'Quicksilver', 407, 'weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (314, 'Grotto', 406, 'weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (315, 'Serenity', 405, 'weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (316, 'Muertos', 404, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (317, 'Deadly Poison', 403, 'weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (318, 'Malachite', 402, 'weapon_mac10;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (319, 'System Lock', 401, 'weapon_m249;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (320, 'é¾çŽ‹ (Dragon King)', 400, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (321, 'Catacombs', 399, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (322, 'Chatterbox', 398, 'weapon_galilar;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (323, 'Naga', 397, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (324, 'Urban Shock', 396, 'weapon_elite;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (325, 'Man-o''-war', 395, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (326, 'Cartel', 394, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (327, 'Tranquility', 393, 'weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (328, 'Delusion', 392, 'weapon_ump45;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (329, 'Cardiac', 391, 'weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (330, 'Highwayman', 390, 'weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (331, 'Fire Elemental', 389, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (332, 'Cartel', 388, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (333, 'Urban Hazard', 387, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (334, 'Dart', 386, 'weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (335, 'Firestarter', 385, 'weapon_mag7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (336, 'Griffin', 384, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (337, 'Basilisk', 383, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (338, 'Murky', 382, 'weapon_g3sg1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (339, 'Grinder', 381, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (340, 'Wasteland Rebel', 380, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (341, 'Cerberus', 379, 'weapon_galilar;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (342, 'Fallout Warning', 378, 'weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (343, 'Hot Shot', 377, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (344, 'Chemical Green', 376, 'weapon_bizon;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (345, 'Radiation Hazard', 375, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (346, 'Toxic', 374, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (347, 'Contamination', 373, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (348, 'Nuclear Garden', 372, 'weapon_mac10;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (349, 'Styx', 371, 'weapon_famas;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (350, 'Bone Machine', 370, 'weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (351, 'Nuclear Waste', 369, 'weapon_negev;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (352, 'Setting Sun', 368, 'weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (353, 'Reactor', 367, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (354, 'Green Plaid', 366, 'weapon_mp9;weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (355, 'Olive Plaid', 365, 'weapon_mp7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (356, 'Business Class', 364, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (357, 'Traveler', 363, 'weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (358, 'Labyrinth', 362, 'weapon_ump45;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (359, 'Abyss', 361, 'weapon_ssg08;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (360, 'Cyrex', 360, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (361, 'Asiimov', 359, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (362, 'Supernova', 358, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (363, 'Ivory', 357, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (364, 'Koi', 356, 'weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (365, 'Desert-Strike', 355, 'weapon_negev;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (366, 'Urban Hazard', 354, 'weapon_mp7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (367, 'Water Elemental', 353, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (368, 'Fowl Play', 352, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (369, 'Conspiracy', 351, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (370, 'Tigris', 350, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (371, 'Osiris', 349, 'weapon_bizon;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (372, 'Red Leather', 348, 'weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (373, 'Pilot', 347, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (374, 'Coach Class', 346, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (375, 'First Class', 345, 'weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (376, 'Dragon Lore', 344, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (377, 'Commuter', 343, 'weapon_mac10;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (378, 'Leather', 342, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (379, 'First Class', 341, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (380, 'Jet Set', 340, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (381, 'Caiman', 339, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (382, 'Pulse', 338, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (383, 'Tatter', 337, 'weapon_mac10;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (384, 'Desert-Strike', 336, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (385, 'Module', 335, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (386, 'Twist', 334, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (387, 'Indigo', 333, 'weapon_mac10;weapon_ump45;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (388, 'Royal Blue', 332, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (389, 'Briar', 330, 'weapon_elite;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (390, 'Dark Age', 329, 'weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (391, 'Hand Cannon', 328, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (392, 'Chainmail', 327, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (393, 'Knight', 326, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (394, 'Chalice', 325, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (395, 'Rust Coat', 323, 'weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (396, 'Nitro', 322, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (397, 'Master Piece', 321, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (398, 'Red Python', 320, 'weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (399, 'Detour', 319, 'weapon_ssg08;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (400, 'Road Rash', 318, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (401, 'Bratatat', 317, 'weapon_negev;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (402, 'Jaguar', 316, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (403, 'Poison Dart', 315, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (404, 'Heaven Guard', 314, 'weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (405, 'Orion', 313, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (406, 'Cyrex', 312, 'weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (407, 'Desert Warfare', 311, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (408, 'Curse', 310, 'weapon_mac10;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (409, 'Howl', 309, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (410, 'Kami', 308, 'weapon_galilar;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (411, 'Retribution', 307, 'weapon_elite;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (412, 'Antique', 306, 'weapon_bizon;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (413, 'Torque', 305, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (414, 'Slashed', 304, 'weapon_ssg08;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (415, 'Isaac', 303, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (416, 'Vulcan', 302, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (417, 'Atomic Alloy', 301, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (418, 'Emerald Pinstripe', 300, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (419, 'Caged Steel', 299, 'weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (420, 'Army Sheen', 298, 'weapon_negev;weapon_scar20;weapon_sg556;weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (421, 'Tuxedo', 297, 'weapon_galilar;weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (422, 'Meteorite', 296, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (423, 'Franklin', 295, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (424, 'Green Apple', 294, 'weapon_g3sg1;weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (425, 'Death Rattle', 293, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (426, 'Heaven Guard', 291, 'weapon_mag7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (427, 'Guardian', 290, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (428, 'Sandstorm', 289, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (429, 'Sergeant', 288, 'weapon_famas;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (430, 'Pulse', 287, 'weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (431, 'Antique', 286, 'weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (432, 'Terrain', 285, 'weapon_negev;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (433, 'Heat', 284, 'weapon_mac10;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (434, 'Trigon', 283, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (435, 'Redline', 282, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (436, 'Corporal', 281, 'weapon_ump45;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (437, 'Chameleon', 280, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (438, 'Asiimov', 279, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (439, 'Blue Fissure', 278, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (440, 'Stainless', 277, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (441, 'Panther', 276, 'weapon_elite;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (442, 'Red FragCam', 275, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (443, 'Copper Galaxy', 274, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (444, 'Heirloom', 273, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (445, 'Titanium Bit', 272, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (446, 'Undertow', 271, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (447, 'Victoria', 270, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (448, 'The Fuschia Is Now', 269, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (449, 'Tread Plate', 268, 'weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (450, 'Cobalt Halftone', 267, 'weapon_bizon;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (451, 'Magma', 266, 'weapon_m249;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (452, 'Kami', 265, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (453, 'Sandstorm', 264, 'weapon_galilar;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (454, 'Rising Skull', 263, 'weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (455, 'Rose Iron', 262, 'weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (456, 'Marina', 261, 'weapon_elite;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (457, 'Pulse', 260, 'weapon_famas;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (458, 'Redline', 259, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (459, 'Mehndi', 258, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (460, 'Guardian', 257, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (461, 'The Kraken', 256, 'weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (462, 'Asiimov', 255, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (463, 'Nitro', 254, 'weapon_fiveseven;weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (464, 'Acid Fade', 253, 'weapon_ssg08;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (465, 'Silver Quartz', 252, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (466, 'Pit Viper', 251, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (467, 'Full Stop', 250, 'weapon_sawedoff;weapon_mp7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (468, 'Cobalt Quartz', 249, 'weapon_elite;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (469, 'Red Quartz', 248, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (470, 'Damascus Steel', 247, 'weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (471, 'Amber Fade', 246, 'weapon_mac10;weapon_sawedoff;weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (472, 'Army Recon', 245, 'weapon_mp7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (473, 'Teardown', 244, 'weapon_famas;weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (474, 'Gator Mesh', 243, 'weapon_m249;weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (475, 'Army Mesh', 242, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (476, 'Hunting Blind', 241, 'weapon_galilar;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (477, 'CaliCamo', 240, 'weapon_xm1014;weapon_negev;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (478, 'VariCamo Blue', 238, 'weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (479, 'Urban Rubble', 237, 'weapon_deagle;weapon_galilar;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (480, 'Night Ops', 236, 'weapon_bizon;weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (481, 'VariCamo', 235, 'weapon_g3sg1;weapon_galilar;weapon_tec9;weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (482, 'Ash Wood', 234, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (483, 'Tropical Storm', 233, 'weapon_ssg08;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (484, 'Crimson Web', 232, 'weapon_deagle;weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (485, 'Cobalt Disruption', 231, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (486, 'Steel Disruption', 230, 'weapon_glock;weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (487, 'Azure Zebra', 229, 'weapon_g3sg1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (488, 'Blind Spot', 228, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (489, 'Electric Hive', 227, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (490, 'Blue Laminate', 226, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (491, 'Ghost Camo', 225, 'weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (492, 'Water Sigil', 224, 'weapon_bizon;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (493, 'Nightshade', 223, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (494, 'Blood in the Water', 222, 'weapon_ssg08;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (495, 'Serum', 221, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (496, 'Hemoglobin', 220, 'weapon_elite;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (497, 'Hive', 219, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (498, 'Hexane', 218, 'weapon_famas;weapon_cz75a;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (499, 'Blood Tiger', 217, 'weapon_m4a1_silencer;weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (500, 'Blue Titanium', 216, 'weapon_galilar;weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (501, 'X-Ray', 215, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (502, 'Graphite', 214, 'weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (503, 'Ocean Foam', 213, 'weapon_mp7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (504, 'Graphite', 212, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (505, 'Ocean Foam', 211, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (506, 'Anodized Gunmetal', 210, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (507, 'Groundwater', 209, 'weapon_mp7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (508, 'Sand Dune', 208, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (509, 'Facets', 207, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (510, 'Tornado', 206, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (511, 'Jungle', 205, 'weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (512, 'Mosaico', 204, 'weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (513, 'Rust Coat', 203, 'weapon_bizon;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (514, 'Jungle DDPAT', 202, 'weapon_m249;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (515, 'Palm', 201, 'weapon_negev;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (516, 'Mayan Dreams', 200, 'weapon_ssg08;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (517, 'Dry Season', 199, 'weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (518, 'Hazard', 198, 'weapon_mag7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (519, 'Anodized Navy', 197, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (520, 'Emerald', 196, 'weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (521, 'Demeter', 195, 'weapon_g3sg1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (522, 'Spitfire', 194, 'weapon_famas;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (523, 'Bone Pile', 193, 'weapon_ump45;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (524, 'Shattered', 192, 'weapon_galilar;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (525, 'Tempest', 191, 'weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (526, 'Black Limba', 190, 'weapon_elite;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (527, 'Bright Water', 189, 'weapon_m4a1_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (528, 'Graven', 188, 'weapon_mac10;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (529, 'Zirka', 187, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (530, 'Wave Spray', 186, 'weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (531, 'Golden Koi', 185, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (532, 'Corticera', 184, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (533, 'Overgrowth', 183, 'weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (534, 'Emerald Dragon', 182, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (535, 'Corticera', 181, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (536, 'Fire Serpent', 180, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (537, 'Nuclear Threat', 179, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (538, 'Doomkitty', 178, 'weapon_famas;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (539, 'Memento', 177, 'weapon_mag7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (540, 'Faded Zebra', 176, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (541, 'Scorched', 175, 'weapon_p90;weapon_ump45;weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;weapon_knife_ursus;weapon_knife_gypsy_jackknife;weapon_knife_stiletto;weapon_knife_widowmaker;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (542, 'BOOM', 174, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (543, 'Black Laminate', 172, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (544, 'Irradiated Alert', 171, 'weapon_bizon;weapon_mag7;weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (545, 'Predator', 170, 'weapon_ak47;weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (546, 'Fallout Warning', 169, 'weapon_p90;weapon_ump45;weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (547, 'Nuclear Threat', 168, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (548, 'Radiation Hazard', 167, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (549, 'Blaze Orange', 166, 'weapon_xm1014;weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (550, 'Splash Jam', 165, 'weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (551, 'Modern Hunter', 164, 'weapon_m4a1;weapon_bizon;weapon_nova;weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (552, 'Splash', 162, 'weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (553, 'Brass', 159, 'weapon_glock;weapon_bizon;weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (554, 'Walnut', 158, 'weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (555, 'Palm', 157, 'weapon_mac10;weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (556, 'Death by Kitty', 156, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (557, 'Bullet Rain', 155, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (558, 'Afterimage', 154, 'weapon_famas;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (559, 'Demolition', 153, 'weapon_elite;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (560, 'Jungle', 151, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (561, 'Urban Dashed', 149, 'weapon_bizon;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (562, 'Sand Dashed', 148, 'weapon_bizon;weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (563, 'Jungle Dashed', 147, 'weapon_g3sg1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (564, 'Urban Masked', 143, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;weapon_knife_ursus;weapon_knife_gypsy_jackknife;weapon_knife_stiletto;weapon_knife_widowmaker;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (565, 'Orange Peel', 141, 'weapon_fiveseven;weapon_mp7;weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (566, 'Waves Perforated', 136, 'weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (567, 'Urban Perforated', 135, 'weapon_xm1014;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (568, 'Sand Spray', 124, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (569, 'Jungle Spray', 122, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (570, 'Sage Spray', 119, 'weapon_galilar;weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (571, 'Sand Mesh', 116, 'weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (572, 'Glacier Mesh', 111, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (573, 'Condemned', 110, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (574, 'Polar Mesh', 107, 'weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (575, 'Grassland Leaves', 104, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (576, 'Whiteout', 102, 'weapon_mp7;weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (577, 'Tornado', 101, 'weapon_m4a1;weapon_mac10;weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (578, 'Storm', 100, 'weapon_aug;weapon_p90;weapon_mag7;weapon_mp9;weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (579, 'Sand Dune', 99, 'weapon_mag7;weapon_nova;weapon_p250;weapon_ssg08;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (580, 'Ultraviolet', 98, 'weapon_mac10;weapon_sg556;weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (581, 'Blue Spruce', 96, 'weapon_xm1014;weapon_ssg08;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (582, 'Grassland', 95, 'weapon_xm1014;weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (583, 'Caramel', 93, 'weapon_ump45;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (584, 'Cyanospatter', 92, 'weapon_famas;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (585, 'Mudder', 90, 'weapon_deagle;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (586, 'Pink DDPAT', 84, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (587, 'Orange DDPAT', 83, 'weapon_galilar;weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (588, 'Forest Night', 78, 'weapon_fiveseven;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (589, 'Boreal Forest', 77, 'weapon_p250;weapon_m4a1_silencer;weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;weapon_knife_ursus;weapon_knife_gypsy_jackknife;weapon_knife_stiletto;weapon_knife_widowmaker;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (590, 'Winter Forest', 76, 'weapon_galilar;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (591, 'Blizzard Marbleized', 75, 'weapon_m249;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (592, 'Polar Camo', 74, 'weapon_g3sg1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (593, 'Wings', 73, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (594, 'Safari Mesh', 72, 'weapon_ak47;weapon_awp;weapon_g3sg1;weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;weapon_knife_ursus;weapon_knife_gypsy_jackknife;weapon_knife_stiletto;weapon_knife_widowmaker;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (595, 'Scorpion', 71, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (596, 'Carbon Fiber', 70, 'weapon_ump45;weapon_bizon;weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (597, 'Cold Blooded', 67, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (598, 'Bloomstick', 62, 'weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (599, 'Hypnotic', 61, 'weapon_deagle;weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (600, 'Dark Water', 60, 'weapon_ssg08;weapon_m4a1_silencer;weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (601, 'Slaughter', 59, 'weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;weapon_knife_ursus;weapon_knife_gypsy_jackknife;weapon_knife_stiletto;weapon_knife_widowmaker;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (602, 'Lightning Strike', 51, 'weapon_awp;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (603, 'Dragon Tattoo', 48, 'weapon_glock;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (604, 'Colony', 47, 'weapon_elite;weapon_aug;weapon_famas;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (605, 'Contractor', 46, 'weapon_elite;weapon_fiveseven;weapon_aug;weapon_g3sg1;weapon_scar20;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (606, 'Case Hardened', 44, 'weapon_fiveseven;weapon_ak47;weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;weapon_knife_ursus;weapon_knife_gypsy_jackknife;weapon_knife_stiletto;weapon_knife_widowmaker;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (607, 'Stained', 43, 'weapon_elite;weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;weapon_knife_ursus;weapon_knife_gypsy_jackknife;weapon_knife_stiletto;weapon_knife_widowmaker;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (608, 'Blue Steel', 42, 'weapon_xm1014;weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;weapon_knife_ursus;weapon_knife_gypsy_jackknife;weapon_knife_stiletto;weapon_knife_widowmaker;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (609, 'Copper', 41, 'weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (610, 'Night', 40, 'weapon_deagle;weapon_glock;weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (611, 'Bulldozer', 39, 'weapon_mag7;weapon_mp9;weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (612, 'Fade', 38, 'weapon_glock;weapon_mac10;weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;weapon_knife_ursus;weapon_knife_gypsy_jackknife;weapon_knife_stiletto;weapon_knife_widowmaker;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (613, 'Blaze', 37, 'weapon_deagle;weapon_ump45;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (614, 'Ossified', 36, 'weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (615, 'Metallic DDPAT', 34, 'weapon_mag7;weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (616, 'Hot Rod', 33, 'weapon_aug;weapon_mp9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (617, 'Silver', 32, 'weapon_mac10;weapon_mag7;weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (618, 'Snake Camo', 30, 'weapon_awp;weapon_sawedoff;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (619, 'Anodized Navy', 28, 'weapon_elite;weapon_negev;weapon_mp7;weapon_sg556;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (620, 'Bone Mask', 27, 'weapon_p250;weapon_revolver;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (621, 'Lichen Dashed', 26, 'weapon_ssg08;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (622, 'Forest Leaves', 25, 'weapon_bizon;weapon_nova;weapon_usp_silencer;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (623, 'Contrast Spray', 22, 'weapon_famas;weapon_m249;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (624, 'Granite Marbleized', 21, 'weapon_hkp2000;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (625, 'Virus', 20, 'weapon_p90;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (626, 'Urban DDPAT', 17, 'weapon_deagle;weapon_m4a1;weapon_mac10;weapon_ump45;weapon_tec9;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (627, 'Jungle Tiger', 16, 'weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (628, 'Gunsmoke', 15, 'weapon_ump45;weapon_mp7;weapon_p250;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (629, 'Red Laminate', 14, 'weapon_ak47;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (630, 'Blue Streak', 13, 'weapon_bizon;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (631, 'Crimson Web', 12, 'weapon_cz75a;weapon_revolver;weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;weapon_knife_ursus;weapon_knife_gypsy_jackknife;weapon_knife_stiletto;weapon_knife_widowmaker;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (632, 'Skulls', 11, 'weapon_mp7;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (633, 'Copperhead', 10, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (634, 'Bengal Tiger', 9, 'weapon_aug;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (635, 'Desert Storm', 8, 'weapon_g3sg1;weapon_m4a1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (636, 'Arctic Camo', 6, 'weapon_g3sg1;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (637, 'Forest DDPAT', 5, 'weapon_sawedoff;weapon_mp7;weapon_bayonet;weapon_knife_flip;weapon_knife_gut;weapon_knife_karambit;weapon_knife_m9_bayonet;weapon_knife_tactical;weapon_knife_falchion;weapon_knife_survival_bowie;weapon_knife_butterfly;weapon_knife_push;weapon_knife_ursus;weapon_knife_gypsy_jackknife;weapon_knife_stiletto;weapon_knife_widowmaker;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (638, 'Candy Apple', 3, 'weapon_fiveseven;weapon_glock;weapon_mac10;weapon_nova;');
INSERT INTO csgo_dev.cs_skins (id, displayName, skinId, weapons) VALUES (639, 'Groundwater', 2, 'weapon_glock;weapon_tec9;');
create table user_groups
(
  id       int auto_increment
    primary key,
  name     varchar(32)   not null,
  tag      varchar(16)   null,
  immunity int default 0 not null,
  flags    varchar(26)   null,
  constraint user_groups_name_uindex
    unique (name),
  constraint user_groups_tag_uindex
    unique (tag)
);

INSERT INTO csgo_dev.user_groups (id, name, tag, immunity, flags) VALUES (1, 'Default', null, 0, null);
INSERT INTO csgo_dev.user_groups (id, name, tag, immunity, flags) VALUES (2, 'Executive', 'EXEC', 99, 'z');
INSERT INTO csgo_dev.user_groups (id, name, tag, immunity, flags) VALUES (3, 'Developer', 'DEV', 99, 'z');
create table users
(
  id        int auto_increment,
  username  varchar(32)                           not null,
  steamId   varchar(64)                           not null,
  `group`   int       default 1                   not null,
  createdAt timestamp default current_timestamp() not null,
  updatedAt timestamp default current_timestamp() not null,
  constraint users_id_uindex
    unique (id),
  constraint users_steamId_uindex
    unique (steamId),
  constraint users_username_uindex
    unique (username),
  constraint users_user_groups_id_fk
    foreign key (`group`) references user_groups (id)
      on update cascade
);

alter table users
  add primary key (id);

INSERT INTO csgo_dev.users (id, username, steamId, `group`, createdAt, updatedAt) VALUES (1, 'MP', 'STEAM_1:1:530997', 3, '2019-01-20 18:58:18', '2019-01-20 18:58:18');