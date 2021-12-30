// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_dart_precache::_ID20445();
    maps\createart\mp_dart_art::_ID20445();
    maps\mp\mp_dart_fx::_ID20445();
    level thread maps\mp\mp_dart_events::_ID5917();
    level thread maps\mp\mp_dart_events::gas_station();
    thread maps\mp\mp_dart_scriptlights::_ID20445();
    level.introvisionset = "mpIntro_dart";
    maps\mp\_load::_ID20445();
    thread maps\mp\_fx::_ID13742();
    maps\mp\_compass::_ID29184( "compass_map_mp_dart" );

    if ( level._ID25139 )
        setdvar( "sm_sunShadowScale", "0.6" );
    else if ( level._ID36452 )
        setdvar( "sm_sunShadowScale", "0.7" );

    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 1.5, 10 );
    maps\mp\_utility::_ID28710( "r_diffuseColorScale", 1.48, 1.7325 );
    setdvar( "r_ssaofadedepth", 1089 );
    setdvar( "r_ssaorejectdepth", 1200 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level thread maps\mp\mp_dart_events::broken_walls();
    level thread maps\mp\mp_dart_events::_ID23981();
    level thread maps\mp\mp_dart_events::container_pathnode_watch();
    level thread _ID37490();
}

_ID37490()
{
    var_0 = getent( "clip128x128x8", "targetname" );
    var_1 = spawn( "script_model", ( 468, -776, 212 ) );
    var_1.angles = ( 0, 0, -90 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
}
