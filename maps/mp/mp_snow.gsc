// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_snow_precache::_ID20445();
    maps\createart\mp_snow_art::_ID20445();
    maps\mp\mp_snow_fx::_ID20445();
    thread maps\mp\_fx::_ID13742();
    common_scripts\utility::_ID13189( "satellite_crashed" );
    common_scripts\utility::_ID13189( "satellite_incoming" );
    level._ID30322 = maps\mp\_utility::allowlevelkillstreaks();
    level thread _ID27217();
    _ID24833();
    level._ID20636 = ::_ID30325;
    level.mapcustomkillstreakfunc = ::_ID30326;
    level._ID20635 = ::_ID30324;
    maps\mp\_load::_ID20445();
    precacheshader( "fullscreen_dirtylense" );
    maps\mp\_compass::_ID29184( "compass_map_mp_snow" );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 2.3, 10 );
    maps\mp\_utility::_ID28710( "r_diffuseColorScale", 1.2, 3 );
    setdvar( "r_ssaorejectdepth", 1500 );
    setdvar( "r_ssaofadedepth", 1200 );
    setdvar( "r_sky_fog_intensity", "1" );
    setdvar( "r_sky_fog_min_angle", "74.6766" );
    setdvar( "r_sky_fog_max_angle", "91.2327" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );

    if ( level._ID25139 )
        setdvar( "sm_sunShadowScale", "0.6" );
    else if ( level._ID36452 )
        setdvar( "sm_sunShadowScale", "0.7" );

    game["attackers"] = "allies";
    game["defenders"] = "axis";
    common_scripts\utility::_ID13189( "satellite_active" );
    common_scripts\utility::_ID13189( "satellite_charged" );
    level thread lighthouse();
    level thread _ID30328();
    common_scripts\utility::_ID35582();
    level thread group_anim( "buoy", "mp_snow_buoy_sway", 0.2, 1.0 );
    level thread group_anim( "boat", "mp_snow_boat_sway", 0.2, 1.0 );
    level thread _ID13170();
    level thread rotate_helicopter_rotor();
    level thread _ID17303();
    level thread _ID37490();
}

