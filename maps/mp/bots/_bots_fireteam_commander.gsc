// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    if ( maps\mp\_utility::bot_is_fireteam_mode() )
    {
        level._ID32345 = [];
        level._ID32345[0] = "tactics_exit";
        level._ID32345[1] = "tactic_none";

        if ( level._ID14086 == "dom" )
        {
            level._ID32345[2] = "tactic_dom_holdA";
            level._ID32345[3] = "tactic_dom_holdB";
            level._ID32345[4] = "tactic_dom_holdC";
            level._ID32345[5] = "tactic_dom_holdAB";
            level._ID32345[6] = "tactic_dom_holdAC";
            level._ID32345[7] = "tactic_dom_holdBC";
            level._ID32345[8] = "tactic_dom_holdABC";
        }
        else if ( level._ID14086 == "war" )
        {
            level._ID32345[2] = "tactic_war_hyg";
            level._ID32345[3] = "tactic_war_buddy";
            level._ID32345[4] = "tactic_war_hp";
            level._ID32345[5] = "tactic_war_pincer";
            level._ID32345[6] = "tactic_war_ctc";
            level._ID32345[7] = "tactic_war_rg";
        }
        else
            return;

        level._ID13079 = [];
        level._ID13079["axis"] = undefined;
        level._ID13079["allies"] = undefined;
        level._ID13083 = [];
        level._ID13083["axis"] = undefined;
        level._ID13083["allies"] = undefined;
        level.fireteam_hunt_target_zone = [];
        level.fireteam_hunt_target_zone["axis"] = undefined;
        level.fireteam_hunt_target_zone["allies"] = undefined;
        level thread commander_wait_connect();
        level thread _ID7796();
    }
}

_ID7796()
{
    level waittill( "game_ended" );

    if ( isdefined( level._ID13079["axis"] ) )
    {
        var_0 = 0;

        foreach ( var_2 in level.players )
        {
            if ( isbot( var_2 ) && var_2.team == "axis" )
                var_0 += var_2.pers["score"];
        }

        level._ID13079["axis"].pers["score"] = var_0;
        level._ID13079["axis"].score = var_0;
        level._ID13079["axis"] maps\mp\gametypes\_persistence::_ID31495( "score", var_0 );
        level._ID13079["axis"] maps\mp\gametypes\_persistence::_ID31528( "round", "score", var_0 );
    }

    if ( isdefined( level._ID13079["allies"] ) )
    {
        var_0 = 0;

        foreach ( var_2 in level.players )
        {
            if ( isbot( var_2 ) && var_2.team == "allies" )
                var_0 += var_2.pers["score"];
        }

        level._ID13079["allies"].pers["score"] = var_0;
        level._ID13079["allies"].score = var_0;
        level._ID13079["allies"] maps\mp\gametypes\_persistence::_ID31495( "score", var_0 );
        level._ID13079["allies"] maps\mp\gametypes\_persistence::_ID31528( "round", "score", var_0 );
    }
}

commander_create_dom_obj( var_0 )
{
    if ( !isdefined( self._ID13081[var_0] ) )
    {
        self._ID13081[var_0] = maps\mp\gametypes\_gameobjects::getnextobjid();
        var_1 = ( 0, 0, 0 );

        foreach ( var_3 in level._ID10614 )
        {
            if ( var_3.label == "_" + var_0 )
            {
                var_1 = var_3.curorigin;
                break;
            }
        }

        objective_add( self._ID13081[var_0], "invisible", var_1, "compass_obj_fireteam" );
        objective_playerteam( self._ID13081[var_0], self getentitynumber() );
    }
}

commander_initialize_gametype()
{
    if ( isdefined( self.commander_gametype_initialized ) )
        return;

    self.commander_gametype_initialized = 1;
    self.commander_last_tactic_applied = "tactic_none";
    self.commander_last_tactic_selected = "tactic_none";

    switch ( level._ID14086 )
    {
        case "war":
            break;
        case "dom":
            self._ID13081 = [];
            commander_create_dom_obj( "a" );
            commander_create_dom_obj( "b" );
            commander_create_dom_obj( "c" );
            break;
    }
}

