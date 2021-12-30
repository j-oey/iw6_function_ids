// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_ca_behemoth_precache::_ID20445();
    maps\createart\mp_ca_behemoth_art::_ID20445();
    maps\mp\mp_ca_behemoth_fx::_ID20445();
    level._ID20636 = ::behemothcustomcratefunc;
    level.mapcustomkillstreakfunc = ::behemothcustomkillstreakfunc;
    level._ID20635 = ::behemothcustombotkillstreakfunc;
    maps\mp\_load::_ID20445();
    behemothsetminimap( "compass_map_mp_ca_behemoth" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    setdvar( "bucket", 1 );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 1.4, 10.75 );
    maps\mp\_utility::_ID28710( "r_diffuseColorScale", 1.72, 2.25 );

    if ( level._ID25139 )
    {
        setdvar( "sm_sunShadowScale", "0.55" );
        setdvar( "sm_sunsamplesizenear", ".15" );
    }
    else if ( level._ID36452 )
    {
        setdvar( "sm_sunShadowScale", "0.56" );
        setdvar( "sm_sunsamplesizenear", ".22" );
    }
    else
    {
        setdvar( "sm_sunShadowScale", "0.9" );
        setdvar( "sm_sunsamplesizenear", ".27" );
    }

    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "urban";
    game["axis_outfit"] = "woodland";
    level.steam_burst_active = 0;
    level.steam_stream_points = [];
    level.steam_burst_points = [];
    level.steam_bokeh_points = [];
    thread setup_burstpipes();
    thread setup_extinguishers();
    thread setup_machinery();
    thread setup_rollers();
    thread setup_movers();
    thread setup_bucketwheels();
    thread setup_fans();
    thread setup_tvs();
    thread maps\mp\mp_ca_killstreaks_heligunner::_ID17631();
    thread _ID36620::_ID37998( "alienEasterEgg" );
}

setup_fans()
{
    var_0 = getentarray( "destruct_fan", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::update_fan );
}

rotate_fan()
{
    self endon( "stop_rotate" );

    for (;;)
    {
        self rotateyaw( 360, 0.5 );
        wait 0.25;
    }
}

update_fan()
{
    var_0 = getent( self.target, "targetname" );

    if ( isdefined( var_0 ) )
    {
        var_0 setcandamage( 1 );
        thread rotate_fan();
        var_0 waittill( "damage" );
        playfx( level._ID1644["tv_explode"], self.origin );
        playsoundatpos( self.origin, "tv_shot_burst" );
        self notify( "stop_rotate" );
        var_0 setcandamage( 0 );
        self rotateyaw( randomfloat( 360 ), 1.0, 0, 0.75 );
    }
}

setup_rollers()
{
    var_0 = getentarray( "beh_roller", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::update_roller );
}

update_roller()
{
    var_0 = 6.0;

    for (;;)
    {
        self rotatepitch( 360, var_0 );
        wait(var_0);
    }
}

setup_tvs()
{
    var_0 = getentarray( "beh_destruct_tv", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::update_tv );
}

update_tv()
{
    var_0 = "monitors_0" + randomintrange( 1, 5 );

    if ( isdefined( level._ID1644[var_0] ) )
    {
        var_1 = anglestoright( self.angles ) * 0.125;
        var_2 = self.origin + var_1;
        var_3 = anglestoright( self.angles );
        var_4 = var_2 + ( 0, 0, -1 );
        var_5 = playloopedfx( level._ID1644[var_0], 0.5, var_4, 1000, var_3 );
        self setcandamage( 1 );
        self waittill( "damage" );
        playfx( level._ID1644["tv_explode"], self.origin );
        playsoundatpos( self.origin, "tv_shot_burst" );
        var_5 delete();
        self setcandamage( 0 );
    }
}

