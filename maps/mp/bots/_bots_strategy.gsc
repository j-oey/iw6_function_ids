// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

bot_defend_get_random_entrance_point_for_current_area()
{
    var_0 = _ID5538( self.cur_defend_stance );

    if ( isdefined( var_0 ) && var_0.size > 0 )
        return common_scripts\utility::_ID25350( var_0 ).origin;

    return undefined;
}

_ID5538( var_0 )
{
    if ( isdefined( self._ID9429 ) )
        return maps\mp\bots\_bots_util::bot_get_entrances_for_stance_and_index( var_0, self._ID9429 );

    return [];
}

_ID5774()
{
    wait 1.0;
    bot_setup_bot_targets( level.bombzones );
    level.bot_set_bombzone_bottargets = 1;
}

bot_setup_radio_bottargets()
{
    bot_setup_bot_targets( level._ID25293 );
}

bot_setup_bot_targets( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2.bottargets ) )
        {
            var_2.bottargets = [];
            var_3 = gettnodesintrigger( var_2.trigger );

            foreach ( var_5 in var_3 )
            {
                if ( !var_5 nodeisdisconnected() )
                    var_2.bottargets = common_scripts\utility::array_add( var_2.bottargets, var_5 );
            }
        }
    }
}

_ID5598( var_0, var_1, var_2 )
{
    var_3 = [];
    var_4 = [];
    var_4[var_4.size] = var_0;

    if ( isdefined( var_1 ) )
        var_4[var_4.size] = var_1;

    if ( isdefined( var_1 ) )
        var_4[var_4.size] = var_2;

    foreach ( var_6 in var_4 )
    {
        var_3["purpose"] = var_6;
        var_3["item_action"] = maps\mp\bots\_bots_util::bot_get_grenade_for_purpose( var_6 );

        if ( isdefined( var_3["item_action"] ) )
            return var_3;
    }
}

bot_set_ambush_trap( var_0, var_1, var_2, var_3, var_4 )
{
    self notify( "bot_set_ambush_trap" );
    self endon( "bot_set_ambush_trap" );

    if ( !isdefined( var_0 ) )
        return 0;

    var_5 = undefined;

    if ( !isdefined( var_4 ) && isdefined( var_1 ) && var_1.size > 0 )
    {
        if ( !isdefined( var_2 ) )
            return 0;

        var_6 = [];
        var_7 = undefined;

        if ( isdefined( var_3 ) )
            var_7 = anglestoforward( ( 0, var_3, 0 ) );

        foreach ( var_9 in var_1 )
        {
            if ( !isdefined( var_7 ) )
            {
                var_6[var_6.size] = var_9;
                continue;
            }

            if ( distancesquared( var_9.origin, var_2.origin ) > 90000 )
            {
                if ( vectordot( var_7, vectornormalize( var_9.origin - var_2.origin ) ) < 0.4 )
                    var_6[var_6.size] = var_9;
            }
        }

        if ( var_6.size > 0 )
        {
            var_5 = common_scripts\utility::_ID25350( var_6 );
            var_11 = getnodesinradius( var_5.origin, 300, 50 );
            var_12 = [];

            foreach ( var_14 in var_11 )
            {
                if ( !isdefined( var_14.bot_ambush_end ) )
                    var_12[var_12.size] = var_14;
            }

            var_11 = var_12;
            var_4 = self botnodepick( var_11, min( var_11.size, 3 ), "node_trap", var_2, var_5 );
        }
    }

    if ( isdefined( var_4 ) )
    {
        var_16 = undefined;

        if ( var_0["purpose"] == "trap_directional" && isdefined( var_5 ) )
        {
            var_17 = vectortoangles( var_5.origin - var_4.origin );
            var_16 = var_17[1];
        }

        if ( self bothasscriptgoal() && self botgetscriptgoaltype() != "critical" && self botgetscriptgoaltype() != "tactical" )
            self botclearscriptgoal();

        var_18 = self botsetscriptgoalnode( var_4, "guard", var_16 );

        if ( var_18 )
        {
            var_19 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();

            if ( var_19 == "goal" )
            {
                thread maps\mp\bots\_bots_util::bot_force_stance_for_time( "stand", 5.0 );

                if ( !isdefined( self.enemy ) || 0 == self botcanseeentity( self.enemy ) )
                {
                    if ( isdefined( var_16 ) )
                        self botthrowgrenade( var_5.origin, var_0["item_action"] );
                    else
                        self botthrowgrenade( self.origin + anglestoforward( self.angles ) * 50, var_0["item_action"] );

                    self.ambush_trap_ent = undefined;
                    thread bot_set_ambush_trap_wait_fire( "grenade_fire" );
                    thread bot_set_ambush_trap_wait_fire( "missile_fire" );
                    var_20 = 3.0;

                    if ( var_0["purpose"] == "tacticalinsertion" )
                        var_20 = 6.0;

                    common_scripts\utility::_ID35637( var_20, "missile_fire", "grenade_fire" );
                    wait 0.05;
                    self notify( "ambush_trap_ent" );

                    if ( isdefined( self.ambush_trap_ent ) && var_0["purpose"] == "c4" )
                        thread bot_watch_manual_detonate( self.ambush_trap_ent, var_0["item_action"], 300 );

                    self.ambush_trap_ent = undefined;
                    wait(randomfloat( 0.25 ));
                    self botsetstance( "none" );
                }
            }

            return 1;
        }
    }

    return 0;
}

bot_set_ambush_trap_wait_fire( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "bot_set_ambush_trap" );
    self endon( "ambush_trap_ent" );
    level endon( "game_ended" );
    self waittill( var_0,  var_1  );
    self.ambush_trap_ent = var_1;
}

bot_watch_manual_detonate( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_0 endon( "death" );
    level endon( "game_ended" );
    var_3 = var_2 * var_2;

    for (;;)
    {
        if ( isdefined( var_0.origin ) && distancesquared( self.origin, var_0.origin ) > var_3 )
        {
            var_4 = self getclosestenemysqdist( var_0.origin, 1.0 );

            if ( var_4 < var_3 )
            {
                self botpressbutton( var_1 );
                return;
            }
        }

        wait(randomfloatrange( 0.25, 1.0 ));
    }
}

_ID5516( var_0, var_1, var_2 )
{
    thread bot_defend_think( var_0, var_1, "capture", var_2 );
}

