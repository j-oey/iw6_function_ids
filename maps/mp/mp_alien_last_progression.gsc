// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

nonlinear_progression_init()
{
    level.num_conduit_completed = 0;
    level.num_transition_completed = 0;
    level.allow_backtrack_encounters = 1;
    level.force_blocker_order = 0;
    level.drill_detonate_override = ::encounter_complete;
    level._ID37430 = ::last_hotjoin_skill_points;
    level._ID36752 = 1;
    common_scripts\utility::_ID13189( "drill_detonated" );
    common_scripts\utility::_ID13189( "drill_destroyed" );
    common_scripts\utility::_ID13189( "drill_drilling" );
    level.drill_health_hardcore = 1250;

    if ( maps\mp\alien\_unk1464::_ID18745() )
        level.drill_health_hardcore = 2000;

    level.gas_station_conduits_completed = 0;
    level.parking_conduits_completed = 0;
    level.rooftop_conduits_completed = 0;
    level.skill_points_earned_from_progression = 0;
}

init_fake_drill()
{
    common_scripts\utility::_ID13189( "drill_detonated" );
    common_scripts\utility::_ID13189( "drill_destroyed" );
    common_scripts\utility::_ID13189( "drill_drilling" );
    level._ID10910 = 0;
    level._ID10913 = 1;
    level.drill = undefined;
    level.drill_carrier = undefined;
    maps\mp\alien\_drill::init_fx();
    maps\mp\alien\_drill::init_drill_drop_loc();
    thread maps\mp\alien\_drill::drill_threat_think();
}

register_nonlinear_outpost( var_0, var_1 )
{
    var_2 = common_scripts\utility::_ID15384( "outpost_" + var_0, "targetname" );

    if ( !isdefined( var_2 ) )
        return;

    var_2.name = var_0;
    var_2.opened = common_scripts\utility::_ID32831( isdefined( var_1 ), var_1, 0 );
    var_2.outpost_encounters = [];
    var_3 = common_scripts\utility::_ID15386( var_2.target, "targetname" );

    foreach ( var_5 in var_3 )
    {
        if ( isdefined( var_5._ID27766 ) )
        {
            if ( var_5._ID27766 == "outpost_transition" )
                level setup_transition_encounter( var_5 );
            else if ( var_5._ID27766 == "outpost_conduit" )
                level setup_conduit_encounter( var_5 );
        }

        var_2.outpost_encounters[var_5.name] = var_5;
    }

    if ( !isdefined( level.outposts ) )
        level.outposts = [];

    level.outposts[var_0] = var_2;
}

register_nonlinear_transition( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( !isdefined( level.outposts[var_0] ) )
    {

    }

    if ( !isdefined( level.outposts[var_0].outpost_encounters[var_1] ) )
    {

    }

    var_8 = level.outposts[var_0].outpost_encounters[var_1];
    var_8.name = var_1;
    var_8._ID38037 = var_2;
    var_8._ID37412 = var_3;
    var_8.outpost_name = var_0;
    var_8.opener_func = var_4;
    var_8.open_delta = var_5;
    var_8.close_delta = var_6;
    var_8.connected_outpost = var_7;
    var_8._ID37225 = ::force_end_transition;
    var_8.type = "transition";
}

register_nonlinear_conduit( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isdefined( level.outposts[var_0] ) )
    {

    }

    if ( !isdefined( level.outposts[var_0].outpost_encounters[var_1] ) )
    {

    }

    var_9 = level.outposts[var_0].outpost_encounters[var_1];
    var_9.name = var_1;
    var_9.outpost_name = var_0;
    var_9.cycle_count = var_2;
    var_9.med_cycle = var_3;
    var_9.hard_cycle = var_4;
    var_9._ID38037 = var_5;
    var_9._ID37412 = var_6;
    var_9.encounter_func = var_7;
    var_9.blocker = common_scripts\utility::_ID32831( isdefined( var_8 ), var_8, 0 );
    var_9._ID37225 = ::force_end_conduit;
    var_9.type = "conduit";
}

run_non_linear_encounters()
{
    level endon( "game_ended" );
    level endon( "start_cross_vignette" );
    level.cycle_count = 1;
    level.current_area_name = "main_base";

    if ( !handle_non_linear_jump_to_start() )
        return;

    level waittill( "enable_encounters" );

    for (;;)
    {
        var_0 = level.outposts[level.current_area_name];

        if ( !isdefined( var_0 ) )
            return;

        foreach ( var_2 in var_0.outpost_encounters )
            level thread outpost_encounter_enable( var_2 );

        if ( level.allow_backtrack_encounters )
        {
            foreach ( var_5 in level.outposts )
            {
                if ( var_5.name != level.current_area_name && var_5.opened )
                {
                    foreach ( var_2 in var_5.outpost_encounters )
                        level thread outpost_encounter_enable( var_2 );
                }
            }
        }

        level waittill( "outpost_encounter_started" );
        common_scripts\utility::flag_set( "outpost_encounter_running" );
        level waittill( "outpost_encounter_completed" );
        common_scripts\utility::_ID13180( "outpost_encounter_running" );
        wait 5.0;

        if ( common_scripts\utility::_ID13177( "start_cross_vignette" ) )
            return;
    }
}

