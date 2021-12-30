// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    self endon( "killanimscript" );
    self.blockgoalpos = 1;
    var_0 = self getnegotiationstartnode();
    var_1 = self getnegotiationendnode();

    if ( var_0.type == "Jump" || var_0.type == "Jump Attack" )
    {
        var_2 = self getnegotiationnextnode();

        if ( isdefined( var_0.target ) && isdefined( var_1.targetname ) && var_0.target == var_1.targetname )
        {
            self._ID33502 = "canned";
            _ID10783( var_0, var_1 );
            return;
        }

        var_3 = _ID12891( var_1 );

        if ( isdefined( var_3 ) )
        {
            self._ID33502 = "jump_attack";
            self._ID19777 = var_1.origin;
            maps\mp\agents\alien\_alien_melee::_ID20848( var_3 );
            return;
        }

        self._ID33502 = "jump";
        _ID18995( var_0, var_1, var_2 );
        return;
        return;
    }

    self._ID33502 = "canned";
    _ID10783( var_0, var_1 );
    return;
}

_ID12891( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID14264() == "spitter" || maps\mp\alien\_unk1464::_ID14264() == "seeder" )
        return undefined;

    var_1 = 16384;
    var_2 = 0.707;

    foreach ( var_4 in level.players )
    {
        if ( distancesquared( var_4.origin, var_0.origin ) > var_1 )
            continue;

        var_5 = vectornormalize( var_0.origin - var_4.origin );
        var_6 = anglestoforward( var_4.angles );
        var_7 = vectordot( var_5, var_6 );

        if ( var_7 > var_2 )
            return var_4;
    }

    return undefined;
}

end_script()
{
    self.blockgoalpos = 0;

    if ( self._ID33502 == "jump" )
        self._ID24939 = "traverse_jump";
    else if ( self._ID33502 == "jump_attack" )
        self._ID24939 = "traverse_jump_attack";
    else
        self._ID24939 = "traverse_canned";

    self._ID33502 = undefined;
}

_ID18995( var_0, var_1, var_2 )
{
    var_3 = undefined;

    if ( isdefined( var_2 ) )
        var_3 = var_2.origin;

    if ( isdefined( level.dlc_alien_jump_override ) )
    {
        [[ level.dlc_alien_jump_override ]]( var_0, var_1, var_2, var_3 );
        return;
    }

    maps\mp\agents\alien\_alien_jump::_ID18995( var_0.origin, var_0.angles, var_1.origin, var_1.angles, var_3, undefined, var_1.script_noteworthy );
}

_ID10783( var_0, var_1 )
{
    var_2 = level.alienanimdata.cannedtraverseanims[var_0.animscript];
    var_3 = var_2["animState"];
    self.startnode = var_0;
    self._ID11740 = var_1;
    self scragentsetphysicsmode( "noclip" );
    self scragentsetorientmode( "face angle abs", var_0.angles );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetanimscale( 1.0, 1.0 );

    if ( isdefined( var_2["traverseSound"] ) )
        thread maps\mp\_utility::_ID23845( var_2["traverseSound"] );

    if ( isdefined( var_2["traverseAnimScale"] ) )
        self scragentsetanimscale( var_2["traverseAnimScale"], var_2["traverseAnimScale"] );

    switch ( var_3 )
    {
        case "traverse_climb_up":
            alienclimbup( var_0, var_1, "traverse_climb_up", self getanimentry( "traverse_climb_up", 4 ) );
            break;
        case "traverse_climb_up_over_56":
            alienclimbup( var_0, var_1, "traverse_climb_up_over_56" );
            break;
        case "traverse_climb_up_ledge_18_run":
            alienclimbup( var_0, var_1, "traverse_climb_up_ledge_18_run" );
            break;
        case "traverse_climb_up_ledge_18_idle":
            alienclimbup( var_0, var_1, "traverse_climb_up_ledge_18_idle" );
            break;
        case "climb_up_end_jump_side_l":
            alienclimbup( var_0, var_1, "climb_up_end_jump_side_l" );
            break;
        case "climb_up_end_jump_side_r":
            alienclimbup( var_0, var_1, "climb_up_end_jump_side_r" );
            break;
        case "traverse_climb_down":
            alienclimbdown( var_0, var_1, "traverse_climb_down" );
            break;
        case "traverse_climb_over_56_down":
            alienclimbdown( var_0, var_1, "traverse_climb_over_56_down" );
            break;
        case "run":
            _ID36702( var_0, var_1, "run" );
            break;
        default:
            alienregulartraversal( var_0, var_3, var_2["animIndexArray"], var_2["endInOriented"], var_2["flexHeightEndAtTraverseEnd"] );
            break;
    }

    self.startnode = undefined;
    self._ID11740 = undefined;
    self scragentsetanimscale( 1, 1 );
}

