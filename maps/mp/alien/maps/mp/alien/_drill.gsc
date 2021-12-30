// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17725()
{
    common_scripts\utility::_ID13189( "drill_detonated" );
    common_scripts\utility::_ID13189( "drill_destroyed" );
    common_scripts\utility::_ID13189( "drill_drilling" );
    level.drill_use_trig = getent( "drill_pickup_trig", "targetname" );

    if ( isdefined( level.drill_use_trig ) )
        level.drill_use_trig._ID23029 = level.drill_use_trig.origin;

    level._ID10910 = 0;
    level._ID10913 = 1;
    level.drill = undefined;
    level.drill_carrier = undefined;
    init_fx();
    init_drill_drop_loc();
    thread drill_think();
    level thread _ID10918();
}

_ID10918()
{
    level endon( "game_ended" );
    var_0 = getentarray( "trigger_hurt", "classname" );

    for (;;)
    {
        if ( !isdefined( level.drill ) )
        {
            wait 0.5;
            continue;
        }

        foreach ( var_2 in var_0 )
        {
            if ( !isdefined( var_2.script_noteworthy ) || var_2.script_noteworthy != "out_of_playable" )
                continue;

            if ( level.drill istouching( var_2 ) )
            {
                level.drill delete();
                playfx( level._ID1644["alien_teleport"], level._ID19452 );
                playfx( level._ID1644["alien_teleport_dist"], level._ID19452 );
                drop_drill( level._ID19452, level.last_drill_pickup_angles );

                foreach ( var_4 in level.players )
                    var_4 maps\mp\_utility::setlowermessage( "drill_overboard", &"ALIEN_COLLECTIBLES_DRILL_OUTOFPLAY", 4 );
            }
        }

        wait 0.1;
    }
}

init_drill_drop_loc()
{
    level.drill_locs = [];
    level.drill_locs = common_scripts\utility::_ID15386( "bomb_drop_loc", "targetname" );
}

init_fx()
{
    level._ID1644["drill_laser_contact"] = loadfx( "vfx/gameplay/alien/vfx_alien_drill_laser_contact" );
    level._ID1644["drill_laser"] = loadfx( "vfx/gameplay/alien/vfx_alien_drill_laser" );
    level._ID1644["stronghold_explode_med"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_sentry_gun_explosion" );
    level._ID1644["stronghold_explode_large"] = loadfx( "fx/explosions/aerial_explosion" );
    level._ID1644["alien_hive_explode"] = loadfx( "fx/explosions/alien_hive_explosion" );
    level._ID30885["friendly"] = "mil_emergency_flare_mp";
    level._ID30884["friendly"] = loadfx( "fx/misc/flare_ambient_green" );
}

drill_think()
{
    level endon( "game_ended" );

    while ( !isdefined( level.players ) || level.players.size < 1 )
        wait 0.05;

    level.drill_health_hardcore = 1250;

    if ( maps\mp\alien\_unk1464::_ID18745() )
        level.drill_health_hardcore = 2000;

    level thread drill_threat_think();
    var_0 = ( 2822.27, -196, 524.068 );
    var_1 = common_scripts\utility::_ID15384( "drill_loc", "targetname" );

    if ( isdefined( var_1 ) )
        var_0 = var_1.origin;

    var_2 = ( 1.287, 0.995, -103.877 );

    if ( isdefined( var_1 ) && isdefined( var_1.angles ) )
        var_2 = var_1.angles;

    level waittill( "spawn_intro_drill",  var_3, var_4  );
    var_5 = 1;

    if ( isdefined( level.initial_drill_origin ) && isdefined( level.initial_drill_angles ) )
    {
        var_0 = level.initial_drill_origin;
        var_2 = level.initial_drill_angles;
        var_5 = 0;
    }

    if ( isdefined( var_3 ) && isdefined( var_4 ) )
    {
        var_0 = var_3;
        var_2 = var_4;
        var_5 = 0;
    }

    var_6 = undefined;

    for (;;)
    {
        _ID30633( "mp_laser_drill", var_0, var_2, var_6, var_5 );
        var_5 = 1;
        level waittill( "new_drill",  var_0, var_2, var_6  );
        wait 0.05;
    }
}

drop_drill( var_0, var_1, var_2 )
{
    level notify( "new_drill",  var_0, var_1, var_2  );
}

_ID30633( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_4 ) )
        var_4 = 1;

    level.drill_carrier = undefined;

    if ( isdefined( level.drill ) )
    {
        level.drill delete();
        level.drill = undefined;
    }

    level.drill = spawn( "script_model", var_1 );
    level.drill setmodel( var_0 );
    level.drill _ID28321();
    level.drill.state = "idle";

    if ( var_4 )
        level.drill thread angles_to_ground( var_1, var_2, ( 0, 0, -4 ) );
    else
        level.drill.angles = var_2;

    if ( common_scripts\utility::flag_exist( "intro_sequence_complete" ) && !common_scripts\utility::_ID13177( "intro_sequence_complete" ) )
        common_scripts\utility::flag_wait( "intro_sequence_complete" );

    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
        maps\mp\alien\_outline_proto::add_to_drill_preplant_watch_list( level.drill );

    if ( !maps\mp\alien\_unk1464::_ID18506( level._ID36752 ) )
        level.drill thread _ID10921( var_3 );

    level notify( "drill_spawned" );
}

enable_alt_drill_pickup( var_0 )
{
    level.drill_use_trig.origin = var_0.origin + ( 0, 0, 24 );
}

disable_alt_drill_pickup()
{
    level.drill_use_trig.origin = level.drill_use_trig._ID23029;
}

_ID10921( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    level endon( "new_drill" );

    if ( isdefined( level.drill_use_trig ) )
        var_1 = level.drill_use_trig;
    else
        var_1 = self;

    if ( !maps\mp\alien\_unk1464::_ID18506( level.prevent_drill_pickup ) )
    {
        if ( isdefined( level.drill_use_trig ) )
            level.drill_use_trig enable_alt_drill_pickup( self );
        else
            var_1 makeusable();
    }

    var_1 setcursorhint( "HINT_ACTIVATE" );
    var_1 sethintstring( &"ALIEN_COLLECTIBLES_PICKUP_BOMB" );

    for (;;)
    {
        var_1 waittill( "trigger",  var_2  );

        if ( var_2 maps\mp\alien\_unk1464::_ID18431() )
        {
            var_2 maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HOLDING", 3 );
            continue;
        }

        if ( var_2 getstance() == "prone" || var_2 getstance() == "crouch" )
        {
            var_2 maps\mp\_utility::setlowermessage( "change_stance", &"ALIENS_PATCH_CHANGE_STANCE", 3 );
            continue;
        }

        if ( maps\mp\alien\_unk1464::_ID18506( var_2._ID23541 ) )
            continue;

        if ( maps\mp\alien\_unk1464::_ID18506( var_2._ID18582 ) )
            continue;

        var_2.has_special_weapon = 1;
        var_2 common_scripts\utility::_disableusability();
        var_2 thread _ID37098();

        if ( isplayer( var_2 ) )
            break;
    }

    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
        maps\mp\alien\_outline_proto::remove_from_drill_preplant_watch_list( level.drill );

    if ( isdefined( level.drill_use_trig ) )
        level.drill_use_trig disable_alt_drill_pickup();

    level notify( "drill_pickedup",  var_2  );
    self playsound( "extinction_item_pickup" );
    level.drill_carrier = var_2;
    level._ID19452 = common_scripts\utility::drop_to_ground( self.origin, 16, -32 );
    level.last_drill_pickup_angles = self.angles;
    level.drill_carrier _ID28321( 1 );
    self.state = "carried";
    var_2 thread _ID11062();
    var_2 thread drop_drill_on_disconnect();
    var_2._ID19670 = var_2 getcurrentweapon();
    var_2 maps\mp\_utility::_giveweapon( "alienbomb_mp" );
    var_2 switchtoweapon( "alienbomb_mp" );
    var_2 disableweaponswitch();
    var_2 common_scripts\utility::_disableoffhandweapons();

    if ( isdefined( var_0 ) )
        var_0 delete();

    var_2 notify( "kill_spendhint" );
    var_2 notify( "dpad_cancel" );
    self delete();
}