outpost_encounter_enable( var_0 )
{
    level endon( "outpost_encounter_started" );
    level endon( "start_cross_vignette" );

    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_0.use_trigger ) )
        return;

    if ( isdefined( var_0.use_trigger.marked_for_delete ) || isdefined( var_0.completed ) )
        return;

    if ( level.force_blocker_order && var_0.type == "conduit" && var_0.blocker )
    {
        var_1 = level.outposts[var_0.outpost_name].outpost_encounters;

        foreach ( var_3 in var_1 )
        {
            if ( var_3.name != var_0.name && var_3.type == "conduit" )
                return;
        }
    }

    level thread encounter_outline_icon_hinttext( var_0 );
    var_0.use_trigger makeusable();
    var_0.use_trigger waittill( "trigger",  var_5  );

    if ( var_0.type == "conduit" && !level.force_blocker_order )
        var_0 = update_conduit_struct_any_order( var_0 );

    level thread [[ var_0.encounter_start_func ]]( var_0, var_5 );
    level notify( "outpost_encounter_started" );
}

encounter_outline_icon_hinttext( var_0 )
{
    if ( isdefined( var_0.completed ) )
        return;

    var_1 = "waypoint_alien_conduit";

    if ( var_0.type == "transition" )
        var_1 = "waypoint_alien_gate";

    var_0.use_trigger thread _ID36640::_ID28422( var_1, 1300 );
    var_0.use_trigger setcursorhint( "HINT_NOICON" );
    var_0.use_trigger common_scripts\utility::_ID33659();

    if ( var_0.type == "transition" )
        var_0.use_trigger sethintstring( &"MP_ALIEN_LAST_TRANSITION_OPEN_HINT" );
    else
        var_0.use_trigger sethintstring( &"MP_ALIEN_LAST_CONDUIT_START_HINT" );

    var_2 = undefined;
    var_3 = undefined;

    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
    {
        if ( var_0.type == "transition" )
        {
            var_2 = var_0.gate_models[0];

            if ( isdefined( var_0.gate_model_double ) )
            {
                var_3 = var_0.gate_model_double;
                maps\mp\alien\_outline_proto::add_to_outline_hive_watch_list( var_0.gate_model_double );
            }
        }
        else
            var_2 = var_0.conduit;

        maps\mp\alien\_outline_proto::add_to_outline_hive_watch_list( var_2 );
    }

    level common_scripts\utility::_ID35626( "outpost_encounter_started", "game_ended", "start_cross_vignette" );
    var_0.use_trigger notify( "stop_listening" );
    var_0.use_trigger _ID36640::destroy_hive_icon();
    var_0.use_trigger sethintstring( "" );
    var_0.use_trigger common_scripts\utility::_ID33657();

    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) && isdefined( var_2 ) )
    {
        maps\mp\alien\_outline_proto::_ID25900( var_2 );

        if ( isdefined( var_3 ) )
            maps\mp\alien\_outline_proto::_ID25900( var_3 );
    }
}

encounter_complete()
{
    var_0 = level._ID37046;

    if ( var_0.type == "transition" )
        thread transition_encounter_complete();
    else
        thread conduit_encounter_complete();

    level thread maps\mp\mp_alien_last::remove_conduit_vo_once_complete();
}

setup_conduit_encounter( var_0 )
{
    if ( !isdefined( var_0.script_noteworthy ) )
        return;

    var_0.name = var_0.script_noteworthy;
    var_0.encounter_start_func = ::run_conduit_encounter;
    var_1 = getentarray( var_0.target, "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3._ID27766 ) )
        {
            if ( var_3._ID27766 == "conduit" )
            {
                var_0.conduit = var_3;
                continue;
            }

            if ( var_3._ID27766 == "use_trigger" )
                var_0.use_trigger = var_3;
        }
    }

    var_5 = getent( var_0.name + "_scriptable", "targetname" );
    var_0.conduit.scriptable = var_5;
}

run_conduit_encounter( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    level.encounter_type = "conduit";
    level._ID37046 = var_0;
    var_1 maps\mp\alien\_persistence::eog_player_update_stat( "drillplants", 1 );
    level._ID37166 = var_0.name;
    level.current_hive_name = var_0.name;
    level.current_area_name = var_0.outpost_name;
    level notify( "drill_planted",  var_1, var_0  );
    var_2 = 0.4;
    var_3 = 1.75;
    thread _ID36640::_ID35886( var_3, var_2 );

    if ( isdefined( var_0.encounter_func ) )
        level thread [[ var_0.encounter_func ]]( var_0 );

    level thread set_area_index_for_encounter( var_0.name );
    maps\mp\_utility::_ID9519( 2, maps\mp\alien\_unk1422::_ID30613 );
    level thread conduit_running( var_0, var_0.conduit, var_1 );
    maps\mp\alien\_gamescore_last::update_generator_score_component_name();
    maps\mp\alien\_unk1443::_ID37894();
    var_4 = level.cycle_count;

    if ( level.num_conduit_completed < 2 )
        level.cycle_count = var_0.cycle_count;
    else if ( level.num_conduit_completed < 4 )
        level.cycle_count = var_0.med_cycle;
    else
        level.cycle_count = var_0.hard_cycle;

    maps\mp\alien\_spawn_director::_ID31265( level.cycle_count );
    level.cycle_count = level.cycle_count + 1;
    common_scripts\utility::flag_wait( "drill_detonated" );
    common_scripts\utility::_ID13180( "drill_drilling" );
    level.drill._ID18318 = 0;
    maps\mp\alien\_spawn_director::_ID11539();
    var_0.completed = 1;
    level.cycle_count = var_4;
    var_0.conduit thread maps\mp\alien\_drill::_ID10903();
    level thread maps\mp\alien\_spawnlogic::remaining_alien_management();
    maps\mp\alien\_unk1422::_ID11538();
    maps\mp\alien\_unk1422::remove_all_challenge_cases();
    maps\mp\alien\_unk1443::_ID36926( level.players, get_conduit_score_component_name_list() );
    setomnvar( "ui_alien_drill_state", 0 );

    if ( isdefined( var_0._ID27345 ) )
        var_0._ID27345 notify( "trigger",  level.players[0]  );

    increment_conduit_progress();
    give_players_rewards( var_0 );
    level._ID37046 = undefined;
    level.encounter_type = undefined;
    level notify( "outpost_encounter_completed" );
    common_scripts\utility::_ID13180( "outpost_encounter_running" );
}

