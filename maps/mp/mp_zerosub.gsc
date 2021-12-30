// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_zerosub_precache::_ID20445();
    maps\createart\mp_zerosub_art::_ID20445();
    maps\mp\mp_zerosub_fx::_ID20445();
    level._ID20636 = ::zerosubcustomcratefunc;
    level.mapcustomkillstreakfunc = ::zerosubcustomkillstreakfunc;
    level._ID20635 = ::zerosubcustombotkillstreakfunc;
    maps\mp\_load::_ID20445();
    maps\mp\_compass::_ID29184( "compass_map_mp_zerosub" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    setdvar( "r_tessellationCutoffFalloffBase", 600 );
    setdvar( "r_tessellationCutoffDistanceBase", 2000 );
    setdvar( "r_tessellationCutoffFalloff", 600 );
    setdvar( "r_tessellationCutoffDistance", 2000 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "urban";
    game["axis_outfit"] = "woodland";
    _ID38175();
    maps\mp\gametypes\_door::_ID10725( "door_switch" );
    thread _ID36620::_ID37998( "alienEasterEgg" );
    thread tvs();
    level thread watchplayerspawn();
    level.zerosub_killstreak = 0;
    level.zerosub_fog_on = 0;
    level.beastallowedindoors = 1;
    level.custom_death_effect = ::playcustomdeathfx;
    level.custom_death_sound = ::playcustomdeathsound;
    setupevents( 1 );
    level thread _ID34405();
    level thread resetfrostvisionset();
    level thread watchnukevisionset();
}

_ID38175()
{
    var_0 = [ "slide_door", "garage_door" ];

    foreach ( var_2 in var_0 )
    {
        var_3 = getentarray( var_2, "targetname" );

        foreach ( var_5 in var_3 )
        {
            if ( isdefined( var_5.classname ) && var_5.classname == "trigger_multiple" )
            {
                if ( isdefined( var_5._ID27766 ) && issubstr( var_5._ID27766, "prone_only=true" ) )
                    continue;

                if ( var_2 == "slide_door" )
                {
                    var_5.origin = ( var_5.origin[0] + 4, var_5.origin[1], var_5.origin[2] );
                    continue;
                }

                if ( var_2 == "garage_door" )
                    var_5.origin = ( var_5.origin[0] - 8.5, var_5.origin[1], var_5.origin[2] );
            }
        }
    }
}

resetfrostvisionset()
{
    level endon( "game_ended" );
    level waittill( "prematch_over" );
    stopfrostfog();
}

watchnukevisionset()
{
    level endon( "game_ended" );
    level waittill( "nuke_aftermath_post_started" );

    foreach ( var_1 in level.players )
        var_1 visionsetstage( 1, 1 );
}

_ID34405()
{
    var_0 = 700;
    var_1 = var_0 * var_0;

    while ( !isdefined( level._ID23303 ) )
        common_scripts\utility::_ID35582();

    for (;;)
    {
        foreach ( var_3 in level._ID23303 )
        {
            if ( !isplayer( var_3 ) )
                continue;

            if ( isbot( var_3 ) )
            {
                if ( !isdefined( var_3._ID9372 ) )
                    var_3._ID9372 = var_3.maxsightdistsqrd;

                if ( level.zerosub_fog_on )
                {
                    var_3.maxsightdistsqrd = var_1;
                    continue;
                }

                var_3.maxsightdistsqrd = var_3._ID9372;
            }
        }

        common_scripts\utility::_ID35582();
    }
}

precacheitems()
{
    level.zerosub_fx["beast"]["snowcover_screen"] = level._ID1644["vfx_yeti_snowcover_scr"];
    level.zerosub_fx["beast"]["blood_explosion"] = level._ID1644["vfx_blood_explosion"];
    level.zerosub_fx["beast"]["shadow_screen"] = level._ID1644["vfx_yeti_shadow_scr"];
    level.zerosub_fx["beast"]["snowcover"] = level._ID1644["vfx_yeti_snowcover"];
    level.zerosub_fx["beast"]["eyeglow"] = level._ID1644["vfx_yeti_glowing_eye"];
    level.zerosub_fx["breath"]["screen"] = level._ID1644["vfx_yeti_breath_scr"];
    level.zerosub_fx["frost"]["screen"] = level._ID1644["vfx_yeti_frost_scr"];
    level.zerosub_fx["snow"]["screen"] = level._ID1644["vfx_yeti_snow_scr"];
    level.zerosub_fx["snow"]["player"] = level._ID1644["vfx_playercentric_snowamb"];
    level.zerosub_fx["dust"]["player"] = level._ID1644["vfx_playercentric_indoors"];
    level.zerosub_fx["button"]["green"] = level._ID1644["vfx_button_light_green"];
    level.zerosub_fx["button"]["red"] = level._ID1644["vfx_button_light_red"];
}

setupevents( var_0 )
{
    precacheitems();
    playenvironmentanims();
    playbuttonfx();
}

playenvironmentanims()
{
    var_0 = getent( "zerosub_fan_01", "targetname" );
    var_1 = getent( "zerosub_fan_02", "targetname" );
    var_2 = getent( "zerosub_radar_dish", "targetname" );
    var_3 = getentarray( "zerosub_bush_01", "targetname" );
    var_4 = getentarray( "zerosub_tree_02", "targetname" );
    var_5 = getentarray( "zerosub_tree_03", "targetname" );
    var_6 = getentarray( "zerosub_tree_04", "targetname" );
    var_7 = getentarray( "zerosub_tree_05", "targetname" );
    var_8 = getentarray( "zerosub_tree_06", "targetname" );

    if ( isdefined( var_0 ) )
        var_0 scriptmodelplayanim( "mp_zerosub_fan_spin_1" );

    if ( isdefined( var_1 ) )
        var_1 scriptmodelplayanim( "mp_zerosub_fan_spin_2" );

    if ( isdefined( var_2 ) )
        var_2 scriptmodelplayanim( "mp_zerosub_radar_spin" );

    if ( isdefined( var_3 ) )
    {
        foreach ( var_10 in var_3 )
        {
            var_11 = randomfloatrange( 1.0, 3.0 );
            var_10 thread playdelayanim( "mp_zerosub_bush_tree", var_11 );
        }
    }

    if ( isdefined( var_4 ) )
    {
        foreach ( var_14 in var_4 )
        {
            var_11 = randomfloatrange( 1.0, 2.0 );
            var_14 thread playdelayanim( "mp_zerosub_spruce_tree_2", var_11 );
        }
    }

    if ( isdefined( var_5 ) )
    {
        foreach ( var_14 in var_5 )
        {
            var_11 = randomfloatrange( 2.0, 3.0 );
            var_14 thread playdelayanim( "mp_zerosub_spruce_tree_3", var_11 );
        }
    }

    if ( isdefined( var_6 ) )
    {
        foreach ( var_14 in var_6 )
        {
            var_11 = randomfloatrange( 4.0, 5.0 );
            var_14 thread playdelayanim( "mp_zerosub_spruce_tree_4", var_11 );
        }
    }

    if ( isdefined( var_7 ) )
    {
        foreach ( var_14 in var_7 )
        {
            var_11 = randomfloatrange( 5.0, 6.0 );
            var_14 thread playdelayanim( "mp_zerosub_dead_pine", var_11 );
        }
    }

    if ( isdefined( var_8 ) )
    {
        foreach ( var_14 in var_8 )
        {
            var_11 = randomfloatrange( 6.0, 7.0 );
            var_14 thread playdelayanim( "mp_zerosub_dead_tree", var_11 );
        }
    }
}

playbuttonfx()
{
    var_0 = common_scripts\utility::_ID15386( "button_green", "targetname" );
    var_1 = common_scripts\utility::_ID15386( "button_red", "targetname" );

    if ( isdefined( var_0 ) )
    {
        foreach ( var_3 in var_0 )
        {
            var_3.fxobj = spawnfx( level.zerosub_fx["button"]["green"], var_3.origin );
            var_3.fxobj thread delaytriggerfx();
            var_3.fxobj thread cleanupfx();
        }
    }

    if ( isdefined( var_1 ) )
    {
        foreach ( var_3 in var_1 )
        {
            var_3.fxobj = spawnfx( level.zerosub_fx["button"]["red"], var_3.origin );
            var_3.fxobj thread delaytriggerfx();
            var_3.fxobj thread cleanupfx();
        }
    }
}

delaytriggerfx()
{
    level endon( "game_ended" );
    level waittill( "prematch_over" );
    triggerfx( self );
}

cleanupfx()
{
    level waittill( "game_ended" );
    self delete();
}

playdelayanim( var_0, var_1 )
{
    level endon( "game_ended" );
    wait(var_1);
    self scriptmodelplayanim( var_0 );
}

zerosubcustomcratefunc()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    if ( !maps\mp\_utility::allowlevelkillstreaks() || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "zerosub_level_killstreak", 85, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"MP_ZEROSUB_LEVEL_KILLSTREAK_ACTIVATE" );
    level thread zerosub_killstreak_watch_for_crate();
}

