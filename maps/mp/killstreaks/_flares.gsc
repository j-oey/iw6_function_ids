// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID13274( var_0 )
{
    self._ID13287 = var_0;
    self._ID13280 = [];
    thread _ID19300();
}

flares_playfx()
{
    for ( var_0 = 0; var_0 < 10; var_0++ )
    {
        if ( !isdefined( self ) )
            return;

        playfxontag( level._ID1644["vehicle_flares"], self, "TAG_FLARE" );
        wait 0.15;
    }
}

_ID13265()
{
    var_0 = spawn( "script_origin", self.origin + ( 0, 0, -256 ) );
    var_0.angles = self.angles;
    var_0 movegravity( ( 0, 0, -1 ), 5.0 );
    self._ID13280[self._ID13280.size] = var_0;
    var_0 thread _ID13264( 5.0, 2.0, self );
    playsoundatpos( var_0.origin, "veh_helo_flares_npc" );
    return var_0;
}

_ID13264( var_0, var_1, var_2 )
{
    if ( isdefined( var_1 ) && isdefined( var_2 ) )
    {
        var_0 -= var_1;
        wait(var_1);

        if ( isdefined( var_2 ) )
            var_2._ID13280 = common_scripts\utility::array_remove( var_2._ID13280, self );
    }

    wait(var_0);
    self delete();
}

_ID13271( var_0 )
{
    return var_0._ID13287;
}

_ID13261( var_0 )
{
    _ID13263( var_0 );
    return var_0._ID13287 > 0 || var_0._ID13280.size > 0;
}

_ID13270( var_0 )
{
    var_0._ID13287--;
    var_0 thread flares_playfx();
    var_1 = var_0 _ID13265();
    return var_1;
}

_ID13263( var_0 )
{
    var_0._ID13280 = common_scripts\utility::array_removeundefined( var_0._ID13280 );
}

_ID13269( var_0 )
{
    _ID13263( var_0 );
    var_1 = undefined;

    if ( var_0._ID13280.size > 0 )
        var_1 = var_0._ID13280[var_0._ID13280.size - 1];

    return var_1;
}

_ID19300()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self endon( "helicopter_done" );

    while ( _ID13261( self ) )
    {
        level waittill( "laserGuidedMissiles_incoming",  var_0, var_1, var_2  );

        if ( !isdefined( var_2 ) || var_2 != self )
            continue;

        foreach ( var_4 in var_1 )
        {
            if ( isvalidmissile( var_4 ) )
                level thread _ID19301( var_4, var_0, var_0.team, var_2 );
        }
    }
}

_ID19301( var_0, var_1, var_2, var_3 )
{
    var_3 endon( "death" );
    var_0 endon( "death" );
    var_0 endon( "missile_targetChanged" );

    while ( _ID13261( var_3 ) )
    {
        if ( !isdefined( var_3 ) || !isvalidmissile( var_0 ) )
            break;

        var_4 = var_3 getpointinbounds( 0, 0, 0 );

        if ( distancesquared( var_0.origin, var_4 ) < 4000000 )
        {
            var_5 = _ID13269( var_3 );

            if ( !isdefined( var_5 ) )
                var_5 = _ID13270( var_3 );

            var_0 missile_settargetent( var_5 );
            var_0 notify( "missile_pairedWithFlare" );
            break;
        }

        common_scripts\utility::_ID35582();
    }
}

_ID13272( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self endon( "helicopter_done" );

    for (;;)
    {
        level waittill( "sam_fired",  var_1, var_2, var_3  );

        if ( !isdefined( var_3 ) || var_3 != self )
            continue;

        if ( isdefined( var_0 ) )
        {
            level thread [[ var_0 ]]( var_1, var_1.team, var_3, var_2 );
            continue;
        }

        level thread flares_watchsamproximity( var_1, var_1.team, var_3, var_2 );
    }
}

flares_watchsamproximity( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );
    var_2 endon( "death" );

    for (;;)
    {
        var_4 = var_2 getpointinbounds( 0, 0, 0 );
        var_5 = [];

        for ( var_6 = 0; var_6 < var_3.size; var_6++ )
        {
            if ( isdefined( var_3[var_6] ) )
                var_5[var_6] = distance( var_3[var_6].origin, var_4 );
        }

        for ( var_6 = 0; var_6 < var_5.size; var_6++ )
        {
            if ( isdefined( var_5[var_6] ) )
            {
                if ( var_5[var_6] < 4000 && var_2._ID13287 > 0 )
                {
                    var_2._ID13287--;
                    var_2 thread flares_playfx();
                    var_7 = var_2 _ID13265();

                    for ( var_8 = 0; var_8 < var_3.size; var_8++ )
                    {
                        if ( isdefined( var_3[var_8] ) )
                        {
                            var_3[var_8] missile_settargetent( var_7 );
                            var_3[var_8] notify( "missile_pairedWithFlare" );
                        }
                    }

                    return;
                }
            }
        }

        wait 0.05;
    }
}

