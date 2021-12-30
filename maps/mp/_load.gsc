// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    if ( isdefined( level._loadstarted ) )
        return;

    level._loadstarted = 1;
    level._ID8425 = getdvar( "createfx" ) != "";
    common_scripts\utility::_ID31993();
    maps\mp\_utility::initgameflags();
    maps\mp\_utility::initlevelflags();
    maps\mp\_utility::initglobals();
    level.generic_index = 0;
    level._ID13197 = spawnstruct();
    level._ID13197 common_scripts\utility::assign_unique_id();

    if ( !isdefined( level._ID13177 ) )
    {
        level._ID13177 = [];
        level._ID13223 = [];
    }

    level._ID26063 = getdvarfloat( "scr_RequiredMapAspectratio", 1 );
    level.createclientfontstring_func = maps\mp\gametypes\_hud_util::createfontstring;
    level.hudsetpoint_func = maps\mp\gametypes\_hud_util::_ID28836;
    level._ID19766 = maps\mp\_utility::_ID19765;
    thread maps\mp\gametypes\_tweakables::_ID17631();

    if ( !isdefined( level.func ) )
        level.func = [];

    level.func["precacheMpAnim"] = ::precachempanim;
    level.func["scriptModelPlayAnim"] = ::scriptmodelplayanim;
    level.func["scriptModelClearAnim"] = ::scriptmodelclearanim;

    if ( !level._ID8425 )
    {
        thread maps\mp\_minefields::_ID21073();
        thread maps\mp\_radiation::_ID25267();
        thread maps\mp\_shutter::_ID20445();
        thread maps\mp\_movers::_ID17631();
        thread maps\mp\_destructables::_ID17631();
        thread common_scripts\_elevator::_ID17631();
        thread common_scripts\_dynamic_world::_ID17631();
        thread common_scripts\_destructible::_ID17631();
        level notify( "interactive_start" );
    }

    game["thermal_vision"] = "thermal_mp";
    visionsetnaked( "", 0 );
    visionsetnight( "default_night_mp" );
    visionsetmissilecam( "missilecam" );
    visionsetthermal( game["thermal_vision"] );
    visionsetpain( "", 0 );
    var_0 = getentarray( "lantern_glowFX_origin", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        var_0[var_1] thread lanterns();

    maps\mp\_audio::init_audio();
    maps\mp\_art::_ID20445();
    _ID29176();
    thread common_scripts\_fx::_ID17935();

    if ( level._ID8425 )
    {
        maps\mp\gametypes\_spawnlogic::setmapcenterfordev();
        maps\mp\_createfx::_ID8418();
    }

    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
    {
        maps\mp\gametypes\_spawnlogic::setmapcenterfordev();
        maps\mp\_global_fx::_ID20445();
        level waittill( "eternity" );
    }

    thread maps\mp\_global_fx::_ID20445();

    for ( var_2 = 0; var_2 < 6; var_2++ )
    {
        switch ( var_2 )
        {
            case 0:
                var_3 = "trigger_multiple";
                break;
            case 1:
                var_3 = "trigger_once";
                break;
            case 2:
                var_3 = "trigger_use";
                break;
            case 3:
                var_3 = "trigger_radius";
                break;
            case 4:
                var_3 = "trigger_lookat";
                break;
            default:
                var_3 = "trigger_damage";
                break;
        }

        var_4 = getentarray( var_3, "classname" );

        for ( var_1 = 0; var_1 < var_4.size; var_1++ )
        {
            if ( isdefined( var_4[var_1]._ID27779 ) )
                var_4[var_1]._ID27562 = var_4[var_1]._ID27779;

            if ( isdefined( var_4[var_1]._ID27562 ) )
                level thread _ID12476( var_4[var_1] );
        }
    }

    thread maps\mp\_animatedmodels::_ID20445();
    level.func["damagefeedback"] = maps\mp\gametypes\_damagefeedback::_ID34528;
    level.func["setTeamHeadIcon"] = maps\mp\_entityheadicons::_ID28896;
    level.laseron_func = ::laseron;
    level._ID19422 = ::laseroff;
    level._ID7872 = ::connectpaths;
    level._ID10188 = ::disconnectpaths;
    setdvar( "sm_sunShadowScale", 1 );
    setdvar( "sm_spotLightScoreModelScale", 0 );
    setdvar( "r_specularcolorscale", 2.5 );
    setdvar( "r_diffusecolorscale", 1 );
    setdvar( "r_lightGridEnableTweaks", 0 );
    setdvar( "r_lightGridIntensity", 1 );
    setdvar( "r_lightGridContrast", 0 );
    setdvar( "ui_showInfo", 1 );
    setdvar( "ui_showMinimap", 1 );
    _ID29171();
    precacheitem( "bomb_site_mp" );

    if ( !level.console )
    {
        level.furfx = loadfx( "vfx/apex/nv_dog_a" );
        level._ID38305 = [];
        level._ID38305[0] = loadfx( "vfx/apex/nv_wolf_b" );
        level._ID38305[1] = loadfx( "vfx/apex/nv_wolf_c" );
    }

    level._ID12791 = 0;
    level._ID20077 = "vehicle_aas_72x_killstreak";
}

