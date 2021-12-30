// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    if ( !isdefined( level.boxsettings ) )
        level.boxsettings = [];
}

_ID5109( var_0, var_1 )
{
    thread watchdeployablemarkercancel( var_1 );
    thread _ID36056( var_1, var_0 );

    for (;;)
    {
        var_2 = common_scripts\utility::_ID35635( "deployable_canceled", "deployable_deployed", "death", "disconnect" );
        return var_2 == "deployable_deployed";
    }
}

_ID33837( var_0, var_1 )
{
    thread watchdeployablemarkercancel( var_1 );
    thread _ID36056( var_1, var_0 );

    for (;;)
    {
        var_2 = common_scripts\utility::_ID35635( "deployable_canceled", "deployable_deployed", "death", "disconnect" );
        return var_2 == "deployable_deployed";
    }
}

watchdeployablemarkercancel( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "deployable_deployed" );
    var_1 = level.boxsettings[var_0];
    var_2 = self getcurrentweapon();

    while ( var_2 == var_1.weaponinfo )
        self waittill( "weapon_change",  var_2  );

    self notify( "deployable_canceled" );
}

_ID36056( var_0, var_1 )
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "deployable_canceled" );

    for (;;)
    {
        self waittill( "grenade_fire",  var_2, var_3  );

        if ( maps\mp\_utility::_ID18757( self ) )
        {
            break;
            continue;
        }

        var_2 delete();
    }

    var_2 makecollidewithitemclip( 1 );
    self notify( "deployable_deployed" );
    var_2.owner = self;
    var_2._ID36273 = var_3;
    self._ID20647 = var_2;
    var_2 playsoundtoplayer( level.boxsettings[var_0]._ID9664, self );
    var_2 thread _ID20648( var_1, var_0, ::box_setactive );
}

_ID23166( var_0 )
{
    self notify( "death" );
}

_ID20648( var_0, var_1, var_2 )
{
    self notify( "markerActivate" );
    self endon( "markerActivate" );
    self waittill( "missile_stuck" );
    var_3 = self.owner;
    var_4 = self.origin;

    if ( !isdefined( var_3 ) )
        return;

    var_5 = _ID8395( var_1, var_4, var_3 );
    var_6 = spawnstruct();
    var_6.linkparent = self getlinkedparent();

    if ( isdefined( var_6.linkparent ) && isdefined( var_6.linkparent.model ) && deployableexclusion( var_6.linkparent.model ) )
    {
        var_5.origin = var_6.linkparent.origin;
        var_7 = var_6.linkparent getlinkedparent();

        if ( isdefined( var_7 ) )
            var_6.linkparent = var_7;
        else
            var_6.linkparent = undefined;
    }

    var_6.deathoverridecallback = ::_ID23166;
    var_5 thread maps\mp\_movers::_ID16165( var_6 );
    var_5._ID21723 = var_6.linkparent;
    var_5 setotherent( var_3 );
    wait 0.05;
    var_5 thread [[ var_2 ]]();
    self delete();

    if ( isdefined( var_5 ) && var_5 maps\mp\_utility::_ID33165() )
        var_5 notify( "death" );
}

deployableexclusion( var_0 )
{
    if ( var_0 == "mp_satcom" )
        return 1;
    else if ( issubstr( var_0, "paris_catacombs_iron" ) )
        return 1;
    else if ( issubstr( var_0, "mp_warhawk_iron_gate" ) )
        return 1;

    return 0;
}

_ID18647()
{
    var_0 = self getcurrentweapon();

    if ( isdefined( var_0 ) )
    {
        foreach ( var_2 in level.boxsettings )
        {
            if ( var_0 == var_2.weaponinfo )
                return 1;
        }
    }

    return 0;
}

_ID8395( var_0, var_1, var_2 )
{
    var_3 = level.boxsettings[var_0];
    var_4 = spawn( "script_model", var_1 - ( 0, 0, 1 ) );
    var_4 setmodel( var_3.modelbase );
    var_4.health = 999999;
    var_4.maxhealth = var_3.maxhealth;
    var_4.angles = var_2.angles;
    var_4.boxtype = var_0;
    var_4.owner = var_2;
    var_4.team = var_2.team;
    var_4._ID17334 = var_3._ID17334;

    if ( isdefined( var_3._ID10811 ) )
        var_4._ID10811 = var_3._ID10811;

    if ( isdefined( var_3._ID20764 ) )
        var_4._ID34772 = var_3._ID20764;

    var_4 box_setinactive();
    var_4 thread box_handleownerdisconnect();
    var_4 addboxtolevelarray();
    return var_4;
}

