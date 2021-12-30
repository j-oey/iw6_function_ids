// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    precachelocationselector( "map_artillery_selector" );
    var_0 = spawnstruct();
    var_0._ID21275 = [];
    var_0._ID21275["allies"] = "vehicle_a10_warthog_iw6_mp";
    var_0._ID21275["axis"] = "vehicle_a10_warthog_iw6_mp";
    var_0._ID34941 = "a10_warthog_mp";
    var_0.inboundsfx = "veh_mig29_dist_loop";
    var_0.speed = 3000;
    var_0._ID15984 = 12500;
    var_0.heightrange = 750;
    var_0.choosedirection = 1;
    var_0._ID28034 = "KS_hqr_airstrike";
    var_0._ID17499 = "KS_ast_inbound";
    var_0.cannonfirevfx = loadfx( "fx/smoke/smoke_trail_white_heli" );
    var_0.cannonrumble = "ac130_25mm_fire";
    var_0._ID34094 = "a10_30mm_turret_mp";
    var_0.turretattachpoint = "tag_barrel";
    var_0._ID26358 = "maverick_projectile_mp";
    var_0._ID22418 = 4;
    var_0.delaybetweenrockets = 0.125;
    var_0.delaybetweenlockon = 0.4;
    var_0._ID20193 = "veh_hud_target_chopperfly";
    var_0.maxhealth = 1000;
    var_0._ID36472 = "destroyed_a10_strafe";
    var_0.callout = "callout_destroyed_a10";
    var_0._ID35387 = undefined;
    var_0.explodevfx = loadfx( "fx/explosions/aerial_explosion" );
    var_0.sfxcannonfireloop_1p = "veh_a10_plr_fire_gatling_lp";
    var_0._ID29618 = "veh_a10_plr_fire_gatling_cooldown";
    var_0._ID29617 = "veh_a10_npc_fire_gatling_lp";
    var_0._ID29619 = "veh_a10_npc_fire_gatling_cooldown";
    var_0._ID29615 = 500;
    var_0._ID29614 = "veh_a10_npc_fire_gatling_short_burst";
    var_0._ID29613 = "veh_a10_npc_fire_gatling_long_burst";
    var_0._ID29612 = "veh_a10_bullet_impact_lp";
    var_0._ID29623 = [];
    var_0._ID29623[0] = "veh_a10_plr_missile_ignition_left";
    var_0._ID29623[1] = "veh_a10_plr_missile_ignition_right";
    var_0.sfxmissilefire_3p = "veh_a10_npc_missile_fire";
    var_0._ID29622 = "veh_a10_missile_loop";
    var_0._ID29620 = "veh_a10_plr_engine_lp";
    var_0._ID29621 = "veh_a10_dist_loop";
    level._ID23699["a10_strafe"] = var_0;
    level._ID19256["a10_strafe"] = ::_ID22916;
    _ID6228();
}

_ID22916( var_0, var_1 )
{
    if ( isdefined( level.a10strafeactive ) )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }
    else if ( maps\mp\_utility::_ID18837() || maps\mp\_utility::_ID18678() )
        return 0;
    else if ( getcsplinecount() < 2 )
        return 0;
    else
    {
        thread dostrike( var_0, "a10_strafe" );
        return 1;
    }
}

dostrike( var_0, var_1 )
{
    self endon( "end_remote" );
    self endon( "death" );
    level endon( "game_ended" );
    var_2 = _ID15233();
    var_3 = _ID31477( var_1, var_0 );

    if ( var_3 )
    {
        var_4 = _ID30814( var_1, var_0, level._ID1946[var_2] );

        if ( isdefined( var_4 ) )
        {
            var_4 dooneflyby();
            _ID32281( var_4, var_1 );
            var_4 = _ID30814( var_1, var_0, level._ID1946[var_2] );

            if ( isdefined( var_4 ) )
            {
                thread maps\mp\killstreaks\_killstreaks::clearrideintro( 1.0, 0.75 );
                var_4 dooneflyby();
                var_4 thread _ID11603( var_1 );
                _ID11763( var_1 );
            }
        }
    }
}

