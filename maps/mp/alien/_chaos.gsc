// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    init_grace_period_end_time();
    maps\mp\alien\_chaos_utility::init_highest_combo();
    maps\mp\alien\_chaos_utility::init_bonus_package_cap();
    maps\mp\alien\_chaos_utility::init_chaos_score_components();
    maps\mp\alien\_chaos_utility::init_combo_duration();
    init_num_skill_upgrade_earned();
    maps\mp\alien\_chaos_utility::init_event_counts();
    maps\mp\alien\_chaos_utility::register_chaos_events();
    register_perk_progression();
    register_bonus_packages();
    maps\mp\alien\_chaos_utility::register_cycle_duration();
    maps\mp\alien\_chaos_utility::register_combo_duration_schedule();
    maps\mp\alien\_chaos_utility::register_pre_end_game_display_func();
    maps\mp\alien\_chaos_utility::reset_alien_kill_streak();
    load_vfx();
    maps\mp\alien\_chaos_utility::add_extra_spawn_locations();
    common_scripts\utility::_ID13189( "combo_freeze" );
    common_scripts\utility::_ID13189( "grace_period_over" );
    common_scripts\utility::_ID13189( "combo_is_alive" );
    common_scripts\utility::_ID13189( "in_host_migration" );
    common_scripts\utility::_ID13189( "chaos_pre_game_is_over" );
    maps\mp\alien\_hud::chaos_hud_init();
    level.chaos_event_queue = [];
    level thread lua_omnvar_update_monitor( level, "ui_chaos_perk" );
    level thread lua_omnvar_update_monitor( level, "ui_chaos_event" );
    level thread process_event_notify_queue();
}

load_vfx()
{
    level._ID1644["chaos_pre_bonus_drop"] = loadfx( "vfx/_requests/chaos/vfx_chaos_prebonus_drop" );
}

set_chaos_area()
{
    level.chaos_area = get_level_specific_chaos_area();
}

get_level_specific_chaos_area()
{
    switch ( level.script )
    {
        case "mp_alien_town":
            return "cabin";
        case "mp_alien_armory":
            return "compound";
        case "mp_alien_beacon":
            return "cargo";
        case "mp_alien_dlc3":
            return "caverns_03";
        case "mp_alien_last":
            return "main_base";
    }
}

chaos()
{
    level endon( "game_ended" );
    level thread chaos_host_migration_handler();
    level thread combo_meter_monitor();
    wait 10;
    level thread hot_join_grace_period_monitor();
    level thread bonus_package_drop_monitor();
    level thread start_grace_period( 120 );
    level thread chaos_cycle_spawn_monitor();
    level thread apply_delta_to_combo_duration();
}

update_alien_killed_event( var_0, var_1, var_2 )
{
    if ( !maps\mp\alien\_chaos_utility::should_process_alien_killed_event( var_2 ) )
        return;

    var_3 = maps\mp\alien\_chaos_utility::get_attacker_as_player( var_2 );

    if ( maps\mp\alien\_chaos_laststand::should_instant_revive( var_3 ) )
        maps\mp\alien\_laststand::instant_revive( var_3 );

    process_chaos_event( "kill_" + var_0 );
    drop_alien_egg( var_1 );
    level thread alien_kill_streak_monitor();
}

update_alien_damaged_event( var_0 )
{
    if ( !maps\mp\alien\_chaos_utility::should_process_alien_damaged_event( var_0 ) )
        return;

    process_chaos_event( "refill_combo_meter" );
}

update_spending_currency_event( var_0, var_1, var_2 )
{
    if ( !maps\mp\alien\_unk1464::is_chaos_mode() )
        return;

    if ( !isdefined( var_1 ) )
        return;

    if ( var_1 == "weapon" && is_new_weapon_pick_up( var_0, var_2 ) )
        process_chaos_event( "new_weapon_pick_up" );
    else
        process_chaos_event( "inc_combo_counter_only" );
}

update_pickup_deployable_box_event()
{
    process_chaos_event( "deployable_pick_up" );
}

process_chaos_event( var_0 )
{
    if ( !maps\mp\alien\_unk1464::is_chaos_mode() )
        return;

    var_1 = level.chaos_events[var_0];
    process_chaos_event_internal( var_1 );
}

update_weapon_pickup( var_0, var_1 )
{
    add_to_weapon_picked_up_list( var_0, var_1 );
    add_to_recent_weapon_list( var_0, var_1 );
}

chaos_onplayerconnect( var_0 )
{
    var_0.weapon_picked_up = [];
    var_0.recent_weapon_list = [];
    var_0 maps\mp\alien\_chaos_laststand::set_in_chaos_self_revive( var_0, 0 );
}

chaos_onspawnplayer( var_0 )
{
    var_0 maps\mp\alien\_damage::_ID28656( level._ID9659 );
    var_0 notify( "enable_armor" );
    var_0.objectivescaler = 10;
    var_0 thread refill_pistol_ammo();
    var_0 give_skill_upgrade_earned( var_0 );
}

chaos_custom_giveloadout( var_0 )
{
    var_0 maps\mp\alien\_chaos_utility::give_activated_perks( var_0 );

    if ( !common_scripts\utility::_ID13177( "chaos_pre_game_is_over" ) )
        var_0 give_start_up_semtex( var_0 );
}

give_start_up_semtex( var_0 )
{
    var_0 setoffhandprimaryclass( "other" );
    var_0 maps\mp\_utility::_giveweapon( "aliensemtex_mp" );
    var_0 setweaponammostock( "aliensemtex_mp", 5 );
}

