// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
        return;

    _ID21535();
    common_scripts\utility::_ID35582();
    var_0 = getentarray( "movable_cover", "targetname" );
    var_1 = common_scripts\utility::_ID15386( "movable_cover", "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3.target ) )
        {
            var_4 = getent( var_3.target, "targetname" );

            if ( isdefined( var_4 ) )
                var_0[var_0.size] = var_4;
        }
    }

    common_scripts\utility::_ID3867( var_0, ::movable_cover_init );
}

_ID21535()
{
    level._ID21540 = [];
    level._ID21540["dumpster"] = "hud_icon_push";
    level._ID21533 = [];
    level._ID21533["dumpster"]["start"] = "mp_dumpster_start";
    level._ID21533["dumpster"]["move"] = "mp_dumpster_mvmt_loop";
    level._ID21533["dumpster"]["stop"] = "mp_dumpster_end";
    level._ID21531 = [];
    level._ID21531["dumpster"] = [];
    level._ID21531["dumpster"]["move"] = "mp_lonestar_dumpster_jitter";
    level._ID21531["dumpster"]["idle"] = "mp_lonestar_dumpster_jitter_idle";
    level._ID21521 = [];
    level._ID21521["dumpster"] = "goal_radius=1;max_speed=80;accel_time=.8;decel_time=.8;stances=crouch,stand";

    foreach ( var_1 in level._ID21531 )
    {
        foreach ( var_3 in var_1 )
            precachempanim( var_3 );
    }
}

movable_cover_init()
{
    self.moving = 0;
    self._ID31533 = 0;
    self._ID34571 = self.spawnflags & 1;
    self.movable_type = "default";

    if ( isdefined( self.script_noteworthy ) )
        self.movable_type = self.script_noteworthy;

    movable_cover_parse_parameters();
    var_0 = [];
    var_1 = common_scripts\utility::get_links();

    foreach ( var_3 in var_1 )
    {
        var_4 = common_scripts\utility::_ID15384( var_3, "script_linkname" );

        if ( isdefined( var_4 ) && isdefined( var_4._ID27658 ) )
        {
            var_4._ID4513 = isdefined( var_4._ID27766 ) && var_4._ID27766 == "auto";
            var_4._ID31533 = isdefined( var_4._ID27766 ) && var_4._ID27766 == "stay";
            var_0[var_4._ID27658] = var_4;
        }
    }

    var_6 = [];

    if ( isdefined( self.target ) )
    {
        var_7 = common_scripts\utility::_ID15386( self.target, "targetname" );
        var_8 = getentarray( self.target, "targetname" );
        var_6 = common_scripts\utility::array_combine( var_7, var_8 );
    }

    var_9 = self;
    var_10 = undefined;

    if ( isdefined( level._ID21531[self.movable_type] ) )
    {
        self.animate_ent = spawn( "script_model", self.origin );
        self.animate_ent setmodel( "generic_prop_raven" );
        self.animate_ent.angles = self.angles;
        self.animate_ent linkto( self );
        var_9 = self.animate_ent;
        var_10 = "j_prop_1";
    }

    self.linked_ents = [];

    foreach ( var_12 in var_6 )
    {
        if ( !isdefined( var_12.script_noteworthy ) )
            continue;

        switch ( var_12.script_noteworthy )
        {
            case "move_trigger":
                if ( !isdefined( var_12._ID27658 ) || !isdefined( var_0[var_12._ID27658] ) )
                    continue;

                var_12 enablelinkto();
                var_12 linkto( self );
                thread movable_cover_trigger( var_12, var_0[var_12._ID27658] );
                thread movable_cover_update_use_icon( var_12, var_0[var_12._ID27658] );
                continue;
            case "link":
                self.linked_ents[self.linked_ents.size] = var_12;
                continue;
            case "angels":
                if ( isdefined( var_12.angles ) && isdefined( self.animate_ent ) )
                    self.animate_ent.angles = var_12.angles;

                continue;
            case "mantlebrush":
                self.linked_ents[self.linked_ents.size] = var_12;
                continue;
            default:
                continue;
        }
    }

    foreach ( var_15 in self.linked_ents )
    {
        if ( isdefined( var_10 ) )
        {
            var_15 linkto( var_9, var_10 );
            continue;
        }

        var_15 linkto( var_9 );
    }

    var_17 = maps\mp\_utility::getlinknamenodes();
    self._ID33485 = [];

    foreach ( var_19 in var_17 )
    {
        if ( !isdefined( var_19.type ) )
            continue;

        var_19._ID22092 = var_19.script_noteworthy;

        if ( !isdefined( var_19._ID22092 ) )
            var_19._ID22092 = "closest";

        var_20 = 0;

        switch ( var_19._ID22092 )
        {
            case "closest":
                var_20 = 1;
                break;
            case "radius":
            case "radius3d":
            case "radius2d":
                if ( isdefined( var_19.target ) )
                {
                    var_12 = common_scripts\utility::_ID15384( var_19.target, "targetname" );

                    if ( isdefined( var_12 ) && isdefined( var_12.radius ) )
                    {
                        var_19._ID32844 = var_12.origin;
                        var_19._ID32846 = var_12.radius;
                        var_20 = 1;
                    }
                }

                break;
            default:
                var_20 = 0;
                break;
        }

        if ( !var_20 )
            continue;

        if ( var_19.type == "Begin" || var_19.type == "End" )
        {
            if ( var_19.type == "Begin" )
                var_19.connected_nodes = getnodearray( var_19.target, "targetname" );
            else
                var_19.connected_nodes = getnodearray( var_19.targetname, "target" );

            foreach ( var_22 in var_19.connected_nodes )
                disconnectnodepair( var_19, var_22 );

            self._ID33485[self._ID33485.size] = var_19;
        }
    }

    _ID21520();
}

