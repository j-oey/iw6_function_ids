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
        maps\mp\_utility::_ID25718( level._ID14086, 10 );
        maps\mp\_utility::_ID28811( "scorelimit", 0 );
        maps\mp\_utility::_ID25714( level._ID14086, 1 );
        maps\mp\_utility::_ID25724( level._ID14086, 1 );
        maps\mp\_utility::_ID25712( level._ID14086, 0 );
        maps\mp\_utility::_ID25706( level._ID14086, 0 );
        level.matchrules_numinitialinfected = 1;
        level._ID20676 = 0;
    }

    _ID28879();
    level._ID32653 = 1;
    level._ID32097 = 0;
    level._ID10157 = 1;
    level._ID22073 = 1;
    level._ID22905 = ::_ID22905;
    level._ID22902 = ::_ID22902;
    level.getspawnpoint = ::getspawnpoint;
    level._ID22886 = ::_ID22886;
    level._ID22796 = ::_ID22796;
    level._ID22913 = ::_ID22913;
    level.bypassclasschoicefunc = ::alwaysgamemodeclass;

    if ( level._ID20676 )
        level._ID21286 = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    game["dialog"]["gametype"] = "infected";

    if ( getdvarint( "g_hardcore" ) )
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];

    game["dialog"]["offense_obj"] = "infct_hint";
}

initializematchrules()
{
    maps\mp\_utility::_ID28682();
    level.matchrules_numinitialinfected = getmatchrulesdata( "infectData", "numInitialInfected" );
    setdynamicdvar( "scr_" + level._ID14086 + "_numLives", 0 );
    maps\mp\_utility::_ID25712( level._ID14086, 0 );
    maps\mp\_utility::_ID28811( "scorelimit", 0 );
    setdynamicdvar( "scr_infect_roundswitch", 0 );
    maps\mp\_utility::_ID25715( "infect", 0, 0, 9 );
    setdynamicdvar( "scr_infect_roundlimit", 1 );
    maps\mp\_utility::_ID25714( "infect", 1 );
    setdynamicdvar( "scr_infect_winlimit", 1 );
    maps\mp\_utility::_ID25724( "infect", 1 );
    setdynamicdvar( "scr_infect_halftime", 0 );
    maps\mp\_utility::_ID25706( "infect", 0 );
    setdynamicdvar( "scr_infect_playerrespawndelay", 0 );
    setdynamicdvar( "scr_infect_waverespawndelay", 0 );
    setdynamicdvar( "scr_player_forcerespawn", 1 );
    setdynamicdvar( "scr_team_fftype", 0 );
    setdynamicdvar( "scr_infect_promode", 0 );
}

_ID22905()
{
    setclientnamemode( "auto_change" );
    maps\mp\_utility::_ID28804( "allies", &"OBJECTIVES_INFECT" );
    maps\mp\_utility::_ID28804( "axis", &"OBJECTIVES_INFECT" );

    if ( level.splitscreen )
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_INFECT" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_INFECT" );
    }
    else
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_INFECT_SCORE" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_INFECT_SCORE" );
    }

    maps\mp\_utility::setobjectivehinttext( "allies", &"OBJECTIVES_INFECT_HINT" );
    maps\mp\_utility::setobjectivehinttext( "axis", &"OBJECTIVES_INFECT_HINT" );
    initspawns();
    var_0[0] = level._ID14086;
    maps\mp\gametypes\_gameobjects::_ID20445( var_0 );
    level._ID25248 = 1;
    level.blockweapondrops = 1;
    level._ID17556 = 0;
    level.infect_chosefirstinfected = 0;
    level._ID17558 = 0;
    level._ID17557 = 0;
    level._ID37447 = 0;
    level._ID17564["axis"] = 0;
    level._ID17564["allies"] = 0;
    level._ID17562 = [];
    level thread _ID22877();
    level thread _ID14084();
}