create_alien_eggs()
{
    level.alien_egg_list = [];
    level.alien_egg_list_index = 0;

    for ( var_0 = 0; var_0 < 20; var_0++ )
        level.alien_egg_list[var_0] = create_alien_egg();
}

set_egg_default_loc( var_0 )
{
    level.eggs_default_loc = var_0;
}

is_new_weapon_pick_up( var_0, var_1 )
{
    return !common_scripts\utility::array_contains( var_0.weapon_picked_up, var_1 );
}

is_weapon_recently_picked_up( var_0, var_1 )
{
    return common_scripts\utility::array_contains( var_0.recent_weapon_list, var_1 );
}

combo_meter_monitor()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "refill_combo_meter" );

        for (;;)
        {
            var_0 = maps\mp\alien\_chaos_utility::get_combo_duration() * 1.1;
            var_1 = level common_scripts\utility::_ID35637( var_0, "refill_combo_meter" );

            if ( var_1 == "timeout" && !common_scripts\utility::_ID13177( "combo_freeze" ) && !common_scripts\utility::_ID13177( "in_host_migration" ) )
            {
                maps\mp\alien\_chaos_utility::keep_running_score();
                drop_combo();

                if ( common_scripts\utility::_ID13177( "grace_period_over" ) )
                    maps\mp\alien\_chaos_utility::chaos_end_game();

                break;
            }
        }
    }
}

alien_kill_streak_monitor()
{
    level notify( "alien_kill_streak" );
    level endon( "alien_kill_streak" );
    var_0 = 0.2;
    maps\mp\alien\_chaos_utility::inc_alien_kill_streak();
    wait(var_0);
    process_alien_kill_streak( maps\mp\alien\_chaos_utility::get_alien_kill_streak() );
    maps\mp\alien\_chaos_utility::reset_alien_kill_streak();
}

process_alien_kill_streak( var_0 )
{
    if ( var_0 < 2 )
        return;

    switch ( var_0 )
    {
        case 2:
            process_chaos_event( "double_kill" );
            break;
        case 3:
            process_chaos_event( "triple_kill" );
            break;
        case 4:
            process_chaos_event( "quad_kill" );
            break;
        default:
            process_chaos_event( "mega_kill" );
            break;
    }
}

bonus_package_drop_monitor()
{
    level endon( "game_ended" );

    foreach ( var_1 in level.chaos_bonus_progression )
    {
        wait(var_1["wait_duration"]);
        level thread drop_bonus_packages( var_1 );
    }
}

drop_bonus_packages( var_0 )
{
    level endon( "game_ended" );
    var_1 = cap_num_of_drops( var_0["num_of_drops"] );

    if ( var_1 == 0 )
        return;

    var_2 = get_bonus_items_list( var_0, var_1 );
    var_3 = get_drop_locations( var_1 );

    for ( var_4 = 0; var_4 < var_1; var_4++ )
    {
        level thread drop_bonus_package( var_2[var_4], var_3[var_4] );
        common_scripts\utility::_ID35582();
    }
}

cap_num_of_drops( var_0 )
{
    var_1 = maps\mp\alien\_chaos_utility::get_current_num_bonus_package();
    var_2 = maps\mp\alien\_chaos_utility::get_bonus_package_cap();
    return min( var_0, var_2 - var_1 );
}

chaos_cycle_spawn_monitor()
{
    level endon( "game_ended" );

    foreach ( var_1 in level.chaos_cycle_duration )
    {
        level thread maps\mp\alien\_spawnlogic::_ID37163();
        wait(var_1);
        maps\mp\alien\_spawn_director::_ID11539();
        common_scripts\utility::_ID35582();
    }
}

apply_delta_to_combo_duration()
{
    level endon( "game_ended" );

    foreach ( var_1 in level.combo_duration_schedule )
    {
        wait(var_1["pre_delta_interval"]);
        maps\mp\alien\_chaos_utility::adjust_combo_duration( var_1["delta"] );
    }
}

chaos_host_migration_handler()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "host_migration_begin" );
        common_scripts\utility::flag_set( "in_host_migration" );
        level waittill( "host_migration_end" );
        common_scripts\utility::_ID13180( "in_host_migration" );
        refill_combo_meter();
    }
}

hot_join_grace_period_monitor()
{
    level endon( "game_ended" );
    wait 30;
    common_scripts\utility::flag_set( "chaos_pre_game_is_over" );
}

process_chaos_event_internal( var_0 )
{
    refill_combo_meter();
    var_1 = should_inc_combo_counter( var_0["combo_inc"] );
    var_2 = should_inc_score_streak( var_0["score_inc"] );

    if ( var_1 )
        inc_combo_counter( var_0["combo_inc"] );

    if ( should_update_lua_event( var_0["LUA_event_ID"] ) )
    {
        maps\mp\alien\_chaos_utility::inc_event_count( var_0["LUA_event_ID"] );
        add_to_omnvar_value_queue( level, "ui_chaos_event", var_0["LUA_event_ID"] );
    }

    if ( var_2 )
        inc_score_streak( var_0["score_inc"] );

    if ( var_1 || var_2 )
    {
        var_3 = maps\mp\alien\_chaos_utility::calculate_total_score();

        foreach ( var_5 in level.players )
            var_5 maps\mp\alien\_persistence::eog_player_update_stat( "score", var_3, 1 );
    }
}

inc_combo_counter( var_0 )
{
    maps\mp\alien\_chaos_utility::add_combo_counter( var_0 );
    var_1 = maps\mp\alien\_chaos_utility::get_combo_counter();
    perk_progression( var_1 );
    maps\mp\alien\_hud::set_combo_counter( var_1 );
    maps\mp\alien\_chaos_utility::record_highest_combo( var_1 );
}