_ID37490()
{
    var_0 = getent( "player32x32x8", "targetname" );
    var_1 = spawn( "script_model", ( -1646.94, 881.505, -2.82839 ) );
    var_1.angles = ( 270, 211.182, 123.817 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
    var_2 = getent( "clip64x64x128", "targetname" );
    var_3 = spawn( "script_model", ( 245, 2512, -64 ) );
    var_3.angles = ( 0, 0, 0 );
    var_3 clonebrushmodeltoscriptmodel( var_2 );
    var_4 = getent( "clip256x256x128", "targetname" );
    var_5 = spawn( "script_model", ( -1536, -1312, -136 ) );
    var_5.angles = ( 0, 0, 0 );
    var_5 clonebrushmodeltoscriptmodel( var_4 );
    var_6 = getent( "clip256x256x128", "targetname" );
    var_7 = spawn( "script_model", ( -1484, -1440, -136 ) );
    var_7.angles = ( 0, 45, 0 );
    var_7 clonebrushmodeltoscriptmodel( var_6 );

    if ( maps\mp\_utility::_ID18422() )
    {
        var_8 = getent( "player64x64x128", "targetname" );
        var_9 = spawn( "script_model", ( -1474, 966, -136 ) );
        var_9.angles = ( 0, 352, 0 );
        var_9 clonebrushmodeltoscriptmodel( var_8 );
        var_10 = getent( "clip128x128x8", "targetname" );
        var_11 = spawn( "script_model", ( 1700, 872, -48 ) );
        var_11.angles = ( 0, 335, 0 );
        var_11 clonebrushmodeltoscriptmodel( var_10 );
    }
}

_ID13170()
{
    var_0 = getentarray( "fishing_boat", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = spawn( "script_model", var_2.origin );
        var_3.angles = ( 0, 0, 0 );
        var_3 setmodel( "generic_prop_raven" );
        var_2 linkto( var_3, "tag_origin" );
        var_3 scriptmodelplayanimdeltamotion( "mp_snow_fishingboat_sway_prop" );
        var_4 = getent( var_2.target, "targetname" );

        if ( isdefined( var_4 ) )
        {
            var_4 linkto( var_3, "tag_origin" );
            var_4 scriptmodelplayanimdeltamotion( "mp_snow_fishingboat_sway" );
        }

        var_2._ID22054 = 1;
    }
}

lighthouse()
{
    var_0 = getent( "lighthouse", "targetname" );
    var_1 = spawn( "script_model", var_0.origin );
    var_1.angles = var_0.angles;
    var_1 setmodel( "generic_prop_raven" );
    var_0 linkto( var_1, "j_prop_1" );
    var_1 scriptmodelplayanimdeltamotion( "mp_snow_lighthouse_scan" );
    var_2 = spawn( "script_model", var_0.origin + ( 0, 0, 70 ) );
    var_2.angles = var_0.angles;
    var_2 setmodel( "tag_origin" );
    var_2 linkto( var_1, "j_prop_1" );
    var_0._ID13826 = var_2;
    level thread _ID19965( var_0 );
}

_ID30328()
{
    var_0 = getscriptablearray( "snowman", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread _ID30327();
}

_ID30327()
{
    self waittill( "death" );
    maps\mp\_movers::notify_moving_platform_invalid();
}

_ID19965( var_0 )
{
    for (;;)
    {
        level waittill( "connected",  var_1  );
        playfxontagforclients( level._ID1644["mp_snow_lighthouse"], var_0._ID13826, "tag_origin", var_1 );
    }
}

_ID24833()
{
    precachempanim( "mp_snow_boat_sway" );
    precachempanim( "mp_snow_buoy_sway" );
    precachempanim( "mp_snow_fishingboat_sway" );
    precachempanim( "mp_snow_fishingboat_sway_prop" );
    precachempanim( "mp_snow_tree_fall" );
    precachempanim( "mp_snow_tree_prefall_loop" );
}

is_dynamic_path()
{
    return isdefined( self.spawnflags ) && self.spawnflags & 1;
}

_ID18359()
{
    return isdefined( self.spawnflags ) && self.spawnflags & 2;
}

_ID27217()
{
    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
        return;

    if ( level._ID30322 )
        level thread play_satellite_static_on_connect();

    common_scripts\utility::_ID35582();
    var_0 = getent( "tree_broken_stump", "targetname" );
    var_1 = getent( "tree_broken_top", "targetname" );
    var_2 = spawn( "script_model", var_0.origin );
    var_2.angles = ( 0, 0, 0 );
    var_2 setmodel( "generic_prop_raven" );
    var_2 scriptmodelplayanimdeltamotion( "mp_snow_tree_prefall_loop" );
    var_0 linkto( var_2, "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_1 linkto( var_2, "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_3 = _ID27220( "satellite_pre_crash" );
    var_4 = _ID27220( "satellite_post_crash" );

    if ( !isdefined( var_3 ) || !isdefined( var_4 ) )
        return;

    var_4 satellite_group_hide();

    if ( !level._ID30322 )
    {
        _ID27231( var_3, var_4 );
        return;
    }

    var_5 = getent( "satellite_flash_trigger", "targetname" );
    var_6 = getent( "satellite_kill_trigger", "targetname" );
    var_7 = common_scripts\utility::_ID15384( "sat_start", "targetname" );
    var_8 = getent( "sat_start_kill_trigger", "targetname" );

    if ( isdefined( var_8 ) )
    {
        var_8._ID31346 = var_8.origin;
        var_8._ID31218 = var_8.angles;
        var_8 enablelinkto();
    }

    if ( level._ID8425 )
    {
        while ( !isdefined( level.player ) )
            common_scripts\utility::_ID35582();

        level.players = [ level.player ];
        level.characters = [];
    }
    else
        maps\mp\_utility::gameflagwait( "prematch_done" );

    for (;;)
    {
        var_9 = spawn( "script_model", var_7.origin );
        var_9.angles = var_7.angles;
        var_9 setmodel( "tag_origin" );
        var_10 = _ID27224();
        var_11 = undefined;

        if ( isdefined( var_10 ) )
            var_11 = var_10.team;

        common_scripts\utility::flag_set( "satellite_incoming" );
        wait 0.5;
        var_12 = 2000;

        if ( isdefined( var_8 ) )
        {
            var_8 linkto( var_9 );
            var_8 thread monitor_touching();
        }

        level thread _ID23831( var_9 );
        var_9 playsoundonmovingent( "scn_satellite_entry" );
        var_13 = var_7;

        for ( var_14 = 0; isdefined( var_13.target ); var_13 = var_15 )
        {
            var_14++;
            var_15 = common_scripts\utility::_ID15384( var_13.target, "targetname" );
            var_16 = distance( var_13.origin, var_15.origin );
            var_17 = var_16 / var_12;
            var_9 moveto( var_15.origin, var_17 );
            level._ID27208 = var_9;

            if ( var_14 == 1 )
                var_9 rotatevelocity( ( -360, 0, 0 ), var_17 );
            else
                var_9 rotatevelocity( ( 0, 1500, 1500 ), var_17 );

            var_9 waittill( "movedone" );

            if ( var_14 == 1 )
            {
                var_2 scriptmodelclearanim();
                var_2 scriptmodelplayanim( "mp_snow_tree_fall" );
                common_scripts\utility::exploder( "2" );

                foreach ( var_19 in level.players )
                    var_19 playrumbleonentity( "artillery_rumble" );

                var_9 playsound( "scn_satellite_skip" );
                continue;
            }

            common_scripts\utility::_ID13180( "satellite_incoming" );
            _ID27218( var_9.origin, 2000, 0, var_5 );
            earthquake( 0.5, 3, var_9.origin, 2000 );
            playfx( level._ID1644["satellite_fall_impact"], var_9.origin );

            while ( level._ID17628 )
                common_scripts\utility::_ID35582();

            foreach ( var_22 in level.characters )
            {
                if ( var_22 istouching( var_6 ) )
                {
                    if ( isdefined( var_10 ) && ( !level._ID32653 || var_22.team != var_11 ) )
                    {
                        var_22 dodamage( var_22.health + 1000, var_22.origin, var_10, var_9, "MOD_EXPLOSIVE" );
                        continue;
                    }

                    var_22 maps\mp\_movers::mover_suicide();
                }
            }

            if ( isdefined( level._ID20086 ) )
            {
                foreach ( var_25 in level._ID20086 )
                {
                    if ( var_25 istouching( var_6 ) )
                        var_25 notify( "death" );
                }
            }

            var_9 playsound( "scn_satellite_impact" );
            common_scripts\utility::_ID35582();
            _ID27231( var_3, var_4 );
        }

        if ( isdefined( var_8 ) )
        {
            var_8 unlink();
            var_8.origin = var_8._ID31346;
            var_8.angles = var_8._ID31218;
        }

        var_9 delete();

        if ( !maps\mp\_utility::levelflag( "post_game_level_event_active" ) )
        {
            if ( !level._ID32653 && !isdefined( var_10 ) )
                continue;

            var_27 = common_scripts\utility::_ID15384( "satellite_use_loc", "targetname" );
            var_28 = spawn( "script_origin", var_27.origin );
            var_28.angles = ( 0, 0, 0 );
            var_28.owner = var_10;
            var_28.team = var_11;
            var_28._ID17429 = 0;

            if ( isdefined( var_10 ) )
                var_28 setotherent( var_10 );

            maps\mp\killstreaks\_uplink::adduplinktolevellist( var_28 );
            var_29 = 0;

            if ( !var_29 )
                break;
        }
    }
}

monitor_touching()
{
    level endon( "satellite_crashed" );

    for (;;)
    {
        if ( isdefined( level._ID20086 ) )
        {
            if ( level._ID20086.size > 0 )
            {
                foreach ( var_1 in level._ID20086 )
                {
                    if ( var_1 istouching( self ) )
                        var_1 notify( "death" );
                }
            }
        }

        common_scripts\utility::_ID35582();
    }
}

_ID27231( var_0, var_1 )
{
    common_scripts\utility::flag_set( "satellite_crashed" );

    foreach ( var_3 in level.players )
        var_3 thread play_exploder_when_not_in_killcam();

    var_0 satellite_group_hide();
    var_1 _ID27222();
    level thread _ID23740();
}

play_exploder_when_not_in_killcam()
{
    self endon( "disconnect" );

    while ( maps\mp\_utility::_ID18658() )
        common_scripts\utility::_ID35582();

    common_scripts\utility::exploder( "32", self );
}

_ID27218( var_0, var_1, var_2, var_3 )
{
    foreach ( var_5 in level.players )
    {
        var_6 = var_5 geteye();
        var_7 = var_0 - var_6;
        var_8 = length( var_7 );

        if ( var_8 > var_1 )
            continue;

        var_7 = vectornormalize( var_7 );
        var_9 = anglestoforward( var_5 getplayerangles() );
        var_10 = vectordot( var_9, var_7 );

        if ( var_10 < var_2 )
            continue;

        if ( isdefined( var_3 ) )
        {
            if ( !var_5 istouching( var_3 ) )
                continue;
        }

        var_5 shellshock( "flashbang_mp", max( 2.0, 4 * ( 1 - var_8 / var_1 ) ) );
    }
}

satellite_group_hide()
{
    if ( isdefined( self.satellite_group_hide ) && self.satellite_group_hide )
        return;

    self.satellite_group_hide = 1;
    self.origin = self.origin - ( 0, 0, 1000 );

    foreach ( var_1 in self._ID7525 )
        var_1 _ID27211();

    self dontinterpolate();
}

_ID27211()
{
    if ( is_dynamic_path() )
        self connectpaths();

    if ( _ID18359() )
        self setaisightlinevisible( 0 );

    maps\mp\_movers::notify_moving_platform_invalid();
    self._ID22672 = self setcontents( 0 );
    self notsolid();
    self hide();
}

_ID27222()
{
    if ( isdefined( self.satellite_group_hide ) && !self.satellite_group_hide )
        return;

    self.satellite_group_hide = 0;
    self.origin = self.origin + ( 0, 0, 1000 );

    foreach ( var_1 in self._ID7525 )
        var_1 _ID27212();

    self dontinterpolate();
}

_ID27212()
{
    self solid();
    self setcontents( self._ID22672 );
    self show();

    if ( is_dynamic_path() )
        self disconnectpaths();

    if ( _ID18359() )
        self setaisightlinevisible( 1 );
}

_ID27220( var_0 )
{
    var_1 = common_scripts\utility::_ID15384( var_0, "targetname" );

    if ( !isdefined( var_1 ) )
        return undefined;

    var_2 = spawn( "script_model", var_1.origin );
    var_2 setmodel( "tag_origin" );
    var_2._ID7525 = [];
    var_2.linked = [];
    var_3 = getentarray( var_1.target, "targetname" );

    foreach ( var_5 in var_3 )
    {
        if ( var_5.classname == "script_brushmodel" )
        {
            var_2._ID7525[var_2._ID7525.size] = var_5;
            continue;
        }

        var_2.linked[var_2.linked.size] = var_5;
        var_5 linkto( var_2 );
    }

    return var_2;
}

_ID27224()
{
    level thread _ID27209();
    level thread _ID27223();
    level waittill( "satellite_start",  var_0  );
    return var_0;
}

_ID27209()
{
    level endon( "satellite_start" );

    if ( !level._ID30322 )
        return;

    level waittill( "spawning_intermission" );
    level thread _ID27214();
    level notify( "satellite_start" );
}

_ID27214()
{
    maps\mp\_utility::levelflagset( "post_game_level_event_active" );
    visionsetnaked( "", 0.5 );
    wait 15;
    maps\mp\_utility::_ID19892( "post_game_level_event_active" );
}

_ID27223()
{
    level waittill( "snow_satellite_killstreak",  var_0  );
    level notify( "satellite_start",  var_0  );
}

_ID21582( var_0 )
{
    var_1 = self.origin;
    var_2 = 3.0;
    var_3 = 3.0;

    for (;;)
    {
        self moveto( var_0, var_2, var_3, 0 );
        wait(var_2 + 3.0);
        self moveto( var_1, 0.1 );
        wait 0.1;
    }
}

play_satellite_static_on_connect()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread _ID26961( ::_ID27235 );
    }
}

_ID23740()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread _ID26961( ::call_fire_exploder_on_spawn );
    }
}

