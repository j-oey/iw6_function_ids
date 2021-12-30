// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    level thread explodersasoneshot();
    level._ID37190 = 3;
    level._ID37512 = "mp/alien/alien_dlc3_intel.csv";
    level.skip_radius_damage_on_puddles = 1;
    level._ID37249 = ::_ID37529;
    level._ID37496 = ::descent_player_initial_spawn_loc_override;
    level.introscreen_line_1 = &"MP_ALIEN_DESCENT_INTRO_LINE_1";
    level._ID18313 = &"MP_ALIEN_DESCENT_INTRO_LINE_2";
    level._ID18314 = &"MP_ALIEN_DESCENT_INTRO_LINE_3";
    level.introscreen_line_4 = &"MP_ALIEN_DESCENT_INTRO_LINE_4";
    maps\mp\alien\_unk1464::alien_mode_enable( "kill_resource", "wave", "airdrop", "lurker", "collectible", "loot", "pillage", "challenge", "outline", "scenes" );
    level thread _ID36635::_ID37009();
    var_0 = [ "caverns_01", "caverns_02", "caverns_03", "caverns_04" ];
    maps\mp\alien\_unk1464::alien_area_init( var_0 );
    level._ID37911 = 10;
    level._ID37413 = 1.0;
    level._ID37408 = 1.0;
    level._ID37409 = 1.0;
    level._ID37410 = 1.0;
    level._ID37411 = 1.25;
    level.casual_spawn_multiplier = 1.0;
    level.casual_damage_scalar = 0.45;
    level.casual_health_scalar = 0.45;
    level.casual_reward_scalar = 1.0;
    level.casual_score_scalar = 0.5;
    setdvar( "r_reactiveMotionWindAmplitudeScale", 0.15 );
    setomnvar( "alt_jump_height", 145.0 );
    setdvar( "sm_sunShadowScale", "0.5" );
    level._ID17520 = 1;
    level.challenge_registration_func = maps\mp\alien\mp_alien_dlc3_challenges::register_dlc3_challenges;
    level._ID6850 = maps\mp\alien\mp_alien_dlc3_challenges::dlc3_challenge_scalar_func;
    level._ID37054 = maps\mp\alien\mp_alien_dlc3_challenges::dlc3_death_challenge_func;
    level._ID37053 = maps\mp\alien\mp_alien_dlc3_challenges::dlc3_damage_challenge_func;
    level._ID17519 = 1;
    level._ID17521 = 1;
    level.escape_cycle = 19;
    level._ID37061 = ::mp_alien_descent_pillage_init;
    _ID36643::_ID37636();
    level.level_locker_weapon_pickup_string_func = ::descent_locker_weapon_pickup_string_func;
    level.pillage_locker_offset_override_func = ::dlc_3_offset_locker_trigger_model;
    level.locker_ark_check_func = ::descent_locker_ark_check_func;
    level._ID36925 = common_scripts\utility::array_randomize( [ "p6_", "p5_" ] );
    level._ID36924 = common_scripts\utility::array_randomize( [ "p8_", "p7_" ] );
    level._ID37059 = ::mp_alien_descent_onspawnplayer_func;
    level.level_specific_vo_callouts = ::descent_specific_vo_callouts;
    level.dlc_get_non_agent_enemies = ::descent_get_non_agent_enemies;
    maps\mp\gametypes\aliens::_ID29054( "bomblocation_14" );
    set_spawn_table();
    set_container_spawn_table();
    set_alien_definition_table();
    level.alien_collectibles_table = "mp/alien/collectibles_dlc3.csv";
    level._ID30720 = "mp/alien/dlc3_spawn_node_info.csv";
    level.alien_challenge_table = "mp/alien/mp_alien_dlc3_challenges.csv";
    level.alien_character_cac_table = "mp/alien/alien_cac_presets.csv";
    level.randombox_table = "mp/alien/beacon_deployable_randombox.csv";

    if ( !maps\mp\alien\_unk1464::is_chaos_mode() )
        _ID36634::_ID37459();

    level._ID37177 = ::descent_enter_area_func;
    level._ID37611 = ::descent_leave_area_func;
    level._ID37116 = ::descent_melee_override_func;
    level.dlc_alien_init_override_func = ::descent_alien_init_override_func;
    level.alien_attack_override_func = ::descent_alien_attack_override_func;
    level.dlc_alien_death_override_func = ::descent_alien_death_override_func;
    level.dlc_idle_anim_state_override_func = ::descent_alien_idle_anim_state_override_func;
    level.dlc_alien_type_node_match_override_func = ::descent_alien_type_node_match_override_func;
    level.dlc_alien_jump_override = ::descent_alien_jump_override;
    level.dlc_can_do_pain_override_func = ::descent_can_do_pain_override_func;
    level.dlc_alien_can_retreat_override_func = ::descent_alien_can_retreat_override_func;
    level.dlc_alien_pain_anim_state_override_func = ::descent_alien_pain_anim_state_override_func;
    level.dlc_alien_turn_in_place_anim_state_override_func = ::descent_alien_turn_in_place_anim_state_override_func;
    level.dlc_alien_should_immediate_ragdoll_on_death_override_func = ::descent_alien_should_immediate_ragdoll_on_death_override_func;
    level.dlc_alien_can_attack_drill_override_func = ::descent_alien_can_attack_drill_override_func;
    _ID37876();
    thread maps\mp\alien\_alien_class_skills_main::_ID20445();

    if ( maps\mp\alien\_unk1464::_ID18745() )
        level._ID36763 = 1;
    else
        level._ID36763 = 0.49;

    level._ID36666 = 0.17;
    level._ID38298 = 2500;
    level._ID37428 = ::descent_hint_precache;
    maps\mp\mp_alien_dlc3_precache::_ID20445();
    maps\createart\mp_alien_dlc3_art::_ID20445();
    maps\mp\mp_alien_dlc3_fx::_ID20445();
    maps\mp\alien\mp_alien_dlc3_ark::_ID20445();
    maps\mp\alien\_alien_maaws::alien_maaws_init();
    level thread maps\mp\alien\_alien_plant::spore_plant_init();
    level.hypno_trap_func = _ID36636::_ID33862;
    level.tesla_trap_func = _ID36636::_ID33862;
    maps\mp\alien\_dlc3_weapon::_ID17631();
    maps\mp\_load::_ID20445();
    maps\mp\agents\alien\_alien_mammoth::mammoth_level_init();
    maps\mp\agents\alien\_alien_gargoyle::gargoyle_level_init();
    maps\mp\agents\alien\_alien_bomber::bomber_level_init();
    maps\mp\_compass::_ID29184( "compass_map_mp_alien_descent" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "urban";
    game["axis_outfit"] = "woodland";
    thread descent_intro_music();
    level thread maps\mp\mp_alien_dlc3_escape::hide_escape_geo( "escape_blocker_1_forcefield" );
    level thread maps\mp\mp_alien_dlc3_escape::hide_escape_geo( "escape_blocker_2_forcefield" );
    level thread maps\mp\mp_alien_dlc3_escape::hide_escape_geo( "escape_blocker_3_forcefield" );
    level.custom_alien_death_func = ::descent_alien_custom_death;
    init_weapon_stat_array();
    level.weapon_stats_override_name_func = ::descent_weapon_stats_override_func;
    level._ID37052 = ::dlc3_cangive_weapon_handler_func;
    level._ID37055 = ::dlc3_give_weapon_handler_func;
    level.dig_fx["shrine"]["player"] = loadfx( "vfx/moments/mp_dig/vfx_kstr_loadedguy" );
    level.dig_fx["shrine"]["screen"] = loadfx( "vfx/moments/mp_dig/vfx_kstr_loadedguy_scr" );
    level thread hide_bridge_parts();
    _ID36642::_ID37036();
    level thread mushroom_bounce_test();
    level.achievement_registration_func = maps\mp\alien\_achievement_dlc3::register_achievements_dlc3;
    level._ID38192 = maps\mp\alien\_achievement_dlc3::update_alien_kill_achievements_dlc3;
    setup_ammo_incompatible_list();
    level thread setup_dlc3_offhands();
    level.blocker_01_drill_spot = ( -16, -2784, 1235.13 );
    level.blocker_02_drill_spot = ( -3012.5, -475.5, 1383.5 );
    level thread dlc3_egg();
    level.cortex_fire_allowed = 1;
    level thread adjust_endgame_camera();
    disable_broken_nodes();
    level thread adjust_weapon_position();
}

adjust_endgame_camera()
{
    var_0 = getentarray( "mp_global_intermission", "classname" );

    foreach ( var_2 in var_0 )
        var_2.angles = ( 0, 91, 0 );
}

disable_broken_nodes()
{
    var_0 = getent( "clip256x256x8", "targetname" );
    var_0 moveto( ( -1759, 2166, 790 ), 0.05 );
    var_0.angles = ( 0, 0, -46 );
    var_0 waittill( "movedone" );
    var_0 disconnectpaths();
    var_1 = spawn( "script_model", ( -1750, 2162, 771.5 ) );
    var_1 setmodel( "dct_alien_plant01_top" );
    var_1.angles = ( 0, 0, -42 );
}

obelisk_emp_monitor()
{
    level endon( "game_ended" );
    wait 5;

    for (;;)
    {
        obelisk_emp_equipment( level._ID34099 );
        wait 0.1;
        obelisk_emp_equipment( level.placedims );
        wait 2;
    }
}

obelisk_emp_equipment( var_0 )
{
    var_1 = 2304;
    level endon( "game_ended" );
    var_2 = common_scripts\utility::array_combine( level._ID31986, level.scanned_obelisks );

    foreach ( var_4 in var_2 )
    {
        if ( !isdefined( var_4 ) || !isdefined( var_4.target ) )
            continue;

        var_5 = undefined;
        var_6 = getentarray( var_4.target, "targetname" );

        foreach ( var_8 in var_6 )
        {
            if ( var_8.classname == "script_brushmodel" )
                var_5 = var_8;
        }

        if ( !isdefined( var_5 ) )
            continue;

        foreach ( var_11 in var_0 )
        {
            if ( isdefined( var_11.carriedby ) )
                continue;

            if ( distance2dsquared( var_11.origin, var_5.origin ) < var_1 )
            {
                if ( var_11.origin[2] >= var_5.origin[2] && abs( var_11.origin[2] - var_5.origin[2] ) < 150 )
                {
                    var_11 notify( "death" );
                    wait 1;
                }
            }

            wait 0.05;
        }

        wait 0.05;
    }
}

