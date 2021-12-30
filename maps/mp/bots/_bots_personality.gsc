// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID29086()
{
    level._ID5723 = [];
    level._ID36868 = [];
    level._ID5723["active"][0] = "default";
    level._ID5723["active"][1] = "run_and_gun";
    level._ID5723["active"][2] = "cqb";
    level._ID5723["stationary"][0] = "camper";
    level._ID5724 = [];

    foreach ( var_5, var_1 in level._ID5723 )
    {
        foreach ( var_3 in var_1 )
        {
            level._ID5724[var_3] = var_5;
            level._ID36868[level._ID36868.size] = var_3;
        }
    }

    level._ID5725 = [];
    level._ID5725["active"] = 2;
    level._ID5725["stationary"] = 1;
    level.bot_pers_init = [];
    level.bot_pers_init["default"] = ::_ID17797;
    level.bot_pers_init["camper"] = ::init_personality_camper;
    level.bot_pers_update["default"] = ::_ID34457;
    level.bot_pers_update["camper"] = ::_ID34456;
}

_ID5500()
{
    self._ID23475 = self botgetpersonality();
    self._ID23476 = level.bot_pers_init[self._ID23475];

    if ( !isdefined( self._ID23476 ) )
        self._ID23476 = level.bot_pers_init["default"];

    self [[ self._ID23476 ]]();
    self._ID23477 = level.bot_pers_update[self._ID23475];

    if ( !isdefined( self._ID23477 ) )
        self._ID23477 = level.bot_pers_update["default"];
}

bot_balance_personality()
{
    if ( isdefined( self.personalitymanuallyset ) && self.personalitymanuallyset )
        return;

    if ( maps\mp\_utility::bot_is_fireteam_mode() )
        return;

    var_0 = [];
    var_1 = [];

    foreach ( var_7, var_3 in level._ID5723 )
    {
        var_1[var_7] = 0;

        foreach ( var_5 in var_3 )
            var_0[var_5] = 0;
    }

    foreach ( var_9 in level.players )
    {
        if ( isbot( var_9 ) && isdefined( var_9.team ) && var_9.team == self.team && var_9 != self && isdefined( var_9._ID16338 ) )
        {
            var_5 = var_9 botgetpersonality();
            var_7 = level._ID5724[var_5];
            var_0[var_5] += 1;
            var_1[var_7] += 1;
        }
    }

    var_11 = undefined;

    while ( !isdefined( var_11 ) )
    {
        for ( var_12 = level._ID5725; var_12.size > 0; var_12[var_13] = undefined )
        {
            var_13 = maps\mp\bots\_bots_util::bot_get_string_index_for_integer( var_12, randomint( var_12.size ) );
            var_1[var_13] -= level._ID5725[var_13];

            if ( var_1[var_13] < 0 )
            {
                var_11 = var_13;
                break;
            }
        }
    }

    var_14 = undefined;
    var_15 = undefined;
    var_16 = 9999;
    var_17 = undefined;
    var_18 = -9999;
    var_19 = common_scripts\utility::array_randomize( level._ID5723[var_11] );

    foreach ( var_5 in var_19 )
    {
        if ( var_0[var_5] < var_16 )
        {
            var_15 = var_5;
            var_16 = var_0[var_5];
        }

        if ( var_0[var_5] > var_18 )
        {
            var_17 = var_5;
            var_18 = var_0[var_5];
        }
    }

    if ( var_18 - var_16 >= 2 )
        var_14 = var_15;
    else
        var_14 = common_scripts\utility::_ID25350( level._ID5723[var_11] );

    if ( self botgetpersonality() != var_14 )
        self botsetpersonality( var_14 );

    self._ID16338 = 1;
}

init_personality_camper()
{
    _ID7425();
}

_ID17797()
{
    _ID7425();
}

