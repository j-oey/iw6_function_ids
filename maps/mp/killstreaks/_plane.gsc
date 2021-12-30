// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    if ( !isdefined( level.planes ) )
        level.planes = [];

    if ( !isdefined( level._ID23699 ) )
        level._ID23699 = [];

    level.fighter_deathfx = loadfx( "vfx/gameplay/explosions/vehicle/hind_mp/vfx_x_mphnd_primary" );
    level.fx_airstrike_afterburner = loadfx( "vfx/gameplay/mp/killstreaks/vfx_air_superiority_afterburner" );
    level.fx_airstrike_contrail = loadfx( "vfx/gameplay/mp/killstreaks/vfx_aircraft_contrail" );
    level._ID13770 = loadfx( "vfx/gameplay/mp/killstreaks/vfx_acraft_light_wingtip_green" );
    level.fx_airstrike_wingtip_light_red = loadfx( "vfx/gameplay/mp/killstreaks/vfx_acraft_light_wingtip_red" );
}

_ID15022( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = var_0 + var_1 * ( -1 * var_2 );
    var_9 = var_0 + var_1 * var_2;

    if ( var_3 )
    {
        var_8 *= ( 1, 1, 0 );
        var_9 *= ( 1, 1, 0 );
    }

    var_8 += ( 0, 0, var_4 );
    var_9 += ( 0, 0, var_4 );
    var_10 = length( var_8 - var_9 );
    var_11 = var_10 / var_5;
    var_10 = abs( 0.5 * var_10 + var_6 );
    var_12 = var_10 / var_5;
    var_13["startPoint"] = var_8;
    var_13["endPoint"] = var_9;
    var_13["attackTime"] = var_12;
    var_13["flyTime"] = var_11;
    return var_13;
}

_ID10390( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = _ID23703( var_0, var_1, var_3, var_7, var_8 );
    var_9 endon( "death" );
    var_10 = 150;
    var_11 = var_4 + ( ( randomfloat( 2 ) - 1 ) * var_10, ( randomfloat( 2 ) - 1 ) * var_10, 0 );
    var_9 planemove( var_11, var_6, var_5, var_8 );
    var_9 _ID23698();
}

_ID23703( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_1 ) )
        return;

    var_5 = 100;
    var_6 = var_2 + ( ( randomfloat( 2 ) - 1 ) * var_5, ( randomfloat( 2 ) - 1 ) * var_5, 0 );
    var_7 = level._ID23699[var_4];
    var_8 = undefined;
    var_8 = spawn( "script_model", var_6 );
    var_8.team = var_1.team;
    var_8.origin = var_6;
    var_8.angles = vectortoangles( var_3 );
    var_8._ID19938 = var_0;
    var_8._ID31889 = var_4;
    var_8.owner = var_1;
    var_8 setmodel( var_7._ID21275[var_1.team] );

    if ( isdefined( var_7.compassiconfriendly ) )
        var_8 _ID28802( var_7.compassiconfriendly, var_7.compassiconenemy );

    var_8 thread _ID16244();
    var_8 thread _ID16245();
    _ID31482( var_8 );

    if ( !isdefined( var_7.nolightfx ) )
        var_8 thread _ID24628();

    var_8 playloopsound( var_7.inboundsfx );
    var_8 createkillcam( var_4 );
    return var_8;
}

planemove( var_0, var_1, var_2, var_3 )
{
    var_4 = level._ID23699[var_3];
    self moveto( var_0, var_1, 0, 0 );

    if ( isdefined( var_4._ID22773 ) )
        self thread [[ var_4._ID22773 ]]( var_0, var_1, var_2, self.owner, var_3 );

    if ( isdefined( var_4._ID30440 ) )
        thread _ID24637( var_4._ID30440, 0.5 * var_1 );

    wait(0.65 * var_1);

    if ( isdefined( var_4._ID23073 ) )
    {
        self stoploopsound();
        self playloopsound( var_4._ID23073 );
    }

    if ( isdefined( var_4._ID23072 ) )
        self scriptmodelplayanimdeltamotion( var_4._ID23072 );

    wait(0.35 * var_1);
}

_ID23698()
{
    var_0 = level._ID23699[self._ID31889];

    if ( isdefined( var_0._ID22844 ) )
        thread [[ var_0._ID22844 ]]( self.owner, self, self._ID31889 );

    if ( isdefined( self.friendlyteamid ) )
    {
        maps\mp\_utility::_objective_delete( self.friendlyteamid );
        maps\mp\_utility::_objective_delete( self.enemyteamid );
    }

    if ( isdefined( self._ID19214 ) )
        self._ID19214 delete();

    _ID31862( self );
    self notify( "delete" );
    self delete();
}

handleemp( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        if ( var_0 maps\mp\_utility::_ID18610() )
        {
            self notify( "death" );
            return;
        }

        level waittill( "emp_update" );
    }
}

_ID16245()
{
    level endon( "game_ended" );
    self endon( "delete" );
    self waittill( "death" );
    var_0 = anglestoforward( self.angles ) * 200;
    playfx( level.fighter_deathfx, self.origin, var_0 );
    thread _ID23698();
}

