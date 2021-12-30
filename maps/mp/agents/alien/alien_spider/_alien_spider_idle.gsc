// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    self endon( "killanimscript" );
    init_alien_idle();
    thread _ID38269();

    for (;;)
    {
        if ( !isdefined( self._ID38117 ) || self._ID38263 )
        {
            wait 0.05;
            continue;
        }

        if ( _ID38165() )
            continue;

        _ID23783();
    }
}

init_alien_idle()
{
    self._ID17354 = 0;
}

_ID23783()
{
    self endon( "vulnerable" );
    _ID12573();
    var_0 = selectidleanimstate();
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_0, undefined, var_0, "end", maps\mp\agents\alien\alien_spider\_alien_spider::_ID37398 );
}

_ID37371()
{
    var_0 = undefined;

    if ( isalive( self.enemy ) && distancesquared( self.enemy.origin, self.origin ) < 2560000 )
        var_0 = self.enemy;
    else if ( isdefined( self.owner ) )
        var_0 = self.owner;

    return var_0;
}

_ID12573()
{
    var_0 = _ID37371();

    if ( isdefined( var_0 ) )
        maps\mp\agents\alien\_alien_anim_utils::_ID33986( var_0 );
}

selectidleanimstate()
{
    var_0 = _ID37354();

    if ( isdefined( self._ID36719 ) )
        var_0 = self._ID36719 + var_0;

    return var_0;
}

_ID37354()
{
    if ( self._ID17354 < 2 + randomintrange( 0, 1 ) )
    {
        var_0 = "idle_default";
        self._ID17354 = self._ID17354 + 1;
    }
    else
    {
        var_0 = "idle";
        self._ID17354 = 0;
    }

    return var_0;
}

is_moving()
{
    return isdefined( self._ID37438 ) && self._ID37438.active;
}

_ID38165()
{
    if ( !isdefined( self._ID37438 ) )
        return 0;

    if ( isdefined( self._ID37109 ) && self._ID37109 )
        return 0;

    if ( maps\mp\agents\alien\alien_spider\_alien_spider::_ID36944() )
        return 0;

    if ( gettime() < self._ID37438._ID37733 )
        return 0;

    if ( !common_scripts\utility::_ID7657() )
        return 0;

    _ID37769( 0 );
    self._ID37438._ID37733 = gettime() + 15000;
    return 1;
}

_ID37475()
{
    var_0 = spawnstruct();
    var_0._ID37733 = gettime() + 15000;
    var_0.active = 0;
    var_0._ID37599 = -1;
    var_1 = level._ID2829[self.alien_type].attributes["movement_radius"];
    var_2 = anglestoforward( self.angles );
    var_3 = anglestoright( self.angles );
    var_0._ID38241[0] = self.origin;
    var_0._ID38241[1] = self.origin + var_2 * var_1;
    var_0._ID38241[2] = self.origin - var_2 * var_1;
    var_0._ID38241[3] = self.origin + var_3 * var_1;
    var_0._ID38241[4] = self.origin - var_3 * var_1;
    self._ID37438 = var_0;
}

_ID37769( var_0 )
{
    if ( var_0 )
        var_1 = 0;
    else
        var_1 = _ID37296();

    var_2 = self._ID37438._ID38241[var_1];
    var_3 = 25.0;

    if ( distance2dsquared( var_2, self.origin ) < var_3 )
        return;

    self._ID37438.active = 1;
    var_4 = _ID37295( var_2 );
    _ID37781( var_4["animIndex"], var_4["direction"], var_2, var_0 );
    self._ID37438._ID37599 = var_1;
    clean_up_move();
}

clean_up_move()
{
    self._ID37438.active = 0;
    self scragentsetgoalpos( self.origin );
    self scragentsetgoalradius( 4096 );
}

_ID37781( var_0, var_1, var_2, var_3 )
{
    self endon( "move_anim_timeout" );
    self endon( "vulnerable" );
    maps\mp\agents\alien\_alien_anim_utils::_ID33987( var_1 );
    var_4 = self getanimentry( "idle_move", var_0 );
    var_5 = length( getmovedelta( var_4 ) );
    var_6 = length( var_2 - self.origin );
    self._ID36479 = var_6 / var_5;

    if ( !var_3 )
        self._ID36479 = min( self._ID36479, 1.0 );

    self.statelocked = 1;
    self scragentsetanimscale( self._ID36479, 1.0 );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", vectortoangles( var_1 ) );
    thread _ID37713();
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "idle_move", var_0, "idle_move", "end", maps\mp\agents\alien\alien_spider\_alien_spider::_ID37398 );
    self.statelocked = 0;
    self notify( "move_anim_complete" );
}

_ID37713()
{
    self endon( "move_anim_complete" );
    self endon( "vulnerable" );
    var_0 = 10.0;
    wait(var_0);
    self notify( "move_anim_timeout" );
}

_ID37296()
{
    var_0 = self._ID37438._ID38241.size;

    if ( self._ID37438._ID37599 != -1 )
        var_0--;

    var_1 = randomint( var_0 );

    if ( self._ID37438._ID37599 != -1 && var_1 >= self._ID37438._ID37599 )
        var_1++;

    return var_1;
}

_ID37295( var_0 )
{
    var_1 = vectornormalize( var_0 - self.origin );
    var_2 = maps\mp\agents\alien\_alien_anim_utils::getprojectiondata( anglestoforward( self.angles ), var_1, anglestoup( self.angles ) );

    if ( var_2._ID26742 < 45 )
    {
        var_3["direction"] = vectornormalize( var_0 - self.origin );
        var_3["animIndex"] = 0;
    }
    else if ( var_2._ID26742 > 135 )
    {
        var_3["direction"] = vectornormalize( self.origin - var_0 );
        var_3["animIndex"] = 1;
    }
    else
    {
        if ( var_2._ID25062 > 0 )
        {
            var_4 = vectornormalize( var_0 - self.origin );
            var_3["animIndex"] = 2;
        }
        else
        {
            var_4 = vectornormalize( self.origin - var_0 );
            var_3["animIndex"] = 3;
        }

        var_3["direction"] = vectorcross( ( 0, 0, 1 ), var_4 );
    }

    return var_3;
}

_ID38269()
{
    self endon( "killanimscript" );
    self waittill( "vulnerable" );

    if ( isdefined( self._ID37438 ) && self._ID37438.active )
        clean_up_move();

    self.statelocked = 1;
    self._ID37437 = 1;
    maps\mp\agents\alien\alien_spider\_alien_spider_melee::_ID37124();
    self._ID37437 = 0;
    self.statelocked = 0;
}
