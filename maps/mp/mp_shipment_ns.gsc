// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_shipment_ns_precache::_ID20445();
    maps\createart\mp_shipment_ns_art::_ID20445();
    maps\mp\mp_shipment_ns_fx::_ID20445();
    maps\mp\_utility::_ID28710( "r_specularColorScale", 3.5, 7.5 );
    level._ID20636 = ::_ID8769;
    level.mapcustomkillstreakfunc = ::customkillstreakfunc;
    level._ID20635 = ::custombotkillstreakfunc;
    _ID24833();
    maps\mp\_load::_ID20445();
    level.nukedeathvisionfunc = ::nukedeathvision;
    thread manage_gates();
    maps\mp\_compass::_ID29184( "compass_map_mp_shipment_ns" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 3.0, 9.5 );

    if ( level._ID25139 )
    {
        setdvar( "sm_sunShadowScale", "0.45" );
        setdvar( "sm_sunsamplesizenear", ".15" );
    }
    else if ( level._ID36452 )
    {
        setdvar( "sm_sunShadowScale", "0.55" );
        setdvar( "sm_sunsamplesizenear", ".3" );
    }
    else
    {
        setdvar( "sm_sunShadowScale", "1.0" );
        setdvar( "sm_sunsamplesizenear", ".42" );
    }

    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "urban";
    game["axis_outfit"] = "woodland";
    sort_spawn_points();
    thread _ID33427();
    thread display_team_scores();
    thread check_for_player_connect();
    thread box_kill_counter();
    thread select_random_prize();
    thread set_up_announcer();
    thread set_up_multi_turret();
    thread nuke_custom_visionset();
    thread box_kill_numbers();
    thread match_end_event();
    thread rotate_turntable();
    thread get_prize_room_curtains_n_fx();
    thread get_elevators();
    thread _ID36620::_ID37998( "alienEasterEgg" );
    level.helipilotsettings["heli_pilot"].modelbase = "vehicle_aas_72x_killstreak_shns";
    maps\mp\bots\_bots_ks::blockkillstreakforbots( "vanguard" );
}

_ID24833()
{
    precachempanim( "mp_stand_idle" );
    precachempanim( "hunted_celebrate_v2" );
    precachempanim( "hunted_celebrate_v3" );
    precachemodel( "shns_score_num_0_small" );
    precachemodel( "shns_score_num_1_small" );
    precachemodel( "shns_score_num_2_small" );
    precachemodel( "shns_score_num_3_small" );
    precachemodel( "shns_score_num_4_small" );
    precachemodel( "shns_score_num_5_small" );
    precachemodel( "shns_score_num_6_small" );
    precachemodel( "shns_score_num_7_small" );
    precachemodel( "shns_score_num_8_small" );
    precachemodel( "shns_score_num_9_small" );
}

manage_gates()
{
    level endon( "game_ended" );
    level endon( "start_custom_ending" );
    var_0 = getentarray( "doors", "targetname" );
    var_1 = getentarray( "doors_b", "targetname" );
    var_2 = common_scripts\utility::array_combine( var_0, var_1 );

    while ( !isdefined( level._ID14086 ) )
        wait 0.01;

    move_gate_array( var_2, "open", 0 );

    if ( level._ID14086 == "sd" || level._ID14086 == "sr" || level._ID14086 == "siege" || level._ID14086 == "horde" || level._ID14086 == "infect" || level._ID14086 == "grnd" )
    {
        remove_armored_shutters();
        return;
    }

    thread manage_expanded_area_spawns();
    var_3 = botautoconnectenabled();

    if ( var_3 == 0 )
    {
        if ( level._ID14086 == "dom" || level._ID14086 == "infect" || level._ID14086 == "grnd" )
        {
            while ( !isdefined( level._ID5597 ) )
                wait 0.05;
        }

        move_gate_array( var_2, "close", 1, 1 );
    }
    else if ( level._ID14086 != "dom" && level._ID14086 != "infect" && level._ID14086 != "grnd" && level._ID14086 != "blitz" )
        move_gate_array( var_2, "close", 1, 1 );
    else
    {
        while ( !isdefined( level._ID5597 ) )
            wait 0.05;

        move_gate_array( var_2, "close", 1, 1 );
    }

    var_4 = 45;
    var_5 = var_2;
    var_6 = 0;
    var_7 = getmatchdata( "hasBots" );

    switch ( level._ID14086 )
    {
        case "dm":
        case "war":
        case "conf":
        case "cranked":
            var_5 = var_0;
            var_4 = 60;
            break;
        case "dom":
            var_6 = 1;

            if ( getmatchdata( "hasBots" ) == 1 )
                var_4 = 0;
            else
                var_4 = 45;

            break;
        case "infect":
        case "grind":
            var_6 = 1;
            var_4 = 1;
            break;
        case "sd":
        case "sr":
        case "blitz":
            var_5 = var_0;
            var_4 = 1;
            break;
        default:
            var_6 = 1;
            var_4 = 1;
            break;
    }

    if ( isdefined( var_4 ) )
    {
        thread sfx_gate_alarm( var_4 );
        thread play_warning_light_fx( var_4 );
        wait(var_4);

        if ( var_6 )
            remove_armored_shutters();

        thread sfx_gates_open();
        move_gate_array( var_5, "open", 1, 1 );
        level notify( "announcement",  "doors_opened", undefined, undefined, 1  );
        level notify( "gates_open" );
    }
}

debug_loop( var_0 )
{
    for (;;)
    {
        iprintlnbold( var_0 );
        wait 1.0;
    }
}

play_red_light_fx()
{

}

play_warning_light_fx( var_0 )
{
    if ( var_0 > 4 )
    {
        wait(var_0 - 4);
        common_scripts\utility::exploder( 11 );

        for ( var_1 = 0; var_1 < 4; var_1++ )
        {
            thread sfx_lights_red();
            common_scripts\utility::exploder( 42 );
            wait 1.1;
        }
    }

    thread sfx_lights_green();
    common_scripts\utility::exploder( 40 );
}

move_gate_array( var_0, var_1, var_2, var_3 )
{
    foreach ( var_5 in var_0 )
        thread move_gate( var_5, var_1, var_2, var_3 );

    wait(var_2);
}

move_gate( var_0, var_1, var_2, var_3 )
{
    var_4 = getent( var_0.target, "targetname" );

    if ( isdefined( var_3 ) )
    {
        if ( var_1 == "close" )
        {
            if ( isdefined( var_4 ) )
            {
                if ( var_2 >= 1 )
                    var_4 moveto( var_4.origin + ( 0, 0, 104 ), var_2, var_2 / 8, var_2 / 4 );
                else
                    var_4.origin = var_4.origin + ( 0, 0, 104 );
            }

            var_0 moveto( var_0.origin + ( 0, 0, 96 ), 0.1 );
            wait 0.1;
            var_0 solid();
            var_0 disconnectpaths();
            var_0 show();
            var_0 setaisightlinevisible( 0 );
        }
        else
        {
            if ( isdefined( var_4 ) )
            {
                if ( var_2 >= 1 )
                    var_4 moveto( var_4.origin - ( 0, 0, 104 ), var_2, var_2 / 8, var_2 / 4 );
                else
                    var_4.origin = var_4.origin - ( 0, 0, 104 );
            }

            var_0 connectpaths();
            var_0 notsolid();
            var_0 hide();
            var_0 setaisightlinevisible( 1 );
            var_0 moveto( var_0.origin - ( 0, 0, 96 ), 0.1 );
            wait 0.1;
        }
    }
    else if ( var_1 == "close" )
    {
        if ( isdefined( var_4 ) )
        {
            if ( var_2 >= 1 )
                var_4 moveto( var_4.origin + ( 0, 0, 104 ), var_2, var_2 / 8, var_2 / 4 );
            else
                var_4.origin = var_4.origin + ( 0, 0, 104 );
        }
    }
    else if ( isdefined( var_4 ) )
    {
        if ( var_2 >= 1 )
            var_4 moveto( var_4.origin - ( 0, 0, 104 ), var_2, var_2 / 8, var_2 / 4 );
        else
            var_4.origin = var_4.origin - ( 0, 0, 104 );
    }
}

move_shutter_array( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_0 )
        thread move_shutter( var_4, var_1, var_2 );

    wait(var_2);
}

move_shutter( var_0, var_1, var_2 )
{
    if ( var_1 == "close" )
        var_0 moveto( var_0.origin + ( 0, 0, 96 ), var_2, var_2 / 8, var_2 / 4 );
    else
        var_0 moveto( var_0.origin - ( 0, 0, 96 ), var_2, var_2 / 8, var_2 / 4 );
}

remove_armored_shutters()
{
    var_0 = getentarray( "armory_rollups", "targetname" );

    if ( isdefined( var_0 ) )
    {
        foreach ( var_2 in var_0 )
            var_2 delete();
    }
}

manage_expanded_area_spawns()
{
    level.dynamicspawns = ::filter_expanded_area_spawn_points;
    level waittill( "gates_open" );
    level.dynamicspawns = undefined;
}

manage_trap_1_area_spawns()
{
    level.dynamicspawns = ::filter_trap_1_area_spawn_points;
    common_scripts\utility::_ID13216( "trap_1_active" );
    level.dynamicspawns = undefined;
}

filter_expanded_area_spawn_points( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( _ID18435( level.expanded_area_spawns, var_3 ) )
            continue;

        var_1[var_1.size] = var_3;
    }

    return var_1;
}

filter_trap_1_area_spawn_points( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( _ID18435( level.trap_1_area_spawns, var_3 ) )
            continue;

        var_1[var_1.size] = var_3;
    }

    return var_1;
}

sort_spawn_points()
{
    level.expanded_area_spawns = [];
    level.trap_1_area_spawns = [];

    while ( !isdefined( level._ID14087 ) )
        wait 0.05;

    if ( !isdefined( level.spawnpoints ) )
        return;

    foreach ( var_1 in level.spawnpoints )
    {
        var_2 = var_1.script_noteworthy;

        if ( !isdefined( var_2 ) )
            continue;

        var_3 = strtok( var_2, ";" );

        foreach ( var_5 in var_3 )
        {
            if ( var_5 == "expanded_area_spawn" )
                level.expanded_area_spawns[level.expanded_area_spawns.size] = var_1;

            if ( var_5 == "trap_1_area_spawn" )
                level.trap_1_area_spawns[level.trap_1_area_spawns.size] = var_1;
        }
    }
}

