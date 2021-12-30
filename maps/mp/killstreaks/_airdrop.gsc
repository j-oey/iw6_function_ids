// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID1644["airdrop_crate_destroy"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_airdrop_crate_dust_kickup" );
    level._ID1644["airdrop_dust_kickup"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_airdrop_crate_dust_kickup" );
    precachempanim( "juggernaut_carepackage" );
    setairdropcratecollision( "airdrop_crate" );
    setairdropcratecollision( "care_package" );
    level._ID19256["airdrop_assault"] = ::_ID33831;
    level._ID19256["airdrop_support"] = ::_ID33831;
    level._ID19256["airdrop_juggernaut"] = ::_ID33831;
    level._ID19256["airdrop_juggernaut_recon"] = ::_ID33831;
    level._ID19256["airdrop_juggernaut_maniac"] = ::_ID33831;
    level.numdropcrates = 0;
    level._ID20086 = [];
    level.cratetypes = [];
    level._ID8252 = [];
    addcratetype( "airdrop_assault", "uplink", 25, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_UPLINK_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_assault", "ims", 25, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_IMS_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_assault", "guard_dog", 20, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_GUARD_DOG_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_assault", "drone_hive", 20, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_DRONE_HIVE_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_assault", "sentry", 10, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_SENTRY_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_assault", "helicopter", 10, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_HELICOPTER_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_assault", "ball_drone_backup", 4, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_assault", "vanguard", 4, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_VANGUARD_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_assault", "airdrop_juggernaut_maniac", 3, ::_ID18982, "mp_juggernaut_carepackage", "mp_juggernaut_carepackage_red", &"KILLSTREAKS_HINTS_JUGGERNAUT_MANIAC_PICKUP", "mp_juggernaut_carepackage_dummy" );
    addcratetype( "airdrop_assault", "airdrop_juggernaut", 2, ::_ID18982, "mp_juggernaut_carepackage", "mp_juggernaut_carepackage_red", &"KILLSTREAKS_HINTS_JUGGERNAUT_PICKUP", "mp_juggernaut_carepackage_dummy" );
    addcratetype( "airdrop_assault", "heli_pilot", 1, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_HELI_PILOT_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_assault", "odin_assault", 1, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_ODIN_ASSAULT_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_support", "uplink_support", 25, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_UPLINK_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_support", "deployable_vest", 25, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_DEPLOYABLE_VEST_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_support", "deployable_ammo", 20, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_support", "ball_drone_radar", 20, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_BALL_DRONE_RADAR_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_support", "aa_launcher", 10, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_AA_LAUNCHER_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_support", "jammer", 10, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_JAMMER_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_support", "air_superiority", 4, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_AIR_SUPERIORITY_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_support", "recon_agent", 4, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_RECON_AGENT_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_support", "heli_sniper", 4, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_HELI_SNIPER_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_support", "uav_3dping", 3, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_UAV_3DPING_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_support", "airdrop_juggernaut_recon", 1, ::_ID18982, "mp_juggernaut_carepackage", "mp_juggernaut_carepackage_red", &"KILLSTREAKS_HINTS_JUGGERNAUT_RECON_PICKUP", "mp_juggernaut_carepackage_dummy" );
    addcratetype( "airdrop_support", "odin_support", 1, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_ODIN_SUPPORT_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_juggernaut", "airdrop_juggernaut", 100, ::_ID18982, "mp_juggernaut_carepackage", "mp_juggernaut_carepackage_red", &"KILLSTREAKS_HINTS_JUGGERNAUT_PICKUP", "mp_juggernaut_carepackage_dummy" );
    addcratetype( "airdrop_juggernaut_recon", "airdrop_juggernaut_recon", 100, ::_ID18982, "mp_juggernaut_carepackage", "mp_juggernaut_carepackage_red", &"KILLSTREAKS_HINTS_JUGGERNAUT_RECON_PICKUP", "mp_juggernaut_carepackage_dummy" );
    addcratetype( "airdrop_juggernaut_maniac", "airdrop_juggernaut_maniac", 100, ::_ID18982, "mp_juggernaut_carepackage", "mp_juggernaut_carepackage_red", &"KILLSTREAKS_HINTS_JUGGERNAUT_MANIAC_PICKUP", "mp_juggernaut_carepackage_dummy" );
    addcratetype( "airdrop_grnd", "uplink", 25, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_UPLINK_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "ims", 25, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_IMS_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "guard_dog", 20, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_GUARD_DOG_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "drone_hive", 20, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_DRONE_HIVE_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "sentry", 10, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_SENTRY_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "helicopter", 10, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_HELICOPTER_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "ball_drone_backup", 4, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "vanguard", 4, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_VANGUARD_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "airdrop_juggernaut_maniac", 3, ::_ID18982, "mp_juggernaut_carepackage", "mp_juggernaut_carepackage_red", &"KILLSTREAKS_HINTS_JUGGERNAUT_MANIAC_PICKUP", "mp_juggernaut_carepackage_dummy" );
    addcratetype( "airdrop_grnd", "airdrop_juggernaut", 2, ::_ID18982, "mp_juggernaut_carepackage", "mp_juggernaut_carepackage_red", &"KILLSTREAKS_HINTS_JUGGERNAUT_PICKUP", "mp_juggernaut_carepackage_dummy" );
    addcratetype( "airdrop_grnd", "heli_pilot", 1, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_HELI_PILOT_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "deployable_vest", 25, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_DEPLOYABLE_VEST_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "deployable_ammo", 20, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "ball_drone_radar", 20, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_BALL_DRONE_RADAR_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "aa_launcher", 20, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_AA_LAUNCHER_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "jammer", 10, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_JAMMER_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "air_superiority", 10, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_AIR_SUPERIORITY_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "recon_agent", 15, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_RECON_AGENT_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "heli_sniper", 10, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_HELI_SNIPER_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "uav_3dping", 5, ::killstreakcratethink, "carepackage_friendly_iw6", "carepackage_enemy_iw6", &"KILLSTREAKS_HINTS_UAV_3DPING_PICKUP", "carepackage_dummy_iw6" );
    addcratetype( "airdrop_grnd", "airdrop_juggernaut_recon", 5, ::_ID18982, "mp_juggernaut_carepackage", "mp_juggernaut_carepackage_red", &"KILLSTREAKS_HINTS_JUGGERNAUT_RECON_PICKUP", "mp_juggernaut_carepackage_dummy" );

    if ( isdefined( level._ID8769 ) )
        [[ level._ID8769 ]]( "carepackage_friendly_iw6", "carepackage_enemy_iw6" );

    if ( isdefined( level._ID20636 ) )
        [[ level._ID20636 ]]();

    generatemaxweightedcratevalue();
    var_0 = spawnstruct();
    var_0._ID36472 = "destroyed_airdrop";
    var_0._ID35387 = undefined;
    var_0.callout = "callout_destroyed_airdrop";
    var_0.samdamagescale = 0.09;
    level.heliconfigs["airdrop"] = var_0;
    maps\mp\gametypes\_rank::registerscoreinfo( "little_bird", 200 );
}

generatemaxweightedcratevalue()
{
    foreach ( var_6, var_1 in level.cratetypes )
    {
        level._ID8252[var_6] = 0;

        foreach ( var_3 in var_1 )
        {
            var_4 = var_3.type;

            if ( !level.cratetypes[var_6][var_4]._ID25497 )
            {
                level.cratetypes[var_6][var_4]._ID36301 = level.cratetypes[var_6][var_4]._ID25497;
                continue;
            }

            level._ID8252[var_6] = level._ID8252[var_6] + level.cratetypes[var_6][var_4]._ID25497;
            level.cratetypes[var_6][var_4]._ID36301 = level._ID8252[var_6];
        }
    }
}

changecrateweight( var_0, var_1, var_2 )
{
    if ( !isdefined( level.cratetypes[var_0] ) || !isdefined( level.cratetypes[var_0][var_1] ) )
        return;

    level.cratetypes[var_0][var_1]._ID25497 = var_2;
    generatemaxweightedcratevalue();
}

setairdropcratecollision( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );

    if ( !isdefined( var_1 ) || var_1.size == 0 )
        return;

    level.airdropcratecollision = getent( var_1[0].target, "targetname" );

    foreach ( var_3 in var_1 )
        var_3 deletecrate();
}

