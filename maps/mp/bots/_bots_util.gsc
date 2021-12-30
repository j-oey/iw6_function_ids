// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

bot_get_nodes_in_cone( var_0, var_1, var_2 )
{
    var_3 = getnodesinradius( self.origin, var_0, 0 );
    var_4 = [];
    var_5 = self getnearestnode();
    var_6 = anglestoforward( self getplayerangles() );
    var_7 = vectornormalize( var_6 * ( 1, 1, 0 ) );

    foreach ( var_9 in var_3 )
    {
        var_10 = vectornormalize( ( var_9.origin - self.origin ) * ( 1, 1, 0 ) );
        var_11 = vectordot( var_10, var_7 );

        if ( var_11 > var_1 )
        {
            if ( !var_2 || isdefined( var_5 ) && nodesvisible( var_9, var_5, 1 ) )
                var_4 = common_scripts\utility::array_add( var_4, var_9 );
        }
    }

    return var_4;
}

bot_goal_can_override( var_0, var_1 )
{
    if ( var_0 == "none" )
        return var_1 == "none";
    else if ( var_0 == "hunt" )
        return var_1 == "hunt" || var_1 == "none";
    else if ( var_0 == "guard" )
        return var_1 == "guard" || var_1 == "hunt" || var_1 == "none";
    else if ( var_0 == "objective" )
        return var_1 == "objective" || var_1 == "guard" || var_1 == "hunt" || var_1 == "none";
    else if ( var_0 == "critical" )
        return var_1 == "critical" || var_1 == "objective" || var_1 == "guard" || var_1 == "hunt" || var_1 == "none";
    else if ( var_0 == "tactical" )
        return 1;
}

bot_set_personality( var_0 )
{
    self botsetpersonality( var_0 );
    maps\mp\bots\_bots_personality::_ID5500();
    self botclearscriptgoal();
}

bot_set_difficulty( var_0 )
{
    if ( var_0 == "default" )
        var_0 = bot_choose_difficulty_for_default();

    self botsetdifficulty( var_0 );

    if ( isplayer( self ) )
    {
        self.pers["rankxp"] = maps\mp\_utility::_ID14714();
        maps\mp\gametypes\_rank::playerupdaterank();
    }
}

bot_choose_difficulty_for_default()
{
    if ( !isdefined( level._ID5551 ) )
    {
        level._ID5551 = [];
        level._ID5551[level._ID5551.size] = "recruit";
        level._ID5551[level._ID5551.size] = "regular";
        level._ID5551[level._ID5551.size] = "hardened";
    }

    var_0 = self.bot_chosen_difficulty;

    if ( !isdefined( var_0 ) )
    {
        var_1 = [];
        var_2 = self.team;

        if ( !isdefined( var_2 ) )
            var_2 = self._ID5801;

        if ( !isdefined( var_2 ) )
            var_2 = self.pers["team"];

        if ( !isdefined( var_2 ) )
            var_2 = "allies";

        foreach ( var_4 in level.players )
        {
            if ( var_4 == self )
                continue;

            if ( !isai( var_4 ) )
                continue;

            var_5 = var_4 botgetdifficulty();

            if ( var_5 == "default" )
                continue;

            var_6 = var_4.team;

            if ( !isdefined( var_6 ) )
                var_6 = var_4._ID5801;

            if ( !isdefined( var_6 ) )
                var_6 = var_4.pers["team"];

            if ( !isdefined( var_6 ) )
                continue;

            if ( !isdefined( var_1[var_6] ) )
                var_1[var_6] = [];

            if ( !isdefined( var_1[var_6][var_5] ) )
            {
                var_1[var_6][var_5] = 1;
                continue;
            }

            var_1[var_6][var_5]++;
        }

        var_8 = -1;

        foreach ( var_10 in level._ID5551 )
        {
            if ( !isdefined( var_1[var_2] ) || !isdefined( var_1[var_2][var_10] ) )
            {
                var_0 = var_10;
                break;
                continue;
            }

            if ( var_8 == -1 || var_1[var_2][var_10] < var_8 )
            {
                var_8 = var_1[var_2][var_10];
                var_0 = var_10;
            }
        }
    }

    if ( isdefined( var_0 ) )
        self.bot_chosen_difficulty = var_0;

    return var_0;
}

bot_is_capturing()
{
    if ( bot_is_defending() )
    {
        if ( self.bot_defending_type == "capture" || self.bot_defending_type == "capture_zone" )
            return 1;
    }

    return 0;
}

_ID5635()
{
    if ( bot_is_defending() )
    {
        if ( self.bot_defending_type == "patrol" )
            return 1;
    }

    return 0;
}

_ID5636()
{
    if ( bot_is_defending() )
    {
        if ( self.bot_defending_type == "protect" )
            return 1;
    }

    return 0;
}

bot_is_bodyguarding()
{
    if ( bot_is_defending() )
    {
        if ( self.bot_defending_type == "bodyguard" )
            return 1;
    }

    return 0;
}

bot_is_defending()
{
    return isdefined( self.bot_defending );
}

bot_is_defending_point( var_0 )
{
    if ( bot_is_defending() )
    {
        if ( _ID5824( self.bot_defending_center, var_0 ) )
            return 1;
    }

    return 0;
}

bot_is_guarding_player( var_0 )
{
    if ( bot_is_bodyguarding() && self._ID5540 == var_0 )
        return 1;

    return 0;
}