commander_monitor_tactics()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "luinotifyserver",  var_0, var_1  );

        if ( var_0 != "tactic_select" )
        {
            if ( var_0 == "bot_select" )
            {
                if ( var_1 > 0 )
                    commander_handle_notify_quick( "bot_next" );
                else if ( var_1 < 0 )
                    commander_handle_notify_quick( "bot_prev" );
            }
            else if ( var_0 == "tactics_menu" )
            {
                if ( var_1 > 0 )
                    commander_handle_notify_quick( "tactics_menu" );
                else if ( var_1 <= 0 )
                    commander_handle_notify_quick( "tactics_close" );
            }

            continue;
        }

        if ( var_1 >= level._ID32345.size )
            continue;

        var_2 = level._ID32345[var_1];
        commander_handle_notify_quick( var_2 );
    }
}

commander_handle_notify_quick( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    switch ( var_0 )
    {
        case "bot_prev":
            commander_spectate_next_bot( 1 );
            break;
        case "bot_next":
            commander_spectate_next_bot( 0 );
            break;
        case "tactics_menu":
            self notify( "commander_mode" );

            if ( isdefined( self._ID13536 ) )
                self._ID13536 notify( "commander_mode" );

            break;
        case "tactics_close":
            self._ID7798 = gettime();
            self notify( "takeover_bot" );
            break;
        case "tactic_none":
            if ( level._ID14086 == "dom" )
            {
                objective_state( self._ID13081["a"], "invisible" );
                objective_state( self._ID13081["b"], "invisible" );
                objective_state( self._ID13081["c"], "invisible" );
            }

            break;
        case "tactic_dom_holdA":
            objective_state( self._ID13081["a"], "active" );
            objective_state( self._ID13081["b"], "invisible" );
            objective_state( self._ID13081["c"], "invisible" );
            break;
        case "tactic_dom_holdB":
            objective_state( self._ID13081["a"], "invisible" );
            objective_state( self._ID13081["b"], "active" );
            objective_state( self._ID13081["c"], "invisible" );
            break;
        case "tactic_dom_holdC":
            objective_state( self._ID13081["a"], "invisible" );
            objective_state( self._ID13081["b"], "invisible" );
            objective_state( self._ID13081["c"], "active" );
            break;
        case "tactic_dom_holdAB":
            objective_state( self._ID13081["a"], "active" );
            objective_state( self._ID13081["b"], "active" );
            objective_state( self._ID13081["c"], "invisible" );
            break;
        case "tactic_dom_holdAC":
            objective_state( self._ID13081["a"], "active" );
            objective_state( self._ID13081["b"], "invisible" );
            objective_state( self._ID13081["c"], "active" );
            break;
        case "tactic_dom_holdBC":
            objective_state( self._ID13081["a"], "invisible" );
            objective_state( self._ID13081["b"], "active" );
            objective_state( self._ID13081["c"], "active" );
            break;
        case "tactic_dom_holdABC":
            objective_state( self._ID13081["a"], "active" );
            objective_state( self._ID13081["b"], "active" );
            objective_state( self._ID13081["c"], "active" );
            break;
        case "tactic_war_rg":
            break;
        case "tactic_war_ctc":
            break;
        case "tactic_war_hp":
            break;
        case "tactic_war_buddy":
            break;
        case "tactic_war_pincer":
            break;
        case "tactic_war_hyg":
            break;
    }

    if ( common_scripts\utility::string_starts_with( var_0, "tactic_" ) )
    {
        self playlocalsound( "earn_superbonus" );

        if ( self.commander_last_tactic_applied != var_0 )
        {
            self.commander_last_tactic_applied = var_0;
            thread commander_order_ack();

            if ( isdefined( level.bot_funcs["commander_gametype_tactics"] ) )
                self [[ level.bot_funcs["commander_gametype_tactics"] ]]( var_0 );
        }
    }
}

commander_order_ack()
{
    self notify( "commander_order_ack" );
    self endon( "commander_order_ack" );
    self endon( "disconnect" );
    var_0 = 360000;
    var_1 = var_0;
    var_2 = undefined;

    for (;;)
    {
        wait 0.5;
        var_1 = var_0;
        var_2 = undefined;
        var_3 = self.origin;
        var_4 = self getspectatingplayer();

        if ( isdefined( var_4 ) )
            var_3 = var_4.origin;

        foreach ( var_6 in level.players )
        {
            if ( isdefined( var_6 ) && isalive( var_6 ) && isbot( var_6 ) && isdefined( var_6.team ) && var_6.team == self.team )
            {
                var_7 = distancesquared( var_3, var_6.origin );

                if ( var_7 < var_1 )
                    var_2 = var_6;
            }
        }

        if ( isdefined( var_2 ) )
        {
            var_9 = var_2.pers["voicePrefix"];
            var_10 = var_9 + level.bcsounds["callout_response_generic"];
            var_2 thread maps\mp\gametypes\_battlechatter_mp::_ID10767( var_10, 1, 1 );
            return;
        }
    }
}

