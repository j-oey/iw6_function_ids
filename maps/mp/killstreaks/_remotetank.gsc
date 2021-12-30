// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["remote_tank"] = ::_ID33870;
    level._ID32563 = [];
    level._ID32563["remote_tank"] = spawnstruct();
    level._ID32563["remote_tank"].timeout = 60.0;
    level._ID32563["remote_tank"].health = 99999;
    level._ID32563["remote_tank"].maxhealth = 1000;
    level._ID32563["remote_tank"]._ID31889 = "remote_tank";
    level._ID32563["remote_tank"]._ID21006 = "ugv_turret_mp";
    level._ID32563["remote_tank"]._ID21192 = "remote_tank_projectile_mp";
    level._ID32563["remote_tank"]._ID28167 = "sentry_offline";
    level._ID32563["remote_tank"]._ID35155 = "remote_ugv_mp";
    level._ID32563["remote_tank"].modelbase = "vehicle_ugv_talon_mp";
    level._ID32563["remote_tank"].modelmgturret = "vehicle_ugv_talon_gun_mp";
    level._ID32563["remote_tank"]._ID21276 = "vehicle_ugv_talon_obj";
    level._ID32563["remote_tank"]._ID21277 = "vehicle_ugv_talon_obj_red";
    level._ID32563["remote_tank"]._ID21271 = "vehicle_ugv_talon_mp";
    level._ID32563["remote_tank"]._ID31975 = &"KILLSTREAKS_REMOTE_TANK_PLACE";
    level._ID32563["remote_tank"].stringcannotplace = &"KILLSTREAKS_REMOTE_TANK_CANNOT_PLACE";
    level._ID32563["remote_tank"]._ID19344 = "killstreak_remote_tank_laptop_mp";
    level._ID32563["remote_tank"]._ID25816 = "killstreak_remote_tank_remote_mp";
    level._ID1644["remote_tank_dying"] = loadfx( "fx/explosions/killstreak_explosion_quick" );
    level._ID1644["remote_tank_explode"] = loadfx( "fx/explosions/bouncing_betty_explosion" );
    level._ID1644["remote_tank_spark"] = loadfx( "fx/impacts/large_metal_painted_hit" );
    level._ID1644["remote_tank_antenna_light_mp"] = loadfx( "fx/misc/aircraft_light_red_blink" );
    level._ID1644["remote_tank_camera_light_mp"] = loadfx( "fx/misc/aircraft_light_wingtip_green" );
    level._ID25752 = 0.5;
}

_ID33870( var_0, var_1 )
{
    var_2 = 1;

    if ( maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 + var_2 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        return 0;
    }

    maps\mp\_utility::_ID17543();
    var_3 = givetank( var_0, "remote_tank" );

    if ( var_3 )
    {
        maps\mp\_matchdata::_ID20253( "remote_tank", self.origin );
        thread maps\mp\_utility::_ID32672( "used_remote_tank", self );
        _ID32392( "remote_tank" );
    }
    else
        maps\mp\_utility::decrementfauxvehiclecount();

    self._ID18582 = 0;
    return var_3;
}

_ID32392( var_0 )
{
    if ( !maps\mp\_utility::_ID18363() )
        var_1 = maps\mp\_utility::getkillstreakweapon( level._ID32563[var_0]._ID31889 );
    else
        var_1 = "killstreak_remote_tank_mp";

    maps\mp\killstreaks\_killstreaks::_ID32391( var_1 );
    self takeweapon( level._ID32563[var_0]._ID19344 );
    self takeweapon( level._ID32563[var_0]._ID25816 );
}

_ID26022()
{
    if ( maps\mp\_utility::_hasperk( "specialty_explosivebullets" ) )
    {
        self._ID26205 = "specialty_explosivebullets";
        maps\mp\_utility::_unsetperk( "specialty_explosivebullets" );
    }
}