_ID37098()
{
    self endon( "death" );
    self endon( "disconnect" );
    wait 1;
    common_scripts\utility::_enableusability();
}

_ID11062()
{
    level endon( "game_ended" );
    level endon( "new_drill" );
    level endon( "drill_planted" );
    level endon( "drill_dropping" );
    self notify( "watching_drop_drill_on_death" );
    self endon( "watching_drop_drill_on_death" );
    common_scripts\utility::_ID35663( "death", "last_stand" );
    self takeweapon( "alienbomb_mp" );
    self enableweaponswitch();
    self switchtoweapon( self._ID19670 );
    common_scripts\utility::_ID1647();
    level.drill_carrier = undefined;
    var_0 = getgroundposition( self.last_death_pos + ( 0, 0, 4 ), 8 );
    var_1 = self.angles;

    if ( maps\mp\alien\_unk1464::_ID18506( self.kill_trigger_event_processed ) )
    {
        var_2 = common_scripts\utility::_ID14934( self.origin, level._ID19280 );
        var_0 = getgroundposition( var_2.origin + ( 0, 0, 4 ), 8 );

        if ( !isdefined( var_2.angles ) )
            var_2.angles = ( 0, 0, 0 );

        var_1 = var_2.angles;
    }

    drop_drill( var_0, var_1 );
}

drop_drill_on_disconnect()
{
    level endon( "drill_dropping" );
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "last_stand" );
    self waittill( "disconnect" );
    playfx( level._ID1644["alien_teleport"], level._ID19452 );
    playfx( level._ID1644["alien_teleport_dist"], level._ID19452 );
    drop_drill( level._ID19452, level.last_drill_pickup_angles );

    foreach ( var_1 in level.players )
    {
        if ( !isalive( var_1 ) )
            continue;

        if ( var_1 == self )
            continue;

        var_1 maps\mp\_utility::setlowermessage( "drill_overboard", &"ALIEN_COLLECTIBLES_DRILL_OUTOFPLAY", 4 );
    }
}

_ID32724( var_0 )
{
    wait 5;

    if ( isdefined( level.drill ) && !isdefined( level.drill_carrier ) && distance( var_0, level.drill.origin ) > 1250 )
    {
        var_0 = common_scripts\utility::drop_to_ground( var_0, 16, -64 );
        level.drill angles_to_ground( var_0, level.drill.angles, ( 0, 0, -4 ) );
        level.drill _ID28321();
        enable_alt_drill_pickup( level.drill );
        return;
    }
}

_ID10944( var_0, var_1 )
{
    if ( isdefined( level.set_drill_state_drilling_override ) )
    {
        self thread [[ level.set_drill_state_drilling_override ]]( var_0, var_1 );
        return;
    }

    self endon( "stop_listening" );
    self endon( "drill_complete" );
    thread _ID28323( var_0, var_1 );
    level.drill endon( "death" );
    level.drill.owner = var_1;
    level._ID37166 = self.target;
    level.drill._ID31409 = gettime();
    common_scripts\utility::flag_set( "drill_drilling" );
    level.drill common_scripts\utility::_ID35637( 5, "drill_finished_plant_anim" );
    _ID17727();
    level.drill._ID31409 = gettime();
    thread set_drill_state_run( var_1 );
    _ID36640::_ID17038();
    level.drill waittill( "offline",  var_2, var_3  );
    thread _ID28322();
    common_scripts\utility::flag_set( "drill_destroyed" );
    wait 2;
    maps\mp\gametypes\aliens::alienendgame( "axis", maps\mp\alien\_hud::_ID14441( "drill_destroyed" ) );
    return;
}

_ID28320()
{
    var_0 = [];
    var_0["brute"][0] = maps\mp\alien\_unk1464::_ID28232( ( 0, 1, 0 ), "alien_drill_attack_drill_F_enter", "alien_drill_attack_drill_F_loop", "alien_drill_attack_drill_F_exit", "attack_drill_front", "attack_drill" );
    var_0["brute"][1] = maps\mp\alien\_unk1464::_ID28232( ( -1, 0, 0 ), "alien_drill_attack_drill_R_enter", "alien_drill_attack_drill_R_loop", "alien_drill_attack_drill_R_exit", "attack_drill_right", "attack_drill" );
    var_0["brute"][2] = maps\mp\alien\_unk1464::_ID28232( ( 1, 0, 0 ), "alien_drill_attack_drill_L_enter", "alien_drill_attack_drill_L_loop", "alien_drill_attack_drill_L_exit", "attack_drill_left", "attack_drill" );
    var_0["goon"][0] = maps\mp\alien\_unk1464::_ID28232( ( 0, 1, 0 ), "alien_goon_drill_attack_drill_F_enter", "alien_goon_drill_attack_drill_F_loop", "alien_goon_drill_attack_drill_F_exit", "attack_drill_front", "attack_drill" );
    var_0["goon"][1] = maps\mp\alien\_unk1464::_ID28232( ( -1, 0, 0 ), "alien_goon_drill_attack_drill_R_enter", "alien_goon_drill_attack_drill_R_loop", "alien_goon_drill_attack_drill_R_exit", "attack_drill_right", "attack_drill" );
    var_0["goon"][2] = maps\mp\alien\_unk1464::_ID28232( ( 1, 0, 0 ), "alien_goon_drill_attack_drill_L_enter", "alien_goon_drill_attack_drill_L_loop", "alien_goon_drill_attack_drill_L_exit", "attack_drill_left", "attack_drill" );
    var_1[0] = "offline";
    var_1[1] = "death";
    var_1[2] = "drill_complete";
    var_1[3] = "destroyed";
    maps\mp\alien\_unk1464::_ID28580( var_0, 1, var_1, undefined, ::drill_synch_attack_play_anim, ::drill_synch_attack_play_anim, ::_ID10934, "drill" );
}

drill_synch_attack_play_anim( var_0 )
{
    level.drill scriptmodelclearanim();
    level.drill scriptmodelplayanim( var_0 );
}