bot_capture_zone( var_0, var_1, var_2, var_3 )
{
    var_3["capture_trigger"] = var_2;
    thread bot_defend_think( var_0, var_1, "capture_zone", var_3 );
}

bot_protect_point( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) || !isdefined( var_2["min_goal_time"] ) )
        var_2["min_goal_time"] = 12;

    if ( !isdefined( var_2 ) || !isdefined( var_2["max_goal_time"] ) )
        var_2["max_goal_time"] = 18;

    thread bot_defend_think( var_0, var_1, "protect", var_2 );
}

_ID5717( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) || !isdefined( var_2["min_goal_time"] ) )
        var_2["min_goal_time"] = 0.0;

    if ( !isdefined( var_2 ) || !isdefined( var_2["max_goal_time"] ) )
        var_2["max_goal_time"] = 0.01;

    thread bot_defend_think( var_0, var_1, "patrol", var_2 );
}

bot_guard_player( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) || !isdefined( var_2["min_goal_time"] ) )
        var_2["min_goal_time"] = 15;

    if ( !isdefined( var_2 ) || !isdefined( var_2["max_goal_time"] ) )
        var_2["max_goal_time"] = 20;

    thread bot_defend_think( var_0, var_1, "bodyguard", var_2 );
}

bot_defend_think( var_0, var_1, var_2, var_3 )
{
    self notify( "started_bot_defend_think" );
    self endon( "started_bot_defend_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "defend_stop" );
    thread defense_death_monitor();

    if ( isdefined( self.bot_defending ) || self botgetscriptgoaltype() == "camp" )
        self botclearscriptgoal();

    self.bot_defending = 1;
    self.bot_defending_type = var_2;

    if ( var_2 == "capture_zone" )
    {
        self.bot_defending_radius = undefined;
        self._ID5545 = var_1;
        self.bot_defending_trigger = var_3["capture_trigger"];
    }
    else
    {
        self.bot_defending_radius = var_1;
        self._ID5545 = undefined;
        self.bot_defending_trigger = undefined;
    }

    if ( maps\mp\_utility::_ID18638( var_0 ) )
    {
        self._ID5540 = var_0;
        childthread _ID21312();
    }
    else
    {
        self._ID5540 = undefined;
        self.bot_defending_center = var_0;
    }

    self botsetstance( "none" );
    var_4 = undefined;
    var_5 = 6;
    var_6 = 10;

    if ( isdefined( var_3 ) )
    {
        self._ID9429 = var_3["entrance_points_index"];
        self._ID9469 = var_3["score_flags"];
        self._ID5546 = var_3["override_origin_node"];

        if ( isdefined( var_3["override_goal_type"] ) )
            var_4 = var_3["override_goal_type"];

        if ( isdefined( var_3["min_goal_time"] ) )
            var_5 = var_3["min_goal_time"];

        if ( isdefined( var_3["max_goal_time"] ) )
            var_6 = var_3["max_goal_time"];

        if ( isdefined( var_3["override_entrances"] ) && var_3["override_entrances"].size > 0 )
        {
            self.defense_override_entrances = var_3["override_entrances"];
            self._ID9429 = self.name + " " + gettime();

            foreach ( var_8 in self.defense_override_entrances )
            {
                var_8._ID25082[self._ID9429] = maps\mp\bots\_bots_util::entrance_visible_from( var_8.origin, maps\mp\bots\_bots_util::defend_valid_center(), "prone" );
                wait 0.05;
                var_8._ID8528[self._ID9429] = maps\mp\bots\_bots_util::entrance_visible_from( var_8.origin, maps\mp\bots\_bots_util::defend_valid_center(), "crouch" );
                wait 0.05;
            }
        }
    }

    if ( !isdefined( self._ID5540 ) )
    {
        var_10 = undefined;

        if ( isdefined( var_3 ) && isdefined( var_3["nearest_node_to_center"] ) )
            var_10 = var_3["nearest_node_to_center"];

        if ( !isdefined( var_10 ) && isdefined( self._ID5546 ) )
            var_10 = self._ID5546;

        if ( !isdefined( var_10 ) && isdefined( self.bot_defending_trigger ) && isdefined( self.bot_defending_trigger._ID21893 ) )
            var_10 = self.bot_defending_trigger._ID21893;

        if ( !isdefined( var_10 ) )
            var_10 = getclosestnodeinsight( maps\mp\bots\_bots_util::defend_valid_center() );

        if ( !isdefined( var_10 ) )
        {
            var_11 = maps\mp\bots\_bots_util::defend_valid_center();
            var_12 = getnodesinradiussorted( var_11, 256, 0 );

            for ( var_13 = 0; var_13 < var_12.size; var_13++ )
            {
                var_14 = vectornormalize( var_12[var_13].origin - var_11 );
                var_15 = var_11 + var_14 * 15;

                if ( sighttracepassed( var_15, var_12[var_13].origin, 0, undefined ) )
                {
                    var_10 = var_12[var_13];
                    break;
                }

                wait 0.05;

                if ( sighttracepassed( var_15 + ( 0, 0, 55 ), var_12[var_13].origin + ( 0, 0, 55 ), 0, undefined ) )
                {
                    var_10 = var_12[var_13];
                    break;
                }

                wait 0.05;
            }
        }

        self._ID22081 = var_10;
    }

    var_16 = level.bot_find_defend_node_func[var_2];

    if ( !isdefined( var_4 ) )
    {
        var_4 = "guard";

        if ( var_2 == "capture" || var_2 == "capture_zone" )
            var_4 = "objective";
    }

    var_17 = maps\mp\bots\_bots_util::bot_is_capturing();

    if ( var_2 == "protect" )
        childthread _ID25119();

    for (;;)
    {
        self._ID24918 = self._ID8595;
        self._ID8595 = undefined;
        self.cur_defend_angle_override = undefined;
        self.cur_defend_point_override = undefined;
        self.cur_defend_stance = calculate_defend_stance( var_17 );
        var_18 = self botgetscriptgoaltype();
        var_19 = maps\mp\bots\_bots_util::bot_goal_can_override( var_4, var_18 );

        if ( !var_19 )
        {
            wait 0.25;
            continue;
        }

        var_20 = var_5;
        var_21 = var_6;
        var_22 = 1;

        if ( isdefined( self._ID9467 ) )
        {
            self.cur_defend_point_override = self._ID9467;
            self._ID9467 = undefined;
            var_22 = 0;
            var_20 = 1.0;
            var_21 = 2.0;
        }
        else if ( isdefined( self.defense_force_next_node_goal ) )
        {
            self._ID8595 = self.defense_force_next_node_goal;
            self.defense_force_next_node_goal = undefined;
        }
        else
            self [[ var_16 ]]();

        self botclearscriptgoal();
        var_23 = "";

        if ( isdefined( self._ID8595 ) || isdefined( self.cur_defend_point_override ) )
        {
            if ( var_22 && maps\mp\bots\_bots_util::_ID5636() && !isplayer( var_0 ) && isdefined( self._ID9429 ) )
            {
                var_24 = _ID5598( "trap_directional", "trap", "c4" );

                if ( isdefined( var_24 ) )
                {
                    var_25 = maps\mp\bots\_bots_util::bot_get_entrances_for_stance_and_index( undefined, self._ID9429 );
                    bot_set_ambush_trap( var_24, var_25, self._ID22081 );
                }
            }

            if ( isdefined( self.cur_defend_point_override ) )
            {
                var_26 = undefined;

                if ( isdefined( self.cur_defend_angle_override ) )
                    var_26 = self.cur_defend_angle_override[1];

                self botsetscriptgoal( self.cur_defend_point_override, 0, var_4, var_26 );
            }
            else if ( !isdefined( self.cur_defend_angle_override ) )
                self botsetscriptgoalnode( self._ID8595, var_4 );
            else
                self botsetscriptgoalnode( self._ID8595, var_4, self.cur_defend_angle_override[1] );

            if ( var_17 )
            {
                if ( !isdefined( self._ID24918 ) || !isdefined( self._ID8595 ) || self._ID24918 != self._ID8595 )
                    self botsetstance( "none" );
            }

            var_27 = self botgetscriptgoal();
            self notify( "new_defend_goal" );
            maps\mp\bots\_bots_util::watch_nodes_stop();

            if ( var_4 == "objective" )
            {
                defense_cautious_approach();
                self botsetawareness( 1.0 );
                self botsetflag( "cautious", 0 );
            }

            if ( self bothasscriptgoal() )
            {
                var_28 = self botgetscriptgoal();

                if ( maps\mp\bots\_bots_util::_ID5824( var_28, var_27 ) )
                    var_23 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail( 20, "defend_force_node_recalculation" );
            }

            if ( var_23 == "goal" )
            {
                if ( var_17 )
                    self botsetstance( self.cur_defend_stance );

                childthread _ID9470();
            }
        }

        if ( var_23 != "goal" )
        {
            wait 0.25;
            continue;
        }

        var_29 = randomfloatrange( var_20, var_21 );
        var_23 = common_scripts\utility::_ID35637( var_29, "node_relinquished", "goal_changed", "script_goal_changed", "defend_force_node_recalculation", "bad_path" );

        if ( ( var_23 == "node_relinquished" || var_23 == "bad_path" || var_23 == "goal_changed" || var_23 == "script_goal_changed" ) && ( self.cur_defend_stance == "crouch" || self.cur_defend_stance == "prone" ) )
            self botsetstance( "none" );
    }
}

calculate_defend_stance( var_0 )
{
    var_1 = "stand";

    if ( var_0 )
    {
        var_2 = 100;
        var_3 = 0;
        var_4 = 0;
        var_5 = self botgetdifficultysetting( "strategyLevel" );

        if ( var_5 == 1 )
        {
            var_2 = 20;
            var_3 = 25;
            var_4 = 55;
        }
        else if ( var_5 >= 2 )
        {
            var_2 = 10;
            var_3 = 20;
            var_4 = 70;
        }

        var_6 = randomint( 100 );

        if ( var_6 < var_3 )
            var_1 = "crouch";
        else if ( var_6 < var_3 + var_4 )
            var_1 = "prone";

        if ( var_1 == "prone" )
        {
            var_7 = _ID5538( "prone" );
            var_8 = _ID9433( "prone" );

            if ( var_8.size >= var_7.size )
                var_1 = "crouch";
        }

        if ( var_1 == "crouch" )
        {
            var_9 = _ID5538( "crouch" );
            var_10 = _ID9433( "crouch" );

            if ( var_10.size >= var_9.size )
                var_1 = "stand";
        }
    }

    return var_1;
}

_ID29840( var_0 )
{
    var_1 = 1250;
    var_2 = var_1 * var_1;

    if ( var_0 )
    {
        if ( self botgetdifficultysetting( "strategyLevel" ) == 0 )
            return 0;

        if ( self.bot_defending_type == "capture_zone" && self istouching( self.bot_defending_trigger ) )
            return 0;

        return distancesquared( self.origin, self.bot_defending_center ) > var_2 * 0.75 * 0.75;
    }
    else if ( self botpursuingscriptgoal() && distancesquared( self.origin, self.bot_defending_center ) < var_2 )
    {
        var_3 = self botgetpathdist();
        return 0 <= var_3 && var_3 <= var_1;
    }
    else
        return 0;
}

_ID29047( var_0, var_1 )
{
    var_2 = spawnstruct();

    if ( isdefined( var_1 ) )
        var_2.origin = var_1;
    else
        var_2.origin = var_0.origin;

    var_2.node = var_0;
    var_2.frames_visible = 0;
    return var_2;
}

defense_cautious_approach()
{
    self notify( "defense_cautious_approach" );
    self endon( "defense_cautious_approach" );
    level endon( "game_ended" );
    self endon( "defend_force_node_recalculation" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "defend_stop" );
    self endon( "started_bot_defend_think" );

    if ( ![[ level.bot_funcs["should_start_cautious_approach"] ]]( 1 ) )
        return;

    var_0 = self botgetscriptgoal();
    var_1 = self botgetscriptgoalnode();
    var_2 = 1;
    var_3 = 0.2;

    while ( var_2 )
    {
        wait 0.25;

        if ( !self bothasscriptgoal() )
            return;

        var_4 = self botgetscriptgoal();

        if ( !maps\mp\bots\_bots_util::_ID5824( var_0, var_4 ) )
            return;

        var_3 += 0.25;

        if ( var_3 >= 0.5 )
        {
            var_3 = 0.0;

            if ( [[ level.bot_funcs["should_start_cautious_approach"] ]]( 0 ) )
                var_2 = 0;
        }
    }

    self botsetawareness( 1.8 );
    self botsetflag( "cautious", 1 );
    var_5 = self botgetnodesonpath();

    if ( !isdefined( var_5 ) || var_5.size <= 2 )
        return;

    self._ID20165 = [];
    var_6 = 1000;

    if ( isdefined( level._ID25118 ) )
        var_6 = level._ID25118;

    var_7 = var_6 * var_6;
    var_8 = getnodesinradius( self.bot_defending_center, var_6, 0, 500 );

    if ( var_8.size <= 0 )
        return;

    var_9 = 5 + self botgetdifficultysetting( "strategyLevel" ) * 2;
    var_10 = int( min( var_9, var_8.size ) );
    var_11 = self botnodepickmultiple( var_8, 15, var_10, "node_protect", maps\mp\bots\_bots_util::defend_valid_center(), "ignore_occupancy" );

    for ( var_12 = 0; var_12 < var_11.size; var_12++ )
    {
        var_13 = _ID29047( var_11[var_12] );
        self._ID20165 = common_scripts\utility::array_add( self._ID20165, var_13 );
    }

    var_14 = botgetmemoryevents( 0, gettime() - 60000, 1, "death", 0, self );

    foreach ( var_16 in var_14 )
    {
        if ( distancesquared( var_16, self.bot_defending_center ) < var_7 )
        {
            var_17 = getclosestnodeinsight( var_16 );

            if ( isdefined( var_17 ) )
            {
                var_13 = _ID29047( var_17, var_16 );
                self._ID20165 = common_scripts\utility::array_add( self._ID20165, var_13 );
            }
        }
    }

    if ( isdefined( self._ID9429 ) )
    {
        var_19 = maps\mp\bots\_bots_util::bot_get_entrances_for_stance_and_index( "stand", self._ID9429 );

        for ( var_12 = 0; var_12 < var_19.size; var_12++ )
        {
            var_13 = _ID29047( var_19[var_12] );
            self._ID20165 = common_scripts\utility::array_add( self._ID20165, var_13 );
        }
    }

    if ( self._ID20165.size == 0 )
        return;

    childthread monitor_cautious_approach_dangerous_locations();
    var_20 = self botgetscriptgoaltype();
    var_21 = self botgetscriptgoalradius();
    var_22 = self botgetscriptgoalyaw();
    wait 0.05;

    for ( var_23 = 1; var_23 < var_5.size - 2; var_23++ )
    {
        maps\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time();
        var_24 = getlinkednodes( var_5[var_23] );

        if ( var_24.size == 0 )
            continue;

        var_25 = [];

        for ( var_12 = 0; var_12 < var_24.size; var_12++ )
        {
            if ( !common_scripts\utility::_ID36376( self.origin, self.angles, var_24[var_12].origin, 0 ) )
                continue;

            for ( var_26 = 0; var_26 < self._ID20165.size; var_26++ )
            {
                var_16 = self._ID20165[var_26];

                if ( nodesvisible( var_16.node, var_24[var_12], 1 ) )
                {
                    var_25 = common_scripts\utility::array_add( var_25, var_24[var_12] );
                    var_26 = self._ID20165.size;
                }
            }
        }

        if ( var_25.size == 0 )
            continue;

        var_27 = self botnodepick( var_25, 1 + var_25.size * 0.15, "node_hide" );

        if ( isdefined( var_27 ) )
        {
            var_28 = [];

            for ( var_12 = 0; var_12 < self._ID20165.size; var_12++ )
            {
                if ( nodesvisible( self._ID20165[var_12].node, var_27, 1 ) )
                    var_28 = common_scripts\utility::array_add( var_28, self._ID20165[var_12] );
            }

            self botclearscriptgoal();
            self botsetscriptgoalnode( var_27, "critical" );
            childthread _ID21306();
            var_29 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail( undefined, "cautious_approach_early_out" );
            self notify( "stop_cautious_approach_early_out_monitor" );

            if ( var_29 == "cautious_approach_early_out" )
                break;

            if ( var_29 == "goal" )
            {
                for ( var_12 = 0; var_12 < var_28.size; var_12++ )
                {
                    for ( var_30 = 0; var_28[var_12].frames_visible < 18 && var_30 < 3.6; var_30 += 0.25 )
                    {
                        self botlookatpoint( var_28[var_12].origin + ( 0, 0, self getplayerviewheight() ), 0.25, "script_search" );
                        wait 0.25;
                    }
                }
            }
        }

        wait 0.05;
    }

    self notify( "stop_location_monitoring" );
    self botclearscriptgoal();

    if ( isdefined( var_1 ) )
        self botsetscriptgoalnode( var_1, var_20, var_22 );
    else
        self botsetscriptgoal( self.cur_defend_point_override, var_21, var_20, var_22 );
}

_ID21306()
{
    self endon( "cautious_approach_early_out" );
    self endon( "stop_cautious_approach_early_out_monitor" );
    var_0 = undefined;

    if ( isdefined( self.bot_defending_radius ) )
        var_0 = self.bot_defending_radius * self.bot_defending_radius;
    else if ( isdefined( self._ID5545 ) )
    {
        var_1 = bot_capture_zone_get_furthest_distance();
        var_0 = var_1 * var_1;
    }

    wait 0.05;

    for (;;)
    {
        if ( distancesquared( self.origin, self.bot_defending_center ) < var_0 )
            self notify( "cautious_approach_early_out" );

        wait 0.05;
    }
}

monitor_cautious_approach_dangerous_locations()
{
    self endon( "stop_location_monitoring" );
    var_0 = 10000;

    for (;;)
    {
        var_1 = self getnearestnode();

        if ( isdefined( var_1 ) )
        {
            var_2 = self botgetfovdot();

            for ( var_3 = 0; var_3 < self._ID20165.size; var_3++ )
            {
                if ( nodesvisible( var_1, self._ID20165[var_3].node, 1 ) )
                {
                    var_4 = common_scripts\utility::_ID36376( self.origin, self.angles, self._ID20165[var_3].origin, var_2 );
                    var_5 = !var_4 || self._ID20165[var_3].frames_visible < 17;

                    if ( var_5 && distancesquared( self.origin, self._ID20165[var_3].origin ) < var_0 )
                    {
                        var_4 = 1;
                        self._ID20165[var_3].frames_visible = 18;
                    }

                    if ( var_4 )
                    {
                        self._ID20165[var_3].frames_visible++;

                        if ( self._ID20165[var_3].frames_visible >= 18 )
                        {
                            self._ID20165[var_3] = self._ID20165[self._ID20165.size - 1];
                            self._ID20165[self._ID20165.size - 1] = undefined;
                            var_3--;
                        }
                    }
                }
            }
        }

        wait 0.05;
    }
}

_ID25119()
{
    self notify( "protect_watch_allies" );
    self endon( "protect_watch_allies" );
    var_0 = [];
    var_1 = 1050;
    var_2 = var_1 * var_1;
    var_3 = 900;

    if ( isdefined( level._ID25118 ) )
        var_3 = level._ID25118;

    for (;;)
    {
        var_4 = gettime();
        var_5 = _ID5613( self.bot_defending_center, var_3 );

        foreach ( var_7 in var_5 )
        {
            var_8 = var_7.entity_number;

            if ( !isdefined( var_8 ) )
                var_8 = var_7 getentitynumber();

            if ( !isdefined( var_0[var_8] ) )
                var_0[var_8] = var_4 - 1;

            if ( !isdefined( var_7.last_investigation_time ) )
                var_7.last_investigation_time = var_4 - 10001;

            if ( var_7.health == 0 && isdefined( var_7._ID9101 ) && var_4 - var_7._ID9101 < 5000 )
            {
                if ( var_4 - var_7.last_investigation_time > 10000 && var_4 > var_0[var_8] )
                {
                    if ( isdefined( var_7.lastattacker ) && isdefined( var_7.lastattacker.team ) && var_7.lastattacker.team == common_scripts\utility::_ID14447( self.team ) )
                    {
                        if ( distancesquared( var_7.origin, self.origin ) < var_2 )
                        {
                            self botgetimperfectenemyinfo( var_7.lastattacker, var_7.origin );
                            var_9 = getclosestnodeinsight( var_7.origin );

                            if ( isdefined( var_9 ) )
                            {
                                self._ID9467 = var_9.origin;
                                self notify( "defend_force_node_recalculation" );
                            }

                            var_7.last_investigation_time = var_4;
                        }

                        var_0[var_8] = var_4 + 10000;
                    }
                }
            }
        }

        wait(( randomint( 5 ) + 1 ) * 0.05);
    }
}

defense_get_initial_entrances()
{
    if ( isdefined( self.defense_override_entrances ) )
        return self.defense_override_entrances;
    else if ( maps\mp\bots\_bots_util::bot_is_capturing() )
        return _ID5538( self.cur_defend_stance );
    else if ( maps\mp\bots\_bots_util::_ID5636() || maps\mp\bots\_bots_util::bot_is_bodyguarding() )
    {
        var_0 = findentrances( self.origin );
        return var_0;
    }
}

_ID9470()
{
    self notify( "defense_watch_entrances_at_goal" );
    self endon( "defense_watch_entrances_at_goal" );
    self endon( "new_defend_goal" );
    self endon( "script_goal_changed" );
    var_0 = self getnearestnode();
    var_1 = undefined;

    if ( maps\mp\bots\_bots_util::bot_is_capturing() )
    {
        var_2 = defense_get_initial_entrances();
        var_1 = [];

        if ( isdefined( var_0 ) )
        {
            foreach ( var_4 in var_2 )
            {
                if ( nodesvisible( var_0, var_4, 1 ) )
                    var_1 = common_scripts\utility::array_add( var_1, var_4 );
            }
        }
    }
    else if ( maps\mp\bots\_bots_util::_ID5636() || maps\mp\bots\_bots_util::bot_is_bodyguarding() )
    {
        var_1 = defense_get_initial_entrances();

        if ( isdefined( var_0 ) && !issubstr( self getcurrentweapon(), "riotshield" ) )
        {
            if ( nodesvisible( var_0, self._ID22081, 1 ) )
                var_1 = common_scripts\utility::array_add( var_1, self._ID22081 );
        }
    }

    if ( isdefined( var_1 ) )
    {
        childthread maps\mp\bots\_bots_util::bot_watch_nodes( var_1 );

        if ( maps\mp\bots\_bots_util::bot_is_bodyguarding() )
            childthread bot_monitor_watch_entrances_bodyguard();
        else
            childthread _ID5692();
    }
}

_ID5692()
{
    self notify( "bot_monitor_watch_entrances_at_goal" );
    self endon( "bot_monitor_watch_entrances_at_goal" );
    self notify( "bot_monitor_watch_entrances" );
    self endon( "bot_monitor_watch_entrances" );

    while ( !isdefined( self._ID35991 ) )
        wait 0.05;

    var_0 = level.bot_funcs["get_watch_node_chance"];

    for (;;)
    {
        foreach ( var_2 in self._ID35991 )
        {
            if ( var_2 == self._ID22081 )
            {
                var_2._ID35990[self.entity_number] = 0.8;
                continue;
            }

            var_2._ID35990[self.entity_number] = 1.0;
        }

        var_4 = isdefined( var_0 );

        if ( !var_4 )
            prioritize_watch_nodes_toward_enemies( 0.5 );

        foreach ( var_2 in self._ID35991 )
        {
            if ( var_4 )
            {
                var_6 = self [[ var_0 ]]( var_2 );
                var_2._ID35990[self.entity_number] = var_2._ID35990[self.entity_number] * var_6;
            }

            if ( _ID12160( var_2 ) )
                var_2._ID35990[self.entity_number] = var_2._ID35990[self.entity_number] * 0.5;
        }

        wait(randomfloatrange( 0.5, 0.75 ));
    }
}

bot_monitor_watch_entrances_bodyguard()
{
    self notify( "bot_monitor_watch_entrances_bodyguard" );
    self endon( "bot_monitor_watch_entrances_bodyguard" );
    self notify( "bot_monitor_watch_entrances" );
    self endon( "bot_monitor_watch_entrances" );

    while ( !isdefined( self._ID35991 ) )
        wait 0.05;

    for (;;)
    {
        var_0 = anglestoforward( self._ID5540.angles ) * ( 1, 1, 0 );
        var_0 = vectornormalize( var_0 );

        foreach ( var_2 in self._ID35991 )
        {
            var_2._ID35990[self.entity_number] = 1.0;
            var_3 = var_2.origin - self._ID5540.origin;
            var_3 = vectornormalize( var_3 );
            var_4 = vectordot( var_0, var_3 );

            if ( var_4 > 0.6 )
                var_2._ID35990[self.entity_number] = var_2._ID35990[self.entity_number] * 0.33;
            else if ( var_4 > 0 )
                var_2._ID35990[self.entity_number] = var_2._ID35990[self.entity_number] * 0.66;

            if ( !_ID12158( var_2 ) )
                var_2._ID35990[self.entity_number] = var_2._ID35990[self.entity_number] * 0.5;
        }

        wait(randomfloatrange( 0.4, 0.6 ));
    }
}

_ID12158( var_0 )
{
    var_1 = getnodezone( var_0 );
    var_2 = vectornormalize( var_0.origin - self.origin );

    for ( var_3 = 0; var_3 < level._ID36588; var_3++ )
    {
        if ( botzonegetcount( var_3, self.team, "enemy_predict" ) > 0 )
        {
            if ( isdefined( var_1 ) && var_3 == var_1 )
                return 1;
            else
            {
                var_4 = vectornormalize( getzoneorigin( var_3 ) - self.origin );
                var_5 = vectordot( var_2, var_4 );

                if ( var_5 > 0.2 )
                    return 1;
            }
        }
    }

    return 0;
}

prioritize_watch_nodes_toward_enemies( var_0 )
{
    if ( self._ID35991.size <= 0 )
        return;

    var_1 = self._ID35991;

    for ( var_2 = 0; var_2 < level._ID36588; var_2++ )
    {
        if ( botzonegetcount( var_2, self.team, "enemy_predict" ) <= 0 )
            continue;

        if ( var_1.size == 0 )
            break;

        var_3 = vectornormalize( getzoneorigin( var_2 ) - self.origin );

        for ( var_4 = 0; var_4 < var_1.size; var_4++ )
        {
            var_5 = getnodezone( var_1[var_4] );
            var_6 = 0;

            if ( isdefined( var_5 ) && var_2 == var_5 )
                var_6 = 1;
            else
            {
                var_7 = vectornormalize( var_1[var_4].origin - self.origin );
                var_8 = vectordot( var_7, var_3 );

                if ( var_8 > 0.2 )
                    var_6 = 1;
            }

            if ( var_6 )
            {
                var_1[var_4]._ID35990[self.entity_number] = var_1[var_4]._ID35990[self.entity_number] * var_0;
                var_1[var_4] = var_1[var_1.size - 1];
                var_1[var_1.size - 1] = undefined;
                var_4--;
            }
        }
    }
}

_ID12160( var_0 )
{
    var_1 = bot_get_teammates_currently_defending_point( self.bot_defending_center );

    foreach ( var_3 in var_1 )
    {
        if ( entrance_watched_by_player( var_3, var_0 ) )
            return 1;
    }

    return 0;
}

entrance_watched_by_player( var_0, var_1 )
{
    var_2 = anglestoforward( var_0.angles );
    var_3 = vectornormalize( var_1.origin - var_0.origin );
    var_4 = vectordot( var_2, var_3 );

    if ( var_4 > 0.6 )
        return 1;

    return 0;
}

bot_get_teammates_currently_defending_point( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
    {
        if ( isdefined( level._ID25118 ) )
            var_1 = level._ID25118;
        else
            var_1 = 900;
    }

    var_2 = [];
    var_3 = _ID5613( var_0, var_1 );

    foreach ( var_5 in var_3 )
    {
        if ( !isai( var_5 ) || var_5 maps\mp\bots\_bots_util::bot_is_defending_point( var_0 ) )
            var_2 = common_scripts\utility::array_add( var_2, var_5 );
    }

    return var_2;
}

_ID5613( var_0, var_1 )
{
    var_2 = var_1 * var_1;
    var_3 = [];

    for ( var_4 = 0; var_4 < level._ID23303.size; var_4++ )
    {
        var_5 = level._ID23303[var_4];

        if ( var_5 != self && isdefined( var_5.team ) && var_5.team == self.team && maps\mp\_utility::_ID18820( var_5 ) )
        {
            if ( distancesquared( var_0, var_5.origin ) < var_2 )
                var_3 = common_scripts\utility::array_add( var_3, var_5 );
        }
    }

    return var_3;
}

defense_death_monitor()
{
    level endon( "game_ended" );
    self endon( "started_bot_defend_think" );
    self endon( "defend_stop" );
    self endon( "disconnect" );
    self waittill( "death" );

    if ( isdefined( self ) )
        thread bot_defend_stop();
}

bot_defend_stop()
{
    self notify( "defend_stop" );
    self.bot_defending = undefined;
    self.bot_defending_center = undefined;
    self.bot_defending_radius = undefined;
    self._ID5545 = undefined;
    self.bot_defending_type = undefined;
    self.bot_defending_trigger = undefined;
    self._ID5546 = undefined;
    self._ID5540 = undefined;
    self._ID9469 = undefined;
    self._ID22081 = undefined;
    self._ID9467 = undefined;
    self.defense_force_next_node_goal = undefined;
    self._ID24918 = undefined;
    self._ID8595 = undefined;
    self.cur_defend_angle_override = undefined;
    self.cur_defend_point_override = undefined;
    self._ID9429 = undefined;
    self.defense_override_entrances = undefined;
    self botclearscriptgoal();
    self botsetstance( "none" );
}

_ID9433( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level._ID23303 )
    {
        if ( !isdefined( var_3.team ) )
            continue;

        if ( var_3.team == self.team && var_3 != self && isai( var_3 ) && var_3 maps\mp\bots\_bots_util::bot_is_defending() && var_3.cur_defend_stance == var_0 )
        {
            if ( var_3.bot_defending_type == self.bot_defending_type && maps\mp\bots\_bots_util::bot_is_defending_point( var_3.bot_defending_center ) )
                var_1 = common_scripts\utility::array_add( var_1, var_3 );
        }
    }

    return var_1;
}

