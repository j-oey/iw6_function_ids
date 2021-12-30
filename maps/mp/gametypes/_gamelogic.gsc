// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID22845( var_0 )
{
    if ( isdefined( level.forfeitinprogress ) )
        return;

    level endon( "abort_forfeit" );
    level thread forfeitwaitforabort();
    level.forfeitinprogress = 1;

    if ( !level._ID32653 && level.players.size > 1 )
        wait 10;
    else
        wait 1.05;

    level._ID13542 = 0;
    var_1 = 20.0;
    _ID20671( var_1 );
    var_2 = &"";

    if ( !isdefined( var_0 ) )
    {
        level.finalkillcam_winner = "none";
        var_2 = game["end_reason"]["players_forfeited"];
        var_3 = level.players[0];
    }
    else if ( var_0 == "axis" )
    {
        level.finalkillcam_winner = "axis";
        var_2 = game["end_reason"]["allies_forfeited"];
        var_3 = "axis";
    }
    else if ( var_0 == "allies" )
    {
        level.finalkillcam_winner = "allies";
        var_2 = game["end_reason"]["axis_forfeited"];
        var_3 = "allies";
    }
    else if ( level.multiteambased && issubstr( var_0, "team_" ) )
        var_3 = var_0;
    else
    {
        level.finalkillcam_winner = "none";
        var_3 = "tie";
    }

    level.forcedend = 1;

    if ( isplayer( var_3 ) )
        logstring( "forfeit, win: " + var_3 getxuid() + "(" + var_3.name + ")" );
    else
        logstring( "forfeit, win: " + var_3 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );

    thread endgame( var_3, var_2 );
}

forfeitwaitforabort()
{
    level endon( "game_ended" );
    level waittill( "abort_forfeit" );
    level._ID13542 = 1;
    setomnvar( "ui_match_start_countdown", 0 );
}

_ID20672( var_0 )
{
    waittillframeend;
    level endon( "match_forfeit_timer_beginning" );

    while ( var_0 > 0 && !level.gameended && !level._ID13542 && !level._ID17628 )
    {
        setomnvar( "ui_match_start_countdown", var_0 );
        var_0--;
        maps\mp\gametypes\_hostmigration::_ID35597( 1.0 );
    }

    setomnvar( "ui_match_start_countdown", 0 );
}

_ID20671( var_0 )
{
    level notify( "match_forfeit_timer_beginning" );
    var_1 = int( var_0 );
    setomnvar( "ui_match_start_text", "opponent_forfeiting_in" );
    _ID20672( var_1 );
}

