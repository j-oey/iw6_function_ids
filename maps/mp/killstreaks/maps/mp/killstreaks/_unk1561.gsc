// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID25748["laserTarget"] = loadfx( "fx/misc/laser_glow" );
    level._ID25748["missileExplode"] = loadfx( "fx/explosions/bouncing_betty_explosion" );
    level._ID25748["deathExplode"] = loadfx( "fx/explosions/uav_advanced_death" );
    level._ID19256["remote_mortar"] = ::_ID33869;
    level._ID25747 = undefined;
}

_ID33869( var_0, var_1 )
{
    if ( isdefined( level._ID25747 ) )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    maps\mp\_utility::_ID29199( "remote_mortar" );
    var_2 = maps\mp\killstreaks\_killstreaks::_ID17993( "remote_mortar" );

    if ( var_2 != "success" )
    {
        if ( var_2 != "disconnect" )
            maps\mp\_utility::_ID7513();

        return 0;
    }
    else if ( isdefined( level._ID25747 ) )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        maps\mp\_utility::_ID7513();
        return 0;
    }

    maps\mp\_matchdata::_ID20253( "remote_mortar", self.origin );
    return _ID31471( var_0 );
}

_ID31471( var_0 )
{
    var_1 = _ID30909( var_0, self );

    if ( !isdefined( var_1 ) )
        return 0;

    level._ID25747 = var_1;
    remoteride( var_1 );
    thread maps\mp\_utility::_ID32672( "used_remote_mortar", self );
    return 1;
}

_ID30909( var_0, var_1 )
{
    var_2 = spawnplane( var_1, "script_model", level._ID34167 gettagorigin( "tag_origin" ), "compass_objpoint_reaper_friendly", "compass_objpoint_reaper_enemy" );

    if ( !isdefined( var_2 ) )
        return undefined;

    var_2 setmodel( "vehicle_predator_b" );
    var_2._ID19938 = var_0;
    var_2.team = var_1.team;
    var_2.owner = var_1;
    var_2._ID22406 = 1;
    var_2 setcandamage( 1 );
    var_2 thread _ID8985();
    var_2._ID16760 = "remote_mortar";
    var_2._ID34170 = "remote_mortar";
    var_2 maps\mp\killstreaks\_uav::adduavmodel();
    var_3 = 6300;
    var_4 = randomint( 360 );
    var_5 = 6100;
    var_6 = cos( var_4 ) * var_5;
    var_7 = sin( var_4 ) * var_5;
    var_8 = vectornormalize( ( var_6, var_7, var_3 ) );
    var_8 *= 6100;
    var_2 linkto( level._ID34167, "tag_origin", var_8, ( 0, var_4 - 90, 10 ) );
    var_1 setclientdvar( "ui_reaper_targetDistance", -1 );
    var_1 setclientdvar( "ui_reaper_ammoCount", 14 );
    var_2 thread _ID16245( var_1 );
    var_2 thread _ID16285( var_1 );
    var_2 thread _ID16269( var_1 );
    var_2 thread _ID16270( var_1 );
    var_2 thread _ID16259();
    var_2 thread _ID16258();
    return var_2;
}

_ID20306( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    wait 0.05;
    var_1 = vectortoangles( level._ID34167.origin - var_0 gettagorigin( "tag_player" ) );
    self setplayerangles( var_1 );
}

remoteride( var_0 )
{
    maps\mp\_utility::_giveweapon( "mortar_remote_mp" );
    self switchtoweapon( "mortar_remote_mp" );
    thread _ID35606( 1.0, var_0 );
    thread maps\mp\_utility::_ID25727( var_0 );

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::_ID28902( 0 );

    self playerlinkweaponviewtodelta( var_0, "tag_player", 1.0, 40, 40, 25, 40 );
    thread _ID20306( var_0 );
    common_scripts\utility::_disableweaponswitch();
    thread _ID25824( var_0 );
    thread remotefiring( var_0 );
    thread _ID25867( var_0 );
}

_ID35606( var_0, var_1 )
{
    self endon( "disconnect" );
    var_1 endon( "death" );
    wait(var_0);
    self visionsetthermalforplayer( level.ac130.enhanced_vision, 0 );
    self.lastvisionsetthermal = level.ac130.enhanced_vision;
    self thermalvisionfofoverlayon();
}

_ID25824( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "remote_done" );
    var_0 endon( "death" );
    var_0._ID32605 = spawnfx( level._ID25748["laserTarget"], ( 0, 0, 0 ) );

    for (;;)
    {
        var_1 = self geteye();
        var_2 = anglestoforward( self getplayerangles() );
        var_3 = var_1 + var_2 * 15000;
        var_4 = bullettrace( var_1, var_3, 0, var_0._ID32605 );

        if ( isdefined( var_4["position"] ) )
        {
            var_0._ID32605.origin = var_4["position"];
            triggerfx( var_0._ID32605 );
        }

        wait 0.05;
    }
}