_ID21312()
{
    var_0 = 0;
    var_1 = 175;
    var_2 = self._ID5540.origin;
    var_3 = 0;
    var_4 = 0;

    for (;;)
    {
        if ( !isdefined( self._ID5540 ) )
            thread bot_defend_stop();

        if ( self._ID5540 islinked() )
        {
            wait 0.05;
            continue;
        }

        self.bot_defending_center = self._ID5540.origin;
        self._ID22081 = self._ID5540 getnearestnode();

        if ( !isdefined( self._ID22081 ) )
            self._ID22081 = self getnearestnode();

        if ( self botgetscriptgoaltype() != "none" )
        {
            var_5 = self botgetscriptgoal();
            var_6 = self._ID5540 getvelocity();
            var_7 = lengthsquared( var_6 );

            if ( var_7 > 100 )
            {
                var_0 = 0;

                if ( distancesquared( var_2, self._ID5540.origin ) > var_1 * var_1 )
                {
                    var_2 = self._ID5540.origin;
                    var_4 = 1;
                    var_8 = vectornormalize( var_5 - self._ID5540.origin );
                    var_9 = vectornormalize( var_6 );

                    if ( vectordot( var_8, var_9 ) < 0.1 )
                    {
                        self notify( "defend_force_node_recalculation" );
                        wait 0.25;
                    }
                }
            }
            else
            {
                var_0 += 0.05;

                if ( var_3 > 100 && var_4 )
                {
                    var_2 = self._ID5540.origin;
                    var_4 = 0;
                }

                if ( var_0 > 0.5 )
                {
                    var_10 = distancesquared( var_5, self.bot_defending_center );

                    if ( var_10 > self.bot_defending_radius * self.bot_defending_radius )
                    {
                        self notify( "defend_force_node_recalculation" );
                        wait 0.25;
                    }
                }
            }

            var_3 = var_7;

            if ( abs( self._ID5540.origin[2] - var_5[2] ) >= 50 )
            {
                self notify( "defend_force_node_recalculation" );
                wait 0.25;
            }
        }

        wait 0.05;
    }
}

