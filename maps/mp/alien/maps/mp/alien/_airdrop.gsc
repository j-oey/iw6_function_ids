// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID37467()
{
    if ( !maps\mp\alien\_unk1464::alien_mode_has( "airdrop" ) )
        return;

    if ( !common_scripts\utility::flag_exist( "hives_cleared" ) )
        common_scripts\utility::_ID13189( "hives_cleared" );

    if ( !common_scripts\utility::flag_exist( "nuke_countdown" ) )
        common_scripts\utility::_ID13189( "nuke_countdown" );

    if ( !common_scripts\utility::flag_exist( "escape_conditions_met" ) )
        common_scripts\utility::_ID13189( "escape_conditions_met" );

    common_scripts\utility::_ID13189( "nuke_went_off" );
    init_fx();
    _ID17699();
}

init_fx()
{
    level._ID1644["alien_heli_spotlight"] = loadfx( "vfx/gameplay/alien/vfx_alien_spotlight_heli_model" );
    level._ID1644["cockpit_blue_cargo01"] = loadfx( "fx/misc/aircraft_light_cockpit_red" );
    level._ID1644["cockpit_blue_cockpit01"] = loadfx( "fx/misc/aircraft_light_cockpit_blue" );
    level._ID1644["white_blink"] = loadfx( "fx/misc/aircraft_light_white_blink" );
    level._ID1644["white_blink_tail"] = loadfx( "fx/misc/aircraft_light_red_blink" );
    level._ID1644["wingtip_green"] = loadfx( "fx/misc/aircraft_light_wingtip_green" );
    level._ID1644["wingtip_red"] = loadfx( "fx/misc/aircraft_light_wingtip_red" );
    level._ID1644["spot"] = loadfx( "fx/misc/aircraft_light_hindspot" );
    level._ID1644["harrier_heavy_smoke"] = loadfx( "fx/smoke/smoke_trail_black_heli_emitter" );
    level._ID1644["escape_zone_ring"] = loadfx( "vfx/gameplay/alien/vfx_alien_chopper_escape_ring" );
}

_ID37181()
{
    level endon( "game_ended" );
    _ID37994();
    maps\mp\alien\_spawnlogic::escape_choke_init();
    var_0 = spawn( "script_model", ( -4606.2, 3258.7, 307.7 ) );
    var_0 setmodel( "tag_origin" );
    var_0 makeusable();
    wait 0.05;
    var_1 = newhudelem();
    var_1 setshader( "waypoint_bomb", 14, 14 );
    var_1.alpha = 1;
    var_1.color = ( 1, 1, 1 );
    var_1 setwaypoint( 1, 1 );
    var_1.x = var_0.origin[0];
    var_1.y = var_0.origin[1];
    var_1.z = var_0.origin[2];
    var_0 setcursorhint( "HINT_ACTIVATE" );
    level thread _ID37803( var_0 );

    if ( isdefined( level.players ) && level.players.size > 1 )
    {
        var_0 sethintstring( &"ALIEN_COLLECTIBLES_ACTIVATE_NUKE" );
        iprintlnbold( &"ALIEN_COLLECTIBLES_NUKE_ACTIVATE_USE" );
    }
    else
    {
        var_0 sethintstring( &"ALIEN_COLLECTIBLES_ACTIVATE_NUKE_SOLO" );
        iprintlnbold( &"ALIEN_COLLECTIBLES_NUKE_ACTIVATE_USE_SOLO" );
    }

    _ID35440();
    level thread maps\mp\alien\_spawnlogic::_ID12243( level.escape_cycle );
    level thread maps\mp\alien\_music_and_dialog::_ID24682();
    var_2 = getent( "escape_zone", "targetname" );

    if ( isdefined( level._ID26071 ) )
        level._ID26071 destroy();

    level._ID26071 = newhudelem();
    level._ID26071 setshader( "waypoint_alien_beacon", 14, 14 );
    level._ID26071.alpha = 0;
    level._ID26071.color = ( 1, 1, 1 );
    level._ID26071 setwaypoint( 1, 1 );
    level._ID26071.x = var_2.origin[0];
    level._ID26071.y = var_2.origin[1];
    level._ID26071.z = var_2.origin[2];
    common_scripts\utility::flag_set( "nuke_countdown" );
    common_scripts\utility::_ID13180( "alien_music_playing" );
    level thread maps\mp\alien\_music_and_dialog::_ID23809();
    var_1 destroy();
    var_0 makeunusable();
    var_0 setcursorhint( "HINT_ACTIVATE" );
    var_0 sethintstring( "" );
    var_0 delete();
    var_3 = gettime();
    level thread _ID22341();
    level thread rescue_think( var_3 );
    level thread _ID17615();
}

_ID37803( var_0 )
{
    level endon( "all_players_using_nuke" );

    foreach ( var_2 in level.players )
        var_2 thread _ID38287( var_0 );

    for (;;)
    {
        level waittill( "connected",  var_2  );
        var_2 thread _ID38287( var_0 );
    }
}

rescue_think( var_0 )
{
    level endon( "game_ended" );
    var_1 = getent( "escape_zone", "targetname" );
    var_2 = common_scripts\utility::_ID15384( var_1.target, "targetname" );
    var_3 = var_2.origin;
    var_4 = var_2.angles;
    level.escape_loc = var_1.origin;
    thread call_in_rescue_heli( var_3, var_4, 10 );

    while ( !isdefined( level._ID26068 ) )
        wait 0.05;

    level._ID26068 maps\mp\_utility::_ID9519( 5, maps\mp\alien\_music_and_dialog::play_pilot_vo, "so_alien_plt_comeon" );
    level._ID26068 thread heli_leave_on_nuke();
    level._ID26068 thread _ID13431();
    level._ID26068 _ID35666();
    thread watch_player_escape( var_1, var_0 );
}

_ID35666()
{
    level endon( "nuke_went_off" );
    self waittill( "in_position" );
    level._ID26068 thread maps\mp\alien\_music_and_dialog::play_pilot_vo( "so_alien_plt_exfil" );
    level thread get_on_chopper_nag();
}