default_ondeadevent( var_0 )
{
    level.finalkillcam_winner = "none";

    if ( var_0 == "allies" )
    {
        iprintln( &"MP_GHOSTS_ELIMINATED" );
        logstring( "team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
        level.finalkillcam_winner = "axis";
        thread endgame( "axis", game["end_reason"]["allies_eliminated"] );
        return;
    }

    if ( var_0 == "axis" )
    {
        iprintln( &"MP_FEDERATION_ELIMINATED" );
        logstring( "team eliminated, win: allies, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
        level.finalkillcam_winner = "allies";
        thread endgame( "allies", game["end_reason"]["axis_eliminated"] );
        return;
    }

    logstring( "tie, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
    level.finalkillcam_winner = "none";

    if ( level._ID32653 )
    {
        thread endgame( "tie", game["end_reason"]["tie"] );
        return;
    }

    thread endgame( undefined, game["end_reason"]["tie"] );
    return;
    return;
    return;
}

default_ononeleftevent( var_0 )
{
    if ( level._ID32653 )
    {
        var_1 = maps\mp\_utility::_ID15113( var_0 );

        if ( isdefined( var_1 ) )
            var_1 thread _ID15604();
    }
    else
    {
        var_1 = maps\mp\_utility::_ID15113();
        logstring( "last one alive, win: " + var_1.name );
        level.finalkillcam_winner = "none";
        thread endgame( var_1, game["end_reason"]["enemies_eliminated"] );
    }

    return 1;
}

_ID9379()
{
    var_0 = undefined;
    level.finalkillcam_winner = "none";

    if ( level._ID32653 )
    {
        if ( game["teamScores"]["allies"] == game["teamScores"]["axis"] )
            var_0 = "tie";
        else if ( game["teamScores"]["axis"] > game["teamScores"]["allies"] )
        {
            level.finalkillcam_winner = "axis";
            var_0 = "axis";
        }
        else
        {
            level.finalkillcam_winner = "allies";
            var_0 = "allies";
        }

        logstring( "time limit, win: " + var_0 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
    }
    else
    {
        var_0 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();

        if ( isdefined( var_0 ) )
            logstring( "time limit, win: " + var_0.name );
        else
            logstring( "time limit, tie" );
    }

    thread endgame( var_0, game["end_reason"]["time_limit_reached"] );
}

_ID9377()
{
    var_0 = undefined;
    level.finalkillcam_winner = "none";
    thread endgame( "halftime", game["end_reason"]["time_limit_reached"] );
}

_ID13521( var_0 )
{
    if ( level._ID17093 || level.forcedend )
        return;

    var_1 = undefined;
    level.finalkillcam_winner = "none";

    if ( level._ID32653 )
    {
        if ( getdvarint( "squad_match" ) == 1 && isdefined( var_0 ) && var_0 == 2 )
            var_1 = "axis";
        else if ( game["teamScores"]["allies"] == game["teamScores"]["axis"] )
            var_1 = "tie";
        else if ( game["teamScores"]["axis"] > game["teamScores"]["allies"] )
        {
            level.finalkillcam_winner = "axis";
            var_1 = "axis";
        }
        else
        {
            level.finalkillcam_winner = "allies";
            var_1 = "allies";
        }

        logstring( "host ended game, win: " + var_1 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
    }
    else
    {
        var_1 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();

        if ( isdefined( var_1 ) )
            logstring( "host ended game, win: " + var_1.name );
        else
            logstring( "host ended game, tie" );
    }

    level.forcedend = 1;
    level._ID17093 = 1;

    if ( level.splitscreen )
        var_2 = game["end_reason"]["ended_game"];
    else
        var_2 = game["end_reason"]["host_ended_game"];

    if ( isdefined( var_0 ) && var_0 == 2 )
        var_2 = game["end_reason"]["allies_forfeited"];

    level notify( "force_end" );
    thread endgame( var_1, var_2 );
}

onscorelimit()
{
    var_0 = game["end_reason"]["score_limit_reached"];
    var_1 = undefined;
    level.finalkillcam_winner = "none";

    if ( level.multiteambased )
    {
        var_1 = maps\mp\gametypes\_gamescore::_ID15494();

        if ( var_1 == "none" )
            var_1 = "tie";
    }
    else if ( level._ID32653 )
    {
        if ( game["teamScores"]["allies"] == game["teamScores"]["axis"] )
            var_1 = "tie";
        else if ( game["teamScores"]["axis"] > game["teamScores"]["allies"] )
        {
            var_1 = "axis";
            level.finalkillcam_winner = "axis";
        }
        else
        {
            var_1 = "allies";
            level.finalkillcam_winner = "allies";
        }

        logstring( "scorelimit, win: " + var_1 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
    }
    else
    {
        var_1 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();

        if ( isdefined( var_1 ) )
            logstring( "scorelimit, win: " + var_1.name );
        else
            logstring( "scorelimit, tie" );
    }

    thread endgame( var_1, var_0 );
    return 1;
}

_ID34542()
{
    if ( maps\mp\_utility::_ID20673() && !level._ID17628 && ( !isdefined( level._ID10157 ) || !level._ID10157 ) )
    {
        if ( level.multiteambased )
        {
            var_0 = 0;
            var_1 = 0;

            for ( var_2 = 0; var_2 < level._ID32668.size; var_2++ )
            {
                var_0 += level._ID32656[level._ID32668[var_2]];

                if ( level._ID32656[level._ID32668[var_2]] )
                    var_1 += 1;
            }

            for ( var_2 = 0; var_2 < level._ID32668.size; var_2++ )
            {
                if ( var_0 == level._ID32656[level._ID32668[var_2]] && game["state"] == "playing" )
                {
                    thread _ID22845( level._ID32668[var_2] );
                    return;
                }
            }

            if ( var_1 > 1 )
            {
                level.forfeitinprogress = undefined;
                level notify( "abort_forfeit" );
            }
        }
        else if ( level._ID32653 )
        {
            if ( level._ID32656["allies"] < 1 && level._ID32656["axis"] > 0 && game["state"] == "playing" )
            {
                thread _ID22845( "axis" );
                return;
            }

            if ( level._ID32656["axis"] < 1 && level._ID32656["allies"] > 0 && game["state"] == "playing" )
            {
                thread _ID22845( "allies" );
                return;
            }

            if ( level._ID32656["axis"] > 0 && level._ID32656["allies"] > 0 )
            {
                level.forfeitinprogress = undefined;
                level notify( "abort_forfeit" );
            }
        }
        else
        {
            if ( level._ID32656["allies"] + level._ID32656["axis"] == 1 && level._ID20754 > 1 )
            {
                thread _ID22845();
                return;
            }

            if ( level._ID32656["axis"] + level._ID32656["allies"] > 1 )
            {
                level.forfeitinprogress = undefined;
                level notify( "abort_forfeit" );
            }
        }
    }

    if ( !maps\mp\_utility::_ID15035() && ( !isdefined( level._ID10173 ) || !level._ID10173 ) )
        return;

    if ( !maps\mp\_utility::_ID14070() )
        return;

    if ( level._ID17628 )
        return;

    if ( level.multiteambased )
        return;

    if ( level._ID32653 )
    {
        var_3["allies"] = level._ID20088["allies"];
        var_3["axis"] = level._ID20088["axis"];

        if ( isdefined( level._ID10173 ) && level._ID10173 )
        {
            var_3["allies"] = 0;
            var_3["axis"] = 0;
        }

        if ( !level.alivecount["allies"] && !level.alivecount["axis"] && !var_3["allies"] && !var_3["axis"] )
            return [[ level._ID22796 ]]( "all" );

        if ( !level.alivecount["allies"] && !var_3["allies"] )
            return [[ level._ID22796 ]]( "allies" );

        if ( !level.alivecount["axis"] && !var_3["axis"] )
            return [[ level._ID22796 ]]( "axis" );

        var_4 = level.alivecount["allies"] == 1 && !var_3["allies"];
        var_5 = level.alivecount["axis"] == 1 && !var_3["axis"];

        if ( var_4 || var_5 )
        {
            var_6 = undefined;

            if ( var_4 && !isdefined( level._ID22814["allies"] ) )
            {
                level._ID22814["allies"] = gettime();
                var_7 = [[ level._ID22870 ]]( "allies" );

                if ( isdefined( var_7 ) )
                {
                    if ( !isdefined( var_6 ) )
                        var_6 = var_7;

                    var_6 = var_6 || var_7;
                }
            }

            if ( var_5 && !isdefined( level._ID22814["axis"] ) )
            {
                level._ID22814["axis"] = gettime();
                var_8 = [[ level._ID22870 ]]( "axis" );

                if ( isdefined( var_8 ) )
                {
                    if ( !isdefined( var_6 ) )
                        var_6 = var_8;

                    var_6 = var_6 || var_8;
                }
            }

            return var_6;
            return;
        }

        return;
    }

    if ( !level.alivecount["allies"] && !level.alivecount["axis"] && ( !level._ID20088["allies"] && !level._ID20088["axis"] ) )
        return [[ level._ID22796 ]]( "all" );

    var_9 = maps\mp\_utility::_ID15264();

    if ( var_9.size == 1 )
    {
        return [[ level._ID22870 ]]( "all" );
        return;
    }

    return;
}

_ID35767()
{
    if ( !isdefined( level.finalkillcam_winner ) )
        return 0;

    level waittill( "final_killcam_done" );
    return 1;
}

_ID33055( var_0 )
{
    setgameendtime( gettime() + int( var_0 * 1000 ) );
    var_1 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_1 hide();

    if ( var_0 >= 10.0 )
        wait(var_0 - 10.0);

    for (;;)
    {
        var_1 playsound( "ui_mp_timer_countdown" );
        wait 1.0;
    }
}

_ID35566( var_0 )
{
    var_1 = gettime();
    var_2 = var_1 + var_0 * 1000 - 200;

    if ( var_0 > 5 )
        var_3 = gettime() + getdvarint( "min_wait_for_players" ) * 1000;
    else
        var_3 = 0;

    var_4 = level.connectingplayers / 3;

    for (;;)
    {
        if ( isdefined( game["roundsPlayed"] ) && game["roundsPlayed"] )
            break;

        var_5 = level._ID20754;
        var_6 = gettime();

        if ( var_5 >= var_4 && var_6 > var_3 || var_6 > var_2 )
            break;

        wait 0.05;
    }
}

_ID24880()
{
    level endon( "game_ended" );
    level.connectingplayers = getdvarint( "party_partyPlayerCountNum" );

    if ( level._ID24880 > 0 )
        matchstarttimerwaitforplayers();
    else
        _ID20684();

    foreach ( var_1 in level.players )
    {
        var_1 maps\mp\_utility::_ID13582( 0 );
        var_1 enableweapons();

        if ( !isdefined( var_1.pers["team"] ) )
            continue;

        var_2 = var_1.pers["team"];
        var_3 = maps\mp\_utility::_ID15198( var_2 );

        if ( !isdefined( var_3 ) || !var_1.hasspawned )
            continue;

        var_4 = 0;

        if ( game["defenders"] == var_2 )
            var_4 = 1;

        var_1 setclientomnvar( "ui_objective_text", var_4 );
    }

    if ( game["state"] != "playing" )
    {
        return;
        return;
    }
}

_ID15760()
{
    level endon( "game_ended" );

    if ( !isdefined( game["clientActive"] ) )
    {
        while ( getactiveclientcount() == 0 )
            wait 0.05;

        game["clientActive"] = 1;
    }

    while ( level._ID17628 > 0 )
    {
        wait 1.0;
        level._ID17628--;
    }

    level notify( "grace_period_ending" );
    wait 0.05;
    maps\mp\_utility::_ID14068( "graceperiod_done" );
    level._ID17628 = 0;

    if ( game["state"] != "playing" )
        return;

    if ( maps\mp\_utility::_ID15035() )
    {
        var_0 = level.players;

        for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        {
            var_2 = var_0[var_1];

            if ( !var_2.hasspawned && var_2.sessionteam != "spectator" && !isalive( var_2 ) )
                var_2.statusicon = "hud_status_dead";
        }
    }

    level thread _ID34542();
}

_ID28745( var_0, var_1 )
{
    var_0.hasdonecombat = var_1;
    var_2 = !isdefined( var_0._ID16391 ) || !var_0._ID16391;

    if ( var_2 && var_1 )
    {
        var_0._ID16391 = 1;

        if ( isdefined( var_0.pers["hasMatchLoss"] ) && var_0.pers["hasMatchLoss"] )
            return;

        if ( !maps\mp\_utility::_ID18363() )
        {
            _ID34555( var_0 );
            return;
        }

        return;
    }
}

_ID34648( var_0 )
{
    if ( !var_0 maps\mp\_utility::_ID25420() )
        return;

    if ( !isdefined( var_0._ID16391 ) || !var_0._ID16391 )
        return;

    if ( !issquadsmode() )
    {
        var_0 maps\mp\gametypes\_persistence::_ID31495( "losses", -1 );
        var_0 maps\mp\gametypes\_persistence::_ID31495( "wins", 1 );
        var_0 maps\mp\_utility::_ID34572( "winLossRatio", "wins", "losses" );
        var_0 maps\mp\gametypes\_persistence::_ID31495( "currentWinStreak", 1 );
        var_1 = var_0 maps\mp\gametypes\_persistence::_ID31510( "currentWinStreak" );

        if ( var_1 > var_0 maps\mp\gametypes\_persistence::_ID31510( "winStreak" ) )
            var_0 maps\mp\gametypes\_persistence::_ID31526( "winStreak", var_1 );
    }

    var_0 maps\mp\gametypes\_persistence::_ID31528( "round", "win", 1 );
    var_0 maps\mp\gametypes\_persistence::_ID31528( "round", "loss", 0 );
}

_ID34555( var_0 )
{
    if ( !var_0 maps\mp\_utility::_ID25420() )
        return;

    if ( !isdefined( var_0._ID16391 ) || !var_0._ID16391 )
        return;

    var_0.pers["hasMatchLoss"] = 1;

    if ( !issquadsmode() )
    {
        var_0 maps\mp\gametypes\_persistence::_ID31495( "losses", 1 );
        var_0 maps\mp\_utility::_ID34572( "winLossRatio", "wins", "losses" );
        maps\mp\gametypes\_persistence::_ID31495( "gamesPlayed", 1 );
    }

    var_0 maps\mp\gametypes\_persistence::_ID31528( "round", "loss", 1 );
}

_ID34630( var_0 )
{
    if ( !var_0 maps\mp\_utility::_ID25420() )
        return;

    if ( !isdefined( var_0._ID16391 ) || !var_0._ID16391 )
        return;

    if ( !issquadsmode() )
    {
        var_0 maps\mp\gametypes\_persistence::_ID31495( "losses", -1 );
        var_0 maps\mp\gametypes\_persistence::_ID31495( "ties", 1 );
        var_0 maps\mp\_utility::_ID34572( "winLossRatio", "wins", "losses" );
        var_0 maps\mp\gametypes\_persistence::_ID31526( "currentWinStreak", 0 );
    }

    var_0 maps\mp\gametypes\_persistence::_ID31528( "round", "loss", 0 );
}

updatewinlossstats( var_0 )
{
    if ( maps\mp\_utility::_ID25017() )
        return;

    if ( !maps\mp\_utility::_ID35913() )
        return;

    var_1 = level.players;
    _ID38233();

    if ( !isdefined( var_0 ) || isdefined( var_0 ) && isstring( var_0 ) && var_0 == "tie" )
    {
        foreach ( var_3 in level.players )
        {
            if ( isdefined( var_3.connectedpostgame ) )
                continue;

            if ( level._ID17093 && var_3 ishost() )
            {
                if ( !issquadsmode() )
                    var_3 maps\mp\gametypes\_persistence::_ID31526( "currentWinStreak", 0 );

                continue;
            }

            _ID34630( var_3 );
        }

        return;
    }

    if ( isplayer( var_0 ) )
    {
        if ( level._ID17093 && var_0 ishost() )
        {
            if ( !issquadsmode() )
                var_0 maps\mp\gametypes\_persistence::_ID31526( "currentWinStreak", 0 );

            return;
        }

        _ID34648( var_0 );
        return;
    }

    if ( isstring( var_0 ) )
    {
        foreach ( var_3 in level.players )
        {
            if ( isdefined( var_3.connectedpostgame ) )
                continue;

            if ( level._ID17093 && var_3 ishost() )
            {
                if ( !issquadsmode() )
                    var_3 maps\mp\gametypes\_persistence::_ID31526( "currentWinStreak", 0 );

                continue;
            }

            if ( var_0 == "tie" )
            {
                _ID34630( var_3 );
                continue;
            }

            if ( var_3.pers["team"] == var_0 )
            {
                _ID34648( var_3 );
                continue;
            }

            if ( !issquadsmode() )
                var_3 maps\mp\gametypes\_persistence::_ID31526( "currentWinStreak", 0 );
        }

        return;
    }

    return;
    return;
}

_ID38233()
{
    if ( level._ID14086 != "infect" )
        return;

    foreach ( var_1 in level.players )
    {
        if ( var_1.sessionstate == "spectator" && !var_1.spectatekillcam )
        {
            continue;
            continue;
        }

        if ( isdefined( var_1._ID16391 ) && var_1._ID16391 )
        {
            continue;
            continue;
        }

        if ( var_1.team == "axis" )
        {
            continue;
            continue;
        }

        var_1 _ID28745( var_1, 1 );
    }
}

_ID13583( var_0 )
{
    self endon( "disconnect" );
    maps\mp\_utility::_ID7496();

    if ( !isdefined( var_0 ) )
        var_0 = 0.05;

    wait(var_0);
    maps\mp\_utility::_ID13582( 1 );
}

_ID34560( var_0 )
{
    if ( !game["timePassed"] )
        return;

    if ( !maps\mp\_utility::_ID20673() )
        return;

    if ( !maps\mp\_utility::_ID15434() || level.forcedend )
    {
        var_1 = maps\mp\_utility::_ID15435() / 1000;
        var_1 = min( var_1, 1200 );
    }
    else
        var_1 = maps\mp\_utility::_ID15434() * 60;

    if ( level._ID32653 )
    {
        if ( var_0 == "allies" )
        {
            var_2 = "allies";
            var_3 = "axis";
        }
        else if ( var_0 == "axis" )
        {
            var_2 = "axis";
            var_3 = "allies";
        }
        else
        {
            var_2 = "tie";
            var_3 = "tie";
        }

        if ( var_2 != "tie" )
        {
            var_4 = maps\mp\gametypes\_rank::_ID15328( "win" );
            var_5 = maps\mp\gametypes\_rank::_ID15328( "loss" );
            setwinningteam( var_2 );
        }
        else
        {
            var_4 = maps\mp\gametypes\_rank::_ID15328( "tie" );
            var_5 = maps\mp\gametypes\_rank::_ID15328( "tie" );
        }

        foreach ( var_7 in level.players )
        {
            if ( isdefined( var_7.connectedpostgame ) )
                continue;

            if ( !var_7 maps\mp\_utility::_ID25420() )
                continue;

            if ( var_7._ID33067["total"] < 1 || var_7.pers["participation"] < 1 )
            {
                var_7 thread maps\mp\gametypes\_rank::endgameupdate();
                continue;
            }

            if ( level._ID17093 && var_7 ishost() )
                continue;

            if ( !isdefined( var_7._ID16391 ) || !var_7._ID16391 )
                continue;

            var_8 = var_7 maps\mp\gametypes\_rank::_ID15357();

            if ( var_2 == "tie" )
            {
                var_9 = int( var_4 * ( var_1 / 60 * var_8 ) * var_7._ID33067["total"] / var_1 );
                var_7 thread givematchbonus( "tie", var_9 );
                var_7._ID20665 = var_9;
                continue;
            }

            if ( isdefined( var_7.pers["team"] ) && var_7.pers["team"] == var_2 )
            {
                var_9 = int( var_4 * ( var_1 / 60 * var_8 ) * var_7._ID33067["total"] / var_1 );
                var_7 thread givematchbonus( "win", var_9 );
                var_7._ID20665 = var_9;
                continue;
            }

            if ( isdefined( var_7.pers["team"] ) && var_7.pers["team"] == var_3 )
            {
                var_9 = int( var_5 * ( var_1 / 60 * var_8 ) * var_7._ID33067["total"] / var_1 );
                var_7 thread givematchbonus( "loss", var_9 );
                var_7._ID20665 = var_9;
            }
        }

        return;
    }

    if ( isdefined( var_0 ) )
    {
        var_4 = maps\mp\gametypes\_rank::_ID15328( "win" );
        var_5 = maps\mp\gametypes\_rank::_ID15328( "loss" );
    }
    else
    {
        var_4 = maps\mp\gametypes\_rank::_ID15328( "tie" );
        var_5 = maps\mp\gametypes\_rank::_ID15328( "tie" );
    }

    foreach ( var_7 in level.players )
    {
        if ( isdefined( var_7.connectedpostgame ) )
            continue;

        if ( var_7._ID33067["total"] < 1 || var_7.pers["participation"] < 1 )
        {
            var_7 thread maps\mp\gametypes\_rank::endgameupdate();
            continue;
        }

        if ( !isdefined( var_7._ID16391 ) || !var_7._ID16391 )
            continue;

        var_8 = var_7 maps\mp\gametypes\_rank::_ID15357();
        var_12 = 0;

        for ( var_13 = 0; var_13 < min( level._ID23663["all"].size, 3 ); var_13++ )
        {
            if ( level._ID23663["all"][var_13] != var_7 )
                continue;

            var_12 = 1;
        }

        if ( var_12 )
        {
            var_9 = int( var_4 * ( var_1 / 60 * var_8 ) * var_7._ID33067["total"] / var_1 );
            var_7 thread givematchbonus( "win", var_9 );
            var_7._ID20665 = var_9;
            continue;
        }

        var_9 = int( var_5 * ( var_1 / 60 * var_8 ) * var_7._ID33067["total"] / var_1 );
        var_7 thread givematchbonus( "loss", var_9 );
        var_7._ID20665 = var_9;
    }

    return;
}

givematchbonus( var_0, var_1 )
{
    self endon( "disconnect" );
    level waittill( "give_match_bonus" );
    maps\mp\gametypes\_rank::giverankxp( var_0, var_1 );
    maps\mp\gametypes\_rank::endgameupdate();
}

_ID29211( var_0 )
{
    var_1 = level.players;

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_3 = var_1[var_2];

        if ( !isdefined( var_3.score ) || !isdefined( var_3.pers["team"] ) )
            continue;
    }

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_3 = var_1[var_2];

        if ( !isdefined( var_3.score ) || !isdefined( var_3.pers["team"] ) )
            continue;

        var_4 = var_3.score;

        if ( maps\mp\_utility::_ID15150() )
            var_4 = var_3.score / maps\mp\_utility::_ID15150();

        setplayerteamrank( var_3, var_3.clientid, int( var_4 ) );
    }
}

_ID7131( var_0 )
{
    if ( isdefined( level._ID33056 ) && level._ID33056 )
        return;

    if ( game["state"] != "playing" )
    {
        setgameendtime( 0 );
        return;
    }

    if ( maps\mp\_utility::_ID15434() <= 0 )
    {
        if ( isdefined( level._ID31480 ) )
            setgameendtime( level._ID31480 );
        else
            setgameendtime( 0 );

        return;
    }

    if ( !maps\mp\_utility::_ID14065( "prematch_done" ) )
    {
        setgameendtime( 0 );
        return;
    }

    if ( !isdefined( level._ID31480 ) )
        return;

    if ( maps\mp\_utility::gettimepassedpercentage() > level._ID33066 )
        setnojiptime( 1 );

    var_1 = gettimeremaining();
    setgameendtime( gettime() + int( var_1 ) );

    if ( var_1 > 0 )
        return;

    [[ level._ID22913 ]]();
}

gettimeremaining()
{
    return maps\mp\_utility::_ID15434() * 60 * 1000 - maps\mp\_utility::_ID15435();
}

_ID15438()
{
    var_0 = maps\mp\_utility::_ID15434() * 60 * 1000;
    return ( var_0 - maps\mp\_utility::_ID15435() ) / var_0;
}

_ID7130( var_0 )
{
    if ( maps\mp\_utility::getwatcheddvar( "scorelimit" ) <= 0 || maps\mp\_utility::_ID18716() )
        return;

    if ( isdefined( level._ID27362 ) && level._ID27362 )
        return;

    if ( level._ID14086 == "conf" || level._ID14086 == "jugg" )
        return;

    if ( !level._ID32653 )
        return;

    if ( maps\mp\_utility::_ID15435() < 60000 )
        return;

    var_1 = estimatedtimetillscorelimit( var_0 );

    if ( var_1 < 2 )
    {
        level notify( "match_ending_soon",  "score"  );
        return;
    }
}

checkplayerscorelimitsoon()
{
    if ( maps\mp\_utility::getwatcheddvar( "scorelimit" ) <= 0 || maps\mp\_utility::_ID18716() )
        return;

    if ( level._ID32653 )
        return;

    if ( maps\mp\_utility::_ID15435() < 60000 )
        return;

    var_0 = estimatedtimetillscorelimit();

    if ( var_0 < 2 )
    {
        level notify( "match_ending_soon",  "score"  );
        return;
    }
}

_ID7127()
{
    if ( maps\mp\_utility::_ID18716() )
        return 0;

    if ( isdefined( level._ID27362 ) && level._ID27362 )
        return 0;

    if ( game["state"] != "playing" )
        return 0;

    if ( maps\mp\_utility::getwatcheddvar( "scorelimit" ) <= 0 )
        return 0;

    if ( level._ID32653 )
    {
        var_0 = 0;

        for ( var_1 = 0; var_1 < level._ID32668.size; var_1++ )
        {
            if ( game["teamScores"][level._ID32668[var_1]] >= maps\mp\_utility::getwatcheddvar( "scorelimit" ) )
                var_0 = 1;
        }

        if ( !var_0 )
            return 0;
    }
    else
    {
        if ( !isplayer( self ) )
            return 0;

        if ( self.score < maps\mp\_utility::getwatcheddvar( "scorelimit" ) )
            return 0;
    }

    return onscorelimit();
}

_ID34544()
{
    level endon( "game_ended" );

    while ( game["state"] == "playing" )
    {
        if ( isdefined( level._ID31480 ) )
        {
            if ( gettimeremaining() < 3000 )
            {
                wait 0.1;
                continue;
            }
        }

        wait 1;
    }
}

matchstarttimerwaitforplayers()
{
    thread _ID20681( "match_starting_in", level._ID24880 + level.prematchperiodend );
    _ID35566( level._ID24880 );

    if ( level.prematchperiodend > 0 && !isdefined( level.hostmigrationtimer ) )
    {
        var_0 = level.prematchperiodend;

        if ( maps\mp\_utility::_ID18768() && !maps\mp\_utility::_ID18625() || maps\mp\_utility::_ID37547() )
            var_0 = level._ID24880;

        _ID20681( "match_starting_in", var_0 );
        return;
    }
}

_ID20682( var_0 )
{
    waittillframeend;
    introvisionset();
    level endon( "match_start_timer_beginning" );

    while ( var_0 > 0 && !level.gameended )
    {
        setomnvar( "ui_match_start_countdown", var_0 );

        if ( var_0 == 0 )
            visionsetnaked( "", 0 );

        var_0--;
        wait 1.0;
    }

    setomnvar( "ui_match_start_countdown", 0 );
}

_ID20681( var_0, var_1 )
{
    self notify( "matchStartTimer" );
    self endon( "matchStartTimer" );
    level notify( "match_start_timer_beginning" );
    var_2 = int( var_1 );

    if ( var_2 >= 2 )
    {
        setomnvar( "ui_match_start_text", var_0 );
        _ID20682( var_2 );
        visionsetnaked( "", 3.0 );
        return;
    }

    introvisionset();
    visionsetnaked( "", 1.0 );
    return;
}

introvisionset()
{
    if ( !isdefined( level.introvisionset ) )
        level.introvisionset = "mpIntro";

    visionsetnaked( level.introvisionset, 0 );
}

_ID20684()
{
    visionsetnaked( "", 0 );
}

_ID22896()
{
    if ( !isdefined( game["switchedsides"] ) )
        game["switchedsides"] = 0;

    if ( game["roundsWon"]["allies"] == maps\mp\_utility::getwatcheddvar( "winlimit" ) - 1 && game["roundsWon"]["axis"] == maps\mp\_utility::getwatcheddvar( "winlimit" ) - 1 )
    {
        var_0 = _ID14915();

        if ( var_0 != game["defenders"] )
        {
            game["switchedsides"] = !game["switchedsides"];
            level.switchedsides = 1;
        }
        else
            level.switchedsides = undefined;

        level._ID15987 = "overtime";
        return;
    }

    level._ID15987 = "halftime";
    game["switchedsides"] = !game["switchedsides"];
    level.switchedsides = 1;
    return;
}

_ID7125()
{
    if ( !level._ID32653 )
        return 0;

    if ( !isdefined( level._ID26777 ) || !level._ID26777 )
        return 0;

    if ( game["roundsPlayed"] % level._ID26777 == 0 )
    {
        _ID22896();
        return 1;
    }

    return 0;
}

_ID33081()
{
    if ( level.gameended )
    {
        var_0 = ( gettime() - level._ID14064 ) / 1000;
        var_1 = level._ID24793 - var_0;

        if ( var_1 < 0 )
            return 0;

        return var_1;
    }

    if ( maps\mp\_utility::_ID15434() <= 0 )
        return undefined;

    if ( !isdefined( level._ID31480 ) )
        return undefined;

    var_2 = maps\mp\_utility::_ID15434();
    var_0 = ( gettime() - level._ID31480 ) / 1000;
    var_1 = maps\mp\_utility::_ID15434() * 60 - var_0;

    if ( isdefined( level.timepaused ) )
        var_1 += level.timepaused;

    return var_1 + level._ID24793;
}

_ID13577()
{
    if ( isdefined( self._ID23446 ) )
    {
        if ( isdefined( self._ID23446[0] ) )
        {
            self._ID23446[0] maps\mp\gametypes\_hud_util::destroyelem();
            self._ID23447[0] maps\mp\gametypes\_hud_util::destroyelem();
        }

        if ( isdefined( self._ID23446[1] ) )
        {
            self._ID23446[1] maps\mp\gametypes\_hud_util::destroyelem();
            self._ID23447[1] maps\mp\gametypes\_hud_util::destroyelem();
        }

        if ( isdefined( self._ID23446[2] ) )
        {
            self._ID23446[2] maps\mp\gametypes\_hud_util::destroyelem();
            self._ID23447[2] maps\mp\gametypes\_hud_util::destroyelem();
        }
    }

    self notify( "perks_hidden" );
    self._ID20385 maps\mp\gametypes\_hud_util::destroyelem();
    self._ID20392 maps\mp\gametypes\_hud_util::destroyelem();

    if ( isdefined( self._ID25120 ) )
        self._ID25120 maps\mp\gametypes\_hud_util::destroyelem();

    if ( isdefined( self.proxbartext ) )
    {
        self.proxbartext maps\mp\gametypes\_hud_util::destroyelem();
        return;
    }
}

gethostplayer()
{
    var_0 = getentarray( "player", "classname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( var_0[var_1] ishost() )
            return var_0[var_1];
    }
}

_ID17094()
{
    var_0 = gethostplayer();

    if ( isdefined( var_0 ) && !var_0.hasspawned && !isdefined( var_0._ID28023 ) )
        return 1;

    return 0;
}

roundendwait( var_0, var_1 )
{
    var_2 = 0;

    while ( !var_2 )
    {
        var_3 = level.players;
        var_2 = 1;

        foreach ( var_5 in var_3 )
        {
            if ( !isdefined( var_5.doingsplash ) )
                continue;

            if ( !var_5 maps\mp\gametypes\_hud_message::_ID18607() )
                continue;

            var_2 = 0;
        }

        wait 0.5;
    }

    if ( !var_1 )
    {
        wait(var_0);
        level notify( "round_end_finished" );
        return;
    }

    wait(var_0 / 2);
    level notify( "give_match_bonus" );
    wait(var_0 / 2);
    var_2 = 0;

    while ( !var_2 )
    {
        var_3 = level.players;
        var_2 = 1;

        foreach ( var_5 in var_3 )
        {
            if ( !isdefined( var_5.doingsplash ) )
                continue;

            if ( !var_5 maps\mp\gametypes\_hud_message::_ID18607() )
                continue;

            var_2 = 0;
        }

        wait 0.5;
    }

    level notify( "round_end_finished" );
}

_ID26774( var_0 )
{
    self setdepthoffield( 0, 128, 512, 4000, 6, 1.8 );
}

updatesquadvssquad()
{
    for (;;)
    {
        setnojiptime( 1 );
        wait 0.05;
    }
}

callback_startgametype()
{
    maps\mp\_load::_ID20445();
    maps\mp\_utility::_ID19893( "round_over", 0 );
    maps\mp\_utility::_ID19893( "game_over", 0 );
    maps\mp\_utility::_ID19893( "block_notifies", 0 );
    maps\mp\_utility::_ID19893( "post_game_level_event_active", 0 );
    level._ID24880 = 0;
    level.prematchperiodend = 0;
    level._ID24789 = 0;
    level.intermission = 0;
    setdvar( "bg_compassShowEnemies", getdvar( "scr_game_forceuav" ) );

    if ( maps\mp\_utility::_ID20673() )
        setdvar( "isMatchMakingGame", 1 );
    else
        setdvar( "isMatchMakingGame", 0 );

    if ( level.multiteambased )
        setdvar( "ui_numteams", level._ID22424 );

    if ( !isdefined( game["gamestarted"] ) )
    {
        game["clientid"] = 0;
        game["truncated_killcams"] = 0;

        if ( !isdefined( game["attackers"] ) || !isdefined( game["defenders"] ) )
            thread common_scripts\utility::error( "No attackers or defenders team defined in level .gsc." );

        if ( !isdefined( game["attackers"] ) )
            game["attackers"] = "allies";

        if ( !isdefined( game["defenders"] ) )
            game["defenders"] = "axis";

        if ( !isdefined( game["state"] ) )
            game["state"] = "playing";

        game["allies"] = "ghosts";
        game["axis"] = "federation";
        game["strings"]["press_to_spawn"] = &"PLATFORM_PRESS_TO_SPAWN";
        game["strings"]["spawn_next_round"] = &"MP_SPAWN_NEXT_ROUND";
        game["strings"]["spawn_flag_wait"] = &"MP_SPAWN_FLAG_WAIT";
        game["strings"]["spawn_tag_wait"] = &"MP_SPAWN_TAG_WAIT";
        game["strings"]["waiting_to_spawn"] = &"MP_WAITING_TO_SPAWN";
        game["strings"]["waiting_to_safespawn"] = &"MP_WAITING_TO_SAFESPAWN";
        game["strings"]["match_starting"] = &"MP_MATCH_STARTING";
        game["strings"]["change_class"] = &"MP_CHANGE_CLASS_NEXT_SPAWN";
        game["strings"]["last_stand"] = &"MPUI_LAST_STAND";
        game["strings"]["final_stand"] = &"MPUI_FINAL_STAND";
        game["strings"]["c4_death"] = &"MPUI_C4_DEATH";
        game["strings"]["cowards_way"] = &"PLATFORM_COWARDS_WAY_OUT";
        game["colors"]["black"] = ( 0, 0, 0 );
        game["colors"]["white"] = ( 1, 1, 1 );
        game["colors"]["grey"] = ( 0.5, 0.5, 0.5 );
        game["colors"]["cyan"] = ( 0.35, 0.7, 0.9 );
        game["colors"]["orange"] = ( 0.9, 0.6, 0 );
        game["colors"]["blue"] = ( 0.2, 0.3, 0.7 );
        game["colors"]["red"] = ( 0.75, 0.25, 0.25 );
        game["colors"]["green"] = ( 0.25, 0.75, 0.25 );
        game["colors"]["yellow"] = ( 0.65, 0.65, 0 );
        game["strings"]["allies_name"] = maps\mp\gametypes\_teams::_ID15421( "allies" );
        game["icons"]["allies"] = maps\mp\gametypes\_teams::_ID15418( "allies" );
        game["colors"]["allies"] = maps\mp\gametypes\_teams::getteamcolor( "allies" );
        game["strings"]["axis_name"] = maps\mp\gametypes\_teams::_ID15421( "axis" );
        game["icons"]["axis"] = maps\mp\gametypes\_teams::_ID15418( "axis" );
        game["colors"]["axis"] = maps\mp\gametypes\_teams::getteamcolor( "axis" );

        if ( game["colors"]["allies"] == game["colors"]["black"] )
            game["colors"]["allies"] = game["colors"]["grey"];

        if ( game["colors"]["axis"] == game["colors"]["black"] )
            game["colors"]["axis"] = game["colors"]["grey"];

        [[ level._ID22892 ]]();
        setdvarifuninitialized( "min_wait_for_players", 5 );

        if ( level.console )
        {
            if ( !level.splitscreen )
            {
                if ( maps\mp\_utility::_ID37547() || isdedicatedserver() )
                    level._ID24880 = maps\mp\gametypes\_tweakables::_ID15451( "game", "graceperiod_comp" );
                else
                    level._ID24880 = maps\mp\gametypes\_tweakables::_ID15451( "game", "graceperiod" );

                level.prematchperiodend = maps\mp\gametypes\_tweakables::_ID15451( "game", "matchstarttime" );
            }
        }
        else
        {
            if ( maps\mp\_utility::_ID37547() || isdedicatedserver() )
                level._ID24880 = maps\mp\gametypes\_tweakables::_ID15451( "game", "playerwaittime_comp" );
            else
                level._ID24880 = maps\mp\gametypes\_tweakables::_ID15451( "game", "playerwaittime" );

            level.prematchperiodend = maps\mp\gametypes\_tweakables::_ID15451( "game", "matchstarttime" );
        }

        setnojipscore( 0 );
        setnojiptime( 0 );

        if ( getdvar( "squad_vs_squad" ) == "1" )
            thread updatesquadvssquad();
    }
    else
    {
        setdvarifuninitialized( "min_wait_for_players", 5 );

        if ( level.console )
        {
            if ( !level.splitscreen )
            {
                level._ID24880 = 5;
                level.prematchperiodend = maps\mp\gametypes\_tweakables::_ID15451( "game", "matchstarttime" );
            }
        }
        else
        {
            level._ID24880 = 5;
            level.prematchperiodend = maps\mp\gametypes\_tweakables::_ID15451( "game", "matchstarttime" );
        }
    }

    if ( !isdefined( game["status"] ) )
        game["status"] = "normal";

    setdvar( "ui_overtime", game["status"] == "overtime" );

    if ( game["status"] != "overtime" && game["status"] != "halftime" )
    {
        if ( !( isdefined( game["switchedsides"] ) && game["switchedsides"] == 1 && maps\mp\_utility::_ID18706() ) )
        {
            game["teamScores"]["allies"] = 0;
            game["teamScores"]["axis"] = 0;
        }

        if ( level.multiteambased )
        {
            for ( var_0 = 0; var_0 < level._ID32668.size; var_0++ )
                game["teamScores"][level._ID32668[var_0]] = 0;
        }
    }

    if ( !isdefined( game["timePassed"] ) )
        game["timePassed"] = 0;

    if ( !isdefined( game["roundsPlayed"] ) )
        game["roundsPlayed"] = 0;

    if ( !isdefined( game["roundsWon"] ) )
        game["roundsWon"] = [];

    if ( level._ID32653 )
    {
        if ( !isdefined( game["roundsWon"]["axis"] ) )
            game["roundsWon"]["axis"] = 0;

        if ( !isdefined( game["roundsWon"]["allies"] ) )
            game["roundsWon"]["allies"] = 0;

        if ( level.multiteambased )
        {
            for ( var_0 = 0; var_0 < level._ID32668.size; var_0++ )
            {
                if ( !isdefined( game["roundsWon"][level._ID32668[var_0]] ) )
                    game["roundsWon"][level._ID32668[var_0]] = 0;
            }
        }
    }

    level.gameended = 0;
    level.forcedend = 0;
    level._ID17093 = 0;

    if ( !maps\mp\_utility::_ID18363() )
        level.hardcoremode = getdvarint( "g_hardcore" );

    if ( level.hardcoremode )
        logstring( "game mode: hardcore" );

    level.diehardmode = getdvarint( "scr_diehard" );

    if ( !level._ID32653 )
        level.diehardmode = 0;

    if ( level.diehardmode )
        logstring( "game mode: diehard" );

    level._ID19262 = getdvarint( "scr_game_hardpoints" );
    level._ID34773 = 1;
    level.objectivepointsmod = 1;

    if ( maps\mp\_utility::_ID20673() )
        level._ID20716 = 2;
    else
        level._ID20716 = -1;

    if ( !maps\mp\_utility::_ID18363() )
    {
        thread maps\mp\gametypes\_healthoverlay::_ID17631();
        thread maps\mp\gametypes\_killcam::_ID17631();
        thread maps\mp\gametypes\_damage::_ID17934();
        thread maps\mp\gametypes\_battlechatter_mp::_ID17631();
        thread maps\mp\gametypes\_music_and_dialog::_ID17631();
    }

    thread [[ level._ID18054 ]]();
    thread maps\mp\gametypes\_persistence::_ID17631();
    thread maps\mp\gametypes\_menus::_ID17631();
    thread maps\mp\gametypes\_hud::_ID17631();
    thread maps\mp\gametypes\_serversettings::_ID17631();
    thread maps\mp\gametypes\_teams::_ID17631();
    thread maps\mp\gametypes\_weapons::_ID17631();
    thread maps\mp\gametypes\_outline::_ID17631();
    thread maps\mp\gametypes\_shellshock::_ID17631();
    thread maps\mp\gametypes\_deathicons::_ID17631();
    thread maps\mp\gametypes\_damagefeedback::_ID17631();
    thread maps\mp\gametypes\_objpoints::_ID17631();
    thread maps\mp\gametypes\_gameobjects::_ID17631();
    thread maps\mp\gametypes\_spectating::_ID17631();
    thread maps\mp\gametypes\_spawnlogic::_ID17631();
    thread maps\mp\_matchdata::_ID17631();
    thread maps\mp\_awards::_ID17631();
    thread maps\mp\_areas::_ID17631();
    thread [[ level._ID19259 ]]();
    thread maps\mp\perks\_perks::_ID17631();
    thread maps\mp\_events::_ID17631();
    thread maps\mp\_defcon::_ID17631();
    thread [[ level._ID20669 ]]();
    thread maps\mp\_zipline::_ID17631();

    if ( level._ID32653 )
        thread maps\mp\gametypes\_friendicons::_ID17631();

    thread maps\mp\gametypes\_hud_message::_ID17631();
    game["gamestarted"] = 1;
    level._ID20754 = 0;
    level._ID36229["allies"] = 0;
    level._ID36229["axis"] = 0;
    level._ID19669["allies"] = 0;
    level._ID19669["axis"] = 0;
    level._ID36230["allies"] = 0;
    level._ID36230["axis"] = 0;
    level.aliveplayers["allies"] = [];
    level.aliveplayers["axis"] = [];
    level.activeplayers = [];

    if ( level.multiteambased )
    {
        for ( var_0 = 0; var_0 < level._ID32668.size; var_0++ )
        {
            level._wavedelay[level._ID32668[var_0]] = 0;
            level._ID1723[level._ID32668[var_0]] = 0;
            level._waveplayerspawnindex[level._ID32668[var_0]] = 0;
            level._aliveplayers[level._ID32668[var_0]] = [];
        }
    }

    setdvar( "ui_scorelimit", 0 );
    setdvar( "ui_allow_teamchange", 1 );

    if ( maps\mp\_utility::_ID15035() )
        setdvar( "g_deadChat", 0 );
    else
        setdvar( "g_deadChat", 1 );

    var_1 = getdvarint( "scr_" + level._ID14086 + "_waverespawndelay" );

    if ( var_1 )
    {
        level._ID36229["allies"] = var_1;
        level._ID36229["axis"] = var_1;
        level._ID19669["allies"] = 0;
        level._ID19669["axis"] = 0;

        if ( level.multiteambased )
        {
            for ( var_0 = 0; var_0 < level._ID32668.size; var_0++ )
            {
                level._wavedelay[level._ID32668[var_0]] = var_1;
                level._ID1723[level._ID32668[var_0]] = 0;
            }
        }

        level thread _ID36234();
    }

    maps\mp\_utility::_ID14067( "prematch_done", 0 );

    if ( maps\mp\_utility::_ID18363() )
        level._ID15760 = 10;
    else
        level._ID15760 = 15;

    level._ID17628 = level._ID15760;
    maps\mp\_utility::_ID14067( "graceperiod_done", 0 );
    level.roundenddelay = 4;
    level.halftimeroundenddelay = 4;
    level.noragdollents = getentarray( "noragdoll", "targetname" );

    if ( level._ID32653 )
    {
        maps\mp\gametypes\_gamescore::_ID34624( "axis" );
        maps\mp\gametypes\_gamescore::_ID34624( "allies" );

        if ( level.multiteambased )
        {
            for ( var_0 = 0; var_0 < level._ID32668.size; var_0++ )
                maps\mp\gametypes\_gamescore::_ID34624( level._ID32668[var_0] );
        }
    }
    else
        thread maps\mp\gametypes\_gamescore::initialdmscoreupdate();

    thread _ID34639();
    level notify( "update_scorelimit" );
    [[ level._ID22905 ]]();
    level._ID27363 = getdvarint( "scr_" + level._ID14086 + "_score_percentage_cut_off", 80 );
    level._ID33066 = getdvarint( "scr_" + level._ID14086 + "_time_percentage_cut_off", 80 );

    if ( !level.console && ( getdvar( "dedicated" ) == "dedicated LAN server" || getdvar( "dedicated" ) == "dedicated internet server" ) )
        thread verifydedicatedconfiguration();

    thread _ID31445();
    level thread maps\mp\_utility::_ID34645();
    level thread timelimitthread();

    if ( !maps\mp\_utility::_ID18363() )
    {
        level thread maps\mp\gametypes\_damage::_ID10387();
        return;
    }

    _ID21359();
    return;
}

_ID6468()
{
    endparty();

    if ( !level.gameended )
    {
        level thread _ID13521();
        return;
    }
}

verifydedicatedconfiguration()
{
    for (;;)
    {
        if ( level._ID25418 )
            exitlevel( 0 );

        if ( !getdvarint( "xblive_privatematch" ) )
            exitlevel( 0 );

        if ( getdvar( "dedicated" ) != "dedicated LAN server" && getdvar( "dedicated" ) != "dedicated internet server" )
            exitlevel( 0 );

        wait 5;
    }
}

timelimitthread()
{
    level endon( "game_ended" );
    var_0 = maps\mp\_utility::_ID15435();

    while ( game["state"] == "playing" )
    {
        thread _ID7131( var_0 );
        var_0 = maps\mp\_utility::_ID15435();

        if ( isdefined( level._ID31480 ) )
        {
            if ( gettimeremaining() < 3000 )
            {
                wait 0.1;
                continue;
            }
        }

        wait 1;
    }
}

_ID34639()
{
    for (;;)
    {
        level common_scripts\utility::_ID35663( "update_scorelimit", "update_winlimit" );

        if ( !maps\mp\_utility::_ID18768() || !maps\mp\_utility::_ID18716() )
        {
            setdvar( "ui_scorelimit", maps\mp\_utility::getwatcheddvar( "scorelimit" ) );
            thread _ID7127();
            continue;
        }

        setdvar( "ui_scorelimit", maps\mp\_utility::getwatcheddvar( "winlimit" ) );
    }
}

playtickingsound()
{
    self endon( "death" );
    self endon( "stop_ticking" );
    level endon( "game_ended" );
    var_0 = level.bombtimer;

    for (;;)
    {
        self playsound( "ui_mp_suitcasebomb_timer" );

        if ( var_0 > 10 )
        {
            var_0 -= 1;
            wait 1;
        }
        else if ( var_0 > 4 )
        {
            var_0 -= 0.5;
            wait 0.5;
        }
        else if ( var_0 > 1 )
        {
            var_0 -= 0.4;
            wait 0.4;
        }
        else
        {
            var_0 -= 0.3;
            wait 0.3;
        }

        maps\mp\gametypes\_hostmigration::_ID35770();
    }
}

_ID31859()
{
    self notify( "stop_ticking" );
}

_ID33054()
{
    level endon( "game_ended" );
    wait 0.05;
    var_0 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_0 hide();

    while ( game["state"] == "playing" )
    {
        if ( !level._ID33075 && maps\mp\_utility::_ID15434() )
        {
            var_1 = gettimeremaining() / 1000;
            var_2 = int( var_1 + 0.5 );

            if ( var_2 >= 30 && var_2 <= 60 )
                level notify( "match_ending_soon",  "time"  );

            if ( var_2 <= 10 || var_2 <= 30 && var_2 % 2 == 0 )
            {
                level notify( "match_ending_very_soon" );

                if ( var_2 == 0 )
                    break;

                var_0 playsound( "ui_mp_timer_countdown" );
            }

            if ( var_1 - floor( var_1 ) >= 0.05 )
                wait(var_1 - floor( var_1 ));
        }

        wait 1.0;
    }
}

_ID14084()
{
    level endon( "game_ended" );
    level waittill( "prematch_over" );
    level._ID31480 = gettime();
    level.discardtime = 0;

    if ( isdefined( game["roundMillisecondsAlreadyPassed"] ) )
    {
        level._ID31480 = level._ID31480 - game["roundMillisecondsAlreadyPassed"];
        game["roundMillisecondsAlreadyPassed"] = undefined;
    }

    var_0 = gettime();

    while ( game["state"] == "playing" )
    {
        if ( !level._ID33075 )
            game["timePassed"] += gettime() - var_0;

        var_0 = gettime();
        wait 1.0;
    }
}

updatetimerpausedness()
{
    var_0 = level._ID33076 || isdefined( level.hostmigrationtimer );

    if ( !maps\mp\_utility::_ID14065( "prematch_done" ) )
        var_0 = 0;

    if ( !level._ID33075 && var_0 )
    {
        level._ID33075 = 1;
        level.timerpausetime = gettime();
        return;
    }

    if ( level._ID33075 && !var_0 )
    {
        level._ID33075 = 0;
        level.discardtime = level.discardtime + gettime() - level.timerpausetime;
        return;
    }

    return;
}

_ID23389()
{
    level._ID33076 = 1;
    updatetimerpausedness();
}

_ID26217()
{
    level._ID33076 = 0;
    updatetimerpausedness();
}

_ID31445()
{
    thread _ID14084();
    level._ID33075 = 0;
    level._ID33076 = 0;
    setomnvar( "ui_prematch_period", 1 );

    if ( isdefined( level.customprematchperiod ) )
        [[ level.customprematchperiod ]]();
    else
        _ID24880();

    maps\mp\_utility::_ID14068( "prematch_done" );
    level notify( "prematch_over" );
    setomnvar( "ui_prematch_period", 0 );
    updatetimerpausedness();
    thread _ID33054();
    thread _ID15760();

    if ( !maps\mp\_utility::_ID18363() )
    {
        thread maps\mp\gametypes\_missions::roundbegin();
        return;
    }
}

_ID36234()
{
    level endon( "game_ended" );

    while ( game["state"] == "playing" )
    {
        var_0 = gettime();

        if ( var_0 - level._ID19669["allies"] > level._ID36229["allies"] * 1000 )
        {
            level notify( "wave_respawn_allies" );
            level._ID19669["allies"] = var_0;
            level._ID36230["allies"] = 0;
        }

        if ( var_0 - level._ID19669["axis"] > level._ID36229["axis"] * 1000 )
        {
            level notify( "wave_respawn_axis" );
            level._ID19669["axis"] = var_0;
            level._ID36230["axis"] = 0;
        }

        if ( level.multiteambased )
        {
            for ( var_1 = 0; var_1 < level._ID32668.size; var_1++ )
            {
                if ( var_0 - level._ID19669[level._ID32668[var_1]] > level._wavedelay[level._ID32668[var_1]] * 1000 )
                {
                    var_2 = "wave_rewpawn_" + level._ID32668[var_1];
                    level notify( var_2 );
                    level._ID19669[level._ID32668[var_1]] = var_0;
                    level._ID36230[level._ID32668[var_1]] = 0;
                }
            }
        }

        wait 0.05;
    }
}

_ID14915()
{
    var_0["allies"] = 0;
    var_0["axis"] = 0;
    var_1["allies"] = 0;
    var_1["axis"] = 0;

    foreach ( var_3 in level.players )
    {
        var_4 = var_3.pers["team"];

        if ( isdefined( var_4 ) && ( var_4 == "allies" || var_4 == "axis" ) )
        {
            var_0[var_4] += var_3.kills;
            var_1[var_4] += var_3.deaths;
        }
    }

    if ( var_0["allies"] > var_0["axis"] )
        return "allies";
    else if ( var_0["axis"] > var_0["allies"] )
        return "axis";

    if ( var_1["allies"] < var_1["axis"] )
        return "allies";
    else if ( var_1["axis"] < var_1["allies"] )
        return "axis";

    if ( randomint( 2 ) == 0 )
        return "allies";

    return "axis";
}

_ID25419( var_0 )
{
    if ( maps\mp\_utility::_ID20673() )
    {
        _ID29211();

        if ( _ID17094() )
        {
            level._ID17093 = 1;
            logstring( "host idled out" );
            endlobby();
        }

        _ID34560( var_0 );
    }

    updatewinlossstats( var_0 );
}

displayroundend( var_0, var_1 )
{
    if ( maps\mp\_utility::_ID18706() )
    {
        var_0 = "roundend";
        var_2 = game["music"]["allies_suspense"].size;
        var_3 = game["music"]["axis_suspense"].size;
        maps\mp\_utility::_ID24645( game["music"]["allies_suspense"][randomint( var_2 )], "allies" );
        maps\mp\_utility::_ID24645( game["music"]["axis_suspense"][randomint( var_3 )], "axis" );
    }

    foreach ( var_5 in level.players )
    {
        if ( isdefined( var_5.connectedpostgame ) || var_5.pers["team"] == "spectator" && !var_5 ismlgspectator() )
            continue;

        if ( level._ID32653 )
        {
            var_5 thread maps\mp\gametypes\_hud_message::_ID32671( var_0, 1, var_1 );
            continue;
        }

        var_5 thread maps\mp\gametypes\_hud_message::_ID23075( var_0, var_1 );
    }

    if ( !maps\mp\_utility::_ID35913() )
        level notify( "round_win",  var_0  );

    if ( maps\mp\_utility::_ID35913() )
    {
        roundendwait( level.roundenddelay, 0 );
        return;
    }

    roundendwait( level.roundenddelay, 1 );
    return;
}

displaygameend( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        if ( isdefined( var_3.connectedpostgame ) || var_3.pers["team"] == "spectator" && !var_3 ismlgspectator() )
            continue;

        if ( level._ID32653 )
        {
            var_3 thread maps\mp\gametypes\_hud_message::_ID32671( var_0, 0, var_1 );
            continue;
        }

        var_3 thread maps\mp\gametypes\_hud_message::_ID23075( var_0, var_1 );
    }

    level notify( "game_win",  var_0  );
    roundendwait( level._ID24793, 1 );
}

_ID10227()
{
    var_0 = level._ID15987;

    if ( var_0 == "halftime" )
    {
        if ( maps\mp\_utility::getwatcheddvar( "roundlimit" ) )
        {
            if ( game["roundsPlayed"] * 2 == maps\mp\_utility::getwatcheddvar( "roundlimit" ) )
                var_0 = "halftime";
            else
                var_0 = "intermission";
        }
        else if ( maps\mp\_utility::getwatcheddvar( "winlimit" ) )
        {
            if ( game["roundsPlayed"] == maps\mp\_utility::getwatcheddvar( "winlimit" ) - 1 )
                var_0 = "halftime";
            else
                var_0 = "intermission";
        }
        else
            var_0 = "intermission";
    }

    level notify( "round_switch",  var_0  );
    var_1 = 0;

    if ( isdefined( level.switchedsides ) )
        var_1 = game["end_reason"]["switching_sides"];

    foreach ( var_3 in level.players )
    {
        if ( isdefined( var_3.connectedpostgame ) || var_3.pers["team"] == "spectator" && !var_3 ismlgspectator() )
            continue;

        var_3 thread maps\mp\gametypes\_hud_message::_ID32671( var_0, 1, var_1 );
    }

    roundendwait( level.halftimeroundenddelay, 0 );
}

freezeallplayers( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    foreach ( var_4 in level.players )
    {
        var_4 thread _ID13583( var_0 );
        var_4 thread _ID26774( 4.0 );
        var_4 _ID13577();
        var_4 setclientdvars( "cg_everyoneHearsEveryone", 1, "cg_drawSpectatorMessages", 0 );

        if ( isdefined( var_1 ) && isdefined( var_2 ) )
            var_4 setclientdvars( var_1, var_2 );
    }

    foreach ( var_7 in level.agentarray )
        var_7 maps\mp\_utility::_ID13582( 1 );
}

endgameovertime( var_0, var_1 )
{
    visionsetnaked( "mpOutro", 0.5 );
    setdvar( "bg_compassShowEnemies", 0 );
    freezeallplayers();
    level notify( "round_switch",  "overtime"  );

    foreach ( var_3 in level.players )
    {
        if ( isdefined( var_3.connectedpostgame ) || var_3.pers["team"] == "spectator" && !var_3 ismlgspectator() )
            continue;

        if ( level._ID32653 )
        {
            var_3 thread maps\mp\gametypes\_hud_message::_ID32671( var_0, 0, var_1 );
            continue;
        }

        var_3 thread maps\mp\gametypes\_hud_message::_ID23075( var_0, var_1 );
    }

    roundendwait( level.roundenddelay, 0 );

    if ( isdefined( level.finalkillcam_winner ) )
    {
        level._ID12883[level.finalkillcam_winner] = maps\mp\_utility::_ID15332();

        foreach ( var_3 in level.players )
            var_3 notify( "reset_outcome" );

        level notify( "game_cleanup" );
        _ID35767();

        foreach ( var_3 in level.players )
        {
            if ( isdefined( var_3.connectedpostgame ) || var_3.pers["team"] == "spectator" && !var_3 ismlgspectator() )
                continue;

            if ( level._ID32653 )
            {
                var_3 thread maps\mp\gametypes\_hud_message::_ID32671( var_0, 0, var_1 );
                continue;
            }

            var_3 thread maps\mp\gametypes\_hud_message::_ID23075( var_0, var_1 );
        }
    }

    game["status"] = "overtime";
    level notify( "restarting" );
    game["state"] = "playing";
    map_restart( 1 );
}

_ID11608()
{
    visionsetnaked( "mpOutro", 0.5 );
    setdvar( "bg_compassShowEnemies", 0 );
    game["switchedsides"] = !game["switchedsides"];
    level.switchedsides = undefined;
    freezeallplayers();

    foreach ( var_1 in level.players )
        var_1.pers["stats"] = var_1._ID31525;

    level notify( "round_switch",  "halftime"  );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1.connectedpostgame ) || var_1.pers["team"] == "spectator" && !var_1 ismlgspectator() )
            continue;

        var_1 thread maps\mp\gametypes\_hud_message::_ID32671( "halftime", 1, game["end_reason"]["switching_sides"] );
    }

    roundendwait( level.roundenddelay, 0 );

    if ( isdefined( level.finalkillcam_winner ) )
    {
        level._ID12883[level.finalkillcam_winner] = maps\mp\_utility::_ID15332();

        foreach ( var_1 in level.players )
            var_1 notify( "reset_outcome" );

        level notify( "game_cleanup" );
        _ID35767();

        foreach ( var_1 in level.players )
        {
            if ( isdefined( var_1.connectedpostgame ) || var_1.pers["team"] == "spectator" && !var_1 ismlgspectator() )
                continue;

            var_1 thread maps\mp\gametypes\_hud_message::_ID32671( "halftime", 1, game["end_reason"]["switching_sides"] );
        }
    }

    game["status"] = "halftime";
    level notify( "restarting" );
    game["state"] = "playing";
    setdvar( "ui_game_state", game["state"] );
    map_restart( 1 );
}

