// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool
#using_animtree("animated_props_mp_descent");

_ID20445()
{
    maps\mp\mp_descent_new_precache::_ID20445();
    maps\createart\mp_descent_new_art::_ID20445();
    maps\mp\mp_descent_new_fx::_ID20445();
    maps\mp\_load::_ID20445();
    maps\mp\_compass::_ID29184( "compass_map_mp_descent_new" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 2.5, 2.5 );

    if ( level._ID25139 )
    {
        setdvar( "sm_sunShadowScale", "0.5" );
        setdvar( "sm_sunsamplesizenear", ".15" );
    }
    else if ( level._ID36452 )
    {
        setdvar( "sm_sunShadowScale", "0.8" );
        setdvar( "sm_sunsamplesizenear", ".25" );
    }

    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "urban";
    game["axis_outfit"] = "elite";
    level thread _ID36211();
    var_0 = getanimlength( %mp_descent_light01_fall );
    animatescriptableprops( "animated_model_descent_light01", var_0 );
    var_0 = getanimlength( %mp_descent_light02_fall );
    animatescriptableprops( "animated_model_descent_light02", var_0 );
    var_0 = getanimlength( %mp_descent_light03_fall );
    animatescriptableprops( "animated_model_descent_light03", var_0 );
    var_0 = getanimlength( %mp_descent_light04_fall );
    animatescriptableprops( "animated_model_descent_light04", var_0 );
    var_0 = getanimlength( %mp_descent_phone01_fall );
    animatescriptableprops( "animated_model_descent_phone01", var_0 );
    var_0 = getanimlength( %mp_descent_phone02_fall );
    animatescriptableprops( "animated_model_descent_phone02", var_0 );
    var_0 = getanimlength( %mp_descent_microwave_fall );
    animatescriptableprops( "animated_model_descent_microwave", var_0 );
    var_0 = getanimlength( %mp_descent_tv01_fall );
    animatescriptableprops( "animated_model_descent_tv01", var_0 );
    var_0 = getanimlength( %mp_descent_whiteboard_fall );
    animatescriptableprops( "animated_model_descent_whiteboard", var_0 );
    animatescriptableprops( "animated_model_descent_bulletinboard", var_0 );
    var_0 = getanimlength( %mp_descent_kitchen_fall );
    animatescriptableprops( "animated_model_descent_kitchen", var_0 );
    level setupbuildingcollapse();
    level thread connect_watch();
    thread setupcollapsingcolumn( "column" );
    thread setupsniperduct( "sniper_mover" );
}

connect_watch()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        thread connect_watch_endofframe( var_0 );
    }
}

connect_watch_endofframe( var_0 )
{
    var_0 endon( "death" );
    waittillframeend;

    if ( isdefined( level._ID35343 ) )
    {
        var_0 playersetgroundreferenceent( level._ID35343 );
        return;
    }
}

spawn_watch()
{
    for (;;)
    {
        level waittill( "player_spawned",  var_0  );

        if ( isdefined( level._ID35343 ) )
            var_0 playersetgroundreferenceent( level._ID35343 );
    }
}

anglesclamp180( var_0 )
{
    return ( angleclamp180( var_0[0] ), angleclamp180( var_0[1] ), angleclamp180( var_0[2] ) );
}

