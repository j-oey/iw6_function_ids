// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    if ( level._ID32653 && !isdefined( level._ID22073 ) )
    {
        if ( !isdefined( level.battlebuddywaitlist ) )
            level.battlebuddywaitlist = [];

        level thread onplayerspawned();
        level thread _ID22877();
    }
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread _ID22777();
        var_0 thread _ID22808();
    }
}

onplayerspawned()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "player_spawned",  var_0  );

        if ( !isai( var_0 ) )
        {
            if ( isdefined( var_0._ID18790 ) )
            {
                var_0._ID18790 = undefined;

                if ( isdefined( var_0.battlebuddy ) && isalive( var_0.battlebuddy ) )
                {
                    if ( var_0.battlebuddy getstance() != "stand" )
                        var_0 setstance( "crouch" );
                }
            }

            if ( var_0 _ID35842() )
            {
                if ( !var_0 _ID16383() )
                {
                    var_0._ID13166 = 0;
                    var_0 findbattlebuddy();
                }

                continue;
            }

            var_0 leavebattlebuddysystem();
        }
    }
}

_ID22777()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "luinotifyserver",  var_0, var_1  );

        if ( var_0 == "battlebuddy_update" )
        {
            var_2 = !_ID35842();
            self setcommonplayerdata( "enableBattleBuddy", var_2 );

            if ( var_2 )
                findbattlebuddy();
            else
                leavebattlebuddysystem();

            continue;
        }

        if ( var_0 == "team_select" && self.hasspawned )
        {
            var_3 = _ID35842();
            leavebattlebuddysystem();
            self setcommonplayerdata( "enableBattleBuddy", var_3 );
        }
    }
}

_ID22808()
{
    self waittill( "disconnect" );
    leavebattlebuddysystemdisconnect();
}

_ID35565()
{
    maps\mp\_utility::_ID34608( "spectator" );
    self.forcespectatorclient = self.battlebuddy getentitynumber();
    self forcethirdpersonwhenfollowing();
    self setclientomnvar( "cam_scene_name", "over_shoulder" );
    self setclientomnvar( "cam_scene_lead", self.battlebuddy getentitynumber() );
    _ID35546();
}

_ID36077()
{
    self endon( "disconnect" );
    self endon( "abort_battlebuddy_spawn" );
    self endon( "teamSpawnPressed" );
    level endon( "game_ended" );
    self setclientomnvar( "ui_battlebuddy_showButtonPrompt", 1 );
    self notifyonplayercommand( "respawn_random", "+usereload" );
    self notifyonplayercommand( "respawn_random", "+activate" );
    wait 0.5;
    self waittill( "respawn_random" );
    self setclientomnvar( "ui_battlebuddy_timer_ms", 0 );
    self setclientomnvar( "ui_battlebuddy_showButtonPrompt", 0 );
    setupforrandomspawn();
}

setupforrandomspawn()
{
    clearbuddymessage();
    self._ID18790 = undefined;
    self notify( "randomSpawnPressed" );
    _ID7402();
}

_ID35546()
{
    self endon( "randomSpawnPressed" );
    level endon( "game_ended" );
    self._ID18790 = undefined;
    thread _ID36077();

    if ( isdefined( self.battlebuddyrespawntimestamp ) )
    {
        var_0 = 4000 - ( gettime() - self.battlebuddyrespawntimestamp );

        if ( var_0 < 2000 )
            var_0 = 2000;
    }
    else
        var_0 = 4000;

    var_1 = _ID7062();

    if ( var_1._ID31530 == 0 )
        self.battlebuddy setclientomnvar( "ui_battlebuddy_status", "incoming" );
    else if ( var_1._ID31530 == -1 || var_1._ID31530 == -3 )
        self.battlebuddy setclientomnvar( "ui_battlebuddy_status", "err_combat" );
    else
        self.battlebuddy setclientomnvar( "ui_battlebuddy_status", "err_pos" );

    _ID34631( var_0 );

    for ( var_1 = _ID7062(); var_1._ID31530 != 0; var_1 = _ID7062() )
    {
        if ( var_1._ID31530 == -1 || var_1._ID31530 == -3 )
        {
            self setclientomnvar( "ui_battlebuddy_status", "wait_combat" );
            self.battlebuddy setclientomnvar( "ui_battlebuddy_status", "err_combat" );
        }
        else if ( var_1._ID31530 == -2 )
        {
            self setclientomnvar( "ui_battlebuddy_status", "wait_pos" );
            self.battlebuddy setclientomnvar( "ui_battlebuddy_status", "err_pos" );
        }
        else if ( var_1._ID31530 == -4 )
        {
            _ID7402();
            return;
        }

        wait 0.5;
    }

    self._ID18790 = 1;
    thread _ID10220();
    self playlocalsound( "copycat_steal_class" );
    self notify( "teamSpawnPressed" );
}

clearbuddymessage()
{
    self setclientomnvar( "ui_battlebuddy_status", "none" );
    self setclientomnvar( "ui_battlebuddy_showButtonPrompt", 0 );

    if ( isdefined( self.battlebuddy ) )
        self.battlebuddy setclientomnvar( "ui_battlebuddy_status", "none" );
}

displaybuddystatusmessage( var_0 )
{
    maps\mp\_utility::setlowermessage( "waiting_info", var_0, undefined, undefined, undefined, undefined, undefined, undefined, 1 );
}

