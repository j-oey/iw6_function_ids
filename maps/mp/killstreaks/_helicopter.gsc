// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    var_0 = getentarray( "heli_start", "targetname" );
    var_1 = getentarray( "heli_loop_start", "targetname" );

    if ( !var_0.size && !var_1.size )
        return;

    level.chopper = undefined;
    level._ID16675 = getentarray( "heli_start", "targetname" );
    level.heli_loop_nodes = getentarray( "heli_loop_start", "targetname" );
    level._ID31881 = common_scripts\utility::_ID15386( "strafe_path", "targetname" );
    level._ID16611 = getentarray( "heli_leave", "targetname" );
    level._ID16546 = getentarray( "heli_crash_start", "targetname" );
    level._ID16628 = 5;
    level.heli_maxhealth = 2000;
    level._ID16552 = 0;
    level.heli_targeting_delay = 0.5;
    level._ID16696 = 1.5;
    level._ID16695 = 60;
    level._ID16700 = 3700;
    level._ID16686 = 5;
    level._ID16685 = 0.5;
    level._ID16627 = 256;
    level._ID16629 = 0.3;
    level._ID16509 = 0.3;
    level._ID16516 = 1000;
    level.heli_attract_range = 4096;
    level.heli_angle_offset = 90;
    level._ID16590 = 0;
    level _ID24850();
    level._ID7233["damage"]["light_smoke"] = loadfx( "fx/smoke/smoke_trail_white_heli_emitter" );
    level._ID7233["damage"]["heavy_smoke"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_helo_damage" );
    level._ID7233["damage"]["on_fire"] = loadfx( "fx/fire/fire_smoke_trail_L_emitter" );
    level._ID7233["light"]["left"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_acraft_light_wingtip_green" );
    level._ID7233["light"]["right"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_acraft_light_wingtip_red" );
    level._ID7233["light"]["belly"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_acraft_light_red_blink" );
    level._ID7233["light"]["tail"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_acraft_light_white_blink" );
    level._ID7233["explode"]["medium"] = loadfx( "fx/explosions/aerial_explosion" );
    level._ID7233["explode"]["large"] = loadfx( "fx/explosions/helicopter_explosion_secondary_small" );
    level._ID7233["smoke"]["trail"] = loadfx( "fx/smoke/smoke_trail_white_heli" );
    level._ID7233["explode"]["death"] = [];
    level._ID7233["explode"]["death"]["apache"] = loadfx( "vfx/gameplay/explosions/vehicle/apch_mp/vfx_x_mpapc_primary" );
    level._ID7233["explode"]["air_death"]["apache"] = loadfx( "vfx/gameplay/explosions/vehicle/apch_mp/vfx_x_mpapc_primary" );
    level._ID19961["apache"] = ::_ID9405;
    level._ID7233["explode"]["death"]["cobra"] = loadfx( "vfx/gameplay/explosions/vehicle/hind_mp/vfx_x_mphnd_primary" );
    level._ID7233["explode"]["air_death"]["cobra"] = loadfx( "vfx/gameplay/explosions/vehicle/hind_mp/vfx_x_mphnd_primary" );
    level._ID19961["cobra"] = ::_ID9405;
    level._ID7233["explode"]["death"]["littlebird"] = loadfx( "vfx/gameplay/explosions/vehicle/aas_mp/vfx_x_mpaas_primary" );
    level._ID7233["explode"]["air_death"]["littlebird"] = loadfx( "vfx/gameplay/explosions/vehicle/aas_mp/vfx_x_mpaas_primary" );
    level._ID19961["littlebird"] = ::_ID9405;
    level._ID1644["vehicle_flares"] = loadfx( "fx/misc/flares_cobra" );
    level._ID7233["fire"]["trail"]["medium"] = loadfx( "fx/fire/fire_smoke_trail_L_emitter" );
    level._ID19256["helicopter"] = ::_ID34748;
    level.helidialog["tracking"][0] = "ac130_fco_moreenemy";
    level.helidialog["tracking"][1] = "ac130_fco_getthatguy";
    level.helidialog["tracking"][2] = "ac130_fco_guyrunnin";
    level.helidialog["tracking"][3] = "ac130_fco_gotarunner";
    level.helidialog["tracking"][4] = "ac130_fco_personnelthere";
    level.helidialog["tracking"][5] = "ac130_fco_rightthere";
    level.helidialog["tracking"][6] = "ac130_fco_tracking";
    level.helidialog["locked"][0] = "ac130_fco_lightemup";
    level.helidialog["locked"][1] = "ac130_fco_takehimout";
    level.helidialog["locked"][2] = "ac130_fco_nailthoseguys";
    level._ID19563 = 0;
    level.heliconfigs = [];
    var_2 = spawnstruct();
    var_2._ID36472 = "destroyed_helicopter";
    var_2.callout = "callout_destroyed_helicopter";
    var_2.samdamagescale = 0.09;
    var_2.enginevfxtag = "tag_engine_left";
    level.heliconfigs["helicopter"] = var_2;
    var_2 = spawnstruct();
    var_2._ID36472 = "destroyed_little_bird";
    var_2.callout = "callout_destroyed_little_bird";
    var_2.samdamagescale = 0.09;
    var_2.enginevfxtag = "tag_engine_left";
    level.heliconfigs["airdrop"] = var_2;
    var_2 = spawnstruct();
    var_2._ID36472 = "destroyed_pavelow";
    var_2.callout = "callout_destroyed_helicopter_flares";
    var_2.samdamagescale = 0.07;
    var_2.enginevfxtag = "tag_engine_left";
    level.heliconfigs["flares"] = var_2;
    maps\mp\_utility::_ID25239( "helicopter" );
}

_ID20503( var_0, var_1, var_2 )
{
    level._ID7233["explode"]["death"][var_0] = loadfx( var_1 );
    level._ID19961[var_0] = var_2;
}

addairexplosion( var_0, var_1 )
{
    level._ID7233["explode"]["air_death"][var_0] = loadfx( var_1 );
}

_ID9405()
{
    playfxontag( level._ID7233["light"]["left"], self, "tag_light_L_wing" );
    wait 0.05;
    playfxontag( level._ID7233["light"]["right"], self, "tag_light_R_wing" );
    wait 0.05;
    playfxontag( level._ID7233["light"]["belly"], self, "tag_light_belly" );
    wait 0.05;
    playfxontag( level._ID7233["light"]["tail"], self, "tag_light_tail" );
}

_ID34748( var_0, var_1 )
{
    return _ID33849( var_0, "helicopter" );
}

_ID33849( var_0, var_1 )
{
    var_2 = 1;

    if ( isdefined( level.chopper ) )
        var_3 = 1;
    else
        var_3 = 0;

    if ( isdefined( level.chopper ) && var_3 )
    {
        self iprintlnbold( &"KILLSTREAKS_HELI_IN_QUEUE" );

        if ( isdefined( var_1 ) && var_1 != "helicopter" )
            var_4 = "helicopter_" + var_1;
        else
            var_4 = "helicopter";

        thread maps\mp\killstreaks\_killstreaks::_ID34551();
        var_5 = spawn( "script_origin", ( 0, 0, 0 ) );
        var_5 hide();
        var_5 thread deleteonentnotify( self, "disconnect" );
        var_5.player = self;
        var_5._ID19938 = var_0;
        var_5._ID16760 = var_1;
        var_5._ID31889 = var_4;
        maps\mp\_utility::_ID25237( "helicopter", var_5 );
        var_6 = undefined;

        if ( !self hasweapon( common_scripts\utility::_ID15114() ) )
            var_6 = maps\mp\killstreaks\_killstreaks::_ID15018();
        else
            var_6 = common_scripts\utility::_ID15114();

        var_7 = maps\mp\_utility::getkillstreakweapon( "helicopter" );
        thread maps\mp\killstreaks\_killstreaks::waittakekillstreakweapon( var_7, var_6 );
        return 0;
    }
    else if ( maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 + var_2 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        return 0;
    }

    var_2 = 1;
    _ID31447( var_0, var_1 );
    return 1;
}

deleteonentnotify( var_0, var_1 )
{
    self endon( "death" );
    var_0 waittill( var_1 );
    self delete();
}

_ID31447( var_0, var_1 )
{
    maps\mp\_utility::_ID17543();
    var_2 = undefined;

    if ( !isdefined( var_1 ) )
        var_1 = "";

    var_3 = "helicopter";
    var_4 = self.pers["team"];
    var_2 = level._ID16675[randomint( level._ID16675.size )];
    maps\mp\_matchdata::_ID20253( var_3, self.origin );
    thread heli_think( var_0, self, var_2, self.pers["team"], var_1 );
}

_ID24850()
{
    level._ID16656["allies"]["hit"] = "cobra_helicopter_hit";
    level._ID16656["allies"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
    level._ID16656["allies"]["damaged"] = "cobra_helicopter_damaged";
    level._ID16656["allies"]["spinloop"] = "cobra_helicopter_dying_loop";
    level._ID16656["allies"]["spinstart"] = "cobra_helicopter_dying_layer";
    level._ID16656["allies"]["crash"] = "exp_helicopter_fuel";
    level._ID16656["allies"]["missilefire"] = "weap_cobra_missile_fire";
    level._ID16656["axis"]["hit"] = "cobra_helicopter_hit";
    level._ID16656["axis"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
    level._ID16656["axis"]["damaged"] = "cobra_helicopter_damaged";
    level._ID16656["axis"]["spinloop"] = "cobra_helicopter_dying_loop";
    level._ID16656["axis"]["spinstart"] = "cobra_helicopter_dying_layer";
    level._ID16656["axis"]["crash"] = "exp_helicopter_fuel";
    level._ID16656["axis"]["missilefire"] = "weap_cobra_missile_fire";
}

_ID16596()
{
    var_0 = self.team;

    if ( level.multiteambased )
        var_0 = "axis";

    return var_0;
}

_ID30677( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = spawnhelicopter( var_0, var_1, var_2, var_3, var_4 );

    if ( !isdefined( var_5 ) )
        return undefined;

    if ( var_4 == "vehicle_battle_hind" )
        var_5.heli_type = "cobra";
    else
        var_5.heli_type = level._ID16698[var_4];

    var_5 thread [[ level._ID19961[var_5.heli_type] ]]();
    var_5 addtohelilist();
    var_5.zoffset = ( 0, 0, var_5 gettagorigin( "tag_origin" )[2] - var_5 gettagorigin( "tag_ground" )[2] );
    var_5.attractor = missile_createattractorent( var_5, level._ID16516, level.heli_attract_range );
    return var_5;
}

helidialog( var_0 )
{
    if ( gettime() - level._ID19563 < 6000 )
        return;

    level._ID19563 = gettime();
    var_1 = randomint( level.helidialog[var_0].size );
    var_2 = level.helidialog[var_0][var_1];
    var_3 = maps\mp\gametypes\_teams::getteamvoiceprefix( self.team ) + var_2;
    self playlocalsound( var_3 );
}

updateareanodes( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        var_3._ID34842 = [];
        var_3.nodescore = 0;
    }

    foreach ( var_6 in level.players )
    {
        if ( !isalive( var_6 ) )
            continue;

        if ( var_6.team == self.team )
            continue;

        foreach ( var_3 in var_0 )
        {
            if ( distancesquared( var_6.origin, var_3.origin ) > 1048576 )
                continue;

            var_3._ID34842[var_3._ID34842.size] = var_6;
        }
    }

    var_10 = var_0[0];

    foreach ( var_3 in var_0 )
    {
        var_12 = getent( var_3.target, "targetname" );

        foreach ( var_6 in var_3._ID34842 )
        {
            var_3.nodescore = var_3.nodescore + 1;

            if ( bullettracepassed( var_6.origin + ( 0, 0, 32 ), var_12.origin, 0, var_6 ) )
                var_3.nodescore = var_3.nodescore + 3;
        }

        if ( var_3.nodescore > var_10.nodescore )
            var_10 = var_3;
    }

    return getent( var_10.target, "targetname" );
}

heli_think( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = var_2.origin;
    var_6 = var_2.angles;
    var_7 = "cobra_mp";
    var_8 = "vehicle_battle_hind";
    var_9 = _ID30677( var_1, var_5, var_6, var_7, var_8 );

    if ( !isdefined( var_9 ) )
        return;

    level.chopper = var_9;

    if ( var_3 == "allies" )
        level.allieschopper = var_9;
    else
        level.axischopper = var_9;

    var_9._ID16760 = var_4;
    var_9._ID19938 = var_0;
    var_9.team = var_3;
    var_9.pers["team"] = var_3;
    var_9.owner = var_1;
    var_9 setotherent( var_1 );
    var_9.startnode = var_2;
    var_9.maxhealth = level.heli_maxhealth;
    var_9._ID32609 = level.heli_targeting_delay;
    var_9._ID24976 = undefined;
    var_9.secondarytarget = undefined;
    var_9.attacker = undefined;
    var_9.currentstate = "ok";
    var_9 common_scripts\utility::_ID20489( var_3 );
    var_9.empgrenaded = 0;

    if ( var_4 == "flares" || var_4 == "minigun" )
        var_9 thread maps\mp\killstreaks\_flares::_ID13274( 1 );

    var_9 thread heli_leave_on_disconnect( var_1 );
    var_9 thread heli_leave_on_changeteams( var_1 );
    var_9 thread _ID16614( var_1 );
    var_9 thread _ID16549( var_4 );
    var_9 thread _ID16706();
    var_9 thread _ID16705();
    var_9 thread _ID16563();
    var_9 endon( "helicopter_done" );
    var_9 endon( "crashing" );
    var_9 endon( "leaving" );
    var_9 endon( "death" );
    var_10 = getentarray( "heli_attack_area", "targetname" );
    var_11 = undefined;
    var_11 = level.heli_loop_nodes[randomint( level.heli_loop_nodes.size )];
    var_9 _ID16582( var_2 );
    var_9 thread _ID16687();
    var_9 thread _ID16617( 60.0 );
    var_9 thread _ID16581( var_11 );
}

_ID16563()
{
    var_0 = self getentitynumber();
    common_scripts\utility::_ID35626( "death", "crashing", "leaving" );
    removefromhelilist( var_0 );
    self notify( "helicopter_done" );
    self notify( "helicopter_removed" );
    var_1 = undefined;
    var_2 = maps\mp\_utility::_ID25241( "helicopter" );

    if ( !isdefined( var_2 ) )
        level.chopper = undefined;
    else
    {
        var_1 = var_2.player;
        var_3 = var_2._ID19938;
        var_4 = var_2._ID31889;
        var_5 = var_2._ID16760;
        var_2 delete();

        if ( isdefined( var_1 ) && ( var_1.sessionstate == "playing" || var_1.sessionstate == "dead" ) )
        {
            var_1 maps\mp\killstreaks\_killstreaks::_ID34739( var_4, 1 );
            var_1 _ID31447( var_3, var_5 );
            return;
        }

        level.chopper = undefined;
    }
}

_ID16687()
{
    self notify( "heli_targeting" );
    self endon( "heli_targeting" );
    self endon( "death" );
    self endon( "helicopter_done" );

    for (;;)
    {
        var_0 = [];
        self._ID24976 = undefined;
        self.secondarytarget = undefined;

        foreach ( var_2 in level.characters )
        {
            wait 0.05;

            if ( !_ID6657( var_2 ) )
                continue;

            var_0[var_0.size] = var_2;
        }

        if ( var_0.size )
        {
            for ( var_4 = _ID14910( var_0 ); !isdefined( var_4 ); var_4 = _ID14910( var_0 ) )
                wait 0.05;

            self._ID24976 = var_4;
            self notify( "primary acquired" );
        }

        if ( isdefined( self._ID24976 ) )
        {
            fireontarget( self._ID24976 );
            continue;
        }

        wait 0.25;
    }
}

_ID6657( var_0 )
{
    var_1 = 1;

    if ( !isalive( var_0 ) || isdefined( var_0.sessionstate ) && var_0.sessionstate != "playing" )
        return 0;

    if ( self._ID16760 == "remote_mortar" )
    {
        if ( var_0 sightconetrace( self.origin, self ) < 1 )
            return 0;
    }

    if ( distance( var_0.origin, self.origin ) > level._ID16700 )
        return 0;

    if ( !self.owner maps\mp\_utility::isenemy( var_0 ) )
        return 0;

    if ( isdefined( var_0._ID30916 ) && ( gettime() - var_0._ID30916 ) / 1000 <= 5 )
        return 0;

    if ( var_0 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
        return 0;

    var_2 = self.origin + ( 0, 0, -160 );
    var_3 = anglestoforward( self.angles );
    var_4 = var_2 + 144 * var_3;

    if ( var_0 sightconetrace( var_4, self ) < level._ID16685 )
        return 0;

    return var_1;
}

_ID14910( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2 ) )
            continue;

        _ID34461( var_2 );
    }

    var_4 = 0;
    var_5 = undefined;
    var_6 = getentarray( "minimap_corner", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2 ) )
            continue;

        if ( var_6.size == 2 )
        {
            var_8 = var_6[0].origin;
            var_9 = var_6[0].origin;

            if ( var_6[1].origin[0] > var_9[0] )
                var_9 = ( var_6[1].origin[0], var_9[1], var_9[2] );
            else
                var_8 = ( var_6[1].origin[0], var_8[1], var_8[2] );

            if ( var_6[1].origin[1] > var_9[1] )
                var_9 = ( var_9[0], var_6[1].origin[1], var_9[2] );
            else
                var_8 = ( var_8[0], var_6[1].origin[1], var_8[2] );

            if ( var_2.origin[0] < var_8[0] || var_2.origin[0] > var_9[0] || var_2.origin[1] < var_8[1] || var_2.origin[1] > var_9[1] )
                continue;
        }

        if ( var_2._ID32927 < var_4 )
            continue;

        if ( !bullettracepassed( var_2.origin + ( 0, 0, 32 ), self.origin, 0, self ) )
        {
            wait 0.05;
            continue;
        }

        var_4 = var_2._ID32927;
        var_5 = var_2;
    }

    return var_5;
}

_ID34461( var_0 )
{
    var_0._ID32927 = 0;
    var_1 = distance( var_0.origin, self.origin );
    var_0._ID32927 = var_0._ID32927 + ( level._ID16700 - var_1 ) / level._ID16700 * 100;

    if ( isdefined( self.attacker ) && var_0 == self.attacker )
        var_0._ID32927 = var_0._ID32927 + 100;

    if ( isplayer( var_0 ) )
        var_0._ID32927 = var_0._ID32927 + var_0.score * 4;

    if ( isdefined( var_0.antithreat ) )
        var_0._ID32927 = var_0._ID32927 - var_0.antithreat;

    if ( var_0._ID32927 <= 0 )
        var_0._ID32927 = 1;
}

_ID16645()
{
    self cleartargetyaw();
    self cleargoalyaw();
    self vehicle_setspeed( 80, 35 );
    self setyawspeed( 75, 45, 45 );
    self setmaxpitchroll( 30, 30 );
    self setneargoalnotifydist( 256 );
    self setturningability( 0.9 );
}

_ID2400( var_0 )
{
    self endon( "death" );
    self.recentdamageamount = self.recentdamageamount + var_0;
    wait 4.0;
    self.recentdamageamount = self.recentdamageamount - var_0;
}

modifydamage( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_0 ) )
    {
        if ( isdefined( self.owner ) && var_0 == self.owner && self._ID31889 == "heli_sniper" || isdefined( var_0.class ) && var_0.class == "worldspawn" || var_0 == self )
            return -1;
    }

    if ( isdefined( level.ishorde ) && level.ishorde && isdefined( self._ID31889 ) && self._ID31889 == "heli_sniper" )
        return -1;

    var_4 = var_3;
    var_4 = maps\mp\gametypes\_damage::_ID16266( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handlegrenadedamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleapdamage( var_1, var_2, var_4, var_0 );
    thread _ID2400( var_4 );
    self notify( "heli_damage_fx" );
    return var_4;
}

