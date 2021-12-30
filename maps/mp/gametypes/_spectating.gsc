// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID30972["allies"] = spawnstruct();
    level._ID30972["axis"] = spawnstruct();
    level thread _ID22877();
    level thread getlevelmlgcams();
}

_ID37039( var_0 )
{
    precacheshader( var_0 );
    var_1 = spawn( "script_model", ( 0, 0, 0 ) );
    var_1 setmodel( "tag_origin" );
    var_1.angles = ( 0, 0, 0 );
    var_2 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_2, "active", ( 0, 0, 0 ) );
    objective_icon( var_2, var_0 );
    objective_playermask_hidefromall( var_2 );
    objective_onentitywithrotation( var_2, var_1 );
    var_1._ID22495 = var_2;
    return var_1;
}

_ID37970( var_0 )
{
    for ( var_1 = 0; var_1 < level._ID36936.size; var_1++ )
    {
        if ( var_0 )
        {
            objective_playermask_showto( level._ID36936[var_1]._ID22495, self getentitynumber() );
            continue;
        }

        objective_playermask_hidefrom( level._ID36936[var_1]._ID22495, self getentitynumber() );
    }
}

getlevelmlgcams()
{
    var_0 = tolower( getdvar( "mapname" ) );
    var_1 = tablelookup( "mp/CameraPositions.csv", 0, var_0, 1 );
    var_2 = tablelookup( "mp/CameraPositions.csv", 0, var_0, 2 );
    level._ID36936 = [];
    level._ID36936[0] = _ID37039( "compass_mlg_cam1" );
    level._ID36936[1] = _ID37039( "compass_mlg_cam2" );
    level._ID36936[2] = _ID37039( "compass_mlg_cam3" );
    level._ID36936[3] = _ID37039( "compass_mlg_cam4" );

    if ( var_1 == "" )
        return;

    var_3 = tablelookup( "mp/CameraPositions.csv", 0, var_0, 3 );
    var_4 = tablelookup( "mp/CameraPositions.csv", 0, var_0, 4 );
    var_5 = tablelookup( "mp/CameraPositions.csv", 0, var_0, 5 );
    var_6 = tablelookup( "mp/CameraPositions.csv", 0, var_0, 6 );
    var_7 = tablelookup( "mp/CameraPositions.csv", 0, var_0, 7 );
    var_8 = tablelookup( "mp/CameraPositions.csv", 0, var_0, 8 );
    level.camera1pos = getcameravecorang( var_1 );
    level.camera1ang = getcameravecorang( var_2 );
    level.camera2pos = getcameravecorang( var_3 );
    level.camera2ang = getcameravecorang( var_4 );
    level.camera3pos = getcameravecorang( var_5 );
    level.camera3ang = getcameravecorang( var_6 );
    level.camera4pos = getcameravecorang( var_7 );
    level.camera4ang = getcameravecorang( var_8 );

    if ( var_0 == "mp_strikezone" )
    {
        var_9 = tablelookup( "mp/CameraPositions.csv", 0, var_0 + "_b", 1 );
        var_10 = tablelookup( "mp/CameraPositions.csv", 0, var_0 + "_b", 2 );
        var_11 = tablelookup( "mp/CameraPositions.csv", 0, var_0 + "_b", 3 );
        var_12 = tablelookup( "mp/CameraPositions.csv", 0, var_0 + "_b", 4 );
        var_13 = tablelookup( "mp/CameraPositions.csv", 0, var_0 + "_b", 5 );
        var_14 = tablelookup( "mp/CameraPositions.csv", 0, var_0 + "_b", 6 );
        var_15 = tablelookup( "mp/CameraPositions.csv", 0, var_0 + "_b", 7 );
        var_16 = tablelookup( "mp/CameraPositions.csv", 0, var_0 + "_b", 8 );
        level.camera5pos = getcameravecorang( var_9 );
        level.camera5ang = getcameravecorang( var_10 );
        level.camera6pos = getcameravecorang( var_11 );
        level.camera6ang = getcameravecorang( var_12 );
        level.camera7pos = getcameravecorang( var_13 );
        level.camera7ang = getcameravecorang( var_14 );
        level.camera8pos = getcameravecorang( var_15 );
        level.camera8ang = getcameravecorang( var_16 );
        return;
    }
}

getcameravecorang( var_0 )
{
    var_1 = strtok( var_0, " " );
    var_2 = ( int( var_1[0] ), int( var_1[1] ), int( var_1[2] ) );
    return var_2;
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread _ID22853();
        var_0 thread onjoinedspectators();
        var_0 thread _ID22904();
        var_0 thread _ID37746();
    }
}

_ID22853()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "joined_team" );
        _ID28880();
        _ID37970( 0 );
    }
}

