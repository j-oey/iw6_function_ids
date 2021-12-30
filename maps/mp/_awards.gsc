// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    _ID17904();
    level thread _ID22877();
    level thread monitormovementdistance();
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );

        if ( !isdefined( var_0.pers["stats"] ) )
            var_0.pers["stats"] = [];

        var_0._ID31525 = var_0.pers["stats"];

        if ( !var_0._ID31525.size )
        {
            var_0 setcommonplayerdata( "round", "awardCount", 0 );

            foreach ( var_3, var_2 in level.awards )
            {
                if ( isdefined( level.awards[var_3]._ID9411 ) )
                {
                    var_0 maps\mp\_utility::initplayerstat( var_3, level.awards[var_3]._ID9411 );
                    continue;
                }

                var_0 maps\mp\_utility::initplayerstat( var_3 );
            }
        }

        var_0._ID24949 = var_0.origin;
        var_0._ID24940 = 0;
        var_0.altitudepolls = 0;
        var_0._ID33153 = 0;
        var_0._ID34744 = [];
        var_0 thread onplayerspawned();
        var_0 thread monitorpositioncamping();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "spawned_player" );
        thread _ID21431();
        thread _ID21440();
        thread _ID21455();
        thread _ID21382();
        thread _ID21439();
        thread _ID21390();
        thread _ID21452();
        thread _ID21447();
    }
}

