// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level.ac130_use_duration = 40;
    angelflareprecache();
    level._ID1644["cloud"] = loadfx( "fx/misc/ac130_cloud" );
    level._ID1644["beacon"] = loadfx( "fx/misc/ir_beacon_coop" );
    level._ID1644["ac130_explode"] = loadfx( "fx/explosions/aerial_explosion_ac130_coop" );
    level._ID1644["ac130_flare"] = loadfx( "fx/misc/flares_cobra" );
    level._ID1644["ac130_light_red"] = loadfx( "fx/misc/aircraft_light_wingtip_red" );
    level._ID1644["ac130_light_white_blink"] = loadfx( "fx/misc/aircraft_light_white_blink" );
    level._ID1644["ac130_light_red_blink"] = loadfx( "fx/misc/aircraft_light_red_blink" );
    level._ID1644["ac130_engineeffect"] = loadfx( "fx/fire/jet_engine_ac130" );
    level._ID1644["coop_muzzleflash_105mm"] = loadfx( "fx/muzzleflashes/ac130_105mm" );
    level._ID1644["coop_muzzleflash_40mm"] = loadfx( "fx/muzzleflashes/ac130_40mm" );
    level.radioforcedtransmissionqueue = [];
    level.enemieskilledintimewindow = 0;
    level._ID19599 = gettime();
    level.color["white"] = ( 1, 1, 1 );
    level.color["red"] = ( 1, 0, 0 );
    level.color["blue"] = ( 0.1, 0.3, 1 );
    level.cosine = [];
    level.cosine["45"] = cos( 45 );
    level.cosine["5"] = cos( 5 );
    level._ID23528["ac130_25mm_mp"] = 60;
    level._ID23528["ac130_40mm_mp"] = 600;
    level._ID23528["ac130_105mm_mp"] = 1000;
    level._ID23527["ac130_25mm_mp"] = 0;
    level._ID23527["ac130_40mm_mp"] = 3.0;
    level._ID23527["ac130_105mm_mp"] = 6.0;
    level._ID36283["ac130_25mm_mp"] = 1.5;
    level._ID36283["ac130_40mm_mp"] = 3.0;
    level._ID36283["ac130_105mm_mp"] = 5.0;
    level.ac130_speed["move"] = 250;
    level.ac130_speed["rotate"] = 70;
    common_scripts\utility::_ID13189( "allow_context_sensative_dialog" );
    common_scripts\utility::flag_set( "allow_context_sensative_dialog" );
    var_0 = getentarray( "minimap_corner", "targetname" );
    var_1 = ( 0, 0, 0 );

    if ( var_0.size )
        var_1 = maps\mp\gametypes\_spawnlogic::findboxcenter( var_0[0].origin, var_0[1].origin );

    level.ac130 = spawn( "script_model", var_1 );
    level.ac130 setmodel( "c130_zoomRig" );
    level.ac130.angles = ( 0, 115, 0 );
    level.ac130.owner = undefined;
    level.ac130._ID32889 = "ac130_thermal_mp";
    level.ac130.enhanced_vision = "ac130_enhanced_mp";
    level.ac130.targetname = "ac130rig_script_model";
    level.ac130 hide();
    level.ac130inuse = 0;
    thread _ID26747( "on" );
    thread ac130_spawn();
    thread _ID22877();
    level._ID19256["ac130"] = ::_ID33830;
    level.ac130queue = [];
}

_ID33830( var_0, var_1 )
{
    if ( isdefined( level.ac130player ) || level.ac130inuse )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    if ( maps\mp\_utility::_ID18837() )
        return 0;

    if ( maps\mp\_utility::_ID18678() )
        return 0;

    maps\mp\_utility::_ID29199( "ac130" );
    var_2 = maps\mp\killstreaks\_killstreaks::_ID17993( var_1 );

    if ( var_2 != "success" )
    {
        if ( var_2 != "disconnect" )
            maps\mp\_utility::_ID7513();

        return 0;
    }

    var_2 = _ID28628( self );

    if ( isdefined( var_2 ) && var_2 )
    {
        level.ac130.planemodel._ID8221 = undefined;
        level.ac130inuse = 1;
    }
    else
        maps\mp\_utility::_ID7513();

    return isdefined( var_2 ) && var_2;
}

_ID17833()
{
    level._ID27382["foo"]["bar"] = "";
    add_context_sensative_dialog( "ai", "in_sight", 0, "ac130_fco_getthatguy" );
    add_context_sensative_dialog( "ai", "in_sight", 1, "ac130_fco_guymovin" );
    add_context_sensative_dialog( "ai", "in_sight", 2, "ac130_fco_getperson" );
    add_context_sensative_dialog( "ai", "in_sight", 3, "ac130_fco_guyrunnin" );
    add_context_sensative_dialog( "ai", "in_sight", 4, "ac130_fco_gotarunner" );
    add_context_sensative_dialog( "ai", "in_sight", 5, "ac130_fco_backonthose" );
    add_context_sensative_dialog( "ai", "in_sight", 6, "ac130_fco_gonnagethim" );
    add_context_sensative_dialog( "ai", "in_sight", 7, "ac130_fco_nailthoseguys" );
    add_context_sensative_dialog( "ai", "in_sight", 8, "ac130_fco_lightemup" );
    add_context_sensative_dialog( "ai", "in_sight", 9, "ac130_fco_takehimout" );
    add_context_sensative_dialog( "ai", "in_sight", 10, "ac130_plt_yeahcleared" );
    add_context_sensative_dialog( "ai", "in_sight", 11, "ac130_plt_copysmoke" );
    add_context_sensative_dialog( "ai", "wounded_crawl", 0, "ac130_fco_movingagain" );
    add_context_sensative_timeout( "ai", "wounded_crawl", undefined, 6 );
    add_context_sensative_dialog( "ai", "wounded_pain", 0, "ac130_fco_doveonground" );
    add_context_sensative_dialog( "ai", "wounded_pain", 1, "ac130_fco_knockedwind" );
    add_context_sensative_dialog( "ai", "wounded_pain", 2, "ac130_fco_downstillmoving" );
    add_context_sensative_dialog( "ai", "wounded_pain", 3, "ac130_fco_gettinbackup" );
    add_context_sensative_dialog( "ai", "wounded_pain", 4, "ac130_fco_yepstillmoving" );
    add_context_sensative_dialog( "ai", "wounded_pain", 5, "ac130_fco_stillmoving" );
    add_context_sensative_timeout( "ai", "wounded_pain", undefined, 12 );
    add_context_sensative_dialog( "weapons", "105mm_ready", 0, "ac130_gnr_gunready1" );
    add_context_sensative_dialog( "weapons", "105mm_fired", 0, "ac130_gnr_shot1" );
    add_context_sensative_dialog( "plane", "rolling_in", 0, "ac130_plt_rollinin" );
    add_context_sensative_dialog( "explosion", "secondary", 0, "ac130_nav_secondaries1" );
    add_context_sensative_timeout( "explosion", "secondary", undefined, 7 );
    add_context_sensative_dialog( "kill", "single", 0, "ac130_plt_gottahurt" );
    add_context_sensative_dialog( "kill", "single", 1, "ac130_fco_iseepieces" );
    add_context_sensative_dialog( "kill", "single", 2, "ac130_fco_oopsiedaisy" );
    add_context_sensative_dialog( "kill", "single", 3, "ac130_fco_goodkill" );
    add_context_sensative_dialog( "kill", "single", 4, "ac130_fco_yougothim" );
    add_context_sensative_dialog( "kill", "single", 5, "ac130_fco_yougothim2" );
    add_context_sensative_dialog( "kill", "single", 6, "ac130_fco_thatsahit" );
    add_context_sensative_dialog( "kill", "single", 7, "ac130_fco_directhit" );
    add_context_sensative_dialog( "kill", "single", 8, "ac130_fco_rightontarget" );
    add_context_sensative_dialog( "kill", "single", 9, "ac130_fco_okyougothim" );
    add_context_sensative_dialog( "kill", "single", 10, "ac130_fco_within2feet" );
    add_context_sensative_dialog( "kill", "small_group", 0, "ac130_fco_nice" );
    add_context_sensative_dialog( "kill", "small_group", 1, "ac130_fco_directhits" );
    add_context_sensative_dialog( "kill", "small_group", 2, "ac130_fco_iseepieces" );
    add_context_sensative_dialog( "kill", "small_group", 3, "ac130_fco_goodkill" );
    add_context_sensative_dialog( "kill", "small_group", 4, "ac130_fco_yougothim" );
    add_context_sensative_dialog( "kill", "small_group", 5, "ac130_fco_yougothim2" );
    add_context_sensative_dialog( "kill", "small_group", 6, "ac130_fco_thatsahit" );
    add_context_sensative_dialog( "kill", "small_group", 7, "ac130_fco_directhit" );
    add_context_sensative_dialog( "kill", "small_group", 8, "ac130_fco_rightontarget" );
    add_context_sensative_dialog( "kill", "small_group", 9, "ac130_fco_okyougothim" );
    add_context_sensative_dialog( "misc", "action", 0, "ac130_fco_tracking" );
    add_context_sensative_timeout( "misc", "action", 0, 70 );
    add_context_sensative_dialog( "misc", "action", 1, "ac130_fco_moreenemy" );
    add_context_sensative_timeout( "misc", "action", 1, 80 );
    add_context_sensative_dialog( "misc", "action", 2, "ac130_random" );
    add_context_sensative_timeout( "misc", "action", 2, 55 );
    add_context_sensative_dialog( "misc", "action", 3, "ac130_fco_rightthere" );
    add_context_sensative_timeout( "misc", "action", 3, 100 );
}

