// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

init_challenge_type()
{
    level._ID6847 = [];

    if ( !isdefined( level._ID6850 ) )
        level._ID6850 = ::_ID9356;

    if ( isdefined( level.challenge_registration_func ) )
        [[ level.challenge_registration_func ]]();

    if ( maps\mp\alien\_unk1464::_ID18506( level._ID17520 ) )
    {
        _ID25676( "spend_10k", 10000, 0, undefined, undefined, ::activate_spend_currency, ::_ID9020, undefined, ::_ID34478 );
        _ID25676( "spend_20k", 20000, 0, undefined, undefined, ::activate_spend_currency, ::_ID9020, undefined, ::_ID34478 );
        _ID25676( "kill_leper", 30, 0, undefined, undefined, ::_ID2085, ::_ID9013, undefined, ::_ID34435 );
        _ID25676( "spend_no_money", 120, 1, undefined, undefined, ::activate_spend_no_money, ::default_resetsuccess, undefined, ::_ID34479 );
        _ID25676( "no_reloads", 60, 1, undefined, undefined, ::activate_no_reloads, ::default_resetsuccess, undefined, ::update_no_reloads );
        _ID25676( "no_abilities", 90, 1, undefined, undefined, ::activate_no_abilities, ::default_resetsuccess, undefined, ::_ID34445 );
        _ID25676( "take_no_damage", undefined, 1, undefined, undefined, ::default_resetsuccess, ::default_resetsuccess, undefined, ::_ID34484 );
        _ID25676( "melee_5_goons", 5, 0, undefined, undefined, ::activate_melee_goons, ::deactivate_melee_goons, undefined, ::_ID34439 );
        _ID25676( "melee_spitter", 1, 0, undefined, undefined, ::_ID2088, ::_ID9016, undefined, ::update_melee_spitter );
        _ID25676( "no_stuck_drill", undefined, 1, undefined, undefined, ::default_resetsuccess, ::default_resetsuccess, undefined, ::_ID34449 );
        _ID25676( "kill_10_with_propane", 10, 0, undefined, undefined, ::_ID2081, ::_ID9009, undefined, ::_ID34431 );
        _ID25676( "stay_prone", 10, 0, undefined, undefined, ::activate_stay_prone, ::_ID9021, undefined, ::_ID34480 );
        _ID25676( "kill_10_with_traps", 10, 0, undefined, undefined, ::activate_kill_10_with_traps, ::_ID9010, undefined, ::_ID34432 );
        _ID25676( "avoid_minion_explosion", undefined, 1, undefined, undefined, ::activate_avoid_minion_exp, ::deactivate_avoid_minion_exp, undefined, ::_ID34400 );
        _ID25676( "75_percent_accuracy", undefined, 1, ::_ID29212, undefined, ::activate_percent_accuracy, ::deactivate_percent_accuracy, undefined, ::_ID34391 );
        _ID25676( "pistols_only", 10, 0, undefined, undefined, ::activate_use_weapon_challenge, ::default_resetsuccess, undefined, ::_ID34458 );
        _ID25676( "shotguns_only", 10, 0, undefined, undefined, ::activate_use_weapon_challenge, ::deactivate_weapon_challenge_waypoints, undefined, ::update_shotguns_only );
        _ID25676( "snipers_only", 10, 0, undefined, undefined, ::activate_use_weapon_challenge, ::deactivate_weapon_challenge_waypoints, undefined, ::_ID34476 );
        _ID25676( "lmgs_only", 10, 0, undefined, undefined, ::activate_use_weapon_challenge, ::deactivate_weapon_challenge_waypoints, undefined, ::_ID34437 );
        _ID25676( "ar_only", 10, 0, undefined, undefined, ::activate_use_weapon_challenge, ::deactivate_weapon_challenge_waypoints, undefined, ::_ID34399 );
        _ID25676( "smg_only", 10, 0, undefined, undefined, ::activate_use_weapon_challenge, ::deactivate_weapon_challenge_waypoints, undefined, ::_ID34475 );
        _ID25676( "kill_10_with_turrets", 10, 0, undefined, undefined, ::activate_kill_10_with_turrets, ::deactivate_kill_10_with_turrets, undefined, ::_ID34433 );
        _ID25676( "kill_airborne_aliens", 5, 0, undefined, undefined, ::activate_kill_airborne_aliens, ::deactivate_kill_airborne_aliens, undefined, ::_ID34434 );
        _ID25676( "melee_only", undefined, 1, undefined, undefined, ::activate_melee_only, ::deactivate_melee_only, undefined, ::_ID34440 );
        _ID25676( "50_percent_accuracy", undefined, 1, ::_ID12830, undefined, ::activate_percent_accuracy, ::deactivate_percent_accuracy, undefined, ::_ID34390 );
        _ID25676( "stay_within_area", 10, 0, undefined, ::_ID37838, ::activate_stay_within_area, ::_ID9022, undefined, ::_ID34481 );
        _ID25676( "kill_10_in_30", 10, 0, undefined, undefined, ::activate_kill_10_in_30, ::default_resetsuccess, undefined, ::_ID34430 );
        _ID25676( "protect_player", undefined, 1, undefined, undefined, ::activate_protect_a_player, ::deactivate_protect_a_player, undefined, ::_ID34465 );
        _ID25676( "no_laststand", undefined, 1, undefined, undefined, ::default_resetsuccess, ::default_resetsuccess, undefined, ::_ID34447 );
        _ID25676( "no_bleedout", undefined, 1, undefined, undefined, ::default_resetsuccess, ::default_resetsuccess, undefined, ::_ID34446 );
        _ID25676( "challenge_failed", undefined, 0, undefined, undefined, ::default_resetsuccess, ::default_resetsuccess, undefined, undefined );
        _ID25676( "challenge_success", undefined, 0, undefined, undefined, ::default_resetsuccess, ::default_resetsuccess, undefined, undefined );
        _ID25676( "barrier_hive", undefined, 0, undefined, undefined, ::default_resetsuccess, ::default_resetsuccess, undefined, undefined );
    }

    _ID17638();
    level.current_challenge_index = -1;
    level.current_challenge_progress_max = -1;
    level.current_challenge_progress_current = -1;
    level.current_challenge_percent = -1;
    level.current_challenge_target_player = -1;
    level._ID8632 = -1;
    level.current_challenge_scalar = -1;
    level.current_challenge_title = -1;
    level.current_challenge_pre_challenge = 0;
    level.all_challenge_completed = 1;
    level.pre_challenge_active = 0;
    level.num_challenge_completed = 0;
}