addcratetype( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isdefined( var_4 ) )
        var_4 = "carepackage_friendly_iw6";

    if ( !isdefined( var_5 ) )
        var_5 = "carepackage_enemy_iw6";

    if ( !isdefined( var_8 ) )
        var_8 = "carepackage_dummy_iw6";

    level.cratetypes[var_0][var_1] = spawnstruct();
    level.cratetypes[var_0][var_1].droptype = var_0;
    level.cratetypes[var_0][var_1].type = var_1;
    level.cratetypes[var_0][var_1]._ID25497 = var_2;
    level.cratetypes[var_0][var_1]._ID36301 = var_2;
    level.cratetypes[var_0][var_1].func = var_3;
    level.cratetypes[var_0][var_1]._ID21266 = var_4;
    level.cratetypes[var_0][var_1].model_name_enemy = var_5;
    level.cratetypes[var_0][var_1].model_name_dummy = var_8;

    if ( isdefined( var_6 ) )
        game["strings"][var_1 + "_hint"] = var_6;

    if ( isdefined( var_7 ) )
        game["strings"][var_1 + "_optional_hint"] = var_7;
}

getrandomcratetype( var_0 )
{
    var_1 = randomint( level._ID8252[var_0] );
    var_2 = undefined;

    foreach ( var_4 in level.cratetypes[var_0] )
    {
        var_5 = var_4.type;

        if ( !level.cratetypes[var_0][var_5]._ID36301 )
            continue;

        var_2 = var_5;

        if ( level.cratetypes[var_0][var_5]._ID36301 > var_1 )
            break;
    }

    return var_2;
}

getcratetypefordroptype( var_0 )
{
    switch ( var_0 )
    {
        case "airdrop_sentry_minigun":
            return "sentry";
        case "airdrop_predator_missile":
            return "predator_missile";
        case "airdrop_juggernaut":
            return "airdrop_juggernaut";
        case "airdrop_juggernaut_def":
            return "airdrop_juggernaut_def";
        case "airdrop_juggernaut_gl":
            return "airdrop_juggernaut_gl";
        case "airdrop_juggernaut_recon":
            return "airdrop_juggernaut_recon";
        case "airdrop_juggernaut_maniac":
            return "airdrop_juggernaut_maniac";
        case "airdrop_remote_tank":
            return "remote_tank";
        case "airdrop_lase":
            return "lasedStrike";
        case "airdrop_assault":
        case "airdrop_mega":
        case "airdrop_support":
        case "airdrop_grnd":
        case "airdrop_escort":
        case "airdrop_grnd_mega":
        case "airdrop_sotf":
        default:
            if ( isdefined( level.getrandomcratetypeforgamemode ) )
                return [[ level.getrandomcratetypeforgamemode ]]( var_0 );

            return getrandomcratetype( var_0 );
    }
}

_ID33831( var_0, var_1 )
{
    var_2 = var_1;
    var_3 = undefined;

    if ( !isdefined( var_2 ) )
        var_2 = "airdrop_assault";

    var_4 = 1;

    if ( ( level._ID20086.size >= 4 || level._ID12791 >= 4 ) && var_2 != "airdrop_mega" && !issubstr( tolower( var_2 ), "juggernaut" ) )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }
    else if ( maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 + var_4 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        return 0;
    }
    else if ( var_2 == "airdrop_lase" && isdefined( level._ID19398 ) && level._ID19398 )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    if ( var_2 != "airdrop_mega" && !issubstr( tolower( var_2 ), "juggernaut" ) )
        thread _ID36058();

    if ( !issubstr( var_2, "juggernaut" ) )
        maps\mp\_utility::_ID17543();

    var_3 = beginairdropviamarker( var_0, var_2 );

    if ( !isdefined( var_3 ) || !var_3 )
    {
        self notify( "markerDetermined" );
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    if ( var_2 == "airdrop_mega" )
        thread maps\mp\_utility::_ID32672( "used_airdrop_mega", self );

    self notify( "markerDetermined" );
    maps\mp\_matchdata::_ID20253( var_2, self.origin );
    return 1;
}

_ID36058()
{
    self endon( "markerDetermined" );
    self waittill( "disconnect" );
    return;
}

beginairdropviamarker( var_0, var_1 )
{
    self notify( "beginAirdropViaMarker" );
    self endon( "beginAirdropViaMarker" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self._ID32931 = undefined;
    self._ID32932 = undefined;
    thread _ID36036( var_0, var_1 );
    thread _ID36034( var_0, var_1 );
    thread _ID36033( var_0, var_1 );
    var_2 = common_scripts\utility::_ID35635( "notAirDropWeapon", "markerDetermined" );

    if ( isdefined( var_2 ) && var_2 == "markerDetermined" )
        return 1;
    else if ( !isdefined( var_2 ) && isdefined( self._ID32931 ) )
        return 1;

    return 0;
}

_ID36036( var_0, var_1 )
{
    level endon( "game_ended" );
    self notify( "watchAirDropWeaponChange" );
    self endon( "watchAirDropWeaponChange" );
    self endon( "disconnect" );
    self endon( "markerDetermined" );

    while ( maps\mp\_utility::_ID18585() )
        wait 0.05;

    var_2 = self getcurrentweapon();

    if ( maps\mp\killstreaks\_killstreaks::isairdropmarker( var_2 ) )
        var_3 = var_2;
    else
        var_3 = undefined;

    while ( maps\mp\killstreaks\_killstreaks::isairdropmarker( var_2 ) )
    {
        self waittill( "weapon_switch_started",  var_2  );

        if ( maps\mp\killstreaks\_killstreaks::isairdropmarker( var_2 ) )
            var_3 = var_2;
    }

    if ( isdefined( self._ID32931 ) )
    {
        var_4 = maps\mp\_utility::getkillstreakweapon( self.pers["killstreaks"][self._ID32932]._ID31889 );
        self takeweapon( var_4 );
        self notify( "markerDetermined" );
    }
    else
        self notify( "notAirDropWeapon" );
}

_ID36034( var_0, var_1 )
{
    level endon( "game_ended" );
    self notify( "watchAirDropMarkerUsage" );
    self endon( "watchAirDropMarkerUsage" );
    self endon( "disconnect" );
    self endon( "markerDetermined" );

    for (;;)
    {
        self waittill( "grenade_pullback",  var_2  );

        if ( !maps\mp\killstreaks\_killstreaks::isairdropmarker( var_2 ) )
            continue;

        common_scripts\utility::_disableusability();
        beginairdropmarkertracking();
    }
}

_ID36033( var_0, var_1 )
{
    level endon( "game_ended" );
    self notify( "watchAirDropMarker" );
    self endon( "watchAirDropMarker" );
    self endon( "disconnect" );
    self endon( "markerDetermined" );

    for (;;)
    {
        self waittill( "grenade_fire",  var_2, var_3  );

        if ( !maps\mp\killstreaks\_killstreaks::isairdropmarker( var_3 ) )
            continue;

        self._ID32931 = 1;
        self._ID32932 = self._ID19258;
        var_2 thread airdropdetonateonstuck();
        var_2.owner = self;
        var_2._ID36273 = var_3;
        var_2 thread airdropmarkeractivate( var_1 );
    }
}

beginairdropmarkertracking()
{
    level endon( "game_ended" );
    self notify( "beginAirDropMarkerTracking" );
    self endon( "beginAirDropMarkerTracking" );
    self endon( "death" );
    self endon( "disconnect" );
    common_scripts\utility::_ID35626( "grenade_fire", "weapon_change" );
    common_scripts\utility::_enableusability();
}

airdropmarkeractivate( var_0, var_1 )
{
    level endon( "game_ended" );
    self notify( "airDropMarkerActivate" );
    self endon( "airDropMarkerActivate" );
    self waittill( "explode",  var_2  );
    var_3 = self.owner;

    if ( !isdefined( var_3 ) )
        return;

    if ( var_3 maps\mp\_utility::_ID18678() )
        return;

    if ( issubstr( tolower( var_0 ), "escort_airdrop" ) && isdefined( level.chopper ) )
        return;

    wait 0.05;

    if ( issubstr( tolower( var_0 ), "juggernaut" ) )
        level _ID10336( var_3, var_2, randomfloat( 360 ), var_0 );
    else if ( issubstr( tolower( var_0 ), "escort_airdrop" ) )
        var_3 maps\mp\killstreaks\_escortairdrop::finishsupportescortusage( var_1, var_2, randomfloat( 360 ), "escort_airdrop" );
    else
        level _ID10390( var_3, var_2, randomfloat( 360 ), var_0 );
}

_ID17879()
{
    self._ID18318 = 0;
    self hide();

    if ( isdefined( self.target ) )
    {
        self.collision = getent( self.target, "targetname" );
        self.collision notsolid();
    }
    else
        self.collision = undefined;
}

_ID9617( var_0 )
{
    wait 0.25;
    self linkto( var_0, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_0 waittill( "death" );
    self delete();
}

crateteammodelupdater()
{
    self endon( "death" );
    self hide();

    foreach ( var_1 in level.players )
    {
        if ( var_1.team != "spectator" )
            self showtoplayer( var_1 );
    }

    for (;;)
    {
        level waittill( "joined_team" );
        self hide();

        foreach ( var_1 in level.players )
        {
            if ( var_1.team != "spectator" )
                self showtoplayer( var_1 );
        }
    }
}

_ID8255( var_0 )
{
    self endon( "death" );
    self hide();

    foreach ( var_2 in level.players )
    {
        if ( var_2.team == "spectator" )
        {
            if ( var_0 == "allies" )
                self showtoplayer( var_2 );

            continue;
        }

        if ( var_2.team == var_0 )
            self showtoplayer( var_2 );
    }

    for (;;)
    {
        level waittill( "joined_team" );
        self hide();

        foreach ( var_2 in level.players )
        {
            if ( var_2.team == "spectator" )
            {
                if ( var_0 == "allies" )
                    self showtoplayer( var_2 );

                continue;
            }

            if ( var_2.team == var_0 )
                self showtoplayer( var_2 );
        }
    }
}

cratemodelenemyteamsupdater( var_0 )
{
    self endon( "death" );
    self hide();

    foreach ( var_2 in level.players )
    {
        if ( var_2.team != var_0 )
            self showtoplayer( var_2 );
    }

    for (;;)
    {
        level waittill( "joined_team" );
        self hide();

        foreach ( var_2 in level.players )
        {
            if ( var_2.team != var_0 )
                self showtoplayer( var_2 );
        }
    }
}

cratemodelplayerupdater( var_0, var_1 )
{
    self endon( "death" );
    self hide();

    foreach ( var_3 in level.players )
    {
        if ( var_1 && isdefined( var_0 ) && var_3 != var_0 )
            continue;

        if ( !var_1 && isdefined( var_0 ) && var_3 == var_0 )
            continue;

        self showtoplayer( var_3 );
    }

    for (;;)
    {
        level waittill( "joined_team" );
        self hide();

        foreach ( var_3 in level.players )
        {
            if ( var_1 && isdefined( var_0 ) && var_3 != var_0 )
                continue;

            if ( !var_1 && isdefined( var_0 ) && var_3 == var_0 )
                continue;

            self showtoplayer( var_3 );
        }
    }
}

crateuseteamupdater( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        _ID29195( var_0 );
        level waittill( "joined_team" );
    }
}

_ID8271( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        _ID29194( var_0 );
        level waittill( "joined_team" );
    }
}

