// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

bridge_main()
{
    _ID36913();
    common_scripts\utility::_ID35582();

    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
        return;

    level._ID36892 = spawnstruct();
    level._ID36892 maps\mp\mp_ca_red_river_bridge_device::_ID36894();
    maps\mp\mp_ca_red_river_bridge_device::_ID36910( level._ID36892 );
    level._ID6093 = spawnstruct();
    level._ID6093 bridge_init();
    level._ID6093 thread _ID36916();
}

_ID36913()
{
    precachempanim( "mp_ca_red_river_bridge_01" );
    precachempanim( "mp_ca_red_river_bridge_02" );
    precachempanim( "mp_ca_red_river_bridge_03" );
}
#using_animtree("animated_props");

bridge_init()
{
    self._ID36889 = 0.0;
    self._ID36889 = max( self._ID36889, getanimlength( %mp_ca_red_river_bridge_01 ) );
    self._ID36889 = max( self._ID36889, getanimlength( %mp_ca_red_river_bridge_02 ) );
    self._ID36889 = max( self._ID36889, getanimlength( %mp_ca_red_river_bridge_03 ) );
    self._ID36917 = getentarray( "bridge_whole", "targetname" );
    self._ID36891 = getentarray( "bridge_destroyed", "targetname" );
    _ID36911( self._ID36891 );
    level._ID36890 = getentarray( "bridge_animated_model", "targetname" );
    _ID36911( level._ID36890 );
    level._ID36914 = getscriptablearray( "bridge_animated_model", "targetname" );

    foreach ( var_1 in level._ID36914 )
        var_1 hide();

    level._ID36918 = getent( "bridgePathNodes", "targetname" );
    clearpath( level._ID36918 );
    level._ID37102 = getent( "destroyPathNodes", "targetname" );
    blockpath( level._ID37102 );
}

_ID36915( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        var_2 show();
        var_2 solid();
    }
}

_ID36911( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        var_2 hide();
        var_2 notsolid();
        var_2 maps\mp\_movers::notify_moving_platform_invalid();
    }
}

_ID36916()
{
    level waittill( "bridge_trigger_explode" );
    level._ID36892 notify( "bridge_exploded" );
    maps\mp\_utility::_ID24645( "scn_bridge_explo_2d" );
    thread common_scripts\utility::_ID23839( "scn_bridge_explo_boom_left", ( -484, -733, 90 ) );
    thread common_scripts\utility::_ID23839( "scn_bridge_explo_boom_right", ( 143, -824, 60 ) );
    _ID36912();
    wait 0.15;

    if ( isdefined( self._ID36891 ) )
        _ID36915( self._ID36891 );

    if ( isdefined( self._ID36917 ) )
        _ID36911( self._ID36917 );

    clearpath( level._ID37102 );
    blockpath( level._ID36918 );

    foreach ( var_1 in level._ID36890 )
    {
        var_1 show();
        var_1 solid();

        if ( isdefined( var_1._ID3571 ) )
            var_1 scriptmodelplayanim( var_1._ID3571 );
    }

    foreach ( var_4 in level._ID36914 )
    {
        var_4 show();
        var_4 setscriptablepartstate( 0, "destroyed" );
    }

    wait(self._ID36889);
}

_ID36912()
{
    common_scripts\utility::exploder( 11 );
    common_scripts\utility::exploder( 12 );
    playloopsoundatpos( ( -941.022, -712.704, -133.546 ), "emt_red_fire_explo_med1_lp" );
    playloopsoundatpos( ( -389.143, -886.295, -174.497 ), "emt_red_fire_explo_med2_lp" );
    playloopsoundatpos( ( -283.364, -531.226, 73.5775 ), "emt_red_fire_explo_med3_lp" );
    playloopsoundatpos( ( 103.789, -379.687, 116.523 ), "emt_red_fire_explo_lrg_pole_lp" );
    playloopsoundatpos( ( 244.235, -335.982, 33.3856 ), "emt_red_fire_explo_lrg_pole_lp" );
    playloopsoundatpos( ( -371.551, -1141.23, 27.313 ), "emt_red_fire_explo_sm_lp" );
    level thread bridge_fx_waitforconnections();
}

playloopsoundatpos( var_0, var_1 )
{
    common_scripts\utility::_ID23798( var_1, var_0 );
}

bridge_fx_waitforconnections()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 childthread bridge_fx_playonconnection();
    }
}

bridge_fx_playonconnection()
{
    self endon( "disconnect" );
    common_scripts\utility::_ID35626( "joined_team", "luinotifyserver" );
    common_scripts\utility::exploder( 11, self, 0 );

    if ( isdefined( level.nukedetonated ) )
    {
        self visionsetnakedforplayer( "", 0 );
        maps\mp\killstreaks\_nuke::_ID37971( 0 );
    }
    else
        self visionsetnakedforplayer( "mp_ca_red_river_exploded", 0 );
}

clearpath( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        var_0 connectpaths();
        var_0 hide();
        var_0 notsolid();
    }
}

blockpath( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        var_0 show();
        var_0 solid();
        var_0 disconnectpaths();
    }
}
