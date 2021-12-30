// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID34107 = [];
    level._ID34107["mg_turret"] = "remote_mg_turret";
    level._ID19256["remote_mg_turret"] = ::_ID33868;
    level._ID34100 = [];
    level._ID34100["mg_turret"] = spawnstruct();
    level._ID34100["mg_turret"]._ID28168 = "manual";
    level._ID34100["mg_turret"]._ID28167 = "sentry_offline";
    level._ID34100["mg_turret"].timeout = 60.0;
    level._ID34100["mg_turret"].health = 999999;
    level._ID34100["mg_turret"].maxhealth = 1000;
    level._ID34100["mg_turret"]._ID31889 = "remote_mg_turret";
    level._ID34100["mg_turret"].weaponinfo = "remote_turret_mp";
    level._ID34100["mg_turret"].modelbase = "mp_remote_turret";
    level._ID34100["mg_turret"]._ID21276 = "mp_remote_turret_placement";
    level._ID34100["mg_turret"]._ID21277 = "mp_remote_turret_placement_failed";
    level._ID34100["mg_turret"]._ID21271 = "mp_remote_turret";
    level._ID34100["mg_turret"]._ID32680 = "used_remote_mg_turret";
    level._ID34100["mg_turret"]._ID16989 = &"KILLSTREAKS_ENTER_REMOTE_TURRET";
    level._ID34100["mg_turret"].hintexit = &"KILLSTREAKS_EARLY_EXIT";
    level._ID34100["mg_turret"]._ID16994 = &"KILLSTREAKS_DOUBLE_TAP_TO_CARRY";
    level._ID34100["mg_turret"]._ID23671 = &"KILLSTREAKS_TURRET_PLACE";
    level._ID34100["mg_turret"].cannotplacestring = &"KILLSTREAKS_TURRET_CANNOT_PLACE";
    level._ID34100["mg_turret"]._ID35387 = "remote_sentry_destroyed";
    level._ID34100["mg_turret"]._ID19344 = "killstreak_remote_turret_laptop_mp";
    level._ID34100["mg_turret"]._ID25816 = "killstreak_remote_turret_remote_mp";
    level._ID1644["sentry_explode_mp"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_sentry_gun_explosion" );
    level._ID1644["sentry_smoke_mp"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_sg_damage_blacksmoke" );
    level._ID1644["antenna_light_mp"] = loadfx( "fx/lights/light_detonator_blink" );
}

_ID33868( var_0, var_1 )
{
    var_2 = _ID33871( var_0, "mg_turret" );

    if ( var_2 )
        maps\mp\_matchdata::_ID20253( level._ID34100["mg_turret"]._ID31889, self.origin );

    self._ID18582 = 0;
    return var_2;
}

_ID32392( var_0 )
{
    self takeweapon( level._ID34100[var_0]._ID19344 );
    self takeweapon( level._ID34100[var_0]._ID25816 );
}

_ID33871( var_0, var_1 )
{
    if ( maps\mp\_utility::_ID18837() )
        return 0;

    var_2 = _ID8491( var_1, self );
    _ID26022();
    setcarryingturret( var_2, 1 );
    thread _ID26206();

    if ( isdefined( var_2 ) )
        return 1;
    else
        return 0;
}

setcarryingturret( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_0 turret_setcarried( self );
    common_scripts\utility::_disableweapon();
    self notifyonplayercommand( "place_turret", "+attack" );
    self notifyonplayercommand( "place_turret", "+attack_akimbo_accessible" );
    self notifyonplayercommand( "cancel_turret", "+actionslot 4" );

    if ( !level.console )
    {
        self notifyonplayercommand( "cancel_turret", "+actionslot 5" );
        self notifyonplayercommand( "cancel_turret", "+actionslot 6" );
        self notifyonplayercommand( "cancel_turret", "+actionslot 7" );
    }

    for (;;)
    {
        var_2 = common_scripts\utility::_ID35635( "place_turret", "cancel_turret", "force_cancel_placement" );

        if ( var_2 == "cancel_turret" || var_2 == "force_cancel_placement" )
        {
            if ( var_2 == "cancel_turret" && !var_1 )
                continue;

            if ( level.console )
            {
                var_3 = maps\mp\_utility::getkillstreakweapon( level._ID34100[var_0._ID34107]._ID31889 );

                if ( isdefined( self._ID19258 ) && var_3 == maps\mp\_utility::getkillstreakweapon( self.pers["killstreaks"][self._ID19258]._ID31889 ) && !self getweaponslistitems().size )
                {
                    maps\mp\_utility::_giveweapon( var_3, 0 );
                    maps\mp\_utility::_setactionslot( 4, "weapon", var_3 );
                }
            }

            var_0 _ID34050();
            common_scripts\utility::_enableweapon();
            return 0;
        }

        if ( !var_0.canbeplaced )
            continue;

        var_0 _ID34053();
        common_scripts\utility::_enableweapon();
        return 1;
    }
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
    foreach ( var_1 in self._ID36267 )
    {
        var_2 = strtok( var_1, "_" );

        if ( var_2[0] == "alt" )
        {
            self._ID26214[var_1] = self getweaponammoclip( var_1 );
            self._ID26216[var_1] = self getweaponammostock( var_1 );
            continue;
        }

        self._ID26214[var_1] = self getweaponammoclip( var_1 );
        self._ID26216[var_1] = self getweaponammostock( var_1 );
    }

    self._ID36293 = [];

    foreach ( var_1 in self._ID36267 )
    {
        var_2 = strtok( var_1, "_" );

        if ( var_2[0] == "alt" )
            continue;

        self._ID36293[self._ID36293.size] = var_1;
        self takeweapon( var_1 );
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

_ID34053()
{
    self setmodel( level._ID34100[self._ID34107].modelbase );
    self setsentrycarrier( undefined );
    self setcandamage( 1 );
    self.carriedby forceusehintoff();
    self.carriedby = undefined;

    if ( isdefined( self.owner ) )
    {
        self.owner._ID18582 = 0;
        common_scripts\utility::_ID20489( self.owner.team );
    }

    self playsound( "sentry_gun_plant" );
    thread _ID34049();
    self notify( "placed" );
}

_ID34050()
{
    self.carriedby forceusehintoff();

    if ( isdefined( self.owner ) )
        self.owner._ID18582 = 0;

    self delete();
}

turret_setcarried( var_0 )
{
    self setmodel( level._ID34100[self._ID34107]._ID21276 );
    self setcandamage( 0 );
    self setsentrycarrier( var_0 );
    self setcontents( 0 );
    self.carriedby = var_0;
    var_0._ID18582 = 1;
    var_0 thread _ID34636( self );
    thread _ID34038( var_0 );
    thread turret_oncarrierdisconnect( var_0 );
    thread turret_oncarrierchangedteam( var_0 );
    thread _ID34040();
    self setdefaultdroppitch( -89.0 );
    _ID34052();
    self notify( "carried" );
}

_ID34636( var_0 )
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
        var_2 = self canplayerplacesentry();
        var_0.origin = var_2["origin"];
        var_0.angles = var_2["angles"];
        var_0.canbeplaced = self isonground() && var_2["result"] && abs( var_0.origin[2] - self.origin[2] ) < 10;

        if ( var_0.canbeplaced != var_1 )
        {
            if ( var_0.canbeplaced )
            {
                var_0 setmodel( level._ID34100[var_0._ID34107]._ID21276 );
                self forceusehinton( level._ID34100[var_0._ID34107]._ID23671 );
            }
            else
            {
                var_0 setmodel( level._ID34100[var_0._ID34107]._ID21277 );
                self forceusehinton( level._ID34100[var_0._ID34107].cannotplacestring );
            }
        }

        var_1 = var_0.canbeplaced;
        wait 0.05;
    }
}

_ID34038( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    var_0 waittill( "death" );

    if ( self.canbeplaced )
        _ID34053();
    else
        self delete();
}

turret_oncarrierdisconnect( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    var_0 waittill( "disconnect" );
    self delete();
}

turret_oncarrierchangedteam( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    var_0 common_scripts\utility::_ID35626( "joined_team", "joined_spectators" );
    self delete();
}

_ID34040( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    level waittill( "game_ended" );
    self delete();
}

_ID8491( var_0, var_1 )
{
    var_2 = spawnturret( "misc_turret", var_1.origin, level._ID34100[var_0].weaponinfo );
    var_2.angles = var_1.angles;
    var_2 setmodel( level._ID34100[var_0].modelbase );
    var_2.owner = var_1;
    var_2.health = level._ID34100[var_0].health;
    var_2.maxhealth = level._ID34100[var_0].maxhealth;
    var_2.damagetaken = 0;
    var_2._ID34107 = var_0;
    var_2._ID32026 = 0;
    var_2._ID32028 = 5.0;
    var_2 setturretmodechangewait( 1 );
    var_2 _ID34052();
    var_2 setsentryowner( var_1 );
    var_2 setturretminimapvisible( 1, var_0 );
    var_2 setdefaultdroppitch( -89.0 );
    var_2 thread _ID34020();
    var_2._ID8967 = 1.0;
    var_2 thread _ID34028();
    var_2 thread _ID34078();
    return var_2;
}

_ID34049()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    self setdefaultdroppitch( 0.0 );
    self makeunusable();
    self maketurretsolid();

    if ( !isdefined( self.owner ) )
        return;

    var_0 = self.owner;

    if ( isdefined( var_0._ID25825 ) )
    {
        foreach ( var_2 in var_0._ID25825 )
            var_2 notify( "death" );
    }

    var_0._ID25825 = [];
    var_0._ID25825[0] = self;
    var_0._ID34793 = 0;
    var_0._ID23545 = 0;
    var_0._ID12127 = 1;

    if ( isalive( var_0 ) )
        var_0 maps\mp\_utility::setlowermessage( "pickup_remote_turret", level._ID34100[self._ID34107]._ID16994, undefined, undefined, undefined, undefined, undefined, undefined, 1 );

    var_0 thread _ID36107( self );

    if ( level._ID32653 )
    {
        self.team = var_0.team;
        self setturretteam( var_0.team );
        maps\mp\_entityheadicons::_ID28896( self.team, ( 0, 0, 65 ) );
    }
    else
        maps\mp\_entityheadicons::_ID28825( self.owner, ( 0, 0, 65 ) );

    self._ID23194 = spawn( "trigger_radius", self.origin + ( 0, 0, 1 ), 0, 32, 64 );
    self._ID23194 enablelinkto();
    self._ID23194 linkto( self );
    var_0 thread _ID34021( self );
    thread _ID36067();
    thread _ID34019();
    thread _ID34018();
    thread _ID34069();
    thread _ID33998();
}

