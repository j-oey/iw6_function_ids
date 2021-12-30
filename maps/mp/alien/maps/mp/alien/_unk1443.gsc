// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

init_gamescore()
{
    _ID25696();
}

_ID37466( var_0 )
{
    level._ID37179 = [];

    foreach ( var_2 in var_0 )
    {
        switch ( var_2 )
        {
            case "hive":
                _ID37878( "hive", 8 );
                continue;
            case "escape":
                _ID37878( "escape", 9 );
                continue;
            case "relics":
                _ID37878( "relics", 5 );
                continue;
        }

        endswitch( 4 )  case "relics" loc_50 case "hive" loc_2C case "escape" loc_3E default loc_62
    }
}

_ID37465( var_0 )
{
    level._ID37168 = [];

    foreach ( var_2 in var_0 )
    {
        switch ( var_2 )
        {
            case "challenge":
                _ID37457();
                continue;
            case "drill":
                _ID37464();
                continue;
            case "team":
                _ID37486();
                continue;
            case "team_blocker":
                _ID37453();
                continue;
            case "personal":
                _ID37477();
                continue;
            case "personal_blocker":
                _ID37452();
                continue;
            case "escape":
                _ID37469();
                continue;
        }

        endswitch( 8 )  case "personal_blocker" loc_E4 case "team_blocker" loc_D0 case "personal" loc_DA case "drill" loc_BC case "challenge" loc_B2 case "escape" loc_EE case "team" loc_C6 default loc_F8
    }
}

init_player_score()
{
    if ( is_scoring_disabled() )
        return;

    self._ID37167 = [];
    self.end_game_score = [];
    component_specific_init( self );
    _ID37897( self );
    _ID26084();
}

_ID37894()
{
    foreach ( var_2, var_1 in level._ID37168 )
    {
        if ( isdefined( var_1._ID37903 ) )
            [[ var_1._ID37903 ]]( var_1 );
    }

    _ID37901();
}

_ID37901()
{
    foreach ( var_1 in level.players )
    {
        _ID37897( var_1 );
        maps\mp\alien\_hud::_ID37896( var_1 );
    }
}

component_specific_init( var_0 )
{
    foreach ( var_3, var_2 in level._ID37168 )
    {
        if ( isdefined( var_2.player_init_func ) )
            [[ var_2.player_init_func ]]( var_0 );
    }
}

_ID37897( var_0 )
{
    foreach ( var_3, var_2 in level._ID37168 )
    {
        if ( isdefined( var_2._ID37898 ) )
            [[ var_2._ID37898 ]]( var_0 );
    }
}

_ID26084()
{
    foreach ( var_2, var_1 in level._ID37179 )
        self.end_game_score[var_2] = 0;
}

calculate_total_end_game_score( var_0 )
{
    var_1 = 1;
    var_2 = 0;

    foreach ( var_6, var_4 in level._ID37179 )
    {
        var_5 = var_0.end_game_score[var_6];
        maps\mp\alien\_hud::_ID37952( var_0, var_1, var_4._ID37642, var_5 );
        var_1++;
        var_2 += var_5;
    }

    maps\mp\alien\_hud::_ID37952( var_0, var_1, 10, var_2 );
}

calculate_players_total_end_game_score()
{
    if ( is_scoring_disabled() )
        return;

    if ( common_scripts\utility::flag_exist( "drill_drilling" ) && common_scripts\utility::_ID13177( "drill_drilling" ) )
        _ID36928( level.players, get_partial_hive_score_component_list() );

    foreach ( var_1 in level.players )
        calculate_total_end_game_score( var_1 );
}

get_partial_hive_score_component_list()
{
    if ( isdefined( level.partial_hive_score_component_list_func ) )
        return [[ level.partial_hive_score_component_list_func ]]();

    return [ "challenge", "team" ];
}

