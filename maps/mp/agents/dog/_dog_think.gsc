// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    _ID29173();
    thread _ID32903();
    thread _ID36105();
    thread _ID36106();
    thread _ID36108();
    thread _ID35542();
    thread _ID35563();
}

_ID29173()
{
    self.blockgoalpos = 0;
    self.ownerradiussq = 20736;
    self._ID20904 = 16384;
    self.attackoffset = 25 + self.radius;
    self.attackradiussq = 202500;
    self._ID35890 = 302500;
    self._ID35891 = 96.0;
    self.attackzheight = 54;
    self._ID36750 = -64;
    self._ID23183 = 2250000;
    self.dogdamagedradiussq = 2250000;
    self._ID19106 = 1000000;
    self._ID24872 = 76;
    self._ID21127 = 50;
    self._ID13507 = 0;
    self.ignoreclosefoliage = 1;
    self.movemode = "run";
    self.enableextendedkill = 1;
    self.attackstate = "idle";
    self._ID21670 = "idle";
    self._ID5139 = 0;
    self._ID38156 = 0;
    self.allowcrouch = 1;
    self scragentsetgoalradius( 24 );
}

_ID17631()
{
    self.animcbs = spawnstruct();
    self.animcbs.onenter = [];
    self.animcbs.onenter["idle"] = maps\mp\agents\dog\_dog_idle::_ID20445;
    self.animcbs.onenter["move"] = maps\mp\agents\dog\_dog_move::_ID20445;
    self.animcbs.onenter["traverse"] = maps\mp\agents\dog\_dog_traverse::_ID20445;
    self.animcbs.onenter["melee"] = maps\mp\agents\dog\_dog_melee::_ID20445;
    self.animcbs._ID22830 = [];
    self.animcbs._ID22830["idle"] = maps\mp\agents\dog\_dog_idle::end_script;
    self.animcbs._ID22830["move"] = maps\mp\agents\dog\_dog_move::end_script;
    self.animcbs._ID22830["melee"] = maps\mp\agents\dog\_dog_melee::end_script;
    self.animcbs._ID22830["traverse"] = maps\mp\agents\dog\_dog_traverse::end_script;
    self._ID36038 = ::watchattackstate;
    self.aistate = "idle";
    self.movemode = "fastwalk";
    self.radius = 15;
    self.height = 40;
}

_ID22818( var_0, var_1 )
{
    self notify( "killanimscript" );

    if ( !isdefined( self.animcbs.onenter[var_1] ) )
        return;

    if ( var_0 == var_1 && var_1 != "traverse" )
        return;

    if ( isdefined( self.animcbs._ID22830[var_0] ) )
        self [[ self.animcbs._ID22830[var_0] ]]();

    exitaistate( self.aistate );
    self.aistate = var_1;
    _ID12130( var_1 );
    self [[ self.animcbs.onenter[var_1] ]]();
}

_ID32903()
{
    self endon( "death" );
    level endon( "game_ended" );

    if ( isdefined( self.owner ) )
    {
        self endon( "owner_disconnect" );
        thread _ID9815( self.owner );
    }

    self thread [[ self._ID36038 ]]();
    thread _ID21388();

    for (;;)
    {
        if ( self.aistate != "melee" && !self.statelocked && _ID25562() && !didpastmeleefail() )
            self scragentbeginmelee( self.curmeleetarget );

        switch ( self.aistate )
        {
            case "idle":
                _ID34548();
                break;
            case "move":
                _ID34564();
                break;
            case "melee":
                _ID34561();
                break;
        }

        wait 0.05;
    }
}

didpastpursuitfail( var_0 )
{
    if ( isdefined( self.curmeleetarget ) && var_0 != self.curmeleetarget )
        return 0;

    if ( !isdefined( self._ID19597 ) || !isdefined( self._ID19596 ) )
        return 0;

    if ( distance2dsquared( var_0.origin, self._ID19597 ) > 4 )
        return 0;

    if ( self._ID5322 )
        return 1;

    if ( distancesquared( self.origin, self._ID19596 ) > 4096 && gettime() - self._ID19598 > 2000 )
        return 0;

    return 1;
}