_ID31485()
{
    var_0 = self.owner;
    var_0 maps\mp\_utility::_ID29199( self._ID34107 );
    var_0 maps\mp\_utility::_ID13582( 1 );
    var_1 = var_0 maps\mp\killstreaks\_killstreaks::_ID17993();

    if ( var_1 != "success" )
    {
        if ( var_1 != "disconnect" )
            var_0 maps\mp\_utility::_ID7513();

        return 0;
    }

    var_0 maps\mp\_utility::_giveweapon( level._ID34100[self._ID34107]._ID25816 );
    var_0 switchtoweaponimmediate( level._ID34100[self._ID34107]._ID25816 );
    var_0 maps\mp\_utility::_ID13582( 0 );
    var_0 thread _ID35606( 1.0, self );

    if ( isdefined( level._ID17249["thermal_mode"] ) )
        level._ID17249["thermal_mode"] settext( "" );

    if ( getdvarint( "camera_thirdPerson" ) )
        var_0 maps\mp\_utility::_ID28902( 0 );

    var_0 playerlinkweaponviewtodelta( self, "tag_player", 0, 180, 180, 50, 25, 0 );
    var_0 playerlinkedsetviewznear( 0 );
    var_0 playerlinkedsetusebaseangleforviewclamp( 1 );
    var_0 remotecontrolturret( self );
    var_0 maps\mp\_utility::_ID7495( "enter_remote_turret" );
    var_0 maps\mp\_utility::_ID7495( "pickup_remote_turret" );
    var_0 maps\mp\_utility::setlowermessage( "early_exit", level._ID34100[self._ID34107].hintexit, undefined, undefined, undefined, undefined, undefined, undefined, 1 );
}

