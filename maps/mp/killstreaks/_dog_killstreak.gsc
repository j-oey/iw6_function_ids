// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["guard_dog"] = ::_ID33845;
}

_ID28940()
{
    level._ID2507["dog"] = level._ID2507["player"];
    level._ID2507["dog"]["spawn"] = ::_ID30630;
    level._ID2507["dog"]["on_killed"] = ::_ID22741;
    level._ID2507["dog"]["on_damaged"] = maps\mp\agents\_agents::_ID22742;
    level._ID2507["dog"]["on_damaged_finished"] = ::on_damaged_finished;
    level._ID2507["dog"]["think"] = maps\mp\agents\dog\_dog_think::_ID20445;
}

_ID33845( var_0, var_1 )
{
    return _ID34741();
}

_ID34741()
{
    if ( isdefined( self.hasdog ) && self.hasdog )
    {
        var_0 = self getcommonplayerdatareservedint( "mp_dog_type" );

        if ( var_0 == 1 )
            self iprintlnbold( &"KILLSTREAKS_ALREADY_HAVE_WOLF" );
        else
            self iprintlnbold( &"KILLSTREAKS_ALREADY_HAVE_DOG" );

        return 0;
    }

    if ( maps\mp\agents\_agent_utility::getnumactiveagents( "dog" ) >= 5 )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_DOGS" );
        return 0;
    }

    if ( maps\mp\agents\_agent_utility::getnumownedactiveagents( self ) >= 2 )
    {
        self iprintlnbold( &"KILLSTREAKS_AGENT_MAX" );
        return 0;
    }

    var_1 = getmaxagents();

    if ( maps\mp\agents\_agent_utility::getnumactiveagents() >= var_1 )
    {
        self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE" );
        return 0;
    }

    if ( !maps\mp\_utility::_ID18757( self ) )
        return 0;

    var_2 = maps\mp\agents\_agent_utility::getvalidspawnpathnodenearplayer( 1 );

    if ( !isdefined( var_2 ) )
        return 0;

    var_3 = maps\mp\agents\_agent_common::_ID7870( "dog", self.team );

    if ( !isdefined( var_3 ) )
        return 0;

    self.hasdog = 1;
    var_3 maps\mp\agents\_agent_utility::_ID28189( self.team, self );
    var_4 = var_2.origin;
    var_5 = vectortoangles( self.origin - var_2.origin );
    var_3 thread [[ var_3 maps\mp\agents\_agent_utility::agentfunc( "spawn" ) ]]( var_4, var_5, self );
    var_3 maps\mp\_utility::_setnameplatematerial( "player_name_bg_green_dog", "player_name_bg_red_dog" );

    if ( isdefined( self.balldrone ) && self.balldrone.balldronetype == "ball_drone_backup" )
        maps\mp\gametypes\_missions::_ID25038( "ch_twiceasdeadly" );

    maps\mp\_matchdata::_ID20253( "guard_dog", self.origin );
    return 1;
}

_ID22741( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self.isactive = 0;
    self.hasdied = 0;

    if ( isdefined( self.owner ) )
        self.owner.hasdog = 0;

    var_1.lastkilldogtime = gettime();

    if ( isdefined( self.animcbs._ID22830[self.aistate] ) )
        self [[ self.animcbs._ID22830[self.aistate] ]]();

    if ( isplayer( var_1 ) && isdefined( self.owner ) && var_1 != self.owner )
    {
        self.owner maps\mp\_utility::_ID19765( "dog_killed" );
        maps\mp\gametypes\_damage::onkillstreakkilled( var_1, var_4, var_3, var_2, "destroyed_guard_dog" );

        if ( isplayer( var_1 ) )
        {
            var_1 maps\mp\gametypes\_missions::_ID25038( "ch_notsobestfriend" );

            if ( !self isonground() )
                var_1 maps\mp\gametypes\_missions::_ID25038( "ch_hoopla" );
        }
    }

    self setanimstate( "death" );
    var_9 = self getanimentry();
    var_10 = getanimlength( var_9 );
    var_8 = int( var_10 * 1000 );
    self._ID5433 = self cloneagent( var_8 );
    self playsound( common_scripts\utility::_ID32831( self._ID36783, "anml_wolf_shot_death", "anml_dog_shot_death" ) );
    maps\mp\agents\_agent_utility::_ID9023();
    self notify( "killanimscript" );
}

on_damaged_finished( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isdefined( self._ID24607 ) )
        thread play_pain_sound( 2.5 );

    var_10 = var_2;

    if ( isdefined( var_8 ) && var_8 == "head" && level._ID14086 != "horde" )
    {
        var_10 = int( var_10 * 0.6 );

        if ( var_2 > 0 && var_10 <= 0 )
            var_10 = 1;
    }

    if ( self.health - var_10 > 0 )
        maps\mp\agents\dog\_dog_think::_ID22790( var_0, var_1, var_10, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

    if ( isplayer( var_1 ) )
    {
        if ( isdefined( self.attackstate ) && self.attackstate != "attacking" )
        {
            if ( distancesquared( self.origin, var_1.origin ) <= self.dogdamagedradiussq )
            {
                self.favoriteenemy = var_1;
                self._ID13507 = 1;
                thread maps\mp\agents\dog\_dog_think::_ID36068();
            }
        }
    }

    maps\mp\agents\_agents::agent_damage_finished( var_0, var_1, var_10, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

play_pain_sound( var_0 )
{
    self endon( "death" );
    self playsound( common_scripts\utility::_ID32831( self._ID36783, "anml_wolf_shot_pain", "anml_dog_shot_pain" ) );
    self._ID24607 = 1;
    wait(var_0);
    self._ID24607 = undefined;
}

_ID30630( var_0, var_1, var_2 )
{
    var_3 = 0;
    var_4 = 0;

    if ( isdefined( var_2 ) )
    {
        if ( isdefined( var_2._ID38111 ) )
            var_3 = var_2._ID38111;
        else
            var_3 = var_2 getcommonplayerdatareservedint( "mp_dog_type" );
    }

    var_5 = "mp_fullbody_dog_a";

    if ( var_3 == 1 )
    {
        if ( var_4 == 0 )
            var_5 = "mp_fullbody_wolf_b";
        else
            var_5 = "mp_fullbody_wolf_c";
    }

    if ( ishairrunning() )
        var_5 += "_fur";

    self setmodel( var_5 );
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
    self._ID36783 = var_3 == 1;
    maps\mp\agents\dog\_dog_think::_ID17631();

    if ( var_3 == 1 )
        var_9 = "wolf_animclass";
    else
        var_9 = "dog_animclass";

    self spawnagent( var_6, var_7, var_9, 15, 40, var_2 );
    level notify( "spawned_agent",  self  );
    maps\mp\agents\_agent_common::_ID28188( 250 );

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
        if ( var_3 == 1 )
            var_10 = level._ID38305[var_4];
        else
            var_10 = level.furfx;

        playfxontag( var_10, self, "tag_origin" );
    }
}
