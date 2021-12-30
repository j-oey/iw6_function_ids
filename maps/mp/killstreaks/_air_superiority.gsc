// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    var_0 = spawnstruct();
    var_0._ID21275 = [];
    var_0._ID21275["allies"] = "vehicle_a10_warthog_iw6_mp";
    var_0._ID21275["axis"] = "vehicle_a10_warthog_iw6_mp";
    var_0.inboundsfx = "veh_mig29_dist_loop";
    var_0.compassiconfriendly = "compass_objpoint_airstrike_friendly";
    var_0.compassiconenemy = "compass_objpoint_airstrike_busy";
    var_0.speed = 4000;
    var_0._ID15984 = 20000;
    var_0.distfromplayer = 4000;
    var_0.heightrange = 250;
    var_0._ID22413 = 3;
    var_0._ID23072 = "airstrike_mp_roll";
    var_0._ID30440 = "veh_mig29_sonic_boom";
    var_0._ID22773 = ::attackenemyaircraft;
    var_0._ID22844 = ::cleanupflyby;
    var_0._ID36472 = "destroyed_air_superiority";
    var_0.callout = "callout_destroyed_air_superiority";
    var_0._ID35387 = undefined;
    var_0._ID19217 = ( -800, 0, 200 );
    level._ID23699["air_superiority"] = var_0;
    level._ID19256["air_superiority"] = ::_ID22916;
    level._ID32650["axis"] = 0;
    level._ID32650["allies"] = 0;
}

_ID22916( var_0, var_1 )
{
    var_2 = maps\mp\_utility::getotherteam( self.team );

    if ( level._ID32653 && level._ID32650[var_2] || !level._ID32653 && isdefined( level.airdeniedplayer ) && level.airdeniedplayer == self )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }
    else
    {
        thread dostrike( var_0, "air_superiority" );
        maps\mp\_matchdata::_ID20253( "air_superiority", self.origin );
        thread maps\mp\_utility::_ID32672( "used_air_superiority", self );
        return 1;
    }
}

dostrike( var_0, var_1 )
{
    var_2 = level._ID23699[var_1];
    var_3 = maps\mp\killstreaks\_plane::getplaneflightplan( var_2.distfromplayer );
    wait 1;
    var_4 = maps\mp\_utility::getotherteam( self.team );
    level._ID32650[var_4] = 1;
    level.airdeniedplayer = self;
    dooneflyby( var_1, var_0, var_3._ID32619, var_3.flightdir, var_3.height );
    self waittill( "aa_flyby_complete" );
    wait 2;
    maps\mp\gametypes\_hostmigration::_ID35770();

    if ( isdefined( self ) )
    {
        dooneflyby( var_1, var_0, var_3._ID32619, -1 * var_3.flightdir, var_3.height );
        self waittill( "aa_flyby_complete" );
    }

    level._ID32650[var_4] = 0;
    level.airdeniedplayer = undefined;
}

dooneflyby( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = level._ID23699[var_0];
    var_6 = maps\mp\killstreaks\_plane::_ID15022( var_2, var_3, var_5._ID15984, 1, var_4, var_5.speed, -0.5 * var_5._ID15984, var_0 );
    level thread maps\mp\killstreaks\_plane::_ID10390( var_1, self, var_1, var_6["startPoint"] + ( 0, 0, randomint( var_5.heightrange ) ), var_6["endPoint"] + ( 0, 0, randomint( var_5.heightrange ) ), var_6["attackTime"], var_6["flyTime"], var_3, var_0 );
}

attackenemyaircraft( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );
    self.owner endon( "killstreak_disowned" );
    level endon( "game_ended" );
    wait(var_2);
    var_5 = findalltargets( self.owner, self.team );
    var_6 = level._ID23699[var_4];
    var_7 = var_6._ID22413;

    for ( var_8 = var_5.size - 1; var_8 >= 0 && var_7 > 0; var_8-- )
    {
        var_9 = var_5[var_8];

        if ( isdefined( var_9 ) && isalive( var_9 ) )
        {
            _ID13047( var_9 );
            var_7--;
            wait 1;
        }
    }
}

