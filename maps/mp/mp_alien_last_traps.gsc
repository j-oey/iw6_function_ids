// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    var_0 = getentarray( "tesla_trap_switch", "targetname" );
    level.tesla_traps = [];

    foreach ( var_2 in var_0 )
    {
        maps\mp\alien\_outline_proto::add_to_outline_watch_list( var_2, 750 );
        var_3 = getentarray( var_2.target, "targetname" );
        common_scripts\utility::_ID3867( var_3, ::init_tesla_trap );
        var_2.teslas = var_3;
        var_2 thread wait_for_tesla_switch_activation( var_3 );
        level.tesla_traps[level.tesla_traps.size] = var_2;
    }

    if ( !maps\mp\alien\_unk1464::is_chaos_mode() )
    {
        level thread disable_traps_when_ancestor_attacks();
        level thread setup_trap_repair_generator();
    }
}

init_tesla_trap()
{
    self hidepart( "tag_tesla_swap_small" );
    self hidepart( "tag_tesla_swap_med" );
    self.tesla_type = "tesla_trap";
}

wait_for_tesla_switch_activation( var_0 )
{
    self endon( "stop_tesla_trap" );
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( &"MP_ALIEN_LAST_USE_TESLA" );
    self makeusable();

    for (;;)
    {
        self waittill( "trigger",  var_1  );

        if ( !isdefined( var_1 ) || !isalive( var_1 ) )
            continue;

        if ( var_1 maps\mp\alien\_unk1464::_ID18431() || var_1 maps\mp\alien\_unk1464::has_special_weapon() )
        {
            var_1 maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HOLDING", 3 );
            continue;
        }

        if ( !var_1 maps\mp\alien\_persistence::player_has_enough_currency( 750 ) )
        {
            var_1 maps\mp\_utility::setlowermessage( "no_money", &"ALIEN_COLLECTIBLES_NO_MONEY", 3 );
            continue;
        }

        var_1 maps\mp\alien\_persistence::_ID32387( 750, 0, "trap" );
        self.owner = var_1;
        level thread maps\mp\alien\_music_and_dialog::_ID24698( var_1, "tesla_trap" );

        if ( !isdefined( self.script_noteworthy ) || self.script_noteworthy != "tesla_generator" )
            self setmodel( "mp_zeb_garage_switch_on" );
        else
            self playloopsound( "alien_fence_gen_lp" );

        self makeunusable();
        maps\mp\alien\_outline_proto::_ID25902( self );

        foreach ( var_3 in var_0 )
        {
            var_3.owner = var_1;
            var_3 thread run_tesla_trap();
        }

        wait 150;

        if ( !isdefined( self.script_noteworthy ) || self.script_noteworthy != "tesla_generator" )
            self setmodel( "mp_zeb_garage_switch_off" );
        else
            self stoploopsound( "alien_fence_gen_lp" );

        if ( isdefined( var_0[0].owner ) && isalive( var_0[0].owner ) && var_0[0].owner.sessionstate == "playing" )
            var_0[0].owner maps\mp\_utility::setlowermessage( "electric_fence_offline", &"ALIENS_PATCH_ELECTRIC_TRAP_OFFLINE", 3 );

        foreach ( var_3 in var_0 )
        {
            var_3 notify( "trap_done" );
            wait 0.5;
            var_3 stoploopsound();
            var_3.owner = undefined;
            stopfxontag( level._ID1644["tesla_idle3"], var_3, "tag_fx_01" );

            if ( isdefined( var_3.attack_bolt ) )
                var_3.attack_bolt delete();
        }

        maps\mp\alien\_outline_proto::add_to_outline_watch_list( self, 750 );
        self makeusable();
    }
}

