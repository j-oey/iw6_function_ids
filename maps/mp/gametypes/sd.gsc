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
        maps\mp\_utility::_ID25718( level._ID14086, 2.5 );
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
    level._ID22892 = ::_ID22892;
    level._ID22905 = ::_ID22905;
    level.getspawnpoint = ::getspawnpoint;
    level._ID22902 = ::_ID22902;
    level._ID22886 = ::_ID22886;
    level._ID22796 = ::_ID22796;
    level._ID22870 = ::_ID22870;
    level._ID22913 = ::_ID22913;
    level._ID22869 = ::_ID22869;
    level._ID17937 = ::_ID17937;
    level.gamemodemaydropweapon = maps\mp\_utility::isplayeroutsideofanybombsite;
    level.allowlatecomers = 0;

    if ( level._ID20676 || level._ID20680 )
        level._ID21286 = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    game["dialog"]["gametype"] = "searchdestroy";

    if ( getdvarint( "g_hardcore" ) )
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
    else if ( getdvarint( "camera_thirdPerson" ) )
        game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
    else if ( getdvarint( "scr_diehard" ) )
        game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
    else if ( getdvarint( "scr_" + level._ID14086 + "_promode" ) )
        game["dialog"]["gametype"] += "_pro";

    game["dialog"]["offense_obj"] = "obj_destroy";
    game["dialog"]["defense_obj"] = "obj_defend";
    game["dialog"]["lead_lost"] = "null";
    game["dialog"]["lead_tied"] = "null";
    game["dialog"]["lead_taken"] = "null";
    setomnvar( "ui_bomb_timer_endtime", 0 );
}

initializematchrules()
{
    maps\mp\_utility::_ID28682();
    var_0 = getmatchrulesdata( "sdData", "roundLength" );
    setdynamicdvar( "scr_sd_timelimit", var_0 );
    maps\mp\_utility::_ID25718( "sd", var_0 );
    var_1 = getmatchrulesdata( "sdData", "roundSwitch" );
    setdynamicdvar( "scr_sd_roundswitch", var_1 );
    maps\mp\_utility::_ID25715( "sd", var_1, 0, 9 );
    var_2 = getmatchrulesdata( "commonOption", "scoreLimit" );
    setdynamicdvar( "scr_sd_winlimit", var_2 );
    maps\mp\_utility::_ID25724( "sd", var_2 );
    setdynamicdvar( "scr_sd_bombtimer", getmatchrulesdata( "sdData", "bombTimer" ) );
    setdynamicdvar( "scr_sd_planttime", getmatchrulesdata( "sdData", "plantTime" ) );
    setdynamicdvar( "scr_sd_defusetime", getmatchrulesdata( "sdData", "defuseTime" ) );
    setdynamicdvar( "scr_sd_multibomb", getmatchrulesdata( "sdData", "multiBomb" ) );
    setdynamicdvar( "scr_sd_roundlimit", 0 );
    maps\mp\_utility::_ID25714( "sd", 0 );
    setdynamicdvar( "scr_sd_scorelimit", 1 );
    maps\mp\_utility::_ID25717( "sd", 1 );
    setdynamicdvar( "scr_sd_halftime", 0 );
    maps\mp\_utility::_ID25706( "sd", 0 );
    setdynamicdvar( "scr_sd_promode", 0 );
}

_ID22892()
{
    game["bomb_dropped_sound"] = "mp_war_objective_lost";
    game["bomb_recovered_sound"] = "mp_war_objective_taken";
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

    setclientnamemode( "manual_change" );
    level._ID1644["bomb_explosion"] = loadfx( "fx/explosions/tanker_explosion" );
    level._ID1644["vehicle_explosion"] = loadfx( "fx/explosions/small_vehicle_explosion_new" );
    level._ID1644["building_explosion"] = loadfx( "fx/explosions/building_explosion_gulag" );
    maps\mp\_utility::_ID28804( game["attackers"], &"OBJECTIVES_SD_ATTACKER" );
    maps\mp\_utility::_ID28804( game["defenders"], &"OBJECTIVES_SD_DEFENDER" );

    if ( level.splitscreen )
    {
        maps\mp\_utility::_ID28803( game["attackers"], &"OBJECTIVES_SD_ATTACKER" );
        maps\mp\_utility::_ID28803( game["defenders"], &"OBJECTIVES_SD_DEFENDER" );
    }
    else
    {
        maps\mp\_utility::_ID28803( game["attackers"], &"OBJECTIVES_SD_ATTACKER_SCORE" );
        maps\mp\_utility::_ID28803( game["defenders"], &"OBJECTIVES_SD_DEFENDER_SCORE" );
    }

    maps\mp\_utility::setobjectivehinttext( game["attackers"], &"OBJECTIVES_SD_ATTACKER_HINT" );
    maps\mp\_utility::setobjectivehinttext( game["defenders"], &"OBJECTIVES_SD_DEFENDER_HINT" );
    initspawns();
    var_2[0] = "sd";
    var_2[1] = "bombzone";
    var_2[2] = "blocker";
    maps\mp\gametypes\_gameobjects::_ID20445( var_2 );
    _ID34544();
    _ID28878();
    thread _ID5465();
}

