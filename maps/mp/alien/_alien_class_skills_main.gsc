// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    common_scripts\utility::_ID13189( "give_player_abilities" );

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        thread maps\mp\alien\_chaos::chaos_setup_op_weapons();
    else
        thread setup_op_weapons();

    level._ID1644["smoke_green_signal"] = loadfx( "vfx/gameplay/alien/vfx_alien_cskill_medic_smk_01" );
}

setup_op_weapons()
{
    level.opweaponsarray = [];
    level.opweaponsarray[0] = "iw5_alienriotshield_mp";
    level.opweaponsarray[1] = "iw5_alienriotshield1_mp";
    level.opweaponsarray[2] = "iw5_alienriotshield2_mp";
    level.opweaponsarray[3] = "iw5_alienriotshield3_mp";
    level.opweaponsarray[4] = "iw5_alienriotshield4_mp";
    level.opweaponsarray[5] = "iw6_alienminigun_mp";
    level.opweaponsarray[6] = "iw6_alienminigun1_mp";
    level.opweaponsarray[7] = "iw6_alienminigun2_mp";
    level.opweaponsarray[8] = "iw6_alienminigun3_mp";
    level.opweaponsarray[9] = "iw6_alienminigun4_mp";
    level.opweaponsarray[10] = "iw6_alienmk32_mp";
    level.opweaponsarray[11] = "iw6_alienmk321_mp";
    level.opweaponsarray[12] = "iw6_alienmk322_mp";
    level.opweaponsarray[13] = "iw6_alienmk323_mp";
    level.opweaponsarray[14] = "iw6_alienmk324_mp";
    level.opweaponsarray[15] = "iw6_alienpanzerfaust3_mp";
    level.opweaponsarray[16] = "iw6_alienrgm_mp";
    level.opweaponsarray[17] = "mp/iw6_alienrgm_mp";
    level.opweaponsarray[18] = "weapon_iw6_alienrgm_mp";
    level.opweaponsarray[19] = "iw6_alienmaaws_mp";
    level.opweaponsarray[20] = "venomxgun_mp";
    level.opweaponsarray[21] = "venomxproj_mp";
    level.opweaponsarray[22] = "iw6_aliendlc11_mp";
    level.opweaponsarray[23] = "alienbomb_mp";
    level.opweaponsarray[24] = "iw6_aliendlc11sp_mp";
    level.opweaponsarray[25] = "iw6_aliendlc11li_mp";
    level.opweaponsarray[26] = "iw6_aliendlc11fi_mp";
    level.opweaponsarray[27] = "iw6_aliendlc11_mp";
    level.opweaponsarray[28] = "aliensoflam_mp";
    level.opweaponsarray[29] = "aliencortex_mp";
    level.opweaponsarray[30] = "iw6_aliendlc41_mp";
}

assign_skills()
{
    self endon( "death" );
    self endon( "disconnect" );
    self.ability_scalar_bullet = 1;
    self.ability_scalar_melee = 1;
    var_0 = self;
    common_scripts\utility::flag_wait( "give_player_abilities" );
    var_1 = var_0 maps\mp\alien\_persistence::_ID14747();
    var_2 = maps\mp\alien\_persistence::get_selected_perk_0_secondary();
    thread death_check();

    if ( var_1 == "perk_bullet_damage" )
    {
        if ( maps\mp\alien\_persistence::is_upgrade_enabled( "weapon_specialist_upgrade" ) )
            var_0 thread specialist_skill_icon_waiter();
    }

    if ( var_2 == "perk_bullet_damage" )
    {
        if ( maps\mp\alien\_persistence::is_upgrade_enabled( "weapon_specialist_upgrade" ) )
            var_0 thread specialist_skill_icon_waiter( "secondary" );
    }

    if ( var_1 == "perk_health" )
    {
        if ( maps\mp\alien\_persistence::is_upgrade_enabled( "tank_upgrade" ) )
            var_0 thread tank_skill_icon_waiter();
    }

    if ( var_2 == "perk_health" )
    {
        if ( maps\mp\alien\_persistence::is_upgrade_enabled( "tank_upgrade" ) )
            var_0 thread tank_skill_icon_waiter( "secondary" );
    }

    if ( var_1 == "perk_medic" )
    {
        if ( maps\mp\alien\_persistence::is_upgrade_enabled( "medic_upgrade" ) )
            var_0 thread medic_skill_icon_waiter();
    }

    if ( var_2 == "perk_medic" )
    {
        if ( maps\mp\alien\_persistence::is_upgrade_enabled( "medic_upgrade" ) )
            var_0 thread medic_skill_icon_waiter( "secondary" );
    }

    if ( var_1 == "perk_rigger" )
    {
        if ( maps\mp\alien\_persistence::is_upgrade_enabled( "engineer_upgrade" ) )
            var_0 thread engineer_skill_icon_waiter();
    }

    if ( var_2 == "perk_rigger" )
    {
        if ( maps\mp\alien\_persistence::is_upgrade_enabled( "engineer_upgrade" ) )
            var_0 thread engineer_skill_icon_waiter( "secondary" );
    }
}

