// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["ims"] = ::_ID33853;
    level._ID17474 = [];
    var_0 = spawnstruct();
    var_0.weaponinfo = "ims_projectile_mp";
    var_0.modelbase = "ims_scorpion_body_iw6";
    var_0._ID21276 = "ims_scorpion_body_iw6_placement";
    var_0._ID21277 = "ims_scorpion_body_iw6_placement_failed";
    var_0._ID21271 = "ims_scorpion_body_iw6";
    var_0.modelbombsquad = "ims_scorpion_body_iw6_bombsquad";
    var_0._ID16999 = &"KILLSTREAKS_HINTS_IMS_PICKUP_TO_MOVE";
    var_0._ID23671 = &"KILLSTREAKS_HINTS_IMS_PLACE";
    var_0.cannotplacestring = &"KILLSTREAKS_HINTS_IMS_CANNOT_PLACE";
    var_0._ID31889 = "ims";
    var_0._ID31051 = "used_ims";
    var_0.maxhealth = 1000;
    var_0._ID19940 = 90.0;
    var_0._ID25573 = 0.5;
    var_0._ID15760 = 0.4;
    var_0._ID22404 = 4;
    var_0._ID12530 = "ims_scorpion_explosive_iw6";
    var_0._ID23664 = 30.0;
    var_0._ID23669 = 24.0;
    var_0._ID19935 = "tag_lid";
    var_0._ID19933 = [];
    var_0._ID19933[1] = "IMS_Scorpion_door_1";
    var_0._ID19933[2] = "IMS_Scorpion_door_2";
    var_0._ID19933[3] = "IMS_Scorpion_door_3";
    var_0._ID19933[4] = "IMS_Scorpion_door_4";
    var_0._ID19934 = [];
    var_0._ID19934[1] = "IMS_Scorpion_1_opened";
    var_0._ID19934[2] = "IMS_Scorpion_2_opened";
    var_0._ID19934[3] = "IMS_Scorpion_3_opened";
    var_0.expltagroot = "tag_explosive";
    var_0._ID19217 = ( 0, 0, 12 );
    level._ID17474["ims"] = var_0;
    level._ID1644["ims_explode_mp"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ims_explosion" );
    level._ID1644["ims_smoke_mp"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_sg_damage_blacksmoke" );
    level._ID1644["ims_sensor_explode"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ims_sparks" );
    level._ID1644["ims_antenna_light_mp"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink" );
    level.placedims = [];
}

_ID33853( var_0, var_1 )
{
    var_2 = [];

    if ( isdefined( self._ID17471 ) )
        var_2 = self._ID17471;

    var_3 = giveims( "ims" );

    if ( !isdefined( var_3 ) )
    {
        var_3 = 0;

        if ( isdefined( self._ID17471 ) )
        {
            if ( !var_2.size && self._ID17471.size )
                var_3 = 1;

            if ( var_2.size && var_2[0] != self._ID17471[0] )
                var_3 = 1;
        }
    }

    if ( var_3 )
        maps\mp\_matchdata::_ID20253( level._ID17474["ims"]._ID31889, self.origin );

    self._ID18582 = 0;
    return var_3;
}

giveims( var_0 )
{
    var_1 = createimsforplayer( var_0, self );
    _ID26022();
    self._ID6722 = var_1;
    var_1._ID13165 = 1;
    var_2 = _ID28666( var_1, 1 );
    self._ID6722 = undefined;
    thread _ID26206();
    return var_2;
}

_ID28666( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_0 thread ims_setcarried( self );
    common_scripts\utility::_disableweapon();

    if ( !isai( self ) )
    {
        self notifyonplayercommand( "place_ims", "+attack" );
        self notifyonplayercommand( "place_ims", "+attack_akimbo_accessible" );
        self notifyonplayercommand( "cancel_ims", "+actionslot 4" );

        if ( !level.console )
        {
            self notifyonplayercommand( "cancel_ims", "+actionslot 5" );
            self notifyonplayercommand( "cancel_ims", "+actionslot 6" );
            self notifyonplayercommand( "cancel_ims", "+actionslot 7" );
        }
    }

    for (;;)
    {
        if ( maps\mp\_utility::_ID18363() )
            var_2 = common_scripts\utility::_ID35635( "place_ims", "cancel_ims", "force_cancel_placement", "player_action_slot_restart" );
        else
            var_2 = common_scripts\utility::_ID35635( "place_ims", "cancel_ims", "force_cancel_placement" );

        if ( var_2 == "cancel_ims" || var_2 == "force_cancel_placement" || var_2 == "player_action_slot_restart" )
        {
            if ( !var_1 && var_2 == "cancel_ims" )
                continue;

            if ( level.console )
            {
                var_3 = maps\mp\_utility::getkillstreakweapon( level._ID17474[var_0._ID17475]._ID31889 );

                if ( isdefined( self._ID19258 ) && var_3 == maps\mp\_utility::getkillstreakweapon( self.pers["killstreaks"][self._ID19258]._ID31889 ) && !self getweaponslistitems().size )
                {
                    maps\mp\_utility::_giveweapon( var_3, 0 );
                    maps\mp\_utility::_setactionslot( 4, "weapon", var_3 );
                }
            }

            var_0 ims_setcancelled( var_2 == "force_cancel_placement" && !isdefined( var_0._ID13165 ) );
            return 0;
        }

        if ( !var_0.canbeplaced )
            continue;

        var_0 thread _ID17463();
        self notify( "IMS_placed" );
        common_scripts\utility::_enableweapon();
        return 1;
    }
}

_ID26046()
{
    if ( self hasweapon( "iw6_riotshield_mp" ) )
    {
        self._ID26213 = "iw6_riotshield_mp";
        self takeweapon( "iw6_riotshield_mp" );
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

createimsforplayer( var_0, var_1 )
{
    if ( isdefined( var_1._ID18582 ) && var_1._ID18582 )
        return;

    var_2 = spawnturret( "misc_turret", var_1.origin + ( 0, 0, 25 ), "sentry_minigun_mp" );
    var_2.angles = var_1.angles;
    var_2._ID17475 = var_0;
    var_2.owner = var_1;
    var_2 setmodel( level._ID17474[var_0].modelbase );
    var_2 maketurretinoperable();
    var_2 setturretmodechangewait( 1 );
    var_2 setmode( "sentry_offline" );
    var_2 makeunusable();
    var_2 setsentryowner( var_1 );
    return var_2;
}

createims( var_0 )
{
    var_1 = var_0.owner;
    var_2 = var_0._ID17475;
    var_3 = spawn( "script_model", var_0.origin );
    var_3 setmodel( level._ID17474[var_2].modelbase );
    var_3.scale = 3;
    var_3.angles = var_0.angles;
    var_3._ID17475 = var_2;
    var_3.owner = var_1;
    var_3 setotherent( var_1 );
    var_3.team = var_1.team;
    var_3._ID29893 = 0;
    var_3._ID16844 = 0;
    var_3.attacks = 1;
    var_3 disablemissilestick();
    var_3.hasexplosivefired = [];
    var_3.config = level._ID17474[var_2];
    var_3 thread _ID17449();
    var_3 thread _ID17466();
    var_3 thread _ID17444();
    var_3 thread _ID17456();
    return var_3;
}

_ID17444()
{
    var_0 = spawn( "script_model", self.origin );
    var_0.angles = self.angles;
    var_0 hide();
    var_0 thread maps\mp\gametypes\_weapons::bombsquadvisibilityupdater( self.owner );
    var_0 setmodel( level._ID17474[self._ID17475].modelbombsquad );
    var_0 linkto( self );
    var_0 setcontents( 0 );
    self.bombsquadmodel = var_0;
    self waittill( "death" );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

_ID17452( var_0 )
{
    self._ID17429 = 1;
    self notify( "death" );
}

_ID17445()
{
    self endon( "carried" );
    maps\mp\gametypes\_damage::_ID21371( self.config.maxhealth, "ims", ::_ID17447, ::ims_modifydamage, 1 );
}

ims_modifydamage( var_0, var_1, var_2, var_3 )
{
    if ( self._ID16844 || var_1 == "ims_projectile_mp" )
        return -1;

    var_4 = var_3;

    if ( var_2 == "MOD_MELEE" )
        var_4 = self.maxhealth * 0.25;

    if ( isexplosivedamagemod( var_2 ) )
        var_4 = var_3 * 1.5;

    var_4 = maps\mp\gametypes\_damage::_ID16266( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleapdamage( var_1, var_2, var_4, var_0 );
    return var_4;
}

_ID17447( var_0, var_1, var_2, var_3 )
{
    var_4 = maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, "destroyed_ims", "ims_destroyed" );

    if ( var_4 )
        var_0 notify( "destroyed_equipment" );
}

_ID17446()
{
    self endon( "carried" );
    self waittill( "death" );
    removefromimslist();

    if ( !isdefined( self ) )
        return;

    _ID17462();
    self playsound( "ims_destroyed" );

    if ( isdefined( self._ID18319 ) )
    {
        playfx( common_scripts\utility::_ID15033( "ims_explode_mp" ), self.origin + ( 0, 0, 10 ) );
        playfx( common_scripts\utility::_ID15033( "ims_smoke_mp" ), self.origin );
        self._ID18319 _ID26206();
        self._ID18319 _ID26215();
        self notify( "deleting" );
        wait 1.0;
    }
    else if ( isdefined( self._ID17429 ) )
    {
        playfx( common_scripts\utility::_ID15033( "ims_explode_mp" ), self.origin + ( 0, 0, 10 ) );
        self notify( "deleting" );
    }
    else
    {
        playfx( common_scripts\utility::_ID15033( "ims_explode_mp" ), self.origin + ( 0, 0, 10 ) );
        playfx( common_scripts\utility::_ID15033( "ims_smoke_mp" ), self.origin );
        wait 3.0;
        self playsound( "ims_fire" );
        self notify( "deleting" );
    }

    if ( isdefined( self._ID22499 ) )
        maps\mp\_utility::_objective_delete( self._ID22499 );

    if ( isdefined( self._ID22498 ) )
        maps\mp\_utility::_objective_delete( self._ID22498 );

    maps\mp\gametypes\_weapons::equipmentdeletevfx();
    self enablemissilestick();
    self delete();
}

_ID36063()
{
    self endon( "carried" );
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "emp_damage",  var_0, var_1  );
        maps\mp\gametypes\_weapons::_ID31835();
        playfx( common_scripts\utility::_ID15033( "emp_stun" ), self.origin );
        playfx( common_scripts\utility::_ID15033( "ims_smoke_mp" ), self.origin );
        wait(var_1);
        _ID17465();
    }
}

_ID17449()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger",  var_0  );

        if ( !maps\mp\_utility::_ID18757( var_0 ) )
            continue;

        if ( self.damagetaken >= self.maxhealth )
            continue;

        if ( maps\mp\_utility::_ID18363() && isdefined( level.drill_carrier ) && var_0 == level.drill_carrier )
            continue;

        var_1 = createimsforplayer( self._ID17475, var_0 );

        if ( !isdefined( var_1 ) )
            continue;

        var_1._ID17442 = self;
        _ID17462();
        ims_hideallparts();

        if ( isdefined( self getlinkedparent() ) )
            self unlink();

        var_0 _ID28666( var_1, 0 );
    }
}

_ID17463()
{
    self endon( "death" );
    level endon( "game_ended" );

    if ( isdefined( self.carriedby ) )
        self.carriedby forceusehintoff();

    self.carriedby = undefined;

    if ( isdefined( self.owner ) )
        self.owner._ID18582 = 0;

    self._ID13165 = undefined;
    var_0 = undefined;

    if ( isdefined( self._ID17442 ) )
    {
        var_0 = self._ID17442;
        var_0 endon( "death" );
        var_0.origin = self.origin;
        var_0.angles = self.angles;
        var_0.carriedby = undefined;
        var_0 _ID17464();

        if ( isdefined( var_0.bombsquadmodel ) )
        {
            var_0.bombsquadmodel show();
            var_0 _ID17472( var_0.bombsquadmodel, 1 );
            level notify( "update_bombsquad" );
        }
    }
    else
        var_0 = createims( self );

    var_0 addtoimslist();
    var_0._ID18735 = 1;
    var_0 thread _ID17445();
    var_0 thread _ID36063();
    var_0 thread _ID17446();
    var_0 setcandamage( 1 );
    self playsound( "ims_plant" );
    self notify( "placed" );
    var_0 thread ims_setactive();
    var_1 = spawnstruct();

    if ( isdefined( self._ID21723 ) )
        var_1.linkparent = self._ID21723;

    var_1.endonstring = "carried";
    var_1.deathoverridecallback = ::_ID17452;
    var_0 thread maps\mp\_movers::_ID16165( var_1 );
    self delete();
}

ims_setcancelled( var_0 )
{
    if ( isdefined( self.carriedby ) )
    {
        var_1 = self.carriedby;
        var_1 forceusehintoff();
        var_1._ID18582 = undefined;
        var_1.carrieditem = undefined;
        var_1 common_scripts\utility::_enableweapon();

        if ( isdefined( var_1._ID17471 ) )
        {
            foreach ( var_3 in var_1._ID17471 )
            {
                if ( isdefined( var_3.bombsquadmodel ) )
                    var_3.bombsquadmodel delete();
            }
        }
    }

    if ( isdefined( var_0 ) && var_0 )
        maps\mp\gametypes\_weapons::equipmentdeletevfx();

    self delete();
}

ims_setcarried( var_0 )
{
    removefromimslist();
    self setmodel( level._ID17474[self._ID17475]._ID21276 );
    self setsentrycarrier( var_0 );
    self setcontents( 0 );
    self setcandamage( 0 );
    self.carriedby = var_0;
    var_0._ID18582 = 1;
    var_0 thread _ID34549( self );
    thread ims_oncarrierdeath( var_0 );
    thread ims_oncarrierdisconnect( var_0 );
    thread _ID17455();
    thread ims_onenterride( var_0 );

    if ( maps\mp\_utility::_ID18363() && isdefined( level.drop_ims_when_grabbed_func ) )
        self thread [[ level.drop_ims_when_grabbed_func ]]( var_0 );

    self notify( "carried" );

    if ( isdefined( self._ID17442 ) )
    {
        self._ID17442 notify( "carried" );
        self._ID17442.carriedby = var_0;
        self._ID17442._ID18735 = 0;

        if ( isdefined( self._ID17442.bombsquadmodel ) )
            self._ID17442.bombsquadmodel hide();
    }
}

_ID34549( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "placed" );
    var_0 endon( "death" );
    var_0.canbeplaced = 1;
    var_1 = -1;
    var_2 = level._ID17474[var_0._ID17475];

    for (;;)
    {
        var_3 = self canplayerplacesentry( 1, var_2._ID23669 );
        var_0.origin = var_3["origin"];
        var_0.angles = var_3["angles"];
        var_0.canbeplaced = self isonground() && var_3["result"] && abs( var_0.origin[2] - self.origin[2] ) < var_2._ID23664;

        if ( isdefined( var_3["entity"] ) )
            var_0._ID21723 = var_3["entity"];
        else
            var_0._ID21723 = undefined;

        if ( var_0.canbeplaced != var_1 )
        {
            if ( var_0.canbeplaced )
            {
                var_0 setmodel( level._ID17474[var_0._ID17475]._ID21276 );
                self forceusehinton( level._ID17474[var_0._ID17475]._ID23671 );
            }
            else
            {
                var_0 setmodel( level._ID17474[var_0._ID17475]._ID21277 );
                self forceusehinton( level._ID17474[var_0._ID17475].cannotplacestring );
            }
        }

        var_1 = var_0.canbeplaced;
        wait 0.05;
    }
}

ims_oncarrierdeath( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    var_0 endon( "disconnect" );
    var_0 waittill( "death" );

    if ( self.canbeplaced && var_0.team != "spectator" )
        thread _ID17463();
    else
        ims_setcancelled();
}

ims_oncarrierdisconnect( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    var_0 waittill( "disconnect" );
    ims_setcancelled();
}

ims_onenterride( var_0 )
{
    self endon( "placed" );
    self endon( "death" );

    for (;;)
    {
        if ( isdefined( self.carriedby._ID22850 ) && self.carriedby._ID22850 )
            self notify( "death" );

        wait 0.1;
    }
}

_ID17455( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    level waittill( "game_ended" );
    ims_setcancelled();
}

ims_setactive()
{
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( level._ID17474[self._ID17475]._ID16999 );
    var_0 = self.owner;
    var_0 forceusehintoff();

    if ( !maps\mp\_utility::_ID18363() )
    {
        if ( level._ID32653 )
            maps\mp\_entityheadicons::_ID28896( self.team, ( 0, 0, 60 ) );
        else
            maps\mp\_entityheadicons::_ID28825( var_0, ( 0, 0, 60 ) );
    }

    self makeusable();
    self setcandamage( 1 );
    maps\mp\gametypes\_weapons::_ID20501();

    if ( isdefined( var_0._ID17471 ) )
    {
        foreach ( var_2 in var_0._ID17471 )
        {
            if ( var_2 == self )
                continue;

            var_2 notify( "death" );
        }
    }

    var_0._ID17471 = [];
    var_0._ID17471[0] = self;

    foreach ( var_5 in level.players )
    {
        if ( var_5 == var_0 )
        {
            self enableplayeruse( var_5 );
            continue;
        }

        self disableplayeruse( var_5 );
    }

    if ( self._ID29893 )
    {
        level thread maps\mp\_utility::_ID32672( level._ID17474[self._ID17475]._ID31051, var_0 );
        self._ID29893 = 0;
    }

    var_7 = ( 0, 0, 20 );
    var_8 = ( 0, 0, 256 ) - var_7;
    var_9 = [];
    self.killcam_ents = [];

    for ( var_10 = 0; var_10 < self.config._ID22404; var_10++ )
    {
        if ( numexplosivesexceedmodelcapacity() )
            var_11 = _ID29701( var_10 + 1, self.config._ID22404 - 4 );
        else
            var_11 = var_10 + 1;

        var_12 = self gettagorigin( self.config.expltagroot + var_11 + "_attach" );
        var_13 = self gettagorigin( self.config.expltagroot + var_11 + "_attach" ) + var_7;
        var_9[var_10] = bullettrace( var_13, var_13 + var_8, 0, self );

        if ( var_10 < 4 )
        {
            var_14 = spawn( "script_model", var_12 + self.config._ID19217 );
            var_14 setscriptmoverkillcam( "explosive" );
            self.killcam_ents[self.killcam_ents.size] = var_14;
        }
    }

    var_15 = var_9[0];

    for ( var_10 = 0; var_10 < var_9.size; var_10++ )
    {
        if ( var_9[var_10]["position"][2] < var_15["position"][2] )
            var_15 = var_9[var_10];
    }

    self.attackheightpos = var_15["position"] - ( 0, 0, 20 ) - self.origin;
    var_16 = spawn( "trigger_radius", self.origin, 0, 256, 100 );
    self._ID4128 = var_16;
    self._ID4128 enablelinkto();
    self._ID4128 linkto( self );
    self.attackmovetime = length( self.attackheightpos ) / 200;
    _ID17468();
    _ID17465();
    thread ims_watchplayerconnected();

    foreach ( var_5 in level.players )
        thread _ID17458( var_5 );
}

ims_watchplayerconnected()
{
    self endon( "death" );

    for (;;)
    {
        level waittill( "connected",  var_0  );
        _ID17457( var_0 );
    }
}

_ID17457( var_0 )
{
    self endon( "death" );
    var_0 endon( "disconnect" );
    var_0 waittill( "spawned_player" );
    self disableplayeruse( var_0 );
}

_ID17458( var_0 )
{
    self endon( "death" );
    var_0 endon( "disconnect" );

    for (;;)
    {
        var_0 waittill( "joined_team" );
        self disableplayeruse( var_0 );
    }
}

_ID17456()
{
    self endon( "death" );
    level endon( "game_ended" );
    self.owner waittill( "killstreak_disowned" );

    if ( isdefined( self._ID18735 ) )
        self notify( "death" );
    else
        ims_setcancelled( 0 );
}

_ID17465()
{
    thread maps\mp\gametypes\_weapons::doblinkinglight( "tag_fx" );
    thread _ID17443();
}

_ID17462()
{
    self makeunusable();
    self freeentitysentient();

    if ( level._ID32653 )
        maps\mp\_entityheadicons::_ID28896( "none", ( 0, 0, 0 ) );
    else if ( isdefined( self.owner ) )
        maps\mp\_entityheadicons::_ID28825( undefined, ( 0, 0, 0 ) );

    if ( isdefined( self._ID4128 ) )
        self._ID4128 delete();

    if ( isdefined( self.killcam_ents ) )
    {
        foreach ( var_1 in self.killcam_ents )
        {
            if ( isdefined( var_1 ) )
            {
                if ( isdefined( self.owner ) && isdefined( self.owner._ID17470 ) && var_1 == self.owner._ID17470 )
                {
                    continue;
                    continue;
                }

                var_1 delete();
            }
        }
    }

    if ( isdefined( self._ID12520 ) )
    {
        self._ID12520 delete();
        self._ID12520 = undefined;
    }

    maps\mp\gametypes\_weapons::_ID31835();
}

isfriendlytoims( var_0 )
{
    if ( level._ID32653 && self.team == var_0.team )
        return 1;

    return 0;
}

_ID17443()
{
    self endon( "death" );
    self endon( "emp_damage" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( !isdefined( self._ID4128 ) )
            break;

        self._ID4128 waittill( "trigger",  var_0  );

        if ( isplayer( var_0 ) )
        {
            if ( isdefined( self.owner ) && var_0 == self.owner )
                continue;

            if ( level._ID32653 && var_0.pers["team"] == self.team )
                continue;

            if ( !maps\mp\_utility::_ID18757( var_0 ) )
                continue;
        }
        else if ( isdefined( var_0.owner ) )
        {
            if ( isdefined( self.owner ) && var_0.owner == self.owner )
                continue;

            if ( level._ID32653 && var_0.owner.pers["team"] == self.team )
                continue;
        }

        var_1 = var_0.origin + ( 0, 0, 50 );

        if ( !sighttracepassed( self.attackheightpos + self.origin, var_1, 0, self ) )
            continue;

        var_2 = 0;

        for ( var_3 = 1; var_3 <= self.config._ID22404; var_3++ )
        {
            if ( var_3 > 4 )
                break;

            if ( sighttracepassed( self gettagorigin( self.config._ID19935 + var_3 ), var_1, 0, self ) )
            {
                var_2 = 1;
                break;
            }
        }

        if ( !var_2 )
            continue;

        self playsound( "ims_trigger" );

        if ( maps\mp\_utility::_ID18363() && isdefined( level.ims_alien_grace_period_func ) && isdefined( self.owner ) )
        {
            var_4 = [[ level.ims_alien_grace_period_func ]]( level._ID17474[self._ID17475]._ID15760, self.owner );
            maps\mp\gametypes\_weapons::explosivetrigger( var_0, var_4, "ims" );
        }
        else
            maps\mp\gametypes\_weapons::explosivetrigger( var_0, level._ID17474[self._ID17475]._ID15760, "ims" );

        if ( !isdefined( self._ID4128 ) )
            break;

        if ( !isdefined( self.hasexplosivefired[self.attacks] ) )
        {
            self.hasexplosivefired[self.attacks] = 1;
            thread fire_sensor( var_0, self.attacks );
            self.attacks++;
        }

        if ( self.attacks > self.config._ID22404 )
            break;

        _ID17468();
        self waittill( "sensor_exploded" );
        wait(self.config._ID25573);

        if ( !isdefined( self.owner ) )
            break;
    }

    if ( isdefined( self.carriedby ) && isdefined( self.owner ) && self.carriedby == self.owner )
        return;

    self notify( "death" );
}

fire_sensor( var_0, var_1 )
{
    if ( numexplosivesexceedmodelcapacity() )
        var_1 = _ID29701( var_1, self.config._ID22404 - 4 );

    var_2 = self._ID12520;
    self._ID12520 = undefined;
    var_3 = self.config._ID19935 + var_1;
    playfxontag( level._ID1644["ims_sensor_explode"], self, var_3 );
    imsopendoor( var_1, self.config );
    var_4 = self.config.weaponinfo;
    var_5 = self.owner;
    var_2 unlink();
    var_2 rotateyaw( 3600, self.attackmovetime );
    var_2 moveto( self.attackheightpos + self.origin, self.attackmovetime, self.attackmovetime * 0.25, self.attackmovetime * 0.25 );

    if ( isdefined( var_2._ID19214 ) )
    {
        var_6 = var_2._ID19214;
        var_6 unlink();

        if ( isdefined( self.owner ) )
            self.owner._ID17470 = var_6;

        var_6 moveto( self.attackheightpos + self.origin + self.config._ID19217, self.attackmovetime, self.attackmovetime * 0.25, self.attackmovetime * 0.25 );

        if ( !numexplosivesexceedmodelcapacity() )
            var_6 thread _ID9603( 5.0 );
    }

    var_2 playsound( "ims_launch" );
    var_2 waittill( "movedone" );
    playfx( level._ID1644["ims_sensor_explode"], var_2.origin );
    var_7 = [];
    var_7[0] = var_0.origin;

    for ( var_8 = 0; var_8 < var_7.size; var_8++ )
    {
        if ( isdefined( var_5 ) )
        {
            magicbullet( var_4, var_2.origin, var_7[var_8], var_5 );

            if ( maps\mp\_utility::_ID18363() && isdefined( level.ims_alien_fire_func ) )
                self thread [[ level.ims_alien_fire_func ]]( var_7[var_8], var_5 );

            continue;
        }

        magicbullet( var_4, var_2.origin, var_7[var_8] );
    }

    var_2 delete();
    self notify( "sensor_exploded" );
}

_ID9603( var_0 )
{
    self endon( "death" );
    level maps\mp\gametypes\_hostmigration::_ID35597( var_0 );

    if ( isdefined( self ) )
        self delete();
}

_ID17466()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = level._ID17474[self._ID17475]._ID19940;

    while ( var_0 )
    {
        wait 1.0;
        maps\mp\gametypes\_hostmigration::_ID35770();

        if ( !isdefined( self.carriedby ) )
            var_0 = max( 0, var_0 - 1.0 );
    }

    self notify( "death" );
}