initspawns()
{
    level._ID30895 = ( 0, 0, 0 );
    level._ID30893 = ( 0, 0, 0 );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_sd_spawn_attacker" );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_sd_spawn_defender" );
    level._ID20634 = maps\mp\gametypes\_spawnlogic::findboxcenter( level._ID30895, level._ID30893 );
    setmapcenter( level._ID20634 );
}

getspawnpoint()
{
    var_0 = "mp_sd_spawn_defender";

    if ( self.pers["team"] == game["attackers"] )
        var_0 = "mp_sd_spawn_attacker";

    var_1 = maps\mp\gametypes\_spawnlogic::_ID15350( var_0 );
    var_2 = maps\mp\gametypes\_spawnlogic::_ID15349( var_1 );
    return var_2;
}

_ID22902()
{
    if ( maps\mp\_utility::_ID18638( self ) )
    {
        self.isplanting = 0;
        self.isdefusing = 0;
        self.isbombcarrier = 0;
    }

    if ( level._ID21797 && self.pers["team"] == game["attackers"] )
        self setclientomnvar( "ui_carrying_bomb", 1 );
    else
        self setclientomnvar( "ui_carrying_bomb", 0 );

    maps\mp\_utility::setextrascore0( 0 );

    if ( isdefined( self.pers["plants"] ) )
        maps\mp\_utility::setextrascore0( self.pers["plants"] );

    level notify( "spawned_player" );
}

_ID22886( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    self setclientomnvar( "ui_carrying_bomb", 0 );
    thread _ID7057();
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

_ID27937( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        if ( !isai( var_3 ) )
            var_3 setclientomnvar( "ui_bomb_planting_defusing", 0 );
    }

    level.finalkillcam_winner = var_0;

    if ( var_1 == game["end_reason"]["target_destroyed"] || var_1 == game["end_reason"]["bomb_defused"] )
    {
        var_5 = 1;

        foreach ( var_7 in level.bombzones )
        {
            if ( isdefined( level.finalkillcam_killcamentityindex[var_0] ) && level.finalkillcam_killcamentityindex[var_0] == var_7._ID19215 )
            {
                var_5 = 0;
                break;
            }
        }

        if ( var_5 )
            maps\mp\gametypes\_damage::erasefinalkillcam();
    }

    thread maps\mp\gametypes\_gamelogic::endgame( var_0, var_1 );
}

_ID22796( var_0 )
{
    if ( level.bombexploded || level._ID5457 )
        return;

    if ( var_0 == "all" )
    {
        if ( level.bombplanted )
            _ID27937( game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"] );
        else
            _ID27937( game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"] );
    }
    else if ( var_0 == game["attackers"] )
    {
        if ( level.bombplanted )
            return;

        level thread _ID27937( game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"] );
    }
    else if ( var_0 == game["defenders"] )
        level thread _ID27937( game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"] );
}

_ID22870( var_0 )
{
    if ( level.bombexploded || level._ID5457 )
        return;

    var_1 = maps\mp\_utility::_ID15113( var_0 );
    var_1 thread _ID15604();
}

_ID22869( var_0, var_1, var_2 )
{
    var_3 = maps\mp\gametypes\_rank::_ID15328( "kill" );
    var_4 = var_0.team;

    if ( game["state"] == "postgame" && ( var_0.team == game["defenders"] || !level.bombplanted ) )
        var_1._ID12872 = 1;

    if ( var_0.isplanting )
    {
        thread maps\mp\_matchdata::_ID20250( var_2, "planting" );
        var_1 maps\mp\_utility::_ID17529( "defends", 1 );
        var_1 maps\mp\gametypes\_persistence::_ID31528( "round", "defends", var_1.pers["defends"] );
    }
    else if ( var_0.isbombcarrier )
    {
        var_1 maps\mp\_utility::_ID17531( "bombcarrierkills", 1 );
        thread maps\mp\_matchdata::_ID20250( var_2, "carrying" );
    }
    else if ( var_0.isdefusing )
    {
        thread maps\mp\_matchdata::_ID20250( var_2, "defusing" );
        var_1 maps\mp\_utility::_ID17529( "defends", 1 );
        var_1 maps\mp\gametypes\_persistence::_ID31528( "round", "defends", var_1.pers["defends"] );
    }

    if ( var_1.isbombcarrier )
        var_1 maps\mp\_utility::_ID17531( "killsasbombcarrier", 1 );
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
    _ID27937( game["defenders"], game["end_reason"]["time_limit_reached"] );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1._ID36797 ) )
        {
            var_1 takeweapon( var_1._ID36797 );
            break;
        }
    }
}

_ID34544()
{
    level._ID23712 = maps\mp\_utility::_ID11160( "planttime", 5, 0, 20 );
    level.defusetime = maps\mp\_utility::_ID11160( "defusetime", 5, 0, 20 );
    level.bombtimer = maps\mp\_utility::_ID11160( "bombtimer", 45, 1, 300 );
    level._ID21797 = maps\mp\_utility::_ID11161( "multibomb", 0, 0, 1 );
}

_ID25982( var_0 )
{
    var_1 = [];
    var_2 = getentarray( "script_brushmodel", "classname" );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4._ID27614 ) && var_4._ID27614 == "bombzone" )
        {
            foreach ( var_6 in var_0 )
            {
                if ( distance( var_4.origin, var_6.origin ) < 100 && issubstr( tolower( var_6._ID27658 ), "c" ) )
                {
                    var_6._ID25728 = var_4;
                    var_1[var_1.size] = var_6;
                    break;
                }
            }
        }
    }

    foreach ( var_10 in var_1 )
    {
        var_10._ID25728 delete();
        var_11 = getentarray( var_10.target, "targetname" );

        foreach ( var_13 in var_11 )
            var_13 delete();

        var_10 delete();
    }

    return common_scripts\utility::array_removeundefined( var_0 );
}

