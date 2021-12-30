// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    if ( getdvar( "mapname" ) == "mp_background" )
        return;

    maps\mp\alien\_globallogic::_ID17631();
    maps\mp\gametypes\_callbacksetup::_ID29168();
    maps\mp\alien\_globallogic::_ID29168();
    level.customprematchperiod = ::alien_customprematchperiod;

    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = ::initializematchrules;
        [[ level.initializematchrules ]]();
        level thread maps\mp\_utility::_ID25726();
    }
    else
    {
        maps\mp\_utility::_ID25715( level._ID14086, 0, 0, 9 );
        maps\mp\_utility::_ID25718( level._ID14086, 0 );
        maps\mp\_utility::_ID25717( level._ID14086, 500 );
        maps\mp\_utility::_ID25714( level._ID14086, 1 );
        maps\mp\_utility::_ID25724( level._ID14086, 1 );
        maps\mp\_utility::_ID25712( level._ID14086, 0 );
        maps\mp\_utility::_ID25706( level._ID14086, 0 );
        level._ID20676 = 0;
        level._ID20680 = 0;
        level._ID24880 = 0;
    }

    if ( level._ID20676 || level._ID20680 )
        level._ID21286 = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    level._ID32653 = 1;
    level.getteamassignment = ::getteamassignment;
    level._ID22892 = ::_ID22892;
    level._ID19259 = ::_ID19259;
    level._ID22905 = ::_ID22905;
    level._ID22902 = ::_ID22902;
    level.getspawnpoint = ::getspawnpoint;
    level._ID11605 = ::alienendgame;
    level._ID13522 = ::_ID2851;
    level._ID22869 = maps\mp\alien\_death::_ID22869;
    level._ID22886 = maps\mp\alien\_death::_ID22886;
    level._ID22913 = ::_ID22913;
    level._ID22924 = ::_ID22924;
    level.bypassclasschoicefunc = ::bypassclasschoicefunc;
    level.callbackplayerlaststand = maps\mp\alien\_laststand::callback_playerlaststandalien;
    level.callbackplayerdamage = maps\mp\alien\_damage::callback_alienplayerdamage;
    level.aliens_make_entity_sentient_func = ::alien_make_entity_sentient;
    level.aliens_give_currency_func = maps\mp\alien\_persistence::_ID15551;
    level._ID12498 = 0.1;
    level._ID29789 = 0.1;
    level.armorpiercingmod = 0.2;
    level.custom_giveloadout = ::custom_giveloadout;
    level._ID5889 = ::_ID5889;
    level._ID25669 = 2;
    level.damagefeedbacknosound = 1;
    level.ischaosmode = getdvarint( "scr_chaos_mode", 0 );
    level.hardcoremode = getdvarint( "scr_aliens_hardcore" );
    level._ID37910 = getdvarint( "scr_aliens_ricochet" );
    level._ID37448 = getdvarint( "scr_aliens_infinite" );
    level.casualmode = getdvarint( "scr_aliens_casual" );
    level.playermeleestunregentime = 4000;
    setdvarifuninitialized( "alien_cover_node_retreat", 0 );
    setdvarifuninitialized( "alien_retreat_towards_spawn", 1 );

    if ( maps\mp\alien\_unk1464::_ID18426() )
        setomnvar( "ui_aliens_hardcore", 1 );

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
    {
        setomnvar( "ui_alien_chaos", 1 );
        maps\mp\alien\_chaos::set_chaos_area();
    }

    if ( !isdefined( level._ID37911 ) )
        level._ID37911 = 25;

    level._ID15177 = ::getnodearray;
    level._ID22099 = 0;
    level._ID22098 = 0;
    level.maxalienattackerdifficultyvalue = 10.0;
    setalienloadout();
    healthregeninit();
    maps\mp\agents\alien\_alien_anim_utils::initalienanims();
    level thread _ID22877();
    level thread maps\mp\alien\_music_and_dialog::_ID17631();
    level thread _ID36637::_ID38079();
    level thread _ID36637::_ID37100();
    level thread maps\mp\alien\_autosentry_alien::_ID17631();
    maps\mp\alien\_outline_proto::outline_init();
    _ID36638::_ID17631();
    common_scripts\utility::_ID3867( getentarray( "misc_turret", "classname" ), maps\mp\alien\_trap::_ID34034 );
}

healthregeninit()
{
    level.healthregendisabled = 0;
    level._ID16473 = getdvarfloat( "alien_playerHealthRegenCap", 1.0 );
}

getteamassignment()
{
    return "allies";
}

initializematchrules()
{
    maps\mp\_utility::_ID28682();
    setdynamicdvar( "scr_aliens_roundswitch", 0 );
    maps\mp\_utility::_ID25715( "aliens", 0, 0, 9 );
    setdynamicdvar( "scr_aliens_roundlimit", 1 );
    maps\mp\_utility::_ID25714( "aliens", 1 );
    setdynamicdvar( "scr_aliens_winlimit", 1 );
    maps\mp\_utility::_ID25724( "aliens", 1 );
    setdynamicdvar( "scr_aliens_halftime", 0 );
    maps\mp\_utility::_ID25706( "aliens", 0 );
    setdynamicdvar( "scr_aliens_promode", 0 );
}

