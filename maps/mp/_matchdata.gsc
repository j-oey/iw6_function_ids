// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    if ( !isdefined( game["gamestarted"] ) )
    {
        setmatchdatadef( "mp/matchdata.def" );
        setmatchdata( "map", level.script );

        if ( level.hardcoremode )
        {
            var_0 = level._ID14086 + " hc";
            setmatchdata( "gametype", var_0 );
        }
        else
            setmatchdata( "gametype", level._ID14086 );

        setmatchdata( "buildVersion", getbuildversion() );
        setmatchdata( "buildNumber", getbuildnumber() );
        setmatchdata( "dateTime", getsystemtime() );
        setmatchdataid();
    }

    level._ID20745 = 285;
    level.maxnamelength = 26;
    level._ID20735 = 150;
    level._ID20742 = 64;
    level._ID20746 = 30;
    level._ID20750 = 10;
    level._ID20749 = 10;

    if ( !maps\mp\_utility::_ID18363() )
    {
        level thread gameendlistener();
        level thread _ID11742();
    }
}

_ID15139()
{
    return getmatchdata( "dateTime" );
}

_ID20253( var_0, var_1 )
{
    if ( !canlogclient( self ) || !canlogkillstreak() )
        return;

    var_2 = getmatchdata( "killstreakCount" );
    setmatchdata( "killstreakCount", var_2 + 1 );
    setmatchdata( "killstreaks", var_2, "eventType", var_0 );
    setmatchdata( "killstreaks", var_2, "player", self.clientid );
    setmatchdata( "killstreaks", var_2, "eventTime", gettime() );
    setmatchdata( "killstreaks", var_2, "eventPos", 0, int( var_1[0] ) );
    setmatchdata( "killstreaks", var_2, "eventPos", 1, int( var_1[1] ) );
    setmatchdata( "killstreaks", var_2, "eventPos", 2, int( var_1[2] ) );
}

loggameevent( var_0, var_1 )
{
    if ( !canlogclient( self ) || !canlogevent() )
        return;

    var_2 = getmatchdata( "eventCount" );
    setmatchdata( "eventCount", var_2 + 1 );
    setmatchdata( "events", var_2, "eventType", var_0 );
    setmatchdata( "events", var_2, "player", self.clientid );
    setmatchdata( "events", var_2, "eventTime", gettime() );
    setmatchdata( "events", var_2, "eventPos", 0, int( var_1[0] ) );
    setmatchdata( "events", var_2, "eventPos", 1, int( var_1[1] ) );
    setmatchdata( "events", var_2, "eventPos", 2, int( var_1[2] ) );
}

_ID20250( var_0, var_1 )
{
    if ( !canloglife( var_0 ) )
        return;

    setmatchdata( "lives", var_0, "modifiers", var_1, 1 );
}

_ID20254( var_0, var_1 )
{
    if ( !canloglife( var_0 ) )
        return;

    setmatchdata( "lives", var_0, "multikill", var_1 );
}