alienregulartraversal( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = var_2[randomint( var_2.size )];
    var_6 = self getanimentry( var_1, var_5 );
    var_7 = needflexibleheightsupport( var_6 );
    var_8 = getanimlength( var_6 );
    _ID33487( var_6, var_0 );

    if ( animhasnotetrack( var_6, "highest_point" ) )
        self.apextraversaldeathvector = vectornormalize( self.startnode.origin - self._ID11740.origin );

    var_9 = getent( var_0.target, "targetname" );

    if ( isdefined( var_9 ) )
        var_9 thread _ID27048( var_8 );

    if ( var_7._ID21900 )
        _ID10782( var_1, var_5, var_6, var_7._ID31335, var_7._ID11565, var_4, ::alientraversenotetrackhandler );
    else
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_1, var_5, "canned_traverse", "end", ::alientraversenotetrackhandler );

    _ID11751( var_3 );
}

_ID27048( var_0 )
{
    self notify( "stop_previous_traversal" );
    self endon( "stop_previous_traversal" );
    self setscriptablepartstate( 0, 1 );
    wait(var_0);
    self setscriptablepartstate( 0, 0 );
}

_ID11751( var_0 )
{
    if ( var_0 )
    {
        self scragentsetphysicsmode( "noclip" );
        self.oriented = 1;
        self.ignoreme = 1;
        return;
    }

    self scragentsetphysicsmode( "gravity" );
    self.oriented = 0;
    self.ignoreme = 0;
    return;
}

needflexibleheightsupport( var_0 )
{
    var_1 = spawnstruct();

    if ( animhasnotetrack( var_0, "traverse_up" ) )
    {
        var_1._ID21900 = 1;
        var_1._ID31335 = "traverse_up";
        var_1._ID11565 = "traverse_up_end";
        return var_1;
    }

    if ( animhasnotetrack( var_0, "traverse_drop" ) )
    {
        var_1._ID21900 = 1;
        var_1._ID31335 = "traverse_drop";
        var_1._ID11565 = "traverse_drop_end";
        return var_1;
    }

    var_1._ID21900 = 0;
    return var_1;
}

_ID10782( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = "canned_traverse";
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_0, var_1, var_7, var_3, var_6 );

    if ( var_5 )
    {
        var_8 = self._ID11740.origin;
        var_9 = 1;
    }
    else
    {
        var_8 = common_scripts\utility::_ID15384( self._ID11740.target, "targetname" );
        var_8 = var_8.origin;
        var_10 = getnotetracktimes( var_2, "highest_point" );
        var_9 = var_10[0];
    }

    dotraversalwithflexibleheight_internal( var_0, var_1, var_7, var_2, var_3, var_4, var_8, var_9, var_6 );
}

dotraversalwithflexibleheight_internal( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = abs( self.origin[2] - var_6[2] );
    var_10 = getnotetracktimes( var_3, var_4 );
    var_11 = var_10[0];
    var_12 = getnotetracktimes( var_3, var_5 );
    var_13 = var_12[0];
    var_14 = getmovedelta( var_3, var_11, var_7 );
    var_15 = abs( var_14[2] );
    var_16 = getmovedelta( var_3, var_11, var_13 );
    var_17 = abs( var_16[2] );
    var_18 = var_15 - var_17;

    if ( var_9 <= var_18 )
        var_19 = 1;
    else
        var_19 = ( var_9 - var_18 ) / var_17;

    var_20 = 1 / var_19;
    self scragentsetanimscale( 1.0, var_19 );
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( var_0, var_1, var_20, var_2, var_5, var_8 );
    self scragentsetanimscale( 1.0, 1.0 );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_0, var_1, var_2, "end", var_8 );
    self.apextraversaldeathvector = undefined;
}

