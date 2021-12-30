// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["drone_hive"] = ::_ID33846;
    level.dronemissilespawnarray = getentarray( "remoteMissileSpawn", "targetname" );

    foreach ( var_1 in level.dronemissilespawnarray )
        var_1._ID32605 = getent( var_1.target, "targetname" );
}

_ID33846( var_0, var_1 )
{
    return _ID34743( self, var_0 );
}

_ID34743( var_0, var_1 )
{
    if ( isdefined( self.underwater ) && self.underwater )
        return 0;

    var_0 maps\mp\_utility::_ID29199( "remotemissile" );
    var_0 maps\mp\_utility::_ID13582( 1 );
    var_0 common_scripts\utility::_disableweaponswitch();
    level thread _ID21375( var_0 );
    level thread _ID21392( var_0 );
    level thread _ID21425( var_0 );
    var_2 = var_0 maps\mp\killstreaks\_killstreaks::_ID17993( "drone_hive" );

    if ( var_2 == "success" )
    {
        var_0 maps\mp\_utility::_ID13582( 0 );
        level thread _ID27018( var_0, var_1 );
    }
    else
    {
        var_0 notify( "end_kill_streak" );
        var_0 maps\mp\_utility::_ID7513();
        var_0 common_scripts\utility::_enableweaponswitch();
    }

    return var_2 == "success";
}

watchhostmigrationstartedinit( var_0 )
{
    var_0 endon( "killstreak_disowned" );
    var_0 endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "death" );

    for (;;)
    {
        level waittill( "host_migration_begin" );

        if ( isdefined( self ) )
        {
            var_0 visionsetmissilecamforplayer( game["thermal_vision"], 0 );
            var_0 maps\mp\_utility::set_visionset_for_watching_players( "default", 0, undefined, 1 );
            var_0 thermalvisionfofoverlayon();
            continue;
        }

        var_0 setclientomnvar( "ui_predator_missile", 2 );
    }
}

watchhostmigrationfinishedinit( var_0 )
{
    var_0 endon( "killstreak_disowned" );
    var_0 endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "death" );

    for (;;)
    {
        level waittill( "host_migration_end" );

        if ( isdefined( self ) )
        {
            var_0 setclientomnvar( "ui_predator_missile", 1 );
            var_0 setclientomnvar( "ui_predator_missiles_left", self.missilesleft );
            continue;
        }

        var_0 setclientomnvar( "ui_predator_missile", 2 );
    }
}

_ID27018( var_0, var_1 )
{
    var_0 endon( "killstreak_disowned" );
    level endon( "game_ended" );
    var_0 notifyonplayercommand( "missileTargetSet", "+attack" );
    var_0 notifyonplayercommand( "missileTargetSet", "+attack_akimbo_accessible" );
    var_2 = _ID14908( var_0, level.dronemissilespawnarray );
    var_3 = var_2.origin;
    var_4 = var_2._ID32605.origin;
    var_5 = vectornormalize( var_3 - var_4 );
    var_3 = var_5 * 14000 + var_4;
    var_6 = magicbullet( "drone_hive_projectile_mp", var_3, var_4, var_0 );
    var_6 setcandamage( 1 );
    var_6 disablemissileboosting();
    var_6 setmissileminimapvisible( 1 );
    var_6.team = var_0.team;
    var_6._ID19938 = var_1;
    var_6.type = "remote";
    var_6.owner = var_0;
    var_6.entitynumber = var_6 getentitynumber();
    level._ID26359[var_6.entitynumber] = var_6;
    level._ID25821 = 1;
    level thread _ID21373( var_6, 1 );
    level thread _ID21365( var_6 );

    if ( isdefined( var_0.killsthislifeperweapon ) )
    {
        var_0.killsthislifeperweapon["drone_hive_projectile_mp"] = 0;
        var_0.killsthislifeperweapon["switch_blade_child_mp"] = 0;
    }

    _ID21187( var_0, var_6 );
    var_0 setclientomnvar( "ui_predator_missile", 1 );
    var_6 thread watchhostmigrationstartedinit( var_0 );
    var_6 thread watchhostmigrationfinishedinit( var_0 );
    var_7 = 0;
    var_6.missilesleft = 2;
    var_0 setclientomnvar( "ui_predator_missiles_left", 2 );

    for (;;)
    {
        var_8 = var_6 common_scripts\utility::_ID35635( "death", "missileTargetSet" );
        maps\mp\gametypes\_hostmigration::_ID35770();

        if ( var_8 == "death" )
            break;

        if ( !isdefined( var_6 ) )
            break;

        if ( var_7 < 2 )
        {
            level thread _ID30914( var_6, var_7 );
            var_7++;
            var_6.missilesleft = 2 - var_7;
            var_0 setclientomnvar( "ui_predator_missiles_left", var_6.missilesleft );

            if ( var_7 == 2 )
                var_6 enablemissileboosting();
        }
    }

    thread _ID26247( var_0 );
}

