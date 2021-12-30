// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_pirate_precache::_ID20445();
    maps\createart\mp_pirate_art::_ID20445();
    maps\mp\mp_pirate_fx::_ID20445();
    maps\mp\_load::_ID20445();
    maps\mp\_compass::_ID29184( "compass_map_mp_pirate" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 2.8, 14 );
    maps\mp\_utility::_ID28710( "sm_sunShadowScale", 0.5, 1 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "urban";
    game["axis_outfit"] = "woodland";
    thread setuplevelkillstreak();
    thread _ID36620::_ID37998( "alienEasterEgg" );
    var_0 = setupdestructible( "destruction_tower" );
    var_0 thread towercollapse( 9 );
    var_1 = setupdestructible( "destruction_window" );
    var_1 thread windowcollapse( 5 );
    thread bellssetup( "churchbell" );

    if ( maps\mp\_utility::_ID18422() )
    {
        game["thermal_vision"] = "thermal_mp";
        setthermalbodymaterial( "thermalbody_snowlevel" );
        visionsetthermal( game["thermal_vision"] );
    }

    thread setupconvos();
}

setuplevelkillstreak()
{
    level._ID1644["cannon_impact"] = loadfx( "vfx/moments/mp_pirate/vfx_exp_can_impact" );
    level._ID1644["random_mortars_trail"] = loadfx( "vfx/moments/mp_pirate/vfx_cannon_trail" );
    level._ID1644["cannon_muzzleflash"] = loadfx( "vfx/moments/mp_pirate/vfx_cannon_blast" );
    level._ID1644["ship_wake"] = loadfx( "vfx/moments/mp_pirate/vfx_ghost_boat_wake" );
    var_0 = spawnstruct();
    var_0.crateweight = 85;
    var_0.cratehint = &"MP_PIRATE_CANNONS_USE";
    var_0.debugname = "Cannon Barrage";
    var_0._ID17334 = "pirate_cannons";
    var_0._ID36273 = "warhawk_mortar_mp";
    var_0._ID31051 = "used_pirate_cannons";
    var_0.sourceents = "ship_cannons";
    var_0.targetstructs = "cannon_target";
    var_0.launchdelay = 12;
    var_0.projectileperloop = 12;
    var_0.delaybetweenvolleys = 6;
    var_0.model = "pirateship_cannon_ball_iw6";
    var_0.launchsfxarray = [ "cannon_fire_1", "cannon_fire_2", "cannon_fire_3", "cannon_fire_4", "cannon_fire_5", "cannon_fire_6", "cannon_fire_7", "cannon_fire_8", "cannon_fire_9", "cannon_fire_10" ];
    var_0.launchsfxstartid = 0;
    var_0._ID19717 = "cannon_muzzleflash";
    var_0.launchdelaymin = 1.0;
    var_0.launchdelaymax = 1.5;
    var_0.launchairtimemin = 2;
    var_0.launchairtimemax = 3;
    var_0.strikeduration = 35;
    var_0.incomingsfx = "cannon_ball_incoming";
    var_0.trailvfx = "random_mortars_trail";
    var_0.impactsfx = "cannon_ball_impact";
    var_0.impactvfx = "cannon_impact";
    shipsetup( "cannon_ship" );
    maps\mp\killstreaks\_mortarstrike::createmortar( var_0 );
    level.mapcustomkillstreakfunc = ::customkillstreakfunc;
    level._ID20636 = ::_ID8769;
    level._ID20635 = ::custombotkillstreakfunc;
    maps\mp\mp_pirate_ghost::_ID17631();
}

customkillstreakfunc()
{
    maps\mp\killstreaks\_mortarstrike::mortarcustomkillstreakfunc();
    level._ID19256["pirate_cannons"] = ::tryusepirateship;
    maps\mp\mp_pirate_ghost::customkillstreakfunc();
}

_ID8769()
{
    maps\mp\killstreaks\_mortarstrike::mortarcustomcratefunc();
    maps\mp\mp_pirate_ghost::_ID8769();
}

custombotkillstreakfunc()
{
    maps\mp\killstreaks\_mortarstrike::mortarcustombotkillstreakfunc();
    maps\mp\mp_pirate_ghost::cusombotkillstreakfunc();
}

setupdestructible( var_0 )
{
    var_1 = getentarray( var_0 + "_before", "targetname" );
    var_2 = getentarray( var_0 + "_after", "targetname" );

    foreach ( var_4 in var_2 )
        var_4 clearpath();

    var_6 = getentarray( var_0 + "_anim", "targetname" );

    foreach ( var_8 in var_6 )
        var_8 hide();

    var_10 = spawnstruct();
    var_10.postcollapse = var_2;
    var_10.precollapse = var_1;
    var_10.animmodels = var_6;
    return var_10;
}

