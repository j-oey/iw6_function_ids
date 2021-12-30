// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    self.animsubstate = "none";
    _ID28903();
    self.timeofnextsound = self.timeofnextsound + 2000;
    self.bidlehitreaction = 0;
    self scragentsetgoalpos( self.origin );
    self scragentsetorientmode( "face angle abs", self.angles );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetphysicsmode( "gravity" );
    _ID34615();
}

end_script()
{
    if ( isdefined( self._ID24955 ) )
    {
        self scragentsetmaxturnspeed( self._ID24955 );
        self._ID24955 = undefined;
        return;
    }
}

_ID34615()
{
    self endon( "killanimscript" );
    self endon( "cancelidleloop" );

    for (;;)
    {
        var_0 = self.animsubstate;
        var_1 = _ID9948();

        if ( var_1 != self.animsubstate )
            _ID12135( var_1 );

        _ID34505();

        switch ( self.animsubstate )
        {
            case "idle_combat":
                wait 0.2;
                continue;
            case "idle_noncombat":
                if ( var_0 == "none" )
                {
                    if ( self.movemode == "run" || self.movemode == "sprint" )
                        self playsoundonmovingent( common_scripts\utility::_ID32831( self._ID36783, "anml_wolf_pants_mp_fast", "anml_dog_pants_mp_fast" ) );
                    else
                        self playsoundonmovingent( common_scripts\utility::_ID32831( self._ID36783, "anml_wolf_pants_mp_med", "anml_dog_pants_mp_med" ) );
                }
                else if ( gettime() > self.timeofnextsound )
                {
                    if ( randomint( 10 ) < 4 )
                        self playsoundonmovingent( common_scripts\utility::_ID32831( self._ID36783, "anml_wolf_whine", "anml_dog_whine" ) );
                    else
                        self playsoundonmovingent( common_scripts\utility::_ID32831( self._ID36783, "anml_wolf_pants_mp_med", "anml_dog_pants_mp_med" ) );

                    _ID28903();
                }

                wait 0.5;
                continue;
            default:
                wait 1;
                continue;
        }
    }
}

_ID9948()
{
    if ( _ID29853() )
    {
        return "idle_combat";
        return;
    }

    return "idle_noncombat";
    return;
}

_ID12135( var_0 )
{
    _ID12446( self.animsubstate );
    self.animsubstate = var_0;
    _ID24598();
}

_ID12446( var_0 )
{
    if ( isdefined( self._ID24955 ) )
    {
        self scragentsetmaxturnspeed( self._ID24955 );
        self._ID24955 = undefined;
        return;
    }
}

_ID24598()
{
    if ( self.animsubstate == "idle_combat" )
    {
        self setanimstate( "attack_idle" );
        return;
    }

    self setanimstate( "casual_idle" );
    return;
}

_ID34505()
{
    var_0 = undefined;

    if ( isdefined( self.enemy ) && distancesquared( self.enemy.origin, self.origin ) < 1048576 )
        var_0 = self.enemy;
    else if ( isdefined( self.owner ) && distancesquared( self.owner.origin, self.origin ) > 576 )
        var_0 = self.owner;

    if ( isdefined( var_0 ) )
    {
        var_1 = var_0.origin - self.origin;
        var_2 = vectortoangles( var_1 );

        if ( abs( angleclamp180( var_2[1] - self.angles[1] ) ) > 1 )
        {
            _ID33982( var_2[1] );
            return;
        }

        return;
    }
}

_ID29853()
{
    return isdefined( self.enemy ) && maps\mp\_utility::_ID18757( self.enemy ) && distancesquared( self.origin, self.enemy.origin ) < 1000000;
}

getturnanimstate( var_0 )
{
    if ( _ID29853() )
    {
        if ( var_0 < -135 || var_0 > 135 )
        {
            return "attack_turn_180";
            return;
        }

        if ( var_0 < 0 )
        {
            return "attack_turn_right_90";
            return;
        }

        return "attack_turn_left_90";
        return;
        return;
        return;
    }

    if ( var_0 < -135 || var_0 > 135 )
    {
        return "casual_turn_180";
        return;
    }

    if ( var_0 < 0 )
    {
        return "casual_turn_right_90";
        return;
    }

    return "casual_turn_left_90";
    return;
    return;
    return;
}