_ID21411()
{
    level endon( "game_ended" );
    self endon( "death" );
    var_0 = [];
    var_1 = [];

    for (;;)
    {
        var_2 = [];
        var_0 = _ID15001();

        foreach ( var_4 in var_0 )
        {
            var_5 = self.owner worldpointinreticle_circle( var_4.origin, 65, 90 );

            if ( var_5 )
            {
                self.owner thread maps\mp\_utility::_ID10878( self.origin, var_4.origin, 10, ( 0, 0, 1 ) );
                var_2[var_2.size] = var_4;
            }
        }

        if ( var_2.size )
        {
            var_1 = sortbydistance( var_2, self.origin );
            self._ID19654 = var_1[0];
            maps\mp\gametypes\_hostmigration::_ID35597( 0.25 );
        }

        wait 0.05;
        maps\mp\gametypes\_hostmigration::_ID35770();
    }
}

_ID15001( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level._ID23303 )
    {
        if ( var_0 maps\mp\_utility::isenemy( var_3 ) && !var_3 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
            var_1[var_1.size] = var_3;
    }

    var_5 = maps\mp\gametypes\_weapons::_ID20194();

    if ( var_1.size && var_5.size )
    {
        var_6 = common_scripts\utility::array_combine( var_1, var_5 );
        return var_6;
    }
    else if ( var_1.size )
        return var_1;
    else
        return var_5;
}

_ID30914( var_0, var_1 )
{
    var_0.owner playlocalsound( "ammo_crate_use" );
    var_2 = var_0 gettagangles( "tag_camera" );
    var_3 = anglestoforward( var_2 );
    var_4 = anglestoright( var_2 );
    var_5 = ( 35, 35, 35 );
    var_6 = ( 15000, 15000, 15000 );

    if ( var_1 )
        var_5 *= -1;

    var_7 = bullettrace( var_0.origin, var_0.origin + var_3 * var_6, 0, var_0 );
    var_6 *= var_7["fraction"];
    var_8 = var_0.origin + var_4 * var_5;
    var_9 = var_0.origin + var_3 * var_6;
    var_10 = var_0.owner _ID15001( var_0.owner );
    var_11 = magicbullet( "switch_blade_child_mp", var_8, var_9, var_0.owner );

    foreach ( var_13 in var_10 )
    {
        if ( distance2dsquared( var_13.origin, var_9 ) < 262144 )
        {
            var_11 missile_settargetent( var_13 );
            break;
        }
    }

    var_11 setcandamage( 1 );
    var_11 setmissileminimapvisible( 1 );
    var_11.team = var_0.team;
    var_11._ID19938 = var_0._ID19938;
    var_11.type = var_0.type;
    var_11.owner = var_0.owner;
    var_11.entitynumber = var_11 getentitynumber();
    level._ID26359[var_11.entitynumber] = var_11;
    level thread _ID21373( var_11, 0 );
}

_ID20361( var_0, var_1 )
{
    var_1 endon( "death" );
    level endon( "game_ended" );
    self endon( "death" );

    for (;;)
    {
        triggerfx( var_0 );
        wait 0.25;
    }
}

getnextmissilespawnindex( var_0 )
{
    var_1 = var_0 + 1;

    if ( var_1 == level.dronemissilespawnarray.size )
        var_1 = 0;

    return var_1;
}

_ID21365( var_0 )
{
    var_0 endon( "death" );

    for (;;)
    {
        var_0.owner waittill( "missileTargetSet" );
        var_0 notify( "missileTargetSet" );
    }
}

