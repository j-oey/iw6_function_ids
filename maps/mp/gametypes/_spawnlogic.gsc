// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level.killstreakspawnshield = 5000;
    level._ID13508 = 0;
    level._ID32096 = 1;
    level._ID30895 = ( 0, 0, 0 );
    level._ID30893 = ( 0, 0, 0 );
    level.clienttracespawnclass = undefined;
    level.disableclientspawntraces = 0;
    level._ID22416 = 0;
    level._ID22415 = 0;
    level.players = [];
    level._ID23303 = [];
    level.characters = [];
    level.spawnpointarray = [];
    level.grenades = [];
    level._ID21199 = [];
    level._ID6711 = [];
    level._ID16755 = [];
    level._ID34099 = [];
    level._ID32558 = [];
    level._ID27392 = [];
    level._ID17442 = [];
    level._ID34171 = [];
    level.balldrones = [];
    level thread _ID22877();
    level thread spawnpointupdate();
    level thread _ID33300();
    level thread _ID33319();
    level thread _ID33297();
    level thread _ID33301();

    if ( getdvarint( "scr_frontlineSpawns", 0 ) == 1 )
    {
        if ( level._ID14086 == "war" || level._ID14086 == "conf" || level._ID14086 == "cranked" )
            level thread maps\mp\gametypes\_spawnfactor::spawnfrontlinethink();
    }
    else
    {
        var_0 = int( getdvar( "scr_anchorSpawns" ) );

        if ( level._ID14086 == "war" || level._ID14086 == "conf" || level._ID14086 == "cranked" )
            level thread maps\mp\gametypes\_spawnfactor::_ID36999();
    }

    for ( var_1 = 0; var_1 < level._ID32668.size; var_1++ )
        level._ID32679[level._ID32668[var_1]] = [];

    maps\mp\gametypes\_spawnfactor::_ID37479();
}

_ID33301()
{
    for (;;)
    {
        self waittill( "host_migration_end" );

        foreach ( var_1 in level._ID23303 )
            var_1.canperformclienttraces = canperformclienttraces( var_1 );
    }
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        level thread _ID31428( var_0 );
        level thread _ID12559( var_0 );
    }
}

_ID12559( var_0 )
{
    var_0 endon( "disconnect" );

    for (;;)
    {
        if ( var_0.sessionstate == "playing" && maps\mp\_utility::_ID18757( var_0 ) && !var_0 maps\mp\_utility::_hasperk( "specialty_gpsjammer" ) )
        {
            var_1 = 0;
            var_2 = var_0 getplayerssightingme();

            foreach ( var_4 in var_2 )
            {
                if ( level._ID32653 && var_4.team == var_0.team )
                    continue;

                if ( var_0.sessionstate != "playing" || !maps\mp\_utility::_ID18757( var_0 ) )
                    continue;

                var_1 = 1;
                var_0 notify( "eyesOn" );
                break;
            }

            var_0 markforeyeson( var_1 );
        }
        else
        {
            var_0 markforeyeson( 0 );
            var_0 notify( "eyesOff" );
        }

        wait 0.05;
    }
}

_ID31428( var_0 )
{
    var_0 endon( "disconnect" );
    var_0.canperformclienttraces = canperformclienttraces( var_0 );

    if ( !var_0.canperformclienttraces )
        return;

    wait 0.05;
    var_0 setclientspawnsighttraces( level.clienttracespawnclass );
}

canperformclienttraces( var_0 )
{
    if ( level.disableclientspawntraces )
        return 0;

    if ( !isdefined( level.clienttracespawnclass ) )
        return 0;

    if ( isai( var_0 ) )
        return 0;

    if ( var_0 ishost() )
        return 0;

    return 1;
}

