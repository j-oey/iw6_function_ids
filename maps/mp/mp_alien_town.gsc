// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    level.additional_boss_weapon = ::update_weapon_placement;
    level.introscreen_line_1 = &"MP_ALIEN_TOWN_INTRO_LINE_1";
    level._ID18313 = &"MP_ALIEN_TOWN_INTRO_LINE_2";
    level._ID18314 = &"MP_ALIEN_TOWN_INTRO_LINE_3";
    level.introscreen_line_4 = &"MP_ALIEN_TOWN_INTRO_LINE_4";
    level._ID18173 = ::_ID21729;
    level._ID37833 = ::_ID37721;
    level._ID37060 = ::_ID37718;
    level.alien_character_cac_table = "mp/alien/alien_cac_presets.csv";
    level._ID37496 = ::_ID37797;
    level._ID37061 = ::_ID37719;
    level._ID33846 = ::mp_alien_town_try_use_drone_hive;
    level._ID1644["alien_ark_gib"] = loadfx( "vfx/gameplay/alien/vfx_alien_ark_gib_01" );
    level.custom_alien_death_func = maps\mp\alien\_death::general_alien_custom_death;

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        level.adjust_spawnlocation_func = ::town_chaos_adjust_spawnlocation;

    maps\mp\alien\_unk1464::alien_mode_enable( "kill_resource", "wave", "airdrop", "lurker", "collectible", "loot", "pillage", "challenge", "outline", "scenes" );
    var_0 = [ "lodge", "city", "lake" ];
    maps\mp\alien\_unk1464::alien_area_init( var_0 );
    level.alien_challenge_table = "mp/alien/mp_alien_town_challenges.csv";
    level._ID17520 = 1;
    level._ID17519 = 1;
    level._ID17521 = 1;
    level.escape_cycle = 15;
    level._ID37911 = 10;
    level._ID37413 = 1.0;
    level._ID37408 = 1.0;
    level._ID37409 = 1.0;
    level._ID37410 = 1.0;
    level._ID37411 = 1.25;
    level.casual_spawn_multiplier = 1.0;
    level.casual_damage_scalar = 0.45;
    level.casual_health_scalar = 0.45;
    level.casual_reward_scalar = 1.0;
    level.casual_score_scalar = 0.5;
    maps\mp\mp_alien_town_precache::_ID20445();
    maps\createart\mp_alien_town_art::_ID20445();
    maps\mp\mp_alien_town_fx::_ID20445();
    setdvar( "r_reactiveMotionWindAmplitudeScale", 0.15 );
    level._ID37016 = 0;
    level._ID37020 = 0;
    level._ID37017 = 0;
    maps\mp\_load::_ID20445();
    maps\mp\_utility::_ID28710( "sm_sunShadowScale", 0.5, 1.0 );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 2.5, 9.01 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "woodland";
    var_1 = [];
    var_1[5] = "lodge_lung_3";
    var_1[9] = "city_lung_5";
    var_2 = [ 5, 9 ];
    maps\mp\gametypes\aliens::_ID28965( var_2 );
    maps\mp\gametypes\aliens::setup_blocker_hives( var_1 );
    maps\mp\gametypes\aliens::_ID29054( "crater_lung" );
    thread maps\mp\alien\_alien_class_skills_main::_ID20445();
    level._ID37059 = ::mp_alien_town_onspawnplayer_func;
    var_3 = [ "lake_lung_1", "lake_lung_2", "lake_lung_3", "lake_lung_4", "lake_lung_5", "lake_lung_6" ];
    maps\mp\alien\_unk1464::add_hive_dependencies( "crater_lung", var_3 );
    var_4 = [ "mini_lung" ];
    maps\mp\alien\_unk1464::add_hive_dependencies( "lodge_lung_1", var_4 );
    maps\mp\alien\_unk1464::add_hive_dependencies( "lodge_lung_2", var_4 );
    maps\mp\alien\_unk1464::add_hive_dependencies( "lodge_lung_3", var_4 );
    maps\mp\alien\_unk1464::add_hive_dependencies( "lodge_lung_4", var_4 );
    maps\mp\alien\_unk1464::add_hive_dependencies( "lodge_lung_5", var_4 );
    maps\mp\alien\_unk1464::add_hive_dependencies( "lodge_lung_6", var_4 );
    level._ID37428 = ::_ID38159;
    var_5 = 85000;
    var_6 = 95000;
    var_7 = 105000;
    var_8 = 240000;
    maps\mp\alien\_persistence::register_lb_escape_rank( [ 0, var_5, var_6, var_7, var_8 ] );
    level._ID29830 = ::_ID29830;
    register_encounters();
    restore_fog_setting();
    nuke_fog_setting();
    rescue_waypoint_setting();
    set_spawn_table();
    amb_quakes();
    level thread _ID38174();
    game["thermal_vision"] = "mp_alien_town_thermal";
    visionsetthermal( game["thermal_vision"] );
    game["thermal_vision_trinity"] = "mp_alien_thermal_trinity";
    level thread initspawnablecollision();
    level.skip_radius_damage_on_puddles = 1;
    level thread maps\mp\alien\_lasedstrike_alien::_ID17631();
    level thread maps\mp\alien\_switchblade_alien::_ID17631();
    common_scripts\utility::_ID3867( getentarray( "killstreak_attack_chopper", "targetname" ), ::attack_chopper_monitoruse );
}

