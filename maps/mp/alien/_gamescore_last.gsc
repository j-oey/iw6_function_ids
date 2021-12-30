// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

init_last_eog_score_components( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        switch ( var_2 )
        {
            case "street":
                maps\mp\alien\_unk1443::_ID37878( "street", 24 );
                continue;
            case "relics":
                maps\mp\alien\_unk1443::_ID37878( "relics", 5 );
                continue;
            case "generator":
                maps\mp\alien\_unk1443::_ID37878( "generator", 25 );
                continue;
            case "cortex":
                maps\mp\alien\_unk1443::_ID37878( "cortex", 29 );
                continue;
            case "item_crafting":
                maps\mp\alien\_unk1443::_ID37878( "item_crafting", 27 );
                continue;
            case "ancestor_bonus":
                maps\mp\alien\_unk1443::_ID37878( "ancestor_bonus", 28 );
                continue;
        }

        endswitch( 7 )  case "street" loc_21 case "ancestor_bonus" loc_7B case "cortex" loc_57 case "generator" loc_45 case "item_crafting" loc_69 case "relics" loc_33 default loc_8D
    }
}

init_last_encounter_score_components( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        switch ( var_2 )
        {
            case "street_personal":
                init_street_personal_score_component();
                continue;
            case "street_team":
                init_street_team_score_component();
                continue;
            case "street_challenge":
                init_street_challenge_score_component();
                continue;
            case "generator":
                init_generator_score_component();
                continue;
            case "generator_personal":
                init_generator_personal_score_component();
                continue;
            case "generator_team":
                init_generator_team_score_component();
                continue;
            case "generator_challenge":
                init_generator_challenge_score_component();
                continue;
            case "item_crafting":
                init_item_crafting_score_component();
                continue;
            case "ancestor_bonus":
                init_ancestor_bonus_score_component();
                continue;
            case "cortex":
                init_cortex_score_component();
                continue;
        }

        endswitch( 11 )  case "generator_team" loc_120 case "generator_challenge" loc_12A case "generator_personal" loc_116 case "street_team" loc_F8 case "street_challenge" loc_102 case "street_personal" loc_EE case "ancestor_bonus" loc_13E case "cortex" loc_148 case "generator" loc_10C case "item_crafting" loc_134 default loc_152
    }
}

init_street_personal_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "street_personal", ::init_street_personal_score, undefined, maps\mp\alien\_unk1443::_ID37899, maps\mp\alien\_unk1443::calculate_personal_skill_score, 3, "street" );
}

init_street_personal_score( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        var_0._ID37659 = 5000;
        var_0._ID37656 = 3500;
    }
    else
    {
        var_0._ID37659 = 2200;
        var_0._ID37656 = 1700;
    }

    return var_0;
}

init_street_team_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "street_team", ::init_street_teamwork_score, maps\mp\alien\_unk1443::_ID37904, maps\mp\alien\_unk1443::_ID37900, maps\mp\alien\_unk1443::_ID6447, 2, "street" );
}

init_street_teamwork_score( var_0 )
{
    var_0._ID37660 = 1700;
    var_0._ID37661 = 1700;
    var_0._ID37657 = 1700;
    maps\mp\alien\_unk1443::_ID37904( var_0 );
    return var_0;
}

init_street_challenge_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "street_challenge", maps\mp\alien\_unk1443::_ID37456, undefined, maps\mp\alien\_unk1443::_ID37895, maps\mp\alien\_unk1443::calculate_challenge_score, 4, "street" );
}

init_generator_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "generator", maps\mp\alien\_unk1443::_ID37463, maps\mp\alien\_unk1443::_ID37902, undefined, maps\mp\alien\_unk1443::calculate_drill_protection_score, 26, "generator" );
}

init_generator_personal_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "generator_personal", maps\mp\alien\_unk1443::_ID37476, undefined, maps\mp\alien\_unk1443::_ID37899, maps\mp\alien\_unk1443::calculate_personal_skill_score, 3, "generator" );
}

