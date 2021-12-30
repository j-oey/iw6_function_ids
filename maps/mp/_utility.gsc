// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID12483()
{
    if ( isdefined( self.script_delay ) )
        wait(self.script_delay);

    self playsound( level._ID27382[self._ID27818] );
}

_beginlocationselection( var_0, var_1, var_2, var_3 )
{
    self beginlocationselection( var_1, var_2, var_3 );
    self._ID28032 = 1;
    self setblurforplayer( 10.3, 0.3 );
    thread _ID11759( "cancel_location" );
    thread _ID11759( "death" );
    thread _ID11759( "disconnect" );
    thread _ID11759( "used" );
    thread _ID11759( "weapon_change" );
    self endon( "stop_location_selection" );
    thread endselectiononendgame();
    thread endselectiononemp();

    if ( isdefined( var_0 ) && self.team != "spectator" )
    {
        if ( isdefined( self._ID31888 ) )
            self._ID31888 destroy();

        if ( self issplitscreenplayer() )
        {
            self._ID31888 = maps\mp\gametypes\_hud_util::createfontstring( "default", 1.3 );
            self._ID31888 maps\mp\gametypes\_hud_util::_ID28836( "CENTER", "CENTER", 0, -98 );
        }
        else
        {
            self._ID31888 = maps\mp\gametypes\_hud_util::createfontstring( "default", 1.6 );
            self._ID31888 maps\mp\gametypes\_hud_util::_ID28836( "CENTER", "CENTER", 0, -190 );
        }

        var_4 = _ID15101( var_0 );
        self._ID31888 settext( var_4 );
        return;
    }
}

stoplocationselection( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "generic";

    if ( !var_0 )
    {
        self setblurforplayer( 0, 0.3 );
        self endlocationselection();
        self._ID28032 = undefined;

        if ( isdefined( self._ID31888 ) )
            self._ID31888 destroy();
    }

    self notify( "stop_location_selection",  var_1  );
}

endselectiononemp()
{
    self endon( "stop_location_selection" );

    for (;;)
    {
        level waittill( "emp_update" );

        if ( !_ID18610() )
            continue;

        thread stoplocationselection( 0, "emp" );
        return;
    }
}

_ID11759( var_0 )
{
    self endon( "stop_location_selection" );
    self waittill( var_0 );
    thread stoplocationselection( var_0 == "disconnect", var_0 );
}

endselectiononendgame()
{
    self endon( "stop_location_selection" );
    level waittill( "game_ended" );
    thread stoplocationselection( 0, "end_game" );
}

isattachment( var_0 )
{
    if ( _ID18363() )
        var_1 = tablelookup( "mp/alien/alien_attachmentTable.csv", 4, var_0, 0 );
    else
        var_1 = tablelookup( "mp/attachmentTable.csv", 4, var_0, 0 );

    if ( isdefined( var_1 ) && var_1 != "" )
    {
        return 1;
        return;
    }

    return 0;
    return;
}

getattachmenttype( var_0 )
{
    if ( _ID18363() )
        var_1 = tablelookup( "mp/alien/alien_attachmentTable.csv", 4, var_0, 2 );
    else
        var_1 = tablelookup( "mp/attachmentTable.csv", 4, var_0, 2 );

    return var_1;
}

_ID9519( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    thread delaythread_proc( var_1, var_0, var_2, var_3, var_4, var_5, var_6 );
}

delaythread_proc( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    wait(var_1);

    if ( !isdefined( var_2 ) )
    {
        thread [[ var_0 ]]();
        return;
    }

    if ( !isdefined( var_3 ) )
    {
        thread [[ var_0 ]]( var_2 );
        return;
    }

    if ( !isdefined( var_4 ) )
    {
        thread [[ var_0 ]]( var_2, var_3 );
        return;
    }

    if ( !isdefined( var_5 ) )
    {
        thread [[ var_0 ]]( var_2, var_3, var_4 );
        return;
    }

    if ( !isdefined( var_6 ) )
    {
        thread [[ var_0 ]]( var_2, var_3, var_4, var_5 );
        return;
    }

    thread [[ var_0 ]]( var_2, var_3, var_4, var_5, var_6 );
    return;
    return;
    return;
    return;
    return;
}

_ID3810( var_0, var_1 )
{
    foreach ( var_4, var_3 in var_0 )
    {
        if ( var_4 == var_1 )
            return 1;
    }

    return 0;
}

_ID15251()
{
    var_0 = self.origin + ( 0, 0, 10 );
    var_1 = 11;
    var_2 = anglestoforward( self.angles );
    var_2 *= var_1;
    var_3[0] = var_0 + var_2;
    var_3[1] = var_0;
    var_4 = bullettrace( var_3[0], var_3[0] + ( 0, 0, -18 ), 0, undefined );

    if ( var_4["fraction"] < 1 )
    {
        var_5 = spawnstruct();
        var_5.origin = var_4["position"];
        var_5.angles = _ID23011( var_4["normal"] );
        return var_5;
    }

    var_4 = bullettrace( var_3[1], var_3[1] + ( 0, 0, -18 ), 0, undefined );

    if ( var_4["fraction"] < 1 )
    {
        var_5 = spawnstruct();
        var_5.origin = var_4["position"];
        var_5.angles = _ID23011( var_4["normal"] );
        return var_5;
    }

    var_3[2] = var_0 + ( 16, 16, 0 );
    var_3[3] = var_0 + ( 16, -16, 0 );
    var_3[4] = var_0 + ( -16, -16, 0 );
    var_3[5] = var_0 + ( -16, 16, 0 );
    var_6 = undefined;
    var_7 = undefined;

    for ( var_8 = 0; var_8 < var_3.size; var_8++ )
    {
        var_4 = bullettrace( var_3[var_8], var_3[var_8] + ( 0, 0, -1000 ), 0, undefined );

        if ( !isdefined( var_6 ) || var_4["fraction"] < var_6 )
        {
            var_6 = var_4["fraction"];
            var_7 = var_4["position"];
        }
    }

    if ( var_6 == 1 )
        var_7 = self.origin;

    var_5 = spawnstruct();
    var_5.origin = var_7;
    var_5.angles = _ID23011( var_4["normal"] );
    return var_5;
}

_ID23011( var_0 )
{
    var_1 = ( var_0[0], var_0[1], 0 );
    var_2 = length( var_1 );

    if ( !var_2 )
        return ( 0, 0, 0 );

    var_3 = vectornormalize( var_1 );
    var_4 = var_0[2] * -1;
    var_5 = ( var_3[0] * var_4, var_3[1] * var_4, var_2 );
    var_6 = vectortoangles( var_5 );
    return var_6;
}

deleteplacedentity( var_0 )
{
    var_1 = getentarray( var_0, "classname" );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        var_1[var_2] delete();
}

_ID24645( var_0, var_1, var_2 )
{
    if ( level.splitscreen )
    {
        if ( isdefined( level.players[0] ) )
        {
            level.players[0] playlocalsound( var_0 );
            return;
        }

        return;
    }

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_2 ) )
        {
            for ( var_3 = 0; var_3 < level.players.size; var_3++ )
            {
                var_4 = level.players[var_3];

                if ( var_4 issplitscreenplayer() && !var_4 issplitscreenplayerprimary() )
                    continue;

                if ( isdefined( var_4.pers["team"] ) && var_4.pers["team"] == var_1 && !_ID18616( var_4, var_2 ) )
                    var_4 playlocalsound( var_0 );
            }

            return;
        }

        for ( var_3 = 0; var_3 < level.players.size; var_3++ )
        {
            var_4 = level.players[var_3];

            if ( var_4 issplitscreenplayer() && !var_4 issplitscreenplayerprimary() )
                continue;

            if ( isdefined( var_4.pers["team"] ) && var_4.pers["team"] == var_1 )
                var_4 playlocalsound( var_0 );
        }

        return;
        return;
    }

    if ( isdefined( var_2 ) )
    {
        for ( var_3 = 0; var_3 < level.players.size; var_3++ )
        {
            if ( level.players[var_3] issplitscreenplayer() && !level.players[var_3] issplitscreenplayerprimary() )
                continue;

            if ( !_ID18616( level.players[var_3], var_2 ) )
                level.players[var_3] playlocalsound( var_0 );
        }

        return;
    }

    for ( var_3 = 0; var_3 < level.players.size; var_3++ )
    {
        if ( level.players[var_3] issplitscreenplayer() && !level.players[var_3] issplitscreenplayerprimary() )
            continue;

        level.players[var_3] playlocalsound( var_0 );
    }

    return;
    return;
    return;
}

sortlowermessages()
{
    for ( var_0 = 1; var_0 < self._ID20387.size; var_0++ )
    {
        var_1 = self._ID20387[var_0];
        var_2 = var_1._ID25014;

        for ( var_3 = var_0 - 1; var_3 >= 0 && var_2 > self._ID20387[var_3]._ID25014; var_3-- )
            self._ID20387[var_3 + 1] = self._ID20387[var_3];

        self._ID20387[var_3 + 1] = var_1;
    }
}

addlowermessage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_10 = undefined;

    foreach ( var_12 in self._ID20387 )
    {
        if ( var_12.name == var_0 )
        {
            if ( var_12._ID32858 == var_1 && var_12._ID25014 == var_3 )
                return;

            var_10 = var_12;
            break;
        }
    }

    if ( !isdefined( var_10 ) )
    {
        var_10 = spawnstruct();
        self._ID20387[self._ID20387.size] = var_10;
    }

    var_10.name = var_0;
    var_10._ID32858 = var_1;
    var_10._ID33037 = var_2;
    var_10.addtime = gettime();
    var_10._ID25014 = var_3;
    var_10._ID29992 = var_4;
    var_10._ID29872 = var_5;
    var_10.fadetoalpha = var_6;
    var_10.fadetoalphatime = var_7;
    var_10.hidewhenindemo = var_8;
    var_10.hidewheninmenu = var_9;
    sortlowermessages();
}

_ID26016( var_0 )
{
    if ( isdefined( self._ID20387 ) )
    {
        for ( var_1 = self._ID20387.size; var_1 > 0; var_1-- )
        {
            if ( self._ID20387[var_1 - 1].name != var_0 )
                continue;

            var_2 = self._ID20387[var_1 - 1];

            for ( var_3 = var_1; var_3 < self._ID20387.size; var_3++ )
            {
                if ( isdefined( self._ID20387[var_3] ) )
                    self._ID20387[var_3 - 1] = self._ID20387[var_3];
            }

            self._ID20387[self._ID20387.size - 1] = undefined;
        }

        sortlowermessages();
        return;
    }
}

getlowermessage()
{
    if ( !isdefined( self._ID20387 ) )
        return undefined;

    return self._ID20387[0];
}

setlowermessage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 1;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_4 ) )
        var_4 = 0;

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    if ( !isdefined( var_6 ) )
        var_6 = 0.85;

    if ( !isdefined( var_7 ) )
        var_7 = 3.0;

    if ( !isdefined( var_8 ) )
        var_8 = 0;

    if ( !isdefined( var_9 ) )
        var_9 = 1;

    addlowermessage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
    _ID34556();
}

_ID34556()
{
    if ( !isdefined( self ) )
        return;

    var_0 = getlowermessage();

    if ( !isdefined( var_0 ) )
    {
        if ( isdefined( self._ID20385 ) && isdefined( self._ID20392 ) )
        {
            self._ID20385.alpha = 0;
            self._ID20392.alpha = 0;
        }

        return;
    }

    self._ID20385 settext( var_0._ID32858 );
    self._ID20385.alpha = 0.85;
    self._ID20392.alpha = 1;
    self._ID20385.hidewhenindemo = var_0.hidewhenindemo;
    self._ID20385.hidewheninmenu = var_0.hidewheninmenu;

    if ( var_0._ID29872 )
    {
        self._ID20385 fadeovertime( min( var_0.fadetoalphatime, 60 ) );
        self._ID20385.alpha = var_0.fadetoalpha;
    }

    if ( var_0._ID33037 > 0 && var_0._ID29992 )
    {
        self._ID20392 settimer( max( var_0._ID33037 - ( gettime() - var_0.addtime ) / 1000, 0.1 ) );
        return;
    }

    if ( var_0._ID33037 > 0 && !var_0._ID29992 )
    {
        self._ID20392 settext( "" );
        self._ID20385 fadeovertime( min( var_0._ID33037, 60 ) );
        self._ID20385.alpha = 0;
        thread clearondeath( var_0 );
        thread clearafterfade( var_0 );
        return;
    }

    self._ID20392 settext( "" );
    return;
    return;
}

clearondeath( var_0 )
{
    self notify( "message_cleared" );
    self endon( "message_cleared" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "death" );
    _ID7495( var_0.name );
}

clearafterfade( var_0 )
{
    wait(var_0._ID33037);
    _ID7495( var_0.name );
    self notify( "message_cleared" );
}

_ID7495( var_0 )
{
    _ID26016( var_0 );
    _ID34556();
}

_ID7496()
{
    for ( var_0 = 0; var_0 < self._ID20387.size; var_0++ )
        self._ID20387[var_0] = undefined;

    if ( !isdefined( self._ID20385 ) )
        return;

    _ID34556();
}

_ID25004( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        if ( var_3.team != var_1 )
            continue;

        var_3 iprintln( var_0 );
    }
}

printboldonteam( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < level.players.size; var_2++ )
    {
        var_3 = level.players[var_2];

        if ( isdefined( var_3.pers["team"] ) && var_3.pers["team"] == var_1 )
            var_3 iprintlnbold( var_0 );
    }
}

_ID24997( var_0, var_1, var_2 )
{
    for ( var_3 = 0; var_3 < level.players.size; var_3++ )
    {
        var_4 = level.players[var_3];

        if ( isdefined( var_4.pers["team"] ) && var_4.pers["team"] == var_1 )
            var_4 iprintlnbold( var_0, var_2 );
    }
}

_ID25005( var_0, var_1, var_2 )
{
    for ( var_3 = 0; var_3 < level.players.size; var_3++ )
    {
        var_4 = level.players[var_3];

        if ( isdefined( var_4.pers["team"] ) && var_4.pers["team"] == var_1 )
            var_4 iprintln( var_0, var_2 );
    }
}

_ID25003( var_0, var_1 )
{
    var_2 = level.players;

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        if ( isdefined( var_1 ) )
        {
            if ( isdefined( var_2[var_3].pers["team"] ) && var_2[var_3].pers["team"] == var_1 )
                var_2[var_3] iprintln( var_0 );

            continue;
        }

        var_2[var_3] iprintln( var_0 );
    }
}

_ID24993( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = isdefined( var_4 );
    var_8 = 0;

    if ( isdefined( var_5 ) )
        var_8 = 1;

    if ( level.splitscreen || !var_7 )
    {
        for ( var_9 = 0; var_9 < level.players.size; var_9++ )
        {
            var_10 = level.players[var_9];
            var_11 = var_10.team;

            if ( isdefined( var_11 ) )
            {
                if ( var_11 == var_0 && isdefined( var_2 ) )
                {
                    var_10 iprintln( var_2, var_6 );
                    continue;
                }

                if ( var_11 == var_1 && isdefined( var_3 ) )
                    var_10 iprintln( var_3, var_6 );
            }
        }

        if ( var_7 )
        {
            level.players[0] playlocalsound( var_4 );
            return;
        }

        return;
    }

    if ( var_8 )
    {
        for ( var_9 = 0; var_9 < level.players.size; var_9++ )
        {
            var_10 = level.players[var_9];
            var_11 = var_10.team;

            if ( isdefined( var_11 ) )
            {
                if ( var_11 == var_0 )
                {
                    if ( isdefined( var_2 ) )
                        var_10 iprintln( var_2, var_6 );

                    var_10 playlocalsound( var_4 );
                    continue;
                }

                if ( var_11 == var_1 )
                {
                    if ( isdefined( var_3 ) )
                        var_10 iprintln( var_3, var_6 );

                    var_10 playlocalsound( var_5 );
                }
            }
        }

        return;
    }

    for ( var_9 = 0; var_9 < level.players.size; var_9++ )
    {
        var_10 = level.players[var_9];
        var_11 = var_10.team;

        if ( isdefined( var_11 ) )
        {
            if ( var_11 == var_0 )
            {
                if ( isdefined( var_2 ) )
                    var_10 iprintln( var_2, var_6 );

                var_10 playlocalsound( var_4 );
                continue;
            }

            if ( var_11 == var_1 )
            {
                if ( isdefined( var_3 ) )
                    var_10 iprintln( var_3, var_6 );
            }
        }
    }

    return;
    return;
}