add_context_sensative_dialog( var_0, var_1, var_2, var_3 )
{
    var_4 = maps\mp\gametypes\_teams::getteamvoiceprefix( "allies" ) + var_3;
    var_4 = maps\mp\gametypes\_teams::getteamvoiceprefix( "axis" ) + var_3;

    if ( !isdefined( level._ID27382[var_0] ) || !isdefined( level._ID27382[var_0][var_1] ) || !isdefined( level._ID27382[var_0][var_1][var_2] ) )
    {
        level._ID27382[var_0][var_1][var_2] = spawnstruct();
        level._ID27382[var_0][var_1][var_2]._ID23901 = 0;
        level._ID27382[var_0][var_1][var_2].sounds = [];
    }

    var_5 = level._ID27382[var_0][var_1][var_2].sounds.size;
    level._ID27382[var_0][var_1][var_2].sounds[var_5] = var_3;
}

add_context_sensative_timeout( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( level._ID7909 ) )
        level._ID7909 = [];

    var_4 = 0;

    if ( !isdefined( level._ID7909[var_0] ) )
        var_4 = 1;
    else if ( !isdefined( level._ID7909[var_0][var_1] ) )
        var_4 = 1;

    if ( var_4 )
        level._ID7909[var_0][var_1] = spawnstruct();

    if ( isdefined( var_2 ) )
    {
        level._ID7909[var_0][var_1]._ID15839 = [];
        level._ID7909[var_0][var_1]._ID15839[_ID31965( var_2 )] = spawnstruct();
        level._ID7909[var_0][var_1]._ID15839[_ID31965( var_2 )]._ID34830["timeoutDuration"] = var_3 * 1000;
        level._ID7909[var_0][var_1]._ID15839[_ID31965( var_2 )]._ID34830["lastPlayed"] = var_3 * -1000;
    }
    else
    {
        level._ID7909[var_0][var_1]._ID34830["timeoutDuration"] = var_3 * 1000;
        level._ID7909[var_0][var_1]._ID34830["lastPlayed"] = var_3 * -1000;
    }
}

_ID23843( var_0 )
{
    maps\mp\_utility::_ID23845( var_0 );
}

array_remove_nokeys( var_0, var_1 )
{
    var_2 = [];

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        if ( var_0[var_3] != var_1 )
            var_2[var_2.size] = var_0[var_3];
    }

    return var_2;
}

_ID3839( var_0, var_1 )
{
    var_2 = [];
    var_3 = getarraykeys( var_0 );

    for ( var_4 = var_3.size - 1; var_4 >= 0; var_4-- )
    {
        if ( var_3[var_4] != var_1 )
            var_2[var_2.size] = var_0[var_3[var_4]];
    }

    return var_2;
}

_ID31965( var_0 )
{
    return "" + var_0;
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
        self waittill( "spawned_player" );
}

deleteonac130playerremoved()
{
    level waittill( "ac130player_removed" );
    self delete();
}

monitormanualplayerexit()
{
    level endon( "game_ended" );
    level endon( "ac130player_removed" );
    self endon( "disconnect" );
    level.ac130 thread maps\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit();
    level.ac130 waittill( "killstreakExit" );

    if ( isdefined( level.ac130.owner ) )
        level thread _ID25963( level.ac130.owner, 0 );
}

