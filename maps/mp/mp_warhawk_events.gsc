// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool
#using_animtree("animated_props");

_ID24833()
{
    level._ID16507 = [];
    level._ID16507["heli_flyby_01"] = "mp_warhawk_heli_flyby_01";
    level._ID16507["heli_flyby_02"] = "mp_warhawk_heli_flyby_02";
    level.heli_anims_length = [];
    level.heli_anims_length["heli_flyby_01"] = getanimlength( %mp_warhawk_heli_flyby_01 );
    level.heli_anims_length["heli_flyby_02"] = getanimlength( %mp_warhawk_heli_flyby_02 );
    level._ID2653 = 0;
    precachempanim( "mp_warhawk_metal_door_open_in" );
    precachempanim( "mp_warhawk_metal_door_open_in_loop" );
    precachempanim( "mp_warhawk_metal_door_open_out" );
    precachempanim( "mp_warhawk_metal_door_open_out_loop" );
    precachempanim( "mp_frag_metal_door_chain" );
    common_scripts\utility::_ID13189( "chain_broken" );
}

_ID25359( var_0, var_1 )
{
    level endon( "random_destruction" );

    if ( !level._ID8425 )
    {
        var_2 = randomfloatrange( var_0, var_1 );
        wait(var_2);
        level._ID21982++;
        level notify( "random_destruction",  level._ID25393[level._ID21982 - 1]  );
    }
}

_ID25355( var_0, var_1 )
{
    level endon( "stop_dynamic_events" );
    common_scripts\utility::_ID35582();

    if ( !isdefined( level._ID9826 ) )
        level._ID9826 = common_scripts\utility::_ID15386( "random_destructible", "targetname" );

    _ID25357( level._ID9826 );

    for (;;)
    {
        thread _ID25359( var_0, var_1 );
        level waittill( "random_destruction",  var_2  );

        if ( !isdefined( var_2 ) )
            continue;

        var_2 -= 1;

        if ( level._ID9826[var_2]._ID13061 )
        {
            _ID25358( var_2 );
            level._ID9826[var_2]._ID13061 = 0;
        }
        else
        {
            _ID25356( var_2 );
            level._ID9826[var_2]._ID13061 = 1;
        }

        if ( level._ID21982 >= level._ID25393.size )
            break;
    }
}

_ID25358( var_0 )
{
    var_1 = getentarray( level._ID9826[var_0].target, "targetname" );

    foreach ( var_3 in var_1 )
    {
        switch ( var_3.script_noteworthy )
        {
            case "destructible_before":
                var_3 common_scripts\utility::_ID33659();
                continue;
            case "destructible_after":
                var_3 common_scripts\utility::_ID33657();
                continue;
            case "undefined":
            default:
                continue;
        }
    }
}

exploders_explode_for_late_player()
{
    self endon( "disconnect" );

    if ( isdefined( level.exploders_cached ) )
    {
        var_0 = 0;

        foreach ( var_2 in level.exploders_cached )
        {
            common_scripts\utility::exploder( var_2.index, self, var_2._ID33037 );
            var_0++;

            if ( var_0 >= 4 )
            {
                wait 0.05;
                var_0 = 0;
            }
        }
    }
}

_ID12493()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread exploders_explode_for_late_player();
    }
}

exploder_cache( var_0 )
{
    if ( !isdefined( level.exploders_cached ) )
        level.exploders_cached = [];

    var_1 = spawnstruct();
    var_1.index = var_0;
    var_1._ID33037 = level._ID33037;
    level.exploders_cached[level.exploders_cached.size] = var_1;
}