didpastmeleefail()
{
    if ( isdefined( self.lastmeleefailedpos ) && isdefined( self.lastmeleefailedmypos ) && distance2dsquared( self.curmeleetarget.origin, self.lastmeleefailedpos ) < 4 && distancesquared( self.origin, self.lastmeleefailedmypos ) < 2500 )
        return 1;

    if ( _ID35845( 0 ) )
        return 1;

    return 0;
}

_ID12130( var_0 )
{
    exitaistate( self.aistate );
    self.aistate = var_0;

    switch ( var_0 )
    {
        case "idle":
            self._ID21670 = "idle";
            self._ID5139 = 0;
            break;
        case "move":
            self._ID21670 = "follow";
            break;
        case "melee":
            break;
        default:
            break;
    }
}

exitaistate( var_0 )
{
    switch ( var_0 )
    {
        case "move":
            self._ID23187 = undefined;
            break;
        default:
            break;
    }
}

_ID34548()
{
    _ID34568();
}

_ID34564()
{
    _ID34568();
}

_ID34561()
{
    self scragentsetgoalpos( self.origin );
}

_ID34568()
{
    if ( self.blockgoalpos )
        return;

    self._ID24947 = self._ID21670;
    var_0 = undefined;
    var_1 = 0;
    var_2 = 0;
    var_3 = 500;

    if ( self._ID5139 && gettime() - self._ID19522 < var_3 )
    {
        self._ID21670 = "follow";
        var_1 = 1;
    }
    else
        self._ID21670 = _ID15159();

    if ( self._ID21670 == "pursuit" )
    {
        var_0 = getattackpoint( self.enemy );
        var_4 = 0;

        if ( isdefined( self._ID19522 ) && gettime() - self._ID19522 < 3000 )
        {
            if ( distance2dsquared( var_0, self._ID19520 ) < 16 )
                var_4 = 1;
            else if ( isdefined( self._ID19521 ) && self._ID19521 == "pursuit" && distance2dsquared( self._ID19523, self.enemy.origin ) < 16 )
                var_4 = 1;
        }

        if ( var_4 )
        {
            self._ID21670 = "follow";
            var_2 = 1;
        }
        else if ( _ID35845( 1 ) )
        {
            self._ID21670 = "follow";
            var_2 = 1;
        }
        else if ( didpastpursuitfail( self.enemy ) )
        {
            self._ID21670 = "follow";
            var_2 = 1;
        }
    }

    _ID28816( var_2 );

    if ( self._ID21670 == "follow" )
    {
        self.curmeleetarget = undefined;
        self.movemode = getfollowmovemode( self.movemode );
        self._ID4803 = 1;
        var_5 = self getpathgoalpos();

        if ( !isdefined( var_5 ) )
            var_5 = self.origin;

        if ( self.owner.sessionstate == "spectator" )
            return;

        if ( gettime() - self._ID38156 < 5000 )
            var_1 = 1;

        var_6 = self.owner getstance();

        if ( !isdefined( self.owner._ID24954 ) && isdefined( self.owner ) )
            self.owner._ID24954 = var_6;

        var_7 = !isdefined( self._ID23187 ) || distance2dsquared( self._ID23187, self.owner.origin ) > 100;

        if ( var_7 )
            self._ID23187 = self.owner.origin;

        var_8 = distance2dsquared( var_5, self.owner.origin );

        if ( var_1 || var_8 > self.ownerradiussq && var_7 || self.owner._ID24954 != var_6 || self._ID24947 != "idle" && self._ID24947 != self._ID21670 )
        {
            self scragentsetgoalpos( findpointnearowner() );
            self.owner._ID24954 = var_6;
            return;
        }

        return;
    }

    if ( self._ID21670 == "pursuit" )
    {
        self.curmeleetarget = self.enemy;
        self.movemode = "sprint";
        self._ID4803 = 0;
        self scragentsetgoalpos( var_0 );
        return;
    }

    return;
}

