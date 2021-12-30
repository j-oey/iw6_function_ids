// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    if ( maps\mp\_utility::_ID18363() )
        return;

    if ( isdefined( level._ID8425 ) && level._ID8425 )
        return;

    if ( level.script == "mp_character_room" )
        return;

    _ID28940();
    maps\mp\bots\_bots_personality::_ID29086();
    level.badplace_cylinder_func = ::badplace_cylinder;
    level._ID4645 = ::badplace_delete;
    maps\mp\bots\_bots_ks::bot_killstreak_setup();
    maps\mp\bots\_bots_loadout::_ID17631();
    level thread _ID17631();
}

_ID28940()
{
    level.bot_funcs = [];
    level.bot_funcs["bots_spawn"] = ::_ID30607;
    level.bot_funcs["bots_add_scavenger_bag"] = ::_ID5494;
    level.bot_funcs["bots_add_to_level_targets"] = maps\mp\bots\_bots_util::bot_add_to_bot_level_targets;
    level.bot_funcs["bots_remove_from_level_targets"] = maps\mp\bots\_bots_util::bot_remove_from_bot_level_targets;
    level.bot_funcs["bots_make_entity_sentient"] = ::_ID5680;
    level.bot_funcs["think"] = ::_ID5803;
    level.bot_funcs["on_killed"] = ::_ID22747;
    level.bot_funcs["should_do_killcam"] = ::bot_should_do_killcam;
    level.bot_funcs["get_attacker_ent"] = maps\mp\bots\_bots_util::bot_get_known_attacker;
    level.bot_funcs["should_pickup_weapons"] = ::bot_should_pickup_weapons;
    level.bot_funcs["on_damaged"] = ::bot_damage_callback;
    level.bot_funcs["gametype_think"] = ::_ID9365;
    level.bot_funcs["leader_dialog"] = maps\mp\bots\_bots_util::_ID5661;
    level.bot_funcs["player_spawned"] = ::_ID5729;
    level.bot_funcs["should_start_cautious_approach"] = maps\mp\bots\_bots_strategy::_ID29840;
    level.bot_funcs["know_enemies_on_start"] = ::_ID5658;
    level.bot_funcs["bot_get_rank_xp"] = ::bot_get_rank_xp;
    level.bot_funcs["ai_3d_sighting_model"] = ::bot_3d_sighting_model;
    level.bot_funcs["dropped_weapon_think"] = ::bot_think_seek_dropped_weapons;
    level.bot_funcs["dropped_weapon_cancel"] = ::_ID29841;
    level.bot_funcs["crate_can_use"] = ::crate_can_use_always;
    level.bot_funcs["crate_low_ammo_check"] = ::crate_low_ammo_check;
    level.bot_funcs["crate_should_claim"] = ::_ID8246;
    level.bot_funcs["crate_wait_use"] = ::_ID8247;
    level.bot_funcs["crate_in_range"] = ::_ID8240;
    level.bot_funcs["post_teleport"] = ::bot_post_teleport;
    level.bot_random_path_function = [];
    level.bot_random_path_function["allies"] = maps\mp\bots\_bots_personality::bot_random_path_default;
    level.bot_random_path_function["axis"] = maps\mp\bots\_bots_personality::bot_random_path_default;
    level.bot_can_use_box_by_type["deployable_vest"] = ::_ID5784;
    level.bot_can_use_box_by_type["deployable_ammo"] = ::bot_should_use_ammo_crate;
    level.bot_can_use_box_by_type["scavenger_bag"] = ::bot_should_use_scavenger_bag;
    level.bot_can_use_box_by_type["deployable_grenades"] = ::bot_should_use_grenade_crate;
    level.bot_can_use_box_by_type["deployable_juicebox"] = ::_ID5786;
    level.bot_pre_use_box_of_type["deployable_ammo"] = ::_ID5734;
    level.bot_post_use_box_of_type["deployable_ammo"] = ::bot_post_use_ammo_crate;
    level.bot_find_defend_node_func["capture"] = maps\mp\bots\_bots_strategy::find_defend_node_capture;
    level.bot_find_defend_node_func["capture_zone"] = maps\mp\bots\_bots_strategy::_ID12903;
    level.bot_find_defend_node_func["protect"] = maps\mp\bots\_bots_strategy::find_defend_node_protect;
    level.bot_find_defend_node_func["bodyguard"] = maps\mp\bots\_bots_strategy::_ID12901;
    level.bot_find_defend_node_func["patrol"] = maps\mp\bots\_bots_strategy::_ID12904;
    maps\mp\bots\_bots_gametype_war::_ID28940();

    if ( maps\mp\_utility::bot_is_fireteam_mode() )
        maps\mp\bots\_bots_fireteam::bot_fireteam_setup_callbacks();
}

codecallback_leaderdialog( var_0, var_1 )
{
    if ( isdefined( level.bot_funcs ) && isdefined( level.bot_funcs["leader_dialog"] ) )
        self [[ level.bot_funcs["leader_dialog"] ]]( var_0, var_1 );
}

_ID17631()
{
    thread _ID21340();
    thread bot_triggers();
    _ID17908();

    if ( !_ID29892() )
        return;

    _ID25658();
    var_0 = botautoconnectenabled();

    if ( var_0 > 0 )
    {
        setmatchdata( "hasBots", 1 );

        if ( maps\mp\_utility::bot_is_fireteam_mode() )
        {
            level thread maps\mp\bots\_bots_fireteam::_ID5587();
            level thread maps\mp\bots\_bots_fireteam_commander::_ID17631();
        }
        else
            level thread bot_connect_monitor();
    }
}

_ID17908()
{
    if ( !isdefined( level.crateownerusetime ) )
        level.crateownerusetime = 500;

    if ( !isdefined( level.cratenonownerusetime ) )
        level.cratenonownerusetime = 3000;

    level._ID5715 = 3000;
    level.bot_respawn_launcher_name = "iw6_panzerfaust3";
    level._ID36840 = "iw6_knifeonly";
    level._ID36588 = getzonecount();
    _ID17909();
}

_ID17909()
{
    if ( isdefined( level._ID32800 ) )
        var_0 = [[ level._ID32800 ]]();
    else
        var_0 = getallnodes();

    level.bot_map_min_x = 0;
    level.bot_map_max_x = 0;
    level.bot_map_min_y = 0;
    level.bot_map_max_y = 0;
    level.bot_map_min_z = 0;
    level._ID5684 = 0;

    if ( var_0.size > 1 )
    {
        level.bot_map_min_x = var_0[0].origin[0];
        level.bot_map_max_x = var_0[0].origin[0];
        level.bot_map_min_y = var_0[0].origin[1];
        level.bot_map_max_y = var_0[0].origin[1];
        level.bot_map_min_z = var_0[0].origin[2];
        level._ID5684 = var_0[0].origin[2];

        for ( var_1 = 1; var_1 < var_0.size; var_1++ )
        {
            var_2 = var_0[var_1].origin;

            if ( var_2[0] < level.bot_map_min_x )
                level.bot_map_min_x = var_2[0];

            if ( var_2[0] > level.bot_map_max_x )
                level.bot_map_max_x = var_2[0];

            if ( var_2[1] < level.bot_map_min_y )
                level.bot_map_min_y = var_2[1];

            if ( var_2[1] > level.bot_map_max_y )
                level.bot_map_max_y = var_2[1];

            if ( var_2[2] < level.bot_map_min_z )
                level.bot_map_min_z = var_2[2];

            if ( var_2[2] > level._ID5684 )
                level._ID5684 = var_2[2];
        }
    }

    level.bot_map_center = ( ( level.bot_map_min_x + level.bot_map_max_x ) / 2, ( level.bot_map_min_y + level.bot_map_max_y ) / 2, ( level.bot_map_min_z + level._ID5684 ) / 2 );
    level._ID5823 = 1;
}

bot_post_teleport()
{
    level._ID5823 = undefined;
    level.bot_initialized_remote_vehicles = undefined;
    _ID17909();
    maps\mp\bots\_bots_ks_remote_vehicle::_ID25812();
}

_ID29892()
{
    return 1;
}

_ID25658()
{
    wait 1;

    foreach ( var_1 in level.players )
    {
        if ( isbot( var_1 ) )
        {
            var_1.equipment_enabled = 1;
            var_1._ID5801 = var_1.team;
            var_1.bot_spawned_before = 1;
            var_1 thread [[ level.bot_funcs["think"] ]]();
        }
    }
}

_ID5729()
{
    _ID5772();

    if ( isdefined( self.prev_personality ) )
    {
        maps\mp\bots\_bots_util::bot_set_personality( self.prev_personality );
        self.prev_personality = undefined;
    }
}

_ID5772()
{
    if ( !isdefined( self.bot_class ) )
    {
        if ( !bot_gametype_chooses_class() )
        {
            while ( !isdefined( level._ID5678 ) )
                wait 0.05;

            if ( isdefined( self.override_class_function ) )
                self.bot_class = [[ self.override_class_function ]]();
            else
                self.bot_class = maps\mp\bots\_bots_personality::bot_setup_callback_class();
        }
        else
            self.bot_class = self.class;
    }
}

_ID36013()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );

        if ( !isai( var_0 ) && level.players.size > 0 )
        {
            level._ID24530 = common_scripts\utility::array_add( level._ID24530, var_0 );
            childthread _ID5855( var_0 );
            childthread bots_notify_on_disconnect( var_0 );
            childthread _ID5856( var_0 );
        }
    }
}

_ID5855( var_0 )
{
    var_0 endon( "bots_human_disconnected" );

    while ( !common_scripts\utility::array_contains( level.players, var_0 ) )
        wait 0.05;

    var_0 notify( "bots_human_spawned" );
}

bots_notify_on_disconnect( var_0 )
{
    var_0 endon( "bots_human_spawned" );
    var_0 waittill( "disconnect" );
    var_0 notify( "bots_human_disconnected" );
}

_ID5856( var_0 )
{
    var_0 common_scripts\utility::_ID35626( "bots_human_spawned", "bots_human_disconnected" );
    level._ID24530 = common_scripts\utility::array_remove( level._ID24530, var_0 );
}

_ID21332()
{
    level._ID24530 = [];
    childthread _ID36013();

    for (;;)
    {
        if ( level._ID24530.size > 0 )
            level._ID23390 = 1;
        else
            level._ID23390 = 0;

        wait 0.5;
    }
}

