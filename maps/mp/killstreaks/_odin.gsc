// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["odin_support"] = ::_ID33859;
    level._ID19256["odin_assault"] = ::_ID33859;
    level._ID1644["odin_clouds"] = loadfx( "vfx/gameplay/mp/killstreaks/odin/odin_parallax_clouds" );
    level._ID1644["odin_fisheye"] = loadfx( "vfx/gameplay/screen_effects/vfx_scrnfx_odin_fisheye" );
    level._ID1644["odin_targeting"] = loadfx( "vfx/gameplay/mp/killstreaks/odin/vfx_marker_odin_cyan" );
    level.odinsettings = [];
    level.odinsettings["odin_support"] = spawnstruct();
    level.odinsettings["odin_support"].timeout = 60.0;
    level.odinsettings["odin_support"]._ID31889 = "odin_support";
    level.odinsettings["odin_support"]._ID35155 = "odin_mp";
    level.odinsettings["odin_support"].modelbase = "vehicle_odin_mp";
    level.odinsettings["odin_support"]._ID32680 = "used_odin_support";
    level.odinsettings["odin_support"]._ID35407 = "odin_gone";
    level.odinsettings["odin_support"]._ID35397 = "odin_target_killed";
    level.odinsettings["odin_support"]._ID35396 = "odin_targets_killed";
    level.odinsettings["odin_support"]._ID34179 = 1;
    level.odinsettings["odin_support"]._ID34186 = &"KILLSTREAKS_ODIN_UNAVAILABLE";
    level.odinsettings["odin_support"].weapon["airdrop"] = spawnstruct();
    level.odinsettings["odin_support"].weapon["airdrop"]._ID25056 = "odin_projectile_airdrop_mp";
    level.odinsettings["odin_support"].weapon["airdrop"]._ID26913 = "smg_fire";
    level.odinsettings["odin_support"].weapon["airdrop"].ammoomnvar = "ui_odin_airdrop_ammo";
    level.odinsettings["odin_support"].weapon["airdrop"].airdroptype = "airdrop_support";
    level.odinsettings["odin_support"].weapon["airdrop"]._ID25742 = 20;
    level.odinsettings["odin_support"].weapon["airdrop"]._ID34181 = -1;
    level.odinsettings["odin_support"].weapon["airdrop"]._ID35386 = "odin_carepackage";
    level.odinsettings["odin_support"].weapon["airdrop"].plr_ready_sound = "odin_carepack_ready";
    level.odinsettings["odin_support"].weapon["airdrop"].plr_fire_sound = "odin_carepack_launch";
    level.odinsettings["odin_support"].weapon["marking"] = spawnstruct();
    level.odinsettings["odin_support"].weapon["marking"]._ID25056 = "odin_projectile_marking_mp";
    level.odinsettings["odin_support"].weapon["marking"]._ID26913 = "heavygun_fire";
    level.odinsettings["odin_support"].weapon["marking"].ammoomnvar = "ui_odin_marking_ammo";
    level.odinsettings["odin_support"].weapon["marking"]._ID25742 = 4;
    level.odinsettings["odin_support"].weapon["marking"]._ID34181 = -1;
    level.odinsettings["odin_support"].weapon["marking"]._ID35405 = "odin_marking";
    level.odinsettings["odin_support"].weapon["marking"]._ID35404 = "odin_marked";
    level.odinsettings["odin_support"].weapon["marking"]._ID35403 = "odin_m_marked";
    level.odinsettings["odin_support"].weapon["marking"].plr_ready_sound = "odin_flash_ready";
    level.odinsettings["odin_support"].weapon["marking"].plr_fire_sound = "odin_flash_launch";
    level.odinsettings["odin_support"].weapon["smoke"] = spawnstruct();
    level.odinsettings["odin_support"].weapon["smoke"]._ID25056 = "odin_projectile_smoke_mp";
    level.odinsettings["odin_support"].weapon["smoke"]._ID26913 = "smg_fire";
    level.odinsettings["odin_support"].weapon["smoke"].ammoomnvar = "ui_odin_smoke_ammo";
    level.odinsettings["odin_support"].weapon["smoke"]._ID25742 = 7;
    level.odinsettings["odin_support"].weapon["smoke"]._ID34181 = -1;
    level.odinsettings["odin_support"].weapon["smoke"]._ID35406 = "odin_smoke";
    level.odinsettings["odin_support"].weapon["smoke"].plr_ready_sound = "odin_smoke_ready";
    level.odinsettings["odin_support"].weapon["smoke"].plr_fire_sound = "odin_smoke_launch";
    level.odinsettings["odin_support"].weapon["juggernaut"] = spawnstruct();
    level.odinsettings["odin_support"].weapon["juggernaut"]._ID25056 = "odin_projectile_smoke_mp";
    level.odinsettings["odin_support"].weapon["juggernaut"]._ID26913 = "heavygun_fire";
    level.odinsettings["odin_support"].weapon["juggernaut"].ammoomnvar = "ui_odin_juggernaut_ammo";
    level.odinsettings["odin_support"].weapon["juggernaut"].juggtype = "juggernaut_recon";
    level.odinsettings["odin_support"].weapon["juggernaut"]._ID25742 = level.odinsettings["odin_support"].timeout;
    level.odinsettings["odin_support"].weapon["juggernaut"]._ID34181 = -1;
    level.odinsettings["odin_support"].weapon["juggernaut"]._ID34182 = -2;
    level.odinsettings["odin_support"].weapon["juggernaut"]._ID34180 = -3;
    level.odinsettings["odin_support"].weapon["juggernaut"]._ID35395 = "odin_moving";
    level.odinsettings["odin_support"].weapon["juggernaut"].plr_ready_sound = "null";
    level.odinsettings["odin_support"].weapon["juggernaut"].plr_fire_sound = "odin_jugg_launch";
    level.odinsettings["odin_assault"] = spawnstruct();
    level.odinsettings["odin_assault"].timeout = 60.0;
    level.odinsettings["odin_assault"]._ID31889 = "odin_assault";
    level.odinsettings["odin_assault"]._ID35155 = "odin_mp";
    level.odinsettings["odin_assault"].modelbase = "vehicle_odin_mp";
    level.odinsettings["odin_assault"]._ID32680 = "used_odin_assault";
    level.odinsettings["odin_assault"]._ID35407 = "loki_gone";
    level.odinsettings["odin_assault"]._ID35397 = "odin_target_killed";
    level.odinsettings["odin_assault"]._ID35396 = "odin_targets_killed";
    level.odinsettings["odin_assault"]._ID34179 = 2;
    level.odinsettings["odin_assault"]._ID34186 = &"KILLSTREAKS_LOKI_UNAVAILABLE";
    level.odinsettings["odin_assault"].weapon["airdrop"] = spawnstruct();
    level.odinsettings["odin_assault"].weapon["airdrop"]._ID25056 = "odin_projectile_airdrop_mp";
    level.odinsettings["odin_assault"].weapon["airdrop"]._ID26913 = "smg_fire";
    level.odinsettings["odin_assault"].weapon["airdrop"].ammoomnvar = "ui_odin_airdrop_ammo";
    level.odinsettings["odin_assault"].weapon["airdrop"].airdroptype = "airdrop_assault";
    level.odinsettings["odin_assault"].weapon["airdrop"]._ID25742 = 20;
    level.odinsettings["odin_assault"].weapon["airdrop"]._ID34181 = -1;
    level.odinsettings["odin_assault"].weapon["airdrop"]._ID35386 = "odin_carepackage";
    level.odinsettings["odin_assault"].weapon["airdrop"].plr_ready_sound = "odin_carepack_ready";
    level.odinsettings["odin_assault"].weapon["airdrop"].plr_fire_sound = "odin_carepack_launch";
    level.odinsettings["odin_assault"].weapon["large_rod"] = spawnstruct();
    level.odinsettings["odin_assault"].weapon["large_rod"]._ID25056 = "odin_projectile_large_rod_mp";
    level.odinsettings["odin_assault"].weapon["large_rod"]._ID26913 = "heavygun_fire";
    level.odinsettings["odin_assault"].weapon["large_rod"].ammoomnvar = "ui_odin_marking_ammo";
    level.odinsettings["odin_assault"].weapon["large_rod"]._ID25742 = 4;
    level.odinsettings["odin_assault"].weapon["large_rod"]._ID34181 = -2;
    level.odinsettings["odin_assault"].weapon["large_rod"].plr_ready_sound = "null";
    level.odinsettings["odin_assault"].weapon["large_rod"].plr_fire_sound = "ac130_105mm_fire";
    level.odinsettings["odin_assault"].weapon["large_rod"].npc_fire_sound = "ac130_105mm_fire_npc";
    level.odinsettings["odin_assault"].weapon["small_rod"] = spawnstruct();
    level.odinsettings["odin_assault"].weapon["small_rod"]._ID25056 = "odin_projectile_small_rod_mp";
    level.odinsettings["odin_assault"].weapon["small_rod"]._ID26913 = "smg_fire";
    level.odinsettings["odin_assault"].weapon["small_rod"].ammoomnvar = "ui_odin_smoke_ammo";
    level.odinsettings["odin_assault"].weapon["small_rod"]._ID25742 = 2;
    level.odinsettings["odin_assault"].weapon["small_rod"]._ID34181 = -2;
    level.odinsettings["odin_assault"].weapon["small_rod"].plr_ready_sound = "null";
    level.odinsettings["odin_assault"].weapon["small_rod"].plr_fire_sound = "ac130_40mm_fire";
    level.odinsettings["odin_assault"].weapon["small_rod"].npc_fire_sound = "ac130_40mm_fire_npc";
    level.odinsettings["odin_assault"].weapon["juggernaut"] = spawnstruct();
    level.odinsettings["odin_assault"].weapon["juggernaut"]._ID25056 = "odin_projectile_smoke_mp";
    level.odinsettings["odin_assault"].weapon["juggernaut"]._ID26913 = "heavygun_fire";
    level.odinsettings["odin_assault"].weapon["juggernaut"].ammoomnvar = "ui_odin_juggernaut_ammo";
    level.odinsettings["odin_assault"].weapon["juggernaut"].juggtype = "juggernaut";
    level.odinsettings["odin_assault"].weapon["juggernaut"]._ID25742 = level.odinsettings["odin_assault"].timeout;
    level.odinsettings["odin_assault"].weapon["juggernaut"]._ID34181 = -1;
    level.odinsettings["odin_assault"].weapon["juggernaut"]._ID34182 = -2;
    level.odinsettings["odin_assault"].weapon["juggernaut"]._ID34180 = -3;
    level.odinsettings["odin_assault"].weapon["juggernaut"]._ID35395 = "odin_moving";
    level.odinsettings["odin_assault"].weapon["juggernaut"].plr_ready_sound = "null";
    level.odinsettings["odin_assault"].weapon["juggernaut"].plr_fire_sound = "odin_jugg_launch";

    if ( !isdefined( level._ID16638 ) )
    {
        level._ID16638 = getent( "heli_pilot_mesh", "targetname" );

        if ( !isdefined( level._ID16638 ) )
        {

        }
        else
            level._ID16638.origin = level._ID16638.origin + maps\mp\_utility::gethelipilotmeshoffset();
    }

    maps\mp\agents\_agents::_ID35509();
    level._ID2507["odin_juggernaut"] = level._ID2507["player"];
    level._ID2507["odin_juggernaut"]["think"] = common_scripts\utility::empty_init_func;
    level._ID22563 = 800;
    level._ID22564 = 200;
    level.active_odin = [];
}

