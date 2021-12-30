// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID21073()
{
    var_0 = getentarray( "minefield", "targetname" );

    if ( var_0.size > 0 )
        level._ID1644["mine_explosion"] = loadfx( "vfx/gameplay/explosions/weap/gre/vfx_exp_gre_dirt_cg" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        var_0[var_1] thread _ID21072();
}

_ID21072()
{
    for (;;)
    {
        self waittill( "trigger",  var_0  );

        if ( isplayer( var_0 ) )
            var_0 thread _ID21071( self );
    }
}

_ID21071( var_0 )
{
    if ( isdefined( self._ID21070 ) )
        return;

    self._ID21070 = 1;
    wait 0.5;
    wait(randomfloat( 0.5 ));

    if ( isdefined( self ) && self istouching( var_0 ) )
    {
        var_1 = self getorigin();
        var_2 = 300;
        var_3 = 2000;
        var_4 = 50;
        radiusdamage( var_1, var_2, var_3, var_4 );
    }

    self._ID21070 = undefined;
}
