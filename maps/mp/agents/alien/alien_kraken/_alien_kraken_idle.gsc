// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    self endon( "killanimscript" );
    init_alien_idle();

    if ( !isdefined( level.fx_water_loop_running ) )
    {
        level.fx_water_loop_running = 1;
        thread play_water_fx_loop();
    }

    for (;;)
    {
        if ( !isdefined( self._ID38117 ) || self.posturing || self.smashing )
        {
            wait 0.05;
            continue;
        }

        _ID23783();
    }
}

init_alien_idle()
{
    self._ID17354 = 0;
}

_ID23783()
{
    var_0 = selectidleanimstate();
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_0, undefined, "idle", "end" );
}

play_water_fx_loop()
{
    self endon( "death" );
    var_0 = [ "water_fx1", "water_fx2", "water_fx3", "water_fx4" ];

    for (;;)
    {
        wait 0.01;

        if ( common_scripts\utility::_ID13177( "fx_kraken_water" ) )
        {
            wait(randomfloatrange( 0.8, 3.3 ));
            self setscriptablepartstate( "body", "normal" );
            wait 0.1;
            var_1 = common_scripts\utility::_ID25350( var_0 );
            self setscriptablepartstate( "body", var_1 );
        }
    }

    if ( common_scripts\utility::_ID13177( "fx_kraken_water" ) )
        self setscriptablepartstate( "body", "normal" );
}

end_water_fx_loop()
{
    self waittill( "heat" );
    wait 0.1;
    self setscriptablepartstate( "tentacle", "normal" );
}

selectidleanimstate()
{
    var_0 = "idle_";

    if ( isdefined( self._ID36719 ) )
        var_0 += ( self._ID36719 + "_" );

    var_1 = var_0 + level._ID2829["kraken"].attributes[self._ID38117]["ship_side"];
    return var_1;
}
