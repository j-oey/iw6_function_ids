// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

gettweakabledvarvalue( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "rule":
            var_2 = level._ID26912[var_1].dvar;
            break;
        case "game":
            var_2 = level._ID14085[var_1].dvar;
            break;
        case "team":
            var_2 = level._ID32682[var_1].dvar;
            break;
        case "player":
            var_2 = level._ID24553[var_1].dvar;
            break;
        case "class":
            var_2 = level.classtweaks[var_1].dvar;
            break;
        case "weapon":
            var_2 = level._ID36298[var_1].dvar;
            break;
        case "hardpoint":
            var_2 = level.hardpointtweaks[var_1].dvar;
            break;
        case "hud":
            var_2 = level._ID17262[var_1].dvar;
            break;
        default:
            var_2 = undefined;
            break;
    }

    var_3 = getdvarint( var_2 );
    return var_3;
}

gettweakabledvar( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "rule":
            var_2 = level._ID26912[var_1].dvar;
            break;
        case "game":
            var_2 = level._ID14085[var_1].dvar;
            break;
        case "team":
            var_2 = level._ID32682[var_1].dvar;
            break;
        case "player":
            var_2 = level._ID24553[var_1].dvar;
            break;
        case "class":
            var_2 = level.classtweaks[var_1].dvar;
            break;
        case "weapon":
            var_2 = level._ID36298[var_1].dvar;
            break;
        case "hardpoint":
            var_2 = level.hardpointtweaks[var_1].dvar;
            break;
        case "hud":
            var_2 = level._ID17262[var_1].dvar;
            break;
        default:
            var_2 = undefined;
            break;
    }

    return var_2;
}

_ID15451( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "rule":
            var_2 = level._ID26912[var_1]._ID34844;
            break;
        case "game":
            var_2 = level._ID14085[var_1]._ID34844;
            break;
        case "team":
            var_2 = level._ID32682[var_1]._ID34844;
            break;
        case "player":
            var_2 = level._ID24553[var_1]._ID34844;
            break;
        case "class":
            var_2 = level.classtweaks[var_1]._ID34844;
            break;
        case "weapon":
            var_2 = level._ID36298[var_1]._ID34844;
            break;
        case "hardpoint":
            var_2 = level.hardpointtweaks[var_1]._ID34844;
            break;
        case "hud":
            var_2 = level._ID17262[var_1]._ID34844;
            break;
        default:
            var_2 = undefined;
            break;
    }

    return var_2;
}

_ID15450( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "rule":
            var_2 = level._ID26912[var_1]._ID19666;
            break;
        case "game":
            var_2 = level._ID14085[var_1]._ID19666;
            break;
        case "team":
            var_2 = level._ID32682[var_1]._ID19666;
            break;
        case "player":
            var_2 = level._ID24553[var_1]._ID19666;
            break;
        case "class":
            var_2 = level.classtweaks[var_1]._ID19666;
            break;
        case "weapon":
            var_2 = level._ID36298[var_1]._ID19666;
            break;
        case "hardpoint":
            var_2 = level.hardpointtweaks[var_1]._ID19666;
            break;
        case "hud":
            var_2 = level._ID17262[var_1]._ID19666;
            break;
        default:
            var_2 = undefined;
            break;
    }

    return var_2;
}

_ID28909( var_0, var_1, var_2 )
{
    switch ( var_0 )
    {
        case "rule":
            var_3 = level._ID26912[var_1].dvar;
            break;
        case "game":
            var_3 = level._ID14085[var_1].dvar;
            break;
        case "team":
            var_3 = level._ID32682[var_1].dvar;
            break;
        case "player":
            var_3 = level._ID24553[var_1].dvar;
            break;
        case "class":
            var_3 = level.classtweaks[var_1].dvar;
            break;
        case "weapon":
            var_3 = level._ID36298[var_1].dvar;
            break;
        case "hardpoint":
            var_3 = level.hardpointtweaks[var_1].dvar;
            break;
        case "hud":
            var_3 = level._ID17262[var_1].dvar;
            break;
        default:
            var_3 = undefined;
            break;
    }

    setdvar( var_3, var_2 );
}

_ID28908( var_0, var_1, var_2 )
{
    switch ( var_0 )
    {
        case "rule":
            level._ID26912[var_1]._ID19666 = var_2;
            break;
        case "game":
            level._ID14085[var_1]._ID19666 = var_2;
            break;
        case "team":
            level._ID32682[var_1]._ID19666 = var_2;
            break;
        case "player":
            level._ID24553[var_1]._ID19666 = var_2;
            break;
        case "class":
            level.classtweaks[var_1]._ID19666 = var_2;
            break;
        case "weapon":
            level._ID36298[var_1]._ID19666 = var_2;
            break;
        case "hardpoint":
            level.hardpointtweaks[var_1]._ID19666 = var_2;
            break;
        case "hud":
            level._ID17262[var_1]._ID19666 = var_2;
            break;
        default:
            break;
    }
}

