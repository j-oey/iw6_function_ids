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
        maps\mp\_utility::_ID25718( level._ID14086, 7 );
        maps\mp\_utility::_ID25717( level._ID14086, 2500 );
        maps\mp\_utility::_ID25714( level._ID14086, 1 );
        maps\mp\_utility::_ID25724( level._ID14086, 1 );
        maps\mp\_utility::_ID25712( level._ID14086, 0 );
        maps\mp\_utility::_ID25706( level._ID14086, 0 );
        level._ID20676 = 0;
        level._ID20680 = 0;
        level.mugger_bank_limit = getdvarint( "scr_mugger_bank_limit", 10 );
    }

    setteammode( "ffa" );
    level._ID22892 = ::_ID22892;
    level._ID22905 = ::_ID22905;
    level._ID22902 = ::_ID22902;
    level.getspawnpoint = ::getspawnpoint;
    level._ID22869 = ::_ID22869;
    level._ID22888 = ::_ID22888;
    level._ID22913 = ::_ID22913;
    level._ID22924 = ::_ID22924;
    level._ID8769 = ::createmuggercrates;
    level._ID3995 = 1;

    if ( level._ID20676 || level._ID20680 )
        level._ID21286 = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    level._ID21761["vanish"] = loadfx( "impacts/small_snowhit" );
    level._ID21761["smoke"] = loadfx( "smoke/airdrop_flare_mp_effect_now" );
    level._ID21792 = loadfx( "misc/ui_flagbase_red" );
    level thread _ID22877();
}

initializematchrules()
{
    maps\mp\_utility::_ID28682();
    setdynamicdvar( "scr_mugger_roundswitch", 0 );
    maps\mp\_utility::_ID25715( "mugger", 0, 0, 9 );
    setdynamicdvar( "scr_mugger_roundlimit", 1 );
    maps\mp\_utility::_ID25714( "mugger", 1 );
    setdynamicdvar( "scr_mugger_winlimit", 1 );
    maps\mp\_utility::_ID25724( "mugger", 1 );
    setdynamicdvar( "scr_mugger_halftime", 0 );
    maps\mp\_utility::_ID25706( "mugger", 0 );
    setdynamicdvar( "scr_mugger_promode", 0 );
    level.mugger_bank_limit = getmatchrulesdata( "muggerData", "bankLimit" );
    setdynamicdvar( "scr_mugger_bank_limit", level.mugger_bank_limit );
    level._ID21769 = getmatchrulesdata( "muggerData", "jackpotLimit" );
    setdynamicdvar( "scr_mugger_jackpot_limit", level._ID21769 );
    level._ID21793 = getmatchrulesdata( "muggerData", "throwKnifeFrac" );
    setdynamicdvar( "scr_mugger_throwing_knife_mug_frac", level._ID21793 );
}

_ID22892()
{
    precachemodel( "prop_dogtags_foe_iw6" );
    precachemodel( "weapon_us_smoke_grenade_burnt2" );
    precachempanim( "mp_dogtag_spin" );
    precacheshader( "waypoint_dogtags2" );
    precacheshader( "waypoint_dogtag_pile" );
    precacheshader( "waypoint_jackpot" );
    precacheshader( "hud_tagcount" );
    precachesound( "mugger_mugging" );
    precachesound( "mugger_mega_mugging" );
    precachesound( "mugger_you_mugged" );
    precachesound( "mugger_got_mugged" );
    precachesound( "mugger_mega_drop" );
    precachesound( "mugger_muggernaut" );
    precachesound( "mugger_tags_banked" );
    precachestring( &"MPUI_MUGGER_JACKPOT" );
}

