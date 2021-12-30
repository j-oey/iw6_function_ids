// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID37474()
{
    if ( !common_scripts\utility::flag_exist( "hives_cleared" ) )
        common_scripts\utility::_ID13189( "hives_cleared" );

    if ( !common_scripts\utility::flag_exist( "blocker_hive_destroyed" ) )
        common_scripts\utility::_ID13189( "blocker_hive_destroyed" );

    init_hive_locs();
}

_ID37880( var_0 )
{
    for (;;)
    {
        var_1 = _ID37937( 0 );
        level thread maps\mp\alien\_spawnlogic::_ID37163( "drill_planted", "door_planted" );

        foreach ( var_3 in var_1 )
            var_3 thread _ID37881( get_hive_score_component_list_func( var_0 ) );

        var_5 = level common_scripts\utility::_ID35635( "regular_hive_destroyed", "regular_door_destroyed" );

        if ( var_5 == "regular_hive_destroyed" )
        {
            maps\mp\alien\_spawn_director::_ID11539();
            level thread maps\mp\alien\_spawnlogic::remaining_alien_management();
            return;
        }
    }
}

_ID37881( var_0 )
{
    level endon( "game_ended" );
    self notify( "stop_listening" );
    self endon( "stop_listening" );

    if ( isdefined( level.drill ) && !isdefined( level.drill_carrier ) && !maps\mp\alien\_unk1464::_ID18506( level._ID36752 ) )
        level waittill( "drill_pickedup",  var_1  );

    var_2 = "waypoint_alien_destroy";
    var_3 = get_hive_waypoint_dist( self, 1300 );

    if ( maps\mp\alien\_unk1464::is_door() || isdefined( level.hive_icon_override ) && self [[ level.hive_icon_override ]]() )
    {
        var_3 = 1000;
        var_2 = "waypoint_alien_door";
    }

    thread _ID28422( var_2, var_3 );
    var_4 = maps\mp\alien\_drill::_ID35452();
    level.current_hive_name = self.target;

    if ( !maps\mp\alien\_unk1464::_ID18506( level._ID36752 ) )
        thread maps\mp\alien\_drill::_ID10923( var_4 );

    if ( level.cycle_count == 1 )
        level maps\mp\_utility::_ID9519( 1, maps\mp\alien\_music_and_dialog::playvoforwavestart );

    if ( maps\mp\alien\_unk1464::is_door() )
    {
        level notify( "door_planted" );
        level notify( "start_spawn_event",  self.target  );

        if ( maps\mp\alien\_unk1464::_ID18506( level.current_cycle_started_by_timeout ) )
            level.cycle_count--;
    }

    if ( !maps\mp\alien\_unk1464::is_door() )
        maps\mp\_utility::_ID9519( 2, maps\mp\alien\_unk1422::_ID30613 );

    level.drill_carrier = undefined;
    thread maps\mp\alien\_drill::_ID10944( self.origin, var_4 );
    _ID10102();
    maps\mp\alien\_unk1443::_ID37894();
    level notify( "force_cycle_start" );
    common_scripts\utility::flag_wait( "drill_detonated" );
    hive_play_death_animations();
    maps\mp\alien\_unk1422::_ID11538();
    maps\mp\alien\_unk1422::remove_all_challenge_cases();
    level._ID31986 = common_scripts\utility::array_remove( level._ID31986, self );
    self notify( "hive_dying" );
    thread maps\mp\alien\_drill::_ID10903();

    if ( isdefined( self._ID27345 ) )
        self._ID27345 notify( "trigger",  level.players[0]  );

    level.current_hive_name = level.current_hive_name + "_post";

    if ( maps\mp\alien\_unk1464::is_door() )
    {
        give_door_score();
        level notify( "regular_door_destroyed" );
    }
    else
    {
        level.num_hive_destroyed++;
        give_players_rewards( 0, var_0 );
        level notify( "regular_hive_destroyed" );
    }

    self notify( "stop_listening" );
}