inc_score_streak( var_0 )
{
    maps\mp\alien\_chaos_utility::add_score_streak( var_0 );
    var_1 = maps\mp\alien\_chaos_utility::get_score_streak();
    maps\mp\alien\_hud::set_score_streak( var_1 );
}

should_inc_combo_counter( var_0 )
{
    return var_0 > 0;
}

should_inc_score_streak( var_0 )
{
    return var_0 > 0;
}

should_update_lua_event( var_0 )
{
    return var_0 > 0;
}

pop_first_item_out_of_queue( var_0, var_1 )
{
    var_2 = var_0.omnvar_value_queue[var_1][0];

    if ( isdefined( var_2 ) )
    {
        var_3 = [];

        for ( var_4 = 1; var_4 < var_0.omnvar_value_queue[var_1].size; var_4++ )
            var_3[var_3.size] = var_0.omnvar_value_queue[var_1][var_4];

        var_0.omnvar_value_queue[var_1] = var_3;
    }

    return var_2;
}

lua_omnvar_update_monitor( var_0, var_1, var_2 )
{
    level endon( "game_ended" );

    if ( isdefined( var_2 ) )
        var_0 endon( var_2 );

    var_0.omnvar_value_queue[var_1] = [];

    for (;;)
    {
        var_3 = pop_first_item_out_of_queue( var_0, var_1 );

        if ( isdefined( var_3 ) )
        {
            chaos_event_notify( var_1, var_3, var_0 );

            if ( isplayer( var_0 ) )
                var_0 setclientomnvar( var_1, var_3 );
            else
                setomnvar( var_1, var_3 );

            common_scripts\utility::_ID35582();
            continue;
        }

        var_0 waittill( "update_" + var_1 );
    }
}

chaos_event_notify( var_0, var_1, var_2 )
{
    switch ( var_0 )
    {
        case "ui_chaos_perk":
        case "ui_chaos_event":
            var_3 = get_chaos_event_notify_string( var_0, var_1 );

            if ( isdefined( var_3 ) )
            {
                add_to_event_notify_queue( var_0, var_1, var_2, var_3 );
                return;
            }
    }
}

get_chaos_event_notify_string( var_0, var_1 )
{
    if ( var_0 == "ui_chaos_perk" )
    {
        switch ( var_1 )
        {
            case 1:
                return &"ALIEN_CHAOS_PERK_QUICKDRAW";
            case 2:
                return &"ALIEN_CHAOS_PERK_STRONGER_MELEE";
            case 3:
                return &"ALIEN_CHAOS_PERK_TRAP_MASTER";
            case 4:
                return &"ALIEN_CHAOS_PERK_GAS_MASK";
            case 5:
                return &"ALIEN_CHAOS_PERK_FASTRELOAD";
            case 6:
                return &"ALIEN_CHAOS_PERK_BULLET_DAMAGE_1";
            case 7:
                return &"ALIEN_CHAOS_PERK_STEADY_AIM";
            case 8:
                return &"ALIEN_CHAOS_PERK_STALKER";
            case 9:
                return &"ALIEN_CHAOS_PERK_QUICK_REVIVE";
            case 10:
                return &"ALIEN_CHAOS_PERK_FAST_REGEN";
            case 11:
                return &"ALIEN_CHAOS_PERK_MARATHON";
            case 12:
                return &"ALIEN_CHAOS_PERK_MORE_CASH";
            case 13:
                return &"ALIEN_CHAOS_PERK_BULLET_DAMAGE_2";
            case 14:
                return &"ALIEN_CHAOS_PERK_AGILITY";
            case 15:
                return &"ALIEN_CHAOS_PERK_MORE_HEALTH";
            case 16:
                return &"ALIEN_CHAOS_PERK_FERAL_VISION";
        }
    }
    else
    {
        switch ( var_1 )
        {
            case 2:
                return &"ALIEN_CHAOS_MEGA_KILL";
            case 3:
                return &"ALIEN_CHAOS_QUAD_KILL";
            case 5:
                return &"ALIEN_CHAOS_TRIPLE_KILL";
            case 10:
                return &"ALIEN_CHAOS_DOUBLE_KILL";
        }
    }
}

add_to_event_notify_queue( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4.name = var_0;
    var_4._ID34844 = var_1;
    var_4._ID12095 = var_2;
    var_4.event_string = var_3;
    var_4.time_added = gettime();
    level.chaos_event_queue[level.chaos_event_queue.size] = var_4;
}

process_event_notify_queue()
{
    level endon( "game_ended" );

    for (;;)
    {
        if ( level.chaos_event_queue.size > 0 )
        {
            var_0 = level.chaos_event_queue[0];
            level.chaos_event_queue = common_scripts\utility::array_remove( level.chaos_event_queue, var_0 );

            if ( gettime() - var_0.time_added > 5000 )
                continue;

            if ( isplayer( var_0._ID12095 ) )
                var_0._ID12095 iprintlnbold( var_0.event_string );
            else
                iprintlnbold( var_0.event_string );

            wait 2;
        }

        wait 0.1;
    }
}

add_to_omnvar_value_queue( var_0, var_1, var_2 )
{
    var_0.omnvar_value_queue[var_1][var_0.omnvar_value_queue[var_1].size] = var_2;
    var_0 notify( "update_" + var_1 );
}

