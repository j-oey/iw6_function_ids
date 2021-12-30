// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["littlebird_support"] = ::_ID33856;
    level.heliguardsettings = [];
    level.heliguardsettings["littlebird_support"] = spawnstruct();
    level.heliguardsettings["littlebird_support"].timeout = 60.0;
    level.heliguardsettings["littlebird_support"].health = 999999;
    level.heliguardsettings["littlebird_support"].maxhealth = 2000;
    level.heliguardsettings["littlebird_support"]._ID31889 = "littlebird_support";
    level.heliguardsettings["littlebird_support"]._ID35155 = "attack_littlebird_mp";
    level.heliguardsettings["littlebird_support"].weaponinfo = "littlebird_guard_minigun_mp";
    level.heliguardsettings["littlebird_support"]._ID36271 = "vehicle_little_bird_minigun_left";
    level.heliguardsettings["littlebird_support"]._ID36272 = "vehicle_little_bird_minigun_right";
    level.heliguardsettings["littlebird_support"]._ID36296 = "tag_flash";
    level.heliguardsettings["littlebird_support"].weapontagright = "tag_flash_2";
    level.heliguardsettings["littlebird_support"].sentrymode = "auto_nonai";
    level.heliguardsettings["littlebird_support"].modelbase = level._ID20077;
    level.heliguardsettings["littlebird_support"]._ID32680 = "used_littlebird_support";
    _ID19740();
    _ID19739();
}

_ID33856( var_0, var_1 )
{
    var_2 = "littlebird_support";
    var_3 = 1;

    if ( isdefined( level._ID20084 ) || maps\mp\killstreaks\_helicopter::_ID12353( var_2 ) )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }
    else if ( !level.air_node_mesh.size )
    {
        self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE_IN_LEVEL" );
        return 0;
    }
    else if ( maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 + var_3 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        return 0;
    }

    maps\mp\_utility::_ID17543();
    var_4 = createlbguard( var_2 );

    if ( !isdefined( var_4 ) )
    {
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    thread startlbsupport( var_4 );
    level thread maps\mp\_utility::_ID32672( level.heliguardsettings[var_2]._ID32680, self, self.team );
    return 1;
}

