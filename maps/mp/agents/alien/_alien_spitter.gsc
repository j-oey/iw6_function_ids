// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20113()
{
    level._ID1644["spit_AOE"] = loadfx( "vfx/gameplay/alien/vfx_alien_spitter_gas_cloud" );
    level._ID1644["spit_AOE_small"] = loadfx( "vfx/gameplay/alien/vfx_alien_spitter_gas_cloud_64" );
}

_ID31030()
{
    self.gas_cloud_available = 1;
}

_ID31028()
{
    _ID25733();
}

is_escape_sequence_active()
{
    return common_scripts\utility::flag_exist( "hives_cleared" ) && common_scripts\utility::_ID13177( "hives_cleared" );
}

_ID14583()
{
    if ( is_escape_sequence_active() )
        return 3240000;

    return 1440000;
}

_ID14573()
{
    if ( is_escape_sequence_active() )
        return 1.0;

    return 0.5;
}

_ID31022( var_0 )
{
    if ( self.spit_type == "gas_cloud" )
        level._ID31031 = gettime();

    self._ID20883 = "spit";
    self._ID31023 = var_0;
    maps\mp\agents\alien\_alien_think::alien_melee( var_0 );
}

_ID31017( var_0 )
{
    self endon( "melee_pain_interrupt" );
    var_1 = isdefined( var_0 ) && isdefined( var_0.code_classname ) && var_0.code_classname == "script_vehicle";

    if ( var_1 )
        var_2 = var_0;
    else
        var_2 = self._ID31023;

    var_2 endon( "death" );
    maps\mp\agents\alien\_alien_anim_utils::_ID33986( var_2 );

    if ( isalive( var_2 ) )
    {
        self._ID31023 = var_2;

        if ( var_1 )
        {
            var_3 = 5;
            var_4 = vectornormalize( anglestoforward( var_2.angles ) );
            var_5 = length( var_2 vehicle_getvelocity() ) * var_3;
            var_6 = var_4 * var_5;
            self.spit_target_location = var_2.origin + var_6 + ( 0, 0, 32 );
        }
        else
            self.spit_target_location = var_2.origin;

        self.looktarget = var_2;
        maps\mp\alien\_unk1464::_ID28196( 0.2, 1.0 );

        if ( isdefined( self.current_spit_node ) && !maps\mp\alien\_unk1464::is_normal_upright( anglestoup( self.current_spit_node.angles ) ) )
        {
            var_7 = anglestoup( self.current_spit_node.angles );
            var_8 = anglestoforward( self.angles );
            var_9 = vectorcross( var_7, var_8 );
            var_8 = vectorcross( var_9, var_7 );
            var_10 = ( 0, 0, 0 ) - var_9;
            var_11 = axistoangles( var_8, var_10, var_7 );
            self scragentsetorientmode( "face angle abs", var_11 );
        }
        else if ( isdefined( self.enemy ) && var_2 == self.enemy )
            self scragentsetorientmode( "face enemy" );
        else
        {
            var_8 = vectornormalize( var_2.origin - self.origin );

            if ( isdefined( self.current_spit_node ) )
                var_7 = anglestoup( self.current_spit_node.angles );
            else
                var_7 = anglestoup( self.angles );

            var_9 = vectorcross( var_7, var_8 );
            var_8 = vectorcross( var_9, var_7 );
            var_10 = ( 0, 0, 0 ) - var_9;
            var_11 = axistoangles( var_8, var_10, var_7 );
            self scragentsetorientmode( "face angle abs", var_11 );
        }

        if ( self.oriented )
            self scragentsetanimmode( "anim angle delta" );
        else
            self scragentsetanimmode( "anim deltas" );

        _ID23849();
    }

    maps\mp\alien\_unk1464::_ID28197( 0.2 );
    self.looktarget = undefined;
    self._ID31023 = undefined;
    self.spit_target_location = undefined;
    self.spit_type = undefined;
}

_ID23849()
{
    switch ( self.spit_type )
    {
        case "close_range":
            maps\mp\agents\_scriptedagents::_ID23883( "close_spit_attack", "spit_attack", "end", ::_ID16239 );
            break;
        case "gas_cloud":
            maps\mp\agents\_scriptedagents::_ID23883( "gas_spit_attack", "spit_attack", "end", ::_ID16239 );
            break;
        case "long_range":
            var_0 = randomintrange( 2, 3 );

            for ( var_1 = 0; var_1 < var_0; var_1++ )
                maps\mp\agents\_scriptedagents::_ID23883( "long_range_spit_attack", "spit_attack", "end", ::_ID16239 );

            break;
        default:
            break;
    }
}

