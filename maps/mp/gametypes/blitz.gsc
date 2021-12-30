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
        maps\mp\_utility::_ID25717( level._ID14086, 16 );
        maps\mp\_utility::_ID25718( level._ID14086, 5 );
        maps\mp\_utility::_ID25714( level._ID14086, 2 );
        maps\mp\_utility::_ID25715( level._ID14086, 1, 0, 1 );
        maps\mp\_utility::_ID25724( level._ID14086, 0 );
        maps\mp\_utility::_ID25712( level._ID14086, 0 );
        level._ID20676 = 0;
    }

    level._ID32653 = 1;
    level._ID22489 = 0;
    level._ID32096 = 0;
    level._ID22905 = ::_ID22905;
    level.getspawnpoint = ::getspawnpoint;
    level._ID22913 = ::_ID22913;
    level._ID22869 = ::_ID22869;
    level._ID22886 = ::_ID22886;
    level._ID22902 = ::_ID22902;
    level._ID17937 = ::_ID17937;
    level.spawnnodetype = common_scripts\utility::_ID32831( getdvarint( "scr_altBlitzSpawns", 0 ) == 1, "mp_tdm_spawn", "mp_blitz_spawn" );

    if ( level._ID20676 )
        level._ID21286 = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    game["dialog"]["gametype"] = "blitz";

    if ( getdvarint( "g_hardcore" ) )
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];

    game["dialog"]["offense_obj"] = "bltz_hint";
    game["dialog"]["defense_obj"] = "bltz_hint";
    game["dialog"]["bltz_e_scored"] = "bltz_e_scored";
    game["dialog"]["bltz_scored"] = "bltz_scored";
}

initializematchrules()
{
    maps\mp\_utility::_ID28682();
    setdynamicdvar( "scr_blitz_roundswitch", 1 );
    maps\mp\_utility::_ID25715( "blitz", 1, 0, 1 );
    setdynamicdvar( "scr_blitz_roundlimit", 2 );
    maps\mp\_utility::_ID25714( "blitz", 2 );
    setdynamicdvar( "scr_blitz_winlimit", 0 );
    maps\mp\_utility::_ID25724( "blitz", 0 );
    setdynamicdvar( "scr_blitz_promode", 0 );
}

_ID17932()
{
    level._ID1644["portal_fx_defend"] = loadfx( "vfx/gameplay/mp/core/vfx_marker_base_cyan" );
    level._ID1644["portal_fx_goal"] = loadfx( "vfx/gameplay/mp/core/vfx_marker_base_orange" );
    level._ID1644["portal_fx_closed"] = loadfx( "vfx/gameplay/mp/core/vfx_marker_base_grey" );
    level._ID1644["blitz_teleport"] = loadfx( "vfx/gameplay/mp/core/vfx_teleport_player" );
}

_ID22905()
{
    maps\mp\_utility::_ID28804( "allies", &"OBJECTIVES_BLITZ" );
    maps\mp\_utility::_ID28804( "axis", &"OBJECTIVES_BLITZ" );

    if ( level.splitscreen )
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_BLITZ" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_BLITZ" );
    }
    else
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_BLITZ_ATTACKER_SCORE" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_BLITZ_ATTACKER_SCORE" );
    }

    maps\mp\_utility::setobjectivehinttext( "allies", &"OBJECTIVES_BLITZ_HINT" );
    maps\mp\_utility::setobjectivehinttext( "axis", &"OBJECTIVES_BLITZ_HINT" );
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

    initspawns();
    _ID17932();
    var_2[0] = level._ID14086;
    maps\mp\gametypes\_gameobjects::_ID20445( var_2 );
    createportals();
    level thread _ID22877();
    assignteamspawns();
    level thread _ID27015();
}

_ID22877()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 _ID38035();
        var_0 thread _ID37867();
        var_0 thread onplayerspawned();
    }
}

onplayerspawned()
{
    self waittill( "spawned_player" );
    _ID29990();
    thread _ID25661();
    thread refreshspectatorportalfx();
    thread _ID7486();
}

