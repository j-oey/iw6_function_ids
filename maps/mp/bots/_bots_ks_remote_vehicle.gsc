// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID25812()
{
    while ( !isdefined( level._ID5823 ) )
        wait 0.05;

    if ( isdefined( level.bot_initialized_remote_vehicles ) )
        return;

    level._ID5660["heli_pilot"] = ( 0, 0, 350 );
    level._ID5660["heli_sniper"] = ( 0, 0, 228 );
    level.bot_ks_funcs["isUsing"]["odin_assault"] = maps\mp\_utility::_ID18837;
    level.bot_ks_funcs["isUsing"]["odin_support"] = maps\mp\_utility::_ID18837;
    level.bot_ks_funcs["isUsing"]["heli_pilot"] = maps\mp\_utility::_ID18837;
    level.bot_ks_funcs["isUsing"]["heli_sniper"] = maps\mp\killstreaks\_killstreaks::_ID18836;
    level.bot_ks_funcs["isUsing"]["switchblade_cluster"] = maps\mp\_utility::_ID18837;
    level.bot_ks_funcs["isUsing"]["vanguard"] = ::_ID18839;
    level.bot_ks_funcs["waittill_initial_goal"]["heli_pilot"] = ::heli_pilot_waittill_initial_goal;
    level.bot_ks_funcs["waittill_initial_goal"]["heli_sniper"] = ::heli_sniper_waittill_initial_goal;
    level.bot_ks_funcs["control_aiming"]["heli_pilot"] = ::_ID16637;
    level.bot_ks_funcs["control_aiming"]["heli_sniper"] = common_scripts\utility::empty_init_func;
    level.bot_ks_funcs["control_aiming"]["vanguard"] = ::_ID34849;
    level.bot_ks_funcs["control_other"]["heli_pilot"] = ::heli_pilot_monitor_flares;
    level.bot_ks_funcs["heli_pick_node"]["heli_pilot"] = ::heli_pilot_pick_node;
    level.bot_ks_funcs["heli_pick_node"]["heli_sniper"] = ::_ID16654;
    level.bot_ks_funcs["heli_pick_node"]["vanguard"] = ::vanguard_pick_node;
    level.bot_ks_funcs["heli_node_get_origin"]["heli_pilot"] = ::heli_get_node_origin;
    level.bot_ks_funcs["heli_node_get_origin"]["heli_sniper"] = ::heli_get_node_origin;
    level.bot_ks_funcs["heli_node_get_origin"]["vanguard"] = ::_ID34854;
    level.bot_ks_funcs["odin_perform_action"]["odin_assault"] = ::odin_assault_perform_action;
    level.bot_ks_funcs["odin_perform_action"]["odin_support"] = ::_ID22586;
    level.bot_ks_funcs["odin_get_target"]["odin_assault"] = ::_ID22524;
    level.bot_ks_funcs["odin_get_target"]["odin_support"] = ::_ID22585;
    var_0 = common_scripts\utility::_ID15386( "so_chopper_boss_path_struct", "script_noteworthy" );
    level.bot_heli_nodes = [];

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.script_linkname ) )
            level.bot_heli_nodes = common_scripts\utility::array_add( level.bot_heli_nodes, var_2 );
    }

    level.bot_heli_pilot_traceoffset = maps\mp\_utility::_ID15049();

    foreach ( var_5 in level.bot_heli_nodes )
    {
        var_5.vanguard_origin = var_5.origin;
        var_6 = var_5.origin + ( 0, 0, 50 );

        for ( var_5._ID34833 = 1; !_ID23024( var_6 ) && var_6[2] > var_5.origin[2] - 1000; var_6 -= ( 0, 0, 25 ) )
        {

        }

        if ( var_6[2] <= var_5.origin[2] - 1000 )
            var_5._ID34833 = 0;

        var_6 -= ( 0, 0, 50 );
        var_5.vanguard_origin = var_6;
    }

    var_8 = -99999999;

    foreach ( var_5 in level.bot_heli_nodes )
        var_8 = max( var_8, var_5.origin[2] );

    level.bot_vanguard_height_trace_size = var_8 - level.bot_map_min_z + 100;
    level._ID22557 = getweaponexplosionradius( "odin_projectile_large_rod_mp" );
    level._ID22579 = getweaponexplosionradius( "odin_projectile_small_rod_mp" );
    level.vanguard_missile_radius = getweaponexplosionradius( "remote_tank_projectile_mp" );
    level._ID16639 = getdvarfloat( "bg_bulletExplRadius" );

    while ( !isdefined( level._ID22563 ) || !isdefined( level._ID22564 ) )
        wait 0.05;

    level._ID22541 = ( level._ID22563 + level._ID22564 ) / 2;
    level._ID23140 = [];

    if ( isdefined( level.teleportgetactivepathnodezonesfunc ) )
        var_11 = [[ level.teleportgetactivepathnodezonesfunc ]]();
    else
    {
        var_11 = [];

        for ( var_12 = 0; var_12 < level._ID36588; var_12++ )
            var_11[var_11.size] = var_12;
    }

    foreach ( var_14 in var_11 )
    {
        if ( botzonegetindoorpercent( var_14 ) < 0.25 )
            level._ID23140 = common_scripts\utility::array_add( level._ID23140, var_14 );
    }

    level.bot_odin_time_to_move["recruit"] = 1.0;
    level.bot_odin_time_to_move["regular"] = 0.7;
    level.bot_odin_time_to_move["hardened"] = 0.4;
    level.bot_odin_time_to_move["veteran"] = 0.05;
    level.bot_initialized_remote_vehicles = 1;
}

bot_killstreak_remote_control( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_3 ) )
        return 0;

    var_5 = 1;
    var_6 = 1;
    var_7 = undefined;

    if ( isdefined( self._ID22077 ) )
    {
        var_8 = self botgetscriptgoalradius();
        var_9 = distancesquared( self.origin, self._ID22077.origin );

        if ( var_9 < squared( var_8 ) )
        {
            var_5 = 0;
            var_6 = 0;
        }
        else if ( var_9 < squared( 200 ) )
            var_5 = 0;
    }

    var_10 = var_0._ID31889 == "vanguard" && is_indoor_map();

    if ( var_10 || var_5 )
    {
        var_11 = getnodesinradius( self.origin, 500, 0, 512 );

        if ( isdefined( var_11 ) && var_11.size > 0 )
        {
            if ( isdefined( var_4 ) && var_4 )
            {
                var_12 = var_11;
                var_11 = [];

                foreach ( var_14 in var_12 )
                {
                    if ( nodeexposedtosky( var_14 ) )
                    {
                        var_15 = getlinkednodes( var_14 );
                        var_16 = 0;

                        foreach ( var_18 in var_15 )
                        {
                            if ( nodeexposedtosky( var_18 ) )
                                var_16++;
                        }

                        if ( var_16 / var_15.size > 0.5 )
                            var_11 = common_scripts\utility::array_add( var_11, var_14 );
                    }
                }
            }

            if ( var_10 )
            {
                var_21 = self botnodescoremultiple( var_11, "node_exposed" );

                foreach ( var_14 in var_21 )
                {
                    if ( bullettracepassed( var_14.origin + ( 0, 0, 30 ), var_14.origin + ( 0, 0, 400 ), 0, self ) )
                    {
                        var_7 = var_14;
                        break;
                    }

                    wait 0.05;
                }
            }
            else if ( var_11.size > 0 )
                var_7 = self botnodepick( var_11, min( 3, var_11.size ), "node_hide" );

            if ( !isdefined( var_7 ) )
                return 0;

            self botsetscriptgoalnode( var_7, "tactical" );
        }
    }

    if ( var_6 )
    {
        var_24 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();

        if ( var_24 != "goal" )
        {
            _ID33763( var_7 );
            return 1;
        }
    }

    if ( isdefined( var_2 ) && !self [[ var_2 ]]() )
    {
        _ID33763( var_7 );
        return 0;
    }

    if ( !maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks() )
    {
        _ID33763( var_7 );
        return 1;
    }

    if ( !isdefined( var_7 ) )
    {
        if ( self getstance() == "prone" )
            self botsetstance( "prone" );
        else if ( self getstance() == "crouch" )
            self botsetstance( "crouch" );
    }
    else if ( self botgetdifficultysetting( "strategyLevel" ) > 0 )
    {
        if ( randomint( 100 ) > 50 )
            self botsetstance( "prone" );
        else
            self botsetstance( "crouch" );
    }

    maps\mp\bots\_bots_ks::bot_switch_to_killstreak_weapon( var_0, var_1, var_0.weapon );
    self.vehicle_controlling = undefined;
    self thread [[ var_3 ]]();
    thread bot_end_control_on_respawn();
    thread bot_end_control_watcher( var_7 );
    self waittill( "control_func_done" );
    return 1;
}

