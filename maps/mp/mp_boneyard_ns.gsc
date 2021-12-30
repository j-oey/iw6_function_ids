// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_boneyard_ns_precache::_ID20445();
    maps\createart\mp_boneyard_ns_art::_ID20445();
    maps\mp\mp_boneyard_ns_fx::_ID20445();
    level._ID20636 = ::_ID36813;
    level.mapcustomkillstreakfunc = ::_ID36814;
    level._ID20635 = ::_ID36812;
    maps\mp\_load::_ID20445();
    maps\mp\_compass::_ID29184( "compass_map_mp_boneyard_ns" );
    maps\mp\mp_boneyard_ns_anim::_ID20445();
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 2, 4.5 );
    setdvar( "sm_sunShadowScale", 0.6 );
    setdvar( "sm_sunSampleSizeNear", 0.35 );
    level._ID36681 = spawn( "script_origin", ( -93, 1451, 248 ) );
    level._ID36683 = spawn( "script_origin", ( 317, 1449, 247 ) );
    level._ID36682 = spawn( "script_origin", ( 805, 1443, 275 ) );
    level._ID37203 = spawn( "script_origin", ( 517, 1463, 14 ) );
    level.fire_event_a2 = spawn( "script_origin", ( 517, 1463, 14 ) );
    level.fire_event_a3 = spawn( "script_origin", ( 517, 1463, 14 ) );
    level._ID37204 = spawn( "script_origin", ( 381, 1463, -18 ) );
    level.fire_event_b2 = spawn( "script_origin", ( 381, 1463, -18 ) );
    level.fire_event_lp = spawn( "script_origin", ( 280, 1471, 9 ) );
    level.fire_event_lpstart = spawn( "script_origin", ( 280, 1471, 9 ) );
    level.fire_event_lpstop = spawn( "script_origin", ( 280, 1471, 9 ) );
    level._ID37607 = spawn( "script_origin", ( 1936, 231, 221 ) );
    level._ID37608 = spawn( "script_origin", ( -1028, 534, 368 ) );
    level._ID37606 = spawn( "script_origin", ( 2917, 396, 10 ) );
    game["attackers"] = "allies";
    game["defenders"] = "axis";

    while ( !isdefined( level._ID14087 ) )
        wait 0.05;

    maps\mp\mp_boneyard_ns_killstreak::_ID36805();
    flag_inits();

    if ( level._ID14086 == "sd" || level._ID14086 == "sr" || level._ID14086 == "grind" )
        _ID37991( 1, "horizontal rocket fire" );
    else if ( level._ID14086 == "blitz" || level._ID14086 == "horde" || maps\mp\_utility::_ID37549() )
        _ID37991( 1 );
    else
        _ID37985();

    thread _ID37559();

    if ( level._ID14086 == "horde" || level._ID14086 == "infect" )
        setup_safeguard();

    level thread _ID37490();
}

_ID37490()
{
    if ( level._ID14086 == "horde" || level._ID14086 == "infect" )
    {
        var_0 = getent( "clip128x128x8", "targetname" );
        var_1 = spawn( "script_model", ( -1352, 168, 150 ) );
        var_1.angles = ( 0, 0, 0 );
        var_1 clonebrushmodeltoscriptmodel( var_0 );
    }

    if ( level._ID36452 || level._ID36451 )
    {
        var_2 = spawn( "script_model", ( -136, 1246, 136 ) );
        var_2 setmodel( "comm_desk_part_long" );
        var_2.angles = ( 360, 90, 90 );
        var_3 = spawn( "script_model", ( -136, 1346, 136 ) );
        var_3 setmodel( "comm_desk_part_long" );
        var_3.angles = ( 360, 90, 90 );
        var_4 = spawn( "script_model", ( -136, 1446, 136 ) );
        var_4 setmodel( "comm_desk_part_long" );
        var_4.angles = ( 360, 90, 90 );
        var_5 = spawn( "script_model", ( -136, 1546, 136 ) );
        var_5 setmodel( "comm_desk_part_long" );
        var_5.angles = ( 360, 90, 90 );
        var_6 = spawn( "script_model", ( -132, 1578, 157 ) );
        var_6 setmodel( "light_post_strip_mall_02" );
        var_6.angles = ( 0, 90, 180 );
    }
}

