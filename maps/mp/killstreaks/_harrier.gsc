// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

beginharrier( var_0, var_1, var_2 )
{
    var_3 = getent( "airstrikeheight", "targetname" );

    if ( isdefined( var_3 ) )
        var_4 = var_3.origin[2];
    else if ( isdefined( level.airstrikeheightscale ) )
        var_4 = 850 * level.airstrikeheightscale;
    else
        var_4 = 850;

    var_2 *= ( 1, 1, 0 );
    var_5 = var_2 + ( 0, 0, var_4 );
    var_6 = _ID30823( var_0, self, var_1, var_5 );
    var_6.pathgoal = var_5;
    return var_6;
}

_ID14947( var_0, var_1, var_2 )
{
    var_3 = 1200;
    var_4 = _ID33249( var_0, var_1 );
    var_5 = var_4 + var_3;

    if ( isdefined( level.airstrikeheightscale ) && var_5 < 850 * level.airstrikeheightscale )
        var_5 = 950 * level.airstrikeheightscale;

    var_5 += randomint( var_2 );
    return var_5;
}

_ID30823( var_0, var_1, var_2, var_3 )
{
    var_4 = vectortoangles( var_3 - var_2 );
    var_5 = spawnhelicopter( var_1, var_2, var_4, "harrier_mp", "vehicle_av8b_harrier_jet_mp" );

    if ( !isdefined( var_5 ) )
        return;

    var_5 addtohelilist();
    var_5 thread _ID25998();
    var_5 thread handledestroydamage();
    var_5.speed = 250;
    var_5.accel = 175;
    var_5.health = 2500;
    var_5.maxhealth = var_5.health;
    var_5.team = var_1.team;
    var_5.owner = var_1;
    var_5 setcandamage( 1 );
    var_5.owner = var_1;
    var_5 thread _ID16326();
    var_5 setmaxpitchroll( 0, 90 );
    var_5 vehicle_setspeed( var_5.speed, var_5.accel );
    var_5 thread _ID24595();
    var_5 setdamagestage( 3 );
    var_5._ID21199 = 6;
    var_5.pers["team"] = var_5.team;
    var_5 sethoverparams( 50, 100, 50 );
    var_5 setturningability( 0.05 );
    var_5 setyawspeed( 45, 25, 25, 0.5 );
    var_5.defendloc = var_3;
    var_5._ID19938 = var_0;
    var_5.allowmonitoreddamage = 1;
    var_5.isharrier = 1;
    var_5.damagecallback = ::callback_vehicledamage;
    level.harriers = common_scripts\utility::array_removeundefined( level.harriers );
    level.harriers[level.harriers.size] = var_5;
    level._ID16323 = undefined;
    return var_5;
}

defendlocation( var_0 )
{
    var_0 endon( "death" );
    var_0 thread _ID16332();
    var_0 setvehgoalpos( var_0.pathgoal, 1 );
    var_0 thread _ID7584( var_0.pathgoal );
    var_0 waittill( "goal" );
    var_0 _ID31844();
    var_0 engageground();
    var_0 thread monitorowner();
}

_ID7584( var_0 )
{
    self endon( "goal" );
    self endon( "death" );

    for (;;)
    {
        if ( distance2d( self.origin, var_0 ) < 768 )
        {
            self setmaxpitchroll( 45, 25 );
            break;
        }

        wait 0.05;
    }
}

engageground()
{
    self notify( "engageGround" );
    self endon( "engageGround" );
    self endon( "death" );
    thread _ID16328();
    thread _ID25396();
    var_0 = self.defendloc;
    self vehicle_setspeed( 15, 5 );
    self setvehgoalpos( var_0, 1 );
    self waittill( "goal" );
}

