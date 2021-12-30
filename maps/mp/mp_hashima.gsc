// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_hashima_precache::_ID20445();
    maps\createart\mp_hashima_art::_ID20445();
    maps\mp\mp_hashima_fx::_ID20445();
    _ID24833();
    level._ID20636 = ::hashimacustomcratefunc;
    level.mapcustomkillstreakfunc = ::_ID16403;
    level._ID20635 = ::_ID16401;
    level.vanguardvisionset = "ac130_enhanced_mp_hashima";
    maps\mp\_load::_ID20445();
    maps\mp\_compass::_ID29184( "compass_map_mp_hashima" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    maps\mp\_utility::_ID28710( "r_diffuseColorScale", 1.75, 1 );
    maps\mp\_utility::_ID28710( "r_specularcolorscale", 3, 8 );
    setdvar( "r_ssaoFadeDepth", 1024 );
    setdvar( "r_reactiveMotionWindAmplitudeScale", 0.3 );
    setdvar( "r_reactiveMotionWindFrequencyScale", 0.5 );
    setdvar( "r_sky_fog_intensity", "1" );
    setdvar( "r_sky_fog_min_angle", "50" );
    setdvar( "r_sky_fog_max_angle", "85" );

    if ( level._ID25139 || level._ID36452 )
        setdvar( "sm_sunShadowScale", "0.7" );

    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "woodland";
    game["axis_outfit"] = "urban";
    common_scripts\utility::_ID13189( "north_target_hit" );
    common_scripts\utility::_ID13189( "south_target_hit" );
    level._ID7635 = undefined;
    level.start_to_end_length = 0.0;
    level.end_to_start_length = 0.0;
    _ID7636();
    level thread use_switch_toggle_multiple();
    level thread _ID16159();
    level thread inithideymodels();
}

