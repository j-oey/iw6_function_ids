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
        maps\mp\_utility::_ID25718( level._ID14086, 30 );
        maps\mp\_utility::_ID25717( level._ID14086, 300 );
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
    level._ID22886 = ::_ID22886;
    level._ID17937 = ::_ID17937;
    level._ID22902 = ::_ID22902;
    level.lastcaptime = gettime();
    level.alliescapturing = [];
    level._ID4604 = [];

    if ( level._ID20676 || level._ID20680 )
        level._ID21286 = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    game["dialog"]["gametype"] = "domination";

    if ( getdvarint( "g_hardcore" ) )
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
    else if ( getdvarint( "camera_thirdPerson" ) )
        game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
    else if ( getdvarint( "scr_diehard" ) )
        game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
    else if ( getdvarint( "scr_" + level._ID14086 + "_promode" ) )
        game["dialog"]["gametype"] += "_pro";

    game["dialog"]["offense_obj"] = "capture_objs";
    game["dialog"]["defense_obj"] = "capture_objs";
    thread _ID22877();
}

initializematchrules()
{
    maps\mp\_utility::_ID28682();

    if ( getdvarint( "scr_playlist_type", 0 ) == 1 || maps\mp\_utility::_ID37547() )
    {
        setdynamicdvar( "scr_dom_roundswitch", 1 );
        maps\mp\_utility::_ID25715( "dom", 1, 0, 1 );
        setdynamicdvar( "scr_dom_roundlimit", 2 );
        maps\mp\_utility::_ID25714( "dom", 2 );
        setdynamicdvar( "scr_dom_winlimit", 0 );
        maps\mp\_utility::_ID25724( "dom", 0 );
    }
    else
    {
        setdynamicdvar( "scr_dom_roundlimit", 1 );
        maps\mp\_utility::_ID25714( "dom", 1 );
        setdynamicdvar( "scr_dom_winlimit", 1 );
        maps\mp\_utility::_ID25724( "dom", 1 );
    }

    setdynamicdvar( "scr_dom_halftime", 0 );
    maps\mp\_utility::_ID25706( "dom", 0 );
    setdynamicdvar( "scr_dom_promode", 0 );
}

_ID22905()
{
    maps\mp\_utility::_ID28804( "allies", &"OBJECTIVES_DOM" );
    maps\mp\_utility::_ID28804( "axis", &"OBJECTIVES_DOM" );

    if ( level.splitscreen )
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_DOM" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_DOM" );
    }
    else
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_DOM_SCORE" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_DOM_SCORE" );
    }

    maps\mp\_utility::setobjectivehinttext( "allies", &"OBJECTIVES_DOM_HINT" );
    maps\mp\_utility::setobjectivehinttext( "axis", &"OBJECTIVES_DOM_HINT" );
    setclientnamemode( "auto_change" );

    if ( !isdefined( game["switchedsides"] ) )
        game["switchedsides"] = 0;

    level.flagbasefxid["neutral"] = loadfx( "vfx/gameplay/mp/core/vfx_marker_base_grey" );
    level.flagbasefxid["friendly"] = loadfx( "vfx/gameplay/mp/core/vfx_marker_base_cyan" );
    level.flagbasefxid["enemy"] = loadfx( "vfx/gameplay/mp/core/vfx_marker_base_orange" );
    initspawns();
    var_0[0] = "dom";
    maps\mp\gametypes\_gameobjects::_ID20445( var_0 );
    thread _ID10614();
    thread _ID34532();
}

initspawns()
{
    level._ID30895 = ( 0, 0, 0 );
    level._ID30893 = ( 0, 0, 0 );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_dom_spawn_allies_start" );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_dom_spawn_axis_start" );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", "mp_dom_spawn" );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", "mp_dom_spawn" );
    level._ID20634 = maps\mp\gametypes\_spawnlogic::findboxcenter( level._ID30895, level._ID30893 );
    setmapcenter( level._ID20634 );
}

