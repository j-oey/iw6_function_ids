// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

assembly_line()
{
    assembly_line_animate();
}

assembly_line_precache()
{
    level._ID1644["tank_part_explode"] = loadfx( "vfx/moments/mp_sovereign/vfx_halon_exp" );
    level._ID1644["tank_part_extinguish"] = loadfx( "vfx/ambient/steam/vfx_steam_escape" );
}
#using_animtree("animated_props");

assembly_line_animate()
{
    level.assembly_line_tank_notetracks = [];
    level.assembly_line_tank_notetracks["scn_factory_assembly_tank00_ss"] = 4;
    var_0 = %mp_sovereign_assembly_line_front_piece;
    var_1 = getanimlength( var_0 );

    for ( var_2 = 1; var_2 <= 13; var_2++ )
    {
        var_3 = "ps_";
        var_4 = "scn_factory_assembly_tank" + common_scripts\utility::_ID32831( var_2 <= 9, "0", "" ) + var_2 + "_ss";
        var_5 = getnotetracktimes( var_0, var_3 + var_4 );
        level.assembly_line_tank_notetracks[var_4] = var_5[0] * var_1;
    }

    for ( var_2 = 1; var_2 <= 5; var_2++ )
    {
        var_4 = "scn_factory_assembly_tank_arm0" + var_2 + "_ss";
        var_6 = "front_station_0" + var_2 + "_start";
        var_5 = getnotetracktimes( var_0, var_6 );
        level.assembly_line_tank_notetracks[var_4] = var_5[0] * var_1;
    }

    var_7 = 2;
    var_8 = 55;
    level._ID21971 = randomintrange( 4, 6 );

    for ( var_2 = 0; var_2 < var_7; var_2++ )
    {
        var_9 = getent( "tank_chassis_collision" + ( var_2 + 1 ), "targetname" );
        var_10 = getent( "tank_chassis_collision_top" + ( var_2 + 1 ), "targetname" );
        var_11 = getent( "tank_chassis_collision_center" + ( var_2 + 1 ), "targetname" );

        if ( !isdefined( var_9 ) || !isdefined( var_10 ) || !isdefined( var_11 ) )
            continue;

        var_9._ID18320 = 1;
        var_10._ID18320 = 1;
        var_11._ID18320 = 1;
        var_10.angles = ( 90, 0, 0 );
        level thread assembly_line_piece( var_9, var_10, var_11 );
        wait(var_8);
    }
}