run_tesla_trap()
{
    self endon( "trap_done" );

    if ( !maps\mp\alien\_unk1464::_ID18506( self._ID37808 ) )
    {
        self._ID37808 = 1;
        self playloopsound( "alien_fence_hum_lp" );
    }

    self.fire_rate = 1.5;
    self.damage_amount = 1800;

    if ( !isdefined( self.attack_bolt ) )
    {
        self.attack_bolt = spawn( "script_model", self.origin + ( 0, 0, 40 ) );
        self.attack_bolt setmodel( "tag_origin" );
    }

    wait 0.5;
    playfxontag( level._ID1644["tesla_idle3"], self, "tag_fx_01" );
    var_0 = 750;
    var_1 = 250;
    var_2 = -64;
    var_3 = 128;
    var_4 = self.origin + ( 0, 0, 30 );

    for (;;)
    {
        var_5 = 0;

        foreach ( var_7 in level.agentarray )
        {
            if ( !isdefined( var_7.alien_type ) )
                continue;

            if ( !maps\mp\alien\_unk1464::_ID18506( var_7.isactive ) || !isalive( var_7 ) )
                continue;

            if ( maps\mp\alien\_unk1464::_ID18506( var_7.pet ) )
                continue;

            if ( maps\mp\alien\_unk1464::_ID18506( var_7._ID37527 ) )
                continue;

            if ( var_7.alien_type == "ancestor" && ( isdefined( var_7.shield_state ) && var_7.shield_state != 0 ) )
                continue;

            var_8 = var_7.origin + ( 0, 0, 30 );

            if ( var_7.alien_type == "ancestor" )
                var_8 = var_7 gettagorigin( "tag_weapon_chest" );
            else if ( var_7.alien_type == "elite" )
                var_8 = var_7 gettagorigin( "tag_eye" );

            var_9 = var_8[2] - var_4[2];
            var_10 = distance2d( var_8, var_4 );
            var_11 = 0;

            if ( var_9 >= 100 && var_9 <= var_0 && var_10 <= var_1 * 2 )
                var_11 = 1;
            else if ( var_9 >= 40 && var_9 <= var_0 && var_10 <= var_1 )
                var_11 = 1;
            else if ( var_9 > 0 && var_9 <= 40 && var_10 <= var_1 )
                var_11 = 1;
            else if ( var_9 <= 0 && var_9 > var_2 && var_10 <= var_1 )
                var_11 = 1;

            if ( var_11 && bullettracepassed( var_8, var_4 + ( 0, 0, 50 ), 0, self ) )
            {
                var_7._ID37527 = 1;
                var_7 thread tesla_trap_attack( self, var_8 );
                reset_attack_bolt();
                wait(self.fire_rate);
            }
        }

        wait 0.1;
    }
}

tesla_trap_attack( var_0, var_1 )
{
    self endon( "death" );
    playfxontag( level._ID1644["tesla_attack"], var_0.attack_bolt, "TAG_ORIGIN" );
    var_0.attack_bolt moveto( var_1, 0.05 );
    var_0.attack_bolt waittill( "movedone" );
    playfxontag( level._ID1644["tesla_shock"], var_0.attack_bolt, "tag_origin" );
    self playsound( "tesla_shock" );

    if ( isdefined( var_0.owner ) && isalive( var_0.owner ) )
        self dodamage( var_0.damage_amount, self.origin, var_0.owner, var_0, "MOD_UNKNOWN" );
    else
    {
        var_2 = undefined;
        var_3 = undefined;
        self dodamage( var_0.damage_amount, self.origin, var_2, var_3, "MOD_UNKNOWN" );
    }

    wait 0.05;

    if ( isdefined( var_0.attack_bolt ) )
        var_0.attack_bolt delete();

    wait 2;
    self._ID37527 = undefined;
}

reset_attack_bolt( var_0 )
{
    self endon( "death" );
    self endon( "carried" );
    var_1 = self.origin + ( 0, 0, 40 );

    if ( isdefined( var_0 ) )
        var_1 = var_0;

    var_2 = 0;

    while ( isdefined( self.attack_bolt ) )
    {
        wait 0.1;
        var_2++;

        if ( var_2 > 1.1 )
            break;
    }

    if ( isdefined( self.attack_bolt ) )
        self.attack_bolt delete();

    self.attack_bolt = spawn( "script_model", var_1 );
    self.attack_bolt setmodel( "tag_origin" );
}