createlbguard( var_0 )
{
    var_1 = _ID19733( self.origin );

    if ( isdefined( var_1.angles ) )
        var_2 = var_1.angles;
    else
        var_2 = ( 0, 0, 0 );

    var_3 = maps\mp\killstreaks\_airdrop::_ID15024( self.origin );
    var_4 = lbsupport_getclosestnode( self.origin );
    var_5 = anglestoforward( self.angles );
    var_6 = var_4.origin * ( 1, 1, 0 ) + ( 0, 0, 1 ) * var_3 + var_5 * -100;
    var_7 = var_1.origin;
    var_8 = spawnhelicopter( self, var_7, var_2, level.heliguardsettings[var_0]._ID35155, level.heliguardsettings[var_0].modelbase );

    if ( !isdefined( var_8 ) )
        return;

    var_8 maps\mp\killstreaks\_helicopter::addtolittlebirdlist();
    var_8 thread maps\mp\killstreaks\_helicopter::_ID26000();
    var_8.health = level.heliguardsettings[var_0].health;
    var_8.maxhealth = level.heliguardsettings[var_0].maxhealth;
    var_8.damagetaken = 0;
    var_8.speed = 100;
    var_8._ID13465 = 40;
    var_8.owner = self;
    var_8 setotherent( self );
    var_8.team = self.team;
    var_8 setmaxpitchroll( 45, 45 );
    var_8 vehicle_setspeed( var_8.speed, 100, 40 );
    var_8 setyawspeed( 120, 60 );
    var_8 setneargoalnotifydist( 512 );
    var_8._ID19219 = 0;
    var_8._ID16760 = "littlebird";
    var_8._ID16732 = "littlebird_support";
    var_8._ID32625 = 2000;
    var_8 common_scripts\utility::_ID20489( var_8.team );
    var_8._ID32619 = var_6;
    var_8._ID8699 = var_4;
    var_9 = spawnturret( "misc_turret", var_8.origin, level.heliguardsettings[var_0].weaponinfo );
    var_9 linkto( var_8, level.heliguardsettings[var_0]._ID36296, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_9 setmodel( level.heliguardsettings[var_0]._ID36271 );
    var_9.angles = var_8.angles;
    var_9.owner = var_8.owner;
    var_9.team = self.team;
    var_9 maketurretinoperable();
    var_9._ID34941 = var_8;
    var_8._ID21007 = var_9;
    var_8._ID21007 setdefaultdroppitch( 0 );
    var_10 = var_8.origin + ( anglestoforward( var_8.angles ) * -100 + anglestoright( var_8.angles ) * -100 ) + ( 0, 0, 50 );
    var_9._ID19214 = spawn( "script_model", var_10 );
    var_9._ID19214 setscriptmoverkillcam( "explosive" );
    var_9._ID19214 linkto( var_8, "tag_origin" );
    var_9 = spawnturret( "misc_turret", var_8.origin, level.heliguardsettings[var_0].weaponinfo );
    var_9 linkto( var_8, level.heliguardsettings[var_0].weapontagright, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_9 setmodel( level.heliguardsettings[var_0]._ID36272 );
    var_9.angles = var_8.angles;
    var_9.owner = var_8.owner;
    var_9.team = self.team;
    var_9 maketurretinoperable();
    var_9._ID34941 = var_8;
    var_8._ID21008 = var_9;
    var_8._ID21008 setdefaultdroppitch( 0 );
    var_10 = var_8.origin + ( anglestoforward( var_8.angles ) * -100 + anglestoright( var_8.angles ) * 100 ) + ( 0, 0, 50 );
    var_9._ID19214 = spawn( "script_model", var_10 );
    var_9._ID19214 setscriptmoverkillcam( "explosive" );
    var_9._ID19214 linkto( var_8, "tag_origin" );

    if ( level._ID32653 )
    {
        var_8._ID21007 setturretteam( self.team );
        var_8._ID21008 setturretteam( self.team );
    }

    var_8._ID21007 setmode( level.heliguardsettings[var_0].sentrymode );
    var_8._ID21008 setmode( level.heliguardsettings[var_0].sentrymode );
    var_8._ID21007 setsentryowner( self );
    var_8._ID21008 setsentryowner( self );
    var_8._ID21007 thread lbsupport_attacktargets();
    var_8._ID21008 thread lbsupport_attacktargets();
    var_8.attract_strength = 10000;
    var_8.attract_range = 150;
    var_8.attractor = missile_createattractorent( var_8, var_8.attract_strength, var_8.attract_range );
    var_8._ID16390 = 0;
    var_8.empgrenaded = 0;
    var_8 thread _ID19735();
    var_8 thread _ID19741();
    var_8 thread _ID19747();
    var_8 thread _ID19743();
    var_8 thread lbsupport_watchownerdamage();
    var_8 thread _ID19744();
    var_8 thread _ID19737();
    level._ID20084 = var_8;
    var_8.owner maps\mp\_matchdata::_ID20253( level.heliguardsettings[var_8._ID16732]._ID31889, var_8._ID32619 );
    return var_8;
}

_ID19737()
{
    playfxontag( level._ID7233["light"]["left"], self, "tag_light_nose" );
    wait 0.05;
    playfxontag( level._ID7233["light"]["belly"], self, "tag_light_belly" );
    wait 0.05;
    playfxontag( level._ID7233["light"]["tail"], self, "tag_light_tail1" );
    wait 0.05;
    playfxontag( level._ID7233["light"]["tail"], self, "tag_light_tail2" );
}

startlbsupport( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 setlookatent( self );
    var_0 setvehgoalpos( var_0._ID32619 );
    var_0 waittill( "near_goal" );
    var_0 vehicle_setspeed( var_0.speed, 60, 30 );
    var_0 waittill( "goal" );
    var_0 setvehgoalpos( var_0._ID8699.origin, 1 );
    var_0 waittill( "goal" );
    var_0 thread _ID19730();
    var_0 thread maps\mp\killstreaks\_flares::_ID13272( ::_ID19745 );
    var_0 thread maps\mp\killstreaks\_flares::_ID13273( ::_ID19746 );
}

_ID19730()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );

    if ( !isdefined( self.owner ) )
    {
        thread _ID19736();
        return;
    }

    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self vehicle_setspeed( self._ID13465, 20, 20 );

    for (;;)
    {
        if ( isdefined( self.owner ) && isalive( self.owner ) )
        {
            var_0 = _ID19731( self.owner.origin );

            if ( isdefined( var_0 ) && var_0 != self._ID8699 )
            {
                self._ID8699 = var_0;
                _ID19738();
                continue;
            }
        }

        wait 1;
    }
}