_ID25676( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    var_11 = spawnstruct();
    var_11._ID25633 = var_0;
    var_11.goal = var_1;
    var_11._ID9390 = var_2;
    var_11._ID18803 = ::_ID9370;

    if ( isdefined( var_3 ) )
        var_11._ID18803 = var_3;

    var_11.canactivatefunc = ::default_canactivatefunc;

    if ( isdefined( var_4 ) )
        var_11.canactivatefunc = var_4;

    var_11.activatefunc = var_5;
    var_11._ID9025 = var_6;
    var_11.failactivatefunc = ::default_failactivatefunc;

    if ( isdefined( var_7 ) )
        var_11.failactivatefunc = var_7;

    var_11._ID34541 = var_8;
    var_11._ID26270 = ::_ID9381;

    if ( isdefined( var_9 ) )
        var_11._ID26270 = var_9;

    var_11._ID12643 = ::default_failfunc;

    if ( isdefined( var_10 ) )
        var_11._ID12643 = var_10;

    level._ID6847[var_0] = var_11;
}

_ID17638()
{
    var_0 = level.alien_challenge_table;
    var_1 = 0;
    var_2 = 1;
    var_3 = 99;
    var_4 = 1;
    var_5 = 2;
    var_6 = 6;
    var_7 = 7;
    var_8 = 8;

    for ( var_9 = var_2; var_9 <= var_3; var_9++ )
    {
        var_10 = tablelookup( var_0, var_1, var_9, var_4 );

        if ( var_10 == "" )
            break;

        var_11 = tablelookup( var_0, var_1, var_9, var_5 );
        var_12 = tablelookup( var_0, var_1, var_9, var_8 );
        level._ID6847[var_10].allowed_cycles = var_11;
        level._ID6847[var_10].allowedinsolo = int( tablelookup( var_0, var_1, var_9, var_6 ) );
        level._ID6847[var_10]._ID2978 = var_12;
    }
}

default_canactivatefunc()
{
    return 1;
}

default_failactivatefunc()
{

}

_ID9370()
{
    return self._ID32046;
}

default_failfunc()
{

}

default_resetsuccess()
{
    self._ID32046 = self._ID9390;
}

_ID9381()
{
    var_0 = 1;

    foreach ( var_2 in level.players )
        var_2 maps\mp\alien\_persistence::give_player_points( var_0 );
}

activate_spend_currency()
{
    activate_spend_money_progress();
}

_ID9020()
{
    _ID26104();
}

_ID26104()
{
    default_resetsuccess();
    self._ID8660 = 0;
}

activate_spend_money_progress()
{
    default_resetsuccess();
    self._ID8660 = 0;
    self.goal = self.goal * 1000;
    _ID34408( 0, self.goal );
}

_ID34478( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID8660 = self._ID8660 + var_0;

    if ( self._ID8660 >= self.goal )
        self._ID32046 = 1;

    _ID34408( self._ID8660, self.goal );

    if ( self._ID32046 )
        maps\mp\alien\_unk1422::deactivate_current_challenge();
}

_ID2085()
{
    default_resetsuccess();

    if ( !isdefined( level._ID8635 ) )
        level waittill( "alien_cycle_started" );

    self.leper = maps\mp\alien\_spawn_director::_ID30572( "leper" );
    self.leper thread _ID19831();
    self.leper thread maps\mp\agents\alien\_alien_leper::_ID19825( self.goal );
    var_0 = int( gettime() + 30000 );

    foreach ( var_2 in level.players )
        var_2 setclientomnvar( "ui_intel_timer", var_0 );

    level._ID8632 = 30;
    level thread _ID34410();
}

_ID9013()
{
    default_resetsuccess();

    if ( isalive( self.leper ) )
    {
        self.leper thread maps\mp\agents\alien\_alien_leper::leper_despawn();
        self.leper = undefined;
    }
}

_ID19831()
{
    self waittill( "death",  var_0, var_1, var_2  );

    if ( isdefined( var_0 ) && ( isplayer( var_0 ) || isdefined( var_0.classname ) && var_0.classname == "misc_turret" && isdefined( var_0.owner ) && var_0.owner isusingturret() ) )
        maps\mp\alien\_unk1422::_ID34406( "kill_leper", "success" );
    else
        maps\mp\alien\_unk1422::_ID34406( "kill_leper", "fail" );

    level notify( "stop_challenge_timer" );
    level._ID8632 = -1;
}

