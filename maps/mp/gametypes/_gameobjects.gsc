// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445( var_0 )
{
    var_0[var_0.size] = "airdrop_pallet";
    var_1 = getentarray();

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( isdefined( var_1[var_2]._ID27614 ) )
        {
            var_3 = 1;
            var_4 = strtok( var_1[var_2]._ID27614, " " );

            for ( var_5 = 0; var_5 < var_0.size; var_5++ )
            {
                for ( var_6 = 0; var_6 < var_4.size; var_6++ )
                {
                    if ( var_4[var_6] == var_0[var_5] )
                    {
                        var_3 = 0;
                        break;
                    }
                }

                if ( !var_3 )
                    break;
            }

            if ( var_3 )
                var_1[var_2] delete();
        }
    }
}

_ID17631()
{
    level._ID22408 = 0;
    level thread _ID22877();
}

_ID22877()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread onplayerspawned();
        var_0 thread _ID22808();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "spawned_player" );

        if ( isdefined( self._ID14076 ) )
        {
            self._ID14076 = undefined;
            continue;
        }

        _ID17801();
    }
}

_ID17801()
{
    thread ondeath();
    self._ID33168 = [];
    self.carryobject = undefined;
    self.claimtrigger = undefined;
    self.canpickupobject = 1;
    self.killedinuse = undefined;
    self._ID17959 = 1;
}

ondeath()
{
    level endon( "game_ended" );
    self waittill( "death" );

    if ( isdefined( self.carryobject ) )
    {
        self.carryobject thread _ID28709();
        return;
    }
}

_ID22808()
{
    level endon( "game_ended" );
    self waittill( "disconnect" );

    if ( isdefined( self.carryobject ) )
    {
        self.carryobject thread _ID28709();
        return;
    }
}

_ID8396( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4.type = "carryObject";
    var_4.curorigin = var_1.origin;
    var_4._ID23192 = var_0;
    var_4.entnum = var_1 getentitynumber();

    if ( issubstr( var_1.classname, "use" ) )
        var_4._ID33726 = "use";
    else
        var_4._ID33726 = "proximity";

    var_1._ID4860 = var_1.origin;
    var_4.trigger = var_1;

    if ( !isdefined( var_1._ID20039 ) )
    {
        var_1._ID20039 = 1;
        var_1 enablelinkto();
    }

    var_4._ID34784 = undefined;

    if ( !isdefined( var_3 ) )
        var_3 = ( 0, 0, 0 );

    var_4._ID22631 = var_3;

    for ( var_5 = 0; var_5 < var_2.size; var_5++ )
    {
        var_2[var_5]._ID4860 = var_2[var_5].origin;
        var_2[var_5].baseangles = var_2[var_5].angles;
    }

    var_4._ID35361 = var_2;
    var_4._ID7838 = [];
    var_4._ID22501 = 0;
    var_4._ID22500 = 0;

    foreach ( var_7 in level._ID32668 )
    {
        var_4._ID32670[var_7] = getnextobjid();
        objective_add( var_4._ID32670[var_7], "invisible", var_4.curorigin );
        objective_team( var_4._ID32670[var_7], var_7 );
        var_4.objpoints[var_7] = maps\mp\gametypes\_objpoints::createteamobjpoint( "objpoint_" + var_7 + "_" + var_4.entnum, var_4.curorigin + var_3, var_7, undefined );
        var_4.objpoints[var_7].alpha = 0;
    }

    var_4.carrier = undefined;
    var_4._ID18762 = 0;
    var_4._ID18086 = "none";
    var_4.allowweapons = 0;
    var_4._ID36422 = [];
    var_4.carriervisible = 0;
    var_4._ID35317 = "none";
    var_4.carryicon = undefined;
    var_4._ID22810 = undefined;
    var_4.onpickup = undefined;
    var_4._ID22893 = undefined;

    if ( var_4._ID33726 == "use" )
        var_4 thread carryobjectusethink();
    else
    {
        var_4.curprogress = 0;
        var_4._ID34780 = 0;
        var_4._ID34766 = 0;
        var_4._ID32684 = [];
        var_4._ID32683 = [];
        var_4._ID22425["neutral"] = 0;
        var_4._ID33167["neutral"] = [];
        var_4._ID22425["none"] = 0;
        var_4._ID33167["none"] = [];

        foreach ( var_10 in level._ID32668 )
        {
            var_4._ID22425[var_10] = 0;
            var_4._ID33167[var_10] = [];
        }

        var_4._ID7317 = "none";
        var_4._ID7316 = undefined;
        var_4._ID19532 = "none";
        var_4._ID19533 = 0;
        var_4 thread carryobjectproxthink();
    }

    var_4 thread _ID34514();
    return var_4;
}

carryobjectusethink()
{
    level endon( "game_ended" );

    for (;;)
    {
        self.trigger waittill( "trigger",  var_0  );

        if ( self._ID18762 )
            continue;

        if ( !maps\mp\_utility::_ID18757( var_0 ) )
            continue;

        if ( !_ID6602( var_0.pers["team"] ) )
            continue;

        if ( !var_0.canpickupobject )
            continue;

        if ( !isdefined( var_0._ID17959 ) )
            continue;

        if ( isdefined( var_0._ID32944 ) )
            continue;

        if ( isdefined( self.carrier ) )
            continue;

        if ( var_0 maps\mp\_utility::_ID18837() )
            continue;

        _ID28820( var_0 );
    }
}

carryobjectproxthink()
{
    thread carryobjectproxthinkdelayed();
}

_ID6749()
{
    level endon( "game_ended" );

    for (;;)
    {
        self.trigger waittill( "trigger",  var_0  );

        if ( self._ID18762 )
            continue;

        if ( !maps\mp\_utility::_ID18757( var_0 ) )
            continue;

        if ( !_ID6602( var_0.pers["team"] ) )
            continue;

        if ( !var_0.canpickupobject )
            continue;

        if ( isdefined( var_0._ID32944 ) )
            continue;

        if ( isdefined( self.carrier ) )
            continue;

        _ID28820( var_0 );
    }
}

carryobjectproxthinkdelayed()
{
    level endon( "game_ended" );
    thread _ID25134();

    for (;;)
    {
        if ( self._ID34780 && self.curprogress >= self._ID34780 )
        {
            self.curprogress = 0;
            var_0 = getearliestclaimplayer();

            if ( isdefined( self._ID22816 ) )
                self [[ self._ID22816 ]]( _ID14931(), var_0, isdefined( var_0 ) );

            if ( isdefined( var_0 ) )
                _ID28820( var_0 );

            _ID28674( "none" );
            self._ID7316 = undefined;
        }

        if ( self._ID7317 != "none" )
        {
            if ( self._ID34780 )
            {
                if ( !self._ID22425[self._ID7317] )
                {
                    if ( isdefined( self._ID22816 ) )
                        self [[ self._ID22816 ]]( _ID14931(), self._ID7316, 0 );

                    _ID28674( "none" );
                    self._ID7316 = undefined;
                }
                else
                {
                    self.curprogress = self.curprogress + 50 * self._ID34766;

                    if ( isdefined( self._ID22922 ) )
                        self [[ self._ID22922 ]]( _ID14931(), self.curprogress / self._ID34780, 50 * self._ID34766 / self._ID34780 );
                }
            }
            else
            {
                if ( maps\mp\_utility::_ID18757( self._ID7316 ) )
                    _ID28820( self._ID7316 );

                _ID28674( "none" );
                self._ID7316 = undefined;
            }
        }

        wait 0.05;
        maps\mp\gametypes\_hostmigration::_ID35770();
    }
}

