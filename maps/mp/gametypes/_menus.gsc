// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    if ( !isdefined( game["gamestarted"] ) )
    {
        game["menu_team"] = "team_marinesopfor";

        if ( level.multiteambased )
            game["menu_team"] = "team_mt_options";

        if ( maps\mp\_utility::bot_is_fireteam_mode() )
        {
            level.fireteam_menu = "class_commander_" + level._ID14086;
            game["menu_class"] = level.fireteam_menu;
            game["menu_class_allies"] = level.fireteam_menu;
            game["menu_class_axis"] = level.fireteam_menu;
        }
        else
        {
            game["menu_class"] = "class";
            game["menu_class_allies"] = "class_marines";
            game["menu_class_axis"] = "class_opfor";
        }

        game["menu_changeclass_allies"] = "changeclass_marines";
        game["menu_changeclass_axis"] = "changeclass_opfor";

        if ( level.multiteambased )
        {
            for ( var_0 = 0; var_0 < level._ID32668.size; var_0++ )
            {
                var_1 = "menu_class_" + level._ID32668[var_0];
                var_2 = "menu_changeclass_" + level._ID32668[var_0];
                game[var_1] = game["menu_class_allies"];
                game[var_2] = "changeclass_marines";
            }
        }

        game["menu_changeclass"] = "changeclass";

        if ( level.console )
        {
            game["menu_controls"] = "ingame_controls";

            if ( level.splitscreen )
            {
                if ( level.multiteambased )
                {
                    for ( var_0 = 0; var_0 < level._ID32668.size; var_0++ )
                    {
                        var_1 = "menu_class_" + level._ID32668[var_0];
                        var_2 = "menu_changeclass_" + level._ID32668[var_0];
                        game[var_1] += "_splitscreen";
                        game[var_2] += "_splitscreen";
                    }
                }

                game["menu_team"] += "_splitscreen";
                game["menu_class_allies"] += "_splitscreen";
                game["menu_class_axis"] += "_splitscreen";
                game["menu_changeclass_allies"] += "_splitscreen";
                game["menu_changeclass_axis"] += "_splitscreen";
                game["menu_controls"] += "_splitscreen";
                game["menu_changeclass_defaults_splitscreen"] = "changeclass_splitscreen_defaults";
                game["menu_changeclass_custom_splitscreen"] = "changeclass_splitscreen_custom";
                precachemenu( game["menu_changeclass_defaults_splitscreen"] );
                precachemenu( game["menu_changeclass_custom_splitscreen"] );
            }

            precachemenu( game["menu_controls"] );
        }

        precachemenu( game["menu_team"] );
        precachemenu( game["menu_class_allies"] );
        precachemenu( game["menu_class_axis"] );
        precachemenu( game["menu_changeclass"] );
        precachemenu( game["menu_changeclass_allies"] );
        precachemenu( game["menu_changeclass_axis"] );
        precachemenu( game["menu_class"] );
        precachestring( &"MP_HOST_ENDED_GAME" );
        precachestring( &"MP_HOST_ENDGAME_RESPONSE" );
    }

    level thread _ID22877();
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread _ID36070();
        var_0 thread _ID36080();
        var_0 thread _ID36074();
        var_0 thread _ID7867();
    }
}

_ID7867()
{

}

_ID14932( var_0 )
{
    if ( var_0 > 10 )
    {
        if ( var_0 > 10 && var_0 < 17 )
        {
            var_0 -= 10;
            var_0 = "axis_recipe" + var_0;
        }
        else if ( var_0 > 16 && var_0 < 23 )
        {
            var_0 -= 16;
            var_0 = "allies_recipe" + var_0;
        }
    }
    else
        var_0 = "custom" + var_0;

    return var_0;
}