bot_cache_entrances_to_bombzones()
{
    var_0 = [];
    var_1 = [];
    var_2 = 0;

    foreach ( var_4 in level.bombzones )
    {
        var_0[var_2] = common_scripts\utility::_ID25350( var_4.bottargets ).origin;
        var_1[var_2] = "zone" + var_4.label;
        var_2++;
    }

    bot_cache_entrances( var_0, var_1 );
}

bot_cache_entrances_to_flags_or_radios( var_0, var_1 )
{
    wait 1.0;
    var_2 = [];
    var_3 = [];

    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        if ( isdefined( var_0[var_4].bottarget ) )
            var_2[var_4] = var_0[var_4].bottarget.origin;
        else
        {
            var_0[var_4]._ID21893 = getclosestnodeinsight( var_0[var_4].origin );
            var_2[var_4] = var_0[var_4]._ID21893.origin;
        }

        var_3[var_4] = var_1 + var_0[var_4]._ID27658;
    }

    bot_cache_entrances( var_2, var_3 );
}

entrance_visible_from( var_0, var_1, var_2 )
{
    var_3 = ( 0, 0, 11 );
    var_4 = ( 0, 0, 40 );
    var_5 = undefined;

    if ( var_2 == "stand" )
        return 1;
    else if ( var_2 == "crouch" )
        var_5 = var_4;
    else if ( var_2 == "prone" )
        var_5 = var_3;

    return sighttracepassed( var_1 + var_5, var_0 + var_5, 0, undefined );
}

bot_cache_entrances( var_0, var_1 )
{
    wait 0.1;
    var_2 = [];

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        var_4 = var_1[var_3];
        var_2[var_4] = findentrances( var_0[var_3] );
        wait 0.05;

        for ( var_5 = 0; var_5 < var_2[var_4].size; var_5++ )
        {
            var_6 = var_2[var_4][var_5];
            var_6.is_precalculated_entrance = 1;
            var_6._ID25082[var_4] = entrance_visible_from( var_6.origin, var_0[var_3], "prone" );
            wait 0.05;
            var_6._ID8528[var_4] = entrance_visible_from( var_6.origin, var_0[var_3], "crouch" );
            wait 0.05;

            for ( var_7 = 0; var_7 < var_1.size; var_7++ )
            {
                for ( var_8 = var_7 + 1; var_8 < var_1.size; var_8++ )
                {
                    var_6._ID22761[var_1[var_7]][var_1[var_8]] = 0;
                    var_6._ID22761[var_1[var_8]][var_1[var_7]] = 0;
                }
            }
        }
    }

    var_9 = [];

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        for ( var_5 = var_3 + 1; var_5 < var_0.size; var_5++ )
        {
            var_10 = _ID14456( var_0[var_3], var_0[var_5] );
            var_9[var_1[var_3]][var_1[var_5]] = var_10;
            var_9[var_1[var_5]][var_1[var_3]] = var_10;

            foreach ( var_12 in var_10 )
            {
                var_12._ID22761[var_1[var_3]][var_1[var_5]] = 1;
                var_12._ID22761[var_1[var_5]][var_1[var_3]] = 1;
            }
        }
    }

    if ( !isdefined( level._ID24854 ) )
        level._ID24854 = [];

    if ( !isdefined( level._ID12155 ) )
        level._ID12155 = [];

    if ( !isdefined( level._ID12154 ) )
        level._ID12154 = [];

    if ( !isdefined( level.entrance_points ) )
        level.entrance_points = [];

    level._ID24854 = common_scripts\utility::array_combine_non_integer_indices( level._ID24854, var_9 );
    level._ID12155 = common_scripts\utility::array_combine( level._ID12155, var_0 );
    level._ID12154 = common_scripts\utility::array_combine( level._ID12154, var_1 );
    level.entrance_points = common_scripts\utility::array_combine_non_integer_indices( level.entrance_points, var_2 );
    level._ID12157 = 1;
}

_ID14456( var_0, var_1 )
{
    var_2 = func_get_nodes_on_path( var_0, var_1 );

    if ( isdefined( var_2 ) )
    {
        var_2 = _ID25887( var_2 );
        var_2 = _ID14268( var_2 );
    }

    return var_2;
}

_ID13740( var_0, var_1 )
{
    return getpathdist( var_0, var_1 );
}

func_get_nodes_on_path( var_0, var_1 )
{
    return getnodesonpath( var_0, var_1 );
}

_ID13734( var_0, var_1, var_2 )
{
    return botgetclosestnavigablepoint( var_0, var_1, var_2 );
}

_ID22085( var_0, var_1 )
{
    if ( !isdefined( self._ID22761 ) || !isdefined( self._ID22761[var_0] ) || !isdefined( self._ID22761[var_0][var_1] ) )
        return 0;

    return self._ID22761[var_0][var_1];
}

_ID14268( var_0 )
{
    var_1 = var_0;

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        var_3 = getlinkednodes( var_0[var_2] );

        for ( var_4 = 0; var_4 < var_3.size; var_4++ )
        {
            if ( !common_scripts\utility::array_contains( var_1, var_3[var_4] ) )
                var_1 = common_scripts\utility::array_add( var_1, var_3[var_4] );
        }
    }

    return var_1;
}

_ID14833( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        if ( nodesvisible( var_4, var_1, 1 ) )
            var_2 = common_scripts\utility::array_add( var_2, var_4 );
    }

    return var_2;
}