get_on_chopper_nag()
{
    level endon( "nuke_went_off" );
    level endon( "escape_conditions_met" );
    var_0 = [ "so_alien_plt_getonchopper", "so_alien_plt_hurryup", "so_alien_plt_comeon" ];

    for (;;)
    {
        wait(randomintrange( 10, 15 ));
        level._ID26068 thread maps\mp\alien\_music_and_dialog::play_pilot_vo( common_scripts\utility::_ID25350( var_0 ) );
    }
}

heli_leave_on_nuke()
{
    self endon( "death" );
    self waittill( "rescue_chopper_exit" );
    self setneargoalnotifydist( 200 );
    self.near_goal = 1;
    var_0 = self._ID12431[0];

    for ( var_1 = 0; var_1 < self._ID12431.size; var_1++ )
    {
        var_2 = self._ID12431[var_1];
        _ID16583( var_2.origin, int( min( 35, 20 + var_1 * 5 ) ) );
    }
}

_ID13431()
{
    level endon( "nuke_went_off" );
    self endon( "death" );
    var_0 = getent( "fly_to_extraction_trig", "targetname" );

    for (;;)
    {
        var_0 waittill( "trigger",  var_1  );

        if ( isplayer( var_1 ) )
        {
            self notify( "fly_to_extraction" );
            return;
        }

        wait 0.05;
    }
}

watch_player_escape( var_0, var_1 )
{
    level._ID26068 endon( "death" );
    var_2 = var_0.origin;
    var_3 = var_0.radius;
    var_4 = 128;
    var_5 = spawnfx( level._ID1644["escape_zone_ring"], var_2 );
    triggerfx( var_5 );
    var_6 = spawn( "trigger_radius", var_2, 0, var_3, var_4 );
    _ID35454( var_6 );
    var_5 delete();
    common_scripts\utility::flag_set( "escape_conditions_met" );

    if ( isdefined( level._ID26071 ) )
        level._ID26071 destroy();

    level._ID26068 notify( "extract" );
    var_7 = [];
    var_8 = [];

    foreach ( var_10 in level.players )
    {
        if ( var_10 istouching( var_6 ) && isalive( var_10 ) && !( isdefined( var_10.laststand ) && var_10.laststand ) )
        {
            var_7[var_7.size] = var_10;

            if ( !maps\mp\alien\_unk1464::is_casual_mode() )
                var_10 maps\mp\alien\_persistence::_ID28529();

            var_10.nuke_escaped = 1;
            continue;
        }

        var_8[var_8.size] = var_10;
        var_10.nuke_escaped = 0;
    }

    foreach ( var_10 in level.players )
    {
        if ( 1 == var_10.nuke_escaped )
            var_10 maps\mp\alien\_persistence::award_completion_tokens();
    }

    level.num_players_left = level.players.size - var_7.size;
    level._ID22384 = var_7.size;

    foreach ( var_10 in var_8 )
        var_10 iprintlnbold( &"ALIEN_COLLECTIBLES_YOU_DIDNT_MAKE_IT" );

    if ( var_7.size == 0 )
    {
        var_16 = maps\mp\alien\_hud::_ID14441( "fail_escape" );
        level maps\mp\_utility::_ID9519( 15, maps\mp\gametypes\aliens::alienendgame, "axis", var_16 );
        level._ID26068 notify( "rescue_chopper_exit" );
        return;
    }

    var_17 = _ID14452( var_1 );
    var_18 = common_scripts\utility::_ID15384( "player_teleport_loc", "targetname" );
    var_19 = var_18.origin;

    foreach ( var_10 in var_7 )
        var_10 thread player_blend_to_chopper();

    wait 1.6;

    if ( level.players.size == 1 )
        level._ID26068 maps\mp\_utility::_ID9519( 2, maps\mp\alien\_music_and_dialog::play_pilot_vo, "so_alien_plt_itsjustyou" );
    else if ( level.players.size > level._ID22384 )
        level._ID26068 maps\mp\_utility::_ID9519( 2, maps\mp\alien\_music_and_dialog::play_pilot_vo, "so_alien_plt_wherestherest" );

    level thread maps\mp\alien\_music_and_dialog::_ID23753();
    thread _ID29513( level._ID26068 );
    wait 0.5;
    level._ID26068 notify( "rescue_chopper_exit" );
    wait 4;
    level notify( "force_nuke_detonate" );
    var_22 = [ "so_alien_plt_sourceofinvasion", "so_alien_plt_squashmorebugs" ];
    level._ID26068 maps\mp\_utility::_ID9519( 2, maps\mp\alien\_music_and_dialog::play_pilot_vo, common_scripts\utility::_ID25350( var_22 ) );
    level._ID26068 thread play_nuke_rumble( 4.5 );
    _ID36632::_ID37944( var_17 );
    maps\mp\alien\_achievement::_ID34422( var_7, var_17 );
    maps\mp\alien\_unk1443::_ID25028( var_17, var_7 );
    maps\mp\alien\_unlock::_ID34423( var_7 );
    maps\mp\alien\_persistence::update_lb_aliensession_escape( var_7, var_17 );
    wait 2;

    if ( var_7.size == level.players.size )
        var_23 = maps\mp\alien\_hud::_ID14441( "all_escape" );
    else
        var_23 = maps\mp\alien\_hud::_ID14441( "some_escape" );

    level maps\mp\_utility::_ID9519( 10, maps\mp\gametypes\aliens::alienendgame, "allies", var_23 );
}

player_blend_to_chopper()
{
    self endon( "death" );
    self endon( "disconnect" );

    if ( self isusingturret() && isdefined( self._ID8662 ) )
    {
        self._ID8662 notify( "death" );
        wait 0.5;
    }

    self notify( "force_cancel_placement" );
    self.playerlinkedtochopper = 1;
    self notify( "dpad_cancel" );
    self disableusability();
    fade_black_screen();
    self.escape_overlay fadeovertime( 0.5 );
    self.escape_overlay.alpha = 1;
    wait 0.5;
    self playerhide();
    maps\mp\_utility::_ID13582( 1 );
    var_0 = "TAG_ALIEN_P1";
    self playerlinktoblend( level._ID26068, var_0, 0.6, 0.2, 0.2 );
    wait 0.6;
    self playerlinkto( level._ID26068, var_0, 1, 50, 50, 18, 30, 0 );
    thread force_crouch( 1 );
    self allowjump( 0 );
    self.escape_overlay fadeovertime( 0.5 );
    self.escape_overlay.alpha = 0;
    wait 0.5;
    self.escape_overlay destroy();
}

