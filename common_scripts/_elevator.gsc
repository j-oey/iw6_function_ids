// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    if ( getdvar( "scr_elevator_disabled" ) == "1" )
        return;

    var_0 = getentarray( "elevator_group", "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    if ( !var_0.size )
        return;

    precachestring( &"ELEVATOR_CALL_HINT" );
    precachestring( &"ELEVATOR_USE_HINT" );
    precachestring( &"ELEVATOR_FLOOR_SELECT_HINT" );
    precachemenu( "elevator_floor_selector" );
    thread elevator_update_global_dvars();
    level.elevators = [];
    level._ID11286 = _ID11297( "scr_elevator_callbutton_link_v", "96" );
    level.elevator_callbutton_link_h = _ID11297( "scr_elevator_callbutton_link_h", "256" );
    build_elevators();
    _ID24754();
    elevator_call();

    if ( !level.elevators.size )
        return;

    foreach ( var_2 in level.elevators )
    {
        var_2 thread elevator_think();
        var_2 thread elevator_sound_think();
    }

    thread elevator_debug();
}

elevator_update_global_dvars()
{
    for (;;)
    {
        level.elevator_accel = _ID11296( "scr_elevator_accel", "0.2" );
        level._ID11289 = _ID11296( "scr_elevator_decel", "0.2" );
        level._ID11307 = _ID11297( "scr_elevator_music", "1" );
        level._ID11316 = _ID11297( "scr_elevator_speed", "96" );
        level._ID11300 = _ID11297( "scr_elevator_innerdoorspeed", "14" );
        level.elevator_outterdoorspeed = _ID11297( "scr_elevator_outterdoorspeed", "16" );
        level.elevator_return = _ID11297( "scr_elevator_return", "0" );
        level._ID11320 = _ID11297( "scr_elevator_waittime", "6" );
        level._ID11282 = _ID11297( "scr_elevator_aggressive_call", "0" );
        level.elevator_debug = _ID11297( "debug_elevator", "0" );

        if ( common_scripts\utility::_ID18787() )
            level._ID11304 = _ID11297( "scr_elevator_motion_detection", "0" );
        else
            level._ID11304 = _ID11297( "scr_elevator_motion_detection", "1" );

        wait 1;
    }
}

elevator_think()
{
    _ID11295( "[A]" );
}

elevator_call()
{
    foreach ( var_1 in level._ID11287 )
        var_1 thread _ID21303();
}

_ID13423( var_0 )
{
    self endon( "elevator_moving" );
    self._ID13423 = 0;
    self._ID23178 = undefined;

    for (;;)
    {
        var_0 waittill( "trigger",  var_1  );
        self._ID13423 = 1;
        self._ID23178 = var_1;
        break;
    }

    self notify( "floor_override" );
}

_ID11295( var_0 )
{
    self.estate = var_0;
    var_1 = get_housing_door_trigger();
    var_2 = _ID14506();

    for (;;)
    {
        if ( self.estate == "[A]" )
        {
            if ( level.elevator_return && get_curfloor() != _ID14526() )
            {
                self._ID21688 = _ID14526();
                thread _ID13423( var_2 );
                _ID35715( "floor_override", level._ID11320 );

                if ( self._ID13423 && isdefined( self._ID23178 ) && isplayer( self._ID23178 ) )
                    _ID14464( self._ID23178 );

                self.estate = "[B]";
                continue;
            }

            for (;;)
            {
                if ( self._ID21688 == get_curfloor() )
                    var_3 = var_2 discrete_waittill( "trigger" );
                else
                    var_3 = "elevator_called";

                if ( isstring( var_3 ) && var_3 == "elevator_called" && self._ID21688 != get_curfloor() )
                {
                    self.estate = "[B]";
                    break;
                }

                if ( isdefined( var_3 ) && isplayer( var_3 ) && isalive( var_3 ) )
                {
                    var_4 = var_3 istouching( var_2 );
                    var_5 = isdefined( var_2.motion_trigger ) && var_3 istouching( var_2.motion_trigger );
                    var_6 = var_4 || var_5;

                    if ( var_6 )
                    {
                        var_7 = var_3;
                        _ID14464( var_7 );

                        if ( self._ID21688 == get_curfloor() )
                            continue;

                        self.estate = "[B]";
                        break;
                    }
                }
            }
        }

        if ( self.estate == "[B]" )
        {
            thread elevator_interrupt( var_1 );
            var_8 = get_curfloor();
            thread close_inner_doors();
            thread close_outer_doors( var_8 );
            common_scripts\utility::_ID35626( "closed_inner_doors", "interrupted" );

            if ( self._ID11302 )
            {
                self.estate = "[C]";
                continue;
            }

            self.estate = "[D]";
            continue;
        }

        if ( self.estate == "[C]" )
        {
            var_8 = get_curfloor();
            thread _ID22940();
            thread _ID22943( var_8 );
            self waittill( "opened_floor_" + var_8 + "_outer_doors" );

            if ( self._ID11302 )
            {
                self.estate = "[B]";
                continue;
            }

            self.estate = "[A]";
            continue;
        }

        if ( self.estate == "[D]" )
        {
            if ( self._ID21688 != get_curfloor() )
            {
                thread elevator_move( self._ID21688 );
                self waittill( "elevator_moved" );
            }

            self.estate = "[C]";
            continue;
        }
    }
}