world_tilt()
{
    level endon( "game_ended" );
    var_0 = getentarray( "world_tilt_damage", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::world_tilt_damage_watch );
    var_1 = getentarray( "vista", "targetname" );

    if ( !var_1.size )
        return;

    level._ID35343 = var_1[0];

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3.script_noteworthy ) && var_3.script_noteworthy == "main" )
        {
            level._ID35343 = var_3;
            break;
        }
    }

    level.vista_rotation_origins = [];
    var_5 = common_scripts\utility::_ID15386( "rotation_point", "targetname" );

    foreach ( var_7 in var_5 )
    {
        if ( !isdefined( var_7.script_noteworthy ) )
            continue;

        var_7.angles = ( 0, 0, 0 );
        level.vista_rotation_origins[var_7.script_noteworthy] = var_7;
    }

    foreach ( var_3 in var_1 )
    {
        if ( var_3 != level._ID35343 )
        {
            if ( isdefined( var_3.classname ) && issubstr( var_3.classname, "trigger" ) )
                var_3 enablelinkto();

            var_3 linkto( level._ID35343 );
        }

        if ( !isdefined( var_3.target ) )
            continue;

        var_10 = getentarray( var_3.target, "targetname" );

        foreach ( var_12 in var_10 )
        {
            if ( !isdefined( var_12.script_noteworthy ) )
                var_12.script_noteworthy = "link";

            switch ( var_12.script_noteworthy )
            {
                case "link":
                    var_12 linkto( var_3 );
                    continue;
                default:
                    continue;
            }
        }
    }

    while ( !isdefined( level.players ) )
        common_scripts\utility::_ID35582();

    foreach ( var_16 in level.players )
        var_16 playersetgroundreferenceent( level._ID35343 );

    level.max_world_pitch = 8;
    level.max_world_roll = 8;
    var_18 = level.max_world_pitch;
    var_19 = level.max_world_roll;
    var_20 = 6500;
    var_21 = 2;
    var_22 = 0.5;
    var_23 = [ 0, 0, 1, 0 ];
    var_24 = spawnstruct();
    var_24.origin = level._ID35343.origin;
    var_24.angles = level._ID35343.angles;
    var_25 = [];

    for (;;)
    {
        var_26 = ( 0, 0, 0 );

        if ( var_22 < randomfloat( 1 ) )
            var_26 = ( randomfloatrange( -1 * var_18, var_18 ), 0, randomfloatrange( -1 * var_19, var_19 ) );

        var_27 = ( 0, 0, randomfloatrange( 200, 1000 ) );
        var_28 = 1;

        if ( var_21 > 0 )
        {
            var_28 = ( var_25.size + 1 ) / var_21;
            var_28 = clamp( var_28, 0, 1.0 );
        }

        var_26 *= var_28;
        var_27 *= var_28;
        var_29 = var_24 world_tilt_get_trans( var_27, var_26 );

        if ( var_29["origin"][2] > level._ID35343.origin[2] + var_20 )
            break;

        var_29["time"] = randomfloatrange( 1, 2 ) * var_28;
        var_24.origin = var_29["origin"];
        var_24.angles = var_29["angles"];
        var_25[var_25.size] = var_29;
    }

    var_30 = var_25.size;
    var_31 = level._ID35343.origin[2] + var_20 - var_25[var_25.size - 1]["origin"][2];

    if ( var_31 > 0 )
    {
        var_32 = array_zero_to_one( var_25.size, 0.5 );

        for ( var_33 = 0; var_33 < var_25.size; var_33++ )
            var_25[var_33]["origin"] += ( 0, 0, var_32[var_33] * var_31 );
    }

    var_34 = array_zero_to_one( var_30, 0.5 );

    for ( var_33 = 0; var_33 < var_34.size - 1; var_33++ )
    {
        var_35 = var_33;
        var_36 = var_33;
        var_37 = randomfloatrange( 0, 1 );
        var_38 = int( min( var_23.size - 1, var_34.size - var_33 ) );

        for ( var_39 = var_38; var_39 >= 2; var_39-- )
        {
            if ( var_23[var_39] > var_37 )
            {
                var_36 = var_35 + var_39 - 1;
                break;
            }
        }

        var_40 = var_36 - var_35;

        if ( var_40 > 0 )
        {
            var_41 = var_34[var_36] - var_34[var_35];
            var_41 *= randomfloatrange( 0.2, 0.8 );
            var_42 = var_34[var_35] + var_41;

            for ( var_39 = var_35; var_39 <= var_36; var_39++ )
                var_34[var_39] = var_42;

            var_33 += var_40;
        }
    }

    for ( var_33 = 0; var_33 < var_25.size; var_33++ )
    {
        level.tilt_active = 0;
        tilt_wait( var_34[var_33] );
        level.tilt_active = 1;
        var_29 = var_25[var_33];
        var_43 = var_29["time"];
        var_29 = var_25[var_33];
        level._ID35343 world_tilt_move( var_29 );
        earthquake( 0.35, 2, level._ID35343.origin, 100000 );
    }
}

world_tilt_damage_watch()
{
    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4  );

        if ( level.tilt_active )
            continue;

        if ( !isdefined( var_0 ) || var_0 < 150 )
            continue;

        if ( !isdefined( var_4 ) || var_4 != "MOD_PROJECTILE" )
            continue;

        thread world_tilt_damage( var_0 );
    }
}

world_tilt_damage( var_0 )
{
    var_1 = 100;
    var_2 = 1000;
    var_3 = clamp( ( var_0 - var_1 ) / ( var_2 - var_1 ), 0.1, 1 );
    var_4 = randomfloatrange( 2, 3 ) * var_3;

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "east" )
        var_4 *= -1.0;

    var_5 = level._ID35343.angles[0] + var_4;
    var_5 = clamp( var_5, -1 * level.max_world_pitch, level.max_world_pitch );
    var_6 = ( var_5, level._ID35343.angles[1], level._ID35343.angles[2] );
    var_7 = 0.2;
    level._ID35343 rotateto( var_6, var_7 );
    earthquake( 0.2, 1, level._ID35343.origin, 100000 );
    wait(var_7);
}