endgame( var_0, var_1, var_2 )
{
    if ( maps\mp\_utility::_ID18363() )
    {
        [[ level._ID11605 ]]( var_0, var_1 );
        return;
    }

    _ID11606( var_0, var_1, var_2 );
    return;
}

_ID11606( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( game["state"] == "postgame" || level.gameended && ( !isdefined( level._ID15845 ) || !level._ID15845 ) )
        return;

    setomnvar( "ui_pause_menu_show", 0 );
    game["state"] = "postgame";
    setdvar( "ui_game_state", "postgame" );
    level._ID14064 = gettime();
    level.gameended = 1;
    level._ID17628 = 0;
    level notify( "game_ended",  var_0  );
    maps\mp\_utility::levelflagset( "game_over" );
    maps\mp\_utility::levelflagset( "block_notifies" );
    common_scripts\utility::_ID35582();
    setgameendtime( 0 );
    var_3 = getmatchdata( "gameLength" );
    var_3 += int( maps\mp\_utility::_ID15332() );
    setmatchdata( "gameLength", var_3 );
    maps\mp\gametypes\_playerlogic::_ID25006();

    if ( isdefined( var_0 ) && isstring( var_0 ) && var_0 == "overtime" )
    {
        level.finalkillcam_winner = "none";
        endgameovertime( var_0, var_1 );
        return;
    }

    if ( isdefined( var_0 ) && isstring( var_0 ) && var_0 == "halftime" )
    {
        level.finalkillcam_winner = "none";
        _ID11608();
        return;
    }

    if ( isdefined( level.finalkillcam_winner ) )
        level._ID12883[level.finalkillcam_winner] = maps\mp\_utility::_ID15332();

    game["roundsPlayed"]++;

    if ( level._ID32653 )
    {
        if ( var_0 == "axis" || var_0 == "allies" )
            game["roundsWon"][var_0]++;

        maps\mp\gametypes\_gamescore::_ID34624( "axis" );
        maps\mp\gametypes\_gamescore::_ID34624( "allies" );
    }
    else if ( isdefined( var_0 ) && isplayer( var_0 ) )
        game["roundsWon"][var_0._ID15851]++;

    maps\mp\gametypes\_gamescore::_ID34574();
    _ID25419( var_0 );

    foreach ( var_5 in level.players )
    {
        var_5 setclientdvar( "ui_opensummary", 1 );

        if ( maps\mp\_utility::_ID35914() || maps\mp\_utility::_ID35913() )
            var_5 maps\mp\killstreaks\_killstreaks::clearkillstreaks();
    }

    setdvar( "g_deadChat", 1 );
    setdvar( "ui_allow_teamchange", 0 );
    setdvar( "bg_compassShowEnemies", 0 );
    freezeallplayers( 1.0, "cg_fovScale", 1 );

    if ( !var_2 )
        visionsetnaked( "mpOutro", 0.5 );

    if ( !maps\mp\_utility::_ID35914() && !var_2 )
    {
        displayroundend( var_0, var_1 );

        if ( isdefined( level.finalkillcam_winner ) )
        {
            foreach ( var_5 in level.players )
                var_5 notify( "reset_outcome" );

            level notify( "game_cleanup" );
            _ID35767();
        }

        if ( !maps\mp\_utility::_ID35913() )
        {
            maps\mp\_utility::_ID19892( "block_notifies" );

            if ( _ID7125() )
                _ID10227();

            foreach ( var_5 in level.players )
                var_5.pers["stats"] = var_5._ID31525;

            level notify( "restarting" );
            game["state"] = "playing";
            setdvar( "ui_game_state", "playing" );
            map_restart( 1 );
            return;
        }

        if ( !level.forcedend )
            var_1 = _ID34599( var_0 );
    }

    if ( !isdefined( game["clientMatchDataDef"] ) )
    {
        game["clientMatchDataDef"] = "mp/clientmatchdata.def";
        setclientmatchdatadef( game["clientMatchDataDef"] );
    }

    maps\mp\gametypes\_missions::_ID26772( var_0 );

    if ( level._ID32653 && maps\mp\_utility::_ID18768() && level.gameended && !maps\mp\_utility::_ID18706() )
    {
        if ( game["roundsWon"]["allies"] == game["roundsWon"]["axis"] )
            var_0 = "tie";
        else if ( game["roundsWon"]["axis"] > game["roundsWon"]["allies"] )
        {
            level.finalkillcam_winner = "axis";
            var_0 = "axis";
        }
        else
        {
            level.finalkillcam_winner = "allies";
            var_0 = "allies";
        }
    }

    displaygameend( var_0, var_1 );

    if ( isdefined( level.finalkillcam_winner ) && maps\mp\_utility::_ID35914() )
    {
        foreach ( var_5 in level.players )
            var_5 notify( "reset_outcome" );

        level notify( "game_cleanup" );
        _ID35767();
    }

    maps\mp\_utility::_ID19892( "block_notifies" );
    level.intermission = 1;
    level notify( "start_custom_ending" );
    level notify( "spawning_intermission" );

    foreach ( var_5 in level.players )
    {
        var_5 notify( "reset_outcome" );
        var_5 thread maps\mp\gametypes\_playerlogic::_ID30890();
    }

    _ID25043();
    wait 1.0;
    checkforpersonalbests();

    if ( level._ID32653 )
    {
        if ( var_0 == "axis" || var_0 == "allies" )
            setmatchdata( "victor", var_0 );
        else
            setmatchdata( "victor", "none" );

        setmatchdata( "alliesScore", getteamscore( "allies" ) );
        setmatchdata( "axisScore", getteamscore( "axis" ) );
    }
    else
        setmatchdata( "victor", "none" );

    foreach ( var_5 in level.players )
    {
        var_5 setcommonplayerdata( "round", "endReasonTextIndex", var_1 );

        if ( var_5 maps\mp\_utility::_ID25420() && !maps\mp\_utility::_ID18363() )
            var_5 maps\mp\_matchdata::logfinalstats();
    }

    setmatchdata( "host", level._ID17103 );

    if ( maps\mp\_utility::_ID20673() )
    {
        setmatchdata( "playlistVersion", getplaylistversion() );
        setmatchdata( "playlistID", getplaylistid() );
        setmatchdata( "isDedicated", isdedicatedserver() );
    }

    sendmatchdata();

    foreach ( var_5 in level.players )
        var_5.pers["stats"] = var_5._ID31525;

    if ( !var_2 && !level._ID24789 )
    {
        if ( !maps\mp\_utility::_ID35914() )
            wait 6.0;
        else
            wait(min( 10.0, 4.0 + level._ID24789 ));
    }
    else
        wait(min( 10.0, 4.0 + level._ID24789 ));

    maps\mp\_utility::levelflagwaitopen( "post_game_level_event_active" );
    setnojipscore( 0 );
    setnojiptime( 0 );
    level notify( "exitLevel_called" );
    exitlevel( 0 );
}

