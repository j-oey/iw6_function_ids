// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_dome_ns_precache::_ID20445();
    anim_precache();
    maps\createart\mp_dome_ns_art::_ID20445();
    maps\mp\mp_dome_ns_fx::_ID20445();
    common_scripts\_pipes::_ID20445();
    level._ID20636 = ::dome_nscustomcratefunc;
    level.mapcustomkillstreakfunc = ::dome_nscustomkillstreakfunc;
    level._ID20635 = ::dome_nscustombotkillstreakfunc;
    level.deployableboxgiveweaponfunc = maps\mp\mp_alien_weapon::give_alien_weapon;
    maps\mp\_load::_ID20445();
    mp_dome_ns_flag_init();
    setdvar( "r_globalGenericMaterialScale", 4.0 );
    maps\mp\_compass::_ID29184( "compass_map_mp_dome_ns" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    setdvar( "r_reactiveMotionWindAmplitudeScale", 0.4 );
    setdvar( "r_reactiveMotionPlayerRadius", 20.0 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    alien_weapon_setup();
    thread auto_door_setup();
    thread crane_platform();
    thread always_open_door();
    maps\mp\mp_alien_weapon::_ID17631();

    if ( level._ID25139 )
    {
        setdvar( "sm_sunShadowScale", "0.3" );
        setdvar( "sm_sunsamplesizenear", ".15" );
    }
    else if ( level._ID36452 )
    {
        setdvar( "sm_sunShadowScale", "0.55" );
        setdvar( "sm_sunsamplesizenear", ".25" );
    }
    else
        setdvar( "sm_sunShadowScale", "1.0" );

    maps\mp\_utility::_ID28710( "r_specularColorScale", 3.0, 7.5 );
    level._ID23631 = 0;
    thread _ID36620::_ID37998( "alienEasterEgg" );
}

mp_dome_ns_flag_init()
{
    common_scripts\utility::_ID13189( "crane_usable" );
    common_scripts\utility::_ID13189( "misters_on" );
}

set_up_shootable_pipes()
{
    var_0 = getentarray( "pipe_shootable", "targetname" );

    foreach ( var_2 in var_0 )
        var_2.script_noteworthy = "steam";
}

anim_precache()
{
    precachempanim( "mp_dome_ns_crane_cargo_01" );
    precachempanim( "mp_dome_ns_crane_cargo_02" );
    precachempanim( "mp_dome_ns_crane_cargo_start" );
    precachempanim( "mp_dome_ns_crane_01" );
    precachempanim( "mp_dome_ns_crane_02" );
    precachempanim( "mp_dome_ns_crane_start" );
    precachempanim( "mp_dome_ns_showerdoor_open_l" );
    precachempanim( "mp_dome_ns_showerdoor_close_l" );
    precachempanim( "mp_dome_ns_showerdoor_open_r" );
    precachempanim( "mp_dome_ns_showerdoor_close_r" );
    precachemodel( "mp_dns_crane_debris" );
}

alien_weapon_setup()
{
    var_0 = getent( "alien_weapon_trigger", "targetname" );
    thread alien_weapon_trigger_watcher( var_0 );
}

alien_weapon_trigger_watcher( var_0 )
{
    var_0 makeunusable();
    common_scripts\utility::flag_wait( "crane_usable" );
    var_1 = getent( "platform_origin", "targetname" );
    var_0 makeusable();
    var_0 enablelinkto();
    var_0 linkto( var_1 );
    var_0 sethintstring( &"MP_DOME_NS_GET_ALIEN_GUN" );

    for (;;)
    {
        if ( level.remaining_alien_weapons == 0 )
            break;

        var_0 waittill( "trigger",  var_2  );
        var_2 maps\mp\mp_alien_weapon::give_alien_weapon();
    }

    var_3 = getent( "alien_gun_model", "targetname" );
    var_3 hide();
    var_0 makeunusable();
    var_0 sethintstring( "" );
}
#using_animtree("animated_props_dlc2");

crane_platform()
{
    thread crane_available_check();
    var_0 = getent( "het_bed_proxy", "targetname" );
    var_0 delete();
    var_1 = 2;
    level.platform_lights = [];
    var_2 = getent( "platform_origin", "targetname" );
    var_3 = getent( "moving_platform_model", "targetname" );
    var_4 = getent( "alien_gun_model", "targetname" );
    var_5 = getent( "platform_sfx_origin", "targetname" );
    var_6 = getent( "platform_death_trigger", "targetname" );
    var_7 = getent( "dome_crane", "targetname" );
    var_8 = getentarray( "moving_platform", "targetname" );
    var_8[var_8.size] = var_3;
    var_8[var_8.size] = var_4;
    var_9 = getent( "side_blockerB", "targetname" );
    var_10 = getent( "arm_base_jnt_collision", "targetname" );
    var_11 = getent( "arm_mid_jnt_collision", "targetname" );
    var_12 = getent( "arm_end_jnt_collision", "targetname" );
    var_13 = getent( "operators_cab_jnt_collision", "targetname" );
    var_14 = getent( "hook_jnt_collision", "targetname" );
    var_10 linkto( var_7, "arm_base_jnt" );
    var_11 linkto( var_7, "arm_mid_jnt" );
    var_12 linkto( var_7, "arm_end_jnt" );
    var_13 linkto( var_7, "operators_cab_jnt" );
    var_14 linkto( var_7, "hook_jnt" );
    var_10.destroyairdroponcollision = 1;
    var_11.destroyairdroponcollision = 1;
    var_12.destroyairdroponcollision = 1;
    var_13.destroyairdroponcollision = 1;
    var_14.destroyairdroponcollision = 1;
    var_10._ID22054 = 1;
    var_11._ID22054 = 1;
    var_12._ID22054 = 1;
    var_13._ID22054 = 1;
    var_14._ID22054 = 1;
    var_15 = getentarray( "gate_watcher", "targetname" );
    var_16 = getent( "crane_occupied_watcher", "targetname" );

    foreach ( var_18 in var_15 )
    {
        var_18 enablelinkto();
        var_18 linkto( var_2 );
    }

    var_6 enablelinkto();
    var_6 linkto( var_2 );
    var_16 enablelinkto();
    var_16 linkto( var_2 );
    thread disable_drones_watcher( var_16 );
    common_scripts\utility::_ID35582();
    var_2 scriptmodelplayanimdeltamotion( "mp_dome_ns_crane_cargo_start" );
    var_7 scriptmodelplayanimdeltamotion( "mp_dome_ns_crane_start" );
    wait 1;

    foreach ( var_21 in var_8 )
    {
        var_21 linkto( var_2, "tag_origin" );
        var_21.destroyairdroponcollision = 1;
    }

    var_5 linkto( var_2, "tag_origin" );
    var_9 solid();
    var_9 connectpaths();
    var_9 notsolid();
    var_23 = getent( "crane_gate_blocker", "targetname" );
    var_23 linkto( var_2 );
    var_23._ID22054 = 1;
    var_24 = getent( "crane_audio_org", "targetname" );
    var_25 = 1;
    common_scripts\utility::flag_wait( "crane_usable" );
    objective_add( 31, "active", var_3.origin, "waypoint_man_basket" );
    objective_onentitywithrotation( 31, var_3 );
    var_23 unlink();
    var_23 notsolid();
    wait 0.1;
    var_23 linkto( var_2 );
    var_26 = getent( "platform_toggle_triggerA", "targetname" );
    var_26 sethintstring( &"MP_DOME_NS_ACTIVATE_CRANE" );
    var_26 makeusable();
    var_27 = getent( "platform_toggle_triggerB", "targetname" );
    var_27 sethintstring( &"MP_DOME_NS_ACTIVATE_CRANE" );
    var_27 makeunusable();
    thread gate_watcher( var_15, var_26 );
    thread gate_watcher( var_15, var_27 );

    for (;;)
    {
        level waittill( "crane_triggered" );
        thread fx_crane_light( var_5 );
        crane_gate_move( var_23, var_2, "down" );

        if ( var_25 == 1 )
        {
            var_26 playsound( "scn_crane_button_activate" );
            var_26 makeunusable();
            var_2 scriptmodelplayanimdeltamotion( "mp_dome_ns_crane_cargo_01" );
            var_3 scriptmodelplayanim( "mp_dome_ns_crane_cargo_01_gate" );
            var_7 scriptmodelplayanimdeltamotion( "mp_dome_ns_crane_01" );
            var_28 = getanimlength( %mp_dome_ns_crane_cargo_01_gate );
            var_29 = getnotetracktimes( %mp_dome_ns_crane_cargo_01_gate, "gate_open" );
            var_30 = var_28 * var_29[0];
        }
        else
        {
            var_27 playsound( "scn_crane_button_activate" );
            var_27 makeunusable();
            var_2 scriptmodelplayanimdeltamotion( "mp_dome_ns_crane_cargo_02" );
            var_3 scriptmodelplayanim( "mp_dome_ns_crane_cargo_02_gate" );
            var_7 scriptmodelplayanimdeltamotion( "mp_dome_ns_crane_02" );
            var_29 = getnotetracktimes( %mp_dome_ns_crane_cargo_02_gate, "gate_open" );
            var_28 = getanimlength( %mp_dome_ns_crane_cargo_02_gate );
            var_30 = var_28 * var_29[0];
            var_9 solid();
            var_9 connectpaths();
            var_9 notsolid();
        }

        thread sfx_crane_bar( var_25, 0, "down" );
        var_24 thread sfx_crane_start();
        var_5 thread sfx_crane_platform_start();

        foreach ( var_21 in var_8 )
        {
            var_21._ID34249 = ::crane_damage_manager;
            var_21._ID34253 = 1;
            var_21.unresolved_collision_kill = 1;
            var_21.owner = level.triggerer;
        }

        thread sfx_crane_bar( var_25, var_30, "up" );
        wait(var_30);
        crane_gate_move( var_23, var_2, "up" );
        var_6 thread death_trigger_manager();

        if ( var_25 == 1 )
        {
            var_9 solid();
            var_9 disconnectpaths();
            var_9 notsolid();
            var_33 = var_28 - var_30;
            var_24 thread sfx_crane_stop( var_33, 2 );
            var_5 thread sfx_crane_stop_impt( var_33, 0.2 );
        }
        else
        {
            var_33 = var_28 - var_30;
            var_24 thread sfx_crane_stop( var_33, 1.8 );
            var_5 thread sfx_crane_stop_impt( var_33, 0.4 );
        }

        wait(var_28 - var_30);
        wait(var_1);

        if ( var_25 == 1 )
        {
            var_27 sethintstring( &"MP_DOME_NS_ACTIVATE_CRANE" );
            var_27 makeusable();
        }
        else
        {
            var_26 sethintstring( &"MP_DOME_NS_ACTIVATE_CRANE" );
            var_26 makeusable();
        }

        var_25 *= -1;
        level notify( "platform_move_done" );
    }
}

death_trigger_manager()
{
    level endon( "platform_move_done" );

    for (;;)
    {
        var_0 = [];
        var_1 = maps\mp\agents\_agent_utility::getactiveagentsoftype( "all" );
        var_1 = common_scripts\utility::array_combine( var_1, level.players );

        foreach ( var_3 in var_1 )
        {
            if ( isplayer( var_3 ) && ( var_3.sessionstate == "intermission" || var_3.sessionstate == "spectator" || !maps\mp\_utility::_ID18757( var_3 ) ) )
                var_1 = common_scripts\utility::array_remove( var_1, var_3 );
        }

        var_0 = self getistouchingentities( var_1 );

        foreach ( var_3 in var_0 )
            crane_damage_manager( var_3 );

        wait 0.1;
    }
}

disable_drones_watcher( var_0 )
{
    for (;;)
    {
        if ( isdefined( level.players ) )
            break;

        wait 1;
    }

    for (;;)
    {
        var_1 = var_0 getistouchingentities( level.players );

        foreach ( var_3 in var_1 )
        {
            if ( isdefined( var_3.drones_disabled ) )
                continue;

            var_3.drones_disabled = 1;
            var_3.seekers_disabled = 1;
            var_3 thread enable_drones_watcher( var_0 );
        }

        wait 0.05;
    }
}

enable_drones_watcher( var_0 )
{
    if ( !isplayer( self ) )
        self endon( "death" );

    self endon( "disconnect" );

    while ( self istouching( var_0 ) )
        wait 0.05;

    self.drones_disabled = undefined;
    self.seekers_disabled = undefined;
}

gate_watcher( var_0, var_1 )
{
    for (;;)
    {
        var_1 waittill( "trigger",  var_2  );
        var_3 = [];
        var_4 = [];
        var_5 = level.players;

        foreach ( var_7 in var_5 )
        {
            if ( var_7.sessionstate == "intermission" || var_7.sessionstate == "spectator" || !maps\mp\_utility::_ID18757( var_7 ) )
                var_7 = common_scripts\utility::array_remove( var_5, var_7 );
        }

        foreach ( var_10 in var_0 )
        {
            var_4 = var_10 getistouchingentities( var_5 );
            var_3 = common_scripts\utility::array_combine( var_3, var_4 );
        }

        if ( var_3.size > 0 )
        {
            var_2 playsoundtoplayer( "alien_miasma_alarm", var_2 );
            continue;
        }

        level notify( "crane_triggered" );
        level.triggerer = var_2;
    }
}

crane_gate_move( var_0, var_1, var_2 )
{
    if ( var_2 == "up" )
    {
        level notify( "basket_descending" );
        var_0 notsolid();
        return;
    }

    var_0 solid();
    return;
}

crane_available_check()
{
    var_0 = getent( "moving_platform_model", "targetname" );
    var_1 = getent( "platform_origin", "targetname" );
    var_2 = getent( "dome_crane", "targetname" );
    level.crane_targets = 3;
    thread crane_target_setup( "crane_target_1", "arm_base_jnt", 5 );
    thread crane_target_setup( "crane_target_2", "arm_mid_jnt", 6 );
    thread crane_target_setup( "crane_target_3", "arm_end_jnt", 7 );

    while ( level.crane_targets == 3 )
    {
        if ( getdvarint( "scr_activateCrane" ) == 1 )
            break;

        wait 0.05;
    }

    var_0 playsound( "scn_dome_crane_platform_01" );
    var_1 scriptmodelplayanimdeltamotion( "mp_dome_ns_crane_cargo_drop1" );
    var_0 scriptmodelplayanim( "mp_dome_ns_crane_cargo_drop1_gate" );
    var_2 scriptmodelplayanimdeltamotion( "mp_dome_ns_crane_drop1" );
    var_3 = getanimlength( %mp_dome_ns_crane_drop1 );
    wait(var_3);

    while ( level.crane_targets == 2 )
    {
        if ( getdvarint( "scr_activateCrane" ) == 1 )
            break;

        wait 0.05;
    }

    var_0 playsound( "scn_dome_crane_platform_02" );
    var_1 scriptmodelplayanimdeltamotion( "mp_dome_ns_crane_cargo_drop2" );
    var_0 scriptmodelplayanim( "mp_dome_ns_crane_cargo_drop2_gate" );
    var_2 scriptmodelplayanimdeltamotion( "mp_dome_ns_crane_drop2" );
    var_3 = getanimlength( %mp_dome_ns_crane_drop2 );
    wait(var_3);

    while ( level.crane_targets == 1 )
    {
        if ( getdvarint( "scr_activateCrane" ) == 1 )
            break;

        wait 0.05;
    }

    var_0 playsound( "scn_dome_crane_platform_03" );
    var_1 scriptmodelplayanimdeltamotion( "mp_dome_ns_crane_cargo_drop3" );
    var_0 scriptmodelplayanim( "mp_dome_ns_crane_cargo_drop3_gate" );
    var_2 scriptmodelplayanimdeltamotion( "mp_dome_ns_crane_drop3" );
    var_4 = spawn( "script_model", var_2.origin );
    var_4.angles = var_2.angles;
    var_4 setmodel( "mp_dns_crane_debris" );
    var_4 scriptmodelplayanimdeltamotion( "mp_dome_ns_crane_drop3_debris" );
    var_3 = getanimlength( %mp_dome_ns_crane_drop3 );
    wait(var_3 - 0.8);
    common_scripts\utility::exploder( 4 );
    wait 0.2;
    var_5 = getentarray( "crane_platform_blocker", "targetname" );
    var_6 = getnodearray( "traverse_platform", "targetname" );

    foreach ( var_8 in var_6 )
        connectnodepair( var_8, getnode( var_8.target, "targetname" ) );

    var_10 = getnodearray( "no_agent_spawn_node", "script_noteworthy" );
    var_10 common_scripts\utility::array_combine( var_10, var_6 );

    foreach ( var_8 in var_10 )
        var_8.no_agent_spawn = 1;

    foreach ( var_14 in var_5 )
    {
        if ( var_14.classname == "script_brushmodel" )
            var_14 connectpaths();

        var_14 delete();
    }

    wait 1;
    common_scripts\utility::flag_set( "crane_usable" );
    var_0 man_cage_button_fx();
}

man_cage_button_fx()
{
    common_scripts\utility::flag_wait( "crane_usable" );

    for (;;)
    {
        stopfxontag( level._ID1644["vfx_red_light"], self, "tag_fx_red" );
        playfxontag( level._ID1644["vfx_green_light"], self, "tag_fx_green" );
        level waittill( "crane_triggered" );
        playfxontag( level._ID1644["vfx_red_light"], self, "tag_fx_red" );
        stopfxontag( level._ID1644["vfx_green_light"], self, "tag_fx_green" );
        level waittill( "platform_move_done" );
    }
}

crane_target_setup( var_0, var_1, var_2 )
{
    var_3 = getent( var_0, "targetname" );
    var_4 = getent( "dome_crane", "targetname" );
    var_3 linkto( var_4, var_1 );

    if ( level._ID14086 == "oic" || level._ID14086 == "gun" || level._ID14086 == "infect" || level._ID14086 == "horde" || level._ID14086 == "sotf" || level._ID14086 == "sotf_ffa" || maps\mp\_utility::_ID37547() )
    {
        var_3 delete();
        return;
    }

    var_3 setcandamage( 1 );
    var_3.health = 100000;

    for (;;)
    {
        var_3 waittill( "damage",  var_5, var_6, var_7, var_8, var_9  );

        if ( var_5 >= 75 && ( var_9 == "MOD_EXPLOSIVE" || var_9 == "MOD_PROJECTILE_SPLASH" || var_9 == "MOD_PROJECTILE" || var_9 == "MOD_GRENADE_SPLASH" || var_9 == "MOD_GRENADE" || var_9 == "SPLASH" ) )
        {
            var_3 playsound( "scn_dome_crane_explo_01" );
            var_3 delete();
            level.crane_targets--;
            common_scripts\utility::exploder( var_2 );
            break;
        }
    }
}

crane_damage_manager( var_0 )
{
    if ( isdefined( level.triggerer ) )
    {
        if ( isdefined( var_0.team ) && var_0.team == level.triggerer.team )
        {
            var_0 dodamage( 1000, var_0.origin, self, self, "MOD_CRUSH" );
            return;
        }

        var_0 dodamage( 1000, var_0.origin, level.triggerer, self, "MOD_CRUSH" );
        return;
        return;
    }

    var_0 dodamage( 1000, var_0.origin, undefined, undefined, "MOD_CRUSH" );
    return;
}

clean_tube_watcher()
{
    var_0 = getent( "trigger_clean_tube_spray", "targetname" );

    for (;;)
    {
        var_1 = [];
        var_2 = maps\mp\agents\_agent_utility::getactiveagentsoftype( "all" );
        var_2 = common_scripts\utility::array_combine( var_2, level.players );
        var_2 = common_scripts\utility::array_combine( var_2, level._ID25810 );

        foreach ( var_4 in var_2 )
        {
            if ( isplayer( var_4 ) && ( var_4.sessionstate == "intermission" || var_4.sessionstate == "spectator" || !maps\mp\_utility::_ID18757( var_4 ) ) )
                var_2 = common_scripts\utility::array_remove( var_2, var_4 );
        }

        common_scripts\utility::_ID35582();
        var_1 = var_0 getistouchingentities( var_2 );

        foreach ( var_4 in var_1 )
        {
            if ( isplayer( var_4 ) )
                var_4.drones_disabled = 1;

            var_4 thread enable_drones_watcher( var_0 );
        }

        if ( var_1.size > 0 )
        {
            activateclientexploder( 70 );
            thread sfx_misters_on();
        }
        else
            thread sfx_misters_off();

        wait 0.75;
    }
}

door_trigger_watcher( var_0 )
{
    for (;;)
    {
        var_1 = maps\mp\agents\_agent_utility::getactiveagentsoftype( "all" );
        var_1 = common_scripts\utility::array_combine( var_1, level.players );
        var_1 = common_scripts\utility::array_combine( var_1, level._ID25810 );

        foreach ( var_3 in var_1 )
        {
            if ( isplayer( var_3 ) && ( var_3.sessionstate == "intermission" || var_3.sessionstate == "spectator" || !maps\mp\_utility::_ID18757( var_3 ) ) )
                var_1 = common_scripts\utility::array_remove( var_1, var_3 );
        }

        common_scripts\utility::_ID35582();
        var_5 = var_0 getistouchingentities( var_1 );

        if ( var_5.size == 0 )
            var_0 notify( "unoccupied" );
        else
            var_0 notify( "occupied" );

        wait 0.25;
    }
}

always_open_door()
{
    var_0 = getent( "door_open_right", "targetname" );
    var_1 = getent( "door_open_left", "targetname" );
    var_0 scriptmodelplayanimdeltamotion( "mp_dome_ns_showerdoor_open_l" );
    var_1 scriptmodelplayanimdeltamotion( "mp_dome_ns_showerdoor_open_r" );
}

auto_door_setup()
{
    for (;;)
    {
        if ( isdefined( level.players ) )
            break;

        wait 1;
    }

    thread clean_tube_watcher();
    var_0 = getentarray( "trigger_automatic_door", "targetname" );

    foreach ( var_2 in var_0 )
    {
        thread door_trigger_watcher( var_2 );
        thread auto_door_manager( var_2 );
    }
}

auto_door_manager( var_0 )
{
    var_1 = 2;
    var_2 = getentarray( var_0.target, "targetname" );
    var_3 = 1;
    var_4 = 1;
    var_5 = 1;
    var_6 = 1;
    var_7 = 1;
    var_8 = 1;
    var_9 = 1;
    var_10 = 1;

    foreach ( var_12 in var_2 )
    {
        var_13 = var_12._ID27766;

        if ( var_12._ID27766 == "door_left;" )
            var_14 = var_12;

        if ( !isdefined( var_13 ) )
            var_13 = "";

        var_15 = strtok( var_13, ";" );

        foreach ( var_17 in var_15 )
        {
            if ( var_15[0] == "door_left" )
                var_3 = var_12;

            if ( var_15[0] == "door_right" )
                var_4 = var_12;

            if ( var_15[0] == "closed_left" )
                var_5 = var_12;

            if ( var_15[0] == "closed_right" )
                var_6 = var_12;

            if ( var_15[0] == "open_left" )
                var_7 = var_12;

            if ( var_15[0] == "open_right" )
                var_8 = var_12;

            if ( var_15[0] == "door_animated_right" )
                var_9 = var_12;

            if ( var_15[0] == "door_animated_left" )
                var_10 = var_12;
        }
    }

    common_scripts\utility::_ID35582();
    var_3 connectpaths();
    var_4 connectpaths();
    var_20 = var_6.origin;
    var_3 linkto( var_5 );
    var_4 linkto( var_6 );

    for (;;)
    {
        var_0 waittill( "occupied" );
        var_3 maps\mp\_movers::notify_moving_platform_invalid();
        var_4 maps\mp\_movers::notify_moving_platform_invalid();
        var_5 moveto( var_7.origin, 0.5 );
        var_6 moveto( var_8.origin, 0.5 );
        var_10 scriptmodelplayanimdeltamotion( "mp_dome_ns_showerdoor_open_r" );
        var_9 scriptmodelplayanimdeltamotion( "mp_dome_ns_showerdoor_open_l" );
        var_10 playsound( "scn_dome_ns_glass_door_open" );
        var_9 playsound( "scn_dome_ns_glass_door_open" );
        wait 0.5;
        wait(var_1);
        var_0 waittill( "unoccupied" );
        var_5 moveto( var_20, 0.5 );
        var_6 moveto( var_20, 0.5 );
        var_10 scriptmodelplayanimdeltamotion( "mp_dome_ns_showerdoor_close_r" );
        var_9 scriptmodelplayanimdeltamotion( "mp_dome_ns_showerdoor_close_l" );
        var_10 playsound( "scn_dome_ns_glass_door_close" );
        var_9 playsound( "scn_dome_ns_glass_door_close" );
        wait 0.5;
        wait 0.1;
    }
}

fx_crane_light( var_0 )
{
    playfxontag( level._ID1644["vfx_dome_ns_man_cage_flare"], var_0, "tag_origin" );
    level waittill( "platform_move_done" );
    stopfxontag( level._ID1644["vfx_dome_ns_man_cage_flare"], var_0, "tag_origin" );
}

dome_nscustomcratefunc()
{
    if ( !isdefined( game["player_holding_level_killstreak"] ) )
        game["player_holding_level_killstreak"] = 0;

    if ( !maps\mp\_utility::allowlevelkillstreaks() || game["player_holding_level_killstreak"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "dome_seekers", 200, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"MP_DOME_NS_SEEKERS_PICKUP" );
    level thread watch_for_dome_ns_alien_dog_crate();
}

watch_for_dome_ns_alien_dog_crate()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "dome_seekers" )
        {
            maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "dome_seekers", 0 );
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
                maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "dome_seekers", 200 );
            else
                game["player_holding_level_killstreak"] = 1;
        }
    }
}