_ID14908( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in level.players )
    {
        if ( !maps\mp\_utility::_ID18757( var_4 ) )
            continue;

        if ( var_4.team == var_0.team )
            continue;

        if ( var_4.team == "spectator" )
            continue;

        var_2[var_2.size] = var_4;
    }

    if ( !var_2.size )
        return var_1[randomint( var_1.size )];

    var_6 = common_scripts\utility::array_randomize( var_1 );
    var_7 = var_6[0];

    foreach ( var_9 in var_6 )
    {
        var_9._ID30026 = 0;

        for ( var_10 = 0; var_10 < var_2.size; var_10++ )
        {
            var_11 = var_2[var_10];

            if ( !maps\mp\_utility::_ID18757( var_11 ) )
            {
                var_2[var_10] = var_2[var_2.size - 1];
                var_2[var_2.size - 1] = undefined;
                var_10--;
                continue;
            }

            if ( bullettracepassed( var_11.origin + ( 0, 0, 32 ), var_9.origin, 0, var_11 ) )
            {
                var_9._ID30026 = var_9._ID30026 + 1;
                return var_9;
            }

            wait 0.05;
            maps\mp\gametypes\_hostmigration::_ID35770();
        }

        if ( var_9._ID30026 == var_2.size )
            return var_9;

        if ( var_9._ID30026 > var_7._ID30026 )
            var_7 = var_9;
    }

    return var_7;
}

_ID21187( var_0, var_1 )
{
    var_2 = 1.0;
    var_0 maps\mp\_utility::_ID13582( 1 );
    var_0 cameralinkto( var_1, "tag_origin" );
    var_0 controlslinkto( var_1 );
    var_0 visionsetmissilecamforplayer( "default", var_2 );
    var_0 thread maps\mp\_utility::set_visionset_for_watching_players( "default", var_2, undefined, 1 );
    var_0 visionsetmissilecamforplayer( game["thermal_vision"], 1.0 );
    var_0 thread delayedfofoverlay();
    level thread _ID34208( var_0, var_2 );
}

delayedfofoverlay()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    maps\mp\gametypes\_hostmigration::_ID35597( 0.25 );
    self thermalvisionfofoverlayon();
}

_ID34208( var_0, var_1, var_2 )
{
    var_0 endon( "disconnect" );
    maps\mp\gametypes\_hostmigration::_ID35597( var_1 - 0.35 );
    var_0 maps\mp\_utility::_ID13582( 0 );
}

_ID21375( var_0 )
{
    var_0 endon( "disconnect" );
    var_0 endon( "end_kill_streak" );
    var_0 waittill( "killstreak_disowned" );
    level thread _ID26247( var_0 );
}

_ID21392( var_0 )
{
    var_0 endon( "disconnect" );
    var_0 endon( "end_kill_streak" );
    level waittill( "game_ended" );
    level thread _ID26247( var_0 );
}

_ID21425( var_0 )
{
    var_0 endon( "end_kill_streak" );
    var_0 endon( "disconnect" );
    level waittill( "objective_cam" );
    level thread _ID26247( var_0, 1 );
}

_ID21373( var_0, var_1 )
{
    var_0 waittill( "death" );
    maps\mp\gametypes\_hostmigration::_ID35770();

    if ( isdefined( var_0._ID32573 ) )
        var_0._ID32573 delete();

    if ( isdefined( var_0.entitynumber ) )
        level._ID26359[var_0.entitynumber] = undefined;

    if ( var_1 )
        level._ID25821 = undefined;
}

_ID26247( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_0 setclientomnvar( "ui_predator_missile", 2 );
    var_0 notify( "end_kill_streak" );
    var_0 maps\mp\_utility::_ID13582( 1 );
    var_0 thermalvisionfofoverlayoff();
    var_0 controlsunlink();

    if ( !isdefined( var_1 ) )
        maps\mp\gametypes\_hostmigration::_ID35597( 0.95 );

    var_0 cameraunlink();
    var_0 setclientomnvar( "ui_predator_missile", 0 );
    var_0 maps\mp\_utility::_ID7513();
    var_0 common_scripts\utility::_enableweaponswitch();
}