_ID25356( var_0 )
{
    if ( !level._ID9826[var_0]._ID21481.size || !level._ID9826[var_0].mortar_ends.size )
        return;

    var_1 = common_scripts\utility::_ID25350( level._ID9826[var_0]._ID21481 );
    var_2 = common_scripts\utility::_ID25350( level._ID9826[var_0].mortar_ends );
    _ID25368( var_1.origin, var_2.origin, var_1._ID27550, undefined, 0, 0 );
    var_3 = getentarray( level._ID9826[var_0].target, "targetname" );

    foreach ( var_5 in var_3 )
    {
        switch ( var_5.script_noteworthy )
        {
            case "destructible_before":
                var_5 maps\mp\_movers::notify_moving_platform_invalid();
                var_5 common_scripts\utility::_ID33657();
                continue;
            case "destructible_after":
                var_5 common_scripts\utility::_ID33659();
                continue;
            case "undefined":
            default:
                continue;
        }
    }

    common_scripts\utility::exploder( 50 + var_0 );
    exploder_cache( 50 + var_0 );
    var_7 = common_scripts\utility::_ID15386( level._ID9826[var_0].target, "targetname" );

    foreach ( var_5 in var_7 )
    {
        if ( isdefined( var_5.script_noteworthy ) && isdefined( level._ID1644[var_5.script_noteworthy] ) )
            playfx( level._ID1644[var_5.script_noteworthy], var_5.origin );
    }

    if ( isdefined( level._ID9826[var_0]._ID27766 ) )
    {
        var_10 = strtok( level._ID9826[var_0]._ID27766, ";" );

        foreach ( var_12 in var_10 )
        {
            var_13 = strtok( var_12, "=" );

            if ( var_13.size != 2 )
                continue;

            switch ( var_13[0] )
            {
                case "play_sound":
                    playsoundatpos( level._ID9826[var_0].origin, var_13[1] );
                    continue;
                case "play_loopsound":
                    level._ID9826[var_0]._ID20336 playloopsound( var_13[1] );
                    continue;
                case "play_fx":
                    playfx( level._ID1644[var_13[1]], level._ID9826[var_0].origin );
                    continue;
                default:
                    continue;
            }
        }
    }
}

_ID25357( var_0 )
{
    level._ID21982 = 0;
    level._ID25393 = [];

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        level._ID25393[var_1] = var_1 + 1;

    level._ID25393 = common_scripts\utility::array_randomize( level._ID25393 );

    foreach ( var_3 in var_0 )
    {
        var_3._ID21481 = [];
        var_3.mortar_ends = [];
        var_3._ID13061 = 0;
        var_4 = [];
        var_5 = undefined;
        var_6 = undefined;
        var_7 = undefined;
        var_8 = undefined;
        var_9 = common_scripts\utility::_ID15386( var_3.target, "targetname" );

        foreach ( var_11 in var_9 )
        {
            switch ( var_11.script_noteworthy )
            {
                case "before_start_origin":
                    var_5 = var_11.origin;
                    continue;
                case "before_end_origin":
                    var_6 = var_11.origin;
                    continue;
                case "after_start_origin":
                    var_7 = var_11.origin;
                    continue;
                case "after_end_origin":
                    var_8 = var_11.origin;
                    continue;
                case "mortar_start":
                    var_3._ID21481[var_3._ID21481.size] = var_11;
                    continue;
                case "mortar_end":
                    var_3.mortar_ends[var_3.mortar_ends.size] = var_11;
                    continue;
                default:
                    continue;
            }
        }

        var_13 = undefined;
        var_14 = undefined;

        if ( isdefined( var_5 ) && isdefined( var_6 ) )
            var_13 = var_6 - var_5;

        if ( isdefined( var_7 ) && isdefined( var_8 ) )
            var_14 = var_8 - var_7;

        var_15 = getentarray( var_3.target, "targetname" );

        foreach ( var_11 in var_15 )
        {
            switch ( var_11.script_noteworthy )
            {
                case "destructible_before":
                    var_4[var_4.size] = var_11;

                    if ( isdefined( var_13 ) )
                        var_11.origin = var_11.origin + var_13;

                    continue;
                case "destructible_after":
                    if ( isdefined( var_14 ) )
                        var_11.origin = var_11.origin + var_14;

                    var_11 common_scripts\utility::_ID33657();
                    continue;
                case "loop_sound_ent":
                    var_3._ID20336 = var_11;
                    continue;
                case "delete":
                    var_11 delete();
                    continue;
                default:
                    continue;
            }
        }

        if ( var_3._ID21481.size == 0 )
            var_3._ID21481 = common_scripts\utility::_ID15386( "air_raid", "targetname" );

        if ( var_3.mortar_ends.size == 0 )
            var_3.mortar_ends = var_4;
    }
}