_ID25887( var_0 )
{
    var_0[var_0.size - 1] = undefined;
    var_0[0] = undefined;
    return common_scripts\utility::array_removeundefined( var_0 );
}

_ID5828( var_0 )
{
    var_1 = 1;

    while ( !bot_bots_enabled_or_added( var_0 ) )
        wait 0.5;
}

bot_bots_enabled_or_added( var_0 )
{
    if ( botautoconnectenabled() )
        return 1;

    if ( bots_exist( var_0 ) )
        return 1;

    return 0;
}

bot_waittill_out_of_combat_or_time( var_0 )
{
    var_1 = gettime();

    for (;;)
    {
        if ( isdefined( var_0 ) )
        {
            if ( gettime() > var_1 + var_0 )
                return;
        }

        if ( !isdefined( self.enemy ) )
            return;
        else if ( !bot_in_combat() )
            return;

        wait 0.05;
    }
}

bot_in_combat( var_0 )
{
    var_1 = gettime() - self.last_enemy_sight_time;
    var_2 = level._ID5715;

    if ( isdefined( var_0 ) )
        var_2 = var_0;

    return var_1 < var_2;
}

bot_waittill_goal_or_fail( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) && isdefined( var_2 ) )
    {

    }

    var_3 = [ "goal", "bad_path", "no_path", "node_relinquished", "script_goal_changed" ];

    if ( isdefined( var_1 ) )
        var_3[var_3.size] = var_1;

    if ( isdefined( var_2 ) )
        var_3[var_3.size] = var_2;

    if ( isdefined( var_0 ) )
        var_4 = common_scripts\utility::_ID35628( var_3, var_0 );
    else
        var_4 = common_scripts\utility::_ID35630( var_3 );

    return var_4;
}

bot_usebutton_wait( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    childthread _ID34683();
    var_3 = common_scripts\utility::_ID35637( var_0, var_1, var_2, "use_button_no_longer_pressed", "finished_use" );
    self notify( "stop_usebutton_watcher" );
    return var_3;
}

_ID34683( var_0, var_1 )
{
    self endon( "stop_usebutton_watcher" );
    wait 0.05;

    while ( self usebuttonpressed() )
        wait 0.05;

    self notify( "use_button_no_longer_pressed" );
}

bots_exist( var_0 )
{
    foreach ( var_2 in level._ID23303 )
    {
        if ( isai( var_2 ) )
        {
            if ( isdefined( var_0 ) && var_0 )
            {
                if ( !maps\mp\_utility::_ID18820( var_2 ) )
                    continue;
            }

            return 1;
        }
    }

    return 0;
}

bot_get_entrances_for_stance_and_index( var_0, var_1 )
{
    if ( !isdefined( level._ID12157 ) && !isdefined( self.defense_override_entrances ) )
        return undefined;

    var_2 = [];

    if ( isdefined( self.defense_override_entrances ) )
        var_2 = self.defense_override_entrances;
    else
        var_2 = level.entrance_points[var_1];

    if ( !isdefined( var_0 ) || var_0 == "stand" )
        return var_2;
    else if ( var_0 == "crouch" )
    {
        var_3 = [];

        foreach ( var_5 in var_2 )
        {
            if ( var_5._ID8528[var_1] )
                var_3 = common_scripts\utility::array_add( var_3, var_5 );
        }

        return var_3;
    }
    else if ( var_0 == "prone" )
    {
        var_3 = [];

        foreach ( var_5 in var_2 )
        {
            if ( var_5._ID25082[var_1] )
                var_3 = common_scripts\utility::array_add( var_3, var_5 );
        }

        return var_3;
    }

    return undefined;
}

bot_find_node_to_guard_player( var_0, var_1, var_2 )
{
    var_3 = undefined;
    var_4 = self._ID5540 getvelocity();

    if ( lengthsquared( var_4 ) > 100 )
    {
        var_5 = getnodesinradius( var_0, var_1 * 1.75, var_1 * 0.5, 500 );
        var_6 = [];
        var_7 = vectornormalize( var_4 );

        for ( var_8 = 0; var_8 < var_5.size; var_8++ )
        {
            var_9 = vectornormalize( var_5[var_8].origin - self._ID5540.origin );

            if ( vectordot( var_9, var_7 ) > 0.1 )
                var_6[var_6.size] = var_5[var_8];
        }
    }
    else
        var_6 = getnodesinradius( var_0, var_1, 0, 500 );

    if ( isdefined( var_2 ) && var_2 )
    {
        var_10 = vectornormalize( self._ID5540.origin - self.origin );
        var_11 = var_6;
        var_6 = [];

        foreach ( var_13 in var_11 )
        {
            var_9 = vectornormalize( var_13.origin - self._ID5540.origin );

            if ( vectordot( var_10, var_9 ) > 0.2 )
                var_6[var_6.size] = var_13;
        }
    }

    var_15 = [];
    var_16 = [];
    var_17 = [];

    for ( var_8 = 0; var_8 < var_6.size; var_8++ )
    {
        var_18 = distancesquared( var_6[var_8].origin, var_0 ) > 10000;
        var_19 = abs( var_6[var_8].origin[2] - self._ID5540.origin[2] ) < 50;

        if ( var_18 )
            var_15[var_15.size] = var_6[var_8];

        if ( var_19 )
            var_16[var_16.size] = var_6[var_8];

        if ( var_18 && var_19 )
            var_17[var_17.size] = var_6[var_8];

        if ( var_8 % 100 == 99 )
            wait 0.05;
    }

    if ( var_17.size > 0 )
        var_3 = self botnodepick( var_17, var_17.size * 0.15, "node_capture", var_0, undefined, self._ID9469 );

    if ( !isdefined( var_3 ) )
    {
        wait 0.05;

        if ( var_16.size > 0 )
            var_3 = self botnodepick( var_16, var_16.size * 0.15, "node_capture", var_0, undefined, self._ID9469 );

        if ( !isdefined( var_3 ) && var_15.size > 0 )
        {
            wait 0.05;
            var_3 = self botnodepick( var_15, var_15.size * 0.15, "node_capture", var_0, undefined, self._ID9469 );
        }
    }

    return var_3;
}

