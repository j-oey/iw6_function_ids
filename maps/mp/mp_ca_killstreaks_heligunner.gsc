// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    maps\mp\killstreaks\_helicopter_guard::_ID19740();
    maps\mp\killstreaks\_helicopter_guard::_ID19739();
    level._ID19276["iw6_cabehemothminigun_mp"] = "heli_gunner";
}

tryuseheligunner( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2._ID36472 = "destroyed_heli_gunner";
    var_2.callout = "callout_destroyed_heli_gunner";
    var_2.samdamagescale = 0.09;
    var_2.enginevfxtag = "tag_engine_right";
    var_2.helicopter_model = "vehicle_ca_blackhawk";
    level.heliconfigs["heli_gunner"] = var_2;
    level._ID19276["iw6_cabehemothminigun_mp"] = "heli_gunner";
    var_3 = getcloseststartnode( self.origin );
    var_4 = getclosestnode( self.origin );
    var_5 = vectortoangles( var_4.origin - var_3.origin );

    if ( isdefined( self.underwater ) && self.underwater )
        return 0;
    else if ( !isdefined( level.air_node_mesh ) || !isdefined( var_3 ) || !isdefined( var_4 ) )
    {
        self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE_IN_LEVEL" );
        return 0;
    }

    var_6 = 1;

    if ( _ID12352() )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    if ( maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 + var_6 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        return 0;
    }

    if ( isdefined( self.iscapturingcrate ) && self.iscapturingcrate )
        return 0;

    if ( isdefined( self._ID18764 ) && self._ID18764 )
        return 0;

    var_7 = createheli( self, var_3, var_4, var_5, var_1, var_0 );

    if ( !isdefined( var_7 ) )
        return 0;

    var_8 = helipickup( var_7, var_1 );

    if ( isdefined( var_8 ) && var_8 == "fail" )
        return 0;

    return 1;
}

_ID12352()
{
    return isdefined( level._ID19723 );
}

getcloseststartnode( var_0 )
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

createheli( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = getent( "airstrikeheight", "targetname" );
    var_7 = var_2.origin;
    var_8 = anglestoforward( var_3 );
    var_9 = var_1.origin;
    var_10 = level.heliconfigs[var_4];
    var_11 = spawnhelicopter( var_0, var_9, var_8, "attack_littlebird_mp", var_10.helicopter_model );

    if ( !isdefined( var_11 ) )
        return;

    var_12 = maps\mp\_utility::_ID15049();
    var_13 = var_7 + ( maps\mp\_utility::gethelipilotmeshoffset() + var_12 );
    var_14 = var_7 + maps\mp\_utility::gethelipilotmeshoffset() - var_12;
    var_15 = bullettrace( var_13, var_14, 0, 0, 0, 0, 1 );

    if ( isdefined( var_15["entity"] ) && var_15["normal"][2] > 0.1 )
        var_7 = var_15["position"] - maps\mp\_utility::gethelipilotmeshoffset() + ( 0, 0, 384 );

    var_11 maps\mp\killstreaks\_helicopter::addtolittlebirdlist( "heli_gunner" );
    var_11 thread maps\mp\killstreaks\_helicopter::_ID26000();
    var_11 thread waitfordeath();
    var_11._ID19938 = var_5;
    var_11.forward = var_8;
    var_11.pathstart = var_9;
    var_11.pathgoal = var_7;
    var_11._ID23346 = var_1.origin;
    var_11._ID13433 = var_7[2];
    var_11._ID20741 = var_6.origin;
    var_11.ongroundpos = var_1.origin;
    var_11._ID23552 = var_11.ongroundpos + ( 0, 0, 300 );
    var_11._ID17153 = var_11.ongroundpos + ( 0, 0, 600 );
    var_11.forwardyaw = var_8[1];
    var_11._ID4631 = var_8[1] + 180;

    if ( var_11._ID4631 > 360 )
        var_11._ID4631 = var_11._ID4631 - 360;

    var_11._ID16760 = "littlebird";
    var_11.heli_type = "littlebird";
    var_11._ID20166 = var_1._ID23006;
    var_11.allowsafeeject = 1;
    var_11._ID31889 = "heli_gunner";
    var_11.owner = var_0;
    var_11.team = var_0.team;
    var_11 thread leaveonownerdisconnect();
    var_11.attractor = missile_createattractorent( var_11, level._ID16516, level.heli_attract_range );
    var_11._ID18603 = 0;
    var_11.maxhealth = 10000;
    var_11 thread maps\mp\killstreaks\_flares::_ID13274( 1 );
    var_11 thread maps\mp\killstreaks\_helicopter::_ID16549( "heli_gunner", 1 );
    var_11 thread _ID16725( "heli_gunner" );
    var_11.speed = 100;
    var_11.ammo = 100;
    var_11._ID13465 = 40;
    var_11 setcandamage( 1 );
    var_11 setmaxpitchroll( 45, 45 );
    var_11 vehicle_setspeed( var_11.speed, 100, 40 );
    var_11 setyawspeed( 120, 60 );
    var_11 sethoverparams( 10, 10, 60 );
    var_11 setneargoalnotifydist( 512 );
    var_11._ID19219 = 0;
    var_11.allowboard = 0;
    var_11.ownerboarded = 1;
    return var_11;
}