_ID15159( var_0 )
{
    if ( isdefined( self.enemy ) )
    {
        if ( isdefined( self.favoriteenemy ) && self.enemy == self.favoriteenemy )
            return "pursuit";

        if ( abs( self.origin[2] - self.enemy.origin[2] ) < self._ID35891 && distance2dsquared( self.enemy.origin, self.origin ) < self.attackradiussq )
            return "pursuit";

        if ( isdefined( self.curmeleetarget ) && self.curmeleetarget == self.enemy )
        {
            if ( distance2dsquared( self.curmeleetarget.origin, self.origin ) < self._ID19106 )
                return "pursuit";
        }
    }

    return "follow";
}

_ID28816( var_0 )
{
    if ( var_0 )
    {
        if ( !isdefined( self._ID19597 ) )
        {
            self._ID19597 = self.enemy.origin;
            self._ID19596 = self.origin;
            var_1 = maps\mp\agents\_scriptedagents::droppostoground( self.enemy.origin );
            self._ID5322 = !isdefined( var_1 );
            self._ID19598 = gettime();
            return;
        }

        return;
    }

    self._ID19597 = undefined;
    self._ID19596 = undefined;
    self._ID5322 = undefined;
    self._ID19598 = undefined;
    return;
}

_ID35542()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "bad_path",  var_0  );
        self._ID5139 = 1;
        self._ID19522 = gettime();
        self._ID19520 = var_0;
        self._ID19521 = self._ID21670;

        if ( self._ID21670 == "follow" && isdefined( self.owner ) )
        {
            self._ID19523 = self.owner.origin;
            continue;
        }

        if ( self._ID21670 == "pursuit" && isdefined( self.enemy ) )
            self._ID19523 = self.enemy.origin;
    }
}

_ID35563()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "path_set" );
        self._ID5139 = 0;
    }
}

getfollowmovemode( var_0 )
{
    var_1 = 40000;
    var_2 = 65536;
    var_3 = self getpathgoalpos();

    if ( isdefined( var_3 ) )
    {
        var_4 = distancesquared( var_3, self.origin );

        if ( var_0 == "run" || var_0 == "sprint" )
        {
            if ( var_4 < var_1 )
                return "fastwalk";
            else if ( var_0 == "sprint" )
                return "run";
        }
        else if ( var_0 == "fastwalk" )
        {
            if ( var_4 > var_2 )
                return "run";
        }
    }

    return var_0;
}

_ID37556( var_0 )
{
    var_1 = var_0[2] - self.origin[2];
    return var_1 <= self.attackzheight && var_1 >= self._ID36750;
}

_ID35845( var_0 )
{
    if ( !isdefined( self.curmeleetarget ) )
        return 0;

    return !_ID37556( self.curmeleetarget.origin ) && distance2dsquared( self.origin, self.curmeleetarget.origin ) < self._ID20904 * 0.75 * 0.75 && ( !var_0 || self agentcanseesentient( self.curmeleetarget ) );
}

_ID25562()
{
    if ( !isdefined( self.curmeleetarget ) )
        return 0;

    if ( !maps\mp\_utility::_ID18757( self.curmeleetarget ) )
        return 0;

    if ( self.aistate == "traverse" )
        return 0;

    if ( distance2dsquared( self.origin, self.curmeleetarget.origin ) > self._ID20904 )
        return 0;

    if ( !_ID37556( self.curmeleetarget.origin ) )
        return 0;

    return 1;
}