_ID22892()
{
    precachestring( &"ALIEN_COLLECTIBLES_SELF_REVIVED" );
    precachestring( &"ALIEN_COLLECTIBLES_PLANT_BOMB" );
    precachestring( &"ALIEN_COLLECTIBLES_NO_BOMB" );
    precachestring( &"ALIEN_COLLECTIBLES_GO_PLANT_BOMB" );
    precachestring( &"ALIEN_COLLECTIBLES_PICKUP_BOMB" );
    precachestring( &"ALIEN_COLLECTIBLES_REPAIR_DRILL" );
    precachestring( &"ALIEN_COLLECTIBLES_ACTIVATE_NUKE" );
    precachestring( &"ALIEN_COLLECTIBLES_COUNTDOWN_NUKE" );
    precachestring( &"ALIEN_COLLECTIBLES_DRILL_DESTROYED" );
    level._ID1644["alien_teleport"] = loadfx( "vfx/test/vfx_alien_teleport" );
    level._ID1644["alien_teleport_dist"] = loadfx( "vfx/test/vfx_alien_teleport_dist" );
    level._ID1644["Riotshield_fire"] = loadfx( "vfx/gameplay/alien/vfx_alien_on_fire" );
    level._ID1644["arcade_death"] = loadfx( "vfx/moments/alien/vfx_alien_arcade_death" );
    maps\mp\agents\alien\_alien_elite::_ID20107();
    maps\mp\agents\alien\_alien_spitter::_ID20113();
    level._ID1644["drone_ground_spawn"] = loadfx( "vfx/gameplay/alien/vfx_alien_drone_ground_spawn" );
    level._ID1644["deployablebox_crate_destroy"] = loadfx( "vfx/test/vfx_alien_teleport" );
    maps\mp\agents\alien\_alien_minion::_ID20105();
    level._ID1644["bomb_impact"] = loadfx( "vfx/ambient/sparks/electrical_sparks" );
    level._ID1644["shield_impact"] = loadfx( "fx/impacts/large_metalhit_1" );
    level._ID1644["airdrop_crate_destroy"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ims_explosion" );
    level._ID1644["melee_blood"] = loadfx( "vfx/gameplay/impacts/small/impact_alien_flesh_hit_b_fatal" );
    precacheturret( "turret_minigun_alien" );

    if ( maps\mp\alien\_unk1464::alien_mode_has( "airdrop" ) )
    {
        precachevehicle( "littlebird_alien" );
        precachevehicle( "nh90_alien" );
        precachempanim( "alien_drill_enter" );
        precachempanim( "alien_drill_loop" );
        precachempanim( "alien_drill_end" );
        precachempanim( "alien_drill_operate_enter" );
        precachempanim( "alien_drill_nonoperate" );
        precachempanim( "alien_drill_operate_end" );
        precachempanim( "alien_drill_attack_drill_F_enter" );
        precachempanim( "alien_drill_attack_drill_F_exit" );
        precachempanim( "alien_drill_attack_drill_F_loop" );
        precachempanim( "alien_drill_attack_drill_L_enter" );
        precachempanim( "alien_drill_attack_drill_L_exit" );
        precachempanim( "alien_drill_attack_drill_L_loop" );
        precachempanim( "alien_drill_attack_drill_R_enter" );
        precachempanim( "alien_drill_attack_drill_R_exit" );
        precachempanim( "alien_drill_attack_drill_R_loop" );
        precachempanim( "alien_goon_drill_attack_drill_F_enter" );
        precachempanim( "alien_goon_drill_attack_drill_F_loop" );
        precachempanim( "alien_goon_drill_attack_drill_F_exit" );
        precachempanim( "alien_goon_drill_attack_drill_R_enter" );
        precachempanim( "alien_goon_drill_attack_drill_R_loop" );
        precachempanim( "alien_goon_drill_attack_drill_R_exit" );
        precachempanim( "alien_goon_drill_attack_drill_L_enter" );
        precachempanim( "alien_goon_drill_attack_drill_L_loop" );
        precachempanim( "alien_goon_drill_attack_drill_L_exit" );
        precachempanim( "alien_sentry_attack_sentry_front_enter" );
        precachempanim( "alien_sentry_attack_sentry_front_exit" );
        precachempanim( "alien_sentry_attack_sentry_front_loop" );
        precachempanim( "alien_sentry_attack_sentry_side_r_enter" );
        precachempanim( "alien_sentry_attack_sentry_side_r_exit" );
        precachempanim( "alien_sentry_attack_sentry_side_r_loop" );
        precachempanim( "alien_sentry_attack_sentry_side_l_enter" );
        precachempanim( "alien_sentry_attack_sentry_side_l_exit" );
        precachempanim( "alien_sentry_attack_sentry_side_l_loop" );
        precachempanim( "alien_goon_sentry_attack_sentry_F_enter" );
        precachempanim( "alien_goon_sentry_attack_sentry_F_exit" );
        precachempanim( "alien_goon_sentry_attack_sentry_F_loop" );
        precachempanim( "alien_goon_sentry_attack_sentry_L_enter" );
        precachempanim( "alien_goon_sentry_attack_sentry_L_exit" );
        precachempanim( "alien_goon_sentry_attack_sentry_L_loop" );
        precachempanim( "alien_goon_sentry_attack_sentry_R_enter" );
        precachempanim( "alien_goon_sentry_attack_sentry_R_exit" );
        precachempanim( "alien_goon_sentry_attack_sentry_R_loop" );
    }

    if ( maps\mp\alien\_intro_sequence::_ID18262() )
        maps\mp\alien\_intro_sequence::intro_sequence_precache();
}

_ID22905()
{
    if ( isdefined( level._ID37060 ) )
        [[ level._ID37060 ]]();

    setnojiptime( 1 );
    setclientnamemode( "auto_change" );
    thread maps\mp\alien\_unk1464::_ID21744();
    level._ID10157 = 1;
    level.damagelistsize = 20;
    maps\mp\_utility::_ID28804( "allies", &"ALIEN_OBJECTIVES_ALIENS" );
    maps\mp\_utility::_ID28804( "axis", &"ALIEN_OBJECTIVES_ALIENS" );

    if ( level.splitscreen )
    {
        maps\mp\_utility::_ID28803( "allies", &"ALIEN_OBJECTIVES_ALIENS" );
        maps\mp\_utility::_ID28803( "axis", &"ALIEN_OBJECTIVES_ALIENS" );
    }
    else
    {
        maps\mp\_utility::_ID28803( "allies", &"ALIEN_OBJECTIVES_ALIENS_SCORE" );
        maps\mp\_utility::_ID28803( "axis", &"ALIEN_OBJECTIVES_ALIENS_SCORE" );
    }

    maps\mp\_utility::setobjectivehinttext( "allies", &"ALIEN_OBJECTIVES_ALIENS_HINT" );
    maps\mp\_utility::setobjectivehinttext( "axis", &"ALIEN_OBJECTIVES_ALIENS_HINT" );
    maps\mp\alien\_persistence::bbdata_init();
    maps\mp\alien\_persistence::_ID25417();
    maps\mp\alien\_persistence::_ID37879();
    maps\mp\alien\_progression::_ID20445();
    init_threatbiasgroups();

    if ( maps\mp\alien\_unk1464::alien_mode_has( "collectible" ) )
        maps\mp\alien\_collectibles::_ID24809();

    _ID36637::_ID24809();

    if ( maps\mp\alien\_unk1464::alien_mode_has( "scenes" ) )
        maps\mp\alien\_spawnlogic::alien_scene_init();

    maps\mp\alien\_alien_fx::_ID20445();
    maps\mp\alien\_spawnlogic::alien_health_per_player_init();
    initspawns();
    var_0[0] = level._ID14086;
    maps\mp\gametypes\_gameobjects::_ID20445( var_0 );
    level.current_cycle_num = 0;
    level.num_hive_destroyed = 0;
    level thread maps\mp\alien\_trap::_ID33474();
    maps\mp\alien\_unk1443::init_gamescore();
    level._ID31029 = 0;
    level._ID14085["spectatetype"]._ID34844 = 1;

    if ( should_enable_pillage() )
        thread maps\mp\alien\_pillage::pillage_init();

    if ( maps\mp\alien\_unk1464::alien_mode_has( "challenge" ) )
        maps\mp\alien\_unk1422::_ID17697();

    maps\mp\alien\_unlock::_ID17861();
    maps\mp\alien\_prestige::_ID17814();
    maps\mp\alien\_hud::_ID17631();
    level._ID20386 = "objective";

    if ( level.splitscreen )
        level.lowertextfontsize = 1.35;

    if ( !level.console )
        level.lowertextfontsize = 1;

    level._ID32682["fftype"]._ID34844 = 1;
    maps\mp\alien\_death::_ID19206();
    level thread _ID16166();
    level thread maps\mp\alien\_trap::_ID11233();
    level._ID36474 = getdvarint( "scr_aliens_xpscale" );
    level._ID36474 = min( level._ID36474, 4 );
    level._ID36474 = max( level._ID36474, 0 );
    _ID36632::_ID38118();
    _ID36638::_ID22905();
    level thread _ID37922();
}

should_enable_pillage()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        return 0;

    return maps\mp\alien\_unk1464::alien_mode_has( "pillage" );
}

_ID16166()
{
    wait 5;
    _ID37394();
    level notify( "spawn_nondeterministic_entities" );
}

_ID37394()
{
    if ( maps\mp\alien\_unk1464::alien_mode_has( "collectible" ) )
        maps\mp\alien\_collectibles::_ID24774();

    if ( !maps\mp\alien\_unk1464::alien_mode_has( "nogame" ) && maps\mp\alien\_unk1464::alien_mode_has( "wave" ) && maps\mp\alien\_spawnlogic::_ID34712() )
    {
        _ID36640::_ID25954( level._ID25988 );
        level._ID25988 = undefined;
    }

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        maps\mp\alien\_chaos::create_alien_eggs();
}

spawnallypet( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    wait 0.05;
    var_6 = "wave " + var_0;

    for ( var_7 = 0; var_7 < var_1; var_7++ )
    {
        var_8 = var_2;

        if ( var_6 == "wave elite" )
        {
            var_9 = bullettrace( var_2 + ( 0, 0, 128 ), var_2 + ( 0, 0, -128 ), 0 );

            if ( var_9["fraction"] == 0 || var_9["fraction"] == 1 )
                continue;

            var_8 = var_9["position"];
        }

        var_10 = var_4;
        var_11 = var_8;
        var_12 = addalienagent( "allies", var_11, var_10, var_6 );
        var_12.pet = 1;
        var_12.owner = var_3;
        var_12._ID23491 = 1024;
        var_12.threatbias = -800;

        if ( var_0 == "goon" )
        {
            var_12.maxhealth = int( 100 * level.alien_health_per_player_scalar[level.players.size] );
            var_12.health = int( 100 * level.alien_health_per_player_scalar[level.players.size] );
        }
        else if ( var_0 == "brute" )
        {
            var_12.maxhealth = int( 200 * level.alien_health_per_player_scalar[level.players.size] );
            var_12.health = int( 200 * level.alien_health_per_player_scalar[level.players.size] );
        }
        else if ( var_0 == "spitter" )
        {
            var_12.maxhealth = int( 150 * level.alien_health_per_player_scalar[level.players.size] );
            var_12.health = int( 150 * level.alien_health_per_player_scalar[level.players.size] );
        }
        else if ( var_0 == "locust" )
        {
            var_12.maxhealth = int( 250 * level.alien_health_per_player_scalar[level.players.size] );
            var_12.health = int( 250 * level.alien_health_per_player_scalar[level.players.size] );
        }
        else if ( var_0 == "elite" )
        {
            var_12.maxhealth = int( 350 * level.alien_health_per_player_scalar[level.players.size] );
            var_12.health = int( 350 * level.alien_health_per_player_scalar[level.players.size] );
        }

        if ( maps\mp\alien\_unk1464::_ID18506( var_5 ) )
        {
            var_12.maxhealth = int( var_12.maxhealth * 1.25 );
            var_12.health = int( var_12.maxhealth * 1.25 );
        }

        var_12 maps\mp\alien\_unk1464::_ID28196( 0.5, 0.0 );

        if ( var_3 maps\mp\alien\_persistence::is_upgrade_enabled( "master_scavenger_upgrade" ) )
        {
            var_12.upgraded = 1;
            maps\mp\alien\_outline_proto::enable_outline( var_12, 2, 0 );
        }
        else
            maps\mp\alien\_outline_proto::enable_outline( var_12, 3, 0 );

        var_12 setscriptablepartstate( "body", "pet" );

        if ( isdefined( self._ID12146 ) )
            self._ID12146 destroy();

        var_12 thread _ID36711( var_5 );
        var_12 thread kill_alien_on_owner_disconnect( var_3 );
    }
}

_ID36711( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    var_1 = 180;

    if ( maps\mp\alien\_unk1464::_ID18506( var_0 ) )
        var_1 *= 1.25;

    wait(var_1);
    playfx( level._ID1644["alien_minion_explode"], self.origin + ( 0, 0, 32 ) );
    self suicide();
}