find_defend_node_capture()
{
    var_0 = bot_defend_get_random_entrance_point_for_current_area();
    var_1 = maps\mp\bots\_bots_util::bot_find_node_to_capture_point( maps\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_radius, var_0 );

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_0 ) )
        {
            var_2 = vectornormalize( var_0 - var_1.origin );
            self.cur_defend_angle_override = vectortoangles( var_2 );
        }
        else
        {
            var_3 = vectornormalize( var_1.origin - maps\mp\bots\_bots_util::defend_valid_center() );
            self.cur_defend_angle_override = vectortoangles( var_3 );
        }

        self._ID8595 = var_1;
    }
    else if ( isdefined( var_0 ) )
        _ID5620( var_0, undefined );
    else
        _ID5620( undefined, maps\mp\bots\_bots_util::defend_valid_center() );
}

_ID12903()
{
    var_0 = bot_defend_get_random_entrance_point_for_current_area();
    var_1 = maps\mp\bots\_bots_util::_ID5568( self._ID5545, var_0 );

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_0 ) )
        {
            var_2 = vectornormalize( var_0 - var_1.origin );
            self.cur_defend_angle_override = vectortoangles( var_2 );
        }
        else
        {
            var_3 = vectornormalize( var_1.origin - maps\mp\bots\_bots_util::defend_valid_center() );
            self.cur_defend_angle_override = vectortoangles( var_3 );
        }

        self._ID8595 = var_1;
    }
    else if ( isdefined( var_0 ) )
        _ID5620( var_0, undefined );
    else
        _ID5620( undefined, maps\mp\bots\_bots_util::defend_valid_center() );
}