pickupobjectdelay( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self.canpickupobject = 0;

    for (;;)
    {
        if ( distancesquared( self.origin, var_0 ) > 4096 )
            break;

        wait 0.2;
    }

    self.canpickupobject = 1;
}

_ID28820( var_0 )
{
    if ( isai( var_0 ) && isdefined( var_0.owner ) )
        return;

    if ( isdefined( var_0.carryobject ) )
    {
        if ( isdefined( self._ID22872 ) )
            self [[ self._ID22872 ]]( var_0 );

        return;
    }

    var_0 giveobject( self );
    _ID28663( var_0 );

    if ( isdefined( self.trigger getlinkedparent() ) )
    {
        for ( var_1 = 0; var_1 < self._ID35361.size; var_1++ )
            self._ID35361[var_1] unlink();

        self.trigger unlink();
    }

    for ( var_1 = 0; var_1 < self._ID35361.size; var_1++ )
        self._ID35361[var_1] hide();

    self.trigger.origin = self.trigger.origin + ( 0, 0, 10000 );
    self.trigger maps\mp\_movers::_ID31788();
    self notify( "pickup_object" );

    if ( isdefined( self.onpickup ) )
        self [[ self.onpickup ]]( var_0 );

    _ID34525();
    updateworldicons();
}

_ID34514()
{
    level endon( "game_ended" );
    var_0 = 5.0;

    for (;;)
    {
        if ( isdefined( self.carrier ) )
        {
            self.curorigin = self.carrier.origin + ( 0, 0, 75 );

            foreach ( var_2 in level._ID32668 )
                self.objpoints[var_2] maps\mp\gametypes\_objpoints::_ID34570( self.curorigin );

            foreach ( var_2 in level._ID32668 )
            {
                if ( ( self._ID35317 == "friendly" || self._ID35317 == "any" ) && isfriendlyteam( var_2 ) && self._ID22501 )
                {
                    if ( self.objpoints[var_2]._ID18782 )
                    {
                        self.objpoints[var_2].alpha = self.objpoints[var_2].basealpha;
                        self.objpoints[var_2] fadeovertime( var_0 + 1.0 );
                        self.objpoints[var_2].alpha = 0;
                    }

                    objective_position( self._ID32670[var_2], self.curorigin );
                }
            }

            foreach ( var_2 in level._ID32668 )
            {
                if ( ( self._ID35317 == "enemy" || self._ID35317 == "any" ) && !isfriendlyteam( var_2 ) && self._ID22500 )
                {
                    if ( self.objpoints[var_2]._ID18782 )
                    {
                        self.objpoints[var_2].alpha = self.objpoints[var_2].basealpha;
                        self.objpoints[var_2] fadeovertime( var_0 + 1.0 );
                        self.objpoints[var_2].alpha = 0;
                    }

                    objective_position( self._ID32670[var_2], self.curorigin );
                }
            }

            maps\mp\_utility::wait_endon( var_0, "dropped", "reset" );
            continue;
        }

        self.curorigin = self.trigger.origin;

        foreach ( var_2 in level._ID32668 )
            self.objpoints[var_2] maps\mp\gametypes\_objpoints::_ID34570( self.curorigin + self._ID22631 );

        wait 0.05;
    }
}

hidecarryiconongameend()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "drop_object" );
    level waittill( "game_ended" );

    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 0;
        return;
    }
}

giveobject( var_0 )
{
    self.carryobject = var_0;
    thread _ID33298();

    if ( !var_0.allowweapons )
    {
        common_scripts\utility::_disableweapon();
        thread manualdropthink();
    }

    if ( isdefined( var_0.carryicon ) )
    {
        if ( level.splitscreen )
        {
            self.carryicon = maps\mp\gametypes\_hud_util::_ID8444( var_0.carryicon, 33, 33 );
            self.carryicon maps\mp\gametypes\_hud_util::_ID28836( "BOTTOM RIGHT", "BOTTOM RIGHT", -50, -78 );
        }
        else
        {
            self.carryicon = maps\mp\gametypes\_hud_util::_ID8444( var_0.carryicon, 50, 50 );
            self.carryicon maps\mp\gametypes\_hud_util::_ID28836( "BOTTOM RIGHT", "BOTTOM RIGHT", -50, -65 );
        }

        self.carryicon.hidewheninmenu = 1;
        thread hidecarryiconongameend();
        return;
    }
}

_ID26246()
{
    self._ID18762 = 1;
    self notify( "reset" );

    for ( var_0 = 0; var_0 < self._ID35361.size; var_0++ )
    {
        self._ID35361[var_0].origin = self._ID35361[var_0]._ID4860;
        self._ID35361[var_0].angles = self._ID35361[var_0].baseangles;
        self._ID35361[var_0] show();
    }

    self.trigger.origin = self.trigger._ID4860;
    self.curorigin = self.trigger.origin;

    if ( isdefined( self._ID22893 ) )
        self [[ self._ID22893 ]]();

    _ID7479();
    updateworldicons();
    _ID34525();
    self._ID18762 = 0;
}

_ID18649()
{
    if ( isdefined( self.carrier ) )
        return 0;

    if ( self.curorigin != self.trigger._ID4860 )
        return 0;

    return 1;
}

_ID28841( var_0, var_1 )
{
    self._ID18762 = 1;

    for ( var_2 = 0; var_2 < self._ID35361.size; var_2++ )
    {
        self._ID35361[var_2].origin = var_0;
        self._ID35361[var_2].angles = var_1;
        self._ID35361[var_2] show();
    }

    self.trigger.origin = var_0;
    self.curorigin = self.trigger.origin;
    _ID7479();
    updateworldicons();
    _ID34525();
    self._ID18762 = 0;
}

_ID22887()
{
    if ( isdefined( self.carryobject ) )
    {
        self.carryobject thread _ID28709();
        return;
    }
}

carryobject_overridemovingplatformdeath( var_0 )
{
    for ( var_1 = 0; var_1 < var_0.carryobject._ID35361.size; var_1++ )
        var_0.carryobject._ID35361[var_1] unlink();

    var_0.carryobject.trigger unlink();
    var_0.carryobject notify( "stop_pickup_timeout" );
    var_0.carryobject _ID26246();
}