_ID36790( var_0, var_1 )
{
    var_0 delete();

    if ( isdefined( level._ID17030 ) )
    {
        level._ID17030 notify( "new_flight_path" );
        level._ID17030 notify( "blocker_hive_destroyed" );
    }

    common_scripts\utility::flag_set( "blocker_hive_destroyed" );
    var_1 hive_play_death_animations();
    var_1 delete_removables();
    var_1 maps\mp\alien\_drill::_ID25944();
    var_1 maps\mp\alien\_drill::fx_ents_playfx();
    var_1 _ID29913();
    var_1 destroy_hive_icon();
    var_1 thread blocker_kill_sequence();
    var_1 thread maps\mp\alien\_drill::do_radius_damage();
    level thread maps\mp\alien\_music_and_dialog::_ID24663();
    level thread maps\mp\alien\_spawnlogic::remaining_alien_management();
    level.current_blocker_hive = undefined;
    level.blocker_hive_active = undefined;
    level._ID31986 = common_scripts\utility::array_remove( level._ID31986, var_1 );
    level.current_hive_name = level.current_hive_name + "_post";
    level.num_hive_destroyed++;

    if ( maps\mp\alien\_unk1464::_ID18745() && !issplitscreen() )
        maps\mp\alien\_laststand::_ID15541( level.players[0], 1 );

    if ( isdefined( var_1._ID10936 ) && !maps\mp\alien\_unk1464::_ID18506( level._ID36752 ) )
        level thread maps\mp\alien\_drill::_ID32724( var_1._ID10936[randomint( var_1._ID10936.size )].origin );

    if ( isdefined( var_1._ID27345 ) )
        var_1._ID27345 notify( "trigger",  level.players[0]  );

    maps\mp\alien\_achievement::_ID34404( var_1.target );
    level maps\mp\alien\_challenge_function::_ID37425();
    common_scripts\utility::_ID13180( "blocker_hive_destroyed" );
    var_1 notify( "hive_dying" );
    var_1 notify( "stop_listening" );
}

blocker_kill_sequence()
{
    playfx( level._ID1644["stronghold_explode_large"], self.origin );
    thread _ID29309();

    foreach ( var_1 in self.scriptables )
    {
        var_1 thread hive_explode( 1 );
        common_scripts\utility::_ID35582();
    }
}

_ID37029( var_0 )
{
    var_1 = spawn( "script_model", var_0.origin );
    var_1 setmodel( "mp_ext_alien_hive03_collision" );
    var_1 hide();
    var_1._ID17045 = var_0.target;

    if ( _ID14323() == 1 )
    {
        var_1.health = 100000;
        var_1.maxhealth = 100000;
    }
    else
    {
        var_1.health = 150000;
        var_1.maxhealth = 150000;
    }

    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        var_1.health = int( 0.66 * var_1.health );
        var_1.maxhealth = int( 0.66 * var_1.maxhealth );
    }

    if ( isdefined( level._ID37030 ) )
        var_1 = [[ level._ID37030 ]]( var_1 );

    return var_1;
}

hive_explode( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 2;

    for ( var_1 = 0; var_1 < var_0; var_1++ )
    {
        wait(randomfloatrange( 0.5, 1 ));
        var_2 = 8;
        var_3 = var_2 - randomintrange( 0, var_2 * 2 );
        var_4 = var_2 - randomintrange( 0, var_2 * 2 );
        var_5 = anglestoforward( self.angles );
        var_6 = anglestoup( self.angles );
        playfx( level._ID1644["alien_hive_explode"], self.origin + ( var_3, var_4, 0 ), var_5, var_6 );
    }
}

_ID29309()
{
    wait 0.1;
    self playsound( "alien_hive_destroyed" );
}