create_alien_egg()
{
    var_0 = 32;
    var_1 = 76;
    var_2 = level.eggs_default_loc;
    var_3 = spawn( "script_model", var_2 );
    var_3 setmodel( "alien_spider_egg_ammo" );
    var_4 = spawn( "trigger_radius", var_2, 0, var_0, var_1 );
    var_4 enablelinkto();
    var_4 linkto( var_3 );
    var_3.trigger = var_4;
    var_3 thread egg_pick_up_monitor( var_3 );
    var_3 thread alien_egg_think( var_3 );
    return var_3;
}

alien_egg_think( var_0 )
{
    var_1 = "none";

    for (;;)
    {
        if ( var_1 != "activate" )
            var_0 waittill( "activate" );

        var_1 = var_0 common_scripts\utility::_ID35637( 30, "picked_up", "activate" );

        if ( var_1 == "picked_up" )
            process_chaos_event( "inc_combo_counter_only" );

        if ( var_1 != "activate" )
            move_alien_egg( var_0, level.eggs_default_loc );
    }
}

drop_alien_egg( var_0 )
{
    var_1 = ( 0, 0, 10 );
    var_2 = get_egg_from_list();
    move_alien_egg( var_2, var_0 + var_1 );
    var_2 notify( "activate" );
}

get_egg_from_list()
{
    var_0 = level.alien_egg_list[level.alien_egg_list_index];
    level.alien_egg_list_index = ( level.alien_egg_list_index + 1 ) % 20;
    return var_0;
}

refill_combo_meter()
{
    level notify( "refill_combo_meter" );
    maps\mp\alien\_hud::reset_combo_meter( maps\mp\alien\_chaos_utility::get_combo_duration() );
    common_scripts\utility::flag_set( "combo_is_alive" );
}

drop_combo()
{
    maps\mp\alien\_chaos_utility::reset_combo_counter();
    maps\mp\alien\_hud::set_combo_counter( 0 );
    unset_players_perks();
    common_scripts\utility::_ID13180( "combo_is_alive" );
}

egg_pick_up_monitor( var_0 )
{
    for (;;)
    {
        var_0.trigger waittill( "trigger",  var_1  );

        if ( isplayer( var_1 ) )
        {
            var_0 notify( "picked_up" );
            var_1 playlocalsound( "ball_drone_targeting" );
        }

        common_scripts\utility::_ID35582();
    }
}

move_alien_egg( var_0, var_1 )
{
    var_0 dontinterpolate();
    var_0.origin = var_1;
}

perk_progression( var_0 )
{
    if ( !isdefined( level.perk_progression[var_0] ) )
        return;

    level.perk_progression[var_0]["is_activated"] = 1;
    var_1 = level.perk_progression[var_0];
    add_to_omnvar_value_queue( level, "ui_chaos_perk", var_1["LUA_perk_ID"] );

    foreach ( var_3 in level.players )
        [[ var_1["activate_func"] ]]( var_3, var_1["perk_ref"] );
}

unset_players_perks()
{
    foreach ( var_1 in level.players )
        maps\mp\alien\_chaos_utility::unset_player_perks( var_1 );

    maps\mp\alien\_chaos_utility::set_all_perks_inactivated();
    add_to_omnvar_value_queue( level, "ui_chaos_perk", 0 );
}

swap_weapon_items( var_0 )
{
    var_0 = remove_weapon_item( var_0 );
    var_0 = maps\mp\alien\_chaos_utility::add_chaos_weapon( var_0 );
    return var_0;
}

remove_weapon_item( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( maps\mp\alien\_collectibles::_ID18380( var_3.script_noteworthy ) )
            continue;

        var_1[var_1.size] = var_3;
    }

    return var_1;
}

add_to_weapon_picked_up_list( var_0, var_1 )
{
    if ( common_scripts\utility::array_contains( var_0.weapon_picked_up, var_1 ) )
        return;

    var_0.weapon_picked_up[var_0.weapon_picked_up.size] = var_1;
}

add_to_recent_weapon_list( var_0, var_1 )
{
    if ( var_0.recent_weapon_list.size < 3 )
        var_0.recent_weapon_list[var_0.recent_weapon_list.size] = var_1;
    else
    {
        for ( var_2 = 0; var_2 < 2; var_2++ )
            var_0.recent_weapon_list[var_2] = var_0.recent_weapon_list[var_2 + 1];

        var_0.recent_weapon_list[2] = var_1;
    }
}

give_skill_upgrade_earned( var_0 )
{
    var_1 = get_num_skill_upgrade_earned();

    foreach ( var_3 in [ "defense", "offense" ] )
    {
        var_0 maps\mp\alien\_persistence::_ID28599( var_3, var_1 );
        var_0 maps\mp\alien\_persistence::_ID34467( "upgrade", get_resource_ref( var_0, var_3 ), var_1 );
    }
}

get_resource_ref( var_0, var_1 )
{
    return level.alien_combat_resources[var_1][self getcoopplayerdata( "alienPlayerLoadout", var_1 )]._ID25633;
}

