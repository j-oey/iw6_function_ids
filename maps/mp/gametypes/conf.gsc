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
        maps\mp\_utility::_ID25717( level._ID14086, 65 );
        maps\mp\_utility::_ID25714( level._ID14086, 1 );
        maps\mp\_utility::_ID25724( level._ID14086, 1 );
        maps\mp\_utility::_ID25712( level._ID14086, 0 );
        maps\mp\_utility::_ID25706( level._ID14086, 0 );
        level._ID20676 = 0;
        level._ID20680 = 0;
    }

    level._ID32653 = 1;
    level._ID17937 = ::_ID17937;
    level._ID22905 = ::_ID22905;
    level.getspawnpoint = ::getspawnpoint;
    level._ID22869 = ::_ID22869;
    level._ID22892 = ::_ID22892;

    if ( level._ID20676 || level._ID20680 )
        level._ID21286 = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    game["dialog"]["gametype"] = "kill_confirmed";
    game["dialog"]["kill_confirmed"] = "kill_confirmed";

    if ( getdvarint( "g_hardcore" ) )
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];

    level.conf_fx["vanish"] = loadfx( "fx/impacts/small_snowhit" );
}

initializematchrules()
{
    maps\mp\_utility::_ID28682();
    setdynamicdvar( "scr_conf_roundswitch", 0 );
    maps\mp\_utility::_ID25715( "conf", 0, 0, 9 );
    setdynamicdvar( "scr_conf_roundlimit", 1 );
    maps\mp\_utility::_ID25714( "conf", 1 );
    setdynamicdvar( "scr_conf_winlimit", 1 );
    maps\mp\_utility::_ID25724( "conf", 1 );
    setdynamicdvar( "scr_conf_halftime", 0 );
    maps\mp\_utility::_ID25706( "conf", 0 );
    setdynamicdvar( "scr_conf_promode", 0 );
}

_ID22892()
{
    precachempanim( "mp_dogtag_spin" );
    precacheshader( "waypoint_dogtags" );
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

    maps\mp\_utility::_ID28804( "allies", &"OBJECTIVES_CONF" );
    maps\mp\_utility::_ID28804( "axis", &"OBJECTIVES_CONF" );

    if ( level.splitscreen )
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_CONF" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_CONF" );
    }
    else
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_CONF_SCORE" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_CONF_SCORE" );
    }

    maps\mp\_utility::setobjectivehinttext( "allies", &"OBJECTIVES_CONF_HINT" );
    maps\mp\_utility::setobjectivehinttext( "axis", &"OBJECTIVES_CONF_HINT" );
    initspawns();
    level.dogtags = [];
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
    level thread _ID30824( var_0, var_1 );

    if ( game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level._ID23070[var_1.team]] )
        var_1._ID12872 = 1;
}

