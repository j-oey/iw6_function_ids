// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID6469()
{
    if ( maps\mp\_utility::_ID18363() )
        setnojiptime( 1 );

    level._ID17097 = 0;

    if ( level.gameended )
        return;

    foreach ( var_1 in level.characters )
        var_1._ID17096 = 0;

    level.hostmigrationtimer = 1;
    setdvar( "ui_inhostmigration", 1 );
    level notify( "host_migration_begin" );
    maps\mp\gametypes\_gamelogic::updatetimerpausedness();

    foreach ( var_1 in level.characters )
    {
        var_1 thread _ID17099();

        if ( isplayer( var_1 ) )
            var_1 setclientomnvar( "ui_session_state", var_1.sessionstate );
    }

    setdvar( "ui_game_state", game["state"] );
    level endon( "host_migration_begin" );
    _ID17101();
    level.hostmigrationtimer = undefined;
    setdvar( "ui_inhostmigration", 0 );
    level notify( "host_migration_end" );
    maps\mp\gametypes\_gamelogic::updatetimerpausedness();
    level thread maps\mp\gametypes\_gamelogic::_ID34542();

    if ( getdvar( "squad_use_hosts_squad" ) == "1" )
    {
        level thread maps\mp\gametypes\_menus::update_wargame_after_migration();
        return;
    }
}

_ID17101()
{
    level endon( "game_ended" );
    level._ID17628 = 25;
    thread maps\mp\gametypes\_gamelogic::_ID20681( "waiting_for_players", 20.0 );
    _ID17102();
    level._ID17628 = 10;
    thread maps\mp\gametypes\_gamelogic::_ID20681( "match_resuming_in", 5.0 );
    wait 5;
    level._ID17628 = 0;
}

_ID17102()
{
    level endon( "hostmigration_enoughplayers" );
    wait 15;
}

hostmigrationname( var_0 )
{
    if ( !isdefined( var_0 ) )
        return "<removed_ent>";

    var_1 = -1;
    var_2 = "?";

    if ( isdefined( var_0.entity_number ) )
        var_1 = var_0.entity_number;

    if ( isplayer( var_0 ) && isdefined( var_0.name ) )
        var_2 = var_0.name;

    if ( isplayer( var_0 ) )
        return "player <" + var_2 + ">";

    if ( isagent( var_0 ) && maps\mp\_utility::_ID18638( var_0 ) )
        return "participant agent <" + var_1 + ">";

    if ( isagent( var_0 ) )
        return "non-participant agent <" + var_1 + ">";

    return "unknown entity <" + var_1 + ">";
}

hostmigrationtimerthink_internal()
{
    level endon( "host_migration_begin" );
    level endon( "host_migration_end" );

    while ( !maps\mp\_utility::_ID18757( self ) )
        self waittill( "spawned" );

    self._ID17096 = 1;
    maps\mp\_utility::_ID13582( 1 );
    level waittill( "host_migration_end" );
}

_ID17099()
{
    self endon( "disconnect" );

    if ( isplayer( self ) )
        self setclientdvar( "cg_scoreboardPingGraph", "0" );

    hostmigrationtimerthink_internal();

    if ( self._ID17096 )
    {
        if ( maps\mp\_utility::_ID14065( "prematch_done" ) )
            maps\mp\_utility::_ID13582( 0 );

        self._ID17096 = undefined;
    }

    if ( isplayer( self ) )
    {
        self setclientdvar( "cg_scoreboardPingGraph", "1" );
        return;
    }
}

_ID35770()
{
    if ( !isdefined( level.hostmigrationtimer ) )
        return 0;

    var_0 = gettime();
    level waittill( "host_migration_end" );
    return gettime() - var_0;
}

_ID35771( var_0 )
{
    if ( isdefined( level.hostmigrationtimer ) )
        return;

    level endon( "host_migration_begin" );
    wait(var_0);
}

_ID35597( var_0 )
{
    if ( var_0 == 0 )
        return;

    var_1 = gettime();
    var_2 = gettime() + var_0 * 1000;

    while ( gettime() < var_2 )
    {
        _ID35771( ( var_2 - gettime() ) / 1000 );

        if ( isdefined( level.hostmigrationtimer ) )
        {
            var_3 = _ID35770();
            var_2 += var_3;
        }
    }

    _ID35770();
    return gettime() - var_1;
}

_ID35709( var_0, var_1 )
{
    self endon( var_0 );

    if ( var_1 == 0 )
        return;

    var_2 = gettime();
    var_3 = gettime() + var_1 * 1000;

    while ( gettime() < var_3 )
    {
        _ID35771( ( var_3 - gettime() ) / 1000 );

        if ( isdefined( level.hostmigrationtimer ) )
        {
            var_4 = _ID35770();
            var_3 += var_4;
        }
    }

    _ID35770();
    return gettime() - var_2;
}

_ID35596( var_0 )
{
    if ( var_0 == 0 )
        return;

    var_1 = gettime();
    var_2 = gettime() + var_0 * 1000;

    while ( gettime() < var_2 )
    {
        _ID35771( ( var_2 - gettime() ) / 1000 );

        while ( isdefined( level.hostmigrationtimer ) )
        {
            var_2 += 1000;
            setgameendtime( int( var_2 ) );
            wait 1;
        }
    }

    while ( isdefined( level.hostmigrationtimer ) )
    {
        var_2 += 1000;
        setgameendtime( int( var_2 ) );
        wait 1;
    }

    return gettime() - var_1;
}
