// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["lasedStrike"] = ::_ID33854;
    level._ID22393 = 2;
    level._ID19403 = loadfx( "fx/misc/laser_glow" );
    level._ID19402 = loadfx( "fx/explosions/uav_advanced_death" );
    var_0 = getentarray( "remoteMissileSpawn", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.target ) )
            var_2._ID32605 = getent( var_2.target, "targetname" );
    }

    level._ID19401 = var_0;
    thread _ID22877();
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread onplayerspawned();
        var_0._ID30381 = 0;
        var_0._ID16418 = 0;
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
        self waittill( "spawned_player" );
}

_ID33854( var_0, var_1 )
{
    return _ID34754();
}

_ID34754()
{
    var_0 = _ID36131();

    if ( isdefined( var_0 ) && var_0 )
    {
        self._ID16418 = 0;
        return 1;
    }
    else
        return 0;
}

givemarker()
{
    maps\mp\killstreaks\_killstreaks::givekillstreakweapon( "iw5_soflam_mp" );
    self._ID16418 = 1;
    thread _ID36131();
}

_ID36131()
{
    self notify( "watchSoflamUsage" );
    self endon( "watchSoflamUsage" );
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );

    while ( maps\mp\_utility::_ID18585() )
        wait 0.05;

    for (;;)
    {
        if ( self attackbuttonpressed() && self getcurrentweapon() == "iw5_soflam_mp" && self adsbuttonpressed() )
        {
            self weaponlocktargettooclose( 0 );
            self weaponlockfree();
            var_0 = _ID15396();

            if ( !isdefined( var_0 ) )
            {
                wait 0.05;
                continue;
            }

            if ( !isdefined( var_0[0] ) )
            {
                wait 0.05;
                continue;
            }

            var_1 = var_0[0];
            var_2 = _ID4117( var_1 );

            if ( var_2 )
                self._ID30381++;

            if ( self._ID30381 >= level._ID22393 )
                return 1;
        }

        if ( maps\mp\_utility::_ID18585() )
            return 0;

        wait 0.05;
    }
}

playlocksound()
{
    if ( isdefined( self._ID24608 ) && self._ID24608 )
        return;

    self playlocalsound( "javelin_clu_lock" );
    self._ID24608 = 1;
    wait 0.75;
    self stoplocalsound( "javelin_clu_lock" );
    self._ID24608 = 0;
}

_ID24612()
{
    if ( isdefined( self._ID24608 ) && self._ID24608 )
        return;

    self playlocalsound( "javelin_clu_aquiring_lock" );
    self._ID24608 = 1;
    wait 0.75;
    self stoplocalsound( "javelin_clu_aquiring_lock" );
    self._ID24608 = 0;
}