_ID23683()
{

}

_ID23686()
{
    if ( !isdefined( self.target ) )
        return;

    if ( !isdefined( self._ID27443 ) || !isdefined( level._ID23684[self._ID27443] ) )
        return;

    var_0 = getentarray( self.target, "targetname" );
    var_1 = common_scripts\utility::_ID15386( self.target, "targetname" );
    var_2 = common_scripts\utility::array_combine( var_0, var_1 );

    foreach ( var_4 in var_2 )
    {
        if ( !isdefined( var_4.script_noteworthy ) )
            continue;

        switch ( var_4.script_noteworthy )
        {
            case "plane":
                self._ID23677 = var_4;
                thread _ID26963( "end", ::delete_ent, var_4 );
                continue;
            case "scene_node":
                self._ID27341 = var_4;

                if ( !isdefined( self._ID27341.angles ) )
                    self._ID27341.angles = ( 0, 0, 0 );

                continue;
            case "show":
                var_4 hide();
                thread _ID26963( var_4._ID27766, ::show_ent, var_4 );
                continue;
            case "show_trigger":
                var_4 common_scripts\utility::_ID33657();
                thread _ID26963( var_4._ID27766, ::_ID29951, var_4 );
                continue;
            case "kill_players":
                thread _ID26963( var_4._ID27766, ::kill_players_touching_ent, var_4 );
                continue;
            case "delete":
                thread _ID26963( var_4._ID27766, ::delete_ent, var_4 );
                continue;
            case "fx":
                thread _ID26963( var_4._ID27766, ::_ID23766, var_4 );
                continue;
            case "trigger_fx":
                if ( isdefined( var_4._ID27611 ) && isdefined( level._ID1644[var_4._ID27611] ) )
                {
                    var_5 = spawnfx( level._ID1644[var_4._ID27611], var_4.origin, anglestoforward( var_4.angles ) );
                    thread _ID26963( var_4._ID27766, ::_ID33616, var_5 );
                }

                continue;
            default:
                continue;
        }
    }

    if ( self._ID27443 == "mp_warhawk_osprey_crash" )
    {
        thread _ID26963( "start", ::play_fx_on_tag, "osprey_trail", "tag_engine_ri_fx2", self._ID23677 );
        thread _ID26963( "crash_sound", ::_ID23842, self._ID23677, "osprey_crash" );
        thread _ID26963( "hit_watertower", ::_ID23838, self._ID23677, "osprey_hit_tower" );
        thread _ID26963( "hit_ground", ::_ID31787, "osprey_trail", "tag_engine_ri_fx2", self._ID23677 );
    }
}

plan_crash_run( var_0 )
{
    level endon( "stop_dynamic_events" );

    if ( isdefined( var_0 ) )
        wait(var_0);

    if ( isdefined( self._ID27341 ) )
    {
        self._ID23677.origin = self._ID27341.origin;
        self._ID23677.angles = self._ID27341.angles;
    }

    self._ID23677 scriptmodelplayanimdeltamotion( self._ID27443 );
    thread run_anim_events( level._ID23685[self._ID27443] );
}

create_anim_event( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2._ID33037 = var_1;
    var_2._ID22159 = var_0;
    var_2.done = 0;
    return var_2;
}

run_anim_events( var_0 )
{
    var_1 = gettime();

    for (;;)
    {
        foreach ( var_3 in var_0 )
        {
            if ( var_3.done )
                continue;

            if ( ( gettime() - var_1 ) / 1000 >= var_3._ID33037 )
            {
                self notify( var_3._ID22159 );
                var_3.done = 1;

                if ( var_3._ID22159 == "end" )
                    return;
            }
        }

        wait 0.05;
    }
}

_ID26963( var_0, var_1, var_2, var_3, var_4 )
{
    self waittill( var_0 );

    if ( isdefined( var_4 ) )
        self thread [[ var_1 ]]( var_2, var_3, var_4 );
    else if ( isdefined( var_3 ) )
        self thread [[ var_1 ]]( var_2, var_3 );
    else if ( isdefined( var_2 ) )
        self thread [[ var_1 ]]( var_2 );
    else
        self thread [[ var_1 ]]();
}

