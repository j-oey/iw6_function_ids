// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID33083( var_0 )
{
    if ( !self.hasspawned )
        return 0;

    var_1 = gettime() + var_0 * 1000;
    var_2 = level._ID19669[self.pers["team"]];
    var_3 = level._ID36229[self.pers["team"]] * 1000;
    var_4 = ( var_1 - var_2 ) / var_3;
    var_5 = ceil( var_4 );
    var_6 = var_2 + var_5 * var_3;

    if ( isdefined( self.respawntimerstarttime ) )
    {
        var_7 = ( gettime() - self.respawntimerstarttime ) / 1000.0;

        if ( self.respawntimerstarttime < var_2 )
            return 0;
    }

    if ( isdefined( self._ID36233 ) )
        var_6 += 50 * self._ID36233;

    return ( var_6 - gettime() ) / 1000;
}

teamkilldelay()
{
    var_0 = self.pers["teamkills"];

    if ( level._ID20716 < 0 || var_0 <= level._ID20716 )
        return 0;

    var_1 = var_0 - level._ID20716;
    return maps\mp\gametypes\_tweakables::_ID15451( "team", "teamkillspawndelay" ) * var_1;
}

_ID33082( var_0 )
{
    if ( level._ID17628 && !self.hasspawned || level.gameended )
        return 0;

    var_1 = 0;

    if ( self.hasspawned )
    {
        var_2 = self [[ level.onrespawndelay ]]();

        if ( isdefined( var_2 ) )
            var_1 = var_2;
        else
            var_1 = getdvarint( "scr_" + level._ID14086 + "_playerrespawndelay" );

        if ( var_0 && isdefined( self.pers["teamKillPunish"] ) && self.pers["teamKillPunish"] )
            var_1 += teamkilldelay();

        if ( isdefined( self.respawntimerstarttime ) )
        {
            var_3 = ( gettime() - self.respawntimerstarttime ) / 1000.0;
            var_1 -= var_3;

            if ( var_1 < 0 )
                var_1 = 0;
        }

        if ( isdefined( self.setspawnpoint ) )
            var_1 += level._ID33086;
    }

    var_4 = getdvarint( "scr_" + level._ID14086 + "_waverespawndelay" ) > 0;

    if ( var_4 )
        return _ID33083( var_1 );

    return var_1;
}

_ID20776()
{
    if ( maps\mp\_utility::_ID15035() || isdefined( level._ID10173 ) )
    {
        if ( isdefined( level._ID10173 ) && level._ID10173 )
            return 0;

        if ( isdefined( self.pers["teamKillPunish"] ) && self.pers["teamKillPunish"] )
            return 0;

        if ( self.pers["lives"] <= 0 && maps\mp\_utility::_ID14070() )
            return 0;
        else if ( maps\mp\_utility::_ID14070() )
        {
            if ( !level._ID17628 && !self.hasspawned && ( isdefined( level.allowlatecomers ) && !level.allowlatecomers ) )
            {
                if ( isdefined( self.siegelatecomer ) && !self.siegelatecomer )
                    return 1;

                return 0;
            }
        }
    }

    return 1;
}

_ID30822()
{
    self endon( "becameSpectator" );

    if ( isdefined( self._ID35590 ) && self._ID35590 )
        self waittill( "okToSpawn" );

    if ( isdefined( self.addtoteam ) )
    {
        maps\mp\gametypes\_menus::addtoteam( self.addtoteam );
        self.addtoteam = undefined;
    }

    if ( !_ID20776() )
    {
        wait 0.05;
        var_0 = self.origin;
        var_1 = self.angles;
        self notify( "attempted_spawn" );
        var_2 = self.pers["teamKillPunish"];

        if ( isdefined( var_2 ) && var_2 )
        {
            self.pers["teamkills"] = max( self.pers["teamkills"] - 1, 0 );
            maps\mp\_utility::setlowermessage( "friendly_fire", &"MP_FRIENDLY_FIRE_WILL_NOT" );

            if ( !self.hasspawned && self.pers["teamkills"] <= level._ID20716 )
                self.pers["teamKillPunish"] = 0;
        }
        else if ( maps\mp\_utility::_ID18768() && !maps\mp\_utility::islastround() )
        {
            if ( isdefined( self._ID32355 ) && self._ID32355 )
                maps\mp\_utility::setlowermessage( "spawn_info", game["strings"]["spawn_tag_wait"] );
            else if ( level._ID14086 == "siege" )
                maps\mp\_utility::setlowermessage( "spawn_info", game["strings"]["spawn_flag_wait"] );
            else
                maps\mp\_utility::setlowermessage( "spawn_info", game["strings"]["spawn_next_round"] );

            thread _ID26032( 3.0 );
        }

        if ( self.sessionstate != "spectator" )
            var_0 += ( 0, 0, 60 );

        thread spawnspectator( var_0, var_1 );
        return;
    }

    if ( self._ID35591 )
        return;

    self._ID35591 = 1;
    _ID35536();

    if ( isdefined( self ) )
    {
        self._ID35591 = 0;
        return;
    }
}

_ID35536()
{
    self endon( "disconnect" );
    self endon( "end_respawn" );
    level endon( "game_ended" );
    self notify( "attempted_spawn" );
    var_0 = 0;
    var_1 = self.pers["teamKillPunish"];

    if ( isdefined( var_1 ) && var_1 )
    {
        var_2 = teamkilldelay();

        if ( var_2 > 0 )
        {
            maps\mp\_utility::setlowermessage( "friendly_fire", &"MP_FRIENDLY_FIRE_WILL_NOT", var_2, 1, 1 );
            thread respawn_asspectator( self.origin + ( 0, 0, 60 ), self.angles );
            var_0 = 1;
            wait(var_2);
            maps\mp\_utility::_ID7495( "friendly_fire" );
            self.respawntimerstarttime = gettime();
        }

        self.pers["teamKillPunish"] = 0;
    }
    else if ( !maps\mp\_utility::_ID18363() && teamkilldelay() )
        self.pers["teamkills"] = max( self.pers["teamkills"] - 1, 0 );

    if ( maps\mp\_utility::_ID18837() )
    {
        self._ID30887 = 1;
        self._ID9087 = self.origin;
        self waittill( "stopped_using_remote" );
    }

    if ( !isdefined( self._ID36233 ) && isdefined( level._ID36230[self.team] ) )
    {
        self._ID36233 = level._ID36230[self.team];
        level._ID36230[self.team]++;
    }

    var_3 = _ID33082( 0 );
    thread _ID24863( var_3 );

    if ( var_3 > 0 )
    {
        maps\mp\_utility::setlowermessage( "spawn_info", game["strings"]["waiting_to_spawn"], var_3, 1, 1 );

        if ( !var_0 )
            thread respawn_asspectator( self.origin + ( 0, 0, 60 ), self.angles );

        var_0 = 1;
        maps\mp\_utility::waitfortimeornotify( var_3, "force_spawn" );
        self notify( "stop_wait_safe_spawn_button" );
    }

    if ( _ID21905() )
    {
        maps\mp\_utility::setlowermessage( "spawn_info", game["strings"]["press_to_spawn"], undefined, undefined, undefined, undefined, undefined, undefined, 1 );

        if ( !var_0 )
            thread respawn_asspectator( self.origin + ( 0, 0, 60 ), self.angles );

        var_0 = 1;
        _ID35601();
    }

    self._ID35591 = 0;
    maps\mp\_utility::_ID7495( "spawn_info" );
    self._ID36233 = undefined;
    thread spawnplayer();
}

