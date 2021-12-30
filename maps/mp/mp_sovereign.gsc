// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_sovereign_precache::_ID20445();
    maps\createart\mp_sovereign_art::_ID20445();
    maps\mp\mp_sovereign_fx::_ID20445();
    level thread _ID35812();
    level thread maps\mp\mp_sovereign_events::assembly_line_precache();
    level thread maps\mp\_movable_cover::_ID17631();
    level._ID20636 = ::_ID30505;
    level.mapcustomkillstreakfunc = ::_ID30506;
    level._ID20635 = ::_ID30504;
    maps\mp\_load::_ID20445();
    thread maps\mp\_fx::_ID13742();
    maps\mp\_compass::_ID29184( "compass_map_mp_sovereign" );

    if ( level._ID25139 || level._ID36452 )
        setdvar( "sm_sunShadowScale", "0.5" );

    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    setdvar( "r_sky_fog_intensity", "1" );
    setdvar( "r_sky_fog_min_angle", "60" );
    setdvar( "r_sky_fog_max_angle", "85" );
    setdvar( "r_ssaofadedepth", 1200 );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 3.5, 5 );
    maps\mp\_utility::_ID28710( "r_diffuseColorScale", 1.5, 1.2 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level thread maps\mp\mp_sovereign_events::assembly_line();
    level thread maps\mp\mp_sovereign_events::_ID16003();
    level thread _ID26345();
    level thread _ID20514();
    level thread _ID34405();
}

_ID34405()
{
    var_0 = 1200;
    var_1 = var_0 * var_0;

    while ( !isdefined( level._ID23303 ) )
        common_scripts\utility::_ID35582();

    for (;;)
    {
        var_2 = [];

        foreach ( var_4 in level._ID23303 )
        {
            if ( !isplayer( var_4 ) )
                continue;

            var_5 = level._ID16002 && var_4 geteye()[2] < 280;

            if ( var_5 )
                var_2[var_2.size] = var_4;

            if ( isbot( var_4 ) )
            {
                if ( !isdefined( var_4._ID9372 ) )
                    var_4._ID9372 = var_4.maxsightdistsqrd;

                if ( var_5 )
                {
                    var_4.maxsightdistsqrd = var_1;
                    continue;
                }

                var_4.maxsightdistsqrd = var_4._ID9372;
            }
        }

        if ( var_2.size )
            common_scripts\utility::exploder( 39, var_2 );

        wait 0.5;
    }
}

is_dynamic_path()
{
    return isdefined( self.spawnflags ) && self.spawnflags & 1;
}

_ID18359()
{
    return isdefined( self.spawnflags ) && self.spawnflags & 2;
}
#using_animtree("animated_props");

