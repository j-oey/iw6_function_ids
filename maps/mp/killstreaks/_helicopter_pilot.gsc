// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["heli_pilot"] = ::_ID33850;
    level.heli_pilot = [];
    level.helipilotsettings = [];
    level.helipilotsettings["heli_pilot"] = spawnstruct();
    level.helipilotsettings["heli_pilot"].timeout = 60.0;
    level.helipilotsettings["heli_pilot"].maxhealth = 2000;
    level.helipilotsettings["heli_pilot"]._ID31889 = "heli_pilot";
    level.helipilotsettings["heli_pilot"]._ID35155 = "heli_pilot_mp";
    level.helipilotsettings["heli_pilot"].modelbase = level._ID20077;
    level.helipilotsettings["heli_pilot"]._ID32680 = "used_heli_pilot";
    helipilot_setairstartnodes();
    level._ID16638 = getent( "heli_pilot_mesh", "targetname" );

    if ( !isdefined( level._ID16638 ) )
    {

    }
    else
        level._ID16638.origin = level._ID16638.origin + maps\mp\_utility::gethelipilotmeshoffset();

    var_0 = spawnstruct();
    var_0._ID36472 = "destroyed_helo_pilot";
    var_0._ID35387 = undefined;
    var_0.callout = "callout_destroyed_helo_pilot";
    var_0.samdamagescale = 0.09;
    var_0.enginevfxtag = "tag_engine_right";
    level.heliconfigs["heli_pilot"] = var_0;
}

_ID33850( var_0, var_1 )
{
    var_2 = "heli_pilot";
    var_3 = 1;

    if ( isdefined( self.underwater ) && self.underwater )
        return 0;
    else if ( _ID12351( self.team ) )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }
    else if ( maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 + var_3 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        return 0;
    }

    maps\mp\_utility::_ID17543();
    var_4 = _ID8440( var_2 );

    if ( !isdefined( var_4 ) )
    {
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    level.heli_pilot[self.team] = var_4;
    var_5 = starthelipilot( var_4 );

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    return var_5;
}

_ID12351( var_0 )
{
    if ( level._ID14086 == "dm" )
    {
        if ( isdefined( level.heli_pilot[var_0] ) || isdefined( level.heli_pilot[level._ID23070[var_0]] ) )
            return 1;
        else
            return 0;
    }
    else if ( isdefined( level.heli_pilot[var_0] ) )
        return 1;
    else
        return 0;
}

watchhostmigrationfinishedinit( var_0 )
{
    var_0 endon( "killstreak_disowned" );
    var_0 endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "death" );

    for (;;)
    {
        level waittill( "host_migration_end" );
        var_0 setclientomnvar( "ui_heli_pilot", 1 );
    }
}

_ID8440( var_0 )
{
    var_1 = _ID16740( self.origin );
    var_2 = _ID16741( var_1 );
    var_3 = vectortoangles( var_2.origin - var_1.origin );
    var_4 = anglestoforward( self.angles );
    var_5 = var_2.origin + var_4 * -100;
    var_6 = var_1.origin;
    var_7 = spawnhelicopter( self, var_6, var_3, level.helipilotsettings[var_0]._ID35155, level.helipilotsettings[var_0].modelbase );

    if ( !isdefined( var_7 ) )
        return;

    var_7 makevehiclesolidcapsule( 18, -9, 18 );
    var_7 maps\mp\killstreaks\_helicopter::addtolittlebirdlist();
    var_7 thread maps\mp\killstreaks\_helicopter::_ID26000();
    var_7.maxhealth = level.helipilotsettings[var_0].maxhealth;
    var_7.speed = 40;
    var_7.owner = self;
    var_7 setotherent( self );
    var_7.team = self.team;
    var_7._ID16760 = "littlebird";
    var_7.helipilottype = "heli_pilot";
    var_7 setmaxpitchroll( 45, 45 );
    var_7 vehicle_setspeed( var_7.speed, 40, 40 );
    var_7 setyawspeed( 120, 60 );
    var_7 setneargoalnotifydist( 32 );
    var_7 sethoverparams( 100, 100, 100 );
    var_7 common_scripts\utility::_ID20489( var_7.team );
    var_7._ID32619 = var_5;
    var_7._ID8699 = var_2;
    var_7.attract_strength = 10000;
    var_7.attract_range = 150;
    var_7.attractor = missile_createattractorent( var_7, var_7.attract_strength, var_7.attract_range );
    var_7 thread maps\mp\killstreaks\_helicopter::_ID16549( "heli_pilot" );
    var_7 thread _ID16743();
    var_7 thread helipilot_watchtimeout();
    var_7 thread helipilot_watchownerloss();
    var_7 thread _ID16749();
    var_7 thread _ID16747();
    var_7 thread helipilot_watchdeath();
    var_7 thread watchhostmigrationfinishedinit( self );
    var_7.owner maps\mp\_matchdata::_ID20253( level.helipilotsettings[var_7.helipilottype]._ID31889, var_7._ID32619 );
    return var_7;
}