initspawns()
{
    level._ID30895 = ( 0, 0, 0 );
    level._ID30893 = ( 0, 0, 0 );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_blitz_spawn_axis_start" );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_blitz_spawn_allies_start" );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", level.spawnnodetype );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", level.spawnnodetype );
    level._ID20634 = maps\mp\gametypes\_spawnlogic::findboxcenter( level._ID30895, level._ID30893 );
    setmapcenter( level._ID20634 );
}

createportals()
{
    level._ID24743 = [];

    if ( game["switchedsides"] )
    {
        var_0 = getent( "allies_portal", "targetname" );
        var_1 = getent( "axis_portal", "targetname" );
    }
    else
    {
        var_0 = getent( "axis_portal", "targetname" );
        var_1 = getent( "allies_portal", "targetname" );
    }

    level._ID24742["axis"] = createportal( var_0, "axis" );
    level._ID24742["allies"] = createportal( var_1, "allies" );
}

createportal( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2.origin = var_0.origin;
    var_2._ID23192 = var_1;
    var_2._ID22927 = 1;
    var_2.guarded = 0;
    var_2.trigger = var_0;

    if ( isdefined( level.matchrecording_generateid ) && isdefined( level.matchrecording_logevent ) )
    {
        if ( !isdefined( game["blitzPortalLogIDs"] ) )
            game["blitzPortalLogIDs"] = [];

        if ( !isdefined( game["blitzPortalLogIDs"][var_1] ) )
            game["blitzPortalLogIDs"][var_1] = [[ level.matchrecording_generateid ]]();

        var_3 = common_scripts\utility::_ID32831( var_1 == "allies", 0, 1 );
        [[ level.matchrecording_logevent ]]( game["blitzPortalLogIDs"][var_1], undefined, "PORTAL", var_2.origin[0], var_2.origin[1], gettime(), var_3 );
    }

    return var_2;
}

assignteamspawns()
{
    var_0 = maps\mp\gametypes\_spawnlogic::_ID15350( level.spawnnodetype );
    var_1 = maps\mp\gametypes\_spawnlogic::_ID18728();
    level._ID32679["axis"] = [];
    level._ID32679["allies"] = [];
    level._ID32679["neutral"] = [];

    if ( getdvarint( "scr_altBlitzSpawns", 0 ) == 1 && level._ID24742.size == 2 )
    {
        var_2 = level._ID24742["allies"];
        var_3 = level._ID24742["axis"];
        var_4 = ( var_2.origin[0], var_2.origin[1], 0 );
        var_5 = ( var_3.origin[0], var_3.origin[1], 0 );
        var_6 = var_5 - var_4;
        var_7 = length2d( var_6 );

        foreach ( var_9 in var_0 )
        {
            var_10 = ( var_9.origin[0], var_9.origin[1], 0 );
            var_11 = var_10 - var_4;
            var_12 = vectordot( var_11, var_6 );
            var_13 = var_12 / var_7 * var_7;

            if ( var_13 < 0.33 )
            {
                var_9._ID32652 = var_2._ID23192;
                level._ID32679[var_9._ID32652][level._ID32679[var_9._ID32652].size] = var_9;
                continue;
            }

            if ( var_13 > 0.67 )
            {
                var_9._ID32652 = var_3._ID23192;
                level._ID32679[var_9._ID32652][level._ID32679[var_9._ID32652].size] = var_9;
                continue;
            }

            var_14 = undefined;
            var_15 = undefined;

            if ( var_1 )
                var_14 = getpathdist( var_9.origin, var_2.origin, 999999 );

            if ( isdefined( var_14 ) && var_14 != -1 )
                var_15 = getpathdist( var_9.origin, var_3.origin, 999999 );

            if ( !isdefined( var_15 ) || var_15 == -1 )
            {
                var_14 = distance2d( var_2.origin, var_9.origin );
                var_15 = distance2d( var_3.origin, var_9.origin );
            }

            var_16 = max( var_14, var_15 );
            var_17 = min( var_14, var_15 );
            var_18 = var_17 / var_16;

            if ( var_18 > 0.5 )
                level._ID32679["neutral"][level._ID32679["neutral"].size] = var_9;
        }
    }
    else
    {
        foreach ( var_9 in var_0 )
        {
            var_9._ID32652 = _ID15163( var_9 );

            if ( var_9._ID32652 == "axis" )
            {
                level._ID32679["axis"][level._ID32679["axis"].size] = var_9;
                continue;
            }

            level._ID32679["allies"][level._ID32679["allies"].size] = var_9;
        }
    }
}

