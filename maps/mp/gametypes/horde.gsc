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
        maps\mp\_utility::_ID25718( level._ID14086, 0 );
        maps\mp\_utility::_ID25717( level._ID14086, 0 );
        maps\mp\_utility::_ID25714( level._ID14086, 1 );
        maps\mp\_utility::_ID25724( level._ID14086, 1 );
        maps\mp\_utility::_ID25712( level._ID14086, 1 );
        maps\mp\_utility::_ID25706( level._ID14086, 0 );
    }

    setdynamicdvar( "r_hudOutlineWidth", 1 );
    setdynamicdvar( "scr_horde_timeLimit", 0 );
    setdynamicdvar( "scr_horde_numLives", 1 );
    maps\mp\_utility::_ID25718( level._ID14086, 0 );
    _ID28879();
    _ID17983();
    _ID20118();
    level._ID11502 = 1;
    level._ID30964 = 25;
    level._ID32653 = 1;
    level.ishorde = 1;
    level._ID10157 = 1;
    level._ID22073 = 1;
    level.alwaysdrawfriendlynames = 1;
    level._ID27362 = 1;
    level.allowlatecomers = 1;
    level.skiplivesxpscalar = 1;
    level.highlightairdrop = 1;
    level._ID22075 = 1;
    level._ID22072 = 1;
    level.allowlaststandai = 1;
    level.enableteamintel = 1;
    level._ID18819 = 1;
    level._ID26011 = 1;
    level._ID3995 = 1;
    level.skippointdisplayxp = 1;
    level._ID13531 = 1;
    level._ID36710 = 0;
    level.allowfauxdeath = 0;
    level._ID19262 = 0;
    level._ID32097 = 0;
    level._ID14070 = 0;
    level.donottrackgamesplayed = 1;
    level.disableweaponstats = 1;
    level._ID24549 = "allies";
    level.enemyteam = "axis";
    level.laststandusetime = 2000;
    level._ID8707 = "";
    level._ID38157 = [];
    level._ID22905 = ::_ID22905;
    level.getspawnpoint = ::getspawnpoint;
    level._ID22869 = ::_ID22869;
    level._ID22902 = ::_ID22902;
    level._ID21286 = ::_ID21287;
    level.callbackplayerlaststand = maps\mp\gametypes\_horde_laststand::_ID6478;
    level._ID22796 = ::_ID22796;
    level._ID8769 = maps\mp\gametypes\_horde_crates::createhordecrates;
    level._ID22906 = ::_ID22869;
    level._ID36261 = ::dropweaponfordeathhorde;
}

_ID29172()
{
    game["dialog"]["gametype"] = "infct_hint";
    game["dialog"]["offense_obj"] = "null";
    game["dialog"]["defense_obj"] = "null";
    game["dialog"]["mission_success"] = "sgd_end";
    game["dialog"]["mission_failure"] = "sgd_end_fail";
    game["dialog"]["mission_draw"] = "sgd_end_fail";
    game["dialog"]["round_end"] = "sgd_rnd_end";
    game["dialog"]["round_start"] = "sgd_rnd_start";
    game["dialog"]["round_loot"] = "sgd_plr_join";
    game["dialog"]["weapon_level"] = "sgd_prf_inc";
    game["dialog"]["max_ammo"] = "sgd_team_restock";
    game["dialog"]["support_drop"] = "sgd_supply_drop";
    game["dialog"]["ally_down"] = "sgd_ally_down";
    game["dialog"]["ally_dead"] = "sgd_ally_dead";
    game["dialog"]["dc"] = "sgd_plr_quit";
    game["dialog"]["squadmate"] = "sgd_squad";
}

_ID20118()
{
    level._ID1644["dropLocation"] = loadfx( "smoke/signal_smoke_airdrop" );
    level._ID1644["spawn_effect"] = loadfx( "fx/maps/mp_siege_dam/mp_siege_spawn" );
    level._ID1644["crate_teleport"] = loadfx( "vfx/gameplay/mp/core/vfx_teleport_player" );
    level._ID1644["loot_crtae"] = loadfx( "vfx/gameplay/mp/core/vfx_marker_base_cyan" );
    level._ID1644["weapon_level"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_3d_world_ping" );
}

_ID17983()
{
    level.maxpickupsperround = _ID15144();
    level.maxammopickupsperround = 1;
    level._ID8701 = 0;
    level._ID8681 = 0;
    level._ID23418 = getpercentchancetodrop();
    level._ID36276 = "mp_weapon_level_pickup_badge";
    level._ID36275 = ::_ID36274;
    level.ammopickupmodel = "prop_mp_max_ammo_pickup";
    level.ammopickupfunc = ::ammopickup;
}

_ID35615( var_0 )
{
    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    _ID37976( "ui_cranked_bomb_timer_final_seconds", 1 );
}

_ID28751( var_0, var_1 )
{
    level thread _ID35615( var_1 - 5 );
    _ID37976( "ui_cranked_bomb_timer_text", var_0 );
    _ID37976( "ui_cranked_bomb_timer_end_milliseconds", int( gettime() + var_1 * 1000 ) );
}

_ID7487()
{
    _ID37976( "ui_cranked_bomb_timer_end_milliseconds", 0 );
}

_ID37976( var_0, var_1 )
{
    level._ID38157[var_0] = var_1;

    foreach ( var_3 in level.players )
        var_3 setclientomnvar( var_0, var_1 );
}

_ID38234( var_0 )
{
    foreach ( var_3, var_2 in level._ID38157 )
        var_0 setclientomnvar( var_3, var_2 );
}

_ID15144()
{
    var_0 = maps\mp\gametypes\_horde_util::_ID15195() + 1;
    return clamp( var_0, 3, 5 );
}

getpercentchancetodrop()
{
    var_0 = 0;
    var_1 = maps\mp\gametypes\_horde_util::_ID15195();

    switch ( var_1 )
    {
        case 0:
            var_0 = 0;
            break;
        case 1:
            var_0 = 14;
            break;
        case 2:
            var_0 = 13;
            break;
        case 3:
            var_0 = 12;
            break;
        case 4:
        default:
            var_0 = 10;
            break;
    }

    return var_0;
}

initializematchrules()
{
    maps\mp\_utility::_ID28682();
    setdynamicdvar( "scr_horde_roundswitch", 0 );
    maps\mp\_utility::_ID25715( "horde", 0, 0, 9 );
    setdynamicdvar( "scr_horde_roundlimit", 1 );
    maps\mp\_utility::_ID25714( "horde", 1 );
    setdynamicdvar( "scr_horde_winlimit", 1 );
    maps\mp\_utility::_ID25724( "horde", 1 );
    setdynamicdvar( "scr_horde_halftime", 0 );
    maps\mp\_utility::_ID25706( "horde", 0 );
    setdynamicdvar( "scr_horde_promode", 0 );
    setdynamicdvar( "scr_horde_timeLimit", 0 );
    maps\mp\_utility::_ID25718( level._ID14086, 0 );
    setdynamicdvar( "scr_horde_numLives", 1 );
    maps\mp\_utility::_ID25712( level._ID14086, 1 );
    setdynamicdvar( "scr_horde_difficulty", getmatchrulesdata( "hordeData", "difficulty" ) );
    setdynamicdvar( "r_hudOutlineWidth", 1 );
}

_ID22905()
{
    setclientnamemode( "auto_change" );

    if ( !isdefined( game["switchedsides"] ) )
        game["switchedsides"] = 0;

    maps\mp\_utility::_ID28804( "allies", &"HORDE_OBJECTIVE" );
    maps\mp\_utility::_ID28804( "axis", &"HORDE_OBJECTIVE" );
    maps\mp\_utility::_ID28803( "allies", &"HORDE_OBJECTIVE_SCORE" );
    maps\mp\_utility::_ID28803( "axis", &"HORDE_OBJECTIVE_SCORE" );
    maps\mp\_utility::setobjectivehinttext( "allies", &"HORDE_OBJECTIVE_HINT" );
    maps\mp\_utility::setobjectivehinttext( "axis", &"HORDE_OBJECTIVE_HINT" );
    initspawns();
    _ID29172();
    var_0[0] = level._ID14086;
    maps\mp\gametypes\_gameobjects::_ID20445( var_0 );
    inithordesettings();
    level thread _ID22880();
    level thread _ID27020();
    level thread _ID27019();
}

inithordesettings()
{
    setdvar( "g_keyboarduseholdtime", 250 );
    level.hordedroplocations = common_scripts\utility::_ID15386( "horde_drop", "targetname" );
    level.blastshieldmod = 0.75;
    level.intelminigun = "iw6_minigunjugg_mp";
    level._ID17069 = int( clamp( getdvarint( "scr_horde_difficulty", 3 ), 1, 3 ) );
    level._ID20759 = getmaxrounds( level._ID17069 );
    level.currentroundnumber = 0;
    level._ID8702 = 0;
    level._ID12074 = 4;
    level._ID11088 = 0;
    _ID17071();
    level.chancetospawndog = 0;
    level._ID19544 = 0;
    level._ID24714 = [];
    level._ID24714["damage_body"] = 10;
    level._ID24714["damage_head"] = 30;
    level._ID24714["kill_normal"] = 20;
    level._ID24714["kill_melee"] = 50;
    level._ID24714["kill_head"] = 50;
    level._ID17252 = 50;
    level._ID17244 = 395;
}

_ID17071()
{
    foreach ( var_1 in level.hordedroplocations )
    {
        var_2 = var_1.origin + ( 0, 0, 32 );
        var_3 = var_1.origin - ( 0, 0, 256 );
        var_4 = bullettrace( var_2, var_3, 0 );
        var_1._ID33250 = var_1.origin;

        if ( var_4["fraction"] < 1 )
            var_1._ID33250 = var_4["position"];
    }
}

_ID22880()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0._ID14072 = 1;
        var_0._ID16424 = 0;

        if ( level.currentroundnumber > 10 )
            var_0._ID16424 = 1;

        level thread _ID8465( var_0 );
        level thread maps\mp\gametypes\_horde_crates::_ID21377( var_0 );
        level thread _ID21451( var_0 );
        level thread _ID38232( var_0 );
    }
}

