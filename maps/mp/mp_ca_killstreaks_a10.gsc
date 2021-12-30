// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631( var_0 )
{
    level._ID1644["vfx_a10_missile_fire"] = loadfx( "vfx/moments/mp_ca_impact/vfx_a10_missile_fire" );
    var_1 = spawnstruct();
    var_1._ID21275 = [];
    var_1._ID21275["allies"] = "vehicle_ca_a10_warthog";
    var_1._ID21275["axis"] = "vehicle_ca_a10_warthog";
    var_1._ID34941 = "ca_a10warthog_mp";
    var_1.inboundsfx = "veh_mig29_dist_loop";
    var_1.speed = 750;
    var_1._ID15984 = 12500;
    var_1.heightrange = 750;
    var_1.choosedirection = 1;
    var_1._ID28034 = "KS_hqr_airstrike";
    var_1._ID17499 = "KS_ast_inbound";
    var_1.cannonfirevfx = loadfx( "fx/smoke/smoke_trail_white_heli" );
    var_1.cannonrumble = "ac130_25mm_fire";
    var_1._ID34094 = "a10_cammturret_mp";
    var_1.turretattachpoint = "tag_barrel";
    var_1._ID26358 = "iw6_a10impactmissile_mp";
    var_1._ID22418 = 4;
    var_1.delaybetweenrockets = 0.125;
    var_1.delaybetweenlockon = 0.4;
    var_1._ID20193 = "veh_hud_target_chopperfly";
    var_1.maxhealth = 10000;
    var_1._ID36472 = "destroyed_a10_strafe";
    var_1.callout = "callout_destroyed_a10";
    var_1._ID35387 = undefined;
    var_1.explodevfx = loadfx( "vfx/gameplay/explosions/vehicle/aas_mp/vfx_x_mpaas_primary" );
    var_1.sfxcannonfireloop_1p = "a10_plr_fire_gatling_lp";
    var_1._ID29618 = "a10_plr_fire_gatling_cooldown";
    var_1._ID29617 = "a10_npc_fire_gatling_lp";
    var_1._ID29619 = "a10_npc_fire_gatling_cooldown";
    var_1._ID29615 = 500;
    var_1._ID29614 = "veh_a10_npc_fire_gatling_short_burst";
    var_1._ID29613 = "veh_a10_npc_fire_gatling_long_burst";
    var_1._ID29612 = "a10_bullet_impact_lp";
    var_1._ID29623 = [];
    var_1._ID29623[0] = "veh_a10_plr_missile_ignition_left";
    var_1._ID29623[1] = "veh_a10_plr_missile_ignition_right";
    var_1.sfxmissilefire_3p = "veh_a10_npc_missile_fire";
    var_1._ID29622 = "veh_a10_missile_loop";
    var_1._ID29620 = "veh_a10_plr_engine_lp";
    var_1._ID29621 = "veh_a10_dist_loop";
    level._ID23699["ca_a10_strafe"] = var_1;
    level._ID19256["ca_a10_strafe"] = ::_ID22916;
    level.a10_active = 0;
    level.curr_a10_index = 0;

    if ( var_0 == "impact" )
        buildallflightpathsimpact();
    else
        _ID6228();

    level.debug_prints = 0;
}

_ID22916( var_0, var_1 )
{
    var_2 = level._ID23699["ca_a10_strafe"];
    level._ID19276[var_2._ID26358] = "ca_a10_strafe";
    level._ID19276[var_2._ID34094] = "ca_a10_strafe";

    if ( maps\mp\_utility::isairdenied() )
    {
        self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE_WHEN_AA" );
        return 0;
    }

    if ( isdefined( level._ID22370 ) && level._ID22370 )
    {
        self iprintlnbold( &"MP_CA_KILLSTREAKS_A10_UNAVAIL_NUKE" );
        return 0;
    }

    if ( maps\mp\_utility::_ID18715() )
    {
        self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE_FOR_N_WHEN_NUKE", level._ID22369 );
        return 0;
    }

    if ( level.a10_active || maps\mp\_utility::_ID18837() || maps\mp\_utility::_ID18678() || !isalive( self ) )
        return 0;

    if ( level._ID20086.size == 0 && !isdefined( level.chopper ) )
    {
        thread dostrike( var_0, "ca_a10_strafe" );
        return 1;
    }

    self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
    return 0;
}

