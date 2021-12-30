// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID10725( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3._ID27766 ) )
            var_3 button_parse_parameters( var_3._ID27766 );

        var_3 _ID10710();
    }

    foreach ( var_3 in var_1 )
        var_3 thread _ID10726();
}

_ID10710()
{
    var_0 = self;
    var_0._ID10745 = [];

    if ( isdefined( var_0._ID27651 ) )
        var_0.doormovetime = max( 0.1, float( var_0._ID27651 ) / 1000 );

    var_1 = getentarray( var_0.target, "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( issubstr( var_3.classname, "trigger" ) )
        {
            if ( !isdefined( var_0._ID33576 ) )
                var_0._ID33576 = [];

            if ( isdefined( var_3._ID27766 ) )
                var_3 trigger_parse_parameters( var_3._ID27766 );

            if ( isdefined( var_3.script_linkto ) )
            {
                var_4 = getent( var_3.script_linkto, "script_linkname" );
                var_3 enablelinkto();
                var_3 linkto( var_4 );
            }

            var_0._ID33576[var_0._ID33576.size] = var_3;
            continue;
        }

        if ( var_3.classname == "script_brushmodel" || var_3.classname == "script_model" )
        {
            if ( isdefined( var_3.script_noteworthy ) && issubstr( var_3.script_noteworthy, "light" ) )
            {
                if ( issubstr( var_3.script_noteworthy, "light_on" ) )
                {
                    if ( !isdefined( var_0._ID19979 ) )
                        var_0._ID19979 = [];

                    var_3 hide();
                    var_0._ID19979[var_0._ID19979.size] = var_3;
                }
                else if ( issubstr( var_3.script_noteworthy, "light_off" ) )
                {
                    if ( !isdefined( var_0.lights_off ) )
                        var_0.lights_off = [];

                    var_3 hide();
                    var_0.lights_off[var_0.lights_off.size] = var_3;
                }
                else
                {

                }
            }
            else if ( var_3.spawnflags & 2 )
            {
                if ( !isdefined( var_0.ai_sight_brushes ) )
                    var_0.ai_sight_brushes = [];

                var_3 notsolid();
                var_3 hide();
                var_3 setaisightlinevisible( 0 );
                var_0.ai_sight_brushes[var_0.ai_sight_brushes.size] = var_3;
            }
            else
                var_0._ID10745[var_0._ID10745.size] = var_3;

            continue;
        }

        if ( var_3.classname == "script_origin" )
            var_0.entsound = var_3;
    }

    if ( !isdefined( var_0.entsound ) && var_0._ID10745.size )
        var_0.entsound = sortbydistance( var_0._ID10745, var_0.origin )[0];

    foreach ( var_7 in var_0._ID10745 )
    {
        var_7.posclosed = var_7.origin;
        var_7._ID24757 = common_scripts\utility::_ID15384( var_7.target, "targetname" ).origin;
        var_7._ID10246 = distance( var_7._ID24757, var_7.posclosed );
        var_7.origin = var_7._ID24757;
        var_7.no_moving_unresolved_collisions = 0;

        if ( isdefined( var_7._ID27766 ) )
            var_7 door_parse_parameters( var_7._ID27766 );
    }
}

_ID10726()
{
    var_0 = self;
    var_0 _ID10712( 2, 1 );

    for (;;)
    {
        var_0._ID31504 = undefined;
        var_0._ID31506 = undefined;
        var_0 common_scripts\utility::_ID35626( "door_state_done", "door_state_interrupted" );

        if ( isdefined( var_0._ID31504 ) && var_0._ID31504 )
        {
            var_1 = var_0 _ID10714( var_0._ID31503 );
            var_0 _ID10712( var_1, 0 );
            continue;
        }

        if ( isdefined( var_0._ID31506 ) && var_0._ID31506 )
        {
            var_0 _ID10712( 4, 0 );
            continue;
        }
    }
}

