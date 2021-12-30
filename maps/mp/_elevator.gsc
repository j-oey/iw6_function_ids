// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17730( var_0 )
{
    var_1 = getent( var_0.name, "targetname" );
    var_1._ID34249 = ::handleunreslovedcollision;
    var_1._ID10745 = [];

    foreach ( var_8, var_3 in var_0._ID10745 )
    {
        var_4 = [];

        foreach ( var_6 in var_3 )
        {
            var_4[var_4.size] = setupdoor( var_6 + "left", 0, var_0._ID10741 );
            var_4[var_4.size] = setupdoor( var_6 + "right", 1, var_0._ID10741 );
        }

        var_1._ID10745[var_8] = var_4;
    }

    var_1._ID33576 = getent( var_0._ID33577, "targetname" );
    var_1._ID8605 = "floor1";
    var_1._ID26060 = var_1._ID8605;
    var_1._ID10750 = 0;
    var_1._ID10744 = 2.0;
    var_1.doorspeed = var_0._ID10741 / var_1._ID10744;
    var_1._ID21687 = 5.0;
    var_1._ID4533 = 10.0;
    var_1.destinations = [];
    var_1.pathblockers = [];
    var_1._ID6359 = getentarray( var_0._ID6359, "targetname" );

    foreach ( var_10 in var_1._ID6359 )
        var_10 _ID29167( var_1 );

    var_12 = getentarray( "elevator_models", "targetname" );

    foreach ( var_14 in var_12 )
        var_14 linkto( var_1 );

    var_1 thread _ID11327();
    var_1 thread _ID22957( var_1._ID8605, 0 );
}

setupdoor( var_0, var_1, var_2 )
{
    var_3 = getent( var_0, "targetname" );

    if ( isdefined( var_3 ) )
    {
        var_3.closepos = var_3.origin;

        if ( isdefined( var_3.target ) )
        {
            var_4 = common_scripts\utility::_ID15384( var_3.target, "targetname" );
            var_3._ID22962 = var_4.origin;
        }
        else
        {
            var_5 = anglestoforward( var_3.angles ) * var_2;
            var_3._ID22962 = var_3.origin + var_5;
        }

        return var_3;
    }
    else
        return;
}

_ID29167( var_0 )
{
    self.owner = var_0;

    if ( isdefined( self.target ) )
    {
        var_1 = common_scripts\utility::_ID15384( self.target, "targetname" );

        if ( isdefined( var_1 ) )
        {
            var_0.destinations[self._ID27658] = var_1.origin;

            if ( isdefined( var_1.target ) )
            {
                var_2 = getent( var_1.target, "targetname" );

                if ( isdefined( var_2 ) )
                    var_0.pathblockers[self._ID27658] = var_2;
            }
        }
    }

    _ID11490();
}

_ID11490()
{
    self sethintstring( &"MP_ELEVATOR_USE" );
    self makeusable();
    thread buttonthink();
}

disablebutton()
{
    self makeunusable();
}

buttonthink()
{
    var_0 = self.owner;
    var_0 endon( "elevator_busy" );

    for (;;)
    {
        self waittill( "trigger" );

        if ( self._ID27658 == "elevator" )
        {
            if ( var_0._ID8605 == "floor1" )
                var_0._ID26060 = "floor2";
            else
                var_0._ID26060 = "floor1";
        }
        else
            var_0._ID26060 = self._ID27658;

        var_0 notify( "elevator_called" );
    }
}

_ID11327()
{
    for (;;)
    {
        self waittill( "elevator_called" );

        foreach ( var_1 in self._ID6359 )
            var_1 disablebutton();

        if ( self._ID8605 != self._ID26060 )
        {
            if ( self._ID10750 != 0 )
            {
                self notify( "elevator_stop_autoclose" );
                thread closeelevatordoors( self._ID8605 );
                self waittill( "elevator_doors_closed" );
            }

            elevatormovetofloor( self._ID26060 );
            wait 0.25;
        }

        thread _ID22957( self._ID8605, 0 );
        self waittill( "elevator_doors_open" );

        foreach ( var_1 in self._ID6359 )
            var_1 _ID11490();
    }
}