fade_black_screen()
{
    self.escape_overlay = newclienthudelem( self );
    self.escape_overlay.x = 0;
    self.escape_overlay.y = 0;
    self.escape_overlay setshader( "black", 640, 480 );
    self.escape_overlay.alignx = "left";
    self.escape_overlay.aligny = "top";
    self.escape_overlay.sort = 1;
    self.escape_overlay.horzalign = "fullscreen";
    self.escape_overlay.vertalign = "fullscreen";
    self.escape_overlay.alpha = 0;
    self.escape_overlay.foreground = 1;
}

play_nuke_rumble( var_0 )
{
    wait(var_0);

    foreach ( var_2 in level.players )
    {
        earthquake( 0.33, 4, var_2.origin, 1000 );
        var_2 playrumbleonentity( "heavy_3s" );
    }
}

force_crouch( var_0 )
{
    self endon( "death" );
    self endon( "remove_force_crouch" );

    if ( isdefined( var_0 ) && var_0 == 0 )
        self notify( "remove_force_crouch" );
    else
    {
        for (;;)
        {
            if ( self getstance() != "crouch" )
                self setstance( "crouch" );

            wait 0.05;
        }
    }
}

_ID35454( var_0 )
{
    level endon( "nuke_went_off" );

    if ( common_scripts\utility::_ID13177( "nuke_went_off" ) )
        return;

    for (;;)
    {
        var_1 = [];
        var_2 = [];

        foreach ( var_4 in level.players )
        {
            if ( !isalive( var_4 ) || isdefined( var_4.laststand ) && var_4.laststand )
                continue;

            if ( var_4 istouching( var_0 ) )
            {
                var_1[var_1.size] = var_4;
                continue;
            }

            var_2[var_2.size] = var_4;
        }

        if ( var_1.size == 0 )
        {
            wait 0.05;
            continue;
        }
        else if ( var_2.size == 0 )
            return;

        wait 0.05;
    }
}

_ID35440()
{
    level endon( "game_ended" );

    while ( !are_all_players_using_nuke() )
        wait 0.05;

    level notify( "all_players_using_nuke" );
}

are_all_players_using_nuke()
{
    var_0 = 1;

    foreach ( var_2 in level.players )
    {
        if ( !isdefined( var_2._ID24414 ) || !var_2._ID24414 )
            var_0 = 0;
    }

    return var_0;
}

_ID38287( var_0 )
{
    level endon( "game_ended" );
    level endon( "all_players_using_nuke" );
    self endon( "disconnect" );
    self notify( "watch_for_use_nuke" );
    self endon( "watch_for_use_nuke" );
    self._ID24414 = 0;

    for (;;)
    {
        if ( self usebuttonpressed() && distancesquared( self.origin, var_0.origin ) < 16900 )
        {
            self._ID24414 = 1;
            self notify( "using_nuke" );
            thread reset_nuke_usage();
        }

        wait 0.05;
    }
}

reset_nuke_usage()
{
    level endon( "game_ended" );
    level endon( "all_players_using_nuke" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "using_nuke" );
    wait 0.5;
    self._ID24414 = 0;
}

_ID22341()
{
    var_0 = 240;
    level._ID22372 = ( -9068, 5883, 600 );
    level._ID22354 = ( 0, -60, 90 );
    setomnvar( "ui_alien_nuke_timer", gettime() + 240000 );
    level thread hide_timer_on_game_end();
    _ID35465( var_0, "force_nuke_detonate" );
    level._ID22376 = 3.35;
    level.players[0] thread maps\mp\alien\_nuke::donukesimple();
    common_scripts\utility::_ID13180( "nuke_countdown" );
    setomnvar( "ui_alien_nuke_timer", 0 );
    common_scripts\utility::flag_set( "nuke_went_off" );
    var_1 = 0;
    level thread _ID33292( var_1 );
    wait 2;
    level.fx_crater_plume delete();
}

hide_timer_on_game_end()
{
    level waittill( "game_ended" );
    setomnvar( "ui_alien_nuke_timer", 0 );
}

_ID14452( var_0 )
{
    var_1 = gettime() - var_0;
    var_2 = 240000 - var_1;
    var_2 = max( 0, var_2 );
    return var_2;
}

_ID35465( var_0, var_1 )
{
    level endon( var_1 );

    if ( !isdefined( level._ID22340 ) )
    {
        level._ID22340 = spawn( "script_origin", ( 0, 0, 0 ) );
        level._ID22340 hide();
    }

    for ( var_0 = int( var_0 ); var_0 > 0; var_0-- )
    {
        if ( var_0 == 10 )
            level thread maps\mp\alien\_music_and_dialog::_ID24658();

        if ( var_0 == 30 )
            level thread maps\mp\alien\_music_and_dialog::_ID24659();

        if ( var_0 == 120 )
            level thread maps\mp\alien\_music_and_dialog::_ID24676();

        if ( var_0 <= 30 )
            level._ID22340 playsound( "ui_mp_nukebomb_timer" );

        wait 1.0;
    }

    return 1;
}

_ID33292( var_0 )
{
    var_1 = gettime();
    level waittill( "game_ended" );
    var_2 = gettime();
    level._ID32124 = var_2 - var_1;
}

_ID17615()
{
    level endon( "game_ended" );
    level notify( "force_cycle_start" );
    level.infinite_event_index = 1;
    level._ID17614 = 60;

    for (;;)
    {
        _ID35484();
        var_0 = "chaos_event_2";
        level notify( var_0 );
        level._ID19496 = gettime();
        maps\mp\alien\_spawn_director::activate_spawn_event( var_0 );
        level.infinite_event_index++;
    }
}

_ID35484()
{
    level endon( "force_chaos_event" );

    if ( level.infinite_event_index == 1 )
        wait 5;
    else
        wait(level._ID17614);
}

_ID37994()
{
    level._ID30946 = getentarray( "force_special_spawn_trig", "targetname" );

    foreach ( var_1 in level._ID30946 )
        var_1 thread _ID36021();
}