addtoimslist()
{
    var_0 = self getentitynumber();
    level.placedims[var_0] = self;
}

removefromimslist()
{
    var_0 = self getentitynumber();
    level.placedims[var_0] = undefined;
}

ims_hideallparts()
{
    self hide();
    self._ID16844 = 1;
}

_ID17464()
{
    self show();
    self._ID16844 = 0;
    _ID17472( self, 1 );
}

imscreateexplosive( var_0 )
{
    var_1 = spawn( "script_model", self gettagorigin( self.config.expltagroot + var_0 + "_attach" ) );
    var_1 setmodel( self.config._ID12530 );
    var_1.angles = self.angles;
    var_1._ID19214 = self.killcam_ents[var_0 - 1];
    var_1._ID19214 linkto( self );
    return var_1;
}

_ID17468()
{
    for ( var_0 = 1; var_0 <= self.config._ID22404 && isdefined( self.hasexplosivefired[var_0] ); var_0++ )
    {

    }

    if ( var_0 <= self.config._ID22404 )
    {
        if ( numexplosivesexceedmodelcapacity() )
            var_0 = _ID29701( var_0, self.config._ID22404 - 4 );

        var_1 = imscreateexplosive( var_0 );
        var_1 linkto( self );
        self._ID12520 = var_1;
    }
}

imsopendoor( var_0, var_1, var_2 )
{
    var_3 = var_1._ID19935 + var_0 + "_attach";
    var_4 = undefined;

    if ( isdefined( var_2 ) )
        var_4 = var_1._ID19934[var_0];
    else
        var_4 = var_1._ID19933[var_0];

    self scriptmodelplayanim( var_4 );
    var_5 = var_1.expltagroot + var_0 + "_attach";
    self hidepart( var_5 );
}

_ID17472( var_0, var_1 )
{
    var_2 = self.hasexplosivefired.size;

    if ( var_2 > 0 )
    {
        if ( numexplosivesexceedmodelcapacity() )
            var_2 = _ID29701( var_2, self.config._ID22404 - 4 );

        var_0 imsopendoor( var_2, self.config, var_1 );
    }
}

numexplosivesexceedmodelcapacity()
{
    return self.config._ID22404 > 4;
}

_ID29701( var_0, var_1 )
{
    var_2 = var_0 - var_1;
    var_2 = max( 1, var_2 );
    return int( var_2 );
}