zerosubcustomkillstreakfunc()
{
    level._ID19256["zerosub_level_killstreak"] = ::tryusezerosubkillstreak;
}

zerosubcustombotkillstreakfunc()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "zerosub_level_killstreak", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

tryusezerosubkillstreak( var_0, var_1 )
{
    level thread maps\mp\_utility::_ID32672( "used_zerosub_level_killstreak", self );
    level.zerosub_killstreak_user = self;
    playfrostfog();
    level thread watchplayerconnect();
    level thread watchhostmigration();

    foreach ( var_3 in level.players )
    {
        var_3 playlocalsound( "mp_zero_monster_spawn" );

        if ( var_3.team != level.zerosub_killstreak_user.team )
            var_3 thread watchragdoll();
    }

    level thread watchkillstreakend();

    if ( level.zerosub_killstreak )
    {
        level thread killrandomtargets();
        game["player_holding_level_killstrek"] = 0;
        return 1;
    }
    else
    {
        level._ID19276["beast_agent_mp"] = "zerosub_level_killstreak";
        return maps\mp\mp_beast_men::tryuseagentkillstreak();
    }
}

zerosub_killstreak_watch_for_crate()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "zerosub_level_killstreak" )
        {
            maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "zerosub_level_killstreak", 0 );
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "zerosub_level_killstreak", 85 );
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