_ID16329()
{
    self endon( "death" );
    self setmaxpitchroll( 0, 0 );
    self notify( "leaving" );
    breaktarget( 1 );
    self notify( "stopRand" );

    for (;;)
    {
        self vehicle_setspeed( 35, 25 );
        var_0 = self.origin + anglestoforward( ( 0, randomint( 360 ), 0 ) ) * 500;
        var_0 += ( 0, 0, 900 );
        var_1 = bullettrace( self.origin, self.origin + ( 0, 0, 900 ), 0, self );

        if ( var_1["surfacetype"] == "none" )
            break;

        wait 0.1;
    }

    self setvehgoalpos( var_0, 1 );
    thread _ID31446();
    self waittill( "goal" );
    self playsoundonmovingent( "harrier_fly_away" );
    var_2 = _ID15232();
    self vehicle_setspeed( 250, 75 );
    self setvehgoalpos( var_2, 1 );
    self waittill( "goal" );
    level.harriers[level.harriers.size - 1] = undefined;
    self notify( "harrier_gone" );
    thread _ID16325();
}

_ID16325()
{
    self delete();
}

_ID16332()
{
    self endon( "death" );
    maps\mp\gametypes\_hostmigration::_ID35597( 90 );
    _ID16329();
}

_ID25396()
{
    self notify( "randomHarrierMovement" );
    self endon( "randomHarrierMovement" );
    self endon( "stopRand" );
    self endon( "death" );
    self endon( "acquiringTarget" );
    self endon( "leaving" );
    var_0 = self.defendloc;

    for (;;)
    {
        var_1 = _ID15165( self.origin );
        self setvehgoalpos( var_1, 1 );
        self waittill( "goal" );
        wait(randomintrange( 1, 2 ));
        self notify( "randMove" );
    }
}

_ID15165( var_0, var_1 )
{
    self endon( "stopRand" );
    self endon( "death" );
    self endon( "acquiringTarget" );
    self endon( "leaving" );

    if ( !isdefined( var_1 ) )
    {
        var_2 = [];

        foreach ( var_4 in level.players )
        {
            if ( var_4 == self )
                continue;

            if ( !level._ID32653 || var_4.team != self.team )
                var_2[var_2.size] = var_4.origin;
        }

        if ( var_2.size > 0 )
        {
            var_6 = averagepoint( var_2 );
            var_7 = var_6[0];
            var_8 = var_6[1];
        }
        else
        {
            var_9 = level._ID20634;
            var_10 = level._ID20638 / 4;
            var_7 = randomfloatrange( var_9[0] - var_10, var_9[0] + var_10 );
            var_8 = randomfloatrange( var_9[1] - var_10, var_9[1] + var_10 );
        }

        var_11 = _ID14947( var_7, var_8, 20 );
    }
    else if ( common_scripts\utility::_ID7657() )
    {
        var_12 = self.origin - self._ID5126.origin;
        var_7 = var_12[0];
        var_8 = var_12[1] * -1;
        var_11 = _ID14947( var_7, var_8, 20 );
        var_13 = ( var_8, var_7, var_11 );

        if ( distance2d( self.origin, var_13 ) > 1200 )
        {
            var_8 *= 0.5;
            var_7 *= 0.5;
            var_13 = ( var_8, var_7, var_11 );
        }
    }
    else
    {
        if ( distance2d( self.origin, self._ID5126.origin ) < 200 )
            return;

        var_14 = self.angles[1];
        var_15 = ( 0, var_14, 0 );
        var_16 = self.origin + anglestoforward( var_15 ) * randomintrange( 200, 400 );
        var_11 = _ID14947( var_16[0], var_16[1], 20 );
        var_7 = var_16[0];
        var_8 = var_16[1];
    }

    for (;;)
    {
        var_17 = _ID33251( var_7, var_8, var_11 );

        if ( var_17 != 0 )
            return var_17;

        var_7 = randomfloatrange( var_0[0] - 1200, var_0[0] + 1200 );
        var_8 = randomfloatrange( var_0[1] - 1200, var_0[1] + 1200 );
        var_11 = _ID14947( var_7, var_8, 20 );
    }
}