handledeathdamage( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_0 ) )
    {
        var_4 = level.heliconfigs[self._ID31889];
        var_5 = maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, var_4._ID36472, var_4._ID9801, var_4.callout );

        if ( var_5 )
        {
            var_0 notify( "destroyed_helicopter" );
            self.killingattacker = var_0;
        }

        if ( var_1 == "heli_pilot_turret_mp" )
            var_0 maps\mp\gametypes\_missions::_ID25038( "ch_enemy_down" );

        maps\mp\gametypes\_missions::checkaachallenges( var_0, self, var_1 );
    }
}

_ID16549( var_0, var_1 )
{
    self endon( "crashing" );
    self endon( "leaving" );
    self._ID31889 = var_0;
    self.recentdamageamount = 0;
    thread _ID16601();
    maps\mp\gametypes\_damage::_ID21371( self.maxhealth, "helicopter", ::handledeathdamage, ::modifydamage, 1, var_1 );
}

_ID16706()
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "emp_damage",  var_0, var_1  );
        self.empgrenaded = 1;

        if ( isdefined( self._ID21007 ) )
            self._ID21007 notify( "stop_shooting" );

        if ( isdefined( self._ID21008 ) )
            self._ID21008 notify( "stop_shooting" );

        wait(var_1);
        self.empgrenaded = 0;

        if ( isdefined( self._ID21007 ) )
            self._ID21007 notify( "turretstatechange" );

        if ( isdefined( self._ID21008 ) )
            self._ID21008 notify( "turretstatechange" );
    }
}

