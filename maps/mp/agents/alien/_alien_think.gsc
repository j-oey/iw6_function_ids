// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID22818( var_0, var_1 )
{
    _ID22831( var_0, var_1 );
    self.currentanimstate = var_1;

    switch ( var_1 )
    {
        case "idle":
            maps\mp\agents\alien\_alien_idle::_ID20445();
            break;
        case "move":
            maps\mp\agents\alien\_alien_move::_ID20445();
            break;
        case "traverse":
            maps\mp\agents\alien\_alien_traverse::_ID20445();
            break;
        case "melee":
            maps\mp\agents\alien\_alien_melee::_ID20445();
            break;
    }
}

_ID22831( var_0, var_1 )
{
    self notify( "killanimscript" );

    switch ( var_0 )
    {
        case "idle":
            maps\mp\agents\alien\_alien_idle::end_script();
            break;
        case "move":
            maps\mp\agents\alien\_alien_move::end_script();
            break;
        case "traverse":
            maps\mp\agents\alien\_alien_traverse::end_script();
            break;
        case "melee":
            maps\mp\agents\alien\_alien_melee::end_script();
            break;
    }
}

_ID21388()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "flashbang",  var_0, var_1, var_2, var_3, var_4, var_5  );

        switch ( self.currentanimstate )
        {
            case "idle":
                continue;
            case "move":
                maps\mp\agents\alien\_alien_move::_ID22843();
                continue;
        }
    }
}

ondamagefinish( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    self finishagentdamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0 );

    if ( self.health <= 0 )
        return 1;

    var_10 = maps\mp\alien\_unk1464::is_trap( var_0 );
    registerdamage( var_2 );

    if ( isdefined( var_1 ) )
    {
        if ( isplayer( var_1 ) || isdefined( var_1.owner ) && isplayer( var_1.owner ) )
        {
            if ( !var_10 )
                var_1 maps\mp\alien\_damage::check_for_special_damage( self, var_5, var_4 );

            if ( var_2 > 0 )
                level.alienbbdata["damage_done"] = level.alienbbdata["damage_done"] + var_2;
        }
    }

    var_11 = _ID29813( var_5, var_4, var_1 );

    if ( !var_11 )
    {
        var_12 = belowcumulativepainthreshold( var_1, var_5 );

        if ( var_4 != "MOD_MELEE" && var_12 )
            return;

        if ( var_4 == "MOD_MELEE" && !var_12 && !_ID29825() )
            return;
    }

    if ( !isdefined( var_7 ) )
        var_7 = anglestoforward( self.angles );

    _ID22311( var_7, var_8, var_2, var_11 );
    cleardamagehistory();

    if ( var_11 && !var_10 )
    {
        thread maps\mp\alien\_alien_fx::_ID13963();
        var_3 |= level._ID17348;
    }

    switch ( self.currentanimstate )
    {
        case "idle":
            maps\mp\agents\alien\_alien_idle::_ID22790( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
            break;
        case "move":
            maps\mp\agents\alien\_alien_move::_ID22790( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
            break;
        case "melee":
            maps\mp\agents\alien\_alien_melee::_ID22790( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
            break;
    }

    return 1;
}

_ID29813( var_0, var_1, var_2 )
{
    if ( maps\mp\alien\_unk1464::_ID14264() == "elite" )
        return 0;

    if ( maps\mp\alien\_unk1464::_ID18506( self.is_burning ) )
        return 0;

    if ( isdefined( var_2 ) && isplayer( var_2 ) && var_1 != "MOD_MELEE" )
    {
        var_3 = isdefined( var_0 ) && var_0 == var_2 getcurrentprimaryweapon();
        return var_3 && var_2 maps\mp\alien\_unk1464::has_stun_ammo();
    }

    return 0;
}

_ID29825()
{
    if ( maps\mp\alien\_unk1464::_ID14264() == "elite" )
        return 0;

    return 1;
}

_ID22311( var_0, var_1, var_2, var_3 )
{
    self notify( "jump_pain",  var_0, var_1, var_2, var_3  );
}

cleardamagehistory()
{
    self.recentdamages = [];
    self._ID8974 = 0;
}

registerdamage( var_0 )
{
    var_1 = [];
    var_1["amount"] = var_0;
    var_1["time"] = gettime();
    self.recentdamages[self._ID8974] = var_1;
    self._ID8974++;

    if ( self._ID8974 == level.damagelistsize )
    {
        self._ID8974 = 0;
        return;
    }
}

belowcumulativepainthreshold( var_0, var_1 )
{
    var_2 = maps\mp\alien\_unk1464::_ID14264();
    var_3 = _ID14954();
    var_4 = level._ID2829[var_2].attributes["min_cumulative_pain_threshold"];
    return var_3 < var_4;
}

_ID14954()
{
    var_0 = maps\mp\alien\_unk1464::_ID14264();
    var_1 = level._ID2829[var_0].attributes["min_cumulative_pain_buffer_time"] * 1000.0;
    var_2 = 0;
    var_3 = gettime();

    for ( var_4 = 0; var_4 < self.recentdamages.size; var_4++ )
    {
        if ( var_3 - self.recentdamages[var_4]["time"] < var_1 )
            var_2 += self.recentdamages[var_4]["amount"];
    }

    return var_2;
}

gettargetpredictedposition( var_0, var_1 )
{
    var_2 = var_0 getentityvelocity();
    var_3 = var_0.origin + var_1 * var_2;
    return var_3;
}

_ID14895( var_0, var_1, var_2 )
{
    var_3 = 15;
    var_4 = gettargetpredictedposition( var_0, var_2 );
    var_5 = vectornormalize( self.origin - var_4 );
    var_6 = var_4 + var_5 * var_1;
    var_6 = getgroundposition( var_6, var_3, 64, 64 );
    return var_6;
}

_ID4136()
{
    if ( !isdefined( self.enemy ) )
        return 0;

    self scragentbeginmelee( self.enemy );
    return 1;
}

_ID20445()
{
    self endon( "death" );
    common_scripts\utility::_ID35582();
    var_0 = 0;
    var_1 = 0;

    if ( _ID29834() )
        thread downed_enemy_monitor();

    for (;;)
    {
        if ( var_0 )
        {
            alien_test_loop();
            continue;
        }

        if ( var_1 )
        {
            alien_test_jump();
            continue;
        }

        alien_main_loop();
    }
}

_ID29834()
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "elite":
        case "minion":
        case "spitter":
        case "gargoyle":
        case "seeder":
            return 0;
        default:
            return 1;
    }
}

downed_enemy_monitor()
{
    self endon( "death" );

    for (;;)
    {
        if ( !isplayer( self.enemy ) )
        {
            wait 0.05;
            continue;
        }

        thread monitor_enemy_for_downed( self.enemy );
        common_scripts\utility::_ID35626( "downed_enemy", "enemy" );
    }
}

monitor_enemy_for_downed( var_0 )
{
    self endon( "enemy" );
    self endon( "death" );
    var_0 common_scripts\utility::_ID35626( "death", "last_stand" );
    var_1 = 65536;

    if ( distancesquared( var_0.origin, self.origin ) < var_1 )
    {
        self._ID11893 = 1;
        self._ID10804 = var_0.origin;
    }

    self notify( "downed_enemy" );
}

alien_test_loop()
{
    var_0 = [ ( -296, 448, -352 ), ( 808, 300, -368 ), ( 1320.6, 482.8, -320 ) ];
    wait 10;

    for (;;)
    {
        foreach ( var_2 in var_0 )
        {
            if ( distancesquared( self.origin, var_2 ) < 100 )
                continue;

            self scragentsetgoalpos( var_2 );
            self waittill( "goal_reached" );
            wait 3;
        }
    }
}

alien_test_jump()
{
    var_0 = [ ( -203.3, -898, 151.033 ), ( -1282.2, -669.1, -26.529 ) ];
    wait 10;

    for (;;)
    {
        foreach ( var_2 in var_0 )
        {
            if ( distancesquared( self.origin, var_2 ) < 100 )
                continue;

            self scragentsetgoalpos( var_2 );
            self waittill( "goal_reached" );
            wait 3;
        }
    }
}

_ID16029( var_0, var_1 )
{
    if ( var_1 )
        self.attractor_flare = var_0;
    else
    {
        if ( !isdefined( self.attractor_flare ) )
            return;

        if ( isdefined( var_0 ) && var_0 != self.attractor_flare )
            return;

        self.attractor_flare = undefined;
    }

    self notify( "alien_main_loop_restart" );
}