bot_end_control_on_respawn()
{
    self endon( "disconnect" );
    self endon( "control_func_done" );
    level endon( "game_ended" );
    self waittill( "spawned_player" );
    self notify( "control_func_done" );
}

bot_end_control_watcher( var_0 )
{
    self endon( "disconnect" );
    self waittill( "control_func_done" );
    _ID33763( var_0 );
    self botsetstance( "none" );
    self botsetscriptmove( 0, 0 );
    self botsetflag( "disable_movement", 0 );
    self botsetflag( "disable_rotation", 0 );
    self.vehicle_controlling = undefined;
}

_ID33763( var_0 )
{
    if ( isdefined( var_0 ) && self bothasscriptgoal() && isdefined( self botgetscriptgoalnode() ) && self botgetscriptgoalnode() == var_0 )
        self botclearscriptgoal();
}

bot_end_control_on_vehicle_death( var_0 )
{
    var_0 waittill( "death" );
    self notify( "control_func_done" );
}

bot_waittill_using_vehicle( var_0 )
{
    var_1 = gettime();

    while ( !self [[ level.bot_ks_funcs["isUsing"][var_0] ]]() )
    {
        wait 0.05;

        if ( gettime() - var_1 > 5000 )
            return 0;
    }

    return 1;
}

_ID5532()
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "control_func_done" );
    level endon( "game_ended" );
    childthread _ID16074();
    var_0 = bot_waittill_using_vehicle( "switchblade_cluster" );

    if ( !var_0 )
        self notify( "control_func_done" );

    thread _ID32282();
    var_1 = _ID12899( self );
    wait 0.1;
    self._ID22727 = self.maxsightdistsqrd;
    self.maxsightdistsqrd = 256000000;
    thread _ID35945();
    var_2 = undefined;
    var_3 = 0;
    var_4 = 0;
    var_5 = [];
    var_6 = undefined;
    var_7 = 0;
    var_8 = 0;
    var_9 = undefined;
    var_10 = undefined;
    var_11 = 0;
    var_12 = is_indoor_map();

    while ( self [[ level.bot_ks_funcs["isUsing"]["switchblade_cluster"] ]]() && isdefined( var_1 ) )
    {
        foreach ( var_14 in level._ID26359 )
        {
            if ( isdefined( var_14 ) && var_14.owner == self && var_14._ID36249 == "switch_blade_child_mp" )
            {
                var_15 = 1;

                foreach ( var_17 in var_5 )
                {
                    if ( var_17.rocket == var_14 )
                        var_15 = 0;
                }

                if ( var_15 )
                {
                    var_19 = spawnstruct();
                    var_19.rocket = var_14;
                    var_19.target = var_6;
                    var_6 = undefined;
                    var_5 = common_scripts\utility::array_add( var_5, var_19 );
                }
            }
        }

        for ( var_21 = 0; var_21 < var_5.size; var_21++ )
        {
            var_17 = var_5[var_21];

            if ( isdefined( var_17 ) && isdefined( var_17.rocket ) && !common_scripts\utility::array_contains( level._ID26359, var_17.rocket ) )
            {
                var_5[var_21] = var_5[var_5.size - 1];
                var_5[var_5.size - 1] = undefined;
                var_21--;
            }
        }

        if ( var_11 )
        {
            wait 0.05;
            continue;
        }

        var_22 = undefined;

        if ( isdefined( var_10 ) )
        {
            var_22 = var_10;

            if ( !isalive( var_10 ) || !self botcanseeentity( var_22 ) )
            {
                if ( !isalive( var_10 ) )
                    var_11 = 1;

                wait 0.05;
                continue;
            }
        }

        var_23 = [];

        if ( !isdefined( var_22 ) )
        {
            var_24 = bot_killstreak_get_all_outside_enemies( 0 );
            var_25 = [];

            foreach ( var_17 in var_5 )
            {
                if ( isdefined( var_17.target ) )
                    var_25 = common_scripts\utility::array_add( var_25, var_17.target );
            }

            var_24 = common_scripts\utility::array_remove_array( var_24, var_25 );

            foreach ( var_29 in var_24 )
            {
                if ( var_29 maps\mp\_utility::_hasperk( "specialty_noplayertarget" ) )
                    continue;

                if ( self botcanseeentity( var_29 ) || var_12 && common_scripts\utility::_ID36376( self geteye(), var_1.angles, var_29.origin, self botgetfovdot() ) )
                {
                    if ( !bot_body_is_dead() && distancesquared( var_29.origin, self.origin ) < 40000 )
                        continue;

                    var_23 = common_scripts\utility::array_add( var_23, var_29 );

                    if ( !isdefined( var_22 ) )
                    {
                        var_22 = var_29;
                        continue;
                    }

                    var_30 = vectornormalize( var_22.origin - var_1.origin );
                    var_31 = vectornormalize( var_29.origin - var_1.origin );
                    var_32 = anglestoforward( var_1.angles );
                    var_33 = vectordot( var_30, var_32 );
                    var_34 = vectordot( var_31, var_32 );

                    if ( var_34 > var_33 )
                        var_22 = var_29;
                }
            }
        }

        if ( isdefined( var_22 ) )
        {
            var_2 = undefined;
            var_36 = var_1.origin[2] - var_22.origin[2];
            var_37 = self botgetdifficulty();

            if ( var_37 == "recruit" )
                var_9 = var_22.origin;
            else if ( var_36 < 5000 )
                var_9 = var_22.origin;
            else if ( length( var_22 getentityvelocity() ) < 25 )
                var_9 = var_22.origin;
            else if ( gettime() - var_8 > 500 )
            {
                var_8 = gettime();
                var_38 = 3.0;

                if ( var_37 == "regular" )
                    var_38 = 1.0;

                var_9 = getpredictedentityposition( var_22, var_38 );
            }

            var_39 = _ID21146( var_1, var_9 );
            var_40 = _ID21147( var_1, var_9 );

            if ( var_40 < 30 )
                var_41 = 0.0;
            else if ( var_40 < 100 )
                var_41 = 0.15;
            else if ( var_40 < 200 )
                var_41 = 0.3;
            else if ( var_40 < 400 )
                var_41 = 0.6;
            else
                var_41 = 1.0;

            if ( var_7 )
                var_41 = min( var_41 * 3, 1.0 );

            if ( var_41 > 0 )
                self botsetscriptmove( var_39[1], 0.05, var_41, 1, 1 );
            else if ( gettime() > var_4 )
            {
                if ( var_3 < 2 )
                {
                    self botpressbutton( "attack" );
                    var_3++;
                    var_4 = gettime() + 200;

                    if ( var_37 == "regular" && var_3 == 2 || var_37 == "hardened" || var_37 == "veteran" )
                    {
                        var_42 = var_3 == 1 && var_23.size == 1;

                        if ( !var_42 )
                        {
                            var_6 = var_22;
                            var_4 += 800;
                        }
                    }
                }
                else if ( !var_7 && ( var_36 < 5000 || var_37 == "recruit" ) )
                {
                    var_7 = 1;
                    self botpressbutton( "attack" );

                    if ( var_37 == "recruit" )
                        var_10 = var_22;
                }
            }
        }
        else
        {
            if ( !isdefined( var_2 ) )
                var_2 = common_scripts\utility::_ID25350( level._ID23140 );

            var_43 = getzonenodeforindex( var_2 ).origin;

            if ( _ID21147( var_1, var_43 ) < 200 )
            {
                var_2 = common_scripts\utility::_ID25350( level._ID23140 );
                var_43 = getzonenodeforindex( var_2 ).origin;
            }

            var_39 = _ID21146( var_1, var_43 );
            self botsetscriptmove( var_39[1], 0.05, 0.75, 1, 1 );
        }

        wait 0.05;
    }

    self notify( "control_func_done" );
}

