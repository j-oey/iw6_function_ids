// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID15661( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = common_scripts\utility::_ID15386( var_0, "targetname" );

    if ( var_5.size <= 0 )
        return;

    if ( !isdefined( var_2 ) )
        var_2 = randomfloatrange( -20, -15 );

    if ( !isdefined( var_3 ) )
        var_3 = var_1;

    foreach ( var_7 in var_5 )
    {
        if ( !isdefined( level._ID1644 ) )
            level._ID1644 = [];

        if ( !isdefined( level._ID1644[var_3] ) )
            level._ID1644[var_3] = loadfx( var_1 );

        if ( !isdefined( var_7.angles ) )
            var_7.angles = ( 0, 0, 0 );

        var_8 = common_scripts\utility::createoneshoteffect( var_3 );
        var_8._ID34830["origin"] = var_7.origin;
        var_8._ID34830["angles"] = var_7.angles;
        var_8._ID34830["fxid"] = var_3;
        var_8._ID34830["delay"] = var_2;

        if ( isdefined( var_4 ) )
            var_8._ID34830["soundalias"] = var_4;
    }
}