_ID28709()
{
    self._ID18762 = 1;
    self.resetnow = undefined;
    self notify( "dropped" );

    foreach ( var_1 in self._ID35361 )
        var_1.prev_contents = var_1 setcontents( 0 );

    if ( isdefined( self.carrier ) && self.carrier.team != "spectator" )
    {
        var_3 = playerphysicstrace( self.carrier.origin + ( 0, 0, 20 ), self.carrier.origin - ( 0, 0, 2000 ), 0, self.carrier._ID5433 );
        var_4 = bullettrace( self.carrier.origin + ( 0, 0, 20 ), self.carrier.origin - ( 0, 0, 2000 ), 0, self.carrier._ID5433, 1, 0, 1 );
    }
    else
    {
        var_3 = playerphysicstrace( self._ID27109 + ( 0, 0, 20 ), self._ID27109 - ( 0, 0, 20 ), 0, undefined );
        var_4 = bullettrace( self._ID27109 + ( 0, 0, 20 ), self._ID27109 - ( 0, 0, 20 ), 0, undefined, 1, 0, 1 );
    }

    foreach ( var_1 in self._ID35361 )
        var_1 setcontents( var_1.prev_contents );

    var_7 = self.carrier;
    var_8 = 0;

    if ( isdefined( var_3 ) )
    {
        var_9 = randomfloat( 360 );
        var_10 = var_3;

        if ( var_4["fraction"] < 1 && distance( var_4["position"], var_3 ) < 10.0 )
        {
            var_11 = ( cos( var_9 ), sin( var_9 ), 0 );
            var_11 = vectornormalize( var_11 - var_4["normal"] * vectordot( var_11, var_4["normal"] ) );
            var_12 = vectortoangles( var_11 );
        }
        else
            var_12 = ( 0, var_9, 0 );

        for ( var_13 = 0; var_13 < self._ID35361.size; var_13++ )
        {
            self._ID35361[var_13].origin = var_10;
            self._ID35361[var_13].angles = var_12;
            self._ID35361[var_13] show();
        }

        self.trigger.origin = var_10;
        self.curorigin = self.trigger.origin;
        var_14 = var_4["entity"];

        if ( isdefined( var_14 ) && isdefined( var_14.owner ) )
            var_14 = var_14 getlinkedparent();

        if ( isdefined( var_14 ) )
        {
            if ( isdefined( var_14._ID18320 ) && var_14._ID18320 == 1 )
                self.resetnow = 1;
            else
            {
                for ( var_13 = 0; var_13 < self._ID35361.size; var_13++ )
                    self._ID35361[var_13] linkto( var_14 );

                self.trigger linkto( var_14 );
                var_15 = spawnstruct();
                var_15.carryobject = self;
                var_15.deathoverridecallback = ::carryobject_overridemovingplatformdeath;
                self.trigger thread maps\mp\_movers::_ID16165( var_15 );
            }
        }

        thread _ID23554();
    }
    else
    {
        for ( var_13 = 0; var_13 < self._ID35361.size; var_13++ )
        {
            self._ID35361[var_13].origin = self._ID35361[var_13]._ID4860;
            self._ID35361[var_13].angles = self._ID35361[var_13].baseangles;
            self._ID35361[var_13] show();
        }

        self.trigger.origin = self.trigger._ID4860;
        self.curorigin = self.trigger._ID4860;
    }

    if ( isdefined( self._ID22810 ) )
        self [[ self._ID22810 ]]( var_7 );

    _ID7479();
    _ID34525();
    updateworldicons();
    self._ID18762 = 0;
}

_ID28663( var_0 )
{
    self.carrier = var_0;
    thread _ID34643();
}

_ID7479()
{
    if ( !isdefined( self.carrier ) )
        return;

    self.carrier _ID32393( self );
    self.carrier = undefined;
    self notify( "carrier_cleared" );
}

_ID23554()
{
    self endon( "pickup_object" );
    self endon( "stop_pickup_timeout" );
    wait 0.05;

    if ( isdefined( self.resetnow ) )
    {
        self.resetnow = undefined;
        _ID26246();
        return;
    }

    var_0 = getentarray( "minefield", "targetname" );
    var_1 = getentarray( "trigger_hurt", "classname" );
    var_2 = getentarray( "radiation", "targetname" );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        if ( !self._ID35361[0] istouching( var_2[var_3] ) )
            continue;

        _ID26246();
        return;
    }

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        if ( !self._ID35361[0] istouching( var_0[var_3] ) )
            continue;

        _ID26246();
        return;
    }

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        if ( !self._ID35361[0] istouching( var_1[var_3] ) )
            continue;

        _ID26246();
        return;
    }

    if ( isdefined( self.autoresettime ) )
    {
        wait(self.autoresettime);

        if ( !isdefined( self.carrier ) )
        {
            _ID26246();
            return;
        }

        return;
    }
}

_ID32393( var_0 )
{
    if ( isdefined( self.carryicon ) )
        self.carryicon maps\mp\gametypes\_hud_util::destroyelem();

    if ( isdefined( self ) )
        self.carryobject = undefined;

    self notify( "drop_object" );

    if ( var_0._ID33726 == "proximity" )
        thread pickupobjectdelay( var_0.trigger.origin );

    if ( maps\mp\_utility::_ID18757( self ) && !var_0.allowweapons )
    {
        common_scripts\utility::_enableweapon();
        return;
    }
}

_ID33298()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "drop_object" );

    while ( isdefined( self.carryobject ) && maps\mp\_utility::_ID18757( self ) )
    {
        if ( self isonground() )
        {
            var_0 = bullettrace( self.origin + ( 0, 0, 20 ), self.origin - ( 0, 0, 20 ), 0, undefined );

            if ( var_0["fraction"] < 1 )
                self.carryobject._ID27109 = var_0["position"];
        }

        wait 0.05;
    }
}

manualdropthink()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "drop_object" );

    for (;;)
    {
        while ( self attackbuttonpressed() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self meleebuttonpressed() )
            wait 0.05;

        while ( !self attackbuttonpressed() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed() && !self meleebuttonpressed() )
            wait 0.05;

        if ( isdefined( self.carryobject ) && !self usebuttonpressed() )
            self.carryobject thread _ID28709();
    }
}

deleteuseobject()
{
    foreach ( var_1 in level._ID32668 )
    {
        objective_delete( self._ID32670[var_1] );
        maps\mp\gametypes\_objpoints::deleteobjpoint( self.objpoints[var_1] );
    }

    self.trigger = undefined;
    self notify( "deleted" );
}

_ID8493( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4.type = "useObject";
    var_4.curorigin = var_1.origin;
    var_4._ID23192 = var_0;
    var_4.entnum = var_1 getentitynumber();
    var_4._ID19114 = undefined;

    if ( issubstr( var_1.classname, "use" ) )
        var_4._ID33726 = "use";
    else
        var_4._ID33726 = "proximity";

    var_4.trigger = var_1;

    for ( var_5 = 0; var_5 < var_2.size; var_5++ )
    {
        var_2[var_5]._ID4860 = var_2[var_5].origin;
        var_2[var_5].baseangles = var_2[var_5].angles;
    }

    var_4._ID35361 = var_2;

    if ( !isdefined( var_3 ) )
        var_3 = ( 0, 0, 0 );

    var_4._ID22631 = var_3;
    var_4._ID7838 = [];

    foreach ( var_7 in level._ID32668 )
    {
        var_4._ID32670[var_7] = getnextobjid();
        objective_add( var_4._ID32670[var_7], "invisible", var_4.curorigin );
        objective_team( var_4._ID32670[var_7], var_7 );
        var_4.objpoints[var_7] = maps\mp\gametypes\_objpoints::createteamobjpoint( "objpoint_" + var_7 + "_" + var_4.entnum, var_4.curorigin + var_3, var_7, undefined );
        var_4.objpoints[var_7].alpha = 0;
    }

    var_4._ID18086 = "none";
    var_4._ID36422 = [];
    var_4._ID35317 = "none";
    var_4._ID22916 = undefined;
    var_4._ID22785 = undefined;
    var_4._ID34779 = "default";
    var_4._ID34780 = 10000;
    var_4.curprogress = 0;

    if ( var_4._ID33726 == "proximity" )
    {
        var_4._ID32684 = [];
        var_4._ID32683 = [];
        var_4._ID22425["neutral"] = 0;
        var_4._ID33167["neutral"] = [];
        var_4._ID22425["none"] = 0;
        var_4._ID33167["none"] = [];

        foreach ( var_10 in level._ID32668 )
        {
            var_4._ID22425[var_10] = 0;
            var_4._ID33167[var_10] = [];
        }

        var_4._ID34766 = 0;
        var_4._ID7317 = "none";
        var_4._ID7316 = undefined;
        var_4._ID19532 = "none";
        var_4._ID19533 = 0;
        var_4 thread _ID34759();
    }
    else
    {
        var_4._ID34766 = 1;
        var_4 thread _ID34761();
    }

    return var_4;
}