show_ent( var_0 )
{
    var_0 show();
}

_ID29951( var_0 )
{
    var_0 common_scripts\utility::_ID33659();
}

delete_ent( var_0 )
{
    var_0 delete();
}

_ID23842( var_0, var_1 )
{
    var_0 playsound( var_1 );
}

_ID23838( var_0, var_1 )
{
    playsoundatpos( var_0.origin, var_1 );
}

kill_players_touching_ent( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( var_2 istouching( var_0 ) )
            var_2 maps\mp\_movers::mover_suicide();
    }
}

_ID23766( var_0 )
{
    if ( !isdefined( var_0._ID27611 ) || !isdefined( level._ID1644[var_0._ID27611] ) )
        return;

    playfx( level._ID1644[var_0._ID27611], var_0.origin, anglestoforward( var_0.angles ) );
}

_ID33616( var_0 )
{
    triggerfx( var_0 );
}

play_fx_on_tag( var_0, var_1, var_2 )
{
    playfxontag( common_scripts\utility::_ID15033( var_0 ), var_2, var_1 );
}

_ID31787( var_0, var_1, var_2 )
{
    stopfxontag( common_scripts\utility::_ID15033( var_0 ), var_2, var_1 );
}

_ID25368( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = ( 0, 0, -800 );

    if ( !isdefined( var_2 ) )
        var_2 = randomfloatrange( 3, 4 );

    var_7 = trajectorycalculateinitialvelocity( var_0, var_1, var_6, var_2 );

    if ( isdefined( var_4 ) && var_4 )
    {
        var_8 = trajectorycomputedeltaheightattime( var_7[2], -1 * var_6[2], var_2 / 2 );
        var_9 = ( var_1 - var_0 ) / 2 + var_0 + ( 0, 0, var_8 );

        if ( bullettracepassed( var_9, var_1, 0, undefined ) )
        {
            thread _ID25369( var_0, var_1, var_2, var_3, var_7, var_5 );
            return 1;
        }
        else
            return 0;
    }

    _ID25369( var_0, var_1, var_2, var_3, var_7, var_5 );
}

_ID25369( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = 350;
    var_7 = _ID25370( var_0 );
    var_7.origin = var_0;
    var_7._ID17490 = 1;
    common_scripts\utility::_ID35582();
    playfxontag( common_scripts\utility::_ID15033( "random_mortars_trail" ), var_7, "tag_fx" );
    var_7.angles = vectortoangles( var_4 ) * ( -1, 1, 1 );
    maps\mp\_utility::_ID9519( var_2 - 2.0, ::random_mortars_incoming_sound, var_1 );
    var_7 movegravity( var_4, var_2 - 0.05 );
    var_7 waittill( "movedone" );

    if ( level._ID8425 && !isdefined( level.players ) )
        level.players = [];

    if ( isdefined( var_3 ) )
        var_7 radiusdamage( var_1, 250, 750, 500, var_3, "MOD_EXPLOSIVE", "warhawk_mortar_mp" );
    else
        var_7 radiusdamage( var_1, 140, 5, 5, undefined, "MOD_EXPLOSIVE", "warhawk_mortar_mp" );

    playrumbleonposition( "artillery_rumble", var_1 );

    foreach ( var_9 in level.players )
    {
        if ( var_9 maps\mp\_utility::_ID18837() )
            continue;

        if ( distance( var_1, var_9.origin ) > var_6 )
            continue;

        if ( var_9 damageconetrace( var_1 ) )
            var_9 thread maps\mp\gametypes\_shellshock::_ID10047( var_1 );
    }

    if ( var_5 )
        playfx( common_scripts\utility::_ID15033( "mortar_impact_00" ), var_1 );

    var_7 delete();
}

random_mortars_incoming_sound( var_0 )
{
    playsoundatpos( var_0, "mortar_incoming" );
}

