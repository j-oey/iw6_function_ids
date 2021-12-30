// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_strikezone_precache::_ID20445();
    maps\createart\mp_strikezone_art::_ID20445();
    maps\mp\mp_strikezone_fx::_ID20445();
    maps\mp\_teleport::_ID20445();
    maps\mp\_teleport::_ID32779( "start", "compass_map_mp_strikezone" );
    maps\mp\_teleport::_ID32779( "destroyed", "compass_map_mp_strikezone_after" );
    maps\mp\_teleport::_ID32777( "start", [ 1, 2, 3, 4 ], [ 2, 1, 4, 3 ] );
    maps\mp\_teleport::_ID32777( "destroyed", [ 5, 6, 7, 8 ], [ 6, 5, 8, 7 ] );
    maps\mp\_teleport::_ID32761( 0 );
    maps\mp\_teleport::_ID32781( ::pre_teleport, "destroyed" );
    maps\mp\_teleport::_ID32780( ::_ID24782, "destroyed" );
    maps\mp\_teleport::_ID32780( ::pre_teleport_to_start, "start" );
    level.donuke_fx = ::donuke_fx_strikezone;
    level thread sunflare();
    level thread _ID13357();
    level thread _ID17720();
    level._ID20636 = ::_ID31963;
    level.mapcustomkillstreakfunc = ::_ID31964;
    level._ID20635 = ::_ID31962;
    maps\mp\_load::_ID20445();
    thread maps\mp\_fx::_ID13742();
    common_scripts\utility::_ID13189( "nuke_event_active" );
    level._ID35333 = 0;
    setdvar( "r_reactiveMotionWindAmplitudeScale", 0.3 );
    setdvar( "r_reactiveMotionWindFrequencyScale", 0.5 );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    maps\mp\_utility::_ID28710( "r_diffuseColorScale", 1.639, 1.5 );
    maps\mp\_utility::_ID28710( "r_specularcolorscale", 2.5, 3 );
    setdvar( "r_ssaorejectdepth", 1500 );
    setdvar( "r_ssaofadedepth", 1200 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "urban";
    game["axis_outfit"] = "desert";

    if ( level._ID25139 )
        setdvar( "sm_sunShadowScale", "0.6" );
    else if ( level._ID36452 )
        setdvar( "sm_sunShadowScale", "0.7" );

    level.pre_org = common_scripts\utility::_ID15384( "world_origin_pre", "targetname" );
    level._ID24780 = common_scripts\utility::_ID15384( "world_origin_post", "targetname" );
    level._ID21012 = 0;

    if ( isdefined( level._ID24780 ) && isdefined( level.pre_org ) )
        level._ID21012 = ( level.pre_org.origin[2] + level._ID24780.origin[2] ) / 2;

    common_scripts\utility::_ID13189( "teleport_to_destroyed" );
    common_scripts\utility::_ID13189( "start_fog_fade_in" );
    common_scripts\utility::_ID13189( "start_fog_fade_out" );
    level thread _ID22338();
    level thread _ID12711();
    level thread ronnie_talks();
    level thread connect_watch();
    level thread _ID37490();
}

_ID37490()
{
    var_0 = getent( "clip128x128x128", "targetname" );
    var_1 = spawn( "script_model", ( 1488, 448, 34992 ) );
    var_1.angles = ( 0, 0, 0 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
    var_2 = getent( "clip256x256x8", "targetname" );
    var_3 = spawn( "script_model", ( -1589.73, 167.941, 34846 ) );
    var_3.angles = ( 7.64427, 359.534, -40.4325 );
    var_3 clonebrushmodeltoscriptmodel( var_2 );

    if ( maps\mp\_utility::_ID18422() )
    {
        var_4 = getent( "player256x256x128", "targetname" );
        var_5 = spawn( "script_model", ( 1091.96, -1218, 35088 ) );
        var_5.angles = ( 0, 60, -90 );
        var_5 clonebrushmodeltoscriptmodel( var_4 );
        var_6 = getent( "player256x256x128", "targetname" );
        var_7 = spawn( "script_model", ( 1314.31, -727.89, 34967.3 ) );
        var_7.angles = ( 345.369, 351.123, 18.9223 );
        var_7 clonebrushmodeltoscriptmodel( var_6 );
        var_8 = getent( "player256x256x128", "targetname" );
        var_9 = spawn( "script_model", ( 955.98, 485.142, 34875.7 ) );
        var_9.angles = ( 336.26, 306.702, -30.7675 );
        var_9 clonebrushmodeltoscriptmodel( var_8 );
    }
}

_ID13357()
{
    var_0 = getent( "after_sky", "targetname" );

    if ( isdefined( var_0 ) )
        var_0.angles = ( 180, 0, 0 );
}

connect_watch()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );

        if ( isdefined( level._ID35333 ) )
            var_0 visionsetstage( level._ID35333, 0.1 );

        var_0 thread _ID36023();
        playfxontagforclients( level._ID1644["vfx_sunflare"], level._ID32074, "tag_origin", var_0 );
    }
}

