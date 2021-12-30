// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    _ID29018();
    setup_heli_range();
    common_scripts\utility::_ID13189( "player_using_vanguard" );
    createthreatbiasgroup( "vanguard" );
    setignoremegroup( "vanguard", "dontattackdrill" );

    for ( var_0 = 1; var_0 <= 2; var_0++ )
        thread vanguard_activate_wait_for_access_notify( var_0 );
}

vanguard_activate_wait_for_access_notify( var_0 )
{
    level waittill( "alien_vanguard_access_0" + var_0 );
    var_1 = getent( "alien_vanguard_blocker_0" + var_0, "targetname" );
    var_1 makeusable();
    var_1 setcursorhint( "HINT_ACTIVATE" );
    var_1 sethintstring( &"MP_ALIEN_DESCENT_VANGUARD_ACTIVATE" );
    var_2 = newhudelem();
    var_2 setshader( "waypoint_alien_vanguard", 20, 20 );
    var_2.color = ( 1, 1, 1 );
    var_2 setwaypoint( 1, 1 );
    var_2.sort = 1;
    var_2.foreground = 1;
    var_2.alpha = 0.5;
    var_2.x = var_1.origin[0];
    var_2.y = var_1.origin[1];
    var_2.z = var_1.origin[2];
    var_2 thread alien_vanguard_wait_and_cleanup( var_1, var_0 );
    var_1 thread vanguard_activate_think( var_1, var_0, var_2 );
}

_ID29018()
{
    level._ID34853["hit"] = loadfx( "fx/impacts/large_metal_painted_hit" );
    level._ID34853["smoke"] = loadfx( "fx/smoke/remote_heli_damage_smoke_runner" );
    level._ID34853["explode"] = loadfx( "vfx/gameplay/explosions/vehicle/vang/vfx_exp_vanguard" );
    level._ID34853["target_marker_circle"] = loadfx( "vfx/gameplay/mp/core/vfx_marker_gryphon_orange" );
}

setup_heli_range()
{
    level._ID34883 = 1800;
    level.vanguardmaxdistancesq = 163840000;
    level._ID38248 = getentarray( "remote_heli_range", "targetname" );
    level._ID34884 = getent( "airstrikeheight", "targetname" );

    if ( isdefined( level._ID34884 ) )
        level._ID34883 = level._ID34884.origin[2];
}

alien_vanguard_wait_and_cleanup( var_0, var_1 )
{
    level waittill( "blocker_0" + var_1 + "_destroyed" );
    maps\mp\alien\_outline_proto::disable_outline_for_players( var_0, level.players );
    self destroy();
}