_ID26206()
{
    if ( isdefined( self._ID26205 ) )
    {
        maps\mp\_utility::_ID15611( self._ID26205, 0 );
        self._ID26205 = undefined;
    }
}

_ID35602()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait 0.05;
    _ID26206();
}

_ID26046()
{
    var_0 = self getweaponslistprimaries();

    foreach ( var_2 in var_0 )
    {
        var_3 = strtok( var_2, "_" );

        if ( var_3[0] == "alt" )
        {
            self._ID26214[var_2] = self getweaponammoclip( var_2 );
            self._ID26216[var_2] = self getweaponammostock( var_2 );
            continue;
        }

        self._ID26214[var_2] = self getweaponammoclip( var_2 );
        self._ID26216[var_2] = self getweaponammostock( var_2 );
    }

    self._ID36293 = [];

    foreach ( var_2 in var_0 )
    {
        var_3 = strtok( var_2, "_" );
        self._ID36293[self._ID36293.size] = var_2;

        if ( var_3[0] == "alt" )
            continue;

        self takeweapon( var_2 );
    }
}

_ID26215()
{
    if ( !isdefined( self._ID26214 ) || !isdefined( self._ID26216 ) || !isdefined( self._ID36293 ) )
        return;

    var_0 = [];

    foreach ( var_2 in self._ID36293 )
    {
        var_3 = strtok( var_2, "_" );

        if ( var_3[0] == "alt" )
        {
            var_0[var_0.size] = var_2;
            continue;
        }

        maps\mp\_utility::_giveweapon( var_2 );

        if ( isdefined( self._ID26214[var_2] ) )
            self setweaponammoclip( var_2, self._ID26214[var_2] );

        if ( isdefined( self._ID26216[var_2] ) )
            self setweaponammostock( var_2, self._ID26216[var_2] );
    }

    foreach ( var_6 in var_0 )
    {
        if ( isdefined( self._ID26214[var_6] ) )
            self setweaponammoclip( var_6, self._ID26214[var_6] );

        if ( isdefined( self._ID26216[var_6] ) )
            self setweaponammostock( var_6, self._ID26216[var_6] );
    }

    self._ID26214 = undefined;
    self._ID26216 = undefined;
}

_ID35603()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait 0.05;
    _ID26215();
}

givetank( var_0, var_1 )
{
    var_2 = _ID8485( var_1, self );
    var_2._ID19938 = var_0;
    _ID26022();
    _ID26046();
    var_3 = setcarryingtank( var_2, 1 );
    thread _ID26206();
    thread _ID26215();

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    return var_3;
}

_ID8485( var_0, var_1 )
{
    var_2 = spawnturret( "misc_turret", var_1.origin + ( 0, 0, 25 ), level._ID32563[var_0]._ID21006 );
    var_2.angles = var_1.angles;
    var_2._ID32568 = var_0;
    var_2.owner = var_1;
    var_2 setmodel( level._ID32563[var_0].modelbase );
    var_2 maketurretinoperable();
    var_2 setturretmodechangewait( 1 );
    var_2 setmode( "sentry_offline" );
    var_2 makeunusable();
    var_2 setsentryowner( var_1 );
    return var_2;
}