_ID10934( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
    {
        level.drill scriptmodelclearanim();
        level.drill scriptmodelplayanim( var_0 );
        wait(var_1);
    }

    if ( isalive( level.drill ) && !common_scripts\utility::_ID13177( "drill_detonated" ) )
    {
        level.drill scriptmodelclearanim();
        level.drill scriptmodelplayanim( "alien_drill_loop" );
        return;
    }
}

_ID34678()
{
    return 1;
}

_ID36026( var_0 )
{
    self endon( "drill_complete" );
    self endon( "death" );
    var_0 endon( "hive_dying" );
    wait 5.0;
    self makeunusable();
    var_1 = 100;
    var_2 = 1000;
    var_3 = 4000;
    var_4 = 2000;

    for (;;)
    {
        self makeunusable();

        for (;;)
        {
            var_5 = ( self.health - 20000 ) / level.drill_health_hardcore;

            if ( var_5 < 0.75 )
                break;

            wait 1;
        }

        self makeusable();

        if ( isdefined( level.drill_repair ) )
            self sethintstring( level.drill_repair );
        else
            self sethintstring( &"ALIEN_COLLECTIBLES_DRILL_REPAIR" );

        self waittill( "trigger",  var_6  );

        if ( maps\mp\alien\_unk1464::_ID18506( var_6._ID18582 ) )
            continue;

        self sethintstring( "" );
        var_7 = level.players.size;
        var_6.isrepairing = 1;
        level notify( "dlc_vo_notify",  "drill_repair", var_6  );
        var_8 = int( var_3 * var_6 maps\mp\alien\_perk_utility::perk_getdrilltimescalar() * var_6._ID10945 );

        if ( var_7 > 1 )
            var_8 = int( ( var_3 + ( var_7 - 1 ) * var_4 ) * var_6 maps\mp\alien\_perk_utility::perk_getdrilltimescalar() * var_6._ID10945 );

        var_9 = _ID34751( var_6, var_8 );

        if ( !var_9 )
        {
            var_6.isrepairing = 0;
            continue;
        }

        if ( isdefined( level.drill_sfx_lp ) )
        {
            if ( isdefined( level.drill_overheat_lp_02 ) )
                level.drill_overheat_lp_02 stoploopsound();

            if ( !var_0 maps\mp\alien\_unk1464::is_door() && !var_0 maps\mp\alien\_unk1464::is_door_hive() && level.script != "mp_alien_dlc3" )
            {
                if ( level.script == "mp_alien_last" )
                    level.drill_sfx_lp playloopsound( "alien_conduit_on_lp" );
                else
                    level.drill_sfx_lp playloopsound( "alien_laser_drill_lp" );
            }
        }

        level notify( "dlc_vo_notify",  "drill_repaired", var_6  );
        level notify( "drill_repaired" );
        var_6.isrepairing = 0;
        var_0 thread drill_reset_bbprint( var_6 );
        var_6 maps\mp\alien\_persistence::_ID15551( var_1 );
        self.health = level.drill_health_hardcore + 20000;
        level._ID10911 = level.drill_health_hardcore + 20000;
        update_drill_health_hud();
        var_6.isrepairing = 0;
        var_6 maps\mp\alien\_persistence::eog_player_update_stat( "drillrestarts", 1 );
        wait 1.0;
    }
}

_ID28323( var_0, var_1 )
{
    if ( isdefined( level.drill ) )
    {
        level.drill delete();
        level.drill = undefined;
    }

    level.drill = spawn( "script_model", var_0 );
    level.drill setmodel( "mp_laser_drill" );
    level.drill.state = "planted";
    level.drill.angles = self.angles;

    if ( !maps\mp\alien\_unk1464::is_door() )
        level.drill _ID28320();

    if ( isdefined( level.drill_attack_setup_override ) )
        level.drill [[ level.drill_attack_setup_override ]]();

    var_2 = 150;

    if ( _ID34678() )
    {
        var_2 = level.drill_health_hardcore;
        level.drill thread _ID36026( self );
    }

    level.drill.maxhealth = 20000 + var_2;
    level.drill.health = int( 20000 + var_2 * var_1 maps\mp\alien\_perk_utility::perk_getdrillhealthscalar() );
    level.drill thread _ID35943();

    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
        maps\mp\alien\_outline_proto::_ID2259( level.drill, 0 );

    thread sfx_drill_plant();
    self.depth_marker = gettime();
    level thread maps\mp\alien\_music_and_dialog::playvoforbombplant( var_1 );
    _ID9765();

    if ( !maps\mp\alien\_unk1464::is_door() && !maps\mp\alien\_unk1464::is_door_hive() )
    {
        level.drill scriptmodelplayanim( "alien_drill_enter" );
        wait 4;
    }
    else
        wait 0.5;

    level.drill notify( "drill_finished_plant_anim" );
}

_ID35943()
{
    self endon( "drill_complete" );
    self endon( "death" );

    for (;;)
    {
        var_0 = ( level.drill.health - 20000 ) / level.drill_health_hardcore;

        if ( var_0 < 0.5 )
        {
            maps\mp\alien\_unk1422::_ID34406( "no_stuck_drill", 0 );
            break;
        }

        wait 1;
    }
}

drill_threat_think()
{
    level endon( "game_ended" );
    var_0 = 1;

    for (;;)
    {
        if ( !isdefined( level.drill ) || !issentient( level.drill ) || !isalive( level.drill ) )
        {
            wait(var_0);
            continue;
        }

        if ( _ID34678() )
        {
            self.drill.threatbias = -1000;
            wait(var_0);
            continue;
        }

        var_1 = 0;
        var_2 = 0;

        foreach ( var_4 in level.players )
        {
            if ( isdefined( var_4 ) && isalive( var_4 ) )
            {
                var_2++;
                var_1 += distance2d( var_4.origin, level.drill.origin );
            }
        }

        if ( var_2 == 0 )
        {
            level.drill.threatbias = int( -3000 );
            wait(var_0);
            continue;
        }

        var_6 = var_1 / max( 1, var_2 );

        if ( var_6 < 1000 )
            level.drill.threatbias = int( -3000 );
        else if ( var_6 > 2500 )
            level.drill.threatbias = int( -1000 );
        else
        {
            var_7 = 1500;
            var_8 = 2000;
            var_9 = ( var_6 - 1000 ) / var_7;
            var_10 = var_9 * var_8;
            level.drill.threatbias = int( -3000 + var_10 );
        }

        wait(var_0);
    }
}