_ID36023()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "grenade_fire",  var_0, var_1  );

        if ( isdefined( var_1 ) && isdefined( var_0 ) && var_1 == "throwingknife_mp" )
            level thread watch_throwing_knife_land( var_0 );
    }
}

watch_throwing_knife_land( var_0 )
{
    var_0 endon( "death" );
    var_0 waittill( "missile_stuck",  var_1  );
    level notify( "hit_by_knife",  var_0, var_1  );
}

sunflare()
{
    var_0 = ( -2827.98, -25930.5, 12914.9 );
    var_1 = ( 270, 0, 0 );
    var_2 = ( -1831.25, -12492.3, 41020.6 );
    var_3 = ( 270, 0, 0 );
    level._ID32074 = spawn( "script_model", var_0 );
    level._ID32074 setmodel( "tag_origin" );
    level._ID32074.angles = var_1;
    common_scripts\utility::flag_wait( "teleport_setup_complete" );

    if ( level.teleport_zone_current != "start" )
    {
        level._ID32074.origin = var_2;
        level._ID32074.angles = var_3;
    }

    for (;;)
    {
        level waittill( "teleport_to_zone",  var_4  );

        if ( var_4 == "start" )
        {
            level._ID32074.origin = var_0;
            level._ID32074.angles = var_1;
            continue;
        }

        level._ID32074.origin = var_2;
        level._ID32074.angles = var_3;
    }
}

_ID17720()
{
    common_scripts\utility::flag_wait( "teleport_setup_complete" );

    if ( level.teleport_zone_current != "start" )
        destroyed_fire_fx();
}

donuke_fx_strikezone()
{
    if ( !level.allow_level_killstreak )
        return 0;

    game["player_holding_level_killstrek"] = 0;
    disable_strikezone_rog();
    thread maps\mp\_teleport::_ID32789( "destroyed" );
    return 1;
}

pre_teleport()
{
    level notify( "nuke_start" );
    common_scripts\utility::flag_set( "nuke_event_active" );
    level.allow_level_killstreak = 0;
    level.disable_killcam = 1;
    maps\mp\gametypes\_damage::erasefinalkillcam();

    if ( !maps\mp\_utility::levelflag( "post_game_level_event_active" ) )
        maps\mp\gametypes\_hostmigration::_ID35597( level._ID22376 - 2 );

    var_0 = 2;
    var_1 = 0.2;
    var_2 = 0.1;
    level thread _ID22342( 0.3, var_0 );
    thread _ID22346( 2 );
    level._ID22347 = gettime();
    common_scripts\utility::exploder( 60 );
    level thread _ID22351();
    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );

    foreach ( var_4 in level.players )
    {
        if ( isdefined( var_4.setspawnpoint ) )
            var_4 maps\mp\perks\_perkfunctions::deleteti( var_4.setspawnpoint );
    }

    level thread _ID22349( 0.1, var_1 + var_2, 0 );
    maps\mp\gametypes\_hostmigration::_ID35597( var_1 );
    level thread _ID22342( 0.5, 5 );
    level thread _ID26914( "hijack_plane_medium" );
    level thread _ID22348();

    if ( !maps\mp\_utility::levelflag( "post_game_level_event_active" ) && isdefined( level._ID22371.team ) )
        level thread maps\mp\killstreaks\_nuke::_ID22360();

    visionsetnaked( "mp_strikezone_flash", var_2 );
    maps\mp\gametypes\_hostmigration::_ID35597( var_2 );
    wait 0.1;
    common_scripts\utility::exploder( 70, undefined, level._ID22347 / 1000 );
    common_scripts\utility::flag_set( "teleport_to_destroyed" );
}

