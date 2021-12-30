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
    if ( var_0 == "weapon_alien_laser_drill" )
        return 1;
    else if ( issubstr( var_0, "crafting" ) )
        return 1;
    else if ( issubstr( var_0, "scorpion_body" ) )
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

_ID14325( var_0, var_1, var_2 )
{
    return level.alien_combat_resources[var_0][var_1]._ID34652[var_2].dpad_icon;
}

_ID14721( var_0 )
{
    if ( !isdefined( var_0 ) )
        return undefined;

    foreach ( var_3, var_2 in level.alien_combat_resources )
    {
        if ( isdefined( var_2[var_0] ) )
            return var_3;
    }

    return undefined;
}

_ID8395( var_0, var_1, var_2 )
{
    var_3 = level.boxsettings[var_0];
    var_4 = spawn( "script_model", var_1 );
    var_4 setmodel( var_3.modelbase );
    var_4.health = 999999;
    var_4.maxhealth = var_3.maxhealth;
    var_4.angles = var_2.angles;
    var_4.boxtype = var_0;
    var_4.owner = var_2;
    var_4.team = var_2.team;

    if ( isdefined( var_3._ID10811 ) )
        var_4._ID10811 = var_3._ID10811;

    if ( isdefined( var_3._ID20764 ) )
        var_4._ID34772 = var_3._ID20764;

    var_5 = var_4.owner;
    var_6 = _ID14721( var_4._ID10811 );

    if ( is_combat_resource( var_6 ) )
    {
        var_4._ID34651 = var_5 maps\mp\alien\_persistence::_ID14816( var_6 );
        var_4.icon_name = _ID14325( var_6, var_4._ID10811, var_4._ID34651 );
    }
    else
    {
        var_4._ID34651 = 0;
        var_4.icon_name = var_3.icon_name;
    }

    level.alienbbdata["team_item_deployed"]++;
    var_5 maps\mp\alien\_persistence::eog_player_update_stat( "deployables", 1 );
    var_4 box_setinactive();
    var_4 thread box_handleownerdisconnect();
    var_4 addboxtolevelarray();
    return var_4;
}

is_combat_resource( var_0 )
{
    return isdefined( var_0 );
}

box_setactive( var_0 )
{
    self setcursorhint( "HINT_NOICON" );
    var_1 = level.boxsettings[self.boxtype];
    self sethintstring( var_1._ID16999 );
    self._ID18318 = 0;
    var_2 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_2, "invisible", ( 0, 0, 0 ) );
    objective_position( var_2, self.origin );
    objective_state( var_2, "active" );

    if ( isdefined( var_1._ID29628 ) )
        objective_icon( var_2, var_1._ID29628 );

    self._ID22499 = var_2;

    if ( ( !isdefined( var_0 ) || !var_0 ) && isdefined( var_1._ID22917 ) && ( !isdefined( var_1.canusecallback ) || self.owner [[ var_1.canusecallback ]]() ) )
    {
        if ( maps\mp\_utility::_ID18757( self.owner ) )
            self.owner [[ var_1._ID22917 ]]( self );
    }

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
    common_scripts\utility::_ID20489( self.team, 1 );

    if ( isdefined( self.owner ) )
        self.owner notify( "new_deployable_box",  self  );

    if ( level._ID32653 )
    {
        foreach ( var_4 in level._ID23303 )
            _box_setactivehelper( var_4, self.team == var_4.team, var_1.canusecallback );
    }
    else
    {
        foreach ( var_4 in level._ID23303 )
            _box_setactivehelper( var_4, isdefined( self.owner ) && self.owner == var_4, var_1.canusecallback );
    }

    if ( ( !isdefined( self.air_dropped ) || !self.air_dropped ) && !maps\mp\alien\_unk1464::_ID18745() )
        level thread maps\mp\_utility::_ID32672( var_1._ID31051, self.owner, self.team );

    thread _ID5880();
    thread box_agentconnected();
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
        _ID5869( var_0 );
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
    maps\mp\_entityheadicons::setheadicon( var_0, self.icon_name, ( 0, 0, var_2 ), 14, 14, undefined, undefined, undefined, undefined, undefined, 0 );
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
    maps\mp\gametypes\_damage::_ID21371( var_0.maxhealth, var_0.damagefeedback, ::boxmodifydamage, ::_ID5891, 1 );
}

