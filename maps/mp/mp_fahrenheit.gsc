// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_fahrenheit_precache::_ID20445();
    maps\createart\mp_fahrenheit_art::_ID20445();
    maps\mp\mp_fahrenheit_fx::_ID20445();
    _ID24833();
    maps\mp\_load::_ID20445();
    common_scripts\utility::_ID13189( "stop_dynamic_events" );
    level._ID25332 = [];
    level._ID25332 = getscriptablearray( "rain_scriptable", "targetname" );
    level._ID26767 = 0;
    level._ID26763 = 1;
    level._ID31877 = 0;
    level._ID31148 = 0.4;
    level._ID31149 = 0.7;
    var_0 = maps\mp\_utility::_ID15434() * 60;

    if ( var_0 <= 0 )
        var_0 = 600;

    level.assumed_match_length = var_0;
    maps\mp\_compass::_ID29184( "compass_map_mp_fahrenheit" );
    setdvar( "r_reactiveMotionWindAmplitudeScale", 0.5 );
    setdvar( "r_reactiveMotionWindFrequencyScale", 0.5 );

    if ( level._ID25139 || level._ID36452 )
        setdvar( "sm_sunShadowScale", "0.8" );

    maps\mp\_utility::_ID28710( "r_specularColorScale", 3, 9 );
    maps\mp\_utility::_ID28710( "r_diffuseColorScale", 1.6, 2.2 );
    setdvar( "r_ssaorejectdepth", 1500 );
    setdvar( "r_ssaofadedepth", 1200 );
    setdvar( "r_sky_fog_intensity", "1" );
    setdvar( "r_sky_fog_min_angle", "56.6766" );
    setdvar( "r_sky_fog_max_angle", "75" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    common_scripts\utility::_ID13189( "begin_storm" );
    level thread _ID23704();
    common_scripts\utility::_ID35582();

    if ( maps\mp\_utility::_ID18768() )
        compute_round_based_percentages( var_0 );

    level thread _ID30089( level.assumed_match_length, level._ID26767, level._ID26763 );
    level thread connect_watch();
    thread _ID29175();
    level thread _ID37490();
}

