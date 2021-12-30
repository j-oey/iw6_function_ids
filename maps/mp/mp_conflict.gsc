// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_conflict_precache::_ID20445();
    maps\createart\mp_conflict_art::_ID20445();
    maps\mp\mp_conflict_fx::_ID20445();
    level._ID16324 = loadfx( "fx/fire/jet_afterburner_harrier_damaged" );
    level._ID16322 = loadfx( "fx/explosions/aerial_explosion_harrier" );
    level._ID16321 = loadfx( "fx/fire/jet_afterburner_harrier" );
    level._ID20636 = ::conflictcustomcratefunc;
    level.mapcustomkillstreakfunc = ::conflictcustomkillstreakfunc;
    level._ID20635 = ::conflictcustombotkillstreakfunc;
    maps\mp\_load::_ID20445();
    maps\mp\_compass::_ID29184( "compass_map_mp_conflict" );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 2.5, 9 );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "urban";
    game["axis_outfit"] = "woodland";
    thread maps\mp\killstreaks\_airstrike::_ID17631();
    thread _ID36620::_ID37998( "alienEasterEgg" );
}

conflictcustomcratefunc()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    if ( !maps\mp\_utility::allowlevelkillstreaks() || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "harrier_airstrike", 80, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"MP_CONFLICT_KILLSTREAKS_HARRIER_PICKUP" );
    maps\mp\killstreaks\_airdrop::generatemaxweightedcratevalue();
    level thread watch_for_conflict_crate();
}

conflictcustomkillstreakfunc()
{
    level._ID19256["harrier_airstrike"] = ::tryuseconflictkillstreak;
}

tryuseconflictkillstreak( var_0, var_1 )
{
    return maps\mp\killstreaks\_airstrike::_ID33832( var_0, var_1 );
}

watch_for_conflict_crate()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "harrier_airstrike" )
        {
            maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "harrier_airstrike", 0 );
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "harrier_airstrike", 80 );
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

conflictcustombotkillstreakfunc()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "harrier_airstrike", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}