_ID34599( var_0 )
{
    if ( !level._ID32653 )
        return 1;

    if ( maps\mp\_utility::_ID18706() )
    {
        if ( maps\mp\_utility::_ID17022() )
            return game["end_reason"]["score_limit_reached"];

        if ( maps\mp\_utility::_ID17024() )
            return game["end_reason"]["time_limit_reached"];
    }
    else if ( maps\mp\_utility::hitroundlimit() )
        return game["end_reason"]["round_limit_reached"];

    if ( maps\mp\_utility::_ID17025() )
        return game["end_reason"]["score_limit_reached"];

    return game["end_reason"]["objective_completed"];
}

estimatedtimetillscorelimit( var_0 )
{
    var_1 = getscoreperminute( var_0 );
    var_2 = _ID15331( var_0 );
    var_3 = 999999;

    if ( var_1 )
        var_3 = var_2 / var_1;

    return var_3;
}

getscoreperminute( var_0 )
{
    var_1 = maps\mp\_utility::getwatcheddvar( "scorelimit" );
    var_2 = maps\mp\_utility::_ID15434();
    var_3 = maps\mp\_utility::_ID15435() / 60000 + 0.0001;

    if ( isplayer( self ) )
        var_4 = self.score / var_3;
    else
        var_4 = getteamscore( var_0 ) / var_3;

    return var_4;
}