set_drill_state_run( var_0 )
{
    if ( isdefined( level.set_drill_state_run_override ) )
    {
        self thread [[ level.set_drill_state_run_override ]]( var_0 );
        return;
    }

    self endon( "death" );
    self endon( "stop_listening" );
    level.drill.state = "online";
    level.drill notify( "online" );
    level.drill setcandamage( 1 );
    level.drill makeunusable();
    level.drill sethintstring( "" );
    var_1 = 150;

    if ( _ID34678() )
        var_1 = level.drill_health_hardcore;

    level.drill.maxhealth = 20000 + var_1;
    level.drill.health = int( 20000 + var_1 * level.drill.owner maps\mp\alien\_perk_utility::perk_getdrillhealthscalar() );
    level.drill.threatbias = -3000;
    level.drill makeentitysentient( "allies" );
    level.drill setthreatbiasgroup( "drill" );
    update_drill_health_hud();

    foreach ( var_3 in level.agentarray )
    {
        if ( isdefined( var_3._ID36227 ) && var_3._ID36227 )
            var_3 getenemyinfo( level.drill );
    }

    var_5 = level.drill gettagangles( "tag_laser" );
    var_6 = anglestoforward( var_5 );
    var_7 = anglestoup( var_5 );
    var_8 = vectorcross( var_6, ( 0, 0, 1 ) );
    var_9 = level.drill gettagorigin( "tag_laser_end" ) - ( 0, 0, 16 ) + var_8 * 4 * -1 + var_6 * 1.0 * -1;
    var_10 = level.drill gettagorigin( "tag_laser" ) - ( 0, 0, 8 );
    level.drill._ID14018 = spawnfx( level._ID1644["drill_laser_contact"], var_9 );
    level.drill._ID14032 = spawnfx( level._ID1644["drill_laser"], var_10, var_6, var_7 );
    var_11 = maps\mp\alien\_unk1464::is_door() || maps\mp\alien\_unk1464::is_door_hive();
    thread _ID29319( var_11 );

    if ( maps\mp\alien\_unk1464::is_door() )
    {
        level notify( "drill_start_door_fx" );
        level.drill scriptmodelplayanim( "alien_drill_open_door" );
    }
    else if ( isdefined( level.custom_hive_logic ) )
        level [[ level.custom_hive_logic ]]();
    else
    {
        triggerfx( level.drill._ID14018 );
        triggerfx( level.drill._ID14032 );
        level.drill scriptmodelplayanim( "alien_drill_loop" );
    }

    thread _ID16044();
    self.depth_marker = gettime();
    thread monitor_drill_complete( self.depth );
    thread _ID36640::_ID17034();
    thread _ID36640::_ID28422( "waypoint_alien_defend" );
    _ID9765();
    maps\mp\alien\_hud::turn_on_drill_meter_hud( self.depth );
    level thread _ID35941( self.depth );
}

_ID35941( var_0 )
{
    level endon( "drill_detonated" );
    level endon( "game_ended" );
    wait(var_0 / 2);
    level thread maps\mp\alien\_music_and_dialog::_ID24672();
}

monitor_drill_complete( var_0 )
{
    self endon( "death" );
    self endon( "stop_listening" );
    level.drill endon( "offline" );

    while ( self._ID19720.size > 0 )
    {
        var_1 = self._ID19720[self._ID19720.size - 1];
        var_2 = self._ID19720.size == 1;
        var_3 = var_0 - var_1;

        if ( var_2 )
            childthread maps\mp\alien\_music_and_dialog::playmusicbeforereachlayer( var_3 );

        var_4 = "remaining_depth_to_layer is negative, ";
        var_4 = var_4 + "[depth=" + var_0 + "][layer_depth=" + var_1 + "][layer index=" + self._ID19720.size - 1 + "]";
        var_4 = var_4 + "[hive.origin=" + self.origin + "]";
        common_scripts\utility::_ID35637( var_3, "force_drill_complete" );
        self.layer_completed++;
        setomnvar( "ui_alien_drill_layer_completed", self.layer_completed );
        self._ID19720 = common_scripts\utility::array_remove( self._ID19720, var_1 );
        var_0 = var_1;
        _ID25503();

        if ( !maps\mp\alien\_unk1464::is_door() )
            _ID25504( var_2 );
    }

    self notify( "drill_complete" );
    level.drill notify( "drill_complete" );
    level._ID37166 = undefined;
    common_scripts\utility::_ID13180( "drill_drilling" );
    common_scripts\utility::flag_set( "drill_detonated" );

    foreach ( var_6 in level.players )
    {
        if ( !isalive( var_6 ) || maps\mp\alien\_unk1464::_ID18506( var_6._ID18764 ) || maps\mp\alien\_unk1464::_ID18506( var_6._ID5118 ) )
            continue;

        var_6 setclientomnvar( "ui_securing_progress", 0 );
        var_6 setclientomnvar( "ui_securing", 0 );
    }

    setomnvar( "ui_alien_drill_state", 0 );
}

_ID25503()
{
    var_0 = 0.4;
    var_1 = 1.75;

    if ( maps\mp\alien\_unk1464::is_door() )
        var_0 = 0.15;

    thread _ID36640::_ID35886( var_1, var_0 );
}

_ID25504( var_0 )
{
    if ( var_0 )
        return;

    var_1 = "reached_layer_" + self.layer_completed;
    maps\mp\alien\_spawn_director::activate_spawn_event( var_1 );
}

_ID17727()
{
    if ( maps\mp\alien\_unk1464::is_door() )
    {
        self.depth = 30;
        self._ID33145 = self.depth;
        self.layer_completed = 0;
        self._ID19720[0] = 0;
        setomnvar( "ui_alien_drill_layers_table_line", 599 + level.current_cycle_num + 1 );
        setomnvar( "ui_alien_drill_layer_completed", self.layer_completed );
        return;
    }

    var_0 = level.cycle_data._ID8865[level.current_cycle_num + 1];
    self.depth = var_0[var_0.size - 1];
    self._ID33145 = self.depth;
    self.layer_completed = 0;
    self._ID19720[0] = 0;

    for ( var_1 = 0; var_1 <= var_0.size - 2; var_1++ )
        self._ID19720[self._ID19720.size] = var_0[var_1];

    setomnvar( "ui_alien_drill_layers_table_line", 599 + level.current_cycle_num + 1 );
    setomnvar( "ui_alien_drill_layer_completed", self.layer_completed );
    return;
}

_ID28322()
{
    self endon( "death" );
    self endon( "stop_listening" );
    level.drill.state = "offline";

    if ( isdefined( level.drill._ID14018 ) )
        level.drill._ID14018 delete();

    if ( isdefined( level.drill._ID14032 ) )
        level.drill._ID14032 delete();

    if ( maps\mp\alien\_unk1464::is_door() )
        level notify( "drill_stop_door_fx" );

    thread sfx_drill_offline();
    var_0 = ( gettime() - self.depth_marker ) / 1000;
    self.depth = max( 0, self.depth - var_0 );
    level.drill scriptmodelplayanim( "alien_drill_operate_end" );
    wait 1.4;
    level.drill scriptmodelplayanim( "alien_drill_nonoperate" );
    level.drill makeusable();
    level.drill setcursorhint( "HINT_ACTIVATE" );
    level.drill sethintstring( &"ALIEN_COLLECTIBLES_PLANT_BOMB" );
    level.drill setcandamage( 0 );
    level.drill freeentitysentient();
    _ID36640::destroy_hive_icon();
    level.drill _ID28321();
    setomnvar( "ui_alien_drill_state", 2 );
}