_ID28628( var_0 )
{
    self endon( "ac130player_removed" );

    if ( isdefined( level.ac130player ) )
        return 0;

    _ID17833();
    var_0 setclientomnvar( "enableCustomAudioZone", 1 );
    level.ac130player = var_0;
    level.ac130.owner = var_0;
    level.ac130.planemodel show();
    level.ac130.planemodel thread _ID23869();
    level.ac130._ID17526 = 0;
    level.ac130.planemodel playloopsound( "veh_ac130iw6_ext_dist" );
    level.ac130.planemodel thread _ID8985();
    thread handleincomingmissiles();
    level.ac130.planemodel thermaldrawenable();
    var_1 = spawnplane( var_0, "script_model", level.ac130.planemodel.origin, "compass_objpoint_c130_friendly", "compass_objpoint_c130_enemy" );
    var_1 notsolid();
    var_1 linkto( level.ac130, "tag_player", ( 0, 80, 32 ), ( 0, -90, 0 ) );
    var_1 thread deleteonac130playerremoved();
    thread maps\mp\_utility::_ID32672( "used_ac130", var_0 );
    var_0 thread _ID35606( 1.0 );
    var_0 thread maps\mp\_utility::_ID25727( level.ac130.planemodel );

    if ( getdvarint( "camera_thirdPerson" ) )
        var_0 maps\mp\_utility::_ID28902( 0 );

    var_0 maps\mp\_utility::_giveweapon( "ac130_105mm_mp" );
    var_0 maps\mp\_utility::_giveweapon( "ac130_40mm_mp" );
    var_0 maps\mp\_utility::_giveweapon( "ac130_25mm_mp" );
    var_0 switchtoweapon( "ac130_105mm_mp" );
    var_0 thread _ID25964( level.ac130_use_duration * var_0._ID19266 );
    var_0 setclientomnvar( "ui_ac130_hud", 1 );
    var_0 thread _ID23152();
    var_0 setblurforplayer( 1.2, 0 );
    var_0 thread attachplayer( var_0 );
    var_0 thread _ID6882();
    var_0 thread _ID36262();
    var_0 thread _ID7895();
    var_0 thread _ID29787();
    var_0 thread clouds();

    if ( isbot( self ) )
    {
        self.vehicle_controlling = level.ac130;
        var_0 thread ac130_control_bot_aiming();
    }

    var_0 thread watchhostmigrationfinishedinit();
    var_0 thread _ID25968();
    var_0 thread _ID25965();
    var_0 thread _ID25971();
    var_0 thread _ID25966();
    var_0 thread _ID25969();
    var_0 thread monitormanualplayerexit();
    thread ac130_altscene();
    return 1;
}

initac130hud()
{
    self setclientomnvar( "ui_ac130_hud", 1 );
    common_scripts\utility::_ID35582();
    self switchtoweapon( "ac130_105mm_mp" );
    common_scripts\utility::_ID35582();
    self setclientomnvar( "ui_ac130_weapon", 0 );
    common_scripts\utility::_ID35582();
    self setclientomnvar( "ui_ac130_105mm_ammo", self getweaponammoclip( "ac130_105mm_mp" ) );
    common_scripts\utility::_ID35582();
    self setclientomnvar( "ui_ac130_40mm_ammo", self getweaponammoclip( "ac130_40mm_mp" ) );
    common_scripts\utility::_ID35582();
    self setclientomnvar( "ui_ac130_25mm_ammo", self getweaponammoclip( "ac130_25mm_mp" ) );
    common_scripts\utility::_ID35582();
    thread _ID23152();
    self setclientomnvar( "enableCustomAudioZone", 1 );
}

watchhostmigrationfinishedinit()
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    level endon( "game_ended" );
    self endon( "death" );

    for (;;)
    {
        level waittill( "host_migration_end" );
        initac130hud();
    }
}

_ID35606( var_0 )
{
    self endon( "disconnect" );
    level endon( "ac130player_removed" );
    wait(var_0);
    self visionsetthermalforplayer( game["thermal_vision"], 0 );
    self thermalvisionfofoverlayon();
    thread _ID32891();
}

_ID23869()
{
    wait 0.05;
    playfxontag( level._ID1644["ac130_light_red_blink"], self, "tag_light_belly" );
    playfxontag( level._ID1644["ac130_engineeffect"], self, "tag_body" );
    wait 0.5;
    playfxontag( level._ID1644["ac130_light_white_blink"], self, "tag_light_tail" );
    playfxontag( level._ID1644["ac130_light_red"], self, "tag_light_top" );
    wait 0.5;
    playfxontag( level.fx_airstrike_contrail, self, "tag_light_L_wing" );
    playfxontag( level.fx_airstrike_contrail, self, "tag_light_R_wing" );
}

ac130_altscene()
{
    foreach ( var_1 in level.players )
    {
        if ( var_1 != level.ac130player && var_1.team == level.ac130player.team )
            var_1 thread maps\mp\_utility::_ID28636( level.ac130.cameramodel, "tag_origin", 20 );
    }
}

removeac130playerongameend()
{
    self endon( "ac130player_removed" );
    level waittill( "game_ended" );
    level thread _ID25963( self, 0 );
}

_ID25969()
{
    self endon( "ac130player_removed" );
    level waittill( "game_cleanup" );
    level thread _ID25963( self, 0 );
}

_ID25967()
{
    self endon( "ac130player_removed" );
    self waittill( "death" );
    level thread _ID25963( self, 0 );
}

_ID25966()
{
    self endon( "ac130player_removed" );
    level.ac130.planemodel waittill( "crashing" );
    level thread _ID25963( self, 0 );
}

_ID25968()
{
    self endon( "ac130player_removed" );
    self waittill( "disconnect" );
    level thread _ID25963( self, 1 );
}

_ID25965()
{
    self endon( "ac130player_removed" );
    self waittill( "joined_team" );
    level thread _ID25963( self, 0 );
}

_ID25971()
{
    self endon( "ac130player_removed" );
    common_scripts\utility::_ID35626( "joined_spectators", "spawned" );
    level thread _ID25963( self, 0 );
}

_ID25964( var_0 )
{
    self endon( "ac130player_removed" );
    var_1 = var_0;
    self setclientomnvar( "ui_ac130_use_time", var_1 * 1000 + gettime() );
    maps\mp\gametypes\_hostmigration::_ID35597( var_1 );
    self setclientomnvar( "ui_ac130_use_time", 0 );
    level thread _ID25963( self, 0 );
}

_ID25963( var_0, var_1 )
{
    var_0 notify( "ac130player_removed" );
    level notify( "ac130player_removed" );
    level.ac130.cameramodel notify( "death" );
    waittillframeend;

    if ( !var_1 )
    {
        var_0 maps\mp\_utility::_ID7513();
        var_0 stoplocalsound( "missile_incoming" );
        var_0 stoploopsound();
        var_0 show();
        var_0 unlink();

        if ( isbot( var_0 ) )
        {
            var_0 controlsunlink();
            var_0 cameraunlink();
            var_0.vehicle_controlling = undefined;
        }

        var_0 thermalvisionoff();
        var_0 thermalvisionfofoverlayoff();
        var_0 visionsetthermalforplayer( level.ac130._ID32889, 0 );
        var_0.lastvisionsetthermal = level.ac130._ID32889;
        var_0 setblurforplayer( 0, 0 );

        if ( getdvarint( "camera_thirdPerson" ) )
            var_0 maps\mp\_utility::_ID28902( 1 );

        var_2 = maps\mp\_utility::getkillstreakweapon( "ac130" );
        var_0 takeweapon( var_2 );
        var_0 takeweapon( "ac130_105mm_mp" );
        var_0 takeweapon( "ac130_40mm_mp" );
        var_0 takeweapon( "ac130_25mm_mp" );
        var_0 setclientomnvar( "ui_ac130_hud", 0 );
        var_0 setclientomnvar( "enableCustomAudioZone", 0 );
    }

    removefromlittlebirdlist();
    wait 0.5;
    level.ac130.planemodel playsound( "veh_ac130iw6_ext_dist_fade" );
    wait 0.5;
    level.ac130player = undefined;
    level.ac130.planemodel hide();
    level.ac130.planemodel stoploopsound();

    if ( isdefined( level.ac130.planemodel._ID8221 ) )
    {
        level.ac130inuse = 0;
        return;
    }

    var_3 = spawn( "script_model", level.ac130.planemodel gettagorigin( "tag_origin" ) );
    var_3.angles = level.ac130.planemodel.angles;
    var_3 setmodel( "vehicle_y_8_gunship_mp" );
    var_4 = var_3.origin + anglestoright( var_3.angles ) * 20000;
    var_4 += ( 0, 0, 10000 );
    var_3 thread _ID23869();
    var_3 moveto( var_4, 40.0, 0.0, 0.0 );
    var_5 = ( 0, var_3.angles[1], -20 );
    var_3 rotateto( var_5, 30, 1, 1 );
    var_3 thread _ID9665( 1 );
    wait 5.0;
    var_3 thread _ID9665( 1 );
    wait 5.0;
    var_3 thread _ID9665( 1 );
    level.ac130inuse = 0;
    wait 30.0;
    var_3 delete();
}