_ID16743()
{
    playfxontag( level._ID7233["light"]["left"], self, "tag_light_nose" );
    wait 0.05;
    playfxontag( level._ID7233["light"]["belly"], self, "tag_light_belly" );
    wait 0.05;
    playfxontag( level._ID7233["light"]["tail"], self, "tag_light_tail1" );
    wait 0.05;
    playfxontag( level._ID7233["light"]["tail"], self, "tag_light_tail2" );
}

starthelipilot( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    maps\mp\_utility::_ID29199( var_0.helipilottype );

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::_ID28902( 0 );

    self._ID26200 = self.angles;
    var_0 thread maps\mp\killstreaks\_flares::ks_setup_manual_flares( 2, "+smoke", "ui_heli_pilot_flare_ammo", "ui_heli_pilot_warn" );
    thread _ID36091( var_0 );
    maps\mp\_utility::_ID13582( 1 );
    var_1 = maps\mp\killstreaks\_killstreaks::_ID17993( var_0.helipilottype );

    if ( var_1 != "success" )
    {
        if ( isdefined( self.disabledweapon ) && self.disabledweapon )
            common_scripts\utility::_enableweapon();

        var_0 notify( "death" );
        return 0;
    }

    maps\mp\_utility::_ID13582( 0 );
    var_2 = maps\mp\_utility::_ID15049();
    var_3 = var_0._ID8699.origin + ( maps\mp\_utility::gethelipilotmeshoffset() + var_2 );
    var_4 = var_0._ID8699.origin + maps\mp\_utility::gethelipilotmeshoffset() - var_2;
    var_5 = bullettrace( var_3, var_4, 0, undefined, 0, 0, 1 );

    if ( !isdefined( var_5["entity"] ) )
    {

    }

    var_6 = var_5["position"] - maps\mp\_utility::gethelipilotmeshoffset() + ( 0, 0, 250 );
    var_7 = spawn( "script_origin", var_6 );
    self remotecontrolvehicle( var_0 );
    var_0 thread _ID16730( var_7 );
    var_0 thread _ID16745();
    level thread maps\mp\_utility::_ID32672( level.helipilotsettings[var_0.helipilottype]._ID32680, self );
    var_0._ID19214 = spawn( "script_origin", self getvieworigin() );
    return 1;
}

_ID16730( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    self remotecontrolvehicletarget( var_0 );
    self waittill( "goal_reached" );
    self remotecontrolvehicletargetoff();
    var_0 delete();
}

_ID36091( var_0 )
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    self waittill( "intro_cleared" );
    self setclientomnvar( "ui_heli_pilot", 1 );
    var_1 = maps\mp\_utility::_ID23108( self, "cyan", self, 0, "killstreak" );
    _ID26020( var_1, var_0 );

    foreach ( var_3 in level._ID23303 )
    {
        if ( !maps\mp\_utility::_ID18757( var_3 ) || var_3.sessionstate != "playing" )
            continue;

        if ( maps\mp\_utility::isenemy( var_3 ) )
        {
            if ( !var_3 maps\mp\_utility::_hasperk( "specialty_noplayertarget" ) )
            {
                var_1 = maps\mp\_utility::_ID23108( var_3, "orange", self, 0, "killstreak" );
                var_3 _ID26020( var_1, var_0 );
                continue;
            }

            var_3 thread _ID38295( var_0 );
        }
    }

    var_0 thread _ID38297();
    thread _ID36062( var_0 );
}

_ID38295( var_0 )
{
    self notify( "watchForPerkRemoval" );
    self endon( "watchForPerkRemoval" );
    self endon( "death" );
    self waittill( "removed_specialty_noplayertarget" );
    var_1 = maps\mp\_utility::_ID23108( self, "orange", var_0.owner, 0, "killstreak" );
    _ID26020( var_1, var_0 );
}

_ID38297()
{
    self endon( "leaving" );
    self endon( "death" );

    for (;;)
    {
        level waittill( "player_spawned",  var_0  );

        if ( var_0.sessionstate == "playing" && self.owner maps\mp\_utility::isenemy( var_0 ) )
            var_0 thread _ID38295( self );
    }
}

_ID26020( var_0, var_1 )
{
    thread _ID37424( var_0, var_1 );
    thread _ID37802( var_0, var_1 );
}

