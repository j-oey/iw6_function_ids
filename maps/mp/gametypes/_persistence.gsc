// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    maps\mp\gametypes\_class::_ID17631();

    if ( !maps\mp\_utility::_ID18363() )
    {
        level._ID23468 = [];
        maps\mp\gametypes\_missions::_ID17631();
        maps\mp\gametypes\_rank::_ID17631();
        level thread _ID34512();
        level thread _ID34669();
        level thread writekdhistorystats();
    }

    maps\mp\gametypes\_playercards::_ID17631();
}

_ID17910()
{
    self.bufferedstats = [];
    self.squadmemberbufferedstats = [];

    if ( maps\mp\_utility::_ID25420() )
    {
        self.bufferedstats["totalShots"] = self getrankedplayerdata( "totalShots" );
        self.bufferedstats["accuracy"] = self getrankedplayerdata( "accuracy" );
        self.bufferedstats["misses"] = self getrankedplayerdata( "misses" );
        self.bufferedstats["hits"] = self getrankedplayerdata( "hits" );
        self.bufferedstats["timePlayedAllies"] = self getrankedplayerdata( "timePlayedAllies" );
        self.bufferedstats["timePlayedOpfor"] = self getrankedplayerdata( "timePlayedOpfor" );
        self.bufferedstats["timePlayedOther"] = self getrankedplayerdata( "timePlayedOther" );
        self.bufferedstats["timePlayedTotal"] = self getrankedplayerdata( "timePlayedTotal" );
        var_0 = self getrankedplayerdata( "activeSquadMember" );
        self.squadmemberbufferedstats["experienceToPrestige"] = self getrankedplayerdata( "squadMembers", var_0, "experienceToPrestige" );
    }

    self._ID6161 = [];
    self._ID6161["round"] = [];
    self._ID6161["round"]["timePlayed"] = self getcommonplayerdata( "round", "timePlayed" );

    if ( maps\mp\_utility::_ID25420() )
    {
        self._ID6161["xpMultiplierTimePlayed"] = [];
        self._ID6161["xpMultiplierTimePlayed"][0] = self getrankedplayerdata( "xpMultiplierTimePlayed", 0 );
        self._ID6161["xpMultiplierTimePlayed"][1] = self getrankedplayerdata( "xpMultiplierTimePlayed", 1 );
        self._ID6161["xpMultiplierTimePlayed"][2] = self getrankedplayerdata( "xpMultiplierTimePlayed", 2 );
        self._ID6162["xpMaxMultiplierTimePlayed"] = [];
        self._ID6162["xpMaxMultiplierTimePlayed"][0] = self getrankedplayerdata( "xpMaxMultiplierTimePlayed", 0 );
        self._ID6162["xpMaxMultiplierTimePlayed"][1] = self getrankedplayerdata( "xpMaxMultiplierTimePlayed", 1 );
        self._ID6162["xpMaxMultiplierTimePlayed"][2] = self getrankedplayerdata( "xpMaxMultiplierTimePlayed", 2 );
        self._ID6161["challengeXPMultiplierTimePlayed"] = [];
        self._ID6161["challengeXPMultiplierTimePlayed"][0] = self getrankedplayerdata( "challengeXPMultiplierTimePlayed", 0 );
        self._ID6162["challengeXPMaxMultiplierTimePlayed"] = [];
        self._ID6162["challengeXPMaxMultiplierTimePlayed"][0] = self getrankedplayerdata( "challengeXPMaxMultiplierTimePlayed", 0 );
        self._ID6161["weaponXPMultiplierTimePlayed"] = [];
        self._ID6161["weaponXPMultiplierTimePlayed"][0] = self getrankedplayerdata( "weaponXPMultiplierTimePlayed", 0 );
        self._ID6162["weaponXPMaxMultiplierTimePlayed"] = [];
        self._ID6162["weaponXPMaxMultiplierTimePlayed"][0] = self getrankedplayerdata( "weaponXPMaxMultiplierTimePlayed", 0 );

        if ( issquadsmode() )
        {
            self.bufferedstats["prestigeDoubleXp"] = self getrankedplayerdata( "prestigeDoubleXp" );
            self.bufferedstats["prestigeDoubleXpTimePlayed"] = self getrankedplayerdata( "prestigeDoubleXpTimePlayed" );
            self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"] = self getrankedplayerdata( "prestigeDoubleXpMaxTimePlayed" );
        }

        self.bufferedstats["prestigeDoubleWeaponXp"] = self getrankedplayerdata( "prestigeDoubleWeaponXp" );
        self.bufferedstats["prestigeDoubleWeaponXpTimePlayed"] = self getrankedplayerdata( "prestigeDoubleWeaponXpTimePlayed" );
        self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"] = self getrankedplayerdata( "prestigeDoubleWeaponXpMaxTimePlayed" );
        return;
    }
}

