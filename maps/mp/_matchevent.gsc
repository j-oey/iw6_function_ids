// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID20663["smoke"] = loadfx( "fx/smoke/smoke_grenade_11sec_mp" );
    level._ID20663["tracer"] = loadfx( "fx/misc/tracer_incoming" );
    level._ID20663["explosion"] = loadfx( "fx/explosions/building_explosion_huge_gulag" );
    level._ID20668["mortar"] = ::domortar;
    level._ID20668["smoke"] = ::_ID10766;
    level._ID20668["airstrike"] = ::_ID10328;
    level._ID20668["pavelow"] = ::dopavelow;
    level._ID20668["heli_insertion"] = ::_ID10579;
    level._ID20668["osprey_insertion"] = ::doospreyinsertion;
    level._ID20670 = 0;
    level thread _ID22877();
}

_ID22877()
{
    if ( level._ID24880 > 0 )
    {
        for (;;)
            level waittill( "connected",  var_0  );
    }
}

onplayerspawned()
{
    self endon( "disconnect" );
    level endon( "matchevent_started" );
    self waittill( "spawned_player" );

    if ( isdefined( level.alliesinsertchopper ) && !level.alliesinsertchopper.droppedoff && level._ID24880 > 0 && self.team == "allies" )
    {
        self playerlinkto( level.alliesinsertchopper );
        level.alliesinsertchopper.linkedplayers[level.alliesinsertchopper.linkedplayers.size] = self;
    }
    else if ( isdefined( level.alliesinsertchopper ) && !level.alliesinsertchopper.droppedoff && level._ID24880 > 0 && self.team == "axis" )
    {
        self playerlinkto( level._ID4606 );
        level._ID4606.linkedplayers[level._ID4606.linkedplayers.size] = self;
    }
}

getmapcenter()
{
    if ( isdefined( level._ID20634 ) )
        return level._ID20634;

    var_0 = getspawnarray( "mp_tdm_spawn_allies_start" );
    var_1 = getspawnarray( "mp_tdm_spawn_axis_start" );

    if ( isdefined( var_0 ) && isdefined( var_0[0] ) && isdefined( var_1 ) && isdefined( var_1[0] ) )
    {
        var_2 = distance( var_0[0].origin, var_1[0].origin ) / 2;
        var_3 = vectortoangles( var_0[0].origin - var_1[0].origin );
        var_3 = vectornormalize( var_3 );
        return var_0[0].origin + var_3 * var_2;
    }

    return ( 0, 0, 0 );
}

_ID15371()
{
    var_0 = getspawnarray( "mp_tdm_spawn_allies_start" );
    var_1 = getspawnarray( "mp_tdm_spawn_axis_start" );

    if ( isdefined( var_0 ) && isdefined( var_0[0] ) && isdefined( var_1 ) && isdefined( var_1[0] ) )
    {
        var_2 = [];
        var_2["axis"] = var_1;
        var_2["allies"] = var_0;
        return var_2;
    }
    else
        return undefined;
}

_ID10579( var_0, var_1, var_2 )
{
    var_3 = 1200;
    var_4 = 1200;
    var_5 = 1000;

    if ( !isdefined( var_0 ) )
        var_0 = "both";

    if ( var_0 == "axis" )
        thread _ID18022( var_1 );
    else if ( var_0 == "allies" )
        thread _ID18021( var_2 );
    else
    {
        thread _ID18021( var_2 );
        thread _ID18022( var_1 );
    }
}