_ID34435( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( var_0 == "success" )
        self._ID32046 = 1;

    maps\mp\alien\_unk1422::deactivate_current_challenge();
}

activate_spend_no_money()
{
    default_resetsuccess();
    var_0 = int( gettime() + self.goal * 1000 );

    foreach ( var_2 in level.players )
        var_2 setclientomnvar( "ui_intel_timer", var_0 );

    level._ID8632 = self.goal;
    level thread _ID34410();
    level thread _ID30986( self );
}

_ID30986( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "fail" );
    wait(var_0.goal);
    var_0._ID32046 = 1;
    level notify( "stop_challenge_timer" );
    maps\mp\alien\_unk1422::deactivate_current_challenge();
}

_ID34479( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID32046 = 0;
    self notify( "fail" );
    level notify( "stop_challenge_timer" );
    maps\mp\alien\_unk1422::deactivate_current_challenge();
}

activate_no_reloads()
{
    default_resetsuccess();
    var_0 = int( gettime() + self.goal * 1000 );
    level._ID8632 = self.goal;
    level thread _ID34410();
    level thread _ID22061( self );

    foreach ( var_2 in level.players )
    {
        var_2 setclientomnvar( "ui_intel_timer", var_0 );
        var_2 thread _ID35476();
    }
}

_ID22061( var_0 )
{
    level endon( "stop_watching_reload" );
    wait(var_0.goal);
    var_0._ID32046 = 1;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
    level notify( "stop_challenge_timer" );
    level notify( "stop_watching_reload" );
}

_ID35476()
{
    level endon( "stop_watching_reload" );
    self waittill( "reload" );
    maps\mp\alien\_unk1422::_ID34406( "no_reloads" );
    level notify( "stop_watching_reload" );
}

update_no_reloads( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
    level notify( "stop_challenge_timer" );
}

activate_no_abilities()
{
    default_resetsuccess();
    var_0 = int( gettime() + self.goal * 1000 );
    level._ID8632 = self.goal;
    level thread _ID34410();
    level thread no_abilities_timer( self );

    foreach ( var_2 in level.players )
    {
        var_2 setclientomnvar( "ui_intel_timer", var_0 );
        var_2 thread wait_for_ability_use();
    }
}

no_abilities_timer( var_0 )
{
    level endon( "stop_watching_ability_use" );
    wait(var_0.goal);
    var_0._ID32046 = 1;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
    level notify( "stop_challenge_timer" );
    level notify( "stop_watching_ability_use" );
}

wait_for_ability_use()
{
    level endon( "stop_watching_ability_use" );
    common_scripts\utility::_ID35626( "action_finish_used", "class_skill_used" );
    maps\mp\alien\_unk1422::_ID34406( "no_abilities" );
    level notify( "stop_watching_ability_use" );
}

_ID34445( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
    level notify( "stop_challenge_timer" );
}

_ID34484( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
}

_ID22076()
{
    var_0 = 250;

    foreach ( var_2 in level.players )
        var_2 thread maps\mp\alien\_persistence::_ID15551( var_0 );
}

activate_melee_goons()
{
    reset_melee_goons_progress();
    _ID34408( 0, self.goal );
}

deactivate_melee_goons()
{
    reset_melee_goons_progress();
}

reset_melee_goons_progress()
{
    default_resetsuccess();
    self._ID8660 = 0;
}

_ID34439( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID8660 = self._ID8660 + var_0;

    if ( self._ID8660 >= self.goal )
        self._ID32046 = 1;

    var_9 = self.goal - self._ID8660;
    _ID34408( self._ID8660, self.goal );

    if ( self._ID32046 )
        maps\mp\alien\_unk1422::deactivate_current_challenge();
}

_ID2088()
{
    _ID26096();
}

_ID9016()
{
    _ID26096();
}

_ID26096()
{
    default_resetsuccess();
    self._ID8660 = 0;
}

update_melee_spitter( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID8660 = self._ID8660 + var_0;

    if ( self._ID8660 >= self.goal )
        self._ID32046 = 1;

    if ( self._ID32046 )
        maps\mp\alien\_unk1422::deactivate_current_challenge();
}

_ID34449( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
}

_ID34447( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
}

_ID34446( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
}

_ID2081()
{
    reset_kill_10_with_propane_progress();
    _ID34408( 0, self.goal );
}

_ID9009()
{
    reset_kill_10_with_propane_progress();
}

reset_kill_10_with_propane_progress()
{
    default_resetsuccess();
    self._ID8660 = 0;
}

_ID34431( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID8660 = self._ID8660 + var_0;

    if ( self._ID8660 >= self.goal )
        self._ID32046 = 1;

    var_9 = self.goal - self._ID8660;
    _ID34408( self._ID8660, self.goal );

    if ( self._ID32046 )
        maps\mp\alien\_unk1422::deactivate_current_challenge();
}

activate_kill_10_with_traps()
{
    reset_kill_10_with_traps_progress();
    _ID34408( 0, self.goal );
}

_ID9010()
{
    reset_kill_10_with_traps_progress();
}

reset_kill_10_with_traps_progress()
{
    default_resetsuccess();
    self._ID8660 = 0;
}

_ID34432( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID8660 = self._ID8660 + var_0;

    if ( self._ID8660 >= self.goal )
        self._ID32046 = 1;

    var_9 = self.goal - self._ID8660;
    _ID34408( self._ID8660, self.goal );

    if ( self._ID32046 )
        maps\mp\alien\_unk1422::deactivate_current_challenge();
}