flag_inits()
{
    common_scripts\utility::_ID13189( "flag_rocket_countdown" );
    common_scripts\utility::_ID13189( "flag_rocket_countdown_fx" );
    common_scripts\utility::_ID13189( "flag_rocket_launched" );
    common_scripts\utility::_ID13189( "Horizontal_Test_Fired" );
    common_scripts\utility::_ID13189( "Horizontal_Test_Firing" );
}

_ID37985()
{
    thread _ID37963();
    maps\mp\mp_boneyard_ns_killstreak::_ID36808();
    _ID36801();
    getent( "remd_02_proxy", "targetname" ) delete();
    level._ID37912 = getentarray( "rocket_explo_obj", "targetname" );

    foreach ( var_1 in level._ID37912 )
        var_1 _ID37993();

    var_3 = getscriptablearray( "scriptable_toy_com_propane_tank02_cheap", "classname" );

    foreach ( var_5 in var_3 )
        var_5 thread _ID37916();

    level thread maps\mp\mp_boneyard_ns_killstreak::_ID36803();
    level thread maps\mp\mp_boneyard_ns_killstreak::_ID36807();
    level thread _ID36802();
    thread _ID37777();
    thread _ID36620::_ID37998( "alienEasterEgg" );
    maps\mp\_utility::_ID9519( 5, ::_ID37184, 10, 3 );
    maps\mp\_utility::_ID9519( 60, ::_ID37183, 25, 3 );
}

_ID37991( var_0, var_1 )
{
    getent( "rocket_explo_rocket", "targetname" ) delete();
    var_2 = getentarray( "rocket_explo_obj", "targetname" );

    foreach ( var_4 in var_2 )
    {
        var_5 = getentarray( var_4.target + "_before", "targetname" );
        common_scripts\utility::array_call( var_5, ::delete );
        var_6 = getentarray( var_4.target + "_delete", "targetname" );

        foreach ( var_8 in var_6 )
        {
            var_8 connectpaths();
            var_8 delete();
        }

        if ( isdefined( level._ID37186["rocket_explo"][var_4._ID27658] ) )
            _ID37722( level._ID37186["rocket_explo"][var_4._ID27658], -60 );
    }

    thread _ID38059();
    level notify( "rocket_crash_01" );
    getent( "remd_02_proxy", "targetname" ) delete();
    getent( "tunnel_exit_A_mantles", "targetname" ) delete();
    var_11 = getentarray( "unbroken_facade", "targetname" );
    common_scripts\utility::array_call( var_11, ::delete );
    _ID37722( 208, -60 );
    radiusdamage( ( -309, -516, -47 ), 50, 496, 500 );
    level._ID37188[5] = spawnstruct();
    level._ID37188[5]._ID22381 = 5;
    level._ID37188[5]._ID33037 = gettime();
    level._ID37188[5]._ID31480 = 0;
    var_12 = getscriptablearray( "scriptable_toy_com_propane_tank02_cheap", "classname" );

    foreach ( var_14 in var_12 )
        var_14 thread _ID37916();

    maps\mp\_utility::_ID9519( 3, ::_ID37722, 21 );
    level thread maps\mp\mp_boneyard_ns_killstreak::_ID36807();

    if ( isdefined( var_0 ) && var_0 )
    {
        if ( isdefined( var_1 ) )
        {
            switch ( var_1 )
            {
                case "horizontal rocket fire":
                    maps\mp\mp_boneyard_ns_killstreak::_ID36808();
                    level thread maps\mp\mp_boneyard_ns_killstreak::_ID36803();
                    break;
                default:
                    break;
            }
        }
        else
        {
            maps\mp\mp_boneyard_ns_killstreak::_ID36808();
            _ID36801();
            level thread maps\mp\mp_boneyard_ns_killstreak::_ID36803();
            level thread _ID36802();
        }
    }

    thread _ID36620::_ID37998( "alienEasterEgg" );
    maps\mp\_utility::_ID9519( 5, ::_ID37184, 10, 3 );
    maps\mp\mp_boneyard_ns_killstreak::_ID36806( 200 );
}

setup_safeguard()
{
    var_0 = getnode( "crawler_ladder_bottom_node", "targetname" );
    var_1 = getnode( "crawler_ladder_top_node", "targetname" );
    disconnectnodepair( var_1, var_0 );
    var_2 = getent( "crawler_ladder", "targetname" );
    var_2 delete();
}