_ID35812()
{
    common_scripts\utility::_ID13189( "walkway_collasped" );

    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
        return;

    precachempanim( "mp_sovereign_walkway_collapse_top" );
    precachempanim( "mp_sovereign_walkway_collapse_bottom" );
    precachempanim( "mp_sovereign_walkway_collapse_top_idle" );
    precachempanim( "mp_sovereign_walkway_collapse_bottom_idle" );
    common_scripts\utility::_ID35582();
    var_0 = getanimlength( %mp_sovereign_walkway_collapse_top );
    var_1 = getanimlength( %mp_sovereign_walkway_collapse_bottom );
    var_2 = getnotetracktimes( %mp_sovereign_walkway_collapse_top, "bottom_anim_begin" )[0];
    var_2 *= var_0;
    var_3 = getent( "walkway_trigger_damage", "targetname" );
    var_4 = getent( "walkway_tank_animated", "targetname" );
    var_4 scriptmodelplayanimdeltamotion( "mp_sovereign_walkway_collapse_top_idle" );

    if ( isdefined( var_4.target ) )
    {
        var_4._ID7525 = getent( var_4.target, "targetname" );

        if ( isdefined( var_4._ID7525 ) )
        {
            var_4._ID7525 linkto( var_4, "j_canister_main" );
            var_5 = spawn( "script_model", ( 568, -722, 568 ) );
            var_4._ID7525._ID19214 = var_5;
        }
    }

    var_6 = getentarray( "walkway_clip_end", "targetname" );
    common_scripts\utility::_ID3867( var_6, ::_ID35813 );
    var_7 = getent( "walkway_tank_trigger_hurt", "targetname" );

    if ( isdefined( var_7 ) )
        var_7 delete();

    var_8 = getent( "walkway_animated", "targetname" );
    var_8 scriptmodelplayanimdeltamotion( "mp_sovereign_walkway_collapse_bottom_idle" );
    var_8 hide();
    var_9 = _ID35815( "walkway_non_destroyed" );
    var_10 = _ID35815( "walkway_destroyed" );
    var_10 _ID35816();
    var_11 = [];
    var_12 = getnotetracktimes( %mp_sovereign_walkway_collapse_top, "hose1_start" );
    var_13 = getnotetracktimes( %mp_sovereign_walkway_collapse_top, "hose2_start" );
    var_14 = getnotetracktimes( %mp_sovereign_walkway_collapse_top, "hose3_start" );

    if ( var_12.size > 0 )
    {
        var_15 = var_12[0] * var_0;
        var_16 = var_13[0] * var_0;
        var_17 = var_14[0] * var_0;
        var_11[0] = [ "tag_fx_canister_1", "vfx_can_afterleak", var_15 ];
        var_11[1] = [ "tag_fx_canister_2", "vfx_can_afterleak", var_16 ];
        var_11[2] = [ "tag_fx_canister_3", "vfx_can_afterleak", var_17 ];
        var_11[3] = [ "tag_fx_cables_1", "vfx_can_jet", var_15 ];
        var_11[4] = [ "tag_fx_cables_2", "vfx_can_jet", var_16 ];
        var_11[5] = [ "tag_fx_cables_3", "vfx_can_jet", var_17 ];
    }

    for (;;)
    {
        var_18 = _ID35821( var_3 );
        common_scripts\utility::flag_set( "walkway_collasped" );
        common_scripts\utility::exploder( 2 );
        var_4._ID7525 playsoundonmovingent( "scn_catwalk_break_away" );
        common_scripts\utility::_ID22147( var_2, ::playsoundatpos, ( 136, -412, 360 ), "scn_catwalk_impact" );
        common_scripts\utility::_ID22147( 4.13, ::playsoundatpos, ( 242, -326, 322 ), "scn_catwalk_steam_burst1" );
        common_scripts\utility::_ID22147( 4.46, ::playsoundatpos, ( 277, -283, 256 ), "scn_catwalk_steam_burst2" );
        var_4 scriptmodelplayanimdeltamotion( "mp_sovereign_walkway_collapse_top" );

        foreach ( var_20 in var_11 )
            thread _ID35820( var_20[2], var_4, var_20[1], var_20[0] );

        level maps\mp\_utility::_ID9519( var_2, common_scripts\utility::exploder, 3 );
        var_8 common_scripts\utility::delaycall( var_2, ::show );
        var_8 common_scripts\utility::delaycall( var_2, ::scriptmodelplayanimdeltamotion, "mp_sovereign_walkway_collapse_bottom" );
        var_9 maps\mp\_utility::_ID9519( var_2, ::_ID35816 );
        common_scripts\utility::_ID3867( var_6, maps\mp\_utility::_ID9519, var_2, ::walkway_collapse_clip_show );
        var_10 maps\mp\_utility::_ID9519( var_2 + var_1, ::_ID35819 );

        if ( isdefined( var_4._ID7525 ) )
        {
            var_4._ID7525 thread maps\mp\_movers::_ID24268( 0 );
            var_4._ID7525 maps\mp\_utility::_ID9519( var_2 + var_1, ::_ID35813 );
            var_4._ID7525.unresolved_collision_kill = 1;
            var_4._ID7525._ID34253 = 1;
            var_4._ID7525.owner = var_18;
        }

        wait(var_2 + var_1);

        if ( isdefined( var_4._ID7525 ) )
        {
            var_4._ID7525 maps\mp\_movers::_ID31810();
            var_4._ID7525.unresolved_collision_kill = 0;
            var_4._ID7525._ID34253 = undefined;
            var_4._ID7525.owner = undefined;
        }

        _ID35821();
        common_scripts\utility::_ID13180( "walkway_collasped" );
        var_4 show();
        var_8 scriptmodelplayanimdeltamotion( "mp_sovereign_walkway_collapse_bottom_idle" );
        var_8 hide();
        common_scripts\utility::_ID3867( var_6, ::_ID35813 );
        var_9 _ID35819();
        var_10 _ID35816();

        if ( isdefined( var_4._ID7525 ) )
            var_4._ID7525 walkway_collapse_clip_show();

        wait 1;
        var_4 scriptmodelplayanimdeltamotion( "mp_sovereign_walkway_collapse_top_idle" );
    }
}

_ID35820( var_0, var_1, var_2, var_3 )
{
    wait(var_0);
    playfxontag( level._ID1644[var_2], var_1, var_3 );
}

_ID35818()
{
    self notify( "stop_walkway_collapse_hurt_trigger" );
}