_ID19738()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self notify( "lbSupport_moveToPlayer" );
    self endon( "lbSupport_moveToPlayer" );
    self._ID18110 = 1;
    self setvehgoalpos( self._ID8699.origin + ( 0, 0, 100 ), 1 );
    self waittill( "goal" );
    self._ID18110 = 0;
    self notify( "hit_goal" );
}

_ID19741()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self waittill( "death" );
    thread maps\mp\killstreaks\_helicopter::_ID19722();
}

_ID19747()
{
    level endon( "game_ended" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    var_0 = level.heliguardsettings[self._ID16732].timeout;
    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    thread _ID19736();
}

_ID19743()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner waittill( "killstreak_disowned" );
    self notify( "owner_gone" );
    thread _ID19736();
}

lbsupport_watchownerdamage()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );

    for (;;)
    {
        self.owner waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( isplayer( var_1 ) )
        {
            if ( var_1 != self.owner && distance2d( var_1.origin, self.origin ) <= self._ID32625 && !var_1 maps\mp\_utility::_hasperk( "specialty_blindeye" ) && !( level.hardcoremode && level._ID32653 && var_1.team == self.team ) )
            {
                self setlookatent( var_1 );

                if ( isdefined( self._ID21007 ) )
                    self._ID21007 settargetentity( var_1 );

                if ( isdefined( self._ID21008 ) )
                    self._ID21008 settargetentity( var_1 );
            }
        }
    }
}

_ID19744()
{
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    level common_scripts\utility::_ID35626( "round_end_finished", "game_ended" );
    thread _ID19736();
}

_ID19736()
{
    self endon( "death" );
    self notify( "leaving" );
    level._ID20084 = undefined;
    self clearlookatent();
    var_0 = maps\mp\killstreaks\_airdrop::_ID15024( self.origin );
    var_1 = self.origin + ( 0, 0, var_0 );
    self vehicle_setspeed( self.speed, 60 );
    self setmaxpitchroll( 45, 180 );
    self setvehgoalpos( var_1 );
    self waittill( "goal" );
    var_1 += anglestoforward( self.angles ) * 15000;
    var_2 = spawn( "script_origin", var_1 );

    if ( isdefined( var_2 ) )
    {
        self setlookatent( var_2 );
        var_2 thread _ID35429( 3.0 );
    }

    self setvehgoalpos( var_1 );
    self waittill( "goal" );
    self notify( "gone" );
    maps\mp\killstreaks\_helicopter::_ID26014();
}

_ID35429( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    wait(var_0);
    self delete();
}

_ID19735()
{
    self endon( "death" );
    level endon( "game_ended" );
    self setcandamage( 1 );

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
            if ( var_1 != self.owner && distance2d( var_1.origin, self.origin ) <= self._ID32625 && !var_1 maps\mp\_utility::_hasperk( "specialty_blindeye" ) && !( level.hardcoremode && level._ID32653 && var_1.team == self.team ) )
            {
                self setlookatent( var_1 );

                if ( isdefined( self._ID21007 ) )
                    self._ID21007 settargetentity( var_1 );

                if ( isdefined( self._ID21008 ) )
                    self._ID21008 settargetentity( var_1 );
            }

            var_1 maps\mp\gametypes\_damagefeedback::_ID34528( "helicopter" );

            if ( var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET" )
            {
                if ( var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
                    var_10 += var_0 * level.armorpiercingmod;
            }
        }

        if ( isdefined( var_1.owner ) && isplayer( var_1.owner ) )
            var_1.owner maps\mp\gametypes\_damagefeedback::_ID34528( "helicopter" );

        if ( isdefined( var_9 ) )
        {
            switch ( var_9 )
            {
                case "stinger_mp":
                case "remote_mortar_missile_mp":
                case "javelin_mp":
                case "ac130_105mm_mp":
                case "ac130_40mm_mp":
                case "remotemissile_projectile_mp":
                    self._ID19345 = 1;
                    var_10 = self.maxhealth + 1;
                    break;
                case "sam_projectile_mp":
                    self._ID19345 = 1;
                    var_10 = self.maxhealth * 0.25;
                    break;
                case "emp_grenade_mp":
                    var_10 = 0;
                    thread _ID19729();
                    break;
                case "osprey_player_minigun_mp":
                    self._ID19345 = 0;
                    var_10 *= 2;
                    break;
            }

            maps\mp\killstreaks\_killstreaks::_ID19257( var_1, var_9, self );
        }

        self.damagetaken = self.damagetaken + var_10;

        if ( self.damagetaken >= self.maxhealth )
        {
            if ( isplayer( var_1 ) && ( !isdefined( self.owner ) || var_1 != self.owner ) )
            {
                var_1 notify( "destroyed_helicopter" );
                var_1 notify( "destroyed_killstreak",  var_9  );
                thread maps\mp\_utility::_ID32672( "callout_destroyed_little_bird", var_1 );
                var_1 thread maps\mp\gametypes\_rank::giverankxp( "kill", 300, var_9, var_4 );
                var_1 thread maps\mp\gametypes\_rank::_ID36462( "destroyed_little_bird" );
                thread maps\mp\gametypes\_missions::vehiclekilled( self.owner, self, undefined, var_1, var_0, var_4, var_9 );
            }

            if ( isdefined( self.owner ) )
                self.owner thread maps\mp\_utility::_ID19765( "lbguard_destroyed" );

            self notify( "death" );
            return;
        }
    }
}

