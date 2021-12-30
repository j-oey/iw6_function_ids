// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    game["music"]["spawn_allies"] = "mus_us_spawn";
    game["music"]["defeat_allies"] = "mus_us_defeat";
    game["music"]["victory_allies"] = "mus_us_victory";
    game["music"]["winning_allies"] = "mus_us_winning";
    game["music"]["losing_allies"] = "mus_us_losing";
    game["voice"]["allies"] = maps\mp\gametypes\_teams::getteamvoiceprefix( "allies" ) + "1mc_";
    game["music"]["allies_used_nuke"] = "mus_us_nuke_fired";
    game["music"]["allies_hit_by_nuke"] = "mus_us_nuke_hit";
    game["music"]["draw_allies"] = "mus_us_draw";
    game["music"]["spawn_axis"] = "mus_fd_spawn";
    game["music"]["defeat_axis"] = "mus_fd_defeat";
    game["music"]["victory_axis"] = "mus_fd_victory";
    game["music"]["winning_axis"] = "mus_fd_winning";
    game["music"]["losing_axis"] = "mus_fd_losing";
    game["voice"]["axis"] = maps\mp\gametypes\_teams::getteamvoiceprefix( "axis" ) + "1mc_";
    game["music"]["axis_used_nuke"] = "mus_fd_nuke_fired";
    game["music"]["axis_hit_by_nuke"] = "mus_fd_nuke_hit";
    game["music"]["draw_axis"] = "mus_fd_draw";
    game["music"]["losing_time"] = "mp_time_running_out_losing";
    game["music"]["allies_suspense"] = [];
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_01";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_02";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_03";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_04";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_05";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_06";
    game["music"]["axis_suspense"] = [];
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_01";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_02";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_03";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_04";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_05";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_06";
    game["dialog"]["mission_success"] = "mission_success";
    game["dialog"]["mission_failure"] = "mission_fail";
    game["dialog"]["mission_draw"] = "draw";
    game["dialog"]["round_success"] = "encourage_win";
    game["dialog"]["round_failure"] = "encourage_lost";
    game["dialog"]["round_draw"] = "draw";
    game["dialog"]["timesup"] = "timesup";
    game["dialog"]["winning_time"] = "winning";
    game["dialog"]["losing_time"] = "losing";
    game["dialog"]["winning_score"] = "winning_fight";
    game["dialog"]["losing_score"] = "losing_fight";
    game["dialog"]["lead_lost"] = "lead_lost";
    game["dialog"]["lead_tied"] = "tied";
    game["dialog"]["lead_taken"] = "lead_taken";
    game["dialog"]["last_alive"] = "lastalive";
    game["dialog"]["boost"] = "boost";

    if ( !isdefined( game["dialog"]["offense_obj"] ) )
        game["dialog"]["offense_obj"] = "boost";

    if ( !isdefined( game["dialog"]["defense_obj"] ) )
        game["dialog"]["defense_obj"] = "boost";

    game["dialog"]["hardcore"] = "hardcore";
    game["dialog"]["highspeed"] = "highspeed";
    game["dialog"]["tactical"] = "tactical";
    game["dialog"]["challenge"] = "challengecomplete";
    game["dialog"]["promotion"] = "promotion";
    game["dialog"]["bomb_taken"] = "acheive_bomb";
    game["dialog"]["bomb_lost"] = "bomb_taken";
    game["dialog"]["bomb_defused"] = "bomb_defused";
    game["dialog"]["bomb_defused_axis"] = "bomb_defused_axis";
    game["dialog"]["bomb_defused_allies"] = "bomb_defused_allies";
    game["dialog"]["bomb_planted"] = "bomb_planted";
    game["dialog"]["obj_taken"] = "securedobj";
    game["dialog"]["obj_lost"] = "lostobj";
    game["dialog"]["obj_defend"] = "obj_defend";
    game["dialog"]["obj_destroy"] = "obj_destroy";
    game["dialog"]["obj_capture"] = "capture_obj";
    game["dialog"]["objs_capture"] = "capture_objs";
    game["dialog"]["hq_located"] = "hq_located";
    game["dialog"]["hq_enemy_captured"] = "hq_captured";
    game["dialog"]["hq_enemy_destroyed"] = "hq_destroyed";
    game["dialog"]["hq_secured"] = "hq_secured";
    game["dialog"]["hq_offline"] = "hq_offline";
    game["dialog"]["hq_online"] = "hq_online";
    game["dialog"]["move_to_new"] = "new_positions";
    game["dialog"]["push_forward"] = "pushforward";
    game["dialog"]["attack"] = "attack";
    game["dialog"]["defend"] = "defend";
    game["dialog"]["offense"] = "offense";
    game["dialog"]["defense"] = "defense";
    game["dialog"]["halftime"] = "halftime";
    game["dialog"]["overtime"] = "overtime";
    game["dialog"]["side_switch"] = "switching";
    game["dialog"]["flag_taken"] = "ourflag";
    game["dialog"]["flag_dropped"] = "ourflag_drop";
    game["dialog"]["flag_returned"] = "ourflag_return";
    game["dialog"]["flag_captured"] = "ourflag_capt";
    game["dialog"]["flag_getback"] = "getback_ourflag";
    game["dialog"]["enemy_flag_bringhome"] = "enemyflag_tobase";
    game["dialog"]["enemy_flag_taken"] = "enemyflag";
    game["dialog"]["enemy_flag_dropped"] = "enemyflag_drop";
    game["dialog"]["enemy_flag_returned"] = "enemyflag_return";
    game["dialog"]["enemy_flag_captured"] = "enemyflag_capt";
    game["dialog"]["got_flag"] = "achieve_flag";
    game["dialog"]["dropped_flag"] = "lost_flag";
    game["dialog"]["enemy_got_flag"] = "enemy_has_flag";
    game["dialog"]["enemy_dropped_flag"] = "enemy_dropped_flag";
    game["dialog"]["capturing_a"] = "capturing_a";
    game["dialog"]["capturing_b"] = "capturing_b";
    game["dialog"]["capturing_c"] = "capturing_c";
    game["dialog"]["captured_a"] = "capture_a";
    game["dialog"]["captured_b"] = "capture_c";
    game["dialog"]["captured_c"] = "capture_b";
    game["dialog"]["securing_a"] = "securing_a";
    game["dialog"]["securing_b"] = "securing_b";
    game["dialog"]["securing_c"] = "securing_c";
    game["dialog"]["secured_a"] = "secure_a";
    game["dialog"]["secured_b"] = "secure_b";
    game["dialog"]["secured_c"] = "secure_c";
    game["dialog"]["losing_a"] = "losing_a";
    game["dialog"]["losing_b"] = "losing_b";
    game["dialog"]["losing_c"] = "losing_c";
    game["dialog"]["lost_a"] = "lost_a";
    game["dialog"]["lost_b"] = "lost_b";
    game["dialog"]["lost_c"] = "lost_c";
    game["dialog"]["enemy_taking_a"] = "enemy_take_a";
    game["dialog"]["enemy_taking_b"] = "enemy_take_b";
    game["dialog"]["enemy_taking_c"] = "enemy_take_c";
    game["dialog"]["enemy_has_a"] = "enemy_has_a";
    game["dialog"]["enemy_has_b"] = "enemy_has_b";
    game["dialog"]["enemy_has_c"] = "enemy_has_c";
    game["dialog"]["lost_all"] = "take_positions";
    game["dialog"]["secure_all"] = "positions_lock";
    game["dialog"]["losing_target"] = "enemy_capture";
    game["dialog"]["lost_target"] = "lost_target";
    game["dialog"]["taking_target"] = "capturing_target";
    game["dialog"]["took_target"] = "achieve_target";
    game["dialog"]["defcon_raised"] = "defcon_raised";
    game["dialog"]["defcon_lowered"] = "defcon_lowered";
    game["dialog"]["one_minute_left"] = "one_minute";
    game["dialog"]["thirty_seconds_left"] = "thirty_seconds";
    game["music"]["nuke_music"] = "nuke_music";
    game["dialog"]["sentry_destroyed"] = "sentry_destroyed";
    game["dialog"]["sentry_gone"] = "sentry_gone";
    game["dialog"]["ti_destroyed"] = "ti_blocked";
    game["dialog"]["ti_gone"] = "ti_cancelled";
    game["dialog"]["ims_destroyed"] = "ims_destroyed";
    game["dialog"]["satcom_destroyed"] = "satcom_destroyed";
    game["dialog"]["ballistic_vest_destroyed"] = "ballistic_vest_destroyed";
    game["dialog"]["ammocrate_destroyed"] = "ammocrate_destroyed";
    game["dialog"]["ammocrate_gone"] = "ammocrate_gone";
    game["dialog"]["achieve_carepackage"] = "achieve_carepackage";
    game["dialog"]["gryphon_destroyed"] = "gryphon_destroyed";
    game["dialog"]["gryphon_gone"] = "gryphon_gone";
    game["dialog"]["vulture_destroyed"] = "vulture_destroyed";
    game["dialog"]["vulture_gone"] = "vulture_gone";
    game["dialog"]["nowl_destroyed"] = "nowl_destroyed";
    game["dialog"]["nowl_gone"] = "nowl_gone";
    game["dialog"]["oracle_gone"] = "oracle_gone";
    game["dialog"]["dog_gone"] = "dog_gone";
    game["dialog"]["dog_killed"] = "dog_killed";
    game["dialog"]["squad_gone"] = "squad_gone";
    game["dialog"]["squad_killed"] = "squad_killed";
    game["dialog"]["odin_gone"] = "odin_gone";
    game["dialog"]["odin_carepackage"] = "odin_carepackage";
    game["dialog"]["odin_marking"] = "odin_marking";
    game["dialog"]["odin_marked"] = "odin_marked";
    game["dialog"]["odin_m_marked"] = "odin_m_marked";
    game["dialog"]["odin_smoke"] = "odin_smoke";
    game["dialog"]["odin_moving"] = "odin_moving";
    game["dialog"]["loki_gone"] = "loki_gone";
    game["dialog"]["odin_target_killed"] = "odin_target_killed";
    game["dialog"]["odin_targets_killed"] = "odin_targets_killed";
    game["dialog"]["claymore_destroyed"] = "null";
    game["dialog"]["mine_destroyed"] = "null";
    level thread _ID22877();
    level thread _ID22858();
    level thread _ID21827();
    level thread _ID22847();
    level thread _ID22896();
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread onplayerspawned();
        var_0 thread finalkillcammusic();
        var_0 thread watchhostmigration();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    if ( !isai( self ) )
    {
        self waittill( "spawned_player" );
        thread dointro();
        return;
    }
}