_ID30824( var_0, var_1 )
{
    if ( var_0 maps\mp\killstreaks\_killstreaks::_ID18836() )
        return;

    var_2 = var_0.pers["team"];

    if ( isdefined( level.dogtags[var_0._ID15851] ) )
    {
        playfx( level.conf_fx["vanish"], level.dogtags[var_0._ID15851].curorigin );
        level.dogtags[var_0._ID15851] notify( "reset" );
    }
    else
    {
        var_3[0] = spawn( "script_model", ( 0, 0, 0 ) );
        var_3[0] setmodel( "prop_dogtags_foe_iw6" );
        var_3[1] = spawn( "script_model", ( 0, 0, 0 ) );
        var_3[1] setmodel( "prop_dogtags_friend_iw6" );
        var_4 = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 32, 32 );
        level.dogtags[var_0._ID15851] = maps\mp\gametypes\_gameobjects::_ID8493( "any", var_4, var_3, ( 0, 0, 16 ) );
        maps\mp\_utility::_objective_delete( level.dogtags[var_0._ID15851]._ID32670["allies"] );
        maps\mp\_utility::_objective_delete( level.dogtags[var_0._ID15851]._ID32670["axis"] );
        maps\mp\gametypes\_objpoints::deleteobjpoint( level.dogtags[var_0._ID15851].objpoints["allies"] );
        maps\mp\gametypes\_objpoints::deleteobjpoint( level.dogtags[var_0._ID15851].objpoints["axis"] );
        level.dogtags[var_0._ID15851] maps\mp\gametypes\_gameobjects::_ID29198( 0 );
        level.dogtags[var_0._ID15851]._ID22916 = ::_ID22916;
        level.dogtags[var_0._ID15851]._ID35229 = var_0;
        level.dogtags[var_0._ID15851].victimteam = var_2;
        level.dogtags[var_0._ID15851]._ID22495 = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add( level.dogtags[var_0._ID15851]._ID22495, "invisible", ( 0, 0, 0 ) );
        objective_icon( level.dogtags[var_0._ID15851]._ID22495, "waypoint_dogtags" );
        level thread clearonvictimdisconnect( var_0 );
        var_0 thread _ID32370( level.dogtags[var_0._ID15851] );
    }

    var_5 = var_0.origin + ( 0, 0, 14 );
    level.dogtags[var_0._ID15851].curorigin = var_5;
    level.dogtags[var_0._ID15851].trigger.origin = var_5;
    level.dogtags[var_0._ID15851]._ID35361[0].origin = var_5;
    level.dogtags[var_0._ID15851]._ID35361[1].origin = var_5;
    level.dogtags[var_0._ID15851] maps\mp\gametypes\_gameobjects::_ID17961();
    level.dogtags[var_0._ID15851] maps\mp\gametypes\_gameobjects::allowuse( "any" );
    level.dogtags[var_0._ID15851]._ID35361[0] thread _ID29994( level.dogtags[var_0._ID15851], maps\mp\_utility::getotherteam( var_2 ) );
    level.dogtags[var_0._ID15851]._ID35361[1] thread _ID29994( level.dogtags[var_0._ID15851], var_2 );
    level.dogtags[var_0._ID15851].attacker = var_1;

    if ( isplayer( var_1 ) )
    {
        objective_position( level.dogtags[var_0._ID15851]._ID22495, var_5 );
        objective_state( level.dogtags[var_0._ID15851]._ID22495, "active" );
        objective_player( level.dogtags[var_0._ID15851]._ID22495, var_1 getentitynumber() );
    }

    playsoundatpos( var_5, "mp_killconfirm_tags_drop" );
    level notify( "new_tag_spawned",  level.dogtags[var_0._ID15851]  );
    level.dogtags[var_0._ID15851]._ID35361[0] scriptmodelplayanim( "mp_dogtag_spin" );
    level.dogtags[var_0._ID15851]._ID35361[1] scriptmodelplayanim( "mp_dogtag_spin" );
}

_ID29994( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "reset" );
    self hide();

    foreach ( var_3 in level.players )
    {
        if ( var_3.team == var_1 )
            self showtoplayer( var_3 );

        if ( var_3.team == "spectator" && var_1 == "allies" )
            self showtoplayer( var_3 );
    }

    for (;;)
    {
        level waittill( "joined_team" );
        self hide();

        foreach ( var_3 in level.players )
        {
            if ( var_3.team == var_1 )
                self showtoplayer( var_3 );

            if ( var_3.team == "spectator" && var_1 == "allies" )
                self showtoplayer( var_3 );

            if ( var_0.victimteam == var_3.team && var_3 == var_0.attacker )
                objective_state( var_0._ID22495, "invisible" );
        }
    }
}

