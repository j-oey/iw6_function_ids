// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

gethighestscoringplayer()
{
    _ID34574();

    if ( !level._ID23663["all"].size )
    {
        return undefined;
        return;
    }

    return level._ID23663["all"][0];
    return;
}

getlosingplayers()
{
    _ID34574();
    var_0 = level._ID23663["all"];
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( var_3 == level._ID23663["all"][0] )
            continue;

        var_1[var_1.size] = var_3;
    }

    return var_1;
}

_ID15616( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( maps\mp\_utility::_ID18363() )
    {
        return;
        return;
    }

    _ID15617( var_0, var_1, var_2, var_3, var_4, var_5 );
    return;
}

_ID15617( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( isdefined( var_1.owner ) && !isbot( var_1 ) )
        var_1 = var_1.owner;

    if ( !isbot( var_1 ) )
    {
        if ( isdefined( var_1.commanding_bot ) )
            var_1 = var_1.commanding_bot;
    }

    if ( !isplayer( var_1 ) )
        return;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_4 ) )
        var_4 = 0;

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    var_6 = var_1.pers["score"];
    _ID22888( var_0, var_1, var_2, var_5 );
    var_7 = var_1.pers["score"] - var_6;

    if ( var_7 == 0 )
        return;

    if ( var_5 )
        var_7 = int( var_7 * 10 );

    var_8 = maps\mp\gametypes\_rank::_ID15328( var_0 );

    if ( !var_1 maps\mp\_utility::_ID25420() && !level.hardcoremode && !var_4 )
    {
        if ( _ID37244( level._ID14086 ) )
            var_1 thread maps\mp\gametypes\_rank::_ID36471( var_8 );
        else
            var_1 thread maps\mp\gametypes\_rank::_ID36471( var_7 );
    }

    if ( _ID37244( level._ID14086 ) )
        var_1 maps\mp\gametypes\_persistence::_ID31495( "score", var_8 );
    else if ( !issquadsmode() )
        var_1 maps\mp\gametypes\_persistence::_ID31495( "score", var_7 );

    if ( var_1.pers["score"] >= 65000 )
        var_1.pers["score"] = 65000;

    var_1.score = var_1.pers["score"];
    var_9 = var_1.score;

    if ( var_5 )
        var_9 = int( var_9 * 10 );

    if ( _ID37244( level._ID14086 ) )
        var_1 maps\mp\gametypes\_persistence::_ID31528( "round", "score", var_9 * var_8 );
    else
        var_1 maps\mp\gametypes\_persistence::_ID31528( "round", "score", var_9 );

    if ( !level._ID32653 )
        thread _ID28062();

    if ( !var_3 )
        var_1 maps\mp\gametypes\_gamelogic::checkplayerscorelimitsoon();

    var_10 = var_1 maps\mp\gametypes\_gamelogic::_ID7127();
}

_ID22888( var_0, var_1, var_2, var_3 )
{
    var_4 = undefined;

    if ( isdefined( level._ID22888 ) )
        var_4 = [[ level._ID22888 ]]( var_0, var_1, var_2 );

    if ( !isdefined( var_4 ) )
        var_4 = maps\mp\gametypes\_rank::_ID15328( var_0 );

    var_4 *= level.objectivepointsmod;

    if ( var_3 )
        var_4 = int( var_4 / 10 );

    var_1.pers["score"] = var_1.pers["score"] + var_4;
}

_setplayerscore( var_0, var_1 )
{
    if ( var_1 == var_0.pers["score"] )
        return;

    if ( var_1 < 0 )
        return;

    var_0.pers["score"] = var_1;
    var_0.score = var_0.pers["score"];
    var_0 thread maps\mp\gametypes\_gamelogic::_ID7127();
}

_getplayerscore( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = self;

    return var_0.pers["score"];
}

giveteamscoreforobjective( var_0, var_1 )
{
    var_1 *= level.objectivepointsmod;
    _setteamscore( var_0, _ID1699( var_0 ) + var_1 );
    level notify( "update_team_score",  var_0, _ID1699( var_0 )  );
    var_2 = _ID15494();

    if ( !level.splitscreen && var_2 != "none" && var_2 != level._ID35918 && gettime() - level.laststatustime > 5000 && maps\mp\_utility::getscorelimit() != 1 )
    {
        level.laststatustime = gettime();
        maps\mp\_utility::_ID19760( "lead_taken", var_2, "status" );

        if ( level._ID35918 != "none" )
            maps\mp\_utility::_ID19760( "lead_lost", level._ID35918, "status" );
    }

    if ( var_2 != "none" )
    {
        level._ID35918 = var_2;
        var_3 = _ID1699( var_2 );
        var_4 = maps\mp\_utility::getwatcheddvar( "scorelimit" );

        if ( var_3 == 0 || var_4 == 0 )
            return;

        var_5 = var_3 / var_4 * 100;

        if ( var_5 > level._ID27363 )
        {
            setnojipscore( 1 );
            return;
        }

        return;
    }
}

