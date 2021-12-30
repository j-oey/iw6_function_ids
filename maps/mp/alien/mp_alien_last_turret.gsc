// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

last_turret_init()
{
    precacheitem( "killstreak_remote_turret_remote_mp" );
    precachestring( &"ALIEN_COLLECTIBLES_USE_TURRET" );
    precacheturret( "turret_dlc4_alien_shock" );
    precacheshader( "reticle_flechette" );
    last_turret_fx_init();
    common_scripts\utility::_ID13189( "boss_turrets_on" );
}

last_turret_fx_init()
{
    level._ID1644["beacon_turret_hit_fx"] = loadfx( "vfx/gameplay/alien/vfx_alien_beac_turret_hit_fx" );
    level._ID1644["beacon_turret_kraken_hit_fx"] = loadfx( "vfx/gameplay/alien/vfx_alien_arm_gun_li_cloud" );
}

set_up_remote_turrets()
{
    level.kraken_turrets = [];
    wait 1.0;
    var_0 = getentarray( "turret_use_trigger", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread remote_turret_monitoruse();

    level thread listen_for_kraken_emp();
}

remote_turret_monitoruse()
{
    level endon( "game_ended" );
    self endon( "turret_is_broken" );
    wait 0.05;
    var_0 = build_turret_func();
    var_0._ID17490 = 0;
    var_0.overloaded = 0;
    var_0.reloading = 0;
    var_0.off = 0;
    var_1 = var_0._ID33995;
    var_0.use_trigger = self;
    var_0 makeunusable();

    if ( isdefined( level.shock_turret_ammo_override ) )
    {
        var_1 = level.shock_turret_ammo_override;
        var_0._ID33995 = level.shock_turret_ammo_override;
    }

    self makeusable();
    self sethintstring( &"ALIEN_COLLECTIBLES_ACTIVATE_TURRET" );
    self setmodel( "tag_origin" );

    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
    {
        self.outline_model = getent( self.script_noteworthy, "targetname" );
        maps\mp\alien\_outline_proto::add_to_outline_watch_list( self.outline_model, 750 );
    }

    var_0 thread watch_for_turret_reloading();
    var_0 thread watch_for_turret_overloading();
    level.kraken_turrets[level.kraken_turrets.size] = var_0;

    if ( !var_0.off )
        var_0 maps\mp\_utility::_ID9519( 2, ::play_turret_fx, 0 );
    else
    {
        var_0 maps\mp\_utility::_ID9519( 2, ::play_turret_fx, 1 );
        self sethintstring( "" );
    }

    for (;;)
    {
        self waittill( "trigger",  var_2  );

        if ( !isplayer( var_2 ) )
            continue;

        if ( var_2 maps\mp\alien\_unk1464::_ID18431() )
        {
            var_2 maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HOLDING", 3 );
            continue;
        }

        if ( var_0._ID17490 )
            continue;

        if ( var_0.off )
            continue;

        if ( maps\mp\alien\_unk1464::_ID18506( var_2._ID18582 ) )
            continue;

        if ( isdefined( level.drill_carrier ) && level.drill_carrier == var_2 )
            continue;

        if ( var_0.overloaded )
        {
            var_2 maps\mp\_utility::setlowermessage( "cant_buy", &"MP_ALIEN_LAST_TURRET_OFFLINE", 3 );
            continue;
        }

        if ( var_0.reloading )
        {
            var_2 maps\mp\_utility::setlowermessage( "cant_buy", &"MP_ALIEN_LAST_TURRET_RELOADING", 3 );
            continue;
        }

        while ( !var_2 isonground() )
            wait 0.1;

        var_3 = int( 750 * var_2 maps\mp\alien\_perk_utility::_ID23440() );

        if ( !var_0 is_turret_enabled() )
        {
            if ( var_2 _ID6524( var_3 ) )
            {
                var_2 maps\mp\alien\_persistence::_ID32387( var_3, 1, "trap" );
                self sethintstring( "" );
                var_0._ID11491 = 1;
                self.outline_model._ID11491 = 1;
                var_0._ID33995 = int( var_1 * var_2 maps\mp\alien\_perk_utility::_ID23442() );
                var_2 maps\mp\alien\_unk1464::_ID28592( var_0._ID33995 );
                var_0._ID17490 = 1;
                var_0 enable_turret_use();
                var_0 thread _ID34034( var_2 );
                var_0.owner = var_2;
                maps\mp\alien\_outline_proto::_ID25902( self.outline_model );
            }
            else
                var_2 maps\mp\_utility::setlowermessage( "no_money", &"ALIEN_COLLECTIBLES_NO_MONEY", 3 );

            continue;
        }

        var_0._ID17490 = 1;
        var_2 maps\mp\alien\_unk1464::_ID28592( var_0._ID33995 );
        var_0 enable_turret_use();
        var_0 thread _ID34034( var_2 );
        var_0.owner = var_2;
        maps\mp\alien\_outline_proto::_ID25902( self.outline_model );
    }
}

build_turret_func()
{
    var_0 = getent( self.target, "targetname" );
    var_1 = "mg_turret";
    var_2 = "turret_dlc4_alien_shock";
    var_3 = "killstreak_remote_turret_remote_mp";
    var_4 = "weapon_standing_turret_chaingun";
    var_5 = "used_minigun_turret";
    var_6 = spawnturret( "misc_turret", var_0.origin, var_2 );
    var_6.angles = var_0.angles;
    var_6 setmodel( var_4 );
    var_6.weaponinfo = var_2;
    var_0 delete();
    var_6.health = 100;
    var_6._ID34107 = var_1;
    var_6._ID33995 = 300;
    var_6 setturretmodechangewait( 1 );
    var_6 setdefaultdroppitch( 0.0 );
    var_6 maketurretsolid();
    var_6._ID11491 = 0;
    var_7 = getentarray( "turret_trigger_use_touch", "targetname" );

    if ( var_7.size > 0 )
    {
        if ( var_7.size > 1 )
            var_7 = common_scripts\utility::_ID14293( self.origin, var_7 );

        var_6.actual_use_trigger = var_7[0];
    }

    return var_6;
}

_ID34034( var_0 )
{
    level endon( "game_ended" );
    level notify( "beacon_turret_used" );

    while ( !isdefined( self._ID33995 ) )
        wait 0.05;

    self.use_trigger hide();
    self.owner = var_0;
    var_0._ID18582 = 1;
    self._ID23149 = 0;
    var_0.pressed_use = 0;
    var_0.is_using_remote_turret = 1;
    thread send_notify_on_player_disconnect( var_0 );
    move_player_camera_to_turret( var_0 );
    play_turret_fx( 0 );
    thread monitor_player_exit( var_0 );
    thread _ID35933( var_0 );
    thread wait_for_turret_to_spin_up();
    thread check_player_state_and_stop_using_turret( var_0 );
    _ID35450();
    _ID10134();
}

send_notify_on_player_disconnect( var_0 )
{
    self endon( "stop_watching" );
    var_0 waittill( "disconnect" );
    self notify( "user_disconnected" );
    self.owner = undefined;
    self._ID17490 = 0;
    self notify( "exit" );
    self notify( "player_exit" );
    self.use_trigger show();
    self.use_trigger sethintstring( &"ALIEN_COLLECTIBLES_USE_TURRET" );
    maps\mp\alien\_outline_proto::add_to_outline_watch_list( self.use_trigger.outline_model, 750 );
    self notify( "stop_watching" );
}

move_player_camera_to_turret( var_0 )
{
    var_0 maps\mp\_utility::_giveweapon( "killstreak_remote_turret_remote_mp" );
    var_0 switchtoweapon( "killstreak_remote_turret_remote_mp" );

    if ( getdvarint( "camera_thirdPerson" ) )
        var_0 maps\mp\_utility::_ID28902( 0 );

    var_0 maps\mp\_utility::_ID29199( self._ID34107 );
    var_0 playerlinkweaponviewtodelta( self, "tag_player", 1, 80, 80, 25, 25, 0 );
    var_0 playerlinkedsetviewznear( 0 );
    var_0 playerlinkedsetusebaseangleforviewclamp( 1 );
    var_0 remotecontrolturret( self );
    var_0 maps\mp\_utility::_ID7495( "enter_remote_turret" );
    var_0 maps\mp\alien\_unk1464::_ID10113();
    var_0 maps\mp\alien\_unk1464::_ID29953( 2 );
    var_0 maps\mp\alien\_unk1464::_ID28592( self._ID33995 );
    var_0 setclientomnvar( "ui_alien_turret_overheat", 0 );
    thread _ID34043( var_0 );
    thread _ID34002();
    var_0 maps\mp\_utility::setlowermessage( "disengage_turret", &"ALIEN_COLLECTIBLES_DISENGAGE_TURRET", 4 );
    var_0 add_reticle_to_player_view();
}

_ID35450()
{
    self waittill( "disable_turret" );
}

listen_for_player_use_button()
{
    self endon( "stop_watching" );
    self.owner endon( "disconnect" );

    while ( self.owner usebuttonpressed() )
        wait 0.05;

    for (;;)
    {
        var_0 = 0;

        while ( self.owner usebuttonpressed() )
        {
            var_0 += 0.05;
            wait 0.05;

            if ( var_0 > 0.5 )
            {
                self.owner notify( "player_pressed_use" );
                wait 2.0;
            }
        }

        wait 0.05;
    }
}

_ID35933( var_0 )
{
    self endon( "disable_turret" );
    self endon( "player_exit" );
    self.owner endon( "disconnect" );
    thread zap_periodically_when_firing( var_0 );
    var_1 = 0;
    var_2 = self._ID33995;
    var_3 = weaponfiretime( self.weaponinfo );

    for (;;)
    {
        self waittill( "turret_fire" );
        self getturretowner() notify( "turret_fire" );
        self.heatlevel = self.heatlevel + var_3;
        var_1++;
        self.cooldownwaittime = var_3;
        self._ID33995 = var_2 - var_1;

        if ( var_1 >= var_2 )
        {
            self._ID33995 = 0;
            self.owner maps\mp\alien\_unk1464::_ID28592( self._ID33995 );
            break;
        }

        self.owner maps\mp\alien\_unk1464::_ID28592( self._ID33995 );
    }

    if ( isdefined( self.owner ) && isalive( self.owner ) )
        self.owner thread maps\mp\alien\_unk1464::wait_for_player_to_dismount_turret();

    self.reloading = 1;
    self.owner setclientomnvar( "ui_alien_turret_overheat", -1 );
    self notify( "disable_turret" );
}

wait_for_turret_to_spin_up()
{
    self endon( "disable_turret" );
    self endon( "player_exit" );

    for (;;)
    {
        if ( !self._ID23149 )
            self turretfireenable();
        else
            self turretfiredisable();

        wait 0.1;
    }
}

wait_for_player_to_dismount_remote_turret()
{
    self endon( "death" );
    self endon( "disconnect" );
    maps\mp\_utility::setlowermessage( "disengage_turret", &"ALIEN_COLLECTIBLES_DISENGAGE_TURRET", 0 );

    while ( maps\mp\_utility::_ID18837() )
        wait 0.5;

    maps\mp\_utility::_ID7495( "disengage_turret" );
}

watch_for_turret_reloading()
{
    if ( isdefined( level.shock_turret_reload_time_override ) )
        var_0 = level.shock_turret_reload_time_override;
    else
        var_0 = 25;

    while ( !isdefined( self.broken ) )
    {
        if ( self.reloading && !self.overloaded )
        {
            thread play_turret_fx( 1 );
            self.use_trigger sethintstring( "" );
            maps\mp\alien\_outline_proto::_ID25902( self.use_trigger.outline_model );
            wait(var_0 - 5);

            if ( self.overloaded )
            {
                self.reloading = 0;
                break;
            }

            thread play_turret_fx( 0 );
            wait 5;

            if ( self.overloaded )
            {
                self.reloading = 0;
                break;
            }

            maps\mp\alien\_outline_proto::add_to_outline_watch_list( self.use_trigger.outline_model, 750 );
            self.reloading = 0;
            self.use_trigger sethintstring( &"ALIEN_COLLECTIBLES_ACTIVATE_TURRET" );
        }

        wait 0.1;
    }

    self.reloading_func_done = 1;
}

watch_for_turret_overloading()
{
    level waittill( "traps_disabled" );
    self.overloaded = 1;
    level thread maps\mp\mp_alien_last_traps::play_disabled_fx( self.use_trigger.outline_model );
    self.use_trigger sethintstring( &"MP_ALIEN_LAST_TURRET_OFFLINE" );
    maps\mp\alien\_outline_proto::_ID25902( self.use_trigger.outline_model );
    maps\mp\alien\_outline_proto::enable_outline( self.use_trigger.outline_model, 4, 1 );
    level waittill( "traps_reenabled" );
    self.overloaded = 0;
    self.reloading = 0;
    self.use_trigger sethintstring( &"ALIEN_COLLECTIBLES_ACTIVATE_TURRET" );
    self.overloading_func_done = 1;
    maps\mp\alien\_outline_proto::add_to_outline_watch_list( self.use_trigger.outline_model, 750 );
}

listen_for_kraken_emp()
{
    common_scripts\utility::flag_wait( "boss_turrets_on" );

    while ( !isdefined( level.kraken ) )
        wait 0.1;

    var_0 = undefined;

    for (;;)
    {
        var_1 = level.kraken common_scripts\utility::waittill_any_return_no_endon_death( "kraken_emp", "kraken_emp_stage_2", "kraken_emp_stage_3" );

        foreach ( var_3 in level.kraken_turrets )
        {
            var_3.overloaded = 1;

            if ( var_1 == "kraken_emp_stage_2" )
            {
                if ( isdefined( var_3.use_trigger.script_noteworthy ) && var_3.use_trigger.script_noteworthy == "turret_console_lower_right" )
                    var_0 = var_3;
            }

            if ( var_1 == "kraken_emp_stage_3" )
            {
                if ( isdefined( var_3.use_trigger.script_noteworthy ) && var_3.use_trigger.script_noteworthy == "turret_console_lower_left" )
                    var_0 = var_3;
            }
        }

        if ( isdefined( var_0 ) )
        {
            var_0 notify( "disable_turret" );
            var_0.use_trigger notify( "turret_is_broken" );
            var_0.use_trigger turret_is_broken( var_0 );
        }
    }
}

is_turret_enabled()
{
    return self._ID11491;
}

is_remote_enabled()
{
    return self._ID11491;
}

_ID10134()
{
    self._ID11491 = 0;
    self.use_trigger sethintstring( &"ALIEN_COLLECTIBLES_ACTIVATE_TURRET" );
    self turretfiredisable();
    self maketurretinoperable();

    if ( isdefined( self.outline_model ) )
    {
        self.outline_model._ID11491 = 0;
        return;
    }
}

play_turret_fx( var_0 )
{
    return;
}

play_broken_fx()
{
    return;
}

enable_turret_use()
{
    self sethintstring( "" );
    self turretfireenable();
    self maketurretoperable();
}

_ID6524( var_0 )
{
    return maps\mp\alien\_persistence::player_has_enough_currency( var_0 );
}

monitor_player_exit( var_0 )
{
    self endon( "turret_disabled" );
    thread listen_for_player_use_button();

    for (;;)
    {
        var_0 waittill( "player_pressed_use" );
        self.use_trigger sethintstring( &"ALIEN_COLLECTIBLES_USE_TURRET" );
        maps\mp\alien\_outline_proto::add_to_outline_watch_list( self.use_trigger.outline_model, 750 );
        var_0.pressed_use = 1;
    }
}

_ID34002()
{
    self endon( "death" );
    self notify( "stop_cooldown_monitor" );
    self endon( "stop_cooldown_monitor" );
    self endon( "turret_disabled" );
    self endon( "disable_turret" );
    self endon( "exit" );

    for (;;)
    {
        if ( self.heatlevel > 0 )
        {
            if ( self.cooldownwaittime <= 0 )
                self.heatlevel = max( 0, self.heatlevel - 0.05 );
            else
                self.cooldownwaittime = max( 0, self.cooldownwaittime - 0.05 );
        }

        wait 0.05;
    }
}

_ID34043( var_0 )
{
    self notify( "overheat_monitor" );
    self endon( "overheat_monitor" );
    self endon( "turret_disabled" );
    self endon( "disable_turret" );
    self endon( "exit" );
    var_0 endon( "disconnect" );
    self.heatlevel = 0;

    if ( isdefined( level.shock_turret_heat_override ) )
        var_1 = level.shock_turret_heat_override;
    else
        var_1 = 2.5;

    self.cooldownwaittime = 1;
    var_2 = 0;

    for (;;)
    {
        if ( !maps\mp\_utility::_ID18757( var_0 ) )
        {
            self._ID18319 = undefined;
            var_0 setclientomnvar( "ui_alien_turret_overheat", -1 );
            break;
        }

        if ( self.heatlevel >= var_1 )
        {
            var_3 = 1;
            thread turret_overheat_disable();
        }
        else
            var_3 = self.heatlevel / var_1;

        var_4 = 5;
        var_5 = int( var_3 * 100 );

        if ( var_2 != var_5 )
        {
            if ( var_5 <= var_4 || abs( abs( var_2 ) - abs( var_5 ) ) > var_4 )
            {
                var_0 setclientomnvar( "ui_alien_turret_overheat", var_5 );
                var_2 = var_5;
            }
        }

        wait 0.05;
    }

    var_0 setclientomnvar( "ui_alien_turret_overheat", -1 );
}

turret_overheat_disable()
{
    self endon( "turret_disabled" );
    self endon( "disable_turret" );
    self endon( "exit" );
    self._ID23149 = 1;

    while ( self.heatlevel > 0 )
        wait 0.1;

    self._ID23149 = 0;
}

_ID7469( var_0 )
{
    self notify( "clearammocounterondeath" );
    self endon( "clearammocounterondeath" );
    var_0 endon( "disconnect" );
    self waittill( "turret_disabled" );
    var_0 maps\mp\alien\_unk1464::hide_turret_icon();
    var_0 maps\mp\_utility::_ID7495( "disengage_turret" );
}

clear_turret_ammo_counter_on_dismount( var_0 )
{
    self notify( "dimountammocounter" );
    self endon( "dismountammocounter" );
    var_0 endon( "disconnect" );
    var_0 maps\mp\alien\_unk1464::hide_turret_icon();
    var_0 maps\mp\_utility::_ID7495( "disengage_turret" );

    if ( var_0 getcurrentweapon() == "none" )
    {
        var_0 thread _ID26192();
        return;
    }
}

_ID26192()
{
    var_0 = self getweaponslistprimaries();

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && var_2 != "none" )
        {
            self switchtoweapon( var_2 );
            break;
        }
    }
}