_ID21536( var_0, var_1 )
{
    if ( !isdefined( self._ID34764 ) && isdefined( var_0 ) )
        self notify( "new_user" );
    else if ( isdefined( self._ID34764 ) && isdefined( var_0 ) && self._ID34764 != var_0 )
        self notify( "new_user" );
    else if ( isdefined( self._ID34764 ) && !isdefined( var_0 ) )
        self notify( "clear_user" );

    self._ID34764 = var_0;
    self._ID34765 = var_1;
}

movable_cover_update_use_icon( var_0, var_1 )
{
    if ( !isdefined( level._ID21540[self.movable_type] ) )
        return;

    while ( !isdefined( level.players ) )
    {
        common_scripts\utility::_ID35582();
        continue;
    }

    var_2 = 100;
    var_3 = var_2 * var_2;
    var_4 = var_0 getentitynumber();
    var_5 = "trigger_" + var_4;

    for (;;)
    {
        foreach ( var_7 in level.players )
        {
            if ( !isdefined( var_7._ID21526 ) )
                var_7._ID21526 = [];

            var_8 = distancesquared( var_7.origin + ( 0, 0, 30 ), var_0.origin );

            if ( var_8 <= var_3 && !_ID21518( var_1.origin ) )
            {
                if ( !isdefined( var_7._ID21526[var_5] ) )
                {
                    var_7._ID21526[var_5] = movable_cover_use_icon( var_7, var_0 );
                    var_7._ID21526[var_5].alpha = 0;
                }

                var_7._ID21526[var_5] notify( "stop_fade" );
                var_7._ID21526[var_5] thread _ID21523();
                continue;
            }

            if ( isdefined( var_7._ID21526[var_5] ) )
                var_7._ID21526[var_5] thread _ID21524();
        }

        wait 0.05;
    }
}

_ID21523()
{
    self endon( "death" );

    if ( self.alpha == 1 )
        return;

    self fadeovertime( 0.5 );
    self.alpha = 1;
}

_ID21524()
{
    self endon( "death" );
    self endon( "stop_fade" );

    if ( self.alpha == 0 )
        return;

    var_0 = 0.5;
    self fadeovertime( var_0 );
    self.alpha = 0;
    wait(var_0);
    self destroy();
}

movable_cover_use_icon( var_0, var_1 )
{
    var_2 = var_0 maps\mp\gametypes\_hud_util::_ID8444( level._ID21540[self.movable_type], 16, 16 );
    var_2 setwaypoint( 1, 0 );
    var_2 settargetent( var_1 );
    var_2.fading = 0;
    return var_2;
}

