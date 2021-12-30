// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    if ( !level._ID32653 )
        return;

    precacheshader( "headicon_dead" );
    level thread _ID22877();
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0._ID28041 = [];
    }
}

_ID34530()
{

}

adddeathicon( var_0, var_1, var_2, var_3 )
{
    if ( !level._ID32653 )
        return;

    var_4 = var_0.origin;
    var_1 endon( "spawned_player" );
    var_1 endon( "disconnect" );
    wait 0.05;
    maps\mp\_utility::_ID35777();

    if ( getdvar( "ui_hud_showdeathicons" ) == "0" )
        return;

    if ( level.hardcoremode )
        return;

    if ( isdefined( self.lastdeathicon ) )
        self.lastdeathicon destroy();

    var_5 = newteamhudelem( var_2 );
    var_5.x = var_4[0];
    var_5.y = var_4[1];
    var_5.z = var_4[2] + 54;
    var_5.alpha = 0.61;
    var_5.archived = 0;
    var_5.showinkillcam = 0;

    if ( level.splitscreen )
        var_5 setshader( "headicon_dead", 14, 14 );
    else
        var_5 setshader( "headicon_dead", 7, 7 );

    var_5 setwaypoint( 0 );
    self.lastdeathicon = var_5;
    var_5 thread destroyslowly( var_3 );
}

destroyslowly( var_0 )
{
    self endon( "death" );
    wait(var_0);
    self fadeovertime( 1.0 );
    self.alpha = 0;
    wait 1.0;
    self destroy();
}