_ID8268()
{
    if ( !issubstr( self.cratetype, "juggernaut" ) )
        return;

    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "juggernaut_equipped",  var_0  );
        self disableplayeruse( var_0 );
        thread crateusepostjuggernautupdater( var_0 );
    }
}

crateusepostjuggernautupdater( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 waittill( "death" );
    self enableplayeruse( var_0 );
}

createairdropcrate( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = spawn( "script_model", var_3 );
    var_6.curprogress = 0;
    var_6._ID34780 = 0;
    var_6._ID34766 = 0;
    var_6.team = self.team;
    var_6.destination = var_4;
    var_6._ID17334 = "care_package";

    if ( isdefined( var_0 ) )
        var_6.owner = var_0;
    else
        var_6.owner = undefined;

    var_6.cratetype = var_2;
    var_6.droptype = var_1;
    var_6.targetname = "care_package";
    var_7 = "carepackage_dummy_iw6";

    if ( isdefined( level.custom_dummy_crate_model ) )
        var_7 = level.custom_dummy_crate_model;

    var_6 setmodel( var_7 );

    if ( var_2 == "airdrop_jackpot" )
    {
        var_6.friendlymodel = spawn( "script_model", var_3 );
        var_6.friendlymodel setmodel( level.cratetypes[var_1][var_2]._ID21266 );
        var_6.friendlymodel thread _ID9617( var_6 );
    }
    else
    {
        var_6.friendlymodel = spawn( "script_model", var_3 );
        var_6.friendlymodel setmodel( level.cratetypes[var_1][var_2]._ID21266 );

        if ( isdefined( level.highlightairdrop ) && level.highlightairdrop )
        {
            if ( !isdefined( var_5 ) )
                var_5 = 2;

            var_6.friendlymodel hudoutlineenable( var_5, 0 );
            var_6.outlinecolor = var_5;
        }

        var_6._ID12071 = spawn( "script_model", var_3 );
        var_6._ID12071 setmodel( level.cratetypes[var_1][var_2].model_name_enemy );
        var_6.friendlymodel setentityowner( var_6 );
        var_6._ID12071 setentityowner( var_6 );
        var_6.friendlymodel thread _ID9617( var_6 );

        if ( level._ID32653 )
            var_6.friendlymodel thread _ID8255( var_6.team );
        else
            var_6.friendlymodel thread cratemodelplayerupdater( var_0, 1 );

        var_6._ID12071 thread _ID9617( var_6 );

        if ( level.multiteambased )
            var_6._ID12071 thread cratemodelenemyteamsupdater( var_6.team );
        else if ( level._ID32653 )
            var_6._ID12071 thread _ID8255( level._ID23070[var_6.team] );
        else
            var_6._ID12071 thread cratemodelplayerupdater( var_0, 0 );
    }

    var_6._ID18318 = 0;
    var_6 clonebrushmodeltoscriptmodel( level.airdropcratecollision );
    var_6 thread common_scripts\utility::entity_path_disconnect_thread( 1.0 );
    var_6._ID19214 = spawn( "script_model", var_6.origin + ( 0, 0, 300 ), 0, 1 );
    var_6._ID19214 setscriptmoverkillcam( "explosive" );
    var_6._ID19214 linkto( var_6 );
    level.numdropcrates++;
    var_6 thread dropcrateexistence( var_4 );
    level notify( "createAirDropCrate",  var_6  );
    return var_6;
}

dropcrateexistence( var_0 )
{
    level endon( "game_ended" );
    self waittill( "death" );

    if ( isdefined( level.cratekill ) )
        [[ level.cratekill ]]( var_0 );

    level.numdropcrates--;
}

cratesetupforuse( var_0, var_1 )
{
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( var_0 );
    self makeusable();
    var_2 = "compass_objpoint_ammo_friendly";
    var_3 = "compass_objpoint_ammo_enemy";

    if ( isdefined( level._ID22508 ) )
        var_3 = "compass_objpoint_ammo_friendly";

    if ( !isdefined( self._ID22499 ) )
        self._ID22499 = createobjective( var_2, self.team, 1 );

    if ( !isdefined( self._ID22498 ) )
        self._ID22498 = createobjective( var_3, level._ID23070[self.team], 0 );

    thread crateuseteamupdater();
    thread _ID8268();

    if ( issubstr( self.cratetype, "juggernaut" ) )
    {
        foreach ( var_5 in level.players )
        {
            if ( var_5 maps\mp\_utility::_ID18666() )
                thread crateusepostjuggernautupdater( var_5 );
        }
    }

    var_7 = undefined;

    if ( level._ID32653 )
        var_7 = maps\mp\_entityheadicons::setheadicon( self.team, var_1, ( 0, 0, 24 ), 14, 14, 0, undefined, undefined, undefined, undefined, 0 );
    else if ( isdefined( self.owner ) )
        var_7 = maps\mp\_entityheadicons::setheadicon( self.owner, var_1, ( 0, 0, 24 ), 14, 14, 0, undefined, undefined, undefined, undefined, 0 );

    if ( isdefined( var_7 ) )
        var_7.showinkillcam = 0;

    if ( isdefined( level.iconvisall ) )
        [[ level.iconvisall ]]( self, var_1 );
    else
    {
        foreach ( var_5 in level.players )
        {
            if ( var_5.team == "spectator" )
                var_7 = maps\mp\_entityheadicons::setheadicon( var_5, var_1, ( 0, 0, 24 ), 14, 14, 0, undefined, undefined, undefined, undefined, 0 );
        }
    }
}

