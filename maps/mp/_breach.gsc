// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    thread _ID20478();
}

_ID20478()
{
    breach_precache();
    common_scripts\utility::_ID35582();
    var_0 = common_scripts\utility::_ID15386( "breach", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::breach_init );
}

breach_precache()
{
    level.breach_icon_count = -1;
    level._ID1644["default"] = loadfx( "fx/explosions/breach_room_cheap" );
}

breach_init()
{
    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
        return;

    if ( !isdefined( self.target ) )
        return;

    self.breach_targets = [];
    self.auto_breach_gametypes = [];

    if ( isdefined( self.script_noteworthy ) )
    {
        var_0 = strtok( self.script_noteworthy, "," );

        foreach ( var_2 in var_0 )
        {
            if ( getsubstr( var_2, 0, 7 ) == "not_in_" )
                self.auto_breach_gametypes[self.auto_breach_gametypes.size] = getsubstr( var_2, 7, var_2.size );

            if ( var_2 == "only_if_allowClassChoice" )
            {
                if ( !maps\mp\_utility::allowclasschoice() )
                    self.auto_breach_gametypes[self.auto_breach_gametypes.size] = level._ID14086;
            }
        }
    }

    var_4 = getentarray( self.target, "targetname" );
    var_5 = common_scripts\utility::_ID15386( self.target, "targetname" );
    var_6 = common_scripts\utility::array_combine( var_4, var_5 );
    var_7 = maps\mp\_utility::getlinknamenodes();

    foreach ( var_9 in var_7 )
        var_9._ID18729 = 1;

    var_6 = common_scripts\utility::array_combine( var_6, var_7 );

    foreach ( var_12 in var_6 )
    {
        if ( !isdefined( var_12.script_noteworthy ) )
            var_12.script_noteworthy = var_12.classname;

        if ( var_12.script_noteworthy == "trigger_use_touch" )
        {
            var_12 usetriggerrequirelookat();
            var_12.script_noteworthy = "trigger_use";
        }

        if ( !isdefined( var_12._ID18729 ) || var_12._ID18729 == 0 )
            var_12.script_noteworthy = tolower( var_12.script_noteworthy );

        var_13 = strtok( var_12.script_noteworthy, ", " );

        foreach ( var_15 in var_13 )
        {
            var_16 = undefined;
            var_0 = strtok( var_15, "_" );

            if ( var_0.size >= 3 && var_0[var_0.size - 2] == "on" )
            {
                var_16 = var_0[var_0.size - 1];
                var_15 = var_0[0];

                for ( var_17 = 1; var_17 < var_0.size - 2; var_17++ )
                    var_15 = var_15 + "_" + var_0[var_17];
            }

            var_18 = 0;
            var_0 = strtok( var_15, "_" );

            if ( var_0.size >= 2 && var_0[var_0.size - 1] == "useside" )
            {
                var_18 = 1;
                var_15 = var_0[0];

                for ( var_17 = 1; var_17 < var_0.size - 2; var_17++ )
                    var_15 = var_15 + "_" + var_0[var_17];
            }

            add_breach_target( var_12, var_15, var_16, var_18 );

            switch ( var_15 )
            {
                case "show":
                case "animated":
                    var_12 hide();
                    continue;
                case "solid":
                    if ( isdefined( var_12.spawnflags ) && var_12.spawnflags & 2 )
                        var_12 setaisightlinevisible( 0 );

                    var_12 notsolid();
                    continue;
                case "teleport_show":
                    var_12 common_scripts\utility::_ID33657();
                    continue;
                case "use_icon":
                    continue;
                case "trigger_damage":
                    thread breach_damage_watch( var_12 );
                    continue;
                case "fx":
                    if ( !isdefined( var_12.angles ) )
                        var_12.angles = ( 0, 0, 0 );

                    continue;
                case "connect_node":
                    var_12 disconnectnode();
                    continue;
                case "disconnect_node":
                    var_12 connectnode();
                    continue;
                case "delete":
                    if ( isdefined( var_12.spawnflags ) && var_12.spawnflags & 2 )
                        var_12 setaisightlinevisible( 1 );

                    continue;
                default:
                    continue;
            }
        }
    }

    if ( level._ID8425 )
        return;

    var_21 = get_breach_target( "trigger_use" );

    if ( isdefined( var_21 ) )
    {
        if ( !isdefined( get_breach_target( "sound" ) ) )
        {
            var_22 = spawn( "script_origin", var_21.origin );
            add_breach_target( var_22, "sound" );
        }

        if ( !isdefined( get_breach_target( "damage" ) ) )
        {
            var_23 = spawnstruct();
            var_23.origin = var_21.origin;
            add_breach_target( var_23, "damage" );
        }

        var_24 = _ID14330( "damage" );

        foreach ( var_23 in var_24 )
        {
            if ( !isdefined( var_23.radius ) )
                var_23.radius = 128;

            if ( !isdefined( var_23._ID20694 ) )
                var_23._ID20694 = 100;

            if ( !isdefined( var_23._ID21035 ) )
                var_23._ID21035 = 1;
        }

        thread _ID6050();
    }

    thread breach_on_activate();
    breach_on_event( "init" );

    foreach ( var_15 in self.auto_breach_gametypes )
    {
        if ( level._ID14086 == var_15 )
        {
            self notify( "breach_activated",  undefined, 1  );
            break;
        }
    }
}