_ID5465()
{
    level.bombplanted = 0;
    level._ID5457 = 0;
    level.bombexploded = 0;
    var_0 = getent( "sd_bomb_pickup_trig", "targetname" );

    if ( !isdefined( var_0 ) )
    {
        common_scripts\utility::error( "No sd_bomb_pickup_trig trigger found in map." );
        return;
    }

    var_1[0] = getent( "sd_bomb", "targetname" );

    if ( !isdefined( var_1[0] ) )
    {
        common_scripts\utility::error( "No sd_bomb script_model found in map." );
        return;
    }

    var_1[0] setmodel( "weapon_briefcase_bomb_iw6" );

    if ( !level._ID21797 )
    {
        level.sdbomb = maps\mp\gametypes\_gameobjects::_ID8396( game["attackers"], var_0, var_1, ( 0, 0, 32 ) );
        level.sdbomb maps\mp\gametypes\_gameobjects::_ID2974( "friendly" );
        level.sdbomb maps\mp\gametypes\_gameobjects::_ID28180( "friendly", "waypoint_bomb" );
        level.sdbomb maps\mp\gametypes\_gameobjects::_ID28181( "friendly", "waypoint_bomb" );
        level.sdbomb maps\mp\gametypes\_gameobjects::_ID29202( "friendly" );
        level.sdbomb.allowweapons = 1;
        level.sdbomb.onpickup = ::onpickup;
        level.sdbomb._ID22810 = ::_ID22810;
    }
    else
    {
        var_0 delete();
        var_1[0] delete();
    }

    level.bombzones = [];
    var_2 = getentarray( "bombzone", "targetname" );
    var_2 = _ID25982( var_2 );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_0 = var_2[var_3];
        var_1 = getentarray( var_2[var_3].target, "targetname" );
        var_4 = maps\mp\gametypes\_gameobjects::_ID8493( game["defenders"], var_0, var_1, ( 0, 0, 64 ) );
        var_4._ID17334 = "bomb_zone";
        var_4 maps\mp\gametypes\_gameobjects::allowuse( "enemy" );
        var_4 maps\mp\gametypes\_gameobjects::_ID29198( level._ID23712 );
        var_4 maps\mp\gametypes\_gameobjects::setwaitweaponchangeonuse( 0 );
        var_4 maps\mp\gametypes\_gameobjects::_ID29197( &"MP_PLANTING_EXPLOSIVE" );
        var_4 maps\mp\gametypes\_gameobjects::_ID29196( &"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES" );

        if ( !level._ID21797 )
            var_4 maps\mp\gametypes\_gameobjects::_ID28764( level.sdbomb );

        var_5 = var_4 maps\mp\gametypes\_gameobjects::_ID15110();
        var_4.label = var_5;
        var_4 maps\mp\gametypes\_gameobjects::_ID28180( "friendly", "waypoint_defend" + var_5 );
        var_4 maps\mp\gametypes\_gameobjects::_ID28181( "friendly", "waypoint_defend" + var_5 );
        var_4 maps\mp\gametypes\_gameobjects::_ID28180( "enemy", "waypoint_target" + var_5 );
        var_4 maps\mp\gametypes\_gameobjects::_ID28181( "enemy", "waypoint_target" + var_5 );
        var_4 maps\mp\gametypes\_gameobjects::_ID29202( "any" );
        var_4._ID22779 = ::_ID22779;
        var_4._ID22816 = ::_ID22816;
        var_4._ID22916 = ::onuseplantobject;
        var_4._ID22785 = ::_ID22785;
        var_4._ID34784 = "briefcase_bomb_mp";

        for ( var_6 = 0; var_6 < var_1.size; var_6++ )
        {
            if ( isdefined( var_1[var_6]._ID27562 ) )
            {
                var_4._ID12489 = var_1[var_6]._ID27562;
                var_1[var_6] thread _ID29181( var_4 );
                break;
            }
        }

        level.bombzones[level.bombzones.size] = var_4;
        var_4.bombdefusetrig = getent( var_1[0].target, "targetname" );
        var_4.bombdefusetrig.origin = var_4.bombdefusetrig.origin + ( 0, 0, -10000 );
        var_4.bombdefusetrig.label = var_5;
    }

    for ( var_3 = 0; var_3 < level.bombzones.size; var_3++ )
    {
        var_7 = [];

        for ( var_8 = 0; var_8 < level.bombzones.size; var_8++ )
        {
            if ( var_8 != var_3 )
                var_7[var_7.size] = level.bombzones[var_8];
        }

        level.bombzones[var_3]._ID23067 = var_7;
    }
}