vanguard_activate_think( var_0, var_1, var_2 )
{
    level endon( "blocker_0" + var_1 + "_destroyed" );

    for (;;)
    {
        maps\mp\alien\_outline_proto::enable_outline_for_players( var_0, level.players, 2, 0, "high" );
        var_2.alpha = 0.5;
        var_0 sethintstring( &"MP_ALIEN_DESCENT_VANGUARD_ACTIVATE" );

        foreach ( var_4 in level.players )
        {
            if ( isdefined( var_4._ID20385 ) )
                var_4 maps\mp\_utility::setlowermessage( "vanguard_use_hint", &"MP_ALIEN_DESCENT_VANGUARD_USE_HINT", 3.5 );
        }

        for (;;)
        {
            self waittill( "trigger",  var_4  );
            var_4.vanguard_num = var_1;

            if ( var_4 maps\mp\alien\_unk1464::_ID18431() || maps\mp\alien\_unk1464::_ID18506( var_4._ID18582 ) || maps\mp\alien\_unk1464::_ID18506( var_4.has_special_weapon ) )
            {
                var_4 maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HOLDING", 3 );
                continue;
            }

            if ( var_4 getstance() == "prone" || var_4 getstance() == "crouch" )
            {
                var_4 maps\mp\_utility::setlowermessage( "change_stance", &"ALIENS_PATCH_CHANGE_STANCE", 3 );
                continue;
            }

            if ( !isalive( var_4 ) || !var_4 isonground() || maps\mp\alien\_unk1464::_ID18506( var_4.laststand ) || maps\mp\alien\_unk1464::_ID18506( var_4._ID23541 ) )
                continue;

            var_4.player_action_disabled = 1;
            var_4 maps\mp\_utility::_ID13582( 1 );
            var_4 common_scripts\utility::_disableusability();

            if ( isplayer( var_4 ) )
                break;
        }

        maps\mp\alien\_outline_proto::disable_outline_for_players( var_0, level.players );
        var_2.alpha = 0;
        var_0 sethintstring( "" );
        level notify( "alien_vanguard_0" + var_1 + "_triggered" );
        var_6 = ( 0, 0, 0 );

        switch ( var_1 )
        {
            case 1:
                var_6 = var_4 find_valid_vanguard_spawn_point( 80, 150 );
                break;
            case 2:
                var_6 = var_4 find_valid_vanguard_spawn_point( 80, 35 );
                break;
        }

        if ( isdefined( var_6 ) )
        {
            var_7 = create_vanguard( var_4, var_6 );
            var_4 thread start_vanguard( var_7 );
            var_7 waittill( "death" );
            maps\mp\alien\_outline_proto::enable_outline_for_players( var_0, level.players, 1, 0, "high" );
            maps\mp\gametypes\_hostmigration::_ID35597( 15 );
            continue;
        }

        wait 0.05;
        var_4 maps\mp\_utility::_ID13582( 0 );
        var_4 common_scripts\utility::_enableusability();
    }
}

find_valid_vanguard_spawn_point( var_0, var_1 )
{
    var_2 = anglestoforward( self.angles );
    var_3 = anglestoright( self.angles );
    var_4 = self geteye();
    var_5 = var_4 + ( 0, 0, var_1 );
    var_6 = var_5 - var_0 * var_2;

    if ( check_vanguard_spawn_point( var_4, var_6 ) )
        return var_6;

    var_6 = var_5 + var_0 * var_2;

    if ( check_vanguard_spawn_point( var_4, var_6 ) )
        return var_6;

    var_6 += var_0 * var_3;

    if ( check_vanguard_spawn_point( var_4, var_6 ) )
        return var_6;

    var_6 = var_5 - var_0 * var_3;

    if ( check_vanguard_spawn_point( var_4, var_6 ) )
        return var_6;

    var_6 = var_5;

    if ( check_vanguard_spawn_point( var_4, var_6 ) )
        return var_6;

    common_scripts\utility::_ID35582();
    var_6 = var_5 + 0.707 * var_0 * ( var_2 + var_3 );

    if ( check_vanguard_spawn_point( var_4, var_6 ) )
        return var_6;

    var_6 = var_5 + 0.707 * var_0 * ( var_2 - var_3 );

    if ( check_vanguard_spawn_point( var_4, var_6 ) )
        return var_6;

    var_6 = var_5 + 0.707 * var_0 * ( var_3 - var_2 );

    if ( check_vanguard_spawn_point( var_4, var_6 ) )
        return var_6;

    var_6 = var_5 + 0.707 * var_0 * ( -1 * var_2 - var_3 );

    if ( check_vanguard_spawn_point( var_4, var_6 ) )
        return var_6;

    return undefined;
}

find_vanguard_spawn_angles()
{
    var_0 = ( 0, 0, 0 );

    foreach ( var_2 in level.scanned_obelisks )
        var_0 += var_2.scriptables[0].origin;

    var_0 /= level.scanned_obelisks.size;
    return vectortoangles( var_0 - self geteye() );
}

check_vanguard_spawn_point( var_0, var_1 )
{
    var_2 = 0;

    if ( capsuletracepassed( var_1, 10, 20.01, undefined, 1, 1 ) )
        var_2 = bullettracepassed( var_0, var_1, 0, undefined );

    return var_2;
}