_ID14906( var_0 )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "helicopter_removed" );
    self endon( "heightReturned" );
    var_1 = getent( "airstrikeheight", "targetname" );

    if ( isdefined( var_1 ) )
        var_2 = var_1.origin[2];
    else if ( isdefined( level.airstrikeheightscale ) )
        var_2 = 850 * level.airstrikeheightscale;
    else
        var_2 = 850;

    var_3 = bullettrace( var_0, var_0 - ( 0, 0, 10000 ), 0, self, 0, 0, 0, 0 );
    var_4 = var_3["position"][2];
    var_5 = 0;
    var_6 = 0;

    for ( var_7 = 0; var_7 < 30; var_7++ )
    {
        wait 0.05;
        var_8 = var_7 % 8;
        var_9 = var_7 * 7;

        switch ( var_8 )
        {
            case 0:
                var_5 = var_9;
                var_6 = var_9;
                break;
            case 1:
                var_5 = var_9 * -1;
                var_6 = var_9 * -1;
                break;
            case 2:
                var_5 = var_9 * -1;
                var_6 = var_9;
                break;
            case 3:
                var_5 = var_9;
                var_6 = var_9 * -1;
                break;
            case 4:
                var_5 = 0;
                var_6 = var_9 * -1;
                break;
            case 5:
                var_5 = var_9 * -1;
                var_6 = 0;
                break;
            case 6:
                var_5 = var_9;
                var_6 = 0;
                break;
            case 7:
                var_5 = 0;
                var_6 = var_9;
                break;
            default:
                break;
        }

        var_10 = bullettrace( var_0 + ( var_5, var_6, 1000 ), var_0 - ( var_5, var_6, 10000 ), 0, self, 0, 0, 0, 0, 0 );

        if ( isdefined( var_10["entity"] ) )
            continue;

        if ( var_10["position"][2] + 145 > var_4 )
            var_4 = var_10["position"][2] + 145;
    }

    return var_4;
}

helipickup( var_0, var_1 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "crashing" );
    var_0 endon( "owner_disconnected" );
    var_0 endon( "killstreakExit" );
    var_2 = getcloseststartnode( self.origin );
    level thread maps\mp\_utility::_ID32672( "used_heli_gunner", self, self.team );

    if ( isdefined( var_2.angles ) )
        var_3 = var_2.angles;
    else
        var_3 = ( 0, 0, 0 );

    common_scripts\utility::_disableusability();
    var_4 = var_0._ID13433;

    if ( isdefined( var_2._ID21919[0] ) )
        var_5 = var_2._ID21919[0];
    else
        var_5 = getclosestnode( self.origin );

    var_6 = anglestoforward( self.angles );
    var_7 = var_5.origin * ( 1, 1, 0 ) + ( 0, 0, 1 ) * var_4 + var_6 * -100;
    var_0._ID32619 = var_7;
    var_0._ID8699 = var_5;
    var_8 = _ID21648( var_0 );

    if ( isdefined( var_8 ) && var_8 == "fail" )
    {
        var_0 thread helileave();
        return var_8;
    }
    else
    {
        thread _ID37747( var_0 );
        return var_8;
    }
}