_ID14084()
{
    level endon( "game_ended" );
    setdynamicdvar( "scr_infect_timelimit", 0 );

    for (;;)
    {
        level waittill( "update_game_time",  var_0  );

        if ( !isdefined( var_0 ) )
            var_0 = ( maps\mp\_utility::_ID15435() + 1500 ) / 60000 + 2;

        setdynamicdvar( "scr_infect_timelimit", var_0 );
        level thread watchhostmigration( var_0 );
    }
}

watchhostmigration( var_0 )
{
    level notify( "watchHostMigration" );
    level endon( "watchHostMigration" );
    level endon( "game_ended" );
    level waittill( "host_migration_begin" );
    setdynamicdvar( "scr_infect_timelimit", 0 );
    waittillframeend;
    setdynamicdvar( "scr_infect_timelimit", 0 );
    level waittill( "host_migration_end" );
    level notify( "update_game_time",  var_0  );
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0._ID14072 = 1;
        var_0._ID14073 = 1;
        var_0._ID17567 = 0;

        if ( maps\mp\_utility::_ID14065( "prematch_done" ) )
        {
            var_0._ID14073 = 0;

            if ( isdefined( level.infect_chosefirstinfected ) && level.infect_chosefirstinfected )
                var_0._ID32120 = gettime();
        }

        if ( isdefined( level._ID17562[var_0.name] ) )
            var_0._ID17567 = 1;

        var_0 thread _ID21454();
    }
}

initspawns()
{
    level._ID30895 = ( 0, 0, 0 );
    level._ID30893 = ( 0, 0, 0 );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", "mp_tdm_spawn" );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", "mp_tdm_spawn" );
    level._ID20634 = maps\mp\gametypes\_spawnlogic::findboxcenter( level._ID30895, level._ID30893 );
    setmapcenter( level._ID20634 );
}

alwaysgamemodeclass()
{
    return "gamemode";
}

getspawnpoint()
{
    if ( self._ID14072 )
    {
        self._ID14072 = 0;
        self.pers["class"] = "gamemode";
        self.pers["lastClass"] = "";
        self.class = self.pers["class"];
        self.lastclass = self.pers["lastClass"];
        var_0 = "allies";

        if ( self._ID17567 )
            var_0 = "axis";

        maps\mp\gametypes\_menus::addtoteam( var_0, 1 );
        thread _ID21374();
    }

    if ( level._ID17628 )
    {
        var_1 = maps\mp\gametypes\_spawnlogic::_ID15350( "mp_tdm_spawn" );
        var_2 = maps\mp\gametypes\_spawnlogic::_ID15346( var_1 );
    }
    else
    {
        var_1 = maps\mp\gametypes\_spawnlogic::_ID15425( self.pers["team"] );
        var_2 = maps\mp\gametypes\_spawnscoring::_ID15345( var_1 );
    }

    return var_2;
}

_ID22902()
{
    self._ID32655 = undefined;
    self._ID17563 = self.origin;
    updateteamscores();

    if ( !level._ID17558 )
    {
        level._ID17558 = 1;
        level thread _ID7155();
    }

    if ( self._ID17567 )
    {
        if ( !level._ID17556 )
        {
            level notify( "infect_stopCountdown" );
            level.infect_chosefirstinfected = 1;
            level._ID17556 = 1;

            foreach ( var_1 in level.players )
            {
                if ( isdefined( var_1._ID17560 ) )
                    var_1._ID17560 = undefined;
            }
        }

        foreach ( var_1 in level.players )
        {
            if ( isdefined( var_1._ID18657 ) )
                var_1 thread _ID28760();
        }

        if ( level._ID17564["axis"] == 1 )
            self._ID18657 = 1;

        _ID18006( 1 );
    }

    if ( isdefined( self._ID18657 ) )
    {
        self.pers["gamemodeLoadout"] = level._ID17561["axis_initial"];
        self.infected_class = "axis_initial";
    }
    else
    {
        self.pers["gamemodeLoadout"] = level._ID17561[self.pers["team"]];
        self.infected_class = self.pers["team"];
    }

    thread _ID22901();
    level notify( "spawned_player" );
}