_ID24995( var_0, var_1, var_2 )
{
    foreach ( var_4 in level.players )
    {
        if ( var_4.team != var_0 )
            continue;

        var_4 _ID24994( var_1, var_2 );
    }
}

_ID24994( var_0, var_1 )
{
    self iprintln( var_0 );
    self playlocalsound( var_1 );
}

_playlocalsound( var_0 )
{
    if ( level.splitscreen && self getentitynumber() != 0 )
        return;

    self playlocalsound( var_0 );
}

_ID11161( var_0, var_1, var_2, var_3 )
{
    var_0 = "scr_" + level._ID14086 + "_" + var_0;

    if ( getdvar( var_0 ) == "" )
    {
        setdvar( var_0, var_1 );
        return var_1;
    }

    var_4 = getdvarint( var_0 );

    if ( var_4 > var_3 )
        var_4 = var_3;
    else if ( var_4 < var_2 )
        var_4 = var_2;
    else
        return var_4;

    setdvar( var_0, var_4 );
    return var_4;
}

_ID11160( var_0, var_1, var_2, var_3 )
{
    var_0 = "scr_" + level._ID14086 + "_" + var_0;

    if ( getdvar( var_0 ) == "" )
    {
        setdvar( var_0, var_1 );
        return var_1;
    }

    var_4 = getdvarfloat( var_0 );

    if ( var_4 > var_3 )
        var_4 = var_3;
    else if ( var_4 < var_2 )
        var_4 = var_2;
    else
        return var_4;

    setdvar( var_0, var_4 );
    return var_4;
}

_ID23845( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
    {
        playsoundatpos( self gettagorigin( var_1 ), var_0 );
        return;
    }

    playsoundatpos( self.origin, var_0 );
    return;
}

getotherteam( var_0 )
{
    if ( level.multiteambased )
    {

    }

    if ( var_0 == "allies" )
        return "axis";
    else if ( var_0 == "axis" )
        return "allies";
    else
        return "none";
}

wait_endon( var_0, var_1, var_2, var_3 )
{
    self endon( var_1 );

    if ( isdefined( var_2 ) )
        self endon( var_2 );

    if ( isdefined( var_3 ) )
        self endon( var_3 );

    wait(var_0);
}

_ID17982( var_0 )
{
    if ( !isdefined( self.pers[var_0] ) )
    {
        self.pers[var_0] = 0;
        return;
    }
}

_ID15245( var_0 )
{
    return self.pers[var_0];
}

_ID17529( var_0, var_1, var_2 )
{
    if ( isdefined( self ) && isdefined( self.pers ) && isdefined( self.pers[var_0] ) )
    {
        self.pers[var_0] = self.pers[var_0] + var_1;

        if ( !isdefined( var_2 ) || var_2 == 0 )
        {
            maps\mp\gametypes\_persistence::_ID31495( var_0, var_1 );
            return;
        }

        return;
    }
}

_ID28819( var_0, var_1 )
{
    self.pers[var_0] = var_1;
}

initplayerstat( var_0, var_1 )
{
    if ( !isdefined( self._ID31525["stats_" + var_0] ) )
    {
        if ( !isdefined( var_1 ) )
            var_1 = 0;

        self._ID31525["stats_" + var_0] = spawnstruct();
        self._ID31525["stats_" + var_0]._ID34844 = var_1;
        return;
    }
}

_ID17531( var_0, var_1 )
{
    if ( isagent( self ) || isbot( self ) )
        return;

    var_2 = self._ID31525["stats_" + var_0];
    var_2._ID34844 = var_2._ID34844 + var_1;
}

_ID28832( var_0, var_1 )
{
    var_2 = self._ID31525["stats_" + var_0];
    var_2._ID34844 = var_1;
    var_2._ID33037 = gettime();
}

getplayerstat( var_0 )
{
    return self._ID31525["stats_" + var_0]._ID34844;
}

_ID15260( var_0 )
{
    return self._ID31525["stats_" + var_0]._ID33037;
}

_ID28833( var_0, var_1 )
{
    var_2 = getplayerstat( var_0 );

    if ( var_1 > var_2 )
    {
        _ID28832( var_0, var_1 );
        return;
    }
}

_ID28834( var_0, var_1 )
{
    var_2 = getplayerstat( var_0 );

    if ( var_1 < var_2 )
    {
        _ID28832( var_0, var_1 );
        return;
    }
}

_ID34572( var_0, var_1, var_2 )
{
    if ( !_ID25420() )
        return;

    var_3 = maps\mp\gametypes\_persistence::_ID31510( var_1 );
    var_4 = maps\mp\gametypes\_persistence::_ID31510( var_2 );

    if ( var_4 == 0 )
        var_4 = 1;

    maps\mp\gametypes\_persistence::_ID31526( var_0, int( var_3 * 1000 / var_4 ) );
}

_ID34573( var_0, var_1, var_2 )
{
    if ( !_ID25420() )
        return;

    var_3 = maps\mp\gametypes\_persistence::statgetbuffered( var_1 );
    var_4 = maps\mp\gametypes\_persistence::statgetbuffered( var_2 );

    if ( var_4 == 0 )
        var_4 = 1;

    maps\mp\gametypes\_persistence::_ID31527( var_0, int( var_3 * 1000 / var_4 ) );
}

_ID35777( var_0 )
{
    if ( level.lastslowprocessframe == gettime() )
    {
        if ( isdefined( var_0 ) && var_0 )
        {
            while ( level.lastslowprocessframe == gettime() )
                wait 0.05;
        }
        else
        {
            wait 0.05;

            if ( level.lastslowprocessframe == gettime() )
            {
                wait 0.05;

                if ( level.lastslowprocessframe == gettime() )
                {
                    wait 0.05;

                    if ( level.lastslowprocessframe == gettime() )
                        wait 0.05;
                }
            }
        }
    }

    level.lastslowprocessframe = gettime();
}

waitfortimeornotify( var_0, var_1 )
{
    self endon( var_1 );
    wait(var_0);
}

_ID18616( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( var_0 == var_1[var_2] )
            return 1;
    }

    return 0;
}

_ID19760( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = game["dialog"][var_0];

    if ( !isdefined( var_5 ) )
        return;

    var_6 = game["voice"]["allies"] + var_5;
    var_7 = game["voice"]["axis"] + var_5;
    queuedialog( var_6, var_7, var_0, 2, var_1, var_2, var_3, var_4 );
}

_ID19767( var_0, var_1, var_2, var_3 )
{
    foreach ( var_5 in var_1 )
        var_5 _ID19765( var_0, var_2, undefined, var_3 );
}

_ID19765( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( game["dialog"][var_0] ) )
        return;

    var_4 = self.pers["team"];

    if ( isdefined( var_4 ) && ( var_4 == "axis" || var_4 == "allies" ) )
    {
        var_5 = game["voice"][var_4] + game["dialog"][var_0];
        self queuedialogforplayer( var_5, var_0, 2, var_1, var_2, var_3 );
        return;
    }
}

_ID15173()
{
    for ( var_0 = 0; var_0 < self._ID19768.size; var_0++ )
    {
        if ( issubstr( self._ID19768[var_0], "losing" ) )
        {
            if ( self.team == "allies" )
            {
                if ( issubstr( level._ID4604, self._ID19768[var_0] ) )
                    return self._ID19768[var_0];
                else
                    common_scripts\utility::array_remove( self._ID19768, self._ID19768[var_0] );
            }
            else if ( issubstr( level.alliescapturing, self._ID19768[var_0] ) )
                return self._ID19768[var_0];
            else
                common_scripts\utility::array_remove( self._ID19768, self._ID19768[var_0] );

            continue;
        }

        return level.alliescapturing[self._ID19768];
    }
}

orderonqueueddialog()
{
    self endon( "disconnect" );
    var_0 = [];
    var_0 = self._ID19768;

    for ( var_1 = 0; var_1 < self._ID19768.size; var_1++ )
    {
        if ( issubstr( self._ID19768[var_1], "losing" ) )
        {
            for ( var_2 = var_1; var_2 >= 0; var_2-- )
            {
                if ( !issubstr( self._ID19768[var_2], "losing" ) && var_2 != 0 )
                    continue;

                if ( var_2 != var_1 )
                {
                    arrayinsertion( var_0, self._ID19768[var_1], var_2 );
                    common_scripts\utility::array_remove( var_0, self._ID19768[var_1] );
                    break;
                }
            }
        }
    }

    self._ID19768 = var_0;
}

_ID34559()
{
    if ( self.pers["team"] == "spectator" )
    {
        self setclientdvar( "g_scriptMainMenu", game["menu_team"] );
        return;
    }

    self setclientdvar( "g_scriptMainMenu", game["menu_class_" + self.pers["team"]] );
    return;
}

updateobjectivetext()
{
    if ( self.pers["team"] == "spectator" )
    {
        self setclientdvar( "cg_objectiveText", "" );
        return;
    }

    if ( getwatcheddvar( "scorelimit" ) > 0 && !_ID18716() )
    {
        if ( isdefined( _ID15199( self.pers["team"] ) ) )
        {
            if ( level.splitscreen )
            {
                self setclientdvar( "cg_objectiveText", _ID15199( self.pers["team"] ) );
                return;
            }

            self setclientdvar( "cg_objectiveText", _ID15199( self.pers["team"] ), getwatcheddvar( "scorelimit" ) );
            return;
            return;
        }

        return;
    }

    if ( isdefined( getobjectivetext( self.pers["team"] ) ) )
    {
        self setclientdvar( "cg_objectiveText", getobjectivetext( self.pers["team"] ) );
        return;
    }

    return;
}

_ID28804( var_0, var_1 )
{
    game["strings"]["objective_" + var_0] = var_1;
}

_ID28803( var_0, var_1 )
{
    game["strings"]["objective_score_" + var_0] = var_1;
}

setobjectivehinttext( var_0, var_1 )
{
    game["strings"]["objective_hint_" + var_0] = var_1;
}

getobjectivetext( var_0 )
{
    return game["strings"]["objective_" + var_0];
}

_ID15199( var_0 )
{
    return game["strings"]["objective_score_" + var_0];
}

_ID15198( var_0 )
{
    return game["strings"]["objective_hint_" + var_0];
}

_ID15435()
{
    if ( !isdefined( level._ID31480 ) || !isdefined( level.discardtime ) )
        return 0;

    if ( level._ID33075 )
    {
        return level.timerpausetime - level._ID31480 - level.discardtime;
        return;
    }

    return gettime() - level._ID31480 - level.discardtime;
    return;
}

gettimepassedpercentage()
{
    return _ID15435() / _ID15434() * 60 * 1000 * 100;
}

_ID15332()
{
    return _ID15435() / 1000;
}

_ID15150()
{
    return _ID15332() / 60;
}

clearkillcamstate()
{
    self.forcespectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
}

_ID18658()
{
    return self.spectatekillcam;
}

_ID18844( var_0 )
{
    return isdefined( var_0 ) && var_0 != "";
}

getvalueinrange( var_0, var_1, var_2 )
{
    if ( var_0 > var_2 )
    {
        return var_2;
        return;
    }

    if ( var_0 < var_1 )
    {
        return var_1;
        return;
    }

    return var_0;
    return;
    return;
}

_ID35579( var_0 )
{
    var_1 = gettime();
    var_2 = ( gettime() - var_1 ) / 1000;

    if ( var_2 < var_0 )
    {
        wait(var_0 - var_2);
        return var_0;
        return;
    }

    return var_2;
    return;
}

logxpgains()
{
    if ( !isdefined( self._ID36465 ) )
        return;

    var_0 = getarraykeys( self._ID36465 );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_2 = self._ID36465[var_0[var_1]];

        if ( !var_2 )
            continue;

        self logstring( "xp " + var_0[var_1] + ": " + var_2 );
    }
}

_ID25715( var_0, var_1, var_2, var_3 )
{
    _ID25723( "roundswitch", var_1 );
    var_0 = "scr_" + var_0 + "_roundswitch";
    level._ID26778 = var_0;
    level._ID26780 = var_2;
    level._ID26779 = var_3;
    level._ID26777 = getdvarint( var_0, var_1 );

    if ( level._ID26777 < var_2 )
    {
        level._ID26777 = var_2;
        return;
    }

    if ( level._ID26777 > var_3 )
    {
        level._ID26777 = var_3;
        return;
    }

    return;
}

_ID25714( var_0, var_1 )
{
    _ID25723( "roundlimit", var_1 );
}

_ID25713( var_0, var_1 )
{
    _ID25723( "numTeams", var_1 );
}

_ID25724( var_0, var_1 )
{
    _ID25723( "winlimit", var_1 );
}

_ID25717( var_0, var_1 )
{
    _ID25723( "scorelimit", var_1 );
}

_ID25718( var_0, var_1 )
{
    _ID25722( "timelimit", var_1 );
    setdvar( "ui_timelimit", _ID15434() );
}

_ID25706( var_0, var_1 )
{
    _ID25723( "halftime", var_1 );
    setdvar( "ui_halftime", gethalftime() );
}

_ID25712( var_0, var_1 )
{
    _ID25723( "numlives", var_1 );
}

_ID28812( var_0 )
{
    setdvar( "overtimeTimeLimit", var_0 );
}

get_damageable_player( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2._ID18738 = 1;
    var_2._ID18531 = 0;
    var_2.entity = var_0;
    var_2._ID8961 = var_1;
    return var_2;
}

_ID14408( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2._ID18738 = 0;
    var_2._ID18531 = 0;
    var_2._ID18776 = 1;
    var_2.entity = var_0;
    var_2._ID8961 = var_1;
    return var_2;
}

_ID14403( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2._ID18738 = 0;
    var_2._ID18531 = 0;
    var_2.entity = var_0;
    var_2._ID8961 = var_1;
    return var_2;
}

get_damageable_mine( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2._ID18738 = 0;
    var_2._ID18531 = 0;
    var_2.entity = var_0;
    var_2._ID8961 = var_1;
    return var_2;
}

_ID14407( var_0 )
{
    return var_0.origin + ( 0, 0, 32 );
}

_ID15362()
{
    if ( self getstance() == "crouch" )
        var_0 = self.origin + ( 0, 0, 24 );
    else if ( self getstance() == "prone" )
        var_0 = self.origin + ( 0, 0, 10 );
    else
        var_0 = self.origin + ( 0, 0, 32 );

    return var_0;
}

_ID14404( var_0 )
{
    return var_0.origin;
}

getdvarvec( var_0 )
{
    var_1 = getdvar( var_0 );

    if ( var_1 == "" )
        return ( 0, 0, 0 );

    var_2 = strtok( var_1, " " );

    if ( var_2.size < 3 )
        return ( 0, 0, 0 );

    setdvar( "tempR", var_2[0] );
    setdvar( "tempG", var_2[1] );
    setdvar( "tempB", var_2[2] );
    return ( getdvarfloat( "tempR" ), getdvarfloat( "tempG" ), getdvarfloat( "tempB" ) );
}

_ID31978( var_0, var_1 )
{
    if ( var_0.size <= var_1.size )
        return var_0;

    if ( getsubstr( var_0, var_0.size - var_1.size, var_0.size ) == var_1 )
        return getsubstr( var_0, 0, var_0.size - var_1.size );

    return var_0;
}

_takeweaponsexcept( var_0 )
{
    var_1 = self getweaponslistall();

    foreach ( var_3 in var_1 )
    {
        if ( var_3 == var_0 )
        {
            continue;
            continue;
        }

        self takeweapon( var_3 );
    }
}

_ID27304()
{
    var_0 = spawnstruct();
    var_0._ID22604 = self getoffhandsecondaryclass();
    var_0.actionslots = self._ID27299;
    var_0.currentweapon = self getcurrentweapon();
    var_1 = self getweaponslistall();
    var_0._ID36284 = [];

    foreach ( var_3 in var_1 )
    {
        if ( weaponinventorytype( var_3 ) == "exclusive" )
            continue;

        if ( weaponinventorytype( var_3 ) == "altmode" )
            continue;

        var_4 = spawnstruct();
        var_4.name = var_3;
        var_4._ID7535 = self getweaponammoclip( var_3, "right" );
        var_4._ID7534 = self getweaponammoclip( var_3, "left" );
        var_4._ID31748 = self getweaponammostock( var_3 );

        if ( isdefined( self._ID32944 ) && self._ID32944 == var_3 )
            var_4._ID31748--;

        var_0._ID36284[var_0._ID36284.size] = var_4;
    }

    self.script_savedata = var_0;
}