kill_alien_on_owner_disconnect( var_0 )
{
    self endon( "death" );
    var_0 waittill( "disconnect" );
    playfx( level._ID1644["alien_minion_explode"], self.origin + ( 0, 0, 32 ) );
    self suicide();
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );

        if ( !isai( var_0 ) )
        {
            if ( maps\mp\alien\_unk1464::is_chaos_mode() )
                maps\mp\alien\_chaos::chaos_onplayerconnect( var_0 );

            var_0 _ID36632::_ID37745();

            if ( isdefined( var_0.connecttime ) )
                var_0.connect_time = var_0.connecttime;
            else
                var_0.connect_time = gettime();

            var_0 maps\mp\alien\_prestige::_ID17805();
            var_0 maps\mp\alien\_persistence::player_persistence_init();
            var_0 thread maps\mp\alien\_unk1464::weapon_change_monitor();
            var_0 thread _ID32916();
            var_0 thread _ID24142();
            var_0 maps\mp\alien\_hud::init_player_hud_onconnect();
            var_0 maps\mp\alien\_unk1443::init_player_score();
            var_0 thread maps\mp\alien\_progression::_ID24323();
            var_0 maps\mp\alien\_achievement::_ID17800();
            var_0 maps\mp\alien\_unlock::init_player_unlock();
            var_0 thread maps\mp\alien\_persistence::_ID37788();
            var_0 _ID37497();

            if ( !maps\mp\alien\_unk1464::is_casual_mode() )
                var_0 setclientomnvar( "allow_write_leaderboards", 1 );
            else
                var_0 setclientomnvar( "allow_write_leaderboards", 0 );

            if ( common_scripts\utility::flag_exist( "hives_cleared" ) && common_scripts\utility::_ID13177( "hives_cleared" ) )
            {
                var_0.threatbias = 100000;
                var_0 thread maps\mp\alien\_persistence::_ID28395( "escaping" );
            }
            else if ( !isdefined( level.cycle_count ) || level.cycle_count < 1 )
                var_0 thread maps\mp\alien\_persistence::_ID28395( "pregame" );
            else if ( isdefined( level.cycle_count ) && level.cycle_count == 1 )
                var_0 thread maps\mp\alien\_persistence::_ID28395( "prehive" );
            else
                var_0 thread maps\mp\alien\_persistence::_ID28395( "progressing" );

            if ( maps\mp\alien\_unk1464::alien_mode_has( "kill_resource" ) )
                var_0 thread _ID24140();

            var_1 = _ID37286();

            if ( var_1 > 0 )
                var_0 maps\mp\alien\_persistence::give_player_points( var_1 );

            var_0 _ID26143();

            if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
                var_0 thread maps\mp\alien\_outline_proto::_ID23090();

            if ( maps\mp\alien\_unk1464::alien_mode_has( "challenge" ) )
            {
                if ( maps\mp\alien\_unk1422::current_challenge_exist() && maps\mp\alien\_unk1464::alien_mode_has( "challenge" ) )
                    var_0 thread maps\mp\alien\_unk1422::_ID16049();
            }

            var_0 thread _ID30949();
            var_0 thread _ID11431();
            var_0 thread _ID21375();

            if ( common_scripts\utility::flag_exist( "drill_drilling" ) )
                var_0 thread maps\mp\alien\_drill::check_for_player_near_hive_with_drill();

            var_0 thread maps\mp\alien\_hud::_ID18145();

            if ( maps\mp\alien\_unk1464::_ID18506( level._ID18304 ) )
                var_0 thread _ID24123();

            var_0 _ID36638::_ID22877();
        }
    }
}

_ID37497()
{
    if ( isdefined( level._ID37496 ) )
        self [[ level._ID37496 ]]();
}

_ID37286()
{
    if ( isdefined( level._ID37430 ) )
        return [[ level._ID37430 ]]();
    else
        return _ID37079();
}

_ID37079()
{
    var_0 = 1;

    if ( maps\mp\alien\_unk1464::_ID18426() )
        var_1 = 0;
    else
        var_1 = max( 0, level.num_hive_destroyed - var_0 );

    var_2 = maps\mp\alien\_unk1422::get_num_challenge_completed();
    return var_1 + var_2;
}

init_threatbiasgroups()
{
    createthreatbiasgroup( "players" );
    createthreatbiasgroup( "hive_heli" );
    createthreatbiasgroup( "other_aliens" );
    createthreatbiasgroup( "spitters" );
    createthreatbiasgroup( "dontattackdrill" );
    createthreatbiasgroup( "drill" );
    setthreatbias( "hive_heli", "spitters", 10000 );
    setignoremegroup( "hive_heli", "other_aliens" );
    setignoremegroup( "drill", "dontattackdrill" );
    setignoremegroup( "hive_heli", "dontattackdrill" );
}

_ID32916()
{
    level endon( "game_ended" );

    while ( !threatbiasgroupexists( "players" ) )
        wait 0.05;

    self setthreatbiasgroup( "players" );
}

_ID24123()
{
    self endon( "disconnect" );
    self notify( "intro_done" );
    self waittill( "spawned" );
    self.pers["hotjoined"] = 1;
    self._ID18316 fadeovertime( 1 );
    wait 1;
    self._ID18316 destroy();
    var_0 = maps\mp\alien\_spawnlogic::get_alive_enemies();

    if ( !isdefined( var_0 ) || var_0.size < 1 )
        return;

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && maps\mp\alien\_unk1464::_ID18506( var_2.pet ) )
            maps\mp\alien\_outline_proto::enable_outline_for_player( var_2, self, 3, 0, "high" );
    }
}

_ID24142()
{
    self._ID16480 = level._ID16473;
    self._ID25671 = 1;
}

_ID24143()
{
    self._ID16433 = 1;
}

_ID24141()
{
    self._ID8983 = gettime();
}

_ID24140()
{
    self._ID19810 = 0;
}

_ID22902()
{
    self.pers["gamemodeLoadout"] = level.alien_loadout;
    self._ID10945 = 1.0;
    self.fireshield = 0;
    self._ID18764 = 0;
    self.isrepairing = 0;
    self._ID18582 = 0;
    self._ID18569 = undefined;
    self._ID18643 = undefined;
    self.burning = undefined;
    self._ID29718 = undefined;
    self.player_action_disabled = undefined;

    if ( maps\mp\alien\_perk_utility::_ID16358( "perk_health" ) )
    {
        self.maxhealth = maps\mp\alien\_perk_utility::_ID23432();
        self.health = self.maxhealth;
    }

    thread _ID24183();
    thread _ID2855();
    _ID24143();
    _ID24141();
    maps\mp\alien\_laststand::_ID24144();

    if ( maps\mp\alien\_persistence::is_upgrade_enabled( "shock_melee_upgrade" ) )
        thread melee_strength_timer();

    if ( maps\mp\alien\_persistence::is_upgrade_enabled( "locker_key_upgrade" ) )
    {
        var_0 = getdvar( "ui_mapname" );

        if ( var_0 == "mp_alien_armory" || var_0 == "mp_alien_beacon" || var_0 == "mp_alien_dlc3" || var_0 == "mp_alien_last" )
            thread init_locker_key_upgrade();
    }

    if ( maps\mp\alien\_unk1464::alien_mode_has( "loot" ) )
        maps\mp\alien\_collectibles::_ID24207();

    if ( maps\mp\alien\_unk1464::alien_mode_has( "airdrop" ) )
        thread maps\mp\alien\_drill::_ID36041();

    thread maps\mp\alien\_collectibles::_ID36140();
    thread maps\mp\alien\_unk1464::_ID33321();
    thread _ID2856();
    thread alienplayerarmor();
    thread maps\mp\alien\_perkfunctions::_ID36051();
    self.threatbias = maps\mp\alien\_prestige::_ID24909();
    _ID26145();
    thread maps\mp\alien\_trap::_ID21321();
    thread _ID36059();

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        maps\mp\alien\_chaos::chaos_onspawnplayer( self );

    if ( isdefined( level._ID37059 ) )
        self [[ level._ID37059 ]]();

    if ( isdefined( level.resetplayercraftingitemsonrespawn ) )
        self [[ level.resetplayercraftingitemsonrespawn ]]();

    if ( maps\mp\alien\_unk1464::has_pistols_only_relic_and_no_deployables() )
        thread maps\mp\alien\_collectibles::check_for_player_near_weapon();

    thread maps\mp\alien\_unk1464::setup_class_nameplates();
    thread kick_for_inactivity();
    _ID36638::_ID22902();
}

_ID36059()
{
    level endon( "game_ended" );
    self waittill( "disconnect" );

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        var_0 = maps\mp\alien\_chaos_laststand::chaos_gameshouldend( self );
    else
        var_0 = maps\mp\alien\_laststand::_ID14077( self );

    if ( var_0 )
        level thread alienendgame( "axis", maps\mp\alien\_hud::_ID14441( "kia" ) );
}