_ID22905()
{
    setclientnamemode( "auto_change" );
    maps\mp\_utility::_ID28804( "allies", &"OBJECTIVES_MUGGER" );
    maps\mp\_utility::_ID28804( "axis", &"OBJECTIVES_MUGGER" );

    if ( level.splitscreen )
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_MUGGER" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_MUGGER" );
    }
    else
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_MUGGER_SCORE" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_MUGGER_SCORE" );
    }

    maps\mp\_utility::setobjectivehinttext( "allies", &"OBJECTIVES_MUGGER_HINT" );
    maps\mp\_utility::setobjectivehinttext( "axis", &"OBJECTIVES_MUGGER_HINT" );
    level._ID30895 = ( 0, 0, 0 );
    level._ID30893 = ( 0, 0, 0 );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", "mp_dm_spawn" );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", "mp_dm_spawn" );
    level._ID20634 = maps\mp\gametypes\_spawnlogic::findboxcenter( level._ID30895, level._ID30893 );
    setmapcenter( level._ID20634 );
    level.dogtags = [];
    var_0[0] = level._ID14086;
    var_0[1] = "dm";
    maps\mp\gametypes\_gameobjects::_ID20445( var_0 );
    level._ID21794 = getdvarint( "scr_mugger_timelimit", 7 );
    setdynamicdvar( "scr_mugger_timeLimit", level._ID21794 );
    maps\mp\_utility::_ID25718( "mugger", level._ID21794 );
    level.mugger_scorelimit = getdvarint( "scr_mugger_scorelimit", 2500 );

    if ( level.mugger_scorelimit == 0 )
        level.mugger_scorelimit = 2500;

    setdynamicdvar( "scr_mugger_scoreLimit", level.mugger_scorelimit );
    maps\mp\_utility::_ID25717( "mugger", level.mugger_scorelimit );
    level.mugger_bank_limit = getdvarint( "scr_mugger_bank_limit", 10 );
    level._ID21786 = getdvarint( "scr_mugger_muggernaut_window", 3000 );
    level._ID21785 = getdvarint( "scr_mugger_muggernaut_muggings_needed", 3 );
    level._ID21782 = squared( getdvarfloat( "mugger_min_spawn_dist", 350 ) );
    level._ID21769 = getdvarint( "scr_mugger_jackpot_limit", 0 );
    level._ID21778 = getdvarfloat( "scr_mugger_jackpot_wait_sec", 10 );
    level._ID21793 = getdvarfloat( "scr_mugger_throwing_knife_mug_frac", 1.0 );
    level _ID21763();
    level thread _ID21784();
    level thread _ID21783();
    createdropzones();
    level.jackpot_zone = spawn( "script_model", ( 0, 0, 0 ) );
    level.jackpot_zone.origin = ( 0, 0, 0 );
    level.jackpot_zone.angles = ( 90, 0, 0 );
    level.jackpot_zone setmodel( "weapon_us_smoke_grenade_burnt2" );
    level.jackpot_zone hide();
    level.jackpot_zone.mugger_fx_playing = 0;
    level thread _ID21779();
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0._ID32365 = 0;
        var_0._ID33151 = 0;
        var_0.assists = var_0._ID33151;
        var_0.pers["assists"] = var_0._ID33151;
        var_0.game_extrainfo = var_0._ID32365;
        var_0._ID21796 = [];

        if ( isplayer( var_0 ) && !isbot( var_0 ) )
        {
            var_0._ID10574 = var_0 maps\mp\gametypes\_hud_util::_ID8444( "hud_tagcount", 48, 48 );
            var_0._ID10574 maps\mp\gametypes\_hud_util::_ID28836( "TOP LEFT", "TOP LEFT", 200, 0 );
            var_0._ID10574.alpha = 1;
            var_0._ID10574.hidewheninmenu = 1;
            var_0._ID10574.archived = 1;
            level thread hidehudelementongameend( var_0._ID10574 );
            var_0._ID10575 = var_0 maps\mp\gametypes\_hud_util::createfontstring( "bigfixed", 1.0 );
            var_0._ID10575 maps\mp\gametypes\_hud_util::_ID28815( var_0._ID10574 );
            var_0._ID10575 maps\mp\gametypes\_hud_util::_ID28836( "CENTER", "CENTER", -24 );
            var_0._ID10575 setvalue( var_0._ID32365 );
            var_0._ID10575.alpha = 1;
            var_0._ID10575.color = ( 1, 1, 0.5 );
            var_0._ID10575.glowalpha = 1;
            var_0._ID10575.sort = 1;
            var_0._ID10575.hidewheninmenu = 1;
            var_0._ID10575.archived = 1;
            var_0._ID10575 maps\mp\gametypes\_hud::_ID13470( 3.0 );
            level thread hidehudelementongameend( var_0._ID10575 );
        }
    }
}

_ID22902()
{
    self._ID21796 = [];

    if ( !isagent( self ) )
        thread _ID35599();
}

hidehudelementongameend( var_0 )
{
    level waittill( "game_ended" );

    if ( isdefined( var_0 ) )
        var_0.alpha = 0;
}

getspawnpoint()
{
    var_0 = maps\mp\gametypes\_spawnlogic::_ID15425( self.pers["team"] );
    var_1 = maps\mp\gametypes\_spawnscoring::_ID15344( var_0 );
    return var_1;
    return var_1;
}

_ID22924( var_0 )
{
    if ( isdefined( var_0 ) && var_0 == "suicide" )
        level thread _ID30824( self, self );

    maps\mp\gametypes\_globallogic::_ID22924( var_0 );
}

_ID22869( var_0, var_1, var_2 )
{
    level thread _ID30824( var_0, var_1 );

    if ( game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level._ID23070[var_1.team]] )
        var_1._ID12872 = 1;
}

_ID21763()
{
    level.mugger_max_extra_tags = getdvarint( "scr_mugger_max_extra_tags", 50 );
    level._ID21759 = [];
}