_ID14313( var_0 )
{
    if ( common_scripts\utility::_ID7657() && maps\mp\alien\_unk1464::_ID14264() != "seeder" )
    {
        var_1 = _ID14488();

        foreach ( var_3 in var_1 )
        {
            if ( is_valid_spit_target( var_3, 0 ) )
                return var_3;
        }

        wait 0.05;
    }

    if ( isdefined( var_0 ) )
    {
        if ( isalive( var_0 ) && is_valid_spit_target( var_0, 0 ) )
            return var_0;
    }

    var_5 = _ID14391();
    var_6 = 4;
    var_7 = 0;

    foreach ( var_9 in var_5 )
    {
        if ( !isalive( var_9 ) )
            continue;

        if ( isdefined( var_0 ) && var_9 == var_0 )
            continue;

        if ( is_valid_spit_target( var_9, 1 ) )
            return var_9;

        var_7++;

        if ( var_7 >= var_6 )
        {
            common_scripts\utility::_ID35582();
            var_7 = 0;
        }
    }

    return undefined;
}

_ID14488()
{
    var_0 = [];

    if ( !can_spit_gas_cloud() || _ID18468() )
        return var_0;

    foreach ( var_2 in level.players )
    {
        if ( !isalive( var_2 ) )
            continue;

        if ( isdefined( var_2._ID18011 ) && var_2._ID18011 )
            var_0[var_0.size] = var_2;
    }

    if ( isdefined( level.drill ) && isdefined( level.drill.state ) && level.drill.state == "offline" )
        var_0[var_0.size] = level.drill;

    return common_scripts\utility::array_randomize( var_0 );
}

is_valid_spit_target( var_0, var_1 )
{
    if ( !isalive( var_0 ) )
        return 0;

    if ( var_1 && isplayer( var_0 ) && !_ID16336( var_0 ) )
        return 0;

    var_2 = _ID14583();
    var_3 = distance2dsquared( self.origin, var_0.origin );

    if ( var_3 > var_2 )
        return 0;

    self.looktarget = var_0;

    if ( !isalive( var_0 ) )
        return 0;

    if ( ( isplayer( var_0 ) || issentient( var_0 ) ) && !isdefined( var_0.usingremote ) )
        var_4 = var_0 geteye();
    else
        var_4 = var_0.origin;

    var_5 = self gettagorigin( "TAG_BREATH" );
    return bullettracepassed( var_5, var_4, 0, self );
}

_ID14762( var_0 )
{
    return self gettagorigin( "TAG_BREATH" );
}

_ID16336( var_0 )
{
    var_1 = level.maxalienattackerdifficultyvalue - level._ID2829[self.alien_type].attributes["attacker_difficulty"];
    var_2 = maps\mp\agents\alien\_alien_think::_ID14385( var_0 );
    return var_2 <= var_1;
}

_ID16239( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( level._ID37115 ) )
    {
        self [[ level._ID37115 ]]( var_0, var_1, var_2, var_3 );
        return;
    }

    if ( var_0 == "spit" )
    {
        return fire_spit_projectile();
        return;
    }
}

fire_spit_projectile()
{
    if ( !isdefined( self._ID31023 ) && !isdefined( self.spit_target_location ) )
        return;

    var_0 = isalive( self._ID31023 );
    var_1 = isdefined( self._ID31023.code_classname ) && self._ID31023.code_classname == "script_vehicle";

    if ( var_0 && !var_1 )
        var_2 = self._ID31023.origin;
    else
        var_2 = self.spit_target_location;

    if ( self.spit_type == "gas_cloud" )
    {
        _ID31020( var_2 );
        return;
    }

    if ( var_0 )
    {
        var_3 = 1400;
        var_2 = get_lookahead_target_location( var_3, self._ID31023, 0 );

        if ( !bullettracepassed( var_2, _ID14762( var_2 ), 0, self ) )
            var_2 = get_lookahead_target_location( var_3, self._ID31023, 1 );

        _ID31018( var_2 );
        return;
    }

    return;
}