_ID15163( var_0 )
{
    var_1 = maps\mp\gametypes\_spawnlogic::_ID18728();
    var_2 = undefined;
    var_3 = undefined;

    foreach ( var_5 in level._ID24742 )
    {
        var_6 = undefined;

        if ( var_1 )
            var_6 = getpathdist( var_0.origin, var_5.origin, 999999 );

        if ( !isdefined( var_6 ) || var_6 == -1 )
            var_6 = distancesquared( var_5.origin, var_0.origin );

        if ( !isdefined( var_2 ) || var_6 < var_3 )
        {
            var_2 = var_5;
            var_3 = var_6;
        }
    }

    return var_2._ID23192;
}

_ID22869( var_0, var_1, var_2 )
{
    var_1 thread maps\mp\gametypes\_rank::_ID36462( "kill" );
}

_ID27015()
{
    _ID31468( level._ID24742["axis"] );
    _ID31468( level._ID24742["allies"] );
}

_ID31468( var_0 )
{
    level thread _ID27043( var_0 );
    level thread runportalstatus( var_0 );
    level thread _ID27045( var_0 );
}

_ID27043( var_0 )
{
    level endon( "final_score_teleport" );
    level endon( "halftime_score_teleport" );
    level endon( "time_ended" );
    level endon( "force_end" );
    var_1 = blitzgetteam( var_0 );
    var_0 childthread _ID22891( var_1 );
    var_0 childthread _ID22890( var_1 );
}

_ID22891( var_0 )
{
    for (;;)
    {
        level waittill( "portal_used",  var_1  );

        if ( var_1 != var_0 )
            continue;

        _ID16906( var_0 );
        showclosedportalfx( var_0 );
    }
}

_ID22890( var_0 )
{
    for (;;)
    {
        level waittill( "portal_ready",  var_1  );

        if ( var_1 != var_0 )
            continue;

        if ( !self._ID22927 )
            continue;

        _ID16898( var_0 );
        _ID29984( var_0 );
    }
}

_ID16906( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( !isdefined( var_2 ) || !isdefined( var_2.team ) )
            continue;

        if ( var_2.team == "allies" || var_2.team == "axis" )
        {
            if ( var_2.team == var_0 )
            {
                if ( isdefined( var_2._ID9432 ) )
                    var_2._ID9432 delete();
            }
            else if ( isdefined( var_2.goal_fx_ent ) )
                var_2.goal_fx_ent delete();

            continue;
        }

        var_3 = var_2 ismlgspectator();

        if ( var_3 && var_0 == var_2 getmlgspectatorteam() || !var_3 && var_0 == "allies" )
        {
            if ( isdefined( var_2._ID9432 ) )
                var_2._ID9432 delete();
        }
        else if ( isdefined( var_2.goal_fx_ent ) )
            var_2.goal_fx_ent delete();
    }
}

_ID29984( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( !isdefined( var_2 ) || !isdefined( var_2.team ) )
            continue;

        if ( var_2.team == "allies" || var_2.team == "axis" )
        {
            if ( var_2.team == var_0 )
            {
                if ( !isdefined( var_2._ID9432 ) )
                {
                    var_2._ID9432 = spawnfxforclient( level._ID1644["portal_fx_defend"], self.origin, var_2 );
                    triggerfx( var_2._ID9432 );
                }
            }
            else if ( !isdefined( var_2.goal_fx_ent ) )
            {
                var_2.goal_fx_ent = spawnfxforclient( level._ID1644["portal_fx_goal"], self.origin, var_2 );
                triggerfx( var_2.goal_fx_ent );
            }

            continue;
        }

        var_3 = var_2 ismlgspectator();

        if ( var_3 && var_0 == var_2 getmlgspectatorteam() || !var_3 && var_0 == "allies" )
        {
            if ( !isdefined( var_2._ID9432 ) )
            {
                var_2._ID9432 = spawnfxforclient( level._ID1644["portal_fx_defend"], self.origin, var_2 );
                triggerfx( var_2._ID9432 );
            }
        }
        else if ( !isdefined( var_2.goal_fx_ent ) )
        {
            var_2.goal_fx_ent = spawnfxforclient( level._ID1644["portal_fx_goal"], self.origin, var_2 );
            triggerfx( var_2.goal_fx_ent );
        }
    }
}