play_ambient_fx()
{
    wait 5;
    common_scripts\utility::exploder( 50 );
    common_scripts\utility::exploder( 51 );
}

setup_dlc3_offhands()
{
    while ( !isdefined( level._ID22602 ) )
        wait 1;

    level._ID22602 = common_scripts\utility::array_add( level._ID22602, "iw6_aliendlc22_mp" );
    level._ID22602 = common_scripts\utility::array_add( level._ID22602, "iw6_aliendlc31_mp" );
    level._ID22602 = common_scripts\utility::array_add( level._ID22602, "iw6_aliendlc32_mp" );
    level._ID22602 = common_scripts\utility::array_add( level._ID22602, "iw6_aliendlc33_mp" );
    level._ID22603 = common_scripts\utility::array_add( level._ID22603, "iw6_aliendlc21_mp" );
}

setup_ammo_incompatible_list()
{
    level._ID36717 = [];
    level._ID36717[0] = "iw5_alienriotshield_mp";
    level._ID36717[1] = "iw5_alienriotshield1_mp";
    level._ID36717[2] = "iw5_alienriotshield2_mp";
    level._ID36717[3] = "iw5_alienriotshield3_mp";
    level._ID36717[4] = "iw5_alienriotshield4_mp";
    level._ID36717[5] = "iw6_alienminigun_mp";
    level._ID36717[6] = "iw6_alienminigun1_mp";
    level._ID36717[7] = "iw6_alienminigun2_mp";
    level._ID36717[8] = "iw6_alienminigun3_mp";
    level._ID36717[9] = "iw6_alienminigun4_mp";
    level._ID36717[10] = "iw6_alienmk32_mp";
    level._ID36717[11] = "iw6_alienmk321_mp";
    level._ID36717[12] = "iw6_alienmk322_mp";
    level._ID36717[13] = "iw6_alienmk323_mp";
    level._ID36717[14] = "iw6_alienmk324_mp";
    level._ID36717[15] = "iw6_aliendlc11_mp";
    level._ID36717[16] = "iw6_aliendlc11li_mp";
    level._ID36717[17] = "iw6_aliendlc11sp_mp";
    level._ID36717[18] = "iw6_aliendlc11fi_mp";
}

player_on_obelisk_monitor()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        return;

    wait 5;
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 = 2304;

    for (;;)
    {
        var_1 = common_scripts\utility::array_combine( level._ID31986, level.scanned_obelisks );

        foreach ( var_3 in var_1 )
        {
            if ( !isdefined( var_3 ) || !isdefined( var_3.target ) )
                continue;

            var_4 = undefined;
            var_5 = getentarray( var_3.target, "targetname" );

            foreach ( var_7 in var_5 )
            {
                if ( var_7.classname == "script_brushmodel" )
                    var_4 = var_7;
            }

            if ( !isdefined( var_4 ) )
                continue;

            if ( distance2dsquared( self.origin, var_4.origin ) < var_0 )
            {
                if ( self.origin[2] >= var_4.origin[2] && abs( self.origin[2] - var_4.origin[2] ) < 150 )
                {
                    playsoundatpos( self.origin, "alien_fence_shock" );
                    playfx( level._ID1644["obelisk_shock"], self.origin );
                    var_9 = self getvelocity();
                    self setvelocity( ( var_9[0] + 210, var_9[1] + -210, var_9[2] + 50 ) );
                    self dodamage( 5, var_4.origin, var_4, var_4, "MOD_UNKNOWN" );
                    wait 1;
                }
            }

            wait 0.05;
        }

        wait 0.05;
    }
}

chaos_player_on_obelisk_monitor()
{
    wait 5;
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 = getentarray( "area_03_hive_01", "targetname" );
    var_1 = getentarray( "area_03_hive_02", "targetname" );
    var_2 = 2304;

    for (;;)
    {
        var_3 = common_scripts\utility::array_combine( var_0, var_1 );

        foreach ( var_5 in level.players )
        {
            if ( maps\mp\alien\_laststand::player_in_laststand( var_5 ) )
                continue;

            foreach ( var_7 in var_3 )
            {
                var_8 = undefined;

                if ( var_7.classname == "script_brushmodel" )
                    var_8 = var_7;

                if ( !isdefined( var_8 ) )
                    continue;

                if ( distance2dsquared( var_5.origin, var_8.origin ) < var_2 )
                {
                    if ( var_5.origin[2] >= var_8.origin[2] && abs( var_5.origin[2] - var_8.origin[2] ) < 150 )
                    {
                        playsoundatpos( var_5.origin, "alien_fence_shock" );
                        playfx( level._ID1644["obelisk_shock"], var_5.origin );
                        var_9 = var_5 getvelocity();
                        var_5 setvelocity( ( var_9[0] + 210, var_9[1] + -210, var_9[2] + 50 ) );
                        var_5 dodamage( 5, var_8.origin, var_8, var_8, "MOD_UNKNOWN" );
                        wait 1;
                    }
                }

                wait 0.05;
            }

            wait 0.05;
        }

        wait 0.05;
    }
}

mushroom_bounce_test()
{
    var_0 = getentarray( "bounce_trig", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::shroom_bounce_monitor );
}

shroom_bounce_monitor()
{
    for (;;)
    {
        self waittill( "trigger",  var_0  );

        if ( isplayer( var_0 ) )
            var_0 thread shroom_bounce();
    }
}

shroom_bounce()
{
    if ( maps\mp\alien\_unk1464::_ID18506( self.isbouncing ) )
    {
        if ( maps\mp\alien\_unk1464::_ID18506( maps\mp\alien\_unk1464::_ID18437() ) )
        {
            var_0 = self getvelocity();
            self setvelocity( ( var_0[0] + randomintrange( 120, 150 ), var_0[1] + randomintrange( 120, 150 ), randomintrange( 200, 400 ) ) );
        }

        return;
    }

    self.isbouncing = 1;
    var_0 = self getvelocity();

    if ( maps\mp\alien\_unk1464::_ID18506( maps\mp\alien\_unk1464::_ID18437() ) )
        self setvelocity( ( var_0[0] + randomintrange( 120, 150 ), var_0[1] + randomintrange( 120, 150 ), randomintrange( 200, 400 ) ) );
    else
    {
        self setvelocity( ( var_0[0] + randomintrange( -160, 160 ), var_0[1] + randomintrange( -160, 160 ), randomintrange( 700, 900 ) ) );
        self playlocalsound( "plr_bounce" );
    }

    thread unset_shroom_bounce();
}

unset_shroom_bounce()
{
    self endon( "disconnect" );
    wait 1;
    self.isbouncing = 0;
}