_ID21146( var_0, var_1 )
{
    var_2 = missile_find_ground_target( var_0, var_1[2] );
    var_3 = vectornormalize( var_1 - var_2 );
    return vectortoangles( var_3 );
}

_ID21147( var_0, var_1 )
{
    var_2 = missile_find_ground_target( var_0, var_1[2] );
    return distance( var_2, var_1 );
}

_ID16074()
{
    self botsetflag( "disable_rotation", 1 );
    self botsetflag( "disable_movement", 1 );
    _ID12899( self );
    self botsetflag( "disable_rotation", 0 );
    self botsetflag( "disable_movement", 0 );
}

_ID32282()
{
    self endon( "disconnect" );
    self botsetawareness( 2.5 );
    self waittill( "control_func_done" );
    self botsetawareness( 1.0 );
}

missile_find_ground_target( var_0, var_1 )
{
    var_2 = anglestoforward( var_0.angles );
    var_3 = ( var_1 - var_0.origin[2] ) / var_2[2];
    var_4 = var_0.origin + var_2 * var_3;
    return var_4;
}

_ID35945()
{
    self endon( "disconnect" );
    self waittill( "control_func_done" );
    self.maxsightdistsqrd = self._ID22727;
}

_ID12899( var_0 )
{
    for (;;)
    {
        foreach ( var_2 in level._ID26359 )
        {
            if ( isdefined( var_2 ) && var_2.owner == var_0 )
                return var_2;
        }

        wait 0.05;
    }
}

_ID34847()
{
    if ( !maps\mp\bots\_bots_ks::aerial_vehicle_allowed() )
        return 0;

    if ( maps\mp\killstreaks\_vanguard::_ID12355( self.team ) || level._ID20086.size >= 4 )
        return 0;

    if ( maps\mp\bots\_bots_ks::iskillstreakblockedforbots( "vanguard" ) )
        return 0;

    return 1;
}

_ID5656( var_0, var_1, var_2, var_3 )
{
    bot_killstreak_remote_control( var_0, var_1, var_2, var_3, 1 );
}

_ID18839()
{
    return maps\mp\_utility::_ID18837() && self.usingremote == "vanguard" && isdefined( self._ID25826 );
}

bot_control_vanguard()
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "control_func_done" );
    level endon( "game_ended" );
    var_0 = bot_waittill_using_vehicle( "vanguard" );

    if ( !var_0 )
        self notify( "control_func_done" );

    self.vehicle_controlling = self._ID25826;
    childthread bot_end_control_on_vehicle_death( self.vehicle_controlling );
    self.vehicle_controlling endon( "death" );
    wait 0.5;
    var_1 = 0;
    var_2 = !self.vehicle_controlling _ID34857();
    var_3 = undefined;
    var_4 = 0;
    var_5 = is_indoor_map();

    while ( var_2 && !var_5 )
    {
        var_6 = getnodesinradiussorted( self.vehicle_controlling.origin, 1024, 64, 512, "path" );

        if ( isdefined( var_3 ) )
            var_6 = common_scripts\utility::array_remove( var_6, var_3 );

        foreach ( var_8 in var_6 )
        {
            if ( node_is_valid_outside_for_vanguard( var_8 ) )
            {
                var_3 = var_8;
                break;
            }

            wait 0.05;
            var_1 += 0.05;
        }

        if ( var_1 < 1.0 )
            wait(1.0 - var_1);

        if ( !isdefined( var_3 ) )
        {
            self botpressbutton( "use", 4.0 );
            wait 4.0;
        }

        var_10 = maps\mp\bots\_bots_util::bot_queued_process( "GetNodesOnPathVanguard", maps\mp\bots\_bots_util::func_get_nodes_on_path, self.vehicle_controlling.origin, var_3.origin );

        if ( !isdefined( var_10 ) )
        {
            if ( var_4 == 0 )
            {
                var_4++;
                wait 0.05;
                continue;
            }
            else
            {
                self botpressbutton( "use", 4.0 );
                wait 4.0;
            }
        }

        for ( var_11 = 0; var_11 < var_10.size; var_11++ )
        {
            var_12 = var_10[var_11];

            if ( var_11 == 0 && distancesquared( self.origin, var_12.origin ) < 1600 )
                continue;

            var_13 = 32;

            if ( var_11 == var_10.size - 1 )
                var_13 = 16;

            var_14 = self.vehicle_controlling.origin;
            var_15 = gettime() + 2500;

            while ( distance2dsquared( var_12.origin, self.vehicle_controlling.origin ) > var_13 * var_13 )
            {
                if ( self.vehicle_controlling _ID34857() )
                {
                    var_11 = var_10.size;
                    break;
                }

                if ( gettime() > var_15 )
                {
                    var_15 = gettime() + 2500;
                    var_16 = distancesquared( self.vehicle_controlling.origin, var_14 );

                    if ( var_16 < 1.0 )
                    {
                        var_11++;
                        break;
                    }

                    var_14 = self.vehicle_controlling.origin;
                }

                var_17 = vectornormalize( var_12.origin - self.vehicle_controlling.origin );
                self botsetscriptmove( vectortoangles( var_17 )[1], 0.2 );
                self botlookatpoint( var_12.origin, 0.2, "script_forced" );
                var_18 = var_12.origin[2] + 64;
                var_19 = var_18 - self.vehicle_controlling.origin[2];

                if ( var_19 > 10 )
                    self botpressbutton( "lethal" );
                else if ( var_19 < -10 )
                    self botpressbutton( "tactical" );

                wait 0.05;
            }
        }

        var_2 = 0;

        if ( !self.vehicle_controlling _ID34857() )
            var_2 = 1;
    }

    self botsetscriptmove( 0, 0 );
    self botlookatpoint( undefined );
    self childthread [[ level.bot_ks_funcs["control_aiming"]["vanguard"] ]]();
    var_21 = self.vehicle_controlling.origin[2];
    var_22 = undefined;
    var_23 = gettime() + 2000;
    var_24 = [];
    var_24[0] = ( 1, 0, 0 );
    var_24[1] = ( -1, 0, 0 );
    var_24[2] = ( 0, 1, 0 );
    var_24[3] = ( 0, -1, 0 );
    var_24[4] = ( 1, 1, 0 );
    var_24[5] = ( 1, -1, 0 );
    var_24[6] = ( -1, 1, 0 );
    var_24[7] = ( -1, -1, 0 );
    var_25 = _ID12897( self.vehicle_controlling.origin, "vanguard" );

    while ( var_25.vanguard_origin[2] - self.vehicle_controlling.origin[2] > 20 )
    {
        if ( !self.vehicle_controlling maps\mp\killstreaks\_vanguard::_ID34856() )
            break;

        if ( gettime() > var_23 )
        {
            var_23 = gettime() + 2000;

            if ( isdefined( var_22 ) )
                var_22 = undefined;
            else
            {
                var_19 = self.vehicle_controlling.origin[2] - var_21;

                if ( var_19 < 20 && !var_5 )
                {
                    var_26 = common_scripts\utility::array_randomize( var_24 );

                    foreach ( var_28 in var_26 )
                    {
                        if ( _ID24751( self.vehicle_controlling.origin + var_28 * 64 ) )
                        {
                            if ( !bullettracepassed( self.vehicle_controlling.origin, self.vehicle_controlling.origin + var_28 * 64, 0, self.vehicle_controlling ) )
                            {
                                wait 0.05;
                                continue;
                            }

                            var_22 = var_28;
                            break;
                        }

                        wait 0.05;
                    }
                }
            }

            var_21 = self.vehicle_controlling.origin[2];
        }

        if ( isdefined( var_22 ) )
        {
            self botsetscriptmove( vectortoangles( var_22 )[1], 0.05 );

            if ( common_scripts\utility::_ID7657() )
                self botpressbutton( "tactical" );
        }
        else
            self botpressbutton( "lethal" );

        wait 0.05;
    }

    wait 1.0;

    while ( !self.vehicle_controlling maps\mp\killstreaks\_vanguard::_ID34856() )
    {
        self botpressbutton( "tactical" );
        wait 0.1;
    }

    wait 1.0;
    self botsetflag( "disable_movement", 0 );
    bot_control_heli_main_move_loop( "vanguard", 0 );
    self notify( "control_func_done" );
}

