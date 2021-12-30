// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID1644["slide_dust"] = loadfx( "vfx/gameplay/screen_effects/vfx_scrnfx_tocam_slidedust_m" );
    level._ID1644["hit_left"] = loadfx( "vfx/gameplay/screen_effects/vfx_blood_hit_left" );
    level._ID1644["hit_right"] = loadfx( "vfx/gameplay/screen_effects/vfx_blood_hit_right" );
    level._ID1644["melee_spray"] = loadfx( "vfx/gameplay/screen_effects/vfx_melee_blood_spray" );
}

_ID29694( var_0, var_1 )
{
    if ( maps\mp\_flashgrenades::_ID18627() )
        return;

    if ( var_0 == "MOD_EXPLOSIVE" || var_0 == "MOD_GRENADE" || var_0 == "MOD_GRENADE_SPLASH" || var_0 == "MOD_PROJECTILE" || var_0 == "MOD_PROJECTILE_SPLASH" )
    {
        if ( var_1 > 10 )
        {
            if ( isdefined( self._ID29695 ) && self._ID29695 )
            {
                self shellshock( "frag_grenade_mp", self._ID29695 );
                return;
            }

            self shellshock( "frag_grenade_mp", 0.5 );
            return;
            return;
        }

        return;
    }
}

_ID11744()
{
    self waittill( "death" );
    waittillframeend;
    self notify( "end_explode" );
}

_ID15783()
{
    self notify( "grenade_earthQuake" );
    self endon( "grenade_earthQuake" );
    thread _ID11744();
    self endon( "end_explode" );
    self waittill( "explode",  var_0  );
    playrumbleonposition( "grenade_rumble", var_0 );
    earthquake( 0.5, 0.75, var_0, 800 );

    foreach ( var_2 in level.players )
    {
        if ( var_2 maps\mp\_utility::_ID18837() )
            continue;

        if ( distancesquared( var_0, var_2.origin ) > 360000 )
            continue;

        if ( var_2 damageconetrace( var_0 ) )
            var_2 thread _ID10047( var_0 );

        var_2 setclientomnvar( "ui_hud_shake", 1 );
    }
}

_ID10047( var_0 )
{
    self notify( "dirtEffect" );
    self endon( "dirtEffect" );
    self endon( "disconnect" );

    if ( !maps\mp\_utility::_ID18757( self ) )
        return;

    var_1 = vectornormalize( anglestoforward( self.angles ) );
    var_2 = vectornormalize( anglestoright( self.angles ) );
    var_3 = vectornormalize( var_0 - self.origin );
    var_4 = vectordot( var_3, var_1 );
    var_5 = vectordot( var_3, var_2 );
    var_6 = [ "death", "damage" ];

    if ( var_4 > 0 && var_4 > 0.5 && self getcurrentweapon() != "iw6_riotshield_mp" )
    {
        common_scripts\utility::_ID35628( var_6, 2.0 );
        return;
    }

    if ( abs( var_4 ) < 0.866 )
    {
        if ( var_5 > 0 )
        {
            common_scripts\utility::_ID35628( var_6, 2.0 );
            return;
        }

        common_scripts\utility::_ID35628( var_6, 2.0 );
        return;
        return;
    }

    return;
}

_ID5379( var_0 )
{
    self endon( "disconnect" );

    if ( !maps\mp\_utility::_ID18757( self ) )
        return;

    var_1 = vectornormalize( anglestoforward( self.angles ) );
    var_2 = vectornormalize( anglestoright( self.angles ) );
    var_3 = vectornormalize( var_0 - self.origin );
    var_4 = vectordot( var_3, var_1 );
    var_5 = vectordot( var_3, var_2 );

    if ( var_4 > 0 && var_4 > 0.5 )
        return;

    if ( abs( var_4 ) < 0.866 )
    {
        var_6 = level._ID1644["hit_left"];

        if ( var_5 > 0 )
            var_6 = level._ID1644["hit_right"];

        var_7 = [ "death", "damage" ];
        thread _ID37778( var_6, var_7, 7.0 );
        return;
    }

    return;
}

_ID5380()
{
    self endon( "disconnect" );
    wait 0.5;
    var_0 = [ "death" ];
    thread _ID37778( level._ID1644["melee_spray"], var_0, 1.5 );
}

_ID37778( var_0, var_1, var_2 )
{
    self endon( "disconnect" );
    var_3 = spawnfxforclient( var_0, self geteye(), self );
    triggerfx( var_3 );
    var_3 setfxkilldefondelete();
    common_scripts\utility::_ID35628( var_1, var_2 );
    var_3 delete();
}

c4_earthquake()
{
    thread _ID11744();
    self endon( "end_explode" );
    self waittill( "explode",  var_0  );
    playrumbleonposition( "grenade_rumble", var_0 );
    earthquake( 0.4, 0.75, var_0, 512 );

    foreach ( var_2 in level.players )
    {
        if ( var_2 maps\mp\_utility::_ID18837() )
            continue;

        if ( distance( var_0, var_2.origin ) > 512 )
            continue;

        if ( var_2 damageconetrace( var_0 ) )
            var_2 thread _ID10047( var_0 );

        var_2 setclientomnvar( "ui_hud_shake", 1 );
    }
}

barrel_earthquake()
{
    var_0 = self.origin;
    playrumbleonposition( "grenade_rumble", var_0 );
    earthquake( 0.4, 0.5, var_0, 512 );

    foreach ( var_2 in level.players )
    {
        if ( var_2 maps\mp\_utility::_ID18837() )
            continue;

        if ( distance( var_0, var_2.origin ) > 512 )
            continue;

        if ( var_2 damageconetrace( var_0 ) )
            var_2 thread _ID10047( var_0 );

        var_2 setclientomnvar( "ui_hud_shake", 1 );
    }
}

_ID3903()
{
    var_0 = self.origin;
    playrumbleonposition( "artillery_rumble", self.origin );
    earthquake( 0.7, 0.5, self.origin, 800 );

    foreach ( var_2 in level.players )
    {
        if ( var_2 maps\mp\_utility::_ID18837() )
            continue;

        if ( distance( var_0, var_2.origin ) > 600 )
            continue;

        if ( var_2 damageconetrace( var_0 ) )
            var_2 thread _ID10047( var_0 );

        var_2 setclientomnvar( "ui_hud_shake", 1 );
    }
}

_ID31713( var_0 )
{
    playrumbleonposition( "grenade_rumble", var_0 );
    earthquake( 1.0, 0.6, var_0, 2000 );

    foreach ( var_2 in level.players )
    {
        if ( var_2 maps\mp\_utility::_ID18837() )
            continue;

        if ( distance( var_0, var_2.origin ) > 1000 )
            continue;

        if ( var_2 damageconetrace( var_0 ) )
            var_2 thread _ID10047( var_0 );

        var_2 setclientomnvar( "ui_hud_shake", 1 );
    }
}

airstrike_earthquake( var_0 )
{
    playrumbleonposition( "artillery_rumble", var_0 );
    earthquake( 0.7, 0.75, var_0, 1000 );

    foreach ( var_2 in level.players )
    {
        if ( var_2 maps\mp\_utility::_ID18837() )
            continue;

        if ( distance( var_0, var_2.origin ) > 900 )
            continue;

        if ( var_2 damageconetrace( var_0 ) )
            var_2 thread _ID10047( var_0 );

        var_2 setclientomnvar( "ui_hud_shake", 1 );
    }
}