dointro()
{
    level endon( "host_migration_begin" );

    if ( !level.splitscreen || level.splitscreen && !isdefined( level._ID23902 ) )
    {
        if ( !self issplitscreenplayer() || self issplitscreenplayerprimary() )
            self playlocalsound( game["music"]["spawn_" + self.team] );

        if ( level.splitscreen )
            level._ID23902 = 1;
    }

    if ( isdefined( game["dialog"]["gametype"] ) && ( !level.splitscreen || self == level.players[0] ) )
    {
        if ( isdefined( game["dialog"]["allies_gametype"] ) && self.team == "allies" )
            maps\mp\_utility::_ID19765( "allies_gametype" );
        else if ( isdefined( game["dialog"]["axis_gametype"] ) && self.team == "axis" )
            maps\mp\_utility::_ID19765( "axis_gametype" );
        else if ( !self issplitscreenplayer() || self issplitscreenplayerprimary() )
            maps\mp\_utility::_ID19765( "gametype" );
    }

    maps\mp\_utility::gameflagwait( "prematch_done" );

    if ( !isdefined( self ) )
        return;

    if ( self.team == game["attackers"] )
    {
        if ( !self issplitscreenplayer() || self issplitscreenplayerprimary() )
        {
            maps\mp\_utility::_ID19765( "offense_obj", "introboost" );
            return;
        }

        return;
    }

    if ( !self issplitscreenplayer() || self issplitscreenplayerprimary() )
    {
        maps\mp\_utility::_ID19765( "defense_obj", "introboost" );
        return;
    }

    return;
}