windowcollapse( var_0 )
{
    level waittill( "mortar_killstreak_start" );

    if ( var_0 > 0.775 )
    {
        var_0 = randomfloatrange( var_0, var_0 + 5 );
        wait(var_0 - 0.775);
    }

    common_scripts\utility::exploder( 2 );
    wait 0.775;

    foreach ( var_2 in self.precollapse )
        var_2 clearpath();

    var_4 = 4.0;

    foreach ( var_6 in self.animmodels )
    {
        var_6 show();
        var_7 = var_6.script_noteworthy;

        if ( isdefined( var_7 ) )
            var_6 scriptmodelplayanim( var_7 );
    }

    wait 1.5;
    var_9 = self.postcollapse[0].origin;

    foreach ( var_11 in self.postcollapse )
    {
        if ( isdefined( var_11._ID7525 ) )
        {
            var_9 = var_11._ID7525.origin;
            break;
        }
    }

    earthquake( 0.1, 0.5, var_9, 150 );
    wait(var_4 - 1.5);

    foreach ( var_14 in self.postcollapse )
        var_14 blockpath();

    foreach ( var_6 in self.animmodels )
        var_6 hide();
}

towercollapse( var_0 )
{
    level waittill( "mortar_killstreak_start" );

    if ( var_0 > 0 )
    {
        var_0 = randomfloatrange( var_0, var_0 + 5 );
        wait(var_0 - 0);
    }

    common_scripts\utility::exploder( 1 );

    foreach ( var_2 in self.precollapse )
        var_2 clearpath();

    var_4 = 9;

    foreach ( var_6 in self.animmodels )
    {
        var_6 show();
        var_7 = var_6.script_noteworthy;

        if ( isdefined( var_7 ) )
            var_6 scriptmodelplayanim( var_7 );
    }

    playsoundatpos( self.precollapse[0].origin, "scn_pirate_tower_collapse" );
    wait 1.5;
    var_9 = self.postcollapse[0].origin;

    foreach ( var_11 in self.postcollapse )
    {
        if ( isdefined( var_11._ID7525 ) )
        {
            var_9 = var_11._ID7525.origin;
            break;
        }
    }

    earthquake( 0.25, 0.5, var_9, 300 );
    wait(var_4 - 1.5);

    foreach ( var_6 in self.animmodels )
        var_6 hide();

    foreach ( var_16 in self.postcollapse )
        var_16 blockpath();
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

tryusepirateship( var_0, var_1 )
{
    if ( maps\mp\killstreaks\_mortarstrike::tryusemortars( var_0, var_1 ) )
    {
        thread shiprun( "cannon_ship", "shipPathStart" );
        return 1;
    }

    return 0;
}

shiprun( var_0, var_1 )
{
    var_2 = getent( var_0, "targetname" );
    var_3 = getentarray( "ship_bits", "targetname" );

    foreach ( var_5 in var_3 )
    {
        var_5 show();
        var_5 linkto( var_2 );
    }

    var_2 thread shipbarrageplaymusic();
    var_2 thread shipvo();
    var_7 = common_scripts\utility::_ID15384( var_1, "targetname" );
    var_2.origin = var_7.origin;
    var_2.angles = var_7.angles;
    playfxontag( common_scripts\utility::_ID15033( "ship_wake" ), var_2.waketag, "tag_origin" );

    for ( var_8 = var_7.target; isdefined( var_8 ); var_8 = var_2 shipmove( var_8, 300 ) )
    {

    }

    var_2 stopsounds();
    stopfxontag( common_scripts\utility::_ID15033( "ship_wake" ), var_2.waketag, "tag_origin" );
    var_3 = getentarray( "ship_bits", "targetname" );

    foreach ( var_5 in var_3 )
        var_5 hide();
}

shipsetup( var_0 )
{
    var_1 = getent( var_0, "targetname" );
    var_2 = anglestoforward( var_1.angles );
    var_3 = 350 * anglestoright( var_1.angles );
    var_4 = getentarray( "ship_bits", "targetname" );
    var_5 = var_4[0];

    for ( var_6 = 0; var_6 < 5; var_6++ )
    {
        var_7 = "tag_cannon_" + ( var_6 + 1 );
        var_8 = spawn( "script_model", var_5 gettagorigin( var_7 ) );
        var_8.angles = var_5 gettagangles( var_7 );
        var_8 setmodel( "tag_origin" );
        var_8 linkto( var_1 );
        var_8.targetname = "ship_cannons";
    }

    var_1.cannons = var_1 getlinkedchildren();
    var_9 = spawn( "script_model", var_5 gettagorigin( "tag_wake" ) + ( 0, 0, 85 ) );
    var_9.angles = var_1.angles + ( -90, 0, 0 );
    var_9 setmodel( "tag_origin" );
    var_9 linkto( var_1 );
    var_1.waketag = var_9;

    foreach ( var_11 in var_4 )
        var_11 hide();
}

shipmove( var_0, var_1 )
{
    var_2 = common_scripts\utility::_ID15384( var_0, "targetname" );

    if ( isdefined( var_2 ) )
    {
        if ( !isdefined( var_2._ID21687 ) )
            var_2._ID21687 = distance2d( var_2.origin, self.origin ) / var_1;

        self moveto( var_2.origin, var_2._ID21687, 0, 0 );
        self rotateto( var_2.angles, var_2._ID21687, 0, 0 );
        wait(var_2._ID21687);
        return var_2.target;
    }

    return undefined;
}

shipbarrageplaymusic()
{
    level endon( "game_ended" );
    self.waketag playsoundonmovingent( "mus_dead_man_chest_01" );
    level waittill( "mortar_killstreak_end" );
    self stopsounds();
    wait 0.05;
    self.waketag playsoundonmovingent( "mus_dead_man_chest_02" );
}

shipvo()
{
    wait 7.5;
    thread shipvoplaylines();
    level waittill( "mortar_volleyFinished" );
    wait(randomfloatrange( 3.0, 3.5 ));
    thread shipvoplaylines();
}

shipvoplaylines()
{
    thread shipvoplayoneline( "mp_pirate_cpt_attack" );
    wait(randomfloatrange( 1.0, 1.5 ));

    if ( randomint( 2 ) == 0 )
    {
        thread shipvoplayoneline( "mp_pirate_prt1_attack" );
        wait(randomfloatrange( 0.5, 1.0 ));
        thread shipvoplayoneline( "mp_pirate_prt2_attack" );
    }
    else
    {
        thread shipvoplayoneline( "mp_pirate_prt2_attack" );
        wait(randomfloatrange( 0.5, 1.0 ));
        thread shipvoplayoneline( "mp_pirate_prt1_attack" );
    }
}

shipvoplayoneline( var_0, var_1 )
{
    var_2 = self.cannons[randomint( self.cannons.size )];
    var_2 playsoundonmovingent( var_0 );
}

bellssetup( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );

    if ( var_1.size <= 0 )
        return;

    common_scripts\utility::_ID3867( var_1, ::bellsdetecthit );
}

