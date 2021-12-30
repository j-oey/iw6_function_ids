// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID22379 = "aftermath_post";
    level._ID1644["nuke_player"] = loadfx( "fx/explosions/player_death_nuke" );
    level._ID1644["nuke_flash"] = loadfx( "fx/explosions/player_death_nuke_flash" );
    level._ID1644["nuke_aftermath"] = loadfx( "fx/dust/nuke_aftermath_mp" );
    level._ID19256["nuke"] = ::_ID33858;
    setdvarifuninitialized( "scr_nukeTimer", 10 );
    setdvarifuninitialized( "scr_nukeCancelMode", 0 );
    level._ID22376 = getdvarint( "scr_nukeTimer" );
    level.cancelmode = getdvarint( "scr_nukeCancelMode" );

    if ( level.multiteambased )
    {
        for ( var_0 = 0; var_0 < level._ID32668.size; var_0++ )
            level._ID32669[level._ID32668[var_0]] = 0;
    }
    else
    {
        level._ID32669["allies"] = 0;
        level._ID32669["axis"] = 0;
    }

    level._ID22368 = 60.0;
    level._ID22369 = int( level._ID22368 );
    level._ID22371 = spawnstruct();
    level._ID22371._ID36473 = 2;
    level.nukedetonated = undefined;
    level thread _ID22877();
}

_ID33858( var_0, var_1, var_2 )
{
    if ( isdefined( level._ID22370 ) )
    {
        self iprintlnbold( &"KILLSTREAKS_NUKE_ALREADY_INBOUND" );
        return 0;
    }

    if ( maps\mp\_utility::_ID18837() && ( !isdefined( level._ID15845 ) || !level._ID15845 ) )
        return 0;

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    thread _ID10678( var_2 );
    self notify( "used_nuke" );
    maps\mp\_matchdata::_ID20253( "nuke", self.origin );
    return 1;
}

delaythread_nuke( var_0, var_1 )
{
    level endon( "nuke_cancelled" );
    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    thread [[ var_1 ]]();
}

_ID10678( var_0 )
{
    level endon( "nuke_cancelled" );
    level._ID22371.player = self;
    level._ID22371.team = self.pers["team"];
    level._ID22370 = 1;
    level._ID24956 = int( getomnvar( "ui_bomb_timer" ) );
    setomnvar( "ui_bomb_timer", 4 );

    if ( level._ID32653 )
        thread maps\mp\_utility::_ID32672( "used_nuke", self, self.team );
    else if ( !level.hardcoremode )
        self iprintlnbold( &"KILLSTREAKS_FRIENDLY_TACTICAL_NUKE" );

    if ( !isdefined( level.donuke_fx ) || ![[ level.donuke_fx ]]() )
    {
        if ( !isdefined( level.nuke_soundobject ) )
        {
            level.nuke_soundobject = spawn( "script_origin", ( 0, 0, 1 ) );
            level.nuke_soundobject hide();
        }

        level thread delaythread_nuke( level._ID22376 - 3.3, ::_ID22375 );
        level thread delaythread_nuke( level._ID22376, ::_ID22374 );
        level thread delaythread_nuke( level._ID22376, ::nukeslowmo );
        level thread delaythread_nuke( level._ID22376, ::_ID22365 );
        level thread delaythread_nuke( level._ID22376 + 0.25, ::_ID22377 );
        level thread delaythread_nuke( level._ID22376 + 1.5, ::_ID22360 );
        level thread delaythread_nuke( level._ID22376 + 1.5, ::_ID22363 );
        level thread _ID22353();

        if ( level.cancelmode && var_0 )
            level thread cancelnukeondeath( self );
    }

    level thread _ID34490();

    if ( !isdefined( level._ID22340 ) )
    {
        level._ID22340 = spawn( "script_origin", ( 0, 0, 0 ) );
        level._ID22340 hide();
    }

    for ( var_1 = level._ID22376; var_1 > 0; var_1-- )
    {
        level._ID22340 playsound( "ui_mp_kem_timer" );
        wait 1.0;
    }
}

donukesimple()
{
    level._ID22371.player = self;
    level._ID22371.team = self.pers["team"];
    level._ID22370 = 1;
    level thread delaythread_nuke( level._ID22376 - 3.3, ::_ID22375 );
    level thread delaythread_nuke( level._ID22376, ::_ID22374 );
    level thread delaythread_nuke( level._ID22376, ::nukeslowmo );
    level thread delaythread_nuke( level._ID22376, ::_ID22365 );
    level thread delaythread_nuke( level._ID22376 + 0.25, ::_ID22377 );
    level thread delaythread_nuke( level._ID22376 + 1.5, ::nukedeathsimple );
    level thread delaythread_nuke( level._ID22376 + 1.5, ::_ID22363 );

    if ( !isdefined( level.nuke_soundobject ) )
    {
        level.nuke_soundobject = spawn( "script_origin", ( 0, 0, 1 ) );
        level.nuke_soundobject hide();
    }
}

nukedeathsimple()
{
    level notify( "nuke_death" );
}