assembly_line_piece( var_0, var_1, var_2 )
{
    var_3 = common_scripts\utility::_ID15384( "assembly_start_point", "targetname" );
    var_4 = spawn( "script_model", var_3.origin );
    var_4.angles = var_3.angles;
    var_4 setmodel( "mp_sovereign_assembly_moving_front_piece" );
    var_2.origin = var_4.origin;
    var_2 linkto( var_4, "tag_origin" );
    var_5 = common_scripts\utility::_ID15384( "assembly_start_point_collision", "targetname" );
    var_6 = spawn( "script_model", var_5.origin );
    var_6.angles = var_5.angles;
    var_6 setmodel( "generic_prop_raven" );
    var_0.origin = var_5.origin;
    var_0 linkto( var_6, "tag_origin" );
    var_7 = common_scripts\utility::_ID15384( "assembly_start_point_collision_top", "targetname" );
    var_8 = spawn( "script_model", var_7.origin );
    var_8.angles = var_7.angles;
    var_8 setmodel( "generic_prop_raven" );
    var_1.origin = var_7.origin;
    var_1 linkto( var_8, "tag_origin" );
    var_4._ID23309 = [];

    if ( isdefined( var_3.target ) )
    {
        var_9 = getentarray( var_3.target, "targetname" );

        foreach ( var_11 in var_9 )
        {
            var_12 = spawn( "script_model", var_11.origin );
            var_12.angles = var_11.angles;
            var_12 setmodel( var_11.model );

            if ( isdefined( var_11.target ) )
            {
                var_13 = getent( var_11.target, "targetname" );

                if ( isdefined( var_13 ) )
                {

                }
            }

            var_12 linkto( var_4, "tag_tank_chassis" );
            var_12 assembly_line_tank_part_visible( 0 );
            var_12._ID23270 = var_4;
            var_4._ID23309[var_4._ID23309.size] = var_12;
        }
    }

    var_4 thread assembly_line_tank_damage_watch();

    for (;;)
    {
        level._ID21971--;

        if ( level._ID21971 <= 0 )
        {
            foreach ( var_11 in var_4._ID23309 )
                var_11 assembly_line_tank_part_visible( 1 );

            level._ID21971 = randomintrange( 9, 12 );
        }

        var_4 _ID3962();
        var_4 scriptmodelplayanimdeltamotion( "mp_sovereign_assembly_line_front_piece" );
        var_6 scriptmodelplayanimdeltamotion( "mp_sovereign_assembly_line_front_piece_origin" );
        var_8 scriptmodelplayanimdeltamotion( "mp_sovereign_assembly_line_front_piece_origin_top" );
        var_17 = getanimlength( %mp_sovereign_assembly_line_front_piece );
        thread animate_arms( var_17 );
        wait(var_17);
        var_4 scriptmodelclearanim();
        var_4.origin = var_3.origin;
        var_4.angles = var_3.angles;
        var_6 scriptmodelclearanim();
        var_6.origin = var_5.origin;
        var_6.angles = var_5.angles;
        var_8 scriptmodelclearanim();
        var_8.origin = var_7.origin;
        var_8.angles = var_7.angles;

        foreach ( var_11 in var_4._ID23309 )
            var_11 assembly_line_tank_part_visible( 0 );
    }
}

_ID3962()
{
    foreach ( var_2, var_1 in level.assembly_line_tank_notetracks )
        maps\mp\_utility::_ID9519( var_1, ::assembly_line_notetrack_sound, var_2 );
}

assembly_line_notetrack_sound( var_0 )
{
    self playsoundonmovingent( var_0 );
}

assembly_line_tank_damage_watch()
{
    for (;;)
    {
        self waittill( "part_destroyed",  var_0  );

        foreach ( var_2 in self._ID23309 )
        {
            var_2 thread assembly_line_tank_part_explode( var_0 );
            var_2 thread assembly_line_tank_part_visible( 0 );
        }

        wait 1;
        level notify( "activate_halon_system" );
        wait 4;

        foreach ( var_2 in self._ID23309 )
            var_2 thread assembly_line_tank_part_extinguish();
    }
}

assembly_line_tank_part_visible( var_0 )
{
    if ( isdefined( self.is_visable ) && self.is_visable == var_0 )
        return;

    if ( var_0 )
    {
        self setmodel( self._ID35315 );
        self setcontents( self._ID35314 );
        thread assembly_line_tank_part_damage_watch();
    }
    else
    {
        self._ID35315 = self.model;
        self setmodel( "tag_origin" );
        self._ID35314 = self setcontents( 0 );
        assembly_line_tank_part_damage_watch_end();
    }

    self.is_visable = var_0;
}

assembly_line_tank_part_damage_watch()
{
    self endon( "stop_tank_part_damage_watch" );
    self.health = 50;
    self setcandamage( 1 );

    for ( self._ID19429 = undefined; self.health > 0; self._ID19429 = var_1 )
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8  );

    self waittill( "death" );
    self._ID23270 notify( "part_destroyed",  self._ID19429  );
}

assembly_line_tank_part_explode( var_0 )
{
    self playsound( "barrel_mtl_explode" );
    playfxontag( level._ID1644["tank_part_explode"], self, "tag_origin" );
    playfxontag( level._ID1644["tank_part_burn"], self, "tag_origin" );

    if ( !isdefined( var_0 ) )
        var_0 = self;

    radiusdamage( self.origin, 400, 300, 50, var_0, "MOD_EXPLOSIVE" );
}

