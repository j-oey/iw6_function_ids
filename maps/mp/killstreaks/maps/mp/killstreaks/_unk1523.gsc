// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["ball_drone_radar"] = ::_ID33836;
    level._ID19256["ball_drone_backup"] = ::_ID33836;
    level.balldronesettings = [];
    level.balldronesettings["ball_drone_radar"] = spawnstruct();
    level.balldronesettings["ball_drone_radar"].timeout = 60.0;
    level.balldronesettings["ball_drone_radar"].health = 999999;
    level.balldronesettings["ball_drone_radar"].maxhealth = 500;
    level.balldronesettings["ball_drone_radar"]._ID31889 = "ball_drone_radar";
    level.balldronesettings["ball_drone_radar"]._ID35155 = "ball_drone_mp";
    level.balldronesettings["ball_drone_radar"].modelbase = "vehicle_ball_drone_iw6";
    level.balldronesettings["ball_drone_radar"]._ID32680 = "used_ball_drone_radar";
    level.balldronesettings["ball_drone_radar"]._ID14031 = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ims_sparks" );
    level.balldronesettings["ball_drone_radar"].fxid_explode = loadfx( "vfx/gameplay/explosions/vehicle/ball/vfx_exp_ball_drone" );
    level.balldronesettings["ball_drone_radar"]._ID30472 = "ball_drone_explode";
    level.balldronesettings["ball_drone_radar"]._ID35387 = "nowl_destroyed";
    level.balldronesettings["ball_drone_radar"]._ID35407 = "nowl_gone";
    level.balldronesettings["ball_drone_radar"]._ID36472 = "destroyed_ball_drone_radar";
    level.balldronesettings["ball_drone_radar"]._ID24592 = ::_ID25256;
    level.balldronesettings["ball_drone_radar"]._ID14026 = [];
    level.balldronesettings["ball_drone_radar"].fxid_light2 = [];
    level.balldronesettings["ball_drone_radar"]._ID14028 = [];
    level.balldronesettings["ball_drone_radar"]._ID14029 = [];
    level.balldronesettings["ball_drone_radar"]._ID14026["enemy"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink" );
    level.balldronesettings["ball_drone_radar"].fxid_light2["enemy"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink" );
    level.balldronesettings["ball_drone_radar"]._ID14028["enemy"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink" );
    level.balldronesettings["ball_drone_radar"]._ID14029["enemy"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink" );
    level.balldronesettings["ball_drone_radar"]._ID14026["friendly"] = loadfx( "fx/misc/light_mine_blink_friendly" );
    level.balldronesettings["ball_drone_radar"].fxid_light2["friendly"] = loadfx( "fx/misc/light_mine_blink_friendly" );
    level.balldronesettings["ball_drone_radar"]._ID14028["friendly"] = loadfx( "fx/misc/light_mine_blink_friendly" );
    level.balldronesettings["ball_drone_radar"]._ID14029["friendly"] = loadfx( "fx/misc/light_mine_blink_friendly" );
    level.balldronesettings["ball_drone_backup"] = spawnstruct();
    level.balldronesettings["ball_drone_backup"].timeout = 90.0;
    level.balldronesettings["ball_drone_backup"].health = 999999;
    level.balldronesettings["ball_drone_backup"].maxhealth = 500;
    level.balldronesettings["ball_drone_backup"]._ID31889 = "ball_drone_backup";
    level.balldronesettings["ball_drone_backup"]._ID35155 = "backup_drone_mp";
    level.balldronesettings["ball_drone_backup"].modelbase = "vehicle_drone_backup_buddy";
    level.balldronesettings["ball_drone_backup"]._ID32680 = "used_ball_drone_radar";
    level.balldronesettings["ball_drone_backup"]._ID14031 = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ims_sparks" );
    level.balldronesettings["ball_drone_backup"].fxid_explode = loadfx( "fx/explosions/bouncing_betty_explosion" );
    level.balldronesettings["ball_drone_backup"]._ID30472 = "ball_drone_explode";
    level.balldronesettings["ball_drone_backup"]._ID35387 = "vulture_destroyed";
    level.balldronesettings["ball_drone_backup"]._ID35407 = "vulture_gone";
    level.balldronesettings["ball_drone_backup"]._ID36472 = "destroyed_ball_drone";
    level.balldronesettings["ball_drone_backup"].weaponinfo = "ball_drone_gun_mp";
    level.balldronesettings["ball_drone_backup"]._ID36270 = "vehicle_drone_backup_buddy_gun";
    level.balldronesettings["ball_drone_backup"]._ID36295 = "tag_turret_attach";
    level.balldronesettings["ball_drone_backup"]._ID30491 = "weap_p99_fire_npc";
    level.balldronesettings["ball_drone_backup"]._ID30487 = "ball_drone_targeting";
    level.balldronesettings["ball_drone_backup"]._ID30476 = "ball_drone_lockon";
    level.balldronesettings["ball_drone_backup"].sentrymode = "sentry";
    level.balldronesettings["ball_drone_backup"]._ID35360 = 1440000;
    level.balldronesettings["ball_drone_backup"].burstmin = 10;
    level.balldronesettings["ball_drone_backup"]._ID6331 = 20;
    level.balldronesettings["ball_drone_backup"]._ID23388 = 0.15;
    level.balldronesettings["ball_drone_backup"]._ID23387 = 0.35;
    level.balldronesettings["ball_drone_backup"]._ID20198 = 0.25;
    level.balldronesettings["ball_drone_backup"]._ID24592 = ::backupbuddyplayfx;
    level.balldronesettings["ball_drone_backup"]._ID14026 = [];
    level.balldronesettings["ball_drone_backup"]._ID14026["enemy"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink" );
    level.balldronesettings["ball_drone_backup"]._ID14026["friendly"] = loadfx( "fx/misc/light_mine_blink_friendly" );
    level.balldrones = [];
}

_ID33836( var_0, var_1 )
{
    return useballdrone( var_1 );
}

useballdrone( var_0 )
{
    var_1 = 1;

    if ( maps\mp\_utility::_ID18837() )
        return 0;
    else if ( exceededmaxballdrones() )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }
    else if ( maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 + var_1 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        return 0;
    }
    else if ( isdefined( self.balldrone ) )
    {
        self iprintlnbold( &"KILLSTREAKS_COMPANION_ALREADY_EXISTS" );
        return 0;
    }
    else if ( isdefined( self.drones_disabled ) )
    {
        self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE" );
        return 0;
    }

    maps\mp\_utility::_ID17543();
    var_2 = createballdrone( var_0 );

    if ( !isdefined( var_2 ) )
    {
        if ( maps\mp\_utility::_ID18363() )
            self.drone_failed = 1;
        else
            self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE" );

        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    self.balldrone = var_2;
    thread _ID31427( var_2 );

    if ( var_0 == "ball_drone_backup" && maps\mp\agents\_agent_utility::_ID15194( self, "dog" ) > 0 )
        maps\mp\gametypes\_missions::_ID25038( "ch_twiceasdeadly" );

    return 1;
}

createballdrone( var_0 )
{
    var_1 = self.angles;
    var_2 = anglestoforward( self.angles );
    var_3 = self.origin + var_2 * 100 + ( 0, 0, 90 );
    var_4 = self.origin + ( 0, 0, 90 );
    var_5 = bullettrace( var_4, var_3, 0 );
    var_6 = 3;

    while ( var_5["surfacetype"] != "none" && var_6 > 0 )
    {
        var_3 = self.origin + vectornormalize( var_4 - var_5["position"] ) * 5;
        var_5 = bullettrace( var_4, var_3, 0 );
        var_6--;
        wait 0.05;
    }

    if ( var_6 <= 0 )
        return;

    var_7 = anglestoright( self.angles );
    var_8 = self.origin + var_7 * 20 + ( 0, 0, 90 );
    var_5 = bullettrace( var_3, var_8, 0 );
    var_6 = 3;

    while ( var_5["surfacetype"] != "none" && var_6 > 0 )
    {
        var_8 = var_3 + vectornormalize( var_3 - var_5["position"] ) * 5;
        var_5 = bullettrace( var_3, var_8, 0 );
        var_6--;
        wait 0.05;
    }

    if ( var_6 <= 0 )
        return;

    var_9 = spawnhelicopter( self, var_3, var_1, level.balldronesettings[var_0]._ID35155, level.balldronesettings[var_0].modelbase );

    if ( !isdefined( var_9 ) )
        return;

    var_9 enableaimassist();
    var_9 makevehiclenotcollidewithplayers( 1 );
    var_9 addtoballdronelist();
    var_9 thread _ID25994();
    var_9.health = level.balldronesettings[var_0].health;
    var_9.maxhealth = level.balldronesettings[var_0].maxhealth;
    var_9.damagetaken = 0;
    var_9.speed = 140;
    var_9._ID13465 = 140;
    var_9.owner = self;
    var_9.team = self.team;
    var_9 vehicle_setspeed( var_9.speed, 16, 16 );
    var_9 setyawspeed( 120, 90 );
    var_9 setneargoalnotifydist( 16 );
    var_9.balldronetype = var_0;
    var_9 sethoverparams( 30, 10, 5 );
    var_9 setotherent( self );
    var_9 common_scripts\utility::_ID20489( self.team, var_0 != "ball_drone_backup" );

    if ( issentient( var_9 ) )
        var_9 setthreatbiasgroup( "DogsDontAttack" );

    if ( !maps\mp\_utility::_ID18363() )
    {
        if ( level._ID32653 )
            var_9 maps\mp\_entityheadicons::_ID28896( var_9.team, ( 0, 0, 25 ) );
        else
            var_9 maps\mp\_entityheadicons::_ID28825( var_9.owner, ( 0, 0, 25 ) );
    }

    var_10 = 45;
    var_11 = 45;

    switch ( var_0 )
    {
        case "ball_drone_radar":
            var_10 = 90;
            var_11 = 90;
            var_12 = spawn( "script_model", self.origin );
            var_12.team = self.team;
            var_12 makeportableradar( self );
            var_9._ID25255 = var_12;
            var_9 thread _ID25257();
            var_9.ammo = 99999;
            var_9.cameraoffset = distance( var_9.origin, var_9 gettagorigin( "camera_jnt" ) );
            var_9 thread maps\mp\gametypes\_trophy_system::_ID33737( self );
            var_9 thread balldrone_handledamage();
            break;
        case "ball_drone_backup":
        case "alien_ball_drone":
        case "alien_ball_drone_1":
        case "alien_ball_drone_2":
        case "alien_ball_drone_3":
        case "alien_ball_drone_4":
            var_13 = spawnturret( "misc_turret", var_9 gettagorigin( level.balldronesettings[var_0]._ID36295 ), level.balldronesettings[var_0].weaponinfo );
            var_13 linkto( var_9, level.balldronesettings[var_0]._ID36295 );
            var_13 setmodel( level.balldronesettings[var_0]._ID36270 );
            var_13.angles = var_9.angles;
            var_13.owner = var_9.owner;
            var_13.team = self.team;
            var_13 maketurretinoperable();
            var_13 makeunusable();
            var_13._ID34941 = var_9;
            var_13.health = level.balldronesettings[var_0].health;
            var_13.maxhealth = level.balldronesettings[var_0].maxhealth;
            var_13.damagetaken = 0;
            var_14 = self.origin + var_2 * -100 + ( 0, 0, 40 );
            var_13._ID17384 = spawn( "script_origin", var_14 );
            var_13._ID17384.targetname = "test";
            thread _ID17385( var_13._ID17384 );

            if ( level._ID32653 )
                var_13 setturretteam( self.team );

            var_13 setmode( level.balldronesettings[var_0].sentrymode );
            var_13 setsentryowner( self );
            var_13 setleftarc( 180 );
            var_13 setrightarc( 180 );
            var_13 setbottomarc( 50 );
            var_13 thread _ID4723();
            var_13 setturretminimapvisible( 1, "buddy_turret" );
            var_15 = var_9.origin + ( anglestoforward( var_9.angles ) * -10 + anglestoright( var_9.angles ) * -10 ) + ( 0, 0, 10 );
            var_13._ID19214 = spawn( "script_model", var_15 );
            var_13._ID19214 setscriptmoverkillcam( "explosive" );
            var_13._ID19214 linkto( var_9 );
            var_9._ID33988 = var_13;
            var_13._ID23270 = var_9;
            var_9 thread _ID4724();
            var_9._ID33988 thread _ID4725();
            break;
        default:
            break;
    }

    var_9 setmaxpitchroll( var_10, var_11 );
    var_9._ID32619 = var_8;
    var_9.attract_strength = 10000;
    var_9.attract_range = 150;

    if ( !( maps\mp\_utility::_ID18363() && isdefined( level.script ) && level.script == "mp_alien_last" ) )
        var_9.attractor = missile_createattractorent( var_9, var_9.attract_strength, var_9.attract_range );

    var_9._ID16390 = 0;
    var_9._ID32026 = 0;
    var_9._ID17494 = 0;
    var_9 thread _ID36063();
    var_9 thread balldrone_watchdeath();
    var_9 thread balldrone_watchtimeout();
    var_9 thread balldrone_watchownerloss();
    var_9 thread balldrone_watchownerdeath();
    var_9 thread balldrone_watchroundend();
    var_9 thread balldrone_enemy_lightfx();
    var_9 thread balldrone_friendly_lightfx();
    var_16 = spawnstruct();
    var_16._ID34837 = 1;
    var_16.deathoverridecallback = ::balldrone_moving_platform_death;
    var_9 thread maps\mp\_movers::_ID16165( var_16 );
    var_9.owner maps\mp\_matchdata::_ID20253( level.balldronesettings[var_9.balldronetype]._ID31889, var_9._ID32619 );
    return var_9;
}

balldrone_moving_platform_death( var_0 )
{
    if ( !isdefined( var_0.lasttouchedplatform.destroydroneoncollision ) || var_0.lasttouchedplatform.destroydroneoncollision )
        self notify( "death" );
}

_ID17385( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_1 = anglestoforward( self.angles );

    for (;;)
    {
        if ( maps\mp\_utility::_ID18757( self ) && !maps\mp\_utility::_ID18837() && anglestoforward( self.angles ) != var_1 )
        {
            var_1 = anglestoforward( self.angles );
            var_2 = self.origin + var_1 * -100 + ( 0, 0, 40 );
            var_0 moveto( var_2, 0.5 );
        }

        wait 0.5;
    }
}

balldrone_enemy_lightfx()
{
    self endon( "death" );
    var_0 = level.balldronesettings[self.balldronetype];

    for (;;)
    {
        foreach ( var_2 in level.players )
        {
            if ( isdefined( var_2 ) )
            {
                if ( level._ID32653 )
                {
                    if ( var_2.team != self.team )
                        self [[ var_0._ID24592 ]]( "enemy", var_2 );

                    continue;
                }

                if ( var_2 != self.owner )
                    self [[ var_0._ID24592 ]]( "enemy", var_2 );
            }
        }

        wait 1.0;
    }
}

balldrone_friendly_lightfx()
{
    self endon( "death" );
    var_0 = level.balldronesettings[self.balldronetype];

    foreach ( var_2 in level.players )
    {
        if ( isdefined( var_2 ) )
        {
            if ( level._ID32653 )
            {
                if ( var_2.team == self.team )
                    self [[ var_0._ID24592 ]]( "friendly", var_2 );

                continue;
            }

            if ( var_2 == self.owner )
                self [[ var_0._ID24592 ]]( "friendly", var_2 );
        }
    }

    thread _ID36052();
    thread _ID36093();
}

backupbuddyplayfx( var_0, var_1 )
{
    var_2 = level.balldronesettings[self.balldronetype];
    playfxontagforclients( var_2._ID14026[var_0], self._ID33988, "tag_fx", var_1 );
    playfxontagforclients( var_2._ID14026[var_0], self, "tag_fx", var_1 );
}

_ID25256( var_0, var_1 )
{
    var_2 = level.balldronesettings[self.balldronetype];
    playfxontagforclients( var_2._ID14026[var_0], self, "tag_fx", var_1 );
    playfxontagforclients( var_2.fxid_light2[var_0], self, "tag_fx1", var_1 );
    playfxontagforclients( var_2._ID14028[var_0], self, "tag_fx2", var_1 );
    playfxontagforclients( var_2._ID14029[var_0], self, "tag_fx3", var_1 );
}

_ID36052()
{
    self endon( "death" );

    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 waittill( "spawned_player" );
        var_1 = level.balldronesettings[self.balldronetype];

        if ( isdefined( var_0 ) )
        {
            if ( level._ID32653 )
            {
                if ( var_0.team == self.team )
                    self [[ var_1._ID24592 ]]( "friendly", var_0 );
                else
                    self [[ var_1._ID24592 ]]( "enemy", var_0 );

                continue;
            }

            if ( var_0 == self.owner )
            {
                self [[ var_1._ID24592 ]]( "friendly", var_0 );
                continue;
            }

            self [[ var_1._ID24592 ]]( "enemy", var_0 );
        }
    }
}

_ID36093()
{
    self endon( "death" );

    for (;;)
    {
        level waittill( "joined_team",  var_0  );
        var_0 waittill( "spawned_player" );
        var_1 = level.balldronesettings[self.balldronetype];

        if ( isdefined( var_0 ) )
        {
            if ( level._ID32653 )
            {
                if ( var_0.team == self.team )
                    self [[ var_1._ID24592 ]]( "friendly", var_0 );
                else
                    self [[ var_1._ID24592 ]]( "enemy", var_0 );

                continue;
            }

            if ( var_0 == self.owner )
            {
                self [[ var_1._ID24592 ]]( "friendly", var_0 );
                continue;
            }

            self [[ var_1._ID24592 ]]( "enemy", var_0 );
        }
    }
}

_ID31427( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );

    switch ( var_0.balldronetype )
    {
        case "ball_drone_backup":
        case "alien_ball_drone":
        case "alien_ball_drone_1":
        case "alien_ball_drone_2":
        case "alien_ball_drone_3":
        case "alien_ball_drone_4":
            if ( isdefined( var_0._ID33988 ) && isdefined( var_0._ID33988._ID17384 ) )
                var_0 setlookatent( var_0._ID33988._ID17384 );
            else
                var_0 setlookatent( self );

            break;
        default:
            var_0 setlookatent( self );
            break;
    }

    var_1 = ( 0, 0, 118 );
    var_0 setdronegoalpos( self, var_1 );
    var_0 waittill( "near_goal" );
    var_0 vehicle_setspeed( var_0.speed, 10, 10 );
    var_0 waittill( "goal" );
    var_0 thread balldrone_followplayer();
}

balldrone_followplayer()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );

    if ( !isdefined( self.owner ) )
    {
        thread balldrone_leave();
        return;
    }

    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self vehicle_setspeed( self._ID13465, 10, 10 );
    var_0 = ( 0, 0, 0 );
    var_1 = 4096;
    thread low_entries_watcher();

    for (;;)
    {
        if ( isdefined( self.owner ) && isalive( self.owner ) )
        {
            if ( self.owner.origin != var_0 && distancesquared( self.owner.origin, var_0 ) > var_1 )
            {
                if ( self.balldronetype == "ball_drone_backup" || self.balldronetype == "alien_ball_drone" || self.balldronetype == "alien_ball_drone_1" || self.balldronetype == "alien_ball_drone_2" || self.balldronetype == "alien_ball_drone_3" || self.balldronetype == "alien_ball_drone_4" )
                {
                    if ( !isdefined( self._ID33988 getturrettarget( 0 ) ) )
                    {
                        var_0 = self.owner.origin;
                        _ID4733();
                        continue;
                    }
                }
                else
                {
                    var_0 = self.owner.origin;
                    _ID4733();
                    continue;
                }
            }
        }

        wait 1;
    }
}