_ID16898( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( !isdefined( var_2 ) || !isdefined( var_2.team ) )
            continue;

        if ( var_2.team == "allies" || var_2.team == "axis" )
        {
            if ( var_2.team == var_0 )
            {
                if ( isdefined( var_2.closed_defend_fx_ent ) )
                    var_2.closed_defend_fx_ent delete();
            }
            else if ( isdefined( var_2._ID7566 ) )
                var_2._ID7566 delete();

            continue;
        }

        var_3 = var_2 ismlgspectator();

        if ( var_3 && var_0 == var_2 getmlgspectatorteam() || !var_3 && var_0 == "allies" )
        {
            if ( isdefined( var_2.closed_defend_fx_ent ) )
                var_2.closed_defend_fx_ent delete();
        }
        else if ( isdefined( var_2._ID7566 ) )
            var_2._ID7566 delete();
    }
}

showclosedportalfx( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( !isdefined( var_2 ) || !isdefined( var_2.team ) )
            continue;

        if ( var_2.team == "allies" || var_2.team == "axis" )
        {
            if ( var_2.team == var_0 )
            {
                if ( !isdefined( var_2.closed_defend_fx_ent ) )
                {
                    var_2.closed_defend_fx_ent = spawnfxforclient( level._ID1644["portal_fx_closed"], self.origin, var_2 );
                    triggerfx( var_2.closed_defend_fx_ent );
                }
            }
            else if ( !isdefined( var_2._ID7566 ) )
            {
                var_2._ID7566 = spawnfxforclient( level._ID1644["portal_fx_closed"], self.origin, var_2 );
                triggerfx( var_2._ID7566 );
            }

            continue;
        }

        var_3 = var_2 ismlgspectator();

        if ( var_3 && var_0 == var_2 getmlgspectatorteam() || !var_3 && var_0 == "allies" )
        {
            if ( !isdefined( var_2.closed_defend_fx_ent ) )
            {
                var_2.closed_defend_fx_ent = spawnfxforclient( level._ID1644["portal_fx_closed"], self.origin, var_2 );
                triggerfx( var_2.closed_defend_fx_ent );
            }
        }
        else if ( !isdefined( var_2._ID7566 ) )
        {
            var_2._ID7566 = spawnfxforclient( level._ID1644["portal_fx_closed"], self.origin, var_2 );
            triggerfx( var_2._ID7566 );
        }
    }
}

_ID25661()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "joined_team" );
        _ID29990();
    }
}

refreshspectatorportalfx()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "joined_spectators" );
        _ID38035();
    }
}

_ID37867()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "luinotifyserver",  var_0, var_1  );

        if ( var_0 == "mlg_view_change" )
            _ID38035();
    }
}

_ID7486()
{
    self waittill( "disconnect" );
    clearportalfx();
}

_ID29990()
{
    if ( self.team != "allies" && self.team != "axis" )
        return;

    var_0 = self.team;
    var_1 = maps\mp\_utility::getotherteam( var_0 );
    clearportalfx();

    if ( isdefined( level._ID24742[var_0] ) && isdefined( level._ID24742[var_1] ) )
    {
        if ( level._ID24742[var_0]._ID22927 && !level._ID24742[var_0].guarded )
        {
            self._ID9432 = spawnfxforclient( level._ID1644["portal_fx_defend"], level._ID24742[var_0].origin, self );
            triggerfx( self._ID9432 );
        }
        else
        {
            self.closed_defend_fx_ent = spawnfxforclient( level._ID1644["portal_fx_closed"], level._ID24742[var_0].origin, self );
            triggerfx( self.closed_defend_fx_ent );
        }

        if ( level._ID24742[var_1]._ID22927 && !level._ID24742[var_1].guarded )
        {
            self.goal_fx_ent = spawnfxforclient( level._ID1644["portal_fx_goal"], level._ID24742[var_1].origin, self );
            triggerfx( self.goal_fx_ent );
        }
        else
        {
            self._ID7566 = spawnfxforclient( level._ID1644["portal_fx_closed"], level._ID24742[var_1].origin, self );
            triggerfx( self._ID7566 );
        }
    }
}

