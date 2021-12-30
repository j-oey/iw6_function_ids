// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

init_beacon_eog_score_components( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        switch ( var_2 )
        {
            case "kraken":
                maps\mp\alien\_unk1443::_ID37878( "kraken", 17 );
                continue;
            case "item_crafting":
                maps\mp\alien\_unk1443::_ID37878( "item_crafting", 14 );
                continue;
            case "side_area":
                maps\mp\alien\_unk1443::_ID37878( "side_area", 15 );
                continue;
            case "relics":
                maps\mp\alien\_unk1443::_ID37878( "relics", 5 );
                continue;
        }

        endswitch( 5 )  case "relics" loc_57 case "side_area" loc_45 case "item_crafting" loc_33 case "kraken" loc_21 default loc_69
    }
}

init_beacon_encounter_score_components( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        switch ( var_2 )
        {
            case "kraken":
                init_kraken_score_component();
                continue;
            case "kraken_personal":
                init_kraken_personal_score_component();
                continue;
            case "kraken_team":
                init_kraken_team_score_component();
                continue;
            case "tentacle_bonus":
                init_tentacle_score_component();
                continue;
            case "item_crafting":
                init_item_crafting_score_component();
                continue;
            case "side_area":
                init_side_area_score_component();
                continue;
            case "gas":
                init_gas_protection_score_component();
                continue;
            case "progression_door":
                init_progression_door_score_component();
                continue;
        }

        endswitch( 9 )  case "progression_door" loc_102 case "tentacle_bonus" loc_DA case "kraken_team" loc_D0 case "kraken_personal" loc_C6 case "gas" loc_F8 case "side_area" loc_EE case "item_crafting" loc_E4 case "kraken" loc_BC default loc_10C
    }
}

init_kraken_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "kraken", ::init_kraken_score, maps\mp\alien\_globallogic::blank, undefined, ::calculate_kraken_score_component, 17, "kraken" );
}

init_kraken_score( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        var_0.max_score_kraken = 6000;
    else
        var_0.max_score_kraken = 4500;

    var_0._ID38146["kraken_battle_time"] = 0;
    return var_0;
}

calculate_kraken_score_component( var_0, var_1 )
{
    var_2 = maps\mp\alien\_unk1443::_ID37337( var_1, "kraken_battle_time" );
    var_3 = max( 0, 750000 - var_2 );
    var_4 = var_1.max_score_kraken * var_3 / 750000;
    return int( var_4 );
}

init_kraken_personal_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "kraken_personal", ::init_kraken_personal_score, undefined, maps\mp\alien\_unk1443::_ID37899, maps\mp\alien\_unk1443::calculate_personal_skill_score, 17, "kraken" );
}

init_kraken_personal_score( var_0 )
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

init_kraken_team_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "kraken_team", maps\mp\alien\_unk1443::_ID37485, maps\mp\alien\_unk1443::_ID37904, maps\mp\alien\_unk1443::_ID37900, maps\mp\alien\_unk1443::_ID6447, 17, "kraken" );
}

calculate_kraken_score( var_0 )
{
    maps\mp\alien\_unk1443::_ID38222( "kraken", "kraken_battle_time", var_0 );
    var_1 = get_kraken_score_component_name_list();
    maps\mp\alien\_unk1443::_ID36928( level.players, var_1 );
}

get_kraken_score_component_name_list()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        return [ "kraken", "kraken_personal" ];
    else
        return [ "kraken", "kraken_team", "kraken_personal" ];
}

init_tentacle_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "tentacle_bonus", ::init_tentacle_score, maps\mp\alien\_globallogic::blank, undefined, ::calculate_tentacle_score, 18, "hive" );
}

init_tentacle_score( var_0 )
{
    var_0._ID38146["tentacle_start_HP"] = 0;
    return var_0;
}

calculate_tentacle_score( var_0, var_1 )
{
    var_2 = maps\mp\alien\_unk1443::_ID37337( var_1, "tentacle_start_HP" );
    var_3 = get_tentacle_end_hp();
    var_4 = min( var_2, var_2 - var_3 );
    return int( 2500 * var_4 / var_2 );
}

get_tentacle_end_hp()
{
    if ( !isdefined( level.miniboss.hp ) )
        return 0;

    return max( 0, level.miniboss.hp );
}

init_item_crafting_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "item_crafting", ::blank_score_component_init, maps\mp\alien\_globallogic::blank, undefined, ::calculate_item_crafting_score, 14, "item_crafting" );
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

init_side_area_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "side_area", ::blank_score_component_init, maps\mp\alien\_globallogic::blank, undefined, ::calculate_side_area_score, 15, "side_area" );
}

calculate_side_area_score( var_0, var_1 )
{
    return 2000;
}

init_progression_door_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "progression_door", ::blank_score_component_init, maps\mp\alien\_globallogic::blank, undefined, ::calculate_progression_door_score, 15, "hive" );
}

calculate_progression_door_score( var_0, var_1 )
{
    return 2000;
}

init_gas_protection_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "gas", ::blank_score_component_init, ::reset_team_gas_protection_score, undefined, ::calculate_gas_protection_score, 16, "hive" );
}

reset_team_gas_protection_score( var_0 )
{
    var_0._ID38146["num_valve_destroyed"] = 0;
}

calculate_gas_protection_score( var_0, var_1 )
{
    var_2 = maps\mp\alien\_unk1443::_ID37337( var_1, "num_valve_destroyed" );
    var_3 = max( 0, 4 - var_2 );
    return int( var_3 * 500 );
}

blank_score_component_init( var_0 )
{
    return var_0;
}