_ID21303()
{
    for (;;)
    {
        var_0 = discrete_waittill( "trigger" );
        var_1 = undefined;
        var_2 = [];

        foreach ( var_5, var_4 in self.e )
        {
            var_1 = var_5;
            var_2 = var_4;
        }

        var_6 = 0;

        foreach ( var_8 in var_2 )
        {
            var_9 = var_8 elevator_floor_update();

            if ( !level._ID11282 && !var_9 )
            {
                if ( var_8 get_curfloor() == var_1 )
                {
                    var_6 = 1;
                    var_2 = [];
                    break;
                }
            }
        }

        foreach ( var_8 in var_2 )
        {
            if ( var_8.estate == "[A]" )
            {
                var_8 call_elevator( var_1 );
                var_6 = 1;

                if ( !level._ID11282 )
                    break;
            }
        }

        if ( var_6 )
            self playsound( "elev_bell_ding" );
    }
}

call_elevator( var_0 )
{
    self._ID21688 = var_0;
    var_1 = _ID14506();
    var_1 notify( "trigger",  "elevator_called"  );

    if ( level._ID11304 )
        var_1.motion_trigger notify( "trigger",  "elevator_called"  );
}

_ID14464( var_0 )
{
    var_1 = _ID14630();

    if ( var_1.size == 2 )
    {
        var_2 = get_curfloor();
        self._ID21688 = !var_2;
        return;
    }

    var_0 openpopupmenu( "elevator_floor_selector" );
    var_0 setclientdvar( "player_current_floor", get_curfloor() );

    for (;;)
    {
        var_0 waittill( "menuresponse",  var_3, var_4  );

        if ( var_3 == "elevator_floor_selector" )
        {
            if ( var_4 != "none" )
                self._ID21688 = int( var_4 );

            break;
        }
    }
}

elevator_interrupt( var_0 )
{
    self notify( "interrupt_watch" );
    level notify( "elevator_interior_button_pressed" );
    self endon( "interrupt_watch" );
    self endon( "elevator_moving" );
    self._ID11302 = 0;
    wait 0.5;
    var_0 waittill( "trigger",  var_1  );
    self notify( "interrupted" );
    self._ID11302 = 1;
}

elevator_floor_update()
{
    var_0 = _ID14509();
    var_1 = var_0.origin;
    var_2 = 1;

    foreach ( var_6, var_4 in _ID14630() )
    {
        var_5 = self.e["floor" + var_6 + "_pos"];

        if ( var_1 == var_5 )
        {
            self.e["current_floor"] = var_6;
            var_2 = 0;
        }
    }

    return var_2;
}

elevator_sound_think()
{
    var_0 = get_housing_musak_model();

    if ( level._ID11307 && isdefined( var_0 ) )
        var_0 playloopsound( "elev_musak_loop" );

    thread _ID20044( "closing_inner_doors" );
    thread _ID20044( "opening_inner_doors" );
    thread _ID20044( "closed_inner_doors" );
    thread _ID20044( "opened_inner_doors" );

    foreach ( var_3, var_2 in _ID14630() )
    {
        thread _ID20044( "closing_floor_" + var_3 + "_outer_doors" );
        thread _ID20044( "opening_floor_" + var_3 + "_outer_doors" );
        thread _ID20044( "closed_floor_" + var_3 + "_outer_doors" );
        thread _ID20044( "opened_floor_" + var_3 + "_outer_doors" );
    }

    thread _ID20044( "interrupted" );
    thread _ID20044( "elevator_moving" );
    thread _ID20044( "elevator_moved" );
}

