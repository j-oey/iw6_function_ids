// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_lonestar_precache::_ID20445();
    maps\createart\mp_lonestar_art::_ID20445();
    maps\mp\mp_lonestar_fx::_ID20445();
    level thread maps\mp\_movers::_ID20445();
    level thread maps\mp\_movable_cover::_ID17631();
    level thread _ID25231();
    maps\mp\_load::_ID20445();
    thread maps\mp\_fx::_ID13742();
    maps\mp\_compass::_ID29184( "compass_map_mp_lonestar" );
    setdvar( "r_ssaofadedepth", 384 );
    setdvar( "r_ssaorejectdepth", 1152 );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 3, 15 );
    maps\mp\_utility::_ID28710( "r_diffuseColorScale", 1.25, 3.5 );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );

    if ( level._ID25139 )
    {
        setdvar( "sm_sunShadowScale", "0.5" );
        setdvar( "sm_sunsamplesizenear", ".19" );
    }
    else if ( level._ID36452 )
    {
        setdvar( "sm_sunShadowScale", "0.8" );
        setdvar( "sm_sunsamplesizenear", ".25" );
    }
    else
        setdvar( "sm_sunShadowScale", "0.9" );

    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level thread _ID12485();
    level thread _ID37490();
}

_ID37490()
{
    var_0 = getent( "clip128x128x128", "targetname" );
    var_1 = spawn( "script_model", ( -714, -2022, 102 ) );
    var_1.angles = ( 0, 0, 0 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
    var_2 = getent( "clip128x128x128", "targetname" );
    var_3 = spawn( "script_model", ( -828, -2160, 80 ) );
    var_3.angles = ( 0, 0, 0 );
    var_3 clonebrushmodeltoscriptmodel( var_2 );
    var_4 = getent( "clip256x256x256", "targetname" );
    var_5 = spawn( "script_model", ( -2048, -336, 112 ) );
    var_5.angles = ( 0, 0, 0 );
    var_5 clonebrushmodeltoscriptmodel( var_4 );
    var_6 = getent( "player32x32x256", "targetname" );
    var_7 = spawn( "script_model", ( -572, -822, 276 ) );
    var_7.angles = ( 0, 0, 0 );
    var_7 clonebrushmodeltoscriptmodel( var_6 );
    var_8 = getent( "clip64x64x128", "targetname" );
    var_9 = spawn( "script_model", ( -990, -209.5, 323 ) );
    var_9.angles = ( 90, 0, 0 );
    var_9 clonebrushmodeltoscriptmodel( var_8 );
}

_ID12485()
{
    var_0 = getentarray( "exploder_trigger", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2._ID27651 ) )
            continue;

        var_2 thread _ID12484();
    }
}

_ID12484()
{
    self endon( "death" );
    var_0 = [];
    var_0[3] = "scn_mp_lonestar_bat";
    var_0[4] = "scn_mp_lonestar_bat";

    for (;;)
    {
        self waittill( "trigger" );
        common_scripts\utility::exploder( self._ID27651 );

        if ( isdefined( var_0[self._ID27651] ) && isdefined( self.target ) )
        {
            var_1 = common_scripts\utility::_ID15386( self.target, "targetname" );

            foreach ( var_3 in var_1 )
                playsoundatpos( var_3.origin, var_0[self._ID27651] );
        }

        wait(randomfloatrange( 60, 120 ));
    }
}
#using_animtree("animated_props");