_ID37424( var_0, var_1 )
{
    self notify( "heliRemoveOutline" );
    self endon( "heliRemoveOutline" );
    self endon( "outline_removed" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_2 = [ "leaving", "death" ];
    var_1 common_scripts\utility::waittill_any_in_array_return_no_endon_death( var_2 );

    if ( isdefined( self ) )
    {
        maps\mp\_utility::_ID23104( var_0, self );
        self notify( "outline_removed" );
    }
}

_ID37802( var_0, var_1 )
{
    self notify( "playerRemoveOutline" );
    self endon( "playerRemoveOutline" );
    self endon( "outline_removed" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_2 = [ "death" ];
    common_scripts\utility::waittill_any_in_array_return_no_endon_death( var_2 );
    maps\mp\_utility::_ID23104( var_0, self );
    self notify( "outline_removed" );
}

helipilot_watchdeath()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self waittill( "death" );

    if ( isdefined( self.owner ) )
        self.owner _ID16738( self );

    if ( isdefined( self._ID19214 ) )
        self._ID19214 delete();

    thread maps\mp\killstreaks\_helicopter::_ID19722();
}

_ID16747()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    level waittill( "objective_cam" );
    thread maps\mp\killstreaks\_helicopter::_ID19722();

    if ( isdefined( self.owner ) )
        self.owner _ID16738( self );
}

helipilot_watchtimeout()
{
    level endon( "game_ended" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    var_0 = level.helipilotsettings[self.helipilottype].timeout;
    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    thread helipilot_leave();
}

helipilot_watchownerloss()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner common_scripts\utility::_ID35626( "disconnect", "joined_team", "joined_spectators" );
    thread helipilot_leave();
}

_ID16749()
{
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    level common_scripts\utility::_ID35626( "round_end_finished", "game_ended" );
    thread helipilot_leave();
}

helipilot_leave()
{
    self endon( "death" );
    self notify( "leaving" );

    if ( isdefined( self.owner ) )
        self.owner _ID16738( self );

    var_0 = maps\mp\killstreaks\_airdrop::_ID15024( self.origin );
    var_1 = self.origin + ( 0, 0, var_0 );
    self vehicle_setspeed( 140, 60 );
    self setmaxpitchroll( 45, 180 );
    self setvehgoalpos( var_1 );
    self waittill( "goal" );
    var_1 += anglestoforward( self.angles ) * 15000;
    var_2 = spawn( "script_origin", var_1 );

    if ( isdefined( var_2 ) )
    {
        self setlookatent( var_2 );
        var_2 thread _ID35429( 3.0 );
    }

    self setvehgoalpos( var_1 );
    self waittill( "goal" );
    self notify( "gone" );
    maps\mp\killstreaks\_helicopter::_ID26014();
}

_ID35429( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    wait(var_0);
    self delete();
}

_ID16738( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        self setclientomnvar( "ui_heli_pilot", 0 );
        var_0 notify( "end_remote" );

        if ( maps\mp\_utility::_ID18837() )
            maps\mp\_utility::_ID7513();

        if ( getdvarint( "camera_thirdPerson" ) )
            maps\mp\_utility::_ID28902( 1 );

        self remotecontrolvehicleoff( var_0 );
        self setplayerangles( self._ID26200 );
        thread _ID16739();
    }
}

_ID16739()
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    maps\mp\_utility::_ID13582( 1 );
    wait 0.5;
    maps\mp\_utility::_ID13582( 0 );
}

_ID16745()
{
    self endon( "leaving" );
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = 0;

    for (;;)
    {
        if ( isdefined( self.owner ) )
        {
            if ( self.owner adsbuttonpressed() )
            {
                if ( !var_0 )
                {
                    self.owner setclientomnvar( "ui_heli_pilot", 2 );
                    var_0 = 1;
                }
            }
            else if ( var_0 )
            {
                self.owner setclientomnvar( "ui_heli_pilot", 1 );
                var_0 = 0;
            }
        }

        wait 0.1;
    }
}

helipilot_setairstartnodes()
{
    level.air_start_nodes = common_scripts\utility::_ID15386( "chopper_boss_path_start", "targetname" );
}

_ID16741( var_0 )
{
    if ( isdefined( var_0.script_linkto ) )
    {
        var_1 = var_0 common_scripts\utility::get_links();

        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            var_3 = common_scripts\utility::_ID15384( var_1[var_2], "script_linkname" );

            if ( isdefined( var_3 ) )
                return var_3;
        }
    }

    return undefined;
}

_ID16740( var_0 )
{
    var_1 = undefined;
    var_2 = 999999;

    foreach ( var_4 in level.air_start_nodes )
    {
        var_5 = distance( var_4.origin, var_0 );

        if ( var_5 < var_2 )
        {
            var_1 = var_4;
            var_2 = var_5;
        }
    }

    return var_1;
}

_ID36062( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    self endon( "leaving" );
    var_0 thread maps\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit();
    var_0 waittill( "killstreakExit" );
    var_0 thread helipilot_leave();
}