alien_vanguard_handle_threatbias( var_0, var_1 )
{
    if ( maps\mp\alien\_unk1464::_ID18506( var_1 ) )
    {
        if ( isdefined( self ) )
        {
            if ( isdefined( self.threatbias ) )
                self.threatbias = self.threatbias + 10000;

            self.ignoreme = 0;
        }
    }
    else
    {
        setthreatbias( "vanguard", "spitters", 10000 );

        if ( isdefined( self ) )
        {
            if ( isdefined( self.threatbias ) )
                self.threatbias = self.threatbias - 10000;

            self.ignoreme = 1;
        }
    }
}

start_vanguard( var_0 )
{
    var_1 = 0.25;
    thread _ID37504( var_1 );
    wait(var_1);
    self._ID26200 = self.angles;

    if ( self.vanguard_num == 1 )
    {
        var_2 = find_vanguard_spawn_angles();
        self setplayerangles( var_2 );
        var_0.angles = var_2;
    }

    maps\mp\_utility::_ID29199( "alien_vanguard" );
    alien_vanguard_handle_threatbias( var_0 );

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::_ID28902( 0 );

    var_0 enableaimassist();
    var_0._ID24519 = 1;
    self cameralinkto( var_0, "tag_origin" );
    self remotecontrolvehicle( var_0 );
    var_0.ammocount = 100;
    self._ID25826 = var_0;
    maps\mp\_utility::_giveweapon( "killstreak_remote_tank_remote_mp" );
    self switchtoweaponimmediate( "killstreak_remote_tank_remote_mp" );
    maps\mp\_utility::_ID13582( 0 );
    var_3 = initride();

    if ( var_3 != "success" )
    {
        var_0 notify( "death" );
        return 0;
    }
    else if ( !isdefined( var_0 ) )
        return 0;

    maps\mp\_utility::_ID13582( 0 );
    common_scripts\utility::_enableusability();
    thread _ID34877( var_0 );
    thread _ID34861( var_0 );
    thread _ID34863( var_0 );
    thread _ID34879( var_0 );
    var_0 thread _ID34871();
    thread bubble_fx();
    level notify( "vanguard_used" );
    self notify( "vanguard_used" );
    common_scripts\utility::flag_set( "player_using_vanguard" );
    maps\mp\alien\_outline_proto::enable_outline_for_player( self, self, 3, 0, "high" );
    return 1;
}

bubble_fx()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 = 36;
    var_1 = spawnfx( level._ID1644["vanguard_shield"], self.origin + ( 0, 0, 1 ) * var_0 );
    triggerfx( var_1 );
    thread disconnect_delete( var_1, "end_remote" );
    self waittill( "end_remote" );
    wait 0.1;
    var_1 delete();
}

disconnect_delete( var_0, var_1 )
{
    self endon( var_1 );
    common_scripts\utility::_ID35626( "disconnect", "death" );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

_ID37504( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18506( self.isferal ) )
        _ID36637::_ID37063();

    if ( isdefined( self.camfx ) )
        self.camfx delete();

    self visionsetnakedforplayer( "black_bw", var_0 );
    thread maps\mp\_utility::set_visionset_for_watching_players( "black_bw", var_0, 1.5, undefined, 1 );
    level waittill( "vanguard_used" );

    if ( !isdefined( self.vanguard_hint_shown ) )
    {
        self.vanguard_hint_shown = 1;
        maps\mp\_utility::setlowermessage( "vanguard_use_hint", &"MP_ALIEN_DESCENT_VANGUARD_USE_HINT", 4.0 );
    }

    self visionsetnakedforplayer( "", var_0 );
    thread maps\mp\_utility::set_visionset_for_watching_players( "", var_0 );
    self thermalvisionfofoverlayon();
    self setclientomnvar( "ui_vanguard", 1 );
}

initride()
{
    var_0 = initride_internal();
    return var_0;
}

initride_internal()
{
    var_0 = common_scripts\utility::_ID35637( 1.0, "disconnect", "death" );
    maps\mp\gametypes\_hostmigration::_ID35770();

    if ( !isalive( self ) )
        return "fail";

    if ( var_0 == "disconnect" || var_0 == "death" )
    {
        if ( var_0 == "disconnect" )
            return "disconnect";

        if ( self.team == "spectator" )
            return "fail";

        return "success";
    }

    maps\mp\gametypes\_hostmigration::_ID35770();

    if ( !isalive( self ) )
        return "fail";

    return "success";
}

