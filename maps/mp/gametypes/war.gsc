// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    if ( getdvar( "mapname" ) == "mp_background" )
        return;

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
        maps\mp\_utility::_ID25715( level._ID14086, 0, 0, 9 );
        maps\mp\_utility::_ID25718( level._ID14086, 10 );
        maps\mp\_utility::_ID25717( level._ID14086, 75 );
        maps\mp\_utility::_ID25714( level._ID14086, 1 );
        maps\mp\_utility::_ID25724( level._ID14086, 1 );
        maps\mp\_utility::_ID25712( level._ID14086, 0 );
        maps\mp\_utility::_ID25706( level._ID14086, 0 );
        level._ID20676 = 0;
        level._ID20680 = 0;
    }

    level._ID32653 = 1;
    level._ID22905 = ::_ID22905;
    level.getspawnpoint = ::getspawnpoint;
    level._ID22869 = ::_ID22869;

    if ( level._ID20676 || level._ID20680 )
        level._ID21286 = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    game["dialog"]["gametype"] = "tm_death";

    if ( getdvarint( "g_hardcore" ) )
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
    else if ( getdvarint( "camera_thirdPerson" ) )
        game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
    else if ( getdvarint( "scr_diehard" ) )
        game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
    else if ( getdvarint( "scr_" + level._ID14086 + "_promode" ) )
        game["dialog"]["gametype"] += "_pro";

    game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";
}

initializematchrules()
{
    maps\mp\_utility::_ID28682();
    setdynamicdvar( "scr_war_roundswitch", 0 );
    maps\mp\_utility::_ID25715( "war", 0, 0, 9 );
    setdynamicdvar( "scr_war_roundlimit", 1 );
    maps\mp\_utility::_ID25714( "war", 1 );
    setdynamicdvar( "scr_war_winlimit", 1 );
    maps\mp\_utility::_ID25724( "war", 1 );
    setdynamicdvar( "scr_war_halftime", 0 );
    maps\mp\_utility::_ID25706( "war", 0 );
    setdynamicdvar( "scr_war_promode", 0 );
}

_ID22905()
{
    setclientnamemode( "auto_change" );

    if ( !isdefined( game["switchedsides"] ) )
        game["switchedsides"] = 0;

    if ( game["switchedsides"] )
    {
        var_0 = game["attackers"];
        var_1 = game["defenders"];
        game["attackers"] = var_1;
        game["defenders"] = var_0;
    }

    maps\mp\_utility::_ID28804( "allies", &"OBJECTIVES_WAR" );
    maps\mp\_utility::_ID28804( "axis", &"OBJECTIVES_WAR" );

    if ( level.splitscreen )
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_WAR" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_WAR" );
    }
    else
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_WAR_SCORE" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_WAR_SCORE" );
    }

    maps\mp\_utility::setobjectivehinttext( "allies", &"OBJECTIVES_WAR_HINT" );
    maps\mp\_utility::setobjectivehinttext( "axis", &"OBJECTIVES_WAR_HINT" );
    initspawns();
    var_2[0] = level._ID14086;
    maps\mp\gametypes\_gameobjects::_ID20445( var_2 );
}

initspawns()
{
    level._ID30895 = ( 0, 0, 0 );
    level._ID30893 = ( 0, 0, 0 );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_tdm_spawn_allies_start" );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_tdm_spawn_axis_start" );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", "mp_tdm_spawn" );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", "mp_tdm_spawn" );
    level._ID20634 = maps\mp\gametypes\_spawnlogic::findboxcenter( level._ID30895, level._ID30893 );
    setmapcenter( level._ID20634 );
}

getspawnpoint()
{
    var_0 = self.pers["team"];

    if ( game["switchedsides"] )
        var_0 = maps\mp\_utility::getotherteam( var_0 );

    if ( maps\mp\gametypes\_spawnlogic::_ID38029() )
    {
        var_1 = maps\mp\gametypes\_spawnlogic::_ID15350( "mp_tdm_spawn_" + var_0 + "_start" );
        var_2 = maps\mp\gametypes\_spawnlogic::_ID15349( var_1 );
    }
    else
    {
        var_1 = maps\mp\gametypes\_spawnlogic::_ID15425( var_0 );
        var_2 = maps\mp\gametypes\_spawnscoring::_ID15345( var_1 );
    }

    return var_2;
}

_ID22869( var_0, var_1, var_2 )
{
    var_3 = maps\mp\gametypes\_rank::_ID15328( "score_increment" );
    level maps\mp\gametypes\_gamescore::giveteamscoreforobjective( var_1.pers["team"], var_3 );

    if ( game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level._ID23070[var_1.team]] )
        var_1._ID12872 = 1;
}

_ID22913()
{
    level.finalkillcam_winner = "none";

    if ( game["status"] == "overtime" )
        var_0 = "forfeit";
    else if ( game["teamScores"]["allies"] == game["teamScores"]["axis"] )
        var_0 = "overtime";
    else if ( game["teamScores"]["axis"] > game["teamScores"]["allies"] )
    {
        level.finalkillcam_winner = "axis";
        var_0 = "axis";
    }
    else
    {
        level.finalkillcam_winner = "allies";
        var_0 = "allies";
    }

    thread maps\mp\gametypes\_gamelogic::endgame( var_0, game["end_reason"]["time_limit_reached"] );
}
