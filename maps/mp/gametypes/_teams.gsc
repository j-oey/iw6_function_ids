// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    initscoreboard();
    level._ID32651 = getdvarint( "scr_teambalance" );
    level._ID20723 = getdvarint( "sv_maxclients" );
    setplayermodels();
    level._ID13579 = [];

    if ( level._ID32653 )
    {
        level thread _ID22877();
        level thread _ID34620();
        wait 0.15;

        if ( !maps\mp\_utility::_ID18363() )
        {
            level thread _ID34579();
            return;
        }

        return;
    }

    level thread _ID22846();
    wait 0.15;
    level thread _ID34538();
    return;
}

initscoreboard()
{
    setdvar( "g_TeamName_Allies", _ID15422( "allies" ) );
    setdvar( "g_TeamIcon_Allies", _ID15418( "allies" ) );
    setdvar( "g_TeamIcon_MyAllies", _ID15418( "allies" ) );
    setdvar( "g_TeamIcon_EnemyAllies", _ID15418( "allies" ) );
    var_0 = getteamcolor( "allies" );
    setdvar( "g_ScoresColor_Allies", var_0[0] + " " + var_0[1] + " " + var_0[2] );
    setdvar( "g_TeamName_Axis", _ID15422( "axis" ) );
    setdvar( "g_TeamIcon_Axis", _ID15418( "axis" ) );
    setdvar( "g_TeamIcon_MyAxis", _ID15418( "axis" ) );
    setdvar( "g_TeamIcon_EnemyAxis", _ID15418( "axis" ) );
    var_0 = getteamcolor( "axis" );
    setdvar( "g_ScoresColor_Axis", var_0[0] + " " + var_0[1] + " " + var_0[2] );
    setdvar( "g_ScoresColor_Spectator", ".25 .25 .25" );
    setdvar( "g_ScoresColor_Free", ".76 .78 .10" );
    setdvar( "g_teamTitleColor_MyTeam", ".6 .8 .6" );
    setdvar( "g_teamTitleColor_EnemyTeam", "1 .45 .5" );
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread _ID22853();
        var_0 thread onjoinedspectators();
        var_0 thread onplayerspawned();
        var_0 thread _ID33320();
    }
}

_ID22846()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread _ID33299();
    }
}

_ID22853()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "joined_team" );
        _ID34626();
    }
}

onjoinedspectators()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "joined_spectators" );
        self.pers["teamTime"] = undefined;
    }
}

_ID33320()
{
    self endon( "disconnect" );
    self._ID33067["allies"] = 0;
    self._ID33067["axis"] = 0;
    self._ID33067["free"] = 0;
    self._ID33067["other"] = 0;
    self._ID33067["total"] = 0;
    maps\mp\_utility::gameflagwait( "prematch_done" );

    for (;;)
    {
        if ( game["state"] == "playing" )
        {
            if ( self.sessionteam == "allies" )
            {
                self._ID33067["allies"]++;
                self._ID33067["total"]++;
            }
            else if ( self.sessionteam == "axis" )
            {
                self._ID33067["axis"]++;
                self._ID33067["total"]++;
            }
            else if ( self.sessionteam == "spectator" )
                self._ID33067["other"]++;
        }

        wait 1.0;
    }
}

_ID34579()
{
    if ( !level._ID25418 )
        return;

    level endon( "game_ended" );

    for (;;)
    {
        maps\mp\gametypes\_hostmigration::_ID35770();

        foreach ( var_1 in level.players )
            var_1 _ID34576();

        wait 1.0;
    }
}

