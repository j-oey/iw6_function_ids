// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID28174 = [];
    level._ID28174["sentry_minigun"] = "sentry";
    level._ID28174["sam_turret"] = "sam_turret";
    level._ID19256[level._ID28174["sentry_minigun"]] = ::_ID33834;
    level._ID19256[level._ID28174["sam_turret"]] = ::tryusesam;
    level._ID28172 = [];
    level._ID28172["sentry_minigun"] = spawnstruct();
    level._ID28172["sentry_minigun"].health = 999999;
    level._ID28172["sentry_minigun"].maxhealth = 1000;
    level._ID28172["sentry_minigun"].burstmin = 20;
    level._ID28172["sentry_minigun"]._ID6331 = 120;
    level._ID28172["sentry_minigun"]._ID23388 = 0.15;
    level._ID28172["sentry_minigun"]._ID23387 = 0.35;
    level._ID28172["sentry_minigun"]._ID28168 = "sentry";
    level._ID28172["sentry_minigun"]._ID28167 = "sentry_offline";
    level._ID28172["sentry_minigun"].timeout = 90.0;
    level._ID28172["sentry_minigun"]._ID31014 = 0.05;
    level._ID28172["sentry_minigun"].overheattime = 8.0;
    level._ID28172["sentry_minigun"].cooldowntime = 0.1;
    level._ID28172["sentry_minigun"].fxtime = 0.3;
    level._ID28172["sentry_minigun"]._ID31889 = "sentry";
    level._ID28172["sentry_minigun"].weaponinfo = "sentry_minigun_mp";
    level._ID28172["sentry_minigun"].modelbase = "weapon_sentry_chaingun";
    level._ID28172["sentry_minigun"]._ID21276 = "weapon_sentry_chaingun_obj";
    level._ID28172["sentry_minigun"]._ID21277 = "weapon_sentry_chaingun_obj_red";
    level._ID28172["sentry_minigun"].modelbombsquad = "weapon_sentry_chaingun_bombsquad";
    level._ID28172["sentry_minigun"]._ID21271 = "weapon_sentry_chaingun_destroyed";
    level._ID28172["sentry_minigun"]._ID16999 = &"SENTRY_PICKUP";
    level._ID28172["sentry_minigun"].headicon = 1;
    level._ID28172["sentry_minigun"]._ID32680 = "used_sentry";
    level._ID28172["sentry_minigun"]._ID29893 = 0;
    level._ID28172["sentry_minigun"]._ID35387 = "sentry_destroyed";
    level._ID28172["sentry_minigun"]._ID36472 = "destroyed_sentry";
    level._ID28172["sentry_minigun"]._ID19962 = "tag_fx";
    level._ID28172["sam_turret"] = spawnstruct();
    level._ID28172["sam_turret"].health = 999999;
    level._ID28172["sam_turret"].maxhealth = 1000;
    level._ID28172["sam_turret"].burstmin = 20;
    level._ID28172["sam_turret"]._ID6331 = 120;
    level._ID28172["sam_turret"]._ID23388 = 0.15;
    level._ID28172["sam_turret"]._ID23387 = 0.35;
    level._ID28172["sam_turret"]._ID28168 = "manual_target";
    level._ID28172["sam_turret"]._ID28167 = "sentry_offline";
    level._ID28172["sam_turret"].timeout = 90.0;
    level._ID28172["sam_turret"]._ID31014 = 0.05;
    level._ID28172["sam_turret"].overheattime = 8.0;
    level._ID28172["sam_turret"].cooldowntime = 0.1;
    level._ID28172["sam_turret"].fxtime = 0.3;
    level._ID28172["sam_turret"]._ID31889 = "sam_turret";
    level._ID28172["sam_turret"].weaponinfo = "sam_mp";
    level._ID28172["sam_turret"].modelbase = "mp_sam_turret";
    level._ID28172["sam_turret"]._ID21276 = "mp_sam_turret_placement";
    level._ID28172["sam_turret"]._ID21277 = "mp_sam_turret_placement_failed";
    level._ID28172["sam_turret"]._ID21271 = "mp_sam_turret";
    level._ID28172["sam_turret"]._ID16999 = &"SENTRY_PICKUP";
    level._ID28172["sam_turret"].headicon = 1;
    level._ID28172["sam_turret"]._ID32680 = "used_sam_turret";
    level._ID28172["sam_turret"]._ID29893 = 0;
    level._ID28172["sam_turret"]._ID35387 = "sam_destroyed";
    level._ID28172["sam_turret"]._ID36472 = undefined;
    level._ID28172["sam_turret"]._ID19962 = "tag_fx";
    level._ID1644["sentry_overheat_mp"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_sg_overheat_smoke" );
    level._ID1644["sentry_explode_mp"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ims_explosion" );
    level._ID1644["sentry_sparks_mp"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_sentry_gun_explosion" );
    level._ID1644["sentry_smoke_mp"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_sg_damage_blacksmoke" );
}

_ID33834( var_0, var_1 )
{
    var_2 = _ID15629( "sentry_minigun" );

    if ( var_2 )
        maps\mp\_matchdata::_ID20253( level._ID28172["sentry_minigun"]._ID31889, self.origin );

    return var_2;
}

tryusesam( var_0, var_1 )
{
    var_2 = _ID15629( "sam_turret" );

    if ( var_2 )
        maps\mp\_matchdata::_ID20253( level._ID28172["sam_turret"]._ID31889, self.origin );

    return var_2;
}

_ID15629( var_0 )
{
    self._ID19488 = var_0;
    var_1 = _ID8474( var_0, self );
    _ID26022();
    self._ID6724 = var_1;
    var_2 = _ID28668( var_1, 1 );
    self._ID6724 = undefined;
    thread _ID35602();
    self._ID18582 = 0;

    if ( isdefined( var_1 ) )
        return 1;
    else
        return 0;
}

_ID28668( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_0 _ID28140( self );
    common_scripts\utility::_disableweapon();

    if ( !isai( self ) )
    {
        self notifyonplayercommand( "place_sentry", "+attack" );
        self notifyonplayercommand( "place_sentry", "+attack_akimbo_accessible" );
        self notifyonplayercommand( "cancel_sentry", "+actionslot 4" );

        if ( !level.console )
        {
            self notifyonplayercommand( "cancel_sentry", "+actionslot 5" );
            self notifyonplayercommand( "cancel_sentry", "+actionslot 6" );
            self notifyonplayercommand( "cancel_sentry", "+actionslot 7" );
        }
    }

    for (;;)
    {
        var_2 = common_scripts\utility::_ID35635( "place_sentry", "cancel_sentry", "force_cancel_placement" );

        if ( !isdefined( var_0 ) )
        {
            common_scripts\utility::_enableweapon();
            return 1;
        }

        if ( var_2 == "cancel_sentry" || var_2 == "force_cancel_placement" )
        {
            if ( !var_1 && var_2 == "cancel_sentry" )
                continue;

            if ( level.console )
            {
                var_3 = maps\mp\_utility::getkillstreakweapon( level._ID28172[var_0._ID28174]._ID31889 );

                if ( isdefined( self._ID19258 ) && var_3 == maps\mp\_utility::getkillstreakweapon( self.pers["killstreaks"][self._ID19258]._ID31889 ) && !self getweaponslistitems().size )
                {
                    maps\mp\_utility::_giveweapon( var_3, 0 );
                    maps\mp\_utility::_setactionslot( 4, "weapon", var_3 );
                }
            }

            var_0 _ID28138( var_2 == "force_cancel_placement" && !isdefined( var_0._ID13165 ) );
            return 0;
        }

        if ( !var_0.canbeplaced )
            continue;

        var_0 _ID28144();
        common_scripts\utility::_enableweapon();
        return 1;
    }
}

_ID26046()
{
    if ( !maps\mp\_utility::_ID18363() )
    {
        if ( self hasweapon( "iw6_riotshield_mp" ) )
        {
            self._ID26213 = "iw6_riotshield_mp";
            self takeweapon( "iw6_riotshield_mp" );
        }
    }
    else if ( self hasweapon( "iw5_alienriotshield_mp" ) )
    {
        self._ID26213 = "iw5_alienriotshield_mp";
        self._ID26329 = self getammocount( "iw5_alienriotshield_mp" );
        self takeweapon( "iw5_alienriotshield_mp" );
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

_ID26215()
{
    if ( isdefined( self._ID26213 ) )
    {
        maps\mp\_utility::_giveweapon( self._ID26213 );

        if ( maps\mp\_utility::_ID18363() )
        {
            if ( self._ID26213 == "iw5_alienriotshield_mp" )
                self setweaponammoclip( "iw5_alienriotshield_mp", self._ID26329 );
        }

        self._ID26213 = undefined;
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

_ID8474( var_0, var_1 )
{
    var_2 = spawnturret( "misc_turret", var_1.origin, level._ID28172[var_0].weaponinfo );
    var_2.angles = var_1.angles;
    var_2 sentry_initsentry( var_0, var_1 );
    var_2 thread sentry_createbombsquadmodel( var_0 );
    return var_2;
}

sentry_initsentry( var_0, var_1 )
{
    self._ID28174 = var_0;
    self.canbeplaced = 1;
    self setmodel( level._ID28172[self._ID28174].modelbase );
    self._ID29893 = 1;
    self._ID13165 = 1;
    self setcandamage( 1 );

    switch ( var_0 )
    {
        case "minigun_turret":
        case "gl_turret":
        case "minigun_turret_1":
        case "minigun_turret_2":
        case "minigun_turret_3":
        case "minigun_turret_4":
        case "gl_turret_1":
        case "gl_turret_2":
        case "gl_turret_3":
        case "gl_turret_4":
            self setleftarc( 80 );
            self setrightarc( 80 );
            self setbottomarc( 50 );
            self setdefaultdroppitch( 0.0 );
            self._ID23036 = var_1;
            break;
        case "sam_turret":
        case "scramble_turret":
            self maketurretinoperable();
            self setleftarc( 180 );
            self setrightarc( 180 );
            self settoparc( 80 );
            self setdefaultdroppitch( -89.0 );
            self._ID19412 = 0;
            var_2 = spawn( "script_model", self gettagorigin( "tag_laser" ) );
            var_2 linkto( self );
            self._ID19214 = var_2;
            self._ID19214 setscriptmoverkillcam( "explosive" );
            break;
        default:
            self maketurretinoperable();
            self setdefaultdroppitch( -89.0 );
            break;
    }

    self setturretmodechangewait( 1 );
    _ID28142();
    _ID28143( var_1 );
    thread _ID28158();

    switch ( var_0 )
    {
        case "minigun_turret":
        case "minigun_turret_1":
        case "minigun_turret_2":
        case "minigun_turret_3":
        case "minigun_turret_4":
            self._ID21295 = 0;
            self.heatlevel = 0;
            self._ID23149 = 0;
            thread _ID28104();
            break;
        case "gl_turret":
        case "gl_turret_1":
        case "gl_turret_2":
        case "gl_turret_3":
        case "gl_turret_4":
            self._ID21295 = 0;
            self.heatlevel = 0;
            self.cooldownwaittime = 0;
            self._ID23149 = 0;
            thread _ID34026();
            thread turret_coolmonitor();
            break;
        case "sam_turret":
        case "scramble_turret":
            thread _ID28102();
            thread _ID28079();
            break;
        default:
            thread _ID28102();
            thread _ID28074();
            thread _ID28079();
            break;
    }
}

sentry_createbombsquadmodel( var_0 )
{
    if ( isdefined( level._ID28172[var_0].modelbombsquad ) )
    {
        var_1 = spawn( "script_model", self.origin );
        var_1.angles = self.angles;
        var_1 hide();
        var_1 thread maps\mp\gametypes\_weapons::bombsquadvisibilityupdater( self.owner );
        var_1 setmodel( level._ID28172[var_0].modelbombsquad );
        var_1 linkto( self );
        var_1 setcontents( 0 );
        self.bombsquadmodel = var_1;
        self waittill( "death" );

        if ( isdefined( var_1 ) )
            var_1 delete();
    }
}

_ID28099()
{
    self endon( "carried" );
    maps\mp\gametypes\_damage::_ID21371( level._ID28172[self._ID28174].maxhealth, "sentry", ::_ID28165, ::sentrymodifydamage, 1 );
}

sentrymodifydamage( var_0, var_1, var_2, var_3 )
{
    var_4 = var_3;

    if ( var_2 == "MOD_MELEE" )
        var_4 = self.maxhealth * 0.34;

    var_4 = maps\mp\gametypes\_damage::_ID16266( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handlegrenadedamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleapdamage( var_1, var_2, var_4, var_0 );
    return var_4;
}

_ID28165( var_0, var_1, var_2, var_3 )
{
    var_4 = level._ID28172[self._ID28174];
    var_5 = maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, var_4._ID36472, var_4._ID35387 );

    if ( var_5 )
        var_0 notify( "destroyed_equipment" );
}

_ID28163()
{
    self endon( "carried" );
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "emp_damage",  var_0, var_1  );
        maps\mp\gametypes\_weapons::_ID31835();
        playfxontag( common_scripts\utility::_ID15033( "emp_stun" ), self, "tag_aim" );
        self setdefaultdroppitch( 40 );
        self setmode( level._ID28172[self._ID28174]._ID28167 );
        wait(var_1);
        self setdefaultdroppitch( -89.0 );
        self setmode( level._ID28172[self._ID28174]._ID28168 );
        thread maps\mp\gametypes\_weapons::doblinkinglight( level._ID28172[self._ID28174]._ID19962 );
    }
}

_ID28100()
{
    self endon( "carried" );
    self waittill( "death" );

    if ( !isdefined( self ) )
        return;

    self freeentitysentient();
    self setmodel( level._ID28172[self._ID28174]._ID21271 );
    _ID28142();
    self setdefaultdroppitch( 40 );
    self setsentryowner( undefined );

    if ( isdefined( self._ID18319 ) )
        self useby( self._ID18319 );

    self setturretminimapvisible( 0 );

    if ( isdefined( self._ID23194 ) )
        self._ID23194 delete();

    self playsound( "sentry_explode" );

    switch ( self._ID28174 )
    {
        case "minigun_turret":
        case "gl_turret":
            self._ID13518 = 1;
            self turretfiredisable();
            break;
        default:
            break;
    }

    if ( isdefined( self._ID18319 ) )
    {
        playfxontag( common_scripts\utility::_ID15033( "sentry_explode_mp" ), self, "tag_origin" );
        playfxontag( common_scripts\utility::_ID15033( "sentry_smoke_mp" ), self, "tag_aim" );
        self._ID18319._ID34041 maps\mp\gametypes\_hud_util::destroyelem();
        self._ID18319 _ID26206();
        self._ID18319 _ID26215();
        self notify( "deleting" );
        wait 1.0;
        stopfxontag( common_scripts\utility::_ID15033( "sentry_explode_mp" ), self, "tag_origin" );
        stopfxontag( common_scripts\utility::_ID15033( "sentry_smoke_mp" ), self, "tag_aim" );
    }
    else
    {
        playfxontag( common_scripts\utility::_ID15033( "sentry_sparks_mp" ), self, "tag_aim" );
        self playsound( "sentry_explode_smoke" );

        for ( var_0 = 8; var_0 > 0; var_0 -= 0.4 )
        {
            playfxontag( common_scripts\utility::_ID15033( "sentry_smoke_mp" ), self, "tag_aim" );
            wait 0.4;
        }

        playfx( common_scripts\utility::_ID15033( "sentry_explode_mp" ), self.origin + ( 0, 0, 10 ) );
        self notify( "deleting" );
    }

    maps\mp\gametypes\_weapons::equipmentdeletevfx();

    if ( isdefined( self._ID19214 ) )
        self._ID19214 delete();

    self delete();
}

_ID28102()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger",  var_0  );

        if ( !maps\mp\_utility::_ID18757( var_0 ) )
            continue;

        if ( self._ID28174 == "sam_turret" || self._ID28174 == "scramble_turret" )
            self setmode( level._ID28172[self._ID28174]._ID28167 );

        var_0 _ID28668( self, 0 );
    }
}

_ID34021( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );

    if ( !isdefined( var_0._ID23194 ) )
        return;

    var_1 = 0;

    for (;;)
    {
        if ( isalive( self ) && self istouching( var_0._ID23194 ) && !isdefined( var_0._ID18319 ) && !isdefined( var_0.carriedby ) && self isonground() )
        {
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

                var_0 setmode( level._ID28172[var_0._ID28174]._ID28167 );
                thread _ID28668( var_0, 0 );
                var_0._ID23194 delete();
                return;
            }
        }

        wait 0.05;
    }
}

_ID34022()
{
    self notify( "turret_handluse" );
    self endon( "turret_handleuse" );
    self endon( "deleting" );
    level endon( "game_ended" );
    self._ID13518 = 0;
    var_0 = ( 1, 0.9, 0.7 );
    var_1 = ( 1, 0.65, 0 );
    var_2 = ( 1, 0.25, 0 );

    for (;;)
    {
        self waittill( "trigger",  var_3  );

        if ( isdefined( self.carriedby ) )
            continue;

        if ( isdefined( self._ID18319 ) )
            continue;

        if ( !maps\mp\_utility::_ID18757( var_3 ) )
            continue;

        var_3 _ID26022();
        var_3 _ID26046();
        self._ID18319 = var_3;
        self setmode( level._ID28172[self._ID28174]._ID28167 );
        _ID28143( var_3 );
        self setmode( level._ID28172[self._ID28174]._ID28168 );
        var_3 thread _ID34057( self );
        var_3._ID34041 = var_3 maps\mp\gametypes\_hud_util::createbar( var_0, 100, 6 );
        var_3._ID34041 maps\mp\gametypes\_hud_util::_ID28836( "CENTER", "BOTTOM", 0, -70 );
        var_3._ID34041.alpha = 0.65;
        var_3._ID34041.bar.alpha = 0.65;
        var_4 = 0;

        for (;;)
        {
            if ( !maps\mp\_utility::_ID18757( var_3 ) )
            {
                self._ID18319 = undefined;
                var_3._ID34041 maps\mp\gametypes\_hud_util::destroyelem();
                break;
            }

            if ( !var_3 isusingturret() )
            {
                self notify( "player_dismount" );
                self._ID18319 = undefined;
                var_3._ID34041 maps\mp\gametypes\_hud_util::destroyelem();
                var_3 _ID26206();
                var_3 _ID26215();
                self sethintstring( level._ID28172[self._ID28174]._ID16999 );
                self setmode( level._ID28172[self._ID28174]._ID28167 );
                _ID28143( self._ID23036 );
                self setmode( level._ID28172[self._ID28174]._ID28168 );
                break;
            }

            if ( self.heatlevel >= level._ID28172[self._ID28174].overheattime )
                var_5 = 1;
            else
                var_5 = self.heatlevel / level._ID28172[self._ID28174].overheattime;

            var_3._ID34041 maps\mp\gametypes\_hud_util::_ID34509( var_5 );

            if ( common_scripts\utility::string_starts_with( self._ID28174, "minigun_turret" ) )
                var_6 = "minigun_turret";

            if ( self._ID13518 || self._ID23149 )
            {
                self turretfiredisable();
                var_3._ID34041.bar.color = var_2;
                var_4 = 0;
            }
            else if ( self.heatlevel > level._ID28172[self._ID28174].overheattime * 0.75 && common_scripts\utility::string_starts_with( self._ID28174, "minigun_turret" ) )
            {
                var_3._ID34041.bar.color = var_1;

                if ( randomintrange( 0, 10 ) < 6 )
                    self turretfireenable();
                else
                    self turretfiredisable();

                if ( !var_4 )
                {
                    var_4 = 1;
                    thread playheatfx();
                }
            }
            else
            {
                var_3._ID34041.bar.color = var_0;
                self turretfireenable();
                var_4 = 0;
                self notify( "not_overheated" );
            }

            wait 0.05;
        }

        self setdefaultdroppitch( 0.0 );
    }
}

_ID28101()
{
    self endon( "death" );
    level endon( "game_ended" );
    self notify( "sentry_handleOwner" );
    self endon( "sentry_handleOwner" );
    self.owner waittill( "killstreak_disowned" );
    self notify( "death" );
}

_ID28143( var_0 )
{
    self.owner = var_0;
    self setsentryowner( self.owner );
    self setturretminimapvisible( 1, self._ID28174 );

    if ( level._ID32653 )
    {
        self.team = self.owner.team;
        self setturretteam( self.team );
    }

    thread _ID28101();
}

_ID28112( var_0 )
{
    self notify( "death" );
}

_ID28144()
{
    self setmodel( level._ID28172[self._ID28174].modelbase );

    if ( self getmode() == "manual" )
        self setmode( level._ID28172[self._ID28174]._ID28167 );

    thread _ID28099();
    thread _ID28100();
    self setsentrycarrier( undefined );
    self setcandamage( 1 );

    switch ( self._ID28174 )
    {
        case "minigun_turret":
        case "gl_turret":
        case "minigun_turret_1":
        case "minigun_turret_2":
        case "minigun_turret_3":
        case "minigun_turret_4":
        case "gl_turret_1":
        case "gl_turret_2":
        case "gl_turret_3":
        case "gl_turret_4":
            self.angles = self.carriedby.angles;

            if ( isalive( self._ID23036 ) )
                self._ID23036 maps\mp\_utility::setlowermessage( "pickup_hint", level._ID28172[self._ID28174]._ID23185, 3.0, undefined, undefined, undefined, undefined, undefined, 1 );

            self._ID23194 = spawn( "trigger_radius", self.origin + ( 0, 0, 1 ), 0, 105, 64 );
            self._ID23194 enablelinkto();
            self._ID23194 linkto( self );
            self._ID23036 thread _ID34021( self );
            thread _ID34022();
            break;
        default:
            break;
    }

    _ID28109();

    if ( isdefined( self.bombsquadmodel ) )
    {
        self.bombsquadmodel show();
        level notify( "update_bombsquad" );
    }

    self.carriedby forceusehintoff();
    self.carriedby = undefined;
    self._ID13165 = undefined;

    if ( isdefined( self.owner ) )
    {
        self.owner._ID18582 = 0;
        common_scripts\utility::_ID20489( self.owner.team );

        if ( issentient( self ) )
            self setthreatbiasgroup( "DogsDontAttack" );

        self.owner notify( "new_sentry",  self  );
    }

    sentry_setactive();
    var_0 = spawnstruct();

    if ( isdefined( self._ID21723 ) )
        var_0.linkparent = self._ID21723;

    var_0.endonstring = "carried";
    var_0.deathoverridecallback = ::_ID28112;
    thread maps\mp\_movers::_ID16165( var_0 );

    if ( self._ID28174 != "multiturret" )
        self playsound( "sentry_gun_plant" );

    thread maps\mp\gametypes\_weapons::doblinkinglight( level._ID28172[self._ID28174]._ID19962 );
    self notify( "placed" );
}

_ID28138( var_0 )
{
    if ( isdefined( self.carriedby ) )
    {
        var_1 = self.carriedby;
        var_1 forceusehintoff();
        var_1._ID18582 = undefined;
        var_1.carrieditem = undefined;
        var_1 common_scripts\utility::_enableweapon();

        if ( isdefined( self.bombsquadmodel ) )
            self.bombsquadmodel delete();
    }

    if ( isdefined( var_0 ) && var_0 )
        maps\mp\gametypes\_weapons::equipmentdeletevfx();

    self delete();
}

_ID28140( var_0 )
{
    if ( isdefined( self._ID23036 ) )
        jump loc_1409

    self setmodel( level._ID28172[self._ID28174]._ID21276 );
    self setsentrycarrier( var_0 );
    self setcandamage( 0 );
    _ID28108();
    self.carriedby = var_0;
    var_0._ID18582 = 1;
    var_0 thread _ID34603( self );
    thread _ID28115( var_0 );
    thread _ID28116( var_0 );
    thread _ID28114( var_0 );
    thread _ID28117();
    self freeentitysentient();
    self setdefaultdroppitch( -89.0 );
    _ID28142();

    if ( isdefined( self getlinkedparent() ) )
        self unlink();

    self notify( "carried" );

    if ( isdefined( self.bombsquadmodel ) )
        self.bombsquadmodel hide();
}

_ID34603( var_0 )
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
        var_2 = self canplayerplacesentry( 1, 22 );
        var_0.origin = var_2["origin"];
        var_0.angles = var_2["angles"];
        var_0.canbeplaced = self isonground() && var_2["result"] && abs( var_0.origin[2] - self.origin[2] ) < 30;

        if ( isdefined( var_2["entity"] ) )
            var_0._ID21723 = var_2["entity"];
        else
            var_0._ID21723 = undefined;

        if ( var_0.canbeplaced != var_1 )
        {
            if ( var_0.canbeplaced )
            {
                var_0 setmodel( level._ID28172[var_0._ID28174]._ID21276 );
                self forceusehinton( &"SENTRY_PLACE" );
            }
            else
            {
                var_0 setmodel( level._ID28172[var_0._ID28174]._ID21277 );
                self forceusehinton( &"SENTRY_CANNOT_PLACE" );
            }
        }

        var_1 = var_0.canbeplaced;
        wait 0.05;
    }
}