bot_find_node_to_capture_point( var_0, var_1, var_2 )
{
    var_3 = undefined;
    var_4 = getnodesinradius( var_0, var_1, 0, 500 );

    if ( var_4.size > 0 )
        var_3 = self botnodepick( var_4, var_4.size * 0.15, "node_capture", var_0, var_2, self._ID9469 );

    return var_3;
}

_ID5568( var_0, var_1 )
{
    var_2 = undefined;

    if ( var_0.size > 0 )
        var_2 = self botnodepick( var_0, var_0.size * 0.15, "node_capture", undefined, var_1, self._ID9469 );

    return var_2;
}

bot_find_node_that_protects_point( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = getnodesinradius( var_0, var_1, 0, 500 );

    if ( var_3.size > 0 )
        var_2 = self botnodepick( var_3, var_3.size * 0.15, "node_protect", var_0, self._ID9469 );

    return var_2;
}

_ID5727( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = undefined;
    var_6 = getnodesinradius( var_0, var_1, 0, 500 );

    if ( isdefined( var_6 ) && var_6.size >= 2 )
        var_5 = bot_find_random_midpoint( var_6, var_2 );

    if ( !isdefined( var_5 ) )
    {
        if ( !isdefined( var_3 ) )
            var_3 = 0;

        if ( !isdefined( var_4 ) )
            var_4 = 1;

        var_7 = randomfloatrange( self.bot_defending_radius * var_3, self.bot_defending_radius * var_4 );
        var_8 = anglestoforward( ( 0, randomint( 360 ), 0 ) );
        var_5 = var_0 + var_8 * var_7;
    }

    return var_5;
}

bot_pick_random_point_from_set( var_0, var_1, var_2 )
{
    var_3 = undefined;

    if ( var_1.size >= 2 )
        var_3 = bot_find_random_midpoint( var_1, var_2 );

    if ( !isdefined( var_3 ) )
    {
        var_4 = common_scripts\utility::_ID25350( var_1 );
        var_5 = var_4.origin - var_0;
        var_3 = var_0 + vectornormalize( var_5 ) * length( var_5 ) * randomfloat( 1.0 );
    }

    return var_3;
}

bot_find_random_midpoint( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = common_scripts\utility::array_randomize( var_0 );

    for ( var_4 = 0; var_4 < var_3.size; var_4++ )
    {
        for ( var_5 = var_4 + 1; var_5 < var_3.size; var_5++ )
        {
            var_6 = var_3[var_4];
            var_7 = var_3[var_5];

            if ( nodesvisible( var_6, var_7, 1 ) )
            {
                var_2 = ( ( var_6.origin[0] + var_7.origin[0] ) * 0.5, ( var_6.origin[1] + var_7.origin[1] ) * 0.5, ( var_6.origin[2] + var_7.origin[2] ) * 0.5 );

                if ( isdefined( var_1 ) && self [[ var_1 ]]( var_2 ) == 1 )
                    return var_2;
            }
        }
    }

    return var_2;
}

defend_valid_center()
{
    if ( isdefined( self._ID5546 ) )
        return self._ID5546.origin;
    else if ( isdefined( self.bot_defending_center ) )
        return self.bot_defending_center;

    return undefined;
}

bot_allowed_to_use_killstreaks()
{
    if ( maps\mp\_utility::bot_is_fireteam_mode() )
    {
        if ( isdefined( self._ID30022 ) && self._ID30022 == 1 )
            return 0;
    }

    if ( maps\mp\_utility::_ID18678() )
        return 0;

    if ( bot_is_remote_or_linked() )
        return 0;

    if ( self isusingturret() )
        return 0;

    if ( isdefined( level._ID22370 ) )
        return 0;

    if ( isdefined( self.underwater ) && self.underwater )
        return 0;

    if ( isdefined( self.controlsfrozen ) && self.controlsfrozen )
        return 0;

    if ( self isoffhandweaponreadytothrow() )
        return 0;

    if ( !bot_in_combat( 500 ) )
        return 1;

    if ( !isalive( self.enemy ) )
        return 1;

    return 0;
}

