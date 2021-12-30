// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    if ( isdefined( level.barrels_init ) )
        return;

    level.barrels_init = 1;
    var_0 = getentarray( "barrel_shootable", "targetname" );

    if ( !var_0.size )
        return;

    level._barrels = spawnstruct();
    level._barrels.num_barrel_fx = 0;
    var_0 thread _ID24849();
    var_0 thread methodsinit();
    thread _ID24774( var_0 );
}

_ID24774( var_0 )
{
    waittillframeend;

    if ( level._ID8425 )
        return;

    common_scripts\utility::_ID3867( var_0, ::barrelsetup );
}

barrelsetup()
{
    self setcandamage( 1 );
    self setcanradiusdamage( 0 );
    self.barrel_fx_array = [];
    var_0 = undefined;

    if ( isdefined( self.target ) )
    {
        var_0 = common_scripts\utility::_ID15384( self.target, "targetname" );
        self.a = var_0.origin;
        var_1 = anglestoforward( var_0.angles );
        var_1 *= 128;
        self.b = self.a + var_1;
    }
    else
    {
        var_1 = anglestoforward( self.angles );
        var_2 = var_1 * 64;
        self.a = self.origin + var_2;
        var_2 = var_1 * -64;
        self.b = self.origin + var_2;
    }

    thread barrel_wait_loop();
}

barrel_wait_loop()
{
    var_0 = ( 0, 0, 0 );
    var_1 = 0;
    var_2 = 4;

    for (;;)
    {
        self waittill( "damage",  var_3, var_4, var_5, var_0, var_6  );

        if ( var_1 )
        {
            if ( randomint( 100 ) <= 33 )
                continue;
        }

        var_1 = 1;
        var_7 = barrel_logic( var_5, var_0, var_6, var_4 );

        if ( var_7 )
            var_2--;

        if ( var_2 <= 0 )
            break;
    }

    self setcandamage( 0 );
}

barrel_logic( var_0, var_1, var_2, var_3 )
{
    if ( level._barrels.num_barrel_fx > 8 )
        return 0;

    if ( !isdefined( level._barrels._barrel_methods[var_2] ) )
        var_1 = barrel_calc_nofx( var_1, var_2 );
    else
        var_1 = self [[ level._barrels._barrel_methods[var_2] ]]( var_1, var_2 );

    if ( !isdefined( var_1 ) )
        return 0;

    if ( isdefined( var_3.classname ) && var_3.classname == "worldspawn" )
        return 0;

    foreach ( var_5 in self.barrel_fx_array )
    {
        if ( distancesquared( var_1, var_5.origin ) < 25 )
            return 0;
    }

    var_7 = undefined;

    if ( isai( var_3 ) )
        var_7 = var_3 geteye();
    else
        var_7 = var_3.origin;

    var_8 = var_1 - var_7;
    var_9 = bullettrace( var_7, var_7 + 1.5 * var_8, 0, var_3, 0 );

    if ( isdefined( var_9["normal"] ) && isdefined( var_9["entity"] ) && var_9["entity"] == self )
    {
        var_10 = var_9["normal"];
        thread barrelfx( var_1, var_10, var_3 );
        return 1;
    }

    return 0;
}

barrelfx( var_0, var_1, var_2 )
{
    var_3 = level._barrels._ID13977[self.script_noteworthy];
    var_4 = level._barrels._barrel_fx_time[self.script_noteworthy];
    var_5 = int( var_4 / var_3 );
    var_6 = 30;
    var_7 = level._barrels._sound[self.script_noteworthy + "_hit"];
    var_8 = level._barrels._sound[self.script_noteworthy + "_loop"];
    var_9 = level._barrels._sound[self.script_noteworthy + "_end"];
    var_10 = spawn( "script_origin", var_0 );
    var_10 playsound( var_7 );
    var_10 playloopsound( var_8 );
    self.barrel_fx_array[self.barrel_fx_array.size] = var_10;

    if ( common_scripts\utility::_ID18787() )
        thread barrel_damage( var_0, var_1, var_2, var_10 );

    var_11 = spawn( "script_model", var_0 );
    var_11 setmodel( "tag_origin" );
    var_11.angles = vectortoangles( var_1 );
    wait 0.05;
    playfxontag( level._barrels._ID1644[self.script_noteworthy], var_11, "tag_origin" );
    level._barrels.num_barrel_fx++;
    var_11 rotatepitch( 90, var_3, 1, 1 );
    wait(var_3);
    stopfxontag( level._barrels._ID1644[self.script_noteworthy], var_11, "tag_origin" );
    var_5--;

    while ( level._barrels.num_barrel_fx <= 8 && var_5 > 0 )
    {
        var_11 = spawn( "script_model", var_0 );
        var_11 setmodel( "tag_origin" );
        var_11.angles = vectortoangles( var_1 );
        wait 0.05;
        playfxontag( level._barrels._ID1644[self.script_noteworthy], var_11, "tag_origin" );
        level._barrels.num_barrel_fx++;
        var_11 rotatepitch( 90, var_3, 1, 1 );
        wait(var_3);
        stopfxontag( level._barrels._ID1644[self.script_noteworthy], var_11, "tag_origin" );
    }

    wait 0.5;
    var_10 delete();
    self.barrel_fx_array = common_scripts\utility::array_removeundefined( self.barrel_fx_array );
    level._barrels.num_barrel_fx--;
}