monitor_attackable_ent_damage( var_0 )
{
    level endon( "blocker_hive_destroyed" );
    level endon( "game_ended" );
    level._ID1644["Fire_Cloud_Blocker_Hive"] = loadfx( "vfx/gameplay/alien/vfx_alien_gas_fire" );
    var_1 = 0.75 * self.maxhealth;
    var_2 = 0.5 * self.maxhealth;
    var_3 = 0.25 * self.maxhealth;
    var_4 = 0;
    var_5 = 0;
    var_6 = 0;

    for (;;)
    {
        self waittill( "damage",  var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16  );

        if ( isdefined( var_16 ) && var_16 == "alienmortar_strike_mp" )
        {
            var_7 = int( var_7 / 3 );
            self.health = self.health + var_7;
        }

        if ( isdefined( var_16 ) && var_16 == "iw6_alienpanzerfaust3_mp" )
            self dodamage( var_7, self.origin, var_8, var_8, "MOD_PROJECTILE_SPLASH" );

        if ( isdefined( var_8 ) && isalive( var_8 ) && isplayer( var_8 ) )
        {
            if ( !isdefined( var_8._ID17027 ) )
                var_8._ID17027 = 0;

            var_8._ID17027 = var_8._ID17027 + var_7;

            if ( var_8._ID17027 > 400 )
            {
                var_8._ID17027 = 0;
                var_8.threatbias = var_8.threatbias + 100;
                var_8 thread _ID7969( 10 );
            }
        }

        if ( !( isdefined( var_11 ) && var_11 == "MOD_UNKNOWN" ) && !( isdefined( self.is_burning ) && self.is_burning ) )
        {
            if ( isdefined( var_8._ID16351 ) && var_8._ID16351 || isdefined( var_16 ) && ( var_16 == "iw6_alienmk324_mp" || var_16 == "iw6_alienminigun4_mp" || var_16 == "iw6_alienmk323_mp" ) )
                thread blocker_hive_burn( var_8 );
        }

        if ( isdefined( var_8.owner ) && isalive( var_8.owner ) && isplayer( var_8.owner ) )
            var_8 = var_8.owner;

        if ( isdefined( var_8 ) && isalive( var_8 ) && isplayer( var_8 ) )
            var_8 thread maps\mp\gametypes\_damagefeedback::_ID34528( "standard" );

        if ( !var_4 && self.health < var_1 )
        {
            thread _ID35886( 0.1, 0.4 );
            var_4 = 1;
        }

        if ( !var_5 && self.health < var_2 )
        {
            thread _ID35886( 0.1, 0.4 );
            var_0 hive_play_first_pain_animations();

            if ( isdefined( level._ID17030 ) )
                level._ID17030 maps\mp\alien\_music_and_dialog::play_pilot_vo( "so_alien_plt_hivehalfdead" );

            var_5 = 1;
        }

        if ( !var_6 && self.health < var_3 )
        {
            var_0 hive_play_second_pain_animations();

            if ( isdefined( level._ID17030 ) )
                level._ID17030 maps\mp\alien\_music_and_dialog::play_pilot_vo( "so_alien_plt_hivealmostdead" );

            var_6 = 1;
        }
    }
}

blocker_hive_burn( var_0 )
{
    self endon( "death" );
    self.is_burning = 1;
    var_1 = 3;
    var_2 = 1200;
    var_2 *= level.alien_health_per_player_scalar[level.players.size];
    var_3 = 0;
    var_4 = 6;
    var_5 = var_1 / var_4;
    var_6 = var_2 / var_4;
    var_7 = self.origin + vectornormalize( anglestoforward( self.angles ) ) * 60 - ( 0, 0, 20 );
    self._ID14164 = spawnfx( level._ID1644["Fire_Cloud_Blocker_Hive"], var_7 );
    triggerfx( self._ID14164 );
    thread kill_hive_burning_on_death();

    for ( var_8 = 0; var_8 < var_4; var_8++ )
    {
        wait(var_5);
        self dodamage( var_6, self.origin, var_0, var_0, "MOD_UNKNOWN" );
    }

    self.is_burning = 0;
    self._ID14164 delete();
}

kill_hive_burning_on_death()
{
    self notify( "kill_hive_burning_on_death" );
    self endon( "kill_hive_burning_on_death" );
    self waittill( "death" );

    if ( isdefined( self._ID14164 ) )
        self._ID14164 delete();
}

_ID7969( var_0 )
{
    level endon( "blocker_hive_destroyed" );
    level endon( "game_ended" );
    self endon( "death" );
    thread _ID26110();
    thread _ID26109();
    wait(var_0);
    self.threatbias = int( max( 0, self.threatbias - 100 ) );
}

_ID26110()
{
    self notify( "monitor_threat_on_death" );
    self endon( "monitor_threat_on_death" );
    self waittill( "death" );
    self.threatbias = 0;
}

_ID26109()
{
    self notify( "monitor_threat_on_blocker_destroyed" );
    self endon( "monitor_threat_on_blocker_destroyed" );
    level waittill( "blocker_hive_destroyed" );
    self.threatbias = 0;
}