_ID34456()
{
    if ( _ID29836() && !maps\mp\bots\_bots_util::bot_is_defending() && !maps\mp\bots\_bots_util::bot_is_remote_or_linked() )
    {
        var_0 = self botgetscriptgoaltype();
        var_1 = 0;

        if ( !isdefined( self.camper_time_started_hunting ) )
            self.camper_time_started_hunting = 0;

        var_2 = var_0 == "hunt";
        var_3 = gettime() > self.camper_time_started_hunting + 10000;

        if ( ( !var_2 || var_3 ) && !maps\mp\bots\_bots_util::bot_out_of_ammo() )
        {
            if ( !self bothasscriptgoal() )
                bot_random_path();

            var_1 = _ID12895();

            if ( !var_1 )
                self.camper_time_started_hunting = gettime();
        }

        if ( isdefined( var_1 ) && var_1 )
        {
            self._ID3282 = maps\mp\bots\_bots_util::bot_queued_process( "bot_find_ambush_entrances", ::bot_find_ambush_entrances, self._ID22077, 1 );
            var_4 = maps\mp\bots\_bots_strategy::_ID5598( "trap_directional", "trap", "c4" );

            if ( isdefined( var_4 ) )
            {
                var_5 = gettime();
                maps\mp\bots\_bots_strategy::bot_set_ambush_trap( var_4, self._ID3282, self._ID22077, self.ambush_yaw );
                var_5 = gettime() - var_5;

                if ( var_5 > 0 && isdefined( self._ID3280 ) && isdefined( self._ID22077 ) )
                {
                    self._ID3280 = self._ID3280 + var_5;
                    self._ID22077.bot_ambush_end = self._ID3280 + 10000;
                }
            }

            if ( !maps\mp\bots\_bots_strategy::bot_has_tactical_goal() && !maps\mp\bots\_bots_util::bot_is_defending() && isdefined( self._ID22077 ) )
            {
                self botsetscriptgoalnode( self._ID22077, "camp", self.ambush_yaw );
                thread clear_script_goal_on( "bad_path", "node_relinquished", "out_of_ammo" );
                thread _ID35994();
                thread bot_add_ambush_time_delayed( "clear_camper_data", "goal" );
                thread _ID5833( "clear_camper_data", "bot_add_ambush_time_delayed", self._ID3282, self.ambush_yaw );
                return;
            }
        }
        else
        {
            if ( var_0 == "camp" )
                self botclearscriptgoal();

            _ID34457();
        }
    }
}

_ID34457()
{
    var_0 = undefined;
    var_1 = self bothasscriptgoal();

    if ( var_1 )
        var_0 = self botgetscriptgoal();

    if ( !maps\mp\bots\_bots_strategy::bot_has_tactical_goal() && !maps\mp\bots\_bots_util::bot_is_remote_or_linked() )
    {
        var_2 = undefined;
        var_3 = undefined;

        if ( var_1 )
        {
            var_2 = distancesquared( self.origin, var_0 );
            var_3 = self botgetscriptgoalradius();
            var_4 = var_3 * 2;

            if ( isdefined( self.bot_memory_goal ) && var_2 < var_4 * var_4 )
            {
                var_5 = botmemoryflags( "investigated" );
                botflagmemoryevents( 0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, var_4, "kill", var_5, self );
                botflagmemoryevents( 0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, var_4, "death", var_5, self );
                self.bot_memory_goal = undefined;
                self.bot_memory_goal_time = undefined;
            }
        }

        if ( !var_1 || var_2 < var_3 * var_3 )
        {
            var_6 = bot_random_path();

            if ( var_6 && randomfloat( 100 ) < 25 )
            {
                var_7 = maps\mp\bots\_bots_strategy::_ID5598( "trap_directional", "trap" );

                if ( isdefined( var_7 ) )
                {
                    var_8 = self botgetscriptgoal();

                    if ( isdefined( var_8 ) )
                    {
                        var_9 = getclosestnodeinsight( var_8 );

                        if ( isdefined( var_9 ) )
                        {
                            var_10 = maps\mp\bots\_bots_util::bot_queued_process( "bot_find_ambush_entrances", ::bot_find_ambush_entrances, var_9, 0 );
                            var_11 = maps\mp\bots\_bots_strategy::bot_set_ambush_trap( var_7, var_10, var_9 );

                            if ( !isdefined( var_11 ) || var_11 )
                            {
                                self botclearscriptgoal();
                                var_6 = bot_random_path();
                            }
                        }
                    }
                }
            }

            if ( var_6 )
                thread clear_script_goal_on( "enemy", "bad_path", "goal", "node_relinquished", "search_end" );
        }
    }
}