disable_traps_when_ancestor_attacks()
{
    common_scripts\utility::_ID13189( "engineer_repaired_generator" );
    common_scripts\utility::flag_wait( "disable_all_traps" );
    level notify( "traps_disabled" );

    foreach ( var_1 in level._ID13045 )
    {
        var_1 thread maps\mp\alien\_trap::kill_fire( var_1._ID37205 );
        var_1 notify( "fire_trap_exhausted" );
        var_1 notify( "disable_fire_trap" );
        var_1.barrel makeusable();
        var_1.barrel sethintstring( &"MP_ALIEN_LAST_TRAPS_OFFLINE" );
        maps\mp\alien\_outline_proto::_ID25902( var_1.barrel );
        maps\mp\alien\_outline_proto::enable_outline( var_1.barrel, 4, 1 );
        markdangerousnodesintrigger( var_1.burn_trig, 0 );
        var_1.burning = 0;
        level thread play_disabled_fx( var_1.barrel );
    }

    foreach ( var_4 in level.electric_fences )
    {
        var_4 notify( "death" );
        var_4._ID14209 makeusable();
        var_4._ID14209 sethintstring( &"MP_ALIEN_LAST_TRAPS_OFFLINE" );
        var_4._ID27034 = 0;
        var_4.capacity = 0;
        var_4._ID14209 stoploopsound( "alien_fence_gen_lp" );
        var_4._ID14209 playsound( "alien_fence_gen_off" );
        var_4._ID29717 stoploopsound( "alien_fence_hum_lp" );
        maps\mp\alien\_outline_proto::_ID25902( var_4._ID14209 );
        maps\mp\alien\_outline_proto::enable_outline( var_4._ID14209, 4, 1 );
        level thread play_disabled_fx( var_4._ID14209 );
    }

    foreach ( var_7 in level.tesla_traps )
    {
        if ( !isdefined( var_7.script_noteworthy ) || var_7.script_noteworthy != "tesla_generator" )
            var_7 setmodel( "mp_zeb_garage_switch_off" );
        else
            var_7 stoploopsound( "alien_fence_gen_lp" );

        var_7 sethintstring( &"MP_ALIEN_LAST_TRAPS_OFFLINE" );
        var_7 notify( "stop_tesla_trap" );
        level thread play_disabled_fx( var_7 );
        maps\mp\alien\_outline_proto::_ID25902( var_7 );
        maps\mp\alien\_outline_proto::enable_outline( var_7, 4, 1 );

        foreach ( var_9 in var_7.teslas )
            level thread disable_tesla( var_9 );
    }

    common_scripts\utility::_ID3867( getentarray( "misc_turret", "classname" ), ::disable_turrets );

    while ( common_scripts\utility::_ID13177( "disable_all_traps" ) && !common_scripts\utility::_ID13177( "engineer_repaired_generator" ) )
        wait 0.25;

    if ( isdefined( level.ancestor_generator ) )
    {
        maps\mp\alien\_outline_proto::disable_outline_for_players( level.ancestor_generator, level.players );
        level.ancestor_generator makeunusable();
    }

    level notify( "traps_reenabled" );
    common_scripts\utility::_ID3867( getentarray( "misc_turret", "classname" ), ::reenable_turrets );

    foreach ( var_1 in level._ID13045 )
    {
        maps\mp\alien\_outline_proto::disable_outline( var_1.barrel );
        var_1.barrel makeusable();
        var_1.barrel sethintstring( var_1._ID16999 );
        maps\mp\alien\_outline_proto::add_to_outline_watch_list( var_1.barrel, var_1.cost );
        var_1 thread maps\mp\alien\_trap::_ID13043();
    }

    foreach ( var_4 in level.electric_fences )
    {
        var_4._ID14209 makeusable();
        var_4._ID14209 sethintstring( var_4._ID16999 );
        var_4 thread maps\mp\alien\_trap::_ID26953( maps\mp\alien\_trap::_ID23757, maps\mp\alien\_trap::_ID23756, maps\mp\alien\_trap::ambient_fence_shocks );
        maps\mp\alien\_outline_proto::add_to_outline_watch_list( var_4._ID14209, var_4.cost );
    }

    foreach ( var_7 in level.tesla_traps )
    {
        var_7 notify( "stop_tesla_trap" );
        maps\mp\alien\_outline_proto::add_to_outline_watch_list( var_7, 750 );
        var_7 enable_tesla();
    }
}

disable_tesla( var_0 )
{
    var_0 notify( "trap_done" );
    wait 0.5;
    var_0 stoploopsound();
    var_0.owner = undefined;
    stopfxontag( level._ID1644["tesla_idle3"], var_0, "tag_fx_01" );

    if ( isdefined( var_0.attack_bolt ) )
        var_0.attack_bolt delete();
}

enable_tesla()
{
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( &"MP_ALIEN_LAST_USE_TESLA" );
    self makeusable();
    thread wait_for_tesla_switch_activation( getentarray( self.target, "targetname" ) );
}

play_disabled_fx( var_0, var_1, var_2 )
{
    level endon( "traps_reenabled" );

    for (;;)
    {
        if ( isdefined( var_2 ) )
        {
            playfxontag( common_scripts\utility::_ID15033( "sentry_smoke_mp" ), var_0, "tag_aim" );
            wait 0.05;
            playfxontag( common_scripts\utility::_ID15033( "ims_sensor_explode" ), var_0, "tag_aim" );
        }
        else
        {
            if ( !isdefined( var_1 ) )
                playfx( common_scripts\utility::_ID15033( "ims_sensor_explode" ), var_0.origin );

            wait 0.05;
            playfx( common_scripts\utility::_ID15033( "sentry_smoke_mp" ), var_0.origin );
            wait 0.05;
            var_0 playsound( "sentry_explode_smoke" );
        }

        wait(randomfloatrange( 1.5, 3 ));
    }
}

