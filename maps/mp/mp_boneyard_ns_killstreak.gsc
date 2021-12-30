// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID36808()
{
    level._ID37580 = spawnstruct();
    level._ID37580._ID38004 = getent( "ks_vertical_org", "targetname" );
    level._ID37580.dam = getent( "ks_vertical_damage_vol", "targetname" );
    level._ID37580.destructibles = [ ( 481, -74, -100 ) ];
    level._ID37580._ID38240 = 0;
    level._ID37580._ID37663 = 1;
    level._ID37580.player = undefined;
    level._ID37580.team = undefined;
    level._ID37580.inflictor = getent( "vert_fire_ent", "targetname" );
    level._ID37580._ID38181 = [];
    level._ID37580._ID38181[0] = "compass_icon_vf_idle";
    level._ID37580._ID38181[1] = "compass_icon_vf_active";
    level._ID37580._ID38183 = 0;
    level._ID37580._ID38180 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( level._ID37580._ID38180, "active", ( 381.5, 120, 254 ), level._ID37580._ID38181[0] );
    objective_playermask_hidefromall( level._ID37580._ID38180 );
    level._ID36677 = spawn( "script_origin", ( 1936, 231, 221 ) );
    level._ID36678 = spawn( "script_origin", ( 520, -224, 199 ) );
    level._ID36679 = spawn( "script_origin", ( 346, 150, 246 ) );
    level.alarm1_cp1 = spawn( "script_origin", ( 346, 150, 246 ) );
    level.alarm1_cp2 = spawn( "script_origin", ( 346, 150, 246 ) );
    level._ID36680 = spawn( "script_origin", ( -1028, 534, 368 ) );
    level._ID37210 = spawn( "script_origin", ( 1063, 112, -177 ) );
    level.fire_node1end = spawn( "script_origin", ( 1063, 112, -177 ) );
    level._ID37211 = spawn( "script_origin", ( 1320, -439, -133 ) );
    level.fire_node2end = spawn( "script_origin", ( 1320, -439, -133 ) );
    level._ID37212 = spawn( "script_origin", ( -283, 97, 16 ) );
    level.fire_node3end = spawn( "script_origin", ( -283, 97, 16 ) );
    common_scripts\utility::_ID13189( "boneyard_killstreak_captured" );
    common_scripts\utility::_ID13189( "boneyard_killstreak_can_kill" );
    common_scripts\utility::_ID13189( "boneyard_killstreak_active" );
    common_scripts\utility::_ID13189( "ks_vertical_alarm_on" );
    common_scripts\utility::_ID13189( "ks_vertical_firing" );
    common_scripts\utility::_ID13189( "boneyard_killstreak_endgame" );
    common_scripts\utility::_ID13180( "boneyard_killstreak_endgame" );
    thread _ID37579();
}

_ID36813()
{
    level.allow_level_killstreak = maps\mp\_utility::allowlevelkillstreaks();

    if ( !level.allow_level_killstreak )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "f1_engine_fire", 200, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"MP_BONEYARD_NS_F1_ENGINE_FIRE_PICKUP" );

    if ( isdefined( game["player_holding_level_killstreak"] ) && isalive( game["player_holding_level_killstreak"] ) )
    {
        level._ID37580.player = game["player_holding_level_killstreak"];
        level._ID37580.team = game["player_holding_level_killstreak"].pers["team"];
        common_scripts\utility::flag_set( "boneyard_killstreak_captured" );
        thread _ID36810( level._ID37580, 0.1 );
    }
    else
        level thread _ID36811();
}

_ID36811()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "f1_engine_fire" )
        {
            _ID36805();
            var_1 = _ID35446( var_0 );

            if ( !isdefined( var_1 ) )
                _ID36806( 200 );
            else
            {
                level._ID37580.player = var_1;
                level._ID37580.team = var_1.pers["team"];
                game["player_holding_level_killstreak"] = var_1;
                common_scripts\utility::flag_set( "boneyard_killstreak_captured" );
                thread _ID36810( level._ID37580, 0.1 );
            }
        }
    }
}

_ID35446( var_0 )
{
    var_1 = _ID35948( var_0 );
    return var_1;
}

_ID35948( var_0 )
{
    var_0 endon( "death" );
    var_0 waittill( "captured",  var_1  );
    return var_1;
}

