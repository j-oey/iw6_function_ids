// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID37479()
{
    if ( !isdefined( level._ID38064 ) )
    {
        level._ID38064 = 250000;
        return;
    }
}

_ID27354( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_3 ) )
        var_4 = [[ var_1 ]]( var_2, var_3 );
    else
        var_4 = [[ var_1 ]]( var_2 );

    var_4 = clamp( var_4, 0, 100 );
    var_4 *= var_0;
    return var_4;
}

critical_factor( var_0, var_1 )
{
    var_2 = [[ var_0 ]]( var_1 );
    var_2 = clamp( var_2, 0, 100 );
    return var_2;
}

avoidcarepackages( var_0 )
{
    foreach ( var_2 in level._ID6711 )
    {
        if ( !isdefined( var_2 ) )
            continue;

        if ( distancesquared( var_0.origin, var_2.origin ) < 22500 )
            return 0;
    }

    return 100;
}

avoidgrenades( var_0 )
{
    foreach ( var_2 in level.grenades )
    {
        if ( !isdefined( var_2 ) || !var_2 _ID18618( var_0 ) )
            continue;

        if ( distancesquared( var_0.origin, var_2.origin ) < 122500 )
            return 0;
    }

    return 100;
}

avoidmines( var_0 )
{
    var_1 = common_scripts\utility::array_combine( level._ID21075, level.placedims );

    if ( isdefined( level._ID33473 ) && level._ID33473.size > 0 )
        var_1 = common_scripts\utility::array_combine( var_1, level._ID33473 );

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3 ) || !var_3 _ID18618( var_0 ) )
            continue;

        if ( distancesquared( var_0.origin, var_3.origin ) < 122500 )
            return 0;
    }

    return 100;
}

_ID18618( var_0 )
{
    if ( !level._ID32653 || level._ID13683 || !isdefined( var_0.team ) )
    {
        return 1;
        return;
    }

    var_1 = undefined;

    if ( isdefined( self.owner ) )
        var_1 = self.owner.team;

    if ( isdefined( var_1 ) )
    {
        return var_1 != var_0.team;
        return;
    }

    return 1;
    return;
    return;
}

avoidairstrikelocations( var_0 )
{
    if ( !isdefined( level._ID3910 ) )
        return 100;

    if ( !var_0._ID23137 )
        return 100;

    var_1 = maps\mp\killstreaks\_airstrike::getairstrikedanger( var_0.origin );

    if ( var_1 > 0 )
        return 0;

    return 100;
}

avoidcornervisibleenemies( var_0 )
{
    var_1 = "all";

    if ( level._ID32653 )
        var_1 = maps\mp\gametypes\_gameobjects::_ID15002( self.team );

    if ( var_0.cornersights[var_1] > 0 )
        return 0;

    return 100;
}

_ID4584( var_0 )
{
    var_1 = "all";

    if ( level._ID32653 )
        var_1 = maps\mp\gametypes\_gameobjects::_ID15002( self.team );

    if ( var_0._ID13732[var_1] > 0 )
        return 0;

    return 100;
}

_ID36753( var_0 )
{
    var_1 = [];
    var_2 = [];

    if ( level._ID32653 )
        var_1[0] = maps\mp\gametypes\_gameobjects::_ID15002( self.team );
    else
        var_1[var_1.size] = "all";

    foreach ( var_4 in var_1 )
    {
        if ( var_0._ID33157[var_4] == 0 )
            continue;

        var_2[var_2.size] = var_4;
    }

    if ( var_2.size == 0 )
        return 100;

    foreach ( var_4 in var_2 )
    {
        if ( var_0._ID21046[var_4] < level._ID38064 )
            return 0;
    }

    return 100;
}

_ID4592( var_0 )
{
    if ( isdefined( self.allowtelefrag ) )
        return 100;

    if ( positionwouldtelefrag( var_0.origin ) )
    {
        foreach ( var_2 in var_0.alternates )
        {
            if ( !positionwouldtelefrag( var_2 ) )
                return 100;
        }

        return 0;
    }

    return 100;
}

avoidsamespawn( var_0 )
{
    if ( isdefined( self._ID19613 ) && self._ID19613 == var_0 )
        return 0;

    return 100;
}

avoidenemyspawn( var_0 )
{
    if ( isdefined( var_0.lastspawnteam ) && ( !level._ID32653 || var_0.lastspawnteam != self.team ) )
    {
        var_1 = var_0.lastspawntime + 500;

        if ( gettime() < var_1 )
            return 0;
    }

    return 100;
}

avoidrecentlyusedbyenemies( var_0 )
{
    var_1 = !level._ID32653 || isdefined( var_0.lastspawnteam ) && self.team != var_0.lastspawnteam;

    if ( var_1 && isdefined( var_0.lastspawntime ) )
    {
        var_2 = gettime() - var_0.lastspawntime;

        if ( var_2 > 4000 )
            return 100;

        return var_2 / 4000 * 100;
    }

    return 100;
}