_ID37876()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
    {
        maps\mp\gametypes\aliens::_ID37876( ::chaos_init, undefined, undefined, undefined, ::chaos_init, maps\mp\alien\_globallogic::blank );
        maps\mp\gametypes\aliens::_ID37876( maps\mp\alien\_chaos::chaos, undefined, undefined, undefined, maps\mp\alien\_chaos::chaos, maps\mp\alien\_globallogic::blank );
        return;
    }

    maps\mp\gametypes\aliens::_ID37876( ::_ID37164, undefined, undefined, undefined, ::_ID37164, maps\mp\alien\_globallogic::blank );
    maps\mp\gametypes\aliens::_ID37876( maps\mp\_obelisk::obelisk, 1, undefined, undefined, _ID36640::_ID38041, ::jump_to_area1_1st_obelisk, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( maps\mp\_obelisk::obelisk, 1, undefined, undefined, _ID36640::_ID38041, ::jump_to_area1_2nd_obelisk, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( maps\mp\_obelisk::obelisk, 1, undefined, undefined, _ID36640::_ID38041, ::jump_to_area1_3rd_obelisk, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( maps\mp\_obelisk::obelisk, 1, undefined, undefined, _ID36640::_ID38041, ::jump_to_area1_4th_obelisk, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( maps\mp\_obelisk::obelisk, 1, undefined, undefined, _ID36640::_ID38041, ::jump_to_area1_5th_obelisk, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( ::gate_blocker_01, 1, undefined, 1, _ID36640::_ID38041, ::jump_to_gate_blocker_01, ::beat_gate_blocker_01 );
    maps\mp\gametypes\aliens::_ID37876( maps\mp\_obelisk::obelisk, 1, undefined, undefined, _ID36640::_ID38041, ::jump_to_area2_1st_obelisk, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( maps\mp\_obelisk::obelisk, 1, undefined, undefined, _ID36640::_ID38041, ::jump_to_area2_2nd_obelisk, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( maps\mp\_obelisk::obelisk, 1, undefined, undefined, _ID36640::_ID38041, ::jump_to_area2_3rd_obelisk, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( maps\mp\_obelisk::obelisk, 1, undefined, undefined, _ID36640::_ID38041, ::jump_to_area2_4th_obelisk, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( maps\mp\_obelisk::obelisk, 1, undefined, undefined, _ID36640::_ID38041, ::jump_to_area2_5th_obelisk, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( ::gate_blocker_02, 1, undefined, 1, _ID36640::_ID38041, ::jump_to_gate_blocker_02, ::beat_gate_blocker_02 );
    maps\mp\gametypes\aliens::_ID37876( ::bridge_hive, 1, undefined, undefined, _ID36640::_ID38041, ::jump_to_bridge_1st_obelisk, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( ::bridge_hive, 1, undefined, undefined, _ID36640::_ID38041, ::jump_to_bridge_2nd_obelisk, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( ::bridge_hive, 1, undefined, undefined, _ID36640::_ID38041, ::jump_to_bridge_3rd_obelisk, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( maps\mp\mp_alien_dlc3_escape::escape_global_logic, 0, undefined, undefined, _ID36640::_ID38041, ::jumpto_escape_blocker_01, ::beat_ark_interior );
}

blank_script()
{

}

mp_alien_descent_onspawnplayer_func()
{
    thread _ID36641::_ID37117();
    thread maps\mp\alien\_cortex::monitor_cortex_fired();
    thread maps\mp\alien\_dlc3_weapon::dlc3_weapon_watcher();
    thread _ID36642::_ID37506();

    if ( !isdefined( level.setskillsflag ) )
    {
        level.setskillsflag = 1;
        common_scripts\utility::flag_set( "give_player_abilities" );
    }

    thread maps\mp\alien\_alien_class_skills_main::assign_skills();
    thread maps\mp\alien\_achievement::_ID37143( 2 );

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        return;

    if ( common_scripts\utility::_ID13177( "everyone_in_ark" ) && !common_scripts\utility::_ID13177( "ark_console_cycle_over" ) && !isdefined( self.reviveent ) )
        level thread maps\mp\alien\mp_alien_dlc3_ark::teleport_players_not_in_ark();
}

descent_get_non_agent_enemies()
{
    var_0 = [];

    if ( isdefined( level.alive_plants ) )
    {
        foreach ( var_2 in level.alive_plants )
            var_0 = common_scripts\utility::array_add( var_0, var_2.coll_model );

        return var_0;
    }

    return [];
}

monitorsprintslide()
{
    self endon( "disconnect" );

    for (;;)
    {
        var_0 = common_scripts\utility::_ID35635( "sprint_slide_begin", "sprint_slide_end", "death" );

        if ( !isalive( self ) )
        {
            self.issliding = undefined;
            self.isslidinggraceperiod = gettime() - 1;
            continue;
        }

        if ( var_0 == "sprint_slide_end" )
        {
            self.issliding = undefined;
            self.isslidinggraceperiod = gettime() + 1000;
            continue;
        }

        if ( var_0 == "sprint_slide_begin" )
            self.issliding = 1;
    }
}

playerissprintsliding()
{
    return isdefined( self.issliding ) || isdefined( self.isslidinggraceperiod ) && gettime() <= self.isslidinggraceperiod;
}

_ID37805()
{
    return isdefined( self.issliding ) || isdefined( self.isslidinggraceperiod ) && gettime() <= self.isslidinggraceperiod + 1000;
}

jump_to_gate_blocker_01()
{

}

jump_to_gate_blocker_02()
{

}

set_obelisks_as_scanned( var_0 )
{

}

descent_locker_weapon_pickup_string_func( var_0 )
{
    var_0 = "" + var_0;

    switch ( var_0 )
    {
        case "weapon_vks":
            return &"ALIEN_PICKUPS_DESCENT_LOCKER_VKS";
        case "weapon_usr":
            return &"ALIEN_PICKUPS_DESCENT_LOCKER_USR";
        case "weapon_remington_r5rgp":
            return &"ALIEN_PICKUPS_DESCENT_LOCKER_R5RGP";
        case "weapon_rm_22":
            return &"ALIEN_PICKUPS_DESCENT_LOCKER_MAVERICK";
        case "weapon_evopro":
            return &"ALIEN_PICKUPS_DESCENT_LOCKER_RIPPER";
        case "weapon_k7":
            return &"ALIEN_PICKUPS_DESCENT_LOCKER_K7";
        case "weapon_uts_15":
            return &"ALIEN_PICKUPS_DESCENT_LOCKER_UTS";
        case "weapon_maul":
            return &"ALIEN_PICKUPS_DESCENT_LOCKER_MAUL";
        case "weapon_mk14_ebr_iw6":
            return &"ALIEN_PICKUPS_DESCENT_LOCKER_MK14";
        case "weapon_imbel_ia2":
            return &"ALIEN_PICKUPS_DESCENT_LOCKER_IMBEL";
        case "weapon_kac_chainsaw":
            return &"ALIEN_PICKUPS_DESCENT_LOCKER_KAC";
        case "weapon_ameli":
            return &"ALIEN_PICKUPS_DESCENT_LOCKER_AMELI";
    }
}

mp_alien_descent_pillage_init()
{
    level.pillageinfo = spawnstruct();
    level.pillageinfo._ID37088 = 1000;
    level.pillageinfo._ID37691 = "pb_money_stack_01";
    level.pillageinfo._ID36748 = "has_spotter_scope";
    level.pillageinfo.alienattachment_model = "weapon_alien_muzzlebreak";
    level.pillageinfo._ID37665 = "mil_ammo_case_1_open";
    level.pillageinfo._ID37220 = "mil_emergency_flare_mp";
    level.pillageinfo._ID36975 = "weapon_baseweapon_clip";
    level.pillageinfo._ID38047 = "weapon_soflam";
    level.pillageinfo._ID37610 = "weapon_knife_iw6";
    level.pillageinfo._ID38164 = "mp_trophy_system_folded_iw6";
    level.pillageinfo._ID38182 = 1;
    level.pillageinfo._ID37133 = 30;
    level.pillageinfo._ID37138 = 12;
    level.pillageinfo._ID37134 = 19;
    level.pillageinfo._ID37135 = 15;
    level.pillageinfo._ID37140 = 7;
    level.pillageinfo._ID37136 = 5;
    level.pillageinfo._ID37137 = 2;
    level.pillageinfo.easy_intel = 5;
    level.pillageinfo._ID37668 = 30;
    level.pillageinfo._ID37670 = 15;
    level.pillageinfo._ID37673 = 10;
    level.pillageinfo._ID37669 = 10;
    level.pillageinfo._ID37675 = 10;
    level.pillageinfo._ID37671 = 5;
    level.pillageinfo._ID37676 = 5;
    level.pillageinfo._ID37672 = 5;
    level.pillageinfo.medium_intel = 5;
    level.pillageinfo._ID37399 = 30;
    level.pillageinfo._ID37400 = 14;
    level.pillageinfo._ID37401 = 10;
    level.pillageinfo._ID37403 = 10;
    level.pillageinfo._ID37406 = 11;
    level.pillageinfo._ID37404 = 5;
    level.pillageinfo._ID37407 = 5;
    level.pillageinfo._ID37402 = 5;
    level.pillageinfo.hard_intel = 5;
    level.attachment_found_func = ::remove_alienmuzzlebrake;
    level.recipe_setup_func = ::descent_recipe_setup_func;
    level thread init_attachment_and_crafting_locations();
    level._ID37006 = "mp/alien/crafting_items.csv";
    level._ID37012 = 0;
    level._ID37014 = 1;
    level._ID37013 = 2;
    level._ID37011 = 3;
    level._ID37652 = 3;
    level._ID37008 = "weapon_baseweapon_clip";
    level._ID37284 = ::dlc3_get_hintstring_for_pillaged_item_func;
    level._ID37282 = ::dlc3_get_hintstring_for_item_pickup_func;
    level._ID37051 = ::dlc3_build_pillageitem_array_func;
    level.random_crafting_list = [ "venomx", "nucleicbattery", "bluebiolum", "biolum", "orangebiolum", "fuse", "tnt", "pipe", "resin", "biolum", "cellbattery" ];
    relocate_bad_pillage_spots();
}

relocate_bad_pillage_spots()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        return;

    var_0 = 0;

    foreach ( var_2 in level.struct )
    {
        if ( var_2.origin == ( -1748.6, 2168.2, 777.4 ) )
        {
            var_2.origin = ( -1705, 2050, 907 );
            var_2.angles = ( 335.34, 274.43, 0.83 );
        }
        else if ( var_2.origin == ( -2066.6, -1783.8, 1390.6 ) )
            var_2.origin = ( -2066.6, -1783.8, 1385 );
        else if ( var_2.origin == ( 615, -3964, 1002.2 ) )
        {
            var_2.origin = ( 613.59, -3949.01, 1004.7 );
            var_2.angles = ( 7.93, 357.6, 27.8 );
        }

        var_0++;

        if ( var_0 % 10 == 0 )
            wait 0.1;
    }
}

adjust_weapon_position()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        return;

    var_0 = 0;

    foreach ( var_2 in level.struct )
    {
        if ( var_2.origin == ( 723.5, -1921, 1315.6 ) )
        {
            var_2.origin = ( 916.95, -1877.7, 1166.94 );
            var_2.item_ent.origin = ( 916.95, -1877.7, 1166.94 );
            var_2.item_ent.angles = ( 314, 212, 0 );
            break;
        }

        var_0++;

        if ( var_0 % 10 == 0 )
            wait 0.1;
    }
}

dlc3_get_hintstring_for_pillaged_item_func( var_0 )
{
    var_0 = "" + var_0;

    switch ( var_0 )
    {
        case "crafting":
            return &"ALIEN_CRAFTING_FOUND_CRAFTING_ITEM";
        case "locker_key":
            return &"ALIEN_PILLAGE_LOCKER_FOUND_LOCKER_KEY";
        case "locker_weapon":
            return &"ALIEN_PILLAGE_LOCKER_FOUND_LOCKER_WEAPON";
    }
}

dlc3_get_hintstring_for_item_pickup_func( var_0 )
{
    var_0 = "" + var_0;

    switch ( var_0 )
    {
        case "wire":
            return &"ALIEN_CRAFTING_PICKUP_WIRE";
        case "amolecular":
            return &"ALIEN_CRAFTING_PICKUP_AMOLECULAR";
        case "fuse":
            return &"ALIEN_CRAFTING_PICKUP_FUSE";
        case "pipe":
            return &"ALIEN_CRAFTING_PICKUP_PIPE";
        case "pressureplate":
            return &"ALIEN_CRAFTING_PICKUP_PRESSUREPLATE";
        case "nucleicbattery":
            return &"ALIEN_CRAFTING_PICKUP_NUCLEICBATTERY";
        case "cellbattery":
            return &"ALIEN_CRAFTING_PICKUP_CELLBATTERY";
        case "liquidbattery":
            return &"ALIEN_CRAFTING_PICKUP_LIQUIDBATTERY";
        case "tnt":
            return &"ALIEN_CRAFTING_PICKUP_TNT";
        case "resin":
            return &"ALIEN_CRAFTING_PICKUP_RESIN";
        case "bbiolum":
            return &"ALIEN_CRAFTING_PICKUP_BIOLUM";
        case "biolum":
            return &"ALIEN_CRAFTING_PICKUP_BIOLUM";
        case "locker_key":
            return &"ALIEN_PILLAGE_LOCKER_PICKUP_LOCKER_KEY";
        case "locker_weapon":
            return &"ALIEN_PILLAGE_LOCKER_PICKUP_LOCKER_WEAPON";
        case "venomx":
            return &"ALIEN_CRAFTING_PICKUP_DISARMED_VENOM";
        case "bluebiolum":
        case "bbluebiolum":
            return &"ALIEN_CRAFTING_PICKUP_BLUEBIOLUM";
        case "orangebiolum":
        case "oorangebiolum":
            return &"ALIEN_CRAFTING_PICKUP_ORANGEBIOLUM";
        case "amethystbiolum":
            return &"ALIEN_CRAFTING_PICKUP_PURPLEBIOLUM";
        case "iw6_aliendlc22_mp":
            return &"ALIEN_CRAFTING_PICKUP_PIPEBOMB";
        case "flare":
        case "iw6_aliendlc21_mp":
        case "viewmodel_flare":
        case "stickyflare":
            return &"ALIEN_CRAFTING_PICKUP_STICKYFLARE";
        case "detonator":
            return &"ALIEN_CRAFTING_PICKUP_DETONATOR";
        case "casing":
            return &"ALIEN_CRAFTING_PICKUP_CASING";
        case "iw6_aliendlc31_mp":
            return &"ALIEN_CRAFTING_PICKUP_VENOMXGRENADE";
        case "iw6_aliendlc32_mp":
            return &"ALIEN_CRAFTING_PICKUP_VENOMLXGRENADE";
        case "iw6_aliendlc33_mp":
            return &"ALIEN_CRAFTING_PICKUP_VENOMFXGRENADE";
    }

    if ( isdefined( level.level_locker_weapon_pickup_string_func ) )
        return [[ level.level_locker_weapon_pickup_string_func ]]( var_0 );
}

dlc3_build_pillageitem_array_func( var_0 )
{
    switch ( var_0 )
    {
        case "easy":
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "crafting", level.pillageinfo._ID37003 );
            break;
        case "medium":
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "crafting", level.pillageinfo._ID37007 );
            break;
        case "hard":
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "crafting", level.pillageinfo._ID37004 );
            break;
    }

    level thread _ID36642::build_intel_pillageitem_arrays( var_0 );
}

descent_recipe_setup_func()
{
    return [ "tesla", "grenade", "trap", "weapon", "sticky", "vgrenade" ];
}

init_attachment_and_crafting_locations()
{
    level thread _ID36636::_ID17631();
    wait 10;
    var_0 = [];
    var_0[0] = getent( "ark_area_1_section_1", "targetname" );
    var_0[1] = getent( "ark_area_1_section_2", "targetname" );
    var_0[2] = getent( "ark_area_1_section_3", "targetname" );
    var_1 = common_scripts\utility::_ID25350( var_0 );
    var_2 = [];
    var_2[0] = getent( "ark_area_2_section_1", "targetname" );
    var_2[1] = getent( "ark_area_2_section_2", "targetname" );
    var_2[2] = getent( "ark_area_2_section_3", "targetname" );
    var_3 = common_scripts\utility::_ID25350( var_2 );
    var_4 = spawn( "script_model", ( 0, 0, 0 ) );
    var_5 = [];
    var_5[0] = getent( "ark_area_3_section_1", "targetname" );
    var_5[1] = getent( "ark_area_3_section_2", "targetname" );
    var_5[2] = var_4;
    var_6 = [ var_5[0], var_5[1] ];
    setup_attachment_crafting_area( var_0, var_1, 1 );
    common_scripts\utility::_ID35582();
    setup_attachment_crafting_area( var_2, var_3, 2 );
    common_scripts\utility::_ID35582();
    setup_attachment_crafting_area( var_5, var_6, 3 );

    if ( !isdefined( level._ID23658 ) )
        level._ID23658 = [];

    level.trophy_use_pickupfunc = _ID36635::trophy_use_pickupfunc;
    level.custom_pet_bomb_check = _ID36635::crafting_pet_trap_check;
    level.resetplayercraftingitemsonrespawn = _ID36635::resetplayercraftingitemsonrespawn;

    if ( !maps\mp\alien\_unk1464::is_chaos_mode() )
        _ID36635::setup_recipes();
}

setup_attachment_crafting_area( var_0, var_1, var_2 )
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
    {
        for ( var_3 = 0; var_3 < var_0.size; var_3++ )
            var_0[var_3] delete();

        return;
    }

    var_4 = undefined;

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        if ( isarray( var_1 ) )
        {
            foreach ( var_6 in var_1 )
            {
                if ( var_0[var_3] == var_6 )
                    var_4 = var_6;
            }
        }
        else
            var_4 = var_1;

        if ( var_0[var_3] == var_4 )
        {
            var_8 = common_scripts\utility::_ID15384( "gun_area_" + var_2 + "_section_" + ( var_3 + 1 ), "targetname" );
            var_9 = spawn( "script_model", var_8.origin );
            var_9.angles = var_8.angles;
            var_9 setmodel( "weapon_ameli_green" );
            var_0[var_3] thread setup_attachment_pickup_spot();
            continue;
            continue;
        }

        var_10 = common_scripts\utility::_ID15386( "crafting_area_" + var_2 + "_section_" + ( var_3 + 1 ), "targetname" );

        foreach ( var_12 in var_10 )
        {
            var_13 = spawn( "script_model", var_12.origin );
            var_13.angles = var_12.angles;
            var_13 setmodel( "beacon_intel_tablet" );
            var_13.targetname = "crafting_recipe_table";
        }

        var_0[var_3] delete();
    }
}

setup_attachment_pickup_spot()
{
    var_0 = spawnstruct();
    var_0.origin = self.origin;
    var_0.pillageinfo = spawnstruct();
    var_0.pillage_trigger = self;
    var_0.pillage_trigger.angles = self.angles;
    var_1 = &"MP_ALIEN_DESCENT_ATTACHMENT_PICKUP";
    var_0.pillage_trigger sethintstring( var_1 );
    var_0.pillage_trigger makeusable();

    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
        maps\mp\alien\_outline_proto::add_to_outline_pillage_watch_list( var_0.pillage_trigger, 0 );

    var_0._ID11491 = 1;
    var_0._ID27956 = 1;
    var_0.pillageinfo.type = "attachment";
    var_0.pillageinfo._ID4040 = "alienmuzzlebrake";
    var_0.pillageinfo.ammo = 1;
    var_0 thread maps\mp\alien\_pillage::_ID23567();
}

remove_alienmuzzlebrake( var_0 )
{
    if ( var_0 != "alienmuzzlebrake" )
        return var_0;

    var_1 = self getcurrentweapon();
    var_2 = getweaponbasename( var_1 );
    var_3 = maps\mp\_utility::getweaponclass( var_1 );

    switch ( var_3 )
    {
        case "weapon_shotgun":
        case "weapon_dmr":
            return "reflex";
        case "weapon_assault":
            if ( issubstr( var_2, "sc2010" ) )
                return "reflex";

            break;
    }

    return "rof";
}

descent_hint_precache()
{
    var_0 = [];
    var_0["ALIEN_PICKUPS_DESCENT_PICKUP_AMELI"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_AMELI";
    var_0["ALIEN_PICKUPS_DESCENT_PICKUP_IMBEL"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_IMBEL";
    var_0["ALIEN_PICKUPS_DESCENT_PICKUP_K7"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_K7";
    var_0["ALIEN_PICKUPS_DESCENT_PICKUP_KAC"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_KAC";
    var_0["ALIEN_PICKUPS_DESCENT_PICKUP_KASTET"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_KASTET";
    var_0["ALIEN_PICKUPS_DESCENT_PICKUP_MAUL"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_MAUL";
    var_0["ALIEN_PICKUPS_DESCENT_PICKUP_MAVERICK"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_MAVERICK";
    var_0["ALIEN_PICKUPS_DESCENT_PICKUP_MK14"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_MK14";
    var_0["ALIEN_PICKUPS_DESCENT_PICKUP_R5RGP"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_R5RGP";
    var_0["ALIEN_PICKUPS_DESCENT_PICKUP_RIPPER"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_RIPPER";
    var_0["ALIEN_PICKUPS_DESCENT_PICKUP_USR"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_USR";
    var_0["ALIEN_PICKUPS_DESCENT_PICKUP_UTS"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_UTS";
    var_0["ALIEN_PICKUPS_DESCENT_PICKUP_VKS"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_VKS";
    return var_0;
}

_ID37164()
{
    maps\mp\alien\_drill::_ID17725();
    _ID36640::_ID37474();
    maps\mp\_obelisk::obelisk_init();
    thread maps\mp\alien\_alien_vanguard::_ID17631();
    thread gate_blocker_glyphs( 1 );
    var_0 = getent( "blocker_01_forcefield", "targetname" );
    var_0 disconnectpaths();
    var_0 = getent( "blocker_02_forcefield", "targetname" );
    var_0 disconnectpaths();
    level thread wait_spawn_intro_drill();
    level thread maps\mp\mp_alien_dlc3_vignettes::_ID20445();
    maps\mp\alien\_gamescore_dlc3::init_descent_eog_score_components( [ "hive", "gryphon", "ark", "escape", "relics" ] );
    maps\mp\alien\_unk1443::_ID37465( [ "challenge", "drill", "team", "personal" ] );
    maps\mp\alien\_gamescore_dlc3::_ID37465( [ "gryphon", "gryphon_team", "gryphon_personal", "cortex", "cortex_team", "cortex_personal", "escape", "escape_team", "escape_personal" ] );
    level thread obelisk_emp_monitor();
}

wait_spawn_intro_drill()
{
    wait 5.0;
    level notify( "spawn_intro_drill" );
    common_scripts\utility::flag_set( "intro_sequence_complete" );
}

descent_enter_area_func( var_0 )
{
    if ( !maps\mp\alien\_unk1464::is_chaos_mode() )
        _ID36634::_ID36650( var_0 );
}

descent_leave_area_func( var_0 )
{

}

descent_melee_override_func( var_0 )
{
    switch ( self._ID20883 )
    {
        case "burrow":
            maps\mp\agents\alien\_alien_mammoth::burrow( var_0 );
            break;
        case "stun":
            maps\mp\agents\alien\_alien_gargoyle::stun( var_0 );
            break;
        case "wing_swipe":
            maps\mp\agents\alien\_alien_gargoyle::wing_swipe( var_0 );
            break;
        case "hover_attack":
            maps\mp\agents\alien\_alien_gargoyle::hover( var_0 );
            break;
        case "divebomb":
            maps\mp\agents\alien\_alien_bomber::divebomb( var_0 );
            break;
        case "strafe_run":
            maps\mp\agents\alien\_alien_gargoyle::strafe_run( var_0 );
            break;
        case "kamikaze":
            maps\mp\agents\alien\_alien_bomber::kamikaze( var_0 );
            break;
        case "fissure_spawn":
            maps\mp\agents\alien\_alien_mammoth::fissure_spawn( var_0 );
            break;
        case "mammoth_angered":
            maps\mp\agents\alien\_alien_mammoth::mammoth_angered( var_0 );
            break;
        case "takeoff":
            maps\mp\agents\alien\_alien_gargoyle::takeoff( var_0 );
            break;
        case "land":
            maps\mp\agents\alien\_alien_gargoyle::land( var_0 );
            break;
        case "air_dodge":
            maps\mp\agents\alien\_alien_gargoyle::air_dodge( var_0 );
            break;
        case "fly":
            maps\mp\agents\alien\_alien_gargoyle::fly( var_0 );
            break;
        case "fly_intro":
            maps\mp\agents\alien\_alien_gargoyle::fly_intro( var_0 );
            break;
    }
}

descent_alien_idle_anim_state_override_func( var_0 )
{
    if ( !isdefined( self.alien_type ) )
        return undefined;

    switch ( self.alien_type )
    {
        case "gargoyle":
            return maps\mp\agents\alien\_alien_gargoyle::gargoyle_idle_state( var_0 );
    }

    return undefined;
}

descent_can_do_pain_override_func( var_0 )
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "gargoyle":
            return maps\mp\agents\alien\_alien_gargoyle::can_do_pain( var_0 );
        default:
            return 1;
    }
}

descent_alien_pain_anim_state_override_func( var_0 )
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "gargoyle":
            return maps\mp\agents\alien\_alien_gargoyle::get_pain_anim_state( var_0 );
        default:
            return undefined;
    }
}

descent_alien_turn_in_place_anim_state_override_func()
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "gargoyle":
            return maps\mp\agents\alien\_alien_gargoyle::get_turn_in_place_anim_state();
        default:
            return undefined;
    }
}

descent_alien_can_attack_drill_override_func( var_0 )
{
    switch ( var_0 )
    {
        case "gargoyle":
            if ( isdefined( level.vanguard_active ) && level.vanguard_active )
                return 1;
        default:
            break;
    }

    return undefined;
}

descent_alien_should_immediate_ragdoll_on_death_override_func( var_0 )
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "gargoyle":
            return maps\mp\agents\alien\_alien_gargoyle::should_immediate_ragdoll_on_death();
        default:
            return undefined;
    }
}

descent_alien_can_retreat_override_func( var_0 )
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "gargoyle":
            return maps\mp\agents\alien\_alien_gargoyle::can_retreat( var_0 );
        default:
            return 1;
    }
}

descent_alien_type_node_match_override_func( var_0 )
{
    switch ( var_0 )
    {
        case "elite":
        case "mammoth":
        case "bomber":
            return 0;
        case "gargoyle":
            if ( getdvarint( "scr_gargoyle_disable_fly_intro" ) != 1 )
                return 0;

            break;
        default:
            return 1;
    }
}

descent_alien_jump_override( var_0, var_1, var_2, var_3 )
{
    var_4 = undefined;

    if ( isdefined( var_1.script_noteworthy ) && var_1.script_noteworthy != "flyable" )
        var_4 = var_1.script_noteworthy;

    maps\mp\agents\alien\_alien_jump::_ID18995( var_0.origin, var_0.angles, var_1.origin, var_1.angles, var_3, undefined, var_4 );
}

descent_alien_init_override_func()
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "mammoth":
            maps\mp\agents\alien\_alien_mammoth::mammoth_init();
            level notify( "dlc_vo_notify",  "inbound_mammoth", self  );
            break;
        case "gargoyle":
            maps\mp\agents\alien\_alien_gargoyle::gargoyle_init();
            break;
        case "bomber":
            maps\mp\agents\alien\_alien_bomber::bomber_init();
            break;
    }
}

descent_alien_attack_override_func( var_0, var_1 )
{
    switch ( var_1 )
    {
        case "burrow":
            maps\mp\agents\alien\_alien_mammoth::burrow_attack( var_0 );
            break;
        case "stun":
            maps\mp\agents\alien\_alien_gargoyle::stun_attack( var_0 );
            break;
        case "wing_swipe":
            maps\mp\agents\alien\_alien_gargoyle::wing_swipe_attack( var_0 );
            break;
        case "hover_attack":
            maps\mp\agents\alien\_alien_gargoyle::hover_attack( var_0 );
            break;
        case "strafe_run":
            maps\mp\agents\alien\_alien_gargoyle::strafe_run_attack( var_0 );
            break;
        case "fissure_spawn":
            maps\mp\agents\alien\_alien_mammoth::fissure_spawn_attack( var_0 );
            break;
        case "mammoth_angered":
            maps\mp\agents\alien\_alien_mammoth::mammoth_angered_attack( var_0 );
            break;
        case "takeoff":
            maps\mp\agents\alien\_alien_gargoyle::takeoff_attack( var_0 );
            break;
        case "land":
            maps\mp\agents\alien\_alien_gargoyle::landing_attack( var_0 );
            break;
        case "fly":
            maps\mp\agents\alien\_alien_gargoyle::fly_attack( var_0 );
            break;
        case "fly_intro":
            maps\mp\agents\alien\_alien_gargoyle::fly_intro_attack( var_0 );
            break;
        default:
            return 0;
    }

    return 1;
}

descent_alien_death_override_func( var_0 )
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "bomber":
            thread maps\mp\agents\alien\_alien_bomber::bomber_death( self.origin );
            break;
    }
}

descent_alien_custom_death( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = isdefined( var_1 ) && isplayer( var_1 );

    if ( var_7 && isdefined( var_4 ) && maps\mp\alien\_unk1464::weapon_has_alien_attachment( var_4 ) && var_3 != "MOD_MELEE" && !maps\mp\alien\_unk1464::_ID18506( level._ID11234 ) )
    {
        playfx( level._ID1644["alien_ark_gib"], self.origin + ( 0, 0, 32 ) );

        if ( maps\mp\alien\_unk1464::_ID18506( level.should_use_custom_death_func ) )
            level thread maps\mp\mp_alien_dlc3_escape::alien_death_trail( self.origin );

        return 1;
    }

    if ( maps\mp\alien\_unk1464::_ID18506( level.should_use_custom_death_func ) )
    {
        if ( maps\mp\alien\_unk1464::_ID18506( self.cortex_kill ) )
        {
            playfx( level._ID1644["alien_gib"], self.origin + ( 0, 0, 32 ) );
            return 1;
        }

        if ( var_7 || isdefined( var_1.owner ) && isplayer( var_1.owner ) )
        {
            level thread maps\mp\mp_alien_dlc3_escape::alien_death_trail( self.origin );
            return 0;
        }
    }

    return 0;
}

descent_intro_music()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread descent_intro_music_play();
        var_0 thread monitorsprintslide();
        var_0 thread player_on_obelisk_monitor();
    }
}

descent_intro_music_play()
{
    self waittill( "spawned_player" );

    foreach ( var_1 in level.players )
    {
        wait 0.01;

        if ( common_scripts\utility::flag_exist( "intro_sequence_complete" ) && !common_scripts\utility::_ID13177( "intro_sequence_complete" ) )
        {
            var_1 stoplocalsound( "us_spawn_music" );

            if ( !level.splitscreen || level.splitscreen && !isdefined( level.playeddescentstartingmusic ) )
            {
                if ( !self issplitscreenplayer() || self issplitscreenplayerprimary() )
                    level thread maps\mp\alien\_music_and_dialog::play_alien_music( "mus_alien_dlc3_descent_intro" );

                if ( level.splitscreen )
                    level.playeddescentstartingmusic = 1;
            }

            continue;
        }

        wait 0.1;
        var_1 stoplocalsound( "us_spawn_music" );
        wait 0.1;
        var_1 stoplocalsound( "us_spawn_music" );
        wait 0.1;
        var_1 stoplocalsound( "us_spawn_music" );
        wait 0.1;
        var_1 stoplocalsound( "us_spawn_music" );
        wait 0.1;
        var_1 stoplocalsound( "us_spawn_music" );
    }
}

gate_blocker_glyphs( var_0 )
{
    level endon( "game_ended" );
    level endon( "alien_vanguard_access_0" + var_0 );
    var_1 = -1;
    var_2 = getent( "blocker_0" + var_0 + "_door", "targetname" );

    for (;;)
    {
        level waittill( "obelisk_destroyed" );
        var_1++;
        var_2 setscriptablepartstate( 0, "glyph_" + var_1 );
    }
}

gate_blocker( var_0 )
{
    level endon( "game_ended" );

    while ( !isdefined( level.drill_icon ) )
        common_scripts\utility::_ID35582();

    var_1 = gettime();
    level notify( "alien_vanguard_access_0" + var_0 );
    level.vanguard_active = 1;
    maps\mp\alien\_unk1443::_ID37894();
    var_2 = getent( "blocker_0" + var_0 + "_door", "targetname" );
    var_2 setscriptablepartstate( 0, "open" );
    var_2 playsound( "scn_gate_open" );
    level thread deploy_vanguard_nag( 20 );
    level.drill_use_trig makeunusable();
    maps\mp\alien\_outline_proto::remove_from_drill_preplant_watch_list( level.drill );
    maps\mp\alien\_drill::_ID9765();
    common_scripts\utility::flag_wait( "player_using_vanguard" );
    level thread maps\mp\alien\_spawnlogic::_ID37163( "alien_vanguard_0" + var_0 + "_triggered", "blocker_0" + var_0 + "_destroyed" );
    maps\mp\_obelisk::wait_for_all_scanned_obelisk_destroyed( 13000, [ "alienvanguard_projectile_mp", "alienvanguard_projectile_mini_mp" ], "waypoint_alien_destroy" );
    level notify( "ff_down" );

    foreach ( var_4 in level.players )
        var_4 maps\mp\_utility::_ID7495( "vanguard_use_hint" );

    switch ( var_0 )
    {
        case 1:
            level thread maps\mp\alien\_drill::_ID32724( level.blocker_01_drill_spot );
            break;
        case 2:
            level thread maps\mp\alien\_drill::_ID32724( level.blocker_02_drill_spot );
            break;
    }

    level.drill_use_trig makeusable();
    maps\mp\alien\_outline_proto::add_to_drill_preplant_watch_list( level.drill );
    level.drill maps\mp\alien\_drill::_ID28321();
    var_6 = getent( "blocker_0" + var_0 + "_forcefield", "targetname" );
    var_6 thread sfx_forcefield_down();
    var_6 connectpaths();
    common_scripts\utility::_ID35582();
    var_6 delete();
    var_2 setscriptablepartstate( 0, "ff_down" );

    if ( var_0 == 1 )
        thread gate_blocker_glyphs( 2 );

    level notify( "blocker_0" + var_0 + "_destroyed" );
    level thread maps\mp\alien\_spawn_director::_ID11539();
    level thread maps\mp\alien\_spawnlogic::remaining_alien_management();
    maps\mp\alien\_unk1443::_ID38222( "gryphon", "gryphon_encounter_duration", gettime() - var_1 );
    maps\mp\alien\_unk1443::_ID36926( level.players, maps\mp\alien\_gamescore_dlc3::get_gryphon_score_component_list() );
    give_players_blocker_rewards();
    level.vanguard_active = 0;

    if ( maps\mp\alien\_unk1464::_ID18745() && !issplitscreen() )
        maps\mp\alien\_laststand::_ID15541( level.players[0], 1 );

    level notify( "descent_door_complete" );
}

sfx_forcefield_down()
{
    playsoundatpos( self.origin, "scn_dsnt_forcefield_down" );
}

give_players_blocker_rewards()
{
    foreach ( var_1 in level.players )
    {
        var_1 maps\mp\alien\_persistence::eog_player_update_stat( "hivesdestroyed", 1 );
        var_1 maps\mp\alien\_persistence::try_award_bonus_pool_token();
        var_1 thread _ID36640::_ID35519();
    }
}

gate_blocker_create_ff_fx( var_0 )
{
    self endon( "disconnect" );
    self endon( "ff_down" );
    wait 0.1;
    var_1 = spawnfx( level._ID1644["alien_forcefield"], var_0.origin + ( 0, 0, 0 ), ( 90, 0, 0 ) );

    for (;;)
    {
        triggerfx( var_1 );
        wait 5;
    }
}

gate_blocker_01()
{
    level notify( "vo_before_first_blocker" );
    gate_blocker( 1 );
    level notify( "vo_after_first_blocker" );
    maps\mp\alien\_unk1464::update_player_initial_spawn_info( ( -1212, -2863, 999 ), ( 0, 114, 0 ) );
    maps\mp\alien\_achievement_dlc3::update_progression_achievements( "complete_first_gate" );
}

gate_blocker_02()
{
    level notify( "vo_before_second_blocker" );
    gate_blocker( 2 );
    level notify( "vo_after_second_blocker" );
    maps\mp\alien\_unk1464::update_player_initial_spawn_info( ( -2417, 510, 1226 ), ( 0, 27, 0 ) );
}

gate_blocker_dmg_think()
{
    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( isdefined( var_9 ) && var_9 == "alienvanguard_projectile_mp" )
        {
            var_10 = distancesquared( self.origin, var_3 );

            if ( var_10 < 10000 )
            {
                level notify( "gate_damaged" );
                self.life--;

                if ( self.life <= 0 )
                    break;
            }
        }
    }

    level notify( "dlc_vo_notify",  "descent_vo", "door_incomplete"  );
    level notify( self.targetname + "_destroyed" );
    self.destroy_icon destroy();
    self delete();
}

gate_blocker_dmg_nag( var_0 )
{
    level endon( "gate_damaged" );
    level waittill( "vanguard_used" );
    wait(var_0);

    for (;;)
    {
        level notify( "dlc_vo_notify",  "descent_vo", "control_vanguard"  );
        wait(var_0);
    }
}

deploy_vanguard_nag( var_0 )
{
    level endon( "vanguard_used" );
    common_scripts\utility::flag_wait( "blocker_gate_1_init_vo_done" );

    for (;;)
    {
        level notify( "dlc_vo_notify",  "descent_vo", "deploy_vanguard"  );
        wait(var_0);
    }
}

beat_gate_blocker( var_0 )
{

}

beat_gate_blocker_01()
{

}

beat_gate_blocker_02()
{

}

bridge_hive()
{
    maps\mp\_obelisk::obelisk();
    level thread open_bridge_obelisk( level.current_hive_name );
    level thread check_bridge_hives_and_play_vo();
}

open_bridge_obelisk( var_0 )
{
    var_0 = maps\mp\_utility::_ID31978( var_0, "_post" );
    open_obelisk( var_0 );
}

open_obelisk( var_0, var_1 )
{
    var_2 = getentarray( var_0, "targetname" );
    thread open_bridge_obelisk_fx( var_0, var_1 );

    if ( !isdefined( var_2 ) )
        return;

    foreach ( var_4 in var_2 )
    {
        if ( !isdefined( var_4.script_noteworthy ) )
            continue;

        switch ( var_4.script_noteworthy )
        {
            case "shell_a":
                var_4 moveto( transform_pos_ang( var_4, ( 4, 4, -32 ), 1 ), 5, 0.5, 0.5 );
                continue;
            case "shell_b":
                var_4 moveto( transform_pos_ang( var_4, ( 4, -4, -32 ), 0 ), 5, 0.5, 0.5 );
                continue;
            case "shell_c":
                var_4 moveto( transform_pos_ang( var_4, ( -4, -4, -32 ), 0 ), 5, 0.5, 0.5 );
                continue;
            case "shell_d":
                var_4 moveto( transform_pos_ang( var_4, ( -4, 4, -32 ), 1 ), 5, 0.5, 0.5 );
                continue;
            default:
                continue;
        }
    }
}

open_bridge_obelisk_fx( var_0, var_1 )
{
    var_2 = getscriptablearray( var_0, "targetname" );

    if ( !isdefined( var_2 ) )
        return;

    foreach ( var_4 in var_2 )
    {
        wait 1;
        var_4 setscriptablepartstate( "base", "warm_up" );
        wait 6;

        if ( isdefined( var_1 ) )
        {
            var_4 setscriptablepartstate( "base", var_1 );
            continue;
        }

        var_4 setscriptablepartstate( "base", "on" );
    }
}

transform_pos_ang( var_0, var_1, var_2 )
{
    var_3 = var_0.origin;
    var_4 = ( 0, 0, 0 );

    if ( maps\mp\alien\_unk1464::_ID18506( var_2 ) )
        var_4 = ( 0, 180, 0 );

    var_5 = var_0.origin;
    var_6 = var_0.angles;
    var_7 = var_0.origin + var_1;
    var_8 = var_0.angles;
    var_9 = transformmove( var_5, var_6, var_3, var_4, var_7, var_8 );
    return var_9["origin"];
}

beat_ark_interior()
{
    level notify( "debug_beat_ark_interior" );
}

jumpto_escape_blocker_01()
{

}

jumpto_escape()
{

}

debug_open_blocker_doors()
{
    var_0 = getent( "blocker_01_door", "targetname" );
    var_1 = getent( "blocker_02_door", "targetname" );
    var_2 = getent( "blocker_01_forcefield", "targetname" );
    var_3 = getent( "blocker_02_forcefield", "targetname" );
    var_0 setscriptablepartstate( 0, "ff_down" );
    var_1 setscriptablepartstate( 0, "ff_down" );
    var_2 delete();
    var_3 delete();
}

change_player_facing()
{
    while ( !isdefined( level.players ) )
        wait 0.1;

    foreach ( var_1 in level.players )
        var_1 setplayerangles( var_1.angles + ( 0, -90, 0 ) );
}

set_spawn_table()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        set_chaos_spawn_table();
    else
    {
        if ( maps\mp\alien\_unk1464::_ID18426() )
        {
            set_hardcore_extinction_spawn_table();
            return;
        }

        set_regular_extinction_spawn_table();
    }
}

