// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    _ID28940();
}

_ID28940()
{
    level._ID2507["squadmate"]["gametype_update"] = ::_ID36674;
    level._ID2507["player"]["think"] = ::_ID36670;
}

_ID36670()
{
    thread maps\mp\bots\_bots_gametype_dom::_ID36838();
}

_ID36674()
{
    var_0 = undefined;

    foreach ( var_2 in self.owner._ID33168 )
    {
        if ( var_2._ID34757._ID17334 == "domFlag" )
            var_0 = var_2;
    }

    if ( isdefined( var_0 ) )
    {
        var_4 = var_0 maps\mp\gametypes\dom::_ID15019();

        if ( var_4 != self.team )
        {
            if ( !maps\mp\bots\_bots_gametype_dom::_ID36856( var_0 ) )
                maps\mp\bots\_bots_gametype_dom::_ID36947( var_0, "critical", 1 );

            return 1;
        }
    }

    return 0;
}