_ID20044( var_0 )
{
    for (;;)
    {
        self waittill( var_0 );
        var_1 = _ID14509();

        if ( issubstr( var_0, "closing_" ) )
            var_1 playsound( "elev_door_close" );

        if ( issubstr( var_0, "opening_" ) )
            var_1 playsound( "elev_door_open" );

        if ( var_0 == "elevator_moving" )
        {
            var_1 playsound( "elev_run_start" );
            var_1 playloopsound( "elev_run_loop" );
        }

        if ( var_0 == "interrupted" )
            var_1 playsound( "elev_door_interupt" );

        if ( var_0 == "elevator_moved" )
        {
            var_1 stoploopsound( "elev_run_loop" );
            var_1 playsound( "elev_run_end" );
            var_1 playsound( "elev_bell_ding" );
        }
    }
}

_ID24754()
{
    foreach ( var_5, var_1 in level.elevators )
    {
        var_1._ID21688 = var_1 get_curfloor();

        foreach ( var_4, var_3 in var_1 _ID14630() )
        {
            if ( var_1 get_curfloor() != var_4 )
                var_1 thread close_outer_doors( var_4 );
        }
    }
}

elevator_move( var_0 )
{
    self notify( "elevator_moving" );
    self endon( "elevator_moving" );
    var_1 = _ID14509();
    var_2 = self.e["floor" + var_0 + "_pos"] - var_1.origin;
    var_3 = level._ID11316;
    var_4 = abs( distance( self.e["floor" + var_0 + "_pos"], var_1.origin ) );
    var_5 = var_4 / var_3;
    var_1 moveto( var_1.origin + var_2, var_5, var_5 * level.elevator_accel, var_5 * level._ID11289 );

    foreach ( var_7 in _ID14503() )
    {
        var_8 = var_7.origin + var_2;

        if ( !issubstr( var_7.classname, "trigger_" ) )
        {
            var_7 moveto( var_8, var_5, var_5 * level.elevator_accel, var_5 * level._ID11289 );
            continue;
        }

        var_7.origin = var_8;
    }

    _ID35677( var_1, self.e["floor" + var_0 + "_pos"] );
    self notify( "elevator_moved" );
}

close_inner_doors()
{
    self notify( "closing_inner_doors" );
    self endon( "closing_inner_doors" );
    self endon( "opening_inner_doors" );
    var_0 = _ID14507();
    var_1 = _ID14513();
    var_2 = _ID14509();
    var_3 = _ID14504();
    var_4 = ( var_3[0], var_3[1], var_2.origin[2] );
    var_5 = level._ID11300;
    var_6 = abs( distance( var_0.origin, var_4 ) );
    var_7 = var_6 / var_5;
    var_0 moveto( var_4, var_7, var_7 * 0.1, var_7 * 0.25 );
    var_1 moveto( var_4, var_7, var_7 * 0.1, var_7 * 0.25 );
    _ID35677( var_0, var_4, var_1, var_4 );
    self notify( "closed_inner_doors" );
}

_ID22940()
{
    self notify( "opening_inner_doors" );
    self endon( "opening_inner_doors" );
    var_0 = _ID14507();
    var_1 = _ID14513();
    var_2 = _ID14509();
    var_3 = _ID14508();
    var_4 = _ID14514();
    var_5 = ( var_3[0], var_3[1], var_2.origin[2] );
    var_6 = ( var_4[0], var_4[1], var_2.origin[2] );
    var_7 = level._ID11300;
    var_8 = abs( distance( var_5, var_6 ) * 0.5 );
    var_9 = var_8 / var_7 * 0.5;
    var_0 moveto( var_5, var_9, var_9 * 0.1, var_9 * 0.25 );
    var_1 moveto( var_6, var_9, var_9 * 0.1, var_9 * 0.25 );
    _ID35677( var_0, var_5, var_1, var_6 );
    self notify( "opened_inner_doors" );
}