_ID35606( var_0, var_1 )
{
    self endon( "disconnect" );
    var_1 endon( "death" );
    wait(var_0);
    self visionsetthermalforplayer( game["thermal_vision"], 1.5 );
    self thermalvisionon();
    self thermalvisionfofoverlayon();
}

_ID31865()
{
    var_0 = self.owner;

    if ( var_0 maps\mp\_utility::_ID18837() )
    {
        var_0 thermalvisionoff();
        var_0 thermalvisionfofoverlayoff();
        var_0 remotecontrolturretoff( self );
        var_0 unlink();
        var_0 switchtoweapon( var_0 common_scripts\utility::_ID15114() );
        var_0 maps\mp\_utility::_ID7513();

        if ( getdvarint( "camera_thirdPerson" ) )
            var_0 maps\mp\_utility::_ID28902( 1 );

        var_0 visionsetthermalforplayer( game["thermal_vision"], 0 );
        var_1 = maps\mp\_utility::getkillstreakweapon( level._ID34100[self._ID34107]._ID31889 );
        var_0 maps\mp\killstreaks\_killstreaks::_ID32391( var_1 );
    }

    if ( self._ID32026 )
        var_0 stopshellshock();

    var_0 maps\mp\_utility::_ID7495( "early_exit" );

    if ( !isdefined( var_0.using_remote_turret_when_died ) || !var_0.using_remote_turret_when_died )
        var_0 maps\mp\_utility::setlowermessage( "enter_remote_turret", level._ID34100[self._ID34107]._ID16989, undefined, undefined, undefined, 1, 0.25, 1.5, 1 );

    self notify( "exit" );
}

