// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    self endon( "death" );
    self endon( "killanimscript" );
    self.curmeleetarget endon( "disconnect" );
    var_0 = self.curmeleetarget.origin - self.origin;
    var_1 = length( var_0 );
    var_2 = 1;

    if ( var_1 < self.attackoffset )
    {
        var_3 = self.origin;
        var_2 = 0;
    }
    else
    {
        var_0 /= var_1;
        var_3 = self.curmeleetarget.origin - var_0 * self.attackoffset;
    }

    var_4 = 0;
    var_5 = self.origin + ( 0, 0, 30 );
    var_6 = self.curmeleetarget.origin + ( 0, 0, 30 );
    var_7 = physicstrace( var_5, var_6 );

    if ( distancesquared( var_7, var_6 ) > 1 )
    {
        meleefailed();
        return;
    }

    if ( var_2 )
        var_8 = maps\mp\agents\_scriptedagents::canmovepointtopoint( self.origin, var_3 );
    else
        var_8 = 1;

    var_9 = undefined;

    if ( !var_8 )
        var_10 = 0;
    else
    {
        var_9 = _ID29863( self.curmeleetarget );
        var_10 = isdefined( var_9 );
    }

    self.blockgoalpos = 1;

    if ( var_10 )
    {
        _ID10361( var_9 );
        return;
    }

    _ID10771( var_3, var_8 );
    return;
}

end_script()
{
    self scragentsetanimscale( 1, 1 );
    self.blockgoalpos = 0;
}

_ID15147()
{
    return "attack_run_and_jump";
}

_ID29863( var_0 )
{
    if ( !self.enableextendedkill )
        return undefined;

    var_1 = 4;

    if ( !maps\mp\_utility::_ID18638( var_0 ) )
        return undefined;

    if ( _ID18751( var_0 ) )
        return undefined;

    if ( var_0 maps\mp\_utility::_ID18666() )
        return undefined;

    var_2 = self.origin - var_0.origin;

    if ( abs( var_2[2] ) > var_1 )
        return undefined;

    var_3 = vectornormalize( ( var_2[0], var_2[1], 0 ) );
    var_4 = anglestoforward( var_0.angles );
    var_5 = vectordot( var_4, var_3 );

    if ( var_5 > 0.707 )
    {
        var_6 = 0;
        var_7 = rotatevector( ( 1, 0, 0 ), var_0.angles );
    }
    else if ( var_5 < -0.707 )
    {
        var_6 = 1;
        var_7 = rotatevector( ( -1, 0, 0 ), var_0.angles );
    }
    else
    {
        var_8 = maps\mp\agents\dog\_dog_think::_ID8524( var_2, var_4 );

        if ( var_8 > 0 )
        {
            var_6 = 3;
            var_7 = rotatevector( ( 0, -1, 0 ), var_0.angles );
        }
        else
        {
            var_6 = 2;
            var_7 = rotatevector( ( 0, 1, 0 ), var_0.angles );
        }
    }

    if ( var_6 == 1 )
        var_9 = 128;
    else
        var_9 = 96;

    var_10 = var_0.origin - var_9 * var_7;
    var_11 = maps\mp\agents\_scriptedagents::droppostoground( var_10 );

    if ( !isdefined( var_11 ) )
        return undefined;

    if ( abs( var_11[2] - var_10[2] ) > var_1 )
        return undefined;

    if ( !self aiphysicstracepassed( var_0.origin + ( 0, 0, 4 ), var_11 + ( 0, 0, 4 ), self.radius, self.height ) )
        return undefined;

    return var_6;
}

_ID10361( var_0 )
{
    var_1 = "attack_extended";
    _ID10608( self.curmeleetarget, self.curmeleetarget.health, "MOD_MELEE_DOG" );
    var_2 = self getanimentry( var_1, var_0 );
    thread _ID12551( var_2, self.curmeleetarget.origin, self.curmeleetarget.angles );

    if ( var_0 == 1 )
        self playsoundonmovingent( common_scripts\utility::_ID32831( self._ID36783, "mp_wolf_attack_quick_back_npc", "mp_dog_attack_quick_back_npc" ) );
    else
        self playsoundonmovingent( common_scripts\utility::_ID32831( self._ID36783, "mp_wolf_attack_short_npc", "mp_dog_attack_short_npc" ) );

    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_1, var_0, "attack", "end" );
    self notify( "kill_stick" );
    self.curmeleetarget = undefined;
    self scragentsetanimmode( "anim deltas" );
    self unlink();
}