conduit_running( var_0, var_1, var_2 )
{
    var_1 endon( "stop_listening" );
    var_1 endon( "drill_complete" );
    level.drill = var_1;
    level.drill.state = "planted";
    level.drill endon( "death" );
    level.drill.owner = var_2;
    level.drill._ID31985 = var_1;
    level.drill._ID33077 = 0;
    level.drill._ID31409 = gettime();
    level.drill.hive_is_really_a_door = 0;
    var_1.scriptables = [];
    var_1._ID25962 = [];
    var_1._ID13828 = [];
    var_3 = level.drill_health_hardcore;
    level.drill.maxhealth = 20000 + var_3;
    level.drill.health = int( 20000 + var_3 * level.drill.owner maps\mp\alien\_perk_utility::perk_getdrillhealthscalar() );
    level.drill thread maps\mp\alien\_drill::_ID36026( level.drill );
    level.drill thread maps\mp\alien\_drill::_ID35943();
    level.drill thread watch_drill_health_for_fx();

    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
        maps\mp\alien\_outline_proto::_ID2259( level.drill, 0 );

    var_1 playsound( "alien_conduit_on" );
    level notify( "dlc_vo_notify",  "last_vo", "conduit_start"  );
    thread maps\mp\alien\_drill::_ID9765();
    common_scripts\utility::flag_set( "drill_drilling" );
    wait 2;
    var_1 thread _ID17727( var_0 );
    var_1 thread set_conduit_state_run( var_2 );
    _ID36640::_ID17038();
    level.drill waittill( "offline",  var_4, var_5  );
    var_1 thread set_conduit_state_offline();
    wait 2;
    maps\mp\gametypes\aliens::alienendgame( "axis", maps\mp\alien\_hud::_ID14441( "generator_destroyed" ) );
}

set_conduit_state_run( var_0 )
{
    self endon( "death" );
    self endon( "stop_listening" );
    level.drill.state = "online";
    level.drill notify( "online" );
    level.drill setcandamage( 1 );
    level.drill makeunusable();
    level.drill sethintstring( "" );
    var_1 = level.drill_health_hardcore;
    level.drill.maxhealth = 20000 + var_1;
    level.drill.health = int( 20000 + var_1 * level.drill.owner maps\mp\alien\_perk_utility::perk_getdrillhealthscalar() );
    level.drill.threatbias = -3000;
    level.drill makeentitysentient( "allies" );
    level.drill setthreatbiasgroup( "drill" );
    maps\mp\alien\_drill::update_drill_health_hud();

    foreach ( var_3 in level.agentarray )
    {
        if ( isdefined( var_3._ID36227 ) && var_3._ID36227 )
            var_3 getenemyinfo( level.drill );
    }

    thread sfx_conduit_on();
    thread conduit_fx_warm_up();
    thread maps\mp\alien\_drill::_ID16044();
    self.depth_marker = gettime();
    thread maps\mp\alien\_drill::monitor_drill_complete( self.depth );
    thread _ID36640::_ID17034();
    thread _ID36640::_ID28422( "waypoint_alien_defend" );
    thread offset_conduit_icon();
    thread maps\mp\alien\_drill::_ID9765();
    thread maps\mp\alien\_hud::turn_on_drill_meter_hud( self.depth );

    if ( level.encounter_type == "conduit" )
        level thread maps\mp\alien\_drill::_ID35941( self.depth );
}

offset_conduit_icon()
{
    level endon( "drill_detonated" );
    level endon( "game_ended" );

    while ( !isdefined( self._ID17321 ) )
        wait 0.1;

    self._ID17321.z = self._ID17321.z + 70;
}

conduit_fx_warm_up()
{
    level.drill.scriptable setscriptablepartstate( "base", "warm_up" );
}

conduit_fx_on()
{
    level.drill.scriptable setscriptablepartstate( "base", "on" );
}

conduit_fx_damaged()
{
    level.drill.scriptable setscriptablepartstate( "base", "damaged" );
}