avoidrecentlyusedbyanyone( var_0 )
{
    if ( isdefined( var_0.lastspawntime ) )
    {
        var_1 = gettime() - var_0.lastspawntime;

        if ( var_1 > 4000 )
            return 100;

        return var_1 / 4000 * 100;
    }

    return 100;
}

avoidlastdeathlocation( var_0 )
{
    if ( !isdefined( self._ID19541 ) )
        return 100;

    var_1 = distancesquared( var_0.origin, self._ID19541 );

    if ( var_1 > 3240000 )
        return 100;

    var_2 = var_1 / 3240000;
    return var_2 * 100;
}

avoidlastattackerlocation( var_0 )
{
    if ( !isdefined( self.lastattacker ) || !isdefined( self.lastattacker.origin ) )
        return 100;

    if ( !maps\mp\_utility::_ID18757( self.lastattacker ) )
        return 100;

    var_1 = distancesquared( var_0.origin, self.lastattacker.origin );

    if ( var_1 > 3240000 )
        return 100;

    var_2 = var_1 / 3240000;
    return var_2 * 100;
}

spawnfrontlinethink()
{
    if ( !level._ID32653 )
        return;

    while ( !isdefined( level.spawnpoints ) )
        wait 0.05;

    var_0 = undefined;
    var_1 = undefined;
    var_2 = isdefined( level.matchrecording_logevent ) && isdefined( level.matchrecording_generateid );
    var_3 = getdvarint( "scr_draw_frontline" ) == 1;
    var_4 = getdvarint( "scr_frontline_min_spawns", 0 );

    if ( var_4 == 0 )
        var_4 = 3;

    var_5 = getdvarint( "scr_frontline_disable_ratio_check", 0 ) != 1;

    for (;;)
    {
        wait 0.5;
        var_6 = [];
        var_7 = [];

        foreach ( var_9 in level.players )
        {
            if ( !isdefined( var_9 ) )
                continue;

            if ( !maps\mp\_utility::_ID18757( var_9 ) )
                continue;

            if ( var_9.team == "axis" )
            {
                var_6[var_6.size] = var_9;
                continue;
            }

            var_7[var_7.size] = var_9;
        }

        var_11 = maps\mp\_utility::_ID14896( var_7 );

        if ( !isdefined( var_11 ) )
        {
            wait 0.05;
            continue;
        }

        var_11 = ( var_11[0], var_11[1], 0 );
        var_12 = maps\mp\_utility::_ID14896( var_6 );

        if ( !isdefined( var_12 ) )
        {
            wait 0.05;
            continue;
        }

        var_12 = ( var_12[0], var_12[1], 0 );
        var_13 = var_12 - var_11;
        var_14 = vectortoyaw( var_13 );

        if ( !isdefined( var_0 ) )
            var_0 = var_14;

        var_15 = 4.0;
        var_16 = var_14 - var_0;

        if ( var_16 > 180 )
            var_16 -= 360;
        else if ( var_16 < -180 )
            var_16 = 360 + var_16;

        var_15 = clamp( var_16, var_15 * -1, var_15 );
        var_0 += var_15;
        var_17 = var_11 + var_13 * 0.5;

        if ( !isdefined( var_1 ) )
            var_1 = var_17;

        var_18 = var_17 - var_1;
        var_19 = length2d( var_18 );
        var_20 = min( var_19, 100 );

        if ( var_20 > 0 )
        {
            var_18 *= var_20 / var_19;
            var_1 += var_18;
        }

        var_21 = anglestoforward( ( 0, var_0, 0 ) );
        var_22 = [];
        var_22["allies"] = 0;
        var_22["axis"] = 0;
        var_23 = level.spawnpoints;
        var_23 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns( var_23 );

        foreach ( var_25 in var_23 )
        {
            var_26 = undefined;
            var_27 = var_1 - var_25.origin;
            var_28 = vectordot( var_27, var_21 );

            if ( var_28 > 0 )
            {
                var_26 = "allies";
                var_25.forcedteam = var_26;
            }
            else
            {
                var_26 = "axis";
                var_25.forcedteam = var_26;
            }

            var_29 = maps\mp\_utility::getotherteam( var_26 );

            if ( !isdefined( var_25._ID13732 ) || !isdefined( var_25._ID13732[var_29] ) || var_25._ID13732[var_29] <= 0 )
                var_22[var_26]++;
        }

        var_31 = common_scripts\utility::_ID32831( var_22["allies"] < var_22["axis"], "allies", "axis" );
        var_32 = maps\mp\_utility::getotherteam( var_31 );
        var_33 = var_22[var_31] < var_22[var_32] * 0.5;

        if ( var_22[var_31] <= var_4 || var_5 && var_33 )
        {
            foreach ( var_25 in var_23 )
                var_25.forcedteam = undefined;

            var_1 = undefined;
            var_0 = undefined;
        }

        if ( var_2 || var_3 )
        {
            if ( var_2 && !isdefined( level.frontlinelogids ) )
            {
                level.frontlinelogids = [];
                level.frontlinelogids["line"] = [[ level.matchrecording_generateid ]]();
                level.frontlinelogids["alliesCenter"] = [[ level.matchrecording_generateid ]]();
                level.frontlinelogids["axisCenter"] = [[ level.matchrecording_generateid ]]();
            }

            if ( isdefined( var_1 ) && isdefined( var_0 ) )
            {
                var_36 = ( var_1[0], var_1[1], level._ID20634[2] );
                var_37 = anglestoright( ( 0, var_0, 0 ) );
                var_38 = var_36 + var_37 * 5000;
                var_39 = var_36 - var_37 * 5000;

                if ( var_2 )
                    [[ level.matchrecording_logevent ]]( level.frontlinelogids["line"], "allies", "FRONT_LINE", var_38[0], var_38[1], gettime(), undefined, var_39[0], var_39[1] );
            }
            else if ( var_2 )
                [[ level.matchrecording_logevent ]]( level.frontlinelogids["line"], "allies", "FRONT_LINE", 0, 0, gettime(), undefined, 0, 0 );

            if ( var_2 )
            {
                [[ level.matchrecording_logevent ]]( level.frontlinelogids["alliesCenter"], "axis", "ANCHOR", var_12[0], var_12[1], gettime() );
                [[ level.matchrecording_logevent ]]( level.frontlinelogids["axisCenter"], "allies", "ANCHOR", var_11[0], var_11[1], gettime() );
            }
        }
    }
}

