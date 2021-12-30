// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

init_chaos_score_components()
{
    level.combo_counter = 0;
    level.score_streak = 0;
    level.running_score_base = 0;
    level.total_score = 0;
}

calculate_total_score()
{
    level.total_score = level.running_score_base + level.combo_counter * level.score_streak;
    maps\mp\alien\_hud::set_total_score( level.total_score );
    return level.total_score;
}

keep_running_score()
{
    level.running_score_base = level.running_score_base + get_combo_counter() * get_score_streak();
}

reset_combo_counter()
{
    level.combo_counter = 0;
}

add_combo_counter( var_0 )
{
    level.combo_counter = level.combo_counter + var_0;
}

add_score_streak( var_0 )
{
    level.score_streak = level.score_streak + var_0;
}

get_combo_counter()
{
    return level.combo_counter;
}

get_score_streak()
{
    return level.score_streak;
}

get_total_score()
{
    return level.total_score;
}

register_chaos_events()
{
    level.chaos_events = [];

    for ( var_0 = 1; var_0 <= 100; var_0++ )
    {
        var_1 = table_look_up( "mp/alien/chaos_events.csv", var_0, 1 );

        if ( maps\mp\agents\alien\_alien_agents::is_empty_string( var_1 ) )
            break;

        var_2 = [];
        var_2["LUA_event_ID"] = int( table_look_up( "mp/alien/chaos_events.csv", var_0, 2 ) );
        var_2["combo_inc"] = int( table_look_up( "mp/alien/chaos_events.csv", var_0, 4 ) );
        var_2["score_inc"] = int( table_look_up( "mp/alien/chaos_events.csv", var_0, 5 ) );
        level.chaos_events[var_1] = var_2;
    }
}

add_chaos_weapon( var_0 )
{
    for ( var_1 = 1000; var_1 <= 1099; var_1++ )
    {
        if ( is_empty_value( var_1 ) )
            break;

        var_2 = make_weapon_struct( var_1 );
        var_0[var_0.size] = var_2;
    }

    return var_0;
}

make_weapon_struct( var_0 )
{
    var_1 = spawnstruct();
    var_1.script_noteworthy = _ID14842( var_0 );
    var_1.origin = get_weapon_origin( var_0 );
    var_1.angles = get_weapon_angles( var_0 );
    return var_1;
}

is_empty_value( var_0 )
{
    return table_look_up( level.alien_cycle_table, var_0, 1 ) == "";
}

_ID14842( var_0 )
{
    return get_weapon_info( var_0, 1 );
}

get_weapon_origin( var_0 )
{
    return transform_to_coordinate( get_weapon_info( var_0, 2 ) );
}

get_weapon_angles( var_0 )
{
    return transform_to_coordinate( get_weapon_info( var_0, 3 ) );
}

get_weapon_info( var_0, var_1 )
{
    return table_look_up( level.alien_cycle_table, var_0, var_1 );
}

register_perk( var_0, var_1, var_2 )
{
    var_3 = [];
    var_3["perk_ref"] = var_0;
    var_3["activate_func"] = var_1;
    var_3["deactivate_func"] = var_2;
    var_3["LUA_perk_ID"] = get_lua_perk_id( var_0 );
    var_3["is_activated"] = 0;
    level.perk_progression[get_activation_level( var_0 )] = var_3;
}

get_lua_perk_id( var_0 )
{
    return int( table_look_up( "mp/alien/chaos_perks.csv", var_0, 2 ) );
}

get_activation_level( var_0 )
{
    return int( table_look_up( "mp/alien/chaos_perks.csv", var_0, 1 ) );
}

register_drop_locations()
{
    level.chaos_bonus_loc = [];
    level.chaos_bonus_loc_used = [];

    for ( var_0 = 4000; var_0 <= 4099; var_0++ )
    {
        var_1 = table_look_up( level.alien_cycle_table, var_0, 1 );

        if ( maps\mp\agents\alien\_alien_agents::is_empty_string( var_1 ) )
            break;

        level.chaos_bonus_loc[level.chaos_bonus_loc.size] = transform_to_coordinate( var_1 );
    }
}

