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
        maps\mp\_utility::_ID25715( level._ID14086, 0, 0, 9 );
        maps\mp\_utility::_ID25718( level._ID14086, 10 );
        maps\mp\_utility::_ID25717( level._ID14086, 500 );
        maps\mp\_utility::_ID25714( level._ID14086, 1 );
        maps\mp\_utility::_ID25724( level._ID14086, 1 );
        maps\mp\_utility::_ID25712( level._ID14086, 0 );
        maps\mp\_utility::_ID25706( level._ID14086, 0 );
    }

    level._ID32653 = 1;
    level._ID22905 = ::_ID22905;
    level.getspawnpoint = ::getspawnpoint;
    level._ID22869 = ::_ID22869;
    level._ID22892 = ::_ID22892;
    level._ID22902 = ::_ID22902;
}

_ID22892()
{
    level.flagbasefxid["friendly"] = loadfx( "vfx/gameplay/mp/core/vfx_marker_base_cyan" );
}

initializematchrules()
{
    maps\mp\_utility::_ID28682();
    setdynamicdvar( "scr_grind_roundswitch", 0 );
    maps\mp\_utility::_ID25715( "grind", 0, 0, 9 );
    setdynamicdvar( "scr_grind_roundlimit", 1 );
    maps\mp\_utility::_ID25714( "grind", 1 );
    setdynamicdvar( "scr_grind_winlimit", 1 );
    maps\mp\_utility::_ID25724( "grind", 1 );
    setdynamicdvar( "scr_grind_halftime", 0 );
    maps\mp\_utility::_ID25706( "grind", 0 );
    setdynamicdvar( "scr_grind_promode", 0 );
}

_ID22905()
{
    setclientnamemode( "auto_change" );

    if ( !isdefined( game["switchedsides"] ) )
        game["switchedsides"] = 0;

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
    createtags();
    var_0[0] = level._ID14086;
    maps\mp\gametypes\_gameobjects::_ID20445( var_0 );
    createzones();
    level thread _ID22877();
    level thread _ID27069();
    level thread _ID37891();
}

_ID22902()
{
    if ( isdefined( self._ID32367 ) )
        self setclientomnvar( "ui_grind_tags", self._ID32367 );
}

createtags()
{
    level.dogtags = [];

    for ( var_0 = 0; var_0 < 50; var_0++ )
    {
        var_1 = spawn( "script_model", ( 0, 0, 0 ) );
        var_1 setmodel( "prop_dogtags_foe_iw6" );
        var_1._ID4860 = var_1.origin;
        var_1 scriptmodelplayanim( "mp_dogtag_spin" );
        var_1 hide();
        var_2 = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 32, 32 );
        var_2.targetname = "trigger_dogtag";
        var_2 hide();
        var_3 = spawnstruct();
        var_3.type = "useObject";
        var_3.curorigin = var_2.origin;
        var_3.entnum = var_2 getentitynumber();
        var_3._ID19663 = 0;
        var_3._ID35358 = var_1;
        var_3._ID22631 = ( 0, 0, 16 );
        var_3.trigger = var_2;
        var_3._ID33726 = "proximity";
        var_3 maps\mp\gametypes\_gameobjects::allowuse( "none" );
        level.dogtags[level.dogtags.size] = var_3;
    }
}

_ID15390()
{
    var_0 = level.dogtags[0];
    var_1 = gettime();

    foreach ( var_3 in level.dogtags )
    {
        if ( var_3._ID18086 == "none" )
        {
            var_0 = var_3;
            break;
        }

        if ( var_3._ID19663 < var_1 )
        {
            var_1 = var_3._ID19663;
            var_0 = var_3;
        }
    }

    var_0 notify( "reset" );
    var_0 maps\mp\gametypes\_gameobjects::_ID17961();
    var_0._ID19663 = gettime();
    return var_0;
}

_ID30915( var_0, var_1 )
{
    var_2 = var_0 + ( 0, 0, 14 );

    if ( isdefined( var_1 ) && var_1 )
    {
        var_3 = ( 0, randomfloat( 360 ), 0 );
        var_4 = anglestoforward( var_3 );
        var_5 = randomfloatrange( 40, 300 );
        var_6 = var_2 + var_5 * var_4;
        var_2 = playerphysicstrace( var_2, var_6 );
    }

    var_7 = _ID15390();
    var_7.curorigin = var_2;
    var_7.trigger.origin = var_2;
    var_7._ID35358.origin = var_2;
    var_7.trigger show();
    var_7._ID35358 show();
    var_7 maps\mp\gametypes\_gameobjects::allowuse( "any" );
    playsoundatpos( var_2, "mp_grind_token_drop" );
    return var_7;
}