_ID24782()
{
    level thread maps\mp\killstreaks\_nuke::_ID22357();
    level thread _ID38230();

    if ( level._ID14086 == "grnd" )
        level thread maps\mp\gametypes\grnd::cyclezones();

    var_0 = 0.5;
    var_1 = 2.5;
    var_2 = 3.5;
    nuke_blur( 3, 0.1 );
    common_scripts\utility::flag_set( "start_fog_fade_out" );
    visionsetnaked( "mp_strikezone_explosion", var_0 );
    common_scripts\utility::_ID35582();
    level thread _ID22349( 0, var_0, 1 );
    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    nuke_blur( 0, var_1 + 2 );
    maps\mp\gametypes\_hostmigration::_ID35597( var_1 );
    visionsetnaked( "mp_strikezone_after", var_2 );
    setexpfog( 431.294, 2011.37, 0.54, 0.54, 0.54, 1, 0.5, var_2, 0.92, 0.69, 0.44, 1, ( -0.05, -0.89, 0.44 ), 0, 100, 0.625, 1, 140.897, 114.026 );
    wait(var_2);
    visionsetnaked( "", 0 );
    clearfog( 0 );
    level.disable_killcam = 0;
    common_scripts\utility::_ID13180( "nuke_event_active" );
}

_ID38230()
{
    if ( level.gameended )
        return;

    foreach ( var_1 in level.players )
    {
        if ( isai( var_1 ) )
            continue;

        var_1 setmlgcameradefaults( 0, level.camera5pos, level.camera5ang );
        var_1 setmlgcameradefaults( 1, level.camera6pos, level.camera6ang );
        var_1 setmlgcameradefaults( 2, level.camera7pos, level.camera7ang );
        var_1 setmlgcameradefaults( 3, level.camera8pos, level.camera8ang );
    }
}

pre_teleport_to_start()
{
    visionsetnaked( "", 0 );
}

_ID22338()
{
    level endon( "nuke_start" );
    common_scripts\utility::flag_wait( "teleport_setup_complete" );
    level waittill( "spawning_intermission" );

    if ( level.allow_level_killstreak )
        level thread _ID22345();
}

_ID22345()
{
    maps\mp\_utility::levelflagset( "post_game_level_event_active" );
    visionsetnaked( "", 0.5 );
    maps\mp\_teleport::_ID32789( "destroyed" );
    wait 5;
    maps\mp\_utility::_ID19892( "post_game_level_event_active" );
}

_ID22346( var_0 )
{
    if ( isdefined( var_0 ) && var_0 > 0 )
        wait(var_0);

    common_scripts\utility::exploder( 2 );
    wait 2;
    destroyed_fire_fx();
    wait 2.5;
    common_scripts\utility::exploder( 19 );
    wait 4.8;
    common_scripts\utility::exploder( 23 );
}

destroyed_fire_fx()
{
    exploder_with_connect_watch( 8, -2 );
}

exploder_with_connect_watch( var_0, var_1 )
{
    common_scripts\utility::exploder( var_0, undefined, var_1 );
    level thread _ID12469( var_0, var_1 );
}

_ID12469( var_0, var_1 )
{
    for (;;)
    {
        level waittill( "connected",  var_2  );
        common_scripts\utility::exploder( var_0, var_2, var_1 );
    }
}

_ID28609( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1.0;

    foreach ( var_3 in level.players )
        var_3 visionsetstage( var_0, var_1 );

    level._ID35333 = var_0;
}

_ID28203( var_0 )
{
    if ( !isdefined( level._ID24529 ) )
        level._ID24529 = 0;

    if ( var_0 == level._ID24529 )
        return;

    if ( var_0 )
    {
        level._ID24921 = level._ID21286;
        level._ID21286 = ::_ID34203;
    }
    else
        level._ID21286 = level._ID24921;

    level._ID24529 = var_0;
}

_ID34203( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( isdefined( var_0 ) )
        return var_0.health - 1;

    return 0;
}

_ID22349( var_0, var_1, var_2 )
{
    setslowmotion( 1.0, 0.25, var_0 );
    wait(var_1);
    setslowmotion( 0.25, 1, var_2 );
}

_ID22342( var_0, var_1 )
{
    var_2 = common_scripts\utility::_ID15386( "nuke_earthquake", "targetname" );

    foreach ( var_4 in var_2 )
        earthquake( var_0, var_1, var_4.origin, var_4.radius );
}