_ID28115( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    var_0 waittill( "death" );

    if ( self.canbeplaced )
        _ID28144();
    else
        _ID28138( 0 );
}

_ID28116( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    var_0 waittill( "disconnect" );
    self delete();
}

_ID28114( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    var_0 common_scripts\utility::_ID35626( "joined_team", "joined_spectators" );
    self delete();
}

_ID28117( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    level waittill( "game_ended" );
    self delete();
}

sentry_setactive()
{
    self setmode( level._ID28172[self._ID28174]._ID28168 );
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( level._ID28172[self._ID28174]._ID16999 );

    if ( level._ID28172[self._ID28174].headicon )
    {
        if ( level._ID32653 )
            maps\mp\_entityheadicons::_ID28896( self.team, ( 0, 0, 65 ) );
        else
            maps\mp\_entityheadicons::_ID28825( self.owner, ( 0, 0, 65 ) );
    }

    self makeusable();

    foreach ( var_1 in level.players )
    {
        switch ( self._ID28174 )
        {
            case "minigun_turret":
            case "gl_turret":
            case "minigun_turret_1":
            case "minigun_turret_2":
            case "minigun_turret_3":
            case "minigun_turret_4":
            case "gl_turret_1":
            case "gl_turret_2":
            case "gl_turret_3":
            case "gl_turret_4":
                self enableplayeruse( var_1 );

                if ( maps\mp\_utility::_ID18363() )
                {
                    var_2 = self getentitynumber();
                    addtoturretlist( var_2 );
                }

                continue;
            default:
                var_2 = self getentitynumber();
                addtoturretlist( var_2 );

                if ( var_1 == self.owner )
                    self enableplayeruse( var_1 );
                else
                    self disableplayeruse( var_1 );

                continue;
        }
    }

    if ( self._ID29893 )
    {
        level thread maps\mp\_utility::_ID32672( level._ID28172[self._ID28174]._ID32680, self.owner, self.owner.team );
        self._ID29893 = 0;
    }

    if ( self._ID28174 == "sam_turret" )
        thread _ID27117();

    if ( self._ID28174 == "scramble_turret" )
        thread _ID27395();

    thread _ID28163();
}