_ID36804()
{
    if ( isdefined( level._ID37580.player ) && level._ID37580.player istouching( level._ID37580.dam ) )
        return 0;

    return common_scripts\utility::_ID13177( "boneyard_killstreak_can_kill" );
}

_ID36806( var_0 )
{
    if ( isdefined( game["player_holding_level_killstreak"] ) && isalive( game["player_holding_level_killstreak"] ) )
        return 0;

    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "f1_engine_fire", var_0 );
}

_ID36805()
{
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "f1_engine_fire", 0 );
}

_ID36807()
{
    level waittill( "game_cleanup" );
    maps\mp\gametypes\_gamelogic::_ID35767();
    common_scripts\utility::flag_set( "boneyard_killstreak_endgame" );
    thread _ID37584();
    thread sound_fire_loop_logic();
    thread _ID37582();
    wait 10;
    common_scripts\utility::_ID13180( "boneyard_killstreak_endgame" );
}

sound_fire_loop_logic()
{
    level._ID37210 playloopsound( "scn_fire_event_02_fire1_lp" );
    level._ID37211 playloopsound( "scn_fire_event_02_fire2_lp" );
    level._ID37212 playloopsound( "scn_fire_event_02_fire1_lp" );
    wait 10.23;
    level.fire_node1end playsound( "scn_fire_event_02_fire1" );
    level.fire_node2end playsound( "scn_fire_event_02_fire2" );
    level.fire_node3end playsound( "scn_fire_event_02_fire1" );
    level._ID37210 stoploopsound();
    level._ID37211 stoploopsound();
    level._ID37212 stoploopsound();
}

_ID36803()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "boneyard_killstreak_activate",  var_0  );
        thread _ID36805();
        game["player_holding_level_killstreak"] = undefined;
        common_scripts\utility::flag_set( "boneyard_killstreak_active" );
        level._ID37580.player = var_0;
        level._ID37580.team = var_0.pers["team"];
        wait 0.5;
        common_scripts\utility::flag_set( "ks_vertical_alarm_on" );
        thread _ID37583();
        thread _ID37584();
        thread _ID37582();
        wait 2;
        common_scripts\utility::_ID13180( "ks_vertical_alarm_on" );
        _ID37581();
        common_scripts\utility::_ID13180( "boneyard_killstreak_active" );

        if ( level._ID37580._ID38240 == 0 )
        {
            common_scripts\utility::_ID13180( "boneyard_killstreak_captured" );
            objective_playermask_hidefromall( level._ID37580._ID38180 );
            level._ID37580.player = undefined;
            level._ID37580.team = undefined;
            thread _ID36806( 100 );
        }
    }
}

_ID36810( var_0, var_1 )
{
    level endon( "boneyard_killstreak_captured" );
    common_scripts\utility::_ID13180( "boneyard_killstreak_can_kill" );
    thread _ID36809( var_0 );

    for (;;)
    {
        var_2 = var_0.dam getistouchingentities( level.characters );
        var_3 = 0;

        if ( level._ID32653 )
        {
            foreach ( var_5 in var_2 )
            {
                if ( maps\mp\_utility::_ID18757( var_5 ) && var_5.pers["team"] != var_0.team )
                {
                    var_3 = 1;
                    break;
                }
            }
        }
        else
        {
            foreach ( var_5 in var_2 )
            {
                if ( maps\mp\_utility::_ID18757( var_5 ) && ( var_5 != var_0.player || isdefined( var_5.owner ) && var_5.owner != var_0.player ) )
                {
                    var_3 = 1;
                    break;
                }
            }
        }

        if ( var_0._ID38183 != var_3 )
        {
            var_0._ID38183 = var_3;
            objective_icon( var_0._ID38180, var_0._ID38181[var_3] );

            if ( var_3 > 0 )
                common_scripts\utility::flag_set( "boneyard_killstreak_can_kill" );
            else
                common_scripts\utility::_ID13180( "boneyard_killstreak_can_kill" );
        }

        wait(var_1);
    }
}

_ID36809( var_0 )
{
    var_1 = var_0.player getentitynumber();
    objective_playermask_showto( var_0._ID38180, var_1 );
    wait 0.2;
    objective_playermask_hidefromall( level._ID37580._ID38180 );
    wait 0.3;
    objective_playermask_showto( var_0._ID38180, var_1 );
    wait 0.2;
    objective_playermask_hidefromall( level._ID37580._ID38180 );
    wait 0.3;
    objective_playermask_showto( var_0._ID38180, var_1 );
}

