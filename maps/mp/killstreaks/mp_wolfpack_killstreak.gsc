// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["mine_level_killstreak"] = ::tryusewolfpack;
    level._ID19276["killstreak_wolfpack_mp"] = "mine_level_killstreak";
}

_ID28940()
{
    level._ID2507["wolf"] = level._ID2507["dog"];
    level._ID2507["wolf"]["spawn"] = ::_ID30630;
    level._ID2507["wolf"]["on_killed"] = ::_ID22741;
    level._ID2507["wolf"]["on_damaged"] = maps\mp\agents\_agents::_ID22742;
    level._ID2507["wolf"]["on_damaged_finished"] = maps\mp\killstreaks\_dog_killstreak::on_damaged_finished;
    level._ID2507["wolf"]["think"] = ::think_init;
}

tryusewolfpack( var_0, var_1 )
{
    _ID28940();
    return _ID34741();
}

_ID34741()
{
    if ( maps\mp\agents\_agent_utility::getnumownedactiveagents( self ) >= 2 )
    {
        self iprintlnbold( &"KILLSTREAKS_AGENT_MAX" );
        return 0;
    }

    var_0 = getmaxagents();

    if ( maps\mp\agents\_agent_utility::getnumactiveagents() >= var_0 )
    {
        self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE" );
        return 0;
    }

    if ( !maps\mp\_utility::_ID18757( self ) )
        return 0;

    var_1 = spawnwolf( 1 );

    if ( var_1 )
    {
        self playsound( "mp_mine_wolf_spawn" );
        thread maps\mp\_utility::_ID32672( "used_mine_level_killstreak", self );
        thread spawnwolfpack();
    }

    return var_1;
}

spawnwolf( var_0 )
{
    var_1 = maps\mp\agents\_agent_common::_ID7870( "wolf", self.team );

    if ( !isdefined( var_1 ) )
        return 0;

    var_1 maps\mp\agents\_agent_utility::_ID28189( self.team, self );
    var_2 = "wolf_spawn_0" + var_0;
    var_3 = common_scripts\utility::_ID15384( var_2, "targetname" );
    var_4 = var_3.origin;
    var_5 = self.angles;
    var_1.wolfid = var_0;
    var_1.pathnodearray = common_scripts\utility::_ID15386( "wolf_path_0" + var_0, "script_noteworthy" );
    var_1 thread [[ var_1 maps\mp\agents\_agent_utility::agentfunc( "spawn" ) ]]( var_4, var_5, self );
    var_1 maps\mp\_utility::_setnameplatematerial( "player_name_bg_green_dog", "player_name_bg_red_dog" );
    return 1;
}

spawnwolfpack()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    for ( var_0 = 2; var_0 <= 3; var_0++ )
    {
        wait 0.75;
        spawnwolf( var_0 );
    }

    var_1 = 3;

    for (;;)
    {
        level waittill( "wolf_killed",  var_2  );

        if ( var_1 > 0 )
        {
            wait 0.75;
            spawnwolf( var_2 );
            var_1--;
            continue;
        }

        break;
    }
}

_ID22741( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self.isactive = 0;
    self.hasdied = 0;
    var_1.lastkilldogtime = gettime();

    if ( isdefined( self.animcbs._ID22830[self.aistate] ) )
        self [[ self.animcbs._ID22830[self.aistate] ]]();

    if ( isplayer( var_1 ) && isdefined( self.owner ) && var_1 != self.owner )
        maps\mp\gametypes\_damage::onkillstreakkilled( var_1, var_4, var_3, var_2, "destroyed_ks_wolf" );

    self setanimstate( "death" );
    var_9 = self getanimentry();
    var_10 = getanimlength( var_9 );
    var_8 = int( var_10 * 1000 );
    self._ID5433 = self cloneagent( var_8 );
    self playsound( "anml_wolf_shot_death" );
    level notify( "wolf_killed",  self.wolfid  );
    maps\mp\agents\_agent_utility::_ID9023();
    self notify( "killanimscript" );
}

_ID30630( var_0, var_1, var_2 )
{
    var_3 = 1;
    var_4 = "mp_fullbody_wolf_c";
    var_5 = 1;

    if ( self.wolfid == 1 )
    {
        var_4 = "mp_fullbody_wolf_b";
        var_5 = 0;
    }

    if ( ishairrunning() )
        var_4 += "_fur";

    self setmodel( var_4 );
    self.species = "dog";
    self._ID22818 = maps\mp\agents\dog\_dog_think::_ID22818;

    if ( isdefined( var_0 ) && isdefined( var_1 ) )
    {
        var_6 = var_0;
        var_7 = var_1;
    }
    else
    {
        var_8 = self [[ level.getspawnpoint ]]();
        var_6 = var_8.origin;
        var_7 = var_8.angles;
    }

    maps\mp\agents\_agent_utility::activateagent();
    self._ID30916 = gettime();
    self.lastspawntime = gettime();
    self._ID36783 = 1;
    var_9 = "wolf_animclass";
    maps\mp\agents\dog\_dog_think::_ID17631();
    self._ID36038 = ::watchattackstate;
    self spawnagent( var_6, var_7, var_9, 15, 40, var_2 );
    level notify( "spawned_agent",  self  );
    maps\mp\agents\_agent_common::_ID28188( 200 );

    if ( isdefined( var_2 ) )
        maps\mp\agents\_agent_utility::_ID28189( var_2.team, var_2 );

    self setthreatbiasgroup( "Dogs" );
    self takeallweapons();

    if ( isdefined( self.owner ) )
    {
        self hide();
        wait 1.0;

        if ( !isalive( self ) )
            return;

        self show();
    }

    self thread [[ maps\mp\agents\_agent_utility::agentfunc( "think" ) ]]();
    wait 0.1;

    if ( ishairrunning() )
    {
        var_10 = level._ID38305[var_5];
        playfxontag( var_10, self, "tag_origin" );
    }
}