close_outer_doors( var_0 )
{
    self notify( "closing_floor_" + var_0 + "_outer_doors" );
    self endon( "closing_floor_" + var_0 + "_outer_doors" );
    self endon( "opening_floor_" + var_0 + "_outer_doors" );
    var_1 = get_outer_leftdoor( var_0 );
    var_2 = _ID14633( var_0 );
    var_3 = _ID14632( var_0 );
    var_4 = _ID14628( var_0 );
    var_5 = level.elevator_outterdoorspeed;
    var_6 = abs( distance( var_3, var_4 ) );
    var_7 = var_6 / var_5;
    var_1 moveto( var_4, var_7, var_7 * 0.1, var_7 * 0.25 );
    var_2 moveto( var_4, var_7, var_7 * 0.1, var_7 * 0.25 );
    _ID35677( var_1, var_4, var_2, var_4 );
    self notify( "closed_floor_" + var_0 + "_outer_doors" );
}

_ID22943( var_0 )
{
    level notify( "elevator_doors_opening" );
    self notify( "opening_floor_" + var_0 + "_outer_doors" );
    self endon( "opening_floor_" + var_0 + "_outer_doors" );
    var_1 = get_outer_leftdoor( var_0 );
    var_2 = _ID14633( var_0 );
    var_3 = _ID14632( var_0 );
    var_4 = _ID14634( var_0 );
    var_5 = _ID14628( var_0 );
    var_6 = level.elevator_outterdoorspeed;
    var_7 = abs( distance( var_3, var_5 ) );
    var_8 = var_7 / var_6 * 0.5;
    var_1 moveto( var_3, var_8, var_8 * 0.1, var_8 * 0.25 );
    var_2 moveto( var_4, var_8, var_8 * 0.1, var_8 * 0.25 );
    _ID35677( var_1, var_3, var_2, var_4 );
    self notify( "opened_floor_" + var_0 + "_outer_doors" );
}