_ID15494()
{
    var_0 = level._ID32668;

    if ( !isdefined( level._ID35918 ) )
        level._ID35918 = "none";

    var_1 = "none";
    var_2 = 0;

    if ( level._ID35918 != "none" )
    {
        var_1 = level._ID35918;
        var_2 = game["teamScores"][level._ID35918];
    }

    var_3 = 1;

    foreach ( var_5 in var_0 )
    {
        if ( var_5 == level._ID35918 )
            continue;

        if ( game["teamScores"][var_5] > var_2 )
        {
            var_1 = var_5;
            var_2 = game["teamScores"][var_5];
            var_3 = 1;
            continue;
        }

        if ( game["teamScores"][var_5] == var_2 )
        {
            var_3 += 1;
            var_1 = "none";
        }
    }

    return var_1;
}

_setteamscore( var_0, var_1 )
{
    if ( var_1 == game["teamScores"][var_0] )
        return;

    game["teamScores"][var_0] = var_1;
    _ID34624( var_0 );

    if ( game["status"] == "overtime" && !isdefined( level._ID23181 ) || isdefined( level._ID23181 ) && !level._ID23181 )
    {
        thread maps\mp\gametypes\_gamelogic::onscorelimit();
        return;
    }

    thread maps\mp\gametypes\_gamelogic::_ID7130( var_0 );
    thread maps\mp\gametypes\_gamelogic::_ID7127();
    return;
}

_ID34624( var_0 )
{
    var_1 = 0;

    if ( !maps\mp\_utility::_ID18768() || !maps\mp\_utility::_ID18716() || level._ID14086 == "blitz" )
        var_1 = _ID1699( var_0 );
    else
        var_1 = game["roundsWon"][var_0];

    setteamscore( var_0, var_1 );
}

_ID1699( var_0 )
{
    return game["teamScores"][var_0];
}

_ID28063()
{
    level notify( "updating_scores" );
    level endon( "updating_scores" );
    wait 0.05;
    maps\mp\_utility::_ID35777();

    foreach ( var_1 in level.players )
        var_1 updatescores();
}

_ID28062()
{
    level notify( "updating_dm_scores" );
    level endon( "updating_dm_scores" );
    wait 0.05;
    maps\mp\_utility::_ID35777();

    for ( var_0 = 0; var_0 < level.players.size; var_0++ )
    {
        level.players[var_0] updatedmscores();
        level.players[var_0]._ID34529 = 1;
    }
}

_ID25991()
{
    var_0 = 0;
    var_1 = level._ID23663["all"].size;
    var_2 = 0;

    for ( var_3 = 0; var_3 < var_1; var_3++ )
    {
        if ( level._ID23663["all"][var_3] == self )
            var_2 = 1;

        if ( var_2 )
            level._ID23663["all"][var_3] = level._ID23663["all"][var_3 + 1];
    }

    if ( !var_2 )
        return;

    level._ID23663["all"][var_1 - 1] = undefined;

    if ( level.multiteambased )
        _ID21752();

    if ( level._ID32653 )
    {
        updateteamplacement();
        return;
    }

    var_1 = level._ID23663["all"].size;

    for ( var_3 = 0; var_3 < var_1; var_3++ )
    {
        var_4 = level._ID23663["all"][var_3];
        var_4 notify( "update_outcome" );
    }
}

_ID34574()
{
    var_0 = [];

    foreach ( var_2 in level.players )
    {
        if ( isdefined( var_2.connectedpostgame ) )
            continue;

        if ( var_2.pers["team"] == "spectator" || var_2.pers["team"] == "none" )
            continue;

        var_0[var_0.size] = var_2;
    }

    for ( var_4 = 1; var_4 < var_0.size; var_4++ )
    {
        var_2 = var_0[var_4];
        var_5 = var_2.score;

        for ( var_6 = var_4 - 1; var_6 >= 0 && getbetterplayer( var_2, var_0[var_6] ) == var_2; var_6-- )
            var_0[var_6 + 1] = var_0[var_6];

        var_0[var_6 + 1] = var_2;
    }

    level._ID23663["all"] = var_0;

    if ( level.multiteambased )
        _ID21752();
    else if ( level._ID32653 )
        updateteamplacement();
}