dostrike( var_0, var_1 )
{
    self endon( "end_remote" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "ca_a10_nuked" );
    thread watchteamswitchpre();
    thread _ID36058();
    thread watchnukeplayer();
    var_2 = 0;
    var_3 = 1;
    var_4 = 0;
    var_5 = _ID31477( var_1, var_0 );

    if ( var_5 )
    {
        if ( level._ID32653 )
        {
            level._ID32650[self.team] = 1;
            level._ID32650[maps\mp\_utility::getotherteam( self.team )] = 1;
        }
        else
            level.airdeniedplayer = self;

        thread watchgameend();
        level.a10_active = 1;
        level thread maps\mp\_utility::_ID32672( "used_ca_a10_strafe", self, self.team );
        self.is_attacking = 0;
        var_6 = _ID30814( var_1, var_0, level._ID1946[var_2], "1" );

        if ( isdefined( var_6 ) )
        {
            thread a10_play_pilot_vo_with_wait( "mp_ca_impact_a10_pilot_01", 1.05 );
            var_6 dooneflyby();
            self.is_attacking = 0;
            self visionsetnakedforplayer( "black_bw", 0.75 );
            wait 0.8;
            self remotecontrolvehicleoff();

            if ( isdefined( var_6 ) )
            {
                var_6.forceclean = 1;
                var_6 thread _ID11603( var_1 );
            }

            var_6 = _ID30814( var_1, var_0, level._ID1946[var_3], "2" );

            if ( isdefined( var_6 ) )
            {
                thread maps\mp\killstreaks\_killstreaks::clearrideintro( 1.0, 0.125 );
                thread a10_play_pilot_vo_with_wait( "mp_ca_impact_a10_pilot_02", 0.3 );
                var_6 dooneflyby();

                if ( isdefined( var_6 ) )
                    var_6 thread _ID11603( var_1 );

                _ID11763( var_1 );
            }
        }
    }

    return var_5;
}

a10_play_pilot_vo_with_wait( var_0, var_1 )
{
    wait(var_1);
    self playlocalsound( var_0 );
}

_ID31477( var_0, var_1 )
{
    self endon( "end_remote" );
    self endon( "disconnect" );
    maps\mp\_utility::_ID29199( "ca_a10_strafe" );
    maps\mp\_utility::_ID13582( 1 );

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::_ID28902( 0 );

    self._ID26200 = self.angles;

    if ( maps\mp\_utility::_ID18666() && isdefined( self._ID18985 ) )
        self._ID18985.alpha = 0;

    var_2 = maps\mp\killstreaks\_killstreaks::_ID17993( "ca_a10_strafe" );

    if ( var_2 != "success" )
    {
        if ( var_2 != "disconnect" )
            maps\mp\_utility::_ID7513();

        if ( isdefined( self.disabledweapon ) && self.disabledweapon )
            common_scripts\utility::_enableweapon();

        self notify( "death" );
        return 0;
    }

    maps\mp\_utility::_ID13582( 0 );
    level.a10strafeactive = 1;
    self._ID34791 = 1;
    return 1;
}