_ID8465( var_0 )
{
    var_0._ID36291 = [];
    var_0._ID17063 = [];
    var_0._ID37828 = [];
    var_0.beingrevived = 0;
    var_0._ID19283 = 0;
    var_0._ID22417 = 0;
    var_0._ID22398 = 0;
    var_0._ID37918 = 0;
    var_0._ID37666 = 1;
    level._ID24542 = "iw6_mp443_mp_xmags";
    var_1 = getweaponbasename( level._ID24542 );
    _ID8442( var_0, level._ID24542, 0 );
    _ID8442( var_0, level.intelminigun, 0 );
    level thread _ID36659( var_0 );
    level thread _ID21465( var_0 );
    level thread _ID37703( var_0 );
}

_ID8442( var_0, var_1, var_2 )
{
    var_3 = getweaponbasename( var_1 );

    if ( _ID16425( var_0, var_3 ) )
        return;

    var_0._ID36291[var_3]["level"] = 1;
    var_0._ID36291[var_3]["vaule"] = 0;
    var_0._ID36291[var_3]["barSize"] = 0;

    if ( var_2 )
        var_0._ID36291[var_3]["barSize"] = getweaponbarsize( 1, var_3 );
}

_ID16425( var_0, var_1 )
{
    return isdefined( var_1 ) && isdefined( var_0._ID36291[var_1] );
}

_ID22902()
{
    if ( self._ID14072 )
    {
        self.pers["class"] = "gamemode";
        self.pers["lastClass"] = "";
        self.pers["gamemodeLoadout"] = level._ID17075[level._ID24549];
        self.class = self.pers["class"];
        self.lastclass = self.pers["lastClass"];
    }

    if ( isagent( self ) )
    {
        if ( !maps\mp\gametypes\_horde_util::isonhumanteam( self ) )
        {
            _ID28714( self );
            _ID28715( self );
            var_0 = _ID15053();
            self.pers["gamemodeLoadout"] = var_0;
            self.agentname = var_0["name_localized"];
            self._ID17064 = var_0["type"];
            thread maps\mp\agents\_agents_gametype_horde::_ID23871();
        }
        else
        {
            self.pers["gamemodeLoadout"] = level._ID17075["squadmate"];
            maps\mp\bots\_bots_util::bot_set_personality( "camper" );
            maps\mp\bots\_bots_util::bot_set_difficulty( "regular" );
            self botsetdifficultysetting( "allowGrenades", 1 );
        }

        self.avoidkillstreakonspawntimer = 0;
    }

    thread _ID22901();
}

_ID28715( var_0 )
{
    var_0 maps\mp\bots\_bots_util::bot_set_personality( "run_and_gun" );

    if ( level.currentroundnumber < 41 )
    {
        var_0 maps\mp\bots\_bots_util::bot_set_difficulty( "recruit" );
        var_0 botsetdifficultysetting( "visionBlinded", 0.05 );
        var_0 botsetdifficultysetting( "hearingDeaf", 0.05 );
        var_0 botsetdifficultysetting( "meleeReactAllowed", 1 );
        var_0 botsetdifficultysetting( "meleeReactionTime", 600 );
        var_0 botsetdifficultysetting( "meleeDist", 85 );
        var_0 botsetdifficultysetting( "meleeChargeDist", 100 );
        var_0 botsetdifficultysetting( "minGraceDelayFireTime", 0 );
        var_0 botsetdifficultysetting( "maxGraceDelayFireTime", 0 );
        var_0 botsetdifficultysetting( "minInaccuracy", 1.25 );
        var_0 botsetdifficultysetting( "maxInaccuracy", 1.75 );
        var_0 botsetdifficultysetting( "strafeChance", 0.25 );

        if ( level.currentroundnumber > 8 )
        {
            var_0 botsetdifficultysetting( "minInaccuracy", 0.75 );
            var_0 botsetdifficultysetting( "maxInaccuracy", 1.5 );
        }

        if ( level.currentroundnumber > 20 )
        {
            var_0 botsetdifficultysetting( "adsAllowed", 1 );
            var_0 botsetdifficultysetting( "diveChance", 0.15 );
        }
    }
    else if ( level.currentroundnumber > 50 )
        var_0 maps\mp\bots\_bots_util::bot_set_difficulty( "veteran" );
    else
        var_0 maps\mp\bots\_bots_util::bot_set_difficulty( "hardened" );

    var_0 botsetdifficultysetting( "allowGrenades", 0 );
    var_0 botsetdifficultysetting( "avoidSkyPercent", 0 );
}

_ID15592()
{
    if ( level.currentroundnumber > 15 )
        maps\mp\_utility::_ID15611( "specialty_fastreload", 0 );

    if ( level.currentroundnumber > 20 )
        maps\mp\_utility::_ID15611( "specialty_fastsprintrecovery", 0 );

    if ( level.currentroundnumber > 30 )
        maps\mp\_utility::_ID15611( "specialty_lightweight", 0 );

    if ( level.currentroundnumber > 35 )
        maps\mp\_utility::_ID15611( "specialty_quickdraw", 0 );

    if ( level.currentroundnumber > 40 )
        maps\mp\_utility::_ID15611( "specialty_stalker", 0 );

    if ( level.currentroundnumber > 45 )
        maps\mp\_utility::_ID15611( "specialty_marathon", 0 );

    if ( level.currentroundnumber > 50 )
        maps\mp\_utility::_ID15611( "specialty_regenfaster", 0 );
}

_ID28714( var_0 )
{
    var_0.maxhealth = 60 + 20 * level.currentroundnumber;
    var_0.health = var_0.maxhealth;
}

_ID22901()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "giveLoadout" );
    maps\mp\killstreaks\_killstreaks::clearkillstreaks();

    if ( maps\mp\gametypes\_horde_util::isonhumanteam( self ) )
    {
        self givemaxammo( level._ID24542 );
        thread _ID24468( level._ID24542 );

        if ( isplayer( self ) )
        {
            self setweaponammoclip( "proximity_explosive_mp", 1 );
            self setweaponammoclip( "concussion_grenade_mp", 1 );
            maps\mp\_utility::_ID15611( "specialty_pistoldeath", 0 );

            if ( !self._ID16424 )
                thread maps\mp\killstreaks\_killstreaks::_ID15602( "agent", 0, 0, self );

            childthread _ID34598( self._ID14072 );
            _ID26021( self );
            _ID38234( self );
        }

        if ( isagent( self ) )
        {
            self.agentname = &"HORDE_BUDDY";
            self._ID17064 = "Buddy";
            childthread ammorefillprimary();
            thread maps\mp\bots\_bots::bot_think_revive();

            if ( isdefined( self.owner ) )
                self.owner._ID16424 = 1;
        }
    }
    else
    {
        childthread ammorefillprimary();
        childthread ammorefillsecondary();

        switch ( self._ID17064 )
        {
            case "Ravager":
                _ID28847();
                break;
            case "Enforcer":
                _ID28716();
                break;
            case "Striker":
                setstrikermodel();
                self botsetflag( "path_traverse_wait", 1 );
                break;
            case "Blaster":
                _ID28650();
                self botsetdifficultysetting( "maxFireTime", 2800 );
                self botsetdifficultysetting( "minFireTime", 1500 );
                break;
            case "Hammer":
                _ID28743();
                break;
        }

        endswitch( 6 )  case "Hammer" loc_CAA case "Blaster" loc_C86 case "Striker" loc_C70 case "Enforcer" loc_C66 case "Ravager" loc_C5C default loc_CB4
        self setviewmodel( "viewhands_juggernaut_ally" );
        self setclothtype( "cloth" );
        _ID15592();
    }

    self._ID14072 = 0;
}