addstartspawnpoints( var_0 )
{
    var_1 = _ID15350( var_0 );

    if ( !var_1.size )
        return;

    if ( !isdefined( level._ID31475 ) )
        level._ID31475 = [];

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_1[var_2] _ID30904();
        var_1[var_2]._ID28018 = 0;
        level._ID31475[level._ID31475.size] = var_1[var_2];
    }

    foreach ( var_4 in var_1 )
    {
        var_4.infront = 1;
        var_5 = anglestoforward( var_4.angles );

        foreach ( var_7 in var_1 )
        {
            if ( var_4 == var_7 )
                continue;

            var_8 = vectornormalize( var_7.origin - var_4.origin );
            var_9 = vectordot( var_5, var_8 );

            if ( var_9 > 0.86 )
            {
                var_4.infront = 0;
                break;
            }
        }
    }
}

addspawnpoints( var_0, var_1, var_2 )
{
    if ( !isdefined( level.spawnpoints ) )
        level.spawnpoints = [];

    if ( !isdefined( level._ID32679[var_0] ) )
        level._ID32679[var_0] = [];

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_3 = [];
    var_3 = _ID15350( var_1 );

    if ( !isdefined( level.clienttracespawnclass ) )
        level.clienttracespawnclass = var_1;

    if ( !var_3.size && !var_2 )
        return;

    foreach ( var_5 in var_3 )
    {
        if ( !isdefined( var_5._ID17930 ) )
        {
            var_5 _ID30904();
            level.spawnpoints[level.spawnpoints.size] = var_5;
        }

        level._ID32679[var_0][level._ID32679[var_0].size] = var_5;
    }
}

_ID30904()
{
    var_0 = self;
    level._ID30895 = _ID12450( level._ID30895, var_0.origin );
    level._ID30893 = _ID12449( level._ID30893, var_0.origin );
    var_0.forward = anglestoforward( var_0.angles );
    var_0._ID30031 = var_0.origin + ( 0, 0, 50 );
    var_0.lastspawntime = gettime();
    var_0._ID23137 = 1;
    var_0._ID17930 = 1;
    var_0.alternates = [];
    var_1 = 1024;

    if ( !bullettracepassed( var_0._ID30031, var_0._ID30031 + ( 0, 0, var_1 ), 0, undefined ) )
    {
        var_2 = var_0._ID30031 + var_0.forward * 100;

        if ( !bullettracepassed( var_2, var_2 + ( 0, 0, var_1 ), 0, undefined ) )
            var_0._ID23137 = 0;
    }

    var_3 = anglestoright( var_0.angles );
    addalternatespawnpoint( var_0, var_0.origin + var_3 * 45 );
    addalternatespawnpoint( var_0, var_0.origin - var_3 * 45 );
    _ID17999( var_0 );
}

addalternatespawnpoint( var_0, var_1 )
{
    var_2 = playerphysicstrace( var_0.origin, var_0.origin + ( 0, 0, 18 ), 0, undefined );
    var_3 = var_2[2] - var_0.origin[2];
    var_4 = ( var_1[0], var_1[1], var_1[2] + var_3 );
    var_5 = playerphysicstrace( var_2, var_4, 0, undefined );

    if ( var_5 != var_4 )
        return;

    var_6 = playerphysicstrace( var_4, var_1 );
    var_0.alternates[var_0.alternates.size] = var_6;
}

_ID15350( var_0 )
{
    if ( !isdefined( level.spawnpointarray ) )
        level.spawnpointarray = [];

    if ( !isdefined( level.spawnpointarray[var_0] ) )
    {
        level.spawnpointarray[var_0] = [];
        level.spawnpointarray[var_0] = getspawnarray( var_0 );

        foreach ( var_2 in level.spawnpointarray[var_0] )
            var_2.classname = var_0;
    }

    return level.spawnpointarray[var_0];
}

_ID15346( var_0 )
{
    if ( !isdefined( var_0 ) )
        return undefined;

    var_1 = undefined;
    var_0 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns( var_0 );
    var_0 = common_scripts\utility::array_randomize( var_0 );

    foreach ( var_3 in var_0 )
    {
        var_1 = var_3;

        if ( canspawn( var_1.origin ) && !positionwouldtelefrag( var_1.origin ) )
            break;
    }

    return var_1;
}