_ID21905()
{
    if ( maps\mp\gametypes\_tweakables::_ID15451( "player", "forcerespawn" ) != 0 )
        return 0;

    if ( !self.hasspawned )
        return 0;

    var_0 = getdvarint( "scr_" + level._ID14086 + "_waverespawndelay" ) > 0;

    if ( var_0 )
        return 0;

    if ( self._ID35841 )
        return 0;

    return 1;
}

_ID35601()
{
    self endon( "disconnect" );
    self endon( "end_respawn" );

    for (;;)
    {
        if ( self usebuttonpressed() )
            break;

        wait 0.05;
    }
}

_ID26032( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    waittillframeend;
    self endon( "end_respawn" );
    wait(var_0);
    maps\mp\_utility::_ID7495( "spawn_info" );
}

laststandrespawnplayer()
{
    self laststandrevive();

    if ( maps\mp\_utility::_hasperk( "specialty_finalstand" ) && !level.diehardmode )
        maps\mp\_utility::_unsetperk( "specialty_finalstand" );

    if ( level.diehardmode )
        self.headicon = "";

    self setstance( "crouch" );
    self._ID26264 = 1;
    self notify( "revive" );

    if ( isdefined( self._ID31177 ) )
        self.maxhealth = self._ID31177;

    self.health = self.maxhealth;
    common_scripts\utility::_enableusability();

    if ( game["state"] == "postgame" )
    {
        maps\mp\gametypes\_gamelogic::_ID13583();
        return;
    }
}

_ID14967()
{
    var_0 = spawn( "script_origin", self.origin );
    var_0 hide();
    var_0.angles = self.angles;
    return var_0;
}

showspawnnotifies()
{
    if ( isdefined( game["defcon"] ) )
        thread maps\mp\gametypes\_hud_message::defconsplashnotify( game["defcon"], 0 );

    if ( !maps\mp\_utility::_ID18363() && maps\mp\_utility::_ID18763() )
    {
        thread maps\mp\gametypes\_hud_message::_ID31052( "rested" );
        return;
    }
}

_ID24863( var_0 )
{
    if ( !0 )
        return;

    self endon( "disconnect" );
    self endon( "spawned" );
    self endon( "used_predicted_spawnpoint" );
    self notify( "predicting_about_to_spawn_player" );
    self endon( "predicting_about_to_spawn_player" );

    if ( var_0 <= 0 )
        return;

    if ( var_0 > 1.0 )
        wait(var_0 - 1.0);

    _ID24862();
    self predictstreampos( self.predictedspawnpoint.origin + ( 0, 0, 60 ), self.predictedspawnpoint.angles );
    self._ID24865 = gettime();

    for ( var_1 = 0; var_1 < 30; var_1++ )
    {
        wait 0.4;
        var_2 = self.predictedspawnpoint;
        _ID24862();

        if ( self.predictedspawnpoint != var_2 )
        {
            self predictstreampos( self.predictedspawnpoint.origin + ( 0, 0, 60 ), self.predictedspawnpoint.angles );
            self._ID24865 = gettime();
        }
    }
}

_ID24862()
{
    if ( _ID33082( 1 ) > 1.0 )
    {
        self.predictedspawnpoint = getspectatepoint();
        return;
    }

    if ( isdefined( self.setspawnpoint ) )
    {
        self.predictedspawnpoint = self.setspawnpoint;
        return;
    }

    var_0 = self [[ level.getspawnpoint ]]();
    self.predictedspawnpoint = var_0;
}

checkpredictedspawnpointcorrectness( var_0 )
{
    self notify( "used_predicted_spawnpoint" );
    self.predictedspawnpoint = undefined;
}

_ID23417( var_0, var_1 )
{
    return var_0 + " (" + int( var_0 / var_1 * 100 ) + "%)";
}

_ID25006()
{

}

_ID15340( var_0 )
{
    if ( !positionwouldtelefrag( var_0.origin ) )
        return var_0.origin;

    if ( !isdefined( var_0.alternates ) )
        return var_0.origin;

    foreach ( var_2 in var_0.alternates )
    {
        if ( !positionwouldtelefrag( var_2 ) )
            return var_2;
    }

    return var_0.origin;
}

_ID33093()
{
    if ( !isdefined( self.setspawnpoint ) )
        return 0;

    var_0 = getentarray( "care_package", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( distance( var_2.origin, self.setspawnpoint._ID24539 ) > 64 )
            continue;

        if ( isdefined( var_2.owner ) )
            maps\mp\gametypes\_hud_message::_ID24474( "destroyed_insertion", var_2.owner );

        maps\mp\perks\_perkfunctions::deleteti( self.setspawnpoint );
        return 0;
    }

    if ( !bullettracepassed( self.setspawnpoint.origin + ( 0, 0, 60 ), self.setspawnpoint.origin, 0, self.setspawnpoint ) )
        return 0;

    var_4 = self.setspawnpoint.origin + ( 0, 0, 1 );
    var_5 = playerphysicstrace( var_4, self.setspawnpoint.origin + ( 0, 0, -16 ) );

    if ( var_4[2] == var_5[2] )
        return 0;

    return 1;
}

_ID30888()
{
    self notify( "spawningClientThisFrameReset" );
    self endon( "spawningClientThisFrameReset" );
    wait 0.05;
    level._ID22416--;
}

