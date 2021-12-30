// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    var_0 = spawnstruct();
    var_0._ID17334 = "deployable_weapon_crate";
    var_0.weaponinfo = "deployable_weapon_crate_marker_mp";
    var_0.modelbase = "mp_weapon_crate";
    var_0.modelbombsquad = "mp_weapon_crate_bombsquad";
    var_0._ID16999 = &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_USE";
    var_0.capturingstring = &"KILLSTREAKS_DEPLOYABLE_AMMO_TAKING";
    var_0._ID12275 = "deployable_ammo_taken";
    var_0._ID31889 = "deployable_ammo";
    var_0._ID31051 = "used_deployable_ammo";
    var_0._ID29628 = "compass_objpoint_deploy_ammo_friendly";
    var_0._ID16454 = 20;
    var_0._ID19940 = 90.0;
    var_0._ID35389 = "ammocrate_gone";
    var_0._ID34785 = 50;
    var_0._ID36472 = "destroyed_ammo";
    var_0._ID35387 = "ammocrate_destroyed";
    var_0._ID9664 = "mp_vest_deployed_ui";
    var_0._ID22921 = "ammo_crate_use";
    var_0._ID22917 = ::_ID22919;
    var_0.canusecallback = ::canusedeployable;
    var_0._ID37742 = 1;
    var_0._ID34780 = 1000;
    var_0.maxhealth = 150;
    var_0.damagefeedback = "deployable_bag";
    var_0.deathvfx = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ballistic_vest_death" );
    var_0._ID2990 = 1;
    var_0.allowgrenadedamage = 0;
    var_0._ID20764 = 4;
    var_0.minigunchance = 20;
    var_0._ID21116 = "iw6_minigun_mp";
    var_0.ammorestockcheckfreq = 0.5;
    var_0._ID3345 = 10.0;
    var_0._ID33722 = 200;
    var_0._ID33720 = 64;
    var_0._ID22803 = ::_ID22782;
    var_0.canuseotherboxes = 0;
    level.boxsettings["deployable_ammo"] = var_0;
    level._ID19256["deployable_ammo"] = ::_ID33837;
    level.deployablegunbox_bonusinxuses = randomintrange( 1, var_0.minigunchance + 1 );
    level._ID9646["deployable_ammo"] = [];
    maps\mp\gametypes\sotf::definechestweapons();
}

_ID33837( var_0, var_1 )
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
    level.deployablegunbox_bonusinxuses--;

    if ( level.deployablegunbox_bonusinxuses == 0 )
    {
        var_1 = level.boxsettings[var_0.boxtype];

        if ( isdefined( level.deployableboxgiveweaponfunc ) )
            [[ level.deployableboxgiveweaponfunc ]]( 1 );
        else
            _ID15596( self, var_1._ID21116 );

        maps\mp\gametypes\_missions::_ID25038( "ch_guninabox" );
        level.deployablegunbox_bonusinxuses = randomintrange( var_1.minigunchance, var_1.minigunchance + 1 );
    }
    else
        giverandomgun( self );
}

_ID22782( var_0 )
{
    thread restockammoaura( var_0 );
}

giverandomgun( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 getweaponslistprimaries() )
        var_1[var_1.size] = getweaponbasename( var_3 );

    var_5 = undefined;

    for (;;)
    {
        var_5 = maps\mp\gametypes\sotf::_ID15295( level._ID36255 );
        var_6 = var_5["name"];

        if ( !common_scripts\utility::array_contains( var_1, var_6 ) )
            break;
    }

    var_5 = maps\mp\gametypes\sotf::getrandomattachments( var_5 );
    _ID15596( var_0, var_5 );
}

_ID15596( var_0, var_1 )
{
    var_2 = var_0 getweaponslistprimaries();
    var_3 = 0;

    foreach ( var_5 in var_2 )
    {
        if ( !maps\mp\gametypes\_weapons::_ID18545( var_5 ) )
            var_3++;
    }

    if ( var_3 > 1 )
    {
        var_7 = var_0._ID19545;

        if ( isdefined( var_7 ) && var_7 != "none" )
            var_0 dropitem( var_7 );
    }

    var_0 maps\mp\_utility::_giveweapon( var_1 );
    var_0 switchtoweapon( var_1 );
    var_0 givestartammo( var_1 );
}

restockammoaura( var_0 )
{
    self endon( "death" );
    level endon( "game_eneded" );
    var_1 = spawn( "trigger_radius", self.origin, 0, var_0._ID33722, var_0._ID33720 );
    var_1.owner = self;
    thread maps\mp\gametypes\_weapons::deleteondeath( var_1 );

    if ( isdefined( self._ID21723 ) )
    {
        var_1 enablelinkto();
        var_1 linkto( self._ID21723 );
    }

    var_2 = var_0._ID33722 * var_0._ID33722;
    var_3 = undefined;

    for (;;)
    {
        var_4 = var_1 getistouchingentities( level.players );

        foreach ( var_3 in var_4 )
        {
            if ( isdefined( var_3 ) && !self.owner maps\mp\_utility::isenemy( var_3 ) && _ID29851( var_3 ) )
                addammo( var_3, var_0._ID3345 );
        }

        wait(var_0.ammorestockcheckfreq);
    }
}

_ID29851( var_0 )
{
    return !isdefined( var_0._ID9662 ) || gettime() >= var_0._ID9662;
}

addammo( var_0, var_1 )
{
    var_0._ID9662 = gettime() + var_1 * 1000;
    maps\mp\gametypes\_weapons::_ID27334( var_0 );
    var_0 maps\mp\gametypes\_damagefeedback::hudicontype( "boxofguns" );
}

addammoovertime( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        addammo( var_0 );
        wait(var_2);

        if ( distancesquared( var_0.origin, self.origin ) > var_1 )
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
