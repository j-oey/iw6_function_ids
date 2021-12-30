// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID17103 = getdvar( "sv_hostname" );

    if ( level._ID17103 == "" )
        level._ID17103 = "CoDHost";

    setdvar( "sv_hostname", level._ID17103 );
    level.allowvote = getdvarint( "g_allowvote", 1 );
    setdvar( "g_allowvote", level.allowvote );
    setdvar( "ui_allowvote", level.allowvote );
    _ID28732( maps\mp\gametypes\_tweakables::_ID15451( "team", "fftype" ) );
    constraingametype( getdvar( "g_gametype" ) );

    for (;;)
    {
        _ID34607();
        wait 5;
    }
}

_ID34607()
{
    var_0 = getdvar( "sv_hostname" );

    if ( level._ID17103 != var_0 )
        level._ID17103 = var_0;

    var_1 = getdvarint( "g_allowvote", 1 );

    if ( level.allowvote != var_1 )
    {
        level.allowvote = var_1;
        setdvar( "ui_allowvote", level.allowvote );
    }

    var_2 = maps\mp\gametypes\_tweakables::_ID15451( "team", "fftype" );

    if ( level._ID13683 != var_2 )
    {
        _ID28732( var_2 );
        return;
    }
}

constraingametype( var_0 )
{
    var_1 = getentarray();

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_3 = var_1[var_2];

        if ( var_0 == "dm" )
        {
            if ( isdefined( var_3._ID27616 ) && var_3._ID27616 != "1" )
                var_3 delete();

            continue;
        }

        if ( var_0 == "tdm" )
        {
            if ( isdefined( var_3._ID27620 ) && var_3._ID27620 != "1" )
                var_3 delete();

            continue;
        }

        if ( var_0 == "ctf" )
        {
            if ( isdefined( var_3._ID27615 ) && var_3._ID27615 != "1" )
                var_3 delete();

            continue;
        }

        if ( var_0 == "hq" )
        {
            if ( isdefined( var_3._ID27617 ) && var_3._ID27617 != "1" )
                var_3 delete();

            continue;
        }

        if ( var_0 == "sd" )
        {
            if ( isdefined( var_3._ID27619 ) && var_3._ID27619 != "1" )
                var_3 delete();

            continue;
        }

        if ( var_0 == "koth" )
        {
            if ( isdefined( var_3.script_gametype_koth ) && var_3.script_gametype_koth != "1" )
                var_3 delete();
        }
    }
}

_ID28732( var_0 )
{
    level._ID13683 = var_0;
    setdvar( "ui_friendlyfire", var_0 );
    setdvar( "cg_drawFriendlyHUDGrenades", var_0 );
}