_ID34866( var_0 )
{
    if ( !isdefined( var_0.lasttouchedplatform.destroydroneoncollision ) || var_0.lasttouchedplatform.destroydroneoncollision || !isdefined( self.spawngraceperiod ) || gettime() > self.spawngraceperiod )
        self notify( "death" );
}

create_vanguard( var_0, var_1 )
{
    var_2 = spawnhelicopter( var_0, var_1, var_0.angles, "remote_alien_uav_mp", "vehicle_drone_vanguard" );
    level.alien_vanguard = var_2;

    if ( !isdefined( var_2 ) )
        return undefined;

    var_2 makevehiclesolidcapsule( 20, -5, 10 );
    var_2._ID4081 = spawn( "script_model", ( 0, 0, 0 ) );
    var_2._ID4081 setmodel( "tag_origin" );
    var_2._ID4081.angles = ( -90, 0, 0 );
    var_2._ID4081.offset = 4;
    var_3 = spawnturret( "misc_turret", var_2.origin, "ball_drone_gun_mp", 0 );
    var_3 linkto( var_2, "tag_turret_attach", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_3 setmodel( "vehicle_drone_vanguard_gun_dlc3" );
    var_3 maketurretinoperable();
    var_2._ID33988 = var_3;
    var_3 makeunusable();
    var_2.team = var_0.team;
    var_2.pers["team"] = var_0.team;
    var_2.owner = var_0;
    var_2 thread makesentient( var_0.team );

    if ( issentient( var_2 ) )
        var_2 setthreatbiasgroup( "vanguard" );

    var_4 = missile_createattractorent( var_2, 1000, 8000 );
    var_2.health = 999999;
    var_2.maxhealth = 100;
    var_2.damagetaken = 0;
    var_0 setclientomnvar( "ui_vanguard_health", 100 );
    var_2._ID30272 = 0;
    var_2._ID17629 = 0;
    var_2._ID16760 = "remote_uav";
    var_3.owner = var_0;
    var_3 setentityowner( var_2 );
    var_3 thread maps\mp\gametypes\_weapons::doblinkinglight( "tag_fx1" );
    var_3._ID23270 = var_2;
    var_3.health = 999999;
    var_3.maxhealth = 100;
    var_3.damagetaken = 0;
    var_0 thread vanguard_handledisconnect( var_2, "end_remote" );
    var_2 thread vanguard_handlestopusing();
    var_2 thread vanguard_handlesequencecompletestopusing();
    level thread _ID34860( var_2 );
    level thread _ID34864( var_2 );
    var_2 thread _ID34880();
    var_2 thread _ID34855();
    var_2._ID33988 thread _ID34878();
    var_2 thread _ID36063();
    var_5 = spawnstruct();
    var_5._ID34837 = 1;
    var_5.deathoverridecallback = ::_ID34866;
    var_2 thread maps\mp\_movers::_ID16165( var_5 );
    level._ID25810[var_2.team] = var_2;
    return var_2;
}

print_dmg()
{
    self endon( "death" );

    for (;;)
    {
        iprintlnbold( self.damagetaken );
        wait 0.2;
    }
}

makesentient( var_0 )
{
    self makeentitysentient( var_0 );
    self waittill( "death" );

    if ( isdefined( self ) )
        self freeentitysentient();
}

_ID34863( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );
    var_1 = 3;
    wait(var_1);

    for (;;)
    {
        var_2 = 0;

        while ( var_0.owner usebuttonpressed() )
        {
            var_2 += 0.05;

            if ( var_2 > 0.75 )
            {
                var_0 notify( "death" );
                return;
            }

            wait 0.05;
        }

        wait 0.05;
    }
}

_ID34879( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );

    while ( !isdefined( var_0._ID4081 ) )
        wait 0.05;

    var_0 setotherent( var_0._ID4081 );
    var_0 setturrettargetent( var_0._ID4081 );
}

