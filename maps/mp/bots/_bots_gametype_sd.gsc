// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    _ID28940();
    _ID36875();
}

_ID28940()
{
    level.bot_funcs["crate_can_use"] = ::_ID37025;
    level.bot_funcs["gametype_think"] = ::_ID36876;
    level.bot_funcs["should_start_cautious_approach"] = ::_ID38021;
    level.bot_funcs["know_enemies_on_start"] = undefined;
    level.bot_funcs["notify_enemy_bots_bomb_used"] = ::_ID37735;
}

_ID36875()
{
    _ID37981();
}

_ID37025( var_0 )
{
    if ( isagent( self ) && !isdefined( var_0.boxtype ) )
        return 0;

    if ( !maps\mp\_utility::_ID18820( self ) )
        return 1;

    if ( !isdefined( self._ID37917 ) )
        return 0;

    switch ( self._ID37917 )
    {
        case "atk_bomber":
        case "bomb_defuser":
        case "investigate_someone_using_bomb":
            return 0;
    }

    return 1;
}

_ID37981()
{
    level.bots_disable_team_switching = 1;
    level._ID37495 = 3000;
    maps\mp\bots\_bots_strategy::_ID5774();
    maps\mp\bots\_bots_util::_ID5828( 1 );
    level._ID36874 = [];
    level._ID36874["axis"] = [];
    level._ID36874["allies"] = [];
    level._ID36831["atk_bomber"] = ::_ID36747;
    level._ID36831["clear_target_zone"] = ::_ID36973;
    level._ID36831["defend_planted_bomb"] = ::_ID37090;
    level._ID36831["bomb_defuser"] = ::_ID36792;
    level._ID36831["investigate_someone_using_bomb"] = ::_ID37520;
    level._ID36831["camp_bomb"] = ::_ID36937;
    level._ID36831["defender"] = ::_ID37093;
    level._ID36831["backstabber"] = ::_ID36762;
    level._ID36831["random_killer"] = ::_ID37852;
    var_0 = 0;

    foreach ( var_2 in level.bombzones )
    {
        var_3 = getzonenearest( var_2.curorigin );

        if ( isdefined( var_3 ) )
            botzonesetteam( var_3, game["defenders"] );
    }

    if ( !var_0 )
    {
        maps\mp\bots\_bots_util::bot_cache_entrances_to_bombzones();
        thread _ID36873();
        level._ID5597 = 1;
    }
}

