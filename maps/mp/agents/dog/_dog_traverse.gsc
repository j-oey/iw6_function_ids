// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    self endon( "killanimscript" );

    if ( !isdefined( level._ID10576 ) )
        _ID17927();

    var_0 = self getnegotiationstartnode();
    var_1 = self getnegotiationendnode();
    var_2 = undefined;
    var_2 = level._ID10576[var_0.animscript];

    if ( !isdefined( var_2 ) )
        return;

    self.blockgoalpos = 1;
    var_3 = var_1.origin - var_0.origin;
    var_4 = ( var_3[0], var_3[1], 0 );
    var_5 = vectortoangles( var_4 );
    self scragentsetorientmode( "face angle abs", var_5 );
    self scragentsetanimmode( "anim deltas" );
    var_6 = self getanimentry( var_2, 0 );
    var_7 = getnotetracktimes( var_6, "code_move" );

    if ( var_7.size > 0 )
        var_8 = getmovedelta( var_6, 0, var_7[0] );
    else
        var_8 = getmovedelta( var_6, 0, 1 );

    var_9 = maps\mp\agents\_scriptedagents::getanimscalefactors( var_3, var_8 );
    self scragentsetphysicsmode( "noclip" );

    if ( var_3[2] > 0 )
    {
        if ( var_8[2] > 0 )
        {
            var_10 = getnotetracktimes( var_6, "traverse_jump_start" );

            if ( var_10.size > 0 )
            {
                var_11 = 1;
                var_12 = 1;

                if ( length2dsquared( var_4 ) < 0.64 * length2dsquared( var_8 ) )
                    var_11 = 0.4;

                if ( var_3[2] < 0.75 * var_8[2] )
                    var_12 = 0.5;

                self scragentsetanimscale( var_11, var_12 );
                maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_2, 0, "traverse", "traverse_jump_start" );
                var_13 = getnotetracktimes( var_6, "traverse_jump_end" );
                var_14 = getmovedelta( var_6, 0, var_10[0] );
                var_15 = getmovedelta( var_6, 0, var_13[0] );
                var_11 = 1;
                var_12 = 1;
                var_16 = var_1.origin - self.origin;
                var_17 = var_8 - var_14;

                if ( length2dsquared( var_16 ) < 0.5625 * length2dsquared( var_17 ) )
                    var_11 = 0.75;

                if ( var_16[2] < 0.75 * var_17[2] )
                    var_12 = 0.75;

                var_18 = var_8 - var_15;
                var_19 = ( var_18[0] * var_11, var_18[1] * var_11, var_18[2] * var_12 );
                var_20 = rotatevector( var_19, var_5 );
                var_21 = var_1.origin - var_20;
                var_22 = var_15 - var_14;
                var_23 = rotatevector( var_22, var_5 );
                var_24 = var_21 - self.origin;
                var_9 = maps\mp\agents\_scriptedagents::getanimscalefactors( var_24, var_23, 1 );
                self scragentsetanimscale( var_9._ID36478, var_9.z );
                maps\mp\agents\_scriptedagents::_ID35786( "traverse", "traverse_jump_end" );
                self scragentsetanimscale( var_11, var_12 );
                maps\mp\agents\_scriptedagents::_ID35786( "traverse", "code_move" );
                return;
            }

            self scragentsetanimscale( var_9._ID36478, var_9.z );
            maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_2, 0, "traverse" );
            return;
            return;
        }

        var_25 = getnotetracktimes( var_6, "gravity on" );

        if ( var_25.size > 0 )
        {
            var_26 = var_0 gettargetentpos();

            if ( isdefined( var_26 ) )
            {
                var_27 = var_26 - self.origin;
                var_28 = var_1.origin - var_26;
                var_29 = getmovedelta( var_6, 0, var_25[0] );
                var_9 = maps\mp\agents\_scriptedagents::getanimscalefactors( var_27, var_29 );
                self scragentsetanimscale( var_9._ID36478, var_9.z );
                maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_2, 0, "traverse", "gravity on" );
                var_30 = getmovedelta( var_6, var_25[0], 1 );
                var_9 = maps\mp\agents\_scriptedagents::getanimscalefactors( var_28, var_30 );
                self scragentsetanimscale( var_9._ID36478, var_9.z );
                maps\mp\agents\_scriptedagents::_ID35786( "traverse", "code_move" );
                return;
            }
        }

        var_31 = getanimlength( var_6 );
        self scragentdoanimlerp( var_0.origin, var_1.origin, var_31 );
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_2, 0, "traverse" );
        return;
        return;
    }

    var_25 = getnotetracktimes( var_6, "gravity on" );

    if ( var_25.size > 0 )
    {
        self scragentsetanimscale( var_9._ID36478, 1 );
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_2, 0, "traverse", "gravity on" );
        var_32 = getmovedelta( var_6, 0, var_25[0] );
        var_33 = var_32[2] - var_8[2];

        if ( abs( var_33 ) > 0 )
        {
            var_34 = self.origin[2] - var_1.origin[2];
            var_12 = var_34 / var_33;
            self scragentsetanimscale( var_9._ID36478, var_12 );
            var_35 = clamp( 2 / var_12, 0.5, 1 );
            var_36 = var_2 + "_norestart";
            self setanimstate( var_36, 0, var_35 );
        }

        maps\mp\agents\_scriptedagents::_ID35786( "traverse", "code_move" );
    }
    else
    {
        self scragentsetanimscale( var_9._ID36478, var_9.z );
        var_35 = clamp( 2 / var_9.z, 0.5, 1 );
        var_13 = getnotetracktimes( var_6, "traverse_jump_end" );

        if ( var_13.size > 0 )
        {
            maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( var_2, 0, var_35, "traverse", "traverse_jump_end" );
            var_36 = var_2 + "_norestart";
            self setanimstate( var_36, 0, 1 );
            maps\mp\agents\_scriptedagents::_ID35786( "traverse", "code_move" );
        }
        else
            maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_2, 0, "traverse" );
    }

    self scragentsetanimscale( 1, 1 );
    return;
}

