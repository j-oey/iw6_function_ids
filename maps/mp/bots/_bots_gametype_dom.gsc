// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    _ID28940();
    _ID37979();
    level thread maps\mp\bots\_bots_util::_ID5691( maps\mp\bots\_bots_util::bot_valid_camp_assassin );
}

_ID28940()
{
    level.bot_funcs["crate_can_use"] = ::_ID37025;
    level.bot_funcs["gametype_think"] = ::_ID36838;
    level.bot_funcs["should_start_cautious_approach"] = ::_ID38020;
    level.bot_funcs["leader_dialog"] = ::_ID36836;
    level.bot_funcs["get_watch_node_chance"] = ::_ID36835;
    level.bot_funcs["commander_gametype_tactics"] = ::_ID36832;
}

_ID36855( var_0 )
{
    var_1 = 90000;

    if ( maps\mp\bots\_bots_util::bot_is_defending() && distance2dsquared( var_0, self.bot_defending_center ) < var_1 )
        return 1;

    if ( self bothasscriptgoal() )
    {
        var_2 = self botgetscriptgoal();

        if ( distance2dsquared( var_0, var_2 ) < var_1 )
            return 1;
    }

    return 0;
}

_ID37026( var_0 )
{
    if ( isagent( self ) )
    {
        if ( !isdefined( level._ID38045 ) || self.owner != level._ID38045 )
            return _ID37025();

        if ( !isdefined( var_0.boxtype ) && maps\mp\bots\_bots_util::bot_crate_is_command_goal( var_0 ) )
            return _ID36855( var_0.origin );

        return 0;
    }

    return _ID37025( var_0 );
}

_ID37025( var_0 )
{
    if ( isagent( self ) && !isdefined( var_0.boxtype ) )
        return 0;

    if ( !maps\mp\_utility::_ID18820( self ) )
        return 1;

    return maps\mp\bots\_bots_util::_ID5636();
}

_ID36832( var_0 )
{
    var_1 = 0;

    switch ( var_0 )
    {
        case "tactic_none":
            level._ID36837[self.team] = [];
            var_1 = 1;
            break;
        case "tactic_dom_holdA":
            level._ID36837[self.team] = [];
            level._ID36837[self.team][0] = _ID37331( "A" );
            var_1 = 1;
            break;
        case "tactic_dom_holdB":
            level._ID36837[self.team] = [];
            level._ID36837[self.team][0] = _ID37331( "B" );
            var_1 = 1;
            break;
        case "tactic_dom_holdC":
            level._ID36837[self.team] = [];
            level._ID36837[self.team][0] = _ID37331( "C" );
            var_1 = 1;
            break;
        case "tactic_dom_holdAB":
            level._ID36837[self.team] = [];
            level._ID36837[self.team][0] = _ID37331( "A" );
            level._ID36837[self.team][1] = _ID37331( "B" );
            var_1 = 1;
            break;
        case "tactic_dom_holdBC":
            level._ID36837[self.team] = [];
            level._ID36837[self.team][0] = _ID37331( "B" );
            level._ID36837[self.team][1] = _ID37331( "C" );
            var_1 = 1;
            break;
        case "tactic_dom_holdAC":
            level._ID36837[self.team] = [];
            level._ID36837[self.team][0] = _ID37331( "A" );
            level._ID36837[self.team][1] = _ID37331( "C" );
            var_1 = 1;
            break;
        case "tactic_dom_holdABC":
            level._ID36837[self.team] = [];
            level._ID36837[self.team][0] = _ID37331( "A" );
            level._ID36837[self.team][1] = _ID37331( "B" );
            level._ID36837[self.team][2] = _ID37331( "C" );
            var_1 = 1;
            break;
    }

    if ( var_1 )
    {
        foreach ( var_3 in level._ID23303 )
        {
            if ( !isdefined( var_3.team ) )
                continue;

            if ( maps\mp\_utility::_ID18540( var_3 ) && var_3.team == self.team )
                var_3._ID37226 = 1;
        }
    }
}