chopperselfdamagewatchter()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "owner_disconnected" );
    self endon( "killstreakExit" );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4  );

        if ( var_1 == self.owner )
        {
            self.owner iprintlnbold( "stop hitting yourself!" );
            self.health = self.health + var_0;
        }
    }
}

_ID37747( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "crashing" );
    var_0 endon( "owner_disconnected" );
    var_0 endon( "killstreakExit" );

    if ( isdefined( self._ID17471 ) )
        destroycarriedims();

    var_0 thread _ID15590();
    var_0 setyawspeed( 1, 1, 1, 0.1 );
    var_0 notify( "picked_up_passenger" );
    common_scripts\utility::_enableusability();
    var_0 vehicle_setspeed( var_0.speed, 100, 40 );
    self._ID22850 = 1;
    self.helisniper = var_0;
    var_0 endon( "owner_death" );
    var_0 thread _ID25165();
    var_0 thread _ID19786();
    var_0.owner thermalvisionfofoverlayon();
    var_0 setvehgoalpos( var_0._ID32619, 1 );
    var_0 thread _ID16724();
    givegunnerperks();
    var_0 thread restockplayerhealth();
    var_0 waittill( "near_goal" );
    var_0 thread _ID16736();
    thread _ID36062( var_0 );
    wait 45;
    self notify( "heli_sniper_timeout" );
    dodropff( var_0 );
    takegunnerperks();
}

restockplayerhealth()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "owner_disconnected" );
    self endon( "killstreakExit" );
    self endon( "dropping" );

    for (;;)
    {
        self.owner waittill( "damage" );
        self.owner.health = 100;
    }
}

givegunnerperks()
{
    var_0 = [];
    var_0[0] = "specialty_quickdraw";
    var_0[1] = "specialty_fastreload";
    var_0[2] = "specialty_holdbreath";
    var_0[3] = "specialty_autospot";
    var_0[4] = "specialty_bulletpenetration";
    var_0[5] = "specialty_marksman";
    var_0[6] = "specialty_sharp_focus";
    var_0[7] = "specialty_armorpiercing";
    var_0[8] = "specialty_blindeye";
    var_0[9] = "specialty_incog";
    self.givenperks = [];
    self thermalvisionfofoverlayon();

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( !maps\mp\_utility::_hasperk( var_0[var_1] ) )
        {
            maps\mp\_utility::_ID15611( var_0[var_1], 0 );
            self.givenperks[self.givenperks.size] = var_0[var_1];
        }
    }
}

takegunnerperks()
{
    self thermalvisionfofoverlayoff();

    for ( var_0 = 0; var_0 < self.givenperks.size; var_0++ )
        maps\mp\_utility::_unsetperk( self.givenperks[var_0] );

    self.givenperks = [];
}

dodropff( var_0 )
{
    var_0 notify( "dropping" );
    var_0 thread _ID16753();
    var_0 waittill( "at_dropoff" );
    var_0 vehicle_setspeed( 60 );
    var_0 setyawspeed( 180, 180, 180, 0.3 );
    wait 1;

    if ( !maps\mp\_utility::_ID18757( self ) )
        return;

    thread _ID28900();
    self stopridingvehicle();
    self allowjump( 1 );
    self setstance( "stand" );
    self._ID22850 = 0;
    self.helisniper = undefined;
    var_0.ownerboarded = 0;
    self takeweapon( level.heli_gunner_weapon );
    self enableweaponswitch();
    takegunnerperks();
    var_0.owner notify( "dropping" );
    var_1 = common_scripts\utility::_ID15114();

    if ( !self hasweapon( var_1 ) )
        var_1 = maps\mp\killstreaks\_killstreaks::_ID15018();

    maps\mp\_utility::_ID32279( var_1 );
    wait 1;
    var_0 thread helileave();
}