register_bonus_progression()
{
    level.chaos_bonus_progression = [];
    var_0 = 0;

    for ( var_1 = 5000; var_1 <= 5099; var_1++ )
    {
        var_2 = table_look_up( level.alien_cycle_table, var_1, 1 );

        if ( maps\mp\agents\alien\_alien_agents::is_empty_string( var_2 ) )
            break;

        var_3 = [];
        var_3["wait_duration"] = int( var_2 );
        var_3["num_of_drops"] = int( table_look_up( level.alien_cycle_table, var_1, 2 ) );
        var_3["package_group_type"] = strtok( table_look_up( level.alien_cycle_table, var_1, 3 ), " " );
        var_3["package_group_chance"] = convert_array_to_int( strtok( table_look_up( level.alien_cycle_table, var_1, 4 ), " " ) );
        var_3["item_chance"] = strtok( table_look_up( level.alien_cycle_table, var_1, 5 ), " " );

        if ( var_3["num_of_drops"] > var_0 )
            var_0 = var_3["num_of_drops"];

        level.chaos_bonus_progression[level.chaos_bonus_progression.size] = var_3;
    }

    level.chaos_max_used_loc_stored = level.chaos_bonus_loc.size - var_0;
}

convert_array_to_int( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
        var_1[var_1.size] = int( var_3 );

    return var_1;
}

transform_to_coordinate( var_0 )
{
    var_1 = strtok( var_0, "," );
    return ( int( var_1[0] ), int( var_1[1] ), int( var_1[2] ) );
}

init_chaos_deployable( var_0, var_1, var_2 )
{
    var_3 = spawnstruct();
    var_3.modelbase = "mp_weapon_alien_crate";
    var_3._ID16999 = &"ALIEN_CHAOS_BONUS_PICKUP";
    var_3.capturingstring = &"ALIEN_CHAOS_BONUS_TAKING";
    var_3._ID16454 = 25;
    var_3._ID19940 = 90.0;
    var_3._ID34785 = 0;
    var_3._ID35387 = "ballistic_vest_destroyed";
    var_3._ID22921 = "ammo_crate_use";
    var_3._ID22917 = var_2;
    var_3.canusecallback = maps\mp\alien\_deployablebox::_ID37078;
    var_3._ID34780 = 500;
    var_3.maxhealth = 150;
    var_3.damagefeedback = "deployable_bag";
    var_3._ID20764 = 1;
    var_3.icon_name = var_1;
    add_to_chaos_bonus_package_type( var_0 );
    maps\mp\alien\_deployablebox::_ID37461( var_0, var_3 );
}

get_random_player()
{
    return level.players[randomint( level.players.size )];
}

table_look_up( var_0, var_1, var_2 )
{
    return tablelookup( var_0, 0, var_1, var_2 );
}

get_drop_location_rated( var_0, var_1 )
{
    var_2 = 22500;
    var_3 = 90000;
    var_4 = 1.0;
    var_5 = 1.0;
    var_6 = 2.0;
    var_7 = -1000.0;
    var_8 = ( 0, 0, 0 );

    foreach ( var_10 in level.chaos_bonus_loc )
    {
        if ( location_recently_used( var_10 ) )
            continue;

        var_11 = 0.0;

        foreach ( var_13 in level.players )
        {
            var_14 = distancesquared( var_13.origin, var_10 );

            if ( var_14 > var_2 )
                var_11 += var_4;

            if ( var_14 < var_3 )
                var_11 += var_4;
        }

        var_16 = vectornormalize( ( 0, vectortoyaw( var_10 - var_1 ), 0 ) );
        var_11 += vectordot( var_16, var_0 ) * var_5;
        var_11 += randomfloat( var_6 );

        if ( var_11 > var_7 )
        {
            var_7 = var_11;
            var_8 = var_10;
        }
    }

    register_location( var_8 );
    return var_8;
}