remotefiring( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "remote_done" );
    var_0 endon( "death" );
    var_1 = gettime();
    var_2 = var_1 - 2200;
    var_3 = 14;
    self.firingreaper = 0;

    for (;;)
    {
        var_1 = gettime();

        if ( self attackbuttonpressed() && var_1 - var_2 > 3000 )
        {
            var_3--;
            self setclientdvar( "ui_reaper_ammoCount", var_3 );
            var_2 = var_1;
            self.firingreaper = 1;
            self playlocalsound( "reaper_fire" );
            self playrumbleonentity( "damage_heavy" );
            var_4 = self geteye();
            var_5 = anglestoforward( self getplayerangles() );
            var_6 = anglestoright( self getplayerangles() );
            var_7 = var_4 + var_5 * 100 + var_6 * -100;
            var_8 = magicbullet( "remote_mortar_missile_mp", var_7, var_0._ID32605.origin, self );
            var_8.type = "remote_mortar";
            earthquake( 0.3, 0.5, var_4, 256 );
            var_8 missile_settargetent( var_0._ID32605 );
            var_8 missile_setflightmodedirect();
            var_8 thread _ID25820( var_0 );
            var_8 thread _ID25822( var_0 );
            var_8 waittill( "death" );
            self setclientdvar( "ui_reaper_targetDistance", -1 );
            self.firingreaper = 0;

            if ( var_3 == 0 )
                break;

            continue;
        }

        wait 0.05;
    }

    self notify( "removed_reaper_ammo" );
    _ID25813( var_0 );
    var_0 thread _ID25817();
}

_ID16286( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "remote_done" );
    var_0 endon( "death" );
    self notifyonplayercommand( "remote_mortar_toggleZoom1", "+ads_akimbo_accessible" );

    if ( !level.console )
        self notifyonplayercommand( "remote_mortar_toggleZoom1", "+toggleads_throw" );

    for (;;)
    {
        var_1 = common_scripts\utility::_ID35635( "remote_mortar_toggleZoom1" );

        if ( !isdefined( self._ID25749 ) )
            self._ID25749 = 0;

        self._ID25749 = 1 - self._ID25749;
    }
}

_ID25867( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "remote_done" );
    var_0 endon( "death" );
    self._ID25749 = undefined;
    thread _ID16286( var_0 );
    var_0._ID36598 = 0;
    var_1 = 0;

    for (;;)
    {
        if ( self adsbuttonpressed() )
        {
            wait 0.05;

            if ( isdefined( self._ID25749 ) )
                var_1 = 1;

            break;
        }

        wait 0.05;
    }

    for (;;)
    {
        if ( !var_1 && self adsbuttonpressed() || var_1 && self._ID25749 )
        {
            if ( var_0._ID36598 == 0 )
            {
                maps\mp\_utility::_giveweapon( "mortar_remote_zoom_mp" );
                self switchtoweapon( "mortar_remote_zoom_mp" );
                var_0._ID36598 = 1;
            }
        }
        else if ( !var_1 && !self adsbuttonpressed() || var_1 && !self._ID25749 )
        {
            if ( var_0._ID36598 == 1 )
            {
                maps\mp\_utility::_giveweapon( "mortar_remote_mp" );
                self switchtoweapon( "mortar_remote_mp" );
                var_0._ID36598 = 0;
            }
        }

        wait 0.05;
    }
}

_ID25820( var_0 )
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

_ID25822( var_0 )
{
    self endon( "death" );
    maps\mp\gametypes\_hostmigration::_ID35597( 6 );
    playfx( level._ID25748["missileExplode"], self.origin );
    self delete();
}

_ID25813( var_0 )
{
    if ( !maps\mp\_utility::_ID18837() )
        return;

    if ( isdefined( var_0 ) )
        var_0 notify( "helicopter_done" );

    self thermalvisionoff();
    self thermalvisionfofoverlayoff();
    self visionsetthermalforplayer( game["thermal_vision"], 0 );
    maps\mp\_utility::_ID26201( 0 );
    self unlink();
    maps\mp\_utility::_ID7513();

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::_ID28902( 1 );

    self switchtoweapon( common_scripts\utility::_ID15114() );
    var_1 = maps\mp\_utility::getkillstreakweapon( "remote_mortar" );
    self takeweapon( var_1 );
    self takeweapon( "mortar_remote_zoom_mp" );
    self takeweapon( "mortar_remote_mp" );
    common_scripts\utility::_enableweaponswitch();
}

_ID16285( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 endon( "removed_reaper_ammo" );
    self endon( "death" );
    var_1 = 40.0;
    maps\mp\gametypes\_hostmigration::_ID35597( var_1 );

    while ( var_0.firingreaper )
        wait 0.05;

    if ( isdefined( var_0 ) )
        var_0 _ID25813( self );

    thread _ID25817();
}

_ID16245( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    self endon( "remote_removed" );
    self endon( "remote_done" );
    self waittill( "death" );

    if ( isdefined( var_0 ) )
        var_0 _ID25813( self );

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

    if ( isdefined( var_0 ) )
        var_0 _ID25813( self );

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

_ID26027( var_0, var_1 )
{
    self notify( "remote_removed" );

    if ( isdefined( var_0._ID32605 ) )
        var_0._ID32605 delete();

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
    self unlink();
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
    playfx( level._ID25748["deathExplode"], self.origin, var_0 );
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
