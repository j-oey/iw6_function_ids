// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

initalienanims()
{
    level.alienanimdata = spawnstruct();
    initaliencannedtraverses( level.alienanimdata );
    _ID17883( level.alienanimdata );
    _ID17884( level.alienanimdata );
    initaliendeath( level.alienanimdata );
    _ID17974();
    level.alienanimdata._ID19011 = 107.659;
    level.alienanimdata._ID31858 = 99.4488;
}

calculateanimdata()
{
    _ID6440();
    calculate_stopsoonnotifydist();
}

_ID6440()
{
    iprintln( "level.alienAnimData.jumpLaunchArrival_maxMoveDelta = " + calculate_maxmovedeltainanimstate( "jump_launch_arrival" ) );
}

calculate_stopsoonnotifydist()
{
    iprintln( "level.alienAnimData.stopSoon_NotifyDist = " + calculate_maxmovedeltainanimstate( "run_stop" ) );
}

calculate_maxmovedeltainanimstate( var_0 )
{
    var_1 = 0;
    var_2 = self getanimentrycount( var_0 );

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = self getanimentry( var_0, var_3 );
        var_5 = getmovedelta( var_4, 0, 1 );
        var_6 = lengthsquared( var_5 );

        if ( var_6 > var_1 )
            var_1 = var_6;
    }

    return sqrt( var_1 );
}

