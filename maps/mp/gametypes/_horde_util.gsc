// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID18740( var_0 )
{
    return isdefined( var_0.laststand ) && var_0.laststand;
}

isonhumanteam( var_0 )
{
    return var_0.team == level._ID24549;
}

_ID15195()
{
    var_0 = 0;

    if ( !isdefined( level.players ) )
        return 0;

    foreach ( var_2 in level.players )
    {
        if ( isonhumanteam( var_2 ) )
            var_0++;
    }

    return var_0;
}

_ID18796( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = level.currentroundnumber;

    if ( !level._ID11502 )
        return 0;

    if ( var_0 % 5 == 1 )
        return 1;

    return 0;
}

_ID18606()
{
    return level.chancetospawndog > 0;
}

_ID29991( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( isonhumanteam( var_2 ) && maps\mp\_utility::_ID18757( var_2 ) )
            var_2 thread maps\mp\gametypes\_hud_message::_ID31052( var_0 );
    }
}

_ID16377( var_0 )
{
    var_1 = 0;

    if ( isagent( var_0 ) )
        return var_1;

    foreach ( var_3 in var_0.pers["killstreaks"] )
    {
        if ( isdefined( var_3 ) && isdefined( var_3._ID31889 ) && var_3.available && var_3._ID31889 == "agent" )
        {
            var_1 = 1;
            break;
        }
    }

    return var_1;
}

getplayerweaponhorde( var_0 )
{
    var_1 = var_0 getcurrentprimaryweapon();

    if ( isdefined( var_0.changingweapon ) )
        var_1 = var_0.changingweapon;

    if ( !maps\mp\gametypes\_weapons::isprimaryweapon( var_1 ) )
        var_1 = var_0 common_scripts\utility::_ID15114();

    if ( !var_0 hasweapon( var_1 ) )
        var_1 = var_0 maps\mp\killstreaks\_killstreaks::_ID15018();

    return var_1;
}

_ID24647( var_0 )
{
    level endon( "game_ended" );

    foreach ( var_2 in level.players )
    {
        if ( !maps\mp\_utility::_ID18757( var_2 ) )
            continue;

        if ( !isonhumanteam( var_2 ) )
            continue;

        var_2 playsoundtoplayer( var_0, var_2 );
    }
}

_ID37864( var_0 )
{
    var_1 = var_0 getweaponslistall();

    foreach ( var_3 in var_1 )
    {
        var_0 givemaxammo( var_3 );

        if ( var_3 == level.intelminigun )
        {
            var_4 = weaponclipsize( level.intelminigun );
            var_0 setweaponammoclip( level.intelminigun, var_4 );
        }
    }
}

_ID36755( var_0 )
{
    var_0 maps\mp\gametypes\_persistence::_ID31528( "round", "squardKills", var_0._ID19283 + 1 );
    var_0._ID19283 = int( min( var_0._ID19283 + 1, 999 ) );
    var_0.kills = var_0._ID19283;
    var_0 maps\mp\_utility::_ID28819( "hordeKills", var_0._ID19283 );
}

_ID36756( var_0 )
{
    var_0 maps\mp\gametypes\_persistence::_ID31528( "round", "squardRevives", var_0._ID22417 + 1 );
    var_0._ID22417 = int( min( var_0._ID22417 + 1, 999 ) );
    var_0.assists = var_0._ID22417;
    var_0 maps\mp\_utility::_ID28819( "hordeRevives", var_0._ID22417 );
}

_ID36754( var_0 )
{
    var_0 maps\mp\gametypes\_persistence::_ID31528( "round", "squardCrates", var_0._ID22398 + 1 );
    var_0._ID22398 = int( min( var_0._ID22398 + 1, 999 ) );
    var_0 maps\mp\_utility::setextrascore0( var_0._ID22398 );
    var_0 maps\mp\_utility::_ID28819( "hordeCrates", var_0._ID22398 );
}

_ID36757( var_0, var_1 )
{
    var_0 maps\mp\gametypes\_persistence::_ID31528( "round", "sguardWave", var_1 );
    var_0 maps\mp\_utility::_ID28819( "hordeRound", var_1 );
}

_ID36758( var_0, var_1 )
{
    var_0 maps\mp\gametypes\_persistence::_ID31528( "round", "sguardWeaponLevel", var_1 );
    var_0 maps\mp\_utility::_ID28819( "hordeWeapon", var_1 );
}