add_breach_target( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = "activate";

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( self.breach_targets[var_2] ) )
        self.breach_targets[var_2] = [];

    if ( !isdefined( self.breach_targets[var_2][var_1] ) )
        self.breach_targets[var_2][var_1] = [];

    var_4 = spawnstruct();
    var_4.target = var_0;

    if ( var_3 )
    {
        var_4.facing_dot = 0;
        var_4._ID12583 = 0;
        var_4._ID12584 = anglestoforward( var_0.angles );

        if ( isdefined( var_0.target ) )
        {
            var_5 = common_scripts\utility::_ID15386( var_0.target, "targetname" );

            foreach ( var_7 in var_5 )
            {
                if ( !isdefined( var_7.script_noteworthy ) )
                    continue;

                switch ( var_7.script_noteworthy )
                {
                    case "angles":
                    case "angles_3d":
                        var_4._ID12583 = 1;
                    case "angles_2d":
                        if ( !isdefined( var_4.angles3d ) )
                            var_4._ID12583 = 0;

                        var_4._ID12584 = anglestoforward( var_7.angles );

                        if ( isdefined( var_7._ID27542 ) )
                            var_4.facing_dot = var_7._ID27542;

                        continue;
                    default:
                        continue;
                }
            }
        }
    }

    var_9 = self.breach_targets[var_2][var_1].size;
    self.breach_targets[var_2][var_1][var_9] = var_4;
}

get_breach_target( var_0, var_1, var_2 )
{
    var_3 = _ID14330( var_0, var_1, var_2 );

    if ( var_3.size > 0 )
        return var_3[0];
    else
        return undefined;
}

_ID14330( var_0, var_1, var_2 )
{
    var_3 = [];

    if ( !isdefined( var_1 ) )
        var_1 = "activate";

    if ( !isdefined( self.breach_targets[var_1] ) )
        return var_3;

    if ( !isdefined( self.breach_targets[var_1][var_0] ) )
        return var_3;

    foreach ( var_5 in self.breach_targets[var_1][var_0] )
    {
        if ( isdefined( var_5._ID12584 ) && isdefined( var_2 ) )
        {
            var_6 = var_2.origin - var_5.target.origin;

            if ( !var_5._ID12583 )
                var_6 = ( var_6[0], var_6[1], 0 );

            var_6 = vectornormalize( var_6 );
            var_7 = vectordot( var_6, var_5._ID12584 );

            if ( var_7 < var_5.facing_dot )
                continue;
        }

        var_3[var_3.size] = var_5.target;
    }

    return var_3;
}