spawnplayer( var_0 )
{
    self endon( "disconnect" );
    self endon( "joined_spectators" );
    self notify( "spawned" );
    self notify( "end_respawn" );
    self notify( "started_spawnPlayer" );

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    var_1 = undefined;
    self._ID32973 = 0;
    self setclientomnvar( "ui_options_menu", 0 );
    self setclientomnvar( "ui_hud_shake", 0 );
    self.lastkillsplash = undefined;

    if ( !level._ID17628 && !self.hasdonecombat )
    {
        level._ID22416++;

        if ( level._ID22416 > 1 )
        {
            self._ID35592 = 1;
            wait(0.05 * ( level._ID22416 - 1 ));
        }

        thread _ID30888();
        self._ID35592 = 0;
    }

    if ( !self hasloadedcustomizationplayerview( self ) )
    {
        var_2 = gettime() + 5000;
        self._ID35592 = 1;
        wait 0.1;

        while ( !self hasloadedcustomizationplayerview( self ) )
        {
            wait 0.1;

            if ( gettime() > var_2 )
                break;
        }

        self._ID35592 = 0;
    }

    if ( isdefined( self._ID13535 ) )
    {
        var_3 = self._ID13535;
        self._ID13535 = undefined;

        if ( isdefined( self.forcespawnangles ) )
        {
            var_4 = self.forcespawnangles;
            self.forcespawnangles = undefined;
        }
        else
            var_4 = ( 0, randomfloatrange( 0, 360 ), 0 );
    }
    else if ( isdefined( self.setspawnpoint ) && ( isdefined( self.setspawnpoint._ID22328 ) || _ID33093() ) )
    {
        var_1 = self.setspawnpoint;

        if ( !isdefined( self.setspawnpoint._ID22328 ) )
        {
            self._ID32973 = 1;
            self playlocalsound( "tactical_spawn" );

            if ( level.multiteambased )
            {
                foreach ( var_6 in level._ID32668 )
                {
                    if ( var_6 != self.team )
                        self playsoundtoteam( "tactical_spawn", var_6 );
                }
            }
            else if ( level._ID32653 )
                self playsoundtoteam( "tactical_spawn", level._ID23070[self.team] );
            else
                self playsound( "tactical_spawn" );
        }

        foreach ( var_9 in level._ID34171 )
        {
            if ( distancesquared( var_9.origin, var_1._ID24539 ) < 1024 )
                var_9 notify( "damage",  5000, var_9.owner, ( 0, 0, 0 ), ( 0, 0, 0 ), "MOD_EXPLOSIVE", "", "", "", undefined, "killstreak_emp_mp"  );
        }

        var_3 = self.setspawnpoint._ID24539;
        var_4 = self.setspawnpoint.angles;

        if ( isdefined( self.setspawnpoint.enemytrigger ) )
            self.setspawnpoint.enemytrigger delete();

        self.setspawnpoint delete();
        var_1 = undefined;
    }
    else if ( isdefined( self._ID18790 ) && isdefined( self.battlebuddy ) )
    {
        var_3 = undefined;
        var_4 = undefined;
        var_11 = maps\mp\gametypes\_battlebuddy::_ID7062();

        if ( var_11._ID31530 == 0 )
        {
            var_3 = var_11.origin;
            var_4 = var_11.angles;
        }
        else
        {
            var_1 = self [[ level.getspawnpoint ]]();
            var_3 = var_1.origin;
            var_4 = var_1.angles;
        }

        maps\mp\gametypes\_battlebuddy::_ID7402();
        self setclientomnvar( "cam_scene_name", "battle_spawn" );
        self setclientomnvar( "cam_scene_lead", self.battlebuddy getentitynumber() );
        self setclientomnvar( "cam_scene_support", self getentitynumber() );
    }
    else if ( isdefined( self.helispawning ) && ( !isdefined( self._ID13166 ) || isdefined( self._ID13166 ) && self._ID13166 ) && level._ID24880 > 0 && self.team == "allies" )
    {
        while ( !isdefined( level.allieschopper ) )
            wait 0.1;

        var_3 = level.allieschopper.origin;
        var_4 = level.allieschopper.angles;
        self._ID13166 = 0;
    }
    else if ( isdefined( self.helispawning ) && ( !isdefined( self._ID13166 ) || isdefined( self._ID13166 ) && self._ID13166 ) && level._ID24880 > 0 && self.team == "axis" )
    {
        while ( !isdefined( level.axischopper ) )
            wait 0.1;

        var_3 = level.axischopper.origin;
        var_4 = level.axischopper.angles;
        self._ID13166 = 0;
    }
    else
    {
        var_1 = self [[ level.getspawnpoint ]]();
        var_3 = var_1.origin;
        var_4 = var_1.angles;
    }

    _ID28877();
    var_12 = self.hasspawned;
    self.fauxdead = undefined;

    if ( !var_0 )
    {
        self._ID19246 = [];
        self.killsthislifeperweapon = [];
        maps\mp\_utility::_ID34608( "playing" );
        maps\mp\_utility::clearkillcamstate();
        self._ID6560 = undefined;
        self.maxhealth = maps\mp\gametypes\_tweakables::_ID15451( "player", "maxhealth" );
        self.health = self.maxhealth;
        self._ID13681 = undefined;
        self.hasspawned = 1;
        self._ID30916 = gettime();
        self._ID35917 = !isdefined( var_1 );
        self.afk = 0;
        self._ID8965 = [];
        self._ID19266 = 1;
        self._ID36475 = 1;
        self.objectivescaler = 1;
        self.clampedhealth = undefined;
        self._ID29698 = 0;
        self._ID29697 = 0;
        self._ID25599 = 0;
    }

    self._ID21667 = 1;
    self._ID18011 = 0;
    self.laststand = undefined;
    self._ID17611 = undefined;
    self.inc4death = undefined;
    self.disabledweapon = 0;
    self._ID10155 = 0;
    self.disabledoffhandweapons = 0;
    common_scripts\utility::_ID26147();

    if ( !var_0 )
    {
        self.avoidkillstreakonspawntimer = 5.0;

        if ( !maps\mp\_utility::_ID18363() )
        {
            var_13 = self.pers["lives"];

            if ( var_13 == maps\mp\_utility::_ID15035() )
                addtolivescount();

            if ( var_13 )
                self.pers["lives"]--;
        }

        _ID2446();

        if ( !var_12 || maps\mp\_utility::_ID14070() || maps\mp\_utility::_ID14070() && level._ID17628 && self.hasdonecombat )
            _ID26001();

        if ( !self._ID35903 )
        {
            var_14 = 20;

            if ( maps\mp\_utility::_ID15434() > 0 && var_14 < maps\mp\_utility::_ID15434() * 60 / 4 )
                var_14 = maps\mp\_utility::_ID15434() * 60 / 4;

            if ( level._ID17628 || maps\mp\_utility::_ID15435() < var_14 * 1000 )
                self._ID35903 = 1;
        }
    }

    self setdepthoffield( 0, 0, 512, 512, 4, 0 );

    if ( level.console )
        self setclientdvar( "cg_fov", "65" );

    _ID26145();

    if ( isdefined( var_1 ) )
    {
        maps\mp\gametypes\_spawnlogic::_ID12871( var_1 );
        var_3 = _ID15340( var_1 );
        var_4 = var_1.angles;
    }
    else if ( !isdefined( self.faux_spawn_infected ) )
        self.lastspawntime = gettime();

    self.spawnpos = var_3;
    self spawn( var_3, var_4 );

    if ( var_0 && isdefined( self.faux_spawn_stance ) )
    {
        self setstance( self.faux_spawn_stance );
        self.faux_spawn_stance = undefined;
    }

    if ( isai( self ) )
        maps\mp\_utility::_ID13582( 1 );

    [[ level._ID22902 ]]();

    if ( isdefined( var_1 ) )
        checkpredictedspawnpointcorrectness( var_1.origin );

    if ( !var_0 )
    {
        maps\mp\gametypes\_missions::_ID24537();

        if ( isai( self ) && isdefined( level.bot_funcs ) && isdefined( level.bot_funcs["player_spawned"] ) )
            self [[ level.bot_funcs["player_spawned"] ]]();

        if ( !isai( self ) )
            thread _ID36078();
    }

    maps\mp\gametypes\_class::_ID28675( self.class );

    if ( isdefined( level.custom_giveloadout ) )
        self [[ level.custom_giveloadout ]]( var_0 );
    else
        maps\mp\gametypes\_class::giveloadout( self.team, self.class );

    if ( isdefined( game["roundsPlayed"] ) && game["roundsPlayed"] > 0 )
    {
        if ( !isdefined( self.classrefreshed ) || !self.classrefreshed )
        {
            if ( isdefined( self.class_num ) )
            {
                self setclientomnvar( "ui_loadout_selected", self.class_num );
                self.classrefreshed = 1;
            }
        }
    }

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::_ID28902( 1 );

    if ( !maps\mp\_utility::_ID14065( "prematch_done" ) )
        maps\mp\_utility::_ID13582( 1 );
    else
        maps\mp\_utility::_ID13582( 0 );

    if ( !maps\mp\_utility::_ID14065( "prematch_done" ) || !var_12 && game["state"] == "playing" )
    {
        if ( !maps\mp\_utility::_ID18363() )
        {
            if ( game["status"] == "overtime" )
                thread maps\mp\gametypes\_hud_message::_ID22731( game["strings"]["overtime"], game["strings"]["overtime_hint"], undefined, ( 1, 0, 0 ), "mp_last_stand" );
        }

        thread showspawnnotifies();
    }

    if ( maps\mp\_utility::_ID15069( "scr_showperksonspawn", 1 ) == 1 && game["state"] != "postgame" )
    {
        if ( !maps\mp\_utility::_ID18363() )
            self setclientomnvar( "ui_spawn_abilities_show", 1 );
    }

    waittillframeend;
    self._ID30887 = undefined;
    self notify( "spawned_player" );
    level notify( "player_spawned",  self  );

    if ( game["state"] == "postgame" )
    {
        maps\mp\gametypes\_gamelogic::_ID13583();
        return;
    }
}