elevatormovetofloor( var_0 )
{
    self playsound( "scn_elevator_startup" );
    self playloopsound( "scn_elevator_moving_lp" );
    var_1 = self.destinations[var_0];
    var_2 = var_1[2] - self.origin[2];

    foreach ( var_4 in self._ID10745["elevator"] )
        var_4 movez( var_2, self._ID21687 );

    self movez( var_2, self._ID21687 );
    wait(self._ID21687);
    self stoploopsound( "scn_elevator_moving_lp" );
    self playsound( "scn_elevator_stopping" );
    self playsound( "scn_elevator_beep" );
    self._ID8605 = self._ID26060;
}

_ID22957( var_0, var_1 )
{
    var_2 = self._ID10745[var_0];
    self._ID10750 = 1;
    var_3 = var_2[0];
    var_4 = ( var_3._ID22962[0], var_3._ID22962[1], var_3.origin[2] );
    var_5 = var_4 - var_3.origin;
    var_6 = length( var_5 );
    var_7 = var_6 / self.doorspeed;
    var_8 = 0.25;

    if ( var_7 == 0.0 )
    {
        var_7 = 0.05;
        var_8 = 0.0;
    }
    else
    {
        self playsound( "scn_elevator_doors_opening" );
        var_8 = min( var_8, var_7 );
    }

    foreach ( var_3 in var_2 )
        var_3 moveto( ( var_3._ID22962[0], var_3._ID22962[1], var_3.origin[2] ), var_7, 0.0, var_8 );

    wait(var_7);
    self._ID10750 = 2;
    self notify( "elevator_doors_open" );
    elevatorclearpath( var_0 );

    if ( var_1 )
        thread elevatordoorsautoclose();
}

closeelevatordoors( var_0 )
{
    self endon( "elevator_close_interrupted" );
    thread _ID36050( var_0 );
    var_1 = self._ID10745[var_0];
    self._ID10750 = 3;
    var_2 = var_1[0];
    var_3 = ( var_2.closepos[0], var_2.closepos[1], var_2.origin[2] );
    var_4 = var_3 - var_2.origin;
    var_5 = length( var_4 );

    if ( var_5 != 0.0 )
    {
        var_6 = var_5 / self.doorspeed;

        foreach ( var_2 in var_1 )
            var_2 moveto( ( var_2.closepos[0], var_2.closepos[1], var_2.origin[2] ), var_6, 0.0, 0.25 );

        self playsound( "scn_elevator_doors_closing" );
        wait(var_6);
    }

    self._ID10750 = 0;
    elevatorblockpath( var_0 );
    self notify( "elevator_doors_closed" );
}

_ID36050( var_0 )
{
    self endon( "elevator_doors_closed" );
    var_1 = 1;

    foreach ( var_3 in level.characters )
    {
        if ( var_3 istouchingtrigger( self._ID33576 ) )
        {
            var_1 = 0;
            break;
        }
    }

    if ( var_1 )
        self._ID33576 waittill( "trigger" );

    self notify( "elevator_close_interrupted" );
    _ID22957( var_0, 1 );
}

istouchingtrigger( var_0 )
{
    return isalive( self ) && self istouching( var_0 );
}

elevatordoorsautoclose()
{
    self endon( "elevator_doors_closed" );
    self endon( "elevator_stop_autoclose" );
    wait(self._ID4533);
    closeelevatordoors( self._ID8605 );
}

handleunreslovedcollision( var_0 )
{
    if ( !isplayer( var_0 ) )
        var_0 dodamage( 1000, var_0.origin, self, self, "MOD_CRUSH" );
}

elevatorclearpath( var_0 )
{
    var_1 = self.pathblockers[var_0];

    if ( isdefined( var_1 ) )
    {
        var_1 connectpaths();
        var_1 hide();
        var_1 notsolid();
    }
}

elevatorblockpath( var_0 )
{
    var_1 = self.pathblockers[var_0];

    if ( isdefined( var_1 ) )
    {
        var_1 show();
        var_1 solid();
        var_1 disconnectpaths();
    }
}
