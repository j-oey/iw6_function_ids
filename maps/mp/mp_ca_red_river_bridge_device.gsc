// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID37861()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    level.allow_level_killstreak = maps\mp\_utility::allowlevelkillstreaks();

    if ( !level.allow_level_killstreak || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "warhawk_mortars", 85, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"KILLSTREAKS_HINTS_WARHAWK_MORTARS" );
    level thread _ID38284();
}

_ID38284()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "warhawk_mortars" )
        {
            _ID37110();
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                _ID37158();
                continue;
            }

            game["player_holding_level_killstrek"] = 1;
            break;
        }
    }
}

_ID35446( var_0 )
{
    var_1 = _ID35948( var_0 );
    return !isdefined( var_1 );
}

_ID35948( var_0 )
{
    var_0 endon( "captured" );
    var_0 waittill( "death" );
    waittillframeend;
    return 1;
}

_ID37158()
{
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "warhawk_mortars", 85 );
}

_ID37110()
{
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "warhawk_mortars", 0 );
}

_ID36894()
{
    self._ID37106 = getent( "bridge_device_model", "targetname" );

    if ( !isdefined( self._ID37106 ) )
        return;

    self._ID37706 = 3.0;
    self._ID37172 = 0;
    self._ID37104 = 600;
    self._ID37105 = 200;
    var_0 = ( -1191, -1126, 394 );
    self._ID37106._ID19214 = spawn( "script_model", var_0 );
    self._ID37106._ID19214 setscriptmoverkillcam( "explosive" );
    thread _ID36899();
}

_ID36910( var_0 )
{
    thread _ID36904( var_0 );
    thread _ID36903( var_0._ID37106.origin );
    thread bridge_event_handle_bell_sounds();
    var_1 = _ID37260();

    if ( var_1.size > 0 )
    {
        thread _ID36906( var_1, var_0 );
        thread _ID36902( var_1 );
    }

    thread _ID36897( var_0 );
}

_ID36897( var_0 )
{
    level endon( "bridge_fully_exploded" );
    var_1 = common_scripts\utility::_ID15384( "device_scrambler", "targetname" );

    if ( !isdefined( var_1 ) )
        return;

    thread bridge_device_radioactive_sound( var_1.origin + ( -5, 0, -155 ) );
    level._ID37107 = 1;

    for (;;)
    {
        level waittill( "connected",  var_2  );

        if ( !isbot( var_2 ) )
            var_2 thread _ID26961( ::_ID36900, var_1.origin, var_0._ID37104 );
    }
}

bridge_device_radioactive_sound( var_0 )
{
    var_1 = common_scripts\utility::_ID23798( "emt_geiger_level1", var_0 );
    level waittill( "bridge_fully_exploded" );
    var_1 stoploopsound();
    var_1 delete();
}

_ID26961( var_0, var_1, var_2 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self waittill( "spawned_player" );
    self thread [[ var_0 ]]( var_1, var_2 );
}

_ID36899()
{
    self._ID37106 playloopsound( "device_stage1_loop" );
    wait 2.0;
    var_0 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_0, "active", self._ID37106.origin, "waypoint_radioactive" );
    objective_onentity( var_0, self._ID37106 );
    self.curobjid = var_0;
    thread _ID36893();
    level waittill( "bridge_device_activate",  var_1  );
    _ID37110();
    wait 2.0;
    wait 2.0;
    _ID36898( var_1 );
}

_ID36898( var_0 )
{
    var_1 = common_scripts\utility::_ID15384( "mortar_launch_start", "targetname" );
    var_2 = common_scripts\utility::_ID15384( var_1.target, "targetname" );

    for (;;)
    {
        thread _ID36895( var_1, var_2, var_0 );

        if ( !isdefined( var_2.target ) )
            break;

        var_2 = common_scripts\utility::_ID15384( var_2.target, "targetname" );
    }
}

_ID36893()
{
    level endon( "bridge_device_activate" );
    level waittill( "spawning_intermission" );
    self._ID37706 = 0.5;
    self._ID37172 = 1;
    _ID36898( level.players[0] );
}

random_mortars_incoming_sound( var_0 )
{
    playsoundatpos( var_0, "mortar_incoming" );
}