getspawnpoint()
{
    var_0 = self.pers["team"];
    var_1 = maps\mp\_utility::getotherteam( var_0 );

    if ( level._ID34773 )
    {
        if ( game["switchedsides"] )
        {
            var_2 = maps\mp\gametypes\_spawnlogic::_ID15350( "mp_dom_spawn_" + var_1 + "_start" );
            var_3 = maps\mp\gametypes\_spawnlogic::_ID15349( var_2 );
        }
        else
        {
            var_2 = maps\mp\gametypes\_spawnlogic::_ID15350( "mp_dom_spawn_" + var_0 + "_start" );
            var_3 = maps\mp\gametypes\_spawnlogic::_ID15349( var_2 );
        }
    }
    else
    {
        var_4 = _ID15408( var_0 );
        var_5 = maps\mp\_utility::getotherteam( var_0 );
        var_6 = _ID15408( var_5 );
        var_7 = _ID15237( var_4, var_6 );
        var_2 = maps\mp\gametypes\_spawnlogic::_ID15425( var_0 );
        var_3 = maps\mp\gametypes\_spawnscoring::getspawnpoint_domination( var_2, var_7 );
    }

    return var_3;
}

_ID15408( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level._ID10614 )
    {
        if ( var_3._ID23192 == var_0 )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

_ID15237( var_0, var_1 )
{
    var_2 = [];
    var_2[0] = 0;
    var_2[1] = 0;
    var_2[2] = 0;
    var_3 = self.pers["team"];

    if ( var_0.size == level._ID10614.size )
    {
        var_4 = var_3;
        var_5 = level.bestspawnflag[var_3];
        var_2[var_5._ID34757.dompointnumber] = 1;
        return var_2;
    }

    if ( var_0.size == 1 && var_1.size == 2 && !maps\mp\_utility::isanymlgmatch() )
    {
        var_6 = maps\mp\_utility::getotherteam( self.team );
        var_7 = maps\mp\gametypes\_gamescore::_ID1699( var_6 ) - maps\mp\gametypes\_gamescore::_ID1699( self.team );

        if ( var_7 > 15 )
        {
            var_8 = gettimesincedompointcapture( var_0[0] );
            var_9 = gettimesincedompointcapture( var_1[0] );
            var_10 = gettimesincedompointcapture( var_1[1] );

            if ( var_8 > 40000 && var_9 > 40000 && var_10 > 40000 )
                return var_2;
        }
    }

    if ( var_0.size > 0 )
    {
        foreach ( var_12 in var_0 )
            var_2[var_12.dompointnumber] = 1;

        return var_2;
    }

    if ( var_0.size == 0 )
    {
        var_4 = var_3;
        var_5 = level.bestspawnflag[var_4];

        if ( var_1.size > 0 && var_1.size < level._ID10614.size )
        {
            var_5 = _ID15453( var_4 );
            level.bestspawnflag[var_4] = var_5;
        }

        var_2[var_5._ID34757.dompointnumber] = 1;
        return var_2;
    }

    return var_2;
}

gettimesincedompointcapture( var_0 )
{
    return gettime() - var_0._ID6697;
}

_ID10614()
{
    level._ID19647["allies"] = 0;
    level._ID19647["axis"] = 0;
    game["flagmodels"] = [];
    game["flagmodels"]["neutral"] = "prop_flag_neutral";
    game["flagmodels"]["allies"] = maps\mp\gametypes\_teams::getteamflagmodel( "allies" );
    game["flagmodels"]["axis"] = maps\mp\gametypes\_teams::getteamflagmodel( "axis" );
    var_0 = getentarray( "flag_primary", "targetname" );
    var_1 = getentarray( "flag_secondary", "targetname" );

    if ( var_0.size + var_1.size < 2 )
        return;

    level._ID13222 = [];

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
        level._ID13222[level._ID13222.size] = var_0[var_2];

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        level._ID13222[level._ID13222.size] = var_1[var_2];

    level._ID10614 = [];

    for ( var_2 = 0; var_2 < level._ID13222.size; var_2++ )
    {
        var_3 = level._ID13222[var_2];

        if ( isdefined( var_3.target ) )
            var_4[0] = getent( var_3.target, "targetname" );
        else
        {
            var_4[0] = spawn( "script_model", var_3.origin );
            var_4[0].angles = var_3.angles;
        }

        var_5 = maps\mp\gametypes\_gameobjects::_ID8493( "neutral", var_3, var_4, ( 0, 0, 100 ) );
        var_5 maps\mp\gametypes\_gameobjects::allowuse( "enemy" );
        var_5 maps\mp\gametypes\_gameobjects::_ID29198( 10 );
        var_5 maps\mp\gametypes\_gameobjects::_ID29197( &"MP_SECURING_POSITION" );
        var_6 = var_5 maps\mp\gametypes\_gameobjects::_ID15110();
        var_5.label = var_6;
        var_5 maps\mp\gametypes\_gameobjects::_ID28180( "friendly", "waypoint_defend" + var_6 );
        var_5 maps\mp\gametypes\_gameobjects::_ID28181( "friendly", "waypoint_defend" + var_6 );
        var_5 maps\mp\gametypes\_gameobjects::_ID28180( "enemy", "waypoint_captureneutral" + var_6 );
        var_5 maps\mp\gametypes\_gameobjects::_ID28181( "enemy", "waypoint_captureneutral" + var_6 );
        var_5 maps\mp\gametypes\_gameobjects::_ID29202( "any" );
        var_5._ID22916 = ::_ID22916;
        var_5._ID22779 = ::_ID22779;
        var_5._ID22922 = ::_ID22922;
        var_5._ID22816 = ::_ID22816;
        var_5._ID22331 = 1;
        var_5._ID17334 = "domFlag";
        var_5.firstcapture = 1;
        var_7 = var_4[0].origin + ( 0, 0, 32 );
        var_8 = var_4[0].origin + ( 0, 0, -32 );
        var_9 = bullettrace( var_7, var_8, 0, undefined );
        var_5.baseeffectpos = var_9["position"];
        var_10 = vectortoangles( var_9["normal"] );
        var_5.baseeffectforward = anglestoforward( var_10 );
        var_5 thread _ID28725();
        level._ID13222[var_2]._ID34757 = var_5;
        var_5.levelflag = level._ID13222[var_2];
        level._ID10614[level._ID10614.size] = var_5;
    }

    var_11 = maps\mp\gametypes\_spawnlogic::_ID15350( "mp_dom_spawn_axis_start" );
    var_12 = maps\mp\gametypes\_spawnlogic::_ID15350( "mp_dom_spawn_allies_start" );
    level._ID31469["allies"] = var_12[0].origin;
    level._ID31469["axis"] = var_11[0].origin;
    level.bestspawnflag = [];
    level.bestspawnflag["allies"] = _ID15453( "allies", undefined );
    level.bestspawnflag["axis"] = _ID15453( "axis", level.bestspawnflag["allies"] );
    _ID13224();
}

_ID15453( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = undefined;

    for ( var_4 = 0; var_4 < level._ID13222.size; var_4++ )
    {
        var_5 = level._ID13222[var_4];

        if ( var_5 _ID15019() != "neutral" )
            continue;

        var_6 = distancesquared( var_5.origin, level._ID31469[var_0] );

        if ( ( !isdefined( var_1 ) || var_5 != var_1 ) && ( !isdefined( var_2 ) || var_6 < var_3 ) )
        {
            var_3 = var_6;
            var_2 = var_5;
        }
    }

    return var_2;
}

_ID22779( var_0 )
{
    var_1 = maps\mp\gametypes\_gameobjects::_ID15224();
    self._ID10016 = 0;

    if ( var_1 == "neutral" )
    {
        _ID31531( "securing" + self.label, var_0.team );

        if ( !self.firstcapture )
        {
            if ( self.curprogress == 0 )
                maps\mp\gametypes\_gameobjects::_ID29198( 5.0 );
        }
    }
    else
    {
        maps\mp\gametypes\_gameobjects::_ID29198( 10 );

        if ( var_1 == "allies" )
        {
            level.alliescapturing[level.alliescapturing.size] = self.label;
            var_2 = "axis";
            return;
        }

        level._ID4604[level._ID4604.size] = self.label;
        var_2 = "allies";
    }
}

_ID22922( var_0, var_1, var_2 )
{
    var_3 = maps\mp\gametypes\_gameobjects::_ID15224();

    if ( var_1 > 0.05 && var_2 && !self._ID10016 )
    {
        if ( var_3 == "neutral" )
        {
            _ID31531( "securing" + self.label, var_0 );
            self._ID24948 = maps\mp\_utility::getotherteam( var_0 );
        }
        else
        {
            _ID31531( "losing" + self.label, var_3, 1 );
            _ID31531( "securing" + self.label, var_0 );
        }

        maps\mp\gametypes\_gameobjects::_ID28180( "enemy", "waypoint_taking" + self.label );
        maps\mp\gametypes\_gameobjects::_ID28181( "enemy", "waypoint_taking" + self.label );
        maps\mp\gametypes\_gameobjects::_ID28180( "friendly", "waypoint_losing" + self.label );
        maps\mp\gametypes\_gameobjects::_ID28181( "friendly", "waypoint_losing" + self.label );
        self._ID10016 = 1;
    }
    else if ( var_1 > 0.49 && var_2 && self._ID10016 && var_3 != "neutral" )
    {
        thread _ID28725();
        _ID31531( "lost" + self.label, var_3, 1 );
        maps\mp\_utility::_ID24645( "mp_dom_flag_lost", var_3 );
        level.lastcaptime = gettime();
        thread giveflagassistedcapturepoints( self._ID33167[var_0] );
    }
}

giveflagassistedcapturepoints( var_0 )
{
    level endon( "game_ended" );
    var_1 = getarraykeys( var_0 );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_3 = var_0[var_1[var_2]].player;

        if ( !isdefined( var_3 ) )
            continue;

        if ( isdefined( var_3.owner ) )
            var_3 = var_3.owner;

        if ( !isplayer( var_3 ) )
            continue;

        var_3 maps\mp\_events::giveobjectivepointstreaks();
        wait 0.05;
    }
}

