// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    precacheitem( "aamissile_projectile_mp" );
    precachemodel( "vehicle_av8b_harrier_jet_mp" );
    level._ID32650["axis"] = 0;
    level._ID32650["allies"] = 0;
    level._ID26359 = [];
    level._ID19256["aastrike"] = ::_ID33829;
}

_ID33829( var_0, var_1 )
{
    maps\mp\_matchdata::_ID20253( "aastrike", self.origin );
    thread _ID12949( var_0 );
    thread maps\mp\_utility::_ID32672( "used_aastrike", self, self.team );
    return 1;
}

cycletargets()
{
    self endon( "stopFindingTargets" );
    self endon( "disconnect" );
    self endon( "owner_gone" );
    self endon( "game_ended" );

    for (;;)
    {
        wait 0.05;
        _ID12943();
        wait(randomintrange( 4, 5 ));
    }
}

_ID12943()
{
    self endon( "disconnect" );
    self endon( "owner_gone" );
    self endon( "game_ended" );
    var_0 = [];
    var_1 = [];
    var_2 = [];

    if ( isdefined( level._ID20086 ) && level._ID20086.size )
    {
        foreach ( var_4 in level._ID20086 )
        {
            if ( isdefined( var_4.team ) && var_4.team != self.team )
                var_0[var_0.size] = var_4;
        }
    }

    if ( isdefined( level._ID16755 ) && level._ID16755.size )
    {
        foreach ( var_7 in level._ID16755 )
        {
            if ( var_7.team != self.team )
                var_1[var_1.size] = var_7;
        }
    }

    var_9 = maps\mp\_utility::getotherteam( self.team );

    if ( isdefined( level.activeuavs[var_9] ) )
    {
        foreach ( var_11 in level._ID34165[var_9] )
            var_2[var_2.size] = var_11;
    }

    var_13 = 0;

    foreach ( var_4 in var_0 )
    {
        wait 3;

        if ( var_13 % 2 )
            thread _ID13047( var_4, self.team, 1 );
        else
            thread _ID13047( var_4, self.team, 0 );

        var_13++;
    }

    foreach ( var_7 in var_1 )
    {
        wait 3;
        thread _ID13047( var_7, self.team, 1 );
    }

    foreach ( var_11 in var_2 )
    {
        wait 0.5;
        thread _ID13047( var_11, self.team, 0 );
    }
}

earlyabortwatcher()
{
    self endon( "stopFindingTargets" );
    var_0 = self.team;

    if ( maps\mp\_utility::bot_is_fireteam_mode() )
        self waittill( "killstreak_disowned" );
    else
        common_scripts\utility::_ID35663( "killstreak_disowned", "game_ended" );

    self notify( "owner_gone" );
    level._ID32650[maps\mp\_utility::getotherteam( var_0 )] = 0;
    level.airdeniedplayer = undefined;
}

_ID12949( var_0 )
{
    self endon( "disconnect" );
    self endon( "owner_gone" );
    self endon( "game_ended" );
    level._ID32650[maps\mp\_utility::getotherteam( self.team )] = 1;
    level.airdeniedplayer = self;
    thread earlyabortwatcher();
    thread cycletargets();

    for ( var_1 = 0; var_1 < 4; var_1++ )
    {
        wait 6;

        if ( var_1 == 1 || var_1 == 3 )
        {
            thread _ID10390( 1 );
            continue;
        }

        thread _ID10390( 0 );
    }

    wait 3;
    self notify( "stopFindingTargets" );
    level._ID32650[maps\mp\_utility::getotherteam( self.team )] = 0;
    level.airdeniedplayer = undefined;
}

_ID13047( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_3 = ( 0, 0, 14000 );
    var_4 = ( 0, 0, 1500 );
    var_5 = 15000;
    var_6 = 20000;
    var_7 = var_0.origin;
    var_3 = ( 0, 0, 1 ) * var_7 + ( 0, 0, 1000 );
    var_8 = var_0.angles * ( 0, 1, 0 );
    var_9 = anglestoforward( var_8 );
    var_10 = var_0.origin + var_4 + var_9 * var_5 * -1;
    var_11 = var_0.origin + var_4 + var_9 * var_6;
    var_12 = magicbullet( "aamissile_projectile_mp", var_10 + ( 0, 0, -75 ), var_0.origin, self );
    var_12 missile_settargetent( var_0 );
    var_12 missile_setflightmodedirect();
    var_13 = magicbullet( "aamissile_projectile_mp", var_10 + ( randomint( 500 ), randomint( 500 ), -75 ), var_0.origin, self );
    var_13 missile_settargetent( var_0 );
    var_13 missile_setflightmodedirect();

    if ( var_2 )
        var_14 = spawnplane( self, "script_model", var_10, "compass_objpoint_airstrike_friendly", "compass_objpoint_airstrike_friendly" );
    else
        var_14 = spawnplane( self, "script_model", var_10 );

    if ( self.team == "allies" )
        var_14 setmodel( "vehicle_av8b_harrier_jet_mp" );
    else
        var_14 setmodel( "vehicle_av8b_harrier_jet_opfor_mp" );

    var_15 = distance( var_10, var_11 );
    var_14.angles = vectortoangles( var_11 - var_10 );
    var_14 thread aasoundmanager( var_15 );
    var_14 thread _ID24628();
    var_15 = distance( var_10, var_11 );
    var_14 moveto( var_11 * 2, var_15 / 2000, 0, 0 );
    wait(var_15 / 3000);
    var_14 delete();
}

aasoundmanager( var_0 )
{
    self playloopsound( "veh_aastrike_flyover_loop" );
    wait(var_0 / 2 / 2000);
    self stoploopsound();
    self playloopsound( "veh_aastrike_flyover_outgoing_loop" );
}

_ID10390( var_0 )
{
    self endon( "disconnect" );
    var_1 = randomint( level.spawnpoints.size - 1 );
    var_2 = level.spawnpoints[var_1].origin * ( 1, 1, 0 );
    var_3 = 20000;
    var_4 = 20000;
    var_5 = getent( "airstrikeheight", "targetname" );
    var_6 = ( 0, 0, var_5.origin[2] + randomintrange( -100, 600 ) );
    var_7 = anglestoforward( ( 0, randomint( 45 ), 0 ) );
    var_8 = var_2 + var_6 + var_7 * var_3 * -1;
    var_9 = var_2 + var_6 + var_7 * var_4;
    var_10 = var_8 + ( randomintrange( 400, 500 ), randomintrange( 400, 500 ), randomintrange( 200, 300 ) );
    var_11 = var_9 + ( randomintrange( 400, 500 ), randomintrange( 400, 500 ), randomintrange( 200, 300 ) );

    if ( var_0 )
        var_12 = spawnplane( self, "script_model", var_8, "hud_minimap_harrier_green", "hud_minimap_harrier_red" );
    else
        var_12 = spawnplane( self, "script_model", var_8 );

    var_13 = spawnplane( self, "script_model", var_10 );

    if ( self.team == "allies" )
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
    var_12 playloopsound( "veh_aastrike_flyover_loop" );
    var_12 thread _ID24628();
    var_13.angles = vectortoangles( var_9 - var_10 );
    var_13 thread _ID24628();
    var_14 = distance( var_8, var_9 );
    var_12 moveto( var_9 * 2, var_14 / 1800, 0, 0 );
    wait(randomfloatrange( 0.25, 0.5 ));
    var_13 moveto( var_11 * 2, var_14 / 1800, 0, 0 );
    wait(var_14 / 1600);
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