find_defend_node_protect()
{
    var_0 = maps\mp\bots\_bots_util::bot_find_node_that_protects_point( maps\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_radius );

    if ( isdefined( var_0 ) )
    {
        var_1 = vectornormalize( maps\mp\bots\_bots_util::defend_valid_center() - var_0.origin );
        self.cur_defend_angle_override = vectortoangles( var_1 );
        self._ID8595 = var_0;
    }
    else
        _ID5620( maps\mp\bots\_bots_util::defend_valid_center(), undefined );
}

_ID12901()
{
    var_0 = maps\mp\bots\_bots_util::bot_find_node_to_guard_player( maps\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_radius );

    if ( isdefined( var_0 ) )
        self._ID8595 = var_0;
    else
    {
        var_1 = self getnearestnode();

        if ( isdefined( var_1 ) )
            self._ID8595 = var_1;
        else
            self.cur_defend_point_override = self.origin;
    }
}

_ID12904()
{
    var_0 = undefined;
    var_1 = getnodesinradius( maps\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_radius, 0 );

    if ( isdefined( var_1 ) && var_1.size > 0 )
        var_0 = self botnodepick( var_1, 1 + var_1.size * 0.5, "node_traffic" );

    if ( isdefined( var_0 ) )
        self._ID8595 = var_0;
    else
        _ID5620( undefined, maps\mp\bots\_bots_util::defend_valid_center() );
}

