// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID15345( var_0 )
{
    var_0 = checkdynamicspawns( var_0 );
    var_1["primary"] = [];
    var_1["secondary"] = [];
    var_1["bad"] = [];

    foreach ( var_3 in var_0 )
    {
        _ID17997( var_3 );
        var_4 = criticalfactors_nearteam( var_3 );
        var_1[var_4][var_1[var_4].size] = var_3;
    }

    if ( var_1["primary"].size )
        return _ID27367( var_1["primary"] );

    if ( var_1["secondary"].size )
        return _ID27367( var_1["secondary"] );

    logbadspawn( "Buddy Spawn" );
    return _ID28016( var_0[0], var_0 );
}

_ID27367( var_0 )
{
    var_1 = var_0[0];

    foreach ( var_3 in var_0 )
    {
        _ID27358( var_3 );

        if ( var_3.totalscore > var_1.totalscore )
            var_1 = var_3;
    }

    var_1 = _ID28016( var_1, var_0 );
    return var_1;
}

checkdynamicspawns( var_0 )
{
    if ( isdefined( level.dynamicspawns ) )
        var_0 = [[ level.dynamicspawns ]]( var_0 );

    return var_0;
}

_ID28016( var_0, var_1 )
{
    var_2 = var_0;
    var_3 = 0;

    foreach ( var_5 in var_1 )
    {
        if ( var_5.totalscore > 0 )
            var_3++;
    }

    if ( var_3 == 0 || level._ID13508 )
    {
        if ( level._ID32653 && level._ID32096 )
        {
            var_7 = _ID12930();

            if ( var_7.buddyspawn )
                var_2 = var_7;
        }

        if ( var_2.totalscore == 0 )
        {
            logbadspawn( "UNABLE TO BUDDY SPAWN. Extremely bad." );
            var_2 = var_1[randomint( var_1.size )];
        }
    }

    return var_2;
}

_ID12940( var_0, var_1 )
{
    if ( var_1.size < 2 )
        return var_0;

    var_2 = var_1[0];

    if ( var_2 == var_0 )
        var_2 = var_1[1];

    foreach ( var_4 in var_1 )
    {
        if ( var_4 == var_0 )
            continue;

        if ( var_4.totalscore > var_2.totalscore )
            var_2 = var_4;
    }

    return var_2;
}

_ID12930()
{
    var_0 = spawnstruct();
    _ID17997( var_0 );
    var_1 = _ID15420( self.team );
    var_2 = spawnstruct();
    var_2.maxtracecount = 18;
    var_2._ID8708 = 0;

    foreach ( var_4 in var_1 )
    {
        var_5 = findspawnlocationnearplayer( var_4 );

        if ( !isdefined( var_5 ) )
            continue;

        if ( _ID18770( var_4, var_5, var_2 ) )
        {
            var_0.totalscore = 999;
            var_0.buddyspawn = 1;
            var_0.origin = var_5;
            var_0.angles = getbuddyspawnangles( var_4, var_0.origin );
            break;
        }

        if ( var_2._ID8708 == var_2.maxtracecount )
            break;
    }

    return var_0;
}

getbuddyspawnangles( var_0, var_1 )
{
    var_2 = ( 0, var_0.angles[1], 0 );
    var_3 = findentrances( var_1 );

    if ( isdefined( var_3 ) && var_3.size > 0 )
        var_2 = vectortoangles( var_3[0].origin - var_1 );

    return var_2;
}

_ID15420( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level.players )
    {
        if ( var_3.team != var_0 )
            continue;

        if ( var_3.sessionstate != "playing" )
            continue;

        if ( !maps\mp\_utility::_ID18757( var_3 ) )
            continue;

        if ( var_3 == self )
            continue;

        if ( _ID18739( var_3 ) )
            continue;

        var_1[var_1.size] = var_3;
    }

    return common_scripts\utility::array_randomize( var_1 );
}