_ID36825( var_0 )
{
    if ( maps\mp\_utility::_ID20673() )
        return 1;

    if ( getdvar( "squad_vs_squad" ) == "1" )
        return 1;

    if ( !level._ID32653 )
        return 1;

    if ( maps\mp\gametypes\_teams::_ID15072( var_0 ) )
        return 1;

    return 0;
}

bot_connect_monitor( var_0, var_1 )
{
    level endon( "game_ended" );
    self notify( "bot_connect_monitor" );
    self endon( "bot_connect_monitor" );
    level._ID23390 = 0;
    childthread _ID21332();
    maps\mp\gametypes\_hostmigration::_ID35597( 0.5 );
    var_2 = 1.5;

    if ( !isdefined( level.bot_cm_spawned_bots ) )
        level.bot_cm_spawned_bots = 0;

    if ( !isdefined( level.bot_cm_waited_players_time ) )
        level.bot_cm_waited_players_time = 0;

    if ( !isdefined( level._ID36828 ) )
        level._ID36828 = 0;

    if ( getdvar( "squad_vs_squad" ) == "1" )
    {
        while ( !( isdefined( level.squad_vs_squad_allies_client ) && isdefined( level.squad_vs_squad_axis_client ) ) )
            wait 0.05;

        wait 2.0;
    }

    if ( getdvar( "squad_match" ) == "1" )
    {
        while ( !isdefined( level.squad_match_client ) )
            wait 0.05;

        wait 2.0;
    }

    if ( getdvar( "squad_use_hosts_squad" ) == "1" )
    {
        while ( !isdefined( level.wargame_client ) )
            wait 0.05;

        wait 2.0;
    }

    for (;;)
    {
        if ( level._ID23390 )
        {
            maps\mp\gametypes\_hostmigration::_ID35597( var_2 );
            continue;
        }

        var_3 = isdefined( level.bots_ignore_team_balance ) || !level._ID32653;
        var_4 = botgetteamlimit( 0 );
        var_5 = botgetteamlimit( 1 );
        var_6 = botgetteamdifficulty( 0 );
        var_7 = botgetteamdifficulty( 1 );
        var_8 = "allies";
        var_9 = "axis";
        var_10 = bot_client_counts();
        var_11 = cat_array_get( var_10, "humans" );

        if ( var_11 > 1 )
        {
            var_12 = bot_get_host_team();

            if ( !maps\mp\_utility::_ID20673() && isdefined( var_12 ) && var_12 != "spectator" )
            {
                var_8 = var_12;
                var_9 = maps\mp\_utility::getotherteam( var_12 );
            }
            else
            {
                var_13 = cat_array_get( var_10, "humans_allies" );
                var_14 = cat_array_get( var_10, "humans_axis" );

                if ( var_14 > var_13 )
                {
                    var_8 = "axis";
                    var_9 = "allies";
                }
            }
        }
        else
        {
            var_15 = get_human_player();

            if ( isdefined( var_15 ) )
            {
                var_16 = var_15 bot_get_player_team();

                if ( isdefined( var_16 ) && var_16 != "spectator" )
                {
                    var_8 = var_16;
                    var_9 = maps\mp\_utility::getotherteam( var_16 );
                }
            }
        }

        var_17 = maps\mp\bots\_bots_util::bot_get_team_limit();
        var_18 = maps\mp\bots\_bots_util::bot_get_team_limit();

        if ( var_17 + var_18 < maps\mp\bots\_bots_util::bot_get_client_limit() )
        {
            if ( var_17 < var_4 )
                var_17++;
            else if ( var_18 < var_5 )
                var_18++;
        }

        var_19 = cat_array_get( var_10, "humans_" + var_8 );
        var_20 = cat_array_get( var_10, "humans_" + var_9 );
        var_21 = var_19 + var_20;
        var_22 = cat_array_get( var_10, "spectator" );
        var_23 = 0;

        for ( var_24 = 0; var_22 > 0; var_22-- )
        {
            var_25 = var_19 + var_23 + 1 <= var_17;
            var_26 = var_20 + var_24 + 1 <= var_18;

            if ( var_25 && !var_26 )
            {
                var_23++;
                continue;
            }

            if ( !var_25 && var_26 )
            {
                var_24++;
                continue;
            }

            if ( var_25 && var_26 )
            {
                if ( var_22 % 2 == 1 )
                {
                    var_23++;
                    continue;
                }

                var_24++;
            }
        }

        var_27 = cat_array_get( var_10, "bots_" + var_8 );
        var_28 = cat_array_get( var_10, "bots_" + var_9 );
        var_29 = var_27 + var_28;

        if ( var_29 > 0 )
            level.bot_cm_spawned_bots = 1;

        var_30 = 0;

        if ( !level._ID36828 )
        {
            var_30 = !_ID36846();

            if ( !var_30 )
                level._ID36828 = 1;
        }

        if ( var_30 )
        {
            var_31 = !getdvarint( "systemlink" ) && !getdvarint( "onlinegame" );
            var_32 = !var_3 && var_5 != var_4 && !level.bot_cm_spawned_bots && ( level.bot_cm_waited_players_time < 10 || !maps\mp\_utility::_ID14065( "prematch_done" ) );

            if ( var_31 || var_32 )
            {
                level.bot_cm_waited_players_time = level.bot_cm_waited_players_time + var_2;
                maps\mp\gametypes\_hostmigration::_ID35597( var_2 );
                continue;
            }
        }

        var_33 = int( min( var_17 - var_19 - var_23, var_4 ) );
        var_34 = int( min( var_18 - var_20 - var_24, var_5 ) );
        var_35 = 1;
        var_36 = var_33 + var_34 + var_11;
        var_37 = var_4 + var_5 + var_11;

        for ( var_38 = [ -1, -1 ]; var_36 < maps\mp\bots\_bots_util::bot_get_client_limit() && var_36 < var_37; var_35 = !var_35 )
        {
            if ( var_35 && var_33 < var_4 && _ID36825( var_8 ) )
                var_33++;
            else if ( !var_35 && var_34 < var_5 && _ID36825( var_9 ) )
                var_34++;

            var_36 = var_33 + var_34 + var_11;

            if ( var_38[var_35] == var_36 )
                break;

            var_38[var_35] = var_36;
        }

        if ( var_4 == var_5 && !var_3 && var_23 == 1 && var_24 == 0 && var_34 > 0 )
        {
            if ( !isdefined( level._ID5736 ) && maps\mp\_utility::_ID14065( "prematch_done" ) )
                level._ID5736 = gettime();

            if ( var_30 && ( !isdefined( level._ID5736 ) || gettime() - level._ID5736 < 10000 ) )
                var_34--;
        }

        var_39 = var_33 - var_27;
        var_40 = var_34 - var_28;
        var_41 = 1;

        if ( var_3 )
        {
            var_42 = var_17 + var_18;
            var_43 = var_4 + var_5;
            var_44 = var_19 + var_20;
            var_45 = var_27 + var_28;
            var_46 = int( min( var_42 - var_44, var_43 ) );
            var_47 = var_46 - var_45;

            if ( var_47 == 0 )
                var_41 = 0;
            else if ( var_47 > 0 )
            {
                var_39 = int( var_47 / 2 ) + var_47 % 2;
                var_40 = int( var_47 / 2 );
            }
            else if ( var_47 < 0 )
            {
                var_48 = var_47 * -1;
                var_39 = -1 * int( min( var_48, var_27 ) );
                var_40 = -1 * ( var_48 + var_39 );
            }
        }
        else if ( !maps\mp\_utility::_ID20673() && ( var_39 * var_40 < 0 && maps\mp\_utility::_ID14065( "prematch_done" ) && !isdefined( level.bots_disable_team_switching ) ) )
        {
            var_49 = int( min( abs( var_39 ), abs( var_40 ) ) );

            if ( var_39 > 0 )
                _ID21557( var_49, var_9, var_8, var_6 );
            else if ( var_40 > 0 )
                _ID21557( var_49, var_8, var_9, var_7 );

            var_41 = 0;
        }

        if ( var_41 )
        {
            if ( var_40 < 0 )
                _ID11059( var_40 * -1, var_9 );

            if ( var_39 < 0 )
                _ID11059( var_39 * -1, var_8 );

            if ( var_40 > 0 )
                level thread _ID30607( var_40, var_9, undefined, undefined, "spawned_enemies", var_7 );

            if ( var_39 > 0 )
                level thread _ID30607( var_39, var_8, undefined, undefined, "spawned_allies", var_6 );

            if ( var_40 > 0 && var_39 > 0 )
                level common_scripts\utility::_ID35699( "spawned_enemies", "spawned_allies" );
            else if ( var_40 > 0 )
                level waittill( "spawned_enemies" );
            else if ( var_39 > 0 )
                level waittill( "spawned_allies" );
        }

        if ( var_7 != var_6 )
        {
            bots_update_difficulty( var_9, var_7 );
            bots_update_difficulty( var_8, var_6 );
        }

        maps\mp\gametypes\_hostmigration::_ID35597( var_2 );
    }
}

bot_get_player_team()
{
    if ( isdefined( self.team ) )
        return self.team;

    if ( isdefined( self.pers["team"] ) )
        return self.pers["team"];

    return undefined;
}

bot_get_host_team()
{
    foreach ( var_1 in level.players )
    {
        if ( !isai( var_1 ) && var_1 ishost() )
            return var_1 bot_get_player_team();
    }

    return "spectator";
}

_ID36846()
{
    var_0 = 0;
    var_1 = 0;
    var_2 = 0;

    foreach ( var_4 in level.players )
    {
        if ( !isai( var_4 ) )
        {
            if ( var_4 ishost() )
                var_0 = 1;

            if ( _ID37799( var_4 ) )
            {
                var_1 = 1;

                if ( var_4 ishost() )
                    var_2 = 1;
            }
        }
    }

    return var_2 || var_1 && !var_0;
}

_ID37799( var_0 )
{
    if ( isdefined( var_0.team ) && var_0.team != "spectator" )
        return 1;

    if ( isdefined( var_0.spectating_actively ) && var_0.spectating_actively )
        return 1;

    if ( var_0 ismlgspectator() && isdefined( var_0.team ) && var_0.team == "spectator" )
        return 1;

    return 0;
}