_ID19729()
{
    self notify( "lbSupport_EMPGrenaded" );
    self endon( "lbSupport_EMPGrenaded" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );
    self.empgrenaded = 1;

    if ( isdefined( self._ID21008 ) )
        self._ID21008 notify( "stop_shooting" );

    if ( isdefined( self._ID21007 ) )
        self._ID21007 notify( "stop_shooting" );

    if ( isdefined( level._ID1644["ims_sensor_explode"] ) )
    {
        if ( isdefined( self._ID21008 ) )
            playfxontag( common_scripts\utility::_ID15033( "ims_sensor_explode" ), self._ID21008, "tag_aim" );

        if ( isdefined( self._ID21007 ) )
            playfxontag( common_scripts\utility::_ID15033( "ims_sensor_explode" ), self._ID21007, "tag_aim" );
    }

    wait 3.5;
    self.empgrenaded = 0;

    if ( isdefined( self._ID21008 ) )
        self._ID21008 notify( "turretstatechange" );

    if ( isdefined( self._ID21007 ) )
        self._ID21007 notify( "turretstatechange" );
}

_ID19745( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );
    var_2 endon( "death" );

    for ( var_4 = 0; var_4 < var_3.size; var_4++ )
    {
        if ( isdefined( var_3[var_4] ) && !var_2._ID16390 )
        {
            var_2._ID16390 = 1;
            var_5 = spawn( "script_origin", var_2.origin );
            var_5.angles = var_2.angles;
            var_5 movegravity( anglestoright( var_3[var_4].angles ) * -1000, 0.05 );
            var_5 thread maps\mp\killstreaks\_flares::_ID13264( 5.0 );

            for ( var_6 = 0; var_6 < var_3.size; var_6++ )
            {
                if ( isdefined( var_3[var_6] ) )
                    var_3[var_6] missile_settargetent( var_5 );
            }

            var_7 = var_2.origin + anglestoright( var_3[var_4].angles ) * 200;
            var_2 vehicle_setspeed( var_2.speed, 100, 40 );
            var_2 setvehgoalpos( var_7, 1 );
            wait 2.0;
            var_2 vehicle_setspeed( var_2._ID13465, 20, 20 );
            break;
        }
    }
}

_ID19746( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    var_2 endon( "death" );

    if ( isdefined( self ) && !var_2._ID16390 )
    {
        var_2._ID16390 = 1;
        var_3 = spawn( "script_origin", var_2.origin );
        var_3.angles = var_2.angles;
        var_3 movegravity( anglestoright( self.angles ) * -1000, 0.05 );
        var_3 thread maps\mp\killstreaks\_flares::_ID13264( 5.0 );
        self missile_settargetent( var_3 );
        var_4 = var_2.origin + anglestoright( self.angles ) * 200;
        var_2 vehicle_setspeed( var_2.speed, 100, 40 );
        var_2 setvehgoalpos( var_4, 1 );
        wait 2.0;
        var_2 vehicle_setspeed( var_2._ID13465, 20, 20 );
    }
}