_ID10714( var_0 )
{
    var_1 = self;
    var_2 = undefined;

    if ( var_0 == 0 )
        var_2 = 3;
    else if ( var_0 == 2 )
        var_2 = 1;
    else if ( var_0 == 1 )
        var_2 = 0;
    else if ( var_0 == 3 )
        var_2 = 2;
    else if ( var_0 == 4 )
        var_2 = var_1._ID31508;
    else
    {

    }

    return var_2;
}

_ID10716( var_0 )
{
    var_1 = self;
    var_1 endon( "door_state_interrupted" );
    var_1._ID31504 = undefined;

    if ( var_1._ID31503 == 0 || var_1._ID31503 == 2 )
    {
        if ( !var_0 )
        {
            foreach ( var_3 in var_1._ID10745 )
            {
                if ( isdefined( var_3._ID31820 ) )
                {
                    var_3 stoploopsound();
                    var_3 playsoundonmovingent( var_3._ID31820 );
                }
            }
        }

        if ( isdefined( var_1._ID19979 ) )
        {
            foreach ( var_6 in var_1._ID19979 )
                var_6 show();
        }

        foreach ( var_3 in var_1._ID10745 )
        {
            if ( var_1._ID31503 == 0 )
            {
                if ( isdefined( var_1.ai_sight_brushes ) )
                {
                    foreach ( var_10 in var_1.ai_sight_brushes )
                    {
                        var_10 show();
                        var_10 setaisightlinevisible( 1 );
                    }
                }

                if ( var_3.spawnflags & 1 )
                    var_3 disconnectpaths();
            }
            else
            {
                if ( isdefined( var_1.ai_sight_brushes ) )
                {
                    foreach ( var_10 in var_1.ai_sight_brushes )
                    {
                        var_10 hide();
                        var_10 setaisightlinevisible( 0 );
                    }
                }

                if ( var_3.spawnflags & 1 )
                {
                    if ( isdefined( var_3.script_noteworthy ) && var_3.script_noteworthy == "always_disconnect" )
                        var_3 disconnectpaths();
                    else
                        var_3 connectpaths();
                }
            }

            if ( isdefined( var_3.script_noteworthy ) )
            {
                if ( var_3.script_noteworthy == "clockwise_wheel" || var_3.script_noteworthy == "counterclockwise_wheel" )
                    var_3 rotatevelocity( ( 0, 0, 0 ), 0.1 );
            }

            if ( var_3.no_moving_unresolved_collisions )
                var_3._ID34249 = undefined;
        }

        var_15 = common_scripts\utility::_ID32831( var_1._ID31503 == 0, &"MP_DOOR_USE_OPEN", &"MP_DOOR_USE_CLOSE" );
        var_1 sethintstring( var_15 );
        var_1 makeusable();
        var_1 waittill( "trigger" );

        if ( isdefined( var_1.button_sound ) )
            var_1 playsound( var_1.button_sound );
    }
    else if ( var_1._ID31503 == 1 || var_1._ID31503 == 3 )
    {
        if ( isdefined( var_1.lights_off ) )
        {
            foreach ( var_6 in var_1.lights_off )
                var_6 show();
        }

        var_1 makeunusable();

        if ( var_1._ID31503 == 1 )
        {
            var_1 thread _ID10715();

            foreach ( var_3 in var_1._ID10745 )
            {
                if ( isdefined( var_3.script_noteworthy ) )
                {
                    var_19 = common_scripts\utility::_ID32831( isdefined( var_1.doormovetime ), var_1.doormovetime, 3.0 );
                    var_20 = common_scripts\utility::_ID32831( var_1._ID31503 == 1, var_3.posclosed, var_3._ID24757 );
                    var_21 = distance( var_3.origin, var_20 );
                    var_22 = max( 0.1, var_21 / var_3._ID10246 * var_19 );
                    var_23 = max( var_22 * 0.25, 0.05 );
                    var_24 = 360 * var_21 / 94.2;

                    if ( var_3.script_noteworthy == "clockwise_wheel" )
                        var_3 rotatevelocity( ( 0, 0, -1 * var_24 / var_22 ), var_22, var_23, var_23 );
                    else if ( var_3.script_noteworthy == "counterclockwise_wheel" )
                        var_3 rotatevelocity( ( 0, 0, var_24 / var_22 ), var_22, var_23, var_23 );
                }
            }
        }
        else if ( var_1._ID31503 == 3 )
        {
            if ( isdefined( var_1._ID22941 ) && var_1._ID22941 )
                var_1 thread _ID10715();

            foreach ( var_3 in var_1._ID10745 )
            {
                if ( isdefined( var_3.script_noteworthy ) )
                {
                    var_19 = common_scripts\utility::_ID32831( isdefined( var_1.doormovetime ), var_1.doormovetime, 3.0 );
                    var_20 = common_scripts\utility::_ID32831( var_1._ID31503 == 1, var_3.posclosed, var_3._ID24757 );
                    var_21 = distance( var_3.origin, var_20 );
                    var_22 = max( 0.1, var_21 / var_3._ID10246 * var_19 );
                    var_23 = max( var_22 * 0.25, 0.05 );
                    var_24 = 360 * var_21 / 94.2;

                    if ( var_3.script_noteworthy == "clockwise_wheel" )
                        var_3 rotatevelocity( ( 0, 0, var_24 / var_22 ), var_22, var_23, var_23 );
                    else if ( var_3.script_noteworthy == "counterclockwise_wheel" )
                        var_3 rotatevelocity( ( 0, 0, -1 * var_24 / var_22 ), var_22, var_23, var_23 );
                }
            }
        }

        wait 0.1;
        var_1 childthread door_state_update_sound( "garage_door_start", "garage_door_loop" );
        var_19 = common_scripts\utility::_ID32831( isdefined( var_1.doormovetime ), var_1.doormovetime, 3.0 );
        var_28 = undefined;

        foreach ( var_3 in var_1._ID10745 )
        {
            var_20 = common_scripts\utility::_ID32831( var_1._ID31503 == 1, var_3.posclosed, var_3._ID24757 );

            if ( var_3.origin != var_20 )
            {
                var_22 = max( 0.1, distance( var_3.origin, var_20 ) / var_3._ID10246 * var_19 );
                var_23 = max( var_22 * 0.25, 0.05 );
                var_3 moveto( var_20, var_22, var_23, var_23 );
                var_3 maps\mp\_movers::notify_moving_platform_invalid();

                if ( var_3.no_moving_unresolved_collisions )
                    var_3._ID34249 = maps\mp\_movers::_ID34255;

                if ( !isdefined( var_28 ) || var_22 > var_28 )
                    var_28 = var_22;
            }
        }

        if ( isdefined( var_28 ) )
            wait(var_28);
    }
    else if ( var_1._ID31503 == 4 )
    {
        foreach ( var_3 in var_1._ID10745 )
        {
            var_3 moveto( var_3.origin, 0.05, 0.0, 0.0 );
            var_3 maps\mp\_movers::notify_moving_platform_invalid();

            if ( var_3.no_moving_unresolved_collisions )
                var_3._ID34249 = undefined;

            if ( isdefined( var_3.script_noteworthy ) )
            {
                if ( var_3.script_noteworthy == "clockwise_wheel" || var_3.script_noteworthy == "counterclockwise_wheel" )
                    var_3 rotatevelocity( ( 0, 0, 0 ), 0.05 );
            }
        }

        if ( isdefined( var_1.lights_off ) )
        {
            foreach ( var_6 in var_1.lights_off )
                var_6 show();
        }

        var_1.entsound stoploopsound();

        foreach ( var_3 in var_1._ID10745 )
        {
            if ( isdefined( var_3._ID18103 ) )
                var_3 playsound( var_3._ID18103 );
        }

        wait 1.0;
    }
    else
    {

    }

    var_1._ID31504 = 1;

    foreach ( var_3 in var_1._ID10745 )
        var_3._ID31504 = 1;

    var_1 notify( "door_state_done" );
}