_ID36876()
{
    self notify( "bot_sd_think" );
    self endon( "bot_sd_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( !isdefined( level._ID5597 ) )
        wait 0.05;

    self botsetflag( "separation", 0 );
    self botsetflag( "grenade_objectives", 1 );
    self botsetflag( "use_obj_path_style", 1 );
    var_0 = game["attackers"];
    var_1 = 1;

    if ( isdefined( level.sdbomb ) && isdefined( level.sdbomb.carrier ) && level.sdbomb.carrier == self && isdefined( self._ID37917 ) && self._ID37917 == "atk_bomber" )
        var_1 = 0;

    if ( var_1 )
        self._ID37917 = undefined;

    self._ID38125 = undefined;
    self._ID37420 = 0;
    self._ID36746 = 0;
    self._ID37931 = undefined;
    self._ID37092 = undefined;
    self._ID37095 = 0;

    if ( !isdefined( level._ID37492 ) && !level._ID21797 )
    {
        level._ID37492 = level.sdbomb.curorigin;
        level._ID37493 = getclosestnodeinsight( level.sdbomb.curorigin );
    }

    if ( self.team == var_0 && !isdefined( level._ID36941 ) )
    {
        var_2 = 0;

        if ( !level._ID21797 )
        {
            var_3 = _ID37290( var_0 );

            foreach ( var_5 in var_3 )
            {
                if ( !isai( var_5 ) )
                    var_2 = 1;
            }
        }

        if ( var_2 )
        {
            var_7 = 6000;
            level._ID36941 = gettime() + var_7;
            badplace_cylinder( "bomb", var_7 / 1000, level.sdbomb.curorigin, 75, 300, var_0 );
        }
    }

    for (;;)
    {
        wait(randomintrange( 1, 3 ) * 0.05);

        if ( self.health <= 0 )
            continue;

        self._ID37420 = 1;

        if ( !isdefined( self._ID37917 ) )
            _ID37500();

        if ( isdefined( self._ID38125 ) )
            continue;

        if ( self.team == var_0 )
        {
            if ( !level._ID21797 && isdefined( level._ID36941 ) && gettime() < level._ID36941 && !isdefined( level.sdbomb.carrier ) )
            {
                if ( !maps\mp\bots\_bots_util::bot_is_defending_point( level.sdbomb.curorigin ) )
                {
                    var_8 = getclosestnodeinsight( level.sdbomb.curorigin );

                    if ( isdefined( var_8 ) )
                    {
                        var_9["nearest_node_to_center"] = var_8;
                        maps\mp\bots\_bots_strategy::bot_protect_point( level.sdbomb.curorigin, 900, var_9 );
                    }
                    else
                        level._ID36941 = gettime();
                }
            }
            else
                self [[ level._ID36831[self._ID37917] ]]();

            continue;
        }

        if ( level.bombplanted )
        {
            if ( distancesquared( self.origin, level._ID27946.origin ) > squared( level._ID25118 * 2 ) )
            {
                if ( !isdefined( self._ID37092 ) )
                {
                    self._ID37092 = 1;
                    self botsetpathingstyle( "scripted" );
                }
            }
            else if ( isdefined( self._ID37092 ) && !isdefined( self._ID37931 ) )
            {
                self._ID37092 = undefined;
                self botsetpathingstyle( undefined );
            }
        }

        if ( level.bombplanted && isdefined( level._ID36791 ) && self._ID37917 != "bomb_defuser" )
        {
            if ( !maps\mp\bots\_bots_util::bot_is_defending_point( level._ID27946.origin ) )
            {
                self botclearscriptgoal();
                maps\mp\bots\_bots_strategy::bot_protect_point( level._ID27946.origin, level._ID25118 );
            }

            continue;
        }

        self [[ level._ID36831[self._ID37917] ]]();
    }
}

_ID36747()
{
    self endon( "new_role" );

    if ( maps\mp\bots\_bots_util::bot_is_defending() )
        maps\mp\bots\_bots_strategy::bot_defend_stop();

    if ( isdefined( level.sdbomb ) && isdefined( level.sdbomb.carrier ) && isalive( level.sdbomb.carrier ) && level.sdbomb.carrier != self )
        wait 0.7;

    if ( !self.isbombcarrier && !level._ID21797 )
    {
        if ( isdefined( level.sdbomb ) )
        {
            if ( !isdefined( self._ID37592 ) )
                self._ID37592 = level.sdbomb.curorigin;

            if ( distancesquared( self._ID37592, level.sdbomb.curorigin ) > 4 )
            {
                self botclearscriptgoal();
                self._ID37592 = level.sdbomb.curorigin;
            }
        }

        if ( self._ID36746 >= 2 )
        {
            var_1 = getnodesinradiussorted( level.sdbomb.curorigin, 512, 0 );
            var_2 = undefined;

            foreach ( var_4 in var_1 )
            {
                if ( !var_4 nodeisdisconnected() )
                {
                    var_2 = var_4;
                    break;
                }
            }

            if ( isdefined( var_2 ) )
            {
                self botsetscriptgoal( var_2.origin, 20, "critical" );
                maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();

                if ( isdefined( level.sdbomb ) && !isdefined( level.sdbomb.carrier ) )
                    level.sdbomb maps\mp\gametypes\_gameobjects::_ID28820( self );

                jump loc_5D7
            }

            return;
        }

        if ( !self bothasscriptgoal() )
        {
            var_6 = 15;
            var_7 = 32;
            var_8 = maps\mp\bots\_bots_util::bot_queued_process( "BotGetClosestNavigablePoint", maps\mp\bots\_bots_util::_ID13734, level.sdbomb.curorigin, var_6 + var_7, self );

            if ( isdefined( var_8 ) )
            {
                var_9 = self botsetscriptgoal( level.sdbomb.curorigin, 0, "critical" );

                if ( var_9 )
                {
                    childthread _ID36794();
                    return;
                }
            }
            else
            {
                var_1 = getnodesinradiussorted( level.sdbomb.curorigin, 512, 0 );

                if ( var_1.size > 0 )
                {
                    self botsetscriptgoal( var_1[0].origin, 0, "critical" );
                    maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();
                }

                if ( isdefined( level.sdbomb ) && !isdefined( level.sdbomb.carrier ) )
                {
                    var_8 = maps\mp\bots\_bots_util::bot_queued_process( "BotGetClosestNavigablePoint", maps\mp\bots\_bots_util::_ID13734, level.sdbomb.curorigin, var_6 + var_7, self );

                    if ( !isdefined( var_8 ) )
                        level.sdbomb maps\mp\gametypes\_gameobjects::_ID28820( self );
                }
            }
        }
    }
    else
    {
        if ( isdefined( self._ID37120 ) && gettime() < self._ID37120 )
            return;

        if ( !isdefined( level._ID36793 ) )
            level._ID36793 = level.bombzones[randomint( level.bombzones.size )];

        var_10 = level._ID36793;
        self._ID36799 = var_10;

        if ( !isdefined( level._ID37494 ) || gettime() - level._ID37494 < level._ID37495 )
        {
            level._ID37494 = gettime() + level._ID37495;
            self botclearscriptgoal();
            self botsetscriptgoal( self.origin, 0, "tactical" );
            wait(level._ID37495 / 1000);
        }

        self botclearscriptgoal();

        if ( level._ID36749 == "rush" )
        {
            self botsetpathingstyle( "scripted" );
            var_11 = self botnodescoremultiple( var_10.bottargets, "node_exposed" );
            var_12 = self botgetdifficultysetting( "strategyLevel" ) * 0.45;
            var_13 = ( self botgetdifficultysetting( "strategyLevel" ) + 1 ) * 0.15;

            foreach ( var_4 in var_10.bottargets )
            {
                if ( !common_scripts\utility::array_contains( var_11, var_4 ) )
                    var_11[var_11.size] = var_4;
            }

            if ( randomfloat( 1.0 ) < var_12 )
                var_16 = var_11[0];
            else if ( randomfloat( 1.0 ) < var_13 )
                var_16 = var_11[1];
            else
                var_16 = common_scripts\utility::_ID25350( var_11 );

            self botsetscriptgoal( var_16.origin, 0, "critical" );
        }

        var_17 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();

        if ( var_17 == "goal" )
        {
            var_18 = _ID37318() - gettime();
            var_19 = var_18 - level._ID23712 * 2 * 1000;
            var_20 = gettime() + var_19;

            if ( var_19 > 0 )
                maps\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time( var_19 );

            var_21 = gettime() >= var_20;
            var_22 = _ID37933( level._ID23712 + 2, "bomb_planted", var_21 );
            self botclearscriptgoal();

            if ( var_22 )
            {
                maps\mp\bots\_bots_strategy::bot_enable_tactical_goals();
                _ID36877( "defend_planted_bomb" );
            }
            else if ( var_19 > 5000 )
                self._ID37120 = gettime() + 5000;
        }
    }
}

_ID37318()
{
    if ( level.bombplanted )
        return level.defuseendtime;
    else
        return gettime() + maps\mp\gametypes\_gamelogic::gettimeremaining();
}

_ID36794()
{
    self notify( "bomber_monitor_no_path" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "goal" );
    self endon( "bomber_monitor_no_path" );
    level.sdbomb endon( "pickup_object" );

    for (;;)
    {
        self waittill( "no_path" );
        self._ID36746++;
    }
}

_ID36973()
{
    self endon( "new_role" );

    if ( isdefined( level._ID36745 ) )
    {
        if ( level._ID36749 == "rush" )
        {
            if ( !isdefined( self._ID37947 ) )
            {
                if ( !level._ID21797 )
                {
                    var_0["nearest_node_to_center"] = level._ID37493;
                    maps\mp\bots\_bots_strategy::bot_protect_point( level._ID37492, 900, var_0 );
                    wait(randomfloatrange( 0.0, 4.0 ));
                    maps\mp\bots\_bots_strategy::bot_defend_stop();
                }

                self._ID37947 = 1;
            }

            if ( self botgetdifficultysetting( "strategyLevel" ) > 0 )
                _ID37945();

            if ( isai( level._ID36745 ) && isdefined( level._ID36745._ID36799 ) )
                var_1 = level._ID36745._ID36799;
            else if ( isdefined( level._ID36793 ) )
                var_1 = level._ID36793;
            else
                var_1 = _ID37199( level._ID36745 );

            if ( !maps\mp\bots\_bots_util::bot_is_defending_point( var_1.curorigin ) )
            {
                var_0["min_goal_time"] = 2;
                var_0["max_goal_time"] = 4;
                var_0["override_origin_node"] = common_scripts\utility::_ID25350( var_1.bottargets );
                maps\mp\bots\_bots_strategy::bot_protect_point( var_1.curorigin, level._ID25118, var_0 );
            }
        }
    }
}

_ID37090()
{
    self endon( "new_role" );

    if ( level.bombplanted )
    {
        if ( level._ID36749 == "rush" )
            _ID37108();

        if ( !maps\mp\bots\_bots_util::bot_is_defending_point( level._ID27946.origin ) )
            maps\mp\bots\_bots_strategy::bot_protect_point( level._ID27946.origin, level._ID25118 );
    }
}

_ID36792()
{
    self endon( "new_role" );

    if ( level._ID5457 )
        return;

    var_0 = _ID37201();

    if ( !isdefined( var_0 ) )
        return;

    var_1 = common_scripts\utility::_ID14293( level._ID27946.origin, var_0.bottargets );
    var_2 = ( level._ID27946.origin[0], level._ID27946.origin[1], var_1[0].origin[2] );
    var_3 = _ID36950( var_2, undefined );

    if ( !var_3 )
        return;

    var_4 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();

    if ( var_4 == "bad_path" )
    {
        self._ID37095++;

        if ( self._ID37095 >= 4 )
        {
            for (;;)
            {
                var_5 = getnodesinradiussorted( var_2, 50, 0 );
                var_6 = self._ID37095 - 4;

                if ( var_5.size <= var_6 )
                    break;

                self botsetscriptgoal( var_5[var_6].origin, 20, "critical" );
                var_4 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();

                if ( var_4 == "bad_path" )
                {
                    self._ID37095++;
                    continue;
                }

                break;
            }
        }
    }

    if ( var_4 == "goal" )
    {
        var_7 = _ID37318() - gettime();
        var_8 = var_7 - level.defusetime * 2 * 1000;
        var_9 = gettime() + var_8;

        if ( var_8 > 0 )
            maps\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time( var_8 );

        var_10 = gettime() >= var_9;
        _ID37933( level.defusetime + 2, "bomb_defused", var_10 );
        self botclearscriptgoal();
        maps\mp\bots\_bots_strategy::bot_enable_tactical_goals();
    }
}

_ID37520()
{
    self endon( "new_role" );

    if ( maps\mp\bots\_bots_util::bot_is_defending() )
        maps\mp\bots\_bots_strategy::bot_defend_stop();

    var_0 = _ID37199( self );
    self botsetscriptgoalnode( common_scripts\utility::_ID25350( var_0.bottargets ), "guard" );
    var_1 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();

    if ( var_1 == "goal" )
    {
        wait 4;
        _ID36877( self._ID37844 );
    }
}

_ID36937()
{
    self endon( "new_role" );

    if ( isdefined( level.sdbomb.carrier ) )
    {
        if ( self._ID37844 == "defender" )
            self._ID37091 = _ID37199( self );

        _ID36877( self._ID37844 );
    }
    else if ( !maps\mp\bots\_bots_util::bot_is_defending_point( level.sdbomb.curorigin ) )
    {
        var_0["nearest_node_to_center"] = level.sdbomb._ID37725;
        maps\mp\bots\_bots_strategy::bot_protect_point( level.sdbomb.curorigin, level._ID25118, var_0 );
    }
}

_ID37093()
{
    self endon( "new_role" );

    if ( !maps\mp\bots\_bots_util::bot_is_defending_point( self._ID37091.curorigin ) )
    {
        var_0["score_flags"] = "strict_los";
        var_0["override_origin_node"] = common_scripts\utility::_ID25350( self._ID37091.bottargets );
        maps\mp\bots\_bots_strategy::bot_protect_point( self._ID37091.curorigin, level._ID25118, var_0 );
    }
}

_ID36762()
{
    self endon( "new_role" );

    if ( maps\mp\bots\_bots_util::bot_is_defending() )
        maps\mp\bots\_bots_strategy::bot_defend_stop();

    if ( !isdefined( self._ID36761 ) )
        self._ID36761 = "1_move_to_midpoint";

    if ( self._ID36761 == "1_move_to_midpoint" )
    {
        var_0 = level.bombzones[0].curorigin;
        var_1 = level.bombzones[1].curorigin;
        var_2 = ( ( var_0[0] + var_1[0] ) * 0.5, ( var_0[1] + var_1[1] ) * 0.5, ( var_0[2] + var_1[2] ) * 0.5 );
        var_3 = getnodesinradiussorted( var_2, 512, 0 );

        if ( var_3.size == 0 )
        {
            _ID36877( "random_killer" );
            return;
        }

        var_4 = undefined;
        var_5 = int( var_3.size * ( var_3.size + 1 ) * 0.5 );
        var_6 = randomint( var_5 );

        for ( var_7 = 0; var_7 < var_3.size; var_7++ )
        {
            var_8 = var_3.size - var_7;

            if ( var_6 < var_8 )
            {
                var_4 = var_3[var_7];
                break;
            }

            var_6 -= var_8;
        }

        self botsetpathingstyle( "scripted" );
        var_9 = self botsetscriptgoalnode( var_4, "guard" );

        if ( var_9 )
        {
            var_10 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();

            if ( var_10 == "goal" )
            {
                wait(randomfloatrange( 1.0, 4.0 ));
                self._ID36761 = "2_move_to_enemy_spawn";
            }
        }
    }

    if ( self._ID36761 == "2_move_to_enemy_spawn" )
    {
        var_11 = maps\mp\gametypes\_spawnlogic::_ID15350( "mp_sd_spawn_attacker" );
        var_12 = common_scripts\utility::_ID25350( var_11 );
        self botsetpathingstyle( "scripted" );
        var_9 = self botsetscriptgoal( var_12.origin, 250, "guard" );

        if ( var_9 )
        {
            var_10 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();

            if ( var_10 == "goal" )
                self._ID36761 = "3_move_to_bombzone";
        }
    }

    if ( self._ID36761 == "3_move_to_bombzone" )
    {
        if ( !isdefined( self._ID36798 ) )
            self._ID36798 = randomint( level.bombzones.size );

        self botsetpathingstyle( undefined );
        var_9 = self botsetscriptgoal( common_scripts\utility::_ID25350( level.bombzones[self._ID36798].bottargets ).origin, 160, "objective" );

        if ( var_9 )
        {
            var_10 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();

            if ( var_10 == "goal" )
            {
                self botclearscriptgoal();
                self._ID36761 = "2_move_to_enemy_spawn";
                self._ID36798 = 1 - self._ID36798;
            }
        }
    }
}

_ID37852()
{
    self endon( "new_role" );

    if ( maps\mp\bots\_bots_util::bot_is_defending() )
        maps\mp\bots\_bots_strategy::bot_defend_stop();

    self [[ self._ID23477 ]]();
}

_ID37945()
{
    if ( !isdefined( self._ID36716 ) )
    {
        self botsetflag( "force_sprint", 1 );
        self._ID36716 = 1;
    }
}

_ID37108()
{
    if ( isdefined( self._ID36716 ) )
    {
        self botsetflag( "force_sprint", 0 );
        self._ID36716 = undefined;
    }
}

_ID37960()
{
    if ( !isdefined( self._ID37931 ) )
    {
        self botsetpathingstyle( "scripted" );
        self._ID37931 = 1;
    }
}

_ID36950( var_0, var_1 )
{
    var_2 = level._ID36948;
    var_3["entrance_points_index"] = var_1;
    maps\mp\bots\_bots_strategy::_ID5516( var_0, var_2, var_3 );
    wait 0.05;

    while ( distancesquared( self.origin, var_0 ) > var_2 * var_2 && maps\mp\bots\_bots_util::bot_is_defending() )
    {
        if ( _ID37318() - gettime() < 20000 )
        {
            _ID37960();
            _ID37945();
            break;
        }

        wait 0.05;
    }

    if ( maps\mp\bots\_bots_util::bot_is_defending() )
        maps\mp\bots\_bots_strategy::bot_defend_stop();

    return self botsetscriptgoal( var_0, 20, "critical" );
}

_ID37933( var_0, var_1, var_2 )
{
    var_3 = 0;

    if ( self botgetdifficultysetting( "strategyLevel" ) == 1 )
        var_3 = 40;
    else if ( self botgetdifficultysetting( "strategyLevel" ) >= 2 )
        var_3 = 80;

    if ( randomint( 100 ) < var_3 )
    {
        self botsetstance( "prone" );
        wait 0.2;
    }

    if ( self botgetdifficultysetting( "strategyLevel" ) > 0 && !var_2 )
    {
        thread _ID37737();
        thread notify_on_damage();
    }

    self botpressbutton( "use", var_0 );
    var_4 = maps\mp\bots\_bots_util::bot_usebutton_wait( var_0, var_1, "use_interrupted" );
    self botsetstance( "none" );
    self botclearbutton( "use" );
    var_5 = var_4 == var_1;
    return var_5;
}

_ID37735( var_0 )
{
    var_1 = _ID37290( common_scripts\utility::_ID14447( self.team ), 1 );

    foreach ( var_3 in var_1 )
    {
        var_4 = 0;

        if ( var_0 == "plant" )
            var_4 = 300 + var_3 botgetdifficultysetting( "strategyLevel" ) * 100;
        else if ( var_0 == "defuse" )
            var_4 = 500 + var_3 botgetdifficultysetting( "strategyLevel" ) * 500;

        if ( distancesquared( var_3.origin, self.origin ) < squared( var_4 ) )
            var_3 _ID36877( "investigate_someone_using_bomb" );
    }
}

_ID37737()
{
    var_0 = _ID37199( self );
    self waittill( "bulletwhizby",  var_1  );

    if ( !isdefined( var_1.team ) || var_1.team != self.team )
    {
        var_2 = var_0._ID34780 - var_0.curprogress;

        if ( var_2 > 1000 )
            self notify( "use_interrupted" );
    }
}

notify_on_damage()
{
    self waittill( "damage",  var_0, var_1  );

    if ( !isdefined( var_1.team ) || var_1.team != self.team )
        self notify( "use_interrupted" );
}

_ID38021( var_0 )
{
    var_1 = 2000;
    var_2 = var_1 * var_1;

    if ( var_0 )
    {
        if ( _ID37318() - gettime() < 15000 )
            return 0;

        var_3 = 0;
        var_4 = common_scripts\utility::_ID14447( self.team );

        foreach ( var_6 in level.players )
        {
            if ( !isdefined( var_6.team ) )
                continue;

            if ( isalive( var_6 ) && var_6.team == var_4 )
                var_3 = 1;
        }

        return var_3;
    }
    else
        return distancesquared( self.origin, self.bot_defending_center ) <= var_2 && self botpursuingscriptgoal();
}

_ID37199( var_0 )
{
    var_1 = undefined;
    var_2 = 999999999;

    foreach ( var_4 in level.bombzones )
    {
        var_5 = distancesquared( var_4.curorigin, var_0.origin );

        if ( var_5 < var_2 )
        {
            var_1 = var_4;
            var_2 = var_5;
        }
    }

    return var_1;
}

_ID37313( var_0 )
{
    var_1 = [];
    var_2 = _ID37290( game["defenders"] );

    foreach ( var_4 in var_2 )
    {
        if ( isai( var_4 ) && isdefined( var_4._ID37917 ) && var_4._ID37917 == "defender" )
        {
            if ( isdefined( var_4._ID37091 ) && var_4._ID37091 == var_0 )
                var_1 = common_scripts\utility::array_add( var_1, var_4 );

            continue;
        }

        if ( distancesquared( var_4.origin, var_0.curorigin ) < level._ID25118 * level._ID25118 )
            var_1 = common_scripts\utility::array_add( var_1, var_4 );
    }

    return var_1;
}

_ID37201()
{
    if ( isdefined( level._ID32974 ) )
    {
        foreach ( var_1 in level.bombzones )
        {
            if ( distancesquared( level._ID32974.origin, var_1.curorigin ) < 90000 )
                return var_1;
        }
    }

    return undefined;
}

_ID37332( var_0 )
{
    var_0 = "_" + tolower( var_0 );

    for ( var_1 = 0; var_1 < level.bombzones.size; var_1++ )
    {
        if ( level.bombzones[var_1].label == var_0 )
            return level.bombzones[var_1];
    }
}

_ID36796()
{
    self endon( "stopped_being_bomb_carrier" );
    self endon( "new_role" );
    common_scripts\utility::_ID35626( "death", "disconnect" );
    level._ID36745 = undefined;
    level._ID37591 = gettime();

    if ( isdefined( self ) )
        self._ID37917 = undefined;

    var_0 = _ID37290( game["attackers"], 1 );
    _ID37224( var_0, undefined );
}

_ID36795()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "stopped_being_bomb_carrier" );
    level.sdbomb endon( "pickup_object" );
    level.sdbomb waittill( "reset" );

    if ( maps\mp\_utility::_ID18540( self ) )
        self botclearscriptgoal();

    _ID36877( "atk_bomber" );
}