behemothsetminimap( var_0 )
{
    var_1 = getentarray( "minimap_corner", "targetname" );

    if ( var_1.size != 2 )
        return;

    var_2 = ( var_1[0].origin[0], var_1[0].origin[1], 0 );
    var_3 = ( var_1[1].origin[0], var_1[1].origin[1], 0 );
    var_4 = var_2 + 0.5 * ( var_3 - var_2 );
    var_5 = getnorthyaw();
    var_6 = abs( sin( var_5 ) ) + abs( cos( var_5 ) );
    var_2 = var_4 + var_6 * ( var_2 - var_4 );
    var_3 = var_4 + var_6 * ( var_3 - var_4 );
    level._ID20638 = max( abs( var_2[1] - var_3[1] ), abs( var_2[0] - var_3[0] ) );
    var_2 = rotatepoint2d( var_2, var_4, var_5 * -1 );
    var_3 = rotatepoint2d( var_3, var_4, var_5 * -1 );
    var_7 = ( cos( var_5 ), sin( var_5 ), 0 );
    var_8 = ( 0 - var_7[1], var_7[0], 0 );
    var_9 = vectornormalize( var_3 - var_2 );

    if ( vectordot( var_9, var_8 ) > 0 )
    {
        if ( vectordot( var_9, var_7 ) > 0 )
        {
            var_10 = var_3;
            var_11 = var_2;
        }
        else
        {
            var_10 = var_3 + vectordot( var_7, var_2 - var_3 ) * var_7;
            var_11 = 2 * var_4 - var_10;
        }
    }
    else if ( vectordot( var_9, var_7 ) > 0 )
    {
        var_10 = var_2 + vectordot( var_7, var_3 - var_2 ) * var_7;
        var_11 = 2 * var_4 - var_10;
    }
    else
    {
        var_10 = var_2;
        var_11 = var_3;
    }

    setminimap( var_0, var_10[0], var_10[1], var_11[0], var_11[1] );
}

_ID34932( var_0, var_1 )
{
    return ( var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1 );
}

rotatepoint2d( var_0, var_1, var_2 )
{
    var_3 = ( var_0[0] - var_1[0], var_0[1] - var_1[1], var_0[2] );
    var_3 = rotatepointaroundvector( ( 0, 0, 1 ), var_3, var_2 );
    return ( var_3[0] + var_1[0], var_3[1] + var_1[1], var_3[2] );
}

behemothcustomcratefunc()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    if ( !maps\mp\_utility::allowlevelkillstreaks() || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "heli_gunner", 80, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"MP_CA_KILLSTREAKS_HELI_GUNNER_PICKUP" );
    maps\mp\killstreaks\_airdrop::generatemaxweightedcratevalue();
    level thread watch_for_behemoth_crate();
}

behemothcustomkillstreakfunc()
{
    level._ID19256["heli_gunner"] = ::tryusebehemothkillstreak;
}

behemothcustombotkillstreakfunc()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "heli_gunner", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

watch_for_behemoth_crate()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "heli_gunner" )
        {
            maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "heli_gunner", 0 );
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "heli_gunner", 80 );
                continue;
            }

            game["player_holding_level_killstrek"] = 1;
            break;
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

tryusebehemothkillstreak( var_0, var_1 )
{
    return maps\mp\mp_ca_killstreaks_heligunner::tryuseheligunner( var_0, var_1 );
}

setup_bucketwheels()
{
    var_0 = getentarray( "bucket_wheel", "targetname" );

    if ( var_0.size )
        common_scripts\utility::_ID3867( var_0, ::update_bucketwheel );
}

update_bucketwheel()
{
    for (;;)
    {
        self rotatepitch( 360, 20.0 );
        wait 20.0;
    }
}

setup_burstpipes()
{
    var_0 = common_scripts\utility::_ID15386( "burstpipe", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::setup_pipe );
}

loop_pipe_fx( var_0, var_1 )
{
    var_2 = ( 90, 0, 0 );
    var_3 = randomfloatrange( 7.5, 8.0 );
    var_4 = playloopedfx( level._ID1644["vfx_pipe_steam_ring"], var_3, var_0, 0.0, var_2 );
    var_1 playloopsound( "mtl_steam_pipe_hiss_loop" );
    self waittill( "end_fx" );
    var_1 playsound( "mtl_steam_pipe_hiss_loop_end" );
    wait 0.25;
    var_1 stoploopsound( "mtl_steam_pipe_hiss_loop" );
    var_4 delete();
}