register_location( var_0 )
{
    if ( level.chaos_bonus_loc_used.size == level.chaos_max_used_loc_stored )
    {
        for ( var_1 = 0; var_1 < level.chaos_max_used_loc_stored - 1; var_1++ )
            level.chaos_bonus_loc_used[var_1] = level.chaos_bonus_loc_used[var_1 + 1];

        level.chaos_bonus_loc_used[level.chaos_max_used_loc_stored - 1] = var_0;
    }
    else
        level.chaos_bonus_loc_used[level.chaos_bonus_loc_used.size] = var_0;
}

location_recently_used( var_0 )
{
    return common_scripts\utility::array_contains( level.chaos_bonus_loc_used, var_0 );
}

reset_alien_kill_streak()
{
    level.current_alien_kill_streak = 0;
}

inc_alien_kill_streak()
{
    level.current_alien_kill_streak++;
}

get_alien_kill_streak()
{
    return level.current_alien_kill_streak;
}

play_fx_on_package( var_0, var_1 )
{
    var_2 = ( -0.5, 5.6, 0 );
    var_3 = ( 0, 0, 5 );
    var_4 = rotatevector( var_2, var_1 );
    var_5 = var_0 + var_4;
    var_5 += var_3;
    var_6 = spawnfx( common_scripts\utility::_ID15033( "chaos_pre_bonus_drop" ), var_5 );
    triggerfx( var_6 );
    return var_6;
}

clean_up_monitor( var_0, var_1 )
{
    var_1 waittill( "death" );
    var_0 delete();
}

init_highest_combo()
{
    level.highest_combo = 0;
}

record_highest_combo( var_0 )
{
    if ( var_0 <= level.highest_combo )
        return;

    level.highest_combo = var_0;

    foreach ( var_2 in level.players )
        var_2 maps\mp\alien\_persistence::_ID37609( "hits", var_0, 1 );
}

register_cycle_duration()
{
    level.chaos_cycle_duration = [];

    for ( var_0 = 500; var_0 <= 599; var_0++ )
    {
        var_1 = table_look_up( level.alien_cycle_table, var_0, 1 );

        if ( maps\mp\agents\alien\_alien_agents::is_empty_string( var_1 ) )
            break;

        level.chaos_cycle_duration[level.chaos_cycle_duration.size] = int( table_look_up( level.alien_cycle_table, var_0, 6 ) );
    }
}

add_extra_spawn_locations()
{
    var_0 = [];

    for ( var_1 = 6000; var_1 <= 6099; var_1++ )
    {
        var_2 = table_look_up( level.alien_cycle_table, var_1, 1 );

        if ( maps\mp\agents\alien\_alien_agents::is_empty_string( var_2 ) )
            break;

        var_3 = spawnstruct();
        var_3.origin = transform_to_coordinate( var_2 );
        var_3.angles = transform_to_coordinate( table_look_up( level.alien_cycle_table, var_1, 2 ) );
        var_3.script_linkto = translate_to_actual_zone_name( table_look_up( level.alien_cycle_table, var_1, 3 ) );
        var_3.script_noteworthy = table_look_up( level.alien_cycle_table, var_1, 4 );
        var_0[var_0.size] = var_3;
    }

    maps\mp\alien\_spawn_director::put_spawnlocations_into_cycle_data( var_0, level.cycle_data );
}

init_combo_duration()
{
    if ( !isdefined( level.combo_duration ) )
        level.combo_duration = 4.0;
}

get_combo_duration()
{
    return level.combo_duration;
}

adjust_combo_duration( var_0 )
{
    level.combo_duration = level.combo_duration + var_0;
}