conduit_encounter_complete()
{
    _ID36640::destroy_hive_icon();
    self makeunusable();
    self sethintstring( "" );

    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
        maps\mp\alien\_outline_proto::_ID25899( self );

    thread sfx_conduit_off();
    thread conduit_fx_on();

    if ( isdefined( level.drill ) )
        level.drill.ignoreme = 1;

    level.num_conduit_completed++;
    common_scripts\utility::_ID13180( "drill_detonated" );
    wait 4;
    level thread maps\mp\mp_alien_last::play_conduit_encounter_complete_vo();
}

set_conduit_state_offline()
{
    self endon( "death" );
    self endon( "stop_listening" );
    self.state = "offline";
    thread sfx_conduit_offline();
    var_0 = ( gettime() - self.depth_marker ) / 1000;
    self.depth = max( 0, self.depth - var_0 );
    wait 1.0;
    self setcandamage( 0 );
    self freeentitysentient();
    _ID36640::destroy_hive_icon();
    setomnvar( "ui_alien_drill_state", 2 );
}

force_end_conduit()
{
    if ( !common_scripts\utility::_ID13177( "drill_drilling" ) )
        common_scripts\utility::_ID35637( 4, "drill_drilling" );

    var_0 = level._ID37046.conduit;
    var_0._ID19720 = [];
    var_0 notify( "force_drill_complete" );
    wait 1.0;
}

update_conduit_struct_any_order( var_0 )
{
    var_0 = level.outposts[var_0.outpost_name].outpost_encounters[var_0.name];

    if ( var_0.name == "conduit_gas_station_2" && level.gas_station_conduits_completed == 0 )
        swap_conduit_cycles_and_encounter( "gas_station", "conduit_gas_station_1", "conduit_gas_station_2" );
    else if ( var_0.name == "conduit_parking_2" && level.parking_conduits_completed == 0 )
        swap_conduit_cycles_and_encounter( "parking", "conduit_parking_1", "conduit_parking_2" );
    else if ( var_0.name == "conduit_rooftop_2" && level.rooftop_conduits_completed == 0 )
        swap_conduit_cycles_and_encounter( "rooftop", "conduit_rooftop_1", "conduit_rooftop_2" );

    return var_0;
}

swap_conduit_cycles_and_encounter( var_0, var_1, var_2 )
{
    var_3 = level.outposts[var_0].outpost_encounters[var_2].cycle_count;
    var_4 = level.outposts[var_0].outpost_encounters[var_2].med_cycle;
    var_5 = level.outposts[var_0].outpost_encounters[var_2].hard_cycle;
    var_6 = level.outposts[var_0].outpost_encounters[var_2].encounter_func;
    var_7 = level.outposts[var_0].outpost_encounters[var_2].blocker;
    level.outposts[var_0].outpost_encounters[var_2].cycle_count = level.outposts[var_0].outpost_encounters[var_1].cycle_count;
    level.outposts[var_0].outpost_encounters[var_2].med_cycle = level.outposts[var_0].outpost_encounters[var_1].med_cycle;
    level.outposts[var_0].outpost_encounters[var_2].hard_cycle = level.outposts[var_0].outpost_encounters[var_1].hard_cycle;
    level.outposts[var_0].outpost_encounters[var_2].encounter_func = level.outposts[var_0].outpost_encounters[var_1].encounter_func;
    level.outposts[var_0].outpost_encounters[var_2].blocker = level.outposts[var_0].outpost_encounters[var_1].blocker;
    level.outposts[var_0].outpost_encounters[var_1].cycle_count = var_3;
    level.outposts[var_0].outpost_encounters[var_1].med_cycle = var_4;
    level.outposts[var_0].outpost_encounters[var_1].hard_cycle = var_5;
    level.outposts[var_0].outpost_encounters[var_1].encounter_func = var_6;
    level.outposts[var_0].outpost_encounters[var_1].blocker = var_7;
}

increment_conduit_progress()
{
    level.num_hive_destroyed++;

    foreach ( var_1 in level.players )
        var_1 maps\mp\alien\_persistence::eog_player_update_stat( "hivesdestroyed", 1 );
}

watch_drill_health_for_fx()
{
    self endon( "drill_complete" );
    self endon( "death" );
    var_0 = 0;

    for (;;)
    {
        var_1 = ( level.drill.health - 20000 ) / level.drill_health_hardcore;

        if ( var_1 <= 0.75 && !var_0 )
        {
            var_0 = 1;
            conduit_fx_damaged();
        }
        else if ( var_1 > 0.75 && var_0 )
        {
            var_0 = 0;
            conduit_fx_warm_up();
        }

        wait 1;
    }
}

sfx_conduit_on()
{
    wait 0.1;
    var_0 = level.drill;
    level.drill_sfx_lp = spawn( "script_origin", var_0.origin );
    level.drill_sfx_lp linkto( var_0 );

    if ( !isdefined( level.drill_sfx_dist_lp ) )
    {
        level.drill_sfx_dist_lp = spawn( "script_origin", var_0.origin );
        level.drill_sfx_dist_lp linkto( var_0 );
    }

    wait 0.1;

    if ( isdefined( level.drill_sfx_lp ) )
        level.drill_sfx_lp playloopsound( "alien_conduit_on_lp" );
}

