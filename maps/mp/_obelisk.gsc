// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

obelisk_init()
{
    level.scanned_obelisks = [];
    level.drill_tutorial_text = &"MP_ALIEN_DESCENT_DRILL_TUTORIAL_HINT";
}

obelisk()
{
    var_0 = select_obelisks();
    level thread maps\mp\alien\_spawnlogic::_ID37163( "drill_planted" );

    foreach ( var_2 in var_0 )
        var_2 thread obelisk_listener( var_2 );

    level waittill( "obelisk_destroyed" );
    maps\mp\alien\_spawn_director::_ID11539();
    level thread maps\mp\alien\_spawnlogic::remaining_alien_management();
}

obelisk_listener( var_0 )
{
    level endon( "game_ended" );
    var_0 notify( "stop_listening" );
    var_0 endon( "stop_listening" );

    if ( isdefined( level.drill ) && !isdefined( level.drill_carrier ) )
        level waittill( "drill_pickedup" );

    var_1 = _ID36640::get_hive_waypoint_dist( var_0, 1300 );
    var_0 thread _ID36640::_ID28422( "waypoint_alien_scan", var_1 );
    var_2 = var_0 maps\mp\alien\_drill::_ID35452();
    level.current_hive_name = var_0.target;
    level._ID37166 = var_0.target;
    level.drill_carrier = undefined;

    if ( level.cycle_count == 1 )
        level maps\mp\_utility::_ID9519( 1, maps\mp\alien\_music_and_dialog::playvoforwavestart );

    var_0 thread scanning( var_0, var_0.origin, var_2 );
    var_0 _ID36640::_ID10102();
    maps\mp\_utility::_ID9519( 2, maps\mp\alien\_unk1422::_ID30613 );
    maps\mp\alien\_unk1443::_ID37894();
    common_scripts\utility::flag_wait( "drill_detonated" );
    var_0 thread scan_complete_sequence( var_0 );
    add_to_scanned_obelisk_list( var_0 );
    maps\mp\alien\_unk1422::_ID11538();
    maps\mp\alien\_unk1443::_ID36926( level.players, _ID36640::get_regular_hive_score_component_name_list() );
    level._ID31986 = common_scripts\utility::array_remove( level._ID31986, var_0 );
    level.current_hive_name = level.current_hive_name + "_post";
    level.num_hive_destroyed++;

    if ( isdefined( var_0._ID27345 ) )
        var_0._ID27345 notify( "trigger",  level.players[0]  );

    give_players_rewards();
    level notify( "obelisk_destroyed" );
    var_0 notify( "stop_listening" );
}

give_players_rewards()
{
    foreach ( var_1 in level.players )
    {
        var_1 maps\mp\alien\_persistence::eog_player_update_stat( "hivesdestroyed", 1 );
        var_1 thread _ID36640::_ID35519();
    }
}

select_obelisks()
{
    var_0 = [];
    var_1 = maps\mp\alien\_unk1464::_ID37267();

    foreach ( var_3 in level._ID31986 )
    {
        if ( !( var_3._ID36729 == var_1 ) )
            continue;

        if ( !var_3 _ID36640::dependent_hives_removed() )
            continue;

        var_0 = common_scripts\utility::array_add( var_0, var_3 );
    }

    return var_0;
}

scanning( var_0, var_1, var_2 )
{
    var_0 endon( "stop_listening" );
    var_0 endon( "drill_complete" );
    var_0 thread set_scanner_state_plant( var_0, var_1, var_2 );
    level.drill endon( "death" );
    level.drill.owner = var_2;
    level.drill._ID31985 = var_0;
    common_scripts\utility::flag_set( "drill_drilling" );
    level.drill waittill( "drill_finished_plant_anim" );
    var_0 maps\mp\alien\_drill::_ID17727();
    var_0 thread set_scanner_state_scan( var_0, var_2 );
    level.drill waittill( "offline",  var_3, var_4  );
    var_0 thread maps\mp\alien\_drill::_ID28322();
    wait 2;
    maps\mp\gametypes\aliens::alienendgame( "axis", maps\mp\alien\_hud::_ID14441( "drill_destroyed" ) );
}