_ID34598( var_0 )
{
    self waittill( "spawned_player" );

    if ( !var_0 )
        thread maps\mp\gametypes\_hud_message::_ID31052( "horde_respawn" );
}

_ID21451( var_0 )
{
    var_0 endon( "disconnect" );

    for (;;)
    {
        var_0 waittill( "unresolved_collision" );
        maps\mp\_movers::_ID34251( var_0, 0 );
        wait 0.5;
    }
}

_ID38232( var_0 )
{
    var_0 endon( "disconnect" );

    if ( level.currentroundnumber == 0 )
        return;

    if ( !isdefined( level._ID6711 ) )
        return;

    foreach ( var_2 in level._ID6711 )
    {
        if ( isdefined( var_2.outlinecolor ) )
            var_2.friendlymodel hudoutlineenable( var_2.outlinecolor, 0 );
    }

    common_scripts\utility::_ID35582();

    if ( !isdefined( level.characters ) )
        return;

    foreach ( var_5 in level.characters )
    {
        if ( isdefined( var_5.outlinecolor ) )
            var_5 hudoutlineenable( var_5.outlinecolor, 0 );
    }
}

_ID28847()
{
    self setmodel( "mp_body_infected_a" );

    if ( isdefined( self._ID16458 ) )
        self detach( self._ID16458, "" );

    self._ID16458 = "head_mp_infected";
    self attach( self._ID16458, "", 1 );
}

_ID28716()
{
    self setmodel( "mp_body_juggernaut_light_black" );

    if ( isdefined( self._ID16458 ) )
        self detach( self._ID16458, "" );

    self._ID16458 = "head_juggernaut_light_black";
    self attach( self._ID16458, "", 1 );
}

setstrikermodel()
{
    self setmodel( "mp_body_infected_a" );

    if ( isdefined( self._ID16458 ) )
        self detach( self._ID16458, "" );

    self._ID16458 = "head_mp_infected";
    self attach( self._ID16458, "", 1 );
}

_ID28650()
{
    self setmodel( "mp_fullbody_juggernaut_heavy_black" );

    if ( isdefined( self._ID16458 ) )
    {
        self detach( self._ID16458, "" );
        self._ID16458 = undefined;
    }
}

_ID28743()
{
    self setmodel( "mp_body_juggernaut_light_black" );

    if ( isdefined( self._ID16458 ) )
        self detach( self._ID16458, "" );

    self._ID16458 = "head_juggernaut_light_black";
    self attach( self._ID16458, "", 1 );
}

_ID24468( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        var_4 = weaponclipsize( var_3 );
        self setweaponammoclip( var_3, var_4 );
    }

    var_6 = 1.5;

    for (;;)
    {
        var_1 = self getweaponslistprimaries();

        foreach ( var_3 in var_1 )
        {
            if ( var_3 == var_0 )
            {
                var_8 = self getweaponammostock( var_3 );
                self setweaponammostock( var_3, var_8 + 1 );
            }
        }

        wait(var_6);
    }
}

ammorefillprimary()
{
    if ( self._ID24978 == "none" )
        return;

    for (;;)
    {
        self givemaxammo( self._ID24978 );
        wait 12;
    }
}

ammorefillsecondary()
{
    if ( self._ID27984 == "none" )
        return;

    for (;;)
    {
        self givemaxammo( self._ID27984 );
        wait 8;
    }
}

_ID27020()
{
    level endon( "game_ended" );
    _ID35785();

    foreach ( var_1 in level.players )
    {
        if ( var_1.class == "" )
        {
            var_1 notify( "luinotifyserver",  "class_select", 0  );
            var_1 thread _ID36978();
        }
    }

    for (;;)
    {
        _ID34547();
        _ID29980();
        level notify( "start_round" );
        level._ID14070 = 1;
        _ID36741();
        level childthread _ID21434();
        level waittill( "round_ended" );
    }
}

_ID36978()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    common_scripts\utility::_ID35582();
    self setclientomnvar( "ui_options_menu", -1 );
}

_ID36741()
{
    if ( !( level.currentroundnumber % 4 ) && level._ID18819 )
        level notify( "giveTeamIntel",  level._ID24549  );

    if ( level.currentroundnumber == 21 && maps\mp\gametypes\_horde_util::_ID15195() == 1 && !maps\mp\gametypes\_horde_util::_ID16377( level.players[0] ) )
        level.players[0] thread maps\mp\killstreaks\_killstreaks::_ID15602( "agent", 0, 0, level.players[0] );
}

_ID21434()
{
    if ( maps\mp\gametypes\_horde_util::_ID18796() )
        monitorspecialroundend();
    else
        _ID21424();
}

_ID21424()
{
    for (;;)
    {
        level waittill( "enemy_death" );

        if ( level.currentenemycount == level._ID20734 && level._ID8680 == 0 )
        {
            notifyroundover();
            return;
        }
    }
}

monitorspecialroundend()
{
    var_0 = getspecialroundtimer();
    level thread maps\mp\gametypes\_horde_util::_ID29991( "horde_special_round" );
    _ID28751( "round_time", var_0 );
    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    _ID7487();
    notifyroundover();
}

getspecialroundtimer()
{
    return level._ID30964;
}

notifyroundover()
{
    level notify( "round_ended" );
    level thread respawneliminatedplayers();
    level thread maps\mp\gametypes\_horde_util::_ID24647( "mp_safe_round_end" );

    if ( !maps\mp\gametypes\_horde_util::_ID18796() )
        level thread maps\mp\_utility::_ID19760( "round_end", level._ID24549, "status" );
}

respawneliminatedplayers()
{
    level endon( "game_ended" );

    foreach ( var_1 in level.players )
    {
        if ( !maps\mp\gametypes\_horde_util::isonhumanteam( var_1 ) )
            continue;

        if ( maps\mp\gametypes\_horde_util::_ID18740( var_1 ) && !var_1.beingrevived )
            var_1 notify( "revive_trigger",  var_1  );

        if ( var_1.sessionstate == "spectator" )
        {
            var_1.pers["lives"] = 1;
            var_1 thread maps\mp\gametypes\_playerlogic::_ID30822();
        }
    }
}

_ID38227()
{
    if ( level.currentroundnumber > 19 )
    {
        foreach ( var_1 in level.players )
            var_1 giveachievement( "EXTRA1" );
    }
}

_ID34547()
{
    _ID38227();

    if ( level.currentroundnumber == level._ID20759 )
    {
        level.finalkillcam_winner = level._ID24549;
        level thread maps\mp\gametypes\_gamelogic::endgame( level._ID24549, game["end_reason"][level.enemyteam + "_eliminated"] );
    }

    level.currentroundnumber = _ID15174();
    level._ID20734 = _ID15143( level.currentroundnumber );
    level.currentenemycount = 0;
    level.maxaliveenemycount = getmaxaliveenemycount( level.currentroundnumber );
    level._ID8680 = 0;
    level.maxpickupsperround = _ID15144();
    level._ID23418 = getpercentchancetodrop();
    level._ID8701 = 0;
    level._ID8681 = 0;
    level.chancetospawndog = 0;

    if ( chancefordoground() )
    {
        level.chancetospawndog = 55;
        level._ID19544 = level.currentroundnumber;
    }

    if ( level.currentroundnumber > 4 )
        setnojipscore( 1 );

    foreach ( var_1 in level.players )
    {
        var_1._ID37918++;

        if ( var_1._ID37918 != level.currentroundnumber && var_1._ID37918 > 9 )
            var_1._ID37918 = level.currentroundnumber;

        maps\mp\gametypes\_horde_util::_ID36757( var_1, var_1._ID37918 );
    }
}

chancefordoground()
{
    if ( level.currentroundnumber < 4 )
        return 0;

    if ( maps\mp\gametypes\_horde_util::_ID18796( level.currentroundnumber ) )
        return 0;

    if ( level._ID19544 == level.currentroundnumber - 1 )
        return 0;

    if ( randomintrange( 1, 101 ) < 20 )
        return 1;

    if ( level.currentroundnumber - level._ID19544 > 4 )
        return 1;

    return 0;
}