bot_client_counts()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < level.players.size; var_1++ )
    {
        var_2 = level.players[var_1];

        if ( isdefined( var_2 ) && isdefined( var_2.team ) )
        {
            var_0 = cat_array_add( var_0, "all" );
            var_0 = cat_array_add( var_0, var_2.team );

            if ( isbot( var_2 ) )
            {
                var_0 = cat_array_add( var_0, "bots" );
                var_0 = cat_array_add( var_0, "bots_" + var_2.team );
                continue;
            }

            var_0 = cat_array_add( var_0, "humans" );
            var_0 = cat_array_add( var_0, "humans_" + var_2.team );
        }
    }

    return var_0;
}

cat_array_add( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = [];

    if ( !isdefined( var_0[var_1] ) )
        var_0[var_1] = 0;

    var_0[var_1] += 1;
    return var_0;
}

cat_array_get( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( !isdefined( var_0[var_1] ) )
        return 0;

    return var_0[var_1];
}

_ID21557( var_0, var_1, var_2, var_3 )
{
    foreach ( var_5 in level.players )
    {
        if ( !isdefined( var_5.team ) )
            continue;

        if ( isdefined( var_5._ID7864 ) && var_5._ID7864 && isbot( var_5 ) && var_5.team == var_1 )
        {
            var_5._ID5801 = var_2;

            if ( isdefined( var_3 ) )
                var_5 maps\mp\bots\_bots_util::bot_set_difficulty( var_3 );

            var_5 notify( "luinotifyserver",  "team_select", bot_lui_convert_team_to_int( var_2 )  );
            wait 0.05;
            var_5 notify( "luinotifyserver",  "class_select", var_5.bot_class  );
            var_0--;

            if ( var_0 <= 0 )
            {
                break;
                continue;
            }

            wait 0.1;
        }
    }
}

bots_update_difficulty( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        if ( !isdefined( var_3.team ) )
            continue;

        if ( isdefined( var_3._ID7864 ) && var_3._ID7864 && isbot( var_3 ) && var_3.team == var_0 )
        {
            if ( var_1 != var_3 botgetdifficulty() )
                var_3 maps\mp\bots\_bots_util::bot_set_difficulty( var_1 );
        }
    }
}

bot_drop()
{
    kick( self.entity_number, "EXE_PLAYERKICKED_BOT_BALANCE" );
    wait 0.1;
}

_ID11059( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in level.players )
    {
        if ( isdefined( var_4._ID7864 ) && var_4._ID7864 && isbot( var_4 ) && ( !isdefined( var_1 ) || isdefined( var_4.team ) && var_4.team == var_1 ) )
            var_2[var_2.size] = var_4;
    }

    for ( var_6 = var_2.size - 1; var_6 >= 0; var_6-- )
    {
        if ( var_0 <= 0 )
            break;

        if ( !maps\mp\_utility::_ID18757( var_2[var_6] ) )
        {
            var_2[var_6] bot_drop();
            var_2 = common_scripts\utility::array_remove( var_2, var_2[var_6] );
            var_0--;
        }
    }

    for ( var_6 = var_2.size - 1; var_6 >= 0; var_6-- )
    {
        if ( var_0 <= 0 )
            break;

        var_2[var_6] bot_drop();
        var_0--;
    }
}

bot_lui_convert_team_to_int( var_0 )
{
    if ( var_0 == "axis" )
        return 0;
    else if ( var_0 == "allies" )
        return 1;
    else if ( var_0 == "autoassign" || var_0 == "random" )
        return 2;
    else
        return 3;
}

_ID30606( var_0, var_1, var_2 )
{
    var_3 = gettime() + 60000;

    while ( !self canspawntestclient() )
    {
        if ( gettime() >= var_3 )
        {
            kick( self.entity_number, "EXE_PLAYERKICKED_BOT_BALANCE" );
            var_2.abort = 1;
            return;
        }

        wait 0.05;

        if ( !isdefined( self ) )
        {
            var_2.abort = 1;
            return;
        }
    }

    maps\mp\gametypes\_hostmigration::_ID35597( randomfloatrange( 0.25, 2.0 ) );

    if ( !isdefined( self ) )
    {
        var_2.abort = 1;
        return;
    }

    self spawntestclient();
    self.pers["isBot"] = 1;
    self.equipment_enabled = 1;
    self._ID5801 = var_0;

    if ( isdefined( var_2._ID10028 ) )
        maps\mp\bots\_bots_util::bot_set_difficulty( var_2._ID10028 );

    if ( isdefined( var_1 ) )
        self [[ var_1 ]]();

    self thread [[ level.bot_funcs["think"] ]]();
    var_2._ID25552 = 1;
}

_ID37200( var_0, var_1 )
{
    var_2 = var_0 getrankedplayerdata( "activeSquadMember" );
    var_3 = 0;
    var_4 = 0;

    while ( var_4 < 10 )
    {
        var_3 = 0;
        var_5 = var_0 getrankedplayerdata( "squadHQ", "aiSquadMembers", var_4 );

        if ( var_5 == var_2 )
        {
            var_4++;
            continue;
        }

        if ( !isdefined( level._ID37433 ) || !isdefined( level._ID37433[var_5] ) || level._ID37433[var_5] == 0 )
            return var_5;

        var_4++;
    }

    return -1;
}

_ID30607( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = gettime() + 10000;
    var_7 = [];
    var_8 = var_7.size;

    while ( level.players.size < maps\mp\bots\_bots_util::bot_get_client_limit() && var_7.size < var_0 && gettime() < var_6 )
    {
        maps\mp\gametypes\_hostmigration::_ID35597( 0.05 );
        var_9 = undefined;

        if ( getdvar( "squad_vs_squad" ) == "1" )
        {
            var_10 = level.squad_vs_squad_axis_client;

            if ( var_1 == "allies" )
                var_10 = level.squad_vs_squad_allies_client;

            if ( isdefined( var_10 ) )
            {
                var_11 = var_8;
                var_12 = var_10 getrankedplayerdata( "activeSquadMember" );
                var_13 = 0;
                var_14 = 0;

                for ( var_15 = 0; var_15 < maps\mp\bots\_bots_util::bot_get_team_limit(); var_15++ )
                {
                    var_14 = var_10 getrankedplayerdata( "squadHQ", "aiSquadMembers", var_15 );

                    if ( var_14 == var_12 )
                        continue;

                    if ( var_11 == var_13 )
                        break;

                    var_13++;
                }

                var_16 = var_10 getrankedplayerdata( "squadMembers", var_14, "name" );
                var_17 = var_10 getrankedplayerdata( "squadMembers", var_14, "head" );
                var_18 = var_10 getrankedplayerdata( "squadMembers", var_14, "body" );
                var_19 = var_10 getrankedplayerdata( "squadMembers", var_14, "helmet" );
                var_9 = addbot( var_16, var_17, var_18, var_19 );

                if ( isdefined( var_9 ) )
                    var_9.pers["squadSlot"] = var_14;
            }
            else if ( !isdefined( level._ID38112 ) )
            {
                if ( isdefined( level.squad_vs_squad_axis_client ) )
                {
                    level.finalkillcam_winner = "axis";
                    thread maps\mp\gametypes\_gamelogic::endgame( "axis", game["end_reason"]["allies_forfeited"] );
                }
                else
                {
                    level.finalkillcam_winner = "allies";
                    thread maps\mp\gametypes\_gamelogic::endgame( "allies", game["end_reason"]["axis_forfeited"] );
                }

                level._ID38112 = 1;
            }
        }
        else if ( getdvar( "squad_use_hosts_squad" ) == "1" )
        {
            if ( level.wargame_client.team == var_1 )
            {
                if ( maps\mp\_utility::_ID20673() )
                {
                    var_14 = _ID37200( level.wargame_client, var_1 );
                    var_16 = level.wargame_client getrankedplayerdata( "squadMembers", var_14, "name" );
                    var_17 = level.wargame_client getrankedplayerdata( "squadMembers", var_14, "head" );
                    var_18 = level.wargame_client getrankedplayerdata( "squadMembers", var_14, "body" );
                    var_19 = level.wargame_client getrankedplayerdata( "squadMembers", var_14, "helmet" );
                    var_9 = addbot( var_16, var_17, var_18, var_19 );

                    if ( isdefined( var_9 ) )
                    {
                        level._ID37433[var_14] = 1;
                        var_9.pers["squadSlot"] = var_14;
                    }
                }
                else
                {
                    var_11 = var_8;
                    var_12 = level.wargame_client getprivateplayerdata( "privateMatchActiveSquadMember" );
                    var_13 = 0;
                    var_14 = 0;

                    for ( var_15 = 0; var_15 < maps\mp\bots\_bots_util::bot_get_team_limit(); var_15++ )
                    {
                        var_14 = var_15;

                        if ( var_15 == var_12 )
                            continue;

                        if ( var_11 == var_13 )
                            break;

                        var_13++;
                    }

                    var_16 = level.wargame_client getprivateplayerdata( "privateMatchSquadMembers", var_14, "name" );
                    var_17 = level.wargame_client getprivateplayerdata( "privateMatchSquadMembers", var_14, "head" );
                    var_18 = level.wargame_client getprivateplayerdata( "privateMatchSquadMembers", var_14, "body" );
                    var_19 = level.wargame_client getprivateplayerdata( "privateMatchSquadMembers", var_14, "helmet" );
                    var_9 = addbot( var_16, var_17, var_18, var_19 );

                    if ( isdefined( var_9 ) )
                        var_9.pers["squadSlot"] = var_14;
                }
            }
            else
                var_9 = addbot( "", 0, 0, 0 );
        }
        else if ( getdvar( "squad_match" ) == "1" )
        {
            if ( var_1 == "axis" )
            {
                var_14 = getenemysquaddata( "squadHQ", "aiSquadMembers", var_8 );
                var_16 = getenemysquaddata( "squadMembers", var_14, "name" );
                var_17 = getenemysquaddata( "squadMembers", var_14, "head" );
                var_18 = getenemysquaddata( "squadMembers", var_14, "body" );
                var_19 = getenemysquaddata( "squadMembers", var_14, "helmet" );
                var_9 = addbot( var_16, var_17, var_18, var_19 );

                if ( isdefined( var_9 ) )
                    var_9.pers["squadSlot"] = var_14;
            }
            else
            {
                var_14 = _ID37200( level.squad_match_client, var_1 );

                if ( var_14 > -1 )
                {
                    var_16 = level.squad_match_client getrankedplayerdata( "squadMembers", var_14, "name" );
                    var_17 = level.squad_match_client getrankedplayerdata( "squadMembers", var_14, "head" );
                    var_18 = level.squad_match_client getrankedplayerdata( "squadMembers", var_14, "body" );
                    var_19 = level.squad_match_client getrankedplayerdata( "squadMembers", var_14, "helmet" );
                    var_9 = addbot( var_16, var_17, var_18, var_19 );

                    if ( isdefined( var_9 ) )
                    {
                        level._ID37433[var_14] = 1;
                        var_9.pers["squadSlot"] = var_14;
                    }
                }
            }
        }
        else
            var_9 = addbot( "", 0, 0, 0 );

        if ( !isdefined( var_9 ) )
        {
            if ( isdefined( var_3 ) && var_3 )
            {
                if ( isdefined( var_4 ) )
                    self notify( var_4 );

                return;
            }

            maps\mp\gametypes\_hostmigration::_ID35597( 1 );
            continue;
            continue;
        }

        var_20 = spawnstruct();
        var_20.bot = var_9;
        var_20._ID25552 = 0;
        var_20.abort = 0;
        var_20.index = var_8;
        var_20._ID10028 = var_5;
        var_7[var_7.size] = var_20;
        var_20.bot thread _ID30606( var_1, var_2, var_20 );
        var_8++;
    }

    var_21 = 0;
    var_6 = gettime() + 60000;

    while ( var_21 < var_7.size && gettime() < var_6 )
    {
        var_21 = 0;

        foreach ( var_20 in var_7 )
        {
            if ( var_20._ID25552 || var_20.abort )
                var_21++;
        }

        wait 0.05;
    }

    if ( isdefined( var_4 ) )
        self notify( var_4 );
}

