// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level thread populateintelchallenges();
    level._ID18042 = 0;

    if ( !isdefined( level._ID32097 ) || level._ID32097 )
        level thread _ID22877();

    if ( isdefined( level.enableteamintel ) && isdefined( level.enableteamintel ) )
    {
        level thread runteamintel();
        return;
    }
}

populateintelchallenges()
{
    level endon( "game_ended" );
    wait 0.05;
    level._ID18045 = [];
    var_0 = level._ID14086 == "sd" || level._ID14086 == "sr";
    var_1 = 0;

    for (;;)
    {
        var_2 = tablelookupbyrow( "mp/intelChallenges.csv", var_1, 0 );
        var_3 = int( tablelookupbyrow( "mp/intelChallenges.csv", var_1, 2 ) );
        var_4 = int( tablelookupbyrow( "mp/intelChallenges.csv", var_1, 3 ) );
        var_5 = int( tablelookupbyrow( "mp/intelChallenges.csv", var_1, 4 ) ) == 1;
        var_6 = int( tablelookupbyrow( "mp/intelChallenges.csv", var_1, 5 ) ) == 1;
        var_7 = int( tablelookupbyrow( "mp/intelChallenges.csv", var_1, 6 ) ) == 1;
        var_1++;

        if ( var_2 == "" )
            break;

        if ( var_0 && !var_5 )
            continue;

        level._ID18045[var_2] = spawnstruct();
        level._ID18045[var_2]._ID6854 = var_2;
        level._ID18045[var_2].challengereward = var_3;
        level._ID18045[var_2].challengetarget = var_4;
        level._ID18045[var_2]._ID32654 = var_6;
        level._ID18045[var_2].juggchallenge = var_7;
    }
}

runteamintel()
{
    level endon( "game_ended" );
    level.nummeleekillsintel = 0;
    level.numheadshotsintel = 0;
    level.numkillstreakkillsintel = 0;
    level.numequipmentkillsintel = 0;

    for (;;)
    {
        level waittill( "giveTeamIntel",  var_0  );
        var_1 = [];

        foreach ( var_3 in level._ID18045 )
        {
            if ( !var_3._ID32654 )
                continue;

            var_1[var_1.size] = var_3;
        }

        var_5 = var_1[randomint( var_1.size )];
        var_6 = var_5._ID6854;
        level maps\mp\gametypes\_intelchallenges::_ID15634( var_6, var_0 );
    }
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread _ID18048();
    }
}

_ID18048( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "death",  var_1  );

        if ( isdefined( self._ID16405 ) && self._ID16405 )
        {
            if ( isdefined( self._ID22850 ) && self._ID22850 || self.sessionstate == "spectator" )
            {
                self._ID16405 = 0;
                level thread _ID25349();
            }
            else
                _ID22811();

            continue;
        }

        if ( !level._ID18042 )
        {
            if ( level._ID32653 && isdefined( var_1 ) && isdefined( var_1.team ) && var_1.team == self.team )
                continue;

            level._ID18042 = 1;
            _ID22811( 1 );
        }
    }
}

_ID22811( var_0 )
{
    self._ID16405 = 0;

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    var_1 = self.origin;

    if ( isdefined( self._ID37518 ) )
    {
        var_1 = self._ID37518;
        self._ID37518 = undefined;
    }

    var_2 = getgroundposition( var_1, 42, 1000, 72 );
    var_3 = var_1 + ( 0, 0, 32 );

    if ( var_0 )
    {
        var_4 = spawn( "script_model", var_3 );
        var_4.angles = ( 0, 0, 0 );
        var_4 setmodel( "com_metal_briefcase_intel" );
        var_5 = spawn( "trigger_radius", var_1, 0, 96, 60 );
        var_5._ID17334 = "intel";
        var_6 = [];
        var_6["visuals"] = var_4;
        var_6["trigger"] = var_5;
        var_6["owner"] = "none";
        var_6["isActive"] = 1;
        var_6["firstTriggerPlayer"] = undefined;
        var_6["useRate"] = 1;
        var_6["useTime"] = 0.5;
        var_6["useProgress"] = 0;
        var_6["dropped_time"] = gettime();
        level._ID18050 = var_6;
        level._ID18050["trigger"] enablelinkto();
    }
    else
    {
        if ( isdefined( level._ID18050["visuals"] getlinkedparent() ) )
        {
            level._ID18050["visuals"] unlink();
            level._ID18050["trigger"] unlink();
        }

        level._ID18050["visuals"] hide();
        level._ID18050["visuals"].origin = var_3;
        level._ID18050["trigger"].origin = var_2;
    }

    if ( level._ID18050["visuals"] maps\mp\_utility::_ID33165() )
    {
        level._ID18050["isActive"] = 0;
        level._ID18050["visuals"] hide();
        level thread _ID25349();
        return;
    }

    level._ID18050["owner"] = "none";
    level._ID18050["isActive"] = 1;
    level._ID18050["dropped_time"] = gettime();
    level._ID18050["visuals"] scriptmodelplayanim( "mp_briefcase_spin" );
    thread _ID18069();
    level._ID18050 thread _ID18049();
}