_ID16044()
{
    self endon( "death" );
    self endon( "stop_listening" );
    level endon( "hives_cleared" );
    level.drill endon( "death" );
    level.drill endon( "offline" );
    var_0 = 0;
    var_1 = gettime();
    level._ID10911 = level.drill.health;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;

    for (;;)
    {
        level.drill waittill( "damage",  var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14  );

        if ( isdefined( var_6 ) && isai( var_6 ) )
            level._ID10911 = level._ID10911 - var_5;
        else if ( isdefined( var_14 ) && var_14 == "alien_minion_explosion" )
            level._ID10911 = level._ID10911 - var_5;
        else
        {
            level.drill.health = level._ID10911;
            continue;
        }

        if ( isdefined( level.level_drill_damage_adjust_function ) )
            [[ level.level_drill_damage_adjust_function ]]( var_5, var_6, var_14 );

        level.drill.health = level._ID10911;
        maps\mp\alien\_unk1443::_ID38222( maps\mp\alien\_unk1443::get_drill_score_component_name(), "drill_damage_taken", var_5 );
        _ID36632::_ID37443( var_5 );

        if ( level.script == "mp_alien_last" )
        {
            if ( isdefined( var_6 ) && ( !isdefined( var_6.team ) || var_6.team == "axis" ) )
                self playsound( "scn_dscnt_alien_pod_hit" );
        }

        if ( level.drill.health < 20000 )
        {
            maps\mp\alien\_hud::update_drill_health( 0 );
            level.drill notify( "offline",  var_6, var_5  );
            continue;
        }

        if ( !isdefined( self._ID17321 ) )
            continue;

        var_16 = ( level.drill.health - 20000 ) / 150;
        var_16 = max( 0, min( 1, var_16 ) );
        var_17 = var_16 * var_16;
        var_18 = var_17;
        var_19 = var_18;
        self._ID17321.color = ( 1, var_18, var_19 );

        if ( _ID34678() )
        {
            var_20 = ( level.drill.health - 20000 ) / level.drill_health_hardcore;
            update_drill_health_hud();

            if ( var_20 <= 0.75 && !var_2 )
            {
                if ( isdefined( level.drill_repair_hint ) )
                    iprintlnbold( level.drill_repair_hint );
                else
                    iprintlnbold( &"ALIEN_COLLECTIBLES_DRILL_REPAIR_HINT" );

                var_2 = 1;
            }
            else if ( var_20 <= 0.5 && !var_3 )
            {
                if ( isdefined( level.drill_repair_hint ) )
                    iprintlnbold( level.drill_repair_hint );
                else
                    iprintlnbold( &"ALIEN_COLLECTIBLES_DRILL_REPAIR_HINT" );

                var_3 = 1;
            }
            else if ( var_20 <= 0.25 && !var_4 )
            {
                if ( isdefined( level.drill_repair_hint_urgent ) )
                    iprintlnbold( level.drill_repair_hint_urgent );
                else
                    iprintlnbold( &"ALIEN_COLLECTIBLES_REACT_DRILL" );

                var_4 = 1;
            }

            if ( var_20 <= 0.25 )
                thread sfx_overheat();

            if ( var_20 < 0.5 && gettime() - var_1 > var_0 )
                level thread maps\mp\alien\_music_and_dialog::_ID24673();
            else if ( gettime() - var_1 > var_0 )
                level thread maps\mp\alien\_music_and_dialog::_ID24671();

            var_1 = gettime();
        }
    }
}

sfx_overheat()
{
    if ( !maps\mp\alien\_unk1464::is_door() && !maps\mp\alien\_unk1464::is_door_hive() && level.script != "mp_alien_dlc3" )
        level.drill_sfx_lp stoploopsound( "alien_laser_drill_lp" );

    if ( !isdefined( level.drill_overheat_lp_02 ) )
    {
        level.drill_overheat_lp_02 = spawn( "script_origin", level.drill.origin );
        level.drill_overheat_lp_02 linkto( level.drill );

        if ( level.script == "mp_alien_last" )
        {
            level.drill_sfx_lp stoploopsound( "alien_conduit_on_lp" );
            level.drill_overheat_lp_02 playloopsound( "alien_conduit_damaged_lp" );
            return;
        }
    }

    if ( level.script == "mp_alien_dlc3" )
    {
        level.drill_overheat_lp_02 playloopsound( "alien_drill_scanner_overheat_lp" );
        return;
    }

    level.drill_overheat_lp_02 playloopsound( "alien_laser_drill_overheat_lp" );
    return;
}

_ID10903()
{
    if ( isdefined( level.drill_detonate_override ) )
    {
        self thread [[ level.drill_detonate_override ]]();
        return;
    }

    _ID36640::destroy_hive_icon();
    self makeunusable();
    self sethintstring( "" );

    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
        maps\mp\alien\_outline_proto::_ID25899( level.drill );

    if ( !maps\mp\alien\_unk1464::is_door() && !maps\mp\alien\_unk1464::is_door_hive() )
    {
        thread _ID29316( 0 );
        thread _ID19194();
    }

    if ( isdefined( level.drill._ID14018 ) )
        level.drill._ID14018 delete();

    if ( isdefined( level.drill._ID14032 ) )
        level.drill._ID14032 delete();

    if ( maps\mp\alien\_unk1464::is_door() )
        level notify( "drill_stop_door_fx" );

    level.drill scriptmodelclearanim();

    if ( !maps\mp\alien\_unk1464::is_door() )
    {
        level.drill scriptmodelplayanim( "alien_drill_end" );
        wait 3.8;
    }

    if ( !isdefined( self._ID19460 ) || !self._ID19460 )
    {
        var_0 = level.drill.origin + ( 0, 0, 8 );
        drop_drill( var_0, self.angles - ( 0, 90, 0 ) );
    }

    if ( maps\mp\alien\_unk1464::is_door() || maps\mp\alien\_unk1464::is_door_hive() )
        maps\mp\_utility::_ID9519( 3, ::_ID22931 );
    else
        thread _ID36640::delete_removables();

    thread _ID25944();
    thread fx_ents_playfx();
    _ID36640::_ID29913();
    thread do_radius_damage();

    if ( isdefined( self._ID19460 ) && self._ID19460 )
    {
        common_scripts\utility::flag_set( "hives_cleared" );
        level thread detonate_drill_when_nuke_goes_off( self );
    }

    common_scripts\utility::_ID13180( "drill_detonated" );
    wait 8;
    level thread maps\mp\alien\_music_and_dialog::_ID24665( self );
}

do_radius_damage()
{
    var_0 = 300;

    foreach ( var_2 in self.scriptables )
    {
        radiusdamage( var_2.origin, var_0, 0, 0, var_2 );
        common_scripts\utility::_ID35582();
    }
}

detonate_drill_when_nuke_goes_off( var_0 )
{
    if ( isdefined( level.drill ) )
    {
        level.drill setcandamage( 0 );
        level.drill freeentitysentient();
        level.drill makeunusable();
    }

    level waittill( "nuke_went_off" );
    wait 1.5;
    var_1 = level._ID1644["stronghold_explode_med"];
    var_2 = var_0.origin;

    if ( isdefined( level.drill ) )
        var_2 = level.drill.origin;

    playfx( var_1, var_2 );

    if ( isdefined( level.drill ) )
    {
        level.drill_carrier = undefined;
        level.drill delete();
        return;
    }
}