watchhostmigration()
{
    self endon( "disconnect" );
    level endon( "grace_period_ending" );

    for (;;)
    {
        level waittill( "host_migration_begin" );
        var_0 = level._ID17628;
        level waittill( "host_migration_end" );

        if ( var_0 )
            thread dointro();
    }
}

_ID22858()
{
    level endon( "game_ended" );
    level waittill( "last_alive",  var_0  );

    if ( !isalive( var_0 ) )
        return;

    var_0 maps\mp\_utility::_ID19765( "last_alive" );
}

_ID22896()
{
    level waittill( "round_switch",  var_0  );

    switch ( var_0 )
    {
        case "halftime":
            foreach ( var_2 in level.players )
            {
                if ( var_2 issplitscreenplayer() && !var_2 issplitscreenplayerprimary() )
                    continue;

                var_2 maps\mp\_utility::_ID19765( "halftime" );
            }

            break;
        case "overtime":
            foreach ( var_2 in level.players )
            {
                if ( var_2 issplitscreenplayer() && !var_2 issplitscreenplayerprimary() )
                    continue;

                var_2 maps\mp\_utility::_ID19765( "overtime" );
            }

            break;
        default:
            foreach ( var_2 in level.players )
            {
                if ( var_2 issplitscreenplayer() && !var_2 issplitscreenplayerprimary() )
                    continue;

                var_2 maps\mp\_utility::_ID19765( "side_switch" );
            }

            break;
    }
}