_ID17904()
{
    if ( isdefined( level._ID17937 ) )
        [[ level._ID17937 ]]();

    _ID17902( "10kills", ::_ID18554, 10, "kills" );
    _ID17902( "1death", ::_ID18554, 1, "deaths" );
    _ID17902( "nodeaths", ::isatmost, 0, "deaths" );
    _ID17902( "nokills", ::isatmost, 0, "kills" );
    _ID17976( "mvp", "kills", "deaths" );
    _ID17976( "punisher", "kills", "killstreak" );
    _ID17976( "overkill", "kills", "headshots" );
    _ID18002( "kdratio", 0, ::highestwins );
    _ID18002( "kills", 0, ::highestwins );
    _ID18002( "higherrankkills", 0, ::highestwins );
    _ID18002( "deaths", 0, ::_ID20394 );
    _ID18002( "killstreak", 0, ::highestwins );
    _ID18002( "headshots", 0, ::highestwins );
    _ID18002( "closertoenemies", 0, ::highestwins );
    _ID18002( "throwingknifekills", 0, ::highestwins );
    _ID18002( "grenadekills", 0, ::highestwins );
    _ID18002( "helicopters", 0, ::highestwins );
    _ID18002( "airstrikes", 0, ::highestwins );
    _ID18002( "uavs", 0, ::highestwins );
    _ID18002( "mostmultikills", 0, ::highestwins );
    _ID18002( "multikill", 0, ::highestwins );
    _ID18002( "knifekills", 0, ::highestwins );
    _ID18002( "flankkills", 0, ::highestwins );
    _ID18002( "bulletpenkills", 0, ::highestwins );
    _ID18002( "laststandkills", 0, ::highestwins );
    _ID18002( "laststanderkills", 0, ::highestwins );
    _ID18002( "assists", 0, ::highestwins );
    _ID18002( "c4kills", 0, ::highestwins );
    _ID18002( "claymorekills", 0, ::highestwins );
    _ID18002( "fragkills", 0, ::highestwins );
    _ID18002( "semtexkills", 0, ::highestwins );
    _ID18002( "explosionssurvived", 0, ::highestwins );
    _ID18002( "mosttacprevented", 0, ::highestwins );
    _ID18002( "avengekills", 0, ::highestwins );
    _ID18002( "rescues", 0, ::highestwins );
    _ID18002( "longshots", 0, ::highestwins );
    _ID18002( "adskills", 0, ::highestwins );
    _ID18002( "hipfirekills", 0, ::highestwins );
    _ID18002( "revengekills", 0, ::highestwins );
    _ID18002( "longestlife", 0, ::highestwins );
    _ID18002( "throwbacks", 0, ::highestwins );
    _ID18002( "otherweaponkills", 0, ::highestwins );
    _ID18002( "killedsameplayer", 0, ::highestwins, 2 );
    _ID18002( "mostweaponsused", 0, ::highestwins, 3 );
    _ID18002( "distancetraveled", 0, ::highestwins );
    _ID18002( "mostreloads", 0, ::highestwins );
    _ID18002( "mostswaps", 0, ::highestwins );
    initstat( "flankdeaths", 0 );
    _ID18002( "thermalkills", 0, ::highestwins );
    _ID18002( "mostcamperkills", 0, ::highestwins );
    _ID18002( "fbhits", 0, ::highestwins );
    _ID18002( "stunhits", 0, ::highestwins );
    _ID18002( "scopedkills", 0, ::highestwins );
    _ID18002( "arkills", 0, ::highestwins );
    _ID18002( "arheadshots", 0, ::highestwins );
    _ID18002( "lmgkills", 0, ::highestwins );
    _ID18002( "lmgheadshots", 0, ::highestwins );
    _ID18002( "dmrkills", 0, ::highestwins );
    _ID18002( "sniperkills", 0, ::highestwins );
    _ID18002( "dmrheadshots", 0, ::highestwins );
    _ID18002( "sniperheadshots", 0, ::highestwins );
    _ID18002( "shieldblocks", 0, ::highestwins );
    _ID18002( "shieldkills", 0, ::highestwins );
    _ID18002( "smgkills", 0, ::highestwins );
    _ID18002( "smgheadshots", 0, ::highestwins );
    _ID18002( "shotgunkills", 0, ::highestwins );
    _ID18002( "shotgunheadshots", 0, ::highestwins );
    _ID18002( "pistolkills", 0, ::highestwins );
    _ID18002( "pistolheadshots", 0, ::highestwins );
    _ID18002( "rocketkills", 0, ::highestwins );
    _ID18002( "equipmentkills", 0, ::highestwins );
    _ID18002( "mostclasseschanged", 0, ::highestwins );
    _ID18002( "lowerrankkills", 0, ::highestwins );
    _ID18002( "sprinttime", 0, ::highestwins, 1 );
    _ID18002( "crouchtime", 0, ::highestwins );
    _ID18002( "pronetime", 0, ::highestwins );
    _ID18002( "comebacks", 0, ::highestwins );
    _ID18002( "mostshotsfired", 0, ::highestwins );
    _ID18002( "timeinspot", 0, ::highestwins );
    _ID18002( "killcamtimewatched", 0, ::highestwins );
    _ID18002( "greatestavgalt", 0, ::highestwins );
    _ID18002( "leastavgalt", 9999999, ::_ID20393 );
    _ID18002( "weaponxpearned", 0, ::highestwins );
    _ID18002( "assaultkillstreaksused", 0, ::highestwins );
    _ID18002( "supportkillstreaksused", 0, ::highestwins );
    _ID18002( "specialistkillstreaksearned", 0, ::highestwins );
    _ID18002( "killsconfirmed", 0, ::highestwins );
    _ID18002( "killsdenied", 0, ::highestwins );
    _ID18002( "holdingteamdefenderflag", 0, ::highestwins );
    _ID18002( "damagedone", 0, ::highestwins );
    _ID18002( "damagetaken", 0, ::_ID20393 );

    if ( !maps\mp\_utility::_ID20673() )
    {
        _ID18002( "killcamskipped", 0, ::highestwins );
        _ID18002( "killsteals", 0, ::highestwins );
        _ID18002( "shortestlife", 9999999, ::_ID20393 );
        _ID18002( "suicides", 0, ::highestwins );
        _ID18002( "mostff", 0, ::highestwins );
        _ID18002( "shotgundeaths", 0, ::highestwins );
        _ID18002( "shielddeaths", 0, ::highestwins );
        _ID18002( "flankdeaths", 0, ::highestwins );
    }
}

initbaseaward( var_0 )
{
    level.awards[var_0] = spawnstruct();
    level.awards[var_0].winners = [];
    level.awards[var_0].exclusive = 1;
}