_ID36895( var_0, var_1, var_2 )
{
    wait(randomfloatrange( 0.0, self._ID37706 ));
    var_3 = randomfloatrange( 4.0, 5.0 );

    if ( self._ID37172 )
        var_3 = 2.5;

    var_4 = ( 0, 0, -800 );
    var_5 = trajectorycalculateinitialvelocity( var_0.origin, var_1.origin, var_4, var_3 );
    var_6 = 1;
    var_7 = 350;
    var_8 = _ID25370( var_0.origin );
    var_8.origin = var_0.origin;
    var_8._ID17490 = 1;
    common_scripts\utility::_ID35582();
    playfxontag( common_scripts\utility::_ID15033( "random_mortars_trail" ), var_8, "tag_fx" );
    var_8.angles = vectortoangles( var_5 ) * ( -1, 1, 1 );
    playsoundatpos( var_0.origin, "mortar_launch" );
    maps\mp\_utility::_ID9519( var_3 - 2.0, ::random_mortars_incoming_sound, var_1.origin );
    var_8 movegravity( var_5, var_3 );
    var_8 waittill( "movedone" );

    if ( level._ID8425 && !isdefined( level.players ) )
        level.players = [];

    if ( !isdefined( var_2 ) )
        var_2 = undefined;

    var_8 radiusdamage( var_1.origin, 350, 750, 500, var_2, "MOD_EXPLOSIVE", "warhawk_mortar_mp" );
    playrumbleonposition( "artillery_rumble", var_1.origin );
    var_9 = var_7 * var_7;

    foreach ( var_11 in level._ID23303 )
    {
        if ( var_11 maps\mp\_utility::_ID18837() )
            continue;

        if ( distancesquared( var_1.origin, var_11.origin ) > var_9 )
            continue;

        if ( var_11 damageconetrace( var_1.origin ) )
            var_11 thread maps\mp\gametypes\_shellshock::_ID10047( var_1.origin );
    }

    if ( var_6 )
        playfx( common_scripts\utility::_ID15033( "mortar_impact_00" ), var_1.origin );

    stopfxontag( common_scripts\utility::_ID15033( "random_mortars_trail" ), var_8, "tag_fx" );

    if ( isdefined( var_1.script_noteworthy ) && var_1.script_noteworthy == "device_target" )
        thread _ID36896( var_2, var_8 );

    wait 0.05;
    var_8 delete();
}

_ID36896( var_0, var_1 )
{
    level notify( "bridge_trigger_explode" );
    objective_delete( self.curobjid );
    earthquake( 0.85, 0.5, self._ID37106.origin, 2500 );
    var_2 = self._ID37104;
    var_3 = var_2 + self._ID37105;
    var_4 = var_2 + 3.0 * self._ID37105;

    foreach ( var_6 in level._ID23303 )
    {
        if ( isplayer( var_6 ) && var_6.sessionstate != "playing" )
            continue;

        var_6 thread _ID38197( self._ID37106.origin, var_2, var_4, self._ID37172 );
        var_7 = distancesquared( self._ID37106.origin, var_6.origin );

        if ( var_7 > var_3 * var_3 )
            continue;

        var_8 = var_0;

        if ( !isdefined( var_8 ) )
            var_8 = undefined;
        else if ( isdefined( var_8.team ) && isdefined( var_6.team ) && var_8.team == var_6.team )
            var_8 = var_1;

        if ( var_7 > var_2 * var_2 )
        {
            var_6 dodamage( var_6.maxhealth * 0.9, self._ID37106.origin, var_8, self._ID37106, "MOD_EXPLOSIVE" );
            continue;
        }

        var_6 dodamage( 1000, self._ID37106.origin, var_8, self._ID37106, "MOD_EXPLOSIVE" );
    }

    var_10 = var_3 * var_3;
    var_11 = maps\mp\agents\_agent_utility::getactiveagentsoftype( "dog" );

    foreach ( var_13 in var_11 )
    {
        var_14 = distancesquared( self._ID37106.origin, var_13.origin );

        if ( var_14 <= var_10 )
            var_13 maps\mp\agents\_agent_utility::_ID19221();
    }

    destroytargetarray( self._ID37106.origin, var_10, level._ID25810 );

    foreach ( var_17 in level._ID9646 )
        destroytargetarray( self._ID37106.origin, var_10, var_17 );

    destroytargetarray( self._ID37106.origin, var_10, level._ID34099 );
    destroytargetarray( self._ID37106.origin, var_10, level._ID34657 );
    destroytargetarray( self._ID37106.origin, var_10, level.placedims );
    destroytargetarray( self._ID37106.origin, var_10, level._ID21075 );
    self._ID37106 stoploopsound( "device_stage1_loop" );
    self._ID37106 notsolid();
    self._ID37106 hide();
    self._ID37106 maps\mp\_movers::notify_moving_platform_invalid();

    if ( !self._ID37172 )
        visionsetnaked( "mp_ca_red_river_exploding", 0.5 );

    physicsexplosionsphere( self._ID37106.origin, var_3, var_2, 1.0 );
    wait 0.5;
    level notify( "bridge_fully_exploded" );
    maps\mp\_compass::_ID29184( "compass_map_mp_ca_red_river_exploded" );
    setexpfog( 6.6, 5530, 0.78, 0.81, 0.75, 0.87, 0.77 );

    if ( !self._ID37172 )
    {
        if ( isdefined( level.nukedetonated ) )
        {
            visionsetnaked( "", 3.0 );
            maps\mp\killstreaks\_nuke::_ID37971( 0 );
        }
        else
            visionsetnaked( "mp_ca_red_river_exploded", 3.0 );
    }
}