_ID26202()
{
    var_0 = self.script_savedata;
    self setoffhandsecondaryclass( var_0._ID22604 );

    foreach ( var_2 in var_0._ID36284 )
    {
        _giveweapon( var_2.name, int( tablelookup( "mp/camoTable.csv", 1, self.loadoutprimarycamo, 0 ) ) );
        self setweaponammoclip( var_2.name, var_2._ID7535, "right" );

        if ( issubstr( var_2.name, "akimbo" ) )
            self setweaponammoclip( var_2.name, var_2._ID7534, "left" );

        self setweaponammostock( var_2.name, var_2._ID31748 );
    }

    foreach ( var_6, var_5 in var_0.actionslots )
        _setactionslot( var_6, var_5.type, var_5.item );

    if ( self getcurrentweapon() == "none" )
    {
        var_2 = var_0.currentweapon;

        if ( var_2 == "none" )
            var_2 = common_scripts\utility::_ID15114();

        self setspawnweapon( var_2 );
        self switchtoweapon( var_2 );
        return;
    }
}

_setactionslot( var_0, var_1, var_2 )
{
    self._ID27299[var_0].type = var_1;
    self._ID27299[var_0].item = var_2;
    self setactionslot( var_0, var_1, var_2 );
}

_ID18630( var_0 )
{
    if ( int( var_0 ) != var_0 )
        return 1;

    return 0;
}

_ID25723( var_0, var_1 )
{
    var_2 = "scr_" + level._ID14086 + "_" + var_0;
    level.watchdvars[var_2] = spawnstruct();
    level.watchdvars[var_2]._ID34844 = getdvarint( var_2, var_1 );
    level.watchdvars[var_2].type = "int";
    level.watchdvars[var_2]._ID22322 = "update_" + var_0;
}

_ID25722( var_0, var_1 )
{
    var_2 = "scr_" + level._ID14086 + "_" + var_0;
    level.watchdvars[var_2] = spawnstruct();
    level.watchdvars[var_2]._ID34844 = getdvarfloat( var_2, var_1 );
    level.watchdvars[var_2].type = "float";
    level.watchdvars[var_2]._ID22322 = "update_" + var_0;
}

_ID25721( var_0, var_1 )
{
    var_2 = "scr_" + level._ID14086 + "_" + var_0;
    level.watchdvars[var_2] = spawnstruct();
    level.watchdvars[var_2]._ID34844 = getdvar( var_2, var_1 );
    level.watchdvars[var_2].type = "string";
    level.watchdvars[var_2]._ID22322 = "update_" + var_0;
}

_ID28811( var_0, var_1 )
{
    var_0 = "scr_" + level._ID14086 + "_" + var_0;
    level._ID23179[var_0] = var_1;
}

getwatcheddvar( var_0 )
{
    var_0 = "scr_" + level._ID14086 + "_" + var_0;

    if ( isdefined( level._ID23179 ) && isdefined( level._ID23179[var_0] ) )
        return level._ID23179[var_0];

    return level.watchdvars[var_0]._ID34844;
}

_ID34645()
{
    while ( game["state"] == "playing" )
    {
        var_0 = getarraykeys( level.watchdvars );

        foreach ( var_2 in var_0 )
        {
            if ( level.watchdvars[var_2].type == "string" )
                var_3 = _ID15274( var_2, level.watchdvars[var_2]._ID34844 );
            else if ( level.watchdvars[var_2].type == "float" )
                var_3 = _ID15023( var_2, level.watchdvars[var_2]._ID34844 );
            else
                var_3 = _ID15069( var_2, level.watchdvars[var_2]._ID34844 );

            if ( var_3 != level.watchdvars[var_2]._ID34844 )
            {
                level.watchdvars[var_2]._ID34844 = var_3;
                level notify( level.watchdvars[var_2]._ID22322,  var_3  );
            }
        }

        wait 1.0;
    }
}

_ID18768()
{
    if ( !level._ID32653 )
        return 0;

    if ( getwatcheddvar( "winlimit" ) != 1 && getwatcheddvar( "roundlimit" ) != 1 )
        return 1;

    if ( level._ID14086 == "sr" || level._ID14086 == "sd" || level._ID14086 == "siege" )
        return 1;

    return 0;
}

_ID18625()
{
    if ( !level._ID32653 )
        return 1;

    if ( getwatcheddvar( "roundlimit" ) > 1 && game["roundsPlayed"] == 0 )
        return 1;

    if ( getwatcheddvar( "winlimit" ) > 1 && game["roundsWon"]["allies"] == 0 && game["roundsWon"]["axis"] == 0 )
        return 1;

    return 0;
}

islastround()
{
    if ( !level._ID32653 )
        return 1;

    if ( getwatcheddvar( "roundlimit" ) > 1 && game["roundsPlayed"] >= getwatcheddvar( "roundlimit" ) - 1 )
        return 1;

    if ( getwatcheddvar( "winlimit" ) > 1 && game["roundsWon"]["allies"] >= getwatcheddvar( "winlimit" ) - 1 && game["roundsWon"]["axis"] >= getwatcheddvar( "winlimit" ) - 1 )
        return 1;

    return 0;
}

_ID35914()
{
    if ( !level._ID32653 )
        return 1;

    if ( isdefined( level._ID22866 ) )
        return 0;

    if ( getwatcheddvar( "winlimit" ) == 1 && _ID17025() )
        return 1;

    if ( getwatcheddvar( "roundlimit" ) == 1 )
        return 1;

    return 0;
}

_ID35913()
{
    if ( level.forcedend )
        return 1;

    if ( !level._ID32653 )
        return 1;

    if ( hitroundlimit() || _ID17025() )
        return 1;

    return 0;
}

_ID17024()
{
    if ( getwatcheddvar( "timelimit" ) <= 0 )
        return 0;

    var_0 = maps\mp\gametypes\_gamelogic::gettimeremaining();

    if ( var_0 > 0 )
        return 0;

    return 1;
}

hitroundlimit()
{
    if ( getwatcheddvar( "roundlimit" ) <= 0 )
        return 0;

    return game["roundsPlayed"] >= getwatcheddvar( "roundlimit" );
}

_ID17022()
{
    if ( _ID18716() )
        return 0;

    if ( getwatcheddvar( "scorelimit" ) <= 0 )
        return 0;

    if ( level._ID32653 )
    {
        if ( game["teamScores"]["allies"] >= getwatcheddvar( "scorelimit" ) || game["teamScores"]["axis"] >= getwatcheddvar( "scorelimit" ) )
            return 1;
    }
    else
    {
        for ( var_0 = 0; var_0 < level.players.size; var_0++ )
        {
            var_1 = level.players[var_0];

            if ( isdefined( var_1.score ) && var_1.score >= getwatcheddvar( "scorelimit" ) )
                return 1;
        }
    }

    return 0;
}

_ID17025()
{
    if ( getwatcheddvar( "winlimit" ) <= 0 )
        return 0;

    if ( !level._ID32653 )
        return 1;

    if ( getroundswon( "allies" ) >= getwatcheddvar( "winlimit" ) || getroundswon( "axis" ) >= getwatcheddvar( "winlimit" ) )
        return 1;

    return 0;
}

getscorelimit()
{
    if ( _ID18768() )
    {
        if ( getwatcheddvar( "roundlimit" ) )
        {
            return getwatcheddvar( "roundlimit" );
            return;
        }

        return getwatcheddvar( "winlimit" );
        return;
        return;
    }

    return getwatcheddvar( "scorelimit" );
    return;
}

getroundswon( var_0 )
{
    return game["roundsWon"][var_0];
}

_ID18716()
{
    return level._ID22489;
}

_ID15434()
{
    if ( inovertime() && ( !isdefined( game["inNukeOvertime"] ) || !game["inNukeOvertime"] ) )
    {
        var_0 = int( getdvar( "overtimeTimeLimit" ) );

        if ( isdefined( var_0 ) )
        {
            return var_0;
            return;
        }

        return 1;
        return;
        return;
    }

    if ( isdefined( level._ID9003 ) && level._ID9003 && isdefined( level.bombexploded ) && level.bombexploded > 0 )
    {
        return getwatcheddvar( "timelimit" ) + level.bombexploded * level.ddtimetoadd;
        return;
    }

    return getwatcheddvar( "timelimit" );
    return;
    return;
}

gethalftime()
{
    if ( inovertime() )
    {
        return 0;
        return;
    }

    if ( isdefined( game["inNukeOvertime"] ) && game["inNukeOvertime"] )
    {
        return 0;
        return;
    }

    return getwatcheddvar( "halftime" );
    return;
    return;
}

inovertime()
{
    return isdefined( game["status"] ) && game["status"] == "overtime";
}

_ID14070()
{
    if ( isdefined( level._ID14070 ) )
        return level._ID14070;

    if ( level._ID32653 )
        return level.hasspawned["axis"] && level.hasspawned["allies"];

    return level._ID20754 > 1;
}

_ID14896( var_0 )
{
    var_1 = ( 0, 0, 0 );

    if ( !var_0.size )
        return undefined;

    foreach ( var_3 in var_0 )
        var_1 += var_3.origin;

    var_5 = int( var_1[0] / var_0.size );
    var_6 = int( var_1[1] / var_0.size );
    var_7 = int( var_1[2] / var_0.size );
    var_1 = ( var_5, var_6, var_7 );
    return var_1;
}

_ID15126( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level.players )
    {
        if ( !isalive( var_3 ) )
            continue;

        if ( level._ID32653 && isdefined( var_0 ) )
        {
            if ( var_0 == var_3.pers["team"] )
                var_1[var_1.size] = var_3;

            continue;
        }

        var_1[var_1.size] = var_3;
    }

    return var_1;
}

_ID29199( var_0 )
{
    if ( isdefined( self.carryicon ) )
        self.carryicon.alpha = 0;

    self.usingremote = var_0;
    common_scripts\utility::_disableoffhandweapons();
    self notify( "using_remote" );
}

_ID15315()
{
    return self.usingremote;
}

_ID13582( var_0 )
{
    if ( isdefined( level.hostmigrationtimer ) )
    {
        self._ID17096 = 1;
        self freezecontrols( 1 );
        return;
    }

    self freezecontrols( var_0 );
    self.controlsfrozen = var_0;
}

_ID7513()
{
    if ( isdefined( self.carryicon ) )
        self.carryicon.alpha = 1;

    self.usingremote = undefined;
    common_scripts\utility::_ID1647();
    var_0 = self getcurrentweapon();

    if ( var_0 == "none" || _ID18679( var_0 ) )
    {
        var_1 = common_scripts\utility::_ID15114();

        if ( _ID18757( self ) )
        {
            if ( !self hasweapon( var_1 ) )
                var_1 = maps\mp\killstreaks\_killstreaks::_ID15018();

            self switchtoweapon( var_1 );
        }
    }

    _ID13582( 0 );
    self notify( "stopped_using_remote" );
}

_ID18837()
{
    return isdefined( self.usingremote );
}

_ID18767()
{
    return isdefined( self._ID18767 ) && self._ID18767;
}

_ID25239( var_0 )
{
    if ( !isdefined( level._ID25242 ) )
        level._ID25242 = [];

    level._ID25242[var_0] = [];
}

_ID25237( var_0, var_1 )
{
    level._ID25242[var_0][level._ID25242[var_0].size] = var_1;
}

_ID25241( var_0 )
{
    var_1 = undefined;
    var_2 = [];

    foreach ( var_4 in level._ID25242[var_0] )
    {
        if ( !isdefined( var_4 ) )
            continue;

        if ( !isdefined( var_1 ) )
        {
            var_1 = var_4;
            continue;
        }

        var_2[var_2.size] = var_4;
    }

    level._ID25242[var_0] = var_2;
    return var_1;
}

_giveweapon( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = -1;

    if ( issubstr( var_0, "_akimbo" ) || isdefined( var_2 ) && var_2 == 1 )
    {
        self giveweapon( var_0, var_1, 1 );
        return;
    }

    self giveweapon( var_0, var_1, 0 );
    return;
}

perksenabled()
{
    return getdvarint( "scr_game_perks" ) == 1;
}

_hasperk( var_0 )
{
    var_1 = self._ID23452;

    if ( !isdefined( var_1 ) )
        return 0;

    if ( isdefined( var_1[var_0] ) )
        return 1;

    return 0;
}

_ID15611( var_0, var_1 )
{
    if ( issubstr( var_0, "specialty_weapon_" ) )
    {
        _setperk( var_0, var_1 );
        return;
    }

    _setperk( var_0, var_1 );
    _setextraperks( var_0 );
}

giveperkequipment( var_0, var_1 )
{
    if ( var_0 == "none" || var_0 == "specialty_null" )
    {
        self setoffhandprimaryclass( "none" );
        return;
    }

    self._ID24968 = var_0;

    if ( issubstr( var_0, "_mp" ) )
    {
        switch ( var_0 )
        {
            case "frag_grenade_mp":
            case "mortar_shell_mp":
            case "mortar_shelljugg_mp":
                self setoffhandprimaryclass( "frag" );
                break;
            case "throwingknife_mp":
            case "throwingknifejugg_mp":
                self setoffhandprimaryclass( "throwingknife" );
                break;
            case "trophy_mp":
            case "flash_grenade_mp":
            case "emp_grenade_mp":
            case "motion_sensor_mp":
            case "thermobaric_grenade_mp":
                self setoffhandprimaryclass( "flash" );
                break;
            case "smoke_grenade_mp":
            case "smoke_grenadejugg_mp":
            case "concussion_grenade_mp":
                self setoffhandprimaryclass( "smoke" );
                break;
            default:
                self setoffhandprimaryclass( "other" );
                break;
        }

        _giveweapon( var_0, 0 );
        self givestartammo( var_0 );
        _setperk( var_0, var_1 );
        return;
    }

    _setperk( var_0, var_1 );
    return;
}

_ID15613( var_0, var_1 )
{
    if ( var_0 == "none" || var_0 == "specialty_null" )
    {
        self setoffhandsecondaryclass( "none" );
        return;
    }

    self._ID27981 = var_0;

    if ( issubstr( var_0, "_mp" ) )
    {
        switch ( var_0 )
        {
            case "frag_grenade_mp":
            case "mortar_shell_mp":
            case "mortar_shelljugg_mp":
                self setoffhandsecondaryclass( "frag" );
                break;
            case "throwingknife_mp":
            case "throwingknifejugg_mp":
                self setoffhandsecondaryclass( "throwingknife" );
                break;
            case "trophy_mp":
            case "flash_grenade_mp":
            case "emp_grenade_mp":
            case "motion_sensor_mp":
            case "thermobaric_grenade_mp":
                self setoffhandsecondaryclass( "flash" );
                break;
            case "smoke_grenade_mp":
            case "smoke_grenadejugg_mp":
            case "concussion_grenade_mp":
                self setoffhandsecondaryclass( "smoke" );
                break;
            default:
                self setoffhandsecondaryclass( "other" );
                break;
        }

        _giveweapon( var_0, 0 );

        switch ( var_0 )
        {
            case "trophy_mp":
            case "flash_grenade_mp":
            case "emp_grenade_mp":
            case "motion_sensor_mp":
            case "thermobaric_grenade_mp":
            case "smoke_grenade_mp":
            case "concussion_grenade_mp":
                self setweaponammoclip( var_0, 1 );
                break;
            default:
                self givestartammo( var_0 );
                break;
        }

        _setperk( var_0, var_1 );
        return;
    }

    _setperk( var_0, var_1 );
    return;
}

_setperk( var_0, var_1 )
{
    self._ID23452[var_0] = 1;
    self.perksperkname[var_0] = var_0;
    self._ID23456[var_0] = var_1;
    var_2 = level._ID23453[var_0];

    if ( isdefined( var_2 ) )
        self thread [[ var_2 ]]();

    self setperk( var_0, !isdefined( level._ID27927[var_0] ), var_1 );
}

