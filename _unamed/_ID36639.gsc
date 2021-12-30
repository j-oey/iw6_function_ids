// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID37450( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        switch ( var_2 )
        {
            case "spider":
                maps\mp\alien\_unk1443::_ID37878( "spider", 12 );
                continue;
            case "relics":
                maps\mp\alien\_unk1443::_ID37878( "relics", 5 );
                continue;
        }

        endswitch( 3 )  case "spider" loc_21 case "relics" loc_33 default loc_45
    }
}

_ID37449( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        switch ( var_2 )
        {
            case "first_spider":
                _ID37473();
                continue;
            case "final_spider":
                _ID37471();
                continue;
            case "spider_challenge":
                _ID37481();
                continue;
            case "spider_team":
                _ID37484();
                continue;
            case "spider_personal":
                _ID37483();
                continue;
        }

        endswitch( 6 )  case "final_spider" loc_94 case "first_spider" loc_8A case "spider_personal" loc_B2 case "spider_team" loc_A8 case "spider_challenge" loc_9E default loc_BC
    }
}

_ID37473()
{
    maps\mp\alien\_unk1443::_ID37877( "first_spider", ::_ID37472, ::_ID37905, undefined, ::_ID36933, 12, "spider" );
}

_ID37472( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        var_0._ID37662 = 4500;
    else
        var_0._ID37662 = 3500;

    var_0._ID36764 = 600000;
    return var_0;
}

_ID37905( var_0 )
{
    var_0._ID38146["spider_battle_time"] = 0;
    return var_0;
}

_ID36933( var_0, var_1 )
{
    var_2 = maps\mp\alien\_unk1443::_ID37337( var_1, "spider_battle_time" );
    var_3 = max( 0, var_1._ID36764 - var_2 );
    var_4 = var_1._ID37662 * var_3 / var_1._ID36764;
    return int( var_4 );
}

_ID36927()
{
    var_0 = _ID37278();
    maps\mp\alien\_unk1443::_ID36926( level.players, var_0 );

    foreach ( var_2 in level.players )
        var_2 thread _ID36640::_ID35519();
}

_ID37278()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        return [ "first_spider", "spider_personal", "spider_challenge" ];
    else
        return [ "first_spider", "spider_team", "spider_personal", "spider_challenge" ];
}

_ID37471()
{
    maps\mp\alien\_unk1443::_ID37877( "final_spider", ::_ID37470, ::_ID37905, undefined, ::_ID36933, 12, "spider" );
}

_ID37470( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        var_0._ID37662 = 4500;
    else
        var_0._ID37662 = 3500;

    var_0._ID36764 = 900000;
    return var_0;
}

_ID36930()
{
    var_0 = _ID37277();
    maps\mp\alien\_unk1443::_ID36928( level.players, var_0 );
}

_ID37277()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        return [ "first_spider", "spider_personal" ];
    else
        return [ "first_spider", "spider_team", "spider_personal" ];
}

_ID37481()
{
    maps\mp\alien\_unk1443::_ID37877( "spider_challenge", ::_ID37480, undefined, maps\mp\alien\_unk1443::_ID37895, maps\mp\alien\_unk1443::calculate_challenge_score, 4, "spider" );
}

_ID37480( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        var_0._ID37655 = 1500;
    else
        var_0._ID37655 = 1000;

    return var_0;
}

_ID37484()
{
    maps\mp\alien\_unk1443::_ID37877( "spider_team", maps\mp\alien\_unk1443::_ID37485, maps\mp\alien\_unk1443::_ID37904, maps\mp\alien\_unk1443::_ID37900, maps\mp\alien\_unk1443::_ID6447, 2, "spider" );
}

_ID37483()
{
    maps\mp\alien\_unk1443::_ID37877( "spider_personal", ::_ID37482, undefined, maps\mp\alien\_unk1443::_ID37899, maps\mp\alien\_unk1443::calculate_personal_skill_score, 3, "spider" );
}

_ID37482( var_0 )
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