_ID30824( var_0, var_1 )
{
    if ( isagent( var_1 ) )
        var_1 = var_1.owner;

    var_2 = 0;
    var_3 = 0;

    if ( isdefined( var_1 ) )
    {
        if ( var_0 == var_1 )
        {
            if ( var_0._ID32365 > 0 )
            {
                var_2 = var_0._ID32365;
                var_0._ID32365 = 0;
                var_0.game_extrainfo = 0;

                if ( isplayer( var_0 ) && !isbot( var_0 ) )
                {
                    var_0._ID10575 setvalue( var_0._ID32365 );
                    var_0._ID10575 thread maps\mp\gametypes\_hud::fontpulse( var_0 );
                    var_0 thread maps\mp\gametypes\_hud_message::_ID31054( "mugger_suicide", var_2 );
                }
            }
        }
        else if ( isdefined( var_0.attackerdata ) && var_0.attackerdata.size > 0 )
        {
            if ( isplayer( var_1 ) && isdefined( var_0.attackerdata ) && isdefined( var_1._ID15851 ) && isdefined( var_0.attackerdata[var_1._ID15851] ) )
            {
                var_4 = var_0.attackerdata[var_1._ID15851];

                if ( isdefined( var_4 ) && isdefined( var_4.attackerent ) && var_4.attackerent == var_1 )
                {
                    if ( isdefined( var_4._ID30258 ) && ( var_4._ID30258 == "MOD_MELEE" || ( var_4.weapon == "throwingknife_mp" || var_4.weapon == "throwingknifejugg_mp" ) && level._ID21793 > 0.0 ) )
                    {
                        var_3 = 1;

                        if ( var_0._ID32365 > 0 )
                        {
                            var_2 = var_0._ID32365;

                            if ( ( var_4.weapon == "throwingknife_mp" || var_4.weapon == "throwingknifejugg_mp" ) && level._ID21793 < 1.0 )
                                var_2 = int( ceil( var_0._ID32365 * level._ID21793 ) );

                            var_0._ID32365 = var_0._ID32365 - var_2;
                            var_0.game_extrainfo = var_0._ID32365;

                            if ( isplayer( var_0 ) && !isbot( var_0 ) )
                            {
                                var_0._ID10575 setvalue( var_0._ID32365 );
                                var_0._ID10575 thread maps\mp\gametypes\_hud::fontpulse( var_0 );
                                var_0 thread maps\mp\gametypes\_hud_message::_ID31054( "callout_mugged", var_2 );
                                var_0 playlocalsound( "mugger_got_mugged" );
                            }

                            playsoundatpos( var_0.origin, "mugger_mugging" );
                            var_1 thread maps\mp\gametypes\_hud_message::_ID31054( "callout_mugger", var_2 );

                            if ( var_4.weapon == "throwingknife_mp" || var_4.weapon == "throwingknifejugg_mp" )
                                var_1 playlocalsound( "mugger_you_mugged" );
                        }

                        var_1._ID21796[var_1._ID21796.size] = gettime();
                        var_1 thread _ID21756();
                    }
                }
            }
        }
    }

    if ( isagent( var_0 ) )
    {
        var_5 = var_0.origin + ( 0, 0, 14 );
        playsoundatpos( var_5, "mp_killconfirm_tags_drop" );
        level notify( "mugger_jackpot_increment" );
        var_6 = _ID21791( var_0.origin, 40, 160 );
        var_6._ID35229 = var_0.owner;

        if ( isdefined( var_1 ) && var_0 != var_1 )
            var_6.attacker = var_1;
        else
            var_6.attacker = undefined;

        return;
    }
    else if ( isdefined( level.dogtags[var_0._ID15851] ) )
    {
        playfx( level._ID21761["vanish"], level.dogtags[var_0._ID15851].curorigin );
        level.dogtags[var_0._ID15851] notify( "reset" );
    }
    else
    {
        var_7[0] = spawn( "script_model", ( 0, 0, 0 ) );
        var_7[0] setmodel( "prop_dogtags_foe_iw6" );
        var_8 = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 32, 32 );
        var_8.targetname = "trigger_dogtag";
        var_8 hide();
        level.dogtags[var_0._ID15851] = maps\mp\gametypes\_gameobjects::_ID8493( "any", var_8, var_7, ( 0, 0, 16 ) );
        maps\mp\gametypes\_objpoints::deleteobjpoint( level.dogtags[var_0._ID15851].objpoints["allies"] );
        maps\mp\gametypes\_objpoints::deleteobjpoint( level.dogtags[var_0._ID15851].objpoints["axis"] );
        level.dogtags[var_0._ID15851] maps\mp\gametypes\_gameobjects::_ID29198( 0 );
        level.dogtags[var_0._ID15851]._ID22916 = ::_ID22916;
        var_8.dogtag = level.dogtags[var_0._ID15851];
        level.dogtags[var_0._ID15851]._ID35229 = var_0;
        level.dogtags[var_0._ID15851]._ID22495 = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add( level.dogtags[var_0._ID15851]._ID22495, "invisible", ( 0, 0, 0 ) );
        objective_icon( level.dogtags[var_0._ID15851]._ID22495, "waypoint_dogtags2" );
        level.dogtags[var_0._ID15851]._ID35361[0] scriptmodelplayanim( "mp_dogtag_spin" );
        level thread clearonvictimdisconnect( var_0 );
    }

    var_5 = var_0.origin + ( 0, 0, 14 );
    level.dogtags[var_0._ID15851].curorigin = var_5;
    level.dogtags[var_0._ID15851].trigger.origin = var_5;
    level.dogtags[var_0._ID15851]._ID35361[0].origin = var_5;
    level.dogtags[var_0._ID15851] maps\mp\gametypes\_gameobjects::_ID17961();
    level.dogtags[var_0._ID15851] maps\mp\gametypes\_gameobjects::allowuse( "any" );
    level.dogtags[var_0._ID15851]._ID35361[0] show();

    if ( isdefined( var_1 ) && var_0 != var_1 )
        level.dogtags[var_0._ID15851].attacker = var_1;
    else
        level.dogtags[var_0._ID15851].attacker = undefined;

    level.dogtags[var_0._ID15851] thread timeout();

    if ( var_2 < 5 )
    {
        objective_position( level.dogtags[var_0._ID15851]._ID22495, var_5 );
        objective_state( level.dogtags[var_0._ID15851]._ID22495, "active" );
    }
    else
        _ID21790( var_5, "mugger_megadrop", var_2, var_0, var_1 );

    playsoundatpos( var_5, "mp_killconfirm_tags_drop" );
    level.dogtags[var_0._ID15851]._ID32822 = 0;

    if ( var_2 == 0 )
        level notify( "mugger_jackpot_increment" );

    for ( var_9 = 0; var_9 < var_2; var_9++ )
    {
        var_6 = _ID21791( var_0.origin, 40, 160 );
        var_6._ID35229 = var_0;

        if ( isdefined( var_1 ) && var_0 != var_1 )
        {
            var_6.attacker = var_1;
            continue;
        }

        var_6.attacker = undefined;
    }
}

mugger_tag_pickup_wait()
{
    level endon( "game_ended" );
    self endon( "reset" );
    self endon( "reused" );
    self endon( "deleted" );

    for (;;)
    {
        self.trigger waittill( "trigger",  var_0  );

        if ( !maps\mp\_utility::_ID18757( var_0 ) )
            continue;

        if ( var_0 maps\mp\_utility::_ID18837() || isdefined( var_0._ID30887 ) )
            continue;

        if ( isdefined( var_0.classname ) && var_0.classname == "script_vehicle" )
            continue;

        thread _ID22916( var_0 );
        return;
    }
}

