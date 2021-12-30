// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_battery3_precache::_ID20445();
    maps\createart\mp_battery3_art::_ID20445();
    maps\mp\mp_battery3_fx::_ID20445();
    maps\mp\_load::_ID20445();
    maps\mp\_compass::_ID29184( "compass_map_mp_battery3" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 2.5, 15 );
    maps\mp\_utility::_ID28710( "r_reactiveMotionWindFrequencyScale", 0, 0.1 );
    maps\mp\_utility::_ID28710( "r_reactiveMotionWindAmplitudeScale", 0, 0.5 );
    maps\mp\_utility::_ID28710( "sm_sunSampleSizeNear", 0.25, 0.55 );
    setdvar( "r_dof_hq", 0 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "urban";
    game["axis_outfit"] = "woodland";
    setuplevelkillstreak();
    thread _ID36211();
}

setuplevelkillstreak()
{
    var_0 = spawnstruct();
    var_0.crateweight = 85;
    var_0.cratehint = &"MP_BATTERY3_VOLCANO_HINT";
    var_0.debugname = "Volcano";
    var_0._ID17334 = "volcano";
    var_0._ID36273 = "warhawk_mortar_mp";
    var_0.sourcestructs = "volcano_source";
    var_0.targetstructs = "volcano_small_target";
    var_0.launchdelay = 3;
    var_0.projectileperloop = 12;
    var_0.model = "ruins_volcano_rock_03";
    var_0.launchdelaymin = 0.05;
    var_0.launchdelaymax = 0.2;
    var_0.launchairtimemin = 6;
    var_0.launchairtimemax = 8;
    var_0.strikeduration = 0.5;
    var_0.rotateprojectiles = 1;
    var_0.minrotatation = -90;
    var_0.maxrotation = 90;
    var_0.incomingsfx = "volcano_incoming";
    var_0.trailvfx = "med_meteor_trail";
    var_0.impactvfx = "med_meteor_impact";
    var_0.impactsfx = "volcano_explosion_dirt";
    level._ID1644["med_meteor_impact"] = loadfx( "vfx/moments/mp_battery3/vfx_ground_impact_medium" );
    level._ID1644["med_meteor_trail"] = loadfx( "vfx/moments/mp_battery3/vfx_smoketrail_meteor_med" );
    level._ID1644["large_meteor_impact"] = loadfx( "vfx/moments/mp_battery3/vfx_ground_impact_large" );
    level._ID1644["large_meteor_trail"] = loadfx( "vfx/moments/mp_battery3/vfx_smoketrail_meteor_large" );
    maps\mp\killstreaks\_mortarstrike::createmortar( var_0 );
    maps\mp\killstreaks\_juggernaut_predator::juggpredatorinit();
    thread waitforpredatordeath();
    level.mapcustomkillstreakfunc = ::battery3customkillstreak;
    level._ID20636 = ::battery3customcrate;
    level._ID20635 = ::battery3custombotkillstreakfunc;
    level thread volcanowaitforuse( var_0.sourcestructs );
    thread _ID36620::_ID37998( "alienEasterEgg" );
}

battery3customkillstreak()
{
    maps\mp\killstreaks\_mortarstrike::mortarcustomkillstreakfunc();
    maps\mp\killstreaks\_juggernaut_predator::customkillstreakfunc();
}

battery3customcrate()
{
    var_0 = level.mortarconfig.crateweight;
    level.mortarconfig.crateweight = 0;
    maps\mp\killstreaks\_mortarstrike::mortarcustomcratefunc();
    level.mortarconfig.crateweight = var_0;
    maps\mp\killstreaks\_juggernaut_predator::_ID8769();
}

battery3custombotkillstreakfunc()
{
    maps\mp\killstreaks\_mortarstrike::mortarcustombotkillstreakfunc();
    maps\mp\killstreaks\_juggernaut_predator::custombotkillstreakfunc();
}

waitforpredatordeath()
{
    level waittill( "jugg_predator_killed",  var_0  );
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", level.mortarconfig._ID17334, level.mortarconfig.crateweight );
}

