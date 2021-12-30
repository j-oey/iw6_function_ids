// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID7654()
{
    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
        level waittill( "eternity" );

    if ( !isdefined( level._ID14087 ) || !level._ID14087 )
    {
        [[ level.callbackstartgametype ]]();
        level._ID14087 = 1;
    }
}

codecallback_playerconnect()
{
    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
        level waittill( "eternity" );

    self endon( "disconnect" );
    [[ level._ID6484 ]]();
}

_ID7650( var_0 )
{
    self notify( "disconnect" );
    [[ level.callbackplayerdisconnect ]]( var_0 );
}

codecallback_playerdamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    self endon( "disconnect" );
    var_5 = maps\mp\_utility::_ID36268( var_5 );
    [[ level.callbackplayerdamage ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

codecallback_playerkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self endon( "disconnect" );
    var_4 = maps\mp\_utility::_ID36268( var_4 );
    [[ level.callbackplayerkilled ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
}

codecallback_vehicledamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    var_5 = maps\mp\_utility::_ID36268( var_5 );

    if ( isdefined( self.damagecallback ) )
        self [[ self.damagecallback ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );
    else
        self vehicle_finishdamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );
}

codecallback_codeendgame()
{
    self endon( "disconnect" );
    [[ level._ID6482 ]]();
}

codecallback_playerlaststand( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self endon( "disconnect" );
    var_4 = maps\mp\_utility::_ID36268( var_4 );
    [[ level.callbackplayerlaststand ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
}

codecallback_playermigrated()
{
    self endon( "disconnect" );
    [[ level.callbackplayermigrated ]]();
}

codecallback_hostmigration()
{
    [[ level.callbackhostmigration ]]();
}

setupdamageflags()
{
    level._ID17344 = 1;
    level._ID17338 = 2;
    level.idflags_no_knockback = 4;
    level.idflags_penetration = 8;
    level._ID17348 = 16;
    level._ID17345 = 32;
    level.idflags_shield_explosive_impact_huge = 64;
    level._ID17347 = 128;
    level._ID17341 = 256;
    level._ID17340 = 512;
    level._ID17342 = 1024;
}

_ID29168()
{
    _ID28693();
    setupdamageflags();
}

_ID28693()
{
    level.callbackstartgametype = maps\mp\gametypes\_gamelogic::callback_startgametype;
    level._ID6484 = maps\mp\gametypes\_playerlogic::callback_playerconnect;
    level.callbackplayerdisconnect = maps\mp\gametypes\_playerlogic::_ID6474;
    level.callbackplayerdamage = maps\mp\gametypes\_damage::callback_playerdamage;
    level.callbackplayerkilled = maps\mp\gametypes\_damage::_ID6475;
    level._ID6482 = maps\mp\gametypes\_gamelogic::_ID6468;
    level.callbackplayerlaststand = maps\mp\gametypes\_damage::callback_playerlaststand;
    level.callbackplayermigrated = maps\mp\gametypes\_playerlogic::callback_playermigrated;
    level.callbackhostmigration = maps\mp\gametypes\_hostmigration::_ID6469;
}

abortlevel()
{
    level.callbackstartgametype = ::_ID6492;
    level._ID6484 = ::_ID6492;
    level.callbackplayerdisconnect = ::_ID6492;
    level.callbackplayerdamage = ::_ID6492;
    level.callbackplayerkilled = ::_ID6492;
    level._ID6482 = ::_ID6492;
    level.callbackplayerlaststand = ::_ID6492;
    level.callbackplayermigrated = ::_ID6492;
    level.callbackhostmigration = ::_ID6492;
    setdvar( "g_gametype", "dm" );
    exitlevel( 0 );
}

_ID6492()
{

}
