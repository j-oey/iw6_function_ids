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
        maps\mp\_utility::_ID25717( level._ID14086, 7500 );
        maps\mp\_utility::_ID25714( level._ID14086, 1 );
        maps\mp\_utility::_ID25724( level._ID14086, 1 );
        maps\mp\_utility::_ID25712( level._ID14086, 0 );
        maps\mp\_utility::_ID25706( level._ID14086, 0 );
        level.matchrules_droptime = 15;
        level.matchrules_zoneswitchtime = 60;
        level._ID20676 = 0;
        level._ID20680 = 0;
        setdvar( "scr_game_hardpoints", 0 );
    }

    level._ID32653 = 1;
    level._ID22905 = ::_ID22905;
    level.getspawnpoint = ::getspawnpoint;
    level._ID22902 = ::_ID22902;

    if ( level._ID20676 || level._ID20680 )
        level._ID21286 = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    level.grnd_fx["smoke"] = loadfx( "smoke/airdrop_flare_mp_effect_now" );
    level.grnd_fx["flare"] = loadfx( "smoke/signal_smoke_airdrop" );
    level.grnd_targetfxid = loadfx( "vfx/gameplay/mp/core/vfx_marker_base_cyan" );
    level.dangermaxradius["drop_zone"] = 1200;
    level.dangerminradius["drop_zone"] = 1190;
    level._ID8988["drop_zone"] = 0;
    level.dangerovalscale["drop_zone"] = 1;
}

initializematchrules()
{
    maps\mp\_utility::_ID28682();
    level.matchrules_droptime = getmatchrulesdata( "grndData", "dropTime" );
    level.matchrules_zoneswitchtime = 60 * getmatchrulesdata( "grndData", "zoneSwitchTime" );

    if ( level.matchrules_zoneswitchtime < 60 )
        level.matchrules_zoneswitchtime = 60;

    setdynamicdvar( "scr_grnd_roundswitch", 0 );
    maps\mp\_utility::_ID25715( "grnd", 0, 0, 9 );
    setdynamicdvar( "scr_grnd_roundlimit", 1 );
    maps\mp\_utility::_ID25714( "grnd", 1 );
    setdynamicdvar( "scr_grnd_winlimit", 1 );
    maps\mp\_utility::_ID25724( "grnd", 1 );
    setdynamicdvar( "scr_grnd_halftime", 0 );
    maps\mp\_utility::_ID25706( "grnd", 0 );
    setdynamicdvar( "scr_grnd_promode", 0 );
}

_ID22905()
{
    setclientnamemode( "auto_change" );

    if ( !isdefined( game["switchedsides"] ) )
        game["switchedsides"] = 0;

    maps\mp\_utility::_ID28804( "allies", &"OBJECTIVES_GRND" );
    maps\mp\_utility::_ID28804( "axis", &"OBJECTIVES_GRND" );

    if ( level.splitscreen )
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_GRND" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_GRND" );
    }
    else
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_GRND_SCORE" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_GRND_SCORE" );
    }

    maps\mp\_utility::setobjectivehinttext( "allies", &"OBJECTIVES_DOM_HINT" );
    maps\mp\_utility::setobjectivehinttext( "axis", &"OBJECTIVES_DOM_HINT" );
    level._ID30895 = ( 0, 0, 0 );
    level._ID30893 = ( 0, 0, 0 );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_tdm_spawn_allies_start" );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_tdm_spawn_axis_start" );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", "mp_tdm_spawn" );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", "mp_tdm_spawn" );
    level._ID20634 = maps\mp\gametypes\_spawnlogic::findboxcenter( level._ID30895, level._ID30893 );
    setmapcenter( level._ID20634 );
    var_0 = getentarray( "flag_primary", "targetname" );
    var_1 = sortbydistance( var_0, level._ID20634 );
    var_2 = var_1[0];
    level.grnd_centerloc = level._ID20634;
    maps\mp\gametypes\_rank::registerscoreinfo( "kill", 50 );
    maps\mp\gametypes\_rank::registerscoreinfo( "zone_kill", 100 );
    maps\mp\gametypes\_rank::registerscoreinfo( "zone_tick", 20 );
    var_3[0] = level._ID14086;
    var_3[1] = "tdm";
    maps\mp\gametypes\_gameobjects::_ID20445( var_3 );
    level.grnd_hud["timerDisplay"] = maps\mp\gametypes\_hud_util::createservertimer( "objective", 1.4 );
    level.grnd_hud["timerDisplay"].label = &"MP_NEXT_DROP_ZONE_IN";
    level.grnd_hud["timerDisplay"] maps\mp\gametypes\_hud_util::_ID28836( "BOTTOMCENTER", "BOTTOMCENTER", 0, -28 );
    level.grnd_hud["timerDisplay"].alpha = 0;
    level.grnd_hud["timerDisplay"].archived = 0;
    level.grnd_hud["timerDisplay"].hidewheninmenu = 1;
    level.grnd_hud["timerDisplay"].hidewhenindemo = 1;
    thread hidehudelementongameend( level.grnd_hud["timerDisplay"] );
    createzones();
    initzones();
    initfirstzone();
}

