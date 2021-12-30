// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17970()
{
    var_0 = 1;

    for (;;)
    {
        var_1 = tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"].index_col, var_0, level.global_tables["killstreakTable"]._ID25634 );

        if ( !isdefined( var_1 ) || var_1 == "" )
            break;

        var_2 = tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"].index_col, var_0, level.global_tables["killstreakTable"]._ID25634 );
        var_3 = tablelookupistring( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"].index_col, var_0, level.global_tables["killstreakTable"].earned_hint_col );
        var_4 = tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"].index_col, var_0, level.global_tables["killstreakTable"].earned_dialog_col );
        game["dialog"][var_2] = var_4;
        var_5 = tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"].index_col, var_0, level.global_tables["killstreakTable"].allies_dialog_col );
        game["dialog"]["allies_friendly_" + var_2 + "_inbound"] = "friendly_" + var_5;
        game["dialog"]["allies_enemy_" + var_2 + "_inbound"] = "enemy_" + var_5;
        var_6 = tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"].index_col, var_0, level.global_tables["killstreakTable"].enemy_dialog_col );
        game["dialog"]["axis_friendly_" + var_2 + "_inbound"] = "friendly_" + var_6;
        game["dialog"]["axis_enemy_" + var_2 + "_inbound"] = "enemy_" + var_6;
        var_7 = int( tablelookup( level.global_tables["killstreakTable"]._ID23323, level.global_tables["killstreakTable"].index_col, var_0, level.global_tables["killstreakTable"]._ID27353 ) );
        maps\mp\gametypes\_rank::registerscoreinfo( "killstreak_" + var_2, var_7 );
        var_0++;
    }
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );

        if ( !isdefined( var_0.pers["killstreaks"] ) )
            var_0.pers["killstreaks"] = [];

        if ( !isdefined( var_0.pers["kID"] ) )
            var_0.pers["kID"] = 10;

        var_0._ID19938 = 0;
        var_0.curdefvalue = 0;

        if ( isdefined( var_0.pers["deaths"] ) )
            var_0._ID19938 = var_0.pers["deaths"];

        var_0 visionsetmissilecamforplayer( game["thermal_vision"] );
        var_0 thread onplayerspawned();
        var_0 thread _ID21375();
        var_0._ID31109 = 0;
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    if ( maps\mp\_utility::_ID18363() )
        return;

    for (;;)
    {
        self waittill( "spawned_player" );
        thread _ID19274();
        thread _ID35547();
        thread _ID31892();
        thread _ID31891();

        if ( level.console )
            thread _ID31896();
        else
        {
            thread _ID23412();
            thread _ID23411();
        }

        thread _ID31890();

        if ( !isdefined( self.pers["killstreaks"][0] ) )
            _ID17985();

        if ( !isdefined( self.earnedstreaklevel ) )
            self.earnedstreaklevel = 0;

        if ( game["roundsPlayed"] > 0 && self.adrenaline == 0 )
            self.adrenaline = self getcommonplayerdata( "killstreaksState", "count" );

        setstreakcounttonext();
        updatestreakslots();

        if ( self._ID31894 == "specialist" )
        {
            _ID34610();
            continue;
        }

        _ID15610();
    }
}

_ID17985()
{
    if ( !isdefined( self._ID31894 ) )
        return;

    if ( self._ID31894 == "specialist" )
        self setcommonplayerdata( "killstreaksState", "isSpecialist", 1 );
    else
        self setcommonplayerdata( "killstreaksState", "isSpecialist", 0 );

    var_0 = spawnstruct();
    var_0.available = 0;
    var_0._ID31889 = undefined;
    var_0._ID11210 = 0;
    var_0.awardxp = undefined;
    var_0.owner = undefined;
    var_0._ID19121 = undefined;
    var_0._ID19938 = undefined;
    var_0._ID18639 = 1;
    var_0.isspecialist = 0;
    var_0._ID22012 = undefined;
    self.pers["killstreaks"][0] = var_0;

    for ( var_1 = 1; var_1 < 4; var_1++ )
    {
        var_2 = spawnstruct();
        var_2.available = 0;
        var_2._ID31889 = undefined;
        var_2._ID11210 = 1;
        var_2.awardxp = 1;
        var_2.owner = undefined;
        var_2._ID19121 = undefined;
        var_2._ID19938 = -1;
        var_2._ID18639 = 0;
        var_2.isspecialist = 0;
        self.pers["killstreaks"][var_1] = var_2;
    }

    var_3 = spawnstruct();
    var_3.available = 0;
    var_3._ID31889 = "all_perks_bonus";
    var_3._ID11210 = 1;
    var_3.awardxp = 0;
    var_3.owner = undefined;
    var_3._ID19121 = undefined;
    var_3._ID19938 = -1;
    var_3._ID18639 = 0;
    var_3.isspecialist = 1;
    self.pers["killstreaks"][4] = var_3;

    for ( var_1 = 0; var_1 < 4; var_1++ )
    {
        self setcommonplayerdata( "killstreaksState", "icons", var_1, 0 );
        self setcommonplayerdata( "killstreaksState", "hasStreak", var_1, 0 );
    }

    self setcommonplayerdata( "killstreaksState", "hasStreak", 0, 0 );
    var_4 = 1;

    foreach ( var_6 in self.killstreaks )
    {
        var_7 = self.pers["killstreaks"][var_4];
        var_7._ID31889 = var_6;
        var_7.isspecialist = self._ID31894 == "specialist";
        var_8 = var_7._ID31889;

        if ( self._ID31894 == "specialist" )
        {
            var_9 = strtok( var_7._ID31889, "_" );

            if ( var_9[var_9.size - 1] == "ks" )
            {
                var_10 = undefined;

                foreach ( var_12 in var_9 )
                {
                    if ( var_12 != "ks" )
                    {
                        if ( !isdefined( var_10 ) )
                        {
                            var_10 = var_12;
                            continue;
                        }

                        var_10 += ( "_" + var_12 );
                    }
                }

                if ( maps\mp\_utility::_ID18801( var_7._ID31889, "_" ) )
                    var_10 = "_" + var_10;

                if ( isdefined( var_10 ) && maps\mp\gametypes\_class::getperkupgrade( var_10 ) != "specialty_null" )
                    var_8 = var_7._ID31889 + "_pro";
            }
        }

        self setcommonplayerdata( "killstreaksState", "icons", var_4, maps\mp\_utility::_ID15099( var_8 ) );
        self setcommonplayerdata( "killstreaksState", "hasStreak", var_4, 0 );
        var_4++;
    }

    self setcommonplayerdata( "killstreaksState", "nextIndex", 1 );
    self setcommonplayerdata( "killstreaksState", "selectedIndex", -1 );
    self setcommonplayerdata( "killstreaksState", "numAvailable", 0 );
    self setcommonplayerdata( "killstreaksState", "hasStreak", 4, 0 );
}

updatestreakcount()
{
    if ( !isdefined( self.pers["killstreaks"] ) )
        return;

    if ( self.adrenaline == self._ID24938 )
        return;

    var_0 = self.adrenaline;
    self setcommonplayerdata( "killstreaksState", "count", self.adrenaline );

    if ( self.adrenaline >= self getcommonplayerdata( "killstreaksState", "countToNext" ) )
        setstreakcounttonext();
}

_ID26141()
{
    self setcommonplayerdata( "killstreaksState", "count", 0 );
    setstreakcounttonext();
}

setstreakcounttonext()
{
    if ( !isdefined( self._ID31894 ) )
    {
        self setcommonplayerdata( "killstreaksState", "countToNext", 0 );
        return;
    }

    if ( getmaxstreakcost() == 0 )
    {
        self setcommonplayerdata( "killstreaksState", "countToNext", 0 );
        return;
    }

    if ( self._ID31894 == "specialist" )
    {
        if ( self.adrenaline >= getmaxstreakcost() )
            return;
    }

    var_0 = _ID15175();

    if ( !isdefined( var_0 ) )
        return;

    var_1 = _ID15382( var_0 );
    self setcommonplayerdata( "killstreaksState", "countToNext", var_1 );
}

_ID15175()
{
    if ( self.adrenaline == getmaxstreakcost() && self._ID31894 != "specialist" )
        var_0 = 0;
    else
        var_0 = self.adrenaline;

    foreach ( var_2 in self.killstreaks )
    {
        var_3 = _ID15382( var_2 );

        if ( var_3 > var_0 )
            return var_2;
    }

    return undefined;
}

getmaxstreakcost()
{
    var_0 = 0;

    foreach ( var_2 in self.killstreaks )
    {
        var_3 = _ID15382( var_2 );

        if ( var_3 > var_0 )
            var_0 = var_3;
    }

    return var_0;
}

