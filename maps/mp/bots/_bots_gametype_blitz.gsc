// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    _ID28940();
    _ID37977();
}

_ID28940()
{
    level.bot_funcs["gametype_think"] = ::_ID36820;
}

_ID37977()
{
    maps\mp\bots\_bots_util::_ID5828( 1 );
    level._ID25118 = 600;
    thread _ID36819();
    level._ID5597 = 1;
}

_ID36820()
{
    self notify( "bot_blitz_think" );
    self endon( "bot_blitz_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( !isdefined( level._ID5597 ) )
        wait 0.05;

    self botsetflag( "separation", 0 );

    for (;;)
    {
        wait 0.05;

        if ( !isdefined( self._ID37917 ) )
            _ID37499();

        if ( maps\mp\bots\_bots_strategy::bot_has_tactical_goal() )
            continue;

        if ( self._ID37917 == "attacker" )
        {
            var_0 = level._ID24742[common_scripts\utility::_ID14447( self.team )];

            if ( var_0._ID22927 )
            {
                if ( maps\mp\bots\_bots_util::bot_is_defending() )
                    maps\mp\bots\_bots_strategy::bot_defend_stop();

                if ( !self bothasscriptgoal() )
                    self botsetscriptgoal( var_0.origin, 0, "objective" );
            }
            else if ( !maps\mp\bots\_bots_util::bot_is_defending() )
            {
                self botclearscriptgoal();
                maps\mp\bots\_bots_strategy::bot_protect_point( var_0.origin, level._ID25118 );
            }

            continue;
        }

        if ( self._ID37917 == "defender" )
        {
            var_0 = level._ID24742[self.team];

            if ( !maps\mp\bots\_bots_util::bot_is_defending_point( var_0.origin ) )
            {
                var_1["min_goal_time"] = 20;
                var_1["max_goal_time"] = 30;
                var_1["score_flags"] = "strict_los";
                maps\mp\bots\_bots_strategy::bot_protect_point( var_0.origin, level._ID25118, var_1 );
            }
        }
    }
}

_ID37499()
{
    var_0 = _ID37255( self.team );
    var_1 = _ID37256( self.team );
    var_2 = _ID36785( self.team );
    var_3 = _ID36786( self.team );
    var_4 = level._ID5724[self._ID23475];

    if ( var_4 == "active" )
    {
        if ( var_0.size >= var_2 )
        {
            var_5 = 0;

            foreach ( var_7 in var_0 )
            {
                if ( isai( var_7 ) && level._ID5724[var_7._ID23475] == "stationary" )
                {
                    var_7._ID37917 = undefined;
                    var_5 = 1;
                    break;
                }
            }

            if ( var_5 )
            {
                _ID36788( "attacker" );
                return;
            }

            _ID36788( "defender" );
            return;
        }
        else
            _ID36788( "attacker" );
    }
    else if ( var_4 == "stationary" )
    {
        if ( var_1.size >= var_3 )
        {
            var_5 = 0;

            foreach ( var_10 in var_1 )
            {
                if ( isai( var_10 ) && level._ID5724[var_10._ID23475] == "active" )
                {
                    var_10._ID37917 = undefined;
                    var_5 = 1;
                    break;
                }
            }

            if ( var_5 )
            {
                _ID36788( "defender" );
                return;
            }

            _ID36788( "attacker" );
            return;
        }
        else
            _ID36788( "defender" );
    }
}

_ID36819()
{
    level notify( "bot_blitz_ai_director_update" );
    level endon( "bot_blitz_ai_director_update" );
    level endon( "game_ended" );
    var_0[0] = "allies";
    var_0[1] = "axis";

    for (;;)
    {
        foreach ( var_2 in var_0 )
        {
            var_3 = _ID36785( var_2 );
            var_4 = _ID36786( var_2 );
            var_5 = _ID37255( var_2 );
            var_6 = _ID37256( var_2 );

            if ( var_5.size > var_3 )
            {
                var_7 = [];
                var_8 = 0;

                foreach ( var_10 in var_5 )
                {
                    if ( isai( var_10 ) )
                    {
                        if ( level._ID5724[var_10._ID23475] == "stationary" )
                        {
                            var_10 _ID36788( "defender" );
                            var_8 = 1;
                            break;
                            continue;
                        }

                        var_7 = common_scripts\utility::array_add( var_7, var_10 );
                    }
                }

                if ( !var_8 && var_7.size > 0 )
                    common_scripts\utility::_ID25350( var_7 ) _ID36788( "defender" );
            }

            if ( var_6.size > var_4 )
            {
                var_12 = [];
                var_13 = 0;

                foreach ( var_15 in var_6 )
                {
                    if ( isai( var_15 ) )
                    {
                        if ( level._ID5724[var_15._ID23475] == "active" )
                        {
                            var_15 _ID36788( "attacker" );
                            var_13 = 1;
                            break;
                            continue;
                        }

                        var_12 = common_scripts\utility::array_add( var_12, var_15 );
                    }
                }

                if ( !var_13 && var_12.size > 0 )
                    common_scripts\utility::_ID25350( var_12 ) _ID36788( "attacker" );
            }
        }

        wait 1.0;
    }
}

_ID36785( var_0 )
{
    var_1 = _ID36787( var_0 );
    return int( int( var_1 ) / 2 ) + 1 + int( var_1 ) % 2;
}

_ID36786( var_0 )
{
    var_1 = _ID36787( var_0 );
    return max( int( int( var_1 ) / 2 ) - 1, 0 );
}

_ID36787( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in level._ID23303 )
    {
        if ( maps\mp\_utility::_ID18820( var_3 ) && isdefined( var_3.team ) && var_3.team == var_0 )
            var_1++;
    }

    return var_1;
}

_ID37255( var_0 )
{
    var_1 = _ID37312( "attacker", var_0 );

    foreach ( var_3 in level.players )
    {
        if ( !isai( var_3 ) && isdefined( var_3.team ) && var_3.team == var_0 )
        {
            if ( distancesquared( level._ID24742[var_0].origin, var_3.origin ) > level._ID25118 * level._ID25118 )
                var_1 = common_scripts\utility::array_add( var_1, var_3 );
        }
    }

    return var_1;
}

_ID37256( var_0 )
{
    var_1 = _ID37312( "defender", var_0 );

    foreach ( var_3 in level.players )
    {
        if ( !isai( var_3 ) && isdefined( var_3.team ) && var_3.team == var_0 )
        {
            if ( distancesquared( level._ID24742[var_0].origin, var_3.origin ) <= level._ID25118 * level._ID25118 )
                var_1 = common_scripts\utility::array_add( var_1, var_3 );
        }
    }

    return var_1;
}

_ID36788( var_0 )
{
    self._ID37917 = var_0;
    self botclearscriptgoal();
    maps\mp\bots\_bots_strategy::bot_defend_stop();
}

_ID37312( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in level._ID23303 )
    {
        if ( !isdefined( var_4.team ) )
            continue;

        if ( isalive( var_4 ) && maps\mp\_utility::_ID18820( var_4 ) && var_4.team == var_1 && isdefined( var_4._ID37917 ) && var_4._ID37917 == var_0 )
            var_2[var_2.size] = var_4;
    }

    return var_2;
}