createobjective( var_0, var_1, var_2 )
{
    var_3 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_3, "invisible", ( 0, 0, 0 ) );

    if ( !isdefined( self getlinkedparent() ) )
        objective_position( var_3, self.origin );
    else
        objective_onentity( var_3, self );

    objective_state( var_3, "active" );
    objective_icon( var_3, var_0 );

    if ( !level._ID32653 && isdefined( self.owner ) )
    {
        if ( var_2 )
            objective_playerteam( var_3, self.owner getentitynumber() );
        else
            objective_playerenemyteam( var_3, self.owner getentitynumber() );
    }
    else
        objective_team( var_3, var_1 );

    if ( isdefined( level._ID22508 ) )
        [[ level._ID22508 ]]( var_3 );

    return var_3;
}

_ID29195( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( issubstr( self.cratetype, "juggernaut" ) && var_2 maps\mp\_utility::_ID18666() )
        {
            self disableplayeruse( var_2 );
            continue;
        }

        if ( issubstr( self.cratetype, "lased" ) && isdefined( var_2._ID16418 ) && var_2._ID16418 )
        {
            self disableplayeruse( var_2 );
            continue;
        }

        if ( !isdefined( var_0 ) || var_0 == var_2.team )
        {
            self enableplayeruse( var_2 );
            continue;
        }

        self disableplayeruse( var_2 );
    }
}

_ID29194( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( issubstr( self.cratetype, "juggernaut" ) && var_2 maps\mp\_utility::_ID18666() )
        {
            self disableplayeruse( var_2 );
            continue;
        }

        if ( !isdefined( var_0 ) || var_0 != var_2.team )
        {
            self enableplayeruse( var_2 );
            continue;
        }

        self disableplayeruse( var_2 );
    }
}

_ID11103( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = [];
    self.owner endon( "disconnect" );

    if ( !isdefined( var_4 ) )
    {
        if ( isdefined( var_7 ) )
        {
            var_10 = undefined;
            var_11 = undefined;

            for ( var_12 = 0; var_12 < 100; var_12++ )
            {
                var_11 = getcratetypefordroptype( var_1 );
                var_10 = 0;

                for ( var_13 = 0; var_13 < var_7.size; var_13++ )
                {
                    if ( var_11 == var_7[var_13] )
                    {
                        var_10 = 1;
                        break;
                    }
                }

                if ( var_10 == 0 )
                    break;
            }

            if ( var_10 == 1 )
                var_11 = getcratetypefordroptype( var_1 );
        }
        else
            var_11 = getcratetypefordroptype( var_1 );
    }
    else
        var_11 = var_4;

    if ( !isdefined( var_6 ) )
        var_6 = ( randomint( 50 ), randomint( 50 ), randomint( 50 ) );

    var_9 = createairdropcrate( self.owner, var_1, var_11, var_5, var_0 );

    switch ( var_1 )
    {
        case "airdrop_juggernaut":
        case "airdrop_juggernaut_recon":
        case "airdrop_juggernaut_maniac":
        case "airdrop_mega":
        case "nuke_drop":
            var_9 linkto( self, "tag_ground", ( 64, 32, -128 ), ( 0, 0, 0 ) );
            break;
        case "airdrop_escort":
        case "airdrop_osprey_gunner":
            var_9 linkto( self, var_8, ( 0, 0, 0 ), ( 0, 0, 0 ) );
            break;
        default:
            var_9 linkto( self, "tag_ground", ( 32, 0, 5 ), ( 0, 0, 0 ) );
            break;
    }

    var_9.angles = ( 0, 0, 0 );
    var_9 show();
    var_14 = self.veh_speed;

    if ( issubstr( var_11, "juggernaut" ) )
        var_6 = ( 0, 0, 0 );

    thread _ID35554( var_9, var_6, var_1, var_11 );
    var_9.droppingtoground = 1;
    return var_11;
}

killplayerfromcrate_dodamage( var_0 )
{
    if ( isdefined( level._ID22072 ) && level._ID22072 )
        return;

    var_0 dodamage( 1000, var_0.origin, self, self, "MOD_CRUSH" );
}

killplayerfromcrate_fastvelocitypush()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "player_pushed",  var_0, var_1  );

        if ( isplayer( var_0 ) || isagent( var_0 ) )
        {
            if ( var_1[2] < -20 )
                killplayerfromcrate_dodamage( var_0 );
        }

        wait 0.05;
    }
}

airdrop_override_death_moving_platform( var_0 )
{
    if ( isdefined( var_0.lasttouchedplatform.destroyairdroponcollision ) && var_0.lasttouchedplatform.destroyairdroponcollision )
    {
        playfx( common_scripts\utility::_ID15033( "airdrop_crate_destroy" ), self.origin );
        deletecrate();
    }
}

_ID36966()
{
    var_0 = self getlinkedchildren( 1 );

    if ( !isdefined( var_0 ) )
        return;

    foreach ( var_2 in var_0 )
    {
        if ( !isplayer( var_2 ) )
            continue;

        if ( isdefined( var_2.iscapturingcrate ) && var_2.iscapturingcrate )
        {
            var_3 = var_2 getlinkedparent();

            if ( isdefined( var_3 ) )
            {
                var_2 maps\mp\gametypes\_gameobjects::_ID34638( var_3, 0 );
                var_2 unlink();
            }

            if ( isalive( var_2 ) )
                var_2 common_scripts\utility::_enableweapon();

            var_2.iscapturingcrate = 0;
        }
    }
}

airdrop_override_invalid_moving_platform( var_0 )
{
    wait 0.05;
    self notify( "restarting_physics" );
    _ID36966();
    self physicslaunchserver( ( 0, 0, 0 ), var_0.dropimpulse, var_0.airdrop_max_linear_velocity );
    thread _ID23529( var_0.droptype, var_0.cratetype );
    thread _ID23530( var_0.droptype, var_0.cratetype, var_0.dropimpulse, var_0.airdrop_max_linear_velocity );
}

_ID35554( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_0 endon( "death" );

    if ( !isdefined( var_5 ) || !var_5 )
        self waittill( "drop_crate" );

    var_6 = 1200;

    if ( isdefined( var_4 ) )
        var_6 = var_4;

    var_0 unlink();
    var_0 physicslaunchserver( ( 0, 0, 0 ), var_1, var_6 );
    var_0 thread _ID23529( var_2, var_3 );
    var_0 thread _ID23530( var_2, var_3, var_1, var_6 );
    var_0 thread killplayerfromcrate_fastvelocitypush();
    var_0._ID34249 = ::killplayerfromcrate_dodamage;

    if ( isdefined( var_0._ID19214 ) )
    {
        if ( isdefined( var_0.carestrike ) )
            var_7 = -2100;
        else
            var_7 = 0;

        var_0._ID19214 unlink();
        var_8 = bullettrace( var_0.origin, var_0.origin + ( 0, 0, -10000 ), 0, var_0 );
        var_9 = distance( var_0.origin, var_8["position"] );
        var_10 = var_9 / 800;
        var_0._ID19214 moveto( var_8["position"] + ( 0, 0, 300 ) + ( var_7, 0, 0 ), var_10 );
    }
}

_ID23529( var_0, var_1 )
{
    self endon( "restarting_physics" );
    self endon( "physics_finished" );
    wait 0.5;

    for (;;)
    {
        if ( !isdefined( self ) )
            return;

        var_2 = bullettrace( self.origin, self.origin + ( 0, 0, -60 ), 0, self, 0, 0, 0, 1 );

        if ( var_2["fraction"] < 1.0 )
        {
            var_3 = 600;
            self physicssetmaxlinvel( var_3 );
            thread _ID35532();
            return;
        }

        common_scripts\utility::_ID35582();
    }
}

_ID35532()
{
    self endon( "death" );
    wait 0.035;
    playfx( level._ID1644["airdrop_dust_kickup"], self.origin + ( 0, 0, 5 ), ( 0, 0, 1 ) );
    self.friendlymodel scriptmodelplayanim( "juggernaut_carepackage" );
    self._ID12071 scriptmodelplayanim( "juggernaut_carepackage" );
}

_ID23530( var_0, var_1, var_2, var_3 )
{
    self endon( "restarting_physics" );
    self waittill( "physics_finished" );
    self.droppingtoground = 0;
    self thread [[ level.cratetypes[var_0][var_1].func ]]( var_0 );
    level thread droptimeout( self, self.owner, var_1 );
    var_4 = spawnstruct();
    var_4.endonstring = "restarting_physics";
    var_4.deathoverridecallback = ::airdrop_override_death_moving_platform;
    var_4._ID18321 = ::airdrop_override_invalid_moving_platform;
    var_4.droptype = var_0;
    var_4.cratetype = var_1;
    var_4.dropimpulse = var_2;
    var_4.airdrop_max_linear_velocity = var_3;
    thread maps\mp\_movers::_ID16165( var_4 );

    if ( self.friendlymodel maps\mp\_utility::_ID33165() )
    {
        deletecrate();
        return;
    }

    if ( isdefined( self.owner ) && abs( self.origin[2] - self.owner.origin[2] ) > 3000 )
        deletecrate();
}