_ID35496( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = var_0;

    maps\mp\_utility::gameflagwait( "prematch_done" );

    if ( !isdefined( level._ID31480 ) )
        return;

    var_2 = maps\mp\_utility::getscorelimit();
    var_3 = maps\mp\_utility::_ID15434() * 60;
    var_4 = 0;
    var_5 = 0;

    if ( var_2 <= 0 && var_3 <= 0 )
    {
        var_4 = 1;
        var_3 = 600;
    }
    else if ( var_2 <= 0 )
        var_4 = 1;
    else if ( var_3 <= 0 )
        var_5 = 1;

    var_6 = var_0 * var_3;
    var_7 = var_1 * var_2;
    var_8 = _ID14496();
    var_9 = ( gettime() - level._ID31480 ) / 1000;

    if ( var_4 )
    {
        while ( var_9 < var_6 )
        {
            wait 0.5;
            var_9 = ( gettime() - level._ID31480 ) / 1000;
        }

        return;
    }

    if ( var_5 )
    {
        while ( var_8 < var_7 )
        {
            wait 0.5;
            var_8 = _ID14496();
        }

        return;
    }

    while ( var_9 < var_6 && var_8 < var_7 )
    {
        wait 0.5;
        var_8 = _ID14496();
        var_9 = ( gettime() - level._ID31480 ) / 1000;
    }

    return;
    return;
}

_ID14496()
{
    var_0 = 0;

    if ( level._ID32653 )
    {
        if ( isdefined( game["teamScores"] ) )
        {
            var_0 = game["teamScores"]["allies"];

            if ( game["teamScores"]["axis"] > var_0 )
                var_0 = game["teamScores"]["axis"];
        }
    }
    else if ( isdefined( level.players ) )
    {
        foreach ( var_2 in level.players )
        {
            if ( isdefined( var_2.score ) && var_2.score > var_0 )
                var_0 = var_2.score;
        }
    }

    return var_0;
}

world_tilt_get_trans( var_0, var_1 )
{
    var_2 = anglesclamp180( var_1 - self.angles );
    var_3 = level.vista_rotation_origins["south"];

    if ( var_2[2] < 0 )
        var_3 = level.vista_rotation_origins["north"];

    var_3.angles = self.angles;
    var_4 = spawnstruct();
    var_4.origin = var_3.origin + var_0;
    var_4.angles = var_1;
    var_5 = transformmove( var_4.origin, var_4.angles, var_3.origin, var_3.angles, self.origin, self.angles );
    return var_5;
}

world_tilt_move( var_0 )
{
    common_scripts\utility::exploder( 1 );
    level thread tilt_sounds();
    var_1 = var_0["time"];

    if ( var_0["origin"] != self.origin )
        self moveto( var_0["origin"], var_1, var_1 );

    if ( anglesclamp180( var_0["angles"] ) != anglesclamp180( self.angles ) )
        self rotateto( var_0["angles"], var_1 );

    earthquake( randomfloatrange( 0.3, 0.5 ), var_1, self.origin, 100000 );
    wait(var_1);
}

array_zero_to_one_rand( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    var_4 = [];
    var_5 = 0;

    for ( var_6 = 0; var_6 < var_0; var_6++ )
    {
        var_4[var_6] = randomfloatrange( var_1, var_2 );
        var_5 += var_4[var_6];
    }

    if ( isdefined( var_3 ) )
    {
        for ( var_6 = 0; var_6 < var_0; var_6++ )
        {
            if ( var_5 != 0 )
            {
                var_4[var_6] /= var_5;
                var_4[var_6] *= var_3;
                continue;
            }

            var_4[var_6] = var_3 / var_0;
        }
    }

    return var_4;
}

array_zero_to_one( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    var_3 = [];
    var_4 = 1 / var_0 * 0.5;
    var_5 = 0;

    for ( var_6 = 0; var_6 < var_0; var_6++ )
    {
        var_3[var_6] = var_6 / var_0 + var_4;

        if ( var_1 > 0 )
            var_3[var_6] += randomfloatrange( -1 * var_4 * var_1, var_4 * var_1 );

        var_5 += var_3[var_6];
    }

    if ( isdefined( var_2 ) )
    {
        for ( var_6 = 0; var_6 < var_0; var_6++ )
        {
            var_3[var_6] /= var_5;
            var_3[var_6] *= var_2;
        }
    }

    return var_3;
}

tilt_wait( var_0 )
{
    level endon( "tilt_start" );
    _ID35496( var_0 );
    level notify( "tilt_start" );
}

tilt_sounds()
{
    var_0 = common_scripts\utility::_ID15386( "tilt_sound", "targetname" );

    foreach ( var_2 in var_0 )
        playsoundatpos( var_2.origin, "cobra_helicopter_crash" );
}

