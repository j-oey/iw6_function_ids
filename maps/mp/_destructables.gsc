// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    var_0 = getentarray( "destructable", "targetname" );

    if ( getdvar( "scr_destructables" ) == "0" )
    {
        for ( var_1 = 0; var_1 < var_0.size; var_1++ )
            var_0[var_1] delete();
    }
    else
    {
        for ( var_1 = 0; var_1 < var_0.size; var_1++ )
            var_0[var_1] thread destructable_think();
    }
}

destructable_think()
{
    var_0 = 40;
    var_1 = 0;

    if ( isdefined( self._ID27419 ) )
        var_0 = self._ID27419;

    if ( isdefined( self._ID27860 ) )
        var_1 = self._ID27860;

    if ( isdefined( self._ID27527 ) )
    {
        var_2 = strtok( self._ID27527, " " );

        for ( var_3 = 0; var_3 < var_2.size; var_3++ )
            blockarea( var_2[var_3] );
    }

    if ( isdefined( self._ID27611 ) )
        self._ID13765 = loadfx( self._ID27611 );

    var_4 = 0;
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage",  var_5, var_6  );

        if ( var_5 >= var_1 )
        {
            var_4 += var_5;

            if ( var_4 >= var_0 )
            {
                thread _ID9821();
                return;
            }
        }
    }
}

_ID9821()
{
    var_0 = self;

    if ( isdefined( self._ID27527 ) )
    {
        var_1 = strtok( self._ID27527, " " );

        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
            _ID34188( var_1[var_2] );
    }

    if ( isdefined( var_0._ID13765 ) )
        playfx( var_0._ID13765, var_0.origin + ( 0, 0, 6 ) );

    var_0 delete();
}

blockarea( var_0 )
{

}

blockentsinarea( var_0, var_1 )
{

}

_ID34188( var_0 )
{

}

_ID34189( var_0, var_1 )
{

}