_ID7806( var_0 )
{
    if ( !isdefined( self ) )
        return;

    self notify( "commander_hint_fade_out" );

    if ( isdefined( self._ID7822 ) )
    {
        var_1 = self._ID7822;

        if ( var_0 > 0 )
        {
            var_1 changefontscaleovertime( var_0 );
            var_1.fontscale = var_1.fontscale * 1.5;
            var_1.glowcolor = ( 0.3, 0.6, 0.3 );
            var_1.glowalpha = 1;
            var_1 fadeovertime( var_0 );
            var_1.color = ( 0, 0, 0 );
            var_1.alpha = 0;
            wait(var_0);
        }

        var_1 maps\mp\gametypes\_hud_util::destroyelem();
    }
}

_ID7804()
{
    self endon( "disconnect" );
    self endon( "commander_mode" );
    self.commander_gave_hint = 1;
    wait 1;

    if ( !isdefined( self ) )
        return;

    self._ID7822 = maps\mp\gametypes\_hud_util::createfontstring( "default", 3 );
    self._ID7822.color = ( 1, 1, 1 );
    self._ID7822 settext( &"MPUI_COMMANDER_HINT" );
    self._ID7822.x = 0;
    self._ID7822.y = 20;
    self._ID7822.alignx = "center";
    self._ID7822.aligny = "middle";
    self._ID7822.horzalign = "center";
    self._ID7822.vertalign = "middle";
    self._ID7822.foreground = 1;
    self._ID7822.alpha = 1;
    self._ID7822.hidewhendead = 1;
    self._ID7822.sort = -1;
    self._ID7822 endon( "death" );
    thread commander_hint_delete_on_commander_menu();
    wait 4.0;
    thread _ID7806( 0.5 );
}

commander_hint_delete_on_commander_menu()
{
    self endon( "disconnect" );
    self endon( "commander_hint_fade_out" );
    self waittill( "commander_mode" );
    thread _ID7806( 0 );
}

hud_monitorplayerownership()
{
    self endon( "disconnect" );
    self.ownershipstring = [];

    for ( var_0 = 0; var_0 < 16; var_0++ )
    {
        self.ownershipstring[var_0] = maps\mp\gametypes\_hud_util::createfontstring( "default", 1 );
        self.ownershipstring[var_0].color = ( 1, 1, 1 );
        self.ownershipstring[var_0].x = 0;
        self.ownershipstring[var_0].y = 30 + var_0 * 12;
        self.ownershipstring[var_0].alignx = "center";
        self.ownershipstring[var_0].aligny = "top";
        self.ownershipstring[var_0].horzalign = "center";
        self.ownershipstring[var_0].vertalign = "top";
        self.ownershipstring[var_0].foreground = 1;
        self.ownershipstring[var_0].alpha = 1;
        self.ownershipstring[var_0].sort = -1;
        self.ownershipstring[var_0].archived = 0;
    }

    for (;;)
    {
        var_1 = 0;
        var_2 = [];

        foreach ( var_4 in self.ownershipstring )
        {

        }

        foreach ( var_7 in level.players )
        {
            var_8 = 0;

            if ( isdefined( var_7 ) && var_7.team == self.team )
            {
                if ( isdefined( var_7.owner ) )
                {
                    if ( common_scripts\utility::array_contains( var_2, var_7 ) )
                        self.ownershipstring[var_1].color = ( 1, 0, 0 );
                    else
                        var_2 = common_scripts\utility::array_add( var_2, var_7 );

                    if ( var_7 != var_7.owner && common_scripts\utility::array_contains( var_2, var_7.owner ) )
                        self.ownershipstring[var_1].color = ( 1, 0, 0 );
                    else
                        var_2 = common_scripts\utility::array_add( var_2, var_7.owner );

                    if ( var_7 == self )
                        self.ownershipstring[var_1].color = ( 1, 0, 0 );
                    else if ( var_7.owner == var_7 )
                        self.ownershipstring[var_1].color = ( 1, 0, 0 );
                    else if ( var_7.owner == self )
                        self.ownershipstring[var_1].color = ( 0, 1, 0 );
                    else
                        self.ownershipstring[var_1].color = ( 1, 1, 1 );
                }
                else if ( isdefined( var_7.bot_fireteam_follower ) )
                    var_8 = 1;
                else
                    self.ownershipstring[var_1].color = ( 1, 1, 0 );
            }
            else
                var_8 = 1;

            if ( !var_8 )
                var_1++;
        }

        wait 0.1;
    }
}