bellsdetecthit()
{
    self setcandamage( 1 );
    self._ID37541 = 0;
    var_0 = "pir_big_bell";

    if ( isdefined( self.script_noteworthy ) && maps\mp\_utility::_ID18801( self.script_noteworthy, "pir_bell_" ) )
        var_0 = self.script_noteworthy;

    for (;;)
    {
        self waittill( "damage",  var_1, var_2, var_3, var_4, var_5  );

        if ( !isdefined( var_2 ) || !isplayer( var_2 ) )
            continue;

        var_6 = var_2 getcurrentweapon();

        if ( var_5 == "MOD_IMPACT" || var_5 == "MOD_PROJECTILE" || var_5 == "MOD_PROJECTILE_SPLASH" || var_5 == "MOD_GRENADE" || var_5 == "MOD_GRENADE_SPLASH" || var_5 == "MOD_MELEE" || isdefined( var_6 ) && weaponclass( var_6 ) == "sniper" )
        {
            self playsound( var_0 );

            if ( !self._ID37541 )
                thread bellshitsway( var_2 );

            wait 0.5;
        }
    }
}

bellshitsway( var_0 )
{
    level endon( "game_ended" );
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

setupgrog( var_0 )
{
    level endon( "game_ended" );
    level._ID1644["pirate_test2"] = loadfx( "fx/fire/molotov_bottle_fire" );
    level waittill( "match_ending_soon",  var_1  );
    var_2 = maps\mp\gametypes\_gamelogic::gettimeremaining() * 0.001 - 30.0;

    if ( var_1 == "score" )
    {
        if ( maps\mp\_utility::_ID15434() <= 0 )
            var_2 = 60;
    }
    else
        var_2 = min( var_2, 30 );

    if ( var_2 > 0 )
        wait(var_2);

    var_3 = getent( var_0, "targetname" );

    if ( isdefined( var_3 ) )
    {
        var_4 = maps\mp\gametypes\_gameobjects::_ID8493( "neutral", var_3, [ var_3 ], ( 0, 0, 0 ) );
        var_4._ID17334 = "use";
        var_4 maps\mp\gametypes\_gameobjects::_ID29198( 4 );
        var_4 maps\mp\gametypes\_gameobjects::_ID29197( &"MP_PIRATE_GROG_USING" );
        var_4 maps\mp\gametypes\_gameobjects::_ID29196( &"MP_PIRATE_GROG_USE" );
        var_4 maps\mp\gametypes\_gameobjects::_ID29202( "any" );
        var_4 maps\mp\gametypes\_gameobjects::allowuse( "any" );
        var_4._ID22916 = ::grogonuse;
        var_4._ID22779 = ::grogonbeginuse;
        var_4._ID22816 = ::grogonenduse;
        var_4._ID38240 = 3;
    }
}

grogonuse( var_0 )
{
    if ( !isdefined( var_0.grogtriggered ) )
    {
        var_0 thread grogupdate();
        self._ID38240--;

        if ( self._ID38240 == 0 )
            grogmakeunusable();
    }
    else
        var_0 shellshock( "concussion_grenade_mp", 5 );
}

grogonbeginuse( var_0 )
{

}

grogonenduse( var_0, var_1, var_2 )
{
    if ( isplayer( var_1 ) )
        var_1 maps\mp\gametypes\_gameobjects::_ID34638( self, 0 );
}

grogmakeunusable()
{
    maps\mp\gametypes\_gameobjects::_ID10167();
    maps\mp\gametypes\_gameobjects::deleteuseobject();
}

grogwaitforuse()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger",  var_0  );
        var_0 thread grogupdate( self );
    }
}

