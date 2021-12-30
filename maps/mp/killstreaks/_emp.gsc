// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{

}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "spawned_player" );

        if ( level._ID32653 && level._ID32657[self.team] || !level._ID32653 && isdefined( level._ID11399 ) && level._ID11399 != self )
            self setempjammed( 1 );
    }
}

emp_use( var_0, var_1 )
{
    var_2 = self.pers["team"];

    if ( level.multiteambased )
        thread _ID11388( var_2 );
    else if ( level._ID32653 )
    {
        var_3 = level._ID23070[var_2];
        thread _ID11387( var_3 );
    }
    else
        thread emp_jamplayers( self );

    maps\mp\_matchdata::_ID20253( "emp", self.origin );
    self notify( "used_emp" );
    return 1;
}

_ID11388( var_0 )
{
    level endon( "game_ended" );
    thread maps\mp\_utility::_ID32672( "used_emp", self );
    level notify( "EMP_JamTeam" + var_0 );
    level endon( "EMP_JamTeam" + var_0 );

    foreach ( var_2 in level.players )
    {
        var_2 playlocalsound( "emp_activate" );

        if ( var_2.team == var_0 )
            continue;

        if ( var_2 maps\mp\_utility::_hasperk( "specialty_localjammer" ) )
            var_2 clearscrambler();
    }

    visionsetnaked( "coup_sunblind", 0.1 );
    thread empeffects();
    wait 0.1;
    visionsetnaked( "coup_sunblind", 0 );
    visionsetnaked( "", 3.0 );

    for ( var_4 = 0; var_4 < level._ID32668.size; var_4++ )
    {
        if ( var_0 != level._ID32668[var_4] )
            level._ID32657[level._ID32668[var_4]] = 1;
    }

    level notify( "emp_update" );

    for ( var_4 = 0; var_4 < level._ID32668.size; var_4++ )
    {
        if ( var_0 != level._ID32668[var_4] )
            level _ID9792( self, level._ID32668[var_4] );
    }

    level thread _ID19102();
    maps\mp\gametypes\_hostmigration::_ID35597( level.emptimeout );

    for ( var_4 = 0; var_4 < level._ID32668.size; var_4++ )
    {
        if ( var_0 != level._ID32668[var_4] )
            level._ID32657[level._ID32668[var_4]] = 0;
    }

    foreach ( var_2 in level.players )
    {
        if ( var_2.team == var_0 )
            continue;

        if ( var_2 maps\mp\_utility::_hasperk( "specialty_localjammer" ) )
            var_2 makescrambler();
    }

    level notify( "emp_update" );
}

_ID11387( var_0 )
{
    level endon( "game_ended" );
    thread maps\mp\_utility::_ID32672( "used_emp", self );
    level notify( "EMP_JamTeam" + var_0 );
    level endon( "EMP_JamTeam" + var_0 );

    foreach ( var_2 in level.players )
    {
        var_2 playlocalsound( "emp_activate" );

        if ( var_2.team != var_0 )
            continue;

        if ( var_2 maps\mp\_utility::_hasperk( "specialty_localjammer" ) )
            var_2 clearscrambler();

        var_2 visionsetnakedforplayer( "coup_sunblind", 0.1 );
    }

    thread empeffects();
    wait 0.1;
    visionsetnaked( "coup_sunblind", 0 );
    visionsetnaked( "", 3.0 );
    level._ID32657[var_0] = 1;
    level notify( "emp_update" );
    level _ID9792( self, var_0 );
    level thread _ID19102();
    maps\mp\gametypes\_hostmigration::_ID35597( level.emptimeout );
    level._ID32657[var_0] = 0;

    foreach ( var_2 in level.players )
    {
        if ( var_2.team != var_0 )
            continue;

        if ( var_2 maps\mp\_utility::_hasperk( "specialty_localjammer" ) )
            var_2 makescrambler();
    }

    level notify( "emp_update" );
}