initfirstzone()
{
    level.zonescycling = 0;
    level.firstzoneactive = 0;
    var_0 = 999999;
    var_1 = 0;

    if ( tolower( getdvar( "mapname" ) ) == "mp_shipment_ns" )
        var_2 = ( 1.6, 63, 192 );
    else
    {
        for ( var_3 = 0; var_3 < level.grnd_zones.size; var_3++ )
        {
            var_4 = level.grnd_zones[var_3];
            var_5 = distance2d( level.grnd_centerloc, var_4.origin );

            if ( var_5 < var_0 )
            {
                var_0 = var_5;
                var_1 = var_3;
            }
        }

        level.grnd_initialindex = var_1;
        var_2 = level.grnd_zones[var_1].origin;
    }

    level.grnd_initialpos = var_2;
    level.grnd_zone = spawn( "script_model", var_2 );
    level.grnd_zone.origin = var_2;
    level.grnd_zone.angles = ( 90, 0, 0 );
    level.grnd_zone setmodel( "weapon_us_smoke_grenade_burnt2" );
    var_6 = spawn( "script_model", level.grnd_zone.origin );
    var_6 setmodel( "tag_origin" );
    var_6.angles = vectortoangles( ( 0, 0, 1 ) );
    var_6 linkto( level.grnd_zone );
    level.grnd_zone.ringvfx = var_6;
    level.grnd_dangercenter = spawnstruct();
    level.grnd_dangercenter.origin = var_2;
    level.grnd_dangercenter.forward = anglestoforward( ( 0, 0, 0 ) );
    level.grnd_dangercenter._ID31889 = "drop_zone";
    level.favorclosespawnent = level.grnd_zone;
}

initzones()
{
    level.grnd_zones = [];

    if ( getdvar( "mapname" ) == "mp_strikezone" )
    {
        if ( isdefined( level.teleport_zone_current ) && level.teleport_zone_current == "start" )
        {
            for ( var_0 = 0; var_0 < level.grnd_dropzones1.size; var_0++ )
            {
                var_1 = level.grnd_dropzones1[var_0].origin;
                level.grnd_zones[var_0] = spawn( "script_origin", var_1 );
                level.grnd_zones[var_0].origin = var_1;
                wait 0.05;
            }
        }
        else
        {
            for ( var_0 = 0; var_0 < level.grnd_dropzones2.size; var_0++ )
            {
                var_1 = level.grnd_dropzones2[var_0].origin;
                level.grnd_zones[var_0] = spawn( "script_origin", var_1 );
                level.grnd_zones[var_0].origin = var_1;
                wait 0.05;
            }
        }
    }
    else
    {
        for ( var_0 = 0; var_0 < level.grnd_dropzones.size; var_0++ )
        {
            var_1 = level.grnd_dropzones[var_0].origin;
            level.grnd_zones[var_0] = spawn( "script_origin", var_1 );
            level.grnd_zones[var_0].origin = var_1;
            wait 0.05;
        }
    }
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
        var_3 = sortbydistance( var_1, level.favorclosespawnent.origin );
        var_4 = [];

        for ( var_5 = 0; var_5 < var_3.size; var_5++ )
        {
            var_4[var_5] = var_3[var_5];

            if ( common_scripts\utility::_ID10238( var_4[var_5].origin, level.favorclosespawnent.origin ) > 589824 && var_5 > 5 )
                break;
        }

        var_2 = maps\mp\gametypes\_spawnscoring::getspawnpoint_dz( var_1, var_4 );
    }

    return var_2;
}

_ID22902()
{
    if ( !isdefined( self.ingrindzone ) )
    {
        if ( isagent( self ) )
            return;

        level thread setplayermessages( self );

        if ( !level.zonescycling )
        {
            level.zonescycling = 1;
            level thread cyclezones();
            level thread locationstatus();
            level thread locationscoring();
        }

        thread _ID35599();
    }

    level notify( "spawned_player" );
}