destroytargetarray( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_2 )
    {
        var_5 = distancesquared( var_0, var_4.origin );

        if ( var_5 < var_1 )
            var_4 notify( "death" );
    }
}

_ID38197( var_0, var_1, var_2, var_3 )
{
    self playrumbleonentity( "artillery_rumble" );
    wait 0.3;

    if ( !var_3 && !maps\mp\_utility::_ID18837() )
    {
        var_4 = 0.0;
        var_5 = distancesquared( self.origin, var_0 );

        if ( var_5 < var_2 * var_2 )
        {
            var_4 = 8.0;

            if ( var_5 > var_1 * var_1 )
                var_4 *= ( 1 - ( sqrt( var_5 ) - var_1 ) / ( var_2 - var_1 ) );
        }

        if ( var_4 > 0.0 )
            self shellshock( "mp_ca_red_river_event", var_4 );
    }

    wait 1.0;
    self playrumbleonentity( "artillery_rumble" );
    wait 1.3;
    self playrumbleonentity( "artillery_rumble" );
}

_ID36900( var_0, var_1 )
{
    self endon( "disconnect" );
    wait(randomfloat( 0.5 ));
    maps\mp\killstreaks\_unk1534::_ID31521();
    childthread _ID36901( var_0, var_1 );
    level waittill( "bridge_fully_exploded" );
    maps\mp\killstreaks\_unk1534::_ID31522( 0 );
}

_ID36901( var_0, var_1 )
{
    level endon( "bridge_trigger_explode" );
    var_2 = var_1 * var_1;

    for (;;)
    {
        var_3 = length2dsquared( self.origin - var_0 ) < var_2;
        maps\mp\killstreaks\_unk1534::_ID31522( var_3 );
        wait 0.5;
    }
}

_ID25370( var_0 )
{
    var_1 = spawn( "script_model", var_0 );
    var_1 setmodel( "projectile_rpg7" );
    return var_1;
}

_ID37260()
{
    var_0 = getscriptablearray( "vehicle_pickup_destructible_mp_rr", "targetname" );

    if ( var_0.size <= 0 )
    {

    }

    return var_0;
}

_ID36906( var_0, var_1 )
{
    var_2 = var_1._ID37104 + var_1._ID37105 * 2.0;
    var_2 *= var_2;
    var_3 = var_1._ID37106.origin;

    foreach ( var_5 in var_0 )
    {
        if ( distancesquared( var_5.origin, var_3 ) <= var_2 )
            var_5 thread _ID36905();
    }
}

_ID36905()
{
    self endon( "death" );
    level waittill( "bridge_fully_exploded" );
    self setscriptablepartstate( 0, 3 );
}

_ID36902( var_0 )
{
    common_scripts\utility::_ID3867( var_0, ::_ID36908 );
}

_ID36908()
{
    self endon( "death" );
    level waittill( "bridge_fully_exploded" );
    wait(randomfloatrange( 0.75, 1.25 ));
    thread _ID36907();
}

_ID36907()
{
    var_0 = common_scripts\utility::_ID23798( "rr_car_alarm", self gettagorigin( "tag_engine" ) );
    var_1 = randomfloatrange( 12.0, 16.0 );
    common_scripts\utility::_ID35637( var_1, "death" );
    var_0 stoploopsound( "rr_car_alarm" );
    var_0 playsound( "rr_car_alarm_off" );
    wait 5;
    var_0 delete();
}

_ID36904( var_0 )
{
    var_1 = getglassarray( "bridge_event_glass" );

    if ( var_1.size <= 0 )
        return;

    var_2 = var_0._ID37106.origin;
    level waittill( "bridge_fully_exploded" );

    foreach ( var_4 in var_1 )
        destroyglass( var_4, getglassorigin( var_4 ) - var_2 );
}

