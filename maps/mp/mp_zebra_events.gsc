// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID35496( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = var_0;

    maps\mp\_utility::gameflagwait( "prematch_done" );
    var_2 = maps\mp\_utility::getscorelimit();
    var_3 = maps\mp\_utility::_ID15434() * 60;
    var_4 = 0;
    var_5 = 0;

    if ( var_2 <= 0 && var_3 <= 0 )
    {
        var_4 = 1;
        var_3 = 600;
    }
    else if ( var_2 <= 0 )
        var_4 = 1;
    else if ( var_3 <= 0 )
        var_5 = 1;

    var_6 = var_0 * var_3;
    var_7 = var_1 * var_2;
    var_8 = _ID14496();
    var_9 = ( gettime() - level._ID31480 ) / 1000;

    if ( var_4 )
    {
        while ( var_9 < var_6 )
        {
            wait 0.5;
            var_9 = ( gettime() - level._ID31480 ) / 1000;
        }
    }
    else if ( var_5 )
    {
        while ( var_8 < var_7 )
        {
            wait 0.5;
            var_8 = _ID14496();
        }
    }
    else
    {
        while ( var_9 < var_6 && var_8 < var_7 )
        {
            wait 0.5;
            var_8 = _ID14496();
            var_9 = ( gettime() - level._ID31480 ) / 1000;
        }
    }
}

_ID14496()
{
    var_0 = 0;

    if ( level._ID32653 )
    {
        if ( isdefined( game["teamScores"] ) )
        {
            var_0 = game["teamScores"]["allies"];

            if ( game["teamScores"]["axis"] > var_0 )
                var_0 = game["teamScores"]["axis"];
        }
    }
    else if ( isdefined( level.players ) )
    {
        foreach ( var_2 in level.players )
        {
            if ( isdefined( var_2.score ) && var_2.score > var_0 )
                var_0 = var_2.score;
        }
    }

    return var_0;
}

_ID18359()
{
    return isdefined( self.spawnflags ) && self.spawnflags & 2;
}

is_dynamic_path()
{
    return isdefined( self.spawnflags ) && self.spawnflags & 1;
}