_ID28764( var_0 )
{
    self._ID19114 = var_0;
}

_ID34761()
{
    level endon( "game_ended" );
    self endon( "deleted" );

    for (;;)
    {
        self.trigger waittill( "trigger",  var_0  );

        if ( !maps\mp\_utility::_ID18757( var_0 ) )
            continue;

        if ( !_ID6602( var_0.pers["team"] ) )
            continue;

        if ( !var_0 isonground() )
            continue;

        if ( !var_0 maps\mp\_utility::_ID18666() && maps\mp\_utility::_ID18679( var_0 getcurrentweapon() ) )
            continue;

        if ( isdefined( self._ID34729 ) )
        {
            if ( !self [[ self._ID34729 ]]( var_0 ) )
                continue;
        }

        if ( isdefined( self._ID19114 ) && ( !isdefined( var_0.carryobject ) || var_0.carryobject != self._ID19114 ) )
        {
            if ( isdefined( self._ID22785 ) )
                self [[ self._ID22785 ]]( var_0 );

            continue;
        }

        if ( !var_0 common_scripts\utility::_ID18870() )
            continue;

        var_1 = 1;

        if ( self._ID34780 > 0 )
        {
            if ( isdefined( self._ID22779 ) )
            {
                var_0 _ID34638( self, 0 );
                self [[ self._ID22779 ]]( var_0 );
            }

            if ( !isdefined( self._ID19114 ) )
                thread _ID6664();

            var_2 = var_0.pers["team"];
            var_1 = _ID34751( var_0 );
            self notify( "finished_use" );

            if ( isdefined( self._ID22816 ) )
                self [[ self._ID22816 ]]( var_2, var_0, var_1 );
        }

        if ( !var_1 )
            continue;

        if ( isdefined( self._ID22916 ) )
            self [[ self._ID22916 ]]( var_0 );
    }
}

_ID6664()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    self endon( "finished_use" );

    for (;;)
    {
        self.trigger waittill( "trigger",  var_0  );

        if ( !maps\mp\_utility::_ID18757( var_0 ) )
            continue;

        if ( !_ID6602( var_0.pers["team"] ) )
            continue;

        if ( isdefined( self._ID22785 ) )
            self [[ self._ID22785 ]]( var_0 );
    }
}

getearliestclaimplayer()
{
    var_0 = self._ID7317;

    if ( maps\mp\_utility::_ID18757( self._ID7316 ) )
        var_1 = self._ID7316;
    else
        var_1 = undefined;

    if ( self._ID33167[var_0].size > 0 )
    {
        var_2 = undefined;
        var_3 = getarraykeys( self._ID33167[var_0] );

        for ( var_4 = 0; var_4 < var_3.size; var_4++ )
        {
            var_5 = self._ID33167[var_0][var_3[var_4]];

            if ( maps\mp\_utility::_ID18757( var_5.player ) && ( !isdefined( var_2 ) || var_5._ID31480 < var_2 ) )
            {
                var_1 = var_5.player;
                var_2 = var_5._ID31480;
            }
        }
    }

    return var_1;
}

_ID34759()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    thread _ID25134();

    for (;;)
    {
        if ( self._ID34780 && self.curprogress >= self._ID34780 )
        {
            self.curprogress = 0;
            var_0 = getearliestclaimplayer();

            if ( isdefined( self._ID22816 ) )
                self [[ self._ID22816 ]]( _ID14931(), var_0, isdefined( var_0 ) );

            if ( isdefined( var_0 ) && isdefined( self._ID22916 ) )
                self [[ self._ID22916 ]]( var_0 );

            _ID28674( "none" );
            self._ID7316 = undefined;
        }

        if ( self._ID7317 != "none" )
        {
            if ( self._ID34780 )
            {
                if ( !self._ID22425[self._ID7317] )
                {
                    if ( isdefined( self._ID22816 ) )
                        self [[ self._ID22816 ]]( _ID14931(), self._ID7316, 0 );

                    _ID28674( "none" );
                    self._ID7316 = undefined;
                }
                else
                {
                    self.curprogress = self.curprogress + 50 * self._ID34766;

                    if ( isdefined( self._ID22922 ) )
                        self [[ self._ID22922 ]]( _ID14931(), self.curprogress / self._ID34780, 50 * self._ID34766 / self._ID34780 );
                }
            }
            else
            {
                if ( isdefined( self._ID22916 ) )
                    self [[ self._ID22916 ]]( self._ID7316 );

                _ID28674( "none" );
                self._ID7316 = undefined;
            }
        }

        wait 0.05;
        maps\mp\gametypes\_hostmigration::_ID35770();
    }
}

_ID25134()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    var_0 = self.entnum;

    for (;;)
    {
        self.trigger waittill( "trigger",  var_1  );

        if ( !maps\mp\_utility::_ID18757( var_1 ) )
            continue;

        if ( !maps\mp\_utility::_ID18638( var_1 ) )
            continue;

        if ( isdefined( self.carrier ) )
            continue;

        if ( var_1 maps\mp\_utility::_ID18837() || isdefined( var_1._ID30887 ) )
            continue;

        if ( isdefined( var_1.classname ) && var_1.classname == "script_vehicle" )
            continue;

        if ( !isdefined( var_1._ID17959 ) )
            continue;

        if ( level._ID14086 == "ctfpro" )
        {
            if ( isdefined( self.type ) && self.type == "carryObject" && isdefined( var_1.carryflag ) )
                continue;
        }

        if ( _ID6602( var_1.pers["team"], var_1 ) && self._ID7317 == "none" )
        {
            if ( !isdefined( self._ID19114 ) || isdefined( var_1.carryobject ) && var_1.carryobject == self._ID19114 )
            {
                if ( !_ID25133( var_1 ) )
                    continue;

                _ID28674( var_1.pers["team"] );
                self._ID7316 = var_1;
                var_2 = _ID15313( var_1.pers["team"] );

                if ( isdefined( self._ID32684[var_2] ) )
                    self._ID34780 = self._ID32684[var_2];

                if ( self._ID34780 && isdefined( self._ID22779 ) )
                    self [[ self._ID22779 ]]( self._ID7316 );
            }
            else if ( isdefined( self._ID22785 ) )
                self [[ self._ID22785 ]]( var_1 );
        }

        if ( self._ID34780 && maps\mp\_utility::_ID18757( var_1 ) && !isdefined( var_1._ID33168[var_0] ) )
            var_1 thread _ID33725( self );
    }
}