_ID35599()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    maps\mp\_utility::gameflagwait( "prematch_done" );
    wait 0.5;

    if ( !isdefined( self.grnd_fx_playing ) )
    {
        playfxontagforclients( level.grnd_fx["smoke"], level.grnd_zone, "tag_fx", self );
        self.grnd_fx_playing = 1;
    }
}

createhudinfo( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = maps\mp\gametypes\_hud_util::createfontstring( var_1, var_2 );
    var_7 settext( var_5 );

    if ( level.splitscreen )
        var_7 maps\mp\gametypes\_hud_util::_ID28836( "TOPLEFT", "TOPLEFT", var_3 - 35, var_4 - 5 );
    else
        var_7 maps\mp\gametypes\_hud_util::_ID28836( "TOPLEFT", "TOPLEFT", var_3, var_4 );

    var_7.alpha = 1;
    var_7.color = var_6;
    var_7.glowcolor = var_6;
    var_7.archived = 0;
    var_7.hidewheninmenu = 1;
    thread hidehudelementongameend( var_7 );
    self.grnd_hud[var_0] = var_7;
}

setplayermessages( var_0 )
{
    level endon( "game_ended" );
    maps\mp\_utility::gameflagwait( "prematch_done" );

    if ( !isdefined( var_0 ) )
        return;

    var_0.ingrindzonepoints = 0;
    var_0.grndheadicon = level.grnd_zone maps\mp\_entityheadicons::setheadicon( var_0, "waypoint_captureneutral_b", ( 0, 0, 0 ), 14, 14, undefined, undefined, undefined, 1, undefined, 0 );
    var_0.grndobjid = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_0.grndobjid, "invisible", ( 0, 0, 0 ) );
    objective_player( var_0.grndobjid, var_0 getentitynumber() );
    objective_onentity( var_0.grndobjid, level.grnd_zone );
    objective_icon( var_0.grndobjid, "waypoint_captureneutral_b" );
    objective_state( var_0.grndobjid, "active" );

    if ( var_0 isingrindzone() )
    {
        var_0.ingrindzone = 1;
        var_0.grndheadicon.alpha = 0;
    }
    else
    {
        var_0.ingrindzone = 0;
        var_0.grndheadicon.alpha = 0.85;
    }

    var_0.grnd_wasspectator = 0;

    if ( var_0.team == "spectator" )
    {
        var_0.ingrindzone = 0;
        var_0.ingrindzonepoints = 0;
        var_0.grndheadicon.alpha = 0;
        var_0.grnd_hud["axisScore"].alpha = 0;
        var_0.grnd_hud["axisText"].alpha = 0;
        var_0.grnd_hud["alliesScore"].alpha = 0;
        var_0.grnd_hud["alliesText"].alpha = 0;
        var_0.grnd_wasspectator = 1;
    }

    if ( !isai( var_0 ) )
        var_0 thread grndtracking();
}

getnextzone()
{
    var_0 = undefined;
    var_1 = undefined;
    var_2 = 99999999;
    var_3 = 0;

    if ( isdefined( level.teleport_zone_current ) && level.teleport_zone_current == "start" )
        var_4 = sortbydistance( level.grnd_dropzones1, level.grnd_zone.origin );
    else if ( isdefined( level.teleport_zone_current ) && level.teleport_zone_current != "start" )
    {
        if ( !isdefined( level.grnd_dropzones2 ) || !level.grnd_dropzones2.size )
            level initzones();

        var_4 = sortbydistance( level.grnd_dropzones2, level.grnd_zone.origin );
    }
    else
        var_4 = sortbydistance( level.grnd_zones, level.grnd_zone.origin );

    var_0 = var_4[randomintrange( 1, var_4.size )].origin;
    return var_0;
}

