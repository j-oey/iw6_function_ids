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
        maps\mp\_utility::_ID25715( level._ID14086, 3, 0, 9 );
        maps\mp\_utility::_ID25718( level._ID14086, 5 );
        maps\mp\_utility::_ID25717( level._ID14086, 1 );
        maps\mp\_utility::_ID25714( level._ID14086, 0 );
        maps\mp\_utility::_ID25724( level._ID14086, 4 );
        maps\mp\_utility::_ID25712( level._ID14086, 1 );
        maps\mp\_utility::_ID25706( level._ID14086, 0 );
        level._ID20676 = 0;
        level._ID20680 = 0;
    }

    level._ID22489 = 1;
    level._ID32653 = 1;
    level._ID22073 = 1;
    level._ID14070 = 0;
    level._ID22905 = ::_ID22905;
    level.getspawnpoint = ::getspawnpoint;
    level._ID22902 = ::_ID22902;
    level._ID22886 = ::_ID22886;
    level._ID22796 = ::_ID22796;
    level._ID22870 = ::_ID22870;
    level._ID22913 = ::_ID22913;
    level._ID17937 = ::_ID17937;
    level.lastcaptime = gettime();
    level.alliesprevflagcount = 0;
    level.axisprevflagcount = 0;
    level.allowlatecomers = 0;
    level.gametimerbeeps = 0;
    level.siegeflagcapturing = [];

    if ( level._ID20676 || level._ID20680 )
        level._ID21286 = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    game["dialog"]["offense_obj"] = "capture_objs";
    game["dialog"]["defense_obj"] = "capture_objs";
    game["dialog"]["revived"] = "sr_rev";
    thread _ID22877();
    thread onplayerswitchteam();
}

initializematchrules()
{
    maps\mp\_utility::_ID28682();
    var_0 = getmatchrulesdata( "siegeData", "roundLength" );
    setdynamicdvar( "scr_siege_timelimit", var_0 );
    maps\mp\_utility::_ID25718( "siege", var_0 );
    var_1 = getmatchrulesdata( "siegeData", "roundSwitch" );
    setdynamicdvar( "scr_siege_roundswitch", var_1 );
    maps\mp\_utility::_ID25715( "siege", var_1, 0, 9 );
    var_2 = getmatchrulesdata( "commonOption", "scoreLimit" );
    setdynamicdvar( "scr_siege_winlimit", var_2 );
    maps\mp\_utility::_ID25724( "siege", var_2 );
    var_3 = getmatchrulesdata( "siegeData", "capRate" );
    setdynamicdvar( "scr_siege_caprate", var_3 );
    var_4 = getmatchrulesdata( "siegeData", "rushTimer" );
    setdynamicdvar( "scr_siege_rushtimer", var_4 );
    var_5 = getmatchrulesdata( "siegeData", "rushTimerAmount" );
    setdynamicdvar( "scr_siege_rushtimeramount", var_5 );
    var_6 = getmatchrulesdata( "siegeData", "preCapPoints" );
    setdynamicdvar( "scr_siege_precap", var_6 );
    setdynamicdvar( "scr_siege_roundlimit", 0 );
    maps\mp\_utility::_ID25714( "siege", 0 );
    setdynamicdvar( "scr_siege_scorelimit", 1 );
    maps\mp\_utility::_ID25717( "siege", 1 );
    setdynamicdvar( "scr_siege_halftime", 0 );
    maps\mp\_utility::_ID25706( "siege", 0 );
    setdynamicdvar( "scr_siege_promode", 0 );
}

