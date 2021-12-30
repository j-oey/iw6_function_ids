// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_ca_impact_precache::_ID20445();
    maps\createart\mp_ca_impact_art::_ID20445();
    maps\mp\mp_ca_impact_fx::_ID20445();
    maps\mp\_breach::_ID20445();
    common_scripts\_pipes::_ID20445();
    thread maps\mp\mp_ca_killstreaks_a10::_ID17631( "impact" );
    level._ID20636 = ::impactcustomcratefunc;
    level.mapcustomkillstreakfunc = ::impactcustomkillstreakfunc;
    level._ID20635 = ::impactcustombotkillstreakfunc;
    maps\mp\_load::_ID20445();
    maps\mp\_compass::_ID29184( "compass_map_mp_ca_impact" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );

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
    thread impact_breach_init();
    thread setup_extinguishers();
    thread _ID37995();
    thread setup_phys_hits();
    level._pipes._pipe_fx_time["steam"] = 10;
    thread _ID36620::_ID37998( "alienEasterEgg" );
    thread _ID36211();
}

_ID36211()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "using_remote" );
    self endon( "stopped_using_remote" );
    self endon( "disconnect" );
    self endon( "above_water" );
    var_0 = getentarray( "watersheet", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread watertriggerwaiter();
}

watertriggerwaiter()
{
    for (;;)
    {
        self waittill( "trigger",  var_0  );

        if ( isai( var_0 ) )
            continue;

        if ( !isplayer( var_0 ) )
            continue;

        if ( !isdefined( var_0.istouchingwatersheettrigger ) || var_0.istouchingwatersheettrigger == 0 )
            thread watersheet_playfx( var_0 );
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

impactcustomcratefunc()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    if ( !maps\mp\_utility::allowlevelkillstreaks() || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "ca_a10_strafe", 80, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"MP_CA_KILLSTREAKS_A10_STRAFE_PICKUP" );
    maps\mp\killstreaks\_airdrop::generatemaxweightedcratevalue();
    level thread watch_for_impact_crate();
}

impactcustomkillstreakfunc()
{
    level._ID19256["ca_a10_strafe"] = ::tryuseimpactkillstreak;
}

impactcustombotkillstreakfunc()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "ca_a10_strafe", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

watch_for_impact_crate()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "ca_a10_strafe" )
        {
            maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "ca_a10_strafe", 0 );
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "ca_a10_strafe", 80 );
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

tryuseimpactkillstreak( var_0, var_1 )
{
    return maps\mp\mp_ca_killstreaks_a10::_ID22916( var_0, var_1 );
}

impact_breach_init()
{
    wait 0.5;
    var_0 = common_scripts\utility::_ID15386( "breach", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = getnodearray( var_2.target, "targetname" );

        foreach ( var_5 in var_3 )
            var_5 disconnectnode();
    }

    var_8 = common_scripts\utility::_ID15386( "breach_proxy", "targetname" );

    foreach ( var_5 in var_8 )
    {
        if ( !isdefined( var_5.target ) )
            continue;

        var_2 = common_scripts\utility::_ID15384( var_5.target, "targetname" );

        if ( !isdefined( var_2 ) )
            continue;

        var_0[var_0.size] = var_2;
    }

    common_scripts\utility::_ID3867( var_0, ::impact_breach_update );
}