_ID36062( var_0 )
{
    self endon( "heli_sniper_timeout" );
    var_0 thread maps\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit( "dropping" );
    var_0 waittill( "killstreakExit" );
    dodropff( var_0 );
}

_ID21648( var_0 )
{
    self endon( "disconnect" );
    self visionsetnakedforplayer( "black_bw", 0.5 );
    maps\mp\_utility::set_visionset_for_watching_players( "black_bw", 0.5, 1.0 );
    var_1 = common_scripts\utility::_ID35637( 0.5, "death" );
    maps\mp\gametypes\_hostmigration::_ID35770();

    if ( var_1 == "death" )
    {
        thread maps\mp\killstreaks\_killstreaks::clearrideintro( 1.0 );
        return "fail";
    }

    self cancelmantle();

    if ( var_1 != "disconnect" )
    {
        thread maps\mp\killstreaks\_killstreaks::clearrideintro( 1.0, 0.75 );

        if ( self.team == "spectator" )
            return "fail";
    }

    var_0 attachplayertochopper();

    if ( !isalive( self ) )
        return "fail";

    level.helisnipereyeson = var_0;
    level notify( "update_uplink" );
}

destroycarriedims()
{
    foreach ( var_1 in self._ID17471 )
    {
        if ( isdefined( var_1.carriedby ) && var_1.carriedby == self )
        {
            self forceusehintoff();
            self._ID18582 = undefined;
            self.carrieditem = undefined;

            if ( isdefined( var_1.bombsquadmodel ) )
                var_1.bombsquadmodel delete();

            var_1 delete();
            self enableweapons();
        }
    }
}

_ID16724()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self.owner endon( "death" );
    var_0 = self.origin + anglestoright( self.owner.angles ) * 1000;
    self.lookatent = spawn( "script_origin", var_0 );
    self setlookatent( self.lookatent );
    self setyawspeed( 360, 120 );

    for (;;)
    {
        wait 0.25;
        var_0 = self.origin + anglestoright( self.owner.angles ) * 1000;
        self.lookatent.origin = var_0;
    }
}

attachplayertochopper()
{
    self.owner notify( "force_cancel_sentry" );
    self.owner notify( "force_cancel_ims" );
    self.owner notify( "force_cancel_placement" );
    self.owner notify( "cancel_carryRemoteUAV" );
    self.owner setplayerangles( self gettagangles( "TAG_RIDER" ) );
    self.owner ridevehicle( self, 40, 70, 5, 70, 1 );
    self.owner setstance( "crouch" );
    self.owner allowjump( 0 );
    thread _ID25632();
    self.ownerboarded = 1;
    self notify( "boarded" );
    self.owner.chopper = self;
}

_ID16753()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "owner_disconnected" );
    self endon( "owner_death" );
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = 0;

    foreach ( var_5 in level.air_node_mesh )
    {
        if ( !isdefined( var_5._ID27766 ) || !issubstr( var_5._ID27766, "pickupNode" ) )
            continue;

        var_6 = distancesquared( var_5.origin, self.origin );

        if ( !isdefined( var_2 ) || var_6 < var_2 )
        {
            var_1 = var_5;
            var_2 = var_6;

            if ( var_5._ID27766 == "pickupNodehigh" )
            {
                var_3 = 1;
                continue;
            }

            var_3 = 0;
        }
    }

    if ( maps\mp\_utility::getmapname() == "mp_chasm" )
    {
        if ( var_1.origin == ( -224, -1056, 2376 ) )
            var_1.origin = ( -304, -896, 2376 );
    }

    if ( var_3 && !bullettracepassed( self.origin, var_1.origin, 0, self ) )
    {
        self setvehgoalpos( self.origin + ( 0, 0, 2300 ), 1 );
        _ID35698( "near_goal", "goal", 5 );
        var_8 = var_1.origin;
        var_8 += ( 0, 0, 1500 );
    }
    else if ( var_1.origin[2] > self.origin[2] )
        var_8 = var_1.origin;
    else
    {
        var_8 = var_1.origin * ( 1, 1, 0 );
        var_8 += ( 0, 0, self.origin[2] );
    }

    self setvehgoalpos( var_8, 1 );
    var_9 = _ID14906( var_8 );
    var_10 = var_8 * ( 1, 1, 0 );
    var_11 = var_10 + ( 0, 0, var_9 );
    _ID35698( "near_goal", "goal", 5 );
    self.movedlow = 0;
    self setvehgoalpos( var_11 + ( 0, 0, 200 ), 1 );
    self.droppingoff = 1;
    _ID35698( "near_goal", "goal", 5 );
    self.movedlow = 1;
    self notify( "at_dropoff" );
}