_ID18739( var_0, var_1 )
{
    if ( var_0 issighted() )
    {
        _ID9244( var_0, "IsSighted" );
        return 1;
    }

    if ( !var_0 isonground() )
    {
        _ID9244( var_0, "IsOnGround" );
        return 1;
    }

    if ( var_0 isonladder() )
    {
        _ID9244( var_0, "IsOnLadder" );
        return 1;
    }

    if ( var_0 common_scripts\utility::isflashed() )
    {
        _ID9244( var_0, "isFlashed" );
        return 1;
    }

    if ( isdefined( var_1 ) && var_1 )
    {
        if ( var_0.health < var_0.maxhealth && ( !isdefined( var_0._ID19538 ) || gettime() < var_0._ID19538 + 3000 ) )
        {
            _ID9244( var_0, "RecentDamage" );
            return 1;
        }
    }
    else if ( var_0.health < var_0.maxhealth )
    {
        _ID9244( var_0, "MaxHealth" );
        return 1;
    }

    if ( !maps\mp\gametypes\_spawnfactor::avoidgrenades( var_0 ) )
    {
        _ID9244( var_0, "Grenades" );
        return 1;
    }

    if ( !maps\mp\gametypes\_spawnfactor::avoidmines( var_0 ) )
    {
        _ID9244( var_0, "Mines" );
        return 1;
    }

    return 0;
}

_ID9244( var_0, var_1 )
{
    var_2 = "none";

    if ( isdefined( var_0.battlebuddy ) )
        var_2 = var_0.battlebuddy.name;

    bbprint( "battlebuddy_spawn", "player %s buddy %s reason %s", var_0.name, var_2, var_1 );
}

findspawnlocationnearplayer( var_0 )
{
    var_1 = maps\mp\gametypes\_spawnlogic::getplayertraceheight( var_0, 1 );
    var_2 = findbuddypathnode( var_0, var_1, 0.5 );

    if ( isdefined( var_2 ) )
        return var_2.origin;

    return undefined;
}

findbuddypathnode( var_0, var_1, var_2 )
{
    var_3 = getnodesinradiussorted( var_0.origin, 192, 64, var_1, "Path" );
    var_4 = undefined;

    if ( isdefined( var_3 ) && var_3.size > 0 )
    {
        var_5 = anglestoforward( var_0.angles );

        foreach ( var_7 in var_3 )
        {
            var_8 = vectornormalize( var_7.origin - var_0.origin );
            var_9 = vectordot( var_5, var_8 );

            if ( maps\mp\_utility::getmapname() == "mp_fahrenheit" )
            {
                if ( var_7.origin == ( 1778.9, 171.6, 716 ) || var_7.origin == ( 1772.1, 271.4, 716 ) || var_7.origin == ( 1657.2, 259.6, 716 ) || var_7.origin == ( 1633.7, 333.9, 716 ) || var_7.origin == ( 1634.4, 415.7, 716 ) || var_7.origin == ( 1537.3, 419.3, 716 ) || var_7.origin == ( 1410.9, 420.8, 716 ) || var_7.origin == ( 1315.6, 416.6, 716 ) || var_7.origin == ( 1079.4, 414.6, 716 ) || var_7.origin == ( 982.9, 421.8, 716 ) || var_7.origin == ( 896.9, 423.8, 716 ) )
                    continue;
            }

            if ( var_9 <= var_2 && !positionwouldtelefrag( var_7.origin ) )
            {
                if ( sighttracepassed( var_0.origin + ( 0, 0, var_1 ), var_7.origin + ( 0, 0, var_1 ), 0, var_0 ) )
                {
                    var_4 = var_7;

                    if ( var_9 <= 0.0 )
                        break;
                }
            }
        }
    }

    return var_4;
}

finddronepathnode( var_0, var_1, var_2, var_3 )
{
    var_4 = getnodesinradiussorted( var_0.origin, var_3, 32, var_1, "Path" );
    var_5 = undefined;

    if ( isdefined( var_4 ) && var_4.size > 0 )
    {
        var_6 = anglestoforward( var_0.angles );

        foreach ( var_8 in var_4 )
        {
            var_9 = var_8.origin + ( 0, 0, var_1 );

            if ( capsuletracepassed( var_9, var_2, var_2 * 2 + 0.01, undefined, 1, 1 ) )
            {
                if ( bullettracepassed( var_0 geteye(), var_9, 0, var_0 ) )
                {
                    var_5 = var_9;
                    break;
                }
            }
        }
    }

    return var_5;
}