_ID33859( var_0, var_1 )
{
    if ( isdefined( self.underwater ) && self.underwater )
        return 0;

    var_2 = var_1;
    var_3 = 1;

    if ( maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 + var_3 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        return 0;
    }

    if ( isdefined( level.active_odin[var_2] ) )
    {
        self iprintlnbold( level.odinsettings[var_2]._ID34186 );
        return 0;
    }

    maps\mp\_utility::_ID17543();
    var_4 = _ID8461( var_2 );

    if ( !isdefined( var_4 ) )
    {
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    var_5 = _ID31466( var_4 );

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    return var_5;
}

watchhostmigrationfinishedinit( var_0 )
{
    var_0 endon( "disconnect" );
    var_0 endon( "joined_team" );
    var_0 endon( "joined_spectators" );
    var_0 endon( "killstreak_disowned" );
    level endon( "game_ended" );
    self endon( "death" );

    for (;;)
    {
        level waittill( "host_migration_end" );
        var_0 setclientomnvar( "ui_odin", level.odinsettings[self._ID22598]._ID34179 );
        var_0 thermalvisionfofoverlayon();
        playfxontag( level._ID1644["odin_targeting"], self._ID32610, "tag_origin" );
        self._ID32610 showtoplayer( var_0 );
    }
}

_ID8461( var_0 )
{
    var_1 = self.origin * ( 1, 1, 0 ) + ( level._ID16638.origin - maps\mp\_utility::gethelipilotmeshoffset() ) * ( 0, 0, 1 );
    var_2 = ( 0, 0, 0 );
    var_3 = spawnhelicopter( self, var_1, var_2, level.odinsettings[var_0]._ID35155, level.odinsettings[var_0].modelbase );

    if ( !isdefined( var_3 ) )
        return;

    var_3.speed = 40;
    var_3.owner = self;
    var_3.team = self.team;
    var_3._ID22598 = var_0;
    level.active_odin[var_0] = 1;
    self._ID22520 = var_3;
    var_3 thread _ID22588();
    var_3 thread _ID22595();
    var_3 thread _ID22591();
    var_3 thread _ID22593();
    var_3 thread _ID22594();
    var_3 thread _ID22589();
    var_3 thread odin_watchoutlines();
    var_3 thread _ID22592();
    var_3 thread _ID22528();
    var_3 thread _ID22567();
    var_3.owner maps\mp\_matchdata::_ID20253( level.odinsettings[var_0]._ID31889, var_1 );
    return var_3;
}

_ID31466( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    self._ID26200 = vectortoangles( anglestoforward( self.angles ) );
    _ID22578( var_0 );

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::_ID28902( 0 );

    thread _ID36091( var_0 );
    maps\mp\_utility::_ID13582( 1 );
    odin_zoom_up( var_0 );
    thread maps\mp\killstreaks\_juggernaut::_ID10161();
    var_1 = maps\mp\killstreaks\_killstreaks::_ID17993( var_0._ID22598 );

    if ( var_1 != "success" )
    {
        if ( isdefined( self.disabledweapon ) && self.disabledweapon )
            common_scripts\utility::_enableweapon();

        var_0 notify( "death" );
        return 0;
    }

    maps\mp\_utility::_ID13582( 0 );
    self remotecontrolvehicle( var_0 );
    var_0 thread watchhostmigrationfinishedinit( self );
    var_0.odin_overlay_ent = spawnfxforclient( level._ID1644["odin_fisheye"], self geteye(), self );
    triggerfx( var_0.odin_overlay_ent );
    var_0.odin_overlay_ent setfxkilldefondelete();
    level thread maps\mp\_utility::_ID32672( level.odinsettings[var_0._ID22598]._ID32680, self );
    self thermalvisionfofoverlayon();
    thread waitandoutlineowner( var_0 );
    return 1;
}

waitandoutlineowner( var_0 )
{
    self endon( "disconnect" );
    var_0 endon( "death" );
    wait 1.0;
    var_1 = maps\mp\_utility::_ID23108( self, "cyan", self, 0, "killstreak" );
    var_0 thread _ID26020( var_1, self );
}

odin_zoom_up( var_0 )
{
    var_1 = spawn( "script_model", var_0.origin + ( 0, 0, 3000 ) );
    var_1.angles = vectortoangles( ( 0, 0, 1 ) );
    var_1 setmodel( "tag_origin" );
    var_1 thread _ID35533( 5 );
    var_2 = "odin_zoom_up";
    var_3 = var_1 getentitynumber();
    var_4 = self getentitynumber();
    var_5 = bullettrace( self.origin, var_0.origin, 0, self );

    if ( var_5["surfacetype"] != "none" )
    {
        var_2 = "odin_zoom_down";
        var_3 = var_0 getentitynumber();
        var_4 = var_1 getentitynumber();
    }

    var_6 = common_scripts\utility::array_add( maps\mp\_utility::_ID14681(), self );

    foreach ( var_8 in var_6 )
    {
        var_8 setclientomnvar( "cam_scene_name", var_2 );
        var_8 setclientomnvar( "cam_scene_lead", var_3 );
        var_8 setclientomnvar( "cam_scene_support", var_4 );
        var_8 thread clouds();
    }
}

_ID35533( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    wait(var_0);
    self delete();
}

clouds()
{
    level endon( "game_ended" );
    var_0 = spawn( "script_model", self.origin + ( 0, 0, 250 ) );
    var_0.angles = vectortoangles( ( 0, 0, 1 ) );
    var_0 setmodel( "tag_origin" );
    var_0 thread _ID35533( 2 );
    wait 0.1;
    playfxontagforclients( level._ID1644["odin_clouds"], var_0, "tag_origin", self );
}

_ID22578( var_0 )
{
    maps\mp\_utility::_ID29199( var_0._ID22598 );
    self._ID22520 = var_0;
}

odin_clear_using( var_0 )
{
    var_0._ID22556 = undefined;
    var_0._ID22565 = undefined;
    var_0._ID22581 = undefined;
    var_0._ID22521 = undefined;
    var_0._ID22558 = undefined;
    var_0._ID22580 = undefined;

    if ( isdefined( self ) )
    {
        maps\mp\_utility::_ID7513();
        self._ID22520 = undefined;
    }
}

_ID36091( var_0 )
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    self waittill( "intro_cleared" );
    self setclientomnvar( "ui_odin", level.odinsettings[var_0._ID22598]._ID34179 );
    _ID36062( var_0 );
}