zap_periodically_when_firing( var_0 )
{
    self endon( "player_exit" );

    while ( self._ID33995 > 0 )
    {
        self waittill( "turret_fire" );

        if ( self.heatlevel > 0.1 )
        {
            var_1 = self gettagorigin( "tag_player" );
            var_2 = vectornormalize( anglestoforward( self gettagangles( "tag_player" ) ) );
            var_3 = var_1 + var_2 * 10000;
            var_4 = bullettrace( var_1, var_3, 1, undefined, 1, 1 );

            if ( isdefined( var_4["position"] ) )
            {
                var_5 = var_4["position"];

                if ( isdefined( var_4["entity"] ) && isdefined( var_4["entity"].agent_type ) && ( var_4["entity"].agent_type == "kraken_tentacle" || var_4["entity"].agent_type == "kraken" ) )
                    zap_aliens( var_5, var_4["entity"].agent_type );
                else
                    zap_aliens( var_5 );
            }

            wait 0.5;
        }

        wait 0.1;
    }
}

zap_aliens( var_0, var_1 )
{
    var_2 = 62500;

    if ( self.heatlevel > 0.5 )
        var_2 = 122500;

    if ( self.heatlevel > 0.75 )
        var_2 = 250000;

    var_3 = maps\mp\alien\_spawnlogic::_ID14265();

    if ( isdefined( level.seeder_active_turrets ) )
        var_3 = common_scripts\utility::array_combine( var_3, level.seeder_active_turrets );

    var_4 = [];

    foreach ( var_6 in var_3 )
    {
        if ( distancesquared( var_0, var_6.origin ) < var_2 )
            var_4[var_4.size] = var_6;
    }

    var_8 = 0;
    var_9 = 4;

    if ( !isdefined( self.death_struct ) )
    {
        self.death_struct = spawnstruct();
        self.death_struct.attack_bolt = spawn( "script_model", var_0 );
        self.death_struct.attack_bolt setmodel( "tag_origin" );

        if ( isdefined( level.shock_turret_arc_damage_override ) )
            self.death_struct.damage_amount = level.shock_turret_arc_damage_override;
        else
            self.death_struct.damage_amount = 200;

        common_scripts\utility::_ID35582();
        self.death_struct.attack_bolt.origin = var_0;
    }

    self.death_struct.attack_bolt.origin = var_0;

    if ( var_4.size < 1 )
    {
        for ( var_8 = 0; var_8 < var_9; var_8++ )
        {
            if ( isdefined( var_1 ) )
            {
                level.zap_the_kraken_time = 2;
                turret_tesla_bolt_no_target( var_0, var_1 );
            }
            else
                turret_tesla_bolt_no_target( var_0 );

            if ( randomint( 2 ) == 0 )
                break;

            wait 0.1;
        }
    }
    else
    {
        foreach ( var_6 in var_4 )
        {
            if ( isdefined( var_6 ) )
            {
                var_6 turret_tesla_bolt_death( self );
                var_8++;

                if ( var_8 >= var_9 )
                    break;

                wait 0.1;
            }
        }
    }

    wait 0.05;
    killfxontag( level._ID1644["tesla_attack"], self.death_struct.attack_bolt, "TAG_ORIGIN" );
    killfxontag( level._ID1644["tesla_shock"], self.death_struct.attack_bolt, "TAG_ORIGIN" );
    killfxontag( level._ID1644["beacon_turret_kraken_hit_fx"], self.death_struct.attack_bolt, "TAG_ORIGIN" );
}