_ID16601()
{
    self endon( "leaving" );
    self endon( "crashing" );
    self.currentstate = "ok";
    self._ID19645 = "ok";
    self setdamagestage( 3 );
    var_0 = 3;
    self setdamagestage( var_0 );
    var_1 = level.heliconfigs[self._ID31889];

    for (;;)
    {
        self waittill( "heli_damage_fx" );

        if ( var_0 > 0 && self.damagetaken >= self.maxhealth )
        {
            var_0 = 0;
            self setdamagestage( var_0 );
            stopfxontag( level._ID7233["damage"]["heavy_smoke"], self, var_1.enginevfxtag );
            self notify( "death" );
            break;
            continue;
        }

        if ( var_0 > 1 && self.damagetaken >= self.maxhealth * 0.66 )
        {
            var_0 = 1;
            self setdamagestage( var_0 );
            self.currentstate = "heavy smoke";
            stopfxontag( level._ID7233["damage"]["light_smoke"], self, var_1.enginevfxtag );
            playfxontag( level._ID7233["damage"]["heavy_smoke"], self, var_1.enginevfxtag );
            continue;
        }

        if ( var_0 > 2 && self.damagetaken >= self.maxhealth * 0.33 )
        {
            var_0 = 2;
            self setdamagestage( var_0 );
            self.currentstate = "light smoke";
            playfxontag( level._ID7233["damage"]["light_smoke"], self, var_1.enginevfxtag );
        }
    }
}

