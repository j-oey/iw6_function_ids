// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_skeleton_precache::_ID20445();
    maps\createart\mp_skeleton_art::_ID20445();
    maps\mp\mp_skeleton_fx::_ID20445();
    maps\mp\_load::_ID20445();
    maps\mp\_compass::_ID29184( "compass_map_mp_skeleton" );

    if ( !maps\mp\_utility::_ID18422() )
        setdvar( "r_texFilterProbeBilinear", 1 );

    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 2.5, 6 );
    setdvar( "r_umbraexclusive", 1 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level thread _ID24744();
    level thread _ID37489();
    level._ID38064 = 1000000;
}

_ID37489()
{
    var_0 = getent( "clip128x128x8", "targetname" );
    var_1 = spawn( "script_model", ( -1065.81, -1288.17, 238.002 ) );
    var_1.angles = ( 352.044, 14.1584, 10.0585 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
    var_2 = spawn( "script_model", ( 1393.1, 1093.2, 160 ) );
    var_2 setmodel( "com_plasticcase_green_big_us_dirt" );
    var_2.angles = ( 270, 0.999812, 20 );
    var_3 = spawn( "script_model", ( 1381.76, 1122.11, 160 ) );
    var_3 setmodel( "com_plasticcase_green_big_us_dirt" );
    var_3.angles = ( 270, 2.8, 20 );
    var_4 = spawn( "trigger_radius", ( 4176, 976, -240 ), 0, 750, 375 );
    var_4.radius = 750;
    var_4.height = 375;
    var_4.angles = ( 0, 0, 0 );
    var_4.targetname = "gryphonDeath";
}

_ID24744()
{
    var_0 = getent( "gate", "targetname" );
    var_1 = getent( "gate_d", "targetname" );
    var_2 = common_scripts\utility::_ID15384( var_0.target, "targetname" );
    var_3 = getent( "destroyed_collision", "targetname" );
    var_4 = getent( "intact_collision", "targetname" );
    var_5 = common_scripts\utility::_ID15384( "gate_killcam", "targetname" );
    var_6 = 1.0;
    var_4._ID19214 = spawn( "script_model", var_5.origin );
    var_4._ID19214 setmodel( "tag_origin" );
    var_1 hide();
    var_1 linkto( var_0 );
    var_3 notsolid();
    var_4 notsolid();
    var_4 connectpaths();
    var_4._ID9756 = var_4.origin;
    var_4 moveto( var_0.origin, 0.1, 0.0, 0.0 );
    var_0 setcandamage( 1 );
    var_0 waittill( "damage",  var_7, var_8, var_9, var_10, var_11  );
    var_0 moveto( var_2.origin, var_6, var_6, 0.0 );
    var_4 solid();
    var_4 moveto( var_4._ID9756, var_6, var_6, 0.0 );
    var_4._ID34253 = 1;
    var_4.unresolved_collision_kill = 1;
    var_4.owner = var_8;
    var_0 playsoundonmovingent( "scn_skeleton_portcullis_close" );
    var_4 thread maps\mp\_movers::_ID24268( 0 );
    wait(var_6);
    var_4 disconnectpaths();
    var_4 thread maps\mp\_movers::_ID31810();

    foreach ( var_13 in level.characters )
    {
        if ( var_13 istouching( var_4 ) && isalive( var_13 ) )
        {
            if ( isdefined( var_8 ) && isdefined( var_8.team ) && var_8.team == var_13.team )
            {
                var_13 maps\mp\_movers::mover_suicide();
                continue;
            }

            var_13 dodamage( var_13.health + 20, var_13.origin, var_8, var_4, "MOD_CRUSH" );
        }
    }

    foreach ( var_16 in level._ID25810 )
    {
        if ( var_16 istouching( var_4 ) )
            var_16 notify( "death" );
    }

    earthquake( 0.5, 1.0, var_0.origin, 1000 );
    playfx( common_scripts\utility::_ID15033( "vfx_mp_skeleton_gate_dust" ), var_2.origin + ( 0, 0, 60 ), anglestoforward( var_0.angles + ( 0, 90, 0 ) ), ( 1, 0, 0 ) );

    for (;;)
    {
        var_0 waittill( "damage",  var_7, var_8, var_9, var_10, var_11  );

        if ( var_11 == "MOD_EXPLOSIVE" || var_11 == "MOD_GRENADE_SPLASH" || var_11 == "MOD_PROJECTILE" || var_11 == "MOD_GRENADE" )
        {
            playfx( common_scripts\utility::_ID15033( "vfx_gate_explode" ), var_10, var_9 );
            break;
        }
    }

    var_0 delete();
    var_4 notsolid();
    var_3 solid();
    var_4 connectpaths();
    var_1 show();
    playsoundatpos( var_1.origin, "scn_skeleton_portcullis_exp" );
}