_ID15174()
{
    var_0 = level.currentroundnumber + 1;
    return var_0;
}

_ID15322( var_0 )
{
    var_0 = int( clamp( var_0, 1, 20 ) );
    var_0 -= 1;
    return var_0 * 4 + maps\mp\gametypes\_horde_util::_ID15195();
}

getmaxrounds( var_0 )
{
    var_1 = 100;

    switch ( var_0 )
    {
        case 0:
        case 1:
            var_1 = 20;
            break;
        case 2:
            var_1 = 40;
            break;
        case 3:
            var_1 = 100;
            break;
        default:
            var_1 = 100;
            break;
    }

    return var_1;
}

_ID15143( var_0 )
{
    var_1 = _ID15322( var_0 );
    var_2 = int( tablelookupbyrow( "mp/hordeSettings.csv", var_1, 1 ) );

    if ( var_0 > 20 )
    {
        var_3 = var_0 - 20;
        var_2 += var_3;
    }

    return var_2;
}

getmaxaliveenemycount( var_0 )
{
    var_1 = _ID15322( var_0 );
    var_2 = int( tablelookupbyrow( "mp/hordeSettings.csv", var_1, 2 ) );

    if ( var_0 > 20 )
    {
        var_3 = var_0 - 20;
        var_4 = 1 + int( var_3 / 5 );
        var_2 += 2 * var_4;
        var_2 = min( var_2, 20 );
    }

    return var_2;
}

_ID35785()
{
    maps\mp\_utility::gameflagwait( "prematch_done" );

    while ( !isdefined( level._ID5678 ) || level._ID5678 == 0 )
        common_scripts\utility::_ID35582();

    while ( !level.players.size )
        common_scripts\utility::_ID35582();
}

_ID29980()
{
    if ( _ID29975() )
        _ID28751( "start_time", getroundintermissiontimer() );

    maps\mp\gametypes\_hostmigration::_ID35597( getroundintermissiontimer() );
    _ID7487();
    setomnvar( "ui_horde_round_number", level.currentroundnumber );
    level thread respawneliminatedplayers();

    if ( !maps\mp\gametypes\_horde_util::_ID18796() )
    {
        var_0 = "mp_safe_round_start";

        if ( maps\mp\gametypes\_horde_util::_ID18606() )
            var_0 = "mp_safe_round_boss";

        level childthread maps\mp\gametypes\_horde_util::_ID24647( var_0 );
        level thread maps\mp\_utility::_ID19760( "round_start", level._ID24549, "status" );
    }
    else
        level thread maps\mp\_utility::_ID19760( "round_loot", level._ID24549, "status" );
}

_ID29975()
{
    if ( level.currentroundnumber == 1 )
        return 0;

    if ( maps\mp\gametypes\_horde_util::_ID18796( level.currentroundnumber ) )
        return 0;

    if ( maps\mp\gametypes\_horde_util::_ID18796( level.currentroundnumber - 1 ) )
        return 0;

    return 1;
}

getroundintermissiontimer()
{
    if ( !_ID29975() )
        return 5;

    return 20;
}

_ID27019()
{
    level endon( "game_ended" );
    _ID35785();

    if ( !isdefined( level.hordedroplocations ) || !level.hordedroplocations.size )
        return;

    level childthread monitorsupportdropprogress();

    for (;;)
    {
        level waittill( "airSupport" );
        level childthread displayincomingairdropmessage();
        var_0 = maps\mp\gametypes\_horde_util::_ID15195() + 1;
        var_0 = min( var_0, 4 );
        _ID30456();

        for ( var_1 = 0; var_1 < var_0; var_1++ )
        {
            var_2 = level.hordedroplocations[level._ID11088];
            level thread callairsupport( var_2._ID33250 );
            level._ID11088 = _ID15166( level._ID11088 );
        }
    }
}

_ID30456()
{
    var_0 = ( 0, 0, 0 );
    var_1 = 0;

    foreach ( var_3 in level.players )
    {
        if ( !maps\mp\gametypes\_horde_util::isonhumanteam( var_3 ) || !isalive( var_3 ) )
            continue;

        var_1++;
        var_0 += ( var_3.origin[0], var_3.origin[1], var_3.origin[2] );
    }

    var_5 = var_0 / var_1;
    level.hordedroplocations = sortbydistance( level.hordedroplocations, var_5 );
    level._ID11088 = randomint( 3 );
}

_ID15166( var_0 )
{
    var_1 = var_0 + 1;

    if ( var_1 == level.hordedroplocations.size )
        return 0;

    return var_1;
}

monitorsupportdropprogress()
{
    var_0 = _ID15388();

    for (;;)
    {
        level common_scripts\utility::_ID35626( "pointsEarned", "host_migration_end" );

        if ( level._ID8702 >= var_0 )
        {
            level notify( "airSupport" );
            level._ID8702 = level._ID8702 - var_0;
            var_0 = _ID15388();
        }

        setomnvar( "ui_horde_support_drop_progress", int( level._ID8702 / var_0 * 100 ) );
    }
}

_ID15388()
{
    var_0 = _ID15143( level.currentroundnumber );
    var_1 = int( level.currentroundnumber / 4 );
    var_2 = 45 + var_1 * 15;
    return var_0 * var_2;
}

_ID36659( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 waittill( "spawned_player" );
    common_scripts\utility::_ID35582();
    var_1 = getarraykeys( var_0._ID36291 );

    foreach ( var_3 in var_1 )
        var_0._ID36291[var_3]["barSize"] = getweaponbarsize( 1, var_3 );

    var_0 setclientomnvar( "ui_horde_weapon_progress", 0 );
    var_0 setclientomnvar( "ui_horde_weapon_level", 1 );
    var_5 = int( max( level.currentroundnumber, 1 ) );
    setomnvar( "ui_horde_round_number", var_5 );
    thread _ID38294();
}

_ID38294()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "host_migration_end" );
        var_0 = int( max( level.currentroundnumber, 1 ) );
        setomnvar( "ui_horde_round_number", var_0 );

        foreach ( var_2 in level.players )
        {
            if ( isai( var_2 ) )
                continue;

            if ( !isdefined( var_2 ) )
                continue;

            var_3 = maps\mp\gametypes\_horde_util::getplayerweaponhorde( var_2 );
            var_4 = getweaponbasename( var_3 );
            var_5 = var_2._ID36291[var_4]["barSize"];
            var_2 setclientomnvar( "ui_horde_weapon_progress", int( var_2._ID36291[var_4]["vaule"] / var_5 * 100 ) );
            var_2 setclientomnvar( "ui_horde_weapon_level", var_2._ID36291[var_4]["level"] );

            if ( !isdefined( var_2._ID17063 ) )
                continue;

            if ( !var_2._ID17063.size )
                continue;

            var_6 = var_2._ID17063.size;

            for ( var_7 = 0; var_7 < var_6; var_7++ )
            {
                if ( !isdefined( var_2 ) )
                    continue;

                var_2 setclientomnvar( "ui_horde_update_perk", var_2._ID17063[var_7]["index"] );
                wait 0.05;
            }
        }
    }
}

_ID21465( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    _ID35785();
    maps\mp\gametypes\_horde_util::_ID36758( var_0, 1 );

    for (;;)
    {
        var_0 common_scripts\utility::_ID35626( "weaponPointsEarned", "weapon_change" );
        var_1 = maps\mp\gametypes\_horde_util::getplayerweaponhorde( var_0 );
        var_2 = getweaponbasename( var_1 );

        if ( !_ID16425( var_0, var_2 ) )
            continue;

        var_3 = var_0._ID36291[var_2]["barSize"];

        if ( var_0._ID36291[var_2]["vaule"] >= var_3 )
        {
            var_0 playlocalsound( "mp_safe_weapon_up" );
            playfx( level._ID1644["weapon_level"], var_0.origin + ( 0, 0, _ID15482( var_0 ) ) );
            level thread _ID38235( var_0, var_2, var_1 );
            var_0._ID36291[var_2]["level"]++;
            var_0._ID36291[var_2]["vaule"] = var_0._ID36291[var_2]["vaule"] - var_3;

            if ( var_0._ID37666 < var_0._ID36291[var_2]["level"] )
            {
                var_0._ID37666 = var_0._ID36291[var_2]["level"];
                maps\mp\gametypes\_horde_util::_ID36758( var_0, var_0._ID37666 );
            }

            var_0 thread maps\mp\gametypes\_hud_message::_ID31052( "horde_weapon_level" );
            var_0._ID36291[var_2]["barSize"] = getweaponbarsize( var_0._ID36291[var_2]["level"], var_2 );
        }

        var_0 setclientomnvar( "ui_horde_weapon_progress", int( var_0._ID36291[var_2]["vaule"] / var_3 * 100 ) );
        var_0 setclientomnvar( "ui_horde_weapon_level", var_0._ID36291[var_2]["level"] );
    }
}