_ID18047( var_0 )
{
    level._ID18050["isActive"] = 0;
    level._ID18050["visuals"] hide();
    level thread _ID25349();
}

_ID18069()
{
    level notify( "intelTriggerWatcher" );
    level endon( "intelTriggerWatcher" );
    level endon( "game_ended" );
    level._ID18050["visuals"] endon( "pickedUp" );
    var_0 = level._ID18050["trigger"];
    var_1 = spawnstruct();
    var_1.linkparent = self getmovingplatformparent();
    var_1.endonstring = "intelTriggerWatcher";
    var_1.deathoverridecallback = ::_ID18047;
    level._ID18050["visuals"] thread maps\mp\_movers::_ID16165( var_1 );
    level._ID18050["trigger"] linkto( level._ID18050["visuals"] );
    wait 0.05;
    level._ID18050["visuals"] show();

    for (;;)
    {
        var_0 waittill( "trigger",  var_2  );

        if ( !isplayer( var_2 ) )
            continue;

        if ( isai( var_2 ) )
            continue;

        if ( !isalive( var_2 ) || isdefined( var_2.fauxdead ) && var_2.fauxdead )
            continue;

        if ( level._ID18050["isActive"] )
        {
            if ( isdefined( var_2._ID16405 ) && var_2._ID16405 )
                continue;

            var_3 = var_0 _ID25129( var_2 );

            if ( var_3 )
                var_2 _ID22873();
        }
    }
}

_ID18049()
{
    level._ID18050["visuals"] endon( "pickedUp" );

    for (;;)
    {
        if ( gettime() > level._ID18050["dropped_time"] + 60000 )
            break;

        wait 1;
    }

    level._ID18050["isActive"] = 0;
    level._ID18050["visuals"] hide();
    level thread _ID25349();
}

_ID22873()
{
    self._ID16405 = 1;
    level._ID18050["isActive"] = 0;
    level._ID18050["visuals"] hide();
    level._ID18050["owner"] = self;
    var_0 = [];
    thread maps\mp\gametypes\_rank::giverankxp( "challenge", 100 );

    if ( maps\mp\_utility::_ID18666() )
    {
        foreach ( var_2 in level._ID18045 )
        {
            var_3 = var_2._ID6854;

            if ( !var_2.juggchallenge )
                continue;

            if ( isdefined( self._ID18669 ) && self._ID18669 == 1 )
            {
                if ( !issubstr( var_3, "maniac" ) )
                    continue;
            }
            else if ( isdefined( self._ID18670 ) && self._ID18670 == 1 )
            {
                if ( !issubstr( var_3, "recon" ) )
                    continue;
            }
            else if ( !issubstr( var_3, "assault" ) )
                continue;

            var_0[var_0.size] = var_2;
        }
    }
    else
    {
        var_5 = maps\mp\_utility::getotherteam( self.team );
        var_6 = level._ID32656[var_5];
        var_7 = level.alivecount[var_5];
        var_8 = undefined;
        var_8 = getdvarint( "scr_player_lives" ) == 0;
        var_9 = self getweaponslistprimaries();

        foreach ( var_2 in level._ID18045 )
        {
            var_3 = var_2._ID6854;
            var_11 = var_2.challengetarget;

            if ( !var_8 )
            {
                if ( var_3 == "ch_intel_tbag" || var_11 > var_7 )
                    continue;
            }

            if ( var_3 == "ch_intel_secondarykills" && intelcancomplete_secondarykills( self, var_9 ) == 0 )
                continue;

            if ( var_3 == "ch_intel_explosivekill" && intelcancomplete_explosivekill( self, var_9 ) == 0 )
                continue;

            if ( var_2._ID32654 )
                continue;

            if ( var_2.juggchallenge )
                continue;

            var_0[var_0.size] = var_2;
        }
    }

    var_13 = var_0[randomint( var_0.size )];
    var_14 = var_13._ID6854;

    if ( maps\mp\_utility::_ID18666() )
        maps\mp\gametypes\_intelchallenges::givejuggernautchallenge( var_14 );
    else
    {
        maps\mp\gametypes\_intelchallenges::_ID15587( var_14 );
        thread watchforjuggernaut();
    }

    thread _ID36076();
    thread _ID38296();
    level._ID18050["visuals"] notify( "pickedUp" );
}

intelcancomplete_secondarykills( var_0, var_1 )
{
    var_2 = 0;

    foreach ( var_4 in var_1 )
    {
        if ( maps\mp\_utility::_ID18576( var_4 ) )
        {
            if ( var_0 getammocount( var_4 ) > 0 )
            {
                var_2 = 1;
                break;
            }
        }
    }

    return var_2;
}