_ID18770( var_0, var_1, var_2 )
{
    if ( var_0 issighted() )
    {
        _ID9244( self, "IsSighted-2" );
        return 0;
    }

    foreach ( var_4 in level.players )
    {
        if ( var_2._ID8708 == var_2.maxtracecount )
        {
            _ID9244( self, "TooManyTraces" );
            return 0;
        }

        if ( var_4.team == self.team )
            continue;

        if ( var_4.sessionstate != "playing" )
            continue;

        if ( !maps\mp\_utility::_ID18757( var_4 ) )
            continue;

        if ( var_4 == self )
            continue;

        var_2._ID8708++;
        var_5 = maps\mp\gametypes\_spawnlogic::getplayertraceheight( var_4 );
        var_6 = var_4 geteye();
        var_6 = ( var_6[0], var_6[1], var_4.origin[2] + var_5 );
        var_7 = spawnsighttrace( var_2, var_1 + ( 0, 0, var_5 ), var_6 );

        if ( var_7 > 0 )
        {
            _ID9244( self, "lineOfSight" );
            return 0;
        }
    }

    return 1;
}

_ID17997( var_0 )
{
    var_0.totalscore = 0;
    var_0._ID22392 = 0;
    var_0.buddyspawn = 0;
}

criticalfactors_nearteam( var_0 )
{
    if ( !maps\mp\gametypes\_spawnfactor::critical_factor( maps\mp\gametypes\_spawnfactor::_ID4584, var_0 ) )
        return "bad";

    if ( !maps\mp\gametypes\_spawnfactor::critical_factor( maps\mp\gametypes\_spawnfactor::avoidgrenades, var_0 ) )
        return "bad";

    if ( !maps\mp\gametypes\_spawnfactor::critical_factor( maps\mp\gametypes\_spawnfactor::avoidmines, var_0 ) )
        return "bad";

    if ( !maps\mp\gametypes\_spawnfactor::critical_factor( maps\mp\gametypes\_spawnfactor::avoidairstrikelocations, var_0 ) )
        return "bad";

    if ( !maps\mp\gametypes\_spawnfactor::critical_factor( maps\mp\gametypes\_spawnfactor::avoidcarepackages, var_0 ) )
        return "bad";

    if ( !maps\mp\gametypes\_spawnfactor::critical_factor( maps\mp\gametypes\_spawnfactor::_ID4592, var_0 ) )
        return "bad";

    if ( !maps\mp\gametypes\_spawnfactor::critical_factor( maps\mp\gametypes\_spawnfactor::avoidenemyspawn, var_0 ) )
        return "bad";

    if ( isdefined( var_0.forcedteam ) && var_0.forcedteam != self.team )
        return "bad";

    if ( !maps\mp\gametypes\_spawnfactor::critical_factor( maps\mp\gametypes\_spawnfactor::avoidcornervisibleenemies, var_0 ) )
        return "secondary";

    if ( !maps\mp\gametypes\_spawnfactor::critical_factor( maps\mp\gametypes\_spawnfactor::_ID36753, var_0 ) )
        return "secondary";

    return "primary";
}

_ID27358( var_0 )
{
    var_1 = maps\mp\gametypes\_spawnfactor::_ID27354( 1.25, maps\mp\gametypes\_spawnfactor::_ID24866, var_0 );
    var_0.totalscore = var_0.totalscore + var_1;
    var_1 = maps\mp\gametypes\_spawnfactor::_ID27354( 1.0, maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyenemies, var_0 );
    var_0.totalscore = var_0.totalscore + var_1;
    var_1 = maps\mp\gametypes\_spawnfactor::_ID27354( 1.0, maps\mp\gametypes\_spawnfactor::_ID4582, var_0 );
    var_0.totalscore = var_0.totalscore + var_1;
    var_1 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.5, maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation, var_0 );
    var_0.totalscore = var_0.totalscore + var_1;
    var_1 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.5, maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation, var_0 );
    var_0.totalscore = var_0.totalscore + var_1;
    var_1 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.25, maps\mp\gametypes\_spawnfactor::avoidsamespawn, var_0 );
    var_0.totalscore = var_0.totalscore + var_1;
    var_1 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.25, maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyanyone, var_0 );
    var_0.totalscore = var_0.totalscore + var_1;
}