setcarryingtank( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_0 thread _ID32519( self );
    common_scripts\utility::_disableweapon();
    self notifyonplayercommand( "place_tank", "+attack" );
    self notifyonplayercommand( "place_tank", "+attack_akimbo_accessible" );
    self notifyonplayercommand( "cancel_tank", "+actionslot 4" );

    if ( !level.console )
    {
        self notifyonplayercommand( "cancel_tank", "+actionslot 5" );
        self notifyonplayercommand( "cancel_tank", "+actionslot 6" );
        self notifyonplayercommand( "cancel_tank", "+actionslot 7" );
    }

    for (;;)
    {
        var_2 = common_scripts\utility::_ID35635( "place_tank", "cancel_tank", "force_cancel_placement" );

        if ( var_2 == "cancel_tank" || var_2 == "force_cancel_placement" )
        {
            if ( !var_1 && var_2 == "cancel_tank" )
                continue;

            if ( level.console )
            {
                var_3 = maps\mp\_utility::getkillstreakweapon( level._ID32563[var_0._ID32568]._ID31889 );

                if ( isdefined( self._ID19258 ) && var_3 == maps\mp\_utility::getkillstreakweapon( self.pers["killstreaks"][self._ID19258]._ID31889 ) && !self getweaponslistitems().size )
                {
                    maps\mp\_utility::_giveweapon( var_3, 0 );
                    maps\mp\_utility::_setactionslot( 4, "weapon", var_3 );
                }
            }

            var_0 _ID32518();
            common_scripts\utility::_enableweapon();
            return 0;
        }

        if ( !var_0.canbeplaced )
            continue;

        var_0 thread _ID32521();
        common_scripts\utility::_enableweapon();
        return 1;
    }
}

_ID32519( var_0 )
{
    self setmodel( level._ID32563[self._ID32568]._ID21276 );
    self setsentrycarrier( var_0 );
    self setcontents( 0 );
    self setcandamage( 0 );
    self.carriedby = var_0;
    var_0._ID18582 = 1;
    var_0 thread _ID34619( self );
    thread _ID32505( var_0 );
    thread _ID32506( var_0 );
    thread _ID32507();
    self notify( "carried" );
}

_ID34619( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "placed" );
    var_0 endon( "death" );
    var_0.canbeplaced = 1;
    var_1 = -1;

    for (;;)
    {
        var_2 = self canplayerplacetank( 25.0, 25.0, 50.0, 40.0, 80.0, 0.7 );
        var_0.origin = var_2["origin"];
        var_0.angles = var_2["angles"];
        var_0.canbeplaced = self isonground() && var_2["result"] && abs( var_2["origin"][2] - self.origin[2] ) < 20;

        if ( maps\mp\_utility::_ID18363() )
            var_0.canbeplaced = var_0.canbeplaced && !self._ID18011;

        if ( var_0.canbeplaced != var_1 )
        {
            if ( var_0.canbeplaced )
            {
                var_0 setmodel( level._ID32563[var_0._ID32568]._ID21276 );

                if ( self.team != "spectator" )
                    self forceusehinton( level._ID32563[var_0._ID32568]._ID31975 );
            }
            else
            {
                var_0 setmodel( level._ID32563[var_0._ID32568]._ID21277 );

                if ( self.team != "spectator" )
                {
                    if ( !maps\mp\_utility::_ID18363() )
                        self forceusehinton( level._ID32563[var_0._ID32568].stringcannotplace );
                    else if ( !self._ID18011 )
                        self forceusehinton( level._ID32563[var_0._ID32568].stringcannotplace );
                }
            }
        }

        var_1 = var_0.canbeplaced;
        wait 0.05;
    }
}

_ID32505( var_0 )
{
    self endon( "placed" );
    self endon( "death" );

    if ( !maps\mp\_utility::_ID18363() )
        var_0 waittill( "death" );
    else
    {
        var_0 common_scripts\utility::_ID35626( "death", "last_stand" );
        var_0 notify( "cancel_tank" );
    }

    _ID32518();
}

_ID32506( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    var_0 waittill( "disconnect" );
    _ID32518();
}

_ID32507( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    level waittill( "game_ended" );
    _ID32518();
}

_ID32518()
{
    if ( isdefined( self.carriedby ) )
        self.carriedby forceusehintoff();

    if ( isdefined( self.owner ) )
        self.owner._ID18582 = 0;

    if ( isdefined( self ) )
        self delete();
}

_ID32521()
{
    self endon( "death" );
    level endon( "game_ended" );
    self notify( "placed" );
    self.carriedby forceusehintoff();
    self.carriedby = undefined;

    if ( !isdefined( self.owner ) )
        return 0;

    var_0 = self.owner;
    var_0._ID18582 = 0;
    var_1 = createtank( self );

    if ( !isdefined( var_1 ) )
        return 0;

    var_1 playsound( "sentry_gun_plant" );
    var_1 notify( "placed" );
    var_1 thread _ID32517();
    self delete();
}

