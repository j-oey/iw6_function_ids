// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID23060 = [];

    if ( level.script == "mp_character_room" )
        return;

    level._ID23060["escort_airdrop"] = spawnstruct();
    level._ID23060["escort_airdrop"]._ID34941 = "osprey_mp";
    level._ID23060["escort_airdrop"].modelbase = "vehicle_v22_osprey_body_mp";
    level._ID23060["escort_airdrop"]._ID21269 = "vehicle_v22_osprey_blades_mp";
    level._ID23060["escort_airdrop"]._ID32360 = "tag_le_door_attach";
    level._ID23060["escort_airdrop"]._ID32361 = "tag_ri_door_attach";
    level._ID23060["escort_airdrop"]._ID32356 = "tag_turret_attach";
    level._ID23060["escort_airdrop"]._ID25072 = &"KILLSTREAKS_DEFEND_AIRDROP_PACKAGES";
    level._ID23060["escort_airdrop"].name = &"KILLSTREAKS_ESCORT_AIRDROP";
    level._ID23060["escort_airdrop"].weaponinfo = "osprey_minigun_mp";
    level._ID23060["escort_airdrop"]._ID16760 = "osprey";
    level._ID23060["escort_airdrop"].droptype = "airdrop_escort";
    level._ID23060["escort_airdrop"].maxhealth = level.heli_maxhealth * 2;
    level._ID23060["escort_airdrop"].timeout = 60.0;
    level._ID23060["osprey_gunner"] = spawnstruct();
    level._ID23060["osprey_gunner"]._ID34941 = "osprey_player_mp";
    level._ID23060["osprey_gunner"].modelbase = "vehicle_v22_osprey_body_mp";
    level._ID23060["osprey_gunner"]._ID21269 = "vehicle_v22_osprey_blades_mp";
    level._ID23060["osprey_gunner"]._ID32360 = "tag_le_door_attach";
    level._ID23060["osprey_gunner"]._ID32361 = "tag_ri_door_attach";
    level._ID23060["osprey_gunner"]._ID32356 = "tag_turret_attach";
    level._ID23060["osprey_gunner"]._ID25072 = &"KILLSTREAKS_DEFEND_AIRDROP_PACKAGES";
    level._ID23060["osprey_gunner"].name = &"KILLSTREAKS_OSPREY_GUNNER";
    level._ID23060["osprey_gunner"].weaponinfo = "osprey_player_minigun_mp";
    level._ID23060["osprey_gunner"]._ID16760 = "osprey_gunner";
    level._ID23060["osprey_gunner"].droptype = "airdrop_osprey_gunner";
    level._ID23060["osprey_gunner"].maxhealth = level.heli_maxhealth * 2;
    level._ID23060["osprey_gunner"].timeout = 75.0;

    foreach ( var_1 in level._ID23060 )
    {
        level._ID7233["explode"]["death"][var_1.modelbase] = loadfx( "fx/explosions/helicopter_explosion_osprey" );
        level._ID7233["explode"]["air_death"][var_1.modelbase] = loadfx( "fx/explosions/helicopter_explosion_osprey_air_mp" );
        level._ID7233["anim"]["blades_anim_up"][var_1.modelbase] = loadfx( "fx/props/osprey_blades_anim_up" );
        level._ID7233["anim"]["blades_anim_down"][var_1.modelbase] = loadfx( "fx/props/osprey_blades_anim_down" );
        level._ID7233["anim"]["blades_static_up"][var_1.modelbase] = loadfx( "fx/props/osprey_blades_up" );
        level._ID7233["anim"]["blades_static_down"][var_1.modelbase] = loadfx( "fx/props/osprey_blades_default" );
        level._ID7233["anim"]["hatch_left_static_up"][var_1.modelbase] = loadfx( "fx/props/osprey_bottom_door_left_default" );
        level._ID7233["anim"]["hatch_left_anim_down"][var_1.modelbase] = loadfx( "fx/props/osprey_bottom_door_left_anim_open" );
        level._ID7233["anim"]["hatch_left_static_down"][var_1.modelbase] = loadfx( "fx/props/osprey_bottom_door_left_up" );
        level._ID7233["anim"]["hatch_left_anim_up"][var_1.modelbase] = loadfx( "fx/props/osprey_bottom_door_left_anim_close" );
        level._ID7233["anim"]["hatch_right_static_up"][var_1.modelbase] = loadfx( "fx/props/osprey_bottom_door_right_default" );
        level._ID7233["anim"]["hatch_right_anim_down"][var_1.modelbase] = loadfx( "fx/props/osprey_bottom_door_right_anim_open" );
        level._ID7233["anim"]["hatch_right_static_down"][var_1.modelbase] = loadfx( "fx/props/osprey_bottom_door_right_up" );
        level._ID7233["anim"]["hatch_right_anim_up"][var_1.modelbase] = loadfx( "fx/props/osprey_bottom_door_right_anim_close" );
    }

    level._ID2688 = [];
    level._ID19256["escort_airdrop"] = ::_ID33847;
    level._ID19256["osprey_gunner"] = ::_ID33860;
}