_ID35817( var_0 )
{
    self endon( "stop_walkway_collapse_hurt_trigger" );

    for (;;)
    {
        self waittill( "trigger",  var_1  );

        if ( isplayer( var_1 ) )
            var_1 dodamage( 1000, var_1.origin );
    }
}

_ID35821( var_0 )
{
    level thread _ID35822();

    if ( isdefined( var_0 ) )
        level thread _ID35823( var_0 );

    level waittill( "activate_walkway",  var_1  );
    return var_1;
}

_ID35823( var_0 )
{
    level endon( "activate_walkway" );
    var_0 waittill( "trigger",  var_1  );
    level notify( "activate_walkway",  var_1  );
}

_ID35822()
{
    level endon( "activate_walkway" );

    while ( getdvarint( "trigger_walkway" ) == 0 )
        wait 0.05;

    level notify( "activate_walkway" );
}

_ID35816()
{
    if ( isdefined( self._ID35816 ) && self._ID35816 )
        return;

    self._ID35816 = 1;
    self.origin = self.origin - ( 0, 0, 1000 );

    foreach ( var_1 in self._ID7525 )
        var_1 _ID35813();

    self dontinterpolate();

    foreach ( var_4 in self._ID33485 )
        disconnectnodepair( var_4, var_4._ID7866 );

    foreach ( var_4 in self.nodes )
        var_4 disconnectnode();
}

_ID35813()
{
    if ( is_dynamic_path() )
        self connectpaths();

    if ( _ID18359() )
        self setaisightlinevisible( 0 );

    self._ID22672 = self setcontents( 0 );
    self notsolid();
    self hide();
}

_ID35819()
{
    if ( isdefined( self._ID35816 ) && !self._ID35816 )
        return;

    self._ID35816 = 0;
    self.origin = self.origin + ( 0, 0, 1000 );

    foreach ( var_1 in self._ID7525 )
        var_1 walkway_collapse_clip_show();

    self dontinterpolate();

    foreach ( var_4 in self._ID33485 )
        connectnodepair( var_4, var_4._ID7866 );

    foreach ( var_4 in self.nodes )
        var_4 connectnode();
}

walkway_collapse_clip_show()
{
    self solid();
    self setcontents( self._ID22672 );
    self show();

    if ( is_dynamic_path() )
        self disconnectpaths();

    if ( _ID18359() )
        self setaisightlinevisible( 1 );
}

_ID35815( var_0 )
{
    var_1 = common_scripts\utility::_ID15384( var_0, "targetname" );

    if ( !isdefined( var_1 ) )
        return undefined;

    var_2 = spawn( "script_model", var_1.origin );
    var_2 setmodel( "tag_origin" );
    var_2._ID7525 = [];
    var_2.linked = [];
    var_3 = var_1 common_scripts\utility::get_linked_ents();

    foreach ( var_5 in var_3 )
    {
        if ( var_5.classname == "script_brushmodel" )
        {
            var_2._ID7525[var_2._ID7525.size] = var_5;
            continue;
        }

        var_2.linked[var_2.linked.size] = var_5;
        var_5 linkto( var_2 );
    }

    var_7 = var_1 maps\mp\_utility::getlinknamenodes();
    var_2._ID33485 = [];
    var_2.nodes = [];

    foreach ( var_9 in var_7 )
    {
        if ( isdefined( var_9.targetname ) && var_9.targetname == "traverse" )
        {
            var_9._ID7866 = getnode( var_9.target, "targetname" );
            var_2._ID33485[var_2._ID33485.size] = var_9;
            continue;
        }

        var_2.nodes[var_2.nodes.size] = var_9;
    }

    return var_2;
}

_ID20514()
{
    var_0 = getent( "malfunctioning_crane_arm", "targetname" );
    var_1 = getent( "malfunctioning_crane_arm_clip", "targetname" );
    var_2 = getanimlength( %mp_sovereign_malfunctioning_crane_arm );

    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_1 ) )
    {
        var_1 enablelinkto();
        var_1 linkto( var_0, "basetwist_jnt", ( 0, 0, 0 ), ( 180, 0, 0 ) );
    }

    var_3 = spawn( "script_model", var_0.origin );
    var_3 setmodel( "tag_origin" );
    var_3 linkto( var_0, "basetwist_jnt" );
    var_0 scriptmodelplayanimdeltamotion( "mp_sovereign_malfunctioning_crane_arm" );

    for (;;)
    {
        var_3 playsoundonmovingent( "scn_sov_yellow_crane" );
        wait(var_2);
    }
}