give_door_score()
{
    var_0 = get_door_score_component_list();
    maps\mp\alien\_unk1443::_ID36928( level.players, var_0 );
}

get_door_score_component_list()
{
    if ( is_progression_door( self ) )
        return [ "progression_door" ];
    else
        return [ "side_area" ];
}

is_progression_door( var_0 )
{
    if ( !isdefined( level.progression_doors ) || !isdefined( var_0.target ) )
        return 0;

    return common_scripts\utility::array_contains( level.progression_doors, var_0.target );
}

give_players_rewards( var_0, var_1 )
{
    calculate_and_show_hive_scores( var_1 );

    foreach ( var_3 in level.players )
    {
        var_3 maps\mp\alien\_persistence::eog_player_update_stat( "hivesdestroyed", 1 );
        var_3 thread _ID35519();

        if ( var_0 )
            var_3 maps\mp\alien\_persistence::try_award_bonus_pool_token();
    }
}

calculate_and_show_hive_scores( var_0 )
{
    var_1 = [[ var_0 ]]();
    maps\mp\alien\_unk1443::_ID36926( level.players, var_1 );
}

get_blocker_hive_score_component_name_list()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        return [ "personal_blocker" ];
    else
        return [ "team_blocker", "personal_blocker" ];
}

get_regular_hive_score_component_name_list()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        return [ "drill", "personal", "challenge" ];
    else
        return [ "drill", "team", "personal", "challenge" ];
}

_ID35519()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 = 4.0;
    wait(var_0);
    var_1 = int( self._ID37169 );
    maps\mp\alien\_persistence::give_player_xp( var_1 );
    maps\mp\alien\_persistence::_ID15551( self._ID37162, undefined, undefined, 1 );
}

_ID10102()
{
    foreach ( var_1 in level._ID31986 )
    {
        if ( self != var_1 )
        {
            if ( isdefined( var_1._ID17321 ) )
                var_1._ID17321 destroy();

            var_1 makeunusable();
            var_1 sethintstring( "" );
            var_1 notify( "stop_listening" );
        }
    }
}

_ID28422( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );
    self endon( "stop_listening" );

    if ( !isdefined( var_1 ) )
        var_1 = 1000;

    if ( isdefined( level.drill_icon_draw_dist_override ) )
        var_1 = level.drill_icon_draw_dist_override;

    if ( !isdefined( var_2 ) )
        var_2 = 14;

    if ( !isdefined( var_3 ) )
        var_3 = 14;

    var_4 = 0;

    while ( !var_4 )
    {
        var_4 = 0;

        foreach ( var_6 in level.players )
        {
            if ( isalive( var_6 ) && distance( var_6.origin, self.origin ) <= var_1 )
                var_4 = 1;
        }

        wait 0.05;
    }

    destroy_hive_icon();
    self._ID17321 = newhudelem();
    self._ID17321 setshader( var_0, var_2, var_3 );
    self._ID17321.alpha = 0;
    self._ID17321.color = ( 1, 1, 1 );
    self._ID17321 setwaypoint( 1, 1 );
    self._ID17321.x = self.origin[0];
    self._ID17321.y = self.origin[1];
    self._ID17321.z = self.origin[2];

    if ( !isdefined( var_1 ) )
    {
        self._ID17321.alpha = 0.5;
        return;
    }

    self._ID17321 endon( "death" );

    while ( isdefined( self._ID17321 ) )
    {
        var_4 = 0;

        foreach ( var_6 in level.players )
        {
            if ( isalive( var_6 ) && distance( var_6.origin, self.origin ) <= var_1 )
                var_4 = 1;
        }

        if ( var_4 )
            icon_fade_in( self._ID17321 );
        else
            icon_fade_out( self._ID17321 );

        wait 0.05;
    }
}

icon_fade_in( var_0 )
{
    if ( var_0.alpha != 0 )
        return;

    var_0 fadeovertime( 1 );
    var_0.alpha = 0.5;
    wait 1;
}

icon_fade_out( var_0 )
{
    if ( var_0.alpha == 0 )
        return;

    var_0 fadeovertime( 1 );
    var_0.alpha = 0;
    wait 1;
}

