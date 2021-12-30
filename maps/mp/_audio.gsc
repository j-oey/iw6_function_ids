// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

init_audio()
{
    if ( !isdefined( level.audio ) )
        level.audio = spawnstruct();

    init_reverb();
    init_whizby();
    level._ID22878 = ::_ID22878;
}

_ID22878()
{
    _ID3746( "default" );
}

init_reverb()
{
    add_reverb( "default", "generic", 0.15, 0.9, 2 );
}

add_reverb( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = [];
    _ID18485( var_1 );
    var_5["roomtype"] = var_1;
    var_5["wetlevel"] = var_2;
    var_5["drylevel"] = var_3;
    var_5["fadetime"] = var_4;
    level.audio._ID26254[var_0] = var_5;
}

_ID18485( var_0 )
{

}

_ID3746( var_0 )
{
    if ( !isdefined( level.audio._ID26254[var_0] ) )
        var_1 = level.audio._ID26254["default"];
    else
        var_1 = level.audio._ID26254[var_0];

    self setreverb( "snd_enveffectsprio_level", var_1["roomtype"], var_1["drylevel"], var_1["wetlevel"], var_1["fadetime"] );
}

init_whizby()
{
    level.audio._ID36328 = [];
    _ID28618( 15.0, 30.0, 50.0 );
    _ID28619( 150.0, 250.0, 350.0 );
}

_ID28618( var_0, var_1, var_2 )
{
    level.audio._ID36328["radius"] = [ var_0, var_1, var_2 ];
}

_ID28619( var_0, var_1, var_2 )
{
    level.audio._ID36328["spread"] = [ var_0, var_1, var_2 ];
}

apply_whizby()
{
    var_0 = level.audio._ID36328;
    var_1 = var_0["spread"];
    var_2 = var_0["radius"];
    self setwhizbyspreads( var_1[0], var_1[1], var_1[2] );
    self setwhizbyradii( var_2[0], var_2[1], var_2[2] );
}