kick_for_inactivity()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 = level._ID22861 && !getdvarint( "xblive_privatematch" );

    if ( var_0 )
    {
        var_1 = self getnormalizedmovement();
        var_2 = gettime();

        for (;;)
        {
            wait 0.2;
            var_3 = self getnormalizedmovement();

            if ( var_3[0] == var_1[0] && var_3[1] == var_1[1] )
            {
                if ( gettime() - var_2 > 300000 && level.players.size > 1 )
                    kick( self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE" );

                continue;
            }

            return;
        }
    }
}

_ID24183()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self.last_death_pos = self.origin;

    for (;;)
    {
        self waittill( "damage" );
        self.last_death_pos = self.origin;
    }
}

_ID2855()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = 0.33;
        var_0 = int( var_0 * 100 ) / 100;
        var_1 = self.health / self.maxhealth;

        if ( isdefined( self.laststand ) && self.laststand )
        {
            wait 0.05;
            continue;
        }

        if ( var_1 < var_0 )
        {
            if ( _ID16348() )
            {

            }
            else
            {

            }
        }

        common_scripts\utility::_ID35637( 5, "health_regened", "damage" );
        waittillframeend;
    }
}

_ID16348()
{
    if ( isdefined( self.has_health_pack ) && self.has_health_pack )
        return 1;

    return 0;
}

_ID22913()
{
    maps\mp\gametypes\_gamelogic::_ID9379();
}

_ID22924( var_0 )
{
    maps\mp\alien\_globallogic::_ID22924( var_0 );
}

getspawnpoint()
{
    var_0 = self.pers["team"];

    if ( level._ID15760 && isdefined( level.alien_player_spawn_group ) )
    {
        var_1 = [ "group0", "group1", "group2", "group3" ];
        var_1 = common_scripts\utility::array_randomize( var_1 );
        level._ID15822 = var_1[0];
        var_2 = level._ID15822;
        var_3 = maps\mp\gametypes\_spawnlogic::_ID15350( "mp_alien_spawn_" + var_2 + "_start" );
        var_4 = maps\mp\gametypes\_spawnlogic::_ID15346( var_3 );
    }
    else
    {
        var_3 = maps\mp\gametypes\_spawnlogic::_ID15350( "mp_tdm_spawn_axis_start" );
        var_4 = maps\mp\gametypes\_spawnlogic::_ID15346( var_3 );
    }

    return var_4;
}

initspawns()
{
    maps\mp\alien\_director::alien_attribute_table_init();

    if ( maps\mp\alien\_unk1464::alien_mode_has( "wave" ) )
    {
        maps\mp\alien\_spawnlogic::alien_wave_init();
        thread maps\mp\alien\_spawnlogic::_ID29068();
        maps\mp\alien\_spawnlogic::alien_lurker_init();
    }

    level._ID30895 = ( 0, 0, 0 );
    level._ID30893 = ( 0, 0, 0 );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_tdm_spawn_axis_start" );

    if ( isdefined( level.alien_player_spawn_group ) )
    {
        maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_alien_spawn_group3_start" );
        maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_alien_spawn_group1_start" );
        maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_alien_spawn_group0_start" );
    }

    level._ID20634 = maps\mp\gametypes\_spawnlogic::findboxcenter( level._ID30895, level._ID30893 );
    setmapcenter( level._ID20634 );
}

addalienagent( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = maps\mp\agents\_agent_common::_ID7870( "alien", var_0 );

    if ( isdefined( var_5 ) )
        var_5 thread [[ var_5 maps\mp\agents\_agent_utility::agentfunc( "spawn" ) ]]( var_1, var_2, var_3, var_4 );

    return var_5;
}

setalienloadout()
{
    level.alien_loadout["loadoutPrimary"] = "none";
    level.alien_loadout["loadoutPrimaryAttachment"] = "none";
    level.alien_loadout["loadoutPrimaryAttachment2"] = "none";
    level.alien_loadout["loadoutPrimaryBuff"] = "specialty_null";
    level.alien_loadout["loadoutPrimaryCamo"] = "none";
    level.alien_loadout["loadoutPrimaryReticle"] = "none";
    level.alien_loadout["loadoutSecondary"] = "iw6_alienp226";
    level.alien_loadout["loadoutSecondaryAttachment"] = "none";
    level.alien_loadout["loadoutSecondaryAttachment2"] = "none";
    level.alien_loadout["loadoutSecondaryBuff"] = "specialty_null";
    level.alien_loadout["loadoutSecondaryCamo"] = "none";
    level.alien_loadout["loadoutSecondaryReticle"] = "none";
    level.alien_loadout["loadoutEquipment"] = "none";
    level.alien_loadout["loadoutOffhand"] = "none";
    level.alien_loadout["loadoutPerk1"] = "specialty_pistoldeath";
    level.alien_loadout["loadoutPerk2"] = "specialty_null";
    level.alien_loadout["loadoutPerk3"] = "specialty_null";
    level.alien_loadout["loadoutJuggernaut"] = 0;
}

_ID23633( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        var_4 = getweaponbasename( var_3 );

        if ( var_4 == "iw6_alienp226_mp" || var_4 == "iw6_alienmagnum_mp" || var_4 == "iw6_alienm9a1_mp" || var_4 == "iw6_alienmp443_mp" )
        {
            var_5 = weaponclipsize( var_3 );
            self setweaponammoclip( var_3, var_5 );
        }
    }

    var_7 = 0.2;

    for (;;)
    {
        if ( maps\mp\alien\_perk_utility::_ID23436() == 1 )
        {
            if ( maps\mp\alien\_unk1464::_ID24101( "iw6_alienp226" ) || maps\mp\alien\_unk1464::_ID24101( "iw6_alienmagnum" ) || maps\mp\alien\_unk1464::_ID24101( "iw6_alienm9a1" ) || maps\mp\alien\_unk1464::_ID24101( "iw6_alienmp443" ) )
            {
                wait(var_7);
                continue;
            }

            var_1 = self getweaponslistprimaries();

            foreach ( var_3 in var_1 )
            {
                var_4 = getweaponbasename( var_3 );

                if ( var_4 == "iw6_alienp226_mp" || var_4 == "iw6_alienmagnum_mp" || var_4 == "iw6_alienm9a1_mp" || var_4 == "iw6_alienmp443_mp" )
                {
                    var_9 = self getweaponammostock( var_3 );
                    self setweaponammostock( var_3, var_9 + 1 );
                }
            }

            wait(var_7);
        }

        wait 0.05;
    }
}

bypassclasschoicefunc()
{
    return "gamemode";
}

_ID2856()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    self endon( "faux_spawn" );
    level endon( "game_ended" );
    thread maps\mp\alien\_music_and_dialog::alienplayerpainbreathingsound();

    for (;;)
    {
        common_scripts\utility::_ID35626( "damage", "health_perk_upgrade" );

        if ( !canregenhealth() )
            continue;

        var_0 = gethealthcap();
        var_1 = self.health / var_0;
        thread healthregen( gettime(), var_1, var_0 );
        thread maps\mp\gametypes\_healthoverlay::breathingmanager( gettime(), var_1 );
    }
}

alienplayerarmor()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    self endon( "faux_spawn" );
    self endon( "game_ended" );

    if ( !isdefined( self.bodyarmorhp ) )
        self.bodyarmorhp = 0;

    self setcoopplayerdata( "alienSession", "armor", 0 );
    var_0 = 0;

    for (;;)
    {
        common_scripts\utility::_ID35626( "player_damaged", "enable_armor" );

        if ( !isdefined( self.bodyarmorhp ) )
        {
            if ( var_0 > 0 )
            {
                self setcoopplayerdata( "alienSession", "armor", 0 );
                var_0 = 0;
            }

            continue;
        }

        if ( var_0 != self.bodyarmorhp )
        {
            var_1 = int( self.bodyarmorhp );
            self setcoopplayerdata( "alienSession", "armor", var_1 );
            var_0 = self.bodyarmorhp;
        }
    }
}

gethealthcap()
{
    self._ID16480 = 1.0;
    var_0 = clamp( self.maxhealth * self._ID16480, 0, self.maxhealth );
    return int( var_0 );
}

canregenhealth()
{
    if ( isdefined( self._ID18011 ) && self._ID18011 )
        return 0;

    return 1;
}