_ID36070()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "luinotifyserver",  var_0, var_1  );

        if ( var_0 != "class_select" )
            continue;

        if ( getdvarint( "systemlink" ) && getdvarint( "xblive_competitionmatch" ) && self ismlgspectator() )
        {
            self setclientomnvar( "ui_options_menu", 0 );
            continue;
        }

        var_2 = isai( self ) || issubstr( self.name, "tcBot" );

        if ( !var_2 )
        {
            if ( !isai( self ) && "" + var_1 != "callback" )
                self setclientomnvar( "ui_loadout_selected", var_1 );
        }

        if ( isdefined( self._ID35590 ) && self._ID35590 )
            continue;

        if ( !maps\mp\_utility::allowclasschoice() || maps\mp\_utility::showfakeloadout() )
            continue;

        if ( "" + var_1 != "callback" )
        {
            if ( isdefined( self.pers["isBot"] ) && self.pers["isBot"] )
            {
                self.pers["class"] = var_1;
                self.class = var_1;
            }
            else
            {
                var_3 = var_1 + 1;
                var_3 = _ID14932( var_3 );

                if ( !isdefined( self.pers["class"] ) || var_3 == self.pers["class"] )
                    continue;

                self.pers["class"] = var_3;
                self.class = var_3;

                if ( level._ID17628 && !self.hasdonecombat )
                {
                    maps\mp\gametypes\_class::_ID28675( self.pers["class"] );
                    self.tag_stowed_back = undefined;
                    self._ID32354 = undefined;
                    maps\mp\gametypes\_class::giveloadout( self.pers["team"], self.pers["class"] );
                }
                else if ( isalive( self ) )
                    self iprintlnbold( game["strings"]["change_class"] );
            }

            continue;
        }

        _ID20943( "callback" );
    }
}

_ID36074()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "luinotifyserver",  var_0, var_1  );

        if ( var_0 != "end_game" )
            continue;

        if ( maps\mp\_utility::_ID18363() )
        {
            [[ level._ID13522 ]]();
            continue;
        }

        level thread maps\mp\gametypes\_gamelogic::_ID13521( var_1 );
    }
}

_ID36080()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "luinotifyserver",  var_0, var_1  );

        if ( var_0 != "team_select" )
            continue;

        if ( maps\mp\_utility::_ID20673() )
            continue;

        if ( var_1 != 3 )
            thread showloadoutmenu();

        if ( var_1 == 3 )
        {
            self setclientomnvar( "ui_spectator_selected", 1 );
            self setclientomnvar( "ui_loadout_selected", -1 );
            self.spectating_actively = 1;

            if ( getdvarint( "systemlink" ) && getdvarint( "xblive_competitionmatch" ) )
            {
                self setmlgspectator( 1 );
                self.pers["mlgSpectator"] = 1;
                thread maps\mp\gametypes\_spectating::_ID37970( 1 );
                thread maps\mp\gametypes\_spectating::_ID28880();
                self setclientomnvar( "ui_options_menu", 2 );
            }
        }
        else
        {
            self setclientomnvar( "ui_spectator_selected", -1 );
            self.spectating_actively = 0;

            if ( getdvarint( "systemlink" ) && getdvarint( "xblive_competitionmatch" ) )
            {
                self setmlgspectator( 0 );
                self.pers["mlgSpectator"] = 0;
                thread maps\mp\gametypes\_spectating::_ID37970( 0 );
            }
        }

        self setclientomnvar( "ui_team_selected", var_1 );

        if ( var_1 == 0 )
            var_1 = "axis";
        else if ( var_1 == 1 )
            var_1 = "allies";
        else if ( var_1 == 2 )
            var_1 = "random";
        else
            var_1 = "spectator";

        if ( isdefined( self.pers["team"] ) && var_1 == self.pers["team"] )
        {
            self notify( "selected_same_team" );
            continue;
        }

        self setclientomnvar( "ui_loadout_selected", -1 );

        if ( var_1 == "axis" )
        {
            thread _ID28895( "axis" );
            continue;
        }

        if ( var_1 == "allies" )
        {
            thread _ID28895( "allies" );
            continue;
        }

        if ( var_1 == "random" )
        {
            thread autoassign();
            continue;
        }

        if ( var_1 == "spectator" )
            thread _ID28881();
    }
}