_ID28142()
{
    self setmode( level._ID28172[self._ID28174]._ID28167 );
    self makeunusable();
    self freeentitysentient();
    maps\mp\gametypes\_weapons::_ID31835();
    var_0 = self getentitynumber();

    switch ( self._ID28174 )
    {
        case "gl_turret":
            break;
        default:
            _ID26007( var_0 );
            break;
    }

    if ( level._ID32653 )
        maps\mp\_entityheadicons::_ID28896( "none", ( 0, 0, 0 ) );
    else if ( isdefined( self.owner ) )
        maps\mp\_entityheadicons::_ID28825( undefined, ( 0, 0, 0 ) );
}

_ID28109()
{
    self maketurretsolid();
}

_ID28108()
{
    self setcontents( 0 );
}

_ID18637( var_0 )
{
    if ( level._ID32653 && self.team == var_0.team )
        return 1;

    return 0;
}

addtoturretlist( var_0 )
{
    level._ID34099[var_0] = self;
}

_ID26007( var_0 )
{
    level._ID34099[var_0] = undefined;
}

_ID28074()
{
    self endon( "death" );
    level endon( "game_ended" );
    self._ID21295 = 0;
    self.heatlevel = 0;
    self._ID23149 = 0;
    thread _ID28104();

    for (;;)
    {
        common_scripts\utility::_ID35663( "turretstatechange", "cooled" );

        if ( self isfiringturret() )
        {
            thread _ID28082();
            continue;
        }

        _ID28148();
        thread sentry_burstfirestop();
    }
}