inithideymodels()
{
    var_0 = spawn( "script_model", ( -1494, 3177.5, 238.3 ) );
    var_0 setmodel( "com_trashcan_metal_with_trash" );
    var_0.angles = ( 4.51282, 176.769, 100.788 );
    var_1 = spawn( "script_model", ( -1497, 3239.5, 223.3 ) );
    var_1 setmodel( "com_trashcan_metal_with_trash" );
    var_1.angles = ( 353.55, 216.271, -2.19454 );
    var_2 = spawn( "script_model", ( -1452, 3025, 267.5 ) );
    var_2 setmodel( "com_trashcan_metal_with_trash" );
    var_2.angles = ( 2.21881, 22.6731, 83.4648 );
    var_3 = spawn( "script_model", ( -1507, 3218, 237.3 ) );
    var_3 setmodel( "com_trashcan_metallid" );
    var_3.angles = ( 19.0974, 81.1217, 75.5672 );
    var_4 = spawn( "script_model", ( -1442.5, 2973.5, 274.8 ) );
    var_4 setmodel( "com_trashcan_metallid" );
    var_4.angles = ( 3.4983, 102.922, 81.874 );
    var_5 = getent( "clip64x64x64", "targetname" );
    var_6 = spawn( "script_model", ( -1515, 3215, 194 ) );
    var_6 clonebrushmodeltoscriptmodel( var_5 );
    var_7 = getent( "player64x64x256", "targetname" );
    var_8 = spawn( "script_model", ( -1515, 3215, 258 ) );
    var_8 clonebrushmodeltoscriptmodel( var_7 );
    var_9 = getent( "clip32x32x32", "targetname" );
    var_10 = spawn( "script_model", ( -1446.5, 3004.47, 249.201 ) );
    var_10.angles = ( 3.68833, 23.7315, -8.32483 );
    var_10 clonebrushmodeltoscriptmodel( var_9 );
    var_11 = getent( "player32x32x128", "targetname" );
    var_12 = spawn( "script_model", ( -78, -1222, 380 ) );
    var_12 clonebrushmodeltoscriptmodel( var_11 );
    var_13 = getent( "player32x32x128", "targetname" );
    var_14 = spawn( "script_model", ( -78, -1234, 380 ) );
    var_14 clonebrushmodeltoscriptmodel( var_13 );
    var_15 = getent( "player64x64x256", "targetname" );
    var_16 = spawn( "script_model", ( 896, -1330, 404 ) );
    var_16 clonebrushmodeltoscriptmodel( var_15 );
    var_17 = getent( "player32x32x128", "targetname" );
    var_18 = spawn( "script_model", ( 912, -1084, 352 ) );
    var_18 clonebrushmodeltoscriptmodel( var_17 );
    var_19 = getent( "clip64x64x64", "targetname" );
    var_20 = spawn( "script_model", ( 320, 571, 245 ) );
    var_20.angles = ( 0, 330, 0 );
    var_20 clonebrushmodeltoscriptmodel( var_19 );
    var_21 = getent( "player64x64x256", "targetname" );
    var_22 = spawn( "script_model", ( -238, 5466, 180 ) );
    var_22 clonebrushmodeltoscriptmodel( var_21 );
    var_23 = getent( "clip256x256x256", "targetname" );
    var_24 = spawn( "script_model", ( -1960, -860, -17 ) );
    var_24.angles = ( 0, 0, 0 );
    var_24 clonebrushmodeltoscriptmodel( var_23 );
    var_25 = getent( "clip256x256x256", "targetname" );
    var_26 = spawn( "script_model", ( -672, 5664, 577 ) );
    var_26.angles = ( 0, 0, 0 );
    var_26 clonebrushmodeltoscriptmodel( var_25 );
    var_27 = getent( "clip256x256x256", "targetname" );
    var_28 = spawn( "script_model", ( -672, 5664, 845 ) );
    var_28.angles = ( 0, 0, 0 );
    var_28 clonebrushmodeltoscriptmodel( var_27 );
    var_29 = getent( "clip256x256x256", "targetname" );
    var_30 = spawn( "script_model", ( -2344, 5376, 309 ) );
    var_30.angles = ( 0, 0, 0 );
    var_30 clonebrushmodeltoscriptmodel( var_29 );
    var_31 = getent( "clip32x32x128", "targetname" );
    var_32 = spawn( "script_model", ( -118, -1307.03, 380.887 ) );
    var_32.angles = ( 0, 0, -80 );
    var_32 clonebrushmodeltoscriptmodel( var_31 );
    var_33 = spawn( "trigger_radius", ( 1061, -1483, 320 ), 0, 700, 44 );
    var_33.radius = 700;
    var_33.height = 100;
    var_33.angles = ( 0, 0, 0 );
    var_33.targetname = "gryphonDeath";
}

_ID24833()
{
    precachempanim( "mp_hashima_coal_cart_start_idle" );
    precachempanim( "mp_hashima_coal_cart_end_idle" );
    precachempanim( "mp_hashima_coal_cart_move_1" );
    precachempanim( "mp_hashima_coal_cart_move_2" );
    precachempanim( "mp_hashima_coal_cart_start_idle_origin" );
    precachempanim( "mp_hashima_coal_cart_start_idle_origin_scripted" );
    precachempanim( "mp_hashima_coal_cart_end_idle_origin" );
    precachempanim( "mp_hashima_coal_cart_move_1_origin" );
    precachempanim( "mp_hashima_coal_cart_move_2_origin" );
}

_ID16159()
{
    _ID17775();
    _ID26973();
}

_ID17775()
{
    _ID21201();
    waittillframeend;
    level.missile_starts = common_scripts\utility::_ID15386( "missile_start", "targetname" );
}

_ID21201()
{

}

_ID26973()
{
    level endon( "stop_missiles" );
    var_0 = 10;
    var_1 = 20;
    var_2 = 5.0;
    var_3 = -92500.0;
    var_4 = 10000;
    var_5 = 5000;

    for (;;)
    {
        level waittill( "start_missile_strike",  var_6  );
        var_7 = [];

        foreach ( var_9 in level._ID23303 )
        {
            if ( var_6 maps\mp\_utility::isenemy( var_9 ) )
                var_7[var_7.size] = var_9;
        }

        level thread fake_missile_launch( var_7, var_4, var_5, var_6 );
        wait(var_2);
    }
}