_ID35698( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    self endon( var_0 );
    self endon( var_1 );
    wait(var_2);
}

_ID16736()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "dropping" );
    self vehicle_setspeed( 60, 45, 20 );
    self setneargoalnotifydist( 8 );

    for (;;)
    {
        var_0 = self.owner getnormalizedmovement();

        if ( var_0[0] >= 0.15 || var_0[1] >= 0.15 || var_0[0] <= -0.15 || var_0[1] <= -0.15 )
            thread _ID20627( var_0 );

        wait 0.05;
    }
}

helifreemovementcontrol()
{
    self vehicle_setspeed( 80, 60, 20 );
    self setneargoalnotifydist( 8 );

    for (;;)
    {
        var_0 = self.owner getnormalizedmovement();

        if ( var_0[0] >= 0.15 || var_0[1] >= 0.15 || var_0[0] <= -0.15 || var_0[1] <= -0.15 )
            thread manualmovefree( var_0 );

        wait 0.05;
    }
}

manualmovefree( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "dropping" );
    self notify( "manualMove" );
    self endon( "manualMove" );
    var_1 = anglestoforward( self.owner.angles ) * ( 350 * var_0[0] );
    var_2 = anglestoright( self.owner.angles ) * ( 250 * var_0[1] );
    var_3 = var_1 + var_2;
    var_4 = self.origin + var_3;
    var_4 *= ( 1, 1, 0 );
    var_4 += ( 0, 0, self._ID20741[2] );

    if ( distance2dsquared( ( 0, 0, 0 ), var_4 ) > 8000000 )
        return;

    self setvehgoalpos( var_4, 1 );
    self waittill( "goal" );
}

_ID20627( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "dropping" );
    self notify( "manualMove" );
    self endon( "manualMove" );
    var_1 = anglestoforward( self.owner.angles ) * ( 250 * var_0[0] );
    var_2 = anglestoright( self.owner.angles ) * ( 250 * var_0[1] );
    var_3 = var_1 + var_2;
    var_4 = 256;
    var_5 = self.origin + var_3;
    var_6 = maps\mp\_utility::_ID15049();
    var_7 = var_5 + ( maps\mp\_utility::gethelipilotmeshoffset() + var_6 );
    var_8 = var_5 + maps\mp\_utility::gethelipilotmeshoffset() - var_6;
    var_9 = bullettrace( var_7, var_8, 0, 0, 0, 0, 1 );

    if ( isdefined( var_9["entity"] ) && var_9["normal"][2] > 0.1 )
    {
        var_5 = var_9["position"] - maps\mp\_utility::gethelipilotmeshoffset() + ( 0, 0, var_4 );
        var_10 = var_5[2] - self.origin[2];

        if ( var_10 > 1000 )
            return;

        self setvehgoalpos( var_5, 1 );
        self waittill( "goal" );
    }
}