set_container_spawn_table()
{
    if ( maps\mp\alien\_unk1464::_ID18426() )
        set_hardcore_container_spawn_table();
    else
        set_regular_container_spawn_table();
}

set_alien_definition_table()
{
    if ( maps\mp\alien\_unk1464::_ID18426() )
        set_hardcore_alien_definition_table();
    else
        set_regular_alien_definition_table();
}

set_chaos_spawn_table()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        switch ( maps\mp\alien\_unk1464::get_chaos_area() )
        {
            case "caverns_01":
                level.alien_cycle_table = "mp/alien/chaos_spawn_dlc3_caverns_01_sp.csv";
                break;
            case "caverns_02":
                level.alien_cycle_table = "mp/alien/chaos_spawn_dlc3_caverns_02_sp.csv";
                break;
            case "caverns_03":
                level.alien_cycle_table = "mp/alien/chaos_spawn_dlc3_caverns_03_sp.csv";
                break;
            case "caverns_04":
                level.alien_cycle_table = "mp/alien/chaos_spawn_dlc3_caverns_04_sp.csv";
                break;
        }
    }
    else
    {
        switch ( maps\mp\alien\_unk1464::get_chaos_area() )
        {
            case "caverns_01":
                level.alien_cycle_table = "mp/alien/chaos_spawn_dlc3_caverns_01_mp.csv";
                break;
            case "caverns_02":
                level.alien_cycle_table = "mp/alien/chaos_spawn_dlc3_caverns_02_mp.csv";
                break;
            case "caverns_03":
                level.alien_cycle_table = "mp/alien/chaos_spawn_dlc3_caverns_03_mp.csv";
                break;
            case "caverns_04":
                level.alien_cycle_table = "mp/alien/chaos_spawn_dlc3_caverns_04_mp.csv";
                break;
        }
    }
}