_ID38035()
{
    clearportalfx();
    var_0 = "allies";
    var_1 = "axis";
    var_2 = self ismlgspectator();

    if ( var_2 )
    {
        var_0 = self getmlgspectatorteam();
        var_1 = maps\mp\_utility::getotherteam( var_0 );
    }

    if ( isdefined( level._ID24742[var_0] ) && isdefined( level._ID24742[var_1] ) )
    {
        if ( level._ID24742[var_0]._ID22927 && !level._ID24742[var_0].guarded )
        {
            self._ID9432 = spawnfxforclient( level._ID1644["portal_fx_defend"], level._ID24742[var_0].origin, self );
            triggerfx( self._ID9432 );
        }
        else
        {
            self.closed_defend_fx_ent = spawnfxforclient( level._ID1644["portal_fx_closed"], level._ID24742[var_0].origin, self );
            triggerfx( self.closed_defend_fx_ent );
        }

        if ( level._ID24742[var_1]._ID22927 && !level._ID24742[var_1].guarded )
        {
            self.goal_fx_ent = spawnfxforclient( level._ID1644["portal_fx_goal"], level._ID24742[var_1].origin, self );
            triggerfx( self.goal_fx_ent );
        }
        else
        {
            self._ID7566 = spawnfxforclient( level._ID1644["portal_fx_closed"], level._ID24742[var_1].origin, self );
            triggerfx( self._ID7566 );
        }
    }
}

clearportalfx()
{
    if ( isdefined( self._ID9432 ) )
        self._ID9432 delete();

    if ( isdefined( self.closed_defend_fx_ent ) )
        self.closed_defend_fx_ent delete();

    if ( isdefined( self.goal_fx_ent ) )
        self.goal_fx_ent delete();

    if ( isdefined( self._ID7566 ) )
        self._ID7566 delete();
}