random_mortars_get_target()
{
    var_0 = common_scripts\utility::_ID15386( self.target, "targetname" );

    if ( var_0.size == 0 )
        return undefined;

    var_1 = common_scripts\utility::_ID25350( var_0 );
    var_2 = var_1.origin;

    if ( isdefined( var_1.radius ) )
    {
        var_3 = anglestoforward( ( 0, randomfloatrange( 0, 360 ), 0 ) );
        var_2 += var_3 * randomfloatrange( 0, var_1.radius );
    }

    return var_2;
}

_ID25370( var_0 )
{
    var_1 = spawn( "script_model", var_0 );
    var_1 setmodel( "projectile_rpg7" );
    return var_1;
}

draw_move_path()
{
    self endon( "movedone" );

    for (;;)
    {
        var_0 = self.origin;
        wait 0.5;
        thread maps\mp\_utility::_ID10878( var_0, self.origin, 600, ( 1, 0, 0 ) );
    }
}

draw_model_path()
{
    self endon( "movedone" );
    var_0 = [];

    for (;;)
    {
        wait 0.5;
        var_1 = spawn( "script_model", self.origin );
        var_1 setmodel( self.model );
        var_1.angles = self.angles;
        var_0[var_0.size] = var_1;
    }

    wait 10;

    foreach ( var_1 in var_0 )
        var_1 delete();
}

_ID18949()
{
    var_0 = [];
    var_1 = common_scripts\utility::_ID15386( "jet_flyby_radial", "targetname" );
    var_2 = common_scripts\utility::array_combine( var_0, var_1 );

    foreach ( var_4 in var_2 )
        var_4._ID25259 = var_4.targetname == "jet_flyby_radial";

    for (;;)
    {
        wait(randomfloatrange( 10, 20 ));
        var_2 = common_scripts\utility::array_randomize( var_2 );

        for ( var_6 = 0; var_6 < var_2.size; var_6++ )
        {
            var_4 = var_2[var_6];
            var_7 = undefined;
            var_8 = undefined;

            if ( var_4._ID25259 )
            {
                var_7 = spawnstruct();
                var_8 = spawnstruct();

                if ( !isdefined( var_4.radius ) )
                    var_4.radius = 8000;

                var_9 = ( 0, randomfloatrange( 0, 360 ), 0 );
                var_10 = anglestoforward( var_9 );
                var_7.origin = var_4.origin - var_4.radius * var_10;
                var_7.angles = ( var_9[0] + 3, var_9[1], 0 );
                var_8.origin = var_4.origin + var_4.radius * var_10;
                var_8.angles = ( var_9[0] + 5, var_9[1], 0 );

                if ( isdefined( var_4.height ) )
                {
                    var_7.origin = var_7.origin + ( 0, 0, randomfloatrange( 0, var_4.height ) );
                    var_8.origin = var_8.origin + ( 0, 0, randomfloatrange( 0, var_4.height ) );
                }
            }
            else
            {
                var_11 = common_scripts\utility::_ID15386( var_4.target, "targetname" );
                var_12 = common_scripts\utility::_ID25350( var_11 );

                if ( !isdefined( var_12 ) )
                    continue;

                var_7 = var_4;
                var_8 = var_12;
            }

            var_13 = randomfloatrange( 1500, 1600 );
            var_14 = distance( var_7.origin, var_8.origin );
            var_15 = var_14 / var_13;
            var_16 = spawn( "script_model", var_7.origin );
            var_16.angles = var_8.angles;
            var_16 setmodel( "vehicle_pavelow" );
            common_scripts\utility::_ID35582();
            var_16 playloopsound( "cobra_helicopter_dying_loop" );
            var_16 moveto( var_8.origin, var_15 );
            var_16 rotateto( var_8.angles, var_15 );
            var_16 waittill( "movedone" );
            var_16 delete();
            wait(randomfloatrange( 10, 20 ));
        }
    }
}