door_state_update_sound( var_0, var_1 )
{
    var_2 = self;
    var_3 = 1;
    var_4 = 1;
    var_5 = 0;

    if ( var_2._ID31503 == 3 || var_2._ID31503 == 1 )
    {
        foreach ( var_7 in var_2._ID10745 )
        {
            if ( isdefined( var_7._ID31383 ) )
            {
                var_7 playsoundonmovingent( var_7._ID31383 );
                var_5 = lookupsoundlength( var_7._ID31383 ) / 1000;
                var_3 = 0;
            }
        }

        if ( var_3 )
        {
            var_5 = lookupsoundlength( var_0 ) / 1000;
            playsoundatpos( var_2.entsound.origin, var_0 );
        }
    }

    wait(var_5 * 0.3);

    if ( var_2._ID31503 == 3 || var_2._ID31503 == 1 )
    {
        foreach ( var_7 in var_2._ID10745 )
        {
            if ( isdefined( var_7._ID20334 ) )
            {
                if ( var_7._ID20334 != "none" )
                    var_7 playloopsound( var_7._ID20334 );

                var_4 = 0;
            }
        }

        if ( var_4 )
        {
            var_2.entsound playloopsound( var_1 );
            return;
        }

        return;
    }
}

_ID10712( var_0, var_1 )
{
    var_2 = self;

    if ( isdefined( var_2._ID31503 ) )
    {
        door_state_exit( var_2._ID31503 );
        var_2._ID31508 = var_2._ID31503;
    }

    var_2._ID31503 = var_0;
    var_2 thread _ID10716( var_1 );
}