_ID17903( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_1 ) )
        level.awards[var_0].process = var_1;

    if ( isdefined( var_2 ) )
        level.awards[var_0]._ID34888 = var_2;

    if ( isdefined( var_3 ) )
        level.awards[var_0]._ID34889 = var_3;
}

initstat( var_0, var_1 )
{
    initbaseaward( var_0 );
    level.awards[var_0]._ID9411 = var_1;
    level.awards[var_0].type = "stat";
}

_ID18002( var_0, var_1, var_2, var_3, var_4 )
{
    initbaseaward( var_0 );
    _ID17903( var_0, var_2, var_3, var_4 );
    level.awards[var_0]._ID9411 = var_1;
    level.awards[var_0].type = "stat";
}

_ID17919( var_0, var_1, var_2, var_3 )
{
    initbaseaward( var_0 );
    _ID17903( var_0, var_1, var_2, var_3 );
    level.awards[var_0].type = "derived";
}

_ID17902( var_0, var_1, var_2, var_3 )
{
    initbaseaward( var_0 );
    _ID17903( var_0, var_1, var_2, var_3 );
    level.awards[var_0].type = "flag";
}

_ID17976( var_0, var_1, var_2 )
{
    initbaseaward( var_0 );
    level.awards[var_0].award1_ref = var_1;
    level.awards[var_0].award2_ref = var_2;
    level.awards[var_0].type = "multi";
}

_ID18008( var_0, var_1, var_2, var_3 )
{
    initbaseaward( var_0 );
    _ID17903( var_0, var_1, var_2, var_3 );
    level.awards[var_0].type = "threshold";
}

_ID28778( var_0 )
{
    var_1 = maps\mp\_utility::getplayerstat( var_0 );
    var_2 = maps\mp\_utility::_ID15260( var_0 );
    var_3 = getawardrecord( var_0 );
    var_4 = _ID14899( var_0 );

    if ( !isdefined( var_3 ) || var_1 > var_3 )
    {
        clearawardwinners( var_0 );
        addawardwinner( var_0, self.clientid );
        _ID28648( var_0, var_1, var_2 );
    }
    else if ( var_1 == var_3 )
    {
        if ( isawardexclusive( var_0 ) )
        {
            if ( !isdefined( var_4 ) || var_2 < var_4 )
            {
                clearawardwinners( var_0 );
                addawardwinner( var_0, self.clientid );
                _ID28648( var_0, var_1, var_2 );
            }
        }
        else
            addawardwinner( var_0, self.clientid );
    }
}

setmatchrecordiflower( var_0 )
{
    var_1 = maps\mp\_utility::getplayerstat( var_0 );
    var_2 = maps\mp\_utility::_ID15260( var_0 );
    var_3 = getawardrecord( var_0 );
    var_4 = _ID14899( var_0 );

    if ( !isdefined( var_3 ) || var_1 < var_3 )
    {
        clearawardwinners( var_0 );
        addawardwinner( var_0, self.clientid );
        _ID28648( var_0, var_1, var_2 );
    }
    else if ( var_1 == var_3 )
    {
        if ( isawardexclusive( var_0 ) )
        {
            if ( !isdefined( var_4 ) || var_2 < var_4 )
            {
                clearawardwinners( var_0 );
                addawardwinner( var_0, self.clientid );
                _ID28648( var_0, var_1, var_2 );
            }
        }
        else
            addawardwinner( var_0, self.clientid );
    }
}

_ID14968( var_0 )
{
    var_1 = getratioloval( var_0 );
    var_2 = getratiohival( var_0 );

    if ( !var_1 )
        return var_2 + 0.001;

    return var_2 / var_1;
}

_ID28817( var_0 )
{
    var_1 = self getcommonplayerdata( "bests", var_0 );
    var_2 = maps\mp\_utility::getplayerstat( var_0 );

    if ( var_1 == 0 || var_2 > var_1 )
    {
        var_2 = _ID15026( var_0, var_2 );
        self setcommonplayerdata( "bests", var_0, var_2 );
    }
}