tank_skill_icon_waiter( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self notify( "clear_skills" );
    self endon( "clear_skills" );
    level.meleestunradius = 128;
    level.meleestunmaxdamage = 1;
    level.meleestunmindamage = 1;
    var_1 = [];
    var_1["rank_0_cost"] = 200;
    var_1["rank_1_cost"] = 350;
    var_1["rank_2_cost"] = 380;
    var_1["rank_3_cost"] = 415;
    var_1["rank_4_cost"] = 475;
    var_1["rank_0_duration"] = 5.0;
    var_1["rank_1_duration"] = 5.625;
    var_1["rank_2_duration"] = 6.25;
    var_1["rank_3_duration"] = 7.5;
    var_1["rank_4_duration"] = 10.0;
    var_1["rank_0_cooldown"] = 180;
    var_1["rank_1_cooldown"] = 180;
    var_1["rank_2_cooldown"] = 180;
    var_1["rank_3_cooldown"] = 180;
    var_1["rank_4_cooldown"] = 180;
    var_1["perk"] = "perk_health";
    thread tank_skill_setup( var_1, var_0 );
    thread generic_skill_waiter( var_1, 2, var_0 );
}

tank_skill_setup( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        if ( isdefined( self.has_died_primary ) || isdefined( self.has_died_secondary ) )
        {
            if ( isdefined( var_1 ) )
            {
                self.has_died_secondary = undefined;
                skill_cooldown_secondary( var_0 );
            }
            else
            {
                self.has_died_primary = undefined;
                skill_cooldown_primary( var_0 );
            }
        }

        if ( isdefined( var_1 ) )
            wait_for_secondary_skill_button();
        else
            wait_for_primary_skill_button();

        var_2 = generic_variable_setup( var_0 );
        thread sound_audio_weapon_activate();

        if ( ability_cost( var_2["cost"], var_1 ) )
        {
            self visionsetnakedforplayer( "mp_alien_thermal_trinity", 0.5 );
            maps\mp\alien\_music_and_dialog::playtankclassskillvo( self );
            thread create_tank_ring( var_2 );
            tank_skill_flare( var_2 );
            self visionsetnakedforplayer( "", 0.5 );

            if ( isdefined( var_1 ) )
                skill_cooldown_secondary( var_0 );
            else
                skill_cooldown_primary( var_0 );
        }

        wait 0.05;
    }
}

tank_skill_flare( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_1 = self.threatbias;
    self.threatbias = 3000;
    self.ability_scalar_melee = 1.25;
    self.tank_skill_active = 1;
    thread tank_death_watcher();
    self.ability_invulnerable = 1;
    thread super_punch();
    level notify( "aggro_grab" );
    thread aggro_grab();
    thread sound_audio_tank( var_0 );
    wait(var_0["duration"]);
    self.threatbias = var_1;
    self.ability_scalar_melee = 1;
    var_2 = [];
    var_2 = maps\mp\alien\_spawnlogic::_ID14265();
    self.tank_skill_active = undefined;
    self notify( "super_expired" );

    foreach ( var_4 in var_2 )
        var_4.favoriteenemy = undefined;
}

sound_audio_tank( var_0 )
{
    var_1 = spawn( "script_origin", self.origin );
    thread sound_position_update( var_1 );
    var_1 playloopsound( "alien_skill_tank_lp" );
    common_scripts\utility::_ID35637( var_0["duration"], var_0["death"] );
    var_1 stoploopsound();
    var_1 notify( "kill_node" );
    wait 1;
    var_1 delete();
}

sound_position_update( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_0 endon( "kill_node" );

    for (;;)
    {
        var_0.origin = self.origin;
        wait 0.1;
    }
}

tank_death_watcher()
{
    common_scripts\utility::_ID35626( "disconnect", "death", "super_expired" );
    self.ability_invulnerable = undefined;
}

tank_health_watch()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "super_expired" );
    var_0 = self.health;

    for (;;)
    {
        if ( var_0 <= self.health )
            var_0 = self.health;
        else
            self.health = var_0;

        wait 0.05;
    }
}