_ID22905()
{
    if ( !isdefined( game["switchedsides"] ) )
        game["switchedsides"] = 0;

    if ( game["switchedsides"] )
    {
        var_0 = game["attackers"];
        var_1 = game["defenders"];
        game["attackers"] = var_1;
        game["defenders"] = var_0;
    }

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
    initspawns();
    var_2[0] = "dom";
    maps\mp\gametypes\_gameobjects::_ID20445( var_2 );
    level.flagbasefxid["neutral"] = loadfx( "vfx/gameplay/mp/core/vfx_marker_base_grey" );
    level.flagbasefxid["friendly"] = loadfx( "vfx/gameplay/mp/core/vfx_marker_base_cyan" );
    level.flagbasefxid["enemy"] = loadfx( "vfx/gameplay/mp/core/vfx_marker_base_orange" );
    thread _ID10614();
    thread watchflagtimerpause();
    thread watchflagtimerreset();
    thread watchflagenduse();
    thread watchgameinactive();
    thread watchgamestart();
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

    if ( var_0.size > 0 )
    {
        foreach ( var_7 in var_0 )
            var_2[var_7.dompointnumber] = 1;

        return var_2;
    }

    if ( var_0.size == 0 )
    {
        var_4 = var_3;
        var_5 = level.bestspawnflag[var_4];

        if ( var_1.size > 0 && var_1.size < level._ID10614.size )
        {
            var_5 = _ID15453( var_4, undefined );
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

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0._domflageffect = [];
        var_0 thread _ID22882();
        var_0 thread _ID37866();
        var_0.siegelatecomer = 1;
    }
}

onplayerswitchteam()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "joined_team",  var_0  );

        if ( maps\mp\_utility::_ID14070() )
            var_0.siegelatecomer = 1;
    }
}

_ID22902()
{
    maps\mp\_utility::setextrascore0( 0 );

    if ( isdefined( self.pers["captures"] ) )
        maps\mp\_utility::setextrascore0( self.pers["captures"] );

    level notify( "spawned_player" );
}

_ID22882()
{
    self waittill( "disconnect" );

    foreach ( var_1 in self._domflageffect )
    {
        if ( isdefined( var_1 ) )
            var_1 delete();
    }
}

_ID7057()
{
    wait 0.05;
    var_0 = 0;

    if ( !level.alivecount[game["attackers"]] )
    {
        level._ID30972[game["attackers"]].allowenemyspectate = 1;
        var_0 = 1;
    }

    if ( !level.alivecount[game["defenders"]] )
    {
        level._ID30972[game["defenders"]].allowenemyspectate = 1;
        var_0 = 1;
    }

    if ( var_0 )
        maps\mp\gametypes\_spectating::_ID34611();
}

_ID17937()
{
    maps\mp\_awards::_ID18002( "pointscaptured", 0, maps\mp\_awards::highestwins );
}

_ID34544()
{

}

