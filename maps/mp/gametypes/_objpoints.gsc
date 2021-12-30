// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    precacheshader( "objpoint_default" );
    level._ID22504 = [];
    level.objpoints = [];

    if ( level.splitscreen )
        level._ID22507 = 15;
    else
        level._ID22507 = 8;

    level._ID22503 = 0.75;
    level._ID22506 = 1.0;
}

createteamobjpoint( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = getobjpointbyname( var_0 );

    if ( isdefined( var_6 ) )
        deleteobjpoint( var_6 );

    if ( !isdefined( var_3 ) )
        var_3 = "objpoint_default";

    if ( !isdefined( var_5 ) )
        var_5 = 1.0;

    if ( var_2 != "all" )
        var_6 = newteamhudelem( var_2 );
    else
        var_6 = newhudelem();

    var_6.name = var_0;
    var_6.x = var_1[0];
    var_6.y = var_1[1];
    var_6.z = var_1[2];
    var_6.team = var_2;
    var_6.isflashing = 0;
    var_6._ID18782 = 1;
    var_6 setshader( var_3, level._ID22507, level._ID22507 );
    var_6 setwaypoint( 1, 0 );

    if ( isdefined( var_4 ) )
        var_6.alpha = var_4;
    else
        var_6.alpha = level._ID22503;

    var_6.basealpha = var_6.alpha;
    var_6.index = level._ID22504.size;
    level.objpoints[var_0] = var_6;
    level._ID22504[level._ID22504.size] = var_0;
    return var_6;
}

deleteobjpoint( var_0 )
{
    if ( level.objpoints.size == 1 )
    {
        level.objpoints = [];
        level._ID22504 = [];
        var_0 destroy();
        return;
    }

    var_1 = var_0.index;
    var_2 = level._ID22504.size - 1;
    var_3 = _ID15201( var_2 );
    level._ID22504[var_1] = var_3.name;
    var_3.index = var_1;
    level._ID22504[var_2] = undefined;
    level.objpoints[var_0.name] = undefined;
    var_0 destroy();
}

_ID34570( var_0 )
{
    if ( self.x != var_0[0] )
        self.x = var_0[0];

    if ( self.y != var_0[1] )
        self.y = var_0[1];

    if ( self.z != var_0[2] )
    {
        self.z = var_0[2];
        return;
    }
}

_ID28808( var_0, var_1 )
{
    var_2 = getobjpointbyname( var_0 );
    var_2 _ID34570( var_1 );
}

getobjpointbyname( var_0 )
{
    if ( isdefined( level.objpoints[var_0] ) )
    {
        return level.objpoints[var_0];
        return;
    }

    return undefined;
    return;
}

_ID15201( var_0 )
{
    if ( isdefined( level._ID22504[var_0] ) )
    {
        return level.objpoints[level._ID22504[var_0]];
        return;
    }

    return undefined;
    return;
}

_ID31444()
{
    self endon( "stop_flashing_thread" );

    if ( self.isflashing )
        return;

    self.isflashing = 1;

    while ( self.isflashing )
    {
        self fadeovertime( 0.75 );
        self.alpha = 0.35 * self.basealpha;
        wait 0.75;
        self fadeovertime( 0.75 );
        self.alpha = self.basealpha;
        wait 0.75;
    }

    self.alpha = self.basealpha;
}

_ID31839()
{
    if ( !self.isflashing )
        return;

    self.isflashing = 0;
}