_ID15331( var_0 )
{
    var_1 = maps\mp\_utility::getwatcheddvar( "scorelimit" );

    if ( isplayer( self ) )
        var_2 = var_1 - self.score;
    else
        var_2 = var_1 - getteamscore( var_0 );

    return var_2;
}

_ID15604()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    maps\mp\_utility::_ID35774( 3 );
    thread maps\mp\_utility::_ID32672( "callout_lastteammemberalive", self, self.pers["team"] );

    foreach ( var_1 in level._ID32668 )
    {
        if ( self.pers["team"] != var_1 )
            thread maps\mp\_utility::_ID32672( "callout_lastenemyalive", self, var_1 );
    }

    level notify( "last_alive",  self  );
}

_ID25043()
{
    var_0 = 0;

    foreach ( var_2 in level.players )
    {
        if ( !isdefined( var_2 ) )
            continue;

        var_2.clientmatchdataid = var_0;
        var_0++;

        if ( level._ID25139 && var_2.name.size > level.maxnamelength )
        {
            var_3 = "";

            for ( var_4 = 0; var_4 < level.maxnamelength - 3; var_4++ )
                var_3 += var_2.name[var_4];

            var_3 += "...";
        }
        else
            var_3 = var_2.name;

        setclientmatchdata( "players", var_2.clientmatchdataid, "xuid", var_3 );
        var_2 setcommonplayerdata( "round", "clientMatchIndex", var_2.clientmatchdataid );
    }

    maps\mp\_awards::assignawards();
    maps\mp\_scoreboard::_ID25044();
    sendclientmatchdata();
}