_ID16705()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self waittill( "death" );

    if ( isdefined( self._ID19345 ) && self._ID19345 )
        thread heli_explode( 1 );
    else
    {
        var_0 = level.heliconfigs[self._ID31889];
        playfxontag( level._ID7233["damage"]["on_fire"], self, var_0.enginevfxtag );
        thread _ID16534();
    }
}

_ID16534()
{
    self notify( "crashing" );
    self clearlookatent();
    var_0 = level._ID16546[randomint( level._ID16546.size )];

    if ( isdefined( self._ID21007 ) )
        self._ID21007 notify( "stop_shooting" );

    if ( isdefined( self._ID21008 ) )
        self._ID21008 notify( "stop_shooting" );

    thread _ID16659( 180 );
    thread _ID16646();
    _ID16582( var_0 );
    thread heli_explode();
}

_ID16646()
{
    var_0 = _ID16596();
    var_1 = level.heliconfigs[self._ID31889];
    playfxontag( level._ID7233["explode"]["large"], self, var_1.enginevfxtag );
    self playsound( level._ID16656[var_0]["hitsecondary"] );
    wait 3.0;

    if ( !isdefined( self ) )
        return;

    playfxontag( level._ID7233["explode"]["large"], self, var_1.enginevfxtag );
    self playsound( level._ID16656[var_0]["hitsecondary"] );
}

_ID16659( var_0 )
{
    self endon( "death" );
    var_1 = _ID16596();
    self playsound( level._ID16656[var_1]["hit"] );
    thread _ID31013();
    self setyawspeed( var_0, var_0, var_0 );

    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[1] + var_0 * 0.9 );
        wait 1;
    }
}

_ID31013()
{
    self endon( "death" );
    wait 0.25;
    var_0 = _ID16596();
    self stoploopsound();
    wait 0.05;
    self playloopsound( level._ID16656[var_0]["spinloop"] );
    wait 0.05;
    self playloopsound( level._ID16656[var_0]["spinstart"] );
}