runportalstatus( var_0, var_1 )
{
    level endon( "final_score_teleport" );
    level endon( "halftime_score_teleport" );
    level endon( "time_ended" );
    level endon( "force_end" );
    var_2 = ( 0, 0, 72 );
    var_3 = blitzgetteam( var_0 );
    var_4 = maps\mp\_utility::getotherteam( var_3 );
    var_0.ownerteamid = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_0.ownerteamid, "active", var_0.origin + var_2, "waypoint_blitz_defend" );
    objective_team( var_0.ownerteamid, var_3 );
    var_0.enemyteamid = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_0.enemyteamid, "active", var_0.origin + var_2, "waypoint_blitz_goal" );
    objective_team( var_0.enemyteamid, var_4 );

    for (;;)
    {
        if ( var_0._ID22927 )
        {
            var_0.teamheadicon = var_0 maps\mp\_entityheadicons::setheadicon( var_3, "waypoint_blitz_defend", var_2, 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
            var_0._ID12055 = var_0 maps\mp\_entityheadicons::setheadicon( var_4, "waypoint_blitz_goal", var_2, 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
            objective_icon( var_0.ownerteamid, "waypoint_blitz_defend" );
            objective_icon( var_0.enemyteamid, "waypoint_blitz_goal" );
        }
        else if ( !isdefined( var_0._ID35583 ) || !var_0._ID35583 )
        {
            var_0._ID35583 = 1;
            var_0 childthread _ID25662( var_0, var_3, var_4, var_2 );
        }

        level common_scripts\utility::_ID35626( "portal_used", "portal_ready" );
    }
}

_ID25662( var_0, var_1, var_2, var_3 )
{
    var_4 = 10;

    for ( var_5 = var_4; var_5 > 0; var_5-- )
    {
        if ( var_5 == var_4 )
        {
            var_0.teamheadicon = var_0 maps\mp\_entityheadicons::setheadicon( var_1, "blitz_time_" + var_5 + "_blue", var_3, 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
            objective_icon( var_0.ownerteamid, "blitz_time_" + var_5 + "_blue" );
        }
        else
        {
            var_0.teamheadicon = var_0 maps\mp\_entityheadicons::setheadicon( var_1, "blitz_time_0" + var_5 + "_blue", var_3, 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
            objective_icon( var_0.ownerteamid, "blitz_time_0" + var_5 + "_blue" );
        }

        if ( var_5 == var_4 )
        {
            var_0._ID12055 = var_0 maps\mp\_entityheadicons::setheadicon( var_2, "blitz_time_" + var_5 + "_orng", var_3, 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
            objective_icon( var_0.enemyteamid, "blitz_time_" + var_5 + "_orng" );
        }
        else
        {
            var_0._ID12055 = var_0 maps\mp\_entityheadicons::setheadicon( var_2, "blitz_time_0" + var_5 + "_orng", var_3, 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
            objective_icon( var_0.enemyteamid, "blitz_time_0" + var_5 + "_orng" );
        }

        maps\mp\gametypes\_hostmigration::_ID35597( 1 );
    }

    var_0._ID35583 = 0;
}

_ID27045( var_0 )
{
    level endon( "final_score_teleport" );
    level endon( "halftime_score_teleport" );
    level endon( "time_ended" );
    level endon( "force_end" );
    var_1 = blitzgetteam( var_0 );
    var_2 = getdvarfloat( "scr_blitz_scoredelay", 10 );
    var_0 childthread guardwatch( var_1 );

    for (;;)
    {
        var_0.trigger waittill( "trigger",  var_3  );

        if ( _ID38246( var_3, var_0, var_1 ) )
        {
            var_0._ID22927 = 0;
            level notify( "portal_used",  var_1  );
            _ID37806( var_3, var_0, var_1 );
            maps\mp\gametypes\_hostmigration::_ID35597( var_2 );
            var_0._ID22927 = 1;
            level notify( "portal_ready",  var_1  );
        }
    }
}

_ID38246( var_0, var_1, var_2 )
{
    if ( !isplayer( var_0 ) )
        return 0;

    if ( var_0.team == var_2 || var_0.team == "spectator" )
        return 0;

    if ( checkguardedportal( var_1, var_2 ) )
        return 0;

    if ( var_0 islinked() )
        return 0;

    if ( isdefined( var_0._ID18582 ) && var_0._ID18582 )
        return 0;

    return 1;
}

_ID37806( var_0, var_1, var_2 )
{
    maps\mp\_utility::_ID19760( "bltz_e_scored", var_2 );
    maps\mp\_utility::_ID19760( "bltz_scored", maps\mp\_utility::getotherteam( var_2 ) );
    maps\mp\gametypes\_gamescore::_ID15616( "capture", var_0 );
    var_0 thread maps\mp\gametypes\_rank::giverankxp( "capture" );
    var_0 maps\mp\killstreaks\_killstreaks::_ID15579( "capture" );
    _ID15635( var_0.team );
    var_0 maps\mp\_utility::_ID17531( "pointscaptured", 1 );
    var_0 maps\mp\_utility::_ID17529( "captures", 1 );
    var_0 maps\mp\gametypes\_persistence::_ID31528( "round", "captures", var_0.pers["captures"] );
    var_0 maps\mp\gametypes\_missions::_ID25038( "ch_blitz_score" );

    if ( var_0 maps\mp\gametypes\_missions::playerissprintsliding() )
        var_0 maps\mp\gametypes\_missions::_ID25038( "ch_saafe" );

    if ( isdefined( var_0.stuckbygrenade ) && isdefined( var_0.stuckbygrenade.owner ) )
        var_0.stuckbygrenade.owner maps\mp\gametypes\_missions::_ID25038( "ch_telefragged" );

    var_0 maps\mp\_utility::setextrascore0( var_0.pers["captures"] );
    var_3 = var_0 getspawnpoint();
    var_0 thread _ID32765( var_3.origin, var_3.angles );
}

guardwatch( var_0 )
{
    for (;;)
    {
        if ( checkguardedportal( self, var_0 ) )
        {
            level notify( "portal_used",  var_0  );
            self.guarded = 1;
        }
        else
        {
            level notify( "portal_ready",  var_0  );
            self.guarded = 0;
        }

        common_scripts\utility::_ID35582();
    }
}

checkguardedportal( var_0, var_1 )
{
    foreach ( var_3 in level._ID23303 )
    {
        if ( !isdefined( var_3 ) || !isdefined( var_3.team ) )
            continue;

        if ( var_3.team == var_1 && isalive( var_3 ) && !isdefined( var_3.fauxdead ) )
        {
            if ( distancesquared( var_0.origin, var_3.origin ) < 4300 )
                return 1;
        }
    }

    return 0;
}

_ID15635( var_0 )
{
    maps\mp\gametypes\_gamescore::giveteamscoreforobjective( var_0, 1 );

    foreach ( var_2 in level.players )
    {
        var_3 = var_2.team;

        if ( var_2.team == "spectator" )
        {
            var_4 = var_2 getspectatingplayer();

            if ( isdefined( var_4 ) )
                var_3 = var_4.team;
            else
            {
                var_2 thread maps\mp\gametypes\_hud_message::_ID31054( "blitz_score_team" );
                continue;
            }
        }

        if ( var_3 == var_0 )
        {
            var_2 thread maps\mp\gametypes\_hud_message::_ID31054( "blitz_score_team" );
            continue;
        }

        var_2 thread maps\mp\gametypes\_hud_message::_ID31054( "blitz_score_enemy" );
    }
}

_ID32765( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self._ID32801 = 1;
    _ID7127();
    var_2 = 1;
    var_3 = create_client_overlay( "white", 1, self );
    var_3 thread _ID12615( 0, var_2 );
    var_3 thread huddelete( var_2 );
    var_4 = self gettagorigin( "j_SpineUpper" );
    playfx( level._ID1644["blitz_teleport"], var_4 );

    if ( isdefined( self.setspawnpoint ) )
        maps\mp\perks\_perkfunctions::deleteti( self.setspawnpoint );

    self cancelmantle();
    self setorigin( var_0 );
    self setplayerangles( var_1 );
    self setstance( "stand" );
    wait(var_2);
    self._ID32801 = 0;
}

create_client_overlay( var_0, var_1, var_2 )
{
    if ( isdefined( var_2 ) )
        var_3 = newclienthudelem( var_2 );
    else
        var_3 = newhudelem();

    var_3.x = 0;
    var_3.y = 0;
    var_3 setshader( var_0, 640, 480 );
    var_3.alignx = "left";
    var_3.aligny = "top";
    var_3.sort = 1;
    var_3.horzalign = "fullscreen";
    var_3.vertalign = "fullscreen";
    var_3.alpha = var_1;
    var_3.foreground = 1;
    return var_3;
}

_ID12615( var_0, var_1 )
{
    if ( isdefined( var_1 ) && var_1 > 0 )
        self fadeovertime( var_1 );

    self.alpha = var_0;

    if ( isdefined( var_1 ) && var_1 > 0 )
        wait(var_1);
}

huddelete( var_0 )
{
    self endon( "death" );
    wait(var_0);
    self destroy();
}

getspawnpoint()
{
    var_0 = blitzgetteam( self );
    var_1 = maps\mp\_utility::getotherteam( var_0 );

    if ( maps\mp\gametypes\_spawnlogic::_ID38029() )
    {
        if ( game["switchedsides"] )
        {
            var_2 = maps\mp\gametypes\_spawnlogic::_ID15350( "mp_blitz_spawn_" + var_1 + "_start" );
            var_3 = maps\mp\gametypes\_spawnlogic::_ID15349( var_2 );
        }
        else
        {
            var_2 = maps\mp\gametypes\_spawnlogic::_ID15350( "mp_blitz_spawn_" + var_0 + "_start" );
            var_3 = maps\mp\gametypes\_spawnlogic::_ID15349( var_2 );
        }
    }
    else
    {
        var_4 = level._ID32679["neutral"].size > 0;
        var_2 = maps\mp\gametypes\_spawnlogic::_ID15425( var_0 );
        var_3 = maps\mp\gametypes\_spawnscoring::_ID15342( var_2, var_0, var_4 );

        if ( !isdefined( var_3 ) && var_4 )
        {
            var_2 = maps\mp\gametypes\_spawnlogic::_ID15425( "neutral" );
            var_3 = maps\mp\gametypes\_spawnscoring::_ID15342( var_2, var_0, 0 );
        }
    }

    return var_3;
}

_ID22886( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isdefined( var_1 ) || !isplayer( var_1 ) )
        return;

    var_10 = self;
    var_11 = blitzgetteam( var_10 );
    var_12 = blitzgetteam( var_1 );

    if ( var_12 == var_11 )
        return;

    var_13 = level._ID24742[var_12].origin;
    var_14 = level._ID24742[var_11].origin;
    var_15 = 0;
    var_16 = 0;
    var_17 = 90000;

    if ( distance2dsquared( var_10.origin, var_13 ) < var_17 )
        var_16++;

    if ( distance2dsquared( var_10.origin, var_14 ) < var_17 )
        var_15++;

    if ( var_16 )
    {
        var_1 thread maps\mp\gametypes\_hud_message::_ID31052( "defend", maps\mp\gametypes\_rank::_ID15328( "defend" ) );
        var_1 maps\mp\_utility::_ID17529( "defends", 1 );
        var_1 thread maps\mp\gametypes\_rank::giverankxp( "defend" );
        maps\mp\gametypes\_gamescore::_ID15616( "defend", var_1 );
        var_1 maps\mp\gametypes\_missions::_ID25038( "ch_denied" );
        var_10 thread maps\mp\_matchdata::_ID20250( var_9, "assaulting" );
    }

    if ( var_15 )
    {
        var_1 thread maps\mp\gametypes\_hud_message::_ID31052( "assault", maps\mp\gametypes\_rank::_ID15328( "assault" ) );
        var_1 thread maps\mp\gametypes\_rank::giverankxp( "assault" );
        maps\mp\gametypes\_gamescore::_ID15616( "assault", var_1 );
        var_10 thread maps\mp\_matchdata::_ID20250( var_9, "defending" );
    }
}

blitzgetteam( var_0 )
{
    var_1 = var_0.team;

    if ( !isdefined( var_1 ) )
        var_1 = var_0._ID23192;

    return var_1;
}

_ID22913()
{
    level notify( "time_ended" );
    level.finalkillcam_winner = "none";

    if ( game["teamScores"]["axis"] == game["teamScores"]["allies"] )
        var_0 = "tie";
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

_ID7127()
{
    if ( game["switchedsides"] )
    {
        var_0 = getdvarint( "scr_blitz_scorelimit", 16 );

        if ( getteamscore( self.team ) == var_0 )
        {
            level notify( "final_score_teleport" );
            level.finalkillcam_winner = self.team;
            var_1 = maps\mp\_utility::getotherteam( self.team );

            if ( var_0 >= 16 && getteamscore( var_1 ) == 0 )
                maps\mp\gametypes\_missions::processchallengeforteam( "ch_lockdown", self.team );
        }
    }
    else
    {
        var_0 = getdvarint( "scr_blitz_scorelimit", 16 ) / 2;

        if ( getteamscore( self.team ) == var_0 )
        {
            level notify( "halftime_score_teleport" );
            level.finalkillcam_winner = self.team;
            thread maps\mp\gametypes\_gamelogic::endgame( "roundend", game["end_reason"]["score_limit_reached"] );

            if ( var_0 >= 8.0 )
                maps\mp\gametypes\_missions::processchallengeforteam( "ch_clocking", self.team );
        }
    }
}

_ID22902()
{
    self._ID32801 = 0;
    maps\mp\_utility::setextrascore0( 0 );

    if ( isdefined( self.pers["captures"] ) )
        maps\mp\_utility::setextrascore0( self.pers["captures"] );
}

_ID17937()
{
    maps\mp\_awards::_ID18002( "pointscaptured", 0, maps\mp\_awards::highestwins );
}
