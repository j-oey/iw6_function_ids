// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

init_descent_eog_score_components( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        switch ( var_2 )
        {
            case "hive":
                maps\mp\alien\_unk1443::_ID37878( "hive", 19 );
                continue;
            case "gryphon":
                maps\mp\alien\_unk1443::_ID37878( "gryphon", 20 );
                continue;
            case "ark":
                maps\mp\alien\_unk1443::_ID37878( "ark", 22 );
                continue;
            case "escape":
                maps\mp\alien\_unk1443::_ID37878( "escape", 9 );
                continue;
            case "relics":
                maps\mp\alien\_unk1443::_ID37878( "relics", 5 );
                continue;
        }

        endswitch( 6 )  case "ark" loc_45 case "relics" loc_69 case "hive" loc_21 case "gryphon" loc_33 case "escape" loc_57 default loc_7B
    }
}

_ID37465( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        switch ( var_2 )
        {
            case "gryphon":
                init_gryphon_score_component();
                continue;
            case "gryphon_team":
                init_gryphon_team_score_component();
                continue;
            case "gryphon_personal":
                init_gryphon_personal_score_component();
                continue;
            case "cortex":
                init_cortex_score_component();
                continue;
            case "cortex_team":
                init_cortex_team_component();
                continue;
            case "cortex_personal":
                init_cortex_personal_component();
                continue;
            case "escape":
                init_escape_component();
                continue;
            case "escape_team":
                init_escape_team_component();
                continue;
            case "escape_personal":
                init_escape_personal_component();
                continue;
        }

        endswitch( 10 )  case "cortex" loc_F3 case "escape_personal" loc_125 case "escape_team" loc_11B case "cortex_personal" loc_107 case "cortex_team" loc_FD case "gryphon_personal" loc_E9 case "gryphon_team" loc_DF case "gryphon" loc_D5 case "escape" loc_111 default loc_12F
    }
}

init_gryphon_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "gryphon", ::reset_gryphon_score, ::reset_gryphon_score, undefined, ::calculate_gryphon_score, 21, "gryphon" );
}

reset_gryphon_score( var_0 )
{
    var_0._ID38146["damage_on_gryphon"] = 0;
    var_0._ID38146["gryphon_encounter_duration"] = 0;
    return var_0;
}

calculate_gryphon_score( var_0, var_1 )
{
    var_2 = maps\mp\alien\_unk1443::_ID37337( var_1, "damage_on_gryphon" );
    var_3 = maps\mp\alien\_unk1443::calculate_under_max_score( var_2, 150, 3000 );
    var_4 = maps\mp\alien\_unk1443::_ID37337( var_1, "gryphon_encounter_duration" );
    var_5 = maps\mp\alien\_unk1443::calculate_under_max_score( var_4, 300000, 3000 );
    return var_5 + var_3;
}

init_gryphon_team_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "gryphon_team", maps\mp\alien\_unk1443::_ID37485, maps\mp\alien\_unk1443::_ID37904, maps\mp\alien\_unk1443::_ID37900, maps\mp\alien\_unk1443::_ID6447, 2, "gryphon" );
}

init_gryphon_personal_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "gryphon_personal", ::init_gryphon_personal_score, undefined, ::reset_player_gryphon_personal_score_performance, ::calculate_rgyphon_personal_skill_score, 3, "gryphon" );
}

init_gryphon_personal_score( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        var_0._ID37659 = 4000;
    else
        var_0._ID37659 = 1000;

    return var_0;
}

reset_player_gryphon_personal_score_performance( var_0 )
{
    var_0._ID37167["damage_taken"] = 0;
}

calculate_rgyphon_personal_skill_score( var_0, var_1 )
{
    var_2 = maps\mp\alien\_unk1443::_ID37307( var_0, "damage_taken" );
    return maps\mp\alien\_unk1443::calculate_under_max_score( var_2, 500, var_1._ID37659 );
}

get_gryphon_score_component_list()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        return [ "gryphon", "gryphon_personal" ];
        return;
    }

    return [ "gryphon", "gryphon_team", "gryphon_personal" ];
    return;
}

init_cortex_score_component()
{
    maps\mp\alien\_unk1443::_ID37877( "cortex", ::inti_cortex_score, ::reset_cortex_score, undefined, ::calculate_cortex_score, 23, "ark" );
}

inti_cortex_score( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        var_0.max_cortex_score = 6000;
    else
        var_0.max_cortex_score = 4500;

    reset_cortex_score( var_0 );
    return var_0;
}

reset_cortex_score( var_0 )
{
    var_0._ID38146["times_cortex_activated"] = 0;
    return var_0;
}

calculate_cortex_score( var_0, var_1 )
{
    var_2 = maps\mp\alien\_unk1443::_ID37337( var_1, "times_cortex_activated" );
    return int( clamp( var_2 * 500, 0, var_1.max_cortex_score ) );
}

init_cortex_team_component()
{
    maps\mp\alien\_unk1443::_ID37877( "cortex_team", maps\mp\alien\_unk1443::_ID37485, maps\mp\alien\_unk1443::_ID37904, maps\mp\alien\_unk1443::_ID37900, maps\mp\alien\_unk1443::_ID6447, 2, "ark" );
}

init_cortex_personal_component()
{
    maps\mp\alien\_unk1443::_ID37877( "cortex_personal", maps\mp\alien\_unk1443::_ID37476, undefined, maps\mp\alien\_unk1443::_ID37899, maps\mp\alien\_unk1443::calculate_personal_skill_score, 3, "ark" );
}

get_ark_score_component_list()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        return [ "cortex", "cortex_personal" ];
        return;
    }

    return [ "cortex", "cortex_team", "cortex_personal" ];
    return;
}

init_escape_component()
{
    maps\mp\alien\_unk1443::_ID37877( "escape", ::_ID37468, ::reset_escape_score, undefined, ::_ID36929, 9, "escape" );
}

_ID37468( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        var_0.max_escape_score = 6000;
    else
        var_0.max_escape_score = 4500;

    return var_0;
}

reset_escape_score( var_0 )
{
    var_0._ID38146["escape_blocker_duration"] = 0;
    return var_0;
}

_ID36929( var_0, var_1 )
{
    var_2 = maps\mp\alien\_unk1443::_ID37337( var_1, "escape_blocker_duration" );
    return maps\mp\alien\_unk1443::calculate_under_max_score( var_2, var_1.max_escape_score, 120000 );
}

calculate_escape_blocker_score( var_0 )
{
    maps\mp\alien\_unk1443::_ID38222( "escape", "escape_blocker_duration", var_0 );
    maps\mp\alien\_unk1443::_ID36928( level.players, get_escape_blocker_score_component_list() );
}

init_escape_team_component()
{
    maps\mp\alien\_unk1443::_ID37877( "escape_team", maps\mp\alien\_unk1443::_ID37485, maps\mp\alien\_unk1443::_ID37904, maps\mp\alien\_unk1443::_ID37900, maps\mp\alien\_unk1443::_ID6447, 2, "escape" );
}

init_escape_personal_component()
{
    maps\mp\alien\_unk1443::_ID37877( "escape_personal", maps\mp\alien\_unk1443::_ID37476, undefined, maps\mp\alien\_unk1443::_ID37899, maps\mp\alien\_unk1443::calculate_personal_skill_score, 3, "escape" );
}

get_escape_blocker_score_component_list()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        return [ "escape", "escape_personal" ];
        return;
    }

    return [ "escape", "escape_team", "escape_personal" ];
    return;
}