droptimeout( var_0, var_1, var_2 )
{
    if ( isdefined( level._ID22075 ) && level._ID22075 )
        return;

    level endon( "game_ended" );
    var_0 endon( "death" );

    if ( var_0.droptype == "nuke_drop" )
        return;

    var_3 = 90.0;

    if ( var_2 == "supply" )
        var_3 = 20.0;

    maps\mp\gametypes\_hostmigration::_ID35597( var_3 );

    while ( var_0.curprogress != 0 )
        wait 1;

    var_0 deletecrate();
}

getpathstart( var_0, var_1 )
{
    var_2 = 100;
    var_3 = 15000;
    var_4 = ( 0, var_1, 0 );
    var_5 = var_0 + anglestoforward( var_4 ) * ( -1 * var_3 );
    var_5 += ( ( randomfloat( 2 ) - 1 ) * var_2, ( randomfloat( 2 ) - 1 ) * var_2, 0 );
    return var_5;
}

_ID15232( var_0, var_1 )
{
    var_2 = 150;
    var_3 = 15000;
    var_4 = ( 0, var_1, 0 );
    var_5 = var_0 + anglestoforward( var_4 + ( 0, 90, 0 ) ) * var_3;
    var_5 += ( ( randomfloat( 2 ) - 1 ) * var_2, ( randomfloat( 2 ) - 1 ) * var_2, 0 );
    return var_5;
}

_ID15024( var_0 )
{
    var_1 = 850;
    var_2 = getent( "airstrikeheight", "targetname" );

    if ( !isdefined( var_2 ) )
    {
        if ( isdefined( level.airstrikeheightscale ) )
        {
            if ( level.airstrikeheightscale > 2 )
            {
                var_1 = 1500;
                return var_1 * level.airstrikeheightscale;
            }

            return var_1 * level.airstrikeheightscale + 256 + var_0[2];
        }
        else
            return var_1 + var_0[2];
    }
    else
        return var_2.origin[2];
}

_ID10390( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() )
        return;

    var_6 = _ID15024( var_1 );

    if ( isdefined( var_4 ) )
        var_6 += var_4;

    foreach ( var_8 in level._ID20086 )
    {
        if ( isdefined( var_8.droptype ) )
            var_6 += 128;
    }

    var_10 = var_1 * ( 1, 1, 0 ) + ( 0, 0, var_6 );
    var_11 = getpathstart( var_10, var_2 );
    var_12 = _ID15232( var_10, var_2 );
    var_10 += anglestoforward( ( 0, var_2, 0 ) ) * -50;
    var_13 = _ID16757( var_0, var_11, var_10 );

    if ( isdefined( level.highlightairdrop ) && level.highlightairdrop )
        var_13 hudoutlineenable( 3, 0 );

    var_13 endon( "death" );
    var_13.droptype = var_3;
    var_13 setvehgoalpos( var_10, 1 );
    var_13 thread _ID11103( var_1, var_3, var_6, 0, var_5, var_11 );
    wait 2;
    var_13 vehicle_setspeed( 75, 40 );
    var_13 setyawspeed( 180, 180, 180, 0.3 );
    var_13 waittill( "goal" );
    wait 0.1;
    var_13 notify( "drop_crate" );
    var_13 setvehgoalpos( var_12, 1 );
    var_13 vehicle_setspeed( 300, 75 );
    var_13._ID19788 = 1;
    var_13 waittill( "goal" );
    var_13 notify( "leaving" );
    var_13 notify( "delete" );
    maps\mp\_utility::decrementfauxvehiclecount();
    var_13 delete();
}

_ID10607( var_0, var_1, var_2, var_3 )
{
    level thread _ID10390( var_0, var_1, var_2, var_3, 0 );
    wait(randomintrange( 1, 2 ));
    level thread _ID10390( var_0, var_1 + ( 128, 128, 0 ), var_2, var_3, 128 );
    wait(randomintrange( 1, 2 ));
    level thread _ID10390( var_0, var_1 + ( 172, 256, 0 ), var_2, var_3, 256 );
    wait(randomintrange( 1, 2 ));
    level thread _ID10390( var_0, var_1 + ( 64, 0, 0 ), var_2, var_3, 0 );
}

_ID10336( var_0, var_1, var_2, var_3 )
{
    var_4 = 18000;
    var_5 = 3000;
    var_6 = vectortoyaw( var_1 - var_0.origin );
    var_7 = ( 0, var_6, 0 );
    var_8 = _ID15024( var_1 );
    var_9 = var_1 + anglestoforward( var_7 ) * ( -1 * var_4 );
    var_9 = var_9 * ( 1, 1, 0 ) + ( 0, 0, var_8 );
    var_10 = var_1 + anglestoforward( var_7 ) * var_4;
    var_10 = var_10 * ( 1, 1, 0 ) + ( 0, 0, var_8 );
    var_11 = length( var_9 - var_10 );
    var_12 = var_11 / var_5;
    var_13 = c130setup( var_0, var_9, var_10 );
    var_13.veh_speed = var_5;
    var_13.droptype = var_3;
    var_13 playloopsound( "veh_ac130_dist_loop" );
    var_13.angles = var_7;
    var_14 = anglestoforward( var_7 );
    var_13 moveto( var_10, var_12, 0, 0 );
    var_15 = distance2d( var_13.origin, var_1 );
    var_16 = 0;

    for (;;)
    {
        var_17 = distance2d( var_13.origin, var_1 );

        if ( var_17 < var_15 )
            var_15 = var_17;
        else if ( var_17 > var_15 )
            break;

        if ( var_17 < 320 )
            break;
        else if ( var_17 < 768 )
        {
            earthquake( 0.15, 1.5, var_1, 1500 );

            if ( !var_16 )
            {
                var_13 playsound( "veh_ac130_sonic_boom" );
                var_16 = 1;
            }
        }

        wait 0.05;
    }

    wait 0.05;
    var_18 = ( 0, 0, 0 );

    if ( !maps\mp\_utility::_ID18363() )
        var_19[0] = var_13 thread _ID11103( var_1, var_3, var_8, 0, undefined, var_9, var_18 );

    wait 0.05;
    var_13 notify( "drop_crate" );
    var_20 = var_1 + anglestoforward( var_7 ) * ( var_4 * 1.5 );
    var_13 moveto( var_20, var_12 / 2, 0, 0 );
    wait 6;
    var_13 delete();
}

domegac130flyby( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = 24000;
    var_6 = 2000;
    var_7 = vectortoyaw( var_1 - var_0.origin );
    var_8 = ( 0, var_7, 0 );
    var_9 = anglestoforward( var_8 );

    if ( isdefined( var_4 ) )
        var_1 += var_9 * var_4;

    var_10 = _ID15024( var_1 );
    var_11 = var_1 + anglestoforward( var_8 ) * ( -1 * var_5 );
    var_11 = var_11 * ( 1, 1, 0 ) + ( 0, 0, var_10 );
    var_12 = var_1 + anglestoforward( var_8 ) * var_5;
    var_12 = var_12 * ( 1, 1, 0 ) + ( 0, 0, var_10 );
    var_13 = length( var_11 - var_12 );
    var_14 = var_13 / var_6;
    var_15 = c130setup( var_0, var_11, var_12 );
    var_15.veh_speed = var_6;
    var_15.droptype = var_3;
    var_15 playloopsound( "veh_ac130_dist_loop" );
    var_15.angles = var_8;
    var_9 = anglestoforward( var_8 );
    var_15 moveto( var_12, var_14, 0, 0 );
    var_16 = distance2d( var_15.origin, var_1 );
    var_17 = 0;

    for (;;)
    {
        var_18 = distance2d( var_15.origin, var_1 );

        if ( var_18 < var_16 )
            var_16 = var_18;
        else if ( var_18 > var_16 )
            break;

        if ( var_18 < 256 )
            break;
        else if ( var_18 < 768 )
        {
            earthquake( 0.15, 1.5, var_1, 1500 );

            if ( !var_17 )
            {
                var_15 playsound( "veh_ac130_sonic_boom" );
                var_17 = 1;
            }
        }

        wait 0.05;
    }

    wait 0.05;
    var_19[0] = var_15 thread _ID11103( var_1, var_3, var_10, 0, undefined, var_11 );
    wait 0.05;
    var_15 notify( "drop_crate" );
    wait 0.05;
    var_19[1] = var_15 thread _ID11103( var_1, var_3, var_10, 0, undefined, var_11, undefined, var_19 );
    wait 0.05;
    var_15 notify( "drop_crate" );
    wait 0.05;
    var_19[2] = var_15 thread _ID11103( var_1, var_3, var_10, 0, undefined, var_11, undefined, var_19 );
    wait 0.05;
    var_15 notify( "drop_crate" );
    wait 0.05;
    var_19[3] = var_15 thread _ID11103( var_1, var_3, var_10, 0, undefined, var_11, undefined, var_19 );
    wait 0.05;
    var_15 notify( "drop_crate" );
    wait 4;
    var_15 delete();
}

