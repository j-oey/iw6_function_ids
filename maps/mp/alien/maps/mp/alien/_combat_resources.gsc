// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

init_combat_resources()
{
    if ( !isdefined( level.alien_combat_resources_table ) )
        level.alien_combat_resources_table = "mp/alien/dpad_tree.csv";

    _ID17707();
    init_combat_resource_overrides();
    init_combat_resource_from_table();
    _ID17827();
    init_ims_upgrade_function_pointers();
    init_ball_drone_upgrade_function_pointers();
}

_ID17827()
{
    level._ID8475 = maps\mp\alien\_autosentry_alien::_ID8474;
    level._ID28141 = maps\mp\alien\_autosentry_alien::_ID28140;
    level._ID28145 = maps\mp\alien\_autosentry_alien::_ID28144;
    level._ID28139 = maps\mp\alien\_autosentry_alien::_ID28138;
}

_ID17707()
{
    level.alien_combat_resource_callbacks = [];
    level.alien_combat_resource_callbacks["dpad_team_ammo_reg"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_team_ammo_reg"].canuse = ::_ID37077;
    level.alien_combat_resource_callbacks["dpad_team_ammo_reg"]._ID6618 = ::_ID36713;
    level.alien_combat_resource_callbacks["dpad_team_ammo_reg"].tryuse = ::tryuse_dpad_team_ammo;
    level.alien_combat_resource_callbacks["dpad_team_ammo_reg"]._ID34675 = ::_ID34695;
    level.alien_combat_resource_callbacks["dpad_team_ammo_reg"]._ID6563 = ::canceluse_default_deployable_box;
    level.alien_combat_resource_callbacks["dpad_team_armor"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_team_armor"].canuse = ::_ID37077;
    level.alien_combat_resource_callbacks["dpad_team_armor"]._ID6618 = ::_ID36713;
    level.alien_combat_resource_callbacks["dpad_team_armor"].tryuse = ::_ID33816;
    level.alien_combat_resource_callbacks["dpad_team_armor"]._ID34675 = ::_ID34696;
    level.alien_combat_resource_callbacks["dpad_team_armor"]._ID6563 = ::canceluse_default_deployable_box;
    level.alien_combat_resource_callbacks["dpad_team_explosives"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_team_explosives"].canuse = ::_ID37077;
    level.alien_combat_resource_callbacks["dpad_team_explosives"]._ID6618 = ::_ID36713;
    level.alien_combat_resource_callbacks["dpad_team_explosives"].tryuse = ::tryuse_dpad_team_explosives;
    level.alien_combat_resource_callbacks["dpad_team_explosives"]._ID34675 = ::_ID34699;
    level.alien_combat_resource_callbacks["dpad_team_explosives"]._ID6563 = ::canceluse_default_deployable_box;
    level.alien_combat_resource_callbacks["dpad_team_randombox"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_team_randombox"].canuse = ::_ID37077;
    level.alien_combat_resource_callbacks["dpad_team_randombox"]._ID6618 = ::_ID36713;
    level.alien_combat_resource_callbacks["dpad_team_randombox"].tryuse = ::_ID33820;
    level.alien_combat_resource_callbacks["dpad_team_randombox"]._ID34675 = ::use_dpad_team_randombox;
    level.alien_combat_resource_callbacks["dpad_team_randombox"]._ID6563 = ::canceluse_default_deployable_box;
    level.alien_combat_resource_callbacks["dpad_team_boost"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_team_boost"].canuse = ::_ID37077;
    level.alien_combat_resource_callbacks["dpad_team_boost"]._ID6618 = ::_ID36713;
    level.alien_combat_resource_callbacks["dpad_team_boost"].tryuse = ::_ID33817;
    level.alien_combat_resource_callbacks["dpad_team_boost"]._ID34675 = ::_ID34697;
    level.alien_combat_resource_callbacks["dpad_team_boost"]._ID6563 = ::canceluse_default_deployable_box;
    level.alien_combat_resource_callbacks["dpad_team_adrenaline"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_team_adrenaline"].canuse = ::_ID37077;
    level.alien_combat_resource_callbacks["dpad_team_adrenaline"]._ID6618 = ::_ID36713;
    level.alien_combat_resource_callbacks["dpad_team_adrenaline"].tryuse = ::_ID33814;
    level.alien_combat_resource_callbacks["dpad_team_adrenaline"]._ID34675 = ::_ID34694;
    level.alien_combat_resource_callbacks["dpad_team_adrenaline"]._ID6563 = ::canceluse_default_deployable_box;
    level.alien_combat_resource_callbacks["dpad_ims"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_ims"].canuse = ::_ID36714;
    level.alien_combat_resource_callbacks["dpad_ims"]._ID6618 = ::_ID6623;
    level.alien_combat_resource_callbacks["dpad_ims"].tryuse = ::_ID33808;
    level.alien_combat_resource_callbacks["dpad_ims"]._ID34675 = ::_ID34689;
    level.alien_combat_resource_callbacks["dpad_ims"]._ID6563 = ::canceluse_dpad_ims;
    level.alien_combat_resource_callbacks["dpad_sentry"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_sentry"].canuse = ::_ID36714;
    level.alien_combat_resource_callbacks["dpad_sentry"]._ID6618 = ::_ID6627;
    level.alien_combat_resource_callbacks["dpad_sentry"].tryuse = ::_ID33813;
    level.alien_combat_resource_callbacks["dpad_sentry"]._ID34675 = ::_ID34693;
    level.alien_combat_resource_callbacks["dpad_sentry"]._ID6563 = ::canceluse_dpad_sentry;
    level.alien_combat_resource_callbacks["dpad_gl_sentry"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_gl_sentry"].canuse = ::_ID36714;
    level.alien_combat_resource_callbacks["dpad_gl_sentry"]._ID6618 = ::_ID6622;
    level.alien_combat_resource_callbacks["dpad_gl_sentry"].tryuse = ::_ID33807;
    level.alien_combat_resource_callbacks["dpad_gl_sentry"]._ID34675 = ::use_dpad_glsentry;
    level.alien_combat_resource_callbacks["dpad_gl_sentry"]._ID6563 = ::canceluse_dpad_glsentry;
    level.alien_combat_resource_callbacks["dpad_minigun_turret"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_minigun_turret"].canuse = ::_ID36714;
    level.alien_combat_resource_callbacks["dpad_minigun_turret"]._ID6618 = ::canpurchase_dpad_minigun_turret;
    level.alien_combat_resource_callbacks["dpad_minigun_turret"].tryuse = ::_ID33809;
    level.alien_combat_resource_callbacks["dpad_minigun_turret"]._ID34675 = ::_ID34690;
    level.alien_combat_resource_callbacks["dpad_minigun_turret"]._ID6563 = ::canceluse_dpad_minigun_turret;
    level.alien_combat_resource_callbacks["dpad_backup_buddy"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_backup_buddy"].canuse = ::_ID36714;
    level.alien_combat_resource_callbacks["dpad_backup_buddy"]._ID6618 = ::canpurchase_dpad_backup_buddy;
    level.alien_combat_resource_callbacks["dpad_backup_buddy"].tryuse = ::_ID33804;
    level.alien_combat_resource_callbacks["dpad_backup_buddy"]._ID34675 = ::_ID34686;
    level.alien_combat_resource_callbacks["dpad_backup_buddy"]._ID6563 = ::canceluse_dpad_backup_buddy;
    level.alien_combat_resource_callbacks["dpad_mortar"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_mortar"].canuse = ::_ID36714;
    level.alien_combat_resource_callbacks["dpad_mortar"]._ID6618 = ::_ID37076;
    level.alien_combat_resource_callbacks["dpad_mortar"].tryuse = ::_ID33803;
    level.alien_combat_resource_callbacks["dpad_mortar"]._ID34675 = ::_ID34685;
    level.alien_combat_resource_callbacks["dpad_mortar"]._ID6563 = ::canceluse_dpad_airstrike;
    level.alien_combat_resource_callbacks["dpad_war_machine"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_war_machine"].canuse = ::_ID36714;
    level.alien_combat_resource_callbacks["dpad_war_machine"]._ID6618 = ::_ID36713;
    level.alien_combat_resource_callbacks["dpad_war_machine"].tryuse = ::_ID33825;
    level.alien_combat_resource_callbacks["dpad_war_machine"]._ID34675 = ::use_dpad_war_machine;
    level.alien_combat_resource_callbacks["dpad_war_machine"]._ID6563 = ::canceluse_dpad_war_machine;
    level.alien_combat_resource_callbacks["dpad_death_machine"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_death_machine"].canuse = ::_ID36714;
    level.alien_combat_resource_callbacks["dpad_death_machine"]._ID6618 = ::_ID36713;
    level.alien_combat_resource_callbacks["dpad_death_machine"].tryuse = ::_ID33805;
    level.alien_combat_resource_callbacks["dpad_death_machine"]._ID34675 = ::_ID34687;
    level.alien_combat_resource_callbacks["dpad_death_machine"]._ID6563 = ::canceluse_dpad_death_machine;
    level.alien_combat_resource_callbacks["dpad_predator"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_predator"].canuse = ::_ID36714;
    level.alien_combat_resource_callbacks["dpad_predator"]._ID6618 = ::_ID37076;
    level.alien_combat_resource_callbacks["dpad_predator"].tryuse = ::_ID33810;
    level.alien_combat_resource_callbacks["dpad_predator"]._ID34675 = ::_ID34691;
    level.alien_combat_resource_callbacks["dpad_predator"]._ID6563 = ::canceluse_dpad_predator;
    level.alien_combat_resource_callbacks["dpad_riotshield"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_riotshield"].canuse = ::_ID36714;
    level.alien_combat_resource_callbacks["dpad_riotshield"]._ID6618 = ::canpurchase_dpad_riotshield;
    level.alien_combat_resource_callbacks["dpad_riotshield"].tryuse = ::_ID33811;
    level.alien_combat_resource_callbacks["dpad_riotshield"]._ID34675 = ::_ID34692;
    level.alien_combat_resource_callbacks["dpad_riotshield"]._ID6563 = ::canceluse_dpad_riotshield;
    level.alien_combat_resource_callbacks["dpad_team_ammo_stun"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_team_ammo_stun"].canuse = ::_ID37077;
    level.alien_combat_resource_callbacks["dpad_team_ammo_stun"]._ID6618 = ::_ID36713;
    level.alien_combat_resource_callbacks["dpad_team_ammo_stun"].tryuse = ::_ID33821;
    level.alien_combat_resource_callbacks["dpad_team_ammo_stun"]._ID34675 = ::_ID34701;
    level.alien_combat_resource_callbacks["dpad_team_ammo_stun"]._ID6563 = ::canceluse_default_deployable_box;
    level.alien_combat_resource_callbacks["dpad_team_ammo_explo"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_team_ammo_explo"].canuse = ::_ID37077;
    level.alien_combat_resource_callbacks["dpad_team_ammo_explo"]._ID6618 = ::_ID36713;
    level.alien_combat_resource_callbacks["dpad_team_ammo_explo"].tryuse = ::_ID33823;
    level.alien_combat_resource_callbacks["dpad_team_ammo_explo"]._ID34675 = ::_ID38238;
    level.alien_combat_resource_callbacks["dpad_team_ammo_explo"]._ID6563 = ::canceluse_default_deployable_box;
    level.alien_combat_resource_callbacks["dpad_team_ammo_ap"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_team_ammo_ap"].canuse = ::_ID37077;
    level.alien_combat_resource_callbacks["dpad_team_ammo_ap"]._ID6618 = ::_ID36713;
    level.alien_combat_resource_callbacks["dpad_team_ammo_ap"].tryuse = ::_ID33822;
    level.alien_combat_resource_callbacks["dpad_team_ammo_ap"]._ID34675 = ::_ID34701;
    level.alien_combat_resource_callbacks["dpad_team_ammo_ap"]._ID6563 = ::canceluse_default_deployable_box;
    level.alien_combat_resource_callbacks["dpad_team_ammo_in"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_team_ammo_in"].canuse = ::_ID37077;
    level.alien_combat_resource_callbacks["dpad_team_ammo_in"]._ID6618 = ::_ID36713;
    level.alien_combat_resource_callbacks["dpad_team_ammo_in"].tryuse = ::_ID33824;
    level.alien_combat_resource_callbacks["dpad_team_ammo_in"]._ID34675 = ::_ID38239;
    level.alien_combat_resource_callbacks["dpad_team_ammo_in"]._ID6563 = ::canceluse_default_deployable_box;
    level.alien_combat_resource_callbacks["dpad_team_currency"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_team_currency"].canuse = ::_ID37077;
    level.alien_combat_resource_callbacks["dpad_team_currency"]._ID6618 = ::_ID36713;
    level.alien_combat_resource_callbacks["dpad_team_currency"].tryuse = ::_ID33818;
    level.alien_combat_resource_callbacks["dpad_team_currency"]._ID34675 = ::_ID34698;
    level.alien_combat_resource_callbacks["dpad_team_currency"]._ID6563 = ::canceluse_default_deployable_box;
    level.alien_combat_resource_callbacks["dpad_placeholder_ammo_2"] = spawnstruct();
    level.alien_combat_resource_callbacks["dpad_placeholder_ammo_2"].canuse = ::_ID37077;
    level.alien_combat_resource_callbacks["dpad_placeholder_ammo_2"]._ID6618 = ::_ID36713;
    level.alien_combat_resource_callbacks["dpad_placeholder_ammo_2"].tryuse = ::tryuse_dpad_team_specialammo_comb;
    level.alien_combat_resource_callbacks["dpad_placeholder_ammo_2"]._ID34675 = ::use_dpad_team_specialammo_comb;
    level.alien_combat_resource_callbacks["dpad_placeholder_ammo_2"]._ID6563 = ::canceluse_default_deployable_box;
    level._ID21472["tracer"] = loadfx( "fx/misc/tracer_incoming" );
    level._ID21472["explosion"] = loadfx( "vfx/gameplay/alien/vfx_alien_mortar_explosion" );
    level._ID1644["stun_attack"] = loadfx( "vfx/gameplay/alien/vfx_alien_stun_ammo_attack" );
    level._ID1644["stun_shock"] = loadfx( "vfx/gameplay/alien/vfx_alien_tesla_shock" );
}

init_ims_upgrade_function_pointers()
{
    level.ims_alien_fire_func = ::ims_fire_cloud;
    level.ims_alien_grace_period_func = ::ims_grace_period_scalar;
}

init_ball_drone_upgrade_function_pointers()
{
    level.ball_drone_alien_timeout_func = ::ball_drone_timeout_scalar;
    level.ball_drone_faster_rocket_func = ::ball_drone_fire_rocket_scalar;
}

init_combat_resource_overrides()
{
    level._ID17474 = [];
    var_0 = spawnstruct();
    var_0.weaponinfo = "alienims_projectile_mp";
    var_0.modelbase = "ims_scorpion_body_iw6";
    var_0._ID21276 = "ims_scorpion_body_iw6_placement";
    var_0._ID21277 = "ims_scorpion_body_iw6_placement_failed";
    var_0._ID21271 = "ims_scorpion_body_iw6";
    var_0.modelbombsquad = "ims_scorpion_body_iw6_bombsquad";
    var_0._ID16999 = &"ALIEN_COLLECTIBLES_IMS_PICKUP";
    var_0._ID23671 = &"ALIEN_COLLECTIBLES_IMS_PLACE";
    var_0.cannotplacestring = &"ALIEN_COLLECTIBLES_IMS_CANNOT_PLACE";
    var_0._ID31889 = "alien_ims";
    var_0._ID31051 = "used_ims";
    var_0._ID19940 = 600.0;
    var_0._ID15760 = 0.8;
    var_0._ID25573 = 2.0;
    var_0._ID22404 = 4;
    var_0.attacks = var_0._ID22404;
    var_0._ID12530 = "ims_scorpion_explosive_iw6";
    var_0._ID23664 = 11.5;
    var_0._ID23669 = 24.0;
    var_0._ID19935 = "tag_lid";
    var_0._ID19933 = [];
    var_0._ID19933[1] = "IMS_Scorpion_door_1";
    var_0._ID19933[2] = "IMS_Scorpion_door_2";
    var_0._ID19933[3] = "IMS_Scorpion_door_3";
    var_0._ID19933[4] = "IMS_Scorpion_door_4";
    var_0._ID19934 = [];
    var_0._ID19934[1] = "IMS_Scorpion_1_opened";
    var_0._ID19934[2] = "IMS_Scorpion_2_opened";
    var_0._ID19934[3] = "IMS_Scorpion_3_opened";
    var_0.expltagroot = "tag_explosive";
    var_0._ID19217 = ( 0, 0, 12 );
    var_0.maxhealth = 1000;
    level._ID17474["alien_ims"] = var_0;
    var_0 = spawnstruct();
    var_0.weaponinfo = "alienims_projectileradius_mp";
    var_0.modelbase = "ims_scorpion_body_iw6";
    var_0._ID21276 = "ims_scorpion_body_iw6_placement";
    var_0._ID21277 = "ims_scorpion_body_iw6_placement_failed";
    var_0._ID21271 = "ims_scorpion_body_iw6";
    var_0.modelbombsquad = "ims_scorpion_body_iw6_bombsquad";
    var_0._ID16999 = &"ALIEN_COLLECTIBLES_IMS_PICKUP";
    var_0._ID23671 = &"ALIEN_COLLECTIBLES_IMS_PLACE";
    var_0.cannotplacestring = &"ALIEN_COLLECTIBLES_IMS_CANNOT_PLACE";
    var_0._ID31889 = "alien_ims_1";
    var_0._ID31051 = "used_ims";
    var_0._ID19940 = 600.0;
    var_0._ID15760 = 0.8;
    var_0._ID25573 = 2.0;
    var_0._ID22404 = 4;
    var_0.attacks = var_0._ID22404;
    var_0._ID12530 = "ims_scorpion_explosive_iw6";
    var_0._ID23664 = 11.5;
    var_0._ID23669 = 24.0;
    var_0._ID19935 = "tag_lid";
    var_0._ID19933 = [];
    var_0._ID19933[1] = "IMS_Scorpion_door_1";
    var_0._ID19933[2] = "IMS_Scorpion_door_2";
    var_0._ID19933[3] = "IMS_Scorpion_door_3";
    var_0._ID19933[4] = "IMS_Scorpion_door_4";
    var_0._ID19934 = [];
    var_0._ID19934[1] = "IMS_Scorpion_1_opened";
    var_0._ID19934[2] = "IMS_Scorpion_2_opened";
    var_0._ID19934[3] = "IMS_Scorpion_3_opened";
    var_0.expltagroot = "tag_explosive";
    var_0._ID19217 = ( 0, 0, 12 );
    var_0.maxhealth = 1000;
    level._ID17474["alien_ims_1"] = var_0;
    var_0 = spawnstruct();
    var_0.weaponinfo = "alienims_projectileradius_mp";
    var_0.modelbase = "ims_scorpion_body_iw6";
    var_0._ID21276 = "ims_scorpion_body_iw6_placement";
    var_0._ID21277 = "ims_scorpion_body_iw6_placement_failed";
    var_0._ID21271 = "ims_scorpion_body_iw6";
    var_0.modelbombsquad = "ims_scorpion_body_iw6_bombsquad";
    var_0._ID16999 = &"ALIEN_COLLECTIBLES_IMS_PICKUP";
    var_0._ID23671 = &"ALIEN_COLLECTIBLES_IMS_PLACE";
    var_0.cannotplacestring = &"ALIEN_COLLECTIBLES_IMS_CANNOT_PLACE";
    var_0._ID31889 = "alien_ims_2";
    var_0._ID31051 = "used_ims";
    var_0._ID19940 = 600.0;
    var_0._ID15760 = 0.2;
    var_0._ID25573 = 2.0;
    var_0._ID22404 = 4;
    var_0.attacks = var_0._ID22404;
    var_0._ID12530 = "ims_scorpion_explosive_iw6";
    var_0._ID23664 = 11.5;
    var_0._ID23669 = 24.0;
    var_0._ID19935 = "tag_lid";
    var_0._ID19933 = [];
    var_0._ID19933[1] = "IMS_Scorpion_door_1";
    var_0._ID19933[2] = "IMS_Scorpion_door_2";
    var_0._ID19933[3] = "IMS_Scorpion_door_3";
    var_0._ID19933[4] = "IMS_Scorpion_door_4";
    var_0._ID19934 = [];
    var_0._ID19934[1] = "IMS_Scorpion_1_opened";
    var_0._ID19934[2] = "IMS_Scorpion_2_opened";
    var_0._ID19934[3] = "IMS_Scorpion_3_opened";
    var_0.expltagroot = "tag_explosive";
    var_0._ID19217 = ( 0, 0, 12 );
    var_0.maxhealth = 1000;
    level._ID17474["alien_ims_2"] = var_0;
    var_0 = spawnstruct();
    var_0.weaponinfo = "alienims_projectiledamage_mp";
    var_0.modelbase = "ims_scorpion_body_iw6";
    var_0._ID21276 = "ims_scorpion_body_iw6_placement";
    var_0._ID21277 = "ims_scorpion_body_iw6_placement_failed";
    var_0._ID21271 = "ims_scorpion_body_iw6";
    var_0.modelbombsquad = "ims_scorpion_body_iw6_bombsquad";
    var_0._ID16999 = &"ALIEN_COLLECTIBLES_IMS_PICKUP";
    var_0._ID23671 = &"ALIEN_COLLECTIBLES_IMS_PLACE";
    var_0.cannotplacestring = &"ALIEN_COLLECTIBLES_IMS_CANNOT_PLACE";
    var_0._ID31889 = "alien_ims_3";
    var_0._ID31051 = "used_ims";
    var_0._ID19940 = 600.0;
    var_0._ID15760 = 0.2;
    var_0._ID25573 = 2.0;
    var_0._ID22404 = 4;
    var_0.attacks = var_0._ID22404;
    var_0._ID12530 = "ims_scorpion_explosive_iw6";
    var_0._ID23664 = 11.5;
    var_0._ID23669 = 24.0;
    var_0._ID19935 = "tag_lid";
    var_0._ID19933 = [];
    var_0._ID19933[1] = "IMS_Scorpion_door_1";
    var_0._ID19933[2] = "IMS_Scorpion_door_2";
    var_0._ID19933[3] = "IMS_Scorpion_door_3";
    var_0._ID19933[4] = "IMS_Scorpion_door_4";
    var_0._ID19934 = [];
    var_0._ID19934[1] = "IMS_Scorpion_1_opened";
    var_0._ID19934[2] = "IMS_Scorpion_2_opened";
    var_0._ID19934[3] = "IMS_Scorpion_3_opened";
    var_0.expltagroot = "tag_explosive";
    var_0._ID19217 = ( 0, 0, 12 );
    var_0.maxhealth = 1000;
    level._ID17474["alien_ims_3"] = var_0;
    var_0 = spawnstruct();
    var_0.weaponinfo = "alienims_projectiledamage_mp";
    var_0.modelbase = "ims_scorpion_body_iw6";
    var_0._ID21276 = "ims_scorpion_body_iw6_placement";
    var_0._ID21277 = "ims_scorpion_body_iw6_placement_failed";
    var_0._ID21271 = "ims_scorpion_body_iw6";
    var_0.modelbombsquad = "ims_scorpion_body_iw6_bombsquad";
    var_0._ID16999 = &"ALIEN_COLLECTIBLES_IMS_PICKUP";
    var_0._ID23671 = &"ALIEN_COLLECTIBLES_IMS_PLACE";
    var_0.cannotplacestring = &"ALIEN_COLLECTIBLES_IMS_CANNOT_PLACE";
    var_0._ID31889 = "alien_ims_4";
    var_0._ID31051 = "used_ims";
    var_0._ID19940 = 600.0;
    var_0._ID15760 = 0.2;
    var_0._ID25573 = 2.0;
    var_0._ID22404 = 6;
    var_0.attacks = var_0._ID22404;
    var_0._ID12530 = "ims_scorpion_explosive_iw6";
    var_0._ID23664 = 11.5;
    var_0._ID23669 = 24.0;
    var_0._ID19935 = "tag_lid";
    var_0._ID19933 = [];
    var_0._ID19933[1] = "IMS_Scorpion_door_1";
    var_0._ID19933[2] = "IMS_Scorpion_door_2";
    var_0._ID19933[3] = "IMS_Scorpion_door_3";
    var_0._ID19933[4] = "IMS_Scorpion_door_4";
    var_0._ID19934 = [];
    var_0._ID19934[1] = "IMS_Scorpion_1_opened";
    var_0._ID19934[2] = "IMS_Scorpion_2_opened";
    var_0._ID19934[3] = "IMS_Scorpion_3_opened";
    var_0.expltagroot = "tag_explosive";
    var_0._ID19217 = ( 0, 0, 12 );
    var_0.maxhealth = 1000;
    level._ID17474["alien_ims_4"] = var_0;

    if ( !isdefined( level.balldronesettings ) )
        level.balldronesettings = [];

    level.balldronesettings["alien_ball_drone"] = spawnstruct();
    level.balldronesettings["alien_ball_drone"].timeout = 35.0;
    level.balldronesettings["alien_ball_drone"].health = 999999;
    level.balldronesettings["alien_ball_drone"].maxhealth = 250;
    level.balldronesettings["alien_ball_drone"]._ID31889 = "ball_drone_backup";
    level.balldronesettings["alien_ball_drone"]._ID35155 = "backup_drone_mp";
    level.balldronesettings["alien_ball_drone"].modelbase = "vehicle_drone_backup_buddy";
    level.balldronesettings["alien_ball_drone"]._ID32680 = "used_ball_drone_radar";
    level.balldronesettings["alien_ball_drone"]._ID14031 = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ims_sparks" );
    level.balldronesettings["alien_ball_drone"].fxid_explode = loadfx( "fx/explosions/bouncing_betty_explosion" );
    level.balldronesettings["alien_ball_drone"]._ID30472 = "ball_drone_explode";
    level.balldronesettings["alien_ball_drone"]._ID35387 = "backup_destroyed";
    level.balldronesettings["alien_ball_drone"]._ID36472 = "destroyed_ball_drone";
    level.balldronesettings["alien_ball_drone"].weaponinfo = "alien_ball_drone_gun_mp";
    level.balldronesettings["alien_ball_drone"]._ID36270 = "vehicle_drone_backup_buddy_gun";
    level.balldronesettings["alien_ball_drone"]._ID36295 = "tag_turret_attach";
    level.balldronesettings["alien_ball_drone"]._ID30491 = "weap_p99_fire_npc";
    level.balldronesettings["alien_ball_drone"]._ID30487 = "ball_drone_targeting";
    level.balldronesettings["alien_ball_drone"]._ID30476 = "ball_drone_lockon";
    level.balldronesettings["alien_ball_drone"].sentrymode = "sentry";
    level.balldronesettings["alien_ball_drone"]._ID35360 = 422500;
    level.balldronesettings["alien_ball_drone"].burstmin = 5;
    level.balldronesettings["alien_ball_drone"]._ID6331 = 10;
    level.balldronesettings["alien_ball_drone"]._ID23388 = 0.15;
    level.balldronesettings["alien_ball_drone"]._ID23387 = 0.35;
    level.balldronesettings["alien_ball_drone"]._ID20198 = 0.5;
    level.balldronesettings["alien_ball_drone"]._ID24592 = maps\mp\killstreaks\_unk1523::backupbuddyplayfx;
    level.balldronesettings["alien_ball_drone"]._ID14026 = [];
    level.balldronesettings["alien_ball_drone"]._ID14026["enemy"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink" );
    level.balldronesettings["alien_ball_drone"]._ID14026["friendly"] = loadfx( "fx/misc/light_mine_blink_friendly" );
    level.balldronesettings["alien_ball_drone_1"] = spawnstruct();
    level.balldronesettings["alien_ball_drone_1"].timeout = 35.0;
    level.balldronesettings["alien_ball_drone_1"].health = 999999;
    level.balldronesettings["alien_ball_drone_1"].maxhealth = 250;
    level.balldronesettings["alien_ball_drone_1"]._ID31889 = "ball_drone_backup";
    level.balldronesettings["alien_ball_drone_1"]._ID35155 = "backup_drone_mp";
    level.balldronesettings["alien_ball_drone_1"].modelbase = "vehicle_drone_backup_buddy";
    level.balldronesettings["alien_ball_drone_1"]._ID32680 = "used_ball_drone_radar";
    level.balldronesettings["alien_ball_drone_1"]._ID14031 = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ims_sparks" );
    level.balldronesettings["alien_ball_drone_1"].fxid_explode = loadfx( "fx/explosions/bouncing_betty_explosion" );
    level.balldronesettings["alien_ball_drone_1"]._ID30472 = "ball_drone_explode";
    level.balldronesettings["alien_ball_drone_1"]._ID35387 = "backup_destroyed";
    level.balldronesettings["alien_ball_drone_1"]._ID36472 = "destroyed_ball_drone";
    level.balldronesettings["alien_ball_drone_1"].weaponinfo = "alien_ball_drone_gun1_mp";
    level.balldronesettings["alien_ball_drone_1"]._ID36270 = "vehicle_drone_backup_buddy_gun";
    level.balldronesettings["alien_ball_drone_1"]._ID36295 = "tag_turret_attach";
    level.balldronesettings["alien_ball_drone_1"]._ID30491 = "weap_p99_fire_npc";
    level.balldronesettings["alien_ball_drone_1"]._ID30487 = "ball_drone_targeting";
    level.balldronesettings["alien_ball_drone_1"]._ID30476 = "ball_drone_lockon";
    level.balldronesettings["alien_ball_drone_1"].sentrymode = "sentry";
    level.balldronesettings["alien_ball_drone_1"]._ID35360 = 422500;
    level.balldronesettings["alien_ball_drone_1"].burstmin = 5;
    level.balldronesettings["alien_ball_drone_1"]._ID6331 = 10;
    level.balldronesettings["alien_ball_drone_1"]._ID23388 = 0.15;
    level.balldronesettings["alien_ball_drone_1"]._ID23387 = 0.35;
    level.balldronesettings["alien_ball_drone_1"]._ID20198 = 0.5;
    level.balldronesettings["alien_ball_drone_1"]._ID24592 = maps\mp\killstreaks\_unk1523::backupbuddyplayfx;
    level.balldronesettings["alien_ball_drone_1"]._ID14026 = [];
    level.balldronesettings["alien_ball_drone_1"]._ID14026["enemy"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink" );
    level.balldronesettings["alien_ball_drone_1"]._ID14026["friendly"] = loadfx( "fx/misc/light_mine_blink_friendly" );
    level.balldronesettings["alien_ball_drone_2"] = spawnstruct();
    level.balldronesettings["alien_ball_drone_2"].timeout = 35.0;
    level.balldronesettings["alien_ball_drone_2"].health = 999999;
    level.balldronesettings["alien_ball_drone_2"].maxhealth = 250;
    level.balldronesettings["alien_ball_drone_2"]._ID31889 = "ball_drone_backup";
    level.balldronesettings["alien_ball_drone_2"]._ID35155 = "backup_drone_mp";
    level.balldronesettings["alien_ball_drone_2"].modelbase = "vehicle_drone_backup_buddy";
    level.balldronesettings["alien_ball_drone_2"]._ID32680 = "used_ball_drone_radar";
    level.balldronesettings["alien_ball_drone_2"]._ID14031 = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ims_sparks" );
    level.balldronesettings["alien_ball_drone_2"].fxid_explode = loadfx( "fx/explosions/bouncing_betty_explosion" );
    level.balldronesettings["alien_ball_drone_2"]._ID30472 = "ball_drone_explode";
    level.balldronesettings["alien_ball_drone_2"]._ID35387 = "backup_destroyed";
    level.balldronesettings["alien_ball_drone_2"]._ID36472 = "destroyed_ball_drone";
    level.balldronesettings["alien_ball_drone_2"].weaponinfo = "alien_ball_drone_gun2_mp";
    level.balldronesettings["alien_ball_drone_2"]._ID36270 = "vehicle_drone_backup_buddy_gun";
    level.balldronesettings["alien_ball_drone_2"]._ID36295 = "tag_turret_attach";
    level.balldronesettings["alien_ball_drone_2"]._ID30491 = "weap_p99_fire_npc";
    level.balldronesettings["alien_ball_drone_2"]._ID30487 = "ball_drone_targeting";
    level.balldronesettings["alien_ball_drone_2"]._ID30476 = "ball_drone_lockon";
    level.balldronesettings["alien_ball_drone_2"].sentrymode = "sentry";
    level.balldronesettings["alien_ball_drone_2"]._ID35360 = 722500;
    level.balldronesettings["alien_ball_drone_2"].burstmin = 5;
    level.balldronesettings["alien_ball_drone_2"]._ID6331 = 10;
    level.balldronesettings["alien_ball_drone_2"]._ID23388 = 0.15;
    level.balldronesettings["alien_ball_drone_2"]._ID23387 = 0.35;
    level.balldronesettings["alien_ball_drone_2"]._ID20198 = 0.5;
    level.balldronesettings["alien_ball_drone_2"]._ID24592 = maps\mp\killstreaks\_unk1523::backupbuddyplayfx;
    level.balldronesettings["alien_ball_drone_2"]._ID14026 = [];
    level.balldronesettings["alien_ball_drone_2"]._ID14026["enemy"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink" );
    level.balldronesettings["alien_ball_drone_2"]._ID14026["friendly"] = loadfx( "fx/misc/light_mine_blink_friendly" );
    level.balldronesettings["alien_ball_drone_3"] = spawnstruct();
    level.balldronesettings["alien_ball_drone_3"].timeout = 50.0;
    level.balldronesettings["alien_ball_drone_3"].health = 999999;
    level.balldronesettings["alien_ball_drone_3"].maxhealth = 250;
    level.balldronesettings["alien_ball_drone_3"]._ID31889 = "ball_drone_backup";
    level.balldronesettings["alien_ball_drone_3"]._ID35155 = "backup_drone_mp";
    level.balldronesettings["alien_ball_drone_3"].modelbase = "vehicle_drone_backup_buddy";
    level.balldronesettings["alien_ball_drone_3"]._ID32680 = "used_ball_drone_radar";
    level.balldronesettings["alien_ball_drone_3"]._ID14031 = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ims_sparks" );
    level.balldronesettings["alien_ball_drone_3"].fxid_explode = loadfx( "fx/explosions/bouncing_betty_explosion" );
    level.balldronesettings["alien_ball_drone_3"]._ID30472 = "ball_drone_explode";
    level.balldronesettings["alien_ball_drone_3"]._ID35387 = "backup_destroyed";
    level.balldronesettings["alien_ball_drone_3"]._ID36472 = "destroyed_ball_drone";
    level.balldronesettings["alien_ball_drone_3"].weaponinfo = "alien_ball_drone_gun3_mp";
    level.balldronesettings["alien_ball_drone_3"]._ID36270 = "vehicle_drone_backup_buddy_gun";
    level.balldronesettings["alien_ball_drone_3"]._ID36295 = "tag_turret_attach";
    level.balldronesettings["alien_ball_drone_3"]._ID30491 = "weap_p99_fire_npc";
    level.balldronesettings["alien_ball_drone_3"]._ID30487 = "ball_drone_targeting";
    level.balldronesettings["alien_ball_drone_3"]._ID30476 = "ball_drone_lockon";
    level.balldronesettings["alien_ball_drone_3"].sentrymode = "sentry";
    level.balldronesettings["alien_ball_drone_3"]._ID35360 = 722500;
    level.balldronesettings["alien_ball_drone_3"].burstmin = 5;
    level.balldronesettings["alien_ball_drone_3"]._ID6331 = 10;
    level.balldronesettings["alien_ball_drone_3"]._ID23388 = 0.15;
    level.balldronesettings["alien_ball_drone_3"]._ID23387 = 0.35;
    level.balldronesettings["alien_ball_drone_3"]._ID20198 = 0.5;
    level.balldronesettings["alien_ball_drone_3"]._ID24592 = maps\mp\killstreaks\_unk1523::backupbuddyplayfx;
    level.balldronesettings["alien_ball_drone_3"]._ID14026 = [];
    level.balldronesettings["alien_ball_drone_3"]._ID14026["enemy"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink" );
    level.balldronesettings["alien_ball_drone_3"]._ID14026["friendly"] = loadfx( "fx/misc/light_mine_blink_friendly" );
    level.balldronesettings["alien_ball_drone_4"] = spawnstruct();
    level.balldronesettings["alien_ball_drone_4"].timeout = 50.0;
    level.balldronesettings["alien_ball_drone_4"].health = 999999;
    level.balldronesettings["alien_ball_drone_4"].maxhealth = 250;
    level.balldronesettings["alien_ball_drone_4"]._ID31889 = "ball_drone_backup";
    level.balldronesettings["alien_ball_drone_4"]._ID35155 = "backup_drone_mp";
    level.balldronesettings["alien_ball_drone_4"].modelbase = "vehicle_drone_backup_buddy";
    level.balldronesettings["alien_ball_drone_4"]._ID32680 = "used_ball_drone_radar";
    level.balldronesettings["alien_ball_drone_4"]._ID14031 = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ims_sparks" );
    level.balldronesettings["alien_ball_drone_4"].fxid_explode = loadfx( "fx/explosions/bouncing_betty_explosion" );
    level.balldronesettings["alien_ball_drone_4"]._ID30472 = "ball_drone_explode";
    level.balldronesettings["alien_ball_drone_4"]._ID35387 = "backup_destroyed";
    level.balldronesettings["alien_ball_drone_4"]._ID36472 = "destroyed_ball_drone";
    level.balldronesettings["alien_ball_drone_4"].weaponinfo = "alien_ball_drone_gun4_mp";
    level.balldronesettings["alien_ball_drone_4"]._ID36270 = "vehicle_drone_backup_buddy_gun";
    level.balldronesettings["alien_ball_drone_4"]._ID36295 = "tag_turret_attach";
    level.balldronesettings["alien_ball_drone_4"]._ID30491 = "weap_p99_fire_npc";
    level.balldronesettings["alien_ball_drone_4"]._ID30487 = "ball_drone_targeting";
    level.balldronesettings["alien_ball_drone_4"]._ID30476 = "ball_drone_lockon";
    level.balldronesettings["alien_ball_drone_4"].sentrymode = "sentry";
    level.balldronesettings["alien_ball_drone_4"]._ID35360 = 722500;
    level.balldronesettings["alien_ball_drone_4"].burstmin = 5;
    level.balldronesettings["alien_ball_drone_4"]._ID6331 = 10;
    level.balldronesettings["alien_ball_drone_4"]._ID23388 = 0.15;
    level.balldronesettings["alien_ball_drone_4"]._ID23387 = 0.35;
    level.balldronesettings["alien_ball_drone_4"]._ID20198 = 0.5;
    level.balldronesettings["alien_ball_drone_4"]._ID24592 = maps\mp\killstreaks\_unk1523::backupbuddyplayfx;
    level.balldronesettings["alien_ball_drone_4"]._ID14026 = [];
    level.balldronesettings["alien_ball_drone_4"]._ID14026["enemy"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink" );
    level.balldronesettings["alien_ball_drone_4"]._ID14026["friendly"] = loadfx( "fx/misc/light_mine_blink_friendly" );
    level.boxsettings["deployable_vest"]._ID16999 = &"ALIEN_COLLECTIBLES_DEPLOYABLE_VEST_PICKUP";
    level.boxsettings["deployable_vest"].capturingstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_VEST_GETTING";
    level.boxsettings["deployable_vest"].eventstring = &"ALIEN_COLLECTIBLES_DEPLOYED_VEST";
    level.boxsettings["deployable_ammo"]._ID16999 = &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_PICKUP";
    level.boxsettings["deployable_ammo"].capturingstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKING";
    level.boxsettings["deployable_ammo"].eventstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN";
    level.boxsettings["deployable_juicebox"]._ID16999 = &"ALIEN_COLLECTIBLES_DEPLOYABLE_BOOST_PICKUP";
    level.boxsettings["deployable_juicebox"].capturingstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_BOOST_TAKING";
    level.boxsettings["deployable_juicebox"].eventstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_BOOST_TAKEN";
    level.boxsettings["deployable_ammo"].deathdamagemax = undefined;
    level.minedamagemin = 325;
    level._ID21061 = 750;
    level._ID20752 = 5;
    level._ID9660 = [];
    level._ID9660[0] = 25;
    level._ID9660[1] = 50;
    level._ID9660[2] = 75;
    level._ID9660[3] = 100;
    level._ID9660[4] = 125;
    level._ID9659 = 125;
    level.deployablebox_juicebox_rank = [];
    level.deployablebox_juicebox_rank[0] = 15;
    level.deployablebox_juicebox_rank[1] = 30;
    level.deployablebox_juicebox_rank[2] = 30;
    level.deployablebox_juicebox_rank[3] = 45;
    level.deployablebox_juicebox_rank[4] = 60;
    level._ID9656 = 60;
    level.deployablebox_adrenalinebox_rank = [];
    level.deployablebox_adrenalinebox_rank[0] = 15;
    level.deployablebox_adrenalinebox_rank[1] = 15;
    level.deployablebox_adrenalinebox_rank[2] = 15;
    level.deployablebox_adrenalinebox_rank[3] = 30;
    level.deployablebox_adrenalinebox_rank[4] = 45;
    level.deployablebox_adrenalinebox_max = 45;
}

init_combat_resource_from_table()
{
    level.alien_combat_resources = [];
    populate_combat_resource_from_table( 0, "munition" );
    populate_combat_resource_from_table( 100, "support" );
    populate_combat_resource_from_table( 200, "defense" );
    populate_combat_resource_from_table( 300, "offense" );
}

canceluse_default_deployable_box( var_0, var_1 )
{
    self takeweapon( "aliendeployable_crate_marker_mp" );
    self.deployable = 0;
    self switchtoweapon( self._ID19508 );
    self notify( "cancel_deployable_via_marker" );
}

populate_combat_resource_from_table( var_0, var_1 )
{
    level.alien_combat_resources[var_1] = [];

    for ( var_2 = var_0; var_2 <= var_0 + 99; var_2++ )
    {
        var_3 = get_resource_ref_by_index( var_2 );

        if ( var_3 == "" )
            break;

        if ( !isdefined( level.alien_combat_resources[var_3] ) )
        {
            var_4 = spawnstruct();
            var_4._ID34652 = [];
            var_4._ID34238 = _ID14814( var_3 );
            var_4.name = get_name_by_ref( var_3 );
            var_4._ID17321 = _ID14517( var_3 );
            var_4.dpad_icon = _ID14425( var_3 );
            var_4._ID25633 = var_3;
            var_4.type = var_1;
            var_4._ID6490 = level.alien_combat_resource_callbacks[var_3];
            level.alien_combat_resources[var_1][var_3] = var_4;
        }

        var_5 = 0;

        for ( var_6 = var_2; var_6 <= var_0 + 99; var_6++ )
        {
            var_7 = get_resource_ref_by_index( var_6 );

            if ( var_7 == "" )
                break;

            if ( var_3 == var_7 || is_resource_set( var_3, var_7 ) )
            {
                var_8 = spawnstruct();
                var_8._ID25633 = var_7;
                var_8.desc = get_desc_by_ref( var_7 );
                var_8.cost = _ID14374( var_7 );
                var_8.point_cost = _ID14682( var_7 );
                var_8.dpad_icon = _ID14429( var_7 );
                var_5 += int( var_8.point_cost );
                var_8._ID33143 = var_5;
                level.alien_combat_resources[var_1][var_3]._ID34652[var_6 - var_2] = var_8;
                continue;
            }

            break;
        }

        var_2 = var_6 - 1;
    }
}

is_resource_set( var_0, var_1 )
{
    if ( var_0 == var_1 )
        return 0;

    if ( !issubstr( var_1, var_0 ) )
        return 0;

    var_2 = strtok( var_0, "_" );
    var_3 = strtok( var_1, "_" );

    if ( var_3.size - var_2.size != 1 )
        return 0;

    for ( var_4 = 0; var_4 < var_3.size - 1; var_4++ )
    {
        if ( var_3[var_4] != var_2[var_4] )
            return 0;
    }

    return 1;
}

get_resource_ref_by_index( var_0 )
{
    return tablelookup( level.alien_combat_resources_table, 0, var_0, 1 );
}

get_name_by_ref( var_0 )
{
    return tablelookup( level.alien_combat_resources_table, 1, var_0, 5 );
}

_ID14517( var_0 )
{
    return tablelookup( level.alien_combat_resources_table, 1, var_0, 7 );
}

_ID14425( var_0 )
{
    return tablelookup( level.alien_combat_resources_table, 1, var_0, 8 );
}

get_desc_by_ref( var_0 )
{
    return tablelookup( level.alien_combat_resources_table, 1, var_0, 6 );
}

_ID14682( var_0 )
{
    return int( tablelookup( level.alien_combat_resources_table, 1, var_0, 3 ) );
}

_ID14374( var_0 )
{
    return int( tablelookup( level.alien_combat_resources_table, 1, var_0, 4 ) );
}

_ID14814( var_0 )
{
    return int( tablelookup( level.alien_combat_resources_table, 1, var_0, 2 ) );
}

get_is_upgrade_by_ref( var_0 )
{
    return int( tablelookup( level.alien_combat_resources_table, 1, var_0, 9 ) );
}

_ID14429( var_0 )
{
    return tablelookup( level.alien_combat_resources_table, 1, var_0, 8 );
}

has_ims()
{
    if ( isdefined( self._ID17471 ) && self._ID17471.size > 0 && isalive( self._ID17471[0] ) )
        return 1;

    return 0;
}

_ID16337()
{
    if ( isdefined( self.balldrone ) )
        return 1;

    return 0;
}

tryuse_dpad_team_ammo( var_0, var_1 )
{
    self._ID32637 = var_1;
    common_tryuse_actions();
    thread maps\mp\alien\_deployablebox::_ID37087( var_1, "deployable_ammo" );
}

deployable_ammo_placed_listener()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "new_deployable_box",  var_0  );
    _ID33258( var_0 );
    var_0 setcandamage( 0 );
    var_0 setcanradiusdamage( 0 );

    if ( var_0._ID34651 == 4 )
        var_0 thread _ID32638();
}

_ID33258( var_0 )
{
    if ( !isdefined( self.active_deployables ) )
        self.active_deployables = [];

    if ( isdefined( self.active_deployables[var_0.boxtype] ) )
        self.active_deployables[var_0.boxtype] notify( "death" );

    self.active_deployables[var_0.boxtype] = var_0;
}

_ID32638()
{
    self endon( "death" );
    self endon( "ammo_regen_timeout" );
    var_0 = 65536.0;
    var_1 = 0.1;

    for (;;)
    {
        foreach ( var_3 in level.players )
        {
            if ( isalive( var_3 ) && distancesquared( self.origin, var_3.origin ) < var_0 )
                var_3 _ID36637::addratiomaxstocktoallweapons( var_1 );

            wait 5.0;
        }
    }
}

_ID34695( var_0, var_1 )
{
    thread deployable_ammo_placed_listener();
    self.deployable = 0;
    level thread maps\mp\alien\_music_and_dialog::_ID24695( self );
}

_ID33817( var_0, var_1 )
{
    self._ID32640 = var_1;
    common_tryuse_actions();
    thread maps\mp\alien\_deployablebox::_ID37087( var_1, "deployable_juicebox" );
}

_ID9645()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "new_deployable_box",  var_0  );
    _ID33258( var_0 );
    var_0 setcandamage( 0 );
    var_0 setcanradiusdamage( 0 );
}

_ID34697( var_0, var_1 )
{
    thread _ID9645();
    self.deployable = 0;
    level thread maps\mp\alien\_music_and_dialog::_ID24697( self );
}

_ID33814( var_0, var_1 )
{
    self._ID32636 = var_1;
    common_tryuse_actions();
    thread maps\mp\alien\_deployablebox::_ID37087( var_1, "deployable_adrenalinebox" );
}

_ID9642()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "new_deployable_box",  var_0  );
    _ID33258( var_0 );
    var_0 setcandamage( 0 );
    var_0 setcanradiusdamage( 0 );
}

_ID34694( var_0, var_1 )
{
    thread _ID9642();
    self.deployable = 0;
    level thread maps\mp\alien\_music_and_dialog::_ID24697( self );
}

_ID33816( var_0, var_1 )
{
    self._ID32639 = var_1;
    common_tryuse_actions();
    thread maps\mp\alien\_deployablebox::_ID37087( var_1, "deployable_vest" );
}

deployable_armor_placed_listener()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "new_deployable_box",  var_0  );
    _ID33258( var_0 );
    var_0 setcandamage( 0 );
    var_0 setcanradiusdamage( 0 );
}

_ID34696( var_0, var_1 )
{
    thread deployable_armor_placed_listener();
    self.deployable = 0;
    level thread maps\mp\alien\_music_and_dialog::_ID24696( self );
}

tryuse_dpad_team_explosives( var_0, var_1 )
{
    self._ID32642 = var_1;
    common_tryuse_actions();
    thread maps\mp\alien\_deployablebox::_ID37087( var_1, "deployable_explosives" );
}

_ID9650()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "new_deployable_box",  var_0  );
    _ID33258( var_0 );
    var_0 setcandamage( 0 );
    var_0 setcanradiusdamage( 0 );
}

_ID34699( var_0, var_1 )
{
    thread _ID9650();
    self.deployable = 0;
    level notify( "dlc_vo_notify",  "inform_explosives", self  );

    if ( !isdefined( level._ID38237 ) )
        level thread maps\mp\alien\_music_and_dialog::_ID24694( self );
}

_ID33820( var_0, var_1 )
{
    self._ID32645 = var_1;
    common_tryuse_actions();
    thread maps\mp\alien\_deployablebox::_ID37087( var_1, "deployable_randombox" );
}

deployable_randombox_placed_listener()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "new_deployable_box",  var_0  );
    _ID33258( var_0 );
    var_0 setcandamage( 0 );
    var_0 setcanradiusdamage( 0 );
}

use_dpad_team_randombox( var_0, var_1 )
{
    thread deployable_randombox_placed_listener();
    self.deployable = 0;
    level thread maps\mp\alien\_music_and_dialog::playvoforrandombox( self );
}

_ID33818( var_0, var_1 )
{
    self._ID32641 = var_1;
    common_tryuse_actions();
    thread maps\mp\alien\_deployablebox::_ID37087( var_1, "deployable_currency" );
}

deployable_currency_placed_listener()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "new_deployable_box",  var_0  );
    var_0 setcandamage( 0 );
    var_0 setcanradiusdamage( 0 );
}

_ID34698( var_0, var_1 )
{
    thread deployable_currency_placed_listener();
    self.deployable = 0;
}

canpurchase_dpad_riotshield( var_0, var_1 )
{
    if ( self.hasriotshield )
    {
        maps\mp\_utility::setlowermessage( "riot_shield_equipped", &"ALIEN_COLLECTIBLES_RIOT_SHIELD_EQUIPPED", 3 );
        return 0;
    }

    return _ID36713( var_0, var_1 );
}

_ID33811( var_0, var_1 )
{
    _ID33812( var_0, var_1 );
}

_ID33812( var_0, var_1 )
{
    maps\mp\alien\_unk1464::store_weapons_status();
    self._ID19508 = self getcurrentweapon();

    if ( var_1 == 0 )
    {
        maps\mp\_utility::_giveweapon( "iw5_alienriotshield_mp" );
        self setweaponammoclip( "iw5_alienriotshield_mp", 10 );
        self switchtoweapon( "iw5_alienriotshield_mp" );
    }

    if ( var_1 == 1 )
    {
        maps\mp\_utility::_giveweapon( "iw5_alienriotshield1_mp" );
        self setweaponammoclip( "iw5_alienriotshield1_mp", 15 );
        self switchtoweapon( "iw5_alienriotshield1_mp" );
    }

    if ( var_1 == 2 )
    {
        maps\mp\_utility::_giveweapon( "iw5_alienriotshield2_mp" );
        self setweaponammoclip( "iw5_alienriotshield2_mp", 15 );
        self switchtoweapon( "iw5_alienriotshield2_mp" );
    }

    if ( var_1 == 3 )
    {
        maps\mp\_utility::_giveweapon( "iw5_alienriotshield3_mp" );
        self setweaponammoclip( "iw5_alienriotshield3_mp", 20 );
        self switchtoweapon( "iw5_alienriotshield3_mp" );
    }

    if ( var_1 == 4 )
    {
        maps\mp\_utility::_giveweapon( "iw5_alienriotshield4_mp" );
        self setweaponammoclip( "iw5_alienriotshield4_mp", 25 );
        self.fireshield = 1.0;
        self switchtoweapon( "iw5_alienriotshield4_mp" );
    }

    wait 0.5;
}

_ID34692( var_0, var_1 )
{
    self notify( "action_use" );
    self setclientomnvar( "ui_alien_riotshield_equipped", 1 );
    level notify( "dlc_vo_notify",  "inform_shield", self  );
}

canceluse_dpad_riotshield( var_0, var_1 )
{
    if ( var_1 == 0 )
        self takeweapon( "iw5_alienriotshield_mp" );

    if ( var_1 == 1 )
        self takeweapon( "iw5_alienriotshield1_mp" );

    if ( var_1 == 2 )
        self takeweapon( "iw5_alienriotshield2_mp" );

    if ( var_1 == 3 )
        self takeweapon( "iw5_alienriotshield3_mp" );

    if ( var_1 == 4 )
        self takeweapon( "iw5_alienriotshield4_mp" );

    if ( !isdefined( level.drill_carrier ) || isdefined( level.drill_carrier ) && self != level.drill_carrier )
    {
        if ( isdefined( self._ID19508 ) )
            self switchtoweapon( self._ID19508 );
    }

    self setclientomnvar( "ui_alien_riotshield_equipped", -1 );
    return 1;
}

_ID6627( var_0, var_1 )
{
    var_2 = _ID14821();
    var_3 = get_max_sentry_count( var_1, "sentry" );

    if ( var_2 >= var_3 )
    {
        self iprintlnbold( &"ALIEN_COLLECTIBLES_MAX_TURRETS" );
        return 0;
    }

    if ( maps\mp\alien\_unk1464::_ID18506( self._ID18582 ) )
        return 0;

    return _ID37076( var_0, var_1 );
}

_ID33813( var_0, var_1 )
{
    if ( maps\mp\alien\_unk1464::_ID18506( self._ID18582 ) )
        return 0;

    self._ID19508 = self getcurrentweapon();

    if ( var_1 == 0 )
    {
        self._ID19488 = "alien_sentry";
        var_2 = [[ level._ID8475 ]]( "alien_sentry", self );
        var_2 setconvergencetime( 1.5, "pitch" );
        var_2 setconvergencetime( 1.5, "yaw" );
        self._ID6724 = var_2;
        var_2 [[ level._ID28141 ]]( self );
        self disableweapons();
    }

    if ( var_1 == 1 )
    {
        self._ID19488 = "alien_sentry_1";
        var_3 = [[ level._ID8475 ]]( "alien_sentry_1", self );
        var_3 setconvergencetime( 1.0, "pitch" );
        var_3 setconvergencetime( 1.0, "yaw" );
        self._ID6724 = var_3;
        var_3 [[ level._ID28141 ]]( self );
        self disableweapons();
    }

    if ( var_1 == 2 )
    {
        self._ID19488 = "alien_sentry_2";
        var_4 = [[ level._ID8475 ]]( "alien_sentry_2", self );
        var_4 setconvergencetime( 1.0, "pitch" );
        var_4 setconvergencetime( 1.0, "yaw" );
        self._ID6724 = var_4;
        var_4 [[ level._ID28141 ]]( self );
        self disableweapons();
    }

    if ( var_1 == 3 )
    {
        self._ID19488 = "alien_sentry_3";
        var_5 = [[ level._ID8475 ]]( "alien_sentry_3", self );
        var_5 setconvergencetime( 1.0, "pitch" );
        var_5 setconvergencetime( 1.0, "yaw" );
        self._ID6724 = var_5;
        var_5 [[ level._ID28141 ]]( self );
        self disableweapons();
    }

    if ( var_1 == 4 )
    {
        self._ID19488 = "alien_sentry_4";
        var_6 = [[ level._ID8475 ]]( "alien_sentry_4", self );
        var_6 setconvergencetime( 1.0, "pitch" );
        var_6 setconvergencetime( 1.0, "yaw" );
        self._ID6724 = var_6;
        var_6 [[ level._ID28141 ]]( self );
        self disableweapons();
    }
}

_ID28126( var_0 )
{
    var_1 = 1.5;
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self disableweaponswitch();
    self waittill( "new_sentry",  var_2  );
    self enableweaponswitch();
    thread manage_sentry_count( var_0, "sentry" );

    if ( issentient( var_2 ) )
    {
        if ( !maps\mp\alien\_unk1464::is_chaos_mode() )
            var_2.threatbias = -1000;
        else
            var_2.threatbias = -3500;
    }

    var_2.maxhealth = 150;

    if ( isdefined( var_2.owner ) && var_2.owner maps\mp\alien\_persistence::is_upgrade_enabled( "sentry_health_upgrade" ) )
        var_2.maxhealth = int( var_2.maxhealth * var_1 );

    var_3 = 450;

    switch ( var_0 )
    {
        case 1:
            var_3 = 450;
            break;
        case 2:
            var_3 = 450;
            break;
        case 3:
            var_3 = 600;
            break;
        case 4:
            var_3 = 600;
            break;
        default:
            var_3 = 450;
    }

    var_2 thread _ID28162( var_3 );
}

_ID28162( var_0 )
{
    self endon( "death" );

    while ( var_0 > 0 )
    {
        self waittill( "bullet_fired" );
        var_0--;
    }

    self notify( "death" );
}

_ID34693( var_0, var_1 )
{
    thread _ID28126( var_1 );
    self._ID6724 [[ level._ID28145 ]]();
    self enableweapons();
    self._ID6724 = undefined;
    self._ID18582 = 0;

    if ( isdefined( self._ID19508 ) )
        self switchtoweapon( self._ID19508 );

    level thread maps\mp\alien\_music_and_dialog::_ID24691( self, "sentry" );
}

canceluse_dpad_sentry( var_0, var_1 )
{
    if ( isdefined( self._ID6724 ) )
        self._ID6724 [[ level._ID28139 ]]();

    self enableweapons();

    if ( isdefined( self._ID19508 ) )
        self switchtoweapon( self._ID19508 );
}

_ID14821()
{
    var_0 = _ID14272( "sentry" );
    return _ID14820( var_0 );
}

_ID6622( var_0, var_1 )
{
    var_2 = _ID37341();
    var_3 = 1;

    if ( var_2 >= var_3 )
    {
        self iprintlnbold( &"ALIEN_COLLECTIBLES_MAX_TURRETS" );
        return 0;
    }

    return _ID37076( var_0, var_1 );
}

_ID33807( var_0, var_1 )
{
    self._ID19508 = self getcurrentweapon();

    if ( var_1 == 0 )
    {
        self._ID19488 = "gl_turret";
        var_2 = [[ level._ID8475 ]]( "gl_turret", self );
        self._ID6724 = var_2;
        var_2 [[ level._ID28141 ]]( self );
        self disableweapons();
    }

    if ( var_1 == 1 )
    {
        self._ID19488 = "gl_turret_1";
        var_3 = [[ level._ID8475 ]]( "gl_turret_1", self );
        self._ID6724 = var_3;
        var_3 [[ level._ID28141 ]]( self );
        self disableweapons();
    }

    if ( var_1 == 2 )
    {
        self._ID19488 = "gl_turret_2";
        var_4 = [[ level._ID8475 ]]( "gl_turret_2", self );
        self._ID6724 = var_4;
        var_4 [[ level._ID28141 ]]( self );
        self disableweapons();
    }

    if ( var_1 == 3 )
    {
        self._ID19488 = "gl_turret_3";
        var_5 = [[ level._ID8475 ]]( "gl_turret_3", self );
        self._ID6724 = var_5;
        var_5 [[ level._ID28141 ]]( self );
        self disableweapons();
    }

    if ( var_1 == 4 )
    {
        self._ID19488 = "gl_turret_4";
        var_6 = [[ level._ID8475 ]]( "gl_turret_4", self );
        self._ID6724 = var_6;
        var_6 [[ level._ID28141 ]]( self );
        self disableweapons();
    }
}

glsentry_placed_listener( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self disableweaponswitch();
    self waittill( "new_sentry",  var_1  );
    self enableweaponswitch();
    thread manage_sentry_count( var_0, "grenade" );

    if ( issentient( var_1 ) )
        var_1.threatbias = -1000;

    var_1.maxhealth = 150;
    var_2 = 10;

    switch ( var_0 )
    {
        case 1:
            var_2 = 15;
            break;
        case 2:
            var_2 = 15;
            break;
        case 3:
            var_2 = 30;
            break;
        case 4:
            var_2 = 30;
            break;
        default:
            var_2 = 10;
    }

    var_1 thread _ID15693( var_2, self );
}

_ID15693( var_0, var_1 )
{
    self endon( "death" );
    self._ID33995 = var_0;
    thread _ID36014();

    while ( var_0 > 0 )
    {
        self waittill( "turret_fire" );
        var_0--;
    }

    self._ID13518 = 1;
    self maketurretinoperable();

    if ( isdefined( self.owner ) && isalive( self.owner ) )
        thread _ID36001( var_1 );
}

use_dpad_glsentry( var_0, var_1 )
{
    thread glsentry_placed_listener( var_1 );
    self._ID6724 [[ level._ID28145 ]]();
    self enableweapons();
    self._ID6724 = undefined;
    self._ID18582 = 0;

    if ( isdefined( self._ID19508 ) )
        self switchtoweapon( self._ID19508 );

    level thread maps\mp\alien\_music_and_dialog::_ID24691( self, "grenade" );
}

canceluse_dpad_glsentry( var_0, var_1 )
{
    if ( isdefined( self._ID6724 ) )
        self._ID6724 [[ level._ID28139 ]]();

    self enableweapons();

    if ( isdefined( self._ID19508 ) )
        self switchtoweapon( self._ID19508 );
}

_ID37341()
{
    var_0 = _ID14272( "grenade" );
    return _ID14820( var_0 );
}

canpurchase_dpad_minigun_turret( var_0, var_1 )
{
    var_2 = _ID37342();
    var_3 = 1;

    if ( var_2 >= var_3 )
    {
        self iprintlnbold( &"ALIEN_COLLECTIBLES_MAX_TURRETS" );
        return 0;
    }

    return _ID37076( var_0, var_1 );
}

_ID33809( var_0, var_1 )
{
    self._ID19508 = self getcurrentweapon();

    if ( var_1 == 0 )
    {
        self._ID19508 = self getcurrentweapon();
        self._ID19488 = "minigun_turret";
        var_2 = [[ level._ID8475 ]]( "minigun_turret", self );
        self._ID6724 = var_2;
        var_2 [[ level._ID28141 ]]( self );
        self disableweapons();
    }

    if ( var_1 == 1 )
    {
        self._ID19508 = self getcurrentweapon();
        self._ID19488 = "minigun_turret_1";
        var_3 = [[ level._ID8475 ]]( "minigun_turret_1", self );
        self._ID6724 = var_3;
        var_3 [[ level._ID28141 ]]( self );
        self disableweapons();
    }

    if ( var_1 == 2 )
    {
        self._ID19508 = self getcurrentweapon();
        self._ID19488 = "minigun_turret";
        var_4 = [[ level._ID8475 ]]( "minigun_turret_2", self );
        self._ID6724 = var_4;
        var_4 [[ level._ID28141 ]]( self );
        self disableweapons();
    }

    if ( var_1 == 3 )
    {
        self._ID19508 = self getcurrentweapon();
        self._ID19488 = "minigun_turret";
        var_5 = [[ level._ID8475 ]]( "minigun_turret_3", self );
        self._ID6724 = var_5;
        var_5 [[ level._ID28141 ]]( self );
        self disableweapons();
    }

    if ( var_1 == 4 )
    {
        self._ID19508 = self getcurrentweapon();
        self._ID19488 = "minigun_turret";
        var_6 = [[ level._ID8475 ]]( "minigun_turret_4", self );
        self._ID6724 = var_6;
        var_6 [[ level._ID28141 ]]( self );
        self disableweapons();
    }
}

minigun_turret_placed_listener( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self disableweaponswitch();
    self waittill( "new_sentry",  var_1  );
    self enableweaponswitch();
    var_1.owner = self;
    thread manage_sentry_count( var_0, "minigun" );

    if ( issentient( var_1 ) )
        var_1.threatbias = -1000;

    var_1.maxhealth = 150;
    var_2 = 100;

    switch ( var_0 )
    {
        case 1:
            var_2 = 125;
            break;
        case 2:
            var_2 = 150;
            break;
        case 3:
            var_2 = 175;
            break;
        case 4:
            var_2 = 200;
            break;
        default:
            var_2 = 100;
    }

    var_1 thread minigun_turret_watch_ammo( var_2, self );
}

minigun_turret_watch_ammo( var_0, var_1 )
{
    self endon( "death" );
    self._ID33995 = var_0;
    thread _ID36014();

    while ( var_0 > 0 )
    {
        self waittill( "turret_fire" );
        var_0--;
    }

    self._ID13518 = 1;
    self turretfiredisable();

    if ( isdefined( self.owner ) && isalive( self.owner ) )
        thread _ID36001( var_1 );
}

_ID34073( var_0 )
{
    self endon( "death" );
    self notify( "turretupdateammocount" );
    self endon( "turretupdateammocount" );

    while ( self._ID33995 > 0 )
    {
        self waittill( "turret_fire" );
        self._ID33995--;

        if ( isdefined( var_0 ) && isalive( var_0 ) )
        {
            var_0 notify( "turret_fire" );
            var_0 maps\mp\alien\_unk1464::_ID28592( self._ID33995 );
        }
    }
}

_ID36014()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "trigger",  var_0  );

        if ( !isplayer( var_0 ) )
            continue;

        if ( isdefined( self._ID33995 ) )
        {
            var_0 maps\mp\alien\_unk1464::_ID29953( 1 );
            var_0 maps\mp\alien\_unk1464::_ID28592( self._ID33995 );

            if ( !maps\mp\alien\_unk1464::is_chaos_mode() )
                var_0 maps\mp\alien\_unk1464::_ID10113();
        }

        thread _ID34073( var_0 );
        thread _ID7469( var_0 );
        self waittill( "turret_deactivate" );

        if ( isdefined( var_0 ) && isalive( var_0 ) )
        {
            var_0 notify( "weapon_change",  var_0 getcurrentprimaryweapon()  );
            var_0 maps\mp\alien\_unk1464::hide_turret_icon();
        }
    }
}

_ID36001( var_0 )
{
    var_0 thread maps\mp\alien\_unk1464::wait_for_player_to_dismount_turret();
    self waittill( "player_dismount" );
    self._ID9631 = 1;
    wait 1;
    self notify( "death" );

    if ( isdefined( var_0 ) && isalive( var_0 ) )
    {
        var_0 maps\mp\alien\_unk1464::hide_turret_icon();

        if ( !maps\mp\alien\_unk1464::is_chaos_mode() )
            var_0 maps\mp\alien\_unk1464::_ID11463();

        var_1 = var_0 getcurrentweapon();
        var_0 notify( "weapon_change",  var_1  );
    }
}

_ID7469( var_0 )
{
    self notify( "clearammocounterondeath" );
    self endon( "clearammocounterondeath" );
    self endon( "turret_deactivate" );
    var_0 endon( "disconnect" );
    self waittill( "death" );
    var_0 maps\mp\alien\_unk1464::hide_turret_icon();
    var_0 maps\mp\alien\_unk1464::_ID11463();
}

_ID34690( var_0, var_1 )
{
    thread minigun_turret_placed_listener( var_1 );
    self._ID6724 [[ level._ID28145 ]]();
    self enableweapons();
    self._ID6724 = undefined;
    self._ID18582 = 0;

    if ( isdefined( self._ID19508 ) )
        self switchtoweapon( self._ID19508 );

    level thread maps\mp\alien\_music_and_dialog::_ID24691( self, "generic" );
}

canceluse_dpad_minigun_turret( var_0, var_1 )
{
    if ( isdefined( self._ID6724 ) )
        self._ID6724 [[ level._ID28139 ]]();

    self enableweapons();

    if ( isdefined( self._ID19508 ) )
        self switchtoweapon( self._ID19508 );
}

_ID37342()
{
    var_0 = _ID14272( "minigun" );
    return _ID14820( var_0 );
}

_ID6623( var_0, var_1 )
{
    if ( isdefined( self._ID17471 ) )
        var_2 = _ID14820( self._ID17471 );
    else
        var_2 = 0;

    if ( var_2 > 0 )
    {
        self iprintlnbold( &"ALIEN_COLLECTIBLES_MAX_IMS" );
        return 0;
    }

    return _ID37076( var_0, var_1 );
}

_ID33808( var_0, var_1 )
{
    self._ID19508 = self getcurrentweapon();
    var_2 = undefined;

    switch ( var_1 )
    {
        case 0:
            var_2 = "alien_ims";
            break;
        case 1:
            var_2 = "alien_ims_1";
            break;
        case 2:
            var_2 = "alien_ims_2";
            break;
        case 3:
            var_2 = "alien_ims_3";
            break;
        case 4:
            var_2 = "alien_ims_4";
            break;
    }

    var_3 = maps\mp\killstreaks\_ims::createimsforplayer( var_2, self );
    self._ID6722 = var_3;
    var_3._ID13165 = 1;
    thread maps\mp\killstreaks\_ims::_ID28666( var_3, 1 );

    if ( issentient( self._ID6722 ) )
        self._ID6722.threatbias = -3000;
}

_ID34689( var_0, var_1 )
{
    self enableweapons();
    self._ID6722 = undefined;
    self._ID18582 = 0;

    if ( isdefined( self._ID19508 ) )
        self switchtoweapon( self._ID19508 );

    self enableweaponswitch();
    level thread maps\mp\alien\_music_and_dialog::_ID24677( self );
}

canceluse_dpad_ims( var_0, var_1 )
{
    self enableweapons();

    if ( isdefined( self._ID19508 ) )
        self switchtoweapon( self._ID19508 );
}

ims_fire_cloud( var_0, var_1 )
{
    self endon( "death" );
    var_1 endon( "disconnect" );
    level endon( "game_ended" );
    var_2 = 9;

    if ( var_1 maps\mp\alien\_persistence::is_upgrade_enabled( "ims_fire_upgrade" ) )
    {
        level thread maps\mp\alien\_collectibles::_ID13053( var_1, var_2, var_0 );
        level thread maps\mp\alien\_collectibles::firecloudsfx( var_2, var_0 );
    }
}

ims_grace_period_scalar( var_0, var_1 )
{
    if ( var_1 maps\mp\alien\_persistence::is_upgrade_enabled( "ims_gracetime_upgrade" ) )
        var_0 /= 2;

    return var_0;
}

canpurchase_dpad_backup_buddy( var_0, var_1 )
{
    if ( _ID16337() )
    {
        self iprintlnbold( &"ALIEN_COLLECTIBLES_MAX_DRONE" );
        return 0;
    }

    return _ID37076( var_0, var_1 );
}

_ID33804( var_0, var_1 )
{
    self._ID23541 = 1;
    self._ID19508 = self getcurrentweapon();
    maps\mp\_utility::_giveweapon( "mortar_detonator_mp" );
    self switchtoweaponimmediate( "mortar_detonator_mp" );
    thread maps\mp\alien\_collectibles::_ID7448();
}

_ID34686( var_0, var_1 )
{
    if ( var_1 == 0 )
        maps\mp\killstreaks\_unk1523::useballdrone( "alien_ball_drone" );

    if ( var_1 == 1 )
        maps\mp\killstreaks\_unk1523::useballdrone( "alien_ball_drone_1" );

    if ( var_1 == 2 )
        maps\mp\killstreaks\_unk1523::useballdrone( "alien_ball_drone_2" );

    if ( var_1 == 3 )
        maps\mp\killstreaks\_unk1523::useballdrone( "alien_ball_drone_3" );

    if ( var_1 == 4 )
        maps\mp\killstreaks\_unk1523::useballdrone( "alien_ball_drone_4" );

    wait 0.1;
    self notify( "action_use" );

    if ( maps\mp\alien\_unk1464::_ID18506( self.drone_failed ) )
    {
        self.drone_failed = undefined;
        self iprintlnbold( &"ALIEN_COLLECTIBLES_REMOTE_TANK_CANNOT_PLACE" );
        maps\mp\alien\_persistence::_ID15551( ceil( var_0._ID34652[var_1].cost ) );
    }
    else
    {
        level notify( "dlc_vo_notify",  "online_vulture", self  );

        if ( !isdefined( level._ID38237 ) )
            level thread maps\mp\alien\_music_and_dialog::_ID24675( self );
    }

    self takeweapon( "mortar_detonator_mp" );

    if ( isdefined( self._ID19508 ) )
        self switchtoweapon( self._ID19508 );
}

canceluse_dpad_backup_buddy( var_0, var_1 )
{
    self takeweapon( "mortar_detonator_mp" );
    self.deployable = 0;

    if ( isdefined( self._ID19508 ) )
        self switchtoweapon( self._ID19508 );

    return 1;
}

ball_drone_timeout_scalar( var_0, var_1 )
{
    if ( var_1 maps\mp\alien\_persistence::is_upgrade_enabled( "vulture_duration_upgrade" ) )
        var_0 *= 1.5;

    return var_0;
}

ball_drone_fire_rocket_scalar( var_0, var_1 )
{
    if ( var_1 maps\mp\alien\_persistence::is_upgrade_enabled( "vulture_duration_upgrade" ) )
        var_0 *= 0.6;

    return var_0;
}

_ID33803( var_0, var_1 )
{
    self._ID19508 = self getcurrentweapon();
    maps\mp\_utility::_giveweapon( "mortar_detonator_mp" );
    self switchtoweaponimmediate( "mortar_detonator_mp" );
}

_ID34685( var_0, var_1 )
{
    level thread maps\mp\alien\_music_and_dialog::_ID24681( self );
    self takeweapon( "mortar_detonator_mp" );

    if ( isdefined( self._ID19508 ) )
        self switchtoweapon( self._ID19508 );

    domortar( var_1 );
}

canceluse_dpad_airstrike( var_0, var_1 )
{
    self takeweapon( "mortar_detonator_mp" );

    if ( isdefined( self._ID19508 ) )
        self switchtoweapon( self._ID19508 );

    return 1;
}

domortar( var_0 )
{
    var_1 = 2;
    var_2 = 300;
    var_3 = 1000;
    var_4 = 4000;

    if ( var_0 == 0 )
    {
        var_1 = 3;
        var_2 = 200;
        var_3 = 500;
        var_4 = 1000;
    }

    if ( var_0 == 1 )
    {
        var_1 = 4;
        var_2 = 200;
        var_3 = 500;
        var_4 = 1000;
    }

    if ( var_0 == 2 )
    {
        var_1 = 4;
        var_2 = 256;
        var_3 = 500;
        var_4 = 1500;
    }

    if ( var_0 == 3 )
    {
        var_1 = 5;
        var_2 = 350;
        var_3 = 500;
        var_4 = 1500;
    }

    if ( var_0 == 4 )
    {
        var_1 = 6;
        var_2 = 350;
        var_3 = 1000;
        var_4 = 2000;
    }

    var_5 = 1;
    var_6 = self.origin;

    for ( var_7 = 0; var_7 < var_1; var_7++ )
    {
        var_8 = bullettrace( var_6 + ( 0, 0, 500 ), var_6 - ( 0, 0, 500 ), 0 );

        if ( isdefined( var_8["position"] ) )
        {
            playfx( level._ID21472["tracer"], var_6 );
            thread maps\mp\_utility::_ID24644( "fast_artillery_round", var_6 );
            wait(randomfloatrange( 0.5, 1.5 ));
            playfx( level._ID21472["explosion"], var_6 );
            radiusdamage( self.origin, var_2, var_4, var_3, self, "MOD_EXPLOSIVE", "alienmortar_strike_mp" );
            playrumbleonposition( "grenade_rumble", var_6 );
            earthquake( 1.0, 0.6, var_6, 2000 );
            thread maps\mp\_utility::_ID24644( "exp_suitcase_bomb_main", var_6 );
            physicsexplosionsphere( var_6 + ( 0, 0, 30 ), 250, 125, 2 );
            var_5 *= -1;
        }

        var_6 = self.origin + ( randomintrange( 100, 600 ) * var_5, randomintrange( 100, 600 ) * var_5, 0 );
    }
}

_ID33821( var_0, var_1 )
{
    _ID37086( var_1, "deployable_specialammo" );
}

deployable_specialammo_placed_listener()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "new_deployable_box",  var_0  );
    _ID33258( var_0 );
    var_0 setcandamage( 0 );
    var_0 setcanradiusdamage( 0 );
}

_ID34701( var_0, var_1 )
{
    thread deployable_specialammo_placed_listener();
    self.deployable = 0;
    level thread maps\mp\alien\_music_and_dialog::_ID24692( self );
}

_ID33823( var_0, var_1 )
{
    _ID37086( var_1, "deployable_specialammo_explo" );
}

_ID38238( var_0, var_1 )
{
    thread deployable_specialammo_placed_listener();
    self.deployable = 0;
    level notify( "dlc_vo_notify",  "ready_explosiverounds", self  );

    if ( !isdefined( level._ID38237 ) )
        level thread maps\mp\alien\_music_and_dialog::_ID24692( self );
}

_ID33822( var_0, var_1 )
{
    _ID37086( var_1, "deployable_specialammo_ap" );
}

_ID33824( var_0, var_1 )
{
    _ID37086( var_1, "deployable_specialammo_in" );
}

_ID38239( var_0, var_1 )
{
    thread deployable_specialammo_placed_listener();
    self.deployable = 0;
    level notify( "dlc_vo_notify",  "ready_incendiaryrounds", self  );

    if ( !isdefined( level._ID38237 ) )
        level thread maps\mp\alien\_music_and_dialog::_ID24692( self );
}

tryuse_dpad_team_specialammo_comb( var_0, var_1 )
{
    _ID37086( var_1, "deployable_specialammo_comb" );
}

use_dpad_team_specialammo_comb( var_0, var_1 )
{
    thread deployable_combinedammo_placed_listener();
    self.deployable = 0;
    level notify( "dlc_vo_notify",  "ready_explosiverounds", self  );

    if ( !isdefined( level._ID38237 ) )
        level thread maps\mp\alien\_music_and_dialog::_ID24692( self );
}

deployable_combinedammo_placed_listener()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "new_deployable_box",  var_0  );
    _ID33258( var_0 );
    var_0 setcandamage( 0 );
    var_0 setcanradiusdamage( 0 );

    if ( var_0._ID34651 == 4 )
        var_0 thread team_combined_ammo_regen();
}

team_combined_ammo_regen()
{
    self endon( "death" );
    self endon( "ammo_regen_timeout" );
    var_0 = 65536.0;
    var_1 = 0.1;

    for (;;)
    {
        foreach ( var_3 in level.players )
        {
            if ( isalive( var_3 ) && distancesquared( self.origin, var_3.origin ) < var_0 )
                var_3 _ID36637::addratiomaxstockcombinedtoallweapons( var_1 );

            wait 5.0;
        }
    }
}

_ID33825( var_0, var_1 )
{
    thread _ID33826( var_0, var_1 );
}

_ID33826( var_0, var_1 )
{
    waittillframeend;
    maps\mp\alien\_unk1464::store_weapons_status();
    self._ID19508 = self getcurrentweapon();
    var_2 = "iw6_alienmk32_mp";

    switch ( var_1 )
    {
        case 0:
            var_2 = "iw6_alienmk32_mp";
            break;
        case 1:
            var_2 = "iw6_alienmk321_mp";
            break;
        case 2:
            var_2 = "iw6_alienmk322_mp";
            break;
        case 3:
            var_2 = "iw6_alienmk323_mp";
            break;
        case 4:
            var_2 = "iw6_alienmk324_mp";
            break;
    }

    maps\mp\_utility::_giveweapon( var_2 );
    wait 0.05;
    self switchtoweapon( var_2 );
    self disableweaponswitch();
}

use_dpad_war_machine( var_0, var_1 )
{
    var_2 = "iw6_alienmk32_mp";

    switch ( var_1 )
    {
        case 0:
            var_2 = "iw6_alienmk32_mp";
            break;
        case 1:
            var_2 = "iw6_alienmk321_mp";
            break;
        case 2:
            var_2 = "iw6_alienmk322_mp";
            break;
        case 3:
            var_2 = "iw6_alienmk323_mp";
            break;
        case 4:
            var_2 = "iw6_alienmk324_mp";
            break;
    }

    self notify( "dlc_vo_notify",  "online_mk32", self  );
    thread _ID35926( var_2 );

    if ( !isdefined( level._ID38237 ) )
        level thread maps\mp\alien\_music_and_dialog::_ID24699( self );
}

canceluse_dpad_war_machine( var_0, var_1 )
{
    self endon( "disconnect" );
    wait_to_cancel_dpad_weapon();
    var_2 = "iw6_alienmk32_mp";

    switch ( var_1 )
    {
        case 0:
            var_2 = "iw6_alienmk32_mp";
            break;
        case 1:
            var_2 = "iw6_alienmk321_mp";
            break;
        case 2:
            var_2 = "iw6_alienmk322_mp";
            break;
        case 3:
            var_2 = "iw6_alienmk323_mp";
            break;
        case 4:
            var_2 = "iw6_alienmk324_mp";
            break;
    }

    self takeweapon( var_2 );

    if ( !isdefined( level.drill_carrier ) || isdefined( level.drill_carrier ) && self != level.drill_carrier )
    {
        self switchtoweapon( self._ID19508 );
        self enableweaponswitch();
    }
}

_ID33805( var_0, var_1 )
{
    thread _ID33806( var_0, var_1 );
}

_ID33806( var_0, var_1 )
{
    waittillframeend;
    maps\mp\alien\_unk1464::store_weapons_status();
    self._ID19508 = self getcurrentweapon();
    var_2 = "iw6_alienminigun_mp";

    switch ( var_1 )
    {
        case 0:
            var_2 = "iw6_alienminigun_mp";
            break;
        case 1:
            var_2 = "iw6_alienminigun1_mp";
            break;
        case 2:
            var_2 = "iw6_alienminigun2_mp";
            break;
        case 3:
            var_2 = "iw6_alienminigun3_mp";
            break;
        case 4:
            var_2 = "iw6_alienminigun4_mp";
            break;
    }

    maps\mp\_utility::_giveweapon( var_2 );
    wait 0.05;
    self switchtoweapon( var_2 );
    self disableweaponswitch();
}

_ID34687( var_0, var_1 )
{
    var_2 = "iw6_alienminigun_mp";

    switch ( var_1 )
    {
        case 0:
            var_2 = "iw6_alienminigun_mp";
            break;
        case 1:
            var_2 = "iw6_alienminigun1_mp";
            break;
        case 2:
            var_2 = "iw6_alienminigun2_mp";
            break;
        case 3:
            var_2 = "iw6_alienminigun3_mp";
            break;
        case 4:
            var_2 = "iw6_alienminigun4_mp";
            break;
    }

    thread _ID35926( var_2 );
    level thread maps\mp\alien\_music_and_dialog::playvofordeathmachine( self );
}

canceluse_dpad_death_machine( var_0, var_1 )
{
    self endon( "disconnect" );
    wait_to_cancel_dpad_weapon();
    var_2 = "iw6_alienminigun_mp";

    switch ( var_1 )
    {
        case 0:
            var_2 = "iw6_alienminigun_mp";
            break;
        case 1:
            var_2 = "iw6_alienminigun1_mp";
            break;
        case 2:
            var_2 = "iw6_alienminigun2_mp";
            break;
        case 3:
            var_2 = "iw6_alienminigun3_mp";
            break;
        case 4:
            var_2 = "iw6_alienminigun4_mp";
            break;
    }

    self takeweapon( var_2 );

    if ( !isdefined( level.drill_carrier ) || isdefined( level.drill_carrier ) && self != level.drill_carrier )
    {
        self switchtoweapon( self._ID19508 );
        self enableweaponswitch();
    }
}

wait_to_cancel_dpad_weapon()
{
    self endon( "disconnect" );
    var_0 = gettime() + 1000;

    while ( !maps\mp\alien\_unk1464::has_special_weapon() || var_0 < gettime() )
        wait 0.05;
}

_ID35926( var_0 )
{
    self notify( "watchammo" );
    self endon( "watchammo" );
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_1 = self getammocount( var_0 );

    for (;;)
    {
        var_2 = self getammocount( var_0 );

        if ( var_2 == var_1 - 1 )
            self notify( "fired_ability_gun" );

        if ( var_2 == 0 )
        {
            self takeweapon( var_0 );
            self switchtoweapon( self._ID19508 );
            self enableweaponswitch();
            break;
        }

        wait 0.05;
    }
}

_ID33810( var_0, var_1 )
{
    if ( isdefined( level.alternate_trinity_weapon_try_use ) )
    {
        [[ level.alternate_trinity_weapon_try_use ]]( var_0, var_1 );
        return 1;
    }

    self._ID19508 = self getcurrentweapon();
    maps\mp\_utility::_giveweapon( "switchblade_laptop_mp" );
    self switchtoweaponimmediate( "switchblade_laptop_mp" );
}

_ID34691( var_0, var_1 )
{
    if ( isdefined( level.alternate_trinity_weapon_use ) )
    {
        [[ level.alternate_trinity_weapon_use ]]( var_0, var_1 );
        return 1;
    }

    if ( maps\mp\alien\_unk1464::_ID18437() )
        return;

    self.turn_off_class_skill_activation = 1;
    var_2 = 0;
    var_3 = "switchblade_rocket_mp";
    var_4 = "switchblade_baby_mp";
    var_5 = 14000;

    if ( var_1 == 0 )
        var_2 = 0;

    if ( var_1 == 1 )
        var_2 = 0;

    if ( var_1 == 2 )
        var_2 = 1;

    if ( var_1 == 3 )
    {
        var_2 = 2;
        var_5 = 16000;
        var_4 = "switchblade_babyfast_mp";
    }

    if ( var_1 == 4 )
    {
        var_2 = 4;
        var_5 = 18000;
        var_4 = "switchblade_babyfast_mp";
    }

    if ( isdefined( level._ID33846 ) )
        self [[ level._ID33846 ]]( var_1, var_2, var_3, var_5, var_4 );

    wait 0.1;
}

canceluse_dpad_predator( var_0, var_1 )
{
    if ( isdefined( level.alternate_trinity_weapon_cancel_use ) )
    {
        [[ level.alternate_trinity_weapon_cancel_use ]]( var_0, var_1 );
        return 1;
    }

    self.turn_off_class_skill_activation = undefined;
    self takeweapon( "switchblade_laptop_mp" );

    if ( isdefined( self._ID19508 ) )
        self switchtoweapon( self._ID19508 );

    return 1;
}

alien_begindeployableviamarker( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "cancel_deployable_via_marker" );
    level endon( "game_ended" );
    self waittill( "grenade_fire",  var_2, var_3  );

    if ( var_3 != "aliendeployable_crate_marker_mp" )
        return 0;

    self._ID20647 = var_2;
    _ID32390( var_2, var_3, var_1 );
    var_2.owner = self;
    var_2._ID36273 = var_3;
    var_2 thread maps\mp\alien\_deployablebox::_ID20648( var_0, var_1, maps\mp\alien\_deployablebox::box_setactive );
    return 1;
}

_ID32390( var_0, var_1, var_2 )
{
    var_0 playsoundtoplayer( level.boxsettings[var_2]._ID9664, self );

    if ( self hasweapon( var_1 ) )
    {
        self takeweapon( var_1 );
        self switchtoweapon( common_scripts\utility::_ID15114() );
    }
}

common_tryuse_actions()
{
    self._ID19508 = self getcurrentweapon();
    self giveweapon( "aliendeployable_crate_marker_mp" );
    self switchtoweapon( "aliendeployable_crate_marker_mp" );
    self.deployable = 1;
}

_ID14820( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in var_0 )
    {
        if ( var_3 _ID18410( self ) )
            var_1++;
    }

    return var_1;
}

_ID14272( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level._ID34099 )
    {
        if ( isalive( var_3 ) && level._ID28172[var_3._ID28174]._ID31889 == var_0 && ( isdefined( var_3._ID23036 ) && var_3._ID23036 == self || var_3.owner == self ) )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

_ID18410( var_0 )
{
    var_1 = 360000;

    if ( !isdefined( self ) || !isalive( self ) || isdefined( self._ID9631 ) )
        return 0;

    if ( distancesquared( self.origin, var_0.origin ) < var_1 )
        return 1;

    var_2 = var_0 maps\mp\alien\_unk1464::get_in_world_area();

    if ( isdefined( self.in_world_area ) )
        var_3 = self.in_world_area;
    else
        var_3 = maps\mp\alien\_unk1464::get_in_world_area();

    if ( var_3 == var_2 )
        return 1;

    return 0;
}

manage_sentry_count( var_0, var_1 )
{
    wait 2.0;
    var_2 = get_max_sentry_count( var_0, var_1 );

    switch ( var_1 )
    {
        case "sentry":
            var_3 = _ID14272( "sentry" );
            break;
        case "grenade":
            var_3 = _ID14272( "grenade" );
            break;
        case "minigun":
            var_3 = _ID14272( "minigun" );
            break;
        default:
            var_3 = _ID14272( "sentry" );
    }

    var_4 = var_3.size - var_2;

    if ( var_4 > 0 )
        _ID25892( var_3, var_4 );
}

_ID25892( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        var_3 = common_scripts\utility::_ID15016( self.origin, var_0 );
        var_0 = common_scripts\utility::array_remove( var_0, var_3 );
        var_3 notify( "death" );
    }
}

get_max_sentry_count( var_0, var_1 )
{
    if ( var_1 == "sentry" )
    {
        switch ( var_0 )
        {
            case 4:
                return 2;
            default:
                return 1;
        }
    }
    else
        return 1;
}

_ID37077( var_0 )
{
    if ( self attackbuttonpressed() )
        return 0;

    return _ID36714( var_0 );
}

_ID36714( var_0 )
{
    if ( isdefined( self.laststand ) && self.laststand )
        return 0;

    return 1;
}

_ID37076( var_0, var_1 )
{
    if ( maps\mp\alien\_unk1464::_ID18431() )
        return 0;

    if ( maps\mp\alien\_unk1464::has_special_weapon() )
        return 0;

    if ( isdefined( self.laststand ) && self.laststand )
        return 0;

    return 1;
}

_ID36713( var_0, var_1 )
{
    if ( self attackbuttonpressed() )
        return 0;

    return _ID37076( var_0, var_1 );
}

_ID37086( var_0, var_1 )
{
    self._ID32647 = var_0;
    common_tryuse_actions();
    thread maps\mp\alien\_deployablebox::_ID37087( var_0, var_1 );
}