alientraversenotetrackhandler( var_0, var_1, var_2, var_3 )
{
    switch ( var_0 )
    {
        case "apply_physics":
            self scragentsetphysicsmode( "gravity" );
            break;
        case "highest_point":
            if ( isdefined( self.apextraversaldeathvector ) )
                self.apextraversaldeathvector = self.apextraversaldeathvector * -1;

            break;
        default:
            break;
    }
}

alienclimbup( var_0, var_1, var_2, var_3 )
{
    var_4 = self getanimentry( var_2, 0 );
    var_5 = self getanimentry( var_2, 1 );
    var_6 = self getanimentry( var_2, 2 );
    var_7 = self getanimentry( var_2, 3 );
    var_8 = var_1.origin[2] - var_0.origin[2];
    var_9 = getmovedelta( var_4, 0, 1 )[2];
    var_10 = getmovedelta( var_5, 0, 1 )[2];
    var_11 = getmovedelta( var_6, 0, 1 )[2];
    var_12 = getmovedelta( var_7, 0, 1 )[2];
    var_13 = undefined;
    var_14 = getnotetracktimes( var_4, "climb_up_teleport" )[0];
    var_15 = getmovedelta( var_4, 0, var_14 );
    var_16 = getmovedelta( var_4, var_14, 1 );
    var_17 = var_16[2];

    if ( var_8 < var_9 + var_12 )
    {

    }

    var_18 = var_8 - var_9 + var_12;
    var_19 = 0;
    var_20 = 0;

    if ( var_18 > 0 )
    {
        var_19 = var_18 - var_10 > 0;
        var_20 = max( 0, floor( ( var_18 - var_19 * var_10 ) / var_11 ) );
    }

    var_21 = var_19 * var_10 + var_20 * var_11 + var_17;
    var_22 = var_8 - var_12 - ( var_9 - var_17 );
    var_23 = var_22 / var_21;
    var_24 = 0;

    if ( isdefined( var_3 ) )
    {
        var_13 = getmovedelta( var_3, 0, 1 )[2];
        var_25 = var_13 - var_12;
        var_24 = var_22 - var_21 > var_25;
        var_23 = ( var_22 - var_24 * var_25 ) / var_21;
    }

    var_26 = var_7;

    if ( var_24 )
        var_26 = var_3;

    var_27 = getnotetracktimes( var_26, "stop_teleport" )[0];
    var_28 = getmovedelta( var_26, 0, var_27 )[2];
    var_29 = getmovedelta( var_26, var_27, 1 );
    var_30 = length( var_29 * ( 1, 1, 0 ) );
    self scragentsetanimscale( 1, 1 );
    _ID33490( var_4, var_0 );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_2, 0, "canned_traverse", "climb_up_teleport" );
    self scragentsetanimscale( 1, var_23 );
    maps\mp\agents\_scriptedagents::_ID35786( "canned_traverse", "end" );
    self scragentsetanimscale( 1, var_23 );

    if ( var_19 )
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_2, 1, "canned_traverse", "finish" );

    for ( var_31 = 0; var_31 < var_20; var_31++ )
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_2, 2, "canned_traverse", "end" );

    var_32 = var_1.origin[2] - self.origin[2] - var_29[2];
    var_23 = 1.0;

    if ( var_32 > var_28 )
        var_23 = var_32 / var_28;

    self scragentsetanimscale( 1, var_23 );

    if ( var_24 )
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_2, 4, "canned_traverse", "stop_teleport", ::alientraversenotetrackhandler );
    else
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_2, 3, "canned_traverse", "stop_teleport", ::alientraversenotetrackhandler );

    var_33 = distance2d( self.origin, var_1.origin );
    var_34 = var_33 / var_30;
    self scragentsetanimscale( var_34, 1 );
    maps\mp\agents\_scriptedagents::_ID35786( "canned_traverse", "end" );
}