_ID24749( var_0 )
{
    var_1 = getclosestnodeinsight( var_0 );

    if ( isdefined( var_1 ) )
        return node_is_valid_outside_for_vanguard( var_1 );

    return 0;
}

node_is_valid_outside_for_vanguard( var_0 )
{
    if ( nodeexposedtosky( var_0 ) )
        return _ID24751( var_0.origin );

    return 0;
}

_ID24751( var_0 )
{
    var_1 = var_0;

    for ( var_2 = var_0 + ( 0, 0, level.bot_vanguard_height_trace_size ); !_ID23024( var_2 ) && var_2[2] > var_1[2]; var_2 -= ( 0, 0, 50 ) )
    {

    }

    if ( var_2[2] <= var_1[2] )
        return 0;

    var_3 = bullettracepassed( var_1, var_2, 0, undefined );
    return var_3;
}

_ID34857()
{
    var_0 = getclosestnodeinsight( self.origin );

    if ( isdefined( var_0 ) && !nodeexposedtosky( var_0 ) )
        return 0;

    wait 0.05;

    if ( !_ID24751( self.origin + ( 18, 0, 25 ) ) )
        return 0;

    wait 0.05;

    if ( !_ID24751( self.origin + ( -18, 0, 25 ) ) )
        return 0;

    wait 0.05;

    if ( !_ID24751( self.origin + ( 0, 18, 25 ) ) )
        return 0;

    wait 0.05;

    if ( !_ID24751( self.origin + ( 0, -18, 25 ) ) )
        return 0;

    return 1;
}

_ID34849()
{
    self notify( "vanguard_control_aiming" );
    self endon( "vanguard_control_aiming" );
    var_0 = undefined;
    var_1 = 0;
    var_2 = gettime();
    var_3 = 0;
    var_4 = undefined;
    var_5 = 0;

    while ( self [[ level.bot_ks_funcs["isUsing"]["vanguard"] ]]() )
    {
        var_6 = undefined;
        var_7 = self geteye();
        var_8 = self getplayerangles();
        var_9 = self botgetfovdot();

        if ( isalive( self.enemy ) && self botcanseeentity( self.enemy ) )
        {
            var_10 = 1;
            var_6 = self.enemy;
            var_5 = 0;
        }
        else if ( var_5 < 10.0 )
        {
            foreach ( var_12 in level.characters )
            {
                if ( var_12 == self || !isalive( var_12 ) )
                    continue;

                if ( var_12 maps\mp\_utility::_hasperk( "specialty_noplayertarget" ) )
                    continue;

                if ( !isdefined( var_12.team ) )
                    continue;

                if ( !level._ID32653 || self.team != var_12.team )
                {
                    if ( common_scripts\utility::_ID36376( var_7, var_8, var_12.origin, var_9 ) )
                    {
                        var_5 += 0.05;

                        if ( isdefined( var_6 ) )
                        {
                            var_13 = distancesquared( self.vehicle_controlling.origin, var_6.origin );
                            var_14 = distancesquared( self.vehicle_controlling.origin, var_12.origin );

                            if ( var_14 < var_13 )
                                var_6 = var_12;

                            continue;
                        }

                        var_6 = var_12;
                    }
                }
            }
        }

        if ( isdefined( var_6 ) )
        {
            if ( ( isai( var_6 ) || isplayer( var_6 ) ) && length( var_6 getentityvelocity() ) < 25 )
                var_0 = var_6.origin;
            else if ( gettime() - var_3 < 500 )
            {
                if ( var_4 != var_6 )
                    var_0 = var_6.origin;
            }
            else if ( gettime() - var_3 > 500 )
            {
                var_3 = gettime();
                var_0 = getpredictedentityposition( var_6, 3.0 );
                var_4 = var_6;
            }

            var_16 = 165;

            if ( gettime() - var_2 > 10000 )
                var_16 = 200;

            if ( distancesquared( self.vehicle_controlling._ID4081.origin, var_0 ) < level.vanguard_missile_radius * level.vanguard_missile_radius )
            {
                if ( bot_body_is_dead() || distancesquared( self.vehicle_controlling._ID4081.origin, self.origin ) > level.vanguard_missile_radius * level.vanguard_missile_radius )
                {
                    var_2 = gettime();
                    self botpressbutton( "attack" );
                }
            }
        }
        else if ( gettime() > var_1 )
        {
            var_1 = gettime() + randomintrange( 1000, 2000 );
            var_0 = _ID14710();
            self.next_goal_time = gettime();
        }

        if ( length( var_0 ) == 0 )
            var_0 = ( 0, 0, 10 );

        self botlookatpoint( var_0, 0.2, "script_forced" );
        wait 0.05;
    }
}

vanguard_pick_node( var_0 )
{
    var_0._ID5825[self.entity_number]++;
    var_1 = [[ level.bot_ks_funcs["heli_node_get_origin"]["vanguard"] ]]( var_0 );
    var_2 = bot_vanguard_find_unvisited_nodes( var_0 );
    var_3 = var_2;
    var_2 = [];

    foreach ( var_5 in var_3 )
    {
        if ( var_5._ID34833 )
        {
            if ( var_0.origin[2] != var_0.vanguard_origin[2] || var_5.origin[2] != var_5.vanguard_origin[2] )
            {
                var_6 = [[ level.bot_ks_funcs["heli_node_get_origin"]["vanguard"] ]]( var_5 );
                var_7 = playerphysicstrace( var_1, var_6 );

                if ( distancesquared( var_7, var_6 ) < 1 )
                    var_2 = common_scripts\utility::array_add( var_2, var_5 );

                wait 0.05;
                continue;
            }

            var_2 = common_scripts\utility::array_add( var_2, var_5 );
        }
    }

    if ( var_2.size == 0 && var_3.size > 0 )
    {
        foreach ( var_5 in var_3 )
            var_5._ID5825[self.entity_number]++;
    }

    return _ID16634( var_2, "vanguard" );
}

bot_vanguard_find_unvisited_nodes( var_0 )
{
    var_1 = 99;
    var_2 = [];

    foreach ( var_4 in var_0._ID21919 )
    {
        if ( isdefined( var_4.script_linkname ) && var_4._ID34833 )
        {
            var_5 = var_4._ID5825[self.entity_number];

            if ( var_5 < var_1 )
            {
                var_2 = [];
                var_2[0] = var_4;
                var_1 = var_5;
            }
            else if ( var_5 == var_1 )
                var_2[var_2.size] = var_4;
        }
    }

    return var_2;
}