cyclezones()
{
    level notify( "cycleZones" );
    level endon( "cycleZones" );
    level endon( "game_ended" );
    maps\mp\_utility::gameflagwait( "prematch_done" );

    for (;;)
    {
        var_0 = undefined;

        if ( !level.firstzoneactive )
        {
            level.firstzoneactive = 1;
            var_0 = level.grnd_zone.origin;
        }
        else
        {
            var_0 = getnextzone();
            stopfxontag( level.grnd_fx["smoke"], level.grnd_zone, "tag_fx" );
            wait 0.05;
        }

        var_1 = var_0 + ( 0, 0, 30 );
        var_2 = var_0 + ( 0, 0, -1000 );
        var_3 = bullettrace( var_1, var_2, 0, level.grnd_zone );
        level.grnd_zone.origin = var_3["position"] + ( 0, 0, 1 );
        var_4 = var_3["entity"];

        if ( isdefined( var_4 ) )
        {
            for ( var_5 = var_4 getlinkedparent(); isdefined( var_5 ); var_5 = var_4 getlinkedparent() )
                var_4 = var_5;
        }

        if ( isdefined( var_4 ) )
            level.grnd_zone linkto( var_4 );
        else if ( level.grnd_zone islinked() )
            level.grnd_zone unlink();

        level._ID36704 = level.grnd_zone.origin;
        level._ID36760 = level.grnd_zone.origin;
        level.grnd_dangercenter.origin = level.grnd_zone.origin;
        thread spawnregionvfx( level.grnd_zone.ringvfx, var_3["position"], vectortoangles( var_3["normal"] ), 0.5 );
        wait 0.05;
        playfxontag( level.grnd_fx["smoke"], level.grnd_zone, "tag_fx" );

        foreach ( var_7 in level.players )
            var_7.grnd_fx_playing = 1;

        if ( level.matchrules_droptime )
            level thread randomdrops();

        level.grnd_hud["timerDisplay"].label = &"MP_NEXT_DROP_ZONE_IN";
        level.grnd_hud["timerDisplay"] settimer( level.matchrules_zoneswitchtime );
        level.grnd_hud["timerDisplay"].alpha = 1;
        maps\mp\gametypes\_hostmigration::_ID35597( level.matchrules_zoneswitchtime );
        level.grnd_hud["timerDisplay"].alpha = 0;
        maps\mp\_utility::_ID24645( "mp_dropzone_obj_new" );

        foreach ( var_7 in level.players )
        {
            if ( isai( var_7 ) )
                var_7 thread maps\mp\bots\_bots_gametype_grnd::bot_grnd_think();
        }
    }
}

_ID30883( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( level.grnd_targetfx ) )
        level.grnd_targetfx delete();

    wait(var_3);
    level.grnd_targetfx = spawnfx( level.grnd_targetfxid, var_0, var_1, var_2 );
    triggerfx( level.grnd_targetfx );
}

spawnregionvfx( var_0, var_1, var_2, var_3 )
{
    stopfxontag( level.grnd_targetfxid, var_0, "tag_origin" );
    wait(var_3);
    var_0.origin = var_1;
    var_0.angles = var_2;
    playfxontag( level.grnd_targetfxid, var_0, "tag_origin" );
}

grndtracking()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( !isdefined( self.team ) )
        return;

    for (;;)
    {
        if ( !isdefined( self.grnd_wasspectator ) )
            self.grnd_wasspectator = 0;

        if ( !self.grnd_wasspectator && self.pers["team"] == "spectator" )
        {
            self.ingrindzone = 0;
            self.ingrindzonepoints = 0;
            self.grndheadicon.alpha = 0;
            self.grnd_wasspectator = 1;
        }
        else if ( self.team != "spectator" )
        {
            if ( ( self.grnd_wasspectator || !self.ingrindzone ) && isingrindzone() )
            {
                self.ingrindzone = 1;
                self.ingrindzonepoints = 0;
                self iprintlnbold( &"OBJECTIVES_GRND_CONFIRM" );
                self.grndheadicon.alpha = 0;
            }
            else if ( ( self.grnd_wasspectator || self.ingrindzone ) && !isingrindzone() )
            {
                self.ingrindzone = 0;
                self.ingrindzonepoints = 0;
                self iprintlnbold( &"OBJECTIVES_GRND_HINT" );
                self.grndheadicon.alpha = 0.85;
            }

            self.grnd_wasspectator = 0;
        }

        wait 0.05;
    }
}