_ID10220()
{
    clearbuddymessage();

    if ( isdefined( self.battlebuddy ) )
    {
        self.battlebuddy setclientomnvar( "ui_battlebuddy_status", "on_you" );
        wait 1.5;
        self.battlebuddy setclientomnvar( "ui_battlebuddy_status", "none" );
    }
}

_ID7062()
{
    var_0 = spawnstruct();

    if ( !isdefined( self.battlebuddy ) || !isalive( self.battlebuddy ) )
    {
        var_0._ID31530 = -4;
        return var_0;
    }

    if ( maps\mp\gametypes\_spawnscoring::_ID18739( self.battlebuddy, 1 ) )
        var_0._ID31530 = -1;
    else
    {
        var_1 = maps\mp\gametypes\_spawnscoring::findspawnlocationnearplayer( self.battlebuddy );

        if ( isdefined( var_1 ) )
        {
            var_2 = spawnstruct();
            var_2.maxtracecount = 18;
            var_2._ID8708 = 0;

            if ( !maps\mp\gametypes\_spawnscoring::_ID18770( self.battlebuddy, var_1, var_2 ) )
                var_0._ID31530 = -3;
            else
            {
                var_0._ID31530 = 0;
                var_0.origin = var_1;
                var_3 = self.battlebuddy.origin - var_1;
                var_0.angles = ( 0, self.battlebuddy.angles[1], 0 );
            }
        }
        else
            var_0._ID31530 = -2;
    }

    return var_0;
}

_ID7402()
{
    thread maps\mp\gametypes\_spectating::_ID28880();
    self.forcespectatorclient = -1;
    maps\mp\_utility::_ID34608( "dead" );
    self disableforcethirdpersonwhenfollowing();
    self setclientomnvar( "cam_scene_name", "unknown" );
    clearbuddymessage();
    self notify( "abort_battlebuddy_spawn" );
}

_ID34631( var_0 )
{
    self endon( "disconnect" );
    self endon( "abort_battlebuddy_spawn" );
    self endon( "teamSpawnPressed" );
    var_1 = var_0 * 0.001;
    self setclientomnvar( "ui_battlebuddy_timer_ms", var_0 + gettime() );
    wait(var_1);
    self setclientomnvar( "ui_battlebuddy_timer_ms", 0 );
}

_ID35842()
{
    return self getcommonplayerdata( "enableBattleBuddy" );
}

_ID16383()
{
    return isdefined( self.battlebuddy );
}

_ID21904()
{
    return _ID35842() && !_ID16383();
}

_ID18842( var_0 )
{
    return self != var_0 && self.team == var_0.team && var_0 _ID21904();
}

_ID6555()
{
    return _ID16383() && maps\mp\_utility::_ID18757( self.battlebuddy );
}

pairbattlebuddy( var_0 )
{
    removefrombattlebuddywaitlist( var_0 );
    self.battlebuddy = var_0;
    var_0.battlebuddy = self;
    self setclientomnvar( "ui_battlebuddy_idx", var_0 getentitynumber() );
    var_0 setclientomnvar( "ui_battlebuddy_idx", self getentitynumber() );
}

_ID15468()
{
    return level.battlebuddywaitlist[self.team];
}

addtobattlebuddywaitlist( var_0 )
{
    if ( !isdefined( level.battlebuddywaitlist[var_0.team] ) )
        level.battlebuddywaitlist[var_0.team] = var_0;
    else if ( level.battlebuddywaitlist[var_0.team] != var_0 )
        return;
}

removefrombattlebuddywaitlist( var_0 )
{
    if ( isdefined( var_0.team ) && isdefined( level.battlebuddywaitlist[var_0.team] ) && var_0 == level.battlebuddywaitlist[var_0.team] )
        level.battlebuddywaitlist[var_0.team] = undefined;
}

findbattlebuddy()
{
    if ( level._ID22861 )
    {
        self.fireteammembers = self getfireteammembers();

        if ( self.fireteammembers.size >= 1 )
        {
            foreach ( var_1 in self.fireteammembers )
            {
                if ( _ID18842( var_1 ) )
                    pairbattlebuddy( var_1 );
            }
        }
    }

    if ( !_ID16383() )
    {
        var_1 = _ID15468();

        if ( isdefined( var_1 ) && _ID18842( var_1 ) )
            pairbattlebuddy( var_1 );
        else
        {
            addtobattlebuddywaitlist( self );
            self setclientomnvar( "ui_battlebuddy_idx", -1 );
        }
    }
}

_ID7477()
{
    if ( !isalive( self ) )
        setupforrandomspawn();

    self setclientomnvar( "ui_battlebuddy_idx", -1 );
    self.battlebuddy = undefined;
}

leavebattlebuddysystem()
{
    if ( _ID16383() )
    {
        var_0 = self.battlebuddy;
        _ID7477();
        self setcommonplayerdata( "enableBattleBuddy", 0 );
        var_0 _ID7477();
        var_0 findbattlebuddy();
    }
    else
    {
        removefrombattlebuddywaitlist( self );
        self setclientomnvar( "ui_battlebuddy_idx", -1 );
    }
}

leavebattlebuddysystemdisconnect()
{
    if ( _ID16383() )
    {
        var_0 = self.battlebuddy;
        var_0 _ID7477();
        var_0 findbattlebuddy();
        var_0 clearbuddymessage();
    }
    else
    {
        foreach ( var_3, var_2 in level.battlebuddywaitlist )
        {
            if ( var_2 == self )
            {
                level.battlebuddywaitlist[var_3] = undefined;
                break;
            }
        }
    }
}
