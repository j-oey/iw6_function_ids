// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17969()
{
    self.javelinstage = undefined;
    self._ID18909 = undefined;
    self._ID18908 = undefined;
    self._ID18904 = undefined;
    self._ID18913 = undefined;
    self._ID18912 = undefined;
    self._ID18905 = undefined;
}

_ID26124()
{
    if ( !isdefined( self.javelinuseentered ) )
        return;

    self.javelinuseentered = undefined;
    self notify( "stop_lockon_sound" );
    self weaponlockfree();
    self weaponlocktargettooclose( 0 );
    self weaponlocknoclearance( 0 );
    self.currentlylocking = 0;
    self._ID8697 = 0;
    self._ID18911 = undefined;
    self stoplocalsound( "javelin_clu_lock" );
    self stoplocalsound( "javelin_clu_aquiring_lock" );
    _ID17969();
}

_ID12560()
{
    var_0 = self geteye();
    var_1 = self getplayerangles();
    var_2 = anglestoforward( var_1 );
    var_3 = var_0 + var_2 * 15000;
    var_4 = bullettrace( var_0, var_3, 0, undefined );

    if ( var_4["surfacetype"] == "none" )
        return undefined;

    if ( var_4["surfacetype"] == "default" )
        return undefined;

    var_5 = var_4["entity"];

    if ( isdefined( var_5 ) )
    {
        if ( var_5 == level.ac130.planemodel )
            return undefined;
    }

    var_6 = [];
    var_6[0] = var_4["position"];
    var_6[1] = var_4["normal"];
    return var_6;
}

_ID20191()
{
    self._ID18904 = undefined;
}

_ID20189()
{
    if ( !isdefined( self._ID18904 ) )
        self._ID18904 = 1;
    else
        self._ID18904++;
}

lockmissespassedthreshold()
{
    var_0 = 4;

    if ( isdefined( self._ID18904 ) && self._ID18904 >= var_0 )
        return 1;

    return 0;
}

targetpointtooclose( var_0 )
{
    var_1 = 1100;
    var_2 = distance( self.origin, var_0 );

    if ( var_2 < var_1 )
        return 1;

    return 0;
}

_ID20353( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "stop_lockon_sound" );

    for (;;)
    {
        self playlocalsound( var_0 );
        wait(var_1);
    }
}

topattackpasses( var_0, var_1 )
{
    var_2 = var_0 + var_1 * 10.0;
    var_3 = var_2 + ( 0, 0, 2000 );
    var_4 = bullettrace( var_2, var_3, 0, undefined );

    if ( sighttracepassed( var_2, var_3, 0, undefined ) )
        return 1;

    return 0;
}

_ID18915()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    var_0 = 1150;
    var_1 = 25;
    var_2 = 100;
    var_3 = 400;
    var_4 = 12;
    var_5 = 0;
    var_6 = 0;
    self._ID18911 = undefined;
    _ID17969();

    for (;;)
    {
        wait 0.05;
        var_7 = self getcurrentweapon();

        if ( isbot( self ) && var_7 != "javelin_mp" || !issubstr( var_7, "javelin" ) || maps\mp\_utility::_ID18610() )
        {
            if ( isdefined( self.javelinuseentered ) )
                _ID26124();

            continue;
        }

        if ( self playerads() < 0.95 )
        {
            var_6 = gettime();
            _ID26124();
            continue;
        }

        var_8 = 0;

        if ( getdvar( "missileDebugDraw" ) == "1" )
            var_8 = 1;

        var_9 = 0;

        if ( getdvar( "missileDebugText" ) == "1" )
            var_9 = 1;

        self.javelinuseentered = 1;

        if ( !isdefined( self.javelinstage ) )
            self.javelinstage = 1;

        if ( self.javelinstage == 1 )
        {
            var_10 = maps\mp\gametypes\_weapons::_ID20194();

            if ( var_10.size != 0 )
            {
                var_11 = [];

                foreach ( var_13 in var_10 )
                {
                    var_14 = self worldpointinreticle_circle( var_13.origin, 65, 40 );

                    if ( var_14 )
                        var_11[var_11.size] = var_13;
                }

                if ( var_11.size != 0 )
                {
                    var_16 = sortbydistance( var_11, self.origin );

                    if ( !_ID35158( var_16[0] ) )
                        continue;

                    if ( var_9 )
                    {

                    }

                    self._ID18911 = var_16[0];

                    if ( !isdefined( self._ID18905 ) )
                        self._ID18905 = gettime();

                    self.javelinstage = 2;
                    self.javelinlostsightlinetime = 0;
                    _ID18906( var_0 );
                    self.javelinstage = 1;
                    continue;
                }
            }

            if ( lockmissespassedthreshold() )
            {
                _ID26124();
                continue;
            }

            var_17 = gettime() - var_6;

            if ( var_17 < var_2 )
                continue;

            var_17 = gettime() - var_5;

            if ( var_17 < var_1 )
                continue;

            var_5 = gettime();
            var_21 = _ID12560();

            if ( !isdefined( var_21 ) )
            {
                _ID20189();
                continue;
            }

            if ( targetpointtooclose( var_21[0] ) )
            {
                self weaponlocktargettooclose( 1 );
                continue;
            }
            else
                self weaponlocktargettooclose( 0 );

            if ( isdefined( self._ID18909 ) )
            {
                var_22 = averagepoint( self._ID18909 );
                var_23 = distance( var_22, var_21[0] );

                if ( var_23 > var_3 )
                {
                    _ID20189();
                    continue;
                }
            }
            else
            {
                self._ID18909 = [];
                self._ID18908 = [];
            }

            self._ID18909[self._ID18909.size] = var_21[0];
            self._ID18908[self._ID18908.size] = var_21[1];
            _ID20191();

            if ( self._ID18909.size < var_4 )
                continue;

            self._ID18913 = averagepoint( self._ID18909 );
            self._ID18912 = averagenormal( self._ID18908 );
            self._ID18904 = undefined;
            self._ID18909 = undefined;
            self._ID18908 = undefined;
            self._ID18905 = gettime();
            self weaponlockstart( self._ID18913 );
            thread _ID20353( "javelin_clu_aquiring_lock", 0.6 );
            self.javelinstage = 2;
        }

        if ( self.javelinstage == 2 )
        {
            var_14 = self worldpointinreticle_circle( self._ID18913, 65, 45 );

            if ( !var_14 )
            {
                _ID26124();
                continue;
            }

            if ( targetpointtooclose( self._ID18913 ) )
                self weaponlocktargettooclose( 1 );
            else
                self weaponlocktargettooclose( 0 );

            var_17 = gettime() - self._ID18905;

            if ( var_17 < var_0 )
                continue;

            self weaponlockfinalize( self._ID18913, ( 0, 0, 0 ), 1 );
            self notify( "stop_lockon_sound" );
            self playlocalsound( "javelin_clu_lock" );
            self.javelinstage = 3;
        }

        if ( self.javelinstage == 3 )
        {
            var_14 = self worldpointinreticle_circle( self._ID18913, 65, 45 );

            if ( !var_14 )
            {
                _ID26124();
                continue;
            }

            if ( targetpointtooclose( self._ID18913 ) )
                self weaponlocktargettooclose( 1 );
            else
                self weaponlocktargettooclose( 0 );

            continue;
        }
    }
}