boxmodifydamage( var_0, var_1, var_2, var_3 )
{
    var_4 = var_3;

    if ( isexplosivedamagemod( var_2 ) )
        var_4 = var_3 * 1.5;

    var_4 = maps\mp\gametypes\_damage::handlemeleedamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::_ID16266( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleapdamage( var_1, var_2, var_4, var_0 );
    return var_4;
}

_ID5891( var_0, var_1, var_2, var_3 )
{
    var_4 = level.boxsettings[self.boxtype];
    maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, var_4._ID36472, var_4._ID35387 );
}

box_handledeath()
{
    self waittill( "death" );

    if ( !isdefined( self ) )
        return;

    box_setinactive();
    _ID25983();
    var_0 = level.boxsettings[self.boxtype];
    playfx( common_scripts\utility::_ID15033( "deployablebox_crate_destroy" ), self.origin );

    if ( isdefined( var_0.deathdamagemax ) )
    {
        var_1 = undefined;

        if ( isdefined( self.owner ) )
            var_1 = self.owner;

        radiusdamage( self.origin + ( 0, 0, var_0._ID16454 ), var_0.deathdamageradius, var_0.deathdamagemax, var_0._ID9075, var_1, "MOD_EXPLOSIVE", var_0._ID9104 );
    }

    wait 0.1;
    self notify( "deleting" );
    self delete();
}