_ID34877( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );

    for (;;)
    {
        if ( var_0 maps\mp\_utility::_ID33165( "gryphon" ) )
            var_0 notify( "damage",  1019, self, self.angles, self.origin, "MOD_EXPLOSIVE", undefined, undefined, undefined, undefined, "c4_mp"  );

        self._ID20184 = var_0._ID4081.origin;
        common_scripts\utility::_ID35582();
    }
}

_ID34871()
{
    common_scripts\utility::_ID35582();
    playfxontagforclients( level._ID34853["target_marker_circle"], self._ID4081, "tag_origin", self.owner );
}

_ID15396( var_0, var_1 )
{
    var_2 = var_1._ID33988 gettagorigin( "tag_flash" );
    var_3 = var_0 getplayerangles();
    var_4 = anglestoforward( var_3 );
    var_5 = var_2 + var_4 * 15000;
    var_6 = bullettrace( var_2, var_5, 0, var_1 );

    if ( var_6["surfacetype"] == "none" )
        return undefined;

    if ( var_6["surfacetype"] == "default" )
        return undefined;

    var_7 = var_6["entity"];
    var_8 = [];
    var_8[0] = var_6["position"];
    var_8[1] = var_6["normal"];
    return var_8;
}

_ID34861( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );
    self notifyonplayercommand( "vanguard_fire_missile", "+attack" );
    self notifyonplayercommand( "vanguard_fire_missile", "+attack_akimbo_accessible" );

    if ( !level.console )
    {

    }

    thread vanguard_monitormissile( var_0 );
    thread vanguard_monitorbullet( var_0 );
}

vanguard_monitormissile( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );
    var_0.missile_ready_time = gettime();

    for (;;)
    {
        self waittill( "vanguard_fire_missile" );
        maps\mp\gametypes\_hostmigration::_ID35770();

        if ( isdefined( level.hostmigrationtimer ) )
            continue;

        if ( isdefined( self._ID20184 ) && gettime() >= var_0.missile_ready_time )
            thread _ID34851( var_0, self._ID20184 );
    }
}

vanguard_monitorbullet( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );
    var_0.bullet_ready_time = gettime();

    for (;;)
    {
        if ( self adsbuttonpressed() )
        {
            maps\mp\gametypes\_hostmigration::_ID35770();

            if ( isdefined( level.hostmigrationtimer ) )
                continue;

            if ( isdefined( self._ID20184 ) && gettime() >= var_0.bullet_ready_time )
                thread vanguard_firebullet( var_0, self._ID20184 );
        }

        wait 0.05;
    }
}

_ID34874( var_0, var_1, var_2 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );
    var_0 notify( "end_rumble" );
    var_0 endon( "end_rumble" );

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        self playrumbleonentity( var_1 );
        common_scripts\utility::_ID35582();
    }
}

vanguard_firebullet( var_0, var_1 )
{
    level endon( "game_ended" );
    var_2 = var_0._ID33988 gettagorigin( "tag_fire" );
    var_2 += ( 0, 0, -25 );

    if ( distancesquared( var_2, var_1 ) < 10000 )
    {
        var_0 playsoundtoplayer( "weap_vanguard_fire_deny", self );
        return;
    }

    thread _ID34874( var_0, "pistol_fire", 1 );
    var_3 = magicbullet( "alienvanguard_projectile_mini_mp", var_2, var_1, self );
    var_3._ID35007 = var_0;
    var_4 = 500;
    var_0.bullet_ready_time = gettime() + var_4;
    var_3 maps\mp\gametypes\_hostmigration::_ID35709( "death", 4 );
}