end_script()
{
    self scragentsetanimscale( 1, 1 );
    self.blockgoalpos = 0;
}

gettargetentpos()
{
    if ( isdefined( self._ID32606 ) )
        return self._ID32606;

    var_0 = getent( self.target, "targetname" );

    if ( !isdefined( var_0 ) )
        return undefined;

    self._ID32606 = var_0.origin;
    var_0 delete();
    return self._ID32606;
}

_ID17927()
{
    level._ID10576 = [];
    level._ID10576["hjk_tree_hop"] = "traverse_jump_over_24";
    level._ID10576["jump_across_72"] = "traverse_jump_over_24";
    level._ID10576["wall_hop"] = "traverse_jump_over_36";
    level._ID10576["window_2"] = "traverse_jump_over_36";
    level._ID10576["wall_over_40"] = "traverse_jump_over_36";
    level._ID10576["wall_over"] = "traverse_jump_over_36";
    level._ID10576["window_divethrough_36"] = "traverse_jump_over_36";
    level._ID10576["window_over_40"] = "traverse_jump_over_36";
    level._ID10576["window_over_quick"] = "traverse_jump_over_36";
    level._ID10576["jump_up_80"] = "traverse_jump_up_70";
    level._ID10576["jump_standing_80"] = "traverse_jump_up_70";
    level._ID10576["jump_down_80"] = "traverse_jump_down_70";
    level._ID10576["jump_up_40"] = "traverse_jump_up_40";
    level._ID10576["jump_down_40"] = "traverse_jump_down_40";
    level._ID10576["step_up"] = "traverse_jump_up_24";
    level._ID10576["step_up_24"] = "traverse_jump_up_24";
    level._ID10576["step_down"] = "traverse_jump_down_24";
    level._ID10576["jump_down"] = "traverse_jump_down_24";
    level._ID10576["jump_across"] = "traverse_jump_over_36";
    level._ID10576["jump_across_100"] = "traverse_jump_over_36";
}
