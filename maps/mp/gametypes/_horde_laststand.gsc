// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID6478( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    _ID25709( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );

    if ( _ID14077( self ) )
    {
        self._ID34755 = 1;
        maps\mp\_utility::_suicide();
        hordeendgame();
        return;
    }

    if ( !_ID20770( self ) )
    {
        self._ID34755 = 1;
        maps\mp\_utility::_suicide();
        return;
    }

    self._ID18011 = 1;
    self.laststand = 1;
    self.ignoreme = 1;
    self.health = 1;
    self hudoutlineenable( 1, 0 );
    common_scripts\utility::_disableusability();
    thread _ID19634();
}

_ID14077( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in level._ID23303 )
    {
        if ( var_0 == var_3 && !maps\mp\gametypes\_horde_util::_ID16377( var_0 ) )
            continue;

        if ( !maps\mp\gametypes\_horde_util::isonhumanteam( var_3 ) )
            continue;

        if ( maps\mp\gametypes\_horde_util::_ID18740( var_3 ) && !maps\mp\gametypes\_horde_util::_ID16377( var_3 ) )
            continue;

        if ( !isdefined( var_3.sessionstate ) || var_3.sessionstate != "playing" )
            continue;

        var_1 = 1;
        break;
    }

    return !var_1;
}

hordeendgame()
{
    level.finalkillcam_winner = level.enemyteam;
    level thread maps\mp\gametypes\_gamelogic::endgame( level.enemyteam, game["end_reason"][level._ID24549 + "_eliminated"] );
}

_ID20770( var_0 )
{
    if ( var_0 maps\mp\_utility::_ID33165() )
        return 0;

    return 1;
}

_ID25709( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = spawnstruct();
    var_7.einflictor = var_0;
    var_7.attacker = var_1;
    var_7._ID17335 = var_2;
    var_7.attackerposition = var_1.origin;
    var_7._ID30258 = var_3;
    var_7._ID32157 = var_4;
    var_7._ID34931 = var_5;
    var_7._ID29709 = var_6;
    var_7._ID19635 = gettime();

    if ( isdefined( var_1 ) && isplayer( var_1 ) && var_1 getcurrentprimaryweapon() != "none" )
        var_7._ID31095 = var_1 getcurrentprimaryweapon();
    else
        var_7._ID31095 = undefined;

    self._ID19631 = var_7;
}

_ID19634()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );
    level notify( "player_last_stand" );
    self notify( "force_cancel_placement" );
    level thread maps\mp\gametypes\_horde_util::_ID24647( "mp_safe_team_last_stand" );
    level thread maps\mp\_utility::_ID19760( "ally_down", level._ID24549, "status" );
    level thread _ID23450( self );
    thread laststandwaittilldeathhorde();
    thread _ID19626();
    thread _ID19630();
    var_0 = spawn( "script_model", self.origin );
    var_0 setmodel( "tag_origin" );
    var_0 setcursorhint( "HINT_NOICON" );
    var_0 sethintstring( &"PLATFORM_REVIVE" );
    var_0 makeusable();
    var_0._ID18318 = 0;
    var_0.curprogress = 0;
    var_0._ID34780 = level.laststandusetime;
    var_0._ID34766 = 1;
    var_0._ID17334 = "last_stand";
    var_0.targetname = "revive_trigger";
    var_0.owner = self;
    var_0 linkto( self, "tag_origin", ( 0, 0, 20 ), ( 0, 0, 0 ) );
    var_0 thread maps\mp\gametypes\_damage::deleteonreviveordeathordisconnect();
    var_1 = newteamhudelem( self.team );
    var_1 setshader( "waypoint_revive", 8, 8 );
    var_1 setwaypoint( 1, 1 );
    var_1 settargetent( self );
    var_1.color = ( 0.33, 0.75, 0.24 );
    var_1 thread maps\mp\gametypes\_damage::_ID9816( var_0 );
    thread _ID19639( var_0, var_1, 25 );
    thread _ID19637( 25, var_0 );
    var_0 thread _ID26267();
    var_0 thread _ID19644();
    var_0 endon( "death" );
    wait 25;

    while ( isdefined( var_0._ID18318 ) && var_0._ID18318 )
        common_scripts\utility::_ID35582();

    level thread maps\mp\_utility::_ID19760( "ally_dead", level._ID24549, "status" );
    self hudoutlinedisable();
    maps\mp\_utility::_suicide();
}

_ID26267()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self makeusable();
        self waittill( "trigger",  var_0  );
        self makeunusable();
        self.curprogress = 0;
        self._ID18318 = 1;
        self.owner.beingrevived = 1;
        var_0 freezecontrols( 1 );
        var_0 common_scripts\utility::_disableweapon();
        var_0._ID18764 = 1;
        var_1 = maps\mp\gametypes\_damage::useholdthinkloop( var_0 );
        self._ID18318 = 0;

        if ( isdefined( self.owner ) )
            self.owner.beingrevived = 0;

        if ( isdefined( var_0 ) && maps\mp\_utility::_ID18757( var_0 ) )
        {
            var_0 freezecontrols( 0 );
            var_0 common_scripts\utility::_enableweapon();
            var_0._ID18764 = 0;

            if ( isdefined( var_1 ) && var_1 )
            {
                var_0 thread maps\mp\gametypes\_hud_message::_ID31053( "horde_reviver" );
                var_0 thread maps\mp\perks\_perkfunctions::_ID28771( 850 );

                if ( isplayer( var_0 ) )
                    maps\mp\gametypes\_horde_util::_ID36756( var_0 );
                else if ( isdefined( var_0.owner ) && isplayer( var_0.owner ) && var_0.owner != self.owner )
                    maps\mp\gametypes\_horde_util::_ID36756( var_0.owner );
            }

            if ( !isdefined( var_1 ) )
                var_0 maps\mp\gametypes\_gameobjects::_ID34638( self, 0 );
        }

        if ( isdefined( var_1 ) && var_1 )
        {
            self.owner notify( "revive_trigger",  var_0  );
            break;
        }
    }
}