_ID15349( var_0 )
{
    if ( !isdefined( var_0 ) )
        return undefined;

    var_1 = undefined;
    var_0 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns( var_0 );

    foreach ( var_3 in var_0 )
    {
        if ( var_3._ID28018 )
            continue;

        if ( var_3.infront )
        {
            var_1 = var_3;
            break;
        }

        var_1 = var_3;
    }

    if ( !isdefined( var_1 ) )
        var_1 = _ID15346( var_0 );

    var_1._ID28018 = 1;
    return var_1;
}

_ID15345( var_0, var_1 )
{
    for (;;)
        wait 5;
}

_ID33300()
{
    for (;;)
    {
        level.grenades = getentarray( "grenade", "classname" );
        wait 0.05;
    }
}

_ID33319()
{
    for (;;)
    {
        level._ID21199 = getentarray( "rocket", "classname" );
        wait 0.05;
    }
}

_ID33297()
{
    for (;;)
    {
        level._ID6711 = getentarray( "care_package", "targetname" );
        wait 0.05;
    }
}

_ID15425( var_0 )
{
    return level._ID32679[var_0];
}

_ID18728()
{
    if ( !isdefined( level.pathdataavailable ) )
    {
        var_0 = getallnodes();
        level.pathdataavailable = isdefined( var_0 ) && var_0.size > 150;
    }

    return level.pathdataavailable;
}

addtoparticipantsarray()
{
    level._ID23303[level._ID23303.size] = self;
}

_ID26002()
{
    var_0 = 0;

    for ( var_1 = 0; var_1 < level._ID23303.size; var_1++ )
    {
        if ( level._ID23303[var_1] == self )
        {
            for ( var_0 = 1; var_1 < level._ID23303.size - 1; var_1++ )
                level._ID23303[var_1] = level._ID23303[var_1 + 1];

            level._ID23303[var_1] = undefined;
            break;
        }
    }
}

addtocharactersarray()
{
    if ( maps\mp\_utility::_ID18363() )
    {
        for ( var_0 = 0; var_0 < level.characters.size; var_0++ )
        {
            if ( level.characters[var_0] == self )
                return;
        }
    }

    level.characters[level.characters.size] = self;
}

_ID25996()
{
    var_0 = 0;

    for ( var_1 = 0; var_1 < level.characters.size; var_1++ )
    {
        if ( level.characters[var_1] == self )
        {
            for ( var_0 = 1; var_1 < level.characters.size - 1; var_1++ )
                level.characters[var_1] = level.characters[var_1 + 1];

            level.characters[var_1] = undefined;
            break;
        }
    }
}

spawnpointupdate()
{
    while ( !isdefined( level.spawnpoints ) || level.spawnpoints.size == 0 )
        wait 0.05;

    level thread _ID30906();
    level thread _ID30903();

    for (;;)
    {
        level.disableclientspawntraces = getdvarint( "scr_disableClientSpawnTraces" ) > 0;
        wait 0.05;
    }
}

getactiveplayerlist()
{
    var_0 = [];

    foreach ( var_2 in level.characters )
    {
        if ( !maps\mp\_utility::_ID18757( var_2 ) )
            continue;

        if ( isplayer( var_2 ) && var_2.sessionstate != "playing" )
            continue;

        if ( var_2 maps\mp\killstreaks\_killstreaks::_ID18836() && isdefined( var_2.chopper ) && ( !isdefined( var_2.chopper.movedlow ) || !var_2.chopper.movedlow ) )
            continue;

        var_2.spawnlogicteam = getspawnteam( var_2 );

        if ( var_2.spawnlogicteam == "spectator" )
            continue;

        if ( isagent( var_2 ) && var_2.agent_type == "dog" )
        {
            var_2._ID30892 = getplayertraceheight( var_2, 1 );
            var_2.spawntracelocation = var_2.origin + ( 0, 0, var_2._ID30892 );
        }
        else if ( !var_2.canperformclienttraces )
        {
            var_3 = getplayertraceheight( var_2 );
            var_4 = var_2 geteye();
            var_4 = ( var_4[0], var_4[1], var_2.origin[2] + var_3 );
            var_2._ID30892 = var_3;
            var_2.spawntracelocation = var_4;
        }

        var_0[var_0.size] = var_2;
    }

    return var_0;
}