call_fire_exploder_on_spawn()
{
    self endon( "disconnect" );
    common_scripts\utility::exploder( "32", self );
}

_ID26961( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self waittill( "spawned_player" );
    self thread [[ var_0 ]]();
}

_ID23831( var_0 )
{
    playfxontag( level._ID1644["satellite_fall"], var_0, "tag_origin" );
    playfxontag( level._ID1644["satellite_fall_child0"], var_0, "tag_origin" );
    wait 0.7;
    playfxontag( level._ID1644["satellite_fall_child1"], var_0, "tag_origin" );
    wait 0.7;
    playfxontag( level._ID1644["satellite_fall_child2"], var_0, "tag_origin" );
    wait 0.7;
    playfxontag( level._ID1644["satellite_fall_child3"], var_0, "tag_origin" );
    wait 0.7;
    playfxontag( level._ID1644["satellite_fall_child4"], var_0, "tag_origin" );
    wait 0.7;
    playfxontag( level._ID1644["satellite_fall_child5"], var_0, "tag_origin" );
    wait 0.7;
    playfxontag( level._ID1644["satellite_fall_child6"], var_0, "tag_origin" );
    wait 0.7;
    playfxontag( level._ID1644["satellite_fall_child7"], var_0, "tag_origin" );
    wait 0.7;
    playfxontag( level._ID1644["satellite_fall_child8"], var_0, "tag_origin" );
}