spawnspectator( var_0, var_1 )
{
    self notify( "spawned" );
    self notify( "end_respawn" );
    self notify( "joined_spectators" );
    in_spawnspectator( var_0, var_1 );
}

respawn_asspectator( var_0, var_1 )
{
    in_spawnspectator( var_0, var_1 );
}

in_spawnspectator( var_0, var_1 )
{
    _ID28877();
    var_2 = self.pers["team"];

    if ( isdefined( var_2 ) && var_2 == "spectator" && !level.gameended )
        maps\mp\_utility::_ID7495( "spawn_info" );

    maps\mp\_utility::_ID34608( "spectator" );
    maps\mp\_utility::clearkillcamstate();
    self._ID13681 = undefined;
    _ID26146();

    if ( isdefined( var_2 ) && var_2 == "spectator" )
        self.statusicon = "";
    else
        self.statusicon = "hud_status_dead";

    maps\mp\gametypes\_spectating::_ID28880();
    _ID22903( var_0, var_1 );

    if ( level._ID32653 && !level.splitscreen && !self issplitscreenplayer() )
    {
        self setdepthoffield( 0, 128, 512, 4000, 6, 1.8 );
        return;
    }
}

_ID15255( var_0 )
{
    if ( var_0 < 0 )
        return undefined;

    for ( var_1 = 0; var_1 < level.players.size; var_1++ )
    {
        if ( level.players[var_1] getentitynumber() == var_0 )
            return level.players[var_1];
    }

    return undefined;
}

_ID22903( var_0, var_1 )
{
    if ( isdefined( var_0 ) && isdefined( var_1 ) )
    {
        self setspectatedefaults( var_0, var_1 );
        self spawn( var_0, var_1 );
        checkpredictedspawnpointcorrectness( var_0 );
        return;
    }

    var_2 = getspectatepoint();

    if ( !maps\mp\_utility::_ID18363() )
    {
        var_3 = getentarray( "mp_mlg_camera", "classname" );

        if ( isdefined( var_3 ) && var_3.size )
        {
            for ( var_4 = 0; var_4 < var_3.size && var_4 < 4; var_4++ )
            {
                self setmlgcameradefaults( var_4, var_3[var_4].origin, var_3[var_4].angles );
                level._ID36936[var_4].origin = var_3[var_4].origin;
                level._ID36936[var_4].angles = var_3[var_4].angles;
            }
        }
        else if ( isdefined( level.camera3pos ) )
        {
            var_5 = tolower( getdvar( "mapname" ) );

            if ( var_5 == "mp_strikezone" && isdefined( level.teleport_zone_current ) && level.teleport_zone_current != "start" )
            {
                self setmlgcameradefaults( 0, level.camera5pos, level.camera5ang );
                level._ID36936[0].origin = level.camera5pos;
                level._ID36936[0].angles = level.camera5ang;
                self setmlgcameradefaults( 1, level.camera6pos, level.camera6ang );
                level._ID36936[1].origin = level.camera6pos;
                level._ID36936[1].angles = level.camera6ang;
                self setmlgcameradefaults( 2, level.camera7pos, level.camera7ang );
                level._ID36936[2].origin = level.camera7pos;
                level._ID36936[2].angles = level.camera7ang;
                self setmlgcameradefaults( 3, level.camera8pos, level.camera8ang );
                level._ID36936[3].origin = level.camera8pos;
                level._ID36936[3].angles = level.camera8ang;
            }
            else
            {
                self setmlgcameradefaults( 0, level.camera1pos, level.camera1ang );
                level._ID36936[0].origin = level.camera1pos;
                level._ID36936[0].angles = level.camera1ang;
                self setmlgcameradefaults( 1, level.camera2pos, level.camera2ang );
                level._ID36936[1].origin = level.camera2pos;
                level._ID36936[1].angles = level.camera2ang;
                self setmlgcameradefaults( 2, level.camera3pos, level.camera3ang );
                level._ID36936[2].origin = level.camera3pos;
                level._ID36936[2].angles = level.camera3ang;
                self setmlgcameradefaults( 3, level.camera4pos, level.camera4ang );
                level._ID36936[3].origin = level.camera4pos;
                level._ID36936[3].angles = level.camera4ang;
            }
        }
        else
        {
            for ( var_4 = 0; var_4 < 4; var_4++ )
                self setmlgcameradefaults( var_4, var_2.origin, var_2.angles );
        }
    }

    self setspectatedefaults( var_2.origin, var_2.angles );
    self spawn( var_2.origin, var_2.angles );
    checkpredictedspawnpointcorrectness( var_2.origin );
}

getspectatepoint()
{
    var_0 = getentarray( "mp_global_intermission", "classname" );
    var_1 = maps\mp\gametypes\_spawnlogic::_ID15346( var_0 );
    return var_1;
}

_ID30890()
{
    self endon( "disconnect" );
    self notify( "spawned" );
    self notify( "end_respawn" );
    _ID28877();
    maps\mp\_utility::_ID7496();
    maps\mp\_utility::_ID13582( 1 );
    self setclientdvar( "cg_everyoneHearsEveryone", 1 );
    var_0 = self.pers["postGameChallenges"];

    if ( !maps\mp\_utility::_ID18363() && level._ID25418 && ( self._ID24790 || isdefined( var_0 ) && var_0 ) )
    {
        if ( self._ID24790 )
            self playlocalsound( "mp_level_up" );
        else if ( isdefined( var_0 ) )
            self playlocalsound( "mp_challenge_complete" );

        if ( self._ID24790 > level._ID24789 )
            level._ID24789 = 1;

        if ( isdefined( var_0 ) && var_0 > level._ID24789 )
            level._ID24789 = var_0;

        var_1 = 7.0;

        if ( isdefined( var_0 ) )
            var_1 = 4.0 + min( var_0, 3 );

        while ( var_1 )
        {
            wait 0.25;
            var_1 -= 0.25;
        }
    }

    if ( isdefined( level.finalkillcam_winner ) && level.finalkillcam_winner != "none" && isdefined( level.match_end_delay ) && maps\mp\_utility::_ID35913() )
        wait(level.match_end_delay);

    maps\mp\_utility::_ID34608( "intermission" );
    maps\mp\_utility::clearkillcamstate();
    self._ID13681 = undefined;
    var_2 = getentarray( "mp_global_intermission", "classname" );
    var_2 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns( var_2 );
    var_3 = var_2[0];

    if ( !isdefined( level.custom_ending ) )
    {
        self spawn( var_3.origin, var_3.angles );
        checkpredictedspawnpointcorrectness( var_3.origin );
        self setdepthoffield( 0, 128, 512, 4000, 6, 1.8 );
        return;
    }

    level notify( "scoreboard_displaying" );
    return;
}

spawnendofgame()
{
    if ( 1 )
    {
        if ( isdefined( level.custom_ending ) && maps\mp\_utility::_ID35913() )
            level notify( "start_custom_ending" );

        maps\mp\_utility::_ID13582( 1 );
        spawnspectator();
        maps\mp\_utility::_ID13582( 1 );
        return;
    }

    self notify( "spawned" );
    self notify( "end_respawn" );
    _ID28877();
    maps\mp\_utility::_ID7496();
    self setclientdvar( "cg_everyoneHearsEveryone", 1 );
    maps\mp\_utility::_ID34608( "dead" );
    maps\mp\_utility::clearkillcamstate();
    self._ID13681 = undefined;
    var_0 = getspectatepoint();
    spawnspectator( var_0.origin, var_0.angles );
    checkpredictedspawnpointcorrectness( var_0.origin );
    maps\mp\_utility::_ID13582( 1 );
    self setdepthoffield( 0, 0, 512, 512, 4, 0 );
}