cleanupflyby( var_0, var_1, var_2 )
{
    var_0 notify( "aa_flyby_complete" );
}

findtargetsoftype( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_3 ) )
    {
        foreach ( var_6 in var_3 )
        {
            if ( [[ var_2 ]]( var_0, var_1, var_6 ) )
                var_4._ID32620[var_4._ID32620.size] = var_6;
        }
    }

    return var_4;
}

findalltargets( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2._ID32620 = [];
    var_3 = undefined;

    if ( level._ID32653 )
        var_3 = maps\mp\_utility::_ID18859;
    else
        var_3 = maps\mp\_utility::isvalidffatarget;

    var_4 = undefined;

    if ( isdefined( var_1 ) )
        var_4 = maps\mp\_utility::getotherteam( var_1 );

    findtargetsoftype( var_0, var_4, var_3, level.heli_pilot, var_2 );

    if ( isdefined( level._ID19723 ) )
    {
        if ( [[ var_3 ]]( var_0, var_4, level._ID19723 ) )
            var_2._ID32620[var_2._ID32620.size] = level._ID19723;
    }

    findtargetsoftype( var_0, var_4, var_3, level.planes, var_2 );
    findtargetsoftype( var_0, var_4, var_3, level._ID20086, var_2 );
    findtargetsoftype( var_0, var_4, var_3, level._ID16755, var_2 );
    return var_2._ID32620;
}

_ID13047( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_1 = undefined;

    if ( isdefined( self.owner ) )
        var_1 = self.owner;

    var_2 = 384 * anglestoforward( self.angles );
    var_3 = self gettagorigin( "tag_missile_1" ) + var_2;
    var_4 = magicbullet( "aamissile_projectile_mp", var_3, var_3 + var_2, var_1 );
    var_4._ID35007 = self;
    var_3 = self gettagorigin( "tag_missile_2" ) + var_2;
    var_5 = magicbullet( "aamissile_projectile_mp", var_3, var_3 + var_2, var_1 );
    var_5._ID35007 = self;
    var_6 = [ var_4, var_5 ];
    var_0 notify( "targeted_by_incoming_missile",  var_6  );
    thread startmissileguidance( var_0, 0.25, var_6 );
}

startmissileguidance( var_0, var_1, var_2 )
{
    wait(var_1);

    if ( isdefined( var_0 ) )
    {
        var_3 = undefined;

        if ( var_0.model != "vehicle_av8b_harrier_jet_mp" )
            var_3 = var_0 gettagorigin( "tag_missile_target" );

        if ( !isdefined( var_3 ) )
            var_3 = var_0 gettagorigin( "tag_body" );

        var_4 = var_3 - var_0.origin;

        foreach ( var_6 in var_2 )
        {
            if ( isvalidmissile( var_6 ) )
            {
                var_6 missile_settargetent( var_0, var_4 );
                var_6 missile_setflightmodedirect();
            }
        }
    }
}

_ID9792( var_0, var_1 )
{
    maps\mp\killstreaks\_killstreaks::destroytargetarray( var_0, var_1, "aamissile_projectile_mp", level._ID16755 );
    maps\mp\killstreaks\_killstreaks::destroytargetarray( var_0, var_1, "aamissile_projectile_mp", level._ID20086 );
    maps\mp\killstreaks\_killstreaks::destroytargetarray( var_0, var_1, "aamissile_projectile_mp", level.heli_pilot );

    if ( isdefined( level._ID19723 ) )
    {
        var_2 = [];
        var_2[0] = level._ID19723;
        maps\mp\killstreaks\_killstreaks::destroytargetarray( var_0, var_1, "aamissile_projectile_mp", var_2 );
    }

    maps\mp\killstreaks\_killstreaks::destroytargetarray( var_0, var_1, "aamissile_projectile_mp", level._ID25810 );
    maps\mp\killstreaks\_killstreaks::destroytargetarray( var_0, var_1, "aamissile_projectile_mp", level.planes );
}
