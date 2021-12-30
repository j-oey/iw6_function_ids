// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    var_0 = spawnstruct();
    var_0._ID17334 = "deployable_vest";
    var_0.weaponinfo = "deployable_vest_marker_mp";
    var_0.modelbase = "prop_ballistic_vest_iw6";
    var_0.modelbombsquad = "prop_ballistic_vest_iw6_bombsquad";
    var_0._ID16999 = &"KILLSTREAKS_HINTS_LIGHT_ARMOR_PICKUP";
    var_0.capturingstring = &"KILLSTREAKS_BOX_GETTING_VEST";
    var_0._ID12275 = "deployable_vest_taken";
    var_0._ID31889 = "deployable_vest";
    var_0._ID31051 = "used_deployable_vest";
    var_0._ID29628 = "compass_objpoint_deploy_friendly";
    var_0._ID16454 = 20;
    var_0._ID19940 = 90.0;
    var_0._ID34785 = 50;
    var_0._ID36472 = "destroyed_vest";
    var_0._ID35387 = "ballistic_vest_destroyed";
    var_0._ID9664 = "mp_vest_deployed_ui";
    var_0._ID22921 = "ammo_crate_use";
    var_0._ID22917 = ::_ID22919;
    var_0.canusecallback = ::canusedeployable;
    var_0._ID34780 = 1000;
    var_0.maxhealth = 300;
    var_0.damagefeedback = "deployable_bag";
    var_0.deathvfx = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ballistic_vest_death" );
    var_0._ID2990 = 1;
    var_0.allowgrenadedamage = 0;
    var_0._ID20764 = 4;
    var_0.canuseotherboxes = 0;
    level.boxsettings["deployable_vest"] = var_0;
    level._ID19256["deployable_vest"] = ::_ID33844;
    level._ID9646["deployable_vest"] = [];
}

_ID33844( var_0, var_1 )
{
    var_2 = maps\mp\killstreaks\_deployablebox::_ID5109( var_0, "deployable_vest" );

    if ( !isdefined( var_2 ) || !var_2 )
        return 0;

    if ( !maps\mp\_utility::_ID18363() )
        maps\mp\_matchdata::_ID20253( "deployable_vest", self.origin );

    return 1;
}

canusedeployable( var_0 )
{
    if ( !maps\mp\_utility::_ID18363() )
        return !maps\mp\perks\_perkfunctions::haslightarmor() && !maps\mp\_utility::_ID18666();

    if ( isdefined( var_0 ) && var_0.owner == self && !isdefined( var_0.air_dropped ) )
        return 0;

    return !maps\mp\_utility::_ID18666();
}

_ID22919( var_0 )
{
    if ( maps\mp\_utility::_ID18363() )
    {
        var_1 = 0;

        if ( isdefined( self._ID19959 ) )
            var_1 = self._ID19959;

        var_2 = get_adjusted_armor( var_1, var_0._ID34651 );
        maps\mp\perks\_perkfunctions::_ID28771( var_2 );
        self notify( "enable_armor" );
    }
    else
        maps\mp\perks\_perkfunctions::_ID28771();
}

get_adjusted_armor( var_0, var_1 )
{
    if ( var_0 + level._ID9660[var_1] > level._ID9659 )
        return level._ID9659;

    return var_0 + level._ID9660[var_1];
}
