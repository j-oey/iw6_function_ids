// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID27781()
{
    if ( !isdefined( self._ID27611 ) || !isdefined( self._ID27610 ) || !isdefined( self.script_delay ) )
    {
        self delete();
        return;
    }

    if ( isdefined( self.target ) )
        var_0 = getent( self.target ).origin;
    else
        var_0 = "undefined";

    if ( self._ID27610 == "OneShotfx" )
    {

    }

    if ( self._ID27610 == "loopfx" )
    {

    }

    if ( self._ID27610 == "loopsound" )
        return;
}

_ID15792( var_0 )
{
    playfx( level._ID1644["mechanical explosion"], var_0 );
    earthquake( 0.15, 0.5, var_0, 250 );
}

_ID30495( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_3.origin = var_1;
    var_3 playloopsound( var_0 );

    if ( isdefined( var_2 ) )
        var_3 thread _ID30496( var_2 );
}

_ID30496( var_0 )
{
    level waittill( var_0 );
    self delete();
}

_ID13742()
{
    var_0 = [];
    var_1 = [];
    var_2 = getentarray( "vfx_custom_glass", "targetname" );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4.script_noteworthy ) )
        {
            var_5 = getglass( var_4.script_noteworthy );

            if ( isdefined( var_5 ) )
            {
                var_1[var_5] = var_4;
                var_0[var_0.size] = var_5;
            }
        }
    }

    var_7 = var_0.size;
    var_8 = var_0.size;
    var_9 = 5;
    var_10 = 0;

    while ( var_7 != 0 )
    {
        var_11 = var_10 + var_9 - 1;

        if ( var_11 > var_8 )
            var_11 = var_8;

        if ( var_10 == var_8 )
            var_10 = 0;

        while ( var_10 < var_11 )
        {
            var_12 = var_0[var_10];
            var_4 = var_1[var_12];

            if ( isdefined( var_4 ) )
            {
                if ( isglassdestroyed( var_12 ) )
                {
                    var_4 delete();
                    var_7--;
                    var_1[var_12] = undefined;
                }
            }

            var_10++;
        }

        wait 0.05;
    }
}

_ID5341( var_0 )
{
    self waittill( "death" );
    var_0 delete();
}