healthregen( var_0, var_1, var_2 )
{
    self notify( "healthRegeneration" );
    self endon( "healthRegeneration" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    level endon( "game_ended" );

    if ( _ID18644() )
        return;

    var_3 = spawnstruct();
    getregendata( var_3 );
    wait(var_3.activatetime);

    for (;;)
    {
        var_3 = spawnstruct();
        getregendata( var_3 );

        if ( !maps\mp\alien\_unk1464::has_fragile_relic_and_is_sprinting() )
        {
            if ( self.health < int( var_2 ) )
            {
                if ( self.health + var_3.regenamount > int( var_2 ) )
                    self.health = int( var_2 );
                else
                    self.health = self.health + var_3.regenamount;
            }
            else
                break;
        }

        wait(var_3._ID35781);
    }

    self notify( "healed" );
    _ID24143();
    maps\mp\gametypes\_damage::_ID26118();
}

getregendata( var_0 )
{
    self.prestigehealthregennerfscalar = maps\mp\alien\_prestige::prestige_getslowhealthregenscalar();

    if ( self.prestigehealthregennerfscalar == 1.0 )
    {
        if ( isdefined( self._ID18643 ) )
        {
            var_0.activatetime = 2.25;
            var_0._ID35781 = 0.2625;
            var_0.regenamount = 1;
        }
        else if ( maps\mp\alien\_persistence::is_upgrade_enabled( "faster_health_regen_upgrade" ) )
        {
            var_0.activatetime = 2.7;
            var_0._ID35781 = 0.315;
            var_0.regenamount = 1;
        }
        else
        {
            var_0.activatetime = 3.0;
            var_0._ID35781 = 0.35;
            var_0.regenamount = 1;
        }
    }
    else
    {
        var_0.activatetime = 3.0 * self.prestigehealthregennerfscalar;
        var_0._ID35781 = 0.35 * self.prestigehealthregennerfscalar;
        var_0.regenamount = 1;
    }
}

_ID18644()
{
    return isdefined( level.healthregendisabled ) && level.healthregendisabled || isdefined( self.healthregendisabled ) && self.healthregendisabled;
}

_ID26145()
{

}

_ID26143()
{
    self setclientomnvar( "ui_alien_max_currency", self._ID20724 );
    setdvar( "cg_drawCrosshairNames", 0 );
}

_ID26146()
{

}

alien_make_entity_sentient( var_0, var_1 )
{
    if ( should_make_entity_sentient() )
    {
        if ( isdefined( var_1 ) )
            return self makeentitysentient( var_0, var_1 );
        else
            return self makeentitysentient( var_0 );
    }
}

should_make_entity_sentient()
{
    if ( isdefined( self._ID28174 ) )
        return 1;

    if ( isdefined( level.drill ) && self == level.drill )
        return 1;

    if ( isdefined( self._ID13298 ) )
        return 1;

    return 0;
}

custom_giveloadout( var_0 )
{
    self takeallweapons();
    self.changingweapon = undefined;
    self._ID20133 = [];
    self._ID20139 = [];
    maps\mp\_utility::_setactionslot( 1, "" );
    maps\mp\_utility::_setactionslot( 2, "" );
    maps\mp\_utility::_setactionslot( 3, "altMode" );
    maps\mp\_utility::_setactionslot( 4, "" );

    if ( !level.console )
    {
        maps\mp\_utility::_setactionslot( 5, "" );
        maps\mp\_utility::_setactionslot( 6, "" );
        maps\mp\_utility::_setactionslot( 7, "" );
    }

    maps\mp\_utility::_clearperks();
    maps\mp\alien\_unk1464::_detachall();
    self._ID30899 = 0;

    if ( isdefined( self._ID16458 ) )
        self._ID16458 = undefined;

    set_player_character_model();
    var_1 = getplayermodelindex();
    var_2 = getplayerfoleytype( var_1 );
    self setclothtype( var_2 );
    maps\mp\gametypes\_weapons::_ID34567();
    self._ID19272 = "none";
    self._ID24978 = "none";
    var_3 = self getcoopplayerdata( "alienPlayerLoadout", "perks", 1 );

    switch ( var_3 )
    {
        case "perk_pistol_p226":
        case "perk_pistol_p226_1":
        case "perk_pistol_p226_2":
        case "perk_pistol_p226_3":
        case "perk_pistol_p226_4":
            self._ID9387 = "iw6_alienp226_mp";
            break;
        case "perk_pistol_magnum":
        case "perk_pistol_magnum_1":
        case "perk_pistol_magnum_2":
        case "perk_pistol_magnum_3":
        case "perk_pistol_magnum_4":
            if ( maps\mp\alien\_persistence::is_upgrade_enabled( "magnum_acog_upgrade" ) )
                self._ID9387 = "iw6_alienmagnum_mp_acogpistol_scope5";
            else
                self._ID9387 = "iw6_alienmagnum_mp";

            break;
        case "perk_pistol_m9a1":
        case "perk_pistol_m9a1_1":
        case "perk_pistol_m9a1_2":
        case "perk_pistol_m9a1_3":
        case "perk_pistol_m9a1_4":
            self._ID9387 = "iw6_alienm9a1_mp";
            break;
        case "perk_pistol_mp443":
        case "perk_pistol_mp443_1":
        case "perk_pistol_mp443_2":
        case "perk_pistol_mp443_3":
        case "perk_pistol_mp443_4":
            self._ID9387 = "iw6_alienmp443_mp";
            break;
    }

    self notify( "changed_kit" );
    self notify( "giveLoadout" );
    maps\mp\_utility::_ID15611( "specialty_pistoldeath", 0 );
    self._ID21667 = maps\mp\alien\_prestige::prestige_getmoveslowscalar();

    if ( self._ID21667 == 1.0 )
        maps\mp\_utility::_ID15611( "specialty_sprintreload", 0 );

    if ( maps\mp\alien\_prestige::prestige_getslowhealthregenscalar() == 1.0 )
        maps\mp\_utility::_ID15611( "specialty_falldamage", 0 );

    if ( isdefined( var_0 ) && var_0 )
        return;

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        self._ID9387 = "iw6_alienp226_mp";

    self giveweapon( self._ID9387 );
    maps\mp\alien\_collectibles::scale_ammo_based_on_nerf( self._ID9387 );

    if ( issplitscreen() )
        thread wait_and_force_weapon_switch();
    else
        self setspawnweapon( self._ID9387 );

    if ( should_give_starting_flare() )
    {
        self setoffhandsecondaryclass( "flash" );
        self giveweapon( "alienflare_mp" );
        self setweaponammoclip( "alienflare_mp", 1 );
    }

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        maps\mp\alien\_chaos::chaos_custom_giveloadout( self );
}

getplayermodelindex()
{
    return self getcoopplayerdata( "coopSquadMembers", 0, "body" );
}

getplayerfoleytype( var_0 )
{
    return tablelookup( "mp/cac/bodies.csv", 0, var_0, 5 );
}

wait_and_force_weapon_switch()
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    wait 0.5;
    self setspawnweapon( self._ID9387 );
}

set_player_character_model()
{
    thread _ID28787();
    _ID29204();
}

_ID28672( var_0, var_1, var_2 )
{
    if ( isdefined( self._ID16458 ) )
        self detach( self._ID16458 );

    self setmodel( var_0 );
    self setviewmodel( var_2 );
    self attach( var_1, "", 1 );
    self._ID16458 = var_1;
}

_ID28787()
{
    wait 0.05;
    var_0 = self getcustomizationbody();
    var_1 = self getcustomizationhead();
    var_2 = self getcustomizationviewmodel();
    _ID28672( var_0, var_1, var_2 );
}

_ID29204()
{
    if ( !isdefined( level._ID36925 ) )
        level._ID36925 = common_scripts\utility::array_randomize( [ "p2_", "p4_", "p3_" ] );

    if ( !isdefined( level._ID36924 ) )
        level._ID36924 = common_scripts\utility::array_randomize( [ "p1_" ] );

    if ( !isdefined( level._ID37647 ) )
        level._ID37647 = 0;

    if ( !isdefined( level._ID37195 ) )
        level._ID37195 = 0;

    if ( !isdefined( self._ID35381 ) )
    {
        if ( self hasfemalecustomizationmodel() )
        {
            if ( level._ID37195 < level._ID36924.size )
            {
                self._ID35381 = level._ID36924[level._ID37195];
                level._ID37195++;
            }
            else
            {
                level._ID37195 = 0;
                self._ID35381 = level._ID36924[level._ID37195];
                level._ID37195++;
            }
        }
        else if ( level._ID37647 < level._ID36925.size )
        {
            self._ID35381 = level._ID36925[level._ID37647];
            level._ID37647++;
        }
        else
        {
            level._ID37647 = 0;
            self._ID35381 = level._ID36925[level._ID37647];
            level._ID37647++;
        }
    }
}

_ID5889( var_0 )
{
    return var_0 maps\mp\alien\_unk1464::_ID18431();
}

_ID30949()
{
    self endon( "disconnect" );
    self._ID13242 = 0;
    self._ID23490 = 0;
    self.claymore_tutorial_given = 0;
    self.betty_tutorial_given = 0;
    self.deployable_tutorial_given = 0;
    self._ID28045 = 0;
    self._ID21483 = 0;
    self._ID33736 = 0;
    self._ID30380 = 0;
    self.drill_tutorial_given = 0;
    thread show_weapon_switch_hints();

    for (;;)
    {
        var_0 = self getweaponslistall();

        foreach ( var_2 in var_0 )
        {
            if ( var_2 == "alienbetty_mp" )
            {
                thread _ID29954( var_2 );
                continue;
            }

            if ( var_2 == "alienclaymore_mp" )
            {
                thread _ID29954( var_2 );
                continue;
            }

            if ( var_2 == "alienflare_mp" )
            {
                thread _ID29954( var_2 );
                continue;
            }

            if ( var_2 == "aliensemtex_mp" )
            {
                if ( !maps\mp\alien\_unk1464::is_chaos_mode() )
                    thread _ID29954( var_2 );

                continue;
            }

            if ( var_2 == "alienthrowingknife_mp" )
            {
                thread _ID29954( var_2 );
                continue;
            }

            if ( var_2 == "alienmortar_shell_mp" )
            {
                thread _ID29954( var_2 );
                continue;
            }

            if ( var_2 == "alientrophy_mp" )
            {
                thread _ID29954( var_2 );
                continue;
            }

            if ( var_2 == "alienbomb_mp" )
                thread _ID29954( var_2 );
        }

        wait 1;
    }
}