_ID34854( var_0 )
{
    return var_0.vanguard_origin;
}

_ID23024( var_0 )
{
    var_1 = common_scripts\utility::_ID30774();
    var_1.origin = var_0;
    var_2 = var_1 maps\mp\killstreaks\_vanguard::_ID34856();
    var_1 delete();
    return var_2;
}

_ID16652()
{
    if ( !maps\mp\bots\_bots_ks::aerial_vehicle_allowed() )
        return 0;

    if ( maps\mp\killstreaks\_helisniper::_ID12352() )
        return 0;

    return 1;
}

heli_sniper_waittill_initial_goal()
{
    self.vehicle_controlling waittill( "near_goal" );
}

bot_control_heli_sniper()
{
    thread _ID16653();
    bot_control_heli( "heli_sniper" );
}

_ID16653()
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "control_func_done" );
    level endon( "game_ended" );

    while ( !( maps\mp\killstreaks\_killstreaks::_ID18836() && self islinked() ) )
        wait 0.05;

    self botclearscriptgoal();
}

_ID16654( var_0 )
{
    var_0._ID5825[self.entity_number]++;
    var_1 = bot_heli_find_unvisited_nodes( var_0 );
    return _ID16634( var_1, "heli_sniper" );
}

_ID16636()
{
    if ( !maps\mp\bots\_bots_ks::aerial_vehicle_allowed() )
        return 0;

    if ( maps\mp\killstreaks\_helicopter_pilot::_ID12351( self.team ) )
        return 0;

    return 1;
}

heli_pilot_waittill_initial_goal()
{
    self.vehicle_controlling waittill( "goal_reached" );
}

bot_control_heli_pilot()
{
    bot_control_heli( "heli_pilot" );
}

heli_pilot_pick_node( var_0 )
{
    var_0._ID5825[self.entity_number]++;
    var_1 = bot_heli_find_unvisited_nodes( var_0 );
    var_2 = common_scripts\utility::_ID25350( var_1 );
    return var_2;
}

heli_pilot_monitor_flares()
{
    self notify( "heli_pilot_monitor_flares" );
    self endon( "heli_pilot_monitor_flares" );
    var_0 = [];

    while ( self [[ level.bot_ks_funcs["isUsing"]["heli_pilot"] ]]() )
    {
        self.vehicle_controlling waittill( "targeted_by_incoming_missile",  var_1  );

        if ( !maps\mp\killstreaks\_flares::_ID13261( self.vehicle_controlling ) )
            break;

        var_2 = 1;

        foreach ( var_4 in var_1 )
        {
            if ( isdefined( var_4 ) && !common_scripts\utility::array_contains( var_0, var_4 ) )
                var_2 = 0;
        }

        if ( !var_2 )
        {
            var_6 = clamp( 0.34 * self botgetdifficultysetting( "strategyLevel" ), 0.0, 1.0 );

            if ( randomfloat( 1.0 ) < var_6 )
                self notify( "manual_flare_popped" );

            var_0 = common_scripts\utility::array_combine( var_0, var_1 );
            var_0 = common_scripts\utility::array_removeundefined( var_0 );
            wait 3.0;
        }
    }
}

_ID16637()
{
    self notify( "heli_pilot_control_heli_aiming" );
    self endon( "heli_pilot_control_heli_aiming" );
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = 0;
    var_4 = 0;
    var_5 = undefined;
    var_6 = ( self botgetdifficultysetting( "minInaccuracy" ) + self botgetdifficultysetting( "maxInaccuracy" ) ) / 2;
    var_7 = 0;

    while ( self [[ level.bot_ks_funcs["isUsing"]["heli_pilot"] ]]() )
    {
        var_8 = 0;
        var_9 = 0;

        if ( isdefined( var_1 ) && var_1.health <= 0 && gettime() - var_1._ID9101 < 2000 )
        {
            var_8 = 1;
            var_9 = 1;
        }
        else if ( isalive( self.enemy ) && ( self botcanseeentity( self.enemy ) || gettime() - self lastknowntime( self.enemy ) <= 300 ) )
        {
            var_8 = 1;
            var_1 = self.enemy;
            var_0 = self.enemy.origin;

            if ( self botcanseeentity( self.enemy ) )
            {
                var_7 = 0;
                var_9 = 1;
                var_10 = gettime();
            }
            else
            {
                var_7 += 0.05;

                if ( var_7 > 5.0 )
                    var_8 = 0;
            }
        }

        if ( var_8 )
        {
            var_2 = var_0 - ( 0, 0, 50 );

            if ( var_9 && ( bot_body_is_dead() || distancesquared( var_2, self.origin ) > level._ID16639 * level._ID16639 ) )
                self botpressbutton( "attack" );

            if ( gettime() > var_4 + 500 )
            {
                var_11 = randomfloatrange( -1 * var_6 / 2, var_6 / 2 );
                var_12 = randomfloatrange( -1 * var_6 / 2, var_6 / 2 );
                var_13 = randomfloatrange( -1 * var_6 / 2, var_6 / 2 );
                var_5 = ( 150 * var_11, 150 * var_12, 150 * var_13 );
                var_4 = gettime();
            }

            var_2 += var_5;
            var_14 = self.vehicle_controlling gettagorigin( "tag_player" );
            var_15 = vectornormalize( var_2 - var_14 );
            var_16 = anglestoforward( self getplayerangles() );
            var_17 = vectordot( var_15, var_16 );

            if ( var_17 > 0.5 )
                self botpressbutton( "ads", 0.1 );
        }
        else if ( gettime() > var_3 )
        {
            var_3 = gettime() + randomintrange( 1000, 2000 );
            var_2 = _ID14710();
            self.next_goal_time = gettime();
        }

        var_18 = var_2 - self.vehicle_controlling.origin;
        var_19 = length( var_18 );
        var_20 = vectortoangles( var_18 );
        var_21 = angleclamp( self.vehicle_controlling.angles[0] );
        var_22 = angleclamp( var_20[0] );
        var_23 = int( var_21 - var_22 ) % 360;

        if ( var_23 > 180 )
            var_23 = 360 - var_23;
        else if ( var_23 < -180 )
            var_23 = -360 + var_23;

        if ( var_23 > 15 )
            var_22 = var_21 - 15;
        else if ( var_23 < -15 )
            var_22 = var_21 + 15;

        var_20 = ( var_22, var_20[1], var_20[2] );
        var_18 = anglestoforward( var_20 );
        var_2 = self.vehicle_controlling.origin + var_18 * var_19;

        if ( length( var_2 ) == 0 )
            var_2 = ( 0, 0, 10 );

        self botlookatpoint( var_2, 0.2, "script_forced" );
        wait 0.05;
    }
}

_ID5530()
{
    bot_control_odin( "odin_assault" );
}

odin_assault_perform_action()
{
    if ( bot_odin_try_spawn_juggernaut() )
        return 1;

    if ( bot_odin_try_rods() )
        return 1;

    if ( bot_odin_try_airdrop() )
        return 1;

    return 0;
}

_ID22524()
{
    return bot_odin_find_target_for_rods();
}

bot_odin_find_target_for_rods()
{
    var_0 = undefined;

    if ( isdefined( self._ID19466 ) && gettime() - self.last_large_rod_time < 5000 )
        var_0 = self._ID19466;

    return bot_odin_get_closest_visible_outside_player( "enemy", 1, var_0 );
}

bot_odin_try_rods()
{
    var_0 = bot_odin_should_fire_rod_at_marker();

    if ( var_0 == "large" )
    {
        self notify( "large_rod_action" );
        return 1;
    }

    if ( var_0 == "small" )
    {
        self notify( "small_rod_action" );
        return 1;
    }

    return 0;
}

