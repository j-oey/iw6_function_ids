// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["auto_shotgun"] = ::_ID33835;
    level._ID19268["auto_shotgun"] = ::_ID29792;
    level._ID19256["thumper"] = ::_ID33881;
    level._ID19268["thumper"] = ::_ID32968;
    thread _ID22877();
}

_ID29792()
{
    self givemaxammo( "aa12_mp" );
    thread _ID27309( "aa12_mp" );
}

_ID33835( var_0 )
{
    thread _ID26044( "aa12_mp" );
    return 1;
}

_ID32968()
{
    self givemaxammo( "m79_mp" );
    thread _ID27309( "m79_mp" );
}

_ID33881()
{
    thread _ID26044( "m79_mp" );
    return 1;
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

        if ( !isdefined( self.pers["ksWeapon_clip_ammo"] ) || !isdefined( self.pers["ksWeapon_name"] ) )
            continue;

        var_0 = self.pers["ksWeapon_name"];

        if ( isdefined( self.pers["killstreak"] ) && maps\mp\_utility::getkillstreakweapon( self.pers["killstreak"] ) != var_0 )
        {
            self.pers["ksWeapon_name"] = undefined;
            self.pers["ksWeapon_clip_ammo"] = undefined;
            self.pers["ksWeapon_stock_ammo"] = undefined;
            continue;
        }

        maps\mp\killstreaks\_killstreaks::givekillstreakweapon( var_0 );
        self setweaponammostock( var_0, self.pers["ksWeapon_stock_ammo"] );
        self setweaponammoclip( var_0, self.pers["ksWeapon_clip_ammo"] );
        thread _ID26044( var_0 );
        thread _ID27309( var_0 );
    }
}

_ID27309( var_0 )
{
    self endon( "disconnect" );
    self endon( "got_killstreak" );
    self notify( "saveWeaponAmmoOnDeath" );
    self endon( "saveWeaponAmmoOnDeath" );
    self.pers["ksWeapon_name"] = undefined;
    self.pers["ksWeapon_clip_ammo"] = undefined;
    self.pers["ksWeapon_stock_ammo"] = undefined;
    self waittill( "death" );

    if ( !self hasweapon( var_0 ) )
        return;

    self.pers["ksWeapon_name"] = var_0;
    self.pers["ksWeapon_clip_ammo"] = self getweaponammoclip( var_0 );
    self.pers["ksWeapon_stock_ammo"] = self getweaponammostock( var_0 );
}

_ID26044( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self notify( var_0 + "_ammo_monitor" );
    self endon( var_0 + "_ammo_monitor" );

    for (;;)
    {
        self waittill( "end_firing" );

        if ( self getcurrentweapon() != var_0 )
            continue;

        var_1 = self getweaponammoclip( var_0 ) + self getweaponammostock( var_0 );

        if ( var_1 )
            continue;

        self takeweapon( var_0 );
        return;
    }
}