activate_stay_prone()
{
    _ID26105();
    _ID34408( 0, self.goal );
}

_ID9021()
{
    _ID26105();
}

_ID26105()
{
    default_resetsuccess();
    self._ID8660 = 0;
}

_ID34480( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID8660 = self._ID8660 + var_0;

    if ( self._ID8660 >= self.goal )
        self._ID32046 = 1;

    var_9 = self.goal - self._ID8660;
    _ID34408( self._ID8660, self.goal );

    if ( self._ID32046 )
        maps\mp\alien\_unk1422::deactivate_current_challenge();
}

activate_protect_a_player()
{
    default_resetsuccess();
    var_0 = [];

    foreach ( var_2 in level.players )
    {
        if ( isalive( var_2 ) && !var_2 maps\mp\alien\_unk1464::_ID18437() )
            var_0[var_0.size] = var_2;
    }

    var_4 = common_scripts\utility::_ID25350( var_0 );

    foreach ( var_2 in level.players )
    {
        var_6 = var_4 getentitynumber();
        var_2 setclientomnvar( "ui_intel_target_player", var_6 );
    }

    level.current_challenge_target_player = var_4 getentitynumber();
    var_4 maps\mp\_entityheadicons::setheadicon( var_4.team, "waypoint_defend", ( 0, 0, 72 ), 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
    level thread _ID36022( var_4, self );
    level thread _ID35942( var_4, self );
}

_ID36022( var_0, var_1 )
{
    level endon( "drill_detonated" );
    var_0 common_scripts\utility::_ID35626( "death", "last_stand", "disconnect" );
    var_0 _ID25907();
    var_1._ID32046 = 0;
    _ID34465();
}

_ID34465()
{
    maps\mp\alien\_unk1422::deactivate_current_challenge();

    foreach ( var_1 in level.players )
        var_1 setclientomnvar( "ui_intel_target_player", -1 );

    level.current_challenge_target_player = -1;
}

_ID35942( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "last_stand" );
    var_0 endon( "disconnect" );
    level waittill( "drill_detonated" );
    var_0 _ID25907();
    _ID34465();
}

_ID25907()
{
    foreach ( var_2, var_1 in self._ID12149 )
    {
        if ( !isdefined( var_1 ) )
            continue;

        var_1 destroy();
    }
}

deactivate_protect_a_player()
{
    default_resetsuccess();
}

activate_avoid_minion_exp()
{
    default_resetsuccess();
}

deactivate_avoid_minion_exp()
{
    default_resetsuccess();
}

_ID34400( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
}

_ID34391( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID33150++;
}

_ID29212( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    return self.current_accuracy >= 75;
}

_ID12830( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    return self.current_accuracy >= 50;
}

_ID34390( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID33150++;
}

activate_percent_accuracy()
{
    default_resetsuccess();
    self._ID33149 = 0;
    self._ID33150 = 0;
    self.current_accuracy = 0;
    self._ID18509 = 0;
    level thread _ID33276( self );
    level thread _ID34450( self );
    _ID34407( 0 );
}

deactivate_percent_accuracy()
{
    default_resetsuccess();
    self._ID33149 = 0;
    self._ID33150 = 0;
    level notify( "deactivate_track_accuracy" );
}

activate_use_weapon_challenge()
{
    setup_challenge_waypoints( self );
    default_resetsuccess();
    self._ID8660 = 0;
    _ID34408( 0, self.goal );
}

_ID34458( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( maps\mp\_utility::getweaponclass( var_0 ) == "weapon_pistol" || maps\mp\alien\_unk1464::_ID18506( var_2 ) )
        self._ID8660++;

    _ID34408( self._ID8660, self.goal );

    if ( self._ID8660 >= self.goal )
    {
        self._ID32046 = 1;
        maps\mp\alien\_unk1422::deactivate_current_challenge();
    }
}

update_shotguns_only( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( maps\mp\_utility::getweaponclass( var_0 ) == "weapon_shotgun" || maps\mp\alien\_unk1464::_ID18506( var_2 ) )
        self._ID8660++;

    _ID34408( self._ID8660, self.goal );

    if ( self._ID8660 >= self.goal )
    {
        self._ID32046 = 1;
        maps\mp\alien\_unk1422::deactivate_current_challenge();
    }
}

_ID34476( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( maps\mp\_utility::getweaponclass( var_0 ) == "weapon_sniper" || maps\mp\alien\_unk1464::_ID18506( var_2 ) )
        self._ID8660++;

    _ID34408( self._ID8660, self.goal );

    if ( self._ID8660 >= self.goal )
    {
        self._ID32046 = 1;
        maps\mp\alien\_unk1422::deactivate_current_challenge();
    }
}

_ID34437( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( maps\mp\_utility::getweaponclass( var_0 ) == "weapon_lmg" || maps\mp\alien\_unk1464::_ID18506( var_2 ) )
        self._ID8660++;

    _ID34408( self._ID8660, self.goal );

    if ( self._ID8660 >= self.goal )
    {
        self._ID32046 = 1;
        maps\mp\alien\_unk1422::deactivate_current_challenge();
    }
}

_ID34399( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( maps\mp\_utility::getweaponclass( var_0 ) == "weapon_assault" || maps\mp\alien\_unk1464::_ID18506( var_2 ) )
        self._ID8660++;

    _ID34408( self._ID8660, self.goal );

    if ( self._ID8660 >= self.goal )
    {
        self._ID32046 = 1;
        maps\mp\alien\_unk1422::deactivate_current_challenge();
    }
}