alienclimbdown( var_0, var_1, var_2 )
{
    var_3 = self getanimentry( var_2, 0 );
    var_4 = self getanimentry( var_2, 1 );
    var_5 = self getanimentry( var_2, 2 );
    var_6 = self getanimentry( var_2, 3 );
    var_7 = self getanimentry( var_2, 4 );
    var_8 = var_0.origin[2] - var_1.origin[2];
    var_9 = -1 * getmovedelta( var_3, 0, 1 )[2];
    var_10 = -1 * getmovedelta( var_5, 0, 1 )[2];
    var_11 = -1 * getmovedelta( var_4, 0, 1 )[2];
    var_12 = -1 * getmovedelta( var_6, 0, 1 )[2];
    var_13 = -1 * getmovedelta( var_7, 0, 1 )[2];

    if ( var_8 < var_9 + var_12 )
    {

    }

    var_14 = var_6;
    var_15 = var_12;
    var_16 = 0;

    if ( candojumpforend( var_0, var_1, var_3, var_7 ) )
    {
        var_14 = var_7;
        var_15 = var_13;
        var_16 = 1;
    }

    var_17 = var_8 - var_9 + var_15;
    var_18 = 0;
    var_19 = 0;

    if ( var_17 > 0 )
    {
        var_18 = var_17 - var_10 > 0;
        var_19 = max( 0, floor( ( var_17 - var_18 * var_10 ) / var_11 ) );
    }

    self scragentsetanimscale( 1, 1 );
    _ID33489( var_3, var_0 );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_2, 0, "canned_traverse", "end" );
    var_20 = var_18 * var_10 + var_19 * var_11;

    if ( var_20 > 0 )
    {
        var_21 = abs( var_17 / var_20 );
        self scragentsetanimscale( 1, var_21 );
    }

    for ( var_22 = 0; var_22 < var_19; var_22++ )
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "traverse_climb_down_loop", 0, "traverse_climb_down_loop", "end" );

    if ( var_18 )
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "traverse_climb_down_slide", 0, "traverse_climb_down_slide", "end" );

    var_23 = getnotetracktimes( var_14, "climb_down_teleport" )[0];
    var_24 = getnotetracktimes( var_14, "stop_teleport" )[0];
    var_25 = -1 * getmovedelta( var_14, var_23, var_24 )[2];
    var_26 = abs( self.origin[2] - var_1.origin[2] - abs( getmovedelta( var_14, var_24, 1 )[2] ) );
    var_21 = var_26 / var_25;
    self scragentsetanimscale( 1, var_21 );

    if ( var_16 )
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_2, 4, "canned_traverse", "stop_teleport" );
    else
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_2, 3, "canned_traverse", "stop_teleport" );

    self scragentsetanimscale( 1, 1 );
    self scragentsetphysicsmode( "gravity" );
    maps\mp\agents\_scriptedagents::_ID35786( "canned_traverse", "end" );
}

_ID33487( var_0, var_1 )
{
    var_2 = maps\mp\agents\alien\_alien_anim_utils::getlerptime( var_0 );
    var_3 = maps\mp\agents\alien\_alien_anim_utils::_ID15263( var_0, var_1.origin, var_1.angles, var_2 );
    thread maps\mp\agents\alien\_alien_anim_utils::dolerp( var_3, var_2 );
}

_ID33489( var_0, var_1 )
{
    var_2 = -30;
    var_3 = 60;
    dotraverseclimblerp( var_0, var_1, var_2, var_3, 1 );
}

_ID33490( var_0, var_1 )
{
    var_2 = 0;
    var_3 = 50;
    dotraverseclimblerp( var_0, var_1, var_2, var_3, 0 );
}