spawnwithplayersecondary()
{
    var_0 = self getweaponslistprimaries();
    var_1 = self getcurrentprimaryweapon();

    if ( var_0.size > 1 )
    {
        if ( var_1 == "iw6_knifeonly_mp" )
        {
            foreach ( var_3 in var_0 )
            {
                if ( var_3 != var_1 )
                    self setspawnweapon( var_3 );
            }
        }
    }
}

setdefaultammoclip( var_0 )
{
    var_1 = 1;

    if ( isdefined( self._ID18657 ) )
    {
        if ( maps\mp\_utility::isusingdefaultclass( var_0, 1 ) )
            var_1 = 0;
    }
    else if ( maps\mp\_utility::isusingdefaultclass( var_0, 0 ) )
        var_1 = 0;

    return var_1;
}

_ID22901()
{
    self endon( "death" );
    self endon( "disconnect" );
    self waittill( "giveLoadout" );
    self.last_infected_class = self.infected_class;

    if ( self.pers["team"] == "allies" )
    {
        spawnwithplayersecondary();

        if ( setdefaultammoclip( "allies" ) )
        {
            self setweaponammoclip( "proximity_explosive_mp", 1 );
            self setweaponammoclip( "concussion_grenade_mp", 1 );
        }
    }
    else if ( self.pers["team"] == "axis" )
    {
        thread _ID28758();
        self setmovespeedscale( 1.2 );

        if ( setdefaultammoclip( "axis" ) )
            self setweaponammoclip( "throwingknife_mp", 1 );

        thread _ID28757();
    }

    self.faux_spawn_infected = undefined;
}

_ID28757()
{
    self setmodel( "mp_body_infected_a" );

    if ( isdefined( self._ID16458 ) )
    {
        self detach( self._ID16458, "" );
        self._ID16458 = undefined;
    }

    self attach( "head_mp_infected", "", 1 );
    self._ID16458 = "head_mp_infected";
    self setviewmodel( "viewhands_gs_hostage" );
    self setclothtype( "cloth" );
}

_ID28758()
{
    if ( isdefined( self._ID18657 ) )
    {
        if ( !isdefined( self._ID29981 ) || !self._ID29981 )
        {
            thread maps\mp\gametypes\_rank::_ID36462( "first_infected" );
            self._ID29981 = 1;
        }
    }
    else if ( isdefined( self.changingtoregularinfected ) )
    {
        self.changingtoregularinfected = undefined;

        if ( isdefined( self.changingtoregularinfectedbykill ) )
        {
            self.changingtoregularinfectedbykill = undefined;
            thread maps\mp\gametypes\_rank::_ID36462( "firstblood" );
            maps\mp\gametypes\_gamescore::_ID15616( "first_infected", self );
            thread maps\mp\gametypes\_rank::giverankxp( "first_infected" );
        }
    }
    else if ( !isdefined( self._ID29981 ) || !self._ID29981 )
    {
        thread maps\mp\gametypes\_rank::_ID36462( "got_infected" );
        self._ID29981 = 1;
    }
}

_ID7155()
{
    level endon( "game_ended" );
    level endon( "infect_stopCountdown" );
    level._ID17556 = 0;
    maps\mp\_utility::gameflagwait( "prematch_done" );
    level._ID37447 = 1;
    maps\mp\gametypes\_hostmigration::_ID35597( 1.0 );
    setomnvar( "ui_match_start_text", "first_infected_in" );
    var_0 = 15;

    while ( var_0 > 0 && !level.gameended )
    {
        setomnvar( "ui_match_start_countdown", var_0 );
        var_0--;
        maps\mp\gametypes\_hostmigration::_ID35597( 1.0 );
    }

    setomnvar( "ui_match_start_countdown", 0 );
    level._ID37447 = 0;
    var_1 = [];

    foreach ( var_3 in level.players )
    {
        if ( maps\mp\_utility::_ID20673() && level.players.size > 1 && var_3 ishost() )
            continue;

        if ( var_3.team == "spectator" )
            continue;

        if ( !var_3.hasspawned )
            continue;

        var_1[var_1.size] = var_3;
    }

    var_5 = var_1[randomint( var_1.size )];
    var_5 setfirstinfected( 1 );

    foreach ( var_3 in level.players )
    {
        if ( var_3 == var_5 )
            continue;

        var_3._ID32120 = gettime();
    }
}

