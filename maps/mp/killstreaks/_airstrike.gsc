// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    precachelocationselector( "map_artillery_selector" );
    level._ID2725 = loadfx( "fx/explosions/clusterbomb" );
    level.airstrikessfx = loadfx( "fx/explosions/clusterbomb_no_fount" );
    level.airstrikeexplosion = loadfx( "fx/explosions/clusterbomb_exp_direct_runner_cheap" );
    level._ID21489 = loadfx( "fx/explosions/clusterbomb_exp_direct_runner_stealth" );
    level.bombstrike = loadfx( "fx/explosions/wall_explosion_pm_a" );
    level.airburstbomb = loadfx( "fx/explosions/airburst" );
    level.harriers = [];
    level.fx_airstrike_afterburner = loadfx( "fx/fire/jet_afterburner" );
    level.fx_airstrike_contrail = loadfx( "fx/smoke/jet_contrail" );
    level.dangermaxradius["stealth_airstrike"] = 900;
    level.dangerminradius["stealth_airstrike"] = 750;
    level._ID8988["stealth_airstrike"] = 1;
    level.dangerovalscale["stealth_airstrike"] = 6.0;
    level.dangermaxradius["airstrike"] = 550;
    level.dangerminradius["airstrike"] = 300;
    level._ID8988["airstrike"] = 1.5;
    level.dangerovalscale["airstrike"] = 6.0;
    level.dangermaxradius["precision_airstrike"] = 550;
    level.dangerminradius["precision_airstrike"] = 300;
    level._ID8988["precision_airstrike"] = 2.0;
    level.dangerovalscale["precision_airstrike"] = 6.0;
    level.dangermaxradius["harrier_airstrike"] = 550;
    level.dangerminradius["harrier_airstrike"] = 300;
    level._ID8988["harrier_airstrike"] = 1.5;
    level.dangerovalscale["harrier_airstrike"] = 6.0;
    level._ID3910 = [];
    level._ID19256["airstrike"] = ::_ID33832;
    level._ID19256["precision_airstrike"] = ::_ID33832;
    level._ID19256["super_airstrike"] = ::_ID33832;
    level._ID19256["harrier_airstrike"] = ::_ID33832;
    level._ID19256["stealth_airstrike"] = ::_ID33832;
    level.planes = [];
}

_ID33832( var_0, var_1 )
{
    switch ( var_1 )
    {
        case "precision_airstrike":
            break;
        case "stealth_airstrike":
            break;
        case "harrier_airstrike":
            if ( isdefined( level._ID16323 ) || level.harriers.size >= 1 )
            {
                self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
                return 0;
            }

            break;
        case "super_airstrike":
            break;
    }

    var_2 = _ID28015( var_0, var_1 );

    if ( !isdefined( var_2 ) || !var_2 )
        return 0;

    return 1;
}

_ID10328( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( var_5 == "harrier_airstrike" )
        level._ID16323 = 1;

    if ( isdefined( level.airstrikeinprogress ) )
    {
        while ( isdefined( level.airstrikeinprogress ) )
            level waittill( "begin_airstrike" );

        level.airstrikeinprogress = 1;
        wait 2.0;
    }

    if ( !isdefined( var_3 ) )
    {
        if ( var_5 == "harrier_airstrike" )
            level._ID16323 = undefined;

        return;
    }

    level.airstrikeinprogress = 1;
    var_6 = bullettrace( var_1, var_1 + ( 0, 0, -1e+06 ), 0, undefined );
    var_7 = var_6["position"];
    var_8 = spawnstruct();
    var_8.origin = var_7;
    var_8.forward = anglestoforward( ( 0, var_2, 0 ) );
    var_8._ID31889 = var_5;
    var_8.team = var_4;
    level._ID3910[level._ID3910.size] = var_8;
    callstrike( var_0, var_3, var_7, var_2, var_5 );

    if ( var_5 == "harrier_airstrike" )
        level._ID16323 = undefined;

    wait 1.0;
    level.airstrikeinprogress = undefined;
    var_3 notify( "begin_airstrike" );
    level notify( "begin_airstrike" );
    wait 7.5;
    var_9 = 0;
    var_10 = [];

    for ( var_11 = 0; var_11 < level._ID3910.size; var_11++ )
    {
        if ( !var_9 && level._ID3910[var_11].origin == var_7 )
        {
            var_9 = 1;
            continue;
        }

        var_10[var_10.size] = level._ID3910[var_11];
    }

    level._ID3910 = var_10;
}