register_perk_progression()
{
    level.perk_progression = [];
    maps\mp\alien\_chaos_utility::register_perk( "specialty_marathon", ::give_perk, ::take_perk );
    maps\mp\alien\_chaos_utility::register_perk( "fast_hands", ::give_hand_perks, ::take_hand_perks );
    maps\mp\alien\_chaos_utility::register_perk( "specialty_fastreload", ::give_perk, ::take_perk );
    maps\mp\alien\_chaos_utility::register_perk( "specialty_stalker", ::give_perk, ::take_perk );
    maps\mp\alien\_chaos_utility::register_perk( "fast_movement_speed", ::give_speed, ::take_speed );
    maps\mp\alien\_chaos_utility::register_perk( "gas_mask", ::give_gas_mask, ::take_gas_mask );
    maps\mp\alien\_chaos_utility::register_perk( "revive_protection", ::give_revive_protection, ::take_revive_protection );
    maps\mp\alien\_chaos_utility::register_perk( "steady_aim", ::give_steady_aim, ::take_steady_aim );
    maps\mp\alien\_chaos_utility::register_perk( "more_health", ::give_more_health, ::take_more_health );
    maps\mp\alien\_chaos_utility::register_perk( "stronger_melee", ::give_stronger_melee, ::take_stronger_melee );
    maps\mp\alien\_chaos_utility::register_perk( "bullet_damage_1", ::give_bullet_damage_1, ::take_bullet_damage_1 );
    maps\mp\alien\_chaos_utility::register_perk( "bullet_damage_2", ::give_bullet_damage_2, ::take_bullet_damage_2 );
    maps\mp\alien\_chaos_utility::register_perk( "fast_health_regen", ::give_fast_health_regen, ::take_fast_health_regen );
    maps\mp\alien\_chaos_utility::register_perk( "more_cash", ::give_more_cash, ::take_more_cash );
    maps\mp\alien\_chaos_utility::register_perk( "better_traps", ::give_trap_damage, ::take_trap_damage );
    maps\mp\alien\_chaos_utility::register_perk( "feral_vision", ::give_feral_vision, ::take_feral_vision );
}

give_perk( var_0, var_1 )
{
    var_0 maps\mp\_utility::_ID15611( var_1, 0 );
}

take_perk( var_0, var_1 )
{
    var_0 maps\mp\_utility::_unsetperk( var_1 );
}

give_speed( var_0, var_1 )
{
    var_0._ID21667 = 1.3;
}

take_speed( var_0, var_1 )
{
    var_0._ID21667 = 1.0;
}

give_gas_mask( var_0, var_1 )
{
    var_0._ID23425["medic"]._ID14145 = 0;
}

take_gas_mask( var_0, var_1 )
{
    var_0._ID23425["medic"]._ID14145 = 1.0;
}

give_hand_perks( var_0, var_1 )
{
    var_0 maps\mp\_utility::_ID15611( "specialty_quickdraw", 0 );
    var_0 maps\mp\_utility::_ID15611( "specialty_quickswap", 0 );
    var_0 maps\mp\_utility::_ID15611( "specialty_fastoffhand", 0 );
    var_0 maps\mp\_utility::_ID15611( "specialty_fastsprintrecovery", 0 );
}

take_hand_perks( var_0, var_1 )
{
    var_0 maps\mp\_utility::_unsetperk( "specialty_quickdraw" );
    var_0 maps\mp\_utility::_unsetperk( "specialty_quickswap" );
    var_0 maps\mp\_utility::_unsetperk( "specialty_fastoffhand" );
    var_0 maps\mp\_utility::_unsetperk( "specialty_fastsprintrecovery" );
}

give_revive_protection( var_0, var_1 )
{
    var_0._ID23425["medic"]._ID26261 = 1.5;
    var_0._ID23425["medic"]._ID26259 = 0.5;
}

take_revive_protection( var_0, var_1 )
{
    var_0._ID23425["medic"]._ID26261 = 1.0;
    var_0._ID23425["medic"]._ID26259 = 1.0;
}

give_steady_aim( var_0, var_1 )
{
    var_0 setaimspreadmovementscale( 0.5 );
}

take_steady_aim( var_0, var_1 )
{
    var_0 setaimspreadmovementscale( 1.0 );
}

give_more_health( var_0, var_1 )
{
    var_0._ID23425["health"]._ID20697 = 200;
    var_0.maxhealth = var_0._ID23425["health"]._ID20697;
    var_0 notify( "health_perk_upgrade" );
}

take_more_health( var_0, var_1 )
{
    var_0._ID23425["health"]._ID20697 = 100;
    var_0.maxhealth = var_0._ID23425["health"]._ID20697;
    var_0 notify( "health_perk_upgrade" );
}

give_stronger_melee( var_0, var_1 )
{
    var_0._ID23425["health"].melee_scalar = 3.0;
}

take_stronger_melee( var_0, var_1 )
{
    var_0._ID23425["health"].melee_scalar = 1.0;
}

give_bullet_damage_1( var_0, var_1 )
{
    var_0._ID23425["damagemod"].bullet_damage_scalar = 1.2;
}

take_bullet_damage_1( var_0, var_1 )
{
    var_0._ID23425["damagemod"].bullet_damage_scalar = 1.0;
}

give_bullet_damage_2( var_0, var_1 )
{
    var_0._ID23425["damagemod"].bullet_damage_scalar = 1.5;
}

take_bullet_damage_2( var_0, var_1 )
{
    var_0._ID23425["damagemod"].bullet_damage_scalar = 1.0;
}

give_fast_health_regen( var_0, var_1 )
{
    var_0._ID18643 = 1;
}

take_fast_health_regen( var_0, var_1 )
{
    var_0._ID18643 = undefined;
}

give_more_cash( var_0, var_1 )
{
    var_0 maps\mp\alien\_persistence::_ID28532( 8000 );
    var_0.chaosinthemoney = 1;
}

take_more_cash( var_0, var_1 )
{
    var_0 maps\mp\alien\_persistence::_ID28532( 6000 );
    var_0.chaosinthemoney = undefined;
}

give_trap_damage( var_0, var_1 )
{
    var_0._ID23425["rigger"]._ID33409 = 0.8;
    var_0._ID23425["rigger"]._ID33413 = 1.5;
    var_0._ID23425["rigger"].trap_damage_scalar = 2.0;
}