_ID37581()
{
    level endon( "game_ended" );
    common_scripts\utility::flag_set( "ks_vertical_firing" );
    badplace_brush( "bad_vert_fire", 10, level._ID37580.dam, "allies", "axis" );

    for ( var_0 = 0; var_0 < 20; var_0++ )
    {
        wait 0.5;
        maps\mp\gametypes\_hostmigration::_ID35770();
        var_1 = level._ID37580.player;

        if ( !isdefined( level._ID37580.player ) || !isplayer( level._ID37580.player ) )
            var_1 = undefined;

        thread _ID37066( level._ID37580, var_1, 90 );
        thread _ID37067( level._ID37580, var_1, level._ID25810, 150 );
        thread _ID37067( level._ID37580, var_1, level.placedims, 150 );
        thread _ID37067( level._ID37580, var_1, level._ID34657, 150 );
        thread _ID37067( level._ID37580, var_1, level._ID34099, 150 );
        thread _ID37067( level._ID37580, var_1, level.balldrones, 150 );
        thread _ID37067( level._ID37580, var_1, level._ID21075, 150 );
        thread _ID37067( level._ID37580, var_1, level._ID9646["deployable_vest"], 150 );
        thread _ID37067( level._ID37580, var_1, level._ID9646["deployable_ammo"], 150 );

        foreach ( var_3 in level._ID37580.destructibles )
            radiusdamage( var_3, 1, 45, 45, var_1 );
    }

    if ( !isdefined( level._ID37188 ) || !isdefined( level._ID37188[108] ) || gettime() - level._ID37188[108]._ID33037 > 25000 )
    {
        maps\mp\mp_boneyard_ns::_ID37722( 108 );
        thread sound_fire_loops();
    }

    common_scripts\utility::_ID13180( "ks_vertical_firing" );
}

sound_fire_loops()
{
    var_0 = spawn( "script_origin", ( 574, 228, -110 ) );
    var_1 = spawn( "script_origin", ( 533, -7, -118 ) );
    var_2 = spawn( "script_origin", ( 264, 221, -101 ) );
    var_3 = spawn( "script_origin", ( 299, 1, -109 ) );
    var_4 = spawn( "script_origin", ( 574, 228, -110 ) );
    var_5 = spawn( "script_origin", ( 533, -7, -118 ) );
    var_6 = spawn( "script_origin", ( 264, 221, -101 ) );
    var_7 = spawn( "script_origin", ( 299, 1, -109 ) );
    var_0 playloopsound( "fire_small_01" );
    var_1 playloopsound( "fire_small_01" );
    var_2 playloopsound( "fire_small_01" );
    var_3 playloopsound( "fire_small_01" );
    wait 24.8;
    var_4 playsound( "fire_small_out" );
    var_5 playsound( "fire_small_out" );
    var_6 playsound( "fire_small_out" );
    var_7 playsound( "fire_small_out" );
    wait 0.2;
    var_0 stoploopsound();
    var_1 stoploopsound();
    var_2 stoploopsound();
    var_3 stoploopsound();
    wait 0.1;
    var_0 delete();
    var_1 delete();
    var_2 delete();
    var_3 delete();
}

_ID37066( var_0, var_1, var_2 )
{
    var_3 = var_0.dam getistouchingentities( level.characters );

    foreach ( var_5 in var_3 )
    {
        if ( _ID36939( var_0, var_5 ) )
        {
            if ( isplayer( var_5 ) )
            {
                if ( isdefined( var_0.player ) && var_5 == var_0.player )
                    var_5 maps\mp\gametypes\_damage::_ID12959( var_0.inflictor, var_1, var_2, 0, "MOD_EXPLOSIVE", "none", var_5.origin, ( 0, 0, 1 ), "none", 0, 0 );
                else
                    var_5 dodamage( var_2, var_0.inflictor.origin, var_1, var_0.inflictor, "MOD_EXPLOSIVE" );
            }
            else if ( isdefined( var_5.owner ) && var_5.owner == var_0.player )
                var_5 maps\mp\agents\_agents::_ID22743( undefined, undefined, var_2, 0, "MOD_EXPLOSIVE", "none", var_5.origin, ( 0, 0, 1 ), "none", 0 );
            else
                var_5 maps\mp\agents\_agents::_ID22743( var_0.inflictor, var_1, var_2, 0, "MOD_EXPLOSIVE", "none", var_5.origin, ( 0, 0, 1 ), "none", 0 );
        }
        else if ( isdefined( var_5 ) && maps\mp\_utility::_ID18757( var_5 ) )
        {
            if ( isplayer( var_5 ) )
                var_5 maps\mp\gametypes\_damage::callback_playerdamage( undefined, undefined, 1, 0, "MOD_EXPLOSIVE", "none", var_5.origin, ( 0, 0, 1 ), "none", 0 );
            else
                var_5 maps\mp\agents\_agents::_ID22743( undefined, undefined, 1, 0, "MOD_EXPLOSIVE", "none", var_5.origin, ( 0, 0, 1 ), "none", 0 );
        }

        wait 0.05;
    }
}

