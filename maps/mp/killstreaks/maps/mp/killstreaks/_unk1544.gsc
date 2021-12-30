// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["high_value_target"] = ::_ID33852;
    level._ID17301["axis"] = 0;
    level._ID17301["allies"] = 0;
    game["dialog"]["hvt_gone"] = "hvt_gone";
}

_ID33852( var_0, var_1 )
{
    return _ID34749( self, var_0 );
}

_ID25510()
{
    if ( level._ID32653 )
        return level._ID17301[self.team] >= 4;
    else if ( isdefined( self._ID17301 ) )
        return self._ID17301 >= 2;

    return 0;
}

_ID34749( var_0, var_1 )
{
    if ( !maps\mp\_utility::_ID18757( var_0 ) )
        return 0;

    if ( var_0.team == "spectator" )
        return 0;

    if ( _ID25510() || isdefined( var_0._ID17301 ) && var_0._ID17301 >= 2 )
    {
        self iprintlnbold( &"KILLSTREAKS_HVT_MAX" );
        return 0;
    }

    var_0 thread _ID28750();
    level thread maps\mp\_utility::_ID32672( "used_hvt", var_0, var_0.team );
    return 1;
}

_ID28750()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 = self.team;
    _ID17538();
    thread _ID36090( var_0 );
    maps\mp\gametypes\_hostmigration::_ID35597( 10 );

    if ( level._ID32653 )
        maps\mp\_utility::_ID19760( "hvt_gone", var_0 );
    else
        maps\mp\_utility::_ID19765( "hvt_gone" );

    if ( level._ID32653 )
        level decreasexpboost( var_0 );
    else
        decreasexpboost();
}

_ID17538()
{
    var_0 = 0;

    if ( level._ID32653 )
    {
        level._ID17301[self.team]++;
        var_0 = level._ID17301[self.team];
        var_1 = self.team;
    }
    else
    {
        if ( !isdefined( self._ID17301 ) )
            self._ID17301 = 1;
        else
            self._ID17301++;

        var_0 = self._ID17301;
        var_1 = self getentitynumber();
    }

    var_2 = 1 + var_0 * 0.5;
    level._ID32685[var_1] = clamp( var_2, 1, 4 );
}

decreasexpboost( var_0 )
{
    var_1 = 0;

    if ( level._ID32653 )
    {
        if ( level._ID17301[var_0] > 0 )
            level._ID17301[var_0]--;

        var_1 = level._ID17301[var_0];
        var_2 = var_0;
    }
    else
    {
        if ( self._ID17301 > 0 )
            self._ID17301--;

        var_1 = self._ID17301;
        var_2 = self getentitynumber();
    }

    var_3 = 1 + var_1 * 0.5;
    level._ID32685[var_2] = clamp( var_3, 1, 4 );
}

_ID36090( var_0 )
{
    level endon( "game_ended" );
    var_1 = common_scripts\utility::_ID35635( "disconnect", "joined_team", "joined_spectators" );

    if ( level._ID32653 )
        level decreasexpboost( var_0 );
    else if ( isdefined( self ) && var_1 != "disconnect" )
        decreasexpboost();
}