react_to_attractor_flare()
{
    var_0 = 3.0;
    var_1 = 6.0;
    var_2 = get_flare_node();

    if ( isdefined( var_2 ) )
    {
        self scragentsetgoalnode( var_2 );
        self scragentsetgoalradius( 64.0 );
        self waittill( "goal_reached" );

        while ( isdefined( self.attractor_flare ) )
            wait 0.2;

        return;
    }
}

get_flare_node()
{
    var_0 = getnodesinradius( self.attractor_flare.origin, 300, 50, 128, "path" );

    if ( var_0.size == 0 )
        return undefined;

    var_1 = [];
    var_2 = vectornormalize( self.origin - self.attractor_flare.origin );

    foreach ( var_4 in var_0 )
    {
        var_5 = vectornormalize( var_4.origin - self.attractor_flare.origin );

        if ( vectordot( var_5, var_2 ) < 0 )
            continue;

        var_1[var_1.size] = var_4;
    }

    if ( var_1.size == 0 )
        return var_0[randomint( var_0.size )];

    return var_1[randomint( var_1.size )];
}

alien_main_loop()
{
    self endon( "alien_main_loop_restart" );

    for (;;)
    {
        self.looktarget = undefined;
        var_0 = self.enemy;

        if ( isdefined( self.alien_scripted ) && self.alien_scripted == 1 )
        {

        }
        else if ( isdefined( self.attractor_flare ) )
            react_to_attractor_flare();
        else if ( isdefined( self._ID11893 ) && self._ID11893 )
        {
            _ID24796();
            self._ID11893 = 0;
            self._ID10804 = undefined;
        }
        else if ( isalive( var_0 ) )
        {
            if ( self._ID4637 )
                [[ level.alien_funcs[maps\mp\alien\_unk1464::_ID14264()]["badpath"] ]]( var_0 );
            else
                [[ level.alien_funcs[maps\mp\alien\_unk1464::_ID14264()]["combat"] ]]( var_0 );
        }
        else if ( isdefined( self.pet ) && self.pet )
            alien_pet_follow();
        else
            alien_noncombat();

        wait 0.05;
    }
}

_ID24796()
{
    self endon( "damage" );
    self endon( "enemy_downed_proximity_breached" );
    var_0 = 4.0;
    var_1 = 6.0;
    var_2 = get_downed_posture_node();

    if ( isdefined( var_2 ) )
    {
        self scragentsetgoalnode( var_2 );
        self scragentsetgoalradius( 64.0 );
        self waittill( "goal_reached" );
    }

    thread _ID21318();
    wait(randomfloatrange( var_0, var_1 ));
}

_ID21318()
{
    self endon( "death" );
    self endon( "damage" );
    self endon( "alien_main_loop_restart" );
    var_0 = 16384;

    for (;;)
    {
        foreach ( var_2 in level.players )
        {
            if ( distancesquared( var_2.origin, self.origin ) < var_0 )
            {
                self notify( "enemy_downed_proximity_breached" );
                return;
            }
        }

        wait 0.1;
    }
}

get_downed_posture_node()
{
    var_0 = getnodesinradius( self.origin, 300, 50, 128, "path" );

    if ( var_0.size == 0 )
        return;

    var_1 = [];
    var_1["direction"] = "override";
    var_1["direction_override"] = vectornormalize( self.origin - self._ID10804 );
    var_1["direction_weight"] = 10.0;
    var_1["min_height"] = 64.0;
    var_1["max_height"] = 400.0;
    var_1["height_weight"] = 0.0;
    var_1["enemy_los"] = 0;
    var_1["enemy_los_weight"] = 0.0;
    var_1["min_dist_from_enemy"] = 400.0;
    var_1["max_dist_from_enemy"] = 800.0;
    var_1["desired_dist_from_enemy"] = 600.0;
    var_1["dist_from_enemy_weight"] = 0.0;
    var_1["min_dist_from_all_enemies"] = 200.0;
    var_1["min_dist_from_all_enemies_weight"] = 6.0;
    var_1["not_recently_used_weight"] = 2.0;
    var_1["random_weight"] = 1.0;
    var_2 = get_retreat_node_rated( self.enemy, var_1, var_0 );
    return var_2;
}

_ID9353( var_0 )
{
    var_0 endon( "death" );
    self endon( "enemy" );
    self endon( "bad_path" );
    clear_attacking( var_0 );

    while ( isalive( var_0 ) )
    {
        self.looktarget = var_0;

        if ( _ID29818( var_0 ) )
        {
            _ID28233( var_0 );
            alien_attack_enemy( var_0 );
            clear_attacking( var_0 );

            if ( _ID29819( var_0 ) )
                alien_retreat( var_0 );

            continue;
        }

        _ID2835( var_0 );
    }
}

alien_attack_enemy( var_0 )
{
    if ( _ID34716( var_0 ) )
    {
        alien_synch_attack_enemy( var_0 );
        return;
    }

    alien_attack_sequence( var_0 );
    return;
}

_ID34716( var_0 )
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "elite":
        case "minion":
        case "spitter":
        case "locust":
        case "gargoyle":
        case "mammoth":
        case "seeder":
            return 0;
        default:
            break;
    }

    return isdefined( var_0._ID32300 );
}

alien_attack_sequence( var_0 )
{
    var_1 = _ID14299();

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        var_3 = get_attack_num();

        for ( var_4 = 0; var_4 < var_3; var_4++ )
        {
            if ( has_attack_abort_been_requested( self ) )
                return;

            var_5 = [[ level.alien_funcs[maps\mp\alien\_unk1464::_ID14264()]["approach"] ]]( var_0, var_4 );
            alien_attack( var_0, var_5 );

            if ( distancesquared( self.origin, self.enemy.origin ) < 4096 )
                break;
        }
    }
}

alien_synch_attack_enemy( var_0 )
{
    if ( distance2dsquared( self.origin, var_0.origin ) > 100 )
    {
        self scragentsetgoalradius( 100 );
        self scragentsetgoalentity( var_0 );
        self waittill( "goal_reached" );
    }

    var_1 = isalive( var_0._ID32300.primary_attacker ) && var_0._ID32300.primary_attacker != self;
    var_2 = 1;

    if ( isdefined( var_0._ID32300.can_synch_attack_func ) )
        var_2 = var_0 [[ var_0._ID32300.can_synch_attack_func ]]();

    if ( !var_1 && var_2 )
    {
        var_0._ID32300.primary_attacker = self;
        select_synch_index( var_0 );

        if ( should_move_to_synch_attack_pos( var_0 ) )
        {
            self scragentsetgoalradius( 30 );
            self scragentsetgoalpos( self._ID32299 );
            self waittill( "goal_reached" );
        }

        _ID32302( var_0 );
        return;
    }

    _ID32264( var_0 );
    return;
}

select_synch_index( var_0 )
{
    var_1 = var_0 maps\mp\alien\_unk1464::_ID14774( self );
    var_2 = vectornormalize( self.origin - var_0.origin );
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = -1.1;

    foreach ( var_17, var_8 in var_1 )
    {
        var_9 = var_8["attackerAnimState"];
        var_10 = self getanimentry( var_9, 0 );
        var_11 = getstartorigin( var_0.origin, var_0.angles, var_10 );
        var_12 = length( var_11 - var_0.origin );
        var_13 = var_8["offset_direction"] * var_12;
        var_14 = var_0 localtoworldcoords( var_13 );
        var_15 = vectornormalize( var_14 - var_0.origin );
        var_16 = vectordot( var_15, var_2 );

        if ( var_16 > var_6 )
        {
            var_3 = var_17;
            var_4 = var_9;
            var_5 = var_14;
            var_6 = var_16;
        }
    }

    self._ID32298 = var_3;
    self._ID32296 = var_4;
    self._ID32299 = var_5;
}

should_move_to_synch_attack_pos( var_0 )
{
    var_1 = 0.707;
    var_2 = vectornormalize( self._ID32299 - var_0.origin );
    var_3 = vectornormalize( self.origin - var_0.origin );
    var_4 = vectordot( var_2, var_3 ) > var_1;
    var_5 = distancesquared( var_0.origin, self.origin ) > distancesquared( var_0.origin, self._ID32299 );
    return var_5 || !var_4;
}