_ID36107( var_0 )
{
    self endon( "disconnect" );
    var_0 endon( "death" );
    self.using_remote_turret_when_died = 0;

    for (;;)
    {
        if ( isalive( self ) )
            self waittill( "death" );

        maps\mp\_utility::_ID7495( "enter_remote_turret" );
        maps\mp\_utility::_ID7495( "pickup_remote_turret" );

        if ( self._ID34793 )
            self.using_remote_turret_when_died = 1;
        else
            self.using_remote_turret_when_died = 0;

        self waittill( "spawned_player" );

        if ( !self.using_remote_turret_when_died )
        {
            maps\mp\_utility::setlowermessage( "enter_remote_turret", level._ID34100[var_0._ID34107]._ID16989, undefined, undefined, undefined, 1, 0.25, 1.5, 1 );
            continue;
        }

        var_0 notify( "death" );
    }
}

_ID36067()
{
    self endon( "death" );
    self endon( "carried" );
    level endon( "game_ended" );
    var_0 = self.owner;

    for (;;)
    {
        var_1 = var_0 getcurrentweapon();

        if ( maps\mp\_utility::_ID18679( var_1 ) && var_1 != level._ID34100[self._ID34107].weaponinfo && var_1 != level._ID34100[self._ID34107]._ID19344 && var_1 != level._ID34100[self._ID34107]._ID25816 && var_1 != "none" && ( !var_0 maps\mp\_utility::_ID18666() || var_0 maps\mp\_utility::_ID18837() ) )
        {
            if ( !isdefined( var_0._ID12127 ) || !var_0._ID12127 )
            {
                var_0._ID12127 = 1;
                var_0 maps\mp\_utility::_ID7495( "enter_remote_turret" );
            }

            wait 0.05;
            continue;
        }

        if ( var_0 istouching( self._ID23194 ) )
        {
            if ( !isdefined( var_0._ID12127 ) || !var_0._ID12127 )
            {
                var_0._ID12127 = 1;
                var_0 maps\mp\_utility::_ID7495( "enter_remote_turret" );
            }

            wait 0.05;
            continue;
        }

        if ( isdefined( var_0.empgrenaded ) && var_0.empgrenaded )
        {
            if ( !isdefined( var_0._ID12127 ) || !var_0._ID12127 )
            {
                var_0._ID12127 = 1;
                var_0 maps\mp\_utility::_ID7495( "enter_remote_turret" );
            }

            wait 0.05;
            continue;
        }

        if ( var_0 islinked() && !var_0._ID34793 )
        {
            if ( !isdefined( var_0._ID12127 ) || !var_0._ID12127 )
            {
                var_0._ID12127 = 1;
                var_0 maps\mp\_utility::_ID7495( "enter_remote_turret" );
            }

            wait 0.05;
            continue;
        }

        if ( isdefined( var_0._ID12127 ) && var_0._ID12127 && var_1 != "none" )
        {
            var_0 maps\mp\_utility::setlowermessage( "enter_remote_turret", level._ID34100[self._ID34107]._ID16989, undefined, undefined, undefined, 1, 0.25, 1.5, 1 );
            var_0._ID12127 = 0;
        }

        var_2 = 0;

        while ( var_0 usebuttonpressed() && !var_0 fragbuttonpressed() && !isdefined( var_0._ID32944 ) && !var_0 secondaryoffhandbuttonpressed() && !var_0 isusingturret() && var_0 isonground() && !var_0 istouching( self._ID23194 ) && ( !isdefined( var_0.empgrenaded ) || !var_0.empgrenaded ) )
        {
            if ( isdefined( var_0._ID18582 ) && var_0._ID18582 )
                break;

            if ( isdefined( var_0.iscapturingcrate ) && var_0.iscapturingcrate )
                break;

            if ( !isalive( var_0 ) )
                break;

            if ( !var_0._ID34793 && var_0 maps\mp\_utility::_ID18837() )
                break;

            if ( var_0 islinked() && !var_0._ID34793 )
                break;

            var_2 += 0.05;

            if ( var_2 > 0.75 )
            {
                var_0._ID34793 = !var_0._ID34793;

                if ( var_0._ID34793 )
                {
                    var_0 _ID26046();
                    var_0 _ID32392( self._ID34107 );
                    var_0 maps\mp\_utility::_giveweapon( level._ID34100[self._ID34107]._ID19344 );
                    var_0 switchtoweaponimmediate( level._ID34100[self._ID34107]._ID19344 );
                    _ID31485();
                    var_0 _ID26215();
                }
                else
                {
                    var_0 _ID32392( self._ID34107 );
                    _ID31865();
                }

                wait 2.0;
                break;
            }

            wait 0.05;
        }

        wait 0.05;
    }
}

