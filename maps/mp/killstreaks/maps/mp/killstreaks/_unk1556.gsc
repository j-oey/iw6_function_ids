// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    if ( !isdefined( level._ID23658 ) )
        level._ID23658 = [];
}

_ID15615( var_0 )
{
    var_1 = _ID8463( var_0 );
    _ID26022();
    self.carrieditem = var_1;
    var_2 = _ID22778( var_0, var_1, 1 );
    self.carrieditem = undefined;
    _ID26206();
    return isdefined( var_1 );
}

_ID8463( var_0 )
{
    if ( isdefined( self._ID18582 ) && self._ID18582 )
        return;

    var_1 = level._ID23658[var_0];
    var_2 = spawn( "script_model", self.origin );
    var_2 setmodel( var_1.modelbase );
    var_2.angles = self.angles;
    var_2.owner = self;
    var_2.team = self.team;
    var_2.config = var_1;
    var_2._ID13165 = 1;

    if ( isdefined( var_1._ID22789 ) )
        var_2 [[ var_1._ID22789 ]]( var_0 );

    var_2 deactivate( var_0 );
    var_2 thread timeout( var_0 );
    var_2 thread handleuse( var_0 );
    var_2 thread onkillstreakdisowned( var_0 );
    var_2 thread _ID22847( var_0 );
    var_2 thread createbombsquadmodel( var_0 );
    return var_2;
}

handleuse( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger",  var_1  );

        if ( !maps\mp\_utility::_ID18757( var_1 ) )
            continue;

        if ( isdefined( self getlinkedparent() ) )
            self unlink();

        var_1 _ID22778( var_0, self, 0 );
    }
}

_ID22778( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_1 thread _ID22786( var_0, self );
    common_scripts\utility::_disableweapon();

    if ( !isai( self ) )
    {
        self notifyonplayercommand( "placePlaceable", "+attack" );
        self notifyonplayercommand( "placePlaceable", "+attack_akimbo_accessible" );
        self notifyonplayercommand( "cancelPlaceable", "+actionslot 4" );

        if ( !level.console )
        {
            self notifyonplayercommand( "cancelPlaceable", "+actionslot 5" );
            self notifyonplayercommand( "cancelPlaceable", "+actionslot 6" );
            self notifyonplayercommand( "cancelPlaceable", "+actionslot 7" );
        }
    }

    for (;;)
    {
        var_3 = common_scripts\utility::_ID35635( "placePlaceable", "cancelPlaceable", "force_cancel_placement" );

        if ( !isdefined( var_1 ) )
        {
            common_scripts\utility::_enableweapon();
            return 1;
            continue;
        }

        if ( var_3 == "cancelPlaceable" && var_2 || var_3 == "force_cancel_placement" )
        {
            var_1 _ID22783( var_0, var_3 == "force_cancel_placement" && !isdefined( var_1._ID13165 ) );
            return 0;
            continue;
        }

        if ( var_1.canbeplaced )
        {
            var_1 thread _ID22874( var_0 );
            common_scripts\utility::_enableweapon();
            return 1;
        }
    }
}

_ID22783( var_0, var_1 )
{
    if ( isdefined( self.carriedby ) )
    {
        var_2 = self.carriedby;
        var_2 forceusehintoff();
        var_2._ID18582 = undefined;
        var_2.carrieditem = undefined;
        var_2 common_scripts\utility::_enableweapon();
    }

    if ( isdefined( self.bombsquadmodel ) )
        self.bombsquadmodel delete();

    if ( isdefined( self._ID36949 ) )
        self._ID36949 delete();

    var_3 = level._ID23658[var_0];

    if ( isdefined( var_3._ID22784 ) )
        self [[ var_3._ID22784 ]]( var_0 );

    if ( isdefined( var_1 ) && var_1 )
        maps\mp\gametypes\_weapons::equipmentdeletevfx();

    self delete();
}