_ID28818( var_0 )
{
    var_1 = self getcommonplayerdata( "bests", var_0 );
    var_2 = maps\mp\_utility::getplayerstat( var_0 );

    if ( var_1 == 0 || var_2 < var_1 )
    {
        var_2 = _ID15026( var_0, var_2 );
        self setcommonplayerdata( "bests", var_0, var_2 );
    }
}

_ID17530( var_0 )
{
    var_1 = self getcommonplayerdata( "awards", var_0 );
    self setcommonplayerdata( "awards", var_0, var_1 + 1 );
}

addawardwinner( var_0, var_1 )
{
    foreach ( var_3 in level.awards[var_0].winners )
    {
        if ( var_3 == var_1 )
            return;
    }

    level.awards[var_0].winners[level.awards[var_0].winners.size] = var_1;
}

getawardwinners( var_0 )
{
    return level.awards[var_0].winners;
}

clearawardwinners( var_0 )
{
    level.awards[var_0].winners = [];
}

_ID28648( var_0, var_1, var_2 )
{
    level.awards[var_0]._ID34844 = var_1;
    level.awards[var_0]._ID33037 = var_2;
}

getawardrecord( var_0 )
{
    return level.awards[var_0]._ID34844;
}

_ID14899( var_0 )
{
    return level.awards[var_0]._ID33037;
}

assignawards()
{
    foreach ( var_1 in level.players )
    {
        if ( !var_1 maps\mp\_utility::_ID25420() )
            return;

        var_2 = var_1 maps\mp\_utility::getplayerstat( "kills" );
        var_3 = var_1 maps\mp\_utility::getplayerstat( "deaths" );

        if ( var_3 == 0 )
            var_3 = 1;

        var_1 maps\mp\_utility::_ID28832( "kdratio", var_2 / var_3 );

        if ( isalive( var_1 ) )
        {
            var_4 = gettime() - var_1._ID30916;
            var_1 maps\mp\_utility::_ID28833( "longestlife", var_4 );
        }
    }

    foreach ( var_11, var_7 in level.awards )
    {
        if ( !isdefined( level.awards[var_11].process ) )
            continue;

        var_8 = level.awards[var_11].process;
        var_9 = level.awards[var_11]._ID34888;
        var_10 = level.awards[var_11]._ID34889;

        if ( isdefined( var_9 ) && isdefined( var_10 ) )
        {
            [[ var_8 ]]( var_11, var_9, var_10 );
            continue;
        }

        if ( isdefined( var_9 ) )
        {
            [[ var_8 ]]( var_11, var_9 );
            continue;
        }

        [[ var_8 ]]( var_11 );
    }

    foreach ( var_11, var_7 in level.awards )
    {
        if ( !_ID18708( var_11 ) )
            continue;

        var_13 = level.awards[var_11].award1_ref;
        var_14 = level.awards[var_11].award2_ref;
        var_15 = getawardwinners( var_13 );
        var_16 = getawardwinners( var_14 );

        if ( !isdefined( var_15 ) || !isdefined( var_16 ) )
            continue;

        foreach ( var_18 in var_15 )
        {
            foreach ( var_20 in var_16 )
            {
                if ( var_18 == var_20 )
                {
                    addawardwinner( var_11, var_18 );
                    var_1 = maps\mp\_utility::_ID24491( var_18 );
                    var_21 = var_1 maps\mp\_utility::getplayerstat( var_13 );
                    var_22 = var_1 maps\mp\_utility::getplayerstat( var_14 );
                    var_1 maps\mp\_utility::_ID28832( var_11, encoderatio( var_21, var_22 ) );
                }
            }
        }
    }

    foreach ( var_11, var_7 in level.awards )
    {
        if ( !isawardflag( var_11 ) )
            assignaward( var_11 );
    }

    foreach ( var_1 in level.players )
    {
        var_27 = var_1 getcommonplayerdata( "round", "awardCount" );

        for ( var_28 = 0; var_28 < var_27 && var_28 < 3; var_28++ )
        {
            var_7 = var_1 getcommonplayerdata( "round", "awards", var_28, "award" );
            var_29 = var_1 getcommonplayerdata( "round", "awards", var_28, "value" );
        }
    }
}

