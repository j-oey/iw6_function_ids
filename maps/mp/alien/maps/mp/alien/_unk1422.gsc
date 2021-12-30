// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17697()
{
    var_0 = getdvar( "ui_mapname" );
    level.alien_challenge_table = "mp/alien/" + var_0 + "_challenges.csv";

    if ( maps\mp\alien\_unk1464::_ID18426() )
    {
        level.alien_challenge_table = "mp/alien/" + var_0 + "_hardcore_challenges.csv";

        if ( !tableexists( level.alien_challenge_table ) )
            level.alien_challenge_table = "mp/alien/" + var_0 + "_challenges.csv";
    }

    maps\mp\alien\_challenge_function::init_challenge_type();
}

_ID30613()
{
    if ( !maps\mp\alien\_unk1464::alien_mode_has( "challenge" ) )
        return;

    level.current_challenge_index = undefined;
    level thread _ID30614();
}

_ID30614()
{
    var_0 = get_valid_challenge();

    if ( !isdefined( var_0 ) )
        return;

    activate_new_challenge( var_0 );
}

_ID34406( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !current_challenge_is( var_0 ) || !maps\mp\alien\_unk1464::alien_mode_has( "challenge" ) )
        return;

    if ( level.pre_challenge_active )
        return;

    var_10 = level._ID6847[level.current_challenge];
    var_10 [[ var_10._ID34541 ]]( var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

_ID11538()
{
    if ( current_challenge_exist() && maps\mp\alien\_unk1464::alien_mode_has( "challenge" ) )
        deactivate_current_challenge();
}

remove_all_challenge_cases()
{
    level notify( "remove_all_challenge_case" );
}

get_valid_challenge()
{
    var_0 = [];

    foreach ( var_2 in level._ID6847 )
    {
        if ( isdefined( var_2.already_issued ) )
            continue;

        if ( level.players.size == 1 && !maps\mp\alien\_unk1464::_ID18506( var_2.allowedinsolo ) )
            continue;

        if ( !isdefined( var_2.allowed_cycles ) )
            continue;

        var_3 = strtok( var_2.allowed_cycles, " " );

        foreach ( var_5 in var_3 )
        {
            if ( level.cycle_count - 1 == int( var_5 ) )
            {
                var_6 = maps\mp\alien\_spawn_director::_ID37269();

                if ( !isdefined( var_6 ) )
                    continue;

                if ( should_skip_challenge( var_2 ) )
                    continue;

                var_7 = strtok( var_2._ID2978, " " );

                foreach ( var_9 in var_7 )
                {
                    if ( var_9 == var_6 )
                    {
                        var_0[var_0.size] = var_2;
                        break;
                    }
                }

                break;
            }
        }
    }

    if ( var_0.size > 0 )
    {
        var_13 = var_0[randomint( var_0.size )];
        var_13.already_issued = 1;
        return var_13._ID25633;
    }

    return undefined;
}

should_skip_challenge( var_0 )
{
    var_1 = var_0._ID25633 == "ar_only" || var_0._ID25633 == "smg_only" || var_0._ID25633 == "lmgs_only" || var_0._ID25633 == "shotguns_only" || var_0._ID25633 == "2_weapons_only" || var_0._ID25633 == "semi_autos_only" || var_0._ID25633 == "new_weapon" || var_0._ID25633 == "snipers_only";

    if ( !var_1 )
        return 0;

    var_2 = 0;

    foreach ( var_4 in level.players )
    {
        if ( var_4 maps\mp\alien\_prestige::prestige_getpistolsonly() == 1 )
            var_2++;
    }

    if ( var_0._ID25633 == "new_weapon" && var_2 > 0 )
        return 1;

    if ( var_2 >= level.players.size - 1 )
        return 1;
    else
        return 0;
}

deactivate_current_challenge()
{
    if ( !current_challenge_exist() )
        return;

    var_0 = level._ID6847[level.current_challenge];
    _ID34258();

    if ( var_0 [[ var_0._ID18803 ]]() )
    {
        _ID10203( "challenge_success", 0 );
        var_0 [[ var_0._ID26270 ]]();
        maps\mp\alien\_unk1443::_ID38219( maps\mp\alien\_unk1443::get_challenge_score_component_name(), "challenge_complete" );
        maps\mp\alien\_persistence::update_lb_aliensession_challenge( 1 );
        _ID36632::_ID38198( var_0._ID25633, 1 );
        level.num_challenge_completed++;

        if ( !maps\mp\alien\_unk1464::is_casual_mode() )
        {
            if ( level.num_challenge_completed == 10 )
            {
                foreach ( var_2 in level.players )
                    var_2 maps\mp\alien\_persistence::give_player_tokens( 2, 1 );
            }
        }
    }
    else
    {
        _ID10203( "challenge_failed", 0 );
        var_0 [[ var_0._ID12643 ]]();
        level.all_challenge_completed = 0;
        maps\mp\alien\_persistence::update_lb_aliensession_challenge( 0 );
        _ID36632::_ID38198( var_0._ID25633, 0 );
    }

    var_0 [[ var_0._ID9025 ]]();
}

activate_new_challenge( var_0 )
{
    var_1 = level._ID6847[var_0];

    if ( var_1 [[ var_1.canactivatefunc ]]() )
    {
        var_2 = maps\mp\alien\_challenge_function::get_challenge_scalar( var_0 );

        if ( isdefined( var_2 ) )
        {
            level._ID6847[var_0].goal = var_2;
            level.current_challenge_scalar = var_2;
        }
        else
            level.current_challenge_scalar = -1;

        _ID10203( var_0, 1, var_2 );
        _ID28269( var_0 );
        level.pre_challenge_active = 1;
        challenge_countdown();
        level.pre_challenge_active = 0;

        foreach ( var_4 in level.players )
            var_4 setclientomnvar( "ui_intel_prechallenge", 0 );

        level.current_challenge_pre_challenge = 0;
        var_1 [[ var_1.activatefunc ]]();
    }
    else
        var_1 [[ var_1.failactivatefunc ]]();
}

challenge_countdown()
{
    level endon( "game_ended" );
    var_0 = int( gettime() + 5000 );

    foreach ( var_2 in level.players )
    {
        var_2 setclientomnvar( "ui_intel_timer", var_0 );
        var_2 setclientomnvar( "ui_intel_title", 1 );
    }

    level.current_challenge_title = 1;
    wait 5;

    foreach ( var_2 in level.players )
    {
        var_2 setclientomnvar( "ui_intel_timer", -1 );
        var_2 setclientomnvar( "ui_intel_title", -1 );
    }

    level.current_challenge_title = -1;
    wait 0.5;
}

_ID6533( var_0 )
{
    if ( !isplayer( var_0 ) )
        return 0;

    if ( isai( var_0 ) )
        return 0;

    if ( !isalive( var_0 ) || isdefined( var_0.fauxdead ) && var_0.fauxdead )
        return 0;

    return 1;
}

_ID10203( var_0, var_1, var_2 )
{
    var_3 = tablelookup( level.alien_challenge_table, 1, var_0, 0 );

    foreach ( var_5 in level.players )
    {
        if ( var_1 )
        {
            if ( isdefined( var_2 ) )
                var_5 setclientomnvar( "ui_intel_challenge_scalar", var_2 );
            else
                var_5 setclientomnvar( "ui_intel_challenge_scalar", -1 );

            var_5 setclientomnvar( "ui_intel_prechallenge", 1 );
            var_5 setclientomnvar( "ui_intel_active_index", int( var_3 ) );
            level.current_challenge_index = int( var_3 );
            level.current_challenge_pre_challenge = 1;
            var_5 playlocalsound( "mp_intel_received" );
            continue;
        }

        var_5 setclientomnvar( "ui_intel_active_index", -1 );
        var_5 setclientomnvar( "ui_intel_progress_current", -1 );
        var_5 setclientomnvar( "ui_intel_progress_max", -1 );
        var_5 setclientomnvar( "ui_intel_percent", -1 );
        var_5 setclientomnvar( "ui_intel_target_player", -1 );
        var_5 setclientomnvar( "ui_intel_prechallenge", 0 );
        var_5 setclientomnvar( "ui_intel_timer", -1 );
        var_5 setclientomnvar( "ui_intel_challenge_scalar", -1 );
        level.current_challenge_index = -1;
        level.current_challenge_progress_max = -1;
        level.current_challenge_progress_current = -1;
        level.current_challenge_percent = -1;
        level.current_challenge_target_player = -1;
        level._ID8632 = -1;
        level.current_challenge_scalar = -1;
        level.current_challenge_pre_challenge = 0;
    }

    if ( var_1 )
        return;

    level thread show_challenge_outcome( var_0, var_3 );
}

show_challenge_outcome( var_0, var_1 )
{
    level endon( "game_ended" );
    wait 1;

    foreach ( var_3 in level.players )
    {
        if ( var_0 == "challenge_failed" )
        {
            var_3 setclientomnvar( "ui_intel_active_index", int( var_1 ) );
            var_3 playlocalsound( "mp_intel_fail" );
            continue;
        }

        var_3 setclientomnvar( "ui_intel_active_index", int( var_1 ) );
        var_3 playlocalsound( "mp_intel_success" );
    }

    wait 4;

    foreach ( var_3 in level.players )
        var_3 setclientomnvar( "ui_intel_active_index", -1 );
}

current_challenge_exist()
{
    return isdefined( level.current_challenge );
}

current_challenge_is( var_0 )
{
    return current_challenge_exist() && level.current_challenge == var_0;
}

_ID34258()
{
    level.current_challenge = undefined;
}

_ID28269( var_0 )
{
    level.current_challenge = var_0;
}

_ID16049()
{
    self endon( "disconnect" );
    self setclientomnvar( "ui_intel_prechallenge", level.current_challenge_pre_challenge );

    if ( current_challenge_exist() )
    {
        self setclientomnvar( "ui_intel_active_index", int( level.current_challenge_index ) );
        self setclientomnvar( "ui_intel_progress_current", int( level.current_challenge_progress_current ) );
        self setclientomnvar( "ui_intel_progress_max", int( level.current_challenge_progress_max ) );
        self setclientomnvar( "ui_intel_percent", int( level.current_challenge_percent ) );
        self setclientomnvar( "ui_intel_target_player", int( level.current_challenge_target_player ) );
        self setclientomnvar( "ui_intel_title", int( level.current_challenge_title ) );

        if ( level._ID8632 > 0 )
            self setclientomnvar( "ui_intel_timer", int( gettime() + level._ID8632 * 1000 ) );

        self setclientomnvar( "ui_intel_challenge_scalar", level.current_challenge_scalar );
    }

    if ( level.current_challenge == "50_percent_accuracy" || level.current_challenge == "75_percent_accuracy" )
    {
        var_0 = level._ID6847[level.current_challenge];
        thread maps\mp\alien\_challenge_function::_ID33277( var_0 );
    }
    else if ( level.current_challenge == "no_reloads" )
        thread maps\mp\alien\_challenge_function::_ID35476();
    else if ( level.current_challenge == "no_abilities" )
        thread maps\mp\alien\_challenge_function::wait_for_ability_use();

    if ( isdefined( level.current_drill_health ) )
        setomnvar( "ui_alien_drill_health_text", int( level.current_drill_health ) );

    if ( isdefined( level.current_drill_time ) )
        setomnvar( "ui_alien_drill_end_milliseconds", int( level.current_drill_time ) );
}

get_num_challenge_completed()
{
    if ( !isdefined( level.num_challenge_completed ) )
        return 0;
    else
        return level.num_challenge_completed;
}