clearprogress( var_0 )
{
    wait 2.0;
    level.airstrikeinprogress = undefined;
}

getairstrikedanger( var_0 )
{
    var_1 = 0;

    for ( var_2 = 0; var_2 < level._ID3910.size; var_2++ )
    {
        var_3 = level._ID3910[var_2].origin;
        var_4 = level._ID3910[var_2].forward;
        var_5 = level._ID3910[var_2]._ID31889;
        var_1 += _ID15335( var_0, var_3, var_4, var_5 );
    }

    return var_1;
}

_ID15335( var_0, var_1, var_2, var_3 )
{
    var_4 = var_1 + level._ID8988[var_3] * level.dangermaxradius[var_3] * var_2;
    var_5 = var_0 - var_4;
    var_5 = ( var_5[0], var_5[1], 0 );
    var_6 = vectordot( var_5, var_2 ) * var_2;
    var_7 = var_5 - var_6;
    var_8 = var_7 + var_6 / level.dangerovalscale[var_3];
    var_9 = lengthsquared( var_8 );

    if ( var_9 > level.dangermaxradius[var_3] * level.dangermaxradius[var_3] )
        return 0;

    if ( var_9 < level.dangerminradius[var_3] * level.dangerminradius[var_3] )
        return 1;

    var_10 = sqrt( var_9 );
    var_11 = ( var_10 - level.dangerminradius[var_3] ) / ( level.dangermaxradius[var_3] - level.dangerminradius[var_3] );
    return 1 - var_11;
}

_ID24716( var_0, var_1, var_2, var_3 )
{
    return distance2d( var_0, var_1 ) <= level.dangermaxradius[var_3] * 1.25;
}

_ID20374( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = maps\mp\gametypes\_weapons::_ID14960( var_0, var_1, 1 );
    glassradiusdamage( var_0, var_1, var_2, var_3 );

    for ( var_8 = 0; var_8 < var_7.size; var_8++ )
    {
        if ( var_7[var_8].entity == self )
            continue;

        var_9 = distance( var_0, var_7[var_8]._ID8961 );

        if ( var_7[var_8]._ID18738 || isdefined( var_7[var_8]._ID18776 ) && var_7[var_8]._ID18776 )
        {
            var_10 = !bullettracepassed( var_7[var_8].entity.origin, var_7[var_8].entity.origin + ( 0, 0, 130 ), 0, undefined );

            if ( var_10 )
            {
                var_10 = !bullettracepassed( var_7[var_8].entity.origin + ( 0, 0, 130 ), var_0 + ( 0, 0, 114 ), 0, undefined );

                if ( var_10 )
                {
                    var_9 *= 4;

                    if ( var_9 > var_1 )
                        continue;
                }
            }
        }

        var_7[var_8].damage = int( var_2 + ( var_3 - var_2 ) * var_9 / var_1 );
        var_7[var_8]._ID24745 = var_0;
        var_7[var_8]._ID8979 = var_4;
        var_7[var_8].einflictor = var_5;
        level.airstrikedamagedents[level.airstrikedamagedentscount] = var_7[var_8];
        level.airstrikedamagedentscount++;
    }

    thread airstrikedamageentsthread( var_6 );
}

airstrikedamageentsthread( var_0 )
{
    self notify( "airstrikeDamageEntsThread" );
    self endon( "airstrikeDamageEntsThread" );

    while ( level.airstrikedamagedentsindex < level.airstrikedamagedentscount )
    {
        if ( !isdefined( level.airstrikedamagedents[level.airstrikedamagedentsindex] ) )
        {

        }
        else
        {
            var_1 = level.airstrikedamagedents[level.airstrikedamagedentsindex];

            if ( !isdefined( var_1.entity ) )
            {

            }
            else if ( !var_1._ID18738 || isalive( var_1.entity ) )
            {
                var_1 maps\mp\gametypes\_weapons::_ID8966( var_1.einflictor, var_1._ID8979, var_1.damage, "MOD_PROJECTILE_SPLASH", var_0, var_1._ID24745, vectornormalize( var_1._ID8961 - var_1._ID24745 ) );
                level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;

                if ( var_1._ID18738 )
                    wait 0.05;
            }
            else
                level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;
        }

        level.airstrikedamagedentsindex++;
    }
}

