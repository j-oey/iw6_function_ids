// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["team_ammo_refill"] = ::_ID33880;
}

_ID33880( var_0 )
{
    var_1 = _ID15633();

    if ( var_1 )
        maps\mp\_matchdata::_ID20253( "team_ammo_refill", self.origin );

    return var_1;
}

_ID15633()
{
    if ( level._ID32653 )
    {
        foreach ( var_1 in level.players )
        {
            if ( var_1.team == self.team )
                var_1 _ID25641( 1 );
        }
    }
    else
        _ID25641( 1 );

    level thread maps\mp\_utility::_ID32672( "used_team_ammo_refill", self );
    return 1;
}

_ID25641( var_0 )
{
    var_1 = self getweaponslistall();

    if ( var_0 )
    {
        if ( maps\mp\_utility::_hasperk( "specialty_tacticalinsertion" ) && self getammocount( "flare_mp" ) < 1 )
            maps\mp\_utility::_ID15613( "specialty_tacticalinsertion", 0 );
    }

    foreach ( var_3 in var_1 )
    {
        if ( issubstr( var_3, "grenade" ) || getsubstr( var_3, 0, 2 ) == "gl" )
        {
            if ( !var_0 || self getammocount( var_3 ) >= 1 )
                continue;
        }

        self givemaxammo( var_3 );
    }

    self playlocalsound( "ammo_crate_use" );
}
