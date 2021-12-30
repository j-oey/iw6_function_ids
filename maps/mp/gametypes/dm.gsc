// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\gametypes\_globallogic::_ID17631();
    maps\mp\gametypes\_callbacksetup::_ID29168();
    maps\mp\gametypes\_globallogic::_ID29168();

    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = ::initializematchrules;
        [[ level.initializematchrules ]]();
        level thread maps\mp\_utility::_ID25726();
    }
    else
    {
        maps\mp\_utility::_ID25718( level._ID14086, 10 );
        maps\mp\_utility::_ID25717( level._ID14086, 30 );
        maps\mp\_utility::_ID25724( level._ID14086, 1 );
        maps\mp\_utility::_ID25714( level._ID14086, 1 );
        maps\mp\_utility::_ID25712( level._ID14086, 0 );
        maps\mp\_utility::_ID25706( level._ID14086, 0 );
        level._ID20676 = 0;
        level._ID20680 = 0;
    }

    level._ID22905 = ::_ID22905;
    level.getspawnpoint = ::getspawnpoint;
    level._ID22902 = ::_ID22902;
    level._ID22869 = ::_ID22869;
    level._ID22888 = ::_ID22888;
    level._ID3995 = 1;

    if ( level._ID20676 || level._ID20680 )
        level._ID21286 = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    setteammode( "ffa" );
    game["dialog"]["gametype"] = "freeforall";

    if ( getdvarint( "g_hardcore" ) )
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
    else if ( getdvarint( "camera_thirdPerson" ) )
        game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
    else if ( getdvarint( "scr_diehard" ) )
        game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
    else if ( getdvarint( "scr_" + level._ID14086 + "_promode" ) )
        game["dialog"]["gametype"] += "_pro";
}

initializematchrules()
{
    maps\mp\_utility::_ID28682( 1 );
    setdynamicdvar( "scr_dm_winlimit", 1 );
    maps\mp\_utility::_ID25724( "dm", 1 );
    setdynamicdvar( "scr_dm_roundlimit", 1 );
    maps\mp\_utility::_ID25714( "dm", 1 );
    setdynamicdvar( "scr_dm_halftime", 0 );
    maps\mp\_utility::_ID25706( "dm", 0 );
}

_ID22905()
{
    setclientnamemode( "auto_change" );
    maps\mp\_utility::_ID28804( "allies", &"OBJECTIVES_DM" );
    maps\mp\_utility::_ID28804( "axis", &"OBJECTIVES_DM" );

    if ( level.splitscreen )
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_DM" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_DM" );
    }
    else
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_DM_SCORE" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_DM_SCORE" );
    }

    maps\mp\_utility::setobjectivehinttext( "allies", &"OBJECTIVES_DM_HINT" );
    maps\mp\_utility::setobjectivehinttext( "axis", &"OBJECTIVES_DM_HINT" );
    level._ID30895 = ( 0, 0, 0 );
    level._ID30893 = ( 0, 0, 0 );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", "mp_dm_spawn" );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", "mp_dm_spawn" );
    level._ID20634 = maps\mp\gametypes\_spawnlogic::findboxcenter( level._ID30895, level._ID30893 );
    setmapcenter( level._ID20634 );
    var_0[0] = "dm";
    maps\mp\gametypes\_gameobjects::_ID20445( var_0 );
    level._ID25248 = 1;
}

getspawnpoint()
{
    var_0 = maps\mp\gametypes\_spawnlogic::_ID15425( self.team );

    if ( level._ID17628 )
        var_1 = maps\mp\gametypes\_spawnscoring::_ID37369( var_0 );
    else
        var_1 = maps\mp\gametypes\_spawnscoring::_ID15344( var_0 );

    return var_1;
}

_ID22902()
{
    level notify( "spawned_player" );

    if ( !isdefined( self._ID37185 ) )
    {
        self._ID37185 = maps\mp\gametypes\_rank::_ID15328( "kill" );
        maps\mp\_utility::setextrascore0( self._ID37185 );
    }
}

_ID22869( var_0, var_1, var_2 )
{
    var_3 = 0;

    foreach ( var_5 in level.players )
    {
        if ( isdefined( var_5.score ) && var_5.score > var_3 )
            var_3 = var_5.score;
    }

    if ( game["state"] == "postgame" && var_1.score >= var_3 )
        var_1._ID12872 = 1;
}

_ID22888( var_0, var_1, var_2 )
{
    var_1.assists = var_1 maps\mp\_utility::_ID15245( "longestStreak" );

    if ( var_0 == "kill" )
    {
        var_3 = maps\mp\gametypes\_rank::_ID15328( "score_increment" );
        return var_3;
    }

    return 0;
}