_ID19733( var_0 )
{
    var_1 = undefined;
    var_2 = 999999;

    foreach ( var_4 in level.air_start_nodes )
    {
        var_5 = distance( var_4.origin, var_0 );

        if ( var_5 < var_2 )
        {
            var_1 = var_4;
            var_2 = var_5;
        }
    }

    return var_1;
}

lbsupport_getclosestnode( var_0 )
{
    var_1 = undefined;
    var_2 = 999999;

    foreach ( var_4 in level.air_node_mesh )
    {
        var_5 = distance( var_4.origin, var_0 );

        if ( var_5 < var_2 )
        {
            var_1 = var_4;
            var_2 = var_5;
        }
    }

    return var_1;
}

_ID19731( var_0 )
{
    var_1 = undefined;
    var_2 = distance2d( self._ID8699.origin, var_0 );
    var_3 = var_2;

    foreach ( var_5 in self._ID8699._ID21919 )
    {
        var_6 = distance2d( var_5.origin, var_0 );

        if ( var_6 < var_2 && var_6 < var_3 )
        {
            var_1 = var_5;
            var_3 = var_6;
        }
    }

    return var_1;
}

_ID19725( var_0, var_1 )
{
    if ( var_0.size <= 0 )
        return 0;

    foreach ( var_3 in var_0 )
    {
        if ( var_3 == var_1 )
            return 1;
    }

    return 0;
}

_ID19734()
{
    var_0 = [];

    if ( isdefined( self.script_linkto ) )
    {
        var_1 = common_scripts\utility::get_links();

        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            var_3 = common_scripts\utility::_ID15384( var_1[var_2], "script_linkname" );

            if ( isdefined( var_3 ) )
                var_0[var_0.size] = var_3;
        }
    }

    return var_0;
}

_ID19740()
{
    level.air_start_nodes = common_scripts\utility::_ID15386( "chopper_boss_path_start", "targetname" );

    foreach ( var_1 in level.air_start_nodes )
        var_1._ID21919 = var_1 _ID19734();
}

_ID19739()
{
    level.air_node_mesh = common_scripts\utility::_ID15386( "so_chopper_boss_path_struct", "script_noteworthy" );

    foreach ( var_1 in level.air_node_mesh )
    {
        var_1._ID21919 = var_1 _ID19734();

        foreach ( var_3 in level.air_node_mesh )
        {
            if ( var_1 == var_3 )
                continue;

            if ( !_ID19725( var_1._ID21919, var_3 ) && _ID19725( var_3 _ID19734(), var_1 ) )
                var_1._ID21919[var_1._ID21919.size] = var_3;
        }
    }
}

lbsupport_attacktargets()
{
    self._ID34941 endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "turretstatechange" );

        if ( self isfiringturret() && !self._ID34941.empgrenaded )
        {
            thread _ID19727();
            continue;
        }

        thread lbsupport_burstfirestop();
    }
}

_ID19727()
{
    self._ID34941 endon( "death" );
    self._ID34941 endon( "leaving" );
    self endon( "stop_shooting" );
    level endon( "game_ended" );
    var_0 = 0.1;
    var_1 = 40;
    var_2 = 80;
    var_3 = 1.0;
    var_4 = 2.0;

    for (;;)
    {
        var_5 = randomintrange( var_1, var_2 + 1 );

        for ( var_6 = 0; var_6 < var_5; var_6++ )
        {
            var_7 = self getturrettarget( 0 );

            if ( isdefined( var_7 ) && ( !isdefined( var_7._ID30916 ) || ( gettime() - var_7._ID30916 ) / 1000 > 5 ) && ( isdefined( var_7.team ) && var_7.team != "spectator" ) && maps\mp\_utility::_ID18757( var_7 ) )
            {
                self._ID34941 setlookatent( var_7 );
                self shootturret();
            }

            wait(var_0);
        }

        wait(randomfloatrange( var_3, var_4 ));
    }
}

lbsupport_burstfirestop()
{
    self notify( "stop_shooting" );

    if ( isdefined( self._ID34941.owner ) )
        self._ID34941 setlookatent( self._ID34941.owner );
}