_ID37700()
{
    self notify( "monitor_zone_control" );
    self endon( "monitor_zone_control" );
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 1;
        var_0 = maps\mp\gametypes\dom::_ID15019();

        if ( var_0 != "neutral" )
        {
            var_1 = getzonenearest( self.origin );

            if ( isdefined( var_1 ) )
                botzonesetteam( var_1, var_0 );
        }
    }
}

_ID37694()
{
    self notify( "monitor_flag_ownership" );
    self endon( "monitor_flag_ownership" );
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = maps\mp\gametypes\dom::_ID15019();

    for (;;)
    {
        var_1 = maps\mp\gametypes\dom::_ID15019();

        if ( var_1 != var_0 )
            level notify( "flag_changed_ownership" );

        var_0 = var_1;
        wait 0.05;
    }
}

_ID37979()
{
    var_0 = _ID36845();

    if ( var_0.size > 3 )
    {
        while ( !isdefined( level._ID32722 ) )
            wait 0.05;

        var_1 = [];

        foreach ( var_3 in var_0 )
        {
            if ( !isdefined( var_1[var_3._ID32795] ) )
                var_1[var_3._ID32795] = [];

            var_1[var_3._ID32795] = common_scripts\utility::array_add( var_1[var_3._ID32795], var_3 );
        }

        foreach ( var_7, var_6 in var_1 )
        {
            level._ID12157 = 0;
            _ID36821( var_6 );
            maps\mp\bots\_bots_util::bot_cache_entrances_to_flags_or_radios( var_6, var_7 + "_flag" );
        }
    }
    else
    {
        maps\mp\bots\_bots_util::bot_cache_entrances_to_flags_or_radios( var_0, "flag" );
        _ID36821( var_0 );
    }

    foreach ( var_3 in var_0 )
    {
        var_3 thread _ID37700();
        var_3 thread _ID37694();

        if ( var_3._ID27658 != "_a" && var_3._ID27658 != "_b" && var_3._ID27658 != "_c" )
        {

        }

        var_3.nodes = gettnodesintrigger( var_3 );
        _ID36662( var_3 );
    }

    level._ID36837 = [];
    level._ID36837["axis"] = [];
    level._ID36837["allies"] = [];
    level._ID5597 = 1;
}

_ID36845()
{
    if ( isdefined( level.all_dom_flags ) )
        return level.all_dom_flags;
    else
        return level._ID13222;
}

_ID36821( var_0 )
{
    if ( !isdefined( level._ID37217 ) )
        level._ID37217 = [];

    for ( var_1 = 0; var_1 < var_0.size - 1; var_1++ )
    {
        for ( var_2 = var_1 + 1; var_2 < var_0.size; var_2++ )
        {
            var_3 = distance( var_0[var_1].origin, var_0[var_2].origin );
            var_4 = _ID37280( var_0[var_1] );
            var_5 = _ID37280( var_0[var_2] );
            level._ID37217[var_4][var_5] = var_3;
            level._ID37217[var_5][var_4] = var_3;
        }
    }
}