cancelnukeondeath( var_0 )
{
    var_0 common_scripts\utility::_ID35626( "death", "disconnect" );

    if ( isdefined( var_0 ) && level.cancelmode == 2 )
        var_0 thread maps\mp\killstreaks\_emp::emp_use( 0, 0 );

    _ID22357();
    level._ID22370 = undefined;
    level notify( "nuke_cancelled" );
}

_ID22375()
{
    level endon( "nuke_cancelled" );

    if ( isdefined( level.nuke_soundobject ) )
        level.nuke_soundobject playsound( "nuke_incoming" );
}

_ID22374()
{
    level endon( "nuke_cancelled" );

    if ( isdefined( level.nuke_soundobject ) )
    {
        level.nuke_soundobject playsound( "nuke_explosion" );
        level.nuke_soundobject playsound( "nuke_wave" );
    }
}

_ID22357()
{
    var_0 = 0;

    if ( isdefined( level._ID24956 ) )
        var_0 = level._ID24956;

    setomnvar( "ui_bomb_timer", var_0 );
}

_ID22365()
{
    level endon( "nuke_cancelled" );
    _ID22357();
    level.nukedetonated = 1;

    foreach ( var_1 in level.players )
        level thread _ID22364( var_1 );
}

_ID22364( var_0 )
{
    level endon( "nuke_cancelled" );
    var_0 endon( "disconnect" );
    common_scripts\utility::_ID35582();
    var_1 = undefined;
    var_2 = undefined;

    if ( !isdefined( level._ID22372 ) )
    {
        var_3 = ( 0, var_0.angles[1], 0 );
        var_2 = anglestoforward( var_3 );
        var_4 = 5000;
        var_1 = var_0.origin + var_2 * var_4;
    }
    else
        var_1 = level._ID22372;

    var_5 = undefined;
    var_6 = ( 0, 0, 1 );

    if ( !isdefined( level._ID22354 ) )
        var_5 = anglestoright( ( 0, var_0.angles[1] + 180, 0 ) );
    else
    {
        var_5 = anglestoforward( level._ID22354 );
        var_6 = anglestoup( level._ID22354 );
    }

    var_7 = spawnfxforclient( level._ID1644["nuke_flash"], var_1, var_0, var_6, var_5 );
    triggerfx( var_7 );
    var_0 thread cleanupnukeeffect( var_7, 30 );
}

cleanupnukeeffect( var_0, var_1 )
{
    maps\mp\_utility::waitfortimeornotify( var_1, "disconnect" );
    var_0 delete();
}

_ID22353()
{
    level endon( "nuke_cancelled" );
    level waittill( "spawning_intermission" );
    var_0 = getentarray( "mp_global_intermission", "classname" );
    var_0 = var_0[0];
    var_1 = anglestoup( var_0.angles );
    var_2 = anglestoright( var_0.angles );
    playfx( level._ID1644["nuke_aftermath"], var_0.origin, var_1, var_2 );
}

nukeslowmo()
{
    level endon( "nuke_cancelled" );
    setslowmotion( 1.0, 0.25, 0.5 );
    level waittill( "nuke_death" );
    setslowmotion( 0.25, 1, 2.0 );
}

_ID22377()
{
    level endon( "nuke_cancelled" );
    level.nukevisioninprogress = 1;
    visionsetpostapply( "mpnuke", 3 );
    maps\mp\gametypes\_hostmigration::_ID35597( 2 );
    visionsetpostapply( "nuke_global_flash", 0.1 );
    setexpfog( 0, 956, 0.72, 0.61, 0.39, 0.968, 0.85, 1, 0.298, 0.273, 0.266, 0.25, ( 0, 0, -1 ), 84, 118, 2.75, 0.984, 124, 100 );
    setdvar( "r_materialBloomHQScriptMasterEnable", 0 );
    maps\mp\gametypes\_hostmigration::_ID35597( 0.5 );
    level notify( "nuke_aftermath_post_started" );
    visionsetpostapply( "aftermath_post", 0.5 );
    level waittill( "nuke_death" );
    level thread _ID38231();
    level _ID37971( 5 );
}

_ID22360()
{
    level endon( "nuke_cancelled" );
    level endon( "game_ended" );
    level notify( "nuke_death" );
    maps\mp\gametypes\_hostmigration::_ID35770();

    foreach ( var_1 in level.characters )
    {
        if ( nukecankill( var_1 ) )
        {
            if ( isplayer( var_1 ) )
            {
                var_1._ID22359 = 1;

                if ( maps\mp\_utility::_ID18757( var_1 ) )
                    var_1 thread maps\mp\gametypes\_damage::_ID12959( level._ID22371.player, level._ID22371.player, 999999, 0, "MOD_EXPLOSIVE", "nuke_mp", var_1.origin, ( 0, 0, 1 ), "none", 0, 0 );

                continue;
            }

            var_1 maps\mp\agents\_agents::agent_damage_finished( level._ID22371.player, level._ID22371.player, 999999, 0, "MOD_EXPLOSIVE", "nuke_mp", var_1.origin, ( 0, 0, 1 ), "none", 0 );
        }
    }

    level thread nuke_empjam();
    level._ID22370 = undefined;
}