bot_gametype_chooses_team()
{
    if ( !level._ID32653 )
        return 1;

    if ( isdefined( level.bots_gametype_handles_team_choice ) && level.bots_gametype_handles_team_choice )
        return 1;

    return 0;
}

bot_gametype_chooses_class()
{
    return isdefined( level.bots_gametype_handles_class_choice ) && level.bots_gametype_handles_class_choice;
}

_ID5803()
{
    self notify( "bot_think" );
    self endon( "bot_think" );
    self endon( "disconnect" );

    while ( !isdefined( self.pers["team"] ) )
        wait 0.05;

    level._ID16385 = 1;

    if ( bot_gametype_chooses_team() )
        self._ID5801 = self.pers["team"];

    var_0 = self._ID5801;

    if ( !isdefined( var_0 ) )
        var_0 = self.pers["team"];

    maps\mp\bots\_bots_ks::bot_killstreak_setup();
    self.entity_number = self getentitynumber();
    var_1 = 0;

    if ( !isdefined( self.bot_spawned_before ) )
    {
        var_1 = 1;
        self.bot_spawned_before = 1;

        if ( !bot_gametype_chooses_team() )
        {
            self notify( "luinotifyserver",  "team_select", bot_lui_convert_team_to_int( var_0 )  );
            wait 0.5;

            if ( self.pers["team"] == "spectator" )
            {
                bot_drop();
                return;
            }
        }
    }

    for (;;)
    {
        maps\mp\bots\_bots_util::bot_set_difficulty( self botgetdifficulty() );
        var_2 = self botgetdifficultysetting( "advancedPersonality" );

        if ( var_1 && isdefined( var_2 ) && var_2 != 0 )
            maps\mp\bots\_bots_personality::bot_balance_personality();

        maps\mp\bots\_bots_personality::_ID5500();

        if ( var_1 )
        {
            _ID5772();

            if ( !bot_gametype_chooses_class() )
                self notify( "luinotifyserver",  "class_select", self.bot_class  );

            if ( self.health == 0 )
                self waittill( "spawned_player" );

            if ( isdefined( level.bot_funcs ) && isdefined( level.bot_funcs["know_enemies_on_start"] ) )
                self thread [[ level.bot_funcs["know_enemies_on_start"] ]]();

            var_1 = 0;
        }

        bot_restart_think_threads();
        wait 0.1;
        self waittill( "death" );
        _ID26163();
        self waittill( "spawned_player" );
    }
}

_ID26163()
{
    self endon( "started_spawnPlayer" );

    while ( !self._ID35591 )
        wait 0.05;

    if ( maps\mp\gametypes\_playerlogic::_ID21905() )
    {
        while ( self._ID35591 )
        {
            if ( self.sessionstate == "spectator" )
            {
                if ( getdvarint( "numlives" ) == 0 || self.pers["lives"] > 0 )
                    self botpressbutton( "use", 0.5 );
            }

            wait 1.0;
        }
    }
}

bot_get_rank_xp()
{
    if ( maps\mp\_utility::_ID36859() == 0 )
    {
        if ( !isdefined( self.pers["rankxp"] ) )
            self.pers["rankxp"] = 0;

        return self.pers["rankxp"];
    }

    var_0 = self botgetdifficulty();
    var_1 = "bot_rank_" + var_0;

    if ( isdefined( self.pers[var_1] ) && self.pers[var_1] > 0 )
        return self.pers[var_1];

    var_2 = bot_random_ranks_for_difficulty( var_0 );
    var_3 = var_2["rank"];
    var_4 = var_2["prestige"];
    var_5 = maps\mp\gametypes\_rank::_ID15303( var_3 );
    var_6 = var_5 + maps\mp\gametypes\_rank::_ID15304( var_3 );
    var_7 = randomintrange( var_5, var_6 + 1 );
    self.pers[var_1] = var_7;
    return var_7;
}

bot_3d_sighting_model( var_0 )
{
    thread bot_3d_sighting_model_thread( var_0 );
}

bot_3d_sighting_model_thread( var_0 )
{
    var_0 endon( "disconnect" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( isalive( self ) && !self botcanseeentity( var_0 ) && common_scripts\utility::_ID36376( self.origin, self.angles, var_0.origin, self botgetfovdot() ) )
            self botgetimperfectenemyinfo( var_0, var_0.origin );

        wait 0.1;
    }
}

bot_random_ranks_for_difficulty( var_0 )
{
    var_1 = [];
    var_1["rank"] = 0;
    var_1["prestige"] = 0;

    if ( var_0 == "default" )
        return var_1;

    if ( !isdefined( level.bot_rnd_rank ) )
    {
        level.bot_rnd_rank = [];
        level.bot_rnd_rank["recruit"][0] = 0;
        level.bot_rnd_rank["recruit"][1] = 7;
        level.bot_rnd_rank["regular"][0] = 9;
        level.bot_rnd_rank["regular"][1] = 37;
        level.bot_rnd_rank["hardened"][0] = 39;
        level.bot_rnd_rank["hardened"][1] = 57;
        level.bot_rnd_rank["veteran"][0] = 59;
        level.bot_rnd_rank["veteran"][1] = 59;
    }

    if ( !isdefined( level.bot_rnd_prestige ) )
    {
        level.bot_rnd_prestige = [];
        level.bot_rnd_prestige["recruit"][0] = 0;
        level.bot_rnd_prestige["recruit"][1] = 0;
        level.bot_rnd_prestige["regular"][0] = 0;
        level.bot_rnd_prestige["regular"][1] = 0;
        level.bot_rnd_prestige["hardened"][0] = 0;
        level.bot_rnd_prestige["hardened"][1] = 0;
        level.bot_rnd_prestige["veteran"][0] = 0;
        level.bot_rnd_prestige["veteran"][1] = 9;
    }

    if ( isdefined( level.bot_rnd_rank[var_0][0] ) && isdefined( level.bot_rnd_rank[var_0][1] ) )
        var_1["rank"] = randomintrange( level.bot_rnd_rank[var_0][0], level.bot_rnd_rank[var_0][1] + 1 );

    if ( isdefined( level.bot_rnd_prestige[var_0][0] ) && isdefined( level.bot_rnd_prestige[var_0][1] ) )
        var_1["prestige"] = randomintrange( level.bot_rnd_prestige[var_0][0], level.bot_rnd_prestige[var_0][1] + 1 );

    return var_1;
}

crate_can_use_always( var_0 )
{
    if ( isagent( self ) && !isdefined( var_0.boxtype ) )
        return 0;

    return 1;
}

get_human_player()
{
    var_0 = undefined;
    var_1 = getentarray( "player", "classname" );

    if ( isdefined( var_1 ) )
    {
        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            if ( isdefined( var_1[var_2] ) && isdefined( var_1[var_2]._ID7864 ) && var_1[var_2]._ID7864 && !isai( var_1[var_2] ) && ( !isdefined( var_0 ) || var_0.team == "spectator" ) )
                var_0 = var_1[var_2];
        }
    }

    return var_0;
}

bot_damage_callback( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( self ) || !isalive( self ) )
        return;

    if ( var_2 == "MOD_FALLING" || var_2 == "MOD_SUICIDE" )
        return;

    if ( var_1 <= 0 )
        return;

    if ( !isdefined( var_4 ) )
    {
        if ( !isdefined( var_0 ) )
            return;

        var_4 = var_0;
    }

    if ( isdefined( var_4 ) )
    {
        if ( level._ID32653 )
        {
            if ( isdefined( var_4.team ) && var_4.team == self.team )
                return;
            else if ( isdefined( var_0 ) && isdefined( var_0.team ) && var_0.team == self.team )
                return;
        }

        var_6 = maps\mp\bots\_bots_util::bot_get_known_attacker( var_0, var_4 );

        if ( isdefined( var_6 ) )
            self botsetattacker( var_6 );
    }
}

_ID22747( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    self botclearscriptenemy();
    self botclearscriptgoal();
    var_10 = maps\mp\bots\_bots_util::bot_get_known_attacker( var_1, var_0 );

    if ( !maps\mp\_utility::bot_is_fireteam_mode() && getdvar( "squad_match" ) != "1" && getdvar( "squad_vs_squad" ) != "1" && isdefined( var_10 ) && var_10.classname == "script_vehicle" && isdefined( var_10._ID16760 ) )
    {
        var_11 = self botgetdifficultysetting( "launcherRespawnChance" );

        if ( randomfloat( 1.0 ) < var_11 )
            self.respawn_with_launcher = 1;
    }
}

bot_should_do_killcam()
{
    if ( maps\mp\_utility::bot_is_fireteam_mode() )
        return 0;

    var_0 = 0.0;
    var_1 = self botgetdifficulty();

    if ( var_1 == "recruit" )
        var_0 = 0.1;
    else if ( var_1 == "regular" )
        var_0 = 0.4;
    else if ( var_1 == "hardened" )
        var_0 = 0.7;
    else if ( var_1 == "veteran" )
        var_0 = 1.0;

    return randomfloat( 1.0 ) < 1.0 - var_0;
}