_ID11763( var_0 )
{
    level endon( "game_over" );

    if ( isdefined( self ) )
    {
        if ( var_0 != "team_switch" )
        {
            while ( !isalive( self ) )
                wait 0.5;
        }

        if ( maps\mp\_utility::_ID18666() && isdefined( self._ID18985 ) )
            self._ID18985.alpha = 1;

        maps\mp\_utility::_ID13582( 0 );

        if ( maps\mp\_utility::_ID18837() )
            maps\mp\_utility::_ID7513();

        self setclientomnvar( "ui_a10", 0 );
        self setclientomnvar( "ui_a10_alt_warn", 0 );
        self setclientomnvar( "ui_a10_cannon", 0 );
        self thermalvisionfofoverlayoff();

        if ( getdvarint( "camera_thirdPerson" ) )
            maps\mp\_utility::_ID28902( 1 );

        if ( isdefined( self._ID26200 ) )
        {
            self setplayerangles( self._ID26200 );
            self._ID26200 = undefined;
        }

        thread a10_freezebuffer();
        self._ID34791 = undefined;
    }

    level.a10strafeactive = undefined;
    level.a10_active = 0;

    if ( level._ID32653 )
    {
        level._ID32650["axis"] = 0;
        level._ID32650["allies"] = 0;
    }
    else
        level.airdeniedplayer = undefined;
}

attachmissiles()
{
    var_0 = 4;

    for ( self._ID21199 = []; var_0; var_0-- )
    {
        var_1 = "tag_missile_" + var_0;
        self._ID21199[var_1] = spawn( "script_model", self gettagorigin( var_1 ) );
        self._ID21199[var_1] setmodel( "veh_ca_a10_missile" );
        self._ID21199[var_1].angles = self gettagangles( var_1 );
        self._ID21199[var_1] linkto( self, var_1 );
    }
}

attachanimatedflaps()
{
    self.animated_flaps = spawn( "script_model", self gettagorigin( "tag_origin" ) );
    self.animated_flaps setmodel( "veh_ca_a10_flaps_animated" );
    self.animated_flaps.angles = self gettagangles( "tag_origin" );
    self.animated_flaps linkto( self, "tag_origin" );
}

_ID30814( var_0, var_1, var_2, var_3 )
{
    self endon( "end_remote" );
    self endon( "disconnect" );
    self._ID23677 = createplaneasheli( var_0, var_1, var_2 );

    if ( !isdefined( self._ID23677 ) )
        return undefined;

    self._ID23677._ID31889 = var_0;
    self._ID23677 attachmissiles();
    self._ID23677 attachanimatedflaps();
    self cameralinkto( self._ID23677, "tag_player" );
    self remotecontrolvehicle( self._ID23677 );
    thread _ID36091( var_0, self._ID23677 );
    self._ID23677 setplanesplineid( self, var_2 );
    var_4 = level._ID23699[var_0];
    var_5 = "scn_impact_a10_passby_0" + var_3;
    self._ID23677 playsoundonmovingent( var_5 );
    self._ID23677.sound_name = var_5;
    self._ID23677 thread a10_handledamage();
    self._ID23677 thread watchdisconnectplane();
    return self._ID23677;
}

spawnandplaysoundfora10( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0.origin );
    var_2 setmodel( "tag_origin" );
    var_3 = "scn_impact_a10_passby_0" + var_1;
    var_2 linkto( var_0 );
    var_2 playsoundonmovingent( var_3 );
}

attachturret( var_0 )
{
    var_1 = level._ID23699[var_0];
    var_2 = self gettagorigin( var_1.turretattachpoint );
    var_3 = spawnturret( "misc_turret", self.origin + var_2, var_1._ID34094, 0 );
    var_3.angles = self gettagangles( var_1.turretattachpoint );
    var_3 linkto( self, var_1.turretattachpoint, ( 0, 0, 0 ), ( 0, 0, 0 ) );
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

    for ( var_0 = 4; var_0; var_0-- )
    {
        var_1 = "tag_missile_" + var_0;
        self._ID21199[var_1] hide();
        self._ID21199[var_1] delete();
    }

    self.animated_flaps hide();
    self.animated_flaps delete();

    if ( isdefined( self._ID32615 ) )
    {
        foreach ( var_3 in self._ID32615 )
        {
            if ( isdefined( var_3["icon"] ) )
            {
                var_3["icon"] destroy();
                var_3["icon"] = undefined;
            }
        }
    }

    self delete();
}