nukecankill( var_0 )
{
    if ( !isdefined( level._ID22371 ) )
        return 0;

    if ( level._ID32653 )
    {
        if ( isdefined( level._ID22371.team ) && var_0.team == level._ID22371.team )
            return 0;
    }
    else
    {
        var_1 = isdefined( level._ID22371.player ) && var_0 == level._ID22371.player;
        var_2 = isdefined( level._ID22371.player ) && isdefined( var_0.owner ) && var_0.owner == level._ID22371.player;

        if ( var_1 || var_2 )
            return 0;
    }

    return 1;
}

_ID22363()
{
    level endon( "nuke_cancelled" );
    level waittill( "nuke_death" );
}

nuke_empjam()
{
    level endon( "game_ended" );

    if ( level._ID32653 )
        level _ID22367( maps\mp\_utility::getotherteam( level._ID22371.team ) );
    else
    {
        level._ID32669[level._ID22371.team] = 1;
        level._ID32669[maps\mp\_utility::getotherteam( level._ID22371.team )] = 1;
        _ID22366( level._ID22371.player );
    }
}

_ID22367( var_0 )
{
    level endon( "game_ended" );
    level notify( "nuke_EMPJam" );
    level endon( "nuke_EMPJam" );
    level._ID32669[var_0] = 1;

    foreach ( var_2 in level.players )
    {
        if ( var_2 maps\mp\killstreaks\_unk1534::_ID29881() )
            var_2 maps\mp\killstreaks\_unk1534::applyperplayerempeffects();
    }

    level notify( "nuke_emp_update" );
    level maps\mp\killstreaks\_jammer::_ID9812( level._ID22371.player, var_0 );
    level maps\mp\killstreaks\_air_superiority::_ID9792( level._ID22371.player, var_0 );
    level thread keepnukeemptimeremaining();
    maps\mp\gametypes\_hostmigration::_ID35597( level._ID22368 );
    level._ID32669[var_0] = 0;

    foreach ( var_2 in level.players )
    {
        if ( var_2.team == var_0 && !var_2 maps\mp\killstreaks\_unk1534::_ID29881() )
        {
            var_2 maps\mp\killstreaks\_unk1534::_ID26023();
            var_2._ID22359 = undefined;
        }
    }

    level notify( "nuke_emp_update" );
    level notify( "nuke_emp_ended" );
}

_ID22366( var_0 )
{
    level notify( "nuke_EMPJam" );
    level endon( "nuke_EMPJam" );

    if ( !isdefined( var_0 ) )
        return;

    foreach ( var_2 in level.players )
    {
        if ( var_2 maps\mp\killstreaks\_unk1534::_ID29881() )
            var_2 maps\mp\killstreaks\_unk1534::applyperplayerempeffects();
    }

    level notify( "nuke_emp_update" );
    level maps\mp\killstreaks\_jammer::_ID9812( level._ID22371.player );
    level maps\mp\killstreaks\_air_superiority::_ID9792( level._ID22371.player );
    level thread keepnukeemptimeremaining();
    maps\mp\gametypes\_hostmigration::_ID35597( level._ID22368 );
    level._ID22371.player = undefined;

    foreach ( var_2 in level.players )
    {
        if ( ( !isdefined( var_0 ) || var_2 != var_0 ) && !var_2 maps\mp\killstreaks\_unk1534::_ID29881() )
            var_2 maps\mp\killstreaks\_unk1534::_ID26023();
    }

    level notify( "nuke_emp_update" );
    level notify( "nuke_emp_ended" );
}

keepnukeemptimeremaining()
{
    level notify( "keepNukeEMPTimeRemaining" );
    level endon( "keepNukeEMPTimeRemaining" );
    level endon( "nuke_emp_ended" );

    for ( level._ID22369 = int( level._ID22368 ); level._ID22369; level._ID22369-- )
        wait 1.0;
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "spawned_player" );

        if ( isdefined( level.nukedetonated ) )
            thread _ID29203();
    }
}

_ID29203()
{
    wait 0.1;
    self visionsetpostapplyforplayer( level._ID22379, 0 );
}

_ID34490()
{
    level endon( "game_ended" );
    level endon( "disconnect" );
    level endon( "nuke_cancelled" );
    level endon( "nuke_death" );
    var_0 = level._ID22376 * 1000 + gettime();
    setomnvar( "ui_nuke_end_milliseconds", var_0 );
    level waittill( "host_migration_begin" );
    var_1 = maps\mp\gametypes\_hostmigration::_ID35770();

    if ( var_1 > 0 )
        setomnvar( "ui_nuke_end_milliseconds", var_0 + var_1 );
}

_ID38231()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "host_migration_end" );
        level _ID37971( 0 );
    }
}

_ID37971( var_0 )
{
    if ( isdefined( level.nukedeathvisionfunc ) )
        level thread [[ level.nukedeathvisionfunc ]]();
    else
        visionsetpostapply( level._ID22379, var_0 );
}