_ID32469()
{
    self endon( "death" );
    level endon( "game_ended" );

    if ( !isdefined( self.owner ) )
        return;

    var_0 = self.owner;
    var_0 endon( "death" );
    self waittill( "placed" );
    var_0 _ID32392( self._ID32568 );
    var_0 maps\mp\_utility::_giveweapon( level._ID32563[self._ID32568]._ID19344 );
    var_0 switchtoweaponimmediate( level._ID32563[self._ID32568]._ID19344 );
}

createtank( var_0 )
{
    var_1 = var_0.owner;
    var_2 = var_0._ID32568;
    var_3 = var_0._ID19938;
    var_4 = spawnvehicle( level._ID32563[var_2].modelbase, var_2, level._ID32563[var_2]._ID35155, var_0.origin, var_0.angles, var_1 );

    if ( !isdefined( var_4 ) )
        return undefined;

    var_5 = var_4 gettagorigin( "tag_turret_attach" );
    var_6 = spawnturret( "misc_turret", var_5, level._ID32563[var_2]._ID21006, 0 );
    var_6 linkto( var_4, "tag_turret_attach", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_6 setmodel( level._ID32563[var_2].modelmgturret );
    var_6.health = level._ID32563[var_2].health;
    var_6.owner = var_1;
    var_6.angles = var_1.angles;
    var_6._ID30953 = ::callback_vehicledamage;
    var_6._ID32426 = var_4;
    var_6 makeunusable();
    var_6 setdefaultdroppitch( 0 );
    var_6 setcandamage( 0 );
    var_4._ID30953 = ::callback_vehicledamage;
    var_4._ID19938 = var_3;
    var_4.team = var_1.team;
    var_4.owner = var_1;
    var_4 setotherent( var_1 );
    var_4._ID21003 = var_6;
    var_4.health = level._ID32563[var_2].health;
    var_4.maxhealth = level._ID32563[var_2].maxhealth;
    var_4.damagetaken = 0;
    var_4.destroyed = 0;
    var_4 setcandamage( 0 );
    var_4._ID32568 = var_2;
    var_4 common_scripts\utility::_ID20489( var_4.team );
    var_6 setturretmodechangewait( 1 );
    var_4 tank_setinactive();
    var_6 setsentryowner( var_1 );
    var_1._ID34792 = 0;
    var_4.empgrenaded = 0;
    var_4._ID8967 = 1.0;
    var_4 thread _ID32499();
    var_4 thread tank_watchlowhealth();
    var_4 thread _ID32469();
    return var_4;
}

_ID32517()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );
    self makeunusable();
    self._ID21003 maketurretsolid();
    self makevehiclesolidcapsule( 23, 23, 23 );

    if ( !isdefined( self.owner ) )
        return;

    var_0 = self.owner;
    var_1 = ( 0, 0, 20 );

    if ( level._ID32653 )
    {
        self.team = var_0.team;
        self._ID21003.team = var_0.team;
        self._ID21003 setturretteam( var_0.team );

        foreach ( var_3 in level.players )
        {
            if ( var_3 != var_0 && var_3.team == var_0.team )
            {
                var_4 = self._ID21003 maps\mp\_entityheadicons::setheadicon( var_3, maps\mp\gametypes\_teams::_ID15416( self.team ), var_1, 10, 10, 0, 0.05, 0, 1, 0, 1 );

                if ( isdefined( var_4 ) )
                    var_4 settargetent( self );
            }
        }
    }

    thread _ID32475();
    thread _ID32476();
    thread _ID32472();
    thread tank_handledeath();
    thread _ID32477();
    thread _ID32432();
    thread _ID32433();
    _ID31486();
}