_ID36021()
{
    level endon( "game_ended" );
    level endon( "nuke_went_off" );
    self endon( "death" );

    if ( !common_scripts\utility::flag_exist( "nuke_countdown" ) )
        return;

    if ( !common_scripts\utility::_ID13177( "nuke_countdown" ) )
        common_scripts\utility::flag_wait( "nuke_countdown" );

    for (;;)
    {
        self waittill( "trigger",  var_0  );

        if ( isdefined( var_0 ) && isplayer( var_0 ) && isalive( var_0 ) )
        {
            break;
            continue;
        }

        wait 0.05;
        continue;
    }

    if ( isdefined( level._ID19496 ) )
    {
        var_1 = 15;

        if ( ( gettime() - level._ID19496 ) / 1000 > var_1 )
            level notify( "force_chaos_event" );
    }
    else
        level notify( "force_chaos_event" );

    if ( isdefined( level._ID30946 ) && level._ID30946.size )
        level._ID30946 = common_scripts\utility::array_remove( level._ID30946, self );

    self delete();
}

call_in_rescue_heli( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    level endon( "nuke_went_off" );
    level._ID16580 = 1200;
    level._ID16622 = 1200;
    var_3 = _ID14334();
    var_4 = var_3 + ( 0, 0, level._ID16580 );
    var_5 = var_0 + ( 0, 0, level._ID16580 );
    var_6 = level._ID16622 * ( 0, 1, 0 );
    var_7 = ( 0, 8000, 0 );
    var_8 = var_4 + var_6;
    var_9 = var_4 + var_7;

    if ( isdefined( level._ID4063 ) )
    {
        level._ID4063 notify( "convert_to_hive_heli" );
        stopfxontag( level._ID1644["alien_heli_spotlight"], level._ID4063, "tag_flash" );
        wait 0.5;
        level._ID26068 = level._ID4063;
    }
    else
    {
        level._ID26068 = heli_setup( level.players[0], var_9, var_8 );
        level._ID26068 thread _ID16591();
    }

    level._ID26068 _ID16856();
    level._ID26068.drop_loc = var_0;
    level._ID26068._ID12431 = [];
    var_10 = common_scripts\utility::_ID15384( "heli_extraction_start", "targetname" );

    for ( level._ID26068._ID12431[0] = var_10; isdefined( var_10.target ); level._ID26068._ID12431[level._ID26068._ID12431.size] = var_10 )
        var_10 = common_scripts\utility::_ID15384( var_10.target, "targetname" );

    level._ID26068 thread heli_turret_think();
    level._ID26068 _ID16583( var_8, 60 );
    wait 1;
    level._ID26068 notify( "weapons_free" );
    playfxontag( level._ID1644["alien_heli_spotlight"], level._ID26068, "tag_flash" );
    level._ID26068 _ID16619( var_2, 0, ::get_player_loop_center, "fly_to_extraction" );
    level._ID26068 thread maps\mp\alien\_music_and_dialog::play_pilot_vo( "so_alien_plt_exfil" );
    level._ID26068 notify( "stop_turret" );
    stopfxontag( level._ID1644["alien_heli_spotlight"], level._ID26068, "tag_flash" );
    level._ID26068 _ID16583( var_5, 30 );
    thread sfx_rescue_heli_flyin( level._ID26068 );
    level._ID26068 _ID16583( var_0, 30 );
    level._ID26068 notify( "in_position" );
    level._ID26068 setgoalyaw( var_1[1] );
    level._ID26068 thread heli_turret_think();
    wait 0.05;
    level._ID26068 notify( "weapons_free" );
    playfxontag( level._ID1644["alien_heli_spotlight"], level._ID26068, "tag_flash" );
}

_ID16856()
{
    self hidepart( "door_l" );
    self hidepart( "door_l_handle" );
    self hidepart( "door_l_lock" );
    self hidepart( "door_r" );
    self hidepart( "door_r_handle" );
    self hidepart( "door_r_lock" );
}

call_in_attack_heli( var_0, var_1 )
{
    level endon( "game_ended" );
    level._ID16580 = 1200;
    level._ID16622 = 1200;
    var_2 = _ID14334();
    var_3 = var_2 + ( 0, 0, level._ID16580 );
    var_4 = level._ID16622 * ( 0, 1, 0 );
    var_5 = ( 0, 8000, 0 );
    var_6 = var_3 + var_4;
    var_7 = var_3 + var_5;
    level._ID4063 = heli_setup( level.players[0], var_7, var_6 );
    level._ID4063 endon( "convert_to_hive_heli" );
    level._ID4063 thread heli_turret_think();
    level._ID4063 thread _ID16591();

    if ( isdefined( var_1 ) )
        level._ID4063._ID26269 = var_1;

    level._ID4063 _ID16583( var_6, 60 );
    level._ID4063 maps\mp\alien\_music_and_dialog::_ID24661();
    wait 1;
    level._ID4063 notify( "weapons_free" );
    playfxontag( level._ID1644["alien_heli_spotlight"], level._ID4063, "tag_flash" );
    level._ID4063 _ID16619( var_0, 0, ::get_player_loop_center, undefined, 28 );
    stopfxontag( level._ID1644["alien_heli_spotlight"], level._ID4063, "tag_flash" );
    level._ID4063 thread _ID16565( var_7 );
}