disable_turrets()
{
    if ( !isdefined( self ) || !isdefined( self.weaponinfo ) || self.weaponinfo != "turret_minigun_alien" )
        return;

    self._ID11491 = 0;
    self notify( "disable_turret" );
    var_0 = self getturretowner();

    if ( isdefined( var_0 ) )
        disable_when_owner_exits_turret();

    level thread play_disabled_fx( self, undefined, 1 );
    maps\mp\alien\_trap::_ID10134();
    self makeunusable();
    self sethintstring( &"MP_ALIEN_LAST_TURRET_OFFLINE" );
    maps\mp\alien\_outline_proto::_ID25902( self );
    maps\mp\alien\_outline_proto::enable_outline( self, 4, 1 );
}

disable_when_owner_exits_turret()
{
    level endon( "traps_reenabled" );

    while ( isdefined( self getturretowner() ) )
        wait 0.1;
}

reenable_turrets()
{
    if ( !isdefined( self ) || !isdefined( self.weaponinfo ) || self.weaponinfo != "turret_minigun_alien" )
        return;

    self setcursorhint( "HINT_NOICON" );
    self makeusable();
    self._ID11491 = 0;
    self sethintstring( &"ALIEN_COLLECTIBLES_ACTIVATE_TURRET" );
    self turretfiredisable();
    self maketurretinoperable();
    maps\mp\alien\_outline_proto::add_to_outline_watch_list( self, 750 );
}

setup_trap_repair_generator()
{
    level.ancestor_generator = getent( "ancestor_left_generator", "targetname" );

    if ( !isdefined( level.ancestor_generator ) )
        return;

    wait 5;
    common_scripts\utility::flag_wait( "disable_all_traps" );
    maps\mp\alien\_outline_proto::enable_outline( level.ancestor_generator, 4, 1 );
    level.ancestor_generator thread _ID36026();
}

_ID36026()
{
    level endon( "traps_reenabled" );
    self makeunusable();
    var_0 = 20000;
    var_1 = 2000;

    for (;;)
    {
        self makeusable();
        self sethintstring( &"MP_ALIEN_LAST_REPAIRGENERATOR" );
        self waittill( "trigger",  var_2  );

        if ( maps\mp\alien\_unk1464::_ID18506( var_2._ID18582 ) )
            continue;

        self makeunusable();
        var_3 = level.players.size;
        var_2.isrepairing = 1;
        var_4 = int( var_0 * var_2 maps\mp\alien\_perk_utility::perk_getdrilltimescalar() * var_2._ID10945 );

        if ( var_3 > 1 )
            var_4 = int( ( var_0 + ( var_3 - 1 ) * var_1 ) * var_2 maps\mp\alien\_perk_utility::perk_getdrilltimescalar() * var_2._ID10945 );

        var_5 = _ID34751( var_2, var_4 );

        if ( !var_5 )
        {
            var_2.isrepairing = 0;
            self makeusable();
            continue;
        }

        var_2.isrepairing = 0;
        common_scripts\utility::flag_set( "engineer_repaired_generator" );
        thread maps\mp\mp_alien_last_final_battle::repair_trap_gen_sfx();
        thread maps\mp\mp_alien_last_fx::conduit_fx_on_no_ff();
        break;
    }
}

_ID34751( var_0, var_1 )
{
    thread cancel_repair_on_traps_renabled( var_0 );
    self.curprogress = 0;
    self._ID18318 = 1;
    self._ID34766 = 1;

    if ( isdefined( var_1 ) )
        self._ID34780 = var_1;
    else
        self._ID34780 = 3000;

    if ( !var_0 maps\mp\alien\_perk_utility::_ID16358( "perk_rigger", [ 0, 1, 2, 3, 4 ] ) )
        var_0 maps\mp\alien\_unk1464::_ID37114( var_1 + 0.05, "drill_repair_weapon_management" );

    var_0 thread maps\mp\alien\_drill::_ID23480( self );
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

useholdthinkloop( var_0, var_1, var_2 )
{
    level endon( "traps_reenabled" );

    while ( !level.gameended && isdefined( self ) && maps\mp\_utility::_ID18757( var_0 ) && var_0 usebuttonpressed() && ( !isdefined( var_0.laststand ) || !var_0.laststand ) && self.curprogress < self._ID34780 )
    {
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

cancel_repair_on_traps_renabled( var_0 )
{
    var_0 endon( "disconnect" );
    self notify( "cancel_repair_on_hive_death" );
    self endon( "cancel_repair_on_hive_death" );
    level endon( "engineer_repaired_generator" );
    level waittill( "traps_reenabled" );

    if ( isalive( var_0 ) )
    {
        var_0 notify( "drill_repair_weapon_management" );

        if ( var_0.disabledweapon > 0 )
            var_0 common_scripts\utility::_enableweapon();

        if ( maps\mp\alien\_unk1464::_ID18506( var_0.hasprogressbar ) )
            var_0.hasprogressbar = 0;

        var_0.isrepairing = 0;
    }
}