_ID37490()
{
    var_0 = getent( "clip128x128x8", "targetname" );
    var_1 = spawn( "script_model", ( -2352, -1938, 512 ) );
    var_1.angles = ( 0, 0, 0 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
    var_2 = getent( "clip32x32x256", "targetname" );
    var_3 = spawn( "script_model", ( 176, -2420, 848 ) );
    var_3.angles = ( 0, 0, 0 );
    var_3 clonebrushmodeltoscriptmodel( var_2 );
    var_4 = getent( "clip32x32x256", "targetname" );
    var_5 = spawn( "script_model", ( 176, -2452, 848 ) );
    var_5.angles = ( 0, 0, 0 );
    var_5 clonebrushmodeltoscriptmodel( var_4 );
    var_6 = getent( "clip32x32x256", "targetname" );
    var_7 = spawn( "script_model", ( 666, -1824, 868 ) );
    var_7.angles = ( 0, 0, 0 );
    var_7 clonebrushmodeltoscriptmodel( var_6 );
    var_8 = getent( "clip256x256x8", "targetname" );
    var_9 = spawn( "script_model", ( -1372, -3232, 784 ) );
    var_9.angles = ( 0, 0, 0 );
    var_9 clonebrushmodeltoscriptmodel( var_8 );
    var_10 = getent( "clip64x64x256", "targetname" );
    var_11 = spawn( "script_model", ( -1928, 624, 680 ) );
    var_11.angles = ( 0, 0, -90 );
    var_11 clonebrushmodeltoscriptmodel( var_10 );
    var_12 = getent( "clip256x256x8", "targetname" );
    var_13 = spawn( "script_model", ( -1808, 760, 648 ) );
    var_13.angles = ( 0, 0, 0 );
    var_13 clonebrushmodeltoscriptmodel( var_12 );
    var_14 = spawn( "trigger_radius", ( -1216, 80, 496 ), 0, 864, 110 );
    var_14.radius = 864;
    var_14.height = 110;
    var_14.angles = ( 0, 0, 0 );
    var_14.targetname = "gryphonDeath";
    var_15 = spawn( "trigger_radius", ( 576, -3104, 312 ), 0, 2240, 75 );
    var_15.radius = 2240;
    var_15.height = 75;
    var_15.angles = ( 0, 0, 0 );
    var_15.targetname = "gryphonDeath";
    var_16 = spawn( "trigger_radius", ( -1080, -4136, 520 ), 0, 176, 528 );
    var_16.radius = 176;
    var_16.height = 528;
    var_16.angles = ( 0, 0, 0 );
    var_16.targetname = "gryphonDeath";
    var_17 = spawn( "trigger_radius", ( -1184, -3808, 416 ), 0, 176, 96 );
    var_17.radius = 176;
    var_17.height = 96;
    var_17.angles = ( 0, 0, 0 );
    var_17.targetname = "gryphonDeath";
    var_18 = spawn( "trigger_radius", ( 448, -2144, 896 ), 0, 400, 128 );
    var_18.radius = 400;
    var_18.height = 128;
    var_18.angles = ( 0, 0, 0 );
    var_18.targetname = "antiFoliage";
    level thread _ID38291( var_18 );
    level thread maps\mp\_utility::_ID19279( ( -194, 198, 352 ), 700, 256 );
    level thread maps\mp\_utility::_ID19279( ( -2148, -340, 718 ), 96, 6 );
}

_ID38291( var_0 )
{
    level endon( "game_ended" );

    for (;;)
    {
        foreach ( var_2 in level.players )
        {
            wait 0.05;

            if ( !isdefined( var_2 ) )
                continue;

            if ( var_2 istouching( var_0 ) )
            {
                if ( isdefined( var_2._ID38281 ) && var_2._ID38281 )
                    continue;

                var_2 setignorefoliagesightingme( 1 );
                var_2._ID38281 = 1;
                continue;
            }

            if ( isdefined( var_2._ID38281 ) && var_2._ID38281 )
            {
                var_2 setignorefoliagesightingme( 0 );
                var_2._ID38281 = 0;
            }
        }

        wait 0.1;
    }
}

_ID24833()
{

}

_ID29175()
{
    if ( level._ID14086 == "horde" )
        return;

    var_0 = spawnstruct();
    var_0.name = "elevator";
    var_0._ID10745 = [];
    var_0._ID10745["floor1"] = [ "e_door_floor1_", "e_door_elevator_1_" ];
    var_0._ID10745["floor2"] = [ "e_door_floor2_", "e_door_elevator_2_" ];
    var_0._ID10745["elevator"] = [ "e_door_elevator_1_", "e_door_elevator_2_" ];
    var_0._ID10741 = 35;
    var_0._ID6359 = "elevator_button";
    var_0._ID33577 = "elevator_door_checker";
    maps\mp\_elevator::_ID17730( var_0 );
}

compute_round_based_percentages( var_0 )
{
    var_1 = maps\mp\_utility::getwatcheddvar( "roundlimit" );
    var_2 = maps\mp\_utility::getwatcheddvar( "winlimit" );

    if ( var_2 > 0 )
    {
        level.assumed_match_length = var_2 * var_0;

        if ( maps\mp\_utility::_ID18625() )
            var_3 = 0;
        else
            var_3 = max( game["roundsWon"]["allies"], game["roundsWon"]["axis"] );

        level._ID26767 = var_3 / var_2;
        level._ID26763 = ( var_3 + 1 ) / var_2;
        return;
    }

    if ( var_1 > 0 )
    {
        level.assumed_match_length = var_1 * var_0;
        level._ID26767 = game["roundsPlayed"] / var_1;
        level._ID26763 = ( game["roundsPlayed"] + 1 ) / var_1;
        return;
    }

    return;
}

_ID23704()
{
    level._ID23711 = getscriptablearray( "storm_plant", "targetname" );
    level waittill( "storm_stage_1" );
    _ID23706( "stage_1", 180, 6, 1 );
}

_ID23706( var_0, var_1, var_2, var_3 )
{
    var_4 = anglestoforward( ( 0, var_1, 0 ) );
    var_5 = anglestoright( ( 0, var_1, 0 ) );
    var_6 = undefined;
    var_7 = undefined;

    foreach ( var_9 in level._ID23711 )
    {
        var_10 = disttoline( var_9.origin, ( 0, 0, 0 ), var_5 );

        if ( lrtest( var_9.origin, ( 0, 0, 0 ), var_5 ) == 2 )
            var_10 *= -1;

        if ( !isdefined( var_6 ) || var_10 < var_6 )
            var_6 = var_10;

        if ( !isdefined( var_7 ) || var_10 > var_7 )
            var_7 = var_10;

        var_9._ID32812 = var_10;
    }

    foreach ( var_9 in level._ID23711 )
    {
        var_13 = ( var_9._ID32812 - var_6 ) / ( var_7 - var_6 );
        var_14 = var_2 * var_13;

        if ( isdefined( var_3 ) && var_3 > 0 )
            var_14 += randomfloatrange( 0, var_3 );

        level thread _ID23705( var_9, var_0, var_14 );
    }
}

_ID23705( var_0, var_1, var_2 )
{
    if ( isdefined( var_2 ) && var_2 > 0 )
        wait(var_2);

    var_0 setscriptablepartstate( "storm_plant", var_1 );
}

_ID25322( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( var_0 > 2 )
        var_0 = 0;

    if ( isdefined( level._ID25332 ) )
    {
        foreach ( var_2 in level._ID25332 )
            var_2 setscriptablepartstate( 0, var_0 );

        return;
    }
}

visiontest()
{
    wait 20;
    var_0 = 0;
    var_1 = 2;
    var_2 = -1;
    level._ID30126 = getent( "skydome", "targetname" );
    var_0 += 1;

    if ( var_0 >= var_1 )
        var_0 = 0;

    iprintlnbold( "CHANGING VISIONSETS to:" + var_0 );

    foreach ( var_4 in level.players )
        var_4 visionsetstage( int( min( 1, var_0 ) ), 3 );

    level._ID30126 rotatepitch( var_2 * 45, 3 );
    var_2 *= -1;
    _ID25322( 1 );
    wait 6;
}

_ID13976()
{
    var_0 = [];
    var_0 = getscriptablearray( "rain_scriptable", "targetname" );

    for (;;)
    {
        var_0[0] setscriptablepartstate( 0, 0 );
        wait 5;
        var_0[0] setscriptablepartstate( 0, 1 );
        wait 5;
        var_0[0] setscriptablepartstate( 0, 2 );
        wait 5;
        var_0[0] setscriptablepartstate( 0, 3 );
        wait 5;
    }
}

_ID30089( var_0, var_1, var_2 )
{
    level.volmods = [];

    if ( common_scripts\utility::_ID13177( "stop_dynamic_events" ) )
        return;

    level endon( "stop_dynamic_events" );
    var_3 = 0;
    var_4 = 10;
    maps\mp\_utility::gameflagwait( "prematch_done" );
    level._ID31877 = 0;
    var_5 = var_1;

    if ( var_1 < level._ID31148 )
    {
        foreach ( var_7 in level.players )
            var_7 visionsetstage( int( min( 1, level._ID31877 ) ), 0.1 );

        var_9 = level._ID31148 * var_0 - var_5 * var_0;
        wait(var_9);
        var_5 = level._ID31148;
    }

    if ( var_1 < level._ID31149 )
    {
        level notify( "storm_stage_1" );
        level._ID31877 = 1;
        common_scripts\utility::exploder( 1 );
        level thread storm_sound_stage( "storm_sound_stage_1" );
        level.rainemitent = spawn( "script_origin", ( 0, 0, 0 ) );
        storm_sounds_volmod( "scripted2", 0, 0 );
        wait 0.05;
        level.rainemitent playloopsound( "amb_fah_rain_light_loop" );
        storm_sounds_volmod( "scripted2", 1, 3 );
        var_10 = getscriptablearray( "sun_scriptable", "targetname" );

        foreach ( var_12 in var_10 )
            var_12 setscriptablepartstate( 0, "storm_stage_1" );

        foreach ( var_7 in level.players )
            var_7 visionsetstage( int( min( 1, level._ID31877 ) ), var_4 );

        wait(var_4);
        _ID25322( level._ID31877 );
        var_9 = level._ID31149 * var_0 - var_5 * var_0 + var_4;
        wait(var_9);
        var_5 = level._ID31149;
    }

    level notify( "storm_stage_2" );
    level._ID31877 = 2;
    common_scripts\utility::exploder( 1 );
    level thread storm_sound_stage( "storm_sound_stage_2" );
    level.heavyrainemitent = spawn( "script_origin", ( 0, 0, 0 ) );
    storm_sounds_volmod( "scripted3", 0, 0 );
    wait 0.05;
    level.heavyrainemitent playloopsound( "amb_fah_rain_heavy_loop" );
    storm_sounds_volmod( "scripted3", 1, 3 );
    wait 0.05;
    storm_sounds_volmod( "scripted2", 0, 3 );
    _ID25322( level._ID31877 );

    if ( var_1 >= level._ID31149 )
    {
        foreach ( var_7 in level.players )
            var_7 visionsetstage( int( min( 1, level._ID31877 ) ), 0.1 );

        return;
    }

    foreach ( var_7 in level.players )
        var_7 visionsetstage( int( min( 1, level._ID31877 ) ), var_4 );

    return;
}

storm_sound_stage( var_0 )
{
    var_1 = 0.9;
    var_2 = getentarray( var_0, "targetname" );

    foreach ( var_4 in var_2 )
    {
        var_5 = var_4.script_noteworthy;

        if ( isdefined( var_5 ) )
        {
            var_4 playloopsound( var_5 );
            jump loc_C38
        }

        wait(var_1);
    }
}

storm_sounds_volmod( var_0, var_1, var_2 )
{
    level.volmods[var_0] = var_1;

    foreach ( var_4 in level.players )
        var_4 setvolmod( var_0, var_1, var_2 );
}

_ID26737( var_0, var_1, var_2 )
{
    var_3 = 0;
    var_4 = -70;
    var_0 = min( 1, var_0 / level._ID31148 );
    var_1 = min( 1, var_1 / level._ID31148 );
    level._ID30126 rotatepitch( 180, 0.1 );
    wait 0.1;
    level._ID30126 rotatepitch( var_0 * var_4, 0.1 );
    maps\mp\_utility::gameflagwait( "prematch_done" );
    level._ID30126 rotatepitch( ( var_1 - var_0 ) * var_4, max( 0.1, ( var_1 - var_0 ) * var_2 ) );
}

connect_watch()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );

        if ( isdefined( level._ID31877 ) )
            var_0 visionsetstage( int( min( 1, level._ID31877 ) ), 0.1 );

        foreach ( var_3, var_2 in level.volmods )
            var_0 setvolmod( var_3, var_2 );
    }
}

