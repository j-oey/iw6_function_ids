// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    level.additional_boss_weapon = ::spawn_weapon_in_boss_area;
    level._ID37190 = 1;
    level.introscreen_line_1 = &"MP_ALIEN_ARMORY_INTRO_LINE_1";
    level._ID18313 = &"MP_ALIEN_ARMORY_INTRO_LINE_2";
    level._ID18314 = &"MP_ALIEN_ARMORY_INTRO_LINE_3";
    level.introscreen_line_4 = &"MP_ALIEN_ARMORY_INTRO_LINE_4";
    level._ID37428 = ::_ID36737;
    maps\mp\alien\_unk1464::alien_mode_enable( "kill_resource", "wave", "airdrop", "lurker", "collectible", "loot", "pillage", "challenge", "outline", "scenes" );
    var_0 = [ "checkpoint", "compound", "facility", "loadingdock", "ending" ];
    maps\mp\alien\_unk1464::alien_area_init( var_0 );
    level._ID37911 = 10;
    level._ID37413 = 1.0;
    level._ID37408 = 1.0;
    level._ID37409 = 1.0;
    level._ID37410 = 1.0;
    level._ID37411 = 1.25;
    level.casual_spawn_multiplier = 1.0;
    level.casual_damage_scalar = 0.45;
    level.casual_health_scalar = 0.45;
    level.casual_reward_scalar = 1.0;
    level.casual_score_scalar = 0.5;
    level._ID17520 = 1;
    level.challenge_registration_func = _ID36644::_ID37875;
    level._ID6850 = _ID36644::_ID36731;
    level._ID37054 = _ID36644::_ID36734;
    level._ID37053 = _ID36644::_ID36733;
    level._ID17519 = 1;
    level._ID17521 = 1;
    level.escape_cycle = 19;
    level._ID37496 = ::_ID37797;
    level._ID37061 = ::_ID37716;
    _ID36643::_ID37636();
    level.level_locker_weapon_pickup_string_func = ::armory_locker_weapon_pickup_string_func;
    level._ID33846 = ::mp_alien_armory_try_use_drone_hive;
    level.achievement_registration_func = _ID36631::_ID37874;
    level._ID38192 = _ID36631::_ID38191;
    level._ID38190 = _ID36631::_ID38189;
    level.custom_alien_death_func = maps\mp\alien\_death::general_alien_custom_death;
    level._ID37052 = ::_ID36730;
    level._ID37055 = ::_ID36736;
    level._ID37249 = ::_ID37529;
    level._ID36717 = [ "iw6_aliendlc11_mp" ];
    level._ID38083 = 0;
    level thread _ID37648();
    game["thermal_vision"] = "mp_alien_town_thermal";
    visionsetthermal( game["thermal_vision"] );
    game["thermal_vision_trinity"] = "mp_alien_thermal_trinity";
    level._ID36925 = common_scripts\utility::array_randomize( [ "p6_", "p5_" ] );
    level._ID36924 = common_scripts\utility::array_randomize( [ "p8_", "p7_" ] );
    level._ID37059 = ::_ID37715;
    level._ID37050 = ::_ID37717;
    level._ID37177 = ::_ID36735;
    level._ID37611 = ::_ID36738;
    level._ID37512 = "mp/alien/alien_armory_intel.csv";
    set_spawn_table();
    level.alien_collectibles_table = "mp/alien/collectibles_armory.csv";
    level._ID37075 = "mp/alien/armory_alien_definition.csv";
    level._ID30720 = "mp/alien/armory_spawn_node_info.csv";
    level.alien_challenge_table = "mp/alien/mp_alien_armory_challenges.csv";
    level.alien_character_cac_table = "mp/alien/alien_cac_presets.csv";
    level._ID36993 = "mp/alien/armory_container_spawn.csv";

    if ( maps\mp\alien\_unk1464::_ID18745() )
        level._ID36763 = 1;
    else
        level._ID36763 = 0.49;

    level._ID36666 = 0.17;
    level._ID38298 = 2500;
    maps\mp\mp_alien_armory_precache::_ID20445();
    maps\createart\mp_alien_armory_art::_ID20445();
    maps\mp\mp_alien_armory_fx::_ID20445();
    maps\mp\agents\alien\alien_spider\_alien_spider::_ID24848();
    _ID36633::_ID17631();
    maps\mp\_load::_ID20445();
    setdvar( "sm_sunShadowScale", "0.5" );
    var_1 = [ "tutorial_hive_01" ];
    maps\mp\alien\_unk1464::add_hive_dependencies( "checkpoint_hive_01", var_1 );
    maps\mp\alien\_unk1464::add_hive_dependencies( "checkpoint_hive_02", var_1 );
    maps\mp\alien\_unk1464::add_hive_dependencies( "checkpoint_hive_03", var_1 );
    maps\mp\alien\_unk1464::add_hive_dependencies( "checkpoint_hive_04", var_1 );
    maps\mp\alien\_unk1464::add_hive_dependencies( "checkpoint_hive_05", var_1 );
    var_2 = [ "compound_hive_01", "compound_hive_02", "compound_hive_03", "compound_hive_04", "compound_hive_06", "compound_hive_07", "compound_hive_08" ];
    maps\mp\alien\_unk1464::add_hive_dependencies( "compound_hive_05", var_2 );
    var_3 = [ "compound_hive_01", "compound_hive_02", "compound_hive_03", "compound_hive_04", "compound_hive_05", "compound_hive_07", "compound_hive_08" ];
    maps\mp\alien\_unk1464::add_hive_dependencies( "compound_hive_06", var_3 );
    var_4 = [ "facility_hive_01", "facility_hive_02", "facility_hive_03", "facility_hive_04", "facility_hive_05", "facility_hive_06" ];
    maps\mp\alien\_unk1464::add_hive_dependencies( "facility_hive_07", var_4 );
    maps\mp\_compass::_ID29184( "compass_map_mp_alien_armory" );
    game["thermal_vision_trinity"] = "mp_alien_thermal_trinity";
    var_5 = 20000;
    var_6 = 40000;
    var_7 = 70000;
    var_8 = 240000;
    maps\mp\alien\_persistence::register_lb_escape_rank( [ 0, var_5, var_6, var_7, var_8 ] );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "woodland";
    var_9 = [];
    var_10 = [ 5, 10 ];
    maps\mp\gametypes\aliens::_ID28965( var_10 );
    maps\mp\gametypes\aliens::setup_blocker_hives( var_9 );
    maps\mp\gametypes\aliens::_ID29054( "bomblocation_14" );
    level._ID29830 = ::_ID29830;
    _ID37876();

    if ( !maps\mp\alien\_unk1464::is_chaos_mode() )
        _ID37459();

    maps\mp\alien\_alien_class_skills_main::_ID20445();
    _ID36642::_ID37036();
    level thread _ID37130();
    level thread maps\mp\mp_alien_armory_fx::_ID37234( "light_snow" );
    level thread maps\mp\mp_alien_armory_fx::fx_snow_watcher();
    level thread debris_fx();
    _ID38090();
    level.end_game_scoreboard_wait_time = 15;
    disconnect_snow_paths();
    move_clip_brush_checkpoint_lakeside();
    move_clip_brush_checkpoint_lakeside_boxes();
    common_scripts\utility::_ID13189( "start_spider_encounter" );
    level thread maps\mp\alien\_lasedstrike_alien::_ID17631();
    level thread maps\mp\alien\_switchblade_alien::_ID17631();
}