_ID15233()
{
    return randomint( level._ID1946.size );
}

debug_print_movement( var_0 )
{
    var_1 = "";

    if ( var_0[0] > 0 )
        var_1 += "forward";
    else if ( var_0[0] == 0 )
        var_1 += "-";
    else if ( var_0[0] < 0 )
        var_1 += "backward";

    var_1 += ", ";

    if ( var_0[1] > 0 )
        var_1 += "right";
    else if ( var_0[1] == 0 )
        var_1 += "-";
    else if ( var_0[1] < 0 )
        var_1 += "left";
}

handle_anim( var_0 )
{
    self endon( "a10_end_strafe" );
    self endon( "disconnect" );

    if ( var_0 == "left" )
        self.animated_flaps scriptmodelplayanim( "veh_ca_a10_roll_left" );

    if ( var_0 == "right" )
        self.animated_flaps scriptmodelplayanim( "veh_ca_a10_roll_right" );

    if ( var_0 == "level" )
        self.animated_flaps scriptmodelplayanim( "veh_ca_a10_roll_level" );
}

player_input_monitor()
{
    self endon( "a10_end_strafe" );
    self.owner endon( "disconnect" );

    while ( isdefined( self ) )
    {
        var_0 = self.owner getnormalizedmovement();

        if ( var_0[1] > 0 )
            thread handle_anim( "right" );
        else if ( var_0[1] == 0 )
            thread handle_anim( "level" );
        else if ( var_0[1] < 0 )
            thread handle_anim( "left" );

        wait 0.05;
    }
}

dooneflyby()
{
    self endon( "death" );
    level endon( "game_ended" );
    thread player_input_monitor();

    for (;;)
    {
        self waittill( "splinePlaneReachedNode",  var_0  );

        if ( isdefined( var_0 ) && var_0 == "End" )
        {
            self notify( "a10_end_strafe" );
            break;
        }
    }

    self.owner notify( "a10_cannon_stop" );
    self notify( "a10_cannon_stop" );
}

_ID11603( var_0 )
{
    if ( !isdefined( self ) )
        return;

    var_1 = level._ID23699[var_0];

    if ( var_0 != "disconnect" )
    {
        self.owner.is_attacking = 0;
        self.owner remotecontrolvehicleoff( self );

        if ( isdefined( self._ID33988 ) )
            self.owner remotecontrolturretoff( self._ID33988 );
    }

    self notify( "end_remote" );

    if ( !isdefined( self.forceclean ) )
        wait 5;
    else
        self stopsounds();

    if ( isdefined( self ) )
        _ID7401();
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
    self endon( "delete" );
    self waittill( "death" );
    self.forceclean = 1;
    self.owner thread _ID11763( "ca_a10_strafe" );
    thread _ID11603( "ca_a10_strafe" );
    level.a10_active = 0;
    level.a10strafeactive = undefined;
    self.owner._ID34791 = undefined;
}

a10_freezebuffer()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    maps\mp\_utility::_ID13582( 1 );
    wait 0.5;
    maps\mp\_utility::_ID13582( 0 );
}