_ID31477( var_0, var_1 )
{
    maps\mp\_utility::_ID29199( "a10_strafe" );

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::_ID28902( 0 );

    self._ID26200 = self.angles;
    maps\mp\_utility::_ID13582( 1 );
    var_2 = maps\mp\killstreaks\_killstreaks::_ID17993( "a10_strafe" );

    if ( var_2 != "success" )
    {
        if ( var_2 != "disconnect" )
            maps\mp\_utility::_ID7513();

        if ( isdefined( self.disabledweapon ) && self.disabledweapon )
            common_scripts\utility::_enableweapon();

        self notify( "death" );
        return 0;
    }

    if ( maps\mp\_utility::_ID18666() && isdefined( self._ID18985 ) )
        self._ID18985.alpha = 0;

    maps\mp\_utility::_ID13582( 0 );
    level.a10strafeactive = 1;
    self._ID34791 = 1;
    level thread maps\mp\_utility::_ID32672( "used_" + var_0, self, self.team );
    return 1;
}

_ID11763( var_0 )
{
    maps\mp\_utility::_ID7513();

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::_ID28902( 1 );

    if ( maps\mp\_utility::_ID18666() && isdefined( self._ID18985 ) )
        self._ID18985.alpha = 1;

    self setplayerangles( self._ID26200 );
    self._ID26200 = undefined;
    thread a10_freezebuffer();
    level.a10strafeactive = undefined;
    self._ID34791 = undefined;
}

_ID32281( var_0, var_1 )
{
    self.usingremote = undefined;
    self visionsetnakedforplayer( "black_bw", 0.75 );
    thread maps\mp\_utility::set_visionset_for_watching_players( "black_bw", 0.75, 0.75 );
    wait 0.75;

    if ( isdefined( var_0 ) )
        var_0 thread _ID11603( var_1 );
}

_ID30814( var_0, var_1, var_2 )
{
    var_3 = createplaneasheli( var_0, var_1, var_2 );

    if ( !isdefined( var_3 ) )
        return undefined;

    var_3._ID31889 = var_0;
    self remotecontrolvehicle( var_3 );
    var_3 setplanesplineid( self, var_2 );
    thread _ID36091( var_0, var_3 );
    var_4 = level._ID23699[var_0];
    var_3 playloopsound( var_4._ID29620 );
    var_3 thread a10_handledamage();
    maps\mp\killstreaks\_plane::_ID31482( var_3 );
    return var_3;
}

attachturret( var_0 )
{
    var_1 = level._ID23699[var_0];
    var_2 = self gettagorigin( var_1.turretattachpoint );
    var_3 = spawnturret( "misc_turret", self.origin + var_2, var_1._ID34094, 0 );
    var_3 linkto( self, var_1.turretattachpoint, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_3 setmodel( "vehicle_ugv_talon_gun_mp" );
    var_3.angles = self.angles;
    var_3.owner = self.owner;
    var_3 maketurretinoperable();
    var_3 setturretmodechangewait( 0 );
    var_3 setmode( "sentry_offline" );
    var_3 makeunusable();
    var_3 setcandamage( 0 );
    var_3 setsentryowner( self.owner );
    self.owner remotecontrolturret( var_3 );
    self._ID33988 = var_3;
}

_ID7401()
{
    if ( isdefined( self._ID33988 ) )
        self._ID33988 delete();

    foreach ( var_1 in self._ID32615 )
    {
        if ( isdefined( var_1["icon"] ) )
        {
            var_1["icon"] destroy();
            var_1["icon"] = undefined;
        }
    }

    self delete();
}

_ID15233()
{
    return randomint( level._ID1946.size );
}

dooneflyby()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "splinePlaneReachedNode",  var_0  );

        if ( isdefined( var_0 ) && var_0 == "End" )
        {
            self notify( "a10_end_strafe" );
            break;
        }
    }
}

_ID11603( var_0 )
{
    if ( !isdefined( self ) )
        return;

    self.owner remotecontrolvehicleoff( self );

    if ( isdefined( self._ID33988 ) )
        self.owner remotecontrolturretoff( self._ID33988 );

    self notify( "end_remote" );
    self.owner setclientomnvar( "ui_a10", 0 );
    self.owner thermalvisionfofoverlayoff();
    var_1 = level._ID23699[var_0];
    self stoploopsound( var_1.sfxcannonfireloop_1p );
    maps\mp\killstreaks\_plane::_ID31862( self );
    wait 5;

    if ( isdefined( self ) )
    {
        self stoploopsound( var_1._ID29620 );
        _ID7401();
    }
}

createplaneasheli( var_0, var_1, var_2 )
{
    var_3 = level._ID23699[var_0];
    var_4 = getcsplinepointposition( var_2, 0 );
    var_5 = getcsplinepointtangent( var_2, 0 );
    var_6 = vectortoangles( var_5 );
    var_7 = spawnhelicopter( self, var_4, var_6, var_3._ID34941, var_3._ID21275[self.team] );

    if ( !isdefined( var_7 ) )
        return undefined;

    var_7 makevehiclesolidcapsule( 18, -9, 18 );
    var_7.owner = self;
    var_7.team = self.team;
    var_7._ID19938 = var_1;
    var_7 thread maps\mp\killstreaks\_plane::_ID24628();
    return var_7;
}