turret_tesla_bolt_death( var_0 )
{
    common_scripts\utility::_ID35582();
    playfxontag( level._ID1644["tesla_attack"], var_0.death_struct.attack_bolt, "TAG_ORIGIN" );
    playfxontag( level._ID1644["beacon_turret_hit_fx"], var_0.death_struct.attack_bolt, "tag_origin" );
    var_1 = undefined;

    if ( isdefined( self.alien_type ) && self.alien_type == "seeder_spore" )
        var_1 = self gettagorigin( "J_Spore_46" );
    else if ( isdefined( self ) && isalive( self ) && maps\mp\alien\_unk1464::has_tag( self.model, "J_SpineUpper" ) )
        var_1 = self gettagorigin( "J_SpineUpper" );

    if ( isdefined( var_1 ) )
    {
        var_0.death_struct.attack_bolt moveto( var_1, 0.05 );
        wait 0.05;

        if ( isdefined( self ) && distancesquared( self.origin, var_0.death_struct.attack_bolt.origin ) > 40000 )
            playfxontag( level._ID1644["beacon_turret_hit_fx"], var_0.death_struct.attack_bolt, "tag_origin" );

        if ( isdefined( self ) )
            self playsound( "turret_shock" );

        wait 0.05;

        if ( isdefined( self ) )
        {
            var_2 = self;

            if ( isdefined( self.alien_type ) && self.alien_type == "ancestor" && self.shield_state == 1 )
                var_2 = undefined;
            else if ( isdefined( self.alien_type ) && self.alien_type == "seeder_spore" )
                var_2 = self.coll_model;

            if ( isdefined( var_2 ) )
                var_2 dodamage( var_0.death_struct.damage_amount, self.origin, var_0.owner, var_0 );
        }
    }

    stopfxontag( level._ID1644["tesla_attack"], var_0.death_struct.attack_bolt, "TAG_ORIGIN" );
}