monitorrocketfire2( var_0, var_1 )
{
    var_1 endon( "end_remote" );
    var_1 endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_2 = level._ID23699[var_0];
    var_1._ID22419 = var_2._ID22418;
    var_1._ID32615 = [];

    if ( !isbot( self ) )
    {
        self notifyonplayercommand( "rocket_fire_pressed", "+speed_throw" );
        self notifyonplayercommand( "rocket_fire_pressed", "+ads_akimbo_accessible" );

        if ( !level.console )
            self notifyonplayercommand( "rocket_fire_pressed", "+toggleads_throw" );

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
    self endon( "disconnect" );
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
    self endon( "disconnect" );
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
    self endon( "disconnect" );
    var_3 = "tag_missile_" + self._ID22419;
    var_4 = self gettagorigin( var_3 );

    if ( isdefined( var_4 ) )
    {
        var_5 = self.owner;
        var_6 = level._ID23699[var_0];
        var_7 = magicbullet( var_6._ID26358, var_4, var_4 + 100 * anglestoforward( self.angles ), self.owner );
        var_7 thread a10_missile_set_target( var_1, var_2 );
        earthquake( 0.25, 0.05, self.origin, 512 );
        self._ID22419--;
        self.owner setclientomnvar( "ui_a10_rocket", self._ID22419 );
        self playsoundonmovingent( "a10p_missile_launch" );
        playfxontag( level._ID1644["vfx_a10_missile_fire"], self, var_3 );
        self._ID21199[var_3] hide();
        return var_7;
    }

    return undefined;
}

a10_missile_set_target( var_0, var_1 )
{
    thread a10_missile_cleanup();
    wait 0.2;

    if ( isdefined( self ) && isalive( self ) )
        self missile_settargetent( var_0, var_1 );
}

a10_missile_cleanup()
{
    self waittill( "death" );

    if ( isdefined( self._ID17321 ) )
        self._ID17321 destroy();
}

bot_plane_watcher( var_0 )
{
    level.end_a10_firing = 0;
    var_0 waittill( "end_remote" );
    level.end_a10_firing = 1;
}

bot_fire_controller( var_0, var_1 )
{
    self botpressbutton( "attack" );
    thread bot_plane_watcher( var_0 );
    self.is_attacking = 1;
    var_0 thread update_hit_sound_ent();
    var_0 thread update_gatling_sound_ent();

    while ( !level.end_a10_firing )
    {
        self botpressbutton( "attack" );
        wait 0.01;
    }

    self.is_attacking = 0;
}

get_look_position()
{
    var_0 = self.origin;
    var_1 = self.angles;
    var_2 = anglestoforward( var_1 );
    var_3 = var_0 + var_2 * 7000;
    var_4 = bullettrace( var_0, var_3, 1, self );
    return var_4["position"];
}

update_hit_sound_ent()
{
    level endon( "game_ended" );
    var_0 = get_look_position();
    var_1 = spawn( "script_origin", var_0 );
    var_1 playloopsound( "a10_bullet_impact_lp" );

    while ( isdefined( self ) && self.owner.is_attacking )
    {
        var_1 moveto( get_look_position(), 0.15 );
        wait 0.01;
    }

    var_1 stoploopsound();
    var_1 delete();
}

update_gatling_sound_ent()
{
    level endon( "game_ended" );
    var_0 = self.origin;
    var_1 = spawn( "script_origin", var_0 );
    self.owner playlocalsound( "a10_plr_fire_gatling_lp" );
    var_1 playloopsound( "a10_npc_fire_gatling_lp" );

    while ( isdefined( self ) && isdefined( self.owner ) && isdefined( var_1 ) && self.owner.is_attacking )
    {
        var_1 moveto( self.origin, 0.1 );
        wait 0.01;
    }

    if ( isdefined( self ) )
        thread update_gatling_sound_release_ent();

    if ( isdefined( self ) && isdefined( self.owner ) )
        self.owner stoplocalsound( "a10_plr_fire_gatling_lp" );

    if ( isdefined( var_1 ) )
    {
        var_1 stoploopsound();
        var_1 delete();
    }
}

cutoff_gatling_sound_release()
{
    common_scripts\utility::_ID35626( "end_remote", "end_gatling" );
    self.owner stoplocalsound( "a10_plr_fire_gatling_cooldown" );
}

update_gatling_sound_release_ent()
{
    level endon( "game_ended" );
    var_0 = self.origin;
    var_1 = spawn( "script_origin", var_0 );
    thread cutoff_gatling_sound_release();
    self.owner playlocalsound( "a10_plr_fire_gatling_cooldown" );
    var_1 playsound( "a10_npc_fire_gatling_cooldown" );
    wait 2.5;

    if ( isdefined( var_1 ) )
        var_1 delete();

    self notify( "end_gatling" );
}

_ID21464( var_0, var_1 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_1 endon( "end_remote" );
    var_1 endon( "death" );
    var_1 endon( "a10_end_strafe" );
    var_2 = level._ID23699[var_0];
    var_1.ammocount = 1350;
    self setclientomnvar( "ui_a10_cannon", var_1.ammocount );

    if ( isbot( self ) )
        thread bot_fire_controller( var_1, var_2 );
    else
    {
        thread monitor_attack_button( var_1 );

        while ( var_1.ammocount > 0 )
        {
            while ( !self.is_attacking )
                wait 0.01;

            var_3 = gettime() + var_2._ID29615;
            var_1 thread update_hit_sound_ent();
            var_1 thread update_gatling_sound_ent();
            var_1 thread _ID34513( var_0 );

            while ( self.is_attacking )
                wait 0.1;
        }

        self.is_attacking = 0;
    }
}

monitor_attack_button( var_0 )
{
    var_0 endon( "a10_end_strafe" );
    self endon( "a10_end_strafe" );
    self endon( "disconnect" );
    self.is_attacking = 0;

    while ( isdefined( var_0 ) )
    {
        if ( self attackbuttonpressed() )
            self.is_attacking = 1;
        else
            self.is_attacking = 0;

        wait 0.1;
    }
}

_ID34513( var_0 )
{
    self.owner endon( "a10_cannon_stop" );
    self.owner endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    var_1 = level._ID23699[var_0];

    while ( self.ammocount > 0 && self.owner.is_attacking && isdefined( self ) )
    {
        earthquake( 0.2, 0.5, self.origin, 512 );
        self.ammocount = self.ammocount - 10;
        self.owner setclientomnvar( "ui_a10_cannon", self.ammocount );
        var_2 = self gettagorigin( "tag_flash_attach" ) + 20 * anglestoforward( self.angles );
        playfx( var_1.cannonfirevfx, var_2 );
        self.owner playrumbleonentity( var_1.cannonrumble );
        wait 0.1;
    }

    if ( isdefined( self ) )
    {
        if ( isdefined( self._ID33988 ) )
            self._ID33988 turretfiredisable();
    }
}

_ID21360( var_0, var_1 )
{
    var_1 endon( "end_remote" );
    var_1 endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self setclientomnvar( "ui_a10_alt_warn", 0 );

    for (;;)
    {
        var_2 = int( clamp( var_1.origin[2], 0, 16383 ) );
        self setclientomnvar( "ui_a10_alt", var_2 );

        if ( var_2 <= 10 && !isdefined( var_1.altwarning ) )
        {
            var_1.altwarning = 1;
            self setclientomnvar( "ui_a10_alt_warn", 1 );
        }
        else if ( var_2 > 10 && isdefined( var_1.altwarning ) )
        {
            var_1.altwarning = undefined;
            self setclientomnvar( "ui_a10_alt_warn", 0 );
        }

        wait 0.1;
    }
}

watchdisconnectplane()
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    self endon( "end_remote" );
    self.owner waittill( "disconnect" );
    self.forceclean = 1;
    thread a10_explode();
    thread _ID11603( "disconnect" );
    thread _ID11763( "ca_a10_strafe" );
}