criticalfactors_dz( var_0 )
{
    return criticalfactors_nearteam( var_0 );
}

getspawnpoint_dz( var_0, var_1 )
{
    var_0 = checkdynamicspawns( var_0 );
    var_2["primary"] = [];
    var_2["secondary"] = [];
    var_2["bad"] = [];

    foreach ( var_4 in var_0 )
    {
        _ID17997( var_4 );
        var_5 = criticalfactors_dz( var_4 );
        var_2[var_5][var_2[var_5].size] = var_4;
    }

    if ( var_2["primary"].size )
        return scorespawns_dz( var_2["primary"], var_1 );

    if ( var_2["secondary"].size )
        return scorespawns_dz( var_2["secondary"], var_1 );

    return _ID28016( var_0[0], var_0 );
}

getspawnpoint_domination( var_0, var_1 )
{
    var_0 = checkdynamicspawns( var_0 );
    var_2["primary"] = [];
    var_2["secondary"] = [];
    var_2["bad"] = [];

    foreach ( var_4 in var_0 )
    {
        _ID17997( var_4 );
        var_5 = criticalfactors_domination( var_4 );
        var_2[var_5][var_2[var_5].size] = var_4;
    }

    if ( var_2["primary"].size )
        return _ID27365( var_2["primary"], var_1 );

    if ( var_2["secondary"].size )
        return _ID27365( var_2["secondary"], var_1 );

    logbadspawn( "Buddy Spawn" );
    return _ID28016( var_0[0], var_0 );
}

scorespawns_dz( var_0, var_1 )
{
    var_2 = var_0[0];

    foreach ( var_4 in var_0 )
    {
        scorefactors_dz( var_4, var_1 );

        if ( var_4.totalscore > var_2.totalscore )
            var_2 = var_4;
    }

    var_2 = _ID28016( var_2, var_0 );
    return var_2;
}

_ID27365( var_0, var_1 )
{
    var_2 = var_0[0];

    foreach ( var_4 in var_0 )
    {
        _ID27356( var_4, var_1 );

        if ( var_4.totalscore > var_2.totalscore )
            var_2 = var_4;
    }

    var_2 = _ID28016( var_2, var_0 );
    return var_2;
}

criticalfactors_domination( var_0 )
{
    return criticalfactors_nearteam( var_0 );
}

scorefactors_dz( var_0, var_1 )
{
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 2.5, maps\mp\gametypes\_spawnfactor::preferclosepoints, var_0, var_1 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 1.0, maps\mp\gametypes\_spawnfactor::_ID24866, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 1.0, maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyenemies, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 1.0, maps\mp\gametypes\_spawnfactor::_ID4582, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.25, maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.25, maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.25, maps\mp\gametypes\_spawnfactor::avoidsamespawn, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.25, maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyanyone, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
}

_ID27356( var_0, var_1 )
{
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 2.5, maps\mp\gametypes\_spawnfactor::_ID24868, var_0, var_1 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 1.0, maps\mp\gametypes\_spawnfactor::_ID24866, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 1.0, maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyenemies, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 1.0, maps\mp\gametypes\_spawnfactor::_ID4582, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.25, maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.25, maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.25, maps\mp\gametypes\_spawnfactor::avoidsamespawn, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.25, maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyanyone, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
}