updatestreakslots()
{
    if ( !isdefined( self._ID31894 ) )
        return;

    if ( !maps\mp\_utility::_ID18757( self ) )
        return;

    var_0 = self.pers["killstreaks"];
    var_1 = 0;

    for ( var_2 = 0; var_2 < 4; var_2++ )
    {
        if ( isdefined( var_0[var_2] ) && isdefined( var_0[var_2]._ID31889 ) )
        {
            self setcommonplayerdata( "killstreaksState", "hasStreak", var_2, var_0[var_2].available );

            if ( var_0[var_2].available == 1 )
                var_1++;

            if ( isdefined( level._ID26011 ) && level._ID26011 && !var_0[var_2].available )
                self setcommonplayerdata( "killstreaksState", "icons", var_2, 0 );
        }
    }

    if ( self._ID31894 != "specialist" )
        self setcommonplayerdata( "killstreaksState", "numAvailable", var_1 );

    var_3 = self.earnedstreaklevel;
    var_4 = getmaxstreakcost();

    if ( self.earnedstreaklevel == var_4 && self._ID31894 != "specialist" )
        var_3 = 0;

    var_5 = 1;

    foreach ( var_7 in self.killstreaks )
    {
        var_8 = _ID15382( var_7 );

        if ( var_8 > var_3 )
        {
            var_9 = var_7;
            break;
        }

        if ( self._ID31894 == "specialist" )
        {
            if ( self.earnedstreaklevel == var_4 )
                break;
        }

        var_5++;
    }

    self setcommonplayerdata( "killstreaksState", "nextIndex", var_5 );

    if ( isdefined( self._ID19258 ) && self._ID31894 != "specialist" )
        self setcommonplayerdata( "killstreaksState", "selectedIndex", self._ID19258 );
    else if ( self._ID31894 == "specialist" && var_0[0].available )
        self setcommonplayerdata( "killstreaksState", "selectedIndex", 0 );
    else
        self setcommonplayerdata( "killstreaksState", "selectedIndex", -1 );
}

_ID35547()
{
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self notify( "waitForChangeTeam" );
    self endon( "waitForChangeTeam" );

    for (;;)
    {
        self waittill( "joined_team" );
        clearkillstreaks();
    }
}

killstreakusepressed()
{
    var_0 = self.pers["killstreaks"];
    var_1 = var_0[self._ID19258]._ID31889;
    var_2 = var_0[self._ID19258]._ID19938;
    var_3 = var_0[self._ID19258]._ID11210;
    var_4 = var_0[self._ID19258].awardxp;
    var_5 = var_0[self._ID19258]._ID19121;
    var_6 = var_0[self._ID19258]._ID18639;

    if ( !maps\mp\_utility::_ID34840() )
        return 0;

    if ( !self [[ level._ID19256[var_1] ]]( var_2, var_1 ) )
        return 0;

    thread _ID34551();
    _ID34739( var_1, var_4 );
    return 1;
}

_ID34739( var_0, var_1 )
{
    if ( var_1 )
    {
        self thread [[ level._ID22924 ]]( "killstreak_" + var_0 );
        thread maps\mp\gametypes\_missions::_ID34746( var_0 );
    }

    var_2 = maps\mp\_awards::getkillstreakawardref( var_0 );

    if ( isdefined( var_2 ) )
        thread maps\mp\_utility::_ID17531( var_2, 1 );

    if ( maps\mp\_utility::isassaultkillstreak( var_0 ) )
        thread maps\mp\_utility::_ID17531( "assaultkillstreaksused", 1 );
    else if ( maps\mp\_utility::issupportkillstreak( var_0 ) )
        thread maps\mp\_utility::_ID17531( "supportkillstreaksused", 1 );
    else if ( maps\mp\_utility::_ID18795( var_0 ) )
    {
        thread maps\mp\_utility::_ID17531( "specialistkillstreaksearned", 1 );
        return;
    }

    var_3 = self.team;

    if ( level._ID32653 )
    {
        thread maps\mp\_utility::_ID19760( var_3 + "_friendly_" + var_0 + "_inbound", var_3 );

        if ( maps\mp\_utility::_ID15096( var_0 ) )
        {
            if ( playenemydialog( var_0 ) )
                thread maps\mp\_utility::_ID19760( var_3 + "_enemy_" + var_0 + "_inbound", level._ID23070[var_3] );
        }
    }
    else
    {
        thread maps\mp\_utility::_ID19765( var_3 + "_friendly_" + var_0 + "_inbound" );

        if ( maps\mp\_utility::_ID15096( var_0 ) )
        {
            var_4[0] = self;

            if ( playenemydialog( var_0 ) )
                thread maps\mp\_utility::_ID19760( var_3 + "_enemy_" + var_0 + "_inbound", undefined, undefined, var_4 );
        }
    }
}

playenemydialog( var_0 )
{
    if ( !maps\mp\_utility::_ID18363() )
    {
        if ( level._ID32653 && var_0 == "uplink" && [[ level.comexpfuncs["getRadarStrengthForTeam"] ]]( self.team ) != 1 )
            return 0;
        else if ( !level._ID32653 && var_0 == "uplink" && [[ level.comexpfuncs["getRadarStrengthForPlayer"] ]]( self ) != 2 )
            return 0;
    }

    return 1;
}

_ID34551( var_0 )
{
    if ( isai( self ) && !isdefined( self._ID19258 ) )
        return;

    if ( !isdefined( var_0 ) )
    {
        self.pers["killstreaks"][self._ID19258].available = 0;

        if ( self._ID19258 == 0 )
        {
            self.pers["killstreaks"][self.pers["killstreaks"][0]._ID22012] = undefined;
            var_1 = undefined;
            var_2 = undefined;
            var_3 = self.pers["killstreaks"];

            for ( var_4 = 5; var_4 < var_3.size; var_4++ )
            {
                if ( !isdefined( var_3[var_4] ) || !isdefined( var_3[var_4]._ID31889 ) )
                    continue;

                var_1 = var_3[var_4]._ID31889;
                var_2 = var_3[var_4]._ID19121;
                var_3[0]._ID22012 = var_4;
            }

            if ( isdefined( var_1 ) )
            {
                var_3[0].available = 1;
                var_3[0]._ID31889 = var_1;
                var_3[0]._ID19121 = var_2;
                var_5 = maps\mp\_utility::_ID15099( var_1 );
                self setcommonplayerdata( "killstreaksState", "icons", 0, var_5 );

                if ( !level.console && !common_scripts\utility::_ID18472() )
                {
                    var_6 = maps\mp\_utility::getkillstreakweapon( var_1 );
                    maps\mp\_utility::_setactionslot( 4, "weapon", var_6 );
                }
            }
        }
    }

    var_7 = undefined;

    if ( self._ID31894 == "specialist" )
    {
        if ( self.pers["killstreaks"][0].available )
            var_7 = 0;
    }
    else
    {
        for ( var_4 = 0; var_4 < 4; var_4++ )
        {
            var_8 = self.pers["killstreaks"][var_4];

            if ( isdefined( var_8 ) && isdefined( var_8._ID31889 ) && var_8.available )
                var_7 = var_4;
        }
    }

    if ( isdefined( var_7 ) )
    {
        if ( level.console || common_scripts\utility::_ID18472() )
        {
            self._ID19258 = var_7;
            self.pers["lastEarnedStreak"] = self.pers["killstreaks"][var_7]._ID31889;
            giveselectedkillstreakitem();
        }
        else
        {
            for ( var_4 = 0; var_4 < 4; var_4++ )
            {
                var_8 = self.pers["killstreaks"][var_4];

                if ( isdefined( var_8 ) && isdefined( var_8._ID31889 ) && var_8.available )
                {
                    var_6 = maps\mp\_utility::getkillstreakweapon( var_8._ID31889 );
                    var_9 = self getweaponslistitems();
                    var_10 = 0;

                    for ( var_11 = 0; var_11 < var_9.size; var_11++ )
                    {
                        if ( var_6 == var_9[var_11] )
                        {
                            var_10 = 1;
                            break;
                        }
                    }

                    if ( !var_10 )
                        maps\mp\_utility::_giveweapon( var_6 );
                    else if ( issubstr( var_6, "airdrop_" ) )
                        self setweaponammoclip( var_6, 1 );

                    maps\mp\_utility::_setactionslot( var_4 + 4, "weapon", var_6 );
                }
            }

            self._ID19258 = undefined;
            self.pers["lastEarnedStreak"] = self.pers["killstreaks"][var_7]._ID31889;
            updatestreakslots();
        }
    }
    else
    {
        self._ID19258 = undefined;
        self.pers["lastEarnedStreak"] = undefined;
        updatestreakslots();
    }
}

clearkillstreaks()
{
    var_0 = self.pers["killstreaks"];

    if ( !isdefined( var_0 ) )
        return;

    for ( var_1 = var_0.size - 1; var_1 > -1; var_1-- )
        self.pers["killstreaks"][var_1] = undefined;

    _ID17985();
    _ID26116();
    self._ID19258 = undefined;
    updatestreakslots();
}