_ID26345()
{
    var_0 = "mp_sovereign_robot_arm_malfunction";
    precachempanim( var_0 );
    common_scripts\utility::_ID35582();
    var_1 = getent( "robot_arm", "targetname" );

    if ( !isdefined( var_1 ) )
        return;

    if ( isdefined( var_1.target ) )
    {
        var_2 = getent( var_1.target, "targetname" );
        var_2 linkto( var_1, "j_anim_001" );
    }

    var_3 = spawn( "script_model", var_1.origin );
    var_3 setmodel( "tag_origin" );
    var_3.angles = var_1.angles;
    var_1 linkto( var_3 );
    var_1._ID11757 = [];
    var_4 = var_1 common_scripts\utility::get_links();

    foreach ( var_6 in var_4 )
    {
        var_7 = common_scripts\utility::_ID15384( var_6, "script_linkname" );
        var_1._ID11757[var_1._ID11757.size] = var_7;
    }

    var_9 = getent( "robot_arm_top", "targetname" );
    var_9 linkto( var_3 );
    var_10 = getent( "robot_arm_track", "targetname" );
    var_10._ID11757 = [];
    var_4 = var_10 common_scripts\utility::get_links();

    foreach ( var_6 in var_4 )
    {
        var_7 = common_scripts\utility::_ID15384( var_6, "script_linkname" );
        var_10._ID11757[var_10._ID11757.size] = var_7;
    }

    var_13 = min( var_1._ID11757[0].origin[0], var_1._ID11757[1].origin[0] );
    var_14 = max( var_1._ID11757[0].origin[0], var_1._ID11757[1].origin[0] );
    var_15 = min( var_10._ID11757[0].origin[1], var_10._ID11757[1].origin[1] );
    var_16 = max( var_10._ID11757[0].origin[1], var_10._ID11757[1].origin[1] );
    var_17 = ( var_13, var_15, 0 );
    var_18 = ( var_14, var_16, 0 );
    var_19 = common_scripts\utility::_ID15386( "robot_arm_corner", "targetname" );
    var_20 = min( var_19[0].origin[0], var_19[1].origin[0] );
    var_21 = max( var_19[0].origin[0], var_19[1].origin[0] );
    var_22 = min( var_19[0].origin[1], var_19[1].origin[1] );
    var_23 = max( var_19[0].origin[1], var_19[1].origin[1] );
    var_24 = ( var_20, var_22, 0 );
    var_25 = ( var_21, var_23, 0 );
    var_1 playloopsound( "scn_sov_single_robot_arm_lp" );
    var_1 scriptmodelplayanimdeltamotion( var_0 );
    var_26 = 80;

    for (;;)
    {
        var_27 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();

        if ( isdefined( var_27 ) )
        {
            var_28 = _ID26346( var_17, var_18, var_24, var_25, var_27.origin );
            var_29 = ( var_28[0], var_28[1], var_1.origin[2] );
            var_30 = ( var_10.origin[0], var_28[1], var_10.origin[2] );
            var_31 = distance( var_1.origin, var_29 );

            if ( var_31 > 10 )
            {
                var_32 = vectortoyaw( var_27.origin - var_1.origin );
                var_33 = var_31 / var_26;
                var_3 moveto( var_29, var_33 );
                var_3 rotateto( ( var_1.angles[0], var_32, var_1.angles[2] ), var_33 / 2 );
                var_10 moveto( var_30, var_33 );
                wait(max( var_33, 6 ));
                continue;
            }
        }

        wait 3;
    }
}

_ID26346( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = var_1 - var_0;
    var_6 = var_3 - var_2;
    var_6 = ( var_6[0], var_6[1], 1 );
    var_7 = ( var_4 - var_2 ) / var_6;
    var_7 = ( clamp( var_7[0], 0, 1 ), clamp( var_7[1], 0, 1 ), 0 );
    return var_5 * var_7 + var_0;
}

_ID30505()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    var_0 = level._ID14086 != "sotf" && level._ID14086 != "infect" && level._ID14086 != "horde";

    if ( !var_0 || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "sovereign_gas", 55, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"KILLSTREAKS_HINTS_SOVEREIGN_GAS" );
    level thread _ID35972();
}

_ID35972()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "sovereign_gas" )
        {
            _ID10111();
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "sovereign_gas", 55 );
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

_ID10111()
{
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "sovereign_gas", 0 );
}

_ID30506()
{
    level._ID19256["sovereign_gas"] = ::_ID33875;
    level._ID19276["sovereign_gas_mp"] = "sovereign_gas";
}

_ID30504()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "sovereign_gas", maps\mp\bots\_bots_ks::bot_killstreak_simple_use, maps\mp\mp_sovereign_events::bot_clear_of_gas );
}

_ID33875( var_0, var_1 )
{
    game["player_holding_level_killstrek"] = 0;
    level notify( "sovereign_gas_killstreak",  self  );
    return 1;
}
