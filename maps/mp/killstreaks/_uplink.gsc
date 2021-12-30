// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID34657 = [];
    level._ID19256["uplink"] = ::tryuseuplink;
    level._ID19256["uplink_support"] = ::tryuseuplink;
    level.comexpfuncs = [];
    level.comexpfuncs["giveComExpBenefits"] = ::_ID15589;
    level.comexpfuncs["removeComExpBenefits"] = ::_ID25986;
    level.comexpfuncs["getRadarStrengthForTeam"] = ::_ID15280;
    level.comexpfuncs["getRadarStrengthForPlayer"] = ::getradarstrengthforplayer;
    unblockteamradar( "axis" );
    unblockteamradar( "allies" );
    level thread _ID34658();
    level thread _ID34659();
    var_0 = spawnstruct();
    var_0._ID31889 = "uplink";
    var_0.weaponinfo = "ims_projectile_mp";
    var_0.modelbase = "mp_satcom";
    var_0._ID21276 = "mp_satcom_obj";
    var_0._ID21277 = "mp_satcom_obj_red";
    var_0.modelbombsquad = "mp_satcom_bombsquad";
    var_0._ID16999 = &"KILLSTREAKS_HINTS_UPLINK_PICKUP";
    var_0._ID23671 = &"KILLSTREAKS_HINTS_UPLINK_PLACE";
    var_0.cannotplacestring = &"KILLSTREAKS_HINTS_UPLINK_CANNOT_PLACE";
    var_0._ID16453 = 42;
    var_0._ID31051 = "used_uplink";
    var_0._ID19940 = 30;
    var_0.maxhealth = 500;
    var_0._ID2990 = 1;
    var_0.allowempdamage = 1;
    var_0.damagefeedback = "trophy";
    var_0._ID36472 = "destroyed_uplink";
    var_0._ID9801 = "satcom_destroyed";
    var_0._ID23664 = 30.0;
    var_0._ID23669 = 16.0;
    var_0._ID23667 = 16;
    var_0._ID22875 = ::_ID22874;
    var_0._ID22787 = ::_ID22786;
    var_0.placedsfx = "mp_killstreak_satcom_deploy";
    var_0.activesfx = "mp_killstreak_satcom_loop";
    var_0.onmovingplatformcollision = ::uplink_override_moving_platform_death;
    var_0._ID22798 = ::ondeath;
    var_0._ID22806 = ::_ID22805;
    var_0.deathvfx = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ballistic_vest_death" );
    level._ID23658["uplink"] = var_0;
    level._ID23658["uplink_support"] = var_0;
}

_ID34658()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "update_uplink" );
        level childthread _ID34504();
    }
}

_ID34504()
{
    self notify( "updateAllUplinkThreads" );
    self endon( "updateAllUplinkThreads" );
    level childthread _ID36985();

    if ( level._ID32653 )
    {
        level childthread _ID34629( "axis" );
        level childthread _ID34629( "allies" );
    }
    else
        level childthread _ID34580();

    level childthread _ID34523();
}

_ID36985()
{
    var_0 = [];

    if ( !level._ID32653 )
        level waittill( "radar_status_change_players" );
    else
    {
        while ( var_0.size < 2 )
        {
            level waittill( "radar_status_change",  var_1  );
            var_0[var_0.size] = var_1;
        }
    }

    level notify( "start_com_exp" );
}

_ID34629( var_0 )
{
    var_1 = _ID15280( var_0 );
    var_2 = var_1 == 1;
    var_3 = var_1 >= 2;
    var_4 = var_1 >= 3;
    var_5 = var_1 >= 4;

    if ( var_3 )
        unblockteamradar( var_0 );

    if ( var_4 )
        level.radarmode[var_0] = "fast_radar";
    else
        level.radarmode[var_0] = "normal_radar";

    foreach ( var_7 in level._ID23303 )
    {
        if ( !isdefined( var_7 ) )
            continue;

        if ( var_7.team != var_0 )
            continue;

        var_7._ID29856 = var_2;
        var_7 seteyesonuplinkenabled( var_2 );
        var_7.radarmode = level.radarmode[var_7.team];
        var_7.radarshowenemydirection = var_5;
        var_7 updatesatcomactiveomnvar( var_0 );
        wait 0.05;
    }

    setteamradar( var_0, var_3 );
    level notify( "radar_status_change",  var_0  );
}

_ID34580()
{
    foreach ( var_1 in level._ID23303 )
    {
        if ( !isdefined( var_1 ) )
            continue;

        var_2 = getradarstrengthforplayer( var_1 );
        _ID28830( var_1, var_2 );
        var_1 updatesatcomactiveomnvar();
        wait 0.05;
    }

    level notify( "radar_status_change_players" );
}

_ID34523()
{
    level waittill( "start_com_exp" );

    foreach ( var_1 in level._ID23303 )
    {
        if ( !isdefined( var_1 ) )
            continue;

        var_1 _ID15589();
        wait 0.05;
    }
}

_ID15589()
{
    if ( maps\mp\_utility::_hasperk( "specialty_comexp" ) )
    {
        var_0 = getradarstrengthforcomexp( self );
        _ID28830( self, var_0 );
        updatesatcomactiveomnvar();
    }
}

updatesatcomactiveomnvar( var_0 )
{
    var_1 = 0;

    if ( isdefined( var_0 ) )
        var_1 = _ID15280( var_0 );
    else
        var_1 = getradarstrengthforplayer( self );

    if ( maps\mp\_utility::_hasperk( "specialty_comexp" ) )
        var_1 = getradarstrengthforcomexp( self );

    if ( var_1 > 0 )
        self setclientomnvar( "ui_satcom_active", 1 );
    else
        self setclientomnvar( "ui_satcom_active", 0 );
}

