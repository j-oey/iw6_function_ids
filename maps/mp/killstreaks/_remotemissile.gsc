// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID21198 = 14000;
    level._ID21196 = 7000;
    level._ID21197 = 1500;
    level._ID26359 = [];
    level._ID19256["predator_missile"] = ::_ID33863;
    level._ID25819["explode"] = loadfx( "fx/explosions/aerial_explosion" );
}

_ID33863( var_0, var_1 )
{
    maps\mp\_utility::_ID29199( "remotemissile" );
    var_2 = maps\mp\killstreaks\_killstreaks::_ID17993();

    if ( var_2 != "success" )
    {
        if ( var_2 != "disconnect" )
            maps\mp\_utility::_ID7513();

        return 0;
    }

    self setclientomnvar( "ui_predator_missile", 1 );
    level thread _fire( var_0, self );
    return 1;
}

getbestspawnpoint( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        var_3._ID34842 = [];
        var_3._ID30910 = 0;
    }

    foreach ( var_6 in level.players )
    {
        if ( !maps\mp\_utility::_ID18757( var_6 ) )
            continue;

        if ( var_6.team == self.team )
            continue;

        if ( var_6.team == "spectator" )
            continue;

        var_7 = 999999999;
        var_8 = undefined;

        foreach ( var_3 in var_0 )
        {
            var_3._ID34842[var_3._ID34842.size] = var_6;
            var_10 = distance2d( var_3._ID32605.origin, var_6.origin );

            if ( var_10 <= var_7 )
            {
                var_7 = var_10;
                var_8 = var_3;
            }
        }

        var_8._ID30910 = var_8._ID30910 + 2;
    }

    var_13 = var_0[0];

    foreach ( var_3 in var_0 )
    {
        foreach ( var_6 in var_3._ID34842 )
        {
            var_3._ID30910 = var_3._ID30910 + 1;

            if ( bullettracepassed( var_6.origin + ( 0, 0, 32 ), var_3.origin, 0, var_6 ) )
                var_3._ID30910 = var_3._ID30910 + 3;

            if ( var_3._ID30910 > var_13._ID30910 )
            {
                var_13 = var_3;
                continue;
            }

            if ( var_3._ID30910 == var_13._ID30910 )
            {
                if ( common_scripts\utility::_ID7657() )
                    var_13 = var_3;
            }
        }
    }

    return var_13;
}

_fire( var_0, var_1 )
{
    var_2 = getentarray( "remoteMissileSpawn", "targetname" );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4.target ) )
            var_4._ID32605 = getent( var_4.target, "targetname" );
    }

    if ( var_2.size > 0 )
        var_6 = var_1 getbestspawnpoint( var_2 );
    else
        var_6 = undefined;

    if ( isdefined( var_6 ) )
    {
        var_7 = var_6.origin;
        var_8 = var_6._ID32605.origin;
        var_9 = vectornormalize( var_7 - var_8 );
        var_7 = var_9 * 14000 + var_8;
        var_10 = magicbullet( "remotemissile_projectile_mp", var_7, var_8, var_1 );
    }
    else
    {
        var_11 = ( 0, 0, level._ID21198 );
        var_12 = level._ID21196;
        var_13 = level._ID21197;
        var_14 = anglestoforward( var_1.angles );
        var_7 = var_1.origin + var_11 + var_14 * var_12 * -1;
        var_8 = var_1.origin + var_14 * var_13;
        var_10 = magicbullet( "remotemissile_projectile_mp", var_7, var_8, var_1 );
    }

    if ( !isdefined( var_10 ) )
    {
        var_1 maps\mp\_utility::_ID7513();
        return;
    }

    var_10.team = var_1.team;
    var_10 thread _ID16244();
    var_10._ID19938 = var_0;
    var_10.type = "remote";
    level._ID25821 = 1;
    _ID21187( var_1, var_10 );
}

_ID16244()
{
    self endon( "death" );
    self endon( "deleted" );
    self setcandamage( 1 );

    for (;;)
        self waittill( "damage" );
}

_ID21187( var_0, var_1 )
{
    var_0 endon( "joined_team" );
    var_0 endon( "joined_spectators" );
    var_1 thread _ID26354();
    var_0 thread _ID23973( var_1 );
    var_0 thread _ID23974( var_1 );
    var_0 visionsetmissilecamforplayer( "black_bw", 0 );
    var_0 endon( "disconnect" );

    if ( isdefined( var_1 ) )
    {
        var_0 visionsetmissilecamforplayer( game["thermal_vision"], 1.0 );
        var_0 thermalvisionon();
        var_0 thread delayedfofoverlay();
        var_0 cameralinkto( var_1, "tag_origin" );
        var_0 controlslinkto( var_1 );

        if ( getdvarint( "camera_thirdPerson" ) )
            var_0 maps\mp\_utility::_ID28902( 0 );

        var_1 waittill( "death" );
        var_0 thermalvisionoff();

        if ( isdefined( var_1 ) )
            var_0 maps\mp\_matchdata::_ID20253( "predator_missile", var_1.origin );

        var_0 controlsunlink();
        var_0 maps\mp\_utility::_ID13582( 1 );

        if ( !level.gameended || isdefined( var_0._ID12872 ) )
            var_0 setclientomnvar( "ui_predator_missile", 2 );

        wait 0.5;
        var_0 thermalvisionfofoverlayoff();
        var_0 cameraunlink();

        if ( getdvarint( "camera_thirdPerson" ) )
            var_0 maps\mp\_utility::_ID28902( 1 );
    }

    var_0 setclientomnvar( "ui_predator_missile", 0 );
    var_0 maps\mp\_utility::_ID7513();
}

delayedfofoverlay()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait 0.15;
    self thermalvisionfofoverlayon();
}

_ID23974( var_0 )
{
    var_0 endon( "death" );
    self endon( "disconnect" );
    common_scripts\utility::_ID35626( "joined_team", "joined_spectators" );

    if ( self.team != "spectator" )
    {
        self thermalvisionfofoverlayoff();
        self controlsunlink();
        self cameraunlink();

        if ( getdvarint( "camera_thirdPerson" ) )
            maps\mp\_utility::_ID28902( 1 );
    }

    maps\mp\_utility::_ID7513();
    level._ID25821 = undefined;
}

_ID26354()
{
    var_0 = self getentitynumber();
    level._ID26359[var_0] = self;
    self waittill( "death" );
    level._ID26359[var_0] = undefined;
    level._ID25821 = undefined;
}

_ID23973( var_0 )
{
    var_0 endon( "death" );
    self endon( "death" );
    level waittill( "game_ended" );
    self thermalvisionfofoverlayoff();
    self controlsunlink();
    self cameraunlink();

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::_ID28902( 1 );
}
