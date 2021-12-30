// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    _ID28940();
    _ID37978();
}

_ID28940()
{
    level.bot_funcs["gametype_think"] = ::_ID36830;
}

_ID37978()
{
    level._ID36884 = 200;
    level._ID36883 = 38;
}

_ID36830()
{
    self notify( "bot_conf_think" );
    self endon( "bot_conf_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self._ID37732 = gettime() + 500;
    self._ID38139 = [];
    childthread _ID36886();

    if ( self._ID23475 == "camper" )
    {
        self._ID36987 = 0;

        if ( !isdefined( self._ID36988 ) )
            self._ID36988 = 0;
    }

    for (;;)
    {
        var_0 = isdefined( self._ID38136 );
        var_1 = 0;

        if ( var_0 && self bothasscriptgoal() )
        {
            var_2 = self botgetscriptgoal();

            if ( maps\mp\bots\_bots_util::_ID5824( self._ID38136.curorigin, var_2 ) )
            {
                if ( self botpursuingscriptgoal() )
                    var_1 = 1;
            }
            else if ( maps\mp\bots\_bots_strategy::bot_has_tactical_goal( "kill_tag" ) && self._ID38136 maps\mp\gametypes\_gameobjects::_ID6602( self.team ) )
            {
                self._ID38136 = undefined;
                var_0 = 0;
            }
        }

        self botsetflag( "force_sprint", var_1 );
        self._ID38139 = _ID36872( self._ID38139 );
        var_3 = _ID36841( self._ID38139, 1 );
        var_4 = isdefined( var_3 );

        if ( var_0 && !var_4 || !var_0 && var_4 || var_0 && var_4 && self._ID38136 != var_3 )
        {
            self._ID38136 = var_3;
            self botclearscriptgoal();
            self notify( "stop_camping_tag" );
            maps\mp\bots\_bots_personality::_ID7425();
            maps\mp\bots\_bots_strategy::bot_abort_tactical_goal( "kill_tag" );
        }

        if ( isdefined( self._ID38136 ) )
        {
            self._ID36988 = 0;

            if ( self._ID23475 == "camper" && self._ID36987 )
            {
                self._ID36988 = 1;

                if ( maps\mp\bots\_bots_personality::_ID29836() )
                {
                    if ( maps\mp\bots\_bots_personality::_ID12890( self._ID38136.curorigin, 1000 ) )
                        childthread _ID36822( self._ID38136, "camp" );
                    else
                        self._ID36988 = 0;
                }
            }

            if ( !self._ID36988 )
            {
                if ( !maps\mp\bots\_bots_strategy::bot_has_tactical_goal( "kill_tag" ) )
                {
                    var_5 = spawnstruct();
                    var_5._ID27624 = "objective";
                    var_5._ID22485 = level._ID36884;
                    maps\mp\bots\_bots_strategy::bot_new_tactical_goal( "kill_tag", self._ID38136.curorigin, 25, var_5 );
                }
            }
        }

        var_6 = 0;

        if ( isdefined( self._ID36667 ) )
            var_6 = self [[ self._ID36667 ]]();

        if ( !isdefined( self._ID38136 ) )
        {
            if ( !var_6 )
                self [[ self._ID23477 ]]();
        }

        if ( gettime() > self._ID37732 )
        {
            self._ID37732 = gettime() + 500;
            var_7 = _ID36843( 1 );
            self._ID38139 = _ID36829( var_7, self._ID38139 );
        }

        wait 0.05;
    }
}

_ID36826( var_0 )
{
    if ( isdefined( var_0.on_path_grid ) && var_0.on_path_grid )
    {
        var_1 = self.origin + ( 0, 0, 55 );

        if ( distance2dsquared( var_0.curorigin, var_1 ) < 144 )
        {
            var_2 = var_0.curorigin[2] - var_1[2];

            if ( var_2 > 0 )
            {
                if ( var_2 < level._ID36883 )
                {
                    if ( !isdefined( self._ID37603 ) )
                        self._ID37603 = 0;

                    if ( gettime() - self._ID37603 > 3000 )
                    {
                        self._ID37603 = gettime();
                        thread _ID36860();
                    }
                }
                else
                {
                    var_0.on_path_grid = 0;
                    return 1;
                }
            }
        }
    }

    return 0;
}

_ID36860()
{
    self endon( "death" );
    self endon( "disconnect" );
    self botsetstance( "stand" );
    wait 1.0;
    self botpressbutton( "jump" );
    wait 1.0;
    self botsetstance( "none" );
}

_ID36886()
{
    for (;;)
    {
        level waittill( "new_tag_spawned",  var_0  );
        self._ID37732 = -1;

        if ( isdefined( var_0 ) )
        {
            if ( isdefined( var_0._ID35229 ) && var_0._ID35229 == self || isdefined( var_0.attacker ) && var_0.attacker == self )
            {
                if ( !isdefined( var_0.on_path_grid ) && !isdefined( var_0._ID36935 ) )
                {
                    thread _ID36934( var_0 );
                    _ID38280( var_0 );

                    if ( var_0.on_path_grid )
                    {
                        var_1 = spawnstruct();
                        var_1.origin = var_0.curorigin;
                        var_1.tag = var_0;
                        var_2[0] = var_1;
                        self._ID38139 = _ID36829( var_2, self._ID38139 );
                    }
                }
            }
        }
    }
}

_ID36829( var_0, var_1 )
{
    var_2 = var_1;

    foreach ( var_4 in var_0 )
    {
        var_5 = 0;

        foreach ( var_7 in var_1 )
        {
            if ( var_4.tag == var_7.tag && maps\mp\bots\_bots_util::_ID5824( var_4.origin, var_7.origin ) )
            {
                var_5 = 1;
                break;
            }
        }

        if ( !var_5 )
            var_2 = common_scripts\utility::array_add( var_2, var_4 );
    }

    return var_2;
}

_ID36858( var_0, var_1, var_2 )
{
    if ( !var_0.calculated_nearest_node )
    {
        var_0._ID21893 = getclosestnodeinsight( var_0.curorigin );
        var_0.calculated_nearest_node = 1;
    }

    if ( isdefined( var_0._ID36935 ) )
        return 0;

    var_3 = var_0._ID21893;
    var_4 = !isdefined( var_0.on_path_grid );

    if ( isdefined( var_3 ) && ( var_4 || var_0.on_path_grid ) )
    {
        var_5 = var_3 == var_1 || nodesvisible( var_3, var_1, 1 );

        if ( var_5 )
        {
            var_6 = common_scripts\utility::_ID36376( self.origin, self.angles, var_0.curorigin, var_2 );

            if ( var_6 )
            {
                if ( var_4 )
                {
                    thread _ID36934( var_0 );
                    _ID38280( var_0 );

                    if ( !var_0.on_path_grid )
                        return 0;
                }

                return 1;
            }
        }
    }

    return 0;
}

_ID36843( var_0, var_1, var_2 )
{
    var_3 = undefined;

    if ( isdefined( var_1 ) )
        var_3 = var_1;
    else
        var_3 = self getnearestnode();

    var_4 = undefined;

    if ( isdefined( var_2 ) )
        var_4 = var_2;
    else
        var_4 = self botgetfovdot();

    var_5 = [];

    if ( isdefined( var_3 ) )
    {
        foreach ( var_7 in level.dogtags )
        {
            if ( var_7 maps\mp\gametypes\_gameobjects::_ID6602( self.team ) )
            {
                var_8 = 0;

                if ( !var_0 )
                {
                    if ( !isdefined( var_7._ID36935 ) )
                    {
                        if ( !isdefined( var_7.on_path_grid ) )
                        {
                            level thread _ID36934( var_7 );
                            _ID38280( var_7 );
                        }

                        var_8 = distancesquared( self.origin, var_7.curorigin ) < 1000000 && var_7.on_path_grid;
                    }
                }
                else if ( _ID36858( var_7, var_3, var_4 ) )
                    var_8 = 1;

                if ( var_8 )
                {
                    var_9 = spawnstruct();
                    var_9.origin = var_7.curorigin;
                    var_9.tag = var_7;
                    var_5 = common_scripts\utility::array_add( var_5, var_9 );
                }
            }
        }
    }

    return var_5;
}

_ID36934( var_0 )
{
    var_0 endon( "reset" );
    var_0._ID36935 = 1;
    var_0.on_path_grid = maps\mp\bots\_bots_util::bot_point_is_on_pathgrid( var_0.curorigin, undefined, level._ID36883 + 55 );
    var_0._ID36935 = undefined;
}

_ID38280( var_0 )
{
    while ( !isdefined( var_0.on_path_grid ) )
        wait 0.05;
}

_ID36841( var_0, var_1 )
{
    var_2 = undefined;

    if ( var_0.size > 0 )
    {
        var_3 = 1409865409;

        foreach ( var_5 in var_0 )
        {
            var_6 = _ID37300( var_5.tag );

            if ( !var_1 || var_6 < 2 )
            {
                var_7 = distancesquared( var_5.tag.curorigin, self.origin );

                if ( var_7 < var_3 )
                {
                    var_2 = var_5.tag;
                    var_3 = var_7;
                }
            }
        }
    }

    return var_2;
}

_ID36872( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( var_3.tag maps\mp\gametypes\_gameobjects::_ID6602( self.team ) && maps\mp\bots\_bots_util::_ID5824( var_3.tag.curorigin, var_3.origin ) )
        {
            if ( !_ID36826( var_3.tag ) && var_3.tag.on_path_grid )
                var_1 = common_scripts\utility::array_add( var_1, var_3 );
        }
    }

    return var_1;
}

_ID37300( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in level._ID23303 )
    {
        if ( !isdefined( var_3.team ) )
            continue;

        if ( var_3.team == self.team && var_3 != self )
        {
            if ( isai( var_3 ) )
            {
                if ( isdefined( var_3._ID38136 ) && var_3._ID38136 == var_0 )
                    var_1++;

                continue;
            }

            if ( distancesquared( var_3.origin, var_0.curorigin ) < 160000 )
                var_1++;
        }
    }

    return var_1;
}

_ID36822( var_0, var_1, var_2 )
{
    self notify( "bot_camp_tag" );
    self endon( "bot_camp_tag" );
    self endon( "stop_camping_tag" );

    if ( isdefined( var_2 ) )
        self endon( var_2 );

    self botsetscriptgoalnode( self._ID22077, var_1, self.ambush_yaw );
    var_3 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();

    if ( var_3 == "goal" )
    {
        var_4 = var_0._ID21893;

        if ( isdefined( var_4 ) )
        {
            var_5 = findentrances( self.origin );
            var_5 = common_scripts\utility::array_add( var_5, var_4 );
            childthread maps\mp\bots\_bots_util::bot_watch_nodes( var_5 );
        }
    }
}
