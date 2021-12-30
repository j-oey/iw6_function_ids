// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool
#using_animtree("animals_dlc");

_ID20445()
{
    var_0 = spawnstruct();
    var_0._ID18081 = "parakeets_dlc";
    var_0.rig_model = "pigeon_flock_rig";
    var_0._ID26291 = #animtree;
    var_0._ID26294 = 12;
    var_0.bird_model["idle"] = "parakeet";
    var_0.bird_model["fly"] = "parakeet_fly";
    var_0._ID5232 = #animtree;
    var_0._ID33122 = 600;
    var_0.accn = 150;
    var_0._ID27331 = 300;
    var_0.death_effect = loadfx( "fx/props/chicken_exp_white" );
    var_0.birdmodel_anims = [];
    var_0.rigmodel_anims = [];
    var_0.birdmodel_anims["idle"][0] = %pigeon_idle;
    var_0.birdmodel_anims["idleweight"][0] = 1;
    var_0.birdmodel_anims["idle"][1] = %pigeon_idle_twitch_1;
    var_0.birdmodel_anims["idleweight"][1] = 0.3;
    var_0.birdmodel_anims["flying"] = %pigeon_flying_cycle;
    var_0.rigmodel_anims["flying"] = %pigeon_flock_fly_loop;
    var_0.rigmodel_anims["takeoff_wire"] = %pigeon_flock_takeoff_wire;
    var_0.rigmodel_anims["land_wire"] = %pigeon_flock_land_wire;
    var_0.rigmodel_anims["takeoff_ground"] = %pigeon_flock_takeoff_ground;
    var_0.rigmodel_anims["land_ground"] = %pigeon_flock_land_ground;
    var_0.rigmodel_anims["takeoff_inpipe"] = %pigeon_flock_takeoff_inpipe;
    var_0.rigmodel_anims["land_inpipe"] = %pigeon_flock_land_inpipe;

    if ( !common_scripts\utility::_ID18787() )
    {
        var_0.birdmodel_anims["idlemp"][0] = "pigeon_idle";
        var_0.birdmodel_anims["idlemp"][1] = "pigeon_idle_twitch_1";
        var_0.birdmodel_anims["flyingmp"] = "pigeon_flying_cycle";
        var_0.rigmodel_anims["flyingmp"] = "pigeon_flock_fly_loop_mp";
        var_0.rigmodel_anims["takeoff_wiremp"] = "pigeon_flock_takeoff_wire_mp";
        var_0.rigmodel_anims["land_wiremp"] = "pigeon_flock_land_wire_mp";
        var_0.rigmodel_anims["takeoff_groundmp"] = "pigeon_flock_takeoff_ground_mp";
        var_0.rigmodel_anims["land_groundmp"] = "pigeon_flock_land_ground_mp";
        var_0.rigmodel_anims["takeoff_inpipemp"] = "pigeon_flock_takeoff_inpipe_mp";
        var_0.rigmodel_anims["land_inpipemp"] = "pigeon_flock_land_inpipe_mp";
    }

    var_0.sounds = [];
    var_0.sounds["takeoff"] = "anml_bird_startle_flyaway";
    precachemodel( var_0.rig_model );

    foreach ( var_2 in var_0.bird_model )
        precachemodel( var_2 );

    if ( !isdefined( level._interactive ) )
        level._interactive = [];

    level._interactive[var_0._ID18081] = var_0;
    thread maps\interactive_models\_birds_dlc::birds( var_0 );
}