_ID34021( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );

    if ( !isdefined( var_0._ID23194 ) )
        return;

    if ( isdefined( self.pers["isBot"] ) && self.pers["isBot"] )
        return;

    var_1 = 0;

    for (;;)
    {
        var_2 = self getcurrentweapon();

        if ( maps\mp\_utility::_ID18679( var_2 ) && var_2 != "killstreak_remote_turret_mp" && var_2 != level._ID34100[var_0._ID34107].weaponinfo && var_2 != level._ID34100[var_0._ID34107]._ID19344 && var_2 != level._ID34100[var_0._ID34107]._ID25816 && var_2 != "none" && ( !maps\mp\_utility::_ID18666() || maps\mp\_utility::_ID18837() ) )
        {
            if ( !isdefined( self._ID23545 ) || !self._ID23545 )
            {
                self._ID23545 = 1;
                maps\mp\_utility::_ID7495( "pickup_remote_turret" );
            }

            wait 0.05;
            continue;
        }

        if ( !self istouching( var_0._ID23194 ) )
        {
            if ( !isdefined( self._ID23545 ) || !self._ID23545 )
            {
                self._ID23545 = 1;
                maps\mp\_utility::_ID7495( "pickup_remote_turret" );
            }

            wait 0.05;
            continue;
        }

        if ( maps\mp\_utility::_ID18757( self ) && self istouching( var_0._ID23194 ) && !isdefined( var_0.carriedby ) && self isonground() )
        {
            if ( isdefined( self._ID23545 ) && self._ID23545 && var_2 != "none" )
            {
                maps\mp\_utility::setlowermessage( "pickup_remote_turret", level._ID34100[var_0._ID34107]._ID16994, undefined, undefined, undefined, undefined, undefined, undefined, 1 );
                self._ID23545 = 0;
            }

            if ( self usebuttonpressed() )
            {
                if ( isdefined( self._ID34793 ) && self._ID34793 )
                    continue;

                var_1 = 0;

                while ( self usebuttonpressed() )
                {
                    var_1 += 0.05;
                    wait 0.05;
                }

                if ( var_1 >= 0.5 )
                    continue;

                var_1 = 0;

                while ( !self usebuttonpressed() && var_1 < 0.5 )
                {
                    var_1 += 0.05;
                    wait 0.05;
                }

                if ( var_1 >= 0.5 )
                    continue;

                if ( !maps\mp\_utility::_ID18757( self ) )
                    continue;

                if ( isdefined( self._ID34793 ) && self._ID34793 )
                    continue;

                var_0 setmode( level._ID34100[var_0._ID34107]._ID28167 );
                thread setcarryingturret( var_0, 0 );
                var_0._ID23194 delete();
                self._ID25825 = undefined;
                maps\mp\_utility::_ID7495( "pickup_remote_turret" );
                return;
            }
        }

        wait 0.05;
    }
}