sfx_conduit_off()
{
    var_0 = level.drill;
    var_0 playsound( "alien_conduit_powered_up" );

    if ( isdefined( level.drill_sfx_lp ) )
    {
        level.drill_sfx_lp stoploopsound( "alien_conduit_on_lp" );
        level.drill_sfx_lp playloopsound( "alien_conduit_powered_lp" );
    }

    if ( isdefined( level.drill_sfx_dist_lp ) )
        level.drill_sfx_dist_lp delete();

    if ( isdefined( level.drill_overheat_lp ) )
        level.drill_overheat_lp delete();

    if ( isdefined( level.drill_overheat_lp_02 ) )
        level.drill_overheat_lp_02 delete();
}

sfx_conduit_offline()
{
    var_0 = level.drill;

    if ( isdefined( level.drill_sfx_lp ) )
        level.drill_sfx_lp delete();

    if ( isdefined( level.drill_sfx_dist_lp ) )
        level.drill_sfx_dist_lp delete();

    if ( isdefined( level.drill_overheat_lp_02 ) )
        level.drill_overheat_lp_02 delete();
}

setup_transition_encounter( var_0 )
{
    if ( !isdefined( var_0.script_noteworthy ) )
        return;

    var_0.name = var_0.script_noteworthy;
    var_0.encounter_start_func = ::run_transition_encounter;
    var_0.gate_models = [];
    var_0.gate_clip = undefined;
    var_0.gate_pivot = undefined;
    var_0.gate_model_double = undefined;
    var_0.gate_clip_double = undefined;
    var_0.gate_pivot_double = undefined;
    var_1 = getentarray( var_0.target, "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3._ID27766 ) )
        {
            if ( var_3._ID27766 == "use_trigger" )
            {
                var_0.use_trigger = var_3;
                continue;
            }

            if ( var_3._ID27766 == "outpost_gate_model" )
            {
                var_0.gate_models[var_0.gate_models.size] = var_3;
                continue;
            }

            if ( var_3._ID27766 == "outpost_gate_clip" )
            {
                var_0.gate_clip = var_3;
                continue;
            }

            if ( var_3._ID27766 == "outpost_gate_pivot" )
            {
                var_0.gate_pivot = var_3;
                continue;
            }

            if ( var_3._ID27766 == "objective_marker" )
            {
                var_0.objective_marker = var_3;
                continue;
            }

            if ( var_3._ID27766 == "outpost_gate_model_double" )
            {
                var_0.gate_model_double = var_3;
                continue;
            }

            if ( var_3._ID27766 == "outpost_gate_clip_double" )
            {
                var_0.gate_clip_double = var_3;
                continue;
            }

            if ( var_3._ID27766 == "outpost_gate_pivot_double" )
                var_0.gate_pivot_double = var_3;
        }
    }

    if ( isdefined( var_0.gate_pivot ) && isdefined( var_0.gate_clip ) )
        var_0.gate_clip linkto( var_0.gate_pivot );

    if ( isdefined( var_0.gate_pivot ) )
    {
        foreach ( var_6 in var_0.gate_models )
            var_6 linkto( var_0.gate_pivot );
    }

    if ( isdefined( var_0.gate_pivot_double ) && isdefined( var_0.gate_clip_double ) )
        var_0.gate_clip_double linkto( var_0.gate_pivot_double );

    if ( isdefined( var_0.gate_pivot_double ) )
        var_0.gate_model_double linkto( var_0.gate_pivot_double );
}

run_transition_encounter( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    level.encounter_type = "transition";
    level._ID37046 = var_0;
    level notify( "dlc_vo_notify",  "transition_start"  );
    [[ var_0.opener_func ]]( var_0, 0 );
    var_1 maps\mp\alien\_persistence::eog_player_update_stat( "drillplants", 1 );
    level._ID37166 = var_0.name;
    level.current_hive_name = var_0.name;
    level.current_area_name = var_0.outpost_name;
    level notify( "drill_planted",  var_1, var_0  );
    var_2 = 0.4;
    var_3 = 1.75;
    thread _ID36640::_ID35886( var_3, var_2 );

    if ( level.cycle_count == 1 )
        level maps\mp\_utility::_ID9519( 1, maps\mp\alien\_music_and_dialog::playvoforwavestart );

    level thread set_area_index_for_encounter( var_0.name );
    maps\mp\_utility::_ID9519( 2, maps\mp\alien\_unk1422::_ID30613 );
    level thread transition_running( var_0, var_0.use_trigger, var_1 );
    maps\mp\alien\_gamescore_last::update_street_score_component_name();
    maps\mp\alien\_unk1443::_ID37894();
    maps\mp\alien\_spawn_director::_ID31265( level.cycle_count );
    level.cycle_count++;
    var_4 = level.cycle_data._ID8865[level.cycle_count - 1];
    setomnvar( "ui_alien_nuke_timer", gettime() + var_4[0] * 1000 );
    thread show_transition_objective( var_0, var_4[0] - 15 );
    common_scripts\utility::flag_wait( "drill_detonated" );
    common_scripts\utility::_ID13180( "drill_drilling" );
    maps\mp\alien\_spawn_director::_ID11539();
    var_0.completed = 1;
    var_0.use_trigger thread maps\mp\alien\_drill::_ID10903();
    level thread maps\mp\alien\_unk1422::_ID11538();
    level thread maps\mp\alien\_unk1422::remove_all_challenge_cases();
    level thread maps\mp\alien\_unk1443::_ID36926( level.players, get_transition_score_component_name_list() );
    setomnvar( "ui_alien_drill_state", 0 );
    setomnvar( "ui_alien_nuke_timer", 0 );
    var_5 = var_0.connected_outpost;
    var_6 = level.outposts[var_5].outpost_encounters[var_0.name];
    [[ var_6.opener_func ]]( var_6, 0 );
    var_6.completed = 1;
    level.outposts[var_5].opened = 1;

    if ( isdefined( var_0.use_trigger ) )
        thread wait_and_delete_proxy( var_0.use_trigger );

    if ( isdefined( var_6.use_trigger ) )
        thread wait_and_delete_proxy( var_6.use_trigger );

    if ( var_0.name != "transition_left" && var_0.name != "transition_middle" && var_0.name != "transition_right" )
    {
        level.outposts[level.current_area_name].outpost_encounters[var_0.name] = undefined;
        level.outposts[var_5].outpost_encounters[var_0.name] = undefined;
    }

    level.num_transition_completed++;

    if ( isdefined( var_0._ID27345 ) )
        var_0._ID27345 notify( "trigger",  level.players[0]  );

    give_players_rewards( var_0 );
    level.current_area_name = var_5;
    level._ID37046 = undefined;
    level.encounter_type = undefined;
    level notify( "outpost_encounter_completed" );
    common_scripts\utility::_ID13180( "outpost_encounter_running" );
}