_ID19194()
{
    playfx( level._ID1644["stronghold_explode_large"], self.origin );

    if ( !maps\mp\alien\_unk1464::is_door() )
        thread _ID36640::_ID29309();

    if ( isalive( level.drill ) )
    {
        foreach ( var_1 in self.scriptables )
        {
            var_1 thread _ID36640::hive_explode( 1 );
            common_scripts\utility::_ID35582();
        }

        return;
    }
}

_ID8492()
{
    var_0 = spawn( "script_origin", self.origin );
    var_0.curprogress = 0;
    var_0._ID34780 = 0;
    var_0._ID34766 = 1;
    var_0._ID18318 = 0;
    var_0 thread deleteuseent( self );
    return var_0;
}

deleteuseent( var_0 )
{
    self endon( "death" );
    var_0 waittill( "death" );
    self delete();
}

cancel_repair_on_hive_death( var_0 )
{
    var_0 endon( "disconnect" );
    self notify( "cancel_repair_on_hive_death" );
    self endon( "cancel_repair_on_hive_death" );
    level endon( "drill_repaired" );
    self waittill( "drill_complete" );

    if ( isalive( var_0 ) )
    {
        var_0 notify( "drill_repair_weapon_management" );

        if ( var_0.disabledweapon > 0 )
            var_0 common_scripts\utility::_enableweapon();

        if ( maps\mp\alien\_unk1464::_ID18506( var_0.hasprogressbar ) )
            var_0.hasprogressbar = 0;

        var_0.isrepairing = 0;
        return;
    }
}

_ID34751( var_0, var_1 )
{
    thread cancel_repair_on_hive_death( var_0 );
    self.curprogress = 0;
    self._ID18318 = 1;
    self._ID34766 = 1;

    if ( isdefined( var_1 ) )
        self._ID34780 = var_1;
    else
        self._ID34780 = 3000;

    if ( !var_0 maps\mp\alien\_perk_utility::_ID16358( "perk_rigger", [ 0, 1, 2, 3, 4 ] ) )
        var_0 maps\mp\alien\_unk1464::_ID37114( var_1 + 0.05, "drill_repair_weapon_management" );

    var_0 thread _ID23480( self );
    var_0.hasprogressbar = 1;
    var_2 = useholdthinkloop( var_0, self, 18496 );

    if ( isalive( var_0 ) )
    {
        var_0.hasprogressbar = 0;

        if ( !var_0 maps\mp\alien\_perk_utility::_ID16358( "perk_rigger", [ 0, 1, 2, 3, 4 ] ) )
            var_0 maps\mp\alien\_unk1464::_ID37161( "drill_repair_weapon_management" );
    }

    if ( !isdefined( self ) )
        return 0;

    self._ID18318 = 0;
    self.curprogress = 0;
    return var_2;
}

_ID23480( var_0 )
{
    var_1 = 2;

    if ( level.script == "mp_alien_last" )
        var_1 = 7;

    self endon( "disconnect" );
    self setclientomnvar( "ui_securing", var_1 );
    var_2 = -1;

    while ( maps\mp\_utility::_ID18757( self ) && isdefined( var_0 ) && var_0._ID18318 && !level.gameended )
    {
        if ( var_2 != var_0._ID34766 )
        {
            if ( var_0.curprogress > var_0._ID34780 )
                var_0.curprogress = var_0._ID34780;
        }

        var_2 = var_0._ID34766;
        self setclientomnvar( "ui_securing_progress", var_0.curprogress / var_0._ID34780 );
        wait 0.05;
    }

    self setclientomnvar( "ui_securing_progress", 0 );
    self setclientomnvar( "ui_securing", 0 );
}

useholdthinkloop( var_0, var_1, var_2 )
{
    while ( !level.gameended && isdefined( self ) && maps\mp\_utility::_ID18757( var_0 ) && var_0 usebuttonpressed() && ( !isdefined( var_0.laststand ) || !var_0.laststand ) && self.curprogress < self._ID34780 )
    {
        var_3 = ( self.health - 20000 ) / level.drill_health_hardcore;

        if ( var_3 <= 0 )
            return 0;

        if ( isdefined( var_1 ) && isdefined( var_2 ) )
        {
            if ( distancesquared( var_0.origin, var_1.origin ) > var_2 )
                return 0;
        }

        self.curprogress = self.curprogress + 50 * self._ID34766;
        self._ID34766 = 1;

        if ( self.curprogress >= self._ID34780 )
            return maps\mp\_utility::_ID18757( var_0 );

        wait 0.05;
    }

    return 0;
}

_ID10843( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_3 ) )
    {
        for ( var_4 = 0; var_4 < var_3; var_4++ )
            wait 0.05;

        return;
    }

    for (;;)
        wait 0.05;

    return;
}

angles_to_ground( var_0, var_1, var_2 )
{
    var_3 = var_0 + ( 0, 0, 16 );
    var_4 = var_0 - ( 0, 0, 64 );
    var_5 = bullettrace( var_3, var_4, 0, self );
    var_6 = var_5["normal"] * -1;
    var_7 = vectortoangles( var_6 );
    var_8 = vectortoangles( anglestoup( var_7 ) )[1] - vectortoangles( anglestoforward( var_1 ) )[1];
    var_9 = vectornormalize( var_6 );
    var_10 = vectornormalize( anglestoup( vectortoangles( var_6 ) ) );
    var_11 = vectornormalize( anglestoright( vectortoangles( var_6 ) ) );
    var_10 = rotatepointaroundvector( var_9, var_10, var_8 - 90 );
    var_11 = rotatepointaroundvector( var_9, var_11, var_8 - 90 );
    self.angles = axistoangles( var_10, var_11, var_9 );

    if ( abs( self.angles[2] ) > 45 )
        self.angles = ( self.angles[0], self.angles[1], 0 );

    if ( abs( self.angles[0] ) > 45 )
        self.angles = ( 0, self.angles[1], self.angles[2] );

    self.origin = var_0 + var_2;
}

_ID36041()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );

    if ( self hasweapon( "alienbomb_mp" ) )
    {
        self takeweapon( "alienbomb_mp" );
        self enableweaponswitch();
    }

    for (;;)
    {
        self waittill( "grenade_fire",  var_0, var_1  );

        if ( var_1 == "alienbomb" || var_1 == "alienbomb_mp" )
        {
            var_0.owner = self;
            var_0 setotherent( self );
            var_0.team = self.team;
            var_0 thread _ID36042( self );
        }
    }
}