dropnuke( var_0, var_1, var_2 )
{
    var_3 = 24000;
    var_4 = 2000;
    var_5 = randomint( 360 );
    var_6 = ( 0, var_5, 0 );
    var_7 = _ID15024( var_0 );
    var_8 = var_0 + anglestoforward( var_6 ) * ( -1 * var_3 );
    var_8 = var_8 * ( 1, 1, 0 ) + ( 0, 0, var_7 );
    var_9 = var_0 + anglestoforward( var_6 ) * var_3;
    var_9 = var_9 * ( 1, 1, 0 ) + ( 0, 0, var_7 );
    var_10 = length( var_8 - var_9 );
    var_11 = var_10 / var_4;
    var_12 = c130setup( var_1, var_8, var_9 );
    var_12.veh_speed = var_4;
    var_12.droptype = var_2;
    var_12 playloopsound( "veh_ac130_dist_loop" );
    var_12.angles = var_6;
    var_13 = anglestoforward( var_6 );
    var_12 moveto( var_9, var_11, 0, 0 );
    var_14 = 0;
    var_15 = distance2d( var_12.origin, var_0 );

    for (;;)
    {
        var_16 = distance2d( var_12.origin, var_0 );

        if ( var_16 < var_15 )
            var_15 = var_16;
        else if ( var_16 > var_15 )
            break;

        if ( var_16 < 256 )
            break;
        else if ( var_16 < 768 )
        {
            earthquake( 0.15, 1.5, var_0, 1500 );

            if ( !var_14 )
            {
                var_12 playsound( "veh_ac130_sonic_boom" );
                var_14 = 1;
            }
        }

        wait 0.05;
    }

    var_12 thread _ID11103( var_0, var_2, var_7, 0, "nuke", var_8 );
    wait 0.05;
    var_12 notify( "drop_crate" );
    wait 4;
    var_12 delete();
}

_ID31848( var_0 )
{
    self endon( "death" );
    wait(var_0);
    self stoploopsound();
}

_ID24618( var_0 )
{
    var_1 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_1 hide();
    var_1 endon( "death" );
    thread common_scripts\utility::delete_on_death( var_1 );
    var_1.origin = self.origin;
    var_1.angles = self.angles;
    var_1 linkto( self );
    var_1 playloopsound( var_0 );
    self waittill( "stop sound" + var_0 );
    var_1 stoploopsound( var_0 );
    var_1 delete();
}

c130setup( var_0, var_1, var_2 )
{
    var_3 = vectortoangles( var_2 - var_1 );
    var_4 = spawnplane( var_0, "script_model", var_1, "compass_objpoint_c130_friendly", "compass_objpoint_c130_enemy" );
    var_4 setmodel( "vehicle_ac130_low_mp" );

    if ( !isdefined( var_4 ) )
        return;

    var_4.owner = var_0;
    var_4.team = var_0.team;
    level.c130 = var_4;
    return var_4;
}

_ID16757( var_0, var_1, var_2 )
{
    var_3 = vectortoangles( var_2 - var_1 );
    var_4 = "littlebird_mp";

    if ( isdefined( level._ID35160 ) )
        var_4 = level._ID35160;

    var_5 = spawnhelicopter( var_0, var_1, var_3, var_4, level._ID20077 );

    if ( !isdefined( var_5 ) )
        return;

    var_5 maps\mp\killstreaks\_helicopter::addtolittlebirdlist();
    var_5 thread maps\mp\killstreaks\_helicopter::_ID26000();
    var_5.maxhealth = 500;
    var_5.owner = var_0;
    var_5.team = var_0.team;
    var_5._ID18537 = 1;
    var_5 thread _ID36142();
    var_5 thread _ID16564();
    var_5 thread _ID16726();
    var_5 thread maps\mp\killstreaks\_helicopter::_ID16549( "airdrop" );
    var_5 setmaxpitchroll( 45, 85 );
    var_5 vehicle_setspeed( 250, 175 );
    var_5._ID16760 = "airdrop";
    var_5 hidepart( "tag_wings" );
    return var_5;
}

_ID36142()
{
    level endon( "game_ended" );
    self endon( "leaving" );
    self endon( "helicopter_gone" );
    self endon( "death" );
    maps\mp\gametypes\_hostmigration::_ID35597( 25.0 );
    self notify( "death" );
}

_ID16564()
{
    common_scripts\utility::_ID35626( "crashing", "leaving" );
    self notify( "helicopter_gone" );
}

_ID16726()
{
    self endon( "leaving" );
    self endon( "helicopter_gone" );
    self waittill( "death" );

    if ( !isdefined( self ) )
        return;

    self vehicle_setspeed( 25, 5 );
    thread _ID19724( randomintrange( 180, 220 ) );
    wait(randomfloatrange( 0.5, 1.5 ));
    self notify( "drop_crate" );
    lbexplode();
}

lbexplode()
{
    var_0 = self.origin + ( 0, 0, 1 ) - self.origin;
    playfx( level._ID7233["explode"]["death"]["cobra"], self.origin, var_0 );
    self playsound( "exp_helicopter_fuel" );
    self notify( "explode" );
    maps\mp\_utility::decrementfauxvehiclecount();
    self delete();
}

_ID19724( var_0 )
{
    self endon( "explode" );
    playfxontag( level._ID7233["explode"]["medium"], self, "tail_rotor_jnt" );
    playfxontag( level._ID7233["fire"]["trail"]["medium"], self, "tail_rotor_jnt" );
    self setyawspeed( var_0, var_0, var_0 );

    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[1] + var_0 * 0.9 );
        wait 1;
    }
}

_ID22356()
{
    while ( isdefined( self ) )
    {
        self waittill( "trigger",  var_0  );

        if ( !var_0 isonground() )
            continue;

        if ( !_ID34751( var_0 ) )
            continue;

        self notify( "captured",  var_0  );
    }
}

crateothercapturethink( var_0 )
{
    self endon( "restarting_physics" );

    while ( isdefined( self ) )
    {
        self waittill( "trigger",  var_1  );

        if ( isdefined( self.owner ) && var_1 == self.owner )
            continue;

        if ( !_ID34838( var_1 ) )
            continue;

        if ( isdefined( level.overridecrateusetime ) )
            var_2 = level.overridecrateusetime;
        else
            var_2 = undefined;

        var_1.iscapturingcrate = 1;
        var_3 = _ID8492();
        var_4 = var_3 _ID34751( var_1, var_2, var_0 );

        if ( isdefined( var_3 ) )
            var_3 delete();

        if ( !isdefined( var_1 ) )
            return;

        if ( !var_4 )
        {
            var_1.iscapturingcrate = 0;
            continue;
        }

        var_1.iscapturingcrate = 0;
        self notify( "captured",  var_1  );
    }
}

crateownercapturethink( var_0 )
{
    self endon( "restarting_physics" );

    while ( isdefined( self ) )
    {
        self waittill( "trigger",  var_1  );

        if ( isdefined( self.owner ) && var_1 != self.owner )
            continue;

        if ( !_ID34838( var_1 ) )
            continue;

        var_1.iscapturingcrate = 1;

        if ( !_ID34751( var_1, 500, var_0 ) )
        {
            var_1.iscapturingcrate = 0;
            continue;
        }

        var_1.iscapturingcrate = 0;
        self notify( "captured",  var_1  );
    }
}

crateallcapturethink( var_0 )
{
    self endon( "restarting_physics" );
    self._ID37028 = [];

    while ( isdefined( self ) )
    {
        self waittill( "trigger",  var_1  );

        if ( !_ID34838( var_1 ) )
            continue;

        if ( isdefined( level.overridecrateusetime ) )
            var_2 = level.overridecrateusetime;
        else
            var_2 = undefined;

        childthread _ID37027( var_1, var_2, var_0 );
    }
}