_ID34475( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( maps\mp\_utility::getweaponclass( var_0 ) == "weapon_smg" || maps\mp\alien\_unk1464::_ID18506( var_2 ) )
        self._ID8660++;

    _ID34408( self._ID8660, self.goal );

    if ( self._ID8660 >= self.goal )
    {
        self._ID32046 = 1;
        maps\mp\alien\_unk1422::deactivate_current_challenge();
    }
}

activate_kill_10_with_turrets()
{
    _ID26091();
    _ID34408( 0, self.goal );
}

deactivate_kill_10_with_turrets()
{
    _ID26091();
}

_ID26091()
{
    default_resetsuccess();
    self._ID8660 = 0;
}

_ID34433( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID8660 = self._ID8660 + var_0;

    if ( self._ID8660 >= self.goal )
        self._ID32046 = 1;

    var_9 = self.goal - self._ID8660;
    _ID34408( self._ID8660, self.goal );

    if ( self._ID32046 )
        maps\mp\alien\_unk1422::deactivate_current_challenge();
}

activate_kill_airborne_aliens()
{
    _ID26092();
    _ID34408( 0, self.goal );
}

deactivate_kill_airborne_aliens()
{
    _ID26092();
}

_ID26092()
{
    default_resetsuccess();
    self._ID8660 = 0;
}

_ID34434( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID8660 = self._ID8660 + var_0;

    if ( self._ID8660 >= self.goal )
        self._ID32046 = 1;

    var_9 = self.goal - self._ID8660;
    _ID34408( self._ID8660, self.goal );

    if ( self._ID32046 )
        maps\mp\alien\_unk1422::deactivate_current_challenge();
}

activate_melee_only()
{
    _ID26095();
}

deactivate_melee_only()
{
    _ID26095();
}

_ID26095()
{
    default_resetsuccess();
}

_ID34440( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
}

_ID37838()
{
    var_0 = _ID37261( level.current_hive_name );
    var_1 = bullettrace( var_0 + ( 0, 0, 20 ), var_0 - ( 0, 0, 20 ), 0, undefined, 1, 0, 1, 1 );
    self._ID26314 = spawn( "script_model", var_1["position"] );
    self._ID26314 setmodel( "tag_origin" );
    wait 0.1;
    self.ring_fx = playfxontag( level._ID1644["challenge_ring"], self._ID26314, "tag_origin" );
    return 1;
}

activate_stay_within_area()
{
    default_resetsuccess();
    self._ID8660 = 0;
    self._ID10239 = 22500;
    _ID34408( 0, self.goal );
}

_ID34481( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( abs( var_1[2] - self._ID26314.origin[2] ) > 75 )
        return;

    var_9 = distancesquared( var_1, self._ID26314.origin );

    if ( var_9 > self._ID10239 )
        return;

    self._ID8660++;

    if ( self._ID8660 >= self.goal )
        self._ID32046 = 1;

    var_10 = self.goal - self._ID8660;
    _ID34408( self._ID8660, self.goal );

    if ( self._ID32046 )
        maps\mp\alien\_unk1422::deactivate_current_challenge();
}

_ID9022()
{
    level notify( "ring_challenge_ended" );
    self._ID8660 = 0;
    self._ID26314 delete();
    self.ring_fx = undefined;

    if ( isdefined( level.ring_waypoint_icon ) )
        level.ring_waypoint_icon destroy();

    default_resetsuccess();
}

activate_kill_10_in_30()
{
    default_resetsuccess();
    self._ID8660 = 0;
    var_0 = int( gettime() + 30000 );

    foreach ( var_2 in level.players )
        var_2 setclientomnvar( "ui_intel_timer", var_0 );

    level._ID8632 = 30;
    level thread _ID34410();
    _ID34408( 0, self.goal );
    level thread _ID19122( self );
}

_ID19122( var_0 )
{
    level endon( "game_ended" );
    self endon( "success" );
    wait 30;
    self._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
}

_ID34430( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID8660 = self._ID8660 + var_0;

    if ( self._ID8660 >= self.goal )
    {
        self._ID32046 = 1;
        self notify( "success" );
    }

    var_9 = self.goal - self._ID8660;
    _ID34408( self._ID8660, self.goal );

    if ( self._ID32046 )
        maps\mp\alien\_unk1422::deactivate_current_challenge();
}