locationstatus()
{
    level endon( "game_ended" );
    level.grnd_numplayers["axis"] = 0;
    level.grnd_numplayers["allies"] = 0;
    maps\mp\_utility::gameflagwait( "prematch_done" );

    for (;;)
    {
        level.grnd_numplayers["axis"] = 0;
        level.grnd_numplayers["allies"] = 0;

        foreach ( var_1 in level.players )
        {
            if ( isdefined( var_1.ingrindzone ) && maps\mp\_utility::_ID18757( var_1 ) && var_1.pers["team"] != "spectator" && var_1 isingrindzone() )
                level.grnd_numplayers[var_1.pers["team"]]++;
        }

        foreach ( var_1 in level.players )
        {
            if ( isdefined( var_1.ingrindzone ) && var_1.pers["team"] != "spectator" )
            {
                if ( level.grnd_numplayers["axis"] == level.grnd_numplayers["allies"] )
                {
                    var_1.grndheadicon setshader( "waypoint_captureneutral_b", 14, 14 );
                    var_1.grndheadicon setwaypoint( 0, 1, 0, 0 );
                    objective_icon( var_1.grndobjid, "waypoint_captureneutral_b" );
                    continue;
                }

                if ( level.grnd_numplayers[var_1.pers["team"]] > level.grnd_numplayers[level._ID23070[var_1.pers["team"]]] )
                {
                    var_1.grndheadicon setshader( "waypoint_defend_b", 14, 14 );
                    var_1.grndheadicon setwaypoint( 0, 1, 0, 0 );
                    objective_icon( var_1.grndobjid, "waypoint_defend_b" );
                    continue;
                }

                var_1.grndheadicon setshader( "waypoint_capture_b", 14, 14 );
                var_1.grndheadicon setwaypoint( 0, 1, 0, 0 );
                objective_icon( var_1.grndobjid, "waypoint_capture_b" );
            }
        }

        wait 0.5;
    }
}

locationscoring()
{
    level endon( "game_ended" );
    maps\mp\_utility::gameflagwait( "prematch_done" );
    var_0 = maps\mp\gametypes\_rank::_ID15328( "zone_tick" );

    for (;;)
    {
        foreach ( var_2 in level.players )
        {
            if ( isdefined( var_2.ingrindzone ) && maps\mp\_utility::_ID18757( var_2 ) && var_2.pers["team"] != "spectator" && var_2 isingrindzone() )
            {
                var_2.ingrindzonepoints = var_2.ingrindzonepoints + var_0;
                maps\mp\gametypes\_gamescore::_ID15616( "zone_tick", var_2, undefined, 0, 1 );

                if ( isai( var_2 ) )
                    continue;

                var_2._ID36476 = 0;
                var_2 thread maps\mp\gametypes\_rank::_ID36471( 20 );
            }
        }

        if ( level.grnd_numplayers["axis"] )
            maps\mp\gametypes\_gamescore::giveteamscoreforobjective( "axis", var_0 * level.grnd_numplayers["axis"] );

        if ( level.grnd_numplayers["allies"] )
            maps\mp\gametypes\_gamescore::giveteamscoreforobjective( "allies", var_0 * level.grnd_numplayers["allies"] );

        maps\mp\gametypes\_hostmigration::_ID35597( 1.0 );
    }
}

randomdrops()
{
    level endon( "game_ended" );
    level notify( "reset_grnd_drops" );
    level endon( "reset_grnd_drops" );
    level.grnd_previouscratetypes = [];

    for (;;)
    {
        var_0 = getbestplayer();
        var_1 = 1;

        if ( isdefined( var_0 ) && maps\mp\_utility::_ID8679() < maps\mp\_utility::maxvehiclesallowed() && level._ID12791 + var_1 < maps\mp\_utility::maxvehiclesallowed() && level.numdropcrates < 8 )
        {
            var_0 thread maps\mp\gametypes\_rank::_ID36462( "earned_care_package" );
            var_0 thread maps\mp\gametypes\_hud_message::_ID31054( "callout_earned_carepackage" );
            var_0 thread maps\mp\_utility::_ID19760( level._ID23070[var_0.team] + "_enemy_airdrop_assault_inbound", level._ID23070[var_0.team] );
            var_0 thread maps\mp\_utility::_ID19760( var_0.team + "_friendly_airdrop_assault_inbound", var_0.team );
            maps\mp\_utility::_ID24645( "mp_dropzone_obj_taken", var_0.team );
            maps\mp\_utility::_ID24645( "mp_dropzone_obj_lost", level._ID23070[var_0.team] );
            var_2 = level.grnd_zone.origin + ( randomintrange( -50, 50 ), randomintrange( -50, 50 ), 0 );
            var_3 = getdropzonecratetype();

            if ( issubstr( tolower( var_3 ), "juggernaut" ) )
                level thread maps\mp\killstreaks\_airdrop::_ID10336( var_0, var_2, randomfloat( 360 ), var_3 );
            else if ( var_3 == "mega" )
                level thread maps\mp\killstreaks\_airdrop::domegac130flyby( var_0, var_2, randomfloat( 360 ), "airdrop_grnd", -360 );
            else
            {
                maps\mp\_utility::_ID17543();
                level thread maps\mp\killstreaks\_airdrop::_ID10390( var_0, var_2, randomfloat( 360 ), "airdrop_grnd", 0, var_3 );
            }

            var_4 = level.matchrules_droptime;
        }
        else
            var_4 = 0.5;

        maps\mp\gametypes\_hostmigration::_ID35597( var_4 );
    }
}

