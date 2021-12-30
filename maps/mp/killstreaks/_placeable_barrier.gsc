// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    var_0 = spawnstruct();
    var_0._ID31889 = "placeable_barrier";
    var_0.weaponinfo = "ims_projectile_mp";
    var_0.modelbase = "placeable_barrier";
    var_0._ID21271 = "placeable_barrier_destroyed";
    var_0._ID21276 = "placeable_barrier_obj";
    var_0._ID21277 = "placeable_barrier_obj_red";
    var_0._ID16999 = &"KILLSTREAKS_HINTS_PLACEABLE_COVER_PICKUP";
    var_0._ID23671 = &"KILLSTREAKS_HINTS_PLACEABLE_COVER_PLACE";
    var_0.cannotplacestring = &"KILLSTREAKS_HINTS_PLACEABLE_COVER_CANNOT_PLACE";
    var_0._ID16453 = 75;
    var_0._ID31051 = "used_placeable_barrier";
    var_0._ID19940 = 60.0;
    var_0.maxhealth = 500;
    var_0._ID2990 = 0;
    var_0.damagefeedback = "ims";
    var_0._ID36472 = "destroyed_ims";
    var_0._ID9801 = "ims_destroyed";
    var_0._ID22875 = ::_ID22874;
    var_0._ID22787 = ::_ID22786;
    var_0.placedsfx = "ims_plant";
    var_0.ondamageddelegate = ::ondamaged;
    var_0._ID22798 = ::ondeath;
    var_0.deathvfx = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ballistic_vest_death" );
    var_0._ID7711 = 72;
    var_0.colheight = 36;
    level._ID23658["placeable_barrier"] = var_0;
    _ID29165();
    level._ID19256["placeable_barrier"] = ::_ID33862;
}

_ID33862( var_0, var_1 )
{
    var_2 = maps\mp\killstreaks\_unk1556::_ID15615( "placeable_barrier" );

    if ( var_2 )
        maps\mp\_matchdata::_ID20253( "placeable_barrier", self.origin );

    self._ID18582 = undefined;
    return var_2;
}

createobject( var_0 )
{

}

_ID22874( var_0 )
{
    var_1 = level._ID23658[var_0];
    self setmodel( var_1.modelbase );
    var_2 = common_scripts\utility::_ID30774();
    var_2 show();
    var_2.origin = self.origin;

    if ( !isdefined( level._ID4802 ) )
        _ID29165();

    var_2 clonebrushmodeltoscriptmodel( level._ID4802 );
    var_3 = maps\mp\_utility::getotherteam( self.owner.team );
    badplace_cylinder( var_0 + self getentitynumber(), -1, self.origin, var_1._ID7711, var_1.colheight, var_3 );
    self.collision = var_2;
}

_ID22786( var_0 )
{
    disablecollision( var_0 );
}

ondamaged( var_0, var_1, var_2, var_3 )
{
    return var_3;
}

_ID22805( var_0, var_1, var_2, var_3 )
{

}

ondeath( var_0 )
{
    disablecollision( var_0 );
    var_1 = level._ID23658[var_0];

    if ( isdefined( var_1._ID9094 ) )
        self playsound( var_1._ID9094 );

    playfx( var_1.deathvfx, self.origin );
    wait 0.5;
}

disablecollision( var_0 )
{
    if ( isdefined( self.collision ) )
    {
        badplace_delete( var_0 + self getentitynumber() );
        self.collision delete();
        self.collision = undefined;
    }
}

_ID29165()
{
    var_0 = getent( "barrier_collision", "targetname" );

    if ( isdefined( var_0 ) )
    {
        level._ID4802 = getent( var_0.target, "targetname" );
        var_0 delete();
    }

    if ( !isdefined( level._ID4802 ) )
        level._ID4802 = level.airdropcratecollision;
}
