// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    setupalienstate();
    thread _ID32903();
    thread _ID36105();
    thread _ID36106();
    thread _ID36108();
    thread _ID35542();
    thread _ID35563();
}

setupalienstate()
{
    self.blockgoalpos = 0;
    self.ownerradiussq = 20736;
    self._ID20904 = 8100;
    self.attackoffset = 25 + self.radius;
    self.attackradiussq = 202500;
    self._ID35890 = 302500;
    self._ID35891 = 96.0;
    self.attackzheight = 54;
    self._ID36750 = -64;
    self._ID23183 = 2250000;
    self.dogdamagedradiussq = 42250000;
    self._ID19106 = 36000000;
    self._ID24872 = 76;
    self._ID21127 = 50;
    self._ID13507 = 1;
    self.ignoreclosefoliage = 1;
    self.movemode = "run";
    self.enableextendedkill = 1;
    self.attackstate = "idle";
    self._ID21670 = "idle";
    self._ID5139 = 0;
    self._ID38156 = 0;
    self.alien_goalpos = get_closest( self.origin, self.pathnodearray );
    self.allowcrouch = 1;
    self scragentsetgoalradius( 24 );
}

_ID17631()
{
    self.animcbs = spawnstruct();
    self.animcbs.onenter = [];
    self.animcbs.onenter["idle"] = maps\mp\mp_dome_ns_alien_idle::_ID20445;
    self.animcbs.onenter["move"] = maps\mp\mp_dome_ns_alien_move::_ID20445;
    self.animcbs.onenter["traverse"] = maps\mp\mp_dome_ns_alien_traverse::_ID20445;
    self.animcbs._ID22830 = [];
    self.animcbs._ID22830["idle"] = maps\mp\mp_dome_ns_alien_idle::end_script;
    self.animcbs._ID22830["move"] = maps\mp\mp_dome_ns_alien_move::end_script;
    self.animcbs._ID22830["traverse"] = maps\mp\mp_dome_ns_alien_traverse::end_script;
    self suicide();
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

    if ( var_0 == var_1 && var_1 != "alien_traverse" )
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
        if ( !self.statelocked && _ID25562() )
        {
            mp_dome_ns_alien_explode( self.curmeleetarget );
            return;
        }

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

mp_dome_ns_alien_explode( var_0, var_1, var_2, var_3 )
{
    self emissiveblend( 0.2, 1.0 );
    playfx( level._ID1644["vfx_alien_minion_explode_dome"], self.origin );
    var_4 = 2;
    var_5 = 1;

    if ( !isdefined( var_1 ) )
        var_1 = 400;

    if ( !isdefined( var_2 ) )
        var_2 = 380;

    if ( isdefined( var_3 ) )
        var_3 radiusdamage( self.origin, var_2, var_1, var_5, var_3, "MOD_EXPLOSIVE", "killstreak_level_event_mp" );
    else if ( isdefined( self.owner ) )
        self radiusdamage( self.origin, var_2, var_1, var_5, self.owner, "MOD_EXPLOSIVE", "killstreak_level_event_mp" );
    else
        self radiusdamage( self.origin, var_2, var_1, var_5, undefined, "MOD_EXPLOSIVE", "killstreak_level_event_mp" );

    self playsound( "alien_minion_explode" );
    physicsexplosionsphere( self.origin, var_2, var_2 / 2, var_4 );
    maps\mp\gametypes\_shellshock::barrel_earthquake();
    self notify( "killanimscript" );
    self setanimstate( "explode", 0, 1 );
    wait(getanimlength( self getanimentry( "explode", 0 ) ));

    if ( isdefined( self ) )
    {
        self suicide();
        return;
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

        if ( gettime() - self._ID38156 < 5000 )
            var_1 = 1;

        var_6 = distance2dsquared( self.origin, self.alien_goalpos.origin );

        if ( var_6 < 800 )
            picknewlocation();

        self scragentsetgoalpos( self.alien_goalpos.origin );

        if ( var_1 == 1 )
        {
            self scragentsetgoalpos( self.origin );
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

picknewlocation()
{
    self.alien_goalpos = common_scripts\utility::_ID15384( self.alien_goalpos.target, "targetname" );
}

_ID15159( var_0 )
{
    if ( isdefined( self.enemy ) )
    {
        if ( !maps\mp\_utility::_ID18757( self.enemy ) )
            return "follow";

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
    var_1 = 122500;
    var_2 = 160000;
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

_ID9815( var_0 )
{
    self endon( "death" );
    var_0 common_scripts\utility::_ID35626( "disconnect", "joined_team", "joined_spectators" );
    self notify( "owner_disconnect" );

    if ( maps\mp\gametypes\_hostmigration::_ID35770() )
        wait 0.05;

    self notify( "killanimscript" );

    if ( isdefined( self.animcbs._ID22830[self.aistate] ) )
        self [[ self.animcbs._ID22830[self.aistate] ]]();

    mp_dome_ns_alien_explode( undefined, 1, 0 );
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
        self playsoundonmovingent( "alien_minion_attack" );
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
        self playsoundonmovingent( "alien_minion_attack" );
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
            self playsoundonmovingent( "alien_minion_idle" );
        else
            self playsoundonmovingent( "alien_minion_idle" );

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
                thread maps\mp\mp_dome_ns_alien_idle::_ID22790( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
                break;
            case "move":
                thread maps\mp\mp_dome_ns_alien_move::_ID22790( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
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
                maps\mp\mp_dome_ns_alien_idle::_ID22843();
                continue;
            case "move":
                maps\mp\mp_dome_ns_alien_move::_ID22843();
                continue;
        }
    }
}

get_closest( var_0, var_1, var_2 )
{
    var_3 = var_1[0];
    var_4 = distance( var_0, var_3.origin );

    for ( var_5 = 0; var_5 < var_1.size; var_5++ )
    {
        var_6 = distance( var_0, var_1[var_5].origin );

        if ( var_6 >= var_4 )
            continue;

        var_4 = var_6;
        var_3 = var_1[var_5];
    }

    if ( !isdefined( var_2 ) || var_4 <= var_2 )
        return var_3;

    return undefined;
}