heli_explode( var_0 )
{
    self notify( "death" );

    if ( isdefined( var_0 ) && isdefined( level._ID7233["explode"]["air_death"][self.heli_type] ) )
    {
        var_1 = self gettagangles( "tag_deathfx" );
        playfx( level._ID7233["explode"]["air_death"][self.heli_type], self gettagorigin( "tag_deathfx" ), anglestoforward( var_1 ), anglestoup( var_1 ) );
    }
    else
    {
        var_2 = self.origin;
        var_3 = self.origin + ( 0, 0, 1 ) - self.origin;
        playfx( level._ID7233["explode"]["death"][self.heli_type], var_2, var_3 );
    }

    var_4 = _ID16596();
    self playsound( level._ID16656[var_4]["crash"] );
    wait 0.05;

    if ( isdefined( self._ID19214 ) )
        self._ID19214 delete();

    maps\mp\_utility::decrementfauxvehiclecount();
    self delete();
}

_ID7035()
{
    if ( !isdefined( self.owner ) || !isdefined( self.owner.pers["team"] ) || self.owner.pers["team"] != self.team )
    {
        thread _ID16610();
        return 0;
    }

    return 1;
}

heli_leave_on_disconnect( var_0 )
{
    self endon( "death" );
    self endon( "helicopter_done" );
    var_0 waittill( "disconnect" );
    thread _ID16610();
}

heli_leave_on_changeteams( var_0 )
{
    self endon( "death" );
    self endon( "helicopter_done" );

    if ( maps\mp\_utility::bot_is_fireteam_mode() )
        return;

    var_0 common_scripts\utility::_ID35626( "joined_team", "joined_spectators" );
    thread _ID16610();
}

_ID16616( var_0 )
{
    self endon( "death" );
    self endon( "helicopter_done" );
    var_0 waittill( "spawned" );
    thread _ID16610();
}

_ID16614( var_0 )
{
    self endon( "death" );
    self endon( "helicopter_done" );
    level waittill( "game_ended" );
    thread _ID16610();
}

_ID16617( var_0 )
{
    self endon( "death" );
    self endon( "helicopter_done" );
    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    thread _ID16610();
}

fireontarget( var_0 )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    var_1 = 15;
    var_2 = 0;
    var_3 = 0;

    foreach ( var_5 in level.heli_loop_nodes )
    {
        var_2++;
        var_3 += var_5.origin[2];
    }

    var_7 = var_3 / var_2;
    self notify( "newTarget" );

    if ( isdefined( self.secondarytarget ) && self.secondarytarget.damagetaken < self.secondarytarget.maxhealth )
        return;

    if ( isdefined( self._ID18731 ) && self._ID18731 )
        return;

    var_8 = self._ID24976;
    var_8.antithreat = 0;
    var_9 = self._ID24976.origin * ( 1, 1, 0 );
    var_10 = self.origin * ( 0, 0, 1 );
    var_11 = var_9 + var_10;
    var_12 = distance2d( self.origin, var_8.origin );

    if ( var_12 < 1000 )
        var_1 = 600;

    var_13 = anglestoforward( var_8.angles );
    var_13 *= ( 1, 1, 0 );
    var_14 = var_11 + var_1 * var_13;
    var_15 = var_14 - var_11;
    var_16 = vectortoangles( var_15 );
    var_16 *= ( 1, 1, 0 );
    thread _ID4103( var_8 );
    self vehicle_setspeed( 80 );

    if ( distance2d( self.origin, var_14 ) < 1000 )
        var_14 *= 1.5;

    var_14 *= ( 1, 1, 0 );
    var_14 += ( 0, 0, var_7 );
    _setvehgoalpos( var_14, 1, 1 );
    self waittill( "near_goal" );

    if ( !isdefined( var_8 ) || !isalive( var_8 ) )
        return;

    self setlookatent( var_8 );
    thread isfacing( 10, var_8 );
    common_scripts\utility::_ID35637( 4, "facing" );

    if ( !isdefined( var_8 ) || !isalive( var_8 ) )
        return;

    self clearlookatent();
    var_17 = var_11 + var_1 * anglestoforward( var_16 );
    self setmaxpitchroll( 40, 30 );
    _setvehgoalpos( var_17, 1, 1 );
    self setmaxpitchroll( 30, 30 );

    if ( isdefined( var_8 ) && isalive( var_8 ) )
    {
        if ( isdefined( var_8.antithreat ) )
            var_8.antithreat = var_8.antithreat + 100;
        else
            var_8.antithreat = 100;
    }

    common_scripts\utility::_ID35637( 3, "near_goal" );
}

_ID4103( var_0 )
{
    self notify( "attackGroundTarget" );
    self endon( "attackGroundTarget" );
    self stoploopsound();
    self._ID18563 = 1;
    self setturrettargetent( var_0 );
    _ID35598( var_0, 3.0 );

    if ( !isalive( var_0 ) )
        self._ID18563 = 0;
    else
    {
        var_1 = distance2dsquared( self.origin, var_0.origin );

        if ( var_1 < 640000 )
        {
            thread dropbombs( var_0 );
            self._ID18563 = 0;
            return;
        }
        else
        {
            if ( checkisfacing( 50, var_0 ) && common_scripts\utility::_ID7657() )
            {
                thread _ID13069( var_0 );
                self._ID18563 = 0;
                return;
                return;
            }

            var_2 = weaponfiretime( "cobra_20mm_mp" );
            var_3 = 0;
            var_4 = 0;

            for ( var_5 = 0; var_5 < level._ID16695; var_5++ )
            {
                if ( !isdefined( self ) )
                    break;

                if ( self.empgrenaded )
                    break;

                if ( !isdefined( var_0 ) )
                    break;

                if ( !isalive( var_0 ) )
                    break;

                if ( self.damagetaken >= self.maxhealth )
                    continue;

                if ( !checkisfacing( 55, var_0 ) )
                {
                    self stoploopsound();
                    var_4 = 0;
                    wait(var_2);
                    var_5--;
                    continue;
                }

                if ( var_5 < level._ID16695 - 1 )
                    wait(var_2);

                if ( !isdefined( var_0 ) || !isalive( var_0 ) )
                    break;

                if ( !var_4 )
                {
                    self playloopsound( "weap_hind_20mm_fire_npc" );
                    var_4 = 1;
                }

                self setvehweapon( "cobra_20mm_mp" );
                self fireweapon( "tag_flash", var_0 );
            }

            if ( !isdefined( self ) )
                return;

            self stoploopsound();
            var_4 = 0;
            self._ID18563 = 0;
        }
    }
}