_ID21457( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "deleted" );
    var_0 endon( "reset" );

    for (;;)
    {
        var_0.trigger waittill( "trigger",  var_1  );

        if ( !maps\mp\_utility::_ID18757( var_1 ) )
            continue;

        if ( var_1 maps\mp\_utility::_ID18837() || isdefined( var_1._ID30887 ) )
            continue;

        if ( isdefined( var_1.classname ) && var_1.classname == "script_vehicle" )
            continue;

        if ( isagent( var_1 ) && isdefined( var_1.owner ) )
            var_1 = var_1.owner;

        var_0._ID35358 hide();
        var_0.trigger hide();
        var_0.curorigin = ( 0, 0, 1000 );
        var_0.trigger.origin = ( 0, 0, 1000 );
        var_0._ID35358.origin = ( 0, 0, 1000 );
        var_0 maps\mp\gametypes\_gameobjects::allowuse( "none" );
        var_1 thread maps\mp\gametypes\_rank::giverankxp( "tag" );
        var_1 _ID37804( var_1._ID32367 + 1 );
        var_1 playsound( "mp_killconfirm_tags_pickup" );
        playsoundatpos( var_1.origin, "mp_grind_token_pickup" );
        break;
    }
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0.isscoring = 0;
        var_0 thread _ID37701();
    }
}

_ID37804( var_0 )
{
    self._ID32367 = var_0;
    self.game_extrainfo = var_0;

    if ( var_0 > 999 )
        var_0 = 999;

    self setclientomnvar( "ui_grind_tags", var_0 );
}

_ID37701()
{
    self endon( "disconnect" );

    for (;;)
    {
        common_scripts\utility::_ID35626( "joined_team", "joined_spectators" );

        if ( level._ID17628 )
        {
            _ID37804( 1 );
            continue;
        }

        _ID37804( 0 );
    }
}

hidehudelementongameend( var_0 )
{
    level waittill( "game_ended" );

    if ( isdefined( var_0 ) )
        var_0.alpha = 0;
}

createzones()
{
    level._ID36589 = [];
    game["flagmodels"] = [];
    game["flagmodels"]["neutral"] = "prop_flag_neutral";
    game["flagmodels"]["allies"] = maps\mp\gametypes\_teams::getteamflagmodel( "allies" );
    game["flagmodels"]["axis"] = maps\mp\gametypes\_teams::getteamflagmodel( "axis" );
    var_0 = getentarray( "grind_location", "targetname" );

    foreach ( var_2 in var_0 )
        level._ID36589[level._ID36589.size] = addzone( var_2 );
}

addzone( var_0 )
{
    var_1 = spawnstruct();
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
    var_1.trigger = var_0;
    var_1._ID23192 = "neutral";
    var_2 = var_1.origin + ( 0, 0, 32 );
    var_3 = var_1.origin + ( 0, 0, -32 );
    var_4 = bullettrace( var_2, var_3, 0, undefined );
    var_1.origin = var_4["position"];
    var_1._ID34389 = vectortoangles( var_4["normal"] );
    var_1.forward = anglestoforward( var_1._ID34389 );
    var_1.right = anglestoright( var_1._ID34389 );
    var_1._ID35361[0] = spawn( "script_model", var_1.origin );
    var_1._ID35361[0].angles = var_1.angles;
    var_1._ID35361[0] setmodel( game["flagmodels"]["neutral"] );
    return var_1;
}

_ID27069()
{
    foreach ( var_1 in level._ID36589 )
        level thread _ID31491( var_1, var_1.trigger._ID27658 );
}

_ID31491( var_0, var_1 )
{
    level thread _ID27068( var_0 );
    level thread _ID27070( var_0, var_1 );
    level thread _ID27071( var_0 );
}

_ID27068( var_0 )
{
    maps\mp\_utility::gameflagwait( "prematch_done" );
    var_1 = spawnfx( level.flagbasefxid["friendly"], var_0.origin, var_0.forward, var_0._ID34389 );
    triggerfx( var_1 );
}