_ID25231()
{
    precachempanim( "mp_lonestar_bat_effect_path" );
    level._ID1644["bats"] = loadfx( "fx/animals/bats_swarm" );
    level._ID1644["gas_leak"] = loadfx( "fx/fire/heat_lamp_distortion" );
    level._ID1644["gas_leak_fire"] = loadfx( "fx/maps/mp_lonestar/mp_ls_gaspipe_fire" );
    level._ID25192 = [];
    level._ID25192["ground_collapse"] = "mp_lonestar_road_slab_quake";
    level._ID25192["ground_collapse_start_idle"] = "mp_lonestar_road_slab_quake_idle";
    level._ID25192["pole_fall_on_police_car"] = "mp_lonestar_police_car_crush_pole";
    level._ID25192["police_car_hit_by_pole"] = "mp_lonestar_police_car_crush_car";
    level._ID25192["wire_shake"] = "mp_lonestar_earthquake_wire_shake";
    level._ID25192["hanging_cable_loop"] = "mp_lonestar_hanging_wire_loop";
    level._ID25192["hanging_cable"] = "mp_lonestar_hanging_wire_earthquake";
    level.quake_anims_ref = [];
    level.quake_anims_ref["hanging_cable"] = %mp_lonestar_hanging_wire_earthquake;

    foreach ( var_2, var_1 in level._ID25192 )
        precachempanim( var_1 );

    level._ID24814 = [];
    level._ID25228 = [];
    _ID2230( "qauke_script_hanging_wire", getanimlength( %mp_lonestar_hanging_wire_earthquake ), 0 );
    _ID2230( "qauke_script_telephone_wire", getanimlength( %mp_lonestar_earthquake_wire_shake ), 1 );
    level._ID25190["police_car_hit_by_pole"] = [];
    level._ID25190["police_car_hit_by_pole"][0] = ::quake_event_pole_fall_on_car;
    level._ID25191["police_car_hit_by_pole"] = [];
    level._ID25191["police_car_hit_by_pole"][0] = ::_ID25210;
    common_scripts\utility::_ID35582();

    if ( level._ID8425 )
        return;

    var_3 = gettime();
    var_4 = _ID25219();
    var_5 = common_scripts\utility::_ID15384( "quake", "targetname" );
    var_6 = 3;
    var_7 = [];
    var_8 = [];

    for ( var_9 = 0; var_9 < var_6; var_9++ )
    {
        var_7[var_9] = [];
        var_8[var_9] = var_9;
    }

    var_4 = common_scripts\utility::array_randomize( var_4 );

    foreach ( var_11 in var_4 )
    {
        if ( var_11.count > 0 )
            var_8 = array_shift( var_8 );

        for ( var_9 = 0; var_9 < var_8.size && var_11.count != 0; var_9++ )
        {
            var_12 = var_8[var_9];
            var_7[var_12][var_7[var_12].size] = var_11;
            var_11.count--;
        }
    }

    var_7 = common_scripts\utility::array_randomize( var_7 );
    var_14 = max( 5, maps\mp\_utility::_ID15434() );
    var_15 = [];

    for ( var_9 = 0; var_9 < var_6; var_9++ )
    {
        var_16 = 1 / var_6 * ( var_9 + 0.2 );
        var_17 = 1 / var_6 * ( var_9 + 0.8 );
        var_15[var_9] = randomfloatrange( var_16, var_17 ) * var_14 * 60;
    }

    for ( var_9 = 0; var_9 < var_6; var_9++ )
    {
        var_18 = var_15[var_9];
        earthqauke_wait( var_18 );
        var_5 thread _ID25224( var_7[var_9] );
    }
}

earthqauke_wait( var_0 )
{
    level endon( "earthquake_start" );
    wait(var_0);
    level notify( "earthquake_start" );
}

array_shift( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < var_0.size - 1; var_2++ )
        var_1[var_2] = var_0[var_2 + 1];

    var_1[var_1.size] = var_0[0];
    return var_1;
}

_ID2230( var_0, var_1, var_2 )
{
    var_3 = getscriptablearray( var_0, "targetname" );

    foreach ( var_5 in var_3 )
        var_5._ID25227 = var_1;

    if ( var_2 )
        level._ID24814 = common_scripts\utility::array_combine( level._ID24814, var_3 );
    else
        level._ID25228 = common_scripts\utility::array_combine( level._ID25228, var_3 );
}

_ID25225( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        var_2 setscriptablepartstate( "main", "quake" );
        var_2 common_scripts\utility::delaycall( var_2._ID25227, ::setscriptablepartstate, "main", "idle" );
    }
}

_ID25224( var_0 )
{
    _ID25225( level._ID24814 );
    var_1 = undefined;

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3.script_noteworthy ) && var_3.script_noteworthy == "wires" )
        {
            var_1 = var_3;
            var_1 thread _ID25216( 0, var_1 quake_event_wait() );
            break;
        }
    }

    wait 4.0;
    _ID25225( level._ID25228 );
    var_5 = randomfloatrange( 7, 9 );
    playsoundatpos( ( 0, 0, 0 ), "mp_earthquake_lr" );
    earthquake( 0.3, var_5, self.origin, self.radius );
    common_scripts\utility::exploder( 1 );

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_1 ) || var_3 != var_1 )
            var_3 thread _ID25216( var_5, var_3 quake_event_wait() );
    }
}

_ID25216( var_0, var_1 )
{
    if ( isdefined( var_1 ) && var_1 > 0 )
        wait(var_1);

    self notify( "trigger",  var_0  );
}