_ID33998()
{
    self endon( "death" );
    self endon( "carried" );

    for (;;)
    {
        playfxontag( common_scripts\utility::_ID15033( "antenna_light_mp" ), self, "tag_fx" );
        wait 1.0;
        stopfxontag( common_scripts\utility::_ID15033( "antenna_light_mp" ), self, "tag_fx" );
    }
}

_ID34052()
{
    self setmode( level._ID34100[self._ID34107]._ID28167 );

    if ( level._ID32653 )
        maps\mp\_entityheadicons::_ID28896( "none", ( 0, 0, 0 ) );
    else if ( isdefined( self.owner ) )
        maps\mp\_entityheadicons::_ID28825( undefined, ( 0, 0, 0 ) );

    if ( !isdefined( self.owner ) )
        return;

    var_0 = self.owner;

    if ( isdefined( var_0._ID34793 ) && var_0._ID34793 )
    {
        var_0 thermalvisionoff();
        var_0 thermalvisionfofoverlayoff();
        var_0 remotecontrolturretoff( self );
        var_0 unlink();
        var_0 switchtoweapon( var_0 common_scripts\utility::_ID15114() );
        var_0 maps\mp\_utility::_ID7513();

        if ( getdvarint( "camera_thirdPerson" ) )
            var_0 maps\mp\_utility::_ID28902( 1 );

        var_0 maps\mp\killstreaks\_killstreaks::clearrideintro();
        var_0 visionsetthermalforplayer( game["thermal_vision"], 0 );

        if ( isdefined( var_0._ID10153 ) && var_0._ID10153 )
            var_0 common_scripts\utility::_enableusability();

        var_0 _ID32392( self._ID34107 );
    }
}

_ID34020()
{
    self endon( "death" );
    level endon( "game_ended" );
    self notify( "turret_handleOwner" );
    self endon( "turret_handleOwner" );
    self.owner common_scripts\utility::_ID35626( "disconnect", "joined_team", "joined_spectators" );
    self notify( "death" );
}

_ID34069()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = level._ID34100[self._ID34107].timeout;

    while ( var_0 )
    {
        wait 1.0;
        maps\mp\gametypes\_hostmigration::_ID35770();

        if ( !isdefined( self.carriedby ) )
            var_0 = max( 0, var_0 - 1.0 );
    }

    if ( isdefined( self.owner ) )
        self.owner thread maps\mp\_utility::_ID19765( "sentry_gone" );

    self notify( "death" );
}

_ID34019()
{
    self endon( "carried" );
    var_0 = self getentitynumber();
    maps\mp\killstreaks\_autosentry::addtoturretlist( var_0 );
    self waittill( "death" );
    maps\mp\killstreaks\_autosentry::_ID26007( var_0 );

    if ( !isdefined( self ) )
        return;

    self setmodel( level._ID34100[self._ID34107]._ID21271 );
    _ID34052();
    self setdefaultdroppitch( 40 );
    self setsentryowner( undefined );
    self setturretminimapvisible( 0 );

    if ( isdefined( self._ID23194 ) )
        self._ID23194 delete();

    var_1 = self.owner;

    if ( isdefined( var_1 ) )
    {
        var_1._ID34793 = 0;
        var_1 maps\mp\_utility::_ID7495( "enter_remote_turret" );
        var_1 maps\mp\_utility::_ID7495( "early_exit" );
        var_1 maps\mp\_utility::_ID7495( "pickup_remote_turret" );
        var_1 _ID26206();
        var_1 _ID26215();

        if ( var_1 getcurrentweapon() == "none" )
            var_1 switchtoweapon( var_1 common_scripts\utility::_ID15114() );

        if ( self._ID32026 )
            var_1 stopshellshock();
    }

    self playsound( "sentry_explode" );
    playfxontag( common_scripts\utility::_ID15033( "sentry_explode_mp" ), self, "tag_aim" );
    wait 1.5;
    self playsound( "sentry_explode_smoke" );

    for ( var_2 = 8; var_2 > 0; var_2 -= 0.4 )
    {
        playfxontag( common_scripts\utility::_ID15033( "sentry_smoke_mp" ), self, "tag_aim" );
        wait 0.4;
    }

    self notify( "deleting" );

    if ( isdefined( self._ID32581 ) )
        self._ID32581 delete();

    self delete();
}