mugger_add_extra_tag( var_0 )
{
    var_1[0] = spawn( "script_model", ( 0, 0, 0 ) );
    var_1[0] setmodel( "prop_dogtags_foe_iw6" );
    var_2 = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 32, 32 );
    var_2.targetname = "trigger_dogtag";
    var_2 hide();
    level._ID21759[var_0] = spawnstruct();
    var_3 = level._ID21759[var_0];
    var_3.type = "useObject";
    var_3.curorigin = var_2.origin;
    var_3.entnum = var_2 getentitynumber();
    var_3.trigger = var_2;
    var_3._ID33726 = "proximity";
    var_3 maps\mp\gametypes\_gameobjects::allowuse( "any" );
    var_1[0]._ID4860 = var_1[0].origin;
    var_3._ID35361 = var_1;
    var_3._ID22631 = ( 0, 0, 16 );
    var_3._ID32822 = 1;
    var_3._ID19506 = 0;
    var_3._ID35361[0] scriptmodelplayanim( "mp_dogtag_spin" );
    var_3 thread mugger_tag_pickup_wait();
    return var_3;
}

mugger_first_unused_or_oldest_extra_tag()
{
    var_0 = undefined;
    var_1 = -1;

    foreach ( var_3 in level._ID21759 )
    {
        if ( var_3._ID18086 == "none" )
        {
            var_3._ID19506 = gettime();
            var_3._ID35361[0] show();
            return var_3;
        }

        if ( !isdefined( var_0 ) || var_3._ID19506 < var_1 )
        {
            var_1 = var_3._ID19506;
            var_0 = var_3;
        }
    }

    if ( level._ID21759.size < level.mugger_max_extra_tags )
    {
        var_5 = mugger_add_extra_tag( level._ID21759.size );

        if ( isdefined( var_5 ) )
        {
            var_5._ID19506 = gettime();
            return var_5;
        }
    }

    var_0._ID19506 = gettime();
    var_0 notify( "reused" );
    playfx( level._ID21761["vanish"], var_0.curorigin );
    return var_0;
}

_ID21791( var_0, var_1, var_2 )
{
    var_3 = mugger_first_unused_or_oldest_extra_tag();
    var_4 = var_0 + ( 0, 0, 14 );
    var_5 = ( 0, randomfloat( 360 ), 0 );
    var_6 = anglestoforward( var_5 );
    var_7 = randomfloatrange( 40, 160 );
    var_8 = var_4 + var_7 * var_6;
    var_8 += ( 0, 0, 40 );
    var_9 = playerphysicstrace( var_4, var_8 );
    var_4 = var_9;
    var_8 = var_4 + ( 0, 0, -100 );
    var_9 = playerphysicstrace( var_4, var_8 );

    if ( var_9[2] != var_8[2] )
        var_9 += ( 0, 0, 14 );

    var_3.curorigin = var_9;
    var_3.trigger.origin = var_9;
    var_3._ID35361[0].origin = var_9;
    var_3 maps\mp\gametypes\_gameobjects::_ID17961();
    var_3 maps\mp\gametypes\_gameobjects::allowuse( "any" );
    var_3 thread mugger_tag_pickup_wait();
    var_3 thread timeout();
    return var_3;
}

_ID21790( var_0, var_1, var_2, var_3, var_4 )
{
    level notify( "mugger_tag_pile",  var_0  );
    var_5 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_5, "active", var_0 );
    objective_icon( var_5, "waypoint_dogtag_pile" );
    level maps\mp\_utility::_ID9519( 5, ::mugger_pile_icon_remove, var_5 );

    if ( var_2 >= 10 )
    {
        level.mugger_last_mega_drop = gettime();
        level._ID21770 = 0;

        foreach ( var_7 in level.players )
        {
            var_7 playsoundtoplayer( "mp_defcon_one", var_7 );

            if ( isdefined( var_3 ) && var_7 == var_3 )
                continue;

            if ( isdefined( var_4 ) && var_7 == var_4 )
                continue;

            var_7 thread maps\mp\gametypes\_hud_message::_ID31052( var_1, var_2 );
        }

        var_9 = newhudelem();
        var_9 setshader( "waypoint_dogtag_pile", 10, 10 );
        var_9 setwaypoint( 0, 1, 0, 0 );
        var_9.x = var_0[0];
        var_9.y = var_0[1];
        var_9.z = var_0[2] + 32;
        var_9.alpha = 1;
        var_9 fadeovertime( 5 );
        var_9.alpha = 0;
        var_9 maps\mp\_utility::_ID9519( 5, ::_ID17247 );
    }
}

_ID17247()
{
    if ( isdefined( self ) )
        self destroy();
}

_ID21784()
{
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = getentarray( "remote_tank", "targetname" );
        var_1 = getentarray( "trigger_dogtag", "targetname" );

        foreach ( var_3 in level.players )
        {
            if ( isdefined( var_3._ID34792 ) && var_3._ID34792 == 1 )
            {
                foreach ( var_5 in var_0 )
                {
                    if ( isdefined( var_5 ) && isdefined( var_5.owner ) && var_5.owner == var_3 )
                    {
                        foreach ( var_7 in var_1 )
                        {
                            if ( isdefined( var_7 ) && isdefined( var_7.dogtag ) )
                            {
                                if ( isdefined( var_7.dogtag._ID18086 ) && var_7.dogtag._ID18086 != "none" )
                                {
                                    if ( var_5 istouching( var_7 ) )
                                        var_7.dogtag _ID22916( var_5.owner );
                                }
                            }
                        }
                    }
                }
            }
        }

        wait 0.2;
    }
}

_ID21783()
{
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = getentarray( "trigger_dogtag", "targetname" );

        foreach ( var_2 in level.players )
        {
            if ( isdefined( var_2 ) && isdefined( var_2._ID25826 ) )
            {
                foreach ( var_4 in var_0 )
                {
                    if ( isdefined( var_4 ) && isdefined( var_4.dogtag ) )
                    {
                        if ( isdefined( var_4.dogtag._ID18086 ) && var_4.dogtag._ID18086 != "none" )
                        {
                            if ( var_2._ID25826 istouching( var_4 ) )
                                var_4.dogtag _ID22916( var_2 );
                        }
                    }
                }
            }
        }

        wait 0.2;
    }
}

