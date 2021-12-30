// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    maps\mp\killstreaks\_killstreaks::_ID17970();
    level._ID19256 = [];
    level._ID19268 = [];
    level.killstreakweapons = [];
    thread maps\mp\killstreaks\_uav::_ID17631();
    thread maps\mp\killstreaks\_plane::_ID17631();
    thread maps\mp\killstreaks\_airdrop::_ID17631();
    thread maps\mp\killstreaks\_helicopter::_ID17631();
    thread maps\mp\killstreaks\_nuke::_ID17631();
    thread maps\mp\killstreaks\_a10::_ID17631();
    thread maps\mp\killstreaks\_portableaoegenerator::_ID17631();
    thread maps\mp\killstreaks\_ims::_ID17631();
    thread maps\mp\killstreaks\_perkstreaks::_ID17631();
    thread maps\mp\killstreaks\_juggernaut::_ID17631();
    thread maps\mp\killstreaks\_unk1523::_ID17631();
    thread maps\mp\killstreaks\_autosentry::_ID17631();
    thread maps\mp\killstreaks\_remotemissile::_ID17631();
    thread maps\mp\killstreaks\_deployablebox::_ID17631();
    thread maps\mp\killstreaks\_deployablebox_vest::_ID17631();
    thread maps\mp\killstreaks\_deployablebox_gun::_ID17631();
    thread maps\mp\killstreaks\_helisniper::_ID17631();
    thread maps\mp\killstreaks\_helicopter_pilot::_ID17631();
    thread maps\mp\killstreaks\_vanguard::_ID17631();
    thread maps\mp\killstreaks\_uplink::_ID17631();
    thread maps\mp\killstreaks\_dronehive::_ID17631();
    thread maps\mp\killstreaks\_jammer::_ID17631();
    thread maps\mp\killstreaks\_air_superiority::_ID17631();
    thread maps\mp\killstreaks\_odin::_ID17631();
    thread maps\mp\killstreaks\_unk1544::_ID17631();
    thread maps\mp\killstreaks\_unk1513::_ID17631();
    level._ID19276 = [];
    level._ID19276["sentry_minigun_mp"] = "sentry";
    level._ID19276["hind_bomb_mp"] = "helicopter";
    level._ID19276["hind_missile_mp"] = "helicopter";
    level._ID19276["cobra_20mm_mp"] = "helicopter";
    level._ID19276["nuke_mp"] = "nuke";
    level._ID19276["manned_littlebird_sniper_mp"] = "heli_sniper";
    level._ID19276["iw6_minigunjugg_mp"] = "airdrop_juggernaut";
    level._ID19276["iw6_p226jugg_mp"] = "airdrop_juggernaut";
    level._ID19276["mortar_shelljugg_mp"] = "airdrop_juggernaut";
    level._ID19276["iw6_riotshieldjugg_mp"] = "airdrop_juggernaut_recon";
    level._ID19276["iw6_magnumjugg_mp"] = "airdrop_juggernaut_recon";
    level._ID19276["smoke_grenadejugg_mp"] = "airdrop_juggernaut_recon";
    level._ID19276["iw6_knifeonlyjugg_mp"] = "airdrop_juggernaut_maniac";
    level._ID19276["throwingknifejugg_mp"] = "airdrop_juggernaut_maniac";
    level._ID19276["deployable_vest_marker_mp"] = "deployable_vest";
    level._ID19276["deployable_weapon_crate_marker_mp"] = "deployable_ammo";
    level._ID19276["heli_pilot_turret_mp"] = "heli_pilot";
    level._ID19276["guard_dog_mp"] = "guard_dog";
    level._ID19276["ims_projectile_mp"] = "ims";
    level._ID19276["ball_drone_gun_mp"] = "ball_drone_backup";
    level._ID19276["drone_hive_projectile_mp"] = "drone_hive";
    level._ID19276["switch_blade_child_mp"] = "drone_hive";
    level._ID19276["iw6_maaws_mp"] = "aa_launcher";
    level._ID19276["iw6_maawschild_mp"] = "aa_launcher";
    level._ID19276["iw6_maawshoming_mp"] = "aa_launcher";
    level._ID19276["killstreak_uplink_mp"] = "uplink";
    level._ID19276["odin_projectile_large_rod_mp"] = "odin_assault";
    level._ID19276["odin_projectile_small_rod_mp"] = "odin_assault";
    level._ID19276["iw6_gm6helisnipe_mp"] = "heli_sniper";
    level._ID19276["iw6_gm6helisnipe_mp_gm6scope"] = "heli_sniper";
    level._ID19276["aamissile_projectile_mp"] = "air_superiority";
    level._ID19276["airdrop_marker_mp"] = "airdrop_assault";
    level._ID19276["remote_tank_projectile_mp"] = "vanguard";
    level._ID19276["killstreak_vanguard_mp"] = "vanguard";
    level._ID19276["agent_mp"] = "agent";
    level._ID19276["agent_support_mp"] = "recon_agent";
    level._ID19276["iw6_axe_mp"] = "juggernaut_swamp_slasher";
    level._ID19276["venomxgun_mp"] = "venom_x_gun";
    level._ID19276["venomxproj_mp"] = "venom_x_projectile";
    level._ID19276["iw6_predatorcannon_mp"] = "juggernaut_predator";
    level._ID19276["iw6_predatorsuicide_mp"] = "juggernaut_predator";
    level._ID19276["volcano_rock_mp"] = "volcano";
    level._ID19276["ac130_105mm_mp"] = "ac130";
    level._ID19276["ac130_40mm_mp"] = "ac130";
    level._ID19276["ac130_25mm_mp"] = "ac130";
    level._ID19276["iw6_mariachimagnum_mp_akimbo"] = "juggernaut_death_mariachi";
    level._ID19276["harrier_20mm_mp"] = "harrier_airstrike";
    level._ID19276["artillery_mp"] = "harrier_airstrike";

    if ( isdefined( level.mapcustomkillstreakfunc ) )
        [[ level.mapcustomkillstreakfunc ]]();

    level._ID19263 = maps\mp\_utility::_ID15069( "scr_game_killstreakdelay", 8 );
    level thread maps\mp\killstreaks\_killstreaks::_ID22877();
}