odin_waitfordonefiring( var_0 )
{
    while ( isdefined( self.is_firing ) && var_0 > 0 )
    {
        wait 0.05;
        var_0 -= 0.05;
    }
}

_ID22588()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self waittill( "death" );

    if ( isdefined( self.owner ) )
        self.owner _ID22532( self );

    cleanup_ents();
    odin_waitfordonefiring( 3.0 );
    maps\mp\_utility::decrementfauxvehiclecount();
    level.active_odin[self._ID22598] = undefined;
    self delete();
}

_ID22595()
{
    level endon( "game_ended" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    var_0 = level.odinsettings[self._ID22598];
    var_1 = var_0.timeout;
    maps\mp\gametypes\_hostmigration::_ID35597( var_1 );
    thread odin_leave();
}

_ID22591()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner common_scripts\utility::_ID35626( "disconnect", "joined_team", "joined_spectators" );
    thread odin_leave();
}

_ID22589()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    level waittill( "objective_cam" );
    thread odin_leave();
}

_ID22593()
{
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    level common_scripts\utility::_ID35626( "round_end_finished", "game_ended" );
    thread odin_leave();
}

odin_leave()
{
    self endon( "death" );
    self notify( "leaving" );
    var_0 = level.odinsettings[self._ID22598];
    maps\mp\_utility::_ID19760( var_0._ID35407 );

    if ( isdefined( self.owner ) )
        self.owner _ID22532( self );

    self notify( "gone" );
    cleanup_ents();
    odin_waitfordonefiring( 3.0 );
    maps\mp\_utility::decrementfauxvehiclecount();
    level.active_odin[self._ID22598] = undefined;
    self delete();
}