_ID37369( var_0 )
{
    if ( !isdefined( var_0 ) )
        return undefined;

    var_1 = undefined;
    var_2 = maps\mp\gametypes\_spawnlogic::getactiveplayerlist();
    var_0 = checkdynamicspawns( var_0 );

    if ( !isdefined( var_2 ) || var_2.size == 0 )
        return maps\mp\gametypes\_spawnlogic::_ID15346( var_0 );

    var_3 = 0;

    foreach ( var_5 in var_0 )
    {
        if ( canspawn( var_5.origin ) && !positionwouldtelefrag( var_5.origin ) )
        {
            var_6 = undefined;

            foreach ( var_8 in var_2 )
            {
                var_9 = distancesquared( var_5.origin, var_8.origin );

                if ( !isdefined( var_6 ) || var_9 < var_6 )
                    var_6 = var_9;
            }

            if ( !isdefined( var_1 ) || var_6 > var_3 )
            {
                var_1 = var_5;
                var_3 = var_6;
            }
        }
    }

    if ( !isdefined( var_1 ) )
        return maps\mp\gametypes\_spawnlogic::_ID15346( var_0 );

    return var_1;
}

_ID15344( var_0 )
{
    var_0 = checkdynamicspawns( var_0 );
    var_1["primary"] = [];
    var_1["secondary"] = [];
    var_1["bad"] = [];

    foreach ( var_3 in var_0 )
    {
        _ID17997( var_3 );
        var_4 = _ID8516( var_3 );
        var_1[var_4][var_1[var_4].size] = var_3;
    }

    if ( var_1["primary"].size )
        return _ID27366( var_1["primary"] );

    if ( var_1["secondary"].size )
        return _ID27366( var_1["secondary"] );

    if ( getdvarint( "scr_altFFASpawns" ) == 1 && var_1["bad"].size )
    {
        logbadspawn( "Bad FFA Spawn" );
        return _ID27366( var_1["bad"] );
    }

    logbadspawn( "FFA Random Spawn" );
    return _ID28016( var_0[0], var_0 );
}

_ID27366( var_0 )
{
    var_1 = var_0[0];

    foreach ( var_3 in var_0 )
    {
        _ID27357( var_3 );

        if ( var_3.totalscore > var_1.totalscore )
            var_1 = var_3;
    }

    var_1 = _ID28016( var_1, var_0 );
    return var_1;
}

_ID8516( var_0 )
{
    return criticalfactors_nearteam( var_0 );
}

_ID27357( var_0 )
{
    var_1 = 3.0;

    if ( getdvarint( "scr_altFFASpawns" ) == 1 )
    {
        var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 3.0, maps\mp\gametypes\_spawnfactor::avoidclosestenemy, var_0 );
        var_0.totalscore = var_0.totalscore + var_2;
        var_1 = 2.0;
    }

    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( var_1, maps\mp\gametypes\_spawnfactor::_ID4582, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 2.0, maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyenemies, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.5, maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.5, maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.5, maps\mp\gametypes\_spawnfactor::avoidsamespawn, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
}

_ID15348( var_0 )
{
    var_0 = checkdynamicspawns( var_0 );
    var_1["primary"] = [];
    var_1["secondary"] = [];
    var_1["bad"] = [];

    foreach ( var_3 in var_0 )
    {
        _ID17997( var_3 );
        var_4 = _ID8519( var_3 );
        var_1[var_4][var_1[var_4].size] = var_3;
    }

    if ( var_1["primary"].size )
        return _ID27369( var_1["primary"] );

    if ( var_1["secondary"].size )
        return _ID27369( var_1["secondary"] );

    logbadspawn( "Buddy Spawn" );
    return _ID28016( var_0[0], var_0 );
}

_ID27369( var_0 )
{
    var_1 = var_0[0];

    foreach ( var_3 in var_0 )
    {
        _ID27360( var_3 );

        if ( var_3.totalscore > var_1.totalscore )
            var_1 = var_3;
    }

    var_1 = _ID28016( var_1, var_0 );
    return var_1;
}

_ID8519( var_0 )
{
    return criticalfactors_nearteam( var_0 );
}

_ID27360( var_0 )
{
    var_1 = maps\mp\gametypes\_spawnfactor::_ID27354( 3.0, maps\mp\gametypes\_spawnfactor::_ID4582, var_0 );
    var_0.totalscore = var_0.totalscore + var_1;
    var_1 = maps\mp\gametypes\_spawnfactor::_ID27354( 1.0, maps\mp\gametypes\_spawnfactor::_ID24866, var_0 );
    var_0.totalscore = var_0.totalscore + var_1;
    var_1 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.5, maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation, var_0 );
    var_0.totalscore = var_0.totalscore + var_1;
    var_1 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.5, maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation, var_0 );
    var_0.totalscore = var_0.totalscore + var_1;
}