alien_attack( var_0, var_1 )
{
    self notify( "start_attack" );

    switch ( var_1 )
    {
        case "swipe":
            _ID32263( var_0 );
            break;
        case "leap":
            _ID19775( var_0 );
            break;
        case "wall":
            _ID35831( var_0 );
            break;
        case "badpath_jump":
            badpath_jump( var_0 );
            break;
        case "spit":
            maps\mp\agents\alien\_alien_spitter::_ID31022( var_0 );
            break;
        case "charge":
            maps\mp\agents\alien\_alien_elite::charge_attack( var_0 );
            break;
        case "slam":
            maps\mp\agents\alien\_alien_elite::_ID15818( var_0 );
            break;
        case "angered":
            maps\mp\agents\alien\_alien_elite::angered( var_0 );
            break;
        case "synch":
            _ID32302( var_0 );
            break;
        case "swipe_static":
            _ID32264( var_0 );
            break;
        case "explode":
            maps\mp\agents\alien\_alien_minion::_ID12456( var_0 );
        case "none":
            break;
        default:
            if ( isdefined( level.alien_attack_override_func ) )
            {
                if ( [[ level.alien_attack_override_func ]]( var_0, var_1 ) )
                    break;
            }

            wait 1;
            break;
    }
}

_ID16033( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    self endon( "bad_path" );
    self._ID4637 = 0;

    if ( !can_attempt_badpath_move() )
        return;

    if ( self.badpathcount > 3 )
    {
        if ( attempt_bad_path_move_nearby_node( var_0 ) )
            self.badpathcount = 0;

        return;
    }

    if ( !_ID29802() )
        return;

    if ( self.badpathcount == 1 )
        var_1 = attempt_badpath_move_to_node( var_0, 0, 100, 50 );
    else
        var_1 = 0;

    if ( !var_1 )
    {
        var_1 = attempt_badpath_move_to_node( var_0, 100, 256, 128 );

        if ( !var_1 )
            return;
    }

    if ( attempt_bad_path_melee( var_0 ) )
    {
        self.badpathcount = 0;
        return;
    }
}

can_attempt_badpath_move()
{
    switch ( self.currentanimstate )
    {
        case "traverse":
            return 0;
        default:
            return 1;
    }
}

_ID29802()
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "spitter":
        case "seeder":
            return 0;
        default:
            return 1;
    }
}

attempt_bad_path_move_nearby_node( var_0 )
{
    var_1 = 128;
    var_2 = 512;
    var_3 = getnodesinradius( self.origin, var_2, var_1, 256, "node_pathnode" );

    if ( var_3.size == 0 )
        return 0;

    self scragentsetgoalpos( self.origin );
    self scragentsetgoalradius( 2048 );
    var_4 = var_3[randomint( var_3.size )];

    if ( attempt_badpath_jump( var_0, var_4 ) )
        return 1;
    else
    {
        self scragentsetgoalnode( var_4 );
        self scragentsetgoalradius( 64 );
        self waittill( "goal_reached" );
        return 1;
    }

    return 0;
}

attempt_bad_path_melee( var_0 )
{
    var_1 = abs( self.origin[2] - var_0.origin[2] );
    var_2 = distance2d( self.origin, var_0.origin );

    if ( var_2 > 256 )
        return 0;

    var_3 = self agentcanseesentient( var_0 );

    if ( var_3 && var_1 <= 50 && var_2 <= 150 )
    {
        self.bad_path_handled = 1;

        if ( maps\mp\alien\_unk1464::_ID29814() )
        {
            alien_attack( var_0, "explode" );
            return 1;
        }
        else if ( maps\mp\alien\_unk1464::is_normal_upright( anglestoup( self.angles ) ) )
        {
            alien_attack( var_0, "swipe" );
            return 1;
        }
    }

    self._ID19777 = maps\mp\agents\alien\_alien_melee::_ID14544( 1.0, 48, var_0 );
    var_4 = maps\mp\agents\_scriptedagents::droppostoground( self._ID19777, 256 );

    if ( !isdefined( var_4 ) )
        return 0;

    if ( !trajectorycanattemptaccuratejump( self.origin, anglestoup( self.angles ), self._ID19777, anglestoup( var_0.angles ), level._ID2791, 1.01 * level.alien_jump_melee_speed ) )
        return 0;

    var_5 = getnodesinradiussorted( var_4, 256, 0, 256 );

    if ( !var_5.size )
        return 0;

    var_6 = getpathdist( var_4, var_5[0].origin, 512 );

    if ( var_6 < 0 )
        return 0;

    _ID19775( var_0 );
    return 1;
}

attempt_badpath_move_to_node( var_0, var_1, var_2, var_3 )
{
    var_4 = getnodesinradius( var_0.origin, var_2, var_1, var_3 );

    if ( var_4.size > 0 )
    {
        var_5 = var_4[randomint( var_4.size )];
        self scragentsetgoalnode( var_5 );
        self scragentsetgoalradius( 64 );
        self waittill( "goal_reached" );
        return 1;
    }

    wait 0.1;
    return 0;
}

attempt_badpath_jump( var_0, var_1 )
{
    var_2 = trajectorycanattemptaccuratejump( self.origin, anglestoup( self.angles ), var_1.origin, anglestoup( var_1.angles ), level._ID2791, 1.01 * level.alien_jump_melee_speed );

    if ( var_2 || self.oriented )
    {
        self._ID19777 = var_1.origin;
        self._ID19776 = var_1.angles;
        alien_attack( var_0, "badpath_jump" );
        self scragentsetgoalpos( self.origin );
        self scragentsetgoalradius( 2048 );
        self waittill( "goal_reached" );
    }

    wait 0.5;
    return var_2;
}

_ID26178( var_0 )
{
    self endon( "alien_main_loop_restart" );
    var_0 endon( "death" );
    self endon( "death" );
    self endon( "bad_path" );
    var_1 = 65536.0;

    for (;;)
    {
        if ( distancesquared( self.origin, var_0.origin ) < var_1 )
            self notify( "alien_main_loop_restart" );

        wait 0.05;
    }
}

_ID28233( var_0 )
{
    var_0.current_attackers[var_0.current_attackers.size] = self;
    self.attacking_player = 1;
    self.bypass_max_attacker_counter = 0;
}

clear_attacking( var_0 )
{
    if ( !isdefined( var_0.current_attackers ) )
        var_0.current_attackers = [];

    var_0.current_attackers = common_scripts\utility::array_remove( var_0.current_attackers, self );
    self.attacking_player = 0;
    self.abort_attack_requested = 0;
}

_ID7350()
{
    var_0 = [];

    foreach ( var_2 in self.current_attackers )
    {
        if ( isalive( var_2 ) && isalive( var_2.enemy ) && var_2.enemy == self )
            var_0[var_0.size] = var_2;
    }

    self.current_attackers = var_0;
}

_ID29818( var_0 )
{
    if ( !maps\mp\alien\_unk1464::is_idle_state_locked() && self.statelocked )
        return 0;

    var_0 _ID7350();
    return 1;
}

_ID29819( var_0 )
{
    if ( isdefined( level.dlc_alien_can_retreat_override_func ) )
    {
        if ( ![[ level.dlc_alien_can_retreat_override_func ]]( var_0 ) )
            return 0;
    }

    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "elite":
            return 0;
        default:
            return 1;
    }
}

replace_attacker_request( var_0 )
{
    var_0.abort_attack_requested = 1;
}

has_attack_abort_been_requested( var_0 )
{
    return isdefined( var_0.abort_attack_requested ) && var_0.abort_attack_requested;
}

_ID12892( var_0, var_1 )
{
    var_2 = level._ID2829[self.alien_type].attributes["attacker_priority"];
    var_3 = level._ID2829[self.alien_type].attributes["attacker_difficulty"] - ( level.maxalienattackerdifficultyvalue - var_1 );
    var_4 = [];

    foreach ( var_6 in var_0.current_attackers )
    {
        if ( has_attack_abort_been_requested( var_6 ) )
            continue;

        if ( var_2 < level._ID2829[var_6.alien_type].attributes["attacker_priority"] )
        {
            var_3 -= level._ID2829[var_6.alien_type].attributes["attacker_difficulty"];
            var_4[var_4.size] = var_6;

            if ( var_3 <= 0 )
                break;
        }
    }

    return var_4;
}