call_in_hive_heli( var_0 )
{
    level endon( "game_ended" );
    common_scripts\utility::_ID13189( "evade" );
    var_1 = var_0.origin;
    level._ID16580 = 2200;
    level._ID16622 = 1200;
    var_2 = _ID14334();
    var_3 = var_2 + ( 0, 0, 1200 );
    var_4 = level._ID16622 * ( 0, 1, 0 );
    var_5 = ( 0, 8000, 0 );
    var_6 = var_3 + var_4;
    var_7 = var_3 + var_5;
    var_8 = 60;

    if ( isdefined( level._ID4063 ) )
    {
        level._ID4063 notify( "convert_to_hive_heli" );
        stopfxontag( level._ID1644["alien_heli_spotlight"], level._ID4063, "tag_flash" );
        var_8 = 40;
        wait 0.5;
        level._ID17030 = level._ID4063;
    }
    else
    {
        level._ID17030 = heli_setup( level.players[0], var_7, var_6 );
        level._ID17030 makevehiclesolidsphere( 192 );
        level._ID17030 thread _ID16591();
    }

    if ( level._ID17030 maps\mp\alien\_unk1464::ent_flag_exist( "assault_ready" ) )
        level._ID17030 maps\mp\alien\_unk1464::_ID12100( "assault_ready" );
    else
        level._ID17030 maps\mp\alien\_unk1464::_ID12103( "assault_ready" );

    level._ID17030 sethoverparams( 60, 30, 20 );
    level._ID17030 setyawspeed( 50, 50 );
    level._ID17030._ID22048 = 1;
    level._ID17030.health = 5000000;
    level._ID17030.maxhealth = 5000000;
    level._ID17030._ID12267 = 350;
    level._ID17030 setcandamage( 1 );
    level._ID17030 thread _ID16602();
    level._ID17030 makeentitysentient( "allies" );
    level._ID17030 setthreatbiasgroup( "hive_heli" );
    level._ID17030.damagecallback = ::callback_vehicledamage;
    level._ID17030 thread maps\mp\alien\_hud::blocker_hive_chopper_hp_bar();
    var_9 = missile_createattractorent( level._ID17030, 1000, 8000 );
    level._ID17030 _ID16583( var_6, var_8 );
    playfxontag( level._ID1644["alien_heli_spotlight"], level._ID17030, "tag_flash" );

    foreach ( var_11 in level.players )
    {
        if ( !isalive( var_11 ) )
            continue;

        var_12 = randomfloatrange( 2.5, 4 );

        while ( var_12 >= 0 && isdefined( var_11 ) && isalive( var_11 ) )
        {
            level._ID17030 setturrettargetvec( var_11.origin );
            var_12 -= 0.05;
            wait 0.05;
        }
    }

    level._ID17030 maps\mp\alien\_unk1464::_ID12104( "assault_ready" );
    level._ID17030 thread heli_turret_think( var_0, 3 );
    level._ID17030 notify( "weapons_free" );
    level._ID17030 thread _ID12564( var_0 );
    level._ID17030 _ID17031();

    if ( common_scripts\utility::_ID13177( "evade" ) )
    {
        common_scripts\utility::_ID13180( "evade" );
        playfxontag( level._ID1644["alien_heli_spotlight"], level._ID17030, "tag_flash" );
    }

    level._ID17030 clearlookatent();

    if ( level._ID17030.health < 1 )
    {

    }
    else
    {
        level._ID17030 maps\mp\alien\_music_and_dialog::_ID24664();
        level._ID17030 _ID16583( var_1 + ( 0, 0, 600 ), 20 );
        thread _ID30685( var_1 );
        level._ID17030 _ID16583( var_1 + ( 0, 0, 1200 ), 20 );
    }

    level._ID17030 _ID16619( 2, 0, ::get_player_loop_center, "alien_cycle_started", 28 );
    stopfxontag( level._ID1644["alien_heli_spotlight"], level._ID17030, "tag_flash" );
    level._ID17030 thread _ID16565( var_7 );
    wait 3;
    level._ID17030 maps\mp\alien\_music_and_dialog::_ID24662();
}

_ID17031()
{
    self endon( "death" );
    level endon( "blocker_hive_destroyed" );
    var_0 = [];
    var_0 = common_scripts\utility::_ID15386( "assault_hover_" + _ID36640::_ID14323(), "targetname" );
    var_1 = 10;
    var_2 = 0;

    for (;;)
    {
        setthreatbias( "hive_heli", "spitters", 10000 );

        if ( var_2 < 4 )
        {
            var_2++;
            var_3 = var_0[randomint( var_0.size )].origin;
            _ID16583( var_3, 20 );
        }
        else
        {
            var_2 = 0;
            _ID16619( 1, 0, ::_ID14296, "blocker_hive_destroyed", 35 );

            if ( !common_scripts\utility::_ID13177( "evade" ) )
                continue;
        }

        if ( !common_scripts\utility::_ID13177( "evade" ) )
            common_scripts\utility::_ID35637( var_1, "evade" );

        if ( common_scripts\utility::_ID13177( "evade" ) )
        {
            setignoremegroup( "hive_heli", "spitters" );
            stopfxontag( level._ID1644["alien_heli_spotlight"], level._ID17030, "tag_flash" );

            if ( !maps\mp\alien\_unk1464::_ID18426() )
                _ID16619( 4, 0, ::_ID14296, "blocker_hive_destroyed", 35 );
            else
                _ID16619( 6, 0, ::_ID14296, "blocker_hive_destroyed", 35 );

            common_scripts\utility::_ID13180( "evade" );
            playfxontag( level._ID1644["alien_heli_spotlight"], level._ID17030, "tag_flash" );
        }

        wait 0.05;
    }
}

_ID16602()
{
    level endon( "blocker_hive_destroyed" );
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = self.health;
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;

    for (;;)
    {
        var_1 += var_0 - self.health;

        if ( self.health != var_0 )
        {
            var_4 = var_0 - self.health;
            _ID36632::_ID37443( var_4 );
            var_0 = self.health;
            var_2++;

            if ( var_2 >= 4 )
            {
                maps\mp\alien\_music_and_dialog::_ID24667();
                var_2 = 0;
                self notify( "evade" );
                wait 2;
            }
        }

        if ( var_1 >= self._ID12267 )
        {
            maps\mp\alien\_music_and_dialog::_ID24668();
            var_1 = 0;
            common_scripts\utility::flag_set( "evade" );
            self notify( "evade" );
            self notify( "new_flight_path" );
        }

        if ( common_scripts\utility::_ID13177( "evade" ) )
            common_scripts\utility::_ID13216( "evade" );

        wait 0.5;
    }
}

_ID12564( var_0 )
{
    level endon( "blocker_hive_destroyed" );
    self endon( "death" );
    level endon( "game_ended" );
    wait 3;

    while ( isdefined( var_0 ) && isdefined( self ) )
    {
        if ( !common_scripts\utility::_ID13177( "evade" ) )
        {
            var_1 = var_0.origin - self.origin;
            var_2 = vectortoangles( var_1 );
            self setlookatent( var_0 );
        }
        else
            self clearlookatent();

        wait 1;
    }
}

_ID14296()
{
    var_0 = "assault_loop_" + _ID36640::_ID14323();
    var_1 = common_scripts\utility::_ID15384( var_0, "targetname" );

    if ( common_scripts\utility::flag_exist( "evade" ) && common_scripts\utility::_ID13177( "evade" ) )
        return var_1.origin + ( 0, 0, 600 );
    else
        return var_1.origin;
}