_ID38235( var_0, var_1, var_2 )
{
    if ( !_ID36709( var_1 ) )
        return;

    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_0 notify( "camo_update" );
    var_0 endon( "camo_update" );
    var_3 = var_0 getweaponammoclip( var_2 );
    var_4 = var_0 getweaponammostock( var_2 );
    var_0 setweaponmodelvariant( var_2, _ID37351( var_0._ID36291[var_1]["level"] ) );
}

_ID36709( var_0 )
{
    if ( !level._ID36710 )
        return 0;

    switch ( var_0 )
    {
        case "iw6_usr_mp":
        case "iw6_kac_mp":
        case "iw6_arx160_mp":
        case "iw6_mts255_mp":
        case "iw6_fp6_mp":
        case "iw6_vepr_mp":
        case "iw6_microtar_mp":
        case "iw6_ak12_mp":
        case "iw6_m27_mp":
            return 1;
        default:
            return 0;
    }
}

_ID37351( var_0 )
{
    var_1 = 0;
    var_2 = 4;

    switch ( var_0 )
    {
        case 0:
        case 1:
            var_1 = 0;
            break;
        case 2:
            var_1 = 1;
            break;
        case 3:
            var_1 = 2;
            break;
        case 4:
            var_1 = 3;
            break;
        case 5:
            var_1 = 4;
            break;
        case 6:
        case 7:
            var_1 = 5;
            break;
        case 8:
        case 9:
            var_1 = 6;
            break;
        case 10:
        case 11:
            var_1 = 7;
            break;
        case 12:
        case 13:
            var_1 = 8;
            break;
        case 14:
        case 15:
            var_1 = 9;
            break;
        case 16:
        case 17:
            var_1 = 10;
            break;
        case 18:
        case 19:
            var_1 = 11;
            break;
        case 20:
        case 21:
            var_1 = 12;
            break;
        case 22:
        case 23:
        default:
            var_1 = 13;
            break;
    }

    var_3 = tablelookup( "mp/camotable.csv", 0, var_1, var_2 );
    return int( var_3 );
}

_ID15482( var_0 )
{
    var_1 = var_0 getstance();

    if ( var_1 == "stand" )
        return 48;

    if ( var_1 == "crouch" )
        return 32;

    return 12;
}

getweaponbarsize( var_0, var_1 )
{
    var_2 = weaponclass( var_1 ) == "sniper";
    var_3 = _ID15143( var_0 );
    var_4 = var_3 * 0.8 * 45;

    if ( var_2 )
        var_4 /= 2.5;

    return var_4;
}

displayincomingairdropmessage()
{
    foreach ( var_1 in level.players )
    {
        if ( !maps\mp\gametypes\_horde_util::isonhumanteam( var_1 ) )
            continue;

        if ( var_1.sessionstate == "spectator" )
            continue;

        var_1 playlocalsound( "mp_safe_air_support" );
        var_1 thread maps\mp\gametypes\_hud_message::_ID31052( "horde_support_drop" );
    }
}

callairsupport( var_0 )
{
    playfx( level._ID1644["dropLocation"], var_0 + ( 0, 0, 2 ) );
    var_1 = "one";

    switch ( level.currentroundnumber )
    {
        case 1:
        case 2:
        case 3:
            var_1 = "a";
            break;
        case 4:
        case 5:
        case 6:
            var_1 = "b";
            break;
        case 7:
        case 8:
        case 9:
            var_1 = "c";
            break;
        case 10:
        case 11:
        case 12:
            var_1 = "d";
            break;
        default:
            var_1 = "e";
    }

    var_2 = level.players[0];

    foreach ( var_4 in level.players )
    {
        if ( !maps\mp\_utility::_ID18757( var_4 ) )
            continue;

        if ( maps\mp\gametypes\_horde_util::_ID18740( var_4 ) )
            continue;

        var_2 = var_4;
        break;
    }

    if ( maps\mp\_utility::_ID8679() > maps\mp\_utility::maxvehiclesallowed() || level._ID12791 + 1 > maps\mp\_utility::maxvehiclesallowed() )
        return;

    maps\mp\_utility::_ID17543();
    level thread maps\mp\killstreaks\_airdrop::_ID10390( var_2, var_0, randomfloat( 360 ), var_1 );
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
    if ( self._ID14072 && isplayer( self ) )
        maps\mp\gametypes\_menus::addtoteam( level._ID24549, 1 );

    var_0 = self.team;

    if ( maps\mp\gametypes\_horde_util::isonhumanteam( self ) )
    {
        var_1 = maps\mp\gametypes\_spawnlogic::_ID15425( var_0 );

        if ( level._ID17628 )
            var_2 = maps\mp\gametypes\_spawnlogic::_ID15346( var_1 );
        else
            var_2 = maps\mp\gametypes\_spawnscoring::_ID15345( var_1 );

        return var_2;
    }

    var_1 = maps\mp\gametypes\_spawnlogic::_ID15425( var_0 );
    var_2 = maps\mp\gametypes\_spawnscoring::_ID15347( var_1 );
    return var_2;
}

getagentdamagescalar()
{
    var_0 = 0.25;
    var_1 = maps\mp\gametypes\_horde_util::_ID15195();

    switch ( var_1 )
    {
        case 0:
            var_0 = 0.09;
            break;
        case 1:
            var_0 = 0.09;
            break;
        case 2:
            var_0 = 0.1;
            break;
        case 3:
            var_0 = 0.125;
            break;
        case 4:
        default:
            var_0 = 0.125;
            break;
    }

    return var_0;
}

_ID21287( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( isdefined( var_1 ) && isdefined( var_1.team ) && var_1.team == var_0.team )
        return 0;

    if ( isdefined( var_1 ) && isplayer( var_1 ) )
    {
        if ( var_0 == var_1 && maps\mp\_utility::_ID18679( var_4 ) )
            var_2 = 0;

        var_8 = getweaponbasename( var_4 );

        if ( _ID16425( var_1, var_8 ) )
            var_2 = int( var_2 + var_2 * 0.1 * ( var_1._ID36291[var_8]["level"] - 1 ) );

        if ( var_0.team == level.enemyteam && var_1.team == level._ID24549 )
        {
            if ( var_3 == "MOD_MELEE" )
            {
                var_2 = var_0.maxhealth + 1;

                if ( var_0._ID17064 == "Blaster" )
                    var_2 = int( var_0.maxhealth * 0.7 );
            }

            if ( maps\mp\_utility::_ID18679( var_4 ) )
                var_2 = int( var_2 + 20 * level.currentroundnumber );

            if ( isdefined( level._ID19276[var_4] ) && level._ID19276[var_4] == "heli_sniper" )
                var_2 = int( var_0.maxhealth ) + 1;

            if ( maps\mp\gametypes\_class::_ID18846( var_4, 0 ) )
            {
                if ( isexplosivedamagemod( var_3 ) )
                    var_2 = int( var_0.maxhealth ) + 1;

                if ( var_4 == "throwingknife_mp" )
                {
                    var_2 = var_0.maxhealth + 1;

                    if ( var_0._ID17064 == "Blaster" )
                        var_2 = int( var_0.maxhealth * 0.7 );
                }
            }

            var_1 _ID15618( var_0, var_2, var_3, var_4, var_5, var_6, var_7, 0 );
        }
    }

    if ( isdefined( var_1 ) && isdefined( var_1.owner ) && isplayer( var_1.owner ) )
    {
        var_9 = 0;

        if ( maps\mp\_utility::_ID18679( var_4 ) )
            var_2 = int( var_2 + 20 * level.currentroundnumber );

        if ( isagent( var_1 ) )
        {
            var_2 = int( var_2 + var_2 * 0.1 * ( level.currentroundnumber - 2 ) );
            var_9 = 1;
        }

        var_1.owner _ID15618( var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_9 );
    }

    if ( isplayer( var_0 ) || maps\mp\gametypes\_horde_util::isonhumanteam( var_0 ) )
    {
        if ( maps\mp\gametypes\_horde_util::_ID18740( var_0 ) && !var_0 maps\mp\_utility::_ID33165() )
            return 0;

        if ( isdefined( var_0._ID22850 ) && var_0._ID22850 )
            return 0;

        if ( var_4 == "semtexproj_mp" )
            var_2 *= 3;

        if ( isplayer( var_0 ) )
            var_2 = int( var_2 * 0.125 );
        else
            var_2 = int( var_2 * getagentdamagescalar() );

        if ( isdefined( var_1 ) && isagent( var_1 ) )
        {
            var_1 hudoutlineenable( level._ID12074, 0 );
            var_1.outlinecolor = level._ID12074;

            if ( var_3 == "MOD_MELEE" )
                var_2 = int( var_0.maxhealth / 2 ) + 1;

            if ( var_1.agent_type == "dog" )
                var_2 = int( var_0.maxhealth / 4 ) + 1;
        }

        if ( isdefined( var_0._ID18764 ) && var_0._ID18764 )
        {
            if ( isagent( var_0 ) )
                var_2 = 0;

            if ( isplayer( var_0 ) )
                var_2 = int( var_2 * 0.9 );
        }

        if ( var_0 maps\mp\_utility::_ID18837() && var_0 maps\mp\_utility::_ID15315() == "remotemissile" )
            var_2 = int( var_2 * 0.9 );
    }

    return var_2;
}

