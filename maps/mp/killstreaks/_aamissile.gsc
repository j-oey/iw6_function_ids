// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    precacheitem( "aamissile_projectile_mp" );
    precacheshader( "ac130_overlay_grain" );
    level.aamissilelaunchvert = 14000;
    level.aamissilelaunchhorz = 30000;
    level.aamissilelaunchtargetdist = 1500;
    level._ID26359 = [];
    level._ID19256["aamissile"] = ::_ID33828;
}

_ID33828( var_0, var_1 )
{
    maps\mp\_utility::_ID29199( "aamissile" );
    var_2 = maps\mp\killstreaks\_killstreaks::_ID17993();

    if ( var_2 != "success" )
    {
        if ( var_2 != "disconnect" )
            maps\mp\_utility::_ID7513();

        return 0;
    }

    level thread aa_missile_fire( var_0, self );
    return 1;
}

_ID15398()
{
    var_0 = [];
    var_1 = [];

    if ( isdefined( level._ID20086 ) && level._ID20086.size )
    {
        foreach ( var_3 in level._ID20086 )
        {
            if ( var_3.team != self.team )
                var_0[var_0.size] = var_3;
        }
    }

    if ( isdefined( level._ID16755 ) && level._ID16755.size )
    {
        foreach ( var_6 in level._ID16755 )
        {
            if ( var_6.team != self.team )
                var_1[var_1.size] = var_6;
        }
    }

    if ( isdefined( var_1 ) && var_1.size )
        return var_1[0];
    else if ( isdefined( var_0 ) && var_0.size )
        return var_0[0];
}

aa_missile_fire( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = ( 0, 0, level.aamissilelaunchvert );
    var_4 = level.aamissilelaunchhorz;
    var_5 = level.aammissilelaunchtargetdist;
    var_6 = var_1 _ID15398();

    if ( !isdefined( var_6 ) )
        var_7 = ( 0, 0, 0 );
    else
    {
        var_7 = var_6.origin;
        var_3 = ( 0, 0, 1 ) * var_7 + ( 0, 0, 1000 );
    }

    var_8 = anglestoforward( var_1.angles );
    var_9 = var_1.origin + var_3 + var_8 * var_4 * -1;
    var_10 = magicbullet( "aamissile_projectile_mp", var_9, var_7, var_1 );

    if ( !isdefined( var_10 ) )
    {
        var_1 maps\mp\_utility::_ID7513();
        return;
    }

    var_10._ID19938 = var_0;
    var_10.type = "remote";
    _ID21187( var_1, var_10 );
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
        var_0 thread delayedfofoverlay();
        var_0 cameralinkto( var_1, "tag_origin" );
        var_0 controlslinkto( var_1 );

        if ( getdvarint( "camera_thirdPerson" ) )
            var_0 maps\mp\_utility::_ID28902( 0 );

        var_1 waittill( "death" );

        if ( isdefined( var_1 ) )
            var_0 maps\mp\_matchdata::_ID20253( "predator_missile", var_1.origin );

        var_0 controlsunlink();
        var_0 maps\mp\_utility::_ID13582( 1 );

        if ( !level.gameended || isdefined( var_0._ID12872 ) )
            var_0 thread _ID31520( 0.5 );

        wait 0.5;
        var_0 thermalvisionfofoverlayoff();
        var_0 cameraunlink();

        if ( getdvarint( "camera_thirdPerson" ) )
            var_0 maps\mp\_utility::_ID28902( 1 );
    }

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

_ID31520( var_0 )
{
    self endon( "disconnect" );
    var_1 = newclienthudelem( self );
    var_1.horzalign = "fullscreen";
    var_1.vertalign = "fullscreen";
    var_1 setshader( "white", 640, 480 );
    var_1.archive = 1;
    var_1.sort = 10;
    var_2 = newclienthudelem( self );
    var_2.horzalign = "fullscreen";
    var_2.vertalign = "fullscreen";
    var_2 setshader( "ac130_overlay_grain", 640, 480 );
    var_2.archive = 1;
    var_2.sort = 20;
    wait(var_0);
    var_2 destroy();
    var_1 destroy();
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