update_pipe_fx( var_0 )
{
    wait(randomfloat( 0.25 ));

    while ( self._ID35585 )
    {
        var_0 thread loop_pipe_fx( var_0.origin, self._ID30494 );
        level waittill( "pipe_burst_cutoff" );
        var_0 notify( "end_fx" );
        level waittill( "pipe_burst_restart" );
    }
}

play_effects_at_loc_array( var_0, var_1, var_2 )
{
    var_3 = ( 0, 0, 0 );

    foreach ( var_5 in var_0 )
    {
        if ( var_2 )
            var_3 = ( randomfloat( 180.0 ), randomfloat( 180.0 ), randomfloat( 180.0 ) );

        playfx( var_1, var_5, var_3 );
    }
}

setup_pipe()
{
    var_0 = common_scripts\utility::_ID15386( self.target, "targetname" );
    level.steam_burst_points[level.steam_burst_points.size] = self.origin;
    level.steam_bokeh_points[level.steam_bokeh_points.size] = self.origin + ( 0, 0, 30 );

    foreach ( var_2 in var_0 )
        level.steam_stream_points[level.steam_stream_points.size] = var_2.origin;

    update_pipe();
}

bokeh_timer( var_0 )
{
    var_1 = spawnfx( level._ID1644["scrnfx_water_bokeh_dots_cam_16"], var_0 );
    triggerfx( var_1 );
    wait 10.0;
    var_1 delete();
}

play_bokeh()
{
    foreach ( var_1 in level.steam_bokeh_points )
        thread bokeh_timer( var_1 );
}

update_pipe()
{
    self._ID35585 = 1;
    var_0 = common_scripts\utility::_ID15386( self.target, "targetname" );
    var_1 = getentarray( self.target, "targetname" );

    if ( var_1.size )
    {
        self._ID30494 = var_1[0];
        common_scripts\utility::_ID3867( var_1, ::burstpipe_damage_watcher, self );

        foreach ( var_3 in var_0 )
            thread update_pipe_fx( var_3 );

        self waittill( "burstpipe_damage" );
        self._ID30494 playsound( "mtl_steam_pipe_hit" );
        level notify( "pipe_burst_cutoff" );
        thread play_effects_at_loc_array( level.steam_stream_points, level._ID1644["vfx_pipe_steam_stream"], 1 );
        wait 0.5;
        thread play_bokeh();
        thread play_effects_at_loc_array( level.steam_burst_points, level._ID1644["vfx_pipe_steam_burst"], 1 );
        level.steam_burst_active = 1;
        self._ID30494 playloopsound( "mtl_steam_pipe_hiss_loop" );
        wait 9.75;
        self._ID30494 playsound( "mtl_steam_pipe_hiss_loop_end" );
        wait 0.25;
        var_1[0] stoploopsound( "mtl_steam_pipe_hiss_loop" );
        level.steam_burst_active = 0;
        level notify( "pipe_burst_restart" );
        self._ID35585 = 0;
        wait 120.0;

        while ( level.steam_burst_active )
            wait 0.5;

        update_pipe();
    }
}

burstpipe_damage_watcher( var_0 )
{
    self setcandamage( 1 );

    while ( var_0._ID35585 )
    {
        self waittill( "damage",  var_1, var_2, var_3, var_4, var_5  );

        if ( !level.steam_burst_active )
            var_0 notify( "burstpipe_damage",  var_3, var_4  );
    }

    self setcandamage( 0 );
}

setup_extinguishers()
{
    var_0 = getentarray( "extinguisher", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::update_extinguisher );
}