show_weapon_switch_hints()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "weapon_change",  var_0  );

        if ( var_0 == "aliendeployable_crate_marker_mp" || var_0 == "aliensoflam_mp" )
            thread _ID29954( var_0 );

        if ( maps\mp\alien\_unk1464::_ID18506( self.hasriotshield ) || maps\mp\alien\_unk1464::_ID18506( self._ID16417 ) )
        {
            self setclientomnvar( "ui_alien_riotshield_equipped", 1 );
            wait 0.05;

            if ( !self._ID16417 && self.hasriotshield )
            {
                var_1 = maps\mp\alien\_unk1464::_ID26334();

                if ( !isdefined( var_1 ) )
                    continue;

                var_2 = self getammocount( var_1 );
                self setclientomnvar( "ui_alien_riotshield_equipped", 2 );
                self setclientomnvar( "ui_alien_stowed_riotshield_ammo", var_2 );
            }

            continue;
        }

        self setclientomnvar( "ui_alien_riotshield_equipped", -1 );
    }
}

_ID29954( var_0 )
{
    self endon( "disconnect" );

    switch ( var_0 )
    {
        case "alienbetty_mp":
            if ( !self.betty_tutorial_given )
            {
                self.betty_tutorial_given = 1;
                maps\mp\_utility::setlowermessage( "tutorial", &"ALIEN_COLLECTIBLES_TUTORIAL_BETTY", 3.5 );
            }

            break;
        case "alienclaymore_mp":
            if ( !self.claymore_tutorial_given )
            {
                self.claymore_tutorial_given = 1;
                maps\mp\_utility::setlowermessage( "tutorial", &"ALIEN_COLLECTIBLES_TUTORIAL_CLAYMORE", 3.5 );
            }

            break;
        case "alienthrowingknife_mp":
            if ( !self._ID23490 )
            {
                self._ID23490 = 1;
                maps\mp\_utility::setlowermessage( "tutorial", &"ALIEN_COLLECTIBLES_TUTORIAL_PET", 3.5 );
            }

            break;
        case "alienflare_mp":
            if ( !self._ID13242 )
            {
                self._ID13242 = 1;
                maps\mp\_utility::setlowermessage( "tutorial", &"ALIEN_COLLECTIBLES_TUTORIAL_FLARE", 3.5 );
            }

            break;
        case "aliensemtex_mp":
            if ( !self._ID28045 )
            {
                self._ID28045 = 1;
                maps\mp\_utility::setlowermessage( "tutorial", &"ALIEN_COLLECTIBLES_TUTORIAL_SEMTEX", 3.5 );
            }

            break;
        case "alienmortar_shell_mp":
            if ( !self._ID21483 )
            {
                self._ID21483 = 1;
                maps\mp\_utility::setlowermessage( "tutorial", &"ALIEN_COLLECTIBLES_TUTORIAL_MORTARSHELL", 3.5 );
            }

            break;
        case "aliensoflam_mp":
            if ( !self._ID30380 )
            {
                self._ID30380 = 1;
                maps\mp\_utility::setlowermessage( "tutorial", &"ALIEN_COLLECTIBLES_TUTORIAL_SOFLAM", 3.5 );
            }

            break;
        case "alientrophy_mp":
            if ( !self._ID33736 )
            {
                self._ID33736 = 1;
                maps\mp\_utility::setlowermessage( "tutorial", &"ALIEN_COLLECTIBLES_TUTORIAL_TROPHY", 3.5 );
            }

            break;
        case "alienbomb_mp":
            if ( !self.drill_tutorial_given )
            {
                self.drill_tutorial_given = 1;
                maps\mp\_utility::setlowermessage( "go_plant", get_drill_tutorial_text(), 3.5 );
                return;
            }
    }
}

get_drill_tutorial_text()
{
    if ( isdefined( level.drill_tutorial_text ) )
        return level.drill_tutorial_text;

    return &"ALIEN_COLLECTIBLES_GO_PLANT_BOMB";
}

_ID11431()
{
    self endon( "disconnect" );

    for (;;)
    {
        if ( maps\mp\alien\_unk1464::_ID18431() )
        {
            common_scripts\utility::_disableusability();

            while ( maps\mp\alien\_unk1464::_ID18431() )
                wait 0.05;

            common_scripts\utility::_enableusability();
        }

        wait 0.05;
    }
}

_ID19259()
{
    maps\mp\killstreaks\_killstreaks::_ID17970();
    level._ID19256 = [];
    level._ID19268 = [];
    level.killstreakweapons = [];
    thread maps\mp\killstreaks\_uav::_ID17631();
    thread maps\mp\killstreaks\_airstrike::_ID17631();
    thread maps\mp\killstreaks\_plane::_ID17631();
    thread maps\mp\killstreaks\_helicopter::_ID17631();
    thread maps\mp\alien\_nuke::_ID17631();
    thread maps\mp\killstreaks\_portableaoegenerator::_ID17631();
    thread maps\mp\killstreaks\_ims::_ID17631();
    thread maps\mp\killstreaks\_perkstreaks::_ID17631();
    thread maps\mp\killstreaks\_remoteuav::_ID17631();
    thread maps\mp\killstreaks\_juggernaut::_ID17631();
    thread maps\mp\killstreaks\_unk1523::_ID17631();
    thread maps\mp\killstreaks\_vanguard::_ID17631();
    thread maps\mp\killstreaks\_dronehive::_ID17631();
    thread maps\mp\killstreaks\_air_superiority::_ID17631();
    level._ID32657["allies"] = 0;
    level._ID32657["axis"] = 0;
    level._ID19276 = [];
    level._ID19276["artillery_mp"] = "precision_airstrike";
    level._ID19276["stealth_bomb_mp"] = "stealth_airstrike";
    level._ID19276["pavelow_minigun_mp"] = "helicopter_flares";
    level._ID19276["sentry_minigun_mp"] = "sentry";
    level._ID19276["ac130_105mm_mp"] = "ac130";
    level._ID19276["ac130_40mm_mp"] = "ac130";
    level._ID19276["ac130_25mm_mp"] = "ac130";
    level._ID19276["remotemissile_projectile_mp"] = "predator_missile";
    level._ID19276["cobra_ffar_mp"] = "helicopter";
    level._ID19276["hind_bomb_mp"] = "helicopter";
    level._ID19276["cobra_20mm_mp"] = "helicopter";
    level._ID19276["nuke_mp"] = "nuke";
    level._ID19276["littlebird_guard_minigun_mp"] = "littlebird_support";
    level._ID19276["osprey_minigun_mp"] = "escort_airdrop";
    level._ID19276["remote_mortar_missile_mp"] = "remote_mortar";
    level._ID19276["manned_littlebird_sniper_mp"] = "heli_sniper";
    level._ID19276["iw5_mp412jugg_mp"] = "airdrop_juggernaut";
    level._ID19276["mortar_shelljugg_mp"] = "airdrop_juggernaut";
    level._ID19276["iw6_riotshieldjugg_mp"] = "airdrop_juggernaut_recon";
    level._ID19276["iw5_usp45jugg_mp"] = "airdrop_juggernaut_recon";
    level._ID19276["smoke_grenadejugg_mp"] = "airdrop_juggernaut_recon";
    level._ID19276["iw6_knifeonlyjugg_mp"] = "airdrop_juggernaut_maniac";
    level._ID19276["throwingknifejugg_mp"] = "airdrop_juggernaut_maniac";
    level._ID19276["remote_turret_mp"] = "remote_mg_turret";
    level._ID19276["osprey_player_minigun_mp"] = "osprey_gunner";
    level._ID19276["deployable_vest_marker_mp"] = "deployable_vest";
    level._ID19276["ugv_turret_mp"] = "remote_tank";
    level._ID19276["ugv_gl_turret_mp"] = "remote_tank";
    level._ID19276["remote_tank_projectile_mp"] = "vanguard";
    level._ID19276["uav_remote_mp"] = "remote_uav";
    level._ID19276["heli_pilot_turret_mp"] = "heli_pilot";
    level._ID19276["lasedstrike_missile_mp"] = "lasedStrike";
    level._ID19276["agent_mp"] = "agent";
    level._ID19276["guard_dog_mp"] = "guard_dog";
    level._ID19276["ims_projectile_mp"] = "ims";
    level._ID19276["ball_drone_gun_mp"] = "ball_drone_backup";
    level._ID19276["drone_hive_projectile_mp"] = "drone_hive";
    level._ID19276["switch_blade_child_mp"] = "drone_hive";
    level._ID19276["iw6_maaws_mp"] = "aa_launcher";
    level._ID19276["killstreak_uplink_mp"] = "uplink";
    level._ID19276["gas_strike_mp"] = "gas_airstrike";
    level._ID19276["a10_30mm_mp"] = "a10_strafe";
    level._ID19276["maverick_projectile_mp"] = "a10_strafe";
    level._ID19276["odin_projectile_large_rod_mp"] = "odin_assault";
    level._ID19276["odin_projectile_small_rod_mp"] = "odin_assault";
    level._ID19276["iw5_barrettexp_mp_barrettscope"] = "heli_sniper";
    level._ID19276["airdrop_marker_mp"] = "airdrop_assault";

    if ( isdefined( level.mapcustomkillstreakfunc ) )
        [[ level.mapcustomkillstreakfunc ]]();

    level._ID19263 = maps\mp\_utility::_ID15069( "scr_game_killstreakdelay", 8 );
}