_ID33251( var_0, var_1, var_2 )
{
    self endon( "stopRand" );
    self endon( "death" );
    self endon( "acquiringTarget" );
    self endon( "leaving" );
    self endon( "randMove" );

    for ( var_3 = 1; var_3 <= 10; var_3++ )
    {
        switch ( var_3 )
        {
            case 1:
                var_4 = bullettrace( self.origin, ( var_0, var_1, var_2 ), 0, self );
                break;
            case 2:
                var_4 = bullettrace( self gettagorigin( "tag_left_wingtip" ), ( var_0, var_1, var_2 ), 0, self );
                break;
            case 3:
                var_4 = bullettrace( self gettagorigin( "tag_right_wingtip" ), ( var_0, var_1, var_2 ), 0, self );
                break;
            case 4:
                var_4 = bullettrace( self gettagorigin( "tag_engine_left2" ), ( var_0, var_1, var_2 ), 0, self );
                break;
            case 5:
                var_4 = bullettrace( self gettagorigin( "tag_engine_right2" ), ( var_0, var_1, var_2 ), 0, self );
                break;
            case 6:
                var_4 = bullettrace( self gettagorigin( "tag_right_alamo_missile" ), ( var_0, var_1, var_2 ), 0, self );
                break;
            case 7:
                var_4 = bullettrace( self gettagorigin( "tag_left_alamo_missile" ), ( var_0, var_1, var_2 ), 0, self );
                break;
            case 8:
                var_4 = bullettrace( self gettagorigin( "tag_right_archer_missile" ), ( var_0, var_1, var_2 ), 0, self );
                break;
            case 9:
                var_4 = bullettrace( self gettagorigin( "tag_left_archer_missile" ), ( var_0, var_1, var_2 ), 0, self );
                break;
            case 10:
                var_4 = bullettrace( self gettagorigin( "tag_light_tail" ), ( var_0, var_1, var_2 ), 0, self );
                break;
            default:
                var_4 = bullettrace( self.origin, ( var_0, var_1, var_2 ), 0, self );
        }

        if ( var_4["surfacetype"] != "none" )
            return 0;

        wait 0.05;
    }

    var_5 = ( var_0, var_1, var_2 );
    return var_5;
}

_ID33249( var_0, var_1 )
{
    self endon( "death" );
    self endon( "acquiringTarget" );
    self endon( "leaving" );
    var_2 = -9999999;
    var_3 = 9999999;
    var_4 = -9999999;
    var_5 = self.origin[2];
    var_6 = undefined;
    var_7 = undefined;

    for ( var_8 = 1; var_8 <= 5; var_8++ )
    {
        switch ( var_8 )
        {
            case 1:
                var_9 = bullettrace( ( var_0, var_1, var_5 ), ( var_0, var_1, var_4 ), 0, self );
                break;
            case 2:
                var_9 = bullettrace( ( var_0 + 20, var_1 + 20, var_5 ), ( var_0 + 20, var_1 + 20, var_4 ), 0, self );
                break;
            case 3:
                var_9 = bullettrace( ( var_0 - 20, var_1 - 20, var_5 ), ( var_0 - 20, var_1 - 20, var_4 ), 0, self );
                break;
            case 4:
                var_9 = bullettrace( ( var_0 + 20, var_1 - 20, var_5 ), ( var_0 + 20, var_1 - 20, var_4 ), 0, self );
                break;
            case 5:
                var_9 = bullettrace( ( var_0 - 20, var_1 + 20, var_5 ), ( var_0 - 20, var_1 + 20, var_4 ), 0, self );
                break;
            default:
                var_9 = bullettrace( self.origin, ( var_0, var_1, var_4 ), 0, self );
        }

        if ( var_9["position"][2] > var_2 )
        {
            var_2 = var_9["position"][2];
            var_6 = var_9;
        }
        else if ( var_9["position"][2] < var_3 )
        {
            var_3 = var_9["position"][2];
            var_7 = var_9;
        }

        wait 0.05;
    }

    return var_2;
}

