// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID25267()
{
    var_0 = getentarray( "radiation", "targetname" );

    if ( var_0.size > 0 )
    {
        foreach ( var_2 in var_0 )
            var_2 thread common_scripts\_dynamic_world::_ID33725( ::_ID24489, ::_ID24517 );

        thread _ID22877();
        return;
    }
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0.numareas = 0;
    }
}

_ID24489( var_0 )
{
    self.numareas++;

    if ( self.numareas == 1 )
    {
        radiationeffect();
        return;
    }
}

_ID24517( var_0 )
{
    self.numareas--;

    if ( self.numareas != 0 )
        return;

    self.poison = 0;
    self notify( "leftTrigger" );

    if ( isdefined( self._ID25273 ) )
    {
        self._ID25273 _ID12625( 0.1, 0 );
        return;
    }
}

_ID30502( var_0 )
{
    common_scripts\utility::_ID35626( "death", "leftTrigger" );
    self stoploopsound();
}

radiationeffect()
{
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "death" );
    self endon( "leftTrigger" );
    self.poison = 0;
    thread _ID30502( self );

    for (;;)
    {
        self.poison++;

        switch ( self.poison )
        {
            case 1:
                self.radiationsound = "item_geigercouner_level2";
                self playloopsound( self.radiationsound );
                self viewkick( 1, self.origin );
                break;
            case 3:
                self shellshock( "mp_radiation_low", 4 );
                self.radiationsound = "item_geigercouner_level3";
                self stoploopsound();
                self playloopsound( self.radiationsound );
                self viewkick( 3, self.origin );
                _ID10759( 15 );
                break;
            case 4:
                self shellshock( "mp_radiation_med", 5 );
                self.radiationsound = "item_geigercouner_level3";
                self stoploopsound();
                self playloopsound( self.radiationsound );
                self viewkick( 15, self.origin );
                thread blackout();
                _ID10759( 25 );
                break;
            case 6:
                self shellshock( "mp_radiation_high", 5 );
                self.radiationsound = "item_geigercouner_level4";
                self stoploopsound();
                self playloopsound( self.radiationsound );
                self viewkick( 75, self.origin );
                _ID10759( 45 );
                break;
            case 8:
                self shellshock( "mp_radiation_high", 5 );
                self.radiationsound = "item_geigercouner_level4";
                self stoploopsound();
                self playloopsound( self.radiationsound );
                self viewkick( 127, self.origin );
                _ID10759( 175 );
                break;
        }

        wait 1;
    }

    wait 5;
}

blackout()
{
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "death" );
    self endon( "leftTrigger" );

    if ( !isdefined( self._ID25273 ) )
    {
        self._ID25273 = newclienthudelem( self );
        self._ID25273.x = 0;
        self._ID25273.y = 0;
        self._ID25273 setshader( "black", 640, 480 );
        self._ID25273.alignx = "left";
        self._ID25273.aligny = "top";
        self._ID25273.horzalign = "fullscreen";
        self._ID25273.vertalign = "fullscreen";
        self._ID25273.alpha = 0;
    }

    var_0 = 1;
    var_1 = 2;
    var_2 = 0.25;
    var_3 = 1;
    var_4 = 5;
    var_5 = 100;
    var_6 = 0;

    for (;;)
    {
        while ( self.poison > 1 )
        {
            var_7 = var_5 - var_4;
            var_6 = ( self.poison - var_4 ) / var_7;

            if ( var_6 < 0 )
                var_6 = 0;
            else if ( var_6 > 1 )
                var_6 = 1;

            var_8 = var_1 - var_0;
            var_9 = var_0 + var_8 * ( 1 - var_6 );
            var_10 = var_3 - var_2;
            var_11 = var_2 + var_10 * var_6;
            var_12 = var_6 * 0.5;

            if ( var_6 == 1 )
                break;

            var_13 = var_9 / 2;
            self._ID25273 fadeinblackout( var_13, var_11 );
            self._ID25273 _ID12625( var_13, var_12 );
            wait(var_6 * 0.5);
        }

        if ( var_6 == 1 )
            break;

        if ( self._ID25273.alpha != 0 )
            self._ID25273 _ID12625( 1, 0 );

        wait 0.05;
    }

    self._ID25273 fadeinblackout( 2, 0 );
}

_ID10759( var_0 )
{
    self thread [[ level.callbackplayerdamage ]]( self, self, var_0, 0, "MOD_SUICIDE", "claymore_mp", self.origin, ( 0, 0, 0 ) - self.origin, "none", 0 );
}

fadeinblackout( var_0, var_1 )
{
    self fadeovertime( var_0 );
    self.alpha = var_1;
    wait(var_0);
}

_ID12625( var_0, var_1 )
{
    self fadeovertime( var_0 );
    self.alpha = var_1;
    wait(var_0);
}