destroy_hive_icon()
{
    if ( isdefined( self._ID17321 ) )
        self._ID17321 destroy();
}

_ID17034()
{
    self endon( "death" );
    self endon( "stop_listening" );
    maps\mp\alien\_drill::get_drill_entity() endon( "offline" );

    if ( !isdefined( self.scriptables ) )
        return;

    var_0 = 0.5 * self._ID33145;
    var_1 = 0.25 * self._ID33145;
    var_2 = self.depth;

    if ( var_2 > var_0 )
    {
        wait(self.depth - var_0);
        hive_play_first_pain_animations();
        var_2 = var_0;
    }

    if ( var_2 > var_1 )
    {
        wait(var_2 - var_1);
        hive_play_second_pain_animations();
    }
}

get_hive_score_component_list_func( var_0 )
{
    if ( isdefined( var_0 ) )
        return var_0;

    return ::get_regular_hive_score_component_name_list;
}

hive_play_first_pain_animations()
{
    var_0 = 3;
    thread _ID23780( undefined, undefined, var_0, 1 );
}

hive_play_second_pain_animations()
{
    var_0 = 0.4;
    thread _ID23780( "start_near_death", var_0, "loop_near_death", 1 );
}

_ID17038( var_0 )
{
    var_1 = 0.2;

    if ( isdefined( var_0 ) )
        var_1 = var_0;

    thread _ID23780( "start_pain", var_1, "loop_pain1", 1 );
}

hive_play_death_animations()
{
    var_0 = 1.5;
    thread _ID23780( "death", var_0, "remove", 1 );
}

_ID23780( var_0, var_1, var_2, var_3 )
{
    var_4 = 0.15;
    var_5 = 0.25;

    if ( !isdefined( self.scriptables ) )
        return;

    foreach ( var_7 in self.scriptables )
    {
        var_7 thread play_hive_anim( var_0, var_1, var_2 );

        if ( var_3 )
            wait(randomfloatrange( var_4, var_5 ));
    }
}

play_hive_anim( var_0, var_1, var_2 )
{
    if ( isdefined( var_0 ) )
        self setscriptablepartstate( 0, var_0 );

    if ( isdefined( var_1 ) )
        wait(var_1);

    if ( isdefined( var_2 ) )
        self setscriptablepartstate( 0, var_2 );
}

dependent_hives_removed()
{
    if ( !isdefined( self.target ) || !isdefined( level.hive_dependencies ) || !isdefined( level.hive_dependencies[self.target] ) )
        return 1;

    var_0 = level.hive_dependencies[self.target];

    foreach ( var_2 in level._ID31986 )
    {
        if ( isdefined( var_2.target ) )
        {
            if ( common_scripts\utility::array_contains( var_0, var_2.target ) )
                return 0;
        }
    }

    return 1;
}

_ID37937( var_0 )
{
    var_1 = [];
    var_2 = maps\mp\alien\_unk1464::_ID37267();

    foreach ( var_4 in level._ID31986 )
    {
        var_5 = var_4 is_blocker_hive();

        if ( var_0 && !var_5 )
            continue;

        if ( !var_0 && var_5 )
            continue;

        if ( !( var_4._ID36729 == var_2 ) && !var_4 maps\mp\alien\_unk1464::is_door() )
            continue;

        if ( !var_4 dependent_hives_removed() )
            continue;

        var_1[var_1.size] = var_4;
    }

    return var_1;
}

_ID25954( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        var_3 = getent( var_2, "target" );
        var_3 notify( "stop_listening" );
        var_3 thread _ID23780( "remove", undefined, undefined, 0 );
        var_3 thread delete_removables();
        var_3 destroy_hive_icon();

        foreach ( var_5 in var_3._ID13828 )
            var_5 delete();

        if ( isdefined( var_3.dead_hive_model ) )
            var_3 _ID29913();

        var_3 delete();
    }
}

delete_removables()
{
    foreach ( var_1 in self._ID25962 )
    {
        if ( isdefined( var_1 ) )
            var_1 delete();
    }
}

_ID29913()
{
    foreach ( var_1 in self.dead_hive_model )
        var_1 show();
}

is_blocker_hive()
{
    if ( !isdefined( level._ID5372 ) || !isdefined( self.target ) )
        return 0;

    foreach ( var_1 in level._ID5372 )
    {
        if ( var_1 == self.target )
            return 1;
    }

    return 0;
}