commander_wait_connect()
{
    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            if ( !isai( var_1 ) && !isdefined( var_1._ID13080 ) )
            {
                var_1._ID13080 = 1;
                var_1 setclientomnvar( "ui_options_menu", 0 );
                var_1.classcallback = ::commander_loadout_class_callback;
                var_2 = "allies";

                if ( !isdefined( var_1.team ) )
                {
                    if ( level._ID32656["axis"] < level._ID32656["allies"] )
                        var_2 = "axis";
                    else if ( level._ID32656["allies"] < level._ID32656["axis"] )
                        var_2 = "allies";
                }

                var_1 maps\mp\gametypes\_menus::addtoteam( var_2 );
                level._ID13079[var_1.team] = var_1;
                var_1 maps\mp\gametypes\_menus::bypassclasschoice();
                var_1.class_num = 0;
                var_1._ID35590 = 0;
                var_1 thread onfirstspawnedplayer();
                var_1 thread commander_monitor_tactics();
            }
        }

        wait 0.05;
    }
}

onfirstspawnedplayer()
{
    self endon( "disconnect" );

    for (;;)
    {
        if ( self.team != "spectator" && self.sessionstate == "spectator" )
        {
            thread commander_initialize_gametype();
            thread _ID35435();
            thread commander_spectate_first_available_bot();
            return;
        }

        wait 0.05;
    }
}

commander_spectate_first_available_bot()
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "spectating_cycle" );

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            if ( isbot( var_1 ) && var_1.team == self.team )
            {
                thread _ID7816( var_1 );
                var_1 thread _ID7804();
                return;
            }
        }

        wait 0.1;
    }
}

_ID21319()
{
    self endon( "disconnect" );
    self endon( "joined_spectators" );

    for (;;)
    {
        self waittill( "commander_mode" );
        var_0 = maps\mp\killstreaks\_killstreaks::_ID18511();
        var_1 = maps\mp\killstreaks\_deployablebox::_ID18647();

        if ( !isalive( self ) || var_0 || var_1 )
            continue;

        break;
    }

    if ( self.team == "spectator" )
        return;

    thread _ID35435();
    self playlocalsound( "mp_card_slide" );
    var_2 = 0;

    foreach ( var_4 in level.players )
    {
        if ( isdefined( var_4 ) && var_4 != self && isbot( var_4 ) && isdefined( var_4.team ) && var_4.team == self.team && isdefined( var_4._ID30022 ) && var_4._ID30022 == 1 )
        {
            var_4 thread _ID30973( self );
            var_2 = 1;
            break;
        }
    }

    if ( !var_2 )
        thread maps\mp\gametypes\_playerlogic::spawnspectator();
}

commander_can_takeover_bot( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( !isbot( var_0 ) )
        return 0;

    if ( !isalive( var_0 ) )
        return 0;

    if ( !var_0._ID7864 )
        return 0;

    if ( var_0.team != self.team )
        return 0;

    var_1 = var_0 maps\mp\killstreaks\_killstreaks::_ID18511();

    if ( var_1 )
        return 0;

    var_2 = maps\mp\killstreaks\_deployablebox::_ID18647();

    if ( var_2 )
        return 0;

    return 1;
}

_ID24072()
{
    for ( var_0 = 0; var_0 < level.players.size; var_0++ )
    {
        if ( level.players[var_0] == self )
            return var_0;
    }

    return -1;
}