_ID36662( var_0 )
{
    if ( var_0.classname == "trigger_radius" )
    {
        var_1 = getnodesinradius( var_0.origin, var_0.radius, 0, 100 );
        var_2 = common_scripts\utility::array_remove_array( var_1, var_0.nodes );

        if ( var_2.size > 0 )
        {
            var_0.nodes = common_scripts\utility::array_combine( var_0.nodes, var_2 );
            return;
        }
    }
    else if ( var_0.classname == "trigger_multiple" )
    {
        var_3[0] = var_0 getpointinbounds( 1, 1, 1 );
        var_3[1] = var_0 getpointinbounds( 1, 1, -1 );
        var_3[2] = var_0 getpointinbounds( 1, -1, 1 );
        var_3[3] = var_0 getpointinbounds( 1, -1, -1 );
        var_3[4] = var_0 getpointinbounds( -1, 1, 1 );
        var_3[5] = var_0 getpointinbounds( -1, 1, -1 );
        var_3[6] = var_0 getpointinbounds( -1, -1, 1 );
        var_3[7] = var_0 getpointinbounds( -1, -1, -1 );
        var_4 = 0;

        foreach ( var_6 in var_3 )
        {
            var_7 = distance( var_6, var_0.origin );

            if ( var_7 > var_4 )
                var_4 = var_7;
        }

        var_1 = getnodesinradius( var_0.origin, var_4, 0, 100 );

        foreach ( var_10 in var_1 )
        {
            if ( !ispointinvolume( var_10.origin, var_0 ) )
            {
                if ( ispointinvolume( var_10.origin + ( 0, 0, 40 ), var_0 ) || ispointinvolume( var_10.origin + ( 0, 0, 80 ), var_0 ) || ispointinvolume( var_10.origin + ( 0, 0, 120 ), var_0 ) )
                    var_0.nodes = common_scripts\utility::array_add( var_0.nodes, var_10 );
            }
        }
    }
}

_ID38020( var_0 )
{
    if ( var_0 )
    {
        if ( self._ID37047 maps\mp\gametypes\dom::_ID15019() == "neutral" && _ID37219( self._ID37047 ) )
        {
            var_1 = _ID37262( self._ID19613.origin );

            if ( var_1 == self._ID37047 )
                return 0;
            else
            {
                var_2 = _ID37302( var_1, self._ID37047 );
                var_3 = distancesquared( var_1.origin, self._ID37047.origin );
                var_4 = distancesquared( var_2.origin, self._ID37047.origin );

                if ( var_3 < var_4 )
                    return 0;
            }
        }
    }

    return maps\mp\bots\_bots_strategy::_ID29840( var_0 );
}

_ID36833()
{
    return 0;
}

_ID36834()
{
    return 0;
}

