// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_chasm_precache::_ID20445();
    maps\createart\mp_chasm_art::_ID20445();
    maps\mp\mp_chasm_fx::_ID20445();
    level thread maps\mp\_movers::_ID20445();
    maps\mp\_movers::script_mover_add_parameters( "falling_elevator", "delay_till_trigger=1" );
    maps\mp\_movers::script_mover_add_parameters( "falling_elevator_cables", "delay_till_trigger=1" );
    maps\mp\_movers::script_mover_add_parameters( "elevator_drop_1", "move_time=.7;accel_time=.7" );
    maps\mp\_movers::script_mover_add_parameters( "elevator_drop_2", "move_time=1.2;accel_time=1.2;name=elevator_end" );
    maps\mp\_load::_ID20445();
    thread maps\mp\_fx::_ID13742();
    maps\mp\_compass::_ID29184( "compass_map_mp_chasm" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 2.5, 5 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";

    if ( level._ID14086 == "sd" || level._ID14086 == "sr" )
    {
        level._ID38116 = [];
        level._ID38116["_b"] = ( 384, 278, 1716 );
    }

    level thread _ID12748();
    level thread _ID29166();
    level thread _ID37490();
}

_ID37490()
{
    var_0 = spawn( "trigger_radius", ( -2304, -3072, 512 ), 0, 1024, 2048 );
    var_0.radius = 1024;
    var_0.height = 2048;
    var_0.angles = ( 0, 0, 0 );
    var_0.targetname = "remote_heli_range";
    var_1 = getent( "clip256x256x8", "targetname" );
    var_2 = spawn( "script_model", ( -1216, 2112, 1376 ) );
    var_2.angles = ( 0, 0, 0 );
    var_2 clonebrushmodeltoscriptmodel( var_1 );
    var_3 = spawn( "script_model", ( -2304, -936, 1492 ) );
    var_3 setmodel( "placeable_barrier" );
    var_3.angles = ( 0, 0, 12 );
    var_4 = getent( "clip32x32x32", "targetname" );
    var_5 = spawn( "script_model", ( -1438, -1424, 1030 ) );
    var_5.angles = ( 0, 0, 0 );
    var_5 clonebrushmodeltoscriptmodel( var_4 );
}

_ID29166()
{
    var_0 = getent( "falling_bus", "targetname" );
    var_1 = getent( "bus_collision", "targetname" );
    var_0.collision = var_1;
    var_2 = getentarray( "falling_bus_parts", "targetname" );

    foreach ( var_4 in var_2 )
        var_4 linkto( var_0 );

    var_0._ID34249 = maps\mp\_movers::_ID34255;
    var_0 thread explosive_damage_watch( var_0, "bus_start_fall" );

    if ( isdefined( var_1 ) )
    {
        var_1 linkto( var_0 );
        var_0 thread explosive_damage_watch( var_1, "bus_start_fall" );
    }

    var_6 = var_0;
    var_6._ID19112 = [];
    var_7 = var_6.target;
    var_8 = 0;

    while ( isdefined( var_7 ) )
    {
        var_9 = common_scripts\utility::_ID15384( var_7, "targetname" );

        if ( isdefined( var_9 ) )
        {
            var_6._ID19112[var_8] = var_9;
            var_8++;
            var_7 = var_9.target;
            continue;
        }

        break;
    }

    if ( var_6._ID19112.size > 2 )
    {
        var_6._ID19112[1]._ID27550 = 0.75;
        var_6._ID19112[1]._ID27417 = 0.75;
        var_6._ID19112[1]._ID27516 = 0;
        var_6._ID19112[1].shakemag = 0.5;
        var_6._ID19112[1]._ID29652 = 1.5;
        var_6._ID19112[1]._ID29651 = 1000;
        var_6._ID19112[2]._ID27550 = 4.0;
        var_6._ID19112[2]._ID27417 = 0.0;
        var_6._ID19112[2]._ID27516 = 0;
    }

    var_0._ID23338 = getent( "pathBlocker", "targetname" );
    wait 0.05;
    var_0._ID23338 elevatorclearpath();
    var_0 thread _ID21655( "bus_start_fall" );
}

_ID21655( var_0 )
{
    level endon( "game_ended" );
    self waittill( var_0,  var_1  );
    self playsound( "scn_bus_groan" );
    self._ID23338 elevatorblockpath();
    _ID6340();
    self.collision killlinkedentities( var_1 );

    for ( var_2 = 1; var_2 < self._ID19112.size; var_2++ )
    {
        var_3 = self._ID19112[var_2];
        self moveto( var_3.origin, var_3._ID27550, var_3._ID27417, var_3._ID27516 );
        self rotateto( var_3.angles, var_3._ID27550, var_3._ID27417, var_3._ID27516 );

        if ( isdefined( var_3.shakemag ) )
            earthquake( var_3.shakemag, var_3._ID29652, self.origin, var_3._ID29651 );

        self waittill( "movedone" );
    }

    var_4 = self.origin + ( 0, 0, 2000 );
    earthquake( 0.25, 0.5, var_4, 3000 );
    stopfxontag( common_scripts\utility::_ID15033( "vfx_bus_fall_dust" ), self.busdust, "tag_origin" );
    self.busdust delete();
    playsoundatpos( var_4, "scn_bus_crash" );
}

