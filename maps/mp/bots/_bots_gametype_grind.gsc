// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    _ID28940();
    maps\mp\bots\_bots_gametype_conf::_ID37978();
}

_ID28940()
{
    level.bot_funcs["gametype_think"] = ::_ID36849;
}

_ID36849()
{
    self notify( "bot_grind_think" );
    self endon( "bot_grind_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self._ID37385 = 0;
    self._ID37381 = undefined;
    self._ID36989 = 0;
    self._ID36667 = ::_ID36848;

    if ( self botgetdifficultysetting( "strategyLevel" ) > 0 )
        childthread _ID37176();

    maps\mp\bots\_bots_gametype_conf::_ID36830();
}

_ID36848()
{
    if ( !isdefined( self._ID38136 ) )
    {
        if ( self._ID32367 > 0 )
        {
            var_0 = squared( 500 + self._ID32367 * 250 );

            if ( game["teamScores"][self.team] + self._ID32367 >= maps\mp\_utility::getwatcheddvar( "scorelimit" ) )
                var_0 = squared( 5000 );
            else if ( !isdefined( self.enemy ) && !maps\mp\bots\_bots_util::bot_in_combat() )
                var_0 = squared( 1500 + self._ID32367 * 250 );

            var_1 = undefined;

            foreach ( var_3 in level._ID36589 )
            {
                var_4 = distancesquared( self.origin, var_3.origin );

                if ( var_4 < var_0 )
                {
                    var_0 = var_4;
                    var_1 = var_3;
                }
            }

            if ( isdefined( var_1 ) )
            {
                var_6 = 1;

                if ( self._ID37385 )
                {
                    if ( isdefined( self._ID37381 ) && self._ID37381 == var_1 )
                        var_6 = 0;
                }

                if ( var_6 )
                {
                    self._ID37385 = 1;
                    self._ID37381 = var_1;
                    self botclearscriptgoal();
                    self notify( "stop_going_to_zone" );
                    self notify( "stop_camping_zone" );
                    self._ID36989 = 0;
                    maps\mp\bots\_bots_personality::_ID7425();
                    maps\mp\bots\_bots_strategy::bot_abort_tactical_goal( "kill_tag" );
                    childthread _ID36847( var_1, "tactical" );
                }
            }

            if ( self._ID37385 )
            {
                if ( game["teamScores"][self.team] + self._ID32367 >= maps\mp\_utility::getwatcheddvar( "scorelimit" ) )
                    self botsetflag( "force_sprint", 1 );
            }
        }
        else if ( self._ID37385 )
        {
            self._ID37385 = 0;
            self._ID37381 = undefined;
            self notify( "stop_going_to_zone" );
            self botclearscriptgoal();
        }

        if ( self._ID23475 == "camper" && !self._ID36988 && !self._ID37385 )
        {
            var_0 = undefined;
            var_1 = undefined;

            foreach ( var_3 in level._ID36589 )
            {
                var_4 = distancesquared( self.origin, var_3.origin );

                if ( !isdefined( var_0 ) || var_4 < var_0 )
                {
                    var_0 = var_4;
                    var_1 = var_3;
                }
            }

            if ( isdefined( var_1 ) )
            {
                if ( maps\mp\bots\_bots_personality::_ID29836() )
                {
                    if ( maps\mp\bots\_bots_personality::_ID12890( var_1.origin ) )
                    {
                        self._ID36989 = 1;
                        self notify( "stop_going_to_zone" );
                        self._ID37385 = 0;
                        self botclearscriptgoal();
                        childthread _ID36823( var_1, "camp" );
                    }
                    else
                    {
                        self notify( "stop_camping_zone" );
                        self._ID36989 = 0;
                        maps\mp\bots\_bots_personality::_ID7425();
                    }
                }
            }
            else
                self._ID36989 = 1;
        }
    }
    else
    {
        self notify( "stop_going_to_zone" );
        self._ID37385 = 0;
        self._ID37381 = undefined;
        self notify( "stop_camping_zone" );
        self._ID36989 = 0;
    }

    return self._ID37385 || self._ID36989;
}

_ID36847( var_0, var_1 )
{
    self endon( "stop_going_to_zone" );

    if ( !isdefined( var_0.calculated_nearest_node ) )
    {
        var_0._ID21893 = getclosestnodeinsight( var_0.origin );
        var_0.calculated_nearest_node = 1;
    }

    var_2 = var_0._ID21893;
    self botsetscriptgoal( var_2.origin, 32, var_1 );
    var_3 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();
}

_ID36823( var_0, var_1 )
{
    self endon( "stop_camping_zone" );
    self botsetscriptgoalnode( self._ID22077, var_1, self.ambush_yaw );
    var_2 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();

    if ( var_2 == "goal" )
    {
        if ( !isdefined( var_0.calculated_nearest_node ) )
        {
            var_0._ID21893 = getclosestnodeinsight( var_0.origin );
            var_0.calculated_nearest_node = 1;
        }

        var_3 = var_0._ID21893;

        if ( isdefined( var_3 ) )
        {
            var_4 = findentrances( self.origin );
            var_4 = common_scripts\utility::array_add( var_4, var_3 );
            childthread maps\mp\bots\_bots_util::bot_watch_nodes( var_4 );
        }
    }
}

_ID37176()
{
    self._ID37081 = self botgetdifficultysetting( "meleeChargeDist" );

    for (;;)
    {
        if ( self botgetdifficultysetting( "strategyLevel" ) < 2 )
            wait 0.5;
        else
            wait 0.2;

        if ( isdefined( self.enemy ) && isplayer( self.enemy ) && isdefined( self.enemy._ID32367 ) && self.enemy._ID32367 >= 3 && self botcanseeentity( self.enemy ) && distance( self.origin, self.enemy.origin ) <= 500 )
        {
            self botsetdifficultysetting( "meleeChargeDist", 500 );
            self botsetflag( "prefer_melee", 1 );
            continue;
        }

        self botsetdifficultysetting( "meleeChargeDist", self._ID37081 );
        self botsetflag( "prefer_melee", 0 );
    }
}