intelcancomplete_explosivekill( var_0, var_1 )
{
    var_2 = 0;

    if ( self._ID20130 != "specialty_null" && !issubstr( self._ID20130, "throwingknife" ) )
    {
        var_3 = var_0 getammocount( self._ID20130 );

        if ( var_3 > 0 )
            var_2 = 1;
    }

    if ( var_2 == 0 )
    {
        foreach ( var_5 in var_1 )
        {
            var_6 = weaponclass( var_5 );

            if ( ( var_6 == "rocketlauncher" || var_6 == "grenade" ) && var_0 getammocount( var_5 ) > 0 )
            {
                var_2 = 1;
                break;
                continue;
            }

            var_7 = weaponaltweaponname( var_5 );

            if ( isdefined( var_7 ) && weaponclass( var_7 ) == "grenade" && var_0 getammocount( var_7 ) > 0 )
            {
                var_2 = 1;
                break;
            }
        }
    }

    return var_2;
}

watchforjuggernaut()
{
    self endon( "death" );
    self endon( "intel_cleanup" );

    for (;;)
    {
        level waittill( "juggernaut_equipped" );
        waittillframeend;

        if ( maps\mp\_utility::_ID18666() )
            thread updatejuggintel();
    }
}

updatejuggintel()
{
    self notify( "intel_cleanup" );
    self setclientomnvar( "ui_intel_active_index", -1 );
    _ID22873();
}

_ID36076()
{
    self endon( "death" );
    self endon( "intel_cleanup" );
    self waittill( "disconnect" );
    level thread _ID25349();
}

_ID38296()
{
    self endon( "death" );
    self endon( "intel_cleanup" );
    self endon( "stopped_using_remote" );
    self waittill( "using_remote" );
    self._ID37518 = self.origin;
    thread _ID38229();
}

_ID38229()
{
    self endon( "death" );
    self endon( "intel_cleanup" );
    self waittill( "stopped_using_remote" );
    self._ID37518 = undefined;
    thread _ID38296();
}

_ID25349()
{
    level notify( "randAssignIntel" );
    level endon( "randAssignIntel" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 1;
        var_0 = maps\mp\_utility::getrandomplayingplayer();

        if ( !isdefined( var_0 ) )
            continue;

        var_0._ID16405 = 1;
        level._ID18050["owner"] = var_0;
        var_0 thread _ID36076();
        break;
    }
}

_ID4597( var_0 )
{
    self endon( "disconnect" );
    _ID26052();
    self._ID16405 = 0;
    var_1 = level._ID18045[var_0];
    var_2 = var_1._ID6854;
    var_3 = int( var_1.challengereward );
    self setclientomnvar( "ui_intel_active_index", -1 );
    thread maps\mp\killstreaks\_killstreaks::_ID15602( "airdrop_assault", 0, 0, self );
    thread maps\mp\gametypes\_hud_message::_ID31053( var_2, var_3 );
    thread maps\mp\gametypes\_rank::giverankxp( "intel", var_3 );
    level thread _ID25349();
    self thread [[ level._ID19766 ]]( "achieve_carepackage", undefined, undefined, self.origin );
    maps\mp\gametypes\_missions::_ID25038( "ch_intelligence" );
    self notify( "intel_cleanup" );
}

_ID26052()
{
    var_0 = self getweaponslistall();

    foreach ( var_2 in var_0 )
    {
        if ( maps\mp\_utility::_ID18679( var_2 ) )
        {
            continue;
            continue;
        }

        if ( weaponinventorytype( var_2 ) == "offhand" )
        {
            if ( var_2 == self._ID20130 && maps\mp\_utility::_hasperk( "specialty_extra_deadly" ) || var_2 == self.loadoutperkoffhand && maps\mp\_utility::_hasperk( "specialty_extra_equipment" ) )
                self setweaponammoclip( var_2, 2 );
            else
                self setweaponammoclip( var_2, 1 );

            continue;
        }

        self givemaxammo( var_2 );
    }
}

_ID25129( var_0 )
{
    if ( !isdefined( self ) )
        return 0;

    self._ID18318 = 1;
    var_1 = _ID25130( var_0 );

    if ( !isdefined( self ) )
        return 0;

    level._ID18050["useProgress"] = 0;
    return var_1;
}

_ID25130( var_0 )
{
    self._ID34766 = level._ID18050["useRate"];
    self._ID34780 = level._ID18050["useTime"];
    self.curprogress = 0;

    while ( !level.gameended && isdefined( self ) && maps\mp\_utility::_ID18757( var_0 ) )
    {
        if ( distance2dsquared( self.origin, var_0.origin ) > 36864 )
            break;

        level._ID18050["useProgress"] = level._ID18050["useProgress"] + 0.05 * self._ID34766;
        self.curprogress = level._ID18050["useProgress"];
        var_0 maps\mp\gametypes\_gameobjects::_ID34638( self, 1 );

        if ( level._ID18050["useProgress"] >= self._ID34780 )
        {
            var_0 maps\mp\gametypes\_gameobjects::_ID34638( self, 0 );
            return maps\mp\_utility::_ID18757( var_0 );
        }

        wait 0.05;
    }

    var_0 maps\mp\gametypes\_gameobjects::_ID34638( self, 0 );
    return 0;
}