commander_spectate_next_bot( var_0 )
{
    var_1 = self getspectatingplayer();
    var_2 = undefined;
    var_3 = 0;
    var_4 = 1;

    if ( isdefined( var_0 ) && var_0 == 1 )
        var_4 = -1;

    if ( isdefined( var_1 ) )
        var_3 = var_1 _ID24072();

    var_5 = 1;

    for ( var_6 = var_3 + var_4; var_5 < level.players.size; var_6 += var_4 )
    {
        var_5++;

        if ( var_6 < 0 )
            var_6 = level.players.size - 1;
        else if ( var_6 >= level.players.size )
            var_6 = 0;

        if ( !isdefined( level.players[var_6] ) )
            continue;

        if ( isdefined( var_1 ) && level.players[var_6] == var_1 )
            break;

        var_7 = commander_can_takeover_bot( level.players[var_6] );

        if ( var_7 )
        {
            var_2 = level.players[var_6];
            break;
        }
    }

    if ( isdefined( var_2 ) && ( !isdefined( var_1 ) || var_2 != var_1 ) )
    {
        thread _ID7816( var_2 );
        self playlocalsound( "oldschool_return" );
        var_2 thread takeover_flash();

        if ( isdefined( var_1 ) )
            var_1 bot_free_to_move();
    }
    else
        self playlocalsound( "counter_uav_deactivate" );
}

_ID7816( var_0 )
{
    self notify( "commander_spectate_bot" );
    self endon( "commander_spectate_bot" );
    self endon( "commander_spectate_stop" );
    self endon( "disconnect" );

    while ( isdefined( var_0 ) )
    {
        if ( !self.spectatekillcam && var_0.sessionstate == "playing" )
        {
            var_1 = var_0 getentitynumber();

            if ( self.forcespectatorclient != var_1 )
            {
                self allowspectateteam( "none", 0 );
                self allowspectateteam( "freelook", 0 );
                self.forcespectatorclient = var_1;
                self._ID13536 = var_0;
                maps\mp\killstreaks\_killstreaks::copy_killstreak_status( var_0, 1 );
            }
            else if ( !isdefined( self.adrenaline ) || isdefined( var_0.adrenaline ) && self.adrenaline != var_0.adrenaline )
                maps\mp\killstreaks\_killstreaks::copy_adrenaline( var_0 );
        }

        wait 0.05;
    }
}

_ID14761()
{
    var_0 = undefined;

    if ( isdefined( self._ID13536 ) )
        var_0 = self._ID13536;
    else
        var_0 = self getspectatingplayer();

    return var_0;
}

commander_takeover_first_available_bot()
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "spectating_cycle" );

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            if ( isbot( var_1 ) && var_1.team == self.team )
            {
                _ID30973( var_1 );
                return;
            }
        }

        wait 0.1;
    }
}

_ID30973( var_0 )
{
    self._ID13535 = var_0.origin;
    var_1 = var_0 getplayerangles();
    var_1 = ( var_1[0], var_1[1], 0.0 );
    self.forcespawnangles = ( 0, var_0.angles[1], 0 );
    self setstance( var_0 getstance() );
    self.botlastloadout = var_0.botlastloadout;
    self.bot_class = var_0.bot_class;
    commander_or_bot_change_class( self.bot_class );
    self.health = var_0.health;
    self.velocity = var_0.velocity;
    store_weapons_status( var_0 );
    var_0 maps\mp\gametypes\_weapons::_ID33365( self );
    var_0 thread maps\mp\gametypes\_playerlogic::spawnspectator();

    if ( isbot( var_0 ) )
    {
        var_0._ID30022 = 1;
        var_0 bot_free_to_move();
        self playercommandbot( var_0 );
        self notify( "commander_spectate_stop" );
        var_0 notify( "commander_took_over" );
        jump loc_125A
    }

    thread maps\mp\gametypes\_playerlogic::_ID30822();
    self setplayerangles( var_1 );
    apply_weapons_status();
    maps\mp\killstreaks\_killstreaks::copy_killstreak_status( var_0 );
    botsentientswap( self, var_0 );

    if ( isbot( self ) )
    {
        var_0 thread _ID7816( self );
        var_0 playercommandbot( undefined );
        self._ID30022 = 0;
        var_0 playlocalsound( "counter_uav_activate" );
        thread takeover_flash();
        var_0.commanding_bot = undefined;
        var_0.last_commanded_bot = self;
        _ID5827();
    }
    else
    {
        thread _ID21319();
        self playsound( "copycat_steal_class" );
        thread takeover_flash();
        self.commanding_bot = var_0;
        self.last_commanded_bot = undefined;

        if ( !isdefined( self.commander_gave_hint ) )
            thread _ID7804();
    }
}