_ID30685( var_0 )
{
    level endon( "game_ended" );
    level endon( "new_chaos_airdrop" );
    var_0 = common_scripts\utility::drop_to_ground( var_0, 32, -128 );

    if ( _ID36640::_ID14323() == 1 )
    {
        var_1 = "deployable_currency";
        var_2 = 1;
    }
    else
    {
        var_1 = "deployable_currency";
        var_2 = 2;
    }

    var_3 = level.players[randomint( level.players.size )];
    var_3._ID32641 = var_2;
    var_4 = maps\mp\alien\_deployablebox::_ID8395( var_1, var_0, var_3 );
    var_4._ID34651 = var_2;
    var_4.air_dropped = 1;
    wait 0.05;
    var_4 thread maps\mp\alien\_deployablebox::box_setactive( 1 );
}

face_players()
{
    self endon( "extract" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = _ID14334();
        var_1 = var_0 - self.origin;
        var_2 = vectortoangles( var_1 );
        self setgoalyaw( var_2[1] );
        wait 1;
    }
}

_ID16565( var_0, var_1 )
{
    self notify( "new_flight_path" );
    self notify( "heli_exiting" );
    self endon( "heli_exiting" );
    self endon( "convert_to_hive_heli" );
    wait 0.05;
    self notify( "stop_turret" );
    _ID16583( var_0, 60 );

    if ( !isdefined( var_1 ) || !var_1 )
        self delete();
}

heli_setup( var_0, var_1, var_2 )
{
    var_3 = vectortoangles( var_2 - var_1 );
    var_4 = spawnhelicopter( var_0, var_1, var_3, "nh90_alien", "vehicle_nh90_interior2" );

    if ( !isdefined( var_4 ) )
        return;

    var_4.health = 999999;
    var_4.maxhealth = 500;
    var_4.damagetaken = 0;
    var_4.team = "allies";
    var_4 setcandamage( 0 );
    var_4 setyawspeed( 80, 60 );
    var_4 setmaxpitchroll( 30, 30 );
    var_4 sethoverparams( 10, 10, 60 );
    var_4 setvehweapon( "cobra_20mm_alien" );
    var_4._ID13034 = weaponfiretime( "cobra_20mm_alien" );
    return var_4;
}

_ID16591()
{
    playfxontag( level._ID1644["cockpit_blue_cargo01"], self, "tag_light_cargo01" );
    playfxontag( level._ID1644["cockpit_blue_cockpit01"], self, "tag_light_cockpit01" );
    wait 0.05;
    playfxontag( level._ID1644["white_blink"], self, "tag_light_belly" );
    playfxontag( level._ID1644["white_blink_tail"], self, "tag_light_tail" );
    wait 0.05;
    playfxontag( level._ID1644["wingtip_green"], self, "tag_light_L_wing" );
    playfxontag( level._ID1644["wingtip_red"], self, "tag_light_R_wing" );
}

heli_turret_think( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "stop_turret" );
    self endon( "convert_to_hive_heli" );
    self waittill( "weapons_free" );

    while ( isdefined( self ) && isalive( self ) )
    {
        var_2 = _ID14697( var_0, var_1 );

        if ( !isdefined( var_2 ) || !isalive( var_2 ) )
        {
            setomnvar( "ui_alien_chopper_state", 0 );
            wait 1;
            continue;
        }

        if ( common_scripts\utility::flag_exist( "evade" ) && common_scripts\utility::_ID13177( "evade" ) )
        {
            setomnvar( "ui_alien_chopper_state", 1 );
            wait 1;
            continue;
        }

        self setturrettargetvec( var_2.origin + ( 0, 0, 16 ) );
        common_scripts\utility::waittill_notify_or_timeout( "turret_on_target", 4 );

        if ( isdefined( var_2 ) && isdefined( var_0 ) && var_2 == var_0 )
        {
            setomnvar( "ui_alien_chopper_state", 2 );
            setomnvar( "ui_alien_boss_status", 2 );
        }

        var_3 = 30 + randomintrange( 0, 20 ) - 5;

        for ( var_4 = 0; var_4 < var_3; var_4++ )
        {
            if ( !isdefined( var_2 ) || !isalive( var_2 ) )
                break;

            var_5 = ( 0, 0, 16 );
            self setturrettargetvec( var_2.origin + var_5 );
            self fireweapon( "tag_flash", var_2, ( 0, 0, 0 ) );
            wait(self._ID13034);
        }

        wait(randomfloatrange( 1, 3.5 ));
    }
}

_ID14697( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in level.agentarray )
    {
        if ( !isdefined( var_4.allowvehicledamage ) )
            var_4.allowvehicledamage = 1;

        if ( var_4.team != "axis" )
            continue;

        if ( !isalive( var_4 ) )
            continue;

        if ( distance( var_4.origin, self.origin ) > 2500 )
            continue;

        var_5 = gettime() - var_4.birthtime;

        if ( var_5 < 4000 )
            continue;

        var_2[var_2.size] = var_4;
    }

    if ( var_2.size > 0 )
    {
        var_2 = sortbydistance( var_2, self.origin );

        if ( isdefined( var_0 ) )
        {
            var_7 = distance( var_2[0].origin, self.origin );
            var_8 = distance( var_0.origin, self.origin );

            if ( var_7 >= var_8 / var_1 )
                return var_0;
        }

        return var_2[0];
    }
    else
    {
        if ( isdefined( var_0 ) )
            return var_0;

        return undefined;
    }
}

_ID16583( var_0, var_1, var_2 )
{
    self notify( "new_flight_path" );
    self endon( "new_flight_path" );
    self endon( "convert_to_hive_heli" );

    if ( isdefined( var_2 ) )
        level endon( var_2 );

    self vehicle_setspeed( var_1, var_1 * 0.75, var_1 * 0.75 );
    self setvehgoalpos( var_0, 1 );
    debug_line( self.origin, var_0, ( 0, 0.5, 1 ), 200 );

    if ( isdefined( self.near_goal ) && self.near_goal )
        self waittill( "near_goal" );
    else
        self waittill( "goal" );
}