_ID20263()
{
    if ( !canlogclient( self ) )
        var_0 = level._ID20745;

    if ( self.curclass == "gamemode" )
        var_0 = self logmatchdatalife( self.clientid, self.spawnpos, self._ID30916, self._ID35917 );
    else if ( issubstr( self.curclass, "custom" ) )
    {
        var_1 = maps\mp\_utility::_ID14933( self.curclass );
        var_2 = maps\mp\gametypes\_class::cac_getweapon( var_1, 0 );
        var_3 = maps\mp\gametypes\_class::cac_getweaponattachment( var_1, 0 );
        var_4 = maps\mp\gametypes\_class::cac_getweaponattachmenttwo( var_1, 0 );
        var_5 = maps\mp\gametypes\_class::cac_getweapon( var_1, 1 );
        var_6 = maps\mp\gametypes\_class::cac_getweaponattachment( var_1, 1 );
        var_7 = maps\mp\gametypes\_class::cac_getweaponattachmenttwo( var_1, 1 );
        var_8 = "none";
        var_9 = maps\mp\gametypes\_class::cac_getperk( var_1, 0 );
        var_0 = self logmatchdatalife( self.clientid, self.spawnpos, self._ID30916, self._ID35917, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
        logplayerabilityperks( var_0 );
    }
    else
    {
        var_1 = maps\mp\_utility::_ID14933( self.curclass );
        var_2 = maps\mp\gametypes\_class::_ID32335( level.classtablename, var_1, 0 );
        var_3 = maps\mp\gametypes\_class::_ID32336( level.classtablename, var_1, 0, 0 );
        var_4 = maps\mp\gametypes\_class::_ID32336( level.classtablename, var_1, 0, 1 );
        var_5 = maps\mp\gametypes\_class::_ID32335( level.classtablename, var_1, 1 );
        var_6 = maps\mp\gametypes\_class::_ID32336( level.classtablename, var_1, 1, 0 );
        var_7 = maps\mp\gametypes\_class::_ID32336( level.classtablename, var_1, 1, 1 );
        var_8 = maps\mp\gametypes\_class::_ID32332( level.classtablename, var_1 );
        var_9 = maps\mp\gametypes\_class::_ID32330( level.classtablename, var_1, 0 );
        var_0 = self logmatchdatalife( self.clientid, self.spawnpos, self._ID30916, self._ID35917, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
        logplayerabilityperks( var_0 );
    }

    return var_0;
}

logplayerabilityperks( var_0 )
{
    if ( getdvarint( "scr_trackPlayerAbilities", 0 ) != 0 )
    {
        if ( isdefined( self.abilityflags ) && self.abilityflags.size == 2 )
        {
            setmatchdata( "lives", var_0, "abilityFlags", 0, self.abilityflags[0] );
            setmatchdata( "lives", var_0, "abilityFlags", 1, self.abilityflags[1] );
        }
    }
}

_ID20264( var_0, var_1 )
{
    if ( !canlogclient( self ) )
        return;

    setmatchdata( "players", self.clientid, var_1, var_0 );
}

_ID20262( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !canlogclient( self ) )
        return;

    if ( var_0 >= level._ID20745 )
        return;

    if ( isplayer( var_1 ) && canlogclient( var_1 ) )
        self logmatchdatadeath( var_0, self.clientid, var_1, var_1.clientid, var_4, var_3, maps\mp\_utility::_ID18679( var_4 ), var_1 maps\mp\_utility::_ID18666() );
    else
        self logmatchdatadeath( var_0, self.clientid, undefined, undefined, var_4, var_3, maps\mp\_utility::_ID18679( var_4 ), 0 );
}

logplayerdata()
{
    if ( !canlogclient( self ) )
        return;

    setmatchdata( "players", self.clientid, "score", maps\mp\_utility::_ID15245( "score" ) );

    if ( maps\mp\_utility::_ID15245( "assists" ) > 255 )
        setmatchdata( "players", self.clientid, "assists", 255 );
    else
        setmatchdata( "players", self.clientid, "assists", maps\mp\_utility::_ID15245( "assists" ) );

    if ( maps\mp\_utility::_ID15245( "longestStreak" ) > 255 )
        setmatchdata( "players", self.clientid, "longestStreak", 255 );
    else
        setmatchdata( "players", self.clientid, "longestStreak", maps\mp\_utility::_ID15245( "longestStreak" ) );

    if ( maps\mp\_utility::_ID15245( "validationInfractions" ) > 255 )
        setmatchdata( "players", self.clientid, "validationInfractions", 255 );
    else
        setmatchdata( "players", self.clientid, "validationInfractions", maps\mp\_utility::_ID15245( "validationInfractions" ) );
}

_ID11742()
{
    level waittill( "game_ended" );

    foreach ( var_1 in level.players )
    {
        wait 0.05;

        if ( !isdefined( var_1 ) )
            continue;

        if ( isdefined( var_1._ID9929 ) && var_1._ID9929 && var_1 maps\mp\_utility::_ID25420() )
            var_1 setrankedplayerdata( "restXPGoal", var_1._ID9929 );

        if ( isdefined( var_1._ID36294 ) )
        {
            var_1 _ID10791();
            var_2 = 0;

            if ( var_1._ID36294.size > 3 )
            {
                for ( var_3 = var_1._ID36294.size - 1; var_3 > var_1._ID36294.size - 3; var_3-- )
                {
                    var_1 setcommonplayerdata( "round", "weaponsUsed", var_2, var_1._ID36294[var_3] );
                    var_1 setcommonplayerdata( "round", "weaponXpEarned", var_2, var_1._ID36299[var_3] );
                    var_2++;
                }
            }
            else
            {
                for ( var_3 = var_1._ID36294.size - 1; var_3 >= 0; var_3-- )
                {
                    var_1 setcommonplayerdata( "round", "weaponsUsed", var_2, var_1._ID36294[var_3] );
                    var_1 setcommonplayerdata( "round", "weaponXpEarned", var_2, var_1._ID36299[var_3] );
                    var_2++;
                }
            }
        }
        else
        {
            var_1 setcommonplayerdata( "round", "weaponsUsed", 0, "none" );
            var_1 setcommonplayerdata( "round", "weaponsUsed", 1, "none" );
            var_1 setcommonplayerdata( "round", "weaponsUsed", 2, "none" );
            var_1 setcommonplayerdata( "round", "weaponXpEarned", 0, 0 );
            var_1 setcommonplayerdata( "round", "weaponXpEarned", 1, 0 );
            var_1 setcommonplayerdata( "round", "weaponXpEarned", 2, 0 );
        }

        if ( isdefined( var_1._ID22963 ) )
            var_1 setcommonplayerdata( "round", "operationNumCompleted", var_1._ID22963.size );
        else
            var_1 setcommonplayerdata( "round", "operationNumCompleted", 0 );

        for ( var_3 = 0; var_3 < 5; var_3++ )
        {
            if ( isdefined( var_1._ID22963 ) && isdefined( var_1._ID22963[var_3] ) && var_1._ID22963[var_3] != "ch_prestige" && !issubstr( var_1._ID22963[var_3], "_daily" ) && !issubstr( var_1._ID22963[var_3], "_weekly" ) )
            {
                var_1 setcommonplayerdata( "round", "operationsCompleted", var_3, var_1._ID22963[var_3] );
                continue;
            }

            var_1 setcommonplayerdata( "round", "operationsCompleted", var_3, "" );
        }

        if ( isdefined( var_1.challengescompleted ) )
            var_1 setcommonplayerdata( "round", "challengeNumCompleted", var_1.challengescompleted.size );
        else
            var_1 setcommonplayerdata( "round", "challengeNumCompleted", 0 );

        for ( var_3 = 0; var_3 < 20; var_3++ )
        {
            if ( isdefined( var_1.challengescompleted ) && isdefined( var_1.challengescompleted[var_3] ) && var_1.challengescompleted[var_3] != "ch_prestige" && !issubstr( var_1.challengescompleted[var_3], "_daily" ) && !issubstr( var_1.challengescompleted[var_3], "_weekly" ) )
            {
                var_1 setcommonplayerdata( "round", "challengesCompleted", var_3, var_1.challengescompleted[var_3] );
                continue;
            }

            var_1 setcommonplayerdata( "round", "challengesCompleted", var_3, "" );
        }

        var_1 setcommonplayerdata( "round", "gameMode", level._ID14086 );
        var_1 setcommonplayerdata( "round", "map", tolower( getdvar( "mapname" ) ) );

        if ( issquadsmode() )
        {
            var_1 setcommonplayerdata( "round", "squadMode", 1 );
            continue;
        }

        var_1 setcommonplayerdata( "round", "squadMode", 0 );
    }
}

_ID10791()
{
    var_0 = self._ID36299;
    var_1 = self._ID36299.size;

    for ( var_2 = var_1 - 1; var_2 > 0; var_2-- )
    {
        for ( var_3 = 1; var_3 <= var_2; var_3++ )
        {
            if ( var_0[var_3 - 1] < var_0[var_3] )
            {
                var_4 = self._ID36294[var_3];
                self._ID36294[var_3] = self._ID36294[var_3 - 1];
                self._ID36294[var_3 - 1] = var_4;
                var_5 = self._ID36299[var_3];
                self._ID36299[var_3] = self._ID36299[var_3 - 1];
                self._ID36299[var_3 - 1] = var_5;
                var_0 = self._ID36299;
            }
        }
    }
}

gameendlistener()
{
    level waittill( "game_ended" );

    foreach ( var_1 in level.players )
    {
        var_1 logplayerdata();

        if ( !isalive( var_1 ) )
            continue;

        var_1 _ID20263();
    }
}

canlogclient( var_0 )
{
    if ( isagent( var_0 ) )
        return 0;

    return var_0.clientid < level._ID20746;
}

canlogevent()
{
    return getmatchdata( "eventCount" ) < level._ID20735;
}

canlogkillstreak()
{
    return getmatchdata( "killstreakCount" ) < level._ID20742;
}

canloglife( var_0 )
{
    return getmatchdata( "lifeCount" ) < level._ID20745;
}

logweaponstat( var_0, var_1, var_2 )
{
    if ( !canlogclient( self ) )
        return;

    if ( var_0 == "iw6_pdwauto" )
        var_0 = "iw6_pdw";
    else if ( var_0 == "iw6_knifeonlyfast" )
        var_0 = "iw6_knifeonly";

    if ( maps\mp\_utility::_ID18679( var_0 ) )
        return;

    storeweaponandattachmentstats( "weaponStats", var_0, var_1, var_2 );
}

_ID20243( var_0, var_1, var_2 )
{
    if ( !canlogclient( self ) )
        return;

    storeweaponandattachmentstats( "attachmentsStats", var_0, var_1, var_2 );
}

storeweaponandattachmentstats( var_0, var_1, var_2, var_3 )
{
    var_4 = getmatchdata( "players", self.clientid, var_0, var_1, var_2 );
    var_5 = var_4 + var_3;

    if ( var_2 == "kills" || var_2 == "deaths" || var_2 == "headShots" )
    {
        if ( var_5 > 255 )
            var_5 = 255;
    }
    else if ( var_5 > 65535 )
        var_5 = 65535;

    setmatchdata( "players", self.clientid, var_0, var_1, var_2, var_5 );
}

buildbaseweaponlist()
{
    var_0 = [];
    var_1 = 149;

    for ( var_2 = 0; var_2 <= var_1; var_2++ )
    {
        var_3 = tablelookup( "mp/statstable.csv", 0, var_2, 4 );

        if ( var_3 == "" || var_3 == "uav" || var_3 == "iw6_knifeonlyfast" || var_3 == "laser_designator" || var_3 == "iw6_pdwauto" )
            continue;

        if ( !issubstr( tablelookup( "mp/statsTable.csv", 0, var_2, 2 ), "weapon_" ) )
            continue;

        if ( tablelookup( "mp/statsTable.csv", 0, var_2, 2 ) == "weapon_other" )
            continue;

        var_0[var_0.size] = var_3;
    }

    return var_0;
}

_ID20245( var_0, var_1 )
{
    if ( !canlogclient( self ) )
        return;

    if ( issubstr( var_0, "_daily" ) || issubstr( var_0, "_weekly" ) )
        return;

    var_2 = getmatchdata( "players", self.clientid, "challengeCount" );

    if ( var_2 < level._ID20750 )
    {
        setmatchdata( "players", self.clientid, "challenge", var_2, var_0 );
        setmatchdata( "players", self.clientid, "tier", var_2, var_1 );
        setmatchdata( "players", self.clientid, "challengeCount", var_2 + 1 );
    }
}

logaward( var_0 )
{
    if ( !canlogclient( self ) )
        return;

    var_1 = getmatchdata( "players", self.clientid, "awardCount" );

    if ( var_1 < level._ID20749 )
    {
        setmatchdata( "players", self.clientid, "awards", var_1, var_0 );
        setmatchdata( "players", self.clientid, "awardCount", var_1 + 1 );
    }
}

logkillsconfirmed()
{
    if ( !canlogclient( self ) )
        return;

    setmatchdata( "players", self.clientid, "killsConfirmed", self.pers["confirmed"] );
}

_ID20252()
{
    if ( !canlogclient( self ) )
        return;

    setmatchdata( "players", self.clientid, "killsDenied", self.pers["denied"] );
}

loginitialstats()
{
    if ( getdvarint( "mdsd" ) > 0 )
    {
        setmatchdata( "players", self.clientid, "startXp", self getrankedplayerdata( "experience" ) );
        setmatchdata( "players", self.clientid, "startKills", self getrankedplayerdata( "kills" ) );
        setmatchdata( "players", self.clientid, "startDeaths", self getrankedplayerdata( "deaths" ) );
        setmatchdata( "players", self.clientid, "startWins", self getrankedplayerdata( "wins" ) );
        setmatchdata( "players", self.clientid, "startLosses", self getrankedplayerdata( "losses" ) );
        setmatchdata( "players", self.clientid, "startHits", self getrankedplayerdata( "hits" ) );
        setmatchdata( "players", self.clientid, "startMisses", self getrankedplayerdata( "misses" ) );
        setmatchdata( "players", self.clientid, "startGamesPlayed", self getrankedplayerdata( "gamesPlayed" ) );
        setmatchdata( "players", self.clientid, "startTimePlayedTotal", self getrankedplayerdata( "timePlayedTotal" ) );
        setmatchdata( "players", self.clientid, "startScore", self getrankedplayerdata( "score" ) );
        setmatchdata( "players", self.clientid, "startUnlockPoints", self getrankedplayerdata( "unlockPoints" ) );
        setmatchdata( "players", self.clientid, "startPrestige", self getrankedplayerdata( "prestige" ) );

        for ( var_0 = 0; var_0 < 10; var_0++ )
            setmatchdata( "players", self.clientid, "startCharacterXP", var_0, self getrankedplayerdata( "characterXP", var_0 ) );
    }
}

logfinalstats()
{
    if ( getdvarint( "mdsd" ) > 0 )
    {
        setmatchdata( "players", self.clientid, "endXp", self getrankedplayerdata( "experience" ) );
        setmatchdata( "players", self.clientid, "endKills", self getrankedplayerdata( "kills" ) );
        setmatchdata( "players", self.clientid, "endDeaths", self getrankedplayerdata( "deaths" ) );
        setmatchdata( "players", self.clientid, "endWins", self getrankedplayerdata( "wins" ) );
        setmatchdata( "players", self.clientid, "endLosses", self getrankedplayerdata( "losses" ) );
        setmatchdata( "players", self.clientid, "endHits", self getrankedplayerdata( "hits" ) );
        setmatchdata( "players", self.clientid, "endMisses", self getrankedplayerdata( "misses" ) );
        setmatchdata( "players", self.clientid, "endGamesPlayed", self getrankedplayerdata( "gamesPlayed" ) );
        setmatchdata( "players", self.clientid, "endTimePlayedTotal", self getrankedplayerdata( "timePlayedTotal" ) );
        setmatchdata( "players", self.clientid, "endScore", self getrankedplayerdata( "score" ) );
        setmatchdata( "players", self.clientid, "endUnlockPoints", self getrankedplayerdata( "unlockPoints" ) );
        setmatchdata( "players", self.clientid, "endPrestige", self getrankedplayerdata( "prestige" ) );

        for ( var_0 = 0; var_0 < 10; var_0++ )
            setmatchdata( "players", self.clientid, "endCharacterXP", var_0, self getrankedplayerdata( "characterXP", var_0 ) );
    }
}
