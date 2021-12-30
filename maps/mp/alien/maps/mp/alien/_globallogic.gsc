// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level.splitscreen = issplitscreen();
    maps\mp\_utility::set_console_status();
    level._ID22861 = getdvarint( "onlinegame" );
    level._ID25418 = level._ID22861 && !getdvarint( "xblive_privatematch" ) || getdvarint( "force_ranking" );
    level.script = tolower( getdvar( "mapname" ) );
    level._ID14086 = tolower( getdvar( "g_gametype" ) );
    level._ID32668 = [ "axis", "allies" ];
    level._ID23070["allies"] = "axis";
    level._ID23070["axis"] = "allies";
    level.multiteambased = 0;
    level._ID32653 = 0;
    level._ID22489 = 0;
    level.endgameontimelimit = 1;
    level._ID29973 = 0;
    level._ID33086 = getdvarint( "scr_tispawndelay" );

    if ( !isdefined( level._ID34123 ) )
        maps\mp\gametypes\_tweakables::_ID17631();

    level._ID15987 = "halftime";
    level.halftimesubcaption = &"MP_SWITCHING_SIDES";
    level.laststatustime = 0;
    level._ID35918 = "none";
    level.lastslowprocessframe = 0;
    level._ID23663["allies"] = [];
    level._ID23663["axis"] = [];
    level._ID23663["all"] = [];
    level._ID24793 = 5.0;
    level._ID24535 = [];
    _ID25704();
    var_0 = " LB_" + getdvar( "ui_mapname" );

    if ( getdvarint( "scr_chaos_mode" ) == 1 )
        var_0 += "_CHAOS";

    if ( getdvarint( "sv_maxclients" ) == 1 )
        var_0 += "_SOLO";
    else
        var_0 += "_COOP";

    var_1 = " LB_" + getdvar( "ui_mapname" ) + "_ESCAPES";

    if ( getdvarint( "scr_aliens_hardcore" ) )
        var_0 += "_HC";

    if ( getdvarint( "scr_chaos_mode" ) == 1 )
    {
        var_2 = "LB_GB_ALIEN_CHAOS";

        if ( getdvarint( "sv_maxclients" ) == 1 )
            var_2 += "_SOLO";
        else
            var_2 += "_COOP";

        precacheleaderboards( var_2 + var_0 );
    }
    else
        precacheleaderboards( "LB_GB_ALIEN_HIVES LB_GB_ALIEN_KILLS LB_GB_ALIEN_REVIVES LB_GB_ALIEN_DOWNED LB_GB_ALIEN_XP LB_GB_ALIEN_SCORE LB_GB_ALIEN_CHALLENGES LB_GB_ALIEN_CASHFLOW" + var_0 + var_1 );

    level._ID32656["allies"] = 0;
    level._ID32656["axis"] = 0;
    level._ID32656["spectator"] = 0;
    level.alivecount["allies"] = 0;
    level.alivecount["axis"] = 0;
    level.alivecount["spectator"] = 0;
    level._ID20088["allies"] = 0;
    level._ID20088["axis"] = 0;
    level._ID22814 = [];
    level.hasspawned["allies"] = 0;
    level.hasspawned["axis"] = 0;
    var_3 = 9;
    _ID17779( var_3 );
}

_ID17779( var_0 )
{
    for ( var_1 = 0; var_1 < var_0; var_1++ )
    {
        var_2 = "team_" + var_1;
        level._ID23663[var_2] = [];
        level._ID32656[var_2] = 0;
        level.alivecount[var_2] = 0;
        level._ID20088[var_2] = 0;
        level.hasspawned[var_2] = 0;
    }
}

_ID25704()
{
    setomnvar( "ui_bomb_timer", 0 );

    if ( getdvar( "r_reflectionProbeGenerate" ) != "1" )
        setomnvar( "ui_nuke_end_milliseconds", 0 );

    setdvar( "ui_danger_team", "" );
    setdvar( "ui_inhostmigration", 0 );
    setdvar( "ui_inprematch", 0 );
    setdvar( "ui_override_halftime", 0 );
    setdvar( "camera_thirdPerson", getdvarint( "scr_thirdPerson" ) );
    setdvar( "scr_alien_intel_pillage", 0 );
}

_ID29168()
{
    level._ID22924 = ::_ID22924;
    level.getspawnpoint = ::blank;
    level._ID22902 = ::blank;
    level.onrespawndelay = ::blank;
    level._ID22913 = maps\mp\gametypes\_gamelogic::_ID9379;
    level.onhalftime = maps\mp\gametypes\_gamelogic::_ID9377;
    level._ID22796 = maps\mp\gametypes\_gamelogic::default_ondeadevent;
    level._ID22870 = maps\mp\gametypes\_gamelogic::default_ononeleftevent;
    level._ID22892 = ::blank;
    level._ID22905 = ::blank;
    level._ID22886 = ::blank;
    level._ID19259 = ::blank;
    level._ID20669 = ::blank;
    level._ID18054 = ::blank;
}

blank( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{

}

_ID32856()
{
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        wait 10.0;
        var_0 = spawnstruct();
        var_0._ID33092 = &"MP_CHALLENGE_COMPLETED";
        var_0.notifytext = "wheee";
        var_0._ID30465 = "mp_challenge_complete";
        thread maps\mp\gametypes\_hud_message::_ID22313( var_0 );
    }
}

_ID32857()
{
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        wait 3.0;
        var_0 = randomint( 6 );

        for ( var_1 = 0; var_1 < var_0; var_1++ )
        {
            iprintlnbold( var_0 );
            self shellshock( "frag_grenade_mp", 0.2 );
            wait 0.1;
        }
    }
}

_ID22924( var_0 )
{
    thread maps\mp\gametypes\_rank::giverankxp( var_0 );
}

_ID9250( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < 50; var_2++ )
        wait 0.05;
}