radiusartilleryshellshock( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = level.players;

    foreach ( var_7 in level.players )
    {
        if ( !isalive( var_7 ) )
            continue;

        if ( var_7.team == var_4 || var_7.team == "spectator" )
            continue;

        var_8 = var_7.origin + ( 0, 0, 32 );
        var_9 = distance( var_0, var_8 );

        if ( var_9 > var_1 )
            continue;

        var_10 = int( var_2 + ( var_3 - var_2 ) * var_9 / var_1 );
        var_7 thread artilleryshellshock( "default", var_10 );
    }
}

artilleryshellshock( var_0, var_1 )
{
    self endon( "disconnect" );

    if ( isdefined( self.beingartilleryshellshocked ) && self.beingartilleryshellshocked )
        return;

    self.beingartilleryshellshocked = 1;
    self shellshock( var_0, var_1 );
    wait(var_1 + 1);
    self.beingartilleryshellshocked = 0;
}

dobomberstrike( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isdefined( var_1 ) )
        return;

    var_10 = 100;
    var_11 = 150;
    var_12 = var_4 + ( ( randomfloat( 2 ) - 1 ) * var_10, ( randomfloat( 2 ) - 1 ) * var_10, 4000 );
    var_13 = var_5 + ( ( randomfloat( 2 ) - 1 ) * var_11, ( randomfloat( 2 ) - 1 ) * var_11, 4000 );
    var_14 = spawnplane( var_1, "script_model", var_12, "compass_objpoint_b2_airstrike_friendly", "compass_objpoint_b2_airstrike_enemy" );
    addplanetolist( var_14 );
    var_14 thread _ID16245();
    var_14 playloopsound( "veh_b2_dist_loop" );
    var_14 setmodel( "vehicle_b2_bomber" );
    var_14 thread handleemp( var_1 );
    var_14._ID19938 = var_0;
    var_14.angles = var_8;
    var_15 = anglestoforward( var_8 );
    var_14 moveto( var_13, var_7, 0, 0 );
    thread _ID31714( var_14, var_13, var_7, var_9 );
    thread _ID5459( var_14, var_3, var_1 );
    var_14 endon( "death" );
    wait(var_7 * 0.65);
    removeplanefromlist( var_14 );
    var_14 notify( "delete" );
    var_14 delete();
}

_ID5459( var_0, var_1, var_2 )
{
    var_0 endon( "death" );

    while ( !_ID32613( var_0, var_1, 5000 ) )
        wait 0.05;

    var_3 = 1;
    var_4 = 0;
    var_0 notify( "start_bombing" );
    var_5 = 0;

    for ( var_6 = _ID32607( var_0, var_1 ); var_6 < 5000; var_6 = _ID32607( var_0, var_1 ) )
    {
        if ( var_6 < 1500 && !var_4 )
        {
            var_0 playsoundonmovingent( "veh_b2_sonic_boom" );
            var_4 = 1;
        }

        if ( var_6 < 3000 && var_5 < 4 )
        {
            var_0 thread dropparachutebomb( var_0, var_2 );
            var_5++;
            wait(randomfloatrange( 0.15, 0.3 ));
        }

        wait 0.1;
    }

    var_0 notify( "stop_bombing" );
}

dropparachutebomb( var_0, var_1 )
{
    self endon( "stop_bombing" );
    self endon( "death" );
    var_2 = spawn( "script_model", self.origin );
    var_2 setmodel( "parachute_cargo_static" );
    var_2.team = var_1.team;
    var_2.owner = var_1;
    var_2 setcandamage( 1 );
    var_3 = bullettrace( var_2.origin, var_2.origin - ( 0, 0, 20000 ), 0, var_2, 0, 0 );
    var_4 = var_3["position"];
    var_2 moveto( var_4, randomintrange( 8, 14 ) );
    var_2 thread _ID5456( var_0, var_4 );
    var_2 thread bombwatcher( var_0, var_4 );
}

_ID5456( var_0, var_1 )
{
    var_2 = self;
    self endon( "death" );
    self setcandamage( 1 );
    self.health = 999999;
    self.maxhealth = 200;
    self.damagetaken = 0;

    for (;;)
    {
        self waittill( "damage",  var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12  );

        if ( !maps\mp\gametypes\_weapons::_ID13695( self.owner, var_4 ) )
            continue;

        if ( !isdefined( self ) )
            return;

        self._ID35908 = 1;
        self.damagetaken = self.damagetaken + var_3;

        if ( isplayer( var_4 ) )
            var_4 maps\mp\gametypes\_damagefeedback::_ID34528( "tactical_insertion" );

        if ( self.damagetaken >= self.maxhealth )
        {
            radiusdamage( var_2.origin, 1024, 600, 65, var_2.owner, "MOD_EXPLOSIVE", "stealth_bomb_mp" );
            playfx( level.airburstbomb, var_2.origin, anglestoforward( var_2.angles ), var_2.origin - var_1 );

            if ( isdefined( var_2 ) )
                var_2 delete();

            self notify( "death" );
        }
    }
}

