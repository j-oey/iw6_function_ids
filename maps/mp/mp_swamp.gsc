// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_swamp_precache::_ID20445();
    maps\createart\mp_swamp_art::_ID20445();
    maps\mp\mp_swamp_fx::_ID20445();
    level._ID1644["swamp_slasher_victim"] = loadfx( "vfx/moments/mp_swamp/vfx_spirit_victim" );
    level._ID1644["swamp_slasher_death"] = loadfx( "vfx/moments/mp_swamp/vfx_spirit_victim_killstreak" );
    level._ID1644["vfx_flesh_hit_body_fatal_hatchet"] = loadfx( "vfx/gameplay/impacts/flesh/vfx_flesh_hit_body_fatal_hatchet" );
    maps\mp\_load::_ID20445();
    level._ID20636 = ::_ID38127;
    level.mapcustomkillstreakfunc = ::_ID38128;
    level._ID20635 = ::_ID38126;
    maps\mp\killstreaks\_juggernaut::initlevelcustomjuggernaut( ::_ID38130, ::setjuggswampslasherclass, ::_ID37969, "callout_killed_swamp_slasher" );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 2.5, 7 );
    maps\mp\_compass::_ID29184( "compass_map_mp_swamp" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    setdvar( "r_tessellationCutoffFalloffBase", 600 );
    setdvar( "r_tessellationCutoffDistanceBase", 1600 );
    setdvar( "r_tessellationCutoffFalloff", 600 );
    setdvar( "r_tessellationCutoffDistance", 1600 );
    setdvar( "r_reactiveMotionWindFrequencyScale", 0.1 );
    setdvar( "r_reactiveMotionWindAmplitudeScale", 0.5 );
    maps\mp\_utility::_ID28710( "sm_sunShadowScale", 0.25, 1 );
    maps\mp\_utility::_ID28710( "fx_alphaThreshold", 5, 0 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "urban";
    game["axis_outfit"] = "woodland";
    level thread maps\mp\_breach::_ID20445();
    _ID38255();
    thread _ID38250( "triggerBatCave" );
    thread _ID36620::_ID37998( "alienEasterEgg" );
    maps\mp\bots\_bots_ks::blockkillstreakforbots( "vanguard" );
}

_ID38130( var_0 )
{
    self.isjuggernautlevelcustom = 1;
    self.juggmovespeedscaler = 1.05;
    maps\mp\gametypes\_class::giveloadout( self.pers["team"], var_0, 0 );
    maps\mp\_utility::_ID15611( "specialty_blindeye", 0 );
    maps\mp\_utility::_ID15611( "specialty_coldblooded", 0 );
    maps\mp\_utility::_ID15611( "specialty_noscopeoutline", 0 );
    maps\mp\_utility::_ID15611( "specialty_detectexplosive", 0 );
    maps\mp\_utility::_ID15611( "specialty_marathon", 0 );
    maps\mp\_utility::_ID15611( "specialty_falldamage", 0 );
    self._ID21667 = 1.15;
    _ID38129();
    thread _ID37749();
    thread _ID37748();
    thread maps\mp\_utility::_ID32672( "used_juggernaut_swamp_slasher", self );
    thread _ID38133();
    self.canusekillstreakcallback = ::juggswampslashercanusekillstreak;
    self.killstreakerrormsg = ::juggswampslasherkillsteakerrormsg;
    return 0;
}

juggswampslashercanusekillstreak( var_0 )
{
    if ( var_0 == "heli_sniper" || maps\mp\_utility::_ID18765( var_0 ) )
        return 0;

    return 1;
}

juggswampslasherkillsteakerrormsg()
{
    self iprintlnbold( &"MP_SWAMP_NO_KILLSTREAKS" );
}

setjuggswampslasherclass( var_0 )
{
    var_1 = [];
    var_1["loadoutPrimary"] = "iw6_axe";
    var_1["loadoutPrimaryBuff"] = "specialty_null";
    var_1["loadoutSecondaryBuff"] = "specialty_null";
    var_1["loadoutEquipment"] = "specialty_null";
    return var_1;
}

_ID37969()
{
    if ( isdefined( self._ID16458 ) )
    {
        self detach( self._ID16458, "" );
        self._ID16458 = undefined;
    }

    self setmodel( "mp_fullbody_mp_mmyers_a" );
    self setviewmodel( "viewhands_mp_mmyers" );
    self setclothtype( "nylon" );
}

_ID38171( var_0, var_1 )
{
    maps\mp\killstreaks\_juggernaut::givejuggernaut( var_1 );
    game["player_holding_level_killstrek"] = 0;
    return 1;
}

enable_level_killstreak()
{
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "juggernaut_swamp_slasher", 85 );
}

disable_level_killstreak()
{
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "juggernaut_swamp_slasher", 0 );
}

_ID38127()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    if ( !maps\mp\_utility::allowlevelkillstreaks() || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "juggernaut_swamp_slasher", 85, maps\mp\killstreaks\_airdrop::_ID18982, maps\mp\killstreaks\_airdrop::get_friendly_juggernaut_crate_model(), maps\mp\killstreaks\_airdrop::_ID14446(), &"MP_SWAMP_JUGGERNAUT_SWAMP_SLASHER_PICKUP" );
    level thread _ID38286();
}

_ID38286()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "juggernaut_swamp_slasher" )
        {
            disable_level_killstreak();
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                enable_level_killstreak();
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

_ID38128()
{
    level._ID19256["juggernaut_swamp_slasher"] = ::_ID38171;
}

_ID38126()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "juggernaut_swamp_slasher", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

_ID38133()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );

    for (;;)
    {
        wait 3.0;
        maps\mp\_utility::playplayerandnpcsounds( self, "axeman_breathing_player", "axeman_breathing_sound" );
    }
}