_ID34610()
{
    if ( self.adrenaline == 0 )
    {
        for ( var_0 = 1; var_0 < 4; var_0++ )
        {
            if ( isdefined( self.pers["killstreaks"][var_0] ) )
            {
                self.pers["killstreaks"][var_0].available = 0;
                self setcommonplayerdata( "killstreaksState", "hasStreak", var_0, 0 );
            }
        }

        self setcommonplayerdata( "killstreaksState", "nextIndex", 1 );
        self setcommonplayerdata( "killstreaksState", "hasStreak", 4, 0 );
    }
    else
    {
        for ( var_0 = 1; var_0 < 4; var_0++ )
        {
            var_1 = self.pers["killstreaks"][var_0];

            if ( isdefined( var_1 ) && isdefined( var_1._ID31889 ) && var_1.available )
            {
                var_2 = _ID15382( var_1._ID31889 );

                if ( var_2 > self.adrenaline )
                {
                    self.pers["killstreaks"][var_0].available = 0;
                    self setcommonplayerdata( "killstreaksState", "hasStreak", var_0, 0 );
                    continue;
                }

                if ( self.adrenaline >= var_2 )
                {
                    if ( self getcommonplayerdata( "killstreaksState", "hasStreak", var_0 ) )
                    {
                        self [[ level._ID19256[var_1._ID31889] ]]( undefined, var_1._ID31889 );
                        continue;
                    }

                    _ID15602( var_1._ID31889, var_1._ID11210, 0, self );
                }
            }
        }

        var_3 = getmaxstreakcost();

        if ( isai( self ) )
            var_3 = self.pers["specialistStreakKills"][2];

        var_4 = int( max( 8, var_3 + 2 ) );

        if ( maps\mp\_utility::_hasperk( "specialty_hardline" ) )
            var_4--;

        if ( self.adrenaline >= var_4 )
        {
            self setcommonplayerdata( "killstreaksState", "hasStreak", 4, 1 );
            givebonusperks();
        }
        else
            self setcommonplayerdata( "killstreaksState", "hasStreak", 4, 0 );
    }

    if ( self.pers["killstreaks"][0].available )
    {
        var_5 = self.pers["killstreaks"][0]._ID31889;
        var_6 = maps\mp\_utility::getkillstreakweapon( var_5 );

        if ( level.console || common_scripts\utility::_ID18472() )
        {
            givekillstreakweapon( var_6 );
            self._ID19258 = 0;
        }
        else
        {
            maps\mp\_utility::_giveweapon( var_6 );
            maps\mp\_utility::_setactionslot( 4, "weapon", var_6 );
            self._ID19258 = undefined;
        }
    }
}

_ID15018()
{
    var_0 = self getweaponslistprimaries();
    return var_0[0];
}

istryingtousekillstreakingimmeslot()
{
    return isdefined( self.tryingtouseks ) && self.tryingtouseks && isdefined( self._ID19258 ) && self._ID19258 == 0;
}

istryingtousekillstreakslot()
{
    return isdefined( self.tryingtouseks ) && self.tryingtouseks && isdefined( self._ID19258 );
}

waitforkillstreakweaponswitchstarted()
{
    self endon( "weapon_switch_invalid" );
    self waittill( "weapon_switch_started",  var_0  );
    self notify( "killstreak_weapon_change",  "switch_started", var_0  );
}

waitforkillstreakweaponswitchinvalid()
{
    self endon( "weapon_switch_started" );
    self waittill( "weapon_switch_invalid",  var_0  );
    self notify( "killstreak_weapon_change",  "switch_invalid", var_0  );
}

waitforkillstreakweaponchange()
{
    childthread waitforkillstreakweaponswitchstarted();
    childthread waitforkillstreakweaponswitchinvalid();
    self waittill( "killstreak_weapon_change",  var_0, var_1  );

    if ( var_0 == "switch_started" )
        return var_1;

    var_2 = maps\mp\_utility::getkillstreakweapon( self.pers["killstreaks"][self._ID19258]._ID31889 );
    self switchtoweapon( var_2 );
    waittillframeend;
    var_3 = undefined;

    if ( isdefined( self.changingweapon ) )
        var_3 = self.changingweapon;
    else
        self waittill( "weapon_switch_started",  var_3  );

    if ( var_3 != var_2 )
        return undefined;

    return var_2;
}

_ID19274()
{
    self endon( "disconnect" );
    self endon( "finish_death" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "spawned" );
    level endon( "game_ended" );
    self notify( "killstreakUseWaiter" );
    self endon( "killstreakUseWaiter" );
    self._ID19573 = 0;

    if ( !isdefined( self.pers["lastEarnedStreak"] ) )
        self.pers["lastEarnedStreak"] = undefined;

    thread _ID12952();
    var_0 = [ "streakUsed", "streakUsed1", "streakUsed2", "streakUsed3", "streakUsed4" ];

    for (;;)
    {
        self.tryingtouseks = undefined;
        var_1 = common_scripts\utility::waittill_any_in_array_return_no_endon_death( var_0 );
        self.tryingtouseks = 1;
        waittillframeend;

        if ( !isdefined( self._ID19258 ) || !isdefined( self.pers["killstreaks"][self._ID19258] ) || !isdefined( self.pers["killstreaks"][self._ID19258]._ID31889 ) )
            continue;

        if ( !maps\mp\_utility::cancustomjuggusekillstreak( self.pers["killstreaks"][self._ID19258]._ID31889 ) )
        {
            maps\mp\_utility::printcustomjuggkillstreakerrormsg();

            if ( var_1 != "streakUsed" )
            {
                var_2 = self getcurrentweapon();
                maps\mp\_utility::_ID32279( var_2 );
            }

            continue;
        }

        if ( self isoffhandweaponreadytothrow() )
            continue;

        if ( isdefined( self.changingweapon ) )
            var_3 = self.changingweapon;
        else
            self waittill( "weapon_switch_started",  var_3  );

        var_4 = maps\mp\_utility::getkillstreakweapon( self.pers["killstreaks"][self._ID19258]._ID31889 );

        if ( var_3 != var_4 )
        {
            thread removeunitializedkillstreakweapon();
            continue;
        }

        beginkillstreakweaponswitch();

        if ( var_3 != self getcurrentweapon() )
        {
            thread killstreakwaitforweaponchange();
            var_5 = common_scripts\utility::_ID35638( 1.5, "ks_weapon_change", "ks_alt_weapon_change" );

            if ( var_5 == "ks_alt_weapon_change" )
                self waittill( "weapon_change",  var_3, var_6  );
            else
                var_3 = self getcurrentweapon();
        }

        if ( !isalive( self ) )
        {
            endkillstreakweaponswitch();
            continue;
        }

        if ( var_3 != var_4 )
        {
            var_7 = self._ID19545;

            if ( maps\mp\_utility::_ID18679( var_3 ) )
            {
                if ( maps\mp\_utility::_ID18666() && maps\mp\_utility::_ID18671( var_3 ) )
                    var_7 = var_3;
                else if ( var_3 == "iw6_gm6helisnipe_mp_gm6scope" )
                    var_7 = var_3;
                else
                    self takeweapon( var_3 );
            }

            self switchtoweapon( var_7 );
            endkillstreakweaponswitch();
            continue;
        }

        self.ks_abouttouse = 1;
        waittillframeend;
        self.ks_abouttouse = undefined;
        var_8 = self.pers["killstreaks"][self._ID19258]._ID31889;
        var_9 = self.pers["killstreaks"][self._ID19258]._ID18639;
        endkillstreakweaponswitch();
        var_5 = killstreakusepressed();
        beginkillstreakweaponswitch();
        var_2 = common_scripts\utility::_ID15114();

        if ( !self hasweapon( var_2 ) )
        {
            if ( maps\mp\_utility::_ID18757( self ) )
                var_2 = _ID15018();
            else
                maps\mp\_utility::_giveweapon( var_2 );
        }

        if ( var_5 )
            thread waittakekillstreakweapon( var_4, var_2 );

        if ( _ID29902( var_5, var_8 ) )
            maps\mp\_utility::_ID32279( var_2 );

        var_10 = self getcurrentweapon();

        while ( var_10 != var_2 )
            self waittill( "weapon_change",  var_10  );

        endkillstreakweaponswitch();
    }
}

removeunitializedkillstreakweapon()
{
    self notify( "removeUnitializedKillstreakWeapon" );
    self endon( "removeUnitializedKillstreakWeapon" );
    self endon( "death" );
    self endon( "disconnect" );
    self waittill( "weapon_change",  var_0  );
    var_1 = isdefined( self._ID19258 ) && isdefined( self.pers["killstreaks"] ) && isdefined( self.pers["killstreaks"][self._ID19258] ) && isdefined( self.pers["killstreaks"][self._ID19258]._ID31889 ) && var_0 == maps\mp\_utility::getkillstreakweapon( self.pers["killstreaks"][self._ID19258]._ID31889 );

    if ( var_1 && !isdefined( self.ks_abouttouse ) )
    {
        self takeweapon( var_0 );
        maps\mp\_utility::_giveweapon( var_0, 0 );
        maps\mp\_utility::_setactionslot( 4, "weapon", var_0 );
        var_2 = common_scripts\utility::_ID15114();

        if ( !self hasweapon( var_2 ) )
            var_2 = _ID15018();

        if ( isdefined( var_2 ) )
            maps\mp\_utility::_ID32279( var_2 );
    }
}

