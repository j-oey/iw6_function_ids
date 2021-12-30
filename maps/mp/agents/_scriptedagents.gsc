// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

onenterstate( var_0, var_1 )
{
    if ( isdefined( self._ID22818 ) )
    {
        self [[ self._ID22818 ]]( var_0, var_1 );
        return;
    }
}

_ID22794()
{
    self notify( "killanimscript" );
}

_ID23883( var_0, var_1, var_2, var_3 )
{
    playanimnuntilnotetrack( var_0, 0, var_1, var_2, var_3 );
}

playanimnuntilnotetrack( var_0, var_1, var_2, var_3, var_4 )
{
    self setanimstate( var_0, var_1 );

    if ( !isdefined( var_3 ) )
        var_3 = "end";

    _ID35786( var_2, var_3, var_0, var_1, var_4 );
}

playanimnatrateuntilnotetrack( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self setanimstate( var_0, var_1, var_2 );

    if ( !isdefined( var_4 ) )
        var_4 = "end";

    _ID35786( var_3, var_4, var_0, var_1, var_5 );
}

_ID35786( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = gettime();
    var_6 = undefined;
    var_7 = undefined;

    if ( isdefined( var_2 ) && isdefined( var_3 ) )
        var_7 = getanimlength( self getanimentry( var_2, var_3 ) );

    for (;;)
    {
        self waittill( var_0,  var_8  );

        if ( isdefined( var_7 ) )
            var_6 = ( gettime() - var_5 ) * 0.001 / var_7;

        if ( !isdefined( var_7 ) || var_6 > 0 )
        {
            if ( var_8 == var_1 || var_8 == "end" || var_8 == "anim_will_finish" || var_8 == "finish" )
                break;
        }

        if ( isdefined( var_4 ) )
            [[ var_4 ]]( var_8, var_2, var_3, var_6 );
    }
}

_ID23876( var_0, var_1 )
{
    _ID23879( var_0, 0, var_1 );
}

_ID23879( var_0, var_1, var_2 )
{
    self setanimstate( var_0, var_1 );
    wait(var_2);
}

playanimnatratefortime( var_0, var_1, var_2, var_3 )
{
    self setanimstate( var_0, var_1, var_2 );
    wait(var_3);
}

getanimscalefactors( var_0, var_1, var_2 )
{
    var_3 = length2d( var_0 );
    var_4 = var_0[2];
    var_5 = length2d( var_1 );
    var_6 = var_1[2];
    var_7 = 1;
    var_8 = 1;

    if ( isdefined( var_2 ) && var_2 )
    {
        var_9 = ( var_1[0], var_1[1], 0 );
        var_10 = vectornormalize( var_9 );

        if ( vectordot( var_10, var_0 ) < 0 )
            var_7 = 0;
        else if ( var_5 > 0 )
            var_7 = var_3 / var_5;
    }
    else if ( var_5 > 0 )
        var_7 = var_3 / var_5;

    if ( abs( var_6 ) > 0.001 && var_6 * var_4 >= 0 )
        var_8 = var_4 / var_6;

    var_11 = spawnstruct();
    var_11._ID36478 = var_7;
    var_11.z = var_8;
    return var_11;
}

getangleindex( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 10;

    if ( var_0 < 0 )
    {
        return int( ceil( ( 180 + var_0 - var_1 ) / 45 ) );
        return;
    }

    return int( floor( ( 180 + var_0 + var_1 ) / 45 ) );
    return;
}

droppostoground( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 18;

    var_2 = var_0 + ( 0, 0, var_1 );
    var_3 = var_0 + ( 0, 0, var_1 * -1 );
    var_4 = self aiphysicstrace( var_2, var_3, self.radius, self.height, 1 );

    if ( abs( var_4[2] - var_2[2] ) < 0.1 )
        return undefined;

    if ( abs( var_4[2] - var_3[2] ) < 0.1 )
        return undefined;

    return var_4;
}

canmovepointtopoint( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 6;

    var_3 = ( 0, 0, 1 ) * var_2;
    var_4 = var_0 + var_3;
    var_5 = var_1 + var_3;
    return self aiphysicstracepassed( var_4, var_5, self.radius, self.height - var_2, 1 );
}

_ID15459( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 6;

    var_3 = ( 0, 0, 1 ) * var_2;
    var_4 = var_0 + var_3;
    var_5 = var_1 + var_3;
    return self aiphysicstrace( var_4, var_5, self.radius + 4, self.height - var_2, 1 );
}

_ID15326( var_0 )
{
    var_1 = getmovedelta( var_0 );
    var_2 = self localtoworldcoords( var_1 );
    var_3 = _ID15459( self.origin, var_2 );
    var_4 = distance( self.origin, var_3 );
    var_5 = distance( self.origin, var_2 );
    return min( 1.0, var_4 / var_5 );
}

_ID27107( var_0, var_1, var_2, var_3 )
{
    var_4 = getrandomanimentry( var_0 );
    _ID27106( var_0, var_4, var_1, var_2, var_3 );
}

_ID27104( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = getrandomanimentry( var_0 );
    _ID27105( var_0, var_5, var_1, var_2, var_3, var_4 );
}

_ID27105( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self setanimstate( var_0, var_1, var_2 );
    _ID27106( var_0, var_1, var_3, var_4, var_5 );
}

_ID27106( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = self getanimentry( var_0, var_1 );
    var_6 = _ID15326( var_5 );
    self scragentsetanimscale( var_6, 1.0 );
    playanimnuntilnotetrack( var_0, var_1, var_2, var_3, var_4 );
    self scragentsetanimscale( 1.0, 1.0 );
}

getrandomanimentry( var_0 )
{
    var_1 = self getanimentrycount( var_0 );
    return randomint( var_1 );
}

_ID14876( var_0 )
{
    var_1 = vectortoangles( var_0 );
    var_2 = angleclamp180( var_1[1] - self.angles[1] );
    return getangleindex( var_2 );
}