_ID22874( var_0 )
{
    var_1 = level._ID23658[var_0];
    self.origin = self._ID23668;
    self.angles = self._ID36949.angles;
    self playsound( var_1.placedsfx );
    _ID38034( var_0 );

    if ( isdefined( var_1._ID22875 ) )
        self [[ var_1._ID22875 ]]( var_0 );

    self setcursorhint( "HINT_NOICON" );
    self sethintstring( var_1._ID16999 );
    var_2 = self.owner;
    var_2 forceusehintoff();
    var_2._ID18582 = undefined;
    self.carriedby = undefined;
    self._ID18735 = 1;
    self._ID13165 = undefined;

    if ( isdefined( var_1._ID16453 ) )
    {
        if ( level._ID32653 )
            maps\mp\_entityheadicons::_ID28896( self.team, ( 0, 0, var_1._ID16453 ) );
        else
            maps\mp\_entityheadicons::_ID28825( var_2, ( 0, 0, var_1._ID16453 ) );
    }

    thread _ID16244( var_0 );
    thread _ID16245( var_0 );
    self makeusable();
    common_scripts\utility::_ID20489( self.owner.team );

    if ( issentient( self ) )
        self setthreatbiasgroup( "DogsDontAttack" );

    foreach ( var_4 in level.players )
    {
        if ( var_4 == var_2 )
        {
            self enableplayeruse( var_4 );
            continue;
        }

        self disableplayeruse( var_4 );
    }

    if ( isdefined( self._ID29893 ) )
    {
        level thread maps\mp\_utility::_ID32672( var_1._ID31051, var_2 );
        self._ID29893 = 0;
    }

    var_6 = spawnstruct();
    var_6.linkparent = self._ID21723;
    var_6._ID23898 = 1;
    var_6.endonstring = "carried";

    if ( isdefined( var_1.onmovingplatformcollision ) )
        var_6.deathoverridecallback = var_1.onmovingplatformcollision;

    thread maps\mp\_movers::_ID16165( var_6 );
    thread watchplayerconnected();
    self notify( "placed" );
    self._ID36949 delete();
    self._ID36949 = undefined;
}

_ID22786( var_0, var_1 )
{
    var_2 = level._ID23658[var_0];
    self._ID36949 = var_1 _ID37038( var_0 );
    self._ID18735 = undefined;
    self.carriedby = var_1;
    var_1._ID18582 = 1;
    deactivate( var_0 );
    _ID37426( var_0 );

    if ( isdefined( var_2._ID22787 ) )
        self [[ var_2._ID22787 ]]( var_0 );

    thread _ID34574( var_0, var_1 );
    thread _ID22788( var_0, var_1 );
    self notify( "carried" );
}

_ID34574( var_0, var_1 )
{
    var_1 endon( "death" );
    var_1 endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "placed" );
    self endon( "death" );
    self.canbeplaced = 1;
    var_2 = -1;
    var_3 = level._ID23658[var_0];
    var_4 = ( 0, 0, 0 );

    if ( isdefined( var_3._ID23667 ) )
        var_4 = ( 0, 0, var_3._ID23667 );

    var_5 = self._ID36949;

    for (;;)
    {
        var_6 = var_1 canplayerplacesentry( 1, var_3._ID23669 );
        self._ID23668 = var_6["origin"];
        var_5.origin = self._ID23668 + var_4;
        var_5.angles = var_6["angles"];
        self.canbeplaced = var_1 isonground() && var_6["result"] && abs( self._ID23668[2] - var_1.origin[2] ) < var_3._ID23664;

        if ( isdefined( var_6["entity"] ) )
            self._ID21723 = var_6["entity"];
        else
            self._ID21723 = undefined;

        if ( self.canbeplaced != var_2 )
        {
            if ( self.canbeplaced )
            {
                var_5 setmodel( var_3._ID21276 );
                var_1 forceusehinton( var_3._ID23671 );
            }
            else
            {
                var_5 setmodel( var_3._ID21277 );
                var_1 forceusehinton( var_3.cannotplacestring );
            }
        }

        var_2 = self.canbeplaced;
        wait 0.05;
    }
}

deactivate( var_0 )
{
    self makeunusable();
    _ID16902();
    self freeentitysentient();
    var_1 = level._ID23658[var_0];

    if ( isdefined( var_1._ID22795 ) )
        self [[ var_1._ID22795 ]]( var_0 );
}

_ID16902()
{
    if ( level._ID32653 )
        maps\mp\_entityheadicons::_ID28896( "none", ( 0, 0, 0 ) );
    else if ( isdefined( self.owner ) )
        maps\mp\_entityheadicons::_ID28825( undefined, ( 0, 0, 0 ) );
}

_ID16244( var_0 )
{
    self endon( "carried" );
    var_1 = level._ID23658[var_0];
    maps\mp\gametypes\_damage::_ID21371( var_1.maxhealth, var_1.damagefeedback, ::handledeathdamage, ::modifydamage, 1 );
}