watchragdoll()
{
    self endon( "disconnected" );
    level endon( "game_ended" );
    level endon( "frost_clear" );

    for (;;)
    {
        self waittill( "start_instant_ragdoll",  var_0, var_1  );
        common_scripts\utility::_ID35582();

        if ( isbeastman( var_1 ) )
            physicsexplosionsphere( var_1.origin + ( 0, 0, 50 ), 100, 90, 5.0 );
    }
}

watchkillstreakend()
{
    level endon( "game_ended" );
    var_0 = 40;

    while ( var_0 > 0 )
    {
        var_0 -= 1;
        maps\mp\gametypes\_hostmigration::_ID35597( 1 );
    }

    foreach ( var_2 in level.players )
    {
        if ( isdefined( var_2 ) )
        {
            if ( isdefined( var_2.killedbyyeti ) )
                var_2.killedbyyeti = undefined;

            if ( isdefined( var_2.isbeinghunted ) )
                var_2.isbeinghunted = undefined;

            if ( isdefined( var_2.beastkillcam ) )
                var_2.beastkillcam = undefined;
        }
    }

    if ( !isdefined( level.nukevisioninprogress ) || !level.nukevisioninprogress )
        stopfrostfog();

    level notify( "frost_clear" );
}

killrandomtargets()
{
    level endon( "game_ended" );
    level endon( "frost_clear" );
    wait 8;

    for (;;)
    {
        var_0 = getkilltarget();
        var_1 = randomintrange( 2, 4 );

        if ( isdefined( var_0 ) )
            var_0 thread delaykill( 3 );

        wait(var_1);
    }
}