_ID35886( var_0, var_1 )
{
    level endon( "game_ended" );
    wait(var_0);

    foreach ( var_3 in level.players )
        var_3 thread _ID35889( var_1 );
}

_ID35889( var_0 )
{
    earthquake( var_0, 3, self.origin, 300 );
    self playlocalsound( "pre_quake_mtl_groan" );
    self playrumbleonentity( "heavygun_fire" );
}

init_hive_locs()
{
    level._ID31986 = [];
    level.current_hive_name = "before_first_hive";
    var_0 = getentarray( "stronghold_bomb_loc", "targetname" );
    var_1 = getentarray( "stronghold_door_loc", "targetname" );

    if ( isdefined( var_1 ) && var_1.size > 0 )
        var_0 = common_scripts\utility::array_combine( var_0, var_1 );

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3.target ) )
        {
            var_4 = getentarray( var_3.target, "targetname" );
            var_3.scriptables = getscriptablearray( var_3.target, "targetname" );

            foreach ( var_6 in var_3.scriptables )
                var_6.is_hive = 1;

            var_8 = [];
            var_9 = [];

            foreach ( var_11 in var_4 )
            {
                if ( isdefined( var_11.script_noteworthy ) && var_11.script_noteworthy == "fx_ent" )
                {
                    var_9[var_9.size] = var_11;
                    continue;
                }

                if ( isdefined( var_11.script_noteworthy ) && issubstr( var_11.script_noteworthy, "waypointdist" ) )
                {
                    var_12 = strtok( var_11.script_noteworthy, " " );

                    if ( isdefined( var_12 ) && var_12.size && var_12[0] == "waypointdist" )
                        var_3.waypoint_dist = int( var_12[1] );

                    continue;
                }

                var_8[var_8.size] = var_11;
            }

            if ( isdefined( level._ID27346 ) )
            {
                foreach ( var_15 in level._ID27346 )
                {
                    if ( isdefined( var_15.script_noteworthy ) && var_15.script_noteworthy == var_3.target )
                    {
                        var_3._ID27345 = var_15;
                        break;
                    }
                }
            }

            var_17 = var_3.target + "_drill_teleport_loc";
            var_3._ID10936 = common_scripts\utility::_ID15386( var_17, "targetname" );
            var_3._ID25962 = var_8;
            var_3._ID13828 = var_9;

            if ( var_3.target == level._ID19460 )
                var_3._ID19460 = 1;

            var_18 = var_3.target + "_dead";
            var_3.dead_hive_model = getentarray( var_18, "targetname" );

            if ( isdefined( var_3.dead_hive_model ) )
            {
                foreach ( var_20 in var_3.dead_hive_model )
                    var_20 hide();
            }

            if ( var_3 is_blocker_hive() )
            {
                var_3 thread init_blocker_hive_animation_state();
                var_3 makeunusable();
                var_3 sethintstring( "" );
            }
        }

        if ( !common_scripts\utility::array_contains( level._ID25988, var_3.target ) )
        {
            var_3._ID36729 = var_3 maps\mp\alien\_unk1464::get_in_world_area();
            level._ID31986[level._ID31986.size] = var_3;
        }
    }
}

init_blocker_hive_animation_state()
{
    level endon( "game_ended" );
    self endon( "death" );

    if ( !isdefined( self.scriptables ) )
        return;

    wait 5;

    foreach ( var_1 in self.scriptables )
    {
        wait(randomfloatrange( 0.15, 0.25 ));
        var_1 setscriptablepartstate( 0, "loop_pain1" );
    }
}

get_hive_waypoint_dist( var_0, var_1 )
{
    if ( isdefined( var_0.waypoint_dist ) )
        return var_0.waypoint_dist;

    if ( isdefined( level._ID38298 ) )
        return level._ID38298;

    return var_1;
}

_ID14323()
{
    var_0 = level._ID8866[0];
    var_1 = level._ID8866[1];

    if ( level.cycle_count == var_0 - 1 || level.cycle_count == var_0 )
        return 1;
    else
        return 2;
}

_ID38041()
{

}

_ID36780()
{

}

_ID36779()
{

}