_ID36042( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    self hide();
    common_scripts\utility::_ID35637( 0.05, "missile_stuck" );
    var_1 = self aiphysicstrace( var_0.origin + ( 0, 0, 8 ), var_0.origin - ( 0, 0, 12 ), undefined, undefined, 1, 1 );

    if ( var_1["fraction"] == 1 )
    {
        var_0 takeweapon( "alienbomb_mp" );
        var_0 giveweapon( "alienbomb_mp" );
        var_0 setweaponammostock( "alienbomb_mp", var_0 getweaponammostock( "alienbomb_mp" ) + 1 );
        var_0 switchtoweapon( "alienbomb_mp" );
        self delete();
        return;
    }
    else
    {
        self.origin = var_1["position"];
        var_2 = var_1["entity"];
    }

    self.angles = self.angles * ( 0, 1, 1 );
    level notify( "drill_dropping" );

    foreach ( var_4 in level._ID31986 )
    {
        if ( var_4 _ID36640::is_blocker_hive() )
            continue;

        if ( !var_4 _ID36640::dependent_hives_removed() )
            continue;

        if ( distance( var_4.origin, self.origin ) < 80 )
        {
            var_4 notify( "trigger",  var_0  );
            earthquake( 0.25, 0.5, self.origin, 128 );
            var_0 takeweapon( "alienbomb_mp" );

            if ( !var_0 maps\mp\alien\_unk1464::has_special_weapon() )
                var_0 enableweaponswitch();

            var_0 restore_last_weapon();
            var_0 common_scripts\utility::_ID1647();
            self delete();
            return;
        }
    }

    if ( isdefined( level.watch_bomb_stuck_override ) )
    {
        if ( [[ level.watch_bomb_stuck_override ]]( var_0 ) )
            return;
    }

    drop_drill( self.origin, self.angles, self );
    earthquake( 0.25, 0.5, self.origin, 128 );
    var_0 takeweapon( "alienbomb_mp" );

    if ( !var_0 maps\mp\alien\_unk1464::has_special_weapon() )
        var_0 enableweaponswitch();

    var_0 restore_last_weapon();
    var_0 common_scripts\utility::_ID1647();
    level thread maps\mp\alien\_outline_proto::_ID34416();
    self delete();
}

restore_last_weapon()
{
    if ( self._ID19670 != "aliendeployable_crate_marker_mp" )
    {
        self switchtoweapon( self._ID19670 );
        return;
    }

    self switchtoweapon( self getweaponslistprimaries()[0] );
    return;
}

_ID23964()
{
    if ( !isdefined( self.carryicon ) )
    {
        if ( level.splitscreen )
        {
            self.carryicon = maps\mp\gametypes\_hud_util::_ID8444( "hud_suitcase_bomb", 33, 33 );
            self.carryicon maps\mp\gametypes\_hud_util::_ID28836( "BOTTOM RIGHT", "BOTTOM RIGHT", -50, -78 );
        }
        else
        {
            self.carryicon = maps\mp\gametypes\_hud_util::_ID8444( "hud_suitcase_bomb", 50, 50 );
            self.carryicon maps\mp\gametypes\_hud_util::_ID28836( "BOTTOM RIGHT", "BOTTOM RIGHT", -50, -65 );
        }

        self.carryicon.hidewheninmenu = 1;
        thread hidecarryiconongameend();
    }

    self.carryicon.alpha = 0;
}

hidecarryiconongameend()
{
    self endon( "disconnect" );
    level waittill( "game_ended" );

    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 0;
        return;
    }
}

_ID28321( var_0 )
{
    level notify( "new_bomb_icon" );
    _ID9765( self );

    if ( !isdefined( var_0 ) || !var_0 )
    {
        level.drill_icon = newhudelem();
        level.drill_icon setshader( "waypoint_alien_drill", 14, 14 );
        level.drill_icon.color = ( 1, 1, 1 );
        level.drill_icon setwaypoint( 1, 1 );
        level.drill_icon.sort = 1;
        level.drill_icon.foreground = 1;
        level.drill_icon.alpha = 0.5;
        level.drill_icon.x = self.origin[0];
        level.drill_icon.y = self.origin[1];
        level.drill_icon.z = self.origin[2] + 72;
        return;
    }

    maps\mp\_entityheadicons::setheadicon( self.team, "waypoint_alien_drill", ( 0, 0, 72 ), 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
    return;
}

_ID9765( var_0 )
{
    if ( isdefined( level.drill_icon ) )
        level.drill_icon destroy();

    if ( !isdefined( var_0 ) )
        return;

    _ID25908();
}

_ID25908()
{
    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1._ID12149 ) )
        {
            foreach ( var_4, var_3 in var_1._ID12149 )
            {
                if ( !isdefined( var_3 ) )
                    continue;

                var_3 destroy();
            }
        }
    }
}

_ID25944()
{
    if ( isdefined( self.script_linkto ) )
    {
        maps\mp\alien\_spawn_director::_ID25942( self.script_linkto );
        return;
    }
}

fx_ents_playfx()
{
    foreach ( var_1 in self._ID13828 )
    {
        playfx( level._ID1644["stronghold_explode_med"], var_1.origin );
        var_1 delete();
    }
}

sfx_drill_plant()
{
    var_0 = get_drill_entity();
    var_0 playsound( "alien_laser_drill_plant" );
}

_ID29319( var_0 )
{
    wait 0.1;
    var_1 = get_drill_entity();

    if ( !isdefined( level.drill_sfx_lp ) )
    {
        level.drill_sfx_lp = spawn( "script_origin", var_1.origin );
        level.drill_sfx_lp linkto( var_1 );
    }

    if ( !isdefined( level.drill_sfx_dist_lp ) )
    {
        level.drill_sfx_dist_lp = spawn( "script_origin", var_1.origin );
        level.drill_sfx_dist_lp linkto( var_1 );
    }

    wait 0.1;

    if ( var_0 )
    {
        wait 3.76;

        if ( isdefined( level.drill_sfx_lp ) )
            level.drill_sfx_lp playloopsound( "alien_laser_drill_door_lp" );

        if ( isdefined( level.drill_sfx_dist_lp ) )
        {
            level.drill_sfx_dist_lp playloopsound( "alien_laser_drill_door_dist_lp" );
            return;
        }

        return;
    }

    if ( isdefined( level.drill_sfx_lp ) )
        level.drill_sfx_lp playloopsound( "alien_laser_drill_lp" );

    if ( isdefined( level.drill_sfx_dist_lp ) )
    {
        level.drill_sfx_dist_lp playloopsound( "alien_laser_drill_dist_lp" );
        return;
    }

    return;
}

_ID29316( var_0 )
{
    var_1 = get_drill_entity();
    var_2 = var_1.origin;

    if ( !var_0 )
        var_1 playsound( "alien_laser_drill_stop" );
    else
        playsoundatpos( var_2, "alien_laser_drill_stop" );

    if ( isdefined( level.drill_sfx_lp ) )
        level.drill_sfx_lp delete();

    if ( isdefined( level.drill_sfx_dist_lp ) )
        level.drill_sfx_dist_lp delete();

    if ( isdefined( level.drill_overheat_lp ) )
        level.drill_overheat_lp delete();

    if ( isdefined( level.drill_overheat_lp_02 ) )
        level.drill_overheat_lp_02 delete();

    if ( var_0 )
    {
        wait 2.7;
        playsoundatpos( var_2, "alien_laser_drill_door_open" );
        return;
    }
}