_ID34395( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isdefined( level.current_challenge ) )
        return;

    var_9 = level.current_challenge;

    if ( isdefined( level._ID37054 ) )
    {
        var_10 = self [[ level._ID37054 ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );

        if ( !maps\mp\alien\_unk1464::_ID18506( var_10 ) )
            return;
    }

    var_11 = isdefined( var_1 ) && isplayer( var_1 );
    var_12 = isdefined( var_1 );
    var_13 = isdefined( var_0 ) && isplayer( var_0 );
    var_14 = isdefined( var_0 );
    var_15 = maps\mp\alien\_unk1464::_ID14264();
    var_16 = isdefined( var_4 );
    var_17 = 0;

    if ( var_16 )
        var_17 = _ID37528( var_4 );

    var_18 = 0;

    if ( var_14 )
        var_18 = maps\mp\alien\_unk1464::is_trap( var_0 );

    switch ( var_9 )
    {
        case "pistols_only":
        case "ar_only":
        case "smg_only":
        case "lmgs_only":
        case "shotguns_only":
        case "snipers_only":
            if ( var_16 && var_3 != "MOD_MELEE" )
            {
                var_19 = is_arc_death( var_0, var_1, var_12, var_11, var_14, var_13 );

                if ( !var_14 || var_13 || var_19 )
                {
                    if ( var_19 )
                        maps\mp\alien\_unk1422::_ID34406( var_9, var_4, var_3, var_19 );
                    else
                        maps\mp\alien\_unk1422::_ID34406( var_9, var_4, var_3 );
                }
            }

            break;
        case "melee_5_goons":
            if ( var_15 == "goon" && var_11 && var_3 == "MOD_MELEE" )
                maps\mp\alien\_unk1422::_ID34406( "melee_5_goons", 1 );

            break;
        case "melee_spitter":
            if ( var_15 == "spitter" && var_11 && var_3 == "MOD_MELEE" )
                maps\mp\alien\_unk1422::_ID34406( "melee_spitter", 1 );

            break;
        case "melee_only":
            if ( var_11 && var_3 != "MOD_MELEE" )
                maps\mp\alien\_unk1422::_ID34406( "melee_only" );

            break;
        case "kill_airborne_aliens":
            if ( var_11 && isdefined( self.trajectoryactive ) && self.trajectoryactive )
                maps\mp\alien\_unk1422::_ID34406( "kill_airborne_aliens", 1 );
            else if ( var_11 && ( maps\mp\alien\_unk1464::_ID18506( self.in_air ) || var_15 == "bomber" ) && var_3 != "MOD_SUICIDE" )
                maps\mp\alien\_unk1422::_ID34406( "kill_airborne_aliens", 1 );
            else if ( var_11 && var_15 == "ancestor" )
                maps\mp\alien\_unk1422::_ID34406( "kill_airborne_aliens", 1 );

            break;
        case "stay_prone":
            if ( ( var_11 || var_13 ) && var_1 getstance() == "prone" )
                maps\mp\alien\_unk1422::_ID34406( "stay_prone", 1 );

            break;
        case "kill_10_with_turrets":
            if ( var_11 && var_16 && maps\mp\alien\_damage::_ID18542( var_4 ) )
                maps\mp\alien\_unk1422::_ID34406( "kill_10_with_turrets", 1 );
            else if ( var_12 && isdefined( var_1.classname ) && var_1.classname == "misc_turret" && var_16 && maps\mp\alien\_damage::_ID18542( var_4 ) )
                maps\mp\alien\_unk1422::_ID34406( "kill_10_with_turrets", 1 );

            break;
        case "stay_within_area":
            if ( var_11 )
                maps\mp\alien\_unk1422::_ID34406( "stay_within_area", self.origin, var_1.origin );

            break;
        case "kill_10_in_30":
            if ( var_11 )
                maps\mp\alien\_unk1422::_ID34406( "kill_10_in_30", 1 );

            break;
        case "kill_10_with_propane":
            if ( var_16 && var_4 == "alienpropanetank_mp" )
                maps\mp\alien\_unk1422::_ID34406( "kill_10_with_propane", 1 );
            else if ( var_14 && isdefined( var_0.classname ) && var_0.classname == "trigger_radius" )
                maps\mp\alien\_unk1422::_ID34406( "kill_10_with_propane", 1 );

            break;
        case "kill_10_with_traps":
            if ( var_18 )
                maps\mp\alien\_unk1422::_ID34406( "kill_10_with_traps", 1 );

            break;
    }
}

is_arc_death( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    return var_2 && var_3 && var_4 && !var_5 && isdefined( var_1.stun_struct ) && isdefined( var_1.stun_struct.attack_bolt ) && var_0 == var_1.stun_struct.attack_bolt;
}

_ID34394( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    if ( !isdefined( level.current_challenge ) )
        return;

    if ( level.current_challenge == "melee_only" && var_4 != "MOD_MELEE" && !maps\mp\alien\_unk1464::is_flaming_stowed_riotshield_damage( var_4, var_5, var_0 ) && isplayer( var_1 ) )
        maps\mp\alien\_unk1422::_ID34406( "melee_only" );

    if ( isdefined( var_1 ) && isplayer( var_1 ) )
    {
        if ( isdefined( level._ID37053 ) )
        {
            var_11 = self [[ level._ID37053 ]]( var_0, var_1, var_2, var_4, var_5, var_7, var_8, var_9, var_10 );

            if ( !maps\mp\alien\_unk1464::_ID18506( var_11 ) )
                return;
        }

        var_1 endon( "disconnect" );
        common_scripts\utility::_ID35582();

        if ( isdefined( var_1.fired_weapon ) )
        {
            if ( isdefined( var_5 ) && var_5 == "alienpropanetank_mp" || var_5 == "spore_pet_beam_mp" )
                return;

            if ( isdefined( var_0 ) && isdefined( var_0.classname ) && var_0.classname == "trigger_radius" )
                return;

            if ( isdefined( var_4 ) && var_4 == "MOD_MELEE" )
                return;

            if ( var_3 & 8 )
                return;

            if ( maps\mp\alien\_damage::_ID37543( var_5 ) )
                return;

            if ( var_4 == "MOD_EXPLOSIVE_BULLET" && var_8 == "none" )
                return;

            if ( isdefined( var_5 ) && var_5 == "alienims_projectile_mp" )
                return;

            if ( isdefined( var_5 ) && maps\mp\_utility::getweaponclass( var_5 ) == "weapon_shotgun" )
                var_1.fired_weapon = undefined;

            if ( isdefined( level.current_challenge ) )
            {
                if ( level.current_challenge == "75_percent_accuracy" )
                    maps\mp\alien\_unk1422::_ID34406( "75_percent_accuracy", 1 );
                else if ( level.current_challenge == "50_percent_accuracy" )
                    maps\mp\alien\_unk1422::_ID34406( "50_percent_accuracy", 1 );
            }

            var_1.fired_weapon = undefined;
        }
    }
}