modifydamage( var_0, var_1, var_2, var_3 )
{
    var_4 = var_3;
    var_5 = self.config;

    if ( isdefined( var_5._ID2990 ) && var_5._ID2990 )
        var_4 = maps\mp\gametypes\_damage::handlemeleedamage( var_1, var_2, var_4 );

    if ( isdefined( var_5.allowempdamage ) && var_5.allowempdamage )
        var_4 = maps\mp\gametypes\_damage::handleempdamage( var_1, var_2, var_4 );

    var_4 = maps\mp\gametypes\_damage::_ID16266( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handlegrenadedamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleapdamage( var_1, var_2, var_4, var_0 );

    if ( isdefined( var_5.modifydamage ) )
        var_4 = self [[ var_5.modifydamage ]]( var_1, var_2, var_4 );

    return var_4;
}

handledeathdamage( var_0, var_1, var_2, var_3 )
{
    var_4 = self.config;
    var_5 = maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, var_4._ID36472, var_4._ID9801 );

    if ( var_5 && isdefined( var_4._ID22806 ) )
        self [[ var_4._ID22806 ]]( self._ID31889, var_0, self.owner, var_2 );
}

_ID16245( var_0 )
{
    self endon( "carried" );
    self waittill( "death" );
    var_1 = level._ID23658[var_0];

    if ( isdefined( self ) )
    {
        deactivate( var_0 );

        if ( isdefined( var_1._ID21271 ) )
            self setmodel( var_1._ID21271 );

        if ( isdefined( var_1._ID22798 ) )
            self [[ var_1._ID22798 ]]( var_0 );

        self delete();
    }
}

_ID22788( var_0, var_1 )
{
    self endon( "placed" );
    self endon( "death" );
    var_1 endon( "disconnect" );
    var_1 waittill( "death" );

    if ( self.canbeplaced )
        thread _ID22874( var_0 );
    else
        _ID22783( var_0 );
}

onkillstreakdisowned( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    self.owner waittill( "killstreak_disowned" );
    cleanup( var_0 );
}

_ID22847( var_0 )
{
    self endon( "death" );
    level waittill( "game_ended" );
    cleanup( var_0 );
}

cleanup( var_0 )
{
    if ( isdefined( self._ID18735 ) )
        self notify( "death" );
    else
        _ID22783( var_0 );
}

watchplayerconnected()
{
    self endon( "death" );

    for (;;)
    {
        level waittill( "connected",  var_0  );
        thread _ID22879( var_0 );
    }
}

_ID22879( var_0 )
{
    self endon( "death" );
    var_0 endon( "disconnect" );
    var_0 waittill( "spawned_player" );
    self disableplayeruse( var_0 );
}

timeout( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_1 = level._ID23658[var_0];
    var_2 = var_1._ID19940;

    while ( var_2 > 0.0 )
    {
        wait 1.0;
        maps\mp\gametypes\_hostmigration::_ID35770();

        if ( !isdefined( self.carriedby ) )
            var_2 -= 1.0;
    }

    if ( isdefined( self.owner ) && isdefined( var_1._ID15743 ) )
        self.owner thread maps\mp\_utility::_ID19765( var_1._ID15743 );

    self notify( "death" );
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

createbombsquadmodel( var_0 )
{
    var_1 = level._ID23658[var_0];

    if ( isdefined( var_1.modelbombsquad ) )
    {
        var_2 = spawn( "script_model", self.origin );
        var_2.angles = self.angles;
        var_2 hide();
        var_2 thread maps\mp\gametypes\_weapons::bombsquadvisibilityupdater( self.owner );
        var_2 setmodel( var_1.modelbombsquad );
        var_2 linkto( self );
        var_2 setcontents( 0 );
        self.bombsquadmodel = var_2;
        self waittill( "death" );

        if ( isdefined( var_2 ) )
        {
            var_2 delete();
            self.bombsquadmodel = undefined;
        }
    }
}

_ID38034( var_0 )
{
    self show();

    if ( isdefined( self.bombsquadmodel ) )
    {
        self.bombsquadmodel show();
        level notify( "update_bombsquad" );
    }
}

_ID37426( var_0 )
{
    self hide();

    if ( isdefined( self.bombsquadmodel ) )
        self.bombsquadmodel hide();
}

_ID37038( var_0 )
{
    if ( isdefined( self._ID18582 ) && self._ID18582 )
        return;

    var_1 = spawnturret( "misc_turret", self.origin + ( 0, 0, 25 ), "sentry_minigun_mp" );
    var_1.angles = self.angles;
    var_1.owner = self;
    var_2 = level._ID23658[var_0];
    var_1 setmodel( var_2.modelbase );
    var_1 maketurretinoperable();
    var_1 setturretmodechangewait( 1 );
    var_1 setmode( "sentry_offline" );
    var_1 makeunusable();
    var_1 setsentryowner( self );
    var_1 setsentrycarrier( self );
    var_1 setcandamage( 0 );
    var_1 setcontents( 0 );
    return var_1;
}