_ID14385( var_0 )
{
    var_1 = 0.0;

    if ( !isdefined( var_0.current_attackers ) )
        return var_1;

    foreach ( var_3 in var_0.current_attackers )
    {
        if ( !isalive( var_3 ) )
            continue;

        if ( has_attack_abort_been_requested( var_3 ) )
            continue;

        var_1 += level._ID2829[var_3.alien_type].attributes["attacker_difficulty"];
    }

    return var_1;
}

alien_noncombat()
{
    self scragentsetgoalpos( self.origin );

    for (;;)
    {
        if ( isalive( self.enemy ) )
            break;

        wait 1;
    }
}

alien_pet_follow()
{
    var_0 = 768;

    if ( isdefined( self._ID23491 ) )
        var_0 = self._ID23491;

    var_1 = var_0 * var_0;
    self scragentsetgoalradius( var_0 );

    while ( !isalive( self.enemy ) )
    {
        if ( !isdefined( self.owner ) || !isalive( self.owner ) )
        {
            var_2 = undefined;

            foreach ( var_4 in level.players )
            {
                if ( isalive( var_4 ) )
                {
                    var_2 = var_4;
                    break;
                }
            }

            if ( isdefined( var_2 ) )
                self.owner = var_2;
            else
                self scragentsetgoalpos( self.origin );
        }
        else
        {
            var_6 = distancesquared( self.owner.origin, self.origin );

            if ( var_6 > var_1 )
            {
                var_7 = get_pet_follow_node( self.owner );

                if ( !isdefined( var_7 ) )
                {
                    wait 1.0;
                    continue;
                }

                self scragentsetgoalnode( var_7 );
                self scragentsetgoalradius( 64 );
                self waittill( "goal_reached" );
                wait(randomfloatrange( 0.5, 1.5 ));
            }
        }

        wait 0.05;
    }
}

_ID2835( var_0 )
{
    self endon( "go to combat" );
    thread _ID21338( var_0 );
    thread _ID35952( var_0 );
    thread _ID25373( 0, 70, 30, 1.5, 3.0 );

    for (;;)
    {
        var_1 = common_scripts\utility::_ID7657();
        var_2 = getnodesinradius( self.origin, 512, 256, 256 );

        if ( var_2.size == 0 )
        {
            wait 1;
            self notify( "go to combat" );
            return;
        }

        var_3 = self.origin - var_0.origin;
        var_4 = vectortoangles( var_3 );
        var_5 = anglestoright( var_4 );

        if ( var_1 )
            var_5 *= -1;

        var_6 = [];
        var_6["direction"] = "override";
        var_6["direction_weight"] = 2.0;
        var_6["min_height"] = -32.0;
        var_6["max_height"] = 128.0;
        var_6["height_weight"] = 1.0;
        var_6["enemy_los"] = 1;
        var_6["enemy_los_weight"] = 2.0;
        var_6["min_dist_from_enemy"] = 600.0;
        var_6["max_dist_from_enemy"] = 1000.0;
        var_6["desired_dist_from_enemy"] = 800.0;
        var_6["dist_from_enemy_weight"] = 3.0;
        var_6["min_dist_from_all_enemies"] = 400.0;
        var_6["min_dist_from_all_enemies_weight"] = 1.0;
        var_6["not_recently_used_weight"] = 4.0;
        var_6["random_weight"] = 1.0;
        var_6["direction_override"] = var_5;
        var_7 = get_retreat_node_rated( var_0, var_6, var_2 );
        self scragentsetgoalnode( var_7 );
        self scragentsetgoalradius( 64 );
        self waittill( "goal_reached" );
        wait(randomfloatrange( 1.5, 3.5 ));

        if ( _ID29818( var_0 ) )
        {
            self notify( "go to combat" );
            break;
        }
    }
}

alien_retreat( var_0 )
{
    self notify( "start retreat" );
    _ID28199( "run" );
    var_1 = "elevated_delay";
    var_2 = "alien_forward";

    if ( !isdefined( var_1 ) || var_1 == "" )
        var_1 = "randomize";

    if ( !isdefined( var_2 ) || var_2 == "" )
        var_2 = "alien_forward";

    if ( var_1 == "randomize" )
    {
        var_3 = [ "elevated_delay", "cover", "cover", "cover" ];
        var_4 = randomint( 4 );
        var_1 = var_3[var_4];
    }

    switch ( var_1 )
    {
        case "elevated_delay":
            elevated_delay_retreat( var_0, var_2 );
            break;
        case "cover":
            _ID8104( var_0, var_2 );
            break;
        default:
            wait 1;
            break;
    }
}

_ID21338( var_0 )
{
    self endon( "go to combat" );
    self endon( "damage" );
    self endon( "death" );
    self endon( "alien_main_loop_restart" );
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    wait_for_proximity_check_activation( var_0 );

    for (;;)
    {
        if ( distancesquared( self.origin, var_0.origin ) < 65536 )
        {
            self.attack_sequence_num = 1;
            self._ID4071 = 1;
            self.bypass_max_attacker_counter = 1;
            self notify( "go to combat" );
            break;
        }

        common_scripts\utility::_ID35582();
    }
}

_ID35952( var_0 )
{
    self endon( "go to combat" );
    self endon( "death" );
    self endon( "alien_main_loop_restart" );
    var_0 endon( "death" );
    self waittill( "damage" );
    self.bypass_max_attacker_counter = 1;
    self notify( "go to combat" );
}

wait_for_proximity_check_activation( var_0 )
{
    var_1 = 2;
    var_2 = gettime();

    for (;;)
    {
        if ( distancesquared( self.origin, var_0.origin ) > 65536 )
            break;
        else if ( gettime() - var_2 > var_1 * 1000 )
            break;

        common_scripts\utility::_ID35582();
    }
}

elevated_delay_retreat( var_0, var_1 )
{
    var_2 = get_elevated_jump_node( var_0, var_1 );

    if ( !isdefined( var_2 ) )
    {
        wait 0.05;
        return;
    }

    self scragentsetgoalnode( var_2 );
    self scragentsetgoalradius( 32 );
    self waittill( "goal_reached" );
    wait 1.5;
}

get_elevated_jump_node( var_0, var_1 )
{
    var_2 = getnodesinradius( var_0.origin, 800, 400, 256, "jump" );

    if ( var_2.size == 0 )
        return;

    var_3 = [];

    if ( getdvarint( "alien_retreat_towards_spawn" ) == 1 )
    {
        var_3["direction"] = "override";
        var_3["direction_override"] = vectornormalize( self.spawnorigin - var_0.origin );
        var_3["direction_weight"] = 8.0;
    }
    else
    {
        var_3["direction"] = var_1;
        var_3["direction_weight"] = 1.0;
    }

    var_3["min_height"] = 64.0;
    var_3["max_height"] = 400.0;
    var_3["height_weight"] = 2.0;
    var_3["enemy_los"] = 1;
    var_3["enemy_los_weight"] = 2.0;
    var_3["min_dist_from_enemy"] = 400.0;
    var_3["max_dist_from_enemy"] = 800.0;
    var_3["desired_dist_from_enemy"] = 600.0;
    var_3["dist_from_enemy_weight"] = 3.0;
    var_3["min_dist_from_all_enemies"] = 200.0;
    var_3["min_dist_from_all_enemies_weight"] = 1.0;
    var_3["not_recently_used_weight"] = 4.0;
    var_3["random_weight"] = 1.0;
    var_4 = get_retreat_node_rated( var_0, var_3, var_2 );
    return var_4;
}