_ID37777()
{
    wait 3;
    _ID37722( 21 );
    var_0 = ( 5706.71, -2875.28, 456.125 );
    var_1 = ( 270, 0, 0 );
    var_2 = anglestoup( var_1 );
    var_3 = anglestoforward( var_1 );
    var_4 = spawnfx( level._ID1644["vfx_mp_boneyard_rocket_spot"], var_0, var_3, var_2 );
    triggerfx( var_4 );
    var_5 = ( 6209.81, -2376.86, 446.79 );
    var_6 = ( 307.118, 274.46, 85.1872 );
    var_7 = anglestoup( var_6 );
    var_8 = anglestoforward( var_6 );
    var_9 = spawnfx( level._ID1644["vfx_mp_boneyard_rocket_spot"], var_5, var_8, var_7 );
    triggerfx( var_9 );
    var_10 = ( 4493.13, -2993.15, -151.985 );
    var_11 = ( 302.07, 56.4086, -61.7638 );
    var_12 = anglestoup( var_11 );
    var_13 = anglestoforward( var_11 );
    var_14 = spawnfx( level._ID1644["vfx_mp_boneyard_rocket_spot"], var_10, var_13, var_12 );
    triggerfx( var_14 );
    var_15 = ( 15341.6, -606.557, 2176.76 );
    var_16 = ( 315.112, 247.696, 110.105 );
    var_17 = anglestoup( var_16 );
    var_18 = anglestoforward( var_16 );
    var_19 = spawnfx( level._ID1644["vfx_mp_boneyard_rocket_spot"], var_15, var_18, var_17 );
    triggerfx( var_19 );
    var_20 = ( 15101, -1212.7, 2176.63 );
    var_21 = ( 270, 0, 0 );
    var_22 = anglestoup( var_21 );
    var_23 = anglestoforward( var_21 );
    var_24 = spawnfx( level._ID1644["vfx_mp_boneyard_rocket_spot"], var_20, var_23, var_22 );
    triggerfx( var_24 );
    var_25 = ( 15261.2, -2023.07, 2176.63 );
    var_26 = ( 308.808, 40.8442, -47.1412 );
    var_27 = anglestoup( var_26 );
    var_28 = anglestoforward( var_26 );
    var_29 = spawnfx( level._ID1644["vfx_mp_boneyard_rocket_spot"], var_25, var_28, var_27 );
    triggerfx( var_29 );
    level waittill( "rocket_success_blast_off" );
    var_19 delete();
    var_24 delete();
    var_29 delete();
    level waittill( "rocket_explo_blast_off" );
    var_4 delete();
    var_9 delete();
    var_14 delete();
}

_ID37993()
{
    self._ID7525 = getent( self.target, "targetname" );
    self._ID7525 linkto( self );
    self._ID37023 = getentarray( self.target + "_delete", "targetname" );
    self._ID37022 = getentarray( self.target + "_before", "targetname" );
    self._ID37021 = getentarray( self.target + "_after", "targetname" );
    self._ID37024 = getnodearray( self.target + "_traverse", "targetname" );
    self.linked_ents = [];
    self.kill_ents = [ self._ID7525 ];

    if ( isdefined( self._ID7525.target ) )
    {
        foreach ( var_1 in getentarray( self._ID7525.target, "targetname" ) )
        {
            var_1 linkto( self );
            self.linked_ents[self.linked_ents.size] = var_1;

            if ( isdefined( var_1.script_noteworthy ) && var_1.script_noteworthy == "push_kill" )
                self.kill_ents[self.kill_ents.size] = var_1;
        }
    }

    self._ID37194 = self._ID27658;
    self._ID31345 = getent( "rocket_explo_explosion", "targetname" );
    self hide();
    common_scripts\utility::array_call( self.linked_ents, ::hide );
    self.origin = self._ID31345.origin;
    self.angles = self._ID31345.angles;
    self._ID7525 common_scripts\utility::delaycall( 0.05, ::disconnectpaths );
    self._ID7525 common_scripts\utility::delaycall( 0.05, ::setaisightlinevisible, 0 );

    foreach ( var_1 in self._ID37021 )
    {
        var_1 hide();
        var_1.origin = var_1.origin - ( 0, 0, 1024 );
    }

    wait 0.1;

    foreach ( var_6 in self._ID37024 )
        disconnectnodepair( var_6, getnode( var_6.target, "targetname" ) );
}