_ID36211()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "using_remote" );
    self endon( "stopped_using_remote" );
    self endon( "disconnect" );
    self endon( "above_water" );
    var_0 = getent( "watersheet", "targetname" );

    for (;;)
    {
        var_0 waittill( "trigger",  var_1  );

        if ( !isdefined( var_1.istouchingwatersheettrigger ) || var_1.istouchingwatersheettrigger == 0 )
            thread watersheet_playfx( var_1 );
    }
}

watersheet_playfx( var_0 )
{
    var_0.istouchingwatersheettrigger = 1;
    var_0 setwatersheeting( 1, 2 );
    wait(randomfloatrange( 0.15, 0.75 ));
    var_0 setwatersheeting( 0 );
    var_0.istouchingwatersheettrigger = 0;
}

_ID36210( var_0 )
{
    var_0 endon( "death" );
    thread watersheet_sound_play( var_0 );

    for (;;)
    {
        var_0 waittill( "trigger",  var_1  );
        var_0.sound_end_time = gettime() + 100;
        var_0 notify( "start_sound" );
    }
}

watersheet_sound_play( var_0 )
{
    var_0 endon( "death" );

    for (;;)
    {
        var_0 waittill( "start_sound" );
        var_0 playloopsound( "scn_jungle_under_falls_plr" );

        while ( var_0.sound_end_time > gettime() )
            wait(( var_0.sound_end_time - gettime() ) / 1000);

        var_0 stoploopsound();
    }
}

animatescriptableprops( var_0, var_1 )
{
    var_2 = getscriptablearray( var_0, "targetname" );

    foreach ( var_4 in var_2 )
        var_4 thread animateonescriptableprop( var_1 );
}

animateonescriptableprop( var_0 )
{
    for (;;)
    {
        self setscriptablepartstate( 0, "idle" );
        level waittill( "shake_props" );
        var_1 = randomintrange( 0, 7 ) * 0.05;
        wait(var_1);
        self setscriptablepartstate( 0, "fall" );
        wait(var_0);
    }
}

doubledoorcreate( var_0 )
{
    var_1 = getent( var_0, "targetname" );

    if ( isdefined( var_1 ) )
    {
        var_1.collision = getent( var_0 + "_clip", "targetname" );
        var_1.ruins = [];
        var_1.ruins[0] = getruin( var_0 + "_upper" );
        var_1.ruins[1] = getruin( var_0 + "_lower" );
        var_1.destroyfxpoint = common_scripts\utility::_ID15384( var_1.ruins[0].target, "targetname" );
        common_scripts\utility::_ID35582();
        var_1 blockpath();
        var_1 thread doubledoorwaitfordamage();
        return;
    }
}

doubledoorwaitfordamage()
{
    self.health = 9999;
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4  );

        if ( isexplosivedamagemod( var_4 ) && var_0 > 50 )
            thread doubledoordestroy( var_1, var_2, var_3 );
    }
}

doubledoordestroy( var_0, var_1, var_2 )
{
    self.collision clearpath();
    clearpath();
    var_3 = anglestoforward( self.destroyfxpoint.angles );
    var_4 = vectordot( var_3, var_1 );
    var_5 = var_4 > 0;
    var_6 = 85;
    thread maps\mp\_utility::_ID10878( self.destroyfxpoint.origin, self.destroyfxpoint.origin + 20 * var_3, 50, ( 1, 0, 0 ) );

    if ( !var_5 )
        var_3 *= -1;
    else
        var_6 *= -1;

    playfx( common_scripts\utility::_ID15033( "equipment_explode_big" ), self.destroyfxpoint.origin, var_3 );

    foreach ( var_8 in self.ruins )
    {
        var_8 show();
        var_8 thread doorapplyimpulse( var_6 );
        var_6 *= -1;
    }
}

getruin( var_0 )
{
    var_1 = getent( var_0, "targetname" );
    var_1 hide();
    return var_1;
}

trapdoorcreate( var_0 )
{
    var_1 = getent( var_0, "targetname" );

    if ( isdefined( var_1 ) )
    {
        self._ID23338 = getent( var_1.target, "targetname" );
        common_scripts\utility::_ID35582();
        self._ID23338 blockpath();
        var_1 thread trapdoorwaitfordamage();
        return;
    }
}

trapdoorwaitfordamage()
{
    self.health = 9999;
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4  );
        thread trapdoordestroy( var_1, var_2, var_3 );
    }
}

trapdoordestroy( var_0, var_1, var_2 )
{
    self._ID23338 notsolid();
    self._ID23338 clearpath();
    var_3 = 90.0;
    thread doorapplyimpulse( var_3 );
}

doorapplyimpulse( var_0 )
{
    self rotateby( ( var_0, 0, 0 ), 0.125, 0.125, 0 );
}

clearpath()
{
    self connectpaths();
    self hide();
    self notsolid();
}

blockpath()
{
    self solid();
    self show();
    self disconnectpaths();
}