dotraverseclimblerp( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = maps\mp\agents\alien\_alien_anim_utils::getlerptime( var_0 );
    var_6 = maps\mp\agents\alien\_alien_anim_utils::_ID15263( var_0, var_1.origin, var_1.angles, var_5 );

    if ( var_4 )
        var_7 = ( var_6 - var_1.origin ) * ( 1, 1, 0 );
    else
        var_7 = ( var_1.origin - var_6 ) * ( 1, 1, 0 );

    var_8 = vectornormalize( var_7 );
    var_8 *= var_3;
    var_9 = maps\mp\agents\alien\_alien_anim_utils::_ID15263( var_0, var_1.origin, var_1.angles, getanimlength( var_0 ) );
    var_10 = aligntoverticaledge( var_9, var_2, var_8 );
    var_11 = var_10 - var_9;
    var_6 += var_11;
    thread maps\mp\agents\alien\_alien_anim_utils::dolerp( var_6, var_5 );
}

aligntoverticaledge( var_0, var_1, var_2 )
{
    var_3 = 3.0;
    var_0 += var_2;
    var_0 += ( 0, 0, var_1 );
    var_4 = var_0 - var_2 * var_3;
    var_5 = bullettrace( var_0, var_4, 0 );
    var_0 = var_5["position"];
    var_0 += ( 0, 0, -1 * var_1 );
    return var_0;
}

candojumpforend( var_0, var_1, var_2, var_3 )
{
    var_4 = 10;
    var_5 = ( 0, 0, 10 );
    var_6 = 5;
    var_7 = self.height;
    var_8 = getmovedelta( var_2, 0, 1 );
    var_9 = length2d( var_8 );
    var_10 = var_8[2] * -1;
    var_11 = getmovedelta( var_3, 0, 1 );
    var_12 = length2d( var_11 );
    var_13 = var_11[2] * -1;
    var_14 = vectornormalize( ( var_1.origin - var_0.origin ) * ( 1, 1, 0 ) );
    var_15 = var_0.origin + var_14 * var_9 - ( 0, 0, var_10 );
    var_16 = physicstrace( var_15, var_15 + ( 0, 0, -2000 ) );
    var_17 = var_15 - var_16[2];

    if ( var_17 < var_13 )
        return 0;

    var_18 = var_16 + ( 0, 0, var_13 );
    var_19 = var_16 + var_14 * var_12;
    var_20 = var_18 + var_14 * var_4;
    var_21 = var_19 + var_5;
    return self aiphysicstracepassed( var_20, var_21, var_6, var_7, 0 );
}

_ID36702( var_0, var_1, var_2 )
{
    self.oriented = 1;
    var_3 = var_1.origin - var_0.origin;
    var_4 = anglestoup( var_1.angles );
    var_5 = vectornormalize( var_3 );
    var_6 = vectorcross( var_4, var_5 );
    var_5 = vectorcross( var_6, var_4 );
    var_7 = ( 0, 0, 0 ) - var_6;
    var_8 = axistoangles( var_5, var_7, var_4 );
    self scragentsetorientmode( "face angle abs", var_8 );
    var_9 = self getanimentry( var_2, 0 );
    var_10 = getanimlength( var_9 );
    var_11 = getmovedelta( var_9 );
    var_12 = length( var_11 );
    var_13 = length( var_1.origin - self.origin );
    var_14 = var_10 * var_13 / var_12;
    self scragentdoanimlerp( self.origin, var_1.origin, var_14 );
    self setanimstate( var_2, 0 );
    wait(var_14);
    alienwallrun_waitforangles( var_8 );
}

alienwallrun_anglesalmostequal( var_0, var_1, var_2 )
{
    if ( abs( angleclamp180( var_1[0] - var_0[0] ) > var_2 ) )
        return 0;

    if ( abs( angleclamp180( var_1[1] - var_0[1] ) > var_2 ) )
        return 0;

    if ( abs( angleclamp180( var_1[2] - var_0[2] ) > var_2 ) )
        return 0;

    return 1;
}

alienwallrun_waitforangles( var_0 )
{
    var_1 = 360;

    for ( var_2 = 0.5; var_2 > 0; var_2 -= 0.05 )
    {
        if ( alienwallrun_anglesalmostequal( self.angles, var_0, 1 ) )
            break;

        var_3 = anglesdelta( var_0, self.angles );

        if ( var_3 < 5 || var_3 >= var_1 )
            break;

        var_1 = var_3;
        wait 0.05;
    }
}