_ID29181( var_0 )
{
    var_1 = spawn( "script_origin", self.origin );
    var_1.angles = self.angles;
    var_1 rotateyaw( -45, 0.05 );
    wait 0.05;
    var_2 = undefined;

    if ( isdefined( level._ID38116 ) && isdefined( level._ID38116[var_0.label] ) )
        var_2 = level._ID38116[var_0.label];
    else
    {
        var_3 = self.origin + ( 0, 0, 5 );
        var_4 = self.origin + anglestoforward( var_1.angles ) * 100 + ( 0, 0, 128 );
        var_5 = bullettrace( var_3, var_4, 0, self );
        var_2 = var_5["position"];
    }

    self._ID19214 = spawn( "script_model", var_2 );
    self._ID19214 setscriptmoverkillcam( "explosive" );
    var_0._ID19215 = self._ID19214 getentitynumber();
    var_1 delete();
}

_ID22779( var_0 )
{
    if ( maps\mp\gametypes\_gameobjects::isfriendlyteam( var_0.pers["team"] ) )
    {
        var_0 maps\mp\_utility::_ID22279( "defuse" );
        var_0.isdefusing = 1;

        if ( isdefined( level._ID27946 ) )
            level._ID27946 hide();

        var_0 thread startnpcbombusesound( "briefcase_bomb_defuse_mp", "weap_suitcase_defuse_button" );
    }
    else
    {
        var_0 maps\mp\_utility::_ID22279( "plant" );
        var_0.isplanting = 1;
        var_0._ID36797 = self._ID34784;
        var_0 thread startnpcbombusesound( "briefcase_bomb_mp", "weap_suitcase_raise_button" );

        if ( level._ID21797 )
        {
            for ( var_1 = 0; var_1 < self._ID23067.size; var_1++ )
            {
                self._ID23067[var_1] maps\mp\gametypes\_gameobjects::allowuse( "none" );
                self._ID23067[var_1] maps\mp\gametypes\_gameobjects::_ID29202( "friendly" );
            }
        }
    }
}

_ID22816( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        return;

    var_1._ID36797 = undefined;

    if ( isalive( var_1 ) )
    {
        var_1.isdefusing = 0;
        var_1.isplanting = 0;
    }

    if ( isplayer( var_1 ) )
    {
        var_1 setclientomnvar( "ui_bomb_planting_defusing", 0 );
        var_1.ui_bomb_planting_defusing = undefined;
    }

    if ( maps\mp\gametypes\_gameobjects::isfriendlyteam( var_1.pers["team"] ) )
    {
        if ( isdefined( level._ID27946 ) && !var_2 )
            level._ID27946 show();
    }
    else if ( level._ID21797 && !var_2 )
    {
        for ( var_3 = 0; var_3 < self._ID23067.size; var_3++ )
        {
            self._ID23067[var_3] maps\mp\gametypes\_gameobjects::allowuse( "enemy" );
            self._ID23067[var_3] maps\mp\gametypes\_gameobjects::_ID29202( "any" );
        }
    }
}