quake_event_wait()
{
    if ( isdefined( self._ID27906 ) )
        return self._ID27906;
    else if ( isdefined( self._ID27909 ) && isdefined( self._ID27908 ) )
        return randomfloatrange( self._ID27909, self._ID27908 );

    return 0;
}

_ID25217( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    for (;;)
    {
        self waittill( "trigger",  var_7  );

        if ( isdefined( var_6 ) )
        {
            self thread [[ var_0 ]]( var_7, var_1, var_2, var_3, var_4, var_5, var_6 );
            continue;
        }

        if ( isdefined( var_5 ) )
        {
            self thread [[ var_0 ]]( var_7, var_1, var_2, var_3, var_4, var_5 );
            continue;
        }

        if ( isdefined( var_4 ) )
        {
            self thread [[ var_0 ]]( var_7, var_1, var_2, var_3, var_4 );
            continue;
        }

        if ( isdefined( var_3 ) )
        {
            self thread [[ var_0 ]]( var_7, var_1, var_2, var_3 );
            continue;
        }

        if ( isdefined( var_2 ) )
        {
            self thread [[ var_0 ]]( var_7, var_1, var_2 );
            continue;
        }

        if ( isdefined( var_1 ) )
        {
            self thread [[ var_0 ]]( var_7, var_1 );
            continue;
        }

        self thread [[ var_0 ]]( var_7 );
    }
}

_ID25219()
{
    var_0 = common_scripts\utility::_ID15386( "quake_event", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::quake_event_init );
    return var_0;
}

quake_event_init()
{
    var_0 = getentarray( self.target, "targetname" );

    if ( isdefined( self.script_noteworthy ) )
    {
        var_1 = strtok( self.script_noteworthy, "," );

        foreach ( var_3 in var_1 )
        {
            var_4 = getentarray( var_3, "targetname" );
            var_0 = common_scripts\utility::array_combine( var_0, var_4 );
        }
    }

    foreach ( var_7 in var_0 )
    {
        if ( var_7 maps\mp\_movers::script_mover_is_script_mover() )
        {
            thread _ID25217( ::_ID25213, var_7, "trigger" );
            continue;
        }

        _ID25206( var_7 );

        if ( !isdefined( var_7.script_noteworthy ) )
            continue;

        var_8 = strtok( var_7.script_noteworthy, "," );

        foreach ( var_10 in var_8 )
        {
            switch ( var_10 )
            {
                case "ground_collapse":
                    thread _ID25217( ::_ID25207, var_7, 1, undefined, 1, 0, 1 );
                    continue;
                case "shake":
                    thread _ID25217( ::_ID25214, var_7 );
                    continue;
                case "hurt":
                    if ( !isdefined( var_7._ID27506 ) )
                        var_7._ID27506 = 25;

                    if ( !isdefined( var_7.script_delay ) )
                        var_7.script_delay = 1;

                    thread _ID25217( ::quake_event_hurt, var_7, var_7.script_delay, var_7._ID27506 );
                    continue;
                case "hurt_fire":
                    thread _ID25217( ::quake_event_hurt, var_7, 1, 25 );
                    continue;
                case "delete":
                    thread _ID25217( ::_ID25198, var_7 );
                    continue;
                case "animate":
                    if ( isdefined( var_7._ID27443 ) )
                    {
                        if ( isdefined( level._ID25191[var_7._ID27443] ) )
                        {
                            foreach ( var_12 in level._ID25191[var_7._ID27443] )
                                level thread [[ var_12 ]]( var_7 );
                        }

                        if ( isdefined( level._ID25192[var_7._ID27443 + "_start_idle"] ) )
                            var_7 scriptmodelplayanim( level._ID25192[var_7._ID27443 + "_start_idle"] );

                        if ( isdefined( level._ID25192[var_7._ID27443 + "_loop"] ) )
                            var_7 scriptmodelplayanim( level._ID25192[var_7._ID27443 + "_loop"] );

                        if ( isdefined( level._ID25192[var_7._ID27443] ) )
                            thread _ID25217( ::_ID25194, var_7, var_7._ID27443 );
                    }

                    continue;
                case "show":
                    var_7 hide();
                    thread _ID25217( ::_ID25215, var_7 );
                    continue;
                case "move_to_end":
                    var_14 = 1;

                    if ( isdefined( var_7._ID27766 ) )
                        var_14 = float( var_7._ID27766 );

                    thread _ID25217( ::_ID25207, var_7, 0.5, var_7.script_delay );
                    continue;
                case "gas_leak":
                    if ( isdefined( self.target ) )
                    {
                        var_7._ID13871 = common_scripts\utility::_ID15384( var_7.target, "targetname" );
                        var_7._ID17276 = getent( var_7.target, "targetname" );
                        thread _ID25217( ::quake_event_gas_leak, var_7 );
                    }

                    continue;
                case "sound":
                    thread _ID25217( ::_ID25208, var_7 );
                    continue;
                default:
                    continue;
            }
        }
    }

    var_17 = common_scripts\utility::_ID15386( self.target, "targetname" );

    foreach ( var_19 in var_17 )
    {
        if ( !isdefined( var_19.script_noteworthy ) )
            continue;

        switch ( var_19.script_noteworthy )
        {
            case "fx":
                if ( !isdefined( var_19._ID27766 ) )
                    var_19._ID27766 = "gas_leak";

                if ( !isdefined( var_19.angles ) )
                    var_19.angles = ( 0, 0, 0 );

                var_20 = spawnfx( level._ID1644[var_19._ID27766], var_19.origin, anglestoforward( var_19.angles ) );
                thread _ID25217( ::_ID25202, var_20 );
                continue;
            case "exploder":
                var_21 = var_19._ID27779;

                if ( !isdefined( var_21 ) )
                    var_21 = var_19._ID27562;

                if ( isdefined( var_21 ) )
                    thread _ID25217( ::_ID25201, var_21 );

                continue;
            case "sound":
                thread _ID25217( ::_ID25208, var_19 );
                continue;
            default:
                continue;
        }
    }

    var_23 = getvehiclenodearray( self.target, "targetname" );

    foreach ( var_25 in var_23 )
    {
        if ( !isdefined( var_25.script_noteworthy ) )
            continue;

        switch ( var_25.script_noteworthy )
        {
            case "bats":
                thread _ID25217( ::_ID25195, var_25 );
            default:
                continue;
        }
    }

    var_27 = maps\mp\_utility::getlinknamenodes();

    foreach ( var_25 in var_27 )
    {
        if ( !isdefined( var_25.script_noteworthy ) )
            continue;

        switch ( var_25.script_noteworthy )
        {
            case "connect_traverse":
                _ID10185( var_25 );
                thread _ID25217( ::_ID25197, var_25 );
                continue;
            case "disconnect_traverse":
                thread _ID25217( ::_ID25200, var_25 );
                continue;
            case "connect":
                var_25 disconnectnode();
                thread _ID25217( ::_ID25196, var_25 );
                continue;
            case "disconnect":
                thread _ID25217( ::quake_event_disconnect_node, var_25 );
                continue;
            default:
                continue;
        }
    }

    if ( !isdefined( self.count ) )
        self.count = 1;
}