set_hardcore_extinction_spawn_table()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        level.alien_cycle_table_hardcore = "mp/alien/cycle_spawn_dlc3_hardcore_sp.csv";
    else
        level.alien_cycle_table_hardcore = "mp/alien/cycle_spawn_dlc3_hardcore_mp.csv";
}

set_regular_extinction_spawn_table()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        level.alien_cycle_table = "mp/alien/cycle_spawn_dlc3_sp.csv";
    else
        level.alien_cycle_table = "mp/alien/cycle_spawn_dlc3.csv";
}

set_hardcore_container_spawn_table()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        level._ID36993 = "mp/alien/dlc3_container_spawn_hardcore_sp.csv";
    else
        level._ID36993 = "mp/alien/dlc3_container_spawn_hardcore.csv";
}

set_regular_container_spawn_table()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        level._ID36993 = "mp/alien/dlc3_container_spawn_sp.csv";
    else
        level._ID36993 = "mp/alien/dlc3_container_spawn.csv";
}

set_regular_alien_definition_table()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        level._ID37075 = "mp/alien/dlc3_alien_definition_sp.csv";
    else
        level._ID37075 = "mp/alien/dlc3_alien_definition.csv";
}

set_hardcore_alien_definition_table()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        level._ID37075 = "mp/alien/dlc3_alien_definition_hardcore_sp.csv";
    else
        level._ID37075 = "mp/alien/dlc3_alien_definition_hardcore.csv";
}