bot_should_pickup_weapons()
{
    if ( maps\mp\_utility::_ID18666() )
        return 0;

    return 1;
}

bot_restart_think_threads()
{
    thread bot_think_watch_enemy();
    thread maps\mp\bots\_bots_strategy::bot_think_tactical_goals();
    self thread [[ level.bot_funcs["dropped_weapon_think"] ]]();
    thread _ID5808();
    thread bot_think_crate();
    thread bot_think_crate_blocking_path();
    thread maps\mp\bots\_bots_ks::bot_think_killstreak();
    thread maps\mp\bots\_bots_ks::_ID5812();
    thread bot_think_gametype();
}

bot_think_watch_enemy( var_0 )
{
    var_1 = "spawned_player";

    if ( isdefined( var_0 ) && var_0 )
        var_1 = "death";

    self notify( "bot_think_watch_enemy" );
    self endon( "bot_think_watch_enemy" );
    self endon( var_1 );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self.last_enemy_sight_time = gettime();

    for (;;)
    {
        if ( isdefined( self.enemy ) )
        {
            if ( self botcanseeentity( self.enemy ) )
                self.last_enemy_sight_time = gettime();
        }

        wait 0.05;
    }
}

bot_think_seek_dropped_weapons()
{
    self notify( "bot_think_seek_dropped_weapons" );
    self endon( "bot_think_seek_dropped_weapons" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 = "throwingknife_mp";
    var_1 = "throwingknifejugg_mp";

    for (;;)
    {
        var_2 = 0;

        if ( maps\mp\bots\_bots_util::bot_out_of_ammo() && self [[ level.bot_funcs["should_pickup_weapons"] ]]() && !maps\mp\bots\_bots_util::bot_is_remote_or_linked() )
        {
            var_3 = getentarray( "dropped_weapon", "targetname" );
            var_4 = common_scripts\utility::_ID14293( self.origin, var_3 );

            if ( var_4.size > 0 )
            {
                var_5 = var_4[0];
                bot_seek_dropped_weapon( var_5 );
            }
        }

        if ( !maps\mp\bots\_bots_util::bot_in_combat() && !maps\mp\bots\_bots_util::bot_is_remote_or_linked() && self botgetdifficultysetting( "strategyLevel" ) > 0 )
        {
            var_6 = self hasweapon( var_0 );
            var_7 = self hasweapon( var_1 );
            var_8 = var_6 && self getammocount( var_0 ) == 0 || var_7 && self getammocount( var_1 ) == 0;

            if ( var_8 )
            {
                if ( isdefined( self._ID15736 ) )
                {
                    wait 5.0;
                    continue;
                }

                var_9 = getentarray( "dropped_knife", "targetname" );
                var_10 = common_scripts\utility::_ID14293( self.origin, var_9 );

                foreach ( var_12 in var_10 )
                {
                    if ( !isdefined( var_12 ) )
                        continue;

                    if ( !isdefined( var_12.calculated_closest_point ) )
                    {
                        var_13 = maps\mp\bots\_bots_util::bot_queued_process( "BotGetClosestNavigablePoint", maps\mp\bots\_bots_util::_ID13734, var_12.origin, 32, self );

                        if ( isdefined( var_12 ) )
                        {
                            var_12._ID7581 = var_13;
                            var_12.calculated_closest_point = 1;
                        }
                        else
                            continue;
                    }

                    if ( isdefined( var_12._ID7581 ) )
                    {
                        self._ID15736 = 1;
                        bot_seek_dropped_weapon( var_12 );
                    }
                }
            }
            else if ( var_6 || var_7 )
                self._ID15736 = undefined;
        }

        wait(randomfloatrange( 0.25, 0.75 ));
    }
}

bot_seek_dropped_weapon( var_0 )
{
    if ( maps\mp\bots\_bots_strategy::bot_has_tactical_goal( "seek_dropped_weapon", var_0 ) == 0 )
    {
        var_1 = undefined;

        if ( var_0.targetname == "dropped_weapon" )
        {
            var_2 = 1;
            var_3 = self getweaponslistprimaries();

            foreach ( var_5 in var_3 )
            {
                if ( var_0.model == getweaponmodel( var_5 ) )
                    var_2 = 0;
            }

            if ( var_2 )
                var_1 = ::bot_pickup_weapon;
        }

        var_7 = spawnstruct();
        var_7._ID22470 = var_0;
        var_7.script_goal_radius = 12;
        var_7._ID29800 = level.bot_funcs["dropped_weapon_cancel"];
        var_7.action_thread = var_1;
        maps\mp\bots\_bots_strategy::bot_new_tactical_goal( "seek_dropped_weapon", var_0.origin, 100, var_7 );
    }
}

bot_pickup_weapon( var_0 )
{
    self botpressbutton( "use", 2 );
    wait 2;
}

_ID29841( var_0 )
{
    if ( !isdefined( var_0._ID22470 ) )
        return 1;

    if ( var_0._ID22470.targetname == "dropped_weapon" )
    {
        if ( maps\mp\bots\_bots_util::bot_get_total_gun_ammo() > 0 )
            return 1;
    }
    else if ( var_0._ID22470.targetname == "dropped_knife" )
    {
        if ( maps\mp\bots\_bots_util::bot_in_combat() )
        {
            self._ID15736 = undefined;
            return 1;
        }
    }

    return 0;
}

_ID5808( var_0 )
{
    self notify( "bot_think_level_actions" );
    self endon( "bot_think_level_actions" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        common_scripts\utility::waittill_notify_or_timeout( "calculate_new_level_targets", randomfloatrange( 2, 10 ) );

        if ( !isdefined( level._ID19884 ) || level._ID19884.size == 0 )
            continue;

        if ( maps\mp\bots\_bots_strategy::bot_has_tactical_goal( "map_interactive_object" ) )
            continue;

        if ( maps\mp\bots\_bots_util::bot_in_combat() || maps\mp\bots\_bots_util::bot_is_remote_or_linked() )
            continue;

        var_1 = undefined;

        foreach ( var_3 in level._ID19884 )
        {
            if ( common_scripts\utility::array_contains( var_3.high_priority_for, self ) )
            {
                var_1 = var_3;
                break;
            }
        }

        if ( !isdefined( var_1 ) )
        {
            if ( randomint( 100 ) > 25 )
                continue;

            var_5 = common_scripts\utility::_ID14293( self.origin, level._ID19884 );
            var_6 = 256;

            if ( isdefined( var_0 ) )
                var_6 = var_0;
            else if ( self botgetscriptgoaltype() == "hunt" && self botpursuingscriptgoal() )
                var_6 = 512;

            if ( distancesquared( self.origin, var_5[0].origin ) > var_6 * var_6 )
                continue;

            var_1 = var_5[0];
        }

        var_7 = 0;

        if ( var_1.bot_interaction_type == "damage" )
        {
            var_7 = _ID5781( var_1 );

            if ( var_7 )
            {
                var_8 = var_1.origin[2] - var_1.bot_targets[0].origin[2] + 55;
                var_9 = var_1.origin[2] - var_1.bot_targets[1].origin[2] + 55;

                if ( var_8 > 55 && var_9 > 55 )
                {
                    if ( common_scripts\utility::array_contains( var_1.high_priority_for, self ) )
                        var_1.high_priority_for = common_scripts\utility::array_remove( var_1.high_priority_for, self );

                    continue;
                }
            }

            var_10 = weaponclass( self getcurrentweapon() );

            if ( var_10 == "spread" )
            {
                var_11 = var_1.bot_targets[0].origin - var_1.origin;
                var_12 = var_1.bot_targets[1].origin - var_1.origin;
                var_13 = lengthsquared( var_11 );
                var_14 = lengthsquared( var_12 );

                if ( var_13 > 22500 && var_14 > 22500 )
                {
                    if ( common_scripts\utility::array_contains( var_1.high_priority_for, self ) )
                        var_1.high_priority_for = common_scripts\utility::array_remove( var_1.high_priority_for, self );

                    continue;
                }
            }
        }

        var_15 = spawnstruct();
        var_15._ID22470 = var_1;

        if ( var_1.bot_interaction_type == "damage" )
        {
            if ( var_7 )
                var_15._ID29800 = ::_ID19889;
            else
                var_15._ID29800 = ::_ID19890;
        }

        if ( var_1.bot_interaction_type == "use" )
        {
            var_15.action_thread = ::_ID34722;
            var_15._ID29800 = ::_ID19888;
            var_15._ID27625 = vectortoangles( var_1.origin - var_1.bot_target.origin )[1];
            maps\mp\bots\_bots_strategy::bot_new_tactical_goal( "map_interactive_object", var_1.bot_target.origin, 10, var_15 );
            continue;
        }

        if ( var_1.bot_interaction_type == "damage" )
        {
            if ( var_7 )
            {
                var_15.action_thread = ::_ID20819;
                var_15.script_goal_radius = 20;
            }
            else
            {
                var_15.action_thread = ::attack_damage_trigger;
                var_15.script_goal_radius = 50;
            }

            var_16 = undefined;
            var_17 = maps\mp\bots\_bots_util::bot_queued_process( "GetPathDistLevelAction", maps\mp\bots\_bots_util::_ID13740, self.origin, var_1.bot_targets[0].origin );
            var_18 = maps\mp\bots\_bots_util::bot_queued_process( "GetPathDistLevelAction", maps\mp\bots\_bots_util::_ID13740, self.origin, var_1.bot_targets[1].origin );

            if ( !isdefined( var_1 ) )
                continue;

            if ( var_17 <= 0 && var_18 <= 0 )
                continue;

            if ( var_17 > 0 )
            {
                if ( var_18 < 0 || var_17 <= var_18 )
                    var_16 = var_1.bot_targets[0];
            }

            if ( var_18 > 0 )
            {
                if ( var_17 < 0 || var_18 <= var_17 )
                    var_16 = var_1.bot_targets[1];
            }

            if ( !var_7 )
                childthread _ID21329( var_16 );

            maps\mp\bots\_bots_strategy::bot_new_tactical_goal( "map_interactive_object", var_16.origin, 10, var_15 );
        }
    }
}

_ID5781( var_0 )
{
    var_1 = self getcurrentweapon();
    var_2 = maps\mp\bots\_bots_util::bot_out_of_ammo() || self._ID16417 || isdefined( self._ID18669 ) && self._ID18669 == 1 || weaponclass( var_1 ) == "grenade" || var_1 == "iw6_knifeonly_mp" || var_1 == "iw6_knifeonlyfast_mp";
    return var_2;
}

_ID21329( var_0 )
{
    self endon( "goal" );
    wait 0.1;

    for (;;)
    {
        if ( weaponclass( self getcurrentweapon() ) == "spread" )
        {
            if ( distancesquared( self.origin, var_0.origin ) > 90000 )
            {
                wait 0.05;
                continue;
            }
        }

        var_1 = self getnearestnode();

        if ( isdefined( var_1 ) )
        {
            if ( nodesvisible( var_1, var_0 ) )
            {
                if ( sighttracepassed( self.origin + ( 0, 0, 55 ), var_0.origin + ( 0, 0, 55 ), 0, self ) )
                    self notify( "goal" );
            }
        }

        wait 0.05;
    }
}

attack_damage_trigger( var_0 )
{
    if ( var_0._ID22470.origin[2] - self geteye()[2] > 55 )
    {
        if ( distance2dsquared( var_0._ID22470.origin, self.origin ) < 225 )
            return;
    }

    self botsetflag( "disable_movement", 1 );
    _ID20289( var_0._ID22470, 0.3 );
    self botpressbutton( "ads", 0.3 );
    wait 0.25;
    var_1 = gettime();

    while ( isdefined( var_0._ID22470 ) && !isdefined( var_0._ID22470._ID3208 ) && gettime() - var_1 < 5000 )
    {
        _ID20289( var_0._ID22470, 0.15 );
        self botpressbutton( "ads", 0.15 );
        self botpressbutton( "attack" );
        wait 0.1;
    }

    self botsetflag( "disable_movement", 0 );
}

_ID20819( var_0 )
{
    self botsetflag( "disable_movement", 1 );
    _ID20289( var_0._ID22470, 0.3 );
    wait 0.25;
    var_1 = gettime();

    while ( isdefined( var_0._ID22470 ) && !isdefined( var_0._ID22470._ID3208 ) && gettime() - var_1 < 5000 )
    {
        _ID20289( var_0._ID22470, 0.15 );
        self botpressbutton( "melee" );
        wait 0.1;
    }

    self botsetflag( "disable_movement", 0 );
}

_ID20289( var_0, var_1 )
{
    var_2 = var_0.origin;

    if ( distance2dsquared( self.origin, var_2 ) < 100 )
        var_2 = ( var_2[0], var_2[1], self geteye()[2] );

    self botlookatpoint( var_2, var_1, "script_forced" );
}

_ID34722( var_0 )
{
    if ( isagent( self ) )
    {
        common_scripts\utility::_enableusability();
        var_0._ID22470 enableplayeruse( self );
        wait 0.05;
    }

    var_1 = var_0._ID22470._ID34718;
    self botpressbutton( "use", var_1 );
    wait(var_1);

    if ( isagent( self ) )
    {
        common_scripts\utility::_disableusability();

        if ( isdefined( var_0._ID22470 ) )
            var_0._ID22470 disableplayeruse( self );
    }
}

_ID19889( var_0 )
{
    if ( _ID19888( var_0 ) )
        return 1;

    if ( !_ID5781( var_0._ID22470 ) )
        return 1;

    return 0;
}

_ID19890( var_0 )
{
    if ( _ID19888( var_0 ) )
        return 1;

    if ( _ID5781( var_0._ID22470 ) )
        return 1;

    return 0;
}

_ID19888( var_0 )
{
    if ( !isdefined( var_0._ID22470 ) )
        return 1;

    if ( isdefined( var_0._ID22470._ID3208 ) )
        return 1;

    if ( maps\mp\bots\_bots_util::bot_in_combat() )
        return 1;

    return 0;
}

_ID8240( var_0 )
{
    if ( !isdefined( var_0.owner ) || var_0.owner != self )
    {
        if ( distancesquared( self.origin, var_0.origin ) > 4194304 )
            return 0;
    }

    return 1;
}

bot_crate_valid( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( !self [[ level.bot_funcs["crate_can_use"] ]]( var_0 ) )
        return 0;

    if ( !_ID8242( var_0 ) )
        return 0;

    if ( level._ID32653 && isdefined( var_0.bomb ) && isdefined( var_0.team ) && var_0.team == self.team )
        return 0;

    if ( !self [[ level.bot_funcs["crate_in_range"] ]]( var_0 ) )
        return 0;

    if ( isdefined( var_0.boxtype ) )
    {
        if ( isdefined( level.boxsettings[var_0.boxtype] ) && ![[ level.boxsettings[var_0.boxtype].canusecallback ]]() )
            return 0;

        if ( isdefined( var_0.disabled_use_for ) && isdefined( var_0.disabled_use_for[self getentitynumber()] ) && var_0.disabled_use_for[self getentitynumber()] )
            return 0;

        if ( !self [[ level.bot_can_use_box_by_type[var_0.boxtype] ]]( var_0 ) )
            return 0;
    }

    return isdefined( var_0 );
}

_ID8242( var_0 )
{
    if ( !_ID8239( var_0 ) )
        return 0;

    if ( !_ID8241( var_0 ) )
        return 0;

    return isdefined( var_0 );
}

_ID8239( var_0 )
{
    if ( isdefined( var_0.boxtype ) )
        return gettime() > var_0.birthtime + 1000;
    else
        return isdefined( var_0.droppingtoground ) && !var_0.droppingtoground;
}

_ID8241( var_0 )
{
    if ( !isdefined( var_0.on_path_grid ) )
        crate_calculate_on_path_grid( var_0 );

    return isdefined( var_0 ) && var_0.on_path_grid;
}

node_within_use_radius_of_crate( var_0, var_1 )
{
    if ( isdefined( var_1.boxtype ) && var_1.boxtype == "scavenger_bag" )
        return abs( var_0.origin[0] - var_1.origin[0] ) < 36 && abs( var_0.origin[0] - var_1.origin[0] ) < 36 && abs( var_0.origin[0] - var_1.origin[0] ) < 18;
    else
    {
        var_2 = getdvarfloat( "player_useRadius" );
        var_3 = distancesquared( var_1.origin, var_0.origin + ( 0, 0, 40 ) );
        return var_3 <= var_2 * var_2;
    }
}

crate_calculate_on_path_grid( var_0 )
{
    var_0 thread _ID8244();
    var_0.on_path_grid = 0;
    var_1 = undefined;
    var_2 = undefined;

    if ( isdefined( var_0._ID13519 ) )
    {
        var_1 = var_0._ID13519;
        var_2 = gettime() + 30000;
        var_0._ID13519 = var_2;
        var_0 notify( "path_disconnect" );
    }

    wait 0.05;

    if ( !isdefined( var_0 ) )
        return;

    var_3 = _ID8238( var_0 );

    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_3 ) && var_3.size > 0 )
    {
        var_0.nearest_nodes = var_3;
        var_0.on_path_grid = 1;
    }
    else
    {
        var_4 = getdvarfloat( "player_useRadius" );
        var_5 = getnodesinradiussorted( var_0.origin, var_4 * 2, 0 )[0];
        var_6 = var_0 getpointinbounds( 0, 0, -1 );
        var_7 = undefined;

        if ( isdefined( var_0.boxtype ) && var_0.boxtype == "scavenger_bag" )
        {
            if ( maps\mp\bots\_bots_util::bot_point_is_on_pathgrid( var_0.origin ) )
                var_7 = var_0.origin;
        }
        else
            var_7 = botgetclosestnavigablepoint( var_0.origin, var_4 );

        if ( isdefined( var_5 ) && !var_5 nodeisdisconnected() && isdefined( var_7 ) && abs( var_5.origin[2] - var_6[2] ) < 30 )
        {
            var_0._ID21896 = [ var_7 ];
            var_0.nearest_nodes = [ var_5 ];
            var_0.on_path_grid = 1;
        }
    }

    if ( isdefined( var_0._ID13519 ) )
    {
        if ( var_0._ID13519 == var_2 )
            var_0._ID13519 = var_1;
    }
}