_ID18435( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        if ( var_0[var_2] == var_1 )
            return 1;
    }

    return 0;
}

display_team_scores()
{
    for (;;)
    {
        if ( isdefined( level.players ) )
            break;

        wait 1;
    }

    var_0 = getentarray( "scoreboard_number", "target" );

    foreach ( var_2 in var_0 )
        var_2 hide();

    if ( !level._ID32653 )
        return;

    var_4 = getent( "ghosts_1_0", "targetname" );
    var_5 = getent( "ghosts_2_0", "targetname" );
    var_6 = getent( "ghosts_3_0", "targetname" );
    var_7 = getent( "ghosts_4_0", "targetname" );
    var_8 = getent( "federation_1_0", "targetname" );
    var_9 = getent( "federation_2_0", "targetname" );
    var_10 = getent( "federation_3_0", "targetname" );
    var_11 = getent( "federation_4_0", "targetname" );

    for (;;)
    {
        if ( level._ID14086 == "sd" || level._ID14086 == "sr" || level._ID14086 == "siege" )
        {
            var_12 = game["roundsWon"]["allies"];
            var_13 = game["roundsWon"]["axis"];
        }
        else
        {
            var_12 = game["teamScores"]["allies"];
            var_13 = game["teamScores"]["axis"];
        }

        if ( var_12 > 9999 )
        {
            var_12 = 10000;
            var_4 setmodel( "shns_score_num_feds_r" );
            var_5 setmodel( "shns_score_num_feds_r" );
            var_6 setmodel( "shns_score_num_feds_e" );
            var_7 setmodel( "tag_origin" );
        }

        if ( var_13 > 9999 )
        {
            var_13 = 10000;
            var_8 setmodel( "shns_score_num_feds_r" );
            var_9 setmodel( "shns_score_num_feds_r" );
            var_10 setmodel( "shns_score_num_feds_e" );
            var_11 setmodel( "tag_origin" );
        }

        if ( var_12 < 10 )
        {
            var_14 = getsubstr( var_12, 0, 1 );
            var_4 setmodel( "shns_score_num_ghosts_" + var_14 );
        }

        if ( var_12 > 9 && var_12 < 99 )
        {
            var_14 = getsubstr( var_12, 1, 2 );
            var_15 = getsubstr( var_12, 0, 1 );
            var_4 setmodel( "shns_score_num_ghosts_" + var_14 );
            var_5 setmodel( "shns_score_num_ghosts_" + var_15 );
        }

        if ( var_12 > 99 && var_12 < 999 )
        {
            var_14 = getsubstr( var_12, 2, 3 );
            var_15 = getsubstr( var_12, 1, 2 );
            var_16 = getsubstr( var_12, 0, 1 );
            var_4 setmodel( "shns_score_num_ghosts_" + var_14 );
            var_5 setmodel( "shns_score_num_ghosts_" + var_15 );
            var_6 setmodel( "shns_score_num_ghosts_" + var_16 );
        }

        if ( var_12 > 999 && var_12 <= 9999 )
        {
            var_14 = getsubstr( var_12, 3, 4 );
            var_15 = getsubstr( var_12, 2, 3 );
            var_16 = getsubstr( var_12, 1, 2 );
            var_17 = getsubstr( var_12, 0, 1 );
            var_4 setmodel( "shns_score_num_ghosts_" + var_14 );
            var_5 setmodel( "shns_score_num_ghosts_" + var_15 );
            var_6 setmodel( "shns_score_num_ghosts_" + var_16 );
            var_7 setmodel( "shns_score_num_ghosts_" + var_17 );
        }

        if ( var_13 < 10 )
        {
            var_18 = getsubstr( var_13, 0, 1 );
            var_8 setmodel( "shns_score_num_feds_" + var_18 );
        }

        if ( var_13 > 9 && var_13 < 99 )
        {
            var_18 = getsubstr( var_13, 1, 2 );
            var_19 = getsubstr( var_13, 0, 1 );
            var_8 setmodel( "shns_score_num_feds_" + var_18 );
            var_9 setmodel( "shns_score_num_feds_" + var_19 );
        }

        if ( var_13 > 99 && var_13 < 999 )
        {
            var_18 = getsubstr( var_13, 2, 3 );
            var_19 = getsubstr( var_13, 1, 2 );
            var_20 = getsubstr( var_13, 0, 1 );
            var_8 setmodel( "shns_score_num_feds_" + var_18 );
            var_9 setmodel( "shns_score_num_feds_" + var_19 );
            var_10 setmodel( "shns_score_num_feds_" + var_20 );
        }

        if ( var_13 > 999 && var_13 <= 9999 )
        {
            var_18 = getsubstr( var_13, 3, 4 );
            var_19 = getsubstr( var_13, 2, 3 );
            var_20 = getsubstr( var_13, 1, 2 );
            var_21 = getsubstr( var_13, 0, 1 );
            var_8 setmodel( "shns_score_num_feds_" + var_18 );
            var_9 setmodel( "shns_score_num_feds_" + var_19 );
            var_10 setmodel( "shns_score_num_feds_" + var_20 );
            var_11 setmodel( "shns_score_num_feds_" + var_21 );
        }

        wait 0.5;
    }
}

check_for_player_connect()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread _ID26961( ::kill_watcher );
    }
}

_ID26961( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self waittill( "spawned_player" );
    self thread [[ var_0 ]]();
}

set_up_announcer()
{
    level.announcements = [];
    level.announcer_temperature = 0;
    level.announcements["big_spread"] = create_announcement_entry( 6, 0, "shipment_com_ghosts_lead", "shipment_com_feds_lead" );
    level.announcements["big_spread_noteam"] = create_announcement_entry( 6, 0, "shipment_com_none_lead" );
    level.announcements["score_unchanged"] = create_announcement_entry( 6, 30, "shipment_com_score_same" );
    level.announcements["close_match"] = create_announcement_entry( 1, 0, "shipment_com_close_match" );
    level.announcements["ks_first"] = create_announcement_entry( 1, 0, "shipment_com_ghosts_spin_1st", "shipment_com_feds_spin_1st" );
    level.announcements["ks_additional"] = create_announcement_entry( 0, 0, "shipment_com_ghosts_spin_addtl", "shipment_com_feds_spin_addtl" );
    level.announcements["ks_first_noteam"] = create_announcement_entry( 1, 0, "shipment_com_none_spin_1st" );
    level.announcements["ks_additional_noteam"] = create_announcement_entry( 0, 0, "shipment_com_none_spin_addtl" );
    level.announcements["trap_1"] = create_announcement_entry( 0, 0, "shipment_com_ghosts_gas", "shipment_com_feds_gas" );
    level.announcements["trap_1_noteam"] = create_announcement_entry( 0, 0, "shipment_com_none_gas" );
    level.announcements["all_traps"] = create_announcement_entry( 0, 0, "shipment_com_ghosts_traps", "shipment_com_feds_traps" );
    level.announcements["all_traps_noteam"] = create_announcement_entry( 0, 0, "shipment_com_none_traps" );
    level.announcements["turrets"] = create_announcement_entry( 0, 0, "shipment_com_ghosts_cleanse", "shipment_com_feds_cleanse" );
    level.announcements["turrets_noteam"] = create_announcement_entry( 0, 0, "shipment_com_none_cleanse" );
    level.announcements["care_strike"] = create_announcement_entry( 0, 0, "shipment_com_ghosts_jackpot", "shipment_com_feds_jackpot" );
    level.announcements["care_strike_noteam"] = create_announcement_entry( 0, 0, "shipment_com_none_jackpot" );
    level.announcements["kem_strike"] = create_announcement_entry( 0, 0, "shipment_com_ghosts_kem", "shipment_com_feds_kem" );
    level.announcements["multikill"] = create_announcement_entry( 3, 30, "shipment_com_multikill_female", "shipment_com_multikill_male" );
    level.announcements["killstreak"] = create_announcement_entry( 10, 60, "shipment_com_killstreak_female", "shipment_com_killstreak_male" );
    level.announcements["back_shot_noteam"] = create_announcement_entry( 0, 15, "shipment_com_none_intheback" );
    level.announcements["pistol_kill_noteam"] = create_announcement_entry( 0, 15, "shipment_com_none_pistol_kill" );
    level.announcements["generic_kill"] = create_announcement_entry( 0, 15, "shipment_com_generic" );
    level.announcements["melee_kill"] = create_announcement_entry( 0, 20, "shipment_com_ghosts_melee", "shipment_com_feds_melee" );
    level.announcements["melee_kill_noteam"] = create_announcement_entry( 0, 20, "shipment_com_none_melee" );
    level.announcements["headshot"] = create_announcement_entry( 0, 20, "shipment_com_ghosts_headshot", "shipment_com_feds_headshot" );
    level.announcements["headshot_noteam"] = create_announcement_entry( 0, 20, "shipment_com_none_headshot" );
    level.announcements["dog_kill"] = create_announcement_entry( 0, 10, "shipment_com_ghosts_dogkill", "shipment_com_feds_dogkill" );
    level.announcements["dog_kill_noteam"] = create_announcement_entry( 0, 10, "shipment_com_none_dogkill" );
    level.announcements["long_shot"] = create_announcement_entry( 0, 20, "shipment_com_ghosts_longshot", "shipment_com_feds_longshot" );
    level.announcements["long_shot_noteam"] = create_announcement_entry( 0, 20, "shipment_com_none_longshot" );
    level.announcements["double_kill"] = create_announcement_entry( 0, 15, "shipment_com_ghosts_doublekill", "shipment_com_feds_doublekill" );
    level.announcements["double_kill_noteam"] = create_announcement_entry( 0, 15, "shipment_com_none_doublekill" );
    level.announcements["triple_kill"] = create_announcement_entry( 6, 40, "shipment_com_ghosts_triplekill", "shipment_com_feds_triplekill" );
    level.announcements["triple_kill_noteam"] = create_announcement_entry( 6, 40, "shipment_com_none_triplekill" );
    level.announcements["savior"] = create_announcement_entry( 10, 20, "shipment_com_ghosts_savior", "shipment_com_feds_savior" );
    level.announcements["savior_noteam"] = create_announcement_entry( 10, 20, "shipment_com_none_savior" );
    level.announcements["avenger"] = create_announcement_entry( 10, 20, "shipment_com_ghosts_avenger", "shipment_com_feds_avenger" );
    level.announcements["avenger_noteam"] = create_announcement_entry( 10, 20, "shipment_com_none_avenger" );
    level.announcements["doors_opened"] = create_announcement_entry( 1, 0, "shipment_com_doors_opened" );
    level.announcements["intro"] = create_announcement_entry( 1, 0, "shipment_com_intro" );
    level.announcements["outro"] = create_announcement_entry( 1, 0, "shipment_com_outro" );
    level.announcements["outro_rare"] = create_announcement_entry( 1, 0, "shipment_com_outro_rare" );
    level.announcements["puzzle_box"] = create_announcement_entry( 3, 60, "shipment_com_puzzlebox" );
    level.announcements["puzzle_box_max"] = create_announcement_entry( 1, 0, "shipment_com_100_puzzlebox" );

    if ( level._ID32653 && level._ID14086 != "siege" && level._ID14086 != "sr" && level._ID14086 != "sd" )
        thread determine_score_big_lead();

    if ( !level._ID32653 )
        thread determine_score_big_lead_noteam();

    thread determine_close_match();
    thread manage_announcements();
    thread announcement_time_incrementer();
    thread intro_announcements();
    common_scripts\utility::_ID13189( "ready_to_announce" );
    common_scripts\utility::flag_set( "ready_to_announce" );
}