_ID25720( var_0, var_1, var_2, var_3 )
{
    if ( isstring( var_3 ) )
        var_3 = getdvar( var_2, var_3 );
    else
        var_3 = getdvarint( var_2, var_3 );

    switch ( var_0 )
    {
        case "rule":
            if ( !isdefined( level._ID26912[var_1] ) )
                level._ID26912[var_1] = spawnstruct();

            level._ID26912[var_1]._ID34844 = var_3;
            level._ID26912[var_1]._ID19666 = var_3;
            level._ID26912[var_1].dvar = var_2;
            break;
        case "game":
            if ( !isdefined( level._ID14085[var_1] ) )
                level._ID14085[var_1] = spawnstruct();

            level._ID14085[var_1]._ID34844 = var_3;
            level._ID14085[var_1]._ID19666 = var_3;
            level._ID14085[var_1].dvar = var_2;
            break;
        case "team":
            if ( !isdefined( level._ID32682[var_1] ) )
                level._ID32682[var_1] = spawnstruct();

            level._ID32682[var_1]._ID34844 = var_3;
            level._ID32682[var_1]._ID19666 = var_3;
            level._ID32682[var_1].dvar = var_2;
            break;
        case "player":
            if ( !isdefined( level._ID24553[var_1] ) )
                level._ID24553[var_1] = spawnstruct();

            level._ID24553[var_1]._ID34844 = var_3;
            level._ID24553[var_1]._ID19666 = var_3;
            level._ID24553[var_1].dvar = var_2;
            break;
        case "class":
            if ( !isdefined( level.classtweaks[var_1] ) )
                level.classtweaks[var_1] = spawnstruct();

            level.classtweaks[var_1]._ID34844 = var_3;
            level.classtweaks[var_1]._ID19666 = var_3;
            level.classtweaks[var_1].dvar = var_2;
            break;
        case "weapon":
            if ( !isdefined( level._ID36298[var_1] ) )
                level._ID36298[var_1] = spawnstruct();

            level._ID36298[var_1]._ID34844 = var_3;
            level._ID36298[var_1]._ID19666 = var_3;
            level._ID36298[var_1].dvar = var_2;
            break;
        case "hardpoint":
            if ( !isdefined( level.hardpointtweaks[var_1] ) )
                level.hardpointtweaks[var_1] = spawnstruct();

            level.hardpointtweaks[var_1]._ID34844 = var_3;
            level.hardpointtweaks[var_1]._ID19666 = var_3;
            level.hardpointtweaks[var_1].dvar = var_2;
            break;
        case "hud":
            if ( !isdefined( level._ID17262[var_1] ) )
                level._ID17262[var_1] = spawnstruct();

            level._ID17262[var_1]._ID34844 = var_3;
            level._ID17262[var_1]._ID19666 = var_3;
            level._ID17262[var_1].dvar = var_2;
            break;
    }
}

_ID17631()
{
    level.clienttweakables = [];
    level._ID34123 = 1;
    level._ID26912 = [];
    level._ID14085 = [];
    level._ID32682 = [];
    level._ID24553 = [];
    level.classtweaks = [];
    level._ID36298 = [];
    level.hardpointtweaks = [];
    level._ID17262 = [];

    if ( level.console )
    {
        if ( level._ID36451 || level._ID25140 )
            _ID25720( "game", "graceperiod", "scr_game_graceperiod", 20 );
        else
            _ID25720( "game", "graceperiod", "scr_game_graceperiod", 15 );

        _ID25720( "game", "graceperiod_comp", "scr_game_graceperiod_comp", 60 );
    }
    else
    {
        _ID25720( "game", "playerwaittime", "scr_game_playerwaittime", 15 );
        _ID25720( "game", "playerwaittime_comp", "scr_game_playerwaittime_comp", 60 );
    }

    _ID25720( "game", "matchstarttime", "scr_game_matchstarttime", 15 );
    _ID25720( "game", "onlyheadshots", "scr_game_onlyheadshots", 0 );
    _ID25720( "game", "allowkillcam", "scr_game_allowkillcam", 1 );
    _ID25720( "game", "spectatetype", "scr_game_spectatetype", 2 );
    _ID25720( "game", "deathpointloss", "scr_game_deathpointloss", 0 );
    _ID25720( "game", "suicidepointloss", "scr_game_suicidepointloss", 0 );
    _ID25720( "team", "teamkillpointloss", "scr_team_teamkillpointloss", 0 );
    _ID25720( "team", "fftype", "scr_team_fftype", 0 );
    _ID25720( "team", "teamkillspawndelay", "scr_team_teamkillspawndelay", 0 );
    _ID25720( "player", "maxhealth", "scr_player_maxhealth", 100 );
    _ID25720( "player", "healthregentime", "scr_player_healthregentime", 5 );
    _ID25720( "player", "forcerespawn", "scr_player_forcerespawn", 1 );
    _ID25720( "weapon", "allowfrag", "scr_weapon_allowfrags", 1 );
    _ID25720( "weapon", "allowsmoke", "scr_weapon_allowsmoke", 1 );
    _ID25720( "weapon", "allowflash", "scr_weapon_allowflash", 1 );
    _ID25720( "weapon", "allowc4", "scr_weapon_allowc4", 1 );
    _ID25720( "weapon", "allowclaymores", "scr_weapon_allowclaymores", 1 );
    _ID25720( "weapon", "allowrpgs", "scr_weapon_allowrpgs", 1 );
    _ID25720( "weapon", "allowmines", "scr_weapon_allowmines", 1 );
    _ID25720( "hardpoint", "allowartillery", "scr_hardpoint_allowartillery", 1 );
    _ID25720( "hardpoint", "allowuav", "scr_hardpoint_allowuav", 1 );
    _ID25720( "hardpoint", "allowsupply", "scr_hardpoint_allowsupply", 1 );
    _ID25720( "hardpoint", "allowhelicopter", "scr_hardpoint_allowhelicopter", 1 );
    _ID25720( "hud", "showobjicons", "ui_hud_showobjicons", 1 );
    setdvar( "ui_hud_showobjicons", 1 );
}