box_setactive( var_0 )
{
    self setcursorhint( "HINT_NOICON" );
    var_1 = level.boxsettings[self.boxtype];
    self sethintstring( var_1._ID16999 );
    self._ID18318 = 0;
    var_2 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_2, "invisible", ( 0, 0, 0 ) );

    if ( !isdefined( self getlinkedparent() ) )
        objective_position( var_2, self.origin );
    else
        objective_onentity( var_2, self );

    objective_state( var_2, "active" );
    objective_icon( var_2, var_1._ID29628 );
    self._ID22499 = var_2;

    if ( level._ID32653 )
    {
        objective_team( var_2, self.team );

        foreach ( var_4 in level.players )
        {
            if ( self.team == var_4.team && ( !isdefined( var_1.canusecallback ) || var_4 [[ var_1.canusecallback ]]( self ) ) )
                box_seticon( var_4, var_1._ID31889, var_1._ID16454 );
        }
    }
    else
    {
        objective_player( var_2, self.owner getentitynumber() );

        if ( !isdefined( var_1.canusecallback ) || self.owner [[ var_1.canusecallback ]]( self ) )
            box_seticon( self.owner, var_1._ID31889, var_1._ID16454 );
    }

    self makeusable();
    self._ID18835 = 1;
    self setcandamage( 1 );
    thread box_handledamage();
    thread box_handledeath();
    thread _ID5886();
    thread disablewhenjuggernaut();
    common_scripts\utility::_ID20489( self.team, 1 );

    if ( issentient( self ) )
        self setthreatbiasgroup( "DogsDontAttack" );

    if ( isdefined( self.owner ) )
        self.owner notify( "new_deployable_box",  self  );

    if ( level._ID32653 )
    {
        foreach ( var_4 in level._ID23303 )
        {
            _box_setactivehelper( var_4, self.team == var_4.team, var_1.canusecallback );

            if ( !isai( var_4 ) )
                thread box_playerjoinedteam( var_4 );
        }
    }
    else
    {
        foreach ( var_4 in level._ID23303 )
            _box_setactivehelper( var_4, isdefined( self.owner ) && self.owner == var_4, var_1.canusecallback );
    }

    level thread maps\mp\_utility::_ID32672( var_1._ID31051, self.owner, self.team );
    thread _ID5880();
    thread box_agentconnected();

    if ( isdefined( var_1._ID22803 ) )
        self [[ var_1._ID22803 ]]( var_1 );

    thread createbombsquadmodel( self.boxtype );
}

_box_setactivehelper( var_0, var_1, var_2 )
{
    if ( var_1 )
    {
        if ( !isdefined( var_2 ) || var_0 [[ var_2 ]]( self ) )
            box_enableplayeruse( var_0 );
        else
        {
            box_disableplayeruse( var_0 );
            thread _ID10792( var_0 );
        }

        thread boxthink( var_0 );
    }
    else
        box_disableplayeruse( var_0 );
}

_ID5880()
{
    self endon( "death" );

    for (;;)
    {
        level waittill( "connected",  var_0  );
        childthread _ID5887( var_0 );
    }
}

box_agentconnected()
{
    self endon( "death" );

    for (;;)
    {
        level waittill( "spawned_agent_player",  var_0  );
        _ID5869( var_0 );
    }
}

_ID5887( var_0 )
{
    var_0 waittill( "spawned_player" );

    if ( level._ID32653 )
    {
        _ID5869( var_0 );
        thread box_playerjoinedteam( var_0 );
    }
}

box_playerjoinedteam( var_0 )
{
    self endon( "death" );
    var_0 endon( "disconnect" );

    for (;;)
    {
        var_0 waittill( "joined_team" );

        if ( level._ID32653 )
            _ID5869( var_0 );
    }
}

_ID5869( var_0 )
{
    if ( self.team == var_0.team )
    {
        box_enableplayeruse( var_0 );
        thread boxthink( var_0 );
        box_seticon( var_0, level.boxsettings[self.boxtype]._ID31889, level.boxsettings[self.boxtype]._ID16454 );
    }
    else
    {
        box_disableplayeruse( var_0 );
        maps\mp\_entityheadicons::setheadicon( var_0, "", ( 0, 0, 0 ) );
    }
}

box_seticon( var_0, var_1, var_2 )
{
    maps\mp\_entityheadicons::setheadicon( var_0, maps\mp\_utility::getkillstreakoverheadicon( var_1 ), ( 0, 0, var_2 ), 14, 14, undefined, undefined, undefined, undefined, undefined, 0 );
}

box_enableplayeruse( var_0 )
{
    if ( isplayer( var_0 ) )
        self enableplayeruse( var_0 );

    self.disabled_use_for[var_0 getentitynumber()] = 0;
}

box_disableplayeruse( var_0 )
{
    if ( isplayer( var_0 ) )
        self disableplayeruse( var_0 );

    self.disabled_use_for[var_0 getentitynumber()] = 1;
}