_ID28877()
{
    self stopshellshock();
    self stoprumble( "damage_heavy" );
    self._ID9087 = undefined;
}

_ID22304()
{
    waittillframeend;

    if ( isdefined( self ) )
    {
        level notify( "connecting",  self  );
        return;
    }
}

_ID6474( var_0 )
{
    if ( !isdefined( self._ID7864 ) )
        return;

    var_1 = getmatchdata( "gameLength" );
    var_1 += int( maps\mp\_utility::_ID15332() );
    setmatchdata( "players", self.clientid, "disconnectTime", var_1 );
    setmatchdata( "players", self.clientid, "disconnectReason", var_0 );

    if ( maps\mp\_utility::_ID25420() && !maps\mp\_utility::_ID18363() )
        maps\mp\_matchdata::logfinalstats();

    if ( isdefined( self.pers["confirmed"] ) )
        maps\mp\_matchdata::logkillsconfirmed();

    if ( isdefined( self.pers["denied"] ) )
        maps\mp\_matchdata::_ID20252();

    _ID26026();
    maps\mp\gametypes\_spawnlogic::_ID26002();
    maps\mp\gametypes\_spawnlogic::_ID25996();
    var_2 = self getentitynumber();

    if ( !level._ID32653 )
        game["roundsWon"][self._ID15851] = undefined;

    if ( level.splitscreen )
    {
        var_3 = level.players;

        if ( var_3.size <= 1 )
            level thread maps\mp\gametypes\_gamelogic::_ID13521();
    }

    if ( isdefined( self.score ) && isdefined( self.pers["team"] ) )
    {
        var_4 = self.score;

        if ( maps\mp\_utility::_ID15150() )
            var_4 = self.score / maps\mp\_utility::_ID15150();

        setplayerteamrank( self, self.clientid, int( var_4 ) );
    }

    var_5 = self getentitynumber();
    var_6 = self._ID15851;
    logprint( "Q;" + var_6 + ";" + var_5 + ";" + self.name + "\n" );
    thread maps\mp\_events::_ID10186();

    if ( level.gameended )
        maps\mp\gametypes\_gamescore::_ID25991();

    if ( isdefined( self.team ) )
        _ID26006();

    if ( self.sessionstate == "playing" && !( isdefined( self.fauxdead ) && self.fauxdead ) )
    {
        _ID25993( 1 );
        return;
    }

    if ( self.sessionstate == "spectator" || self.sessionstate == "dead" )
    {
        level thread maps\mp\gametypes\_gamelogic::_ID34542();
        return;
    }

    return;
}

_ID26026()
{
    var_0 = 0;

    for ( var_1 = 0; var_1 < level.players.size; var_1++ )
    {
        if ( level.players[var_1] == self )
        {
            for ( var_0 = 1; var_1 < level.players.size - 1; var_1++ )
                level.players[var_1] = level.players[var_1 + 1];

            level.players[var_1] = undefined;
            break;
        }
    }
}

_ID17914()
{
    if ( level.splitscreen || self issplitscreenplayer() )
    {
        self setclientdvars( "cg_hudGrenadeIconHeight", "37.5", "cg_hudGrenadeIconWidth", "37.5", "cg_hudGrenadeIconOffset", "75", "cg_hudGrenadePointerHeight", "18", "cg_hudGrenadePointerWidth", "37.5", "cg_hudGrenadePointerPivot", "18 40.5", "cg_fovscale", "0.75" );
        setdvar( "r_materialBloomHQScriptMasterEnable", 0 );
        return;
    }

    self setclientdvars( "cg_hudGrenadeIconHeight", "25", "cg_hudGrenadeIconWidth", "25", "cg_hudGrenadeIconOffset", "50", "cg_hudGrenadePointerHeight", "12", "cg_hudGrenadePointerWidth", "25", "cg_hudGrenadePointerPivot", "12 27", "cg_fovscale", "1" );
    return;
}

_ID17913()
{
    setdvar( "cg_drawTalk", 1 );
    setdvar( "cg_drawCrosshair", 1 );
    setdvar( "cg_drawCrosshairNames", 1 );
    setdvar( "cg_hudGrenadeIconMaxRangeFrag", 250 );

    if ( level.hardcoremode )
    {
        setdvar( "cg_drawTalk", 3 );
        setdvar( "cg_drawCrosshair", 0 );
        setdvar( "cg_drawCrosshairNames", 1 );
        setdvar( "cg_hudGrenadeIconMaxRangeFrag", 0 );
    }

    if ( isdefined( level.alwaysdrawfriendlynames ) && level.alwaysdrawfriendlynames )
        setdvar( "cg_drawFriendlyNamesAlways", 1 );
    else
        setdvar( "cg_drawFriendlyNamesAlways", 0 );

    self setclientdvars( "cg_drawSpectatorMessages", 1, "cg_scoreboardPingGraph", 1 );
    _ID17914();

    if ( maps\mp\_utility::_ID15035() )
        self setclientdvars( "cg_deadChatWithDead", 1, "cg_deadChatWithTeam", 0, "cg_deadHearTeamLiving", 0, "cg_deadHearAllLiving", 0 );
    else
        self setclientdvars( "cg_deadChatWithDead", 0, "cg_deadChatWithTeam", 1, "cg_deadHearTeamLiving", 1, "cg_deadHearAllLiving", 0 );

    if ( level._ID32653 )
        self setclientdvars( "cg_everyonehearseveryone", 0 );

    self setclientdvar( "ui_altscene", 0 );

    if ( getdvarint( "scr_hitloc_debug" ) )
    {
        for ( var_0 = 0; var_0 < 6; var_0++ )
            self setclientdvar( "ui_hitloc_" + var_0, "" );

        self._ID17017 = 1;
        return;
    }
}

_ID15134()
{
    var_0 = 0;

    for ( var_1 = 0; var_1 < 30; var_1++ )
    {
        foreach ( var_3 in level.players )
        {
            if ( !isdefined( var_3 ) )
                continue;

            if ( var_3.clientid == var_1 )
            {
                var_0 = 1;
                break;
            }

            var_0 = 0;
        }

        if ( !var_0 )
            return var_1;
    }
}

_ID29192()
{
    self._ID27299 = [];

    for ( var_0 = 1; var_0 <= 4; var_0++ )
    {
        self._ID27299[var_0] = spawnstruct();
        self._ID27299[var_0].type = "";
        self._ID27299[var_0].item = undefined;
    }

    if ( !level.console )
    {
        for ( var_0 = 5; var_0 <= 8; var_0++ )
        {
            self._ID27299[var_0] = spawnstruct();
            self._ID27299[var_0].type = "";
            self._ID27299[var_0].item = undefined;
        }

        return;
    }
}