_ID31486()
{
    var_0 = self.owner;
    var_0 maps\mp\_utility::_ID29199( self._ID32568 );

    if ( maps\mp\_utility::_ID18363() )
    {
        var_0 visionsetthermalforplayer( "black_bw", 0 );
        var_0 visionsetthermalforplayer( game["thermal_vision"], 1.5 );
        var_0 thermalvisionon();
        var_0 thermalvisionfofoverlayon();
    }

    if ( getdvarint( "camera_thirdPerson" ) )
        var_0 maps\mp\_utility::_ID28902( 0 );

    var_0._ID26200 = var_0.angles;
    var_0 maps\mp\_utility::_ID13582( 1 );
    var_1 = var_0 maps\mp\killstreaks\_killstreaks::_ID17993( "remote_tank" );

    if ( var_1 != "success" )
    {
        if ( var_1 != "disconnect" )
            var_0 maps\mp\_utility::_ID7513();

        if ( isdefined( var_0.disabledweapon ) && var_0.disabledweapon )
            var_0 common_scripts\utility::_enableweapon();

        self notify( "death" );
        return 0;
    }

    var_0 maps\mp\_utility::_ID13582( 0 );
    self._ID21003 setcandamage( 1 );
    self setcandamage( 1 );
    var_2 = spawnstruct();
    var_2._ID23898 = 1;
    var_2.deathoverridecallback = ::_ID32508;
    thread maps\mp\_movers::_ID16165( var_2 );
    var_0 remotecontrolvehicle( self );
    var_0 remotecontrolturret( self._ID21003 );
    var_0 thread _ID32541( self );

    if ( maps\mp\_utility::_ID18363() )
        var_0 thread tank_dropmines( self );
    else
        var_0 thread _ID32466( self );

    thread _ID32462();
    thread _ID32510();
    var_0._ID34792 = 1;
    var_0 maps\mp\_utility::_giveweapon( level._ID32563[self._ID32568]._ID25816 );
    var_0 switchtoweaponimmediate( level._ID32563[self._ID32568]._ID25816 );
    thread _ID32473();
    self._ID21003 thread _ID32533();
}

_ID32432()
{
    self endon( "death" );

    for (;;)
    {
        playfxontag( common_scripts\utility::_ID15033( "remote_tank_antenna_light_mp" ), self._ID21003, "tag_headlight_right" );
        wait 1.0;
        stopfxontag( common_scripts\utility::_ID15033( "remote_tank_antenna_light_mp" ), self._ID21003, "tag_headlight_right" );
    }
}

_ID32433()
{
    self endon( "death" );

    for (;;)
    {
        playfxontag( common_scripts\utility::_ID15033( "remote_tank_camera_light_mp" ), self._ID21003, "tag_tail_light_right" );
        wait 2.0;
        stopfxontag( common_scripts\utility::_ID15033( "remote_tank_camera_light_mp" ), self._ID21003, "tag_tail_light_right" );
    }
}

tank_setinactive()
{
    self._ID21003 setmode( level._ID32563[self._ID32568]._ID28167 );

    if ( level._ID32653 )
        maps\mp\_entityheadicons::_ID28896( "none", ( 0, 0, 0 ) );
    else if ( isdefined( self.owner ) )
        maps\mp\_entityheadicons::_ID28825( undefined, ( 0, 0, 0 ) );

    if ( !isdefined( self.owner ) )
        return;

    var_0 = self.owner;

    if ( isdefined( var_0._ID34792 ) && var_0._ID34792 )
    {
        var_0 notify( "end_remote" );

        if ( maps\mp\_utility::_ID18363() )
        {
            var_0 thermalvisionoff();
            var_0 thermalvisionfofoverlayoff();
        }

        var_0 remotecontrolvehicleoff( self );
        var_0 remotecontrolturretoff( self._ID21003 );
        var_0 switchtoweapon( var_0 common_scripts\utility::_ID15114() );
        var_0 maps\mp\_utility::_ID7513();
        var_0 setplayerangles( var_0._ID26200 );

        if ( getdvarint( "camera_thirdPerson" ) )
            var_0 maps\mp\_utility::_ID28902( 1 );

        if ( maps\mp\_utility::_ID18363() )
            var_0 visionsetthermalforplayer( game["thermal_vision"], 0 );

        if ( isdefined( var_0._ID10153 ) && var_0._ID10153 )
            var_0 common_scripts\utility::_enableusability();

        var_0 _ID32392( level._ID32563[self._ID32568]._ID31889 );
        var_0._ID34792 = 0;
        var_0 thread _ID32467();
    }
}