fake_missile_launch( var_0, var_1, var_2, var_3 )
{
    var_4 = common_scripts\utility::_ID15386( "missile_start", "targetname" );
    var_4 = common_scripts\utility::array_randomize( var_4 );
    var_5 = 0;

    foreach ( var_7 in var_0 )
    {
        var_8 = var_7.origin;
        var_9 = spawn( "script_model", var_4[var_5].origin );
        var_9 setmodel( "tag_origin" );
        var_9 thread common_scripts\utility::_ID23796( "move_hashima_second_proj_loop1" );
        common_scripts\utility::_ID35582();
        playsoundatpos( var_4[var_5].origin, "hashima_missile_launch" );
        var_5++;
        var_9 thread _ID21569( var_8, var_1, var_2, var_3, var_7 );
        var_9 playsoundonmovingent( "hashima_missile_incoming" );
        wait(randomfloatrange( 0.1, 0.5 ));
    }
}

_ID21569( var_0, var_1, var_2, var_3, var_4 )
{
    playfxontag( level._ID1644["hashima_missile_lens_flare"], self, "tag_origin" );
    var_5 = 4.0;
    self moveto( var_0 + ( 0, 0, var_1 ), var_5, 1.5, 1.5 );
    var_6 = var_0 + ( 0, 0, 40 ) + anglestoforward( var_4.angles ) * 100;
    var_7 = spawn( "script_model", var_6 );
    var_7 linkto( var_4 );
    wait(var_5);
    var_7 thread _ID35533( 5 );

    if ( isdefined( var_4 ) )
        var_0 = var_4.origin;

    stopfxontag( level._ID1644["hashima_missile_lens_flare"], self, "tag_origin" );
    common_scripts\utility::_ID35582();
    playfx( level._ID1644["hashima_missile_turn_obscurer"], self.origin );
    common_scripts\utility::_ID35582();
    self.angles = vectortoangles( var_0 - self.origin );
    self moveto( var_0 + ( 0, 0, var_2 ), 0.5, 0.5, 0.0 );
    wait 0.5;
    var_8 = 1.0;

    if ( isdefined( var_4 ) )
        var_0 = var_4.origin;

    var_6 = self.origin;
    var_9 = bullettrace( var_6, var_0, 0 );
    var_10 = var_9["position"];
    self delete();

    if ( !isdefined( var_3 ) )
        var_11 = magicbullet( "hashima_missiles_mp", var_6, var_10 );
    else
        var_11 = magicbullet( "hashima_missiles_mp", var_6, var_10, var_3 );

    var_11 playsoundonmovingent( "hashima_missile_flyover" );
    var_11._ID19214 = var_7;
    var_11 waittill( "explode",  var_12  );
    playrumbleonposition( "artillery_rumble", var_12 );
    earthquake( 0.3, 1.0, var_12, 20000 );
}

_ID35533( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    wait(var_0);
    self delete();
}

hashimacustomcratefunc()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    if ( !maps\mp\_utility::allowlevelkillstreaks() || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "hashima_missiles", 85, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"KILLSTREAKS_HINTS_HASHIMA_MISSILES" );
    level thread _ID35957();
}

_ID35957()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "hashima_missiles" )
        {
            maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "hashima_missiles", 0 );
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "hashima_missiles", 85 );
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

_ID16403()
{
    level._ID19256["hashima_missiles"] = ::_ID33848;
    level._ID19276["hashima_missiles_mp"] = "hashima_missiles";
}

_ID16401()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "hashima_missiles", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

_ID33848( var_0, var_1 )
{
    level notify( "start_missile_strike",  self  );
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "hashima_missiles", 0 );
    game["player_holding_level_killstrek"] = 0;
    return 1;
}
#using_animtree("animated_props");

