// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID25044()
{
    foreach ( var_1 in level._ID23663["all"] )
        var_1 _ID28831();

    if ( level.multiteambased )
    {
        buildscoreboardtype( "multiteam" );

        foreach ( var_1 in level.players )
            var_1 setcommonplayerdata( "round", "scoreboardType", "multiteam" );

        setclientmatchdata( "alliesScore", -1 );
        setclientmatchdata( "axisScore", -1 );
        setclientmatchdata( "alliesKills", -1 );
        setclientmatchdata( "alliesDeaths", -1 );
    }
    else if ( level._ID32653 )
    {
        var_5 = getteamscore( "allies" );
        var_6 = getteamscore( "axis" );
        var_7 = 0;
        var_8 = 0;

        foreach ( var_1 in level.players )
        {
            if ( isdefined( var_1.pers["team"] ) && var_1.pers["team"] == "allies" )
            {
                var_7 += var_1.pers["kills"];
                var_8 += var_1.pers["deaths"];
            }
        }

        setclientmatchdata( "alliesScore", var_5 );
        setclientmatchdata( "axisScore", var_6 );
        setclientmatchdata( "alliesKills", var_7 );
        setclientmatchdata( "alliesDeaths", var_8 );

        if ( var_5 == var_6 )
            var_11 = "tied";
        else if ( var_5 > var_6 )
            var_11 = "allies";
        else
            var_11 = "axis";

        if ( var_11 == "tied" )
        {
            buildscoreboardtype( "allies" );
            buildscoreboardtype( "axis" );

            foreach ( var_1 in level.players )
            {
                var_13 = var_1.pers["team"];

                if ( !isdefined( var_13 ) )
                    continue;

                if ( var_13 == "spectator" )
                {
                    var_1 setcommonplayerdata( "round", "scoreboardType", "allies" );
                    continue;
                }

                var_1 setcommonplayerdata( "round", "scoreboardType", var_13 );
            }
        }
        else
        {
            buildscoreboardtype( var_11 );

            foreach ( var_1 in level.players )
                var_1 setcommonplayerdata( "round", "scoreboardType", var_11 );
        }
    }
    else
    {
        buildscoreboardtype( "neutral" );

        foreach ( var_1 in level.players )
            var_1 setcommonplayerdata( "round", "scoreboardType", "neutral" );

        setclientmatchdata( "alliesScore", -1 );
        setclientmatchdata( "axisScore", -1 );
        setclientmatchdata( "alliesKills", -1 );
        setclientmatchdata( "alliesDeaths", -1 );
    }

    foreach ( var_1 in level.players )
    {
        if ( !isai( var_1 ) && ( maps\mp\_utility::_ID25017() || maps\mp\_utility::_ID20673() ) )
            var_1 setcommonplayerdata( "round", "squadMemberIndex", var_1.pers["activeSquadMember"] );

        var_1 setcommonplayerdata( "round", "totalXp", var_1.pers["summary"]["xp"] );
        var_1 setcommonplayerdata( "round", "scoreXp", var_1.pers["summary"]["score"] );
        var_1 setcommonplayerdata( "round", "operationXp", var_1.pers["summary"]["operation"] );
        var_1 setcommonplayerdata( "round", "challengeXp", var_1.pers["summary"]["challenge"] );
        var_1 setcommonplayerdata( "round", "matchXp", var_1.pers["summary"]["match"] );
        var_1 setcommonplayerdata( "round", "miscXp", var_1.pers["summary"]["misc"] );
        var_1 setcommonplayerdatareservedint( "common_entitlement_xp", var_1.pers["summary"]["entitlementXP"] );
        var_1 setcommonplayerdatareservedint( "common_clan_wars_xp", var_1.pers["summary"]["clanWarsXP"] );
    }
}

_ID28831()
{
    var_0 = getclientmatchdata( "scoreboardPlayerCount" );

    if ( var_0 <= 24 )
    {
        setclientmatchdata( "players", self.clientmatchdataid, "score", self.pers["score"] );

        if ( isdefined( level.ishorde ) )
            var_1 = self.pers["hordeKills"];
        else
            var_1 = self.pers["kills"];

        setclientmatchdata( "players", self.clientmatchdataid, "kills", var_1 );

        if ( isdefined( level.ishorde ) )
            var_2 = self.pers["hordeRevives"];
        else if ( level._ID14086 == "dm" || level._ID14086 == "sotf_ffa" || level._ID14086 == "gun" )
            var_2 = self.assists;
        else
            var_2 = self.pers["assists"];

        setclientmatchdata( "players", self.clientmatchdataid, "assists", var_2 );
        var_3 = self.pers["deaths"];
        setclientmatchdata( "players", self.clientmatchdataid, "deaths", var_3 );
        var_4 = self.pers["team"];
        setclientmatchdata( "players", self.clientmatchdataid, "team", var_4 );
        var_5 = game[self.pers["team"]];
        setclientmatchdata( "players", self.clientmatchdataid, "faction", var_5 );
        var_6 = self.pers["extrascore0"];
        setclientmatchdata( "players", self.clientmatchdataid, "extrascore0", var_6 );
        var_0++;
        setclientmatchdata( "scoreboardPlayerCount", var_0 );
        return;
    }

    return;
}

buildscoreboardtype( var_0 )
{
    if ( var_0 == "multiteam" )
    {
        var_1 = 0;

        foreach ( var_3 in level._ID32668 )
        {
            foreach ( var_5 in level._ID23663[var_3] )
            {
                setclientmatchdata( "scoreboards", "multiteam", var_1, var_5.clientmatchdataid );
                var_1++;
            }
        }

        return;
    }

    if ( var_0 == "neutral" )
    {
        var_1 = 0;

        foreach ( var_5 in level._ID23663["all"] )
        {
            setclientmatchdata( "scoreboards", var_0, var_1, var_5.clientmatchdataid );
            var_1++;
        }

        return;
    }

    var_10 = maps\mp\_utility::getotherteam( var_0 );
    var_1 = 0;

    foreach ( var_5 in level._ID23663[var_0] )
    {
        setclientmatchdata( "scoreboards", var_0, var_1, var_5.clientmatchdataid );
        var_1++;
    }

    foreach ( var_5 in level._ID23663[var_10] )
    {
        setclientmatchdata( "scoreboards", var_0, var_1, var_5.clientmatchdataid );
        var_1++;
    }

    return;
    return;
}