box_setinactive()
{
    self makeunusable();
    self._ID18835 = 0;
    maps\mp\_entityheadicons::setheadicon( "none", "", ( 0, 0, 0 ) );

    if ( isdefined( self._ID22499 ) )
        maps\mp\_utility::_objective_delete( self._ID22499 );
}

box_handledamage()
{
    var_0 = level.boxsettings[self.boxtype];
    maps\mp\gametypes\_damage::_ID21371( var_0.maxhealth, var_0.damagefeedback, ::box_handledeathdamage, ::_ID5879, 1 );
}

_ID5879( var_0, var_1, var_2, var_3 )
{
    var_4 = var_3;
    var_5 = level.boxsettings[self.boxtype];

    if ( var_5._ID2990 )
        var_4 = maps\mp\gametypes\_damage::handlemeleedamage( var_1, var_2, var_4 );

    var_4 = maps\mp\gametypes\_damage::_ID16266( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handlegrenadedamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleapdamage( var_1, var_2, var_4, var_0 );
    return var_4;
}

box_handledeathdamage( var_0, var_1, var_2, var_3 )
{
    var_4 = level.boxsettings[self.boxtype];
    var_5 = maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, var_4._ID36472, var_4._ID35387 );

    if ( var_5 )
        var_0 notify( "destroyed_equipment" );
}

box_handledeath()
{
    self waittill( "death" );

    if ( !isdefined( self ) )
        return;

    box_setinactive();
    _ID25983();
    var_0 = level.boxsettings[self.boxtype];
    playfx( var_0.deathvfx, self.origin );
    self playsound( "mp_killstreak_disappear" );

    if ( isdefined( var_0.deathdamagemax ) )
    {
        var_1 = undefined;

        if ( isdefined( self.owner ) )
            var_1 = self.owner;

        radiusdamage( self.origin + ( 0, 0, var_0._ID16454 ), var_0.deathdamageradius, var_0.deathdamagemax, var_0._ID9075, var_1, "MOD_EXPLOSIVE", var_0._ID9104 );
    }

    self notify( "deleting" );
    self delete();
}

box_handleownerdisconnect()
{
    self endon( "death" );
    level endon( "game_ended" );
    self notify( "box_handleOwner" );
    self endon( "box_handleOwner" );
    self.owner waittill( "killstreak_disowned" );
    self notify( "death" );
}

boxthink( var_0 )
{
    self endon( "death" );
    thread _ID5888( var_0 );

    if ( !isdefined( var_0.boxes ) )
        var_0.boxes = [];

    var_0.boxes[var_0.boxes.size] = self;
    var_1 = level.boxsettings[self.boxtype];

    for (;;)
    {
        self waittill( "captured",  var_2  );

        if ( var_2 == var_0 )
        {
            var_0 playlocalsound( var_1._ID22921 );

            if ( isdefined( var_1._ID22917 ) )
                var_0 [[ var_1._ID22917 ]]( self );

            if ( isdefined( self.owner ) && var_0 != self.owner )
            {
                self.owner thread maps\mp\gametypes\_rank::_ID36462( var_1._ID12275 );
                self.owner thread maps\mp\gametypes\_rank::giverankxp( "support", var_1._ID34785 );
            }

            if ( isdefined( self._ID34772 ) )
            {
                self._ID34772--;

                if ( self._ID34772 == 0 )
                {
                    _ID5877();
                    break;
                }
            }

            if ( isdefined( var_1.canuseotherboxes ) && var_1.canuseotherboxes )
            {
                foreach ( var_4 in level._ID9646[var_1._ID31889] )
                {
                    var_4 box_disableplayeruse( self );
                    var_4 maps\mp\_entityheadicons::setheadicon( self, "", ( 0, 0, 0 ) );
                    var_4 thread _ID10792( self );
                }

                continue;
            }

            maps\mp\_entityheadicons::setheadicon( var_0, "", ( 0, 0, 0 ) );
            box_disableplayeruse( var_0 );
            thread _ID10792( var_0 );
        }
    }
}

_ID10792( var_0 )
{
    self endon( "death" );
    var_0 endon( "disconnect" );
    var_0 waittill( "death" );

    if ( level._ID32653 )
    {
        if ( self.team == var_0.team )
        {
            box_seticon( var_0, level.boxsettings[self.boxtype]._ID31889, level.boxsettings[self.boxtype]._ID16454 );
            box_enableplayeruse( var_0 );
        }
    }
    else if ( isdefined( self.owner ) && self.owner == var_0 )
    {
        box_seticon( var_0, level.boxsettings[self.boxtype]._ID31889, level.boxsettings[self.boxtype]._ID16454 );
        box_enableplayeruse( var_0 );
    }
}