beginkillstreakweaponswitch()
{
    common_scripts\utility::_disableweaponswitch();
    common_scripts\utility::_disableusability();
    thread killstreakweaponswitchwatchhostmigration();
}

endkillstreakweaponswitch()
{
    self notify( "endKillstreakWeaponSwitch" );
    common_scripts\utility::_enableweaponswitch();
    common_scripts\utility::_enableusability();
}

killstreakwaitforweaponchange()
{
    self waittill( "weapon_change",  var_0, var_1  );

    if ( !var_1 )
        self notify( "ks_weapon_change" );
    else
        self notify( "ks_alt_weapon_change" );
}

killstreakweaponswitchwatchhostmigration()
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "endKillstreakWeaponSwitch" );
    level waittill( "host_migration_end" );

    if ( isdefined( self ) )
        self enableweaponswitch();
}

waittakekillstreakweapon( var_0, var_1 )
{
    self endon( "disconnect" );
    self endon( "finish_death" );
    self endon( "joined_team" );
    level endon( "game_ended" );
    self notify( "waitTakeKillstreakWeapon" );
    self endon( "waitTakeKillstreakWeapon" );
    var_2 = self getcurrentweapon() == "none";
    self waittill( "weapon_change",  var_3  );

    if ( var_3 == var_1 )
    {
        _ID32391( var_0 );

        if ( !level.console && !common_scripts\utility::_ID18472() )
            self._ID19258 = undefined;
    }
    else if ( var_3 != var_0 )
        thread waittakekillstreakweapon( var_0, var_1 );
    else if ( var_2 && self getcurrentweapon() == var_0 )
        thread waittakekillstreakweapon( var_0, var_1 );
}

_ID32391( var_0 )
{
    var_1 = 0;
    var_2 = self.pers["killstreaks"];

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        if ( isdefined( var_2[var_3] ) && isdefined( var_2[var_3]._ID31889 ) && var_2[var_3].available )
        {
            if ( !maps\mp\_utility::_ID18795( var_2[var_3]._ID31889 ) && var_0 == maps\mp\_utility::getkillstreakweapon( var_2[var_3]._ID31889 ) )
            {
                var_1 = 1;
                break;
            }
        }
    }

    if ( var_1 )
    {
        if ( level.console || common_scripts\utility::_ID18472() )
        {
            if ( isdefined( self._ID19258 ) && var_0 != maps\mp\_utility::getkillstreakweapon( var_2[self._ID19258]._ID31889 ) )
                self takeweapon( var_0 );
            else if ( isdefined( self._ID19258 ) && var_0 == maps\mp\_utility::getkillstreakweapon( var_2[self._ID19258]._ID31889 ) )
            {
                self takeweapon( var_0 );
                maps\mp\_utility::_giveweapon( var_0, 0 );
                maps\mp\_utility::_setactionslot( 4, "weapon", var_0 );
            }
        }
        else
        {
            self takeweapon( var_0 );
            maps\mp\_utility::_giveweapon( var_0, 0 );
        }
    }
    else
    {
        if ( var_0 == "" )
            return;

        self takeweapon( var_0 );
    }
}

_ID29902( var_0, var_1 )
{
    if ( !var_0 )
        return 1;

    if ( maps\mp\_utility::_ID18765( var_1 ) )
        return 0;

    return 1;
}

_ID12952()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "finishDeathWaiter" );
    self endon( "finishDeathWaiter" );
    self waittill( "death" );
    wait 0.05;
    self notify( "finish_death" );
    self.pers["lastEarnedStreak"] = undefined;
}

checkstreakreward()
{
    foreach ( var_1 in self.killstreaks )
    {
        var_2 = _ID15382( var_1 );

        if ( var_2 > self.adrenaline )
            break;

        if ( self._ID24938 < var_2 && self.adrenaline >= var_2 )
        {
            earnkillstreak( var_1, var_2 );
            break;
        }
    }
}

_ID19255( var_0 )
{
    var_1 = "assault";

    switch ( self._ID31894 )
    {
        case "assault":
            var_1 = "assaultStreaks";
            break;
        case "support":
            var_1 = "supportStreaks";
            break;
        case "specialist":
            var_1 = "specialistStreaks";
            break;
    }

    if ( isdefined( self.class_num ) )
    {
        if ( self getcacplayerdata( "loadouts", self.class_num, var_1, 0 ) == var_0 )
            self._ID13163 = gettime();
        else if ( self getcacplayerdata( "loadouts", self.class_num, var_1, 2 ) == var_0 && isdefined( self._ID13163 ) )
        {
            if ( gettime() - self._ID13163 < 20000 )
                thread maps\mp\gametypes\_missions::_ID14249( "wargasm" );
        }
    }
}

earnkillstreak( var_0, var_1 )
{
    level notify( "gave_killstreak",  var_0  );
    self.earnedstreaklevel = var_1;

    if ( !level.gameended )
    {
        var_2 = undefined;

        if ( self._ID31894 == "specialist" )
        {
            var_3 = getsubstr( var_0, 0, var_0.size - 3 );

            if ( maps\mp\gametypes\_class::_ID18734( var_3 ) )
                var_2 = "pro";
        }

        thread maps\mp\gametypes\_hud_message::_ID19270( var_0, var_1, var_2 );

        if ( maps\mp\_utility::bot_is_fireteam_mode() )
        {
            if ( isdefined( var_2 ) )
                self notify( "bot_killstreak_earned",  var_0 + "_" + var_2, var_1  );
            else
                self notify( "bot_killstreak_earned",  var_0, var_1  );
        }
    }

    thread _ID19255( var_0 );
    self.pers["lastEarnedStreak"] = var_0;
    setstreakcounttonext();
    _ID15602( var_0, 1, 1 );
}