turret_tesla_bolt_no_target( var_0, var_1 )
{
    var_2 = self;
    common_scripts\utility::_ID35582();
    playfxontag( level._ID1644["tesla_attack"], var_2.death_struct.attack_bolt, "TAG_ORIGIN" );

    if ( isdefined( var_1 ) && var_1 == "kraken" )
        playfxontag( level._ID1644["beacon_turret_kraken_hit_fx"], var_2.death_struct.attack_bolt, "tag_origin" );
    else
        playfxontag( level._ID1644["tesla_shock"], var_2.death_struct.attack_bolt, "tag_origin" );

    var_3 = 4;
    var_4 = self gettagorigin( "tag_player" );

    for ( var_5 = 0; var_5 < var_3; var_5++ )
    {
        if ( isdefined( var_1 ) )
            var_6 = var_0 + ( randomintrange( -300, 300 ), randomintrange( -300, 300 ), randomintrange( -300, 300 ) );
        else
            var_6 = var_0 + ( randomintrange( -150, 150 ), randomintrange( -150, 150 ), 0 );

        if ( isdefined( var_1 ) )
        {
            var_4 = self gettagorigin( "tag_player" );
            var_7 = bullettrace( var_4, var_6, 1, undefined, 1, 1 );

            if ( !isdefined( var_7["entity"] ) || !isdefined( var_7["entity"].agent_type ) )
                continue;
        }
        else
            var_7 = bullettrace( var_4, var_6, 1 );

        if ( isdefined( var_7["position"] ) )
        {
            if ( distancesquared( var_7["position"], var_2.death_struct.attack_bolt.origin ) < 10000 )
                continue;

            if ( !isdefined( var_1 ) && var_7["position"][2] > var_0[2] + 20 )
                continue;

            var_0 = var_7["position"];
            break;
        }
    }

    var_8 = var_0 + ( 0, 0, 5 );
    var_2.death_struct.attack_bolt moveto( var_8, 0.05 );
    wait 0.05;

    if ( isdefined( self ) && distancesquared( self.origin, var_2.death_struct.attack_bolt.origin ) > 40000 )
    {
        if ( isdefined( var_1 ) && var_1 == "kraken" )
        {
            playfxontag( level._ID1644["beacon_turret_kraken_hit_fx"], var_2.death_struct.attack_bolt, "tag_origin" );
            thread sfx_kraken_shock( var_8 );
        }
        else
            playfxontag( level._ID1644["tesla_shock"], var_2.death_struct.attack_bolt, "tag_origin" );
    }

    wait 0.2;
    stopfxontag( level._ID1644["tesla_shock"], var_2.death_struct.attack_bolt, "TAG_ORIGIN" );
    stopfxontag( level._ID1644["beacon_turret_kraken_hit_fx"], var_2.death_struct.attack_bolt, "TAG_ORIGIN" );
    stopfxontag( level._ID1644["tesla_attack"], var_2.death_struct.attack_bolt, "TAG_ORIGIN" );
}