takeover_flash()
{
    if ( !isdefined( self._ID32397 ) )
    {
        self._ID32397 = newclienthudelem( self );
        self._ID32397.x = 0;
        self._ID32397.y = 0;
        self._ID32397.alignx = "left";
        self._ID32397.aligny = "top";
        self._ID32397.horzalign = "fullscreen";
        self._ID32397.vertalign = "fullscreen";
        self._ID32397 setshader( "combathigh_overlay", 640, 480 );
        self._ID32397.sort = -10;
        self._ID32397.archived = 1;
    }

    self._ID32397.alpha = 0.0;
    self._ID32397 fadeovertime( 0.25 );
    self._ID32397.alpha = 1.0;
    wait 0.75;
    self._ID32397 fadeovertime( 0.5 );
    self._ID32397.alpha = 0.0;
}

_ID35435()
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    self notify( "takeover_wait_start" );
    self endon( "takeover_wait_start" );

    for (;;)
    {
        self waittill( "takeover_bot" );
        var_0 = _ID14761();
        var_1 = commander_can_takeover_bot( var_0 );

        if ( !var_1 )
        {
            commander_spectate_next_bot( 0 );
            var_0 = _ID14761();
            var_1 = commander_can_takeover_bot( var_0 );
        }

        if ( var_1 )
        {
            thread _ID30973( var_0 );
            break;
        }

        self playlocalsound( "counter_uav_deactivate" );
    }
}

_ID5827()
{
    if ( !isdefined( self ) || !isplayer( self ) || !isbot( self ) )
        return;

    self notify( "wait_here" );
    self botsetflag( "disable_movement", 1 );
    self._ID4651 = "bot_waiting_" + self.team + "_" + self.name;
    badplace_cylinder( self._ID4651, 5, self.origin, 32, 72, self.team );
    thread _ID5550();
    thread _ID5826();
}

_ID5550( var_0 )
{
    self endon( "freed_to_move" );
    self endon( "disconnect" );
    self waittill( "death" );
    bot_free_to_move();
}

_ID5826()
{
    self endon( "wait_here" );
    wait 5;
    thread bot_free_to_move();
}

bot_free_to_move()
{
    if ( !isdefined( self ) || !isplayer( self ) || !isbot( self ) )
        return;

    self botsetflag( "disable_movement", 0 );

    if ( isdefined( self._ID4651 ) )
        badplace_delete( self._ID4651 );

    self notify( "freed_to_move" );
}

commander_loadout_class_callback( var_0 )
{
    return self.botlastloadout;
}

commander_or_bot_change_class( var_0 )
{
    self.pers["class"] = var_0;
    self.class = var_0;
    maps\mp\gametypes\_class::_ID28675( var_0 );
    self.tag_stowed_back = undefined;
    self._ID32354 = undefined;
}

store_weapons_status( var_0 )
{
    self.copy_fullweaponlist = var_0 getweaponslistall();
    self.copy_weapon_current = var_0 getcurrentweapon();

    foreach ( var_2 in self.copy_fullweaponlist )
    {
        self.copy_weapon_ammo_clip[var_2] = var_0 getweaponammoclip( var_2 );
        self.copy_weapon_ammo_stock[var_2] = var_0 getweaponammostock( var_2 );
    }
}

apply_weapons_status()
{
    foreach ( var_1 in self.copy_fullweaponlist )
    {
        if ( !self hasweapon( var_1 ) )
            self giveweapon( var_1 );
    }

    var_3 = self getweaponslistall();

    foreach ( var_1 in var_3 )
    {
        if ( !common_scripts\utility::array_contains( self.copy_fullweaponlist, var_1 ) )
            self takeweapon( var_1 );
    }

    foreach ( var_1 in self.copy_fullweaponlist )
    {
        if ( self hasweapon( var_1 ) )
        {
            self setweaponammoclip( var_1, self.copy_weapon_ammo_clip[var_1] );
            self setweaponammostock( var_1, self.copy_weapon_ammo_stock[var_1] );
            continue;
        }
    }

    if ( self getcurrentweapon() != self.copy_weapon_current )
        self switchtoweapon( self.copy_weapon_current );
}