_ID7636()
{
    var_0 = common_scripts\utility::_ID15384( "coal_car_spawn", "targetname" );
    var_1 = getent( "coal_car_clip", "targetname" );
    var_2 = spawn( "script_model", var_0.origin );
    var_2 setmodel( "has_coal_mine_cart_anim" );
    var_3 = spawn( "script_model", var_0.origin );
    var_3 setmodel( "generic_prop_raven" );
    common_scripts\utility::_ID35582();
    var_1 linkto( var_3, "tag_origin" );
    var_2._ID7525 = var_1;
    var_2.collision_origin = var_3;
    common_scripts\utility::_ID35582();
    level.start_to_end_length = getanimlength( %mp_hashima_coal_cart_move_1 );
    level.end_to_start_length = getanimlength( %mp_hashima_coal_cart_move_2 );
    var_2 scriptmodelplayanimdeltamotion( "mp_hashima_coal_cart_start_idle" );
    var_2.collision_origin scriptmodelplayanimdeltamotion( "mp_hashima_coal_cart_start_idle_origin_scripted" );
    level._ID7635 = var_2;
    level._ID7635 thread _ID7637();
}

_ID7637()
{
    var_0 = getent( "ai_sight_brush_start", "targetname" );
    var_1 = getent( "ai_sight_brush_end", "targetname" );
    var_0 notsolid();
    var_0 show();
    var_0 setaisightlinevisible( 1 );
    var_1 notsolid();
    var_1 hide();
    var_1 setaisightlinevisible( 0 );
    var_1 connectpaths();
    var_2 = lookupsoundlength( "scn_cargo_button_start" ) / 1000;
    var_3 = self.origin;
    var_4 = self.angles;
    var_5 = self.collision_origin.origin;
    var_6 = self.collision_origin.angles;
    common_scripts\utility::_ID35582();
    self._ID7525 disconnectpaths();

    for (;;)
    {
        common_scripts\utility::_ID35626( "trigger", "reset" );
        var_0 notsolid();
        var_0 hide();
        var_0 connectpaths();
        self playsoundonmovingent( "scn_cargo_button_start" );
        self scriptmodelplayanimdeltamotion( "mp_hashima_coal_cart_move_1" );
        self.collision_origin scriptmodelplayanimdeltamotion( "mp_hashima_coal_cart_move_1_origin" );
        thread disconnect_path_periodic( 1.0 );
        wait(var_2);
        self playloopsound( "scn_cargo_button_loop" );
        wait(level.start_to_end_length - var_2);
        self stoploopsound();
        self playsoundonmovingent( "scn_cargo_button_end" );
        self notify( "stop_disconnect_path_periodic" );
        self scriptmodelplayanimdeltamotion( "mp_hashima_coal_cart_end_idle" );
        self.collision_origin scriptmodelplayanimdeltamotion( "mp_hashima_coal_cart_end_idle_origin" );
        self._ID7525 disconnectpaths();
        var_0 setaisightlinevisible( 0 );
        var_1 show();
        var_1 setaisightlinevisible( 1 );
        common_scripts\utility::_ID35626( "trigger", "reset" );
        self playsoundonmovingent( "scn_cargo_button_start" );
        thread disconnect_path_periodic( 1.0 );
        self scriptmodelplayanimdeltamotion( "mp_hashima_coal_cart_move_2" );
        self.collision_origin scriptmodelplayanimdeltamotion( "mp_hashima_coal_cart_move_2_origin" );
        wait(var_2);
        self playloopsound( "scn_cargo_button_loop" );
        wait(level.end_to_start_length - var_2);
        self stoploopsound();
        self playsoundonmovingent( "scn_cargo_button_end" );
        self scriptmodelclearanim();
        self.collision_origin scriptmodelclearanim();
        self.origin = var_3;
        self.angles = ( 0, 0, 0 );
        self.collision_origin.origin = var_3;
        self.collision_origin.angles = ( 0, 0, 0 );
        self notify( "stop_disconnect_path_periodic" );
        self scriptmodelplayanimdeltamotion( "mp_hashima_coal_cart_start_idle" );
        self.collision_origin scriptmodelplayanimdeltamotion( "mp_hashima_coal_cart_start_idle_origin_scripted" );
        self._ID7525 disconnectpaths();
        var_0 show();
        var_0 setaisightlinevisible( 1 );
        var_1 hide();
        var_1 setaisightlinevisible( 0 );
    }
}

