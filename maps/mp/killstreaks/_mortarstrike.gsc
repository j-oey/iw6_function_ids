// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

createmortar( var_0 )
{
    level.mortarconfig = var_0;
    var_0 thread _ID38215();
    level._ID2653 = 0;
    level._ID20636 = ::mortarcustomcratefunc;
    level.mapcustomkillstreakfunc = ::mortarcustomkillstreakfunc;
    level._ID20635 = ::mortarcustombotkillstreakfunc;
}

mortarcustomcratefunc()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    if ( !maps\mp\_utility::allowlevelkillstreaks() || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", level.mortarconfig._ID17334, level.mortarconfig.crateweight, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), level.mortarconfig.cratehint );
    level thread watch_for_mortars_crate();
}

watch_for_mortars_crate()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == level.mortarconfig._ID17334 )
        {
            maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", level.mortarconfig._ID17334, 0 );
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", level.mortarconfig._ID17334, level.mortarconfig.crateweight );
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

mortarcustomkillstreakfunc()
{
    level._ID19256[level.mortarconfig._ID17334] = ::tryusemortars;
    level._ID19276[level.mortarconfig._ID36273] = level.mortarconfig._ID17334;
}

mortarcustombotkillstreakfunc()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( level.mortarconfig._ID17334, maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

tryusemortars( var_0, var_1 )
{
    if ( level._ID2653 )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    game["player_holding_level_killstrek"] = 0;
    level notify( "mortar_killstreak_used",  self  );
    return 1;
}

_ID37712()
{
    level endon( "mortar_killstreak_used" );
    level waittill( "spawning_intermission" );
    level._ID37173 = 1;
    _ID37707( 0.1, 0.3, 2.5, 2.5, 6, level.players[0] );
}

_ID38215()
{
    level endon( "stop_dynamic_events" );
    common_scripts\utility::_ID35582();
    self._ID37710 = common_scripts\utility::_ID15386( self.sourcestructs, "targetname" );

    foreach ( var_1 in self._ID37710 )
    {
        if ( !isdefined( var_1.radius ) )
            var_1.radius = 300;
    }

    self._ID37711 = common_scripts\utility::_ID15386( self.targetstructs, "targetname" );

    foreach ( var_4 in self._ID37711 )
    {
        if ( !isdefined( var_4.radius ) )
            var_4.radius = 100;
    }

    for (;;)
    {
        level._ID2653 = 0;
        level.air_raid_team_called = "none";
        thread _ID37712();
        level waittill( "mortar_killstreak_used",  var_6  );
        level._ID2653 = 1;
        level.air_raid_team_called = var_6.team;
        thread warning_audio();
        wait(self.launchdelay);
        _ID37707( self.launchdelaymin, self.launchdelaymax, self.launchairtimemin, self.launchairtimemax, self.strikeduration, var_6 );
        level notify( "mortar_killstreak_end" );
    }
}

warning_audio()
{
    if ( !isdefined( self.warningsfxentname ) || !isdefined( self.warningsfx ) )
        return;

    if ( !isdefined( self.warning_sfx_ent ) )
        self.warning_sfx_ent = getent( self.warningsfxentname, "targetname" );

    if ( isdefined( self.warning_sfx_ent ) )
    {
        self.warning_sfx_ent playsound( self.warningsfx );
        wait(self.warningsfxduration);
        self.warning_sfx_ent stopsounds();
    }
}

_ID37707( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = gettime() + var_4 * 1000;
    var_7 = _ID37853( level.air_raid_team_called );

    if ( var_7.size <= 0 )
        return;

    level notify( "mortar_killstreak_start" );
    var_8 = 0;

    while ( var_6 > gettime() )
    {
        var_9 = self.projectileperloop;
        var_10 = 0;

        foreach ( var_12 in level.players )
        {
            if ( !maps\mp\_utility::_ID18757( var_12 ) )
                continue;

            if ( level._ID32653 )
            {
                if ( var_12.team == level.air_raid_team_called )
                    continue;
            }
            else if ( isdefined( var_5 ) && var_12 == var_5 )
                continue;

            if ( var_12._ID30916 + 8000 > gettime() )
                continue;

            var_13 = var_12 getvelocity();
            var_14 = var_2;

            if ( var_3 > var_2 )
                var_14 = randomfloatrange( var_2, var_3 );

            var_15 = var_12.origin + var_13 * var_14;
            var_16 = getnodesinradiussorted( var_15, 100, 0, 60 );

            foreach ( var_18 in var_16 )
            {
                if ( nodeexposedtosky( var_18 ) )
                {
                    var_19 = common_scripts\utility::_ID25350( var_7 );

                    if ( _ID25368( var_19.origin, var_18.origin, var_14, var_5, 1, 1 ) )
                    {
                        wait(randomfloatrange( var_0, var_1 ));
                        var_10++;
                        break;
                    }
                }
            }
        }

        if ( self._ID37711.size > 0 )
        {
            for ( var_7 = common_scripts\utility::array_randomize( var_7 ); var_10 < var_9; var_10++ )
            {
                var_19 = var_7[var_8];
                var_8++;

                if ( var_8 >= var_7.size )
                    var_8 = 0;

                var_22 = common_scripts\utility::_ID25350( self._ID37711 );
                var_14 = var_2;

                if ( var_3 > var_2 )
                    var_14 = randomfloatrange( var_2, var_3 );

                var_23 = _ID25379( var_19.origin, var_19.radius );
                var_24 = _ID25379( var_22.origin, var_22.radius );
                thread _ID25368( var_23, var_24, var_14, var_5, 0, 1 );
                wait(randomfloatrange( var_0, var_1 ));
            }

            continue;
        }

        break;
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

_ID25368( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( isdefined( self.launchsfx ) )
        playsoundatpos( var_0, self.launchsfx );

    var_6 = ( 0, 0, -800 );
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
    var_7 = createprojectileentity( var_0, self.model );
    var_7._ID17490 = 1;
    common_scripts\utility::_ID35582();

    if ( isdefined( self.trailvfx ) )
        playfxontag( common_scripts\utility::_ID15033( self.trailvfx ), var_7, "tag_fx" );

    var_7.angles = vectortoangles( var_4 ) * ( -1, 1, 1 );

    if ( isdefined( self.incomingsfx ) )
        thread playsoundatposintime( self.incomingsfx, var_1, var_2 - 2.0 );

    var_7 movegravity( var_4, var_2 - 0.05 );

    if ( self.rotateprojectiles )
        var_7 rotatevelocity( common_scripts\utility::randomvectorrange( self.minrotatation, self.maxrotation ), var_2, 2, 0 );

    var_7 waittill( "movedone" );

    if ( level._ID8425 && !isdefined( level.players ) )
        level.players = [];

    if ( isdefined( var_3 ) )
        var_7 radiusdamage( var_1, 250, 750, 500, var_3, "MOD_EXPLOSIVE", self._ID36273 );
    else
        var_7 radiusdamage( var_1, 140, 5, 5, undefined, "MOD_EXPLOSIVE", self._ID36273 );

    playrumbleonposition( "artillery_rumble", var_1 );
    var_8 = var_6 * var_6;

    foreach ( var_10 in level.players )
    {
        if ( var_10 maps\mp\_utility::_ID18837() )
            continue;

        if ( distancesquared( var_1, var_10.origin ) > var_8 )
            continue;

        if ( var_10 damageconetrace( var_1 ) )
            var_10 thread maps\mp\gametypes\_shellshock::_ID10047( var_1 );
    }

    if ( var_5 )
    {
        if ( isdefined( self.impactvfx ) )
            playfx( common_scripts\utility::_ID15033( self.impactvfx ), var_1 );

        if ( isdefined( self.impactsfx ) )
            playsoundatpos( var_1, self.impactsfx );
    }

    var_7 delete();
}

playsoundatposintime( var_0, var_1, var_2 )
{
    wait(var_2);
    playsoundatpos( var_1, var_0 );
}

createprojectileentity( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0 );
    var_2 setmodel( var_1 );
    return var_2;
}

_ID37853( var_0 )
{
    var_1 = [];

    if ( level._ID32653 )
    {
        foreach ( var_3 in self._ID37710 )
        {
            if ( isdefined( var_3._ID27857 ) && var_3._ID27857 == var_0 )
                var_1[var_1.size] = var_3;
        }
    }

    if ( var_1.size == 0 )
        var_1 = self._ID37710;

    return var_1;
}