breach_damage_watch( var_0 )
{
    self endon( "breach_activated" );
    var_0 waittill( "trigger",  var_1  );
    self notify( "breach_activated",  var_1, 0  );
}

breach_on_activate()
{
    self waittill( "breach_activated",  var_0, var_1  );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( isdefined( self._ID34758 ) && !var_1 )
    {
        self._ID34758 breach_set_2dicon( "hud_grenadeicon_back_red" );
        self._ID34758 maps\mp\_utility::_ID9519( 3, ::breach_set_2dicon, undefined );
    }

    breach_on_event( "activate", var_0, var_1 );

    if ( isdefined( self._ID34758 ) )
        self._ID34758._ID35361 = [];

    breach_set_can_use( 0 );
}

breach_on_event( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( var_0 == "use" )
    {
        var_3 = _ID14330( "damage", "activate", var_1 );

        foreach ( var_5 in var_3 )
            var_5._ID23707 = 1;
    }

    common_scripts\utility::array_call( _ID14330( "solid", var_0, var_1 ), ::solid );
    common_scripts\utility::array_call( _ID14330( "notsolid", var_0, var_1 ), ::notsolid );
    common_scripts\utility::_ID3867( _ID14330( "hide", var_0, var_1 ), ::breach_hide );
    common_scripts\utility::_ID3867( _ID14330( "show", var_0, var_1 ), ::breach_show );
    common_scripts\utility::_ID3867( _ID14330( "teleport_show", var_0, var_1 ), common_scripts\utility::_ID33659 );
    common_scripts\utility::_ID3867( _ID14330( "delete", var_0, var_1 ), ::_ID5941 );
    common_scripts\utility::_ID3867( _ID14330( "teleport_hide", var_0, var_1 ), common_scripts\utility::_ID33657 );
    common_scripts\utility::array_call( _ID14330( "connect_node", var_0, var_1 ), ::connectnode );
    common_scripts\utility::array_call( _ID14330( "disconnect_node", var_0, var_1 ), ::disconnectnode );
    common_scripts\utility::_ID3867( _ID14330( "break_glass", var_0, var_1 ), ::_ID5929 );
    common_scripts\utility::_ID3867( _ID14330( "animated", var_0, var_1 ), ::_ID36888 );

    if ( !var_2 )
    {
        common_scripts\utility::_ID3867( _ID14330( "fx", var_0, var_1 ), ::_ID6020, self );
        common_scripts\utility::_ID3867( _ID14330( "damage", var_0, var_1 ), ::breach_damage_radius, var_1 );
    }
}

_ID5941()
{
    if ( isdefined( self._ID27651 ) )
        common_scripts\utility::exploder( self._ID27651 );

    self setaisightlinevisible( 0 );
    self delete();
}

breach_hide()
{
    self setaisightlinevisible( 0 );
    self hide();
}

breach_show()
{
    self setaisightlinevisible( 1 );
    self show();
}

_ID6020( var_0 )
{
    var_1 = undefined;

    if ( isdefined( self._ID27611 ) )
        var_1 = self._ID27611;
    else if ( isdefined( var_0._ID27611 ) )
        var_1 = var_0._ID27611;

    if ( !isdefined( var_1 ) || !isdefined( level._ID1644[var_1] ) )
        var_1 = "default";

    playfx( level._ID1644[var_1], self.origin, anglestoforward( self.angles ), anglestoup( self.angles ) );
}

breach_damage_radius( var_0 )
{
    var_1 = 2.0;

    if ( isdefined( self._ID23707 ) && self._ID23707 == 1 )
    {
        foreach ( var_3 in level._ID23303 )
        {
            var_4 = distancesquared( self.origin, var_3.origin );

            if ( var_4 < self.radius * self.radius )
                var_3 shellshock( "mp_radiation_high", var_1 );
        }
    }

    playrumbleonposition( "artillery_rumble", self.origin );
}

_ID5929()
{
    glassradiusdamage( self.origin, 128, 500, 500 );
}

_ID36888()
{
    self setaisightlinevisible( 1 );
    self show();

    if ( isdefined( self._ID3571 ) )
        self scriptmodelplayanim( self._ID3571 );
}