setfirstinfected( var_0 )
{
    self endon( "disconnect" );

    if ( var_0 )
        self._ID17560 = 1;

    while ( !maps\mp\_utility::_ID18757( self ) || maps\mp\_utility::_ID18837() )
        wait 0.05;

    if ( isdefined( self._ID18582 ) && self._ID18582 == 1 )
    {
        self notify( "force_cancel_placement" );
        wait 0.05;
    }

    while ( self ismantling() )
        wait 0.05;

    while ( !self isonground() && !self isonladder() )
        wait 0.05;

    if ( maps\mp\_utility::_ID18666() )
    {
        self notify( "lost_juggernaut" );
        wait 0.05;
    }

    while ( !isalive( self ) )
        common_scripts\utility::_ID35582();

    if ( var_0 )
    {
        maps\mp\gametypes\_menus::addtoteam( "axis", undefined, 1 );
        thread _ID21374();
        level.infect_chosefirstinfected = 1;
        self._ID17560 = undefined;
        level notify( "update_game_time" );
        updateteamscores();
        level._ID17556 = 1;
    }

    self._ID18657 = 1;
    self.pers["gamemodeLoadout"] = level._ID17561["axis_initial"];

    if ( isdefined( self.setspawnpoint ) )
        maps\mp\perks\_perkfunctions::deleteti( self.setspawnpoint );

    var_1 = spawn( "script_model", self.origin );
    var_1.angles = self.angles;
    var_1._ID24539 = self.origin;
    var_1._ID22328 = 1;
    self.setspawnpoint = var_1;
    self notify( "faux_spawn" );
    self.faux_spawn_stance = self getstance();
    self.faux_spawn_infected = 1;
    thread maps\mp\gametypes\_playerlogic::spawnplayer( 1 );

    if ( var_0 )
        level._ID17562[self.name] = 1;

    foreach ( var_3 in level.players )
        var_3 thread maps\mp\gametypes\_hud_message::_ID31052( "first_infected" );

    level thread maps\mp\_utility::_ID32672( "callout_first_infected", self );
    maps\mp\_utility::_ID24645( "mp_enemy_obj_captured" );
    _ID18006( 1 );
}

_ID28760( var_0, var_1 )
{
    level endon( "game_ended" );
    self._ID18657 = undefined;
    self.changingtoregularinfected = 1;

    if ( isdefined( var_0 ) )
        self.changingtoregularinfectedbykill = 1;

    while ( !maps\mp\_utility::_ID18757( self ) )
        wait 0.05;

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

    if ( isdefined( var_1 ) && var_1 == "MOD_MELEE" )
        wait 1.2;

    while ( !maps\mp\_utility::_ID18757( self ) )
        wait 0.05;

    self.pers["gamemodeLoadout"] = level._ID17561["axis"];

    if ( isdefined( self.setspawnpoint ) )
        maps\mp\perks\_perkfunctions::deleteti( self.setspawnpoint );

    var_2 = spawn( "script_model", self.origin );
    var_2.angles = self.angles;
    var_2._ID24539 = self.origin;
    var_2._ID22328 = 1;
    self.setspawnpoint = var_2;
    self notify( "faux_spawn" );
    self.faux_spawn_stance = self getstance();
    self.faux_spawn_infected = 1;
    thread maps\mp\gametypes\_playerlogic::spawnplayer( 1 );
}