_ID25133( var_0 )
{
    if ( !isdefined( self._ID26065 ) )
        return 1;

    var_1 = var_0 geteye();
    var_2 = self.trigger.origin + ( 0, 0, 32 );
    var_3 = bullettrace( var_1, var_2, 0, undefined );

    if ( var_3["fraction"] != 1 )
    {
        var_2 = self.trigger.origin + ( 0, 0, 16 );
        var_3 = bullettrace( var_1, var_2, 0, undefined );
    }

    if ( var_3["fraction"] != 1 )
    {
        var_2 = self.trigger.origin + ( 0, 0, 0 );
        var_3 = bullettrace( var_1, var_2, 0, undefined );
    }

    return var_3["fraction"] == 1;
}

_ID28674( var_0 )
{
    if ( self._ID7317 == "none" && gettime() - self._ID19533 > 1000 )
        self.curprogress = 0;
    else if ( var_0 != "none" && var_0 != self._ID19532 )
        self.curprogress = 0;

    self._ID19532 = self._ID7317;
    self._ID19533 = gettime();
    self._ID7317 = var_0;
    _ID34642();
}

_ID14931()
{
    return self._ID7317;
}

_ID33725( var_0 )
{
    var_1 = self.pers["team"];
    var_0._ID22425[var_1]++;
    var_2 = self._ID15851;
    var_3 = spawnstruct();
    var_3.player = self;
    var_3._ID31480 = gettime();
    var_0._ID33167[var_1][var_2] = var_3;

    if ( !isdefined( var_0._ID22331 ) )
        var_0._ID22331 = 0;

    self._ID33168[var_0.entnum] = var_0.trigger;
    var_0 _ID34642();

    while ( maps\mp\_utility::_ID18757( self ) && isdefined( var_0.trigger ) && self istouching( var_0.trigger ) && !level.gameended && var_0._ID34780 )
    {
        if ( isplayer( self ) )
        {
            _ID34638( var_0, 1 );
            _ID34583( var_0, 0 );
        }

        wait 0.05;
    }

    if ( isdefined( self ) )
    {
        if ( isplayer( self ) )
        {
            _ID34638( var_0, 0 );
            _ID34583( var_0, 1 );
        }

        self._ID33168[var_0.entnum] = undefined;
    }

    if ( level.gameended )
        return;

    var_0._ID33167[var_1][var_2] = undefined;
    var_0._ID22425[var_1]--;
    var_0 _ID34642();
}

_ID34583( var_0, var_1 )
{
    var_2 = self.pers["team"];

    if ( var_1 || !var_0 _ID6602( var_2 ) || var_2 != var_0._ID7317 || var_0._ID22331 )
    {
        if ( isdefined( self._ID25120 ) )
            self._ID25120 maps\mp\gametypes\_hud_util::_ID16899();

        if ( isdefined( self.proxbartext ) )
            self.proxbartext maps\mp\gametypes\_hud_util::_ID16899();

        return;
    }

    if ( !isdefined( self._ID25120 ) )
    {
        self._ID25120 = maps\mp\gametypes\_hud_util::createprimaryprogressbar();
        self._ID25120._ID19665 = -1;
        self._ID25120._ID19565 = 0;
    }

    if ( self._ID25120._ID16844 )
    {
        self._ID25120 maps\mp\gametypes\_hud_util::_ID29966();
        self._ID25120._ID19665 = -1;
        self._ID25120._ID19565 = 0;
    }

    if ( !isdefined( self.proxbartext ) )
    {
        self.proxbartext = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
        var_3 = var_0 _ID15313( var_2 );

        if ( isdefined( var_0._ID32683[var_3] ) )
            self.proxbartext settext( var_0._ID32683[var_3] );
        else
            self.proxbartext settext( var_0._ID34779 );
    }

    if ( self.proxbartext._ID16844 )
    {
        self.proxbartext maps\mp\gametypes\_hud_util::_ID29966();
        var_3 = var_0 _ID15313( var_2 );

        if ( isdefined( var_0._ID32683[var_3] ) )
            self.proxbartext settext( var_0._ID32683[var_3] );
        else
            self.proxbartext settext( var_0._ID34779 );
    }

    if ( self._ID25120._ID19665 != var_0._ID34766 || self._ID25120._ID19565 != isdefined( level.hostmigrationtimer ) )
    {
        if ( var_0.curprogress > var_0._ID34780 )
            var_0.curprogress = var_0._ID34780;

        var_4 = var_0.curprogress / var_0._ID34780;
        var_5 = 1000 / var_0._ID34780 * var_0._ID34766;

        if ( isdefined( level.hostmigrationtimer ) )
            var_5 = 0;

        self._ID25120 maps\mp\gametypes\_hud_util::_ID34509( var_4, var_5 );
        self._ID25120._ID19665 = var_0._ID34766;
        self._ID25120._ID19565 = isdefined( level.hostmigrationtimer );
        return;
    }
}

migrationcapturereset( var_0 )
{
    var_0.migrationcapturereset = 1;
    level waittill( "host_migration_begin" );

    if ( !isdefined( var_0 ) || !isdefined( self ) )
        return;

    var_0 setclientomnvar( "ui_securing", 0 );
    var_0 setclientomnvar( "ui_securing_progress", 0 );
    self.migrationcapturereset = undefined;
}

_ID34638( var_0, var_1 )
{
    if ( !isdefined( level.hostmigrationtimer ) )
    {
        if ( var_0.curprogress > var_0._ID34780 )
            var_0.curprogress = var_0._ID34780;

        var_2 = var_0.curprogress / var_0._ID34780;

        if ( hasdomflags() && isdefined( var_0._ID17334 ) && var_0._ID17334 == "domFlag" )
        {
            var_3 = 0;

            if ( var_0.label == "_a" )
                var_3 = 1;
            else if ( var_0.label == "_b" )
                var_3 = 2;
            else if ( var_0.label == "_c" )
                var_3 = 3;

            if ( var_1 && isdefined( var_0._ID31162 ) && var_0._ID31162 )
            {
                if ( !isdefined( self._ID34178 ) )
                {
                    if ( !isdefined( self.ui_dom_securing ) )
                    {
                        self setclientomnvar( "ui_dom_securing", var_3 );
                        self.ui_dom_securing = 1;
                    }

                    self setclientomnvar( "ui_dom_stalemate", 1 );
                    self._ID34178 = 1;
                }

                var_2 = 0.01;
            }
            else
            {
                if ( !var_1 && isdefined( self._ID34178 ) )
                {
                    self setclientomnvar( "ui_dom_securing", 0 );
                    self.ui_dom_securing = undefined;
                }

                if ( var_1 && !isdefined( self._ID34178 ) && var_0._ID23192 == self.team )
                {
                    self setclientomnvar( "ui_dom_securing", 0 );
                    self.ui_dom_securing = undefined;
                }

                if ( var_1 && !isdefined( self.ui_dom_securing ) && var_0._ID23192 != self.team )
                {
                    self setclientomnvar( "ui_dom_securing", var_3 );
                    self.ui_dom_securing = 1;
                }

                self setclientomnvar( "ui_dom_stalemate", 0 );
                self._ID34178 = undefined;
            }

            if ( !var_1 )
            {
                var_2 = 0.01;
                self setclientomnvar( "ui_dom_securing", 0 );
                self.ui_dom_securing = undefined;
            }

            if ( var_2 != 0 )
            {
                self setclientomnvar( "ui_dom_progress", var_2 );
                return;
            }

            return;
        }

        if ( ( level._ID14086 == "sd" || level._ID14086 == "sr" ) && isdefined( var_0._ID17334 ) && ( var_0._ID17334 == "bomb_zone" || var_0._ID17334 == "defuse_object" ) )
        {
            if ( var_1 )
            {
                if ( !isdefined( self.ui_bomb_planting_defusing ) )
                {
                    var_4 = 0;

                    if ( var_0._ID17334 == "bomb_zone" )
                        var_4 = 1;
                    else if ( var_0._ID17334 == "defuse_object" )
                        var_4 = 2;

                    self setclientomnvar( "ui_bomb_planting_defusing", var_4 );
                    self.ui_bomb_planting_defusing = 1;
                }
            }
            else
            {
                self setclientomnvar( "ui_bomb_planting_defusing", 0 );
                self.ui_bomb_planting_defusing = undefined;
                var_2 = 0.01;
            }

            if ( var_2 != 0 )
            {
                self setclientomnvar( "ui_planting_defusing_progress", var_2 );
                return;
            }

            return;
        }

        if ( isdefined( var_0._ID17334 ) )
        {
            var_4 = 0;

            switch ( var_0._ID17334 )
            {
                case "care_package":
                    var_4 = 1;
                    break;
                case "intel":
                    var_4 = 2;
                    break;
                case "deployable_vest":
                    var_4 = 3;
                    break;
                case "deployable_weapon_crate":
                    var_4 = 4;
                    break;
                case "last_stand":
                    var_4 = 5;

                    if ( isdefined( self._ID18011 ) && self._ID18011 )
                        var_4 = 6;

                    break;
                case "breach":
                    var_4 = 7;
                    break;
                case "use":
                    var_4 = 8;
                    break;
            }

            _ID34640( var_2, var_1, var_4, var_0 );
            return;
        }

        return;
        return;
        return;
    }
}