_ID19644()
{
    self endon( "death" );
    self endon( "game_ended" );
    var_0 = self.owner;
    var_0 waittill( "revive_trigger",  var_1  );

    if ( isdefined( var_1 ) && isplayer( var_1 ) && var_1 != var_0 )
        var_0 thread maps\mp\gametypes\_hud_message::_ID24474( "revived", var_1 );

    var_0 _ID19633( self );
}

_ID19633( var_0 )
{
    self notify( "revive" );
    self.laststand = undefined;
    self._ID18011 = 0;
    self.headicon = "";
    self.health = self.maxhealth;
    self._ID21667 = 1;
    self.ignoreme = 0;
    self.beingrevived = 0;

    if ( maps\mp\_utility::_hasperk( "specialty_lightweight" ) )
        self._ID21667 = maps\mp\_utility::_ID19986();

    self hudoutlinedisable();
    self laststandrevive();
    self setstance( "crouch" );
    common_scripts\utility::_enableusability();
    maps\mp\gametypes\_weapons::_ID34567();
    maps\mp\_utility::_ID7495( "last_stand" );
    maps\mp\_utility::_ID15611( "specialty_pistoldeath", 0 );

    if ( !canspawn( self.origin ) )
        maps\mp\_movers::_ID34251( self, 0 );

    var_0 delete();
}

laststandwaittilldeathhorde()
{
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );
    self waittill( "death" );
    self.laststand = undefined;
    self._ID18011 = 0;
    self.ignoreme = 0;
}

_ID19630()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );

    for (;;)
    {
        self.health = 2;
        common_scripts\utility::_ID35582();
        self.health = 1;
        common_scripts\utility::_ID35582();
    }
}

_ID19639( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    maps\mp\_utility::_ID23899();
    wait(var_2 / 3);
    var_1.color = ( 1, 0.64, 0 );

    while ( var_0._ID18318 )
        wait 0.05;

    maps\mp\_utility::_ID23899();
    wait(var_2 / 3);
    var_1.color = ( 1, 0, 0 );

    while ( var_0._ID18318 )
        wait 0.05;

    maps\mp\_utility::_ID23899();
}

_ID19637( var_0, var_1 )
{
    self endon( "disconnect" );
    var_2 = 90;

    if ( !issplitscreen() )
        var_2 = 135;

    var_3 = maps\mp\gametypes\_hud_util::createtimer( "hudsmall", 1.0 );
    var_3 maps\mp\gametypes\_hud_util::_ID28836( "CENTER", undefined, 0, var_2 );
    var_3.label = &"MP_HORDE_BLEED_OUT";
    var_3.color = ( 0.804, 0.804, 0.035 );
    var_3.archived = 0;
    var_3.showinkillcam = 0;
    var_3 settimer( var_0 - 1 );
    var_1 waittill( "death" );

    if ( !isdefined( var_3 ) )
        return;

    var_3 notify( "destroying" );
    var_3 maps\mp\gametypes\_hud_util::destroyelem();
}

_ID19626()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 1.5;
        var_0 = self getcurrentprimaryweapon();

        if ( !maps\mp\gametypes\_weapons::isprimaryweapon( var_0 ) )
            continue;

        var_1 = self getweaponammostock( var_0 );
        var_2 = weaponclipsize( var_0 );

        if ( var_1 < var_2 )
            self setweaponammostock( var_0, var_2 );
    }
}

_ID23450( var_0 )
{
    var_0 endon( "disconnect" );
    level endon( "game_ended" );

    if ( !isplayer( var_0 ) )
        return;

    while ( maps\mp\gametypes\_horde_util::_ID18740( var_0 ) && var_0._ID17063.size > 0 )
    {
        var_1 = var_0._ID17063[var_0._ID17063.size - 1]["name"];
        var_2 = var_0._ID17063[var_0._ID17063.size - 1]["index"];
        var_0 thread _ID13328( var_2 );
        var_3 = var_0 common_scripts\utility::waittill_any_return_no_endon_death( "remove_perk", "death", "revive" );

        if ( var_3 == "death" )
            return;

        if ( var_3 == "revive" )
        {
            if ( isdefined( var_0._ID37221 ) )
            {
                if ( var_0._ID37221 == var_2 )
                {
                    var_0 setclientomnvar( "ui_horde_update_perk", var_2 );
                    var_0._ID37221 = undefined;
                }
            }

            return;
        }

        if ( var_3 == "remove_perk" )
        {
            var_0 setclientomnvar( "ui_horde_update_perk", var_2 * -1 );
            var_0 maps\mp\_utility::_unsetperk( var_1 );
            var_0._ID17063 = array_remove_perk( var_0._ID17063, var_1 );
        }
    }
}

array_remove_perk( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        if ( var_4["name"] != var_1 )
            var_2[var_2.size] = var_4;
    }

    return var_2;
}

_ID13328( var_0 )
{
    self endon( "death" );
    self endon( "revive" );
    wait 0.5;
    self setclientomnvar( "ui_horde_update_perk", var_0 );
    self._ID37221 = var_0;
    wait 8;
    self notify( "remove_perk" );
}