_setextraperks( var_0 )
{
    if ( var_0 == "specialty_stun_resistance" )
        _ID15611( "specialty_empimmune", 0 );

    if ( var_0 == "specialty_hardline" )
        _ID15611( "specialty_assists", 0 );

    if ( var_0 == "specialty_incog" )
    {
        _ID15611( "specialty_spygame", 0 );
        _ID15611( "specialty_coldblooded", 0 );
        _ID15611( "specialty_noscopeoutline", 0 );
        _ID15611( "specialty_heartbreaker", 0 );
    }

    if ( var_0 == "specialty_blindeye" )
        _ID15611( "specialty_noplayertarget", 0 );

    if ( var_0 == "specialty_sharp_focus" )
        _ID15611( "specialty_reducedsway", 0 );

    if ( var_0 == "specialty_quickswap" )
    {
        _ID15611( "specialty_fastoffhand", 0 );
        return;
    }
}

_unsetperk( var_0 )
{
    self._ID23452[var_0] = undefined;
    self.perksperkname[var_0] = undefined;
    self._ID23456[var_0] = undefined;

    if ( isdefined( level._ID23459[var_0] ) )
        self thread [[ level._ID23459[var_0] ]]();

    self unsetperk( var_0, !isdefined( level._ID27927[var_0] ) );
}

_unsetextraperks( var_0 )
{
    if ( var_0 == "specialty_bulletaccuracy" )
        _unsetperk( "specialty_steadyaimpro" );

    if ( var_0 == "specialty_coldblooded" )
        _unsetperk( "specialty_heartbreaker" );

    if ( var_0 == "specialty_fasterlockon" )
        _unsetperk( "specialty_armorpiercing" );

    if ( var_0 == "specialty_heartbreaker" )
        _unsetperk( "specialty_empimmune" );

    if ( var_0 == "specialty_rollover" )
    {
        _unsetperk( "specialty_assists" );
        return;
    }
}

_clearperks()
{
    foreach ( var_2, var_1 in self._ID23452 )
    {
        if ( isdefined( level._ID23459[var_2] ) )
            self [[ level._ID23459[var_2] ]]();
    }

    self._ID23452 = [];
    self.perksperkname = [];
    self._ID23456 = [];
    self clearperks();
}

_ID25249( var_0 )
{
    return _ID25250( var_0, 0, var_0.size - 1 );
}

_ID25250( var_0, var_1, var_2 )
{
    var_3 = var_1;
    var_4 = var_2;

    if ( var_2 - var_1 >= 1 )
    {
        var_5 = var_0[var_1];

        while ( var_4 > var_3 )
        {
            while ( var_0[var_3] <= var_5 && var_3 <= var_2 && var_4 > var_3 )
                var_3++;

            while ( var_0[var_4] > var_5 && var_4 >= var_1 && var_4 >= var_3 )
                var_4--;

            if ( var_4 > var_3 )
                var_0 = _ID32141( var_0, var_3, var_4 );
        }

        var_0 = _ID32141( var_0, var_1, var_4 );
        var_0 = _ID25250( var_0, var_1, var_4 - 1 );
        var_0 = _ID25250( var_0, var_4 + 1, var_2 );
    }
    else
        return var_0;

    return var_0;
}

_ID32141( var_0, var_1, var_2 )
{
    var_3 = var_0[var_1];
    var_0[var_1] = var_0[var_2];
    var_0[var_2] = var_3;
    return var_0;
}

_suicide()
{
    if ( _ID18837() && !isdefined( self.fauxdead ) )
    {
        thread maps\mp\gametypes\_damage::playerkilled_internal( self, self, self, 10000, "MOD_SUICIDE", "frag_grenade_mp", ( 0, 0, 0 ), "none", 0, 1116, 1 );
        return;
    }

    if ( !_ID18837() && !isdefined( self.fauxdead ) )
    {
        self suicide();
        return;
    }

    return;
}

_ID18757( var_0 )
{
    if ( isalive( var_0 ) && !isdefined( var_0.fauxdead ) )
        return 1;

    return 0;
}

_ID35639( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = spawnstruct();

    if ( isdefined( var_1 ) )
        thread common_scripts\utility::_ID35743( var_1, var_6 );

    if ( isdefined( var_2 ) )
        thread common_scripts\utility::_ID35743( var_2, var_6 );

    if ( isdefined( var_3 ) )
        thread common_scripts\utility::_ID35743( var_3, var_6 );

    if ( isdefined( var_4 ) )
        thread common_scripts\utility::_ID35743( var_4, var_6 );

    if ( isdefined( var_5 ) )
        thread common_scripts\utility::_ID35743( var_5, var_6 );

    var_6 thread _timeout_pause_on_death_and_prematch( var_0, self );
    var_6 waittill( "returned",  var_7  );
    var_6 notify( "die" );
    return var_7;
}

_timeout_pause_on_death_and_prematch( var_0, var_1 )
{
    self endon( "die" );

    for ( var_2 = 0.05; var_0 > 0; var_0 -= var_2 )
    {
        if ( isplayer( var_1 ) && !_ID18757( var_1 ) )
            var_1 waittill( "spawned_player" );

        if ( getomnvar( "ui_prematch_period" ) )
            level waittill( "prematch_over" );

        wait(var_2);
    }

    self notify( "returned",  "timeout"  );
}

_ID23899()
{
    var_0 = randomintrange( 1, 8 );
    var_1 = "generic";

    if ( self hasfemalecustomizationmodel() )
        var_1 = "female";

    if ( self.team == "axis" )
    {
        self playsound( var_1 + "_death_russian_" + var_0 );
        return;
    }

    self playsound( var_1 + "_death_american_" + var_0 );
    return;
}

_ID25420()
{
    if ( !isplayer( self ) )
        return 0;

    return level._ID25418 && !self._ID34803;
}

_ID25017()
{
    return level._ID22861 && getdvarint( "xblive_privatematch" );
}

_ID20673()
{
    return level._ID22861 && !getdvarint( "xblive_privatematch" );
}

_ID28636( var_0, var_1, var_2, var_3 )
{

}

_ID11758( var_0 )
{
    self endon( "altscene" );
    var_0 waittill( "death" );
    self notify( "end_altScene" );
}

_ID15035()
{
    return getwatcheddvar( "numlives" );
}

givecombathigh( var_0 )
{
    self.combathigh = var_0;
}

arrayinsertion( var_0, var_1, var_2 )
{
    if ( var_0.size != 0 )
    {
        for ( var_3 = var_0.size; var_3 >= var_2; var_3-- )
            var_0[var_3 + 1] = var_0[var_3];
    }

    var_0[var_2] = var_1;
}

_ID15274( var_0, var_1 )
{
    var_2 = var_1;
    var_2 = getdvar( var_0, var_1 );
    return var_2;
}

_ID15069( var_0, var_1 )
{
    var_2 = var_1;
    var_2 = getdvarint( var_0, var_1 );
    return var_2;
}

_ID15023( var_0, var_1 )
{
    var_2 = var_1;
    var_2 = getdvarfloat( var_0, var_1 );
    return var_2;
}

_ID18585()
{
    return isdefined( self.changingweapon );
}

_ID19242( var_0 )
{
    if ( var_0 == "venomxgun_mp" || var_0 == "venomxproj_mp" )
        return 1;

    if ( _hasperk( "specialty_explosivebullets" ) )
        return 0;

    if ( isdefined( self._ID18670 ) && self._ID18670 == 1 )
        return 0;

    var_1 = self.pers["killstreaks"];

    if ( isdefined( level._ID19276[var_0] ) && isdefined( self._ID31894 ) && self._ID31894 != "support" )
    {
        for ( var_2 = 1; var_2 < 4; var_2++ )
        {
            if ( isdefined( var_1[var_2] ) && isdefined( var_1[var_2]._ID31889 ) && var_1[var_2]._ID31889 == level._ID19276[var_0] && isdefined( var_1[var_2]._ID19938 ) && var_1[var_2]._ID19938 == self.pers["deaths"] )
                return _ID31893( level._ID19276[var_0] );
        }

        return 0;
    }

    return !_ID18679( var_0 );
}

_ID31893( var_0 )
{
    var_1 = maps\mp\killstreaks\_killstreaks::_ID15382( var_0 );
    var_2 = maps\mp\killstreaks\_killstreaks::_ID15175();
    var_3 = maps\mp\killstreaks\_killstreaks::_ID15382( var_2 );
    return var_1 < var_3;
}

_ID18666()
{
    if ( isdefined( self._ID18666 ) && self._ID18666 == 1 )
        return 1;

    if ( isdefined( self._ID18667 ) && self._ID18667 == 1 )
        return 1;

    if ( isdefined( self._ID18668 ) && self._ID18668 == 1 )
        return 1;

    if ( isdefined( self._ID18670 ) && self._ID18670 == 1 )
        return 1;

    if ( isdefined( self._ID18669 ) && self._ID18669 == 1 )
        return 1;

    if ( isdefined( self.isjuggernautlevelcustom ) && self.isjuggernautlevelcustom == 1 )
        return 1;

    return 0;
}

_ID18679( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( var_0 == "none" )
        return 0;

    if ( isdestructibleweapon( var_0 ) )
        return 0;

    if ( _ID18568( var_0 ) )
        return 0;

    if ( issubstr( var_0, "killstreak" ) )
        return 1;

    if ( issubstr( var_0, "cobra" ) )
        return 1;

    if ( issubstr( var_0, "remote_tank_projectile" ) )
        return 1;

    if ( issubstr( var_0, "artillery_mp" ) )
        return 1;

    if ( issubstr( var_0, "harrier" ) )
        return 1;

    var_1 = strtok( var_0, "_" );
    var_2 = 0;

    foreach ( var_4 in var_1 )
    {
        if ( var_4 == "mp" )
        {
            var_2 = 1;
            break;
        }
    }

    if ( !var_2 )
        var_0 += "_mp";

    if ( isdefined( level._ID19276[var_0] ) )
        return 1;

    if ( maps\mp\killstreaks\_killstreaks::isairdropmarker( var_0 ) )
        return 1;

    var_6 = weaponinventorytype( var_0 );

    if ( isdefined( var_6 ) && var_6 == "exclusive" )
        return 1;

    return 0;
}

isdestructibleweapon( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    switch ( var_0 )
    {
        case "destructible_toy":
        case "destructible_car":
        case "destructible":
        case "barrel_mp":
            return 1;
    }

    return 0;
}

_ID18568( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    switch ( var_0 )
    {
        case "briefcase_bomb_mp":
        case "bomb_site_mp":
            return 1;
    }

    return 0;
}

_ID18615( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( var_0 == "turret_minigun_mp" )
        return 1;

    if ( issubstr( var_0, "_bipod_" ) )
        return 1;

    return 0;
}

_ID18671( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    switch ( var_0 )
    {
        case "mortar_shelljugg_mp":
        case "throwingknifejugg_mp":
        case "smoke_grenadejugg_mp":
        case "iw6_minigunjugg_mp":
        case "iw6_magnumjugg_mp":
        case "iw6_p226jugg_mp":
        case "iw6_knifeonlyjugg_mp":
        case "iw6_riotshieldjugg_mp":
        case "iw6_axe_mp":
        case "iw6_predatorcannon_mp":
        case "iw6_mariachimagnum_mp_akimbo":
            return 1;
    }

    return 0;
}

getweaponclass( var_0 )
{
    var_1 = _ID14903( var_0 );

    if ( _ID18363() )
        var_2 = tablelookup( "mp/alien/mode_string_tables/alien_statstable.csv", 4, var_1, 2 );
    else
        var_2 = tablelookup( "mp/statstable.csv", 4, var_1, 2 );

    if ( var_2 == "" )
    {
        var_3 = _ID31978( var_0, "_mp" );

        if ( _ID18363() )
            var_2 = tablelookup( "mp/alien/mode_string_tables/alien_statstable.csv", 4, var_3, 2 );
        else
            var_2 = tablelookup( "mp/statstable.csv", 4, var_3, 2 );
    }

    if ( _ID18615( var_0 ) )
        var_2 = "weapon_mg";
    else if ( !_ID18363() && _ID18679( var_0 ) )
        var_2 = "killstreak";
    else if ( var_0 == "none" )
        var_2 = "other";
    else if ( var_2 == "" )
        var_2 = "other";

    return var_2;
}

_ID15471( var_0 )
{
    var_0 = _ID14903( var_0 );

    if ( !isdefined( level.weaponattachments[var_0] ) )
    {
        var_1 = [];

        for ( var_2 = 0; var_2 <= 19; var_2++ )
        {
            var_3 = tablelookup( "mp/statsTable.csv", 4, var_0, 10 + var_2 );

            if ( var_3 == "" )
                break;

            var_1[var_1.size] = var_3;
        }

        level.weaponattachments[var_0] = var_1;
    }

    return level.weaponattachments[var_0];
}

getweaponattachmentfromstats( var_0, var_1 )
{
    var_0 = _ID14903( var_0 );
    return tablelookup( "mp/statsTable.csv", 4, var_0, 10 + var_1 );
}

attachmentscompatible( var_0, var_1 )
{
    var_0 = attachmentmap_tobase( var_0 );
    var_1 = attachmentmap_tobase( var_1 );
    var_2 = 1;

    if ( var_0 == var_1 )
        var_2 = 0;
    else if ( var_0 != "none" && var_1 != "none" )
    {
        var_3 = tablelookuprownum( "mp/attachmentcombos.csv", 0, var_1 );

        if ( tablelookup( "mp/attachmentcombos.csv", 0, var_0, var_3 ) == "no" )
            var_2 = 0;
    }

    return var_2;
}

_ID14903( var_0 )
{
    var_1 = strtok( var_0, "_" );

    if ( var_1[0] == "iw5" || var_1[0] == "iw6" )
        var_0 = var_1[0] + "_" + var_1[1];
    else if ( var_1[0] == "alt" )
        var_0 = var_1[1] + "_" + var_1[2];

    return var_0;
}

getbaseperkname( var_0 )
{
    if ( isendstr( var_0, "_ks" ) )
        var_0 = getsubstr( var_0, 0, var_0.size - 3 );

    return var_0;
}

getvalidextraammoweapons()
{
    var_0 = [];
    var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        var_4 = weaponclass( var_3 );

        if ( !_ID18679( var_3 ) && var_4 != "grenade" && var_4 != "rocketlauncher" )
            var_0[var_0.size] = var_3;
    }

    return var_0;
}

_ID26325()
{
    var_0 = 0;
    var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        if ( maps\mp\gametypes\_weapons::_ID18766( var_3 ) )
        {
            var_0 = 1;
            break;
        }
    }

    return var_0;
}

_ID26324()
{
    var_0 = 0;
    var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        if ( maps\mp\gametypes\_weapons::_ID18766( var_3 ) )
            var_0++;

        if ( var_0 == 2 )
            break;
    }

    return var_0 == 2;
}

riotshield_attach( var_0, var_1 )
{
    var_2 = undefined;

    if ( var_0 )
    {
        self._ID26332 = var_1;
        var_2 = "tag_weapon_right";
    }
    else
    {
        self._ID26333 = var_1;
        var_2 = "tag_shield_back";
    }

    self attachshieldmodel( var_1, var_2 );
    self.hasriotshield = _ID26325();
}

riotshield_detach( var_0 )
{
    var_1 = undefined;
    var_2 = undefined;

    if ( var_0 )
    {
        var_1 = self._ID26332;
        var_2 = "tag_weapon_right";
    }
    else
    {
        var_1 = self._ID26333;
        var_2 = "tag_shield_back";
    }

    self detachshieldmodel( var_1, var_2 );

    if ( var_0 )
        self._ID26332 = undefined;
    else
        self._ID26333 = undefined;

    self.hasriotshield = _ID26325();
}

_ID26327( var_0 )
{
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;

    if ( var_0 )
    {
        var_3 = self._ID26332;
        var_1 = "tag_weapon_right";
        var_2 = "tag_shield_back";
    }
    else
    {
        var_3 = self._ID26333;
        var_1 = "tag_shield_back";
        var_2 = "tag_weapon_right";
    }

    self moveshieldmodel( var_3, var_1, var_2 );

    if ( var_0 )
    {
        self._ID26333 = var_3;
        self._ID26332 = undefined;
        return;
    }

    self._ID26332 = var_3;
    self._ID26333 = undefined;
    return;
}

_ID26321()
{
    self._ID16417 = 0;
    self.hasriotshield = 0;
    self._ID26333 = undefined;
    self._ID26332 = undefined;
}

riotshield_getmodel()
{
    return common_scripts\utility::_ID32831( _ID18666(), "weapon_riot_shield_jug_iw6", "weapon_riot_shield_iw6" );
}