assembly_line_tank_part_extinguish()
{
    stopfxontag( level._ID1644["tank_part_burn"], self, "tag_origin" );
    playfxontag( level._ID1644["tank_part_extinguish"], self, "tag_origin" );
}

assembly_line_tank_part_damage_watch_end()
{
    self notify( "stop_tank_part_damage_watch" );
    self setcandamage( 0 );
}

animate_arms( var_0 )
{
    var_1 = getnotetracktimes( %mp_sovereign_assembly_line_front_piece, "front_station_01_start" );
    var_2 = getnotetracktimes( %mp_sovereign_assembly_line_front_piece, "front_station_02_start" );
    var_3 = getnotetracktimes( %mp_sovereign_assembly_line_front_piece, "front_station_03_start" );
    var_4 = getnotetracktimes( %mp_sovereign_assembly_line_front_piece, "front_station_04_start" );
    var_5 = getnotetracktimes( %mp_sovereign_assembly_line_front_piece, "front_station_05_start" );
    maps\mp\_utility::_ID9519( var_1[0] * var_0, ::animate_front_station_01 );
    maps\mp\_utility::_ID9519( var_2[0] * var_0, ::animate_front_station_02 );
    maps\mp\_utility::_ID9519( var_3[0] * var_0, ::animate_front_station_03 );
    maps\mp\_utility::_ID9519( var_4[0] * var_0, ::animate_front_station_04 );
    maps\mp\_utility::_ID9519( var_5[0] * var_0, ::animate_front_station_05 );
}

animate_front_station_and_return_to_idle( var_0, var_1 )
{
    var_0 setscriptablepartstate( "arm", "animate" );
    wait(getanimlength( var_1 ));
    var_0 setscriptablepartstate( "arm", "idle" );
}

animate_front_station_01_watcher( var_0 )
{
    wait(getanimlength( var_0 ) - 1.5);
    var_1 = ( 895.608, 1640, 92 );
    var_2 = 400;
    var_3 = 100;
    kill_all( var_1, var_2, var_3 );
}

kill_all( var_0, var_1, var_2 )
{
    var_3 = spawn( "trigger_radius", var_0, 0, var_1, var_2 );
    kill_players( var_3 );
    kill_boxes( var_3 );
    var_3 delete();
}

kill_players( var_0 )
{
    foreach ( var_2 in level._ID23303 )
    {
        if ( var_2 istouching( var_0 ) )
            var_2 dodamage( 1000, var_2.origin, undefined, undefined, "MOD_CRUSH" );
    }
}

kill_boxes( var_0 )
{
    var_1 = getentarray( "script_model", "classname" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3.boxtype ) && var_3 istouching( var_0 ) )
            var_3 notify( "death" );
    }
}

animate_front_station_01()
{
    var_0 = getscriptablearray( "factory_assembly_line_front_station01_arm_a", "targetname" )[0];
    var_1 = getscriptablearray( "factory_assembly_line_front_station01_arm_b", "targetname" )[0];
    level thread animate_front_station_and_return_to_idle( var_0, %mp_sovereign_assembly_line_station01_arm_a );
    level thread animate_front_station_and_return_to_idle( var_1, %mp_sovereign_assembly_line_station01_arm_b );
    level thread animate_front_station_01_watcher( %mp_sovereign_assembly_line_station01_arm_a );
}

animate_front_station_02()
{
    var_0 = getscriptablearray( "factory_assembly_line_front_station02_arm_a", "targetname" )[0];
    var_1 = getscriptablearray( "factory_assembly_line_front_station02_arm_b", "targetname" )[0];
    var_2 = getscriptablearray( "factory_assembly_line_front_station02_arm_c", "targetname" )[0];
    var_3 = getscriptablearray( "factory_assembly_line_front_station02_arm_d", "targetname" )[0];
    level thread animate_front_station_and_return_to_idle( var_0, %mp_sovereign_assembly_line_station02_arm_a );
    level thread animate_front_station_and_return_to_idle( var_1, %mp_sovereign_assembly_line_station02_arm_b );
    level thread animate_front_station_and_return_to_idle( var_2, %mp_sovereign_assembly_line_station02_arm_c );
    level thread animate_front_station_and_return_to_idle( var_3, %mp_sovereign_assembly_line_station02_arm_d );
}

