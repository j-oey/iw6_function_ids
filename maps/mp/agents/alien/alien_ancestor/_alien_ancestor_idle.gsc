// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    self endon( "killanimscript" );

    for (;;)
        _ID23783();
}

_ID23783()
{
    face_target();
    var_0 = get_idle_anim_state();
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_0, undefined, "idle", "end" );
}

get_idle_anim_state()
{
    if ( maps\mp\agents\alien\alien_ancestor\_alien_ancestor::isshieldup() )
        return "idle";

    return "idle_vulnerable";
}

face_target()
{
    var_0 = undefined;
    var_1 = 1600;

    if ( isalive( self.enemy ) && distancesquared( self.enemy.origin, self.origin ) < var_1 * var_1 )
        var_0 = self.enemy;

    if ( isdefined( var_0 ) )
        maps\mp\agents\alien\_alien_anim_utils::_ID33986( var_0 );
}