_ID21756()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self notify( "checking_muggernaut" );
    self endon( "checking_muggernaut" );
    wait 2;

    if ( self._ID21796.size < level._ID21785 )
        return;

    var_0 = self._ID21796[self._ID21796.size - 1];
    var_1 = var_0 - level._ID21786;
    var_2 = [];

    foreach ( var_4 in self._ID21796 )
    {
        if ( var_4 >= var_1 )
            var_2[var_2.size] = var_4;
    }

    if ( var_2.size >= level._ID21785 )
    {
        thread maps\mp\gametypes\_hud_message::_ID31054( "muggernaut", self._ID32365 );
        thread maps\mp\gametypes\_rank::giverankxp( "muggernaut" );
        _ID21755( 1, 1 );
        self._ID21796 = [];
    }
    else
        self._ID21796 = var_2;
}

mugger_pile_icon_remove( var_0 )
{
    objective_delete( var_0 );
}

_ID16901( var_0 )
{
    self hide();

    foreach ( var_2 in level.players )
    {
        if ( var_2 != var_0 )
            self showtoplayer( var_2 );
    }
}

_ID22916( var_0 )
{
    if ( isdefined( var_0.owner ) )
        var_0 = var_0.owner;

    if ( self._ID32822 )
        self.trigger playsound( "mp_killconfirm_tags_deny" );
    else if ( isdefined( self.attacker ) && var_0 == self.attacker )
    {
        self.trigger playsound( "mp_killconfirm_tags_pickup" );
        var_0 maps\mp\_utility::_ID17531( "killsconfirmed", 1 );
        var_0 maps\mp\_utility::_ID17529( "confirmed", 1 );
        var_0 maps\mp\gametypes\_persistence::_ID31528( "round", "confirmed", var_0.pers["confirmed"] );
    }
    else
    {
        self.trigger playsound( "mp_killconfirm_tags_deny" );
        var_0 maps\mp\_utility::_ID17531( "killsdenied", 1 );
        var_0 maps\mp\_utility::_ID17529( "denied", 1 );
        var_0 maps\mp\gametypes\_persistence::_ID31528( "round", "denied", var_0.pers["denied"] );
    }

    var_0 thread onpickup();
    _ID26142( 1 );
}

onpickup()
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    while ( !isdefined( self.pers ) )
        wait 0.05;

    thread mugger_delayed_banking();
}

mugger_delayed_banking()
{
    self notify( "banking" );
    self endon( "banking" );
    level endon( "banking_all" );
    self._ID32365++;
    self.game_extrainfo = self._ID32365;

    if ( isplayer( self ) && !isbot( self ) )
    {
        self._ID10575 setvalue( self._ID32365 );
        self._ID10575 thread maps\mp\gametypes\_hud::fontpulse( self );
    }

    wait 1.5;
    var_0 = level.mugger_bank_limit - self._ID32365;

    if ( var_0 > 0 && var_0 <= 5 )
    {
        var_1 = undefined;

        switch ( var_0 )
        {
            case 1:
                var_1 = "mugger_1more";
                break;
            case 2:
                var_1 = "mugger_2more";
                break;
            case 3:
                var_1 = "mugger_3more";
                break;
            case 4:
                var_1 = "mugger_4more";
                break;
            case 5:
                var_1 = "mugger_5more";
                break;
        }

        if ( isdefined( var_1 ) )
            self playsoundtoplayer( var_1, self );
    }

    wait 0.5;
    _ID21755( 0 );
}

_ID21755( var_0, var_1 )
{
    var_2 = 0;

    if ( var_0 == 1 )
        var_2 = self._ID32365;
    else
    {
        var_3 = self._ID32365 % level.mugger_bank_limit;
        var_2 = self._ID32365 - var_3;
    }

    if ( var_2 > 0 )
    {
        self._ID32366 = var_2;

        if ( !isdefined( var_1 ) )
            thread maps\mp\gametypes\_hud_message::_ID31054( "callout_tags_banked", var_2 );

        thread maps\mp\gametypes\_rank::giverankxp( "tags_banked", self._ID32366 * maps\mp\gametypes\_rank::_ID15328( "kill_confirmed" ) );
        level thread maps\mp\gametypes\_gamescore::_ID15616( "tags_banked", self, undefined, 1 );
        self._ID33151 = self._ID33151 + var_2;
        self._ID32365 = self._ID32365 - var_2;
        self.game_extrainfo = self._ID32365;

        if ( isplayer( self ) && !isbot( self ) )
        {
            self._ID10575 setvalue( self._ID32365 );
            self._ID10575 thread maps\mp\gametypes\_hud::fontpulse( self );
        }

        self.assists = self._ID33151;
        self.pers["assists"] = self._ID33151;
        self updatescores();
    }
}

_ID22888( var_0, var_1, var_2 )
{
    if ( var_0 == "tags_banked" && isdefined( var_1 ) && isdefined( var_1._ID32366 ) && var_1._ID32366 > 0 )
    {
        var_3 = var_1._ID32366 * maps\mp\gametypes\_rank::_ID15328( "kill_confirmed" );
        var_1._ID32366 = 0;
        return var_3;
    }

    return 0;
}

_ID26142( var_0 )
{
    if ( !var_0 )
        level notify( "mugger_jackpot_increment" );

    self.attacker = undefined;
    self notify( "reset" );
    self._ID35361[0] hide();
    self.curorigin = ( 0, 0, 1000 );
    self.trigger.origin = ( 0, 0, 1000 );
    self._ID35361[0].origin = ( 0, 0, 1000 );
    maps\mp\gametypes\_gameobjects::allowuse( "none" );

    if ( isdefined( self.jackpot_tag ) && self.jackpot_tag == 1 )
        level.mugger_jackpot_tags_spawned--;

    if ( !self._ID32822 )
        objective_state( self._ID22495, "invisible" );
}