showloadoutmenu()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    common_scripts\utility::_ID35626( "joined_team", "selected_same_team" );
    self setclientomnvar( "ui_options_menu", 2 );
}

autoassign()
{
    if ( maps\mp\_utility::_ID18363() || level._ID14086 == "infect" )
    {
        thread _ID28895( "allies" );
        return;
    }

    if ( ( getdvarint( "squad_match" ) == 1 || getdvarint( "squad_vs_squad" ) == 1 || getdvarint( "squad_use_hosts_squad" ) == 1 ) && isdefined( self._ID5801 ) )
    {
        thread _ID28895( self._ID5801 );
        return;
    }

    if ( !isdefined( self.team ) )
    {
        if ( self ismlgspectator() )
            thread _ID28881();
        else if ( level._ID32656["axis"] < level._ID32656["allies"] )
            thread _ID28895( "axis" );
        else if ( level._ID32656["allies"] < level._ID32656["axis"] )
            thread _ID28895( "allies" );
        else if ( getteamscore( "allies" ) > getteamscore( "axis" ) )
            thread _ID28895( "axis" );
        else
            thread _ID28895( "allies" );

        return;
    }

    if ( self ismlgspectator() )
    {
        thread _ID28881();
        return;
    }

    if ( level._ID32656["axis"] < level._ID32656["allies"] && self.team != "axis" )
    {
        thread _ID28895( "axis" );
        return;
    }

    if ( level._ID32656["allies"] < level._ID32656["axis"] && self.team != "allies" )
    {
        thread _ID28895( "allies" );
        return;
    }

    if ( level._ID32656["allies"] == level._ID32656["axis"] )
    {
        if ( getteamscore( "allies" ) > getteamscore( "axis" ) && self.team != "axis" )
        {
            thread _ID28895( "axis" );
            return;
        }

        if ( self.team != "allies" )
        {
            thread _ID28895( "allies" );
            return;
        }

        return;
        return;
    }

    return;
    return;
    return;
}

_ID28895( var_0 )
{
    self endon( "disconnect" );

    if ( !isai( self ) && level._ID32653 && !maps\mp\gametypes\_teams::_ID15072( var_0 ) )
        return;

    if ( level._ID17628 && !self.hasdonecombat )
        self.hasspawned = 0;

    if ( self.sessionstate == "playing" )
    {
        self._ID32285 = 1;
        self._ID18976 = var_0;
        self._ID19789 = self.pers["team"];
    }

    addtoteam( var_0 );

    if ( self.sessionstate == "playing" )
        self suicide();

    waitforclassselect();
    endrespawnnotify();

    if ( self.sessionstate == "spectator" )
    {
        if ( game["state"] == "postgame" )
            return;

        if ( game["state"] == "playing" && !maps\mp\_utility::_ID18658() )
        {
            if ( isdefined( self._ID35592 ) && self._ID35592 )
                return;

            thread maps\mp\gametypes\_playerlogic::_ID30822();
        }

        thread maps\mp\gametypes\_spectating::_ID28880();
    }

    self notify( "okToSpawn" );
}

_ID28881()
{
    if ( isdefined( self.pers["team"] ) && self.pers["team"] == "spectator" )
        return;

    if ( isalive( self ) )
    {
        self._ID32285 = 1;
        self._ID18976 = "spectator";
        self._ID19789 = self.pers["team"];
        self suicide();
    }

    self notify( "becameSpectator" );
    addtoteam( "spectator" );
    self.pers["class"] = undefined;
    self.class = undefined;
    thread maps\mp\gametypes\_playerlogic::spawnspectator();
}