_ID35446( var_0 )
{
    var_1 = _ID35948( var_0 );
    return !isdefined( var_1 );
}

_ID35948( var_0 )
{
    var_0 endon( "captured" );
    var_0 waittill( "death" );
    waittillframeend;
    return 1;
}

dome_nscustomkillstreakfunc()
{
    level._ID19276["killstreak_level_event_mp"] = "dome_seekers";
    level._ID19256["dome_seekers"] = ::tryusealien;
}

tryusealien( var_0, var_1 )
{
    if ( getdvarint( "scr_alienDebugMode" ) == 1 )
        var_2 = 1;
    else
        var_2 = 3;

    if ( maps\mp\agents\_agent_utility::getnumactiveagents() + var_2 >= 5 )
    {
        self iprintlnbold( &"KILLSTREAKS_AGENT_MAX" );
        return 0;
    }

    var_3 = maps\mp\agents\_agent_utility::getvalidspawnpathnodenearplayer( 1 );

    if ( !isdefined( var_3 ) || isdefined( self.seekers_disabled ) )
    {
        self iprintlnbold( &"MP_DOME_NS_SEEKERS_UNAVAILABLE" );
        return 0;
    }

    thread maps\mp\mp_dome_ns_alien::usealien( var_3, var_2 );
    return 1;
}

