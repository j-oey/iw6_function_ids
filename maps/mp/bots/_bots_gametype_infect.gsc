// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    _ID28940();
    _ID37980();
}

_ID28940()
{
    level.bot_funcs["gametype_think"] = ::_ID36854;
    level.bot_funcs["should_pickup_weapons"] = ::_ID36881;
}

_ID37980()
{
    level.bots_gametype_handles_class_choice = 1;
    level.bots_ignore_team_balance = 1;
    level.bots_gametype_handles_team_choice = 1;
    thread _ID36850();
}

_ID36881()
{
    if ( level.infect_chosefirstinfected && self.team == "axis" )
        return 0;

    return maps\mp\bots\_bots::bot_should_pickup_weapons();
}

_ID36854()
{
    self notify( "bot_infect_think" );
    self endon( "bot_infect_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    childthread _ID36853();

    for (;;)
    {
        if ( level.infect_chosefirstinfected )
        {
            if ( self.team == "axis" && self botgetpersonality() != "run_and_gun" )
                maps\mp\bots\_bots_util::bot_set_personality( "run_and_gun" );
        }

        if ( self._ID5801 != self.team )
            self._ID5801 = self.team;

        if ( self.team == "axis" )
        {
            var_0 = maps\mp\bots\_bots_strategy::bot_melee_tactical_insertion_check();

            if ( !isdefined( var_0 ) || var_0 )
                self botclearscriptgoal();
        }

        self [[ self._ID23477 ]]();
        wait 0.05;
    }
}

_ID36850()
{
    level notify( "bot_infect_ai_director_update" );
    level endon( "bot_infect_ai_director_update" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = [];
        var_1 = [];

        foreach ( var_3 in level.players )
        {
            if ( !isdefined( var_3._ID37498 ) && var_3.health > 0 && isdefined( var_3.team ) && ( var_3.team == "allies" || var_3.team == "axis" ) )
                var_3._ID37498 = gettime();

            if ( isdefined( var_3._ID37498 ) && gettime() - var_3._ID37498 > 5000 )
            {
                if ( !isdefined( var_3.team ) )
                    continue;

                if ( var_3.team == "axis" )
                {
                    var_0[var_0.size] = var_3;
                    continue;
                }

                if ( var_3.team == "allies" )
                    var_1[var_1.size] = var_3;
            }
        }

        if ( var_0.size > 0 && var_1.size > 0 )
        {
            var_5 = 1;

            foreach ( var_7 in var_1 )
            {
                if ( isbot( var_7 ) )
                    var_5 = 0;
            }

            if ( var_5 )
            {
                foreach ( var_3 in var_1 )
                {
                    if ( !isdefined( var_3._ID37596 ) )
                    {
                        var_3._ID37596 = gettime();
                        var_3._ID37595 = var_3.origin;
                        var_3._ID38155 = 0;
                    }

                    if ( gettime() >= var_3._ID37596 + 5000 )
                    {
                        var_3._ID37596 = gettime();
                        var_10 = distancesquared( var_3.origin, var_3._ID37595 );
                        var_3._ID37595 = var_3.origin;

                        if ( var_10 < 90000 )
                        {
                            var_3._ID38155 = var_3._ID38155 + 5000;

                            if ( var_3._ID38155 >= 20000 )
                            {
                                var_11 = common_scripts\utility::_ID14293( var_3.origin, var_0 );

                                foreach ( var_13 in var_11 )
                                {
                                    if ( isbot( var_13 ) )
                                    {
                                        var_14 = var_13 botgetscriptgoaltype();

                                        if ( var_14 != "tactical" && var_14 != "critical" )
                                        {
                                            var_13 thread _ID37434( var_3 );
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            var_3._ID38155 = 0;
                            var_3._ID37595 = var_3.origin;
                        }
                    }
                }
            }
        }

        wait 1.0;
    }
}

_ID37434( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self botsetscriptgoal( var_0.origin, 0, "critical" );
    maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();
    self botclearscriptgoal();
}

_ID36853()
{
    if ( self.team == "axis" )
    {
        self._ID36940 = 0;
        self._ID37677 = undefined;
        self._ID37679 = undefined;
        self._ID37678 = 0;
        self._ID37682 = undefined;
        self._ID37681 = 0;
        var_0 = self botgetdifficultysetting( "throwKnifeChance" );

        if ( var_0 < 0.25 )
            self botsetdifficultysetting( "throwKnifeChance", 0.25 );

        self botsetdifficultysetting( "allowGrenades", 1 );
        self botsetflag( "path_traverse_wait", 1 );

        for (;;)
        {
            if ( self hasweapon( "throwingknife_mp" ) )
            {
                if ( maps\mp\_utility::_ID18638( self.enemy ) )
                {
                    var_1 = gettime();

                    if ( !isdefined( self._ID37677 ) || self._ID37677 != self.enemy )
                    {
                        self._ID37677 = self.enemy;
                        self._ID37679 = self.enemy getnearestnode();
                        self._ID37678 = var_1;
                    }
                    else
                    {
                        var_2 = squared( self botgetdifficultysetting( "meleeDist" ) );

                        if ( distancesquared( self.enemy.origin, self.origin ) <= var_2 )
                            self._ID36940 = var_1;

                        var_3 = self.enemy getnearestnode();
                        var_4 = self getnearestnode();

                        if ( !isdefined( self._ID37679 ) || self._ID37679 != var_3 )
                        {
                            self._ID37678 = var_1;
                            self._ID37679 = var_3;
                        }

                        if ( !isdefined( self._ID37682 ) || self._ID37682 != var_4 )
                        {
                            self._ID37681 = var_1;
                            self._ID37682 = var_4;
                        }
                        else if ( distancesquared( self.origin, self._ID37682.origin ) > 9216 )
                            self._ID37680 = var_1;

                        if ( self._ID36940 + 3000 < var_1 )
                        {
                            if ( self._ID37681 + 3000 < var_1 )
                            {
                                if ( self._ID37678 + 3000 < var_1 )
                                {
                                    if ( _ID36851( self.origin, self.enemy.origin ) )
                                        maps\mp\bots\_bots_util::bot_queued_process( "find_node_can_see_ent", ::_ID36852, self.enemy, self._ID37682 );

                                    if ( !self getammocount( "throwingknife_mp" ) )
                                        self setweaponammoclip( "throwingknife_mp", 1 );

                                    maps\mp\_utility::waitfortimeornotify( 30, "enemy" );
                                    self botclearscriptgoal();
                                }
                            }
                        }
                    }
                }
            }

            wait 0.25;
        }
    }
}

_ID36851( var_0, var_1 )
{
    if ( abs( var_0[2] - var_1[2] ) > 56.0 && distance2dsquared( var_0, var_1 ) < 2304 )
        return 1;

    return 0;
}

_ID36852( var_0, var_1 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_1 ) )
        return;

    var_2 = 0;

    if ( issubstr( var_1.type, "Begin" ) )
        var_2 = 1;

    var_3 = getlinkednodes( var_1 );

    if ( isdefined( var_3 ) && var_3.size )
    {
        var_4 = common_scripts\utility::array_randomize( var_3 );

        foreach ( var_6 in var_4 )
        {
            if ( var_2 && issubstr( var_6.type, "End" ) )
                continue;

            if ( _ID36851( var_6.origin, var_0.origin ) )
                continue;

            var_7 = self geteye() - self.origin;
            var_8 = var_6.origin + var_7;
            var_9 = var_0.origin;

            if ( isplayer( var_0 ) )
                var_9 = var_0 maps\mp\_utility::_ID15362();

            if ( sighttracepassed( var_8, var_9, 0, self, var_0 ) )
            {
                var_10 = vectortoyaw( var_9 - var_8 );
                self botsetscriptgoalnode( var_6, "critical", var_10 );
                maps\mp\bots\_bots_util::bot_waittill_goal_or_fail( 3.0 );
                return;
            }

            wait 0.05;
        }
    }
}