_ID38219( var_0, var_1, var_2 )
{
    foreach ( var_4 in level.players )
        var_4 _ID38217( var_0, var_1, var_2 );
}

_ID36926( var_0, var_1 )
{
    _ID36928( var_0, var_1 );
    maps\mp\alien\_hud::_ID38031();
}

_ID36928( var_0, var_1 )
{
    foreach ( var_3 in var_0 )
        _ID36932( var_3, var_1 );
}

_ID36932( var_0, var_1 )
{
    var_2 = 1;
    var_3 = 0;

    foreach ( var_5 in var_1 )
    {
        var_6 = level._ID37168[var_5];
        var_7 = [[ var_6._ID36931 ]]( var_0, var_6 );
        var_7 *= level.cycle_score_scalar;
        var_7 = int( var_7 );
        var_0.end_game_score[var_6._ID37171] = var_0.end_game_score[var_6._ID37171] + var_7;
        maps\mp\alien\_hud::_ID37951( var_0, var_2, var_6._ID37642, var_7 );
        var_3 += var_7;
        var_2++;
    }

    var_9 = var_0 maps\mp\alien\_prestige::_ID14611();
    var_10 = int( var_3 * var_9 * 0.2 );
    var_0.end_game_score["relics"] = var_0.end_game_score["relics"] + var_10;
    maps\mp\alien\_hud::_ID37951( var_0, var_2, 5, var_10 );
    var_2++;
    var_3 += var_10;
    var_0 maps\mp\alien\_persistence::eog_player_update_stat( "score", var_3 );
    maps\mp\alien\_hud::_ID37951( var_0, var_2, 6, var_3 );
    var_2++;
    var_11 = var_0 maps\mp\alien\_perk_utility::_ID23427();
    var_12 = var_0 maps\mp\alien\_prestige::prestige_getmoneyearnedscalar();
    var_13 = int( var_3 * var_11 * var_12 * 0.1 / level.cycle_score_scalar );
    var_13 = round_up_to_nearest( var_13, 10 );
    maps\mp\alien\_hud::_ID37951( var_0, var_2, 7, var_13 );
    var_0._ID37169 = var_3;
    var_0._ID37162 = var_13;
}

_ID37457()
{
    _ID37877( "challenge", ::_ID37456, undefined, ::_ID37895, ::calculate_challenge_score, 4, "hive" );
}

_ID37456( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        var_0._ID37655 = 1500;
    else
        var_0._ID37655 = 1000;

    return var_0;
}

_ID37895( var_0 )
{
    var_0._ID37167["challenge_complete"] = 0;
}

calculate_challenge_score( var_0, var_1 )
{
    return int( var_0._ID37167["challenge_complete"] * var_1._ID37655 );
}

get_challenge_score_component_name()
{
    return common_scripts\utility::_ID32831( isdefined( level.challenge_score_component_name ), level.challenge_score_component_name, "challenge" );
}

set_challenge_score_component_name( var_0 )
{
    level.challenge_score_component_name = var_0;
}

_ID37464()
{
    _ID37877( "drill", ::_ID37463, ::_ID37902, undefined, ::calculate_drill_protection_score, 1, "hive" );
}

_ID37463( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        var_0._ID37658 = 4500;
        var_0.max_drill_damage_limit = 1200;
    }
    else
    {
        var_0._ID37658 = 3500;
        var_0.max_drill_damage_limit = 750;
    }

    return var_0;
}

_ID37902( var_0 )
{
    var_0._ID38146["drill_damage_taken"] = 0;
    return var_0;
}

calculate_drill_protection_score( var_0, var_1 )
{
    var_2 = _ID37337( var_1, "drill_damage_taken" ) / var_1.max_drill_damage_limit;
    var_3 = max( 0, 1 - var_2 );
    var_4 = var_1._ID37658;
    var_5 = var_4 * var_3;
    return int( var_5 );
}