removefromlittlebirdlist()
{
    var_0 = level.ac130.planemodel getentitynumber();
    level._ID20086[var_0] = undefined;
}

_ID8985()
{
    self endon( "death" );
    self endon( "crashing" );
    level endon( "game_ended" );
    level endon( "ac130player_removed" );
    self.health = 999999;
    self.maxhealth = 1000;
    self.damagetaken = 0;
    self.team = level.ac130player.team;
    maps\mp\killstreaks\_helicopter::addtolittlebirdlist();
    self.attractor = missile_createattractorent( self, 1000, 4096 );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( isdefined( level.ac130player ) && level._ID32653 && isplayer( var_1 ) && var_1.team == level.ac130player.team && !isdefined( level.nukedetonated ) )
            continue;

        if ( var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_EXPLOSIVE_BULLET" )
            continue;

        self._ID35908 = 1;
        var_10 = var_0;

        if ( isplayer( var_1 ) )
            var_1 maps\mp\gametypes\_damagefeedback::_ID34528( "ac130" );

        maps\mp\killstreaks\_killstreaks::_ID19257( var_1, var_9, level.ac130 );

        if ( isdefined( var_1.owner ) && isplayer( var_1.owner ) )
            var_1.owner maps\mp\gametypes\_damagefeedback::_ID34528( "ac130" );

        self.damagetaken = self.damagetaken + var_10;

        if ( self.damagetaken >= self.maxhealth )
        {
            if ( isplayer( var_1 ) )
            {
                thread maps\mp\gametypes\_missions::vehiclekilled( level.ac130player, self, undefined, var_1, var_0, var_4, var_9 );
                thread maps\mp\_utility::_ID32672( "callout_destroyed_ac130", var_1 );
                var_1 thread maps\mp\gametypes\_rank::giverankxp( "kill", 400, var_9, var_4 );
                var_1 notify( "destroyed_killstreak" );
            }

            level thread crashplane( 10.0 );
        }
    }
}

ac130_spawn()
{
    wait 0.05;
    var_0 = spawn( "script_model", level.ac130 gettagorigin( "tag_player" ) );
    var_0 setmodel( "vehicle_y_8_gunship_mp" );
    var_0.targetname = "vehicle_y_8_gunship_mp";
    var_0 setcandamage( 1 );
    var_0.maxhealth = 1000;
    var_0.health = var_0.maxhealth;
    var_0 linkto( level.ac130, "tag_player", ( 0, 80, 32 ), ( -25, 0, 0 ) );
    level.ac130.planemodel = var_0;
    level.ac130.planemodel hide();
    var_1 = spawn( "script_model", level.ac130 gettagorigin( "tag_player" ) );
    var_1 setmodel( "tag_origin" );
    var_1 hide();
    var_1.targetname = "ac130CameraModel";
    var_1 linkto( level.ac130, "tag_player", ( 0, 0, 32 ), ( 5, 0, 0 ) );
    level.ac130.cameramodel = var_1;
}

_ID23152()
{
    self endon( "ac130player_removed" );
    wait 0.05;
    thread _ID34575();
    thread _ID34501();
}

_ID34575()
{
    self endon( "ac130player_removed" );

    for (;;)
    {
        self setclientomnvar( "ui_ac130_coord1_posx", abs( level.ac130.planemodel.origin[0] ) );
        self setclientomnvar( "ui_ac130_coord1_posy", abs( level.ac130.planemodel.origin[1] ) );
        self setclientomnvar( "ui_ac130_coord1_posz", abs( level.ac130.planemodel.origin[2] ) );
        wait 0.5;
    }
}

_ID34577()
{
    self endon( "ac130player_removed" );
    common_scripts\utility::_ID35582();
    self setclientomnvar( "ui_ac130_coord2_posx", abs( self.origin[0] ) );
    self setclientomnvar( "ui_ac130_coord2_posy", abs( self.origin[1] ) );
    self setclientomnvar( "ui_ac130_coord2_posz", abs( self.origin[2] ) );
}

_ID34501()
{
    self endon( "ac130player_removed" );

    for (;;)
    {
        var_0 = self geteye();
        var_1 = self getplayerangles();
        var_2 = anglestoforward( var_1 );
        var_3 = var_0 + var_2 * 15000;
        var_4 = physicstrace( var_0, var_3 );
        self setclientomnvar( "ui_ac130_coord3_posx", abs( var_4[0] ) );
        self setclientomnvar( "ui_ac130_coord3_posy", abs( var_4[1] ) );
        self setclientomnvar( "ui_ac130_coord3_posz", abs( var_4[2] ) );
        wait 0.1;
    }
}

ac130shellshock()
{
    self endon( "ac130player_removed" );
    level endon( "post_effects_disabled" );
    var_0 = 5;

    for (;;)
    {
        self shellshock( "ac130", var_0 );
        wait(var_0);
    }
}

_ID26747( var_0 )
{
    level notify( "stop_rotatePlane_thread" );
    level endon( "stop_rotatePlane_thread" );

    if ( var_0 == "on" )
    {
        var_1 = 10;
        var_2 = level.ac130_speed["rotate"] / 360 * var_1;
        level.ac130 rotateyaw( level.ac130.angles[2] + var_1, var_2, var_2, 0 );

        for (;;)
        {
            level.ac130 rotateyaw( 360, level.ac130_speed["rotate"] );
            wait(level.ac130_speed["rotate"]);
        }
    }
    else if ( var_0 == "off" )
    {
        var_3 = 10;
        var_2 = level.ac130_speed["rotate"] / 360 * var_3;
        level.ac130 rotateyaw( level.ac130.angles[2] + var_3, var_2, 0, var_2 );
    }
}

attachplayer( var_0 )
{
    if ( isbot( var_0 ) )
        var_0 cameralinkto( level.ac130, "tag_player" );

    self playerlinkweaponviewtodelta( level.ac130.cameramodel, "tag_player", 1.0, 35, 35, 35, 35 );
    self setplayerangles( level.ac130 gettagangles( "tag_player" ) );
}