startnpcbombusesound( var_0, var_1 )
{
    self endon( "death" );
    self endon( "stopNpcBombSound" );

    if ( maps\mp\_utility::isanymlgmatch() )
        return;

    var_2 = "";

    while ( var_2 != var_0 )
        self waittill( "weapon_change",  var_2  );

    self playsoundtoteam( var_1, self.team, self );
    var_3 = maps\mp\_utility::getotherteam( self.team );
    self playsoundtoteam( var_1, var_3 );
    self waittill( "weapon_change" );
    self notify( "stopNpcBombSound" );
}

_ID22785( var_0 )
{
    var_0 iprintlnbold( &"MP_CANT_PLANT_WITHOUT_BOMB" );
}

onuseplantobject( var_0 )
{
    if ( !maps\mp\gametypes\_gameobjects::isfriendlyteam( var_0.pers["team"] ) )
    {
        level thread bombplanted( self, var_0 );

        for ( var_1 = 0; var_1 < level.bombzones.size; var_1++ )
        {
            if ( level.bombzones[var_1] == self )
                continue;

            level.bombzones[var_1] maps\mp\gametypes\_gameobjects::_ID10167();
        }

        var_0 playsound( "mp_bomb_plant" );
        var_0 notify( "bomb_planted" );
        var_0 notify( "objective",  "plant"  );
        var_0 maps\mp\_utility::_ID17529( "plants", 1 );
        var_0 maps\mp\gametypes\_persistence::_ID31528( "round", "plants", var_0.pers["plants"] );
        var_0 maps\mp\_utility::setextrascore0( var_0.pers["plants"] );

        if ( isdefined( level.sd_loadout ) && isdefined( level.sd_loadout[var_0.team] ) )
            var_0 thread _ID25981();

        maps\mp\_utility::_ID19760( "bomb_planted" );
        level thread maps\mp\_utility::_ID32672( "callout_bombplanted", var_0 );
        level.bombowner = var_0;
        var_0 thread maps\mp\gametypes\_hud_message::_ID31052( "plant", maps\mp\gametypes\_rank::_ID15328( "plant" ) );
        var_0 thread maps\mp\gametypes\_rank::_ID36462( "plant" );
        var_0 thread maps\mp\gametypes\_rank::giverankxp( "plant" );
        var_0.bombplantedtime = gettime();
        maps\mp\gametypes\_gamescore::_ID15616( "plant", var_0 );

        if ( isplayer( var_0 ) )
            var_0 thread maps\mp\_matchdata::loggameevent( "plant", var_0.origin );
    }
}

applybombcarrierclass()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( isdefined( self._ID18582 ) && self._ID18582 == 1 )
    {
        self notify( "force_cancel_placement" );
        wait 0.05;
    }

    while ( self ismantling() )
        wait 0.05;

    while ( !self isonground() )
        wait 0.05;

    if ( maps\mp\_utility::_ID18666() )
    {
        self notify( "lost_juggernaut" );
        wait 0.05;
    }

    self.pers["gamemodeLoadout"] = level.sd_loadout[self.team];

    if ( isdefined( self.setspawnpoint ) )
        maps\mp\perks\_perkfunctions::deleteti( self.setspawnpoint );

    var_0 = spawn( "script_model", self.origin );
    var_0.angles = self.angles;
    var_0._ID24539 = self.origin;
    var_0._ID22328 = 1;
    self.setspawnpoint = var_0;
    self._ID14071 = self.class;
    self.pers["class"] = "gamemode";
    self.pers["lastClass"] = "gamemode";
    self.class = "gamemode";
    self.lastclass = "gamemode";
    self notify( "faux_spawn" );
    self._ID14076 = 1;
    self.faux_spawn_stance = self getstance();
    thread maps\mp\gametypes\_playerlogic::spawnplayer( 1 );
}

_ID25981()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( isdefined( self._ID18582 ) && self._ID18582 == 1 )
    {
        self notify( "force_cancel_placement" );
        wait 0.05;
    }

    while ( self ismantling() )
        wait 0.05;

    while ( !self isonground() )
        wait 0.05;

    if ( maps\mp\_utility::_ID18666() )
    {
        self notify( "lost_juggernaut" );
        wait 0.05;
    }

    self.pers["gamemodeLoadout"] = undefined;

    if ( isdefined( self.setspawnpoint ) )
        maps\mp\perks\_perkfunctions::deleteti( self.setspawnpoint );

    var_0 = spawn( "script_model", self.origin );
    var_0.angles = self.angles;
    var_0._ID24539 = self.origin;
    var_0._ID22328 = 1;
    self.setspawnpoint = var_0;
    self notify( "faux_spawn" );
    self.faux_spawn_stance = self getstance();
    thread maps\mp\gametypes\_playerlogic::spawnplayer( 1 );
}

