// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_frag_precache::_ID20445();
    maps\createart\mp_frag_art::_ID20445();
    maps\mp\mp_frag_fx::_ID20445();
    _ID24833();
    level.dynamicspawns = ::_ID12849;
    maps\mp\_load::_ID20445();
    maps\mp\_compass::_ID29184( "compass_map_mp_frag" );
    setdvar( "r_ssaoFadeDepth", 1024 );

    if ( !level.console )
    {
        setdvar( "r_lightGridEnableTweaks", 1 );
        setdvar( "r_lightGridIntensity", 1.33 );
        maps\mp\_utility::_ID28710( "r_diffuseColorScale", 1.37, 1 );
        maps\mp\_utility::_ID28710( "r_specularcolorscale", 3, 9 );
    }
    else
    {
        setdvar( "r_lightGridEnableTweaks", 1 );
        setdvar( "r_lightGridIntensity", 1.33 );
        setdvar( "r_diffuseColorScale", 1.37 );
        setdvar( "r_specularcolorscale", 2 );
    }

    if ( !maps\mp\_utility::_ID18422() )
        setdvar( "sm_sunShadowScale", "0.8" );

    game["attackers"] = "allies";
    game["defenders"] = "axis";
    common_scripts\utility::_ID13189( "chain_broken" );
    common_scripts\utility::_ID13189( "container_open" );
    common_scripts\utility::_ID13189( "warehouse_open" );
    common_scripts\utility::_ID13189( "drop_ladder" );
    common_scripts\utility::_ID13189( "ladder_down" );
    common_scripts\utility::_ID13189( "hopper_closed" );
    common_scripts\utility::_ID13189( "hopper_open" );
    common_scripts\utility::_ID13189( "pop_up_targets_ready" );
    common_scripts\utility::_ID13189( "hopper_open_initially" );
    common_scripts\utility::flag_set( "hopper_closed" );
    maps\mp\gametypes\_door::_ID10725( "door_switch" );
    level thread generic_shootable_double_doors( "left_gate", "left_gate", "j_prop_1", "right_gate", "j_prop_2", "lock", "gate_clip", "gate_trigger", "mp_frag_metal_door_closed_loop", "mp_frag_metal_door_open", "mp_frag_metal_door_open_out", "mp_frag_metal_door_chain", "frag_gate_iron_open", undefined, undefined, "chain_gate_trigger_damage", "chain_broken", 0, undefined );
    level thread bot_underground_trapped_watch();
    level thread bot_shootable_target_watch( "gate_trigger", "near_gate_volume", "chain_broken" );
    level thread generic_shootable_double_doors( "warehouse_door_right", "warehouse_door_right", "j_prop_1", "warehouse_door_left", "j_prop_2", "warehouse_door_lock", "warehouse_door_clip", "warehouse_door_trigger", undefined, "mp_frag_large_door_open", "mp_frag_large_door_open", "mp_frag_large_door_chain_idle", "scn_breach_swingindoor_left", "scn_breach_swingindoor_right", "scn_breach_swingindoor_lock", "warehouse_trigger_damage", "warehouse_open", 1, "warehouse_door_handle" );
    level thread bot_shootable_target_watch( "warehouse_door_trigger", "near_warehouse_volume", "warehouse_open" );
    level thread _ID29742();
    level thread bot_shootable_target_watch( "ladder_damage_trigger", "near_ladder_volume", "ladder_down" );
    level thread sprinkler_watch();
    level _ID37490();
}