_ID15618( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = maps\mp\_utility::_ID18642( var_3, var_6, var_2, self );
    var_9 = var_2 == "MOD_MELEE" || var_2 == "MOD_IMPACT";
    var_10 = var_1 >= var_0.health;

    if ( var_9 && var_6 == "shield" )
        return;

    var_11 = undefined;

    if ( var_10 )
    {
        if ( var_9 )
            var_11 = "kill_melee";
        else if ( var_8 )
            var_11 = "kill_head";
        else
            var_11 = "kill_normal";

        self notify( "horde_kill",  var_0, var_3, var_2  );
    }
    else if ( var_8 )
        var_11 = "damage_head";
    else
        var_11 = "damage_body";

    givepointsforevent( var_11, var_3, var_7 );
}

givepointsforevent( var_0, var_1, var_2 )
{
    var_3 = level._ID24714[var_0];
    self._ID37828[self._ID37828.size] = var_3;
    maps\mp\gametypes\_gamescore::_ID15616( var_0, self, undefined, 1, 1, 1 );
    thread maps\mp\gametypes\_rank::giverankxp( var_0 );
    level._ID8702 = level._ID8702 + var_3;
    level notify( "pointsEarned" );

    if ( var_2 )
        return;

    var_4 = getweaponbasename( var_1 );

    if ( _ID16425( self, var_4 ) )
    {
        self._ID36291[var_4]["vaule"] = self._ID36291[var_4]["vaule"] + var_3;
        self notify( "weaponPointsEarned" );
    }
}

_ID37703( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );

    for (;;)
    {
        if ( var_0._ID37828.size > 0 )
        {
            var_0 setclientomnvar( "ui_horde_award_points", var_0._ID37828[var_0._ID37828.size - 1] );
            var_0._ID37828 = _ID37890( var_0._ID37828 );
        }

        wait 0.05;
    }
}

_ID37890( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < var_0.size - 1; var_2++ )
        var_1[var_2] = var_0[var_2];

    return var_1;
}

_ID22869( var_0, var_1, var_2 )
{
    _ID26021( var_0 );

    if ( !isdefined( var_1 ) )
        return;

    if ( game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level._ID23070[var_1.team]] )
        var_1._ID12872 = 1;
}

_ID26021( var_0 )
{
    if ( isplayer( var_0 ) )
    {
        var_0 setclientomnvar( "ui_horde_update_perk", 0 );
        var_0._ID17063 = [];
    }
}

chancetospawnpickup( var_0 )
{
    if ( level._ID8701 == level.maxpickupsperround )
        return;

    level endon( "game_ended" );
    var_1 = randomintrange( 1, 101 );

    if ( var_1 > level._ID23418 )
        return;

    var_2 = level._ID36276;
    var_3 = level._ID36275;

    if ( level._ID8681 < level.maxammopickupsperround && common_scripts\utility::_ID7657() )
    {
        var_2 = level.ammopickupmodel;
        var_3 = level.ammopickupfunc;
        level._ID8681++;
    }

    _ID30900( var_0.origin + ( 0, 0, 14 ), var_2, var_3 );
}

_ID30900( var_0, var_1, var_2 )
{
    var_3[0] = spawn( "script_model", ( 0, 0, 0 ) );
    var_3[0] setmodel( var_1 );
    var_3[0] hudoutlineenable( 1, 0 );
    var_4 = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 32, 32 );
    var_5 = maps\mp\gametypes\_gameobjects::_ID8493( level._ID24549, var_4, var_3, ( 0, 0, 16 ) );
    maps\mp\_utility::_objective_delete( var_5._ID32670["allies"] );
    maps\mp\_utility::_objective_delete( var_5._ID32670["axis"] );
    maps\mp\gametypes\_objpoints::deleteobjpoint( var_5.objpoints["allies"] );
    maps\mp\gametypes\_objpoints::deleteobjpoint( var_5.objpoints["axis"] );
    var_6 = var_0;
    var_5.curorigin = var_6;
    var_5.trigger.origin = var_6;
    var_5._ID35361[0].origin = var_6;
    var_5 maps\mp\gametypes\_gameobjects::_ID29198( 0 );
    var_5 maps\mp\gametypes\_gameobjects::allowuse( "friendly" );
    var_5._ID22916 = var_2;
    level._ID8701++;
    var_5 thread _ID23547();
    var_5 thread pickuptimer();
}

_ID23547()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    self endon( "death" );
    var_0 = self;
    var_1 = self.curorigin;
    var_2 = self.curorigin + ( 0, 0, 12 );
    var_3 = 1.25;

    if ( isdefined( self._ID35361 ) && isdefined( self._ID35361[0] ) )
        var_0 = self._ID35361[0];

    for (;;)
    {
        var_0 moveto( var_2, var_3, 0.15, 0.15 );
        var_0 rotateyaw( 180, var_3 );
        wait(var_3);
        var_0 moveto( var_1, var_3, 0.15, 0.15 );
        var_0 rotateyaw( 180, var_3 );
        wait(var_3);
    }
}

pickuptimer()
{
    self endon( "deleted" );
    wait 15;
    thread _ID23553();
    wait 8;
    level thread removepickup( self );
}

_ID23553()
{
    self endon( "deleted" );

    for (;;)
    {
        self._ID35361[0] hide();
        wait 0.25;
        self._ID35361[0] show();
        wait 0.25;
    }
}

removepickup( var_0 )
{
    var_0 notify( "deleted" );
    wait 0.05;
    var_0.trigger delete();
    var_0._ID35361[0] delete();
}

_ID36274( var_0 )
{
    if ( !isplayer( var_0 ) )
        return;

    var_1 = maps\mp\gametypes\_horde_util::getplayerweaponhorde( var_0 );
    var_2 = getweaponbasename( var_1 );

    if ( _ID16425( var_0, var_2 ) )
    {
        var_3 = var_0._ID36291[var_2]["barSize"];
        var_0._ID36291[var_2]["vaule"] = var_3;
        var_0 notify( "weaponPointsEarned" );
    }

    level thread removepickup( self );
}

ammopickup( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( maps\mp\gametypes\_horde_util::isonhumanteam( var_2 ) && maps\mp\_utility::_ID18757( var_2 ) )
        {
            var_2 thread maps\mp\gametypes\_hud_message::_ID31052( "horde_team_restock" );
            maps\mp\gametypes\_horde_util::_ID37864( var_2 );
            var_2.health = var_2.maxhealth;
        }
    }

    var_0 playlocalsound( "mp_safe_team_ammo" );
    playfx( level._ID1644["weapon_level"], var_0.origin + ( 0, 0, _ID15482( var_0 ) ) );
    level thread removepickup( self );
}

hordemaydropweapon( var_0 )
{
    if ( var_0 == level._ID24542 )
        return 0;

    return 1;
}

dropweaponfordeathhorde( var_0, var_1 )
{
    var_2 = maps\mp\gametypes\_horde_util::getplayerweaponhorde( self );

    if ( var_2 == level.intelminigun )
        var_2 = maps\mp\killstreaks\_killstreaks::_ID15018();

    if ( !hordemaydropweapon( var_2 ) )
        return;

    var_3 = ( 0, 0, 18 );
    var_4 = spawn( "script_model", self.origin + var_3 );
    var_4 hide();
    var_4 setmodel( "mp_weapon_crate" );
    var_4.owner = self;
    var_4.curorigin = self.origin + var_3;
    var_4._ID33308 = var_2;
    var_4 hudoutlineenable( 1, 0 );
    var_4.trigger = spawn( "trigger_radius", self.origin + var_3, 0, 32, 32 );

    foreach ( var_6 in level.players )
    {
        if ( var_4.owner == var_6 )
            var_4 showtoplayer( var_4.owner );
    }

    var_4 thread _ID23547();
    var_4 thread watchweaponpickuphorde();
    var_4 thread _ID26045();
}

