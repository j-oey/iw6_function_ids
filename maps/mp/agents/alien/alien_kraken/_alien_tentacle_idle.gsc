// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    self endon( "killanimscript" );
    init_alien_idle();

    for (;;)
    {
        if ( !self.extended || !isdefined( level.kraken ) || !isdefined( level.kraken._ID38117 ) )
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
    var_1 = level._ID2829["kraken"].attributes[self.tentacle_name]["anim_index"];
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_0, var_1, "idle", "end" );

    if ( !isheatedphaseactive() )
        self setscriptablepartstate( "tentacle", "normal" );
}

selectidleanimstate()
{
    if ( isheatedphaseactive() )
        var_0 = "heat_";
    else
        var_0 = "idle_";

    if ( isdefined( level.kraken._ID36719 ) )
        var_0 += ( level.kraken._ID36719 + "_" );

    var_1 = var_0 + level._ID2829["kraken"].attributes[level.kraken._ID38117]["ship_side"];
    return var_1;
}

isheatedphaseactive()
{
    return level.kraken.phase == "heat";
}