_ID28158()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = level._ID28172[self._ID28174].timeout;

    if ( !maps\mp\_utility::_ID18363() )
    {

    }

    while ( var_0 )
    {
        wait 1.0;
        maps\mp\gametypes\_hostmigration::_ID35770();

        if ( !isdefined( self.carriedby ) )
            var_0 = max( 0, var_0 - 1.0 );
    }

    if ( isdefined( self.owner ) )
    {
        if ( self._ID28174 == "sam_turret" )
            self.owner thread maps\mp\_utility::_ID19765( "sam_gone" );
        else if ( self._ID28174 == "scramble_turret" )
            self.owner thread maps\mp\_utility::_ID19765( "sam_gone" );
        else
            self.owner thread maps\mp\_utility::_ID19765( "sentry_gone" );
    }

    self notify( "death" );
}

_ID28154()
{
    self endon( "death" );
    self playsound( "sentry_gun_beep" );
    wait 0.1;
    self playsound( "sentry_gun_beep" );
    wait 0.1;
    self playsound( "sentry_gun_beep" );
}

_ID28149()
{
    thread _ID28154();

    while ( self._ID21295 < level._ID28172[self._ID28174]._ID31014 )
    {
        self._ID21295 = self._ID21295 + 0.1;
        wait 0.1;
    }
}