_ID4733()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self notify( "ballDrone_moveToPlayer" );
    self endon( "ballDrone_moveToPlayer" );
    var_0 = 40;
    var_1 = 40;
    var_2 = 118;

    switch ( self.owner getstance() )
    {
        case "stand":
            var_2 = 118;
            break;
        case "crouch":
            var_2 = 70;
            break;
        case "prone":
            var_2 = 36;
            break;
    }

    if ( isdefined( self.low_entry ) )
        var_2 *= self.low_entry;

    var_3 = ( var_1, var_0, var_2 );
    self setdronegoalpos( self.owner, var_3 );
    self._ID18110 = 1;
    thread balldrone_watchforgoal();
}

balldrone_watchforgoal()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self notify( "ballDrone_watchForGoal" );
    self endon( "ballDrone_watchForGoal" );
    var_0 = common_scripts\utility::_ID35635( "goal", "near_goal", "hit_goal" );
    self._ID18110 = 0;
    self._ID17494 = 0;
    self notify( "hit_goal" );
}

_ID25257()
{
    level endon( "game_ended" );
    self endon( "death" );

    for (;;)
    {
        if ( isdefined( self._ID32026 ) && self._ID32026 )
        {
            wait 0.5;
            continue;
        }

        if ( isdefined( self._ID17494 ) && self._ID17494 )
        {
            wait 0.5;
            continue;
        }

        if ( isdefined( self._ID25255 ) )
            self._ID25255 moveto( self.origin, 0.5 );

        wait 0.5;
    }
}