create_announcement_entry( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = spawnstruct();
    var_6.reps = 0;
    var_6.max_reps = var_0;
    var_6.temperature = 0;
    var_6._ID7973 = var_1;
    var_6.lines = [];
    var_6.lines[var_6.lines.size] = var_2;
    var_6.lines[var_6.lines.size] = var_3;
    var_6.lines[var_6.lines.size] = var_4;
    var_6.lines[var_6.lines.size] = var_5;
    return var_6;
}

manage_announcements()
{
    var_0 = getentarray( "announcer_speaker", "targetname" );
    var_1 = 6;
    level.last_announcement_type = "default";

    for (;;)
    {
        if ( isdefined( level.players ) )
            break;

        wait 1;
    }

    for (;;)
    {
        level waittill( "announcement",  var_2, var_3, var_4, var_5  );

        if ( !isdefined( level.announcements ) )
            continue;

        if ( level.last_announcement_type == var_2 && var_2 != "generic_kill" )
            continue;

        if ( level._ID29973 == 1 )
            continue;

        if ( level.announcements[var_2].reps >= level.announcements[var_2].max_reps && level.announcements[var_2].max_reps != 0 || level.announcements[var_2].temperature > 0 && level.announcements[var_2]._ID7973 != 0 )
            continue;

        if ( !common_scripts\utility::_ID13177( "ready_to_announce" ) )
        {
            if ( !isdefined( var_5 ) )
                continue;
            else
                level common_scripts\utility::waittill_notify_or_timeout( "allow_override", 5 );
        }

        maps\mp\gametypes\_hostmigration::_ID35770();

        if ( isdefined( var_4 ) )
        {
            if ( isdefined( var_3 ) )
            {
                if ( var_4 == 1 )
                {
                    if ( var_3 == "axis" )
                        var_6 = level.announcements[var_2].lines[2];
                    else
                        var_6 = level.announcements[var_2].lines[0];
                }
                else if ( var_3 == "axis" )
                    var_6 = level.announcements[var_2].lines[3];
                else
                    var_6 = level.announcements[var_2].lines[1];
            }
            else if ( var_4 == 1 )
                var_6 = level.announcements[var_2].lines[0];
            else
                var_6 = level.announcements[var_2].lines[1];
        }
        else if ( isdefined( var_3 ) && level._ID14086 != "dm" )
        {
            if ( var_3 == "axis" )
                var_6 = level.announcements[var_2].lines[1];
            else
                var_6 = level.announcements[var_2].lines[0];
        }
        else
            var_6 = level.announcements[var_2].lines[0];

        foreach ( var_8 in var_0 )
        {
            var_8 playsound( var_6 );
            level.announcements[var_2].reps++;
            level.time_since_last_announcement = 0;
        }

        if ( var_2 != "outro" && var_2 != "outro_rare" )
        {
            level.last_announcement_type = var_2;
            common_scripts\utility::_ID13180( "ready_to_announce" );
            thread allow_announcement_override( var_6 );

            if ( var_2 == "generic_kill" )
                thread announcer_cooldown_manager( 2 );
            else
                thread announcer_cooldown_manager( var_1 );

            level.announcements[var_2] thread announcement_cooldown();
            continue;
        }

        level endon( "game_ended" );
    }
}

announcement_time_incrementer()
{
    level.time_since_last_announcement = 0;

    for (;;)
    {
        wait 1;
        level.time_since_last_announcement++;
    }
}

allow_announcement_override( var_0 )
{
    var_1 = lookupsoundlength( var_0 );
    wait(var_1 / 1000 + 0.1);
    level notify( "allow_override" );
}

announcement_cooldown()
{
    self.temperature = self._ID7973;

    while ( self.temperature > 0 )
    {
        self.temperature--;
        wait 1;
    }
}

announcer_cooldown_manager( var_0 )
{
    if ( level.announcer_temperature > var_0 )
        return;

    level.announcer_temperature = var_0;
    level notify( "announcer_time_reset" );
    level endon( "announcer_time_reset" );

    for (;;)
    {
        if ( level.announcer_temperature <= 0 )
        {
            wait(randomfloatrange( 0, 3 ));
            common_scripts\utility::flag_set( "ready_to_announce" );
            return;
        }

        level.announcer_temperature--;
        wait 1;
    }
}

intro_announcements()
{
    while ( !isdefined( level._ID14087 ) )
        wait 0.05;

    wait 18;
    level notify( "announcement",  "intro", undefined, undefined, 1  );
}

kill_watcher()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    level.last_announcer_line = "default";
    var_0 = self hasfemalecustomizationmodel();

    for (;;)
    {
        if ( level._ID14086 != "horde" )
            self waittill( "got_a_kill",  var_1, var_2, var_3  );
        else
            self waittill( "horde_kill",  var_1, var_2, var_3  );

        if ( level.time_since_last_announcement > 18 )
            level notify( "announcement",  "generic_kill", undefined, undefined  );
        else
        {
            var_4 = gettime();

            if ( weaponclass( var_2 ) == "pistol" && var_3 != "MOD_MELEE" && level.last_announcer_line != "pistol" )
            {
                level notify( "announcement",  "pistol_kill_noteam", undefined, undefined  );
                level.last_announcer_line = "pistol";
                continue;
            }

            if ( var_3 == "MOD_MELEE" && level.last_announcer_line != "mod_melee" )
            {
                if ( level._ID32653 )
                {
                    if ( common_scripts\utility::_ID7657() )
                        level notify( "announcement",  "melee_kill", self.team, undefined  );
                    else
                        level notify( "announcement",  "melee_kill_noteam", undefined, undefined  );
                }
                else
                    level notify( "announcement",  "melee_kill_noteam", undefined, undefined  );

                level.last_announcer_line = "mod_melee";
                continue;
            }

            if ( var_3 == "MOD_HEAD_SHOT" && level.last_announcer_line != "mod_head_shot" )
            {
                if ( level._ID32653 )
                    level notify( "announcement",  "headshot", self.team, undefined  );
                else
                    level notify( "announcement",  "headshot_noteam", undefined, undefined  );

                level.last_announcer_line = "mod_head_shot";
                continue;
            }

            if ( var_2 == "guard_dog_mp" && level.last_announcer_line != "guard_dog_mp" )
            {
                if ( level._ID32653 )
                    level notify( "announcement",  "dog_kill", self.team, undefined  );
                else
                    level notify( "announcement",  "dog_kill_noteam", undefined, undefined  );

                level.last_announcer_line = "guard_dog_mp";
                continue;
            }

            if ( maps\mp\_events::_ID18696( self, var_2, var_3, self.origin, var_1 ) && level.last_announcer_line != "long_shot" )
            {
                if ( level._ID32653 )
                    level notify( "announcement",  "long_shot", self.team, undefined  );
                else
                    level notify( "announcement",  "long_shot_noteam", undefined, undefined  );

                level.last_announcer_line = "long_shot";
                continue;
            }

            if ( self.recentkillcount == 2 )
            {
                if ( level._ID32653 )
                    level notify( "announcement",  "double_kill", self.team, undefined  );
                else
                    level notify( "announcement",  "double_kill_noteam", undefined, undefined  );
            }

            if ( level._ID14086 != "horde" )
            {
                if ( isbackshot( var_1 ) && level.last_announcer_line != "back_shot" )
                {
                    level notify( "announcement",  "back_shot_noteam", undefined, undefined  );
                    level.last_announcer_line = "back_shot";
                }

                if ( issavior( var_1, var_4 ) && level.last_announcer_line != "savior" )
                {
                    if ( level._ID32653 )
                        level notify( "announcement",  "savior", self.team, undefined  );
                    else
                        level notify( "announcement",  "savior_noteam", undefined, undefined  );

                    level.last_announcer_line = "savior";
                }

                if ( level._ID32653 && var_4 - var_1._ID19574 < 500 && level.last_announcer_line != "avenger" )
                {
                    if ( var_1._ID19569 != self )
                    {
                        if ( level._ID32653 )
                            level notify( "announcement",  "avenger", self.team, undefined  );
                        else
                            level notify( "announcement",  "avenger_noteam", undefined, undefined  );

                        level.last_announcer_line = "avenger";
                    }
                }
            }

            if ( self.recentkillcount == 3 )
            {
                if ( level._ID32653 )
                    level notify( "announcement",  "triple_kill", self.team, undefined  );
                else
                    level notify( "announcement",  "triple_kill_noteam", undefined, undefined  );
            }

            if ( self.recentkillcount >= 4 )
                level notify( "announcement",  "multikill", undefined, undefined  );

            if ( self.adrenaline >= 5 )
                level notify( "announcement",  "killstreak", undefined, undefined  );
        }

        wait 0.1;
    }
}

isbackshot( var_0 )
{
    var_1 = var_0._ID3366[1];
    var_2 = self._ID3367[1];
    var_3 = angleclamp180( var_1 - var_2 );

    if ( abs( var_3 ) < 65 )
        return 1;
    else
        return 0;
}

issavior( var_0, var_1 )
{
    foreach ( var_4, var_3 in var_0._ID8965 )
    {
        if ( var_4 == self._ID15851 )
            continue;

        if ( level._ID32653 && var_1 - var_3 < 500 )
            return 1;
    }

    return 0;
}