dome_nscustombotkillstreakfunc()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "dome_seekers", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

sfx_misters_on()
{
    if ( common_scripts\utility::_ID13177( "misters_on" ) )
        return;

    common_scripts\utility::flag_set( "misters_on" );

    if ( !isdefined( level.mister_01 ) )
        level.mister_01 = spawn( "script_origin", ( 1735, 1546, -133 ) );

    if ( !isdefined( level.mister_02 ) )
        level.mister_02 = spawn( "script_origin", ( 1745, 1707, -140 ) );

    if ( !isdefined( level.mister_03 ) )
        level.mister_03 = spawn( "script_origin", ( 1753, 1835, -140 ) );

    if ( !isdefined( level.mister_04 ) )
        level.mister_04 = spawn( "script_origin", ( 1698, 1952, -140 ) );

    if ( !isdefined( level.mister_05 ) )
        level.mister_05 = spawn( "script_origin", ( 1540, 1981, -133 ) );

    level.mister_01 playloopsound( "emt_dome_ns_mist_01" );
    level.mister_02 playloopsound( "emt_dome_ns_mist_02" );
    level.mister_03 playloopsound( "emt_dome_ns_mist_03" );
    level.mister_04 playloopsound( "emt_dome_ns_mist_01" );
    level.mister_05 playloopsound( "emt_dome_ns_mist_02" );
}