get_lookahead_target_location( var_0, var_1, var_2 )
{
    if ( !isplayer( var_1 ) )
        return var_1.origin;

    var_3 = _ID14573();

    if ( var_2 && !isdefined( var_1.usingremote ) )
        var_4 = var_1 geteye();
    else
        var_4 = var_1.origin;

    var_5 = distance( self.origin, var_4 );
    var_6 = var_5 / var_0;
    var_7 = var_1 getvelocity();
    return var_4 + var_7 * var_3 * var_6;
}

can_spit_gas_cloud()
{
    if ( !self.gas_cloud_available )
        return 0;

    if ( isdefined( self.enemy ) && isdefined( self.enemy._ID22048 ) && self.enemy._ID22048 )
        return 0;

    var_0 = ( gettime() - level._ID31031 ) * 0.001;
    return level._ID31029 < 3 && var_0 > 3.33;
}

_ID31018( var_0 )
{
    var_1 = _ID14762( var_0 );
    var_2 = magicbullet( "alienspit_mp", var_1, var_0, self );
    var_2.owner = self;

    if ( isdefined( var_2 ) )
    {
        var_2 thread _ID31019( self );
        return;
    }
}

_ID31019( var_0 )
{
    self waittill( "explode",  var_1  );

    if ( !isdefined( var_1 ) )
        return;

    playfx( level._ID1644["spit_AOE_small"], var_1 + ( 0, 0, 8 ), ( 0, 0, 1 ), ( 1, 0, 0 ) );
}

_ID31020( var_0 )
{
    var_1 = _ID14762( var_0 );
    var_2 = magicbullet( "alienspit_gas_mp", var_1, var_0, self );
    var_2.owner = self;

    if ( isdefined( var_2 ) )
        var_2 thread _ID31021( self );

    thread _ID14144();
}

_ID14144()
{
    self endon( "death" );
    self.gas_cloud_available = 0;
    var_0 = randomfloatrange( 10.0, 15.0 );
    wait(var_0);
    self.gas_cloud_available = 1;
}

_ID31021( var_0 )
{
    self waittill( "explode",  var_1  );

    if ( !isdefined( var_1 ) )
        return;

    var_2 = spawn( "trigger_radius", var_1, 0, 150, 128 );

    if ( !isdefined( var_2 ) )
        return;

    level._ID31029++;
    var_2._ID22876 = 1;
    playfx( level._ID1644["spit_AOE"], var_1 + ( 0, 0, 8 ), ( 0, 0, 1 ), ( 1, 0, 0 ) );
    thread _ID31015( var_1, var_2 );
    level notify( "spitter_spit",  var_1  );
    wait 10.0;
    var_2 delete();
    level._ID31029--;
}

_ID31015( var_0, var_1 )
{
    var_1 endon( "death" );
    wait 2.0;

    for (;;)
    {
        var_1 waittill( "trigger",  var_2  );

        if ( !isplayer( var_2 ) )
            continue;

        if ( !isalive( var_2 ) )
            continue;

        _ID10196( var_2 );
        damage_player( var_2, var_1 );
    }
}

damage_player( var_0, var_1 )
{
    var_2 = 0.5;
    var_3 = gettime();

    if ( !isdefined( var_0._ID19497 ) )
        var_4 = var_2;
    else if ( var_0._ID19497 + var_2 * 1000.0 > var_3 )
        return;
    else
        var_4 = min( var_2, ( var_3 - var_0._ID19497 ) * 0.001 );

    var_5 = var_0 maps\mp\alien\_perk_utility::_ID23431();
    var_6 = int( 12.0 * var_4 * var_5 );

    if ( var_6 > 0 )
        var_0 thread [[ level.callbackplayerdamage ]]( var_1, var_1, var_6, 0, "MOD_SUICIDE", "alienspit_gas_mp", var_1.origin, ( 0, 0, 0 ), "none", 0 );

    var_0._ID19497 = var_3;
}

