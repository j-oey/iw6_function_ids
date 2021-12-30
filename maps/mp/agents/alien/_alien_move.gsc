// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    self endon( "killanimscript" );
    entermove();
    _ID31459();
    continuemovement();
}

entermove()
{
    self.blockgoalpos = 0;
    self._ID24606 = 0;
    self scragentsetphysicsmode( "gravity" );
    self scragentsetanimmode( "code_move" );
}

_ID31459()
{
    if ( candostartmove() )
    {
        switch ( _ID15368() )
        {
            case "run-start":
                _ID10762();
                break;
            case "walk-start":
                _ID10798();
                break;
            case "leap-to-run":
                _ID10598();
                break;
            default:
                break;
        }

        return;
    }
}

end_script()
{
    self.blockgoalpos = 0;
    self._ID24606 = 0;
    _ID6559( undefined );
    self scragentsetanimscale( 1, 1 );
    self._ID24939 = "move";
}

setupmovement()
{
    self.enablestop = 1;
    thread waitformovemodechange();
    thread _ID35558();
    thread _ID35571();
    thread _ID35576();
    thread waitforstuck();

    if ( candodge() )
    {
        thread _ID35561();
        thread _ID35552();
        return;
    }
}

continuemovement()
{
    setupmovement();

    if ( self.oriented )
    {
        var_0 = self getlookaheaddir();
        var_1 = anglestoup( self.angles );
        var_2 = vectorcross( var_1, var_0 );
        var_0 = vectorcross( var_2, var_1 );
        var_3 = ( 0, 0, 0 ) - var_2;
        var_4 = axistoangles( var_0, var_3, var_1 );
        self scragentsetorientmode( "face angle abs", var_4 );
        self scragentsetanimmode( "code_move_slide" );
    }
    else
    {
        self scragentsetorientmode( "face motion" );
        self scragentsetanimmode( "code_move" );
    }

    self scragentsetanimscale( self._ID36479, 1.0 );
    _ID28789( self.movemode );
}

waitformovemodechange()
{
    self endon( "killanimscript" );
    self endon( "alienmove_endwait_runwalk" );
    var_0 = self.movemode;

    for (;;)
    {
        if ( var_0 != self.movemode )
        {
            _ID28789( self.movemode );
            var_0 = self.movemode;
        }

        wait 0.1;
    }
}

_ID35571()
{
    self endon( "killanimscript" );
    self endon( "alienmove_endwait_sharpturn" );
    self waittill( "path_dir_change",  var_0  );
    var_1 = maps\mp\agents\_scriptedagents::_ID14876( var_0 );

    if ( var_1 == 4 )
    {
        thread _ID35571();
        return;
    }

    var_2 = !_ID29812();

    if ( var_2 )
        var_1 = 0;

    var_3 = "run_turn";
    var_4 = self getanimentry( var_3, var_1 );
    var_5 = var_2 || candoturnanim( var_4 );

    if ( !var_5 )
    {
        thread _ID35571();
        return;
    }

    _ID6559( "sharpturn" );
    self.blockgoalpos = 1;
    self.enablestop = 0;

    if ( var_2 )
        maps\mp\agents\alien\_alien_anim_utils::_ID33987( self getlookaheaddir() );

    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( var_3, var_1, self.moveplaybackrate, var_3, "code_move" );
    self scragentsetorientmode( "face motion" );
    self.blockgoalpos = 0;
    continuemovement();
}