_ID16245()
{
    level endon( "game_ended" );
    self endon( "delete" );
    self waittill( "death" );
    level.a10strafeactive = undefined;
    self.owner._ID34791 = undefined;
    self delete();
}

a10_freezebuffer()
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    maps\mp\_utility::_ID13582( 1 );
    wait 0.5;
    maps\mp\_utility::_ID13582( 0 );
}

_ID21432( var_0, var_1 )
{
    var_1 endon( "end_remote" );
    var_1 endon( "death" );
    self endon( "death" );
    level endon( "game_ended" );
    var_2 = level._ID23699[var_0];
    var_1._ID22419 = var_2._ID22418;
    self notifyonplayercommand( "rocket_fire_pressed", "+speed_throw" );
    self notifyonplayercommand( "rocket_fire_pressed", "+ads_akimbo_accessible" );

    if ( !level.console )
        self notifyonplayercommand( "rocket_fire_pressed", "+toggleads_throw" );

    self setclientomnvar( "ui_a10_rocket", var_1._ID22419 );

    while ( var_1._ID22419 > 0 )
    {
        self waittill( "rocket_fire_pressed" );
        var_1 onfirerocket( var_0 );
        wait(var_2.delaybetweenrockets);
    }
}

monitorrocketfire2( var_0, var_1 )
{
    var_1 endon( "end_remote" );
    var_1 endon( "death" );
    self endon( "death" );
    level endon( "game_ended" );
    var_2 = level._ID23699[var_0];
    var_1._ID22419 = var_2._ID22418;
    self notifyonplayercommand( "rocket_fire_pressed", "+speed_throw" );
    self notifyonplayercommand( "rocket_fire_pressed", "+ads_akimbo_accessible" );

    if ( !level.console )
        self notifyonplayercommand( "rocket_fire_pressed", "+toggleads_throw" );

    var_1._ID32615 = [];
    self setclientomnvar( "ui_a10_rocket", var_1._ID22419 );

    while ( var_1._ID22419 > 0 )
    {
        if ( !self adsbuttonpressed() )
            self waittill( "rocket_fire_pressed" );

        var_1 _ID21183();

        if ( var_1._ID32615.size > 0 )
            var_1 thread _ID13070();
    }
}

_ID21189()
{
    var_0 = [];

    foreach ( var_2 in level.players )
    {
        if ( missileisgoodtarget( var_2 ) )
            var_0[var_0.size] = var_2;
    }

    foreach ( var_5 in level._ID34657 )
    {
        if ( missileisgoodtarget( var_5 ) )
            var_0[var_0.size] = var_5;
    }

    if ( var_0.size > 0 )
    {
        var_7 = sortbydistance( var_0, self.origin );
        return var_7[0];
    }

    return undefined;
}

missileisgoodtarget( var_0 )
{
    return isalive( var_0 ) && var_0.team != self.owner.team && !_ID18705( var_0 ) && ( isplayer( var_0 ) && !var_0 maps\mp\_utility::_hasperk( "specialty_blindeye" ) ) && missiletargetangle( var_0 ) > 0.25;
}

missiletargetangle( var_0 )
{
    var_1 = vectornormalize( var_0.origin - self.origin );
    var_2 = anglestoforward( self.angles );
    return vectordot( var_1, var_2 );
}

_ID21183()
{
    self endon( "death" );
    self endon( "end_remote" );
    level endon( "game_ended" );
    self endon( "a10_missiles_fired" );
    var_0 = level._ID23699[self._ID31889];
    self.owner setclientomnvar( "ui_a10_rocket_lock", 1 );
    thread _ID21207();
    var_1 = undefined;

    while ( self._ID32615.size < self._ID22419 )
    {
        if ( !isdefined( var_1 ) )
        {
            var_1 = _ID21189();

            if ( isdefined( var_1 ) )
            {
                thread _ID21194( var_1 );
                wait(var_0.delaybetweenlockon);
                var_1 = undefined;
                continue;
            }
        }

        wait 0.1;
    }

    self.owner setclientomnvar( "ui_a10_rocket_lock", 0 );
    self notify( "a10_missiles_fired" );
}