callback_playerconnect()
{
    thread _ID22304();
    self.statusicon = "hud_status_connecting";
    self waittill( "begin" );
    self.statusicon = "";
    self.connecttime = undefined;
    level notify( "connected",  self  );
    self._ID7864 = 1;

    if ( self ishost() )
        level.player = self;

    if ( !level.splitscreen && !isdefined( self.pers["score"] ) )
        iprintln( &"MP_CONNECTED", self );

    self._ID34803 = self isusingonlinedataoffline();
    _ID17913();

    if ( !maps\mp\_utility::_ID18363() )
        initplayerstats();

    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
        level waittill( "eternity" );

    self._ID15851 = maps\mp\_utility::getuniqueid();
    var_0 = 0;

    if ( !isdefined( self.pers["clientid"] ) )
    {
        if ( game["clientid"] >= 30 )
            self.pers["clientid"] = _ID15134();
        else
            self.pers["clientid"] = game["clientid"];

        if ( game["clientid"] < 30 )
            game["clientid"]++;

        var_0 = 1;
    }

    if ( var_0 )
        maps\mp\killstreaks\_killstreaks::_ID26116();

    self.clientid = self.pers["clientid"];
    self.pers["teamKillPunish"] = 0;
    logprint( "J;" + self._ID15851 + ";" + self getentitynumber() + ";" + self.name + "\n" );

    if ( game["clientid"] <= 30 && game["clientid"] != getmatchdata( "playerCount" ) )
    {
        var_1 = 0;
        var_2 = 0;

        if ( !isai( self ) && maps\mp\_utility::_ID20673() )
            self registerparty( self.clientid );

        setmatchdata( "playerCount", game["clientid"] );
        setmatchdata( "players", self.clientid, "playerID", "xuid", self getxuid() );
        setmatchdata( "players", self.clientid, "playerID", "ucdIDHigh", self getucdidhigh() );
        setmatchdata( "players", self.clientid, "playerID", "ucdIDLow", self getucdidlow() );
        setmatchdata( "players", self.clientid, "playerID", "clanIDHigh", self getclanidhigh() );
        setmatchdata( "players", self.clientid, "playerID", "clanIDLow", self getclanidlow() );
        setmatchdata( "players", self.clientid, "gamertag", self.name );
        var_2 = self getcommonplayerdata( "connectionIDChunkLow", 0 );
        var_1 = self getcommonplayerdata( "connectionIDChunkHigh", 0 );
        setmatchdata( "players", self.clientid, "connectionIDChunkLow", var_2 );
        setmatchdata( "players", self.clientid, "connectionIDChunkHigh", var_1 );
        setmatchclientip( self, self.clientid );
        var_3 = getmatchdata( "gameLength" );
        var_3 += int( maps\mp\_utility::_ID15332() );
        setmatchdata( "players", self.clientid, "joinType", self getjointype() );
        setmatchdata( "players", self.clientid, "connectTime", var_3 );

        if ( maps\mp\_utility::_ID25420() && !maps\mp\_utility::_ID18363() )
            maps\mp\_matchdata::loginitialstats();

        if ( isdefined( self.pers["isBot"] ) && self.pers["isBot"] || isai( self ) )
            var_4 = 1;
        else
            var_4 = 0;

        if ( maps\mp\_utility::_ID20673() && maps\mp\_utility::allowteamchoice() && !var_4 )
            setmatchdata( "players", self.clientid, "team", self.sessionteam );
    }

    if ( !level._ID32653 )
        game["roundsWon"][self._ID15851] = 0;

    self._ID19768 = [];
    self._ID19764 = [];
    self._ID19761 = "";
    self.leaderdialoggroups = [];
    self.leaderdialoggroup = "";

    if ( !isdefined( self.pers["cur_kill_streak"] ) )
        self.pers["cur_kill_streak"] = 0;

    if ( !isdefined( self.pers["cur_death_streak"] ) )
        self.pers["cur_death_streak"] = 0;

    if ( !isdefined( self.pers["assistsToKill"] ) )
        self.pers["assistsToKill"] = 0;

    if ( !isdefined( self.pers["cur_kill_streak_for_nuke"] ) )
        self.pers["cur_kill_streak_for_nuke"] = 0;

    if ( !isdefined( self.pers["objectivePointStreak"] ) )
        self.pers["objectivePointStreak"] = 0;

    if ( maps\mp\_utility::_ID25420() && !maps\mp\_utility::_ID18363() )
        self.kill_streak = maps\mp\gametypes\_persistence::_ID31510( "killStreak" );

    self._ID19559 = -1;
    self._ID32664 = 0;
    self.hasspawned = 0;
    self._ID35591 = 0;
    self._ID35841 = 0;
    self._ID35903 = 0;
    self._ID21667 = 1;
    self._ID19266 = 1;
    self._ID36475 = 1;
    self.objectivescaler = 1;
    self._ID18785 = 0;

    if ( !maps\mp\_utility::_ID18363() )
        _ID28853();

    _ID29192();
    thread maps\mp\_flashgrenades::_ID21388();
    _ID26143();
    waittillframeend;
    level.players[level.players.size] = self;
    maps\mp\gametypes\_spawnlogic::addtoparticipantsarray();
    maps\mp\gametypes\_spawnlogic::addtocharactersarray();

    if ( level._ID32653 )
        self updatescores();

    if ( game["state"] == "postgame" )
    {
        self.connectedpostgame = 1;
        self setclientdvars( "cg_drawSpectatorMessages", 0 );
        _ID30890();
        return;
    }

    if ( isai( self ) && isdefined( level.bot_funcs ) && isdefined( level.bot_funcs["think"] ) )
        self thread [[ level.bot_funcs["think"] ]]();

    level endon( "game_ended" );

    if ( isdefined( level.hostmigrationtimer ) )
        thread maps\mp\gametypes\_hostmigration::_ID17099();

    if ( isdefined( level._ID22878 ) )
        [[ level._ID22878 ]]();

    if ( maps\mp\_utility::bot_is_fireteam_mode() && !isai( self ) )
    {
        thread spawnspectator();
        self setclientomnvar( "ui_options_menu", 0 );
        return;
    }

    if ( !isdefined( self.pers["team"] ) )
    {
        if ( maps\mp\_utility::_ID20673() && self.sessionteam != "none" )
        {
            thread spawnspectator();
            thread maps\mp\gametypes\_menus::_ID28895( self.sessionteam );

            if ( maps\mp\_utility::allowclasschoice() || maps\mp\_utility::showfakeloadout() && !isai( self ) )
                self setclientomnvar( "ui_options_menu", 2 );

            thread _ID19119();
            return;
            return;
        }

        if ( issquadsmode() && getdvarint( "onlinegame" ) == 0 && level._ID14086 != "horde" && isbot( self ) == 0 )
        {
            thread spawnspectator();
            thread maps\mp\gametypes\_menus::_ID28895( "allies" );
            self setclientomnvar( "ui_options_menu", 2 );
            return;
        }

        if ( !maps\mp\_utility::_ID20673() && maps\mp\_utility::allowteamchoice() )
        {
            maps\mp\gametypes\_menus::menuspectator();
            self setclientomnvar( "ui_options_menu", 1 );
            return;
        }

        thread spawnspectator();
        maps\mp\gametypes\_menus::autoassign();

        if ( maps\mp\_utility::allowclasschoice() || maps\mp\_utility::showfakeloadout() && !isai( self ) )
            self setclientomnvar( "ui_options_menu", 2 );

        if ( maps\mp\_utility::_ID20673() )
            thread _ID19119();

        return;
        return;
        return;
        return;
        return;
    }

    maps\mp\gametypes\_menus::addtoteam( self.pers["team"], 1 );

    if ( maps\mp\_utility::_ID18844( self.pers["class"] ) )
    {
        thread _ID30822();
        return;
    }

    thread spawnspectator();

    if ( self.pers["team"] == "spectator" )
    {
        if ( isdefined( self.pers["mlgSpectator"] ) && self.pers["mlgSpectator"] )
        {
            self setmlgspectator( 1 );
            thread maps\mp\gametypes\_spectating::_ID37970( 1 );
            thread maps\mp\gametypes\_spectating::_ID28880();
        }

        if ( maps\mp\_utility::allowteamchoice() )
        {
            maps\mp\gametypes\_menus::beginteamchoice();
            return;
        }

        self [[ level.autoassign ]]();
        return;
        return;
    }

    maps\mp\gametypes\_menus::beginclasschoice();
    return;
    return;
    return;
}