super_punch()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "super_expired" );

    for (;;)
    {
        if ( self meleebuttonpressed() && self ismeleeing() )
        {
            wait 0.05;
            earthquake( 0.3, 0.2, self.origin, 10 );
            radiusdamage( self.origin, level.meleestunradius, level.meleestunmaxdamage, level.meleestunmindamage, self, "MOD_MELEE", "meleestun_mp" );
            self playsoundtoplayer( "bodyfall_asphault_large", self );
            wait_for_melee_end();
        }

        wait 0.05;
    }
}

wait_for_melee_end()
{
    for (;;)
    {
        if ( self ismeleeing() == 0 )
            return;

        wait 0.1;
    }
}

aggro_grab()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "aggro_grab" );
    self endon( "super_expired" );

    for (;;)
    {
        var_0 = [];
        var_0 = maps\mp\alien\_spawnlogic::_ID14265();

        foreach ( var_2 in var_0 )
            var_2.favoriteenemy = self;

        wait 0.5;
    }
}

proto_hack_flare_update()
{
    self endon( "death" );
    self endon( "disconnect" );
    var_0 = 0;

    for (;;)
    {
        var_1 = spawn( "script_model", self gettagorigin( "tag_weapon_right" ) );
        var_1 setmodel( "mil_emergency_flare_mp" );
        var_1.angles = self gettagangles( "tag_weapon_right" );
        var_1 linkto( self, "tag_weapon_right" );
        wait 0.05;
        var_2 = var_1 gettagangles( "tag_fire_fx" );
        var_3 = spawnfx( loadfx( "fx/misc/flare_ambient_green" ), var_1 gettagorigin( "tag_fire_fx" ), anglestoforward( var_2 ), anglestoup( var_2 ) );
        triggerfx( var_3 );
        var_1 playloopsound( "emt_road_flare_burn" );
        wait 0.05;
        var_1 delete();
        var_3 delete();
        var_0 += 1;

        if ( var_0 == 50 )
            return;
    }
}

create_tank_ring( var_0 )
{
    if ( isdefined( self ) )
        playfxontag( loadfx( "vfx/gameplay/alien/vfx_alien_cskill_tank_01" ), self, "tag_origin" );

    common_scripts\utility::_ID35637( var_0["duration"], "last_stand" );

    if ( isdefined( self ) )
        stopfxontag( loadfx( "vfx/gameplay/alien/vfx_alien_cskill_tank_01" ), self, "tag_origin" );
}

medic_skill_icon_waiter( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self notify( "clear_skills" );
    self endon( "clear_skills" );
    var_1 = [];
    var_1["rank_0_cost"] = 225;
    var_1["rank_1_cost"] = 350;
    var_1["rank_2_cost"] = 390;
    var_1["rank_3_cost"] = 430;
    var_1["rank_4_cost"] = 515;
    var_1["rank_0_duration"] = 5;
    var_1["rank_1_duration"] = 5.625;
    var_1["rank_2_duration"] = 6.25;
    var_1["rank_3_duration"] = 7.5;
    var_1["rank_4_duration"] = 10;
    var_1["rank_0_cooldown"] = 180;
    var_1["rank_1_cooldown"] = 180;
    var_1["rank_2_cooldown"] = 180;
    var_1["rank_3_cooldown"] = 180;
    var_1["rank_4_cooldown"] = 180;
    var_1["perk"] = "perk_medic";
    thread medic_skill_setup( var_1, var_0 );
    thread generic_skill_waiter( var_1, 4, var_0 );
}

medic_skill_setup( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        if ( isdefined( self.has_died_primary ) || isdefined( self.has_died_secondary ) )
        {
            if ( isdefined( var_1 ) )
            {
                self.has_died_secondary = undefined;
                skill_cooldown_secondary( var_0 );
            }
            else
            {
                self.has_died_primary = undefined;
                skill_cooldown_primary( var_0 );
            }
        }

        if ( isdefined( var_1 ) )
            wait_for_secondary_skill_button();
        else
            wait_for_primary_skill_button();

        var_2 = generic_variable_setup( var_0 );
        thread sound_audio_weapon_activate();

        if ( ability_cost( var_2["cost"], var_1 ) )
        {
            maps\mp\alien\_music_and_dialog::playmedicclassskillvo( self );
            create_heal_ring( var_2 );

            if ( isdefined( var_1 ) )
                skill_cooldown_secondary( var_0 );
            else
                skill_cooldown_primary( var_0 );
        }

        wait 0.05;
    }
}