check_bridge_hives_and_play_vo()
{
    if ( !isdefined( level.bridge_hives_done ) )
        level.bridge_hives_done = 0;

    level.bridge_hives_done++;

    if ( level.bridge_hives_done == 2 )
        level thread stop_post_drill_vo_from_playing_next_obelisk();

    if ( level.bridge_hives_done > 2 )
    {
        level turn_off_drill();
        level thread maps\mp\mp_alien_dlc3_vignettes::descent_vo_area_3_end();
        maps\mp\alien\_achievement_dlc3::update_progression_achievements( "extend_the_bridge" );
        wait 5;
        level thread add_waypoint_to_ark();
        level thread extend_bridge();
        level thread start_ark_vo();
        common_scripts\utility::flag_set( "area_3_done" );
    }
}

stop_post_drill_vo_from_playing_next_obelisk()
{
    wait 6;
    level.no_grab_drill_vo = 1;
}

extend_bridge()
{
    var_0 = getentarray( "bridge_section_2", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2 solid();
        var_2 show();
    }

    var_4 = getent( "ark_bridge_path_clip", "targetname" );
    var_4 connectpaths();
    var_4 notsolid();
    thread extend_bridge_fx();
    level slide_bridge( -640 );
    level notify( "dlc_vo_notify",  "descent_vo", "complete_bridge"  );
}