_ID16619( var_0, var_1, var_2, var_3, var_4 )
{
    self notify( "new_flight_path" );
    self endon( "new_flight_path" );
    self endon( "death" );
    self endon( "convert_to_hive_heli" );

    if ( isdefined( var_3 ) )
    {
        level endon( var_3 );
        self endon( var_3 );
    }

    var_5 = 12;

    if ( isdefined( var_1 ) && var_1 )
        var_5 *= -1;

    var_6 = 0;
    var_7 = ( 0, level._ID16622, 0 );
    var_8 = 30;

    if ( isdefined( var_4 ) )
        var_8 = var_4;

    var_9 = self.origin;
    var_10 = var_9;
    var_11 = [[ var_2 ]]();

    while ( var_0 > 0 && self.health > 0 )
    {
        var_12 = rotatevector( var_7, ( 0, var_6, 0 ) );
        var_6 += var_5;

        if ( var_6 >= 360 )
        {
            var_11 = [[ var_2 ]]();
            var_6 = 0;
            var_0--;
        }

        var_9 = var_10;
        var_10 = var_11 + var_12;
        self vehicle_setspeed( var_8, var_8, var_8 );
        self setvehgoalpos( var_10, 0 );
        debug_line( var_9, var_10, ( 0, 0.5, 1 ), 100 );
        var_13 = abs( level._ID16622 * sin( var_5 ) );
        var_14 = _ID14802( var_13, var_8 );
        var_15 = 0.1;
        wait(var_14 * ( 1 - var_15 ));
    }
}

get_drop_loop_center()
{
    return self.drop_loc + ( 0, 0, level._ID16580 );
}

_ID14434()
{
    return ( -10251, 6937, level._ID16580 + 400 );
}

get_player_loop_center()
{
    var_0 = _ID14334();
    return var_0 + ( 0, 0, level._ID16580 );
}

_ID14802( var_0, var_1 )
{
    var_2 = var_1 * 17.6;
    var_3 = var_0 / var_2;
    return var_3;
}

debug_line( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( level._ID16552 ) && level._ID16552 == 1.0 && !isdefined( var_3 ) )
        thread _ID10843( var_0, var_1, var_2 );
    else if ( isdefined( level._ID16552 ) && level._ID16552 == 1.0 )
        thread _ID10843( var_0, var_1, var_2, var_3 );
}

_ID10843( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_3 ) )
    {
        for ( var_4 = 0; var_4 < var_3; var_4++ )
            wait 0.05;
    }
    else
    {
        for (;;)
            wait 0.05;
    }
}

_ID18527( var_0, var_1 )
{
    return var_0._ID36301 < var_1._ID36301;
}

_ID14334( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    var_1 = 0;
    var_2 = 0;
    var_3 = 0;

    foreach ( var_5 in level.players )
    {
        var_1 += var_5.origin[0];
        var_2 += var_5.origin[1];
        var_3 += ( var_5.origin[2] + var_0 );
    }

    var_7 = max( 1, level.players.size );
    var_8 = ( var_1 / var_7, var_2 / var_7, var_3 / var_7 );
    return var_8;
}

_ID25698( var_0, var_1, var_2 )
{
    if ( !isdefined( level._ID6913 ) )
        level._ID6913 = [];

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = level._ID6913.size;
        level._ID6913[var_4] = [];
        level._ID6913[var_4][0] = var_0;
        level._ID6913[var_4][1] = var_1;
    }
}

_ID14703()
{
    return level._ID6913[randomint( level._ID6913.size )];
}

callback_vehicledamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    if ( !isplayer( var_1 ) && isdefined( var_1.owner ) && isplayer( var_1.owner ) )
        var_1 = var_1.owner;

    if ( var_1 == self || isdefined( var_1.pers ) && var_1.pers["team"] == self.team && level._ID32653 )
        return;

    if ( self.health <= 0 )
        return;

    if ( isdefined( self._ID12267 ) && self.health - var_2 <= self._ID12267 && ( !isdefined( self._ID30272 ) || !self._ID30272 ) )
    {
        thread _ID23896();
        self._ID30272 = 1;
    }

    self vehicle_finishdamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );
}

_ID23896()
{
    self endon( "death" );
    wait 0.15;
    playfxontag( level._ID1644["harrier_heavy_smoke"], self, "tag_engine_left" );
}

airdrop_reward()
{
    if ( !isdefined( level.chaos_airdrop_locs ) || level.chaos_airdrop_locs.size == 0 )
        return;

    level notify( "new_chaos_airdrop" );
    var_0 = get_chaos_airdrop_loc();
    thread _ID31396( var_0._ID32036[0] );
    thread spawn_random_airdrop_sub_items( var_0._ID32036 );
    var_0._ID36301++;
}

_ID28256( var_0, var_1 )
{
    level endon( "game_ended" );
    level endon( "new_chaos_airdrop" );

    if ( isdefined( level.airdrop_icon ) )
        level.airdrop_icon destroy();

    level.airdrop_icon = newhudelem();
    level.airdrop_icon setshader( "waypoint_ammo", 14, 14 );
    level.airdrop_icon.alpha = 1;
    level.airdrop_icon.color = ( 1, 1, 1 );
    level.airdrop_icon setwaypoint( 1, 1 );
    level.airdrop_icon.x = var_0[0];
    level.airdrop_icon.y = var_0[1];
    level.airdrop_icon.z = var_0[2];
    wait(var_1);

    if ( isdefined( level.airdrop_icon ) )
        level.airdrop_icon destroy();
}

get_chaos_airdrop_loc()
{
    var_0 = 3000;
    var_1 = _ID14334();
    var_2 = level.chaos_airdrop_locs;
    var_2 = sortbydistance( var_2, var_1 );
    var_3 = [];

    foreach ( var_5 in var_2 )
    {
        if ( distance( var_5.origin, var_1 ) > var_0 )
            var_3[var_3.size] = var_5;
    }

    var_7 = 4;
    var_8 = [];

    for ( var_9 = 0; var_9 < 4; var_9++ )
    {
        if ( !isdefined( var_3[var_9] ) )
            break;

        var_8[var_9] = var_3[var_9];
    }

    var_10 = common_scripts\utility::_ID3855( var_8, ::_ID18527 );
    return var_10[0];
}

_ID31396( var_0 )
{
    level endon( "game_ended" );
    level endon( "new_chaos_airdrop" );
    call_in_airdrop_heli( var_0, 3, 3 );
    wait 2;
    level notify( "chaos_airdrop_landed" );
}