hasdomflags()
{
    if ( level._ID14086 == "dom" || level._ID14086 == "siege" )
        return 1;

    return 0;
}

_ID34640( var_0, var_1, var_2, var_3 )
{
    if ( var_1 )
    {
        if ( !isdefined( var_3._ID34737 ) )
            var_3._ID34737 = [];

        if ( !isdefined( self.migrationcapturereset ) )
            var_3 thread migrationcapturereset( self );

        if ( !_ID12420( self, var_3._ID34737 ) )
            var_3._ID34737[var_3._ID34737.size] = self;

        if ( !isdefined( self._ID34183 ) )
        {
            self setclientomnvar( "ui_securing", var_2 );
            self._ID34183 = 1;
        }
    }
    else
    {
        if ( isdefined( var_3._ID34737 ) && _ID12420( self, var_3._ID34737 ) )
            var_3._ID34737 = common_scripts\utility::array_remove( var_3._ID34737, self );

        self setclientomnvar( "ui_securing", 0 );
        self._ID34183 = undefined;
        var_0 = 0.01;
    }

    if ( var_0 != 0 )
    {
        self setclientomnvar( "ui_securing_progress", var_0 );
        return;
    }
}

_ID12420( var_0, var_1 )
{
    if ( var_1.size > 0 )
    {
        foreach ( var_3 in var_1 )
        {
            if ( var_3 == var_0 )
                return 1;
        }
    }

    return 0;
}

_ID34642()
{
    var_0 = self._ID22425[self._ID7317];
    var_1 = 0;
    var_2 = 0;

    if ( level.multiteambased )
    {
        foreach ( var_4 in level._ID32668 )
        {
            if ( self._ID7317 != var_4 )
                var_1 += self._ID22425[var_4];
        }
    }
    else
    {
        if ( self._ID7317 != "axis" )
            var_1 += self._ID22425["axis"];

        if ( self._ID7317 != "allies" )
            var_1 += self._ID22425["allies"];
    }

    foreach ( var_7 in self._ID33167[self._ID7317] )
    {
        if ( !isdefined( var_7.player ) )
            continue;

        if ( var_7.player.pers["team"] != self._ID7317 )
            continue;

        if ( var_7.player.objectivescaler == 1 )
            continue;

        var_0 *= var_7.player.objectivescaler;
        var_2 = var_7.player.objectivescaler;
    }

    self._ID34766 = 0;
    self._ID31162 = var_0 && var_1;

    if ( var_0 && !var_1 )
        self._ID34766 = min( var_0, 4 );

    if ( isdefined( self._ID18551 ) && self._ID18551 && var_2 != 0 )
    {
        self._ID34766 = 1 * var_2;
        return;
    }

    if ( isdefined( self._ID18551 ) && self._ID18551 )
    {
        self._ID34766 = 1;
        return;
    }

    return;
}

_ID34751( var_0 )
{
    var_0 notify( "use_hold" );

    if ( isplayer( var_0 ) )
        var_0 playerlinkto( self.trigger );
    else
        var_0 linkto( self.trigger );

    var_0 playerlinkedoffsetenable();
    var_0 clientclaimtrigger( self.trigger );
    var_0.claimtrigger = self.trigger;
    var_1 = self._ID34784;
    var_2 = var_0 getcurrentweapon();

    if ( isdefined( var_1 ) )
    {
        if ( var_2 == var_1 )
            var_2 = var_0._ID19588;

        var_0._ID19588 = var_2;
        var_0 maps\mp\_utility::_giveweapon( var_1 );
        var_0 setweaponammostock( var_1, 0 );
        var_0 setweaponammoclip( var_1, 0 );
        var_0 switchtoweapon( var_1 );
    }
    else
        var_0 common_scripts\utility::_disableweapon();

    self.curprogress = 0;
    self._ID18318 = 1;
    self._ID34766 = 0;
    var_3 = useholdthinkloop( var_0, var_2 );

    if ( isdefined( var_0 ) )
    {
        var_0 detachusemodels();
        var_0 notify( "done_using" );
    }

    if ( isdefined( var_1 ) && isdefined( var_0 ) )
        var_0 thread _ID32398( var_1 );

    if ( isdefined( var_3 ) && var_3 )
        return 1;

    if ( isdefined( var_0 ) )
    {
        var_0.claimtrigger = undefined;

        if ( isdefined( var_1 ) )
        {
            if ( var_2 != "none" )
                var_0 maps\mp\_utility::_ID32279( var_2 );
            else
                var_0 takeweapon( var_1 );
        }
        else
            var_0 common_scripts\utility::_enableweapon();

        var_0 unlink();

        if ( !maps\mp\_utility::_ID18757( var_0 ) )
            var_0.killedinuse = 1;
    }

    self._ID18318 = 0;
    self.trigger releaseclaimedtrigger();
    return 0;
}

detachusemodels()
{
    if ( isdefined( self.attachedusemodel ) )
    {
        self detach( self.attachedusemodel, "tag_inhand" );
        self.attachedusemodel = undefined;
        return;
    }
}