_ID8104( var_0, var_1 )
{
    var_2 = 1;
    self endon( "go to combat" );
    thread _ID21338( var_0 );
    thread _ID35952( var_0 );
    var_3 = [];

    if ( getdvarint( "alien_cover_node_retreat" ) == 1 )
    {
        var_3["direction"] = "cover";
        var_3["direction_weight"] = 2.0;
        var_3["enemy_los_weight"] = 0.0;
        var_3["max_dist_from_enemy"] = 1200.0;
    }
    else if ( getdvarint( "alien_retreat_towards_spawn" ) == 1 )
    {
        var_3["direction"] = "override";
        var_3["direction_override"] = vectornormalize( self.spawnorigin - var_0.origin );
        var_3["direction_weight"] = 8.0;
        var_3["enemy_los_weight"] = 6.0;
        var_3["max_dist_from_enemy"] = 800.0;
    }
    else
    {
        var_3["direction"] = var_1;
        var_3["direction_weight"] = 1.0;
        var_3["enemy_los_weight"] = 6.0;
        var_3["max_dist_from_enemy"] = 800.0;
    }

    var_3["min_height"] = -32.0;
    var_3["max_height"] = 128.0;
    var_3["height_weight"] = 1.0;
    var_3["enemy_los"] = 0;
    var_3["min_dist_from_enemy"] = 400.0;
    var_3["desired_dist_from_enemy"] = 600.0;
    var_3["dist_from_enemy_weight"] = 2.0;
    var_3["min_dist_from_all_enemies"] = 200.0;
    var_3["min_dist_from_all_enemies_weight"] = 1.0;
    var_3["min_dist_from_current_position"] = 256.0;
    var_3["min_dist_from_current_position_weight"] = 3.0;
    var_3["not_recently_used_weight"] = 4.0;
    var_3["random_weight"] = 1.0;
    var_4 = _ID14377( var_0, var_3 );

    if ( !isdefined( var_4 ) )
        return;

    self scragentsetgoalnode( var_4 );
    self scragentsetgoalradius( 64 );
    self waittill( "goal_reached" );

    for ( var_5 = 0; var_5 < var_2; var_5++ )
    {
        var_3["direction"] = "alien_forward";
        var_4 = _ID14377( var_0, var_3 );

        if ( !isdefined( var_4 ) )
            return;

        self scragentsetgoalnode( var_4 );
        self scragentsetgoalradius( 64 );
        self waittill( "goal_reached" );
    }
}

_ID14377( var_0, var_1 )
{
    if ( getdvarint( "alien_cover_node_retreat" ) == 1 )
        var_2 = getnodesinradius( var_0.origin, 800, 400, 256, "cover stand" );
    else
        var_2 = getnodesinradius( var_0.origin, 800, 400, 256 );

    if ( var_2.size == 0 )
        return undefined;

    var_3 = get_retreat_node_rated( var_0, var_1, var_2 );
    return var_3;
}

_ID7297( var_0, var_1 )
{
    self endon( "go to combat" );
    thread _ID21338( var_0 );
    thread _ID35952( var_0 );
    var_2 = getnodesinradius( var_0.origin, 800, 400, 256 );

    if ( var_2.size == 0 )
        var_2 = getnodesinradius( var_0.origin, 2000, 400, 256 );

    var_3 = [];
    var_3["direction"] = var_1;
    var_3["direction_weight"] = 1.0;
    var_3["min_height"] = -32.0;
    var_3["max_height"] = 32.0;
    var_3["height_weight"] = 2.0;
    var_3["enemy_los"] = 1;
    var_3["enemy_los_weight"] = 2.0;
    var_3["min_dist_from_enemy"] = 400.0;
    var_3["max_dist_from_enemy"] = 800.0;
    var_3["desired_dist_from_enemy"] = 600.0;
    var_3["dist_from_enemy_weight"] = 3.0;
    var_3["min_dist_from_all_enemies"] = 200.0;
    var_3["min_dist_from_all_enemies_weight"] = 1.0;
    var_3["not_recently_used_weight"] = 4.0;
    var_3["random_weight"] = 2.0;
    var_4 = get_retreat_node_rated( var_0, var_3, var_2 );
    self scragentsetgoalnode( var_4 );
    self scragentsetgoalradius( 64 );
    self waittill( "goal_reached" );
    var_5 = randomint( 2 );

    for ( var_6 = 0; var_6 < getdvarint( "alien_circling_retreat_num_nodes" ) - 1; var_6++ )
    {
        var_7 = self.origin - var_0.origin;
        var_8 = vectortoangles( var_7 );
        var_9 = anglestoright( var_8 );

        if ( var_5 )
            var_9 *= -1;

        var_2 = getnodesinradius( var_0.origin, 800, 500, 256 );

        if ( var_2.size == 0 )
            var_2 = getnodesinradius( var_0.origin, 2000, 400, 256 );

        var_3["direction"] = "override";
        var_3["direction_override"] = var_9;
        var_3["direction_weight"] = 2.0;
        var_3["random_weight"] = 1.0;
        var_3["min_dist_from_current_position"] = 256.0;
        var_3["min_dist_from_current_position_weight"] = 3.0;
        var_10 = get_retreat_node_rated( var_0, var_3, var_2 );
        self scragentsetgoalnode( var_10 );
        self scragentsetgoalradius( 64 );
        self waittill( "goal_reached" );
    }
}

elevated_circling_retreat( var_0, var_1 )
{
    self endon( "go to combat" );
    thread _ID21338( var_0 );
    thread _ID35952( var_0 );
    var_2 = get_elevated_jump_node( var_0, var_1 );

    if ( !isdefined( var_2 ) )
        return;

    self scragentsetgoalnode( var_2 );
    self scragentsetgoalradius( 64 );
    self waittill( "goal_reached" );
    var_3 = [];
    var_3["direction"] = var_1;
    var_3["direction_weight"] = 1.0;
    var_3["min_height"] = -32.0;
    var_3["max_height"] = 32.0;
    var_3["height_weight"] = 2.0;
    var_3["enemy_los"] = 1;
    var_3["enemy_los_weight"] = 2.0;
    var_3["min_dist_from_enemy"] = 400.0;
    var_3["max_dist_from_enemy"] = 800.0;
    var_3["desired_dist_from_enemy"] = 600.0;
    var_3["dist_from_enemy_weight"] = 3.0;
    var_3["min_dist_from_all_enemies"] = 200.0;
    var_3["min_dist_from_all_enemies_weight"] = 1.0;
    var_3["not_recently_used_weight"] = 4.0;
    var_3["random_weight"] = 2.0;
    var_4 = randomint( 2 );

    for ( var_5 = 0; var_5 < getdvarint( "alien_circling_retreat_num_nodes" ) - 1; var_5++ )
    {
        var_6 = self.origin - var_0.origin;
        var_7 = vectortoangles( var_6 );
        var_8 = anglestoright( var_7 );

        if ( var_4 )
            var_8 *= -1;

        var_9 = getnodesinradius( self.origin, 800, 250, 256, "jump" );

        if ( var_9.size == 0 )
            return;

        var_3["direction"] = "override";
        var_3["direction_override"] = var_8;
        var_3["direction_weight"] = 2.0;
        var_3["random_weight"] = 1.0;
        var_3["min_dist_from_current_position"] = 256.0;
        var_3["min_dist_from_current_position_weight"] = 3.0;
        var_10 = get_retreat_node_rated( var_0, var_3, var_9 );
        self scragentsetgoalnode( var_10 );
        self scragentsetgoalradius( 64 );
        self waittill( "goal_reached" );
    }
}

close_range_retreat( var_0 )
{
    self endon( "go to combat" );
    thread _ID21338( var_0 );
    thread _ID35952( var_0 );
    _ID28199( "run" );
    var_1 = 55;
    var_2 = 75;
    var_3 = 256;
    var_4 = 256;
    var_5 = _ID14618( var_0, var_3, var_4, var_1, var_2 );
    var_6 = getnodesinradius( var_5, 256, 0, 128, "path" );

    if ( var_6.size == 0 )
        var_6 = getnodesinradius( var_5, 500, 256, 128, "path" );

    if ( var_6.size == 0 )
    {
        wait 0.2;
        return;
    }

    var_7 = [];

    if ( getdvarint( "alien_retreat_towards_spawn" ) == 1 )
        var_7["direction_weight"] = 8.0;
    else
        var_7["direction_weight"] = 3.0;

    var_7["direction"] = "override";
    var_7["direction_override"] = vectornormalize( var_5 - self.origin );
    var_7["min_height"] = -32.0;
    var_7["max_height"] = 32.0;
    var_7["height_weight"] = 6.0;
    var_7["enemy_los"] = 0;
    var_7["enemy_los_weight"] = 0.0;
    var_7["min_dist_from_enemy"] = 150.0;
    var_7["max_dist_from_enemy"] = 800.0;
    var_7["desired_dist_from_enemy"] = 200.0;
    var_7["dist_from_enemy_weight"] = 3.0;
    var_7["min_dist_from_all_enemies"] = 150.0;
    var_7["min_dist_from_all_enemies_weight"] = 1.0;
    var_7["not_recently_used_weight"] = 4.0;
    var_7["random_weight"] = 2.0;
    var_8 = get_retreat_node_rated( var_0, var_7, var_6 );
    self scragentsetgoalnode( var_8 );
    self scragentsetgoalradius( 64 );
    self waittill( "goal_reached" );
}

