// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID23115 = 0;
    level._ID23111 = [];
    level thread _ID23102();
    level thread _ID23117();
}

_ID23110( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_0._ID23122 ) )
        var_0._ID23122 = [];

    var_7 = spawnstruct();
    var_7._ID25014 = var_4;
    var_7.colorindex = var_1;
    var_7._ID24543 = var_2;
    var_7.depthenable = var_3;
    var_7.type = var_5;

    if ( var_5 == "TEAM" )
        var_7.team = var_6;

    var_8 = _ID23112();
    var_0._ID23122[var_8] = var_7;
    _ID23101( var_0 );
    var_9 = [];

    foreach ( var_11 in var_7._ID24543 )
    {
        var_12 = outlinegethighestinfoforplayer( var_0, var_11 );

        if ( !isdefined( var_12 ) || var_12 == var_7 || var_12._ID25014 == var_7._ID25014 )
            var_9[var_9.size] = var_11;
    }

    if ( var_9.size > 0 )
        var_0 hudoutlineenableforclients( var_9, var_7.colorindex, var_7.depthenable );

    return var_8;
}

_ID23105( var_0, var_1 )
{
    if ( !isdefined( var_1._ID23122 ) )
    {
        _ID23120( var_1 );
        return;
    }
    else if ( !isdefined( var_1._ID23122[var_0] ) )
        return;

    var_2 = var_1._ID23122[var_0];
    var_3 = [];

    foreach ( var_6, var_5 in var_1._ID23122 )
    {
        if ( var_5 != var_2 )
            var_3[var_6] = var_5;
    }

    if ( var_3.size == 0 )
        _ID23120( var_1 );

    if ( isdefined( var_1 ) )
    {
        var_1._ID23122 = var_3;

        foreach ( var_8 in var_2._ID24543 )
        {
            if ( !isdefined( var_8 ) )
                continue;

            var_9 = outlinegethighestinfoforplayer( var_1, var_8 );

            if ( isdefined( var_9 ) )
            {
                if ( var_9._ID25014 <= var_2._ID25014 )
                    var_1 hudoutlineenableforclient( var_8, var_9.colorindex, var_9.depthenable );

                continue;
            }

            var_1 hudoutlinedisableforclient( var_8 );
        }

        return;
    }
}

_ID23102()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        level thread outlineonplayerdisconnect( var_0 );
    }
}

outlineonplayerdisconnect( var_0 )
{
    level endon( "game_ended" );
    var_0 waittill( "disconnect" );
    outlineremoveplayerfromvisibletoarrays( var_0 );
    _ID23106( var_0 );
}

_ID23117()
{
    for (;;)
    {
        level waittill( "joined_team",  var_0  );

        if ( !isdefined( var_0.team ) || var_0.team == "spectator" )
            continue;

        thread _ID23118( var_0 );
    }
}

_ID23118( var_0 )
{
    var_0 notify( "outlineOnPlayerJoinedTeam_onFirstSpawn" );
    var_0 endon( "outlineOnPlayerJoinedTeam_onFirstSpawn" );
    var_0 endon( "disconnect" );
    var_0 waittill( "spawned_player" );
    outlineremoveplayerfromvisibletoarrays( var_0 );
    _ID23106( var_0 );
    _ID23100( var_0 );
}

outlineremoveplayerfromvisibletoarrays( var_0 )
{
    level._ID23111 = common_scripts\utility::array_removeundefined( level._ID23111 );

    foreach ( var_2 in level._ID23111 )
    {
        var_3 = 0;

        foreach ( var_5 in var_2._ID23122 )
        {
            var_5._ID24543 = common_scripts\utility::array_removeundefined( var_5._ID24543 );

            if ( isdefined( var_0 ) && common_scripts\utility::array_contains( var_5._ID24543, var_0 ) )
            {
                var_5._ID24543 = common_scripts\utility::array_remove( var_5._ID24543, var_0 );
                var_3 = 1;
            }
        }

        if ( var_3 && isdefined( var_2 ) && isdefined( var_0 ) )
            var_2 hudoutlinedisableforclient( var_0 );
    }
}

_ID23100( var_0 )
{
    foreach ( var_2 in level._ID23111 )
    {
        if ( !isdefined( var_2 ) )
            continue;

        var_3 = undefined;

        foreach ( var_5 in var_2._ID23122 )
        {
            if ( var_5.type == "ALL" || var_5.type == "TEAM" && var_5.team == var_0.team )
            {
                if ( !common_scripts\utility::array_contains( var_5._ID24543, var_0 ) )
                {
                    var_5._ID24543[var_5._ID24543.size] = var_0;
                    jump loc_3FD
                }

                if ( !isdefined( var_3 ) || var_5._ID25014 > var_3._ID25014 )
                    var_3 = var_5;
            }
        }

        if ( isdefined( var_3 ) )
            var_2 hudoutlineenableforclient( var_0, var_3.colorindex, var_3.depthenable );
    }
}

_ID23106( var_0 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_0._ID23122 ) || var_0._ID23122.size == 0 )
        return;

    foreach ( var_3, var_2 in var_0._ID23122 )
        _ID23105( var_3, var_0 );
}

_ID23101( var_0 )
{
    if ( !common_scripts\utility::array_contains( level._ID23111, var_0 ) )
    {
        level._ID23111[level._ID23111.size] = var_0;
        return;
    }
}

_ID23120( var_0 )
{
    level._ID23111 = common_scripts\utility::array_remove( level._ID23111, var_0 );
}

outlinegethighestpriorityid( var_0 )
{
    var_1 = -1;

    if ( !isdefined( var_0._ID23122 ) || var_0.size == 0 )
        return var_1;

    var_2 = undefined;

    foreach ( var_5, var_4 in var_0._ID23122 )
    {
        if ( !isdefined( var_2 ) || var_4._ID25014 > var_2._ID25014 )
        {
            var_2 = var_4;
            var_1 = var_5;
        }
    }

    return var_1;
}

outlinegethighestinfoforplayer( var_0, var_1 )
{
    var_2 = undefined;

    if ( isdefined( var_0._ID23122 ) && var_0._ID23122.size )
    {
        foreach ( var_5, var_4 in var_0._ID23122 )
        {
            if ( common_scripts\utility::array_contains( var_4._ID24543, var_1 ) && ( !isdefined( var_2 ) || var_4._ID25014 > var_2._ID25014 ) )
                var_2 = var_4;
        }
    }

    return var_2;
}

_ID23112()
{
    level._ID23115++;
    return level._ID23115;
}

_ID23119( var_0 )
{
    var_0 = tolower( var_0 );
    var_1 = undefined;

    switch ( var_0 )
    {
        case "level_script":
            var_1 = 0;
            break;
        case "equipment":
            var_1 = 1;
            break;
        case "perk":
            var_1 = 2;
            break;
        case "killstreak":
            var_1 = 3;
            break;
        case "killstreak_personal":
            var_1 = 4;
            break;
        default:
            var_1 = 0;
            break;
    }

    return var_1;
}

_ID23103( var_0 )
{
    var_0 = tolower( var_0 );
    var_1 = undefined;

    switch ( var_0 )
    {
        case "white":
            var_1 = 0;
            break;
        case "red":
            var_1 = 1;
            break;
        case "green":
            var_1 = 2;
            break;
        case "cyan":
            var_1 = 3;
            break;
        case "orange":
            var_1 = 4;
            break;
        case "yellow":
            var_1 = 5;
            break;
        case "blue":
            var_1 = 6;
            break;
        default:
            var_1 = 0;
            break;
    }

    return var_1;
}