_ID31531( var_0, var_1, var_2 )
{
    var_3 = gettime();

    if ( gettime() < level._ID19647[var_1] + 5000 && ( !isdefined( var_2 ) || !var_2 ) )
        return;

    thread _ID9510( var_0, var_1 );
    level._ID19647[var_1] = gettime();
}

_ID22816( var_0, var_1, var_2 )
{
    if ( isplayer( var_1 ) )
    {
        var_1 setclientomnvar( "ui_dom_securing", 0 );
        var_1.ui_dom_securing = undefined;
    }

    var_3 = maps\mp\gametypes\_gameobjects::_ID15224();

    if ( var_3 != "neutral" )
    {
        maps\mp\gametypes\_gameobjects::_ID28180( "enemy", "waypoint_capture" + self.label );
        maps\mp\gametypes\_gameobjects::_ID28181( "enemy", "waypoint_capture" + self.label );
        maps\mp\gametypes\_gameobjects::_ID28180( "friendly", "waypoint_defend" + self.label );
        maps\mp\gametypes\_gameobjects::_ID28181( "friendly", "waypoint_defend" + self.label );
    }
    else
    {
        maps\mp\gametypes\_gameobjects::_ID28180( "enemy", "waypoint_captureneutral" + self.label );
        maps\mp\gametypes\_gameobjects::_ID28181( "enemy", "waypoint_captureneutral" + self.label );
        maps\mp\gametypes\_gameobjects::_ID28180( "friendly", "waypoint_captureneutral" + self.label );
        maps\mp\gametypes\_gameobjects::_ID28181( "friendly", "waypoint_captureneutral" + self.label );
    }

    if ( var_0 == "allies" )
        common_scripts\utility::array_remove( level.alliescapturing, self.label );
    else
        common_scripts\utility::array_remove( level._ID4604, self.label );
}

