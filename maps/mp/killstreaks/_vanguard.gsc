// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    _ID29179();
    _ID29180();
    level._ID25810 = [];
    level._ID19256["vanguard"] = ::tryusevanguard;
    level._ID34858 = 0;
    level.vanguardfiremisslefunc = ::_ID34851;
    level._ID19403 = loadfx( "fx/misc/laser_glow" );
}

_ID29179()
{
    level._ID34853["hit"] = loadfx( "fx/impacts/large_metal_painted_hit" );
    level._ID34853["smoke"] = loadfx( "fx/smoke/remote_heli_damage_smoke_runner" );
    level._ID34853["explode"] = loadfx( "vfx/gameplay/explosions/vehicle/vang/vfx_exp_vanguard" );
    level._ID34853["target_marker_circle"] = loadfx( "vfx/gameplay/mp/core/vfx_marker_gryphon_orange" );
}

_ID29180()
{
    level._ID38248 = getentarray( "remote_heli_range", "targetname" );
    level._ID34884 = getent( "airstrikeheight", "targetname" );

    if ( isdefined( level._ID34884 ) )
    {
        level._ID34883 = level._ID34884.origin[2];
        level._ID34886 = 163840000;
    }

    level._ID37536 = 0;

    if ( maps\mp\_utility::getmapname() == "mp_descent" || maps\mp\_utility::getmapname() == "mp_descent_new" )
    {
        level._ID34883 = level._ID38248[0].origin[2] + 360;
        level._ID37536 = 1;
    }
}

tryusevanguard( var_0, var_1 )
{
    return _ID34783( var_0, var_1 );
}

_ID34783( var_0, var_1 )
{
    if ( maps\mp\_utility::_ID18837() || self isusingturret() )
        return 0;

    if ( isdefined( self.underwater ) && self.underwater )
        return 0;

    if ( _ID12355( self.team ) || level._ID20086.size >= 4 )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }
    else if ( maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 + 1 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        return 0;
    }
    else if ( isdefined( self.drones_disabled ) )
    {
        self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE" );
        return 0;
    }

    maps\mp\_utility::_ID17543();
    var_2 = _ID15586( var_0, var_1 );

    if ( !isdefined( var_2 ) )
    {
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    if ( !maps\mp\_utility::_ID18363() )
        maps\mp\_matchdata::_ID20253( var_1, self.origin );

    return _ID31487( var_2, var_1, var_0 );
}

_ID12355( var_0 )
{
    if ( level._ID32653 )
        return isdefined( level._ID25810[var_0] );
    else
        return isdefined( level._ID25810[var_0] ) || isdefined( level._ID25810[level._ID23070[var_0]] );
}

findvalidvanguardspawnpoint( var_0, var_1 )
{
    var_2 = anglestoforward( self.angles );
    var_3 = anglestoright( self.angles );
    var_4 = self geteye();
    var_5 = var_4 + ( 0, 0, var_1 );
    var_6 = var_5 + var_0 * var_2;

    if ( checkvanguardspawnpoint( var_4, var_6 ) )
        return var_6;

    var_6 = var_5 - var_0 * var_2;

    if ( checkvanguardspawnpoint( var_4, var_6 ) )
        return var_6;

    var_6 += var_0 * var_3;

    if ( checkvanguardspawnpoint( var_4, var_6 ) )
        return var_6;

    var_6 = var_5 - var_0 * var_3;

    if ( checkvanguardspawnpoint( var_4, var_6 ) )
        return var_6;

    var_6 = var_5;

    if ( checkvanguardspawnpoint( var_4, var_6 ) )
        return var_6;

    common_scripts\utility::_ID35582();
    var_6 = var_5 + 0.707 * var_0 * ( var_2 + var_3 );

    if ( checkvanguardspawnpoint( var_4, var_6 ) )
        return var_6;

    var_6 = var_5 + 0.707 * var_0 * ( var_2 - var_3 );

    if ( checkvanguardspawnpoint( var_4, var_6 ) )
        return var_6;

    var_6 = var_5 + 0.707 * var_0 * ( var_3 - var_2 );

    if ( checkvanguardspawnpoint( var_4, var_6 ) )
        return var_6;

    var_6 = var_5 + 0.707 * var_0 * ( -1 * var_2 - var_3 );

    if ( checkvanguardspawnpoint( var_4, var_6 ) )
        return var_6;

    return undefined;
}