_ID35576()
{
    self endon( "killanimscript" );
    self endon( "alienmove_endwait_stop" );
    self waittill( "stop_soon" );

    if ( !shoulddostopanim() || self.movemode == "walk" )
    {
        thread _ID35576();
        return;
    }

    var_0 = self getpathgoalpos();

    if ( !isdefined( var_0 ) )
    {
        thread _ID35576();
        return;
    }

    var_1 = var_0 - self.origin;
    var_2 = _ID15381( var_0 );
    var_3 = _ID15379();

    if ( _ID29828() )
        var_4 = 0;
    else
        var_4 = getstopanimindex( var_3, var_2 );

    var_5 = self getanimentry( var_3, var_4 );
    var_6 = getmovedelta( var_5 );
    var_7 = getangledelta( var_5 );

    if ( length( var_1 ) + 48 < length( var_6 ) )
    {
        thread _ID35576();
        return;
    }

    var_8 = getstopdata( var_0 );
    var_9 = calcanimstartpos( var_8._ID24745, var_8.angles[1], var_6, var_7 );
    var_10 = maps\mp\agents\_scriptedagents::droppostoground( var_9 );

    if ( !isdefined( var_10 ) )
    {
        thread _ID35576();
        return;
    }

    if ( !maps\mp\agents\_scriptedagents::canmovepointtopoint( var_8._ID24745, var_10 ) )
    {
        thread _ID35576();
        return;
    }

    _ID6559( "stop", "sharpturn" );
    thread _ID35563( "alienmove_endwait_pathsetwhilestopping", "alienmove_endwait_stop" );
    var_11 = maps\mp\agents\_scriptedagents::getanimscalefactors( var_0 - self.origin, var_6 );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", vectortoangles( var_1 ) );
    self scragentsetanimscale( var_11._ID36478, var_11.z );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_3, var_4, var_3, "end" );
    self scragentsetanimscale( 1.0, 1.0 );

    if ( _ID29828() )
        maps\mp\agents\alien\_alien_anim_utils::_ID33987( self getlookaheaddir() );

    var_0 = self getpathgoalpos();

    if ( distancesquared( self.origin, var_0 ) < 400.0 )
    {
        self scragentsetanimmode( "code_move_slide" );
        self setanimstate( "idle" );
        return;
        return;
    }

    _ID31459();
    continuemovement();
    return;
}

_ID15381( var_0 )
{
    if ( isdefined( self.enemy ) )
        return self.enemy.origin - var_0;

    return var_0 - self.origin;
}

_ID15379()
{
    switch ( self.movemode )
    {
        case "run":
        case "jog":
            return "run_stop";
        case "walk":
            return "walk_stop";
    }

    endswitch( 4 )  case "jog" loc_435 case "run" loc_435 case "walk" loc_43B default loc_441
}

getstopanimindex( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "walk_stop":
            return 0;
        case "run_stop":
            return maps\mp\agents\_scriptedagents::_ID14876( var_1 );
    }
}

_ID35563( var_0, var_1 )
{
    self endon( "killanimscript" );
    self endon( var_0 );
    var_2 = self scragentgetgoalpos();
    self waittill( "path_set" );
    var_3 = self scragentgetgoalpos();

    if ( distancesquared( var_2, var_3 ) < 1 )
    {
        thread _ID35563( var_0, var_1 );
        return;
    }

    self notify( var_1 );
    continuemovement();
}

_ID35558()
{
    self endon( "killanimscript" );
    self endon( "alienmove_endwait_jumpsoon" );
    self waittill( "traverse_soon" );
    _ID6559( "jumpsoon" );
    var_0 = self getnegotiationstartnode();
    var_1 = self getnegotiationendnode();
    var_2 = var_1.origin - var_0.origin;
    var_3 = maps\mp\agents\_scriptedagents::_ID14876( var_1.origin - var_0.origin );

    if ( !_ID29864( var_0, var_3 ) )
    {
        continuemovement();
        return;
    }

    var_4 = "jump_launch_arrival";
    var_5 = self getanimentry( var_4, var_3 );
    var_6 = getmovedelta( var_5 );
    var_7 = getangledelta( var_5 );

    if ( !maps\mp\agents\_scriptedagents::canmovepointtopoint( self.origin, var_0.origin ) && !self.oriented )
    {
        continuemovement();
        return;
    }

    thread _ID35563( "alienmove_endwait_pathsetwhilejumping", "alienmove_endwait_jumpsoon" );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    var_8 = maps\mp\agents\_scriptedagents::getanimscalefactors( var_0.origin - self.origin, var_6 );
    self scragentsetanimscale( var_8._ID36478, var_8.z );
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( var_4, var_3, self.moveplaybackrate, "jump_launch_arrival", "anim_will_finish" );
    var_9 = var_2;
    var_10 = anglestoup( self.angles );
    var_11 = vectorcross( var_10, var_9 );
    var_9 = vectorcross( var_11, var_10 );
    var_12 = ( 0, 0, 0 ) - var_11;
    var_13 = axistoangles( var_9, var_12, var_10 );
    self scragentsetorientmode( "face angle abs", var_13 );
    self scragentsetanimscale( 1.0, 1.0 );
    var_0 = self getnegotiationstartnode();

    if ( isdefined( var_0 ) && distancesquared( self.origin, var_0.origin ) < 400.0 || self.oriented )
    {
        self scragentsetanimmode( "code_move_slide" );
        return;
    }

    continuemovement();
    return;
}