sfx_drill_offline()
{
    var_0 = get_drill_entity();

    if ( level.script == "mp_alien_dlc3" )
        level.drill playsound( "alien_drill_scanner_shutdown" );
    else
        var_0 playsound( "alien_laser_drill_shutdown" );

    if ( isdefined( level.drill_sfx_lp ) )
        level.drill_sfx_lp delete();

    if ( isdefined( level.drill_sfx_dist_lp ) )
        level.drill_sfx_dist_lp delete();

    if ( isdefined( level.drill_overheat_lp_02 ) )
    {
        level.drill_overheat_lp_02 delete();
        return;
    }
}

_ID10923( var_0 )
{
    drill_generic_bbprint( "aliendrillplant", var_0 );
}

drill_reset_bbprint( var_0 )
{
    drill_generic_bbprint( "aliendrillreset", var_0 );
}

drill_generic_bbprint( var_0, var_1 )
{
    var_2 = level.current_cycle_num;
    var_3 = "unknown hive";

    if ( isdefined( self.target ) )
        var_3 = self.target;

    var_4 = gettime() - level._ID31480;
    var_5 = "unknown player";

    if ( isdefined( var_1.name ) )
        var_5 = var_1.name;

    var_6 = level.players.size;
    var_7 = var_1 maps\mp\alien\_persistence::_ID14747();
    var_8 = var_1 maps\mp\alien\_persistence::_ID14645();
    var_9 = var_1 maps\mp\alien\_persistence::_ID14748();
    var_10 = var_1 maps\mp\alien\_persistence::get_perk_1_level();
    var_11 = -1;

    if ( isdefined( level.drill ) && isdefined( level.drill.health ) && isdefined( level.drill_health_hardcore ) )
        var_11 = ( level.drill.health - 20000 ) / level.drill_health_hardcore;

    bbprint( var_0, "cyclenum %i hivename %s playtime %f drillhealth %f repairer %s repairerperk0 %s repairerperk1 %s repairerperk0level %s repairerperk1level %s playernum %i ", var_2, var_3, var_4, var_11, var_5, var_7, var_9, var_8, var_10, var_6 );
}

check_for_player_near_hive_with_drill()
{
    if ( maps\mp\alien\_unk1464::_ID18506( level._ID36752 ) )
        return;

    self endon( "disconnect" );
    var_0 = 6400;

    for (;;)
    {
        while ( !common_scripts\utility::_ID13177( "drill_drilling" ) )
        {
            if ( isdefined( self._ID18011 ) && self._ID18011 || common_scripts\utility::_ID13177( "drill_drilling" ) || isdefined( self.usingremote ) || maps\mp\alien\_unk1464::_ID18506( self._ID18582 ) )
            {
                wait 0.05;
                continue;
            }

            foreach ( var_2 in level._ID31986 )
            {
                if ( var_2 _ID36640::is_blocker_hive() )
                    continue;

                if ( !var_2 _ID36640::dependent_hives_removed() )
                    continue;

                if ( distancesquared( var_2.origin, self.origin ) < var_0 )
                {
                    if ( !isdefined( level.drill_carrier ) || isdefined( level.drill_carrier ) && level.drill_carrier != self )
                    {
                        maps\mp\_utility::setlowermessage( "need_drill", &"ALIEN_COLLECTIBLES_NEED_DRILL", undefined, 10 );

                        while ( player_should_see_drill_hint( var_2, var_0, 1 ) )
                            wait 0.05;

                        maps\mp\_utility::_ID7495( "need_drill" );
                        continue;
                    }

                    maps\mp\_utility::setlowermessage( "plant_drill", &"ALIEN_COLLECTIBLES_PLANT_BOMB", undefined, 10 );

                    while ( player_should_see_drill_hint( var_2, var_0, 0 ) )
                        wait 0.05;

                    maps\mp\_utility::_ID7495( "plant_drill" );
                }
            }

            wait 0.05;
        }

        common_scripts\utility::_ID13216( "drill_drilling" );
    }
}

player_should_see_drill_hint( var_0, var_1, var_2 )
{
    if ( distancesquared( var_0.origin, self.origin ) > var_1 )
        return 0;

    if ( common_scripts\utility::_ID13177( "drill_drilling" ) )
        return 0;

    if ( self._ID18011 )
        return 0;

    if ( isdefined( self.usingremote ) )
        return 0;

    if ( maps\mp\alien\_unk1464::_ID18506( var_2 ) )
        return 1;
    else if ( maps\mp\alien\_unk1464::_ID18506( self._ID18582 ) )
        return 0;

    return 1;
}

get_drill_entity()
{
    if ( isdefined( level.drill._ID34941 ) )
    {
        return level.drill._ID34941;
        return;
    }

    return level.drill;
    return;
}

_ID22931()
{
    level notify( "door_opening",  self.target  );

    foreach ( var_1 in self._ID25962 )
    {
        if ( isdefined( var_1 ) )
        {
            if ( var_1.classname == "script_model" )
            {
                var_1 thread slide_open();
                continue;
            }

            if ( var_1.classname == "script_brushmodel" )
                var_1 connectpaths();

            var_1 delete();
        }
    }
}

slide_open()
{
    if ( !isdefined( self._ID27441 ) )
    {
        self delete();
        return;
    }

    self moveto( self.origin + self._ID27441, 1 );
    return;
}

_ID35452()
{
    self endon( "stop_listening" );

    for (;;)
    {
        self waittill( "trigger",  var_0  );

        if ( !maps\mp\alien\_unk1464::_ID18506( level._ID36752 ) && ( !isdefined( level.drill_carrier ) || level.drill_carrier != var_0 ) )
        {
            var_0 maps\mp\_utility::setlowermessage( "no_bomb", &"ALIEN_COLLECTIBLES_NO_BOMB", 5 );
            wait 0.05;
            continue;
        }

        if ( isplayer( var_0 ) )
        {
            if ( !maps\mp\alien\_unk1464::_ID18506( level._ID36752 ) )
            {
                var_0 maps\mp\_utility::_ID7495( "go_plant" );
                var_0 takeweapon( "alienbomb_mp" );

                if ( !var_0 maps\mp\alien\_unk1464::has_special_weapon() )
                    var_0 enableweaponswitch();

                if ( !isdefined( level.non_player_drill_plant_check ) || ![[ level.non_player_drill_plant_check ]]() )
                    var_0 switchtoweapon( var_0._ID19670 );

                self makeunusable();
                self sethintstring( "" );
                _ID25908();
            }

            var_1 = 0.4;
            var_2 = 1.75;
            thread _ID36640::_ID35886( var_2, var_1 );
            var_0 maps\mp\alien\_persistence::eog_player_update_stat( "drillplants", 1 );
            level notify( "drill_planted",  var_0, self  );
            return var_0;
        }
    }
}

update_drill_health_hud()
{
    var_0 = int( ( level.drill.health - 20000 ) / level.drill_health_hardcore * 100 );
    maps\mp\alien\_hud::update_drill_health( var_0 );
}