bombwatcher( var_0, var_1 )
{
    var_2 = self;
    var_2 endon( "death" );

    while ( var_2.origin[2] > var_1[2] + 600 )
        wait 0.1;

    radiusdamage( var_1 + ( 0, 0, 64 ), 1024, 600, 65, var_0.owner, "MOD_EXPLOSIVE", "stealth_bomb_mp" );
    playfx( level.airburstbomb, var_2.origin, anglestoforward( var_2.angles ), var_2.origin - var_1 );
    var_2 delete();
}

_ID23889()
{
    self endon( "stop_bombing" );
    self endon( "death" );

    for (;;)
    {
        playfxontag( level.stealthbombfx, self, "tag_left_alamo_missile" );
        playfxontag( level.stealthbombfx, self, "tag_right_alamo_missile" );
        wait 0.5;
    }
}

_ID31714( var_0, var_1, var_2, var_3 )
{
    var_0 waittill( "start_bombing" );
    var_4 = anglestoforward( var_0.angles );
    var_5 = spawn( "script_model", var_0.origin + ( 0, 0, 100 ) - var_4 * 200 );
    var_0._ID19214 = var_5;
    var_0._ID19214 setscriptmoverkillcam( "airstrike" );
    var_0.airstriketype = var_3;
    var_5._ID31480 = gettime();
    var_5 thread _ID9603( 15.0 );
    var_5 linkto( var_0, "tag_origin", ( -256, 768, 768 ), ( 0, 0, 0 ) );
}

_ID6500( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_1 ) || var_1 maps\mp\_utility::_ID18678() )
    {
        self notify( "stop_bombing" );
        return;
    }

    var_4 = 512;
    var_5 = ( 0, randomint( 360 ), 0 );
    var_6 = var_0 + anglestoforward( var_5 ) * randomfloat( var_4 );
    var_7 = bullettrace( var_6, var_6 + ( 0, 0, -10000 ), 0, undefined );
    var_6 = var_7["position"];
    var_8 = distance( var_0, var_6 );

    if ( var_8 > 5000 )
        return;

    wait(0.85 * var_8 / 2000);

    if ( !isdefined( var_1 ) || var_1 maps\mp\_utility::_ID18678() )
    {
        self notify( "stop_bombing" );
        return;
    }

    if ( var_3 )
    {
        playfx( level._ID21489, var_6 );
        level thread maps\mp\gametypes\_shellshock::_ID31713( var_6 );
    }

    thread maps\mp\_utility::_ID24644( "exp_airstrike_bomb", var_6 );
    radiusartilleryshellshock( var_6, 512, 8, 4, var_1.team );
    _ID20374( var_6 + ( 0, 0, 16 ), 896, 300, 50, var_1, self, "stealth_bomb_mp" );
}

handleharrierairstrikeobjectiveicons()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    wait 2;
    maps\mp\killstreaks\_plane::_ID28802( "hud_minimap_harrier_green", "hud_minimap_harrier_red" );
    thread cleanupharrierairstrikeobjectiveicons();
}

cleanupharrierairstrikeobjectiveicons()
{
    var_0 = self.friendlyteamid;
    var_1 = self.enemyteamid;
    common_scripts\utility::_ID35637( 3.5, "death" );

    if ( isdefined( var_0 ) )
    {
        maps\mp\_utility::_objective_delete( var_0 );
        maps\mp\_utility::_objective_delete( var_1 );
    }
}

