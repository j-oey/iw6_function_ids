// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{

}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread _ID34597();
    }
}

showspawnpoint( var_0, var_1, var_2 )
{

}

_ID34597()
{

}

_ID25656()
{

}

_ID15754()
{

}

_ID15755()
{

}

devaliengiveplayersmoney()
{

}

_ID30539()
{
    var_0 = [ "headshot", "avenger", "execution", "longshot", "posthumous", "double", "triple", "multi" ];

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        thread maps\mp\gametypes\_rank::_ID36471( 100 );
        thread maps\mp\gametypes\_rank::_ID36462( var_0[var_1] );
        wait 2.0;
    }
}