_ID32467()
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    maps\mp\_utility::_ID13582( 1 );
    wait 0.5;
    maps\mp\_utility::_ID13582( 0 );
}

_ID32475()
{
    self endon( "death" );
    self.owner waittill( "disconnect" );

    if ( isdefined( self._ID21003 ) )
        self._ID21003 notify( "death" );

    self notify( "death" );
}

_ID32476()
{
    self endon( "death" );
    self.owner waittill( "stop_using_remote" );
    self notify( "death" );
}

_ID32472()
{
    self endon( "death" );
    self.owner common_scripts\utility::_ID35626( "joined_team", "joined_spectators" );
    self notify( "death" );
}

_ID32477()
{
    self endon( "death" );
    var_0 = level._ID32563[self._ID32568].timeout;
    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    self notify( "death" );
}

_ID32508( var_0 )
{
    self notify( "death" );
}

tank_handledeath()
{
    level endon( "game_ended" );
    var_0 = self getentitynumber();
    addtougvlist( var_0 );
    self waittill( "death" );
    self playsound( "talon_destroyed" );
    _ID26008( var_0 );
    self setmodel( level._ID32563[self._ID32568]._ID21271 );

    if ( isdefined( self.owner ) && ( self.owner._ID34792 || self.owner maps\mp\_utility::_ID18837() ) )
    {
        tank_setinactive();
        self.owner._ID34792 = 0;
    }

    self._ID21003 setdefaultdroppitch( 40 );
    self._ID21003 setsentryowner( undefined );
    self playsound( "sentry_explode" );
    playfxontag( level._ID1644["remote_tank_dying"], self._ID21003, "tag_aim" );
    wait 2.0;
    playfx( level._ID1644["remote_tank_explode"], self.origin );
    self._ID21003 delete();
    maps\mp\_utility::decrementfauxvehiclecount();
    self delete();
}