_ID31510( var_0 )
{
    return self getrankedplayerdata( var_0 );
}

_ID31526( var_0, var_1 )
{
    if ( !maps\mp\_utility::_ID25420() )
        return;

    self setrankedplayerdata( var_0, var_1 );
}

_ID31495( var_0, var_1, var_2 )
{
    if ( !maps\mp\_utility::_ID25420() )
        return;

    if ( isdefined( var_2 ) )
    {
        var_3 = self getrankedplayerdata( var_0, var_2 );
        self setrankedplayerdata( var_0, var_2, var_1 + var_3 );
        return;
    }

    var_3 = self getrankedplayerdata( var_0 );
    self setrankedplayerdata( var_0, var_1 + var_3 );
    return;
}

_ID31512( var_0, var_1 )
{
    if ( var_0 == "round" )
    {
        return self getcommonplayerdata( var_0, var_1 );
        return;
    }

    return self getrankedplayerdata( var_0, var_1 );
    return;
}

_ID31528( var_0, var_1, var_2 )
{
    if ( isagent( self ) )
        return;

    if ( !maps\mp\_utility::_ID25420() )
        return;

    if ( var_0 == "round" )
    {
        self setcommonplayerdata( var_0, var_1, var_2 );
        return;
    }

    self setrankedplayerdata( var_0, var_1, var_2 );
    return;
}

_ID31498( var_0, var_1, var_2 )
{
    if ( !maps\mp\_utility::_ID25420() )
        return;

    var_3 = self getrankedplayerdata( var_0, var_1 );
    self setrankedplayerdata( var_0, var_1, var_3 + var_2 );
}

_ID31513( var_0, var_1 )
{
    if ( !maps\mp\_utility::_ID25420() )
        return 0;

    return self._ID6161[var_0][var_1];
}

_ID31529( var_0, var_1, var_2 )
{
    if ( !maps\mp\_utility::_ID25420() )
        return;

    self._ID6161[var_0][var_1] = var_2;
}

_ID31499( var_0, var_1, var_2 )
{
    if ( !maps\mp\_utility::_ID25420() )
        return;

    var_3 = _ID31513( var_0, var_1 );
    _ID31529( var_0, var_1, var_3 + var_2 );
}

_ID31497( var_0, var_1, var_2 )
{
    if ( !maps\mp\_utility::_ID25420() )
        return;

    var_3 = statgetbuffered( var_0 ) + var_1;

    if ( var_3 > var_2 )
        var_3 = var_2;

    if ( var_3 < statgetbuffered( var_0 ) )
        var_3 = var_2;

    _ID31527( var_0, var_3 );
}

_ID31500( var_0, var_1, var_2, var_3 )
{
    if ( !maps\mp\_utility::_ID25420() )
        return;

    var_4 = _ID31513( var_0, var_1 ) + var_2;

    if ( var_4 > var_3 )
        var_4 = var_3;

    if ( var_4 < _ID31513( var_0, var_1 ) )
        var_4 = var_3;

    _ID31529( var_0, var_1, var_4 );
}

statgetbuffered( var_0 )
{
    if ( !maps\mp\_utility::_ID25420() )
        return 0;

    return self.bufferedstats[var_0];
}

statgetsquadbuffered( var_0 )
{
    if ( !maps\mp\_utility::_ID25420() )
        return 0;

    return self.squadmemberbufferedstats[var_0];
}

_ID31527( var_0, var_1 )
{
    if ( !maps\mp\_utility::_ID25420() )
        return;

    self.bufferedstats[var_0] = var_1;
}

statsetsquadbuffered( var_0, var_1 )
{
    if ( !maps\mp\_utility::_ID25420() )
        return;

    self.squadmemberbufferedstats[var_0] = var_1;
}

_ID31496( var_0, var_1 )
{
    if ( !maps\mp\_utility::_ID25420() )
        return;

    var_2 = statgetbuffered( var_0 );
    _ID31527( var_0, var_2 + var_1 );
}

stataddsquadbuffered( var_0, var_1 )
{
    if ( !maps\mp\_utility::_ID25420() )
        return;

    var_2 = statgetsquadbuffered( var_0 );
    statsetsquadbuffered( var_0, var_2 + var_1 );
}