stop_using_turret( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );

    if ( maps\mp\_utility::_ID18837() )
    {
        self remotecontrolturretoff( var_0 );
        self unlink();
        self switchtoweapon( common_scripts\utility::_ID15114() );
        maps\mp\_utility::_ID7513();
        self notify( "exit_turret" );
        var_0 notify( "stop_watching" );

        if ( getdvarint( "camera_thirdPerson" ) )
            maps\mp\_utility::_ID28902( 1 );

        var_2 = self getweaponslistexclusives();

        foreach ( var_4 in var_2 )
            self takeweapon( var_4 );

        maps\mp\alien\_unk1464::hide_turret_icon();
        maps\mp\alien\_unk1464::_ID11463();
        var_0.owner = undefined;
        self setclientomnvar( "ui_alien_turret_overheat", -1 );
        maps\mp\_utility::_ID7495( "disengage_turret" );
        self.is_using_remote_turret = 0;
        var_0._ID17490 = 0;
        self._ID18582 = 0;
    }

    maps\mp\_utility::_ID7495( "disengage_turret" );
    maps\mp\_utility::_ID7495( "early_exit" );
    var_0 notify( "exit" );
    var_0 notify( "player_exit" );
    clear_turret_reticle();
    var_0.use_trigger show();
}

check_player_state_and_stop_using_turret( var_0 )
{
    var_0 endon( "disconnect" );

    for (;;)
    {
        if ( !isdefined( self.owner ) || self.owner != var_0 )
            break;

        if ( var_0 maps\mp\alien\_unk1464::_ID18437() )
            break;

        if ( var_0.health <= 1 )
            break;

        if ( maps\mp\alien\_unk1464::_ID18506( var_0.pressed_use ) )
            break;

        if ( maps\mp\alien\_unk1464::_ID18506( self.broken ) )
            break;

        if ( self.overloaded )
            break;

        if ( self.reloading )
        {
            wait 0.5;
            break;
        }

        wait 0.1;
    }

    if ( isdefined( var_0 ) )
    {
        var_0 stop_using_turret( self, self._ID34107 );
        return;
    }
}

