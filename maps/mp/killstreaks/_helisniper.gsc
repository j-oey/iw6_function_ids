// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    maps\mp\killstreaks\_helicopter_guard::_ID19740();
    maps\mp\killstreaks\_helicopter_guard::_ID19739();
    level._ID30308 = loadfx( "fx/explosions/sniper_incendiary" );
    level._ID19256["heli_sniper"] = ::_ID33851;
    var_0 = spawnstruct();
    var_0._ID36472 = "destroyed_helo_scout";
    var_0.callout = "callout_destroyed_helo_scout";
    var_0.samdamagescale = 0.09;
    var_0.enginevfxtag = "tag_engine_right";
    level.heliconfigs["heli_sniper"] = var_0;
}

_ID33851( var_0, var_1 )
{
    var_2 = getcloseststartnode( self.origin );
    var_3 = getclosestnode( self.origin );
    var_4 = vectortoangles( var_3.origin - var_2.origin );

    if ( isdefined( self.underwater ) && self.underwater )
        return 0;

    if ( isdefined( self.isjuggernautlevelcustom ) && self.isjuggernautlevelcustom == 1 )
        return 0;
    else if ( !isdefined( level.air_node_mesh ) || !isdefined( var_2 ) || !isdefined( var_3 ) )
    {
        self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE_IN_LEVEL" );
        return 0;
    }

    var_5 = 1;

    if ( _ID12352() )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    if ( maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 + var_5 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        return 0;
    }

    if ( isdefined( self.iscapturingcrate ) && self.iscapturingcrate )
        return 0;

    if ( isdefined( self._ID18764 ) && self._ID18764 )
        return 0;

    var_6 = createheli( self, var_2, var_3, var_4, var_1, var_0 );

    if ( !isdefined( var_6 ) )
        return 0;

    var_7 = helipickup( var_6, var_1 );

    if ( isdefined( var_7 ) && var_7 == "fail" )
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
    var_10 = spawnhelicopter( var_0, var_9, var_8, "attack_littlebird_mp", level._ID20077 );

    if ( !isdefined( var_10 ) )
        return;

    var_11 = maps\mp\_utility::_ID15049();
    var_12 = var_7 + ( maps\mp\_utility::gethelipilotmeshoffset() + var_11 );
    var_13 = var_7 + maps\mp\_utility::gethelipilotmeshoffset() - var_11;
    var_14 = bullettrace( var_12, var_13, 0, 0, 0, 0, 1 );

    if ( isdefined( var_14["entity"] ) && var_14["normal"][2] > 0.1 )
        var_7 = var_14["position"] - maps\mp\_utility::gethelipilotmeshoffset() + ( 0, 0, 384 );

    var_10 maps\mp\killstreaks\_helicopter::addtolittlebirdlist( "lbSniper" );
    var_10 thread maps\mp\killstreaks\_helicopter::_ID26000();
    var_10 thread waitfordeath();
    var_10._ID19938 = var_5;
    var_10.forward = var_8;
    var_10.pathstart = var_9;
    var_10.pathgoal = var_7;
    var_10._ID23346 = var_1.origin;
    var_10._ID13433 = var_7[2];
    var_10._ID20741 = var_6.origin;
    var_10.ongroundpos = var_1.origin;
    var_10._ID23552 = var_10.ongroundpos + ( 0, 0, 300 );
    var_10._ID17153 = var_10.ongroundpos + ( 0, 0, 600 );
    var_10.forwardyaw = var_8[1];
    var_10._ID4631 = var_8[1] + 180;

    if ( var_10._ID4631 > 360 )
        var_10._ID4631 = var_10._ID4631 - 360;

    var_10._ID16760 = "littlebird";
    var_10.heli_type = "littlebird";
    var_10._ID20166 = var_1._ID23006;
    var_10.allowsafeeject = 1;
    var_10.attractor = missile_createattractorent( var_10, level._ID16516, level.heli_attract_range );
    var_10._ID18603 = 0;
    var_10.maxhealth = level.heli_maxhealth;
    var_10 thread maps\mp\killstreaks\_flares::_ID13274( 1 );
    var_10 thread maps\mp\killstreaks\_helicopter::_ID16549( "heli_sniper", 1 );
    var_10 thread _ID16725( var_4 );
    var_10.owner = var_0;
    var_10.team = var_0.team;
    var_10 thread leaveonownerdisconnect();
    var_10.speed = 100;
    var_10.ammo = 100;
    var_10._ID13465 = 40;
    var_10 setcandamage( 1 );
    var_10 setmaxpitchroll( 45, 45 );
    var_10 vehicle_setspeed( var_10.speed, 100, 40 );
    var_10 setyawspeed( 120, 60 );
    var_10 sethoverparams( 10, 10, 60 );
    var_10 setneargoalnotifydist( 512 );
    var_10._ID19219 = 0;
    var_10._ID31889 = "heli_sniper";
    var_10.allowboard = 0;
    var_10.ownerboarded = 0;
    var_10 hidepart( "tag_wings" );
    return var_10;
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
    level thread maps\mp\_utility::_ID32672( "used_heli_sniper", self, self.team );

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
    var_0 setvehgoalpos( var_0._ID32619, 1 );
    var_0 thread _ID16724();
    var_0 waittill( "near_goal" );
    var_0 thread _ID16736();
    thread _ID36062( var_0 );
    wait 45;
    self notify( "heli_sniper_timeout" );
    dodropff( var_0 );
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
    self takeweapon( "iw6_gm6helisnipe_mp_gm6scope" );
    self enableweaponswitch();
    maps\mp\_utility::_ID28849();
    var_1 = common_scripts\utility::_ID15114();

    if ( !self hasweapon( var_1 ) )
        var_1 = maps\mp\killstreaks\_killstreaks::_ID15018();

    maps\mp\_utility::_ID32279( var_1 );
    wait 1;

    if ( isdefined( var_0 ) )
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
    self.owner ridevehicle( self, 40, 70, 10, 70, 1 );
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

        if ( isdefined( self.killingattacker ) && isdefined( self.killingattacker.isharrier ) )
            self.killingattacker radiusdamage( self.owner.origin, 200, 2600, 2600, self.killingattacker );
        else if ( isdefined( var_2 ) && var_10 != 2 )
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
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "dropping" );
    self.owner endon( "disconnect" );

    for (;;)
    {
        if ( !isalive( self.owner ) )
            return "fail";

        if ( self.owner getcurrentprimaryweapon() != "iw6_gm6helisnipe_mp_gm6scope" )
        {
            self.owner giveweapon( "iw6_gm6helisnipe_mp_gm6scope" );
            self.owner switchtoweaponimmediate( "iw6_gm6helisnipe_mp_gm6scope" );
            self.owner disableweaponswitch();
            self.owner maps\mp\_utility::_ID28849( 0, 100 );
            self.owner givemaxammo( "iw6_gm6helisnipe_mp_gm6scope" );
        }
        else
            return;

        wait 0.05;
    }
}

_ID26183()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "dropping" );

    for (;;)
    {
        self.owner waittill( "weapon_fired" );
        self.owner givemaxammo( "iw6_gm6helisnipe_mp_gm6scope" );
    }
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