_ID13273( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self endon( "helicopter_done" );

    for (;;)
    {
        level waittill( "stinger_fired",  var_1, var_2, var_3  );

        if ( !isdefined( var_3 ) || var_3 != self )
            continue;

        if ( isdefined( var_0 ) )
        {
            var_2 thread [[ var_0 ]]( var_1, var_1.team, var_3 );
            continue;
        }

        var_2 thread _ID13279( var_1, var_1.team, var_3 );
    }
}

_ID13279( var_0, var_1, var_2 )
{
    self endon( "death" );

    for (;;)
    {
        if ( !isdefined( var_2 ) )
            break;

        var_3 = var_2 getpointinbounds( 0, 0, 0 );
        var_4 = distance( self.origin, var_3 );

        if ( var_4 < 4000 && var_2._ID13287 > 0 )
        {
            var_2._ID13287--;
            var_2 thread flares_playfx();
            var_5 = var_2 _ID13265();
            self missile_settargetent( var_5 );
            self notify( "missile_pairedWithFlare" );
            return;
        }

        wait 0.05;
    }
}

ks_setup_manual_flares( var_0, var_1, var_2, var_3 )
{
    self._ID13287 = var_0;
    self._ID13280 = [];

    if ( isdefined( var_2 ) )
        self.owner setclientomnvar( var_2, var_0 );

    thread ks_manualflares_watchuse( var_1, var_2 );
    thread _ID19302( var_3 );
}

ks_manualflares_watchuse( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self endon( "helicopter_done" );

    if ( !isai( self.owner ) )
        self.owner notifyonplayercommand( "manual_flare_popped", var_0 );

    while ( _ID13271( self ) )
    {
        self.owner waittill( "manual_flare_popped" );
        var_2 = _ID13270( self );

        if ( isdefined( var_2 ) && isdefined( self.owner ) && !isai( self.owner ) )
        {
            self.owner playlocalsound( "veh_helo_flares_plr" );

            if ( isdefined( var_1 ) )
                self.owner setclientomnvar( var_1, _ID13271( self ) );
        }
    }
}

_ID19302( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self endon( "helicopter_done" );

    while ( _ID13261( self ) )
    {
        self waittill( "targeted_by_incoming_missile",  var_1  );

        if ( !isdefined( var_1 ) )
            continue;

        self.owner playlocalsound( "missile_incoming" );
        self.owner thread _ID19306( self, "missile_incoming" );

        if ( isdefined( var_0 ) )
        {
            var_2 = vectornormalize( var_1[0].origin - self.origin );
            var_3 = vectornormalize( anglestoright( self.angles ) );
            var_4 = vectordot( var_2, var_3 );
            var_5 = 1;

            if ( var_4 > 0 )
                var_5 = 2;
            else if ( var_4 < 0 )
                var_5 = 3;

            self.owner setclientomnvar( var_0, var_5 );
        }

        foreach ( var_7 in var_1 )
        {
            if ( isvalidmissile( var_7 ) )
                thread _ID19303( var_7 );
        }
    }
}

_ID19303( var_0 )
{
    self endon( "death" );
    var_0 endon( "death" );

    for (;;)
    {
        if ( !isdefined( self ) || !isvalidmissile( var_0 ) )
            break;

        var_1 = self getpointinbounds( 0, 0, 0 );

        if ( distancesquared( var_0.origin, var_1 ) < 4000000 )
        {
            var_2 = _ID13269( self );

            if ( isdefined( var_2 ) )
            {
                var_0 missile_settargetent( var_2 );
                var_0 notify( "missile_pairedWithFlare" );
                self.owner stoplocalsound( "missile_incoming" );
                break;
            }
        }

        common_scripts\utility::_ID35582();
    }
}

_ID19306( var_0, var_1 )
{
    self endon( "disconnect" );
    var_0 waittill( "death" );
    self stoplocalsound( var_1 );
}