waitforclassselect()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self._ID35590 = 1;

    for (;;)
    {
        if ( maps\mp\_utility::allowclasschoice() || maps\mp\_utility::showfakeloadout() && !isai( self ) )
            self waittill( "luinotifyserver",  var_0, var_1  );
        else
        {
            bypassclasschoice();
            break;
        }

        if ( var_0 != "class_select" )
            continue;

        if ( self.team == "spectator" )
            continue;

        if ( "" + var_1 != "callback" )
        {
            if ( isdefined( self.pers["isBot"] ) && self.pers["isBot"] )
            {
                self.pers["class"] = var_1;
                self.class = var_1;
            }
            else
            {
                var_1 += 1;
                self.pers["class"] = _ID14932( var_1 );
                self.class = _ID14932( var_1 );
            }

            self._ID35590 = 0;
        }
        else
        {
            self._ID35590 = 0;
            _ID20943( "callback" );
        }

        break;
    }
}

beginclasschoice( var_0 )
{
    var_1 = self.pers["team"];

    if ( maps\mp\_utility::allowclasschoice() || maps\mp\_utility::showfakeloadout() && !isai( self ) )
    {
        self setclientomnvar( "ui_options_menu", 2 );

        if ( !self ismlgspectator() )
            waitforclassselect();

        endrespawnnotify();

        if ( self.sessionstate == "spectator" )
        {
            if ( game["state"] == "postgame" )
                return;

            if ( game["state"] == "playing" && !maps\mp\_utility::_ID18658() )
            {
                if ( isdefined( self._ID35592 ) && self._ID35592 )
                    return;

                thread maps\mp\gametypes\_playerlogic::_ID30822();
            }

            thread maps\mp\gametypes\_spectating::_ID28880();
        }

        self.connecttime = gettime();
        self notify( "okToSpawn" );
    }
    else
        thread bypassclasschoice();

    if ( !isalive( self ) )
    {
        thread maps\mp\gametypes\_playerlogic::_ID24863( 0.1 );
        return;
    }
}

bypassclasschoice()
{
    self._ID28023 = 1;
    self._ID35590 = 0;

    if ( isdefined( level.bypassclasschoicefunc ) )
    {
        var_0 = self [[ level.bypassclasschoicefunc ]]();
        self.class = var_0;
        return;
    }

    self.class = "class0";
    return;
}

beginteamchoice()
{
    self setclientomnvar( "ui_options_menu", 1 );
}

showmainmenuforteam()
{
    var_0 = self.pers["team"];
    self openpopupmenu( game["menu_class_" + var_0] );
}

menuspectator()
{
    if ( isdefined( self.pers["team"] ) && self.pers["team"] == "spectator" )
        return;

    if ( isalive( self ) )
    {
        self._ID32285 = 1;
        self._ID18976 = "spectator";
        self._ID19789 = self.pers["team"];
        self suicide();
    }

    addtoteam( "spectator" );
    self.pers["class"] = undefined;
    self.class = undefined;
    thread maps\mp\gametypes\_playerlogic::spawnspectator();
}