_ID4117( var_0 )
{
    var_1 = undefined;
    var_2 = undefined;
    var_3 = 6000;
    var_4 = ( 0, 0, var_3 );
    var_5 = 3000;
    var_6 = anglestoforward( self.angles );
    var_7 = self.origin;
    var_8 = var_7 + var_4 + var_6 * var_5 * -1;
    var_9 = 0;
    var_10 = bullettrace( var_0 + ( 0, 0, var_3 ), var_0, 0 );

    if ( var_10["fraction"] > 0.99 )
    {
        var_9 = 1;
        var_8 = var_0 + ( 0, 0, var_3 );
    }

    if ( !var_9 )
    {
        var_10 = bullettrace( var_0 + ( 300, 0, var_3 ), var_0, 0 );

        if ( var_10["fraction"] > 0.99 )
        {
            var_9 = 1;
            var_8 = var_0 + ( 300, 0, var_3 );
        }
    }

    if ( !var_9 )
    {
        var_10 = bullettrace( var_0 + ( 0, 300, var_3 ), var_0, 0 );

        if ( var_10["fraction"] > 0.99 )
        {
            var_9 = 1;
            var_8 = var_0 + ( 0, 300, var_3 );
        }
    }

    if ( !var_9 )
    {
        var_10 = bullettrace( var_0 + ( 0, -300, var_3 ), var_0, 0 );

        if ( var_10["fraction"] > 0.99 )
        {
            var_9 = 1;
            var_8 = var_0 + ( 0, -300, var_3 );
        }
    }

    if ( !var_9 )
    {
        var_10 = bullettrace( var_0 + ( 300, 300, var_3 ), var_0, 0 );

        if ( var_10["fraction"] > 0.99 )
        {
            var_9 = 1;
            var_8 = var_0 + ( 300, 300, var_3 );
        }
    }

    if ( !var_9 )
    {
        var_10 = bullettrace( var_0 + ( -300, 0, var_3 ), var_0, 0 );

        if ( var_10["fraction"] > 0.99 )
        {
            var_9 = 1;
            var_8 = var_0 + ( -300, 0, var_3 );
        }
    }

    if ( !var_9 )
    {
        var_10 = bullettrace( var_0 + ( -300, -300, var_3 ), var_0, 0 );

        if ( var_10["fraction"] > 0.99 )
        {
            var_9 = 1;
            var_8 = var_0 + ( -300, -300, var_3 );
        }
    }

    if ( !var_9 )
    {
        var_10 = bullettrace( var_0 + ( 300, -300, var_3 ), var_0, 0 );

        if ( var_10["fraction"] > 0.99 )
        {
            var_9 = 1;
            var_8 = var_0 + ( 300, -300, var_3 );
        }
    }

    if ( !var_9 )
    {
        for ( var_11 = 0; var_11 < 5; var_11++ )
        {
            var_3 /= 2;
            var_4 = ( 0, 0, var_3 );
            var_8 = self.origin + var_4 + var_6 * var_5 * -1;
            var_12 = bullettrace( var_0, var_8, 0 );

            if ( var_12["fraction"] > 0.99 )
            {
                var_9 = 1;
                break;
            }

            wait 0.05;
        }
    }

    if ( !var_9 )
    {
        for ( var_11 = 0; var_11 < 5; var_11++ )
        {
            var_3 *= 2.5;
            var_4 = ( 0, 0, var_3 );
            var_8 = self.origin + var_4 + var_6 * var_5 * -1;
            var_12 = bullettrace( var_0, var_8, 0 );

            if ( var_12["fraction"] > 0.99 )
            {
                var_9 = 1;
                break;
            }

            wait 0.05;
        }
    }

    if ( !var_9 )
    {
        thread canthittarget();
        return 0;
    }

    var_1 = spawnfx( level._ID19403, var_0 );
    thread playlocksound();
    self weaponlockfinalize( var_0, ( 0, 0, 0 ), 0 );
    var_13 = magicbullet( "lasedStrike_missile_mp", var_8, var_0, self );
    var_13 missile_settargetent( var_1 );
    thread _ID20361( var_1, var_13 );
    var_13 waittill( "death" );

    if ( isdefined( var_1 ) )
        var_1 delete();

    self weaponlockfree();
    return 1;
}

_ID20361( var_0, var_1 )
{
    var_1 endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        triggerfx( var_0 );
        wait 0.05;
    }
}

_ID19396( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "remote_done" );
    self endon( "death" );

    for (;;)
    {
        var_1 = distance( self.origin, var_0._ID32605.origin );
        var_0.owner setclientdvar( "ui_reaper_targetDistance", int( var_1 / 12 ) );
        wait 0.05;
    }
}

canthittarget()
{
    thread _ID24612();
    self weaponlocktargettooclose( 1 );
}

_ID7061( var_0, var_1 )
{
    foreach ( var_3 in level._ID19401 )
    {
        var_4 = bullettrace( var_3.origin, var_1, 0, var_0 );

        if ( var_4["fraction"] >= 0.98 )
            return var_3;

        wait 0.05;
    }

    return;
}