onusedefuseobject( var_0 )
{
    var_0 notify( "bomb_defused" );
    var_0 notify( "objective",  "defuse"  );
    level thread _ID5457();
    maps\mp\gametypes\_gameobjects::_ID10167();
    maps\mp\_utility::_ID19760( "bomb_defused_" + var_0.team );
    level thread maps\mp\_utility::_ID32672( "callout_bombdefused", var_0 );

    if ( isdefined( level.bombowner ) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && maps\mp\_utility::_ID18757( level.bombowner ) )
        var_0 thread maps\mp\gametypes\_hud_message::_ID31052( "ninja_defuse", maps\mp\gametypes\_rank::_ID15328( "defuse" ) );
    else
        var_0 thread maps\mp\gametypes\_hud_message::_ID31052( "defuse", maps\mp\gametypes\_rank::_ID15328( "defuse" ) );

    var_0 thread maps\mp\gametypes\_rank::_ID36462( "defuse" );
    var_0 thread maps\mp\gametypes\_rank::giverankxp( "defuse" );
    maps\mp\gametypes\_gamescore::_ID15616( "defuse", var_0 );
    var_0 maps\mp\_utility::_ID17529( "defuses", 1 );
    var_0 maps\mp\gametypes\_persistence::_ID31528( "round", "defuses", var_0.pers["defuses"] );

    if ( isplayer( var_0 ) )
        var_0 thread maps\mp\_matchdata::loggameevent( "defuse", var_0.origin );
}

_ID22810( var_0 )
{
    level notify( "bomb_dropped" );
    setomnvar( "ui_bomb_carrier", -1 );
    maps\mp\gametypes\_gameobjects::_ID28180( "friendly", "waypoint_bomb" );
    maps\mp\gametypes\_gameobjects::_ID28181( "friendly", "waypoint_bomb" );
    maps\mp\_utility::_ID24645( game["bomb_dropped_sound"], game["attackers"] );
}

onpickup( var_0 )
{
    var_0.isbombcarrier = 1;
    var_0 maps\mp\_utility::_ID17531( "bombscarried", 1 );

    if ( isplayer( var_0 ) )
        var_0 thread maps\mp\_matchdata::loggameevent( "pickup", var_0.origin );

    var_0 setclientomnvar( "ui_carrying_bomb", 1 );
    setomnvar( "ui_bomb_carrier", var_0 getentitynumber() );
    maps\mp\gametypes\_gameobjects::_ID28180( "friendly", "waypoint_escort" );
    maps\mp\gametypes\_gameobjects::_ID28181( "friendly", "waypoint_escort" );

    if ( isdefined( level.sd_loadout ) && isdefined( level.sd_loadout[var_0.team] ) )
        var_0 thread applybombcarrierclass();

    if ( !level._ID5457 )
    {
        maps\mp\_utility::_ID32672( "callout_bombtaken", var_0, var_0.team );
        maps\mp\_utility::_ID19760( "bomb_taken", var_0.pers["team"] );
    }

    maps\mp\_utility::_ID24645( game["bomb_recovered_sound"], game["attackers"] );
}

_ID22893()
{

}