_ID33311( var_0, var_1 )
{
    thread _ID32913( var_0, 1, "deaths" );
}

_ID33296( var_0, var_1 )
{
    if ( isdefined( self ) && isplayer( self ) )
    {
        if ( var_1 != "MOD_FALLING" )
        {
            if ( var_1 == "MOD_MELEE" && issubstr( var_0, "tactical" ) )
            {
                maps\mp\_matchdata::_ID20243( "tactical", "kills", 1 );
                maps\mp\_matchdata::_ID20243( "tactical", "hits", 1 );
                maps\mp\gametypes\_persistence::_ID17542( "tactical", "kills", 1 );
                maps\mp\gametypes\_persistence::_ID17542( "tactical", "hits", 1 );
                return;
            }

            if ( var_1 == "MOD_MELEE" && !maps\mp\gametypes\_weapons::_ID18766( var_0 ) && var_0 != "iw6_knifeonly_mp" && var_0 != "iw6_knifeonlyfast_mp" )
            {
                maps\mp\_matchdata::_ID20243( "none", "kills", 1 );
                maps\mp\_matchdata::_ID20243( "none", "hits", 1 );
                maps\mp\gametypes\_persistence::_ID17542( "none", "kills", 1 );
                maps\mp\gametypes\_persistence::_ID17542( "none", "hits", 1 );
                return;
            }

            thread _ID32913( var_0, 1, "kills" );
        }

        if ( var_1 == "MOD_HEAD_SHOT" )
        {
            thread _ID32913( var_0, 1, "headShots" );
            return;
        }

        return;
    }
}