_ID23107( var_0, var_1, var_2, var_3 )
{
    var_4 = level.players;
    var_5 = maps\mp\gametypes\_outline::_ID23103( var_1 );
    var_6 = maps\mp\gametypes\_outline::_ID23119( var_3 );
    return maps\mp\gametypes\_outline::_ID23110( var_0, var_5, var_4, var_2, var_6, "ALL" );
}

_ID23109( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = getteamarray( var_2, 0 );
    var_6 = maps\mp\gametypes\_outline::_ID23103( var_1 );
    var_7 = maps\mp\gametypes\_outline::_ID23119( var_4 );
    return maps\mp\gametypes\_outline::_ID23110( var_0, var_6, var_5, var_3, var_7, "TEAM", var_2 );
}

_ID23108( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = maps\mp\gametypes\_outline::_ID23103( var_1 );
    var_6 = maps\mp\gametypes\_outline::_ID23119( var_4 );

    if ( isagent( var_2 ) )
        return maps\mp\gametypes\_outline::_ID23112();

    return maps\mp\gametypes\_outline::_ID23110( var_0, var_5, [ var_2 ], var_3, var_6, "ENTITY" );
}

_ID23104( var_0, var_1 )
{
    maps\mp\gametypes\_outline::_ID23105( var_0, var_1 );
}

_ID24644( var_0, var_1 )
{
    playsoundatpos( var_1, var_0 );
}

_ID19987( var_0, var_1 )
{
    var_2 = 1;

    for ( var_3 = 0; var_3 < var_1; var_3++ )
        var_2 *= 10;

    var_4 = var_0 * var_2;
    var_4 = int( var_4 );
    var_4 /= var_2;
    return var_4;
}

_ID26771( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = "nearest";

    var_3 = 1;

    for ( var_4 = 0; var_4 < var_1; var_4++ )
        var_3 *= 10;

    var_5 = var_0 * var_3;

    if ( var_2 == "up" )
        var_6 = ceil( var_5 );
    else if ( var_2 == "down" )
        var_6 = floor( var_5 );
    else
        var_6 = var_5 + 0.5;

    var_5 = int( var_6 );
    var_5 /= var_3;
    return var_5;
}

_ID24491( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( var_2.clientid == var_0 )
            return var_2;
    }

    return undefined;
}

_ID18763()
{
    if ( !_ID25420() )
        return 0;

    return self getrankedplayerdata( "restXPGoal" ) > self getrankedplayerdata( "experience" );
}

_ID31977( var_0 )
{
    var_1 = strtok( var_0, "." );
    var_2 = int( var_1[0] );

    if ( isdefined( var_1[1] ) )
    {
        var_3 = 1;

        for ( var_4 = 0; var_4 < var_1[1].size; var_4++ )
            var_3 *= 0.1;

        var_2 += int( var_1[1] ) * var_3;
    }

    return var_2;
}

_ID28863( var_0 )
{
    self makeusable();

    foreach ( var_2 in level.players )
    {
        if ( var_2 != var_0 )
        {
            self disableplayeruse( var_2 );
            continue;
        }

        self enableplayeruse( var_2 );
    }
}

_ID20513( var_0 )
{
    self makeusable();
    thread _updateteamusable( var_0 );
}

_updateteamusable( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        foreach ( var_2 in level.players )
        {
            if ( var_2.team == var_0 )
            {
                self enableplayeruse( var_2 );
                continue;
            }

            self disableplayeruse( var_2 );
        }

        level waittill( "joined_team" );
    }
}

_ID20499( var_0 )
{
    self makeusable();
    thread _updateenemyusable( var_0 );
}

_updateenemyusable( var_0 )
{
    self endon( "death" );
    var_1 = var_0.team;

    for (;;)
    {
        if ( level._ID32653 )
        {
            foreach ( var_3 in level.players )
            {
                if ( var_3.team != var_1 )
                {
                    self enableplayeruse( var_3 );
                    continue;
                }

                self disableplayeruse( var_3 );
            }
        }
        else
        {
            foreach ( var_3 in level.players )
            {
                if ( var_3 != var_0 )
                {
                    self enableplayeruse( var_3 );
                    continue;
                }

                self disableplayeruse( var_3 );
            }
        }

        level waittill( "joined_team" );
    }
}

initgameflags()
{
    if ( !isdefined( game["flags"] ) )
    {
        game["flags"] = [];
        return;
    }
}

_ID14067( var_0, var_1 )
{
    game["flags"][var_0] = var_1;
}

_ID14065( var_0 )
{
    return game["flags"][var_0];
}

_ID14068( var_0 )
{
    game["flags"][var_0] = 1;
    level notify( var_0 );
}

_ID14066( var_0 )
{
    game["flags"][var_0] = 0;
}

gameflagwait( var_0 )
{
    while ( !_ID14065( var_0 ) )
        level waittill( var_0 );
}

_ID18749( var_0 )
{
    if ( var_0 == "MOD_RIFLE_BULLET" || var_0 == "MOD_PISTOL_BULLET" )
        return 1;

    return 0;
}

_ID18573( var_0 )
{
    var_1 = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";

    if ( issubstr( var_1, var_0 ) )
        return 1;

    return 0;
}

isfmjdamage( var_0, var_1, var_2 )
{
    return isdefined( var_2 ) && var_2 _hasperk( "specialty_bulletpenetration" ) && isdefined( var_1 ) && _ID18573( var_1 );
}

initlevelflags()
{
    if ( !isdefined( level._ID19894 ) )
    {
        level._ID19894 = [];
        return;
    }
}

_ID19893( var_0, var_1 )
{
    level._ID19894[var_0] = var_1;
}

levelflag( var_0 )
{
    return level._ID19894[var_0];
}

levelflagset( var_0 )
{
    level._ID19894[var_0] = 1;
    level notify( var_0 );
}

_ID19892( var_0 )
{
    level._ID19894[var_0] = 0;
    level notify( var_0 );
}

_ID19896( var_0 )
{
    while ( !levelflag( var_0 ) )
        level waittill( var_0 );
}

levelflagwaitopen( var_0 )
{
    while ( levelflag( var_0 ) )
        level waittill( var_0 );
}

initglobals()
{
    if ( !isdefined( level.global_tables ) )
    {
        level.global_tables["killstreakTable"] = spawnstruct();
        level.global_tables["killstreakTable"]._ID23323 = "mp/killstreakTable.csv";
        level.global_tables["killstreakTable"].index_col = 0;
        level.global_tables["killstreakTable"]._ID25634 = 1;
        level.global_tables["killstreakTable"]._ID21871 = 2;
        level.global_tables["killstreakTable"]._ID9737 = 3;
        level.global_tables["killstreakTable"]._ID19238 = 4;
        level.global_tables["killstreakTable"].earned_hint_col = 5;
        level.global_tables["killstreakTable"]._ID30466 = 6;
        level.global_tables["killstreakTable"].earned_dialog_col = 7;
        level.global_tables["killstreakTable"].allies_dialog_col = 8;
        level.global_tables["killstreakTable"].enemy_dialog_col = 9;
        level.global_tables["killstreakTable"]._ID12038 = 10;
        level.global_tables["killstreakTable"]._ID36242 = 11;
        level.global_tables["killstreakTable"]._ID27353 = 12;
        level.global_tables["killstreakTable"]._ID17323 = 13;
        level.global_tables["killstreakTable"]._ID23146 = 14;
        level.global_tables["killstreakTable"].dpad_icon_col = 15;
        level.global_tables["killstreakTable"]._ID34204 = 16;
        level.global_tables["killstreakTable"].all_team_steak_col = 17;
        return;
    }
}

_ID18678()
{
    return _ID18610() || isairdenied();
}

_ID18610()
{
    if ( self.team == "spectator" )
        return 0;

    if ( level._ID32653 )
    {
        return level._ID32657[self.team] || isdefined( self.empgrenaded ) && self.empgrenaded || level._ID32669[self.team];
        return;
    }

    return isdefined( level._ID11399 ) && level._ID11399 != self || isdefined( self.empgrenaded ) && self.empgrenaded || isdefined( level._ID22371.player ) && self != level._ID22371.player && level._ID32669[self.team];
    return;
}

isairdenied()
{
    if ( self.team == "spectator" )
        return 0;

    if ( level._ID32653 )
    {
        return level._ID32650[self.team];
        return;
    }

    return isdefined( level.airdeniedplayer ) && level.airdeniedplayer != self;
    return;
}

_ID18715()
{
    if ( self.team == "spectator" )
        return 0;

    return isdefined( self._ID22359 );
}

_ID15254( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( var_2._ID15851 == var_0 )
            return var_2;
    }

    return undefined;
}

_ID32672( var_0, var_1, var_2, var_3 )
{
    if ( level.hardcoremode && !_ID18363() )
        return;

    foreach ( var_5 in level.players )
    {
        if ( isdefined( var_2 ) && var_5.team != var_2 )
            continue;

        if ( !isplayer( var_5 ) )
            continue;

        var_5 thread maps\mp\gametypes\_hud_message::_ID24474( var_0, var_1, var_3 );
    }
}

iscacprimaryweapon( var_0 )
{
    switch ( getweaponclass( var_0 ) )
    {
        case "weapon_smg":
        case "weapon_assault":
        case "weapon_riot":
        case "weapon_sniper":
        case "weapon_dmr":
        case "weapon_lmg":
        case "weapon_shotgun":
            return 1;
        default:
            return 0;
    }
}

_ID18576( var_0 )
{
    switch ( getweaponclass( var_0 ) )
    {
        case "weapon_projectile":
        case "weapon_pistol":
        case "weapon_machine_pistol":
            return 1;
        default:
            return 0;
    }
}

_ID15113( var_0 )
{
    var_1 = undefined;

    foreach ( var_3 in level.players )
    {
        if ( isdefined( var_0 ) && var_3.team != var_0 )
            continue;

        if ( !_ID18757( var_3 ) && !var_3 maps\mp\gametypes\_playerlogic::_ID20776() )
            continue;

        if ( isdefined( var_3._ID32285 ) && var_3._ID32285 )
            continue;

        var_1 = var_3;
    }

    return var_1;
}

_ID15264()
{
    var_0 = [];

    foreach ( var_2 in level.players )
    {
        if ( !_ID18757( var_2 ) && !var_2 maps\mp\gametypes\_playerlogic::_ID20776() )
            continue;

        var_0[var_0.size] = var_2;
    }

    return var_0;
}

_ID35774( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_2 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 0.05;

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    for (;;)
    {
        if ( self.health != self.maxhealth )
            var_2 = 0;
        else
            var_2 += var_1;

        wait(var_1);

        if ( self.health == self.maxhealth && var_2 >= var_0 )
            break;
    }

    return;
}

enableweaponlaser()
{
    if ( !isdefined( self._ID36265 ) )
        self._ID36265 = 0;

    self._ID36265++;
    self laseron();
}

_ID10177()
{
    self._ID36265--;

    if ( self._ID36265 == 0 )
    {
        self laseroff();
        self._ID36265 = undefined;
        return;
    }
}

attachmentmap_tounique( var_0, var_1 )
{
    var_2 = var_0;
    var_1 = _ID14903( var_1 );

    if ( isdefined( level.attachmentmap_basetounique[var_1] ) && isdefined( level.attachmentmap_basetounique[var_1][var_0] ) )
        var_2 = level.attachmentmap_basetounique[var_1][var_0];
    else
    {
        if ( _ID18363() )
            var_3 = tablelookup( "mp/alien/mode_string_tables/alien_statstable.csv", 4, var_1, 2 );
        else
            var_3 = tablelookup( "mp/statstable.csv", 4, var_1, 2 );

        if ( isdefined( level.attachmentmap_basetounique[var_3] ) && isdefined( level.attachmentmap_basetounique[var_3][var_0] ) )
            var_2 = level.attachmentmap_basetounique[var_3][var_0];
    }

    return var_2;
}

_ID4048( var_0 )
{
    var_1 = undefined;

    if ( isdefined( level.attachmentmap_attachtoperk[var_0] ) )
        var_1 = level.attachmentmap_attachtoperk[var_0];

    return var_1;
}

weaponperkmap( var_0 )
{
    var_1 = undefined;

    if ( isdefined( level.weaponmap_toperk[var_0] ) )
        var_1 = level.weaponmap_toperk[var_0];

    return var_1;
}

_ID18558( var_0, var_1 )
{
    var_2 = strtok( var_0, "_" );
    return isattachmentsniperscopedefaulttokenized( var_2, var_1 );
}

isattachmentsniperscopedefaulttokenized( var_0, var_1 )
{
    var_2 = 0;

    if ( var_0.size && isdefined( var_1 ) )
    {
        var_3 = 0;

        if ( var_0[0] == "alt" )
            var_3 = 1;

        if ( var_0.size >= 3 + var_3 && ( var_0[var_3] == "iw5" || var_0[var_3] == "iw6" ) )
        {
            if ( weaponclass( var_0[var_3] + "_" + var_0[var_3 + 1] + "_" + var_0[var_3 + 2] ) == "sniper" )
                var_2 = var_0[var_3 + 1] + "scope" == var_1;
        }
    }

    return var_2;
}

getnumdefaultattachments( var_0 )
{
    if ( weaponclass( var_0 ) == "sniper" )
    {
        var_1 = getweaponattachments( var_0 );

        foreach ( var_3 in var_1 )
        {
            if ( _ID18558( var_0, var_3 ) )
                return 1;
        }
    }
    else if ( _ID18801( var_0, "iw6_dlcweap02" ) )
    {
        var_1 = getweaponattachments( var_0 );

        foreach ( var_3 in var_1 )
        {
            if ( var_3 == "dlcweap02scope" )
                return 1;
        }
    }

    return 0;
}

_ID15474( var_0 )
{
    var_1 = getweaponattachments( var_0 );

    foreach ( var_4, var_3 in var_1 )
        var_1[var_4] = attachmentmap_tobase( var_3 );

    return var_1;
}

getattachmentlistbasenames()
{
    var_0 = [];
    var_1 = 0;

    if ( _ID18363() )
        var_2 = tablelookup( "mp/alien/alien_attachmentTable.csv", 0, var_1, 5 );
    else
        var_2 = tablelookup( "mp/attachmentTable.csv", 0, var_1, 5 );

    while ( var_2 != "" )
    {
        if ( !common_scripts\utility::array_contains( var_0, var_2 ) )
            var_0[var_0.size] = var_2;

        var_1++;

        if ( _ID18363() )
        {
            var_2 = tablelookup( "mp/alien/alien_attachmentTable.csv", 0, var_1, 5 );
            continue;
        }

        var_2 = tablelookup( "mp/attachmentTable.csv", 0, var_1, 5 );
    }

    return var_0;
}

getattachmentlistuniqenames()
{
    var_0 = [];
    var_1 = 0;

    if ( _ID18363() )
        var_2 = tablelookup( "mp/alien/alien_attachmentTable.csv", 0, var_1, 4 );
    else
        var_2 = tablelookup( "mp/attachmentTable.csv", 0, var_1, 4 );

    while ( var_2 != "" )
    {
        var_0[var_0.size] = var_2;
        var_1++;

        if ( _ID18363() )
        {
            var_2 = tablelookup( "mp/alien/alien_attachmentTable.csv", 0, var_1, 4 );
            continue;
        }

        var_2 = tablelookup( "mp/attachmentTable.csv", 0, var_1, 4 );
    }

    return var_0;
}