checkvanguardspawnpoint( var_0, var_1 )
{
    var_2 = 0;

    if ( capsuletracepassed( var_1, 20, 40.01, undefined, 1, 1 ) )
        var_2 = bullettracepassed( var_0, var_1, 0, undefined );

    return var_2;
}

_ID15586( var_0, var_1, var_2 )
{
    var_3 = maps\mp\gametypes\_spawnscoring::finddronepathnode( self, 90, 20, 192 );

    if ( !isdefined( var_3 ) )
    {
        var_3 = maps\mp\gametypes\_spawnscoring::finddronepathnode( self, 0, 20, 192 );

        if ( !isdefined( var_3 ) )
        {
            var_3 = findvalidvanguardspawnpoint( 80, 35 );

            if ( !isdefined( var_3 ) )
                var_3 = findvalidvanguardspawnpoint( 80, 0 );
        }
    }

    if ( isdefined( var_3 ) )
    {
        var_4 = self.angles;
        var_5 = _ID8494( var_0, self, var_1, var_3, var_4, var_2 );

        if ( !isdefined( var_5 ) )
            self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );

        return var_5;
    }
    else
    {
        self iprintlnbold( &"KILLSTREAKS_VANGUARD_NO_SPAWN_POINT" );
        return undefined;
    }
}

_ID31487( var_0, var_1, var_2 )
{
    maps\mp\_utility::_ID29199( var_1 );
    maps\mp\_utility::_ID13582( 1 );
    self._ID26200 = self.angles;

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::_ID28902( 0 );

    thread _ID36091( var_0 );
    var_3 = maps\mp\killstreaks\_killstreaks::_ID17993( "vanguard" );

    if ( var_3 != "success" )
    {
        var_0 notify( "death" );
        return 0;
    }
    else if ( !isdefined( var_0 ) )
        return 0;

    maps\mp\_utility::_ID13582( 0 );
    var_0._ID24519 = 1;
    self cameralinkto( var_0, "tag_origin" );
    self remotecontrolvehicle( var_0 );
    var_0.ammocount = 100;
    self._ID25811 = var_2;
    self._ID25826 = var_0;
    thread maps\mp\_utility::_ID32672( "used_vanguard", self );
    return 1;
}

_ID34866( var_0 )
{
    if ( !isdefined( var_0.lasttouchedplatform.destroydroneoncollision ) || var_0.lasttouchedplatform.destroydroneoncollision || !isdefined( self.spawngraceperiod ) || gettime() > self.spawngraceperiod )
        thread handledeathdamage( undefined, undefined, undefined, undefined );
    else
    {
        wait 1.0;
        thread maps\mp\_movers::_ID16164( var_0 );
    }
}

_ID8494( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = spawnhelicopter( var_1, var_3, var_4, "remote_uav_mp", "vehicle_drone_vanguard" );

    if ( !isdefined( var_6 ) )
        return undefined;

    var_6 maps\mp\killstreaks\_helicopter::addtolittlebirdlist();
    var_6 thread maps\mp\killstreaks\_helicopter::_ID26000();
    var_6 makevehiclesolidcapsule( 20, -5, 10 );
    var_6._ID4081 = spawn( "script_model", ( 0, 0, 0 ) );
    var_6._ID4081 setmodel( "tag_origin" );
    var_6._ID4081.angles = ( -90, 0, 0 );
    var_6._ID4081.offset = 4;
    var_7 = spawnturret( "misc_turret", var_6.origin, "ball_drone_gun_mp", 0 );
    var_7 linkto( var_6, "tag_turret_attach", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_7 setmodel( "vehicle_drone_vanguard_gun" );
    var_7 maketurretinoperable();
    var_6._ID33988 = var_7;
    var_7 makeunusable();
    var_6._ID19938 = var_0;
    var_6.team = var_1.team;
    var_6.pers["team"] = var_1.team;
    var_6.owner = var_1;
    var_6 common_scripts\utility::_ID20489( var_1.team );

    if ( issentient( var_6 ) )
        var_6 setthreatbiasgroup( "DogsDontAttack" );

    var_6.health = 999999;
    var_6.maxhealth = 750;
    var_6.damagetaken = 0;
    var_6._ID30272 = 0;
    var_6._ID17629 = 0;
    var_6._ID16760 = "remote_uav";
    var_7.owner = var_1;
    var_7 setentityowner( var_6 );
    var_7 thread maps\mp\gametypes\_weapons::doblinkinglight( "tag_fx1" );
    var_7._ID23270 = var_6;
    var_7.health = 999999;
    var_7.maxhealth = 250;
    var_7.damagetaken = 0;
    level thread _ID34862( var_6 );
    level thread _ID34865( var_6, var_5 );
    level thread _ID34860( var_6 );
    level thread _ID34864( var_6 );
    var_6 thread _ID34880();
    var_6 thread _ID34881();
    var_6 thread _ID34855();
    var_6._ID33988 thread _ID34878();
    var_6 thread _ID36063();
    var_8 = spawn( "script_model", var_6.origin );
    var_8 setscriptmoverkillcam( "explosive" );
    var_8 linkto( var_6, "tag_player", ( -10, 0, 20 ), ( 0, 0, 0 ) );
    var_6._ID19214 = var_8;
    var_6.spawngraceperiod = gettime() + 2000;
    var_9 = spawnstruct();
    var_9._ID34837 = 1;
    var_9.deathoverridecallback = ::_ID34866;
    var_6 thread maps\mp\_movers::_ID16165( var_9 );
    level._ID25810[var_6.team] = var_6;
    return var_6;
}

watchhostmigrationfinishedinit( var_0 )
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    level endon( "game_ended" );
    var_0 endon( "death" );

    for (;;)
    {
        level waittill( "host_migration_end" );
        _ID37504();
        var_0 thread _ID34871();
    }
}