areaparallelpipid( var_0, var_1, var_2 )
{
    return var_0[0] * var_1[1] - var_0[1] * var_1[0] + var_1[0] * var_2[1] - var_2[0] * var_1[1] + var_2[0] * var_0[1] - var_0[0] * var_2[1];
}

areatriange( var_0, var_1, var_2 )
{
    return areaparallelpipid( var_0, var_1, var_2 ) * 0.5;
}

lrtest( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 0.0;

    var_4 = areaparallelpipid( var_1, var_2, var_0 );

    if ( var_4 > var_3 )
        return 1;

    if ( var_4 < var_3 * -1 )
        return 2;

    return 3;
}

project( var_0, var_1 )
{
    var_2 = vectordot( var_0, var_1 ) / lengthsquared( var_1 );
    return [ var_1 * var_2, var_2 ];
}

_ID25059( var_0, var_1, var_2 )
{
    var_0 -= var_1;
    var_3 = project( var_0, var_2 - var_1 );
    var_0 = var_3[0];
    var_4 = var_3[1];
    var_clear_1
    var_0 += var_1;
    return [ var_0, var_4 ];
}

_ID25060( var_0, var_1, var_2 )
{
    var_3 = _ID25059( var_0, var_1, var_2 );
    var_0 = var_3[0];
    var_4 = var_3[1];
    var_clear_1

    if ( var_4 < 0.0 )
        var_0 = var_1;
    else if ( var_4 > 1.0 )
        var_0 = var_2;

    return [ var_0, var_4 ];
}

disttoline( var_0, var_1, var_2 )
{
    var_3 = _ID25059( var_0, var_1, var_2 );
    var_4 = var_3[0];
    var_5 = var_3[1];
    var_clear_2
    return distance( var_4, var_0 );
}