_ID10196( var_0 )
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() && var_0 maps\mp\alien\_perk_utility::_ID23431() == 0 )
    {
        return;
        return;
    }

    if ( !var_0 maps\mp\alien\_perk_utility::_ID16358( "perk_medic", [ 1, 2, 3, 4 ] ) )
    {
        if ( isdefined( level.shell_shock_override ) )
        {
            var_0 [[ level.shell_shock_override ]]( 0.5 );
            return;
        }

        var_0 shellshock( "alien_spitter_gas_cloud", 0.5 );
        return;
        return;
    }

    return;
}

get_rl_toward( var_0 )
{
    var_1 = vectortoangles( var_0.origin - self.origin );
    var_2 = anglestoright( var_1 );

    if ( common_scripts\utility::_ID7657() )
        var_2 *= -1;

    return var_2;
}

_ID31027( var_0 )
{
    self endon( "bad_path" );
    self endon( "death" );
    self endon( "alien_main_loop_restart" );

    for (;;)
    {
        var_1 = find_spitter_attack_node( self.enemy );

        if ( isdefined( var_1 ) )
        {
            _ID21605( var_1 );
            _ID31026( self.enemy );
            continue;
        }

        wait 0.05;
    }
}

_ID25733()
{
    if ( isdefined( self.current_spit_node ) )
    {
        self scragentrelinquishclaimednode( self.current_spit_node );
        self.current_spit_node._ID7314 = 0;
        self.current_spit_node = undefined;
        return;
    }
}

_ID7313( var_0 )
{
    self.current_spit_node = var_0;
    var_0._ID7314 = 1;
    self scragentclaimnode( var_0 );
}

_ID21605( var_0 )
{
    self endon( "player_proximity_during_move" );
    _ID25733();
    _ID7313( var_0 );
    self scragentsetgoalnode( var_0 );
    self scragentsetgoalradius( 64 );
    thread _ID11982();
    self waittill( "goal_reached" );
}

_ID11982()
{
    self endon( "death" );
    self endon( "goal_reached" );
    self endon( "alien_main_loop_restart" );

    for (;;)
    {
        wait 0.05;

        if ( !maps\mp\alien\_unk1464::is_normal_upright( anglestoup( self.angles ) ) )
            continue;

        if ( !maps\mp\agents\alien\_alien_think::_ID20854() )
            continue;

        if ( isdefined( self._ID34835 ) && gettime() < self._ID34835 )
            continue;

        var_0 = _ID12913( 40000.0 );

        if ( isdefined( var_0 ) )
            break;
    }

    _ID25733();
    self notify( "player_proximity_during_move" );
    self scragentsetgoalentity( var_0 );
    self scragentsetgoalradius( 2048.0 );
    self waittill( "goal_reached" );
}

_ID14692( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID14264() == "seeder" )
        var_1 = getnodesinradius( var_0.origin, 768, 128, 512, "jump attack" );
    else
        var_1 = getnodesinradius( var_0.origin, 1000, 300, 512, "jump attack" );

    var_2 = [];

    foreach ( var_4 in var_1 )
    {
        if ( isdefined( var_4._ID7314 ) && var_4._ID7314 )
            continue;

        var_2[var_2.size] = var_4;
    }

    return var_2;
}

_ID18468()
{
    return isdefined( self.pet ) && self.pet;
}

_ID14391()
{
    if ( _ID18468() )
    {
        return level.agentarray;
        return;
    }

    return level.players;
    return;
}