_ID24595()
{
    self endon( "death" );
    wait 0.2;
    playfxontag( level.fx_airstrike_contrail, self, "tag_right_wingtip" );
    playfxontag( level.fx_airstrike_contrail, self, "tag_left_wingtip" );
    wait 0.2;
    playfxontag( level._ID16321, self, "tag_engine_right" );
    playfxontag( level._ID16321, self, "tag_engine_left" );
    wait 0.2;
    playfxontag( level._ID16321, self, "tag_engine_right2" );
    playfxontag( level._ID16321, self, "tag_engine_left2" );
    wait 0.2;
    playfxontag( level._ID7233["light"]["left"], self, "tag_light_L_wing" );
    wait 0.2;
    playfxontag( level._ID7233["light"]["right"], self, "tag_light_R_wing" );
    wait 0.2;
    playfxontag( level._ID7233["light"]["belly"], self, "tag_light_belly" );
    wait 0.2;
    playfxontag( level._ID7233["light"]["tail"], self, "tag_light_tail" );
}

_ID31844()
{
    stopfxontag( level.fx_airstrike_contrail, self, "tag_right_wingtip" );
    stopfxontag( level.fx_airstrike_contrail, self, "tag_left_wingtip" );
}

_ID31446()
{
    wait 3.0;

    if ( !isdefined( self ) )
        return;

    playfxontag( level.fx_airstrike_contrail, self, "tag_right_wingtip" );
    playfxontag( level.fx_airstrike_contrail, self, "tag_left_wingtip" );
}

getpathstart( var_0 )
{
    var_1 = 100;
    var_2 = 15000;
    var_3 = 850;
    var_4 = randomfloat( 360 );
    var_5 = ( 0, var_4, 0 );
    var_6 = var_0 + anglestoforward( var_5 ) * ( -1 * var_2 );
    var_6 += ( ( randomfloat( 2 ) - 1 ) * var_1, ( randomfloat( 2 ) - 1 ) * var_1, 0 );
    return var_6;
}

_ID15232()
{
    var_0 = 150;
    var_1 = 15000;
    var_2 = 850;
    var_3 = self.angles[1];
    var_4 = ( 0, var_3, 0 );
    var_5 = self.origin + anglestoforward( var_4 ) * var_1;
    return var_5;
}

fireontarget( var_0, var_1 )
{
    self endon( "leaving" );
    self endon( "stopfiring" );
    self endon( "explode" );
    self endon( "death" );
    self._ID5126 endon( "death" );
    self._ID5126 endon( "disconnect" );
    var_2 = gettime();
    var_3 = gettime();
    var_4 = 0;
    self setvehweapon( "harrier_20mm_mp" );

    if ( !isdefined( var_1 ) )
        var_1 = 50;

    for (;;)
    {
        if ( _ID18756( var_0 ) )
        {
            break;
            continue;
        }

        wait 0.25;
    }

    self setturrettargetent( self._ID5126, ( 0, 0, 50 ) );
    var_5 = 25;

    for (;;)
    {
        if ( var_5 == 25 )
            self playloopsound( "weap_hind_20mm_fire_npc" );

        var_5--;
        self fireweapon( "tag_flash", self._ID5126, ( 0, 0, 0 ), 0.05 );
        wait 0.1;

        if ( var_5 <= 0 )
        {
            self stoploopsound();
            wait 1;
            var_5 = 25;
        }
    }
}

_ID18756( var_0 )
{
    self endon( "death" );
    self endon( "leaving" );

    if ( !isdefined( var_0 ) )
        var_0 = 10;

    var_1 = anglestoforward( self.angles );
    var_2 = self._ID5126.origin - self.origin;
    var_1 *= ( 1, 1, 0 );
    var_2 *= ( 1, 1, 0 );
    var_2 = vectornormalize( var_2 );
    var_1 = vectornormalize( var_1 );
    var_3 = vectordot( var_2, var_1 );
    var_4 = cos( var_0 );

    if ( var_3 >= var_4 )
        return 1;
    else
        return 0;
}