assignaward( var_0 )
{
    var_1 = getawardwinners( var_0 );

    if ( !isdefined( var_1 ) )
        return;

    foreach ( var_3 in var_1 )
    {
        foreach ( var_5 in level.players )
        {
            if ( var_5.clientid == var_3 )
                var_5 _ID15581( var_0 );
        }
    }
}

getawardtype( var_0 )
{
    if ( isdefined( level.awards[var_0].type ) )
        return level.awards[var_0].type;
    else
        return "none";
}

_ID18708( var_0 )
{
    return getawardtype( var_0 ) == "multi";
}

_ID18799( var_0 )
{
    return getawardtype( var_0 ) == "stat";
}

isthresholdaward( var_0 )
{
    return getawardtype( var_0 ) == "threshold";
}

isawardflag( var_0 )
{
    return getawardtype( var_0 ) == "flag";
}

isawardexclusive( var_0 )
{
    if ( isdefined( level.awards[var_0].exclusive ) )
        return level.awards[var_0].exclusive;
    else
        return 1;
}

hasdisplayvalue( var_0 )
{
    var_1 = getawardtype( var_0 );

    switch ( var_1 )
    {
        case "derived":
            var_2 = 0;
            break;
        case "stat":
        case "multi":
        default:
            var_2 = 1;
            break;
    }

    return var_2;
}

_ID15581( var_0 )
{
    var_1 = self getcommonplayerdata( "round", "awardCount" );
    _ID17530( var_0 );

    if ( hasdisplayvalue( var_0 ) )
    {
        if ( _ID18799( var_0 ) )
        {

        }

        var_2 = maps\mp\_utility::getplayerstat( var_0 );
    }
    else
        var_2 = 1;

    var_2 = _ID15026( var_0, var_2 );

    if ( var_1 < 5 )
    {
        self setcommonplayerdata( "round", "awards", var_1, "award", var_0 );
        self setcommonplayerdata( "round", "awards", var_1, "value", var_2 );
    }

    var_1++;
    self setcommonplayerdata( "round", "awardCount", var_1 );
    maps\mp\_matchdata::logaward( var_0 );

    if ( var_1 == 1 )
        maps\mp\_highlights::givehighlight( var_0, var_2 );
}

_ID15026( var_0, var_1 )
{
    var_2 = tablelookup( "mp/awardTable.csv", 1, var_0, 7 );

    switch ( var_2 )
    {
        case "float":
            var_1 = maps\mp\_utility::_ID19987( var_1, 2 );
            var_1 *= 100;
            break;
        case "none":
        case "distance":
        case "count":
        case "time":
        case "multi":
        case "ratio":
        default:
            break;
    }

    var_1 = int( var_1 );
    return var_1;
}

highestwins( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        if ( var_3 maps\mp\_utility::_ID25420() && var_3 _ID31532( var_0 ) && ( !isdefined( var_1 ) || var_3 maps\mp\_utility::getplayerstat( var_0 ) >= var_1 ) )
        {
            var_3 _ID28778( var_0 );

            if ( !isawardflag( var_0 ) )
                var_3 _ID28817( var_0 );
        }
    }
}

_ID20393( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        if ( var_3 maps\mp\_utility::_ID25420() && var_3 _ID31532( var_0 ) && ( !isdefined( var_1 ) || var_3 maps\mp\_utility::getplayerstat( var_0 ) <= var_1 ) )
        {
            var_3 setmatchrecordiflower( var_0 );

            if ( !isawardflag( var_0 ) )
                var_3 _ID28818( var_0 );
        }
    }
}

_ID20394( var_0 )
{
    var_1 = maps\mp\_utility::_ID15435() / 1000;
    var_2 = var_1 * 0.5;

    foreach ( var_4 in level.players )
    {
        if ( var_4.hasspawned && var_4._ID33067["total"] >= var_2 )
        {
            var_4 setmatchrecordiflower( var_0 );

            if ( !isawardflag( var_0 ) )
                var_4 _ID28818( var_0 );
        }
    }
}