_ID37749()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "killed_enemy",  var_0, var_1  );

        if ( var_1 == "iw6_axe_mp" )
        {
            self.health = int( min( self.health + 2, 100 ) );
            thread _ID38132( var_0 );
        }
    }
}

_ID38132( var_0 )
{
    var_1 = var_0.origin + ( 0, 0, 50 );
    var_2 = self.origin - var_0.origin;
    var_3 = var_0 gettagorigin( "j_neck" );
    playfx( level._ID1644["vfx_flesh_hit_body_fatal_hatchet"], var_3, vectornormalize( var_2 ), anglestoup( var_0 gettagangles( "j_neck" ) ) );
    var_0 playsound( "scn_axe_kill_npc" );
    wait 0.05;
    playfx( level._ID1644["swamp_slasher_victim"], var_1 );
}

_ID37748()
{
    level endon( "game_ended" );
    thread swampslashermusicendoflevel();
    common_scripts\utility::_ID35626( "death", "disconnect" );

    if ( isdefined( self ) )
    {
        playfx( level._ID1644["swamp_slasher_death"], self.origin + ( 0, 0, 50 ) );
        self playsound( "scn_axe_kill_plr" );
    }

    thread _ID38131();
    self.canusekillstreakcallback = undefined;
    self.killstreakerrormsg = undefined;
}

swampslashermusicendoflevel()
{
    self endon( "death" );
    self endon( "disconnect" );
    level waittill( "game_ended" );
    thread _ID38131();
}

_ID38129()
{
    maps\mp\gametypes\_music_and_dialog::disablemusic();
    level.slashermusicent = spawn( "script_origin", ( 0, 0, 0 ) );
    level.slashermusicent playloopsound( "mus_mp_swamp_killstreak_start" );
}

_ID38131()
{
    level.slashermusicent stoploopsound();
    maps\mp\_utility::_ID24645( "mus_mp_swamp_killstreak_end" );
    thread maps\mp\gametypes\_music_and_dialog::enablemusic();
    common_scripts\utility::_ID35582();
    level.slashermusicent delete();
    level.slashermusicent = undefined;
}

_ID38253( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnfx( common_scripts\utility::_ID15033( "vfx_frog_jump_inwater_r" ), var_0, anglestoforward( var_1 ), anglestoup( var_1 ) );
    var_4.trigger = spawn( "trigger_radius", var_2, 0, var_3, 128 );
    var_4.radius = var_3;
    var_4 thread _ID38254();
}

_ID38254()
{
    level endon( "game_ended" );

    for (;;)
    {
        self.trigger waittill( "trigger",  var_0  );
        triggerfx( self );
        wait 30;
    }
}

_ID38255()
{
    _ID38253( ( 543.607, -1866.1, 16.9588 ), ( 273, 270.011, 33.961 ), ( 543.607, -1866.1, 16.9588 ), 400 );
    _ID38253( ( -137.91, -1403.79, 17.1477 ), ( 273, 270, 163.983 ), ( -137.91, -1403.79, 17.1477 ), 400 );
    _ID38253( ( -753.322, 385.262, 2.15145 ), ( 273, 270.009, 95.9661 ), ( -753.322, 385.262, 2.15145 ), 400 );
    _ID38253( ( -928.21, 619.578, 1.96266 ), ( 273, 270.002, 116.968 ), ( -928.21, 619.578, 1.96266 ), 400 );
    _ID38253( ( -1138.44, 365.926, 1.51848 ), ( 274, 269.744, -90.7688 ), ( -1138.44, 365.926, 1.51848 ), 400 );
    _ID38253( ( -941.947, -27.4375, 7.81633 ), ( 273, 270.004, 43.9734 ), ( -941.947, -27.4375, 7.81633 ), 400 );
    _ID38253( ( -1092.89, -419.291, 6.29806 ), ( 273, 270.003, 82.9732 ), ( -1092.89, -419.291, 6.29806 ), 400 );
    _ID38253( ( -758.194, -1355.44, 61.8263 ), ( 273, 270, 176.977 ), ( -758.194, -1355.44, 61.8263 ), 400 );
    _ID38253( ( -198.275, -1725.05, 19.3899 ), ( 273, 270, 100.969 ), ( -198.275, -1725.05, 19.3899 ), 400 );
    _ID38253( ( 721.78, -1614.7, 18.9652 ), ( 273.486, 235.078, 120.847 ), ( 721.78, -1614.7, 18.9652 ), 400 );
    _ID38253( ( 494.378, -1182.59, 2.01686 ), ( 273, 270.003, 0 ), ( 494.378, -1182.59, 2.01686 ), 400 );
}

_ID38250( var_0 )
{
    level endon( "game_ended" );
    var_1 = getent( var_0, "targetname" );

    if ( isdefined( var_1 ) )
    {
        var_1 childthread _ID38249();

        for (;;)
        {
            var_1 waittill( "trigger",  var_2  );
            var_1 thread _ID38251( var_2 );
        }
    }
}

_ID38251( var_0 )
{
    self endon( "batCaveTrigger" );
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_0 notify( "batCaveExit" );
    var_0 endon( "batCaveExit" );
    childthread _ID38252( var_0 );

    while ( var_0 istouching( self ) )
        common_scripts\utility::_ID35582();

    var_0 notify( "batCaveExit" );
}

_ID38252( var_0 )
{
    var_0 endon( "batCaveExit" );
    var_0 waittill( "weapon_fired" );
    self notify( "batCaveTrigger" );
}

_ID38249()
{
    for (;;)
    {
        self waittill( "batCaveTrigger" );
        common_scripts\utility::exploder( 55 );
        var_0 = 60;
        wait(var_0);
    }
}