_ID21375()
{
    while ( isdefined( self ) )
    {
        if ( maps\mp\_utility::bot_is_fireteam_mode() )
            self waittill( "disconnect" );
        else
            common_scripts\utility::_ID35626( "disconnect", "joined_team", "joined_spectators" );

        self notify( "killstreak_disowned" );
    }
}

_ID2851()
{
    level thread alienendgame( "axis", maps\mp\alien\_hud::_ID14441( "host_end" ) );
}

alienendgame( var_0, var_1 )
{
    var_2 = 11.0;

    if ( _ID14061() )
        return;

    game["state"] = "postgame";
    level.gameended = 1;
    level._ID14064 = gettime();
    level._ID17628 = 0;
    level notify( "game_ended",  var_0  );
    common_scripts\utility::_ID35582();
    maps\mp\_utility::levelflagset( "game_over" );
    maps\mp\_utility::levelflagset( "block_notifies" );
    setomnvar( "ui_pause_menu_show", 0 );
    setdvar( "ui_game_state", "postgame" );
    setdvar( "g_deadChat", 1 );
    setdvar( "ui_allow_teamchange", 0 );
    setdvar( "bg_compassShowEnemies", 0 );
    setdvar( "scr_gameended", 1 );
    setgameendtime( 0 );
    maps\mp\gametypes\_gamescore::_ID34624( "axis" );
    maps\mp\gametypes\_gamescore::_ID34624( "allies" );
    maps\mp\gametypes\_gamescore::_ID34574();
    maps\mp\gametypes\_gamelogic::freezeallplayers( 1.0, "cg_fovScale", 1 );

    foreach ( var_4 in level.players )
    {
        var_4 notify( "reset_outcome" );
        var_4.pers["stats"] = var_4._ID31525;
        var_4 maps\mp\killstreaks\_killstreaks::clearkillstreaks();
        var_4.ignoreme = 1;
        var_4 maps\mp\_utility::_ID7496();
    }

    foreach ( var_7 in level.agentarray )
    {
        if ( isdefined( var_7.isactive ) && var_7.isactive )
        {
            var_7.ignoreall = 1;
            var_7 maps\mp\alien\_unk1464::_ID11418();
        }
    }

    maps\mp\alien\_unk1443::calculate_players_total_end_game_score();
    level.intermission = 1;

    if ( isdefined( level.pre_end_game_display_func ) )
        [[ level.pre_end_game_display_func ]]();

    maps\mp\alien\_hud::_ID10219( var_0, var_1 );
    maps\mp\_utility::_ID19892( "block_notifies" );
    level notify( "spawning_intermission" );
    var_9 = maps\mp\gametypes\_playerlogic::_ID30890;

    if ( isdefined( level._ID37056 ) )
        var_9 = level._ID37056;

    foreach ( var_4 in level.players )
    {
        var_4 thread [[ var_9 ]]();
        var_4 thread blackbox_endgame_score();
        var_4 setclientdvar( "ui_opensummary", 1 );
        var_4 setroundgamemode();
    }

    var_12 = _ID37275( var_1 );
    var_13 = _ID37306();
    blackbox_endgame( var_12, var_13 );
    _ID36632::endgame( var_12, var_13 );

    if ( isdefined( level.end_game_scoreboard_wait_time ) )
        var_2 = level.end_game_scoreboard_wait_time;

    wait(var_2);
    setnojiptime( 0 );
    level notify( "exitLevel_called" );
    exitlevel( 0 );
}

_ID14061()
{
    return game["state"] == "postgame" || level.gameended;
}

setroundgamemode()
{
    if ( !maps\mp\alien\_unk1464::is_chaos_mode() )
        self setcommonplayerdata( "round", "gameMode", "aliens" );
    else
        self setcommonplayerdata( "round", "gameMode", "mugger" );

    self setcommonplayerdata( "round", "map", tolower( getdvar( "mapname" ) ) );
}

blackbox_endgame_score()
{
    var_0 = -1;

    if ( isdefined( level.current_cycle_num ) )
        var_0 = level.current_cycle_num;

    var_1 = "unknown";

    if ( isdefined( self.name ) )
        var_1 = self.name;

    var_2 = "unknown";

    if ( isdefined( level.current_hive_name ) )
        var_2 = level.current_hive_name;

    var_3 = 0;

    if ( isdefined( self.end_game_score ) && isdefined( self.end_game_score["total_score"] ) )
        var_3 = self.end_game_score["total_score"];

    var_4 = maps\mp\alien\_persistence::_ID14672();
    bbprint( "alienfinalscore", "playername %s cyclenum %i hivename %s playerfinalscore %i playerxpearned %i ", var_1, var_0, var_2, var_3, var_4 );
}

blackbox_endgame( var_0, var_1 )
{
    var_2 = -1;

    if ( isdefined( level.players[0] ) )
        var_2 = int( level.players[0] maps\mp\alien\_persistence::_ID14667() );

    var_3 = -1;

    if ( isdefined( level.players[1] ) )
        var_3 = int( level.players[1] maps\mp\alien\_persistence::_ID14667() );

    var_4 = -1;

    if ( isdefined( level.players[2] ) )
        var_4 = int( level.players[2] maps\mp\alien\_persistence::_ID14667() );

    var_5 = -1;

    if ( isdefined( level.players[3] ) )
        var_5 = int( level.players[3] maps\mp\alien\_persistence::_ID14667() );

    var_6 = 0;

    if ( isdefined( level.current_cycle_num ) )
        var_6 = level.current_cycle_num;

    var_7 = "unknown";

    if ( isdefined( level.current_hive_name ) )
        var_7 = level.current_hive_name;

    var_8 = level.alienbbdata["times_downed"];
    var_9 = level.alienbbdata["times_died"];
    var_10 = level.alienbbdata["times_drill_stuck"];
    var_11 = level.alienbbdata["aliens_killed"];
    var_12 = level.alienbbdata["team_item_deployed"];
    var_13 = level.alienbbdata["team_item_used"];
    var_14 = level.alienbbdata["bullets_shot"];
    var_15 = level.alienbbdata["damage_taken"];
    var_16 = level.alienbbdata["damage_done"];
    var_17 = level.alienbbdata["traps_used"];
    bbprint( "alienendgame", "endcondition %s player0rank %i player1rank %i player2rank %i player3rank %i playtime %f hivescleared %i hivename %s timesdowned %i timesdied %i timesdrillstuck %i alienskilled %i teamitemused %i teamitemdeployed %i bulletsshot %i damagedone %i damagetaken %i trapsused %i ", var_0, var_2, var_3, var_4, var_5, var_1, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17 );

    foreach ( var_20 in level.players )
    {
        var_20 setcoopplayerdata( "alienSession", "team_shots", level.alienbbdata["bullets_shot"] );
        var_20 setcoopplayerdata( "alienSession", "team_kills", level.alienbbdata["aliens_killed"] );
        var_20 setcoopplayerdata( "alienSession", "team_hives", level.num_hive_destroyed );
        var_21 = int( var_20 getentitynumber() );
        var_22 = "EoGPlayer" + var_21;

        if ( isdefined( var_20.name ) )
            var_23 = var_20.name;
        else
            var_23 = "-error";

        var_24 = gettime() - var_20.connect_time;
        var_25 = var_20 getcoopplayerdata( var_22, "kills" );
        var_26 = var_20 getcoopplayerdata( var_22, "score" );
        var_27 = var_20 getcoopplayerdata( var_22, "assists" );
        var_28 = var_20 getcoopplayerdata( var_22, "revives" );
        var_29 = var_20 getcoopplayerdata( var_22, "drillrestarts" );
        var_30 = var_20 getcoopplayerdata( var_22, "deaths" );
        var_31 = var_20 getcoopplayerdata( var_22, "hivesdestroyed" );
        var_32 = var_20 getcoopplayerdata( var_22, "traps" );
        var_33 = var_20 getcoopplayerdata( var_22, "deployables" );
        var_34 = var_20 getcoopplayerdata( var_22, "deployablesused" );
        var_35 = var_20 getcoopplayerdata( var_22, "currencyspent" );
        var_36 = var_20 getcoopplayerdata( var_22, "currencytotal" );
        var_37 = "alienendgame_player" + var_21;
        bbprint( var_37, "playername %s playerplaytime %f playerkills %i playerscore %i playerassists %i playerrevives %i playerdrillrestarts %i playerdeaths %i playerhives %i playertraps %i playertotalcurrency %i playercurrencyspent %i playerdeployables %i playerdeployablesused %i ", var_23, var_24, var_25, var_26, var_27, var_28, var_29, var_30, var_31, var_32, var_36, var_35, var_33, var_34 );
    }
}