_ID28148()
{
    self._ID21295 = 0;
}

_ID28082()
{
    self endon( "death" );
    self endon( "stop_shooting" );
    level endon( "game_ended" );
    _ID28149();
    var_0 = weaponfiretime( level._ID28172[self._ID28174].weaponinfo );
    var_1 = level._ID28172[self._ID28174].burstmin;
    var_2 = level._ID28172[self._ID28174]._ID6331;
    var_3 = level._ID28172[self._ID28174]._ID23388;
    var_4 = level._ID28172[self._ID28174]._ID23387;

    for (;;)
    {
        var_5 = randomintrange( var_1, var_2 + 1 );

        for ( var_6 = 0; var_6 < var_5 && !self._ID23149; var_6++ )
        {
            self shootturret();
            self notify( "bullet_fired" );
            self.heatlevel = self.heatlevel + var_0;
            wait(var_0);
        }

        wait(randomfloatrange( var_3, var_4 ));
    }
}

sentry_burstfirestop()
{
    self notify( "stop_shooting" );
}

_ID34057( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "player_dismount" );
    var_1 = weaponfiretime( level._ID28172[var_0._ID28174].weaponinfo );

    for (;;)
    {
        var_0 waittill( "turret_fire" );
        var_0.heatlevel = var_0.heatlevel + var_1;
        var_0.cooldownwaittime = var_1;
    }
}