_ID26122()
{
    var_0 = maps\mp\gametypes\_gameobjects::_ID15224();

    if ( var_0 == "neutral" )
        _ID24581();
    else
    {
        foreach ( var_2 in level.players )
            showcapturedbaseeffecttoplayer( var_0, var_2 );
    }
}

_ID22916( var_0 )
{
    var_1 = var_0.team;
    var_2 = maps\mp\gametypes\_gameobjects::_ID15224();
    self._ID6697 = gettime();
    self.firstcapture = 0;
    _ID28724( var_1 );
    level._ID34773 = 0;

    if ( var_2 == "neutral" )
    {
        var_3 = maps\mp\_utility::getotherteam( var_1 );
        thread maps\mp\_utility::_ID24993( var_1, var_3, undefined, undefined, "mp_dom_flag_captured", undefined, var_0 );

        if ( _ID15411( var_1 ) < level._ID13222.size )
        {
            _ID31531( "secured" + self.label, var_1, 1 );
            _ID31531( "enemy_has" + self.label, var_3, 1 );
        }
        else
        {
            _ID31531( "secure_all", var_1 );
            _ID31531( "lost_all", var_3 );

            foreach ( var_5 in level.players )
            {
                if ( var_5.team == var_1 )
                    var_5 maps\mp\gametypes\_missions::_ID25038( "ch_domdom" );
            }
        }
    }

    var_0 maps\mp\_events::giveobjectivepointstreaks();
    thread giveflagcapturexp( self._ID33167[var_1] );
}