door_state_exit( var_0 )
{
    var_1 = self;

    if ( var_0 == 0 || var_0 == 2 )
    {
        if ( isdefined( var_1._ID19979 ) )
        {
            foreach ( var_3 in var_1._ID19979 )
                var_3 hide();

            return;
        }

        return;
    }

    if ( var_0 == 1 || var_0 == 3 )
    {
        if ( isdefined( var_1.lights_off ) )
        {
            foreach ( var_3 in var_1.lights_off )
                var_3 hide();
        }

        var_1.entsound stoploopsound();

        foreach ( var_8 in var_1._ID10745 )
        {
            if ( isdefined( var_8._ID20334 ) )
                var_8 stoploopsound();
        }

        return;
    }

    if ( var_0 == 4 )
        return;

    return;
    return;
    return;
}

_ID10715()
{
    var_0 = self;
    var_0 endon( "door_state_done" );
    var_1 = [];

    foreach ( var_3 in var_0._ID33576 )
    {
        if ( var_0._ID31503 == 1 )
        {
            if ( isdefined( var_3.not_closing ) && var_3.not_closing == 1 )
                continue;
        }
        else if ( var_0._ID31503 == 3 )
        {
            if ( isdefined( var_3._ID22153 ) && var_3._ID22153 == 1 )
                continue;
        }

        var_1[var_1.size] = var_3;
    }

    if ( var_1.size > 0 )
    {
        var_5 = var_0 waittill_any_triggered_return_triggerer( var_1 );

        if ( !isdefined( var_5.fauxdead ) || var_5.fauxdead == 0 )
        {
            var_0._ID31506 = 1;
            var_0 notify( "door_state_interrupted" );
            return;
        }

        return;
    }
}

waittill_any_triggered_return_triggerer( var_0 )
{
    var_1 = self;

    foreach ( var_3 in var_0 )
        var_1 thread _ID26245( var_3 );

    var_1 waittill( "interrupted" );
    return var_1._ID18109;
}