_ID28789( var_0 )
{
    if ( var_0 == "run" )
    {
        var_1 = self getanimentrycount( "run" );
        var_2 = [ 20, 80 ];
        var_3 = maps\mp\alien\_unk1464::getrandomindex( var_2 );
        self setanimstate( "run", var_3, self.moveplaybackrate );
        return;
    }

    if ( var_0 == "jog" )
    {
        self setanimstate( "jog", undefined, self.moveplaybackrate );
        return;
    }

    if ( var_0 == "walk" )
    {
        self setanimstate( "walk", undefined, self.moveplaybackrate );
        return;
    }

    return;
    return;
    return;
}

_ID6559( var_0, var_1 )
{
    var_2 = [ "runwalk", "sharpturn", "stop", "pathsetwhilestopping", "jumpsoon", "pathsetwhilejumping", "pathset", "nearmiss", "dodgechance", "stuck" ];
    var_3 = isdefined( var_0 );
    var_4 = isdefined( var_1 );

    foreach ( var_6 in var_2 )
    {
        if ( var_3 && var_6 == var_0 )
            continue;

        if ( var_4 && var_6 == var_1 )
            continue;

        self notify( "alienmove_endwait_" + var_6 );
    }
}

getstopdata( var_0 )
{
    var_1 = spawnstruct();

    if ( isdefined( self.node ) )
    {
        var_1._ID24745 = self.node.origin;
        var_1.angles = self.node.angles;
    }
    else if ( isdefined( self.enemy ) )
    {
        var_1._ID24745 = var_0;
        var_1.angles = vectortoangles( self.enemy.origin - var_0 );
    }
    else
    {
        var_1._ID24745 = var_0;
        var_1.angles = self.angles;
    }

    return var_1;
}

calcanimstartpos( var_0, var_1, var_2, var_3 )
{
    var_4 = var_1 - var_3;
    var_5 = ( 0, var_4, 0 );
    var_6 = anglestoforward( var_5 );
    var_7 = anglestoright( var_5 );
    var_8 = var_6 * var_2[0];
    var_9 = var_7 * var_2[1];
    return var_0 - var_8 + var_9;
}

_ID22843()
{
    dostumble();
}

_ID22790( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( isdefined( level.dlc_can_do_pain_override_func ) )
    {
        var_10 = [[ level.dlc_can_do_pain_override_func ]]( "move" );

        if ( !var_10 )
            return;
    }

    if ( maps\mp\alien\_unk1464::_ID18462( var_1, var_4 ) )
    {
        dostumble( var_3, var_7, var_8, var_2, var_4, var_1 );
        return;
    }
}

dostumble( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "killanimscript" );

    if ( self._ID24606 )
        return;

    _ID6559( undefined );
    self.statelocked = 1;
    self._ID24606 = 1;
    var_6 = var_0 & level._ID17348;

    if ( var_4 == "MOD_MELEE" || var_6 )
    {
        var_7 = "pain_pushback";
        var_8 = maps\mp\agents\alien\_alien_anim_utils::_ID15226( "push_back", var_1 );
        var_9 = "pain_pushback";
    }
    else
    {
        var_7 = maps\mp\agents\alien\_alien_anim_utils::_ID15227( "run_stumble", var_3, var_6 );
        var_8 = maps\mp\agents\alien\_alien_anim_utils::_ID15226( "run", var_1, var_2 );
        var_9 = "run_stumble";
    }

    var_10 = self getanimentry( var_7, var_8 );
    maps\mp\alien\_unk1464::always_play_pain_sound( var_10 );
    maps\mp\alien\_unk1464::_ID25692( var_10 );
    self scragentsetorientmode( "face angle abs", self.angles );
    self scragentsetanimmode( "anim deltas" );
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( var_7, var_8, self.moveplaybackrate, var_9, "code_move" );
    self._ID24606 = 0;
    self.statelocked = 0;

    if ( _ID29896() )
        _ID31459();

    continuemovement();
}

_ID35561( var_0 )
{
    self endon( "killanimscript" );
    self endon( "alienmove_endwait_nearmiss" );
    var_1 = 0.5;

    for (;;)
    {
        common_scripts\utility::_ID35626( "bulletwhizby", "damage" );

        if ( randomfloat( 1.0 ) < var_1 )
            continue;

        if ( !self._ID24606 )
            _ID10348();
    }
}