bot_odin_should_fire_rod_at_marker()
{
    var_0 = gettime() >= self._ID22520._ID22558;
    var_1 = gettime() >= self._ID22520._ID22580;

    if ( var_0 || var_1 )
    {
        var_2 = bot_odin_get_visible_outside_players( "enemy", 0 );
        var_3 = [];
        var_4 = distancesquared( self.origin, self._ID22520._ID32610.origin );

        for ( var_5 = 0; var_5 < var_2.size; var_5++ )
        {
            var_6 = bot_odin_get_player_target_point( var_2[var_5] );
            var_3[var_5] = distancesquared( self._ID22520._ID32610.origin, var_6 );
        }

        if ( var_0 )
        {
            if ( !bot_body_is_dead() && var_4 < level._ID22557 * level._ID22557 )
                return "none";

            for ( var_5 = 0; var_5 < var_2.size; var_5++ )
            {
                if ( var_3[var_5] < squared( level._ID22557 ) )
                {
                    self._ID19466 = var_2[var_5];
                    self.last_large_rod_time = gettime();
                    return "large";
                }
            }
        }

        if ( var_1 )
        {
            if ( !bot_body_is_dead() && var_4 < level._ID22579 * level._ID22579 )
                return "none";

            for ( var_5 = 0; var_5 < var_2.size; var_5++ )
            {
                if ( var_3[var_5] < squared( level._ID22579 ) )
                {
                    if ( isdefined( self._ID19466 ) && self._ID19466 == var_2[var_5] && gettime() - self.last_large_rod_time < 5000 )
                        continue;

                    return "small";
                }
            }
        }
    }

    return "none";
}

_ID5531()
{
    bot_control_odin( "odin_support" );
}

_ID22586()
{
    if ( bot_odin_try_spawn_juggernaut() )
        return 1;

    if ( bot_odin_try_airdrop() )
        return 1;

    if ( bot_odin_try_smoke() )
        return 1;

    if ( bot_odin_try_flash() )
        return 1;

    return 0;
}

bot_odin_try_flash()
{
    if ( bot_odin_should_fire_flash_at_marker() )
    {
        self notify( "marking_action" );
        return 1;
    }

    return 0;
}

bot_odin_should_fire_flash_at_marker()
{
    if ( gettime() < self._ID22520._ID22565 )
        return 0;

    var_0 = bot_odin_get_visible_outside_players( "enemy", 0 );
    var_1 = [];

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        var_3 = bot_odin_get_player_target_point( var_0[var_2] );
        var_1[var_2] = distancesquared( self._ID22520._ID32610.origin, var_3 );

        if ( var_1[var_2] < squared( level._ID22541 / 2 ) )
            return 1;
    }

    return 0;
}

bot_odin_try_smoke()
{
    if ( _ID5705() )
    {
        self notify( "smoke_action" );
        return 1;
    }

    return 0;
}

_ID5705()
{
    if ( gettime() < self._ID22520._ID22581 )
        return 0;

    var_0 = _ID5700();

    foreach ( var_2 in var_0 )
    {
        if ( distancesquared( var_2, self._ID22520._ID32610.origin ) < 2500 )
            return 1;
    }

    var_4 = undefined;

    if ( isdefined( self._ID22520._ID32610._ID21893 ) )
        var_4 = getnodezone( self._ID22520._ID32610._ID21893 );

    if ( !isdefined( var_4 ) )
        return 0;

    var_5 = bot_killstreak_get_zone_enemies_outside( 1 );
    var_6 = var_5[var_4].size;

    if ( var_6 >= 2 )
        return 1;

    return 0;
}

_ID5700()
{
    var_0 = [];

    if ( gettime() < self._ID22520._ID22581 )
        return var_0;

    foreach ( var_2 in level._ID6711 )
    {
        if ( maps\mp\bots\_bots::_ID8242( var_2 ) )
        {
            var_3[0] = self;
            var_4 = common_scripts\utility::_ID14293( var_2.origin, level.players, var_3 );

            if ( var_4.size > 0 && var_4[0].team == self.team )
                var_0 = common_scripts\utility::array_add( var_0, var_2.origin );
        }
    }

    var_6 = bot_odin_get_visible_outside_players( "ally", 0 );

    foreach ( var_8 in var_6 )
    {
        if ( isai( var_8 ) && var_8 maps\mp\bots\_bots_util::bot_is_capturing() )
            var_0 = common_scripts\utility::array_add( var_0, var_8.origin );
    }

    return var_0;
}

_ID22585()
{
    var_0 = _ID5700();

    if ( var_0.size > 0 )
        return var_0[0];

    return bot_odin_get_closest_visible_outside_player( "enemy", 1 );
}

_ID21330()
{
    for (;;)
    {
        self._ID22520._ID32610._ID21893 = getclosestnodeinsight( self._ID22520._ID32610.origin );

        if ( maps\mp\bots\_bots_util::bot_point_is_on_pathgrid( self._ID22520._ID32610.origin, 200 ) )
            self._ID22520._ID32610.nearest_point_on_pathgrid = self._ID22520._ID32610.origin;
        else
            self._ID22520._ID32610.nearest_point_on_pathgrid = undefined;

        wait 0.25;
    }
}

bot_control_odin( var_0 )
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "control_func_done" );
    level endon( "game_ended" );
    var_1 = bot_waittill_using_vehicle( var_0 );

    if ( !var_1 )
        self notify( "control_func_done" );

    self.vehicle_controlling = self._ID22520;
    childthread bot_end_control_on_vehicle_death( self._ID22520 );
    self._ID22520 endon( "death" );
    wait 1.4;
    self botsetawareness( 0.7 );
    thread bot_end_odin_watcher();
    self._ID22571 = [];
    self._ID22572 = [];
    self._ID22559 = 0;
    var_2 = undefined;
    var_3 = 0;
    var_4 = undefined;
    childthread _ID21330();
    var_5 = self._ID22520._ID32610.origin;
    var_6 = gettime();

    while ( self [[ level.bot_ks_funcs["isUsing"][var_0] ]]() )
    {
        var_7 = self [[ level.bot_ks_funcs["odin_perform_action"][var_0] ]]();

        if ( gettime() > var_6 + 2000 )
        {
            var_6 = gettime();
            var_8 = distance( var_5, self._ID22520._ID32610.origin );
            var_5 = self._ID22520._ID32610.origin;

            if ( var_8 < 100 )
            {
                var_4 = undefined;
                var_2 = undefined;
            }
        }

        if ( gettime() > var_3 || !isdefined( var_4 ) )
        {
            var_9 = level.bot_odin_time_to_move[self botgetdifficulty()];
            var_3 = gettime() + var_9 * 1000;
            var_10 = self [[ level.bot_ks_funcs["odin_get_target"][var_0] ]]();

            if ( isdefined( var_10 ) )
            {
                var_2 = undefined;

                if ( isplayer( var_10 ) )
                    var_4 = bot_odin_get_player_target_point( var_10 );
                else
                    var_4 = var_10;
            }
            else
            {
                if ( !isdefined( var_2 ) )
                    var_2 = common_scripts\utility::_ID25350( level._ID23140 );

                var_11 = getzonenodeforindex( var_2 ).origin;

                if ( distance2dsquared( self._ID22520._ID32610.origin, var_11 ) < 10000 )
                {
                    var_2 = common_scripts\utility::_ID25350( level._ID23140 );
                    var_11 = getzonenodeforindex( var_2 ).origin;
                    var_6 = gettime();
                }

                var_4 = var_11;
            }
        }

        var_12 = var_4 - self._ID22520._ID32610.origin;

        if ( lengthsquared( var_12 ) > 100 )
        {
            var_13 = vectortoangles( var_12 );
            self botsetscriptmove( var_13[1], 0.05 );
            self botlookatpoint( var_4, 0.1, "script_forced" );
        }
        else
            var_6 = gettime();

        wait 0.05;
    }

    self notify( "control_func_done" );
}