timeout()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "deleted" );
    self endon( "reset" );
    self endon( "reused" );
    self notify( "timeout_start" );
    self endon( "timeout_start" );
    level maps\mp\gametypes\_hostmigration::_ID35597( 27.0 );

    for ( var_0 = 3.0; var_0 > 0.0; var_0 -= 0.5 )
    {
        self._ID35361[0] hide();
        wait 0.25;
        self._ID35361[0] show();
        wait 0.25;
    }

    playfx( level._ID21761["vanish"], self.curorigin );
    thread _ID26142( 0 );
}

clearonvictimdisconnect( var_0 )
{
    level endon( "game_ended" );
    var_1 = var_0._ID15851;
    var_0 waittill( "disconnect" );

    if ( isdefined( level.dogtags[var_1] ) )
    {
        level.dogtags[var_1] maps\mp\gametypes\_gameobjects::allowuse( "none" );
        playfx( level._ID21761["vanish"], level.dogtags[var_1].curorigin );
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

_ID22913()
{
    level notify( "banking_all" );

    foreach ( var_1 in level.players )
        var_1 _ID21755( 1 );

    wait 0.1;
    maps\mp\gametypes\_gamelogic::_ID9379();
}

_ID21779()
{
    level endon( "game_ended" );
    level endon( "jackpot_stop" );

    if ( level._ID21769 <= 0 )
        return;

    level._ID21770 = 0;
    level._ID21775 = 0;
    level._ID21770 = 0;
    level thread mugger_jackpot_timer();

    for (;;)
    {
        level waittill( "mugger_jackpot_increment" );
        var_0 = 1;

        if ( var_0 )
        {
            level._ID21770++;
            var_1 = clamp( float( level._ID21770 / level._ID21769 ), 0.0, 1.0 );

            if ( level._ID21770 >= level._ID21769 )
            {
                if ( isdefined( level._ID21776 ) )
                    level._ID21776 thread maps\mp\gametypes\_hud::fontpulse( level.players[0] );

                level._ID21770 = 15 + randomintrange( 0, 3 ) * 5;
                level thread _ID21766();
                break;
            }
        }
    }
}

mugger_jackpot_timer()
{
    level endon( "game_ended" );
    level endon( "jackpot_stop" );
    maps\mp\_utility::gameflagwait( "prematch_done" );

    for (;;)
    {
        wait(level._ID21778);
        level notify( "mugger_jackpot_increment" );
    }
}

_ID21766()
{
    level endon( "game_ended" );
    level notify( "reset_airdrop" );
    level endon( "reset_airdrop" );
    var_0 = level._ID21758[level.script][randomint( level._ID21758[level.script].size )];
    var_0 += ( randomintrange( -50, 50 ), randomintrange( -50, 50 ), 0 );

    for (;;)
    {
        var_1 = level.players[0];
        var_2 = 1;

        if ( isdefined( var_1 ) && maps\mp\_utility::_ID8679() < maps\mp\_utility::maxvehiclesallowed() && level._ID12791 + var_2 < maps\mp\_utility::maxvehiclesallowed() && level.numdropcrates < 8 )
        {
            foreach ( var_4 in level.players )
                var_4 thread maps\mp\gametypes\_hud_message::_ID31052( "mugger_jackpot_incoming" );

            maps\mp\_utility::_ID17543();
            level thread maps\mp\killstreaks\_airdrop::_ID10390( var_1, var_0, randomfloat( 360 ), "airdrop_mugger", 0, "airdrop_jackpot" );
            break;
            continue;
        }

        wait 0.5;
        continue;
    }

    level._ID21775 = level._ID21770;
    level thread _ID21773( var_0 );
}

_ID21771( var_0, var_1, var_2 )
{
    if ( !isdefined( level._ID18896 ) )
    {
        level._ID18896 = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add( level._ID18896, "active", var_0 );
        objective_icon( level._ID18896, "waypoint_jackpot" );
    }
    else
        objective_position( level._ID18896, var_0 );

    if ( var_2 >= 10 )
    {
        foreach ( var_4 in level.players )
            var_4 playlocalsound( game["music"]["victory_" + var_4.pers["team"]] );

        if ( !isdefined( level.jackpotpileicon ) )
        {
            level.jackpotpileicon = newhudelem();
            level.jackpotpileicon setshader( "waypoint_jackpot", 64, 64 );
            level.jackpotpileicon setwaypoint( 0, 1, 0, 0 );
        }

        level.jackpotpileicon.x = var_0[0];
        level.jackpotpileicon.y = var_0[1];
        level.jackpotpileicon.z = var_0[2] + 12;
        level.jackpotpileicon.alpha = 0.75;
    }
}

_ID21772()
{
    objective_state( level._ID18896, "invisible" );
    level.jackpotpileicon fadeovertime( 2 );
    level.jackpotpileicon.alpha = 0;
    level.jackpotpileicon maps\mp\_utility::_ID9519( 2, ::_ID17247 );
}

_ID21767( var_0 )
{
    _ID21768();
    var_1 = var_0 + ( 0, 0, 30 );
    var_2 = var_0 + ( 0, 0, -1000 );
    var_3 = bullettrace( var_1, var_2, 0, undefined );
    level.jackpot_zone.origin = var_3["position"] + ( 0, 0, 1 );
    level.jackpot_zone show();
    var_4 = vectortoangles( var_3["normal"] );
    var_5 = anglestoforward( var_4 );
    var_6 = anglestoright( var_4 );
    thread _ID30883( var_3["position"], var_5, var_6, 0.5 );
    wait 0.1;
    playfxontag( level._ID21761["smoke"], level.jackpot_zone, "tag_fx" );

    foreach ( var_8 in level.players )
        var_8.mugger_fx_playing = 1;

    level.jackpot_zone.mugger_fx_playing = 1;
}

_ID21768()
{
    stopfxontag( level._ID21761["smoke"], level.jackpot_zone, "tag_fx" );
    level.jackpot_zone hide();

    if ( isdefined( level.jackpot_targetfx ) )
        level.jackpot_targetfx delete();

    if ( level.jackpot_zone.mugger_fx_playing )
    {
        level.jackpot_zone.mugger_fx_playing = 0;
        stopfxontag( level._ID21761["smoke"], level.jackpot_zone, "tag_fx" );
        wait 0.05;
    }
}

_ID30883( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( level.jackpot_targetfx ) )
        level.jackpot_targetfx delete();

    wait(var_3);
    level.jackpot_targetfx = spawnfx( level._ID21792, var_0, var_1, var_2 );
    triggerfx( level.jackpot_targetfx );
}

_ID35599()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    maps\mp\_utility::gameflagwait( "prematch_done" );
    wait 0.5;

    if ( level.jackpot_zone.mugger_fx_playing == 1 && !isdefined( self.mugger_fx_playing ) )
    {
        playfxontagforclients( level._ID21761["smoke"], level.jackpot_zone, "tag_fx", self );
        self.mugger_fx_playing = 1;
    }
}