create_heal_ring( var_0 )
{
    var_1 = spawnturret( "misc_turret", self.origin + ( 0, 0, 20 ), "sentry_minigun_mp" );
    var_1.owner = self;
    var_1.angles = anglestoup( ( 0, 0, 90 ) );
    var_1 setmodel( "tag_origin_vehicle" );
    var_1 maketurretinoperable();
    var_1 setturretmodechangewait( 1 );
    var_1 setmode( "sentry_offline" );
    var_1 makeunusable();
    var_1 setsentryowner( self );
    var_1 setsentrycarrier( self );
    var_1 setcandamage( 0 );
    var_1 setcontents( 0 );
    wait 0.1;
    playfxontag( level._ID1644["smoke_green_signal"], var_1, "tag_origin" );
    var_2 = spawn( "script_model", self.origin );
    var_2 linkto( var_1 );
    var_2 playloopsound( "alien_skill_medic_lp" );
    thread heal_logic();
    thread death_deletes_heal_ring( var_1 );
    common_scripts\utility::_ID35637( var_0["duration"], "last_stand", "death", "disconnect" );

    if ( isdefined( self ) )
        self notify( "heal_over" );

    var_2 stoploopsound();
    var_2 unlink();

    if ( isdefined( var_1 ) )
        var_1 delete();

    wait 0.1;

    if ( isdefined( var_2 ) )
        var_2 delete();
}

death_deletes_heal_ring( var_0 )
{
    self endon( "heal_over" );
    common_scripts\utility::_ID35626( "death", "disconnect", "vanguard_used" );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

save_grenade()
{
    self endon( "missile_stuck" );
    wait 5;
    self.failthrow = 1;
    self notify( "missile_stuck" );
}

medic_heal_skill( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "disconnect" );
    wait 1.5;
    thread heal_logic( var_0 );
    var_3 = spawnfx( level._ID1644["smoke_green_signal"], var_0, anglestoforward( self.angles ), anglestoup( self.angles + ( 0, 0, 0 ) ) );
    triggerfx( var_3 );
    wait(var_2["duration"]);
    self notify( "heal_over" );
    var_3 delete();
}

heal_logic()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "heal_over" );

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            var_2 = int( floor( var_1.maxhealth * 0.1 ) );

            if ( distance( var_1.origin, self.origin ) <= 128 )
            {
                if ( isdefined( var_1.laststand ) && var_1.laststand )
                {
                    var_1 notify( "revive_success" );
                    var_1 setclientomnvar( "ui_laststand_end_milliseconds", 0 );
                    maps\mp\alien\_laststand::record_revive_success( self, var_1 );
                    continue;
                }

                if ( var_1.health + var_2 >= var_1.maxhealth )
                {
                    var_1.health = var_1.maxhealth;
                    continue;
                }

                var_1.health = var_1.health + var_2;
            }
        }

        wait 0.5;
    }
}

engineer_skill_icon_waiter( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self notify( "clear_skills" );
    self endon( "clear_skills" );
    var_1 = [];
    var_1["rank_0_cost"] = 200;
    var_1["rank_1_cost"] = 350;
    var_1["rank_2_cost"] = 380;
    var_1["rank_3_cost"] = 415;
    var_1["rank_4_cost"] = 475;
    var_1["rank_0_duration"] = 5.0;
    var_1["rank_1_duration"] = 5.625;
    var_1["rank_2_duration"] = 6.25;
    var_1["rank_3_duration"] = 7.5;
    var_1["rank_4_duration"] = 10.0;
    var_1["rank_0_cooldown"] = 180;
    var_1["rank_1_cooldown"] = 180;
    var_1["rank_2_cooldown"] = 180;
    var_1["rank_3_cooldown"] = 180;
    var_1["rank_4_cooldown"] = 180;
    var_1["perk"] = "perk_rigger";
    thread engineer_skill_setup( var_1, var_0 );
    thread generic_skill_waiter( var_1, 3, var_0 );
}

engineer_skill_setup( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        if ( isdefined( self.has_died_primary ) || isdefined( self.has_died_secondary ) )
        {
            if ( isdefined( var_1 ) )
            {
                self.has_died_secondary = undefined;
                skill_cooldown_secondary( var_0 );
            }
            else
            {
                self.has_died_primary = undefined;
                skill_cooldown_primary( var_0 );
            }
        }

        if ( isdefined( var_1 ) )
            wait_for_secondary_skill_button();
        else
            wait_for_primary_skill_button();

        var_2 = generic_variable_setup( var_0 );
        thread sound_audio_weapon_activate();

        if ( ability_cost( var_2["cost"], var_1 ) )
        {
            maps\mp\alien\_music_and_dialog::playengineerclassskillvo( self );
            engineer_slow_field( var_2 );

            if ( isdefined( var_1 ) )
                skill_cooldown_secondary( var_0 );
            else
                skill_cooldown_primary( var_0 );
        }

        wait 0.05;
    }
}