volcanowaitforuse( var_0 )
{
    level endon( "game_ended" );
    var_1 = common_scripts\utility::_ID15384( var_0, "targetname" );

    for (;;)
    {
        level waittill( "mortar_killstreak_used",  var_2  );
        wait 1.0;
        playsoundatpos( var_1.origin, "volcano_rumble_start" );
        earthquake( 0.1, 5.0, level._ID20634, 15000 );
        level waittill( "mortar_killstreak_start" );
        var_3 = level.mortarconfig;
        playsoundatpos( var_1.origin, "volcano_eruption_primary" );
        common_scripts\utility::exploder( 1 );
        earthquake( 0.3, 2.0, level._ID20634, 15000 );
        playrumble( "artillery_rumble" );
        var_4 = randomfloatrange( 2, 3 );
        wait(var_4);
        var_5[0] = "volcano_eruption_second";
        var_5[1] = "volcano_eruption_third";
        var_5[2] = "volcano_eruption_fourth";

        for ( var_6 = 0; var_6 < 3; var_6++ )
        {
            var_3 maps\mp\killstreaks\_mortarstrike::_ID37707( var_3.launchdelaymin, var_3.launchdelaymax, var_3.launchairtimemin, var_3.launchairtimemax, var_3.strikeduration, var_2 );
            playsoundatpos( var_1.origin, var_5[var_6] );
            common_scripts\utility::exploder( 1 );
            earthquake( 0.3, 2.0, level._ID20634, 15000 );
            playrumble( "damage_light" );
            var_4 = randomfloatrange( 1.0, 2.0 );
            wait(var_4);
        }
    }
}

volcanoinitlargechunks()
{
    level.volcanolargechunks = getentarray( "volcano_bigchunk", "targetname" );

    foreach ( var_1 in level.volcanolargechunks )
        var_1 clearpath();
}

volcanodolargechunks( var_0, var_1 )
{
    if ( level.volcanolargechunks.size == 0 )
        return;

    var_2 = [];
    var_3 = common_scripts\utility::_ID15384( level.mortarconfig.sourcestructs, "targetname" );

    for ( var_4 = 0; var_4 < var_0; var_4++ )
    {
        for ( var_5 = randomint( level.volcanolargechunks.size ); isdefined( var_2[var_5] ); var_5 = randomint( level.volcanolargechunks.size ) )
        {

        }

        var_2[var_5] = 1;
        level.volcanolargechunks[var_5] thread volcanolaunchlargechunk( var_3.origin, var_1 );
        var_6 = randomintrange( 0, 3 ) * 0.05;
        wait(var_6);
    }
}

volcanolaunchlargechunk( var_0, var_1 )
{
    var_2 = ( 0, 0, -800 );
    var_3 = randomfloatrange( 9.0, 12.0 );
    var_4 = trajectorycalculateinitialvelocity( var_0, self.origin, var_2, var_3 );
    self._ID36273 = level.mortarconfig._ID36273;
    self.impactvfx = "large_meteor_impact";
    self.rotateprojectiles = 1;
    self.minrotatation = -150;
    self.maxrotation = 150;
    maps\mp\killstreaks\_mortarstrike::_ID25369( var_0, self.origin, var_3, var_1, var_4, 1 );
    blockpath();
    radiusdamage( self.origin, 80, 1000, 1000, undefined, "MOD_CRUSH" );
    crushallobjects( self.origin, 80 );
}

volcano_activate_at_end_of_match()
{
    level endon( "mortar_killstreak_used" );
    level waittill( "spawning_intermission" );
    level._ID37173 = 1;
    level.mortarconfig maps\mp\killstreaks\_mortarstrike::_ID37707( 0.1, 0.3, 2.5, 2.5, 6, level.players[0] );
    var_0 = common_scripts\utility::_ID15384( level.mortarconfig.sourcestructs, "targetname" );
    var_1 = anglestoforward( vectornormalize( var_0.origin - level._ID20634 ) );
    var_2 = anglestoup( ( 0, 0, 0 ) );
    playfx( common_scripts\utility::_ID15033( "volcano_explode_01" ), var_0.origin, var_2, var_1 );
    earthquake( 0.3, 2.0, level._ID20634, 15000 );
    playrumble( "artillery_rumble" );
}