_ID20943( var_0 )
{
    if ( var_0 == "demolitions_mp,0" && self getrankedplayerdata( "featureNew", "demolitions" ) )
        self setrankedplayerdata( "featureNew", "demolitions", 0 );

    if ( var_0 == "sniper_mp,0" && self getrankedplayerdata( "featureNew", "sniper" ) )
        self setrankedplayerdata( "featureNew", "sniper", 0 );

    var_1 = self.pers["team"];
    var_2 = maps\mp\gametypes\_class::_ID14932( var_0 );
    var_3 = maps\mp\gametypes\_class::getweaponchoice( var_0 );

    if ( var_2 == "restricted" )
    {
        beginclasschoice();
        return;
    }

    if ( isdefined( self.pers["class"] ) && self.pers["class"] == var_2 && ( isdefined( self.pers["primary"] ) && self.pers["primary"] == var_3 ) )
        return;

    if ( self.sessionstate == "playing" )
    {
        if ( isdefined( self.pers["lastClass"] ) && isdefined( self.pers["class"] ) )
        {
            self.pers["lastClass"] = self.pers["class"];
            self.lastclass = self.pers["lastClass"];
        }

        self.pers["class"] = var_2;
        self.class = var_2;
        self.pers["primary"] = var_3;

        if ( game["state"] == "postgame" )
            return;

        if ( level._ID17628 && !self.hasdonecombat )
        {
            maps\mp\gametypes\_class::_ID28675( self.pers["class"] );
            self.tag_stowed_back = undefined;
            self._ID32354 = undefined;
            maps\mp\gametypes\_class::giveloadout( self.pers["team"], self.pers["class"] );
        }
        else
            self iprintlnbold( game["strings"]["change_class"] );
    }
    else
    {
        if ( isdefined( self.pers["lastClass"] ) && isdefined( self.pers["class"] ) )
        {
            self.pers["lastClass"] = self.pers["class"];
            self.lastclass = self.pers["lastClass"];
        }

        self.pers["class"] = var_2;
        self.class = var_2;
        self.pers["primary"] = var_3;

        if ( game["state"] == "postgame" )
            return;

        if ( game["state"] == "playing" && !maps\mp\_utility::_ID18658() )
            thread maps\mp\gametypes\_playerlogic::_ID30822();
    }

    thread maps\mp\gametypes\_spectating::_ID28880();
}

update_wargame_after_migration()
{
    foreach ( var_1 in level.players )
    {
        if ( !isai( var_1 ) && var_1 ishost() )
            level.wargame_client = var_1;
    }
}

addtoteam( var_0, var_1, var_2 )
{
    if ( isdefined( self.team ) )
    {
        maps\mp\gametypes\_playerlogic::_ID26006();

        if ( isdefined( var_2 ) && var_2 )
            maps\mp\gametypes\_playerlogic::decrementalivecount( self.team );
    }

    self.pers["team"] = var_0;
    self.team = var_0;

    if ( getdvar( "squad_vs_squad" ) == "1" )
    {
        if ( !isai( self ) )
        {
            if ( var_0 == "allies" )
            {
                if ( !isdefined( level.squad_vs_squad_allies_client ) )
                    level.squad_vs_squad_allies_client = self;
            }
            else if ( var_0 == "axis" )
            {
                if ( !isdefined( level.squad_vs_squad_axis_client ) )
                    level.squad_vs_squad_axis_client = self;
            }
        }
    }

    if ( getdvar( "squad_match" ) == "1" )
    {
        if ( !isai( self ) && self ishost() )
        {
            if ( !isdefined( level.squad_match_client ) )
                level.squad_match_client = self;
        }
    }

    if ( getdvar( "squad_use_hosts_squad" ) == "1" )
    {
        if ( !isai( self ) && self ishost() )
        {
            if ( !isdefined( level.wargame_client ) )
                level.wargame_client = self;
        }
    }

    if ( !maps\mp\_utility::_ID20673() || isdefined( self.pers["isBot"] ) || !maps\mp\_utility::allowteamchoice() )
    {
        if ( level._ID32653 )
            self.sessionteam = var_0;
        else if ( var_0 == "spectator" )
            self.sessionteam = "spectator";
        else
            self.sessionteam = "none";
    }

    if ( game["state"] != "postgame" )
    {
        maps\mp\gametypes\_playerlogic::addtoteamcount();

        if ( isdefined( var_2 ) && var_2 )
            maps\mp\gametypes\_playerlogic::incrementalivecount( self.team );
    }

    maps\mp\_utility::updateobjectivetext();

    if ( isdefined( var_1 ) && var_1 )
        waittillframeend;

    maps\mp\_utility::_ID34559();

    if ( var_0 == "spectator" )
    {
        self notify( "joined_spectators" );
        level notify( "joined_team",  self  );
        return;
    }

    self notify( "joined_team" );
    level notify( "joined_team",  self  );
    return;
}

endrespawnnotify()
{
    self._ID35591 = 0;
    self notify( "end_respawn" );
}