engineer_slow_field( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_1 = spawn( "script_model", self.origin );
    var_2 = getgroundposition( self.origin + ( 0, 0, 20 ), 2 );
    var_1.ammo = 1000;

    if ( isdefined( var_2 ) )
        var_1.origin = var_2;

    var_1 setmodel( "mp_weapon_alien_crate" );
    var_3 = spawnfx( loadfx( "vfx/gameplay/alien/vfx_alien_cskill_engnr_ff_01" ), var_1.origin, anglestoforward( self.angles + ( -90, 0, 0 ) ), anglestoup( var_1.angles ) );
    var_4 = spawn( "script_origin", var_1.origin );
    var_4 playloopsound( "alien_skill_engineer_lp" );
    triggerfx( var_3 );
    thread disconnect_delete( var_3, "skill_done" );
    level.slow_field_active = 1;
    thread handle_ally_threat( var_1, var_0 );
    var_1 thread maps\mp\gametypes\_trophy_system::_ID33737( self );
    alien_blocker_field( var_1, var_0 );
    level.slow_field_active = 0;
    var_4 stoploopsound();
    wait 0.1;
    var_3 delete();
    var_1 delete();
    var_4 delete();

    foreach ( var_6 in level.players )
        var_6.ignoreme = 0;
}

alien_blocker_field( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_2 = 245;
    thread damage_enemies_in_range( var_0 );
    badplace_cylinder( "cray_dome", var_1["duration"], var_0.origin, var_2, var_2, "axis" );
    wait(var_1["duration"]);
    self notify( "stop_eng_damage" );
    badplace_delete( "cray_dome" );
}

damage_enemies_in_range( var_0 )
{
    self endon( "stop_eng_damage" );
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        var_1 = maps\mp\alien\_spawnlogic::_ID14265();

        foreach ( var_3 in var_1 )
        {
            if ( distance2d( var_0.origin, var_3.origin ) <= 256 )
            {
                var_3 dodamage( 1, var_0.origin, self, self, "MOD_MELEE" );
                wait 0.5;
                jump loc_F71
            }

            wait 0.05;
        }

        wait 0.05;
    }
}

handle_ally_threat( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "stop_eng_damage" );
    var_2 = 30625;

    for (;;)
    {
        foreach ( var_4 in level.players )
        {
            if ( distance2dsquared( var_0.origin, var_4.origin ) <= var_2 )
            {
                var_4.ignoreme = 1;
                var_4 thread safe_threat_restore( var_1 );
                continue;
            }

            var_4.ignoreme = 0;
        }

        wait 0.5;
    }
}

safe_threat_restore( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    wait(var_0["duration"]);
    self.ignoreme = 0;
}

specialist_skill_icon_waiter( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self notify( "clear_skills" );
    self endon( "clear_skills" );
    var_1 = [];
    var_1["rank_0_cost"] = 250;
    var_1["rank_1_cost"] = 350;
    var_1["rank_2_cost"] = 400;
    var_1["rank_3_cost"] = 450;
    var_1["rank_4_cost"] = 500;
    var_1["rank_0_duration"] = 5.0;
    var_1["rank_1_duration"] = 5.625;
    var_1["rank_2_duration"] = 6.25;
    var_1["rank_3_duration"] = 7.5;
    var_1["rank_4_duration"] = 10.0;
    var_1["rank_0_cooldown"] = 180;
    var_1["rank_1_cooldown"] = 180;
    var_1["rank_2_cooldown"] = 180;
    var_1["rank_3_cooldown"] = 180;
    var_1["rank_4_cooldown"] = 180;
    var_1["perk"] = "perk_bullet_damage";
    thread specialist_skill_setup( var_1, var_0 );
    thread generic_skill_waiter( var_1, 1, var_0 );
}

specialist_skill_setup( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self.damage_increased = 1;

    for (;;)
    {
        if ( isdefined( self.has_died_primary ) || isdefined( self.has_died_secondary ) )
        {
            if ( isdefined( var_1 ) )
            {
                self.has_died_secondary = undefined;
                skill_cooldown_secondary( var_0 );
            }
            else
            {
                self.has_died_primary = undefined;
                skill_cooldown_primary( var_0 );
            }
        }

        if ( isdefined( var_1 ) )
            wait_for_secondary_skill_button();
        else
            wait_for_primary_skill_button();

        var_2 = generic_variable_setup( var_0 );
        thread sound_audio_weapon_activate();

        if ( ability_cost( var_2["cost"], var_1 ) )
        {
            maps\mp\alien\_music_and_dialog::playweaponclassskillvo( self );
            self.skill_in_use = 1;
            thread effect_on_fire( var_2 );
            self.camfx = spawnfxforclient( loadfx( "vfx/gameplay/alien/vfx_alien_cskill_wspecial_01" ), self.origin, self );
            triggerfx( self.camfx );
            specialist_boost( var_2 );
            self.skill_in_use = undefined;

            if ( isdefined( self.camfx ) )
                self.camfx delete();

            if ( isdefined( var_1 ) )
                skill_cooldown_secondary( var_0 );
            else
                skill_cooldown_primary( var_0 );
        }

        wait 0.05;
    }
}