determine_close_match()
{
    var_0 = maps\mp\_utility::_ID15434() * 60;
    var_1 = maps\mp\_utility::getscorelimit();

    if ( level._ID14086 == "blitz" )
        var_1 = maps\mp\_utility::getwatcheddvar( "scorelimit" );

    if ( var_0 < 60 || var_1 == 0 )
        return;

    var_2 = max( 5, var_1 / 20 );
    thread match_nearly_over( var_1 );
    common_scripts\utility::waittill_notify_or_timeout( "score_limit_almost_reached", var_0 - 25 );

    if ( abs( getteamscore( "allies" ) - getteamscore( "axis" ) ) < var_2 )
        level notify( "announcement",  "close_match"  );
}

match_nearly_over( var_0 )
{
    var_1 = 0.9;

    for (;;)
    {
        var_2 = getteamscore( "allies" );
        var_3 = getteamscore( "axis" );

        if ( var_2 > var_0 * 0.9 || var_3 > var_0 * 0.9 )
        {
            level notify( "score_limit_almost_reached" );
            break;
        }

        wait 0.25;
    }
}

determine_score_big_lead()
{
    level endon( "game_ended" );
    var_0 = maps\mp\_utility::getscorelimit();

    if ( level._ID14086 == "blitz" )
        var_0 = maps\mp\_utility::getwatcheddvar( "scorelimit" );

    if ( var_0 == 0 )
        return;

    var_1 = var_0 * 0.5;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;
    var_5 = 30;

    for (;;)
    {
        var_6 = getteamscore( "allies" );
        var_7 = getteamscore( "axis" );
        var_8 = gettime();

        if ( var_6 == var_2 && var_7 == var_3 && var_8 > 60000 )
            var_4++;
        else
            var_4 = 0;

        if ( var_4 > var_5 )
        {
            level notify( "announcement",  "score_unchanged"  );
            var_4 = 0;
        }

        var_9 = abs( var_6 - var_7 );

        if ( var_9 > var_1 )
        {
            if ( var_6 > var_7 )
            {
                level notify( "announcement",  "big_spread", "ghosts"  );
                return;
            }
            else
            {
                level notify( "announcement",  "big_spread", "federation"  );
                return;
            }
        }

        var_2 = var_6;
        var_3 = var_7;
        wait 1;
    }
}

determine_score_big_lead_noteam()
{
    level endon( "game_ended" );
    var_0 = maps\mp\_utility::getscorelimit();

    if ( level._ID14086 == "blitz" )
        var_0 = maps\mp\_utility::getwatcheddvar( "scorelimit" );

    if ( var_0 == 0 )
        return;

    for (;;)
    {
        if ( isdefined( level.players ) )
        {
            var_1 = [];
            var_1 = common_scripts\utility::_ID3855( level.players, ::_ID18488 );

            if ( var_1.size >= 2 )
            {
                if ( var_1[0].score - var_1[1].score > var_0 / 2 )
                {
                    level notify( "announcement",  "big_spread_noteam"  );
                    return;
                }
            }
        }

        wait 1;
    }
}

randomizer_create( var_0 )
{
    var_1 = spawnstruct();
    var_1._ID3800 = var_0;
    return var_1;
}

_ID25404()
{
    var_0 = undefined;

    if ( self._ID3800.size > 1 && isdefined( self._ID19462 ) )
    {
        var_0 = randomint( self._ID3800.size - 1 );

        if ( var_0 >= self._ID19462 )
            var_0++;
    }
    else
        var_0 = randomint( self._ID3800.size );

    self._ID19462 = var_0;
    return self._ID3800[var_0];
}

rotate_turntable()
{
    var_0 = getent( "showcase_turntable", "targetname" );
    var_1 = getentarray( "showcase_prize", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 linkto( var_0 );

    for (;;)
    {
        var_0 rotateyaw( 360, 20 );
        wait 20;
    }
}

_ID8769()
{
    level.allow_level_killstreak = maps\mp\_utility::allowlevelkillstreaks();

    if ( !level.allow_level_killstreak )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "slot_machine", 2000, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"MP_DLC_13_KILLSTREAK_PICKUP" );
    level thread killstreak_watch_for_crate();
}

killstreak_watch_for_crate()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "slot_machine" )
        {
            killstreak_set_weight( 0 );
            var_1 = _ID35446( var_0 );

            if ( !isdefined( var_1 ) )
                killstreak_set_weight( 2000 );
            else
                game["player_holding_level_killstreak"] = var_1;
        }
    }
}

_ID35446( var_0 )
{
    var_1 = _ID35948( var_0 );
    return var_1;
}

_ID35948( var_0 )
{
    var_0 endon( "death" );
    var_0 waittill( "captured",  var_1  );
    return var_1;
}

killstreak_set_weight( var_0 )
{
    if ( isdefined( game["player_holding_level_killstreak"] ) && isalive( game["player_holding_level_killstreak"] ) )
        return 0;

    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "slot_machine", var_0 );
}

customkillstreakfunc()
{
    level._ID19276["killstreak_level_event_mp"] = "slot_machine";
    level._ID19256["slot_machine"] = ::tryusekillstreak;
    thread debug_prizes();
}

custombotkillstreakfunc()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "slot_machine", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

tryusekillstreak( var_0, var_1 )
{
    level notify( "killstreak_activate",  self  );
    return 1;
}

select_random_prize()
{
    var_0 = [];
    var_1 = 30;
    var_2 = var_1 + 15;
    var_3 = var_2 + 25;
    var_4 = var_3 + 25;
    var_5 = var_4 + 5;

    for (;;)
    {
        level waittill( "killstreak_activate",  var_6  );
        common_scripts\utility::flag_set( "ready_to_announce" );
        level notify( "allow_override" );

        if ( !common_scripts\utility::_ID13177( "killstreak_additional" ) )
        {
            if ( level._ID32653 )
                level notify( "announcement",  "ks_first", var_6.team, undefined, 1  );
            else
                level notify( "announcement",  "ks_first_noteam", undefined, undefined, 1  );

            common_scripts\utility::flag_set( "killstreak_additional" );
        }
        else if ( level._ID32653 )
            level notify( "announcement",  "ks_additional", var_6.team, undefined, 1  );
        else
            level notify( "announcement",  "ks_additional_noteam", undefined, undefined, 1  );

        var_7 = randomintrange( 0, 100 );
        var_8 = "null";
        var_9 = "null";

        if ( var_7 <= var_1 )
            var_8 = "trap_1";

        if ( var_7 >= var_1 && var_7 <= var_2 )
            var_8 = "all_traps";

        if ( var_7 >= var_2 && var_7 <= var_3 )
            var_8 = "turrets";

        if ( var_7 >= var_3 && var_7 <= var_4 )
            var_8 = "care_strike";

        if ( var_7 >= var_4 && var_7 <= var_5 )
            var_8 = "kem_strike";

        if ( ( var_8 == "care_strike" || var_8 == "all_traps" ) && level._ID6711.size > 0 )
            var_8 = "trap_1";

        if ( common_scripts\utility::_ID13177( "turrets_active" ) && ( var_8 == "all_traps" || var_8 == "turrets" ) )
            var_8 = "trap_1";

        switch ( var_8 )
        {
            case "trap_1":
                common_scripts\utility::flag_set( "trap_1_active" );
                thread manage_trap_1_area_spawns();
                var_9 = "Gas Trap";
                common_scripts\utility::exploder( 24 );
                thread play_gas_jet_fx();
                thread play_slot_machine_sfx();
                jumbotron_play_slot_machine_bink( "mp_shipment_ns_trap_1_prize", 5 );

                if ( isdefined( var_6 ) )
                    var_6 thread trap_activate( level.trap_1, 25, 0, 1, 12, 1 );

                break;
            case "all_traps":
                var_9 = "All Traps";
                common_scripts\utility::flag_set( "trap_1_active" );
                thread manage_trap_1_area_spawns();
                common_scripts\utility::exploder( 26 );
                thread play_gas_jet_fx();
                thread play_slot_machine_sfx( 1 );
                jumbotron_play_slot_machine_bink( "mp_shipment_ns_all_traps_prize", 5 );

                if ( isdefined( var_6 ) )
                    var_6 thread trap_activate( level.trap_1, 25, 0, 1, 12, 1 );

                wait 0.5;
                var_6 thread multi_turret( 15 );
                wait 1.2;
                var_6 thread carestrike_setup();
                break;
            case "turrets":
                var_9 = "Arena Cleanse";
                common_scripts\utility::exploder( 22 );
                thread play_slot_machine_sfx();
                jumbotron_play_slot_machine_bink( "mp_shipment_ns_turret_prize", 5 );

                if ( isdefined( var_6 ) )
                    var_6 thread multi_turret( 15 );

                break;
            case "care_strike":
                var_9 = "Carestrike";
                common_scripts\utility::exploder( 23 );
                thread play_slot_machine_sfx();
                jumbotron_play_slot_machine_bink( "mp_shipment_ns_care_prize", 5 );

                if ( isdefined( var_6 ) )
                    var_6 thread carestrike_setup();

                break;
            case "kem_strike":
                var_9 = "K.E.M. Strike";
                common_scripts\utility::exploder( 25 );
                thread play_slot_machine_sfx();
                jumbotron_play_slot_machine_bink( "mp_shipment_ns_kem_prize", 5 );

                if ( isdefined( var_6 ) )
                    var_6 thread maps\mp\killstreaks\_nuke::_ID10678();

                break;
        }

        if ( !level._ID32653 && var_8 != "kem_strike" )
            var_8 += "_noteam";

        common_scripts\utility::flag_set( "ready_to_announce" );
        level notify( "allow_override" );
        waittillframeend;
        level notify( "announcement",  var_8, var_6.team, undefined, 1  );
        game["player_holding_level_killstreak"] = undefined;
        killstreak_set_weight( 2000 );
    }
}

nuke_custom_visionset()
{
    level waittill( "nuke_death" );
    wait 1.3;
    level notify( "nuke_death" );
    thread nuke_custom_visionset();
}