update_extinguisher()
{
    self setcandamage( 1 );
    var_0 = 0;

    while ( !var_0 )
    {
        self waittill( "damage",  var_1, var_2, var_3, var_4, var_5  );

        if ( issubstr( var_5, "MELEE" ) || issubstr( var_5, "BULLET" ) )
        {
            self setcandamage( 0 );
            playfx( level._ID1644["vfx_fire_extinguisher"], var_4, rotatevector( var_3, ( 0, 180, 0 ) ) );
            playsoundatpos( self.origin, "extinguisher_break" );
            var_0 = 1;
            continue;
        }

        self setcandamage( 0 );
        playfx( level._ID1644["vfx_fire_extinguisher"], self.origin, anglestoup( self.angles ) );
        playsoundatpos( self.origin, "extinguisher_break" );
    }
}

_ID37779( var_0, var_1, var_2 )
{
    var_3 = spawnfx( var_0, var_1, anglestoforward( var_2 ), anglestoup( var_2 ) );
    triggerfx( var_3 );
    wait 5.0;
    var_3 delete();
}

setup_machinery()
{
    var_0 = getentarray( "machinery", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::update_machine );
}
#using_animtree("mp_ca_behemoth");

update_machine()
{
    var_0 = 10.0;
    var_1 = "";
    var_2 = 1;

    if ( isdefined( self.script_noteworthy ) )
    {
        if ( self.script_noteworthy == "center" )
        {
            var_0 = getanimlength( %mp_ca_beh_center_machine_idle );
            var_1 = "mp_ca_beh_center_machine_idle";
        }
        else if ( self.script_noteworthy == "left" )
        {
            var_0 = getanimlength( %mp_ca_beh_engine_a_idle );
            var_1 = "mp_ca_beh_engine_a_idle";
        }
        else if ( self.script_noteworthy == "right" )
        {
            var_0 = getanimlength( %mp_ca_beh_engine_b_idle );
            var_1 = "mp_ca_beh_engine_b_idle";
        }

        if ( var_0 )
        {
            while ( var_2 )
            {
                self scriptmodelplayanim( var_1 );
                wait(var_0);
            }
        }
    }
}

setup_movers()
{
    var_0 = getentarray( "mover", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::update_mover );
}

setup_mover_nodes()
{
    var_0 = common_scripts\utility::_ID15384( self.target, "targetname" );

    if ( isdefined( var_0 ) )
    {
        self.angles = vectortoangles( self.origin - var_0.origin );
        var_1 = 1;

        while ( var_0 != self && var_1 )
        {
            var_2 = var_0;
            var_0 = common_scripts\utility::_ID15384( var_2.target, "targetname" );

            if ( isdefined( var_0 ) )
            {
                var_0.angles = vectortoangles( var_0.origin - var_2.origin );
                continue;
            }

            var_1 = 0;
        }
    }
}

update_mover()
{
    var_0 = common_scripts\utility::_ID15384( self.target, "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    var_0 setup_mover_nodes();
    self.origin = var_0.origin;
    self.angles = var_0.angles;
    self._ID11491 = 1;
    var_1 = 140.0;
    var_2 = 0.0;
    var_3 = 0.0;

    if ( isdefined( var_0._ID27417 ) )
        var_3 = var_0._ID27417;

    for ( var_0 = common_scripts\utility::_ID15384( var_0.target, "targetname" ); isdefined( var_0 ); var_0 = common_scripts\utility::_ID15384( var_0.target, "targetname" ) )
    {
        var_2 = 0.0;

        if ( isdefined( var_0._ID27516 ) )
            var_2 = var_0._ID27516;

        var_4 = var_1;

        if ( isdefined( var_0.script_physics ) )
            var_4 *= var_0.script_physics;

        var_5 = distance( self.origin, var_0.origin ) / var_4;
        var_5 = max( var_5, var_2 + var_3 );
        self moveto( var_0.origin, var_5, var_3, var_2 );
        self rotateto( var_0.angles, var_5, var_3, var_2 );
        var_6 = var_0.angles[1];
        wait(var_5 - var_3 + var_2);

        if ( isdefined( var_0.script_node_pausetime ) )
            wait(var_0.script_node_pausetime);

        var_3 = 0.0;

        if ( isdefined( var_0._ID27417 ) )
            var_3 = var_0._ID27417;
    }
}