_ID37954()
{
    level._ID36745 = self;
    _ID36877( "atk_bomber" );
    thread _ID36796();

    if ( !level._ID21797 )
        thread _ID36795();

    if ( isai( self ) )
    {
        maps\mp\bots\_bots_strategy::bot_disable_tactical_goals();

        if ( level._ID36749 == "rush" && self botgetdifficultysetting( "strategyLevel" ) > 0 )
            _ID37945();
    }
}

_ID37500()
{
    if ( self.team == game["attackers"] )
    {
        if ( level.bombplanted )
            _ID36877( "defend_planted_bomb" );
        else if ( !isdefined( level._ID36745 ) )
            _ID37954();
        else if ( level._ID36749 == "rush" )
            _ID36877( "clear_target_zone" );
    }
    else
    {
        var_0 = _ID37312( "backstabber" );
        var_1 = _ID37312( "defender" );
        var_2 = level._ID5724[self._ID23475];
        var_3 = self botgetdifficultysetting( "strategyLevel" );

        if ( var_2 == "active" )
        {
            if ( !isdefined( self._ID37917 ) && level._ID36706 && var_3 > 0 )
            {
                if ( var_0.size == 0 )
                    _ID36877( "backstabber" );
                else
                {
                    var_4 = 1;

                    foreach ( var_6 in var_0 )
                    {
                        var_7 = level._ID5724[var_6._ID23475];

                        if ( var_7 == "active" )
                        {
                            var_4 = 0;
                            break;
                        }
                    }

                    if ( var_4 )
                    {
                        _ID36877( "backstabber" );
                        var_0[0] _ID36877( undefined );
                    }
                }
            }

            if ( !isdefined( self._ID37917 ) )
            {
                if ( var_1.size < 4 )
                    _ID36877( "defender" );
            }

            if ( !isdefined( self._ID37917 ) )
            {
                var_9 = randomint( 4 );

                if ( var_9 == 3 && level._ID36708 && var_3 > 0 )
                    _ID36877( "random_killer" );
                else if ( var_9 == 2 && level._ID36706 && var_3 > 0 )
                    _ID36877( "backstabber" );
                else
                    _ID36877( "defender" );
            }
        }
        else if ( var_2 == "stationary" )
        {
            if ( !isdefined( self._ID37917 ) )
            {
                if ( var_1.size < 4 )
                    _ID36877( "defender" );
                else
                {
                    foreach ( var_11 in var_1 )
                    {
                        var_12 = level._ID5724[var_11._ID23475];

                        if ( var_12 == "active" )
                        {
                            _ID36877( "defender" );
                            var_11 _ID36877( undefined );
                            break;
                        }
                    }
                }
            }

            if ( !isdefined( self._ID37917 ) && level._ID36706 && var_3 > 0 )
            {
                if ( var_0.size == 0 )
                    _ID36877( "backstabber" );
            }

            if ( !isdefined( self._ID37917 ) )
                _ID36877( "defender" );
        }

        if ( self._ID37917 == "defender" )
        {
            var_14 = level.bombzones;

            if ( _ID37417( self.team ) )
                var_14 = _ID37305( self.team );

            if ( var_14.size == 1 )
                self._ID37091 = var_14[0];
            else
            {
                var_15 = _ID37313( var_14[0] );
                var_16 = _ID37313( var_14[1] );

                if ( var_15.size < var_16.size )
                    self._ID37091 = var_14[0];
                else if ( var_16.size < var_15.size )
                    self._ID37091 = var_14[1];
                else
                    self._ID37091 = common_scripts\utility::_ID25350( var_14 );
            }
        }
    }
}