levitateprops( var_0, var_1 )
{
    var_2 = getdvarint( "phys_gravity", -800 );
    setdvar( "phys_gravity", 0 );
    physicsjitter( level._ID20634, 2500, 0, 5.0, 5.0 );
    var_3 = randomfloatrange( var_0, var_1 );
    wait(var_3);
    setdvar( "phys_gravity", var_2 );
}

movercreate( var_0, var_1 )
{
    var_2 = getent( var_0, "targetname" );
    var_2.collision = getent( var_0 + "_collision", "targetname" );

    if ( isdefined( var_2.collision ) )
    {
        var_2.collision linkto( var_2 );
        var_2.collision thread moverexplosivetrigger( var_1 );
    }

    var_2._ID34249 = maps\mp\_movers::_ID34255;
    var_3 = var_2;
    var_3._ID19112 = [];
    var_4 = var_3.target;
    var_5 = 0;

    while ( isdefined( var_4 ) )
    {
        var_6 = common_scripts\utility::_ID15384( var_4, "targetname" );

        if ( isdefined( var_6 ) )
        {
            var_3._ID19112[var_5] = var_6;

            if ( !isdefined( var_6._ID27550 ) )
                var_6._ID27550 = 1.0;

            if ( !isdefined( var_6._ID27417 ) )
                var_6._ID27417 = 0.0;

            if ( !isdefined( var_6._ID27516 ) )
                var_6._ID27516 = 0.0;

            var_5++;
            var_4 = var_6.target;
            continue;
        }

        break;
    }

    var_2 thread _ID21655( var_1 );
}

moverexplosivetrigger( var_0 )
{
    level endon( "game_ended" );

    if ( !isdefined( var_0 ) )
        var_0 = "explosive_damage";

    self setcandamage( 1 );

    for (;;)
    {
        self.health = 1000000;
        self waittill( "damage",  var_1, var_2, var_3, var_4, var_5  );

        if ( isexplosivedamagemod( var_5 ) )
            level notify( var_0,  self  );
    }
}

_ID21655( var_0 )
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( var_0,  var_1  );

        if ( !isdefined( var_1 ) || var_1 == self )
            break;
    }

    for ( var_2 = 1; var_2 < self._ID19112.size; var_2++ )
    {
        var_3 = self._ID19112[var_2];
        self moveto( var_3.origin, var_3._ID27550, var_3._ID27417, var_3._ID27516 );
        self rotateto( var_3.angles, var_3._ID27550, var_3._ID27417, var_3._ID27516 );

        if ( isdefined( var_3.shakemag ) )
            earthquake( var_3.shakemag, var_3._ID29652, self.origin, var_3._ID29651 );

        self waittill( "movedone" );
    }

    var_4 = self.origin + ( 0, 0, 2000 );
    earthquake( 0.25, 0.5, var_4, 3000 );
}

animatedmovercreate( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = getent( var_0, "targetname" );

    if ( isdefined( var_6 ) )
    {
        level waittill( "trigger_movers" );

        if ( isdefined( var_2 ) )
            var_6 playsound( var_2 );

        var_6 scriptmodelplayanim( var_1 );

        if ( isdefined( var_3 ) )
        {
            wait(var_4);
            playsoundatpos( var_5, var_3 );
            return;
        }

        return;
    }
}

setupcollapsingcolumn( var_0 )
{
    var_1 = getent( var_0, "targetname" );

    if ( isdefined( var_1 ) )
    {
        var_2 = getent( var_0 + "_debris_clip", "targetname" );
        var_2 notsolid();
        var_3 = randomintrange( 1, level.dropnodes.size );
        var_4 = "buildingCollapseEnd_" + var_3;
        level common_scripts\utility::_ID35626( var_4, "trigger_movers" );
        var_1 playsound( "scn_dest_collapse_fall" );
        var_1 scriptmodelplayanim( "mp_descent_column_collapsing" );
        var_5 = var_2.origin + ( 0, 0, 10 );
        wait 3.5;
        playsoundatpos( var_5, "scn_dest_collapse_impact" );
        common_scripts\utility::exploder( 23 );
        earthquake( 0.3, 0.25, var_5, 500 );
        radiusdamage( var_5, 192, 500, 500, undefined, "MOD_CRUSH" );
        var_2 solid();
        return;
    }
}

setupsniperduct( var_0 )
{
    var_1 = getent( var_0, "targetname" );

    if ( isdefined( var_1 ) )
    {
        var_2 = common_scripts\utility::_ID15384( var_0 + "_origin", "targetname" );
        var_3 = spawn( "script_model", var_2.origin );
        var_1 linkto( var_3 );
        var_4 = getent( var_1.target, "targetname" );
        var_4 linkto( var_3 );
        var_5 = randomintrange( 1, level.dropnodes.size );
        var_6 = "buildingCollapseEnd_" + var_5;
        level common_scripts\utility::_ID35626( var_6, "trigger_movers" );
        var_3 rotatepitch( -99.0, 1, 0.85, 0.15 );
        wait 1;
        var_7 = 0.5;
        var_8 = var_7 * 1;
        var_3 rotatepitch( 13.5, var_8, 0.5 * var_8, 0.5 * var_8 );
        wait(var_8);
        var_3 rotatepitch( -4.5, var_8, 0.5 * var_8, 0.5 * var_8 );
        wait(var_8);
        return;
    }
}