_ID36999()
{
    level notify( "correctHomogenization" );
    level endon( "correctHomogenization" );

    if ( !level._ID32653 )
        return;

    var_0 = 2;
    var_1 = 0;
    var_2 = [];
    var_3 = [];
    var_4 = [];
    var_5 = [];
    var_6 = [];
    var_7 = [];
    var_2 = getspawnarray( "mp_tdm_spawn_allies_start" );
    var_3 = getspawnarray( "mp_tdm_spawn_axis_start" );
    var_8 = [];

    while ( !isdefined( level.spawnpoints ) )
        wait 0.05;

    var_9 = tolower( getdvar( "mapname" ) );

    if ( var_9 == "mp_strikezone" )
    {
        foreach ( var_11 in level.spawnpoints )
        {
            if ( var_11.origin[2] < 20000 )
            {
                var_4[var_4.size] = var_11;
                continue;
            }

            var_5[var_5.size] = var_11;
        }

        if ( level.teleport_zone_current == "start" )
            var_6 = sortbydistance( var_4, level._ID20634 );
        else
            var_6 = sortbydistance( var_5, level._ID20634 );

        for ( var_13 = 0; var_13 < 8; var_13++ )
            var_7[var_13] = var_6[var_6.size - var_13 + 1];
    }
    else
    {
        var_6 = sortbydistance( level.spawnpoints, level._ID20634 );

        for ( var_13 = 0; var_13 < 8; var_13++ )
            var_7[var_13] = var_6[var_6.size - var_13 + 1];

        var_7[var_7.size] = var_2[0];
        var_7[var_7.size] = var_3[0];
    }

    var_14 = int( getdvar( "scr_anchorSpawns" ) );

    for (;;)
    {
        wait 5;
        var_15 = [];
        var_16 = [];

        foreach ( var_18 in level.players )
        {
            if ( !isdefined( var_18 ) )
                continue;

            if ( !maps\mp\_utility::_ID18757( var_18 ) )
                continue;

            if ( var_18.team == "axis" )
            {
                var_15[var_15.size] = var_18;
                continue;
            }

            var_16[var_16.size] = var_18;
        }

        var_20 = maps\mp\_utility::_ID14896( var_16 );

        if ( !isdefined( var_20 ) )
        {
            wait 0.05;
            continue;
        }

        var_21 = [];
        var_21 = sortbydistance( var_7, var_20 );
        var_22 = var_21[0];
        var_23 = 0;
        var_24 = undefined;

        for ( var_13 = 0; var_13 < var_8.size; var_13++ )
        {
            if ( var_22 == var_8[var_13] )
            {
                var_23 = 1;
                continue;
            }

            var_23 = 0;
            break;
        }

        if ( var_23 )
        {
            var_1 += 1;

            if ( var_1 >= var_0 )
            {
                var_24 = var_21[var_21.size - 1];
                var_8[var_8.size] = var_24;
            }
        }

        if ( !isdefined( var_24 ) )
        {
            var_24 = var_22;
            var_8[var_8.size] = var_24;
        }

        var_25 = [];
        var_25 = sortbydistance( var_7, var_24.origin );
        var_26 = var_25[var_25.size - 1];
        level._ID36704 = var_24.origin;
        level._ID36760 = var_26.origin;
    }
}