_ID28104()
{
    self endon( "death" );
    var_0 = weaponfiretime( level._ID28172[self._ID28174].weaponinfo );
    var_1 = 0;
    var_2 = 0;
    var_3 = level._ID28172[self._ID28174].overheattime;
    var_4 = level._ID28172[self._ID28174].cooldowntime;

    for (;;)
    {
        if ( self.heatlevel != var_1 )
            wait(var_0);
        else
            self.heatlevel = max( 0, self.heatlevel - 0.05 );

        if ( self.heatlevel > var_3 )
        {
            self._ID23149 = 1;
            thread playheatfx();

            switch ( self._ID28174 )
            {
                case "minigun_turret":
                case "minigun_turret_1":
                case "minigun_turret_2":
                case "minigun_turret_3":
                case "minigun_turret_4":
                    playfxontag( common_scripts\utility::_ID15033( "sentry_smoke_mp" ), self, "tag_aim" );
                    break;
                default:
                    break;
            }

            while ( self.heatlevel )
            {
                self.heatlevel = max( 0, self.heatlevel - var_4 );
                wait 0.1;
            }

            self._ID23149 = 0;
            self notify( "not_overheated" );
        }

        var_1 = self.heatlevel;
        wait 0.05;
    }
}

_ID34026()
{
    self endon( "death" );
    var_0 = level._ID28172[self._ID28174].overheattime;

    for (;;)
    {
        if ( self.heatlevel > var_0 )
        {
            self._ID23149 = 1;
            thread playheatfx();

            switch ( self._ID28174 )
            {
                case "gl_turret":
                    playfxontag( common_scripts\utility::_ID15033( "sentry_smoke_mp" ), self, "tag_aim" );
                    break;
                default:
                    break;
            }

            while ( self.heatlevel )
                wait 0.1;

            self._ID23149 = 0;
            self notify( "not_overheated" );
        }

        wait 0.05;
    }
}

turret_coolmonitor()
{
    self endon( "death" );

    for (;;)
    {
        if ( self.heatlevel > 0 )
        {
            if ( self.cooldownwaittime <= 0 )
                self.heatlevel = max( 0, self.heatlevel - 0.05 );
            else
                self.cooldownwaittime = max( 0, self.cooldownwaittime - 0.05 );
        }

        wait 0.05;
    }
}