_ID36091( var_0 )
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    self waittill( "intro_cleared" );
    _ID37504();
    var_0 enableaimassist();
    thread _ID34877( var_0 );
    thread _ID34861( var_0 );
    thread _ID34863( var_0 );
    thread _ID34879( var_0 );
    var_0 thread _ID34871();

    if ( !level.hardcoremode )
        var_0 thread _ID34872();

    thread watchhostmigrationfinishedinit( var_0 );
    maps\mp\_utility::_ID13582( 0 );
}

_ID37504()
{
    self thermalvisionfofoverlayon();
    self thermalvisionon();
    self setclientomnvar( "ui_vanguard", 1 );
}

_ID34863( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );
    var_0 thread maps\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit();
    var_0 waittill( "killstreakExit" );

    if ( isdefined( var_0.owner ) )
        var_0.owner maps\mp\_utility::_ID19765( "gryphon_gone" );

    var_0 notify( "death" );
}

_ID34879( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );

    while ( !isdefined( var_0._ID4081 ) )
        wait 0.05;

    var_0 setotherent( var_0._ID4081 );
    var_0 setturrettargetent( var_0._ID4081 );
}

_ID34877( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );

    for (;;)
    {
        if ( var_0 maps\mp\_utility::_ID33165( "gryphon" ) )
            var_0 notify( "damage",  1019, self, self.angles, self.origin, "MOD_EXPLOSIVE", undefined, undefined, undefined, undefined, "c4_mp"  );

        self._ID20184 = var_0._ID4081.origin;
        common_scripts\utility::_ID35582();
    }
}

_ID34871()
{
    playfxontagforclients( level._ID34853["target_marker_circle"], self._ID4081, "tag_origin", self.owner );
    thread vanguard_showreticletoenemies();
}

_ID34872()
{
    self endon( "death" );
    self endon( "end_remote" );

    for (;;)
    {
        level waittill( "joined_team",  var_0  );
        stopfxontag( level._ID34853["target_marker_circle"], self._ID4081, "tag_origin" );
        common_scripts\utility::_ID35582();
        _ID34871();
    }
}

vanguard_showreticletoenemies()
{
    self endon( "death" );
    self endon( "end_remote" );

    if ( !level.hardcoremode )
    {
        foreach ( var_1 in level.players )
        {
            if ( self.owner maps\mp\_utility::isenemy( var_1 ) )
            {
                common_scripts\utility::_ID35582();
                playfxontagforclients( level._ID34853["target_marker_circle"], self._ID4081, "tag_origin", var_1 );
            }
        }
    }
}

_ID34875( var_0 )
{
    var_1 = _ID15396( var_0.owner, var_0 );

    if ( isdefined( var_1 ) )
    {
        var_0._ID4081.origin = var_1[0] + ( 0, 0, 4 );
        return var_1[0];
    }

    return undefined;
}