get_drill_score_component_name()
{
    return common_scripts\utility::_ID32831( isdefined( level.drill_score_component_name ), level.drill_score_component_name, "drill" );
}

set_drill_score_component_name( var_0 )
{
    level.drill_score_component_name = var_0;
}

_ID37486()
{
    _ID37877( "team", ::_ID37485, ::_ID37904, ::_ID37900, ::_ID6447, 2, "hive" );
}

_ID37485( var_0 )
{
    var_0._ID37660 = 1000;
    var_0._ID37661 = 1000;
    var_0._ID37657 = 1000;
    _ID37904( var_0 );
    return var_0;
}

_ID37904( var_0 )
{
    var_0._ID38146["damage_done_on_alien"] = 0;
    var_0._ID38146["num_players_enter_laststand"] = 0;
    var_0._ID38146["num_players_bleed_out"] = 0;
    return var_0;
}

_ID37900( var_0 )
{
    var_0._ID37167["damage_done_on_alien"] = 0;
    var_0._ID37167["team_support_deploy"] = 0;
}

_ID6447( var_0, var_1 )
{
    var_2 = var_1._ID37660;
    var_3 = min( var_2, _ID37307( var_0, "team_support_deploy" ) * 100 );

    if ( _ID37337( var_1, "num_players_bleed_out" ) )
        var_4 = 0;
    else
    {
        var_5 = var_1._ID37661;
        var_6 = _ID37337( var_1, "num_players_enter_laststand" ) * 200;
        var_4 = max( 0, var_5 - var_6 );
    }

    var_7 = _ID37337( var_1, "damage_done_on_alien" );

    if ( var_7 == 0 )
        var_7 = 1;

    var_8 = _ID37307( var_0, "damage_done_on_alien" ) / var_7;
    var_9 = var_1._ID37657;
    var_10 = var_9 * level.players.size;
    var_11 = min( var_9, var_8 * var_10 );
    return int( var_3 + var_4 + var_11 );
}

get_team_score_component_name()
{
    return common_scripts\utility::_ID32831( isdefined( level.team_score_component_name ), level.team_score_component_name, "team" );
}

set_team_score_component_name( var_0 )
{
    level.team_score_component_name = var_0;
}

_ID37453()
{
    _ID37877( "team_blocker", ::_ID37455, ::_ID37904, ::_ID37900, ::_ID6447, 2, "hive" );
}

_ID37455( var_0 )
{
    var_0._ID37660 = 2000;
    var_0._ID37661 = 1000;
    var_0._ID37657 = 2500;
    _ID37904( var_0 );
    return var_0;
}

_ID37477()
{
    _ID37877( "personal", ::_ID37476, undefined, ::_ID37899, ::calculate_personal_skill_score, 3, "hive" );
}

_ID37476( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        var_0._ID37659 = 2500;
        var_0._ID37656 = 1500;
    }
    else
    {
        var_0._ID37659 = 1500;
        var_0._ID37656 = 1000;
    }

    return var_0;
}

_ID37899( var_0 )
{
    var_0._ID37167["damage_taken"] = 0;
    var_0._ID37167["shots_hit"] = 0;
    var_0._ID37167["shots_fired"] = 0;
}

calculate_personal_skill_score( var_0, var_1 )
{
    var_2 = _ID37307( var_0, "damage_taken" ) / 500;
    var_3 = max( 0, 1 - var_2 );
    var_4 = var_1._ID37659;
    var_5 = var_4 * var_3;

    if ( _ID37307( var_0, "shots_fired" ) == 0 )
        var_6 = 1.0;
    else
        var_6 = _ID37307( var_0, "shots_hit" ) / _ID37307( var_0, "shots_fired" );

    var_6 = min( 1.0, var_6 );
    var_7 = var_1._ID37656;
    var_8 = var_7 * var_6;
    return int( var_5 + var_8 );
}