_ID37876()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
    {
        maps\mp\gametypes\aliens::_ID37876( ::chaos_init, undefined, undefined, undefined, ::chaos_init, maps\mp\alien\_globallogic::blank );
        maps\mp\gametypes\aliens::_ID37876( maps\mp\alien\_chaos::chaos, undefined, undefined, undefined, maps\mp\alien\_chaos::chaos, maps\mp\alien\_globallogic::blank );
        return;
    }

    maps\mp\gametypes\aliens::_ID37876( ::_ID37164, undefined, undefined, undefined, ::_ID37164, maps\mp\alien\_globallogic::blank );
    maps\mp\gametypes\aliens::_ID37876( ::_ID36724, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37563, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( _ID36640::_ID37880, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37563, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( ::_ID36725, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37563, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( ::_ID36723, 1, undefined, 1, _ID36640::_ID38041, ::_ID37563, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( ::_ID37214, 1, undefined, undefined, ::_ID38039, ::_ID37563 );
    maps\mp\gametypes\aliens::_ID37876( _ID36640::_ID37880, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37565, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( _ID36640::_ID37880, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37565, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( ::_ID36726, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37565, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( _ID36640::_ID37880, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37566, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( ::_ID37934, undefined, undefined, 1, ::_ID38042, ::_ID37565 );
    maps\mp\gametypes\aliens::_ID37876( ::_ID37191, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37569, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( ::_ID37191, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37569, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( ::_ID37191, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37569, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( ::_ID37191, 1, undefined, undefined, _ID36640::_ID38041, ::_ID37569, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( ::_ID37594, 1, undefined, 1, _ID36640::_ID38041, ::_ID37569, _ID36640::_ID36780 );
    maps\mp\gametypes\aliens::_ID37876( ::_ID38153, 1, undefined, undefined, ::_ID38043, ::_ID37570 );
}

_ID37164()
{
    maps\mp\alien\_drill::_ID17725();
    _ID36640::_ID37474();
    maps\mp\agents\alien\alien_spider\_alien_spider::_ID37503();
    maps\mp\agents\alien\_alien_human::_ID37491( "alien_human_armory_animclass" );
    maps\mp\alien\_unk1443::_ID37466( [ "hive" ] );
    _ID36639::_ID37450( [ "spider", "relics" ] );
    maps\mp\alien\_unk1443::_ID37465( [ "challenge", "drill", "team", "personal" ] );
    _ID36639::_ID37449( [ "spider_challenge", "spider_team", "spider_personal", "first_spider" ] );
    setup_special_guns();
}

setup_special_guns()
{
    var_0 = getentarray( "anti_alien_gun", "targetname" );
    common_scripts\utility::_ID3867( var_0, _ID36633::_ID37377 );
}

_ID36737()
{
    var_0 = [];
    var_0["ALIEN_PICKUPS_ARMORY_PICKUP_MAUL"] = &"ALIEN_PICKUPS_ARMORY_PICKUP_MAUL";
    var_0["ALIEN_PICKUPS_ARMORY_PICKUP_PROPANE_TANK"] = &"ALIEN_PICKUPS_ARMORY_PICKUP_PROPANE_TANK";
    var_0["ALIEN_PICKUPS_ARMORY_PICKUP_VKS"] = &"ALIEN_PICKUPS_ARMORY_PICKUP_VKS";
    var_0["ALIEN_PICKUPS_ARMORY_PICKUP_KRISS"] = &"ALIEN_PICKUPS_ARMORY_PICKUP_KRISS";
    var_0["ALIEN_PICKUPS_ARMORY_PICKUP_L115A3"] = &"ALIEN_PICKUPS_ARMORY_PICKUP_L115A3";
    var_0["ALIEN_PICKUPS_ARMORY_PICKUP_KAC"] = &"ALIEN_PICKUPS_ARMORY_PICKUP_KAC";
    var_0["ALIEN_PICKUPS_ARMORY_PICKUP_MTS255"] = &"ALIEN_PICKUPS_ARMORY_PICKUP_MTS255";
    var_0["ALIEN_PICKUPS_ARMORY_PICKUP_VEPR"] = &"ALIEN_PICKUPS_ARMORY_PICKUP_VEPR";
    var_0["ALIEN_PICKUPS_ARMORY_PICKUP_G28"] = &"ALIEN_PICKUPS_ARMORY_PICKUP_G28";
    var_0["ALIEN_PICKUPS_ARMORY_PICKUP_LSAT"] = &"ALIEN_PICKUPS_ARMORY_PICKUP_LSAT";
    var_0["ALIEN_PICKUPS_ARMORY_PICKUP_ARX_160"] = &"ALIEN_PICKUPS_ARMORY_PICKUP_ARX_160";
    var_0["ALIEN_PICKUPS_ARMORY_PICKUP_SVU"] = &"ALIEN_PICKUPS_ARMORY_PICKUP_SVU";
    var_0["ALIEN_PICKUPS_ARMORY_PICKUP_MAVERICK"] = &"ALIEN_PICKUPS_ARMORY_PICKUP_MAVERICK";
    var_0["ALIEN_PICKUPS_ARMORY_PICKUP_KASTET"] = &"ALIEN_PICKUPS_ARMORY_PICKUP_KASTET";
    return var_0;
}

_ID38091()
{
    self scragentsetorientmode( "face angle abs", self.angles );
    thread _ID37786();
    thread _ID38094();
    thread maps\mp\mp_alien_armory_vignettes::_ID37213();
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( "spawn", 0, 1.0, "spawn", "end" );
    self scragentsetgoalpos( self.origin );
    self scragentsetgoalradius( 4096 );
    self waittill( "goal_reached" );
}

_ID38090()
{
    var_0 = getscriptablearray( "snow_debris", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 setscriptablepartstate( 0, 1 );
}

debris_fx()
{
    if ( maps\mp\_utility::_ID18422() )
        level._ID1644["spider_reveal_dense_particles"] = loadfx( "vfx/spider_reveal_particles" );
}

_ID38094()
{
    wait 2.66;
    var_0 = getent( "snow_debris_static", "targetname" );
    var_1 = getscriptablearray( "snow_debris", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 setscriptablepartstate( 0, 0 );

    var_0 delete();

    if ( maps\mp\_utility::_ID18422() )
    {
        var_5 = common_scripts\utility::_ID15384( "spider_blocker_01", "targetname" );
        playfx( level._ID1644["spider_reveal_dense_particles"], var_5.origin, ( 1, 0, 0 ), ( 0, 0, 1 ) );
    }

    wait 0.2;
    common_scripts\utility::exploder( 62 );
    wait 0.3;
    common_scripts\utility::exploder( 61 );
    wait 0.3;
    common_scripts\utility::exploder( 62 );
    wait 0.2;
    common_scripts\utility::exploder( 63 );
    wait 0.5;
    common_scripts\utility::exploder( 61 );
    wait 0.2;
    common_scripts\utility::exploder( 63 );
    wait 0.5;
    common_scripts\utility::exploder( 62 );
    wait 0.5;
    common_scripts\utility::exploder( 61 );
    wait 4;
    common_scripts\utility::exploder( 65 );
    wait 0.3;
    common_scripts\utility::exploder( 64 );
    var_6 = ( -3112, -5074, 674 );
    earthquake( 0.6, 1, var_6, 1600 );
    playrumbleonposition( "grenade_rumble", var_6 );
}

_ID37786()
{
    foreach ( var_1 in level.players )
    {
        if ( common_scripts\utility::_ID13177( "alien_music_playing" ) )
        {
            var_1 stoplocalsound( "mp_suspense_01" );
            var_1 stoplocalsound( "mp_suspense_02" );
            var_1 stoplocalsound( "mp_suspense_03" );
            var_1 stoplocalsound( "mp_suspense_04" );
            var_1 stoplocalsound( "mp_suspense_05" );
            var_1 stoplocalsound( "mp_suspense_06" );
            var_1 stoplocalsound( "mus_alien_newwave" );
            common_scripts\utility::_ID13180( "alien_music_playing" );
        }

        if ( !common_scripts\utility::_ID13177( "exfil_music_playing" ) )
            level thread maps\mp\alien\_music_and_dialog::play_alien_music( "mus_alien_dlc1_spider" );
    }
}

_ID37785()
{
    self endon( "death" );
    self endon( "end_spider_intro_loop" );

    for (;;)
        maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( "spawn", 1, 1.0, "spawn", "end" );
}

_ID37696()
{
    self endon( "death" );
    self endon( "end_spider_intro_loop" );
    self waittill( "damage" );
    self notify( "end_spider_intro_loop" );
}

_ID37697()
{
    self endon( "death" );
    self endon( "end_spider_intro_loop" );
    var_0 = 1000000;

    for (;;)
    {
        foreach ( var_2 in level.players )
        {
            if ( distance2dsquared( var_2.origin, self.origin ) < var_0 )
            {
                self notify( "end_spider_intro_loop" );
                break;
            }
        }

        wait 0.05;
    }
}

_ID38150()
{
    wait 10;
    thread maps\mp\alien\_spawnlogic::_ID30574( "minion" );
    wait 2;
    thread maps\mp\alien\_spawnlogic::_ID30574( "minion" );
    wait 10;
    thread maps\mp\alien\_spawnlogic::_ID30574( "minion" );
}

_ID36724()
{
    level maps\mp\mp_alien_armory_vignettes::_ID20445();
    _ID36640::_ID37880();
    thread maps\mp\mp_alien_armory_vignettes::_ID37382();
}

_ID36725()
{
    _ID36640::_ID37880();
    thread maps\mp\mp_alien_armory_vignettes::_ID37383();
}

_ID36723()
{
    _ID36640::_ID37880();
    thread maps\mp\mp_alien_armory_vignettes::_ID36727();
}

_ID38149()
{
    wait 10.0;
    var_0 = maps\mp\agents\alien\_alien_human::_ID36694( ( -2115, -7073, 661 ), ( 0, 0, 0 ), "mp_body_us_rangers_assault_a_urban", "head_mp_head_a" );
}

_ID37432( var_0, var_1, var_2, var_3 )
{

}

_ID37986()
{
    level endon( "first_spider_fight_skipped" );
    var_0 = common_scripts\utility::_ID15384( "spider_blocker_01", "targetname" );
    var_0._ID37908 = "retreat";
    var_0._ID37907 = 0;
    level._ID38082 = _ID38068( var_0.origin, var_0.angles );
    level._ID38082 _ID38091();
    level._ID38082._ID37909 = var_0;
    level._ID38082 _ID37618();
    level thread _ID38099( 1 );
    level._ID38082 thread maps\mp\agents\alien\alien_spider\_alien_spider::_ID36700( 1 );
    _ID36652();
}

_ID38099( var_0 )
{
    var_1 = "stage_" + var_0;
    var_2 = level._ID2829[level._ID38082.alien_type].attributes[var_1]["cycle_delay"];
    var_3 = "spider_fight_" + var_0 + "_complete";

    if ( var_2 > 0.0 )
        var_4 = common_scripts\utility::_ID35710( var_3, var_2 );
    else
        var_4 = "no_delay";

    if ( isdefined( var_4 ) )
    {
        maps\mp\alien\_spawn_director::_ID31265( level.cycle_count );
        level waittill( var_3 );
        maps\mp\alien\_spawn_director::_ID11539();
    }

    level.cycle_count++;

    if ( var_0 == 1 )
        connect_snow_paths();
}

_ID37618()
{
    var_0 = getent( "spider_collision_00", "targetname" );
    var_0._ID37762 = var_0.origin;
    var_0._ID23034 = var_0.angles;
    var_0.origin = self.origin;
    var_0.angles = self.angles;
    self._ID36983 = var_0;
    var_0 linkto( self );
}

_ID38185()
{
    if ( isdefined( self._ID36983 ) )
    {
        self._ID36983 unlink();
        self._ID36983.origin = self._ID36983._ID37762;
        self._ID36983.angles = self._ID36983._ID23034;
        self._ID36983 = undefined;
    }
}

disconnect_snow_paths()
{
    var_0 = getent( "spider_mound_clip", "targetname" );
    var_0 disconnectpaths();
}

connect_snow_paths()
{
    var_0 = getent( "spider_mound_clip", "targetname" );
    var_0 hide();
    var_0 connectpaths();
    var_0 delete();
}

_ID37214()
{
    var_0 = ( -3191, -5031, 609 );
    level._ID37166 = "first_spider_fight";
    _ID38271();
    var_1 = gettime();
    maps\mp\alien\_unk1443::_ID37894();
    maps\mp\mp_alien_armory_fx::_ID37234( "heavy_snow_no_fog" );
    maps\mp\mp_alien_armory_fx::fx_set_spider_fog_1();
    _ID37986();
    level._ID38082 waittill( "spider_stage_end" );
    level notify( "spider_battle_end" );
    wait 0.1;
    thread maps\mp\mp_alien_armory_vignettes::_ID38087();
    level._ID38082 _ID38185();
    var_2 = gettime() - var_1;
    maps\mp\alien\_unk1443::_ID38222( "first_spider", "spider_battle_time", var_2 );
    _ID36639::_ID36927();
    wait 0.05;
    var_3 = getentarray( "fence_blocker_01_clip", "targetname" );

    foreach ( var_5 in var_3 )
        var_5 delete();

    wait 6;
    level thread _ID37141();
    level._ID37166 = undefined;
    level notify( "spider_fight_1_complete" );
    maps\mp\mp_alien_armory_fx::_ID37234( "medium_snow" );
    clearfog( 3 );
    level thread maps\mp\alien\_drill::_ID32724( var_0 );
    thread maps\mp\mp_alien_armory_vignettes::_ID37832();
    _ID36631::_ID38195( "compound" );
    _ID37376();

    if ( maps\mp\alien\_unk1464::_ID18745() && !issplitscreen() )
        maps\mp\alien\_laststand::_ID15541( level.players[0], 1 );

    foreach ( var_8 in level.players )
        var_8 maps\mp\alien\_persistence::try_award_bonus_pool_token();
}

_ID37141()
{
    wait 3;
    var_0 = getentarray( "script_model", "classname" );

    if ( !isdefined( var_0 ) || var_0.size < 1 )
        return;

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2 ) )
            continue;

        if ( isdefined( var_2.model ) && var_2.model == "alien_spider_egg" )
        {
            playfx( level._ID1644["egg_explosion"], var_2.origin );
            wait 0.1;
            var_2 delete();
        }
    }
}

_ID38271()
{
    var_0 = "waypoint_alien_blocker";
    var_1 = 14;
    var_2 = 14;
    var_3 = 0.75;
    var_4 = ( -3198, -4902, 648 );
    var_5 = 60;
    var_6 = 256;
    var_7 = 100;
    var_8 = maps\mp\alien\_hud::_ID37645( var_0, var_1, var_2, var_3, var_4 );
    var_9 = spawn( "trigger_radius", var_4, 0, var_6, var_7 );
    var_9 thread _ID38290();
    var_9 common_scripts\utility::_ID35637( var_5, "trigger_by_player" );
    var_9 delete();
    var_8 destroy();
}

_ID38290()
{
    self endon( "death" );
    level endon( "game_ended" );
    common_scripts\utility::_ID35582();

    for (;;)
    {
        self waittill( "trigger",  var_0  );

        if ( isplayer( var_0 ) )
            break;
    }

    self notify( "trigger_by_player" );
}

_ID36652()
{
    var_0 = "kill_spider";

    if ( !maps\mp\alien\_unk1464::_ID18745() )
    {
        if ( randomint( 100 ) > 50 )
            var_0 = "kill_eggs";
    }

    maps\mp\alien\_unk1422::activate_new_challenge( var_0 );
}

_ID37376()
{
    var_0 = ( -3175, -4687, 649 );
    var_0 = common_scripts\utility::drop_to_ground( var_0, 32, -128 );
    var_1 = "deployable_currency";
    var_2 = 1;
    var_3 = level.players[randomint( level.players.size )];
    var_3._ID32641 = var_2;
    var_4 = maps\mp\alien\_deployablebox::_ID8395( var_1, var_0, var_3 );
    var_4._ID34651 = var_2;
    var_4.air_dropped = 1;
    wait 0.05;
    var_4 thread maps\mp\alien\_deployablebox::box_setactive( 1 );
}

_ID38039()
{
    level notify( "first_spider_fight_skipped" );

    if ( isdefined( level._ID38082 ) )
        level._ID38082 suicide();

    var_0 = getentarray( "fence_blocker_01", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();

    level.cycle_count++;
    maps\mp\mp_alien_armory_fx::_ID37234( "medium_snow" );
}

_ID36726()
{
    _ID36640::_ID37880();
    thread maps\mp\mp_alien_armory_vignettes::_ID37841();
}

_ID37934()
{
    maps\mp\mp_alien_armory_fx::_ID37234( "medium_snow" );
    maps\mp\mp_alien_armory_vignettes::_ID38085();
    maps\mp\mp_alien_armory_vignettes::_ID38096();
    maps\mp\mp_alien_armory_vignettes::_ID38088();
    maps\mp\mp_alien_armory_fx::_ID37234( "heavy_snow_no_fog" );
    var_0 = getentarray( "blocker_02", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();

    level notify( "factory_blocker_gone" );
    _ID36631::_ID38195( "facility" );

    if ( maps\mp\alien\_unk1464::_ID18745() && !issplitscreen() )
        maps\mp\alien\_laststand::_ID15541( level.players[0], 1 );
}

_ID38153()
{
    var_0 = gettime();
    maps\mp\alien\_unk1443::_ID37894();
    level._ID37166 = "final_spider_fight";
    level notify( "final_spider_fight" );
    var_1 = common_scripts\utility::_ID15384( "spider_ending_01", "targetname" );
    var_1._ID37908 = "retreat";
    var_1._ID37907 = 3;
    maps\mp\mp_alien_armory_vignettes::_ID38086();
    level._ID38082._ID37909 = var_1;
    level._ID38082._ID37156 = common_scripts\utility::_ID15384( "spider_ending_retreat_01", "targetname" );
    level._ID38082 _ID37618();
    level thread _ID38099( 2 );
    var_2 = gettime();
    maps\mp\mp_alien_armory_fx::_ID37234( "heavy_snow_no_fog" );
    maps\mp\mp_alien_armory_fx::fx_set_spider_fog_3();
    level thread force_all_players_in_final_area();
    level._ID38082 maps\mp\agents\alien\alien_spider\_alien_spider::_ID36700( 2 );
    var_3 = gettime() - var_2;
    _ID36631::_ID38195( "final", var_3 );
    level._ID38082 _ID38185();
    level._ID38082 suicide();
    level._ID37166 = undefined;
    level notify( "spider_fight_2_complete" );
    maps\mp\mp_alien_armory_fx::_ID37234( "heavy_snow" );
    clearfog( 3 );
    _ID38211( var_0 );

    if ( !maps\mp\alien\_unk1464::is_casual_mode() )
        set_players_escaped();

    give_players_completion_tokens();
    maps\mp\alien\_unlock::_ID34423( level.players );
    var_4 = gettime() - var_0;
    maps\mp\alien\_unk1443::_ID38222( "final_spider", "spider_battle_time", var_4 );
    _ID36639::_ID36930();
    var_5 = get_win_condition();
    var_6 = maps\mp\alien\_hud::_ID14441( var_5 );
    thread armory_victory_music();
    level maps\mp\_utility::_ID9519( 10, maps\mp\gametypes\aliens::alienendgame, "allies", var_6 );
    thread maps\mp\mp_alien_armory_vignettes::_ID37831();
}

set_players_escaped()
{
    foreach ( var_1 in level.players )
        var_1 maps\mp\alien\_persistence::_ID28529();
}

give_players_completion_tokens()
{
    foreach ( var_1 in level.players )
        var_1 maps\mp\alien\_persistence::award_completion_tokens();
}

get_win_condition()
{
    foreach ( var_1 in level.players )
    {
        if ( maps\mp\alien\_unk1464::_ID18506( var_1._ID18011 ) )
            return "some_escape";
    }

    return "all_escape";
}

armory_victory_music()
{
    wait 2;

    foreach ( var_1 in level.players )
    {
        if ( common_scripts\utility::_ID13177( "alien_music_playing" ) )
        {
            var_1 stoplocalsound( "mp_suspense_01" );
            var_1 stoplocalsound( "mp_suspense_02" );
            var_1 stoplocalsound( "mp_suspense_03" );
            var_1 stoplocalsound( "mp_suspense_04" );
            var_1 stoplocalsound( "mp_suspense_05" );
            var_1 stoplocalsound( "mp_suspense_06" );
            var_1 stoplocalsound( "mus_alien_newwave" );
            var_1 stoplocalsound( "mus_alien_dlc1_archer_exfil" );
            common_scripts\utility::_ID13180( "alien_music_playing" );
        }

        if ( !common_scripts\utility::_ID13177( "exfil_music_playing" ) )
            level thread maps\mp\alien\_music_and_dialog::play_alien_music( "mus_alien_exfil" );
    }
}

_ID38211( var_0 )
{
    var_1 = gettime() - var_0;
    var_2 = _ID37289( var_1 );

    foreach ( var_4 in level.players )
    {
        var_4 maps\mp\alien\_persistence::_ID37609( "escapedRank" + var_2, 1, 1 );
        var_4 maps\mp\alien\_persistence::_ID37609( "hits", 1, 1 );
    }
}

_ID37289( var_0 )
{
    var_1 = 300000;
    var_2 = 600000;
    var_3 = 900000;

    if ( var_0 <= var_1 )
        return 0;
    else if ( var_0 <= var_2 )
        return 1;
    else if ( var_0 <= var_3 )
        return 2;
    else
        return 3;
}

_ID38067( var_0 )
{
    var_0 endon( "death" );
    var_1 = 0.5;

    for (;;)
    {
        if ( var_0 maps\mp\agents\alien\alien_spider\_alien_spider::_ID37357() < var_1 )
            break;

        wait 0.05;
    }

    var_2 = common_scripts\utility::_ID15384( "spider_ending_02", "targetname" );
    var_2._ID37908 = "retreat";
    var_2._ID37907 = 3;
    var_3 = _ID38068( var_2.origin._ID38069.angles );
    var_3 maps\mp\agents\alien\alien_spider\_alien_spider::_ID36700( 3 );
    var_3._ID37909 = var_2;
    var_3 suicide();
}

_ID38068( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        var_2 = var_1;
    else if ( isdefined( level.players ) )
        var_2 = vectortoangles( level.players[0].origin - var_0 );
    else
        var_2 = ( 0, 0, 0 );

    return maps\mp\agents\alien\alien_spider\_alien_spider::_ID36701( var_0, var_2 );
}

_ID38042()
{
    var_0 = getentarray( "blocker_02", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();

    maps\mp\mp_alien_armory_fx::_ID37234( "heavy_snow_no_fog" );
}

_ID38043()
{

}

_ID36735( var_0 )
{
    if ( !maps\mp\alien\_unk1464::is_chaos_mode() )
        _ID36634::_ID36650( var_0 );
}

_ID36738( var_0 )
{
    if ( !maps\mp\alien\_unk1464::is_chaos_mode() )
        _ID36634::_ID37071( var_0 );
}

_ID37191()
{
    _ID36640::_ID37880();

    if ( level.current_hive_name == "facility_hive_01_post" )
        thread maps\mp\mp_alien_armory_vignettes::_ID37041();
}

_ID37594()
{
    var_0 = "queen_break_wall";
    var_1 = 4.5;
    var_2 = 5.0;
    _ID36640::_ID37880();
    wait(randomfloatrange( 1.0, var_2 ));
    level notify( "queen_break_wall" );
    level thread watch_spider_fight_trigger();
    wait(var_1);
    thread maps\mp\mp_alien_armory_vignettes::queen_hole_marker();
}

watch_spider_fight_trigger()
{
    var_0 = getent( "archer_escape", "targetname" );
    var_0 waittill( "trigger" );
    common_scripts\utility::flag_set( "start_spider_encounter" );
}

_ID37459()
{
    _ID36634::_ID37459();
    level._ID38018 = ::_ID38017;
    var_0 = [];
    var_0["container_spawn_2"] = [ "checkpoint_hive_02" ];
    var_0["container_spawn_3"] = [ "checkpoint_hive_04" ];
    var_0["container_spawn_4"] = [ "compound_hive_04" ];
    var_0["container_spawn_5"] = [ "compound_hive_08" ];
    var_0["container_spawn_6"] = [ "compound_hive_03" ];
    level thread _ID36634::_ID36992( var_0 );
}

_ID38017( var_0 )
{
    var_1 = [ "container_spawn_2", "container_spawn_3", "container_spawn_4", "container_spawn_5", "container_spawn_6" ];
    return common_scripts\utility::array_contains( var_1, var_0 );
}

mp_alien_armory_try_use_drone_hive( var_0, var_1, var_2, var_3, var_4 )
{
    maps\mp\alien\_switchblade_alien::_ID33846( var_0, var_1, var_2, var_3, var_4 );
}

_ID37563()
{

}

_ID37565()
{

}

_ID37566()
{

}

_ID37569()
{

}

_ID37570()
{

}

_ID37716()
{
    level.pillageinfo = spawnstruct();
    level.pillageinfo.alienattachment_model = "weapon_alien_muzzlebreak";
    level.pillageinfo._ID37088 = 1000;
    level.pillageinfo._ID37691 = "pb_money_stack_01";
    level.pillageinfo._ID36748 = "has_spotter_scope";
    level.pillageinfo._ID37665 = "mil_ammo_case_1_open";
    level.pillageinfo._ID37220 = "mil_emergency_flare_mp";
    level.pillageinfo._ID36975 = "weapon_baseweapon_clip";
    level.pillageinfo._ID38047 = "weapon_soflam";
    level.pillageinfo._ID37610 = "weapon_knife_iw6";
    level.pillageinfo._ID38164 = "mp_trophy_system_folded_iw6";
    level.pillageinfo._ID38182 = 1;
    level.pillageinfo._ID37133 = 30;
    level.pillageinfo._ID37138 = 12;
    level.pillageinfo._ID37134 = 19;
    level.pillageinfo._ID37135 = 15;
    level.pillageinfo._ID37139 = 5;
    level.pillageinfo._ID37140 = 7;
    level.pillageinfo._ID37136 = 5;
    level.pillageinfo._ID37137 = 2;
    level.pillageinfo.easy_intel = 5;
    level.pillageinfo._ID37668 = 30;
    level.pillageinfo._ID37670 = 15;
    level.pillageinfo._ID37673 = 10;
    level.pillageinfo._ID37669 = 10;
    level.pillageinfo._ID37675 = 10;
    level.pillageinfo._ID37671 = 5;
    level.pillageinfo._ID37674 = 5;
    level.pillageinfo._ID37676 = 5;
    level.pillageinfo._ID37672 = 5;
    level.pillageinfo.medium_intel = 5;
    level.pillageinfo._ID37399 = 30;
    level.pillageinfo._ID37400 = 14;
    level.pillageinfo._ID37401 = 10;
    level.pillageinfo._ID37403 = 10;
    level.pillageinfo._ID37406 = 11;
    level.pillageinfo._ID37404 = 5;
    level.pillageinfo._ID37405 = 5;
    level.pillageinfo._ID37407 = 5;
    level.pillageinfo._ID37402 = 5;
    level.pillageinfo.hard_intel = 5;
    level._ID37051 = ::armory_build_pillageitem_array_func;
    relocate_bad_pillage_spots();
}

relocate_bad_pillage_spots()
{
    var_0 = common_scripts\utility::_ID15386( "pillage_compound_3", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( var_2.origin == ( -1324.8, -3134.5, 687.9 ) )
        {
            var_2.origin = ( -1241, -3234, 674 );
            var_2.angles = ( 1, 0, 0 );
        }
    }
}

armory_build_pillageitem_array_func( var_0 )
{
    level thread _ID36642::build_intel_pillageitem_arrays( var_0 );
}

_ID37715()
{
    thread _ID36633::_ID38078();
    thread _ID36641::_ID37117();
    thread _ID36642::_ID37506();
    thread maps\mp\mp_alien_armory_vignettes::_ID37246();
    thread maps\mp\alien\_achievement::_ID37143( 0 );

    if ( !isdefined( level.setskillsflag ) )
    {
        level.setskillsflag = 1;
        common_scripts\utility::flag_set( "give_player_abilities" );
    }

    thread maps\mp\alien\_alien_class_skills_main::assign_skills();
}

_ID37717( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( _ID37539( var_5 ) )
        var_2 *= 15;

    return var_2;
}

_ID37539( var_0 )
{
    return isdefined( var_0 ) && var_0 == "spider_beam_mp";
}

_ID37130()
{
    level endon( "game_ended" );
    level endon( "easter_egg_conduit_complete" );
    level endon( "easter_egg_conduit_failed" );
    level._ID37131 = 0;
    level._ID37132 = getentarray( "conduit_trig", "targetname" );

    if ( !isdefined( level._ID37132 ) || level._ID37132.size == 0 )
        return;

    var_0 = level._ID37132[randomint( level._ID37132.size )];
    level._ID37132 = sortbydistance( level._ID37132, var_0.origin );
    var_1 = [];

    for ( var_2 = 0; var_2 < 4; var_2++ )
    {
        var_3 = level._ID37132[var_2];
        var_3.health = 1000000;
        var_3._ID17334 = var_2;
        var_3._ID37429 = 0;
        var_3._ID38304 = 0;
        var_3._ID38062 = common_scripts\utility::_ID15386( var_3.target, "targetname" );
        var_1[var_1.size] = var_3;
    }

    var_1 = common_scripts\utility::array_randomize( var_1 );
    common_scripts\utility::_ID3867( var_1, ::_ID37692 );
    var_4 = 0;
    var_5 = 0;

    for (;;)
    {
        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            var_6 = var_1[var_2];

            if ( !var_6._ID37429 )
            {
                playsoundatpos( var_6.origin, "emt_aln_arm_trans_sparks" );

                foreach ( var_8 in var_6._ID38062 )
                {
                    playfx( loadfx( "vfx/moments/alien/easter_egg_conduit_spark" ), var_8.origin );
                    playfx( loadfx( "vfx/moments/alien/fence_lightning_shock" ), var_8.origin );
                }

                var_6._ID38304 = 1;
                wait 6;
                var_6._ID38304 = 0;
                continue;
            }

            wait 6;
        }
    }
}

_ID37692()
{
    level endon( "easter_egg_conduit_complete" );
    level endon( "easter_egg_conduit_failed" );

    for (;;)
    {
        var_0 = spawn( "script_model", self._ID38062[0].origin );
        var_0 setmodel( "tag_origin" );
        var_0.health = 1000000;
        var_0 endon( "death" );
        var_0 setcandamage( 1 );
        var_0 waittill( "damage",  var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10  );

        if ( isdefined( var_2 ) && isplayer( var_2 ) && isdefined( var_5 ) && var_5 == "MOD_EXPLOSIVE" && isdefined( var_9 ) && var_9 == 5 && !isdefined( var_10 ) )
        {
            if ( self._ID38304 )
            {
                if ( level._ID37131 == 0 )
                    level thread _ID37693();

                self._ID37429 = 1;
                level._ID37131++;
            }
            else
                level notify( "easter_egg_conduit_failed" );

            var_0 delete();
            return;
        }

        self.health = self.health + var_1;
    }
}

_ID37693()
{
    level endon( "easter_egg_conduit_complete" );
    level endon( "easter_egg_conduit_failed" );
    wait 24;
    wait 0.5;

    if ( level._ID37131 < 4 )
        level notify( "easter_egg_conduit_failed" );
    else
    {
        level thread _ID36651();
        level notify( "easter_egg_conduit_complete" );
    }
}

_ID36651()
{
    iprintln( &"ALIENS_PATCH_ZAP" );
    level._ID1644["arcade_death"] = loadfx( "vfx/moments/alien/vfx_alien_arcade_death_dlc1" );
    level._ID11234 = 1;
    wait 300;
    level._ID11234 = 0;
}

_ID36730( var_0, var_1, var_2, var_3 )
{
    var_4 = 0;

    if ( self hasweapon( "aliensoflam_mp" ) )
        var_4++;

    if ( self.hasriotshield || self._ID16417 )
        var_4++;

    if ( var_1 == "iw6_aliendlc11_mp" && var_0.size + 1 > var_3 + var_4 )
        return 0;

    return 1;
}

_ID36736( var_0 )
{
    if ( self getcurrentweapon() == "iw6_aliendlc11_mp" )
        return 0;

    return undefined;
}

_ID37648()
{
    level._ID37045 = [ "ocean", "mountain", "tower", "security_gate", "compound", "helipad" ];
    level waittill( "spider_fight_1_complete" );
    level._ID37045 = [];
    wait_for_scene_trig_over( "compound_scripted_spawn" );
    level._ID37045 = [ "rooftop", "helipad", "storage", "factory" ];
    level waittill( "factory_blocker_gone" );
    level._ID37045 = [];
    wait_for_scene_trig_over( "facility_scripted_spawn" );
    level._ID37045 = [ "window" ];
    level waittill( "factory_blocker_gone" );
    level._ID37045 = [];
}

wait_for_scene_trig_over( var_0 )
{
    var_1 = getentarray( "scene_trig", "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3.target ) && var_3.target == var_0 )
        {
            var_3 waittill( "trigger" );
            break;
        }
    }

    wait 25;
}

_ID37529()
{
    var_0 = [ "container_electric_node_01", "checkpoint_electric_trap_node_01b", "electric_trap_node_01", "catwalk_electric_trap", "electric_node_00b" ];

    if ( isdefined( self._ID14209 ) && isdefined( self._ID14209.target ) && common_scripts\utility::array_contains( var_0, self._ID14209.target ) )
        return 1;

    return 0;
}

_ID37714()
{
    self endon( "disconnect" );
    self notify( "spawned" );
    self notify( "end_respawn" );
    self stopshellshock();
    self stoprumble( "damage_heavy" );
    self._ID9087 = undefined;
    maps\mp\_utility::_ID13582( 1 );
    self setclientdvar( "cg_everyoneHearsEveryone", 1 );
    var_0 = self.pers["postGameChallenges"];
    self playerhide();
    maps\mp\_utility::clearkillcamstate();
    self._ID13681 = undefined;
    var_1 = select_best_intermission_point();
    self spawn( var_1.origin, var_1.angles );
    self setdepthoffield( 0, 128, 512, 4000, 6, 1.8 );
    self._ID3349 = spawn( "script_model", self.origin );
    self._ID3349.angles = var_1.angles;
    self._ID3349 setmodel( "tag_origin" );
    self cameralinkto( self._ID3349, "tag_origin" );
    common_scripts\utility::_ID35582();

    if ( !isdefined( var_1.target ) )
        return;

    var_2 = common_scripts\utility::_ID15384( var_1.target, "targetname" );

    for (;;)
    {
        self._ID3349 moveto( var_2.origin, 25 );
        self._ID3349 rotateto( var_2.angles, 25 );
        wait 25;

        if ( !isdefined( var_2.target ) )
            break;

        var_2 = common_scripts\utility::_ID15384( var_2.target, "targetname" );
    }
}

select_best_intermission_point()
{
    var_0 = maps\mp\alien\_unk1464::_ID37267();
    var_1 = common_scripts\utility::_ID15386( var_0 + "_intermission", "script_noteworthy" );

    switch ( var_0 )
    {
        case "loadingdock":
            return get_best_struct_facing_boss( var_1, level._ID38082 );
    }

    if ( isdefined( var_1 ) )
        return common_scripts\utility::_ID25350( var_1 );
}

get_best_struct_facing_boss( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        if ( common_scripts\utility::_ID36376( var_1.origin, var_1.angles, var_4.origin, cos( 35 ) ) )
            var_2[var_2.size] = var_4;
    }

    if ( var_2.size < 1 )
        return common_scripts\utility::_ID25350( var_0 );

    return common_scripts\utility::_ID25350( var_2 );
}

_ID37031( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = spawnstruct();
    var_5.pillage_trigger = spawn( "script_model", self.origin );
    var_5.pillage_trigger setmodel( var_1 );
    var_5.pillage_trigger setcursorhint( "HINT_NOICON" );

    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
        maps\mp\alien\_outline_proto::add_to_outline_pillage_watch_list( var_5.pillage_trigger, 0 );

    var_6 = spawnstruct();
    var_6.type = var_0;

    if ( var_6.type == "explosive" )
    {
        var_6.explosive_type = maps\mp\alien\_pillage::choose_random_explosive_type();
        var_6.explosive_type = "aliensemtex_mp";
        var_5.pillage_trigger setmodel( getweaponmodel( var_6.explosive_type ) );
    }

    var_6.count = var_2;
    var_7 = var_6 _ID37336();
    var_8 = maps\mp\alien\_pillage::get_hintstring_for_item_pickup( var_7 );
    var_5.pillage_trigger sethintstring( var_8 );
    var_5.pillage_trigger makeusable();
    var_5.pillageinfo = spawnstruct();
    var_5.pillageinfo.type = var_0;

    if ( !isdefined( var_4 ) )
        var_4 = 1;

    var_5.pillageinfo.ammo = var_4;

    if ( isdefined( var_3 ) )
        var_5.pillageinfo.item = var_3;

    if ( var_6.type == "explosive" )
        var_5.pillageinfo.item = var_6.explosive_type;

    var_9 = common_scripts\utility::drop_to_ground( var_5.pillage_trigger.origin );
    var_5.pillage_trigger moveto( var_9 + ( 0, 0, 4 ), 0.75 );
    var_5 thread maps\mp\alien\_pillage::_ID23567();
    var_5._ID11491 = 1;
    var_5._ID27956 = 1;
}

_ID37336()
{
    var_0 = self.type;

    switch ( self.type )
    {
        case "grenade":
            var_0 = "aliensemtex_mp";
            break;
        case "explosive":
            var_0 = self.explosive_type;
            break;
        default:
            break;
    }

    return var_0;
}

armory_locker_weapon_pickup_string_func( var_0 )
{
    var_0 = "" + var_0;

    switch ( var_0 )
    {
        case "weapon_kriss_v":
            return &"ALIEN_PICKUPS_ARMORY_LOCKER_KRISS";
        case "weapon_vepr":
            return &"ALIEN_PICKUPS_ARMORY_LOCKER_VEPR";
        case "weapon_maul":
            return &"ALIEN_PICKUPS_ARMORY_LOCKER_MAUL";
        case "weapon_mts_255":
            return &"ALIEN_PICKUPS_ARMORY_LOCKER_MTS255";
        case "weapon_vks":
            return &"ALIEN_PICKUPS_ARMORY_LOCKER_VKS";
        case "weapon_l115a3":
            return &"ALIEN_PICKUPS_ARMORY_LOCKER_L115A3";
        case "weapon_kac_chainsaw":
            return &"ALIEN_PICKUPS_ARMORY_LOCKER_KAC";
        case "weapon_arx_160":
            return &"ALIEN_PICKUPS_ARMORY_LOCKER_ARX_160";
        case "weapon_g28":
            return &"ALIEN_PICKUPS_ARMORY_LOCKER_G28";
        case "weapon_lsat_iw6":
            return &"ALIEN_PICKUPS_ARMORY_LOCKER_LSAT";
        case "weapon_dragunov_svu":
            return &"ALIEN_PICKUPS_ARMORY_LOCKER_SVU";
        case "weapon_kastet":
            return &"ALIEN_PICKUPS_ARMORY_LOCKER_KASTET";
        case "weapon_rm_22":
            return &"ALIEN_PICKUPS_ARMORY_LOCKER_MAVERICK";
    }
}

_ID29830()
{
    if ( !maps\mp\alien\_unk1464::_ID18745() && ( level.cycle_count == 3 || level.cycle_count == 7 || level.cycle_count == 8 || level.cycle_count == 10 ) )
        return 1;

    return 0;
}

force_all_players_in_final_area()
{
    var_0 = common_scripts\utility::_ID15386( "final_battle_player_teleport", "script_noteworthy" );
    var_1 = [];

    foreach ( var_3 in level.players )
    {
        if ( !var_3 should_teleport_player() )
            continue;

        var_1[var_1.size] = var_3;
        var_3 thread do_teleport_messaging();
    }

    if ( var_1.size < 1 )
        return;

    level waittill( "teleport_players_to_final" );

    for (;;)
    {
        var_5 = 0;

        foreach ( var_7, var_3 in var_1 )
        {
            if ( !var_3 should_teleport_player() )
                continue;

            if ( !var_3 maps\mp\alien\_unk1464::_ID18437() && !maps\mp\alien\_unk1464::_ID18506( var_3._ID18764 ) || var_3.sessionstate == "spectator" )
            {
                var_3 thread find_valid_spot_to_teleport( var_0 );
                var_3.being_teleported = 1;
                continue;
            }

            var_5 = 1;
        }

        if ( !var_5 )
            break;

        wait 0.05;
    }

    level thread teleport_dog_tags();
    wait 3;
    var_8 = getent( "final_battle_player_check", "targetname" );

    foreach ( var_3 in level.players )
    {
        if ( isalive( var_3 ) && var_3 istouching( var_8 ) )
            continue;

        var_3 thread find_valid_spot_to_teleport( var_0 );
    }
}

teleport_dog_tags()
{
    var_0 = common_scripts\utility::_ID15386( "final_battle_player_teleport", "script_noteworthy" );
    var_1 = ( 0, 0, 30 );

    foreach ( var_4, var_3 in level.players )
    {
        if ( var_3.sessionstate == "spectator" )
        {
            if ( isdefined( var_3.reviveent ) )
                var_3.reviveent.origin = var_0[var_4].origin;

            if ( isdefined( var_3.reviveiconent ) )
                var_3.reviveiconent.origin = var_0[var_4].origin + var_1;

            var_3.forceteleportorigin = var_0[var_4].origin;
            var_3.forceteleportangles = var_0[var_4].angles;
        }
    }
}

should_teleport_player()
{
    var_0 = getent( "final_battle_player_check", "targetname" );

    if ( isdefined( self.being_teleported ) )
        return 0;

    if ( !isalive( self ) || self istouching( var_0 ) )
        return 0;

    return 1;
}

find_valid_spot_to_teleport( var_0 )
{
    for (;;)
    {
        foreach ( var_2 in var_0 )
        {
            if ( canspawn( var_2.origin ) && !positionwouldtelefrag( var_2.origin ) )
            {
                thread teleport_player_to_final_area( var_2 );
                return;
            }
        }

        wait 0.05;
    }
}

teleport_player_to_final_area( var_0 )
{
    self endon( "disconnect" );
    thread teleport_black_screen();
    wait 1;
    self cancelmantle();
    self dontinterpolate();
    self setorigin( var_0.origin );
    self setplayerangles( var_0.angles );
    self notify( "teleport_finished" );
}

do_teleport_messaging()
{
    self endon( "death" );
    var_0 = getent( "final_battle_player_check", "targetname" );
    self iprintlnbold( &"MP_ALIEN_ARMORY_TELEPORT_PLAYER" );
    wait 1;

    for ( var_1 = 9; var_1 > 0; var_1-- )
    {
        if ( self istouching( var_0 ) )
        {
            wait 1;
            continue;
        }

        self iprintlnbold( var_1 );
        wait 1;
    }

    level notify( "teleport_players_to_final" );
}

teleport_black_screen()
{
    self endon( "disconnect" );
    self.teleport_overlay = newclienthudelem( self );
    self.teleport_overlay.x = 0;
    self.teleport_overlay.y = 0;
    self.teleport_overlay setshader( "black", 640, 480 );
    self.teleport_overlay.alignx = "left";
    self.teleport_overlay.aligny = "top";
    self.teleport_overlay.sort = 1;
    self.teleport_overlay.horzalign = "fullscreen";
    self.teleport_overlay.vertalign = "fullscreen";
    self.teleport_overlay.alpha = 0;
    self.teleport_overlay.foreground = 1;
    self.teleport_overlay fadeovertime( 0.75 );
    self.teleport_overlay.alpha = 1;
    self waittill( "teleport_finished" );
    self.teleport_overlay fadeovertime( 0.75 );
    self.teleport_overlay.alpha = 0;
    wait 1;
    self.teleport_overlay destroy();
}

set_spawn_table()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        set_chaos_spawn_table();
    else
    {
        if ( maps\mp\alien\_unk1464::_ID18426() )
        {
            set_hardcore_extinction_spawn_table();
            return;
        }

        set_regular_extinction_spawn_table();
    }
}

set_chaos_spawn_table()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        switch ( maps\mp\alien\_unk1464::get_chaos_area() )
        {
            case "checkpoint":
                level.alien_cycle_table = "mp/alien/chaos_spawn_armory_checkpoint_sp.csv";
                break;
            case "compound":
                level.alien_cycle_table = "mp/alien/chaos_spawn_armory_compound_sp.csv";
                break;
            case "facility":
                level.alien_cycle_table = "mp/alien/chaos_spawn_armory_facility_sp.csv";
                break;
        }
    }
    else
    {
        switch ( maps\mp\alien\_unk1464::get_chaos_area() )
        {
            case "checkpoint":
                level.alien_cycle_table = "mp/alien/chaos_spawn_armory_checkpoint.csv";
                break;
            case "compound":
                level.alien_cycle_table = "mp/alien/chaos_spawn_armory_compound.csv";
                break;
            case "facility":
                level.alien_cycle_table = "mp/alien/chaos_spawn_armory_facility.csv";
                break;
        }
    }
}

set_regular_extinction_spawn_table()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        level.alien_cycle_table = "mp/alien/cycle_spawn_armory_sp.csv";
    else
        level.alien_cycle_table = "mp/alien/cycle_spawn_armory.csv";
}

chaos_init()
{
    _ID36640::init_hive_locs();
    maps\mp\alien\_chaos::_ID17631();
    register_egg_default_loc();
    set_end_cam_position();
    level thread armory_chaos_nondeterministic_entity_handler();
}

armory_chaos_nondeterministic_entity_handler()
{
    level endon( "game_ended" );
    var_0 = 5;
    wait(var_0);
    open_intro_fence();
    move_patchable_clip_to_compound();
    delete_snow_mound();
    maps\mp\mp_alien_armory_vignettes::_ID38087();
}

delete_snow_mound()
{
    var_0 = getentarray( "snow_debris_static", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
            var_2 delete();
    }

    var_4 = getentarray( "spider_mound_clip", "targetname" );

    foreach ( var_2 in var_4 )
    {
        if ( isdefined( var_2 ) )
        {
            var_2 connectpaths();
            var_2 delete();
        }
    }
}

move_patchable_clip_to_compound()
{
    move_player256x256x8();
    move_player256x256x128();
    move_player512x512x8();
    move_clip512x512x8();
    move_clip256x256x8();
    move_clip256x256x128();
    move_box_models();
}

move_box_models()
{
    var_0 = spawn( "script_model", ( -2665, -5071, 818 ) );
    var_0 setmodel( "clk_crate48x64_snow" );
    var_0.angles = ( 0, 270, 0 );
    var_1 = spawn( "script_model", ( -2674, -5127, 818 ) );
    var_1 setmodel( "clk_crate48x64_snow" );
    var_1.angles = ( 0, 180, 0 );
}

move_player256x256x8()
{
    var_0 = getent( "player256x256x8", "targetname" );
    var_1 = spawn( "script_model", ( -3440, -5001, 860 ) );
    var_1.angles = ( 270, 0, 0 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
}

move_player256x256x128()
{
    var_0 = getent( "player256x256x128", "targetname" );
    var_1 = spawn( "script_model", ( -4084, -5168, 860 ) );
    var_1.angles = ( 270, 270, 0 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
}

move_player512x512x8()
{
    var_0 = getent( "player512x512x8", "targetname" );
    var_1 = spawn( "script_model", ( -3700, -5048, 984 ) );
    var_1.angles = ( 270, 270, 0 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
}

move_clip512x512x8()
{
    var_0 = getent( "player512x512x8", "targetname" );
    var_1 = spawn( "script_model", ( -2828, -5128, 1072 ) );
    var_1.angles = ( 270, 180, 0 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
}

move_clip256x256x8()
{
    var_0 = getent( "player256x256x8", "targetname" );
    var_1 = spawn( "script_model", ( -2692, -5162, 938 ) );
    var_1.angles = ( 270, 90, 0 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
}

move_clip256x256x128()
{
    var_0 = getent( "clip256x256x128", "targetname" );
    var_0.origin = ( -2570, -5172, 938 );
    var_0.angles = ( 270, 0, 0 );
    var_0 disconnectpaths();
}

set_end_cam_position()
{
    var_0 = getentarray( "mp_global_intermission", "classname" );
    var_1 = common_scripts\utility::_ID14934( level.eggs_default_loc, var_0 );

    switch ( maps\mp\alien\_unk1464::get_chaos_area() )
    {
        case "checkpoint":
            var_1.origin = ( -2000, -7020, 848 );
            var_1.angles = ( 15, 110, -8 );
            break;
        case "facility":
            var_1.origin = ( -2000, -7020, 848 );
            var_1.angles = ( 15, 110, -8 );
            break;
    }
}

_ID37797()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
    {
        chaos_player_initial_spawn_loc_override();
        return;
    }
}

chaos_player_initial_spawn_loc_override()
{
    var_0 = [];

    switch ( maps\mp\alien\_unk1464::get_chaos_area() )
    {
        case "compound":
            var_0 = [ ( -3249, -4639, 600 ), ( -3394, -4668, 620 ), ( -3027, -4599, 619 ), ( -2896, -4625, 634 ) ];
            break;
    }

    self._ID13535 = var_0[level.players.size];
    self.forcespawnangles = ( 0, 90, 0 );
}

register_egg_default_loc()
{
    switch ( maps\mp\alien\_unk1464::get_chaos_area() )
    {
        case "checkpoint":
            maps\mp\alien\_chaos::set_egg_default_loc( ( -2576, -6307, -36 ) );
            break;
        case "compound":
            maps\mp\alien\_chaos::set_egg_default_loc( ( -2576, -6307, -36 ) );
            break;
        case "facility":
            maps\mp\alien\_chaos::set_egg_default_loc( ( -2576, -6307, -36 ) );
            break;
    }
}

open_intro_fence()
{
    var_0 = getentarray( "intro_fence", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
            var_2 delete();
    }

    var_4 = getscriptablearray( "intro_fence_script", "targetname" );
    var_4[0] setscriptablepartstate( 0, 3 );
}

set_hardcore_extinction_spawn_table()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        level.alien_cycle_table_hardcore = "mp/alien/cycle_spawn_armory_hardcore_sp.csv";
    else
        level.alien_cycle_table_hardcore = "mp/alien/cycle_spawn_armory_hardcore.csv";
}

move_clip_brush_checkpoint_lakeside()
{
    var_0 = getent( "player512x512x8", "targetname" );
    var_1 = spawn( "script_model", ( -1414, -6356, 650 ) );
    var_1.angles = ( 270, 0, 0 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
}

move_clip_brush_checkpoint_lakeside_boxes()
{
    var_0 = getent( "player128x128x8", "targetname" );
    var_1 = spawn( "script_model", ( -1554, -5942, 892 ) );
    var_1.angles = ( 270.5, 6.19994, -89.9999 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
}

spawn_weapon_in_boss_area()
{
    var_0 = spawnstruct();
    var_0.script_noteworthy = "weapon_iw6_aliendlc15_mp";
    var_0.targetname = "item";
    var_0.origin = ( -2948, 485, 692 );
    var_0.angles = ( 60, 0, 0 );
    var_0.radius = 200;
    return var_0;
}