bombplanted( var_0, var_1 )
{
    level notify( "bomb_planted",  var_0  );
    maps\mp\gametypes\_gamelogic::_ID23389();
    level.bombplanted = 1;
    var_1 setclientomnvar( "ui_carrying_bomb", 0 );
    setomnvar( "ui_bomb_carrier", -1 );
    var_0._ID35361[0] thread maps\mp\gametypes\_gamelogic::playtickingsound();
    level._ID32974 = var_0._ID35361[0];
    level._ID33056 = 1;
    level.defuseendtime = int( gettime() + level.bombtimer * 1000 );
    setgameendtime( level.defuseendtime );
    setomnvar( "ui_bomb_timer", 1 );

    if ( !level._ID21797 )
    {
        level.sdbomb maps\mp\gametypes\_gameobjects::_ID2974( "none" );
        level.sdbomb maps\mp\gametypes\_gameobjects::_ID29202( "none" );
        level.sdbomb maps\mp\gametypes\_gameobjects::_ID28709();
        level._ID27946 = level.sdbomb._ID35361[0];
    }
    else
    {
        level._ID27946 = spawn( "script_model", var_1.origin );
        level._ID27946.angles = var_1.angles;
        level._ID27946 setmodel( "weapon_briefcase_bomb_iw6" );
    }

    var_0 maps\mp\gametypes\_gameobjects::allowuse( "none" );
    var_0 maps\mp\gametypes\_gameobjects::_ID29202( "none" );
    var_2 = var_0 maps\mp\gametypes\_gameobjects::_ID15110();
    var_3 = var_0.bombdefusetrig;
    var_3.origin = level._ID27946.origin;
    var_4 = [];
    var_5 = maps\mp\gametypes\_gameobjects::_ID8493( game["defenders"], var_3, var_4, ( 0, 0, 32 ) );
    var_5._ID17334 = "defuse_object";
    var_5 maps\mp\gametypes\_gameobjects::allowuse( "friendly" );
    var_5 maps\mp\gametypes\_gameobjects::_ID29198( level.defusetime );
    var_5 maps\mp\gametypes\_gameobjects::setwaitweaponchangeonuse( 0 );
    var_5 maps\mp\gametypes\_gameobjects::_ID29197( &"MP_DEFUSING_EXPLOSIVE" );
    var_5 maps\mp\gametypes\_gameobjects::_ID29196( &"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES" );
    var_5 maps\mp\gametypes\_gameobjects::_ID29202( "any" );
    var_5 maps\mp\gametypes\_gameobjects::_ID28180( "friendly", "waypoint_defuse" + var_2 );
    var_5 maps\mp\gametypes\_gameobjects::_ID28180( "enemy", "waypoint_defend" + var_2 );
    var_5 maps\mp\gametypes\_gameobjects::_ID28181( "friendly", "waypoint_defuse" + var_2 );
    var_5 maps\mp\gametypes\_gameobjects::_ID28181( "enemy", "waypoint_defend" + var_2 );
    var_5.label = var_2;
    var_5._ID22779 = ::_ID22779;
    var_5._ID22816 = ::_ID22816;
    var_5._ID22916 = ::onusedefuseobject;
    var_5._ID34784 = "briefcase_bomb_defuse_mp";
    _ID5474();
    setomnvar( "ui_bomb_timer", 0 );
    var_0._ID35361[0] maps\mp\gametypes\_gamelogic::_ID31859();

    if ( level.gameended || level._ID5457 )
        return;

    level.bombexploded = 1;
    level notify( "bomb_exploded" );

    if ( isdefined( level._ID27942 ) )
        level thread [[ level._ID27942 ]]();

    var_6 = level._ID27946.origin;
    level._ID27946 hide();

    if ( isdefined( var_1 ) )
    {
        var_0._ID35361[0] radiusdamage( var_6, 512, 200, 20, var_1, "MOD_EXPLOSIVE", "bomb_site_mp" );
        var_1 maps\mp\_utility::_ID17529( "destructions", 1 );
        var_1 maps\mp\gametypes\_persistence::_ID31528( "round", "destructions", var_1.pers["destructions"] );
    }
    else
        var_0._ID35361[0] radiusdamage( var_6, 512, 200, 20, undefined, "MOD_EXPLOSIVE", "bomb_site_mp" );

    var_7 = randomfloat( 360 );

    if ( isdefined( var_0.trigger._ID11242 ) )
        var_8 = var_0.trigger._ID11242;
    else
        var_8 = "bomb_explosion";

    var_9 = var_6 + ( 0, 0, 50 );
    var_10 = spawnfx( level._ID1644[var_8], var_9, ( 0, 0, 1 ), ( cos( var_7 ), sin( var_7 ), 0 ) );
    triggerfx( var_10 );
    physicsexplosionsphere( var_9, 200, 100, 3 );
    playrumbleonposition( "grenade_rumble", var_6 );
    earthquake( 0.75, 2.0, var_6, 2000 );
    thread maps\mp\_utility::_ID24644( "exp_suitcase_bomb_main", var_6 );

    if ( isdefined( var_0._ID12489 ) )
        common_scripts\utility::exploder( var_0._ID12489 );

    for ( var_11 = 0; var_11 < level.bombzones.size; var_11++ )
        level.bombzones[var_11] maps\mp\gametypes\_gameobjects::_ID10167();

    var_5 maps\mp\gametypes\_gameobjects::_ID10167();
    setgameendtime( 0 );
    wait 3;
    _ID27937( game["attackers"], game["end_reason"]["target_destroyed"] );
}