_ID37963()
{
    var_0 = getentarray( "unbroken_facade", "targetname" );
    var_1 = getentarray( "broken_facade", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 hide();

    level waittill( "break_facade" );

    foreach ( var_3 in var_1 )
    {
        _ID37722( 205 );
        var_3 show();
    }

    foreach ( var_3 in var_0 )
        var_3 hide();

    wait 0.36;
    _ID37722( 206 );
    wait 0.3;
    _ID37722( 207 );
    wait 0.28;
    _ID37722( 208 );
}

_ID37916()
{
    self waittill( "death" );
    iprintln( "tank dead" );
}

_ID36813()
{
    level thread maps\mp\mp_boneyard_ns_killstreak::_ID36813();
}

_ID36814()
{
    level._ID19256["f1_engine_fire"] = ::_ID38170;
}

_ID36812()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "f1_engine_fire", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

_ID38170( var_0, var_1 )
{
    if ( common_scripts\utility::_ID13177( "boneyard_killstreak_active" ) || !isdefined( level._ID37580 ) )
    {
        self iprintlnbold( &"MP_BONEYARD_NS_F1_IN_USE" );
        return 0;
    }

    level._ID37580._ID38240 = level._ID37580._ID38240 + 1;
    level notify( "boneyard_killstreak_activate",  self  );

    if ( level._ID37580._ID38240 >= level._ID37580._ID37663 )
    {
        level._ID37580._ID38240 = 0;
        return 1;
    }

    return 0;
}

_ID37182( var_0, var_1 )
{
    common_scripts\utility::flag_set( "flag_rocket_countdown" );

    for ( var_2 = var_0; var_2 >= 0; var_2-- )
    {
        if ( var_2 == 20 )
            _ID37722( 16 );

        if ( isdefined( var_1[var_2] ) )
        {
            level._ID37607 playsound( var_1[var_2] );
            level._ID37608 playsound( var_1[var_2] );
        }

        wait 1;
    }

    common_scripts\utility::_ID13180( "flag_rocket_countdown" );
}

_ID37184( var_0, var_1 )
{
    level notify( "rocket_success_start" );
    var_2 = getent( "rocket_success_rocket", "targetname" );
    var_3 = [];
    var_2 thread _ID37182( var_0, var_3 );
    wait(var_0 - var_1);
    level notify( "rocket_success_launch_init" );
    _ID37722( 33 );
    var_2 playsound( "scn_beginning_launch_sfx_dist" );
    wait(var_1);
    level notify( "rocket_success_blast_off" );
    playfxontag( level._ID1644["vfx_rocket_shuttle_smoke_geotrail_xlarge"], var_2, "tag_origin" );
    var_2 scriptmodelplayanimdeltamotion( level._ID36718["rocket_success"]["launch"] );
    wait(getanimlength( level._ID36722["rocket_success"]["launch"] ));
    level notify( "rocket_success_finished" );
    thread _ID36751();
    var_2 scriptmodelclearanim();
    var_4 = anglestoup( var_2.angles );
    var_2 moveto( var_4 * 62512.5, 64 );
    wait 64;
    stopfxontag( level._ID1644["vfx_rocket_shuttle_smoke_geotrail_xlarge"], var_2, "tag_origin" );
    var_2 delete();
}

_ID36751()
{
    wait 25;
    level._ID37606 playsound( "mp_boneyard_fd_attentionallpersonelthis" );
}

_ID37183( var_0, var_1 )
{
    level notify( "rocket_explo_start" );
    getscriptablearray( "countdown_clock", "targetname" )[0] setscriptablepartstate( 0, 1 );
    var_2 = getent( "rocket_explo_explosion", "targetname" );
    var_3 = getent( "rocket_explo_rocket", "targetname" );
    var_4 = level._ID36722["rocket_explo"]["launch"];
    var_5 = [];
    var_5[25] = "mp_boneyard_ld_autosequencestarttminus";
    var_5[17] = "mp_boneyard_ld_tminus15";
    var_5[13] = "mp_boneyard_ld_tminus10";
    maps\mp\_utility::_ID9519( 57.8, ::_ID37722, 111 );
    _ID37722( 20 );
    common_scripts\utility::flag_set( "flag_rocket_countdown_fx" );
    wait(60 - var_0);
    var_3 thread _ID37182( var_0, var_5 );
    wait(var_0 - var_1);
    level notify( "rocket_explo_launch_init" );
    _ID37722( 32 );
    var_3 playsound( "scn_beginning_launch_sfx" );
    wait(var_1);
    level notify( "rocket_explo_blast_off" );
    common_scripts\utility::flag_set( "flag_rocket_launched" );
    playfxontag( level._ID1644["vfx_rocket_shuttle_smoke_geotrail_xlarge"], var_3, "control_root" );
    var_3 scriptmodelplayanimdeltamotion( level._ID36718["rocket_explo"]["launch"] );
    thread _ID38061( var_3 );
    thread _ID36920();

    foreach ( var_7 in level._ID37912 )
        var_7 thread _ID37914();

    var_9 = getanimlength( var_4 ) * getnotetracktimes( var_4, "rog_hit" )[0];
    wait(var_9);
    level notify( "rocket_explo_explode" );
    _ID37722( 64 );
    stopfxontag( level._ID1644["vfx_rocket_shuttle_smoke_geotrail_xlarge"], var_3, "control_root" );
    thread _ID37232( var_3 );
    level._ID37912[1] playsound( "scn_shuttle_debris_fall_01" );
    level._ID37912[2] playsound( "scn_shuttle_debris_fall_02" );
    thread _ID37189();
    thread _ID37887();
    thread _ID37913();
    thread _ID38059();
    thread _ID38008();
    thread kill_survivors( "rocket_crash_01", ( -752, 96, -112 ), 192, 96 );
    thread kill_survivors( "rocket_crash_02", ( 944, 112, -112 ), 192, 96 );
    wait(getanimlength( var_4 ) - var_9);
    var_3 delete();
    level notify( "rocket_explo_finished" );
    maps\mp\_compass::_ID29184( "compass_map_mp_boneyard_ns_after" );
    maps\mp\mp_boneyard_ns_killstreak::_ID36806( 200 );
}

_ID37232( var_0 )
{
    playfxontag( level._ID1644["vfx_debris_trail_xlarge"], var_0, "j_rocket_004" );
    playfxontag( level._ID1644["vfx_debris_trail_xlarge"], var_0, "j_rocket_005" );
    common_scripts\utility::_ID35582();
    playfxontag( level._ID1644["vfx_debris_trail_xlarge"], var_0, "j_rocket_006" );
    playfxontag( level._ID1644["vfx_debris_trail_xlarge"], var_0, "j_rocket_007" );
    common_scripts\utility::_ID35582();
    playfxontag( level._ID1644["vfx_debris_trail_xlarge"], var_0, "j_rocket_008" );
}

_ID38061( var_0 )
{
    wait 5.5;
    var_0 playsound( "scn_beggining_launch_explode" );
}

_ID36920()
{
    var_0 = getanimlength( level._ID36722["rocket_explo"]["crash_04"] );
    var_1 = getnotetracktimes( level._ID36722["rocket_explo"]["crash_04"], "building_hit" );
    var_2 = var_0 * var_1[0];
    wait(var_2);
    level notify( "break_facade" );
    thread _ID38060( "building" );
}

_ID38008()
{
    level waittill( "rocket_crash_01" );
    var_0 = spawn( "script_origin", ( -1686, 2876, 89 ) );
    var_1 = spawn( "script_origin", ( -2445, 1748, 18 ) );
    var_2 = spawn( "script_origin", ( -3190, 1477, 55 ) );
    wait 0.4;
    var_0 playsound( "scn_shuttle_dist_debris_01" );
    wait 0.1;
    var_1 playsound( "scn_shuttle_dist_debris_02" );
    wait 0.3;
    var_2 playsound( "scn_shuttle_dist_debris_06" );
    wait 6;
    var_0 delete();
    var_1 delete();
    var_2 delete();
}

_ID38059()
{
    level waittill( "rocket_crash_01" );
    var_0 = spawn( "script_origin", ( -808, -14, -130 ) );
    var_1 = spawn( "script_origin", ( -817, 210, -123 ) );
    var_2 = spawn( "script_origin", ( -1028, 534, 368 ) );
    var_3 = spawn( "script_origin", ( -599, 276, -117 ) );
    var_4 = spawn( "script_origin", ( -282, 184, -127 ) );
    var_5 = spawn( "script_origin", ( -384, 504, -45 ) );
    var_6 = spawn( "script_origin", ( -69, 923, -81 ) );
    var_7 = spawn( "script_origin", ( 133, 912, -68 ) );
    var_8 = spawn( "script_origin", ( 870, 1, -110 ) );
    var_9 = spawn( "script_origin", ( 880, 229, -115 ) );
    var_10 = spawn( "script_origin", ( 1224, 231, -147 ) );
    var_11 = spawn( "script_origin", ( 1377, 207, -159 ) );
    var_12 = spawn( "script_origin", ( 1340, -15, -149 ) );
    var_13 = spawn( "script_origin", ( 1154, 128, -31 ) );
    var_14 = spawn( "script_origin", ( -558, 61, 33 ) );
    var_15 = spawn( "script_origin", ( 973, 115, 7 ) );
    var_0 playloopsound( "fire_small_01" );
    var_1 playloopsound( "fire_small_01" );
    var_2 playloopsound( "fire_small_01" );
    var_3 playloopsound( "fire_small_01" );
    var_4 playloopsound( "fire_small_01" );
    var_5 playloopsound( "fire_small_01" );
    var_6 playloopsound( "fire_small_01" );
    var_7 playloopsound( "fire_small_01" );
    var_8 playloopsound( "fire_small_01" );
    var_9 playloopsound( "fire_small_01" );
    var_10 playloopsound( "fire_small_01" );
    var_11 playloopsound( "fire_small_01" );
    var_12 playloopsound( "fire_small_01" );
    var_13 playloopsound( "fire_ceiling_small_01" );
    var_14 playloopsound( "fire_ceiling_small_01" );
    var_15 playloopsound( "fire_small_01" );
}

_ID37189()
{
    wait 0.7;
    level._ID37607 playsound( "mp_boneyard_ld_supplydronehasbeen" );
    level._ID37608 playsound( "mp_boneyard_ld_supplydronehasbeen" );
}

_ID37914()
{
    common_scripts\utility::_ID3867( self.kill_ents, maps\mp\_movers::_ID24268, 0 );

    foreach ( var_1 in self.kill_ents )
        var_1.destroyairdroponcollision = 1;

    common_scripts\utility::array_call( self.linked_ents, ::show );
    self show();
    playfxontag( level._ID1644["vfx_debris_trail_xlarge"], self, "tag_origin" );
    var_3 = getanimlength( level._ID36722["rocket_explo"][self._ID37194] );
    thread _ID37915( var_3 );
    self scriptmodelplayanimdeltamotion( level._ID36718["rocket_explo"][self._ID37194] );
    wait(var_3);

    if ( maps\mp\gametypes\_hostmigration::_ID35770() )
        wait 0.05;

    stopfxontag( level._ID1644["vfx_debris_trail_xlarge"], self, "tag_origin" );

    foreach ( var_1 in self._ID37023 )
    {
        var_1 connectpaths();
        var_1 delete();
    }

    thread rocket_explo_drop_part_safety_check();
    common_scripts\utility::_ID3867( self.kill_ents, maps\mp\_movers::_ID31810 );
    self._ID7525 common_scripts\utility::delaycall( 0.05, ::disconnectpaths );
    self._ID7525 common_scripts\utility::delaycall( 0.05, ::setaisightlinevisible, 1 );
    wait 0.1;

    foreach ( var_7 in self._ID37024 )
        connectnodepair( var_7, getnode( var_7.target, "targetname" ) );
}

rocket_explo_drop_part_safety_check()
{
    foreach ( var_1 in level.players )
    {
        if ( var_1 istouching( self._ID7525 ) )
            self._ID7525 maps\mp\_movers::_ID34254( var_1 );
    }
}

_ID37915( var_0 )
{
    var_1 = getnotetracktimes( level._ID36722["rocket_explo"][self._ID37194], "ground_hit" );
    wait(var_0 * var_1[0]);
    level notify( "rocket_" + self._ID37194 );

    if ( isdefined( level._ID37186["rocket_explo"][self._ID37194] ) )
        _ID37722( level._ID37186["rocket_explo"][self._ID37194] );

    earthquake( 0.6, 1.5, self.origin, 800 );
    thread _ID38060( self._ID37194 );
    common_scripts\utility::array_call( self._ID37022, ::hide );

    foreach ( var_3 in self._ID37021 )
    {
        var_3 show();
        var_3 movez( 1024, 0.05 );
    }

    wait 0.1;
    common_scripts\utility::array_call( self._ID37022, ::delete );
}

_ID38060( var_0 )
{
    switch ( var_0 )
    {
        case "crash_01":
            self playsound( "scn_shuttle_debris_05" );
            break;
        case "crash_02":
            self playsound( "scn_shuttle_debris_04" );
            break;
        case "crash_03a":
            break;
        case "crash_03b":
            break;
        case "crash_04":
            self playsound( "scn_shuttle_debris_02" );
            break;
        case "building":
            var_1 = spawn( "script_origin", ( 670, 1101, 442 ) );
            var_1 playsound( "scn_shuttle_debris_01" );
            break;
        case "tank":
            break;
        default:
            break;
    }
}

_ID37887()
{
    level waittill( "rocket_crash_02" );
    var_0 = getent( "tunnel_exit_A_mantles", "targetname" );
    var_0 delete();
}

_ID37913()
{
    level waittill( "rocket_crash_01" );
    thread _ID38060( "tank" );
    radiusdamage( ( -309, -516, -47 ), 50, 496, 500 );
    level._ID37188[5] = spawnstruct();
    level._ID37188[5]._ID22381 = 5;
    level._ID37188[5]._ID33037 = gettime();
    level._ID37188[5]._ID31480 = 0;
}

kill_survivors( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );
    level waittill( var_0 );
    var_4 = spawn( "trigger_radius", var_1, 0, var_2, var_3 );
    damage_radius_check( var_4 );
}