_ID15602( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "joined_team" );
    self endon( "givingLoadout" );
    self endon( "disconnect" );

    if ( !isdefined( var_5 ) )
    {
        var_5 = self.pers["kID"];
        self.pers["kID"]++;
    }

    if ( !isdefined( level._ID19256[var_0] ) )
        return;

    if ( self.team == "spectator" )
        return;

    var_6 = undefined;

    if ( !isdefined( var_1 ) || var_1 == 0 )
    {
        if ( isdefined( var_4 ) )
            var_7 = var_4;
        else
            var_7 = self.pers["killstreaks"].size;

        if ( !isdefined( self.pers["killstreaks"][var_7] ) )
            self.pers["killstreaks"][var_7] = spawnstruct();

        var_8 = 1;

        if ( var_7 > 5 && istryingtousekillstreakingimmeslot() )
        {
            var_8 = 0;
            var_9 = var_7;
            var_10 = var_7 - 1;
            var_11 = self.pers["killstreaks"][var_10];
            var_12 = self.pers["killstreaks"][var_9];
            var_12.available = var_11.available;
            var_12._ID31889 = var_11._ID31889;
            var_12._ID11210 = var_11._ID11210;
            var_12.awardxp = var_11.awardxp;
            var_12.owner = var_11.owner;
            var_12._ID19121 = var_11._ID19121;
            var_12._ID19938 = var_11._ID19938;
            var_12._ID18639 = var_11._ID18639;
            var_12.isspecialist = var_11.isspecialist;
            var_7 = var_10;
        }

        var_13 = self.pers["killstreaks"][var_7];
        var_13.available = 0;
        var_13._ID31889 = var_0;
        var_13._ID11210 = 0;
        var_13.awardxp = isdefined( var_2 ) && var_2;
        var_13.owner = var_3;
        var_13._ID19121 = var_5;
        var_13._ID19938 = -1;
        var_13._ID18639 = 1;
        var_13.isspecialist = 0;

        if ( !var_8 )
        {
            self.pers["killstreaks"][0]._ID22012 = var_7 + 1;
            return;
        }

        if ( !isdefined( var_4 ) )
            var_4 = 0;

        self.pers["killstreaks"][var_4]._ID22012 = var_7;
        self.pers["killstreaks"][var_4]._ID31889 = var_0;
        var_6 = var_4;
        var_14 = maps\mp\_utility::_ID15099( var_0 );
        self setcommonplayerdata( "killstreaksState", "icons", var_4, var_14 );
    }
    else
    {
        for ( var_15 = 1; var_15 < 4; var_15++ )
        {
            var_16 = self.pers["killstreaks"][var_15];

            if ( isdefined( var_16 ) && isdefined( var_16._ID31889 ) && var_0 == var_16._ID31889 )
            {
                var_6 = var_15;
                break;
            }
        }

        if ( !isdefined( var_6 ) )
            return;
    }

    var_17 = self.pers["killstreaks"][var_6];
    var_17.available = 1;
    var_17._ID11210 = isdefined( var_1 ) && var_1;
    var_17.awardxp = isdefined( var_2 ) && var_2;
    var_17.owner = var_3;
    var_17._ID19121 = var_5;

    if ( !var_17._ID11210 )
        var_17._ID19938 = -1;
    else
        var_17._ID19938 = self.pers["deaths"];

    if ( self._ID31894 == "specialist" && var_6 != 0 )
    {
        var_17.isspecialist = 1;

        if ( isdefined( level._ID19256[var_0] ) )
            self [[ level._ID19256[var_0] ]]( -1, var_0 );

        _ID34739( var_0, var_2 );
    }
    else if ( level.console || common_scripts\utility::_ID18472() )
    {
        var_18 = maps\mp\_utility::getkillstreakweapon( var_0 );
        givekillstreakweapon( var_18 );

        if ( isdefined( self._ID19258 ) )
        {
            var_0 = self.pers["killstreaks"][self._ID19258]._ID31889;
            var_19 = maps\mp\_utility::getkillstreakweapon( var_0 );

            if ( !isholdingweapon( var_19 ) )
                self._ID19258 = var_6;
        }
        else
            self._ID19258 = var_6;
    }
    else
    {
        if ( 0 == var_6 && self.pers["killstreaks"][0]._ID22012 > 5 )
        {
            var_20 = self.pers["killstreaks"][0]._ID22012 - 1;
            var_21 = maps\mp\_utility::getkillstreakweapon( self.pers["killstreaks"][var_20]._ID31889 );
            self takeweapon( var_21 );
        }

        var_19 = maps\mp\_utility::getkillstreakweapon( var_0 );
        maps\mp\_utility::_giveweapon( var_19, 0 );
        var_22 = 1;

        if ( isdefined( self._ID19258 ) )
        {
            var_0 = self.pers["killstreaks"][self._ID19258]._ID31889;
            var_19 = maps\mp\_utility::getkillstreakweapon( var_0 );
            var_22 = !isholdingweapon( var_19 ) && self getcurrentweapon() != "none";
        }

        if ( var_22 )
            maps\mp\_utility::_setactionslot( var_6 + 4, "weapon", var_19 );
        else
        {
            maps\mp\_utility::_setactionslot( var_6 + 4, "" );
            self.actionslotenabled[var_6] = 0;
        }
    }

    updatestreakslots();

    if ( isdefined( level._ID19268[var_0] ) )
        self [[ level._ID19268[var_0] ]]();

    if ( isdefined( var_1 ) && var_1 && isdefined( var_2 ) && var_2 )
        self notify( "received_earned_killstreak" );
}

givekillstreakweapon( var_0 )
{
    self endon( "disconnect" );

    if ( !level.console && !common_scripts\utility::_ID18472() )
        return;

    var_1 = maps\mp\_utility::getkillstreakreferencebyweapon( var_0 );

    if ( !maps\mp\_utility::cancustomjuggusekillstreak( var_1 ) )
        maps\mp\_utility::_setactionslot( 4, "" );
    else
    {
        var_2 = self getweaponslistitems();

        foreach ( var_4 in var_2 )
        {
            if ( !maps\mp\_utility::_ID18801( var_4, "killstreak_" ) && !maps\mp\_utility::_ID18801( var_4, "airdrop_" ) && !maps\mp\_utility::_ID18801( var_4, "deployable_" ) )
                continue;

            if ( isholdingweapon( var_4 ) )
                continue;

            while ( maps\mp\_utility::_ID18585() )
                wait 0.05;

            self takeweapon( var_4 );
        }

        if ( isdefined( self._ID19258 ) )
        {
            var_1 = self.pers["killstreaks"][self._ID19258]._ID31889;
            var_6 = maps\mp\_utility::getkillstreakweapon( var_1 );

            if ( !isholdingweapon( var_6 ) )
            {
                if ( var_0 != "" )
                {
                    maps\mp\_utility::_giveweapon( var_0, 0 );
                    maps\mp\_utility::_setactionslot( 4, "weapon", var_0 );
                    return;
                }

                return;
            }

            return;
        }

        maps\mp\_utility::_giveweapon( var_0, 0 );
        maps\mp\_utility::_setactionslot( 4, "weapon", var_0 );
    }
}

isholdingweapon( var_0 )
{
    return self getcurrentweapon() == var_0 || isdefined( self.changingweapon ) && self.changingweapon == var_0;
}

_ID15382( var_0 )
{
    var_1 = int( maps\mp\_utility::_ID15100( var_0 ) );

    if ( isdefined( self ) && isplayer( self ) )
    {
        if ( maps\mp\_utility::_ID18795( var_0 ) )
        {
            if ( isdefined( self.pers["gamemodeLoadout"] ) )
            {
                if ( isdefined( self.pers["gamemodeLoadout"]["loadoutKillstreak1"] ) && self.pers["gamemodeLoadout"]["loadoutKillstreak1"] == var_0 )
                    var_1 = 2;
                else if ( isdefined( self.pers["gamemodeLoadout"]["loadoutKillstreak2"] ) && self.pers["gamemodeLoadout"]["loadoutKillstreak2"] == var_0 )
                    var_1 = 4;
                else if ( isdefined( self.pers["gamemodeLoadout"]["loadoutKillstreak3"] ) && self.pers["gamemodeLoadout"]["loadoutKillstreak3"] == var_0 )
                    var_1 = 6;
                else
                {

                }
            }
            else if ( issubstr( self.curclass, "custom" ) )
            {
                for ( var_2 = 0; var_2 < 3; var_2++ )
                {
                    var_3 = self getcacplayerdata( "loadouts", self.class_num, "specialistStreaks", var_2 );

                    if ( var_3 == var_0 )
                        break;
                }

                var_1 = self getcacplayerdata( "loadouts", self.class_num, "specialistStreakKills", var_2 );
            }
            else if ( issubstr( self.curclass, "callback" ) )
            {
                var_2 = 0;

                foreach ( var_2, var_5 in self.pers["specialistStreaks"] )
                {
                    if ( var_5 == var_0 )
                        break;
                }

                var_1 = self.pers["specialistStreakKills"][var_2];
            }
            else if ( issubstr( self.curclass, "axis" ) || issubstr( self.curclass, "allies" ) )
            {
                var_2 = 0;
                var_6 = "none";

                if ( issubstr( self.curclass, "axis" ) )
                    var_6 = "axis";
                else if ( issubstr( self.curclass, "allies" ) )
                    var_6 = "allies";

                for ( var_7 = maps\mp\_utility::_ID14933( self.curclass ); var_2 < 3; var_2++ )
                {
                    var_3 = getmatchrulesdata( "defaultClasses", var_6, var_7, "class", "specialistStreaks", var_2 );

                    if ( var_3 == var_0 )
                        break;
                }

                var_1 = getmatchrulesdata( "defaultClasses", var_6, var_7, "class", "specialistStreakKills", var_2 );
            }
        }

        if ( maps\mp\_utility::_hasperk( "specialty_hardline" ) && var_1 > 0 )
            var_1--;
    }

    var_1 = int( clamp( var_1, 0, 30 ) );
    return var_1;
}

_ID31895( var_0 )
{
    switch ( var_0 )
    {
        case "specialist":
        case "assault":
            return 1;
        case "support":
            return 0;
    }
}

_ID15610( var_0 )
{
    var_1 = self.pers["killstreaks"];

    if ( level.console || common_scripts\utility::_ID18472() )
    {
        var_2 = -1;
        var_3 = -1;

        for ( var_4 = 0; var_4 < 4; var_4++ )
        {
            if ( isdefined( var_1[var_4] ) && isdefined( var_1[var_4]._ID31889 ) && var_1[var_4].available && _ID15382( var_1[var_4]._ID31889 ) > var_3 )
            {
                var_3 = 0;

                if ( !var_1[var_4]._ID18639 )
                    var_3 = _ID15382( var_1[var_4]._ID31889 );

                var_2 = var_4;
            }
        }

        if ( var_2 != -1 )
        {
            self._ID19258 = var_2;
            var_5 = var_1[self._ID19258]._ID31889;
            var_6 = maps\mp\_utility::getkillstreakweapon( var_5 );
            givekillstreakweapon( var_6 );
        }
        else
            self._ID19258 = undefined;
    }
    else
    {
        var_2 = -1;
        var_3 = -1;

        for ( var_4 = 0; var_4 < 4; var_4++ )
        {
            if ( isdefined( var_1[var_4] ) && isdefined( var_1[var_4]._ID31889 ) && var_1[var_4].available )
            {
                var_7 = maps\mp\_utility::getkillstreakweapon( var_1[var_4]._ID31889 );
                var_8 = self getweaponslistitems();
                var_9 = 0;

                for ( var_10 = 0; var_10 < var_8.size; var_10++ )
                {
                    if ( var_7 == var_8[var_10] )
                    {
                        var_9 = 1;
                        break;
                    }
                }

                if ( !var_9 )
                    maps\mp\_utility::_giveweapon( var_7 );
                else if ( issubstr( var_7, "airdrop_" ) )
                    self setweaponammoclip( var_7, 1 );

                maps\mp\_utility::_setactionslot( var_4 + 4, "weapon", var_7 );

                if ( _ID15382( var_1[var_4]._ID31889 ) > var_3 )
                {
                    var_3 = 0;

                    if ( !var_1[var_4]._ID18639 )
                        var_3 = _ID15382( var_1[var_4]._ID31889 );

                    var_2 = var_4;
                }
            }
        }

        if ( var_2 != -1 )
            var_5 = var_1[var_2]._ID31889;

        self._ID19258 = undefined;
    }

    updatestreakslots();
}