_ID22916( var_0 )
{
    if ( isdefined( var_0.owner ) )
        var_0 = var_0.owner;

    var_0 maps\mp\_events::giveobjectivepointstreaks();
    var_1 = var_0.pers["team"];

    if ( var_1 == self.victimteam )
    {
        self.trigger playsound( "mp_killconfirm_tags_deny" );
        var_0 maps\mp\_utility::_ID17531( "killsdenied", 1 );
        var_0 maps\mp\_utility::_ID17529( "denied", 1 );
        var_0 maps\mp\gametypes\_persistence::_ID31528( "round", "denied", var_0.pers["denied"] );

        if ( isplayer( var_0 ) )
            var_0 maps\mp\_utility::setextrascore0( var_0.pers["confirmed"] + var_0.pers["denied"] );

        if ( self._ID35229 == var_0 )
            var_2 = "tags_retrieved";
        else
            var_2 = "kill_denied";

        if ( isdefined( self.attacker ) )
            self.attacker thread maps\mp\gametypes\_rank::_ID36462( "kill_denied" );

        var_0 thread onpickup( var_2 );
        var_0 maps\mp\gametypes\_missions::_ID25038( "ch_denier" );
    }
    else
    {
        self.trigger playsound( "mp_killconfirm_tags_pickup" );
        var_2 = "kill_confirmed";
        var_0 maps\mp\_utility::_ID17531( "killsconfirmed", 1 );
        var_0 maps\mp\_utility::_ID17529( "confirmed", 1 );
        var_0 maps\mp\gametypes\_persistence::_ID31528( "round", "confirmed", var_0.pers["confirmed"] );

        if ( self.attacker != var_0 )
            self.attacker thread onpickup( var_2 );

        var_0 onpickup( var_2 );

        if ( isplayer( var_0 ) )
        {
            var_0 maps\mp\_utility::_ID19765( "kill_confirmed" );
            var_0 maps\mp\_utility::setextrascore0( var_0.pers["confirmed"] + var_0.pers["denied"] );
        }

        var_0 maps\mp\gametypes\_missions::_ID25038( "ch_collector" );
        var_0 maps\mp\gametypes\_gamescore::giveteamscoreforobjective( var_1, 1 );
    }

    _ID26142();
}

onpickup( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    while ( !isdefined( self.pers ) )
        wait 0.05;

    thread maps\mp\gametypes\_rank::_ID36462( var_0 );
    maps\mp\gametypes\_gamescore::_ID15616( var_0, self, undefined, 1 );
    thread maps\mp\gametypes\_rank::giverankxp( var_0 );
}

_ID26142()
{
    self.attacker = undefined;
    self notify( "reset" );
    self._ID35361[0] hide();
    self._ID35361[1] hide();
    self.curorigin = ( 0, 0, 1000 );
    self.trigger.origin = ( 0, 0, 1000 );
    self._ID35361[0].origin = ( 0, 0, 1000 );
    self._ID35361[1].origin = ( 0, 0, 1000 );
    maps\mp\gametypes\_gameobjects::allowuse( "none" );
    objective_state( self._ID22495, "invisible" );
}

_ID32370( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "joined_team" );
        var_0.victimteam = self.pers["team"];
        var_0 _ID26142();
    }
}

clearonvictimdisconnect( var_0 )
{
    level endon( "game_ended" );
    var_1 = var_0._ID15851;
    var_0 waittill( "disconnect" );

    if ( isdefined( level.dogtags[var_1] ) )
    {
        level.dogtags[var_1] maps\mp\gametypes\_gameobjects::allowuse( "none" );

        if ( isdefined( level.dogtags[var_1].attacker ) )
            level.dogtags[var_1].attacker thread maps\mp\gametypes\_rank::_ID36462( "kill_denied" );

        playfx( level.conf_fx["vanish"], level.dogtags[var_1].curorigin );
        level.dogtags[var_1] notify( "reset" );
        wait 0.05;

        if ( isdefined( level.dogtags[var_1] ) )
        {
            objective_delete( level.dogtags[var_1]._ID22495 );
            level.dogtags[var_1].trigger delete();

            for ( var_2 = 0; var_2 < level.dogtags[var_1]._ID35361.size; var_2++ )
                level.dogtags[var_1]._ID35361[var_2] delete();

            level.dogtags[var_1] notify( "deleted" );
            level.dogtags[var_1] = undefined;
        }
    }
}

_ID17937()
{

}