sfx_misters_off()
{
    if ( !common_scripts\utility::_ID13177( "misters_on" ) )
        return;

    common_scripts\utility::_ID13180( "misters_on" );
    level.mister_01 stoploopsound();
    level.mister_02 stoploopsound();
    level.mister_03 stoploopsound();
    level.mister_04 stoploopsound();
    level.mister_05 stoploopsound();
}

sfx_crane_start()
{
    wait 0.3;
    self playsound( "scn_crane_start" );
    wait 2.4;
    self playloopsound( "scn_crane_mvmt_lp" );
}

sfx_crane_platform_start()
{
    self playsound( "scn_crane_platform_start" );
    thread sfx_crane_rattle();
}

sfx_crane_stop( var_0, var_1 )
{
    wait(var_0 - var_1);
    self playsound( "scn_crane_stop" );
    wait 0.3;
    self stoploopsound( "scn_crane_mvmt_lp" );
}

sfx_crane_stop_impt( var_0, var_1 )
{
    wait(var_0 - var_1);
    self playsound( "scn_crane_stop_impt" );
}

sfx_crane_rattle()
{
    wait 3;
    wait(randomintrange( 3, 4 ));
    self playsound( "scn_crane_rattle" );
    wait(randomintrange( 9, 12 ));
    self playsound( "scn_crane_rattle" );
    wait(randomintrange( 9, 11 ));
    self playsound( "scn_crane_rattle" );
    wait 7.5;
    self playsound( "scn_crane_rattle" );
}

