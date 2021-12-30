// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    var_0 = spawnstruct();
    var_0.weaponinfo = "deployable_vest_marker_mp";
    var_0.modelbase = "afr_mortar_ammo_01";
    var_0._ID16999 = &"KILLSTREAKS_HINTS_DEPLOYABLE_GRENADES_PICKUP";
    var_0.capturingstring = &"KILLSTREAKS_DEPLOYABLE_GRENADES_TAKING";
    var_0._ID12275 = "deployable_grenades_taken";
    var_0._ID31889 = "deployable_grenades";
    var_0._ID31051 = "used_deployable_grenades";
    var_0._ID29628 = "compass_objpoint_deploy_grenades_friendly";
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
    var_0._ID9104 = "deployable_grenades_mp";
    var_0.deathvfx = loadfx( "fx/explosions/grenadeexp_default" );
    var_0.deathdamageradius = 256;
    var_0.deathdamagemax = 150;
    var_0._ID9075 = 50;
    var_0._ID2990 = 1;
    var_0.allowgrenadedamage = 1;
    var_0._ID20764 = 3;
    level.boxsettings["deployable_grenades"] = var_0;
    level._ID19256["deployable_grenades"] = ::_ID33840;
    level._ID9646["deployable_grenades"] = [];
}

_ID33840( var_0, var_1 )
{
    var_2 = maps\mp\killstreaks\_deployablebox::_ID5109( var_0, "deployable_grenades" );

    if ( !isdefined( var_2 ) || !var_2 )
        return 0;

    maps\mp\_matchdata::_ID20253( "deployable_grenades", self.origin );
    return 1;
}

_ID22919( var_0 )
{
    refillexplosiveweapons();
}

refillexplosiveweapons()
{
    var_0 = self getweaponslistall();

    if ( isdefined( var_0 ) )
    {
        foreach ( var_2 in var_0 )
        {
            if ( maps\mp\gametypes\_weapons::_ID18640( var_2 ) || maps\mp\gametypes\_weapons::isoffhandweapon( var_2 ) )
                self givestartammo( var_2 );
        }
    }

    if ( maps\mp\_utility::_hasperk( "specialty_tacticalinsertion" ) && self getammocount( "flare_mp" ) < 1 )
        maps\mp\_utility::_ID15613( "specialty_tacticalinsertion", 0 );
}

canusedeployable( var_0 )
{
    if ( maps\mp\_utility::_ID18363() && isdefined( var_0 ) && var_0.owner == self && !isdefined( var_0.air_dropped ) )
        return 0;

    return !maps\mp\_utility::_ID18666();
}