_ID22886( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_10 = 0;
    var_11 = 0;

    if ( self.team == "allies" && isdefined( var_1 ) )
    {
        if ( isplayer( var_1 ) && var_1 != self )
            var_10 = 1;
        else if ( level._ID17556 && ( var_1 == self || !isplayer( var_1 ) ) )
        {
            var_10 = 1;
            var_11 = 1;
        }
    }

    if ( isplayer( var_1 ) && var_1.team == "allies" && var_1 != self )
    {
        var_1.pers["killsAsSurvivor"]++;
        var_1 maps\mp\gametypes\_persistence::_ID31528( "round", "killsAsSurvivor", var_1.pers["killsAsSurvivor"] );
    }
    else if ( isplayer( var_1 ) && var_1.team == "axis" && var_1 != self )
    {
        var_1.pers["killsAsInfected"]++;
        var_1 maps\mp\gametypes\_persistence::_ID31528( "round", "killsAsInfected", var_1.pers["killsAsInfected"] );
    }

    if ( var_10 )
    {
        self._ID32655 = 1;
        maps\mp\gametypes\_menus::addtoteam( "axis" );
        thread _ID21374();
        level notify( "update_game_time" );
        updateteamscores();
        level._ID17562[self.name] = 1;

        if ( var_11 )
        {
            if ( level._ID17564["axis"] > 1 )
            {
                foreach ( var_13 in level.players )
                {
                    if ( isdefined( var_13._ID18657 ) )
                        var_13 thread _ID28760();
                }
            }
        }
        else if ( isdefined( var_1._ID18657 ) )
            var_1 thread _ID28760( 1, var_3 );
        else
        {
            var_1 thread maps\mp\gametypes\_rank::_ID36462( "infected_survivor" );
            maps\mp\gametypes\_gamescore::_ID15616( "infected_survivor", var_1, self, 1 );
            var_1 thread maps\mp\gametypes\_rank::giverankxp( "infected_survivor" );
        }

        if ( level._ID17564["allies"] > 1 )
        {
            maps\mp\_utility::_ID24645( "mp_enemy_obj_captured", "allies" );
            maps\mp\_utility::_ID24645( "mp_war_objective_taken", "axis" );
            thread maps\mp\_utility::_ID32672( "callout_got_infected", self, "allies" );

            if ( !var_11 )
            {
                thread maps\mp\_utility::_ID32672( "callout_infected", var_1, "axis" );

                foreach ( var_13 in level.players )
                {
                    if ( !maps\mp\_utility::_ID18757( var_13 ) || self.sessionstate == "spectator" )
                        continue;

                    if ( var_13.team == "allies" && var_13 != self && distance( var_13._ID17563, var_13.origin ) > 32 )
                    {
                        var_13 thread maps\mp\gametypes\_rank::_ID36462( "survivor" );
                        maps\mp\gametypes\_gamescore::_ID15616( "survivor", var_13, undefined, 1 );
                        var_13 thread maps\mp\gametypes\_rank::giverankxp( "survivor" );
                    }
                }
            }
        }
        else if ( level._ID17564["allies"] == 1 )
            onfinalsurvivor();
        else if ( level._ID17564["allies"] == 0 )
            _ID22907();

        _ID28889( 1 );
    }
}

onfinalsurvivor()
{
    maps\mp\_utility::_ID24645( "mp_obj_captured" );

    foreach ( var_1 in level.players )
    {
        if ( !isdefined( var_1 ) )
            continue;

        if ( var_1.team == "allies" )
        {
            var_1 thread maps\mp\gametypes\_rank::_ID36462( "final_survivor" );

            if ( !level._ID17557 )
            {
                if ( var_1._ID14073 && isdefined( var_1._ID17563 ) && distance( var_1._ID17563, var_1.origin ) > 32 )
                {
                    maps\mp\gametypes\_gamescore::_ID15616( "final_survivor", var_1, undefined, 1 );
                    var_1 thread maps\mp\gametypes\_rank::giverankxp( "final_survivor" );
                }

                level._ID17557 = 1;
            }

            thread maps\mp\_utility::_ID32672( "callout_final_survivor", var_1 );

            if ( !var_1 maps\mp\_utility::_ID18666() )
                level thread _ID12888( var_1 );

            break;
        }
    }
}