_ID35844()
{
    if ( !isdefined( self.enemy ) )
        return 0;

    if ( abs( self.origin[2] - self.enemy.origin[2] ) <= self._ID35891 || self agentcanseesentient( self.enemy ) )
    {
        var_0 = distance2dsquared( self.origin, self.enemy.origin );

        if ( var_0 < self._ID35890 )
            return 1;
    }

    return 0;
}

getattackpoint( var_0 )
{
    var_1 = var_0.origin - self.origin;
    var_1 = vectornormalize( var_1 );
    var_2 = self getpathgoalpos();
    var_3 = self.attackoffset + 4;

    if ( isdefined( var_2 ) && distance2dsquared( var_2, var_0.origin ) < var_3 * var_3 && maps\mp\agents\_scriptedagents::canmovepointtopoint( var_0.origin, var_2 ) )
        return var_2;

    var_4 = var_0.origin - var_1 * self.attackoffset;
    var_4 = maps\mp\agents\_scriptedagents::droppostoground( var_4 );

    if ( !isdefined( var_4 ) )
        return var_0.origin;

    if ( !maps\mp\agents\_scriptedagents::canmovepointtopoint( var_0.origin, var_4 ) )
    {
        var_5 = anglestoforward( var_0.angles );
        var_4 = var_0.origin + var_5 * self.attackoffset;

        if ( !maps\mp\agents\_scriptedagents::canmovepointtopoint( var_0.origin, var_4 ) )
            return var_0.origin;
    }

    return var_4;
}

_ID8524( var_0, var_1 )
{
    return var_0[0] * var_1[1] - var_1[0] * var_0[1];
}

findpointnearowner()
{
    var_0 = vectornormalize( self.origin - self.owner.origin );
    var_1 = anglestoforward( self.owner.angles );
    var_1 = ( var_1[0], var_1[1], 0 );
    var_1 = vectornormalize( var_1 );
    var_2 = _ID8524( var_0, var_1 );
    var_3 = getclosestnodeinsight( self.owner.origin );

    if ( !isdefined( var_3 ) )
        return self.origin;

    var_4 = getlinkednodes( var_3 );
    var_5 = 5;
    var_6 = 10;
    var_7 = 15;
    var_8 = -15;
    var_9 = gettime() - self._ID38156 < 5000;
    var_10 = 0;
    var_11 = undefined;
    var_4[var_4.size] = var_3;

    foreach ( var_13 in var_4 )
    {
        var_14 = 0;
        var_15 = var_13.origin - self.owner.origin;
        var_16 = length( var_15 );

        if ( var_16 >= self._ID24872 )
            var_14 += var_5;
        else if ( var_16 < self._ID21127 )
        {
            var_17 = 1 - ( self._ID21127 - var_16 ) / self._ID21127;
            var_14 += var_5 * var_17 * var_17;
        }
        else
            var_14 += var_5 * var_16 / self._ID24872;

        if ( var_16 == 0 )
            var_16 = 1;

        var_15 /= var_16;
        var_18 = vectordot( var_1, var_15 );
        var_19 = self.owner getstance();

        switch ( var_19 )
        {
            case "stand":
                if ( var_18 < cos( 35 ) && var_18 > cos( 45 ) )
                    var_14 += var_6;

                break;
            case "crouch":
                if ( var_18 < cos( 75 ) && var_18 > cos( 90 ) )
                    var_14 += var_6;

                break;
            case "prone":
                if ( var_18 < cos( 125 ) && var_18 > cos( 135 ) )
                    var_14 += var_6;

                break;
        }

        var_20 = _ID8524( var_15, var_1 );

        if ( var_20 * var_2 > 0 )
            var_14 += var_7;

        if ( var_9 )
        {
            var_21 = vectordot( self._ID37069, var_15 );
            var_14 += var_21 * var_8;
        }

        if ( var_14 > var_10 )
        {
            var_10 = var_14;
            var_11 = var_13;
        }
    }

    if ( !isdefined( var_11 ) )
        return self.origin;

    var_23 = var_11.origin - self.owner.origin;
    var_24 = length( var_23 );

    if ( var_24 > self._ID24872 )
    {
        var_25 = var_3.origin - self.owner.origin;

        if ( vectordot( var_25, var_23 / var_24 ) < 0 )
            var_26 = var_11.origin;
        else
        {
            var_27 = vectornormalize( var_11.origin - var_3.origin );
            var_26 = var_3.origin + var_27 * self._ID24872;
        }
    }
    else
        var_26 = var_11.origin;

    var_26 = maps\mp\agents\_scriptedagents::droppostoground( var_26 );

    if ( !isdefined( var_26 ) )
        return self.origin;

    if ( self._ID5139 && distance2dsquared( var_26, self._ID19520 ) < 4 )
        return self.origin;

    return var_26;
}