group_anim( var_0, var_1, var_2, var_3 )
{
    var_4 = getentarray( var_0, "targetname" );

    foreach ( var_6 in var_4 )
    {
        if ( isdefined( var_2 ) && isdefined( var_3 ) )
            wait(randomfloatrange( var_2, var_3 ));

        var_7 = spawn( "script_model", var_6.origin );
        var_7.angles = ( 0, 0, 0 );
        var_7 setmodel( "generic_prop_raven" );
        var_6 linkto( var_7, "tag_origin" );
        var_7 scriptmodelplayanimdeltamotion( var_1 );

        if ( isdefined( var_6.target ) )
        {
            var_8 = getentarray( var_6.target, "targetname" );

            foreach ( var_10 in var_8 )
                var_10 linkto( var_7, "j_prop_1" );
        }
    }
}

_ID26751()
{
    var_0 = getentarray( "rotating_window", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::_ID26752 );
}

_ID26752()
{
    if ( !isdefined( self.target ) )
        return;

    var_0 = common_scripts\utility::_ID15386( self.target, "targetname" );

    foreach ( var_2 in var_0 )
    {
        switch ( var_2.script_noteworthy )
        {
            case "open_angles":
                self.open_angles = var_2.angles;
                continue;
            case "closed_angles":
                self.closed_angles = var_2.angles;
                continue;
            default:
                continue;
        }
    }

    var_4 = getentarray( self.target, "targetname" );
    self._ID16894 = [];

    foreach ( var_6 in var_4 )
    {
        switch ( var_6.script_noteworthy )
        {
            case "open_trigger":
                self._ID22946 = var_6;
                continue;
            case "close_trigger":
                self._ID7562 = var_6;
                continue;
            case "hide_when_closed":
                self._ID16894[self._ID16894.size] = var_6;
                continue;
            default:
                continue;
        }
    }

    self setcandamage( 0 );
    thread _ID26753();
}