setupbuildingcollapse()
{
    level.soundsources = [];
    var_0 = common_scripts\utility::_ID15386( "tilt_sound", "targetname" );

    if ( isdefined( var_0 ) )
    {
        foreach ( var_2 in var_0 )
            level.soundsources[var_2._ID27658] = var_2;
    }

    level.collapsesettings = [];
    var_4 = [];
    var_4["prefalltime"] = 1.5;
    var_4["falltime"] = 3.0;
    var_4["sfx"] = [];
    var_4["sfx"]["rubble_left"] = "scn_bldg_fall1_rubble_left";
    var_4["sfx"]["rubble_right"] = "scn_bldg_fall1_rubble_right";
    var_4["sfx"]["glass_left"] = "scn_bldg_fall1_glass_left";
    var_4["sfx"]["glass_right"] = "scn_bldg_fall1_glass_right";
    level.collapsesettings[level.collapsesettings.size] = var_4;
    var_4 = [];
    var_4["prefalltime"] = 1.5;
    var_4["falltime"] = 3.0;
    var_4["sfx"] = [];
    var_4["sfx"]["rubble_left"] = "scn_bldg_fall2_rubble_left";
    var_4["sfx"]["rubble_right"] = "scn_bldg_fall2_rubble_right";
    var_4["sfx"]["glass_left"] = "scn_bldg_fall2_glass_left";
    var_4["sfx"]["glass_right"] = "scn_bldg_fall2_glass_right";
    level.collapsesettings[level.collapsesettings.size] = var_4;
    var_4 = [];
    var_4["prefalltime"] = 1.5;
    var_4["falltime"] = 3.0;
    var_4["sfx"] = [];
    var_4["sfx"]["rubble_left"] = "scn_bldg_fall3_rubble_left";
    var_4["sfx"]["rubble_right"] = "scn_bldg_fall3_rubble_right";
    var_4["sfx"]["glass_left"] = "scn_bldg_fall3_glass_left";
    var_4["sfx"]["glass_right"] = "scn_bldg_fall3_glass_right";
    level.collapsesettings[level.collapsesettings.size] = var_4;
    var_4 = [];
    var_4["prefalltime"] = 1.5;
    var_4["falltime"] = 3.0;
    var_4["sfx"] = [];
    var_4["sfx"]["rubble_left"] = "scn_bldg_fall4_rubble_left";
    var_4["sfx"]["rubble_right"] = "scn_bldg_fall4_rubble_right";
    var_4["sfx"]["glass_left"] = "scn_bldg_fall4_glass_left";
    var_4["sfx"]["glass_right"] = "scn_bldg_fall4_glass_right";
    level.collapsesettings[level.collapsesettings.size] = var_4;
    var_4 = [];
    var_4["prefalltime"] = 0.5;
    var_4["falltime"] = 3.0;
    var_4["sfx"] = [];
    var_4["sfx"]["rubble_left"] = "scn_bldg_fall5_rubble_left";
    var_4["sfx"]["rubble_right"] = "scn_bldg_fall5_rubble_right";
    var_4["sfx"]["glass_left"] = "scn_bldg_fall5_glass_left";
    var_4["sfx"]["glass_right"] = "scn_bldg_fall5_glass_right";
    level.collapsesettings[level.collapsesettings.size] = var_4;
    level._ID35343 = getent( "vista_test", "targetname" );
    var_5 = [];
    var_5[0] = 550;
    var_5[1] = 400;
    var_5[2] = 350;
    level.dropnodes = [];
    var_6 = common_scripts\utility::_ID15384( "drop_node2", "targetname" );
    var_7 = 3;
    var_8 = 6;
    var_9 = level._ID35343.origin[2];
    var_10 = 0;

    while ( isdefined( var_6 ) )
    {
        var_6.angles = ( randomfloatrange( -1 * var_7, var_7 ), 0, randomfloatrange( -1 * var_8, var_8 ) );
        var_6.origin = var_6.origin - ( 0, 0, var_5[var_10] );
        var_10++;
        level.dropnodes[level.dropnodes.size] = var_6;

        if ( isdefined( var_6.target ) )
        {
            var_6 = common_scripts\utility::_ID15384( var_6.target, "targetname" );
            continue;
        }

        break;
    }

    level thread dropnodewait();
    level thread setupdropeventtrigger();
    level.facadeconcrete = [];

    for ( var_10 = 0; var_10 < level.dropnodes.size; var_10++ )
    {
        var_11 = "concrete_building" + var_10;
        var_12 = getent( var_11, "targetname" );
        var_12 linkto( level._ID35343 );
        level.facadeconcrete[var_10] = var_12;
    }

    level.facadeglass = [];
    level.ruinglass = [];

    for ( var_10 = 0; var_10 < level.dropnodes.size; var_10++ )
    {
        var_11 = "facade_glass_" + var_10;
        var_13 = getentarray( var_11, "targetname" );
        var_13 = common_scripts\utility::_ID3855( var_13, ::compareheight );
        level.facadeglass[var_10] = var_13;

        foreach ( var_15 in var_13 )
            var_15 linkto( level._ID35343 );

        var_17 = "facade_glass_ruin_" + var_10;
        var_18 = getent( var_17, "targetname" );

        if ( isdefined( var_18 ) )
        {
            var_18 linkto( level._ID35343 );
            var_18 hide();
            level.ruinglass[var_10] = var_18;
        }
    }
}