callback_vehicledamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    var_12 = self;

    if ( isdefined( self._ID32426 ) )
        var_12 = self._ID32426;

    if ( isdefined( var_12._ID3210 ) && var_12._ID3210 )
        return;

    if ( !maps\mp\gametypes\_weapons::_ID13695( var_12.owner, var_1 ) )
        return;

    if ( isdefined( var_3 ) && var_3 & level.idflags_penetration )
        var_12._ID35910 = 1;

    var_12._ID35908 = 1;
    var_12._ID8967 = 0.0;
    playfxontagforclients( level._ID1644["remote_tank_spark"], var_12, "tag_player", var_12.owner );

    if ( isdefined( var_5 ) )
    {
        switch ( var_5 )
        {
            case "artillery_mp":
            case "stealth_bomb_mp":
                var_2 *= 4;
                break;
        }
    }

    if ( var_4 == "MOD_MELEE" )
        var_2 = var_12.maxhealth * 0.5;

    var_13 = var_2;

    if ( isplayer( var_1 ) )
    {
        var_1 maps\mp\gametypes\_damagefeedback::_ID34528( "remote_tank" );

        if ( var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET" )
        {
            if ( var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
                var_13 += var_2 * level.armorpiercingmod;
        }

        if ( isexplosivedamagemod( var_4 ) )
            var_13 += var_2;
    }

    if ( isexplosivedamagemod( var_4 ) && ( isdefined( var_5 ) && var_5 == "destructible_car" ) )
        var_13 = var_12.maxhealth;

    if ( isdefined( var_1.owner ) && isplayer( var_1.owner ) )
        var_1.owner maps\mp\gametypes\_damagefeedback::_ID34528( "remote_tank" );

    if ( isdefined( var_5 ) )
    {
        switch ( var_5 )
        {
            case "stinger_mp":
            case "remote_mortar_missile_mp":
            case "javelin_mp":
            case "ac130_105mm_mp":
            case "ac130_40mm_mp":
            case "remotemissile_projectile_mp":
                var_12._ID19345 = 1;
                var_13 = var_12.maxhealth + 1;
                break;
            case "artillery_mp":
            case "stealth_bomb_mp":
                var_12._ID19345 = 0;
                var_13 = var_12.maxhealth * 0.5;
                break;
            case "bomb_site_mp":
                var_12._ID19345 = 0;
                var_13 = var_12.maxhealth + 1;
                break;
            case "emp_grenade_mp":
                var_13 = 0;
                var_12 thread _ID32463();
                break;
            case "ims_projectile_mp":
                var_12._ID19345 = 1;
                var_13 = var_12.maxhealth * 0.5;
                break;
        }

        maps\mp\killstreaks\_killstreaks::_ID19257( var_1, var_5, self );
    }

    var_12.damagetaken = var_12.damagetaken + var_13;
    var_12 playsound( "talon_damaged" );

    if ( var_12.damagetaken >= var_12.maxhealth )
    {
        if ( isplayer( var_1 ) && ( !isdefined( var_12.owner ) || var_1 != var_12.owner ) )
        {
            var_12._ID3210 = 1;
            var_1 notify( "destroyed_killstreak",  var_5  );
            thread maps\mp\_utility::_ID32672( "callout_destroyed_remote_tank", var_1 );
            var_1 thread maps\mp\gametypes\_rank::giverankxp( "kill", 300, var_5, var_4 );
            var_1 thread maps\mp\gametypes\_rank::_ID36462( "destroyed_remote_tank" );
            thread maps\mp\gametypes\_missions::vehiclekilled( var_12.owner, var_12, undefined, var_1, var_2, var_4, var_5 );
        }

        var_12 notify( "death" );
    }
}

_ID32463()
{
    self notify( "tank_EMPGrenaded" );
    self endon( "tank_EMPGrenaded" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );
    self.empgrenaded = 1;
    self._ID21003 turretfiredisable();
    wait 3.5;
    self.empgrenaded = 0;
    self._ID21003 turretfireenable();
}

_ID32499()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = 0;

    for (;;)
    {
        if ( !self.empgrenaded )
        {
            if ( self._ID8967 < 1.0 )
            {
                self._ID8967 = self._ID8967 + 0.1;
                var_0 = 1;
            }
            else if ( var_0 )
            {
                self._ID8967 = 1.0;
                var_0 = 0;
            }
        }

        wait 0.1;
    }
}

tank_watchlowhealth()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = 0.1;
    var_1 = 1;
    var_2 = 1;

    for (;;)
    {
        if ( var_2 )
        {
            if ( self.damagetaken > 0 )
            {
                var_2 = 0;
                var_1++;
            }
        }
        else if ( self.damagetaken >= self.maxhealth * ( var_0 * var_1 ) )
            var_1++;

        wait 0.05;
    }
}

_ID32473()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( isdefined( self._ID30953 ) )
            self [[ self._ID30953 ]]( undefined, var_1, var_0, var_8, var_4, var_9, var_3, var_2, undefined, undefined, var_5, var_7 );
    }
}

_ID32533()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( isdefined( self._ID30953 ) && isdefined( self._ID32426 ) && ( !isexplosivedamagemod( var_4 ) || isdefined( var_9 ) && isexplosivedamagemod( var_4 ) && ( var_9 == "stealth_bomb_mp" || var_9 == "artillery_mp" ) ) )
            self._ID32426 [[ self._ID30953 ]]( undefined, var_1, var_0, var_8, var_4, var_9, var_3, var_2, undefined, undefined, var_5, var_7 );
    }
}