_ID22532( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        self setclientomnvar( "ui_odin", -1 );
        var_0 notify( "end_remote" );
        self notify( "odin_ride_ended" );
        odin_clear_using( var_0 );

        if ( getdvarint( "camera_thirdPerson" ) )
            maps\mp\_utility::_ID28902( 1 );

        self thermalvisionfofoverlayoff();
        self remotecontrolvehicleoff( var_0 );
        self setplayerangles( self._ID26200 );
        thread _ID22543();
        self stoplocalsound( "odin_negative_action" );
        self stoplocalsound( "odin_positive_action" );

        foreach ( var_2 in level.odinsettings[var_0._ID22598].weapon )
        {
            if ( isdefined( var_2.plr_ready_sound ) )
                self stoplocalsound( var_2.plr_ready_sound );

            if ( isdefined( var_2.plr_fire_sound ) )
                self stoplocalsound( var_2.plr_fire_sound );
        }

        if ( isdefined( var_0._ID18980 ) )
            var_0._ID18980 maps\mp\bots\_bots_strategy::bot_guard_player( self, 350 );
    }
}

_ID22543()
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    maps\mp\_utility::_ID13582( 1 );
    wait 0.5;
    maps\mp\_utility::_ID13582( 0 );
}

_ID22594()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = self.owner;
    var_0 endon( "disconnect" );
    var_1 = var_0 getvieworigin();
    var_2 = var_1 + anglestoforward( self gettagangles( "tag_player" ) ) * 10000;
    var_3 = bullettrace( var_1, var_2, 0, self );
    var_4 = spawn( "script_model", var_3["position"] );
    var_4.angles = vectortoangles( ( 0, 0, 1 ) );
    var_4 setmodel( "tag_origin" );
    self._ID32610 = var_4;
    var_4 endon( "death" );
    var_5 = bullettrace( var_4.origin + ( 0, 0, 50 ), var_4.origin + ( 0, 0, -100 ), 0, var_4 );
    var_4.origin = var_5["position"] + ( 0, 0, 50 );
    var_4 hide();
    var_4 showtoplayer( var_0 );
    var_4 childthread monitormarkervisibility( var_0 );
    thread showfx();
    thread _ID36035();
    thread _ID36095();

    switch ( self._ID22598 )
    {
        case "odin_support":
            thread watchsmokeuse();
            thread _ID36097();
            break;
        case "odin_assault":
            thread _ID36096();
            thread _ID36128();
            break;
    }

    self setotherent( var_4 );
}