_ID22351()
{
    var_0 = 40000;
    var_1 = anglestoforward( ( 319.008, 265.869, 88.6746 ) );
    var_2 = ( -3892.33, 1244.78, -156.711 );
    var_3 = var_2 + var_1 * var_0;
    playsoundatpos( var_3, "kem_launch" );
    var_4 = 2;
    var_5 = spawn( "script_model", var_3 );
    var_5 setmodel( "tag_origin" );
    var_5 common_scripts\utility::delaycall( 0.05, ::playsoundonmovingent, "kem_incoming" );
    var_5 moveto( var_2, var_4 );
    maps\mp\gametypes\_hostmigration::_ID35597( var_4 );

    if ( !isdefined( level.nuke_soundobject ) )
    {
        level.nuke_soundobject = spawn( "script_origin", ( 0, 0, 1 ) );
        level.nuke_soundobject hide();
    }

    level.nuke_soundobject playsound( "kem_explosion" );
}

_ID22348()
{
    var_0 = spawnstruct();
    var_1 = spawnstruct();
    var_2 = 0.2;
    var_3 = 1;
    var_4 = 20;
    var_5 = spawn( "script_model", ( 0, 0, 0 ) );
    var_5.angles = ( 0, 0, 0 );

    foreach ( var_7 in level.players )
        var_7 playersetgroundreferenceent( var_5 );

    var_5 rotateto( ( var_4, 0, 0 ), var_2, 0, var_2 );
    wait(var_2);
    var_5 rotateto( ( 0, 0, 0 ), var_3, 0, var_3 );
    wait(var_3);

    foreach ( var_7 in level.players )
        var_7 playersetgroundreferenceent( undefined );

    var_5 delete();
}

nuke_blur( var_0, var_1 )
{
    foreach ( var_3 in level.players )
        var_3 setblurforplayer( var_0, var_1 );
}

_ID26914( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    foreach ( var_3 in level.players )
    {
        if ( var_1 )
        {
            var_3 playrumblelooponentity( var_0 );
            continue;
        }

        var_3 playrumbleonentity( var_0 );
    }

    if ( !var_1 )
        return;

    level waittill( "stop_rumble_loop" );

    foreach ( var_3 in level.players )
        var_3 stoprumble( var_0 );
}

_ID31816()
{
    level notify( "stop_rumble_loop" );
}

generic_swing_ents()
{
    var_0 = [];
    var_0["small"] = "mp_strikezone_chunk_sway_small";
    var_0["large"] = "mp_strikezone_chunk_sway_large";

    foreach ( var_3, var_2 in var_0 )
        precachempanim( var_2 );

    var_4 = getentarray( "generic_swing", "targetname" );

    foreach ( var_6 in var_4 )
    {
        if ( !isdefined( var_6.angles ) )
            var_6.angles = ( 0, 0, 0 );

        var_7 = spawn( "script_model", var_6.origin );
        var_7.angles = var_6.angles;
        var_7 setmodel( "generic_prop_raven" );
        var_6 linkto( var_7, "j_prop_1" );
        var_8 = "small";

        if ( isdefined( var_6.script_noteworthy ) && isdefined( var_0[var_6.script_noteworthy] ) )
            var_8 = var_6.script_noteworthy;

        var_7 scriptmodelplayanim( var_0[var_6.script_noteworthy] );
    }
}

_ID12711()
{
    var_0 = getentarray( "fall_object", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::fall_object_init );
}

fall_object_init()
{
    self.end = self;
    var_0 = [];

    if ( isdefined( self.target ) )
    {
        var_1 = common_scripts\utility::_ID15386( self.target, "targetname" );
        _ID28290( var_1, "angle_ref" );
        var_0 = common_scripts\utility::array_combine( var_0, var_1 );
        var_2 = getentarray( self.target, "targetname" );
        var_0 = common_scripts\utility::array_combine( var_0, var_2 );
    }

    if ( isdefined( self.script_linkto ) )
    {
        var_1 = common_scripts\utility::_ID15386( self.script_linkto, "script_linkname" );
        _ID28290( var_1, "start" );
        var_0 = common_scripts\utility::array_combine( var_0, var_1 );
        var_2 = getentarray( self.script_linkto, "script_linkname" );
        var_0 = common_scripts\utility::array_combine( var_0, var_2 );
    }

    foreach ( var_4 in var_0 )
    {
        if ( !isdefined( var_4.script_noteworthy ) )
            continue;

        switch ( var_4.script_noteworthy )
        {
            case "angle_ref":
                self.end = var_4;
                continue;
            case "start":
                self._ID31206 = var_4;
                continue;
            case "link":
                var_4 linkto( self );
                continue;
            default:
                continue;
        }
    }

    _ID28285( var_0 );

    if ( isdefined( self._ID31206 ) && isdefined( self.end ) )
        thread fall_object_run();
}