_ID34851( var_0, var_1 )
{
    level endon( "game_ended" );

    if ( var_0.ammocount <= 0 )
        return;

    var_2 = var_0._ID33988 gettagorigin( "tag_fire" );
    var_2 += ( 0, 0, -25 );

    if ( distancesquared( var_2, var_1 ) < 10000 )
    {
        var_0 playsoundtoplayer( "weap_vanguard_fire_deny", self );
        return;
    }

    var_0.ammocount--;
    thread _ID34874( var_0, "shotgun_fire", 1 );
    earthquake( 0.3, 0.25, var_0.origin, 60 );
    var_3 = magicbullet( "alienvanguard_projectile_mp", var_2, var_1, self );
    var_3._ID35007 = var_0;
    var_4 = 3000;
    var_0.missile_ready_time = gettime() + var_4;
    thread _ID38236( var_0, var_4 * 0.001 );
    var_3 maps\mp\gametypes\_hostmigration::_ID35709( "death", 4 );
    earthquake( 0.3, 0.75, var_1, 128 );

    if ( isdefined( var_0 ) )
    {
        earthquake( 0.25, 0.75, var_0.origin, 60 );
        thread _ID34874( var_0, "damage_heavy", 3 );

        if ( var_0.ammocount == 0 )
        {
            wait 0.75;
            var_0 notify( "death" );
        }
    }
}

_ID38236( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );
    self setclientomnvar( "ui_vanguard_ammo", -1 );
    wait(var_1);
    self setclientomnvar( "ui_vanguard_ammo", var_0.ammocount );
}

_ID15370( var_0, var_1 )
{
    var_2 = ( 3000, 3000, 3000 );
    var_3 = vectornormalize( var_0.origin - var_1 + ( 0, 0, -400 ) );
    var_4 = rotatevector( var_3, ( 0, 25, 0 ) );
    var_5 = var_1 + var_4 * var_2;

    if ( _ID18858( var_5, var_1 ) )
        return var_5;

    var_4 = rotatevector( var_3, ( 0, -25, 0 ) );
    var_5 = var_1 + var_4 * var_2;

    if ( _ID18858( var_5, var_1 ) )
        return var_5;

    var_5 = var_1 + var_3 * var_2;

    if ( _ID18858( var_5, var_1 ) )
        return var_5;

    return var_1 + ( 0, 0, 3000 );
}

_ID18858( var_0, var_1 )
{
    var_2 = bullettrace( var_0, var_1, 0 );

    if ( var_2["fraction"] > 0.99 )
        return 1;

    return 0;
}

_ID34880()
{
    self endon( "death" );
    var_0 = self.origin;
    self._ID25414 = 0;

    for (;;)
    {
        if ( !isdefined( self ) )
            return;

        if ( !isdefined( self.owner ) )
            return;

        if ( !_ID34856() )
        {
            while ( !_ID34856() )
            {
                if ( !isdefined( self ) )
                    return;

                if ( !isdefined( self.owner ) )
                    return;

                if ( !self._ID25414 )
                {
                    self._ID25414 = 1;
                    thread _ID34869();
                }

                if ( isdefined( self._ID16734 ) )
                    var_1 = distance( self.origin, self._ID16734.origin );
                else
                    var_1 = distance( self.origin, var_0 );

                var_2 = _ID37365( var_1 );
                self.owner setclientomnvar( "ui_vanguard", var_2 );
                wait 0.15;
            }

            self notify( "in_range" );
            self._ID25414 = 0;
            self.owner setclientomnvar( "ui_vanguard", 1 );
        }

        var_3 = int( angleclamp( self.angles[1] ) );
        self.owner setclientomnvar( "ui_vanguard_heading", var_3 );
        var_4 = self.origin[2] * 0.0254;
        var_4 = int( clamp( var_4, -250, 250 ) );
        self.owner setclientomnvar( "ui_vanguard_altitude", var_4 );
        var_5 = distance2d( self.origin, self._ID4081.origin ) * 0.0254;
        var_5 = int( clamp( var_5, 0, 256 ) );
        self.owner setclientomnvar( "ui_vanguard_range", var_5 );
        var_0 = self.origin;
        wait 0.15;
    }
}

_ID37365( var_0 )
{
    var_0 = clamp( var_0, 50, 550 );
    return 2 + int( 8 * ( var_0 - 50 ) / 500 );
}

