// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_ca_red_river_precache::_ID20445();
    maps\createart\mp_ca_red_river_art::_ID20445();
    maps\mp\mp_ca_red_river_fx::_ID20445();
    maps\mp\_breach::_ID20445();
    level thread maps\mp\_movers::_ID20445();
    level thread maps\mp\_movable_cover::_ID17631();
    level._ID20636 = ::_ID37861;
    level.mapcustomkillstreakfunc = ::_ID37862;
    level._ID20635 = ::_ID37860;
    maps\mp\_load::_ID20445();
    maps\mp\_compass::_ID29184( "compass_map_mp_ca_red_river" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    setdvar( "r_reactiveMotionWindAmplitudeScale", 3 );
    setdvar( "r_reactiveMotionWindFrequencyScale", 0.33 );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 2.5, 9 );
    maps\mp\_utility::_ID28710( "r_diffuseColorScale", 1.25, 1.5 );

    if ( level._ID25139 )
        setdvar( "sm_sunShadowScale", "0.4" );
    else if ( level._ID36452 )
        setdvar( "sm_sunShadowScale", "0.4" );
    else
        setdvar( "sm_sunShadowScale", "0.9" );

    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "urban";
    game["axis_outfit"] = "desert";
    precachempanim( "rr_gate_open_out" );
    precachempanim( "rr_gate_open_in" );
    precachempanim( "mp_frag_metal_door_chain" );
    common_scripts\utility::_ID13189( "chain_broken" );
    thread _ID37992();
    thread maps\mp\mp_ca_red_river_bridge_event::bridge_main();
    thread chain_gate();
    thread _ID37856();
    thread _ID36620::_ID37998( "alienEasterEgg" );
}

_ID37856()
{
    wait 0.5;
    var_0 = common_scripts\utility::_ID15386( "breach", "targetname" );
    var_1 = common_scripts\utility::_ID15386( "breach_proxy", "targetname" );

    foreach ( var_3 in var_0 )
    {
        var_4 = getnodearray( var_3.target, "targetname" );

        foreach ( var_6 in var_4 )
            var_6 disconnectnode();
    }

    foreach ( var_6 in var_1 )
    {
        if ( !isdefined( var_6.target ) )
            continue;

        var_3 = common_scripts\utility::_ID15384( var_6.target, "targetname" );

        if ( !isdefined( var_3 ) )
            continue;

        var_0[var_0.size] = var_3;
    }

    common_scripts\utility::_ID3867( var_0, ::_ID37857 );
}

_ID37857()
{
    self waittill( "breach_activated" );
    var_0 = 0.5;
    var_1 = 0.5;
    var_2 = 600;

    if ( isdefined( self._ID27542 ) )
        var_0 = self._ID27542;

    if ( isdefined( self._ID27906 ) )
        var_1 = self._ID27906;

    if ( isdefined( self.radius ) )
        var_2 = self.radius;

    earthquake( var_0, var_1, self.origin, var_2 );
    var_3 = getnodearray( self.target, "targetname" );

    foreach ( var_5 in var_3 )
        var_5 connectnode();
}

_ID37861()
{
    level thread maps\mp\mp_ca_red_river_bridge_device::_ID37861();
}

_ID37862()
{
    level._ID19256["warhawk_mortars"] = ::_ID38172;
    level._ID19276["warhawk_mortar_mp"] = "warhawk_mortars";
}

_ID37860()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "warhawk_mortars", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

_ID38172( var_0, var_1 )
{
    level notify( "bridge_device_activate",  self  );
    return 1;
}

_ID37992()
{
    var_0 = getentarray( "pinata", "targetname" );

    if ( var_0.size > 0 )
    {
        foreach ( var_2 in var_0 )
            var_2 thread _ID38218( level._ID1644["mp_ca_red_river_pinata_boom"] );
    }

    var_4 = getentarray( "pinata_large", "targetname" );

    if ( var_4.size > 0 )
    {
        foreach ( var_2 in var_4 )
            var_2 thread _ID38218( level._ID1644["mp_ca_red_river_pinata_boom_lg"] );
    }
}