_ID16244()
{
    self endon( "end_remote" );
    maps\mp\gametypes\_damage::_ID21371( 800, "helicopter", ::handledeathdamage, ::modifydamage, 1 );
}

modifydamage( var_0, var_1, var_2, var_3 )
{
    var_4 = var_3;
    var_4 = maps\mp\gametypes\_damage::_ID16266( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleapdamage( var_1, var_2, var_4, var_0 );
    return var_4;
}

handledeathdamage( var_0, var_1, var_2, var_3 )
{
    var_4 = level._ID23699[self._ID31889];
    maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, var_4._ID36472, var_4._ID9801, var_4.callout );
    maps\mp\gametypes\_missions::checkaachallenges( var_0, self, var_1 );
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
    wait 0.5;
    playfxontag( level.fx_airstrike_wingtip_light_red, self, "tag_right_wingtip" );
    wait 0.5;
    playfxontag( level._ID13770, self, "tag_left_wingtip" );
}

_ID15250()
{
    var_0 = getent( "airstrikeheight", "targetname" );

    if ( isdefined( var_0 ) )
        return var_0.origin[2];
    else
    {
        var_1 = 950;

        if ( isdefined( level.airstrikeheightscale ) )
            var_1 *= level.airstrikeheightscale;

        return var_1;
    }
}

getplaneflightplan( var_0 )
{
    var_1 = spawnstruct();
    var_1.height = _ID15250();
    var_2 = getent( "airstrikeheight", "targetname" );

    if ( isdefined( var_2 ) && isdefined( var_2.script_noteworthy ) && var_2.script_noteworthy == "fixedposition" )
    {
        var_1._ID32619 = var_2.origin;
        var_1.flightdir = anglestoforward( var_2.angles );

        if ( randomint( 2 ) == 0 )
            var_1.flightdir = var_1.flightdir * -1;
    }
    else
    {
        var_3 = anglestoforward( self.angles );
        var_4 = anglestoright( self.angles );
        var_1._ID32619 = self.origin + var_0 * var_3;
        var_1.flightdir = -1 * var_4;
    }

    return var_1;
}

getexplodedistance( var_0 )
{
    var_1 = 850;
    var_2 = 1500;
    var_3 = var_1 / var_0;
    var_4 = var_3 * var_2;
    return var_4;
}

_ID31482( var_0 )
{
    var_1 = var_0 getentitynumber();
    level.planes[var_1] = var_0;
}

_ID31862( var_0 )
{
    var_1 = var_0 getentitynumber();
    level.planes[var_1] = undefined;
}

_ID28015( var_0, var_1, var_2 )
{
    var_3 = level._ID20638 / 6.46875;

    if ( level.splitscreen )
        var_3 *= 1.5;

    var_4 = level._ID23699[var_1];

    if ( isdefined( var_4._ID28034 ) )
        self playlocalsound( game["voice"][self.team] + var_4._ID28034 );

    maps\mp\_utility::_beginlocationselection( var_1, "map_artillery_selector", var_4.choosedirection, var_3 );
    self endon( "stop_location_selection" );
    self waittill( "confirm_location",  var_5, var_6  );

    if ( !var_4.choosedirection )
        var_6 = randomint( 360 );

    self setblurforplayer( 0, 0.3 );

    if ( isdefined( var_4._ID17499 ) )
        self playlocalsound( game["voice"][self.team] + var_4._ID17499 );

    self thread [[ var_2 ]]( var_0, var_5, var_6, var_1 );
    return 1;
}

_ID28802( var_0, var_1 )
{
    var_2 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_2, "active", ( 0, 0, 0 ), var_0 );
    objective_onentitywithrotation( var_2, self );
    self.friendlyteamid = var_2;
    var_3 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_3, "active", ( 0, 0, 0 ), var_1 );
    objective_onentitywithrotation( var_3, self );
    self.enemyteamid = var_3;

    if ( level._ID32653 )
    {
        objective_team( var_2, self.team );
        objective_team( var_3, maps\mp\_utility::getotherteam( self.team ) );
    }
    else
    {
        var_4 = self.owner getentitynumber();
        objective_playerteam( var_2, var_4 );
        objective_playerenemyteam( var_3, var_4 );
    }
}

_ID24637( var_0, var_1 )
{
    self endon( "death" );
    wait(var_1);
    self playsoundonmovingent( var_0 );
}

createkillcam( var_0 )
{
    var_1 = level._ID23699[var_0];

    if ( isdefined( var_1._ID19217 ) )
    {
        var_2 = anglestoforward( self.angles );
        var_3 = spawn( "script_model", self.origin + ( 0, 0, 100 ) - var_2 * 200 );
        var_3._ID31480 = gettime();
        var_3 setscriptmoverkillcam( "airstrike" );
        var_3 linkto( self, "tag_origin", var_1._ID19217, ( 0, 0, 0 ) );
        self._ID19214 = var_3;
    }
}