_ID9815( var_0 )
{
    self endon( "death" );
    var_0 common_scripts\utility::_ID35626( "disconnect", "joined_team" );
    self notify( "owner_disconnect" );

    if ( maps\mp\gametypes\_hostmigration::_ID35770() )
        wait 0.05;

    self notify( "killanimscript" );

    if ( isdefined( self.animcbs._ID22830[self.aistate] ) )
        self [[ self.animcbs._ID22830[self.aistate] ]]();

    self suicide();
}

watchattackstate()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( self.aistate == "melee" )
        {
            if ( self.attackstate != "melee" )
            {
                self.attackstate = "melee";
                _ID28875( undefined );
            }
        }
        else if ( self._ID21670 == "pursuit" )
        {
            if ( self.attackstate != "attacking" )
            {
                self.attackstate = "attacking";
                _ID28875( "bark", "attacking" );
            }
        }
        else if ( self.attackstate != "warning" )
        {
            if ( _ID35844() )
            {
                self.attackstate = "warning";
                _ID28875( "growl", "warning" );
            }
            else
            {
                self.attackstate = self.aistate;
                _ID28875( "pant" );
            }
        }
        else if ( !_ID35844() )
        {
            self.attackstate = self.aistate;
            _ID28875( "pant" );
        }

        wait 0.05;
    }
}

_ID28875( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
    {
        self notify( "end_dog_sound" );
        self._ID30500 = undefined;
        return;
    }

    if ( !isdefined( self._ID30500 ) || self._ID30500 != var_0 )
    {
        self notify( "end_dog_sound" );
        self._ID30500 = var_0;

        if ( var_0 == "bark" )
        {
            thread _ID23885( var_1 );
            return;
        }

        if ( var_0 == "growl" )
        {
            thread playgrowl( var_1 );
            return;
        }

        if ( var_0 == "pant" )
        {
            thread playpanting();
            return;
        }

        return;
        return;
        return;
        return;
    }
}

_ID23885( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "end_dog_sound" );

    if ( !isdefined( self.barking_sound ) )
    {
        self playsoundonmovingent( common_scripts\utility::_ID32831( self._ID36783, "anml_wolf_bark", "anml_dog_bark" ) );
        self.barking_sound = 1;
        thread _ID36040();
        return;
    }
}

_ID36040()
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "end_dog_sound" );
    wait(randomintrange( 5, 10 ));
    self.barking_sound = undefined;
}

playgrowl( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "end_dog_sound" );

    if ( isdefined( self._ID19562 ) && gettime() - self._ID19562 < 3000 )
        wait 3;

    for (;;)
    {
        self._ID19562 = gettime();
        self playsoundonmovingent( common_scripts\utility::_ID32831( self._ID36783, "anml_wolf_growl", "anml_dog_growl" ) );
        wait(randomintrange( 3, 6 ));
    }
}