_ID6882()
{
    self endon( "ac130player_removed" );
    wait 0.05;
    self enableweapons();
    self enableweaponswitch();
    common_scripts\utility::_ID35582();
    self setclientomnvar( "ui_ac130_105mm_ammo", self getweaponammoclip( "ac130_105mm_mp" ) );
    common_scripts\utility::_ID35582();
    self setclientomnvar( "ui_ac130_40mm_ammo", self getweaponammoclip( "ac130_40mm_mp" ) );
    common_scripts\utility::_ID35582();
    self setclientomnvar( "ui_ac130_25mm_ammo", self getweaponammoclip( "ac130_25mm_mp" ) );

    for (;;)
    {
        self waittill( "weapon_change",  var_0  );
        thread _ID23843( "ac130iw6_weapon_switch" );
        self notify( "reset_25mm" );
        self stoploopsound( "ac130iw6_25mm_fire_loop" );

        switch ( var_0 )
        {
            case "ac130_105mm_mp":
                self setclientomnvar( "ui_ac130_weapon", 0 );
                continue;
            case "ac130_40mm_mp":
                self setclientomnvar( "ui_ac130_weapon", 1 );
                continue;
            case "ac130_25mm_mp":
                self setclientomnvar( "ui_ac130_weapon", 2 );
                thread playsound25mm();
                continue;
        }
    }
}

_ID36262()
{
    self endon( "ac130player_removed" );

    for (;;)
    {
        self waittill( "weapon_fired" );
        var_0 = self getcurrentweapon();

        switch ( var_0 )
        {
            case "ac130_105mm_mp":
                thread _ID15857();
                earthquake( 0.2, 1, level.ac130.planemodel.origin, 1000 );
                self setclientomnvar( "ui_ac130_105mm_ammo", self getweaponammoclip( var_0 ) );
                break;
            case "ac130_40mm_mp":
                earthquake( 0.1, 0.5, level.ac130.planemodel.origin, 1000 );
                self setclientomnvar( "ui_ac130_40mm_ammo", self getweaponammoclip( var_0 ) );
                break;
            case "ac130_25mm_mp":
                self setclientomnvar( "ui_ac130_25mm_ammo", self getweaponammoclip( var_0 ) );
                break;
        }

        if ( self getweaponammoclip( var_0 ) )
            continue;

        thread _ID36282( var_0 );
    }
}

_ID36282( var_0 )
{
    self endon( "ac130player_removed" );
    wait(level._ID36283[var_0]);
    self setweaponammoclip( var_0, 9999 );

    switch ( var_0 )
    {
        case "ac130_105mm_mp":
            self setclientomnvar( "ui_ac130_105mm_ammo", self getweaponammoclip( var_0 ) );
            break;
        case "ac130_40mm_mp":
            self setclientomnvar( "ui_ac130_40mm_ammo", self getweaponammoclip( var_0 ) );
            break;
        case "ac130_25mm_mp":
            self setclientomnvar( "ui_ac130_25mm_ammo", self getweaponammoclip( var_0 ) );
            break;
    }

    if ( self getcurrentweapon() == var_0 )
    {
        self takeweapon( var_0 );
        maps\mp\_utility::_giveweapon( var_0 );
        self switchtoweapon( var_0 );
    }
}

playsound25mm()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "ac130player_removed" );
    self endon( "reset_25mm" );
    var_0 = self getcurrentweapon();

    for (;;)
    {
        self waittill( "weapon_fired" );
        self stoplocalsound( "ac130iw6_25mm_fire_loop_cooldown" );
        self playloopsound( "ac130iw6_25mm_fire_loop" );

        while ( self attackbuttonpressed() && self getweaponammoclip( var_0 ) )
            wait 0.05;

        self stoploopsound();
        self playlocalsound( "ac130iw6_25mm_fire_loop_cooldown" );
    }
}

ac130_control_bot_aiming()
{
    self endon( "ac130player_removed" );
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = 0;
    var_4 = 0;
    var_5 = undefined;
    var_6 = ( self botgetdifficultysetting( "minInaccuracy" ) + self botgetdifficultysetting( "maxInaccuracy" ) ) / 2;
    var_7 = 0;

    for (;;)
    {
        var_8 = 0;
        var_9 = 0;

        if ( isdefined( var_1 ) && var_1.health <= 0 && gettime() - var_1._ID9101 < 2000 )
        {
            var_8 = 1;
            var_9 = 1;
        }
        else if ( isalive( self.enemy ) && ( self botcanseeentity( self.enemy ) || gettime() - self lastknowntime( self.enemy ) <= 300 ) )
        {
            var_8 = 1;
            var_1 = self.enemy;
            var_10 = var_1.origin;
            var_0 = self.enemy.origin;

            if ( self botcanseeentity( self.enemy ) )
            {
                var_7 = 0;
                var_9 = 1;
                var_11 = gettime();
            }
            else
            {
                var_7 += 0.05;

                if ( var_7 > 5.0 )
                    var_8 = 0;
            }
        }

        if ( var_8 )
        {
            if ( isdefined( var_0 ) )
                var_2 = var_0;

            if ( var_9 && ( maps\mp\bots\_bots_ks_remote_vehicle::bot_body_is_dead() || distancesquared( var_2, level.ac130.origin ) > level._ID23528["ac130_105mm_mp"] * level._ID23528["ac130_105mm_mp"] ) )
                self botpressbutton( "attack" );

            if ( gettime() > var_4 + 500 )
            {
                var_12 = randomfloatrange( -1 * var_6 / 2, var_6 / 2 );
                var_13 = randomfloatrange( -1 * var_6 / 2, var_6 / 2 );
                var_14 = randomfloatrange( -1 * var_6 / 2, var_6 / 2 );
                var_5 = ( 150 * var_12, 150 * var_13, 150 * var_14 );
                var_4 = gettime();
            }

            var_2 += var_5;
        }
        else if ( gettime() > var_3 )
        {
            var_3 = gettime() + randomintrange( 1000, 2000 );
            var_2 = maps\mp\bots\_bots_ks_remote_vehicle::_ID14710();
        }

        self botlookatpoint( var_2, 0.2, "script_forced" );
        wait 0.05;
    }
}

_ID32891()
{
    self endon( "ac130player_removed" );
    self thermalvisionon();
    self visionsetthermalforplayer( level.ac130.enhanced_vision, 1 );
    self.lastvisionsetthermal = level.ac130.enhanced_vision;
    self visionsetthermalforplayer( level.ac130._ID32889, 0.62 );
    self.lastvisionsetthermal = level.ac130._ID32889;
    self setclientdvar( "ui_ac130_thermal", 1 );
}

clouds()
{
    self endon( "ac130player_removed" );
    wait 6;
    _ID7586();

    for (;;)
    {
        wait(randomfloatrange( 40, 80 ));
        _ID7586();
    }
}