_ID34512()
{
    wait 0.15;
    var_0 = 0;

    while ( !level.gameended )
    {
        maps\mp\gametypes\_hostmigration::_ID35770();
        var_0++;

        if ( var_0 >= level.players.size )
            var_0 = 0;

        if ( isdefined( level.players[var_0] ) )
        {
            level.players[var_0] _ID36444();
            level.players[var_0] _ID34646();
        }

        wait 2.0;
    }

    foreach ( var_2 in level.players )
    {
        var_2 _ID36444();
        var_2 _ID34646();
    }
}

_ID36444()
{
    var_0 = maps\mp\_utility::_ID25420();

    if ( var_0 )
    {
        foreach ( var_3, var_2 in self.bufferedstats )
            self setrankedplayerdata( var_3, var_2 );

        if ( !isai( self ) )
        {
            foreach ( var_3, var_2 in self.squadmemberbufferedstats )
                self setrankedplayerdata( "squadMembers", self.pers["activeSquadMember"], var_3, var_2 );
        }
    }

    foreach ( var_3, var_2 in self._ID6161 )
    {
        foreach ( var_8, var_7 in var_2 )
        {
            if ( var_3 == "round" )
            {
                self setcommonplayerdata( var_3, var_8, var_7 );
                continue;
            }

            if ( var_0 )
                self setrankedplayerdata( var_3, var_8, var_7 );
        }
    }
}

writekdhistorystats()
{
    if ( !maps\mp\_utility::_ID20673() )
        return;

    if ( issquadsmode() )
        return;

    level waittill( "game_ended" );
    wait 0.1;

    if ( maps\mp\_utility::_ID35913() || !maps\mp\_utility::_ID18768() && maps\mp\_utility::_ID17024() )
    {
        foreach ( var_1 in level.players )
            var_1 incrementrankedreservedhistory( var_1.kills, var_1.deaths );

        return;
    }
}

incrementrankedreservedhistory( var_0, var_1 )
{
    if ( !maps\mp\_utility::_ID25420() )
        return;

    for ( var_2 = 0; var_2 < 4; var_2++ )
    {
        var_3 = self getrankedplayerdatareservedint( "kdHistoryK" + ( var_2 + 1 ) );
        self setrankedplayerdatareservedint( "kdHistoryK" + var_2, var_3 );
        var_3 = self getrankedplayerdatareservedint( "kdHistoryD" + ( var_2 + 1 ) );
        self setrankedplayerdatareservedint( "kdHistoryD" + var_2, var_3 );
    }

    self setrankedplayerdatareservedint( "kdHistoryK4", int( clamp( var_0, 0, 255 ) ) );
    self setrankedplayerdatareservedint( "kdHistoryD4", int( clamp( var_1, 0, 255 ) ) );
}

_ID17544( var_0, var_1, var_2 )
{
    if ( var_0 == "iw6_pdwauto" )
        var_0 = "iw6_pdw";
    else if ( var_0 == "iw6_knifeonlyfast" )
        var_0 = "iw6_knifeonly";

    if ( maps\mp\_utility::_ID18679( var_0 ) )
        return;

    if ( isdefined( level.disableweaponstats ) )
        return;

    if ( maps\mp\_utility::_ID25420() )
    {
        var_3 = self getrankedplayerdata( "weaponStats", var_0, var_1 );
        self setrankedplayerdata( "weaponStats", var_0, var_1, var_3 + var_2 );
        return;
    }
}

_ID17542( var_0, var_1, var_2 )
{
    if ( isdefined( level.disableweaponstats ) )
        return;

    if ( maps\mp\_utility::_ID25420() )
    {
        var_3 = self getrankedplayerdata( "attachmentsStats", var_0, var_1 );
        self setrankedplayerdata( "attachmentsStats", var_0, var_1, var_3 + var_2 );
        return;
    }
}

_ID34646()
{
    if ( !isdefined( self._ID33308 ) )
        return;

    if ( self._ID33308 == "" || self._ID33308 == "none" )
        return;

    if ( maps\mp\_utility::_ID18679( self._ID33308 ) || maps\mp\_utility::_ID18615( self._ID33308 ) )
        return;

    var_0 = self._ID33308;
    var_1 = undefined;
    var_2 = getsubstr( var_0, 0, 4 );

    if ( var_2 == "alt_" )
    {
        var_3 = maps\mp\_utility::_ID15474( var_0 );

        foreach ( var_5 in var_3 )
        {
            if ( var_5 == "shotgun" || var_5 == "gl" )
            {
                var_1 = var_5;
                break;
            }
        }

        if ( !isdefined( var_1 ) )
        {
            var_7 = strtok( var_0, "_" );
            var_1 = var_7[1] + "_" + var_7[2];
        }
    }
    else if ( var_2 == "iw5_" || var_2 == "iw6_" )
    {
        var_7 = strtok( var_0, "_" );
        var_1 = var_7[0] + "_" + var_7[1];
    }

    if ( var_1 == "gl" || var_1 == "shotgun" )
    {
        _ID23470( var_1 );
        _ID23465();
        return;
    }

    if ( !maps\mp\_utility::iscacprimaryweapon( var_1 ) && !maps\mp\_utility::_ID18576( var_1 ) )
        return;

    perslog_weaponstats( var_1 );
    var_3 = getweaponattachments( var_0 );

    foreach ( var_5 in var_3 )
    {
        var_9 = maps\mp\_utility::attachmentmap_tobase( var_5 );

        switch ( var_9 )
        {
            case "shotgun":
            case "gl":
            case "scope":
                continue;
        }

        _ID23470( var_9 );
    }

    _ID23465();
}