get_retreat_node_rated( var_0, var_1, var_2 )
{
    if ( var_2.size == 0 )
        return undefined;

    var_3 = var_1["direction"];
    var_4 = var_1["direction_weight"];
    var_5 = var_1["min_height"];
    var_6 = var_1["max_height"];
    var_7 = var_1["height_weight"];
    var_8 = var_1["enemy_los"];
    var_9 = var_1["enemy_los_weight"];
    var_10 = var_1["min_dist_from_enemy"];
    var_11 = var_1["max_dist_from_enemy"];
    var_12 = var_1["desired_dist_from_enemy"];
    var_13 = var_1["dist_from_enemy_weight"];
    var_14 = var_1["min_dist_from_all_enemies"];
    var_15 = var_1["min_dist_from_all_enemies_weight"];
    var_16 = var_1["min_dist_from_current_position"];
    var_17 = var_1["min_dist_from_current_position_weight"];
    var_18 = var_1["not_recently_used_weight"];
    var_19 = var_1["random_weight"];

    if ( isdefined( var_1["recently_used_time_limit"] ) )
        var_20 = var_1["recently_used_time_limit"];
    else
        var_20 = 10.0;

    if ( isdefined( var_1["test_offset"] ) )
        var_21 = var_1["test_offset"];
    else
        var_21 = ( 0, 0, 0 );

    var_22 = undefined;

    if ( isplayer( var_0 ) )
        var_22 = anglestoforward( var_0 getplayerangles() );
    else if ( isdefined( var_0 ) )
        var_22 = anglestoforward( var_0.angles );

    var_23 = undefined;
    var_24 = 0;

    if ( var_3 == "player_front" )
        var_23 = var_22;
    else if ( var_3 == "player_behind" )
        var_23 = var_22 * -1;
    else if ( var_3 == "alien_forward" )
        var_23 = anglestoforward( self.angles );
    else if ( var_3 == "alien_backward" )
        var_23 = anglestoforward( self.angles ) * -1;
    else if ( var_3 == "cover" )
        var_24 = 1;
    else if ( var_3 == "override" )
        var_23 = var_1["direction_override"];
    else
    {

    }

    var_25 = 0;
    var_26 = -1.0;
    var_27 = 0;

    for ( var_28 = 0; var_25 < var_2.size; var_25++ )
    {
        var_29 = var_2[var_25];
        var_30 = var_29.origin + var_21;
        var_31 = 0.0;

        if ( var_7 > 0.0 )
        {
            if ( var_30[2] - var_0.origin[2] > var_5 && var_30[2] - var_0.origin[2] < var_6 )
                var_31 += var_7;
        }

        var_32 = undefined;

        if ( var_24 )
        {
            var_23 = anglestoforward( var_29.angles );
            var_32 = vectornormalize( var_0.origin - var_30 );
        }
        else
            var_32 = vectornormalize( var_30 - self.origin );

        var_33 = vectordot( var_23, var_32 );
        var_31 += ( var_33 + 1.0 ) * 0.5 * var_4;

        if ( var_13 > 0.0 )
        {
            var_34 = distance( var_30, var_0.origin );

            if ( var_34 > var_10 && var_34 < var_11 )
            {
                var_35 = 0.0;

                if ( var_34 > var_12 )
                    var_35 += 1 - ( var_34 - var_12 ) / ( var_11 - var_12 );
                else
                    var_35 += ( var_34 - var_10 ) / ( var_12 - var_10 );

                var_31 += var_35 * var_13;
            }
        }

        if ( var_15 )
        {
            var_36 = 1;

            foreach ( var_38 in level.players )
            {
                if ( !isdefined( var_0 ) || var_38 != var_0 )
                {
                    if ( distancesquared( var_30, var_38.origin ) < var_14 * var_14 )
                    {
                        var_36 = 0;
                        break;
                    }
                }
            }

            if ( var_36 )
                var_31 += var_15;
        }

        if ( isdefined( var_17 ) && var_17 > 0.0 )
        {
            if ( distancesquared( self.origin, var_30 ) > var_16 * var_16 )
                var_31 += var_17;
        }

        if ( !_ID22088( var_29, var_20 ) )
            var_31 += var_18;

        if ( var_19 > 0.0 )
            var_31 += randomfloat( var_19 );

        if ( var_9 > 0.0 && var_31 > var_26 - var_9 )
        {
            while ( _ID20708() )
            {
                var_28++;

                if ( var_28 >= 20 )
                    break;

                common_scripts\utility::_ID35582();
            }

            if ( isdefined( var_0 ) )
            {
                var_40 = sighttracepassed( var_0 get_eye_position(), var_30 + ( 0, 0, 50 ), 0, self );
                level._ID22098++;

                if ( var_8 == var_40 )
                    var_31 += var_9;
            }
        }

        if ( var_31 > var_26 )
        {
            var_26 = var_31;
            var_27 = var_25;
        }
    }

    _ID25691( var_2[var_27] );
    return var_2[var_27];
}

get_eye_position()
{
    if ( isalive( self ) && ( isplayer( self ) || isagent( self ) ) )
        return self geteye();

    return self.origin;
}

_ID20708()
{
    var_0 = 5;

    if ( gettime() > level._ID22099 )
    {
        level._ID22099 = gettime();
        level._ID22098 = 0;
    }

    return level._ID22098 >= var_0;
}

_ID9354( var_0, var_1 )
{
    var_2 = do_initial_approach( var_0 );
    var_3 = self._ID32265;
    var_4 = randomfloat( 1.0 ) < var_3;

    if ( !var_4 && _ID15704( var_0 ) )
        return "leap";

    return _ID15696( var_0, var_2 );
}

do_initial_approach( var_0 )
{
    thread _ID18975( var_0 );
    var_1 = undefined;

    if ( distancesquared( self.origin, var_0.origin ) > 250000.0 )
        var_1 = approach_enemy( 400, var_0, 3 );

    return var_1;
}

_ID18975( var_0 )
{
    self notify( "jogWhenCloseToEnemy" );
    self endon( "jogWhenCloseToEnemy" );
    self endon( "death" );
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    level endon( "game_ended" );

    if ( distancesquared( self.origin, var_0.origin ) >= 4000000 )
        _ID28199( "run" );

    for (;;)
    {
        wait 1.0;

        if ( distancesquared( self.origin, var_0.origin ) < 4000000 )
            break;
    }

    _ID32289();
}

_ID32289()
{
    if ( self.movemode == "jog" )
        return;

    var_0 = 0.9;
    _ID28199( "jog" );
    self.moveplaybackrate = self.moveplaybackrate * var_0;
    thread backtorunondamage( 1 );
}

backtorunondamage( var_0 )
{
    self notify( "backToRunOnDamage" );
    self endon( "backToRunOnDamage" );
    self endon( "death" );
    level endon( "game_ended" );

    if ( isdefined( var_0 ) && var_0 )
        common_scripts\utility::_ID35626( "damage", "start_attack", "bulletwhizby" );
    else
        common_scripts\utility::_ID35626( "damage", "start_attack" );

    _ID28199( "run" );
    self.moveplaybackrate = self.defaultmoveplaybackrate;
}

_ID30295( var_0 )
{
    self endon( "death" );
    self endon( "start_attack" );
    _ID28199( "walk" );
    var_1 = 1.05;

    for (;;)
    {
        wait 1.0;

        if ( _ID17482() || distancesquared( self.origin, var_0.origin ) > 160000 * var_1 )
        {
            _ID28199( "run" );
            break;
        }
    }
}

_ID17482()
{
    foreach ( var_1 in level.players )
    {
        if ( _ID17481( var_1 ) )
            return 1;
    }

    return 0;
}

_ID17481( var_0 )
{
    var_1 = 0.5;
    var_2 = self.origin - var_0.origin;
    var_3 = anglestoforward( var_0.angles );
    var_4 = vectordot( var_2, var_3 );

    if ( var_4 < 0 )
        return 0;

    var_5 = var_4 > var_1;
    return var_5;
}

_ID15696( var_0, var_1 )
{
    var_2 = getdvarint( "alien_melee_distance" );

    if ( var_2 < 100 )
        var_2 = 100;

    run_near_enemy( var_2, var_0 );

    if ( !self agentcanseesentient( var_0 ) )
        return "none";

    return "swipe";
}