_ID28290( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = "";

    if ( !isarray( var_0 ) )
        var_0 = [ var_0 ];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.script_noteworthy ) )
            var_3.script_noteworthy = var_1;
    }
}

_ID28285( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = ( 0, 0, 0 );

    if ( !isarray( var_0 ) )
        var_0 = [ var_0 ];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.angles ) )
            var_3.angles = var_1;
    }
}

fall_object_run()
{
    var_0 = self.origin;
    var_1 = self.angles;
    var_2 = transformmove( self._ID31206.origin, self._ID31206.angles, self.end.origin, self.end.angles, self.origin, self.angles );
    self.origin = var_2["origin"];
    self.angles = var_2["angles"];
    common_scripts\utility::flag_wait( "start_fog_fade_out" );
    wait(randomfloatrange( 0.8, 1.0 ));

    if ( isdefined( self.script_delay ) )
    {
        if ( self.script_delay < 0 )
            self.script_delay = randomfloatrange( 30, 120 );

        wait(self.script_delay);
    }

    playsoundatpos( self.origin, "cobra_helicopter_crash" );
    var_3 = randomfloatrange( 300, 320 );
    var_4 = distance( var_0, self.origin );
    var_5 = var_4 / var_3;
    self moveto( var_0, var_5, var_5, 0 );

    if ( var_1 != self.angles )
        self rotateto( var_1, var_5, 0, 0 );

    wait(var_5);
}

ronnie_talks()
{
    var_0 = [];
    var_0["low"] = [];
    var_0["high"] = [];
    var_0["high"][0] = "mp_strikezone_hdg_01";
    var_0["high"][1] = "mp_strikezone_hdg_02";
    var_0["high"][2] = "mp_strikezone_hdg_03";
    var_0["high"][3] = "mp_strikezone_hdg_05";
    var_0["high"][4] = "mp_strikezone_hdg_06";
    var_0["high"][4] = "mp_strikezone_hdg_07";
    var_0["high"][4] = "mp_strikezone_hdg_09";
    var_0["low"][0] = "mp_strikezone_hdg_04";
    var_0["low"][1] = "mp_strikezone_hdg_08";
    var_0["low"][2] = "mp_strikezone_hdg_10";
    var_1 = getentarray( "ronnie_talk_location", "targetname" );
    common_scripts\utility::_ID3867( var_1, ::ronnie_knife_watcher );

    for (;;)
    {
        level waittill( "ronnie_speak",  var_2  );
        var_3 = common_scripts\utility::_ID25350( var_0[var_2.script_noteworthy] );
        playsoundatpos( var_2.origin, var_3 );
    }
}

ronnie_knife_watcher()
{
    self endon( "death" );

    for (;;)
    {
        level waittill( "hit_by_knife",  var_0, var_1  );

        if ( isdefined( var_0 ) )
        {
            if ( var_0 istouching( self ) )
                level notify( "ronnie_speak",  self  );
        }
    }
}

_ID31963()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    level.allow_level_killstreak = maps\mp\_utility::allowlevelkillstreaks();

    if ( !level.allow_level_killstreak || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "nuke", 55, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"KILLSTREAKS_HINTS_STRIKEZONE_ROG" );
    level thread _ID31961();
}

_ID31961()
{
    common_scripts\utility::flag_wait( "teleport_setup_complete" );

    if ( level._ID32716 )
    {
        if ( level.allow_level_killstreak )
            level thread _ID35973();
    }
    else
    {
        level.allow_level_killstreak = 0;
        disable_strikezone_rog();
    }
}

_ID35973()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "nuke" )
        {
            disable_strikezone_rog();
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                _ID11469();
                continue;
            }

            game["player_holding_level_killstrek"] = 1;
            break;
        }
    }
}

_ID35446( var_0 )
{
    var_1 = _ID35948( var_0 );
    return !isdefined( var_1 );
}

_ID35948( var_0 )
{
    var_0 endon( "captured" );
    var_0 waittill( "death" );
    waittillframeend;
    return 1;
}

_ID11469()
{
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "nuke", 55 );
}

disable_strikezone_rog()
{
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "nuke", 0 );
}

_ID31964()
{

}

_ID31962()
{

}