_ID17993( var_0 )
{
    common_scripts\utility::_disableusability();
    var_1 = initridekillstreak_internal( var_0 );

    if ( isdefined( self ) )
        common_scripts\utility::_enableusability();

    return var_1;
}

initridekillstreak_internal( var_0 )
{
    if ( isdefined( var_0 ) && _ID18685( var_0 ) )
        var_1 = "timeout";
    else
        var_1 = common_scripts\utility::_ID35637( 1.0, "disconnect", "death", "weapon_switch_started" );

    maps\mp\gametypes\_hostmigration::_ID35770();

    if ( var_1 == "weapon_switch_started" )
        return "fail";

    if ( !isalive( self ) )
        return "fail";

    if ( var_1 == "disconnect" || var_1 == "death" )
    {
        if ( var_1 == "disconnect" )
            return "disconnect";

        if ( self.team == "spectator" )
            return "fail";

        return "success";
    }

    if ( maps\mp\_utility::_ID18678() )
        return "fail";

    if ( !isdefined( var_0 ) || !issubstr( var_0, "odin" ) )
    {
        self visionsetnakedforplayer( "black_bw", 0.75 );
        thread maps\mp\_utility::set_visionset_for_watching_players( "black_bw", 0.75, 1.0, undefined, 1 );
        var_2 = common_scripts\utility::_ID35637( 0.8, "disconnect", "death" );
    }
    else
        var_2 = common_scripts\utility::_ID35637( 1.0, "disconnect", "death" );

    self notify( "black_out_done" );
    maps\mp\gametypes\_hostmigration::_ID35770();

    if ( var_2 != "disconnect" )
    {
        if ( !isdefined( var_0 ) || !issubstr( var_0, "odin" ) )
            thread clearrideintro( 1.0 );
        else
            self notify( "intro_cleared" );

        if ( self.team == "spectator" )
            return "fail";
    }

    if ( self isonladder() )
        return "fail";

    if ( !isalive( self ) )
        return "fail";

    if ( maps\mp\_utility::_ID18678() )
        return "fail";

    if ( var_2 == "disconnect" )
        return "disconnect";
    else
        return "success";
}

_ID18685( var_0 )
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
        case "osprey_gunner":
        case "remote_uav":
        case "remote_tank":
            return 1;
    }

    return 0;
}

clearrideintro( var_0, var_1 )
{
    self endon( "disconnect" );

    if ( isdefined( var_0 ) )
        wait(var_0);

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    self visionsetnakedforplayer( "", var_1 );
    maps\mp\_utility::set_visionset_for_watching_players( "", var_1 );
    self notify( "intro_cleared" );
}

allowridekillstreakplayerexit( var_0 )
{
    if ( isdefined( var_0 ) )
        self endon( var_0 );

    if ( !isdefined( self.owner ) )
        return;

    var_1 = self.owner;
    level endon( "game_ended" );
    var_1 endon( "disconnect" );
    var_1 endon( "end_remote" );
    self endon( "death" );

    for (;;)
    {
        var_2 = 0;

        while ( var_1 usebuttonpressed() )
        {
            var_2 += 0.05;

            if ( var_2 > 0.75 )
            {
                self notify( "killstreakExit" );
                return;
            }

            wait 0.05;
        }

        wait 0.05;
    }
}

giveselectedkillstreakitem()
{
    var_0 = self.pers["killstreaks"][self._ID19258]._ID31889;
    var_1 = maps\mp\_utility::getkillstreakweapon( var_0 );
    givekillstreakweapon( var_1 );
    updatestreakslots();
}

getkillstreakcount()
{
    var_0 = 0;

    for ( var_1 = 0; var_1 < 4; var_1++ )
    {
        if ( isdefined( self.pers["killstreaks"][var_1] ) && isdefined( self.pers["killstreaks"][var_1]._ID31889 ) && self.pers["killstreaks"][var_1].available )
            var_0++;
    }

    return var_0;
}

_ID29997()
{
    if ( getkillstreakcount() > 1 )
    {
        for (;;)
        {
            self._ID19258++;

            if ( self._ID19258 > 3 )
                self._ID19258 = 0;

            if ( self.pers["killstreaks"][self._ID19258].available == 1 )
                break;
        }

        giveselectedkillstreakitem();
    }
}

shufflekillstreaksdown()
{
    if ( getkillstreakcount() > 1 )
    {
        for (;;)
        {
            self._ID19258--;

            if ( self._ID19258 < 0 )
                self._ID19258 = 3;

            if ( self.pers["killstreaks"][self._ID19258].available == 1 )
                break;
        }

        giveselectedkillstreakitem();
    }
}

_ID31892()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "toggled_up" );

        if ( !level.console && !common_scripts\utility::_ID18472() )
            continue;

        if ( isdefined( self._ID29974 ) && self._ID29974 )
            continue;

        if ( !self ismantling() && ( !isdefined( self.changingweapon ) || isdefined( self.changingweapon ) && self.changingweapon == "none" ) && ( !maps\mp\_utility::_ID18679( self getcurrentweapon() ) || isminigun( self getcurrentweapon() ) || self getcurrentweapon() == "venomxgun_mp" || maps\mp\_utility::_ID18679( self getcurrentweapon() ) && maps\mp\_utility::_ID18666() ) && self._ID31894 != "specialist" && ( !isdefined( self._ID18582 ) || isdefined( self._ID18582 ) && self._ID18582 == 0 ) && ( !isdefined( self._ID19650 ) || isdefined( self._ID19650 ) && gettime() - self._ID19650 > 100 ) )
        {
            _ID29997();
            self setclientomnvar( "ui_killstreak_scroll", 1 );
        }

        wait 0.12;
    }
}

isminigun( var_0 )
{
    return var_0 == "iw6_minigunjugg_mp";
}

_ID31891()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "toggled_down" );

        if ( !level.console && !common_scripts\utility::_ID18472() )
            continue;

        if ( isdefined( self._ID29974 ) && self._ID29974 )
            continue;

        if ( !self ismantling() && ( !isdefined( self.changingweapon ) || isdefined( self.changingweapon ) && self.changingweapon == "none" ) && ( !maps\mp\_utility::_ID18679( self getcurrentweapon() ) || isminigun( self getcurrentweapon() ) || self getcurrentweapon() == "venomxgun_mp" || maps\mp\_utility::_ID18679( self getcurrentweapon() ) && maps\mp\_utility::_ID18666() ) && self._ID31894 != "specialist" && ( !isdefined( self._ID18582 ) || isdefined( self._ID18582 ) && self._ID18582 == 0 ) && ( !isdefined( self._ID19650 ) || isdefined( self._ID19650 ) && gettime() - self._ID19650 > 100 ) )
        {
            shufflekillstreaksdown();
            self setclientomnvar( "ui_killstreak_scroll", 1 );
        }

        wait 0.12;
    }
}

_ID31896()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "streakUsed" );
        self._ID19650 = gettime();
    }
}

_ID31890()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( isbot( self ) )
        return;

    maps\mp\_utility::gameflagwait( "prematch_done" );

    if ( level.console || common_scripts\utility::_ID18472() )
    {
        self notifyonplayercommand( "toggled_up", "+actionslot 1" );
        self notifyonplayercommand( "toggled_down", "+actionslot 2" );
        self notifyonplayercommand( "streakUsed", "+actionslot 4" );
        self notifyonplayercommand( "streakUsed", "+actionslot 5" );
        self notifyonplayercommand( "streakUsed", "+actionslot 6" );
        self notifyonplayercommand( "streakUsed", "+actionslot 7" );
    }

    if ( !level.console )
    {
        self notifyonplayercommand( "streakUsed1", "+actionslot 4" );
        self notifyonplayercommand( "streakUsed2", "+actionslot 5" );
        self notifyonplayercommand( "streakUsed3", "+actionslot 6" );
        self notifyonplayercommand( "streakUsed4", "+actionslot 7" );
    }
}