_ID5746()
{
    var_0 = undefined;
    var_1 = botmemoryflags( "investigated", "killer_died" );
    var_2 = botmemoryflags( "investigated" );
    var_3 = common_scripts\utility::_ID25350( botgetmemoryevents( 0, gettime() - 10000, 1, "death", var_1, self ) );

    if ( isdefined( var_3 ) )
    {
        var_0 = var_3;
        self.bot_memory_goal_time = 10000;
    }
    else
    {
        var_4 = undefined;

        if ( self botgetscriptgoaltype() != "none" )
            var_4 = self botgetscriptgoal();

        var_5 = botgetmemoryevents( 0, gettime() - 45000, 1, "kill", var_2, self );
        var_6 = botgetmemoryevents( 0, gettime() - 45000, 1, "death", var_1, self );
        var_3 = common_scripts\utility::_ID25350( common_scripts\utility::array_combine( var_5, var_6 ) );

        if ( isdefined( var_3 ) > 0 && ( !isdefined( var_4 ) || distancesquared( var_4, var_3 ) > 1000000 ) )
        {
            var_0 = var_3;
            self.bot_memory_goal_time = 45000;
        }
    }

    if ( isdefined( var_0 ) )
    {
        var_7 = getzonenearest( var_0 );
        var_8 = getzonenearest( self.origin );

        if ( isdefined( var_7 ) && isdefined( var_8 ) && var_8 != var_7 )
        {
            var_9 = botzonegetcount( var_7, self.team, "ally" ) + botzonegetcount( var_7, self.team, "path_ally" );

            if ( var_9 > 1 )
                var_0 = undefined;
        }
    }

    if ( isdefined( var_0 ) )
        self.bot_memory_goal = var_0;

    return var_0;
}