_ID37490()
{
    var_0 = getent( "clip128x128x8", "targetname" );
    var_1 = spawn( "script_model", ( 832, 1938, 466 ) );
    var_1.angles = ( 0, 0, -90 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
    var_2 = getent( "player128x128x8", "targetname" );
    var_3 = spawn( "script_model", ( 1144, 1938, 466 ) );
    var_3.angles = ( 0, 0, -90 );
    var_3 clonebrushmodeltoscriptmodel( var_2 );
    var_4 = spawn( "script_model", ( -571, 1414.5, 193 ) );
    var_4 setmodel( "mp_frag_pipe_4x128_metal_painted_01" );
    var_4.angles = ( 90, 0, 0 );
}

_ID24833()
{
    precachempanim( "mp_frag_metal_door_chain" );
    precachempanim( "mp_frag_metal_door_closed_loop" );
    precachempanim( "mp_frag_metal_door_open" );
    precachempanim( "mp_frag_metal_door_open_loop" );
    precachempanim( "mp_frag_metal_door_open_out" );
    precachempanim( "mp_frag_metal_door_open_out_loop" );
    precachempanim( "mp_frag_large_door_chain_idle" );
    precachempanim( "mp_frag_large_door_open" );
    precachempanim( "mp_frag_large_door_open_loop" );
    precachempanim( "mp_frag_large_door_closed_loop" );
    precachempanim( "mp_frag_crate_open" );
    precachempanim( "mp_frag_crate_open_loop" );
    precachempanim( "mp_frag_crate_closed_loop" );
    precachempanim( "mp_frag_ladder_fall" );
    precachempanim( "mp_frag_ladder_fall_start_loop" );
}

_ID33710( var_0, var_1 )
{
    self endon( var_1 );
    var_0 waittill( "damage",  var_2, var_3, var_4, var_5, var_6  );
    self notify( var_1,  var_2, var_3, var_4, var_5, var_6  );
}

generic_shootable_double_doors( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18 )
{
    var_19 = getent( var_1, "targetname" );
    var_20 = getent( var_3, "targetname" );

    if ( isdefined( var_5 ) )
        var_21 = getent( var_5, "targetname" );
    else
        var_21 = undefined;

    var_22 = getent( var_6, "targetname" );
    var_23 = getentarray( var_7, "targetname" );
    var_24 = getent( var_0, "targetname" );
    var_25 = spawn( "script_model", var_24.origin );

    if ( isdefined( var_24.angles ) )
        var_25.angles = var_24.angles;
    else
        var_25.angles = ( 0, 0, 0 );

    var_25 setmodel( "generic_prop_raven" );
    common_scripts\utility::_ID35582();

    if ( isdefined( var_8 ) )
        var_25 scriptmodelplayanim( var_8 );

    common_scripts\utility::_ID35582();

    if ( isdefined( var_2 ) )
        var_19 linkto( var_25, var_2 );
    else
        var_19 linkto( var_25, "j_prop_1" );

    if ( isdefined( var_4 ) )
        var_20 linkto( var_25, var_4 );
    else
        var_20 linkto( var_25, "j_prop_2" );

    common_scripts\utility::_ID35582();

    if ( var_17 )
        var_22 disconnectpaths();
    else
        var_22 connectpaths();

    var_26 = ( 0, 0, 0 );
    var_27 = 0;

    foreach ( var_29 in var_23 )
    {
        if ( isdefined( var_29.target ) )
            maps\mp\_utility::add_to_bot_damage_targets( var_29 );

        var_26 += var_29.origin;
        var_27++;
    }

    var_26 /= var_27;

    if ( isdefined( var_21 ) && isdefined( var_11 ) )
        var_21 scriptmodelplayanim( var_11 );

    var_19 setcandamage( 0 );
    var_19 setcanradiusdamage( 0 );
    var_20 setcandamage( 0 );
    var_20 setcanradiusdamage( 0 );

    if ( isdefined( var_21 ) )
    {
        var_21 setcandamage( 0 );
        var_21 setcanradiusdamage( 0 );
    }

    var_22 setcandamage( 0 );
    var_22 setcanradiusdamage( 0 );

    foreach ( var_29 in var_23 )
        thread _ID33710( var_29, var_15 );

    self waittill( var_15,  var_33, var_34, var_35, var_36, var_37  );

    if ( isexplosivedamagemod( var_37 ) )
        var_35 = var_26 - var_36;

    var_38 = var_35[1] < 0;

    if ( isdefined( var_18 ) )
    {
        var_39 = getentarray( var_18, "targetname" );

        foreach ( var_41 in var_39 )
            var_41 delete();
    }

    foreach ( var_29 in var_23 )
    {
        maps\mp\_utility::remove_from_bot_damage_targets( var_29 );
        var_29 delete();
    }

    common_scripts\utility::flag_set( var_16 );

    if ( isdefined( var_12 ) )
        var_19 playsound( var_12 );

    if ( isdefined( var_13 ) )
        var_20 playsound( var_13 );

    if ( isdefined( var_21 ) && isdefined( var_14 ) )
        playsoundatpos( var_21.origin, var_14 );

    if ( var_38 )
        var_25 scriptmodelplayanimdeltamotion( var_9 );
    else
        var_25 scriptmodelplayanimdeltamotion( var_10 );

    common_scripts\utility::_ID35582();

    if ( isdefined( var_21 ) )
        var_21 delete();

    wait 0.3;

    if ( var_17 )
        var_22 connectpaths();

    common_scripts\utility::_ID35582();
    var_22 delete();
}

hide_ai_sight_brushes()
{
    var_0 = getentarray( "ai_sight_brush", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2 notsolid();
        var_2 hide();
        var_2 setaisightlinevisible( 0 );
    }
}

_ID28255( var_0, var_1 )
{
    if ( var_1 )
        var_2 = var_0 + "_on";
    else
        var_2 = var_0 + "_off";

    self._ID17490 = var_1;
    self setmodel( var_2 );

    if ( isdefined( self._ID13826 ) )
        self._ID13826 delete();

    if ( isdefined( level._ID1644[var_2] ) && isdefined( self._ID13891 ) && isdefined( self._ID13837 ) )
    {
        self._ID13826 = spawnfx( level._ID1644[var_2], self._ID13891, self._ID13837 );
        triggerfx( self._ID13826 );
    }
}

_ID24731( var_0 )
{
    if ( isdefined( self.button_toggles ) )
    {
        foreach ( var_2 in self.button_toggles )
            var_2 _ID28255( "mp_frag_button", var_0 );
    }
}

get_linked_structs()
{
    var_0 = [];

    if ( isdefined( self.script_linkto ) )
    {
        var_1 = common_scripts\utility::get_links();

        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            var_3 = common_scripts\utility::_ID15384( var_1[var_2], "script_linkname" );

            if ( isdefined( var_3 ) )
                var_0[var_0.size] = var_3;
        }
    }

    return var_0;
}

