// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    thread _ID22877();
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "spawned_player" );
        thread _ID21378();
    }
}

_ID21378()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self._ID11395 = 0;

    for (;;)
    {
        self waittill( "emp_damage",  var_0, var_1  );

        if ( !isalive( self ) || isdefined( self.usingremote ) || maps\mp\_utility::_hasperk( "specialty_empimmune" ) || !isdefined( var_0 ) )
            continue;

        var_2 = 1;
        var_3 = 0;

        if ( level._ID32653 && var_0 != self && isdefined( var_0.pers["team"] ) && var_0.pers["team"] == self.pers["team"] )
        {
            if ( level._ID13683 == 0 )
                continue;
            else if ( level._ID13683 == 1 )
            {
                var_3 = 0;
                var_2 = 1;
            }
            else if ( level._ID13683 == 2 )
            {
                var_2 = 0;
                var_3 = 1;
            }
            else if ( level._ID13683 == 3 )
            {
                var_3 = 1;
                var_2 = 1;
            }
        }
        else
        {
            var_0 notify( "emp_hit" );

            if ( var_0 != self )
                var_0 maps\mp\gametypes\_missions::_ID25038( "ch_onthepulse" );
        }

        if ( var_2 && isdefined( self ) )
            thread _ID3754( var_1 );

        if ( var_3 )
            var_0 thread _ID3754( var_1 );
    }
}

_ID3754( var_0 )
{
    self notify( "applyEmp" );
    self endon( "applyEmp" );
    self endon( "disconnect" );
    self endon( "death" );
    wait 0.05;
    self.empgrenaded = 1;
    self shellshock( "flashbang_mp", 1 );
    self._ID11395 = gettime() + var_0 * 1000;
    maps\mp\killstreaks\_unk1534::applyperplayerempeffects_ondetonate();
    maps\mp\killstreaks\_unk1534::applyperplayerempeffects();
    thread emprumbleloop( 0.75 );
    thread _ID11397();
    wait(var_0);
    self notify( "empGrenadeTimedOut" );
    _ID7132();
}

_ID11397()
{
    self notify( "empGrenadeDeathWaiter" );
    self endon( "empGrenadeDeathWaiter" );
    self endon( "empGrenadeTimedOut" );
    self waittill( "death" );
    _ID7132();
}

_ID7132()
{
    self.empgrenaded = 0;

    if ( !maps\mp\killstreaks\_unk1534::_ID29881() )
        maps\mp\killstreaks\_unk1534::_ID26023();
}

emprumbleloop( var_0 )
{
    self endon( "emp_rumble_loop" );
    self notify( "emp_rumble_loop" );
    var_1 = gettime() + var_0 * 1000;

    while ( gettime() < var_1 )
    {
        self playrumbleonentity( "damage_heavy" );
        wait 0.05;
    }
}

_ID18611()
{
    return isdefined( self._ID11395 ) && gettime() < self._ID11395;
}