bot_draw_cylinder( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{

}

bot_draw_cylinder_think( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{

}

bot_draw_circle( var_0, var_1, var_2, var_3, var_4 )
{

}

bot_get_total_gun_ammo()
{
    var_0 = 0;
    var_1 = undefined;

    if ( isdefined( self._ID36267 ) && self._ID36267.size > 0 )
        var_1 = self._ID36267;
    else
        var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        var_0 += self getweaponammoclip( var_3 );
        var_0 += self getweaponammostock( var_3 );
    }

    return var_0;
}

bot_out_of_ammo()
{
    if ( maps\mp\_utility::_ID18666() )
    {
        if ( isdefined( self._ID18669 ) || isdefined( self.isjuggernautlevelcustom ) )
        {
            if ( self._ID23475 != "run_and_gun" )
            {
                self.prev_personality = self._ID23475;
                bot_set_personality( "run_and_gun" );
            }

            return 1;
        }
    }

    var_0 = undefined;

    if ( isdefined( self._ID36267 ) && self._ID36267.size > 0 )
        var_0 = self._ID36267;
    else
        var_0 = self getweaponslistprimaries();

    foreach ( var_2 in var_0 )
    {
        if ( self getweaponammoclip( var_2 ) > 0 )
            return 0;

        if ( self getweaponammostock( var_2 ) > 0 )
            return 0;
    }

    return 1;
}

bot_get_grenade_ammo()
{
    var_0 = 0;
    var_1 = self getweaponslistoffhands();

    foreach ( var_3 in var_1 )
        var_0 += self getweaponammostock( var_3 );

    return var_0;
}

bot_grenade_matches_purpose( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        return 0;

    switch ( var_0 )
    {
        case "trap_directional":
            switch ( var_1 )
            {
                case "claymore_mp":
                    return 1;
            }

            break;
        case "trap":
            switch ( var_1 )
            {
                case "trophy_mp":
                case "motion_sensor_mp":
                case "proximity_explosive_mp":
                    return 1;
            }

            break;
        case "c4":
            switch ( var_1 )
            {
                case "c4_mp":
                    return 1;
            }

            break;
        case "tacticalinsertion":
            switch ( var_1 )
            {
                case "flare_mp":
                    return 1;
            }

            break;
    }

    return 0;
}

bot_get_grenade_for_purpose( var_0 )
{
    if ( self botgetdifficultysetting( "allowGrenades" ) != 0 )
    {
        var_1 = self botfirstavailablegrenade( "lethal" );

        if ( bot_grenade_matches_purpose( var_0, var_1 ) )
            return "lethal";

        var_1 = self botfirstavailablegrenade( "tactical" );

        if ( bot_grenade_matches_purpose( var_0, var_1 ) )
            return "tactical";
    }
}

bot_watch_nodes( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    self notify( "bot_watch_nodes" );
    self endon( "bot_watch_nodes" );
    self endon( "bot_watch_nodes_stop" );
    self endon( "disconnect" );
    self endon( "death" );
    wait 1.0;
    var_8 = 1;

    while ( var_8 )
    {
        if ( self bothasscriptgoal() && self botpursuingscriptgoal() )
        {
            if ( distancesquared( self botgetscriptgoal(), self.origin ) < 16 )
                var_8 = 0;
        }

        if ( var_8 )
            wait 0.05;
    }

    var_9 = self.origin;

    if ( isdefined( var_0 ) )
    {
        self._ID35991 = [];

        foreach ( var_11 in var_0 )
        {
            var_12 = 0;

            if ( distance2dsquared( self.origin, var_11.origin ) <= 10 )
                var_12 = 1;

            var_13 = self geteye();
            var_14 = vectordot( ( 0, 0, 1 ), vectornormalize( var_11.origin - var_13 ) );

            if ( abs( var_14 ) > 0.92 )
                var_12 = 1;

            if ( !var_12 )
                self._ID35991[self._ID35991.size] = var_11;
        }
    }

    if ( !isdefined( self._ID35991 ) )
        return;

    if ( isdefined( var_4 ) )
        self endon( var_4 );

    if ( isdefined( var_5 ) )
        self endon( var_5 );

    if ( isdefined( var_6 ) )
        self endon( var_6 );

    if ( isdefined( var_7 ) )
        self endon( var_7 );

    thread _ID35992();
    self._ID35991 = common_scripts\utility::array_randomize( self._ID35991 );

    foreach ( var_11 in self._ID35991 )
        var_11._ID35990[self.entity_number] = 1.0;

    var_18 = gettime();
    var_19 = var_18;
    var_20 = [];
    var_21 = undefined;

    if ( isdefined( var_1 ) )
        var_21 = ( 0, var_1, 0 );

    var_22 = isdefined( var_21 ) && isdefined( var_2 );
    var_23 = undefined;

    for (;;)
    {
        var_24 = gettime();
        self notify( "still_watching_nodes" );
        var_25 = self botgetfovdot();

        if ( isdefined( var_3 ) && var_24 >= var_3 )
            return;

        if ( maps\mp\bots\_bots_strategy::bot_has_tactical_goal() )
        {
            self botlookatpoint( undefined );
            wait 0.2;
            continue;
        }

        if ( !self bothasscriptgoal() || !self botpursuingscriptgoal() )
        {
            wait 0.2;
            continue;
        }

        if ( isdefined( var_23 ) && var_23._ID35990[self.entity_number] == 0.0 )
            var_19 = var_24;

        if ( self._ID35991.size > 0 )
        {
            var_26 = 0;

            if ( isdefined( self.enemy ) )
            {
                var_27 = self lastknownpos( self.enemy );
                var_28 = self lastknowntime( self.enemy );

                if ( var_28 && var_24 - var_28 < 5000 )
                {
                    var_29 = vectornormalize( var_27 - self.origin );
                    var_30 = 0;

                    for ( var_31 = 0; var_31 < self._ID35991.size; var_31++ )
                    {
                        var_32 = vectornormalize( self._ID35991[var_31].origin - self.origin );
                        var_33 = vectordot( var_29, var_32 );

                        if ( var_33 > var_30 )
                        {
                            var_30 = var_33;
                            var_23 = self._ID35991[var_31];
                            var_26 = 1;
                        }
                    }
                }
            }

            if ( !var_26 && var_24 >= var_19 )
            {
                var_34 = [];

                for ( var_31 = 0; var_31 < self._ID35991.size; var_31++ )
                {
                    var_11 = self._ID35991[var_31];
                    var_35 = var_11 getnodenumber();

                    if ( var_22 && !common_scripts\utility::_ID36376( self.origin, var_21, var_11.origin, var_2 ) )
                        continue;

                    if ( !isdefined( var_20[var_35] ) )
                        var_20[var_35] = 0;

                    if ( common_scripts\utility::_ID36376( self.origin, self.angles, var_11.origin, var_25 ) )
                        var_20[var_35] = var_24;

                    for ( var_36 = 0; var_36 < var_34.size; var_36++ )
                    {
                        if ( var_20[var_34[var_36] getnodenumber()] > var_20[var_35] )
                            break;
                    }

                    var_34 = common_scripts\utility::array_insert( var_34, var_11, var_36 );
                }

                var_23 = undefined;

                for ( var_31 = 0; var_31 < var_34.size; var_31++ )
                {
                    if ( randomfloat( 1 ) > var_34[var_31]._ID35990[self.entity_number] )
                        continue;

                    var_23 = var_34[var_31];
                    var_19 = var_24 + randomintrange( 3000, 5000 );
                    break;
                }
            }

            if ( isdefined( var_23 ) )
            {
                var_37 = ( 0, 0, self getplayerviewheight() );
                var_38 = var_23.origin + var_37;
                var_39 = self.origin + ( 0, 0, 55 );
                var_40 = vectornormalize( var_38 - var_39 );
                var_41 = ( 0, 0, 1 );

                if ( vectordot( var_41, var_40 ) > 0.92 )
                    self botlookatpoint( var_38, 0.4, "script_search" );
            }
        }

        wait 0.2;
    }
}

watch_nodes_stop()
{
    self notify( "bot_watch_nodes_stop" );
    self._ID35991 = undefined;
}

_ID35992()
{
    self notify( "watch_nodes_aborted" );
    self endon( "watch_nodes_aborted" );

    for (;;)
    {
        var_0 = common_scripts\utility::_ID35637( 0.5, "still_watching_nodes" );

        if ( !isdefined( var_0 ) || var_0 != "still_watching_nodes" )
        {
            watch_nodes_stop();
            return;
        }
    }
}

_ID5661( var_0, var_1 )
{
    if ( isdefined( var_1 ) && var_1 != ( 0, 0, 0 ) )
    {
        if ( !common_scripts\utility::_ID36376( self.origin, self.angles, var_1, self botgetfovdot() ) )
        {
            var_2 = self botpredictseepoint( var_1 );

            if ( isdefined( var_2 ) )
                self botlookatpoint( var_2 + ( 0, 0, 40 ), 1.0, "script_seek" );
        }

        self botmemoryevent( "known_enemy", undefined, var_1 );
    }
}

bot_get_known_attacker( var_0, var_1 )
{
    if ( isdefined( var_1 ) && isdefined( var_1.classname ) )
    {
        if ( var_1.classname == "grenade" )
        {
            if ( !bot_ent_is_anonymous_mine( var_1 ) )
                return var_0;
        }
        else if ( var_1.classname == "rocket" )
        {
            if ( isdefined( var_1._ID35007 ) )
                return var_1._ID35007;

            if ( isdefined( var_1.type ) && ( var_1.type == "remote" || var_1.type == "odin" ) )
                return var_1;

            if ( isdefined( var_1.owner ) )
                return var_1.owner;
        }
        else if ( var_1.classname == "worldspawn" || var_1.classname == "trigger_hurt" )
            return undefined;

        return var_1;
    }

    return var_0;
}

bot_ent_is_anonymous_mine( var_0 )
{
    if ( !isdefined( var_0._ID36249 ) )
        return 0;

    if ( var_0._ID36249 == "c4_mp" )
        return 1;

    if ( var_0._ID36249 == "proximity_explosive_mp" )
        return 1;

    return 0;
}

_ID5824( var_0, var_1 )
{
    return var_0[0] == var_1[0] && var_0[1] == var_1[1] && var_0[2] == var_1[2];
}

bot_add_to_bot_level_targets( var_0 )
{
    var_0.high_priority_for = [];

    if ( var_0.bot_interaction_type == "use" )
        bot_add_to_bot_use_targets( var_0 );
    else if ( var_0.bot_interaction_type == "damage" )
        bot_add_to_bot_damage_targets( var_0 );
    else
    {

    }
}

bot_remove_from_bot_level_targets( var_0 )
{
    var_0._ID3208 = 1;
    level._ID19884 = common_scripts\utility::array_remove( level._ID19884, var_0 );
}

bot_add_to_bot_use_targets( var_0 )
{
    if ( !issubstr( var_0.code_classname, "trigger_use" ) )
        return;

    if ( !isdefined( var_0.target ) )
        return;

    if ( isdefined( var_0.bot_target ) )
        return;

    if ( !isdefined( var_0._ID34718 ) )
        return;

    var_1 = getnodearray( var_0.target, "targetname" );

    if ( var_1.size != 1 )
        return;

    var_0.bot_target = var_1[0];

    if ( !isdefined( level._ID19884 ) )
        level._ID19884 = [];

    level._ID19884 = common_scripts\utility::array_add( level._ID19884, var_0 );
}

bot_add_to_bot_damage_targets( var_0 )
{
    if ( !issubstr( var_0.code_classname, "trigger_damage" ) )
        return;

    var_1 = getnodearray( var_0.target, "targetname" );

    if ( var_1.size != 2 )
        return;

    var_0.bot_targets = var_1;

    if ( !isdefined( level._ID19884 ) )
        level._ID19884 = [];

    level._ID19884 = common_scripts\utility::array_add( level._ID19884, var_0 );
}

bot_get_string_index_for_integer( var_0, var_1 )
{
    var_2 = 0;

    foreach ( var_5, var_4 in var_0 )
    {
        if ( var_2 == var_1 )
            return var_5;

        var_2++;
    }

    return undefined;
}

bot_get_zones_within_dist( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < level._ID36588; var_2++ )
    {
        var_3 = getzonenodeforindex( var_2 );
        var_3._ID35342 = 0;
    }

    var_4 = getzonenodeforindex( var_0 );
    return bot_get_zones_within_dist_recurs( var_4, var_1 );
}