damage_radius_check( var_0 )
{
    foreach ( var_2 in level._ID23303 )
    {
        if ( var_2 istouching( var_0 ) )
            var_2 dodamage( 1000, var_2.origin, undefined, undefined, "MOD_CRUSH" );
    }

    var_0 delete();
}

_ID37559()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread _ID37560();
    }
}

_ID37560()
{
    self endon( "disconnect" );
    common_scripts\utility::_ID35626( "joined_team", "luinotifyserver" );

    if ( !isdefined( level._ID37188 ) )
        return;

    var_0 = gettime();

    foreach ( var_2 in level._ID37188 )
    {
        if ( var_0 < var_2._ID33037 )
            continue;

        wait 0.05;
        var_3 = var_2._ID31480 - gettime() + var_2._ID33037;

        if ( var_3 > -60000 )
        {
            activateclientexploder( var_2._ID22381, self, var_3 / 1000.0 );
            continue;
        }

        activateclientexploder( var_2._ID22381, self, -60 );
    }

    if ( common_scripts\utility::_ID13177( "flag_rocket_launched" ) )
        getscriptablearray( "countdown_clock", "targetname" )[0] setscriptablepartstate( 0, 0 );
    else if ( common_scripts\utility::_ID13177( "flag_rocket_countdown_fx" ) )
        thread join_sync_countdown();
}