_ID38218( var_0 )
{
    self show();
    self setcandamage( 1 );
    var_1 = undefined;
    var_2 = randomintrange( 2, 4 );

    while ( var_2 > 0 )
    {
        self waittill( "damage",  var_3, var_4, var_5, var_6, var_7  );
        var_2--;
        var_1 = var_5;
        thread _ID37782( level._ID1644["mp_ca_red_river_pinata"], var_6, var_5 );

        if ( issubstr( var_7, "MELEE" ) || issubstr( var_7, "GRENADE" ) )
        {
            var_2 = 0;
            continue;
        }

        if ( issubstr( var_7, "BULLET" ) )
        {
            if ( var_3 > 60.0 )
            {
                var_2 = 0;
                continue;
            }

            if ( isdefined( var_4 ) && isdefined( var_4 getcurrentweapon() ) && weaponclass( var_4 getcurrentweapon() ) == "sniper" )
                var_2 = 0;
        }
    }

    if ( !isdefined( var_1 ) )
        self waittill( "damage",  var_3, var_4, var_5, var_6, var_7  );
    else
        var_5 = var_1;

    self hide();
    self setcandamage( 0 );
    thread _ID37782( var_0, self getorigin(), var_5 );
}

_ID37782( var_0, var_1, var_2 )
{
    var_3 = spawnfx( var_0, var_1, anglestoforward( var_2 ), anglestoup( var_2 ) );
    triggerfx( var_3 );
    wait 5.0;
    var_3 delete();
}

_ID6829( var_0 )
{
    level endon( "chain_gate_trigger_damage" );
    var_0 waittill( "damage",  var_1, var_2, var_3, var_4, var_5  );
    level notify( "chain_gate_trigger_damage",  var_1, var_2, var_3, var_4, var_5  );
}

chain_gate()
{
    var_0 = getent( "left_gate", "targetname" );
    var_1 = getent( "lock", "targetname" );
    var_2 = getent( "gate_clip", "targetname" );
    var_3 = getentarray( "gate_trigger", "targetname" );
    var_4 = spawn( "script_model", var_0.origin );
    var_4 setmodel( "generic_prop_raven" );
    var_4.angles = var_0.angles;
    common_scripts\utility::_ID35582();
    var_2 disconnectpaths();
    common_scripts\utility::_ID35582();
    common_scripts\utility::_ID35582();
    var_5 = ( 0, 0, 0 );
    var_6 = 0;

    foreach ( var_8 in var_3 )
    {
        maps\mp\_utility::add_to_bot_damage_targets( var_8 );
        var_5 += var_8.origin;
        var_6++;
    }

    var_5 /= var_6;
    level thread bot_outside_gate_watch();
    var_1 scriptmodelplayanim( "mp_frag_metal_door_chain" );
    var_0 setcandamage( 0 );
    var_0 setcanradiusdamage( 0 );
    var_1 setcandamage( 0 );
    var_1 setcanradiusdamage( 0 );

    foreach ( var_8 in var_3 )
        thread _ID6829( var_8 );

    self waittill( "chain_gate_trigger_damage",  var_12, var_13, var_14, var_15, var_16  );
    var_1 playsound( "scn_breach_gate_lock" );

    if ( isexplosivedamagemod( var_16 ) )
        var_14 = var_5 - var_15;

    var_17 = var_14[1] < 0;
    var_1 delete();

    foreach ( var_8 in var_3 )
    {
        maps\mp\_utility::remove_from_bot_damage_targets( var_8 );
        var_8 delete();
    }

    common_scripts\utility::flag_set( "chain_broken" );

    if ( var_17 )
    {
        var_0 scriptmodelplayanim( "rr_gate_open_in" );
        var_2 rotateyaw( 130.0, 0.66 );
    }
    else
    {
        var_0 scriptmodelplayanim( "rr_gate_open_out" );
        var_2 rotateyaw( -130.0, 0.66 );
    }

    var_0 playsound( "scn_breach_gate_open_left" );
    wait 0.5;
    var_2 connectpaths();
    common_scripts\utility::_ID35582();
    var_2 delete();
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