_ID6229()
{
    var_0 = getattachmentlistuniqenames();
    level.attachmentmap_uniquetobase = [];

    foreach ( var_2 in var_0 )
    {
        if ( _ID18363() )
            var_3 = tablelookup( "mp/alien/alien_attachmentTable.csv", 4, var_2, 5 );
        else
            var_3 = tablelookup( "mp/attachmenttable.csv", 4, var_2, 5 );

        if ( var_2 == var_3 )
            continue;

        level.attachmentmap_uniquetobase[var_2] = var_3;
    }

    var_5 = [];
    var_6 = 1;

    if ( _ID18363() )
        var_7 = tablelookupbyrow( "mp/alien/alien_attachmentmap.csv", var_6, 0 );
    else
        var_7 = tablelookupbyrow( "mp/attachmentmap.csv", var_6, 0 );

    while ( var_7 != "" )
    {
        var_5[var_5.size] = var_7;
        var_6++;

        if ( _ID18363() )
        {
            var_7 = tablelookupbyrow( "mp/alien/alien_attachmentmap.csv", var_6, 0 );
            continue;
        }

        var_7 = tablelookupbyrow( "mp/attachmentmap.csv", var_6, 0 );
    }

    var_8 = [];
    var_9 = 1;

    if ( _ID18363() )
        var_10 = tablelookupbyrow( "mp/alien/alien_attachmentmap.csv", 0, var_9 );
    else
        var_10 = tablelookupbyrow( "mp/attachmentmap.csv", 0, var_9 );

    while ( var_10 != "" )
    {
        var_8[var_10] = var_9;
        var_9++;

        if ( _ID18363() )
        {
            var_10 = tablelookupbyrow( "mp/alien/alien_attachmentmap.csv", 0, var_9 );
            continue;
        }

        var_10 = tablelookupbyrow( "mp/attachmentmap.csv", 0, var_9 );
    }

    level.attachmentmap_basetounique = [];

    foreach ( var_7 in var_5 )
    {
        foreach ( var_15, var_13 in var_8 )
        {
            if ( _ID18363() )
                var_14 = tablelookup( "mp/alien/alien_attachmentmap.csv", 0, var_7, var_13 );
            else
                var_14 = tablelookup( "mp/attachmentmap.csv", 0, var_7, var_13 );

            if ( var_14 == "" )
                continue;

            if ( !isdefined( level.attachmentmap_basetounique[var_7] ) )
                level.attachmentmap_basetounique[var_7] = [];

            level.attachmentmap_basetounique[var_7][var_15] = var_14;
        }
    }

    level.attachmentmap_attachtoperk = [];

    foreach ( var_18 in var_0 )
    {
        if ( _ID18363() )
            var_19 = tablelookup( "mp/alien/alien_attachmenttable.csv", 4, var_18, 12 );
        else
            var_19 = tablelookup( "mp/attachmenttable.csv", 4, var_18, 12 );

        if ( var_19 == "" )
            continue;

        level.attachmentmap_attachtoperk[var_18] = var_19;
    }
}

buildweaponperkmap()
{
    level.weaponmap_toperk = [];

    if ( _ID18363() )
        return;

    for ( var_0 = 0; tablelookup( "mp/statstable.csv", 0, var_0, 0 ) != ""; var_0++ )
    {
        var_1 = tablelookup( "mp/statstable.csv", 0, var_0, 5 );

        if ( var_1 != "" )
        {
            var_2 = tablelookup( "mp/statstable.csv", 0, var_0, 4 );

            if ( var_2 != "" )
                level.weaponmap_toperk[var_2] = var_1;
        }
    }
}

attachmentmap_tobase( var_0 )
{
    if ( isdefined( level.attachmentmap_uniquetobase[var_0] ) )
        var_0 = level.attachmentmap_uniquetobase[var_0];

    return var_0;
}

_ID36268( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        switch ( var_0 )
        {
            case "semtexproj_mp":
                var_0 = "iw6_mk32_mp";
                break;
            case "iw6_maawschild_mp":
            case "iw6_maawshoming_mp":
                var_0 = "iw6_maaws_mp";
                break;
            case "iw6_knifeonlyfast_mp":
                var_0 = "iw6_knifeonly_mp";
                break;
            case "iw6_pdwauto_mp":
                var_0 = "iw6_pdw_mp";
            default:
                break;
        }
    }

    return var_0;
}

weaponhasintegratedsilencer( var_0 )
{
    return var_0 == "iw6_vks" || var_0 == "iw6_k7" || var_0 == "iw6_honeybadger";
}

weaponisfiretypeburst( var_0 )
{
    if ( weaponhasintegratedfiretypeburst( var_0 ) )
    {
        return 1;
        return;
    }

    return weaponhasattachment( var_0, "firetypeburst" );
    return;
}

weaponhasintegratedfiretypeburst( var_0 )
{
    var_1 = _ID14903( var_0 );

    if ( var_1 == "iw6_pdw" )
    {
        return 1;
        return;
    }

    if ( var_1 == "iw6_msbs" )
    {
        var_2 = _ID15474( var_0 );

        foreach ( var_4 in var_2 )
        {
            if ( var_4 == "firetypeauto" || var_4 == "firetypesingle" )
                return 0;
        }

        return 1;
        return;
    }

    return 0;
    return;
    return;
}

weaponhasintegratedgrip( var_0 )
{
    return var_0 == "iw6_g28";
}

weaponhasintegratedfmj( var_0 )
{
    return var_0 == "iw6_cbjms";
}

weaponhasintegratedtrackerscope( var_0 )
{
    var_1 = _ID14903( var_0 );

    if ( var_1 == "iw6_dlcweap03" )
    {
        var_2 = getweaponattachments( var_0 );

        foreach ( var_4 in var_2 )
        {
            if ( _ID18801( var_4, "dlcweap03" ) )
                return 1;
        }
    }

    return 0;
}

weaponhasattachment( var_0, var_1 )
{
    var_2 = _ID15474( var_0 );

    foreach ( var_4 in var_2 )
    {
        if ( var_4 == var_1 )
            return 1;
    }

    return 0;
}

weapongetnumattachments( var_0 )
{
    var_1 = getnumdefaultattachments( var_0 );
    var_2 = getweaponattachments( var_0 );
    return var_2.size - var_1;
}

isplayerads()
{
    return self playerads() > 0.5;
}

_objective_delete( var_0 )
{
    objective_delete( var_0 );

    if ( !isdefined( level._ID25604 ) )
    {
        level._ID25604 = [];
        level._ID25604[0] = var_0;
        return;
    }

    level._ID25604[level._ID25604.size] = var_0;
    return;
}

_ID33165( var_0 )
{
    var_1 = getentarray( "trigger_hurt", "classname" );

    foreach ( var_3 in var_1 )
    {
        if ( self istouching( var_3 ) && ( level.mapname != "mp_mine" || var_3.dmg > 0 ) )
            return 1;
    }

    var_5 = getentarray( "radiation", "targetname" );

    foreach ( var_3 in var_5 )
    {
        if ( self istouching( var_3 ) )
            return 1;
    }

    if ( isdefined( var_0 ) && var_0 == "gryphon" )
    {
        var_8 = getentarray( "gryphonDeath", "targetname" );

        foreach ( var_3 in var_8 )
        {
            if ( self istouching( var_3 ) )
                return 1;
        }
    }

    return 0;
}

_ID28902( var_0 )
{
    if ( var_0 )
    {
        self setdepthoffield( 0, 110, 512, 4096, 6, 1.8 );
        return;
    }

    self setdepthoffield( 0, 0, 512, 512, 4, 0 );
    return;
}

_ID19279( var_0, var_1, var_2 )
{
    var_3 = spawn( "trigger_radius", var_0, 0, var_1, var_2 );

    for (;;)
    {
        var_3 waittill( "trigger",  var_4  );

        if ( !isplayer( var_4 ) )
            continue;

        var_4 suicide();
    }
}

_ID12935( var_0, var_1, var_2 )
{
    var_3 = cos( var_2 );
    var_4 = anglestoforward( var_0.angles );
    var_5 = var_1.origin - var_0.origin;
    var_4 *= ( 1, 1, 0 );
    var_5 *= ( 1, 1, 0 );
    var_5 = vectornormalize( var_5 );
    var_4 = vectornormalize( var_4 );
    var_6 = vectordot( var_5, var_4 );

    if ( var_6 >= var_3 )
    {
        return 1;
        return;
    }

    return 0;
    return;
}

_ID10878( var_0, var_1, var_2, var_3 )
{
    var_4 = int( var_2 * 20 );

    for ( var_5 = 0; var_5 < var_4; var_5++ )
        wait 0.05;
}

drawsphere( var_0, var_1, var_2, var_3 )
{
    var_4 = int( var_2 * 20 );

    for ( var_5 = 0; var_5 < var_4; var_5++ )
        wait 0.05;
}

_ID28849( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !isdefined( self._ID25605 ) )
        self._ID25605 = var_0;
    else
        self._ID25605 = self._ID25605 + var_0;

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( self._ID25605 ) && var_1 < self._ID25605 )
            var_1 = self._ID25605;

        var_2 = 100 - var_1;
    }
    else
        var_2 = 100 - self._ID25605;

    if ( var_2 < 0 )
        var_2 = 0;

    if ( var_2 > 100 )
        var_2 = 100;

    if ( var_2 == 100 )
    {
        self player_recoilscaleoff();
        return;
    }

    self player_recoilscaleon( var_2 );
}

_ID7359( var_0 )
{
    var_1 = [];

    foreach ( var_4, var_3 in var_0 )
    {
        if ( !isdefined( var_3 ) )
            continue;

        var_1[var_1.size] = var_0[var_4];
    }

    return var_1;
}

_ID22330( var_0 )
{
    self notify( "notusablejoiningplayers" );
    self endon( "death" );
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 endon( "death" );
    self endon( "notusablejoiningplayers" );

    for (;;)
    {
        level waittill( "player_spawned",  var_1  );

        if ( isdefined( var_1 ) && var_1 != var_0 )
            self disableplayeruse( var_1 );
    }
}

_ID18801( var_0, var_1 )
{
    return getsubstr( var_0, 0, var_1.size ) == var_1;
}

disableallstreaks()
{
    level._ID19267 = 1;
}

_ID11488()
{
    level._ID19267 = undefined;
}

_ID34840( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
        var_2 = var_0;
    else
    {
        var_3 = self.pers["killstreaks"];
        var_2 = var_3[self._ID19258]._ID31889;
    }

    if ( isdefined( level._ID19267 ) && level._ID19267 )
        return 0;

    if ( !self isonground() && ( _ID18765( var_2 ) || _ID18583( var_2 ) ) )
        return 0;

    if ( _ID18837() )
        return 0;

    if ( isdefined( self._ID28032 ) )
        return 0;

    if ( shouldpreventearlyuse( var_2 ) && level._ID19263 )
    {
        if ( level._ID15760 - level._ID17628 < level._ID19263 )
        {
            if ( !( isdefined( var_1 ) && var_1 ) )
                self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE_FOR_N", level._ID19263 - ( level._ID15760 - level._ID17628 ) );

            return 0;
        }
    }

    if ( isdefined( self._ID22359 ) && self._ID22359 && _ID18610() )
    {
        if ( _ID18675( var_2 ) )
        {
            if ( !( isdefined( var_1 ) && var_1 ) )
                self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE_FOR_N_WHEN_NUKE", level._ID22369 );

            return 0;
        }
    }

    if ( _ID18610() )
    {
        if ( _ID18675( var_2 ) )
        {
            if ( !( isdefined( var_1 ) && var_1 ) )
                self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE_WHEN_JAMMED" );

            return 0;
        }
    }

    if ( isairdenied() )
    {
        if ( _ID18631( var_2 ) && var_2 != "air_superiority" )
        {
            if ( !( isdefined( var_1 ) && var_1 ) )
                self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE_WHEN_AA" );

            return 0;
        }
    }

    if ( self isusingturret() && ( _ID18765( var_2 ) || _ID18583( var_2 ) ) )
    {
        if ( !( isdefined( var_1 ) && var_1 ) )
            self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE_USING_TURRET" );

        return 0;
    }

    if ( isdefined( self.laststand ) && !_hasperk( "specialty_finalstand" ) )
    {
        if ( !isdefined( level.allowlaststandai ) || !level.allowlaststandai || var_2 != "agent" )
        {
            if ( !( isdefined( var_1 ) && var_1 ) )
                self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE_IN_LASTSTAND" );

            return 0;
        }
    }

    if ( !common_scripts\utility::_ID18870() )
        return 0;

    if ( isdefined( level.civilianjetflyby ) && _ID18631( var_2 ) )
    {
        if ( !( isdefined( var_1 ) && var_1 ) )
            self iprintlnbold( &"KILLSTREAKS_CIVILIAN_AIR_TRAFFIC" );

        return 0;
    }

    return 1;
}

_ID18765( var_0 )
{
    switch ( var_0 )
    {
        case "vanguard":
        case "heli_pilot":
        case "drone_hive":
        case "odin_support":
        case "odin_assault":
        case "ca_a10_strafe":
        case "ac130":
            return 1;
        default:
            return 0;
    }
}

_ID18583( var_0 )
{
    switch ( var_0 )
    {
        case "sentry":
        case "sentry_gl":
        case "minigun_turret":
        case "gl_turret":
        case "deployable_vest":
        case "deployable_ammo":
        case "deployable_grenades":
        case "deployable_exp_ammo":
        case "ims":
            return 1;
        default:
            return 0;
    }
}

shouldpreventearlyuse( var_0 )
{
    switch ( var_0 )
    {
        case "sentry":
        case "air_superiority":
        case "deployable_vest":
        case "deployable_ammo":
        case "ims":
        case "uplink":
        case "guard_dog":
        case "ball_drone_backup":
        case "uplink_support":
        case "aa_launcher":
        case "ball_drone_radar":
        case "recon_agent":
        case "jammer":
        case "uav_3dping":
            return 0;
        default:
            return !_ID18801( var_0, "airdrop_" );
    }
}

_ID18675( var_0 )
{
    switch ( var_0 )
    {
        case "agent":
        case "deployable_vest":
        case "deployable_ammo":
        case "guard_dog":
        case "recon_agent":
        case "dome_seekers":
        case "zerosub_level_killstreak":
            return 0;
        default:
            return 1;
    }
}

iskillstreakaffectedbyjammer( var_0 )
{
    return _ID18675( var_0 ) && !_ID18631( var_0 );
}

_ID18631( var_0 )
{
    switch ( var_0 )
    {
        case "helicopter":
        case "air_superiority":
        case "vanguard":
        case "heli_pilot":
        case "drone_hive":
        case "odin_support":
        case "odin_assault":
        case "ca_a10_strafe":
        case "ac130":
        case "airdrop_sentry_minigun":
        case "airdrop_juggernaut":
        case "airdrop_juggernaut_recon":
        case "heli_sniper":
        case "airdrop_assault":
        case "airdrop_juggernaut_maniac":
            return 1;
        default:
            return 0;
    }
}

_ID18544( var_0 )
{
    var_1 = getkillstreakallteamstreak( var_0 );

    if ( !isdefined( var_1 ) )
        return 0;

    if ( int( var_1 ) == 1 )
        return 1;

    return 0;
}

getkillstreakrownum( var_0 )
{
    return tablelookuprownum( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0 );
}

_ID15099( var_0 )
{
    var_1 = tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"].index_col );

    if ( var_1 == "" )
        var_2 = -1;
    else
        var_2 = int( var_1 );

    return var_2;
}

getkillstreakreference( var_0 )
{
    return tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"]._ID25634 );
}

getkillstreakreferencebyweapon( var_0 )
{
    return tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID36242, var_0, level.global_tables["killstreakTable"]._ID25634 );
}