_ID29209( var_0, var_1, var_2 )
{
    if ( !var_1 )
        return;

    var_3 = maps\mp\_utility::getweaponclass( var_0 );

    if ( var_3 == "killstreak" || var_3 == "other" && var_0 != "trophy_mp" )
        return;

    if ( maps\mp\_utility::_ID18615( var_0 ) )
        return;

    if ( var_3 == "weapon_grenade" || var_3 == "weapon_explosive" || var_0 == "trophy_mp" )
    {
        var_4 = maps\mp\_utility::_ID31978( var_0, "_mp" );
        maps\mp\gametypes\_persistence::_ID17544( var_4, var_2, var_1 );
        maps\mp\_matchdata::logweaponstat( var_4, var_2, var_1 );
        return;
    }

    if ( !isdefined( self._ID33308 ) )
        self._ID33308 = var_0;

    if ( var_0 != self._ID33308 )
    {
        maps\mp\gametypes\_persistence::_ID34646();
        self._ID33308 = var_0;
    }

    switch ( var_2 )
    {
        case "shots":
            self._ID33309++;
            break;
        case "hits":
            self._ID33306++;
            break;
        case "headShots":
            self.trackingweaponheadshots++;
            break;
        case "kills":
            self._ID33307++;
            break;
    }

    if ( var_2 == "deaths" )
    {
        var_5 = undefined;
        var_6 = maps\mp\_utility::_ID14903( var_0 );

        if ( !maps\mp\_utility::iscacprimaryweapon( var_6 ) && !maps\mp\_utility::_ID18576( var_6 ) )
            return;

        var_7 = maps\mp\_utility::_ID15474( var_0 );
        maps\mp\gametypes\_persistence::_ID17544( var_6, var_2, var_1 );
        maps\mp\_matchdata::logweaponstat( var_6, "deaths", var_1 );

        foreach ( var_9 in var_7 )
        {
            if ( var_9 == "scope" )
                continue;

            maps\mp\gametypes\_persistence::_ID17542( var_9, var_2, var_1 );
            maps\mp\_matchdata::_ID20243( var_9, var_2, var_1 );
        }

        return;
    }
}