_ID35552()
{
    self endon( "killanimscript" );
    self endon( "alienmove_endwait_dodgechance" );
    var_0 = 0.0;
    var_1 = randomintrange( 1000, 2000 );
    var_2 = gettime();

    for (;;)
    {
        wait 0.1;

        if ( isalive( self.enemy ) )
        {
            var_3 = gettime();
            var_4 = vectornormalize( self.origin - self.enemy.origin );
            var_5 = anglestoforward( self.enemy.angles );

            if ( vectordot( var_4, var_5 ) < 0.985 )
            {
                var_0 = 0.0;
                continue;
            }

            var_0 += var_3 - var_2;

            if ( distancesquared( self.origin, self.enemy.origin ) > 640000.0 )
                continue;

            var_6 = var_4 * -1.0;
            var_7 = anglestoforward( self.angles );

            if ( vectordot( var_6, var_7 ) < 0.766 )
                continue;

            if ( var_0 >= var_1 && !self._ID24606 )
            {
                _ID10348( "dodgechance" );
                var_0 = 0.0;
                var_1 = randomintrange( 1000, 2000 );
            }

            var_2 = var_3;
        }
    }
}

candodge()
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "elite":
        case "spitter":
        case "mammoth":
        case "seeder":
            return 0;
        default:
            return 1;
    }
}

_ID10348( var_0 )
{
    self endon( "killanimscript" );
    var_1 = 1000;

    if ( isdefined( self.last_dodge_time ) && gettime() - self.last_dodge_time < var_1 )
        return;

    if ( isalive( self.enemy ) && distancesquared( self.origin, self.enemy.origin ) < 65536.0 )
        return;

    var_2 = _ID14696();

    if ( common_scripts\utility::_ID7657() )
    {
        if ( !_ID33787( var_2 + "_left", var_0 ) )
        {
            _ID33787( var_2 + "_right", var_0 );
            return;
        }

        return;
    }

    if ( !_ID33787( var_2 + "_right", var_0 ) )
    {
        _ID33787( var_2 + "_left", var_0 );
        return;
    }

    return;
}

_ID14696()
{
    switch ( self.movemode )
    {
        case "jog":
            return "jog_dodge";
        default:
            return "run_dodge";
    }
}

_ID33787( var_0, var_1 )
{
    var_2 = 0.5;
    var_3 = maps\mp\agents\_scriptedagents::getrandomanimentry( var_0 );
    var_4 = self getanimentry( var_0, var_3 );
    var_5 = maps\mp\agents\_scriptedagents::_ID15326( var_4 );
    var_5 = min( var_5, self._ID36479 );

    if ( var_5 < var_2 )
        return 0;

    self.last_dodge_time = gettime();
    _ID6559( var_1 );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    self scragentsetanimscale( var_5, 1.0 );
    maps\mp\agents\_scriptedagents::_ID23883( var_0, var_0, "end" );
    self scragentsetanimscale( 1, 1 );
    continuemovement();
    return 1;
}

waitforstuck()
{
    self endon( "killanimscript" );
    self endon( "alienmove_endwait_stuck" );
    var_0 = 2000.0;
    var_1 = gettime() + var_0;
    var_2 = self.origin;
    var_3 = 1.0;

    for (;;)
    {
        var_4 = gettime();
        var_5 = length( self.origin - var_2 );

        if ( var_5 > var_3 )
            var_1 = var_4 + var_0;

        if ( var_1 <= var_4 )
        {
            _ID32016();
            var_1 = var_4 + var_0;
            break;
        }

        var_2 = self.origin;
        wait 0.1;
    }

    continuemovement();
}

_ID32016()
{
    self endon( "killanimscript" );
    self endon( "alienmove_endwait_stuck" );
    self endon( "death" );
    var_0 = 0.2;
    _ID6559( "stuck" );
    var_1 = self getanimentry();
    var_2 = getanimlength( var_1 );
    var_3 = length( getmovedelta( var_1 ) );
    var_4 = var_0 / var_2 * var_3;
    var_5 = self getlookaheaddir();
    var_6 = self.origin + var_5 * var_4;
    self scragentsetphysicsmode( "noclip" );
    self scragentsetorientmode( "face angle abs", vectortoangles( var_5 ) );
    self scragentdoanimlerp( self.origin, var_6, var_0 );
    wait(var_0);
    self setorigin( self.origin );
}

_ID10798()
{
    var_0 = "walk_start";
    var_1 = maps\mp\agents\_scriptedagents::getrandomanimentry( var_0 );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    self.blockgoalpos = 1;
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( var_0, var_1, self.moveplaybackrate, var_0, "code_move" );
    self scragentsetorientmode( "face motion" );
    self.blockgoalpos = 0;
}