impact_breach_update()
{
    if ( !( level._ID14086 == "gun" ) && !( level._ID14086 == "sotf_ffa" ) && !( level._ID14086 == "horde" ) && !( level._ID14086 == "sotf" ) && !( level._ID14086 == "infect" ) )
    {
        self waittill( "breach_activated" );
        var_0 = 0.5;
        var_1 = 0.5;
        var_2 = 200;

        if ( isdefined( self._ID27542 ) )
            var_0 = self._ID27542;

        if ( isdefined( self._ID27906 ) )
            var_1 = self._ID27906;

        if ( isdefined( self.radius ) )
            var_2 = self.radius;

        earthquake( var_0, var_1, self.origin, var_2 );
    }

    var_3 = getnodearray( self.target, "targetname" );

    foreach ( var_5 in var_3 )
        var_5 connectnode();
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

_ID37995()
{
    level._ID38143 = 600;
    level._ID38144 = 1200;
    level._ID37731 = -1.0;
    var_0 = getentarray( "watertank", "targetname" );

    if ( var_0.size > 0 )
    {
        for ( var_1 = 0; var_1 < var_0.size; var_1++ )
            var_0[var_1] thread _ID38224( var_1 );
    }
}

_ID38224( var_0 )
{
    self setcandamage( 1 );
    self._ID38142 = 0;
    var_1 = 20.0;
    var_2 = self.origin[2] + var_1;
    var_3 = spawn( "script_origin", ( self.origin[0], self.origin[1], self.origin[2] + var_1 ) );
    var_4 = self.origin[2] + var_1;
    var_5 = 2.0;
    var_6 = 4.0;
    var_7 = 1.0;
    var_8 = 2.0;

    while ( self._ID38142 < 1200.0 )
    {
        self waittill( "damage",  var_9, var_10, var_11, var_12, var_13  );
        self._ID38142 = self._ID38142 + var_9;

        if ( !issubstr( var_13, "BULLET" ) )
            continue;

        if ( !_ID36938() )
            continue;

        var_2 = var_3.origin[2] + var_1;

        if ( var_12[2] >= var_2 )
            continue;

        var_14 = _ID37343( var_10, var_11, var_12 );

        if ( !isdefined( var_14 ) )
            continue;

        var_15 = min( var_6 * var_5, var_2 - self.origin[2] );
        var_16 = max( self.origin[2], max( var_12[2], var_2 - var_15 ) );
        var_17 = var_16 - var_2;
        var_18 = abs( var_17 ) / var_5;
        var_18 = max( var_18, var_7 + var_8 );
        thread _ID38070( level._ID1644["vfx_watertank_bullet_hit"], var_10, var_14, var_12, var_18, var_3, var_1 );

        if ( var_16 >= var_4 )
            continue;

        var_4 = var_16;
        var_3 movez( var_17, var_18, var_7, var_8 );
    }
}

_ID38070( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = spawnfx( var_0, var_3, var_2 );
    triggerfx( var_7 );
    var_8 = gettime() + var_4 * 1000.0;
    var_7 _ID37699( var_5, var_8, var_6 );
    var_7 stopsounds();
    wait 0.05;
    var_7 delete();
}

_ID37699( var_0, var_1, var_2 )
{
    var_0 endon( "tank_destroyed" );

    while ( gettime() < var_1 )
    {
        if ( self.origin[2] >= var_0.origin[2] + var_2 - 1.0 )
            break;

        wait 0.05;
    }
}

_ID38226()
{
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4  );

        if ( !issubstr( var_4, "BULLET" ) )
            continue;

        var_5 = _ID37343( var_1, var_2, var_3 );

        if ( !isdefined( var_5 ) )
            continue;

        var_5 = vectortoangles( var_5 );
        playfx( level._ID1644["vfx_watertank_bullet_hit"], var_3, anglestoforward( var_5 ), anglestoup( var_5 ) );
    }
}

_ID37343( var_0, var_1, var_2 )
{
    var_3 = var_0.origin;
    var_4 = var_2 - var_3;
    var_5 = bullettrace( var_3, var_3 + 1.5 * var_4, 0, var_0, 0 );

    if ( isdefined( var_5["normal"] ) && isdefined( var_5["entity"] ) && var_5["entity"] == self )
        return var_5["normal"];

    return undefined;
}

_ID36938()
{
    if ( gettime() < level._ID37731 )
        return 0;

    return 1;
}

_ID36705()
{
    level._ID37731 = gettime() + randomfloatrange( level._ID38143, level._ID38144 );
}

setup_phys_hits()
{
    var_0 = getentarray( "shootable_hanger", "targetname" );

    if ( var_0.size )
        common_scripts\utility::_ID3867( var_0, ::update_phys_hits );
}

update_phys_hits()
{
    self setcandamage( 1 );
    self waittill( "damage",  var_0, var_1, var_2, var_3, var_4  );
    self hide();
    playfx( level._ID1644["vfx_" + self.model], self.origin, self.angles );
    self delete();
}