getkilltarget()
{
    var_0 = [];
    var_1 = 0;

    foreach ( var_3 in level.players )
    {
        if ( isdefined( var_3 ) && maps\mp\_utility::_ID18757( var_3 ) && var_3.team != level.zerosub_killstreak_user.team && var_3 isoutside() && !var_3 isbeinghunted() && var_3.avoidkillstreakonspawntimer <= 0 && !var_3 maps\mp\killstreaks\_killstreaks::_ID18836() )
            var_0[var_0.size] = var_3;
    }

    if ( var_0.size > 0 )
    {
        var_1 = randomint( var_0.size );
        var_0[var_1].isbeinghunted = 1;
        return var_0[var_1];
    }
}

delaykill( var_0 )
{
    level endon( "game_ended" );
    var_1 = [];
    var_1[var_1.size] = ( 0, 300, 0 );
    var_1[var_1.size] = ( 300, 0, 0 );
    var_1[var_1.size] = ( 300, 300, 0 );
    var_1[var_1.size] = ( 0, -300, 0 );
    var_1[var_1.size] = ( -300, 0, 0 );
    var_1[var_1.size] = ( -300, -300, 0 );
    var_1[var_1.size] = ( -300, 300, 0 );
    var_1[var_1.size] = ( 300, -300, 0 );
    var_2 = randomint( var_1.size );

    if ( !maps\mp\_utility::_ID18837() )
        self playlocalsound( "mp_zerosub_monster_approach" );

    thread playbeastfx();
    var_3 = var_0 - 0.5;
    var_4 = var_0 - var_3;
    wait(var_3);

    if ( isdefined( self ) && maps\mp\_utility::_ID18757( self ) && !maps\mp\_utility::_ID18837() )
    {
        if ( isoutside() && !maps\mp\killstreaks\_killstreaks::_ID18836() )
        {
            var_5 = spawnfxforclient( level.zerosub_fx["beast"]["shadow_screen"], self geteye(), self );
            triggerfx( var_5 );
            var_5 setfxkilldefondelete();
            thread killfxonplayerdeath( var_5 );
            var_6 = spawnfxforclient( level.zerosub_fx["beast"]["snowcover_screen"], self geteye(), self );
            triggerfx( var_6 );
            var_6 setfxkilldefondelete();
            thread killfxonplayerdeath( var_6 );
        }
    }

    wait(var_4);

    if ( isdefined( self ) && maps\mp\_utility::_ID18757( self ) )
    {
        if ( isoutside() && !maps\mp\killstreaks\_killstreaks::_ID18836() )
        {
            if ( !maps\mp\_utility::_ID18837() )
                self playlocalsound( "mp_zero_plr_monster_attack" );

            self playsound( "mp_zero_npc_monster_attack" );
            var_7 = self gettagorigin( "j_mainroot" );
            self.customdeath = 1;
            self.killedbyyeti = 1;
            playfx( level.zerosub_fx["beast"]["blood_explosion"], var_7 );
            self dodamage( 10000, self.origin, level.zerosub_killstreak_user, self.beastkillcam, "MOD_CRUSH" );
            physicsexplosionsphere( self.origin + var_1[var_2], 500, 400, 2.0 );
        }

        self.isbeinghunted = undefined;
    }
}

playbeastfx()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 = 100;

    for (;;)
    {
        var_1 = anglestoforward( self.angles );
        var_2 = self.origin - var_1 * var_0;
        var_3 = spawnfx( level.zerosub_fx["beast"]["snowcover"], var_2 );
        triggerfx( var_3 );
        var_3 thread watchfxlifetime( 2 );
        var_0 -= 20;
        wait 0.5;
    }
}