_ID34856()
{
    if ( isdefined( self._ID17629 ) && self._ID17629 )
        return 0;

    if ( isdefined( level._ID38248[0] ) )
    {
        foreach ( var_1 in level._ID38248 )
        {
            if ( self istouching( var_1 ) )
                return 0;
        }

        return 1;
    }
    else if ( distance2dsquared( self.origin, level._ID20634 ) < level.vanguardmaxdistancesq && self.origin[2] < level._ID34883 )
        return 1;

    return 0;
}

_ID34869()
{
    self endon( "death" );
    self endon( "in_range" );
    var_0 = 3;
    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    self notify( "death",  "range_death"  );
}

vanguard_handledisconnect( var_0, var_1 )
{
    self endon( var_1 );
    self endon( "death" );
    self waittill( "disconnect" );
    var_0 notify( "death" );
}

vanguard_handlestopusing()
{
    self endon( "death" );
    self.owner waittill( "stop_using_remote" );
    self notify( "death" );
}

vanguard_handlesequencecompletestopusing()
{
    self endon( "death" );
    level waittill( "descent_door_complete" );
    self.sequence_complete = 1;
    self notify( "death" );
}

_ID34860( var_0 )
{
    level endon( "game_ended" );
    level endon( "objective_cam" );
    var_1 = var_0._ID33988;
    var_0 waittill( "death" );
    var_0 maps\mp\gametypes\_weapons::_ID31835();
    stopfxontag( level._ID34853["target_marker_circle"], var_0._ID4081, "tag_origin" );
    playfx( level._ID34853["explode"], var_0.origin );
    var_0 playsound( "ball_drone_explode" );
    var_1 delete();

    if ( isdefined( var_0._ID32604 ) )
        var_0._ID32604 delete();

    _ID34850( var_0.owner, var_0 );
}

_ID34864( var_0 )
{
    var_0 endon( "death" );
    level common_scripts\utility::_ID35626( "objective_cam", "game_ended" );
    playfx( level._ID34853["explode"], var_0.origin );
    var_0 playsound( "ball_drone_explode" );
    _ID34850( var_0.owner, var_0 );
}

_ID34850( var_0, var_1 )
{
    var_1 notify( "end_remote" );
    var_0 notify( "end_remote" );
    var_1._ID24519 = 0;
    var_1 setotherent( undefined );
    _ID34870( var_0, var_1 );
    stopfxontag( level._ID34853["smoke"], var_1, "tag_origin" );
    level._ID25810[var_1.team] = undefined;
    maps\mp\_utility::decrementfauxvehiclecount();
    common_scripts\utility::_ID13180( "player_using_vanguard" );
    var_1._ID4081 delete();
    var_1 delete();
    level.alien_vanguard = undefined;
}

_ID26212()
{
    self visionsetnakedforplayer( "", 1 );
    maps\mp\_utility::set_visionset_for_watching_players( "", 1 );
}

_ID34870( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_0 maps\mp\_utility::_ID7513();
    var_0 _ID26212();
    var_0 setclientomnvar( "ui_vanguard", 0 );

    if ( getdvarint( "camera_thirdPerson" ) )
        var_0 maps\mp\_utility::_ID28902( 1 );

    var_0 cameraunlink( var_1 );
    var_0 remotecontrolvehicleoff( var_1 );
    var_0 thermalvisionfofoverlayoff();

    if ( maps\mp\alien\_unk1464::_ID18506( var_1.sequence_complete ) )
    {
        var_2 = getent( "blocker_0" + var_0.vanguard_num + "_door", "targetname" );
        var_0 setplayerangles( vectortoangles( var_2.origin + ( 0, 0, 150 ) - var_0 geteye() ) );
    }
    else
    {
        var_3 = getent( "alien_vanguard_blocker_0" + var_0.vanguard_num, "targetname" );
        var_0 setplayerangles( vectortoangles( var_3.origin - var_0 geteye() ) );
    }

    var_0._ID25826 = undefined;
    var_0.vanguard_num = undefined;

    if ( var_0.team == "spectator" )
        return;

    var_0 alien_vanguard_handle_threatbias( var_1, 1 );
    maps\mp\alien\_outline_proto::disable_outline_for_player( var_0, var_0 );
    var_0.player_action_disabled = undefined;
    level thread _ID34852( var_0 );
}