checkisfacing( var_0, var_1 )
{
    self endon( "death" );
    self endon( "leaving" );

    if ( !isdefined( var_0 ) )
        var_0 = 10;

    var_2 = anglestoforward( self.angles );
    var_3 = var_1.origin - self.origin;
    var_2 *= ( 1, 1, 0 );
    var_3 *= ( 1, 1, 0 );
    var_3 = vectornormalize( var_3 );
    var_2 = vectornormalize( var_2 );
    var_4 = vectordot( var_3, var_2 );
    var_5 = cos( var_0 );

    if ( var_4 >= var_5 )
        return 1;
    else
        return 0;
}

isfacing( var_0, var_1 )
{
    self endon( "death" );
    self endon( "leaving" );

    if ( !isdefined( var_0 ) )
        var_0 = 10;

    while ( isalive( var_1 ) )
    {
        var_2 = anglestoforward( self.angles );
        var_3 = var_1.origin - self.origin;
        var_2 *= ( 1, 1, 0 );
        var_3 *= ( 1, 1, 0 );
        var_3 = vectornormalize( var_3 );
        var_2 = vectornormalize( var_2 );
        var_4 = vectordot( var_3, var_2 );
        var_5 = cos( var_0 );

        if ( var_4 >= var_5 )
        {
            self notify( "facing" );
            break;
        }

        wait 0.1;
    }
}

_ID35598( var_0, var_1 )
{
    self endon( "death" );
    self endon( "helicopter_done" );
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    common_scripts\utility::waittill_notify_or_timeout( "turret_on_target", var_1 );
}

_ID13069( var_0 )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );

    if ( level._ID25139 )
        var_1 = 1;
    else
        var_1 = 2;

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        if ( !isdefined( var_0 ) )
            return;

        if ( common_scripts\utility::_ID7657() )
        {
            var_3 = magicbullet( "hind_missile_mp", self gettagorigin( "tag_missile_right" ) - ( 0, 0, 64 ), var_0.origin, self.owner );
            var_3._ID35007 = self;
        }
        else
        {
            var_3 = magicbullet( "hind_missile_mp", self gettagorigin( "tag_missile_left" ) - ( 0, 0, 64 ), var_0.origin, self.owner );
            var_3._ID35007 = self;
        }

        var_3 missile_settargetent( var_0 );
        var_3.owner = self;
        var_3 missile_setflightmodedirect();
        wait(0.5 / var_1);
    }
}

dropbombs( var_0 )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );

    if ( !isdefined( var_0 ) )
        return;

    for ( var_1 = 0; var_1 < randomintrange( 2, 5 ); var_1++ )
    {
        if ( common_scripts\utility::_ID7657() )
        {
            var_2 = magicbullet( "hind_bomb_mp", self gettagorigin( "tag_missile_left" ) - ( 0, 0, 45 ), var_0.origin, self.owner );
            var_2._ID35007 = self;
        }
        else
        {
            var_2 = magicbullet( "hind_bomb_mp", self gettagorigin( "tag_missile_right" ) - ( 0, 0, 45 ), var_0.origin, self.owner );
            var_2._ID35007 = self;
        }

        wait(randomfloatrange( 0.35, 0.65 ));
    }
}

_ID15206( var_0 )
{
    var_1 = self.origin;
    var_2 = var_0.origin;
    var_3 = 0;
    var_4 = 40;
    var_5 = ( 0, 0, -196 );

    for ( var_6 = bullettrace( var_1 + var_5, var_2 + var_5, 0, self ); distancesquared( var_6["position"], var_2 + var_5 ) > 10 && var_3 < var_4; var_6 = bullettrace( var_1 + var_5, var_2 + var_5, 0, self ) )
    {
        if ( var_1[2] < var_2[2] )
            var_1 += ( 0, 0, 128 );
        else if ( var_1[2] > var_2[2] )
            var_2 += ( 0, 0, 128 );
        else
        {
            var_1 += ( 0, 0, 128 );
            var_2 += ( 0, 0, 128 );
        }

        var_3++;
    }

    var_7 = [];
    var_7["start"] = var_1;
    var_7["end"] = var_2;
    return var_7;
}

_ID33478( var_0 )
{
    var_1 = _ID15206( var_0 );

    if ( var_1["start"] != self.origin )
    {
        self vehicle_setspeed( 75, 35 );
        _setvehgoalpos( var_1["start"] + ( 0, 0, 30 ), 0 );
        self setgoalyaw( var_0.angles[1] + level.heli_angle_offset );
        self waittill( "goal" );
    }

    if ( var_1["end"] != var_0.origin )
    {
        if ( isdefined( var_0._ID27428 ) && isdefined( var_0._ID27417 ) )
        {
            var_2 = var_0._ID27428;
            var_3 = var_0._ID27417;
        }
        else
        {
            var_2 = 30 + randomint( 20 );
            var_3 = 15 + randomint( 15 );
        }

        self vehicle_setspeed( 75, 35 );
        _setvehgoalpos( var_1["end"] + ( 0, 0, 30 ), 0 );
        self setgoalyaw( var_0.angles[1] + level.heli_angle_offset );
        self waittill( "goal" );
    }
}

_setvehgoalpos( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    var_2 = 0;

    if ( var_2 )
        thread _setvehgoalposadheretomesh( var_0, var_1 );
    else
        self setvehgoalpos( var_0, var_1 );
}