is_dynamic_path()
{
    return isdefined( self.spawnflags ) && self.spawnflags & 1;
}

_ID25206( var_0 )
{
    var_0._ID21567 = var_0;

    if ( !isdefined( var_0.target ) )
        return;

    var_1 = common_scripts\utility::_ID15386( var_0.target, "targetname" );
    var_2 = getentarray( var_0.target, "targetname" );
    var_3 = common_scripts\utility::array_combine( var_1, var_2 );

    foreach ( var_5 in var_3 )
    {
        if ( !isdefined( var_5.script_noteworthy ) )
            continue;

        switch ( var_5.script_noteworthy )
        {
            case "link":
                var_5 linkto( var_0 );
                continue;
            case "origin":
                var_0._ID21567 = spawn( "script_model", var_5.origin );
                var_0._ID21567.angles = ( 0, 0, 0 );

                if ( isdefined( var_5.angles ) )
                    var_0._ID21567.angles = var_5.angles;

                var_0._ID21567 setmodel( "tag_origin" );
                var_0 linkto( var_0._ID21567 );
                continue;
            case "end":
                var_0._ID11557 = var_5;
                continue;
            case "start":
                if ( var_0 is_dynamic_path() )
                    var_0 connectpaths();

                var_0.origin = var_5.origin;

                if ( isdefined( var_5.angles ) )
                    var_0.angles = var_5.angles;

                continue;
            default:
                continue;
        }
    }
}