_ID34852( var_0 )
{
    var_0 endon( "disconnect" );
    var_0 endon( "death" );
    level endon( "game_ended" );
    var_0 maps\mp\_utility::_ID13582( 1 );
    wait 0.5;
    var_0 maps\mp\_utility::_ID13582( 0 );
}

_ID34855()
{
    level endon( "game_ended" );
    self.owner endon( "disconnect" );
    self endon( "death" );
    self endon( "end_remote" );
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( isdefined( var_1.team ) && self.team == var_1.team )
            continue;

        var_10 = modifydamage( var_1, var_9, var_4, var_0 );
        var_10 = int( var_10 );
        maps\mp\alien\_unk1443::_ID38222( "gryphon", "damage_on_gryphon", var_10 );
        self._ID35908 = 1;
        self.damagetaken = self.damagetaken + var_10;
        self.owner thread _ID34874( self, "damage_heavy", 3 );

        if ( self.damagetaken >= self.maxhealth )
        {
            self.owner maps\mp\_utility::setlowermessage( "vanguard_death", &"MP_ALIEN_DESCENT_VANGUARD_DESTROYED", 3.5 );
            self notify( "death" );
            continue;
        }

        self.owner setclientomnvar( "ui_vanguard_health", self.maxhealth - self.damagetaken );

        if ( self.damagetaken >= self.maxhealth / 2 )
            level notify( "dlc_vo_notify",  "descent_vo", "defend_vanguard"  );
    }
}

_ID34878()
{
    level endon( "game_ended" );
    self._ID23270.owner endon( "disconnect" );
    self._ID23270 endon( "death" );
    self._ID23270 endon( "end_remote" );
    self endon( "death" );
    self maketurretsolid();
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( isdefined( var_1.team ) && self._ID23270.team == var_1.team )
            continue;

        var_10 = self._ID23270 modifydamage( var_1, var_9, var_4, var_0 );
        var_10 = int( var_10 );
        maps\mp\alien\_unk1443::_ID38222( "gryphon", "damage_on_gryphon", var_10 );
        self._ID23270._ID35908 = 1;
        self._ID23270.damagetaken = self._ID23270.damagetaken + var_10;
        self._ID23270.owner thread _ID34874( self._ID23270, "damage_heavy", 3 );

        if ( self._ID23270.damagetaken >= self._ID23270.maxhealth )
        {
            self._ID23270.owner maps\mp\_utility::setlowermessage( "vanguard_death", &"MP_ALIEN_DESCENT_VANGUARD_DESTROYED", 3.5 );
            self._ID23270 notify( "death" );
            continue;
        }

        self._ID23270.owner setclientomnvar( "ui_vanguard_health", self._ID23270.maxhealth - self._ID23270.damagetaken );
    }
}

modifydamage( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );
    self.owner endon( "disconnect" );
    self endon( "death" );
    self endon( "end_remote" );

    if ( !isdefined( var_3 ) )
        return 0;

    var_4 = var_3;

    if ( var_2 == "MOD_MELEE" || var_2 == "MOD_UNKNOWN" )
        var_4 = self.maxhealth * 0.34;

    playfxontagforclients( level._ID34853["hit"], self, "tag_origin", self.owner );

    if ( self._ID30272 == 0 && self.damagetaken >= self.maxhealth / 2 )
    {
        self._ID30272 = 1;
        playfxontag( level._ID34853["smoke"], self, "tag_origin" );
    }

    return var_4;
}

_ID36063()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "emp_damage",  var_0, var_1  );
        stopfxontag( level._ID34853["target_marker_circle"], self._ID4081, "tag_origin" );
        common_scripts\utility::_ID35582();
        playfxontag( common_scripts\utility::_ID15033( "emp_stun" ), self, "tag_origin" );
        wait(var_1);
        stopfxontag( level._ID34853["target_marker_circle"], self._ID4081, "tag_origin" );
        common_scripts\utility::_ID35582();
        thread _ID34871();
    }
}