_ID37528( var_0 )
{
    switch ( var_0 )
    {
        case "alienbetty_mp":
        case "aliensemtex_mp":
        case "alienclaymore_mp":
        case "iw6_alienmk32_mp":
        case "iw6_alienmk321_mp":
        case "iw6_alienmk322_mp":
        case "iw6_alienmk323_mp":
        case "iw6_alienmk324_mp":
            return 1;
        default:
            return 0;
    }
}

_ID7449()
{
    self endon( "disconnect" );
    wait 0.05;
    self._ID19426 = undefined;
}

_ID34397( var_0, var_1 )
{
    if ( !isdefined( level.current_challenge ) )
        return;

    switch ( level.current_challenge )
    {
        case "pistols_only":
        case "ar_only":
        case "smg_only":
        case "lmgs_only":
        case "shotguns_only":
        case "snipers_only":
            maps\mp\alien\_unk1422::_ID34406( level.current_challenge, var_0, var_1 );
            break;
        default:
            return;
    }
}

_ID34408( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        var_3 setclientomnvar( "ui_intel_progress_current", int( var_0 ) );
        var_3 setclientomnvar( "ui_intel_progress_max", int( var_1 ) );
    }

    level.current_challenge_progress_max = var_1;
    level.current_challenge_progress_current = var_0;
}

_ID34407( var_0 )
{
    foreach ( var_2 in level.players )
        var_2 setclientomnvar( "ui_intel_percent", var_0 );

    level.current_challenge_percent = var_0;
}

_ID34450( var_0 )
{
    level endon( "deactivate_track_accuracy" );
    var_1 = 0;
    var_2 = 0;

    for (;;)
    {
        if ( var_0._ID33150 == 0 && var_0._ID33149 == 0 || var_0._ID33149 < 1 )
        {
            wait 0.25;
            continue;
        }

        var_3 = int( var_0._ID33150 / var_0._ID33149 * 10000 );

        if ( var_3 > 10000 )
            var_3 = 10000;

        var_4 = var_3 / 100;
        var_0.current_accuracy = var_4;

        if ( var_3 == var_1 )
        {
            var_2++;

            if ( var_2 > 2 )
            {
                _ID34407( var_3 );
                var_2 = 0;
            }
        }
        else
            var_2 = 0;

        wait 0.05;
        var_1 = var_3;
    }
}

_ID12632( var_0 )
{
    var_0._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
}

_ID33276( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( !isalive( var_2 ) )
            continue;

        var_2 thread _ID33277( var_0 );
    }
}

_ID33277( var_0 )
{
    level endon( "deactivate_track_accuracy" );
    self endon( "disconnect" );
    self endon( "death" );
    childthread track_percent_accuracy_misc_shots_fired( var_0 );

    for (;;)
    {
        self waittill( "weapon_fired",  var_1  );

        if ( !_ID36253( var_1 ) )
            continue;

        self.fired_weapon = 1;
        var_0._ID33149++;
    }
}

track_percent_accuracy_misc_shots_fired( var_0 )
{
    level endon( "deactivate_track_accuracy" );
    self endon( "disconnect" );
    self endon( "death" );

    for (;;)
    {
        common_scripts\utility::_ID35626( "turret_fire", "nx1_large_fire" );
        self.fired_weapon = 1;
        var_0._ID33149++;
    }
}

_ID34410()
{
    level endon( "stop_challenge_timer" );

    while ( level._ID8632 > 0 )
    {
        wait 0.1;
        level._ID8632 = level._ID8632 - 0.1;
    }
}

_ID36253( var_0 )
{
    switch ( var_0 )
    {
        case "bouncingbetty_mp":
        case "deployable_vest_marker_mp":
        case "alientrophy_mp":
        case "alienclaymore_mp":
        case "alienbomb_mp":
        case "mortar_detonator_mp":
        case "switchblade_laptop_mp":
        case "aliendeployable_crate_marker_mp":
        case "alienpropanetank_mp":
        case "alien_turret_marker_mp":
            return 0;
    }

    return 1;
}

get_challenge_scalar( var_0 )
{
    return [[ level._ID6850 ]]( var_0 );
}

_ID9356( var_0 )
{
    switch ( var_0 )
    {
        case "pistols_only":
        case "ar_only":
        case "smg_only":
        case "lmgs_only":
        case "shotguns_only":
        case "snipers_only":
            switch ( level.players.size )
            {
                case 1:
                    return 15;
                case 2:
                    return 20;
                case 3:
                case 4:
                    return 25;
            }
        case "kill_10_with_propane":
        case "kill_10_with_traps":
        case "kill_10_with_turrets":
            switch ( level.players.size )
            {
                case 1:
                    return 5;
                case 2:
                case 3:
                case 4:
                    return 10;
            }
        case "kill_10_in_30":
            switch ( level.players.size )
            {
                case 1:
                    return 5;
                case 2:
                case 3:
                case 4:
                    return 10;
            }
        case "stay_within_area":
            switch ( level.players.size )
            {
                case 1:
                    return 10;
                case 2:
                case 3:
                case 4:
                    return 20;
            }
        case "kill_airborne_aliens":
            switch ( level.players.size )
            {
                case 1:
                    return 3;
                case 2:
                case 3:
                case 4:
                    return 5;
            }
        case "stay_prone":
            switch ( level.players.size )
            {
                case 1:
                    return 15;
                case 2:
                case 3:
                case 4:
                    return 25;
            }
        case "spend_20k":
            switch ( level.players.size )
            {
                case 1:
                    return 6;
                case 2:
                    return 10;
                case 3:
                    return 15;
                case 4:
                    return 20;
            }
        case "spend_10k":
            switch ( level.players.size )
            {
                case 1:
                    return 6;
                case 2:
                case 3:
                case 4:
                    return 10;
            }
        case "melee_5_goons":
            switch ( level.players.size )
            {
                case 1:
                    return 5;
                case 2:
                    return 10;
                case 3:
                    return 10;
                case 4:
                    return 15;
            }
    }

    return undefined;
}