air_raid()
{
    level endon( "stop_dynamic_events" );
    common_scripts\utility::_ID35582();
    level.air_raids = common_scripts\utility::_ID15386( "air_raid", "targetname" );

    foreach ( var_1 in level.air_raids )
    {
        if ( !isdefined( var_1.radius ) )
            var_1.radius = 300;

        var_1.current_end = 0;
        var_1._ID11757 = [];

        for ( var_2 = var_1; isdefined( var_2.target ); var_1._ID11757[var_1._ID11757.size] = var_2 )
        {
            var_2 = common_scripts\utility::_ID15384( var_2.target, "targetname" );

            if ( !isdefined( var_2.radius ) )
                var_2.radius = 100;
        }
    }

    for (;;)
    {
        level._ID2653 = 0;
        level.air_raid_team_called = "none";
        level waittill( "warhawk_mortar_killstreak",  var_4  );
        level._ID2653 = 1;
        level.air_raid_team_called = var_4.team;
        thread air_raid_siren( 10 );
        wait 3;
        air_raid_fire( 0.5, 0.6, 25, var_4 );
    }
}

air_raid_siren( var_0 )
{
    if ( !isdefined( level._ID2656 ) )
        level._ID2656 = getent( "air_raid_siren", "targetname" );

    if ( isdefined( level._ID2656 ) )
        level._ID2656 playsound( "air_raid_siren" );

    wait(var_0);

    if ( isdefined( level._ID2656 ) )
        level._ID2656 stopsounds();
}

air_raid_fire( var_0, var_1, var_2, var_3 )
{
    var_4 = gettime() + var_2 * 1000;
    level.air_raids = common_scripts\utility::array_randomize( level.air_raids );
    var_5 = 0;

    while ( var_4 > gettime() )
    {
        var_6 = 12;
        var_7 = 0;

        foreach ( var_9 in level.players )
        {
            if ( !maps\mp\_utility::_ID18757( var_9 ) )
                continue;

            if ( level._ID32653 )
            {
                if ( var_9.team == level.air_raid_team_called )
                    continue;
            }
            else if ( isdefined( var_3 ) && var_9 == var_3 )
                continue;

            if ( var_9._ID30916 + 8000 > gettime() )
                continue;

            var_10 = var_9 getvelocity();
            var_11 = randomfloatrange( 3, 4 );
            var_12 = var_9.origin + var_10 * var_11;
            var_13 = getnodesinradiussorted( var_12, 100, 0, 60 );

            foreach ( var_15 in var_13 )
            {
                if ( nodeexposedtosky( var_15 ) )
                {
                    var_16 = common_scripts\utility::_ID25350( level.air_raids );

                    if ( _ID25368( var_16.origin, var_15.origin, undefined, var_3, 1, 1 ) )
                    {
                        wait(randomfloatrange( var_0, var_1 ));
                        var_7++;
                        break;
                    }
                }
            }
        }

        while ( var_7 < var_6 )
        {
            var_16 = level.air_raids[var_5];
            var_5++;

            if ( var_5 >= level.air_raids.size )
                var_5 = 0;

            var_19 = var_16._ID11757[var_16.current_end];
            var_16.current_end++;

            if ( var_16.current_end >= var_16._ID11757.size )
                var_16.current_end = 0;

            var_20 = _ID25379( var_16.origin, var_16.radius );
            var_21 = _ID25379( var_19.origin, var_19.radius );
            thread _ID25368( var_20, var_21, undefined, var_3, 0, 1 );
            wait(randomfloatrange( var_0, var_1 ));
            var_7++;
        }
    }
}

_ID25379( var_0, var_1 )
{
    if ( var_1 > 0 )
    {
        var_2 = anglestoforward( ( 0, randomfloatrange( 0, 360 ), 0 ) );
        var_3 = randomfloatrange( 0, var_1 );
        var_0 += var_2 * var_3;
    }

    return var_0;
}