_ID15396( var_0, var_1 )
{
    var_2 = var_1._ID33988 gettagorigin( "tag_flash" );
    var_3 = var_0 getplayerangles();
    var_4 = anglestoforward( var_3 );
    var_5 = var_2 + var_4 * 15000;
    var_6 = bullettrace( var_2, var_5, 0, var_1 );

    if ( var_6["surfacetype"] == "none" )
        return undefined;

    if ( var_6["surfacetype"] == "default" )
        return undefined;

    var_7 = var_6["entity"];
    var_8 = [];
    var_8[0] = var_6["position"];
    var_8[1] = var_6["normal"];
    return var_8;
}

_ID34861( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );
    self notifyonplayercommand( "vanguard_fire", "+attack" );
    self notifyonplayercommand( "vanguard_fire", "+attack_akimbo_accessible" );
    var_0.firereadytime = gettime();

    for (;;)
    {
        self waittill( "vanguard_fire" );
        maps\mp\gametypes\_hostmigration::_ID35770();

        if ( isdefined( level.hostmigrationtimer ) )
            continue;

        if ( isdefined( self._ID20184 ) && gettime() >= var_0.firereadytime )
            self thread [[ level.vanguardfiremisslefunc ]]( var_0, self._ID20184 );
    }
}

_ID34874( var_0, var_1, var_2 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );
    var_0 notify( "end_rumble" );
    var_0 endon( "end_rumble" );

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        self playrumbleonentity( var_1 );
        common_scripts\utility::_ID35582();
    }
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

_ID34851( var_0, var_1 )
{
    level endon( "game_ended" );

    if ( var_0.ammocount <= 0 )
        return;

    var_2 = var_0._ID33988 gettagorigin( "tag_fire" );
    var_2 += ( 0, 0, -25 );

    if ( distancesquared( var_2, var_1 ) < 10000 )
    {
        var_0 playsoundtoplayer( "weap_vanguard_fire_deny", self );
        return;
    }

    var_0.ammocount--;
    self playlocalsound( "weap_gryphon_fire_plr" );
    maps\mp\_utility::_ID24644( "weap_gryphon_fire_npc", var_0.origin );
    thread _ID34874( var_0, "shotgun_fire", 1 );
    earthquake( 0.3, 0.25, var_0.origin, 60 );
    var_3 = magicbullet( "remote_tank_projectile_mp", var_2, var_1, self );
    var_3._ID35007 = var_0;
    var_4 = 1500;
    var_0.firereadytime = gettime() + var_4;
    thread _ID38236( var_0, var_4 * 0.001 );
    var_3 maps\mp\gametypes\_hostmigration::_ID35709( "death", 4 );
    earthquake( 0.3, 0.75, var_1, 128 );

    if ( isdefined( var_0 ) )
    {
        earthquake( 0.25, 0.75, var_0.origin, 60 );
        thread _ID34874( var_0, "damage_heavy", 3 );

        if ( var_0.ammocount == 0 )
        {
            wait 0.75;
            var_0 notify( "death" );
        }
    }
}

_ID38236( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );
    self setclientomnvar( "ui_vanguard_ammo", -1 );
    wait(var_1);
    self setclientomnvar( "ui_vanguard_ammo", var_0.ammocount );
}

_ID15370( var_0, var_1 )
{
    var_2 = ( 3000, 3000, 3000 );
    var_3 = vectornormalize( var_0.origin - var_1 + ( 0, 0, -400 ) );
    var_4 = rotatevector( var_3, ( 0, 25, 0 ) );
    var_5 = var_1 + var_4 * var_2;

    if ( _ID18858( var_5, var_1 ) )
        return var_5;

    var_4 = rotatevector( var_3, ( 0, -25, 0 ) );
    var_5 = var_1 + var_4 * var_2;

    if ( _ID18858( var_5, var_1 ) )
        return var_5;

    var_5 = var_1 + var_3 * var_2;

    if ( _ID18858( var_5, var_1 ) )
        return var_5;

    return var_1 + ( 0, 0, 3000 );
}

_ID18858( var_0, var_1 )
{
    var_2 = bullettrace( var_0, var_1, 0 );

    if ( var_2["fraction"] > 0.99 )
        return 1;

    return 0;
}