clear_script_goal_on( var_0, var_1, var_2, var_3, var_4 )
{
    self notify( "clear_script_goal_on" );
    self endon( "clear_script_goal_on" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "start_tactical_goal" );
    var_5 = self botgetscriptgoal();
    var_6 = 1;

    while ( var_6 )
    {
        var_7 = common_scripts\utility::_ID35635( var_0, var_1, var_2, var_3, var_4, "script_goal_changed" );
        var_6 = 0;
        var_8 = 1;

        if ( var_7 == "node_relinquished" || var_7 == "goal" || var_7 == "script_goal_changed" )
        {
            if ( !self bothasscriptgoal() )
                var_8 = 0;
            else
            {
                var_9 = self botgetscriptgoal();
                var_8 = maps\mp\bots\_bots_util::_ID5824( var_5, var_9 );
            }
        }

        if ( var_7 == "enemy" && isdefined( self.enemy ) )
        {
            var_8 = 0;
            var_6 = 1;
        }

        if ( var_8 )
            self botclearscriptgoal();
    }
}

_ID35994()
{
    self notify( "watch_out_of_ammo" );
    self endon( "watch_out_of_ammo" );
    self endon( "death" );
    self endon( "disconnect" );

    while ( !maps\mp\bots\_bots_util::bot_out_of_ammo() )
        wait 0.5;

    self notify( "out_of_ammo" );
}

bot_add_ambush_time_delayed( var_0, var_1 )
{
    self notify( "bot_add_ambush_time_delayed" );
    self endon( "bot_add_ambush_time_delayed" );
    self endon( "death" );
    self endon( "disconnect" );

    if ( isdefined( var_0 ) )
        self endon( var_0 );

    self endon( "node_relinquished" );
    self endon( "bad_path" );
    var_2 = gettime();

    if ( isdefined( var_1 ) )
        self waittill( var_1 );

    if ( isdefined( self._ID3280 ) && isdefined( self._ID22077 ) )
    {
        self._ID3280 = self._ID3280 + gettime() - var_2;
        self._ID22077.bot_ambush_end = self._ID3280 + 10000;
    }

    self notify( "bot_add_ambush_time_delayed" );
}

_ID5833( var_0, var_1, var_2, var_3 )
{
    self notify( "bot_watch_entrances_delayed" );

    if ( var_2.size > 0 )
    {
        self endon( "bot_watch_entrances_delayed" );
        self endon( "death" );
        self endon( "disconnect" );
        self endon( var_0 );
        self endon( "node_relinquished" );
        self endon( "bad_path" );

        if ( isdefined( var_1 ) )
            self waittill( var_1 );

        self endon( "path_enemy" );
        childthread maps\mp\bots\_bots_util::bot_watch_nodes( var_2, var_3, 0, self._ID3280 );
        childthread _ID5694();
    }
}

_ID5694()
{
    self notify( "bot_monitor_watch_entrances_camp" );
    self endon( "bot_monitor_watch_entrances_camp" );
    self notify( "bot_monitor_watch_entrances" );
    self endon( "bot_monitor_watch_entrances" );
    self endon( "disconnect" );
    self endon( "death" );

    while ( !isdefined( self._ID35991 ) )
        wait 0.05;

    while ( isdefined( self._ID35991 ) )
    {
        foreach ( var_1 in self._ID35991 )
            var_1._ID35990[self.entity_number] = 1.0;

        maps\mp\bots\_bots_strategy::prioritize_watch_nodes_toward_enemies( 0.5 );
        wait(randomfloatrange( 0.5, 0.75 ));
    }
}

bot_find_ambush_entrances( var_0, var_1 )
{
    self endon( "disconnect" );
    var_2 = [];
    var_3 = findentrances( var_0.origin );

    if ( isdefined( var_3 ) && var_3.size > 0 )
    {
        wait 0.05;
        var_4 = var_0.type != "Cover Stand" && var_0.type != "Conceal Stand";

        if ( var_4 && var_1 )
            var_3 = self botnodescoremultiple( var_3, "node_exposure_vis", var_0.origin, "crouch" );

        foreach ( var_6 in var_3 )
        {
            if ( distancesquared( self.origin, var_6.origin ) < 90000 )
                continue;

            if ( var_4 && var_1 )
            {
                wait 0.05;

                if ( !maps\mp\bots\_bots_util::entrance_visible_from( var_6.origin, var_0.origin, "crouch" ) )
                    continue;
            }

            var_2[var_2.size] = var_6;
        }
    }

    return var_2;
}

bot_filter_ambush_inuse( var_0 )
{
    var_1 = [];
    var_2 = gettime();
    var_3 = var_0.size;

    for ( var_4 = 0; var_4 < var_3; var_4++ )
    {
        var_5 = var_0[var_4];

        if ( !isdefined( var_5.bot_ambush_end ) || var_2 > var_5.bot_ambush_end )
            var_1[var_1.size] = var_5;
    }

    return var_1;
}