_ID32398( var_0 )
{
    self endon( "use_hold" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( self getcurrentweapon() == var_0 && !isdefined( self._ID32944 ) )
        wait 0.05;

    self takeweapon( var_0 );
}

_ID34778( var_0, var_1, var_2, var_3 )
{
    if ( !maps\mp\_utility::_ID18757( var_0 ) )
        return 0;

    if ( !var_0 istouching( self.trigger ) )
        return 0;

    if ( !var_0 usebuttonpressed() )
        return 0;

    if ( isdefined( var_0._ID32944 ) )
        return 0;

    if ( var_0 meleebuttonpressed() )
        return 0;

    if ( self.curprogress >= self._ID34780 )
        return 0;

    if ( !self._ID34766 && !var_1 )
        return 0;

    if ( var_1 && var_2 > var_3 )
        return 0;

    return 1;
}

useholdthinkloop( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "disabled" );
    var_2 = self._ID34784;
    var_3 = 1;

    if ( isdefined( self.waitforweapononuse ) )
        var_3 = self.waitforweapononuse;

    if ( !var_3 )
        self._ID34766 = 1 * var_0.objectivescaler;

    var_4 = 0;
    var_5 = 1.5;

    while ( _ID34778( var_0, var_3, var_4, var_5 ) )
    {
        var_4 += 0.05;

        if ( !var_3 || !isdefined( var_2 ) || var_0 getcurrentweapon() == var_2 )
        {
            self.curprogress = self.curprogress + 50 * self._ID34766;
            self._ID34766 = 1 * var_0.objectivescaler;
            var_3 = 0;
        }
        else
            self._ID34766 = 0;

        var_0 _ID34638( self, 1 );

        if ( self.curprogress >= self._ID34780 )
        {
            self._ID18318 = 0;
            var_0 clientreleasetrigger( self.trigger );
            var_0.claimtrigger = undefined;

            if ( isdefined( var_2 ) )
            {
                var_0 setweaponammostock( var_2, 1 );
                var_0 setweaponammoclip( var_2, 1 );

                if ( var_1 != "none" )
                    var_0 maps\mp\_utility::_ID32279( var_1 );
                else
                    var_0 takeweapon( var_2 );
            }
            else
                var_0 common_scripts\utility::_enableweapon();

            var_0 unlink();
            return maps\mp\_utility::_ID18757( var_0 );
        }

        wait 0.05;
        maps\mp\gametypes\_hostmigration::_ID35770();
    }

    var_0 _ID34638( self, 0 );
    return 0;
}

_ID34634()
{
    if ( self._ID33726 != "use" )
        return;

    if ( self._ID18086 == "none" )
    {
        self.trigger.origin = self.trigger.origin - ( 0, 0, 50000 );
        return;
    }

    if ( self._ID18086 == "any" )
    {
        self.trigger.origin = self.curorigin;
        self.trigger setteamfortrigger( "none" );
        return;
    }

    if ( self._ID18086 == "friendly" )
    {
        self.trigger.origin = self.curorigin;

        if ( self._ID23192 == "allies" )
        {
            self.trigger setteamfortrigger( "allies" );
            return;
        }

        if ( self._ID23192 == "axis" )
        {
            self.trigger setteamfortrigger( "axis" );
            return;
        }

        self.trigger.origin = self.trigger.origin - ( 0, 0, 50000 );
        return;
        return;
        return;
    }

    if ( self._ID18086 == "enemy" )
    {
        self.trigger.origin = self.curorigin;

        if ( self._ID23192 == "allies" )
        {
            self.trigger setteamfortrigger( "axis" );
            return;
        }

        if ( self._ID23192 == "axis" )
        {
            self.trigger setteamfortrigger( "allies" );
            return;
        }

        self.trigger setteamfortrigger( "none" );
        return;
        return;
        return;
    }

    return;
    return;
    return;
}

updateworldicons()
{
    if ( self._ID35317 == "any" )
    {
        _ID34649( "friendly", 1 );
        _ID34649( "enemy", 1 );
        return;
    }

    if ( self._ID35317 == "friendly" )
    {
        _ID34649( "friendly", 1 );
        _ID34649( "enemy", 0 );
        return;
    }

    if ( self._ID35317 == "enemy" )
    {
        _ID34649( "friendly", 0 );
        _ID34649( "enemy", 1 );
        return;
    }

    _ID34649( "friendly", 0 );
    _ID34649( "enemy", 0 );
    return;
    return;
    return;
}

_ID34649( var_0, var_1 )
{
    if ( !isdefined( self._ID36422[var_0] ) )
        var_1 = 0;

    var_2 = _ID15455( var_0 );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = "objpoint_" + var_2[var_3] + "_" + self.entnum;
        var_5 = maps\mp\gametypes\_objpoints::getobjpointbyname( var_4 );
        var_5 notify( "stop_flashing_thread" );
        var_5 thread maps\mp\gametypes\_objpoints::_ID31839();

        if ( var_1 )
        {
            var_5 setshader( self._ID36422[var_0], level._ID22507, level._ID22507 );
            var_5 fadeovertime( 0.05 );
            var_5.alpha = var_5.basealpha;
            var_5._ID18782 = 1;

            if ( isdefined( self._ID7838[var_0] ) )
                var_5 setwaypoint( 1, 1 );
            else
                var_5 setwaypoint( 1, 0 );

            if ( self.type == "carryObject" )
            {
                if ( isdefined( self.carrier ) && !_ID29880( var_0 ) )
                    var_5 settargetent( self.carrier );
                else
                    var_5 cleartargetent();
            }
            else if ( isdefined( self.objiconent ) )
                var_5 settargetent( self.objiconent );
        }
        else
        {
            var_5 fadeovertime( 0.05 );
            var_5.alpha = 0;
            var_5._ID18782 = 0;
            var_5 cleartargetent();
        }

        var_5 thread hideworldiconongameend();
    }
}

hideworldiconongameend()
{
    self notify( "hideWorldIconOnGameEnd" );
    self endon( "hideWorldIconOnGameEnd" );
    self endon( "death" );
    level waittill( "game_ended" );

    if ( isdefined( self ) )
    {
        self.alpha = 0;
        return;
    }
}

_ID34631( var_0, var_1 )
{

}

_ID34525()
{
    if ( self._ID35317 == "any" )
    {
        _ID34524( "friendly", 1 );
        _ID34524( "enemy", 1 );
        return;
    }

    if ( self._ID35317 == "friendly" )
    {
        _ID34524( "friendly", 1 );
        _ID34524( "enemy", 0 );
        return;
    }

    if ( self._ID35317 == "enemy" )
    {
        _ID34524( "friendly", 0 );
        _ID34524( "enemy", 1 );
        return;
    }

    _ID34524( "friendly", 0 );
    _ID34524( "enemy", 0 );
    return;
    return;
    return;
}

_ID34524( var_0, var_1 )
{
    var_2 = _ID15455( var_0 );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = var_2[var_3];
        var_5 = var_1;

        if ( !var_5 && _ID29889( var_4 ) )
            var_5 = 1;

        var_6 = self._ID32670[var_4];

        if ( !isdefined( self._ID7838[var_0] ) || !var_5 )
        {
            objective_state( var_6, "invisible" );
            continue;
        }

        objective_icon( var_6, self._ID7838[var_0] );
        objective_state( var_6, "active" );

        if ( self.type == "carryObject" )
        {
            if ( maps\mp\_utility::_ID18757( self.carrier ) && !_ID29880( var_0 ) )
                objective_onentity( var_6, self.carrier );
            else if ( isdefined( self._ID35361[0] ) && isdefined( self._ID35361[0] getlinkedparent() ) )
                objective_onentity( var_6, self._ID35361[0] );
            else
                objective_position( var_6, self.curorigin );

            continue;
        }

        if ( isdefined( self.objiconent ) )
            objective_onentity( var_6, self.objiconent );
    }
}

