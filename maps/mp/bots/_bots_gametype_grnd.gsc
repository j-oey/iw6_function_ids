// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    _ID28940();
    setup_bot_grnd();
}

_ID28940()
{
    level.bot_funcs["gametype_think"] = ::bot_grnd_think;
}

setup_bot_grnd()
{
    maps\mp\bots\_bots_util::_ID5828( 1 );
    level._ID25118 = 128;
    level._ID5597 = 1;
}

bot_grnd_think()
{
    self notify( "bot_grnd_think" );
    self endon( "bot_grnd_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( !isdefined( level._ID5597 ) )
        wait 0.05;

    self botsetflag( "separation", 0 );

    for (;;)
    {
        wait 0.05;

        if ( maps\mp\bots\_bots_strategy::bot_has_tactical_goal() )
            continue;

        if ( !self bothasscriptgoal() )
        {
            self botsetscriptgoal( level.grnd_zone.origin, 0, "objective" );
            continue;
        }

        if ( !maps\mp\bots\_bots_util::bot_is_defending() )
        {
            self botclearscriptgoal();
            maps\mp\bots\_bots_strategy::bot_protect_point( level.grnd_zone.origin, level._ID25118 );
        }
    }
}