movable_cover_parse_parameters()
{
    self._ID15719 = 1;
    self._ID20707 = 50;
    self.accel_time = 1;
    self._ID9268 = 1;
    self._ID26064 = 1;
    self._ID31267 = 0.2;
    self.stances = [ "stand", "crouch" ];

    if ( !isdefined( self._ID27766 ) )
        self._ID27766 = "";

    var_0 = level._ID21521[self.movable_type];

    if ( isdefined( var_0 ) )
        self._ID27766 = var_0 + self._ID27766;

    var_1 = strtok( self._ID27766, ";" );

    foreach ( var_3 in var_1 )
    {
        var_4 = strtok( var_3, "=" );

        if ( var_4.size != 2 )
            continue;

        switch ( var_4[0] )
        {
            case "goal_radius":
                self._ID15719 = float( var_4[1] );
                self._ID15719 = max( 1, self._ID15719 );
                continue;
            case "max_speed":
                self._ID20707 = float( var_4[1] );
                continue;
            case "accel_time":
                self.accel_time = float( var_4[1] );
                continue;
            case "decel_time":
                self._ID9268 = float( var_4[1] );
                self._ID9268 = max( 0.05, self._ID9268 );
                continue;
            case "stances":
                self.stances = strtok( var_4[1], "," );
                continue;
            case "requires_push":
                self._ID26064 = int( var_4[1] );
                continue;
            case "start_delay":
                self._ID31267 = float( var_4[1] );
                continue;
            default:
                continue;
        }
    }
}

movable_cover_trigger( var_0, var_1 )
{
    var_2 = var_1._ID4513;
    var_3 = var_1._ID31533;

    for (;;)
    {
        var_4 = undefined;

        if ( var_2 && !self._ID31533 )
        {
            common_scripts\utility::_ID35582();

            if ( isdefined( self._ID34764 ) && self._ID34765 != var_0 )
                continue;
        }
        else
        {
            _ID21536( undefined, undefined );

            for (;;)
            {
                var_0 waittill( "trigger",  var_4  );

                if ( isplayer( var_4 ) )
                    break;
            }

            _ID21536( var_4, var_0 );
        }

        if ( _ID21518( var_1.origin ) )
            continue;

        var_5 = vectornormalize( var_1.origin - self.origin );

        if ( !var_2 && !movable_cover_move_delay( self._ID31267, var_4, var_0, var_5 ) )
            continue;

        var_6 = distance( self.origin, var_1.origin );
        var_7 = var_6 / self._ID20707;

        if ( var_2 && self._ID31533 && !isdefined( self._ID34764 ) )
            continue;

        if ( self.moving )
            continue;

        if ( self._ID34571 )
            self connectpaths();

        _ID21522();
        self.moving = 1;
        self._ID31533 = 0;
        self notify( "move_start" );
        var_8 = gettime();
        var_9 = min( var_7, self.accel_time );

        if ( var_2 )
            var_9 = var_7;

        var_10 = _ID21525( "start" );

        if ( isdefined( var_10 ) )
            self playsound( var_10 );

        var_11 = _ID21525( "move" );

        if ( isdefined( var_11 ) )
            self playloopsound( var_11 );

        if ( isdefined( self.animate_ent ) && isdefined( level._ID21531[self.movable_type]["move"] ) )
            self.animate_ent scriptmodelplayanim( level._ID21531[self.movable_type]["move"] );

        self moveto( var_1.origin, var_7, var_9 );

        if ( var_2 )
            movable_cover_wait_for_user_or_timeout( var_7 );
        else
        {
            while ( _ID21528( var_4, var_0, var_5 ) && !_ID21518( var_1.origin ) )
                wait 0.05;

            _ID21536( undefined, undefined );
        }

        if ( !_ID21518( var_1.origin ) )
        {
            var_12 = _ID21519( ( gettime() - var_8 ) / 1000, var_7, var_9 );
            var_13 = self._ID20707 * var_12;
            var_6 = distance( self.origin, var_1.origin );
            var_14 = var_6;

            if ( var_13 > 0 )
                var_14 = min( var_6, var_13 * self._ID9268 );

            var_7 = 2 * var_14 / self._ID20707;
            self moveto( self.origin + var_14 * var_5, var_7, 0, var_7 );
            wait(var_7);
        }

        self stoploopsound();
        var_15 = _ID21525( "stop" );

        if ( isdefined( var_15 ) )
            self playsound( var_15 );

        if ( isdefined( self.animate_ent ) && isdefined( level._ID21531[self.movable_type]["idle"] ) )
            self.animate_ent scriptmodelplayanim( level._ID21531[self.movable_type]["idle"] );

        if ( var_3 && _ID21518( var_1.origin ) )
            self._ID31533 = 1;

        if ( self._ID34571 )
            self disconnectpaths();

        _ID21520();
        self.moving = 0;
        self notify( "move_end" );
    }
}