_ID15342( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_0 = checkdynamicspawns( var_0 );
    var_3["primary"] = [];
    var_3["secondary"] = [];
    var_3["bad"] = [];

    foreach ( var_5 in var_0 )
    {
        _ID17997( var_5 );
        var_6 = criticalfactors_awayfromenemies( var_5 );
        var_3[var_6][var_3[var_6].size] = var_5;
    }

    if ( var_3["primary"].size )
        return _ID27364( var_3["primary"], var_1 );

    if ( var_3["secondary"].size )
        return _ID27364( var_3["secondary"], var_1 );

    if ( var_2 )
    {
        return undefined;
        return;
    }

    logbadspawn( "Buddy Spawn" );
    return _ID28016( var_0[0], var_0 );
    return;
}

_ID27364( var_0, var_1 )
{
    var_2 = var_0[0];

    foreach ( var_4 in var_0 )
    {
        _ID27355( var_4, var_1 );

        if ( var_4.totalscore > var_2.totalscore )
            var_2 = var_4;
    }

    var_2 = _ID28016( var_2, var_0 );
    return var_2;
}

criticalfactors_awayfromenemies( var_0 )
{
    return criticalfactors_nearteam( var_0 );
}

_ID27355( var_0, var_1 )
{
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 2.0, maps\mp\gametypes\_spawnfactor::_ID4582, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 1.0, maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 1.0, maps\mp\gametypes\_spawnfactor::_ID24866, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 1.0, maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyenemies, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.25, maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.25, maps\mp\gametypes\_spawnfactor::avoidsamespawn, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
    var_2 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.25, maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyanyone, var_0 );
    var_0.totalscore = var_0.totalscore + var_2;
}

_ID15347( var_0 )
{
    var_0 = checkdynamicspawns( var_0 );
    var_1["primary"] = [];
    var_1["secondary"] = [];
    var_1["bad"] = [];

    foreach ( var_3 in var_0 )
    {
        _ID17997( var_3 );
        var_4 = criticalfactors_safeguard( var_3 );
        var_1[var_4][var_1[var_4].size] = var_3;
    }

    if ( var_1["primary"].size )
        return _ID27368( var_1["primary"] );

    if ( var_1["secondary"].size )
        return _ID27368( var_1["secondary"] );

    logbadspawn( "Buddy Spawn" );
    return _ID28016( var_0[0], var_0 );
}

_ID27368( var_0 )
{
    var_1 = var_0[0];

    foreach ( var_3 in var_0 )
    {
        _ID27359( var_3 );

        if ( var_3.totalscore > var_1.totalscore )
            var_1 = var_3;
    }

    var_1 = _ID28016( var_1, var_0 );
    return var_1;
}

criticalfactors_safeguard( var_0 )
{
    return criticalfactors_nearteam( var_0 );
}

_ID27359( var_0 )
{
    var_1 = maps\mp\gametypes\_spawnfactor::_ID27354( 1.0, maps\mp\gametypes\_spawnfactor::_ID25410, var_0 );
    var_0.totalscore = var_0.totalscore + var_1;
    var_1 = maps\mp\gametypes\_spawnfactor::_ID27354( 1.0, maps\mp\gametypes\_spawnfactor::_ID24866, var_0 );
    var_0.totalscore = var_0.totalscore + var_1;
    var_1 = maps\mp\gametypes\_spawnfactor::_ID27354( 0.5, maps\mp\gametypes\_spawnfactor::_ID4582, var_0 );
    var_0.totalscore = var_0.totalscore + var_1;
}

logbadspawn( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "";
    else
        var_0 = "(" + var_0 + ")";

    if ( isdefined( level.matchrecording_logeventmsg ) )
    {
        [[ level.matchrecording_logeventmsg ]]( "LOG_BAD_SPAWN", gettime(), var_0 );
        return;
    }
}