giveflagcapturexp( var_0 )
{
    level endon( "game_ended" );
    var_1 = maps\mp\gametypes\_gameobjects::getearliestclaimplayer();

    if ( isdefined( var_1.owner ) )
        var_1 = var_1.owner;

    level.lastcaptime = gettime();

    if ( isplayer( var_1 ) )
    {
        level thread maps\mp\_utility::_ID32672( "callout_securedposition" + self.label, var_1 );
        var_1 thread maps\mp\_matchdata::loggameevent( "capture", var_1.origin );
    }

    var_2 = getarraykeys( var_0 );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = var_0[var_2[var_3]].player;

        if ( isdefined( var_4.owner ) )
            var_4 = var_4.owner;

        if ( !isplayer( var_4 ) )
            continue;

        var_4 thread maps\mp\gametypes\_hud_message::_ID31052( "capture", maps\mp\gametypes\_rank::_ID15328( "capture" ) );
        var_4 thread _ID34527();
        var_4 thread maps\mp\gametypes\_rank::giverankxp( "capture", maps\mp\gametypes\_rank::_ID15328( "capture" ) * var_4 getcapxpscale() );
        maps\mp\gametypes\_gamescore::_ID15616( "capture", var_4 );
        var_4 maps\mp\_utility::_ID17531( "pointscaptured", 1 );
        var_4 maps\mp\_utility::_ID17529( "captures", 1 );
        var_4 maps\mp\gametypes\_persistence::_ID31528( "round", "captures", var_4.pers["captures"] );
        var_4 maps\mp\gametypes\_missions::_ID25038( "ch_domcap" );
        var_4 maps\mp\_utility::setextrascore0( var_4.pers["captures"] );

        if ( var_4 != var_1 )
            var_4 maps\mp\_events::giveobjectivepointstreaks();

        wait 0.05;
    }
}

_ID9510( var_0, var_1 )
{
    level endon( "game_ended" );
    wait 0.1;
    maps\mp\_utility::_ID35777();
    maps\mp\_utility::_ID19760( var_0, var_1 );
}