_ID10758( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isdefined( var_1 ) )
        return;

    var_10 = 100;
    var_11 = 150;
    var_12 = var_4 + ( ( randomfloat( 2 ) - 1 ) * var_10, ( randomfloat( 2 ) - 1 ) * var_10, 0 );
    var_13 = var_5 + ( ( randomfloat( 2 ) - 1 ) * var_11, ( randomfloat( 2 ) - 1 ) * var_11, 0 );
    var_14 = spawn( "script_model", var_12 );
    var_14.owner = var_1;
    var_14.origin = var_12;
    var_14.angles = var_8;
    var_14.team = var_1.team;
    var_14 thread _ID16245();

    if ( var_9 == "harrier_airstrike" )
    {
        var_14 setmodel( "vehicle_av8b_harrier_jet_mp" );
        var_14 playloopsound( "harrier_fly_in" );
    }
    else
    {
        var_14 setmodel( "vehicle_a10_warthog_iw6_mp" );
        var_14 playloopsound( "veh_mig29_dist_loop" );
    }

    var_14 thread handleemp( var_1 );
    var_14._ID19938 = var_0;
    var_14.angles = var_8;
    var_15 = anglestoforward( var_8 );
    var_14 thread _ID24628();
    var_14 moveto( var_13, var_7, 0, 0 );

    if ( var_9 == "harrier_airstrike" )
        var_14 thread handleharrierairstrikeobjectiveicons();

    thread callstrike_bombeffect( var_14, var_13, var_7, var_6 - 1.0, var_1, var_2, var_9 );
    wait(var_6 - 0.75);
    var_14 scriptmodelplayanimdeltamotion( "airstrike_mp_roll" );
    var_14 endon( "death" );
    wait(var_7 - var_6);
    removeplanefromlist( var_14 );
    var_14 notify( "delete" );
    var_14 delete();
}

_ID16245()
{
    level endon( "game_ended" );
    self endon( "delete" );
    self waittill( "death" );
    var_0 = anglestoforward( self.angles ) * 200;
    playfx( level._ID16322, self.origin, var_0 );
    removeplanefromlist( self );
    self delete();
}

addplanetolist( var_0 )
{
    level.planes[level.planes.size] = var_0;
}

removeplanefromlist( var_0 )
{
    for ( var_1 = 0; var_1 < level.planes.size; var_1++ )
    {
        if ( isdefined( level.planes[var_1] ) && level.planes[var_1] == var_0 )
            level.planes[var_1] = undefined;
    }
}

callstrike_bombeffect( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_0 endon( "death" );
    wait(var_3);

    if ( !isdefined( var_4 ) || var_4 maps\mp\_utility::_ID18678() )
        return;

    if ( var_6 == "harrier_airstrike" )
        var_0 playsoundonmovingent( "harrier_sonic_boom" );
    else
        var_0 playsoundonmovingent( "veh_mig29_sonic_boom" );

    var_7 = anglestoforward( var_0.angles );
    var_8 = _ID30819( var_0.origin, var_0.angles );
    var_8 movegravity( anglestoforward( var_0.angles ) * 4666.67, 3.0 );
    var_8._ID19938 = var_5;
    var_9 = spawn( "script_model", var_0.origin + ( 0, 0, 100 ) - var_7 * 200 );
    var_8._ID19214 = var_9;
    var_8._ID19214 setscriptmoverkillcam( "airstrike" );
    var_8.airstriketype = var_6;
    var_9._ID31480 = gettime();
    var_9 thread _ID9603( 15.0 );
    var_9.angles = var_7;
    var_9 moveto( var_1 + ( 0, 0, 100 ), var_2, 0, 0 );
    wait 0.4;
    var_9 moveto( var_9.origin + var_7 * 4000, 1, 0, 0 );
    wait 0.45;
    var_9 moveto( var_9.origin + ( var_7 + ( 0, 0, -0.2 ) ) * 3500, 2, 0, 0 );
    wait 0.15;
    var_10 = spawn( "script_model", var_8.origin );
    var_10 setmodel( "tag_origin" );
    var_10.origin = var_8.origin;
    var_10.angles = var_8.angles;
    var_8 setmodel( "tag_origin" );
    wait 0.1;
    var_11 = var_10.origin;
    var_12 = var_10.angles;

    if ( level.splitscreen )
        playfxontag( level.airstrikessfx, var_10, "tag_origin" );
    else
        playfxontag( level._ID2725, var_10, "tag_origin" );

    wait 0.05;
    var_9 moveto( var_9.origin + ( var_7 + ( 0, 0, -0.25 ) ) * 2500, 2, 0, 0 );
    wait 0.25;
    var_9 moveto( var_9.origin + ( var_7 + ( 0, 0, -0.35 ) ) * 2000, 2, 0, 0 );
    wait 0.2;
    var_9 moveto( var_9.origin + ( var_7 + ( 0, 0, -0.45 ) ) * 1500, 2, 0, 0 );
    wait 0.5;
    var_13 = 12;
    var_14 = 5;
    var_15 = 55;
    var_16 = ( var_15 - var_14 ) / var_13;
    var_17 = ( 0, 0, 0 );

    for ( var_18 = 0; var_18 < var_13; var_18++ )
    {
        var_19 = anglestoforward( var_12 + ( var_15 - var_16 * var_18, randomint( 10 ) - 5, 0 ) );
        var_20 = var_11 + var_19 * 10000;
        var_21 = bullettrace( var_11, var_20, 0, undefined );
        var_22 = var_21["position"];
        var_17 += var_22;
        playfx( level.airstrikeexplosion, var_22 );
        thread _ID20374( var_22 + ( 0, 0, 16 ), 512, 200, 30, var_4, var_8, "artillery_mp" );

        if ( var_18 % 3 == 0 )
        {
            thread maps\mp\_utility::_ID24644( "exp_airstrike_bomb", var_22 );
            level thread maps\mp\gametypes\_shellshock::airstrike_earthquake( var_22 );
        }

        wait 0.05;
    }

    var_17 = var_17 / var_13 + ( 0, 0, 128 );
    var_9 moveto( var_8._ID19214.origin * 0.35 + var_17 * 0.65, 1.5, 0, 0.5 );
    wait 5.0;
    var_10 delete();
    var_8 delete();
}