_ID22299( var_0 )
{
    self waittill( "trigger" );
    var_0 notify( "trigger" );
}

_ID17060( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3.target ) )
        {
            var_4 = getentarray( var_3.target, "targetname" );

            foreach ( var_6 in var_4 )
            {
                if ( isdefined( var_6.script_noteworthy ) && issubstr( var_6.script_noteworthy, "wheel" ) )
                    var_6 thread hopper_wheel_think( var_3 );
            }
        }
    }
}

hopper_wheel_think( var_0 )
{
    var_1 = self;
    var_2 = 1;

    if ( var_1.script_noteworthy == "counterclockwise_wheel" )
        var_2 = -1;

    var_3 = 10000;
    var_4 = 0;

    for (;;)
    {
        var_0 common_scripts\utility::_ID35626( "door_state_done", "door_state_interrupted" );

        if ( var_4 == 0 )
        {
            if ( var_0._ID31503 == 2 || var_0._ID31503 == 3 )
                var_1 rotatevelocity( ( 0, 0, var_2 * -706 ), var_3 );
            else
                var_1 rotatevelocity( ( 0, 0, var_2 * 706 ), var_3 );

            var_4 = 1;
            continue;
        }

        var_1 rotatevelocity( ( 0, 0, 0 ), 0.1 );
        var_4 = 0;
    }
}

_ID17059( var_0, var_1 )
{
    var_2 = 1;

    if ( var_0 )
        var_2 = -1;

    self rotateroll( var_2 * 706, var_1 );
}

bot_underground_trapped_watch()
{
    var_0 = getentarray( "gate_trigger", "targetname" );
    var_1 = getent( "underground_volume", "targetname" );

    while ( !common_scripts\utility::_ID13177( "chain_broken" ) )
    {
        while ( common_scripts\utility::_ID13177( "hopper_closed" ) && !common_scripts\utility::_ID13177( "chain_broken" ) )
        {
            if ( isdefined( level._ID23303 ) )
            {
                foreach ( var_3 in level._ID23303 )
                {
                    if ( isai( var_3 ) && var_3 istouching( var_1 ) )
                        var_0[0] maps\mp\_utility::set_high_priority_target_for_bot( var_3 );
                }
            }

            wait 0.5;
        }

        while ( common_scripts\utility::_ID13177( "hopper_open" ) && !common_scripts\utility::_ID13177( "chain_broken" ) )
            wait 0.5;
    }
}

_ID12849( var_0 )
{
    var_1 = 32;
    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        if ( common_scripts\utility::_ID13177( "hopper_closed" ) && var_4.origin[2] < var_1 )
            continue;

        var_2[var_2.size] = var_4;
    }

    return var_2;
}