think_init()
{
    maps\mp\agents\dog\_dog_think::_ID29173();
    self.wolfgoalpos = get_closest( self.origin, self.pathnodearray );
    thread _ID32903();
    thread maps\mp\agents\dog\_dog_think::_ID36106();
    thread maps\mp\agents\dog\_dog_think::_ID36108();
    thread maps\mp\agents\dog\_dog_think::_ID35542();
    thread maps\mp\agents\dog\_dog_think::_ID35563();
}

_ID32903()
{
    self endon( "death" );
    level endon( "game_ended" );

    if ( isdefined( self.owner ) )
    {
        self endon( "owner_disconnect" );
        thread maps\mp\agents\dog\_dog_think::_ID9815( self.owner );
    }

    self thread [[ self._ID36038 ]]();
    thread maps\mp\agents\dog\_dog_think::_ID21388();

    for (;;)
    {
        if ( self.aistate != "melee" && !self.statelocked && maps\mp\agents\dog\_dog_think::_ID25562() && !maps\mp\agents\dog\_dog_think::didpastmeleefail() )
            self scragentbeginmelee( self.curmeleetarget );

        switch ( self.aistate )
        {
            case "idle":
                _ID34564();
                break;
            case "move":
                _ID34564();
                break;
            case "melee":
                maps\mp\agents\dog\_dog_think::_ID34561();
                break;
        }

        wait 0.05;
    }
}

_ID34564()
{
    _ID34568();
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
        self._ID21670 = maps\mp\agents\dog\_dog_think::_ID15159();

    if ( self._ID21670 == "pursuit" )
    {
        var_0 = maps\mp\agents\dog\_dog_think::getattackpoint( self.enemy );
        var_4 = 0;

        if ( isdefined( self._ID19522 ) && gettime() - self._ID19522 < 3000 )
        {
            if ( distance2dsquared( var_0, self._ID19520 ) < 16 )
                var_4 = 1;
            else if ( isdefined( self._ID19521 ) && self._ID19521 == "pursuit" && distance2dsquared( self._ID19523, self.enemy.origin ) < 16 )
                var_4 = 1;
        }

        if ( !maps\mp\_utility::_ID18757( self.enemy ) || var_4 || maps\mp\agents\dog\_dog_think::_ID35845( 1 ) || maps\mp\agents\dog\_dog_think::didpastpursuitfail( self.enemy ) )
        {
            self._ID21670 = "follow";
            var_2 = 1;
        }
    }

    maps\mp\agents\dog\_dog_think::_ID28816( var_2 );

    if ( self._ID21670 == "follow" )
    {
        self.curmeleetarget = undefined;
        self.movemode = maps\mp\agents\dog\_dog_think::getfollowmovemode( self.movemode );
        self._ID4803 = 1;
        var_5 = self getpathgoalpos();

        if ( !isdefined( var_5 ) )
            var_5 = self.origin;

        if ( gettime() - self._ID38156 < 5000 )
            var_1 = 1;

        var_6 = distance2dsquared( self.origin, self.wolfgoalpos.origin );

        if ( var_6 < 800 )
            picknewlocation();

        self scragentsetgoalpos( self.wolfgoalpos.origin );

        if ( var_1 == 1 )
        {
            self scragentsetgoalpos( self.origin );
            return;
        }
    }
    else if ( self._ID21670 == "pursuit" )
    {
        self.curmeleetarget = self.enemy;
        self.movemode = "sprint";
        self._ID4803 = 0;
        self scragentsetgoalpos( var_0 );
    }
}

picknewlocation()
{
    self.wolfgoalpos = common_scripts\utility::_ID15384( self.wolfgoalpos.target, "targetname" );
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
            if ( maps\mp\agents\dog\_dog_think::_ID35844() )
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
        else if ( !maps\mp\agents\dog\_dog_think::_ID35844() )
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
            thread _ID23885( var_1 );
        else if ( var_0 == "growl" )
            thread playgrowl( var_1 );
        else if ( var_0 == "pant" )
            thread maps\mp\agents\dog\_dog_think::playpanting();
        else
        {

        }
    }
}

_ID23885( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "end_dog_sound" );

    if ( !isdefined( self.barking_sound ) )
    {
        self playsoundonmovingent( "mine_wolf_bark" );
        self.barking_sound = 1;
        _ID36040();
    }
}

_ID36040()
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "end_dog_sound" );
    wait(randomintrange( 4, 6 ));
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
        self playsoundonmovingent( "mine_wolf_growl" );
        wait(randomintrange( 3, 6 ));
    }
}