registeradrenalineinfo( var_0, var_1 )
{
    if ( !isdefined( level.adrenalineinfo ) )
        level.adrenalineinfo = [];

    level.adrenalineinfo[var_0] = var_1;
}

_ID15579( var_0 )
{
    if ( level.adrenalineinfo[var_0] == 0 )
        return;

    if ( maps\mp\_utility::_ID18666() && self._ID31894 == "specialist" )
        return;

    var_1 = self.adrenaline + level.adrenalineinfo[var_0];
    var_2 = var_1;
    var_3 = getmaxstreakcost();

    if ( var_2 > var_3 && self._ID31894 != "specialist" )
        var_2 -= var_3;
    else if ( level._ID19262 && var_2 > var_3 && self._ID31894 == "specialist" )
    {
        var_4 = var_3;

        if ( isai( self ) )
            var_4 = self.pers["specialistStreakKills"][2];

        var_5 = int( max( 8, var_4 + 2 ) );

        if ( maps\mp\_utility::_hasperk( "specialty_hardline" ) )
            var_5--;

        var_6 = var_2 >= var_5 && self getcommonplayerdata( "killstreaksState", "hasStreak", 4 ) == 0;

        if ( var_6 )
        {
            givebonusperks();
            _ID34739( "all_perks_bonus", 1 );
            thread maps\mp\gametypes\_hud_message::_ID19270( "all_perks_bonus", var_5 );
            self setcommonplayerdata( "killstreaksState", "hasStreak", 4, 1 );
            self.pers["killstreaks"][4].available = 1;
        }

        if ( var_3 > 0 && !( ( var_2 - var_3 ) % 2 ) )
        {
            thread maps\mp\gametypes\_rank::_ID36462( "specialist_streaking_xp" );
            thread maps\mp\gametypes\_rank::giverankxp( "kill" );
        }
    }

    _ID28630( var_2 );
    checkstreakreward();

    if ( var_1 == var_3 && self._ID31894 != "specialist" )
        _ID28630( 0 );
}

givebonusperks()
{
    if ( isai( self ) )
    {
        if ( isdefined( self.pers ) && isdefined( self.pers["specialistBonusStreaks"] ) )
        {
            foreach ( var_1 in self.pers["specialistBonusStreaks"] )
            {
                if ( !maps\mp\_utility::_hasperk( var_1 ) )
                    maps\mp\_utility::_ID15611( var_1, 0 );
            }
        }
    }
    else
    {
        for ( var_3 = 0; var_3 < 7; var_3++ )
        {
            for ( var_4 = 0; var_4 < 5; var_4++ )
            {
                var_5 = 0;

                if ( isdefined( self.teamname ) )
                    var_5 = getmatchrulesdata( "defaultClasses", self.teamname, self.class_num, "class", "specialistBonusStreaks", var_3, var_4 );
                else
                    var_5 = self getcacplayerdata( "loadouts", self.class_num, "specialistBonusStreaks", var_3, var_4 );

                if ( isdefined( var_5 ) && var_5 )
                {
                    var_1 = tablelookup( "mp/cacAbilityTable.csv", 0, var_3 + 1, 4 + var_4 );

                    if ( !maps\mp\_utility::_hasperk( var_1 ) )
                        maps\mp\_utility::_ID15611( var_1, 0 );
                }
            }
        }
    }
}

_ID26116()
{
    self.earnedstreaklevel = 0;
    _ID28630( 0 );
    _ID26141();
    self.pers["lastEarnedStreak"] = undefined;
    self.pers["objectivePointStreak"] = 0;
    self setclientomnvar( "ui_half_tick", 0 );
}

_ID28630( var_0 )
{
    if ( var_0 < 0 )
        var_0 = 0;

    if ( isdefined( self.adrenaline ) )
        self._ID24938 = self.adrenaline;
    else
        self._ID24938 = 0;

    self.adrenaline = var_0;
    self setclientdvar( "ui_adrenaline", self.adrenaline );
    updatestreakcount();
}

_ID23411()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 = common_scripts\utility::_ID18472();

    for (;;)
    {
        if ( var_0 != common_scripts\utility::_ID18472() )
        {
            var_0 = common_scripts\utility::_ID18472();

            if ( !var_0 )
            {
                if ( isdefined( self.actionslotenabled ) )
                {
                    for ( var_1 = 0; var_1 < 4; var_1++ )
                        self.actionslotenabled[var_1] = 1;

                    self notifyonplayercommand( "streakUsed1", "+actionslot 4" );
                    self notifyonplayercommand( "streakUsed2", "+actionslot 5" );
                    self notifyonplayercommand( "streakUsed3", "+actionslot 6" );
                    self notifyonplayercommand( "streakUsed4", "+actionslot 7" );
                    _ID15610();
                }
            }
            else
            {
                var_2 = self getweaponslistitems();

                foreach ( var_4 in var_2 )
                {
                    if ( maps\mp\_utility::_ID18679( var_4 ) && var_4 == self getcurrentweapon() )
                    {
                        self switchtoweapon( common_scripts\utility::_ID15114() );

                        while ( maps\mp\_utility::_ID18585() )
                            wait 0.05;
                    }

                    if ( maps\mp\_utility::_ID18679( var_4 ) )
                        self takeweapon( var_4 );
                }

                for ( var_1 = 0; var_1 < 4; var_1++ )
                {
                    maps\mp\_utility::_setactionslot( var_1 + 4, "" );
                    self.actionslotenabled[var_1] = 0;
                }

                self notifyonplayercommand( "toggled_up", "+actionslot 1" );
                self notifyonplayercommand( "toggled_down", "+actionslot 2" );
                self notifyonplayercommand( "streakUsed", "+actionslot 4" );
                self notifyonplayercommand( "streakUsed", "+actionslot 5" );
                self notifyonplayercommand( "streakUsed", "+actionslot 6" );
                self notifyonplayercommand( "streakUsed", "+actionslot 7" );
                _ID15610();
            }
        }

        wait 0.05;
    }
}

_ID23412()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self.actionslotenabled = [];
    self.actionslotenabled[0] = 1;
    self.actionslotenabled[1] = 1;
    self.actionslotenabled[2] = 1;
    self.actionslotenabled[3] = 1;

    for (;;)
    {
        var_0 = common_scripts\utility::_ID35635( "streakUsed1", "streakUsed2", "streakUsed3", "streakUsed4" );

        if ( common_scripts\utility::_ID18472() )
            continue;

        if ( !isdefined( var_0 ) )
            continue;

        if ( self._ID31894 == "specialist" && var_0 != "streakUsed1" )
            continue;

        if ( isdefined( self.changingweapon ) && self.changingweapon == "none" )
            continue;

        if ( self isoffhandweaponreadytothrow() )
            continue;

        switch ( var_0 )
        {
            case "streakUsed1":
                if ( self.pers["killstreaks"][0].available && self.actionslotenabled[0] )
                    self._ID19258 = 0;

                break;
            case "streakUsed2":
                if ( self.pers["killstreaks"][1].available && self.actionslotenabled[1] )
                    self._ID19258 = 1;

                break;
            case "streakUsed3":
                if ( self.pers["killstreaks"][2].available && self.actionslotenabled[2] )
                    self._ID19258 = 2;

                break;
            case "streakUsed4":
                if ( self.pers["killstreaks"][3].available && self.actionslotenabled[3] )
                    self._ID19258 = 3;

                break;
        }

        if ( isdefined( self._ID19258 ) && !self.pers["killstreaks"][self._ID19258].available )
            self._ID19258 = undefined;

        if ( isdefined( self._ID19258 ) )
        {
            _ID10162();

            for (;;)
            {
                self waittill( "weapon_change",  var_1, var_2  );

                if ( isdefined( self._ID19258 ) )
                {
                    var_3 = maps\mp\_utility::getkillstreakweapon( self.pers["killstreaks"][self._ID19258]._ID31889 );

                    if ( var_1 == var_3 || var_1 == "none" || var_3 == "killstreak_uav_mp" && var_1 == "killstreak_remote_uav_mp" || var_3 == "killstreak_uav_mp" && var_1 == "uav_remote_mp" || var_2 )
                        continue;

                    break;
                }

                break;
            }

            _ID11496();
            self._ID19258 = undefined;
        }
    }
}

_ID10162()
{
    for ( var_0 = 0; var_0 < 4; var_0++ )
    {
        if ( !isdefined( self._ID19258 ) )
            break;

        if ( self._ID19258 == var_0 )
            continue;

        maps\mp\_utility::_setactionslot( var_0 + 4, "" );
        self.actionslotenabled[var_0] = 0;
    }
}

_ID11496()
{
    for ( var_0 = 0; var_0 < 4; var_0++ )
    {
        if ( self.pers["killstreaks"][var_0].available )
        {
            var_1 = maps\mp\_utility::getkillstreakweapon( self.pers["killstreaks"][var_0]._ID31889 );
            maps\mp\_utility::_setactionslot( var_0 + 4, "weapon", var_1 );
        }
        else
            maps\mp\_utility::_setactionslot( var_0 + 4, "" );

        self.actionslotenabled[var_0] = 1;
    }
}