_ID26753()
{
    var_0 = spawn( "script_model", self.origin );
    var_0.angles = self.open_angles;
    var_0 setmodel( "tag_origin" );
    self linkto( var_0, "tag_origin" );
    var_1 = 0;

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "start_closed" )
    {
        var_1 = 1;
        self._ID22946 common_scripts\utility::_ID33657();

        foreach ( var_3 in self._ID16894 )
            var_3 hide();
    }
    else
    {
        self._ID7562 common_scripts\utility::_ID33657();

        foreach ( var_3 in self._ID16894 )
            var_3 show();
    }

    var_7 = angleclamp( self.closed_angles[0] - self.open_angles[0] );

    for (;;)
    {
        if ( var_1 )
            var_1 = 0;
        else
        {
            self._ID22946 common_scripts\utility::_ID33657();
            self._ID7562 common_scripts\utility::_ID33659();
            self._ID7562 waittill( "trigger" );

            foreach ( var_3 in self._ID16894 )
                var_3 hide();

            var_0 rotatepitch( var_7, 0.3, 0, 0 );
            wait 1;
        }

        self._ID22946 common_scripts\utility::_ID33659();
        self._ID7562 common_scripts\utility::_ID33657();
        self._ID22946 waittill( "trigger" );
        var_0 rotatepitch( -1 * var_7, 0.3, 0, 0 );
        wait 0.3;

        foreach ( var_3 in self._ID16894 )
            var_3 show();

        wait 0.7;
    }
}