_ID17979( var_0 )
{
    var_1 = undefined;
    var_2 = getentarray( "sd_bombcam_start", "targetname" );

    foreach ( var_4 in var_2 )
    {
        if ( var_4._ID27658 == var_0.label )
        {
            var_1 = var_4;
            break;
        }
    }

    var_6 = [];

    if ( isdefined( var_1 ) && isdefined( var_1.target ) )
    {
        var_7 = getent( var_1.target, "targetname" );

        while ( isdefined( var_7 ) )
        {
            var_6[var_6.size] = var_7;

            if ( isdefined( var_7.target ) )
            {
                var_7 = getent( var_7.target, "targetname" );
                continue;
            }

            break;
        }
    }

    if ( isdefined( var_1 ) && var_6.size )
    {
        var_8 = spawn( "script_model", var_1.origin );
        var_8.origin = var_1.origin;
        var_8.angles = var_1.angles;
        var_8._ID23323 = var_6;
        var_8 setmodel( "tag_origin" );
        var_8 hide();
        return var_8;
    }
    else
        return undefined;
}

_ID27038()
{
    level notify( "objective_cam" );

    foreach ( var_1 in level.players )
    {
        if ( !isai( var_1 ) )
        {
            var_1 maps\mp\_utility::_ID13582( 1 );
            var_1 visionsetnakedforplayer( "black_bw", 0.5 );
        }
    }

    wait 0.5;

    foreach ( var_1 in level.players )
    {
        if ( !isai( var_1 ) )
        {
            if ( isdefined( var_1.disabledoffhandweapons ) )
            {
                var_1 maps\mp\_utility::_ID29199( "objective_cam" );
                var_1 common_scripts\utility::_disableweapon();
            }

            var_1 playerlinkweaponviewtodelta( self, "tag_player", 1, 180, 180, 180, 180, 1 );
            var_1 maps\mp\_utility::_ID13582( 1 );
            var_1 setplayerangles( self.angles );
            var_1 visionsetnakedforplayer( "", 0.5 );
        }
    }

    var_5 = 0;

    if ( !getdvarint( "g_hardcore" ) )
    {
        setdynamicdvar( "g_hardcore", 1 );
        var_5 = 1;
    }

    for ( var_6 = 0; var_6 < self._ID23323.size; var_6++ )
    {
        var_7 = 0;

        if ( var_6 == 0 )
            var_7 = 5 / self._ID23323.size / 2;

        var_8 = 0;

        if ( var_6 == self._ID23323.size - 1 )
            var_8 = 5 / self._ID23323.size / 2;

        self moveto( self._ID23323[var_6].origin, 5 / self._ID23323.size, var_7, var_8 );
        self rotateto( self._ID23323[var_6].angles, 5 / self._ID23323.size, var_7, var_8 );
        wait(5 / self._ID23323.size);
    }

    if ( var_5 )
    {
        wait 0.5;
        setdynamicdvar( "g_hardcore", 0 );
    }
}

_ID5474()
{
    level endon( "game_ended" );
    level endon( "bomb_defused" );
    var_0 = int( level.bombtimer * 1000 + gettime() );
    setomnvar( "ui_bomb_timer_endtime", var_0 );
    level thread handlehostmigration( var_0 );
    maps\mp\gametypes\_hostmigration::_ID35596( level.bombtimer );
}

handlehostmigration( var_0 )
{
    level endon( "game_ended" );
    level endon( "bomb_defused" );
    level endon( "game_ended" );
    level endon( "disconnect" );
    level waittill( "host_migration_begin" );
    setomnvar( "ui_bomb_timer_endtime", 0 );
    var_1 = maps\mp\gametypes\_hostmigration::_ID35770();

    if ( var_1 > 0 )
        setomnvar( "ui_bomb_timer_endtime", var_0 + var_1 );
}

_ID5457()
{
    level._ID32974 maps\mp\gametypes\_gamelogic::_ID31859();
    level._ID5457 = 1;
    setomnvar( "ui_bomb_timer", 0 );
    level notify( "bomb_defused" );
    wait 1.5;
    setgameendtime( 0 );
    _ID27937( game["defenders"], game["end_reason"]["bomb_defused"] );
}

_ID17937()
{
    maps\mp\_awards::_ID18002( "targetsdestroyed", 0, maps\mp\_awards::highestwins );
    maps\mp\_awards::_ID18002( "bombsplanted", 0, maps\mp\_awards::highestwins );
    maps\mp\_awards::_ID18002( "bombsdefused", 0, maps\mp\_awards::highestwins );
    maps\mp\_awards::_ID18002( "bombcarrierkills", 0, maps\mp\_awards::highestwins );
    maps\mp\_awards::_ID18002( "bombscarried", 0, maps\mp\_awards::highestwins );
    maps\mp\_awards::_ID18002( "killsasbombcarrier", 0, maps\mp\_awards::highestwins );
}

_ID28878()
{
    if ( isusingmatchrulesdata() && getmatchrulesdata( "defaultClasses", game["attackers"], 5, "class", "inUse" ) )
        level.sd_loadout[game["attackers"]] = maps\mp\_utility::_ID15140( game["attackers"], 5 );
}