volcanorumble( var_0, var_1, var_2 )
{
    level endon( "mortar_killstreak_start" );
    level endon( "mortar_killstreak_end" );
    var_3 = gettime() + var_2 * 1000;

    while ( gettime() < var_3 )
    {
        var_4 = randomfloatrange( 0.5, 1.0 );
        earthquake( var_1, var_4, var_0, 15000 );
        playrumble( "damage_light" );
        wait(2.0 * var_4);
    }
}

setuptemple()
{
    var_0 = getentarray( "temple_pre", "targetname" );
    var_1 = getentarray( "temple_post", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 clearpath();

    var_5 = getentarray( "temple_anim", "targetname" );

    foreach ( var_7 in var_5 )
        var_7 hide();

    var_9 = spawnstruct();
    var_9.postcollapse = var_1;
    var_9.precollapse = var_0;
    var_9.animmodels = var_5;
    var_9 thread templecollapse();
}
#using_animtree("vfx_dlc2");

templecollapse()
{
    level waittill( "mortar_killstreak_start" );
    wait 2.0;
    common_scripts\utility::exploder( 55 );
    wait 2.0;

    foreach ( var_1 in self.precollapse )
        var_1 clearpath();

    var_3 = 7.5;

    if ( level._ID25139 || level._ID36452 )
        var_3 = getanimlength( %mp_ruins_td_01_cg_anim );
    else
        var_3 = getanimlength( %mp_ruins_temple_debris_01_anim );

    foreach ( var_5 in self.animmodels )
    {
        var_5 show();
        var_6 = var_5.script_noteworthy;

        if ( !isdefined( var_6 ) )
            var_6 = "mp_ruins_td_01_cg_anim";

        var_5 scriptmodelplayanim( var_6 );
    }

    playsoundatpos( self.precollapse[0].origin, "scn_battery3_temple_collapse" );
    wait 1.5;
    var_8 = undefined;

    foreach ( var_10 in self.postcollapse )
    {
        if ( isdefined( var_10._ID7525 ) )
        {
            var_8 = var_10._ID7525.origin;
            break;
        }
    }

    earthquake( 0.25, 0.5, var_8, 500 );
    radiusdamage( var_8, 500, 500, 500, undefined, "MOD_CRUSH" );
    crushallobjects( var_8, 500 );
    wait 2;

    foreach ( var_13 in self.postcollapse )
        var_13 blockpath();

    wait(var_3 - 3.5);

    foreach ( var_5 in self.animmodels )
        var_5 hide();
}

playrumble( var_0 )
{
    foreach ( var_2 in level.players )
        var_2 playrumbleonentity( var_0 );
}

clearpath()
{
    self hide();
    self notsolid();

    if ( isdefined( self.target ) )
    {
        var_0 = getent( self.target, "targetname" );
        self._ID7525 = var_0;
        var_0 connectpaths();
        var_0 notsolid();
        var_0 hide();
    }
}

blockpath()
{
    self show();
    self solid();

    if ( isdefined( self._ID7525 ) )
    {
        self._ID7525 show();
        self._ID7525 solid();
        self._ID7525 disconnectpaths();
    }
}

crushallobjects( var_0, var_1 )
{
    var_2 = var_1 * var_1;
    crushobjects( var_0, var_2, "death", level._ID34099 );
    crushobjects( var_0, var_2, "death", level.placedims );
    crushobjects( var_0, var_2, "death", level._ID34657 );
    crushobjects( var_0, var_2, "detonateExplosive", level._ID21075 );

    foreach ( var_4 in level._ID9646 )
        crushobjects( var_0, var_2, "death", var_4 );
}

crushobjects( var_0, var_1, var_2, var_3 )
{
    foreach ( var_5 in var_3 )
    {
        if ( distancesquared( var_0, var_5.origin ) < var_1 )
            var_5 notify( var_2 );
    }
}

_ID36211()
{
    level endon( "game_ended" );
    var_0 = getent( "watersheet", "targetname" );

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
    self notify( "predator_force_uncloak" );
    self setwatersheeting( 1 );

    while ( maps\mp\_utility::_ID18757( self ) && self istouching( var_0 ) && !level.gameended )
        wait 0.5;

    self setwatersheeting( 0 );
    self._ID18349 = 0;
}