_ID12476( var_0 )
{
    level endon( "killexplodertridgers" + var_0._ID27562 );
    var_0 waittill( "trigger" );

    if ( isdefined( var_0._ID27487 ) && randomfloat( 1 ) > var_0._ID27487 )
    {
        if ( isdefined( var_0.script_delay ) )
            wait(var_0.script_delay);
        else
            wait 4;

        level thread _ID12476( var_0 );
        return;
    }

    common_scripts\utility::exploder( var_0._ID27562 );
    level notify( "killexplodertridgers" + var_0._ID27562 );
}

_ID29176()
{
    var_0 = getentarray( "script_brushmodel", "classname" );
    var_1 = getentarray( "script_model", "classname" );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        var_0[var_0.size] = var_1[var_2];

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        if ( isdefined( var_0[var_2]._ID27779 ) )
            var_0[var_2]._ID27562 = var_0[var_2]._ID27779;

        if ( isdefined( var_0[var_2]._ID27562 ) )
        {
            if ( var_0[var_2].model == "fx" && ( !isdefined( var_0[var_2].targetname ) || var_0[var_2].targetname != "exploderchunk" ) )
            {
                var_0[var_2] hide();
                continue;
            }

            if ( isdefined( var_0[var_2].targetname ) && var_0[var_2].targetname == "exploder" )
            {
                var_0[var_2] hide();
                var_0[var_2] notsolid();
                continue;
            }

            if ( isdefined( var_0[var_2].targetname ) && var_0[var_2].targetname == "exploderchunk" )
            {
                var_0[var_2] hide();
                var_0[var_2] notsolid();
            }
        }
    }

    var_3 = [];
    var_4 = getentarray( "script_brushmodel", "classname" );

    for ( var_2 = 0; var_2 < var_4.size; var_2++ )
    {
        if ( isdefined( var_4[var_2]._ID27779 ) )
            var_4[var_2]._ID27562 = var_4[var_2]._ID27779;

        if ( isdefined( var_4[var_2]._ID27562 ) )
            var_3[var_3.size] = var_4[var_2];
    }

    var_4 = getentarray( "script_model", "classname" );

    for ( var_2 = 0; var_2 < var_4.size; var_2++ )
    {
        if ( isdefined( var_4[var_2]._ID27779 ) )
            var_4[var_2]._ID27562 = var_4[var_2]._ID27779;

        if ( isdefined( var_4[var_2]._ID27562 ) )
            var_3[var_3.size] = var_4[var_2];
    }

    var_4 = getentarray( "item_health", "classname" );

    for ( var_2 = 0; var_2 < var_4.size; var_2++ )
    {
        if ( isdefined( var_4[var_2]._ID27779 ) )
            var_4[var_2]._ID27562 = var_4[var_2]._ID27779;

        if ( isdefined( var_4[var_2]._ID27562 ) )
            var_3[var_3.size] = var_4[var_2];
    }

    if ( !isdefined( level._ID8435 ) )
        level._ID8435 = [];

    var_5 = [];
    var_5["exploderchunk visible"] = 1;
    var_5["exploderchunk"] = 1;
    var_5["exploder"] = 1;

    for ( var_2 = 0; var_2 < var_3.size; var_2++ )
    {
        var_6 = var_3[var_2];
        var_7 = common_scripts\utility::createexploder( var_6._ID27611 );
        var_7._ID34830 = [];
        var_7._ID34830["origin"] = var_6.origin;
        var_7._ID34830["angles"] = var_6.angles;
        var_7._ID34830["delay"] = var_6.script_delay;
        var_7._ID34830["firefx"] = var_6.script_firefx;
        var_7._ID34830["firefxdelay"] = var_6._ID27574;
        var_7._ID34830["firefxsound"] = var_6._ID27575;
        var_7._ID34830["firefxtimeout"] = var_6._ID27576;
        var_7._ID34830["earthquake"] = var_6._ID27551;
        var_7._ID34830["damage"] = var_6._ID27506;
        var_7._ID34830["damage_radius"] = var_6._ID27783;
        var_7._ID34830["soundalias"] = var_6._ID27819;
        var_7._ID34830["repeat"] = var_6._ID27787;
        var_7._ID34830["delay_min"] = var_6._ID27519;
        var_7._ID34830["delay_max"] = var_6._ID27518;
        var_7._ID34830["target"] = var_6.target;
        var_7._ID34830["ender"] = var_6._ID27553;
        var_7._ID34830["type"] = "exploder";

        if ( !isdefined( var_6._ID27611 ) )
            var_7._ID34830["fxid"] = "No FX";
        else
            var_7._ID34830["fxid"] = var_6._ID27611;

        var_7._ID34830["exploder"] = var_6._ID27562;

        if ( !isdefined( var_7._ID34830["delay"] ) )
            var_7._ID34830["delay"] = 0;

        if ( isdefined( var_6.target ) )
        {
            var_8 = getent( var_7._ID34830["target"], "targetname" ).origin;
            var_7._ID34830["angles"] = vectortoangles( var_8 - var_7._ID34830["origin"] );
        }

        if ( var_6.classname == "script_brushmodel" || isdefined( var_6.model ) )
        {
            var_7.model = var_6;
            var_7.model.disconnect_paths = var_6._ID27530;
        }

        if ( isdefined( var_6.targetname ) && isdefined( var_5[var_6.targetname] ) )
            var_7._ID34830["exploder_type"] = var_6.targetname;
        else
            var_7._ID34830["exploder_type"] = "normal";

        var_7 common_scripts\_createfx::_ID24771();
    }
}

