// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{

}

_ID31458()
{
    thread _ID21388();
}

_ID31850( var_0 )
{
    self notify( "stop_monitoring_flash" );
}

flashrumbleloop( var_0 )
{
    self endon( "stop_monitoring_flash" );
    self endon( "flash_rumble_loop" );
    self notify( "flash_rumble_loop" );
    var_1 = gettime() + var_0 * 1000;

    while ( gettime() < var_1 )
    {
        self playrumbleonentity( "damage_heavy" );
        wait 0.05;
    }
}

_ID21388()
{
    self endon( "disconnect" );
    self notify( "monitorFlash" );
    self endon( "monitorFlash" );
    self.flashendtime = 0;
    var_0 = 1;

    for (;;)
    {
        self waittill( "flashbang",  var_1, var_2, var_3, var_4, var_5, var_6  );

        if ( !isalive( self ) )
            break;

        if ( isdefined( self.usingremote ) )
            continue;

        if ( isdefined( self.owner ) && isdefined( var_4 ) && var_4 == self.owner )
            continue;

        if ( !isdefined( var_6 ) )
            var_6 = 0;

        var_7 = 0;
        var_8 = 1;
        var_3 = 1;
        var_9 = var_2 * var_3 * var_0;
        var_9 += var_6;
        var_9 = maps\mp\perks\_perkfunctions::applystunresistence( var_9 );

        if ( var_9 < 0.25 )
            continue;

        var_10 = undefined;

        if ( var_9 > 2 )
            var_10 = 0.75;
        else
            var_10 = 0.25;

        if ( level._ID32653 && isdefined( var_4 ) && isdefined( var_4.team ) && var_4.team == self.team && var_4 != self )
        {
            if ( level._ID13683 == 0 )
                continue;
            else if ( level._ID13683 == 1 )
            {

            }
            else if ( level._ID13683 == 2 )
            {
                var_9 *= 0.5;
                var_10 *= 0.5;
                var_8 = 0;
                var_7 = 1;
            }
            else if ( level._ID13683 == 3 )
            {
                var_9 *= 0.5;
                var_10 *= 0.5;
                var_7 = 1;
            }
        }
        else if ( isdefined( var_4 ) )
        {
            var_4 notify( "flash_hit" );

            if ( var_4 != self )
                var_4 maps\mp\gametypes\_missions::_ID25038( "ch_indecentexposure" );
        }

        if ( var_8 && isdefined( self ) )
        {
            thread applyflash( var_9, var_10 );

            if ( isdefined( var_4 ) && var_4 != self )
            {
                var_4 thread maps\mp\gametypes\_damagefeedback::_ID34528( "flash" );
                var_11 = self;

                if ( isplayer( var_4 ) && var_4 isitemunlocked( "specialty_paint" ) && var_4 maps\mp\_utility::_hasperk( "specialty_paint" ) )
                {
                    if ( !var_11 maps\mp\perks\_perkfunctions::ispainted() )
                        var_4 maps\mp\gametypes\_missions::_ID25038( "ch_paint_pro" );

                    var_11 thread maps\mp\perks\_perkfunctions::_ID28814( var_4 );
                }
            }
        }

        if ( var_7 && isdefined( var_4 ) )
            var_4 thread applyflash( var_9, var_10 );
    }
}

applyflash( var_0, var_1 )
{
    if ( !isdefined( self._ID13313 ) || var_0 > self._ID13313 )
        self._ID13313 = var_0;

    if ( !isdefined( self._ID13329 ) || var_1 > self._ID13329 )
        self._ID13329 = var_1;

    wait 0.05;

    if ( isdefined( self._ID13313 ) )
    {
        self shellshock( "flashbang_mp", self._ID13313 );
        self.flashendtime = gettime() + self._ID13313 * 1000;
    }

    if ( isdefined( self._ID13329 ) )
        thread flashrumbleloop( self._ID13329 );

    self._ID13313 = undefined;
    self._ID13329 = undefined;
}

_ID18627()
{
    return isdefined( self.flashendtime ) && gettime() < self.flashendtime;
}