acquiregroundtarget( var_0 )
{
    self endon( "death" );
    self endon( "leaving" );

    if ( var_0.size == 1 )
        self._ID5126 = var_0[0];
    else
        self._ID5126 = getbesttarget( var_0 );

    backtodefendlocation( 0 );
    self notify( "acquiringTarget" );
    self setturrettargetent( self._ID5126 );
    self setlookatent( self._ID5126 );
    var_1 = _ID15165( self.origin, 1 );

    if ( !isdefined( var_1 ) )
        var_1 = self.origin;

    self setvehgoalpos( var_1, 1 );
    thread _ID36138();
    thread _ID36139();
    self setvehweapon( "harrier_20mm_mp" );
    thread fireontarget();
}

backtodefendlocation( var_0 )
{
    self setvehgoalpos( self.defendloc, 1 );

    if ( isdefined( var_0 ) && var_0 )
        self waittill( "goal" );
}

_ID36426( var_0 )
{
    var_1 = bullettrace( self.origin, var_0, 1, self );

    if ( var_1["position"] == var_0 )
        return 0;
    else
        return 1;
}

_ID36138()
{
    self notify( "watchTargetDeath" );
    self endon( "watchTargetDeath" );
    self endon( "newTarget" );
    self endon( "death" );
    self endon( "leaving" );
    self._ID5126 waittill( "death" );
    thread breaktarget();
}

_ID36139( var_0 )
{
    self endon( "death" );
    self._ID5126 endon( "death" );
    self._ID5126 endon( "disconnect" );
    self endon( "leaving" );
    self endon( "newTarget" );
    var_1 = undefined;

    if ( !isdefined( var_0 ) )
        var_0 = 1000;

    for (;;)
    {
        if ( !_ID18814( self._ID5126 ) )
        {
            thread breaktarget();
            return;
        }

        if ( !isdefined( self._ID5126 ) )
        {
            thread breaktarget();
            return;
        }

        if ( self._ID5126 sightconetrace( self.origin, self ) < 1 )
        {
            if ( !isdefined( var_1 ) )
                var_1 = gettime();

            if ( gettime() - var_1 > var_0 )
            {
                thread breaktarget();
                return;
            }
        }
        else
            var_1 = undefined;

        wait 0.25;
    }
}

breaktarget( var_0 )
{
    self endon( "death" );
    self clearlookatent();
    self stoploopsound();
    self notify( "stopfiring" );

    if ( isdefined( var_0 ) && var_0 )
        return;

    thread _ID25396();
    self notify( "newTarget" );
    thread _ID16328();
}

_ID16328()
{
    self notify( "harrierGetTargets" );
    self endon( "harrierGetTargets" );
    self endon( "death" );
    self endon( "leaving" );
    var_0 = [];

    for (;;)
    {
        var_0 = [];
        var_1 = level.players;

        if ( isdefined( level.chopper ) && level.chopper.team != self.team && isalive( level.chopper ) )
        {
            if ( !isdefined( level.chopper._ID22128 ) || isdefined( level.chopper._ID22128 ) && !level.chopper._ID22128 )
            {
                thread engagevehicle( level.chopper );
                return;
            }
            else
                backtodefendlocation( 1 );
        }

        if ( isdefined( level._ID20086 ) )
        {
            foreach ( var_3 in level._ID20086 )
            {
                if ( isdefined( var_3 ) && var_3.team != self.team && ( isdefined( var_3.helipilottype ) && var_3.helipilottype == "heli_pilot" ) )
                {
                    thread engagevehicle( var_3 );
                    return;
                }
            }
        }

        for ( var_5 = 0; var_5 < var_1.size; var_5++ )
        {
            var_6 = var_1[var_5];

            if ( _ID18814( var_6 ) )
            {
                if ( isdefined( var_1[var_5] ) )
                    var_0[var_0.size] = var_1[var_5];
            }
            else
                continue;

            wait 0.05;
        }

        if ( var_0.size > 0 )
        {
            acquiregroundtarget( var_0 );
            return;
        }

        wait 1;
    }
}

