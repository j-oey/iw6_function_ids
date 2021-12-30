// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID1644["sentry_overheat_mp"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_sg_overheat_smoke" );
    level._ID1644["sentry_explode_mp"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ims_explosion" );
    level._ID1644["sentry_smoke_mp"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_sg_damage_blacksmoke" );
    level._ID28172 = [];
    level._ID28172["alien_sentry"] = spawnstruct();
    level._ID28172["alien_sentry"].health = 999999;
    level._ID28172["alien_sentry"].maxhealth = 300;
    level._ID28172["alien_sentry"].burstmin = 5;
    level._ID28172["alien_sentry"]._ID6331 = 40;
    level._ID28172["alien_sentry"]._ID23388 = 0.15;
    level._ID28172["alien_sentry"]._ID23387 = 0.35;
    level._ID28172["alien_sentry"]._ID28168 = "sentry";
    level._ID28172["alien_sentry"]._ID28167 = "sentry_offline";
    level._ID28172["alien_sentry"].timeout = 600.0;
    level._ID28172["alien_sentry"]._ID31014 = 1.0;
    level._ID28172["alien_sentry"].overheattime = 5.0;
    level._ID28172["alien_sentry"].cooldowntime = 0.1;
    level._ID28172["alien_sentry"].fxtime = 0.3;
    level._ID28172["alien_sentry"]._ID31889 = "sentry";
    level._ID28172["alien_sentry"].weaponinfo = "alien_sentry_minigun_1_mp";
    level._ID28172["alien_sentry"].modelbase = "weapon_sentry_chaingun";
    level._ID28172["alien_sentry"]._ID21276 = "weapon_sentry_chaingun_obj";
    level._ID28172["alien_sentry"]._ID21277 = "weapon_sentry_chaingun_obj_red";
    level._ID28172["alien_sentry"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["alien_sentry"]._ID16999 = &"SENTRY_PICKUP";
    level._ID28172["alien_sentry"].headicon = 1;
    level._ID28172["alien_sentry"]._ID32680 = "used_sentry";
    level._ID28172["alien_sentry"]._ID29893 = 0;
    level._ID28172["alien_sentry"]._ID35387 = "sentry_destroyed";
    level._ID28172["alien_sentry"].issentient = 1;
    level._ID28172["alien_sentry_1"] = spawnstruct();
    level._ID28172["alien_sentry_1"].health = 999999;
    level._ID28172["alien_sentry_1"].maxhealth = 300;
    level._ID28172["alien_sentry_1"].burstmin = 5;
    level._ID28172["alien_sentry_1"]._ID6331 = 40;
    level._ID28172["alien_sentry_1"]._ID23388 = 0.15;
    level._ID28172["alien_sentry_1"]._ID23387 = 0.35;
    level._ID28172["alien_sentry_1"]._ID28168 = "sentry";
    level._ID28172["alien_sentry_1"]._ID28167 = "sentry_offline";
    level._ID28172["alien_sentry_1"].timeout = 600.0;
    level._ID28172["alien_sentry_1"]._ID31014 = 1.0;
    level._ID28172["alien_sentry_1"].overheattime = 5.0;
    level._ID28172["alien_sentry_1"].cooldowntime = 0.1;
    level._ID28172["alien_sentry_1"].fxtime = 0.3;
    level._ID28172["alien_sentry_1"]._ID31889 = "sentry";
    level._ID28172["alien_sentry_1"].weaponinfo = "alien_sentry_minigun_2_mp";
    level._ID28172["alien_sentry_1"].modelbase = "weapon_sentry_chaingun";
    level._ID28172["alien_sentry_1"]._ID21276 = "weapon_sentry_chaingun_obj";
    level._ID28172["alien_sentry_1"]._ID21277 = "weapon_sentry_chaingun_obj_red";
    level._ID28172["alien_sentry_1"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["alien_sentry_1"]._ID16999 = &"SENTRY_PICKUP";
    level._ID28172["alien_sentry_1"].headicon = 1;
    level._ID28172["alien_sentry_1"]._ID32680 = "used_sentry";
    level._ID28172["alien_sentry_1"]._ID29893 = 0;
    level._ID28172["alien_sentry_1"]._ID35387 = "sentry_destroyed";
    level._ID28172["alien_sentry_1"].issentient = 1;
    level._ID28172["alien_sentry_2"] = spawnstruct();
    level._ID28172["alien_sentry_2"].health = 999999;
    level._ID28172["alien_sentry_2"].maxhealth = 300;
    level._ID28172["alien_sentry_2"].burstmin = 10;
    level._ID28172["alien_sentry_2"]._ID6331 = 80;
    level._ID28172["alien_sentry_2"]._ID23388 = 0.15;
    level._ID28172["alien_sentry_2"]._ID23387 = 0.25;
    level._ID28172["alien_sentry_2"]._ID28168 = "sentry";
    level._ID28172["alien_sentry_2"]._ID28167 = "sentry_offline";
    level._ID28172["alien_sentry_2"].timeout = 600.0;
    level._ID28172["alien_sentry_2"]._ID31014 = 1.0;
    level._ID28172["alien_sentry_2"].overheattime = 5.0;
    level._ID28172["alien_sentry_2"].cooldowntime = 0.2;
    level._ID28172["alien_sentry_2"].fxtime = 0.3;
    level._ID28172["alien_sentry_2"]._ID31889 = "sentry";
    level._ID28172["alien_sentry_2"].weaponinfo = "alien_sentry_minigun_3_mp";
    level._ID28172["alien_sentry_2"].modelbase = "weapon_sentry_chaingun";
    level._ID28172["alien_sentry_2"]._ID21276 = "weapon_sentry_chaingun_obj";
    level._ID28172["alien_sentry_2"]._ID21277 = "weapon_sentry_chaingun_obj_red";
    level._ID28172["alien_sentry_2"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["alien_sentry_2"]._ID16999 = &"SENTRY_PICKUP";
    level._ID28172["alien_sentry_2"].headicon = 1;
    level._ID28172["alien_sentry_2"]._ID32680 = "used_sentry";
    level._ID28172["alien_sentry_2"]._ID29893 = 0;
    level._ID28172["alien_sentry_2"]._ID35387 = "sentry_destroyed";
    level._ID28172["alien_sentry_2"].issentient = 1;
    level._ID28172["alien_sentry_3"] = spawnstruct();
    level._ID28172["alien_sentry_3"].health = 999999;
    level._ID28172["alien_sentry_3"].maxhealth = 300;
    level._ID28172["alien_sentry_3"].burstmin = 10;
    level._ID28172["alien_sentry_3"]._ID6331 = 80;
    level._ID28172["alien_sentry_3"]._ID23388 = 0.15;
    level._ID28172["alien_sentry_3"]._ID23387 = 0.25;
    level._ID28172["alien_sentry_3"]._ID28168 = "sentry";
    level._ID28172["alien_sentry_3"]._ID28167 = "sentry_offline";
    level._ID28172["alien_sentry_3"].timeout = 600.0;
    level._ID28172["alien_sentry_3"]._ID31014 = 1.0;
    level._ID28172["alien_sentry_3"].overheattime = 5.0;
    level._ID28172["alien_sentry_3"].cooldowntime = 0.2;
    level._ID28172["alien_sentry_3"].fxtime = 0.3;
    level._ID28172["alien_sentry_3"]._ID31889 = "sentry";
    level._ID28172["alien_sentry_3"].weaponinfo = "alien_sentry_minigun_4_mp";
    level._ID28172["alien_sentry_3"].modelbase = "weapon_sentry_chaingun";
    level._ID28172["alien_sentry_3"]._ID21276 = "weapon_sentry_chaingun_obj";
    level._ID28172["alien_sentry_3"]._ID21277 = "weapon_sentry_chaingun_obj_red";
    level._ID28172["alien_sentry_3"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["alien_sentry_3"]._ID16999 = &"SENTRY_PICKUP";
    level._ID28172["alien_sentry_3"].headicon = 1;
    level._ID28172["alien_sentry_3"]._ID32680 = "used_sentry";
    level._ID28172["alien_sentry_3"]._ID29893 = 0;
    level._ID28172["alien_sentry_3"]._ID35387 = "sentry_destroyed";
    level._ID28172["alien_sentry_3"].issentient = 1;
    level._ID28172["alien_sentry_4"] = spawnstruct();
    level._ID28172["alien_sentry_4"].health = 999999;
    level._ID28172["alien_sentry_4"].maxhealth = 300;
    level._ID28172["alien_sentry_4"].burstmin = 10;
    level._ID28172["alien_sentry_4"]._ID6331 = 80;
    level._ID28172["alien_sentry_4"]._ID23388 = 0.15;
    level._ID28172["alien_sentry_4"]._ID23387 = 0.25;
    level._ID28172["alien_sentry_4"]._ID28168 = "sentry";
    level._ID28172["alien_sentry_4"]._ID28167 = "sentry_offline";
    level._ID28172["alien_sentry_4"].timeout = 600.0;
    level._ID28172["alien_sentry_4"]._ID31014 = 1.0;
    level._ID28172["alien_sentry_4"].overheattime = 6.0;
    level._ID28172["alien_sentry_4"].cooldowntime = 0.2;
    level._ID28172["alien_sentry_4"].fxtime = 0.3;
    level._ID28172["alien_sentry_4"]._ID31889 = "sentry";
    level._ID28172["alien_sentry_4"].weaponinfo = "alien_sentry_minigun_4_mp";
    level._ID28172["alien_sentry_4"].modelbase = "weapon_sentry_chaingun";
    level._ID28172["alien_sentry_4"]._ID21276 = "weapon_sentry_chaingun_obj";
    level._ID28172["alien_sentry_4"]._ID21277 = "weapon_sentry_chaingun_obj_red";
    level._ID28172["alien_sentry_4"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["alien_sentry_4"]._ID16999 = &"SENTRY_PICKUP";
    level._ID28172["alien_sentry_4"].headicon = 1;
    level._ID28172["alien_sentry_4"]._ID32680 = "used_sentry";
    level._ID28172["alien_sentry_4"]._ID29893 = 0;
    level._ID28172["alien_sentry_4"]._ID35387 = "sentry_destroyed";
    level._ID28172["alien_sentry_4"].issentient = 1;
    level._ID28172["gl_turret"] = spawnstruct();
    level._ID28172["gl_turret"].health = 999999;
    level._ID28172["gl_turret"].maxhealth = 650;
    level._ID28172["gl_turret"].burstmin = 20;
    level._ID28172["gl_turret"]._ID6331 = 130;
    level._ID28172["gl_turret"]._ID23388 = 0.15;
    level._ID28172["gl_turret"]._ID23387 = 0.35;
    level._ID28172["gl_turret"]._ID28168 = "manual";
    level._ID28172["gl_turret"]._ID28167 = "sentry_offline";
    level._ID28172["gl_turret"].timeout = 600.0;
    level._ID28172["gl_turret"]._ID31014 = 0.05;
    level._ID28172["gl_turret"].overheattime = 2.5;
    level._ID28172["gl_turret"].cooldowntime = 0.5;
    level._ID28172["gl_turret"].fxtime = 0.3;
    level._ID28172["gl_turret"]._ID31889 = "grenade";
    level._ID28172["gl_turret"].weaponinfo = "alien_manned_gl_turret_mp";
    level._ID28172["gl_turret"].modelbase = "weapon_standing_turret_grenade_launcher";
    level._ID28172["gl_turret"]._ID21276 = "weapon_standing_turret_grenade_launcher_obj";
    level._ID28172["gl_turret"]._ID21277 = "weapon_standing_turret_grenade_launcher_obj_red";
    level._ID28172["gl_turret"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["gl_turret"]._ID16999 = &"ALIEN_COLLECTIBLES_USE_TURRET";
    level._ID28172["gl_turret"]._ID23185 = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
    level._ID28172["gl_turret"].headicon = 0;
    level._ID28172["gl_turret"]._ID32680 = "used_gl_turret";
    level._ID28172["gl_turret"]._ID29893 = 1;
    level._ID28172["gl_turret"]._ID35387 = "sentry_destroyed";
    level._ID28172["gl_turret"].issentient = 0;
    level._ID28172["gl_turret_1"] = spawnstruct();
    level._ID28172["gl_turret_1"].health = 999999;
    level._ID28172["gl_turret_1"].maxhealth = 650;
    level._ID28172["gl_turret_1"].burstmin = 20;
    level._ID28172["gl_turret_1"]._ID6331 = 130;
    level._ID28172["gl_turret_1"]._ID23388 = 0.15;
    level._ID28172["gl_turret_1"]._ID23387 = 0.35;
    level._ID28172["gl_turret_1"]._ID28168 = "manual";
    level._ID28172["gl_turret_1"]._ID28167 = "sentry_offline";
    level._ID28172["gl_turret_1"].timeout = 600.0;
    level._ID28172["gl_turret_1"]._ID31014 = 0.05;
    level._ID28172["gl_turret_1"].overheattime = 2.5;
    level._ID28172["gl_turret_1"].cooldowntime = 0.5;
    level._ID28172["gl_turret_1"].fxtime = 0.3;
    level._ID28172["gl_turret_1"]._ID31889 = "grenade";
    level._ID28172["gl_turret_1"].weaponinfo = "alien_manned_gl_turret1_mp";
    level._ID28172["gl_turret_1"].modelbase = "weapon_standing_turret_grenade_launcher";
    level._ID28172["gl_turret_1"]._ID21276 = "weapon_standing_turret_grenade_launcher_obj";
    level._ID28172["gl_turret_1"]._ID21277 = "weapon_standing_turret_grenade_launcher_obj_red";
    level._ID28172["gl_turret_1"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["gl_turret_1"]._ID16999 = &"ALIEN_COLLECTIBLES_USE_TURRET";
    level._ID28172["gl_turret_1"]._ID23185 = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
    level._ID28172["gl_turret_1"].headicon = 0;
    level._ID28172["gl_turret_1"]._ID32680 = "used_gl_turret";
    level._ID28172["gl_turret_1"]._ID29893 = 1;
    level._ID28172["gl_turret_1"]._ID35387 = "sentry_destroyed";
    level._ID28172["gl_turret_1"].issentient = 0;
    level._ID28172["gl_turret_2"] = spawnstruct();
    level._ID28172["gl_turret_2"].health = 999999;
    level._ID28172["gl_turret_2"].maxhealth = 650;
    level._ID28172["gl_turret_2"].burstmin = 20;
    level._ID28172["gl_turret_2"]._ID6331 = 130;
    level._ID28172["gl_turret_2"]._ID23388 = 0.15;
    level._ID28172["gl_turret_2"]._ID23387 = 0.35;
    level._ID28172["gl_turret_2"]._ID28168 = "manual";
    level._ID28172["gl_turret_2"]._ID28167 = "sentry_offline";
    level._ID28172["gl_turret_2"].timeout = 600.0;
    level._ID28172["gl_turret_2"]._ID31014 = 0.05;
    level._ID28172["gl_turret_2"].overheattime = 2.5;
    level._ID28172["gl_turret_2"].cooldowntime = 0.5;
    level._ID28172["gl_turret_2"].fxtime = 0.3;
    level._ID28172["gl_turret_2"]._ID31889 = "grenade";
    level._ID28172["gl_turret_2"].weaponinfo = "alien_manned_gl_turret2_mp";
    level._ID28172["gl_turret_2"].modelbase = "weapon_standing_turret_grenade_launcher";
    level._ID28172["gl_turret_2"]._ID21276 = "weapon_standing_turret_grenade_launcher_obj";
    level._ID28172["gl_turret_2"]._ID21277 = "weapon_standing_turret_grenade_launcher_obj_red";
    level._ID28172["gl_turret_2"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["gl_turret_2"]._ID16999 = &"ALIEN_COLLECTIBLES_USE_TURRET";
    level._ID28172["gl_turret_2"]._ID23185 = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
    level._ID28172["gl_turret_2"].headicon = 0;
    level._ID28172["gl_turret_2"]._ID32680 = "used_gl_turret";
    level._ID28172["gl_turret_2"]._ID29893 = 1;
    level._ID28172["gl_turret_2"]._ID35387 = "sentry_destroyed";
    level._ID28172["gl_turret_2"].issentient = 0;
    level._ID28172["gl_turret_3"] = spawnstruct();
    level._ID28172["gl_turret_3"].health = 999999;
    level._ID28172["gl_turret_3"].maxhealth = 650;
    level._ID28172["gl_turret_3"].burstmin = 20;
    level._ID28172["gl_turret_3"]._ID6331 = 130;
    level._ID28172["gl_turret_3"]._ID23388 = 0.15;
    level._ID28172["gl_turret_3"]._ID23387 = 0.35;
    level._ID28172["gl_turret_3"]._ID28168 = "manual";
    level._ID28172["gl_turret_3"]._ID28167 = "sentry_offline";
    level._ID28172["gl_turret_3"].timeout = 600.0;
    level._ID28172["gl_turret_3"]._ID31014 = 0.05;
    level._ID28172["gl_turret_3"].overheattime = 2.5;
    level._ID28172["gl_turret_3"].cooldowntime = 0.5;
    level._ID28172["gl_turret_3"].fxtime = 0.3;
    level._ID28172["gl_turret_3"]._ID31889 = "grenade";
    level._ID28172["gl_turret_3"].weaponinfo = "alien_manned_gl_turret3_mp";
    level._ID28172["gl_turret_3"].modelbase = "weapon_standing_turret_grenade_launcher";
    level._ID28172["gl_turret_3"]._ID21276 = "weapon_standing_turret_grenade_launcher_obj";
    level._ID28172["gl_turret_3"]._ID21277 = "weapon_standing_turret_grenade_launcher_obj_red";
    level._ID28172["gl_turret_3"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["gl_turret_3"]._ID16999 = &"ALIEN_COLLECTIBLES_USE_TURRET";
    level._ID28172["gl_turret_3"]._ID23185 = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
    level._ID28172["gl_turret_3"].headicon = 0;
    level._ID28172["gl_turret_3"]._ID32680 = "used_gl_turret";
    level._ID28172["gl_turret_3"]._ID29893 = 1;
    level._ID28172["gl_turret_3"]._ID35387 = "sentry_destroyed";
    level._ID28172["gl_turret_3"].issentient = 0;
    level._ID28172["gl_turret_4"] = spawnstruct();
    level._ID28172["gl_turret_4"].health = 999999;
    level._ID28172["gl_turret_4"].maxhealth = 650;
    level._ID28172["gl_turret_4"].burstmin = 20;
    level._ID28172["gl_turret_4"]._ID6331 = 130;
    level._ID28172["gl_turret_4"]._ID23388 = 0.15;
    level._ID28172["gl_turret_4"]._ID23387 = 0.35;
    level._ID28172["gl_turret_4"]._ID28168 = "manual";
    level._ID28172["gl_turret_4"]._ID28167 = "sentry_offline";
    level._ID28172["gl_turret_4"].timeout = 600.0;
    level._ID28172["gl_turret_4"]._ID31014 = 0.05;
    level._ID28172["gl_turret_4"].overheattime = 2.5;
    level._ID28172["gl_turret_4"].cooldowntime = 0.5;
    level._ID28172["gl_turret_4"].fxtime = 0.3;
    level._ID28172["gl_turret_4"]._ID31889 = "grenade";
    level._ID28172["gl_turret_4"].weaponinfo = "alien_manned_gl_turret4_mp";
    level._ID28172["gl_turret_4"].modelbase = "weapon_standing_turret_grenade_launcher";
    level._ID28172["gl_turret_4"]._ID21276 = "weapon_standing_turret_grenade_launcher_obj";
    level._ID28172["gl_turret_4"]._ID21277 = "weapon_standing_turret_grenade_launcher_obj_red";
    level._ID28172["gl_turret_4"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["gl_turret_4"]._ID16999 = &"ALIEN_COLLECTIBLES_USE_TURRET";
    level._ID28172["gl_turret_4"]._ID23185 = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
    level._ID28172["gl_turret_4"].headicon = 0;
    level._ID28172["gl_turret_4"]._ID32680 = "used_gl_turret";
    level._ID28172["gl_turret_4"]._ID29893 = 1;
    level._ID28172["gl_turret_4"]._ID35387 = "sentry_destroyed";
    level._ID28172["gl_turret_4"].issentient = 0;
    level._ID28172["minigun_turret"] = spawnstruct();
    level._ID28172["minigun_turret"].health = 999999;
    level._ID28172["minigun_turret"].maxhealth = 650;
    level._ID28172["minigun_turret"].burstmin = 20;
    level._ID28172["minigun_turret"]._ID6331 = 130;
    level._ID28172["minigun_turret"]._ID23388 = 0.15;
    level._ID28172["minigun_turret"]._ID23387 = 0.35;
    level._ID28172["minigun_turret"]._ID28168 = "manual";
    level._ID28172["minigun_turret"]._ID28167 = "sentry_offline";
    level._ID28172["minigun_turret"].timeout = 600.0;
    level._ID28172["minigun_turret"]._ID31014 = 0.5;
    level._ID28172["minigun_turret"].overheattime = 4.0;
    level._ID28172["minigun_turret"].cooldowntime = 0.5;
    level._ID28172["minigun_turret"].fxtime = 0.3;
    level._ID28172["minigun_turret"]._ID31889 = "minigun";
    level._ID28172["minigun_turret"].weaponinfo = "alien_manned_minigun_turret_mp";
    level._ID28172["minigun_turret"].modelbase = "weapon_standing_turret_grenade_launcher";
    level._ID28172["minigun_turret"]._ID21276 = "weapon_standing_turret_grenade_launcher_obj";
    level._ID28172["minigun_turret"]._ID21277 = "weapon_standing_turret_grenade_launcher_obj_red";
    level._ID28172["minigun_turret"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["minigun_turret"]._ID16999 = &"ALIEN_COLLECTIBLES_USE_TURRET";
    level._ID28172["minigun_turret"]._ID23185 = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
    level._ID28172["minigun_turret"].headicon = 0;
    level._ID28172["minigun_turret"]._ID32680 = "used_minigun_turret";
    level._ID28172["minigun_turret"]._ID29893 = 1;
    level._ID28172["minigun_turret"]._ID35387 = "sentry_destroyed";
    level._ID28172["minigun_turret"].issentient = 0;
    level._ID28172["minigun_turret_1"] = spawnstruct();
    level._ID28172["minigun_turret_1"].health = 999999;
    level._ID28172["minigun_turret_1"].maxhealth = 650;
    level._ID28172["minigun_turret_1"].burstmin = 20;
    level._ID28172["minigun_turret_1"]._ID6331 = 130;
    level._ID28172["minigun_turret_1"]._ID23388 = 0.15;
    level._ID28172["minigun_turret_1"]._ID23387 = 0.35;
    level._ID28172["minigun_turret_1"]._ID28168 = "manual";
    level._ID28172["minigun_turret_1"]._ID28167 = "sentry_offline";
    level._ID28172["minigun_turret_1"].timeout = 600.0;
    level._ID28172["minigun_turret_1"]._ID31014 = 0.05;
    level._ID28172["minigun_turret_1"].overheattime = 4.0;
    level._ID28172["minigun_turret_1"].cooldowntime = 0.5;
    level._ID28172["minigun_turret_1"].fxtime = 0.3;
    level._ID28172["minigun_turret_1"]._ID31889 = "minigun";
    level._ID28172["minigun_turret_1"].weaponinfo = "alien_manned_minigun_turret1_mp";
    level._ID28172["minigun_turret_1"].modelbase = "weapon_standing_turret_grenade_launcher";
    level._ID28172["minigun_turret_1"]._ID21276 = "weapon_standing_turret_grenade_launcher_obj";
    level._ID28172["minigun_turret_1"]._ID21277 = "weapon_standing_turret_grenade_launcher_obj_red";
    level._ID28172["minigun_turret_1"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["minigun_turret_1"]._ID16999 = &"ALIEN_COLLECTIBLES_USE_TURRET";
    level._ID28172["minigun_turret_1"]._ID23185 = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
    level._ID28172["minigun_turret_1"].headicon = 0;
    level._ID28172["minigun_turret_1"]._ID32680 = "used_minigun_turret";
    level._ID28172["minigun_turret_1"]._ID29893 = 1;
    level._ID28172["minigun_turret_1"]._ID35387 = "sentry_destroyed";
    level._ID28172["minigun_turret_1"].issentient = 0;
    level._ID28172["minigun_turret_2"] = spawnstruct();
    level._ID28172["minigun_turret_2"].health = 999999;
    level._ID28172["minigun_turret_2"].maxhealth = 650;
    level._ID28172["minigun_turret_2"].burstmin = 20;
    level._ID28172["minigun_turret_2"]._ID6331 = 130;
    level._ID28172["minigun_turret_2"]._ID23388 = 0.15;
    level._ID28172["minigun_turret_2"]._ID23387 = 0.35;
    level._ID28172["minigun_turret_2"]._ID28168 = "manual";
    level._ID28172["minigun_turret_2"]._ID28167 = "sentry_offline";
    level._ID28172["minigun_turret_2"].timeout = 600.0;
    level._ID28172["minigun_turret_2"]._ID31014 = 0.05;
    level._ID28172["minigun_turret_2"].overheattime = 4.0;
    level._ID28172["minigun_turret_2"].cooldowntime = 0.5;
    level._ID28172["minigun_turret_2"].fxtime = 0.3;
    level._ID28172["minigun_turret_2"]._ID31889 = "minigun";
    level._ID28172["minigun_turret_2"].weaponinfo = "alien_manned_minigun_turret2_mp";
    level._ID28172["minigun_turret_2"].modelbase = "weapon_standing_turret_grenade_launcher";
    level._ID28172["minigun_turret_2"]._ID21276 = "weapon_standing_turret_grenade_launcher_obj";
    level._ID28172["minigun_turret_2"]._ID21277 = "weapon_standing_turret_grenade_launcher_obj_red";
    level._ID28172["minigun_turret_2"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["minigun_turret_2"]._ID16999 = &"ALIEN_COLLECTIBLES_USE_TURRET";
    level._ID28172["minigun_turret_2"]._ID23185 = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
    level._ID28172["minigun_turret_2"].headicon = 0;
    level._ID28172["minigun_turret_2"]._ID32680 = "used_minigun_turret";
    level._ID28172["minigun_turret_2"]._ID29893 = 1;
    level._ID28172["minigun_turret_2"]._ID35387 = "sentry_destroyed";
    level._ID28172["minigun_turret_2"].issentient = 0;
    level._ID28172["minigun_turret_3"] = spawnstruct();
    level._ID28172["minigun_turret_3"].health = 999999;
    level._ID28172["minigun_turret_3"].maxhealth = 650;
    level._ID28172["minigun_turret_3"].burstmin = 20;
    level._ID28172["minigun_turret_3"]._ID6331 = 130;
    level._ID28172["minigun_turret_3"]._ID23388 = 0.15;
    level._ID28172["minigun_turret_3"]._ID23387 = 0.35;
    level._ID28172["minigun_turret_3"]._ID28168 = "manual";
    level._ID28172["minigun_turret_3"]._ID28167 = "sentry_offline";
    level._ID28172["minigun_turret_3"].timeout = 600.0;
    level._ID28172["minigun_turret_3"]._ID31014 = 0.05;
    level._ID28172["minigun_turret_3"].overheattime = 4.0;
    level._ID28172["minigun_turret_3"].cooldowntime = 0.5;
    level._ID28172["minigun_turret_3"].fxtime = 0.3;
    level._ID28172["minigun_turret_3"]._ID31889 = "minigun";
    level._ID28172["minigun_turret_3"].weaponinfo = "alien_manned_minigun_turret3_mp";
    level._ID28172["minigun_turret_3"].modelbase = "weapon_standing_turret_grenade_launcher";
    level._ID28172["minigun_turret_3"]._ID21276 = "weapon_standing_turret_grenade_launcher_obj";
    level._ID28172["minigun_turret_3"]._ID21277 = "weapon_standing_turret_grenade_launcher_obj_red";
    level._ID28172["minigun_turret_3"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["minigun_turret_3"]._ID16999 = &"ALIEN_COLLECTIBLES_USE_TURRET";
    level._ID28172["minigun_turret_3"]._ID23185 = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
    level._ID28172["minigun_turret_3"].headicon = 0;
    level._ID28172["minigun_turret_3"]._ID32680 = "used_minigun_turret";
    level._ID28172["minigun_turret_3"]._ID29893 = 1;
    level._ID28172["minigun_turret_3"]._ID35387 = "sentry_destroyed";
    level._ID28172["minigun_turret_3"].issentient = 0;
    level._ID28172["minigun_turret_4"] = spawnstruct();
    level._ID28172["minigun_turret_4"].health = 999999;
    level._ID28172["minigun_turret_4"].maxhealth = 650;
    level._ID28172["minigun_turret_4"].burstmin = 20;
    level._ID28172["minigun_turret_4"]._ID6331 = 130;
    level._ID28172["minigun_turret_4"]._ID23388 = 0.15;
    level._ID28172["minigun_turret_4"]._ID23387 = 0.35;
    level._ID28172["minigun_turret_4"]._ID28168 = "manual";
    level._ID28172["minigun_turret_4"]._ID28167 = "sentry_offline";
    level._ID28172["minigun_turret_4"].timeout = 600.0;
    level._ID28172["minigun_turret_4"]._ID31014 = 0.05;
    level._ID28172["minigun_turret_4"].overheattime = 6.0;
    level._ID28172["minigun_turret_4"].cooldowntime = 0.5;
    level._ID28172["minigun_turret_4"].fxtime = 0.3;
    level._ID28172["minigun_turret_4"]._ID31889 = "minigun";
    level._ID28172["minigun_turret_4"].weaponinfo = "alien_manned_minigun_turret4_mp";
    level._ID28172["minigun_turret_4"].modelbase = "weapon_standing_turret_grenade_launcher";
    level._ID28172["minigun_turret_4"]._ID21276 = "weapon_standing_turret_grenade_launcher_obj";
    level._ID28172["minigun_turret_4"]._ID21277 = "weapon_standing_turret_grenade_launcher_obj_red";
    level._ID28172["minigun_turret_4"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["minigun_turret_4"]._ID16999 = &"ALIEN_COLLECTIBLES_USE_TURRET";
    level._ID28172["minigun_turret_4"]._ID23185 = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
    level._ID28172["minigun_turret_4"].headicon = 0;
    level._ID28172["minigun_turret_4"]._ID32680 = "used_minigun_turret";
    level._ID28172["minigun_turret_4"]._ID29893 = 1;
    level._ID28172["minigun_turret_4"]._ID35387 = "sentry_destroyed";
    level._ID28172["minigun_turret_4"].issentient = 0;
}

_ID15629( var_0 )
{
    self._ID19488 = var_0;
    var_1 = _ID8474( var_0, self );
    _ID26022();
    self._ID6724 = var_1;
    var_2 = _ID28668( var_1, 1 );
    self._ID6724 = undefined;
    thread _ID35602();
    self._ID18582 = 0;

    if ( isdefined( var_1 ) )
        return 1;
    else
        return 0;
}

_ID28668( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_0 _ID28140( self );
    common_scripts\utility::_disableweapon();
    self notifyonplayercommand( "place_sentry", "+attack" );
    self notifyonplayercommand( "place_sentry", "+attack_akimbo_accessible" );
    self notifyonplayercommand( "cancel_sentry", "+actionslot 4" );

    if ( !level.console )
    {
        self notifyonplayercommand( "cancel_sentry", "+actionslot 5" );
        self notifyonplayercommand( "cancel_sentry", "+actionslot 6" );
        self notifyonplayercommand( "cancel_sentry", "+actionslot 7" );
    }

    for (;;)
    {
        var_2 = common_scripts\utility::_ID35635( "place_sentry", "cancel_sentry", "force_cancel_placement" );

        if ( !isdefined( var_0 ) )
        {
            common_scripts\utility::_enableweapon();
            return 1;
        }

        if ( var_2 == "cancel_sentry" || var_2 == "force_cancel_placement" )
        {
            if ( !var_1 && var_2 == "cancel_sentry" )
                continue;

            if ( level.console )
            {
                var_3 = maps\mp\_utility::getkillstreakweapon( level._ID28172[var_0._ID28174]._ID31889 );

                if ( isdefined( self._ID19258 ) && var_3 == maps\mp\_utility::getkillstreakweapon( self.pers["killstreaks"][self._ID19258]._ID31889 ) && !self getweaponslistitems().size )
                {
                    maps\mp\_utility::_giveweapon( var_3, 0 );
                    maps\mp\_utility::_setactionslot( 4, "weapon", var_3 );
                }
            }

            var_0 _ID28138();
            common_scripts\utility::_enableweapon();
            return 0;
        }

        if ( !var_0.canbeplaced )
            continue;

        var_0 _ID28144();
        common_scripts\utility::_enableweapon();
        return 1;
    }
}

_ID26046()
{
    if ( self.hasriotshield )
    {
        var_0 = maps\mp\alien\_unk1464::_ID26334();
        self._ID26213 = var_0;
        self._ID26329 = self getammocount( var_0 );
        self takeweapon( var_0 );
    }
}

_ID26022()
{
    if ( maps\mp\_utility::_hasperk( "specialty_explosivebullets" ) )
    {
        self._ID26205 = "specialty_explosivebullets";
        maps\mp\_utility::_unsetperk( "specialty_explosivebullets" );
    }
}

_ID26215()
{
    if ( isdefined( self._ID26213 ) )
    {
        maps\mp\_utility::_giveweapon( self._ID26213 );

        if ( self.hasriotshield )
        {
            var_0 = maps\mp\alien\_unk1464::_ID26334();
            self setweaponammoclip( var_0, self._ID26329 );
        }
    }

    self._ID26213 = undefined;
}

_ID26206()
{
    if ( isdefined( self._ID26205 ) )
    {
        maps\mp\_utility::_ID15611( self._ID26205, 0 );
        self._ID26205 = undefined;
    }
}

_ID35602()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait 0.05;
    _ID26206();
}

_ID8474( var_0, var_1 )
{
    var_2 = spawnturret( "misc_turret", var_1.origin, level._ID28172[var_0].weaponinfo );
    var_2.angles = var_1.angles;
    var_2 sentry_initsentry( var_0, var_1 );
    return var_2;
}

sentry_initsentry( var_0, var_1 )
{
    self._ID28174 = var_0;
    self.canbeplaced = 1;
    self setmodel( level._ID28172[self._ID28174].modelbase );
    self._ID29893 = 1;
    self setcandamage( 1 );

    switch ( var_0 )
    {
        case "minigun_turret":
        case "gl_turret":
        case "minigun_turret_1":
        case "minigun_turret_2":
        case "minigun_turret_3":
        case "minigun_turret_4":
        case "gl_turret_1":
        case "gl_turret_2":
        case "gl_turret_3":
        case "gl_turret_4":
            self setleftarc( 65 );
            self setrightarc( 65 );
            self settoparc( 50 );
            self setbottomarc( 30 );
            self setdefaultdroppitch( 0.0 );
            self._ID23036 = var_1;
            break;
        default:
            self maketurretinoperable();
            self setdefaultdroppitch( -89.0 );
            break;
    }

    self setturretmodechangewait( 1 );
    _ID28142();
    _ID28143( var_1 );
    thread _ID28099();
    thread _ID28100();
    thread _ID28158();

    switch ( var_0 )
    {
        case "minigun_turret":
        case "minigun_turret_1":
        case "minigun_turret_2":
        case "minigun_turret_3":
        case "minigun_turret_4":
            self._ID21295 = 0;
            self.heatlevel = 0;
            self._ID23149 = 0;
            thread _ID28104();
            break;
        case "gl_turret":
        case "gl_turret_1":
        case "gl_turret_2":
        case "gl_turret_3":
        case "gl_turret_4":
            self._ID21295 = 0;
            self.heatlevel = 0;
            self.cooldownwaittime = 0;
            self._ID23149 = 0;
            thread _ID34026();
            thread turret_coolmonitor();
            break;
        default:
            _ID28560();
            thread _ID28102();
            thread _ID28074();
            thread _ID28079();
            break;
    }
}

_ID28099()
{
    self endon( "death" );
    level endon( "game_ended" );
    self.health = level._ID28172[self._ID28174].health;
    self.maxhealth = level._ID28172[self._ID28174].maxhealth;
    self.damagetaken = 0;

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( !maps\mp\gametypes\_weapons::_ID13695( self.owner, var_1, 0 ) )
            continue;

        if ( isdefined( var_8 ) && var_8 & level.idflags_penetration )
            self._ID35910 = 1;

        if ( var_4 == "MOD_MELEE" )
            self.damagetaken = self.damagetaken + self.maxhealth;

        var_10 = var_0;

        if ( isplayer( var_1 ) )
        {
            var_1 maps\mp\gametypes\_damagefeedback::_ID34528( "sentry" );

            if ( var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
                var_10 = var_0 * level.armorpiercingmod;
        }

        if ( isdefined( var_1.owner ) && isplayer( var_1.owner ) )
            var_1.owner maps\mp\gametypes\_damagefeedback::_ID34528( "sentry" );

        self.damagetaken = self.damagetaken + var_10;

        if ( self.damagetaken >= self.maxhealth )
        {
            thread maps\mp\gametypes\_missions::vehiclekilled( self.owner, self, undefined, var_1, var_0, var_4, var_9 );

            if ( isplayer( var_1 ) && ( !isdefined( self.owner ) || var_1 != self.owner ) )
            {
                var_1 thread maps\mp\gametypes\_rank::giverankxp( "kill", 100, var_9, var_4 );
                var_1 notify( "destroyed_killstreak" );

                if ( isdefined( self._ID34166 ) && self._ID34166 != var_1 )
                    self._ID34166 thread maps\mp\killstreaks\_remoteuav::_ID25854();
            }

            if ( isdefined( self.owner ) )
                self.owner thread maps\mp\_utility::_ID19765( level._ID28172[self._ID28174]._ID35387, undefined, undefined, self.origin );

            self notify( "death" );
            return;
        }
    }
}

_ID28163()
{
    self endon( "carried" );
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "emp_damage",  var_0, var_1  );
        playfxontag( common_scripts\utility::_ID15033( "sentry_explode_mp" ), self, "tag_aim" );
        self setdefaultdroppitch( 40 );
        self setmode( level._ID28172[self._ID28174]._ID28167 );
        wait(var_1);
        self setdefaultdroppitch( -89.0 );
        self setmode( level._ID28172[self._ID28174]._ID28168 );
    }
}

_ID28100()
{
    self waittill( "death" );

    if ( !isdefined( self ) )
        return;

    self freeentitysentient();
    self setmodel( level._ID28172[self._ID28174]._ID21271 );
    _ID28142();
    self setdefaultdroppitch( 40 );

    if ( isdefined( self.carriedby ) )
        self setsentrycarrier( undefined );

    self setsentryowner( undefined );
    self setturretminimapvisible( 0 );

    if ( isdefined( self._ID23194 ) )
        self._ID23194 delete();

    self playsound( "sentry_explode" );

    switch ( self._ID28174 )
    {
        case "minigun_turret":
        case "gl_turret":
            self._ID13518 = 1;
            self turretfiredisable();
            break;
        default:
            break;
    }

    if ( isdefined( self ) )
        thread _ID28088();
}

_ID28088()
{
    self notify( "sentry_delete_turret" );
    self endon( "sentry_delete_turret" );

    if ( isdefined( self._ID18319 ) )
    {
        playfxontag( common_scripts\utility::_ID15033( "sentry_explode_mp" ), self, "tag_origin" );
        playfxontag( common_scripts\utility::_ID15033( "sentry_smoke_mp" ), self, "tag_aim" );
        self._ID18319 setclientomnvar( "ui_alien_turret_overheat", -1 );
        self._ID18319 _ID26206();
        self._ID18319 _ID26215();
        self notify( "deleting" );
        self useby( self._ID18319 );
        wait 1.0;
    }
    else
    {
        wait 1.5;
        playfxontag( common_scripts\utility::_ID15033( "sentry_explode_mp" ), self, "tag_aim" );
        playfxontag( common_scripts\utility::_ID15033( "sentry_smoke_mp" ), self, "tag_aim" );
        self playsound( "sentry_explode_smoke" );
        wait 0.1;
        self notify( "deleting" );
    }

    if ( isdefined( self._ID19214 ) )
        self._ID19214 delete();

    if ( isdefined( self ) )
        self delete();
}

_ID28102()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger",  var_0  );

        if ( !maps\mp\_utility::_ID18757( var_0 ) )
            continue;

        var_0 _ID28668( self, 0 );
    }
}

_ID34021( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "sentry_delete_turret" );

    if ( !isdefined( var_0._ID23194 ) )
        return;

    var_1 = 0;

    for (;;)
    {
        if ( isalive( self ) && self istouching( var_0._ID23194 ) && !isdefined( var_0._ID18319 ) && !isdefined( var_0.carriedby ) && self isonground() && !isdefined( var_0._ID9631 ) )
        {
            if ( self usebuttonpressed() )
            {
                var_1 = 0;

                while ( self usebuttonpressed() )
                {
                    var_1 += 0.05;
                    wait 0.05;
                }

                if ( var_1 >= 0.25 )
                    continue;

                var_1 = 0;

                while ( !self usebuttonpressed() && var_1 < 0.25 )
                {
                    var_1 += 0.05;
                    wait 0.05;
                }

                if ( var_1 >= 0.25 )
                    continue;

                if ( !_ID36942( var_0 ) )
                    continue;

                var_0 setmode( level._ID28172[var_0._ID28174]._ID28167 );
                thread _ID28668( var_0, 0 );
                var_0._ID23194 delete();
                return;
            }
        }

        wait 0.05;
    }
}

_ID38179( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "sentry_delete_turret" );

    if ( !isdefined( var_0._ID23194 ) )
        return;

    var_1 = 0;

    for (;;)
    {
        if ( isalive( self ) && self istouching( var_0._ID23194 ) && !isdefined( var_0._ID18319 ) && !isdefined( var_0.carriedby ) && self isonground() && !isdefined( var_0._ID9631 ) )
        {
            if ( self meleebuttonpressed() )
            {
                var_1 = 0;

                while ( self meleebuttonpressed() )
                {
                    var_1 += 0.05;
                    wait 0.05;
                }

                if ( var_1 >= 0.5 )
                    continue;

                var_1 = 0;

                while ( !self meleebuttonpressed() && var_1 < 0.5 )
                {
                    var_1 += 0.05;
                    wait 0.05;
                }

                if ( var_1 >= 0.5 )
                    continue;

                if ( !_ID36942( var_0 ) )
                    continue;

                var_0 setmode( level._ID28172[var_0._ID28174]._ID28167 );
                thread _ID28668( var_0, 0 );
                var_0._ID23194 delete();
                return;
            }
        }

        wait 0.05;
    }
}

_ID36942( var_0 )
{
    if ( !maps\mp\_utility::_ID18757( self ) )
        return 0;

    if ( isdefined( self._ID34793 ) && self._ID34793 )
        return 0;

    if ( self isusingturret() || isdefined( var_0._ID9631 ) )
        return 0;

    if ( maps\mp\alien\_unk1464::_ID18431() )
        return 0;

    if ( maps\mp\alien\_unk1464::_ID18506( self._ID18582 ) )
        return 0;

    if ( isdefined( var_0._ID18319 ) )
        return 0;

    if ( isdefined( level.drill_carrier ) && level.drill_carrier == self )
        return 0;

    if ( isdefined( self._ID25826 ) )
        return 0;

    return 1;
}

_ID34022()
{
    self notify( "turret_handluse" );
    self endon( "turret_handleuse" );
    self endon( "deleting" );
    level endon( "game_ended" );
    self._ID13518 = 0;
    var_0 = ( 1, 0.9, 0.7 );
    var_1 = ( 1, 0.65, 0 );
    var_2 = ( 1, 0.25, 0 );

    for (;;)
    {
        self waittill( "trigger",  var_3  );

        if ( isdefined( self.carriedby ) )
            continue;

        if ( isdefined( self._ID18319 ) )
            continue;

        if ( !maps\mp\_utility::_ID18757( var_3 ) )
            continue;

        if ( var_3 maps\mp\alien\_unk1464::_ID18431() )
            continue;

        if ( isdefined( level.drill_carrier ) && var_3 == level.drill_carrier )
            continue;

        var_3 _ID26022();
        var_3 notify( "weapon_change",  "none"  );
        self._ID18319 = var_3;
        self setmode( level._ID28172[self._ID28174]._ID28167 );
        _ID28143( var_3 );
        self setmode( level._ID28172[self._ID28174]._ID28168 );
        var_3 thread _ID34057( self );
        var_3 setclientomnvar( "ui_alien_turret_overheat", 0 );
        var_4 = 0;
        var_5 = 0;
        var_3 maps\mp\_utility::setlowermessage( "disengage_turret", &"ALIEN_COLLECTIBLES_DISENGAGE_TURRET", 4 );

        for (;;)
        {
            if ( !maps\mp\_utility::_ID18757( var_3 ) )
            {
                self._ID18319 = undefined;
                var_3 setclientomnvar( "ui_alien_turret_overheat", -1 );
                var_3 maps\mp\_utility::_ID7495( "disengage_turret" );
                break;
            }

            if ( !var_3 isusingturret() )
            {
                self notify( "player_dismount" );
                self._ID18319 = undefined;
                var_3 _ID26206();
                var_3 _ID26215();
                self sethintstring( level._ID28172[self._ID28174]._ID16999 );
                self setmode( level._ID28172[self._ID28174]._ID28167 );
                _ID28143( self._ID23036 );
                self setmode( level._ID28172[self._ID28174]._ID28168 );
                var_3 setclientomnvar( "ui_alien_turret_overheat", -1 );
                var_3 maps\mp\_utility::_ID7495( "disengage_turret" );
                break;
            }

            if ( self.heatlevel >= level._ID28172[self._ID28174].overheattime )
                var_6 = 1;
            else
                var_6 = self.heatlevel / level._ID28172[self._ID28174].overheattime;

            var_7 = 5;
            var_8 = int( var_6 * 100 );

            if ( var_5 != var_8 )
            {
                if ( var_8 <= var_7 || abs( abs( var_5 ) - abs( var_8 ) ) > var_7 )
                {
                    var_3 setclientomnvar( "ui_alien_turret_overheat", var_8 );
                    var_5 = var_8;
                }
            }

            if ( common_scripts\utility::string_starts_with( self._ID28174, "minigun_turret" ) )
                var_9 = "minigun_turret";

            if ( self._ID13518 || self._ID23149 )
            {
                self turretfiredisable();
                var_4 = 0;
            }
            else
            {
                self turretfireenable();
                var_4 = 0;
                self notify( "not_overheated" );
            }

            wait 0.05;
        }

        var_3 maps\mp\_utility::_ID7495( "disengage_turret" );
        self setdefaultdroppitch( 0.0 );
        var_3 setclientomnvar( "ui_alien_turret_overheat", -1 );
    }
}

_ID28101()
{
    self endon( "death" );
    level endon( "game_ended" );
    self notify( "sentry_handleOwner" );
    self endon( "sentry_handleOwner" );
    self.owner waittill( "killstreak_disowned" );
    self notify( "death" );
}

_ID28143( var_0 )
{
    var_0._ID8662 = self;
    self.owner = var_0;
    self setsentryowner( self.owner );
    self setturretminimapvisible( 1, self._ID28174 );

    if ( level._ID32653 )
    {
        self.team = self.owner.team;
        self setturretteam( self.team );
    }

    thread _ID28101();
}

_ID28144()
{
    self setmodel( level._ID28172[self._ID28174].modelbase );

    if ( self getmode() == "manual" )
        self setmode( level._ID28172[self._ID28174]._ID28167 );

    self setsentrycarrier( undefined );
    self setcandamage( 1 );

    switch ( self._ID28174 )
    {
        case "minigun_turret":
        case "gl_turret":
        case "minigun_turret_1":
        case "minigun_turret_2":
        case "minigun_turret_3":
        case "minigun_turret_4":
        case "gl_turret_1":
        case "gl_turret_2":
        case "gl_turret_3":
        case "gl_turret_4":
            self.angles = self.carriedby.angles;

            if ( isalive( self._ID23036 ) )
            {
                if ( level.console || self._ID23036 usinggamepad() )
                    self._ID23036 maps\mp\_utility::setlowermessage( "pickup_hint", level._ID28172[self._ID28174]._ID23185, 3.0, undefined, undefined, undefined, undefined, undefined, 1 );
                else
                    self._ID23036 maps\mp\_utility::setlowermessage( "pickup_hint", &"ALIENS_PATCH_PRESS_TO_CARRY", 3.0, undefined, undefined, undefined, undefined, undefined, 1 );
            }

            self._ID23194 = spawn( "trigger_radius", self.origin + ( 0, 0, 1 ), 0, 105, 64 );

            if ( level.console || self._ID23036 usinggamepad() )
                self._ID23036 thread _ID34021( self );
            else
                self._ID23036 thread _ID38179( self );

            thread _ID34022();
            break;
        default:
            break;
    }

    _ID28109();
    self.carriedby forceusehintoff();
    self.carriedby = undefined;
    self.in_world_area = maps\mp\alien\_unk1464::get_in_world_area();

    if ( isdefined( self.owner ) )
    {
        self.owner._ID18582 = 0;

        if ( level._ID28172[self._ID28174].issentient )
            common_scripts\utility::_ID20489( self.owner.team );

        self.owner notify( "new_sentry",  self  );
    }

    sentry_setactive();
    self playsound( "sentry_gun_plant" );
    self notify( "placed" );
}

_ID28138()
{
    self.carriedby forceusehintoff();

    if ( isdefined( self.owner ) )
        self.owner._ID18582 = 0;

    self delete();
}

_ID28140( var_0 )
{
    if ( isdefined( self._ID23036 ) )
        jump loc_2BF1

    self setmodel( level._ID28172[self._ID28174]._ID21276 );
    self setsentrycarrier( var_0 );
    self setcandamage( 0 );
    _ID28108();
    self.carriedby = var_0;
    var_0._ID18582 = 1;
    var_0 thread _ID34603( self );
    thread _ID28115( var_0 );
    thread _ID28116( var_0 );
    thread _ID28114( var_0 );
    thread _ID28117();
    self freeentitysentient();
    self setdefaultdroppitch( -89.0 );
    _ID28142();
    self notify( "carried" );
}

_ID34603( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "placed" );
    var_0 endon( "death" );
    var_0.canbeplaced = 1;
    var_1 = -1;

    for (;;)
    {
        var_0.canbeplaced = can_place_sentry( var_0 );

        if ( var_0.canbeplaced != var_1 )
        {
            if ( var_0.canbeplaced )
            {
                var_0 setmodel( level._ID28172[var_0._ID28174]._ID21276 );
                self forceusehinton( &"SENTRY_PLACE" );
            }
            else
            {
                var_0 setmodel( level._ID28172[var_0._ID28174]._ID21277 );
                self forceusehinton( &"SENTRY_CANNOT_PLACE" );
            }
        }

        var_1 = var_0.canbeplaced;
        wait 0.05;
    }
}

can_place_sentry( var_0 )
{
    var_1 = self canplayerplacesentry();
    var_0.origin = var_1["origin"];
    var_0.angles = var_1["angles"];
    return self isonground() && var_1["result"] && abs( var_0.origin[2] - self.origin[2] ) < 10;
}

_ID28115( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    var_0 waittill( "death" );

    if ( self.canbeplaced )
        _ID28144();
    else
        self delete();
}

_ID28116( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    var_0 waittill( "disconnect" );
    self delete();
}

_ID28114( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    var_0 common_scripts\utility::_ID35626( "joined_team", "joined_spectators" );
    self delete();
}

_ID28117( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    level waittill( "game_ended" );
    self delete();
}

sentry_setactive()
{
    self setmode( level._ID28172[self._ID28174]._ID28168 );
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( level._ID28172[self._ID28174]._ID16999 );
    self makeusable();

    foreach ( var_1 in level.players )
    {
        switch ( self._ID28174 )
        {
            case "minigun_turret":
            case "gl_turret":
            case "minigun_turret_1":
            case "minigun_turret_2":
            case "minigun_turret_3":
            case "minigun_turret_4":
            case "gl_turret_1":
            case "gl_turret_2":
            case "gl_turret_3":
            case "gl_turret_4":
                self enableplayeruse( var_1 );

                if ( maps\mp\_utility::_ID18363() )
                {
                    var_2 = self getentitynumber();
                    addtoturretlist( var_2 );
                }

                continue;
            default:
                var_2 = self getentitynumber();
                addtoturretlist( var_2 );

                if ( var_1 == self.owner )
                    self enableplayeruse( var_1 );
                else
                    self disableplayeruse( var_1 );

                continue;
        }
    }

    if ( self._ID29893 && !maps\mp\alien\_unk1464::_ID18745() )
    {
        level thread maps\mp\_utility::_ID32672( level._ID28172[self._ID28174]._ID32680, self.owner, self.owner.team );
        self._ID29893 = 0;
    }

    thread _ID28163();
}

_ID28142()
{
    self setmode( level._ID28172[self._ID28174]._ID28167 );
    self makeunusable();
    var_0 = self getentitynumber();

    switch ( self._ID28174 )
    {
        case "gl_turret":
            break;
        default:
            _ID26007( var_0 );
            break;
    }

    if ( level._ID32653 )
        maps\mp\_entityheadicons::_ID28896( "none", ( 0, 0, 0 ) );
    else if ( isdefined( self.owner ) )
        maps\mp\_entityheadicons::_ID28825( undefined, ( 0, 0, 0 ) );
}

_ID28109()
{
    self maketurretsolid();
}

_ID28108()
{
    self setcontents( 0 );
}

_ID18637( var_0 )
{
    if ( level._ID32653 && self.team == var_0.team )
        return 1;

    return 0;
}

addtoturretlist( var_0 )
{
    level._ID34099[var_0] = self;
}

_ID26007( var_0 )
{
    level._ID34099[var_0] = undefined;
}

_ID28074()
{
    self endon( "death" );
    level endon( "game_ended" );
    self._ID21295 = 0;
    self.heatlevel = 0;
    self._ID23149 = 0;
    thread _ID28104();

    for (;;)
    {
        common_scripts\utility::_ID35663( "turretstatechange", "cooled" );

        if ( self isfiringturret() )
        {
            thread _ID28082();
            continue;
        }

        _ID28148();
        thread sentry_burstfirestop();
    }
}

_ID28158()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = level._ID28172[self._ID28174].timeout;

    while ( var_0 )
    {
        wait 1.0;
        maps\mp\gametypes\_hostmigration::_ID35770();

        if ( !isdefined( self.carriedby ) )
            var_0 = max( 0, var_0 - 1.0 );
    }

    while ( isdefined( self ) && isdefined( self._ID18319 ) )
        wait 0.05;

    self notify( "death" );
}

_ID28154()
{
    self endon( "death" );
    self playsound( "sentry_gun_beep" );
    wait 0.1;
    self playsound( "sentry_gun_beep" );
    wait 0.1;
    self playsound( "sentry_gun_beep" );
}

_ID28149()
{
    thread _ID28154();

    while ( self._ID21295 < level._ID28172[self._ID28174]._ID31014 )
    {
        self._ID21295 = self._ID21295 + 0.1;
        wait 0.1;
    }
}

_ID28148()
{
    self._ID21295 = 0;
}

_ID28082()
{
    self endon( "death" );
    self endon( "stop_shooting" );
    level endon( "game_ended" );
    _ID28149();
    var_0 = weaponfiretime( level._ID28172[self._ID28174].weaponinfo );
    var_1 = level._ID28172[self._ID28174].burstmin;
    var_2 = level._ID28172[self._ID28174]._ID6331;
    var_3 = level._ID28172[self._ID28174]._ID23388;
    var_4 = level._ID28172[self._ID28174]._ID23387;

    for (;;)
    {
        var_5 = randomintrange( var_1, var_2 + 1 );

        for ( var_6 = 0; var_6 < var_5 && !self._ID23149; var_6++ )
        {
            self shootturret();
            self notify( "bullet_fired" );
            self.heatlevel = self.heatlevel + var_0;
            wait(var_0);
        }

        wait(randomfloatrange( var_3, var_4 ));
    }
}

sentry_burstfirestop()
{
    self notify( "stop_shooting" );
}

_ID34057( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "player_dismount" );
    var_1 = weaponfiretime( level._ID28172[var_0._ID28174].weaponinfo );

    for (;;)
    {
        var_0 waittill( "turret_fire" );
        var_0 getturretowner() notify( "turret_fire" );
        var_0.heatlevel = var_0.heatlevel + var_1;
        var_0.cooldownwaittime = var_1;
    }
}

_ID28104()
{
    self endon( "death" );
    var_0 = weaponfiretime( level._ID28172[self._ID28174].weaponinfo );
    var_1 = 0;
    var_2 = 0;
    var_3 = level._ID28172[self._ID28174].overheattime;
    var_4 = level._ID28172[self._ID28174].cooldowntime;

    for (;;)
    {
        if ( self.heatlevel != var_1 )
            wait(var_0);
        else
            self.heatlevel = max( 0, self.heatlevel - 0.05 );

        if ( self.heatlevel > var_3 )
        {
            self._ID23149 = 1;
            thread playheatfx();

            switch ( self._ID28174 )
            {
                case "minigun_turret":
                case "minigun_turret_1":
                case "minigun_turret_2":
                case "minigun_turret_3":
                case "minigun_turret_4":
                    playfxontag( common_scripts\utility::_ID15033( "sentry_smoke_mp" ), self, "tag_aim" );
                    break;
                default:
                    break;
            }

            while ( self.heatlevel )
            {
                self.heatlevel = max( 0, self.heatlevel - 0.1 );
                wait 0.1;
            }

            self._ID23149 = 0;
            self notify( "not_overheated" );
        }

        var_1 = self.heatlevel;
        wait 0.05;
    }
}

_ID34026()
{
    self endon( "death" );
    var_0 = level._ID28172[self._ID28174].overheattime;

    for (;;)
    {
        if ( self.heatlevel > var_0 )
        {
            self._ID23149 = 1;
            thread playheatfx();

            switch ( self._ID28174 )
            {
                case "gl_turret":
                    playfxontag( common_scripts\utility::_ID15033( "sentry_smoke_mp" ), self, "tag_aim" );
                    break;
                default:
                    break;
            }

            while ( self.heatlevel )
                wait 0.1;

            self._ID23149 = 0;
            self notify( "not_overheated" );
        }

        wait 0.05;
    }
}

turret_coolmonitor()
{
    self endon( "death" );

    for (;;)
    {
        if ( self.heatlevel > 0 )
        {
            if ( self.cooldownwaittime <= 0 )
                self.heatlevel = max( 0, self.heatlevel - 0.05 );
            else
                self.cooldownwaittime = max( 0, self.cooldownwaittime - 0.05 );
        }

        wait 0.05;
    }
}

playheatfx()
{
    self endon( "death" );
    self endon( "not_overheated" );
    level endon( "game_ended" );
    self notify( "playing_heat_fx" );
    self endon( "playing_heat_fx" );

    for (;;)
    {
        playfxontag( common_scripts\utility::_ID15033( "sentry_overheat_mp" ), self, "tag_flash" );
        wait(level._ID28172[self._ID28174].fxtime);
    }
}

_ID24636()
{
    self endon( "death" );
    self endon( "not_overheated" );
    level endon( "game_ended" );

    for (;;)
    {
        playfxontag( common_scripts\utility::_ID15033( "sentry_smoke_mp" ), self, "tag_aim" );
        wait 0.4;
    }
}

_ID28079()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 3.0;

        if ( !isdefined( self.carriedby ) )
            self playsound( "sentry_gun_beep" );
    }
}

_ID28560()
{
    var_0 = [];
    var_0["brute"][0] = maps\mp\alien\_unk1464::_ID28232( ( 1, 0, 0 ), "alien_sentry_attack_sentry_front_enter", "alien_sentry_attack_sentry_front_loop", "alien_sentry_attack_sentry_front_exit", "attack_sentry_front", "attack_sentry" );
    var_0["brute"][1] = maps\mp\alien\_unk1464::_ID28232( ( 0, 1, 0 ), "alien_sentry_attack_sentry_side_l_enter", "alien_sentry_attack_sentry_side_l_loop", "alien_sentry_attack_sentry_side_l_exit", "attack_sentry_left", "attack_sentry" );
    var_0["brute"][2] = maps\mp\alien\_unk1464::_ID28232( ( 0, -1, 0 ), "alien_sentry_attack_sentry_side_r_enter", "alien_sentry_attack_sentry_side_r_loop", "alien_sentry_attack_sentry_side_r_exit", "attack_sentry_right", "attack_sentry" );
    var_0["goon"][0] = maps\mp\alien\_unk1464::_ID28232( ( 1, 0, 0 ), "alien_goon_sentry_attack_sentry_F_enter", "alien_goon_sentry_attack_sentry_F_loop", "alien_goon_sentry_attack_sentry_F_exit", "attack_sentry_front", "attack_sentry" );
    var_0["goon"][1] = maps\mp\alien\_unk1464::_ID28232( ( 0, 1, 0 ), "alien_goon_sentry_attack_sentry_L_enter", "alien_goon_sentry_attack_sentry_L_loop", "alien_goon_sentry_attack_sentry_L_exit", "attack_sentry_left", "attack_sentry" );
    var_0["goon"][2] = maps\mp\alien\_unk1464::_ID28232( ( 0, -1, 0 ), "alien_goon_sentry_attack_sentry_R_enter", "alien_goon_sentry_attack_sentry_R_loop", "alien_goon_sentry_attack_sentry_R_exit", "attack_sentry_right", "attack_sentry" );
    var_1[0] = "death";
    var_1[1] = "destroyed";
    var_1[2] = "carried";
    maps\mp\alien\_unk1464::_ID28580( var_0, 1, var_1, ::sentry_can_synch_attack, ::sentry_synch_attack_begin, ::_ID28153, ::_ID28152, "sentry gun" );
}

sentry_can_synch_attack()
{
    return !isdefined( self._ID32303 );
}

sentry_synch_attack_begin( var_0 )
{
    self hide();
    self._ID32303 = spawn( "script_model", self.origin );
    self._ID32303 setmodel( level._ID28172[self._ID28174].modelbase );
    self._ID32303.angles = self.angles;
    self turretfiredisable();
    self._ID32303 scriptmodelplayanim( var_0 );
}

_ID28153( var_0 )
{
    self._ID32303 scriptmodelclearanim();
    self._ID32303 scriptmodelplayanim( var_0 );
}

_ID28152( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
    {
        self._ID32303 scriptmodelclearanim();
        self._ID32303 scriptmodelplayanim( var_0 );
        wait(var_1);
    }

    if ( !isdefined( self ) )
        return;

    self._ID32303 delete();
    self show();

    if ( isalive( self ) )
        self turretfireenable();
}
