// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["aa_launcher"] = ::_ID33827;
    maps\mp\_laserguidedlauncher::_ID19910( "vfx/gameplay/mp/killstreaks/vfx_maaws_split", "vfx/gameplay/mp/killstreaks/vfx_maaws_homing" );
}

_ID14856()
{
    return "iw6_maaws_mp";
}

_ID14854()
{
    return "iw6_maawschild_mp";
}

_ID14855()
{
    return "iw6_maawshoming_mp";
}

getaalauncherammo( var_0 )
{
    var_1 = getaalauncheruniqueindex( var_0 );
    var_2 = 0;

    if ( isdefined( var_0.pers["aaLauncherAmmo"][var_1] ) )
        var_2 = var_0.pers["aaLauncherAmmo"][var_1];

    return var_2;
}

clearaalauncherammo( var_0 )
{
    var_1 = getaalauncheruniqueindex( var_0 );
    var_0.pers["aaLauncherAmmo"][var_1] = undefined;
}

setaalauncherammo( var_0, var_1, var_2 )
{
    var_3 = getaalauncheruniqueindex( var_0 );
    var_0.pers["aaLauncherAmmo"][var_3] = var_1;

    if ( !isdefined( var_2 ) || var_2 )
    {
        if ( var_0 hasweapon( _ID14856() ) )
            var_0 setweaponammoclip( _ID14856(), var_1 );
    }
}

getaalauncheruniqueindex( var_0 )
{
    return var_0.pers["killstreaks"][var_0._ID19258]._ID19121;
}

_ID33827( var_0, var_1 )
{
    return _ID34723( self, var_0 );
}

_ID34723( var_0, var_1 )
{
    if ( !isdefined( self.pers["aaLauncherAmmo"] ) )
        self.pers["aaLauncherAmmo"] = [];

    if ( getaalauncherammo( var_0 ) == 0 )
        setaalauncherammo( self, 2, 0 );

    level thread _ID21467( var_0 );
    level thread _ID21409( var_0 );
    thread maps\mp\_laserguidedlauncher::lgm_firing_monitormissilefire( _ID14856(), _ID14854(), _ID14855() );
    var_2 = 0;
    var_3 = var_0 common_scripts\utility::_ID35635( "aa_launcher_switch", "aa_launcher_empty", "death", "disconnect" );

    if ( var_3 == "aa_launcher_empty" )
    {
        var_0 common_scripts\utility::_ID35626( "weapon_change", "LGM_player_allMissilesDestroyed", "death", "disconnect" );
        var_2 = 1;
    }
    else
    {
        if ( var_0 hasweapon( _ID14856() ) && var_0 getammocount( _ID14856() ) == 0 )
            clearaalauncherammo( var_0 );

        if ( getaalauncherammo( var_0 ) == 0 )
            var_2 = 1;
    }

    var_0 notify( "aa_launcher_end" );
    maps\mp\_laserguidedlauncher::_ID19906();
    return var_2;
}

_ID21467( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_0 endon( "aa_launcher_empty" );
    var_0 endon( "aa_launcher_end" );
    var_1 = var_0 getcurrentweapon();

    while ( var_1 == _ID14856() )
        var_0 waittill( "weapon_change",  var_1  );

    var_0 notify( "aa_launcher_switch" );
}

_ID21409( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_0 endon( "aa_launcher_switch" );
    var_0 endon( "aa_launcher_end" );
    setaalauncherammo( var_0, getaalauncherammo( var_0 ), 1 );

    for (;;)
    {
        var_0 waittill( "weapon_fired",  var_1  );

        if ( var_1 != _ID14856() )
            continue;

        var_2 = var_0 getammocount( _ID14856() );
        setaalauncherammo( var_0, var_2, 0 );

        if ( getaalauncherammo( var_0 ) == 0 )
        {
            clearaalauncherammo( var_0 );
            var_0 notify( "aa_launcher_empty" );
            break;
        }
    }
}