_ID10614()
{
    level endon( "game_ended" );
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
    var_2 = "mp/siegeFlagPos.csv";
    var_3 = maps\mp\_utility::getmapname();
    var_4 = 1;

    for ( var_5 = 2; var_5 < 11; var_5++ )
    {
        var_6 = tablelookup( var_2, var_4, var_3, var_5 );

        if ( var_6 != "" )
            setflagpositions( var_5, float( var_6 ) );
    }

    for ( var_7 = 0; var_7 < var_0.size; var_7++ )
        level._ID13222[level._ID13222.size] = var_0[var_7];

    for ( var_7 = 0; var_7 < var_1.size; var_7++ )
        level._ID13222[level._ID13222.size] = var_1[var_7];

    level._ID10614 = [];

    for ( var_7 = 0; var_7 < level._ID13222.size; var_7++ )
    {
        var_8 = level._ID13222[var_7];
        var_8.origin = getflagpos( var_8._ID27658, var_8.origin );

        if ( isdefined( var_8.target ) )
            var_9[0] = getent( var_8.target, "targetname" );
        else
        {
            var_9[0] = spawn( "script_model", var_8.origin );
            var_9[0].angles = var_8.angles;
        }

        var_10 = maps\mp\gametypes\_gameobjects::_ID8493( "neutral", var_8, var_9, ( 0, 0, 100 ) );
        var_10 maps\mp\gametypes\_gameobjects::allowuse( "enemy" );
        var_10 maps\mp\gametypes\_gameobjects::_ID29198( getdvarfloat( "scr_siege_caprate" ) );
        var_10 maps\mp\gametypes\_gameobjects::_ID29197( &"MP_SECURING_POSITION" );
        var_11 = var_10 maps\mp\gametypes\_gameobjects::_ID15110();
        var_10.label = var_11;
        var_10 maps\mp\gametypes\_gameobjects::_ID28180( "friendly", "waypoint_defend" + var_11 );
        var_10 maps\mp\gametypes\_gameobjects::_ID28181( "friendly", "waypoint_defend" + var_11 );
        var_10 maps\mp\gametypes\_gameobjects::_ID28180( "enemy", "waypoint_captureneutral" + var_11 );
        var_10 maps\mp\gametypes\_gameobjects::_ID28181( "enemy", "waypoint_captureneutral" + var_11 );
        var_10 maps\mp\gametypes\_gameobjects::_ID29202( "any" );
        var_10._ID22916 = ::_ID22916;
        var_10._ID22779 = ::_ID22779;
        var_10._ID22922 = ::_ID22922;
        var_10._ID22816 = ::_ID22816;
        var_10._ID22331 = 1;
        var_10._ID17334 = "domFlag";
        var_10.firstcapture = 1;
        var_10.prevteam = "neutral";
        var_10.flagcapsuccess = 0;
        var_12 = var_9[0].origin + ( 0, 0, 32 );
        var_13 = var_9[0].origin + ( 0, 0, -32 );
        var_14 = bullettrace( var_12, var_13, 0, undefined );
        var_10.baseeffectpos = var_14["position"];
        var_15 = vectortoangles( var_14["normal"] );
        var_10.baseeffectforward = anglestoforward( var_15 );
        var_10 thread _ID28725();
        level._ID13222[var_7]._ID34757 = var_10;
        var_10.levelflag = level._ID13222[var_7];
        level._ID10614[level._ID10614.size] = var_10;
    }

    var_16 = maps\mp\gametypes\_spawnlogic::_ID15350( "mp_dom_spawn_axis_start" );
    var_17 = maps\mp\gametypes\_spawnlogic::_ID15350( "mp_dom_spawn_allies_start" );
    level._ID31469["allies"] = var_17[0].origin;
    level._ID31469["axis"] = var_16[0].origin;
    level.bestspawnflag = [];
    level.bestspawnflag["allies"] = _ID15453( "allies", undefined );
    level.bestspawnflag["axis"] = _ID15453( "axis", level.bestspawnflag["allies"] );

    if ( getdvarint( "scr_siege_precap" ) )
    {
        storecenterflag();
        var_18 = [];
        var_18[var_18.size] = level.centerflag;

        if ( game["switchedsides"] )
        {
            level.closestalliesflag = _ID15453( "axis", level.centerflag );
            var_18[var_18.size] = level.closestalliesflag;
            level.closestaxisflag = _ID15453( "allies", var_18 );
        }
        else
        {
            level.closestalliesflag = _ID15453( "allies", level.centerflag );
            var_18[var_18.size] = level.closestalliesflag;
            level.closestaxisflag = _ID15453( "axis", var_18 );
        }

        level.closestalliesflag._ID34757 _ID28724( "allies", "neutral", undefined, 1 );
        level.closestaxisflag._ID34757 _ID28724( "axis", "neutral", undefined, 1 );
    }

    _ID13224();
}

setflagpositions( var_0, var_1 )
{
    switch ( var_0 )
    {
        case 2:
            level.siege_a_xpos = var_1;
            break;
        case 3:
            level.siege_a_ypos = var_1;
            break;
        case 4:
            level.siege_a_zpos = var_1;
            break;
        case 5:
            level.siege_b_xpos = var_1;
            break;
        case 6:
            level.siege_b_ypos = var_1;
            break;
        case 7:
            level.siege_b_zpos = var_1;
            break;
        case 8:
            level.siege_c_xpos = var_1;
            break;
        case 9:
            level.siege_c_ypos = var_1;
            break;
        case 10:
            level.siege_c_zpos = var_1;
            break;
    }
}