low_entries_watcher()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self endon( "death" );
    var_0 = getentarray( "low_entry", "targetname" );

    while ( var_0.size > 0 )
    {
        foreach ( var_2 in var_0 )
        {
            while ( self istouching( var_2 ) || self.owner istouching( var_2 ) )
            {
                if ( isdefined( var_2._ID27766 ) )
                    self.low_entry = float( var_2._ID27766 );
                else
                    self.low_entry = 0.5;

                wait 0.1;
            }

            self.low_entry = undefined;
        }

        wait 0.1;
    }
}

balldrone_watchdeath()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self waittill( "death" );
    thread balldronedestroyed();
}

balldrone_watchtimeout()
{
    level endon( "game_ended" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    var_0 = level.balldronesettings[self.balldronetype];
    var_1 = var_0.timeout;

    if ( maps\mp\_utility::_ID18363() && isdefined( level.ball_drone_alien_timeout_func ) && isdefined( self.owner ) )
        var_1 = self [[ level.ball_drone_alien_timeout_func ]]( var_1, self.owner );

    if ( !maps\mp\_utility::_ID18363() )
    {

    }

    maps\mp\gametypes\_hostmigration::_ID35597( var_1 );

    if ( isdefined( self.owner ) && !maps\mp\_utility::_ID18363() )
        self.owner maps\mp\_utility::_ID19765( var_0._ID35407 );

    thread balldrone_leave();
}

balldrone_watchownerloss()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner waittill( "killstreak_disowned" );
    self notify( "owner_gone" );
    thread balldrone_leave();
}