_ID7586()
{
    if ( isdefined( level._ID24574 ) && issubstr( tolower( level._ID24574 ), "25" ) )
        return;

    playfxontagforclients( level._ID1644["cloud"], level.ac130, "tag_player", level.ac130player );
}

_ID15857()
{
    self endon( "ac130player_removed" );
    level notify( "gun_fired_and_ready_105mm" );
    level endon( "gun_fired_and_ready_105mm" );
    wait 0.5;

    if ( randomint( 2 ) == 0 )
        thread context_sensative_dialog_play_random_group_sound( "weapons", "105mm_fired" );

    wait 5.0;
    thread context_sensative_dialog_play_random_group_sound( "weapons", "105mm_ready" );
}

_ID29787()
{
    self endon( "ac130player_removed" );

    for (;;)
    {
        self waittill( "projectile_impact",  var_0, var_1, var_2  );

        if ( issubstr( tolower( var_0 ), "105" ) )
        {
            earthquake( 0.4, 1.0, var_1, 3500 );
            self setclientomnvar( "ui_ac130_darken", 1 );
        }
        else if ( issubstr( tolower( var_0 ), "40" ) )
            earthquake( 0.2, 0.5, var_1, 2000 );

        if ( maps\mp\_utility::_ID15069( "ac130_ragdoll_deaths", 0 ) )
            thread _ID29788( var_1, var_0 );

        wait 0.05;
    }
}

_ID29788( var_0, var_1 )
{
    wait 0.1;
    physicsexplosionsphere( var_0, level._ID23528[var_1], level._ID23528[var_1] / 2, level._ID23527[var_1] );
}

add_beacon_effect()
{
    self endon( "death" );
    var_0 = 0.75;
    wait(randomfloat( 3.0 ));

    for (;;)
    {
        if ( level.ac130player )
            playfxontagforclients( level._ID1644["beacon"], self, "j_spine4", level.ac130player );

        wait(var_0);
    }
}

_ID7895()
{
    thread _ID11952();
    thread context_sensative_dialog_guy_in_sight();
    thread _ID7897();
    thread _ID7900();
    thread context_sensative_dialog_secondary_explosion_vehicle();
    thread context_sensative_dialog_kill_thread();
    thread context_sensative_dialog_locations();
    thread context_sensative_dialog_filler();
}

context_sensative_dialog_guy_in_sight()
{
    self endon( "ac130player_removed" );

    for (;;)
    {
        if ( context_sensative_dialog_guy_in_sight_check() )
            thread context_sensative_dialog_play_random_group_sound( "ai", "in_sight" );

        wait(randomfloatrange( 1, 3 ));
    }
}

context_sensative_dialog_guy_in_sight_check()
{
    var_0 = [];

    foreach ( var_2 in level.players )
    {
        if ( !maps\mp\_utility::_ID18757( var_2 ) )
            continue;

        if ( var_2.team == level.ac130player.team )
            continue;

        if ( var_2.team == "spectator" )
            continue;

        var_0[var_0.size] = var_2;
    }

    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        if ( !isdefined( var_0[var_4] ) )
            continue;

        if ( !isalive( var_0[var_4] ) )
            continue;

        if ( common_scripts\utility::_ID36376( level.ac130player geteye(), level.ac130player getplayerangles(), var_0[var_4].origin, level.cosine["5"] ) )
            return 1;

        wait 0.05;
    }

    return 0;
}

_ID7897()
{
    self endon( "ac130player_removed" );

    for (;;)
    {
        level waittill( "ai_crawling",  var_0  );
        thread context_sensative_dialog_play_random_group_sound( "ai", "wounded_crawl" );
    }
}

_ID7900()
{
    self endon( "ac130player_removed" );

    for (;;)
    {
        level waittill( "ai_pain",  var_0  );
        thread context_sensative_dialog_play_random_group_sound( "ai", "wounded_pain" );
    }
}

context_sensative_dialog_secondary_explosion_vehicle()
{
    self endon( "ac130player_removed" );

    for (;;)
    {
        level waittill( "player_destroyed_car",  var_0, var_1  );
        wait 1;
        thread context_sensative_dialog_play_random_group_sound( "explosion", "secondary" );
    }
}

_ID11952()
{
    self endon( "ac130player_removed" );

    for (;;)
    {
        level waittill( "ai_killed",  var_0  );
        thread context_sensative_dialog_kill( var_0, level.ac130player );
    }
}

context_sensative_dialog_kill( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        return;

    if ( !isplayer( var_1 ) )
        return;

    level.enemieskilledintimewindow++;
    level notify( "enemy_killed" );
}

context_sensative_dialog_kill_thread()
{
    self endon( "ac130player_removed" );
    var_0 = 1;

    for (;;)
    {
        level waittill( "enemy_killed" );
        wait(var_0);
        var_1 = "kill";
        var_2 = undefined;

        if ( level.enemieskilledintimewindow >= 2 )
            var_2 = "small_group";
        else
        {
            var_2 = "single";

            if ( randomint( 3 ) != 1 )
            {
                level.enemieskilledintimewindow = 0;
                continue;
            }
        }

        level.enemieskilledintimewindow = 0;
        thread context_sensative_dialog_play_random_group_sound( var_1, var_2, 1 );
    }
}

context_sensative_dialog_locations()
{
    common_scripts\utility::_ID3867( getentarray( "context_dialog_car", "targetname" ), ::context_sensative_dialog_locations_add_notify_event, "car" );
    common_scripts\utility::_ID3867( getentarray( "context_dialog_truck", "targetname" ), ::context_sensative_dialog_locations_add_notify_event, "truck" );
    common_scripts\utility::_ID3867( getentarray( "context_dialog_building", "targetname" ), ::context_sensative_dialog_locations_add_notify_event, "building" );
    common_scripts\utility::_ID3867( getentarray( "context_dialog_wall", "targetname" ), ::context_sensative_dialog_locations_add_notify_event, "wall" );
    common_scripts\utility::_ID3867( getentarray( "context_dialog_field", "targetname" ), ::context_sensative_dialog_locations_add_notify_event, "field" );
    common_scripts\utility::_ID3867( getentarray( "context_dialog_road", "targetname" ), ::context_sensative_dialog_locations_add_notify_event, "road" );
    common_scripts\utility::_ID3867( getentarray( "context_dialog_church", "targetname" ), ::context_sensative_dialog_locations_add_notify_event, "church" );
    common_scripts\utility::_ID3867( getentarray( "context_dialog_ditch", "targetname" ), ::context_sensative_dialog_locations_add_notify_event, "ditch" );
    thread context_sensative_dialog_locations_thread();
}

context_sensative_dialog_locations_thread()
{
    self endon( "ac130player_removed" );

    for (;;)
    {
        level waittill( "context_location",  var_0  );

        if ( !isdefined( var_0 ) )
            continue;

        if ( !common_scripts\utility::_ID13177( "allow_context_sensative_dialog" ) )
            continue;

        thread context_sensative_dialog_play_random_group_sound( "location", var_0 );
        wait(5 + randomfloat( 10 ));
    }
}