_ID10762()
{
    var_0 = self getnegotiationstartnode();

    if ( isdefined( var_0 ) )
        var_1 = var_0.origin;
    else
        var_1 = self getpathgoalpos();

    if ( !isdefined( var_1 ) )
        return;

    if ( distancesquared( var_1, self.origin ) < 10000 )
        return;

    var_2 = self getlookaheaddir();
    var_3 = self getvelocity();

    if ( lengthsquared( var_3 ) > 16 )
    {
        var_4 = anglestoup( self.angles );

        if ( vectordot( var_4, ( 0, 0, 1 ) ) < 0.707 )
        {
            var_5 = vectordot( var_4, var_2 );

            if ( var_5 > 0.707 || var_5 < -0.707 )
                return;
        }
    }

    _ID10772( "run_start" );
}

_ID10598()
{
    _ID10772( "leap_to_run_start" );
}

_ID29828()
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "minion":
        case "spitter":
        case "seeder":
            return 1;
        default:
            return 0;
    }
}

_ID29812()
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "elite":
        case "minion":
        case "spitter":
        case "mammoth":
        case "seeder":
            return 0;
        default:
            return 1;
    }
}

_ID10772( var_0 )
{
    if ( _ID29828() )
    {
        var_1 = 0;
        maps\mp\agents\alien\_alien_anim_utils::_ID33987( self getlookaheaddir() );
    }
    else
        var_1 = getstartmoveangleindex();

    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    self.blockgoalpos = 1;
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( var_0, var_1, self.moveplaybackrate, var_0, "code_move" );
    self scragentsetorientmode( "face motion" );
    self.blockgoalpos = 0;
}

candostartmove()
{
    if ( !isdefined( self._ID33491 ) && !isdefined( self._ID30086 ) && ( !isdefined( self._ID10156 ) || self._ID10156 == 0 ) )
    {
        return 1;
        return;
    }

    return 0;
    return;
}

_ID15368()
{
    var_0 = self._ID24939;

    switch ( var_0 )
    {
        case "traverse_jump":
            return "leap-to-run";
        default:
            switch ( self.movemode )
            {
                case "run":
                    return "run-start";
                case "walk":
                    return "walk-start";
                default:
                    return "run-start";
            }
    }
}

shoulddostopanim()
{
    return isdefined( self.enablestop ) && self.enablestop == 1;
}

_ID29864( var_0, var_1 )
{
    if ( var_0.type == "Jump" || var_0.type == "Jump Attack" )
    {
        return 1;
        return;
    }

    if ( _ID33480( var_0.animscript ) )
    {
        return 1;
        return;
    }

    if ( _ID17525( maps\mp\alien\_unk1464::_ID14264(), var_1 ) )
    {
        return 0;
        return;
    }

    return 1;
    return;
    return;
    return;
}

_ID17525( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "elite":
        case "mammoth":
            return var_1 == 4;
        default:
            return var_1 == 3 || var_1 == 4 || var_1 == 5;
    }
}

_ID33480( var_0 )
{
    switch ( var_0 )
    {
        case "alien_climb_up":
        case "alien_climb_up_over_56":
        case "climb_up_end_jump_side_l":
        case "climb_up_end_jump_side_r":
        case "alien_climb_up_ledge_18_run":
        case "alien_climb_up_ledge_18_idle":
            return 1;
        default:
            return 0;
    }
}

candoturnanim( var_0 )
{
    var_1 = 16;
    var_2 = 10;
    var_3 = ( 0, 0, 16 );

    if ( !isdefined( self getpathgoalpos() ) )
        return 0;

    var_4 = getnotetracktimes( var_0, "code_move" );
    var_5 = var_4[0];
    var_6 = getmovedelta( var_0, 0, var_5 );
    var_7 = self localtoworldcoords( var_6 );
    var_7 = getgroundposition( var_7, self.radius );

    if ( !isdefined( var_7 ) )
        return 0;

    var_8 = self aiphysicstracepassed( self.origin + var_3, var_7 + var_3, self.radius - var_2, self.height - var_1 );

    if ( var_8 )
    {
        return 1;
        return;
    }

    return 0;
    return;
}

_ID29896()
{
    var_0 = getstartmoveangleindex();
    return var_0 < 3 || var_0 > 5;
}

getstartmoveangleindex()
{
    return maps\mp\agents\_scriptedagents::_ID14876( self getlookaheaddir() );
}