balldrone_watchownerdeath()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );

    for (;;)
    {
        self.owner waittill( "death" );

        if ( maps\mp\_utility::_ID15035() && self.owner.pers["deaths"] == maps\mp\_utility::_ID15035() )
            thread balldrone_leave();
    }
}

balldrone_watchroundend()
{
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    level common_scripts\utility::_ID35626( "round_end_finished", "game_ended" );
    thread balldrone_leave();
}

balldrone_leave()
{
    self endon( "death" );
    self notify( "leaving" );
    balldroneexplode();
}

balldrone_handledamage()
{
    maps\mp\gametypes\_damage::_ID21371( self.maxhealth, "ball_drone", ::handledeathdamage, ::modifydamage, 1 );
}

_ID4724()
{
    self endon( "death" );
    level endon( "game_ended" );
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );
        maps\mp\gametypes\_damage::_ID21372( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, "ball_drone", ::handledeathdamage, ::modifydamage, 1 );
    }
}

_ID4725()
{
    self endon( "death" );
    level endon( "game_ended" );
    self maketurretsolid();
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( isdefined( self._ID23270 ) )
            self._ID23270 maps\mp\gametypes\_damage::_ID21372( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, "ball_drone", ::handledeathdamage, ::modifydamage, 1 );
    }
}