_setvehgoalposadheretomesh( var_0, var_1 )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    var_2 = var_0;

    for (;;)
    {
        if ( !isdefined( self ) )
            return;

        if ( common_scripts\utility::_ID10238( self.origin, var_2 ) < 65536 )
        {
            self setvehgoalpos( var_2, var_1 );
            break;
        }

        var_3 = vectortoangles( var_2 - self.origin );
        var_4 = anglestoforward( var_3 );
        var_5 = self.origin + var_4 * ( 1, 1, 0 ) * 250;
        var_6 = ( 0, 0, 2500 );
        var_7 = var_5 + ( maps\mp\_utility::gethelipilotmeshoffset() + var_6 );
        var_8 = var_5 + maps\mp\_utility::gethelipilotmeshoffset() - var_6;
        var_9 = bullettrace( var_7, var_8, 0, self, 0, 0, 1 );
        var_10 = var_9;

        if ( isdefined( var_9["entity"] ) && var_9["entity"] == self && var_9["normal"][2] > 0.1 )
        {
            var_11 = var_9["position"][2] - 4400;
            var_12 = var_11 - self.origin[2];

            if ( var_12 > 256 )
            {
                var_9["position"] *= ( 1, 1, 0 );
                var_9["position"] += ( 0, 0, self.origin[2] + 256 );
            }
            else if ( var_12 < -256 )
            {
                var_9["position"] *= ( 1, 1, 0 );
                var_9["position"] += ( 0, 0, self.origin[2] - 256 );
            }

            var_10 = var_9["position"] - maps\mp\_utility::gethelipilotmeshoffset() + ( 0, 0, 600 );
        }
        else
            var_10 = var_2;

        self setvehgoalpos( var_10, 0 );
        wait 0.15;
    }
}

_ID16582( var_0 )
{
    self endon( "death" );
    self endon( "leaving" );
    self notify( "flying" );
    self endon( "flying" );
    _ID16645();
    var_1 = var_0;

    while ( isdefined( var_1.target ) )
    {
        var_2 = getent( var_1.target, "targetname" );

        if ( isdefined( var_1._ID27428 ) && isdefined( var_1._ID27417 ) )
        {
            var_3 = var_1._ID27428;
            var_4 = var_1._ID27417;
        }
        else
        {
            var_3 = 30 + randomint( 20 );
            var_4 = 15 + randomint( 15 );
        }

        if ( isdefined( self._ID18563 ) && self._ID18563 )
        {
            wait 0.05;
            continue;
        }

        if ( isdefined( self._ID18731 ) && self._ID18731 )
        {
            wait 0.05;
            continue;
        }

        self vehicle_setspeed( 75, 35 );

        if ( !isdefined( var_2.target ) )
        {
            _setvehgoalpos( var_2.origin + self.zoffset, 1 );
            self waittill( "near_goal" );
        }
        else
        {
            _setvehgoalpos( var_2.origin + self.zoffset, 0 );
            self waittill( "near_goal" );
            self setgoalyaw( var_2.angles[1] );
            self waittillmatch( "goal" );
        }

        var_1 = var_2;
    }
}

_ID16581( var_0 )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self notify( "flying" );
    self endon( "flying" );
    _ID16645();
    thread heli_loop_speed_control( var_0 );
    var_1 = var_0;

    while ( isdefined( var_1.target ) )
    {
        var_2 = getent( var_1.target, "targetname" );

        if ( isdefined( self._ID18731 ) && self._ID18731 )
        {
            wait 0.25;
            continue;
        }

        if ( isdefined( self._ID18563 ) && self._ID18563 )
        {
            wait 0.1;
            continue;
        }

        if ( isdefined( var_1._ID27428 ) && isdefined( var_1._ID27417 ) )
        {
            self.desired_speed = var_1._ID27428;
            self._ID9748 = var_1._ID27417;
        }
        else
        {
            self.desired_speed = 30 + randomint( 20 );
            self._ID9748 = 15 + randomint( 15 );
        }

        if ( self._ID16760 == "flares" )
        {
            self.desired_speed = self.desired_speed * 0.5;
            self._ID9748 = self._ID9748 * 0.5;
        }

        if ( isdefined( var_2.script_delay ) && isdefined( self._ID24976 ) && !_ID16603() )
        {
            _setvehgoalpos( var_2.origin + self.zoffset, 1, 1 );
            self waittill( "near_goal" );
            wait(var_2.script_delay);
        }
        else
        {
            _setvehgoalpos( var_2.origin + self.zoffset, 0, 1 );
            self waittill( "near_goal" );
            self setgoalyaw( var_2.angles[1] );
            self waittillmatch( "goal" );
        }

        var_1 = var_2;
    }
}

heli_loop_speed_control( var_0 )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );

    if ( isdefined( var_0._ID27428 ) && isdefined( var_0._ID27417 ) )
    {
        self.desired_speed = var_0._ID27428;
        self._ID9748 = var_0._ID27417;
    }
    else
    {
        self.desired_speed = 30 + randomint( 20 );
        self._ID9748 = 15 + randomint( 15 );
    }

    var_1 = 0;
    var_2 = 0;

    for (;;)
    {
        var_3 = self.desired_speed;
        var_4 = self._ID9748;

        if ( isdefined( self._ID18563 ) && self._ID18563 )
        {
            wait 0.05;
            continue;
        }

        if ( self._ID16760 != "flares" && isdefined( self._ID24976 ) && !_ID16603() )
            var_3 *= 0.25;

        if ( var_1 != var_3 || var_2 != var_4 )
        {
            self vehicle_setspeed( 75, 35 );
            var_1 = var_3;
            var_2 = var_4;
        }

        wait 0.05;
    }
}

_ID16603()
{
    if ( self.recentdamageamount > 50 )
        return 1;

    if ( self.currentstate == "heavy smoke" )
        return 1;

    return 0;
}

_ID16584( var_0 )
{
    self notify( "flying" );
    self endon( "flying" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );

    for (;;)
    {
        if ( isdefined( self._ID18563 ) && self._ID18563 )
        {
            wait 0.05;
            continue;
        }

        var_1 = _ID14309( var_0 );
        _ID33478( var_1 );

        if ( isdefined( var_1._ID27428 ) && isdefined( var_1._ID27417 ) )
        {
            var_2 = var_1._ID27428;
            var_3 = var_1._ID27417;
        }
        else
        {
            var_2 = 30 + randomint( 20 );
            var_3 = 15 + randomint( 15 );
        }

        self vehicle_setspeed( 75, 35 );
        _setvehgoalpos( var_1.origin + self.zoffset, 1 );
        self setgoalyaw( var_1.angles[1] + level.heli_angle_offset );

        if ( level._ID16590 != 0 )
        {
            self waittill( "near_goal" );
            wait(level._ID16590);
            continue;
        }

        if ( !isdefined( var_1.script_delay ) )
        {
            self waittill( "near_goal" );
            wait(5 + randomint( 5 ));
            continue;
        }

        self waittillmatch( "goal" );
        wait(var_1.script_delay);
    }
}