_ID15396()
{
    var_0 = self geteye();
    var_1 = self getplayerangles();
    var_2 = anglestoforward( var_1 );
    var_3 = var_0 + var_2 * 15000;
    var_4 = bullettrace( var_0, var_3, 0, undefined );

    if ( var_4["surfacetype"] == "none" )
        return undefined;

    if ( var_4["surfacetype"] == "default" )
        return undefined;

    var_5 = var_4["entity"];

    if ( isdefined( var_5 ) )
    {
        if ( var_5 == level.ac130.planemodel )
            return undefined;
    }

    var_6 = [];
    var_6[0] = var_4["position"];
    var_6[1] = var_4["normal"];
    return var_6;
}

_ID30909( var_0 )
{
    var_1 = spawnplane( var_0, "script_model", level._ID34167 gettagorigin( "tag_origin" ), "compass_objpoint_reaper_friendly", "compass_objpoint_reaper_enemy" );

    if ( !isdefined( var_1 ) )
        return undefined;

    var_1 setmodel( "vehicle_predator_b" );
    var_1.team = var_0.team;
    var_1.owner = var_0;
    var_1._ID22406 = 2;
    var_1 setcandamage( 1 );
    var_1 thread _ID8985();
    var_1._ID16760 = "remote_mortar";
    var_1._ID34170 = "remote_mortar";
    var_1 maps\mp\killstreaks\_uav::adduavmodel();
    var_2 = 6300;
    var_3 = randomint( 360 );
    var_4 = 6100;
    var_5 = cos( var_3 ) * var_4;
    var_6 = sin( var_3 ) * var_4;
    var_7 = vectornormalize( ( var_5, var_6, var_2 ) );
    var_7 *= 6100;
    var_1 linkto( level._ID34167, "tag_origin", var_7, ( 0, var_3 - 90, 10 ) );
    var_1 thread _ID16245( var_0 );
    var_1 thread _ID16269( var_0 );
    var_1 thread _ID16270( var_0 );
    var_1 thread _ID16285();
    var_1 thread _ID16259();
    var_1 thread _ID16258();
    return var_1;
}

_ID16245( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    self endon( "remote_removed" );
    self endon( "remote_done" );
    self waittill( "death" );
    level thread _ID26027( self, 1 );
}

_ID16269( var_0 )
{
    level endon( "game_ended" );
    self endon( "remote_done" );
    self endon( "death" );
    var_0 endon( "disconnect" );
    var_0 endon( "removed_reaper_ammo" );
    var_0 common_scripts\utility::_ID35626( "joined_team", "joined_spectators" );
    thread _ID25817();
}

_ID16270( var_0 )
{
    level endon( "game_ended" );
    self endon( "remote_done" );
    self endon( "death" );
    var_0 endon( "removed_reaper_ammo" );
    var_0 waittill( "disconnect" );
    thread _ID25817();
}

_ID29786()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "remote_done" );
    var_0 = 0;

    for (;;)
    {
        self waittill( "lasedTargetShotFired" );
        var_0++;

        if ( var_0 >= 5 )
            break;
    }

    thread _ID25817();
}

_ID16285()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "remote_done" );
    wait 120;
    thread _ID25817();
}

_ID26027( var_0, var_1 )
{
    self notify( "remote_removed" );

    if ( isdefined( var_0._ID32605 ) )
        var_0._ID32605 delete();

    level._ID19397 = 0;
    level._ID19398 = 0;

    if ( isdefined( var_0 ) )
    {
        var_0 delete();
        var_0 maps\mp\killstreaks\_uav::_ID26039();
    }

    if ( !isdefined( var_1 ) || var_1 == 1 )
        level._ID25747 = undefined;
}

_ID25817()
{
    level._ID25747 = undefined;
    level endon( "game_ended" );
    self endon( "death" );
    self notify( "remote_done" );
    var_0 = self.origin + anglestoforward( self.angles ) * 20000;
    self moveto( var_0, 30 );
    playfxontag( level._ID1644["ac130_engineeffect"], self, "tag_origin" );
    maps\mp\gametypes\_hostmigration::_ID35597( 3 );
    self moveto( var_0, 4, 4, 0.0 );
    maps\mp\gametypes\_hostmigration::_ID35597( 4 );
    level thread _ID26027( self, 0 );
}