animate_front_station_03()
{
    var_0 = getscriptablearray( "factory_assembly_line_front_station03_arm_a", "targetname" )[0];
    var_1 = getscriptablearray( "factory_assembly_line_front_station03_arm_b", "targetname" )[0];
    var_2 = getscriptablearray( "factory_assembly_line_front_station03_arm_c", "targetname" )[0];
    var_3 = getscriptablearray( "factory_assembly_line_front_station03_arm_d", "targetname" )[0];
    level thread animate_front_station_and_return_to_idle( var_0, %mp_sovereign_assembly_line_station03_arm_a );
    level thread animate_front_station_and_return_to_idle( var_1, %mp_sovereign_assembly_line_station03_arm_b );
    level thread animate_front_station_and_return_to_idle( var_2, %mp_sovereign_assembly_line_station03_arm_c );
    level thread animate_front_station_and_return_to_idle( var_3, %mp_sovereign_assembly_line_station03_arm_d );
}

animate_front_station_04()
{
    var_0 = getscriptablearray( "factory_assembly_line_front_station04_arm_a", "targetname" )[0];
    var_1 = getscriptablearray( "factory_assembly_line_front_station04_arm_b", "targetname" )[0];
    var_2 = getscriptablearray( "factory_assembly_line_front_station04_arm_c", "targetname" )[0];
    level thread animate_front_station_and_return_to_idle( var_0, %mp_sovereign_assembly_line_station04_arm_a );
    level thread animate_front_station_and_return_to_idle( var_1, %mp_sovereign_assembly_line_station04_arm_b );
    level thread animate_front_station_and_return_to_idle( var_2, %mp_sovereign_assembly_line_station04_arm_c );
}

animate_front_station_05()
{
    var_0 = getscriptablearray( "factory_assembly_line_front_station05_arm_a", "targetname" )[0];
    var_1 = getscriptablearray( "factory_assembly_line_front_station05_arm_b", "targetname" )[0];
    var_2 = getscriptablearray( "factory_assembly_line_front_station05_arm_c", "targetname" )[0];
    level thread animate_front_station_and_return_to_idle( var_0, %mp_sovereign_assembly_line_station05_arm_a );
    level thread animate_front_station_and_return_to_idle( var_1, %mp_sovereign_assembly_line_station05_arm_b );
    level thread animate_front_station_and_return_to_idle( var_2, %mp_sovereign_assembly_line_station05_arm_c );
}

_ID16003()
{
    level._ID16000 = 2;
    level._ID16001 = 10;
    level._ID35333 = 0;
    level._ID16002 = 0;
    level thread _ID16009();
    level thread halon_system_killstreak();

    for (;;)
    {
        level waittill( "activate_halon_system",  var_0  );
        level thread _ID16008( var_0 );
    }
}

halon_system_killstreak()
{
    for (;;)
    {
        level waittill( "sovereign_gas_killstreak",  var_0  );
        wait 2;
        var_1 = common_scripts\utility::_ID15384( "killstreak_explosive", "targetname" );

        if ( !isdefined( var_1 ) )
            return;

        var_2 = [];
        var_2[var_2.size] = var_1;
        var_1.explosive_dist = 0;
        var_3 = 0;

        for ( var_4 = var_1; isdefined( var_4.target ) && isdefined( common_scripts\utility::_ID15384( var_4.target, "targetname" ) ); var_4 = var_5 )
        {
            var_5 = common_scripts\utility::_ID15384( var_4.target, "targetname" );
            var_3 += distance2d( var_4.origin, var_5.origin );
            var_2[var_2.size] = var_5;
            var_5.explosive_dist = var_3;
        }

        var_6 = 3;

        foreach ( var_8 in var_2 )
        {
            var_9 = var_6 * var_8.explosive_dist / var_3;
            var_8 maps\mp\_utility::_ID9519( var_9, ::_ID16007, var_0 );
        }

        wait(var_6 - 1);

        if ( !common_scripts\utility::_ID13177( "walkway_collasped" ) )
            level notify( "activate_walkway",  var_0  );

        level notify( "activate_halon_system",  var_0  );
    }
}