modifydamage( var_0, var_1, var_2, var_3 )
{
    var_4 = var_3;
    var_4 = maps\mp\gametypes\_damage::_ID16266( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handlegrenadedamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleapdamage( var_1, var_2, var_4, var_0 );
    return var_4;
}

handledeathdamage( var_0, var_1, var_2, var_3 )
{
    var_4 = level.balldronesettings[self.balldronetype];
    maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, var_4._ID36472, var_4._ID35387 );

    if ( self.balldronetype == "ball_drone_backup" )
        var_0 maps\mp\gametypes\_missions::_ID25038( "ch_vulturekiller" );
}

_ID36063()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "emp_damage",  var_0, var_1  );
        balldrone_stunned( var_1 );
    }
}

balldrone_stunned( var_0 )
{
    self notify( "ballDrone_stunned" );
    self endon( "ballDrone_stunned" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );
    self._ID32026 = 1;

    if ( isdefined( level.balldronesettings[self.balldronetype]._ID14031 ) )
        playfxontag( level.balldronesettings[self.balldronetype]._ID14031, self, "tag_origin" );

    if ( self.balldronetype == "ball_drone_radar" )
    {
        if ( isdefined( self._ID25255 ) )
            self._ID25255 delete();
    }

    if ( isdefined( self._ID33988 ) )
        self._ID33988 notify( "turretstatechange" );

    wait(var_0);
    self._ID32026 = 0;

    if ( self.balldronetype == "ball_drone_radar" )
    {
        var_1 = spawn( "script_model", self.origin );
        var_1.team = self.team;
        var_1 makeportableradar( self.owner );
        self._ID25255 = var_1;
    }

    if ( isdefined( self._ID33988 ) )
        self._ID33988 notify( "turretstatechange" );
}