_ID32541( var_0 )
{
    self endon( "disconnect" );
    self endon( "end_remote" );
    var_0 endon( "death" );
    var_1 = 50;
    var_2 = var_1;
    var_3 = weaponfiretime( level._ID32563[var_0._ID32568]._ID21006 );

    for (;;)
    {
        if ( var_0._ID21003 isfiringvehicleturret() )
        {
            var_2--;

            if ( var_2 <= 0 )
            {
                var_0._ID21003 turretfiredisable();
                wait 2.5;
                var_0 playsound( "talon_reload" );
                self playlocalsound( "talon_reload_plr" );
                var_2 = var_1;
                var_0._ID21003 turretfireenable();
            }
        }

        wait(var_3);
    }
}

_ID32466( var_0 )
{
    self endon( "disconnect" );
    self endon( "end_remote" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_1 = 0;

    for (;;)
    {
        if ( self fragbuttonpressed() && !var_0.empgrenaded )
        {
            var_2 = var_0._ID21003.origin;
            var_3 = var_0._ID21003.angles;

            switch ( var_1 )
            {
                case 0:
                    var_2 = var_0._ID21003 gettagorigin( "tag_missile1" );
                    var_3 = var_0._ID21003 gettagangles( "tag_player" );
                    break;
                case 1:
                    var_2 = var_0._ID21003 gettagorigin( "tag_missile2" );
                    var_3 = var_0._ID21003 gettagangles( "tag_player" );
                    break;
            }

            var_0 playsound( "talon_missile_fire" );
            self playlocalsound( "talon_missile_fire_plr" );
            var_4 = var_2 + anglestoforward( var_3 ) * 100;
            var_5 = magicbullet( level._ID32563[var_0._ID32568]._ID21192, var_2, var_4, self );
            var_1 = ( var_1 + 1 ) % 2;
            wait 5.0;
            var_0 playsound( "talon_rocket_reload" );
            self playlocalsound( "talon_rocket_reload_plr" );
            continue;
        }

        wait 0.05;
    }
}

tank_dropmines( var_0 )
{
    self endon( "disconnect" );
    self endon( "end_remote" );
    level endon( "game_ended" );
    var_0 endon( "death" );

    for (;;)
    {
        if ( self secondaryoffhandbuttonpressed() )
        {
            var_1 = bullettrace( var_0.origin + ( 0, 0, 4 ), var_0.origin - ( 0, 0, 4 ), 0, var_0 );
            var_2 = vectornormalize( var_1["normal"] );
            var_3 = vectortoangles( var_2 );
            var_3 += ( 90, 0, 0 );
            var_4 = maps\mp\gametypes\_weapons::_ID30894( var_0.origin, self, "equipment", var_3 );
            var_0 playsound( "item_blast_shield_on" );
            wait 8.0;
            continue;
        }

        wait 0.05;
    }
}

_ID32462()
{
    self endon( "death" );
    self.owner endon( "end_remote" );

    for (;;)
    {
        earthquake( 0.1, 0.25, self._ID21003 gettagorigin( "tag_player" ), 50 );
        wait 0.25;
    }
}

addtougvlist( var_0 )
{
    level._ID34171[var_0] = self;
}

_ID26008( var_0 )
{
    level._ID34171[var_0] = undefined;
}

_ID32510()
{
    if ( !isdefined( self.owner ) )
        return;

    var_0 = self.owner;
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 endon( "end_remote" );
    self endon( "death" );

    for (;;)
    {
        var_1 = 0;

        while ( var_0 usebuttonpressed() )
        {
            var_1 += 0.05;

            if ( var_1 > 0.75 )
            {
                self notify( "death" );
                return;
            }

            wait 0.05;
        }

        wait 0.05;
    }
}
