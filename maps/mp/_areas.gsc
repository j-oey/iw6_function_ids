// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID30384 = getentarray( "trigger_multiple_softlanding", "classname" );
    var_0 = getentarray( "destructible_vehicle", "targetname" );

    foreach ( var_2 in level._ID30384 )
    {
        if ( var_2._ID27878 != "car" )
            continue;

        foreach ( var_4 in var_0 )
        {
            if ( distance( var_2.origin, var_4.origin ) > 64.0 )
                continue;

            var_2.destructible = var_4;
        }
    }

    thread _ID22877();
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0._ID30383 = undefined;
        var_0 thread softlandingwaiter();
    }
}

_ID24490( var_0 )
{
    self._ID30383 = var_0;
}

_ID24518( var_0 )
{
    self._ID30383 = undefined;
}

softlandingwaiter()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "soft_landing",  var_0, var_1  );

        if ( !isdefined( var_0.destructible ) )
            continue;
    }
}