init_generator_team_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "generator_team", maps\mp\alien\_unk1443::_ID37485, maps\mp\alien\_unk1443::_ID37904, maps\mp\alien\_unk1443::_ID37900, maps\mp\alien\_unk1443::_ID6447, 2, "generator" );
}

init_generator_challenge_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "generator_challenge", maps\mp\alien\_unk1443::_ID37456, undefined, maps\mp\alien\_unk1443::_ID37895, maps\mp\alien\_unk1443::calculate_challenge_score, 4, "generator" );
}

init_item_crafting_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "item_crafting", ::blank_score_component_init, maps\mp\alien\_globallogic::blank, undefined, ::calculate_item_crafting_score, 27, "item_crafting" );
}

calculate_item_crafting_score( var_0, var_1 )
{
    var_2 = int( 500 / level.cycle_score_scalar );
    var_3 = get_total_item_crafting_score( var_0, var_1 );
    return min( var_2, 5000 - var_3 );
}

get_total_item_crafting_score( var_0, var_1 )
{
    return var_0.end_game_score[var_1._ID37171];
}

init_ancestor_bonus_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "ancestor_bonus", ::blank_score_component_init, ::reset_team_ancestor_bonus_performance, undefined, ::calculate_ancestor_bonus_score, 28, "ancestor_bonus" );
}

reset_team_ancestor_bonus_performance( var_0 )
{
    var_0._ID38146["num_ancestor_killed"] = 0;
    var_0._ID38146["encounter_start_time"] = gettime();
    return var_0;
}

calculate_ancestor_bonus_score( var_0, var_1 )
{
    var_2 = gettime() - var_1._ID38146["encounter_start_time"];
    return maps\mp\alien\_unk1443::calculate_under_max_score( var_2, 300000, 10000 );
}

init_cortex_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "cortex", ::init_cortex_score, ::reset_team_cortex_performance, undefined, ::calculate_cortex_score, 29, "cortex" );
}

init_cortex_score( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        var_0.max_cortex_damage_limit = 1200;
    else
        var_0.max_cortex_damage_limit = 750;

    return var_0;
}

reset_team_cortex_performance( var_0 )
{
    var_0._ID38146["damage_done_on_cortex"] = 0;
    var_0._ID38146["reach_charge_goal"] = 0;
    return var_0;
}

calculate_cortex_score( var_0, var_1 )
{
    var_2 = maps\mp\alien\_unk1443::_ID37337( var_1, "damage_done_on_cortex" );
    var_3 = maps\mp\alien\_unk1443::calculate_under_max_score( var_2, var_1.max_cortex_damage_limit, 8000 );
    var_4 = maps\mp\alien\_unk1443::_ID37337( var_1, "reach_charge_goal" ) * 2000;
    return int( var_3 + var_4 );
}

update_cortex_charge_bonus( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_1 = var_0 * 25;

    if ( maps\mp\mp_alien_last_final_battle::get_cortex_charge_percent() >= var_1 )
    {
        maps\mp\alien\_unk1443::_ID38222( "cortex", "reach_charge_goal" );
        return;
    }
}

init_partial_hive_score_component_list_func()
{
    level.partial_hive_score_component_list_func = ::last_partial_hive_score_component_list;
}

last_partial_hive_score_component_list()
{
    return [ "street_challenge", "street_team" ];
}

update_generator_score_component_name()
{
    maps\mp\alien\_unk1443::set_challenge_score_component_name( "generator_challenge" );
    maps\mp\alien\_unk1443::set_personal_score_component_name( "generator_personal" );
    maps\mp\alien\_unk1443::set_team_score_component_name( "generator_team" );
}

update_street_score_component_name()
{
    maps\mp\alien\_unk1443::set_challenge_score_component_name( "street_challenge" );
    maps\mp\alien\_unk1443::set_personal_score_component_name( "street_personal" );
    maps\mp\alien\_unk1443::set_team_score_component_name( "street_team" );
}

blank_score_component_init( var_0 )
{
    return var_0;
}