bot_filter_ambush_vicinity( var_0, var_1, var_2 )
{
    var_3 = [];
    var_4 = [];
    var_5 = var_2 * var_2;

    if ( level._ID32653 )
    {
        foreach ( var_7 in level._ID23303 )
        {
            if ( !maps\mp\_utility::_ID18757( var_7 ) )
                continue;

            if ( !isdefined( var_7.team ) )
                continue;

            if ( var_7.team == var_1.team && var_7 != var_1 && isdefined( var_7._ID22077 ) )
                var_4[var_4.size] = var_7._ID22077.origin;
        }
    }

    var_9 = var_4.size;
    var_10 = var_0.size;

    for ( var_11 = 0; var_11 < var_10; var_11++ )
    {
        var_12 = 0;
        var_13 = var_0[var_11];

        for ( var_14 = 0; !var_12 && var_14 < var_9; var_14++ )
        {
            var_15 = distancesquared( var_4[var_14], var_13.origin );
            var_12 = var_15 < var_5;
        }

        if ( !var_12 )
            var_3[var_3.size] = var_13;
    }

    return var_3;
}

_ID7425()
{
    self notify( "clear_camper_data" );

    if ( isdefined( self._ID22077 ) && isdefined( self._ID22077.bot_ambush_end ) )
        self._ID22077.bot_ambush_end = undefined;

    self._ID22077 = undefined;
    self._ID24713 = undefined;
    self.ambush_yaw = undefined;
    self._ID3282 = undefined;
    self.ambush_duration = randomintrange( 20000, 30000 );
    self._ID3280 = -1;
}

_ID29836()
{
    if ( maps\mp\bots\_bots_strategy::bot_has_tactical_goal() )
        return 0;

    if ( gettime() > self._ID3280 )
        return 1;

    if ( !self bothasscriptgoal() )
        return 1;

    return 0;
}

_ID12895()
{
    self notify( "find_camp_node" );
    self endon( "find_camp_node" );
    return maps\mp\bots\_bots_util::bot_queued_process( "find_camp_node_worker", ::find_camp_node_worker );
}