join_sync_countdown()
{
    self endon( "disconnect" );

    while ( !common_scripts\utility::_ID13177( "flag_rocket_launched" ) )
    {
        activateclientexploder( 7, self );
        wait 0.05;
    }
}

_ID37722( var_0, var_1 )
{
    common_scripts\utility::exploder( var_0, undefined, var_1 );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( level._ID37188 ) )
        level._ID37188 = [];

    level._ID37188[var_0] = spawnstruct();
    level._ID37188[var_0]._ID22381 = var_0;
    level._ID37188[var_0]._ID33037 = gettime();
    level._ID37188[var_0]._ID31480 = var_1 * 1000;
}

_ID36801()
{
    level._ID37206 = spawnstruct();
    level._ID37206.dam = getent( "damage_test_fire_horizontal", "targetname" );
    level._ID37206.player = undefined;
    level._ID37206.team = undefined;
    level._ID37206._ID33568 = spawn( "script_model", ( 471, 1601, -17 ) );
    level._ID37206._ID33568 setmodel( "tag_origin" );
    level._ID37206._ID33568 sethintstring( &"MP_BONEYARD_NS_HORIZONTAL_TEST" );
    level._ID37206.inflictor = getent( "horiz_fire_ent", "targetname" );
    common_scripts\utility::_ID13189( "boneyard_fire_horizontal_active" );
    common_scripts\utility::_ID13189( "fire_horiz_alarm_on" );
    common_scripts\utility::_ID13189( "fire_horiz_firing" );
}