monitormarkervisibility( var_0 )
{
    wait 1.5;
    var_1 = [];

    for (;;)
    {
        var_2 = var_0 maps\mp\_utility::_ID14681();

        foreach ( var_4 in var_1 )
        {
            if ( !common_scripts\utility::array_contains( var_2, var_4 ) )
            {
                var_1 = common_scripts\utility::array_remove( var_1, var_4 );
                self hide();
                self showtoplayer( var_0 );
            }
        }

        foreach ( var_4 in var_2 )
        {
            self showtoplayer( var_4 );

            if ( !common_scripts\utility::array_contains( var_1, var_4 ) )
            {
                var_1 = common_scripts\utility::array_add( var_1, var_4 );
                stopfxontag( level._ID1644["odin_targeting"], self, "tag_origin" );
                wait 0.05;
                playfxontag( level._ID1644["odin_targeting"], self, "tag_origin" );
            }
        }

        wait 0.25;
    }
}

_ID36035()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = self.owner;
    var_0 endon( "disconnect" );
    var_1 = level.odinsettings[self._ID22598].weapon["airdrop"];
    self._ID22521 = 0;
    var_0 setclientomnvar( var_1.ammoomnvar, level.odinsettings[self._ID22598]._ID34179 );

    if ( !isai( var_0 ) )
        var_0 notifyonplayercommand( "airdrop_action", "+smoke" );

    for (;;)
    {
        var_0 waittill( "airdrop_action" );

        if ( isdefined( level.hostmigrationtimer ) )
            continue;

        if ( !isdefined( var_0._ID22520 ) )
            return;

        if ( gettime() >= self._ID22521 )
        {
            if ( level._ID32653 )
                maps\mp\_utility::_ID19760( var_1._ID35386, self.team );
            else
                var_0 maps\mp\_utility::_ID19765( var_1._ID35386 );

            self._ID22521 = odin_fireweapon( "airdrop" );
            var_1 = level.odinsettings[self._ID22598].weapon["airdrop"];
            level thread maps\mp\killstreaks\_airdrop::_ID10390( var_0, self._ID32610.origin, randomfloat( 360 ), var_1.airdroptype );
        }
        else
            var_0 maps\mp\_utility::_playlocalsound( "odin_negative_action" );

        wait 1.0;
    }
}

watchsmokeuse()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = self.owner;
    var_0 endon( "disconnect" );
    var_1 = level.odinsettings[self._ID22598].weapon["smoke"];
    self._ID22581 = 0;
    var_0 setclientomnvar( var_1.ammoomnvar, level.odinsettings[self._ID22598]._ID34179 );

    if ( !isai( var_0 ) )
    {
        var_0 notifyonplayercommand( "smoke_action", "+speed_throw" );
        var_0 notifyonplayercommand( "smoke_action", "+ads_akimbo_accessible" );

        if ( !level.console )
            var_0 notifyonplayercommand( "smoke_action", "+toggleads_throw" );
    }

    for (;;)
    {
        var_0 waittill( "smoke_action" );

        if ( isdefined( level.hostmigrationtimer ) )
            continue;

        if ( !isdefined( var_0._ID22520 ) )
            return;

        if ( gettime() >= self._ID22581 )
        {
            if ( level._ID32653 )
                maps\mp\_utility::_ID19760( var_1._ID35406, self.team );
            else
                var_0 maps\mp\_utility::_ID19765( var_1._ID35406 );

            self._ID22581 = odin_fireweapon( "smoke" );
        }
        else
            var_0 maps\mp\_utility::_playlocalsound( "odin_negative_action" );

        wait 1.0;
    }
}

_ID36097()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = self.owner;
    var_0 endon( "disconnect" );
    var_1 = level.odinsettings[self._ID22598].weapon["marking"];
    self._ID22565 = 0;
    var_0 setclientomnvar( var_1.ammoomnvar, level.odinsettings[self._ID22598]._ID34179 );

    if ( !isai( var_0 ) )
    {
        var_0 notifyonplayercommand( "marking_action", "+attack" );
        var_0 notifyonplayercommand( "marking_action", "+attack_akimbo_accessible" );
    }

    for (;;)
    {
        var_0 waittill( "marking_action" );

        if ( isdefined( level.hostmigrationtimer ) )
            continue;

        if ( !isdefined( var_0._ID22520 ) )
            return;

        if ( gettime() >= self._ID22565 )
        {
            self._ID22565 = odin_fireweapon( "marking" );
            thread domarkingflash( self._ID32610.origin + ( 0, 0, 10 ) );
        }
        else
            var_0 maps\mp\_utility::_playlocalsound( "odin_negative_action" );

        wait 1.0;
    }
}