lanterns()
{
    if ( !isdefined( level._ID1644["lantern_light"] ) )
        level._ID1644["lantern_light"] = loadfx( "fx/props/glow_latern" );

    common_scripts\_fx::_ID20341( "lantern_light", self.origin, 0.3, self.origin + ( 0, 0, 1 ) );
}

_ID29171()
{
    var_0 = getentarray( "scriptable_destructible_vehicle", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2.origin + ( 0, 0, 5 );
        var_4 = var_2.origin + ( 0, 0, 128 );
        var_5 = bullettrace( var_3, var_4, 0, var_2 );
        var_2._ID19214 = spawn( "script_model", var_5["position"] );
        var_2._ID19214.targetname = "killCamEnt_destructible_vehicle";
        var_2._ID19214 setscriptmoverkillcam( "explosive" );
        var_2 thread deletedestructiblekillcament();
    }

    var_7 = getentarray( "scriptable_destructible_barrel", "targetname" );

    foreach ( var_2 in var_7 )
    {
        var_3 = var_2.origin + ( 0, 0, 5 );
        var_4 = var_2.origin + ( 0, 0, 128 );
        var_5 = bullettrace( var_3, var_4, 0, var_2 );
        var_2._ID19214 = spawn( "script_model", var_5["position"] );
        var_2._ID19214.targetname = "killCamEnt_explodable_barrel";
        var_2._ID19214 setscriptmoverkillcam( "explosive" );
        var_2 thread deletedestructiblekillcament();
    }
}

deletedestructiblekillcament()
{
    level endon( "game_ended" );
    var_0 = self._ID19214;
    var_0 endon( "death" );
    self waittill( "death" );
    wait 10;

    if ( isdefined( var_0 ) )
        var_0 delete();
}