_ID21773( var_0 )
{
    level endon( "game_ended" );
    level endon( "jackpot_timeout" );
    level notify( "jackpot_stop" );
    _ID21771( var_0, "mugger_jackpot", level._ID21775 );
    level thread _ID21767( var_0 );
    level thread _ID21764( 30 );
    level waittill( "airdrop_jackpot_landed",  var_0  );
    objective_position( level._ID18896, var_0 );
    level.jackpotpileicon.x = var_0[0];
    level.jackpotpileicon.y = var_0[1];
    level.jackpotpileicon.z = var_0[2] + 32;

    foreach ( var_2 in level.players )
    {
        var_2 playsoundtoplayer( "mp_defcon_one", var_2 );
        var_2 thread maps\mp\gametypes\_hud_message::_ID31052( "mugger_jackpot", level._ID21775 );
    }

    level.mugger_jackpot_tags_spawned = 0;

    while ( level._ID21775 > 0 )
    {
        if ( level.mugger_jackpot_tags_spawned < 10 )
        {
            level._ID21775--;
            var_4 = _ID21791( var_0, 0, 400 );
            var_4.jackpot_tag = 1;
            level.mugger_jackpot_tags_spawned++;
            level thread _ID21764( 90 );
            wait 0.1;
            continue;
        }

        wait 0.5;
    }

    level._ID21770 = 0;

    while ( level.mugger_jackpot_tags_spawned > 0 )
        wait 1;

    _ID21765();
}

_ID21765()
{
    level notify( "jackpot_cleanup" );
    _ID21772();
    _ID21768();
    level thread _ID21779();
}

_ID21764( var_0 )
{
    level endon( "jackpot_cleanup" );
    level notify( "jackpot_abort_after_time" );
    level endon( "jackpot_abort_after_time" );
    wait(var_0);
    level notify( "jackpot_timeout" );
}

createmuggercrates( var_0, var_1 )
{
    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_mugger", "airdrop_jackpot", 1, ::_ID21795 );
}

_ID21795( var_0 )
{
    self endon( "death" );
    level notify( "airdrop_jackpot_landed",  self.origin  );
    wait 0.5;
    maps\mp\killstreaks\_airdrop::deletecrate();
}