add_reticle_to_player_view()
{
    self.beacon_turret_icon = [];
    var_0 = "reticle_flechette";
    self.beacon_turret_icon["hud_center"] = maps\mp\gametypes\_hud_util::_ID8444( var_0, 32, 32 );
    self.beacon_turret_icon["hud_center"] _ID28286();
    self.beacon_turret_icon["hud_center"].alignx = "center";
    self.beacon_turret_icon["hud_center"].aligny = "middle";
    self.beacon_turret_icon["hud_center"].alpha = 1.0;
}

_ID28286()
{
    self.alignx = "left";
    self.aligny = "top";
    self.horzalign = "center";
    self.vertalign = "middle";
    self.hidewhendead = 0;
    self.hidewheninmenu = 0;
    self.sort = 205;
    self.foreground = 1;
    self.alpha = 0.65;
}

clear_turret_reticle()
{
    if ( isdefined( self.beacon_turret_icon["hud_center"] ) )
    {
        self.beacon_turret_icon["hud_center"] destroy();
        self.beacon_turret_icon["hud_center"] = undefined;
        return;
    }
}

turret_is_broken( var_0 )
{
    var_0.broken = 1;

    while ( !( isdefined( var_0.reloading_func_done ) && isdefined( var_0.overloading_func_done ) ) )
        wait 0.1;

    var_0 _ID10134();
    self makeunusable();
    self sethintstring( "" );
    maps\mp\alien\_outline_proto::_ID25902( self.outline_model );
    var_0 thread play_broken_fx();
    playfx( level._ID1644["electrical_sparks_20_funner"], self.origin );
}

test_hud_on_player()
{
    wait 10;

    foreach ( var_1 in level.players )
        var_1 add_reticle_to_player_view();
}

debug_print_posrot( var_0 )
{
    if ( maps\mp\alien\_unk1464::has_tag( self.model, var_0 ) )
    {
        var_1 = self gettagorigin( var_0 );
        var_2 = self gettagangles( var_0 );
    }
    else
    {
        var_1 = self gettagorigin( "tag_origin" );
        var_2 = self gettagangles( "tag_origin" );
    }

    iprintln( "origin: " + var_1[0] + ", " + var_1[1] + ", " + var_1[2] );
    iprintln( "angles: " + var_2[0] + ", " + var_2[1] + ", " + var_2[2] );
}

sfx_kraken_shock( var_0 )
{
    if ( !isdefined( level.kraken_shock_sfx ) )
        level.kraken_shock_sfx = 0;

    if ( level.kraken_shock_sfx == 0 )
    {
        level.kraken_shock_sfx = 1;
        playsoundatpos( var_0, "kraken_big_shock" );
        wait 1.8;
        level.kraken_shock_sfx = 0;
        return;
    }

    playsoundatpos( var_0, "kraken_small_shock" );
    return;
}