_ID33847( var_0, var_1 )
{
    var_2 = 1;

    if ( isdefined( level.chopper ) )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    if ( maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 + var_2 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        return 0;
    }

    if ( maps\mp\_utility::_ID18678() )
        return 0;

    maps\mp\_utility::_ID17543();
    var_4 = maps\mp\killstreaks\_airdrop::beginairdropviamarker( var_0, "escort_airdrop" );

    if ( !isdefined( var_4 ) || !var_4 )
    {
        self notify( "markerDetermined" );
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    return 1;
}

_ID33860( var_0, var_1 )
{
    var_2 = 1;

    if ( isdefined( level.chopper ) )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    if ( maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 + var_2 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        return 0;
    }

    maps\mp\_utility::_ID17543();
    var_4 = _ID28017( var_0, "osprey_gunner", "compass_objpoint_osprey_friendly", "compass_objpoint_osprey_enemy", &"KILLSTREAKS_SELECT_MOBILE_MORTAR_LOCATION" );

    if ( !isdefined( var_4 ) || !var_4 )
    {
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    maps\mp\_matchdata::_ID20253( "osprey_gunner", self.origin );
    return 1;
}

finishsupportescortusage( var_0, var_1, var_2, var_3 )
{
    self notify( "used" );
    var_4 = ( 0, var_2, 0 );
    var_5 = 12000;
    var_6 = getent( "airstrikeheight", "targetname" );
    var_7 = var_6.origin[2];
    var_8 = level._ID16675[randomint( level._ID16675.size )];
    var_9 = var_8.origin;
    var_10 = ( var_1[0], var_1[1], var_7 );
    var_11 = var_1 + anglestoforward( var_4 ) * var_5;
    var_12 = vectortoangles( var_10 - var_9 );
    var_13 = var_1;
    var_1 = ( var_1[0], var_1[1], var_7 );
    var_14 = _ID8390( self, var_0, var_9, var_12, var_1, var_3 );
    var_9 = var_8;
    _ID34775( var_0, var_14, var_9, var_10, var_11, var_7, var_13 );
}

_ID12958( var_0, var_1, var_2, var_3 )
{
    self notify( "used" );
    var_4 = ( 0, var_2, 0 );
    var_5 = 12000;
    var_6 = getent( "airstrikeheight", "targetname" );
    var_7 = var_6.origin[2];
    var_8 = level._ID16675[randomint( level._ID16675.size )];
    var_9 = var_8.origin;
    var_10 = ( var_1[0], var_1[1], var_7 );
    var_11 = var_1 + anglestoforward( var_4 ) * var_5;
    var_12 = vectortoangles( var_10 - var_9 );
    var_1 = ( var_1[0], var_1[1], var_7 );
    var_13 = _ID8390( self, var_0, var_9, var_12, var_1, var_3 );
    var_9 = var_8;
    _ID34762( var_0, var_13, var_9, var_10, var_11, var_7 );
}

_ID31855()
{
    self waittill( "stop_location_selection",  var_0  );

    switch ( var_0 )
    {
        case "disconnect":
        case "cancel_location":
        case "death":
        case "weapon_change":
        case "emp":
            self notify( "customCancelLocation" );
            break;
    }
}

_ID28017( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "customCancelLocation" );
    var_5 = undefined;
    var_6 = level._ID20638 / 6.46875;

    if ( level.splitscreen )
        var_6 *= 1.5;

    maps\mp\_utility::_beginlocationselection( var_1, "map_artillery_selector", 0, 500 );
    thread _ID31855();
    self waittill( "confirm_location",  var_7, var_8  );
    maps\mp\_utility::stoplocationselection( 0 );
    maps\mp\_utility::_ID29199( var_1 );
    var_9 = maps\mp\killstreaks\_killstreaks::_ID17993( var_1 );

    if ( var_9 != "success" )
    {
        if ( var_9 != "disconnect" )
            maps\mp\_utility::_ID7513();

        return 0;
    }

    if ( isdefined( level.chopper ) )
    {
        maps\mp\_utility::_ID7513();
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }
    else if ( maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        maps\mp\_utility::_ID7513();
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        return 0;
    }

    thread _ID12958( var_0, var_7, var_8, var_1 );
    return 1;
}

_ID29972( var_0, var_1, var_2, var_3 )
{
    var_4 = maps\mp\gametypes\_hud_util::createfontstring( "bigfixed", 0.5 );
    var_4 maps\mp\gametypes\_hud_util::_ID28836( "CENTER", "CENTER", 0, -150 );
    var_4 settext( var_2 );
    self._ID20163 = [];

    for ( var_5 = 0; var_5 < var_3; var_5++ )
    {
        self._ID20163[var_5] = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add( self._ID20163[var_5], "invisible", ( 0, 0, 0 ) );
        objective_position( self._ID20163[var_5], level._ID2688[level.script][var_5]["origin"] );
        objective_state( self._ID20163[var_5], "active" );
        objective_player( self._ID20163[var_5], self getentitynumber() );

        if ( level._ID2688[level.script][var_5]["in_use"] == 1 )
        {
            objective_icon( self._ID20163[var_5], var_1 );
            continue;
        }

        objective_icon( self._ID20163[var_5], var_0 );
    }

    common_scripts\utility::_ID35626( "cancel_location", "picked_location", "stop_location_selection" );
    var_4 maps\mp\gametypes\_hud_util::destroyelem();

    for ( var_5 = 0; var_5 < var_3; var_5++ )
        maps\mp\_utility::_objective_delete( self._ID20163[var_5] );
}

_ID8390( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = spawnhelicopter( var_0, var_2, var_3, level._ID23060[var_5]._ID34941, level._ID23060[var_5].modelbase );

    if ( !isdefined( var_6 ) )
        return undefined;

    var_6._ID23062 = var_5;
    var_6.heli_type = level._ID23060[var_5].modelbase;
    var_6._ID16760 = level._ID23060[var_5]._ID16760;
    var_6.attractor = missile_createattractorent( var_6, level._ID16516, level.heli_attract_range );
    var_6._ID19938 = var_1;
    var_6.team = var_0.pers["team"];
    var_6.pers["team"] = var_0.pers["team"];
    var_6.owner = var_0;
    var_6 setotherent( var_0 );
    var_6.maxhealth = level._ID23060[var_5].maxhealth;
    var_6.zoffset = ( 0, 0, 0 );
    var_6._ID32609 = level.heli_targeting_delay;
    var_6._ID24976 = undefined;
    var_6.secondarytarget = undefined;
    var_6.attacker = undefined;
    var_6.currentstate = "ok";
    var_6.droptype = level._ID23060[var_5].droptype;
    var_6 common_scripts\utility::_ID20489( var_6.team );
    level.chopper = var_6;
    var_6 maps\mp\killstreaks\_helicopter::addtohelilist();
    var_6 thread maps\mp\killstreaks\_flares::_ID13274( 2 );
    var_6 thread maps\mp\killstreaks\_helicopter::heli_leave_on_disconnect( var_0 );
    var_6 thread maps\mp\killstreaks\_helicopter::heli_leave_on_changeteams( var_0 );
    var_6 thread maps\mp\killstreaks\_helicopter::_ID16614( var_0 );
    var_7 = level._ID23060[var_5].timeout;
    var_6 thread maps\mp\killstreaks\_helicopter::_ID16617( var_7 );
    var_6 thread maps\mp\killstreaks\_helicopter::_ID16549( var_5, 0 );
    var_6 thread maps\mp\killstreaks\_helicopter::_ID16601();
    var_6 thread maps\mp\killstreaks\_helicopter::_ID16563();
    var_6 thread airshipfx();
    var_6 thread airshipfxonconnect();

    if ( var_5 == "escort_airdrop" )
    {
        var_8 = var_6.origin + ( anglestoforward( var_6.angles ) * -200 + anglestoright( var_6.angles ) * -200 ) + ( 0, 0, 200 );
        var_6._ID19214 = spawn( "script_model", var_8 );
        var_6._ID19214 setscriptmoverkillcam( "explosive" );
        var_6._ID19214 linkto( var_6, "tag_origin" );
    }

    return var_6;
}

airshipfx()
{
    self endon( "death" );
    wait 0.05;
    playfxontag( level._ID7233["light"]["tail"], self, "tag_light_tail" );
    wait 0.05;
    playfxontag( level._ID7233["light"]["belly"], self, "tag_light_belly" );
    wait 0.05;
    playfxontag( level._ID7233["anim"]["blades_static_down"][level._ID23060[self._ID23062].modelbase], self, "TAG_BLADES_ATTACH" );
    wait 0.05;
    playfxontag( level._ID7233["anim"]["hatch_left_static_up"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32360 );
    wait 0.05;
    playfxontag( level._ID7233["anim"]["hatch_right_static_up"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32361 );
}

airshipfxonconnect()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected",  var_0  );
        thread airshipfxonclient( var_0 );
    }
}

airshipfxonclient( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    wait 0.05;
    playfxontagforclients( level._ID7233["light"]["tail"], self, "tag_light_tail", var_0 );
    wait 0.05;
    playfxontagforclients( level._ID7233["light"]["belly"], self, "tag_light_belly", var_0 );

    if ( isdefined( self._ID25117 ) )
    {
        if ( self._ID25117 == "up" )
        {
            wait 0.05;
            playfxontagforclients( level._ID7233["anim"]["blades_static_up"][level._ID23060[self._ID23062].modelbase], self, "TAG_BLADES_ATTACH", var_0 );
        }
        else
        {
            wait 0.05;
            playfxontagforclients( level._ID7233["anim"]["blades_static_down"][level._ID23060[self._ID23062].modelbase], self, "TAG_BLADES_ATTACH", var_0 );
        }
    }
    else
    {
        wait 0.05;
        playfxontagforclients( level._ID7233["anim"]["blades_static_down"][level._ID23060[self._ID23062].modelbase], self, "TAG_BLADES_ATTACH", var_0 );
    }

    if ( isdefined( self._ID16429 ) )
    {
        if ( self._ID16429 == "down" )
        {
            wait 0.05;
            playfxontagforclients( level._ID7233["anim"]["hatch_left_static_down"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32360, var_0 );
            wait 0.05;
            playfxontagforclients( level._ID7233["anim"]["hatch_right_static_down"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32361, var_0 );
        }
        else
        {
            wait 0.05;
            playfxontagforclients( level._ID7233["anim"]["hatch_left_static_up"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32360, var_0 );
            wait 0.05;
            playfxontagforclients( level._ID7233["anim"]["hatch_right_static_up"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32361, var_0 );
        }
    }
    else
    {
        wait 0.05;
        playfxontagforclients( level._ID7233["anim"]["hatch_left_static_up"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32360, var_0 );
        wait 0.05;
        playfxontagforclients( level._ID7233["anim"]["hatch_right_static_up"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32361, var_0 );
    }
}

_ID34775( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_1 thread airshipflydefense( self, var_2, var_3, var_4, var_5, var_6 );
}

_ID34762( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    thread _ID26275( var_0, var_1 );
    var_1 thread _ID2710( self, var_2, var_3, var_4, var_5 );
}

_ID26275( var_0, var_1 )
{
    self endon( "disconnect" );
    var_1 endon( "helicopter_done" );
    thread maps\mp\_utility::_ID32672( "used_osprey_gunner", self );
    maps\mp\_utility::_giveweapon( "heli_remote_mp" );
    self switchtoweapon( "heli_remote_mp" );

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::_ID28902( 0 );

    var_1 vehicleturretcontrolon( self );
    self playerlinkweaponviewtodelta( var_1, "tag_player", 1.0, 0, 0, 0, 0, 1 );
    self setplayerangles( var_1 gettagangles( "tag_player" ) );
    var_1 thread maps\mp\killstreaks\_helicopter::_ID16687();
    var_1._ID15889 = self;
    self.heliridelifeid = var_0;
    thread _ID11754( var_1 );
    thread _ID35606( 1.0, var_1 );
    thread maps\mp\_utility::_ID25727( var_1 );

    for (;;)
    {
        var_1 waittill( "turret_fire" );
        var_1 fireweapon();
        earthquake( 0.2, 1, var_1.origin, 1000 );
    }
}

_ID35606( var_0, var_1 )
{
    self endon( "disconnect" );
    var_1 endon( "death" );
    var_1 endon( "helicopter_done" );
    var_1 endon( "crashing" );
    var_1 endon( "leaving" );
    wait(var_0);
    self visionsetthermalforplayer( level.ac130.enhanced_vision, 0 );
    self.lastvisionsetthermal = level.ac130.enhanced_vision;
    self thermalvisionon();
    self thermalvisionfofoverlayon();
}

showdefendprompt( var_0 )
{
    self endon( "disconnect" );
    var_0 endon( "helicopter_done" );
    self._ID12252 = maps\mp\gametypes\_hud_util::createfontstring( "bigfixed", 1.5 );
    self._ID12252 maps\mp\gametypes\_hud_util::_ID28836( "CENTER", "CENTER", 0, -150 );
    self._ID12252 settext( level._ID23060[var_0._ID23062]._ID25072 );
    wait 6;

    if ( isdefined( self._ID12252 ) )
        self._ID12252 maps\mp\gametypes\_hud_util::destroyelem();
}

airshippitchpropsup()
{
    self endon( "crashing" );
    self endon( "death" );
    stopfxontag( level._ID7233["anim"]["blades_static_down"][level._ID23060[self._ID23062].modelbase], self, "TAG_BLADES_ATTACH" );
    playfxontag( level._ID7233["anim"]["blades_anim_up"][level._ID23060[self._ID23062].modelbase], self, "TAG_BLADES_ATTACH" );
    wait 1.0;

    if ( isdefined( self ) )
    {
        playfxontag( level._ID7233["anim"]["blades_static_up"][level._ID23060[self._ID23062].modelbase], self, "TAG_BLADES_ATTACH" );
        self._ID25117 = "up";
    }
}

airshippitchpropsdown()
{
    self endon( "crashing" );
    self endon( "death" );
    stopfxontag( level._ID7233["anim"]["blades_static_up"][level._ID23060[self._ID23062].modelbase], self, "TAG_BLADES_ATTACH" );
    playfxontag( level._ID7233["anim"]["blades_anim_down"][level._ID23060[self._ID23062].modelbase], self, "TAG_BLADES_ATTACH" );
    wait 1.0;

    if ( isdefined( self ) )
    {
        playfxontag( level._ID7233["anim"]["blades_static_down"][level._ID23060[self._ID23062].modelbase], self, "TAG_BLADES_ATTACH" );
        self._ID25117 = "down";
    }
}

airshippitchhatchup()
{
    self endon( "crashing" );
    self endon( "death" );
    stopfxontag( level._ID7233["anim"]["hatch_left_static_down"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32360 );
    playfxontag( level._ID7233["anim"]["hatch_left_anim_up"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32360 );
    stopfxontag( level._ID7233["anim"]["hatch_right_static_down"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32361 );
    playfxontag( level._ID7233["anim"]["hatch_right_anim_up"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32361 );
    wait 1.0;

    if ( isdefined( self ) )
    {
        playfxontag( level._ID7233["anim"]["hatch_left_static_up"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32360 );
        playfxontag( level._ID7233["anim"]["hatch_right_static_up"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32361 );
        self._ID16429 = "up";
    }
}

airshippitchhatchdown()
{
    self endon( "crashing" );
    self endon( "death" );
    stopfxontag( level._ID7233["anim"]["hatch_left_static_up"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32360 );
    playfxontag( level._ID7233["anim"]["hatch_left_anim_down"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32360 );
    stopfxontag( level._ID7233["anim"]["hatch_right_static_up"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32361 );
    playfxontag( level._ID7233["anim"]["hatch_right_anim_down"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32361 );
    wait 1.0;

    if ( isdefined( self ) )
    {
        playfxontag( level._ID7233["anim"]["hatch_left_static_down"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32360 );
        playfxontag( level._ID7233["anim"]["hatch_right_static_down"][level._ID23060[self._ID23062].modelbase], self, level._ID23060[self._ID23062]._ID32361 );
        self._ID16429 = "down";
    }

    self notify( "hatch_down" );
}

_ID14906( var_0 )
{
    self endon( "helicopter_removed" );
    self endon( "heightReturned" );
    var_1 = getent( "airstrikeheight", "targetname" );

    if ( isdefined( var_1 ) )
        var_2 = var_1.origin[2];
    else if ( isdefined( level.airstrikeheightscale ) )
        var_2 = 850 * level.airstrikeheightscale;
    else
        var_2 = 850;

    self._ID5123 = var_2;
    var_3 = 200;
    var_4 = 0;
    var_5 = 0;

    for ( var_6 = 0; var_6 < 125; var_6++ )
    {
        wait 0.05;
        var_7 = var_6 % 8;
        var_8 = var_6 * 3;

        switch ( var_7 )
        {
            case 0:
                var_4 = var_8;
                var_5 = var_8;
                break;
            case 1:
                var_4 = var_8 * -1;
                var_5 = var_8 * -1;
                break;
            case 2:
                var_4 = var_8 * -1;
                var_5 = var_8;
                break;
            case 3:
                var_4 = var_8;
                var_5 = var_8 * -1;
                break;
            case 4:
                var_4 = 0;
                var_5 = var_8 * -1;
                break;
            case 5:
                var_4 = var_8 * -1;
                var_5 = 0;
                break;
            case 6:
                var_4 = var_8;
                var_5 = 0;
                break;
            case 7:
                var_4 = 0;
                var_5 = var_8;
                break;
            default:
                break;
        }

        var_9 = bullettrace( var_0 + ( var_4, var_5, 1000 ), var_0 + ( var_4, var_5, -10000 ), 1, self );

        if ( var_9["position"][2] > var_3 )
            var_3 = var_9["position"][2];
    }

    self._ID5123 = var_3 + 300;

    switch ( getdvar( "mapname" ) )
    {
        case "mp_morningwood":
            self._ID5123 = self._ID5123 + 600;
            break;
        case "mp_overwatch":
            var_10 = level.spawnpoints;
            var_11 = var_10[0];
            var_12 = var_10[0];

            foreach ( var_14 in var_10 )
            {
                if ( var_14.origin[2] < var_11.origin[2] )
                    var_11 = var_14;

                if ( var_14.origin[2] > var_12.origin[2] )
                    var_12 = var_14;
            }

            if ( var_3 < var_11.origin[2] - 100 )
                self._ID5123 = var_12.origin[2] + 900;

            break;
    }
}

airshipflydefense( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self notify( "airshipFlyDefense" );
    self endon( "airshipFlyDefense" );
    self endon( "helicopter_removed" );
    self endon( "death" );
    self endon( "leaving" );
    thread _ID14906( var_2 );
    maps\mp\killstreaks\_helicopter::_ID16582( var_1 );
    self.pathgoal = var_2;
    var_6 = self.angles;
    self setyawspeed( 30, 30, 30, 0.3 );
    var_7 = self.origin;
    var_8 = self.angles[1];
    var_9 = self.angles[0];
    self.timeout = level._ID23060[self._ID23062].timeout;
    self setvehgoalpos( var_2, 1 );
    var_10 = gettime();
    self waittill( "goal" );
    var_11 = ( gettime() - var_10 ) * 0.001;
    self.timeout = self.timeout - var_11;
    thread airshippitchpropsup();
    var_12 = var_2 * ( 1, 1, 0 );
    var_12 += ( 0, 0, self._ID5123 );
    self vehicle_setspeed( 25, 10, 10 );
    self setyawspeed( 20, 10, 10, 0.3 );
    self setvehgoalpos( var_12, 1 );
    var_10 = gettime();
    self waittill( "goal" );
    var_11 = ( gettime() - var_10 ) * 0.001;
    self.timeout = self.timeout - var_11;
    self sethoverparams( 65, 50, 50 );
    _ID23059( 1, level._ID23060[self._ID23062]._ID32356, var_12 );
    thread _ID19232( var_5 );

    if ( isdefined( var_0 ) )
        var_0 common_scripts\utility::_ID35637( self.timeout, "disconnect" );

    self waittill( "leaving" );
    self notify( "osprey_leaving" );
    thread airshippitchpropsdown();
}

_ID35429( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    wait(var_0);
    self delete();
}

_ID19232( var_0 )
{
    self endon( "osprey_leaving" );
    self endon( "helicopter_removed" );
    self endon( "death" );
    var_1 = var_0;

    for (;;)
    {
        foreach ( var_3 in level.players )
        {
            wait 0.05;

            if ( !isdefined( self ) )
                return;

            if ( !isdefined( var_3 ) )
                continue;

            if ( !maps\mp\_utility::_ID18757( var_3 ) )
                continue;

            if ( !self.owner maps\mp\_utility::isenemy( var_3 ) )
                continue;

            if ( var_3 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
                continue;

            if ( distancesquared( var_1, var_3.origin ) > 500000 )
                continue;

            thread aishootplayer( var_3, var_1 );
            _ID35550();
        }
    }
}

aishootplayer( var_0, var_1 )
{
    self notify( "aiShootPlayer" );
    self endon( "aiShootPlayer" );
    self endon( "helicopter_removed" );
    self endon( "leaving" );
    var_0 endon( "death" );
    self setturrettargetent( var_0 );
    self setlookatent( var_0 );
    thread _ID32601( var_0 );
    var_2 = 6;
    var_3 = 2;

    for (;;)
    {
        var_2--;
        self fireweapon( "tag_flash", var_0 );
        wait 0.15;

        if ( var_2 <= 0 )
        {
            var_3--;
            var_2 = 6;

            if ( distancesquared( var_0.origin, var_1 ) > 500000 || var_3 <= 0 || !maps\mp\_utility::_ID18757( var_0 ) )
            {
                self notify( "abandon_target" );
                return;
            }

            wait 1;
        }
    }
}

_ID32601( var_0 )
{
    self endon( "abandon_target" );
    self endon( "leaving" );
    self endon( "helicopter_removed" );
    var_0 waittill( "death" );
    self notify( "target_killed" );
}

_ID35550()
{
    self endon( "helicopter_removed" );
    self endon( "leaving" );
    self endon( "target_killed" );
    self endon( "abandon_target" );

    for (;;)
        wait 0.05;
}

_ID2710( var_0, var_1, var_2, var_3, var_4 )
{
    self notify( "airshipFlyGunner" );
    self endon( "airshipFlyGunner" );
    self endon( "helicopter_removed" );
    self endon( "death" );
    self endon( "leaving" );
    thread _ID14906( var_2 );
    maps\mp\killstreaks\_helicopter::_ID16582( var_1 );
    thread maps\mp\killstreaks\_helicopter::_ID16617( level._ID23060[self._ID23062].timeout );
    var_5 = self.angles;
    self setyawspeed( 30, 30, 30, 0.3 );
    var_6 = self.origin;
    var_7 = self.angles[1];
    var_8 = self.angles[0];
    self.timeout = level._ID23060[self._ID23062].timeout;
    self setvehgoalpos( var_2, 1 );
    var_9 = gettime();
    self waittill( "goal" );
    var_10 = ( gettime() - var_9 ) * 0.001;
    self.timeout = self.timeout - var_10;
    thread airshippitchpropsup();
    var_11 = var_2 * ( 1, 1, 0 );
    var_11 += ( 0, 0, self._ID5123 );
    self vehicle_setspeed( 25, 10, 10 );
    self setyawspeed( 20, 10, 10, 0.3 );
    self setvehgoalpos( var_11, 1 );
    var_9 = gettime();
    self waittill( "goal" );
    var_10 = ( gettime() - var_9 ) * 0.001;
    self.timeout = self.timeout - var_10;
    _ID23058( 1, level._ID23060[self._ID23062]._ID32356, var_11 );
    var_12 = 1.0;

    if ( isdefined( var_0 ) )
        var_0 common_scripts\utility::_ID35637( var_12, "disconnect" );

    self.timeout = self.timeout - var_12;
    self setvehgoalpos( var_2, 1 );
    var_9 = gettime();
    self waittill( "goal" );
    var_10 = ( gettime() - var_9 ) * 0.001;
    self.timeout = self.timeout - var_10;
    var_13 = getentarray( "heli_attack_area", "targetname" );
    var_14 = level.heli_loop_nodes[randomint( level.heli_loop_nodes.size )];

    if ( var_13.size )
        thread maps\mp\killstreaks\_helicopter::_ID16584( var_13 );
    else
        thread maps\mp\killstreaks\_helicopter::_ID16581( var_14 );

    self waittill( "leaving" );
    thread airshippitchpropsdown();
}

_ID23059( var_0, var_1, var_2 )
{
    thread airshippitchhatchdown();
    self waittill( "hatch_down" );
    level notify( "escort_airdrop_started",  self  );
    var_3[0] = thread maps\mp\killstreaks\_airdrop::_ID11103( undefined, self.droptype, undefined, 0, undefined, self.origin, ( randomint( 10 ), randomint( 10 ), randomint( 10 ) ), undefined, var_1 );
    wait 0.05;
    self notify( "drop_crate" );
    wait(var_0);
    var_3[1] = thread maps\mp\killstreaks\_airdrop::_ID11103( undefined, self.droptype, undefined, 0, undefined, self.origin, ( randomint( 100 ), randomint( 100 ), randomint( 100 ) ), var_3, var_1 );
    wait 0.05;
    self notify( "drop_crate" );
    wait(var_0);
    var_3[2] = thread maps\mp\killstreaks\_airdrop::_ID11103( undefined, self.droptype, undefined, 0, undefined, self.origin, ( randomint( 50 ), randomint( 50 ), randomint( 50 ) ), var_3, var_1 );
    wait 0.05;
    self notify( "drop_crate" );
    wait(var_0);
    var_3[3] = thread maps\mp\killstreaks\_airdrop::_ID11103( undefined, self.droptype, undefined, 0, undefined, self.origin, ( randomintrange( -100, 0 ), randomintrange( -100, 0 ), randomintrange( -100, 0 ) ), var_3, var_1 );
    wait 0.05;
    self notify( "drop_crate" );
    wait(var_0);
    thread maps\mp\killstreaks\_airdrop::_ID11103( undefined, self.droptype, undefined, 0, undefined, self.origin, ( randomintrange( -50, 0 ), randomintrange( -50, 0 ), randomintrange( -50, 0 ) ), var_3, var_1 );
    wait 0.05;
    self notify( "drop_crate" );
    wait 1.0;
    thread airshippitchhatchup();
}

_ID23058( var_0, var_1, var_2 )
{
    thread airshippitchhatchdown();
    self waittill( "hatch_down" );
    var_3[0] = thread maps\mp\killstreaks\_airdrop::_ID11103( undefined, self.droptype, undefined, 0, undefined, self.origin, ( randomint( 10 ), randomint( 10 ), randomint( 10 ) ), undefined, var_1 );
    wait 0.05;
    self.timeout = self.timeout - 0.05;
    self notify( "drop_crate" );
    wait(var_0);
    self.timeout = self.timeout - var_0;
    var_3[1] = thread maps\mp\killstreaks\_airdrop::_ID11103( undefined, self.droptype, undefined, 0, undefined, self.origin, ( randomint( 100 ), randomint( 100 ), randomint( 100 ) ), var_3, var_1 );
    wait 0.05;
    self.timeout = self.timeout - 0.05;
    self notify( "drop_crate" );
    wait(var_0);
    self.timeout = self.timeout - var_0;
    var_3[2] = thread maps\mp\killstreaks\_airdrop::_ID11103( undefined, self.droptype, undefined, 0, undefined, self.origin, ( randomint( 50 ), randomint( 50 ), randomint( 50 ) ), var_3, var_1 );
    wait 0.05;
    self.timeout = self.timeout - 0.05;
    self notify( "drop_crate" );
    wait 1.0;
    thread airshippitchhatchup();
}

_ID11753( var_0 )
{
    if ( isdefined( self._ID12252 ) )
        self._ID12252 maps\mp\gametypes\_hud_util::destroyelem();

    self remotecamerasoundscapeoff();
    self thermalvisionoff();
    self thermalvisionfofoverlayoff();
    self unlink();
    maps\mp\_utility::_ID7513();

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::_ID28902( 1 );

    self visionsetthermalforplayer( game["thermal_vision"], 0 );

    if ( isdefined( var_0 ) )
        var_0 vehicleturretcontroloff( self );

    self notify( "heliPlayer_removed" );
    self switchtoweapon( common_scripts\utility::_ID15114() );
    self takeweapon( "heli_remote_mp" );
}

_ID11754( var_0 )
{
    self endon( "disconnect" );
    var_0 waittill( "helicopter_done" );
    _ID11753( var_0 );
}