_ID37027( var_0, var_1, var_2 )
{
    var_0.iscapturingcrate = 1;
    self._ID37028[var_0.name] = _ID8492();
    var_3 = self._ID37028[var_0.name];
    var_4 = self._ID37028[var_0.name] _ID34751( var_0, var_1, var_2, self );

    if ( isdefined( self._ID37028 ) && isdefined( var_3 ) )
    {
        self._ID37028 = maps\mp\_utility::array_remove_keep_index( self._ID37028, var_3 );
        var_3 delete();
    }

    if ( !isdefined( var_0 ) )
        return;

    var_0.iscapturingcrate = 0;

    if ( var_4 )
        self notify( "captured",  var_0  );
}

_ID38228()
{
    self._ID18318 = 0;

    foreach ( var_1 in self._ID37028 )
    {
        if ( var_1._ID18318 )
        {
            self._ID18318 = 1;
            break;
        }
    }
}

_ID34838( var_0 )
{
    if ( ( self.cratetype == "airdrop_juggernaut_recon" || self.cratetype == "airdrop_juggernaut" || self.cratetype == "airdrop_juggernaut_maniac" ) && var_0 maps\mp\_utility::_ID18666() )
        return 0;

    if ( isdefined( var_0._ID22850 ) && var_0._ID22850 )
        return 0;

    var_1 = var_0 getcurrentweapon();

    if ( maps\mp\_utility::_ID18679( var_1 ) && !maps\mp\_utility::_ID18671( var_1 ) )
        return 0;

    if ( isdefined( var_0.changingweapon ) && maps\mp\_utility::_ID18679( var_0.changingweapon ) && !issubstr( var_0.changingweapon, "jugg_mp" ) )
        return 0;

    return 1;
}

killstreakcratethink( var_0 )
{
    self endon( "restarting_physics" );
    self endon( "death" );

    if ( isdefined( game["strings"][self.cratetype + "_hint"] ) )
        var_1 = game["strings"][self.cratetype + "_hint"];
    else
        var_1 = &"PLATFORM_GET_KILLSTREAK";

    cratesetupforuse( var_1, maps\mp\_utility::getkillstreakoverheadicon( self.cratetype ) );
    thread crateothercapturethink();
    thread crateownercapturethink();

    for (;;)
    {
        self waittill( "captured",  var_2  );

        if ( isplayer( var_2 ) )
        {
            var_2 setclientomnvar( "ui_securing", 0 );
            var_2._ID34183 = undefined;
        }

        if ( isdefined( self.owner ) && var_2 != self.owner )
        {
            if ( !level._ID32653 || var_2.team != self.team )
            {
                switch ( var_0 )
                {
                    case "airdrop_assault":
                    case "airdrop_support":
                    case "airdrop_escort":
                    case "airdrop_osprey_gunner":
                        var_2 thread maps\mp\gametypes\_missions::_ID14249( "hijacker_airdrop" );
                        var_2 thread _ID16927( self, "airdrop" );
                        break;
                    case "airdrop_sentry_minigun":
                        var_2 thread maps\mp\gametypes\_missions::_ID14249( "hijacker_airdrop" );
                        var_2 thread _ID16927( self, "sentry" );
                        break;
                    case "airdrop_remote_tank":
                        var_2 thread maps\mp\gametypes\_missions::_ID14249( "hijacker_airdrop" );
                        var_2 thread _ID16927( self, "remote_tank" );
                        break;
                    case "airdrop_mega":
                        var_2 thread maps\mp\gametypes\_missions::_ID14249( "hijacker_airdrop_mega" );
                        var_2 thread _ID16927( self, "emergency_airdrop" );
                        break;
                }
            }
            else
            {
                self.owner thread maps\mp\gametypes\_rank::giverankxp( "killstreak_giveaway", int( maps\mp\killstreaks\_killstreaks::_ID15382( self.cratetype ) / 10 * 50 ) );
                self.owner thread maps\mp\gametypes\_hud_message::_ID31053( "sharepackage", int( maps\mp\killstreaks\_killstreaks::_ID15382( self.cratetype ) / 10 * 50 ) );
            }
        }

        var_2 playlocalsound( "ammo_crate_use" );
        var_2 thread maps\mp\killstreaks\_killstreaks::_ID15602( self.cratetype, 0, 0, self.owner );
        var_2 maps\mp\gametypes\_hud_message::_ID19270( self.cratetype, undefined );
        deletecrate();
    }
}

lasedstrikecratethink( var_0 )
{
    self endon( "restarting_physics" );
    self endon( "death" );
    cratesetupforuse( game["strings"]["marker_hint"], maps\mp\_utility::getkillstreakoverheadicon( self.cratetype ) );
    level._ID19398 = 1;
    thread crateownercapturethink();
    thread crateothercapturethink();
    var_1 = 0;
    var_2 = thread maps\mp\killstreaks\_lasedstrike::_ID30909( self.owner );
    level.lasedstrikedrone = var_2;
    level._ID19397 = 1;
    level._ID30382 = self;

    for (;;)
    {
        self waittill( "captured",  var_3  );

        if ( isdefined( self.owner ) && var_3 != self.owner )
        {
            if ( !level._ID32653 || var_3.team != self.team )
                deletecrate();
        }

        _ID29195( self.team );
        var_3 thread maps\mp\killstreaks\_lasedstrike::givemarker();
        var_1++;

        if ( var_1 >= 5 )
            deletecrate();
    }
}

nukecratethink( var_0 )
{
    self endon( "restarting_physics" );
    self endon( "death" );
    cratesetupforuse( &"PLATFORM_CALL_NUKE", maps\mp\_utility::getkillstreakoverheadicon( self.cratetype ) );
    thread _ID22356();

    for (;;)
    {
        self waittill( "captured",  var_1  );
        var_1 thread [[ level._ID19256[self.cratetype] ]]( level._ID15845 );
        level notify( "nukeCaptured",  var_1  );

        if ( isdefined( level._ID15845 ) && level._ID15845 )
            var_1.capturednuke = 1;

        var_1 playlocalsound( "ammo_crate_use" );
        deletecrate();
    }
}

_ID18982( var_0 )
{
    self endon( "restarting_physics" );
    self endon( "death" );
    cratesetupforuse( game["strings"][self.cratetype + "_hint"], maps\mp\_utility::getkillstreakoverheadicon( self.cratetype ) );
    thread crateothercapturethink();
    thread crateownercapturethink();

    for (;;)
    {
        self waittill( "captured",  var_1  );

        if ( isdefined( self.owner ) && var_1 != self.owner )
        {
            if ( !level._ID32653 || var_1.team != self.team )
            {
                if ( self.cratetype == "airdrop_juggernaut_maniac" )
                    var_1 thread _ID16927( self, "maniac" );
                else if ( maps\mp\_utility::_ID18801( self.cratetype, "juggernaut_" ) )
                    var_1 thread _ID16927( self, self.cratetype );
                else
                    var_1 thread _ID16927( self, "juggernaut" );
            }
            else
            {
                self.owner thread maps\mp\gametypes\_rank::giverankxp( "killstreak_giveaway", int( maps\mp\killstreaks\_killstreaks::_ID15382( self.cratetype ) / 10 ) * 50 );

                if ( self.cratetype == "airdrop_juggernaut_maniac" )
                    self.owner maps\mp\gametypes\_hud_message::_ID24474( "giveaway_juggernaut_maniac", var_1 );
                else if ( maps\mp\_utility::_ID18801( self.cratetype, "juggernaut_" ) )
                    self.owner maps\mp\gametypes\_hud_message::_ID24474( "giveaway_" + self.cratetype, var_1 );
                else
                    self.owner maps\mp\gametypes\_hud_message::_ID24474( "giveaway_juggernaut", var_1 );
            }
        }

        var_1 playlocalsound( "ammo_crate_use" );
        var_2 = "juggernaut";

        switch ( self.cratetype )
        {
            case "airdrop_juggernaut":
                var_2 = "juggernaut";
                break;
            case "airdrop_juggernaut_recon":
                var_2 = "juggernaut_recon";
                break;
            case "airdrop_juggernaut_maniac":
                var_2 = "juggernaut_maniac";
                break;
            default:
                if ( maps\mp\_utility::_ID18801( self.cratetype, "juggernaut_" ) )
                    var_2 = self.cratetype;

                break;
        }

        var_1 thread maps\mp\killstreaks\_juggernaut::givejuggernaut( var_2 );
        deletecrate();
    }
}