_ID19257( var_0, var_1, var_2 )
{
    if ( isdefined( var_1 ) && isplayer( var_0 ) && isdefined( var_2.owner ) && isdefined( var_2.owner.team ) )
    {
        if ( ( level._ID32653 && var_2.owner.team != var_0.team || !level._ID32653 ) && var_0 != var_2.owner )
        {
            if ( maps\mp\_utility::_ID18679( var_1 ) )
                return;

            if ( !isdefined( var_0._ID19564[var_1] ) )
                var_0._ID19564[var_1] = 0;

            if ( var_0._ID19564[var_1] == gettime() )
                return;

            var_0._ID19564[var_1] = gettime();
            var_0 thread maps\mp\gametypes\_gamelogic::_ID32913( var_1, 1, "hits" );

            if ( !issquadsmode() )
            {
                var_3 = var_0 maps\mp\gametypes\_persistence::statgetbuffered( "totalShots" );
                var_4 = var_0 maps\mp\gametypes\_persistence::statgetbuffered( "hits" ) + 1;

                if ( var_4 <= var_3 )
                {
                    var_0 maps\mp\gametypes\_persistence::_ID31527( "hits", var_4 );
                    var_0 maps\mp\gametypes\_persistence::_ID31527( "misses", int( var_3 - var_4 ) );
                    var_0 maps\mp\gametypes\_persistence::_ID31527( "accuracy", int( var_4 * 10000 / var_3 ) );
                }
            }
        }
    }
}

copy_killstreak_status( var_0, var_1 )
{
    self._ID31894 = var_0._ID31894;
    self.pers["cur_kill_streak"] = var_0.pers["cur_kill_streak"];
    maps\mp\gametypes\_persistence::_ID31528( "round", "killStreak", self.pers["cur_kill_streak"] );
    self.pers["killstreaks"] = var_0.pers["killstreaks"];
    self.killstreaks = var_0.killstreaks;

    if ( !isdefined( var_1 ) || var_1 == 0 )
    {
        var_2 = getentarray();

        foreach ( var_4 in var_2 )
        {
            if ( !isdefined( var_4 ) || isplayer( var_4 ) )
                continue;

            if ( isdefined( var_4.owner ) && var_4.owner == var_0 )
            {
                if ( var_4.classname == "misc_turret" )
                {
                    var_4 maps\mp\killstreaks\_autosentry::_ID28143( self );
                    continue;
                }

                var_4.owner = self;
            }
        }
    }

    self.adrenaline = undefined;
    _ID28630( var_0.adrenaline );
    _ID26141();
    updatestreakcount();

    if ( isdefined( var_1 ) && var_1 == 1 && isdefined( self.killstreaks ) )
    {
        var_6 = 1;

        foreach ( var_8 in self.killstreaks )
        {
            var_9 = self.pers["killstreaks"][var_6]._ID31889;

            if ( self._ID31894 == "specialist" )
            {
                var_10 = strtok( self.pers["killstreaks"][var_6]._ID31889, "_" );

                if ( var_10[var_10.size - 1] == "ks" )
                {
                    var_11 = undefined;

                    foreach ( var_13 in var_10 )
                    {
                        if ( var_13 != "ks" )
                        {
                            if ( !isdefined( var_11 ) )
                            {
                                var_11 = var_13;
                                continue;
                            }

                            var_11 += ( "_" + var_13 );
                        }
                    }

                    if ( maps\mp\_utility::_ID18801( self.pers["killstreaks"][var_6]._ID31889, "_" ) )
                        var_11 = "_" + var_11;

                    if ( isdefined( var_11 ) && maps\mp\gametypes\_class::getperkupgrade( var_11 ) != "specialty_null" )
                        var_9 = self.pers["killstreaks"][var_6]._ID31889 + "_pro";
                }
            }

            self setcommonplayerdata( "killstreaksState", "icons", var_6, maps\mp\_utility::_ID15099( var_9 ) );
            var_6++;
        }
    }

    updatestreakslots();

    foreach ( var_11 in var_0.perksperkname )
    {
        if ( !maps\mp\_utility::_hasperk( var_11 ) )
        {
            var_17 = 0;

            if ( isdefined( self._ID23456[var_11] ) )
                var_17 = self._ID23456[var_11];

            maps\mp\_utility::_ID15611( var_11, var_17 );
        }

        if ( !isdefined( var_1 ) || var_1 == 0 )
            var_0 maps\mp\_utility::_unsetperk( var_11 );
    }
}

copy_adrenaline( var_0 )
{
    self.adrenaline = undefined;
    _ID28630( var_0.adrenaline );
    _ID26141();
    updatestreakcount();
    updatestreakslots();
}

_ID18511()
{
    var_0 = self getcurrentweapon();
    var_1 = issubstr( var_0, "killstreak" ) || isdefined( self._ID28032 ) && self._ID28032 == 1 || !common_scripts\utility::_ID18870() && !maps\mp\gametypes\_damage::attackerinremotekillstreak();
    return var_1;
}

_ID21375()
{
    while ( isdefined( self ) )
    {
        if ( maps\mp\_utility::bot_is_fireteam_mode() )
            self waittill( "disconnect" );
        else
            common_scripts\utility::_ID35626( "disconnect", "joined_team", "joined_spectators" );

        self notify( "killstreak_disowned" );
    }
}

_ID12946( var_0, var_1, var_2, var_3 )
{
    var_4 = rotatevector( ( 0, 0, 1 ), ( -1 * var_3, 0, 0 ) );
    var_5 = vectortoangles( var_1 - var_0.origin );

    for ( var_6 = 0; var_6 < 360; var_6 += 30 )
    {
        var_7 = var_2 * rotatevector( var_4, ( 0, var_6 + var_5[1], 0 ) );
        var_8 = var_1 + var_7;

        if ( _findunobstructedfiringpointhelper( var_0, var_8, var_1 ) )
            return var_8;
    }

    return undefined;
}

_ID12945( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = vectortoangles( var_0.origin - var_1 );

    for ( var_7 = var_3; var_7 <= var_4; var_7 += var_5 )
    {
        var_8 = rotatevector( ( 1, 0, 0 ), ( var_7 - 90, 0, 0 ) );
        var_9 = var_2 * rotatevector( var_8, ( 0, var_6[1], 0 ) );
        var_10 = var_1 + var_9;

        if ( _findunobstructedfiringpointhelper( var_0, var_10, var_1 ) )
            return var_10;
    }

    return undefined;
}

_findunobstructedfiringpointhelper( var_0, var_1, var_2 )
{
    var_3 = bullettrace( var_1, var_2, 0 );

    if ( var_3["fraction"] > 0.99 )
        return 1;

    return 0;
}

findunobstructedfiringpoint( var_0, var_1, var_2 )
{
    var_3 = _ID12946( var_0, var_1, var_2, 30 );

    if ( !isdefined( var_3 ) )
        var_3 = _ID12945( var_0, var_1, var_2, 15, 75, 15 );

    return var_3;
}

isairdropmarker( var_0 )
{
    switch ( var_0 )
    {
        case "airdrop_marker_mp":
        case "airdrop_juggernaut_mp":
        case "airdrop_marker_assault_mp":
        case "airdrop_marker_support_mp":
        case "airdrop_mega_marker_mp":
        case "airdrop_sentry_marker_mp":
        case "airdrop_juggernaut_def_mp":
        case "airdrop_juggernaut_maniac_mp":
        case "airdrop_tank_marker_mp":
        case "airdrop_escort_marker_mp":
            return 1;
        default:
            return 0;
    }
}

_ID18836()
{
    return isdefined( self._ID22850 ) && self._ID22850;
}

destroytargetarray( var_0, var_1, var_2, var_3 )
{
    var_4 = "MOD_EXPLOSIVE";
    var_5 = 5000;
    var_6 = ( 0, 0, 0 );
    var_7 = ( 0, 0, 0 );
    var_8 = "";
    var_9 = "";
    var_10 = "";
    var_11 = undefined;

    if ( level._ID32653 )
    {
        foreach ( var_13 in var_3 )
        {
            if ( maps\mp\_utility::_ID18859( var_0, var_1, var_13 ) )
            {
                var_13 notify( "damage",  var_5, var_0, var_6, var_7, var_4, var_8, var_9, var_10, var_11, var_2  );
                wait 0.05;
            }
        }
    }
    else
    {
        foreach ( var_13 in var_3 )
        {
            if ( maps\mp\_utility::isvalidffatarget( var_0, var_1, var_13 ) )
            {
                var_13 notify( "damage",  var_5, var_0, var_6, var_7, var_4, var_8, var_9, var_10, var_11, var_2  );
                wait 0.05;
            }
        }
    }
}