play_slot_machine_sfx( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        thread common_scripts\utility::_ID23839( "emt_slot_machine_dist_jackpot", ( -38, -1357, 1261 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine_jackpot", ( -117, -211, 263 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine_jackpot", ( -741, -381, 347 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine_jackpot", ( -323, 179, 258 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine_jackpot", ( -744, 492, 342 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine_jackpot", ( -420, 750, 342 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine_jackpot", ( 114, 344, 259 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine_jackpot", ( 414, 745, 341 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine_jackpot", ( 720, 505, 341 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine_jackpot", ( 321, -52, 255 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine_jackpot", ( 721, -346, 348 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine_jackpot", ( 464, -617, 348 ) );
    }
    else
    {
        thread common_scripts\utility::_ID23839( "emt_slot_machine_dist", ( -38, -1357, 1261 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine", ( -117, -211, 263 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine", ( -741, -381, 347 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine", ( -323, 179, 258 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine", ( -744, 492, 342 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine", ( -420, 750, 342 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine", ( 114, 344, 259 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine", ( 414, 745, 341 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine", ( 720, 505, 341 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine", ( 321, -52, 255 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine", ( 721, -346, 348 ) );
        thread common_scripts\utility::_ID23839( "emt_slot_machine", ( 464, -617, 348 ) );
    }
}

_ID33427()
{
    level.trap_1 = spawnstruct();
    level.trap_1.inflictor = getent( "trap_1_origin", "targetname" );
    level.trap_1._ID35399 = getent( "trap_1_volume", "targetname" );
    level.trap_1.destructibles = [ ( 481, -74, -100 ) ];
    level.trap_1.player = undefined;
    level.trap_1.team = undefined;
    level.trap_1.exploder = 91;
    level.trap_1._ID13177 = "trap_1_active";
    common_scripts\utility::_ID13189( "trap_1_active" );
    common_scripts\utility::_ID13189( "jumbotron_available" );
    common_scripts\utility::_ID13189( "killstreak_can_kill" );
    common_scripts\utility::_ID13189( "killstreak_additional" );
    common_scripts\utility::_ID13189( "turrets_active" );
    common_scripts\utility::_ID13189( "played_easter_egg_video" );
    thread gas_visionset_cleanup();
}

gas_visionset_cleanup()
{
    wait 2.5;

    while ( level.players.size == 0 )
        wait 0.1;

    level._ID35333 = 0;

    foreach ( var_1 in level.players )
        var_1 visionsetstage( level._ID35333, 2 );
}

trap_activate( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    level notify( "gas_trap_activated" );
    level endon( "gas_trap_activated" );
    level endon( "game_ended" );
    common_scripts\utility::flag_set( var_0._ID13177 );
    var_0.player = self;
    var_0.team = self.pers["team"];
    badplace_brush( "badplace_trap", var_4, var_0._ID35399, "allies", "axis" );
    common_scripts\utility::exploder( var_0.exploder );

    if ( var_0 == level.trap_1 )
    {
        thread gas_trap_sfx();
        thread gas_trap_vision();
    }

    for ( var_6 = 0; var_6 < var_4; var_6 += var_3 )
    {
        maps\mp\gametypes\_hostmigration::_ID35770();

        if ( isdefined( var_5 ) )
            common_scripts\utility::exploder( var_0.exploder );

        var_7 = var_0.player;

        if ( !isdefined( var_0.player ) || !isplayer( var_0.player ) )
            var_7 = undefined;

        thread _ID37066( var_0, var_7, var_1 );
        wait(var_3);
    }

    var_0.player = undefined;
    var_0.team = undefined;
    common_scripts\_exploder::_ID31779( var_0.exploder );
    wait 1;
    common_scripts\utility::_ID13180( var_0._ID13177 );
}

play_gas_jet_fx()
{
    wait 3;
    common_scripts\utility::exploder( 92 );
}

gas_trap_vision()
{
    level._ID35333 = 1;

    foreach ( var_1 in level.players )
        var_1 visionsetstage( level._ID35333, 0.5 );

    thread stop_gas_trap_vision();
}

stop_gas_trap_vision()
{
    wait 12;
    level._ID35333 = 0;

    foreach ( var_1 in level.players )
        var_1 visionsetstage( level._ID35333, 2 );
}

gas_trap_sfx()
{
    common_scripts\utility::_ID23839( "scn_shp_gas_trap", ( -287, 1021, 244 ) );
    common_scripts\utility::_ID23839( "scn_shp_gas_trap", ( 286, 1021, 244 ) );
    common_scripts\utility::_ID23839( "scn_shp_gas_trap", ( 354, -743, 250 ) );
    common_scripts\utility::_ID23839( "scn_shp_gas_trap", ( -316, -730, 250 ) );
    common_scripts\utility::_ID23839( "scn_shp_gas_trap", ( -6, -1084, 357 ) );
    common_scripts\utility::_ID23839( "scn_shp_gas_trap", ( -553, -968, 250 ) );
}

_ID37066( var_0, var_1, var_2 )
{
    var_3 = var_0._ID35399 getistouchingentities( level.characters );

    foreach ( var_5 in var_3 )
    {
        if ( var_5 maps\mp\_utility::_hasperk( "_specialty_blastshield" ) )
            var_2 *= 1.6;

        if ( _ID36939( var_0, var_5 ) && isdefined( var_1 ) )
        {
            if ( var_5.team != var_0.team || level._ID13683 )
                var_0.inflictor radiusdamage( var_5.origin, 10, var_2, var_2, var_1, "MOD_PROJECTILE_SPLASH", "killstreak_level_event_mp" );
            else if ( var_5 == var_1 )
                var_0.inflictor radiusdamage( var_5.origin, 10, var_2, var_2, var_1, "MOD_PROJECTILE_SPLASH", "killstreak_level_event_mp" );
        }

        wait 0.05;
    }
}

_ID36939( var_0, var_1 )
{
    if ( !isdefined( var_1 ) || !maps\mp\_utility::_ID18757( var_1 ) )
        return 0;

    if ( level._ID32653 )
    {
        if ( isdefined( var_0.player ) && var_1 == var_0.player )
            return 1;
        else if ( isdefined( var_0.player ) && isdefined( var_1.owner ) && var_1.owner == var_0.player )
            return 1;
        else if ( isdefined( var_0.team ) && var_1.team == var_0.team && !level._ID13683 )
            return 0;
    }

    return 1;
}

_ID37067( var_0, var_1, var_2, var_3 )
{
    var_4 = "MOD_EXPLOSIVE";
    var_5 = "none";
    var_6 = ( 0, 0, 0 );
    var_7 = ( 0, 0, 0 );
    var_8 = "";
    var_9 = "";
    var_10 = "";
    var_11 = undefined;
    var_12 = var_0._ID35399 getistouchingentities( var_2 );

    foreach ( var_14 in var_12 )
    {
        if ( !isdefined( var_14 ) )
            continue;

        if ( isdefined( var_14.owner ) && var_14.owner == var_0.owner )
            var_14 notify( "damage",  var_3, var_1, var_6, var_7, var_4, var_8, var_9, var_10, var_11, var_5  );
        else if ( level._ID32653 && isdefined( var_0.team ) && isdefined( var_14.team ) && var_14.team == var_0.team )
            continue;

        var_14 notify( "damage",  var_3, var_1, var_6, var_7, var_4, var_8, var_9, var_10, var_11, var_5  );
        wait 0.05;
    }
}

set_up_multi_turret()
{
    level._ID28174["multiturret"] = "multiturret";
    level._ID28172["multiturret"] = spawnstruct();
    level._ID28172["multiturret"].health = 999999;
    level._ID28172["multiturret"].maxhealth = 1000;
    level._ID28172["multiturret"].burstmin = 20;
    level._ID28172["multiturret"]._ID6331 = 120;
    level._ID28172["multiturret"]._ID23388 = 0.0;
    level._ID28172["multiturret"]._ID23387 = 0.01;
    level._ID28172["multiturret"]._ID28168 = "sentry";
    level._ID28172["multiturret"]._ID28167 = "sentry_offline";
    level._ID28172["multiturret"].timeout = 90.0;
    level._ID28172["multiturret"]._ID31014 = 0.05;
    level._ID28172["multiturret"].overheattime = 15.0;
    level._ID28172["multiturret"].cooldowntime = 0.1;
    level._ID28172["multiturret"].fxtime = 0.3;
    level._ID28172["multiturret"]._ID31889 = "sentry";
    level._ID28172["multiturret"].weaponinfo = "sentry_minigun_mp";
    level._ID28172["multiturret"].modelbase = "weapon_sentry_chaingun";
    level._ID28172["multiturret"]._ID21276 = "weapon_sentry_chaingun_obj";
    level._ID28172["multiturret"]._ID21277 = "weapon_sentry_chaingun_obj_red";
    level._ID28172["multiturret"].modelbombsquad = "weapon_sentry_chaingun_bombsquad";
    level._ID28172["multiturret"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["multiturret"]._ID16999 = &"";
    level._ID28172["multiturret"].headicon = 1;
    level._ID28172["multiturret"]._ID32680 = "used_sentry";
    level._ID28172["multiturret"]._ID29893 = 0;
    level._ID28172["multiturret"]._ID35387 = undefined;
    level._ID28172["multiturret"]._ID36472 = "destroyed_sentry";
    level._ID28172["multiturret"]._ID19962 = "tag_fx";
}

multi_turret( var_0 )
{
    common_scripts\utility::flag_set( "turrets_active" );
    var_1 = getentarray( "turret_killstreak_location", "targetname" );

    foreach ( var_3 in var_1 )
        thread generate_turret( var_0, var_3 );

    var_5 = getentarray( "turret_shutter", "targetname" );

    foreach ( var_7 in var_5 )
        var_7 notsolid();

    thread turret_box_light_fx();
    thread sfx_turret_shutters_open();
    move_shutter_array( var_5, "open", 0.25 );
    wait(var_0 - 0.25);
    thread sfx_turret_shutters_close();
    move_shutter_array( var_5, "close", 0.25 );

    foreach ( var_7 in var_5 )
        var_7 solid();

    common_scripts\utility::_ID13180( "turrets_active" );
}

generate_turret( var_0, var_1 )
{
    var_2 = maps\mp\killstreaks\_autosentry::_ID8474( "multiturret", self );
    var_2._ID29893 = 0;
    var_2.carriedby = self;
    level.turret_team = self.pers["team"];
    var_2 maps\mp\killstreaks\_autosentry::_ID28144();
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_2._ID19214 = spawn( "script_model", var_2.origin + ( 0, 0, 64 ) );
    var_2._ID19214 linkto( var_2 );
    var_2 thread multi_turret_timeout( var_0 );
}

multi_turret_timeout( var_0 )
{
    self endon( "death" );
    self endon( "game_ended" );
    wait(var_0);
    self turretfiredisable();
    var_1 = getentarray( "turret_shutter", "targetname" );
    wait 0.25;
    self delete();
    self notify( "death" );
}

carestrike_setup()
{
    var_0 = getent( "carestrike_spawn_1", "targetname" );
    var_1 = getent( "carestrike_spawn_2", "targetname" );
    var_2 = getent( "carestrike_spawn_3", "targetname" );
    var_3 = getent( "carestrike_location_1", "targetname" );
    var_4 = getent( "carestrike_location_2", "targetname" );
    var_5 = getent( "carestrike_location_3", "targetname" );
    thread common_scripts\utility::_ID23839( "mus_carestrike", ( 33, 92, 741 ) );
    var_3 playsound( "scn_shp_carestrike_jets" );
    thread jumbotron_play_slot_machine_bink( "mp_shipment_ns_carestrike", 7 );
    thread carestrike( self, var_0, var_3, "mp_shipment_carestrike_jet_1" );
    thread carestrike( self, var_1, var_4, "mp_shipment_carestrike_jet_2" );
    thread carestrike( self, var_2, var_5, "mp_shipment_carestrike_jet_3" );
}

carestrike( var_0, var_1, var_2, var_3 )
{
    var_4 = var_2.angles;
    var_2 = var_2.origin;
    var_5 = 12000;
    var_6 = 4000;
    var_7 = maps\mp\killstreaks\_airdrop::_ID15024( var_2 );
    var_8 = var_1.origin;
    var_8 = var_8 * ( 1, 1, 0 ) + ( 0, 0, var_7 );
    var_9 = airplanesetup( var_0, var_8 );
    var_9.angles = var_1.angles;
    var_10 = anglestoforward( var_4 );
    var_9 scriptmodelplayanimdeltamotion( var_3 );
    var_11 = distance2d( var_9.origin, var_2 );
    var_12 = 0;

    switch ( var_3 )
    {
        case "mp_shipment_carestrike_jet_1":
            wait 0.05;
            playfxontag( level._ID1644["vfx_jet_cheap_contrail_red"], var_9, "tag_body" );
            break;
        case "mp_shipment_carestrike_jet_2":
            wait 0.1;
            var_9 playsoundonmovingent( "scn_shp_carestrike_jets_mover" );
            playfxontag( level._ID1644["vfx_jet_cheap_contrail_white"], var_9, "tag_body" );
            break;
        case "mp_shipment_carestrike_jet_3":
            wait 0.15;
            playfxontag( level._ID1644["vfx_jet_cheap_contrail_blue"], var_9, "tag_body" );
            break;
    }

    for (;;)
    {
        var_13 = distance2d( var_9.origin, var_2 );

        if ( var_13 < var_11 )
            var_11 = var_13;
        else if ( var_13 > var_11 )
            break;

        if ( var_13 < 256 )
            break;
        else if ( var_13 < 768 )
        {
            earthquake( 0.15, 1.5, var_2, 1500 );

            if ( !var_12 )
                var_12 = 1;
        }

        wait 0.05;
    }

    var_14 = [];
    var_14[0] = "airdrop_assault";
    var_14[1] = "airdrop_support";
    var_15 = var_14[common_scripts\utility::_ID7657()];
    var_16 = var_9 _ID11103( var_2, var_15, var_7, 0, undefined, var_8, var_10 );
    wait 0.05;
    var_9 notify( "drop_crate" );
    wait 0.05;
    var_15 = var_14[common_scripts\utility::_ID7657()];
    var_16 = var_9 _ID11103( var_2, var_15, var_7, 0, undefined, var_8, var_10 );
    wait 0.05;
    var_9 notify( "drop_crate" );
    wait 4;
    objective_delete( var_9.friendly_objective_number );
    maps\mp\_utility::_objective_delete( var_9.friendly_objective_number );
    objective_delete( var_9.enemy_objective_number );
    maps\mp\_utility::_objective_delete( var_9.enemy_objective_number );
    var_9 delete();
}

_ID11103( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_10 = [];
    self.owner endon( "disconnect" );

    if ( !isdefined( var_4 ) )
    {
        if ( isdefined( var_7 ) )
        {
            var_11 = undefined;
            var_12 = undefined;

            for ( var_13 = 0; var_13 < 100; var_13++ )
            {
                var_12 = maps\mp\killstreaks\_airdrop::getcratetypefordroptype( var_1 );
                var_11 = 0;

                for ( var_14 = 0; var_14 < var_7.size; var_14++ )
                {
                    if ( var_12 == var_7[var_14] )
                    {
                        var_11 = 1;
                        break;
                    }
                }

                if ( var_11 == 0 )
                    break;
            }

            if ( var_11 == 1 )
                var_12 = maps\mp\killstreaks\_airdrop::getcratetypefordroptype( var_1 );
        }
        else
            var_12 = maps\mp\killstreaks\_airdrop::getcratetypefordroptype( var_1 );
    }
    else
        var_12 = var_4;

    if ( !isdefined( var_6 ) )
        var_6 = ( randomint( 50 ), randomint( 50 ), randomint( 50 ) );

    var_10 = maps\mp\killstreaks\_airdrop::createairdropcrate( self.owner, var_1, var_12, var_5, var_0 );

    switch ( var_1 )
    {
        case "airdrop_mega":
        case "nuke_drop":
        case "airdrop_juggernaut":
        case "airdrop_juggernaut_recon":
        case "airdrop_juggernaut_maniac":
            var_10 linkto( self, "tag_ground", ( 64, 32, -128 ), ( 0, 0, 0 ) );
            break;
        case "airdrop_escort":
        case "airdrop_osprey_gunner":
            var_10 linkto( self, var_8, ( 0, 0, 0 ), ( 0, 0, 0 ) );
            break;
        default:
            var_10 linkto( self, "tag_ground", ( 32, 0, 5 ), ( 0, 0, 0 ) );
            break;
    }

    var_10.angles = ( 0, 0, 0 );
    var_10 show();
    var_15 = self.veh_speed;
    var_6 *= 50000;
    var_10.carestrike = 1;
    thread maps\mp\killstreaks\_airdrop::_ID35554( var_10, var_6, var_1, var_12, 9999999 );
    var_10.droppingtoground = 1;
    var_10 thread crate_drop_sfx();
    return var_12;
}

crate_drop_sfx()
{
    wait 0.1;
    self playsoundonmovingent( "scn_shp_carestrike_release" );
}

airplanesetup( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_model", var_1 );
    var_3 setmodel( "vehicle_f15_low_nodetail_mp" );

    if ( !isdefined( var_3 ) )
        return;

    var_3.owner = var_0;
    var_3.team = var_0.team;
    var_4 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_4, "invisible", ( 0, 0, 0 ) );
    objective_position( var_4, self.origin );
    objective_state( var_4, "active" );
    objective_onentitywithrotation( var_4, var_3 );
    objective_icon( var_4, "compass_objpoint_airstrike_friendly" );
    var_5 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_5, "invisible", ( 0, 0, 0 ) );
    objective_position( var_5, self.origin );
    objective_state( var_5, "active" );
    objective_onentitywithrotation( var_5, var_3 );
    objective_icon( var_5, "compass_objpoint_airstrike_busy" );

    if ( level._ID32653 )
    {
        objective_team( var_4, var_0.team );
        objective_team( var_5, maps\mp\_utility::getotherteam( var_0.team ) );
    }
    else
    {
        objective_player( var_4, var_0 getentitynumber() );
        objective_playermask_showtoall( var_5 );
        objective_playermask_hidefrom( var_5, var_0 getentitynumber() );
    }

    var_3.friendly_objective_number = var_4;
    var_3.enemy_objective_number = var_5;
    return var_3;
}

debug_prizes()
{
    for (;;)
    {
        if ( getdvarint( "scr_trap_1" ) == 1 )
        {
            common_scripts\utility::flag_set( "trap_1_active" );
            thread manage_trap_1_area_spawns();
            jumbotron_play_slot_machine_bink( "mp_shipment_ns_trap_1_prize", 5 );
            level.players[0] thread trap_activate( level.trap_1, 20, 0, 1, 20, 1 );
        }

        if ( getdvarint( "scr_all_traps" ) == 1 )
        {
            common_scripts\utility::flag_set( "trap_1_active" );
            thread manage_trap_1_area_spawns();
            jumbotron_play_slot_machine_bink( "mp_shipment_ns_all_traps_prize", 5 );
            level.players[0] thread trap_activate( level.trap_1, 15, 0, 1, 20, 1 );
            wait 0.5;
            level.players[0] thread multi_turret( 15 );
            wait 1.2;
            level.players[0] thread carestrike_setup();
        }

        if ( getdvarint( "scr_carestrike" ) == 1 )
        {
            jumbotron_play_slot_machine_bink( "mp_shipment_ns_care_prize", 5 );
            level.players[0] thread carestrike_setup();
        }

        if ( getdvarint( "scr_multiturret" ) == 1 )
        {
            jumbotron_play_slot_machine_bink( "mp_shipment_ns_turret_prize", 5 );
            level.players[0] thread multi_turret( 15 );
        }

        wait 0.25;
    }
}

_ID37458()
{
    thread play_random_clip();
    wait 0.05;
    level notify( "cinematic_preload" );
    wait 1;
    level notify( "cinematic_start" );
}

_ID38282( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_0 ) )
        return;

    level waittill( var_1 );
    preloadcinematicforall( "long_loop" );
    playcinematicforall( "mp_shipment_ns_trap_1_prize" );
    wait 30;
    common_scripts\utility::flag_set( "jumbotron_available" );
    thread jumbotron_loop_bink( "mp_shipment_ns_long_loop", 33 );
    var_4 = getent( "jumbotron_static_logo", "targetname" );
    var_4 hide();
}

play_random_clip()
{
    var_0 = [];
    var_0[var_0.size] = "mp_shipment_ns_clip_01";
    var_0[var_0.size] = "mp_shipment_ns_clip_02";
    var_0[var_0.size] = "mp_shipment_ns_clip_03";
    var_0[var_0.size] = "mp_shipment_ns_clip_04";
    var_0[var_0.size] = "mp_shipment_ns_clip_05";
    var_0[var_0.size] = "mp_shipment_ns_clip_06";
    var_0 = randomizer_create( var_0 );
    common_scripts\utility::flag_set( "jumbotron_available" );
    var_1 = getent( "jumbotron_static_logo", "targetname" );
    var_1 hide();

    for (;;)
    {
        common_scripts\utility::flag_wait( "jumbotron_available" );
        var_2 = var_0 _ID25404();
        playcinematicforall( var_2 );
        wait 3;
    }
}

jumbotron_loop_bink( var_0, var_1 )
{
    level endon( "stop_jumbotron_loop" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "jumbotron_available" );
        playcinematicforall( var_0 );
        wait(var_1);
    }
}

jumbotron_play_slot_machine_bink( var_0, var_1 )
{
    wait(var_1);
    common_scripts\utility::flag_set( "jumbotron_available" );
}

box_kill_counter()
{
    level endon( "game_ended" );
    var_0 = getent( "box_kill_volume", "targetname" );
    var_1 = getent( "puzzle_box_sign_on", "targetname" );
    var_2 = getent( "puzzle_box_sign_off", "targetname" );
    var_1 hide();

    for (;;)
    {
        var_3 = maps\mp\agents\_agent_utility::getactiveagentsoftype( "all" );
        var_3 = common_scripts\utility::array_combine( var_3, level.players );
        var_3 = common_scripts\utility::array_combine( var_3, level._ID25810 );

        foreach ( var_5 in var_3 )
        {
            if ( isplayer( var_5 ) && ( var_5.sessionstate == "intermission" || var_5.sessionstate == "spectator" || !maps\mp\_utility::_ID18757( var_5 ) ) )
                var_3 = common_scripts\utility::array_remove( var_3, var_5 );
        }

        var_7 = var_0 getistouchingentities( var_3 );

        foreach ( var_9 in var_7 )
        {
            if ( isdefined( var_9.is_in_box ) )
                continue;

            var_9.is_in_box = 1;

            if ( isdefined( var_9.classname ) && var_9.classname != "script_vehicle" )
            {
                var_9 thread watch_for_box_death( var_1, var_2 );
                var_9 thread watch_for_leaving_box( var_0 );
            }
        }

        wait 0.05;
    }
}

watch_for_leaving_box( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );

    while ( self istouching( var_0 ) )
        wait 0.05;

    self notify( "left_the_box" );
    self.is_in_box = undefined;
}

watch_for_box_death( var_0, var_1 )
{
    self endon( "disconnect" );
    self endon( "left_the_box" );
    self waittill( "death" );
    self.is_in_box = undefined;
    level.box_kill_counter = level.box_kill_counter + 1;
    thread box_kill_sign_lights( var_0, var_1 );
}

box_kill_sign_lights( var_0, var_1 )
{
    common_scripts\utility::exploder( 33 );
    var_1 hide();
    var_0 show();
    var_0 thread puzzle_box_counter_sfx();
    wait 1.5;
    var_0 hide();
    var_1 show();
}

puzzle_box_counter_sfx()
{
    wait 0.2;
    self playsound( "emt_puzzle_box_counter" );
}

box_kill_numbers()
{
    for (;;)
    {
        if ( isdefined( level.players ) )
            break;

        wait 1;
    }

    level.box_kill_counter = 0;
    var_0 = 0;
    var_1 = 1;
    thread box_kill_counter();
    var_2 = getentarray( "box_1_0", "targetname" );
    var_3 = getentarray( "box_2_0", "targetname" );
    var_4 = common_scripts\utility::array_combine( var_2, var_3 );

    foreach ( var_6 in var_4 )
        var_6 show();

    for (;;)
    {
        if ( level.box_kill_counter == 99 )
            level notify( "announcement",  "puzzle_box_max", undefined, undefined, 1  );
        else if ( level.box_kill_counter > 1 && level.box_kill_counter % 10 == 0 )
            level notify( "announcement",  "puzzle_box", undefined, undefined, 0  );

        if ( level.box_kill_counter > 99 )
            var_8 = 99;
        else
            var_8 = level.box_kill_counter;

        if ( var_8 < 10 )
        {
            var_9 = getsubstr( var_8, 0, 1 );

            foreach ( var_6 in var_2 )
                var_6 setmodel( "shns_score_num_" + var_9 + "_small" );
        }

        if ( var_8 > 9 && var_0 < 99 )
        {
            var_9 = getsubstr( var_8, 1, 2 );

            foreach ( var_6 in var_2 )
                var_6 setmodel( "shns_score_num_" + var_9 + "_small" );

            var_14 = getsubstr( var_8, 0, 1 );

            foreach ( var_6 in var_3 )
                var_6 setmodel( "shns_score_num_" + var_14 + "_small" );
        }

        if ( var_8 >= 50 && !common_scripts\utility::_ID13177( "played_easter_egg_video" ) )
        {
            common_scripts\utility::flag_set( "played_easter_egg_video" );
            common_scripts\utility::exploder( 86 );
            thread common_scripts\utility::_ID23839( "emt_jumbotron_ns", ( -38, -1357, 1261 ) );
            jumbotron_play_slot_machine_bink( "mp_shipment_ns_easter_egg", 23 );
        }

        if ( level.box_kill_counter >= var_1 * 20 )
        {
            var_1++;
            common_scripts\utility::exploder( 8 );
        }

        wait 0.05;
    }
}

match_end_event()
{
    for (;;)
    {
        level common_scripts\utility::_ID35626( "start_custom_ending", "scoreboard_displaying", "final_killcam_done" );

        if ( maps\mp\_utility::_ID35913() )
        {
            break;
            continue;
        }

        wait 0.1;
    }

    maps\mp\_utility::levelflagset( "post_game_level_event_active" );
    var_0 = randomintrange( 1, 10 );

    if ( var_0 == 1 )
        level notify( "announcement",  "outro_rare", undefined, undefined, 1  );
    else
        level notify( "announcement",  "outro", undefined, undefined, 1  );

    maps\mp\_utility::_ID19892( "post_game_level_event_active" );
}

get_highest_scoring_players()
{
    var_0 = [];

    if ( !level._ID32653 )
        var_1 = common_scripts\utility::_ID3855( level.players, ::_ID18488 );
    else
    {
        var_2 = getteamscore( "allies" );
        var_3 = getteamscore( "axis" );

        if ( var_2 == var_3 )
            var_4 = undefined;
        else if ( var_2 > var_3 )
            var_4 = "allies";
        else
            var_4 = "axis";

        if ( isdefined( var_4 ) )
            var_1 = common_scripts\utility::_ID3855( level._ID32666[var_4], ::_ID18488 );
        else
            var_1 = common_scripts\utility::_ID3855( level.players, ::_ID18488 );
    }

    for ( var_5 = 0; var_5 < 3; var_5++ )
    {
        if ( isdefined( var_1[var_5] ) )
        {
            var_0[var_0.size] = var_1[var_5];
            continue;
        }

        break;
    }

    return var_0;
}

_ID18488( var_0, var_1 )
{
    return var_0.score > var_1.score;
}

set_up_winners_podium( var_0 )
{
    var_1 = getent( "mp_global_intermission", "classname" );
    var_2 = spawn( "script_model", var_1.origin );
    var_2 setmodel( "tag_origin" );
    var_2.angles = var_1.angles;
    var_3 = getent( "podium_clip", "targetname" );
    var_3 moveto( var_3.origin + ( 0, 0, 300 ), 0.05 );
    var_3 disconnectpaths();

    for ( var_4 = 0; var_4 < 3; var_4++ )
    {
        var_5 = var_0[var_4];

        if ( !isdefined( var_5 ) )
            return;

        var_6 = var_4 + 1;
        var_7 = getent( "podium_place_" + var_6, "targetname" );
        var_5 spawn( var_7.origin, var_7.angles );
        var_5 maps\mp\_utility::_ID34608( "playing" );
        var_5._ID24978 = undefined;
        var_5.disabledweapon = 1;
        var_5.disabledoffhandweapons = 1;

        if ( isdefined( var_5._ID26332 ) )
            var_5._ID26332 = undefined;

        var_5 cameralinkto( var_2, "tag_origin" );
        var_5.custom_spawn_loc = var_7;

        if ( maps\mp\_utility::_ID18768() )
            var_5 thread podium_scoreboard_sequence( var_7, var_2, "playing" );
    }
}

set_up_podium_spectator( var_0 )
{
    var_1 = getent( "mp_global_intermission", "classname" );
    var_2 = spawn( "script_model", var_1.origin );
    var_2 setmodel( "tag_origin" );
    var_2.angles = var_1.angles;

    if ( isdefined( var_0 ) )
    {
        for ( var_3 = 0; var_3 < var_0.size; var_3++ )
        {
            var_4 = var_0[var_3];

            if ( !isdefined( var_4 ) )
                continue;

            if ( !isbot( var_4 ) )
            {
                var_4 thread spawn_custom_spectator( var_2 );

                if ( maps\mp\_utility::_ID18768() )
                    var_4 thread podium_scoreboard_sequence( var_2, var_2, undefined );
            }
        }
    }
}

podium_scoreboard_sequence( var_0, var_1, var_2 )
{
    level waittill( "scoreboard_displaying" );
    wait 0.01;

    if ( isdefined( var_2 ) )
    {
        self spawn( var_0.origin, var_0.angles );
        maps\mp\_utility::_ID34608( "playing" );
        var_3 = spawn( "script_model", var_1.origin );
        var_3 setmodel( "tag_origin" );
        var_3.angles = var_1.angles;
        self cameralinkto( var_3, "tag_origin" );
        self._ID24978 = undefined;
    }
    else if ( !isbot( self ) )
        thread spawn_custom_spectator( var_0 );

    self setdepthoffield( 0, 0, 512, 512, 4, 0 );
}

spawn_custom_spectator( var_0 )
{
    maps\mp\_utility::clearkillcamstate();
    self._ID13681 = undefined;
    self setspectatedefaults( var_0.origin, var_0.angles );
    self spawn( var_0.origin, var_0.angles );
    maps\mp\_utility::_ID34608( "playing" );
    maps\mp\_utility::_ID13582( 1 );
    self playerhide();
    self cameralinkto( var_0, "tag_origin" );
    self setdepthoffield( 0, 0, 512, 512, 4, 0 );
    maps\mp\_utility::_ID26201( 0 );
}

clean_up_podium_scene()
{
    var_0 = getent( "trap_1_volume", "targetname" );
    var_1 = getentarray( "script_vehicle", "classname" );

    foreach ( var_3 in var_1 )
        var_3 delete();
}

get_prize_room_curtains_n_fx()
{
    wait 5;

    foreach ( var_1 in getscriptablearray( "prize_curtains", "targetname" ) )
        var_1 thread prize_room_curtains();

    thread prize_room_fx();
}

prize_room_curtains()
{
    var_0 = getent( "prize_display_clip", "targetname" );

    for (;;)
    {
        self setscriptablepartstate( 0, "curtain_closed" );
        wait 40;
        self setscriptablepartstate( 0, "curtain_open" );
        var_0 movez( -400, 0.1 );
        wait 15;
        self setscriptablepartstate( 0, "curtain_close" );
        var_0 movez( 400, 0.1 );
        wait 5;
    }
}

prize_room_fx()
{
    for (;;)
    {
        wait 40;
        common_scripts\utility::exploder( 60 );
        thread red_and_blue_fx_lights();
        thread white_fx_lights();
        thread flashing_neon_sign();
        thread common_scripts\utility::_ID23839( "emt_prize_curtains_open", ( 547, 1035, 305 ) );
        var_0 = common_scripts\utility::_ID23798( "emt_prize_bells", ( 547, 1035, 305 ) );
        wait 15;
        thread common_scripts\utility::_ID23839( "emt_prize_curtains_close", ( 547, 1035, 305 ) );
        var_0 stoploopsound();
        wait 5;
    }
}

red_and_blue_fx_lights()
{
    for ( var_0 = 0; var_0 < 8; var_0++ )
    {
        common_scripts\utility::exploder( 61 );
        wait 1;
        common_scripts\utility::exploder( 62 );
        wait 1;
    }
}

white_fx_lights()
{
    for ( var_0 = 0; var_0 < 8; var_0++ )
    {
        common_scripts\utility::exploder( 63 );
        wait 0.5;
        common_scripts\utility::exploder( 64 );
        wait 0.5;
        common_scripts\utility::exploder( 65 );
        wait 0.5;
        common_scripts\utility::exploder( 66 );
        wait 0.5;
    }
}

flashing_neon_sign()
{
    var_0 = [];
    var_1 = [];
    var_2 = 1;
    var_0 = get_neon_sign( "neon_winner_sign_" );
    var_1 = get_neon_sign( "neon_winner_sign_off_" );
    var_3 = get_neon_sign( "neon_winner_sign_right_" );
    var_4 = get_neon_sign( "neon_winner_sign_right_off_" );
    var_5 = gettime();

    while ( gettime() < var_5 + 15000 )
    {
        for ( var_6 = 0; var_6 < 4; var_6++ )
        {
            for ( var_7 = 0; var_7 < var_0.size; var_7++ )
            {
                var_0[var_7] hide();
                var_3[var_7] hide();
                var_1[var_7] show();
                var_4[var_7] show();
                wait 0.05;
                var_1[var_7] hide();
                var_4[var_7] hide();
                var_0[var_7] show();
                var_3[var_7] show();
            }
        }

        for ( var_6 = 0; var_6 < 3; var_6++ )
        {
            for ( var_7 = 0; var_7 < var_0.size; var_7++ )
            {
                var_1[var_7] hide();
                var_4[var_7] hide();
                var_0[var_7] show();
                var_3[var_7] show();
            }

            wait 0.4;

            for ( var_7 = 0; var_7 < var_0.size; var_7++ )
            {
                var_0[var_7] hide();
                var_3[var_7] hide();
                var_1[var_7] show();
                var_4[var_7] show();
            }

            wait 0.4;
        }
    }

    foreach ( var_9 in var_0 )
        var_9 hide();

    foreach ( var_9 in var_3 )
        var_9 hide();

    foreach ( var_9 in var_1 )
        var_9 show();

    foreach ( var_9 in var_4 )
        var_9 show();
}

get_neon_sign( var_0 )
{
    var_1 = [];
    var_2 = 1;

    for (;;)
    {
        var_3 = getent( var_0 + var_2, "targetname" );

        if ( isdefined( var_3 ) )
        {
            var_1[var_2 - 1] = var_3;
            var_2++;
            continue;
        }

        break;
    }

    return var_1;
}

get_elevators()
{
    wait 5;
    var_0 = [ "periph_elevator_NE", "periph_elevator_NW", "periph_elevator_SE", "periph_elevator_SW" ];

    foreach ( var_2 in var_0 )
    {
        foreach ( var_4 in getentarray( var_2, "targetname" ) )
            var_4 thread move_elevators();
    }
}

move_elevators()
{
    for (;;)
    {
        self movez( -448, 8, 2, 4 );
        wait(randomintrange( 10, 17 ));
        self movez( 448, 8, 3, 3 );
        wait(randomintrange( 10, 13 ));
    }
}

move_podium_camera()
{
    self moveto( ( 122, 1006, 300 ), 15, 1, 12 );
    self rotateby( ( 90, 90, 90 ), 3.0, 0.5, 0.5 );
}

create_overlay( var_0, var_1 )
{
    var_2 = newhudelem();
    var_2.x = 0;
    var_2.y = 0;
    var_2 setshader( var_0, 640, 480 );
    var_2.alignx = "left";
    var_2.aligny = "top";
    var_2.sort = 1;
    var_2.horzalign = "fullscreen";
    var_2.vertalign = "fullscreen";
    var_2.alpha = var_1;
    var_2.foreground = 1;
    return var_2;
}

_ID12615( var_0, var_1 )
{
    if ( isdefined( var_1 ) && var_1 > 0 )
        self fadeovertime( var_1 );

    self.alpha = var_0;

    if ( isdefined( var_1 ) && var_1 > 0 )
        wait(var_1);
}

hud_delete( var_0 )
{
    self endon( "death" );
    wait(var_0);
    self destroy();
}

turret_box_light_fx()
{
    level endon( "game_ended" );

    foreach ( var_1 in level.players )
    {
        if ( var_1.pers["team"] == level.turret_team )
        {
            thread looped_turret_light( 15, 16, var_1 );
            continue;
        }

        thread looped_turret_light( 16, 15, var_1 );
    }
}

looped_turret_light( var_0, var_1, var_2 )
{
    var_3 = gettime() + 15000;

    while ( gettime() < var_3 )
    {
        if ( !var_2 maps\mp\_utility::_ID18658() )
            activateclientexploder( var_0, var_2 );
        else
            activateclientexploder( var_1, var_2 );

        wait 1.0;
    }
}

sfx_gate_alarm( var_0 )
{

}

sfx_lights_red()
{
    playsoundatpos( ( -277, 754, 326 ), "scn_shp_gate_red" );
    playsoundatpos( ( -764, 311, 326 ), "scn_shp_gate_red" );
    playsoundatpos( ( -769, -255, 326 ), "scn_shp_gate_red" );
    playsoundatpos( ( -247, -642, 326 ), "scn_shp_gate_red" );
    playsoundatpos( ( 355, -642, 326 ), "scn_shp_gate_red" );
    playsoundatpos( ( 744, -139, 326 ), "scn_shp_gate_red" );
    playsoundatpos( ( 740, 329, 326 ), "scn_shp_gate_red" );
    playsoundatpos( ( 281, 757, 326 ), "scn_shp_gate_red" );
    playsoundatpos( ( 2, 45, 450 ), "scn_shp_gate_red_wet" );
}

sfx_lights_green()
{
    playsoundatpos( ( -277, 754, 326 ), "scn_shp_gate_green" );
    playsoundatpos( ( -764, 311, 326 ), "scn_shp_gate_green" );
    playsoundatpos( ( -769, -255, 326 ), "scn_shp_gate_green" );
    playsoundatpos( ( -247, -642, 326 ), "scn_shp_gate_green" );
    playsoundatpos( ( 355, -642, 326 ), "scn_shp_gate_green" );
    playsoundatpos( ( 744, -139, 326 ), "scn_shp_gate_green" );
    playsoundatpos( ( 740, 329, 326 ), "scn_shp_gate_green" );
    playsoundatpos( ( 281, 757, 326 ), "scn_shp_gate_green" );
    playsoundatpos( ( 2, 45, 450 ), "scn_shp_gate_green_wet" );
}

sfx_gates_open()
{
    playsoundatpos( ( -277, 754, 250 ), "scn_shp_gate_open_01" );
    playsoundatpos( ( -764, 311, 250 ), "scn_shp_gate_open_02" );
    playsoundatpos( ( -769, -255, 250 ), "scn_shp_gate_open_01" );
    playsoundatpos( ( -247, -642, 250 ), "scn_shp_gate_open_02" );
    playsoundatpos( ( 355, -642, 250 ), "scn_shp_gate_open_01" );
    playsoundatpos( ( 744, -139, 250 ), "scn_shp_gate_open_02" );
    playsoundatpos( ( 740, 329, 250 ), "scn_shp_gate_open_01" );
    playsoundatpos( ( 281, 757, 250 ), "scn_shp_gate_open_02" );
}

sfx_turret_shutters_open()
{
    playsoundatpos( ( 305, -176, 250 ), "scn_shp_turret_door_open" );
    playsoundatpos( ( -18, -378, 250 ), "scn_shp_turret_door_open" );
    playsoundatpos( ( -315, -199, 250 ), "scn_shp_turret_door_open" );
    playsoundatpos( ( -306, 322, 250 ), "scn_shp_turret_door_open" );
    playsoundatpos( ( 312, 318, 250 ), "scn_shp_turret_door_open" );
    playsoundatpos( ( 524, 87, 250 ), "scn_shp_turret_door_open" );
}

sfx_turret_shutters_close()
{
    playsoundatpos( ( 305, -176, 250 ), "scn_shp_turret_door_close" );
    playsoundatpos( ( -18, -378, 250 ), "scn_shp_turret_door_close" );
    playsoundatpos( ( -315, -199, 250 ), "scn_shp_turret_door_close" );
    playsoundatpos( ( -306, 322, 250 ), "scn_shp_turret_door_close" );
    playsoundatpos( ( 312, 318, 250 ), "scn_shp_turret_door_close" );
    playsoundatpos( ( 524, 87, 250 ), "scn_shp_turret_door_close" );
}

nukedeathvision()
{
    level._ID22379 = "aftermath_mp_shipment_ns";
    setexpfog( 512, 4097, 0.578828, 0.802656, 1, 0.75, 0.75, 5, 0.382813, 0.350569, 0.293091, 3, ( 1, -0.109979, 0.267867 ), 0, 80, 1, 0.179688, 26, 180 );
    visionsetnaked( level._ID22379, 5 );
    visionsetpain( level._ID22379 );
}