bot_get_zones_within_dist_recurs( var_0, var_1 )
{
    var_2 = [];
    var_2[0] = getnodezone( var_0 );
    var_0._ID35342 = 1;
    var_3 = getlinkednodes( var_0 );

    foreach ( var_5 in var_3 )
    {
        if ( !var_5._ID35342 )
        {
            var_6 = distance( var_0.origin, var_5.origin );

            if ( var_6 < var_1 )
            {
                var_7 = bot_get_zones_within_dist_recurs( var_5, var_1 - var_6 );
                var_2 = common_scripts\utility::array_combine( var_7, var_2 );
            }
        }
    }

    return var_2;
}

bot_crate_is_command_goal( var_0 )
{
    return isdefined( var_0 ) && isdefined( var_0.command_goal ) && var_0.command_goal;
}

bot_get_team_limit()
{
    return int( bot_get_client_limit() / 2 );
}

bot_get_client_limit()
{
    var_0 = getdvarint( "party_maxplayers", 0 );
    var_0 = max( var_0, getdvarint( "party_maxPrivatePartyPlayers", 0 ) );

    if ( getdvar( "squad_vs_squad" ) == "1" || getdvar( "squad_use_hosts_squad" ) == "1" || getdvar( "squad_match" ) == "1" )
        var_0 = 12;

    if ( var_0 > level._ID20723 )
        return level._ID20723;

    return var_0;
}

bot_queued_process_level_thread()
{
    self notify( "bot_queued_process_level_thread" );
    self endon( "bot_queued_process_level_thread" );
    wait 0.05;

    for (;;)
    {
        if ( isdefined( level._ID5741 ) && level._ID5741.size > 0 )
        {
            var_0 = level._ID5741[0];

            if ( isdefined( var_0 ) && isdefined( var_0.owner ) )
            {
                var_1 = undefined;

                if ( isdefined( var_0._ID23276 ) )
                    var_1 = var_0.owner [[ var_0.func ]]( var_0._ID23273, var_0.parm2, var_0._ID23275, var_0._ID23276 );
                else if ( isdefined( var_0._ID23275 ) )
                    var_1 = var_0.owner [[ var_0.func ]]( var_0._ID23273, var_0.parm2, var_0._ID23275 );
                else if ( isdefined( var_0.parm2 ) )
                    var_1 = var_0.owner [[ var_0.func ]]( var_0._ID23273, var_0.parm2 );
                else if ( isdefined( var_0._ID23273 ) )
                    var_1 = var_0.owner [[ var_0.func ]]( var_0._ID23273 );
                else
                    var_1 = var_0.owner [[ var_0.func ]]();

                var_0.owner notify( var_0._ID21872,  var_1  );
            }

            var_2 = [];

            for ( var_3 = 1; var_3 < level._ID5741.size; var_3++ )
                var_2[var_3 - 1] = level._ID5741[var_3];

            level._ID5741 = var_2;
        }

        wait 0.05;
    }
}