_ID36802()
{
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = spawnfx( level._ID1644["vfx_horz_fire_red_light"], ( 452, 1596.93, -27.28 ) );
        triggerfx( var_0 );
        thread _ID38006();
        level._ID37206._ID33568 makeusable();
        level._ID37206._ID33568 waittill( "trigger",  var_1  );
        level._ID37206._ID33568 makeunusable();
        thread _ID38007();
        common_scripts\utility::flag_set( "boneyard_fire_horizontal_active" );
        level._ID37206.player = var_1;
        level._ID37206.team = var_1.pers["team"];
        var_0 delete();
        var_2 = spawnfx( level._ID1644["vfx_horz_fire_amber_light"], ( 452, 1596.93, -27.28 ) );
        triggerfx( var_2 );
        common_scripts\utility::flag_set( "fire_horiz_alarm_on" );
        thread _ID37207();
        thread _ID37209();
        wait 4;
        common_scripts\utility::_ID13180( "fire_horiz_alarm_on" );
        _ID37208();
        level._ID37206.player = undefined;
        level._ID37206.team = undefined;
        common_scripts\utility::_ID13180( "boneyard_fire_horizontal_active" );
        wait 30;
        var_2 delete();
    }
}

_ID37208()
{
    level endon( "game_ended" );
    common_scripts\utility::flag_set( "fire_horiz_firing" );
    badplace_brush( "bad_horiz_fire", 10, level._ID37206.dam, "allies", "axis" );

    for ( var_0 = 0; var_0 < 20; var_0++ )
    {
        wait 0.5;
        maps\mp\gametypes\_hostmigration::_ID35770();
        var_1 = level._ID37206.player;

        if ( !isdefined( level._ID37206.player ) || !isplayer( level._ID37206.player ) )
            var_1 = undefined;

        thread maps\mp\mp_boneyard_ns_killstreak::_ID37066( level._ID37206, var_1, 25 );
        thread maps\mp\mp_boneyard_ns_killstreak::_ID37067( level._ID37206, var_1, level._ID25810, 50 );
        thread maps\mp\mp_boneyard_ns_killstreak::_ID37067( level._ID37206, var_1, level.placedims, 50 );
        thread maps\mp\mp_boneyard_ns_killstreak::_ID37067( level._ID37206, var_1, level._ID34657, 50 );
        thread maps\mp\mp_boneyard_ns_killstreak::_ID37067( level._ID37206, var_1, level._ID34099, 50 );
        thread maps\mp\mp_boneyard_ns_killstreak::_ID37067( level._ID37206, var_1, level.balldrones, 50 );
        thread maps\mp\mp_boneyard_ns_killstreak::_ID37067( level._ID37206, var_1, level._ID21075, 50 );
        thread maps\mp\mp_boneyard_ns_killstreak::_ID37067( level._ID37206, var_1, level._ID9646["deployable_vest"], 50 );
        thread maps\mp\mp_boneyard_ns_killstreak::_ID37067( level._ID37206, var_1, level._ID9646["deployable_ammo"], 50 );
    }

    common_scripts\utility::_ID13180( "fire_horiz_firing" );
}