barrel_damage( var_0, var_1, var_2, var_3 )
{
    if ( !allow_barrel_damage() )
        return;

    var_3 endon( "death" );
    var_4 = var_3.origin + vectornormalize( var_1 ) * 40;
    var_5 = level._barrels._dmg[self.script_noteworthy];

    for (;;)
    {
        if ( !isdefined( self._ID8979 ) )
            self radiusdamage( var_4, 36, var_5, var_5 * 0.75, undefined, "MOD_TRIGGER_HURT" );
        else
            self radiusdamage( var_4, 36, var_5, var_5 * 0.75, var_2, "MOD_TRIGGER_HURT" );

        wait 0.4;
    }
}

allow_barrel_damage()
{
    if ( !common_scripts\utility::_ID18787() )
        return 0;

    if ( !isdefined( level.barrelsdamage ) )
        return 0;

    return level.barrelsdamage;
}

methodsinit()
{
    level._barrels._barrel_methods = [];
    level._barrels._barrel_methods["MOD_UNKNOWN"] = ::barrel_calc_splash;
    level._barrels._barrel_methods["MOD_PISTOL_BULLET"] = ::barrel_calc_ballistic;
    level._barrels._barrel_methods["MOD_RIFLE_BULLET"] = ::barrel_calc_ballistic;
    level._barrels._barrel_methods["MOD_GRENADE"] = ::barrel_calc_splash;
    level._barrels._barrel_methods["MOD_GRENADE_SPLASH"] = ::barrel_calc_splash;
    level._barrels._barrel_methods["MOD_PROJECTILE"] = ::barrel_calc_splash;
    level._barrels._barrel_methods["MOD_PROJECTILE_SPLASH"] = ::barrel_calc_splash;
    level._barrels._barrel_methods["MOD_TRIGGER_HURT"] = ::barrel_calc_splash;
    level._barrels._barrel_methods["MOD_EXPLOSIVE"] = ::barrel_calc_splash;
    level._barrels._barrel_methods["MOD_EXPLOSIVE_BULLET"] = ::barrel_calc_splash;
}

barrel_calc_ballistic( var_0, var_1 )
{
    return var_0;
}

barrel_calc_splash( var_0, var_1 )
{
    var_2 = vectornormalize( vectorfromlinetopoint( self.a, self.b, var_0 ) );
    var_0 = pointonsegmentnearesttopoint( self.a, self.b, var_0 );
    return var_0 + var_2 * 4;
}

barrel_calc_nofx( var_0, var_1 )
{
    return undefined;
}

_ID24849()
{
    var_0 = 0;
    var_1 = 0;
    var_2 = 0;

    foreach ( var_4 in self )
    {
        if ( var_4.script_noteworthy == "oil_leak" )
        {
            var_4 willneverchange();
            var_0 = 1;
            continue;
        }

        if ( var_4.script_noteworthy == "oil_cap" )
        {
            var_4 willneverchange();
            var_1 = 1;
            continue;
        }

        if ( var_4.script_noteworthy == "beer_leak" )
        {
            var_4 willneverchange();
            var_2 = 1;
            continue;
        }
    }

    if ( var_0 )
    {
        level._barrels._ID1644["oil_leak"] = loadfx( "fx/impacts/pipe_oil_barrel_spill" );
        level._barrels._ID13977["oil_leak"] = 6;
        level._barrels._barrel_fx_time["oil_leak"] = 6;
        level._barrels._dmg["oil_leak"] = 5;
    }

    if ( var_1 )
    {
        level._barrels._ID1644["oil_cap"] = loadfx( "fx/impacts/pipe_oil_barrel_squirt" );
        level._barrels._ID13977["oil_cap"] = 3;
        level._barrels._dmg["oil_cap"] = 5;
        level._barrels._barrel_fx_time["oil_cap"] = 5;
    }

    if ( var_2 )
    {
        level._barrels._ID1644["beer_leak"] = loadfx( "fx/impacts/beer_barrel_spill" );
        level._barrels._sound["beer_leak_hit"] = "mtl_beer_keg_hit";
        level._barrels._sound["beer_leak_loop"] = "mtl_beer_keg_hiss_loop";
        level._barrels._sound["beer_leak_end"] = "mtl_beer_keg_hiss_loop_end";
        level._barrels._ID13977["beer_leak"] = 6;
        level._barrels._barrel_fx_time["beer_leak"] = 6;
        level._barrels._dmg["beer_leak"] = 5;
    }
}