_ID18814( var_0 )
{
    self endon( "death" );

    if ( !isalive( var_0 ) || var_0.sessionstate != "playing" )
        return 0;

    if ( isdefined( self.owner ) && var_0 == self.owner )
        return 0;

    if ( distance( var_0.origin, self.origin ) > 8192 )
        return 0;

    if ( distance2d( var_0.origin, self.origin ) < 150 )
        return 0;

    if ( !isdefined( var_0.pers["team"] ) )
        return 0;

    if ( level._ID32653 && var_0.pers["team"] == self.team )
        return 0;

    if ( var_0.pers["team"] == "spectator" )
        return 0;

    if ( isdefined( var_0._ID30916 ) && ( gettime() - var_0._ID30916 ) / 1000 <= 5 )
        return 0;

    if ( var_0 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
        return 0;

    var_1 = self.origin + ( 0, 0, -160 );
    var_2 = anglestoforward( self.angles );
    var_3 = var_1 + 144 * var_2;
    var_4 = var_0 sightconetrace( self.origin, self );

    if ( var_4 < 1 )
        return 0;

    return 1;
}

getbesttarget( var_0 )
{
    self endon( "death" );
    var_1 = self gettagorigin( "tag_flash" );
    var_2 = self.origin;
    var_3 = anglestoforward( self.angles );
    var_4 = undefined;
    var_5 = undefined;
    var_6 = 0;

    foreach ( var_8 in var_0 )
    {
        var_9 = abs( vectortoangles( var_8.origin - self.origin )[1] );
        var_10 = abs( self gettagangles( "tag_flash" )[1] );
        var_9 = abs( var_9 - var_10 );
        var_11 = var_8 getweaponslistitems();

        foreach ( var_13 in var_11 )
        {
            if ( issubstr( var_13, "at4" ) || issubstr( var_13, "stinger" ) || issubstr( var_13, "jav" ) )
                var_9 -= 40;
        }

        if ( distance( self.origin, var_8.origin ) > 2000 )
            var_9 += 40;

        if ( !isdefined( var_4 ) )
        {
            var_4 = var_9;
            var_5 = var_8;
            continue;
        }

        if ( var_4 > var_9 )
        {
            var_4 = var_9;
            var_5 = var_8;
        }
    }

    return var_5;
}

_ID13069( var_0 )
{
    self endon( "death" );
    self endon( "leaving" );

    if ( self._ID21199 <= 0 )
        return;

    var_1 = _ID7074( var_0, 256 );

    if ( !isdefined( var_0 ) )
        return;

    if ( distance2d( self.origin, var_0.origin ) < 512 )
        return;

    if ( isdefined( var_1 ) && var_1 )
        return;

    self._ID21199--;
    self setvehweapon( "aamissile_projectile_mp" );

    if ( isdefined( var_0._ID32605 ) )
        var_2 = self fireweapon( "tag_flash", var_0._ID32605, ( 0, 0, -250 ) );
    else
        var_2 = self fireweapon( "tag_flash", var_0, ( 0, 0, -250 ) );

    var_2 missile_setflightmodedirect();
    var_2 missile_settargetent( var_0 );
}

_ID7074( var_0, var_1 )
{
    self endon( "death" );
    self endon( "leaving" );
    var_2 = [];
    var_3 = level.players;
    var_4 = var_0.origin;

    for ( var_5 = 0; var_5 < var_3.size; var_5++ )
    {
        var_6 = var_3[var_5];

        if ( var_6.team != self.team )
            continue;

        var_7 = var_6.origin;

        if ( distance2d( var_7, var_4 ) < 512 )
            return 1;
    }

    return 0;
}

handledestroydamage()
{
    self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

    if ( var_9 == "aamissile_projectile_mp" && var_4 == "MOD_EXPLOSIVE" && var_0 >= self.health )
        callback_vehicledamage( var_1, var_1, 9001, 0, var_4, var_9, var_3, var_2, var_3, 0, 0, var_7 );
}

callback_vehicledamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    if ( ( var_1 == self || isdefined( var_1.pers ) && var_1.pers["team"] == self.team && !level._ID13683 && level._ID32653 ) && var_1 != self.owner )
        return;

    if ( self.health <= 0 )
        return;

    var_2 = maps\mp\gametypes\_damage::handleapdamage( var_5, var_4, var_2, var_1 );

    switch ( var_5 )
    {
        case "odin_projectile_large_rod_mp":
        case "stinger_mp":
        case "javelin_mp":
        case "ac130_105mm_mp":
        case "ac130_40mm_mp":
        case "remotemissile_projectile_mp":
            self._ID19345 = 1;
            var_2 = self.maxhealth + 1;
            break;
        case "at4_mp":
        case "rpg_mp":
            self._ID19345 = 1;
            var_2 = self.maxhealth - 900;
            break;
        case "remote_tank_projectile_mp":
        case "odin_projectile_small_rod_mp":
            var_2 = int( self.maxhealth * 0.34 );
            self._ID19345 = 1;
            break;
        case "iw6_panzerfaust3_mp":
        case "drone_hive_projectile_mp":
        case "switch_blade_child_mp":
            var_2 = int( self.maxhealth * 0.25 );
            self._ID19345 = 1;
            break;
        case "iw6_maaws_mp":
            var_2 = int( self.maxhealth * 0.24 );
            self._ID19345 = 1;
            break;
        default:
            if ( var_5 != "none" )
                var_2 = int( var_2 / 2 );

            self._ID19345 = 0;
            break;
    }

    maps\mp\killstreaks\_killstreaks::_ID19257( var_1, var_5, self );
    var_1 maps\mp\gametypes\_damagefeedback::_ID34528( "" );

    if ( isplayer( var_1 ) && var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
    {
        var_12 = int( var_2 * level.armorpiercingmod );
        var_2 += var_12;
    }

    if ( self.health <= var_2 )
    {
        if ( isplayer( var_1 ) && ( !isdefined( self.owner ) || var_1 != self.owner ) )
        {
            thread maps\mp\_utility::_ID32672( "callout_destroyed_harrier", var_1 );
            var_13 = maps\mp\gametypes\_rank::_ID15328( "destroyed_harrier" );
            var_1 thread maps\mp\gametypes\_rank::_ID36462( "destroyed_harrier" );
            var_1 thread maps\mp\gametypes\_rank::giverankxp( "kill", var_13, var_5, var_4 );
            thread maps\mp\gametypes\_missions::vehiclekilled( self.owner, self, undefined, var_1, var_2, var_4, var_5 );
            var_1 notify( "destroyed_killstreak" );
        }

        if ( var_5 == "heli_pilot_turret_mp" )
            var_1 maps\mp\gametypes\_missions::_ID25038( "ch_enemy_down" );

        maps\mp\gametypes\_missions::checkaachallenges( var_1, self, var_5 );
        self notify( "death" );
    }

    if ( self.health - var_2 <= 900 && ( !isdefined( self._ID30272 ) || !self._ID30272 ) )
    {
        thread _ID23896();
        self._ID30272 = 1;
    }

    self vehicle_finishdamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );
}