_ID30906()
{
    var_0 = 18;
    var_1 = 0;
    var_2 = 0;
    var_3 = getactiveplayerlist();

    for (;;)
    {
        if ( var_2 )
        {
            wait 0.05;
            var_1 = 0;
            var_2 = 0;
            var_3 = getactiveplayerlist();
        }

        var_4 = level.spawnpoints;
        var_4 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns( var_4 );
        var_2 = 1;

        foreach ( var_6 in var_4 )
        {
            _ID7508( var_6 );

            foreach ( var_8 in var_3 )
            {
                if ( var_6._ID13732[var_8.spawnlogicteam] )
                    continue;

                if ( var_8.canperformclienttraces )
                    var_9 = var_8 clientspawnsighttracepassed( var_6.index );
                else
                {
                    var_9 = spawnsighttrace( var_6, var_6.origin + ( 0, 0, var_8._ID30892 ), var_8.spawntracelocation );
                    var_1++;
                }

                if ( !var_9 )
                    continue;

                if ( var_9 > 0.95 )
                {
                    var_6._ID13732[var_8.spawnlogicteam]++;
                    continue;
                }

                var_6.cornersights[var_8.spawnlogicteam]++;
            }

            additionalsighttraceentities( var_6, level._ID34099 );
            additionalsighttraceentities( var_6, level._ID34171 );

            if ( _ID29890( var_0, var_1 ) )
            {
                wait 0.05;
                var_1 = 0;
                var_2 = 0;
                var_3 = getactiveplayerlist();
            }
        }
    }
}

_ID29890( var_0, var_1 )
{
    var_2 = 0;

    foreach ( var_4 in level._ID23303 )
    {
        if ( !var_4.canperformclienttraces )
            var_2++;
    }

    if ( var_1 + var_2 > var_0 )
        return 1;

    return 0;
}

_ID30903()
{
    var_0 = getactiveplayerlist();
    var_1 = gettime();
    var_2 = 4;
    var_3 = 0;

    for (;;)
    {
        var_4 = level.spawnpoints;
        var_4 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns( var_4 );

        foreach ( var_6 in var_4 )
        {
            clearspawnpointdistancedata( var_6 );
            var_3++;

            foreach ( var_8 in var_0 )
            {
                var_9 = distancesquared( var_8.origin, var_6.origin );

                if ( var_9 < var_6._ID21046[var_8.spawnlogicteam] )
                    var_6._ID21046[var_8.spawnlogicteam] = var_9;

                if ( var_8.spawnlogicteam == "spectator" )
                    continue;

                var_6._ID10251[var_8.spawnlogicteam] = var_6._ID10251[var_8.spawnlogicteam] + var_9;
                var_6.distsumsquaredcapped[var_8.spawnlogicteam] = var_6.distsumsquaredcapped[var_8.spawnlogicteam] + min( var_9, maps\mp\gametypes\_spawnfactor::maxplayerspawninfluencedistsquared() );
                var_6._ID33157[var_8.spawnlogicteam]++;
            }

            if ( isdefined( level._ID36704 ) )
            {
                var_11 = 25;

                for ( var_12 = 0; var_12 < var_11; var_12++ )
                {
                    var_9 = distancesquared( level._ID36704, var_6.origin );
                    var_6._ID33157["allies"]++;
                    var_6._ID10251["allies"] = var_6._ID10251["allies"] + var_9;
                    var_6.distsumsquaredcapped["allies"] = var_6.distsumsquaredcapped["allies"] + var_9;
                    var_9 = distancesquared( level._ID36760, var_6.origin );
                    var_6._ID33157["axis"]++;
                    var_6._ID10251["axis"] = var_6._ID10251["axis"] + var_9;
                    var_6.distsumsquaredcapped["axis"] = var_6.distsumsquaredcapped["axis"] + var_9;
                }
            }

            if ( var_3 == var_2 )
            {
                wait 0.05;
                var_0 = getactiveplayerlist();
                var_1 = gettime();
                var_3 = 0;
            }
        }
    }
}

getspawnteam( var_0 )
{
    var_1 = "all";

    if ( level._ID32653 )
        var_1 = var_0.team;

    return var_1;
}