emp_jamplayers( var_0 )
{
    level notify( "EMP_JamPlayers" );
    level endon( "EMP_JamPlayers" );

    foreach ( var_2 in level.players )
    {
        var_2 playlocalsound( "emp_activate" );

        if ( var_2 == var_0 )
            continue;

        if ( var_2 maps\mp\_utility::_hasperk( "specialty_localjammer" ) )
            var_2 clearscrambler();
    }

    visionsetnaked( "coup_sunblind", 0.1 );
    thread empeffects();
    wait 0.1;
    visionsetnaked( "coup_sunblind", 0 );
    visionsetnaked( "", 3.0 );
    level notify( "emp_update" );
    level._ID11399 = var_0;
    level._ID11399 thread _ID11400();
    level _ID9792( var_0 );
    level notify( "emp_update" );
    level thread _ID19102();
    maps\mp\gametypes\_hostmigration::_ID35597( level.emptimeout );

    foreach ( var_2 in level.players )
    {
        if ( var_2 == var_0 )
            continue;

        if ( var_2 maps\mp\_utility::_hasperk( "specialty_localjammer" ) )
            var_2 makescrambler();
    }

    level._ID11399 = undefined;
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

empeffects()
{
    foreach ( var_1 in level.players )
    {
        var_2 = anglestoforward( var_1.angles );
        var_2 = ( var_2[0], var_2[1], 0 );
        var_2 = vectornormalize( var_2 );
        var_3 = 20000;
        var_4 = spawn( "script_model", var_1.origin + ( 0, 0, 8000 ) + var_2 * var_3 );
        var_4 setmodel( "tag_origin" );
        var_4.angles = var_4.angles + ( 270, 0, 0 );
        var_4 thread _ID11393( var_1 );
    }
}

_ID11393( var_0 )
{
    var_0 endon( "disconnect" );
    wait 0.5;
    playfxontagforclients( level._ID1644["emp_flash"], self, "tag_origin", var_0 );
}

emp_teamtracker()
{
    level endon( "game_ended" );

    for (;;)
    {
        level common_scripts\utility::_ID35663( "joined_team", "emp_update" );

        foreach ( var_1 in level.players )
        {
            if ( var_1.team == "spectator" )
                continue;

            if ( !level._ID32657[var_1.team] && !var_1 maps\mp\_utility::_ID18610() )
            {
                var_1 enablejammedeffect( 0 );
                continue;
            }

            var_1 enablejammedeffect( 1 );
        }
    }
}

_ID11389()
{
    level endon( "game_ended" );

    for (;;)
    {
        level common_scripts\utility::_ID35663( "joined_team", "emp_update" );

        foreach ( var_1 in level.players )
        {
            if ( var_1.team == "spectator" )
                continue;

            if ( isdefined( level._ID11399 ) && level._ID11399 != var_1 )
            {
                var_1 enablejammedeffect( 1 );
                continue;
            }

            if ( !var_1 maps\mp\_utility::_ID18610() )
                var_1 enablejammedeffect( 0 );
        }
    }
}

_ID9792( var_0, var_1 )
{
    thread _ID9785( var_0, var_1 );
    thread destroyactivelittlebirds( var_0, var_1 );
    thread destroyactiveturrets( var_0, var_1 );
    thread destroyactiverockets( var_0, var_1 );
    thread destroyactiveuavs( var_0, var_1 );
    thread destroyactiveimss( var_0, var_1 );
    thread destroyactiveugvs( var_0, var_1 );
    thread _ID9783( var_0, var_1 );
    thread _ID9784( var_0, var_1 );
    thread _ID9819( var_0, var_1, level._ID25810 );
    thread _ID9819( var_0, var_1, level._ID34657 );
}

_ID9819( var_0, var_1, var_2 )
{
    var_3 = "MOD_EXPLOSIVE";
    var_4 = "killstreak_emp_mp";
    var_5 = 5000;
    var_6 = ( 0, 0, 0 );
    var_7 = ( 0, 0, 0 );
    var_8 = "";
    var_9 = "";
    var_10 = "";
    var_11 = undefined;

    foreach ( var_13 in var_2 )
    {
        if ( level._ID32653 && isdefined( var_1 ) )
        {
            if ( isdefined( var_13.team ) && var_13.team != var_1 )
                continue;
        }
        else if ( isdefined( var_13.owner ) && var_13.owner == var_0 )
            continue;

        var_13 notify( "damage",  var_5, var_0, var_6, var_7, var_3, var_8, var_9, var_10, var_11, var_4  );
        wait 0.05;
    }
}

_ID9785( var_0, var_1 )
{
    _ID9819( var_0, var_1, level._ID16755 );
}

destroyactivelittlebirds( var_0, var_1 )
{
    _ID9819( var_0, var_1, level._ID20086 );
}

destroyactiveturrets( var_0, var_1 )
{
    _ID9819( var_0, var_1, level._ID34099 );
}

destroyactiverockets( var_0, var_1 )
{
    var_2 = "MOD_EXPLOSIVE";
    var_3 = "killstreak_emp_mp";
    var_4 = 5000;
    var_5 = ( 0, 0, 0 );
    var_6 = ( 0, 0, 0 );
    var_7 = "";
    var_8 = "";
    var_9 = "";
    var_10 = undefined;

    foreach ( var_12 in level._ID26359 )
    {
        if ( level._ID32653 && isdefined( var_1 ) )
        {
            if ( isdefined( var_12.team ) && var_12.team != var_1 )
                continue;
        }
        else if ( isdefined( var_12.owner ) && var_12.owner == var_0 )
            continue;

        playfx( level._ID25819["explode"], var_12.origin );
        var_12 delete();
        wait 0.05;
    }
}

destroyactiveuavs( var_0, var_1 )
{
    var_2 = level._ID34165;

    if ( level._ID32653 && isdefined( var_1 ) )
        var_2 = level._ID34165[var_1];

    _ID9819( var_0, var_1, var_2 );
}

destroyactiveimss( var_0, var_1 )
{
    _ID9819( var_0, var_1, level._ID17442 );
}

destroyactiveugvs( var_0, var_1 )
{
    _ID9819( var_0, var_1, level._ID34171 );
}

_ID9783( var_0, var_1 )
{
    var_2 = "MOD_EXPLOSIVE";
    var_3 = "killstreak_emp_mp";
    var_4 = 5000;
    var_5 = ( 0, 0, 0 );
    var_6 = ( 0, 0, 0 );
    var_7 = "";
    var_8 = "";
    var_9 = "";
    var_10 = undefined;

    if ( level._ID32653 && isdefined( var_1 ) )
    {
        if ( isdefined( level.ac130player ) && isdefined( level.ac130player.team ) && level.ac130player.team == var_1 )
            level.ac130.planemodel notify( "damage",  var_4, var_0, var_5, var_6, var_2, var_7, var_8, var_9, var_10, var_3  );
    }
    else if ( isdefined( level.ac130player ) )
    {
        if ( !isdefined( level.ac130.owner ) || isdefined( level.ac130.owner ) && level.ac130.owner != var_0 )
            level.ac130.planemodel notify( "damage",  var_4, var_0, var_5, var_6, var_2, var_7, var_8, var_9, var_10, var_3  );
    }
}

_ID9784( var_0, var_1 )
{
    _ID9819( var_0, var_1, level.balldrones );
}

enablejammedeffect( var_0 )
{
    self setempjammed( var_0 );
    var_1 = 0;

    if ( var_0 )
        var_1 = 1;

    thread maps\mp\killstreaks\_unk1534::_ID31441();
}