_ID25814()
{
    self notify( "death" );
    self hide();
    var_0 = anglestoright( self.angles ) * 200;
    playfx( level._ID19402, self.origin, var_0 );
    level._ID19397 = 0;
    level._ID19398 = 0;
}

_ID8985()
{
    level endon( "game_ended" );
    self.owner endon( "disconnect" );
    self.health = 999999;
    self.maxhealth = 1500;
    self.damagetaken = 0;

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( !maps\mp\gametypes\_weapons::_ID13695( self.owner, var_1 ) )
            continue;

        if ( !isdefined( self ) )
            return;

        if ( isdefined( var_8 ) && var_8 & level.idflags_penetration )
            self._ID35910 = 1;

        self._ID35908 = 1;
        var_10 = var_0;

        if ( isplayer( var_1 ) )
        {
            var_1 maps\mp\gametypes\_damagefeedback::_ID34528( "" );

            if ( var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET" )
            {
                if ( var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
                    var_10 += var_0 * level.armorpiercingmod;
            }
        }

        if ( isdefined( var_9 ) )
        {
            switch ( var_9 )
            {
                case "stinger_mp":
                case "javelin_mp":
                    self._ID19345 = 1;
                    var_10 = self.maxhealth + 1;
                    break;
                case "sam_projectile_mp":
                    self._ID19345 = 1;
                    break;
            }

            maps\mp\killstreaks\_killstreaks::_ID19257( var_1, var_9, self );
        }

        self.damagetaken = self.damagetaken + var_10;

        if ( isdefined( self.owner ) )
            self.owner playlocalsound( "reaper_damaged" );

        if ( self.damagetaken >= self.maxhealth )
        {
            if ( isplayer( var_1 ) && ( !isdefined( self.owner ) || var_1 != self.owner ) )
            {
                var_1 notify( "destroyed_killstreak",  var_9  );
                thread maps\mp\_utility::_ID32672( "callout_destroyed_remote_mortar", var_1 );
                var_1 thread maps\mp\gametypes\_rank::giverankxp( "kill", 50, var_9, var_4 );
                var_1 thread maps\mp\gametypes\_rank::_ID36462( "destroyed_remote_mortar" );
                thread maps\mp\gametypes\_missions::vehiclekilled( self.owner, self, undefined, var_1, var_0, var_4, var_9 );
            }

            if ( isdefined( self.owner ) )
                self.owner stoplocalsound( "missile_incoming" );

            thread _ID25814();
            level._ID25747 = undefined;
            return;
        }
    }
}

_ID16259()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "remote_done" );

    for (;;)
    {
        level waittill( "stinger_fired",  var_0, var_1, var_2  );

        if ( !isdefined( var_2 ) || var_2 != self )
            continue;

        var_1 thread _ID31742( var_2, var_0 );
    }
}