_ID25986()
{
    self._ID29856 = 0;
    self seteyesonuplinkenabled( 0 );
    self.radarshowenemydirection = 0;
    self.radarmode = "normal_radar";
    self.hasradar = 0;
    self.isradarblocked = 0;
}

_ID28830( var_0, var_1 )
{
    var_2 = var_1 == 1;
    var_3 = var_1 >= 2;
    var_4 = var_1 >= 3;
    var_5 = var_1 >= 4;
    var_0._ID29856 = var_2;
    var_0 seteyesonuplinkenabled( var_2 );
    var_0.radarshowenemydirection = var_5;
    var_0.radarmode = "normal_radar";
    var_0.hasradar = var_3;
    var_0.isradarblocked = 0;

    if ( var_4 )
        var_0.radarmode = "fast_radar";
}

tryuseuplink( var_0, var_1 )
{
    var_2 = maps\mp\killstreaks\_unk1556::_ID15615( var_1 );

    if ( var_2 )
        maps\mp\_matchdata::_ID20253( "uplink", self.origin );

    self._ID18582 = undefined;
    return var_2;
}

_ID22786( var_0 )
{
    var_1 = self getentitynumber();

    if ( isdefined( level._ID34657[var_1] ) )
        _ID31863();
}

_ID22874( var_0 )
{
    var_1 = level._ID23658[var_0];
    self.owner notify( "uplink_deployed" );
    self setmodel( var_1.modelbase );
    self._ID17429 = 0;
    self setotherent( self.owner );
    common_scripts\utility::_ID20489( self.owner.team, 1 );
    self.config = var_1;
    _ID31483( 1 );
    thread _ID36063();
}

_ID31483( var_0 )
{
    adduplinktolevellist( self );
    thread playuplinkanimations( var_0 );
    self playloopsound( self.config.activesfx );
}

_ID31863()
{
    maps\mp\gametypes\_weapons::_ID31835();
    self scriptmodelclearanim();

    if ( isdefined( self.bombsquadmodel ) )
        self.bombsquadmodel scriptmodelclearanim();

    _ID26043( self );
    self stoploopsound();
}
#using_animtree("animated_props");

playuplinkanimations( var_0 )
{
    self endon( "emp_damage" );
    self endon( "death" );
    self endon( "carried" );

    if ( var_0 )
    {
        var_1 = getnotetracktimes( %satcom_killstreak, "stop anim" );
        var_2 = getanimlength( %satcom_killstreak );
        self scriptmodelplayanim( "Satcom_killStreak" );

        if ( isdefined( self.bombsquadmodel ) )
            self.bombsquadmodel scriptmodelplayanim( "Satcom_killStreak" );

        wait(var_1[0] * var_2);
    }

    self scriptmodelplayanim( "Satcom_killStreak_idle" );

    if ( isdefined( self.bombsquadmodel ) )
        self.bombsquadmodel scriptmodelplayanim( "Satcom_killStreak_idle" );

    thread maps\mp\gametypes\_weapons::doblinkinglight( "tag_fx" );
}

_ID22805( var_0, var_1, var_2, var_3 )
{
    var_1 notify( "destroyed_equipment" );
}

ondeath( var_0, var_1, var_2, var_3 )
{
    maps\mp\gametypes\_weapons::_ID31835();
    maps\mp\gametypes\_weapons::equipmentdeathvfx();
    _ID26043( self );
    self scriptmodelclearanim();

    if ( !self._ID17429 )
        wait 3.0;

    maps\mp\gametypes\_weapons::equipmentdeletevfx();
}

adduplinktolevellist( var_0 )
{
    var_1 = var_0 getentitynumber();
    level._ID34657[var_1] = var_0;
    level notify( "update_uplink" );
}

_ID26043( var_0 )
{
    var_1 = var_0 getentitynumber();
    level._ID34657[var_1] = undefined;
    level notify( "update_uplink" );
}

_ID15280( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in level._ID34657 )
    {
        if ( isdefined( var_3 ) && var_3.team == var_0 )
            var_1++;
    }

    if ( var_1 == 0 && isdefined( level.helisnipereyeson ) && level.helisnipereyeson.team == var_0 )
        var_1++;

    return clamp( var_1, 0, 4 );
}

getradarstrengthforplayer( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in level._ID34657 )
    {
        if ( isdefined( var_3 ) )
        {
            if ( isdefined( var_3.owner ) )
            {
                if ( var_3.owner._ID15851 == var_0._ID15851 )
                    var_1++;

                continue;
            }

            var_4 = var_3 getentitynumber();
            level._ID34657[var_4] = undefined;
        }
    }

    if ( !level._ID32653 && var_1 > 0 )
        var_1++;

    return clamp( var_1, 0, 4 );
}

getradarstrengthforcomexp( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in level._ID34657 )
    {
        if ( isdefined( var_3 ) )
            var_1++;
    }

    if ( !level._ID32653 && var_1 > 0 )
        var_1++;

    return clamp( var_1, 0, 4 );
}

uplink_override_moving_platform_death( var_0 )
{
    self._ID17429 = 1;
    self notify( "death" );
}

_ID36063()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "emp_damage",  var_0, var_1  );
        maps\mp\gametypes\_weapons::equipmentempstunvfx();
        _ID31863();
        wait(var_1);
        _ID31483( 0 );
    }
}

_ID34659()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "player_spawned",  var_0  );
        var_1 = isdefined( var_0._ID29856 ) && var_0._ID29856;
        var_0 seteyesonuplinkenabled( var_1 );
    }
}
