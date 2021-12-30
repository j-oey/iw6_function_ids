// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID34184 = spawnstruct();
    level._ID34184.horzalign = "left";
    level._ID34184.vertalign = "top";
    level._ID34184.alignx = "left";
    level._ID34184.aligny = "top";
    level._ID34184.x = 0;
    level._ID34184.y = 0;
    level._ID34184.width = 0;
    level._ID34184.height = 0;
    level._ID34184._ID7139 = [];
    level._ID13468 = 12;
    level.hud["allies"] = spawnstruct();
    level.hud["axis"] = spawnstruct();
    level._ID24975 = -61;
    level._ID24974 = 0;
    level._ID24970 = 9;
    level._ID24973 = 120;
    level.primaryprogressbartexty = -75;
    level._ID24971 = 0;
    level.primaryprogressbarfontsize = 1.2;
    level._ID32677 = 32;
    level._ID32674 = 14;
    level.teamprogressbarwidth = 192;
    level.teamprogressbartexty = 8;
    level._ID32673 = 1.65;
    level._ID20391 = "BOTTOM";
    level._ID20390 = -140;
    level.lowertextfontsize = 1.6;
}

_ID13470( var_0 )
{
    self.basefontscale = self.fontscale;

    if ( isdefined( var_0 ) )
        self._ID20738 = min( var_0, 6.3 );
    else
        self._ID20738 = min( self.fontscale * 2, 6.3 );

    self._ID17625 = 2;
    self._ID23083 = 4;
}

fontpulse( var_0 )
{
    self notify( "fontPulse" );
    self endon( "fontPulse" );
    self endon( "death" );
    var_0 endon( "disconnect" );
    var_0 endon( "joined_team" );
    var_0 endon( "joined_spectators" );
    self changefontscaleovertime( self._ID17625 * 0.05 );
    self.fontscale = self._ID20738;
    wait(self._ID17625 * 0.05);
    self changefontscaleovertime( self._ID23083 * 0.05 );
    self.fontscale = self.basefontscale;
}