_ID5888( var_0 )
{
    level endon( "game_ended" );

    while ( isdefined( self ) )
    {
        self waittill( "trigger",  var_1  );

        if ( isdefined( level.boxsettings[self.boxtype]._ID37742 ) && level.boxsettings[self.boxtype]._ID37742 && maps\mp\_utility::_ID18679( var_0 getcurrentweapon() ) )
            continue;

        if ( var_1 == var_0 && _ID34751( var_0, level.boxsettings[self.boxtype]._ID34780 ) )
            self notify( "captured",  var_0  );
    }
}

_ID18635( var_0 )
{
    return level._ID32653 && self.team == var_0.team;
}

_ID5886()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = level.boxsettings[self.boxtype];
    var_1 = var_0._ID19940;
    maps\mp\gametypes\_hostmigration::_ID35597( var_1 );

    if ( isdefined( var_0._ID35389 ) )
        self.owner thread maps\mp\_utility::_ID19765( var_0._ID35389 );

    _ID5877();
}

_ID5877()
{
    wait 0.05;
    self notify( "death" );
}

_ID9617( var_0 )
{
    wait 0.25;
    self linkto( var_0, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_0 waittill( "death" );
    _ID5877();
}

box_modelteamupdater( var_0 )
{
    self endon( "death" );
    self hide();

    foreach ( var_2 in level.players )
    {
        if ( var_2.team == var_0 )
            self showtoplayer( var_2 );
    }

    for (;;)
    {
        level waittill( "joined_team" );
        self hide();

        foreach ( var_2 in level.players )
        {
            if ( var_2.team == var_0 )
                self showtoplayer( var_2 );
        }
    }
}

_ID34751( var_0, var_1 )
{
    maps\mp\_movers::script_mover_link_to_use_object( var_0 );
    var_0 common_scripts\utility::_disableweapon();
    var_0._ID5893 = spawnstruct();
    var_0._ID5893.curprogress = 0;
    var_0._ID5893._ID18318 = 1;
    var_0._ID5893._ID34766 = 0;
    var_0._ID5893._ID17334 = self._ID17334;

    if ( isdefined( var_1 ) )
        var_0._ID5893._ID34780 = var_1;
    else
        var_0._ID5893._ID34780 = 3000;

    var_2 = useholdthinkloop( var_0 );

    if ( isalive( var_0 ) )
    {
        var_0 common_scripts\utility::_enableweapon();
        maps\mp\_movers::script_mover_unlink_from_use_object( var_0 );
    }

    if ( !isdefined( self ) )
        return 0;

    var_0._ID5893._ID18318 = 0;
    var_0._ID5893.curprogress = 0;
    return var_2;
}

useholdthinkloop( var_0 )
{
    var_1 = var_0._ID5893;

    while ( var_0 _ID37552( var_1 ) )
    {
        if ( !var_0 maps\mp\_movers::script_mover_use_can_link( self ) )
        {
            var_0 maps\mp\gametypes\_gameobjects::_ID34638( var_1, 0 );
            return 0;
        }

        var_1.curprogress = var_1.curprogress + 50 * var_1._ID34766;

        if ( isdefined( var_0.objectivescaler ) )
            var_1._ID34766 = 1 * var_0.objectivescaler;
        else
            var_1._ID34766 = 1;

        var_0 maps\mp\gametypes\_gameobjects::_ID34638( var_1, 1 );

        if ( var_1.curprogress >= var_1._ID34780 )
        {
            var_0 maps\mp\gametypes\_gameobjects::_ID34638( var_1, 0 );
            return maps\mp\_utility::_ID18757( var_0 );
        }

        wait 0.05;
    }

    var_0 maps\mp\gametypes\_gameobjects::_ID34638( var_1, 0 );
    return 0;
}

disablewhenjuggernaut()
{
    level endon( "game_ended" );
    self endon( "death" );

    for (;;)
    {
        level waittill( "juggernaut_equipped",  var_0  );
        maps\mp\_entityheadicons::setheadicon( var_0, "", ( 0, 0, 0 ) );
        box_disableplayeruse( var_0 );
        thread _ID10792( var_0 );
    }
}

addboxtolevelarray()
{
    level._ID9646[self.boxtype][self getentitynumber()] = self;
}

_ID25983()
{
    level._ID9646[self.boxtype][self getentitynumber()] = undefined;
}

createbombsquadmodel( var_0 )
{
    var_1 = level.boxsettings[var_0];

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

_ID37552( var_0 )
{
    return !level.gameended && isdefined( var_0 ) && maps\mp\_utility::_ID18757( self ) && self usebuttonpressed() && !self isonladder() && !self meleebuttonpressed() && !isdefined( self._ID32944 ) && var_0.curprogress < var_0._ID34780 && ( !isdefined( self._ID32801 ) || !self._ID32801 );
}