_ID36903( var_0 )
{
    var_1 = getentarray( "church_bell", "targetname" );

    if ( var_1.size <= 0 )
        return;

    level._ID38044 = 0;
    common_scripts\utility::_ID3867( var_1, ::_ID37858 );
    common_scripts\utility::_ID3867( var_1, ::_ID36909, var_0 );
}

_ID37858()
{
    self setcandamage( 1 );
    self._ID37541 = 0;
    var_0 = _ID36782( self.script_noteworthy );

    for (;;)
    {
        self waittill( "damage",  var_1, var_2, var_3, var_4, var_5  );

        if ( !isdefined( var_2 ) || !isplayer( var_2 ) )
            continue;

        var_6 = var_2 getcurrentweapon();

        if ( !isdefined( var_6 ) || weaponclass( var_6 ) != "sniper" )
            continue;

        self playsound( var_0 );
        thread _ID37859( var_2 );
        wait 0.5;
    }
}

_ID37859( var_0 )
{
    level endon( "bridge_fully_exploded" );

    if ( self._ID37541 )
        return;

    var_1 = anglestoright( self.angles );
    var_2 = vectornormalize( var_0.origin - self.origin );
    var_3 = vectordot( var_1, var_2 ) * 2.0;

    if ( var_3 > 0.0 )
        var_3 = max( 0.3, var_3 );
    else
        var_3 = min( -0.3, var_3 );

    self._ID37541 = 1;
    self rotateroll( 15 * var_3, 1.0, 0, 0.5 );
    wait 1;
    self rotateroll( -25 * var_3, 2.0, 0.5, 0.5 );
    wait 2;
    self rotateroll( 15 * var_3, 1.5, 0.5, 0.5 );
    wait 1.5;
    self rotateroll( -5 * var_3, 1.0, 0.5, 0.5 );
    wait 1.0;
    self._ID37541 = 0;
}

bridge_event_handle_bell_sounds()
{
    level waittill( "bridge_device_activate" );
    playsoundatpos( ( -510, -1617, 556 ), "scn_church_bells_long_large" );
    playsoundatpos( ( -480, -1986, 423 ), "scn_church_bells_long_small" );
}

_ID36909( var_0 )
{
    var_1 = _ID36782( self.script_noteworthy );
    level waittill( "bridge_device_activate" );
    var_2 = anglestoright( self.angles );
    var_3 = vectornormalize( var_0 - self.origin );
    var_4 = vectordot( var_2, var_3 ) * 2.0;

    if ( var_4 > 0.0 )
        var_4 = max( 0.7, var_4 );
    else
        var_4 = min( -0.7, var_4 );

    var_5 = randomfloatrange( 0.1, 0.8 );
    self._ID37541 = 1;
    self.angles = ( self.angles[0], self.angles[1], 0 );
    self rotateroll( 40 * var_4, var_5, 0, var_5 );
    wait(var_5);
    self rotateroll( -70 * var_4, 2.0, 0.5, 0.5 );
    wait 1.75;
    wait 0.25;
    self rotateroll( 60 * var_4, 2.0, 0.5, 0.5 );
    wait 1.75;
    wait 0.25;
    self rotateroll( -50 * var_4, 2.0, 0.5, 0.5 );
    wait 1.75;
    wait 0.25;
    self rotateroll( 40 * var_4, 2.0, 0.5, 0.5 );
    wait 1.75;
    wait 0.25;
    self rotateroll( -30 * var_4, 2.0, 0.5, 0.5 );
    wait 1.75;
    wait 0.25;
    self rotateroll( 20 * var_4, 1.5, 0.5, 0.5 );
    wait 1.5;
    self rotateroll( -15 * var_4, 1.3, 0.5, 0.5 );
    wait 1.3;
    self rotateroll( 5 * var_4, 1.0, 0.5, 0.5 );
    wait 1.0;
    self._ID37541 = 0;
}

_ID36782( var_0 )
{
    var_1 = "rr_church_bell";

    if ( isdefined( var_0 ) && var_0 == "small" )
    {
        if ( !isdefined( level._ID38044 ) )
            level._ID38044 = 0;

        level._ID38044++;

        if ( level._ID38044 == 1 )
            var_1 = "rr_church_bell_smallest";
        else if ( level._ID38044 == 2 )
            var_1 = "rr_church_bell_smaller";
        else
            var_1 = "rr_church_bell_small";
    }

    return var_1;
}