compareheight( var_0, var_1 )
{
    return var_0.origin[2] > var_1.origin[2];
}

dropnodewait()
{
    for ( level.dropstage = 0; level.dropstage < level.dropnodes.size; level.dropstage++ )
    {
        level waittill( "buildingCollapse" );
        dobuildingfall( level.dropstage );
    }
}

dobuildingfall( var_0 )
{
    level.buildingisfalling = 1;
    var_1 = level.dropnodes[var_0];
    var_2 = level.collapsesettings[var_0];
    var_3 = var_2["prefalltime"];
    var_4 = var_2["falltime"];

    foreach ( var_7, var_6 in level.soundsources )
        playsoundatpos( var_6.origin, var_2["sfx"][var_7] );

    earthquake( randomfloatrange( 0.1, 0.2 ), var_3, level._ID20634, 5000 );
    var_8 = randomfloatrange( 4, 6 );

    if ( randomfloat( 1 ) < 0.5 )
        var_8 *= -1;

    var_9 = randomfloatrange( 2, 3 );

    if ( randomfloat( 1 ) < 0.5 )
        var_9 *= -1;

    var_10 = ( var_9, 0, var_8 );
    level._ID35343 rotateto( 0.75 * var_10, var_3, 1.0 * var_3, 0.0 );
    level thread destroyairkillstreaks();
    wait(var_3);
    level.disablevanguardsinair = 1;
    common_scripts\utility::exploder( 3 );
    playrumble( "damage_light" );
    earthquake( randomfloatrange( 0.3, 0.45 ), var_4, level._ID20634, 5000 );
    level thread animateconcretebuildingfacade( var_0, var_4 );
    level thread animateglassbuildingfacade( var_0, var_4 );
    level._ID35343 moveto( var_1.origin, var_4, 0.25 * var_4, 0.0 );
    level._ID35343 rotateto( -1 * var_10, var_4, 0.25 * var_4, 0.0 );
    level notify( "shake_props" );
    level notify( "buildingCollapseStart_" + var_0 );
    wait(var_4);
    earthquake( randomfloatrange( 0.8, 1.0 ), 1.5, level._ID20634, 5000 );
    common_scripts\utility::exploder( 1 );
    common_scripts\utility::exploder( 3 );
    level notify( "buildingCollapseEnd_" + var_0 );
    level.disablevanguardsinair = undefined;
    playrumble( "artillery_rumble" );
    wait 0.5;
    var_11 = 1.5;
    var_12 = ( -0.25 * var_9, 0, 0.25 * var_8 );
    level._ID35343 rotateto( var_12, var_11, 0.8 * var_11, 0.2 * var_11 );
    wait(0.75 * var_11);
    earthquake( randomfloatrange( 0.3, 0.5 ), 0.25 * var_11 + 1.0, level._ID20634, 5000 );
    playrumble( "damage_light" );
    level.buildingisfalling = undefined;
}

animateconcretebuildingfacade( var_0, var_1 )
{
    var_2 = level.facadeconcrete[var_0];

    if ( isdefined( var_2 ) )
    {
        var_3 = var_2.model;
        var_2 setmodel( "desc_building_destroyed_02" );
        var_4 = spawn( "script_model", var_2.origin );
        var_4.angles = var_2.angles;
        var_4 setmodel( var_3 );
        var_5 = anglestoup( var_4.angles );
        var_6 = var_4.origin - 150 * var_5;
        var_4 moveto( var_6, var_1, var_1, 0 );
        var_4 rotateroll( 20, var_1, var_1, 0 );
        wait(var_1);
        var_4 delete();
        return;
    }
}