callback_playermigrated()
{
    if ( isdefined( self._ID7864 ) && self._ID7864 )
    {
        maps\mp\_utility::updateobjectivetext();
        maps\mp\_utility::_ID34559();

        if ( level._ID32653 )
            self updatescores();
    }

    if ( self ishost() )
        _ID17914();

    var_0 = 0;

    foreach ( var_2 in level.players )
    {
        if ( !isdefined( var_2.pers["isBot"] ) || var_2.pers["isBot"] == 0 )
            var_0++;
    }

    if ( !isdefined( self.pers["isBot"] ) || self.pers["isBot"] == 0 )
    {
        level._ID17097++;

        if ( level._ID17097 >= var_0 * 2 / 3 )
        {
            level notify( "hostmigration_enoughplayers" );
            return;
        }

        return;
    }
}

addlevelstoexperience( var_0, var_1 )
{
    var_2 = maps\mp\gametypes\_rank::getrankforxp( var_0 );
    var_3 = maps\mp\gametypes\_rank::_ID15303( var_2 );
    var_4 = maps\mp\gametypes\_rank::_ID15302( var_2 );
    var_2 += ( var_0 - var_3 ) / ( var_4 - var_3 );
    var_2 += var_1;

    if ( var_2 < 0 )
    {
        var_2 = 0;
        var_5 = 0.0;
    }
    else if ( var_2 >= level._ID20757 + 1.0 )
    {
        var_2 = level._ID20757;
        var_5 = 1.0;
    }
    else
    {
        var_5 = var_2 - floor( var_2 );
        var_2 = int( floor( var_2 ) );
    }

    var_3 = maps\mp\gametypes\_rank::_ID15303( var_2 );
    var_4 = maps\mp\gametypes\_rank::_ID15302( var_2 );
    return int( var_5 * ( var_4 - var_3 ) ) + var_3;
}

_ID15318( var_0 )
{
    var_1 = getdvarfloat( "scr_restxp_cap" );
    return addlevelstoexperience( var_0, var_1 );
}

_ID28853()
{
    if ( !maps\mp\_utility::_ID25420() )
        return;

    if ( !getdvarint( "scr_restxp_enable" ) )
    {
        self setrankedplayerdata( "restXPGoal", 0 );
        return;
    }

    var_0 = self getrestedtime();
    var_1 = var_0 / 3600;
    var_2 = self getrankedplayerdata( "experience" );
    var_3 = getdvarfloat( "scr_restxp_minRestTime" );
    var_4 = getdvarfloat( "scr_restxp_levelsPerDay" ) / 24.0;
    var_5 = _ID15318( var_2 );
    var_6 = self getrankedplayerdata( "restXPGoal" );

    if ( var_6 < var_2 )
        var_6 = var_2;

    var_7 = var_6;
    var_8 = 0;

    if ( var_1 > var_3 )
    {
        var_8 = var_4 * var_1;
        var_6 = addlevelstoexperience( var_6, var_8 );
    }

    var_9 = "";

    if ( var_6 >= var_5 )
    {
        var_6 = var_5;
        var_9 = " (hit cap)";
    }

    self setrankedplayerdata( "restXPGoal", var_6 );
}

_ID13533()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "spawned" );
    wait 60.0;

    if ( self.hasspawned )
        return;

    if ( self.pers["team"] == "spectator" )
        return;

    if ( !maps\mp\_utility::_ID18844( self.pers["class"] ) )
    {
        self.pers["class"] = "CLASS_CUSTOM1";
        self.class = self.pers["class"];
    }

    thread _ID30822();
}

_ID19119()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "spawned" );
    self endon( "attempted_spawn" );
    var_0 = getdvarfloat( "scr_kick_time", 90 );
    var_1 = getdvarfloat( "scr_kick_mintime", 45 );
    var_2 = getdvarfloat( "scr_kick_hosttime", 120 );
    var_3 = gettime();

    if ( self ishost() )
        _ID19120( var_2 );
    else
        _ID19120( var_0 );

    var_4 = ( gettime() - var_3 ) / 1000;

    if ( var_4 < var_0 - 0.1 && var_4 < var_1 )
        return;

    if ( self.hasspawned )
        return;

    if ( self.pers["team"] == "spectator" )
        return;

    kick( self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE" );
    level thread maps\mp\gametypes\_gamelogic::_ID34542();
}

_ID19120( var_0 )
{
    level endon( "game_ended" );
    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
}

initplayerstats()
{
    maps\mp\gametypes\_persistence::_ID17910();
    self.pers["lives"] = maps\mp\_utility::_ID15035();

    if ( !isdefined( self.pers["deaths"] ) )
    {
        maps\mp\_utility::_ID17982( "deaths" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "deaths", 0 );
    }

    self.deaths = maps\mp\_utility::_ID15245( "deaths" );

    if ( !isdefined( self.pers["score"] ) )
    {
        maps\mp\_utility::_ID17982( "score" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "score", 0 );
    }

    self.score = maps\mp\_utility::_ID15245( "score" );

    if ( !isdefined( self.pers["suicides"] ) )
        maps\mp\_utility::_ID17982( "suicides" );

    self._ID32048 = maps\mp\_utility::_ID15245( "suicides" );

    if ( !isdefined( self.pers["kills"] ) )
    {
        maps\mp\_utility::_ID17982( "kills" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "kills", 0 );
    }

    self.kills = maps\mp\_utility::_ID15245( "kills" );

    if ( !isdefined( self.pers["headshots"] ) )
        maps\mp\_utility::_ID17982( "headshots" );

    self._ID16462 = maps\mp\_utility::_ID15245( "headshots" );

    if ( !isdefined( self.pers["assists"] ) )
    {
        maps\mp\_utility::_ID17982( "assists" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "assists", 0 );
    }

    self.assists = maps\mp\_utility::_ID15245( "assists" );

    if ( !isdefined( self.pers["captures"] ) )
    {
        maps\mp\_utility::_ID17982( "captures" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "captures", 0 );
    }

    self._ID6696 = maps\mp\_utility::_ID15245( "captures" );

    if ( !isdefined( self.pers["returns"] ) )
    {
        maps\mp\_utility::_ID17982( "returns" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "returns", 0 );
    }

    self._ID26248 = maps\mp\_utility::_ID15245( "returns" );

    if ( !isdefined( self.pers["defends"] ) )
    {
        maps\mp\_utility::_ID17982( "defends" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "defends", 0 );
    }

    self.defends = maps\mp\_utility::_ID15245( "defends" );

    if ( !isdefined( self.pers["plants"] ) )
    {
        maps\mp\_utility::_ID17982( "plants" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "plants", 0 );
    }

    self._ID23711 = maps\mp\_utility::_ID15245( "plants" );

    if ( !isdefined( self.pers["defuses"] ) )
    {
        maps\mp\_utility::_ID17982( "defuses" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "defuses", 0 );
    }

    self.defuses = maps\mp\_utility::_ID15245( "defuses" );

    if ( !isdefined( self.pers["destructions"] ) )
    {
        maps\mp\_utility::_ID17982( "destructions" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "destructions", 0 );
    }

    self.destructions = maps\mp\_utility::_ID15245( "destructions" );

    if ( !isdefined( self.pers["confirmed"] ) )
    {
        maps\mp\_utility::_ID17982( "confirmed" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "confirmed", 0 );
    }

    self.confirmed = maps\mp\_utility::_ID15245( "confirmed" );

    if ( !isdefined( self.pers["denied"] ) )
    {
        maps\mp\_utility::_ID17982( "denied" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "denied", 0 );
    }

    self.denied = maps\mp\_utility::_ID15245( "denied" );

    if ( !isdefined( self.pers["rescues"] ) )
    {
        maps\mp\_utility::_ID17982( "rescues" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "rescues", 0 );
    }

    self._ID26073 = maps\mp\_utility::_ID15245( "rescues" );

    if ( !isdefined( self.pers["killChains"] ) )
    {
        maps\mp\_utility::_ID17982( "killChains" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "killChains", 0 );
    }

    self.killchains = maps\mp\_utility::_ID15245( "killChains" );

    if ( !isdefined( self.pers["killsAsSurvivor"] ) )
    {
        maps\mp\_utility::_ID17982( "killsAsSurvivor" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "killsAsSurvivor", 0 );
    }

    self.killsassurvivor = maps\mp\_utility::_ID15245( "killsAsSurvivor" );

    if ( !isdefined( self.pers["killsAsInfected"] ) )
    {
        maps\mp\_utility::_ID17982( "killsAsInfected" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "killsAsInfected", 0 );
    }

    self._ID19239 = maps\mp\_utility::_ID15245( "killsAsInfected" );

    if ( !isdefined( self.pers["teamkills"] ) )
        maps\mp\_utility::_ID17982( "teamkills" );

    if ( !isdefined( self.pers["extrascore0"] ) )
        maps\mp\_utility::_ID17982( "extrascore0" );

    if ( !isdefined( self.pers["hordeKills"] ) )
    {
        maps\mp\_utility::_ID17982( "hordeKills" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "squardKills", 0 );
    }

    if ( !isdefined( self.pers["hordeRevives"] ) )
    {
        maps\mp\_utility::_ID17982( "hordeRevives" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "squardRevives", 0 );
    }

    if ( !isdefined( self.pers["hordeCrates"] ) )
    {
        maps\mp\_utility::_ID17982( "hordeCrates" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "squardCrates", 0 );
    }

    if ( !isdefined( self.pers["hordeRound"] ) )
    {
        maps\mp\_utility::_ID17982( "hordeRound" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "sguardWave", 0 );
    }

    if ( !isdefined( self.pers["hordeWeapon"] ) )
    {
        maps\mp\_utility::_ID17982( "hordeWeapon" );
        maps\mp\gametypes\_persistence::_ID31528( "round", "sguardWeaponLevel", 0 );
    }

    if ( !isdefined( self.pers["teamKillPunish"] ) )
        self.pers["teamKillPunish"] = 0;

    maps\mp\_utility::_ID17982( "longestStreak" );
    self.pers["lives"] = maps\mp\_utility::_ID15035();
    maps\mp\gametypes\_persistence::_ID31528( "round", "killStreak", 0 );
    maps\mp\gametypes\_persistence::_ID31528( "round", "loss", 0 );
    maps\mp\gametypes\_persistence::_ID31528( "round", "win", 0 );
    maps\mp\gametypes\_persistence::_ID31528( "round", "scoreboardType", "none" );
    maps\mp\gametypes\_persistence::_ID31529( "round", "timePlayed", 0 );
}