_ID25207( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_1._ID11557 ) )
        return;

    if ( !isdefined( var_4 ) )
        var_4 = 0;

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    if ( !isdefined( var_6 ) )
        var_6 = 0;

    if ( isdefined( var_3 ) && var_3 > 0 )
        wait(var_3);

    if ( var_1._ID11557.origin != var_1.origin )
        var_1._ID21567 moveto( var_1._ID11557.origin, var_2, var_4, var_5 );

    if ( isdefined( var_1._ID11557.angles ) && var_1._ID11557.angles != var_1.angles )
        var_1._ID21567 rotateto( var_1._ID11557.angles, var_2, var_4, var_5 );

    wait(var_2);

    if ( var_1 is_dynamic_path() )
        var_1 disconnectpaths();

    if ( var_6 )
    {
        var_1._ID21567 delete();

        if ( isdefined( var_1 ) )
            var_1 delete();
    }
}

_ID25214( var_0, var_1 )
{

}

_ID25195( var_0, var_1 )
{
    var_2 = ( 752, -3536, 132 );
    var_3 = spawn( "script_model", var_2 );
    var_3.angles = ( 0, 0, 0 );
    var_3 setmodel( "generic_prop_raven" );
    common_scripts\utility::_ID35582();
    var_4 = spawn( "script_model", var_2 );
    var_4 setmodel( "tag_origin" );
    var_4 linkto( var_3, "j_prop_2" );
    common_scripts\utility::_ID35582();
    playfxontag( level._ID1644["bats"], var_3, "j_prop_2" );
    var_3 scriptmodelplayanimdeltamotion( "mp_lonestar_bat_effect_path" );
    var_4 playloopsound( "mp_quake_bat_lp" );
    wait(getanimlength( %mp_lonestar_bat_effect_path ));
    var_4 delete();
    var_3 delete();
}

quake_event_hurt( var_0, var_1, var_2, var_3 )
{
    thread quake_hurt_trigger( var_1, var_2, var_3 );
}

quake_hurt_trigger( var_0, var_1, var_2 )
{
    self endon( "stop_hurt_trigger" );
    var_3 = var_0 getentitynumber();
    var_4 = var_1 * 1000;

    for (;;)
    {
        var_0 waittill( "trigger",  var_5  );

        if ( !isdefined( var_5._ID25220 ) )
            var_5._ID25220 = [];

        if ( !isdefined( var_5._ID25220[var_3] ) )
            var_5._ID25220[var_3] = -1 * var_4;

        if ( var_5._ID25220[var_3] + var_4 > gettime() )
            continue;

        var_5._ID25220[var_3] = gettime();
        var_5 dodamage( var_2, var_0.origin );
    }
}

_ID25215( var_0, var_1 )
{
    var_1 show();
}

_ID25198( var_0, var_1 )
{
    var_1 delete();
}

_ID25202( var_0, var_1 )
{
    triggerfx( var_1 );
}

_ID25201( var_0, var_1 )
{
    common_scripts\utility::exploder( var_1 );
}

_ID25213( var_0, var_1, var_2 )
{
    var_1 notify( var_2 );
}

_ID25194( var_0, var_1, var_2 )
{
    var_1 scriptmodelplayanimdeltamotion( level._ID25192[var_2] );

    if ( isdefined( level._ID25190[var_2] ) )
    {
        foreach ( var_4 in level._ID25190[var_2] )
            level thread [[ var_4 ]]( var_0, var_1 );
    }

    if ( isdefined( level._ID25192[var_2 + "_loop"] ) && isdefined( level.quake_anims_ref[var_2] ) )
    {
        var_6 = getanimlength( level.quake_anims_ref[var_2] );
        wait(var_6);
        var_1 scriptmodelplayanim( level._ID25192[var_1._ID27443 + "_loop"] );
    }
}

quake_event_gas_leak( var_0, var_1 )
{
    for (;;)
    {
        var_2 = spawnfx( level._ID1644["gas_leak_fire"], var_1._ID13871.origin, anglestoforward( var_1._ID13871.angles ) );
        triggerfx( var_2 );
        var_1 playloopsound( "emt_lone_gas_pipe_fire_lp" );
        thread quake_hurt_trigger( var_1._ID17276, 0.25, 10 );
        wait 30;
        self notify( "stop_hurt_trigger" );
        var_2 delete();
        var_1 stoploopsound( "emt_lone_gas_pipe_fire_lp" );
        var_3 = spawnfx( level._ID1644["gas_leak"], var_1._ID13871.origin, anglestoforward( var_1._ID13871.angles ) );
        triggerfx( var_3 );
        var_1 common_scripts\utility::waittill_notify_or_timeout( "trigger", 30 );
        var_3 delete();
    }
}