_ID36058()
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    self endon( "cleared_intro" );
    self waittill( "disconnect" );

    if ( isdefined( self ) && isdefined( self._ID23677 ) )
    {
        self._ID23677.forceclean = 1;
        self._ID23677 thread _ID11603( "ca_a10_strafe" );
    }

    if ( isdefined( self ) )
        _ID11763( "team_switch" );
}

watchgameend()
{
    level endon( "round_end_finished" );
    self endon( "end_remote" );
    level waittill( "game_ended" );
    self notify( "a10_end_strafe" );

    if ( isdefined( self ) && isdefined( self._ID23677 ) )
    {
        self._ID23677.forceclean = 1;
        self._ID23677 thread _ID11603( "ca_a10_strafe" );
    }

    if ( isdefined( self ) )
        _ID11763( "team_switch" );
}

watchteamswitchpre()
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    self endon( "cleared_intro" );
    common_scripts\utility::_ID35626( "joined_team", "joined_spectators" );
    self notify( "switch_team" );
    self notify( "end_remote" );

    if ( isdefined( self._ID23677 ) )
    {
        self._ID23677.forceclean = 1;
        self._ID23677 thread _ID11603( "ca_a10_strafe" );
    }

    _ID11763( "team_switch" );
}

_ID36091( var_0, var_1 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "end_remote" );
    self waittill( "intro_cleared" );
    thread _ID21360( var_0, var_1 );
    thread monitorrocketfire2( var_0, var_1 );
    thread _ID21464( var_0, var_1 );
    thread _ID36121( var_1, var_0 );
    thread _ID36062( var_1 );
    thread watchnuke( var_1, "ca_a10_strafe" );
    thread watchteamswitchpost( var_1, "ca_a10_strafe" );
    self setclientomnvar( "ui_a10", 1 );
    self thermalvisionfofoverlayon();
}