_ID28759( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        return;

    if ( !isdefined( var_0 ) )
    {
        var_1 _ID29209( var_2, 1, "hits" );
        return;
    }

    if ( !isdefined( var_0.playeraffectedarray ) )
        var_0.playeraffectedarray = [];

    var_3 = 1;

    for ( var_4 = 0; var_4 < var_0.playeraffectedarray.size; var_4++ )
    {
        if ( var_0.playeraffectedarray[var_4] == self )
        {
            var_3 = 0;
            break;
        }
    }

    if ( var_3 )
    {
        var_0.playeraffectedarray[var_0.playeraffectedarray.size] = self;
        var_1 _ID29209( var_2, 1, "hits" );
        return;
    }
}

_ID32913( var_0, var_1, var_2 )
{
    self endon( "disconnect" );
    waittillframeend;
    _ID29209( var_0, var_1, var_2 );
}

checkforpersonalbests()
{
    foreach ( var_1 in level.players )
    {
        if ( !isdefined( var_1 ) )
            continue;

        if ( var_1 maps\mp\_utility::_ID25420() )
        {
            var_2 = var_1 getcommonplayerdata( "round", "kills" );
            var_3 = var_1 getcommonplayerdata( "round", "deaths" );
            var_4 = var_1.pers["summary"]["xp"];
            var_5 = var_1 getrankedplayerdata( "bestKills" );
            var_6 = var_1 getrankedplayerdata( "mostDeaths" );
            var_7 = var_1 getrankedplayerdata( "mostXp" );

            if ( var_2 > var_5 )
                var_1 setrankedplayerdata( "bestKills", var_2 );

            if ( var_4 > var_7 )
                var_1 setrankedplayerdata( "mostXp", var_4 );

            if ( var_3 > var_6 )
                var_1 setrankedplayerdata( "mostDeaths", var_3 );

            if ( !maps\mp\_utility::_ID18363() )
                var_1 checkforbestweapon();

            var_1 maps\mp\_matchdata::_ID20264( var_4, "totalXp" );
            var_1 maps\mp\_matchdata::_ID20264( var_1.pers["summary"]["score"], "scoreXp" );
            var_1 maps\mp\_matchdata::_ID20264( var_1.pers["summary"]["operation"], "operationXp" );
            var_1 maps\mp\_matchdata::_ID20264( var_1.pers["summary"]["challenge"], "challengeXp" );
            var_1 maps\mp\_matchdata::_ID20264( var_1.pers["summary"]["match"], "matchXp" );
            var_1 maps\mp\_matchdata::_ID20264( var_1.pers["summary"]["misc"], "miscXp" );
        }

        if ( isdefined( var_1.pers["confirmed"] ) )
            var_1 maps\mp\_matchdata::logkillsconfirmed();

        if ( isdefined( var_1.pers["denied"] ) )
            var_1 maps\mp\_matchdata::_ID20252();
    }
}

isvalidbestweapon( var_0 )
{
    var_1 = maps\mp\_utility::getweaponclass( var_0 );
    return isdefined( var_0 ) && var_0 != "" && !maps\mp\_utility::_ID18679( var_0 ) && var_1 != "killstreak" && var_1 != "other";
}

checkforbestweapon()
{
    var_0 = maps\mp\_matchdata::buildbaseweaponlist();
    var_1 = "";
    var_2 = -1;

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        var_4 = var_0[var_3];
        var_4 = maps\mp\_utility::_ID14903( var_4 );

        if ( isvalidbestweapon( var_4 ) )
        {
            var_5 = self getrankedplayerdata( "weaponStats", var_4, "kills" );

            if ( var_5 > var_2 )
            {
                var_1 = var_4;
                var_2 = var_5;
            }
        }
    }

    var_6 = self getrankedplayerdata( "weaponStats", var_1, "shots" );
    var_7 = self getrankedplayerdata( "weaponStats", var_1, "headShots" );
    var_8 = self getrankedplayerdata( "weaponStats", var_1, "hits" );
    var_9 = self getrankedplayerdata( "weaponStats", var_1, "deaths" );
    var_10 = 0;
    self setrankedplayerdata( "bestWeapon", "kills", var_2 );
    self setrankedplayerdata( "bestWeapon", "shots", var_6 );
    self setrankedplayerdata( "bestWeapon", "headShots", var_7 );
    self setrankedplayerdata( "bestWeapon", "hits", var_8 );
    self setrankedplayerdata( "bestWeapon", "deaths", var_9 );
    self setrankedplayerdata( "bestWeaponXP", var_10 );
    var_11 = int( tablelookup( "mp/statstable.csv", 4, var_1, 0 ) );
    self setrankedplayerdata( "bestWeaponIndex", var_11 );
}

_ID21359()
{
    level waittill( "round_end_finished" );
    level notify( "final_killcam_done" );
    level.forcedend = 1;
    level thread endgame( "axis", game["end_reason"]["objective_failed"] );
}
