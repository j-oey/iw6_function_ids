// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID32657["allies"] = 0;
    level._ID32657["axis"] = 0;
    level._ID11399 = undefined;
    level.emptimeout = 10.0;
    level.emptimeremaining = int( level.emptimeout );
    level._ID19256["jammer"] = ::emp_use;
    level thread _ID22877();
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread _ID22886();
        var_0 thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "spawned_player" );

        if ( maps\mp\killstreaks\_unk1534::_ID29881() )
            maps\mp\killstreaks\_unk1534::applyperplayerempeffects();
    }
}

_ID22886()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "death" );
        maps\mp\killstreaks\_unk1534::_ID31838();
    }
}

emp_use( var_0, var_1 )
{
    var_2 = self.pers["team"];

    if ( level._ID32653 )
    {
        var_3 = level._ID23070[var_2];
        thread _ID11387( var_3 );
    }
    else
        thread emp_jamplayers( self );

    maps\mp\_matchdata::_ID20253( "jammer", self.origin );
    self notify( "used_emp" );
    level notify( "emp_used" );
    return 1;
}

_ID11387( var_0 )
{
    level endon( "game_ended" );
    wait 0.5;
    thread maps\mp\_utility::_ID32672( "used_jammer", self );
    level notify( "EMP_JamTeam" + var_0 );
    level endon( "EMP_JamTeam" + var_0 );
    level._ID32657[var_0] = 1;

    foreach ( var_2 in level.players )
    {
        var_2 maps\mp\killstreaks\_unk1534::applyperplayerempeffects_ondetonate();

        if ( var_2 maps\mp\killstreaks\_unk1534::_ID29881() )
            var_2 maps\mp\killstreaks\_unk1534::applyperplayerempeffects();
    }

    level thread maps\mp\killstreaks\_unk1534::applyglobalempeffects();
    level notify( "emp_update" );
    level _ID9812( self, var_0 );
    level thread _ID19102();
    maps\mp\gametypes\_hostmigration::_ID35597( level.emptimeout );
    level._ID32657[var_0] = 0;

    foreach ( var_2 in level.players )
    {
        if ( var_2.team == var_0 && !var_2 maps\mp\killstreaks\_unk1534::_ID29881() )
            var_2 maps\mp\killstreaks\_unk1534::_ID26023();
    }

    level notify( "emp_update" );
}

emp_jamplayers( var_0 )
{
    level notify( "EMP_JamPlayers" );
    level endon( "EMP_JamPlayers" );
    wait 0.5;

    if ( !isdefined( var_0 ) )
        return;

    level._ID11399 = var_0;

    foreach ( var_2 in level.players )
    {
        var_2 maps\mp\killstreaks\_unk1534::applyperplayerempeffects_ondetonate();

        if ( var_2 maps\mp\killstreaks\_unk1534::_ID29881() )
            var_2 maps\mp\killstreaks\_unk1534::applyperplayerempeffects();
    }

    level thread maps\mp\killstreaks\_unk1534::applyglobalempeffects();
    level notify( "emp_update" );
    level._ID11399 thread _ID11400();
    level _ID9812( var_0 );
    level thread _ID19102();
    maps\mp\gametypes\_hostmigration::_ID35597( level.emptimeout );
    level._ID11399 = undefined;

    foreach ( var_2 in level.players )
    {
        if ( ( !isdefined( var_0 ) || var_2 != var_0 ) && !var_2 maps\mp\killstreaks\_unk1534::_ID29881() )
            var_2 maps\mp\killstreaks\_unk1534::_ID26023();
    }

    level notify( "emp_update" );
    level notify( "emp_ended" );
}

_ID19102()
{
    level notify( "keepEMPTimeRemaining" );
    level endon( "keepEMPTimeRemaining" );
    level endon( "emp_ended" );

    for ( level.emptimeremaining = int( level.emptimeout ); level.emptimeremaining; level.emptimeremaining-- )
        wait 1.0;
}

_ID11400()
{
    level endon( "EMP_JamPlayers" );
    level endon( "emp_ended" );
    self waittill( "disconnect" );
    level notify( "emp_update" );
}

_ID9812( var_0, var_1 )
{
    maps\mp\killstreaks\_killstreaks::destroytargetarray( var_0, var_1, "killstreak_emp_mp", level._ID34099 );
    maps\mp\killstreaks\_killstreaks::destroytargetarray( var_0, var_1, "killstreak_emp_mp", level.placedims );
    maps\mp\killstreaks\_killstreaks::destroytargetarray( var_0, var_1, "killstreak_emp_mp", level.balldrones );
    thread maps\mp\killstreaks\_killstreaks::destroytargetarray( var_0, var_1, "killstreak_emp_mp", level._ID34657 );
    maps\mp\killstreaks\_killstreaks::destroytargetarray( var_0, var_1, "killstreak_emp_mp", level._ID21075 );
}