initaliencannedtraverses( var_0 )
{
    var_0.cannedtraverseanims = [];
    var_0.cannedtraverseanims["alien_crawl_door"] = _ID25719( "traverse_group_1", [ 0 ], 0 );
    var_0.cannedtraverseanims["alien_jump_sidewall_l"] = _ID25719( "traverse_group_1", [ 1 ], 0 );
    var_0.cannedtraverseanims["alien_jump_sidewall_r"] = _ID25719( "traverse_group_1", [ 2 ], 0 );
    var_0.cannedtraverseanims["alien_leap_clear_height_54"] = _ID25719( "traverse_group_1", [ 3 ], 0 );
    var_0.cannedtraverseanims["alien_drone_traverse_corner_wall_crawl"] = _ID25719( "traverse_group_1", [ 4 ], 0 );
    var_0.cannedtraverseanims["alien_leap_clear_height_36"] = _ID25719( "traverse_group_1", [ 5 ], 0 );
    var_0.cannedtraverseanims["alien_leap_tree"] = _ID25719( "traverse_group_1", [ 6 ], 0 );
    var_0.cannedtraverseanims["alien_crawl_under_car"] = _ID25719( "traverse_group_1", [ 7 ], 0 );
    var_0.cannedtraverseanims["alien_crawl_on_car"] = _ID25719( "traverse_group_1", [ 8 ], 0 );
    var_0.cannedtraverseanims["alien_step_up_56"] = _ID25719( "traverse_group_1", [ 9 ], 0 );
    var_0.cannedtraverseanims["alien_step_down_56"] = _ID25719( "traverse_group_1", [ 10 ], 0 );
    var_0.cannedtraverseanims["alien_crawl_deadtree"] = _ID25719( "traverse_group_1", [ 11 ], 0 );
    var_0.cannedtraverseanims["alien_crawl_back_humvee"] = _ID25719( "traverse_group_1", [ 12 ], 0 );
    var_0.cannedtraverseanims["alien_crawl_car"] = _ID25719( "traverse_group_1", [ 13 ], 0 );
    var_0.cannedtraverseanims["alien_crawl_humvee"] = _ID25719( "traverse_group_1", [ 14 ], 0 );
    var_0.cannedtraverseanims["alien_crawl_sidecar"] = _ID25719( "traverse_group_1", [ 15 ], 0 );
    var_0.cannedtraverseanims["alien_crawl_sidehumvee"] = _ID25719( "traverse_group_1", [ 16 ], 0 );
    var_0.cannedtraverseanims["alien_under_fence"] = _ID25719( "traverse_group_1", [ 17, 24 ], 0 );
    var_0.cannedtraverseanims["alien_climb_up_spiral_tree"] = _ID25719( "traverse_group_1", [ 18 ], 1 );
    var_0.cannedtraverseanims["alien_climb_up_gutter_L"] = _ID25719( "traverse_group_1", [ 19 ], 0 );
    var_0.cannedtraverseanims["alien_climb_up_gutter_R"] = _ID25719( "traverse_group_1", [ 20 ], 0 );
    var_0.cannedtraverseanims["alien_climb_over_fence_112"] = _ID25719( "traverse_group_1", [ 21, 22, 23 ], 0 );
    var_0.cannedtraverseanims["alien_mantle_36"] = _ID25719( "traverse_group_2", [ 0 ], 0, 1 );
    var_0.cannedtraverseanims["alien_drone_traverse_climb_vault_8"] = _ID25719( "traverse_group_2", [ 1 ], 0, 1 );
    var_0.cannedtraverseanims["alien_drone_traverse_climb_over_fence"] = _ID25719( "traverse_group_2", [ 2 ], 0, 1 );
    var_0.cannedtraverseanims["alien_crawl_rail_vault_lodge"] = _ID25719( "traverse_group_2", [ 3 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_rail_lodge"] = _ID25719( "traverse_group_2", [ 4 ], 0, 0 );
    var_0.cannedtraverseanims["alien_roof_to_ceiling"] = _ID25719( "traverse_group_2", [ 5 ], 0, 1 );
    var_0.cannedtraverseanims["alien_climb_over_fence_88"] = _ID25719( "traverse_group_2", [ 6 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_down_100"] = _ID25719( "traverse_group_2", [ 7 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_down_200"] = _ID25719( "traverse_group_2", [ 8 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_up_70"] = _ID25719( "traverse_group_2", [ 9 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_up_200"] = _ID25719( "traverse_group_2", [ 10 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_down_straight"] = _ID25719( "traverse_group_2", [ 11 ], 0, 1 );
    var_0.cannedtraverseanims["alien_roof_to_ground"] = _ID25719( "traverse_group_2", [ 12 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_up_128_rail_32"] = _ID25719( "traverse_group_2", [ 13 ], 0, 0 );
    var_0.cannedtraverseanims["alien_jump_up_128_rail_36"] = _ID25719( "traverse_group_2", [ 14 ], 0, 0 );
    var_0.cannedtraverseanims["alien_jump_up_128_rail_48"] = _ID25719( "traverse_group_2", [ 15 ], 0, 0 );
    var_0.cannedtraverseanims["alien_climb_up_rail_32_idle"] = _ID25719( "traverse_group_2", [ 16 ], 0, 1 );
    var_0.cannedtraverseanims["alien_climb_up_rail_32_run"] = _ID25719( "traverse_group_2", [ 17 ], 0, 1 );
    var_0.cannedtraverseanims["alien_mantle_32"] = _ID25719( "traverse_group_2", [ 18 ], 0, 1 );
    var_0.cannedtraverseanims["alien_mantle_48"] = _ID25719( "traverse_group_2", [ 19 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_down_128_rail_32"] = _ID25719( "traverse_group_2", [ 20 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_down_128_rail_36"] = _ID25719( "traverse_group_2", [ 21 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_down_128_rail_48"] = _ID25719( "traverse_group_2", [ 22 ], 0, 1 );
    var_0.cannedtraverseanims["alien_climb_down_128_rail_36"] = _ID25719( "traverse_group_2", [ 23 ], 1, 1 );
    var_0.cannedtraverseanims["alien_mantle_crate_48"] = _ID25719( "traverse_group_2", [ 24 ], 0, 1 );
    var_0.cannedtraverseanims["alien_mantle_crate_64"] = _ID25719( "traverse_group_2", [ 25 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_down_56_idle"] = _ID25719( "traverse_group_2", [ 26 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_down_56_run"] = _ID25719( "traverse_group_2", [ 27 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_up_56_idle"] = _ID25719( "traverse_group_2", [ 28 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_up_56_run"] = _ID25719( "traverse_group_2", [ 29 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_fence_88_enter_scale"] = _ID25719( "traverse_group_2", [ 30 ], 0, 0 );
    var_0.cannedtraverseanims["alien_jump_fence_88_exit_scale"] = _ID25719( "traverse_group_2", [ 31 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_up_90_rail_32"] = _ID25719( "traverse_group_3", [ 0 ], 0, 0 );
    var_0.cannedtraverseanims["alien_jump_fence_high_to_low"] = _ID25719( "traverse_group_3", [ 1 ], 0, 0 );
    var_0.cannedtraverseanims["alien_jump_fence_low_to_high"] = _ID25719( "traverse_group_3", [ 2 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_down_straight_forward_56"] = _ID25719( "traverse_group_3", [ 3 ], 0, 1 );
    var_0.cannedtraverseanims["alien_jump_down_straight_360_dlc"] = _ID25719( "traverse_group_3", [ 4 ], 0, 1 );
    var_0.cannedtraverseanims["alien_rail_32_jump_down_idle_dlc"] = _ID25719( "traverse_group_3", [ 5 ], 0, 1 );
    var_0.cannedtraverseanims["alien_rail_36_jump_down_idle_dlc"] = _ID25719( "traverse_group_3", [ 6 ], 0, 1 );
    var_0.cannedtraverseanims["alien_rail_48_jump_down_idle_dlc"] = _ID25719( "traverse_group_3", [ 7 ], 0, 1 );
    var_0.cannedtraverseanims["alien_climb_up"] = _ID25719( "traverse_climb_up" );
    var_0.cannedtraverseanims["alien_climb_down"] = _ID25719( "traverse_climb_down" );
    var_0.cannedtraverseanims["alien_climb_up_over_56"] = _ID25719( "traverse_climb_up_over_56" );
    var_0.cannedtraverseanims["alien_climb_over_56_down"] = _ID25719( "traverse_climb_over_56_down" );
    var_0.cannedtraverseanims["climb_up_end_jump_side_l"] = _ID25719( "climb_up_end_jump_side_l" );
    var_0.cannedtraverseanims["climb_up_end_jump_side_r"] = _ID25719( "climb_up_end_jump_side_r" );
    var_0.cannedtraverseanims["alien_climb_up_ledge_18_run"] = _ID25719( "traverse_climb_up_ledge_18_run" );
    var_0.cannedtraverseanims["alien_climb_up_ledge_18_idle"] = _ID25719( "traverse_climb_up_ledge_18_idle" );
    var_0.cannedtraverseanims["alien_wall_run"] = _ID25719( "run" );
}

_ID17883( var_0 )
{
    level.alienanimdata._ID19008 = 907.029;
    level.alienanimdata._ID19013 = 16.8476;
    level.alienanimdata._ID19014 = 0.111111;
    level.alienanimdata._ID19012 = [];
    level.alienanimdata._ID19012["jump_launch_up"] = [];
    level.alienanimdata._ID19012["jump_launch_level"] = [];
    level.alienanimdata._ID19012["jump_launch_down"] = [];
    level.alienanimdata._ID19012["jump_launch_up"][0] = ( 0.338726, 0, 0.940885 );
    level.alienanimdata._ID19012["jump_launch_up"][1] = ( 0.688542, 0, 0.725196 );
    level.alienanimdata._ID19012["jump_launch_up"][2] = ( 0.906517, 0, 0.422169 );
    level.alienanimdata._ID19012["jump_launch_level"][0] = ( 0.248516, 0, 0.968628 );
    level.alienanimdata._ID19012["jump_launch_level"][1] = ( 0.579155, 0, 0.815218 );
    level.alienanimdata._ID19012["jump_launch_level"][2] = ( 0.906514, 0, 0.422177 );
    level.alienanimdata._ID19012["jump_launch_down"][0] = ( 0.333125, 0, 0.942883 );
    level.alienanimdata._ID19012["jump_launch_down"][1] = ( 0.518112, 0, 0.855313 );
    level.alienanimdata._ID19012["jump_launch_down"][2] = ( 0.892489, 0, 0.451068 );
    level.alienanimdata.inairanimentry = [];
    level.alienanimdata.inairanimentry["jump_launch_up"] = [];
    level.alienanimdata.inairanimentry["jump_launch_level"] = [];
    level.alienanimdata.inairanimentry["jump_launch_down"] = [];
    level.alienanimdata.inairanimentry["jump_launch_up"]["jump_land_up"] = 0;
    level.alienanimdata.inairanimentry["jump_launch_up"]["jump_land_level"] = 1;
    level.alienanimdata.inairanimentry["jump_launch_up"]["jump_land_down"] = 2;
    level.alienanimdata.inairanimentry["jump_launch_level"]["jump_land_up"] = 3;
    level.alienanimdata.inairanimentry["jump_launch_level"]["jump_land_level"] = 4;
    level.alienanimdata.inairanimentry["jump_launch_level"]["jump_land_down"] = 5;
    level.alienanimdata.inairanimentry["jump_launch_down"]["jump_land_up"] = 6;
    level.alienanimdata.inairanimentry["jump_launch_down"]["jump_land_level"] = 7;
    level.alienanimdata.inairanimentry["jump_launch_down"]["jump_land_down"] = 8;
    level.alienanimdata.inairanimentry["jump_launch_up"]["jump_land_sidewall_high"] = 9;
    level.alienanimdata.inairanimentry["jump_launch_level"]["jump_land_sidewall_high"] = 9;
    level.alienanimdata.inairanimentry["jump_launch_down"]["jump_land_sidewall_high"] = 9;
    level.alienanimdata.inairanimentry["jump_launch_up"]["jump_land_sidewall_low"] = 9;
    level.alienanimdata.inairanimentry["jump_launch_level"]["jump_land_sidewall_low"] = 9;
    level.alienanimdata.inairanimentry["jump_launch_down"]["jump_land_sidewall_low"] = 9;
}

_ID17884( var_0 )
{
    var_0._ID23217 = [];
    var_1 = [];
    var_1["front"]["head"] = [ 0 ];
    var_1["front"]["up_chest"] = [ 1 ];
    var_1["front"]["low_chest"] = [ 1 ];
    var_1["front"]["up_body_L"] = [ 1 ];
    var_1["front"]["up_body_R"] = [ 2 ];
    var_1["front"]["low_body_L"] = [ 2 ];
    var_1["front"]["low_body_R"] = [ 2 ];
    var_1["front"]["armor"] = [ 0 ];
    var_1["front"]["soft"] = [ 0 ];
    var_1["right"]["head"] = [ 0 ];
    var_1["right"]["up_chest"] = [ 3 ];
    var_1["right"]["low_chest"] = [ 3 ];
    var_1["right"]["up_body_L"] = [ 3 ];
    var_1["right"]["up_body_R"] = [ 2 ];
    var_1["right"]["low_body_L"] = [ 4 ];
    var_1["right"]["low_body_R"] = [ 4 ];
    var_1["right"]["armor"] = [ 0 ];
    var_1["right"]["soft"] = [ 0 ];
    var_1["left"]["head"] = [ 0 ];
    var_1["left"]["up_chest"] = [ 1 ];
    var_1["left"]["low_chest"] = [ 1 ];
    var_1["left"]["up_body_L"] = [ 5 ];
    var_1["left"]["up_body_R"] = [ 5 ];
    var_1["left"]["low_body_L"] = [ 6 ];
    var_1["left"]["low_body_R"] = [ 6 ];
    var_1["left"]["armor"] = [ 2 ];
    var_1["left"]["soft"] = [ 2 ];
    var_1["back"]["head"] = [ 0 ];
    var_1["back"]["up_chest"] = [ 1 ];
    var_1["back"]["low_chest"] = [ 1 ];
    var_1["back"]["up_body_L"] = [ 1 ];
    var_1["back"]["up_body_R"] = [ 7 ];
    var_1["back"]["low_body_L"] = [ 7 ];
    var_1["back"]["low_body_R"] = [ 7 ];
    var_1["back"]["armor"] = [ 0 ];
    var_1["back"]["soft"] = [ 0 ];
    var_0._ID23217["idle"] = var_1;
    var_2 = [];
    var_2["front"]["head"] = [ 0 ];
    var_2["front"]["up_chest"] = [ 9 ];
    var_2["front"]["low_chest"] = [ 8 ];
    var_2["front"]["up_body_L"] = [ 8 ];
    var_2["front"]["up_body_R"] = [ 9 ];
    var_2["front"]["low_body_L"] = [ 10 ];
    var_2["front"]["low_body_R"] = [ 10 ];
    var_2["front"]["armor"] = [ 0 ];
    var_2["front"]["soft"] = [ 0 ];
    var_2["right"]["head"] = [ 7 ];
    var_2["right"]["up_chest"] = [ 7 ];
    var_2["right"]["low_chest"] = [ 11 ];
    var_2["right"]["up_body_L"] = [ 7 ];
    var_2["right"]["up_body_R"] = [ 7 ];
    var_2["right"]["low_body_L"] = [ 11 ];
    var_2["right"]["low_body_R"] = [ 11 ];
    var_2["right"]["armor"] = [ 0 ];
    var_2["right"]["soft"] = [ 0 ];
    var_2["left"]["head"] = [ 5 ];
    var_2["left"]["up_chest"] = [ 5 ];
    var_2["left"]["low_chest"] = [ 6 ];
    var_2["left"]["up_body_L"] = [ 5 ];
    var_2["left"]["up_body_R"] = [ 5 ];
    var_2["left"]["low_body_L"] = [ 6 ];
    var_2["left"]["low_body_R"] = [ 6 ];
    var_2["left"]["armor"] = [ 0 ];
    var_2["left"]["soft"] = [ 0 ];
    var_2["back"]["head"] = [ 12 ];
    var_2["back"]["up_chest"] = [ 12 ];
    var_2["back"]["low_chest"] = [ 13 ];
    var_2["back"]["up_body_L"] = [ 12 ];
    var_2["back"]["up_body_R"] = [ 12 ];
    var_2["back"]["low_body_L"] = [ 13 ];
    var_2["back"]["low_body_R"] = [ 13 ];
    var_2["back"]["armor"] = [ 0 ];
    var_2["back"]["soft"] = [ 0 ];
    var_0._ID23217["run"] = var_2;
    var_3 = [];
    var_3["front"]["head"] = [ 0 ];
    var_3["front"]["up_chest"] = [ 1 ];
    var_3["front"]["low_chest"] = [ 1 ];
    var_3["front"]["up_body_L"] = [ 2 ];
    var_3["front"]["up_body_R"] = [ 3 ];
    var_3["front"]["low_body_L"] = [ 4 ];
    var_3["front"]["low_body_R"] = [ 4 ];
    var_3["front"]["armor"] = [ 0 ];
    var_3["front"]["soft"] = [ 0 ];
    var_3["right"]["head"] = [ 7 ];
    var_3["right"]["up_chest"] = [ 7 ];
    var_3["right"]["low_chest"] = [ 8 ];
    var_3["right"]["up_body_L"] = [ 7 ];
    var_3["right"]["up_body_R"] = [ 7 ];
    var_3["right"]["low_body_L"] = [ 8 ];
    var_3["right"]["low_body_R"] = [ 8 ];
    var_3["right"]["armor"] = [ 0 ];
    var_3["right"]["soft"] = [ 0 ];
    var_3["left"]["head"] = [ 5 ];
    var_3["left"]["up_chest"] = [ 5 ];
    var_3["left"]["low_chest"] = [ 6 ];
    var_3["left"]["up_body_L"] = [ 5 ];
    var_3["left"]["up_body_R"] = [ 5 ];
    var_3["left"]["low_body_L"] = [ 6 ];
    var_3["left"]["low_body_R"] = [ 6 ];
    var_3["left"]["armor"] = [ 0 ];
    var_3["left"]["soft"] = [ 0 ];
    var_3["back"]["head"] = [ 9 ];
    var_3["back"]["up_chest"] = [ 9 ];
    var_3["back"]["low_chest"] = [ 10 ];
    var_3["back"]["up_body_L"] = [ 9 ];
    var_3["back"]["up_body_R"] = [ 9 ];
    var_3["back"]["low_body_L"] = [ 10 ];
    var_3["back"]["low_body_R"] = [ 10 ];
    var_3["back"]["armor"] = [ 0 ];
    var_3["back"]["soft"] = [ 0 ];
    var_0._ID23217["jump"] = var_3;
    var_4 = [];
    var_4["front"] = [ 0, 1 ];
    var_4["right"] = [ 2 ];
    var_4["left"] = [ 3 ];
    var_4["back"] = [ 4 ];
    var_0._ID23217["push_back"] = var_4;
    var_5 = [];
    var_5["front"] = [ 0 ];
    var_5["right"] = [ 0 ];
    var_5["left"] = [ 0 ];
    var_5["back"] = [ 0 ];
    var_0._ID23217["move_back"] = var_5;
    var_6 = [];
    var_6["front"] = [ 0, 1, 2 ];
    var_6["right"] = [ 0, 1, 2 ];
    var_6["left"] = [ 0, 1, 2 ];
    var_6["back"] = [ 0, 1, 2 ];
    var_0._ID23217["melee"] = var_6;
    var_7 = [];
    var_7["head"] = "head";
    var_7["neck"] = "head";
    var_7["torso_upper"] = "up_chest";
    var_7["none"] = "up_chest";
    var_7["torso_lower"] = "low_chest";
    var_7["left_arm_upper"] = "up_body_L";
    var_7["left_arm_lower"] = "up_body_L";
    var_7["left_hand"] = "up_body_L";
    var_7["right_arm_upper"] = "up_body_R";
    var_7["right_arm_lower"] = "up_body_R";
    var_7["right_hand"] = "up_body_R";
    var_7["left_leg_upper"] = "low_body_L";
    var_7["left_leg_lower"] = "low_body_L";
    var_7["left_foot"] = "low_body_L";
    var_7["right_leg_upper"] = "low_body_R";
    var_7["right_leg_lower"] = "low_body_R";
    var_7["right_foot"] = "low_body_R";
    var_7["armor"] = "armor";
    var_7["soft"] = "soft";
    var_0._ID23217["hitLoc"] = var_7;
    var_8 = [];
    var_8[0] = "back";
    var_8[1] = "back";
    var_8[2] = "right";
    var_8[3] = "right";
    var_8[4] = "front";
    var_8[5] = "left";
    var_8[6] = "left";
    var_8[7] = "back";
    var_8[8] = "back";
    var_0._ID23217["hitDirection"] = var_8;
    var_9 = [];
    var_9[0] = [ 0 ];
    var_9[1] = [ 1 ];
    var_9[2] = [ 2 ];
    var_9[3] = [ 3 ];
    var_9[4] = [ 4 ];
    var_9[5] = [ 5 ];
    var_9[6] = [ 6 ];
    var_9[7] = [ 7 ];
    var_9[8] = [ 8 ];
    var_9[9] = [ 9 ];
    var_9[10] = [ 10 ];
    var_0._ID23217["idleToImpactMap"] = var_9;
}

initaliendeath( var_0 )
{
    var_0._ID9066 = [];
    var_1 = [];
    var_1["front"]["head"] = [ 0 ];
    var_1["front"]["up_chest"] = [ 1 ];
    var_1["front"]["low_chest"] = [ 1 ];
    var_1["front"]["up_body_L"] = [ 1 ];
    var_1["front"]["up_body_R"] = [ 2 ];
    var_1["front"]["low_body_L"] = [ 2 ];
    var_1["front"]["low_body_R"] = [ 2 ];
    var_1["front"]["armor"] = [ 0 ];
    var_1["front"]["soft"] = [ 0 ];
    var_1["right"]["head"] = [ 0 ];
    var_1["right"]["up_chest"] = [ 4 ];
    var_1["right"]["low_chest"] = [ 3 ];
    var_1["right"]["up_body_L"] = [ 4 ];
    var_1["right"]["up_body_R"] = [ 4 ];
    var_1["right"]["low_body_L"] = [ 2 ];
    var_1["right"]["low_body_R"] = [ 2 ];
    var_1["right"]["armor"] = [ 0 ];
    var_1["right"]["soft"] = [ 0 ];
    var_1["left"]["head"] = [ 0 ];
    var_1["left"]["up_chest"] = [ 1 ];
    var_1["left"]["low_chest"] = [ 1 ];
    var_1["left"]["up_body_L"] = [ 1 ];
    var_1["left"]["up_body_R"] = [ 2 ];
    var_1["left"]["low_body_L"] = [ 5 ];
    var_1["left"]["low_body_R"] = [ 5 ];
    var_1["left"]["armor"] = [ 0 ];
    var_1["left"]["soft"] = [ 0 ];
    var_1["back"]["head"] = [ 0 ];
    var_1["back"]["up_chest"] = [ 1 ];
    var_1["back"]["low_chest"] = [ 1 ];
    var_1["back"]["up_body_L"] = [ 1 ];
    var_1["back"]["up_body_R"] = [ 2 ];
    var_1["back"]["low_body_L"] = [ 2 ];
    var_1["back"]["low_body_R"] = [ 2 ];
    var_1["back"]["armor"] = [ 0 ];
    var_1["back"]["soft"] = [ 0 ];
    var_0._ID9066["idle"] = var_1;
    var_2 = [];
    var_2["front"]["head"] = [ 0 ];
    var_2["front"]["up_chest"] = [ 1 ];
    var_2["front"]["low_chest"] = [ 3 ];
    var_2["front"]["up_body_L"] = [ 4 ];
    var_2["front"]["up_body_R"] = [ 9 ];
    var_2["front"]["low_body_L"] = [ 4 ];
    var_2["front"]["low_body_R"] = [ 3 ];
    var_2["front"]["armor"] = [ 0 ];
    var_2["front"]["soft"] = [ 0 ];
    var_2["right"]["head"] = [ 2 ];
    var_2["right"]["up_chest"] = [ 1 ];
    var_2["right"]["low_chest"] = [ 0 ];
    var_2["right"]["up_body_L"] = [ 7 ];
    var_2["right"]["up_body_R"] = [ 7 ];
    var_2["right"]["low_body_L"] = [ 3 ];
    var_2["right"]["low_body_R"] = [ 4 ];
    var_2["right"]["armor"] = [ 0 ];
    var_2["right"]["soft"] = [ 0 ];
    var_2["left"]["head"] = [ 5 ];
    var_2["left"]["up_chest"] = [ 5 ];
    var_2["left"]["low_chest"] = [ 6 ];
    var_2["left"]["up_body_L"] = [ 5 ];
    var_2["left"]["up_body_R"] = [ 5 ];
    var_2["left"]["low_body_L"] = [ 8 ];
    var_2["left"]["low_body_R"] = [ 6 ];
    var_2["left"]["armor"] = [ 0 ];
    var_2["left"]["soft"] = [ 0 ];
    var_2["back"]["head"] = [ 1 ];
    var_2["back"]["up_chest"] = [ 5 ];
    var_2["back"]["low_chest"] = [ 4 ];
    var_2["back"]["up_body_L"] = [ 3 ];
    var_2["back"]["up_body_R"] = [ 2 ];
    var_2["back"]["low_body_L"] = [ 1 ];
    var_2["back"]["low_body_R"] = [ 4 ];
    var_2["back"]["armor"] = [ 0 ];
    var_2["back"]["soft"] = [ 0 ];
    var_0._ID9066["run"] = var_2;
    var_3 = [];
    var_3["front"]["head"] = [ 1 ];
    var_3["front"]["up_chest"] = [ 0 ];
    var_3["front"]["low_chest"] = [ 0 ];
    var_3["front"]["up_body_L"] = [ 2 ];
    var_3["front"]["up_body_R"] = [ 3 ];
    var_3["front"]["low_body_L"] = [ 4 ];
    var_3["front"]["low_body_R"] = [ 4 ];
    var_3["front"]["armor"] = [ 1 ];
    var_3["front"]["soft"] = [ 1 ];
    var_3["right"]["head"] = [ 7 ];
    var_3["right"]["up_chest"] = [ 7 ];
    var_3["right"]["low_chest"] = [ 8 ];
    var_3["right"]["up_body_L"] = [ 7 ];
    var_3["right"]["up_body_R"] = [ 7 ];
    var_3["right"]["low_body_L"] = [ 8 ];
    var_3["right"]["low_body_R"] = [ 8 ];
    var_3["right"]["armor"] = [ 1 ];
    var_3["right"]["soft"] = [ 1 ];
    var_3["left"]["head"] = [ 5 ];
    var_3["left"]["up_chest"] = [ 5 ];
    var_3["left"]["low_chest"] = [ 6 ];
    var_3["left"]["up_body_L"] = [ 5 ];
    var_3["left"]["up_body_R"] = [ 5 ];
    var_3["left"]["low_body_L"] = [ 6 ];
    var_3["left"]["low_body_R"] = [ 6 ];
    var_3["left"]["armor"] = [ 1 ];
    var_3["left"]["soft"] = [ 1 ];
    var_3["back"]["head"] = [ 9 ];
    var_3["back"]["up_chest"] = [ 9 ];
    var_3["back"]["low_chest"] = [ 10 ];
    var_3["back"]["up_body_L"] = [ 9 ];
    var_3["back"]["up_body_R"] = [ 9 ];
    var_3["back"]["low_body_L"] = [ 10 ];
    var_3["back"]["low_body_R"] = [ 10 ];
    var_3["back"]["armor"] = [ 1 ];
    var_3["back"]["soft"] = [ 1 ];
    var_0._ID9066["jump"] = var_3;
    var_4 = [];
    var_4["head"] = "head";
    var_4["neck"] = "head";
    var_4["torso_upper"] = "up_chest";
    var_4["none"] = "up_chest";
    var_4["torso_lower"] = "low_chest";
    var_4["left_arm_upper"] = "up_body_L";
    var_4["left_arm_lower"] = "up_body_L";
    var_4["left_hand"] = "up_body_L";
    var_4["right_arm_upper"] = "up_body_R";
    var_4["right_arm_lower"] = "up_body_R";
    var_4["right_hand"] = "up_body_R";
    var_4["left_leg_upper"] = "low_body_L";
    var_4["left_leg_lower"] = "low_body_L";
    var_4["left_foot"] = "low_body_L";
    var_4["right_leg_upper"] = "low_body_R";
    var_4["right_leg_lower"] = "low_body_R";
    var_4["right_foot"] = "low_body_R";
    var_4["armor"] = "armor";
    var_4["soft"] = "soft";
    var_0._ID9066["hitLoc"] = var_4;
    var_5 = [];
    var_5[0] = "back";
    var_5[1] = "back";
    var_5[2] = "right";
    var_5[3] = "right";
    var_5[4] = "front";
    var_5[5] = "left";
    var_5[6] = "left";
    var_5[7] = "back";
    var_5[8] = "back";
    var_0._ID9066["hitDirection"] = var_5;
    var_6 = [];
    var_6["electric_shock_death"] = [ 0 ];
    var_6["traverse"] = [ 1 ];
    var_0._ID9066["special"] = var_6;
}

_ID17974()
{
    level.alienanimdata.alienmovebackanimchance[0] = 40;
    level.alienanimdata.alienmovebackanimchance[1] = 40;
    level.alienanimdata.alienmovebackanimchance[2] = 20;
}

_ID25719( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = [];
    var_6["animState"] = var_0;

    if ( isdefined( var_1 ) )
        var_6["animIndexArray"] = var_1;

    if ( isdefined( var_2 ) )
        var_6["endInOriented"] = var_2;

    if ( isdefined( var_3 ) )
        var_6["flexHeightEndAtTraverseEnd"] = var_3;

    if ( isdefined( var_4 ) )
        var_6["traverseSound"] = var_4;

    if ( isdefined( var_5 ) )
        var_6["traverseAnimScale"] = var_5;

    return var_6;
}

_ID33986( var_0 )
{
    var_1 = var_0.origin - self.origin;
    return _ID33987( var_1 );
}

_ID33987( var_0 )
{
    var_1 = getturninplaceindex( anglestoforward( self.angles ), var_0, anglestoup( self.angles ) );
    self scragentsetorientmode( "face angle abs", self.angles );

    if ( var_1 != 4 )
    {
        self.statelocked = 1;

        if ( self.oriented )
            self scragentsetanimmode( "anim angle delta" );
        else
            self scragentsetanimmode( "anim deltas" );

        var_2 = getturninplaceanimstate();
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_2, var_1, "turn_in_place", "code_move" );

        if ( !maps\mp\alien\_unk1464::is_idle_state_locked() )
            self.statelocked = 0;

        return 1;
    }

    return 0;
}

getturninplaceanimstate()
{
    if ( isdefined( level.dlc_alien_turn_in_place_anim_state_override_func ) )
    {
        var_0 = [[ level.dlc_alien_turn_in_place_anim_state_override_func ]]();

        if ( isdefined( var_0 ) )
            return var_0;
    }

    return "turn_in_place";
}

getturninplaceindex( var_0, var_1, var_2 )
{
    var_3 = undefined;
    var_4 = undefined;
    var_5 = getprojectiondata( var_0, var_1, var_2 );
    var_6 = var_5._ID26742;
    var_7 = var_5._ID25062;
    var_8 = 10;

    if ( var_7 > 0 )
        var_4 = int( ceil( ( 180 - var_6 - var_8 ) / 45 ) );
    else
        var_4 = int( floor( ( 180 + var_6 + var_8 ) / 45 ) );

    var_4 = int( clamp( var_4, 0, 8 ) );
    return var_4;
}

getprojectiondata( var_0, var_1, var_2 )
{
    var_3 = spawnstruct();
    var_4 = vectornormalize( _ID25061( var_0, var_2 ) );
    var_5 = vectornormalize( _ID25061( var_1, var_2 ) );
    var_6 = vectorcross( var_5, var_2 );
    var_7 = vectornormalize( _ID25061( var_6, var_2 ) );
    var_8 = vectordot( var_4 * -1, var_7 );
    var_9 = vectordot( var_5, var_4 );
    var_9 = clamp( var_9, -1, 1 );
    var_10 = acos( var_9 );
    var_3._ID26742 = var_10;
    var_3._ID25062 = var_8;
    return var_3;
}

_ID25061( var_0, var_1 )
{
    var_2 = vectordot( var_0, var_1 );
    var_3 = var_0 - var_1 * var_2;
    return var_3;
}

_ID23204( var_0 )
{
    return level.alienanimdata._ID23217["hitLoc"][var_0];
}

_ID23205( var_0 )
{
    var_1 = maps\mp\agents\_scriptedagents::_ID14876( var_0 );
    return level.alienanimdata._ID23217["hitDirection"][var_1];
}

_ID9054( var_0 )
{
    return level.alienanimdata._ID9066["hitLoc"][var_0];
}

death_getincomingdirection( var_0 )
{
    var_1 = maps\mp\agents\_scriptedagents::_ID14876( var_0 );
    return level.alienanimdata._ID9066["hitDirection"][var_1];
}

_ID15227( var_0, var_1, var_2 )
{
    var_3 = _ID14961( var_1, var_2 );
    return var_0 + "_" + var_3;
}

_ID14961( var_0, var_1 )
{
    var_2 = maps\mp\alien\_unk1464::_ID14264();
    var_3 = level._ID2829[var_2].attributes["heavy_damage_threshold"];

    if ( var_0 < var_3 && !var_1 )
        return "light";
    else
        return "heavy";
}

_ID15226( var_0, var_1, var_2 )
{
    var_1 = _ID23205( var_1 * -1 );

    if ( isdefined( var_2 ) )
        var_2 = _ID23204( var_2 );

    return _ID15228( var_0, var_1, var_2, level.alienanimdata._ID23217 );
}

getimpactpainanimindex( var_0 )
{
    var_1 = level.alienanimdata._ID23217["idleToImpactMap"][var_0];
    var_2 = randomintrange( 0, var_1.size );
    return var_1[var_2];
}

_ID14966( var_0, var_1 )
{
    var_2 = _ID14961( var_1, 0 );
    return var_0 + "_" + var_2;
}

getdeathanimindex( var_0, var_1, var_2 )
{
    var_1 = death_getincomingdirection( var_1 * -1 );
    var_2 = _ID9054( var_2 );
    return _ID15228( var_0, var_1, var_2, level.alienanimdata._ID9066 );
}

_ID15228( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_2 ) )
        var_4 = var_3[var_0][var_1][var_2];
    else
        var_4 = var_3[var_0][var_1];

    return var_4[randomint( var_4.size )];
}

_ID15353( var_0 )
{
    var_1 = level.alienanimdata._ID9066["special"][var_0];
    return var_1[randomint( var_1.size )];
}

resetscriptable( var_0, var_1 )
{
    var_2 = getent( var_0, "targetname" );
    var_2 setscriptablepartstate( 0, 0 );
}

playanimonscriptable( var_0, var_1, var_2 )
{
    var_3 = getent( var_0, "targetname" );

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    var_3 setscriptablepartstate( 0, var_2 );
    level notify( "scriptable",  var_0  );
}

getlerptime( var_0 )
{
    var_1 = getanimlength( var_0 );
    return min( 0.2, var_1 );
}

_ID15263( var_0, var_1, var_2, var_3 )
{
    var_4 = getanimlength( var_0 );
    var_5 = getmovedelta( var_0, 0, var_3 / var_4 );
    var_6 = rotatevector( var_5, var_2 );
    return var_1 + var_6;
}

dolerp( var_0, var_1 )
{
    self endon( "death" );
    level endon( "game_ended" );
    self scragentdoanimlerp( self.origin, var_0, var_1 );
    wait(var_1);
    self scragentsetanimmode( "anim deltas" );
}
