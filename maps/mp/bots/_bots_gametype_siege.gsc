// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    _ID28940();
    thread bot_siege_manager_think();
    setup_bot_siege();
}

_ID28940()
{
    level.bot_funcs["gametype_think"] = ::bot_siege_think;
}

setup_bot_siege()
{
    level._ID5597 = 1;
}

bot_siege_manager_think()
{
    level.siege_bot_team_need_flags = [];
    maps\mp\_utility::gameflagwait( "prematch_done" );

    for (;;)
    {
        level.siege_bot_team_need_flags = [];

        foreach ( var_1 in level.players )
        {
            if ( !maps\mp\_utility::_ID18757( var_1 ) && var_1.hasspawned )
            {
                if ( var_1.team != "spectator" && var_1.team != "neutral" )
                    level.siege_bot_team_need_flags[var_1.team] = 1;
            }
        }

        var_3 = [];

        foreach ( var_5 in level._ID13222 )
        {
            var_6 = var_5._ID34757 maps\mp\gametypes\_gameobjects::_ID15224();

            if ( var_6 != "neutral" )
            {
                if ( !isdefined( var_3[var_6] ) )
                {
                    var_3[var_6] = 1;
                    continue;
                }

                var_3[var_6]++;
            }
        }

        foreach ( var_6, var_9 in var_3 )
        {
            if ( var_9 >= 2 )
            {
                var_10 = maps\mp\_utility::getotherteam( var_6 );
                level.siege_bot_team_need_flags[var_10] = 1;
            }
        }

        wait 1.0;
    }
}

bot_siege_think()
{
    self notify( "bot_siege_think" );
    self endon( "bot_siege_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( !isdefined( level._ID5597 ) )
        wait 0.05;

    while ( !isdefined( level.siege_bot_team_need_flags ) )
        wait 0.05;

    self botsetflag( "separation", 0 );
    self botsetflag( "use_obj_path_style", 1 );

    for (;;)
    {
        if ( isdefined( level.siege_bot_team_need_flags[self.team] ) && level.siege_bot_team_need_flags[self.team] )
            _ID36827();
        else if ( isdefined( self.goalflag ) )
        {
            if ( maps\mp\bots\_bots_util::bot_is_defending() )
                maps\mp\bots\_bots_strategy::bot_defend_stop();

            self.goalflag = undefined;
        }

        wait 1.0;
    }
}

_ID36827()
{
    var_0 = undefined;
    var_1 = undefined;

    foreach ( var_3 in level._ID13222 )
    {
        var_4 = var_3._ID34757 maps\mp\gametypes\_gameobjects::_ID15224();

        if ( var_4 != self.team )
        {
            var_5 = distancesquared( self.origin, var_3.origin );

            if ( !isdefined( var_1 ) || var_5 < var_1 )
            {
                var_1 = var_5;
                var_0 = var_3;
            }
        }
    }

    if ( isdefined( var_0 ) )
    {
        if ( !isdefined( self.goalflag ) || self.goalflag != var_0 )
        {
            self.goalflag = var_0;
            maps\mp\bots\_bots_strategy::_ID5516( var_0.origin, 100 );
        }
    }
}