_ID21207()
{
    self endon( "end_remote" );
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "a10_missiles_fired" );
    var_0 = self.owner;
    var_0 notifyonplayercommand( "rocket_fire_released", "-speed_throw" );
    var_0 notifyonplayercommand( "rocket_fire_released", "-ads_akimbo_accessible" );

    if ( !level.console )
        var_0 notifyonplayercommand( "rocket_fire_released", "-toggleads_throw" );

    self.owner waittill( "rocket_fire_released" );
    var_0 setclientomnvar( "ui_a10_rocket_lock", 0 );
    self notify( "a10_missiles_fired" );
}

_ID21194( var_0 )
{
    var_1 = level._ID23699[self._ID31889];
    var_2 = [];
    var_2["icon"] = var_0 maps\mp\_entityheadicons::setheadicon( self.owner, var_1._ID20193, ( 0, 0, -70 ), 10, 10, 0, 0.05, 1, 0, 0, 0 );
    var_2["target"] = var_0;
    self._ID32615[var_0 getentitynumber()] = var_2;
    self.owner playlocalsound( "recondrone_lockon" );
}

_ID18705( var_0 )
{
    return isdefined( self._ID32615[var_0 getentitynumber()] );
}

_ID13070()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = level._ID23699[self._ID31889];

    foreach ( var_2 in self._ID32615 )
    {
        if ( self._ID22419 > 0 )
        {
            var_3 = _ID22840( self._ID31889, var_2["target"], ( 0, 0, -70 ) );

            if ( isdefined( var_2["icon"] ) )
            {
                var_3._ID17321 = var_2["icon"];
                var_2["icon"] = undefined;
            }

            wait(var_0.delaybetweenrockets);
            continue;
        }

        break;
    }

    var_5 = [];
}

_ID22840( var_0, var_1, var_2 )
{
    var_3 = self._ID22419 % 2;
    var_4 = "tag_missile_" + ( var_3 + 1 );
    var_5 = self gettagorigin( var_4 );

    if ( isdefined( var_5 ) )
    {
        var_6 = self.owner;
        var_7 = level._ID23699[var_0];
        var_8 = magicbullet( var_7._ID26358, var_5, var_5 + 100 * anglestoforward( self.angles ), self.owner );
        var_8 thread a10_missile_set_target( var_1, var_2 );
        earthquake( 0.25, 0.05, self.origin, 512 );
        self._ID22419--;
        self.owner setclientomnvar( "ui_a10_rocket", self._ID22419 );
        var_7 = level._ID23699[var_0];
        var_8 playsoundonmovingent( var_7._ID29623[var_3] );
        var_8 playloopsound( var_7._ID29622 );
        return var_8;
    }

    return undefined;
}

onfirerocket( var_0 )
{
    var_1 = "tag_missile_" + self._ID22419;
    var_2 = self gettagorigin( var_1 );

    if ( isdefined( var_2 ) )
    {
        var_3 = self.owner;
        var_4 = level._ID23699[var_0];
        var_5 = magicbullet( var_4._ID26358, var_2, var_2 + 100 * anglestoforward( self.angles ), self.owner );
        earthquake( 0.25, 0.05, self.origin, 512 );
        self._ID22419--;
        self.owner setclientomnvar( "ui_a10_rocket", self._ID22419 );
        var_5 playsoundonmovingent( var_4._ID29623[self._ID22419] );
        var_5 playloopsound( var_4._ID29622 );
        self playsoundonmovingent( "a10p_missile_launch" );
    }
}

a10_missile_set_target( var_0, var_1 )
{
    thread a10_missile_cleanup();
    wait 0.2;
    self missile_settargetent( var_0, var_1 );
}

a10_missile_cleanup()
{
    self waittill( "death" );

    if ( isdefined( self._ID17321 ) )
        self._ID17321 destroy();
}

_ID21464( var_0, var_1 )
{
    var_1 endon( "end_remote" );
    var_1 endon( "death" );
    self endon( "death" );
    level endon( "game_ended" );
    var_2 = level._ID23699[var_0];
    var_1.ammocount = 1350;
    self setclientomnvar( "ui_a10_cannon", var_1.ammocount );
    self notifyonplayercommand( "a10_cannon_start", "+attack" );
    self notifyonplayercommand( "a10_cannon_stop", "-attack" );

    while ( var_1.ammocount > 0 )
    {
        if ( !self attackbuttonpressed() )
            self waittill( "a10_cannon_start" );

        var_3 = gettime() + var_2._ID29615;
        var_1 playloopsound( var_2.sfxcannonfireloop_1p );
        var_1 thread _ID34513( var_0 );
        self waittill( "a10_cannon_stop" );
        var_1 stoploopsound( var_2.sfxcannonfireloop_1p );
        var_1 playsoundonmovingent( var_2._ID29618 );

        if ( gettime() < var_3 )
        {
            playsoundatpos( var_1.origin, var_2._ID29614 );
            continue;
        }

        playsoundatpos( var_1.origin, var_2._ID29613 );
    }
}