wait_and_delete_proxy( var_0 )
{
    var_0.marked_for_delete = 1;
    var_0 notify( "stop_listening" );
    level.next_hive_vo_cycle = 99;
    wait 5;
    var_0 delete();
}

transition_running( var_0, var_1, var_2 )
{
    var_1 endon( "stop_listening" );
    var_1 endon( "drill_complete" );

    if ( isdefined( level.drill ) )
        level.drill = undefined;

    var_3 = common_scripts\utility::_ID15384( "hidden_drill_pos", "targetname" );
    level.drill = spawn( "script_model", var_3.origin );
    level.drill.state = "planted";
    level thread maps\mp\alien\_music_and_dialog::playvoforbombplant( var_2 );
    thread maps\mp\alien\_drill::_ID9765();
    level.drill endon( "death" );
    level.drill.owner = var_2;
    level.drill._ID31985 = var_1;
    level.drill._ID33077 = 0;
    level.drill._ID31409 = gettime();
    var_1.scriptables = [];
    var_1._ID25962 = [];
    var_1._ID13828 = [];
    common_scripts\utility::flag_set( "drill_drilling" );
    var_1 _ID17727( var_0 );
    var_1 thread set_transition_state_run( var_2 );
    _ID36640::_ID17038();
    level.drill waittill( "offline",  var_4, var_5  );
}

set_transition_state_run( var_0 )
{
    self endon( "death" );
    self endon( "stop_listening" );
    level.drill.state = "online";
    level.drill notify( "online" );
    level.drill setcandamage( 0 );
    level.drill makeunusable();
    level.drill sethintstring( "" );
    var_1 = level.drill_health_hardcore;
    level.drill.maxhealth = 20000 + var_1;
    level.drill.health = int( 20000 + var_1 * 1.0 );
    level.drill.threatbias = -3000;
    level.drill makeentitysentient( "allies" );
    thread maps\mp\alien\_drill::monitor_drill_complete( self.depth );
    maps\mp\alien\_drill::_ID9765();
    level thread maps\mp\alien\_drill::_ID35941( self.depth );
}

transition_encounter_complete()
{
    if ( isdefined( level.drill ) )
    {
        level.drill.ignoreme = 1;
        level.drill delete();
    }

    common_scripts\utility::_ID13180( "drill_detonated" );
    level thread maps\mp\mp_alien_last::play_transition_encounter_complete_vo();
}

show_transition_objective( var_0, var_1 )
{
    wait(var_1);

    if ( !isdefined( var_0 ) || maps\mp\alien\_unk1464::_ID18506( var_0.completed ) || !isdefined( var_0.objective_marker ) )
        return;

    if ( isdefined( level.waypoint_icon ) )
        level.waypoint_icon destroy();

    if ( isdefined( level.ring_waypoint_icon ) )
        level.ring_waypoint_icon destroy();

    var_2 = "waypoint_alien_blocker";
    var_3 = 14;
    var_4 = 14;
    var_5 = 0.75;
    var_6 = var_0.objective_marker.origin;
    level.waypoint_icon = maps\mp\alien\_hud::_ID37645( var_2, var_3, var_4, var_5, var_6 );
    var_0.use_trigger waittill( "drill_complete" );
    level.waypoint_icon destroy();
    var_0.objective_marker delete();
}

force_end_transition()
{
    if ( !common_scripts\utility::_ID13177( "drill_drilling" ) )
        common_scripts\utility::_ID35637( 4, "drill_drilling" );

    var_0 = level._ID37046.use_trigger;
    var_0._ID19720 = [];
    var_0 notify( "force_drill_complete" );
    level notify( "debug_beat_current_encounter" );
    wait 1.0;
}