take_trap_damage( var_0, var_1 )
{
    var_0._ID23425["rigger"]._ID33409 = 1.0;
    var_0._ID23425["rigger"]._ID33413 = 1.0;
    var_0._ID23425["rigger"].trap_damage_scalar = 1.0;
}

give_feral_vision( var_0, var_1 )
{
    var_0 thread maps\mp\alien\_outline_proto::_ID28200();
    var_0.isferal = 1;
}

take_feral_vision( var_0, var_1 )
{
    var_0 thread maps\mp\alien\_outline_proto::_ID34257();
    var_0.isferal = undefined;
    var_0 notify( "unset_adrenaline" );
}

register_bonus_packages()
{
    maps\mp\alien\_chaos_utility::register_drop_locations();
    maps\mp\alien\_chaos_utility::register_bonus_progression();
    register_package_types();
}

get_drop_locations( var_0 )
{
    var_1 = [];
    var_2 = maps\mp\alien\_chaos_utility::get_random_player();
    var_3 = var_2 getplayerangles();
    var_4 = 360 / var_0;

    for ( var_5 = 0; var_5 < var_0; var_5++ )
    {
        var_6 = anglestoforward( ( 0, var_5 * var_4, 0 ) );
        var_7 = rotatevector( var_6, var_3 );
        var_7 *= ( 1, 1, 0 );
        var_7 = vectornormalize( var_7 );
        var_1[var_1.size] = maps\mp\alien\_chaos_utility::get_drop_location_rated( var_7, var_2.origin );
    }

    return var_1;
}

get_bonus_items_list( var_0, var_1 )
{
    var_2 = [];
    var_3 = maps\mp\alien\_unk1464::getmultiplerandomindex( var_0["package_group_chance"], var_1 );

    foreach ( var_9, var_5 in var_3 )
    {
        var_6 = strtok( var_0["package_group_type"][var_5], "-" );
        var_7 = maps\mp\alien\_chaos_utility::convert_array_to_int( strtok( var_0["item_chance"][var_5], "-" ) );
        var_8 = maps\mp\alien\_unk1464::getrandomindex( var_7 );
        var_2[var_2.size] = var_6[var_8];
    }

    return var_2;
}

register_package_types()
{
    maps\mp\alien\_chaos_utility::init_chaos_bonus_package_type();
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "combo_freeze", "alien_dpad_icon_freeze", ::give_combo_freeze );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "skill_upgrade", "alien_chaos_waypoint_skill", ::upgrade_all_skills );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "grace_period", "alien_chaos_waypoint_time", ::give_grace_period );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "bonus_score", "alien_chaos_waypoint_score", ::give_bonus_score );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "bonus_cash", "alien_dpad_icon_team_money", ::give_bonus_cash );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "trophy", "alien_chaos_waypoint_gift", ::give_trophy );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "flare", "alien_chaos_waypoint_gift", ::give_flare );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "pet_leash", "alien_chaos_waypoint_gift", ::give_pet_leash );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "soflam", "alien_chaos_waypoint_gift", ::give_soflam );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "self_revive", "alien_icon_laststand", ::give_self_revive );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "specialist_skill", "hud_alien_ammo_infinite", ::give_specalist_class_skill );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "tank_skill", "alien_dpad_icon_tank", ::give_tank_class_skill );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "engineer_skill", "alien_dpad_icon_engineer", ::give_engineer_class_skill );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "medic_skill", "alien_dpad_icon_medic", ::give_medic_class_skill );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "venom_x", "alien_chaos_waypoint_venomx", ::give_venom_x );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "venom_fire", "alien_chaos_waypoint_venomx", ::give_venom_fire );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "venom_lightning", "alien_chaos_waypoint_venomx", ::give_venom_lightning );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "tesla_trap", "alien_chaos_waypoint_tesla", ::give_tesla_trap );
    maps\mp\alien\_chaos_utility::init_chaos_deployable( "hypno_trap", "alien_chaos_waypoint_hypno", ::give_hypno_trap );
    add_special_ammo_dox_as_bonus_package();
}

add_special_ammo_dox_as_bonus_package()
{
    maps\mp\alien\_chaos_utility::add_to_chaos_bonus_package_type( "deployable_specialammo" );
    maps\mp\alien\_chaos_utility::add_to_chaos_bonus_package_type( "deployable_specialammo_in" );
    maps\mp\alien\_chaos_utility::add_to_chaos_bonus_package_type( "deployable_specialammo_explo" );
    maps\mp\alien\_chaos_utility::add_to_chaos_bonus_package_type( "deployable_specialammo_ap" );
}

drop_bonus_package( var_0, var_1 )
{
    var_2 = 0.3;
    var_3 = maps\mp\alien\_chaos_utility::get_random_player();
    var_4 = maps\mp\alien\_chaos_utility::play_fx_on_package( var_1, var_3.angles );
    wait(var_2);
    var_5 = maps\mp\alien\_deployablebox::_ID8395( var_0, var_1, var_3 );
    var_5.air_dropped = 1;
    var_5 maps\mp\alien\_deployablebox::box_setactive( 1 );
    var_4 thread maps\mp\alien\_chaos_utility::clean_up_monitor( var_4, var_5 );
}

give_tesla_trap( var_0 )
{
    if ( isdefined( level.tesla_trap_func ) )
        self thread [[ level.tesla_trap_func ]]( "amolecular_nucleicbattery_wire" );
}

give_hypno_trap( var_0 )
{
    if ( isdefined( level.hypno_trap_func ) )
        self thread [[ level.hypno_trap_func ]]( "biolum_cellbattery_pressureplate" );
}