_ID23896()
{
    self endon( "death" );
    stopfxontag( level._ID16321, self, "tag_engine_left" );
    playfxontag( level._ID16324, self, "tag_engine_left" );
    stopfxontag( level._ID16321, self, "tag_engine_right" );
    playfxontag( level._ID16324, self, "tag_engine_right" );
    wait 0.15;
    stopfxontag( level._ID16321, self, "tag_engine_left2" );
    playfxontag( level._ID16324, self, "tag_engine_left2" );
    stopfxontag( level._ID16321, self, "tag_engine_right2" );
    playfxontag( level._ID16324, self, "tag_engine_right2" );
    playfxontag( level._ID7233["damage"]["heavy_smoke"], self, "tag_engine_left" );
}

_ID16326()
{
    self endon( "harrier_gone" );
    self waittill( "death" );

    if ( !isdefined( self ) )
        return;

    if ( !isdefined( self._ID19345 ) )
    {
        self vehicle_setspeed( 25, 5 );
        thread _ID16331( randomintrange( 180, 220 ) );
        wait(randomfloatrange( 0.5, 1.5 ));
    }

    harrierexplode();
}

harrierexplode()
{
    self playsound( "harrier_jet_crash" );
    level.harriers[level.harriers.size - 1] = undefined;
    var_0 = self gettagangles( "tag_deathfx" );
    playfx( level._ID16322, self gettagorigin( "tag_deathfx" ), anglestoforward( var_0 ), anglestoup( var_0 ) );
    self notify( "explode" );
    wait 0.05;
    thread _ID16325();
}