balldronedestroyed()
{
    if ( !isdefined( self ) )
        return;

    balldroneexplode();
}

balldroneexplode()
{
    if ( isdefined( level.balldronesettings[self.balldronetype].fxid_explode ) )
        playfx( level.balldronesettings[self.balldronetype].fxid_explode, self.origin );

    if ( isdefined( level.balldronesettings[self.balldronetype]._ID30472 ) )
        self playsound( level.balldronesettings[self.balldronetype]._ID30472 );

    self notify( "explode" );
    _ID25978();
}

_ID25978()
{
    maps\mp\_utility::decrementfauxvehiclecount();

    if ( isdefined( self._ID25255 ) )
        self._ID25255 delete();

    if ( isdefined( self._ID33988 ) )
    {
        self._ID33988 setturretminimapvisible( 0 );

        if ( isdefined( self._ID33988._ID17384 ) )
            self._ID33988._ID17384 delete();

        if ( isdefined( self._ID33988._ID19214 ) )
            self._ID33988._ID19214 delete();

        self._ID33988 delete();
    }

    if ( isdefined( self.owner ) && isdefined( self.owner.balldrone ) )
        self.owner.balldrone = undefined;

    self delete();
}

addtoballdronelist()
{
    level.balldrones[self getentitynumber()] = self;
}