build_elevators()
{
    var_0 = getentarray( "elevator_group", "targetname" );
    var_1 = getentarray( "elevator_housing", "targetname" );
    var_2 = getentarray( "elevator_doorset", "targetname" );

    foreach ( var_4 in var_0 )
    {
        var_5 = getent( var_4.target, "targetname" );
        var_6 = [];
        var_6[0] = min( var_4.origin[0], var_5.origin[0] );
        var_6[1] = max( var_4.origin[0], var_5.origin[0] );
        var_6[2] = min( var_4.origin[1], var_5.origin[1] );
        var_6[3] = max( var_4.origin[1], var_5.origin[1] );
        var_7 = spawnstruct();
        var_7.e["id"] = level.elevators.size;
        var_7.e["housing"] = [];
        var_7.e["housing"]["mainframe"] = [];

        foreach ( var_9 in var_1 )
        {
            if ( var_9 _ID18651( var_6 ) )
            {
                var_7.e["housing"]["mainframe"][var_7.e["housing"]["mainframe"].size] = var_9;

                if ( var_9.classname == "script_model" )
                    continue;

                if ( var_9.code_classname == "light" )
                    continue;

                var_10 = getent( var_9.target, "targetname" );
                var_7.e["housing"]["left_door"] = var_10;
                var_7.e["housing"]["left_door_opened_pos"] = var_10.origin;
                var_11 = getent( var_10.target, "targetname" );
                var_7.e["housing"]["right_door"] = var_11;
                var_7.e["housing"]["right_door_opened_pos"] = var_11.origin;
                var_12 = ( var_10.origin - var_11.origin ) * ( 0.5, 0.5, 0.5 ) + var_11.origin;
                var_7.e["housing"]["door_closed_pos"] = var_12;
                var_13 = getent( var_11.target, "targetname" );
                var_7.e["housing"]["door_trigger"] = var_13;
                var_14 = getent( var_13.target, "targetname" );
                var_7.e["housing"]["inside_trigger"] = var_14;
                var_14 _ID20485();
                var_14.motion_trigger = spawn( "trigger_radius", var_9.origin, 0, 64, 128 );
            }
        }

        var_7.e["outer_doorset"] = [];

        foreach ( var_17 in var_2 )
        {
            if ( var_17 _ID18651( var_6 ) )
            {
                var_18 = isdefined( var_17.script_noteworthy ) && var_17.script_noteworthy == "closed_for_lighting";
                var_19 = var_7.e["outer_doorset"].size;
                var_7.e["outer_doorset"][var_19] = [];
                var_7.e["outer_doorset"][var_19]["door_closed_pos"] = var_17.origin;
                var_20 = getent( var_17.target, "targetname" );
                var_7.e["outer_doorset"][var_19]["left_door"] = var_20;
                var_7.e["outer_doorset"][var_19]["left_door_opened_pos"] = var_20.origin;
                var_21 = getent( var_20.target, "targetname" );
                var_7.e["outer_doorset"][var_19]["right_door"] = var_21;
                var_7.e["outer_doorset"][var_19]["right_door_opened_pos"] = var_21.origin;

                if ( var_18 )
                {
                    var_22 = var_17.origin - var_20.origin;
                    var_17.origin = var_20.origin;
                    var_20.origin = var_20.origin + var_22;
                    var_21.origin = var_21.origin - var_22;
                    var_7.e["outer_doorset"][var_19]["door_closed_pos"] = var_17.origin;
                    var_7.e["outer_doorset"][var_19]["left_door_opened_pos"] = var_20.origin;
                    var_7.e["outer_doorset"][var_19]["right_door_opened_pos"] = var_21.origin;
                }
            }
        }

        for ( var_24 = 0; var_24 < var_7.e["outer_doorset"].size - 1; var_24++ )
        {
            for ( var_25 = 0; var_25 < var_7.e["outer_doorset"].size - 1 - var_24; var_25++ )
            {
                if ( var_7.e["outer_doorset"][var_25 + 1]["door_closed_pos"][2] < var_7.e["outer_doorset"][var_25]["door_closed_pos"][2] )
                {
                    var_26 = var_7.e["outer_doorset"][var_25]["left_door"];
                    var_27 = var_7.e["outer_doorset"][var_25]["left_door_opened_pos"];
                    var_28 = var_7.e["outer_doorset"][var_25]["right_door"];
                    var_29 = var_7.e["outer_doorset"][var_25]["right_door_opened_pos"];
                    var_30 = var_7.e["outer_doorset"][var_25]["door_closed_pos"];
                    var_7.e["outer_doorset"][var_25]["left_door"] = var_7.e["outer_doorset"][var_25 + 1]["left_door"];
                    var_7.e["outer_doorset"][var_25]["left_door_opened_pos"] = var_7.e["outer_doorset"][var_25 + 1]["left_door_opened_pos"];
                    var_7.e["outer_doorset"][var_25]["right_door"] = var_7.e["outer_doorset"][var_25 + 1]["right_door"];
                    var_7.e["outer_doorset"][var_25]["right_door_opened_pos"] = var_7.e["outer_doorset"][var_25 + 1]["right_door_opened_pos"];
                    var_7.e["outer_doorset"][var_25]["door_closed_pos"] = var_7.e["outer_doorset"][var_25 + 1]["door_closed_pos"];
                    var_7.e["outer_doorset"][var_25 + 1]["left_door"] = var_26;
                    var_7.e["outer_doorset"][var_25 + 1]["left_door_opened_pos"] = var_27;
                    var_7.e["outer_doorset"][var_25 + 1]["right_door"] = var_28;
                    var_7.e["outer_doorset"][var_25 + 1]["right_door_opened_pos"] = var_29;
                    var_7.e["outer_doorset"][var_25 + 1]["door_closed_pos"] = var_30;
                }
            }
        }

        var_31 = [];

        foreach ( var_24, var_33 in var_7.e["outer_doorset"] )
        {
            var_34 = var_7 _ID14509();
            var_31 = ( var_34.origin[0], var_34.origin[1], var_33["door_closed_pos"][2] );
            var_7.e["floor" + var_24 + "_pos"] = var_31;

            if ( var_34.origin == var_31 )
            {
                var_7.e["initial_floor"] = var_24;
                var_7.e["current_floor"] = var_24;
            }
        }

        level.elevators[level.elevators.size] = var_7;
        var_4 delete();
        var_5 delete();
    }

    foreach ( var_17 in var_2 )
        var_17 delete();

    _ID6171();

    if ( !level._ID11304 )
        _ID29030();

    foreach ( var_39 in level.elevators )
    {
        var_40 = var_39 get_housing_primarylight();

        if ( isdefined( var_40 ) && var_40.size )
        {
            foreach ( var_42 in var_40 )
                var_42 setlightintensity( 0.75 );
        }
    }
}