_ID16507()
{
    level endon( "stop_dynamic_events" );
    var_0 = common_scripts\utility::_ID15386( "heli_anim", "targetname" );

    if ( var_0.size == 0 )
        return;

    var_1 = var_0.size;

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.angles ) )
            var_3.angles = ( 0, 0, 0 );
    }

    for (;;)
    {
        var_1++;

        if ( var_1 >= var_0.size )
        {
            var_0 = common_scripts\utility::array_randomize( var_0 );
            var_1 = 0;
        }

        wait(randomfloatrange( 10, 20 ));

        if ( level._ID2653 )
            continue;

        var_3 = var_0[var_1];

        if ( !isdefined( var_3._ID27443 ) || !isdefined( level._ID16507[var_3._ID27443] ) || !isdefined( level.heli_anims_length[var_3._ID27443] ) )
            continue;

        var_5 = spawn( "script_model", var_3.origin );
        var_5.angles = var_3.angles;
        var_5 setmodel( "vehicle_battle_hind" );
        var_5 playloopsound( "heli_flyover" );
        var_5 scriptmodelplayanimdeltamotion( level._ID16507[var_3._ID27443] );
        wait(level.heli_anims_length[var_3._ID27443]);
        var_5 delete();
    }
}

_ID6829( var_0 )
{
    self endon( "chain_gate_trigger_damage" );
    var_0 waittill( "damage",  var_1, var_2, var_3, var_4, var_5  );
    self notify( "chain_gate_trigger_damage",  var_1, var_2, var_3, var_4, var_5  );
}

chain_gate()
{
    var_0 = getent( "left_gate", "targetname" );
    var_1 = getent( "right_gate", "targetname" );
    var_2 = getent( "lock", "targetname" );
    var_3 = getent( "gate_clip", "targetname" );
    var_4 = getentarray( "gate_trigger", "targetname" );
    var_5 = spawn( "script_model", var_0.origin );
    var_5 setmodel( "generic_prop_raven" );
    var_5.angles = var_0.angles;
    common_scripts\utility::_ID35582();
    var_3 connectpaths();
    common_scripts\utility::_ID35582();
    var_0 linkto( var_5, "j_prop_1" );
    var_1 linkto( var_5, "j_prop_2" );
    common_scripts\utility::_ID35582();
    var_6 = ( 0, 0, 0 );
    var_7 = 0;

    foreach ( var_9 in var_4 )
    {
        maps\mp\_utility::add_to_bot_damage_targets( var_9 );
        var_6 += var_9.origin;
        var_7++;
    }

    var_6 /= var_7;
    level thread bot_outside_gate_watch();
    var_2 scriptmodelplayanim( "mp_frag_metal_door_chain" );
    var_0 setcandamage( 0 );
    var_0 setcanradiusdamage( 0 );
    var_1 setcandamage( 0 );
    var_1 setcanradiusdamage( 0 );
    var_2 setcandamage( 0 );
    var_2 setcanradiusdamage( 0 );

    foreach ( var_9 in var_4 )
        thread _ID6829( var_9 );

    self waittill( "chain_gate_trigger_damage",  var_13, var_14, var_15, var_16, var_17  );
    var_2 playsound( "scn_breach_gate_lock" );

    if ( isexplosivedamagemod( var_17 ) )
        var_15 = var_6 - var_16;

    var_18 = var_15[0] > 0;
    var_2 delete();

    foreach ( var_9 in var_4 )
    {
        maps\mp\_utility::remove_from_bot_damage_targets( var_9 );
        var_9 delete();
    }

    common_scripts\utility::flag_set( "chain_broken" );

    if ( var_18 )
        var_5 scriptmodelplayanimdeltamotion( "mp_warhawk_metal_door_open_in" );
    else
        var_5 scriptmodelplayanimdeltamotion( "mp_warhawk_metal_door_open_out" );

    var_0 playsound( "scn_breach_gate_open_left" );
    var_1 playsound( "scn_breach_gate_open_right" );
    wait 0.5;
    common_scripts\utility::_ID35582();
    var_3 delete();
}

bot_outside_gate_watch()
{
    level endon( "chain_broken" );
    var_0 = getentarray( "gate_trigger", "targetname" );
    var_1 = getent( "near_gate_volume", "targetname" );

    for (;;)
    {
        if ( isdefined( level._ID23303 ) )
        {
            foreach ( var_3 in level._ID23303 )
            {
                if ( isai( var_3 ) && var_3 istouching( var_1 ) )
                    var_0[0] maps\mp\_utility::set_high_priority_target_for_bot( var_3 );
            }
        }

        wait 1.0;
    }
}