_ID6340()
{
    var_0 = getent( "busDustEffect2", "targetname" );
    var_0 setmodel( "tag_origin" );
    var_0 linkto( self );
    playfxontag( common_scripts\utility::_ID15033( "vfx_bus_fall_dust" ), var_0, "tag_origin" );
    self.busdust = var_0;
    var_1 = getent( "busDustEffect", "targetname" );

    if ( isdefined( var_1 ) )
    {
        playfx( common_scripts\utility::_ID15033( "vfx_bus_scrape_dust" ), var_1.origin, anglestoforward( var_1.angles ) );
        var_1 playsound( "scn_bus_slide" );
        return;
    }
}

killlinkedentities( var_0 )
{
    var_1 = self getlinkedchildren();

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3.owner ) )
            var_3 dodamage( 1000, self.origin, var_0, self, "MOD_CRUSH" );
    }
}

_ID12748()
{
    var_0 = getent( "falling_elevator", "targetname" );
    var_1 = getent( "falling_elevator_cables", "targetname" );
    var_2 = getent( "elevatorBlockPaths1", "targetname" );
    var_2 elevatorblockpath();

    if ( !isdefined( var_0 ) || !isdefined( var_1 ) )
        return;

    while ( !isdefined( var_0.linked_ents ) )
        wait 0.05;

    var_0.state = 1;
    var_0 thread _ID12749( var_1 );
    var_0 thread explosive_damage_watch( var_0, "next_stage" );

    foreach ( var_4 in var_0.linked_ents )
        var_0 thread explosive_damage_watch( var_4, "next_stage" );

    var_6 = var_1.origin;
    wait 0.05;
    var_7 = getent( "elevatorBlockPaths2", "targetname" );
    var_7 elevatorclearpath();
    var_7 setcontents( 0 );
    var_0.dusteffect = getentarray( "dustEffect", "targetname" );

    foreach ( var_4 in var_0.dusteffect )
        var_4 linkto( var_1 );

    var_0._ID30541 = getentarray( "sparkEffect", "targetname" );

    foreach ( var_4 in var_0._ID30541 )
        var_4 linkto( var_1 );

    for (;;)
    {
        var_0 waittill( "next_stage",  var_12  );

        if ( var_0.moving )
            continue;

        var_0.state++;
        var_0 notify( "trigger" );

        if ( isdefined( var_1 ) )
            var_1 notify( "trigger" );

        if ( var_0.state == 2 )
        {
            var_0 playsoundonmovingent( "scn_elevator_fall_move" );
            var_1 notify( "stop_watching_cable" );
            var_2 elevatorclearpath();
            var_2 setcontents( 0 );

            foreach ( var_4 in var_0.dusteffect )
                playfx( common_scripts\utility::_ID15033( "vfx_elevator_fall_dust" ), var_4.origin );
        }
        else if ( var_0.state == 3 )
        {
            playsoundatpos( var_6, "scn_elevator_fall_cable_snap" );
            var_7 setcontents( 1 );
            var_7 elevatorblockpath();

            foreach ( var_4 in var_0._ID30541 )
                playfx( common_scripts\utility::_ID15033( "vfx_spark_drip_child" ), var_4.origin );

            var_0 killlinkedentities( var_12 );
        }

        var_0 waittill( "move_end" );

        if ( var_0.state == 2 )
        {
            playsoundatpos( var_6, "scn_elevator_fall_cable_stress" );
            playfx( common_scripts\utility::_ID15033( "vfx_elevator_shaft_dust" ), var_0.origin );
            earthquake( 0.5, 1.5, var_0.origin, 1000 );
            continue;
        }

        if ( var_0.state == 3 )
        {
            var_0 playsoundonmovingent( "scn_elevator_fall_crash" );
            earthquake( 0.75, 1.5, var_0.origin, 1000 );
            var_2 setcontents( 1 );
            var_2 elevatorblockpath();
        }
    }
}

explosive_damage_watch( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "explosive_damage";

    var_0 setcandamage( 1 );

    for (;;)
    {
        var_0.health = 1000000;
        var_0 waittill( "damage",  var_2, var_3, var_4, var_5, var_6  );

        if ( !_ID18413( var_6 ) )
            continue;

        self notify( var_1,  var_3  );
    }
}

_ID12749( var_0 )
{
    var_0 endon( "stop_watching_cable" );
    var_1 = 1000000;
    var_0 setcandamage( 1 );
    var_0.health = var_1;
    var_0._ID12656 = 50;

    for (;;)
    {
        var_0 waittill( "damage",  var_2, var_3, var_4, var_5, var_6  );

        if ( var_0.moving || self.state == 2 && !_ID18413( var_6 ) )
        {
            var_0.health = var_0.health + var_2;
            continue;
        }

        if ( var_0.health > var_1 - var_0._ID12656 )
            continue;

        self notify( "next_stage" );
        break;
    }
}

_ID18413( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    var_0 = tolower( var_0 );

    switch ( var_0 )
    {
        case "mod_grenade_splash":
        case "mod_projectile_splash":
        case "mod_explosive":
        case "splash":
            return 1;
        default:
            return 0;
    }

    return 0;
}

elevatorclearpath()
{
    self connectpaths();
    self hide();
}

elevatorblockpath()
{
    self show();
    self disconnectpaths();
}