set_scanner_state_plant( var_0, var_1, var_2 )
{
    if ( isdefined( level.drill ) )
    {
        level.drill delete();
        level.drill = undefined;
    }

    level.drill = spawn( "script_model", var_1 );
    level.drill setmodel( "mp_laser_drill" );
    level.drill playsound( "alien_drill_scanner_plant" );
    level.drill.state = "planted";
    level.drill.angles = var_0.angles;
    level.drill.maxhealth = 20000 + level.drill_health_hardcore;
    level.drill.health = int( 20000 + level.drill_health_hardcore * var_2 maps\mp\alien\_perk_utility::perk_getdrillhealthscalar() );
    level.drill thread maps\mp\alien\_drill::_ID36026( var_0 );
    level.drill thread maps\mp\alien\_drill::_ID35943();
    maps\mp\alien\_outline_proto::_ID2259( level.drill, 0 );
    level thread maps\mp\alien\_music_and_dialog::playvoforbombplant( var_2 );
    maps\mp\alien\_drill::_ID9765();
    level.drill scriptmodelplayanim( "alien_drill_scan_enter" );
    wait 4;
    level.drill notify( "drill_finished_plant_anim" );
}

set_scanner_state_scan( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "stop_listening" );
    level.drill.state = "online";
    level.drill makeentitysentient( "allies" );
    level.drill setthreatbiasgroup( "drill" );
    level.drill setcandamage( 1 );
    level.drill makeunusable();
    level.drill sethintstring( "" );
    level.drill.threatbias = -3000;
    level.drill scriptmodelplayanim( "alien_drill_scan_loop" );
    level.drill thread sfx_scanner_on( level.drill );
    maps\mp\alien\_drill::update_drill_health_hud();
    level thread obelisk_scan_fx( var_0 );

    foreach ( var_3 in level.agentarray )
    {
        if ( isdefined( var_3._ID36227 ) && var_3._ID36227 )
            var_3 getenemyinfo( level.drill );
    }

    var_0.depth_marker = gettime();
    var_0 thread maps\mp\alien\_drill::_ID16044();
    var_0 thread maps\mp\alien\_drill::monitor_drill_complete( var_0.depth );
    var_0 thread _ID36640::_ID28422( "waypoint_alien_defend" );
    maps\mp\alien\_drill::_ID9765();
    maps\mp\alien\_hud::turn_on_drill_meter_hud( var_0.depth );
    level thread maps\mp\alien\_drill::_ID35941( var_0.depth );
}

obelisk_scan_fx( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "stop_listening" );

    for (;;)
    {
        playfxontag( level._ID1644["obelisk_scan_loop"], level.drill, "tag_laser" );
        wait 5;
    }
}

sfx_scanner_on( var_0 )
{
    level.drill_sfx_lp = spawn_sfx_and_play( var_0.origin, var_0, 0, "alien_drill_scanner_lp" );
}

scan_complete_sequence( var_0 )
{
    var_0 thread play_obelisk_scan_complete_animations( var_0.scriptables[0] );
    var_0 notify( "hive_dying" );
    var_0 _ID36640::destroy_hive_icon();
    maps\mp\alien\_outline_proto::_ID25899( level.drill );
    level.drill scriptmodelplayanim( "alien_drill_scan_exit" );
    level.drill sfx_scanner_off( level.drill );
    stopfxontag( level._ID1644["obelisk_scan_loop"], level.drill, "tag_laser" );
    wait 3.8;

    if ( !isdefined( var_0._ID19460 ) || !var_0._ID19460 )
    {
        var_1 = level.drill.origin + ( 0, 0, 8 );
        maps\mp\alien\_drill::drop_drill( var_1, var_0.angles - ( 0, 90, 0 ) );
    }

    if ( isdefined( var_0._ID19460 ) && var_0._ID19460 )
        common_scripts\utility::flag_set( "hives_cleared" );

    common_scripts\utility::_ID13180( "drill_detonated" );

    if ( !maps\mp\alien\_unk1464::_ID18506( level.no_grab_drill_vo ) )
    {
        level maps\mp\_utility::_ID9519( 8, maps\mp\alien\_music_and_dialog::play_vo_for_grab_drill );
        return;
    }
}

play_obelisk_scan_complete_animations( var_0 )
{
    var_1 = 5.0;
    var_0 setscriptablepartstate( 0, 1 );
    wait(var_1);
    var_0 setscriptablepartstate( 0, 2 );
}