playheatfx()
{
    self endon( "death" );
    self endon( "not_overheated" );
    level endon( "game_ended" );
    self notify( "playing_heat_fx" );
    self endon( "playing_heat_fx" );

    for (;;)
    {
        playfxontag( common_scripts\utility::_ID15033( "sentry_overheat_mp" ), self, "tag_flash" );
        wait(level._ID28172[self._ID28174].fxtime);
    }
}

_ID24636()
{
    self endon( "death" );
    self endon( "not_overheated" );
    level endon( "game_ended" );

    for (;;)
    {
        playfxontag( common_scripts\utility::_ID15033( "sentry_smoke_mp" ), self, "tag_aim" );
        wait 0.4;
    }
}

_ID28079()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 3.0;

        if ( !isdefined( self.carriedby ) )
            self playsound( "sentry_gun_beep" );
    }
}

_ID27117()
{
    self endon( "carried" );
    self endon( "death" );
    level endon( "game_ended" );
    self.samtargetent = undefined;
    self._ID27159 = [];

    for (;;)
    {
        self.samtargetent = _ID27114();
        _ID27125();
        wait 0.05;
    }
}

_ID27114()
{
    var_0 = self gettagorigin( "tag_laser" );

    if ( !isdefined( self.samtargetent ) )
    {
        if ( level._ID32653 )
        {
            var_1 = [];

            if ( level.multiteambased )
            {
                foreach ( var_3 in level._ID32668 )
                {
                    if ( var_3 != self.team )
                    {
                        foreach ( var_5 in level._ID34165[var_3] )
                            var_1[var_1.size] = var_5;
                    }
                }
            }
            else
                var_1 = level._ID34165[level._ID23070[self.team]];

            foreach ( var_9 in var_1 )
            {
                if ( isdefined( var_9._ID18690 ) && var_9._ID18690 )
                    continue;

                if ( sighttracepassed( var_0, var_9.origin, 0, self ) )
                    return var_9;
            }

            foreach ( var_12 in level._ID20086 )
            {
                if ( isdefined( var_12.team ) && var_12.team == self.team )
                    continue;

                if ( sighttracepassed( var_0, var_12.origin, 0, self ) )
                    return var_12;
            }

            foreach ( var_15 in level._ID16755 )
            {
                if ( isdefined( var_15.team ) && var_15.team == self.team )
                    continue;

                if ( sighttracepassed( var_0, var_15.origin, 0, self ) )
                    return var_15;
            }

            foreach ( var_9 in level._ID25810 )
            {
                if ( !isdefined( var_9 ) )
                    continue;

                if ( isdefined( var_9.team ) && var_9.team == self.team )
                    continue;

                if ( sighttracepassed( var_0, var_9.origin, 0, self, var_9 ) )
                    return var_9;
            }
        }
        else
        {
            foreach ( var_9 in level._ID34165 )
            {
                if ( isdefined( var_9._ID18690 ) && var_9._ID18690 )
                    continue;

                if ( isdefined( var_9.owner ) && isdefined( self.owner ) && var_9.owner == self.owner )
                    continue;

                if ( sighttracepassed( var_0, var_9.origin, 0, self ) )
                    return var_9;
            }

            foreach ( var_12 in level._ID20086 )
            {
                if ( isdefined( var_12.owner ) && isdefined( self.owner ) && var_12.owner == self.owner )
                    continue;

                if ( sighttracepassed( var_0, var_12.origin, 0, self ) )
                    return var_12;
            }

            foreach ( var_15 in level._ID16755 )
            {
                if ( isdefined( var_15.owner ) && isdefined( self.owner ) && var_15.owner == self.owner )
                    continue;

                if ( sighttracepassed( var_0, var_15.origin, 0, self ) )
                    return var_15;
            }

            foreach ( var_9 in level._ID25810 )
            {
                if ( !isdefined( var_9 ) )
                    continue;

                if ( isdefined( var_9.owner ) && isdefined( self.owner ) && var_9.owner == self.owner )
                    continue;

                if ( sighttracepassed( var_0, var_9.origin, 0, self, var_9 ) )
                    return var_9;
            }
        }

        self cleartargetentity();
        return undefined;
    }
    else
    {
        if ( !sighttracepassed( var_0, self.samtargetent.origin, 0, self ) )
        {
            self cleartargetentity();
            return undefined;
        }

        return self.samtargetent;
    }
}

_ID27125()
{
    if ( isdefined( self.samtargetent ) )
    {
        if ( self.samtargetent == level.ac130.planemodel && !isdefined( level.ac130player ) )
        {
            self.samtargetent = undefined;
            self cleartargetentity();
            return;
        }

        self settargetentity( self.samtargetent );
        self waittill( "turret_on_target" );

        if ( !isdefined( self.samtargetent ) )
            return;

        if ( !self._ID19412 )
        {
            thread _ID27151();
            thread _ID27150();
            thread sam_watchleaving();
            thread _ID27153();
        }

        wait 2.0;

        if ( !isdefined( self.samtargetent ) )
            return;

        if ( self.samtargetent == level.ac130.planemodel && !isdefined( level.ac130player ) )
        {
            self.samtargetent = undefined;
            self cleartargetentity();
            return;
        }

        var_0 = [];
        var_0[0] = self gettagorigin( "tag_le_missile1" );
        var_0[1] = self gettagorigin( "tag_le_missile2" );
        var_0[2] = self gettagorigin( "tag_ri_missile1" );
        var_0[3] = self gettagorigin( "tag_ri_missile2" );
        var_1 = self._ID27159.size;

        for ( var_2 = 0; var_2 < 4; var_2++ )
        {
            if ( !isdefined( self.samtargetent ) )
                return;

            if ( isdefined( self.carriedby ) )
                return;

            self shootturret();
            var_3 = magicbullet( "sam_projectile_mp", var_0[var_2], self.samtargetent.origin, self.owner );
            var_3 missile_settargetent( self.samtargetent );
            var_3 missile_setflightmodedirect();
            var_3.samturret = self;
            var_3._ID27158 = var_1;
            self._ID27159[var_1][var_2] = var_3;
            level notify( "sam_missile_fired",  self.owner, var_3, self.samtargetent  );

            if ( var_2 == 3 )
                break;

            wait 0.25;
        }

        level notify( "sam_fired",  self.owner, self._ID27159[var_1], self.samtargetent  );
        wait 3.0;
    }
}