_ID14309( var_0 )
{
    return updateareanodes( var_0 );
}

_ID16610( var_0 )
{
    self notify( "leaving" );
    self clearlookatent();

    if ( isdefined( self._ID16760 ) && self._ID16760 == "osprey" && isdefined( self.pathgoal ) )
    {
        _setvehgoalpos( self.pathgoal, 1 );
        common_scripts\utility::_ID35637( 5, "goal" );
    }

    if ( !isdefined( var_0 ) )
    {
        var_1 = level._ID16611[randomint( level._ID16611.size )];
        var_0 = var_1.origin;
    }

    var_2 = spawn( "script_origin", var_0 );

    if ( isdefined( var_2 ) )
    {
        self setlookatent( var_2 );
        var_2 thread _ID35429( 3.0 );
    }

    var_3 = ( var_0 - self.origin ) * 2000;
    _ID16645();
    self vehicle_setspeed( 180, 45 );
    _setvehgoalpos( var_3, 1 );
    common_scripts\utility::_ID35637( 12, "goal" );
    self notify( "gone" );
    self notify( "death" );
    wait 0.05;

    if ( isdefined( self._ID19214 ) )
        self._ID19214 delete();

    maps\mp\_utility::decrementfauxvehiclecount();
    self delete();
}

_ID35429( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    wait(var_0);
    self delete();
}

debug_print3d( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( level._ID16552 ) && level._ID16552 == 1.0 )
        thread _ID10858( var_0, var_1, var_2, var_3, var_4 );
}

debug_print3d_simple( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( level._ID16552 ) && level._ID16552 == 1.0 )
    {
        if ( isdefined( var_3 ) )
            thread _ID10858( var_0, ( 0.8, 0.8, 0.8 ), var_1, var_2, var_3 );
        else
            thread _ID10858( var_0, ( 0.8, 0.8, 0.8 ), var_1, var_2, 0 );
    }
}

debug_line( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( level._ID16552 ) && level._ID16552 == 1.0 && !isdefined( var_3 ) )
        thread _ID10843( var_0, var_1, var_2 );
    else if ( isdefined( level._ID16552 ) && level._ID16552 == 1.0 )
        thread _ID10843( var_0, var_1, var_2, var_3 );
}

_ID10858( var_0, var_1, var_2, var_3, var_4 )
{
    if ( var_4 == 0 )
    {
        while ( isdefined( var_2 ) )
            wait 0.05;
    }
    else
    {
        for ( var_5 = 0; var_5 < var_4; var_5++ )
        {
            if ( !isdefined( var_2 ) )
                break;

            wait 0.05;
        }
    }
}

_ID10843( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_3 ) )
    {
        for ( var_4 = 0; var_4 < var_3; var_4++ )
            wait 0.05;
    }
    else
    {
        for (;;)
            wait 0.05;
    }
}

addtohelilist()
{
    level._ID16755[self getentitynumber()] = self;
}

removefromhelilist( var_0 )
{
    level._ID16755[var_0] = undefined;
}

addtolittlebirdlist( var_0 )
{
    if ( isdefined( var_0 ) && var_0 == "lbSniper" )
        level._ID19723 = self;

    level._ID20086[self getentitynumber()] = self;
}

_ID26000( var_0 )
{
    var_1 = self getentitynumber();
    self waittill( "death" );

    if ( isdefined( var_0 ) && var_0 == "lbSniper" )
        level._ID19723 = undefined;

    level._ID20086[var_1] = undefined;
}

_ID12353( var_0 )
{
    if ( level._ID20086.size >= 4 || level._ID20086.size >= 2 && var_0 == "littlebird_flock" )
        return 1;
    else
        return 0;
}

pavelowmadeselectionvo()
{
    self endon( "death" );
    self endon( "disconnect" );
    self playlocalsound( game["voice"][self.team] + "KS_hqr_pavelow" );
    wait 3.5;
    self playlocalsound( game["voice"][self.team] + "KS_pvl_inbound" );
}

_ID19722()
{
    self endon( "gone" );

    if ( !isdefined( self ) )
        return;

    self notify( "crashing" );

    if ( isdefined( self._ID19345 ) && self._ID19345 )
        common_scripts\utility::_ID35582();
    else
    {
        self vehicle_setspeed( 25, 5 );
        thread _ID19724( randomintrange( 180, 220 ) );
        wait(randomfloatrange( 1.0, 2.0 ));
    }

    lbexplode();
}

_ID19724( var_0 )
{
    self endon( "explode" );
    playfxontag( level._ID7233["explode"]["medium"], self, "tail_rotor_jnt" );
    thread _ID33325( level._ID7233["smoke"]["trail"], "tail_rotor_jnt", "stop tail smoke" );
    self setyawspeed( var_0, var_0, var_0 );

    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[1] + var_0 * 0.9 );
        wait 1;
    }
}

lbexplode()
{
    var_0 = self.origin + ( 0, 0, 1 ) - self.origin;
    var_1 = self gettagangles( "tag_deathfx" );
    playfx( level._ID7233["explode"]["air_death"]["littlebird"], self gettagorigin( "tag_deathfx" ), anglestoforward( var_1 ), anglestoup( var_1 ) );
    self playsound( "exp_helicopter_fuel" );
    self notify( "explode" );
    _ID26014();
}

_ID33325( var_0, var_1, var_2 )
{
    self notify( var_2 );
    self endon( var_2 );
    self endon( "death" );

    for (;;)
    {
        playfxontag( var_0, self, var_1 );
        wait 0.05;
    }
}

_ID26014()
{
    if ( isdefined( self._ID21007 ) )
    {
        if ( isdefined( self._ID21007._ID19214 ) )
            self._ID21007._ID19214 delete();

        self._ID21007 delete();
    }

    if ( isdefined( self._ID21008 ) )
    {
        if ( isdefined( self._ID21008._ID19214 ) )
            self._ID21008._ID19214 delete();

        self._ID21008 delete();
    }

    if ( isdefined( self._ID20647 ) )
        self._ID20647 delete();

    if ( isdefined( level.heli_pilot[self.team] ) && level.heli_pilot[self.team] == self )
        level.heli_pilot[self.team] = undefined;

    maps\mp\_utility::decrementfauxvehiclecount();
    self delete();
}