_ID36877( var_0 )
{
    if ( isai( self ) )
    {
        maps\mp\bots\_bots_strategy::bot_defend_stop();
        self botsetpathingstyle( undefined );
    }

    self._ID37844 = self._ID37917;
    self._ID37917 = var_0;
    self notify( "new_role" );
}

_ID36878( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "new_role" );
    wait(var_1);
    _ID36877( var_0 );
}

_ID37224( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_0 )
    {
        if ( isdefined( var_2 ) )
        {
            var_4 thread _ID36878( var_1, randomfloatrange( 0.0, var_2 ) );
            continue;
        }

        var_4 thread _ID36877( var_1 );
    }
}

_ID37305( var_0 )
{
    return level._ID36874[var_0];
}

_ID37417( var_0 )
{
    var_1 = _ID37305( var_0 );
    return var_1.size > 0;
}

_ID37312( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level._ID23303 )
    {
        if ( isalive( var_3 ) && maps\mp\_utility::_ID18820( var_3 ) && isdefined( var_3._ID37917 ) && var_3._ID37917 == var_0 )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

_ID37290( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in level._ID23303 )
    {
        if ( !isdefined( var_4.team ) )
            continue;

        if ( maps\mp\_utility::_ID18757( var_4 ) && maps\mp\_utility::_ID18820( var_4 ) && var_4.team == var_0 )
        {
            if ( !isdefined( var_1 ) || var_1 && isai( var_4 ) && isdefined( var_4._ID37917 ) )
                var_2[var_2.size] = var_4;
        }
    }

    return var_2;
}