bot_end_odin_watcher( var_0 )
{
    self endon( "disconnect" );
    self waittill( "control_func_done" );
    self._ID22571 = undefined;
    self._ID22572 = undefined;
    self._ID22559 = undefined;
    self botsetawareness( 1.0 );
}

bot_odin_get_player_target_point( var_0 )
{
    if ( level._ID32653 && self.team == var_0.team )
        return var_0.origin;
    else
    {
        if ( length( var_0 getentityvelocity() ) < 25 )
            return var_0.origin;

        var_1 = var_0 getentitynumber();

        if ( !isdefined( self._ID22572[var_1] ) )
            self._ID22572[var_1] = 0;

        var_2 = gettime();
        var_3 = var_2 - self._ID22572[var_1];

        if ( var_3 <= 400 )
        {
            var_4 = vectornormalize( var_0 getentityvelocity() );
            var_5 = vectornormalize( self._ID22571[var_1] - var_0.origin );

            if ( vectordot( var_4, var_5 ) < -0.5 )
                return var_0.origin;
        }

        if ( var_3 > 400 )
        {
            if ( var_2 == self._ID22559 )
            {
                if ( var_3 > 1000 )
                    return var_0.origin;
            }
            else
            {
                self._ID22571[var_1] = getpredictedentityposition( var_0, 1.5 );
                self._ID22572[var_1] = var_2;
                self._ID22559 = var_2;
            }
        }

        return self._ID22571[var_1];
    }
}

bot_odin_get_closest_visible_outside_player( var_0, var_1, var_2 )
{
    var_3 = bot_odin_get_visible_outside_players( var_0, var_1 );

    if ( isdefined( var_2 ) )
        var_3 = common_scripts\utility::array_remove( var_3, var_2 );

    if ( var_3.size > 0 )
    {
        var_4 = common_scripts\utility::_ID14293( self._ID22520._ID32610.origin, var_3 );
        return var_4[0];
    }

    return undefined;
}

bot_odin_try_spawn_juggernaut()
{
    if ( gettime() >= self._ID22520._ID22556 )
    {
        if ( !isdefined( self._ID22520._ID32610._ID21893 ) )
            return 0;

        var_0 = maps\mp\killstreaks\_odin::_ID15074( self._ID22520._ID32610.origin );

        if ( isdefined( var_0 ) )
        {
            self notify( "juggernaut_action" );
            return 1;
        }
    }

    return 0;
}

bot_odin_find_target_for_airdrop()
{
    return bot_odin_get_closest_visible_outside_player( "ally", 0 );
}

bot_odin_try_airdrop()
{
    if ( bot_odin_should_airdrop_at_marker() )
    {
        self notify( "airdrop_action" );
        self notify( "juggernaut_action" );
        return 1;
    }

    return 0;
}

bot_odin_should_airdrop_at_marker()
{
    if ( gettime() < self._ID22520._ID22521 )
        return 0;

    if ( !isdefined( self._ID22520._ID32610._ID21893 ) )
        return 0;

    if ( _ID5701() > 2 )
        return 0;

    if ( !isdefined( self._ID22520._ID32610.nearest_point_on_pathgrid ) )
        return 0;

    var_0 = getnodezone( self._ID22520._ID32610._ID21893 );

    if ( !isdefined( var_0 ) )
        return 0;

    var_1 = bot_killstreak_get_zone_allies_outside( 1 );
    var_2 = var_1[var_0].size;
    var_3 = bot_killstreak_get_zone_enemies_outside( 1 );
    var_4 = var_3[var_0].size;

    if ( var_2 == 0 )
        return 0;

    if ( var_4 == 0 )
    {
        var_5 = 0;
        var_6 = bot_odin_get_visible_outside_players( "enemy", 1 );

        foreach ( var_8 in var_6 )
        {
            if ( distancesquared( var_8.origin, self._ID22520._ID32610.origin ) < 14400 )
                var_5 = 1;
        }

        if ( !var_5 )
            return 1;
    }

    if ( var_2 - var_4 >= 2 )
    {
        var_10 = common_scripts\utility::_ID14293( self._ID22520._ID32610.origin, var_1[var_0] );
        var_11 = common_scripts\utility::_ID14293( self._ID22520._ID32610.origin, var_3[var_0] );
        var_12 = distance( self._ID22520._ID32610.origin, var_10[0].origin );
        var_13 = distance( self._ID22520._ID32610.origin, var_11[0].origin );

        if ( var_12 + 120 < var_13 )
            return 1;
    }

    return 0;
}

_ID5701()
{
    var_0 = 0;

    foreach ( var_2 in level._ID6711 )
    {
        if ( isdefined( var_2 ) && maps\mp\bots\_bots::_ID8242( var_2 ) )
            var_0++;
    }

    return var_0;
}

bot_odin_get_visible_outside_players( var_0, var_1, var_2 )
{
    var_3 = _ID5645( self.team, var_0, var_1 );
    var_4 = self botgetfovdot();
    var_5 = [];

    foreach ( var_7 in var_3 )
    {
        var_8 = 0;
        var_9 = var_4;

        if ( var_0 == "enemy" )
        {
            if ( maps\mp\killstreaks\_odin::_ID12072( var_7 ) )
                var_8 = 1;
            else
                var_9 *= 0.9;
        }

        if ( common_scripts\utility::_ID36376( self.vehicle_controlling.origin, self getplayerangles(), var_7.origin, var_9 ) )
        {
            if ( !var_8 || self botcanseeentity( var_7 ) )
                var_5 = common_scripts\utility::array_add( var_5, var_7 );
        }
    }

    return var_5;
}

is_indoor_map()
{
    return level.script == "mp_sovereign";
}

bot_body_is_dead()
{
    return isdefined( self.fauxdead ) && self.fauxdead;
}

_ID16634( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = 0;

    foreach ( var_5 in var_0 )
    {
        var_6 = distancesquared( level.bot_map_center, [[ level.bot_ks_funcs["heli_node_get_origin"][var_1] ]]( var_5 ) );

        if ( var_6 > var_3 )
        {
            var_3 = var_6;
            var_2 = var_5;
        }
    }

    if ( isdefined( var_2 ) )
        return var_2;
    else
        return common_scripts\utility::_ID25350( var_0 );
}

heli_get_node_origin( var_0 )
{
    return var_0.origin;
}

_ID12897( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = 99999999;

    foreach ( var_5 in level.bot_heli_nodes )
    {
        var_6 = distance2dsquared( var_0, [[ level.bot_ks_funcs["heli_node_get_origin"][var_1] ]]( var_5 ) );

        if ( var_6 < var_3 )
        {
            var_2 = var_5;
            var_3 = var_6;
        }
    }

    return var_2;
}

bot_killstreak_get_zone_allies_outside( var_0 )
{
    var_1 = bot_killstreak_get_all_outside_allies( var_0 );
    var_2 = [];

    for ( var_3 = 0; var_3 < level._ID36588; var_3++ )
        var_2[var_3] = [];

    foreach ( var_5 in var_1 )
    {
        var_6 = var_5 getnearestnode();
        var_7 = getnodezone( var_6 );

        if ( isdefined( var_7 ) )
            var_2[var_7] = common_scripts\utility::array_add( var_2[var_7], var_5 );
    }

    return var_2;
}

bot_killstreak_get_zone_enemies_outside( var_0 )
{
    var_1 = bot_killstreak_get_all_outside_enemies( var_0 );
    var_2 = [];

    for ( var_3 = 0; var_3 < level._ID36588; var_3++ )
        var_2[var_3] = [];

    foreach ( var_5 in var_1 )
    {
        var_6 = var_5 getnearestnode();
        var_7 = getnodezone( var_6 );
        var_2[var_7] = common_scripts\utility::array_add( var_2[var_7], var_5 );
    }

    return var_2;
}