get_personal_score_component_name()
{
    return common_scripts\utility::_ID32831( isdefined( level.personal_score_component_name ), level.personal_score_component_name, "personal" );
}

set_personal_score_component_name( var_0 )
{
    level.personal_score_component_name = var_0;
}

_ID37452()
{
    _ID37877( "personal_blocker", ::_ID37454, undefined, ::_ID37899, ::calculate_personal_skill_score, 3, "hive" );
}

_ID37454( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        var_0._ID37659 = 5500;
        var_0._ID37656 = 4500;
    }
    else
    {
        var_0._ID37659 = 2500;
        var_0._ID37656 = 2000;
    }

    return var_0;
}

_ID37469()
{
    _ID37877( "escape", ::_ID37468, undefined, undefined, ::_ID36929, 9, "escape" );
}

_ID37468( var_0 )
{
    var_0._ID38146["time_remain_ms"] = 0;
    var_0._ID38146["escape_player_ratio"] = 0;
    return var_0;
}

_ID36929( var_0, var_1 )
{
    var_2 = _ID37337( var_1, "time_remain_ms" ) / 240000;
    var_3 = 1 + ( var_0 maps\mp\alien\_prestige::_ID14611() + 1 ) * 0.2;
    var_4 = int( 15000 + 15000 * var_2 * _ID37337( var_1, "escape_player_ratio" ) * var_3 );
    return var_4;
}

_ID25028( var_0, var_1 )
{
    var_2 = var_1.size / level.players.size;
    _ID38222( "escape", "time_remain_ms", var_0 );
    _ID38222( "escape", "escape_player_ratio", var_2 );
    _ID36928( var_1, [ "escape" ] );
}

_ID38217( var_0, var_1, var_2 )
{
    if ( !_ID37414( var_0 ) )
        return;

    if ( !isplayer( self ) )
        return;

    self._ID37167 = _ID38203( self._ID37167, var_1, var_2 );
}

_ID38222( var_0, var_1, var_2 )
{
    if ( !_ID37414( var_0 ) )
        return;

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    level._ID37168[var_0]._ID38146[var_1] = level._ID37168[var_0]._ID38146[var_1] + var_2;
}

_ID38203( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1;

    var_0[var_1] += var_2;
    return var_0;
}

_ID25696()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        setomnvar( "ui_alien_is_solo", 1 );
        return;
    }

    setomnvar( "ui_alien_is_solo", 0 );
    return;
}

_ID37337( var_0, var_1 )
{
    return var_0._ID38146[var_1];
}

_ID37307( var_0, var_1 )
{
    return var_0._ID37167[var_1];
}

_ID37414( var_0 )
{
    return _ID37419( level._ID37168, var_0 );
}

_ID37415( var_0 )
{
    return _ID37419( level._ID37179, var_0 );
}

_ID37419( var_0, var_1 )
{
    if ( is_scoring_disabled() )
        return 0;

    return isdefined( var_0[var_1] );
}

_ID37878( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2._ID37642 = var_1;
    level._ID37179[var_0] = var_2;
}

_ID37877( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = spawnstruct();
    var_8 = [[ var_1 ]]( var_8 );
    var_8._ID37903 = var_2;
    var_8._ID37898 = var_3;
    var_8._ID36931 = var_4;
    var_8._ID37642 = var_5;
    var_8._ID37171 = var_6;

    if ( isdefined( var_7 ) )
        var_8.player_init_func = var_7;

    level._ID37168[var_0] = var_8;
}

_ID34451( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.classname ) && var_0.classname == "script_vehicle" )
        return;

    if ( var_2 == "MOD_TRIGGER_HURT" )
        return;

    _ID38222( get_team_score_component_name(), "damage_done_on_alien", var_1 );
    var_3 = get_personal_score_component_name();

    if ( isplayer( var_0 ) )
    {
        var_0 _ID38217( var_3, "damage_done_on_alien", var_1 );
        return;
    }

    if ( isdefined( var_0.owner ) )
    {
        var_0.owner _ID38217( var_3, "damage_done_on_alien", var_1 );
        return;
    }

    return;
}