_ID21520()
{
    _ID21522();

    foreach ( var_1 in self._ID33485 )
    {
        switch ( var_1._ID22092 )
        {
            case "closest":
                var_1._ID7866 = common_scripts\utility::_ID14934( var_1.origin, var_1.connected_nodes );
                break;
            case "radius":
            case "radius3d":
                var_2 = distance( var_1.origin, var_1._ID32844 );

                if ( var_2 <= var_1._ID32846 )
                    var_1._ID7866 = var_1.connected_nodes[0];

                break;
            case "radius2d":
                var_3 = distance2d( var_1.origin, var_1._ID32844 );

                if ( var_3 <= var_1._ID32846 )
                    var_1._ID7866 = var_1.connected_nodes[0];

                break;
            default:
                break;
        }

        if ( isdefined( var_1._ID7866 ) )
            connectnodepair( var_1, var_1._ID7866 );
    }
}

_ID21522()
{
    foreach ( var_1 in self._ID33485 )
    {
        if ( isdefined( var_1._ID7866 ) )
        {
            disconnectnodepair( var_1, var_1._ID7866 );
            var_1._ID7866 = undefined;
        }
    }
}

_ID21525( var_0 )
{
    if ( !isdefined( level._ID21533[self.movable_type] ) )
        return undefined;

    return level._ID21533[self.movable_type][var_0];
}

movable_cover_wait_for_user_or_timeout( var_0 )
{
    self endon( "new_user" );
    wait(var_0);
}

_ID21519( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( var_0 >= var_1 || var_0 <= 0 )
        return 0;
    else if ( var_0 < var_2 )
        return 1 - ( var_2 - var_0 ) / var_2;
    else if ( var_0 > var_1 - var_3 )
        return 1 - ( var_0 - ( var_1 - var_3 ) ) / var_3;
    else
        return 1;
}

_ID21528( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) || !maps\mp\_utility::_ID18757( var_0 ) || !isplayer( var_0 ) )
        return 0;

    if ( !_ID21529( var_1, var_0 ) )
        return 0;

    if ( var_0 ismantling() )
        return 0;

    var_3 = var_0 getstance();

    if ( !common_scripts\utility::array_contains( self.stances, var_3 ) )
        return 0;

    if ( self._ID26064 )
    {
        var_4 = var_0 getnormalizedmovement();
        var_4 = rotatevector( var_4, -1 * var_0.angles );
        var_4 = vectornormalize( ( var_4[0], -1 * var_4[1], 0 ) );
        var_5 = vectordot( var_2, var_4 );
        return var_5 > 0.2;
    }
    else
        return 1;
}

_ID21529( var_0, var_1 )
{
    return isdefined( var_1 ) && maps\mp\_utility::_ID18757( var_1 ) && var_1 istouching( var_0 );
}

movable_cover_move_delay( var_0, var_1, var_2, var_3 )
{
    var_4 = var_0 * 1000 + gettime();

    for (;;)
    {
        if ( !isdefined( var_1 ) || !maps\mp\_utility::_ID18757( var_1 ) )
            return 0;

        if ( var_1 ismantling() )
            return 0;

        if ( !_ID21528( var_1, var_2, var_3 ) )
            return 0;

        if ( self.moving )
            return 0;

        if ( gettime() >= var_4 )
            return 1;

        wait 0.05;
    }
}

_ID21518( var_0 )
{
    var_1 = distancesquared( self.origin, var_0 );
    return var_1 <= self._ID15719 * self._ID15719;
}

_ID21530( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "move_start" );

        if ( isdefined( var_0 ) )
        {
            var_0._ID22672 = var_0 setcontents( 0 );
            var_0 hide();
        }

        self waittill( "move_end" );

        if ( isdefined( var_0 ) )
        {
            var_0 show();
            var_0 setcontents( var_0._ID22672 );
        }
    }
}