opener_pivot( var_0, var_1 )
{
    if ( !isdefined( var_0.gate_pivot ) )
        return;

    var_2 = common_scripts\utility::_ID32831( var_1, var_0.close_delta, var_0.open_delta );

    if ( !var_1 )
        var_0.gate_clip connectpaths();

    level thread play_door_sounds( var_0 );
    var_0.gate_pivot rotateby( ( 0, var_2, 0 ), 1.0, 0.2, 0.2 );
    wait 1.5;
    var_0.gate_clip disconnectpaths();
}

opener_slide( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0.gate_pivot ) )
        return;

    var_3 = common_scripts\utility::_ID32831( var_1, var_0.close_delta, var_0.open_delta );

    if ( !var_1 )
        var_0.gate_clip connectpaths();

    level thread play_door_sounds( var_0 );

    if ( maps\mp\alien\_unk1464::_ID18506( var_2 ) )
        var_0.gate_pivot movex( var_3, 1.0, 0.1, 0.1 );
    else
        var_0.gate_pivot movez( var_3, 1.0, 0.1, 0.1 );

    wait 1.5;
    var_0.gate_clip disconnectpaths();
}

opener_slide_x( var_0, var_1 )
{
    if ( !isdefined( var_0.gate_pivot ) )
        return;

    var_2 = common_scripts\utility::_ID32831( var_1, var_0.close_delta, var_0.open_delta );

    if ( !var_1 )
        var_0.gate_clip connectpaths();

    level thread play_door_sounds( var_0 );
    var_0.gate_pivot movex( var_2, 2.0, 0.3, 0.6 );
    wait 1.5;
    var_0.gate_clip disconnectpaths();
}

opener_doors( var_0, var_1 )
{
    if ( !isdefined( var_0.gate_pivot ) )
        return;

    var_2 = common_scripts\utility::_ID32831( var_1, var_0.close_delta, var_0.open_delta );

    if ( !var_1 )
    {
        var_0.gate_clip connectpaths();
        var_0.gate_clip_double connectpaths();
    }

    level thread play_door_sounds( var_0 );
    var_0.gate_pivot rotateby( ( 0, var_2, 0 ), 1.0, 0.2, 0.2 );
    var_0.gate_pivot_double rotateby( ( 0, var_2 * -1, 0 ), 1.0, 0.2, 0.2 );
    wait 1.5;
    var_0.gate_clip disconnectpaths();
    var_0.gate_clip_double disconnectpaths();
}

play_door_sounds( var_0 )
{
    if ( isdefined( var_0.gate_pivot.script_noteworthy ) )
    {
        switch ( var_0.gate_pivot.script_noteworthy )
        {
            case "main_gate":
                var_0.gate_pivot playsound( "scn_main_gate_open" );
                break;
            case "fence_gate":
                var_0.gate_pivot playsound( "scn_chn_fence_open" );
                break;
            case "office_door":
                var_0.gate_pivot playsound( "scn_office_exit_open" );
                break;
            case "linked_grate":
                var_0.gate_pivot playsound( "scn_grate_lift_open" );
            default:
                break;
        }
    }
}

handle_non_linear_jump_to_start()
{
    var_0 = maps\mp\gametypes\aliens::_ID37540();
    var_1 = maps\mp\gametypes\aliens::_ID37333( var_0 );
    var_2 = 1;

    switch ( var_1 )
    {
        case 0:
        case 1:
            break;
        case 2:
            maps\mp\mp_alien_last_encounters::jump_to_gas_station();
            set_debug_startpointlocations();
            break;
        case 3:
            maps\mp\mp_alien_last_encounters::jump_to_parking();
            set_debug_startpointlocations();
            break;
        case 4:
            maps\mp\mp_alien_last_encounters::jump_to_rooftop();
            set_debug_startpointlocations();
            break;
        case 5:
            level.current_area_name = "parking";
            set_debug_startpointlocations();

            foreach ( var_4 in level.outposts )
            {
                foreach ( var_6 in var_4.outpost_encounters )
                {
                    if ( var_6.type == "transition" )
                    {
                        var_6.completed = 1;
                        [[ var_6.opener_func ]]( var_6, 0 );
                        wait 0.1;
                    }
                }
            }

            maps\mp\mp_alien_last_final_battle::jump_to_return_to_base();
            var_2 = 1;
            break;
        case 6:
            level.current_area_name = "main_base";
            set_debug_startpointlocations();
            maps\mp\mp_alien_last_final_battle::jump_to_final_left();
            var_2 = 0;
            break;
        case 7:
            level.current_area_name = "main_base";
            set_debug_startpointlocations();
            maps\mp\mp_alien_last_final_battle::jump_to_final_middle();
            var_2 = 0;
            break;
        case 8:
            level.current_area_name = "main_base";
            set_debug_startpointlocations();
            maps\mp\mp_alien_last_final_battle::jump_to_final_right();
            var_2 = 0;
            break;
        case 9:
            level.current_area_name = "main_base";
            set_debug_startpointlocations();
            thread maps\mp\mp_alien_last_final_battle::jump_to_final_battle();
            var_2 = 0;
            break;
        case 10:
            level.current_area_name = "main_base";
            set_debug_startpointlocations();
            thread maps\mp\mp_alien_last_final_battle::jump_to_ending();
            var_2 = 0;
            break;
        default:
            break;
    }

    return var_2;
}