_ID12888( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 endon( "eliminated" );
    level endon( "infect_lateJoiner" );
    level thread enduavonlatejoiner( var_0 );
    var_1 = 0;
    level.radarmode["axis"] = "normal_radar";

    foreach ( var_3 in level.players )
    {
        if ( var_3.team == "axis" )
            var_3.radarmode = "normal_radar";
    }

    setteamradarstrength( "axis", 1 );

    for (;;)
    {
        var_5 = var_0.origin;
        wait 4;

        if ( var_1 )
        {
            setteamradar( "axis", 0 );
            var_1 = 0;
        }

        wait 6;

        if ( distance( var_5, var_0.origin ) < 200 )
        {
            setteamradar( "axis", 1 );
            var_1 = 1;

            foreach ( var_3 in level.players )
                var_3 playlocalsound( "recondrone_tag" );
        }
    }
}

enduavonlatejoiner( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 endon( "eliminated" );

    for (;;)
    {
        if ( level._ID17564["allies"] > 1 )
        {
            level notify( "infect_lateJoiner" );
            wait 0.05;
            setteamradar( "axis", 0 );
            break;
        }

        wait 0.05;
    }
}

_ID21374()
{
    level endon( "game_ended" );
    self endon( "eliminated" );
    self notify( "infect_monitor_disconnect" );
    self endon( "infect_monitor_disconnect" );
    var_0 = self.team;

    if ( !isdefined( var_0 ) && isdefined( self._ID5801 ) )
        var_0 = self._ID5801;

    self waittill( "disconnect" );
    updateteamscores();

    if ( isdefined( self._ID17560 ) || level.infect_chosefirstinfected )
    {
        if ( level._ID17564["axis"] && level._ID17564["allies"] )
        {
            if ( var_0 == "allies" && level._ID17564["allies"] == 1 )
                onfinalsurvivor();
            else if ( var_0 == "axis" && level._ID17564["axis"] == 1 )
            {
                foreach ( var_2 in level.players )
                {
                    if ( var_2 != self && var_2.team == "axis" )
                        var_2 setfirstinfected( 0 );
                }
            }
        }
        else if ( level._ID17564["allies"] == 0 )
            _ID22907();
        else if ( level._ID17564["axis"] == 0 )
        {
            if ( level._ID17564["allies"] == 1 )
            {
                level.finalkillcam_winner = "allies";
                level thread maps\mp\gametypes\_gamelogic::endgame( "allies", game["end_reason"]["axis_eliminated"] );
            }
            else if ( level._ID17564["allies"] > 1 )
            {
                level.infect_chosefirstinfected = 0;
                level thread _ID7155();
            }
        }
    }
    else if ( level._ID37447 && level._ID17564["allies"] == 0 && level._ID17564["axis"] == 0 )
    {
        level notify( "infect_stopCountdown" );
        level._ID17558 = 0;
        setomnvar( "ui_match_start_countdown", 0 );
    }

    self._ID18657 = undefined;
}

_ID22796( var_0 )
{
    return;
}

_ID22913()
{
    level.finalkillcam_winner = "allies";
    level thread maps\mp\gametypes\_gamelogic::endgame( "allies", game["end_reason"]["time_limit_reached"] );
}

_ID22907()
{
    level.finalkillcam_winner = "axis";
    level thread maps\mp\gametypes\_gamelogic::endgame( "axis", game["end_reason"]["allies_eliminated"] );
}

_ID15423( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in level.players )
    {
        if ( var_3.sessionstate == "spectator" && !var_3.spectatekillcam )
            continue;

        if ( var_3.team == var_0 )
            var_1++;
    }

    return var_1;
}