_ID36095()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = self.owner;
    var_0 endon( "disconnect" );
    var_0 endon( "juggernaut_dead" );
    var_1 = level.odinsettings[self._ID22598].weapon["juggernaut"];
    self._ID22556 = 0;
    var_0 setclientomnvar( var_1.ammoomnvar, level.odinsettings[self._ID22598]._ID34179 );

    if ( !isai( var_0 ) )
        var_0 notifyonplayercommand( "juggernaut_action", "+frag" );

    for (;;)
    {
        var_0 waittill( "juggernaut_action" );

        if ( isdefined( level.hostmigrationtimer ) )
            continue;

        if ( !isdefined( var_0._ID22520 ) )
            return;

        if ( gettime() >= self._ID22556 )
        {
            var_2 = _ID15074( self._ID32610.origin );

            if ( isdefined( var_2 ) )
            {
                self._ID22556 = odin_fireweapon( "juggernaut" );
                thread _ID35537( var_2 );
            }
            else
                var_0 maps\mp\_utility::_playlocalsound( "odin_negative_action" );
        }
        else if ( isdefined( self._ID18980 ) )
        {
            var_2 = _ID15073( self._ID32610.origin );

            if ( isdefined( var_2 ) )
            {
                var_0 maps\mp\_utility::_ID19765( var_1._ID35395 );
                var_0 maps\mp\_utility::_playlocalsound( "odin_positive_action" );
                var_0 playrumbleonentity( "pistol_fire" );
                self._ID18980 maps\mp\bots\_bots_strategy::bot_protect_point( var_2.origin, 128 );
                var_0 setclientomnvar( var_1.ammoomnvar, level.odinsettings[self._ID22598]._ID34179 );
            }
            else
                var_0 maps\mp\_utility::_playlocalsound( "odin_negative_action" );
        }

        wait 1.1;

        if ( isdefined( self._ID18980 ) )
            var_0 setclientomnvar( var_1.ammoomnvar, var_1._ID34182 );
    }
}

_ID36096()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = self.owner;
    var_0 endon( "disconnect" );
    var_1 = level.odinsettings[self._ID22598].weapon["large_rod"];
    self._ID22558 = 0;
    var_0 setclientomnvar( var_1.ammoomnvar, level.odinsettings[self._ID22598]._ID34179 );

    if ( !isai( var_0 ) )
    {
        var_0 notifyonplayercommand( "large_rod_action", "+attack" );
        var_0 notifyonplayercommand( "large_rod_action", "+attack_akimbo_accessible" );
    }

    for (;;)
    {
        var_0 waittill( "large_rod_action" );

        if ( isdefined( level.hostmigrationtimer ) )
            continue;

        if ( !isdefined( var_0._ID22520 ) )
            return;

        if ( gettime() >= self._ID22558 )
            self._ID22558 = odin_fireweapon( "large_rod" );
        else
            var_0 maps\mp\_utility::_playlocalsound( "odin_negative_action" );

        wait 1.0;
    }
}

_ID36128()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = self.owner;
    var_0 endon( "disconnect" );
    var_1 = level.odinsettings[self._ID22598].weapon["small_rod"];
    self._ID22580 = 0;
    var_0 setclientomnvar( var_1.ammoomnvar, level.odinsettings[self._ID22598]._ID34179 );

    if ( !isai( var_0 ) )
    {
        var_0 notifyonplayercommand( "small_rod_action", "+speed_throw" );
        var_0 notifyonplayercommand( "small_rod_action", "+ads_akimbo_accessible" );

        if ( !level.console )
            var_0 notifyonplayercommand( "small_rod_action", "+toggleads_throw" );
    }

    for (;;)
    {
        var_0 waittill( "small_rod_action" );

        if ( isdefined( level.hostmigrationtimer ) )
            continue;

        if ( !isdefined( var_0._ID22520 ) )
            return;

        if ( gettime() >= self._ID22580 )
            self._ID22580 = odin_fireweapon( "small_rod" );
        else
            var_0 maps\mp\_utility::_playlocalsound( "odin_negative_action" );

        wait 1.0;
    }
}