disconnect_path_periodic( var_0 )
{
    self endon( "stop_disconnect_path_periodic" );

    for (;;)
    {
        wait(var_0);
        self._ID7525 disconnectpaths();
    }
}

use_switch_toggle_multiple()
{
    level._ID10686 = [];
    var_0 = common_scripts\utility::_ID15386( "switch_toggle", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::_ID34714 );
}

_ID34714()
{
    var_0 = getentarray( self.target, "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2.script_noteworthy ) )
            continue;

        switch ( var_2.script_noteworthy )
        {
            case "use_trigger":
                if ( !isdefined( self._ID34721 ) )
                    self._ID34721 = [];

                self._ID34721[self._ID34721.size] = var_2;
                continue;
            case "button_toggle":
                if ( !isdefined( self.button_toggles ) )
                    self.button_toggles = [];

                var_3 = self.button_toggles.size;
                self.button_toggles[var_3] = var_2;
                level._ID10686[level._ID10686.size] = var_2;
                continue;
            default:
                continue;
        }
    }

    self._ID22600 = "Turn On";
    self.on_hintstring = "Turn Off";
    self._ID33634 = [];
    self._ID33634[0] = level._ID7635;
    self._ID22600 = &"MP_HASHIMA_TRAIN_CAR";
    self.on_hintstring = &"MP_HASHIMA_TRAIN_CAR";
    _ID34715();
}

_ID34715()
{
    var_0 = spawnstruct();
    var_1 = getent( "buzzer_sound_loc", "targetname" );

    for (;;)
    {
        foreach ( var_3 in self._ID34721 )
        {
            var_3 sethintstring( self._ID22600 );
            var_3 thread _ID22299( var_0 );
        }

        thread _ID24731( 1 );
        var_0 waittill( "trigger",  var_5  );

        if ( isdefined( self.button_toggles ) )
            self.button_toggles[0] playsound( "scn_cargo_button_push" );

        var_1 playsound( "scn_cargo_button_buzzer" );

        foreach ( var_3 in self._ID34721 )
            var_3 sethintstring( "" );

        thread _ID24731( 0 );

        foreach ( var_9 in self._ID33634 )
            var_9 notify( "trigger",  var_5  );

        wait(level.start_to_end_length);

        foreach ( var_3 in self._ID34721 )
        {
            var_3 sethintstring( self.on_hintstring );
            var_3 thread _ID22299( var_0 );
        }

        thread _ID24731( 1 );
        var_0 waittill( "trigger",  var_5  );

        if ( isdefined( self.button_toggles ) )
            self.button_toggles[0] playsound( "scn_cargo_button_push" );

        var_1 playsound( "scn_cargo_button_buzzer" );

        foreach ( var_3 in self._ID34721 )
            var_3 sethintstring( "" );

        thread _ID24731( 0 );

        if ( isdefined( self._ID19901 ) )
        {
            foreach ( var_16 in self._ID19901 )
                var_16 setmodel( "weapon_light_stick_tactical_red" );
        }

        foreach ( var_9 in self._ID33634 )
            var_9 notify( "reset" );

        wait(level.end_to_start_length);
    }
}

_ID22299( var_0 )
{
    self waittill( "trigger" );
    var_0 notify( "trigger" );
}

_ID24731( var_0 )
{
    if ( isdefined( self.button_toggles ) )
    {
        foreach ( var_2 in self.button_toggles )
            var_2 _ID28255( "mp_frag_button", var_0 );
    }
}

_ID28255( var_0, var_1 )
{
    if ( var_1 )
        var_2 = "mp_frag_button_on_green";
    else
        var_2 = "mp_frag_button_on";

    self._ID17490 = var_1;
    self setmodel( var_2 );
}

hashima_nukedeathvision()
{
    level._ID22379 = "aftermath_mp_hashima";
    setexpfog( 512, 4097, 0.578828, 0.802656, 1, 0.75, 0.75, 5, 0.382813, 0.350569, 0.293091, 3, ( 1, -0.109979, 0.267867 ), 0, 80, 1, 0.179688, 26, 180 );
    visionsetnaked( level._ID22379, 5 );
    visionsetpain( level._ID22379 );
}