_ID30945()
{
    var_0 = getentarray( "hopper_triggers", "targetname" );
    common_scripts\utility::flag_wait( "pop_up_targets_ready" );
    wait 1;
    common_scripts\utility::flag_set( "hopper_open_initially" );
    var_0[0] notify( "trigger" );
    wait 1;
    common_scripts\utility::_ID13180( "hopper_open_initially" );
}

_ID29742()
{
    var_0 = getnode( "ladder_bottom_node", "targetname" );
    var_1 = getnode( "ladder_top_node", "targetname" );
    disconnectnodepair( var_1, var_0 );
    var_2 = getent( "scripted_ladder", "targetname" );
    var_3 = getent( "ladder_brush_bottom", "targetname" );
    var_3 notsolid();
    var_3 common_scripts\utility::_ID33657();
    var_3 setcandamage( 1 );
    var_2 setcandamage( 1 );
    var_4 = common_scripts\utility::_ID15384( "ladder_down_loc", "targetname" );
    var_5 = common_scripts\utility::_ID15384( "ladder_up_loc", "targetname" );
    var_6 = spawn( "script_model", var_4.origin );
    var_6 setmodel( "tag_origin" );
    var_2 linkto( var_6 );
    common_scripts\utility::_ID35582();
    var_6 moveto( var_5.origin, 0.1, 0.0, 0.0 );
    wait 0.2;
    var_2 unlink();
    var_7 = spawn( "script_model", var_5.origin );
    var_7 setmodel( "generic_prop_raven" );
    common_scripts\utility::_ID35582();
    var_6 delete();
    var_2 linkto( var_7, "j_prop_1" );
    common_scripts\utility::_ID35582();
    var_8 = getent( "ladder_damage_trigger", "targetname" );
    maps\mp\_utility::add_to_bot_damage_targets( var_8 );
    var_9 = [];
    var_9[0] = var_2;
    var_9[1] = var_8;
    _ID35632( var_9, "drop_ladder" );
    var_7 scriptmodelplayanim( "mp_frag_ladder_fall" );
    maps\mp\_utility::remove_from_bot_damage_targets( var_8 );
    var_8 delete();
    var_7 playsound( "detpack_explo_metal" );
    common_scripts\utility::flag_set( "ladder_down" );
    connectnodepair( var_1, var_0 );
    var_10 = getent( "ladder_brush_volume", "targetname" );
    var_11 = 1;

    while ( var_11 )
    {
        var_11 = 0;

        foreach ( var_13 in level.characters )
        {
            if ( var_13 istouching( var_10 ) )
            {
                var_11 = 1;
                break;
            }
        }

        common_scripts\utility::_ID35582();
    }

    var_3 common_scripts\utility::_ID33659();
    var_3 solid();
}

_ID35632( var_0, var_1 )
{
    foreach ( var_3 in var_0 )
        var_3 thread _ID35651( var_1 );

    common_scripts\utility::flag_wait( var_1 );
}

_ID35651( var_0 )
{
    level endon( "drop_ladder" );
    self waittill( "damage",  var_1, var_2, var_3, var_4, var_5  );
    common_scripts\utility::flag_set( "drop_ladder" );
}

bot_shootable_target_watch( var_0, var_1, var_2 )
{
    var_3 = getentarray( var_0, "targetname" );
    var_4 = getent( var_1, "targetname" );

    while ( !common_scripts\utility::_ID13177( var_2 ) )
    {
        if ( isdefined( level._ID23303 ) )
        {
            foreach ( var_6 in level._ID23303 )
            {
                if ( isai( var_6 ) && var_6 istouching( var_4 ) )
                    var_3[0] maps\mp\_utility::set_high_priority_target_for_bot( var_6 );
            }
        }

        wait 1.0;
    }
}

sprinkler_watch()
{
    var_0 = getentarray( "underground_damage_trigger", "targetname" );
    var_1 = getentarray( "sprinkler_type_one", "targetname" );
    var_2 = getentarray( "sprinkler_type_two", "targetname" );

    for (;;)
    {
        common_scripts\utility::_ID35627( var_0[0], "trigger", var_0[1], "trigger" );
        common_scripts\utility::exploder( 1 );
        wait 1.0;

        foreach ( var_4 in var_1 )
            var_4 playloopsound( "emt_frag_water_spray_01_int_lp" );

        foreach ( var_4 in var_2 )
            var_4 playloopsound( "emt_frag_water_spray_02_int_lp" );

        wait 11;

        foreach ( var_4 in var_1 )
            var_4 stoploopsound();

        foreach ( var_4 in var_2 )
            var_4 stoploopsound();
    }
}