_ID34880()
{
    self endon( "death" );
    var_0 = self.origin;
    self._ID25414 = 0;

    for (;;)
    {
        if ( !isdefined( self ) )
            return;

        if ( !isdefined( self.owner ) )
            return;

        if ( !_ID34856() )
        {
            while ( !_ID34856() )
            {
                if ( !isdefined( self ) )
                    return;

                if ( !isdefined( self.owner ) )
                    return;

                if ( !self._ID25414 )
                {
                    self._ID25414 = 1;
                    thread _ID34869();
                }

                if ( isdefined( self._ID16734 ) )
                    var_1 = distance( self.origin, self._ID16734.origin );
                else if ( isdefined( level.disablevanguardsinair ) )
                    var_1 = 467.5;
                else
                    var_1 = distance( self.origin, var_0 );

                var_2 = _ID37365( var_1 );
                self.owner setclientomnvar( "ui_vanguard", var_2 );
                wait 0.1;
            }

            self notify( "in_range" );
            self._ID25414 = 0;
            self.owner setclientomnvar( "ui_vanguard", 1 );
        }

        var_3 = int( angleclamp( self.angles[1] ) );
        self.owner setclientomnvar( "ui_vanguard_heading", var_3 );
        var_4 = self.origin[2] * 0.0254;
        var_4 = int( clamp( var_4, -250, 250 ) );
        self.owner setclientomnvar( "ui_vanguard_altitude", var_4 );
        var_5 = distance2d( self.origin, self._ID4081.origin ) * 0.0254;
        var_5 = int( clamp( var_5, 0, 256 ) );
        self.owner setclientomnvar( "ui_vanguard_range", var_5 );
        var_0 = self.origin;
        wait 0.1;
    }
}

_ID37365( var_0 )
{
    var_0 = clamp( var_0, 50, 550 );
    return 2 + int( 8 * ( var_0 - 50 ) / 500 );
}

_ID34856()
{
    if ( isdefined( self._ID17629 ) && self._ID17629 )
        return 0;

    if ( isdefined( level.disablevanguardsinair ) )
        return 0;

    if ( isdefined( level._ID38248[0] ) )
    {
        foreach ( var_1 in level._ID38248 )
        {
            if ( self istouching( var_1 ) )
                return 0;
        }

        if ( level._ID37536 )
            return self.origin[2] < level._ID34883;
        else
            return 1;
    }
    else if ( distance2dsquared( self.origin, level._ID20634 ) < level._ID34886 && self.origin[2] < level._ID34883 )
        return 1;

    return 0;
}

_ID34869()
{
    self endon( "death" );
    self endon( "in_range" );

    if ( isdefined( self._ID16734 ) )
        var_0 = 3;
    else
        var_0 = 6;

    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    self notify( "death",  "range_death"  );
}

_ID34862( var_0 )
{
    var_0 endon( "death" );
    var_0.owner common_scripts\utility::_ID35626( "killstreak_disowned" );
    var_0 notify( "death" );
}

_ID34865( var_0, var_1 )
{
    var_0 endon( "death" );
    var_2 = 60;

    if ( !maps\mp\_utility::_ID18363() )
    {

    }
    else
        var_2 = var_1;

    maps\mp\gametypes\_hostmigration::_ID35597( var_2 );

    if ( isdefined( var_0.owner ) )
        var_0.owner maps\mp\_utility::_ID19765( "gryphon_gone" );

    var_0 notify( "death" );
}

_ID34860( var_0 )
{
    level endon( "game_ended" );
    level endon( "objective_cam" );
    var_1 = var_0._ID33988;
    var_0 waittill( "death" );
    var_0 maps\mp\gametypes\_weapons::_ID31835();
    stopfxontag( level._ID34853["target_marker_circle"], var_0._ID4081, "tag_origin" );
    playfx( level._ID34853["explode"], var_0.origin );
    var_0 playsound( "ball_drone_explode" );
    var_1 delete();

    if ( isdefined( var_0._ID32604 ) )
        var_0._ID32604 delete();

    _ID34850( var_0.owner, var_0 );
}

_ID34864( var_0 )
{
    var_0 endon( "death" );
    level common_scripts\utility::_ID35626( "objective_cam", "game_ended" );
    playfx( level._ID34853["explode"], var_0.origin );
    var_0 playsound( "ball_drone_explode" );
    _ID34850( var_0.owner, var_0 );
}

_ID34850( var_0, var_1 )
{
    var_1 notify( "end_remote" );
    var_1._ID24519 = 0;
    var_1 setotherent( undefined );
    _ID34870( var_0, var_1 );
    stopfxontag( level._ID34853["smoke"], var_1, "tag_origin" );
    level._ID25810[var_1.team] = undefined;
    maps\mp\_utility::decrementfauxvehiclecount();

    if ( isdefined( var_1._ID19214 ) )
        var_1._ID19214 delete();

    var_1._ID4081 delete();
    var_1 delete();
}