register_encounters()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
    {
        maps\mp\gametypes\aliens::_ID37876( ::chaos_init, undefined, undefined, undefined, ::chaos_init, maps\mp\alien\_globallogic::blank );
        maps\mp\gametypes\aliens::_ID37876( maps\mp\alien\_chaos::chaos, undefined, undefined, undefined, maps\mp\alien\_chaos::chaos, maps\mp\alien\_globallogic::blank );
        return;
    }

    maps\mp\gametypes\aliens::_ID37876( ::_ID37164, undefined, undefined, undefined, ::_ID37164, maps\mp\alien\_globallogic::blank );
    maps\mp\gametypes\aliens::_ID37876( _ID36640::_ID37880, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37561, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( _ID36640::_ID37880, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37571, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( _ID36640::_ID37880, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37571, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( _ID36640::_ID37880, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37571, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( ::_ID36789, 1, 1, 1, _ID36640::_ID38041, ::_ID37571, _ID36640::_ID36779 );
    maps\mp\gametypes\aliens::_ID37876( _ID36640::_ID37880, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37564, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( _ID36640::_ID37880, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37564, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( _ID36640::_ID37880, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37564, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( ::_ID36789, 1, 1, 1, _ID36640::_ID38041, ::_ID37564, _ID36640::_ID36779 );
    maps\mp\gametypes\aliens::_ID37876( _ID36640::_ID37880, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37562, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( _ID36640::_ID37880, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37562, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( _ID36640::_ID37880, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37562, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( _ID36640::_ID37880, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37562, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( _ID36640::_ID37880, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37567, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( maps\mp\alien\_airdrop::_ID37181, undefined, undefined, undefined, ::_ID38038, ::_ID37568 );
}

initspawnablecollision()
{
    level waittill( "spawn_nondeterministic_entities" );
    var_0 = getent( "player512x512x8", "targetname" );
    var_1 = spawn( "script_model", ( -5332.5, -4394, 774.5 ) );
    var_1.angles = ( 90, 274, 7 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
}

_ID37164()
{
    maps\mp\alien\_drill::_ID17725();
    _ID36640::_ID37474();
    maps\mp\alien\_airdrop::_ID37467();
    maps\mp\alien\_unk1443::_ID37466( [ "hive", "escape", "relics" ] );
    maps\mp\alien\_unk1443::_ID37465( [ "challenge", "drill", "team", "team_blocker", "personal", "personal_blocker", "escape" ] );
}

_ID38159()
{
    var_0 = [];
    var_0["ALIEN_COLLECTIBLES_PICKUP_MAUL"] = &"ALIEN_COLLECTIBLES_PICKUP_MAUL";
    var_0["ALIEN_COLLECTIBLES_PICKUP_AK12"] = &"ALIEN_COLLECTIBLES_PICKUP_AK12";
    var_0["ALIEN_COLLECTIBLES_PICKUP_M27"] = &"ALIEN_COLLECTIBLES_PICKUP_M27";
    var_0["ALIEN_COLLECTIBLES_PICKUP_PROPANE_TANK"] = &"ALIEN_COLLECTIBLES_PICKUP_PROPANE_TANK";
    var_0["ALIEN_COLLECTIBLES_PICKUP_MK32"] = &"ALIEN_COLLECTIBLES_PICKUP_MK32";
    var_0["ALIEN_COLLECTIBLES_PICKUP_HONEYBADGER"] = &"ALIEN_COLLECTIBLES_PICKUP_HONEYBADGER";
    var_0["ALIEN_COLLECTIBLES_PICKUP_VKS"] = &"ALIEN_COLLECTIBLES_PICKUP_VKS";
    var_0["ALIEN_COLLECTIBLES_PICKUP_FP6"] = &"ALIEN_COLLECTIBLES_PICKUP_FP6";
    var_0["ALIEN_COLLECTIBLES_PICKUP_KRISS"] = &"ALIEN_COLLECTIBLES_PICKUP_KRISS";
    var_0["ALIEN_COLLECTIBLES_PICKUP_MICROTAR"] = &"ALIEN_COLLECTIBLES_PICKUP_MICROTAR";
    var_0["ALIEN_COLLECTIBLES_PICKUP_P226"] = &"ALIEN_COLLECTIBLES_PICKUP_P226";
    var_0["ALIEN_COLLECTIBLES_PICKUP_L115A3"] = &"ALIEN_COLLECTIBLES_PICKUP_L115A3";
    var_0["ALIEN_COLLECTIBLES_PICKUP_SC2010"] = &"ALIEN_COLLECTIBLES_PICKUP_SC2010";
    var_0["ALIEN_COLLECTIBLES_PICKUP_KAC"] = &"ALIEN_COLLECTIBLES_PICKUP_KAC";
    var_0["ALIEN_COLLECTIBLES_PICKUP_IMBEL"] = &"ALIEN_COLLECTIBLES_PICKUP_IMBEL";
    var_0["ALIEN_COLLECTIBLES_PICKUP_MTS255"] = &"ALIEN_COLLECTIBLES_PICKUP_MTS255";
    var_0["ALIEN_COLLECTIBLES_PICKUP_PANZERFAUST"] = &"ALIEN_COLLECTIBLES_PICKUP_PANZERFAUST";
    var_0["ALIEN_COLLECTIBLES_PICKUP_CBJMS"] = &"ALIEN_COLLECTIBLES_PICKUP_CBJMS";
    var_0["ALIEN_COLLECTIBLES_PICKUP_PP19"] = &"ALIEN_COLLECTIBLES_PICKUP_PP19";
    var_0["ALIEN_COLLECTIBLES_PICKUP_VEPR"] = &"ALIEN_COLLECTIBLES_PICKUP_VEPR";
    var_0["ALIEN_COLLECTIBLES_PICKUP_BREN"] = &"ALIEN_COLLECTIBLES_PICKUP_BREN";
    var_0["ALIEN_COLLECTIBLES_PICKUP_RGM"] = &"ALIEN_COLLECTIBLES_PICKUP_RGM";
    var_0["ALIEN_COLLECTIBLES_PICKUP_G28"] = &"ALIEN_COLLECTIBLES_PICKUP_G28";
    return var_0;
}

rescue_waypoint_setting()
{
    var_0 = getent( "escape_zone", "targetname" );
    var_1 = var_0.origin;
    level.rescue_waypoint_locs = [];
    level.rescue_waypoint_locs[0] = ( -3152, 1356, 610 );
    level.rescue_waypoint_locs[1] = ( -5081, -2715, 522 );
    level.rescue_waypoint_locs[2] = ( -1105, -1760, 831 );
    level.rescue_waypoint_locs[3] = var_1;
    level.rescue_waypoint_locs[4] = var_1;
}

restore_fog_setting()
{
    var_0 = spawnstruct();
    var_0._ID16448 = 1;
    var_0.hdrsuncolorintensity = 1;
    var_0._ID31431 = 0;
    var_0._ID15988 = 2048;
    var_0._ID25621 = 0.206;
    var_0._ID15769 = 0.255;
    var_0.blue = 0.317;
    var_0._ID20751 = 0.5;
    var_0.transitiontime = 0;
    var_0._ID32077 = 1;
    var_0._ID32084 = 0.791;
    var_0._ID32078 = 0.435;
    var_0._ID32064 = 0.331;
    var_0._ID32067 = ( -0.893, 0.273, 0.35 );
    var_0._ID32062 = 8;
    var_0._ID32070 = 64;
    var_0._ID22137 = 0.06;
    var_0._ID30138 = 1.0;
    var_0._ID30140 = 30;
    var_0._ID30139 = 67;
    level.restore_fog_setting = var_0;
}

nuke_fog_setting()
{
    var_0 = spawnstruct();

    if ( maps\mp\_utility::_ID18422() )
    {
        var_0._ID31431 = 0;
        var_0._ID15988 = 2048;
        var_0._ID25621 = 0.498;
        var_0._ID15769 = 0.343;
        var_0.blue = 0.192;
        var_0._ID16448 = 1.25;
        var_0._ID20751 = 0.5;
        var_0.transitiontime = 0;
        var_0._ID32077 = 1;
        var_0._ID32084 = 0.791;
        var_0._ID32078 = 0.435;
        var_0._ID32064 = 0.331;
        var_0.hdrsuncolorintensity = 1.25;
        var_0._ID32067 = ( -0.893, 0.273, 0.35 );
        var_0._ID32062 = 0;
        var_0._ID32070 = 160;
        var_0._ID22137 = 0.01;
        var_0._ID30138 = 0.9;
        var_0._ID30140 = 30;
        var_0._ID30139 = 71;
    }
    else
    {
        var_0._ID31431 = 0;
        var_0._ID15988 = 2048;
        var_0._ID25621 = 0.498;
        var_0._ID15769 = 0.343;
        var_0.blue = 0.192;
        var_0._ID20751 = 0.5;
        var_0.transitiontime = 0;
        var_0._ID32077 = 1;
        var_0._ID32084 = 0.791;
        var_0._ID32078 = 0.435;
        var_0._ID32064 = 0.331;
        var_0._ID32067 = ( -0.893, 0.273, 0.35 );
        var_0._ID32062 = 0;
        var_0._ID32070 = 160;
        var_0._ID22137 = 0.01;
        var_0._ID30138 = 0.9;
        var_0._ID30140 = 30;
        var_0._ID30139 = 71;
        var_0._ID16449 = "alien_nuke_HDR";
    }

    level.nuke_fog_setting = var_0;
}

amb_quakes()
{
    level._ID25230 = getentarray( "quake_trig", "targetname" );

    foreach ( var_1 in level._ID25230 )
        var_1 thread _ID26993();
}

_ID26993()
{
    level endon( "game_ended" );
    wait 5;
    self.movables = [];
    self._ID13765 = [];

    if ( isdefined( self.target ) )
    {
        var_0 = getentarray( self.target, "targetname" );

        foreach ( var_2 in var_0 )
        {
            if ( !isdefined( var_2.script_noteworthy ) )
                continue;

            if ( var_2.script_noteworthy == "moveable" )
                self.movables[self.movables.size] = var_2;

            if ( var_2.script_noteworthy == "fx" )
                self._ID13765[self._ID13765.size] = var_2;
        }
    }

    var_4 = self.radius;
    var_5 = self._ID27783;
    var_6 = self.origin;
    var_7 = 1;

    while ( var_7 )
    {
        foreach ( var_9 in level.players )
        {
            if ( isalive( var_9 ) && var_9 istouching( self ) )
            {
                var_9 playsound( "elm_quake_rumble" );
                wait 0.25;
                earthquake( 0.3, 3, var_6, var_5 );
                physicsjitter( var_6, var_5, var_4, 4.0, 6.0 );
                var_9 playrumbleonentity( "heavy_3s" );

                foreach ( var_11 in self.movables )
                    thread _ID25223( var_11 );

                var_7--;
                wait(randomintrange( 20, 30 ));
                break;
            }
        }

        wait 1;
    }
}

_ID25223( var_0 )
{
    self notify( "moving" );
    self endon( "moving" );
    var_1 = common_scripts\utility::_ID15384( var_0.target, "targetname" );
    var_2 = var_0.angles;
    var_3 = var_1.angles;
    var_4 = 5;
    var_5 = 0.8;

    for ( var_6 = 0; var_6 < var_4; var_6++ )
    {
        var_7 = _ID3362( var_2, var_3, 1 - var_6 / var_4 );
        var_8 = var_5 * ( var_6 + 1 ) / var_4;
        var_0 rotateto( var_7, var_8 );
        wait(var_8);
        var_0 rotateto( var_2, var_8 );
        wait(var_8);
    }
}

_ID3362( var_0, var_1, var_2 )
{
    var_2 *= var_2;
    var_3 = var_0[0] + ( var_1[0] - var_0[0] ) * var_2;
    var_4 = var_0[1] + ( var_1[1] - var_0[1] ) * var_2;
    var_5 = var_0[2] + ( var_1[2] - var_0[2] ) * var_2;
    return ( var_3, var_4, var_5 );
}

_ID21729()
{
    wait 2;
    var_0 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_0 thread maps\mp\alien\_music_and_dialog::play_pilot_vo( "so_alien_plt_introlastsquad" );
    level waittill( "introscreen_over" );
    var_0 maps\mp\_utility::_ID9519( 0.067, maps\mp\alien\_music_and_dialog::play_pilot_vo, "so_alien_plt_introunearthed" );
    var_0 maps\mp\_utility::_ID9519( 4.667, maps\mp\alien\_music_and_dialog::play_pilot_vo, "so_alien_plt_introdrill" );
    var_0 maps\mp\_utility::_ID9519( 15.767, maps\mp\alien\_music_and_dialog::play_pilot_vo, "so_alien_goodluck" );
    level maps\mp\_utility::_ID9519( 17.5, maps\mp\alien\_music_and_dialog::playvoforintro );
    wait 20;
    var_0 delete();
}

_ID29830()
{
    if ( level.cycle_count + 1 == 14 )
        return 0;

    if ( common_scripts\utility::flag_exist( "hives_cleared" ) && common_scripts\utility::_ID13177( "hives_cleared" ) )
        return 0;

    return !isdefined( level._ID5372[level.cycle_count + 1] );
}

_ID37721()
{
    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1._ID9387 ) )
            var_1 switchtoweapon( var_1._ID9387 );
    }
}

_ID37718()
{
    level _ID37720();
    level _ID36715();
}

_ID37720()
{
    var_0 = 100;
    var_1 = common_scripts\utility::_ID15386( "pillage_area", "targetname" );

    foreach ( var_8, var_3 in var_1 )
    {
        var_4 = common_scripts\utility::_ID15386( var_3.target, "targetname" );

        foreach ( var_6 in var_4 )
        {
            if ( distancesquared( var_6.origin, ( -3771, 1288, 830 ) ) <= var_0 )
            {
                var_6.origin = var_6.origin + ( 0, 15, -4 );
                return;
            }
        }
    }
}

_ID36715()
{
    _ID37943( "city_lung_4", ( -4285.85, -3098.1, 550.75 ), ( 2.87763, 77.0197, -2.07208 ) );
    _ID37943( "lake_lung_1", ( -3286.2, 699.453, 671.517 ), ( 356.167, 249.913, 1.77588 ) );
    _ID37943( "lake_lung_2", ( -1620.41, 1558.15, 758 ), ( 0, 161.813, 0 ) );
    _ID37943( "lake_lung_3", ( -3542.69, 2058.54, 570.984 ), ( 0.647456, 186.237, -1.42968 ) );
    _ID37943( "lake_lung_4", ( -2977.48, 1790.44, 565.36 ), ( 358.167, 184.775, -5.04523 ) );
    _ID37943( "lake_lung_6", ( -2769.68, 3698.48, 419.95 ), ( 359.953, 22.833, -10.9619 ) );
    _ID37943( "crater_lung", ( -4375.36, 3138.18, 285.152 ), ( 356.676, 249.752, 12.7989 ) );
}

_ID37943( var_0, var_1, var_2 )
{
    var_3 = getent( var_0, "target" );

    if ( isdefined( var_3 ) )
    {
        var_3.origin = var_1;
        var_3.angles = var_2;
    }
}

_ID38174()
{
    while ( !isdefined( level.electric_fences ) )
        wait 0.05;

    wait 5;

    foreach ( var_1 in level.electric_fences )
    {
        var_2 = var_1._ID14209.target;
        var_3 = strtok( var_1._ID14209.target, "_" );

        if ( var_3.size > 0 )
        {
            foreach ( var_5 in var_3 )
            {
                if ( issubstr( var_5, "auto" ) )
                    var_2 = var_5;
            }
        }

        if ( isdefined( var_1._ID14209.target ) && var_2 == "auto92" )
            var_1._ID29717.origin = var_1._ID29717.origin + ( 0, 0, 30 );

        if ( isdefined( var_1._ID14209.target ) && var_2 == "auto3" )
        {
            var_1._ID29717.origin = var_1._ID29717.origin + ( 102, 64, 30 );
            var_1._ID29712 = 800;
        }
    }
}

_ID37797()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
    {
        chaos_player_initial_spawn_loc_override();
        return;
    }

    var_0 = ( -4297, 3215, 303 );
    var_1 = ( 0, -6, 0 );

    if ( common_scripts\utility::_ID13177( "nuke_countdown" ) )
    {
        self._ID13535 = var_0;
        self.forcespawnangles = var_1;
    }
}

_ID38038()
{

}

chaos_player_initial_spawn_loc_override()
{
    var_0 = [];
    var_1 = [];

    switch ( maps\mp\alien\_unk1464::get_chaos_area() )
    {
        case "lodge":
            var_0 = [ ( 410, -1084, 708.838 ), ( 559, -1239, 705.007 ), ( 753, -1115, 709.901 ), ( 532, -930, 703.947 ) ];
            var_1 = [ ( 0, 210, 0 ), ( 0, 210, 0 ), ( 0, 345, 0 ), ( 0, 345, 0 ) ];
            break;
        case "city":
            var_0 = [ ( -4449, -2801, 535.798 ), ( -4496, -3085, 539.619 ), ( -4300, -3088, 549.954 ), ( -4209, -3326, 552.298 ) ];
            var_1 = [ ( 0, 210, 0 ), ( 0, 210, 0 ), ( 0, 345, 0 ), ( 0, 345, 0 ) ];
            break;
        case "cabin":
            var_0 = [ ( -2105, 2215, 580 ), ( -2029, 2103, 579 ), ( -3462, 1786, 573 ), ( -3451, 1892, 565 ) ];
            var_1 = [ ( 0, 210, 0 ), ( 0, 210, 0 ), ( 0, 345, 0 ), ( 0, 345, 0 ) ];
            break;
    }

    self._ID13535 = var_0[level.players.size];
    self.forcespawnangles = var_1[level.players.size];
}

mp_alien_town_try_use_drone_hive( var_0, var_1, var_2, var_3, var_4 )
{
    maps\mp\alien\_switchblade_alien::_ID33846( var_0, var_1, var_2, var_3, var_4 );
}

remove_upon_escape_sequence()
{
    level waittill( "all_players_using_nuke" );
    self delete();
}

attack_chopper_monitoruse()
{
    level endon( "game_ended" );
    level endon( "all_players_using_nuke" );
    thread remove_upon_escape_sequence();
    self endon( "death" );
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( &"ALIEN_COLLECTIBLES_ACTIVATE_ATTACK_CHOPPER" );
    self makeusable();

    while ( !isdefined( level.players ) || level.players.size < 1 )
        wait 0.05;

    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        level._ID7220 = 3000;
        level._ID7240 = 4;
    }
    else
    {
        level._ID7220 = 6000;
        level._ID7240 = 6;
    }

    wait 0.05;

    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
        maps\mp\alien\_outline_proto::add_to_outline_watch_list( self, 1000 );

    level.attack_chopper_pot = 0;
    level.attack_chopper_reward_pool = [];

    for (;;)
    {
        self waittill( "trigger",  var_0  );

        if ( !isplayer( var_0 ) )
        {
            wait 0.05;
            continue;
        }

        if ( level.attack_chopper_pot >= level._ID7220 )
        {
            wait 0.05;
            continue;
        }

        if ( !chopper_active() )
        {
            if ( var_0 can_purchase_chopper() )
            {
                var_0 maps\mp\alien\_persistence::_ID32387( 1000, 0, "trap" );
                level.attack_chopper_pot = level.attack_chopper_pot + 1000;
                level.attack_chopper_reward_pool[level.attack_chopper_reward_pool.size] = var_0;

                if ( level.attack_chopper_pot >= level._ID7220 )
                {
                    level.attack_chopper_pot = 0;
                    level thread maps\mp\alien\_airdrop::call_in_attack_heli( level._ID7240, level.attack_chopper_reward_pool );
                    level thread maps\mp\alien\_music_and_dialog::_ID24660( var_0 );
                    level.attack_chopper_reward_pool = [];
                    thread maps\mp\_utility::_ID32672( "attack_chopper_enroute", var_0, var_0.team );
                    self sethintstring( "" );

                    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
                        maps\mp\alien\_outline_proto::_ID25902( self );

                    while ( chopper_active() )
                        wait 1;

                    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
                        maps\mp\alien\_outline_proto::add_to_outline_watch_list( self, 1000 );

                    self sethintstring( &"ALIEN_COLLECTIBLES_ACTIVATE_ATTACK_CHOPPER" );
                }
                else
                {
                    if ( maps\mp\alien\_unk1464::_ID18745() )
                        var_0 thread maps\mp\gametypes\_hud_message::_ID24474( "attack_chopper_pot_solo", var_0, level.attack_chopper_pot );
                    else
                        thread maps\mp\_utility::_ID32672( "attack_chopper_pot", var_0, var_0.team, level.attack_chopper_pot );

                    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
                        iprintlnbold( "$" + level.attack_chopper_pot + " / $" + level._ID7220 );

                    self makeunusable();
                    self sethintstring( "" );
                    wait 0.5;
                    self makeusable();
                    self sethintstring( &"ALIEN_COLLECTIBLES_ACTIVATE_ATTACK_CHOPPER" );
                }
            }
            else
                var_0 maps\mp\_utility::setlowermessage( "no_money", &"ALIEN_COLLECTIBLES_NO_MONEY", 3 );

            continue;
        }

        if ( isdefined( level._ID17030 ) )
            var_0 maps\mp\_utility::setlowermessage( "busy", &"ALIEN_COLLECTIBLES_ATTACK_CHOPPER_ACTIVE", 3 );
    }
}

can_purchase_chopper()
{
    return maps\mp\alien\_persistence::player_has_enough_currency( 1000 );
}

chopper_active()
{
    return isdefined( level._ID4063 ) || isdefined( level._ID17030 );
}

_ID36789()
{
    level endon( "game_ended" );
    var_0 = _ID36640::_ID37937( 1 );
    var_1 = var_0[0];
    level._ID37166 = var_1.target;
    var_2 = _ID36640::_ID37029( var_1 );
    var_1.attackable_ent = var_2;
    level.current_blocker_hive = var_1;
    level thread maps\mp\alien\_spawnlogic::_ID37163( "blocker_hive_heli_inbound" );
    _ID37840( var_2 );
    _ID37423( var_2, var_1 );
    var_2 waittill( "death" );
    maps\mp\alien\_spawn_director::_ID11539();
    level._ID37166 = undefined;
    _ID36640::_ID36790( var_2, var_1 );
    _ID36640::give_players_rewards( 1, _ID36640::get_blocker_hive_score_component_name_list );
}

_ID37840( var_0 )
{
    wait 20;
    var_0 maps\mp\alien\_music_and_dialog::_ID24678();
    level thread maps\mp\alien\_airdrop::inbound_chopper_text();
    setomnvar( "ui_alien_boss_progression", 0 );
    setomnvar( "ui_alien_chopper_state", 3 );
    wait(max( 5, 30 ));
}

_ID37423( var_0, var_1 )
{
    thread maps\mp\alien\_airdrop::call_in_hive_heli( var_0 );
    wait 1;

    if ( isdefined( level._ID17030 ) )
    {
        if ( level._ID17030 maps\mp\alien\_unk1464::ent_flag_exist( "assault_ready" ) && !level._ID17030 maps\mp\alien\_unk1464::ent_flag( "assault_ready" ) )
            level._ID17030 maps\mp\alien\_unk1464::ent_flag_wait( "assault_ready" );

        level notify( "blocker_hive_heli_inbound" );
    }

    var_0 show();
    var_0 setcandamage( 1 );
    var_0 thread maps\mp\alien\_hud::blocker_hive_hp_bar();
    var_0 thread _ID36640::monitor_attackable_ent_damage( var_1 );
    var_0 thread maps\mp\alien\_music_and_dialog::_ID24686();
    var_1 _ID36640::_ID17038();
    var_1 thread _ID36640::_ID28422( "waypoint_alien_blocker", 7000, 20, 20 );
    level maps\mp\alien\_challenge_function::show_barrier_hive_intel();
    level.current_hive_name = var_1.target;
    level.blocker_hive_active = 1;
    maps\mp\alien\_unk1443::_ID37894();
    thread _ID36640::_ID35886( 0.1, 0.4 );
}

_ID37561()
{

}

_ID37571()
{

}

_ID37564()
{

}

_ID37562()
{

}

_ID37567()
{

}

_ID37568()
{

}

_ID37719()
{
    level.pillageinfo = spawnstruct();
    level.pillageinfo.alienattachment_model = "weapon_alien_muzzlebreak";
    level.pillageinfo._ID37088 = 1000;
    level.pillageinfo._ID37691 = "pb_money_stack_01";
    level.pillageinfo._ID36748 = "has_spotter_scope";
    level.pillageinfo._ID37665 = "mil_ammo_case_1_open";
    level.pillageinfo._ID37220 = "mil_emergency_flare_mp";
    level.pillageinfo._ID36975 = "weapon_baseweapon_clip";
    level.pillageinfo._ID38047 = "weapon_soflam";
    level.pillageinfo._ID37610 = "weapon_knife_iw6";
    level.pillageinfo._ID38164 = "mp_trophy_system_folded_iw6";
    level.pillageinfo._ID38182 = 1;
    level.pillageinfo._ID37133 = 32;
    level.pillageinfo._ID37138 = 20;
    level.pillageinfo._ID37134 = 20;
    level.pillageinfo._ID37135 = 15;
    level.pillageinfo._ID37139 = 5;
    level.pillageinfo._ID37140 = 5;
    level.pillageinfo._ID37136 = 3;
    level.pillageinfo._ID37668 = 35;
    level.pillageinfo._ID37670 = 15;
    level.pillageinfo._ID37673 = 15;
    level.pillageinfo._ID37669 = 10;
    level.pillageinfo._ID37675 = 10;
    level.pillageinfo._ID37671 = 5;
    level.pillageinfo._ID37674 = 5;
    level.pillageinfo._ID37676 = 5;
    level.pillageinfo._ID37399 = 40;
    level.pillageinfo._ID37400 = 15;
    level.pillageinfo._ID37401 = 10;
    level.pillageinfo._ID37403 = 10;
    level.pillageinfo._ID37406 = 10;
    level.pillageinfo._ID37404 = 5;
    level.pillageinfo._ID37405 = 5;
    level.pillageinfo._ID37407 = 5;
    level._ID37006 = "mp/alien/crafting_items.csv";
    level._ID37012 = 0;
    level._ID37014 = 1;
    level._ID37013 = 2;
    level._ID37011 = 3;
    level._ID37652 = 3;
    level._ID37008 = "weapon_baseweapon_clip";
    level.pillageinfo._ID37003 = 0;
    level.pillageinfo._ID37007 = 0;
    level.pillageinfo._ID37004 = 0;
}

set_spawn_table()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
    {
        set_chaos_spawn_table();
        return;
    }

    if ( maps\mp\alien\_unk1464::_ID18426() )
        set_hardcore_extinction_spawn_table();
}

set_chaos_spawn_table()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        switch ( maps\mp\alien\_unk1464::get_chaos_area() )
        {
            case "lodge":
                level.alien_cycle_table = "mp/alien/chaos_spawn_town_lodge_sp.csv";
                break;
            case "city":
                level.alien_cycle_table = "mp/alien/chaos_spawn_town_city_sp.csv";
                break;
            case "cabin":
                level.alien_cycle_table = "mp/alien/chaos_spawn_town_cabin_sp.csv";
                break;
        }
    }
    else
    {
        switch ( maps\mp\alien\_unk1464::get_chaos_area() )
        {
            case "lodge":
                level.alien_cycle_table = "mp/alien/chaos_spawn_town_lodge.csv";
                break;
            case "city":
                level.alien_cycle_table = "mp/alien/chaos_spawn_town_city.csv";
                break;
            case "cabin":
                level.alien_cycle_table = "mp/alien/chaos_spawn_town_cabin.csv";
                break;
        }
    }
}

chaos_init()
{
    _ID36640::init_hive_locs();
    maps\mp\alien\_airdrop::init_fx();
    level thread armory_chaos_nondeterministic_entity_handler();
    level._ID25988[level._ID25988.size] = "mini_lung";
    maps\mp\alien\_chaos::_ID17631();
    register_egg_default_loc();
    set_player_count_multiplier();
    set_end_cam_position();
}

armory_chaos_nondeterministic_entity_handler()
{
    level endon( "game_ended" );
    var_0 = 5;
    wait(var_0);
    delete_intro_heli_clip();
    move_clip_brush_cabin_to_city();
    move_clip_brush_cabin_to_lake();
    move_clip_to_cliffside();
    move_clip_brush_cliff_exploit();
}

town_chaos_adjust_spawnlocation( var_0 )
{
    if ( var_0.origin == ( -5716, -2031, 524 ) )
    {
        var_0.origin = ( -6011.5, -1494.5, 415.5 );
        var_0.angles = ( 0, 0, 0 );
        var_0.script_noteworthy = "cabin_spawn_ground";
    }

    return var_0;
}

move_clip_to_cliffside()
{
    var_0 = getent( "player256x256x8", "targetname" );
    var_1 = spawn( "script_model", ( -6294, -1282, 558 ) );
    var_1.angles = ( 270, 68, 3 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
}

move_clip_brush_cliff_exploit()
{
    var_0 = getent( "player512x512x8", "targetname" );
    var_1 = spawn( "script_model", ( -4320, 2120, 572 ) );
    var_1.angles = ( 270, 5, 1.28 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
}

set_end_cam_position()
{
    var_0 = getentarray( "mp_global_intermission", "classname" );
    var_1 = common_scripts\utility::_ID14934( level.eggs_default_loc, var_0 );

    switch ( maps\mp\alien\_unk1464::get_chaos_area() )
    {
        case "lodge":
            var_1.origin = ( -3840, 1632, 1008 );
            var_1.angles = ( 25, 0, 0 );
            break;
        case "city":
            var_1.origin = ( -3840, 1632, 1008 );
            var_1.angles = ( 25, 0, 0 );
            break;
        case "cabin":
            var_1.origin = ( -3840, 1632, 1008 );
            var_1.angles = ( 25, 0, 0 );
            break;
    }
}

set_player_count_multiplier()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        level._ID36763 = 1;
    else
        level._ID36763 = 0.49;
}

register_egg_default_loc()
{
    switch ( maps\mp\alien\_unk1464::get_chaos_area() )
    {
        case "lodge":
            maps\mp\alien\_chaos::set_egg_default_loc( ( -2534, 1751, 421 ) );
            break;
        case "city":
            maps\mp\alien\_chaos::set_egg_default_loc( ( -2534, 1751, 421 ) );
            break;
        case "cabin":
            maps\mp\alien\_chaos::set_egg_default_loc( ( -2534, 1751, 421 ) );
            break;
    }
}

move_clip_brush_cabin_to_city()
{
    var_0 = getent( "player256x256x256", "targetname" );
    var_0.origin = ( -5374, -2662, 498 );
    var_0.angles = ( 0, 248, 0 );
}

move_clip_brush_cabin_to_lake()
{
    var_0 = getent( "player128x128x256", "targetname" );
    var_0.origin = ( -3448, 2256, 618 );
    var_0.angles = ( 270, 344, -8.36695 );
}

delete_intro_heli_clip()
{
    var_0 = getent( "helicoptercoll", "targetname" );
    var_0 delete();
}

set_hardcore_extinction_spawn_table()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        level.alien_cycle_table_hardcore = "mp/alien/cycle_spawn_town_hardcore_sp.csv";
    else
        level.alien_cycle_table_hardcore = "mp/alien/cycle_spawn_town_hardcore.csv";
}

mp_alien_town_onspawnplayer_func()
{
    if ( !isdefined( level.setskillsflag ) )
    {
        level.setskillsflag = 1;
        common_scripts\utility::flag_set( "give_player_abilities" );
    }

    thread maps\mp\alien\_alien_class_skills_main::assign_skills();
}

update_weapon_placement()
{
    var_0 = common_scripts\utility::_ID15386( "item", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2.script_noteworthy ) )
            continue;

        if ( var_2.script_noteworthy == "weapon_iw6_alienhoneybadger_mp" )
        {
            var_2.script_noteworthy = "weapon_iw6_alienak12_mp";
            var_2.origin = ( -1503.68, 1942.12, 598.9 );
            break;
        }
    }

    return undefined;
}
