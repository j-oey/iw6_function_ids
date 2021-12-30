// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\bots\_bots_gametype_sd::_ID28940();
    _ID28940();
    maps\mp\bots\_bots_gametype_conf::_ID37978();
    maps\mp\bots\_bots_gametype_sd::_ID36875();
}

_ID28940()
{
    level.bot_funcs["gametype_think"] = ::_ID36882;
}

_ID36882()
{
    self notify( "bot_sr_think" );
    self endon( "bot_sr_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( !isdefined( level._ID5597 ) )
        wait 0.05;

    self._ID38125 = undefined;
    childthread _ID38138();
    maps\mp\bots\_bots_gametype_sd::_ID36876();
}

_ID38138()
{
    for (;;)
    {
        wait 0.05;

        if ( self.health <= 0 )
            continue;

        if ( !isdefined( self._ID37917 ) )
            continue;

        var_0 = maps\mp\bots\_bots_gametype_conf::_ID36843( 0 );

        if ( var_0.size > 0 )
        {
            var_1 = common_scripts\utility::_ID25350( var_0 );

            if ( distancesquared( self.origin, var_1.tag.curorigin ) < 10000 )
                _ID38115( var_1.tag );
            else if ( self.team == game["attackers"] )
            {
                if ( self._ID37917 != "atk_bomber" )
                    _ID38115( var_1.tag );
            }
            else if ( self._ID37917 != "bomb_defuser" )
                _ID38115( var_1.tag );
        }
    }
}

_ID38115( var_0 )
{
    if ( isdefined( var_0._ID36870 ) && isdefined( var_0._ID36870[self.team] ) && isalive( var_0._ID36870[self.team] ) && var_0._ID36870[self.team] != self )
        return;

    if ( _ID38113( var_0 ) )
        return;

    if ( !isdefined( self._ID37917 ) )
        return;

    if ( maps\mp\bots\_bots_util::bot_is_defending() )
        maps\mp\bots\_bots_strategy::bot_defend_stop();

    var_0._ID36870[self.team] = self;
    var_0 thread _ID36972();
    var_0 thread _ID36971( self );
    self._ID38125 = 1;
    childthread _ID37740( var_0, "tag_picked_up" );
    var_1 = var_0.curorigin;
    self botsetscriptgoal( var_1, 0, "tactical" );
    childthread _ID38289( var_0 );
    var_2 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail( undefined, "tag_picked_up", "new_role" );
    self notify( "stop_watch_tag_destination" );

    if ( var_2 == "no_path" )
    {
        var_1 += ( 16 * _ID37851(), 16 * _ID37851(), 0 );
        self botsetscriptgoal( var_1, 0, "tactical" );
        var_2 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail( undefined, "tag_picked_up", "new_role" );

        if ( var_2 == "no_path" )
        {
            var_1 = maps\mp\bots\_bots_util::bot_queued_process( "BotGetClosestNavigablePoint", maps\mp\bots\_bots_util::_ID13734, var_0.curorigin, 32, self );

            if ( isdefined( var_1 ) )
            {
                self botsetscriptgoal( var_1, 0, "tactical" );
                var_2 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail( undefined, "tag_picked_up", "new_role" );
            }
        }
    }
    else if ( var_2 == "bad_path" )
    {
        var_3 = getnodesinradiussorted( var_0.curorigin, 256, 0, level._ID36883 + 55 );

        if ( var_3.size > 0 )
        {
            var_4 = ( var_0.curorigin[0], var_0.curorigin[1], ( var_3[0].origin[2] + var_0.curorigin[2] ) * 0.5 );
            self botsetscriptgoal( var_4, 0, "tactical" );
            var_2 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail( undefined, "tag_picked_up", "new_role" );
        }
    }

    if ( var_2 == "goal" && var_0 maps\mp\gametypes\_gameobjects::_ID6602( self.team ) )
        wait 3.0;

    if ( self bothasscriptgoal() && isdefined( var_1 ) )
    {
        var_5 = self botgetscriptgoal();

        if ( maps\mp\bots\_bots_util::_ID5824( var_5, var_1 ) )
            self botclearscriptgoal();
    }

    self notify( "stop_tag_watcher" );
    var_0._ID36870[self.team] = undefined;
    self._ID38125 = undefined;
}

_ID38289( var_0 )
{
    self endon( "stop_watch_tag_destination" );

    for (;;)
    {
        if ( !var_0 maps\mp\gametypes\_gameobjects::_ID6602( self.team ) )
            wait 0.05;

        var_1 = self botgetscriptgoal();
        wait 0.05;
    }
}

_ID38113( var_0 )
{
    var_1 = distance( self.origin, var_0.curorigin );
    var_2 = maps\mp\bots\_bots_gametype_sd::_ID37290( self.team, 1 );

    foreach ( var_4 in var_2 )
    {
        if ( var_4 != self && isdefined( var_4._ID37917 ) && var_4._ID37917 != "atk_bomber" && var_4._ID37917 != "bomb_defuser" )
        {
            var_5 = distance( var_4.origin, var_0.curorigin );

            if ( var_5 < var_1 * 0.5 )
                return 1;
        }
    }

    return 0;
}

_ID37851()
{
    return randomintrange( 0, 2 ) * 2 - 1;
}

_ID36972()
{
    self waittill( "reset" );
    self._ID36870 = [];
}

_ID36971( var_0 )
{
    self endon( "reset" );
    var_1 = var_0.team;
    var_0 common_scripts\utility::_ID35626( "death", "disconnect" );
    self._ID36870[var_1] = undefined;
}

_ID37740( var_0, var_1 )
{
    self endon( "stop_tag_watcher" );

    while ( var_0 maps\mp\gametypes\_gameobjects::_ID6602( self.team ) && !maps\mp\bots\_bots_gametype_conf::_ID36826( var_0 ) )
        wait 0.05;

    self notify( var_1 );
}

_ID38114( var_0 )
{
    if ( isdefined( var_0._ID36824 ) && isdefined( var_0._ID36824[self.team] ) && isalive( var_0._ID36824[self.team] ) && var_0._ID36824[self.team] != self )
        return;

    if ( !isdefined( self._ID37917 ) )
        return;

    if ( maps\mp\bots\_bots_util::bot_is_defending() )
        maps\mp\bots\_bots_strategy::bot_defend_stop();

    var_0._ID36824[self.team] = self;
    var_0 thread _ID36970();
    var_0 thread _ID36969( self );
    self._ID38125 = 1;
    maps\mp\bots\_bots_personality::_ID7425();
    var_1 = self._ID37917;

    while ( var_0 maps\mp\gametypes\_gameobjects::_ID6602( self.team ) && self._ID37917 == var_1 )
    {
        if ( maps\mp\bots\_bots_personality::_ID29836() )
        {
            if ( maps\mp\bots\_bots_personality::_ID12890( var_0.curorigin, 1000 ) )
                childthread maps\mp\bots\_bots_gametype_conf::_ID36822( var_0, "tactical", "new_role" );
        }

        wait 0.05;
    }

    self notify( "stop_camping_tag" );
    self botclearscriptgoal();
    var_0._ID36824[self.team] = undefined;
    self._ID38125 = undefined;
}

_ID36970()
{
    self waittill( "reset" );
    self._ID36824 = [];
}

_ID36969( var_0 )
{
    self endon( "reset" );
    var_1 = var_0.team;
    var_0 common_scripts\utility::_ID35626( "death", "disconnect" );
    self._ID36824[var_1] = undefined;
}