getbestplayer()
{
    var_0 = undefined;
    var_1 = 0;

    foreach ( var_3 in level.players )
    {
        if ( maps\mp\_utility::_ID18757( var_3 ) && var_3.pers["team"] != "spectator" )
        {
            if ( var_3 isingrindzone() && var_3.ingrindzonepoints > var_1 )
            {
                var_0 = var_3;
                var_1 = var_3.ingrindzonepoints;
            }
        }
    }

    return var_0;
}

getdropzonecratetype()
{
    var_0 = undefined;

    if ( !isdefined( level.grnd_previouscratetypes["mega"] ) && level.numdropcrates == 0 && randomintrange( 0, 100 ) < 5 )
        var_0 = "mega";
    else
    {
        if ( level.grnd_previouscratetypes.size )
        {
            for ( var_1 = 200; var_1; var_1-- )
            {
                var_0 = maps\mp\killstreaks\_airdrop::getrandomcratetype( "airdrop_grnd" );

                if ( isdefined( level.grnd_previouscratetypes[var_0] ) )
                {
                    var_0 = undefined;
                    continue;
                }

                break;
            }
        }

        if ( !isdefined( var_0 ) )
            var_0 = maps\mp\killstreaks\_airdrop::getrandomcratetype( "airdrop_grnd" );
    }

    level.grnd_previouscratetypes[var_0] = 1;

    if ( level.grnd_previouscratetypes.size == 15 )
        level.grnd_previouscratetypes = [];

    return var_0;
}

isingrindzone()
{
    if ( distance2d( level.grnd_zone.origin, self.origin ) < 300 && self.origin[2] > level.grnd_zone.origin[2] - 50 )
        return 1;
    else
        return 0;
}

hidehudelementongameend( var_0 )
{
    level waittill( "game_ended" );

    if ( isdefined( var_0 ) )
        var_0.alpha = 0;
}

createzones()
{
    level.grnd_dropzones = [];
    level.grnd_dropzones1 = [];
    level.grnd_dropzones2 = [];
    var_0 = common_scripts\utility::_ID15386( "sotf_chest_spawnpoint", "targetname" );

    if ( getdvar( "mapname" ) == "mp_strikezone" )
    {
        var_1 = [];
        var_2 = [];

        foreach ( var_4 in var_0 )
        {
            if ( var_4.origin[2] > 10000 )
            {
                level.grnd_dropzones2[level.grnd_dropzones2.size] = var_4;
                continue;
            }

            level.grnd_dropzones1[level.grnd_dropzones1.size] = var_4;
        }
    }
    else
    {
        foreach ( var_4 in var_0 )
            level.grnd_dropzones[level.grnd_dropzones.size] = var_4;
    }

    adjustzones();
}

adjustzones()
{
    var_0 = tolower( getdvar( "mapname" ) );

    if ( var_0 == "mp_strikezone" )
    {
        level.grnd_dropzones1[level.grnd_dropzones1.size] = spawnstruct();
        level.grnd_dropzones1[level.grnd_dropzones1.size - 1].origin = ( -121, -1334, -73 );
    }

    if ( var_0 == "mp_flooded" )
    {
        foreach ( var_2 in level.grnd_dropzones )
        {
            if ( var_2.origin == ( -1596.9, 1315.7, 374.1 ) )
                var_2.origin = ( -1561, 1278, 431 );
        }
    }

    if ( var_0 == "mp_zebra" )
    {
        foreach ( var_2 in level.grnd_dropzones )
        {
            if ( var_2.origin == ( 4008.3, -2066.3, 482.1 ) )
                var_2.origin = ( 4048, -1985, 539 );
        }
    }

    if ( issubstr( var_0, "descent" ) )
    {
        foreach ( var_2 in level.grnd_dropzones )
        {
            if ( var_2.origin == ( 1101, 116, 5373.1 ) )
                var_2.origin = ( 1072, -80, 5378 );
        }
    }
}