addtoteamcount()
{
    level._ID32656[self.team]++;

    if ( !isdefined( level._ID32666 ) )
        level._ID32666 = [];

    if ( !isdefined( level._ID32666[self.team] ) )
        level._ID32666[self.team] = [];

    level._ID32666[self.team][level._ID32666[self.team].size] = self;
    maps\mp\gametypes\_gamelogic::_ID34542();
}

_ID26006()
{
    level._ID32656[self.team]--;

    if ( isdefined( level._ID32666 ) && isdefined( level._ID32666[self.team] ) )
    {
        var_0 = [];

        foreach ( var_2 in level._ID32666[self.team] )
        {
            if ( !isdefined( var_2 ) || var_2 == self )
                continue;

            var_0[var_0.size] = var_2;
        }

        level._ID32666[self.team] = var_0;
        return;
    }
}

_ID2446()
{
    var_0 = self.team;

    if ( !( isdefined( self.alreadyaddedtoalivecount ) && self.alreadyaddedtoalivecount ) )
    {
        level.hasspawned[var_0]++;
        incrementalivecount( var_0 );
    }

    self.alreadyaddedtoalivecount = undefined;

    if ( level.alivecount["allies"] + level.alivecount["axis"] > level._ID20754 )
    {
        level._ID20754 = level.alivecount["allies"] + level.alivecount["axis"];
        return;
    }
}

incrementalivecount( var_0 )
{
    level.alivecount[var_0]++;
}

_ID25993( var_0 )
{
    if ( maps\mp\_utility::_ID18363() )
        return;

    var_1 = self.team;

    if ( isdefined( self._ID32285 ) && self._ID32285 && isdefined( self._ID18976 ) && self._ID18976 == self.team )
        var_1 = self._ID19789;

    if ( isdefined( var_0 ) )
        _ID25975();
    else if ( isdefined( self._ID32285 ) )
        self.pers["lives"]--;

    decrementalivecount( var_1 );
    return maps\mp\gametypes\_gamelogic::_ID34542();
}

decrementalivecount( var_0 )
{
    level.alivecount[var_0]--;
}

addtolivescount()
{
    level._ID20088[self.team] = level._ID20088[self.team] + self.pers["lives"];
}

_ID26001()
{
    level._ID20088[self.team]--;
    level._ID20088[self.team] = int( max( 0, level._ID20088[self.team] ) );
}

_ID25975()
{
    level._ID20088[self.team] = level._ID20088[self.team] - self.pers["lives"];
    level._ID20088[self.team] = int( max( 0, level._ID20088[self.team] ) );
}

_ID26145()
{
    self setclientomnvar( "ui_carrying_bomb", 0 );
    self setclientomnvar( "ui_dom_securing", 0 );
    self setclientomnvar( "ui_securing", 0 );
    self setclientomnvar( "ui_bomb_planting_defusing", 0 );
    self setclientomnvar( "ui_light_armor", 0 );
    self setclientdvar( "ui_juiced_end_milliseconds", 0 );
    self setclientomnvar( "ui_killcam_end_milliseconds", 0 );
    self setclientomnvar( "ui_cranked_bomb_timer_end_milliseconds", 0 );
}

_ID26143()
{
    self setclientomnvar( "ui_carrying_bomb", 0 );
    self setclientomnvar( "ui_dom_securing", 0 );
    self setclientomnvar( "ui_securing", 0 );
    self setclientomnvar( "ui_bomb_planting_defusing", 0 );
    self setclientomnvar( "ui_light_armor", 0 );
    self setclientomnvar( "ui_killcam_end_milliseconds", 0 );
    self setclientdvar( "ui_juiced_end_milliseconds", 0 );
    self setclientdvar( "ui_eyes_on_end_milliseconds", 0 );
    self setclientomnvar( "ui_cranked_bomb_timer_end_milliseconds", 0 );
}

_ID26146()
{
    self setclientomnvar( "ui_carrying_bomb", 0 );
    self setclientomnvar( "ui_dom_securing", 0 );
    self setclientomnvar( "ui_securing", 0 );
    self setclientomnvar( "ui_bomb_planting_defusing", 0 );
    self setclientomnvar( "ui_light_armor", 0 );
    self setclientomnvar( "ui_killcam_end_milliseconds", 0 );
    self setclientdvar( "ui_juiced_end_milliseconds", 0 );
    self setclientdvar( "ui_eyes_on_end_milliseconds", 0 );
    self setclientomnvar( "ui_cranked_bomb_timer_end_milliseconds", 0 );
}

resetuidvarsondeath()
{

}

_ID36078()
{
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "sprint_slide_begin" );
        self playfx( level._ID1644["slide_dust"], self geteye() );
    }
}