_ID26212()
{
    self visionsetnakedforplayer( "", 1 );
    maps\mp\_utility::set_visionset_for_watching_players( "", 1 );
}

_ID34870( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_0 maps\mp\_utility::_ID7513();
    var_0 _ID26212();
    var_0 setclientomnvar( "ui_vanguard", 0 );

    if ( getdvarint( "camera_thirdPerson" ) )
        var_0 maps\mp\_utility::_ID28902( 1 );

    var_0 cameraunlink( var_1 );
    var_0 remotecontrolvehicleoff( var_1 );
    var_0 thermalvisionoff();
    var_0 thermalvisionfofoverlayoff();
    var_0 setplayerangles( var_0._ID26200 );
    var_0._ID25826 = undefined;

    if ( var_0.team == "spectator" )
        return;

    level thread _ID34852( var_0 );
}

_ID34852( var_0 )
{
    var_0 endon( "disconnect" );
    var_0 endon( "death" );
    level endon( "game_ended" );
    var_0 maps\mp\_utility::_ID13582( 1 );
    wait 0.5;
    var_0 maps\mp\_utility::_ID13582( 0 );
}

_ID34881()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "end_remote" );

    for (;;)
    {
        var_0 = 0;

        foreach ( var_2 in level._ID16755 )
        {
            if ( distance( var_2.origin, self.origin ) < 300 )
            {
                var_0 = 1;
                self._ID16734 = var_2;
            }
        }

        foreach ( var_5 in level._ID20086 )
        {
            if ( var_5 != self && ( !isdefined( var_5._ID16760 ) || var_5._ID16760 != "remote_uav" ) && distance( var_5.origin, self.origin ) < 300 )
            {
                var_0 = 1;
                self._ID16734 = var_5;
            }
        }

        if ( !self._ID17629 && var_0 )
            self._ID17629 = 1;
        else if ( self._ID17629 && !var_0 )
        {
            self._ID17629 = 0;
            self._ID16734 = undefined;
        }

        wait 0.05;
    }
}

_ID34855()
{
    self endon( "death" );
    level endon( "game_ended" );
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );
        maps\mp\gametypes\_damage::_ID21372( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, "remote_uav", ::handledeathdamage, ::modifydamage, 1 );
    }
}

_ID34878()
{
    self endon( "death" );
    level endon( "game_ended" );
    self maketurretsolid();
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( isdefined( self._ID23270 ) )
            self._ID23270 maps\mp\gametypes\_damage::_ID21372( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, "remote_uav", ::handledeathdamage, ::modifydamage, 1 );
    }
}

modifydamage( var_0, var_1, var_2, var_3 )
{
    var_4 = var_3;
    var_4 = maps\mp\gametypes\_damage::handleempdamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::_ID16266( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handlegrenadedamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleapdamage( var_1, var_2, var_4, var_0 );

    if ( var_2 == "MOD_MELEE" )
        var_4 = self.maxhealth * 0.34;

    playfxontagforclients( level._ID34853["hit"], self, "tag_origin", self.owner );

    if ( self._ID30272 == 0 && self.damagetaken >= self.maxhealth / 2 )
    {
        self._ID30272 = 1;
        playfxontag( level._ID34853["smoke"], self, "tag_origin" );
    }

    return var_4;
}

handledeathdamage( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self.owner ) )
        self.owner maps\mp\_utility::_ID19765( "gryphon_destroyed" );

    maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, "destroyed_vanguard", undefined, "callout_destroyed_vanguard" );

    if ( isdefined( var_0 ) )
    {
        var_0 maps\mp\gametypes\_missions::_ID25038( "ch_gryphondown" );
        maps\mp\gametypes\_missions::checkaachallenges( var_0, self, var_1 );
    }
}

_ID36063()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "emp_damage",  var_0, var_1  );
        stopfxontag( level._ID34853["target_marker_circle"], self._ID4081, "tag_origin" );
        common_scripts\utility::_ID35582();
        thread vanguard_showreticletoenemies();
        playfxontag( common_scripts\utility::_ID15033( "emp_stun" ), self, "tag_origin" );
        wait(var_1);
        stopfxontag( level._ID34853["target_marker_circle"], self._ID4081, "tag_origin" );
        common_scripts\utility::_ID35582();
        thread _ID34871();
    }
}