_ID18021( var_0 )
{
    var_1 = _ID15371();
    var_2 = 1200;
    var_3 = 1200;
    var_4 = 1000;

    if ( !isdefined( var_0 ) )
        var_0 = var_1["allies"][0];

    var_5 = anglestoforward( var_1["allies"][0].angles ) * 300;
    var_6 = anglestoup( var_1["allies"][0].angles ) * var_2;
    var_7 = anglestoright( var_1["allies"][0].angles ) * 3200;
    var_8 = anglestoright( var_1["allies"][0].angles ) * -3200;
    var_9 = var_1["allies"][0].origin + var_5 + var_6 + var_7;
    var_10 = var_1["allies"][0].origin + var_5 + var_6 + var_8;
    var_11 = spawnhelicopter( self, var_9, var_1["allies"][0].angles, "pavelow_mp", "vehicle_pavelow" );

    if ( !isdefined( var_11 ) )
        return;

    level.alliesinsertchopper = var_11;
    level.alliesinsertchopper.linkedplayers = [];
    level.alliesinsertchopper.droppedoff = 0;
    var_11 vehicle_setspeed( 50, 15 );
    var_11 setvehgoalpos( var_1["allies"][0].origin + ( 0, 0, var_3 / 2 ), 1 );
    var_11 waittill( "goal" );
    var_11 setyawspeed( 0, 1, 1 );
    var_11 setvehgoalpos( var_1["allies"][0].origin + ( 0, 0, var_3 / 6 ), 1 );
    var_11 waittill( "goal" );
    level.alliesinsertchopper.droppedoff = 1;

    foreach ( var_13 in level.alliesinsertchopper.linkedplayers )
        var_13 unlink();

    wait 2;
    var_11 setyawspeed( 60, 40, 40, 0.3 );
    var_11 setvehgoalpos( var_1["allies"][0].origin + ( 0, 0, var_3 ), 1 );
    var_11 waittill( "goal" );
    var_11 vehicle_setspeed( 80, 60 );
    var_11 setvehgoalpos( var_9 + ( 0, 0, var_4 ) + var_7 * 2, 1 );
    var_11 waittill( "goal" );
    var_11 vehicle_setspeed( 120, 120 );
    var_11 setvehgoalpos( var_9 + ( 0, 0, var_4 ) + var_7 * 2 + var_5 * -20, 1 );
    var_11 waittill( "goal" );
    var_11 delete();
}

_ID18022( var_0 )
{
    var_1 = _ID15371();
    var_2 = 1200;
    var_3 = 1200;
    var_4 = 1000;
    var_5 = anglestoforward( var_1["axis"][0].angles ) * 300;
    var_6 = anglestoup( var_1["axis"][0].angles ) * var_2;
    var_7 = anglestoright( var_1["axis"][0].angles ) * 3200;
    var_8 = anglestoright( var_1["axis"][0].angles ) * -3200;
    var_9 = var_1["axis"][0].origin + var_5 + var_6 + var_7;
    var_10 = var_1["axis"][0].origin + var_5 + var_6 + var_8;
    var_11 = spawnhelicopter( self, var_9, var_1["axis"][0].angles, "pavelow_mp", "vehicle_pavelow" );

    if ( !isdefined( var_11 ) )
        return;

    level._ID4606 = var_11;
    level._ID4606.linkedplayers = [];
    level._ID4606.droppedoff = 0;
    var_11 vehicle_setspeed( 50, 15 );
    var_11 setvehgoalpos( var_1["axis"][0].origin + ( 0, 0, var_3 / 2 ), 1 );
    var_11 waittill( "goal" );
    var_11 setyawspeed( 0, 1, 1 );
    var_11 setvehgoalpos( var_1["axis"][0].origin + ( 0, 0, var_3 / 6 ), 1 );
    var_11 waittill( "goal" );
    level._ID4606.droppedoff = 1;

    foreach ( var_13 in level._ID4606.linkedplayers )
        var_13 unlink();

    wait 2;
    var_11 setyawspeed( 60, 40, 40, 0.3 );
    var_11 setvehgoalpos( var_1["axis"][0].origin + ( 0, 0, var_3 ), 1 );
    var_11 waittill( "goal" );
    var_11 vehicle_setspeed( 80, 60 );
    var_11 setvehgoalpos( var_9 + ( 0, 0, var_4 ) + var_7 * 2, 1 );
    var_11 waittill( "goal" );
    var_11 vehicle_setspeed( 120, 120 );
    var_11 setvehgoalpos( var_9 + ( 0, 0, var_4 ) + var_7 * 2 + var_5 * -20, 1 );
    var_11 waittill( "goal" );
    var_11 delete();
}