getbetterplayer( var_0, var_1 )
{
    if ( var_0.score > var_1.score )
        return var_0;

    if ( var_1.score > var_0.score )
        return var_1;

    if ( var_0.deaths < var_1.deaths )
        return var_0;

    if ( var_1.deaths < var_0.deaths )
        return var_1;

    if ( common_scripts\utility::_ID7657() )
    {
        return var_0;
        return;
    }

    return var_1;
    return;
}

updateteamplacement()
{
    var_0["allies"] = [];
    var_0["axis"] = [];
    var_0["spectator"] = [];
    var_1 = level._ID23663["all"];
    var_2 = var_1.size;

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = var_1[var_3];
        var_5 = var_4.pers["team"];
        var_0[var_5][var_0[var_5].size] = var_4;
    }

    level._ID23663["allies"] = var_0["allies"];
    level._ID23663["axis"] = var_0["axis"];
}

_ID21752()
{
    var_0["spectator"] = [];

    foreach ( var_2 in level._ID32668 )
        var_0[var_2] = [];

    var_4 = level._ID23663["all"];
    var_5 = var_4.size;

    for ( var_6 = 0; var_6 < var_5; var_6++ )
    {
        var_7 = var_4[var_6];
        var_8 = var_7.pers["team"];
        var_0[var_8][var_0[var_8].size] = var_7;
    }

    foreach ( var_2 in level._ID32668 )
        level._ID23663[var_2] = var_0[var_2];
}

initialdmscoreupdate()
{
    wait 0.2;
    var_0 = 0;

    for (;;)
    {
        var_1 = 0;
        var_2 = level.players;

        for ( var_3 = 0; var_3 < var_2.size; var_3++ )
        {
            var_4 = var_2[var_3];

            if ( !isdefined( var_4 ) )
                continue;

            if ( isdefined( var_4._ID34529 ) )
                continue;

            var_4._ID34529 = 1;
            var_4 updatedmscores();
            var_1 = 1;
            wait 0.5;
        }

        if ( !var_1 )
            wait 3;
    }
}

processassist( var_0 )
{
    if ( isdefined( level._ID3995 ) )
        return;

    if ( maps\mp\_utility::_ID18363() )
    {
        return;
        return;
    }

    _ID25037( var_0 );
    return;
}

_ID25037( var_0 )
{
    self endon( "disconnect" );
    var_0 endon( "disconnect" );
    wait 0.05;
    maps\mp\_utility::_ID35777();
    var_1 = self.pers["team"];

    if ( var_1 != "axis" && var_1 != "allies" )
        return;

    if ( var_1 == var_0.pers["team"] )
        return;

    var_2 = self;

    if ( isdefined( self.commanding_bot ) )
        var_2 = self.commanding_bot;

    var_2 thread [[ level._ID22924 ]]( "assist" );
    var_2 maps\mp\_utility::_ID17529( "assists", 1 );
    var_2.assists = var_2 maps\mp\_utility::_ID15245( "assists" );
    var_2 maps\mp\_utility::_ID17531( "assists", 1 );
    var_2 maps\mp\gametypes\_persistence::_ID31528( "round", "assists", var_2.assists );
    _ID15616( "assist", self, var_0 );
    maps\mp\killstreaks\_killstreaks::_ID15579( "assist" );
    thread maps\mp\gametypes\_missions::_ID24469( var_0 );
}

_ID25046( var_0 )
{
    if ( isdefined( level._ID3995 ) )
        return;

    if ( maps\mp\_utility::_ID18363() )
    {
        return;
        return;
    }

    _ID25047( var_0 );
    return;
}

_ID25047( var_0 )
{
    self endon( "disconnect" );
    var_0 endon( "disconnect" );
    wait 0.05;
    maps\mp\_utility::_ID35777();

    if ( self.pers["team"] != "axis" && self.pers["team"] != "allies" )
        return;

    if ( self.pers["team"] == var_0.pers["team"] )
        return;

    self thread [[ level._ID22924 ]]( "assist" );
    self thread [[ level._ID22924 ]]( "assist" );
    maps\mp\_utility::_ID17529( "assists", 1 );
    self.assists = maps\mp\_utility::_ID15245( "assists" );
    maps\mp\_utility::_ID17531( "assists", 1 );
    maps\mp\gametypes\_persistence::_ID31528( "round", "assists", self.assists );
    _ID15616( "assist", self, var_0 );
    thread maps\mp\gametypes\_hud_message::_ID31053( "shield_assist" );
    thread maps\mp\gametypes\_missions::_ID24469( var_0 );
}

_ID37244( var_0 )
{
    return var_0 == "dm" || var_0 == "sotf_ffa";
}