_ID28164( var_0 )
{
    self endon( "death" );
    cratesetupforuse( game["strings"]["sentry_hint"], maps\mp\_utility::getkillstreakoverheadicon( self.cratetype ) );
    thread crateothercapturethink();
    thread crateownercapturethink();

    for (;;)
    {
        self waittill( "captured",  var_1  );

        if ( isdefined( self.owner ) && var_1 != self.owner )
        {
            if ( !level._ID32653 || var_1.team != self.team )
            {
                if ( issubstr( var_0, "airdrop_sentry" ) )
                    var_1 thread _ID16927( self, "sentry" );
                else
                    var_1 thread _ID16927( self, "emergency_airdrop" );
            }
            else
            {
                self.owner thread maps\mp\gametypes\_rank::giverankxp( "killstreak_giveaway", int( maps\mp\killstreaks\_killstreaks::_ID15382( "sentry" ) / 10 ) * 50 );
                self.owner maps\mp\gametypes\_hud_message::_ID24474( "giveaway_sentry", var_1 );
            }
        }

        var_1 playlocalsound( "ammo_crate_use" );
        var_1 thread _ID28175();
        deletecrate();
    }
}

deletecrate()
{
    self notify( "crate_deleting" );

    if ( isdefined( self._ID34737 ) )
    {
        foreach ( var_1 in self._ID34737 )
        {
            var_1 setclientomnvar( "ui_securing", 0 );
            var_1._ID34183 = undefined;
        }
    }

    if ( isdefined( self._ID22499 ) )
        maps\mp\_utility::_objective_delete( self._ID22499 );

    if ( isdefined( self._ID22498 ) )
    {
        if ( level.multiteambased )
        {
            foreach ( var_4 in self._ID22498 )
                maps\mp\_utility::_objective_delete( var_4 );
        }
        else
            maps\mp\_utility::_objective_delete( self._ID22498 );
    }

    if ( isdefined( self.bomb ) && isdefined( self.bomb._ID19214 ) )
        self.bomb._ID19214 delete();

    if ( isdefined( self.bomb ) )
        self.bomb delete();

    if ( isdefined( self._ID19214 ) )
        self._ID19214 delete();

    if ( isdefined( self.droptype ) )
        playfx( common_scripts\utility::_ID15033( "airdrop_crate_destroy" ), self.origin );

    self delete();
}

_ID28175()
{
    if ( !maps\mp\killstreaks\_autosentry::_ID15629( "sentry_minigun" ) )
        maps\mp\killstreaks\_killstreaks::_ID15602( "sentry" );
}

_ID16927( var_0, var_1 )
{
    self notify( "hijacker",  var_1, var_0.owner  );
}

_ID25641( var_0 )
{
    var_1 = self getweaponslistall();

    if ( var_0 )
    {
        if ( maps\mp\_utility::_hasperk( "specialty_tacticalinsertion" ) && self getammocount( "flare_mp" ) < 1 )
            maps\mp\_utility::_ID15613( "specialty_tacticalinsertion", 0 );
    }

    foreach ( var_3 in var_1 )
    {
        if ( issubstr( var_3, "grenade" ) || getsubstr( var_3, 0, 2 ) == "gl" )
        {
            if ( !var_0 || self getammocount( var_3 ) >= 1 )
                continue;
        }

        self givemaxammo( var_3 );
    }
}

_ID34751( var_0, var_1, var_2, var_3 )
{
    maps\mp\_movers::script_mover_link_to_use_object( var_0 );
    var_0 common_scripts\utility::_disableweapon();
    self.curprogress = 0;
    self._ID18318 = 1;
    self._ID34766 = 0;

    if ( isdefined( var_3 ) )
        var_3 _ID38228();

    if ( isdefined( var_1 ) )
        self._ID34780 = var_1;
    else
        self._ID34780 = 3000;

    var_4 = useholdthinkloop( var_0 );

    if ( isalive( var_0 ) )
        var_0 common_scripts\utility::_enableweapon();

    if ( isdefined( var_0 ) )
        maps\mp\_movers::script_mover_unlink_from_use_object( var_0 );

    if ( !isdefined( self ) )
        return 0;

    self._ID18318 = 0;
    self.curprogress = 0;

    if ( isdefined( var_3 ) )
        var_3 _ID38228();

    return var_4;
}

useholdthinkloop( var_0 )
{
    while ( var_0 maps\mp\killstreaks\_deployablebox::_ID37552( self ) )
    {
        if ( !var_0 maps\mp\_movers::script_mover_use_can_link( self ) )
        {
            var_0 maps\mp\gametypes\_gameobjects::_ID34638( self, 0 );
            return 0;
        }

        self.curprogress = self.curprogress + 50 * self._ID34766;

        if ( isdefined( self.objectivescaler ) )
            self._ID34766 = 1 * self.objectivescaler;
        else
            self._ID34766 = 1;

        var_0 maps\mp\gametypes\_gameobjects::_ID34638( self, 1 );

        if ( self.curprogress >= self._ID34780 )
        {
            var_0 maps\mp\gametypes\_gameobjects::_ID34638( self, 0 );
            return maps\mp\_utility::_ID18757( var_0 );
        }

        wait 0.05;
    }

    if ( isdefined( self ) )
        var_0 maps\mp\gametypes\_gameobjects::_ID34638( self, 0 );

    return 0;
}

_ID8492()
{
    var_0 = spawn( "script_origin", self.origin );
    var_0.curprogress = 0;
    var_0._ID34780 = 0;
    var_0._ID34766 = 3000;
    var_0._ID18318 = 0;
    var_0._ID17334 = self._ID17334;
    var_0 linkto( self );
    var_0 thread deleteuseent( self );
    return var_0;
}

deleteuseent( var_0 )
{
    self endon( "death" );
    var_0 waittill( "death" );

    if ( isdefined( self._ID34737 ) )
    {
        foreach ( var_2 in self._ID34737 )
        {
            var_2 setclientomnvar( "ui_securing", 0 );
            var_2._ID34183 = undefined;
        }
    }

    self delete();
}

airdropdetonateonstuck()
{
    self endon( "death" );
    self waittill( "missile_stuck" );
    self detonate();
}

_ID32935( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( level._ID6711 ) )
    {
        foreach ( var_5 in level._ID6711 )
        {
            if ( isdefined( var_5._ID18318 ) && var_5._ID18318 )
                continue;

            var_6 = var_5 getlinkedparent();

            if ( isdefined( var_6 ) && var_6 == var_0 )
            {
                thread _ID30716( var_5, var_1, var_2 );

                if ( isdefined( var_3 ) )
                    maps\mp\_utility::_ID9519( 1.0, ::_ID25876, var_3 );
            }
        }
    }
}

_ID30716( var_0, var_1, var_2 )
{
    var_3 = var_0.owner;
    var_4 = var_0.droptype;
    var_5 = var_0.cratetype;
    var_6 = var_0.origin;
    var_0 deletecrate();
    var_7 = var_3 createairdropcrate( var_3, var_4, var_5, var_6 + var_1, var_6 + var_1 );
    var_7.droppingtoground = 1;
    var_7 thread [[ level.cratetypes[var_7.droptype][var_7.cratetype].func ]]( var_7.droptype );
    common_scripts\utility::_ID35582();
    var_7 clonebrushmodeltoscriptmodel( level.airdropcratecollision );
    var_7 thread common_scripts\utility::entity_path_disconnect_thread( 1.0 );
    var_7 physicslaunchserver( var_7.origin, var_2 );

    if ( isbot( var_7.owner ) )
    {
        wait 0.1;
        var_7.owner notify( "new_crate_to_take" );
    }
}

_ID25876( var_0 )
{
    if ( isdefined( level._ID6711 ) )
    {
        foreach ( var_2 in level._ID6711 )
        {
            if ( isdefined( var_2 ) && isdefined( var_2.friendlymodel ) && var_2.friendlymodel istouching( var_0 ) )
                var_2 deletecrate();
        }
    }
}

_ID14436()
{
    return "carepackage_dummy_iw6";
}

_ID14444()
{
    return "carepackage_enemy_iw6";
}

get_friendly_crate_model()
{
    return "carepackage_friendly_iw6";
}

_ID14437()
{
    return "mp_juggernaut_carepackage_dummy";
}

_ID14446()
{
    return "mp_juggernaut_carepackage_red";
}

get_friendly_juggernaut_crate_model()
{
    return "mp_juggernaut_carepackage";
}
