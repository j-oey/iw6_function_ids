// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_favela_iw6_precache::_ID20445();
    maps\createart\mp_favela_iw6_art::_ID20445();
    maps\mp\mp_favela_iw6_fx::_ID20445();
    maps\mp\_load::_ID20445();
    level.nukedeathvisionfunc = ::nukedeathvision;
    maps\mp\_compass::_ID29184( "compass_map_mp_favela_iw6" );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 2.5, 10 );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    maps\mp\_utility::_ID28710( "sm_sunShadowScale", 0.55, 1 );
    maps\mp\_utility::_ID28710( "sm_sunsamplesizenear", 0.2, 0.25 );
    maps\mp\_utility::_ID28710( "r_reactiveMotionWindFrequencyScale", 0, 0.1 );
    maps\mp\_utility::_ID28710( "r_reactiveMotionWindAmplitudeScale", 0, 0.5 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "urban";
    game["axis_outfit"] = "woodland";
    thread _ID36620::_ID37998( "alienEasterEgg" );
    thread tvs();
    thread nuke_custom_visionset();
    level._ID20636 = ::favelacustomcratefunc;
    level.mapcustomkillstreakfunc = ::favelacustomkillstreakfunc;
    level._ID20635 = ::favelacustombotkillstreakfunc;
    thread maps\mp\killstreaks\_ac130::_ID17631();
}

favelacustomcratefunc()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    if ( !maps\mp\_utility::allowlevelkillstreaks() || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "ac130", 80, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"MP_FAVELA_IW6_AC130_PICKUP" );
    maps\mp\killstreaks\_airdrop::generatemaxweightedcratevalue();
    level thread watch_for_favela_crate();
}

favelacustomkillstreakfunc()
{
    level._ID19256["ac130"] = ::tryusefavelakillstreak;
    level.ac130player = level.players[0];
}

favelacustombotkillstreakfunc()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "ac130", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

watch_for_favela_crate()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "ac130" )
        {
            maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "ac130", 0 );
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "ac130", 80 );
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

tryusefavelakillstreak( var_0, var_1 )
{
    return maps\mp\killstreaks\_ac130::_ID33830( var_0, var_1 );
}

tvs()
{
    foreach ( var_1 in [ "fav_bar_tv", "fav_bar_tv_large" ] )
        thread tvs_set( var_1 );
}

tvs_set( var_0 )
{
    var_1 = 4;

    for ( var_2 = 1; var_2 <= var_1; var_2++ )
    {
        if ( !isdefined( level._ID1644[var_0][var_2] ) )
            common_scripts\utility::error( "level._effect[" + var_0 + "][" + var_2 + "] not defined." );

        if ( !isdefined( level.tv_info.effectlength[var_0][var_2] ) )
        {
            common_scripts\utility::error( "level.tv_info.effectLength[" + var_0 + "][" + var_2 + "] not defined." );
            level.tv_info.effectlength[var_0][var_2] = 1;
        }
    }

    if ( !isdefined( level.tv_info.destroymodel[var_0] ) )
    {
        common_scripts\utility::error( "level.tv_info.destroymodel[" + var_0 + "] not defined." );
        var_3 = undefined;
    }
    else
        var_3 = level.tv_info.destroymodel[var_0];

    var_4 = getentarray( var_0, "targetname" );

    foreach ( var_6 in var_4 )
    {
        var_6 setcandamage( 1 );
        var_6.ishealthy = 1;
        var_6.destroymodel = var_3;

        if ( isdefined( var_6.script_noteworthy ) )
            var_6 thread playtvaudio( var_6.script_noteworthy );

        var_6 thread tv_death();
    }

    level.tv_fx_num = var_1;

    for (;;)
    {
        var_8 = level.tv_fx_num;
        level.tv_fx_num = randomintrange( 1, var_1 );

        if ( level.tv_fx_num >= var_8 )
            level.tv_fx_num = level.tv_fx_num + 1;

        var_9 = level._ID1644[var_0][level.tv_fx_num];

        foreach ( var_6 in var_4 )
        {
            if ( var_6.ishealthy )
            {
                playfxontag( var_9, var_6, "tag_fx" );
                var_6.currentfx = var_9;
            }
        }

        wait(level.tv_info.effectlength[var_0][level.tv_fx_num]);
    }
}

playtvaudio( var_0 )
{
    var_1 = issubstr( var_0, "large" );
    var_2 = 15;
    wait(var_2);

    if ( var_1 )
        self playloopsound( "mp_favela_vo_tv_big" );
    else
        self playloopsound( "mp_favela_vo_tv" );
}

tv_death()
{
    self endon( "death" );
    self.health = 10000;
    self waittill( "damage" );
    killfxontag( self.currentfx, self, "tag_fx" );
    self stoploopsound();
    self setmodel( self.destroymodel );
    playfxontag( level._ID1644["tv_explode"], self, "tag_fx" );
    playsoundatpos( self.origin, "tv_shot_burst" );
    self.ishealthy = 0;
    self setcandamage( 0 );
}

setupfirehydrants()
{
    var_0 = getentarray( "water", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread hydrantwaitfordeath();
}

hydrantwaitfordeath()
{
    level endon( "game_ended" );
    var_0 = getent( self.target, "targetname" );
    var_0.trigger = self;
    self hide();

    for (;;)
    {
        var_0 waittill( "state_changed",  var_1, var_2, var_3, var_4, var_5, var_6  );

        if ( var_2 == 2 )
            break;
    }

    self show();
    var_0 thread _ID36211( self );
    var_0 thread hydranttimer();
}

_ID36211( var_0 )
{
    level endon( "game_ended" );
    self endon( "hydrant_end" );

    for (;;)
    {
        var_0 waittill( "trigger",  var_1  );

        if ( isplayer( var_1 ) && !isai( var_1 ) && !( isdefined( var_1._ID18349 ) && var_1._ID18349 ) )
            var_1 thread playertrackwatersheet( var_0 );
    }
}

playertrackwatersheet( var_0 )
{
    self endon( "disconnect" );
    self._ID18349 = 1;
    self setwatersheeting( 1 );

    while ( maps\mp\_utility::_ID18757( self ) && isdefined( var_0 ) && self istouching( var_0 ) && !level.gameended )
        wait 0.5;

    self setwatersheeting( 0 );
    self._ID18349 = 0;
}

hydranttimer()
{
    self waittill( "death" );
    self notify( "hydrant_end" );
    self.trigger delete();
}

nuke_custom_visionset()
{
    level waittill( "nuke_death" );
    wait 1.3;
    level notify( "nuke_death" );
    thread nuke_custom_visionset();
}

nukedeathvision()
{
    level._ID22379 = "aftermath_mp_favela";
    setexpfog( 512, 2048, 0.578828, 0.802656, 1, 0.5, 0.75, 5, 0.382813, 0.350569, 0.293091, 0.5, ( 1, -0.109979, 0.267867 ), 0, 80, 1, 0.179688, 26, 180 );
    visionsetnaked( level._ID22379, 5 );
    visionsetpain( level._ID22379 );
}