_ID37207()
{
    level._ID36683 playsound( "mp_boneyard_cc_rockettestinitiatingin" );

    while ( common_scripts\utility::_ID13177( "fire_horiz_alarm_on" ) )
    {
        level._ID36681 playsound( "emt_boneyard_ns_close_alarm_02" );
        level._ID36682 playsound( "emt_boneyard_ns_close_alarm_02" );
        wait 0.871;
    }
}

_ID37209()
{
    _ID37722( 66 );
    wait 4;

    for ( var_0 = 0; var_0 < 5; var_0++ )
    {
        _ID37722( 67 );
        wait 2;
    }

    _ID37722( 68 );
}

_ID38006()
{
    if ( !isdefined( level._ID36991 ) )
        level._ID36991 = spawn( "script_origin", ( 450, 1590.25, -26 ) );

    level._ID36991 playloopsound( "emt_boneyard_ns_console_beep_01" );
}

_ID38007()
{
    level._ID36991 stoploopsound( "emt_boneyard_ns_console_beep_01" );
    _ID38005();
}

_ID38005()
{
    level._ID36991 playsound( "scn_boneyard_ns_console_press" );
    thread sound_fire_event_logic();
    wait 0.1;
    level._ID36991 playsound( "emt_boneyard_ns_console_beep_02" );
}

sound_fire_event_logic()
{
    level._ID37203 playsound( "scn_fire_event_01" );
    level._ID37204 playsound( "scn_fire_event_01_b" );
    wait 3.8;
    level.fire_event_a2 playsound( "scn_fire_event_01p2" );
    level.fire_event_lpstart playsound( "scn_fire_event_01_lpstart" );
    wait 1.5;
    level.fire_event_lp playloopsound( "scn_fire_event_01_lp" );
    wait 8;
    level.fire_event_a3 playsound( "scn_fire_event_01p3" );
    level.fire_event_b2 playsound( "scn_fire_event_01_bp2" );
    level.fire_event_lpstop playsound( "scn_fire_event_01_lpstop" );
    level.fire_event_lp stoploopsound();
}