_ID5620( var_0, var_1 )
{
    if ( self.bot_defending_type == "capture_zone" )
        self.cur_defend_point_override = maps\mp\bots\_bots_util::bot_pick_random_point_from_set( maps\mp\bots\_bots_util::defend_valid_center(), self._ID5545, ::bot_can_use_point_in_defend );
    else
        self.cur_defend_point_override = maps\mp\bots\_bots_util::_ID5727( maps\mp\bots\_bots_util::defend_valid_center(), self.bot_defending_radius, ::bot_can_use_point_in_defend, 0.15, 0.9 );

    if ( isdefined( var_0 ) )
    {
        var_2 = vectornormalize( var_0 - self.cur_defend_point_override );
        self.cur_defend_angle_override = vectortoangles( var_2 );
    }
    else if ( isdefined( var_1 ) )
    {
        var_2 = vectornormalize( self.cur_defend_point_override - var_1 );
        self.cur_defend_angle_override = vectortoangles( var_2 );
    }
}

bot_can_use_point_in_defend( var_0 )
{
    if ( bot_check_team_is_using_position( var_0, 1, 1, 1 ) )
        return 0;

    return 1;
}

bot_check_team_is_using_position( var_0, var_1, var_2, var_3 )
{
    for ( var_4 = 0; var_4 < level._ID23303.size; var_4++ )
    {
        var_5 = level._ID23303[var_4];

        if ( var_5.team == self.team && var_5 != self )
        {
            if ( isai( var_5 ) )
            {
                if ( var_2 )
                {
                    if ( distancesquared( var_0, var_5.origin ) < 441 )
                        return 1;
                }

                if ( var_3 && var_5 bothasscriptgoal() )
                {
                    var_6 = var_5 botgetscriptgoal();

                    if ( distancesquared( var_0, var_6 ) < 441 )
                        return 1;
                }

                continue;
            }

            if ( var_1 )
            {
                if ( distancesquared( var_0, var_5.origin ) < 441 )
                    return 1;
            }
        }
    }

    return 0;
}