_ID12924( var_0 )
{
    var_1 = distance( self.origin, var_0.origin );

    if ( var_1 < 200 )
        return;

    var_2 = var_0.origin - self.origin;
    var_3 = self.origin + var_2 * 0.5;
    var_4 = var_0 get_eye_position();
    var_5 = 0.95757;
    var_6 = getnodesinradius( var_3, var_1 + 100.0, 100.0, 256.0, "node_jump" );
    var_7 = [];

    foreach ( var_9 in var_6 )
    {
        if ( var_9.origin[2] < var_0.origin[2] + 32.0 )
            continue;

        var_10 = var_0.origin - var_9.origin;
        var_11 = self.origin - var_0.origin;

        if ( vectordot( var_11, var_10 ) > 0 )
            continue;

        var_12 = self.origin - var_9.origin;
        var_13 = var_11 * -1;

        if ( vectordot( var_13, var_12 ) > 0 )
            continue;

        if ( distancesquared( self.origin, var_9.origin ) < 65536.0 )
            continue;

        if ( distancesquared( var_0.origin, var_9.origin ) < 65536.0 )
            continue;

        var_14 = vectornormalize( var_9.origin - var_4 );
        var_15 = vectornormalize( var_14 * ( 1, 1, 0 ) );
        var_16 = vectordot( var_14, var_15 );

        if ( var_16 < var_5 )
            continue;

        var_17 = self geteye();
        var_18 = var_9.origin + ( 0, 0, 32 );
        var_19 = bullettrace( var_17, var_18, 0, self );

        if ( var_19["surfacetype"] != "none" )
            continue;

        var_4 = var_0 get_eye_position();
        var_19 = bullettrace( var_18, var_4, 0, var_0 );

        if ( var_19["surfacetype"] != "none" )
            continue;

        var_7[var_7.size] = var_9;
    }

    if ( var_7.size == 0 )
    {
        return undefined;
        return;
    }

    var_21 = [];
    var_21["direction"] = "alien_forward";
    var_21["direction_weight"] = 1.0;
    var_21["height_weight"] = 0.0;
    var_21["enemy_los_weight"] = 0.0;
    var_21["dist_from_enemy_weight"] = 0.0;
    var_21["min_dist_from_all_enemies_weight"] = 0.0;
    var_21["not_recently_used_weight"] = 4.0;
    var_21["random_weight"] = 1.0;
    var_22 = get_retreat_node_rated( var_0, var_21, var_7 );
    return var_22;
    return;
}

_ID32263( var_0 )
{
    self._ID20883 = "swipe";
    alien_melee( var_0 );
}

_ID19775( var_0 )
{
    self._ID20883 = "leap";
    alien_melee( var_0 );
}

_ID35831( var_0 )
{
    self._ID20883 = "wall";
    alien_melee( var_0 );
}

_ID32302( var_0 )
{
    self._ID20883 = "synch";
    alien_melee( var_0 );
}

badpath_jump( var_0 )
{
    self._ID20883 = "badpath_jump";
    alien_melee( var_0 );
}

_ID32264( var_0 )
{
    self._ID20883 = "swipe_static";
    alien_melee( var_0 );
}

alien_melee( var_0 )
{
    if ( _ID20854() && _ID4136() )
    {
        if ( maps\mp\alien\_unk1464::_ID14264() != "spitter" && maps\mp\alien\_unk1464::_ID14264() != "seeder" )
        {
            self scragentsetgoalentity( var_0 );
            self scragentsetgoalradius( 4096.0 );
        }

        self waittill( "melee_complete" );
        return;
    }

    wait 0.2;
    return;
}

_ID35969()
{
    self endon( "death" );

    for (;;)
    {
        if ( isdefined( self.alien_scripted ) && self.alien_scripted == 1 )
        {
            self notify( "alien_main_loop_restart" );

            while ( isdefined( self.alien_scripted ) && self.alien_scripted == 1 )
                wait 0.05;
        }

        wait 0.05;
    }
}

_ID35951()
{
    self endon( "death" );
    self._ID4637 = 0;

    for (;;)
    {
        self waittill( "bad_path",  var_0, var_1  );
        self._ID4637 = 1;

        if ( !isdefined( self.badpathcount ) || isdefined( self.badpathtime ) && gettime() > self.badpathtime + 2000 )
            self.badpathcount = 0;

        self.badpathtime = gettime();
        self.badpathcount++;
        self notify( "alien_main_loop_restart" );
        wait 0.05;
    }
}

_ID28199( var_0 )
{
    switch ( var_0 )
    {
        case "walk":
        case "run":
        case "jog":
            self.movemode = var_0;
            break;
        default:
            break;
    }
}

_ID35958()
{
    self endon( "death" );

    if ( self.insolid )
        handleinsolid();

    for (;;)
    {
        self waittill( "insolid" );
        handleinsolid();
    }
}

handleinsolid()
{
    while ( self.insolid )
        wait 0.2;

    self scragentsetgoalpos( self.origin );
    self notify( "alien_main_loop_restart" );
}

approach_enemy( var_0, var_1, var_2 )
{
    if ( var_0 < 32 )
        var_0 = 32;

    var_3 = get_approach_node( var_1 );
    var_4 = var_0 * var_0;

    for ( var_5 = 0; isdefined( var_3 ) && var_5 < var_2; var_3 = get_approach_node( var_1 ) )
    {
        if ( _ID27004( var_3, var_0, var_1 ) )
            return var_3;

        if ( distancesquared( self.origin, var_1.origin ) < 250000.0 )
            break;

        var_5++;
    }

    _ID27005( var_0, var_1 );
}

_ID27004( var_0, var_1, var_2 )
{
    self notify( "approach_goal_invalid" );
    self scragentsetgoalradius( 64 );
    self scragentsetgoalnode( var_0 );
    _ID35515( var_0, var_1, var_2 );
    return distancesquared( var_2.origin, self.origin ) <= var_1 * var_1;
}

_ID27005( var_0, var_1 )
{
    self notify( "approach_goal_invalid" );
    var_2 = max( var_0 + -48, 32 );
    self scragentsetgoalradius( var_2 );
    self scragentsetgoalentity( var_1 );
    wait_till_distance_from_enemy( var_0, var_1 );
}

_ID35515( var_0, var_1, var_2 )
{
    self endon( "goal_reached" );
    self endon( "approach_goal_invalid" );
    thread _ID21297( var_0, var_2 );
    wait_till_distance_from_enemy( var_1, var_2 );
}

_ID21297( var_0, var_1 )
{
    self endon( "goal_reached" );
    self endon( "death" );
    self endon( "approach_goal_invalid" );
    var_1 endon( "death" );
    var_2 = 202500;

    while ( isdefined( var_0 ) && isdefined( var_1 ) )
    {
        if ( distancesquared( var_0.origin, var_1.origin ) > var_2 )
            break;

        var_3 = vectornormalize( self.origin - var_1.origin );
        var_4 = vectornormalize( var_0.origin - var_1.origin );

        if ( vectordot( var_3, var_4 ) < 0 )
            break;

        wait 0.2;
    }

    self notify( "approach_goal_invalid" );
}

wait_till_distance_from_enemy( var_0, var_1 )
{
    var_2 = var_0 * var_0;

    for (;;)
    {
        if ( get_distance_squared_to_enemy( var_1 ) < var_2 )
            break;

        common_scripts\utility::_ID35582();
    }
}

get_distance_squared_to_enemy( var_0 )
{
    if ( isplayer( var_0 ) && var_0 isonladder() )
        return distance2dsquared( self.origin, var_0.origin );

    return distancesquared( self.origin, var_0.origin );
}

run_near_enemy( var_0, var_1, var_2 )
{
    if ( var_0 < 32 )
        var_0 = 32;

    if ( !isdefined( var_2 ) || !_ID27004( var_2, var_0, var_1 ) )
    {
        _ID27005( var_0, var_1 );
        return;
    }
}

_ID14618( var_0, var_1, var_2, var_3, var_4 )
{
    if ( getdvarint( "alien_retreat_towards_spawn" ) == 1 )
        var_5 = self.spawnorigin;
    else
        var_5 = self.origin;

    var_6 = vectornormalize( ( var_5 - var_0.origin ) * ( 1, 1, 0 ) );
    var_7 = randomintrange( var_3, var_4 );

    if ( common_scripts\utility::_ID7657() )
        var_7 *= -1;

    var_8 = ( 0, var_7, 0 );
    var_9 = rotatevector( var_6, var_8 );
    var_10 = var_1;

    if ( var_1 < var_2 )
        var_10 = randomintrange( var_1, var_2 );

    return var_0.origin + var_9 * var_10;
}

