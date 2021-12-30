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
    self.is_moving = 1;
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
            default:
                break;
        }
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
    thread _ID35571();
    thread _ID35576();
    thread waitforstuck();
}

continuemovement()
{
    self scragentsetorientmode( "face motion" );
    self scragentsetanimmode( "code_move" );
    self scragentsetanimscale( self._ID36479, 1.0 );
    setupmovement();
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

    var_2 = 0;

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
    thread continuemovement();
}

_ID35576()
{
    self endon( "killanimscript" );
    self endon( "alienmove_endwait_stop" );
    self waittill( "stop_soon" );

    if ( !shoulddostopanim() )
        thread _ID35576();
    else
    {
        var_0 = self getpathgoalpos();
        playstopanimation( var_0, 1 );
        maps\mp\agents\alien\_alien_anim_utils::_ID33987( self getlookaheaddir() );
        var_0 = self getpathgoalpos();

        if ( distancesquared( self.origin, var_0 ) < 400.0 )
        {
            self.is_moving = 0;
            self scragentsetanimmode( "code_move_slide" );
            return;
            return;
        }

        _ID31459();
        continuemovement();
    }
}

shouldrestartstop()
{
    return self.currentanimstate == "move";
}

playstopanimation( var_0, var_1 )
{
    var_2 = shouldrestartstop();

    if ( !isdefined( var_0 ) )
    {
        if ( shouldrestartstop() )
            thread _ID35576();

        return;
    }

    var_3 = var_0 - self.origin;
    var_4 = _ID15381( var_0 );
    var_5 = _ID15379();
    var_6 = getstopanimindex( var_5, var_4 );
    var_7 = self getanimentry( var_5, var_6 );
    var_8 = getmovedelta( var_7 );
    var_9 = getangledelta( var_7 );

    if ( length( var_3 ) + 48 < length( var_8 ) )
    {
        if ( var_2 )
            thread _ID35576();

        return;
    }

    var_10 = getstopdata( var_0 );
    var_11 = calcanimstartpos( var_10._ID24745, var_10.angles[1], var_8, var_9 );
    var_12 = maps\mp\agents\_scriptedagents::droppostoground( var_11 );

    if ( !isdefined( var_12 ) )
    {
        if ( var_2 )
            thread _ID35576();

        return;
    }

    if ( !maps\mp\agents\_scriptedagents::canmovepointtopoint( var_10._ID24745, var_12 ) )
    {
        if ( var_2 )
            thread _ID35576();

        return;
    }

    if ( var_2 )
    {
        _ID6559( "stop", "sharpturn" );
        thread _ID35563( "alienmove_endwait_pathsetwhilestopping", "alienmove_endwait_stop" );
    }

    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", vectortoangles( var_3 ) );

    if ( var_1 )
    {
        var_13 = maps\mp\agents\_scriptedagents::getanimscalefactors( var_0 - self.origin, var_8 );
        self scragentsetanimscale( var_13._ID36478, var_13.z );
    }

    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_5, var_6, var_5, "end" );
    self scragentsetanimscale( 1.0, 1.0 );
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

    endswitch( 4 )  case "jog" loc_3CC case "run" loc_3CC case "walk" loc_3D2 default loc_3D8
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

_ID28789( var_0 )
{
    if ( var_0 == "run" )
    {
        var_1 = self getanimentrycount( "run" );
        var_2 = [ 20, 80 ];
        var_3 = maps\mp\alien\_unk1464::getrandomindex( var_2 );
        self setanimstate( "run", var_3, self.moveplaybackrate );
    }
    else if ( var_0 == "walk" )
    {
        var_4 = undefined;
        self setanimstate( "walk", var_4, self.moveplaybackrate );
    }
    else
    {

    }
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
    if ( maps\mp\alien\_unk1464::_ID18462( var_1, var_4 ) )
        dostumble( var_3, var_7, var_8, var_2, var_4, var_1 );
}

dostumble( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "killanimscript" );

    if ( self._ID24606 )
        return;

    _ID6559( undefined );
    self.statelocked = 1;
    self._ID24606 = 1;
    var_6 = "move_pain";
    var_7 = randomint( self getanimentrycount( var_6 ) );
    var_8 = self getanimentry( var_6, var_7 );
    maps\mp\alien\_unk1464::always_play_pain_sound( var_8 );
    maps\mp\alien\_unk1464::_ID25692( var_8 );
    self scragentsetorientmode( "face angle abs", self.angles );
    self scragentsetanimmode( "anim deltas" );
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( var_6, var_7, self.moveplaybackrate, var_6, "code_move" );
    self._ID24606 = 0;
    self.statelocked = 0;

    if ( _ID29896() )
        _ID31459();

    continuemovement();
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
    var_2 = self getlookaheaddir();

    if ( isdefined( self.pathnode ) )
        var_2 = vectornormalize( self.pathnode.origin - self.origin );

    maps\mp\agents\alien\_alien_anim_utils::_ID33987( var_2 );
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

    _ID10772( "run_start" );
}

_ID10772( var_0 )
{
    var_1 = 0;
    maps\mp\agents\alien\_alien_anim_utils::_ID33987( self getlookaheaddir() );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    self.blockgoalpos = 1;
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( var_0, var_1, self.moveplaybackrate, var_0, "code_move" );
    self scragentsetorientmode( "face motion" );
    self.blockgoalpos = 0;
}

candostartmove()
{
    if ( !isdefined( self._ID30086 ) )
        return 1;
    else
        return 0;
}

_ID15368()
{
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

shoulddostopanim()
{
    return isdefined( self.enablestop ) && self.enablestop == 1;
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
        return 1;
    else
        return 0;
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