odin_fireweapon( var_0 )
{
    self.is_firing = 1;
    var_1 = self.owner;
    var_2 = level.odinsettings[self._ID22598].weapon[var_0];
    var_3 = anglestoforward( var_1 getplayerangles() );
    var_4 = self.origin + var_3 * 100;
    var_1 setclientomnvar( var_2.ammoomnvar, var_2._ID34181 );
    thread _ID36115( var_2 );
    var_5 = self._ID32610.origin;
    var_6 = gettime() + var_2._ID25742 * 1000;

    if ( var_0 == "large_rod" )
    {
        wait 0.5;
        var_1 playrumbleonentity( var_2._ID26913 );
        earthquake( 0.3, 1.5, self.origin, 1000 );
        var_1 playsoundtoplayer( var_2.plr_fire_sound, var_1 );
        playsoundatpos( self.origin, var_2.npc_fire_sound );
        wait 1.5;
    }
    else if ( var_0 == "small_rod" )
    {
        wait 0.5;
        var_1 playrumbleonentity( var_2._ID26913 );
        earthquake( 0.2, 1, self.origin, 1000 );
        var_1 playsoundtoplayer( var_2.plr_fire_sound, var_1 );
        playsoundatpos( self.origin, var_2.npc_fire_sound );
        wait 0.3;
    }
    else
    {
        if ( isdefined( var_2.plr_fire_sound ) )
            var_1 playsoundtoplayer( var_2.plr_fire_sound, var_1 );

        if ( isdefined( var_2.npc_fire_sound ) )
            playsoundatpos( self.origin, var_2.npc_fire_sound );

        var_1 playrumbleonentity( var_2._ID26913 );
    }

    var_7 = magicbullet( var_2._ID25056, var_4, var_5, var_1 );
    var_7.type = "odin";
    var_7 thread _ID38293( var_0 );

    if ( var_0 == "smoke" || var_0 == "juggernaut" || var_0 == "large_rod" )
        level notify( "smoke",  var_7, var_2._ID25056  );

    self.is_firing = undefined;
    return var_6;
}

_ID38293( var_0 )
{
    self waittill( "explode",  var_1  );

    if ( var_0 == "small_rod" )
    {
        playrumbleonposition( "grenade_rumble", var_1 );
        earthquake( 0.7, 1.0, var_1, 1000 );
    }
    else if ( var_0 == "large_rod" )
    {
        playrumbleonposition( "artillery_rumble", var_1 );
        earthquake( 1.0, 1.0, var_1, 2000 );
    }
}

_ID15074( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_1 = getnodesinradiussorted( var_0, 256, 0, 128, "Path" );

    if ( !isdefined( var_1[0] ) )
        return;

    return var_1[0];
}

_ID15073( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_1 = getnodesinradiussorted( var_0, 128, 0, 64, "Path" );

    if ( !isdefined( var_1[0] ) )
        return;

    return var_1[0];
}

_ID35537( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_1 = self.owner;
    var_1 endon( "disconnect" );
    var_2 = self._ID32610.origin;
    wait 3.0;
    var_3 = maps\mp\agents\_agents::add_humanoid_agent( "odin_juggernaut", var_1.team, "class1", var_0.origin, vectortoangles( var_2 - var_0.origin ), var_1, 0, 0, "veteran" );

    if ( isdefined( var_3 ) )
    {
        var_4 = level.odinsettings[self._ID22598].weapon["juggernaut"];
        var_3 thread maps\mp\killstreaks\_juggernaut::givejuggernaut( var_4.juggtype );
        var_3 thread maps\mp\killstreaks\_agent_killstreak::_ID28060();
        var_3 maps\mp\bots\_bots_strategy::bot_protect_point( var_0.origin, 128 );
        self._ID18980 = var_3;
        thread _ID36094();
        var_1 setclientomnvar( var_4.ammoomnvar, var_4._ID34182 );
        var_5 = maps\mp\_utility::_ID23108( var_3, "cyan", self.owner, 0, "killstreak" );
        thread _ID26020( var_5, var_3 );
        var_3 maps\mp\_utility::_setnameplatematerial( "player_name_bg_green_agent", "player_name_bg_red_agent" );
    }
    else
        var_1 iprintlnbold( &"KILLSTREAKS_AGENT_MAX" );
}

_ID36094()
{
    self endon( "death" );
    level endon( "game_ended" );
    self._ID18980 waittill( "death" );
    self.owner notify( "juggernaut_dead" );
    var_0 = level.odinsettings[self._ID22598].weapon["juggernaut"];
    self.owner setclientomnvar( var_0.ammoomnvar, var_0._ID34180 );
    self._ID18980 = undefined;
}

showfx()
{
    self endon( "death" );
    wait 1.0;
    playfxontag( level._ID1644["odin_targeting"], self._ID32610, "tag_origin" );
}

_ID36115( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_1 = self.owner;
    var_1 endon( "disconnect" );
    var_1 endon( "odin_ride_ended" );
    var_2 = var_0.ammoomnvar;
    var_3 = var_0._ID25742;
    var_4 = var_0.plr_ready_sound;
    var_5 = level.odinsettings[self._ID22598]._ID34179;
    wait(var_3);

    if ( !isdefined( var_1._ID22520 ) )
        return;

    if ( isdefined( var_4 ) )
        var_1 maps\mp\_utility::_playlocalsound( var_4 );

    var_1 setclientomnvar( var_2, var_5 );
}