_ID6171()
{
    level._ID11287 = getentarray( "elevator_call", "targetname" );

    foreach ( var_1 in level._ID11287 )
    {
        var_1.e = [];
        var_2 = ( 0, 0, var_1.origin[2] );
        var_3 = ( var_1.origin[0], var_1.origin[1], 0 );
        var_4 = [];

        foreach ( var_12, var_6 in level.elevators )
        {
            foreach ( var_11, var_8 in var_6 _ID14630() )
            {
                var_9 = ( 0, 0, var_6.e["floor" + var_11 + "_pos"][2] );
                var_10 = ( var_6.e["floor" + var_11 + "_pos"][0], var_6.e["floor" + var_11 + "_pos"][1], 0 );

                if ( abs( distance( var_2, var_9 ) ) <= level._ID11286 )
                {
                    if ( abs( distance( var_3, var_10 ) ) <= level.elevator_callbutton_link_h )
                    {
                        var_4[var_4.size] = var_6;
                        var_1.e[var_11] = var_4;
                    }
                }
            }
        }

        var_1 _ID20485();
        var_1.motion_trigger = spawn( "trigger_radius", var_1.origin + ( 0, 0, -32 ), 0, 32, 64 );
    }
}

_ID29030()
{
    foreach ( var_1 in level.elevators )
    {
        var_2 = var_1 _ID14506();
        var_3 = var_1 _ID14630();
        var_4 = var_3.size;
        var_2 setcursorhint( "HINT_NOICON" );

        if ( var_4 > 2 )
        {
            var_2 sethintstring( &"ELEVATOR_FLOOR_SELECT_HINT" );
            continue;
        }

        var_2 sethintstring( &"ELEVATOR_USE_HINT" );
    }

    foreach ( var_7 in level._ID11287 )
    {
        var_7 setcursorhint( "HINT_NOICON" );
        var_7 sethintstring( &"ELEVATOR_CALL_HINT" );
    }
}

_ID20485()
{
    self._ID11491 = 1;
    disable_trigger();
}

discrete_waittill( var_0 )
{
    _ID11478();

    if ( level._ID11304 )
        self.motion_trigger waittill( var_0,  var_1  );
    else
        self waittill( var_0,  var_1  );

    disable_trigger();
    return var_1;
}

_ID11478()
{
    if ( !self._ID11491 )
    {
        self._ID11491 = 1;
        self.origin = self.origin + ( 0, 0, 10000 );

        if ( isdefined( self.motion_trigger ) )
            self.motion_trigger.origin = self.motion_trigger.origin + ( 0, 0, 10000 );
    }
}

disable_trigger()
{
    self notify( "disable_trigger" );

    if ( self._ID11491 )
        thread disable_trigger_helper();
}

disable_trigger_helper()
{
    self endon( "disable_trigger" );
    self._ID11491 = 0;
    wait 1.5;
    self.origin = self.origin + ( 0, 0, -10000 );

    if ( isdefined( self.motion_trigger ) )
        self.motion_trigger.origin = self.motion_trigger.origin + ( 0, 0, -10000 );
}

_ID14629( var_0 )
{
    return self.e["outer_doorset"][var_0];
}

_ID14630()
{
    return self.e["outer_doorset"];
}

_ID14628( var_0 )
{
    return self.e["outer_doorset"][var_0]["door_closed_pos"];
}

get_outer_leftdoor( var_0 )
{
    return self.e["outer_doorset"][var_0]["left_door"];
}

_ID14633( var_0 )
{
    return self.e["outer_doorset"][var_0]["right_door"];
}

_ID14632( var_0 )
{
    return self.e["outer_doorset"][var_0]["left_door_opened_pos"];
}

_ID14634( var_0 )
{
    return self.e["outer_doorset"][var_0]["right_door_opened_pos"];
}

_ID14503()
{
    var_0 = [];
    var_1 = get_housing_door_trigger();
    var_2 = _ID14506();
    var_3 = var_2.motion_trigger;
    var_4 = _ID14507();
    var_5 = _ID14513();
    var_0[var_0.size] = var_1;
    var_0[var_0.size] = var_2;
    var_0[var_0.size] = var_4;
    var_0[var_0.size] = var_5;

    if ( isdefined( var_3 ) )
        var_0[var_0.size] = var_3;

    var_6 = _ID14510();

    foreach ( var_8 in var_6 )
        var_0[var_0.size] = var_8;

    var_10 = get_housing_primarylight();

    foreach ( var_12 in var_10 )
        var_0[var_0.size] = var_12;

    return var_0;
}