_ID22847()
{
    level thread roundwinnerdialog();
    level thread _ID14088();
    level waittill( "game_win",  var_0  );

    if ( level._ID32653 )
    {
        if ( level.splitscreen )
        {
            if ( var_0 == "allies" )
            {
                maps\mp\_utility::_ID24645( game["music"]["victory_allies"], "allies" );
                return;
            }

            if ( var_0 == "axis" )
            {
                maps\mp\_utility::_ID24645( game["music"]["victory_axis"], "axis" );
                return;
            }

            maps\mp\_utility::_ID24645( game["music"]["nuke_music"] );
            return;
            return;
            return;
        }

        if ( var_0 == "allies" )
        {
            maps\mp\_utility::_ID24645( game["music"]["victory_allies"], "allies" );
            maps\mp\_utility::_ID24645( game["music"]["defeat_axis"], "axis" );
            return;
        }

        if ( var_0 == "axis" )
        {
            maps\mp\_utility::_ID24645( game["music"]["victory_axis"], "axis" );
            maps\mp\_utility::_ID24645( game["music"]["defeat_allies"], "allies" );
            return;
        }

        maps\mp\_utility::_ID24645( game["music"]["draw_axis"], "axis" );
        maps\mp\_utility::_ID24645( game["music"]["draw_allies"], "allies" );
        return;
        return;
        return;
        return;
    }

    foreach ( var_2 in level.players )
    {
        if ( var_2 issplitscreenplayer() && !var_2 issplitscreenplayerprimary() )
            continue;

        if ( var_2.pers["team"] != "allies" && var_2.pers["team"] != "axis" )
        {
            var_2 playlocalsound( game["music"]["nuke_music"] );
            continue;
        }

        if ( isdefined( var_0 ) && isplayer( var_0 ) && var_2 == var_0 )
        {
            var_2 playlocalsound( game["music"]["victory_" + var_2.pers["team"]] );
            continue;
        }

        if ( !level.splitscreen )
            var_2 playlocalsound( game["music"]["defeat_" + var_2.pers["team"]] );
    }

    return;
}

roundwinnerdialog()
{
    level waittill( "round_win",  var_0  );
    var_1 = level.roundenddelay / 4;

    if ( var_1 > 0 )
        wait(var_1);

    if ( !isdefined( var_0 ) || isplayer( var_0 ) )
        return;

    if ( var_0 == "allies" )
    {
        maps\mp\_utility::_ID19760( "round_success", "allies" );
        maps\mp\_utility::_ID19760( "round_failure", "axis" );
        return;
    }

    if ( var_0 == "axis" )
    {
        maps\mp\_utility::_ID19760( "round_success", "axis" );
        maps\mp\_utility::_ID19760( "round_failure", "allies" );
        return;
    }

    return;
}

_ID14088()
{
    level waittill( "game_win",  var_0  );
    var_1 = level._ID24793 / 2;

    if ( var_1 > 0 )
        wait(var_1);

    if ( !isdefined( var_0 ) || isplayer( var_0 ) )
        return;

    if ( var_0 == "allies" )
    {
        maps\mp\_utility::_ID19760( "mission_success", "allies" );
        maps\mp\_utility::_ID19760( "mission_failure", "axis" );
        return;
    }

    if ( var_0 == "axis" )
    {
        maps\mp\_utility::_ID19760( "mission_success", "axis" );
        maps\mp\_utility::_ID19760( "mission_failure", "allies" );
        return;
    }

    maps\mp\_utility::_ID19760( "mission_draw" );
    return;
    return;
}