domortar()
{
    var_0 = getmapcenter();
    var_1 = 1;

    for ( var_2 = 0; var_2 < 5; var_2++ )
    {
        var_3 = var_0 + ( randomintrange( 100, 600 ) * var_1, randomintrange( 100, 600 ) * var_1, 0 );
        var_4 = bullettrace( var_3 + ( 0, 0, 500 ), var_3 - ( 0, 0, 500 ), 0 );

        if ( isdefined( var_4["position"] ) )
        {
            playfx( level._ID20663["tracer"], var_3 );
            thread maps\mp\_utility::_ID24644( "fast_artillery_round", var_3 );
            wait(randomfloatrange( 0.5, 1.5 ));
            playfx( level._ID20663["explosion"], var_3 );
            playrumbleonposition( "grenade_rumble", var_3 );
            earthquake( 1.0, 0.6, var_3, 2000 );
            thread maps\mp\_utility::_ID24644( "exp_suitcase_bomb_main", var_3 );
            physicsexplosionsphere( var_3 + ( 0, 0, 30 ), 250, 125, 2 );
            var_1 *= -1;
        }
    }
}

_ID10766()
{
    var_0 = getmapcenter();
    var_1 = 1;

    for ( var_2 = 0; var_2 < 3; var_2++ )
    {
        var_3 = var_0 + ( randomintrange( 100, 600 ) * var_1, randomintrange( 100, 600 ) * var_1, 0 );
        playfx( level._ID20663["smoke"], var_3 );
        var_1 *= -1;
        wait 2;
    }
}

_ID10328()
{
    level endon( "game_ended" );
    var_0 = 1;
    var_1 = getmapcenter();

    for ( var_2 = 0; var_2 < 3; var_2++ )
    {
        var_3 = var_1 + ( randomintrange( 100, 600 ) * var_0, randomintrange( 100, 600 ) * var_0, 0 );
        var_4 = bullettrace( var_3 + ( 0, 0, 500 ), var_3 - ( 0, 0, 500 ), 0 );

        if ( isdefined( var_4["position"] ) )
        {
            thread doairstrikeflyby( var_4["position"] );
            var_0 *= -1;
            wait(randomintrange( 2, 4 ));
        }
    }
}