register_combo_duration_schedule()
{
    level.combo_duration_schedule = [];

    for ( var_0 = 7000; var_0 <= 7099; var_0++ )
    {
        var_1 = table_look_up( level.alien_cycle_table, var_0, 1 );

        if ( maps\mp\agents\alien\_alien_agents::is_empty_string( var_1 ) )
            break;

        var_2 = [];
        var_2["pre_delta_interval"] = float( var_1 );
        var_2["delta"] = float( table_look_up( level.alien_cycle_table, var_0, 2 ) );
        level.combo_duration_schedule[level.combo_duration_schedule.size] = var_2;
    }
}

init_bonus_package_cap()
{
    if ( !isdefined( level.chaos_bonus_package_cap ) )
        level.chaos_bonus_package_cap = 3;
}

get_bonus_package_cap()
{
    return level.chaos_bonus_package_cap;
}

init_chaos_bonus_package_type()
{
    level.chaos_bonus_package_type = [];
}

add_to_chaos_bonus_package_type( var_0 )
{
    level.chaos_bonus_package_type[level.chaos_bonus_package_type.size] = var_0;
}

get_current_num_bonus_package()
{
    var_0 = 0;

    foreach ( var_2 in level.chaos_bonus_package_type )
        var_0 += level._ID9646[var_2].size;

    return var_0;
}

chaos_end_game()
{
    if ( chaos_should_end() )
        level thread maps\mp\gametypes\aliens::alienendgame( "axis", maps\mp\alien\_hud::_ID14441( "kia" ) );
}

chaos_should_end()
{
    if ( common_scripts\utility::_ID13177( "in_host_migration" ) )
        return 0;

    return 1;
}

should_process_alien_killed_event( var_0 )
{
    return isplayer( var_0 ) || isdefined( var_0.owner ) && isplayer( var_0.owner ) || isdefined( var_0.team ) && var_0.team == "allies";
}

should_process_alien_damaged_event( var_0 )
{
    if ( isdefined( var_0 ) && var_0 == "alien_minion_explosion" )
        return 0;

    return 1;
}

unset_player_perks( var_0 )
{
    foreach ( var_2 in level.perk_progression )
    {
        if ( var_2["is_activated"] )
            [[ var_2["deactivate_func"] ]]( var_0, var_2["perk_ref"] );
    }

    var_0 playlocalsound( "mp_splash_screen_default" );
}

give_activated_perks( var_0 )
{
    foreach ( var_2 in level.perk_progression )
    {
        if ( var_2["is_activated"] )
            [[ var_2["activate_func"] ]]( var_0, var_2["perk_ref"] );
    }
}

set_all_perks_inactivated()
{
    foreach ( var_1 in level.perk_progression )
        var_1["is_activated"] = 0;
}

get_attacker_as_player( var_0 )
{
    if ( isplayer( var_0 ) )
        return var_0;

    if ( isdefined( var_0.owner ) && isplayer( var_0.owner ) )
        return var_0.owner;

    return undefined;
}

init_event_counts()
{
    level.chaos_event_counts = [];

    for ( var_0 = 1; var_0 <= 18; var_0++ )
        level.chaos_event_counts[var_0] = 0;
}

update_hud_event_counts()
{
    for ( var_0 = 1; var_0 <= 18; var_0++ )
        maps\mp\alien\_hud::set_event_count( var_0, level.chaos_event_counts[var_0] );
}

inc_event_count( var_0 )
{
    level.chaos_event_counts[var_0]++;
}

register_pre_end_game_display_func()
{
    level.pre_end_game_display_func = ::update_hud_event_counts;
}

translate_to_actual_zone_name( var_0 )
{
    var_1 = [];
    var_0 = strtok( var_0, " " );

    foreach ( var_3 in var_0 )
    {
        foreach ( var_6, var_5 in level.cycle_data._ID30813 )
        {
            if ( issubstr( var_6, var_3 ) )
                var_1[var_1.size] = var_6;
        }
    }

    if ( var_1.size == 0 )
        var_8 = "";
    else
    {
        var_8 = var_1[0];

        for ( var_9 = 1; var_9 < var_1.size; var_9++ )
            var_8 = var_8 + " " + var_1[var_9];
    }

    return var_8;
}