sfx_scanner_off( var_0 )
{
    var_0 playsound( "alien_drill_scanner_off" );
    _ID27085( level.drill_sfx_lp );
    _ID27085( level.drill_overheat_lp_02 );
}

wait_for_all_scanned_obelisk_destroyed( var_0, var_1, var_2 )
{
    foreach ( var_4 in level.scanned_obelisks )
        var_4 thread obelisk_damage_listener( var_4, var_0, var_1, "waypoint_alien_destroy" );

    for (;;)
    {
        level waittill( "scanned_obelisk_destroyed",  var_6  );
        level.scanned_obelisks = common_scripts\utility::array_remove( level.scanned_obelisks, var_6 );

        if ( level.scanned_obelisks.size == 0 )
            return;
    }
}

add_to_scanned_obelisk_list( var_0 )
{
    level.scanned_obelisks[level.scanned_obelisks.size] = var_0;
}

obelisk_damage_listener( var_0, var_1, var_2, var_3 )
{
    var_4 = get_obelisk_clip( var_0 );
    var_4 setcandamage( 1 );
    var_4 setcanradiusdamage( 1 );
    var_0.health = var_1;
    var_5 = maps\mp\alien\_hud::_ID37645( var_3, 20, 20, 1, var_4.origin );
    var_6 = spawn( "script_model", var_0.scriptables[0].origin );
    var_6.angles = var_0.scriptables[0].angles;
    var_6 setmodel( "dct_alien_obelisk" );
    maps\mp\alien\_outline_proto::enable_outline_for_players( var_6, level.players, 2, 0, "high" );

    for (;;)
    {
        var_4 waittill( "damage",  var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16  );

        if ( !isdefined( var_8.team ) || var_8.team != "allies" )
            continue;

        if ( isdefined( var_2 ) && isdefined( var_16 ) && !common_scripts\utility::array_contains( var_2, var_16 ) )
            var_7 = int( var_7 * 0.1 );

        if ( isdefined( var_8 ) )
        {
            var_17 = "standard";

            if ( isdefined( var_16 ) && var_16 == "alienvanguard_projectile_mp" )
                var_17 = "hitaliensoft";

            if ( !isplayer( var_8 ) && isdefined( var_8._ID18319 ) )
                var_8 = var_8._ID18319;

            var_8 thread maps\mp\gametypes\_damagefeedback::_ID34528( var_17 );
        }

        var_0.health = var_0.health - var_7;

        if ( var_0.health < 0 )
        {
            break;
            continue;
        }

        if ( var_0.health < var_1 * 0.33 )
        {
            var_0.scriptables[0] setscriptablepartstate( 0, "damaged_2" );
            maps\mp\alien\_outline_proto::enable_outline_for_players( var_6, level.players, 1, 0, "high" );
            continue;
        }

        if ( var_0.health < var_1 * 0.66 )
        {
            var_0.scriptables[0] setscriptablepartstate( 0, "damaged_1" );
            maps\mp\alien\_outline_proto::enable_outline_for_players( var_6, level.players, 5, 0, "high" );
        }
    }

    var_0 thread sfx_obelisk_destroyed();
    maps\mp\alien\_outline_proto::disable_outline_for_players( var_6, level.players );
    var_6 delete();
    var_0.scriptables[0] setscriptablepartstate( 0, "remove" );
    var_4 delete();
    var_5 destroy();
    level notify( "scanned_obelisk_destroyed",  var_0  );
}

spawn_sfx_and_play( var_0, var_1, var_2, var_3 )
{
    var_4 = spawn( "script_origin", var_0 );
    var_4 linkto( var_1 );
    var_4 thread play_sfx( var_4, var_2, var_3 );
    return var_4;
}

play_sfx( var_0, var_1, var_2 )
{
    wait(var_1);
    var_0 playloopsound( var_2 );
}

_ID27085( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        var_0 delete();
        return;
    }
}

get_obelisk_clip( var_0 )
{
    foreach ( var_2 in self._ID25962 )
    {
        if ( var_2.classname == "script_brushmodel" )
            return var_2;
    }
}

sfx_obelisk_destroyed()
{
    playsoundatpos( self.origin, "alien_obelisk_destroyed" );
}