debugsightline( var_0, var_1, var_2 )
{

}

_ID35158( var_0 )
{
    var_1 = self geteye();
    var_2 = var_0 getpointinbounds( 0, 0, 0 );
    var_3 = sighttracepassed( var_1, var_2, 0, var_0 );
    debugsightline( var_1, var_2, var_3 );

    if ( var_3 )
        return 1;

    var_4 = var_0 getpointinbounds( 1, 0, 0 );
    var_3 = sighttracepassed( var_1, var_4, 0, var_0 );
    debugsightline( var_1, var_4, var_3 );

    if ( var_3 )
        return 1;

    var_5 = var_0 getpointinbounds( -1, 0, 0 );
    var_3 = sighttracepassed( var_1, var_5, 0, var_0 );
    debugsightline( var_1, var_5, var_3 );

    if ( var_3 )
        return 1;

    return 0;
}

_ID18906( var_0 )
{
    if ( self.javelinstage == 2 )
    {
        self weaponlockstart( self._ID18911 );

        if ( !_ID31735( self._ID18911 ) )
        {
            _ID26124();
            self._ID18905 = undefined;
            return;
        }

        var_1 = _ID30386();

        if ( !var_1 )
        {
            self._ID18905 = undefined;
            return;
        }

        if ( !isdefined( self.currentlylocking ) || !self.currentlylocking )
        {
            thread _ID20353( "javelin_clu_aquiring_lock", 0.6 );
            self.currentlylocking = 1;
        }

        var_2 = gettime() - self._ID18905;

        if ( maps\mp\_utility::_hasperk( "specialty_fasterlockon" ) )
        {
            if ( var_2 < var_0 * 0.5 )
                return;
        }
        else if ( var_2 < var_0 )
            return;

        if ( isplayer( self._ID18911 ) )
            self weaponlockfinalize( self._ID18911, ( 0, 0, 64 ), 0 );
        else
            self weaponlockfinalize( self._ID18911, ( 0, 0, 0 ), 0 );

        self notify( "stop_lockon_sound" );

        if ( !isdefined( self._ID8697 ) || !self._ID8697 )
        {
            self playlocalsound( "javelin_clu_lock" );
            self._ID8697 = 1;
        }

        self.javelinstage = 3;
    }

    if ( self.javelinstage == 3 )
    {
        var_1 = _ID30386();

        if ( !var_1 )
            return;

        if ( !_ID31735( self._ID18911 ) )
        {
            _ID26124();
            return;
        }
    }
}

_ID31735( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( !self worldpointinreticle_circle( var_0.origin, 65, 85 ) )
        return 0;

    return 1;
}

_ID30386()
{
    var_0 = 500;

    if ( _ID35158( self._ID18911 ) )
    {
        self.javelinlostsightlinetime = 0;
        return 1;
    }

    if ( self.javelinlostsightlinetime == 0 )
        self.javelinlostsightlinetime = gettime();

    var_1 = gettime() - self.javelinlostsightlinetime;

    if ( var_1 >= var_0 )
    {
        _ID26124();
        return 0;
    }

    return 1;
}