give_venom_x( var_0 )
{
    var_1 = spawnstruct();
    var_1.item_ref = "weapon_iw6_aliendlc11_mp";
    var_1.data = [];
    var_1.data["cost"] = 0;
    remove_special_weapon();
    maps\mp\alien\_collectibles::_ID15575( var_1 );
}

give_venom_fire( var_0 )
{
    var_1 = spawnstruct();
    var_1.item_ref = "weapon_iw6_aliendlc11fi_mp";
    var_1.data = [];
    var_1.data["cost"] = 0;
    remove_special_weapon();
    maps\mp\alien\_collectibles::_ID15575( var_1 );
}

give_venom_lightning( var_0 )
{
    var_1 = spawnstruct();
    var_1.item_ref = "weapon_iw6_aliendlc11li_mp";
    var_1.data = [];
    var_1.data["cost"] = 0;
    remove_special_weapon();
    maps\mp\alien\_collectibles::_ID15575( var_1 );
}

remove_special_weapon()
{
    var_0 = self getcurrentprimaryweapon();

    switch ( var_0 )
    {
        case "iw6_alienminigun_mp":
        case "iw6_alienminigun1_mp":
        case "iw6_alienminigun2_mp":
        case "iw6_alienminigun3_mp":
        case "iw6_alienminigun4_mp":
        case "iw6_alienmk32_mp":
        case "iw6_alienmk321_mp":
        case "iw6_alienmk322_mp":
        case "iw6_alienmk323_mp":
        case "iw6_alienmk324_mp":
        case "iw6_alienmaaws_mp":
            self takeweapon( var_0 );
            wait 0.1;
            break;
    }
}

give_medic_class_skill( var_0 )
{
    maps\mp\alien\_hud::set_has_chaos_class_skill_bonus( self, 4 );
    self.haschaosclassskill = 1;
    thread chaos_class_use_monitor( var_0, "medic" );
}

give_engineer_class_skill( var_0 )
{
    maps\mp\alien\_hud::set_has_chaos_class_skill_bonus( self, 3 );
    self.haschaosclassskill = 1;
    thread chaos_class_use_monitor( var_0, "engineer" );
}

give_tank_class_skill( var_0 )
{
    maps\mp\alien\_hud::set_has_chaos_class_skill_bonus( self, 2 );
    self.haschaosclassskill = 1;
    thread chaos_class_use_monitor( var_0, "tank" );
}

give_specalist_class_skill( var_0 )
{
    maps\mp\alien\_hud::set_has_chaos_class_skill_bonus( self, 1 );
    self.haschaosclassskill = 1;
    thread chaos_class_use_monitor( var_0, "specialist" );
}

chaos_class_use_monitor( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self waittill( "action_slot_1" );
    self.chaosclassskillinuse = 1;
    self.haschaosclassskill = 0;
    maps\mp\alien\_hud::set_has_chaos_class_skill_bonus( self, 0 );
    refill_combo_meter();

    switch ( var_1 )
    {
        case "specialist":
            thread activate_specialist_class_skill();
            break;
        case "tank":
            thread activate_tank_class_skill();
            break;
        case "medic":
            thread activate_medic_class_skill();
            break;
        case "engineer":
            thread activate_engineer_class_skill();
            break;
    }
}

activate_engineer_class_skill()
{
    self endon( "disconnect" );
    var_0 = [];
    var_0["cooldown"] = 20;
    var_0["cost"] = 0;
    var_0["duration"] = 15;
    thread maps\mp\alien\_alien_class_skills_main::sound_audio_weapon_activate();
    maps\mp\alien\_music_and_dialog::playengineerclassskillvo( self );
    maps\mp\alien\_alien_class_skills_main::engineer_slow_field( var_0 );
    self.chaosclassskillinuse = undefined;
}

activate_medic_class_skill()
{
    self endon( "disconnect" );
    var_0 = [];
    var_0["cooldown"] = 20;
    var_0["cost"] = 0;
    var_0["duration"] = 15;
    maps\mp\alien\_music_and_dialog::playmedicclassskillvo( self );
    maps\mp\alien\_alien_class_skills_main::create_heal_ring( var_0 );
    self.chaosclassskillinuse = undefined;
}

activate_tank_class_skill()
{
    self endon( "disconnect" );
    level.meleestunradius = 128;
    level.meleestunmaxdamage = 1;
    level.meleestunmindamage = 1;
    var_0 = [];
    var_0["cooldown"] = 20;
    var_0["cost"] = 0;
    var_0["duration"] = 15;
    self visionsetnakedforplayer( "mp_alien_thermal_trinity", 0.5 );
    maps\mp\alien\_music_and_dialog::playtankclassskillvo( self );
    thread maps\mp\alien\_alien_class_skills_main::create_tank_ring( var_0 );
    maps\mp\alien\_alien_class_skills_main::tank_skill_flare( var_0 );
    self visionsetnakedforplayer( "", 0.5 );
    self.chaosclassskillinuse = undefined;
}

activate_specialist_class_skill()
{
    self endon( "disconnect" );
    var_0 = [];
    var_0["cooldown"] = 20;
    var_0["cost"] = 0;
    var_0["duration"] = 15;
    thread maps\mp\alien\_alien_class_skills_main::sound_audio_weapon_activate();
    maps\mp\alien\_music_and_dialog::playweaponclassskillvo( self );
    self.skill_in_use = 1;
    thread maps\mp\alien\_alien_class_skills_main::effect_on_fire( var_0 );
    self.camfx = spawnfxforclient( loadfx( "vfx/gameplay/alien/vfx_alien_cskill_wspecial_01" ), self.origin, self );
    triggerfx( self.camfx );
    _ID36637::_ID12846( undefined, 1 );
    maps\mp\alien\_alien_class_skills_main::specialist_boost( var_0 );
    self.skill_in_use = undefined;

    if ( isdefined( self.camfx ) )
        self.camfx delete();

    self.chaosclassskillinuse = undefined;
}