get_approach_node( var_0 )
{
    var_1 = 20;
    var_2 = 30;
    var_3 = getdvarint( "alien_melee_distance" );

    if ( var_3 < 100 )
        var_3 = 100;

    var_4 = _ID14618( var_0, var_3, var_3, var_1, var_2 );
    var_5 = getnodesinradius( var_4, 150, 0, 128, "path" );

    if ( var_5.size == 0 )
        var_5 = getnodesinradius( var_4, 300, 150, 128, "path" );

    var_6 = [];
    var_6["direction"] = "override";
    var_6["direction_weight"] = 6.0;
    var_6["direction_override"] = vectornormalize( var_0.origin - self.origin );
    var_6["min_height"] = -32.0;
    var_6["max_height"] = 32.0;
    var_6["height_weight"] = 6.0;
    var_6["enemy_los"] = 0;
    var_6["enemy_los_weight"] = 0.0;
    var_6["min_dist_from_enemy"] = 150.0;
    var_6["max_dist_from_enemy"] = 800.0;
    var_6["desired_dist_from_enemy"] = distance( var_4, var_0.origin );
    var_6["dist_from_enemy_weight"] = 3.0;
    var_6["min_dist_from_all_enemies"] = 150.0;
    var_6["min_dist_from_all_enemies_weight"] = 1.0;
    var_6["not_recently_used_weight"] = 4.0;
    var_6["random_weight"] = 2.0;
    return get_retreat_node_rated( var_0, var_6, var_5 );
}

_ID35493( var_0 )
{
    var_1 = randomintrange( -100, 100 ) + 400;
    var_2 = var_1 * var_1;
    var_3 = 43264;

    for (;;)
    {
        if ( distancesquared( self.origin, var_0.origin ) < var_2 )
            break;

        wait 0.05;
    }

    for (;;)
    {
        if ( !isalive( var_0 ) )
            return 0;

        if ( distancesquared( self.origin, var_0.origin ) < var_3 )
            return 0;

        if ( can_leap_melee( var_0, 400, 208 ) )
            return 1;

        wait 0.05;
    }
}

_ID15704( var_0 )
{
    self scragentsetgoalentity( var_0 );
    self scragentsetgoalradius( 160 );
    return _ID35493( var_0 );
}

go_to_leaping_melee_node( var_0 )
{
    var_1 = getnodesinradius( var_0.origin, 512.0, 200.0, 256.0, "node_jump" );
    var_2 = [];
    var_3 = var_0 get_eye_position();
    var_4 = ( 0, 0, 32 );
    var_5 = undefined;

    foreach ( var_7 in var_1 )
    {
        var_8 = bullettracepassed( var_7.origin + var_4, var_3, 0, self );

        if ( var_8 )
        {
            var_5 = var_7;
            break;
        }
    }

    if ( !isdefined( var_5 ) )
        return 0;

    self scragentsetgoalnode( var_5 );
    self scragentsetgoalradius( 160 );
    var_10 = 160000;
    var_11 = 0.0;
    return _ID35493( var_0 );
}

can_leap_melee( var_0, var_1, var_2 )
{
    if ( !_ID20854() )
        return 0;

    if ( isdefined( var_1 ) )
    {
        if ( distancesquared( self.origin, var_0.origin ) > var_1 * var_1 )
            return 0;
    }

    var_3 = self.origin + ( 0, 0, 32 );
    var_4 = var_0 get_eye_position();
    var_5 = maps\mp\agents\alien\_alien_melee::_ID14588( 1.0, 48, var_0 );
    self._ID19777 = var_5;

    if ( !isdefined( var_5 ) )
        return 0;

    if ( distancesquared( self.origin, var_5 ) < var_2 )
        return 0;

    var_6 = trajectorycanattemptaccuratejump( self.origin, anglestoup( self.angles ), var_5, anglestoup( var_0.angles ), level._ID2791, 1.01 * level.alien_jump_melee_speed );
    return var_6;
}

_ID20854()
{
    switch ( self.currentanimstate )
    {
        case "move":
            return 1;
        case "melee":
            return 1;
        case "idle":
            return 1;
        default:
            return 0;
    }
}

_ID25691( var_0 )
{
    var_1 = [];
    var_1["node"] = var_0;
    var_1["time_stamp"] = gettime();
    level._ID34734[level._ID34735] = var_1;
    level._ID34735++;

    if ( level._ID34735 == level._ID34736 )
    {
        level._ID34735 = 0;
        return;
    }
}

_ID22088( var_0, var_1 )
{
    var_2 = 0;

    for ( var_3 = 0; var_3 < level._ID34736; var_3++ )
    {
        var_4 = level._ID34735 - var_3;

        if ( var_4 < 0 )
            var_4 = level._ID34736 + var_4;

        if ( isdefined( level._ID34734[var_4] ) )
        {
            var_5 = level._ID34734[var_4];

            if ( var_0 == var_5["node"] )
            {
                if ( gettime() - var_5["time_stamp"] < var_1 * 1000 )
                    var_2 = 1;

                break;
            }
        }
    }

    return var_2;
}

_ID14299()
{
    if ( isdefined( self.bypass_max_attacker_counter ) && self.bypass_max_attacker_counter == 1 )
        return 1;

    if ( isdefined( self.attack_sequence_num ) )
    {
        var_0 = self.attack_sequence_num;
        self.attack_sequence_num = undefined;
        return var_0;
    }

    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "elite":
        case "spitter":
        case "locust":
        case "gargoyle":
        case "seeder":
            return 1;
        default:
            return randomint( 3 ) + 6;
    }
}

get_attack_num()
{
    if ( isdefined( self._ID4071 ) )
    {
        var_0 = self._ID4071;
        self._ID4071 = undefined;
        return var_0;
    }

    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "locust":
        case "gargoyle":
            return 1;
        default:
            return randomint( 6 ) + 3;
    }
}

_ID25373( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "go to combat" );
    self endon( "death" );
    var_5 = [];
    var_5["run"] = var_0;
    var_5["jog"] = var_1;
    var_5["walk"] = var_2;
    var_6 = var_0 + var_1 + var_2;
    var_7 = 262144.0;

    for (;;)
    {
        if ( maps\mp\alien\_unk1464::any_player_nearby( self.origin, var_7 ) )
            var_8 = "run";
        else
        {
            var_9 = 0;
            var_10 = randomintrange( 0, var_6 );
            var_8 = undefined;

            foreach ( var_13, var_12 in var_5 )
            {
                var_9 += var_12;

                if ( var_10 <= var_9 )
                {
                    var_8 = var_13;
                    break;
                }
            }
        }

        _ID28199( var_8 );
        wait(randomfloatrange( var_3, var_4 ));
    }
}

armormitigation( var_0, var_1, var_2 )
{

}

_ID23834( var_0, var_1 )
{
    if ( !isdefined( var_1 ) || !isdefined( var_0 ) )
        return;

    var_2 = var_1 * -1;
    var_3 = anglestoup( vectortoangles( var_2 ) );
    playfx( level._ID1644["shield_impact"], var_0, var_2, var_3 );
    self playsound( "bullet_large_metal" );
}

_ID16365( var_0 )
{
    var_1 = maps\mp\alien\_unk1464::getrawbaseweaponname( var_0 );

    if ( isdefined( self.special_ammocount ) && isdefined( self.special_ammocount[var_1] ) && self.special_ammocount[var_1] > 0 )
        return 1;

    return 0;
}

get_pet_follow_node( var_0 )
{
    var_1 = getnodesinradius( var_0.origin, 512, 128, 350, "node_jump" );
    var_2 = [];
    var_2["direction"] = "player_front";
    var_2["direction_weight"] = 2.0;
    var_2["min_height"] = -32.0;
    var_2["max_height"] = 350.0;
    var_2["height_weight"] = 2.0;
    var_2["enemy_los"] = 1;
    var_2["enemy_los_weight"] = 2.0;
    var_2["min_dist_from_enemy"] = 128.0;
    var_2["max_dist_from_enemy"] = 512.0;
    var_2["desired_dist_from_enemy"] = 350.0;
    var_2["dist_from_enemy_weight"] = 3.0;
    var_2["min_dist_from_all_enemies"] = 200.0;
    var_2["min_dist_from_all_enemies_weight"] = 0.0;
    var_2["not_recently_used_weight"] = 4.0;
    var_2["random_weight"] = 2.0;
    var_3 = get_retreat_node_rated( var_0, var_2, var_1 );
    return var_3;
}