_ID30819( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0 );
    var_2.angles = var_1;
    var_2 setmodel( "projectile_cbu97_clusterbomb" );
    return var_2;
}

_ID9603( var_0 )
{
    self endon( "death" );
    wait 10.0;
    self delete();
}

_ID24628()
{
    self endon( "death" );
    wait 0.5;
    playfxontag( level.fx_airstrike_afterburner, self, "tag_engine_right" );
    wait 0.5;
    playfxontag( level.fx_airstrike_afterburner, self, "tag_engine_left" );
    wait 0.5;
    playfxontag( level.fx_airstrike_contrail, self, "tag_right_wingtip" );
    wait 0.5;
    playfxontag( level.fx_airstrike_contrail, self, "tag_left_wingtip" );
}

callstrike( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = undefined;
    var_6 = 0;
    var_7 = ( 0, var_3, 0 );
    var_5 = getent( "airstrikeheight", "targetname" );

    if ( var_4 == "stealth_airstrike" )
    {
        thread maps\mp\_utility::_ID32672( "used_stealth_airstrike", var_1, var_1.team );
        var_8 = 12000;
        var_9 = 4000;

        if ( !isdefined( var_5 ) )
        {
            var_10 = 950;
            var_6 = 1500;

            if ( isdefined( level.airstrikeheightscale ) )
                var_10 *= level.airstrikeheightscale;
        }
        else
        {
            var_10 = var_5.origin[2];

            if ( getdvar( "mapname" ) == "mp_exchange" )
                var_10 += 1024;

            var_6 = getexplodedistance( var_10 );
        }
    }
    else
    {
        if ( var_4 == "harrier_airstrike" )
            thread maps\mp\_utility::_ID32672( "used_harrier", var_1 );

        var_8 = 24000;
        var_9 = 7000;

        if ( !isdefined( var_5 ) )
        {
            var_10 = 850;
            var_6 = 1500;

            if ( isdefined( level.airstrikeheightscale ) )
                var_10 *= level.airstrikeheightscale;
        }
        else
        {
            var_10 = var_5.origin[2];
            var_6 = getexplodedistance( var_10 );
        }
    }

    var_1 endon( "disconnect" );
    var_11 = var_0;
    level.airstrikedamagedents = [];
    level.airstrikedamagedentscount = 0;
    level.airstrikedamagedentsindex = 0;

    if ( var_4 == "harrier_airstrike" )
    {
        var_12 = _ID15022( var_2, var_7, var_8, var_5, var_10, var_9, var_6, var_4 );
        level thread _ID10758( var_0, var_1, var_11, var_2, var_12["startPoint"] + ( 0, 0, randomint( 500 ) ), var_12["endPoint"] + ( 0, 0, randomint( 500 ) ), var_12["bombTime"], var_12["flyTime"], var_7, var_4 );
        wait(randomfloatrange( 1.5, 2.5 ));
        maps\mp\gametypes\_hostmigration::_ID35770();
        level thread _ID10758( var_0, var_1, var_11, var_2, var_12["startPoint"] + ( 0, 0, randomint( 200 ) ), var_12["endPoint"] + ( 0, 0, randomint( 200 ) ), var_12["bombTime"], var_12["flyTime"], var_7, var_4 );
        wait(randomfloatrange( 1.5, 2.5 ));
        maps\mp\gametypes\_hostmigration::_ID35770();
        level thread _ID10758( var_0, var_1, var_11, var_2, var_12["startPoint"] + ( 0, 0, randomint( 200 ) ), var_12["endPoint"] + ( 0, 0, randomint( 200 ) ), var_12["bombTime"], var_12["flyTime"], var_7, var_4 );
        wait(randomfloatrange( 1.5, 2.5 ));
        maps\mp\gametypes\_hostmigration::_ID35770();
        var_13 = maps\mp\killstreaks\_harrier::beginharrier( var_0, var_12["startPoint"], var_2 );
        var_1 thread maps\mp\killstreaks\_harrier::defendlocation( var_13 );
    }
    else if ( var_4 == "stealth_airstrike" )
    {
        var_12 = _ID15022( var_2, var_7, var_8, var_5, var_10, var_9, var_6, var_4 );
        level thread dobomberstrike( var_0, var_1, var_11, var_2, var_12["startPoint"] + ( 0, 0, randomint( 1000 ) ), var_12["endPoint"] + ( 0, 0, randomint( 1000 ) ), var_12["bombTime"], var_12["flyTime"], var_7, var_4 );
    }
    else
    {
        var_12 = _ID15022( var_2, var_7, var_8, var_5, var_10, var_9, var_6, var_4 );
        level thread _ID10758( var_0, var_1, var_11, var_2, var_12["startPoint"] + ( 0, 0, randomint( 500 ) ), var_12["endPoint"] + ( 0, 0, randomint( 500 ) ), var_12["bombTime"], var_12["flyTime"], var_7, var_4 );
        wait(randomfloatrange( 1.5, 2.5 ));
        maps\mp\gametypes\_hostmigration::_ID35770();
        level thread _ID10758( var_0, var_1, var_11, var_2, var_12["startPoint"] + ( 0, 0, randomint( 200 ) ), var_12["endPoint"] + ( 0, 0, randomint( 200 ) ), var_12["bombTime"], var_12["flyTime"], var_7, var_4 );
        wait(randomfloatrange( 1.5, 2.5 ));
        maps\mp\gametypes\_hostmigration::_ID35770();
        level thread _ID10758( var_0, var_1, var_11, var_2, var_12["startPoint"] + ( 0, 0, randomint( 200 ) ), var_12["endPoint"] + ( 0, 0, randomint( 200 ) ), var_12["bombTime"], var_12["flyTime"], var_7, var_4 );

        if ( var_4 == "super_airstrike" )
        {
            wait(randomfloatrange( 2.5, 3.5 ));
            maps\mp\gametypes\_hostmigration::_ID35770();
            level thread _ID10758( var_0, var_1, var_11, var_2, var_12["startPoint"] + ( 0, 0, randomint( 200 ) ), var_12["endPoint"] + ( 0, 0, randomint( 200 ) ), var_12["bombTime"], var_12["flyTime"], var_7, var_4 );
        }
    }
}