_ID34576()
{
    if ( isai( self ) )
        return;

    if ( !maps\mp\_utility::_ID25420() )
        return;

    if ( self._ID33067["allies"] )
    {
        if ( !issquadsmode() )
        {
            maps\mp\gametypes\_persistence::_ID31496( "timePlayedAllies", self._ID33067["allies"] );
            maps\mp\gametypes\_persistence::_ID31496( "timePlayedTotal", self._ID33067["allies"] );
        }

        maps\mp\gametypes\_persistence::_ID31499( "round", "timePlayed", self._ID33067["allies"] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 0, self._ID33067["allies"], self._ID6162["xpMaxMultiplierTimePlayed"][0] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 1, self._ID33067["allies"], self._ID6162["xpMaxMultiplierTimePlayed"][1] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 2, self._ID33067["allies"], self._ID6162["xpMaxMultiplierTimePlayed"][2] );
        maps\mp\gametypes\_persistence::_ID31500( "challengeXPMultiplierTimePlayed", 0, self._ID33067["allies"], self._ID6162["challengeXPMaxMultiplierTimePlayed"][0] );
        maps\mp\gametypes\_persistence::_ID31500( "weaponXPMultiplierTimePlayed", 0, self._ID33067["allies"], self._ID6162["weaponXPMaxMultiplierTimePlayed"][0] );

        if ( issquadsmode() )
        {
            maps\mp\gametypes\_persistence::_ID31497( "prestigeDoubleXpTimePlayed", self._ID33067["allies"], self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"] );
            maps\mp\gametypes\_persistence::_ID31497( "prestigeDoubleWeaponXpTimePlayed", self._ID33067["allies"], self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"] );
        }
    }

    if ( self._ID33067["axis"] )
    {
        if ( !issquadsmode() )
        {
            maps\mp\gametypes\_persistence::_ID31496( "timePlayedOpfor", self._ID33067["axis"] );
            maps\mp\gametypes\_persistence::_ID31496( "timePlayedTotal", self._ID33067["axis"] );
        }

        maps\mp\gametypes\_persistence::_ID31499( "round", "timePlayed", self._ID33067["axis"] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 0, self._ID33067["axis"], self._ID6162["xpMaxMultiplierTimePlayed"][0] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 1, self._ID33067["axis"], self._ID6162["xpMaxMultiplierTimePlayed"][1] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 2, self._ID33067["axis"], self._ID6162["xpMaxMultiplierTimePlayed"][2] );
        maps\mp\gametypes\_persistence::_ID31500( "challengeXPMultiplierTimePlayed", 0, self._ID33067["axis"], self._ID6162["challengeXPMaxMultiplierTimePlayed"][0] );
        maps\mp\gametypes\_persistence::_ID31500( "weaponXPMultiplierTimePlayed", 0, self._ID33067["axis"], self._ID6162["weaponXPMaxMultiplierTimePlayed"][0] );

        if ( issquadsmode() )
        {
            maps\mp\gametypes\_persistence::_ID31497( "prestigeDoubleXpTimePlayed", self._ID33067["axis"], self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"] );
            maps\mp\gametypes\_persistence::_ID31497( "prestigeDoubleWeaponXpTimePlayed", self._ID33067["axis"], self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"] );
        }
    }

    if ( self._ID33067["other"] )
    {
        if ( !issquadsmode() )
        {
            maps\mp\gametypes\_persistence::_ID31496( "timePlayedOther", self._ID33067["other"] );
            maps\mp\gametypes\_persistence::_ID31496( "timePlayedTotal", self._ID33067["other"] );
        }

        maps\mp\gametypes\_persistence::_ID31499( "round", "timePlayed", self._ID33067["other"] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 0, self._ID33067["other"], self._ID6162["xpMaxMultiplierTimePlayed"][0] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 1, self._ID33067["other"], self._ID6162["xpMaxMultiplierTimePlayed"][1] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 2, self._ID33067["other"], self._ID6162["xpMaxMultiplierTimePlayed"][2] );
        maps\mp\gametypes\_persistence::_ID31500( "challengeXPMultiplierTimePlayed", 0, self._ID33067["other"], self._ID6162["challengeXPMaxMultiplierTimePlayed"][0] );
        maps\mp\gametypes\_persistence::_ID31500( "weaponXPMultiplierTimePlayed", 0, self._ID33067["other"], self._ID6162["weaponXPMaxMultiplierTimePlayed"][0] );

        if ( issquadsmode() )
        {
            maps\mp\gametypes\_persistence::_ID31497( "prestigeDoubleXpTimePlayed", self._ID33067["other"], self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"] );
            maps\mp\gametypes\_persistence::_ID31497( "prestigeDoubleWeaponXpTimePlayed", self._ID33067["other"], self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"] );
        }
    }

    if ( self.pers["rank"] != level._ID20757 )
    {
        if ( self._ID33067["allies"] )
            maps\mp\gametypes\_persistence::stataddsquadbuffered( "experienceToPrestige", self._ID33067["allies"] );
        else if ( self._ID33067["axis"] )
            maps\mp\gametypes\_persistence::stataddsquadbuffered( "experienceToPrestige", self._ID33067["axis"] );
        else if ( self._ID33067["other"] )
            maps\mp\gametypes\_persistence::stataddsquadbuffered( "experienceToPrestige", self._ID33067["other"] );
    }

    if ( game["state"] == "postgame" )
        return;

    self._ID33067["allies"] = 0;
    self._ID33067["axis"] = 0;
    self._ID33067["other"] = 0;
}

_ID34626()
{
    if ( game["state"] != "playing" )
        return;

    self.pers["teamTime"] = gettime();
}

_ID34621()
{
    for (;;)
    {
        var_0 = getdvarint( "scr_teambalance" );

        if ( level._ID32651 != var_0 )
            level._ID32651 = getdvarint( "scr_teambalance" );

        wait 1;
    }
}

_ID34620()
{
    level._ID32665 = level._ID20723 / 2;
    level thread _ID34621();
    wait 0.15;

    if ( level._ID32651 && maps\mp\_utility::_ID18768() )
    {
        if ( isdefined( game["BalanceTeamsNextRound"] ) )
            iprintlnbold( &"MP_AUTOBALANCE_NEXT_ROUND" );

        level waittill( "restarting" );

        if ( isdefined( game["BalanceTeamsNextRound"] ) )
        {
            level balanceteams();
            game["BalanceTeamsNextRound"] = undefined;
            return;
        }

        if ( !getteambalance() )
        {
            game["BalanceTeamsNextRound"] = 1;
            return;
        }

        return;
        return;
    }

    level endon( "game_ended" );

    for (;;)
    {
        if ( level._ID32651 )
        {
            if ( !getteambalance() )
            {
                iprintlnbold( &"MP_AUTOBALANCE_SECONDS", 15 );
                wait 15.0;

                if ( !getteambalance() )
                    level balanceteams();
            }

            wait 59.0;
        }

        wait 1.0;
    }

    return;
}

getteambalance()
{
    level.team["allies"] = 0;
    level.team["axis"] = 0;
    var_0 = level.players;

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( isdefined( var_0[var_1].pers["team"] ) && var_0[var_1].pers["team"] == "allies" )
        {
            level.team["allies"]++;
            continue;
        }

        if ( isdefined( var_0[var_1].pers["team"] ) && var_0[var_1].pers["team"] == "axis" )
            level.team["axis"]++;
    }

    if ( level.team["allies"] > level.team["axis"] + level._ID32651 || level.team["axis"] > level.team["allies"] + level._ID32651 )
    {
        return 0;
        return;
    }

    return 1;
    return;
}

balanceteams()
{
    iprintlnbold( game["strings"]["autobalance"] );
    var_0 = [];
    var_1 = [];
    var_2 = level.players;

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        if ( !isdefined( var_2[var_3].pers["teamTime"] ) )
            continue;

        if ( isdefined( var_2[var_3].pers["team"] ) && var_2[var_3].pers["team"] == "allies" )
        {
            var_0[var_0.size] = var_2[var_3];
            continue;
        }

        if ( isdefined( var_2[var_3].pers["team"] ) && var_2[var_3].pers["team"] == "axis" )
            var_1[var_1.size] = var_2[var_3];
    }

    var_4 = undefined;

    while ( var_0.size > var_1.size + 1 || var_1.size > var_0.size + 1 )
    {
        if ( var_0.size > var_1.size + 1 )
        {
            for ( var_5 = 0; var_5 < var_0.size; var_5++ )
            {
                if ( isdefined( var_0[var_5]._ID10647 ) )
                    continue;

                if ( !isdefined( var_4 ) )
                {
                    var_4 = var_0[var_5];
                    continue;
                }

                if ( var_0[var_5].pers["teamTime"] > var_4.pers["teamTime"] )
                    var_4 = var_0[var_5];
            }

            var_4 [[ level._ID22912 ]]( "axis" );
        }
        else if ( var_1.size > var_0.size + 1 )
        {
            for ( var_5 = 0; var_5 < var_1.size; var_5++ )
            {
                if ( isdefined( var_1[var_5]._ID10647 ) )
                    continue;

                if ( !isdefined( var_4 ) )
                {
                    var_4 = var_1[var_5];
                    continue;
                }

                if ( var_1[var_5].pers["teamTime"] > var_4.pers["teamTime"] )
                    var_4 = var_1[var_5];
            }

            var_4 [[ level._ID22912 ]]( "allies" );
        }

        var_4 = undefined;
        var_0 = [];
        var_1 = [];
        var_2 = level.players;

        for ( var_3 = 0; var_3 < var_2.size; var_3++ )
        {
            if ( isdefined( var_2[var_3].pers["team"] ) && var_2[var_3].pers["team"] == "allies" )
            {
                var_0[var_0.size] = var_2[var_3];
                continue;
            }

            if ( isdefined( var_2[var_3].pers["team"] ) && var_2[var_3].pers["team"] == "axis" )
                var_1[var_1.size] = var_2[var_3];
        }
    }
}

setplayermodels()
{
    _ID28694();
    game["allies_model"]["JUGGERNAUT"] = maps\mp\killstreaks\_juggernaut::setjugg;
    game["axis_model"]["JUGGERNAUT"] = maps\mp\killstreaks\_juggernaut::setjugg;
    game["allies_model"]["JUGGERNAUT_MANIAC"] = maps\mp\killstreaks\_juggernaut::_ID28762;
    game["axis_model"]["JUGGERNAUT_MANIAC"] = maps\mp\killstreaks\_juggernaut::_ID28762;
}

_ID24521( var_0, var_1 )
{

}

_ID8068()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < level._ID32668.size; var_1++ )
        var_0[level._ID32668[var_1]] = 0;

    for ( var_1 = 0; var_1 < level.players.size; var_1++ )
    {
        if ( level.players[var_1] == self )
            continue;

        if ( level.players[var_1].pers["team"] == "spectator" )
            continue;

        if ( isdefined( level.players[var_1].pers["team"] ) )
            var_0[level.players[var_1].pers["team"]]++;
    }

    return var_0;
}

_ID28694()
{
    if ( !isdefined( level.defaultheadmodels ) )
    {
        level.defaultheadmodels = [];
        level.defaultheadmodels["allies"] = "head_mp_head_a";
        level.defaultheadmodels["axis"] = "head_mp_head_a";
    }

    if ( !isdefined( level.defaultbodymodels ) )
    {
        level.defaultbodymodels = [];
        level.defaultbodymodels["allies"] = "mp_body_us_rangers_assault_a_urban";
        level.defaultbodymodels["axis"] = "mp_body_us_rangers_assault_a_woodland";
    }

    if ( !isdefined( level._ID9412 ) )
    {
        level._ID9412 = [];
        level._ID9412["allies"] = "viewhands_us_rangers_urban";
        level._ID9412["axis"] = "viewhands_us_rangers_woodland";
    }

    if ( !isdefined( level._ID9413 ) )
    {
        level._ID9413 = [];
        level._ID9413["allies"] = "delta";
        level._ID9413["axis"] = "delta";
        return;
    }
}

_ID28672( var_0, var_1, var_2 )
{
    self setmodel( var_0 );
    self setviewmodel( var_2 );
    self attach( var_1, "", 1 );
    self._ID16458 = var_1;
}

_ID28787()
{
    var_0 = self getcustomizationbody();
    var_1 = self getcustomizationhead();
    var_2 = self getcustomizationviewmodel();
    _ID28672( var_0, var_1, var_2 );
}

setdefaultmodel()
{
    var_0 = level.defaultbodymodels[self.team];
    var_1 = level.defaultheadmodels[self.team];
    var_2 = level._ID9412[self.team];
    _ID28672( var_0, var_1, var_2 );
}

getplayermodelindex()
{
    if ( level._ID25418 )
    {
        return self getrankedplayerdata( "squadMembers", self.pers["activeSquadMember"], "body" );
        return;
    }

    return self getprivateplayerdata( "privateMatchSquadMembers", self.pers["activeSquadMember"], "body" );
    return;
}

getplayerfoleytype( var_0 )
{
    return tablelookup( "mp/cac/bodies.csv", 0, var_0, 5 );
}

getplayermodelname( var_0 )
{
    return tablelookup( "mp/cac/bodies.csv", 0, var_0, 1 );
}

_ID29189()
{
    if ( isplayer( self ) )
        _ID28787();
    else
        setdefaultmodel();

    if ( !isai( self ) )
    {
        var_0 = getplayermodelindex();
        self.bodyindex = var_0;
        var_1 = getplayerfoleytype( var_0 );
        self setclothtype( var_1 );
    }
    else
        self setclothtype( "vestLight" );

    self._ID35390 = level._ID9413[self.team];

    if ( maps\mp\_utility::isanymlgmatch() && !isai( self ) )
    {
        var_2 = getplayermodelname( getplayermodelindex() );

        if ( issubstr( var_2, "fullbody_sniper" ) )
            thread forcedefaultmodel();
    }

    if ( maps\mp\_utility::_ID18666() )
    {
        if ( isdefined( self._ID18669 ) && self._ID18669 )
        {
            thread [[ game[self.team + "_model"]["JUGGERNAUT_MANIAC"] ]]();
            return;
        }

        if ( isdefined( self.isjuggernautlevelcustom ) && self.isjuggernautlevelcustom )
        {
            thread [[ game[self.team + "_model"]["JUGGERNAUT_CUSTOM"] ]]();
            return;
        }

        thread [[ game[self.team + "_model"]["JUGGERNAUT"] ]]();
        return;
        return;
        return;
    }
}

forcedefaultmodel()
{
    if ( isdefined( self._ID16458 ) )
    {
        self detach( self._ID16458, "" );
        self._ID16458 = undefined;
    }

    if ( self.team == "axis" )
    {
        self setmodel( "mp_body_juggernaut_light_black" );
        self setviewmodel( "viewhands_juggernaut_ally" );
    }
    else
    {
        self setmodel( "mp_body_infected_a" );
        self setviewmodel( "viewhands_gs_hostage" );
    }

    if ( isdefined( self._ID16458 ) )
    {
        self detach( self._ID16458, "" );
        self._ID16458 = undefined;
    }

    self attach( "head_mp_infected", "", 1 );
    self._ID16458 = "head_mp_infected";
    self setclothtype( "cloth" );
}

_ID33299()
{
    self endon( "disconnect" );
    self._ID33067["allies"] = 0;
    self._ID33067["axis"] = 0;
    self._ID33067["other"] = 0;
    self._ID33067["total"] = 0;

    for (;;)
    {
        if ( game["state"] == "playing" )
        {
            if ( isdefined( self.pers["team"] ) && self.pers["team"] == "allies" && self.sessionteam != "spectator" )
            {
                self._ID33067["allies"]++;
                self._ID33067["total"]++;
            }
            else if ( isdefined( self.pers["team"] ) && self.pers["team"] == "axis" && self.sessionteam != "spectator" )
            {
                self._ID33067["axis"]++;
                self._ID33067["total"]++;
            }
            else
                self._ID33067["other"]++;
        }

        wait 1.0;
    }
}

_ID34538()
{
    if ( !level._ID25418 )
        return;

    var_0 = 0;

    for (;;)
    {
        var_0++;

        if ( var_0 >= level.players.size )
            var_0 = 0;

        if ( isdefined( level.players[var_0] ) )
            level.players[var_0] updatefreeplayedtime();

        wait 1.0;
    }
}

updatefreeplayedtime()
{
    if ( !maps\mp\_utility::_ID25420() )
        return;

    if ( isai( self ) )
        return;

    if ( self._ID33067["allies"] )
    {
        if ( !issquadsmode() )
        {
            maps\mp\gametypes\_persistence::_ID31496( "timePlayedAllies", self._ID33067["allies"] );
            maps\mp\gametypes\_persistence::_ID31496( "timePlayedTotal", self._ID33067["allies"] );
        }

        maps\mp\gametypes\_persistence::_ID31499( "round", "timePlayed", self._ID33067["allies"] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 0, self._ID33067["allies"], self._ID6162["xpMaxMultiplierTimePlayed"][0] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 1, self._ID33067["allies"], self._ID6162["xpMaxMultiplierTimePlayed"][1] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 2, self._ID33067["allies"], self._ID6162["xpMaxMultiplierTimePlayed"][2] );

        if ( issquadsmode() )
        {
            maps\mp\gametypes\_persistence::_ID31497( "prestigeDoubleXpTimePlayed", self._ID33067["allies"], self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"] );
            maps\mp\gametypes\_persistence::_ID31497( "prestigeDoubleWeaponXpTimePlayed", self._ID33067["allies"], self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"] );
        }
    }

    if ( self._ID33067["axis"] )
    {
        if ( !issquadsmode() )
        {
            maps\mp\gametypes\_persistence::_ID31496( "timePlayedOpfor", self._ID33067["axis"] );
            maps\mp\gametypes\_persistence::_ID31496( "timePlayedTotal", self._ID33067["axis"] );
        }

        maps\mp\gametypes\_persistence::_ID31499( "round", "timePlayed", self._ID33067["axis"] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 0, self._ID33067["axis"], self._ID6162["xpMaxMultiplierTimePlayed"][0] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 1, self._ID33067["axis"], self._ID6162["xpMaxMultiplierTimePlayed"][1] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 2, self._ID33067["axis"], self._ID6162["xpMaxMultiplierTimePlayed"][2] );

        if ( issquadsmode() )
        {
            maps\mp\gametypes\_persistence::_ID31497( "prestigeDoubleXpTimePlayed", self._ID33067["axis"], self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"] );
            maps\mp\gametypes\_persistence::_ID31497( "prestigeDoubleWeaponXpTimePlayed", self._ID33067["axis"], self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"] );
        }
    }

    if ( self._ID33067["other"] )
    {
        if ( !issquadsmode() )
        {
            maps\mp\gametypes\_persistence::_ID31496( "timePlayedOther", self._ID33067["other"] );
            maps\mp\gametypes\_persistence::_ID31496( "timePlayedTotal", self._ID33067["other"] );
        }

        maps\mp\gametypes\_persistence::_ID31499( "round", "timePlayed", self._ID33067["other"] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 0, self._ID33067["other"], self._ID6162["xpMaxMultiplierTimePlayed"][0] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 1, self._ID33067["other"], self._ID6162["xpMaxMultiplierTimePlayed"][1] );
        maps\mp\gametypes\_persistence::_ID31500( "xpMultiplierTimePlayed", 2, self._ID33067["other"], self._ID6162["xpMaxMultiplierTimePlayed"][2] );

        if ( issquadsmode() )
        {
            maps\mp\gametypes\_persistence::_ID31497( "prestigeDoubleXpTimePlayed", self._ID33067["other"], self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"] );
            maps\mp\gametypes\_persistence::_ID31497( "prestigeDoubleWeaponXpTimePlayed", self._ID33067["other"], self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"] );
        }
    }

    if ( game["state"] == "postgame" )
        return;

    self._ID33067["allies"] = 0;
    self._ID33067["axis"] = 0;
    self._ID33067["other"] = 0;
}

_ID15072( var_0 )
{
    if ( maps\mp\_utility::_ID18363() )
        return 1;

    var_1 = 0;
    var_2 = 0;
    var_3 = level.players;

    for ( var_4 = 0; var_4 < var_3.size; var_4++ )
    {
        var_5 = var_3[var_4];

        if ( isdefined( var_5.pers["team"] ) && var_5.pers["team"] == var_0 )
        {
            var_1++;

            if ( isbot( var_5 ) )
                var_2++;
        }
    }

    if ( var_1 < level._ID32665 )
    {
        return 1;
        return;
    }

    if ( var_2 > 0 )
    {
        return 1;
        return;
    }

    if ( !maps\mp\_utility::_ID20673() )
    {
        return 1;
        return;
    }

    if ( level._ID14086 == "infect" )
    {
        return 1;
        return;
    }

    return 0;
    return;
    return;
    return;
    return;
}

onplayerspawned()
{
    level endon( "game_ended" );

    for (;;)
        self waittill( "spawned_player" );
}

_ID21751( var_0 )
{
    return tablelookupistring( "mp/MTTable.csv", 0, var_0, 1 );
}

_ID21750( var_0 )
{
    return tablelookup( "mp/MTTable.csv", 0, var_0, 2 );
}

_ID21749( var_0 )
{
    return tablelookup( "mp/MTTable.csv", 0, var_0, 3 );
}

_ID15421( var_0 )
{
    return tablelookupistring( "mp/factionTable.csv", 0, game[var_0], 1 );
}

_ID15422( var_0 )
{
    return tablelookupistring( "mp/factionTable.csv", 0, game[var_0], 2 );
}

getteamforfeitedstring( var_0 )
{
    return tablelookupistring( "mp/factionTable.csv", 0, game[var_0], 4 );
}

_ID15409( var_0 )
{
    return tablelookupistring( "mp/factionTable.csv", 0, game[var_0], 3 );
}

_ID15418( var_0 )
{
    return tablelookup( "mp/factionTable.csv", 0, game[var_0], 5 );
}

getteamhudicon( var_0 )
{
    return tablelookup( "mp/factionTable.csv", 0, game[var_0], 6 );
}

_ID15416( var_0 )
{
    return tablelookup( "mp/factionTable.csv", 0, game[var_0], 17 );
}

getteamvoiceprefix( var_0 )
{
    return tablelookup( "mp/factionTable.csv", 0, game[var_0], 7 );
}

getteamspawnmusic( var_0 )
{
    return tablelookup( "mp/factionTable.csv", 0, game[var_0], 8 );
}

getteamwinmusic( var_0 )
{
    return tablelookup( "mp/factionTable.csv", 0, game[var_0], 9 );
}

getteamflagmodel( var_0 )
{
    return tablelookup( "mp/factionTable.csv", 0, game[var_0], 10 );
}

_ID15410( var_0 )
{
    return tablelookup( "mp/factionTable.csv", 0, game[var_0], 11 );
}

_ID15413( var_0 )
{
    return tablelookup( "mp/factionTable.csv", 0, game[var_0], 12 );
}

_ID15412( var_0 )
{
    return tablelookup( "mp/factionTable.csv", 0, game[var_0], 13 );
}

getteamcolor( var_0 )
{
    return ( maps\mp\_utility::_ID31977( tablelookup( "mp/factionTable.csv", 0, game[var_0], 14 ) ), maps\mp\_utility::_ID31977( tablelookup( "mp/factionTable.csv", 0, game[var_0], 15 ) ), maps\mp\_utility::_ID31977( tablelookup( "mp/factionTable.csv", 0, game[var_0], 16 ) ) );
}

getteamcratemodel( var_0 )
{
    return tablelookup( "mp/factionTable.csv", 0, game[var_0], 18 );
}

getteamdeploymodel( var_0 )
{
    return tablelookup( "mp/factionTable.csv", 0, game[var_0], 19 );
}