playfrostfog()
{
    level.zerosub_fog_on = 1;

    foreach ( var_1 in level.players )
        var_1 playfrostfogplayer();
}

playfrostfogplayer( var_0 )
{
    self visionsetstage( 1, 5 );
    thread playdoorwindowsnowcoverfx( var_0 );
    thread delayplayloopscreenfx( "frost", 4, 5 );
    thread delayplayloopscreenfx( "snow", 1, 5 );
    thread delayplayloopscreenfx( "breath", 3, 6 );
}

stopfrostfog()
{
    level.zerosub_fog_on = 0;

    foreach ( var_1 in level.players )
        var_1 visionsetstage( 0, 5 );
}

watchplayerconnect()
{
    level endon( "game_ended" );
    level endon( "frost_clear" );

    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 playfrostfogplayer( 1 );
        var_0 thread startkillstreakwatchers();
    }
}

watchhostmigration()
{
    level endon( "game_ended" );
    level endon( "frost_clear" );

    for (;;)
    {
        level waittill( "host_migration_end" );

        foreach ( var_1 in level.players )
            var_1 visionsetstage( 1, 0.1 );
    }
}

startkillstreakwatchers()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    level endon( "frost_clear" );
    self waittill( "spawned_player" );

    if ( self.team != level.zerosub_killstreak_user.team )
        thread watchragdoll();
}

playdoorwindowsnowcoverfx( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    level endon( "frost_clear" );

    if ( !isdefined( var_0 ) || !var_0 )
        wait 5;

    for (;;)
    {
        if ( !isoutside() )
            common_scripts\utility::exploder( 50, self );

        wait 0.5;
    }
}

delayplayloopscreenfx( var_0, var_1, var_2 )
{
    self notify( "playScreenFX_" + var_0 );
    self endon( "playScreenFX_" + var_0 );
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    level endon( "frost_clear" );
    thread watchplayerspawnfx( var_0, var_1, 0.05 );
    var_3 = 0;

    switch ( var_0 )
    {
        case "frost":
            var_3 = 6;
            break;
        case "snow":
            var_3 = 1;
            break;
        case "breath":
            var_3 = 1;
            break;
    }

    wait(var_2);

    for (;;)
    {
        if ( !level.beastallowedindoors && isoutside() || level.beastallowedindoors && isoutside() && var_0 == "snow" || level.beastallowedindoors && var_0 != "snow" )
        {
            var_4 = spawnfxforclient( level.zerosub_fx[var_0]["screen"], self geteye(), self );

            if ( isdefined( var_4 ) )
            {
                triggerfx( var_4 );
                var_4 setfxkilldefondelete();
                var_4 thread watchfxlifetime( var_3 + 1 );
            }
        }

        wait(var_1);
    }
}

isoutside()
{
    var_0 = 1;

    if ( !isdefined( level.zerosub_inside_trigger ) )
        level.zerosub_inside_trigger = getent( "mp_zerosub_indoor_triggers", "targetname" );

    if ( isdefined( level.zerosub_inside_trigger ) )
    {
        if ( self istouching( level.zerosub_inside_trigger ) )
            var_0 = 0;
    }

    return var_0;
}

isbeinghunted()
{
    var_0 = 0;

    if ( isdefined( self.isbeinghunted ) && self.isbeinghunted )
        var_0 = 1;

    return var_0;
}

watchfxlifetime( var_0 )
{
    level endon( "game_ended" );
    wait(var_0);
    self delete();
}

killfxonplayerdeath( var_0 )
{
    level endon( "game_ended" );
    common_scripts\utility::_ID35626( "killed_player", "disconnect" );

    if ( isdefined( var_0 ) )
    {
        if ( isarray( var_0 ) )
        {
            foreach ( var_2 in var_0 )
                var_2 delete();
        }
        else
            var_0 delete();
    }
}