_ID26245( var_0 )
{
    var_1 = self;
    var_1 endon( "door_state_done" );
    var_1 endon( "interrupted" );

    for (;;)
    {
        var_0 waittill( "trigger",  var_2  );

        if ( isdefined( var_0.prone_only ) && var_0.prone_only == 1 )
        {
            if ( isplayer( var_2 ) )
            {
                var_3 = var_2 getstance();

                if ( var_3 != "prone" )
                    continue;
                else
                {
                    var_4 = vectornormalize( anglestoforward( var_2.angles ) );
                    var_5 = vectornormalize( var_0.origin - var_2.origin );
                    var_6 = vectordot( var_4, var_5 );

                    if ( var_6 > 0 )
                        continue;
                }
            }
        }

        break;
    }

    var_1._ID18109 = var_2;
    var_1 notify( "interrupted" );
}

button_parse_parameters( var_0 )
{
    var_1 = self;
    var_1.button_sound = undefined;

    if ( !isdefined( var_0 ) )
        var_0 = "";

    var_2 = strtok( var_0, ";" );

    foreach ( var_4 in var_2 )
    {
        var_5 = strtok( var_4, "=" );

        if ( var_5.size != 2 )
            continue;

        if ( var_5[1] == "undefined" || var_5[1] == "default" )
        {
            var_1._ID23268[var_5[0]] = undefined;
            continue;
        }

        switch ( var_5[0] )
        {
            case "open_interrupt":
                var_1._ID22941 = string_to_bool( var_5[1] );
                continue;
            case "button_sound":
                var_1.button_sound = var_5[1];
                continue;
            default:
                continue;
        }
    }
}

door_parse_parameters( var_0 )
{
    var_1 = self;
    var_1._ID31383 = undefined;
    var_1._ID31820 = undefined;
    var_1._ID20334 = undefined;
    var_1._ID18103 = undefined;

    if ( !isdefined( var_0 ) )
        var_0 = "";

    var_2 = strtok( var_0, ";" );

    foreach ( var_4 in var_2 )
    {
        var_5 = strtok( var_4, "=" );

        if ( var_5.size != 2 )
            continue;

        if ( var_5[1] == "undefined" || var_5[1] == "default" )
        {
            var_1._ID23268[var_5[0]] = undefined;
            continue;
        }

        switch ( var_5[0] )
        {
            case "stop_sound":
                var_1._ID31820 = var_5[1];
                continue;
            case "interrupt_sound":
                var_1._ID18103 = var_5[1];
                continue;
            case "loop_sound":
                var_1._ID20334 = var_5[1];
                continue;
            case "open_interrupt":
                var_1._ID22941 = string_to_bool( var_5[1] );
                continue;
            case "start_sound":
                var_1._ID31383 = var_5[1];
                continue;
            case "unresolved_collision_nodes":
                var_1._ID34252 = getnodearray( var_5[1], "targetname" );
                continue;
            case "no_moving_unresolved_collisions":
                var_1.no_moving_unresolved_collisions = string_to_bool( var_5[1] );
                continue;
            default:
                continue;
        }
    }
}

trigger_parse_parameters( var_0 )
{
    var_1 = self;

    if ( !isdefined( var_0 ) )
        var_0 = "";

    var_2 = strtok( var_0, ";" );

    foreach ( var_4 in var_2 )
    {
        var_5 = strtok( var_4, "=" );

        if ( var_5.size != 2 )
            continue;

        if ( var_5[1] == "undefined" || var_5[1] == "default" )
        {
            var_1._ID23268[var_5[0]] = undefined;
            continue;
        }

        switch ( var_5[0] )
        {
            case "not_opening":
                var_1._ID22153 = string_to_bool( var_5[1] );
                continue;
            case "not_closing":
                var_1.not_closing = string_to_bool( var_5[1] );
                continue;
            case "prone_only":
                var_1.prone_only = string_to_bool( var_5[1] );
                continue;
            default:
                continue;
        }
    }
}

string_to_bool( var_0 )
{
    var_1 = undefined;

    switch ( var_0 )
    {
        case "1":
        case "true":
            var_1 = 1;
            break;
        case "0":
        case "false":
            var_1 = 0;
            break;
        default:
            break;
    }

    return var_1;
}