box_handleownerdisconnect()
{
    self endon( "death" );
    level endon( "game_ended" );
    self notify( "box_handleOwner" );
    self endon( "box_handleOwner" );
    var_0 = self.owner;
    self.owner waittill( "killstreak_disowned" );

    if ( isdefined( self.air_dropped ) && self.air_dropped )
    {
        foreach ( var_2 in level.players )
        {
            if ( !isdefined( var_2 ) || isdefined( var_0 ) && var_0 == var_2 )
                continue;

            self.owner = var_2;
            thread box_handleownerdisconnect();
            return;
        }
    }

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
            {
                var_0 [[ var_1._ID22917 ]]( self );

                if ( maps\mp\alien\_unk1464::is_chaos_mode() )
                    maps\mp\alien\_chaos::update_pickup_deployable_box_event();
            }

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

    if ( isdefined( self.air_dropped ) && self.air_dropped )
        return;

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
    while ( isdefined( self ) )
    {
        self waittill( "trigger",  var_1  );

        if ( maps\mp\_utility::_ID18363() )
        {
            if ( [[ level._ID5889 ]]( var_1 ) )
                continue;
        }

        if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        {
            switch ( self.boxtype )
            {
                case "specialist_skill":
                case "tank_skill":
                case "engineer_skill":
                case "medic_skill":
                    if ( maps\mp\alien\_unk1464::_ID18506( var_1.haschaosclassskill ) )
                    {
                        var_1 maps\mp\_utility::setlowermessage( "cant_use", &"ALIEN_CHAOS_CANT_PICKUP_BONUS", 3 );
                        continue;
                    }
                    else if ( maps\mp\alien\_unk1464::_ID18506( var_1.chaosclassskillinuse ) )
                    {
                        var_1 maps\mp\_utility::setlowermessage( "skill_in_use", &"ALIEN_CHAOS_SKILL_IN_USE", 3 );
                        continue;
                    }

                    break;
                case "combo_freeze":
                    if ( maps\mp\alien\_unk1464::_ID18506( var_1.hascombofreeze ) )
                    {
                        var_1 maps\mp\_utility::setlowermessage( "cant_use", &"ALIEN_CHAOS_CANT_PICKUP_BONUS", 3 );
                        continue;
                    }

                    break;
                default:
                    break;
            }
        }

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

    if ( box_should_leave_immediately() )
        wait 0.05;
    else
    {
        var_0 = level.boxsettings[self.boxtype]._ID19940;
        maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    }

    _ID5877();
}

box_should_leave_immediately()
{
    if ( self.boxtype == "deployable_ammo" && self._ID34651 == 4 || self.boxtype == "deployable_specialammo_comb" && self._ID34651 == 4 )
        return 0;

    if ( maps\mp\alien\_unk1464::_ID18745() && ( !isdefined( self.air_dropped ) || !self.air_dropped ) )
        return 1;

    return 0;
}

_ID5877()
{
    playfx( common_scripts\utility::_ID15033( "deployablebox_crate_destroy" ), self.origin );
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
    if ( isplayer( var_0 ) )
        var_0 playerlinkto( self );
    else
        var_0 linkto( self );

    var_0 playerlinkedoffsetenable();
    var_0._ID5893 = spawnstruct();
    var_0._ID5893.curprogress = 0;
    var_0._ID5893._ID18318 = 1;
    var_0._ID5893._ID34766 = 0;

    if ( isdefined( var_1 ) )
        var_0._ID5893._ID34780 = var_1;
    else
        var_0._ID5893._ID34780 = 3000;

    var_0 maps\mp\alien\_unk1464::_ID37114( var_1 + 0.05, "deployable_weapon_management" );

    if ( isplayer( var_0 ) )
        var_0 thread _ID23480( self );

    var_2 = useholdthinkloop( var_0 );

    if ( isalive( var_0 ) )
    {
        var_0 maps\mp\alien\_unk1464::_ID37161( "deployable_weapon_management" );
        var_0 unlink();
    }

    if ( !isdefined( self ) )
        return 0;

    var_0._ID5893._ID18318 = 0;
    var_0._ID5893.curprogress = 0;
    return var_2;
}

_ID23480( var_0 )
{
    self endon( "disconnect" );
    var_1 = maps\mp\gametypes\_hud_util::createprimaryprogressbar( 0, 25 );
    var_2 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext( 0, 25 );
    var_2 settext( level.boxsettings[var_0.boxtype].capturingstring );
    var_3 = -1;

    while ( maps\mp\_utility::_ID18757( self ) && isdefined( var_0 ) && self._ID5893._ID18318 && var_0._ID18835 && !level.gameended )
    {
        if ( var_3 != self._ID5893._ID34766 )
        {
            if ( self._ID5893.curprogress > self._ID5893._ID34780 )
                self._ID5893.curprogress = self._ID5893._ID34780;

            var_1 maps\mp\gametypes\_hud_util::_ID34509( self._ID5893.curprogress / self._ID5893._ID34780, 1000 / self._ID5893._ID34780 * self._ID5893._ID34766 );

            if ( !self._ID5893._ID34766 )
            {
                var_1 maps\mp\gametypes\_hud_util::_ID16899();
                var_2 maps\mp\gametypes\_hud_util::_ID16899();
            }
            else
            {
                var_1 maps\mp\gametypes\_hud_util::_ID29966();
                var_2 maps\mp\gametypes\_hud_util::_ID29966();
            }
        }

        var_3 = self._ID5893._ID34766;
        wait 0.05;
    }

    var_1 maps\mp\gametypes\_hud_util::destroyelem();
    var_2 maps\mp\gametypes\_hud_util::destroyelem();
}

useholdthinkloop( var_0 )
{
    while ( !level.gameended && isdefined( self ) && maps\mp\_utility::_ID18757( var_0 ) && var_0 usebuttonpressed() && var_0._ID5893.curprogress < var_0._ID5893._ID34780 )
    {
        var_0._ID5893.curprogress = var_0._ID5893.curprogress + 50 * var_0._ID5893._ID34766;

        if ( isdefined( var_0.objectivescaler ) )
            var_0._ID5893._ID34766 = 1 * var_0.objectivescaler;
        else
            var_0._ID5893._ID34766 = 1;

        if ( var_0._ID5893.curprogress >= var_0._ID5893._ID34780 )
            return maps\mp\_utility::_ID18757( var_0 );

        wait 0.05;
    }

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

_ID37078( var_0 )
{
    if ( ( isdefined( var_0 ) && var_0.owner == self || maps\mp\alien\_prestige::prestige_getnodeployables() == 1.0 ) && !isdefined( var_0.air_dropped ) )
        return 0;

    return 1;
}

_ID37082( var_0 )
{
    thread maps\mp\alien\_persistence::_ID9658( var_0 );
    maps\mp\alien\_unk1464::deployable_box_onuse_message( var_0 );
}

_ID37087( var_0, var_1 )
{
    var_2 = maps\mp\alien\_combat_resources::alien_begindeployableviamarker( var_0, var_1 );

    if ( !isdefined( var_2 ) || !var_2 )
        return 0;

    return 1;
}

_ID37461( var_0, var_1 )
{
    if ( !isdefined( level.boxsettings ) )
        level.boxsettings = [];

    level.boxsettings[var_0] = var_1;

    if ( !isdefined( level._ID19256 ) )
        level._ID19256 = [];

    level._ID9646[var_0] = [];
}