_ID36062( var_0 )
{
    level endon( "round_end_finished" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "a10_end_strafe" );
    var_0 thread maps\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit( "killstreakExit" );
    var_0 waittill( "killstreakExit" );
    self notify( "end_remote" );
    var_0 notify( "end_remote" );
    var_0.forceclean = 1;
    var_0 thread a10_explode();
    thread _ID11763( "ca_a10_strafe" );
    var_0 thread _ID11603( "ca_a10_strafe" );
}

watchnukeplayer()
{
    self endon( "disconnect" );
    self endon( "end_remote" );
    level waittill( "nuke_death" );
    self notify( "ca_a10_nuked" );
    thread _ID11763( "ca_a10_strafe" );
}

watchnuke( var_0, var_1 )
{
    var_0 endon( "a10_end_strafe" );
    self endon( "disconnect" );
    self endon( "end_remote" );
    level waittill( "nuke_death" );
    self notify( "ca_a10_nuked" );
    thread _ID11763( "ca_a10_strafe" );

    if ( isdefined( var_0 ) )
    {
        var_0.forceclean = 1;
        var_0 thread a10_explode();
        var_0 thread _ID11603( "ca_a10_strafe" );
    }
}

watchteamswitchpost( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "leaving" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    self notify( "cleared_intro" );
    common_scripts\utility::_ID35626( "joined_team", "joined_spectators" );
    self notify( "a10_end_strafe" );
    self notify( "end_remote" );
    var_0.forceclean = 1;
    thread _ID11763( "team_switch" );
    var_0 thread a10_explode();
    var_0 thread _ID11603( var_1 );
}

_ID36121( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "leaving" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    level common_scripts\utility::_ID35626( "round_end_finished", "game_ended" );
    var_0.forceclean = 1;
    var_0 thread _ID11603( var_1 );
    var_0 thread a10_explode();
    _ID11763( "team_switch" );
}

buildallflightpathsimpact()
{
    var_0 = [];
    var_0[0] = 1;
    var_0[1] = 2;
    var_1 = [];
    var_1[0] = 1;
    var_1[1] = 2;
    _ID6227( var_0, var_1 );
}

_ID6228()
{
    var_0 = [];
    var_0[0] = 1;
    var_0[1] = 1;
    var_1 = [];
    var_1[0] = 1;
    var_1[1] = 1;
    _ID6227( var_0, var_1 );
}

_ID6227( var_0, var_1 )
{
    level._ID1946 = var_0;
    level.a10splinesout = var_1;
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
    thread a10_explode();
}

a10_explode()
{
    if ( isdefined( self ) )
    {
        var_0 = level._ID23699[self._ID31889];
        playfx( var_0.explodevfx, self.origin );
        self hide();
        wait 20.0;
    }
}