_ID25212()
{
    var_0 = getnodearray( "dog_pole_vault", "script_noteworthy" );

    if ( isdefined( var_0 ) )
        disconnectnodepair( var_0[0], var_0[1] );

    var_1 = getnodearray( "dog_pole_vault2", "script_noteworthy" );

    if ( isdefined( var_1 ) )
        disconnectnodepair( var_1[0], var_1[1] );
}

_ID25211()
{
    var_0 = getnodearray( "dog_pole_vault", "script_noteworthy" );

    if ( isdefined( var_0 ) )
    {
        if ( isdefined( var_0[0].target ) && isdefined( var_0[1].targetname ) && var_0[0].target == var_0[1].targetname )
            connectnodepair( var_0[0], var_0[1], 1 );
        else
            connectnodepair( var_0[1], var_0[0], 1 );
    }

    var_1 = getnodearray( "dog_pole_vault2", "script_noteworthy" );

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_1[0].target ) && isdefined( var_1[1].targetname ) && var_1[0].target == var_1[1].targetname )
            connectnodepair( var_1[0], var_1[1], 1 );
        else
            connectnodepair( var_1[1], var_1[0], 1 );
    }
}

_ID25210( var_0 )
{
    var_1 = getent( "pole_that_falls_on_cop_car_base", "targetname" );

    if ( isdefined( var_1 ) )
        var_1 hide();

    var_2 = getent( "pole_that_falls_on_cop_car", "targetname" );

    if ( !isdefined( var_2 ) )
        return;

    var_3 = getentarray( var_2.target, "targetname" );

    foreach ( var_5 in var_3 )
    {
        if ( var_5.script_noteworthy == "clip_up" )
        {
            var_5 linkto( var_2 );
            var_2.clip_up = var_5;
            continue;
        }

        if ( var_5.script_noteworthy == "clip_down" )
        {
            var_5 connectpaths();
            var_5 common_scripts\utility::_ID33657();
            var_2.clip_down = var_5;
        }
    }

    _ID25212();
}

quake_event_pole_fall_on_car( var_0, var_1 )
{
    var_2 = getent( "pole_that_falls_on_cop_car_base", "targetname" );

    if ( isdefined( var_2 ) )
        var_2 show();

    var_3 = getent( "pole_that_falls_on_cop_car", "targetname" );

    if ( !isdefined( var_3 ) )
        return;

    var_3 setmodel( "ls_telephone_pole_snap" );
    var_3 playsound( "scn_pole_fall" );
    var_4 = spawn( "script_model", var_3.origin );
    var_4 setmodel( "generic_prop_raven" );
    var_4.angles = var_3.angles;
    var_3 linkto( var_4, "j_prop_1" );
    var_4 scriptmodelplayanimdeltamotion( "mp_lonestar_police_car_crush_pole" );
    var_5 = getnotetracktimes( %mp_lonestar_police_car_crush_pole, "car_swap" );
    var_6 = getanimlength( %mp_lonestar_police_car_crush_pole );
    wait(var_5[0] * var_6);
    var_1 playsound( "scn_police_car_crush" );
    common_scripts\utility::exploder( 7 );
    var_3.clip_down common_scripts\utility::_ID33659();
    var_3.clip_down disconnectpaths();
    _ID25211();
    var_3.clip_up delete();
    var_1 setmodel( "ls_police_sedan_smashed" );

    foreach ( var_8 in level.characters )
    {
        if ( var_8 istouching( var_3.clip_down ) )
            var_8 maps\mp\_movers::mover_suicide();
    }
}

_ID25208( var_0, var_1 )
{
    if ( !isdefined( var_1._ID27818 ) )
        return;

    playsoundatpos( var_1.origin, var_1._ID27818 );
}

quake_event_disconnect_node( var_0, var_1 )
{
    var_1 disconnectnode();
}

_ID25196( var_0, var_1 )
{
    var_1 connectnode();
}

_ID25200( var_0, var_1 )
{
    _ID10185( var_1 );
}

_ID10185( var_0 )
{
    if ( !isdefined( var_0.end_nodes ) )
        var_0.end_nodes = getnodearray( var_0.target, "targetname" );

    foreach ( var_2 in var_0.end_nodes )
        disconnectnodepair( var_0, var_2, 1 );
}

_ID25197( var_0, var_1 )
{
    connect_traverse( var_1 );
}

connect_traverse( var_0 )
{
    if ( !isdefined( var_0.end_nodes ) )
        var_0.end_nodes = getnodearray( var_0.target, "targetname" );

    foreach ( var_2 in var_0.end_nodes )
        connectnodepair( var_0, var_2, 1 );
}