sfx_crane_bar( var_0, var_1, var_2 )
{
    if ( var_2 == "up" )
    {
        wait(var_1 - 0.8);

        if ( var_0 == 1 )
        {
            var_3 = ( -296, 1403, -200 );
            var_4 = ( -362, 1285, -200 );
        }
        else
        {
            var_3 = ( 970, 292, -245 );
            var_4 = ( 1086, 253, -245 );
        }

        var_5 = "scn_crane_bar_up";
        var_6 = "scn_crane_bar_down";
    }
    else
    {
        wait 0.12;

        if ( var_0 == 1 )
        {
            var_3 = ( 970, 292, -250 );
            var_4 = ( 1090, 266, -250 );
        }
        else
        {
            var_3 = ( -281, 1391, -200 );
            var_4 = ( -345, 1283, -200 );
        }

        var_5 = "scn_crane_bar_down";
        var_6 = "scn_crane_bar_up";
    }

    if ( !isdefined( level.sfx_crane_bar_01 ) )
        level.sfx_crane_bar_01 = spawn( "script_origin", var_3 );

    if ( !isdefined( level.sfx_crane_bar_02 ) )
        level.sfx_crane_bar_02 = spawn( "script_origin", var_4 );

    level.sfx_crane_bar_01 playsound( var_5 );
    level.sfx_crane_bar_02 playsound( var_6 );
    wait 2;
    level.sfx_crane_bar_01 delete();
    level.sfx_crane_bar_02 delete();
}