_ID15022( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = var_0 + anglestoforward( var_1 ) * ( -1 * var_2 );

    if ( isdefined( var_3 ) )
        var_8 *= ( 1, 1, 0 );

    var_8 += ( 0, 0, var_4 );

    if ( var_7 == "stealth_airstrike" )
        var_9 = var_0 + anglestoforward( var_1 ) * ( var_2 * 4 );
    else
        var_9 = var_0 + anglestoforward( var_1 ) * var_2;

    if ( isdefined( var_3 ) )
        var_9 *= ( 1, 1, 0 );

    var_9 += ( 0, 0, var_4 );
    var_10 = length( var_8 - var_9 );
    var_11 = var_10 / var_5;
    var_10 = abs( var_10 / 2 + var_6 );
    var_12 = var_10 / var_5;
    var_13["startPoint"] = var_8;
    var_13["endPoint"] = var_9;
    var_13["bombTime"] = var_12;
    var_13["flyTime"] = var_11;
    return var_13;
}

getexplodedistance( var_0 )
{
    var_1 = 850;
    var_2 = 1500;
    var_3 = var_1 / var_0;
    var_4 = var_3 * var_2;
    return var_4;
}

_ID32607( var_0, var_1 )
{
    var_2 = _ID32614( var_0, var_1 );

    if ( var_2 )
        var_3 = 1;
    else
        var_3 = -1;

    var_4 = common_scripts\utility::_ID13335( var_0.origin );
    var_5 = var_4 + anglestoforward( common_scripts\utility::_ID13333( var_0.angles ) ) * ( var_3 * 100000 );
    var_6 = pointonsegmentnearesttopoint( var_4, var_5, var_1 );
    var_7 = distance( var_4, var_6 );
    return var_7;
}