_ID37275( var_0 )
{
    switch ( var_0 )
    {
        case 1:
            return "all_escape";
        case 2:
            return "some_escape";
        case 3:
            return "fail_escape";
        case 4:
        case 8:
            return "drill destroyed";
        case 5:
            return "died";
        case 6:
            return "host_quit";
        case 7:
            return "gas_fail";
    }

    endswitch( 9 )  case 8 loc_2A57 case 7 loc_2A69 case 6 loc_2A63 case 5 loc_2A5D case 4 loc_2A57 case 3 loc_2A51 case 2 loc_2A4B case 1 loc_2A45 default loc_2A6F
}

_ID37306()
{
    var_0 = 0;

    if ( isdefined( level._ID31480 ) )
        var_0 = gettime() - level._ID31480;

    return var_0;
}

alien_customprematchperiod()
{
    if ( !maps\mp\alien\_unk1464::_ID18506( level._ID18304 ) )
        level._ID24880 = 10;

    if ( !maps\mp\alien\_intro_sequence::_ID18262() )
    {
        var_0 = 3;

        if ( maps\mp\alien\_unk1464::is_chaos_mode() )
            var_0 = 6;

        wait(var_0);
        level notify( "introscreen_over" );
        level._ID18304 = 1;
        level notify( "spawn_intro_drill" );

        if ( maps\mp\alien\_unk1464::_ID18506( level.intermission ) )
            return;

        for ( var_1 = 0; var_1 < level.players.size; var_1++ )
        {
            level.players[var_1] maps\mp\_utility::_ID13582( 0 );
            level.players[var_1] enableweapons();

            if ( !isdefined( level.players[var_1].pers["team"] ) )
                continue;
        }

        return;
    }

    if ( level._ID24880 > 0 )
    {
        var_2 = level _ID35456();

        if ( maps\mp\alien\_intro_sequence::_ID18262() )
            level thread maps\mp\alien\_intro_sequence::_ID23786( var_2 );

        level thread _ID29934();

        if ( isdefined( level._ID18173 ) )
            level thread [[ level._ID18173 ]]();

        wait(level._ID24880 - 3);

        if ( isdefined( level._ID37833 ) )
            [[ level._ID37833 ]]();

        level notify( "introscreen_over" );
        level._ID18304 = 1;
    }
    else
    {
        wait 1;
        level notify( "introscreen_over" );
    }

    if ( maps\mp\alien\_unk1464::_ID18506( level.intermission ) )
        return;

    for ( var_1 = 0; var_1 < level.players.size; var_1++ )
    {
        level.players[var_1] maps\mp\_utility::_ID13582( 0 );
        level.players[var_1] enableweapons();

        if ( !isdefined( level.players[var_1].pers["team"] ) )
            continue;
    }
}

_ID35456()
{
    var_0 = undefined;

    if ( level.players.size == 0 )
        level waittill( "connected",  var_0  );
    else
        var_0 = level.players[0];

    return var_0;
}

_ID29934()
{
    wait 2;
    var_0 = maps\mp\alien\_hud::_ID18302( level.introscreen_line_1, 1 );
    wait 1;
    var_1 = maps\mp\alien\_hud::_ID18302( level._ID18313, 2 );
    wait 1;
    var_2 = maps\mp\alien\_hud::_ID18302( level._ID18314, 3 );
    wait 1;
    var_3 = maps\mp\alien\_hud::_ID18302( level.introscreen_line_4, 4 );
    level waittill( "introscreen_over" );
    var_0 fadeovertime( 3 );
    var_1 fadeovertime( 3 );
    var_2 fadeovertime( 3 );
    var_3 fadeovertime( 3 );
    wait 3.1;
    var_0.alpha = 0;
    var_1.alpha = 0;
    var_2.alpha = 0;
    var_3.alpha = 0;
    var_0 destroy();
    var_1 destroy();
    var_2 destroy();
    var_3 destroy();
}

setup_blocker_hives( var_0 )
{
    level._ID5372 = var_0;
}

_ID28965( var_0 )
{
    level._ID8866 = var_0;
}

_ID29054( var_0 )
{
    level._ID19460 = var_0;
}

_ID37876( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( level._ID37170 ) )
        level._ID37170 = [];

    var_7 = spawnstruct();
    var_7.func = var_0;

    if ( isdefined( var_2 ) )
        var_7._ID37412 = var_2;

    if ( isdefined( var_1 ) )
        var_7._ID38037 = var_1;

    if ( isdefined( var_3 ) )
        var_7._ID37380 = var_3;

    if ( isdefined( var_4 ) )
        var_7._ID38040 = var_4;

    if ( isdefined( var_5 ) )
        var_7._ID37839 = var_5;

    if ( isdefined( var_6 ) )
        var_7._ID37225 = var_6;

    level._ID37170[level._ID37170.size] = var_7;
}

_ID37922()
{
    level endon( "game_ended" );

    if ( isdefined( level.dlc_run_encounters_override ) )
    {
        [[ level.dlc_run_encounters_override ]]();
        return;
    }

    if ( !isdefined( level._ID37170 ) )
        return;

    var_0 = _ID37540();
    var_1 = 0;
    var_2 = _ID37333( var_0 );

    foreach ( var_4 in level._ID37170 )
    {
        level._ID37046 = var_4;

        if ( _ID38016( var_0, var_1, var_2 ) )
            [[ var_4._ID37839 ]]();

        if ( _ID38019( var_0, var_1, var_2 ) )
        {
            [[ var_4._ID38040 ]]();

            if ( isdefined( var_4._ID38037 ) )
                _ID37446( var_4._ID38037 );

            if ( maps\mp\alien\_unk1464::_ID18506( var_4._ID37380 ) )
                maps\mp\alien\_unk1464::_ID37441();
        }
        else
        {
            [[ var_4.func ]]();

            if ( !maps\mp\alien\_unk1464::_ID18426() )
            {
                if ( isdefined( var_4._ID38037 ) )
                    _ID37375( var_4._ID38037 );
            }
            else if ( isdefined( var_4._ID37412 ) )
                _ID37375( var_4._ID37412 );

            if ( maps\mp\alien\_unk1464::_ID18506( var_4._ID37380 ) )
                maps\mp\alien\_collectibles::_ID36668();
        }

        var_1++;
    }
}

init_locker_key_upgrade()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait 5.0;

    if ( !isdefined( level.starting_locker_key_names ) )
        level.starting_locker_key_names = [];

    var_0 = self getxuid();

    if ( maps\mp\alien\_unk1464::_ID18506( level._ID22861 ) )
    {
        for ( var_1 = 0; var_1 < level.starting_locker_key_names.size; var_1++ )
        {
            if ( level.starting_locker_key_names[var_1] == var_0 )
                return;
        }
    }

    level.starting_locker_key_names[level.starting_locker_key_names.size] = var_0;
    self._ID37627 = 1;
    self setclientomnvar( "ui_alien_locker_key", 1 );
}

should_give_starting_flare()
{
    if ( !maps\mp\alien\_perk_utility::_ID16358( "perk_health", [ 0, 1, 2, 3, 4 ] ) )
        return 0;

    if ( !isdefined( level.starting_flare_names ) )
        level.starting_flare_names = [];

    var_0 = self getxuid();

    if ( maps\mp\alien\_unk1464::_ID18506( level._ID22861 ) )
    {
        for ( var_1 = 0; var_1 < level.starting_flare_names.size; var_1++ )
        {
            if ( level.starting_flare_names[var_1] == var_0 )
                return 0;
        }
    }

    level.starting_flare_names[level.starting_flare_names.size] = var_0;
    return 1;
}

_ID37540()
{
    return 0;
}

_ID37333( var_0 )
{
    return 0;
}

_ID38016( var_0, var_1, var_2 )
{
    return 0;
}

_ID38019( var_0, var_1, var_2 )
{
    return 0;
}

_ID37375( var_0 )
{
    foreach ( var_2 in level.players )
        var_2 maps\mp\alien\_persistence::give_player_points( int( var_0 ) );
}

_ID37446( var_0 )
{

}

melee_strength_timer()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self.meleestrength = 1.0;
    var_0 = 1;
    self.meleestrength = 0;
    var_1 = gettime();

    for (;;)
    {
        var_2 = gettime();

        if ( var_2 - var_1 >= level.playermeleestunregentime )
            self.meleestrength = 1.0;
        else
            self.meleestrength = 0;

        if ( self meleebuttonpressed() && !self isreloading() && !self usebuttonpressed() )
        {
            var_1 = gettime();

            if ( var_0 == 1 )
                var_0 = 0;
        }
        else if ( !self meleebuttonpressed() )
            var_0 = 1;
        else
            var_0 = 0;

        wait 0.05;
    }
}