getflagpos( var_0, var_1 )
{
    var_2 = var_1;

    if ( var_0 == "_a" )
    {
        if ( isdefined( level.siege_a_xpos ) && isdefined( level.siege_a_ypos ) && isdefined( level.siege_a_zpos ) )
            var_2 = ( level.siege_a_xpos, level.siege_a_ypos, level.siege_a_zpos );
    }
    else if ( var_0 == "_b" )
    {
        if ( isdefined( level.siege_b_xpos ) && isdefined( level.siege_b_ypos ) && isdefined( level.siege_b_zpos ) )
            var_2 = ( level.siege_b_xpos, level.siege_b_ypos, level.siege_b_zpos );
    }
    else if ( isdefined( level.siege_c_xpos ) && isdefined( level.siege_c_ypos ) && isdefined( level.siege_c_zpos ) )
        var_2 = ( level.siege_c_xpos, level.siege_c_ypos, level.siege_c_zpos );

    return var_2;
}

storecenterflag()
{
    var_0 = undefined;

    foreach ( var_2 in level._ID13222 )
    {
        if ( var_2._ID27658 == "_b" )
            level.centerflag = var_2;
    }
}

watchflagtimerpause()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "flag_capturing",  var_0  );

        if ( getdvarint( "scr_siege_rushtimer" ) )
        {
            var_1 = maps\mp\_utility::getotherteam( var_0.prevteam );

            if ( var_0.prevteam != "neutral" && ( isdefined( level.siegetimerstate ) && level.siegetimerstate != "pause" ) && !iswinningteam( var_1 ) )
            {
                level.gametimerbeeps = 0;
                level.siegetimerstate = "pause";
                pausecountdowntimer();

                if ( !flagownersalive( var_0.prevteam ) )
                    setwinner( var_1, var_0.prevteam + "_eliminated" );
            }
        }
    }
}

iswinningteam( var_0 )
{
    var_1 = 0;
    var_2 = getflagcount( var_0 );

    if ( var_2 == 2 )
        var_1 = 1;

    return var_1;
}

flagownersalive( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in level._ID23303 )
    {
        if ( isdefined( var_3 ) && var_3.team == var_0 && ( maps\mp\_utility::_ID18757( var_3 ) || var_3.pers["lives"] > 0 ) )
        {
            var_1 = 1;
            break;
        }
    }

    return var_1;
}

pausecountdowntimer()
{
    setgameendtime( 0 );

    foreach ( var_1 in level.players )
        var_1 setclientomnvar( "ui_bomb_timer", 5 );

    level notify( "siege_timer_paused" );
}

watchflagtimerreset()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "start_flag_captured",  var_0  );

        if ( getdvarint( "scr_siege_rushtimer" ) )
        {
            if ( isdefined( level.siegetimerstate ) && level.siegetimerstate != "reset" )
            {
                level.gametimerbeeps = 0;
                level.siegetimeleft = undefined;
                level.siegetimerstate = "reset";
                notifyplayers( "siege_timer_reset" );
            }
        }

        level notify( "flag_end_use",  var_0  );
    }
}