onjoinedspectators()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "joined_spectators" );
        _ID28880();

        if ( self ismlgspectator() || isdefined( self.pers["mlgSpectator"] ) && self.pers["mlgSpectator"] )
        {
            self setmlgspectator( 1 );
            self setclientomnvar( "ui_use_mlg_hud", 1 );
            _ID37970( 1 );
        }
    }
}

_ID22904()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "spectating_cycle" );
        var_0 = self getspectatingplayer();

        if ( isdefined( var_0 ) )
        {

        }
    }
}

_ID37746()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "luinotifyserver",  var_0, var_1  );

        if ( var_0 == "mlg_view_change" )
            maps\mp\gametypes\_playerlogic::_ID26146();
    }
}

_ID34611()
{
    level endon( "game_ended" );

    for ( var_0 = 0; var_0 < level.players.size; var_0++ )
        level.players[var_0] _ID28880();
}

_ID28880()
{
    var_0 = self.sessionteam;

    if ( level.gameended && gettime() - level._ID14064 >= 2000 )
    {
        if ( level.multiteambased )
        {
            for ( var_1 = 0; var_1 < level._ID32668.size; var_1++ )
                self allowspectateteam( level._ID32668[var_1], 0 );
        }
        else
        {
            self allowspectateteam( "allies", 0 );
            self allowspectateteam( "axis", 0 );
        }

        self allowspectateteam( "freelook", 0 );
        self allowspectateteam( "none", 1 );
        return;
    }

    var_2 = maps\mp\gametypes\_tweakables::_ID15451( "game", "spectatetype" );

    if ( self ismlgspectator() )
        var_2 = 2;

    if ( maps\mp\_utility::bot_is_fireteam_mode() )
        var_2 = 1;

    switch ( var_2 )
    {
        case 0:
            if ( level.multiteambased )
            {
                for ( var_1 = 0; var_1 < level._ID32668.size; var_1++ )
                    self allowspectateteam( level._ID32668[var_1], 0 );
            }
            else
            {
                self allowspectateteam( "allies", 0 );
                self allowspectateteam( "axis", 0 );
            }

            self allowspectateteam( "freelook", 0 );
            self allowspectateteam( "none", 0 );
            break;
        case 1:
            if ( !level._ID32653 )
            {
                self allowspectateteam( "allies", 1 );
                self allowspectateteam( "axis", 1 );
                self allowspectateteam( "none", 1 );
                self allowspectateteam( "freelook", 0 );
            }
            else if ( isdefined( var_0 ) && ( var_0 == "allies" || var_0 == "axis" ) && !level.multiteambased )
            {
                self allowspectateteam( var_0, 1 );
                self allowspectateteam( maps\mp\_utility::getotherteam( var_0 ), 0 );
                self allowspectateteam( "freelook", 0 );
                self allowspectateteam( "none", 0 );
            }
            else if ( isdefined( var_0 ) && issubstr( var_0, "team_" ) && level.multiteambased )
            {
                for ( var_1 = 0; var_1 < level._ID32668.size; var_1++ )
                {
                    if ( var_0 == level._ID32668[var_1] )
                    {
                        self allowspectateteam( level._ID32668[var_1], 1 );
                        continue;
                    }

                    self allowspectateteam( level._ID32668[var_1], 0 );
                }

                self allowspectateteam( "freelook", 0 );
                self allowspectateteam( "none", 0 );
            }
            else
            {
                if ( level.multiteambased )
                {
                    for ( var_1 = 0; var_1 < level._ID32668.size; var_1++ )
                        self allowspectateteam( level._ID32668[var_1], 0 );
                }
                else
                {
                    self allowspectateteam( "allies", 0 );
                    self allowspectateteam( "axis", 0 );
                }

                self allowspectateteam( "freelook", 0 );
                self allowspectateteam( "none", 0 );
            }

            break;
        case 2:
            if ( level.multiteambased )
            {
                for ( var_1 = 0; var_1 < level._ID32668.size; var_1++ )
                    self allowspectateteam( level._ID32668[var_1], 1 );
            }
            else
            {
                self allowspectateteam( "allies", 1 );
                self allowspectateteam( "axis", 1 );
            }

            self allowspectateteam( "freelook", 1 );
            self allowspectateteam( "none", 1 );
            break;
    }

    if ( isdefined( var_0 ) && ( var_0 == "axis" || var_0 == "allies" ) )
    {
        if ( isdefined( level._ID30972[var_0].allowfreespectate ) )
            self allowspectateteam( "freelook", 1 );

        if ( isdefined( level._ID30972[var_0].allowenemyspectate ) )
        {
            self allowspectateteam( maps\mp\_utility::getotherteam( var_0 ), 1 );
            return;
        }

        return;
    }
}