watchplayerspawnfx( var_0, var_1, var_2 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    level endon( "frost_clear" );
    self waittill( "spawned_player" );
    thread delayplayloopscreenfx( var_0, var_1, var_2 );
}

watchplayerspawn()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "player_spawned",  var_0  );

        if ( isdefined( var_0.customdeath ) )
            var_0.customdeath = undefined;

        if ( isdefined( var_0.beastkillcam ) )
        {
            var_0.beastkillcam.origin = var_0.origin + ( 100, 100, 100 );
            var_0.beastkillcam linkto( var_0 );
        }

        var_0 thread playenvironmentfx();
    }
}

playenvironmentfx()
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = anglestoforward( self.angles );

        if ( isoutside() )
        {
            var_1 = spawnfxforclient( level.zerosub_fx["snow"]["player"], self.origin + var_0 * 100, self );
            triggerfx( var_1 );
            var_1 thread watchfxlifetime( 2 );
        }
        else
        {
            var_2 = spawnfxforclient( level.zerosub_fx["dust"]["player"], self.origin + var_0 * 100, self );
            triggerfx( var_2 );
            var_2 thread watchfxlifetime( 2 );
        }

        wait 1;
    }
}

playcustomdeathfx( var_0, var_1, var_2 )
{
    if ( isbeastman( var_2 ) )
    {
        var_0.customdeath = 1;
        var_3 = var_0 gettagorigin( "j_mainroot" );
        playfx( level.zerosub_fx["beast"]["blood_explosion"], var_3 );
    }
}

playcustomdeathsound( var_0, var_1, var_2 )
{
    if ( var_1 == "MOD_MELEE" )
    {
        if ( isbeastman( var_2 ) )
        {
            var_3 = "male";

            if ( var_0 hasfemalecustomizationmodel() )
                var_3 = "female";

            var_0 playsound( "knife_death_" + var_3 );
        }
    }
    else
        var_0 maps\mp\_utility::_ID23899();
}

isbeastman( var_0 )
{
    var_1 = 0;

    if ( isdefined( var_0 ) && isagent( var_0 ) )
    {
        if ( var_0.agent_type == "beastmen" )
            var_1 = 1;
    }

    return var_1;
}

tvs()
{
    foreach ( var_1 in [ "tv_hockey", "tv_hockey_scale1pt5" ] )
        thread tvs_set( var_1 );
}

tvs_set( var_0 )
{
    if ( !isdefined( level._ID1644[var_0] ) )
        common_scripts\utility::error( "level._effect[" + var_0 + "] not defined." );

    var_1 = 3;

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

    if ( var_4.size == 0 )
    {

    }

    foreach ( var_6 in var_4 )
    {
        var_6 setcandamage( 1 );
        var_6.ishealthy = 1;
        var_6.destroymodel = var_3;
        var_6._ID14036 = level.tv_info.tag[var_0];

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
                playfxontag( var_9, var_6, var_6._ID14036 );
                var_6.currentfx = var_9;
            }
        }

        wait(level.tv_info.effectlength[var_0][level.tv_fx_num]);
    }
}

playtvaudio( var_0 )
{
    var_1 = 15;
    wait(var_1);

    if ( var_0 == "tv_hockey_small_room" )
        self playloopsound( "mp_zerosub_tv_small_room" );
    else
        self playloopsound( "mp_zerosub_tv_big_room" );
}

tv_death()
{
    self endon( "death" );
    self.health = 10000;
    self waittill( "damage" );
    killfxontag( self.currentfx, self, self._ID14036 );
    self stoploopsound();
    self setmodel( self.destroymodel );
    playfxontag( level._ID1644["tv_explode"], self, self._ID14036 );
    playsoundatpos( self.origin, "tv_shot_burst" );
    self.ishealthy = 0;
    self setcandamage( 0 );
}