bot_capture_zone_get_furthest_distance()
{
    var_0 = 0;

    if ( isdefined( self._ID5545 ) )
    {
        foreach ( var_2 in self._ID5545 )
        {
            var_3 = distance( self.bot_defending_center, var_2.origin );
            var_0 = max( var_3, var_0 );
        }
    }

    return var_0;
}

bot_think_tactical_goals()
{
    self notify( "bot_think_tactical_goals" );
    self endon( "bot_think_tactical_goals" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self._ID32346 = [];

    for (;;)
    {
        if ( self._ID32346.size > 0 && !maps\mp\bots\_bots_util::bot_is_remote_or_linked() )
        {
            var_0 = self._ID32346[0];

            if ( !isdefined( var_0.abort ) )
            {
                self notify( "start_tactical_goal" );

                if ( isdefined( var_0._ID31408 ) )
                    self [[ var_0._ID31408 ]]( var_0 );

                childthread _ID35978( var_0 );
                var_1 = "tactical";

                if ( isdefined( var_0._ID15722 ) )
                    var_1 = var_0._ID15722;

                self botsetscriptgoal( var_0._ID15718, var_0._ID15719, var_1, var_0.goal_yaw, var_0._ID22485 );
                var_2 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail( undefined, "stop_tactical_goal" );
                self notify( "stop_goal_aborted_watch" );

                if ( var_2 == "goal" )
                {
                    if ( isdefined( var_0.action_thread ) )
                        self [[ var_0.action_thread ]]( var_0 );
                }

                if ( var_2 != "script_goal_changed" )
                    self botclearscriptgoal();

                if ( isdefined( var_0.end_thread ) )
                    self [[ var_0.end_thread ]]( var_0 );
            }

            self._ID32346 = common_scripts\utility::array_remove( self._ID32346, var_0 );
        }

        wait 0.05;
    }
}

_ID35978( var_0 )
{
    self endon( "stop_tactical_goal" );
    self endon( "stop_goal_aborted_watch" );
    wait 0.05;

    for (;;)
    {
        if ( isdefined( var_0.abort ) || isdefined( var_0._ID29800 ) && self [[ var_0._ID29800 ]]( var_0 ) )
            self notify( "stop_tactical_goal" );

        wait 0.05;
    }
}

bot_new_tactical_goal( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4.type = var_0;
    var_4._ID15718 = var_1;

    if ( isdefined( self.only_allowable_tactical_goals ) )
    {
        if ( !common_scripts\utility::array_contains( self.only_allowable_tactical_goals, var_0 ) )
            return;
    }

    var_4._ID25014 = var_2;
    var_4._ID22470 = var_3._ID22470;
    var_4._ID15722 = var_3._ID27624;
    var_4.goal_yaw = var_3._ID27625;
    var_4._ID15719 = 0;

    if ( isdefined( var_3.script_goal_radius ) )
        var_4._ID15719 = var_3.script_goal_radius;

    var_4._ID31408 = var_3._ID31408;
    var_4.end_thread = var_3.end_thread;
    var_4._ID29800 = var_3._ID29800;
    var_4.action_thread = var_3.action_thread;
    var_4._ID22485 = var_3._ID22485;

    for ( var_5 = 0; var_5 < self._ID32346.size; var_5++ )
    {
        if ( var_4._ID25014 > self._ID32346[var_5]._ID25014 )
            break;
    }

    for ( var_6 = self._ID32346.size - 1; var_6 >= var_5; var_6-- )
        self._ID32346[var_6 + 1] = self._ID32346[var_6];

    self._ID32346[var_5] = var_4;
}

bot_has_tactical_goal( var_0, var_1 )
{
    if ( !isdefined( self._ID32346 ) )
        return 0;

    if ( isdefined( var_0 ) )
    {
        foreach ( var_3 in self._ID32346 )
        {
            if ( var_3.type == var_0 )
            {
                if ( isdefined( var_1 ) && isdefined( var_3._ID22470 ) )
                {
                    return var_3._ID22470 == var_1;
                    continue;
                }

                return 1;
            }
        }

        return 0;
    }
    else
        return self._ID32346.size > 0;
}

bot_abort_tactical_goal( var_0, var_1 )
{
    if ( !isdefined( self._ID32346 ) )
        return;

    foreach ( var_3 in self._ID32346 )
    {
        if ( var_3.type == var_0 )
        {
            if ( isdefined( var_1 ) )
            {
                if ( isdefined( var_3._ID22470 ) && var_3._ID22470 == var_1 )
                    var_3.abort = 1;

                continue;
            }

            var_3.abort = 1;
        }
    }
}

bot_disable_tactical_goals()
{
    self.only_allowable_tactical_goals[0] = "map_interactive_object";

    foreach ( var_1 in self._ID32346 )
    {
        if ( var_1.type != "map_interactive_object" )
            var_1.abort = 1;
    }
}

bot_enable_tactical_goals()
{
    self.only_allowable_tactical_goals = undefined;
}

bot_melee_tactical_insertion_check()
{
    var_0 = gettime();

    if ( !isdefined( self._ID19472 ) || var_0 - self._ID19472 > 1000 )
    {
        self._ID19472 = var_0;
        var_1 = _ID5598( "tacticalinsertion" );

        if ( !isdefined( var_1 ) )
            return 0;

        if ( isdefined( self.enemy ) && self botcanseeentity( self.enemy ) )
            return 0;

        var_2 = getzonenearest( self.origin );

        if ( !isdefined( var_2 ) )
            return 0;

        var_3 = botzonenearestcount( var_2, self.team, 1, "enemy_predict", ">", 0 );

        if ( !isdefined( var_3 ) )
            return 0;

        var_4 = getnodesinradius( self.origin, 500, 0 );

        if ( var_4.size <= 0 )
            return 0;

        var_5 = self botnodepick( var_4, var_4.size * 0.15, "node_hide" );

        if ( !isdefined( var_5 ) )
            return 0;

        return bot_set_ambush_trap( var_1, undefined, undefined, undefined, var_5 );
    }

    return 0;
}