_ID15101( var_0 )
{
    return tablelookupistring( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"]._ID21871 );
}

_ID15091( var_0 )
{
    return tablelookupistring( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"]._ID9737 );
}

_ID15100( var_0 )
{
    return tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"]._ID19238 );
}

getkillstreakearnedhint( var_0 )
{
    return tablelookupistring( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"].earned_hint_col );
}

_ID15106( var_0 )
{
    return tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"]._ID30466 );
}

_ID15093( var_0 )
{
    return tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"].earned_dialog_col );
}

_ID15087( var_0 )
{
    return tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"].allies_dialog_col );
}

_ID15095( var_0 )
{
    return tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"].enemy_dialog_col );
}

_ID15096( var_0 )
{
    return int( tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"]._ID12038 ) );
}

getkillstreakweapon( var_0 )
{
    return tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"]._ID36242 );
}

getkillstreakscore( var_0 )
{
    return tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"]._ID27353 );
}

getkillstreakicon( var_0 )
{
    return tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"]._ID17323 );
}

getkillstreakoverheadicon( var_0 )
{
    return tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"]._ID23146 );
}

_ID15092( var_0 )
{
    return tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"].dpad_icon_col );
}

_ID15107( var_0 )
{
    return tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"]._ID34204 );
}

getkillstreakallteamstreak( var_0 )
{
    return tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"]._ID25634, var_0, level.global_tables["killstreakTable"].all_team_streak_col );
}

_ID8679( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    var_1 = var_0;

    if ( isdefined( level._ID16755 ) )
        var_1 += level._ID16755.size;

    if ( isdefined( level._ID20086 ) )
        var_1 += level._ID20086.size;

    if ( isdefined( level._ID34171 ) )
        var_1 += level._ID34171.size;

    return var_1;
}

maxvehiclesallowed()
{
    return 8;
}

_ID17543()
{
    level._ID12791++;
}

decrementfauxvehiclecount()
{
    level._ID12791--;
    var_0 = _ID8679();

    if ( var_0 > level._ID12791 )
        level._ID12791 = var_0;

    if ( level._ID12791 < 0 )
    {
        level._ID12791 = 0;
        return;
    }
}

_ID19986()
{
    return 1.07;
}

allowteamchoice()
{
    if ( level._ID14086 == "cranked" )
        return level._ID32653;

    var_0 = int( tablelookup( "mp/gametypesTable.csv", 0, level._ID14086, 4 ) );
    return var_0;
}

allowclasschoice()
{
    var_0 = int( tablelookup( "mp/gametypesTable.csv", 0, level._ID14086, 5 ) );
    return var_0;
}

showfakeloadout()
{
    if ( level._ID14086 == "sotf" || level._ID14086 == "sotf_ffa" || level._ID14086 == "gun" || level._ID14086 == "infect" )
        return 1;

    if ( level._ID14086 == "horde" && !_ID20673() && issplitscreen() )
        return 0;

    if ( level._ID14086 == "horde" && level.currentroundnumber == 0 )
        return 1;

    return 0;
}

setfakeloadoutweaponslot( var_0, var_1 )
{
    var_2 = _ID14903( var_0 );
    var_3 = [];

    if ( var_2 != "iw6_knifeonly" && var_2 != "iw6_knifeonlyfast" )
        var_3 = getweaponattachments( var_0 );

    var_4 = "ui_fakeloadout_weapon" + var_1;

    if ( isdefined( var_2 ) )
    {
        var_5 = tablelookuprownum( "mp/statsTable.csv", 4, var_2 );
        self setclientomnvar( var_4, var_5 );
    }
    else
        self setclientomnvar( var_4, -1 );

    for ( var_6 = 0; var_6 < 3; var_6++ )
    {
        var_7 = var_4 + "_attach" + ( var_6 + 1 );
        var_8 = -1;

        if ( isdefined( var_3[var_6] ) )
        {
            if ( !_ID18558( var_0, var_3[var_6] ) )
                var_8 = tablelookuprownum( "mp/attachmentTable.csv", 4, var_3[var_6] );
        }

        self setclientomnvar( var_7, var_8 );
    }
}

_ID18572( var_0, var_1 )
{
    var_2 = 4;
    var_3 = 0;
    var_4 = 4;
    var_5 = self getrankedplayerdata( "weaponRank", var_1 );
    var_6 = int( tablelookup( "mp/weaponRankTable.csv", var_3, getweaponclass( var_1 ), var_4 ) );
    var_7 = tablelookup( "mp/weaponRankTable.csv", var_6, var_0, var_2 );

    if ( var_7 != "" )
    {
        if ( var_5 >= int( var_7 ) )
            return 1;
    }

    return 0;
}

_ID18571( var_0, var_1 )
{
    if ( isdefined( self._ID20132 ) && self._ID20132 == var_1 )
    {
        if ( isdefined( self._ID20134 ) && self._ID20134 == var_0 )
            return 1;
    }
    else if ( isdefined( self._ID20138 ) && self._ID20138 == var_1 )
    {
        if ( isdefined( self._ID20140 ) && self._ID20140 == var_0 )
            return 1;
    }

    return 0;
}

_ID28682( var_0 )
{
    var_1 = getmatchrulesdata( "commonOption", "timeLimit" );
    setdynamicdvar( "scr_" + level._ID14086 + "_timeLimit", var_1 );
    _ID25718( level._ID14086, var_1 );
    var_2 = getmatchrulesdata( "commonOption", "scoreLimit" );
    setdynamicdvar( "scr_" + level._ID14086 + "_scoreLimit", var_2 );
    _ID25717( level._ID14086, var_2 );
    var_3 = getmatchrulesdata( "commonOption", "numLives" );
    setdynamicdvar( "scr_" + level._ID14086 + "_numLives", var_3 );
    _ID25712( level._ID14086, var_3 );
    setdynamicdvar( "scr_player_maxhealth", getmatchrulesdata( "commonOption", "maxHealth" ) );
    setdynamicdvar( "scr_player_healthregentime", getmatchrulesdata( "commonOption", "healthRegen" ) );
    level._ID20676 = 0;
    level._ID20680 = 0;
    setdynamicdvar( "scr_game_spectatetype", getmatchrulesdata( "commonOption", "spectateModeAllowed" ) );
    setdynamicdvar( "scr_game_allowkillcam", getmatchrulesdata( "commonOption", "showKillcam" ) );
    setdynamicdvar( "scr_game_forceuav", getmatchrulesdata( "commonOption", "radarAlwaysOn" ) );
    setdynamicdvar( "scr_" + level._ID14086 + "_playerrespawndelay", getmatchrulesdata( "commonOption", "respawnDelay" ) );
    setdynamicdvar( "scr_" + level._ID14086 + "_waverespawndelay", getmatchrulesdata( "commonOption", "waveRespawnDelay" ) );
    setdynamicdvar( "scr_player_forcerespawn", getmatchrulesdata( "commonOption", "forceRespawn" ) );
    level._ID20675 = getmatchrulesdata( "commonOption", "allowCustomClasses" );
    level._ID32097 = getmatchrulesdata( "commonOption", "allowIntel" );
    setdynamicdvar( "scr_game_hardpoints", getmatchrulesdata( "commonOption", "allowKillstreaks" ) );
    setdynamicdvar( "scr_game_perks", getmatchrulesdata( "commonOption", "allowPerks" ) );
    setdynamicdvar( "g_hardcore", getmatchrulesdata( "commonOption", "hardcoreModeOn" ) );
    setdynamicdvar( "scr_game_onlyheadshots", getmatchrulesdata( "commonOption", "headshotsOnly" ) );

    if ( !isdefined( var_0 ) )
        setdynamicdvar( "scr_team_fftype", getmatchrulesdata( "commonOption", "friendlyFire" ) );

    if ( getmatchrulesdata( "commonOption", "hardcoreModeOn" ) )
    {
        setdynamicdvar( "scr_team_fftype", 2 );
        setdynamicdvar( "scr_player_maxhealth", 30 );
        setdynamicdvar( "scr_player_healthregentime", 0 );
        setdynamicdvar( "scr_player_respawndelay", 0 );
        setdynamicdvar( "scr_game_allowkillcam", 0 );
        setdynamicdvar( "scr_game_forceuav", 0 );
    }

    setdvar( "bg_compassShowEnemies", getdvar( "scr_game_forceuav" ) );
}

_ID25726()
{
    for (;;)
    {
        level waittill( "host_migration_begin" );
        [[ level.initializematchrules ]]();
    }
}

_ID25727( var_0 )
{
    self endon( "disconnect" );

    if ( isdefined( var_0 ) )
        var_0 endon( "death" );

    for (;;)
    {
        level waittill( "host_migration_begin" );

        if ( isdefined( self.lastvisionsetthermal ) )
            self visionsetthermalforplayer( self.lastvisionsetthermal, 0 );
    }
}

_ID15140( var_0, var_1 )
{
    var_2 = [];
    var_2["loadoutPrimaryAttachment2"] = "none";
    var_2["loadoutSecondaryAttachment2"] = "none";
    var_3 = [];
    var_2["loadoutPrimary"] = getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "weaponSetups", 0, "weapon" );
    var_2["loadoutPrimaryAttachment"] = getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "weaponSetups", 0, "attachment", 0 );
    var_2["loadoutPrimaryAttachment2"] = getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "weaponSetups", 0, "attachment", 1 );
    var_2["loadoutPrimaryBuff"] = getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "weaponSetups", 0, "buff" );
    var_2["loadoutPrimaryCamo"] = getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "weaponSetups", 0, "camo" );
    var_2["loadoutPrimaryReticle"] = getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "weaponSetups", 0, "reticle" );
    var_2["loadoutSecondary"] = getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "weaponSetups", 1, "weapon" );
    var_2["loadoutSecondaryAttachment"] = getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "weaponSetups", 1, "attachment", 0 );
    var_2["loadoutSecondaryAttachment2"] = getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "weaponSetups", 1, "attachment", 1 );
    var_2["loadoutSecondaryBuff"] = getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "weaponSetups", 1, "buff" );
    var_2["loadoutSecondaryCamo"] = getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "weaponSetups", 1, "camo" );
    var_2["loadoutSecondaryReticle"] = getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "weaponSetups", 1, "reticle" );
    var_2["loadoutEquipment"] = getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "perks", 0 );
    var_2["loadoutOffhand"] = getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "perks", 1 );

    if ( var_2["loadoutOffhand"] == "specialty_null" )
    {
        var_2["loadoutOffhand"] = "none";

        if ( level._ID14086 == "infect" && var_0 == "axis" )
            var_2["loadoutOffhand"] = "specialty_tacticalinsertion";
    }

    for ( var_4 = 0; var_4 < maps\mp\gametypes\_class::getnumabilitycategories(); var_4++ )
    {
        for ( var_5 = 0; var_5 < maps\mp\gametypes\_class::getnumsubability(); var_5++ )
        {
            var_6 = 0;
            var_6 = getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "abilitiesPicked", var_4, var_5 );

            if ( isdefined( var_6 ) && var_6 )
            {
                var_7 = tablelookup( "mp/cacAbilityTable.csv", 0, var_4 + 1, var_5 + 4 );
                var_3[var_3.size] = var_7;
            }
        }
    }

    var_2["loadoutPerks"] = var_3;
    var_8 = getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "perks", 5 );

    if ( var_8 != "specialty_null" )
    {
        var_2["loadoutStreakType"] = var_8;
        var_2["loadoutKillstreak1"] = maps\mp\gametypes\_class::recipe_getkillstreak( var_0, var_1, var_8, 0 );
        var_2["loadoutKillstreak2"] = maps\mp\gametypes\_class::recipe_getkillstreak( var_0, var_1, var_8, 1 );
        var_2["loadoutKillstreak3"] = maps\mp\gametypes\_class::recipe_getkillstreak( var_0, var_1, var_8, 2 );
    }

    var_2["loadoutJuggernaut"] = getmatchrulesdata( "defaultClasses", var_0, var_1, "juggernaut" );
    return var_2;
}

recipeclassapplyjuggernaut( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    if ( level._ID17628 && !self.hasdonecombat )
        self waittill( "giveLoadout" );
    else
        self waittill( "spawned_player" );

    if ( var_0 )
    {
        self notify( "lost_juggernaut" );
        wait 0.5;
    }

    if ( !isdefined( self._ID18673 ) )
    {
        self._ID21667 = 0.7;
        maps\mp\gametypes\_weapons::_ID34567();
    }

    self.juggmovespeedscaler = 0.7;
    self disableweaponpickup();

    if ( !getdvarint( "camera_thirdPerson" ) )
        self setclientomnvar( "ui_juggernaut", 1 );

    thread maps\mp\killstreaks\_juggernaut::_ID18986();

    if ( level._ID14086 != "jugg" || isdefined( level._ID20679 ) && level._ID20679 )
        self setperk( "specialty_radarjuggernaut", 1, 0 );

    if ( isdefined( self._ID18672 ) && self._ID18672 )
        self makeportableradar( self );

    level notify( "juggernaut_equipped",  self  );
    thread maps\mp\killstreaks\_juggernaut::_ID18989();
}

_ID34608( var_0, var_1 )
{
    self.sessionstate = var_0;

    if ( !isdefined( var_1 ) )
        var_1 = "";

    self.statusicon = var_1;
    self setclientomnvar( "ui_session_state", var_0 );
}

_ID14933( var_0 )
{
    return level.classmap[var_0];
}

isteaminlaststand()
{
    var_0 = _ID15126( self.team );

    foreach ( var_2 in var_0 )
    {
        if ( var_2 != self && ( !isdefined( var_2.laststand ) || !var_2.laststand ) )
            return 0;
    }

    return 1;
}

killteaminlaststand( var_0 )
{
    var_1 = _ID15126( var_0 );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3.laststand ) && var_3.laststand )
            var_3 thread maps\mp\gametypes\_damage::_ID10022( randomintrange( 1, 3 ) );
    }
}

_ID32279( var_0 )
{
    if ( !isai( self ) )
    {
        self switchtoweapon( var_0 );
        return;
    }

    self switchtoweapon( "none" );
    return;
}

_ID18540( var_0 )
{
    if ( isagent( var_0 ) && var_0.agent_teamparticipant == 1 )
        return 1;

    if ( isbot( var_0 ) )
        return 1;

    return 0;
}

_ID18820( var_0 )
{
    if ( _ID18540( var_0 ) )
        return 1;

    if ( isplayer( var_0 ) )
        return 1;

    return 0;
}

isaigameparticipant( var_0 )
{
    if ( isagent( var_0 ) && isdefined( var_0.agent_gameparticipant ) && var_0.agent_gameparticipant == 1 )
        return 1;

    if ( isbot( var_0 ) )
        return 1;

    return 0;
}

_ID18638( var_0 )
{
    if ( isaigameparticipant( var_0 ) )
        return 1;

    if ( isplayer( var_0 ) )
        return 1;

    return 0;
}

_ID15419( var_0 )
{
    var_1 = 0;

    if ( level._ID32653 )
    {
        switch ( var_0 )
        {
            case "axis":
                var_1 = 1;
                break;
            case "allies":
                var_1 = 2;
                break;
        }
    }

    return var_1;
}

getteamarray( var_0, var_1 )
{
    var_2 = [];

    if ( !isdefined( var_1 ) || var_1 )
    {
        foreach ( var_4 in level.characters )
        {
            if ( var_4.team == var_0 )
                var_2[var_2.size] = var_4;
        }
    }
    else
    {
        foreach ( var_4 in level.players )
        {
            if ( var_4.team == var_0 )
                var_2[var_2.size] = var_4;
        }
    }

    return var_2;
}

_ID18642( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_3 ) )
    {
        if ( isdefined( var_3.owner ) )
        {
            if ( var_3.code_classname == "script_vehicle" )
                return 0;

            if ( var_3.code_classname == "misc_turret" )
                return 0;

            if ( var_3.code_classname == "script_model" )
                return 0;
        }

        if ( isdefined( var_3.agent_type ) )
        {
            if ( var_3.agent_type == "dog" || var_3.agent_type == "alien" )
                return 0;
        }
    }

    return ( var_1 == "head" || var_1 == "helmet" ) && var_2 != "MOD_MELEE" && var_2 != "MOD_IMPACT" && var_2 != "MOD_SCARAB" && var_2 != "MOD_CRUSH" && !_ID18615( var_0 );
}

attackerishittingteam( var_0, var_1 )
{
    if ( !level._ID32653 )
    {
        return 0;
        return;
    }

    if ( !isdefined( var_1 ) || !isdefined( var_0 ) )
    {
        return 0;
        return;
    }

    if ( !isdefined( var_0.team ) || !isdefined( var_1.team ) )
    {
        return 0;
        return;
    }

    if ( var_0 == var_1 )
    {
        return 0;
        return;
    }

    if ( level._ID14086 == "infect" && var_0.pers["team"] == var_1.team && isdefined( var_1._ID32655 ) )
    {
        return 0;
        return;
    }

    if ( level._ID14086 == "infect" && var_0.pers["team"] != var_1.team && isdefined( var_1._ID32655 ) )
    {
        return 1;
        return;
    }

    if ( isdefined( var_1._ID27390 ) && var_1._ID27390 )
    {
        return 0;
        return;
    }

    if ( var_0.team == var_1.team )
    {
        return 1;
        return;
    }

    return 0;
    return;
    return;
    return;
    return;
    return;
    return;
    return;
    return;
}

set_high_priority_target_for_bot( var_0 )
{
    if ( !( isdefined( self.high_priority_for ) && common_scripts\utility::array_contains( self.high_priority_for, var_0 ) ) )
    {
        self.high_priority_for = common_scripts\utility::array_add( self.high_priority_for, var_0 );
        var_0 notify( "calculate_new_level_targets" );
        return;
    }
}

add_to_bot_use_targets( var_0, var_1 )
{
    if ( isdefined( level.bot_funcs["bots_add_to_level_targets"] ) )
    {
        var_0._ID34718 = var_1;
        var_0.bot_interaction_type = "use";
        [[ level.bot_funcs["bots_add_to_level_targets"] ]]( var_0 );
        return;
    }
}