_ID6050()
{
    self endon( "breach_activated" );
    wait 0.05;
    self._ID34758 = maps\mp\gametypes\_gameobjects::_ID8493( "neutral", get_breach_target( "trigger_use" ), _ID14330( "use_model" ), ( 0, 0, 0 ) );
    self._ID34758._ID23270 = self;
    self._ID34758._ID34784 = "breach_plant_mp";
    self._ID34758._ID17334 = "breach";
    breach_set_can_use( 1 );
    self._ID34758 maps\mp\gametypes\_gameobjects::_ID29198( 0.5 );
    self._ID34758 maps\mp\gametypes\_gameobjects::_ID29197( &"MP_BREACHING" );
    self._ID34758 maps\mp\gametypes\_gameobjects::_ID29196( &"MP_BREACH" );
    self._ID34758 maps\mp\gametypes\_gameobjects::_ID29202( "any" );
    self._ID34758._ID22916 = ::breach_onuse;
    self._ID34758._ID22816 = ::breach_onenduse;
}

breach_set_can_use( var_0 )
{
    if ( !isdefined( self._ID34758 ) )
        return;

    if ( var_0 )
    {
        foreach ( var_2 in self._ID34758._ID35361 )
        {
            if ( var_2.model == "mil_semtex_belt" )
                var_2 setmodel( "mil_semtex_belt_obj" );
        }

        self._ID34758 maps\mp\gametypes\_gameobjects::allowuse( "any" );
    }
    else
    {
        foreach ( var_2 in self._ID34758._ID35361 )
        {
            if ( var_2.model == "mil_semtex_belt" )
                var_2 setmodel( "mil_semtex_belt" );
        }

        self._ID34758 notify( "disabled" );
        self._ID34758 maps\mp\gametypes\_gameobjects::allowuse( "none" );
    }
}

breach_onuse( var_0 )
{
    self._ID23270 endon( "breach_activated" );
    self._ID23270 notify( "breach_used" );
    self._ID23270 breach_set_can_use( 0 );
    self._ID23270 breach_on_event( "use", var_0 );
    self._ID23270 thread _ID6055( self );
    var_1 = undefined;
    var_2 = self._ID23270 _ID14330( "sound" );

    if ( var_2.size > 1 )
    {
        var_2 = sortbydistance( var_2, var_0.origin );
        var_1 = var_2[0];
    }
    else if ( var_2.size > 0 )
        var_1 = var_2[0];

    var_3 = var_0.team;

    if ( isdefined( var_1 ) )
    {
        for ( var_4 = 0; var_4 < 3; var_4++ )
        {
            var_1 playsound( "breach_beep" );
            wait 0.75;
        }

        if ( isdefined( var_1._ID27766 ) )
        {
            var_5 = strtok( var_1._ID27766, ";" );

            foreach ( var_7 in var_5 )
            {
                var_8 = strtok( var_7, "=" );

                if ( var_8.size < 2 )
                    continue;

                switch ( var_8[0] )
                {
                    case "play_sound":
                        switch ( var_8[1] )
                        {
                            case "concrete":
                                var_1 playsound( "detpack_explo_concrete" );
                                break;
                            case "wood":
                                var_1 playsound( "detpack_explo_wood" );
                                break;
                            case "custom":
                                if ( var_8.size == 3 )
                                    var_1 playsound( var_8[2] );

                                break;
                            case "undefined":
                            case "metal":
                            default:
                                var_1 playsound( "detpack_explo_metal" );
                                break;
                        }

                        continue;
                    default:
                        continue;
                }
            }
        }
        else
            var_1 playsound( "detpack_explo_metal" );
    }

    self._ID23270 notify( "breach_activated",  var_0, undefined, var_3  );
}

breach_onenduse( var_0, var_1, var_2 )
{
    if ( isplayer( var_1 ) )
        var_1 maps\mp\gametypes\_gameobjects::_ID34638( self, 0 );
}