sound_audio_weapon_activate()
{
    var_0 = common_scripts\utility::_ID30774();
    var_0.origin = self.origin;
    var_0.angles = self.angles;
    var_0 linkto( self );
    var_0 playsound( "alien_skill_activate" );
    wait 2;
    var_0 delete();
}

effect_on_fire( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    playfxontag( loadfx( "vfx/gameplay/alien/vfx_alien_cskill_wspecial_02" ), self, "tag_origin" );
    thread sound_audio_weapon( var_0 );
    common_scripts\utility::_ID35637( var_0["duration"], "last_stand" );
    stopfxontag( loadfx( "vfx/gameplay/alien/vfx_alien_cskill_wspecial_02" ), self, "tag_origin" );
}

sound_audio_weapon( var_0 )
{
    wait 0.3;
    var_1 = spawn( "script_origin", self.origin );
    thread sound_position_update( var_1 );
    var_1 playloopsound( "alien_skill_weapon_lp" );
    common_scripts\utility::_ID35637( var_0["duration"], var_0["death"] );
    var_1 stoploopsound();
    var_1 notify( "kill_node" );
    wait 1;
    var_1 delete();
}

specialist_boost( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_1 = specialist_ammo_round_up();
    thread specialist_death_watcher();
    self.ability_scalar_bullet = 0.9;

    foreach ( var_3 in level.players )
    {
        if ( var_3 != self )
            var_3 thread temp_damage_increase( var_0 );
    }

    thread _ID34213( var_1 );
    maps\mp\alien\_unk1464::restore_client_fog( 0 );
    thread maps\mp\alien\_outline_proto::_ID28200();
    wait(var_0["duration"]);
    self setclientomnvar( "ui_alien_unlimited_ammo", 0 );
    level notify( "stop_specialist_power" );
    self.ability_scalar_bullet = 1;
    remove_the_outline();
}

specialist_death_watcher()
{
    common_scripts\utility::_ID35626( "death", "disconnect", "stop_specialist_power" );

    if ( isdefined( self ) )
    {
        self.ability_scalar_bullet = 1;
        self setclientomnvar( "ui_alien_unlimited_ammo", 0 );
        stopfxontag( loadfx( "vfx/gameplay/alien/vfx_alien_cskill_wspecial_02" ), self, "tag_origin" );
    }

    if ( isdefined( self.camfx ) )
        self.camfx delete();
}

temp_damage_increase( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );

    if ( !isdefined( self.damage_increased ) )
    {
        self.damage_increased = 1;
        self.ability_scalar_bullet = 1.1;
        wait(var_0["duration"]);
        self.ability_scalar_bullet = 1;
        self.damage_increased = undefined;
    }
}

remove_the_outline()
{
    self endon( "death" );
    self endon( "disconnect" );

    if ( isdefined( self.isferal ) && self.isferal )
        return;

    self notify( "switchblade_over" );
    var_0 = maps\mp\alien\_spawnlogic::_ID14265();

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2._ID37068 ) )
            continue;

        if ( isdefined( var_2._ID37651 ) )
            continue;

        if ( !isdefined( var_2.pet ) )
            maps\mp\alien\_outline_proto::disable_outline_for_player( var_2, self );
    }

    if ( !isdefined( level.seeder_active_turrets ) )
        return;

    foreach ( var_5 in level.seeder_active_turrets )
    {
        if ( isdefined( var_5 ) && !isdefined( var_5.pet ) )
            maps\mp\alien\_outline_proto::disable_outline_for_player( var_5, self );
    }
}

specialist_ammo_round_up()
{
    self endon( "death" );
    self endon( "disconnect" );
    var_0 = [];

    foreach ( var_2 in self._ID36267 )
        var_0[var_2] = self getammocount( var_2 );

    return var_0;
}