_ID34532()
{
    level endon( "game_ended" );

    while ( !level.gameended )
    {
        var_0 = _ID15223();

        if ( var_0.size )
        {
            for ( var_1 = 1; var_1 < var_0.size; var_1++ )
            {
                var_2 = var_0[var_1];
                var_3 = gettime() - var_2._ID6697;

                for ( var_4 = var_1 - 1; var_4 >= 0 && var_3 > gettime() - var_0[var_4]._ID6697; var_4-- )
                    var_0[var_4 + 1] = var_0[var_4];

                var_0[var_4 + 1] = var_2;
            }

            foreach ( var_2 in var_0 )
            {
                var_6 = var_2 maps\mp\gametypes\_gameobjects::_ID15224();
                maps\mp\gametypes\_gamescore::giveteamscoreforobjective( var_6, 1 );
            }
        }

        var_8 = gettime() - level.lastcaptime;

        if ( maps\mp\_utility::_ID20673() && var_0.size < 2 && var_8 > 120000 )
        {
            level.finalkillcam_winner = "none";
            thread maps\mp\gametypes\_gamelogic::endgame( "none", game["end_reason"]["time_limit_reached"] );
            return;
        }

        wait 5.0;
        maps\mp\gametypes\_hostmigration::_ID35770();
    }
}

_ID22886( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isplayer( var_1 ) || var_1.team == self.team )
        return;

    var_10 = 0;
    var_11 = 0;
    var_12 = self;

    foreach ( var_14 in var_12._ID33168 )
    {
        if ( var_14 != level._ID13222[0] && var_14 != level._ID13222[1] && var_14 != level._ID13222[2] )
            continue;

        var_15 = var_14._ID34757._ID23192;
        var_16 = var_12.team;

        if ( var_15 == "neutral" )
            continue;

        if ( var_16 == var_15 )
        {
            var_10 = 1;
            var_1 thread maps\mp\gametypes\_hud_message::_ID31052( "assault", maps\mp\gametypes\_rank::_ID15328( "assault" ) );
            var_1 thread maps\mp\gametypes\_rank::giverankxp( "assault" );
            maps\mp\gametypes\_gamescore::_ID15616( "assault", var_1 );
            thread maps\mp\_matchdata::_ID20250( var_9, "defending" );
            continue;
        }

        var_11 = 1;
        var_1 thread maps\mp\gametypes\_hud_message::_ID31052( "defend", maps\mp\gametypes\_rank::_ID15328( "defend" ) );
        var_1 thread maps\mp\gametypes\_rank::giverankxp( "defend" );
        maps\mp\gametypes\_gamescore::_ID15616( "defend", var_1 );
        var_1 maps\mp\_utility::_ID17529( "defends", 1 );
        var_1 maps\mp\gametypes\_persistence::_ID31528( "round", "defends", var_1.pers["defends"] );
        var_1 maps\mp\gametypes\_missions::_ID25038( "ch_domprotector" );
        thread maps\mp\_matchdata::_ID20250( var_9, "assaulting" );
    }

    foreach ( var_14 in var_1._ID33168 )
    {
        if ( var_14 != level._ID13222[0] && var_14 != level._ID13222[1] && var_14 != level._ID13222[2] )
            continue;

        var_15 = var_14._ID34757._ID23192;
        var_19 = var_1.team;

        if ( var_15 == "neutral" )
            continue;

        if ( var_19 != var_15 )
        {
            if ( !var_10 )
                var_1 thread maps\mp\gametypes\_hud_message::_ID31052( "assault", maps\mp\gametypes\_rank::_ID15328( "assault" ) );

            var_1 thread maps\mp\gametypes\_rank::giverankxp( "assault" );
            maps\mp\gametypes\_gamescore::_ID15616( "assault", var_1 );
            thread maps\mp\_matchdata::_ID20250( var_9, "defending" );
        }
    }

    foreach ( var_14 in level._ID13222 )
    {
        var_15 = var_14._ID34757._ID23192;
        var_19 = var_1.team;
        var_22 = distancesquared( var_14.origin, var_12.origin );
        var_23 = 90000;

        if ( var_19 == var_15 && var_22 < var_23 )
        {
            if ( !var_11 )
                var_1 thread maps\mp\gametypes\_hud_message::_ID31052( "defend", maps\mp\gametypes\_rank::_ID15328( "defend" ) );

            var_1 thread maps\mp\gametypes\_rank::giverankxp( "defend" );
            maps\mp\gametypes\_gamescore::_ID15616( "defend", var_1 );
            var_1 maps\mp\_utility::_ID17529( "defends", 1 );
            var_1 maps\mp\gametypes\_persistence::_ID31528( "round", "defends", var_1.pers["defends"] );
            thread maps\mp\_matchdata::_ID20250( var_9, "assaulting" );
        }
    }
}