_ID16007( var_0 )
{
    var_1 = [];

    if ( isdefined( self.target ) )
        var_1 = getentarray( self.target, "targetname" );

    playsoundatpos( self.origin, "barrel_mtl_explode" );
    playfx( level._ID1644["tank_part_explode"], self.origin, anglestoforward( self.angles ), anglestoup( self.angles ) );
    var_2 = var_1[0];

    if ( !isdefined( var_2 ) )
        var_2 = var_0;

    var_2 radiusdamage( self.origin, 400, 1200, 1000, var_0, "MOD_EXPLOSIVE", "sovereign_gas_mp" );

    foreach ( var_4 in var_1 )
        var_4 delete();
}

_ID16008( var_0 )
{
    var_1 = getentarray( "halon_alarm_sound", "targetname" );
    var_2 = getentarray( "halon_fan_sound", "targetname" );

    foreach ( var_4 in var_1 )
        var_4 playsound( "halon_fire_alarm" );

    wait 2;
    thread exploder_with_connect_watch( 1, 40 );

    foreach ( var_7 in level.players )
        var_7 playlocalsound( "halon_gas_amb" );

    halon_system_fog_on();
    wait 5;

    foreach ( var_4 in var_1 )
        var_4 stoploopsound();

    wait 35;

    foreach ( var_4 in var_2 )
        var_4 playsound( "halon_exhaust_fan" );

    _ID16004();
    wait(level._ID16001);
}

exploder_with_connect_watch( var_0, var_1 )
{
    common_scripts\utility::exploder( var_0 );
    var_2 = spawnstruct();
    var_3 = gettime();
    var_2 thread _ID12469( var_0, var_3 );
    wait(var_1);
    var_2 notify( "end_exploder_connect_watch" );
}

_ID12469( var_0, var_1 )
{
    self endon( "end_exploder_connect_watch" );

    for (;;)
    {
        level waittill( "connected",  var_2  );
        common_scripts\utility::exploder( var_0, var_2, var_1 / 1000 );
    }
}

halon_system_fog_on()
{
    level._ID16002 = 1;
    level._ID35333 = 1;

    foreach ( var_1 in level.players )
        var_1 visionsetstage( level._ID35333, level._ID16000 );
}

_ID16004()
{
    level._ID16002 = 0;
    level._ID35333 = 0;

    foreach ( var_1 in level.players )
        var_1 visionsetstage( level._ID35333, level._ID16001 );
}

_ID16009()
{
    for (;;)
    {
        level waittill( "player_spawned",  var_0  );

        if ( isdefined( level._ID35333 ) )
            var_0 visionsetstage( level._ID35333, 0.1 );
    }
}

bot_clear_of_gas()
{
    if ( !common_scripts\utility::_ID13177( "walkway_collasped" ) )
    {
        if ( !isdefined( level.halon_dangerzone ) )
            level.halon_dangerzone = getent( "halon_dangerzone", "targetname" );

        if ( isdefined( level.halon_dangerzone ) )
        {
            if ( self istouching( level.halon_dangerzone ) )
                return 0;
        }
    }

    if ( !isdefined( level.explosives_dangerzone ) )
        level.explosives_dangerzone = getent( "explosives_dangerzone", "targetname" );

    if ( isdefined( level.explosives_dangerzone ) )
    {
        if ( self istouching( level.explosives_dangerzone ) )
            return 0;
    }

    return 1;
}