_ID33982( var_0 )
{
    var_1 = self.angles[1];
    var_2 = angleclamp180( var_0 - var_1 );

    if ( -0.5 < var_2 && var_2 < 0.5 )
        return;

    if ( -10 < var_2 && var_2 < 10 )
    {
        _ID26748( var_0, 2 );
        return;
    }

    var_3 = getturnanimstate( var_2 );
    var_4 = self getanimentry( var_3, 0 );
    var_5 = getanimlength( var_4 );
    var_6 = getangledelta3d( var_4 );
    self scragentsetanimmode( "anim angle delta" );

    if ( animhasnotetrack( var_4, "turn_begin" ) && animhasnotetrack( var_4, "turn_end" ) )
    {
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_3, 0, "turn_in_place" );
        var_7 = getnotetracktimes( var_4, "turn_begin" );
        var_8 = getnotetracktimes( var_4, "turn_end" );
        var_9 = ( var_8[0] - var_7[0] ) * var_5;
        var_10 = angleclamp180( var_2 - var_6[1] );
        var_11 = abs( var_10 ) / var_9 / 20;
        var_11 = var_11 * 3.14159 / 180;
        var_12 = ( 0, angleclamp180( self.angles[1] + var_10 ), 0 );
        self._ID24955 = self scragentgetmaxturnspeed();
        self scragentsetmaxturnspeed( var_11 );
        self scragentsetorientmode( "face angle abs", var_12 );
        maps\mp\agents\_scriptedagents::_ID35786( "turn_in_place", "turn_end" );
        self scragentsetmaxturnspeed( self._ID24955 );
        self._ID24955 = undefined;
        maps\mp\agents\_scriptedagents::_ID35786( "turn_in_place", "end" );
    }
    else
    {
        self._ID24955 = self scragentgetmaxturnspeed();
        var_11 = abs( angleclamp180( var_2 - var_6[1] ) ) / var_5 / 20;
        var_11 = var_11 * 3.14159 / 180;
        self scragentsetmaxturnspeed( var_11 );
        var_12 = ( 0, angleclamp180( var_0 - var_6[1] ), 0 );
        self scragentsetorientmode( "face angle abs", var_12 );
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_3, 0, "turn_in_place" );
        self scragentsetmaxturnspeed( self._ID24955 );
        self._ID24955 = undefined;
    }

    self scragentsetanimmode( "anim deltas" );
    _ID24598();
}

_ID26748( var_0, var_1 )
{
    if ( abs( angleclamp180( var_0 - self.angles[1] ) ) <= var_1 )
        return;

    var_2 = ( 0, var_0, 0 );
    self scragentsetorientmode( "face angle abs", var_2 );

    while ( angleclamp180( var_0 - self.angles[1] ) > var_1 )
        wait 0.1;
}

_ID28903()
{
    self.timeofnextsound = gettime() + 8000 + randomint( 5000 );
}

_ID10580( var_0 )
{
    self.blockgoalpos = 1;
    self.statelocked = 1;
    self.bidlehitreaction = 1;
    var_1 = angleclamp180( var_0 - self.angles[1] );

    if ( var_1 > 0 )
        var_2 = 1;
    else
        var_2 = 0;

    self notify( "cancelidleloop" );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "stand_pain", var_2, "stand_pain" );
    self.blockgoalpos = 0;
    self.statelocked = 0;
    self.bidlehitreaction = 0;
    self scragentsetorientmode( "face angle abs", self.angles );
    self.animsubstate = "none";
    thread _ID34615();
}

_ID22790( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( self.bidlehitreaction )
        return;

    var_10 = vectortoangles( var_7 );
    var_11 = var_10[1] - 180;
    _ID10580( var_11 );
}

_ID22843( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( self.bidlehitreaction )
        return;

    _ID10580( self.angles[1] + 180 );
}