_ID25898( var_0 )
{
    if ( isdefined( level.bot_funcs["bots_remove_from_level_targets"] ) )
    {
        [[ level.bot_funcs["bots_remove_from_level_targets"] ]]( var_0 );
        return;
    }
}

add_to_bot_damage_targets( var_0 )
{
    if ( isdefined( level.bot_funcs["bots_add_to_level_targets"] ) )
    {
        var_0.bot_interaction_type = "damage";
        [[ level.bot_funcs["bots_add_to_level_targets"] ]]( var_0 );
        return;
    }
}

remove_from_bot_damage_targets( var_0 )
{
    if ( isdefined( level.bot_funcs["bots_remove_from_level_targets"] ) )
    {
        [[ level.bot_funcs["bots_remove_from_level_targets"] ]]( var_0 );
        return;
    }
}

_ID22279( var_0 )
{
    if ( isdefined( level.bot_funcs["notify_enemy_bots_bomb_used"] ) )
    {
        self [[ level.bot_funcs["notify_enemy_bots_bomb_used"] ]]( var_0 );
        return;
    }
}

_ID14714()
{
    if ( isdefined( level.bot_funcs["bot_get_rank_xp"] ) )
    {
        return self [[ level.bot_funcs["bot_get_rank_xp"] ]]();
        return;
    }
}

_ID36859()
{
    var_0 = 1;

    if ( getdvar( "squad_use_hosts_squad" ) == "1" )
    {
        var_1 = undefined;

        if ( isdefined( self._ID5801 ) )
            var_1 = self._ID5801;
        else if ( isdefined( self.pers["team"] ) )
            var_1 = self.pers["team"];

        if ( isdefined( var_1 ) && level.wargame_client.team == var_1 )
            var_0 = 0;
        else
            var_0 = 1;
    }
    else
        var_0 = self botisrandomized();

    return var_0;
}

isassaultkillstreak( var_0 )
{
    switch ( var_0 )
    {
        case "helicopter":
        case "sentry":
        case "vanguard":
        case "heli_pilot":
        case "drone_hive":
        case "odin_assault":
        case "ims":
        case "uplink":
        case "guard_dog":
        case "ball_drone_backup":
        case "airdrop_sentry_minigun":
        case "airdrop_juggernaut":
        case "airdrop_assault":
        case "airdrop_juggernaut_maniac":
            return 1;
        default:
            return 0;
    }
}

issupportkillstreak( var_0 )
{
    switch ( var_0 )
    {
        case "air_superiority":
        case "odin_support":
        case "deployable_vest":
        case "deployable_ammo":
        case "uplink_support":
        case "aa_launcher":
        case "ball_drone_radar":
        case "recon_agent":
        case "jammer":
        case "uav_3dping":
        case "airdrop_juggernaut_recon":
        case "heli_sniper":
        case "sam_turret":
            return 1;
        default:
            return 0;
    }
}

_ID18795( var_0 )
{
    switch ( var_0 )
    {
        case "specialty_fastsprintrecovery_ks":
        case "specialty_fastreload_ks":
        case "specialty_lightweight_ks":
        case "specialty_marathon_ks":
        case "specialty_stalker_ks":
        case "specialty_reducedsway_ks":
        case "specialty_quickswap_ks":
        case "specialty_pitcher_ks":
        case "specialty_bulletaccuracy_ks":
        case "specialty_quickdraw_ks":
        case "specialty_sprintreload_ks":
        case "specialty_silentkill_ks":
        case "specialty_blindeye_ks":
        case "specialty_gpsjammer_ks":
        case "specialty_quieter_ks":
        case "specialty_incog_ks":
        case "specialty_paint_ks":
        case "specialty_scavenger_ks":
        case "specialty_detectexplosive_ks":
        case "specialty_selectivehearing_ks":
        case "specialty_comexp_ks":
        case "specialty_falldamage_ks":
        case "specialty_regenfaster_ks":
        case "specialty_sharp_focus_ks":
        case "specialty_stun_resistance_ks":
        case "_specialty_blastshield_ks":
        case "specialty_gunsmith_ks":
        case "specialty_extraammo_ks":
        case "specialty_extra_equipment_ks":
        case "specialty_extra_deadly_ks":
        case "specialty_extra_attachment_ks":
        case "specialty_explosivedamage_ks":
        case "specialty_gambler_ks":
        case "specialty_hardline_ks":
        case "specialty_twoprimaries_ks":
        case "specialty_boom_ks":
        case "specialty_deadeye_ks":
            return 1;
        default:
            return 0;
    }
}

bot_is_fireteam_mode()
{
    var_0 = botautoconnectenabled() == 2;

    if ( var_0 )
    {
        if ( !level._ID32653 || level._ID14086 != "war" && level._ID14086 != "dom" )
            return 0;

        return 1;
    }

    return 0;
}

set_console_status()
{
    if ( !isdefined( level.console ) )
    {
        level.console = getdvar( "consoleGame" ) == "true";
        jump loc_6161
    }

    if ( !isdefined( level._ID36452 ) )
    {
        level._ID36452 = getdvar( "xenonGame" ) == "true";
        jump loc_6180
    }

    if ( !isdefined( level._ID25139 ) )
    {
        level._ID25139 = getdvar( "ps3Game" ) == "true";
        jump loc_619F
    }

    if ( !isdefined( level._ID36451 ) )
    {
        level._ID36451 = getdvar( "xb3Game" ) == "true";
        jump loc_61BE
    }

    if ( !isdefined( level._ID25140 ) )
    {
        level._ID25140 = getdvar( "ps4Game" ) == "true";
        return;
    }

    return;
}

_ID18422()
{
    if ( level._ID36451 || level._ID25140 || !level.console )
    {
        return 1;
        return;
    }

    return 0;
    return;
}

_ID28710( var_0, var_1, var_2 )
{
    if ( !isdefined( level.console ) || !isdefined( level._ID36451 ) || !isdefined( level._ID25140 ) )
        set_console_status();

    if ( _ID18422() )
    {
        setdvar( var_0, var_2 );
        return;
    }

    setdvar( var_0, var_1 );
    return;
}

_ID18859( var_0, var_1, var_2 )
{
    return isdefined( var_2.team ) && var_2.team == var_1;
}

isvalidffatarget( var_0, var_1, var_2 )
{
    return isdefined( var_2.owner ) && ( !isdefined( var_0 ) || var_2.owner != var_0 );
}

gethelipilotmeshoffset()
{
    return ( 0, 0, 5000 );
}

_ID15049()
{
    return ( 0, 0, 2500 );
}

getlinknamenodes()
{
    var_0 = [];

    if ( isdefined( self.script_linkto ) )
    {
        var_1 = strtok( self.script_linkto, " " );

        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            var_3 = getnode( var_1[var_2], "script_linkname" );

            if ( isdefined( var_3 ) )
                var_0[var_0.size] = var_3;
        }
    }

    return var_0;
}

_ID18363()
{
    return level._ID14086 == "aliens";
}

_ID14681( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    var_2 = self getentitynumber();
    var_3 = [];

    foreach ( var_5 in level.players )
    {
        if ( var_5 == self )
            continue;

        var_6 = 0;

        if ( !var_1 )
        {
            if ( var_5.team == "spectator" || var_5.sessionstate == "spectator" )
            {
                var_7 = var_5 getspectatingplayer();

                if ( isdefined( var_7 ) && var_7 == self )
                    var_6 = 1;
            }

            if ( var_5.forcespectatorclient == var_2 )
                var_6 = 1;
        }

        if ( !var_0 )
        {
            if ( var_5.killcamentity == var_2 )
                var_6 = 1;
        }

        if ( var_6 )
            var_3[var_3.size] = var_5;
    }

    return var_3;
}

set_visionset_for_watching_players( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = _ID14681( var_4, var_5 );

    foreach ( var_8 in var_6 )
    {
        var_8 notify( "changing_watching_visionset" );

        if ( isdefined( var_3 ) && var_3 )
            var_8 visionsetmissilecamforplayer( var_0, var_1 );
        else
            var_8 visionsetnakedforplayer( var_0, var_1 );

        if ( var_0 != "" && isdefined( var_2 ) )
        {
            var_8 thread _ID26114( self, var_1 + var_2 );
            var_8 thread _ID26113( self );

            if ( var_8 _ID18658() )
                var_8 thread reset_visionset_on_spawn();
        }
    }
}

reset_visionset_on_spawn()
{
    self endon( "disconnect" );
    self waittill( "spawned" );
    self visionsetnakedforplayer( "", 0.0 );
}

_ID26114( var_0, var_1 )
{
    self endon( "changing_watching_visionset" );
    var_2 = gettime();
    var_3 = self.team;

    while ( gettime() - var_2 < var_1 * 1000 )
    {
        if ( self.team != var_3 || !common_scripts\utility::array_contains( var_0 _ID14681(), self ) )
        {
            self visionsetnakedforplayer( "", 0.0 );
            self notify( "changing_visionset" );
            break;
        }

        wait 0.05;
    }
}

_ID26113( var_0 )
{
    self endon( "changing_watching_visionset" );
    var_0 waittill( "disconnect" );
    self visionsetnakedforplayer( "", 0.0 );
}

_setplayerdata( var_0, var_1 )
{
    if ( _ID20673() )
    {
        self setrankedplayerdata( var_0, var_1 );
        return;
    }

    self setprivateplayerdata( var_0, var_1 );
    return;
}

_getplayerdata( var_0 )
{
    if ( _ID20673() )
    {
        return self getrankedplayerdata( var_0 );
        return;
    }

    return self getprivateplayerdata( var_0 );
    return;
}

_validateattacker( var_0 )
{
    if ( isagent( var_0 ) && ( !isdefined( var_0.isactive ) || !var_0.isactive ) )
        return undefined;

    if ( isagent( var_0 ) && !isdefined( var_0.classname ) )
        return undefined;

    return var_0;
}

_ID35688()
{
    self waittill( "grenade_fire",  var_0, var_1  );

    if ( isdefined( var_0 ) )
    {
        if ( !isdefined( var_0._ID36249 ) )
            var_0._ID36249 = var_1;

        if ( !isdefined( var_0.owner ) )
            var_0.owner = self;

        if ( !isdefined( var_0.team ) )
            var_0.team = self.team;
    }

    return var_0;
}

_ID35695()
{
    self waittill( "missile_fire",  var_0, var_1  );

    if ( isdefined( var_0 ) )
    {
        if ( !isdefined( var_0._ID36249 ) )
            var_0._ID36249 = var_1;

        if ( !isdefined( var_0.owner ) )
            var_0.owner = self;

        if ( !isdefined( var_0.team ) )
            var_0.team = self.team;
    }

    return var_0;
}

_setnameplatematerial( var_0, var_1 )
{
    if ( !isdefined( self._ID21874 ) )
    {
        self._ID21874 = [];
        self.prevnameplatematerial = [];
    }
    else
    {
        self.prevnameplatematerial[0] = self._ID21874[0];
        self.prevnameplatematerial[1] = self._ID21874[1];
    }

    self._ID21874[0] = var_0;
    self._ID21874[1] = var_1;
    self setnameplatematerial( var_0, var_1 );
}

_restorepreviousnameplatematerial()
{
    if ( isdefined( self.prevnameplatematerial ) )
        self setnameplatematerial( self.prevnameplatematerial[0], self.prevnameplatematerial[1] );
    else
        self setnameplatematerial( "", "" );

    self._ID21874 = undefined;
    self.prevnameplatematerial = undefined;
}

isplayeroutsideofanybombsite( var_0 )
{
    if ( isdefined( level.bombzones ) )
    {
        foreach ( var_2 in level.bombzones )
        {
            if ( self istouching( var_2.trigger ) )
                return 0;
        }
    }

    return 1;
}

weaponignoresblastshield( var_0 )
{
    return var_0 == "heli_pilot_turret_mp" || var_0 == "bomb_site_mp";
}

_ID18867( var_0 )
{
    return var_0 == "ims_projectile_mp" || var_0 == "remote_tank_projectile_mp";
}

_ID26201( var_0 )
{
    self visionsetnakedforplayer( "", var_0 );
}

playplayerandnpcsounds( var_0, var_1, var_2 )
{
    var_0 playlocalsound( var_1 );
    var_0 playsoundtoteam( var_2, "allies", var_0 );
    var_0 playsoundtoteam( var_2, "axis", var_0 );
}

isenemy( var_0 )
{
    if ( level._ID32653 )
    {
        return isplayeronenemyteam( var_0 );
        return;
    }

    return isplayerffaenemy( var_0 );
    return;
}

isplayeronenemyteam( var_0 )
{
    return var_0.team != self.team;
}

isplayerffaenemy( var_0 )
{
    if ( isdefined( var_0.owner ) )
    {
        return var_0.owner != self;
        return;
    }

    return var_0 != self;
    return;
}

setextrascore0( var_0 )
{
    self.extrascore0 = var_0;
    _ID28819( "extrascore0", var_0 );
}

allowlevelkillstreaks()
{
    if ( level._ID14086 == "sotf" && level._ID14086 == "sotf_ffa" && level._ID14086 == "infect" && level._ID14086 == "horde" )
        return 0;

    return 1;
}

getuniqueid()
{
    if ( isdefined( self.pers["guid"] ) )
        return self.pers["guid"];

    var_0 = self getguid();

    if ( var_0 == "0000000000000000" )
    {
        if ( isdefined( level.guidgen ) )
            level.guidgen++;
        else
            level.guidgen = 1;

        var_0 = "script" + level.guidgen;
    }

    self.pers["guid"] = var_0;
    return self.pers["guid"];
}

getrandomplayingplayer()
{
    var_0 = common_scripts\utility::array_removeundefined( level.players );

    for (;;)
    {
        if ( !var_0.size )
            return;

        var_1 = randomintrange( 0, var_0.size );
        var_2 = var_0[var_1];

        if ( !_ID18757( var_2 ) || var_2.sessionstate != "playing" )
        {
            var_0 = common_scripts\utility::array_remove( var_0, var_2 );
            continue;
        }

        return var_2;
    }
}

getmapname()
{
    if ( !isdefined( level.mapname ) )
        level.mapname = getdvar( "mapname" );

    return level.mapname;
}

issinglehitweapon( var_0 )
{
    switch ( var_0 )
    {
        case "iw6_mk32_mp":
        case "iw6_maaws_mp":
        case "iw6_rgm_mp":
        case "iw6_panzerfaust3_mp":
            return 1;
        default:
            return 0;
    }
}

gamehasneutralcrateowner( var_0 )
{
    switch ( var_0 )
    {
        case "sotf":
        case "sotf_ffa":
            return 1;
        default:
            return 0;
    }
}

array_remove_keep_index( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_5, var_4 in var_0 )
    {
        if ( var_4 != var_1 )
            var_2[var_5] = var_4;
    }

    return var_2;
}

isanymlgmatch()
{
    if ( getdvarint( "xblive_competitionmatch" ) )
        return 1;

    return 0;
}

_ID37549()
{
    if ( getdvarint( "systemlink" ) && getdvarint( "xblive_competitionmatch" ) )
        return 1;

    return 0;
}

_ID37548()
{
    if ( _ID25017() && getdvarint( "xblive_competitionmatch" ) )
        return 1;

    return 0;
}

_ID37547()
{
    if ( _ID37549() || _ID37548() )
        return 1;

    return 0;
}

_ID18706()
{
    if ( level._ID14086 == "blitz" || level._ID14086 == "dom" )
        return 1;

    return 0;
}

isusingdefaultclass( var_0, var_1 )
{
    var_2 = 0;

    if ( isdefined( var_1 ) )
    {
        if ( isusingmatchrulesdata() && getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "inUse" ) )
            var_2 = 1;
    }
    else
    {
        for ( var_1 = 0; var_1 < 6; var_1++ )
        {
            if ( isusingmatchrulesdata() && getmatchrulesdata( "defaultClasses", var_0, var_1, "class", "inUse" ) )
            {
                var_2 = 1;
                break;
            }
        }
    }

    return var_2;
}

cancustomjuggusekillstreak( var_0 )
{
    var_1 = 1;

    if ( isdefined( self.isjuggernautlevelcustom ) && self.isjuggernautlevelcustom && ( isdefined( self.canusekillstreakcallback ) && !self [[ self.canusekillstreakcallback ]]( var_0 ) ) )
        var_1 = 0;

    return var_1;
}

printcustomjuggkillstreakerrormsg()
{
    if ( isdefined( self.killstreakerrormsg ) )
    {
        [[ self.killstreakerrormsg ]]();
        return;
    }
}