spawn_random_airdrop_sub_items( var_0 )
{
    level endon( "game_ended" );
    level endon( "new_chaos_airdrop" );
    level waittill( "chaos_airdrop_landed" );
    var_1 = 0;

    foreach ( var_3 in var_0 )
    {
        if ( var_1 >= level._ID6913.size )
            var_1 = 0;

        var_4 = level._ID6913[var_1][0];
        var_5 = level._ID6913[var_1][1];
        var_6 = level.players[randomint( level.players.size )];
        var_6._ID32641 = var_5;

        if ( var_4 == "deployable_currency" )
            var_3 += ( 0, 0, 16 );

        var_7 = maps\mp\killstreaks\_deployablebox::_ID8395( var_4, var_3, var_6 );
        var_7._ID34651 = var_5;
        var_7.air_dropped = 1;
        wait 0.05;
        var_7 thread maps\mp\killstreaks\_deployablebox::box_setactive( 1 );
        var_1++;
    }
}

call_in_airdrop_heli( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    level._ID16580 = 1500;
    level._ID16622 = 1200;
    var_3 = _ID14334();
    var_4 = var_3 + ( 0, 0, level._ID16580 );
    var_5 = var_0 + ( 0, 0, level._ID16580 );
    var_6 = level._ID16622 * ( 0, 1, 0 );
    var_7 = ( 0, 8000, 0 );
    var_8 = var_4 + var_6;
    var_9 = var_4 + var_7;
    level.airdrop_heli = heli_setup( level.players[0], var_9, var_8 );
    level.airdrop_heli thread heli_turret_think();
    level.airdrop_heli thread _ID16591();
    level.airdrop_heli.drop_loc = var_0;
    level.airdrop_heli _ID16583( var_8, 60 );
    wait 1;
    level.airdrop_heli notify( "weapons_free" );
    level.airdrop_heli _ID16619( var_1, 0, ::get_player_loop_center );
    level.airdrop_heli _ID16619( var_2, 0, ::get_drop_loop_center );
    level.airdrop_heli _ID16583( var_5, 30 );
    var_10 = var_0 + ( 0, 0, 450 );
    level.airdrop_heli _ID16583( var_10, 30 );
    level.airdrop_heli thread _ID16565( var_9 );
}

_ID17699()
{
    level.chaos_airdrop_locs = common_scripts\utility::_ID15386( "chaos_airdrop", "targetname" );

    if ( !isdefined( level.chaos_airdrop_locs ) || level.chaos_airdrop_locs.size == 0 )
        return;

    foreach ( var_1 in level.chaos_airdrop_locs )
    {
        var_1._ID32036 = [];
        var_1._ID32036[0] = var_1.origin;
        var_2 = common_scripts\utility::_ID15386( var_1.target, "targetname" );

        foreach ( var_4 in var_2 )
            var_1._ID32036[var_1._ID32036.size] = var_4.origin;

        var_1._ID36301 = 0;
    }

    register_airdrop_sub_items();
}

_ID32848()
{
    level._ID16552 = 1;
    wait 5;
    level thread airdrop_reward();
}

test_attack_heli()
{
    level._ID16552 = 1;
    wait 5;
    level thread call_in_attack_heli( 10 );
}

register_airdrop_sub_items()
{
    _ID25698( "deployable_currency", 4, 1 );
    _ID25698( "deployable_ammo", 4, 1 );
}

sfx_rescue_heli_flyin( var_0 )
{
    var_0 playsound( "alien_heli_rescue_dz_flyin" );
    wait 1;
    var_0 vehicle_turnengineoff();
    wait 1.6;
    level.heli_lp = spawn( "script_origin", var_0.origin );
    level.heli_lp linkto( var_0 );
    level.heli_lp playloopsound( "alien_heli_rescue_dz_engine_lp" );
}

_ID29513( var_0 )
{
    level.player playsound( "alien_heli_rescue_exfil_lr" );
    wait 1;
    level.heli_lp stoploopsound( "alien_heli_rescue_dz_engine_lp" );
    wait 5;
    level._ID16562 = spawn( "script_origin", var_0.origin );
    level._ID16562 linkto( var_0 );
    level._ID16562 playloopsound( "alien_heli_exfil_engine_lp" );
    wait 18;
    level._ID16562 stoploopsound( "alien_heli_exfil_engine_lp" );
}

inbound_chopper_text()
{
    foreach ( var_1 in level.players )
    {
        var_1 thread show_blocker_hive_hint_text( &"ALIENS_BLOCKER_HIVE_HINT" );
        var_1 thread show_drill_hint();
    }
}

show_blocker_hive_hint_text( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );

    while ( isdefined( self._ID34726 ) )
        wait 0.1;

    var_1 = 1.5;
    var_2 = "objective";

    if ( level.splitscreen )
        var_1 = 1.2;

    self._ID34726 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext( 0, -50, var_1, var_2 );
    self._ID34726 settext( var_0 );
    self._ID34726 setpulsefx( 50, 5000, 800 );
    wait 6;
    self._ID34726 maps\mp\gametypes\_hud_util::destroyelem();
    self._ID34726 = undefined;
}

show_drill_hint()
{
    self endon( "disconnect" );
    var_0 = 122500;

    while ( is_blocker_alive() )
    {
        if ( isdefined( level.current_blocker_hive ) && isdefined( level.drill_carrier ) && level.drill_carrier == self )
        {
            if ( distancesquared( self.origin, level.current_blocker_hive.origin ) < var_0 && isdefined( level.drill_carrier ) && level.drill_carrier == self )
                maps\mp\_utility::setlowermessage( "hive_drill_hint", &"ALIENS_BLOCKER_HIVE_DRILL_HINT" );

            while ( is_blocker_alive() && ( distancesquared( self.origin, level.current_blocker_hive.origin ) < var_0 && isdefined( level.drill_carrier ) && level.drill_carrier == self ) )
                wait 0.25;

            maps\mp\_utility::_ID7495( "hive_drill_hint" );
        }

        wait 0.5;
    }
}

is_blocker_alive()
{
    if ( !common_scripts\utility::flag_exist( "blocker_hive_destroyed" ) )
        return 0;

    return !common_scripts\utility::_ID13177( "blocker_hive_destroyed" ) && isdefined( level.current_blocker_hive );
}
