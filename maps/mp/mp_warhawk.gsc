// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_warhawk_precache::_ID20445();
    maps\createart\mp_warhawk_art::_ID20445();
    maps\mp\mp_warhawk_fx::_ID20445();
    maps\mp\mp_warhawk_events::_ID24833();
    var_0 = 50.0;
    var_1 = 70.0;
    level thread maps\mp\mp_warhawk_events::_ID25355( var_0, var_1 );
    level thread maps\mp\mp_warhawk_events::air_raid();
    level._ID20636 = ::_ID35884;
    level.mapcustomkillstreakfunc = ::_ID35885;
    level._ID20635 = ::warhawkcustombotkillstreakfunc;
    maps\mp\_load::_ID20445();
    thread maps\mp\_fx::_ID13742();
    maps\mp\_compass::_ID29184( "compass_map_mp_warhawk" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    maps\mp\_utility::_ID28710( "r_diffuseColorScale", 1.2, 1.5 );
    maps\mp\_utility::_ID28710( "r_specularcolorscale", 1.5, 9 );
    setdvar( "r_ssaorejectdepth", 1500 );
    setdvar( "r_ssaofadedepth", 1200 );

    if ( level._ID25139 )
        setdvar( "sm_sunShadowScale", "0.6" );
    else if ( level._ID36452 )
        setdvar( "sm_sunShadowScale", "0.7" );

    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level thread maps\mp\mp_warhawk_events::_ID23683();
    level thread maps\mp\mp_warhawk_events::_ID16507();
    level thread maps\mp\mp_warhawk_events::chain_gate();
    level thread maps\mp\mp_warhawk_events::_ID12493();
    level thread maps\mp\_breach::_ID20445();
    level._ID1644["default"] = loadfx( "vfx/moments/mp_warhawk/vfx_mp_warhawk_breach_01" );
    level thread _ID37490();
}

_ID37490()
{
    var_0 = spawn( "script_model", ( -449.855, 640.906, 203.344 ) );
    var_0 setmodel( "afr_corrugated_metal8x8" );
    var_0.angles = ( 0, 0, 0 );
    var_1 = spawn( "script_model", ( 1457, 159.5, 143 ) );
    var_1 setmodel( "afr_corrugated_metal8x8" );
    var_1.angles = ( 0, 0, 0 );
}

_ID35924()
{
    while ( getdvarint( "allow_dynamic_events" ) )
        wait 0.05;

    level notify( "stop_dynamic_events" );
}

_ID35884()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    if ( !maps\mp\_utility::allowlevelkillstreaks() || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "warhawk_mortars", 85, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"KILLSTREAKS_HINTS_WARHAWK_MORTARS" );
    level thread _ID35975();
}

_ID35975()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "warhawk_mortars" )
        {
            maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "warhawk_mortars", 0 );
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "warhawk_mortars", 85 );
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

_ID35885()
{
    level._ID19256["warhawk_mortars"] = ::_ID33885;
    level._ID19276["warhawk_mortar_mp"] = "warhawk_mortars";
}

warhawkcustombotkillstreakfunc()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "warhawk_mortars", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

_ID33885( var_0, var_1 )
{
    if ( level._ID2653 )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    game["player_holding_level_killstrek"] = 0;
    level notify( "warhawk_mortar_killstreak",  self  );
    return 1;
}