_ID32613( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 3000;

    var_3 = _ID32614( var_0, var_1 );

    if ( var_3 )
        var_4 = 1;
    else
        var_4 = -1;

    var_5 = common_scripts\utility::_ID13335( var_0.origin );
    var_6 = var_5 + anglestoforward( common_scripts\utility::_ID13333( var_0.angles ) ) * ( var_4 * 100000 );
    var_7 = pointonsegmentnearesttopoint( var_5, var_6, var_1 );
    var_8 = distance( var_5, var_7 );

    if ( var_8 < var_2 )
        return 1;
    else
        return 0;
}

_ID32614( var_0, var_1 )
{
    var_2 = anglestoforward( common_scripts\utility::_ID13333( var_0.angles ) );
    var_3 = vectornormalize( common_scripts\utility::_ID13335( var_1 ) - var_0.origin );
    var_4 = vectordot( var_2, var_3 );

    if ( var_4 > 0 )
        return 1;
    else
        return 0;
}

_ID35541()
{
    self waittill( "cancel_location" );
    self setblurforplayer( 0, 0.3 );
}

_ID28015( var_0, var_1 )
{
    var_2 = level._ID20638 / 6.46875;

    if ( level.splitscreen )
        var_2 *= 1.5;

    var_3 = 0;

    switch ( var_1 )
    {
        case "precision_airstrike":
            var_3 = 1;
            self playlocalsound( game["voice"][self.team] + "KS_hqr_airstrike" );
            break;
        case "stealth_airstrike":
            var_3 = 1;
            self playlocalsound( game["voice"][self.team] + "KS_hqr_bomber" );
            break;
    }

    if ( var_1 != "harrier_airstrike" )
    {
        maps\mp\_utility::_beginlocationselection( var_1, "map_artillery_selector", var_3, var_2 );
        self endon( "stop_location_selection" );
        self waittill( "confirm_location",  var_4, var_5  );
    }
    else
    {
        var_6 = [];

        foreach ( var_8 in level.players )
        {
            if ( !isdefined( var_8 ) )
                continue;

            if ( !isdefined( var_8.team ) )
                continue;

            if ( var_8.team == self.team )
                continue;

            var_6[var_6.size] = var_8.origin;
        }

        if ( var_6.size )
            var_10 = averagepoint( var_6 );
        else
            var_10 = ( 0, 0, 0 );

        var_4 = var_10;
        var_5 = randomint( 360 );
    }

    if ( !var_3 )
        var_5 = randomint( 360 );

    self setblurforplayer( 0, 0.3 );

    if ( var_1 == "harrier_airstrike" && ( isdefined( level._ID16323 ) || level.harriers.size > 1 ) )
    {
        self notify( "cancel_location" );
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    thread airstrikemadeselectionvo( var_1 );
    maps\mp\_matchdata::_ID20253( var_1, var_4 );
    thread _ID12950( var_0, var_4, var_5, var_1 );
    return 1;
}

_ID12950( var_0, var_1, var_2, var_3 )
{
    self notify( "used" );
    var_4 = bullettrace( level._ID20634 + ( 0, 0, 1e+06 ), level._ID20634, 0, undefined );
    var_1 = ( var_1[0], var_1[1], var_4["position"][2] - 514 );
    thread _ID10328( var_0, var_1, var_2, self, self.pers["team"], var_3 );
}

_ID34724( var_0, var_1, var_2 )
{

}

handleemp( var_0 )
{
    self endon( "death" );

    if ( var_0 maps\mp\_utility::_ID18610() )
    {
        self notify( "death" );
        return;
    }

    for (;;)
    {
        level waittill( "emp_update" );

        if ( !var_0 maps\mp\_utility::_ID18610() )
            continue;

        self notify( "death" );
    }
}

airstrikemadeselectionvo( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );

    switch ( var_0 )
    {
        case "precision_airstrike":
            self playlocalsound( game["voice"][self.team] + "KS_ast_inbound" );
            break;
        case "stealth_airstrike":
            self playlocalsound( game["voice"][self.team] + "KS_bmb_inbound" );
            break;
    }
}
