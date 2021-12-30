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
        maps\mp\_utility::_ID25717( level._ID14086, 100 );
        maps\mp\_utility::_ID25714( level._ID14086, 1 );
        maps\mp\_utility::_ID25724( level._ID14086, 1 );
        maps\mp\_utility::_ID25712( level._ID14086, 0 );
        maps\mp\_utility::_ID25706( level._ID14086, 0 );
        level._ID20676 = 0;
        level._ID20680 = 0;
    }

    level._ID32653 = getdvarint( "scr_cranked_teambased", 1 ) == 1;
    level._ID22905 = ::_ID22905;
    level.getspawnpoint = ::getspawnpoint;
    level._ID22869 = ::_ID22869;
    level._ID22906 = ::_ID22906;
    level.onteamchangedeath = ::onteamchangedeath;

    if ( !level._ID32653 )
    {
        level._ID22888 = ::_ID22888;
        setdvar( "scr_cranked_scorelimit", getdvarint( "scr_cranked_scorelimit_ffa", 60 ) );
        setteammode( "ffa" );
    }

    if ( level._ID20676 || level._ID20680 )
        level._ID21286 = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    game["dialog"]["gametype"] = "cranked";

    if ( getdvarint( "g_hardcore" ) )
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
    else if ( getdvarint( "camera_thirdPerson" ) )
        game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
    else if ( getdvarint( "scr_diehard" ) )
        game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
    else if ( getdvarint( "scr_" + level._ID14086 + "_promode" ) )
        game["dialog"]["gametype"] += "_pro";

    game["dialog"]["offense_obj"] = "crnk_hint";
    game["dialog"]["begin_cranked"] = "crnk_cranked";
    game["dialog"]["five_seconds_left"] = "crnk_det";
    game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";
    level thread _ID22877();
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
        self waittill( "spawned_player" );
}

initializematchrules()
{
    maps\mp\_utility::_ID28682();
    setdynamicdvar( "scr_cranked_roundswitch", 0 );
    maps\mp\_utility::_ID25715( "cranked", 0, 0, 9 );
    setdynamicdvar( "scr_cranked_roundlimit", 1 );
    maps\mp\_utility::_ID25714( "cranked", 1 );
    setdynamicdvar( "scr_cranked_winlimit", 1 );
    maps\mp\_utility::_ID25724( "cranked", 1 );
    setdynamicdvar( "scr_cranked_halftime", 0 );
    maps\mp\_utility::_ID25706( "cranked", 0 );
    setdynamicdvar( "scr_cranked_promode", 0 );
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

    var_2 = &"OBJECTIVES_WAR";
    var_3 = &"OBJECTIVES_WAR_SCORE";
    var_4 = &"OBJECTIVES_WAR_HINT";

    if ( !level._ID32653 )
    {
        var_2 = &"OBJECTIVES_DM";
        var_3 = &"OBJECTIVES_DM_SCORE";
        var_4 = &"OBJECTIVES_DM_HINT";
    }

    maps\mp\_utility::_ID28804( "allies", var_2 );
    maps\mp\_utility::_ID28804( "axis", var_2 );

    if ( level.splitscreen )
    {
        maps\mp\_utility::_ID28803( "allies", var_2 );
        maps\mp\_utility::_ID28803( "axis", var_2 );
    }
    else
    {
        maps\mp\_utility::_ID28803( "allies", var_3 );
        maps\mp\_utility::_ID28803( "axis", var_3 );
    }

    maps\mp\_utility::setobjectivehinttext( "allies", var_4 );
    maps\mp\_utility::setobjectivehinttext( "axis", var_4 );
    initspawns();
    cranked();
    var_5[0] = level._ID14086;
    maps\mp\gametypes\_gameobjects::_ID20445( var_5 );
}

initspawns()
{
    level._ID30895 = ( 0, 0, 0 );
    level._ID30893 = ( 0, 0, 0 );

    if ( level._ID32653 )
    {
        maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_tdm_spawn_allies_start" );
        maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_tdm_spawn_axis_start" );
        maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", "mp_tdm_spawn" );
        maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", "mp_tdm_spawn" );
    }
    else
    {
        maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", "mp_dm_spawn" );
        maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", "mp_dm_spawn" );
    }

    level._ID20634 = maps\mp\gametypes\_spawnlogic::findboxcenter( level._ID30895, level._ID30893 );
    setmapcenter( level._ID20634 );
}

getspawnpoint()
{
    if ( level._ID32653 )
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
    }
    else
    {
        var_1 = maps\mp\gametypes\_spawnlogic::_ID15425( self.team );

        if ( level._ID17628 )
            var_2 = maps\mp\gametypes\_spawnlogic::_ID15346( var_1 );
        else
            var_2 = maps\mp\gametypes\_spawnscoring::_ID15344( var_1 );
    }

    return var_2;
}