watchweaponpickuphorde()
{
    self endon( "death" );

    for (;;)
    {
        self.trigger waittill( "trigger",  var_0  );

        if ( var_0 == self.owner )
            break;
    }

    maps\mp\gametypes\_horde_crates::_ID33791( var_0, self._ID33308 );
    var_0 thread maps\mp\gametypes\_hud_message::_ID31052( "horde_recycle" );
    var_0 playlocalsound( "mp_safe_weapon_up" );
    playfx( level._ID1644["weapon_level"], var_0.origin + ( 0, 0, _ID15482( var_0 ) ) );
    self.trigger delete();
    self delete();
}

_ID26045()
{
    self endon( "death" );
    level endon( "game_ended" );
    self.owner common_scripts\utility::_ID35626( "started_spawnPlayer", "disconnect" );
    wait 22;
    thread _ID31489();
    wait 8;

    if ( !isdefined( self ) )
        return;

    self.trigger delete();
    self delete();
}

_ID31489()
{
    self endon( "trigger" );
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self hide();
        wait 0.25;
        self showtoplayer( self.owner );
        wait 0.25;
    }
}

_ID22796( var_0 )
{
    if ( var_0 != level.enemyteam )
    {
        iprintln( &"MP_GHOSTS_ELIMINATED" );
        logstring( "team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
        level.finalkillcam_winner = "axis";
        level thread maps\mp\gametypes\_gamelogic::endgame( "axis", game["end_reason"]["allies_eliminated"] );
    }
}

_ID28879()
{
    level._ID17075["allies"]["loadoutPrimary"] = "none";
    level._ID17075["allies"]["loadoutPrimaryAttachment"] = "none";
    level._ID17075["allies"]["loadoutPrimaryAttachment2"] = "none";
    level._ID17075["allies"]["loadoutPrimaryBuff"] = "specialty_null";
    level._ID17075["allies"]["loadoutPrimaryCamo"] = "none";
    level._ID17075["allies"]["loadoutPrimaryReticle"] = "none";
    level._ID17075["allies"]["loadoutSecondary"] = "iw6_mp443";
    level._ID17075["allies"]["loadoutSecondaryAttachment"] = "xmags";
    level._ID17075["allies"]["loadoutSecondaryAttachment2"] = "none";
    level._ID17075["allies"]["loadoutSecondaryBuff"] = "specialty_null";
    level._ID17075["allies"]["loadoutSecondaryCamo"] = "none";
    level._ID17075["allies"]["loadoutSecondaryReticle"] = "none";
    level._ID17075["allies"]["loadoutEquipment"] = "proximity_explosive_mp";
    level._ID17075["allies"]["loadoutOffhand"] = "concussion_grenade_mp";
    level._ID17075["allies"]["loadoutStreakType"] = "assault";
    level._ID17075["allies"]["loadoutKillstreak1"] = "none";
    level._ID17075["allies"]["loadoutKillstreak2"] = "none";
    level._ID17075["allies"]["loadoutKillstreak3"] = "none";
    level._ID17075["allies"]["loadoutJuggernaut"] = 0;
    level._ID17075["allies"]["loadoutPerks"] = [ "specialty_falldamage" ];
    level._ID17075["squadmate"]["loadoutPrimary"] = "iw6_ak12";
    level._ID17075["squadmate"]["loadoutPrimaryAttachment"] = "none";
    level._ID17075["squadmate"]["loadoutPrimaryAttachment2"] = "none";
    level._ID17075["squadmate"]["loadoutPrimaryBuff"] = "specialty_null";
    level._ID17075["squadmate"]["loadoutPrimaryCamo"] = "none";
    level._ID17075["squadmate"]["loadoutPrimaryReticle"] = "none";
    level._ID17075["squadmate"]["loadoutSecondary"] = "none";
    level._ID17075["squadmate"]["loadoutSecondaryAttachment"] = "none";
    level._ID17075["squadmate"]["loadoutSecondaryAttachment2"] = "none";
    level._ID17075["squadmate"]["loadoutSecondaryBuff"] = "specialty_null";
    level._ID17075["squadmate"]["loadoutSecondaryCamo"] = "none";
    level._ID17075["squadmate"]["loadoutSecondaryReticle"] = "none";
    level._ID17075["squadmate"]["loadoutEquipment"] = "proximity_explosive_mp";
    level._ID17075["squadmate"]["loadoutOffhand"] = "concussion_grenade_mp";
    level._ID17075["squadmate"]["loadoutStreakType"] = "assault";
    level._ID17075["squadmate"]["loadoutKillstreak1"] = "none";
    level._ID17075["squadmate"]["loadoutKillstreak2"] = "none";
    level._ID17075["squadmate"]["loadoutKillstreak3"] = "none";
    level._ID17075["squadmate"]["loadoutJuggernaut"] = 0;
    level._ID17075["squadmate"]["loadoutPerks"] = [ "specialty_falldamage" ];
    level._ID17075["axis"]["a"]["loadoutPrimary"] = "iw6_maul";
    level._ID17075["axis"]["a"]["loadoutPrimaryAttachment"] = "none";
    level._ID17075["axis"]["a"]["loadoutPrimaryAttachment2"] = "none";
    level._ID17075["axis"]["a"]["loadoutPrimaryBuff"] = "specialty_null";
    level._ID17075["axis"]["a"]["loadoutPrimaryCamo"] = "none";
    level._ID17075["axis"]["a"]["loadoutPrimaryReticle"] = "none";
    level._ID17075["axis"]["a"]["loadoutSecondary"] = "none";
    level._ID17075["axis"]["a"]["loadoutSecondaryAttachment"] = "none";
    level._ID17075["axis"]["a"]["loadoutSecondaryAttachment2"] = "none";
    level._ID17075["axis"]["a"]["loadoutSecondaryBuff"] = "specialty_null";
    level._ID17075["axis"]["a"]["loadoutSecondaryCamo"] = "none";
    level._ID17075["axis"]["a"]["loadoutSecondaryReticle"] = "none";
    level._ID17075["axis"]["a"]["loadoutEquipment"] = "specialty_null";
    level._ID17075["axis"]["a"]["loadoutOffhand"] = "none";
    level._ID17075["axis"]["a"]["loadoutStreakType"] = "assault";
    level._ID17075["axis"]["a"]["loadoutKillstreak1"] = "none";
    level._ID17075["axis"]["a"]["loadoutKillstreak2"] = "none";
    level._ID17075["axis"]["a"]["loadoutKillstreak3"] = "none";
    level._ID17075["axis"]["a"]["loadoutJuggernaut"] = 0;
    level._ID17075["axis"]["a"]["name_localized"] = &"HORDE_RAVAGER";
    level._ID17075["axis"]["a"]["type"] = "Ravager";
    level._ID17075["axis"]["a"]["loadoutPerks"] = [ "specialty_falldamage" ];
    level._ID17075["axis"]["b"]["loadoutPrimary"] = "iw6_vepr";
    level._ID17075["axis"]["b"]["loadoutPrimaryAttachment"] = "none";
    level._ID17075["axis"]["b"]["loadoutPrimaryAttachment2"] = "none";
    level._ID17075["axis"]["b"]["loadoutPrimaryBuff"] = "specialty_null";
    level._ID17075["axis"]["b"]["loadoutPrimaryCamo"] = "none";
    level._ID17075["axis"]["b"]["loadoutPrimaryReticle"] = "none";
    level._ID17075["axis"]["b"]["loadoutSecondary"] = "none";
    level._ID17075["axis"]["b"]["loadoutSecondaryAttachment"] = "none";
    level._ID17075["axis"]["b"]["loadoutSecondaryAttachment2"] = "none";
    level._ID17075["axis"]["b"]["loadoutSecondaryBuff"] = "specialty_null";
    level._ID17075["axis"]["b"]["loadoutSecondaryCamo"] = "none";
    level._ID17075["axis"]["b"]["loadoutSecondaryReticle"] = "none";
    level._ID17075["axis"]["b"]["loadoutEquipment"] = "specialty_null";
    level._ID17075["axis"]["b"]["loadoutOffhand"] = "none";
    level._ID17075["axis"]["b"]["loadoutStreakType"] = "assault";
    level._ID17075["axis"]["b"]["loadoutKillstreak1"] = "none";
    level._ID17075["axis"]["b"]["loadoutKillstreak2"] = "none";
    level._ID17075["axis"]["b"]["loadoutKillstreak3"] = "none";
    level._ID17075["axis"]["b"]["loadoutJuggernaut"] = 0;
    level._ID17075["axis"]["b"]["name_localized"] = &"HORDE_ENFORCER";
    level._ID17075["axis"]["b"]["type"] = "Enforcer";
    level._ID17075["axis"]["b"]["loadoutPerks"] = [ "specialty_falldamage" ];
    level._ID17075["axis"]["c"]["loadoutPrimary"] = "iw6_riotshield";
    level._ID17075["axis"]["c"]["loadoutPrimaryAttachment"] = "none";
    level._ID17075["axis"]["c"]["loadoutPrimaryAttachment2"] = "none";
    level._ID17075["axis"]["c"]["loadoutPrimaryBuff"] = "specialty_null";
    level._ID17075["axis"]["c"]["loadoutPrimaryCamo"] = "none";
    level._ID17075["axis"]["c"]["loadoutPrimaryReticle"] = "none";
    level._ID17075["axis"]["c"]["loadoutSecondary"] = "none";
    level._ID17075["axis"]["c"]["loadoutSecondaryAttachment"] = "none";
    level._ID17075["axis"]["c"]["loadoutSecondaryAttachment2"] = "none";
    level._ID17075["axis"]["c"]["loadoutSecondaryBuff"] = "specialty_null";
    level._ID17075["axis"]["c"]["loadoutSecondaryCamo"] = "none";
    level._ID17075["axis"]["c"]["loadoutSecondaryReticle"] = "none";
    level._ID17075["axis"]["c"]["loadoutEquipment"] = "specialty_null";
    level._ID17075["axis"]["c"]["loadoutOffhand"] = "none";
    level._ID17075["axis"]["c"]["loadoutStreakType"] = "assault";
    level._ID17075["axis"]["c"]["loadoutKillstreak1"] = "none";
    level._ID17075["axis"]["c"]["loadoutKillstreak2"] = "none";
    level._ID17075["axis"]["c"]["loadoutKillstreak3"] = "none";
    level._ID17075["axis"]["c"]["loadoutJuggernaut"] = 0;
    level._ID17075["axis"]["c"]["name_localized"] = &"HORDE_STRIKER";
    level._ID17075["axis"]["c"]["type"] = "Striker";
    level._ID17075["axis"]["c"]["loadoutPerks"] = [ "specialty_falldamage" ];
    level._ID17075["axis"]["d"]["loadoutPrimary"] = "none";
    level._ID17075["axis"]["d"]["loadoutPrimaryAttachment"] = "none";
    level._ID17075["axis"]["d"]["loadoutPrimaryAttachment2"] = "none";
    level._ID17075["axis"]["d"]["loadoutPrimaryBuff"] = "specialty_null";
    level._ID17075["axis"]["d"]["loadoutPrimaryCamo"] = "none";
    level._ID17075["axis"]["d"]["loadoutPrimaryReticle"] = "none";
    level._ID17075["axis"]["d"]["loadoutSecondary"] = "iw6_mk32horde";
    level._ID17075["axis"]["d"]["loadoutSecondaryAttachment"] = "none";
    level._ID17075["axis"]["d"]["loadoutSecondaryAttachment2"] = "none";
    level._ID17075["axis"]["d"]["loadoutSecondaryBuff"] = "specialty_null";
    level._ID17075["axis"]["d"]["loadoutSecondaryCamo"] = "none";
    level._ID17075["axis"]["d"]["loadoutSecondaryReticle"] = "none";
    level._ID17075["axis"]["d"]["loadoutEquipment"] = "specialty_null";
    level._ID17075["axis"]["d"]["loadoutOffhand"] = "none";
    level._ID17075["axis"]["d"]["loadoutStreakType"] = "assault";
    level._ID17075["axis"]["d"]["loadoutKillstreak1"] = "none";
    level._ID17075["axis"]["d"]["loadoutKillstreak2"] = "none";
    level._ID17075["axis"]["d"]["loadoutKillstreak3"] = "none";
    level._ID17075["axis"]["d"]["loadoutJuggernaut"] = 0;
    level._ID17075["axis"]["d"]["name_localized"] = &"HORDE_BLASTER";
    level._ID17075["axis"]["d"]["type"] = "Blaster";
    level._ID17075["axis"]["d"]["loadoutPerks"] = [ "specialty_falldamage" ];
    level._ID17075["axis"]["e"]["loadoutPrimary"] = "iw6_kac";
    level._ID17075["axis"]["e"]["loadoutPrimaryAttachment"] = "flashsuppress";
    level._ID17075["axis"]["e"]["loadoutPrimaryAttachment2"] = "none";
    level._ID17075["axis"]["e"]["loadoutPrimaryBuff"] = "specialty_null";
    level._ID17075["axis"]["e"]["loadoutPrimaryCamo"] = "none";
    level._ID17075["axis"]["e"]["loadoutPrimaryReticle"] = "none";
    level._ID17075["axis"]["e"]["loadoutSecondary"] = "none";
    level._ID17075["axis"]["e"]["loadoutSecondaryAttachment"] = "none";
    level._ID17075["axis"]["e"]["loadoutSecondaryAttachment2"] = "none";
    level._ID17075["axis"]["e"]["loadoutSecondaryBuff"] = "specialty_null";
    level._ID17075["axis"]["e"]["loadoutSecondaryCamo"] = "none";
    level._ID17075["axis"]["e"]["loadoutSecondaryReticle"] = "none";
    level._ID17075["axis"]["e"]["loadoutEquipment"] = "specialty_null";
    level._ID17075["axis"]["e"]["loadoutOffhand"] = "none";
    level._ID17075["axis"]["e"]["loadoutStreakType"] = "assault";
    level._ID17075["axis"]["e"]["loadoutKillstreak1"] = "none";
    level._ID17075["axis"]["e"]["loadoutKillstreak2"] = "none";
    level._ID17075["axis"]["e"]["loadoutKillstreak3"] = "none";
    level._ID17075["axis"]["e"]["loadoutJuggernaut"] = 0;
    level._ID17075["axis"]["e"]["name_localized"] = &"HORDE_HAMMER";
    level._ID17075["axis"]["e"]["type"] = "Hammer";
    level._ID17075["axis"]["e"]["loadoutPerks"] = [ "specialty_falldamage" ];
}

_ID15053()
{
    var_0 = level._ID17075["axis"]["a"];

    if ( level.currentroundnumber < 5 )
        return var_0;

    if ( level.currentroundnumber < 9 )
    {
        if ( common_scripts\utility::_ID7657() )
            var_0 = level._ID17075["axis"]["b"];

        return var_0;
    }

    var_0 = level._ID17075["axis"]["b"];

    if ( level.currentroundnumber < 13 )
    {
        if ( randomintrange( 1, 11 ) < 4 )
            var_0 = level._ID17075["axis"]["c"];

        return var_0;
    }

    if ( level.currentroundnumber < 16 )
    {
        var_1 = randomintrange( 1, 11 );

        if ( var_1 < 4 )
            var_0 = level._ID17075["axis"]["d"];

        return var_0;
    }

    if ( level.currentroundnumber < 24 )
    {
        var_1 = randomintrange( 1, 11 );

        if ( var_1 < 3 )
            var_0 = level._ID17075["axis"]["c"];
        else if ( var_1 < 5 )
            var_0 = level._ID17075["axis"]["d"];

        return var_0;
    }

    var_0 = level._ID17075["axis"]["e"];
    var_1 = randomintrange( 1, 11 );

    if ( var_1 < 3 )
        var_0 = level._ID17075["axis"]["c"];
    else if ( var_1 < 4 )
        var_0 = level._ID17075["axis"]["d"];

    var_2 = 0;

    if ( var_0["type"] == "Blaster" )
    {
        var_3 = 0;

        foreach ( var_5 in level._ID23303 )
        {
            if ( isai( var_5 ) && isdefined( var_5._ID17064 ) )
            {
                if ( var_5._ID17064 == var_0["type"] )
                {
                    var_3++;

                    if ( var_3 >= 4 )
                    {
                        var_2 = 1;
                        break;
                    }
                }
            }
        }
    }

    if ( var_2 )
    {
        var_0 = level._ID17075["axis"]["a"];

        if ( common_scripts\utility::_ID7657() )
            var_0 = level._ID17075["axis"]["b"];
    }

    return var_0;
}