_ID15524( var_0, var_1 )
{
    if ( self.agentteam == "allies" )
        return;

    if ( maps\mp\alien\_unk1464::_ID14264() == "elite" || maps\mp\alien\_unk1464::_ID14264() == "mammoth" )
    {
        var_2 = _ID14726();

        foreach ( var_4 in level.players )
            givekillreward( var_4, var_2, "large" );

        return;
    }

    if ( isdefined( self.attacker_damage ) )
    {
        var_6 = 0.1;
        var_7 = self._ID20697 * var_6;
        var_8 = _ID14890();

        foreach ( var_10 in self.attacker_damage )
        {
            if ( var_10.player == var_0 || isdefined( var_0.owner ) && var_10.player == var_0.owner )
                continue;

            if ( var_10.damage >= var_7 )
            {
                if ( isdefined( var_10.player ) && var_10.player != var_0 )
                {
                    var_10.player maps\mp\alien\_persistence::eog_player_update_stat( "assists", 1 );
                    givekillreward( var_10.player, var_8 );
                }
            }
        }
    }

    if ( !isdefined( var_0 ) )
        return;

    if ( !isplayer( var_0 ) && ( !isdefined( var_0.owner ) || !isplayer( var_0.owner ) ) )
        return;

    var_12 = 0;

    if ( isdefined( var_0.owner ) )
    {
        var_0 = var_0.owner;
        var_12 = 1;
    }

    var_2 = _ID14726();

    if ( isdefined( var_1 ) && var_1 == "soft" && !var_12 )
        var_2 = int( var_2 * 1.5 );

    givekillreward( var_0, var_2, "large", var_1 );
}

givekillreward( var_0, var_1, var_2, var_3 )
{
    var_4 = var_1 * level.cycle_reward_scalar;
    var_0 maps\mp\alien\_persistence::_ID15551( var_4, var_2, var_3 );

    if ( isdefined( level.alien_xp ) )
        var_0 maps\mp\alien\_persistence::give_player_xp( int( var_4 ) );

    if ( common_scripts\utility::flag_exist( "cortex_started" ) && common_scripts\utility::_ID13177( "cortex_started" ) )
    {
        if ( isdefined( level.add_cortex_charge_func ) )
        {
            [[ level.add_cortex_charge_func ]]( var_1 );
            return;
        }

        return;
    }
}

giveassistbonus( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( !isplayer( var_0 ) && ( !isdefined( var_0.owner ) || !isplayer( var_0.owner ) ) )
        return;

    if ( isdefined( var_0.owner ) )
        var_0 = var_0.owner;

    if ( !isdefined( self.attacker_damage ) )
        self.attacker_damage = [];

    foreach ( var_3 in self.attacker_damage )
    {
        if ( var_3.player == var_0 )
        {
            var_3.damage = var_3.damage + var_1;
            return;
        }
    }

    var_5 = spawnstruct();
    var_5.player = var_0;
    var_5.damage = var_1;
    self.attacker_damage[self.attacker_damage.size] = var_5;
}

_ID14890()
{
    return level._ID2829[maps\mp\alien\_unk1464::_ID14264()].attributes["reward"] * 0.5;
}

_ID14726()
{
    return level._ID2829[maps\mp\alien\_unk1464::_ID14264()].attributes["reward"];
}

round_up_to_nearest( var_0, var_1 )
{
    var_2 = var_0 / var_1;
    var_2 = ceil( var_2 );
    return int( var_2 * var_1 );
}

is_scoring_disabled()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        return 1;

    return 0;
}

calculate_under_max_score( var_0, var_1, var_2 )
{
    var_3 = clamp( var_1 - var_0, 0, var_1 );
    return int( var_3 / var_1 * var_2 );
}