_ID8238( var_0 )
{
    var_1 = getnodesinradiussorted( var_0.origin, 256, 0 );

    for ( var_2 = var_1.size; var_2 > 0; var_2-- )
        var_1[var_2] = var_1[var_2 - 1];

    var_1[0] = getclosestnodeinsight( var_0.origin );
    var_3 = undefined;

    if ( isdefined( var_0._ID13519 ) )
        var_3 = getallnodes();

    var_4 = [];
    var_5 = 1;

    if ( !isdefined( var_0.boxtype ) )
        var_5 = 2;

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_6 = var_1[var_2];

        if ( !isdefined( var_6 ) || !isdefined( var_0 ) )
            continue;

        if ( var_6 nodeisdisconnected() )
            continue;

        if ( !node_within_use_radius_of_crate( var_6, var_0 ) )
        {
            if ( var_2 == 0 )
                continue;
            else
                break;
        }

        wait 0.05;

        if ( !isdefined( var_0 ) )
            break;

        if ( sighttracepassed( var_0.origin, var_6.origin + ( 0, 0, 55 ), 0, var_0 ) )
        {
            wait 0.05;

            if ( !isdefined( var_0 ) )
                break;

            if ( !isdefined( var_0._ID13519 ) )
            {
                var_4[var_4.size] = var_6;

                if ( var_4.size == var_5 )
                    return var_4;
                else
                    continue;
            }

            var_7 = undefined;
            var_8 = 0;

            while ( !isdefined( var_7 ) && var_8 < 100 )
            {
                var_8++;
                var_9 = common_scripts\utility::_ID25350( var_3 );

                if ( distancesquared( var_6.origin, var_9.origin ) > 250000 )
                    var_7 = var_9;
            }

            if ( isdefined( var_7 ) )
            {
                var_10 = maps\mp\bots\_bots_util::bot_queued_process( "GetNodesOnPathCrate", maps\mp\bots\_bots_util::func_get_nodes_on_path, var_6.origin, var_7.origin );

                if ( isdefined( var_10 ) )
                {
                    var_4[var_4.size] = var_6;

                    if ( var_4.size == var_5 )
                    {
                        return var_4;
                        continue;
                    }

                    continue;
                }
            }
        }
    }

    return undefined;
}