grogupdate( var_0 )
{
    level endon( "game_ended" );
    self endon( "grogStop" );

    if ( isdefined( self.grogtriggered ) )
        return;

    self.grogtriggered = 1;

    if ( !maps\mp\_utility::_hasperk( "specialty_lightweight" ) )
    {
        self.grogperk = 1;
        maps\mp\_utility::_ID15611( "specialty_lightweight", 0 );
    }

    thread grogtimer( 20 );

    while ( isdefined( self ) && maps\mp\_utility::_ID18757( self ) )
    {
        var_1 = lengthsquared( self getvelocity() );

        if ( var_1 > 13225 )
        {
            if ( !isdefined( self.grogged ) )
            {
                self.grogged = 1;
                playfxontag( common_scripts\utility::_ID15033( "pirate_test2" ), self, "j_mainroot" );
            }
        }
        else if ( isdefined( self.grogged ) )
            grogstopfx();

        wait 0.25;
    }

    grogcleanup();
}

grogcleanup()
{
    if ( isdefined( self ) )
    {
        self.grogtriggered = undefined;

        if ( isdefined( self.grogperk ) )
        {
            self.grogperk = undefined;
            maps\mp\_utility::_unsetperk( "specialty_lightweight" );
        }

        grogstopfx();
    }
}

grogtimer( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    wait(var_0);
    self notify( "grogStop" );
    grogcleanup();
}

grogstopfx()
{
    self.grogged = undefined;
    stopfxontag( common_scripts\utility::_ID15033( "pirate_test2" ), self, "j_mainroot" );
}

setupconvos()
{
    level.convolocs = [ "convo_dock_3", "convo_dock_3", "convo_tavern_1", "convo_voodoo_1", "convo_brothel_1" ];
    level.convovos = [ "mp_pirate_vo_docked", "mp_pirate_vo_docked", "mp_pirate_vo_tavern", "mp_pirate_vo_voodoo", "mp_pirate_vo_brothel" ];
    level endon( "game_ended" );
    convoplayone( 60, 120 );
    convoplayone( 240, 360 );
    convoplayone( 240, 360 );
}

convoplayone( var_0, var_1 )
{
    var_2 = randomintrange( var_0, var_1 );
    wait(var_2);

    for ( var_3 = randomint( level.convolocs.size ); level.convolocs[var_3] == ""; var_3 = randomint( level.convolocs.size ) )
    {

    }

    var_4 = common_scripts\utility::_ID15384( level.convolocs[var_3], "targetname" );
    playsoundatpos( var_4.origin, level.convovos[var_3] );
    level.convolocs[var_3] = "";
}

jailvo()
{
    level endon( "game_ended" );
    var_0 = [ "mp_pirate_prs_jail_1", "mp_pirate_prs_jail_2", "mp_pirate_prs_jail_3", "mp_pirate_prs_jail_4", "mp_pirate_prs_jail_5" ];
    var_1 = common_scripts\utility::_ID15384( "convo_jail_1", "targetname" );
    var_2 = spawn( "script_origin", var_1.origin );

    for (;;)
    {
        var_3 = randomfloatrange( 120, 180 );
        wait(var_3);
        var_4 = randomint( var_0.size );
        var_2 playsound( var_0[var_4] );
    }
}