_ID34213( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "stop_specialist_power" );

    if ( self._ID36267.size == 0 )
        self._ID36267[0] = self getcurrentweapon();

    for (;;)
    {
        var_1 = 0;

        foreach ( var_3 in self._ID36267 )
        {
            if ( weapon_no_unlimited_check( self getcurrentweapon() ) )
                self setclientomnvar( "ui_alien_unlimited_ammo", 1 );
            else
                self setclientomnvar( "ui_alien_unlimited_ammo", 0 );

            if ( var_3 == self getcurrentweapon() && weapon_no_unlimited_check( var_3 ) )
            {
                var_1 = 1;
                self setweaponammoclip( var_3, weaponclipsize( var_3 ), "left" );
            }

            if ( var_3 == self getcurrentweapon() && weapon_no_unlimited_check( var_3 ) )
            {
                var_1 = 1;
                self setweaponammoclip( var_3, weaponclipsize( var_3 ), "right" );
            }

            if ( var_1 == 0 )
                specialist_ammo_round_up();
        }

        wait 0.05;
    }
}

weapon_no_unlimited_check( var_0 )
{
    var_1 = 1;

    foreach ( var_3 in level.opweaponsarray )
    {
        if ( var_0 == var_3 )
            var_1 = 0;
    }

    return var_1;
}

skill_cooldown_primary( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_1 = 0;
    var_2 = get_wait_seconds( var_0 );
    self.is_cooling_primary = 1;
    self setclientomnvar( "ui_alien_class_skill_active", 0 );
    var_3 = gettime() + int( 1000 * var_2 );
    self setclientomnvar( "ui_alien_class_skill_timer", var_3 );
    thread pause_cooldown_watcher();
    var_4 = var_3;

    while ( var_3 >= gettime() )
    {
        if ( isdefined( self.laststand ) )
        {
            var_3 += 1000;
            var_1 = 1;
        }
        else
        {
            var_4 -= 1000;

            if ( var_1 == 1 )
            {
                self setclientomnvar( "ui_alien_class_skill_timer", var_4 );
                var_1 = 0;
            }
        }

        wait 1;
    }

    self setclientomnvar( "ui_alien_class_skill_timer", 0 );
    self.is_cooling_primary = undefined;
}

skill_cooldown_secondary( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_1 = 0;
    var_2 = get_wait_seconds( var_0 );
    self.is_cooling_secondary = 1;
    self setclientomnvar( "ui_alien_class_skill_active_secondary", 0 );
    var_3 = gettime() + int( 1000 * var_2 );
    self setclientomnvar( "ui_alien_class_skill_timer_secondary", var_3 );
    thread pause_cooldown_watcher();
    var_4 = var_3;

    while ( var_3 >= gettime() )
    {
        if ( isdefined( self.laststand ) )
        {
            var_3 += 1000;
            var_1 = 1;
        }
        else
        {
            var_4 -= 1000;

            if ( var_1 == 1 )
            {
                self setclientomnvar( "ui_alien_class_skill_timer_secondary", var_4 );
                var_1 = 0;
            }
        }

        wait 1;
    }

    self setclientomnvar( "ui_alien_class_skill_timer_secondary", 0 );
    self.is_cooling_secondary = undefined;
}

pause_cooldown_watcher()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "death" );

    while ( isdefined( self.is_cooling_secondary ) || isdefined( self.is_cooling_primary ) )
    {
        if ( isdefined( self.laststand ) )
            self setclientomnvar( "ui_alien_class_skill_blocked", 1 );
        else
            self setclientomnvar( "ui_alien_class_skill_blocked", 0 );

        wait 0.1;
    }
}

get_wait_seconds( var_0 )
{
    var_1 = var_0["rank_0_cooldown"];
    var_2 = maps\mp\alien\_persistence::_ID14747();
    var_3 = maps\mp\alien\_persistence::_ID14645();

    if ( var_2 == var_0["perk"] && var_3 == 0 )
        var_1 = var_0["rank_0_cooldown"];
    else if ( var_2 == var_0["perk"] && var_3 == 1 )
        var_1 = var_0["rank_1_cooldown"];
    else if ( var_2 == var_0["perk"] && var_3 == 2 )
        var_1 = var_0["rank_2_cooldown"];
    else if ( var_2 == var_0["perk"] && var_3 == 3 )
        var_1 = var_0["rank_3_cooldown"];
    else if ( var_2 == var_0["perk"] && var_3 == 4 )
        var_1 = var_0["rank_4_cooldown"];

    if ( maps\mp\alien\_persistence::is_upgrade_enabled( "cooldown_skills_upgrade" ) )
        var_1 *= 0.5;

    return var_1;
}

wait_for_primary_skill_button()
{
    self endon( "death" );
    self endon( "disconnect" );
    self.double_tapped_primary = undefined;

    while ( !isdefined( self.double_tapped_primary ) )
    {
        if ( !isdefined( self ) )
        {
            wait 1;
            break;
        }

        self waittill( "action_slot_1" );

        if ( isdefined( self.turn_off_class_skill_activation ) )
            continue;

        if ( !isdefined( self.laststand ) )
            check_for_double_tap_primary();
    }
}