show_barrier_hive_intel()
{
    var_0 = 52;
    var_1 = 2;

    foreach ( var_3 in level.players )
    {
        var_3 setclientomnvar( "ui_intel_title", var_1 );
        var_3 setclientomnvar( "ui_intel_active_index", var_0 );
    }

    level.current_challenge_title = var_1;
    level.current_challenge_index = var_0;
}

_ID37425()
{
    foreach ( var_1 in level.players )
    {
        var_1 setclientomnvar( "ui_intel_active_index", -1 );
        var_1 setclientomnvar( "ui_intel_title", -1 );
    }

    level.current_challenge_title = -1;
    level.current_challenge_index = -1;
}

_ID37261( var_0 )
{
    if ( isdefined( level._ID36954 ) )
        return [[ level._ID36954 ]]( var_0 );

    return undefined;
}

create_challenge_waypoints( var_0 )
{
    var_1 = "waypoint_alien_weapon_challenge";
    var_2 = 14;
    var_3 = 14;
    var_4 = 0.75;
    var_5 = var_0.origin;

    if ( level.script == "mp_alien_armory" )
        var_4 = 0;

    var_6 = maps\mp\alien\_hud::_ID37645( var_1, var_2, var_3, var_4, var_5 );
    return var_6;
}

setup_challenge_waypoints( var_0 )
{
    var_1 = maps\mp\alien\_unk1464::_ID37267();
    var_2 = level.current_challenge;

    if ( var_2 == "pistols_only" )
        return;

    var_3 = get_challenge_weapons( var_1, var_2 );
    self.challenge_weapons = [];

    foreach ( var_5 in var_3 )
        self.challenge_weapons[self.challenge_weapons.size] = maps\mp\_utility::_ID14903( var_5 );
}

get_challenge_weapons( var_0, var_1 )
{
    var_2 = get_weapon_class_for_current_challenge( var_1 );

    if ( !isdefined( var_2 ) && var_1 == "semi_autos_only" )
        var_2 = [ "weapon_dmr", "weapon_sniper" ];

    var_3 = [];
    var_4 = [];

    foreach ( var_6 in level._ID36418 )
    {
        if ( level.script == "mp_alien_armory" )
        {
            if ( isdefined( var_6.script_noteworthy ) && var_6.script_noteworthy == "weapon_iw6_aliendlc15_mp" )
            {
                var_6._ID3788 = [];
                var_6._ID3788[0] = "checkpoint";
            }
        }

        if ( isdefined( var_6._ID3788 ) && var_6._ID3788[0] == var_0 )
        {
            if ( !isdefined( var_6.script_noteworthy ) )
                continue;

            var_7 = getsubstr( var_6.script_noteworthy, 7 );
            var_8 = maps\mp\_utility::getweaponclass( var_7 );

            if ( isarray( var_2 ) )
            {
                if ( common_scripts\utility::array_contains( var_2, var_8 ) )
                {
                    var_3[var_3.size] = var_7;
                    var_9 = create_challenge_waypoints( var_6 );
                    var_4[var_4.size] = var_9;
                }

                continue;
            }

            if ( var_2 != var_8 )
                continue;

            var_3[var_3.size] = var_7;
            var_9 = create_challenge_waypoints( var_6 );
            var_4[var_4.size] = var_9;
        }
    }

    self.waypoints = var_4;
    return var_3;
}

get_weapon_class_for_current_challenge( var_0 )
{
    switch ( var_0 )
    {
        case "ar_only":
            return "weapon_assault";
        case "snipers_only":
            return "weapon_sniper";
        case "smg_only":
            return "weapon_smg";
        case "lmgs_only":
            return "weapon_lmg";
        case "shotguns_only":
            return "weapon_shotgun";
    }
}

deactivate_weapon_challenge_waypoints()
{
    if ( isdefined( self ) && isdefined( self.waypoints ) )
    {
        foreach ( var_1 in self.waypoints )
            var_1 destroy();
    }

    default_resetsuccess();
}

focus_fire_update_alien_outline( var_0 )
{
    foreach ( var_0 in level.players )
    {
        if ( common_scripts\utility::array_contains( self._ID37068, var_0 ) )
        {
            if ( isdefined( var_0.isferal ) && var_0.isferal )
                maps\mp\alien\_outline_proto::enable_outline_for_player( self, var_0, 4, 0, "high" );
            else
                maps\mp\alien\_outline_proto::disable_outline_for_player( self, var_0 );

            continue;
        }

        maps\mp\alien\_outline_proto::enable_outline_for_player( self, var_0, 0, 0, "high" );
    }
}