_ID15223()
{
    var_0 = [];

    foreach ( var_2 in level._ID10614 )
    {
        if ( var_2 maps\mp\gametypes\_gameobjects::_ID15224() != "neutral" && isdefined( var_2._ID6697 ) )
            var_0[var_0.size] = var_2;
    }

    return var_0;
}

_ID15411( var_0 )
{
    var_1 = 0;

    for ( var_2 = 0; var_2 < level._ID13222.size; var_2++ )
    {
        if ( level._ID10614[var_2] maps\mp\gametypes\_gameobjects::_ID15224() == var_0 )
            var_1++;
    }

    return var_1;
}

_ID15019()
{
    return self._ID34757 maps\mp\gametypes\_gameobjects::_ID15224();
}

_ID13224()
{
    foreach ( var_1 in level._ID10614 )
    {
        switch ( var_1.label )
        {
            case "_a":
                var_1.dompointnumber = 0;
                continue;
            case "_b":
                var_1.dompointnumber = 1;
                continue;
            case "_c":
                var_1.dompointnumber = 2;
                continue;
        }
    }

    var_3 = maps\mp\gametypes\_spawnlogic::_ID15350( "mp_dom_spawn" );

    foreach ( var_5 in var_3 )
    {
        var_5.dompointa = 0;
        var_5._ID10622 = 0;
        var_5.dompointc = 0;
        var_5._ID21897 = _ID15162( var_5 );

        switch ( var_5._ID21897._ID34757.dompointnumber )
        {
            case 0:
                var_5.dompointa = 1;
                continue;
            case 1:
                var_5._ID10622 = 1;
                continue;
            case 2:
                var_5.dompointc = 1;
                continue;
        }
    }
}

_ID15162( var_0 )
{
    var_1 = maps\mp\gametypes\_spawnlogic::_ID18728();
    var_2 = undefined;
    var_3 = undefined;

    foreach ( var_5 in level._ID10614 )
    {
        var_6 = undefined;

        if ( var_1 )
            var_6 = getpathdist( var_0.origin, var_5.levelflag.origin, 999999 );

        if ( !isdefined( var_6 ) || var_6 == -1 )
            var_6 = distancesquared( var_5.levelflag.origin, var_0.origin );

        if ( !isdefined( var_2 ) || var_6 < var_3 )
        {
            var_2 = var_5;
            var_3 = var_6;
        }
    }

    return var_2.levelflag;
}

_ID17937()
{
    maps\mp\_awards::_ID18002( "pointscaptured", 0, maps\mp\_awards::highestwins );
}

_ID22902()
{
    maps\mp\_utility::setextrascore0( 0 );

    if ( isdefined( self.pers["captures"] ) )
        maps\mp\_utility::setextrascore0( self.pers["captures"] );
}

_ID34527()
{
    if ( !isdefined( self._ID8157 ) )
    {
        self._ID22396 = 0;
        self._ID8157 = 0;
    }

    self._ID22396++;

    if ( maps\mp\_utility::_ID15150() < 1 )
        return;

    self._ID8157 = self._ID22396 / maps\mp\_utility::_ID15150();
}