_ID17999( var_0 )
{
    _ID7508( var_0 );
    clearspawnpointdistancedata( var_0 );
}

_ID7508( var_0 )
{
    if ( level._ID32653 )
    {
        foreach ( var_2 in level._ID32668 )
            clearteamspawnpointsightdata( var_0, var_2 );

        return;
    }

    clearteamspawnpointsightdata( var_0, "all" );
    return;
}

clearspawnpointdistancedata( var_0 )
{
    if ( level._ID32653 )
    {
        foreach ( var_2 in level._ID32668 )
            _ID7509( var_0, var_2 );

        return;
    }

    _ID7509( var_0, "all" );
    return;
}

clearteamspawnpointsightdata( var_0, var_1 )
{
    var_0._ID13732[var_1] = 0;
    var_0.cornersights[var_1] = 0;
}

_ID7509( var_0, var_1 )
{
    var_0._ID10251[var_1] = 0;
    var_0.distsumsquaredcapped[var_1] = 0;
    var_0._ID21046[var_1] = 9999999;
    var_0._ID33157[var_1] = 0;
}

getplayertraceheight( var_0, var_1 )
{
    if ( isdefined( var_1 ) && var_1 )
        return 64;

    var_2 = var_0 getstance();

    if ( var_2 == "stand" )
        return 64;

    if ( var_2 == "crouch" )
        return 44;

    return 32;
}

additionalsighttraceentities( var_0, var_1 )
{
    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3 ) )
            continue;

        var_4 = getspawnteam( var_3 );

        if ( var_0._ID13732[var_4] )
            continue;

        var_5 = spawnsighttrace( var_0, var_0._ID30031, var_3.origin + ( 0, 0, 50 ) );

        if ( !var_5 )
            continue;

        if ( var_5 > 0.95 )
        {
            var_0._ID13732[var_4]++;
            continue;
        }

        var_0.cornersights[var_4]++;
    }
}

_ID12871( var_0 )
{
    var_1 = gettime();
    self._ID19613 = var_0;
    self.lastspawntime = var_1;
    var_0.lastspawntime = var_1;
    var_0.lastspawnteam = self.team;
}

_ID12451( var_0 )
{
    var_1 = _ID15350( var_0 );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        level._ID30895 = _ID12450( level._ID30895, var_1[var_2].origin );
        level._ID30893 = _ID12449( level._ID30893, var_1[var_2].origin );
    }
}

_ID12450( var_0, var_1 )
{
    if ( var_0[0] > var_1[0] )
        var_0 = ( var_1[0], var_0[1], var_0[2] );

    if ( var_0[1] > var_1[1] )
        var_0 = ( var_0[0], var_1[1], var_0[2] );

    if ( var_0[2] > var_1[2] )
        var_0 = ( var_0[0], var_0[1], var_1[2] );

    return var_0;
}

_ID12449( var_0, var_1 )
{
    if ( var_0[0] < var_1[0] )
        var_0 = ( var_1[0], var_0[1], var_0[2] );

    if ( var_0[1] < var_1[1] )
        var_0 = ( var_0[0], var_1[1], var_0[2] );

    if ( var_0[2] < var_1[2] )
        var_0 = ( var_0[0], var_0[1], var_1[2] );

    return var_0;
}

findboxcenter( var_0, var_1 )
{
    var_2 = ( 0, 0, 0 );
    var_2 = var_1 - var_0;
    var_2 = ( var_2[0] / 2, var_2[1] / 2, var_2[2] / 2 ) + var_0;
    return var_2;
}

setmapcenterfordev()
{
    level._ID30895 = ( 0, 0, 0 );
    level._ID30893 = ( 0, 0, 0 );
    _ID12451( "mp_tdm_spawn_allies_start" );
    _ID12451( "mp_tdm_spawn_axis_start" );
    level._ID20634 = findboxcenter( level._ID30895, level._ID30893 );
    setmapcenter( level._ID20634 );
}

_ID38029()
{
    return level._ID17628 && ( !isdefined( level._ID22412 ) || level._ID22412 == 0 );
}