_ID34513( var_0 )
{
    self.owner endon( "a10_cannon_stop" );
    self endon( "death" );
    level endon( "game_ended" );
    var_1 = level._ID23699[var_0];

    while ( self.ammocount > 0 )
    {
        earthquake( 0.2, 0.5, self.origin, 512 );
        self.ammocount = self.ammocount - 10;
        self.owner setclientomnvar( "ui_a10_cannon", self.ammocount );
        var_2 = self gettagorigin( "tag_flash_attach" ) + 20 * anglestoforward( self.angles );
        playfx( var_1.cannonfirevfx, var_2 );
        self playrumbleonentity( var_1.cannonrumble );
        wait 0.1;
    }

    self._ID33988 turretfiredisable();
}

_ID21360( var_0, var_1 )
{
    var_1 endon( "end_remote" );
    var_1 endon( "death" );
    self endon( "death" );
    level endon( "game_ended" );
    self setclientomnvar( "ui_a10_alt_warn", 0 );

    for (;;)
    {
        var_2 = int( clamp( var_1.origin[2], 0, 16383 ) );
        self setclientomnvar( "ui_a10_alt", var_2 );

        if ( var_2 <= 1000 && !isdefined( var_1.altwarning ) )
        {
            var_1.altwarning = 1;
            self setclientomnvar( "ui_a10_alt_warn", 1 );
        }
        else if ( var_2 > 1000 && isdefined( var_1.altwarning ) )
        {
            var_1.altwarning = undefined;
            self setclientomnvar( "ui_a10_alt_warn", 0 );
        }

        wait 0.1;
    }
}

_ID36091( var_0, var_1 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "intro_cleared" );
    self setclientomnvar( "ui_a10", 1 );
    thread _ID21360( var_0, var_1 );
    thread monitorrocketfire2( var_0, var_1 );
    thread _ID21464( var_0, var_1 );
    thread _ID36121( var_1, var_0 );
    self thermalvisionfofoverlayon();
    thread _ID36062( var_1 );
}

_ID36121( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "leaving" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    level common_scripts\utility::_ID35626( "round_end_finished", "game_ended" );
    var_0 thread _ID11603( var_1 );
    _ID11763( var_1 );
    a10_explode();
}

_ID6228()
{
    var_0 = [];
    var_0[0] = 1;
    var_0[1] = 2;
    var_0[2] = 3;
    var_0[3] = 4;
    var_0[4] = 1;
    var_0[5] = 2;
    var_0[6] = 4;
    var_0[7] = 3;
    var_1 = [];
    var_1[0] = 2;
    var_1[1] = 1;
    var_1[2] = 4;
    var_1[3] = 3;
    var_1[4] = 1;
    var_1[5] = 4;
    var_1[6] = 3;
    var_1[7] = 2;
    _ID6227( var_0, var_1 );
}

_ID6227( var_0, var_1 )
{
    level._ID1946 = var_0;
    level.a10splinesout = var_1;
}

a10_cockpit_breathing()
{
    level endon( "remove_player_control" );

    for (;;)
        wait(randomfloatrange( 3.0, 7.0 ));
}

_ID36062( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "a10_end_strafe" );
    var_0 thread maps\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit();
    var_0 waittill( "killstreakExit" );
    self notify( "end_remote" );
    var_0 thread _ID11603( var_0._ID31889 );
    _ID11763( var_0._ID31889 );
    var_0 a10_explode();
}

a10_handledamage()
{
    self endon( "end_remote" );
    var_0 = level._ID23699[self._ID31889];
    maps\mp\gametypes\_damage::_ID21371( var_0.maxhealth, "helicopter", ::handledeathdamage, ::modifydamage, 1 );
}

modifydamage( var_0, var_1, var_2, var_3 )
{
    var_4 = var_3;
    var_4 = maps\mp\gametypes\_damage::handleempdamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::_ID16266( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleapdamage( var_1, var_2, var_4, var_0 );
    return var_4;
}

handledeathdamage( var_0, var_1, var_2, var_3 )
{
    var_4 = level._ID23699[self._ID31889];
    maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, var_4._ID35387, var_4._ID36472, var_4.callout );
    a10_explode();
}

a10_explode()
{
    var_0 = level._ID23699[self._ID31889];
    maps\mp\killstreaks\_plane::_ID31862( self );
    playfx( var_0.explodevfx, self.origin );
    self delete();
}
