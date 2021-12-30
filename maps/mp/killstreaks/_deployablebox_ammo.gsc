// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    var_0 = spawnstruct();
    var_0.weaponinfo = "deployable_vest_marker_mp";
    var_0.modelbase = "mil_ammo_case_1_open";
    var_0._ID16999 = &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_USE";
    var_0.capturingstring = &"KILLSTREAKS_DEPLOYABLE_AMMO_TAKING";
    var_0._ID12275 = "deployable_ammo_taken";
    var_0._ID31889 = "deployable_ammo";
    var_0._ID31051 = "used_deployable_ammo";
    var_0._ID29628 = "compass_objpoint_deploy_ammo_friendly";
    var_0._ID16454 = 25;
    var_0._ID19940 = 90.0;
    var_0._ID34785 = 50;
    var_0._ID36472 = "destroyed_vest";
    var_0._ID35387 = "ballistic_vest_destroyed";
    var_0._ID9664 = "mp_vest_deployed_ui";
    var_0._ID22921 = "ammo_crate_use";
    var_0._ID22917 = ::_ID22919;
    var_0.canusecallback = ::canusedeployable;
    var_0._ID34780 = 500;
    var_0.maxhealth = 150;
    var_0.damagefeedback = "deployable_bag";
    var_0._ID9104 = "deployable_ammo_mp";
    var_0.deathvfx = loadfx( "fx/explosions/clusterbomb_exp_direct_runner" );
    var_0.deathdamageradius = 256;
    var_0.deathdamagemax = 130;
    var_0._ID9075 = 50;
    var_0._ID2990 = 1;
    var_0.allowgrenadedamage = 1;
    var_0._ID20764 = 4;
    level.boxsettings["deployable_ammo"] = var_0;
    level._ID19256["deployable_ammo"] = ::tryusedeployableammo;
    level._ID9646["deployable_ammo"] = [];
}

tryusedeployableammo( var_0, var_1 )
{
    var_2 = maps\mp\killstreaks\_deployablebox::_ID5109( var_0, "deployable_ammo" );

    if ( !isdefined( var_2 ) || !var_2 )
        return 0;

    if ( !maps\mp\_utility::_ID18363() )
        maps\mp\_matchdata::_ID20253( "deployable_ammo", self.origin );

    return 1;
}

_ID22919( var_0 )
{
    if ( maps\mp\_utility::_ID18363() )
        addalienweaponammo( var_0 );
    else
        addallweaponammo();
}

addallweaponammo()
{
    var_0 = self getweaponslistall();

    if ( isdefined( var_0 ) )
    {
        foreach ( var_2 in var_0 )
        {
            if ( maps\mp\gametypes\_weapons::isbulletweapon( var_2 ) )
            {
                _ID2385( var_2, 2 );
                continue;
            }

            if ( weaponclass( var_2 ) == "rocketlauncher" )
                _ID2385( var_2, 1 );
        }
    }
}

_ID2385( var_0, var_1 )
{
    var_2 = weaponclipsize( var_0 );
    var_3 = self getweaponammostock( var_0 );
    self setweaponammostock( var_0, var_3 + var_1 * var_2 );
}

addratiomaxstocktoallweapons( var_0 )
{
    var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        if ( maps\mp\gametypes\_weapons::isbulletweapon( var_3 ) )
        {
            if ( var_3 != "iw6_alienminigun_mp" )
            {
                var_4 = self getweaponammostock( var_3 );
                var_5 = weaponmaxammo( var_3 );
                var_6 = var_4 + var_5 * var_0;
                self setweaponammostock( var_3, int( min( var_6, var_5 ) ) );
            }
        }
    }
}

addfullcliptoallweapons()
{
    var_0 = self getweaponslistprimaries();

    foreach ( var_2 in var_0 )
    {
        var_3 = weaponclipsize( var_2 );
        self setweaponammoclip( var_2, var_3 );
    }
}

addalienweaponammo( var_0 )
{
    var_1 = self getweaponslistprimaries();

    switch ( var_0._ID34651 )
    {
        case 0:
            addratiomaxstocktoallweapons( 0.4 );
            break;
        case 1:
            addratiomaxstocktoallweapons( 0.7 );
            break;
        case 2:
            addratiomaxstocktoallweapons( 1.0 );
            break;
        case 3:
            addratiomaxstocktoallweapons( 1.0 );
            addfullcliptoallweapons();
            break;
        case 4:
            addratiomaxstocktoallweapons( 1.0 );
            addfullcliptoallweapons();
            break;
    }
}

canusedeployable( var_0 )
{
    if ( maps\mp\_utility::_ID18363() && isdefined( var_0 ) && var_0.owner == self && !isdefined( var_0.air_dropped ) )
        return 0;

    if ( !maps\mp\_utility::_ID18363() )
        return !maps\mp\_utility::_ID18666();
    else
        return 1;
}