set_debug_startpointlocations()
{
    var_0 = 1;

    for ( level.debug_startpointlocations = []; var_0 <= 4; var_0++ )
    {
        var_1 = level.current_area_name + "_spawn_" + var_0;
        var_2 = common_scripts\utility::_ID15384( var_1, "targetname" );

        if ( !isdefined( var_2 ) )
            return;

        level.debug_startpointlocations[level.debug_startpointlocations.size] = common_scripts\utility::drop_to_ground( var_2.origin, 100, -250 );
    }
}

_ID17727( var_0 )
{
    if ( var_0.type == "transition" )
        var_1 = level.cycle_count;
    else
        var_1 = var_0.cycle_count;

    var_2 = level.cycle_data._ID8865[var_1];
    self.depth = var_2[var_2.size - 1];
    self._ID33145 = self.depth;
    self.layer_completed = 0;
    self._ID19720[0] = 0;

    for ( var_3 = 0; var_3 <= var_2.size - 2; var_3++ )
        self._ID19720[self._ID19720.size] = var_2[var_3];
}

give_players_rewards( var_0, var_1, var_2 )
{
    foreach ( var_4 in level.players )
        var_4 thread _ID36640::_ID35519();

    if ( !maps\mp\alien\_unk1464::_ID18426() )
    {
        if ( isdefined( var_0 ) && isdefined( var_0._ID38037 ) )
            give_players_skill_points( var_0._ID38037 );
        else
            give_players_skill_points( var_1 );
    }
    else if ( isdefined( var_0 ) && isdefined( var_0._ID37412 ) )
        give_players_skill_points( var_0._ID37412 );
    else
        give_players_skill_points( var_2 );

    if ( isdefined( var_0 ) && maps\mp\alien\_unk1464::_ID18506( var_0.blocker ) )
    {
        foreach ( var_4 in level.players )
            var_4 maps\mp\alien\_persistence::try_award_bonus_pool_token();
    }

    if ( maps\mp\alien\_unk1464::_ID18745() && !issplitscreen() && isdefined( var_0 ) )
    {
        if ( var_0.type == "transition" && ( level.num_transition_completed == 3 || level.num_transition_completed == 5 ) )
            maps\mp\alien\_laststand::_ID15541( level.players[0], 1 );
    }
}

get_transition_score_component_name_list()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        return [ "street_personal", "street_challenge" ];
    else
        return [ "street_team", "street_personal", "street_challenge" ];
}

get_conduit_score_component_name_list()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        return [ "generator", "generator_personal", "generator_challenge" ];
    else
        return [ "generator", "generator_team", "generator_personal", "generator_challenge" ];
}

last_get_current_player_volumes_override_func()
{
    var_0 = [];
    var_1 = [];
    var_2 = level._ID37166;

    foreach ( var_4 in level.cycle_data._ID30813 )
    {
        var_0[var_0.size] = var_4._ID35399;

        if ( isdefined( var_2 ) && isdefined( var_4._ID35399._ID27766 ) && var_4._ID35399._ID27766 == var_2 )
        {
            var_5 = var_4._ID35399.script_linkname;
            var_1[var_5] = spawnstruct();
            var_1[var_5].players = [];
            var_1[var_5].origin = var_4._ID35399.origin;
            var_1[var_5].name = var_5;
        }
    }

    foreach ( var_8 in level.players )
    {
        var_9 = var_8 getistouchingentities( var_0 );

        foreach ( var_11 in var_9 )
        {
            var_12 = 0;

            if ( !isdefined( var_1[var_11.script_linkname] ) )
            {
                var_5 = var_11.script_linkname;
                var_1[var_5] = spawnstruct();
                var_1[var_5].players = [];
                var_1[var_5].origin = var_11.origin;
                var_1[var_5].name = var_5;
            }

            var_12 = var_1[var_11.script_linkname].players.size;
            var_1[var_11.script_linkname].players[var_12] = var_8;
        }
    }

    return var_1;
}

set_area_index_for_encounter( var_0 )
{
    var_1 = 0;

    switch ( var_0 )
    {
        case "main_base":
            var_1 = 0;
            break;
        case "conduit_gas_station_2":
        case "conduit_gas_station_1":
            var_1 = 1;
            break;
        case "conduit_parking_2":
        case "conduit_parking_1":
            var_1 = 2;
            break;
        case "conduit_rooftop_2":
        case "conduit_rooftop_1":
            var_1 = 3;
            break;
        case "transition_left":
            var_1 = 4;
            break;
        case "transition_upper_left":
            var_1 = 5;
            break;
        case "transition_middle":
            var_1 = 6;
            break;
        case "transition_upper_right":
            var_1 = 7;
            break;
        case "transition_right":
            var_1 = 8;
            break;
    }

    level._ID37044 = var_1;
}

give_players_skill_points( var_0 )
{
    level.skill_points_earned_from_progression = level.skill_points_earned_from_progression + var_0;
    maps\mp\gametypes\aliens::_ID37375( var_0 );
}

last_hotjoin_skill_points()
{
    var_0 = 1;

    if ( maps\mp\alien\_unk1464::_ID18426() )
        var_1 = 0;
    else
        var_1 = max( 0, level.skill_points_earned_from_progression - var_0 );

    var_2 = maps\mp\alien\_unk1422::get_num_challenge_completed();
    return var_1 + var_2;
}