domarkingflash( var_0 )
{
    level endon( "game_ended" );
    var_1 = self.owner;
    var_2 = level._ID22563 * level._ID22563;
    var_3 = level._ID22564 * level._ID22564;
    var_4 = 60;
    var_5 = 40;
    var_6 = 11;
    var_7 = 0;

    foreach ( var_9 in level._ID23303 )
    {
        if ( !maps\mp\_utility::_ID18757( var_9 ) || var_9.sessionstate != "playing" )
            continue;

        if ( level._ID32653 && var_9.team == self.team )
            continue;

        var_10 = distancesquared( var_0, var_9.origin );

        if ( var_10 > var_2 )
            continue;

        var_11 = var_9 getstance();
        var_12 = var_9.origin;

        switch ( var_11 )
        {
            case "stand":
                var_12 = ( var_12[0], var_12[1], var_12[2] + var_4 );
                break;
            case "crouch":
                var_12 = ( var_12[0], var_12[1], var_12[2] + var_5 );
                break;
            case "prone":
                var_12 = ( var_12[0], var_12[1], var_12[2] + var_6 );
                break;
        }

        if ( !bullettracepassed( var_0, var_12, 0, var_9 ) )
            continue;

        if ( var_10 <= var_3 )
            var_13 = 1.0;
        else
            var_13 = 1.0 - ( var_10 - var_3 ) / ( var_2 - var_3 );

        var_14 = anglestoforward( var_9 getplayerangles() );
        var_15 = var_0 - var_12;
        var_15 = vectornormalize( var_15 );
        var_16 = 0.5 * ( 1.0 + vectordot( var_14, var_15 ) );
        var_17 = 1;
        var_9 notify( "flashbang",  var_0, var_13, var_16, var_1, var_17  );
        var_7++;

        if ( !_ID12072( var_9 ) )
        {
            if ( level._ID32653 )
                var_18 = maps\mp\_utility::_ID23109( var_9, "orange", self.team, 0, "killstreak" );
            else
                var_18 = maps\mp\_utility::_ID23108( var_9, "orange", self.owner, 0, "killstreak" );

            thread _ID26020( var_18, var_9, 3.0 );
        }
    }

    var_20 = level.odinsettings[self._ID22598].weapon["marking"];

    if ( var_7 == 1 )
    {
        if ( level._ID32653 )
            maps\mp\_utility::_ID19760( var_20._ID35404, self.team );
        else
            var_1 maps\mp\_utility::_ID19765( var_20._ID35404 );
    }
    else if ( var_7 > 1 )
    {
        if ( level._ID32653 )
            maps\mp\_utility::_ID19760( var_20._ID35403, self.team );
        else
            var_1 maps\mp\_utility::_ID19765( var_20._ID35403 );
    }

    var_21 = maps\mp\gametypes\_weapons::getempdamageents( var_0, 512, 0 );

    foreach ( var_23 in var_21 )
    {
        if ( isdefined( var_23.owner ) && !maps\mp\gametypes\_weapons::_ID13695( self.owner, var_23.owner ) )
            continue;

        var_23 notify( "emp_damage",  self.owner, 8.0  );
    }
}

applyoutline( var_0 )
{
    if ( level._ID32653 && var_0.team == self.team )
        return;
    else if ( !level._ID32653 && var_0 == self.owner )
        return;

    if ( _ID12072( var_0 ) )
        return;

    var_1 = maps\mp\_utility::_ID23108( var_0, "orange", self.owner, 1, "killstreak" );
    thread _ID26020( var_1, var_0 );
}

_ID12072( var_0 )
{
    return var_0 maps\mp\_utility::_hasperk( "specialty_noplayertarget" );
}

_ID26020( var_0, var_1, var_2 )
{
    if ( isdefined( var_1 ) )
        var_1 endon( "disconnect" );

    level endon( "game_ended" );
    var_3 = [ "leave", "death" ];

    if ( isdefined( var_2 ) )
        common_scripts\utility::waittill_any_in_array_or_timeout_no_endon_death( var_3, var_2 );
    else
        common_scripts\utility::waittill_any_in_array_return_no_endon_death( var_3 );

    if ( isdefined( var_1 ) )
        maps\mp\_utility::_ID23104( var_0, var_1 );
}

odin_watchoutlines()
{
    self endon( "death" );
    level endon( "game_ended" );

    foreach ( var_1 in level._ID23303 )
        applyoutline( var_1 );
}

_ID22592()
{
    self endon( "death" );
    level endon( "game_ended" );
    self.enemieskilledintimewindow = 0;

    for (;;)
    {
        level waittill( "odin_killed_player",  var_0  );
        self.enemieskilledintimewindow++;
        self notify( "odin_enemy_killed" );
    }
}

_ID22528( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_1 = level.odinsettings[self._ID22598];
    var_2 = 1.0;

    for (;;)
    {
        self waittill( "odin_enemy_killed" );
        wait(var_2);

        if ( self.enemieskilledintimewindow > 1 )
            self.owner maps\mp\_utility::_ID19765( var_1._ID35396 );
        else
            self.owner maps\mp\_utility::_ID19765( var_1._ID35397 );

        self.enemieskilledintimewindow = 0;
    }
}

_ID22567()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread _ID22568( self );
    }
}

_ID22568( var_0 )
{
    self endon( "disconnect" );
    self waittill( "spawned_player" );
    var_0 applyoutline( self );
}

cleanup_ents()
{
    if ( isdefined( self._ID32610 ) )
        self._ID32610 delete();

    if ( isdefined( self.odin_overlay_ent ) )
        self.odin_overlay_ent delete();
}

_ID36062( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 thread maps\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit();
    var_0 waittill( "killstreakExit" );
    var_1 = level.odinsettings[var_0._ID22598];
    maps\mp\_utility::_ID19760( var_1._ID35407 );
    var_0 notify( "death" );
}