createdropzones()
{
    level._ID21758 = [];
    var_0 = common_scripts\utility::_ID15386( "horde_drop", "targetname" );

    if ( isdefined( var_0 ) && var_0.size )
    {
        var_1 = 0;

        foreach ( var_3 in var_0 )
        {
            level._ID21758[level.script][var_1] = var_3.origin;
            var_1++;
        }
    }
    else
    {
        level._ID21758["mp_seatown"][0] = ( -665, -209, 226 );
        level._ID21758["mp_seatown"][1] = ( -2225, 1573, 260 );
        level._ID21758["mp_seatown"][2] = ( 1275, -747, 292 );
        level._ID21758["mp_seatown"][3] = ( 1210, 963, 225 );
        level._ID21758["mp_seatown"][4] = ( -2343, -811, 226 );
        level._ID21758["mp_seatown"][5] = ( -1125, -1610, 184 );
        level._ID21758["mp_dome"][0] = ( 649, 1096, -250 );
        level._ID21758["mp_dome"][1] = ( 953, -501, -328 );
        level._ID21758["mp_dome"][2] = ( -37, 2099, -231 );
        level._ID21758["mp_dome"][3] = ( -716, 1100, -296 );
        level._ID21758["mp_dome"][4] = ( -683, -51, -352 );
        level._ID21758["mp_plaza2"][0] = ( 266, -212, 708 );
        level._ID21758["mp_plaza2"][1] = ( 295, 1842, 668 );
        level._ID21758["mp_plaza2"][2] = ( -1449, 1833, 692 );
        level._ID21758["mp_plaza2"][3] = ( 835, -1815, 668 );
        level._ID21758["mp_plaza2"][4] = ( -1116, 76, 729 );
        level._ID21758["mp_plaza2"][5] = ( -399, 951, 676 );
        level._ID21758["mp_mogadishu"][0] = ( 552, 1315, 8 );
        level._ID21758["mp_mogadishu"][1] = ( 990, 3248, 144 );
        level._ID21758["mp_mogadishu"][2] = ( -879, 2643, 135 );
        level._ID21758["mp_mogadishu"][3] = ( -68, -995, 16 );
        level._ID21758["mp_mogadishu"][4] = ( 1499, -1206, 15 );
        level._ID21758["mp_mogadishu"][5] = ( 2387, 1786, 61 );
        level._ID21758["mp_paris"][0] = ( -150, -80, 63 );
        level._ID21758["mp_paris"][1] = ( -947, -1088, 107 );
        level._ID21758["mp_paris"][2] = ( 1052, -614, 50 );
        level._ID21758["mp_paris"][3] = ( 1886, 648, 24 );
        level._ID21758["mp_paris"][4] = ( 628, 2096, 30 );
        level._ID21758["mp_paris"][5] = ( -2033, 1082, 308 );
        level._ID21758["mp_paris"][6] = ( -1230, 1836, 295 );
        level._ID21758["mp_exchange"][0] = ( 904, 441, -77 );
        level._ID21758["mp_exchange"][1] = ( -1056, 1435, 141 );
        level._ID21758["mp_exchange"][2] = ( 800, 1543, 148 );
        level._ID21758["mp_exchange"][3] = ( 2423, 1368, 141 );
        level._ID21758["mp_exchange"][4] = ( 596, -1870, 89 );
        level._ID21758["mp_exchange"][5] = ( -1241, -821, 30 );
        level._ID21758["mp_bootleg"][0] = ( -444, -114, -8 );
        level._ID21758["mp_bootleg"][1] = ( 1053, -1051, -13 );
        level._ID21758["mp_bootleg"][2] = ( 889, 1184, -28 );
        level._ID21758["mp_bootleg"][3] = ( -994, 1877, -41 );
        level._ID21758["mp_bootleg"][4] = ( -1707, -1333, 63 );
        level._ID21758["mp_bootleg"][5] = ( -334, -2155, 61 );
        level._ID21758["mp_carbon"][0] = ( -1791, -3892, 3813 );
        level._ID21758["mp_carbon"][1] = ( -338, -4978, 3964 );
        level._ID21758["mp_carbon"][2] = ( -82, -2941, 3990 );
        level._ID21758["mp_carbon"][3] = ( -3198, -2829, 3809 );
        level._ID21758["mp_carbon"][4] = ( -3673, -3893, 3610 );
        level._ID21758["mp_carbon"][5] = ( -2986, -4863, 3648 );
        level._ID21758["mp_hardhat"][0] = ( 1187, -322, 238 );
        level._ID21758["mp_hardhat"][1] = ( 2010, -1379, 357 );
        level._ID21758["mp_hardhat"][2] = ( 1615, 1245, 366 );
        level._ID21758["mp_hardhat"][3] = ( -371, 825, 436 );
        level._ID21758["mp_hardhat"][4] = ( -820, -927, 348 );
        level._ID21758["mp_alpha"][0] = ( -239, 1315, 52 );
        level._ID21758["mp_alpha"][1] = ( -1678, -219, 55 );
        level._ID21758["mp_alpha"][2] = ( 235, -369, 60 );
        level._ID21758["mp_alpha"][3] = ( -201, 2138, 60 );
        level._ID21758["mp_alpha"][4] = ( -1903, 2433, 198 );
        level._ID21758["mp_village"][0] = ( 990, -821, 331 );
        level._ID21758["mp_village"][1] = ( 658, 2155, 337 );
        level._ID21758["mp_village"][2] = ( -559, 1882, 310 );
        level._ID21758["mp_village"][3] = ( -1999, 1184, 343 );
        level._ID21758["mp_village"][4] = ( 215, -2875, 384 );
        level._ID21758["mp_village"][5] = ( 1731, -483, 290 );
        level._ID21758["mp_lambeth"][0] = ( 712, 217, -196 );
        level._ID21758["mp_lambeth"][1] = ( 1719, -1095, -196 );
        level._ID21758["mp_lambeth"][2] = ( 2843, 1034, -269 );
        level._ID21758["mp_lambeth"][3] = ( 1251, 2645, -213 );
        level._ID21758["mp_lambeth"][4] = ( -1114, 1301, -200 );
        level._ID21758["mp_lambeth"][5] = ( -693, -823, -132 );
        level._ID21758["mp_radar"][0] = ( -5052, 2371, 1223 );
        level._ID21758["mp_radar"][1] = ( -4550, 4199, 1268 );
        level._ID21758["mp_radar"][2] = ( -7149, 4449, 1376 );
        level._ID21758["mp_radar"][3] = ( -6350, 1528, 1302 );
        level._ID21758["mp_radar"][4] = ( -3333, 992, 1222 );
        level._ID21758["mp_radar"][5] = ( -4040, -361, 1222 );
        level._ID21758["mp_interchange"][0] = ( 662, -513, 142 );
        level._ID21758["mp_interchange"][1] = ( 674, 1724, 112 );
        level._ID21758["mp_interchange"][2] = ( -1003, 1103, 30 );
        level._ID21758["mp_interchange"][3] = ( 385, -2910, 209 );
        level._ID21758["mp_interchange"][4] = ( 2004, -1760, 144 );
        level._ID21758["mp_interchange"][5] = ( 2458, -300, 147 );
        level._ID21758["mp_underground"][0] = ( 31, 1319, -196 );
        level._ID21758["mp_underground"][1] = ( 165, -940, 60 );
        level._ID21758["mp_underground"][2] = ( -747, 143, 4 );
        level._ID21758["mp_underground"][3] = ( -1671, 1666, -216 );
        level._ID21758["mp_underground"][4] = ( -631, 3158, -68 );
        level._ID21758["mp_underground"][5] = ( 500, 2865, -89 );
        level._ID21758["mp_bravo"][0] = ( -39, -119, 1280 );
        level._ID21758["mp_bravo"][1] = ( 1861, -563, 1229 );
        level._ID21758["mp_bravo"][2] = ( -1548, -366, 1007 );
        level._ID21758["mp_bravo"][3] = ( -678, 1272, 1273 );
        level._ID21758["mp_bravo"][4] = ( 1438, 842, 1272 );
    }
}