extend_bridge_fx()
{
    wait 0.1;
    var_0 = getent( "bridge_section_2_model", "targetname" );
    playfxontag( level._ID1644["bridge_tip"], var_0, "tag_bridge_tip" );
}

add_waypoint_to_ark()
{
    var_0 = newhudelem();
    var_0 setshader( "waypoint_alien_blocker", 20, 20 );
    var_0.color = ( 1, 1, 1 );
    var_0 setwaypoint( 1, 1 );
    var_0.sort = 1;
    var_0.foreground = 1;
    var_0.alpha = 0.5;
    var_0.x = 695;
    var_0.y = 1867;
    var_0.z = 1000;
    var_1 = 200;
    var_2 = var_1 * var_1;
    var_3 = 0;

    while ( !var_3 && !common_scripts\utility::_ID13177( "entering_ark_flag" ) )
    {
        foreach ( var_5 in level.players )
        {
            if ( distancesquared( ( var_0.x, var_0.y, var_0.z ), var_5.origin ) < var_2 )
                var_3 = 1;
        }

        wait 0.1;
    }

    var_0.x = 3824;
    var_0.y = 1857;
    var_0.z = 1000;
    var_1 = 200;
    var_2 = var_1 * var_1;
    var_3 = 0;

    while ( !var_3 )
    {
        foreach ( var_5 in level.players )
        {
            if ( distancesquared( ( var_0.x, var_0.y, var_0.z ), var_5.origin ) < var_2 )
                var_3 = 1;
        }

        wait 0.1;
    }

    var_0 destroy();
}

turn_off_drill()
{
    while ( !isdefined( level.drill_icon ) )
        wait 0.05;

    level.drill_use_trig makeunusable();
    maps\mp\alien\_outline_proto::remove_from_drill_preplant_watch_list( level.drill );
    maps\mp\alien\_drill::_ID9765();
}

destroy_drill( var_0 )
{
    wait(var_0);

    while ( !isdefined( level.drill ) )
        wait 0.1;

    if ( isdefined( level.drill ) )
    {
        level.drill_carrier = undefined;
        level.drill delete();
    }

    if ( isdefined( level.drill_icon ) )
        level.drill_icon destroy();

    if ( isdefined( level.drill_use_trig ) )
        level.drill_use_trig delete();
}

start_ark_vo()
{
    common_scripts\utility::flag_wait( "entering_ark_flag" );
    var_0 = 0;

    if ( !isdefined( level.ark_jump_to ) )
        maps\mp\mp_alien_dlc3_vignettes::descent_vo_entering_ark();

    while ( !var_0 )
    {
        foreach ( var_2 in level.players )
        {
            if ( var_2.origin[0] > 2000 )
                var_0 = 1;
        }

        wait 0.1;
    }

    common_scripts\utility::flag_set( "start_archer_vignette" );
}

hide_bridge_parts()
{
    var_0 = getentarray( "bridge_section_2", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2 notsolid();
        var_2 hide();
    }

    level thread slide_bridge( 640 );
}

slide_bridge( var_0 )
{
    var_1 = getent( "bridge_section_2_model", "targetname" );

    if ( isdefined( var_1 ) )
    {
        playsoundatpos( ( 59, 1891, 995 ), "scn_ark_bridge" );
        var_1 moveto( var_1.origin + ( var_0, 0, 0 ), 2.0, 0.1, 0.1 );
    }

    wait 2.0;
}

descent_specific_vo_callouts( var_0 )
{
    var_0["descent_vo"] = ::playdescentvo;
    var_0["warn_plants"] = ::playplantvo;
    var_0["descent_story_vo"] = ::playdescentstoryvo;
    return var_0;
}

playdescentvo( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_1 = maps\mp\alien\_unk1464::_ID14295();

    if ( var_1.size < 1 )
        return;

    var_2 = var_1[0];

    if ( !soundexists( var_2._ID35381 + var_0 ) )
    {
        iprintln( "descent vo: " + var_2._ID35381 + var_0 );
        return;
    }

    if ( var_0 == "escape_level" )
        wait 5;

    var_1 = maps\mp\alien\_unk1464::_ID14295();

    if ( var_1.size < 1 )
        return;

    var_2 = var_1[0];
    var_3 = var_2._ID35381 + var_0;
    var_2 _ID36641::_ID23864( var_3, undefined, 10 );
}

playplantvo( var_0 )
{
    var_1 = var_0._ID35381 + "warn_plants";
    var_0 _ID36641::_ID23864( var_1, undefined, 3 );
}

playdescentstoryvo( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( !soundexists( var_0 ) )
        return;

    thread maps\mp\alien\_music_and_dialog::pause_vo_system( level.players );
    wait 1;
    play_global_vo( var_0 );
    var_1 = lookupsoundlength( var_0 ) / 1000;
    wait(var_1 + 1);
    thread maps\mp\alien\_music_and_dialog::unpause_vo_system( level.players );
}

play_global_vo( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( isdefined( var_2 ) )
        {
            var_2 playsound( var_0 );
            break;
        }
    }
}

init_weapon_stat_array()
{
    level.weaponstats_weaponlist = [];
    level.weaponstats_weaponlist["iw6_arkalienr5rgp_mp"] = "iw6_alienDLC33_mp";
    level.weaponstats_weaponlist["iw6_arkaliendlc15_mp"] = "iw6_alienDLC15_mp";
    level.weaponstats_weaponlist["iw6_arkalienk7_mp"] = "iw6_alienDLC31_mp";
    level.weaponstats_weaponlist["iw6_arkaliendlc23_mp"] = "iw6_alienDLC23_mp";
    level.weaponstats_weaponlist["iw6_arkalienameli_mp"] = "iw6_alienDLC32_mp";
    level.weaponstats_weaponlist["iw6_arkalienkac_mp"] = "iw6_alienkac_mp";
    level.weaponstats_weaponlist["iw6_arkalienvks_mp"] = "iw6_alienvks_mp";
    level.weaponstats_weaponlist["iw6_arkalienusr_mp"] = "iw6_alienDLC34_mp";
    level.weaponstats_weaponlist["iw6_arkalienimbel_mp"] = "iw6_alienimbel_mp";
    level.weaponstats_weaponlist["iw6_arkalienmk14_mp"] = "iw6_alienDLC31_mp";
    level.weaponstats_weaponlist["iw6_arkalienmaul_mp"] = "iw6_alienmaul_mp";
    level.weaponstats_weaponlist["iw6_arkalienuts15_mp"] = "iw6_alienDLC24_mp";
}

descent_weapon_stats_override_func( var_0 )
{
    if ( isdefined( level.weaponstats_weaponlist[var_0] ) )
        return level.weaponstats_weaponlist[var_0];

    return var_0;
}

descent_locker_ark_check_func( var_0, var_1 )
{
    if ( maps\mp\alien\_unk1464::weapon_has_alien_attachment( var_0 ) )
    {
        var_2 = [ "alienmuzzlebrake" ];
        var_1 = maps\mp\alien\_unk1464::ark_attachment_transfer_to_locker_weapon( var_1, var_2, 1 );
    }

    return "weapon_" + var_1;
}

chaos_init()
{
    _ID36640::init_hive_locs();
    maps\mp\alien\_chaos::_ID17631();
    register_egg_default_loc();
    level thread init_attachment_and_crafting_locations();
    set_end_cam_position();
    dlc3_chaos_nondeterministic_entity_handler();
    level thread chaos_player_on_obelisk_monitor();
}

dlc3_chaos_nondeterministic_entity_handler()
{
    level endon( "game_ended" );
    var_0 = 5;
    wait(var_0);
    move_clip_to_bridge_chaos();
}