_ID31742( var_0, var_1 )
{
    self endon( "death" );
    var_0 endon( "death" );

    if ( isdefined( var_0.owner ) )
        var_0.owner playlocalsound( "missile_incoming" );

    self missile_settargetent( var_0 );
    var_2 = distance( self.origin, var_0 getpointinbounds( 0, 0, 0 ) );
    var_3 = var_0 getpointinbounds( 0, 0, 0 );

    for (;;)
    {
        if ( !isdefined( var_0 ) )
            var_4 = var_3;
        else
            var_4 = var_0 getpointinbounds( 0, 0, 0 );

        var_3 = var_4;
        var_5 = distance( self.origin, var_4 );

        if ( var_5 < 3000 && var_0._ID22406 > 0 )
        {
            var_0._ID22406--;
            var_0 thread maps\mp\killstreaks\_flares::flares_playfx();
            var_6 = var_0 maps\mp\killstreaks\_flares::_ID13265();
            self missile_settargetent( var_6 );
            var_0 = var_6;

            if ( isdefined( var_0.owner ) )
                var_0.owner stoplocalsound( "missile_incoming" );

            return;
        }

        if ( var_5 < var_2 )
            var_2 = var_5;

        if ( var_5 > var_2 )
        {
            if ( var_5 > 1536 )
                return;

            if ( isdefined( var_0.owner ) )
            {
                var_0.owner stoplocalsound( "missile_incoming" );

                if ( level._ID32653 )
                {
                    if ( var_0.team != var_1.team )
                        radiusdamage( self.origin, 1000, 1000, 1000, var_1, "MOD_EXPLOSIVE", "stinger_mp" );
                }
                else
                    radiusdamage( self.origin, 1000, 1000, 1000, var_1, "MOD_EXPLOSIVE", "stinger_mp" );
            }

            self hide();
            wait 0.05;
            self delete();
        }

        wait 0.05;
    }
}

_ID16258()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "remote_done" );

    for (;;)
    {
        level waittill( "sam_fired",  var_0, var_1, var_2  );

        if ( !isdefined( var_2 ) || var_2 != self )
            continue;

        level thread samproximitydetonate( var_2, var_0, var_1 );
    }
}

samproximitydetonate( var_0, var_1, var_2 )
{
    var_0 endon( "death" );

    if ( isdefined( var_0.owner ) )
        var_0.owner playlocalsound( "missile_incoming" );

    var_3 = 150;
    var_4 = 1000;
    var_5 = [];

    for ( var_6 = 0; var_6 < var_2.size; var_6++ )
    {
        if ( isdefined( var_2[var_6] ) )
        {
            var_5[var_6] = distance( var_2[var_6].origin, var_0 getpointinbounds( 0, 0, 0 ) );
            continue;
        }

        var_5[var_6] = undefined;
    }

    for (;;)
    {
        var_7 = var_0 getpointinbounds( 0, 0, 0 );
        var_8 = [];

        for ( var_6 = 0; var_6 < var_2.size; var_6++ )
        {
            if ( isdefined( var_2[var_6] ) )
                var_8[var_6] = distance( var_2[var_6].origin, var_7 );
        }

        for ( var_6 = 0; var_6 < var_8.size; var_6++ )
        {
            if ( isdefined( var_8[var_6] ) )
            {
                if ( var_8[var_6] < 3000 && var_0._ID22406 > 0 )
                {
                    var_0._ID22406--;
                    var_0 thread maps\mp\killstreaks\_flares::flares_playfx();
                    var_9 = var_0 maps\mp\killstreaks\_flares::_ID13265();

                    for ( var_10 = 0; var_10 < var_2.size; var_10++ )
                    {
                        if ( isdefined( var_2[var_10] ) )
                            var_2[var_10] missile_settargetent( var_9 );
                    }

                    if ( isdefined( var_0.owner ) )
                        var_0.owner stoplocalsound( "missile_incoming" );

                    return;
                }

                if ( var_8[var_6] < var_5[var_6] )
                    var_5[var_6] = var_8[var_6];

                if ( var_8[var_6] > var_5[var_6] )
                {
                    if ( var_8[var_6] > 1536 )
                        continue;

                    if ( isdefined( var_0.owner ) )
                    {
                        var_0.owner stoplocalsound( "missile_incoming" );

                        if ( level._ID32653 )
                        {
                            if ( var_0.team != var_1.team )
                                radiusdamage( var_2[var_6].origin, var_4, var_3, var_3, var_1, "MOD_EXPLOSIVE", "sam_projectile_mp" );
                        }
                        else
                            radiusdamage( var_2[var_6].origin, var_4, var_3, var_3, var_1, "MOD_EXPLOSIVE", "sam_projectile_mp" );
                    }

                    var_2[var_6] hide();
                    wait 0.05;
                    var_2[var_6] delete();
                }
            }
        }

        wait 0.05;
    }
}