helileave()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self notify( "end_disconnect_check" );
    self notify( "end_death_check" );
    self notify( "leaving" );

    if ( isdefined( self.ladder ) )
        self.ladder delete();

    if ( isdefined( self.trigger ) )
        self.trigger delete();

    if ( isdefined( self._ID33988 ) )
        self._ID33988 delete();

    if ( isdefined( self._ID21746 ) )
        self._ID21746 maps\mp\gametypes\_hud_util::destroyelem();

    if ( isdefined( self.switchmsg ) )
        self.switchmsg maps\mp\gametypes\_hud_util::destroyelem();

    if ( isdefined( self.movemsg ) )
        self.movemsg maps\mp\gametypes\_hud_util::destroyelem();

    self clearlookatent();
    level.helisnipereyeson = undefined;
    level notify( "update_uplink" );
    self setyawspeed( 220, 220, 220, 0.3 );
    self vehicle_setspeed( 120, 60 );
    self setvehgoalpos( self.origin + ( 0, 0, 1200 ), 1 );
    self waittill( "goal" );
    var_0 = ( self._ID23346 - self.pathgoal ) * 5000;
    self setvehgoalpos( var_0, 1 );
    self vehicle_setspeed( 300, 75 );
    self._ID19788 = 1;
    common_scripts\utility::_ID35637( 5, "goal" );

    if ( isdefined( level._ID19723 ) && level._ID19723 == self )
        level._ID19723 = undefined;

    self notify( "delete" );
    self delete();
}

_ID16725( var_0 )
{
    level endon( "game_ended" );
    self endon( "leaving" );
    self waittill( "death" );
    maps\mp\gametypes\_hostmigration::_ID35770();
    thread maps\mp\killstreaks\_helicopter::_ID19722();

    if ( isdefined( self.ladder ) )
        self.ladder delete();

    if ( isdefined( self.trigger ) )
        self.trigger delete();

    if ( isdefined( self._ID33988 ) )
        self._ID33988 delete();

    if ( isdefined( self._ID21746 ) )
        self._ID21746 maps\mp\gametypes\_hud_util::destroyelem();

    if ( isdefined( self.switchmsg ) )
        self.switchmsg maps\mp\gametypes\_hud_util::destroyelem();

    if ( isdefined( self.movemsg ) )
        self.movemsg maps\mp\gametypes\_hud_util::destroyelem();

    if ( isdefined( self.owner ) && isalive( self.owner ) && self.ownerboarded == 1 )
    {
        self.owner stopridingvehicle();
        var_1 = undefined;
        var_2 = undefined;

        if ( isdefined( self.attackers ) )
        {
            var_3 = 0;

            foreach ( var_6, var_5 in self.attackers )
            {
                if ( var_5 >= var_3 )
                {
                    var_3 = var_5;
                    var_1 = var_6;
                }
            }
        }

        if ( isdefined( var_1 ) )
        {
            foreach ( var_8 in level._ID23303 )
            {
                if ( var_8 maps\mp\_utility::getuniqueid() == var_1 )
                    var_2 = var_8;
            }
        }

        var_10 = getdvarint( "scr_team_fftype" );

        if ( isdefined( var_2 ) && var_10 != 2 )
            radiusdamage( self.owner.origin, 200, 2600, 2600, var_2 );
        else if ( var_10 == 2 && isdefined( var_2 ) && maps\mp\_utility::attackerishittingteam( var_2, self.owner ) )
        {
            radiusdamage( self.owner.origin, 200, 2600, 2600, var_2 );
            radiusdamage( self.owner.origin, 200, 2600, 2600 );
        }
        else
            radiusdamage( self.owner.origin, 200, 2600, 2600 );

        self.owner._ID22850 = 0;
        self.owner.helisniper = undefined;
    }
}

_ID28900()
{
    if ( !maps\mp\_utility::_hasperk( "specialty_falldamage" ) )
    {
        level endon( "game_ended" );
        self endon( "death" );
        self endon( "disconnect" );
        maps\mp\_utility::_ID15611( "specialty_falldamage", 0 );
        wait 2;
        maps\mp\_utility::_unsetperk( "specialty_falldamage" );
    }
}

_ID25632()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "dropping" );
    var_0 = 0;

    for (;;)
    {
        wait 0.05;

        if ( !isdefined( self.owner._ID19959 ) && !self.owner maps\mp\_utility::_ID18666() )
        {
            self.owner maps\mp\perks\_perkfunctions::_ID28771();
            var_0++;

            if ( var_0 >= 2 )
                break;
        }
    }
}