_ID22869( var_0, var_1, var_2 )
{
    if ( isdefined( var_0.cranked ) && var_1 maps\mp\_utility::isenemy( var_0 ) )
        var_1 maps\mp\gametypes\_missions::_ID25038( "ch_cranky" );

    var_0 _ID36968();
    var_3 = maps\mp\gametypes\_rank::_ID15328( "score_increment" );

    if ( isdefined( var_1.cranked ) )
    {
        if ( var_1.cranked_end_time - gettime() <= 1000 )
            var_1 maps\mp\gametypes\_missions::_ID25038( "ch_cranked_reset" );

        var_3 *= 2;
        var_4 = "kill_cranked";
        var_1 thread onkill( var_4 );
        var_1.pers["killChains"]++;
        var_1 maps\mp\gametypes\_persistence::_ID31528( "round", "killChains", var_1.pers["killChains"] );
    }
    else if ( maps\mp\_utility::_ID18757( var_1 ) )
        var_1 _ID20498( "begin_cranked" );

    if ( isdefined( var_0.attackers ) && !isdefined( level._ID3995 ) )
    {
        foreach ( var_6 in var_0.attackers )
        {
            if ( !isdefined( maps\mp\_utility::_validateattacker( var_6 ) ) )
                continue;

            if ( var_6 == var_1 )
                continue;

            if ( var_0 == var_6 )
                continue;

            if ( !isdefined( var_6.cranked ) )
                continue;

            var_6 thread _ID22772( "assist_cranked" );
        }
    }

    if ( level._ID32653 )
    {
        level maps\mp\gametypes\_gamescore::giveteamscoreforobjective( var_1.pers["team"], var_3 );

        if ( game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level._ID23070[var_1.team]] )
            var_1._ID12872 = 1;
    }
    else
    {
        var_8 = 0;

        foreach ( var_6 in level.players )
        {
            if ( isdefined( var_6.score ) && var_6.score > var_8 )
                var_8 = var_6.score;
        }

        if ( game["state"] == "postgame" && var_1.score >= var_8 )
            var_1._ID12872 = 1;
    }
}

_ID22906( var_0 )
{
    var_0 _ID36968();
}

onteamchangedeath( var_0 )
{
    var_0 _ID36968();
}

_ID36968()
{
    self setclientomnvar( "ui_cranked_bomb_timer_end_milliseconds", 0 );
    self.cranked = undefined;
    self.cranked_end_time = undefined;
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

_ID22888( var_0, var_1, var_2 )
{
    if ( var_0 == "kill" )
    {
        var_3 = maps\mp\gametypes\_rank::_ID15328( "score_increment" );

        if ( isdefined( var_1.cranked ) )
            var_3 *= 2;

        return var_3;
    }

    return 0;
}

cranked()
{
    level.crankedbombtimer = 30;
}

_ID20498( var_0 )
{
    maps\mp\_utility::_ID19765( var_0 );
    thread maps\mp\gametypes\_rank::_ID36462( var_0 );
    _ID28685( "kill" );
    self.cranked = 1;
    maps\mp\_utility::_ID15611( "specialty_fastreload", 0 );
    maps\mp\_utility::_ID15611( "specialty_quickdraw", 0 );
    maps\mp\_utility::_ID15611( "specialty_fastoffhand", 0 );
    maps\mp\_utility::_ID15611( "specialty_fastsprintrecovery", 0 );
    maps\mp\_utility::_ID15611( "specialty_marathon", 0 );
    maps\mp\_utility::_ID15611( "specialty_quickswap", 0 );
    maps\mp\_utility::_ID15611( "specialty_stalker", 0 );
    self._ID21667 = 1.2;
    maps\mp\gametypes\_weapons::_ID34567();
}

onkill( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    while ( !isdefined( self.pers ) )
        wait 0.05;

    thread maps\mp\gametypes\_rank::_ID36462( var_0 );
    maps\mp\gametypes\_gamescore::_ID15616( var_0, self, undefined, 1 );
    thread maps\mp\gametypes\_rank::giverankxp( var_0 );
    _ID28685( "kill" );
}

_ID22772( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    thread maps\mp\gametypes\_rank::_ID36462( var_0 );
    _ID28685( "assist" );
}

_ID36043( var_0 )
{
    self notify( "watchBombTimer" );
    self endon( "watchBombTimer" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_1 = 5;
    maps\mp\gametypes\_hostmigration::_ID35596( var_0 - var_1 - 1 );
    maps\mp\_utility::_ID19765( "five_seconds_left" );
    maps\mp\gametypes\_hostmigration::_ID35596( 1.0 );
    self setclientomnvar( "ui_cranked_bomb_timer_final_seconds", 1 );

    while ( var_1 > 0 )
    {
        self playsoundtoplayer( "mp_cranked_countdown", self );
        maps\mp\gametypes\_hostmigration::_ID35596( 1.0 );
        var_1--;
    }

    if ( isdefined( self ) && maps\mp\_utility::_ID18757( self ) )
    {
        self playsound( "grenade_explode_metal" );
        playfx( level.mine_explode, self.origin + ( 0, 0, 32 ) );
        maps\mp\_utility::_suicide();
        self setclientomnvar( "ui_cranked_bomb_timer_end_milliseconds", 0 );
    }
}

_ID28685( var_0 )
{
    var_1 = level.crankedbombtimer;

    if ( var_0 == "assist" )
        var_1 = int( min( ( self.cranked_end_time - gettime() ) / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer ) );

    var_2 = var_1 * 1000 + gettime();
    self setclientomnvar( "ui_cranked_bomb_timer_end_milliseconds", var_2 );
    self.cranked_end_time = var_2;
    thread _ID38292();
    thread _ID36043( var_1 );
    thread _ID36065();
}

_ID38292()
{
    self notify( "watchCrankedHostMigration" );
    self endon( "watchCrankedHostMigration" );
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    level waittill( "host_migration_begin" );
    var_0 = maps\mp\gametypes\_hostmigration::_ID35770();

    if ( self.cranked_end_time + var_0 < 5 )
        self setclientomnvar( "ui_cranked_bomb_timer_final_seconds", 1 );

    if ( var_0 > 0 )
        self setclientomnvar( "ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time + var_0 );
    else
        self setclientomnvar( "ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time );
}

_ID36065()
{
    self notify( "watchEndGame" );
    self endon( "watchEndGame" );
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        if ( game["state"] == "postgame" || level.gameended )
        {
            self setclientomnvar( "ui_cranked_bomb_timer_end_milliseconds", 0 );
            break;
        }

        wait 0.1;
    }
}