_ID36939( var_0, var_1 )
{
    if ( !isdefined( var_1 ) || !maps\mp\_utility::_ID18757( var_1 ) )
        return 0;

    if ( level._ID32653 )
    {
        if ( isdefined( var_0.player ) && var_1 == var_0.player )
            return 1;
        else if ( isdefined( var_0.player ) && isdefined( var_1.owner ) && var_1.owner == var_0.player )
            return 1;
        else if ( isdefined( var_0.team ) && var_1.team == var_0.team )
            return 0;
    }

    return 1;
}

_ID37067( var_0, var_1, var_2, var_3 )
{
    var_4 = "MOD_EXPLOSIVE";
    var_5 = "none";
    var_6 = ( 0, 0, 0 );
    var_7 = ( 0, 0, 0 );
    var_8 = "";
    var_9 = "";
    var_10 = "";
    var_11 = undefined;
    var_12 = var_0.dam getistouchingentities( var_2 );

    foreach ( var_14 in var_12 )
    {
        if ( !isdefined( var_14 ) )
            continue;

        if ( isdefined( var_14.owner ) && var_14.owner == var_1 )
            var_14 notify( "damage",  var_3, var_1, var_6, var_7, var_4, var_8, var_9, var_10, var_11, var_5  );
        else if ( level._ID32653 && isdefined( var_0.team ) && isdefined( var_14.team ) && var_14.team == var_0.team )
            continue;

        var_14 notify( "damage",  var_3, var_1, var_6, var_7, var_4, var_8, var_9, var_10, var_11, var_5  );
        wait 0.05;
    }
}

_ID37583()
{
    level._ID37580._ID38004 playsound( "emt_boneyard_ns_close_alarm_01" );
    thread sound_vertical_fire_logic();
}

sound_vertical_fire_logic()
{
    level._ID36679 playsound( "scn_fire_event_02" );
    wait 1.76;
    level.alarm1_cp1 playsound( "scn_fire_event_02b" );
    thread sound_fire_loop_logic();
    wait 10;
    level.alarm1_cp2 playsound( "scn_fire_event_02c" );
}

_ID37584()
{
    level endon( "game_ended" );

    while ( common_scripts\utility::_ID13177( "boneyard_killstreak_active" ) || common_scripts\utility::_ID13177( "boneyard_killstreak_endgame" ) )
    {
        if ( level._ID32653 && isdefined( level._ID37580.team ) )
        {
            foreach ( var_1 in level.players )
            {
                if ( var_1.pers["team"] == level._ID37580.team )
                {
                    activateclientexploder( 19, var_1 );
                    continue;
                }

                activateclientexploder( 18, var_1 );
            }
        }
        else
            maps\mp\mp_boneyard_ns::_ID37722( 18 );

        wait 0.5;
    }
}

_ID37582()
{
    maps\mp\mp_boneyard_ns::_ID37722( 91 );
    wait 2;
    maps\mp\mp_boneyard_ns::_ID37722( 90 );

    for ( var_0 = 0; var_0 < 5; var_0++ )
    {
        maps\mp\mp_boneyard_ns::_ID37722( 92 );
        wait 2;
    }

    maps\mp\mp_boneyard_ns::_ID37722( 93 );
}

_ID37579()
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "boneyard_killstreak_captured" );
        level.dynamicspawns = ::_ID37197;
        common_scripts\utility::_ID13216( "boneyard_killstreak_captured" );
        level.dynamicspawns = undefined;
    }
}

_ID37197( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3.script_noteworthy ) && var_3.script_noteworthy == "ks_danger_spawn" )
            continue;

        var_1[var_1.size] = var_3;
    }

    return var_1;
}