_ID27153()
{
    level endon( "game_ended" );
    self endon( "death" );

    while ( isdefined( self.samtargetent ) && isdefined( self getturrettarget( 1 ) ) && self getturrettarget( 1 ) == self.samtargetent )
    {
        var_0 = self gettagorigin( "tag_laser" );

        if ( !sighttracepassed( var_0, self.samtargetent.origin, 0, self, self.samtargetent ) )
        {
            self cleartargetentity();
            self.samtargetent = undefined;
            break;
        }

        wait 0.05;
    }
}

_ID27151()
{
    self endon( "death" );
    self laseron();
    self._ID19412 = 1;

    while ( isdefined( self.samtargetent ) && isdefined( self getturrettarget( 1 ) ) && self getturrettarget( 1 ) == self.samtargetent )
        wait 0.05;

    self laseroff();
    self._ID19412 = 0;
}

_ID27150()
{
    self endon( "death" );
    self.samtargetent endon( "death" );

    if ( !isdefined( self.samtargetent._ID16760 ) )
        return;

    self.samtargetent waittill( "crashing" );
    self cleartargetentity();
    self.samtargetent = undefined;
}

sam_watchleaving()
{
    self endon( "death" );
    self.samtargetent endon( "death" );

    if ( !isdefined( self.samtargetent.model ) )
        return;

    if ( self.samtargetent.model == "vehicle_uav_static_mp" )
    {
        self.samtargetent waittill( "leaving" );
        self cleartargetentity();
        self.samtargetent = undefined;
    }
}

_ID27395()
{
    self endon( "carried" );
    self endon( "death" );
    level endon( "game_ended" );
    self._ID27394 = undefined;

    for (;;)
    {
        self._ID27394 = _ID27385();

        if ( isdefined( self._ID27394 ) && isdefined( self._ID27394._ID27390 ) && !self._ID27394._ID27390 )
            scrambletarget();

        wait 0.05;
    }
}

_ID27385()
{
    return _ID27114();
}

scrambletarget()
{
    if ( isdefined( self._ID27394 ) )
    {
        if ( self._ID27394 == level.ac130.planemodel && !isdefined( level.ac130player ) )
        {
            self._ID27394 = undefined;
            self cleartargetentity();
            return;
        }

        self settargetentity( self._ID27394 );
        self waittill( "turret_on_target" );

        if ( !isdefined( self._ID27394 ) )
            return;

        if ( !self._ID19412 )
        {
            thread _ID27387();
            thread _ID27386();
            thread _ID27388();
            thread scramble_watchlineofsight();
        }

        wait 2.0;

        if ( !isdefined( self._ID27394 ) )
            return;

        if ( self._ID27394 == level.ac130.planemodel && !isdefined( level.ac130player ) )
        {
            self._ID27394 = undefined;
            self cleartargetentity();
            return;
        }

        if ( !isdefined( self._ID27394 ) )
            return;

        if ( isdefined( self.carriedby ) )
            return;

        self shootturret();
        thread setscrambled();
        self notify( "death" );
    }
}

setscrambled()
{
    var_0 = self._ID27394;
    var_0 notify( "scramble_fired",  self.owner  );
    var_0 endon( "scramble_fired" );
    var_0 endon( "death" );
    var_0 thread maps\mp\killstreaks\_helicopter::_ID16687();
    var_0._ID27390 = 1;
    var_0._ID27987 = self.owner;
    var_0 notify( "findNewTarget" );
    wait 30;

    if ( isdefined( var_0 ) )
    {
        var_0._ID27390 = 0;
        var_0._ID27987 = undefined;
        var_0 thread maps\mp\killstreaks\_helicopter::_ID16687();
    }
}

scramble_watchlineofsight()
{
    level endon( "game_ended" );
    self endon( "death" );

    while ( isdefined( self._ID27394 ) && isdefined( self getturrettarget( 1 ) ) && self getturrettarget( 1 ) == self._ID27394 )
    {
        var_0 = self gettagorigin( "tag_laser" );

        if ( !sighttracepassed( var_0, self._ID27394.origin, 0, self, self._ID27394 ) )
        {
            self cleartargetentity();
            self._ID27394 = undefined;
            break;
        }

        wait 0.05;
    }
}

_ID27387()
{
    self endon( "death" );
    self laseron();
    self._ID19412 = 1;

    while ( isdefined( self._ID27394 ) && isdefined( self getturrettarget( 1 ) ) && self getturrettarget( 1 ) == self._ID27394 )
        wait 0.05;

    self laseroff();
    self._ID19412 = 0;
}

_ID27386()
{
    self endon( "death" );
    self._ID27394 endon( "death" );

    if ( !isdefined( self._ID27394._ID16760 ) )
        return;

    self._ID27394 waittill( "crashing" );
    self cleartargetentity();
    self._ID27394 = undefined;
}

_ID27388()
{
    self endon( "death" );
    self._ID27394 endon( "death" );

    if ( !isdefined( self._ID27394.model ) )
        return;

    if ( self._ID27394.model == "vehicle_uav_static_mp" )
    {
        self._ID27394 waittill( "leaving" );
        self cleartargetentity();
        self._ID27394 = undefined;
    }
}