_ID31532( var_0 )
{
    var_1 = maps\mp\_utility::getplayerstat( var_0 );
    var_2 = level.awards[var_0]._ID9411;

    if ( var_1 == var_2 )
        return 0;
    else
        return 1;
}

_ID18554( var_0, var_1, var_2 )
{
    foreach ( var_4 in level.players )
    {
        var_5 = var_4 maps\mp\_utility::getplayerstat( var_2 );
        var_6 = var_5;

        if ( var_6 >= var_1 )
            addawardwinner( var_0, var_4.clientid );

        if ( isthresholdaward( var_0 ) || isawardflag( var_0 ) )
            var_4 maps\mp\_utility::_ID28832( var_0, var_5 );
    }
}

isatmost( var_0, var_1, var_2 )
{
    foreach ( var_4 in level.players )
    {
        var_5 = var_4 maps\mp\_utility::getplayerstat( var_2 );

        if ( var_5 <= var_1 )
            addawardwinner( var_0, var_4.clientid );
    }
}

_ID18556( var_0, var_1, var_2 )
{
    var_3 = maps\mp\_utility::_ID15435() / 1000;
    var_4 = var_3 * 0.5;

    foreach ( var_6 in level.players )
    {
        if ( var_6.hasspawned && var_6._ID33067["total"] >= var_4 )
        {
            var_7 = var_6 maps\mp\_utility::getplayerstat( var_2 );

            if ( var_7 <= var_1 )
                addawardwinner( var_0, var_6.clientid );
        }
    }
}

_ID28846( var_0, var_1, var_2 )
{
    foreach ( var_4 in level.players )
    {
        var_5 = var_4 maps\mp\_utility::getplayerstat( var_1 );
        var_6 = var_4 maps\mp\_utility::getplayerstat( var_2 );

        if ( var_6 == 0 )
        {
            var_4 maps\mp\_utility::_ID28832( var_0, var_5 );
            continue;
        }

        var_7 = var_5 / var_6;
        var_4 maps\mp\_utility::_ID28832( var_0, var_7 );
    }
}

getkillstreakawardref( var_0 )
{
    switch ( var_0 )
    {
        case "uav":
        case "uav_support":
        case "directional_uav":
        case "counter_uav":
            return "uavs";
        case "precision_airstrike":
        case "airstrike":
        case "stealth_airstrike":
        case "harrier_airstrike":
        case "super_airstrike":
            return "airstrikes";
        case "helicopter":
        case "helicopter_minigun":
        case "littlebird_support":
        case "helicopter_mk19":
        case "helicopter_blackbox":
        case "helicopter_flares":
        case "littlebird_flock":
            return "helicopters";
        default:
            return undefined;
    }
}

_ID21431()
{
    level endon( "game_ended" );
    self endon( "spawned_player" );
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "reload" );
        maps\mp\_utility::_ID17531( "mostreloads", 1 );
    }
}

_ID21440()
{
    level endon( "game_ended" );
    self endon( "spawned_player" );
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "weapon_fired" );
        maps\mp\_utility::_ID17531( "mostshotsfired", 1 );
    }
}

_ID21455()
{
    level endon( "game_ended" );
    self endon( "spawned_player" );
    self endon( "death" );
    self endon( "disconnect" );
    var_0 = "none";

    for (;;)
    {
        self waittill( "weapon_change",  var_1  );

        if ( var_0 == var_1 )
            continue;

        if ( var_1 == "none" )
            continue;

        if ( !maps\mp\gametypes\_weapons::isprimaryweapon( var_1 ) )
            continue;

        var_0 = var_1;
        maps\mp\_utility::_ID17531( "mostswaps", 1 );

        if ( !isdefined( self._ID34744[var_1] ) )
        {
            self._ID34744[var_1] = 1;
            maps\mp\_utility::_ID17531( "mostweaponsused", 1 );
        }
    }
}