getcapxpscale()
{
    if ( self._ID8157 < 4 )
        return 1;
    else
        return 0.25;
}

_ID28725()
{
    self notify( "flag_neutral" );
    maps\mp\gametypes\_gameobjects::_ID28813( "neutral" );
    self._ID35361[0] setmodel( game["flagmodels"]["neutral"] );

    foreach ( var_1 in level.players )
    {
        var_2 = var_1._domflageffect[self.label];

        if ( isdefined( var_2 ) )
            var_2 delete();
    }

    _ID24581();
}

_ID24581()
{
    if ( isdefined( self.neutralflagfx ) )
        self.neutralflagfx delete();

    self.neutralflagfx = spawnfx( level.flagbasefxid["neutral"], self.baseeffectpos, self.baseeffectforward );
    triggerfx( self.neutralflagfx );
}

_ID28724( var_0 )
{
    var_1 = maps\mp\gametypes\_gameobjects::_ID15110();
    maps\mp\gametypes\_gameobjects::_ID28813( var_0 );
    maps\mp\gametypes\_gameobjects::_ID28180( "enemy", "waypoint_capture" + var_1 );
    maps\mp\gametypes\_gameobjects::_ID28181( "enemy", "waypoint_capture" + var_1 );
    maps\mp\gametypes\_gameobjects::_ID28180( "friendly", "waypoint_defend" + self.label );
    maps\mp\gametypes\_gameobjects::_ID28181( "friendly", "waypoint_defend" + self.label );
    self._ID35361[0] setmodel( game["flagmodels"][var_0] );
    self.neutralflagfx delete();

    foreach ( var_3 in level.players )
        showcapturedbaseeffecttoplayer( var_0, var_3 );

    thread baseeffectswaitforjoined();
}

showcapturedbaseeffecttoplayer( var_0, var_1 )
{
    if ( isdefined( var_1._domflageffect[self.label] ) )
        var_1._domflageffect[self.label] delete();

    var_2 = undefined;
    var_3 = var_1.team;
    var_4 = var_1 ismlgspectator();

    if ( var_4 )
        var_3 = var_1 getmlgspectatorteam();
    else if ( var_3 == "spectator" )
        var_3 = "allies";

    if ( var_3 == var_0 )
        var_2 = spawnfxforclient( level.flagbasefxid["friendly"], self.baseeffectpos, var_1, self.baseeffectforward );
    else
        var_2 = spawnfxforclient( level.flagbasefxid["enemy"], self.baseeffectpos, var_1, self.baseeffectforward );

    var_1._domflageffect[self.label] = var_2;
    triggerfx( var_2 );
}

baseeffectswaitforjoined()
{
    level endon( "game_ended" );
    self endon( "flag_neutral" );

    for (;;)
    {
        level waittill( "joined_team",  var_0  );

        if ( isdefined( var_0._domflageffect[self.label] ) )
        {
            var_0._domflageffect[self.label] delete();
            var_0._domflageffect[self.label] = undefined;
        }

        if ( var_0.team != "spectator" )
            showcapturedbaseeffecttoplayer( self._ID23192, var_0 );
    }
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0._domflageffect = [];
        var_0 thread _ID22808();
        var_0 thread _ID37866();
    }
}

_ID22808()
{
    self waittill( "disconnect" );

    foreach ( var_1 in self._domflageffect )
    {
        if ( isdefined( var_1 ) )
            var_1 delete();
    }
}

_ID37866()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "luinotifyserver",  var_0, var_1  );

        if ( var_0 == "mlg_view_change" )
        {
            foreach ( var_3 in level._ID10614 )
            {
                if ( var_3._ID23192 != "neutral" )
                    var_3 showcapturedbaseeffecttoplayer( var_3._ID23192, self );
            }
        }
    }
}