breach_set_2dicon( var_0 )
{
    maps\mp\gametypes\_gameobjects::_ID28180( "enemy", var_0 );
    maps\mp\gametypes\_gameobjects::_ID28180( "friendly", var_0 );
}

_ID6055( var_0 )
{
    var_1 = var_0.curorigin + ( 0, 0, 5 );

    if ( var_0._ID23270 _ID14330( "use_icon" ).size )
        var_1 = var_0._ID23270 _ID14330( "use_icon" )[0].origin;

    var_0._ID23270 thread breach_icon( "warning", var_1, undefined, "breach_activated" );
}

breach_icon( var_0, var_1, var_2, var_3 )
{
    if ( level._ID8425 )
        return;

    level.breach_icon_count++;
    var_4 = "breach_icon_" + level.breach_icon_count;
    breach_icon_update( var_0, var_1, var_2, var_4, var_3 );

    foreach ( var_6 in level.players )
    {
        if ( isdefined( var_6.breach_icons ) && isdefined( var_6.breach_icons[var_4] ) )
            var_6.breach_icons[var_4] thread breach_icon_fade_out();
    }
}

breach_icon_update( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_4 ) )
    {
        if ( isstring( var_4 ) )
            var_4 = [ var_4 ];

        foreach ( var_6 in var_4 )
            self endon( var_6 );
    }

    var_8 = 100;
    var_9 = 70;
    var_10 = "hud_grenadeicon";
    var_11 = 1;

    switch ( var_0 )
    {
        case "use":
            var_8 = 300;
            var_10 = "breach_icon";
            var_11 = 0;
            break;
        case "warning":
            var_8 = 400;
            var_12 = get_breach_target( "damage" );

            if ( isdefined( var_12 ) )
                var_8 = var_12.radius;

            var_10 = "hud_grenadeicon";
            var_11 = 1;
            break;
        default:
            break;
    }

    var_13 = undefined;

    if ( isdefined( var_2 ) )
        var_13 = anglestoforward( var_2 );

    for (;;)
    {
        foreach ( var_15 in level.players )
        {
            if ( !isdefined( var_15.breach_icons ) )
                var_15.breach_icons = [];

            if ( breach_icon_update_is_player_in_range( var_15, var_1, var_8, var_13, var_9 ) )
            {
                if ( !isdefined( var_15.breach_icons[var_3] ) )
                {
                    var_15.breach_icons[var_3] = breach_icon_create( var_15, var_10, var_1, var_11 );
                    var_15.breach_icons[var_3].alpha = 0;
                }

                var_15.breach_icons[var_3] notify( "stop_fade" );
                var_15.breach_icons[var_3] thread breach_icon_fade_in();
                continue;
            }

            if ( isdefined( var_15.breach_icons[var_3] ) )
                var_15.breach_icons[var_3] thread breach_icon_fade_out();
        }

        wait 0.05;
    }
}

breach_icon_update_is_player_in_range( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = var_0.origin + ( 0, 0, 30 );

    if ( isdefined( var_4 ) && abs( var_5[2] - var_1[2] ) > var_4 )
        return 0;

    if ( isdefined( var_2 ) )
    {
        var_6 = var_2 * var_2;
        var_7 = distancesquared( var_5, var_1 );

        if ( var_7 > var_6 )
            return 0;
    }

    if ( isdefined( var_3 ) )
    {
        var_8 = var_5 - var_1;

        if ( vectordot( var_3, var_8 ) < 0 )
            return 0;
    }

    return 1;
}

breach_icon_create( var_0, var_1, var_2, var_3 )
{
    var_1 = var_0 maps\mp\gametypes\_hud_util::_ID8444( var_1, 16, 16 );
    var_1 setwaypoint( 1, var_3 );
    var_1.x = var_2[0];
    var_1.y = var_2[1];
    var_1.z = var_2[2];
    return var_1;
}

breach_icon_fade_in()
{
    self endon( "death" );

    if ( self.alpha == 1 )
        return;

    self fadeovertime( 0.5 );
    self.alpha = 1;
}

breach_icon_fade_out()
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