_ID16331( var_0 )
{
    self endon( "explode" );
    playfxontag( level._ID7233["explode"]["medium"], self, "tag_origin" );
    self setyawspeed( var_0, var_0, var_0 );

    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[1] + var_0 * 0.9 );
        wait 1;
    }
}

engagevehicle( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "leaving" );
    var_0 endon( "crashing" );
    self endon( "death" );
    acquirevehicletarget( var_0 );
    thread fireonvehicletarget();
}

fireonvehicletarget()
{
    self endon( "leaving" );
    self endon( "stopfiring" );
    self endon( "explode" );
    self._ID5126 endon( "crashing" );
    self._ID5126 endon( "leaving" );
    self._ID5126 endon( "death" );
    var_0 = gettime();

    if ( isdefined( self._ID5126 ) && self._ID5126.classname == "script_vehicle" )
    {
        self setturrettargetent( self._ID5126 );

        for (;;)
        {
            var_1 = distance2d( self.origin, self._ID5126.origin );

            if ( gettime() - var_0 > 2500 && var_1 > 1000 )
            {
                _ID13069( self._ID5126 );
                var_0 = gettime();
            }

            wait 0.1;
        }
    }
}

acquirevehicletarget( var_0 )
{
    self endon( "death" );
    self endon( "leaving" );
    self notify( "newTarget" );
    self._ID5126 = var_0;
    self notify( "acquiringVehTarget" );
    self setlookatent( self._ID5126 );
    thread _ID36145();
    thread _ID36144();
    self setturrettargetent( self._ID5126 );
}

_ID36144()
{
    self endon( "death" );
    self endon( "leaving" );
    self._ID5126 endon( "death" );
    self._ID5126 endon( "drop_crate" );
    self._ID5126 waittill( "crashing" );
    _ID6086();
}

_ID36145()
{
    self endon( "death" );
    self endon( "leaving" );
    self._ID5126 endon( "crashing" );
    self._ID5126 endon( "drop_crate" );
    self._ID5126 waittill( "death" );
    _ID6086();
}

_ID6086()
{
    self clearlookatent();

    if ( isdefined( self._ID5126 ) && !isdefined( self._ID5126._ID22128 ) )
        self._ID5126._ID22128 = 1;

    self notify( "stopfiring" );
    self notify( "newTarget" );
    thread _ID31844();
    thread engageground();
}

_ID12274()
{
    self setmaxpitchroll( 15, 80 );
    self vehicle_setspeed( 50, 100 );
    self setyawspeed( 90, 30, 30, 0.5 );
    var_0 = self.origin;
    var_1 = self.angles[1];

    if ( common_scripts\utility::_ID7657() )
        var_2 = ( 0, var_1 + 90, 0 );
    else
        var_2 = ( 0, var_1 - 90, 0 );

    var_3 = self.origin + anglestoforward( var_2 ) * 500;
    self setvehgoalpos( var_3, 1 );
    self waittill( "goal" );
}

addtohelilist()
{
    level._ID16755[self getentitynumber()] = self;
}

_ID25998()
{
    var_0 = self getentitynumber();
    self waittill( "death" );
    level._ID16755[var_0] = undefined;
}

monitorowner()
{
    self endon( "death" );
    self endon( "leaving" );

    if ( !isdefined( self.owner ) || self.owner.team != self.team )
    {
        thread _ID16329();
        return;
    }

    self.owner common_scripts\utility::_ID35626( "joined_team", "disconnect" );
    thread _ID16329();
}