give_combo_freeze( var_0 )
{
    maps\mp\alien\_hud::set_has_combo_freeze( self, 1 );
    self.hascombofreeze = 1;
    thread combo_freeze_use_monitor();
}

combo_freeze_use_monitor( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self waittill( "action_slot_2" );
    self.hascombofreeze = undefined;
    maps\mp\alien\_hud::set_has_combo_freeze( self, 0 );
    level thread activate_combo_freeze();
}

activate_combo_freeze()
{
    level notify( "activate_combo_freeze" );
    level endon( "activate_combo_freeze" );
    level endon( "game_ended" );
    maps\mp\alien\_hud::freeze_combo_meter( 15 );
    common_scripts\utility::flag_set( "combo_freeze" );
    wait 15;
    maps\mp\alien\_hud::unfreeze_combo_meter();
    common_scripts\utility::_ID13180( "combo_freeze" );
    refill_combo_meter();
}

upgrade_all_skills( var_0 )
{
    inc_num_skill_upgrade_earned();

    foreach ( var_2 in level.players )
        upgrade_player_all_skills( var_2 );
}

upgrade_player_all_skills( var_0 )
{
    var_1 = [ "defense", "offense" ];

    foreach ( var_3 in var_1 )
        var_0 notify( "luinotifyserver",  var_3 + "_try_upgrade"  );
}

init_num_skill_upgrade_earned()
{
    level.num_skill_upgrade_earned = 0;
}

inc_num_skill_upgrade_earned()
{
    level.num_skill_upgrade_earned = min( 4, level.num_skill_upgrade_earned + 1 );
}

get_num_skill_upgrade_earned()
{
    return int( level.num_skill_upgrade_earned );
}

init_grace_period_end_time()
{
    level.grace_period_end_time = gettime();
}

start_grace_period( var_0 )
{
    level notify( "start_grace_period" );
    level endon( "start_grace_period" );
    level endon( "game_ended" );
    var_1 = gettime();
    var_2 = get_grace_period_end_time( var_1, var_0 );
    var_0 = ( var_2 - var_1 ) / 1000;
    common_scripts\utility::_ID13180( "grace_period_over" );
    maps\mp\alien\_hud::set_grace_period_clock( var_2 );
    wait(var_0);
    common_scripts\utility::flag_set( "grace_period_over" );
    maps\mp\alien\_hud::unset_grace_period_clock();

    if ( !common_scripts\utility::_ID13177( "combo_is_alive" ) )
        maps\mp\alien\_chaos_utility::chaos_end_game();
}

get_grace_period_end_time( var_0, var_1 )
{
    var_1 *= 1000;

    if ( level.grace_period_end_time <= var_0 )
        level.grace_period_end_time = var_0 + var_1;
    else
        level.grace_period_end_time = level.grace_period_end_time + var_1;

    return level.grace_period_end_time;
}

give_grace_period( var_0 )
{
    level thread start_grace_period( 30 );
}

give_bonus_score( var_0 )
{
    process_chaos_event( "bonus_score" );
}

give_bonus_cash( var_0 )
{
    foreach ( var_2 in level.players )
        var_2 maps\mp\alien\_persistence::_ID15551( 3000 );
}

give_trophy( var_0 )
{
    give_chaos_offhand_item( self, "alientrophy_mp", "flash" );
}

give_flare( var_0 )
{
    give_chaos_offhand_item( self, "alienflare_mp", "flash" );
}

give_pet_leash( var_0 )
{
    give_chaos_offhand_item( self, "alienthrowingknife_mp", "throwingknife" );
}

give_chaos_offhand_item( var_0, var_1, var_2 )
{
    remove_other_chaos_offhand_item( var_0 );
    var_0 setoffhandsecondaryclass( var_2 );
    var_0 giveweapon( var_1 );
    var_0 setweaponammoclip( var_1, 1 );
}

remove_other_chaos_offhand_item( var_0 )
{
    var_1 = [ "alienflare_mp", "alienthrowingknife_mp", "alientrophy_mp" ];

    foreach ( var_3 in var_1 )
        var_0 takeweapon( var_3 );
}

give_soflam( var_0 )
{
    maps\mp\_utility::setlowermessage( "chaos_soflam_hint", &"ALIEN_CHAOS_SOFLAM_HINT", 3 );
    self giveweapon( "aliensoflam_mp" );
}

give_self_revive( var_0 )
{
    maps\mp\alien\_laststand::_ID15541( self, 1 );
}

refill_pistol_ammo()
{
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "reload" );
        var_0 = self getcurrentweapon();
        var_1 = maps\mp\_utility::getweaponclass( var_0 );

        if ( var_1 == "weapon_pistol" )
        {
            var_2 = weaponclipsize( var_0 );
            var_3 = weaponstartammo( var_0 );
            var_4 = var_3 - var_2;

            for ( var_5 = 0; var_5 < var_2; var_5++ )
            {
                var_6 = self getweaponammostock( var_0 );
                self setweaponammostock( var_0, var_6 + 1 );
                wait 0.05;
            }
        }
    }
}

chaos_setup_op_weapons()
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
    level.opweaponsarray[15] = "iw6_alienmaaws_mp";
    level.opweaponsarray[16] = "alienbomb_mp";
    level.opweaponsarray[17] = "aliensoflam_mp";
}
