// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    init_fx();
}

init_fx()
{
    level._ID1644["vfx_scrnfx_alien_spitter_mist"] = loadfx( "vfx/gameplay/screen_effects/vfx_scrnfx_alien_spitter_mist" );
    level._ID1644["vfx_scrnfx_alien_blood"] = loadfx( "vfx/gameplay/screen_effects/vfx_scrnfx_alien_blood" );
    level._ID1644["vfx_scrnfx_tocam_slidedust_m"] = loadfx( "vfx/gameplay/screen_effects/vfx_scrnfx_tocam_slidedust_m" );
    level._ID1644["vfx_melee_blood_spray"] = loadfx( "vfx/gameplay/screen_effects/vfx_melee_blood_spray" );
    level._ID1644["vfx_blood_hit_left"] = loadfx( "vfx/gameplay/screen_effects/vfx_blood_hit_left" );
    level._ID1644["vfx_blood_hit_right"] = loadfx( "vfx/gameplay/screen_effects/vfx_blood_hit_right" );
    level._ID1644["vfx_alien_spitter_hit_left"] = loadfx( "vfx/gameplay/screen_effects/vfx_alien_spitter_hit_left" );
    level._ID1644["vfx_alien_spitter_hit_right"] = loadfx( "vfx/gameplay/screen_effects/vfx_alien_spitter_hit_right" );
    level._ID1644["vfx_alien_spitter_hit_center"] = loadfx( "vfx/gameplay/screen_effects/vfx_alien_spitter_hit_center" );
}

alien_fire_on()
{
    if ( !isdefined( self.is_burning ) )
        self.is_burning = 0;

    self.is_burning++;

    if ( self.is_burning == 1 )
        self setscriptablepartstate( "body", "burning" );
}

alien_fire_off()
{
    self.is_burning--;

    if ( self.is_burning > 0 )
        return;

    self.is_burning = undefined;
    self notify( "fire_off" );
    self setscriptablepartstate( "body", "normal" );
}

disable_fx_on_death()
{
    self setscriptablepartstate( "body", "normal" );
}

_ID13963()
{
    if ( maps\mp\alien\_unk1464::_ID14264() == "minion" )
        return;

    self endon( "death" );
    self setscriptablepartstate( "body", "shocked" );
    wait 0.5;

    if ( isalive( self ) )
        self setscriptablepartstate( "body", "normal" );
}

_ID36685()
{
    if ( !isdefined( self._ID37524 ) )
        self._ID37524 = 0;

    self playsound( "alien_teleport" );
    self._ID37524++;

    if ( self._ID37524 == 1 )
        self setscriptablepartstate( "body", "normal" );
}

_ID36684()
{
    self._ID37524--;

    if ( self._ID37524 > 0 )
        return;

    self playsound( "alien_teleport_appear" );
    self._ID37524 = undefined;
    self setscriptablepartstate( "body", "normal" );
}