_ID34018()
{
    self endon( "death" );
    self endon( "carried" );
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( !maps\mp\gametypes\_weapons::_ID13695( self.owner, var_1 ) )
            continue;

        if ( isdefined( var_9 ) )
        {
            switch ( var_9 )
            {
                case "flash_grenade_mp":
                case "concussion_grenade_mp":
                    if ( var_4 == "MOD_GRENADE_SPLASH" && self.owner._ID34793 )
                    {
                        self._ID32026 = 1;
                        thread _ID34063();
                    }
                case "smoke_grenade_mp":
                case "smoke_grenadejugg_mp":
                    continue;
            }
        }

        if ( !isdefined( self ) )
            return;

        if ( var_4 == "MOD_MELEE" )
            self.damagetaken = self.damagetaken + self.maxhealth;

        if ( isdefined( var_8 ) && var_8 & level.idflags_penetration )
            self._ID35910 = 1;

        self._ID35908 = 1;
        self._ID8967 = 0.0;
        var_10 = var_0;

        if ( isplayer( var_1 ) )
        {
            var_1 maps\mp\gametypes\_damagefeedback::_ID34528( "remote_turret" );

            if ( var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
                var_10 = var_0 * level.armorpiercingmod;
        }

        if ( isdefined( var_1.owner ) && isplayer( var_1.owner ) )
            var_1.owner maps\mp\gametypes\_damagefeedback::_ID34528( "remote_turret" );

        if ( isdefined( var_9 ) )
        {
            switch ( var_9 )
            {
                case "stinger_mp":
                case "remote_mortar_missile_mp":
                case "javelin_mp":
                case "ac130_105mm_mp":
                case "ac130_40mm_mp":
                case "remotemissile_projectile_mp":
                    self._ID19345 = 1;
                    var_10 = self.maxhealth + 1;
                    break;
                case "artillery_mp":
                case "stealth_bomb_mp":
                    self._ID19345 = 0;
                    var_10 += var_0 * 4;
                    break;
                case "emp_grenade_mp":
                case "bomb_site_mp":
                    self._ID19345 = 0;
                    var_10 = self.maxhealth + 1;
                    break;
            }

            maps\mp\killstreaks\_killstreaks::_ID19257( var_1, var_9, self );
        }

        self.damagetaken = self.damagetaken + var_10;

        if ( self.damagetaken >= self.maxhealth )
        {
            if ( isplayer( var_1 ) && ( !isdefined( self.owner ) || var_1 != self.owner ) )
            {
                var_1 thread maps\mp\gametypes\_rank::giverankxp( "kill", 100, var_9, var_4 );
                var_1 notify( "destroyed_killstreak" );
            }

            if ( isdefined( self.owner ) )
                self.owner thread maps\mp\_utility::_ID19765( level._ID34100[self._ID34107]._ID35387, undefined, undefined, self.origin );

            self notify( "death" );
            return;
        }
    }
}

_ID34028()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = 0;

    for (;;)
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

        wait 0.1;
    }
}

_ID34078()
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

_ID34063()
{
    self notify( "stunned" );
    self endon( "stunned" );
    self endon( "death" );

    while ( self._ID32026 )
    {
        self.owner shellshock( "concussion_grenade_mp", self._ID32028 );
        playfxontag( common_scripts\utility::_ID15033( "sentry_explode_mp" ), self, "tag_origin" );
        var_0 = 0;

        while ( var_0 < self._ID32028 )
        {
            var_0 += 0.05;
            wait 0.05;
        }

        self._ID32026 = 0;
    }
}