_ID21827()
{
    level endon( "game_ended" );
    level.musicenabled = 1;
    thread _ID32138();
    level waittill( "match_ending_soon",  var_0  );

    if ( maps\mp\_utility::getwatcheddvar( "roundlimit" ) == 1 || game["roundsPlayed"] == maps\mp\_utility::getwatcheddvar( "roundlimit" ) - 1 || maps\mp\_utility::_ID18706() )
    {
        if ( !level.splitscreen )
        {
            if ( var_0 == "time" )
            {
                if ( level._ID32653 )
                {
                    if ( game["teamScores"]["allies"] > game["teamScores"]["axis"] )
                    {
                        if ( ismusicenabled() )
                        {
                            maps\mp\_utility::_ID24645( game["music"]["winning_allies"], "allies" );
                            maps\mp\_utility::_ID24645( game["music"]["losing_axis"], "axis" );
                        }

                        maps\mp\_utility::_ID19760( "winning_time", "allies" );
                        maps\mp\_utility::_ID19760( "losing_time", "axis" );
                    }
                    else if ( game["teamScores"]["axis"] > game["teamScores"]["allies"] )
                    {
                        if ( !level.hardcoremode )
                        {
                            maps\mp\_utility::_ID24645( game["music"]["winning_axis"], "axis" );
                            maps\mp\_utility::_ID24645( game["music"]["losing_allies"], "allies" );
                        }

                        maps\mp\_utility::_ID19760( "winning_time", "axis" );
                        maps\mp\_utility::_ID19760( "losing_time", "allies" );
                    }
                }
                else
                {
                    if ( ismusicenabled() )
                        maps\mp\_utility::_ID24645( game["music"]["losing_time"] );

                    maps\mp\_utility::_ID19760( "timesup" );
                }
            }
            else if ( var_0 == "score" )
            {
                if ( level._ID32653 )
                {
                    if ( game["teamScores"]["allies"] > game["teamScores"]["axis"] )
                    {
                        if ( ismusicenabled() )
                        {
                            maps\mp\_utility::_ID24645( game["music"]["winning_allies"], "allies" );
                            maps\mp\_utility::_ID24645( game["music"]["losing_axis"], "axis" );
                        }

                        maps\mp\_utility::_ID19760( "winning_score", "allies" );
                        maps\mp\_utility::_ID19760( "losing_score", "axis" );
                    }
                    else if ( game["teamScores"]["axis"] > game["teamScores"]["allies"] )
                    {
                        if ( ismusicenabled() )
                        {
                            maps\mp\_utility::_ID24645( game["music"]["winning_axis"], "axis" );
                            maps\mp\_utility::_ID24645( game["music"]["losing_allies"], "allies" );
                        }

                        maps\mp\_utility::_ID19760( "winning_score", "axis" );
                        maps\mp\_utility::_ID19760( "losing_score", "allies" );
                    }
                }
                else
                {
                    var_1 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();
                    var_2 = maps\mp\gametypes\_gamescore::getlosingplayers();
                    var_3[0] = var_1;

                    if ( ismusicenabled() )
                    {
                        var_1 playlocalsound( game["music"]["winning_" + var_1.pers["team"]] );

                        foreach ( var_5 in level.players )
                        {
                            if ( var_5 == var_1 )
                                continue;

                            var_5 playlocalsound( game["music"]["losing_" + var_5.pers["team"]] );
                        }
                    }

                    var_1 maps\mp\_utility::_ID19765( "winning_score" );
                    maps\mp\_utility::_ID19767( "losing_score", var_2 );
                }
            }

            level waittill( "match_ending_very_soon" );
            maps\mp\_utility::_ID19760( "timesup" );
            return;
        }

        return;
    }

    if ( !level.hardcoremode )
        maps\mp\_utility::_ID24645( game["music"]["losing_allies"] );

    maps\mp\_utility::_ID19760( "timesup" );
    return;
}

_ID32138( var_0 )
{
    if ( !ismusicenabled() )
        return;

    level endon( "game_ended" );
    level endon( "match_ending_soon" );
    level endon( "stop_suspense_music" );

    if ( isdefined( level._ID22151 ) && level._ID22151 )
        return;

    var_1 = game["music"]["allies_suspense"].size;
    var_2 = game["music"]["axis_suspense"].size;
    level._ID37048 = [];

    if ( isdefined( var_0 ) && var_0 )
        wait 120;

    for (;;)
    {
        wait(randomfloatrange( 60, 120 ));
        level._ID37048["allies"] = randomint( var_1 );
        maps\mp\_utility::_ID24645( game["music"]["allies_suspense"][level._ID37048["allies"]], "allies" );
        level._ID37048["axis"] = randomint( var_2 );
        maps\mp\_utility::_ID24645( game["music"]["axis_suspense"][level._ID37048["axis"]], "axis" );
    }
}

_ID38123()
{
    level notify( "stop_suspense_music" );

    if ( isdefined( level._ID37048 ) && level._ID37048.size == 2 )
    {
        foreach ( var_1 in level.players )
        {
            var_2 = var_1.team;
            var_1 stoplocalsound( game["music"][var_2 + "_suspense"][level._ID37048[var_2]] );
        }

        return;
    }
}

finalkillcammusic()
{
    self waittill( "showing_final_killcam" );
}

enablemusic()
{
    if ( level.musicenabled == 0 )
        thread _ID32138();

    level.musicenabled++;
}

disablemusic()
{
    if ( level.musicenabled > 0 )
    {
        level.musicenabled--;

        if ( level.musicenabled == 0 )
        {
            _ID38123();
            return;
        }

        return;
    }

    return;
}

ismusicenabled()
{
    return !level.hardcoremode && level.musicenabled > 0;
}