_ID36873()
{
    level notify( "bot_sd_ai_director_update" );
    level endon( "bot_sd_ai_director_update" );
    level endon( "game_ended" );
    level._ID36706 = randomint( 3 ) <= 1;
    level._ID36708 = randomint( 3 ) <= 1;
    level._ID36749 = "rush";
    level._ID25118 = 725;
    level._ID36948 = 140;

    for (;;)
    {
        if ( isdefined( level.sdbomb ) && isdefined( level.sdbomb.carrier ) && !isai( level.sdbomb.carrier ) )
            level._ID36793 = _ID37199( level.sdbomb.carrier );

        var_0 = 0;

        if ( !level.bombplanted )
        {
            var_1 = _ID37290( game["attackers"] );

            foreach ( var_3 in var_1 )
            {
                if ( var_3.isbombcarrier )
                {
                    level._ID36941 = gettime();

                    if ( !isdefined( level._ID36745 ) || var_3 != level._ID36745 )
                    {
                        if ( isdefined( level._ID36745 ) && isalive( level._ID36745 ) )
                        {
                            level._ID36745 _ID36877( undefined );
                            level._ID36745 notify( "stopped_being_bomb_carrier" );
                        }

                        var_0 = 1;
                        var_3 _ID37954();
                    }
                }
            }

            if ( !level._ID21797 && !isdefined( level.sdbomb.carrier ) )
            {
                var_5 = getclosestnodeinsight( level.sdbomb.curorigin );

                if ( isdefined( var_5 ) )
                {
                    level.sdbomb._ID37725 = var_5;
                    var_6 = 0;
                    var_7 = _ID37290( game["defenders"], 1 );

                    foreach ( var_9 in var_7 )
                    {
                        var_10 = var_9 getnearestnode();
                        var_11 = var_9 botgetdifficultysetting( "strategyLevel" );

                        if ( var_11 > 0 && var_9._ID37917 != "camp_bomb" && isdefined( var_10 ) && nodesvisible( var_5, var_10, 1 ) )
                        {
                            var_12 = var_9 botgetfovdot();

                            if ( common_scripts\utility::_ID36376( var_9.origin, var_9.angles, level.sdbomb.curorigin, var_12 ) )
                            {
                                if ( var_11 >= 2 || distancesquared( var_9.origin, level.sdbomb.curorigin ) < squared( 700 ) )
                                {
                                    var_6 = 1;
                                    break;
                                }
                            }
                        }
                    }

                    if ( var_6 )
                    {
                        foreach ( var_9 in var_7 )
                        {
                            if ( var_9._ID37917 != "camp_bomb" && var_9 botgetdifficultysetting( "strategyLevel" ) > 0 )
                                var_9 _ID36877( "camp_bomb" );
                        }
                    }
                }
            }

            var_16 = level.bombzones;

            if ( _ID37417( game["defenders"] ) )
                var_16 = _ID37305( game["defenders"] );

            for ( var_17 = 0; var_17 < var_16.size; var_17++ )
            {
                for ( var_18 = 0; var_18 < var_16.size; var_18++ )
                {
                    var_19 = _ID37313( var_16[var_17] );
                    var_20 = _ID37313( var_16[var_18] );

                    if ( var_19.size > var_20.size + 1 )
                    {
                        var_21 = [];

                        foreach ( var_3 in var_19 )
                        {
                            if ( isai( var_3 ) )
                                var_21 = common_scripts\utility::array_add( var_21, var_3 );
                        }

                        if ( var_21.size > 0 )
                        {
                            var_24 = common_scripts\utility::_ID25350( var_21 );
                            var_24 maps\mp\bots\_bots_strategy::bot_defend_stop();
                            var_24._ID37091 = var_16[var_18];
                        }
                    }
                }
            }
        }
        else
        {
            if ( isdefined( level._ID36745 ) )
                level._ID36745 = undefined;

            if ( !isdefined( level._ID36791 ) || !isalive( level._ID36791 ) )
            {
                var_25 = [];
                var_26 = _ID37312( "defender" );
                var_27 = _ID37312( "backstabber" );
                var_28 = _ID37312( "random_killer" );

                if ( var_26.size > 0 )
                    var_25 = var_26;
                else if ( var_27.size > 0 )
                    var_25 = var_27;
                else if ( var_28.size > 0 )
                    var_25 = var_28;

                if ( var_25.size > 0 )
                {
                    var_29 = common_scripts\utility::_ID14293( level._ID27946.origin, var_25 );
                    level._ID36791 = var_29[0];
                    level._ID36791 _ID36877( "bomb_defuser" );
                    level._ID36791 maps\mp\bots\_bots_strategy::bot_disable_tactical_goals();
                    level._ID36791 thread _ID37096();
                }
            }

            if ( !isdefined( level._ID37932 ) )
            {
                level._ID37932 = 1;
                var_30 = _ID37290( game["attackers"] );

                foreach ( var_3 in var_30 )
                {
                    if ( isdefined( var_3._ID37917 ) )
                    {
                        if ( var_3._ID37917 == "atk_bomber" )
                        {
                            var_3 thread _ID36877( undefined );
                            continue;
                        }

                        if ( var_3._ID37917 != "defend_planted_bomb" )
                            var_3 thread _ID36878( "defend_planted_bomb", randomfloatrange( 0.0, 3.0 ) );
                    }
                }
            }
        }

        wait 0.5;
    }
}

_ID37096()
{
    common_scripts\utility::_ID35626( "death", "disconnect" );
    level._ID36791 = undefined;
}