find_camp_node_worker()
{
    self notify( "find_camp_node_worker" );
    self endon( "find_camp_node_worker" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    _ID7425();

    if ( level._ID36588 <= 0 )
        return 0;

    var_0 = getzonenearest( self.origin );
    var_1 = undefined;
    var_2 = undefined;
    var_3 = self.angles;

    if ( isdefined( var_0 ) )
    {
        var_4 = botzonenearestcount( var_0, self.team, -1, "enemy_predict", ">", 0, "ally", "<", 1 );

        if ( !isdefined( var_4 ) )
            var_4 = botzonenearestcount( var_0, self.team, -1, "enemy_predict", ">", 0 );

        if ( !isdefined( var_4 ) )
        {
            var_5 = -1;
            var_6 = -1;

            for ( var_7 = 0; var_7 < level._ID36588; var_7++ )
            {
                var_8 = distance2dsquared( getzoneorigin( var_7 ), self.origin );

                if ( var_8 > var_5 )
                {
                    var_5 = var_8;
                    var_6 = var_7;
                }
            }

            var_4 = var_6;
        }

        var_9 = getzonepath( var_0, var_4 );

        if ( isdefined( var_9 ) && var_9.size > 0 )
        {
            for ( var_10 = 0; var_10 <= int( var_9.size / 2 ); var_10++ )
            {
                var_1 = var_9[var_10];
                var_2 = var_9[int( min( var_10 + 1, var_9.size - 1 ) )];

                if ( botzonegetcount( var_2, self.team, "enemy_predict" ) != 0 )
                    break;
            }

            if ( isdefined( var_1 ) && isdefined( var_2 ) && var_1 != var_2 )
            {
                var_3 = getzoneorigin( var_2 ) - getzoneorigin( var_1 );
                var_3 = vectortoangles( var_3 );
            }
        }
    }

    var_11 = undefined;

    if ( isdefined( var_1 ) )
    {
        var_12 = 1;
        var_13 = 1;
        var_14 = 0;

        while ( var_12 )
        {
            var_15 = getzonenodesbydist( var_1, 800 * var_13, 1 );

            if ( var_15.size > 1024 )
                var_15 = getzonenodes( var_1, 0 );

            wait 0.05;
            var_16 = randomint( 100 );

            if ( var_16 < 66 && var_16 >= 33 )
                var_3 = ( var_3[0], var_3[1] + 45, 0 );
            else if ( var_16 < 33 )
                var_3 = ( var_3[0], var_3[1] - 45, 0 );

            if ( var_15.size > 0 )
            {
                var_17 = int( min( max( 1, var_15.size * 0.15 ), 5 ) );

                if ( var_14 )
                    var_15 = self botnodepickmultiple( var_15, var_17, var_17, "node_camp", anglestoforward( var_3 ), "lenient" );
                else
                    var_15 = self botnodepickmultiple( var_15, var_17, var_17, "node_camp", anglestoforward( var_3 ) );

                var_15 = bot_filter_ambush_inuse( var_15 );

                if ( !isdefined( self._ID6526 ) || !self._ID6526 )
                {
                    var_18 = 800;
                    var_15 = bot_filter_ambush_vicinity( var_15, self, var_18 );
                }

                if ( var_15.size > 0 )
                    var_11 = common_scripts\utility::random_weight_sorted( var_15 );
            }

            if ( isdefined( var_11 ) )
                var_12 = 0;
            else if ( isdefined( self.camping_needs_fallback_camp_location ) )
            {
                if ( var_13 == 1 && !var_14 )
                    var_13 = 3;
                else if ( var_13 == 3 && !var_14 )
                    var_14 = 1;
                else if ( var_13 == 3 && var_14 )
                    var_12 = 0;
            }
            else
                var_12 = 0;

            if ( var_12 )
                wait 0.05;
        }
    }

    if ( !isdefined( var_11 ) || !self botnodeavailable( var_11 ) )
        return 0;

    self._ID22077 = var_11;
    self._ID3280 = gettime() + self.ambush_duration;
    self._ID22077.bot_ambush_end = self._ID3280;
    self.ambush_yaw = var_3[1];
    return 1;
}

_ID12890( var_0, var_1 )
{
    _ID7425();

    if ( isdefined( var_0 ) )
        self._ID24713 = var_0;
    else
    {
        var_2 = undefined;
        var_3 = getnodesinradius( self.origin, 5000, 0, 2000 );

        if ( var_3.size > 0 )
            var_2 = self botnodepick( var_3, var_3.size * 0.25, "node_traffic" );

        if ( isdefined( var_2 ) )
            self._ID24713 = var_2.origin;
        else
            return 0;
    }

    var_4 = 2000;

    if ( isdefined( var_1 ) )
        var_4 = var_1;

    var_5 = getnodesinradius( self._ID24713, var_4, 0, 1000 );
    var_6 = undefined;

    if ( var_5.size > 0 )
    {
        var_7 = int( max( 1, int( var_5.size * 0.15 ) ) );
        var_5 = self botnodepickmultiple( var_5, var_7, var_7, "node_ambush", self._ID24713 );
    }

    var_5 = bot_filter_ambush_inuse( var_5 );

    if ( var_5.size > 0 )
        var_6 = common_scripts\utility::random_weight_sorted( var_5 );

    if ( !isdefined( var_6 ) || !self botnodeavailable( var_6 ) )
        return 0;

    self._ID22077 = var_6;
    self._ID3280 = gettime() + self.ambush_duration;
    self._ID22077.bot_ambush_end = self._ID3280;
    var_8 = vectornormalize( self._ID24713 - self._ID22077.origin );
    var_9 = vectortoangles( var_8 );
    self.ambush_yaw = var_9[1];
    return 1;
}

bot_random_path()
{
    if ( maps\mp\bots\_bots_util::bot_is_remote_or_linked() )
        return 0;

    var_0 = level.bot_random_path_function[self.team];
    return self [[ var_0 ]]();
}

bot_random_path_default()
{
    var_0 = 0;
    var_1 = 50;

    if ( self._ID23475 == "camper" )
        var_1 = 0;

    var_2 = undefined;

    if ( randomint( 100 ) < var_1 )
        var_2 = maps\mp\bots\_bots_util::_ID5746();

    if ( !isdefined( var_2 ) )
    {
        var_3 = self botfindnoderandom();

        if ( isdefined( var_3 ) )
            var_2 = var_3.origin;
    }

    if ( isdefined( var_2 ) )
        var_0 = self botsetscriptgoal( var_2, 128, "hunt" );

    return var_0;
}

bot_setup_callback_class()
{
    if ( maps\mp\bots\_bots_loadout::_ID5777() )
        return "callback";
    else
        return "class0";
}