context_sensative_dialog_locations_add_notify_event( var_0 )
{
    self endon( "ac130player_removed" );

    for (;;)
    {
        self waittill( "trigger",  var_1  );

        if ( !isdefined( var_1 ) )
            continue;

        if ( !isdefined( var_1.team ) || var_1.team != "axis" )
            continue;

        level notify( "context_location",  var_0  );
        wait 5;
    }
}

context_sensative_dialog_vehiclespawn( var_0 )
{
    if ( var_0._ID27857 != "axis" )
        return;

    thread context_sensative_dialog_vehicledeath( var_0 );
    var_0 endon( "death" );

    while ( !common_scripts\utility::_ID36376( level.ac130player geteye(), level.ac130player getplayerangles(), var_0.origin, level.cosine["45"] ) )
        wait 0.5;

    context_sensative_dialog_play_random_group_sound( "vehicle", "incoming" );
}

context_sensative_dialog_vehicledeath( var_0 )
{
    var_0 waittill( "death" );
    thread context_sensative_dialog_play_random_group_sound( "vehicle", "death" );
}

context_sensative_dialog_filler()
{
    self endon( "ac130player_removed" );

    for (;;)
    {
        if ( isdefined( level.radio_in_use ) && level.radio_in_use == 1 )
            level waittill( "radio_not_in_use" );

        var_0 = gettime();

        if ( var_0 - level._ID19599 >= 3000 )
        {
            level._ID19599 = var_0;
            thread context_sensative_dialog_play_random_group_sound( "misc", "action" );
        }

        wait 0.25;
    }
}

context_sensative_dialog_play_random_group_sound( var_0, var_1, var_2 )
{
    level endon( "ac130player_removed" );

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !common_scripts\utility::_ID13177( "allow_context_sensative_dialog" ) )
    {
        if ( var_2 )
            common_scripts\utility::flag_wait( "allow_context_sensative_dialog" );
        else
            return;
    }

    var_3 = undefined;
    var_4 = randomint( level._ID27382[var_0][var_1].size );

    if ( level._ID27382[var_0][var_1][var_4]._ID23901 == 1 )
    {
        for ( var_5 = 0; var_5 < level._ID27382[var_0][var_1].size; var_5++ )
        {
            var_4++;

            if ( var_4 >= level._ID27382[var_0][var_1].size )
                var_4 = 0;

            if ( level._ID27382[var_0][var_1][var_4]._ID23901 == 1 )
                continue;

            var_3 = var_4;
            break;
        }

        if ( !isdefined( var_3 ) )
        {
            for ( var_5 = 0; var_5 < level._ID27382[var_0][var_1].size; var_5++ )
                level._ID27382[var_0][var_1][var_5]._ID23901 = 0;

            var_3 = randomint( level._ID27382[var_0][var_1].size );
        }
    }
    else
        var_3 = var_4;

    if ( context_sensative_dialog_timedout( var_0, var_1, var_3 ) )
        return;

    level._ID27382[var_0][var_1][var_3]._ID23901 = 1;
    var_6 = randomint( level._ID27382[var_0][var_1][var_3].size );
    _ID24646( level._ID27382[var_0][var_1][var_3].sounds[var_6], var_2 );
}

context_sensative_dialog_timedout( var_0, var_1, var_2 )
{
    if ( !isdefined( level._ID7909 ) )
        return 0;

    if ( !isdefined( level._ID7909[var_0] ) )
        return 0;

    if ( !isdefined( level._ID7909[var_0][var_1] ) )
        return 0;

    if ( isdefined( level._ID7909[var_0][var_1]._ID15839 ) && isdefined( level._ID7909[var_0][var_1]._ID15839[_ID31965( var_2 )] ) )
    {
        var_3 = gettime();

        if ( var_3 - level._ID7909[var_0][var_1]._ID15839[_ID31965( var_2 )]._ID34830["lastPlayed"] < level._ID7909[var_0][var_1]._ID15839[_ID31965( var_2 )]._ID34830["timeoutDuration"] )
            return 1;

        level._ID7909[var_0][var_1]._ID15839[_ID31965( var_2 )]._ID34830["lastPlayed"] = var_3;
    }
    else if ( isdefined( level._ID7909[var_0][var_1]._ID34830 ) )
    {
        var_3 = gettime();

        if ( var_3 - level._ID7909[var_0][var_1]._ID34830["lastPlayed"] < level._ID7909[var_0][var_1]._ID34830["timeoutDuration"] )
            return 1;

        level._ID7909[var_0][var_1]._ID34830["lastPlayed"] = var_3;
    }

    return 0;
}

_ID24646( var_0, var_1, var_2 )
{
    if ( !isdefined( level.radio_in_use ) )
        level.radio_in_use = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_2 *= 1000;
    var_3 = gettime();
    var_4 = 0;
    var_4 = _ID23872( var_0 );

    if ( var_4 )
        return;

    if ( !var_1 )
        return;

    level.radioforcedtransmissionqueue[level.radioforcedtransmissionqueue.size] = var_0;

    while ( !var_4 )
    {
        if ( level.radio_in_use )
            level waittill( "radio_not_in_use" );

        if ( var_2 > 0 && gettime() - var_3 > var_2 )
            break;

        if ( !isdefined( level.ac130player ) )
            break;

        var_4 = _ID23872( level.radioforcedtransmissionqueue[0] );

        if ( !level.radio_in_use && isdefined( level.ac130player ) && !var_4 )
        {

        }
    }

    level.radioforcedtransmissionqueue = _ID3839( level.radioforcedtransmissionqueue, 0 );
}

_ID23872( var_0 )
{
    if ( level.radio_in_use )
        return 0;

    if ( !isdefined( level.ac130player ) )
        return 0;

    level.radio_in_use = 1;

    if ( self.team == "allies" || self.team == "axis" )
    {
        var_0 = maps\mp\gametypes\_teams::getteamvoiceprefix( self.team ) + var_0;
        level.ac130player playlocalsound( var_0 );
    }

    wait 4.0;
    level.radio_in_use = 0;
    level._ID19599 = gettime();
    level notify( "radio_not_in_use" );
    return 1;
}

debug_circle( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = 16;
    var_7 = 360 / var_6;
    var_8 = [];

    for ( var_9 = 0; var_9 < var_6; var_9++ )
    {
        var_10 = var_7 * var_9;
        var_11 = cos( var_10 ) * var_1;
        var_12 = sin( var_10 ) * var_1;
        var_13 = var_0[0] + var_11;
        var_14 = var_0[1] + var_12;
        var_15 = var_0[2];
        var_8[var_8.size] = ( var_13, var_14, var_15 );
    }

    if ( isdefined( var_4 ) )
        wait(var_4);

    thread _ID9171( var_8, var_2, var_3, var_5, var_0 );
}

_ID9171( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_4 ) )
        var_3 = 0;

    for ( var_5 = 0; var_5 < var_0.size; var_5++ )
    {
        var_6 = var_0[var_5];

        if ( var_5 + 1 >= var_0.size )
            var_7 = var_0[0];
        else
            var_7 = var_0[var_5 + 1];

        thread debug_line( var_6, var_7, var_1, var_2 );

        if ( var_3 )
            thread debug_line( var_4, var_6, var_1, var_2 );
    }
}

