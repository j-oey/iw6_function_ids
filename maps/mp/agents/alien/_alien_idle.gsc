// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    self endon( "killanimscript" );
    init_alien_idle();

    for (;;)
    {
        if ( isdefined( self.attractor_flare ) )
        {
            _ID23726();
            continue;
        }

        if ( isdefined( self._ID11893 ) && self._ID11893 )
        {
            _ID23752();

            if ( level.gameended )
                self._ID11893 = 0;

            continue;
        }

        _ID23783();
    }
}

init_alien_idle()
{
    self._ID17354 = 0;
    self._ID7875 = 0;

    if ( isdefined( self._ID36479 ) )
        self scragentsetanimscale( self._ID36479, 1.0 );

    if ( isdefined( self.idle_state_locked ) && self.idle_state_locked )
    {
        self.statelocked = 1;
        return;
    }
}

end_script()
{
    self._ID24939 = "idle";

    if ( isdefined( self.idle_state_locked ) && self.idle_state_locked )
    {
        self.statelocked = 0;
        self.idle_state_locked = 0;
        return;
    }
}

_ID23752()
{
    _ID12573();
    self scragentsetorientmode( "face angle abs", self.angles );
    maps\mp\agents\_scriptedagents::_ID23883( "posture", "posture", "end" );
}

_ID23726()
{
    var_0 = vectortoangles( self.attractor_flare.origin - self.origin );
    var_0 = ( self.angles[0], var_0[1], self.angles[2] );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", var_0 );
    var_1 = maps\mp\agents\_scriptedagents::getrandomanimentry( "idle_flare" );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "idle_flare", var_1, "idle_flare", "end" );
}

_ID23783()
{
    _ID12573();
    var_0 = selectidleanimstate();
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_0, undefined, var_0, "end" );
}

selectidleanimstate()
{
    if ( isdefined( level.dlc_idle_anim_state_override_func ) )
    {
        var_0 = self [[ level.dlc_idle_anim_state_override_func ]]( self.enemy );

        if ( isdefined( var_0 ) )
            return var_0;
    }

    if ( isalive( self.enemy ) )
    {
        if ( common_scripts\utility::_ID7657() && self._ID7875 < 2 )
        {
            self._ID7875++;
            return "idle_posture";
        }
    }

    self._ID7875 = 0;

    if ( self._ID17354 < 2 + randomintrange( 0, 1 ) )
    {
        var_1 = "idle_default";
        self._ID17354 = self._ID17354 + 1;
    }
    else
    {
        var_1 = "idle";
        self._ID17354 = 0;
    }

    return var_1;
}

_ID12573()
{
    var_0 = undefined;

    if ( isalive( self.enemy ) && distancesquared( self.enemy.origin, self.origin ) < 2560000 )
        var_0 = self.enemy;
    else if ( isdefined( self.owner ) )
        var_0 = self.owner;

    if ( isdefined( var_0 ) )
    {
        maps\mp\agents\alien\_alien_anim_utils::_ID33986( var_0 );
        return;
    }
}

_ID22790( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( isdefined( level.dlc_can_do_pain_override_func ) )
    {
        var_10 = [[ level.dlc_can_do_pain_override_func ]]( "idle" );

        if ( !var_10 )
            return;
    }

    if ( maps\mp\alien\_unk1464::_ID18462( var_1, var_4 ) )
    {
        dopain( var_3, var_7, var_8, var_2, var_4 );
        return;
    }
}

dopain( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "killanimscript" );
    var_5 = var_0 & level._ID17348;

    if ( var_4 == "MOD_MELEE" || var_5 )
    {
        var_6 = "pain_pushback";
        var_7 = maps\mp\agents\alien\_alien_anim_utils::_ID15226( "push_back", var_1 );
        var_8 = "pain_pushback";
    }
    else
    {
        var_9 = getbasepainanimstate();
        var_6 = maps\mp\agents\alien\_alien_anim_utils::_ID15227( var_9, var_3, var_5 );
        var_7 = maps\mp\agents\alien\_alien_anim_utils::_ID15226( "idle", var_1, var_2 );
        var_8 = "idle_pain";
    }

    var_10 = self getanimentry( var_6, var_7 );
    maps\mp\alien\_unk1464::always_play_pain_sound( var_10 );
    maps\mp\alien\_unk1464::_ID25692( var_10 );
    self.statelocked = 1;

    if ( isdefined( self.oriented ) && self.oriented )
        self scragentsetanimmode( "code_move" );
    else
    {
        self scragentsetanimmode( "anim deltas" );
        self scragentsetorientmode( "face angle abs", self.angles );
    }

    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_6, var_7, var_8 );

    if ( !isdefined( self.idle_state_locked ) || !self.idle_state_locked )
        self.statelocked = 0;

    self setanimstate( "idle" );
}

getbasepainanimstate()
{
    if ( isdefined( level.dlc_alien_pain_anim_state_override_func ) )
    {
        var_0 = [[ level.dlc_alien_pain_anim_state_override_func ]]( "idle" );

        if ( isdefined( var_0 ) )
            return var_0;
    }

    return "idle_pain";
}