playpanting( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "end_dog_sound" );

    if ( isdefined( self._ID19590 ) && gettime() - self._ID19590 < 3000 )
        wait 3;

    self._ID19590 = gettime();

    for (;;)
    {
        if ( self.aistate == "idle" )
        {
            wait 3;
            continue;
        }

        self._ID19590 = gettime();

        if ( self.movemode == "run" || self.movemode == "sprint" )
            self playsoundonmovingent( common_scripts\utility::_ID32831( self._ID36783, "anml_wolf_pants_mp_fast", "anml_dog_pants_mp_fast" ) );
        else
            self playsoundonmovingent( common_scripts\utility::_ID32831( self._ID36783, "anml_wolf_pants_mp_med", "anml_dog_pants_mp_med" ) );

        wait(randomintrange( 6, 8 ));
    }
}

_ID36105()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( !isdefined( self.owner ) )
            return;

        self.owner waittill( "damage",  var_0, var_1  );

        if ( isplayer( var_1 ) && var_1 != self.owner )
        {
            if ( self.attackstate == "attacking" )
                continue;

            if ( distancesquared( self.owner.origin, self.origin ) > self._ID23183 )
                continue;

            if ( distancesquared( self.owner.origin, var_1.origin ) > self._ID23183 )
                continue;

            self.favoriteenemy = var_1;
            self._ID13507 = 1;
            thread _ID36068();
        }
    }
}

_ID36106()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( !isdefined( self.owner ) )
            return;

        self.owner waittill( "death" );

        switch ( level._ID14086 )
        {
            case "sd":
                maps\mp\agents\_agent_utility::_ID19221();
                continue;
            case "sr":
                var_0 = level common_scripts\utility::_ID35635( "sr_player_eliminated", "sr_player_respawned" );

                if ( isdefined( var_0 ) && var_0 == "sr_player_eliminated" )
                    maps\mp\agents\_agent_utility::_ID19221();

                continue;
        }
    }
}

_ID36108()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( !isdefined( self.owner ) )
            return;

        var_0 = self.owner common_scripts\utility::waittill_any_return_no_endon_death( "joined_team", "joined_spectators" );

        if ( isdefined( var_0 ) && ( var_0 == "joined_team" || var_0 == "joined_spectators" ) )
            maps\mp\agents\_agent_utility::_ID19221();
    }
}

_ID36068()
{
    self notify( "watchFavoriteEnemyDeath" );
    self endon( "watchFavoriteEnemyDeath" );
    self endon( "death" );
    self.favoriteenemy common_scripts\utility::_ID35637( 5.0, "death", "disconnect" );
    self.favoriteenemy = undefined;
    self._ID13507 = 0;
}

_ID22790( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    self._ID38156 = gettime();

    if ( isdefined( self.owner ) )
        self._ID37069 = vectornormalize( self.origin - self.owner.origin );

    if ( _ID38026( var_2, var_5, var_4 ) )
    {
        switch ( self.aistate )
        {
            case "idle":
                thread maps\mp\agents\dog\_dog_idle::_ID22790( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
                break;
            case "move":
                thread maps\mp\agents\dog\_dog_move::_ID22790( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
                break;
        }

        return;
    }
}

_ID38026( var_0, var_1, var_2 )
{
    if ( isdefined( var_1 ) && weaponclass( var_1 ) == "sniper" )
        return 1;

    if ( isdefined( var_2 ) && isexplosivedamagemod( var_2 ) && var_0 >= 10 )
        return 1;

    if ( isdefined( var_2 ) && var_2 == "MOD_MELEE" )
        return 1;

    if ( isdefined( var_1 ) && var_1 == "concussion_grenade_mp" )
        return 1;

    return 0;
}

_ID21388()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "flashbang",  var_0, var_1, var_2, var_3, var_4, var_5  );

        if ( isdefined( var_3 ) && var_3 == self.owner )
            continue;

        switch ( self.aistate )
        {
            case "idle":
                maps\mp\agents\dog\_dog_idle::_ID22843();
                continue;
            case "move":
                maps\mp\agents\dog\_dog_move::_ID22843();
                continue;
        }
    }
}