_ID36838()
{
    self notify( "bot_dom_think" );
    self endon( "bot_dom_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( !isdefined( level._ID5597 ) )
        wait 0.05;

    self._ID37226 = 0;
    self._ID37726 = 0;
    self._ID37730 = 0;
    self botsetflag( "separation", 0 );
    self botsetflag( "grenade_objectives", 1 );
    self botsetflag( "use_obj_path_style", 1 );

    for (;;)
    {
        maps\mp\bots\_bots_util::_ID5815();
        var_0 = gettime();

        if ( var_0 > self._ID37730 )
        {
            self._ID37730 = gettime() + 10000;
            self._ID38124 = self botgetdifficultysetting( "strategyLevel" );
        }

        if ( var_0 > self._ID37726 || self._ID37226 )
        {
            if ( _ID38015() )
                self._ID37726 = var_0 + 5000;
            else
            {
                self._ID37226 = 0;
                _ID36827();
                self._ID37726 = var_0 + randomintrange( 30000, 45000 );
            }
        }

        common_scripts\utility::waittill_notify_or_timeout( "needs_new_flag_goal", 1.0 );
    }
}

_ID38015()
{
    if ( self._ID37226 )
        return 0;

    if ( !maps\mp\bots\_bots_util::bot_is_capturing() )
        return 0;

    if ( self._ID37047 maps\mp\gametypes\dom::_ID15019() == self.team )
        return 0;

    var_0 = _ID37279();

    if ( distancesquared( self.origin, self._ID37047.origin ) < var_0 * 2 * ( var_0 * 2 ) )
    {
        var_1 = _ID37257( self.team );

        if ( var_1.size == 2 && !common_scripts\utility::array_contains( var_1, self._ID37047 ) && !_ID36818() )
            return 0;

        return 1;
    }

    return 0;
}

_ID37303()
{
    return level._ID36837[self.team];
}

_ID37416()
{
    var_0 = _ID37303();
    return var_0.size > 0;
}

_ID37218( var_0 )
{
    return !_ID37219( var_0 );
}

_ID37219( var_0 )
{
    return var_0._ID34757.firstcapture;
}

_ID36827()
{
    var_0 = undefined;
    var_1 = [];
    var_2 = [];
    var_3 = 1;
    var_4 = _ID37303();

    if ( var_4.size > 0 )
        var_5 = var_4;
    else
        var_5 = level._ID13222;

    for ( var_6 = 0; var_6 < var_5.size; var_6++ )
    {
        var_7 = var_5[var_6] maps\mp\gametypes\dom::_ID15019();

        if ( var_3 )
        {
            if ( _ID37218( var_5[var_6] ) )
                var_3 = 0;
            else
            {

            }
        }

        if ( var_7 != self.team )
        {
            var_1[var_1.size] = var_5[var_6];
            continue;
        }

        var_2[var_2.size] = var_5[var_6];
    }

    var_8 = undefined;

    if ( var_1.size == 3 )
        var_8 = 1;
    else if ( var_1.size == 2 )
    {
        if ( var_2.size == 1 )
        {
            if ( !_ID36880( var_2[0], 1 ) )
                var_8 = 1;
            else
                var_8 = !_ID36879( 0.34 );
        }
        else if ( var_2.size == 0 )
            var_8 = 1;
    }
    else if ( var_1.size == 1 )
    {
        if ( var_2.size == 2 )
        {
            if ( _ID36818() )
            {
                if ( !_ID36880( var_2[0], 2 ) && !_ID36880( var_2[1], 2 ) )
                    var_8 = 1;
                else if ( self._ID38124 == 0 )
                    var_8 = !_ID36879( 0.34 );
                else
                    var_8 = !_ID36879( 0.5 );
            }
            else
                var_8 = 0;
        }
        else if ( var_2.size == 1 )
        {
            if ( !_ID36880( var_2[0], 1 ) )
                var_8 = 1;
            else
                var_8 = !_ID36879( 0.34 );
        }
        else if ( var_2.size == 0 )
            var_8 = 1;
    }
    else if ( var_1.size == 0 )
        var_8 = 0;

    if ( var_8 )
    {
        if ( var_1.size > 1 )
            var_9 = common_scripts\utility::_ID14293( self.origin, var_1 );
        else
            var_9 = var_1;

        if ( var_3 && !_ID37416() )
        {
            var_10 = _ID37299( var_9[0], 1 );

            if ( var_10 < 2 )
                var_11 = 0;
            else
            {
                var_12 = 20;
                var_13 = 65;
                var_14 = 15;

                if ( self._ID38124 == 0 )
                {
                    var_12 = 50;
                    var_13 = 25;
                    var_14 = 25;
                }

                var_15 = randomint( 100 );

                if ( var_15 < var_12 )
                    var_11 = 0;
                else if ( var_15 < var_12 + var_13 )
                    var_11 = 1;
                else
                    var_11 = 2;
            }

            var_16 = undefined;

            if ( var_11 == 0 )
                var_16 = "critical";

            _ID36947( var_9[var_11], var_16 );
            return;
        }

        if ( var_9.size == 1 )
            var_0 = var_9[0];
        else if ( distancesquared( var_9[0].origin, self.origin ) < 102400 )
            var_0 = var_9[0];
        else
        {
            var_17 = [];
            var_18 = [];

            for ( var_6 = 0; var_6 < var_9.size; var_6++ )
            {
                var_19 = distance( var_9[var_6].origin, self.origin );
                var_18[var_6] = var_19;
                var_17[var_6] = var_19;
            }

            if ( var_2.size == 1 )
            {
                var_20 = 1.5;

                for ( var_6 = 0; var_6 < var_17.size; var_6++ )
                    var_17[var_6] += level._ID37217[_ID37280( var_9[var_6] )][_ID37280( var_2[0] )] * var_20;
            }

            if ( self._ID38124 == 0 )
            {
                var_15 = randomint( 100 );

                if ( var_15 < 50 )
                    var_0 = var_9[0];
                else if ( var_15 < 50 + 50 / ( var_9.size - 1 ) )
                    var_0 = var_9[1];
                else
                    var_0 = var_9[2];
            }
            else if ( var_17.size == 2 )
            {
                var_21[0] = 50;
                var_21[1] = 50;

                for ( var_6 = 0; var_6 < var_9.size; var_6++ )
                {
                    if ( var_17[var_6] < var_17[1 - var_6] )
                    {
                        var_21[var_6] += 20;
                        var_21[1 - var_6] = var_21[1 - var_6] - 20;
                    }

                    if ( var_18[var_6] < 640 )
                    {
                        var_21[var_6] += 15;
                        var_21[1 - var_6] = var_21[1 - var_6] - 15;
                    }

                    if ( var_9[var_6] maps\mp\gametypes\dom::_ID15019() == "neutral" )
                    {
                        var_21[var_6] += 15;
                        var_21[1 - var_6] = var_21[1 - var_6] - 15;
                    }
                }

                var_15 = randomint( 100 );

                if ( var_15 < var_21[0] )
                    var_0 = var_9[0];
                else
                    var_0 = var_9[1];
            }
            else if ( var_17.size == 3 )
            {
                var_21[0] = 34;
                var_21[1] = 33;
                var_21[2] = 33;

                for ( var_6 = 0; var_6 < var_9.size; var_6++ )
                {
                    var_22 = ( var_6 + 1 ) % 3;
                    var_23 = ( var_6 + 2 ) % 3;

                    if ( var_17[var_6] < var_17[var_22] && var_17[var_6] < var_17[var_23] )
                    {
                        var_21[var_6] += 36;
                        var_21[var_22] -= 18;
                        var_21[var_23] -= 18;
                    }

                    if ( var_18[var_6] < 640 )
                    {
                        var_21[var_6] += 15;
                        var_21[var_22] -= 7;
                        var_21[var_23] -= 8;
                    }

                    if ( var_9[var_6] maps\mp\gametypes\dom::_ID15019() == "neutral" )
                    {
                        var_21[var_6] += 15;
                        var_21[var_22] -= 7;
                        var_21[var_23] -= 8;
                    }
                }

                var_15 = randomint( 100 );

                if ( var_15 < var_21[0] )
                    var_0 = var_9[0];
                else if ( var_15 < var_21[0] + var_21[1] )
                    var_0 = var_9[1];
                else
                    var_0 = var_9[2];
            }
        }
    }
    else
    {
        if ( var_2.size > 1 )
            var_24 = common_scripts\utility::_ID14293( self.origin, var_2 );
        else
            var_24 = var_2;

        foreach ( var_26 in var_24 )
        {
            if ( _ID36880( var_26, var_2.size ) )
            {
                var_0 = var_26;
                break;
            }
        }

        if ( !isdefined( var_0 ) )
        {
            if ( self._ID38124 == 0 )
                var_0 = var_2[0];
            else if ( var_24.size == 2 )
            {
                var_28 = _ID37302( var_24[0], var_24[1] );
                var_29 = common_scripts\utility::_ID14293( var_28.origin, var_24 );
                var_15 = randomint( 100 );

                if ( var_15 < 70 )
                    var_0 = var_29[0];
                else
                    var_0 = var_29[1];
            }
            else
                var_0 = var_24[0];
        }
    }

    if ( var_8 )
        _ID36947( var_0 );
    else
        _ID37089( var_0 );
}

_ID36818()
{
    if ( self._ID38124 == 0 )
        return 1;

    var_0 = _ID37303();

    if ( var_0.size == 3 )
        return 1;

    var_1 = maps\mp\gametypes\_gamescore::_ID1699( common_scripts\utility::_ID14447( self.team ) );
    var_2 = maps\mp\gametypes\_gamescore::_ID1699( self.team );
    var_3 = 200 - var_1;
    var_4 = 200 - var_2;
    var_5 = var_4 * 0.5 > var_3;
    return var_5;
}

_ID36879( var_0 )
{
    if ( randomfloat( 1 ) < var_0 )
        return 1;

    var_1 = level._ID5724[self._ID23475];

    if ( var_1 == "stationary" )
        return 1;
    else if ( var_1 == "active" )
        return 0;
}

_ID36947( var_0, var_1, var_2 )
{
    self._ID37047 = var_0;

    if ( _ID36834() )
    {
        var_3["override_goal_type"] = var_1;
        var_3["entrance_points_index"] = _ID37280( var_0 );
        maps\mp\bots\_bots_strategy::bot_protect_point( var_0.origin, _ID37281(), var_3 );
    }
    else
    {
        var_3["override_goal_type"] = var_1;
        var_3["entrance_points_index"] = _ID37280( var_0 );
        maps\mp\bots\_bots_strategy::bot_capture_zone( var_0.origin, var_0.nodes, var_0, var_3 );
    }

    if ( !isdefined( var_2 ) || !var_2 )
        thread _ID37695( var_0 );
}

_ID37089( var_0 )
{
    self._ID37047 = var_0;

    if ( _ID36833() )
    {
        var_1["entrance_points_index"] = _ID37280( var_0 );
        maps\mp\bots\_bots_strategy::bot_capture_zone( var_0.origin, var_0.nodes, var_0, var_1 );
    }
    else
    {
        var_1["entrance_points_index"] = _ID37280( var_0 );
        var_1["nearest_node"] = var_0._ID21893;
        maps\mp\bots\_bots_strategy::bot_protect_point( var_0.origin, _ID37281(), var_1 );
    }

    thread _ID37695( var_0 );
}

_ID37279()
{
    if ( !isdefined( level._ID36948 ) )
        level._ID36948 = 158;

    return level._ID36948;
}

_ID37281()
{
    if ( !isdefined( level._ID25118 ) )
    {
        var_0 = self botgetworldsize();
        var_1 = ( var_0[0] + var_0[1] ) / 2;
        level._ID25118 = min( 1000, var_1 / 3.5 );
    }

    return level._ID25118;
}

_ID36836( var_0, var_1 )
{
    if ( issubstr( var_0, "losing" ) )
    {
        var_2 = getsubstr( var_0, var_0.size - 2 );
        var_3 = undefined;

        for ( var_4 = 0; var_4 < level._ID13222.size; var_4++ )
        {
            if ( var_2 == level._ID13222[var_4]._ID27658 )
                var_3 = level._ID13222[var_4];
        }

        if ( isdefined( var_3 ) && _ID36817( var_3 ) )
        {
            self botmemoryevent( "known_enemy", undefined, var_3.origin );

            if ( !isdefined( self._ID37598 ) || gettime() - self._ID37598 > 10000 )
            {
                if ( maps\mp\bots\_bots_util::_ID5636() )
                {
                    if ( distancesquared( self.origin, var_3.origin ) < 490000 )
                    {
                        _ID36947( var_3 );
                        self._ID37598 = gettime();
                    }
                }
            }
        }
    }

    maps\mp\bots\_bots_util::_ID5661( var_0, var_1 );
}

_ID36817( var_0 )
{
    var_1 = _ID37303();

    if ( var_1.size == 0 )
        return 1;

    if ( common_scripts\utility::array_contains( var_1, var_0 ) )
        return 1;

    return 0;
}

_ID37695( var_0 )
{
    self notify( "monitor_flag_status" );
    self endon( "monitor_flag_status" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_1 = _ID37301( self.team );
    var_2 = _ID37279() * _ID37279();
    var_3 = _ID37279() * 3 * ( _ID37279() * 3 );
    var_4 = 1;

    while ( var_4 )
    {
        var_5 = 0;
        var_6 = var_0 maps\mp\gametypes\dom::_ID15019();
        var_7 = _ID37301( self.team );
        var_8 = _ID37276( self.team );

        if ( maps\mp\bots\_bots_util::bot_is_capturing() )
        {
            if ( var_6 == self.team && var_0._ID34757._ID7317 == "none" )
            {
                if ( !_ID36833() )
                    var_5 = 1;
            }

            if ( var_7 == 2 && var_6 != self.team && !_ID36818() )
            {
                if ( distancesquared( self.origin, var_0.origin ) > var_2 )
                    var_5 = 1;
            }

            foreach ( var_10 in var_8 )
            {
                if ( var_10 != var_0 && _ID36817( var_10 ) )
                {
                    if ( distancesquared( self.origin, var_10.origin ) < var_3 )
                        var_5 = 1;
                }
            }

            if ( self istouching( var_0 ) && var_0._ID34757._ID34766 <= 0 )
            {
                if ( self bothasscriptgoal() )
                {
                    var_12 = self botgetscriptgoal();
                    var_13 = self botgetscriptgoalradius();

                    if ( distancesquared( self.origin, var_12 ) < squared( var_13 ) )
                    {
                        var_14 = self getnearestnode();

                        if ( isdefined( var_14 ) )
                        {
                            var_15 = undefined;

                            foreach ( var_17 in var_0.nodes )
                            {
                                if ( !nodesvisible( var_17, var_14 ) )
                                {
                                    var_15 = var_17.origin;
                                    break;
                                }
                            }

                            if ( isdefined( var_15 ) )
                            {
                                self._ID9467 = var_15;
                                self notify( "defend_force_node_recalculation" );
                            }
                        }
                    }
                }
            }
        }

        if ( maps\mp\bots\_bots_util::_ID5636() )
        {
            if ( var_6 != self.team )
            {
                if ( !_ID36834() )
                    var_5 = 1;
            }
            else if ( var_7 == 1 && var_1 > 1 )
                var_5 = 1;
        }

        var_1 = var_7;

        if ( var_5 )
        {
            self._ID37226 = 1;
            var_4 = 0;
            self notify( "needs_new_flag_goal" );
            continue;
        }

        var_19 = level common_scripts\utility::_ID35710( "flag_changed_ownership", 1 + randomfloatrange( 0, 2 ) );

        if ( !( isdefined( var_19 ) && var_19 == "timeout" ) )
        {
            var_20 = max( ( 3 - self._ID38124 ) * 1.0 + randomfloatrange( -0.5, 0.5 ), 0 );
            wait(var_20);
        }
    }
}

_ID36835( var_0 )
{
    if ( var_0 == self._ID22081 )
        return 1.0;

    if ( !isdefined( self._ID37047 ) )
        return 1.0;

    var_1 = 0;
    var_2 = _ID37280( self._ID37047 );
    var_3 = _ID37257( self.team );

    foreach ( var_5 in var_3 )
    {
        if ( var_5 != self._ID37047 )
        {
            var_1 = var_0 maps\mp\bots\_bots_util::_ID22085( var_2, _ID37280( var_5 ) );

            if ( var_1 )
            {
                var_6 = _ID37302( self._ID37047, var_5 );
                var_7 = var_6 maps\mp\gametypes\dom::_ID15019();

                if ( var_7 != self.team )
                {
                    if ( var_0 maps\mp\bots\_bots_util::_ID22085( var_2, _ID37280( var_6 ) ) )
                        var_1 = 0;
                }
            }
        }
    }

    if ( var_1 )
        return 0.2;

    return 1.0;
}

_ID37280( var_0 )
{
    var_1 = "";

    if ( isdefined( var_0._ID32795 ) )
        var_1 += ( var_0._ID32795 + "_" );

    var_1 += ( "flag" + var_0._ID27658 );
    return var_1;
}

_ID37302( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < level._ID13222.size; var_2++ )
    {
        if ( level._ID13222[var_2] != var_0 && level._ID13222[var_2] != var_1 )
            return level._ID13222[var_2];
    }
}

_ID37331( var_0 )
{
    var_0 = "_" + tolower( var_0 );

    for ( var_1 = 0; var_1 < level._ID13222.size; var_1++ )
    {
        if ( level._ID13222[var_1]._ID27658 == var_0 )
            return level._ID13222[var_1];
    }
}

_ID37262( var_0 )
{
    var_1 = undefined;
    var_2 = undefined;

    foreach ( var_4 in level._ID13222 )
    {
        var_5 = distancesquared( var_4.origin, var_0 );

        if ( !isdefined( var_2 ) || var_5 < var_2 )
        {
            var_1 = var_4;
            var_2 = var_5;
        }
    }

    return var_1;
}

_ID37299( var_0, var_1 )
{
    var_2 = 0;
    var_3 = _ID37279();

    foreach ( var_5 in level._ID23303 )
    {
        if ( !isdefined( var_5.team ) )
            continue;

        if ( var_5.team == self.team && var_5 != self && maps\mp\_utility::_ID18820( var_5 ) )
        {
            if ( isai( var_5 ) )
            {
                if ( var_5 _ID36856( var_0 ) )
                    var_2++;

                continue;
            }

            if ( !isdefined( var_1 ) || !var_1 )
            {
                if ( var_5 istouching( var_0 ) )
                    var_2++;
            }
        }
    }

    return var_2;
}

_ID36856( var_0 )
{
    if ( !maps\mp\bots\_bots_util::bot_is_capturing() )
        return 0;

    return _ID36885( var_0 );
}

_ID36857( var_0 )
{
    if ( !maps\mp\bots\_bots_util::_ID5636() )
        return 0;

    return _ID36885( var_0 );
}

_ID36885( var_0 )
{
    return self._ID37047 == var_0;
}

_ID37301( var_0 )
{
    var_1 = 0;

    for ( var_2 = 0; var_2 < level._ID13222.size; var_2++ )
    {
        var_3 = level._ID13222[var_2] maps\mp\gametypes\dom::_ID15019();

        if ( var_3 == var_0 )
            var_1++;
    }

    return var_1;
}

_ID37276( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < level._ID13222.size; var_2++ )
    {
        var_3 = level._ID13222[var_2] maps\mp\gametypes\dom::_ID15019();

        if ( var_3 == common_scripts\utility::_ID14447( var_0 ) )
            var_1 = common_scripts\utility::array_add( var_1, level._ID13222[var_2] );
    }

    return var_1;
}

_ID37257( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < level._ID13222.size; var_2++ )
    {
        var_3 = level._ID13222[var_2] maps\mp\gametypes\dom::_ID15019();

        if ( var_3 == var_0 )
            var_1 = common_scripts\utility::array_add( var_1, level._ID13222[var_2] );
    }

    return var_1;
}

_ID36880( var_0, var_1 )
{
    if ( var_1 == 1 )
        var_2 = 1;
    else
        var_2 = 2;

    var_3 = _ID37259( var_0 );
    return var_3.size < var_2;
}

_ID37259( var_0 )
{
    var_1 = _ID37281();
    var_2 = [];

    foreach ( var_4 in level._ID23303 )
    {
        if ( !isdefined( var_4.team ) )
            continue;

        if ( var_4.team == self.team && var_4 != self && maps\mp\_utility::_ID18820( var_4 ) )
        {
            if ( isai( var_4 ) )
            {
                if ( var_4 _ID36857( var_0 ) )
                    var_2 = common_scripts\utility::array_add( var_2, var_4 );

                continue;
            }

            if ( distancesquared( var_0.origin, var_4.origin ) < var_1 * var_1 )
                var_2 = common_scripts\utility::array_add( var_2, var_4 );
        }
    }

    return var_2;
}