_ID25994()
{
    var_0 = self getentitynumber();
    self waittill( "death" );
    level.balldrones[var_0] = undefined;
}

exceededmaxballdrones()
{
    if ( level.balldrones.size >= maps\mp\_utility::maxvehiclesallowed() )
        return 1;
    else
        return 0;
}

_ID4723()
{
    self._ID34941 endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "turretstatechange" );

        if ( self isfiringturret() && ( isdefined( self._ID34941._ID32026 ) && !self._ID34941._ID32026 ) && ( isdefined( self._ID34941._ID17494 ) && !self._ID34941._ID17494 ) )
        {
            self laseron();
            _ID10601( level.balldronesettings[self._ID34941.balldronetype]._ID20198 );
            thread _ID4726();
            continue;
        }

        self laseroff();
        thread balldrone_burstfirestop();
    }
}

_ID4726()
{
    self._ID34941 endon( "death" );
    self endon( "stop_shooting" );
    level endon( "game_ended" );
    var_0 = self._ID34941;
    var_1 = weaponfiretime( level.balldronesettings[var_0.balldronetype].weaponinfo );
    var_2 = level.balldronesettings[var_0.balldronetype].burstmin;
    var_3 = level.balldronesettings[var_0.balldronetype]._ID6331;
    var_4 = level.balldronesettings[var_0.balldronetype]._ID23388;
    var_5 = level.balldronesettings[var_0.balldronetype]._ID23387;

    if ( maps\mp\_utility::_ID18363() && level.balldronesettings[var_0.balldronetype].weaponinfo == "alien_ball_drone_gun4_mp" )
        childthread fire_rocket();

    for (;;)
    {
        var_6 = randomintrange( var_2, var_3 + 1 );

        for ( var_7 = 0; var_7 < var_6; var_7++ )
        {
            if ( isdefined( var_0._ID17494 ) && var_0._ID17494 )
                break;

            var_8 = self getturrettarget( 0 );

            if ( isdefined( var_8 ) && canbetargeted( var_8 ) )
            {
                var_0 setlookatent( var_8 );
                self shootturret();
            }

            wait(var_1);
        }

        wait(randomfloatrange( var_4, var_5 ));
    }
}