_ID27070( var_0, var_1 )
{
    var_2 = ( 0, 0, 100 );
    var_0.objid_axis = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_0.objid_axis, "active", var_0.origin + var_2, "waypoint_target_" + var_1 );
    objective_team( var_0.objid_axis, "axis" );
    var_0._ID22496 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_0._ID22496, "active", var_0.origin + var_2, "waypoint_target_" + var_1 );
    objective_team( var_0._ID22496, "allies" );
    var_3 = 0;
    var_4 = "none";

    for (;;)
    {
        var_5 = "neutral";

        foreach ( var_7 in level.players )
        {
            if ( !maps\mp\_utility::_ID18757( var_7 ) )
                continue;

            if ( !var_7._ID32367 )
                continue;

            if ( var_7.team == var_5 )
                continue;

            if ( isinzone( var_7, var_0 ) )
            {
                if ( var_5 == "neutral" )
                {
                    var_5 = var_7.team;
                    continue;
                }

                var_5 = "contested";
                break;
            }
        }

        var_0._ID23192 = var_5;

        if ( var_4 == var_5 )
        {
            common_scripts\utility::_ID35582();
            continue;
        }

        switch ( var_5 )
        {
            case "neutral":
                if ( var_3 + 1250 > gettime() )
                    break;

                var_4 = var_5;
                var_0._ID15808 = var_0 maps\mp\_entityheadicons::setheadicon( "allies", "waypoint_bank_" + var_1, var_2, 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
                var_0._ID15809 = var_0 maps\mp\_entityheadicons::setheadicon( "axis", "waypoint_bank_" + var_1, var_2, 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
                objective_icon( var_0._ID22496, "waypoint_bank_" + var_1 );
                objective_icon( var_0.objid_axis, "waypoint_bank_" + var_1 );
                break;
            case "contested":
                var_4 = var_5;
                var_0._ID15808 = var_0 maps\mp\_entityheadicons::setheadicon( "allies", "waypoint_contested_" + var_1, var_2, 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
                var_0._ID15809 = var_0 maps\mp\_entityheadicons::setheadicon( "axis", "waypoint_contested_" + var_1, var_2, 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
                objective_icon( var_0._ID22496, "waypoint_contested_" + var_1 );
                objective_icon( var_0.objid_axis, "waypoint_contested_" + var_1 );
                break;
            case "axis":
                var_4 = var_5;
                var_0._ID15808 = var_0 maps\mp\_entityheadicons::setheadicon( "allies", "waypoint_scoring_foe_" + var_1, var_2, 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
                var_0._ID15809 = var_0 maps\mp\_entityheadicons::setheadicon( "axis", "waypoint_scoring_friend_" + var_1, var_2, 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
                objective_icon( var_0._ID22496, "waypoint_scoring_foe_" + var_1 );
                objective_icon( var_0.objid_axis, "waypoint_scoring_friend_" + var_1 );
                var_3 = gettime();
                break;
            case "allies":
                var_4 = var_5;
                var_0._ID15808 = var_0 maps\mp\_entityheadicons::setheadicon( "allies", "waypoint_scoring_friend_" + var_1, var_2, 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
                var_0._ID15809 = var_0 maps\mp\_entityheadicons::setheadicon( "axis", "waypoint_scoring_foe_" + var_1, var_2, 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
                objective_icon( var_0._ID22496, "waypoint_scoring_friend_" + var_1 );
                objective_icon( var_0.objid_axis, "waypoint_scoring_foe_" + var_1 );
                var_3 = gettime();
                break;
        }

        common_scripts\utility::_ID35582();
    }
}

isinzone( var_0, var_1 )
{
    if ( maps\mp\_utility::_ID18757( var_0 ) && var_0 istouching( var_1.trigger ) )
        return 1;

    return 0;
}

_ID27071( var_0 )
{
    level endon( "game_ended" );

    for (;;)
    {
        var_0.trigger waittill( "trigger",  var_1  );

        if ( isagent( var_1 ) )
            continue;

        if ( !isplayer( var_1 ) )
            continue;

        if ( var_1.isscoring )
            continue;

        var_1.isscoring = 1;
        level thread _ID25045( var_1, var_0 );
    }
}

_ID37891()
{
    level waittill( "game_ended" );

    foreach ( var_1 in level.players )
    {
        if ( !isdefined( var_1 ) )
            continue;

        if ( !isdefined( var_1._ID32367 ) )
            continue;

        var_1._ID32367 = 0;
    }
}

_ID25045( var_0, var_1 )
{
    while ( var_0._ID32367 && isinzone( var_0, var_1 ) )
    {
        var_0 playsoundtoplayer( "mp_grind_token_banked", var_0 );
        var_0 _ID37804( var_0._ID32367 - 1 );
        maps\mp\gametypes\_gamescore::giveteamscoreforobjective( var_0.team, 1 );
        var_0 maps\mp\_utility::setextrascore0( var_0.extrascore0 + 1 );
        maps\mp\gametypes\_gamescore::_ID15616( "tagScore", var_0 );
        var_0 maps\mp\_events::giveobjectivepointstreaks();
        var_0 maps\mp\gametypes\_missions::_ID25038( "ch_grinder" );
        wait 2;
    }

    var_0.isscoring = 0;
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
    level thread _ID11102( var_0, var_1 );

    if ( game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level._ID23070[var_1.team]] )
        var_1._ID12872 = 1;
}

_ID11102( var_0, var_1 )
{
    if ( isagent( var_0 ) )
        return;

    var_2 = 1;
    var_3 = 0;

    for ( var_4 = 0; var_4 < var_2; var_4++ )
    {
        if ( var_4 > 0 )
            var_3 = 1;

        var_5 = _ID30915( var_0.origin, var_3 );
        var_5._ID35229 = var_0;
        var_5.attacker = var_1;
        level notify( "new_tag_spawned",  var_5  );
        level thread _ID21457( var_5 );
    }

    playsoundatpos( var_0.origin, "mp_killconfirm_tags_drop" );
    var_6 = var_0._ID32367 - var_2;
    var_6 = int( max( 0, var_6 ) );
    var_0 _ID37804( var_6 );
}