move_clip_to_bridge_chaos()
{
    var_0 = getent( "player512x512x8", "targetname" );
    var_1 = spawn( "script_model", ( -512, 1728, 1136 ) );
    var_1.angles = ( 270, 0, 0 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
    var_2 = getent( "player512x512x8", "targetname" );
    var_3 = spawn( "script_model", ( -385, 2201.5, 2160 ) );
    var_3.angles = ( 270, 330, 0 );
    var_3 clonebrushmodeltoscriptmodel( var_2 );
    var_4 = getent( "player512x512x8", "targetname" );
    var_5 = spawn( "script_model", ( -385, 2201.5, 1648 ) );
    var_5.angles = ( 270, 330, 0 );
    var_5 clonebrushmodeltoscriptmodel( var_4 );
    var_6 = getent( "player512x512x8", "targetname" );
    var_7 = spawn( "script_model", ( -512, 1728, 1648 ) );
    var_7.angles = ( 270, 0, 0 );
    var_7 clonebrushmodeltoscriptmodel( var_6 );
    var_8 = getent( "player512x512x8", "targetname" );
    var_9 = spawn( "script_model", ( -385, 2201.5, 1136 ) );
    var_9.angles = ( 270, 330, 0 );
    var_9 clonebrushmodeltoscriptmodel( var_8 );
    var_10 = getent( "player512x512x8", "targetname" );
    var_11 = spawn( "script_model", ( -512, 1728, 2160 ) );
    var_11.angles = ( 270, 0, 0 );
    var_11 clonebrushmodeltoscriptmodel( var_10 );
}

register_egg_default_loc()
{
    switch ( maps\mp\alien\_unk1464::get_chaos_area() )
    {
        case "caverns_01":
            maps\mp\alien\_chaos::set_egg_default_loc( ( -116, 2240, -1264 ) );
            break;
        case "caverns_03":
            maps\mp\alien\_chaos::set_egg_default_loc( ( -116, 2240, -1264 ) );
            break;
    }
}

set_end_cam_position()
{
    var_0 = getentarray( "mp_global_intermission", "classname" );
    var_1 = common_scripts\utility::_ID14934( level.eggs_default_loc, var_0 );

    switch ( maps\mp\alien\_unk1464::get_chaos_area() )
    {
        case "caverns_01":
            var_1.origin = ( -3608, 3024, 810 );
            var_1.angles = ( 350, 345, 0 );
            break;
        case "caverns_03":
            var_1.origin = ( -3608, 3024, 810 );
            var_1.angles = ( 350, 345, 0 );
            break;
    }
}

descent_player_initial_spawn_loc_override()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        chaos_player_initial_spawn_loc_override();
    else
        regular_player_initial_spawn_loc_override();
}

regular_player_initial_spawn_loc_override()
{
    if ( !isdefined( maps\mp\alien\_unk1464::get_player_initial_spawn_origin() ) )
        return;

    self._ID13535 = maps\mp\alien\_unk1464::get_player_initial_spawn_origin();
    self.forcespawnangles = maps\mp\alien\_unk1464::get_player_initial_spawn_angles();
}

chaos_player_initial_spawn_loc_override()
{
    var_0 = [];
    var_1 = [];

    switch ( maps\mp\alien\_unk1464::get_chaos_area() )
    {
        case "caverns_01":
            var_0 = [ ( 2556, -7380, 1202 ), ( 2432, -7436, 1202 ), ( 2282, -7444, 1202 ), ( 2138, -7400, 1202 ) ];
            var_1 = [ ( 0, 90, 0 ), ( 0, 90, 0 ), ( 0, 90, 0 ), ( 0, 90, 0 ) ];
            break;
        case "caverns_03":
            var_0 = [ ( -2936, -161, 1346 ), ( -3082, -158, 1356 ), ( -3111, -285, 1372 ), ( -2917, -283, 1372 ) ];
            var_1 = [ ( 0, 114, 0 ), ( 0, 55, 0 ), ( 0, 55, 0 ), ( 0, 102, 0 ) ];
            break;
    }

    self._ID13535 = var_0[level.players.size];
    self.forcespawnangles = var_1[level.players.size];
}

jump_to_area1_1st_obelisk()
{

}

jump_to_area1_2nd_obelisk()
{

}

jump_to_area1_3rd_obelisk()
{

}

jump_to_area1_4th_obelisk()
{

}

jump_to_area1_5th_obelisk()
{

}

common_jump_to_area1()
{

}

jump_to_area2_1st_obelisk()
{

}

jump_to_area2_2nd_obelisk()
{

}

jump_to_area2_3rd_obelisk()
{

}

jump_to_area2_4th_obelisk()
{

}

jump_to_area2_5th_obelisk()
{

}

common_jump_to_area2()
{

}

jump_to_bridge_1st_obelisk()
{

}

jump_to_bridge_2nd_obelisk()
{

}

jump_to_bridge_3rd_obelisk()
{

}

common_jump_to_area3()
{

}

get_first_num_elements( var_0, var_1 )
{
    var_2 = [];

    for ( var_3 = 0; var_3 < var_1; var_3++ )
        var_2[var_3] = var_0[var_3];

    return var_2;
}

_ID37529()
{
    self._ID33463 = "traps_puddle";
    return 1;
}

explodersasoneshot()
{
    wait 30;
    common_scripts\utility::exploder( 64 );
}

dlc3_egg()
{
    level.eggs_destroyed = 0;
    var_0 = getentarray( "easter_egg", "targetname" );
    var_1 = [];
    var_2 = [];
    var_3 = [];
    var_0 = common_scripts\utility::array_randomize( var_0 );

    foreach ( var_5 in var_0 )
    {
        if ( isdefined( var_5.script_noteworthy ) )
        {
            switch ( var_5.script_noteworthy )
            {
                case "area1":
                    if ( var_1.size >= 2 )
                        var_5 delete();
                    else
                        var_1[var_1.size] = var_5;

                    continue;
                case "area2":
                    if ( var_2.size >= 2 )
                        var_5 delete();
                    else
                        var_2[var_2.size] = var_5;

                    continue;
                case "area3":
                    if ( var_3.size >= 2 )
                        var_5 delete();
                    else
                        var_3[var_3.size] = var_5;

                    continue;
            }
        }
    }

    var_0 = getentarray( "easter_egg", "targetname" );

    foreach ( var_5 in var_0 )
        var_5 thread wait_for_egg_dmg();
}

wait_for_egg_dmg()
{
    level endon( "stop_easter_egg" );
    self setcandamage( 1 );
    self setcanradiusdamage( 1 );
    var_0 = self.origin;

    for (;;)
    {
        self waittill( "damage",  var_1, var_2, var_3, var_4, var_5  );
        playfx( level._ID1644["easter_egg_explode"], var_0 );
        earthquake( 0.12, 1, var_0, 10000 );
        self delete();
        level.eggs_destroyed++;

        if ( level.eggs_destroyed >= 4 )
        {
            foreach ( var_7 in level.players )
            {
                var_7 thread [[ level._ID8750 ]]( 180, 4, 1 );
                var_7 thread maps\mp\alien\_outline_proto::_ID28200();
                playfxontag( level.dig_fx["shrine"]["player"], var_7, "tag_origin" );
                var_7.shrine_effect_ent = spawnfxforclient( level.dig_fx["shrine"]["screen"], var_7 geteye(), var_7 );
                triggerfx( var_7.shrine_effect_ent );
                var_7.shrine_effect_ent setfxkilldefondelete();
                var_7 thread killfxonplayerdeath( var_7.shrine_effect_ent, "death", "disconnect" );
            }

            earthquake( 0.35, 4, var_0, 10000 );
            level._ID1644["arcade_death"] = level._ID1644["easter_egg_death"];
            level._ID11234 = 1;
            level thread dlc3_easter_egg_off();
            level thread delete_remaining_eggs();
            level notify( "stop_easter_egg" );
        }
    }
}

delete_remaining_eggs()
{
    var_0 = getentarray( "easter_egg", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2 ) )
            continue;

        playfx( level._ID1644["easter_egg_explode"], var_2.origin );
        var_2 delete();
        common_scripts\utility::_ID35582();
    }
}

dlc3_easter_egg_off()
{
    level endon( "game_ended" );
    wait 180;
    level._ID11234 = 0;

    foreach ( var_1 in level.players )
    {
        var_1 thread maps\mp\alien\_alien_class_skills_main::remove_the_outline();
        stopfxontag( level.dig_fx["shrine"]["player"], var_1, "tag_origin" );

        if ( isdefined( var_1.shrine_effect_ent ) )
            var_1.shrine_effect_ent delete();
    }
}

killfxonplayerdeath( var_0, var_1, var_2 )
{
    level endon( "game_ended" );

    if ( isdefined( var_1 ) )
        level endon( var_1 );

    if ( isdefined( var_2 ) )
        level endon( var_2 );

    common_scripts\utility::_ID35626( "last_stand", "disconnect" );

    if ( isdefined( var_0 ) )
    {
        if ( isarray( var_0 ) )
        {
            foreach ( var_4 in var_0 )
                var_4 delete();
        }
        else
            var_0 delete();
    }
}

dlc3_cangive_weapon_handler_func( var_0, var_1, var_2, var_3 )
{
    var_4 = 0;

    if ( self hasweapon( "aliensoflam_mp" ) )
        var_4++;

    if ( self.hasriotshield || self._ID16417 )
        var_4++;

    var_5 = self getcurrentweapon();
    var_6 = 0;

    if ( issubstr( var_5, "aliendlc11" ) )
        var_6 = 1;

    if ( var_6 && var_0.size + 1 > var_3 + var_4 )
        return 0;

    return 1;
}

dlc3_give_weapon_handler_func( var_0 )
{
    var_1 = self getcurrentweapon();

    if ( issubstr( var_1, "aliendlc11" ) )
        return 0;

    return undefined;
}

dlc_3_offset_locker_trigger_model()
{
    if ( isdefined( self._ID37635 ) )
        self.pillage_trigger.origin = self._ID37635;

    if ( isdefined( self._ID37622 ) )
        self.pillage_trigger.angles = self._ID37622;

    var_0 = ( 0, 0, 20 );
    var_1 = ( 0, 0, 13 );
    var_2 = ( 0, 0, 90 );
    var_3 = ( 0, 0, 6 );
    var_4 = ( 0, 0, 0 );
    var_5 = getgroundposition( self.pillage_trigger.origin + var_0, 2 );

    switch ( self.pillage_trigger.model )
    {
        case "weapon_rm_22":
            self.pillage_trigger hidepart( "tag_barrel_sniper", "weapon_rm_22" );
        default:
            var_3 = var_1;
            var_4 = var_2;
            break;
    }

    var_3 = var_1;
    var_4 = var_2;
    var_6 = self.pillage_trigger.origin;
    var_7 = self.pillage_trigger.angles;
    var_8 = self.pillage_trigger.origin;
    var_9 = ( 0, 0, 0 );
    var_10 = self.pillage_trigger.origin + var_3;
    var_11 = var_4;
    var_12 = transformmove( var_6, var_7, var_8, var_9, var_10, var_11 );
    var_13 = var_12["origin"] - var_5;
    var_4 = var_12["angles"];
    self.pillage_trigger.origin = var_5 + var_13;
    self.pillage_trigger.angles = var_4;
}