_ID23465()
{
    self._ID33308 = "none";
    self._ID33309 = 0;
    self._ID33307 = 0;
    self._ID33306 = 0;
    self.trackingweaponheadshots = 0;
    self._ID33304 = 0;
}

perslog_weaponstats( var_0 )
{
    if ( self._ID33309 > 0 )
    {
        _ID17544( var_0, "shots", self._ID33309 );
        maps\mp\_matchdata::logweaponstat( var_0, "shots", self._ID33309 );
    }

    if ( self._ID33307 > 0 )
    {
        _ID17544( var_0, "kills", self._ID33307 );
        maps\mp\_matchdata::logweaponstat( var_0, "kills", self._ID33307 );
    }

    if ( self._ID33306 > 0 )
    {
        _ID17544( var_0, "hits", self._ID33306 );
        maps\mp\_matchdata::logweaponstat( var_0, "hits", self._ID33306 );
    }

    if ( self.trackingweaponheadshots > 0 )
    {
        _ID17544( var_0, "headShots", self.trackingweaponheadshots );
        maps\mp\_matchdata::logweaponstat( var_0, "headShots", self.trackingweaponheadshots );
    }

    if ( self._ID33304 > 0 )
    {
        _ID17544( var_0, "deaths", self._ID33304 );
        maps\mp\_matchdata::logweaponstat( var_0, "deaths", self._ID33304 );
        return;
    }
}

_ID23470( var_0 )
{
    if ( self._ID33309 > 0 && var_0 != "tactical" )
    {
        _ID17542( var_0, "shots", self._ID33309 );
        maps\mp\_matchdata::_ID20243( var_0, "shots", self._ID33309 );
    }

    if ( self._ID33307 > 0 && var_0 != "tactical" )
    {
        _ID17542( var_0, "kills", self._ID33307 );
        maps\mp\_matchdata::_ID20243( var_0, "kills", self._ID33307 );
    }

    if ( self._ID33306 > 0 && var_0 != "tactical" )
    {
        _ID17542( var_0, "hits", self._ID33306 );
        maps\mp\_matchdata::_ID20243( var_0, "hits", self._ID33306 );
    }

    if ( self.trackingweaponheadshots > 0 && var_0 != "tactical" )
    {
        _ID17542( var_0, "headShots", self.trackingweaponheadshots );
        maps\mp\_matchdata::_ID20243( var_0, "headShots", self.trackingweaponheadshots );
    }

    if ( self._ID33304 > 0 )
    {
        _ID17542( var_0, "deaths", self._ID33304 );
        maps\mp\_matchdata::_ID20243( var_0, "deaths", self._ID33304 );
        return;
    }
}

_ID34669()
{
    level waittill( "game_ended" );

    if ( !maps\mp\_utility::_ID20673() )
        return;

    var_0 = 0;
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;
    var_5 = 0;

    foreach ( var_7 in level.players )
        var_5 += var_7._ID33067["total"];

    incrementcounter( "global_minutes", int( var_5 / 60 ) );

    if ( maps\mp\_utility::_ID18768() && !maps\mp\_utility::_ID35913() )
        return;

    wait 0.05;

    foreach ( var_7 in level.players )
    {
        var_0 += var_7.kills;
        var_1 += var_7.deaths;
        var_2 += var_7.assists;
        var_3 += var_7._ID16462;
        var_4 += var_7._ID32048;
    }

    incrementcounter( "global_headshots", var_3 );
    incrementcounter( "global_suicides", var_4 );
    incrementcounter( "global_games", 1 );

    if ( !isdefined( level._ID3995 ) )
        incrementcounter( "global_assists", var_2 );

    if ( !isdefined( level.ishorde ) )
        incrementcounter( "global_kills", var_0 );

    if ( !isdefined( level.ishorde ) )
    {
        incrementcounter( "global_deaths", var_1 );
        return;
    }
}