_ID12551( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "killanimscript" );
    self endon( "kill_stick" );
    wait 0.05;

    if ( isalive( self.curmeleetarget ) )
        return;

    var_3 = self.curmeleetarget getcorpseentity();
    self linkto( var_3 );
    self scragentdoanimrelative( var_0, var_1, var_2 );
}

_ID10771( var_0, var_1 )
{
    var_2 = _ID15147();
    var_3 = 0;

    if ( !var_1 )
    {
        if ( self agentcanseesentient( self.curmeleetarget ) )
        {
            var_4 = maps\mp\agents\_scriptedagents::droppostoground( self.curmeleetarget.origin );

            if ( isdefined( var_4 ) )
            {
                var_3 = 1;
                var_0 = var_4;
            }
            else
            {
                meleefailed();
                return;
            }
        }
        else
        {
            meleefailed();
            return;
        }
    }

    self.lastmeleefailedmypos = undefined;
    self.lastmeleefailedpos = undefined;
    var_5 = self getanimentry( var_2, 0 );
    var_6 = getanimlength( var_5 );
    var_7 = getnotetracktimes( var_5, "dog_melee" );

    if ( var_7.size > 0 )
        var_8 = var_7[0] * var_6;
    else
        var_8 = var_6;

    self scragentdoanimlerp( self.origin, var_0, var_8 );
    thread _ID34553( self.curmeleetarget, var_8, var_1 );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_2, 0, "attack", "dog_melee" );
    self notify( "cancel_updatelerppos" );
    var_9 = 0;

    if ( isdefined( self.curmeleetarget ) )
        var_9 = self.curmeleetarget.health;

    if ( isdefined( self._ID20895 ) )
        var_9 = self._ID20895;

    if ( isdefined( self.curmeleetarget ) )
        _ID10608( self.curmeleetarget, var_9, "MOD_IMPACT" );

    self.curmeleetarget = undefined;

    if ( var_3 )
        self scragentsetanimscale( 0, 1 );
    else
        self scragentsetanimscale( 1, 1 );

    self scragentsetphysicsmode( "gravity" );
    self scragentsetanimmode( "anim deltas" );
    maps\mp\agents\_scriptedagents::_ID35786( "attack", "end" );
}

_ID34553( var_0, var_1, var_2 )
{
    self endon( "killanimscript" );
    self endon( "death" );
    self endon( "cancel_updatelerppos" );
    var_0 endon( "disconnect" );
    var_0 endon( "death" );
    var_3 = var_1;
    var_4 = 0.05;

    for (;;)
    {
        wait(var_4);
        var_3 -= var_4;

        if ( var_3 <= 0 )
            break;

        var_5 = _ID15454( var_0, var_2 );

        if ( !isdefined( var_5 ) )
            break;

        self scragentdoanimlerp( self.origin, var_5, var_3 );
    }
}

_ID15454( var_0, var_1 )
{
    if ( !var_1 )
    {
        var_2 = maps\mp\agents\_scriptedagents::droppostoground( var_0.origin );
        return var_2;
        return;
    }

    var_3 = var_0.origin - self.origin;
    var_4 = length( var_3 );

    if ( var_4 < self.attackoffset )
    {
        return self.origin;
        return;
    }

    var_3 /= var_4;
    var_5 = var_0.origin - var_3 * self.attackoffset;

    if ( maps\mp\agents\_scriptedagents::canmovepointtopoint( self.origin, var_5 ) )
    {
        return var_5;
        return;
    }

    return undefined;
    return;
    return;
    return;
}

_ID18751( var_0 )
{
    if ( isdefined( var_0.hasriotshield ) && var_0.hasriotshield )
    {
        var_1 = self.origin - var_0.origin;
        var_2 = vectornormalize( ( var_1[0], var_1[1], 0 ) );
        var_3 = anglestoforward( var_0.angles );
        var_4 = vectordot( var_3, var_1 );

        if ( var_0._ID16417 )
        {
            if ( var_4 > 0.766 )
                return 1;
        }
        else if ( var_4 < -0.766 )
            return 1;
    }

    return 0;
}

_ID10608( var_0, var_1, var_2 )
{
    if ( _ID18751( var_0 ) )
        return;

    var_0 dodamage( var_1, self.origin, self, self, var_2 );
}

meleefailed()
{
    self.lastmeleefailedmypos = self.origin;
    self.lastmeleefailedpos = self.curmeleetarget.origin;
}