_ID27229()
{
    var_0 = common_scripts\utility::_ID15384( "satellite_use_loc", "targetname" );
    var_1 = spawn( "script_model", var_0.origin );
    var_1.angles = var_0.angles;
    var_1 makescrambler( self );
}

rotate_helicopter_rotor()
{
    var_0 = getent( "heli_rotor_top", "targetname" );
    var_0 rotatevelocity( ( 0, -300, 0 ), 36000, 0, 0 );
    var_1 = getent( "heli_rotor_back", "targetname" );

    if ( isdefined( var_1 ) )
        var_1 rotatevelocity( ( -300, 0, 0 ), 36000, 0, 0 );
}

_ID27235()
{
    self endon( "disconnect" );
    var_0 = common_scripts\utility::_ID15384( "satellite_use_loc", "targetname" );
    maps\mp\killstreaks\_unk1534::_ID31521();
    var_1 = 512;
    var_2 = var_1 * var_1;

    for (;;)
    {
        var_3 = length2dsquared( self.origin - var_0.origin ) < var_2;

        if ( var_3 && common_scripts\utility::_ID13177( "satellite_crashed" ) )
            maps\mp\killstreaks\_unk1534::_ID31522( 1 );
        else
            maps\mp\killstreaks\_unk1534::_ID31522( 0 );

        wait 0.5;
    }
}

_ID27236()
{
    level common_scripts\utility::_ID35663( "emp_update" );
}

_ID17303()
{
    var_0 = getentarray( "ice", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::_ID17314 );
}

_ID17314()
{
    self._ID31346 = self.origin;
    self.anim_ref = self;
    var_0 = getentarray( self.target, "targetname" );

    foreach ( var_2 in var_0 )
    {
        switch ( var_2.script_noteworthy )
        {
            case "border":
                self.border = var_2;
                continue;
            case "trigger_sink":
                self.trigger = var_2;
                self.trigger enablelinkto();
                self.trigger linkto( self );
                continue;
            default:
                continue;
        }
    }

    thread _ID17311();
}

_ID17311()
{
    self setcandamage( 1 );
    self.health = 30;

    for (;;)
    {
        self waittill( "damage" );

        if ( self.health <= 0 )
            break;
    }

    if ( isdefined( self._ID27611 ) )
        common_scripts\utility::exploder( self._ID27611 );

    self playsound( "pond_ice_crack" );
    self.border delete();
    thread _ID17313();
    thread _ID17315();
    thread _ID17316();
}