_ID14509()
{
    var_0 = self.e["housing"]["mainframe"];
    var_1 = undefined;

    foreach ( var_3 in var_0 )
    {
        if ( var_3.classname != "script_model" && var_3.code_classname != "light" )
            var_1 = var_3;
    }

    return var_1;
}

_ID14510()
{
    var_0 = self.e["housing"]["mainframe"];
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( var_3.classname == "script_model" )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

get_housing_primarylight()
{
    var_0 = self.e["housing"]["mainframe"];
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( var_3.code_classname == "light" )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

get_housing_musak_model()
{
    var_0 = _ID14510();
    var_1 = undefined;

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3.script_noteworthy ) && var_3.script_noteworthy == "play_musak" )
            var_1 = var_3;
    }

    return var_1;
}

get_housing_door_trigger()
{
    return self.e["housing"]["door_trigger"];
}

_ID14506()
{
    return self.e["housing"]["inside_trigger"];
}

_ID14504()
{
    return self.e["housing"]["door_closed_pos"];
}

_ID14507()
{
    return self.e["housing"]["left_door"];
}

_ID14513()
{
    return self.e["housing"]["right_door"];
}

_ID14508()
{
    return self.e["housing"]["left_door_opened_pos"];
}

_ID14514()
{
    return self.e["housing"]["right_door_opened_pos"];
}

get_curfloor()
{
    var_0 = elevator_floor_update();
    return self.e["current_floor"];
}

_ID14526()
{
    return self.e["initial_floor"];
}

_ID35677( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) && !isdefined( var_3 ) )
    {
        var_2 = var_0;
        var_3 = var_1;
    }

    for (;;)
    {
        var_4 = var_0.origin;
        var_5 = var_2.origin;

        if ( var_4 == var_1 && var_5 == var_3 )
            break;

        wait 0.05;
    }
}

_ID18651( var_0 )
{
    var_1 = self.origin[0];
    var_2 = self.origin[1];
    var_3 = var_0[0];
    var_4 = var_0[1];
    var_5 = var_0[2];
    var_6 = var_0[3];
    return var_1 >= var_3 && var_1 <= var_4 && var_2 >= var_5 && var_2 <= var_6;
}

_ID18653( var_0 )
{
    var_1 = self.origin[0];
    var_2 = self.origin[1];
    var_3 = var_0[0];
    var_4 = var_0[1];
    var_5 = var_0[2];
    var_6 = var_0[3];
    var_7 = ( var_3 + var_4 ) / 2;
    var_8 = ( var_5 + var_6 ) / 2;
    var_9 = abs( distance( ( var_3, var_5, 0 ), ( var_7, var_8, 0 ) ) );
    return abs( distance( ( var_1, var_2, 0 ), ( var_7, var_8, 0 ) ) ) < var_9;
}

_ID35715( var_0, var_1 )
{
    self endon( var_0 );
    wait(var_1);
}

_ID11297( var_0, var_1 )
{
    return int( _ID11296( var_0, var_1 ) );
}

_ID11296( var_0, var_1 )
{
    if ( getdvar( var_0 ) != "" )
        return getdvarfloat( var_0 );
    else
    {
        setdvar( var_0, var_1 );
        return var_1;
    }
}

elevator_debug()
{
    if ( !level.elevator_debug )
        return;

    for (;;)
    {
        if ( level.elevator_debug != 2 )
            continue;

        foreach ( var_7, var_1 in level.elevators )
        {
            var_2 = var_1 _ID14509();
            var_3 = var_1 get_housing_musak_model();

            foreach ( var_6, var_5 in var_1.e["outer_doorset"] )
            {

            }
        }

        foreach ( var_9 in level._ID11287 )
        {
            foreach ( var_16, var_5 in var_9.e )
            {
                var_11 = 0;

                foreach ( var_15, var_13 in var_5 )
                {
                    var_11++;
                    var_14 = var_9.origin + ( 0, 0, var_11 * -4 );
                }
            }
        }

        wait 0.05;
    }
}
