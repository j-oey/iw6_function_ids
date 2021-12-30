// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID29881()
{
    return !maps\mp\_utility::_hasperk( "specialty_empimmune" ) && maps\mp\_utility::_ID18610();
}

applyglobalempeffects()
{
    visionsetnaked( "coup_sunblind", 0.05 );
    wait 0.05;
    visionsetnaked( "coup_sunblind", 0 );
    visionsetnaked( "", 0.5 );
}

applyperplayerempeffects_ondetonate()
{
    self playlocalsound( "emp_activate" );
}

applyperplayerempeffects()
{
    self setempjammed( 1 );

    if ( maps\mp\_utility::_hasperk( "specialty_localjammer" ) )
        self clearscrambler();

    thread _ID31441();
}

_ID26023()
{
    self setempjammed( 0 );

    if ( maps\mp\_utility::_hasperk( "specialty_localjammer" ) )
        self makescrambler();

    thread _ID31837();
}

_ID31441()
{
    level endon( "game_ended" );
    self endon( "emp_stop_effect" );
    self endon( "disconnect" );
    self._ID5276 = 1;
    thread doempartifactloop();
    wait 1.0;
    self setclientomnvar( "ui_hud_static", 2 );
    wait 0.5;
    self notify( "emp_stop_artifact" );
    self setclientomnvar( "ui_hud_emp_artifact", 0 );

    for (;;)
    {
        self setclientomnvar( "ui_hud_static", 3 );
        var_0 = randomfloatrange( 0.25, 1.25 );
        wait(var_0);
        self setclientomnvar( "ui_hud_static", 2 );
        wait 0.5;
    }
}

_ID31837()
{
    level endon( "game_ended" );
    self notify( "emp_stop_effect" );
    self endon( "disconnect" );

    if ( isdefined( self._ID5276 ) )
    {
        self._ID5276 = undefined;
        self setclientomnvar( "ui_hud_static", 0 );

        for ( var_0 = 0; var_0 < 3; var_0++ )
        {
            self setclientomnvar( "ui_hud_emp_artifact", 1 );
            wait 0.5;
        }

        self setclientomnvar( "ui_hud_emp_artifact", 0 );
        self._ID24362 = 0;
    }
}

_ID31838()
{
    self notify( "emp_stop_effect" );

    if ( isdefined( self._ID5276 ) || isdefined( self._ID24362 ) )
    {
        self._ID5276 = undefined;
        self._ID24362 = 0;
        self setclientomnvar( "ui_hud_static", 0 );
        self setclientomnvar( "ui_hud_emp_artifact", 0 );
    }
}

doempartifactloop()
{
    self notify( "emp_stop_artifact" );
    level endon( "game_ended" );
    self endon( "emp_stop_effect" );
    self endon( "emp_stop_artifact" );
    self endon( "disconnect" );
    self endon( "joined_spectators" );

    for (;;)
    {
        self setclientomnvar( "ui_hud_emp_artifact", 1 );
        var_0 = randomfloatrange( 0.375, 0.5 );
        wait(var_0);
    }
}

_ID10359( var_0 )
{
    self notify( "emp_stop_static" );
    level endon( "game_ended" );
    self endon( "emp_stop_effect" );
    self endon( "emp_stop_static" );
    self endon( "disconnect" );
    self endon( "joined_spectators" );
    var_1 = 1.0;
    var_2 = 2.0;

    if ( var_0 == 2 )
    {
        var_1 = 0.5;
        var_2 = 0.75;
    }

    for (;;)
    {
        self setclientomnvar( "ui_hud_static", 2 );
        var_3 = randomfloatrange( var_1, var_2 );
        wait(var_3);
    }
}

_ID31521()
{
    self._ID24362 = 0;
}

_ID31522( var_0 )
{
    if ( self._ID24362 != var_0 && isalive( self ) && !maps\mp\_utility::_ID18610() )
    {
        self._ID24362 = var_0;

        switch ( var_0 )
        {
            case 0:
                _ID31837();
                break;
            case 1:
                self._ID5276 = 1;
                self notify( "emp_stop_static" );
                thread doempartifactloop();
                thread _ID10359( 1 );
                break;
            case 2:
                self._ID5276 = 1;
                self notify( "emp_stop_static" );
                self notify( "emp_stop_artifact" );
                thread _ID10359( 2 );
                break;
        }
    }
}

_ID38120()
{
    return self._ID24362;
}