_ID17313()
{
    var_0 = 0;

    for (;;)
    {
        var_1 = randomfloatrange( 3, 5 );
        var_2 = ( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) );
        var_2 = vectornormalize( var_2 );
        var_2 *= 3;

        if ( var_0 <= 2 )
        {
            var_2 *= ( 3 - var_0 );
            var_1 /= ( 3 - var_0 );
        }

        self rotateto( var_2, var_1 );
        self waittill( "rotatedone" );
        var_0++;
    }
}

_ID17315()
{
    self._ID30053 = 0;

    for (;;)
    {
        self.trigger waittill( "trigger" );
        self._ID30053 = gettime() + 200;
    }
}

_ID17316()
{
    var_0 = 40;
    var_1 = 20;
    var_2 = self._ID31346;
    var_3 = var_2 - ( 0, 0, 100 );

    for (;;)
    {
        while ( self._ID30053 < gettime() )
            common_scripts\utility::_ID35582();

        var_4 = distance( self.origin, var_3 );
        var_5 = var_4 / var_0;
        self.anim_ref moveto( var_3, var_5 );

        while ( self._ID30053 >= gettime() )
            common_scripts\utility::_ID35582();

        var_4 = distance( self.origin, var_2 );
        var_5 = var_4 / var_1;
        self.anim_ref moveto( var_2, var_5, 0, var_5 );
    }
}

_ID35496( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = var_0;

    maps\mp\_utility::gameflagwait( "prematch_done" );

    if ( !isdefined( level._ID31480 ) )
        return;

    var_2 = maps\mp\_utility::getscorelimit();
    var_3 = maps\mp\_utility::_ID15434() * 60;
    var_4 = 0;
    var_5 = 0;

    if ( var_2 <= 0 && var_3 <= 0 )
    {
        var_4 = 1;
        var_3 = 600;
    }
    else if ( var_2 <= 0 )
        var_4 = 1;
    else if ( var_3 <= 0 )
        var_5 = 1;

    var_6 = var_0 * var_3;
    var_7 = var_1 * var_2;
    var_8 = _ID14496();
    var_9 = ( gettime() - level._ID31480 ) / 1000;

    if ( var_4 )
    {
        while ( var_9 < var_6 )
        {
            wait 0.5;
            var_9 = ( gettime() - level._ID31480 ) / 1000;
        }
    }
    else if ( var_5 )
    {
        while ( var_8 < var_7 )
        {
            wait 0.5;
            var_8 = _ID14496();
        }
    }
    else
    {
        while ( var_9 < var_6 && var_8 < var_7 )
        {
            wait 0.5;
            var_8 = _ID14496();
            var_9 = ( gettime() - level._ID31480 ) / 1000;
        }
    }
}

_ID14496()
{
    var_0 = 0;

    if ( level._ID32653 )
    {
        if ( isdefined( game["teamScores"] ) )
        {
            var_0 = game["teamScores"]["allies"];

            if ( game["teamScores"]["axis"] > var_0 )
                var_0 = game["teamScores"]["axis"];
        }
    }
    else if ( isdefined( level.players ) )
    {
        foreach ( var_2 in level.players )
        {
            if ( isdefined( var_2.score ) && var_2.score > var_0 )
                var_0 = var_2.score;
        }
    }

    return var_0;
}

_ID30325()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    if ( !level._ID30322 || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "snow_satellite", 55, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"KILLSTREAKS_HINTS_SNOW_SATELLITE" );
    level thread _ID35971();
}

_ID35971()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "snow_satellite" )
        {
            _ID10110();
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "snow_satellite", 55 );
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

_ID10110()
{
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "snow_satellite", 0 );
}

_ID30326()
{
    level._ID19256["snow_satellite"] = ::_ID33874;
    level._ID19276["snow_satellite_mp"] = "snow_satellite";
}

_ID30324()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "snow_satellite", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

_ID33874( var_0, var_1 )
{
    game["player_holding_level_killstrek"] = 0;
    level notify( "snow_satellite_killstreak",  self  );
    return 1;
}