fire_rocket()
{
    for (;;)
    {
        var_0 = self getturrettarget( 0 );

        if ( isdefined( var_0 ) && canbetargeted( var_0 ) )
            magicbullet( "alienvulture_mp", self gettagorigin( "tag_flash" ), var_0.origin, self.owner );

        var_1 = weaponfiretime( "alienvulture_mp" );

        if ( isdefined( level.ball_drone_faster_rocket_func ) && isdefined( self.owner ) )
            var_1 = self [[ level.ball_drone_faster_rocket_func ]]( var_1, self.owner );

        wait(weaponfiretime( "alienvulture_mp" ));
    }
}

_ID10601( var_0 )
{
    while ( var_0 > 0 )
    {
        self playsound( level.balldronesettings[self._ID34941.balldronetype]._ID30487 );
        wait 0.5;
        var_0 -= 0.5;
    }

    self playsound( level.balldronesettings[self._ID34941.balldronetype]._ID30476 );
}

balldrone_burstfirestop()
{
    self notify( "stop_shooting" );

    if ( isdefined( self._ID17384 ) )
        self._ID34941 setlookatent( self._ID17384 );
}

canbetargeted( var_0 )
{
    var_1 = 1;

    if ( isplayer( var_0 ) )
    {
        if ( !maps\mp\_utility::_ID18757( var_0 ) || var_0.sessionstate != "playing" )
            return 0;
    }

    if ( level._ID32653 && isdefined( var_0.team ) && var_0.team == self.team )
        return 0;

    if ( isdefined( var_0.team ) && var_0.team == "spectator" )
        return 0;

    if ( isplayer( var_0 ) && var_0 == self.owner )
        return 0;

    if ( isplayer( var_0 ) && isdefined( var_0._ID30916 ) && ( gettime() - var_0._ID30916 ) / 1000 <= 5 )
        return 0;

    if ( isplayer( var_0 ) && var_0 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
        return 0;

    if ( distancesquared( var_0.origin, self.origin ) > level.balldronesettings[self._ID34941.balldronetype]._ID35360 )
        return 0;

    var_2 = self gettagorigin( "tag_flash" );
    return var_1;
}