crate_get_bot_target( var_0 )
{
    if ( isdefined( var_0._ID21896 ) )
        return var_0._ID21896[0];

    if ( isdefined( var_0.nearest_nodes ) )
    {
        if ( var_0.nearest_nodes.size > 1 )
        {
            var_1 = common_scripts\utility::array_reverse( self botnodescoremultiple( var_0.nearest_nodes, "node_exposed" ) );
            return common_scripts\utility::random_weight_sorted( var_1 ).origin;
        }
        else
            return var_0.nearest_nodes[0].origin;
    }
}

crate_get_bot_target_check_distance( var_0, var_1 )
{
    var_2 = crate_get_bot_target( var_0 );
    var_3 = var_1 * 0.9;
    var_3 *= var_3;

    if ( distancesquared( var_0.origin, var_2 ) <= var_3 )
        return var_2;
    else
        return undefined;
}

bot_think_crate()
{
    self notify( "bot_think_crate" );
    self endon( "bot_think_crate" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 = getdvarfloat( "player_useRadius" );

    for (;;)
    {
        var_1 = randomfloatrange( 2, 4 );
        common_scripts\utility::waittill_notify_or_timeout( "new_crate_to_take", var_1 );

        if ( isdefined( self.boxes ) && self.boxes.size == 0 )
            self.boxes = undefined;

        var_2 = level._ID6711;

        if ( !maps\mp\bots\_bots_util::bot_in_combat() && isdefined( self.boxes ) )
            var_2 = common_scripts\utility::array_combine( var_2, self.boxes );

        if ( isdefined( level._ID5753 ) && maps\mp\_utility::_hasperk( "specialty_scavenger" ) )
            var_2 = common_scripts\utility::array_combine( var_2, level._ID5753 );

        var_2 = common_scripts\utility::array_removeundefined( var_2 );

        if ( var_2.size == 0 )
            continue;

        if ( maps\mp\bots\_bots_strategy::bot_has_tactical_goal( "airdrop_crate" ) || self botgetscriptgoaltype() == "tactical" || maps\mp\bots\_bots_util::bot_is_remote_or_linked() )
            continue;

        var_3 = [];

        foreach ( var_5 in var_2 )
        {
            if ( bot_crate_valid( var_5 ) )
                var_3[var_3.size] = var_5;
        }

        var_3 = common_scripts\utility::array_remove_duplicates( var_3 );

        if ( var_3.size == 0 )
            continue;

        var_3 = common_scripts\utility::_ID14293( self.origin, var_3 );
        var_7 = self getnearestnode();

        if ( !isdefined( var_7 ) )
            continue;

        var_8 = self [[ level.bot_funcs["crate_low_ammo_check"] ]]();
        var_9 = ( var_8 || randomint( 100 ) < 50 ) && !maps\mp\_utility::_ID18610();
        var_10 = undefined;

        foreach ( var_5 in var_3 )
        {
            var_12 = 0;

            if ( ( !isdefined( var_5.owner ) || var_5.owner != self ) && !isdefined( var_5.boxtype ) )
            {
                var_13 = [];

                foreach ( var_15 in level.players )
                {
                    if ( !isdefined( var_15.team ) )
                        continue;

                    if ( !isai( var_15 ) && level._ID32653 && var_15.team == self.team )
                    {
                        if ( distancesquared( var_15.origin, var_5.origin ) < 490000 )
                            var_13[var_13.size] = var_15;
                    }
                }

                if ( var_13.size > 0 )
                {
                    var_17 = var_13[0] getnearestnode();

                    if ( isdefined( var_17 ) )
                    {
                        var_12 = 0;

                        foreach ( var_19 in var_5.nearest_nodes )
                            var_12 |= nodesvisible( var_17, var_19, 1 );
                    }
                }
            }

            if ( !var_12 )
            {
                var_21 = isdefined( var_5._ID5846 ) && isdefined( var_5._ID5846[self.team] ) && var_5._ID5846[self.team] > 0;
                var_22 = 0;

                foreach ( var_19 in var_5.nearest_nodes )
                    var_22 |= nodesvisible( var_7, var_19, 1 );

                if ( var_22 || var_9 && !var_21 )
                {
                    var_10 = var_5;
                    break;
                }
            }
        }

        if ( isdefined( var_10 ) )
        {
            if ( self [[ level.bot_funcs["crate_should_claim"] ]]() )
            {
                if ( !isdefined( var_10.boxtype ) )
                {
                    if ( !isdefined( var_10._ID5846 ) )
                        var_10._ID5846 = [];

                    var_10._ID5846[self.team] = 1;
                }
            }

            var_26 = spawnstruct();
            var_26._ID22470 = var_10;
            var_26._ID31408 = ::_ID35931;
            var_26._ID29800 = ::crate_picked_up;
            var_27 = undefined;

            if ( isdefined( var_10.boxtype ) )
            {
                if ( isdefined( var_10.boxtouchonly ) && var_10.boxtouchonly )
                {
                    var_26.script_goal_radius = 16;
                    var_26.action_thread = undefined;
                    var_27 = var_10.origin;
                }
                else
                {
                    var_26.script_goal_radius = 50;
                    var_26.action_thread = ::_ID34682;
                    var_28 = crate_get_bot_target_check_distance( var_10, var_0 );

                    if ( !isdefined( var_28 ) )
                        continue;

                    var_28 -= var_10.origin;
                    var_29 = length( var_28 ) * randomfloat( 1.0 );
                    var_27 = var_10.origin + vectornormalize( var_28 ) * var_29 + ( 0, 0, 12 );
                }
            }
            else
            {
                var_26.action_thread = ::_ID34684;
                var_26.end_thread = ::_ID31828;
                var_27 = crate_get_bot_target_check_distance( var_10, var_0 );

                if ( !isdefined( var_27 ) )
                    continue;

                var_26.script_goal_radius = var_0 - distance( var_10.origin, var_27 + ( 0, 0, 40 ) );
                var_27 += ( 0, 0, 24 );
            }

            if ( isdefined( var_26.script_goal_radius ) )
            {

            }

            var_10 notify( "path_disconnect" );
            wait 0.05;

            if ( !isdefined( var_10 ) )
                continue;

            maps\mp\bots\_bots_strategy::bot_new_tactical_goal( "airdrop_crate", var_27, 30, var_26 );
        }
    }
}

_ID5784( var_0 )
{
    return 1;
}

_ID8246()
{
    return 1;
}

crate_low_ammo_check()
{
    return 0;
}

bot_should_use_ammo_crate( var_0 )
{
    if ( self getcurrentweapon() == level.boxsettings[var_0.boxtype]._ID21116 )
        return 0;

    return 1;
}

_ID5734( var_0 )
{
    self switchtoweapon( self._ID27984 );
    wait 1.0;
}

bot_post_use_ammo_crate( var_0 )
{
    self switchtoweapon( "none" );
    self._ID27984 = self getcurrentweapon();
}

bot_should_use_scavenger_bag( var_0 )
{
    if ( maps\mp\bots\_bots_util::_ID5606( 0.66 ) )
    {
        var_1 = self getnearestnode();

        if ( isdefined( var_0.nearest_nodes ) && isdefined( var_0.nearest_nodes[0] ) && isdefined( var_1 ) )
        {
            if ( nodesvisible( var_1, var_0.nearest_nodes[0], 1 ) )
            {
                if ( common_scripts\utility::_ID36376( self.origin, self.angles, var_0.origin, self botgetfovdot() ) )
                    return 1;
            }
        }
    }

    return 0;
}

bot_should_use_grenade_crate( var_0 )
{
    var_1 = self getweaponslistoffhands();

    foreach ( var_3 in var_1 )
    {
        if ( self getweaponammostock( var_3 ) == 0 )
            return 1;
    }

    return 0;
}

_ID5786( var_0 )
{
    return 1;
}

_ID8244()
{
    self notify( "crate_monitor_position" );
    self endon( "crate_monitor_position" );
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = self.origin;
        wait 0.5;

        if ( !isalive( self ) )
            return;

        if ( !maps\mp\bots\_bots_util::_ID5824( self.origin, var_0 ) )
        {
            self.on_path_grid = undefined;
            self.nearest_nodes = undefined;
            self._ID21896 = undefined;
        }
    }
}

_ID8247()
{

}

crate_picked_up( var_0 )
{
    if ( !isdefined( var_0._ID22470 ) )
        return 1;

    return 0;
}

_ID34684( var_0 )
{
    if ( isagent( self ) )
    {
        common_scripts\utility::_enableusability();
        var_0._ID22470 enableplayeruse( self );
        wait 0.05;
    }

    self [[ level.bot_funcs["crate_wait_use"] ]]();

    if ( isdefined( var_0._ID22470.owner ) && var_0._ID22470.owner == self )
        var_1 = level.crateownerusetime / 1000 + 0.5;
    else
        var_1 = level.cratenonownerusetime / 1000 + 1.0;

    self botpressbutton( "use", var_1 );
    wait(var_1);

    if ( isagent( self ) )
    {
        common_scripts\utility::_disableusability();

        if ( isdefined( var_0._ID22470 ) )
            var_0._ID22470 disableplayeruse( self );
    }

    if ( isdefined( var_0._ID22470 ) )
    {
        if ( !isdefined( var_0._ID22470.bots_used ) )
            var_0._ID22470.bots_used = [];

        var_0._ID22470.bots_used[var_0._ID22470.bots_used.size] = self;
    }
}

_ID34682( var_0 )
{
    if ( isagent( self ) )
    {
        common_scripts\utility::_enableusability();
        var_0._ID22470 enableplayeruse( self );
        wait 0.05;
    }

    if ( isdefined( var_0._ID22470 ) && isdefined( var_0._ID22470.boxtype ) )
    {
        var_1 = var_0._ID22470.boxtype;

        if ( isdefined( level.bot_pre_use_box_of_type[var_1] ) )
            self [[ level.bot_pre_use_box_of_type[var_1] ]]( var_0._ID22470 );

        if ( isdefined( var_0._ID22470 ) )
        {
            var_2 = level.boxsettings[var_0._ID22470.boxtype]._ID34780 / 1000 + 0.5;
            self botpressbutton( "use", var_2 );
            wait(var_2);

            if ( isdefined( level.bot_post_use_box_of_type[var_1] ) )
                self [[ level.bot_post_use_box_of_type[var_1] ]]( var_0._ID22470 );
        }
    }

    if ( isagent( self ) )
    {
        common_scripts\utility::_disableusability();

        if ( isdefined( var_0._ID22470 ) )
            var_0._ID22470 disableplayeruse( self );
    }
}