animateglassbuildingfacade( var_0, var_1 )
{
    if ( isdefined( level.facadeglass[var_0] ) )
    {
        var_2 = var_1 / level.facadeglass[var_0].size;
        level.ruinglass[var_0] show();

        foreach ( var_4 in level.facadeglass[var_0] )
        {
            var_4 thread glassfacadefall( var_1 );
            wait(var_2);
        }

        return;
    }
}

glassfacadefall( var_0 )
{
    self unlink();
    var_1 = anglestoup( self.angles );
    var_2 = self.origin - 400 * var_1;
    self moveto( var_2, var_0, var_0, 0 );
    self rotateroll( -60, var_0, var_0, 0 );
    wait(var_0);
    self delete();
}

setupdropeventtrigger()
{
    var_0 = level.dropnodes.size + 1;

    if ( level._ID14086 == "sr" || level._ID14086 == "sd" )
    {
        level thread searchandrescueeventtriggerdrop();
        return;
    }

    var_1 = maps\mp\_utility::getwatcheddvar( "scorelimit" );

    if ( level._ID32653 && var_1 >= level.dropnodes.size * 20 )
    {
        level thread scorelimittriggerdrop( var_1, level.dropnodes.size );
        return;
    }

    var_2 = maps\mp\_utility::getwatcheddvar( "timelimit" );

    if ( var_2 <= 0 )
        var_2 = 10;

    var_2 *= 60;
    level thread timelimittriggerdrop( var_2, var_0 );
    return;
    return;
}

searchandrescueeventtriggerdrop()
{
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = level common_scripts\utility::_ID35635( "last_alive", "bomb_exploded", "bomb_dropped" );

        if ( var_0 == "last_alive" || !level.bombplanted )
        {
            var_1 = randomfloatrange( 3, 6 );
            wait(var_1);
        }
        else if ( var_0 != "bomb_exploded" )
            continue;

        level notify( "buildingCollapse" );
    }
}

scorelimittriggerdrop( var_0, var_1 )
{
    level endon( "game_ended" );
    level thread periodictremor( 90, 120 );
    var_2 = int( 0.3 * var_0 );
    var_3 = 1;

    for (;;)
    {
        level waittill( "update_team_score",  var_4, var_5  );

        if ( var_5 >= var_3 * var_2 )
        {
            var_6 = randomfloatrange( 3, 6 );
            wait(var_6);
            level notify( "buildingCollapse" );
            var_3++;
        }
    }
}

timelimittriggerdrop( var_0, var_1 )
{
    level endon( "game_ended" );
    var_2 = var_0 / var_1;
    level thread periodictremor( 0.8 * var_2, 1.2 * var_2 );

    while ( level.dropstage < level.dropnodes.size )
    {
        wait(var_2);
        level notify( "buildingCollapse" );
    }
}

periodictremor( var_0, var_1 )
{
    level endon( "game_ended" );
    var_2 = 0.5 * randomfloatrange( var_0, var_1 );
    wait(var_2);

    for (;;)
    {
        if ( !isdefined( level.buildingisfalling ) )
        {
            playsoundatpos( level._ID20634, "scn_bldg_tremor_lr" );
            var_4 = randomfloatrange( 0.2, 0.3 );
            var_5 = randomfloatrange( 1.0, 1.5 );
            earthquake( var_4, var_5, level._ID20634, 5000 );
        }

        var_2 = randomfloatrange( var_0, var_1 );
        wait(var_2);
    }
}

setupbuildingfx()
{
    var_0 = getent( "column_chunk", "targetname" );
    playfxontag( common_scripts\utility::_ID15033( "vfx_building_debris_runner" ), var_0, "tag_03_vfx_building_debris_runner" );
    playfxontag( common_scripts\utility::_ID15033( "vfx_spark_drip_dec_runner" ), var_0, "tag_02_vfx_spark_drip_dec_runner" );
    playfxontag( common_scripts\utility::_ID15033( "vfx_building_hole_elec_short_runner" ), var_0, "tag_01_vfx_building_hole_elec_short_runner" );
}

destroyairkillstreaks()
{
    destroyairkillstreaksforteam( undefined, "allies" );
    destroyairkillstreaksforteam( undefined, "axis" );
}

destroyairkillstreaksforteam( var_0, var_1 )
{
    maps\mp\killstreaks\_killstreaks::destroytargetarray( var_0, var_1, "aamissile_projectile_mp", level.heli_pilot );

    if ( isdefined( level._ID19723 ) )
    {
        var_2 = [];
        var_2[0] = level._ID19723;
        maps\mp\killstreaks\_killstreaks::destroytargetarray( var_0, var_1, "aamissile_projectile_mp", var_2 );
        return;
    }
}

playrumble( var_0 )
{
    foreach ( var_2 in level.players )
        var_2 playrumbleonentity( var_0 );
}