_ID19101()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "dropping" );

    for (;;)
    {
        if ( self.owner getstance() != "crouch" )
            self.owner setstance( "crouch" );

        wait 0.05;
    }
}

_ID15590()
{
    level.heli_gunner_weapon = "iw6_cabehemothminigun_mp";
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "dropping" );
    self.owner endon( "disconnect" );
    var_0 = 0;
    var_1 = 0;

    while ( self.owner getcurrentprimaryweapon() != level.heli_gunner_weapon )
    {
        if ( !isalive( self.owner ) )
            return "fail";

        if ( self.owner getcurrentprimaryweapon() != level.heli_gunner_weapon )
        {
            self.owner giveweapon( level.heli_gunner_weapon );
            self.owner switchtoweaponimmediate( level.heli_gunner_weapon );
            self.owner disableweaponswitch();
            self.owner givemaxammo( level.heli_gunner_weapon );
            self.owner thread _ID26183();
            var_0 = 1;
            var_1 += 1;
        }

        wait 0.05;
    }
}

_ID26183()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "dropping" );

    for (;;)
    {
        self waittill( "weapon_fired" );
        self givestartammo( level.heli_gunner_weapon );
    }
}

update_hit_fx()
{
    self endon( "a10_cannon_stop" );

    for (;;)
    {
        var_0 = self geteye();
        var_1 = self getplayerangles();
        var_2 = anglestoforward( var_1 );
        var_3 = var_0 + var_2 * 7000;
        var_4 = bullettrace( var_0, var_3, 1, self );
        playfx( level._ID1644["vfx_heli_gunner_impact"], var_4["position"] );
        wait 0.15;
    }
}

monitor_gun_audio()
{
    level endon( "game_ended" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "dropping" );
    self endon( "crashing" );
    self.owner notifyonplayercommand( "a10_cannon_start", "+attack" );
    self.owner notifyonplayercommand( "a10_cannon_stop", "-attack" );
    thread gun_audio_cutoff_master();
    var_0 = "veh_a10_npc_fire_gatling_lp";

    for (;;)
    {
        if ( !self.owner attackbuttonpressed() )
            self.owner waittill( "a10_cannon_start" );

        self.owner thread update_hit_fx();
        self playloopsound( var_0 );
        self.owner waittill( "a10_cannon_stop" );
        self stoploopsound( var_0 );
    }
}

gun_audio_cutoff_master()
{
    thread gun_audio_cutoff( "death", self.owner );
    thread gun_audio_cutoff( "game_ended", level );
    thread gun_audio_cutoff( "disconnect", self.owner );
    thread gun_audio_cutoff( "dropping", self.owner );
    thread gun_audio_cutoff( "crashing", self );
}

gun_audio_cutoff( var_0, var_1 )
{
    self endon( "audio_end" );
    var_1 waittill( var_0 );
    self notify( "audio_end" );
}

_ID25165()
{
    level endon( "game_ended" );
    self.owner endon( "disconnect" );
    self endon( "death" );
    self endon( "crashing" );
    self.owner waittill( "death" );
    self.owner._ID22850 = 0;
    self.owner.helisniper = undefined;
    self.ownerboarded = 0;

    if ( isdefined( self.origin ) )
        physicsexplosionsphere( self.origin, 200, 200, 1 );
}

leaveonownerdisconnect()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "end_disconnect_check" );
    self.owner waittill( "disconnect" );
    self notify( "owner_disconnected" );
    thread helileave();
}

_ID19786()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "end_death_check" );
    self.owner waittill( "death" );
    self notify( "owner_death" );
    thread helileave();
}

getclosestnode( var_0 )
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

waitfordeath()
{
    var_0 = self getentitynumber();
    self waittill( "death" );
    level._ID19723 = undefined;

    if ( isdefined( level.helisnipereyeson ) )
    {
        level.helisnipereyeson = undefined;
        level notify( "update_uplink" );
    }
}