bot_queued_process( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( level._ID5741 ) )
        level._ID5741 = [];

    foreach ( var_8, var_7 in level._ID5741 )
    {
        if ( var_7.owner == self && var_7.name == var_0 )
        {
            self notify( var_7.name );
            level._ID5741[var_8] = undefined;
        }
    }

    var_7 = spawnstruct();
    var_7.owner = self;
    var_7.name = var_0;
    var_7._ID21872 = var_7.name + "_done";
    var_7.func = var_1;
    var_7._ID23273 = var_2;
    var_7.parm2 = var_3;
    var_7._ID23275 = var_4;
    var_7._ID23276 = var_5;
    level._ID5741[level._ID5741.size] = var_7;

    if ( !isdefined( level.bot_queued_process_level_thread_active ) )
    {
        level.bot_queued_process_level_thread_active = 1;
        level thread bot_queued_process_level_thread();
    }

    self waittill( var_7._ID21872,  var_9  );
    return var_9;
}

bot_is_remote_or_linked()
{
    return maps\mp\_utility::_ID18837() || self islinked();
}

_ID5606( var_0 )
{
    var_1 = undefined;

    if ( isdefined( self._ID36267 ) && self._ID36267.size > 0 )
        var_1 = self._ID36267;
    else
        var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        var_4 = weaponclipsize( var_3 );
        var_5 = self getweaponammostock( var_3 );

        if ( var_5 <= var_4 )
            return 1;

        if ( self getfractionmaxammo( var_3 ) <= var_0 )
            return 1;
    }

    return 0;
}

bot_point_is_on_pathgrid( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 256;

    if ( !isdefined( var_2 ) )
        var_2 = 50;

    var_3 = getnodesinradiussorted( var_0, var_1, 0, var_2, "Path" );

    foreach ( var_5 in var_3 )
    {
        var_6 = var_0 + ( 0, 0, 30 );
        var_7 = var_5.origin + ( 0, 0, 30 );
        var_8 = physicstrace( var_6, var_7 );

        if ( _ID5824( var_8, var_7 ) )
            return 1;

        wait 0.05;
    }

    return 0;
}

_ID5691( var_0 )
{
    level endon( "game_ended" );
    self notify( "bot_monitor_enemy_camp_spots" );
    self endon( "bot_monitor_enemy_camp_spots" );
    level._ID11856 = [];
    level._ID11855 = [];
    level._ID11854 = [];

    for (;;)
    {
        wait 1.0;
        var_1 = [];

        if ( !isdefined( var_0 ) )
            continue;

        foreach ( var_3 in level._ID23303 )
        {
            if ( !isdefined( var_3.team ) )
                continue;

            if ( var_3 [[ var_0 ]]() && !isdefined( var_1[var_3.team] ) )
            {
                level._ID11854[var_3.team] = undefined;
                level._ID11856[var_3.team] = var_3 botpredictenemycampspots( 1 );

                if ( isdefined( level._ID11856[var_3.team] ) )
                {
                    if ( !isdefined( level._ID11855[var_3.team] ) || !common_scripts\utility::array_contains( level._ID11856[var_3.team], level._ID11855[var_3.team] ) )
                        level._ID11855[var_3.team] = common_scripts\utility::_ID25350( level._ID11856[var_3.team] );

                    if ( isdefined( level._ID11855[var_3.team] ) )
                    {
                        var_4 = [];

                        foreach ( var_6 in level._ID23303 )
                        {
                            if ( !isdefined( var_6.team ) )
                                continue;

                            if ( var_6 [[ var_0 ]]() && var_6.team == var_3.team )
                                var_4[var_4.size] = var_6;
                        }

                        var_4 = sortbydistance( var_4, level._ID11855[var_3.team] );

                        if ( var_4.size > 0 )
                            level._ID11854[var_3.team] = var_4[0];
                    }
                }

                var_1[var_3.team] = 1;
            }
        }
    }
}

bot_valid_camp_assassin()
{
    if ( !isdefined( self ) )
        return 0;

    if ( !isai( self ) )
        return 0;

    if ( !isdefined( self.team ) )
        return 0;

    if ( self.team == "spectator" )
        return 0;

    if ( !isalive( self ) )
        return 0;

    if ( !maps\mp\_utility::_ID18540( self ) )
        return 0;

    if ( self._ID23475 == "camper" )
        return 0;

    return 1;
}

_ID5815()
{
    if ( !isdefined( level._ID11854 ) )
        return;

    if ( !isdefined( level._ID11854[self.team] ) )
        return;

    if ( level._ID11854[self.team] == self )
    {
        maps\mp\bots\_bots_strategy::bot_defend_stop();
        self botsetscriptgoal( level._ID11855[self.team], 128, "objective", undefined, 256 );
        bot_waittill_goal_or_fail();
    }
}

bot_force_stance_for_time( var_0, var_1 )
{
    self notify( "bot_force_stance_for_time" );
    self endon( "bot_force_stance_for_time" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self botsetstance( var_0 );
    wait(var_1);
    self botsetstance( "none" );
}