doairstrikeflyby( var_0 )
{
    var_1 = randomint( level.spawnpoints.size - 1 );
    var_2 = level.spawnpoints[var_1].origin * ( 1, 1, 0 );
    var_3 = 8000;
    var_4 = 8000;
    var_5 = getent( "airstrikeheight", "targetname" );
    var_6 = ( 0, 0, var_5.origin[2] + randomintrange( -100, 600 ) );
    var_7 = anglestoforward( ( 0, randomint( 45 ), 0 ) );
    var_8 = var_2 + var_6 + var_7 * var_3 * -1;
    var_9 = var_2 + var_6 + var_7 * var_4;
    var_10 = var_8 + ( randomintrange( 400, 500 ), randomintrange( 400, 500 ), randomintrange( 200, 300 ) );
    var_11 = var_9 + ( randomintrange( 400, 500 ), randomintrange( 400, 500 ), randomintrange( 200, 300 ) );
    var_12 = spawnplane( self, "script_model", var_8 );
    var_13 = spawnplane( self, "script_model", var_10 );

    if ( common_scripts\utility::_ID7657() )
    {
        var_12 setmodel( "vehicle_av8b_harrier_jet_mp" );
        var_13 setmodel( "vehicle_av8b_harrier_jet_mp" );
    }
    else
    {
        var_12 setmodel( "vehicle_av8b_harrier_jet_opfor_mp" );
        var_13 setmodel( "vehicle_av8b_harrier_jet_opfor_mp" );
    }

    var_12.angles = vectortoangles( var_9 - var_8 );
    var_12 playloopsound( "veh_mig29_dist_loop" );
    var_12 thread _ID24628();
    var_13.angles = vectortoangles( var_9 - var_10 );
    var_13 playloopsound( "veh_mig29_dist_loop" );
    var_13 thread _ID24628();
    var_14 = distance( var_8, var_9 );
    var_12 moveto( var_9 * 2, var_14 / 2000, 0, 0 );
    wait(randomfloatrange( 0.25, 0.5 ));
    var_13 moveto( var_11 * 2, var_14 / 2000, 0, 0 );
    wait(var_14 / 2000);
    var_12 delete();
    var_13 delete();
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

dopavelow()
{
    var_0 = getmapcenter();
    var_1 = bullettrace( var_0 + ( 0, 0, 500 ), var_0 - ( 0, 0, 500 ), 0 );

    if ( isdefined( var_1["position"] ) )
    {
        if ( common_scripts\utility::_ID7657() )
            var_2 = "vehicle_pavelow";
        else
            var_2 = "vehicle_pavelow_opfor";

        var_3 = spawnhelicopter( self, var_1["position"] + ( 0, 0, 1000 ), ( 0, 0, 0 ), "pavelow_mp", var_2 );

        if ( !isdefined( var_3 ) )
            return;

        var_3.team = self.pers["team"];
        var_3.heli_type = level._ID16698[var_2];
        var_3 thread [[ level._ID19961[level._ID16698[var_2]] ]]();
        var_3.zoffset = ( 0, 0, var_3 gettagorigin( "tag_origin" )[2] - var_3 gettagorigin( "tag_ground" )[2] );
        wait 1;
        playfxontag( level._ID7233["damage"]["on_fire"], var_3, "tag_engine_left" );
        var_3 thread maps\mp\killstreaks\_helicopter::_ID16534();
    }
}

doospreyinsertion()
{
    var_0 = _ID15371();

    if ( isdefined( var_0 ) )
    {
        var_1 = 200;
        var_2 = 200;
        var_3 = 1000;
        var_4 = anglestoforward( var_0["allies"][0].angles ) * 300;
        var_5 = anglestoup( var_0["allies"][0].angles ) * var_1;
        var_6 = var_0["allies"][0].origin + var_4 + var_5;
        var_7 = spawnhelicopter( self, var_6, var_0["allies"][0].angles, "osprey_minigun_mp", "vehicle_v22_osprey_body_mp" );

        if ( !isdefined( var_7 ) )
            return;

        var_8 = anglestoforward( var_0["axis"][0].angles ) * 300;
        var_9 = anglestoup( var_0["axis"][0].angles ) * var_1;
        var_10 = var_0["axis"][0].origin + var_8 + var_9;
        var_11 = spawnhelicopter( self, var_10, var_0["axis"][0].angles, "osprey_minigun_mp", "vehicle_v22_osprey_body_mp" );

        if ( !isdefined( var_11 ) )
        {
            var_7 delete();
            return;
        }

        var_7 thread maps\mp\killstreaks\_escortairdrop::airshippitchpropsup();
        var_11 thread maps\mp\killstreaks\_escortairdrop::airshippitchpropsup();
        var_7 thread maps\mp\killstreaks\_escortairdrop::airshippitchhatchdown();
        var_11 thread maps\mp\killstreaks\_escortairdrop::airshippitchhatchdown();
        var_7 vehicle_setspeed( 20, 10 );
        var_7 setyawspeed( 3, 3, 3, 0.3 );
        var_7 setvehgoalpos( var_6 + ( 0, 0, var_2 ), 1 );
        var_11 vehicle_setspeed( 20, 10 );
        var_11 setyawspeed( 3, 3, 3, 0.3 );
        var_11 setvehgoalpos( var_10 + ( 0, 0, var_2 ), 1 );
        var_7 waittill( "goal" );
        var_7 thread maps\mp\killstreaks\_escortairdrop::airshippitchhatchup();
        var_11 thread maps\mp\killstreaks\_escortairdrop::airshippitchhatchup();
        wait 2;
        var_7 vehicle_setspeed( 80, 60 );
        var_7 setyawspeed( 30, 15, 15, 0.3 );
        var_7 setvehgoalpos( var_6 + ( 0, 0, var_3 ), 1 );
        var_11 vehicle_setspeed( 80, 60 );
        var_11 setyawspeed( 30, 15, 15, 0.3 );
        var_11 setvehgoalpos( var_10 + ( 0, 0, var_3 ), 1 );
        var_7 waittill( "goal" );
        var_7 thread maps\mp\killstreaks\_escortairdrop::airshippitchpropsdown();
        var_11 thread maps\mp\killstreaks\_escortairdrop::airshippitchpropsdown();
        var_7 vehicle_setspeed( 120, 120 );
        var_7 setyawspeed( 100, 100, 40, 0.3 );
        var_7 setvehgoalpos( var_6 + ( 0, 0, var_3 ) + var_4 * -20, 1 );
        var_11 vehicle_setspeed( 120, 120 );
        var_11 setyawspeed( 100, 100, 40, 0.3 );
        var_11 setvehgoalpos( var_10 + ( 0, 0, var_3 ) + var_8 * -20, 1 );
        var_7 waittill( "goal" );
        var_7 delete();
        var_11 delete();
    }
}