_ID29880( var_0 )
{
    if ( var_0 == "friendly" && self._ID22501 )
        return 1;
    else if ( var_0 == "enemy" && self._ID22500 )
        return 1;

    return 0;
}

_ID15455( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level._ID32668 )
    {
        if ( var_0 == "friendly" )
        {
            if ( isfriendlyteam( var_3 ) )
                var_1[var_1.size] = var_3;

            continue;
        }

        if ( var_0 == "enemy" )
        {
            if ( !isfriendlyteam( var_3 ) )
                var_1[var_1.size] = var_3;
        }
    }

    return var_1;
}

_ID29889( var_0 )
{
    if ( !isdefined( self.carrier ) )
        return 0;

    if ( self.carrier maps\mp\_utility::_hasperk( "specialty_gpsjammer" ) )
        return 0;

    return getteamradar( var_0 );
}

_ID34643()
{
    self endon( "death" );
    self endon( "carrier_cleared" );

    for (;;)
    {
        level waittill( "radar_status_change" );
        _ID34525();
    }
}

_ID28813( var_0 )
{
    self._ID23192 = var_0;
    _ID34634();
    _ID34525();
    updateworldicons();

    if ( var_0 != "neutral" )
    {
        self._ID24948 = var_0;
        return;
    }
}

_ID15224()
{
    return self._ID23192;
}

_ID29198( var_0 )
{
    self._ID34780 = int( var_0 * 1000 );
}

setwaitweaponchangeonuse( var_0 )
{
    self.waitforweapononuse = var_0;
}

_ID29197( var_0 )
{
    self._ID34779 = var_0;
}

_ID28899( var_0, var_1 )
{
    self._ID32684[var_0] = int( var_1 * 1000 );
}

_ID28898( var_0, var_1 )
{
    self._ID32683[var_0] = var_1;
}

_ID29196( var_0 )
{
    self.trigger sethintstring( var_0 );
}

_ID2974( var_0 )
{
    self._ID18086 = var_0;
}

allowuse( var_0 )
{
    self._ID18086 = var_0;
    _ID34634();
}

_ID29202( var_0 )
{
    self._ID35317 = var_0;
    _ID34525();
    updateworldicons();
}

_ID28788( var_0 )
{
    if ( var_0 )
    {
        for ( var_1 = 0; var_1 < self._ID35361.size; var_1++ )
        {
            self._ID35361[var_1] show();

            if ( self._ID35361[var_1].classname == "script_brushmodel" || self._ID35361[var_1].classname == "script_model" )
            {
                foreach ( var_3 in level.players )
                {
                    if ( var_3 istouching( self._ID35361[var_1] ) )
                        var_3 maps\mp\_utility::_suicide();
                }

                self._ID35361[var_1] thread _ID20510();
            }
        }

        return;
    }

    for ( var_1 = 0; var_1 < self._ID35361.size; var_1++ )
    {
        self._ID35361[var_1] hide();

        if ( self._ID35361[var_1].classname == "script_brushmodel" || self._ID35361[var_1].classname == "script_model" )
        {
            self._ID35361[var_1] notify( "changing_solidness" );
            self._ID35361[var_1] notsolid();
        }
    }

    return;
}

_ID20510()
{
    self endon( "death" );
    self notify( "changing_solidness" );
    self endon( "changing_solidness" );

    for (;;)
    {
        for ( var_0 = 0; var_0 < level.players.size; var_0++ )
        {
            if ( level.players[var_0] istouching( self ) )
                break;
        }

        if ( var_0 == level.players.size )
        {
            self solid();
            break;
        }

        wait 0.05;
    }
}

setcarriervisible( var_0 )
{
    self.carriervisible = var_0;
}

_ID28661( var_0 )
{
    self._ID34777 = var_0;
}

_ID28180( var_0, var_1 )
{
    self._ID7838[var_0] = var_1;
    _ID34525();
}

_ID28181( var_0, var_1 )
{
    self._ID36422[var_0] = var_1;
    updateworldicons();
}

set3duseicon( var_0, var_1 )
{
    self._ID36424[var_0] = var_1;
}

setcarryicon( var_0 )
{
    self.carryicon = var_0;
}

_ID10167()
{
    self notify( "disabled" );

    if ( self.type == "carryObject" )
    {
        if ( isdefined( self.carrier ) )
            self.carrier _ID32393( self );

        for ( var_0 = 0; var_0 < self._ID35361.size; var_0++ )
            self._ID35361[var_0] hide();
    }

    self.trigger common_scripts\utility::_ID33657();
    _ID29202( "none" );
}

_ID11498()
{
    if ( self.type == "carryObject" )
    {
        for ( var_0 = 0; var_0 < self._ID35361.size; var_0++ )
            self._ID35361[var_0] show();
    }

    self.trigger common_scripts\utility::_ID33659();
    _ID29202( "any" );
}

_ID15313( var_0 )
{
    if ( var_0 == self._ID23192 )
    {
        return "friendly";
        return;
    }

    return "enemy";
    return;
}

isfriendlyteam( var_0 )
{
    if ( self._ID23192 == "any" )
        return 1;

    if ( self._ID23192 == var_0 )
        return 1;

    if ( self._ID23192 == "neutral" && isdefined( self._ID24948 ) && self._ID24948 == var_0 )
        return 1;

    return 0;
}

_ID6602( var_0, var_1 )
{
    switch ( self._ID18086 )
    {
        case "none":
            return 0;
        case "any":
            return 1;
        case "friendly":
            if ( var_0 == self._ID23192 )
                return 1;
            else
                return 0;
        case "enemy":
            if ( var_0 != self._ID23192 )
                return 1;
            else
                return 0;
        default:
            return 0;
    }
}

isteam( var_0 )
{
    if ( var_0 == "neutral" )
        return 1;

    if ( var_0 == "allies" )
        return 1;

    if ( var_0 == "axis" )
        return 1;

    if ( var_0 == "any" )
        return 1;

    if ( var_0 == "none" )
        return 1;

    foreach ( var_2 in level._ID32668 )
    {
        if ( var_0 == var_2 )
            return 1;
    }

    return 0;
}

isrelativeteam( var_0 )
{
    if ( var_0 == "friendly" )
        return 1;

    if ( var_0 == "enemy" )
        return 1;

    if ( var_0 == "any" )
        return 1;

    if ( var_0 == "none" )
        return 1;

    return 0;
}

_ID15002( var_0 )
{
    if ( level.multiteambased )
    {

    }

    if ( var_0 == "neutral" )
    {
        return "none";
        return;
    }

    if ( var_0 == "allies" )
    {
        return "axis";
        return;
    }

    return "allies";
    return;
    return;
}

getnextobjid()
{
    if ( !isdefined( level._ID25604 ) || level._ID25604.size < 1 )
    {
        var_0 = level._ID22408;
        level._ID22408++;
    }
    else
    {
        var_0 = level._ID25604[level._ID25604.size - 1];
        level._ID25604[level._ID25604.size - 1] = undefined;
    }

    if ( var_0 > 31 )
        var_0 = 31;

    return var_0;
}

_ID15110()
{
    var_0 = self.trigger._ID27658;

    if ( !isdefined( var_0 ) )
    {
        var_0 = "";
        return var_0;
    }

    if ( var_0[0] != "_" )
        return "_" + var_0;

    return var_0;
}

_ID17961()
{
    self._ID21893 = undefined;
    self.calculated_nearest_node = 0;
    self.on_path_grid = undefined;
}