_ID35931( var_0 )
{
    thread _ID5834( var_0._ID22470 );
}

_ID31828( var_0 )
{
    if ( isdefined( var_0._ID22470 ) )
        var_0._ID22470._ID5846[self.team] = 0;
}

_ID5834( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "revived" );
    var_0 endon( "disconnect" );
    level endon( "game_ended" );
    var_1 = self.team;
    common_scripts\utility::_ID35626( "death", "disconnect" );

    if ( isdefined( var_0 ) )
        var_0._ID5846[var_1] = 0;
}

bot_think_crate_blocking_path()
{
    self notify( "bot_think_crate_blocking_path" );
    self endon( "bot_think_crate_blocking_path" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 = getdvarfloat( "player_useRadius" );

    for (;;)
    {
        wait 3;

        if ( self usebuttonpressed() )
            continue;

        if ( maps\mp\_utility::_ID18837() )
            continue;

        var_1 = level._ID6711;

        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            var_3 = var_1[var_2];

            if ( !isdefined( var_3 ) )
                continue;

            if ( distancesquared( self.origin, var_3.origin ) < var_0 * var_0 )
            {
                if ( var_3.owner == self )
                {
                    self botpressbutton( "use", level.crateownerusetime / 1000 + 0.5 );
                    continue;
                }

                self botpressbutton( "use", level.cratenonownerusetime / 1000 + 0.5 );
            }
        }
    }
}

bot_think_revive()
{
    self notify( "bot_think_revive" );
    self endon( "bot_think_revive" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( !level._ID32653 )
        return;

    for (;;)
    {
        var_0 = 2.0;
        var_1 = getentarray( "revive_trigger", "targetname" );

        if ( var_1.size > 0 )
            var_0 = 0.05;

        level common_scripts\utility::waittill_notify_or_timeout( "player_last_stand", var_0 );

        if ( !bot_can_revive() )
            continue;

        var_1 = getentarray( "revive_trigger", "targetname" );

        if ( var_1.size > 1 )
        {
            var_1 = sortbydistance( var_1, self.origin );

            if ( isdefined( self.owner ) )
            {
                for ( var_2 = 0; var_2 < var_1.size; var_2++ )
                {
                    if ( var_1[var_2].owner != self.owner )
                        continue;

                    if ( var_2 == 0 )
                        break;

                    var_3 = var_1[var_2];
                    var_1[var_2] = var_1[0];
                    var_1[0] = var_3;
                    break;
                }
            }
        }

        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            var_4 = var_1[var_2];
            var_5 = var_4.owner;

            if ( !isdefined( var_5 ) )
                continue;

            if ( var_5 == self )
                continue;

            if ( !isalive( var_5 ) )
                continue;

            if ( var_5.team != self.team )
                continue;

            if ( !isdefined( var_5._ID18011 ) || !var_5._ID18011 )
                continue;

            if ( isdefined( var_5._ID5846 ) && isdefined( var_5._ID5846[self.team] ) && var_5._ID5846[self.team] > 0 )
                continue;

            if ( distancesquared( self.origin, var_5.origin ) < 4194304 )
            {
                var_6 = spawnstruct();
                var_6._ID22470 = var_4;
                var_6.script_goal_radius = 64;

                if ( isdefined( self._ID19485 ) && gettime() - self._ID19485 < 1000 )
                    var_6.script_goal_radius = 32;

                var_6._ID31408 = ::_ID35932;
                var_6.end_thread = ::_ID31815;
                var_6._ID29800 = ::_ID24285;
                var_6.action_thread = ::revive_player;
                maps\mp\bots\_bots_strategy::bot_new_tactical_goal( "revive", var_5.origin, 60, var_6 );
                break;
            }
        }
    }
}

_ID35932( var_0 )
{
    thread _ID5834( var_0._ID22470.owner );
}

_ID31815( var_0 )
{
    if ( isdefined( var_0._ID22470.owner ) )
        var_0._ID22470.owner._ID5846[self.team] = 0;
}

_ID24285( var_0 )
{
    if ( !isdefined( var_0._ID22470.owner ) || var_0._ID22470.owner.health <= 0 )
        return 1;

    if ( !isdefined( var_0._ID22470.owner._ID18011 ) || !var_0._ID22470.owner._ID18011 )
        return 1;

    return 0;
}

revive_player( var_0 )
{
    if ( distancesquared( self.origin, var_0._ID22470.owner.origin ) > 4096 )
    {
        self._ID19485 = gettime();
        return;
    }

    if ( isagent( self ) )
    {
        common_scripts\utility::_enableusability();
        var_0._ID22470 enableplayeruse( self );
        wait 0.05;
    }

    var_1 = self.team;
    self botpressbutton( "use", level.laststandusetime / 1000 + 0.5 );
    wait(level.laststandusetime / 1000 + 1.5);

    if ( isdefined( var_0._ID22470.owner ) )
        var_0._ID22470._ID5846[var_1] = 0;

    if ( isagent( self ) )
    {
        common_scripts\utility::_disableusability();

        if ( isdefined( var_0._ID22470 ) )
            var_0._ID22470 disableplayeruse( self );
    }
}

bot_can_revive()
{
    if ( isdefined( self.laststand ) && self.laststand == 1 )
        return 0;

    if ( maps\mp\bots\_bots_strategy::bot_has_tactical_goal( "revive" ) )
        return 0;

    if ( maps\mp\bots\_bots_util::bot_is_remote_or_linked() )
        return 0;

    if ( maps\mp\bots\_bots_util::bot_is_bodyguarding() )
        return 1;

    var_0 = self botgetscriptgoaltype();

    if ( var_0 == "none" || var_0 == "hunt" || var_0 == "guard" )
        return 1;

    return 0;
}

_ID26263( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "bad_path" );
    self endon( "goal" );
    var_0 common_scripts\utility::_ID35626( "death", "revived" );
    self notify( "bad_path" );
}

_ID5658()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( gettime() > 15000 )
        return;

    while ( !maps\mp\_utility::_ID14070() || !maps\mp\_utility::_ID14065( "prematch_done" ) )
        wait 0.05;

    var_0 = undefined;
    var_1 = undefined;

    for ( var_2 = 0; var_2 < level.players.size; var_2++ )
    {
        var_3 = level.players[var_2];

        if ( isdefined( var_3 ) && isdefined( self.team ) && isdefined( var_3.team ) && isenemyteam( self.team, var_3.team ) )
        {
            if ( !isdefined( var_3._ID5795 ) )
                var_0 = var_3;

            if ( isai( var_3 ) && !isdefined( var_3._ID5794 ) )
                var_1 = var_3;
        }
    }

    if ( isdefined( var_0 ) )
    {
        self._ID5794 = 1;
        var_0._ID5795 = 1;
        self getenemyinfo( var_0 );
    }

    if ( isdefined( var_1 ) )
    {
        var_1._ID5794 = 1;
        self._ID5795 = 1;
        var_1 getenemyinfo( self );
    }
}

_ID5680( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        return self makeentitysentient( var_0, var_1 );
    else
        return self makeentitysentient( var_0 );
}

bot_think_gametype()
{
    self notify( "bot_think_gametype" );
    self endon( "bot_think_gametype" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    maps\mp\_utility::gameflagwait( "prematch_done" );
    self thread [[ level.bot_funcs["gametype_think"] ]]();
}

_ID9365()
{

}

_ID21340()
{
    for (;;)
    {
        level waittill( "smoke",  var_0, var_1  );

        if ( var_1 == "smoke_grenade_mp" || var_1 == "smoke_grenadejugg_mp" || var_1 == "odin_projectile_smoke_mp" )
        {
            var_0 thread _ID16202( 9.0 );
            continue;
        }

        if ( var_1 == "odin_projectile_large_rod_mp" )
            var_0 thread _ID16202( 2.5 );
    }
}

_ID16202( var_0 )
{
    self waittill( "explode",  var_1  );
    var_2 = common_scripts\utility::_ID30774();
    var_2 show();
    var_2.origin = var_1;
    var_3 = 0.8;
    wait(var_3);
    var_3 = 0.5;
    var_4 = getent( "smoke_grenade_sight_clip_64_short", "targetname" );

    if ( isdefined( var_4 ) )
        var_2 clonebrushmodeltoscriptmodel( var_4 );

    wait(var_3);
    var_3 = 0.6;
    var_5 = getent( "smoke_grenade_sight_clip_64_tall", "targetname" );

    if ( isdefined( var_5 ) )
        var_2 clonebrushmodeltoscriptmodel( var_5 );

    wait(var_3);
    var_3 = var_0;
    var_6 = getent( "smoke_grenade_sight_clip_256", "targetname" );

    if ( isdefined( var_6 ) )
        var_2 clonebrushmodeltoscriptmodel( var_6 );

    wait(var_3);
    var_2 delete();
}

_ID5494( var_0 )
{
    var_1 = 0;
    var_0.boxtype = "scavenger_bag";
    var_0.boxtouchonly = 1;

    if ( !isdefined( level._ID5753 ) )
        level._ID5753 = [];

    foreach ( var_4, var_3 in level._ID5753 )
    {
        if ( !isdefined( var_3 ) )
        {
            var_1 = 1;
            level._ID5753[var_4] = var_0;
            break;
        }
    }

    if ( !var_1 )
        level._ID5753[level._ID5753.size] = var_0;

    foreach ( var_6 in level._ID23303 )
    {
        if ( isai( var_6 ) && var_6 maps\mp\_utility::_hasperk( "specialty_scavenger" ) )
            var_6 notify( "new_crate_to_take" );
    }
}

bot_triggers()
{
    var_0 = getentarray( "bot_flag_set", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2.script_noteworthy ) )
            continue;

        var_2 thread bot_flag_trigger( var_2.script_noteworthy );
    }
}

bot_flag_trigger( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "trigger",  var_1  );

        if ( maps\mp\_utility::isaigameparticipant( var_1 ) )
        {
            var_1 notify( "flag_trigger_set_" + var_0 );
            var_1 botsetflag( var_0, 1 );
            var_1 thread bot_flag_trigger_clear( var_0 );
        }
    }
}

bot_flag_trigger_clear( var_0 )
{
    self endon( "flag_trigger_set_" + var_0 );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    common_scripts\utility::_ID35582();
    waittillframeend;
    self botsetflag( var_0, 0 );
}
