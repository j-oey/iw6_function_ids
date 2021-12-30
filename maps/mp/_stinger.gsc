// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID18004()
{
    self._ID31743 = undefined;
    self._ID31744 = undefined;
    self._ID31740 = undefined;
    self._ID31741 = undefined;
    thread _ID26140();
    level._ID31745 = [];
}

_ID26139()
{
    if ( !isdefined( self._ID31747 ) )
        return;

    self._ID31747 = undefined;
    self notify( "stop_javelin_locking_feedback" );
    self notify( "stop_javelin_locked_feedback" );
    self weaponlockfree();
    _ID18004();
}

_ID26140()
{
    self endon( "disconnect" );
    self notify( "ResetStingerLockingOnDeath" );
    self endon( "ResetStingerLockingOnDeath" );

    for (;;)
    {
        self waittill( "death" );
        _ID26139();
    }
}

_ID31736( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( !self worldpointinreticle_circle( var_0.origin, 65, 85 ) )
        return 0;

    if ( self._ID31744 == level.ac130.planemodel && !isdefined( level.ac130player ) )
        return 0;

    return 1;
}

_ID20360()
{
    self endon( "stop_javelin_locking_feedback" );

    for (;;)
    {
        if ( isdefined( level.chopper ) && isdefined( level.chopper._ID15889 ) && isdefined( self._ID31744 ) && self._ID31744 == level.chopper._ID15889 )
            level.chopper._ID15889 playlocalsound( "missile_locking" );

        if ( isdefined( level.ac130player ) && isdefined( self._ID31744 ) && self._ID31744 == level.ac130.planemodel )
            level.ac130player playlocalsound( "missile_locking" );

        self playlocalsound( "stinger_locking" );
        self playrumbleonentity( "ac130_25mm_fire" );
        wait 0.6;
    }
}

_ID20359()
{
    self endon( "stop_javelin_locked_feedback" );

    for (;;)
    {
        if ( isdefined( level.chopper ) && isdefined( level.chopper._ID15889 ) && isdefined( self._ID31744 ) && self._ID31744 == level.chopper._ID15889 )
            level.chopper._ID15889 playlocalsound( "missile_locking" );

        if ( isdefined( level.ac130player ) && isdefined( self._ID31744 ) && self._ID31744 == level.ac130.planemodel )
            level.ac130player playlocalsound( "missile_locking" );

        self playlocalsound( "stinger_locked" );
        self playrumbleonentity( "ac130_25mm_fire" );
        wait 0.25;
    }
}

_ID20201( var_0 )
{
    var_1 = self geteye();

    if ( !isdefined( var_0 ) )
        return 0;

    var_2 = sighttracepassed( var_1, var_0.origin, 0, var_0 );

    if ( var_2 )
        return 1;

    var_3 = var_0 getpointinbounds( 1, 0, 0 );
    var_2 = sighttracepassed( var_1, var_3, 0, var_0 );

    if ( var_2 )
        return 1;

    var_4 = var_0 getpointinbounds( -1, 0, 0 );
    var_2 = sighttracepassed( var_1, var_4, 0, var_0 );

    if ( var_2 )
        return 1;

    return 0;
}

_ID31738( var_0 )
{

}

_ID30386()
{
    var_0 = 500;

    if ( _ID20201( self._ID31744 ) )
    {
        self._ID31741 = 0;
        return 1;
    }

    if ( self._ID31741 == 0 )
        self._ID31741 = gettime();

    var_1 = gettime() - self._ID31741;

    if ( var_1 >= var_0 )
    {
        _ID26139();
        return 0;
    }

    return 1;
}

_ID31746()
{
    if ( !isplayer( self ) )
        return;

    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    var_0 = 1000;
    _ID18004();

    for (;;)
    {
        wait 0.05;

        if ( self playerads() < 0.95 )
        {
            _ID26139();
            continue;
        }

        var_1 = self getcurrentweapon();

        if ( var_1 != "stinger_mp" && var_1 != "at4_mp" && var_1 != "iw5_smaw_mp" )
        {
            _ID26139();
            continue;
        }

        self._ID31747 = 1;

        if ( !isdefined( self._ID31743 ) )
            self._ID31743 = 0;

        _ID31738( self._ID31744 );

        if ( self._ID31743 == 0 )
        {
            var_2 = maps\mp\gametypes\_weapons::_ID20194();

            if ( var_2.size == 0 )
                continue;

            var_3 = [];

            foreach ( var_5 in var_2 )
            {
                if ( !isdefined( var_5 ) )
                    continue;

                var_6 = self worldpointinreticle_circle( var_5.origin, 65, 75 );

                if ( var_6 )
                    var_3[var_3.size] = var_5;
            }

            if ( var_3.size == 0 )
                continue;

            var_8 = sortbydistance( var_3, self.origin );

            if ( !_ID20201( var_8[0] ) )
                continue;

            thread _ID20360();
            self._ID31744 = var_8[0];
            self._ID31740 = gettime();
            self._ID31743 = 1;
            self._ID31741 = 0;
        }

        if ( self._ID31743 == 1 )
        {
            if ( !_ID31736( self._ID31744 ) )
            {
                _ID26139();
                continue;
            }

            var_9 = _ID30386();

            if ( !var_9 )
                continue;

            var_10 = gettime() - self._ID31740;

            if ( maps\mp\_utility::_hasperk( "specialty_fasterlockon" ) )
            {
                if ( var_10 < var_0 * 0.5 )
                    continue;
            }
            else if ( var_10 < var_0 )
                continue;

            self notify( "stop_javelin_locking_feedback" );
            thread _ID20359();

            if ( _ID7135( self._ID31744.model ) )
                self weaponlockfinalize( self._ID31744 );
            else if ( isplayer( self._ID31744 ) )
                self weaponlockfinalize( self._ID31744, ( 100, 0, 64 ) );
            else
                self weaponlockfinalize( self._ID31744, ( 100, 0, -32 ) );

            self._ID31743 = 2;
        }

        if ( self._ID31743 == 2 )
        {
            var_9 = _ID30386();

            if ( !var_9 )
                continue;

            if ( !_ID31736( self._ID31744 ) )
            {
                _ID26139();
                continue;
            }
        }
    }
}

_ID7135( var_0 )
{
    switch ( var_0 )
    {
        case "vehicle_av8b_harrier_jet_mp":
        case "vehicle_av8b_harrier_jet_opfor_mp":
        case "vehicle_ugv_talon_mp":
            return 1;
        default:
            if ( var_0 == level._ID20077 )
                return 1;
    }

    return 0;
}