debug_line( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = ( 1, 1, 1 );

    for ( var_4 = 0; var_4 < var_2 * 20; var_4++ )
        wait 0.05;
}

handleincomingmissiles()
{
    level endon( "game_ended" );
    level.ac130.planemodel thread _ID13274( 1 );
}

_ID13274( var_0 )
{
    self._ID13287 = var_0;
    self._ID13280 = [];
    thread _ID19300();
    thread ks_airsuperiority_handleincoming();
}

_ID24582( var_0 )
{
    for ( var_1 = 0; var_1 < var_0; var_1++ )
    {
        thread angel_flare();
        wait(randomfloatrange( 0.1, 0.25 ));
    }
}

_ID9665( var_0 )
{
    self playsound( "ac130iw6_flare_burst" );

    if ( !isdefined( var_0 ) )
    {
        var_1 = spawn( "script_origin", level.ac130.planemodel.origin );
        var_1.angles = level.ac130.planemodel.angles;
        var_1 movegravity( ( 0, 0, 0 ), 5.0 );
        thread _ID24582( 10 );
        self._ID13280[self._ID13280.size] = var_1;
        var_1 thread _ID9603( 5.0 );
        return var_1;
    }
    else
        thread _ID24582( 5 );
}

_ID13271( var_0 )
{
    return var_0._ID13287;
}

_ID13261( var_0 )
{
    _ID13263( var_0 );
    return var_0._ID13287 > 0 || var_0._ID13280.size > 0;
}

_ID13270( var_0 )
{
    var_0._ID13287--;
    var_1 = var_0 _ID9665();
    return var_1;
}

_ID13263( var_0 )
{
    var_0._ID13280 = common_scripts\utility::array_removeundefined( var_0._ID13280 );
}

_ID13269( var_0 )
{
    _ID13263( var_0 );
    var_1 = undefined;

    if ( var_0._ID13280.size > 0 )
        var_1 = var_0._ID13280[var_0._ID13280.size - 1];

    return var_1;
}

_ID19300()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self endon( "helicopter_done" );

    while ( _ID13261( self ) )
    {
        level waittill( "laserGuidedMissiles_incoming",  var_0, var_1, var_2  );

        if ( !isdefined( var_2 ) || var_2 != self )
            continue;

        level.ac130player playlocalsound( "missile_incoming" );
        level.ac130player thread _ID19306( self, "missile_incoming" );

        foreach ( var_4 in var_1 )
        {
            if ( isvalidmissile( var_4 ) )
                level thread _ID19301( var_4, var_0, var_0.team, var_2 );
        }
    }
}

_ID19301( var_0, var_1, var_2, var_3 )
{
    var_3 endon( "death" );
    var_0 endon( "death" );
    var_0 endon( "missile_targetChanged" );

    while ( _ID13261( var_3 ) )
    {
        if ( !isdefined( var_3 ) || !isvalidmissile( var_0 ) )
            break;

        var_4 = var_3 getpointinbounds( 0, 0, 0 );

        if ( distancesquared( var_0.origin, var_4 ) < 4000000 )
        {
            var_5 = _ID13269( var_3 );

            if ( !isdefined( var_5 ) )
                var_5 = _ID13270( var_3 );

            var_0 missile_settargetent( var_5 );
            var_0 notify( "missile_pairedWithFlare" );
            level.ac130player stoplocalsound( "missile_incoming" );
            break;
        }

        common_scripts\utility::_ID35582();
    }
}

ks_airsuperiority_handleincoming()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self endon( "helicopter_done" );

    while ( _ID13261( self ) )
    {
        self waittill( "targeted_by_incoming_missile",  var_0  );

        if ( !isdefined( var_0 ) )
            continue;

        level.ac130player playlocalsound( "missile_incoming" );
        level.ac130player thread _ID19306( self, "missile_incoming" );

        foreach ( var_2 in var_0 )
        {
            if ( isvalidmissile( var_2 ) )
                thread ks_airsuperiority_monitorproximity( var_2 );
        }
    }
}

ks_airsuperiority_monitorproximity( var_0 )
{
    self endon( "death" );
    var_0 endon( "death" );

    for (;;)
    {
        if ( !isdefined( self ) || !isvalidmissile( var_0 ) )
            break;

        var_1 = self getpointinbounds( 0, 0, 0 );

        if ( distancesquared( var_0.origin, var_1 ) < 4000000 )
        {
            var_2 = _ID13269( self );

            if ( !isdefined( var_2 ) && self._ID13287 > 0 )
                var_2 = _ID13270( self );

            if ( isdefined( var_2 ) )
            {
                var_0 missile_settargetent( var_2 );
                var_0 notify( "missile_pairedWithFlare" );
                level.ac130player stoplocalsound( "missile_incoming" );
                break;
            }
        }

        common_scripts\utility::_ID35582();
    }
}

_ID19306( var_0, var_1 )
{
    self endon( "disconnect" );
    var_0 waittill( "death" );
    self stoplocalsound( var_1 );
}

_ID9603( var_0 )
{
    wait(var_0);
    self delete();
}

crashplane( var_0 )
{
    level.ac130.planemodel notify( "crashing" );
    level.ac130.planemodel._ID8221 = 1;
    playfxontag( level._ID1644["ac130_explode"], level.ac130.planemodel, "tag_deathfx" );
    wait 0.25;
    level.ac130.planemodel hide();
}

angelflareprecache()
{
    level._ID1644["angel_flare_geotrail"] = loadfx( "fx/smoke/angel_flare_geotrail" );
    level._ID1644["angel_flare_swirl"] = loadfx( "fx/smoke/angel_flare_swirl_runner" );
}

angel_flare()
{
    var_0 = spawn( "script_model", self.origin );
    var_0 setmodel( "angel_flare_rig" );
    var_0.origin = self gettagorigin( "tag_flash_flares" );
    var_0.angles = self gettagangles( "tag_flash_flares" );
    var_0.angles = ( var_0.angles[0], var_0.angles[1] + 180, var_0.angles[2] + -90 );
    var_1 = level._ID1644["angel_flare_geotrail"];
    var_0 scriptmodelplayanim( "ac130_angel_flares0" + ( randomint( 3 ) + 1 ) );
    wait 0.1;
    playfxontag( var_1, var_0, "flare_left_top" );
    playfxontag( var_1, var_0, "flare_right_top" );
    wait 0.05;
    playfxontag( var_1, var_0, "flare_left_bot" );
    playfxontag( var_1, var_0, "flare_right_bot" );
    wait 3.0;
    stopfxontag( var_1, var_0, "flare_left_top" );
    stopfxontag( var_1, var_0, "flare_right_top" );
    stopfxontag( var_1, var_0, "flare_left_bot" );
    stopfxontag( var_1, var_0, "flare_right_bot" );
    var_0 delete();
}