bot_killstreak_get_all_outside_enemies( var_0 )
{
    return _ID5645( self.team, "enemy", var_0 );
}

bot_killstreak_get_all_outside_allies( var_0 )
{
    return _ID5645( self.team, "ally", var_0 );
}

_ID5645( var_0, var_1, var_2 )
{
    var_3 = [];
    var_4 = level._ID23303;

    if ( isdefined( var_2 ) && var_2 )
        var_4 = level.players;

    foreach ( var_6 in var_4 )
    {
        if ( var_6 == self || !isalive( var_6 ) )
            continue;

        var_7 = 0;

        if ( var_1 == "ally" )
            var_7 = level._ID32653 && var_0 == var_6.team;
        else if ( var_1 == "enemy" )
            var_7 = !level._ID32653 || var_0 != var_6.team;

        if ( var_7 )
        {
            var_8 = var_6 getnearestnode();

            if ( isdefined( var_8 ) && nodeexposedtosky( var_8 ) )
                var_3 = common_scripts\utility::array_add( var_3, var_6 );
        }
    }

    var_3 = common_scripts\utility::array_remove( var_3, self );
    return var_3;
}

bot_heli_find_unvisited_nodes( var_0 )
{
    var_1 = 99;
    var_2 = [];

    foreach ( var_4 in var_0._ID21919 )
    {
        if ( isdefined( var_4.script_linkname ) )
        {
            var_5 = var_4._ID5825[self.entity_number];

            if ( var_5 < var_1 )
            {
                var_2 = [];
                var_2[0] = var_4;
                var_1 = var_5;
            }
            else if ( var_5 == var_1 )
                var_2[var_2.size] = var_4;
        }
    }

    return var_2;
}

bot_control_heli( var_0 )
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "control_func_done" );
    level endon( "game_ended" );
    var_1 = bot_waittill_using_vehicle( var_0 );

    if ( !var_1 )
        self notify( "control_func_done" );

    foreach ( var_3 in level._ID20086 )
    {
        if ( var_3.owner == self )
            self.vehicle_controlling = var_3;
    }

    childthread bot_end_control_on_vehicle_death( self.vehicle_controlling );
    self.vehicle_controlling endon( "death" );

    if ( isdefined( level.bot_ks_funcs["control_other"][var_0] ) )
        self childthread [[ level.bot_ks_funcs["control_other"][var_0] ]]();

    self [[ level.bot_ks_funcs["waittill_initial_goal"][var_0] ]]();
    self childthread [[ level.bot_ks_funcs["control_aiming"][var_0] ]]();
    bot_control_heli_main_move_loop( var_0, 1 );
    self notify( "control_func_done" );
}

bot_get_heli_goal_dist_sq( var_0 )
{
    if ( var_0 )
        return squared( 100 );
    else
        return squared( 30 );
}

bot_get_heli_slowdown_dist_sq( var_0 )
{
    if ( var_0 )
        return squared( 300 );
    else
        return squared( 90 );
}

bot_control_heli_main_move_loop( var_0, var_1 )
{
    foreach ( var_3 in level.bot_heli_nodes )
        var_3._ID5825[self.entity_number] = 0;

    var_5 = _ID12897( self.vehicle_controlling.origin, var_0 );
    var_6 = undefined;
    self.next_goal_time = 0;
    var_7 = "needs_new_goal";
    var_8 = undefined;
    var_9 = self.vehicle_controlling.origin;
    var_10 = 3.0;
    var_11 = 0.05;

    while ( self [[ level.bot_ks_funcs["isUsing"][var_0] ]]() )
    {
        if ( gettime() > self.next_goal_time && var_7 == "needs_new_goal" )
        {
            var_12 = var_5;
            var_5 = [[ level.bot_ks_funcs["heli_pick_node"][var_0] ]]( var_5 );
            var_6 = undefined;

            if ( isdefined( var_5 ) )
            {
                var_13 = [[ level.bot_ks_funcs["heli_node_get_origin"][var_0] ]]( var_5 );

                if ( var_1 )
                {
                    var_14 = var_5.origin + ( maps\mp\_utility::gethelipilotmeshoffset() + level.bot_heli_pilot_traceoffset );
                    var_15 = var_5.origin + maps\mp\_utility::gethelipilotmeshoffset() - level.bot_heli_pilot_traceoffset;
                    var_16 = bullettrace( var_14, var_15, 0, undefined, 0, 0, 1 );
                    var_6 = var_16["position"] - maps\mp\_utility::gethelipilotmeshoffset() + level._ID5660[var_0];
                }
                else
                    var_6 = var_13;
            }

            if ( isdefined( var_6 ) )
            {
                self botsetflag( "disable_movement", 0 );
                var_7 = "waiting_till_goal";
                var_10 = 3.0;
                var_9 = self.vehicle_controlling.origin;
            }
            else
            {
                var_5 = var_12;
                self.next_goal_time = gettime() + 2000;
            }
        }
        else if ( var_7 == "waiting_till_goal" )
        {
            if ( !var_1 )
            {
                var_17 = var_6[2] - self.vehicle_controlling.origin[2];

                if ( var_17 > 10 )
                    self botpressbutton( "lethal" );
                else if ( var_17 < -10 )
                    self botpressbutton( "tactical" );
            }

            var_18 = var_6 - self.vehicle_controlling.origin;

            if ( var_1 )
                var_8 = length2dsquared( var_18 );
            else
                var_8 = lengthsquared( var_18 );

            if ( var_8 < bot_get_heli_goal_dist_sq( var_1 ) )
            {
                self botsetscriptmove( 0, 0 );
                self botsetflag( "disable_movement", 1 );

                if ( self botgetdifficulty() == "recruit" )
                    self.next_goal_time = gettime() + randomintrange( 5000, 7000 );
                else
                    self.next_goal_time = gettime() + randomintrange( 3000, 5000 );

                var_7 = "needs_new_goal";
            }
            else
            {
                var_18 = var_6 - self.vehicle_controlling.origin;
                var_19 = vectortoangles( var_18 );
                var_20 = common_scripts\utility::_ID32831( var_8 < bot_get_heli_slowdown_dist_sq( var_1 ), 0.5, 1.0 );
                self botsetscriptmove( var_19[1], var_11, var_20 );
                var_10 -= var_11;

                if ( var_10 <= 0.0 )
                {
                    if ( distancesquared( self.vehicle_controlling.origin, var_9 ) < 225 )
                    {
                        var_5._ID5825[self.entity_number]++;
                        var_7 = "needs_new_goal";
                    }

                    var_9 = self.vehicle_controlling.origin;
                    var_10 = 3.0;
                }
            }
        }

        wait(var_11);
    }
}

_ID14710()
{
    var_0 = [];

    foreach ( var_2 in level._ID23140 )
    {
        var_3 = botzonegetcount( var_2, self.team, "enemy_predict" );

        if ( var_3 > 0 )
            var_0 = common_scripts\utility::array_add( var_0, var_2 );
    }

    var_5 = undefined;

    if ( var_0.size > 0 )
    {
        var_6 = common_scripts\utility::_ID25350( var_0 );
        var_7 = common_scripts\utility::_ID25350( getzonenodes( var_6 ) );
        var_5 = var_7.origin;
    }
    else
    {
        if ( isdefined( level._ID32800 ) )
            var_8 = [[ level._ID32800 ]]();
        else
            var_8 = getallnodes();

        var_9 = 0;

        while ( var_9 < 10 )
        {
            var_9++;
            var_10 = var_8[randomint( var_8.size )];
            var_5 = var_10.origin;

            if ( nodeexposedtosky( var_10 ) && distance2dsquared( var_10.origin, self.vehicle_controlling.origin ) > 62500 )
                break;
        }
    }

    return var_5;
}