check_for_double_tap_primary()
{
    self endon( "d_tap_limit_primary" );
    thread timer_for_double_tap_primary();
    common_scripts\utility::_ID35626( "action_slot_1" );
    self notify( "double_tapped_primary" );
    self.double_tapped_primary = 1;
}

timer_for_double_tap_primary()
{
    self endon( "double_tapped_primary" );

    for ( var_0 = 10; var_0 > 0; var_0 -= 1 )
        wait 0.05;

    self notify( "d_tap_limit_primary" );
}

wait_for_secondary_skill_button()
{
    self endon( "death" );
    self endon( "disconnect" );
    self.double_tapped_secondary = undefined;

    while ( !isdefined( self.double_tapped_secondary ) )
    {
        if ( !isdefined( self ) )
        {
            wait 1;
            break;
        }

        self waittill( "action_slot_3" );

        if ( isdefined( self.turn_off_class_skill_activation ) )
            continue;

        if ( !isdefined( self.laststand ) )
            check_for_double_tap_secondary();
    }
}

check_for_double_tap_secondary()
{
    self endon( "d_tap_limit_secondary" );
    thread timer_for_double_tap_secondary();
    common_scripts\utility::_ID35626( "action_slot_3" );
    self notify( "double_tapped_secondary" );
    self.double_tapped_secondary = 1;
}

timer_for_double_tap_secondary()
{
    self endon( "double_tapped_secondary" );

    for ( var_0 = 10; var_0 > 0; var_0 -= 1 )
        wait 0.05;

    self notify( "d_tap_limit_secondary" );
}

ability_cost( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );

    if ( isdefined( var_1 ) )
        self setclientomnvar( "ui_alien_class_skill_active_secondary", 1 );
    else
        self setclientomnvar( "ui_alien_class_skill_active", 1 );

    self notify( "class_skill_used" );
    return 1;
}

deleteondeath( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self waittill( "death" );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

offhand_check()
{
    self endon( "death" );
    self endon( "disconnect" );
    var_0 = self getweaponslistoffhands();

    foreach ( var_2 in var_0 )
    {
        if ( self getammocount( var_2 ) )
            return 0;
    }

    return 1;
}

generic_skill_waiter( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "disconnect" );

    if ( isdefined( var_2 ) )
        self setclientomnvar( "ui_alien_class_skill_secondary", var_1 );
    else
        self setclientomnvar( "ui_alien_class_skill", var_1 );
}

generic_variable_setup( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_1 = [];
    var_2 = maps\mp\alien\_persistence::get_selected_perk_0_secondary();
    var_3 = maps\mp\alien\_persistence::_ID14747();
    var_4 = maps\mp\alien\_persistence::_ID14645();

    if ( ( var_3 == var_0["perk"] || var_2 == var_0["perk"] ) && var_4 == 0 )
    {
        var_1["cooldown"] = var_0["rank_0_cooldown"];
        var_1["cost"] = var_0["rank_0_cost"];
        var_1["duration"] = var_0["rank_0_duration"];
    }
    else if ( ( var_3 == var_0["perk"] || var_2 == var_0["perk"] ) && var_4 == 1 )
    {
        var_1["cooldown"] = var_0["rank_1_cooldown"];
        var_1["cost"] = var_0["rank_1_cost"];
        var_1["duration"] = var_0["rank_1_duration"];
    }
    else if ( ( var_3 == var_0["perk"] || var_2 == var_0["perk"] ) && var_4 == 2 )
    {
        var_1["cooldown"] = var_0["rank_2_cooldown"];
        var_1["cost"] = var_0["rank_2_cost"];
        var_1["duration"] = var_0["rank_2_duration"];
    }
    else if ( ( var_3 == var_0["perk"] || var_2 == var_0["perk"] ) && var_4 == 3 )
    {
        var_1["cooldown"] = var_0["rank_3_cooldown"];
        var_1["cost"] = var_0["rank_3_cost"];
        var_1["duration"] = var_0["rank_3_duration"];
    }
    else if ( ( var_3 == var_0["perk"] || var_2 == var_0["perk"] ) && var_4 == 4 )
    {
        var_1["cooldown"] = var_0["rank_4_cooldown"];
        var_1["cost"] = var_0["rank_4_cost"];
        var_1["duration"] = var_0["rank_4_duration"];
    }

    return var_1;
}

death_check()
{
    self waittill( "death" );
    self.has_died_primary = 1;
    self.has_died_secondary = 1;
}

disconnect_delete( var_0, var_1 )
{
    self endon( var_1 );
    common_scripts\utility::_ID35626( "disconnect", "death" );

    if ( isdefined( var_0 ) )
        var_0 delete();
}