watchflagenduse()
{
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = 0;
        var_1 = 0;
        level waittill( "flag_end_use",  var_2  );
        var_0 = getflagcount( "allies" );
        var_1 = getflagcount( "axis" );

        if ( var_0 == 2 || var_1 == 2 )
        {
            if ( getdvarint( "scr_siege_rushtimer" ) )
            {
                if ( level.siegeflagcapturing.size == 0 && ( !var_2.flagcapsuccess || !isdefined( level.siegetimerstate ) || level.siegetimerstate != "start" ) )
                {
                    var_3 = getdvarfloat( "scr_siege_rushtimeramount" );

                    if ( isdefined( level.siegetimeleft ) )
                        var_3 = level.siegetimeleft;

                    var_4 = int( gettime() + var_3 * 1000 );

                    foreach ( var_6 in level.players )
                        var_6 setclientomnvar( "ui_bomb_timer", 0 );

                    level._ID33056 = 1;
                    maps\mp\gametypes\_gamelogic::_ID23389();
                    setgameendtime( var_4 );

                    if ( !isdefined( level.siegetimerstate ) || level.siegetimerstate == "pause" )
                    {
                        level.siegetimerstate = "start";
                        notifyplayers( "siege_timer_start" );
                    }

                    if ( !level.gametimerbeeps )
                        thread watchgametimer( var_3 );
                }
            }
        }
        else if ( var_0 == 3 )
            setwinner( "allies", "score_limit_reached" );
        else if ( var_1 == 3 )
            setwinner( "axis", "score_limit_reached" );

        var_2.prevteam = var_2._ID23192;
    }
}

watchgameinactive()
{
    level endon( "game_ended" );
    level endon( "flag_capturing" );
    var_0 = getdvarfloat( "scr_siege_timelimit" );

    if ( var_0 > 0 )
    {
        var_1 = var_0 * 60 - 1;

        while ( var_1 > 0 )
        {
            var_1 -= 1;
            wait 1;
        }

        level.siegegameinactive = 1;
    }
}

watchgamestart()
{
    level endon( "game_ended" );
    maps\mp\_utility::gameflagwait( "prematch_done" );

    while ( !havespawnedplayers() )
        common_scripts\utility::_ID35582();

    level._ID14070 = 1;
}

havespawnedplayers()
{
    if ( level._ID32653 )
        return level.hasspawned["axis"] && level.hasspawned["allies"];

    return level._ID20754 > 1;
}

watchgametimer( var_0 )
{
    level endon( "game_ended" );
    level endon( "siege_timer_paused" );
    level endon( "siege_timer_reset" );
    var_1 = var_0;
    var_2 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_2 hide();
    level.gametimerbeeps = 1;

    while ( var_1 > 0 )
    {
        var_1 -= 1;
        level.siegetimeleft = var_1;

        if ( var_1 <= 30 )
        {
            if ( var_1 != 0 )
                var_2 playsound( "ui_mp_timer_countdown" );
        }

        wait 1;
    }

    _ID22913();
}

getflagcount( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in level._ID10614 )
    {
        if ( var_3._ID23192 == var_0 && !isbeingcaptured( var_3 ) )
            var_1 += 1;
    }

    return var_1;
}

isbeingcaptured( var_0 )
{
    var_1 = 0;

    if ( isdefined( var_0 ) )
    {
        if ( level.siegeflagcapturing.size > 0 )
        {
            foreach ( var_3 in level.siegeflagcapturing )
            {
                if ( var_0.label == var_3 )
                    var_1 = 1;
            }
        }
    }

    return var_1;
}

setwinner( var_0, var_1 )
{
    if ( var_0 != "tie" )
        level.finalkillcam_winner = var_0;
    else
        level.finalkillcam_winner = "none";

    foreach ( var_3 in level.players )
    {
        if ( !isai( var_3 ) )
        {
            var_3 setclientomnvar( "ui_dom_securing", 0 );
            var_3 setclientomnvar( "ui_bomb_timer", 0 );
        }
    }

    thread maps\mp\gametypes\_gamelogic::endgame( var_0, game["end_reason"][var_1] );
}

_ID22779( var_0 )
{
    var_1 = maps\mp\gametypes\_gameobjects::_ID15224();
    self._ID10016 = 0;
    maps\mp\gametypes\_gameobjects::_ID29198( getdvarfloat( "scr_siege_caprate" ) );
    level.siegeflagcapturing[level.siegeflagcapturing.size] = self.label;
    level notify( "flag_capturing",  self  );
}