_ID37103()
{
    var_0 = [];
    var_1 = [];

    if ( level._ID32653 )
    {
        foreach ( var_3 in level.players )
        {
            if ( !isdefined( var_3 ) )
                continue;

            if ( !maps\mp\_utility::_ID18757( var_3 ) )
                continue;

            if ( var_3.team == "axis" )
            {
                var_0[var_0.size] = var_3;
                continue;
            }

            var_1[var_1.size] = var_3;
        }

        var_5 = maps\mp\_utility::_ID14896( var_0 );
        var_6 = maps\mp\_utility::_ID14896( var_1 );

        if ( !isdefined( var_6 ) || !isdefined( var_5 ) )
            return 0;

        if ( common_scripts\utility::_ID10238( var_6, var_5 ) < 1048576 )
        {
            return 1;
            return;
        }

        return 0;
        return;
        return;
    }

    return 0;
    return;
}

_ID24866( var_0 )
{
    if ( var_0._ID33157[self.team] == 0 )
        return 0;

    var_1 = var_0._ID10251[self.team] / var_0._ID33157[self.team];
    var_1 = min( var_1, 3240000 );
    var_2 = 1 - var_1 / 3240000;
    return var_2 * 100;
}

_ID4582( var_0 )
{
    var_1 = [];
    var_2 = [];

    if ( level._ID32653 )
        var_1[0] = maps\mp\gametypes\_gameobjects::_ID15002( self.team );
    else
        var_1[var_1.size] = "all";

    foreach ( var_4 in var_1 )
    {
        if ( var_0._ID33157[var_4] == 0 )
            continue;

        var_2[var_2.size] = var_4;
    }

    if ( var_2.size == 0 )
        return 100;

    foreach ( var_4 in var_2 )
    {
        if ( var_0._ID21046[var_4] < 250000 )
            return 0;
    }

    var_8 = 0;
    var_9 = 0;

    foreach ( var_4 in var_2 )
    {
        var_8 += var_0.distsumsquaredcapped[var_4];
        var_9 += var_0._ID33157[var_4];
    }

    var_12 = var_8 / var_9;
    var_12 = min( var_12, 3240000 );
    var_13 = var_12 / 3240000;
    return var_13 * 100;
}

avoidclosestenemy( var_0 )
{
    var_1 = [];
    var_2 = [];

    if ( level._ID32653 )
        var_1[0] = maps\mp\gametypes\_gameobjects::_ID15002( self.team );
    else
        var_1[var_1.size] = "all";

    foreach ( var_4 in var_1 )
    {
        if ( var_0._ID33157[var_4] == 0 )
            continue;

        var_2[var_2.size] = var_4;
    }

    if ( var_2.size == 0 )
        return 100;

    var_6 = 0;

    foreach ( var_4 in var_2 )
    {
        if ( var_0._ID21046[var_4] < 250000 )
            return 0;

        var_8 = min( var_0._ID21046[var_4], 3240000 );
        var_9 = var_8 / 3240000;
        var_6 += var_9 * 100;
    }

    return var_6 / var_2.size;
}

scoredompoint( var_0 )
{
    var_1 = undefined;

    foreach ( var_3 in level._ID10614 )
    {
        if ( isdefined( var_3.dompointnumber ) && var_3.dompointnumber == var_0 )
        {
            var_1 = var_3;
            break;
        }
    }

    if ( !isdefined( var_1 ) )
        return 100;

    var_5 = var_1 maps\mp\gametypes\_gameobjects::_ID14931();

    if ( var_5 == "none" )
    {
        return 100;
        return;
    }

    return 50.0;
    return;
}

_ID24868( var_0, var_1 )
{
    if ( var_1[0] && var_0.dompointa )
        return scoredompoint( 0 );

    if ( var_1[1] && var_0._ID10622 )
        return scoredompoint( 1 );

    if ( var_1[2] && var_0.dompointc )
        return scoredompoint( 2 );

    return 0;
}

preferclosepoints( var_0, var_1 )
{
    foreach ( var_3 in var_1 )
    {
        if ( var_0 == var_3 )
            return 100;
    }

    return 0;
}

_ID24867( var_0, var_1 )
{
    if ( isdefined( var_0._ID32652 ) && var_0._ID32652 == var_1 )
        return 100;

    return 0;
}

_ID25410( var_0 )
{
    return randomintrange( 0, 99 );
}

maxplayerspawninfluencedistsquared( var_0 )
{
    return 3240000;
}