find_spitter_attack_node( var_0 )
{
    var_1 = [];

    if ( is_escape_sequence_active() && isdefined( level._ID12244 ) )
    {
        var_1 = _ID14692( level._ID12244 );

        if ( var_1.size > 0 )
            var_0 = level._ID12244;
    }

    if ( var_1.size == 0 && isdefined( var_0 ) )
        var_1 = _ID14692( var_0 );

    if ( var_1.size == 0 )
    {
        var_2 = _ID14391();

        foreach ( var_4 in var_2 )
        {
            wait 0.05;

            if ( !isalive( var_4 ) )
                continue;

            if ( isdefined( var_0 ) && var_4 == var_0 )
                continue;

            var_1 = _ID14692( var_4 );

            if ( var_1.size > 0 )
            {
                var_0 = var_4;
                break;
            }
        }
    }

    if ( var_1.size == 0 )
        var_1 = _ID14692( self );

    if ( var_1.size == 0 )
        return undefined;

    var_6 = [];

    if ( isdefined( var_0 ) )
    {
        var_6["dist_from_enemy_weight"] = 8.0;
        var_6["enemy_los_weight"] = 6.0;
        var_6["height_weight"] = 4.0;
        var_7 = get_rl_toward( var_0 );
        var_0 endon( "death" );
    }
    else
    {
        var_6["dist_from_enemy_weight"] = 0.0;
        var_6["enemy_los_weight"] = 0.0;
        var_6["height_weight"] = 0.0;
        var_7 = _ID14335();
    }

    var_6["direction"] = "override";
    var_6["direction_override"] = var_7;
    var_6["direction_weight"] = 1.0;
    var_6["min_height"] = 64.0;
    var_6["max_height"] = 400.0;
    var_6["enemy_los"] = 1;
    var_6["min_dist_from_enemy"] = 300.0;
    var_6["max_dist_from_enemy"] = 800.0;
    var_6["desired_dist_from_enemy"] = 600.0;
    var_6["min_dist_from_all_enemies"] = 300.0;
    var_6["min_dist_from_all_enemies_weight"] = 5.0;
    var_6["not_recently_used_weight"] = 10.0;
    var_6["recently_used_time_limit"] = 30.0;
    var_6["random_weight"] = 1.0;
    var_8 = maps\mp\agents\alien\_alien_think::get_retreat_node_rated( var_0, var_6, var_1 );
    return var_8;
}

_ID14335()
{
    var_0 = _ID14391();

    if ( var_0.size == 0 )
        return self.origin + anglestoforward( self.angles ) * 100;

    var_1 = ( 0, 0, 0 );

    foreach ( var_3 in var_0 )
        var_1 += var_3.origin;

    var_1 /= var_0.size;
    return var_1 - self.origin;
}

_ID31026( var_0 )
{
    self endon( "spitter_node_move_requested" );

    if ( !isdefined( self.current_spit_node ) )
    {
        choose_spit_type( "close_range" );
        _ID31022( var_0 );
        self._ID34835 = gettime() + randomfloatrange( 1.5, 3.0 ) * 1000.0;
        return;
    }

    _ID28596();

    if ( !is_escape_sequence_active() )
        wait(randomfloatrange( 1.5, 3.0 ) * 0.5);

    for (;;)
    {
        var_1 = undefined;
        var_2 = 0.0;

        while ( !isdefined( var_1 ) )
        {
            var_2 += 0.2;

            if ( var_2 >= 1.0 )
                return;

            wait 0.2;

            if ( isdefined( var_0 ) && isdefined( var_0.code_classname ) && var_0.code_classname == "script_vehicle" )
            {
                var_1 = var_0;
                continue;
            }

            var_1 = _ID14313( var_0 );
        }

        choose_spit_type( "long_range" );
        _ID31022( var_1 );
        wait(randomfloatrange( 1.5, 3.0 ));
    }
}

choose_spit_type( var_0 )
{
    if ( !_ID18468() && can_spit_gas_cloud() )
    {
        self.spit_type = "gas_cloud";
        return;
    }

    self.spit_type = var_0;
    return;
}

_ID28596()
{
    thread _ID31033( 10 );
    thread _ID31032( 0.1 );

    if ( !_ID18468() )
    {
        thread _ID31034( 90000.0 );
        return;
    }
}

_ID31033( var_0 )
{
    self endon( "spitter_node_move_requested" );
    self endon( "death" );
    self endon( "alien_main_loop_restart" );
    wait(var_0);
    self notify( "spitter_node_move_requested" );
}

_ID31032( var_0 )
{
    self endon( "spitter_node_move_requested" );
    self endon( "death" );
    self endon( "alien_main_loop_restart" );
    self waittill( "damage" );
    wait(var_0);
    self notify( "spitter_node_move_requested" );
}

_ID31034( var_0 )
{
    self endon( "spitter_node_move_requested" );
    self endon( "death" );
    self endon( "alien_main_loop_restart" );

    for (;;)
    {
        var_1 = _ID12913( var_0 );

        if ( isdefined( var_1 ) )
            break;

        wait 0.2;
    }

    self notify( "spitter_node_move_requested" );
}

_ID12913( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( !isalive( var_2 ) )
            continue;

        var_3 = distance2dsquared( self.origin, var_2.origin );

        if ( var_3 < var_0 )
            return var_2;
    }

    return undefined;
}