_ID22916( var_0 )
{
    var_1 = var_0.team;
    var_2 = maps\mp\gametypes\_gameobjects::_ID15224();
    self._ID6697 = gettime();
    _ID28724( var_1, var_2, var_0 );
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
    }

    var_0 maps\mp\_events::giveobjectivepointstreaks();
    thread giveflagcapturexp( self._ID33167[var_1] );
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
}

_ID22816( var_0, var_1, var_2 )
{
    if ( isplayer( var_1 ) )
    {
        var_1 setclientomnvar( "ui_dom_securing", 0 );
        var_1.ui_dom_securing = undefined;
    }

    if ( var_2 )
    {
        self.flagcapsuccess = 1;
        level notify( "start_flag_captured",  self  );
    }
    else
    {
        self.flagcapsuccess = 0;
        level notify( "flag_end_use",  self  );
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

    level.siegeflagcapturing = common_scripts\utility::array_remove( level.siegeflagcapturing, self.label );
}

_ID22893()
{

}

_ID15453( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;

    foreach ( var_6 in level._ID13222 )
    {
        if ( var_6._ID34757 _ID15019() != "neutral" )
            continue;

        var_7 = distancesquared( var_6.origin, level._ID31469[var_0] );

        if ( isdefined( var_1 ) )
        {
            if ( !isflagexcluded( var_6, var_1 ) && ( !isdefined( var_2 ) || var_7 < var_3 ) )
            {
                var_3 = var_7;
                var_2 = var_6;
            }

            continue;
        }

        if ( !isdefined( var_2 ) || var_7 < var_3 )
        {
            var_3 = var_7;
            var_2 = var_6;
        }
    }

    return var_2;
}

isflagexcluded( var_0, var_1 )
{
    var_2 = 0;

    if ( isarray( var_1 ) )
    {
        foreach ( var_4 in var_1 )
        {
            if ( var_0 == var_4 )
            {
                var_2 = 1;
                break;
            }
        }
    }
    else if ( var_0 == var_1 )
        var_2 = 1;

    return var_2;
}

_ID22796( var_0 )
{
    if ( maps\mp\_utility::_ID14070() )
    {
        if ( var_0 == "all" )
            _ID22913();
        else if ( var_0 == game["attackers"] )
        {
            if ( getflagcount( var_0 ) == 2 )
                return;

            setwinner( game["defenders"], game["attackers"] + "_eliminated" );
        }
        else if ( var_0 == game["defenders"] )
        {
            if ( getflagcount( var_0 ) == 2 )
                return;

            setwinner( game["attackers"], game["defenders"] + "_eliminated" );
        }
    }
}

_ID22870( var_0 )
{
    var_1 = maps\mp\_utility::_ID15113( var_0 );
    var_1 thread _ID15604();
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

_ID15604()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    maps\mp\_utility::_ID35774( 3 );
    var_0 = maps\mp\_utility::getotherteam( self.pers["team"] );
    level thread maps\mp\_utility::_ID32672( "callout_lastteammemberalive", self, self.pers["team"] );
    level thread maps\mp\_utility::_ID32672( "callout_lastenemyalive", self, var_0 );
    level notify( "last_alive",  self  );
    maps\mp\gametypes\_missions::lastmansd();
}

_ID22913()
{
    if ( isdefined( level.siegegameinactive ) )
        level thread maps\mp\gametypes\_gamelogic::_ID13521();
    else
    {
        var_0 = getflagcount( "allies" );
        var_1 = getflagcount( "axis" );

        if ( var_0 > var_1 )
            setwinner( "allies", "time_limit_reached" );
        else if ( var_1 > var_0 )
            setwinner( "axis", "time_limit_reached" );
        else
            setwinner( "tie", "time_limit_reached" );
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

_ID9510( var_0, var_1 )
{
    level endon( "game_ended" );
    wait 0.1;
    maps\mp\_utility::_ID35777();
    maps\mp\_utility::_ID19760( var_0, var_1 );
}

teamrespawn( var_0, var_1 )
{
    foreach ( var_3 in level._ID23303 )
    {
        if ( isdefined( var_3 ) && var_3.team == var_0 && !maps\mp\_utility::_ID18757( var_3 ) && !common_scripts\utility::array_contains( level.alive_players[var_3.team], var_3 ) && ( !isdefined( var_3._ID35590 ) || !var_3._ID35590 ) )
        {
            if ( isdefined( var_3.siegelatecomer ) && var_3.siegelatecomer )
                var_3.siegelatecomer = 0;

            var_3 maps\mp\gametypes\_playerlogic::incrementalivecount( var_3.team );
            var_3.alreadyaddedtoalivecount = 1;
            var_3 thread _ID38278();
            var_3 thread maps\mp\gametypes\_hud_message::_ID31052( "sr_respawned" );
            level notify( "sr_player_respawned",  var_3  );
            var_3 maps\mp\_utility::_ID19765( "revived" );
            var_1 maps\mp\gametypes\_missions::_ID25038( "ch_rescuer" );

            if ( !isdefined( var_1._ID37892 ) )
                var_1._ID37892 = [];

            var_1._ID37892[var_3._ID15851] = 1;

            if ( var_1._ID37892.size == 4 )
                var_1 maps\mp\gametypes\_missions::_ID25038( "ch_helpme" );
        }
    }
}

_ID38278()
{
    self endon( "started_spawnPlayer" );

    for (;;)
    {
        wait 0.05;

        if ( isdefined( self ) && ( self.sessionstate == "spectator" || !maps\mp\_utility::_ID18757( self ) ) )
        {
            self.pers["lives"] = 1;
            maps\mp\gametypes\_playerlogic::_ID30822();
            continue;
        }

        return;
    }
}

notifyplayers( var_0 )
{
    foreach ( var_2 in level.players )
        var_2 thread maps\mp\gametypes\_hud_message::_ID31052( var_0 );

    level notify( "match_ending_soon",  "time"  );
    level notify( var_0 );
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
    return maps\mp\gametypes\_gameobjects::_ID15224();
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

getcapxpscale()
{
    if ( self._ID8157 < 4 )
        return 1;
    else
        return 0.25;
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

_ID28724( var_0, var_1, var_2, var_3 )
{
    var_4 = maps\mp\gametypes\_gameobjects::_ID15110();
    maps\mp\gametypes\_gameobjects::_ID28813( var_0 );
    maps\mp\gametypes\_gameobjects::_ID28180( "enemy", "waypoint_capture" + var_4 );
    maps\mp\gametypes\_gameobjects::_ID28181( "enemy", "waypoint_capture" + var_4 );
    maps\mp\gametypes\_gameobjects::_ID28180( "friendly", "waypoint_defend" + self.label );
    maps\mp\gametypes\_gameobjects::_ID28181( "friendly", "waypoint_defend" + self.label );
    self._ID35361[0] setmodel( game["flagmodels"][var_0] );

    if ( isdefined( self.neutralflagfx ) )
        self.neutralflagfx delete();

    foreach ( var_6 in level.players )
        showcapturedbaseeffecttoplayer( var_0, var_6 );

    if ( !isdefined( var_3 ) )
    {
        if ( var_1 != "neutral" )
        {
            _ID31531( "secured" + self.label, var_0, 1 );
            _ID31531( "lost" + self.label, var_1, 1 );
            maps\mp\_utility::_ID24645( "mp_dom_flag_lost", var_1 );
            level.lastcaptime = gettime();
        }

        teamrespawn( var_0, var_2 );
        self.firstcapture = 0;
    }

    thread baseeffectswaitforjoined();
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