updateteamscores()
{
    level._ID17564["allies"] = _ID15423( "allies" );
    game["teamScores"]["allies"] = level._ID17564["allies"];
    setteamscore( "allies", level._ID17564["allies"] );
    level._ID17564["axis"] = _ID15423( "axis" );
    game["teamScores"]["axis"] = level._ID17564["axis"];
    setteamscore( "axis", level._ID17564["axis"] );
}

_ID28879()
{
    if ( maps\mp\_utility::isusingdefaultclass( "allies", 0 ) )
        level._ID17561["allies"] = maps\mp\_utility::_ID15140( "allies", 0 );
    else
    {
        level._ID17561["allies"]["loadoutPrimary"] = "iw6_maul";
        level._ID17561["allies"]["loadoutPrimaryAttachment"] = "none";
        level._ID17561["allies"]["loadoutPrimaryAttachment2"] = "none";
        level._ID17561["allies"]["loadoutPrimaryBuff"] = "specialty_longerrange";
        level._ID17561["allies"]["loadoutPrimaryCamo"] = "none";
        level._ID17561["allies"]["loadoutPrimaryReticle"] = "none";
        level._ID17561["allies"]["loadoutSecondary"] = "none";
        level._ID17561["allies"]["loadoutSecondaryAttachment"] = "none";
        level._ID17561["allies"]["loadoutSecondaryAttachment2"] = "none";
        level._ID17561["allies"]["loadoutSecondaryBuff"] = "specialty_null";
        level._ID17561["allies"]["loadoutSecondaryCamo"] = "none";
        level._ID17561["allies"]["loadoutSecondaryReticle"] = "none";
        level._ID17561["allies"]["loadoutEquipment"] = "proximity_explosive_mp";
        level._ID17561["allies"]["loadoutOffhand"] = "concussion_grenade_mp";
        level._ID17561["allies"]["loadoutStreakType"] = "assault";
        level._ID17561["allies"]["loadoutKillstreak1"] = "none";
        level._ID17561["allies"]["loadoutKillstreak2"] = "none";
        level._ID17561["allies"]["loadoutKillstreak3"] = "none";
        level._ID17561["allies"]["loadoutJuggernaut"] = 0;
        level._ID17561["allies"]["loadoutPerks"] = [ "specialty_scavenger", "specialty_quickdraw", "specialty_quieter" ];
    }

    if ( maps\mp\_utility::isusingdefaultclass( "axis", 1 ) )
    {
        level._ID17561["axis_initial"] = maps\mp\_utility::_ID15140( "axis", 1 );
        level._ID17561["axis_initial"]["loadoutStreakType"] = "assault";
        level._ID17561["axis_initial"]["loadoutKillstreak1"] = "none";
        level._ID17561["axis_initial"]["loadoutKillstreak2"] = "none";
        level._ID17561["axis_initial"]["loadoutKillstreak3"] = "none";
    }
    else
    {
        level._ID17561["axis_initial"]["loadoutPrimary"] = "iw6_m9a1";
        level._ID17561["axis_initial"]["loadoutPrimaryAttachment"] = "none";
        level._ID17561["axis_initial"]["loadoutPrimaryAttachment2"] = "none";
        level._ID17561["axis_initial"]["loadoutPrimaryBuff"] = "specialty_bling";
        level._ID17561["axis_initial"]["loadoutPrimaryCamo"] = "none";
        level._ID17561["axis_initial"]["loadoutPrimaryReticle"] = "none";
        level._ID17561["axis_initial"]["loadoutSecondary"] = "none";
        level._ID17561["axis_initial"]["loadoutSecondaryAttachment"] = "none";
        level._ID17561["axis_initial"]["loadoutSecondaryAttachment2"] = "none";
        level._ID17561["axis_initial"]["loadoutSecondaryBuff"] = "specialty_null";
        level._ID17561["axis_initial"]["loadoutSecondaryCamo"] = "none";
        level._ID17561["axis_initial"]["loadoutSecondaryReticle"] = "none";
        level._ID17561["axis_initial"]["loadoutEquipment"] = "throwingknife_mp";
        level._ID17561["axis_initial"]["loadoutOffhand"] = "specialty_tacticalinsertion";
        level._ID17561["axis_initial"]["loadoutStreakType"] = "assault";
        level._ID17561["axis_initial"]["loadoutKillstreak1"] = "none";
        level._ID17561["axis_initial"]["loadoutKillstreak2"] = "none";
        level._ID17561["axis_initial"]["loadoutKillstreak3"] = "none";
        level._ID17561["axis_initial"]["loadoutJuggernaut"] = 0;
        level._ID17561["axis_initial"]["loadoutPerks"] = [ "specialty_longersprint", "specialty_quickdraw", "specialty_quieter", "specialty_falldamage", "specialty_bulletaccuracy" ];
    }

    if ( maps\mp\_utility::isusingdefaultclass( "axis", 0 ) )
    {
        level._ID17561["axis"] = maps\mp\_utility::_ID15140( "axis", 0 );
        level._ID17561["axis"]["loadoutStreakType"] = "assault";
        level._ID17561["axis"]["loadoutKillstreak1"] = "none";
        level._ID17561["axis"]["loadoutKillstreak2"] = "none";
        level._ID17561["axis"]["loadoutKillstreak3"] = "none";
    }
    else
    {
        level._ID17561["axis"]["loadoutPrimary"] = "iw6_knifeonly";
        level._ID17561["axis"]["loadoutPrimaryAttachment"] = "none";
        level._ID17561["axis"]["loadoutPrimaryAttachment2"] = "none";
        level._ID17561["axis"]["loadoutPrimaryBuff"] = "specialty_null";
        level._ID17561["axis"]["loadoutPrimaryCamo"] = "none";
        level._ID17561["axis"]["loadoutPrimaryReticle"] = "none";
        level._ID17561["axis"]["loadoutSecondary"] = "none";
        level._ID17561["axis"]["loadoutSecondaryAttachment"] = "none";
        level._ID17561["axis"]["loadoutSecondaryAttachment2"] = "none";
        level._ID17561["axis"]["loadoutSecondaryBuff"] = "specialty_null";
        level._ID17561["axis"]["loadoutSecondaryCamo"] = "none";
        level._ID17561["axis"]["loadoutSecondaryReticle"] = "none";
        level._ID17561["axis"]["loadoutEquipment"] = "throwingknife_mp";
        level._ID17561["axis"]["loadoutOffhand"] = "specialty_tacticalinsertion";
        level._ID17561["axis"]["loadoutStreakType"] = "assault";
        level._ID17561["axis"]["loadoutKillstreak1"] = "none";
        level._ID17561["axis"]["loadoutKillstreak2"] = "none";
        level._ID17561["axis"]["loadoutKillstreak3"] = "none";
        level._ID17561["axis"]["loadoutJuggernaut"] = 0;
        level._ID17561["axis"]["loadoutPerks"] = [ "specialty_longersprint", "specialty_quickdraw", "specialty_quieter", "specialty_falldamage" ];
    }
}

_ID21454()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "infected" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( !level.infect_chosefirstinfected || !isdefined( self._ID32120 ) || !isalive( self ) )
        {
            wait 0.05;
            continue;
        }

        _ID28889( 0 );
        wait 1.0;
    }
}

_ID18006( var_0 )
{
    maps\mp\_utility::setextrascore0( 0 );

    if ( isdefined( var_0 ) && var_0 )
    {
        self notify( "infected" );
        self.extrascore1 = 1;
    }
}

_ID28889( var_0 )
{
    if ( !isdefined( self._ID32120 ) )
        self._ID32120 = self._ID30916;

    var_1 = int( ( gettime() - self._ID32120 ) / 1000 );

    if ( var_1 > 999 )
        var_1 = 999;

    maps\mp\_utility::setextrascore0( var_1 );

    if ( isdefined( var_0 ) && var_0 )
    {
        self notify( "infected" );
        self.extrascore1 = 1;
    }
}