monitormovementdistance()
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            if ( !isalive( var_1 ) )
                continue;

            if ( var_1.deaths != var_1._ID24940 )
            {
                var_1._ID24949 = var_1.origin;
                var_1._ID24940 = var_1.deaths;
            }

            var_2 = distance( var_1.origin, var_1._ID24949 );
            var_1 maps\mp\_utility::_ID17531( "distancetraveled", var_2 );
            var_1._ID24949 = var_1.origin;
            var_1.altitudepolls++;
            var_1._ID33153 = var_1._ID33153 + var_1.origin[2];
            var_3 = var_1._ID33153 / var_1.altitudepolls;
            var_1 maps\mp\_utility::_ID28832( "leastavgalt", var_3 );
            var_1 maps\mp\_utility::_ID28832( "greatestavgalt", var_3 );
            wait 0.05;
        }

        wait 0.05;
    }
}

monitorpositioncamping()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self._ID19525 = gettime();
    self._ID24755 = [];
    var_0 = 512;
    var_1 = squared( var_0 );

    for (;;)
    {
        if ( !isalive( self ) )
        {
            wait 0.5;
            self._ID19525 = gettime();
            self._ID24755 = [];
            continue;
        }

        self._ID24755[self._ID24755.size] = self.origin;

        if ( gettime() - self._ID19525 >= 15000 )
        {
            if ( distancesquared( self._ID24755[0], self.origin ) < var_1 && distancesquared( self._ID24755[1], self._ID24755[0] ) < var_1 )
            {
                var_2 = gettime() - self._ID19525;
                maps\mp\_utility::_ID17531( "timeinspot", var_2 );
            }

            self._ID24755 = [];
            self._ID19525 = gettime();
        }

        wait 5;
    }
}

encoderatio( var_0, var_1 )
{
    return var_0 + ( var_1 << 16 );
}

getratiohival( var_0 )
{
    return var_0 & 65535;
}

getratioloval( var_0 )
{
    return var_0 >> 16;
}

_ID21379()
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    while ( level.players.size < 3 )
        wait 1;

    for (;;)
    {
        if ( level.players.size < 2 )
        {
            wait 0.05;
            continue;
        }

        foreach ( var_1 in level.players )
        {
            if ( !isdefined( var_1 ) )
                continue;

            if ( var_1.team == "spectator" )
                continue;

            if ( !isalive( var_1 ) )
                continue;

            var_2 = sortbydistance( level.players, var_1.origin );

            if ( var_2[1].team != var_1.team )
                var_1 maps\mp\_utility::_ID17531( "closertoenemies", 0.05 );

            wait 0.05;
        }

        wait 0.05;
    }
}

_ID21382()
{
    level endon( "game_ended" );
    self endon( "spawned_player" );
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "survived_explosion",  var_0  );

        if ( isdefined( var_0 ) && isplayer( var_0 ) && self == var_0 )
            continue;

        maps\mp\_utility::_ID17531( "explosionssurvived", 1 );
        wait 0.05;
    }
}

_ID21439()
{
    level endon( "game_ended" );
    self endon( "spawned_player" );
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "shield_blocked" );
        maps\mp\_utility::_ID17531( "shieldblocks", 1 );
        wait 0.05;
    }
}

_ID21390()
{
    level endon( "game_ended" );
    self endon( "spawned_player" );
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "flash_hit" );
        maps\mp\_utility::_ID17531( "fbhits", 1 );
        wait 0.05;
    }
}

_ID21452()
{
    level endon( "game_ended" );
    self endon( "spawned_player" );
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "stun_hit" );
        maps\mp\_utility::_ID17531( "stunhits", 1 );
        wait 0.05;
    }
}

_ID21447()
{
    level endon( "game_ended" );
    self endon( "spawned_player" );
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        if ( self getstance() == "crouch" )
            maps\mp\_utility::_ID17531( "crouchtime", 500 );
        else if ( self getstance() == "prone" )
            maps\mp\_utility::_ID17531( "pronetime", 500 );

        wait 0.5;
    }
}
