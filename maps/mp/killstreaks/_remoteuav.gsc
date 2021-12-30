// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID25841["hit"] = loadfx( "fx/impacts/large_metal_painted_hit" );
    level._ID25841["smoke"] = loadfx( "fx/smoke/remote_heli_damage_smoke_runner" );
    level._ID25841["explode"] = loadfx( "fx/explosions/bouncing_betty_explosion" );
    level._ID25841["missile_explode"] = loadfx( "fx/explosions/stinger_explosion" );
    level._ID25834["launch"][0] = "ac130_plt_yeahcleared";
    level._ID25834["launch"][1] = "ac130_plt_rollinin";
    level._ID25834["launch"][2] = "ac130_plt_scanrange";
    level._ID25834["out_of_range"][0] = "ac130_plt_cleanup";
    level._ID25834["out_of_range"][1] = "ac130_plt_targetreset";
    level._ID25834["track"][0] = "ac130_fco_moreenemy";
    level._ID25834["track"][1] = "ac130_fco_getthatguy";
    level._ID25834["track"][2] = "ac130_fco_guymovin";
    level._ID25834["track"][3] = "ac130_fco_getperson";
    level._ID25834["track"][4] = "ac130_fco_guyrunnin";
    level._ID25834["track"][5] = "ac130_fco_gotarunner";
    level._ID25834["track"][6] = "ac130_fco_backonthose";
    level._ID25834["track"][7] = "ac130_fco_gonnagethim";
    level._ID25834["track"][8] = "ac130_fco_personnelthere";
    level._ID25834["track"][9] = "ac130_fco_rightthere";
    level._ID25834["track"][10] = "ac130_fco_tracking";
    level._ID25834["tag"][0] = "ac130_fco_nice";
    level._ID25834["tag"][1] = "ac130_fco_yougothim";
    level._ID25834["tag"][2] = "ac130_fco_yougothim2";
    level._ID25834["tag"][3] = "ac130_fco_okyougothim";
    level._ID25834["assist"][0] = "ac130_fco_goodkill";
    level._ID25834["assist"][1] = "ac130_fco_thatsahit";
    level._ID25834["assist"][2] = "ac130_fco_directhit";
    level._ID25834["assist"][3] = "ac130_fco_rightontarget";
    level._ID25846 = 0;
    level._ID25851 = getentarray( "no_vehicles", "targetname" );
    level._ID19256["remote_uav"] = ::_ID34768;
    level._ID25810 = [];
}

_ID34768( var_0, var_1 )
{
    return _ID33872( var_0, "remote_uav" );
}

_ID12354( var_0 )
{
    if ( level._ID14086 == "dm" )
    {
        if ( isdefined( level._ID25810[var_0] ) || isdefined( level._ID25810[level._ID23070[var_0]] ) )
            return 1;
        else
            return 0;
    }
    else if ( isdefined( level._ID25810[var_0] ) )
        return 1;
    else
        return 0;
}

_ID33872( var_0, var_1 )
{
    common_scripts\utility::_disableusability();

    if ( maps\mp\_utility::_ID18837() || self isusingturret() || isdefined( level._ID22370 ) )
    {
        common_scripts\utility::_enableusability();
        return 0;
    }

    var_2 = 1;

    if ( _ID12354( self.team ) || level._ID20086.size >= 4 )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        common_scripts\utility::_enableusability();
        return 0;
    }
    else if ( maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 + var_2 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        common_scripts\utility::_enableusability();
        return 0;
    }

    self setplayerdata( "reconDroneState", "staticAlpha", 0 );
    self setplayerdata( "reconDroneState", "incomingMissile", 0 );
    maps\mp\_utility::_ID17543();
    var_3 = givecarryremoteuav( var_0, var_1 );

    if ( var_3 )
    {
        maps\mp\_matchdata::_ID20253( var_1, self.origin );
        thread maps\mp\_utility::_ID32672( "used_remote_uav", self );
    }
    else
        maps\mp\_utility::decrementfauxvehiclecount();

    self._ID18582 = 0;
    return var_3;
}

givecarryremoteuav( var_0, var_1 )
{
    var_2 = createcarryremoteuav( var_1, self );
    self takeweapon( "killstreak_uav_mp" );
    maps\mp\_utility::_giveweapon( "killstreak_remote_uav_mp" );
    self switchtoweaponimmediate( "killstreak_remote_uav_mp" );
    _ID28667( var_2 );

    if ( isalive( self ) && isdefined( var_2 ) )
    {
        var_3 = var_2.origin;
        var_4 = self.angles;
        var_2._ID30494 delete();
        var_2 delete();
        var_5 = _ID31472( var_0, var_1, var_3, var_4 );
    }
    else
    {
        var_5 = 0;

        if ( isalive( self ) )
        {
            self takeweapon( "killstreak_remote_uav_mp" );
            maps\mp\_utility::_giveweapon( "killstreak_uav_mp" );
        }
    }

    return var_5;
}

createcarryremoteuav( var_0, var_1 )
{
    var_2 = var_1.origin + anglestoforward( var_1.angles ) * 4 + anglestoup( var_1.angles ) * 50;
    var_3 = spawnturret( "misc_turret", var_2, "sentry_minigun_mp" );
    var_3.origin = var_2;
    var_3.angles = var_1.angles;
    var_3._ID28174 = "sentry_minigun";
    var_3.canbeplaced = 1;
    var_3 setturretmodechangewait( 1 );
    var_3 setmode( "sentry_offline" );
    var_3 makeunusable();
    var_3 maketurretinoperable();
    var_3.owner = var_1;
    var_3 setsentryowner( var_3.owner );
    var_3.scale = 3;
    var_3._ID17629 = 0;
    var_3 thread _ID6752();
    var_3._ID25415 = getent( "remote_uav_range", "targetname" );

    if ( !isdefined( var_3._ID25415 ) )
    {
        var_4 = getent( "airstrikeheight", "targetname" );
        var_3._ID20741 = var_4.origin[2];
        var_3.maxdistance = 3600;
    }

    var_3._ID30494 = spawn( "script_origin", var_3.origin );
    var_3._ID30494.angles = var_3.angles;
    var_3._ID30494.origin = var_3.origin;
    var_3._ID30494 linkto( var_3 );
    var_3._ID30494 playloopsound( "recondrone_idle_high" );
    return var_3;
}

_ID28667( var_0 )
{
    var_0 thread carryremoteuav_setcarried( self );
    self notifyonplayercommand( "place_carryRemoteUAV", "+attack" );
    self notifyonplayercommand( "place_carryRemoteUAV", "+attack_akimbo_accessible" );
    self notifyonplayercommand( "cancel_carryRemoteUAV", "+actionslot 4" );

    if ( !level.console )
    {
        self notifyonplayercommand( "cancel_carryRemoteUAV", "+actionslot 5" );
        self notifyonplayercommand( "cancel_carryRemoteUAV", "+actionslot 6" );
        self notifyonplayercommand( "cancel_carryRemoteUAV", "+actionslot 7" );
    }

    for (;;)
    {
        var_1 = _ID20152( "place_carryRemoteUAV", "cancel_carryRemoteUAV", "weapon_switch_started", "force_cancel_placement", "death", "disconnect" );
        self forceusehintoff();

        if ( var_1 != "place_carryRemoteUAV" )
        {
            carryremoteuav_delete( var_0 );
            break;
        }

        if ( !var_0.canbeplaced )
        {
            if ( self.team != "spectator" )
                self forceusehinton( &"KILLSTREAKS_REMOTE_UAV_CANNOT_PLACE" );

            continue;
        }

        if ( isdefined( level._ID22370 ) || maps\mp\_utility::_ID18610() || _ID12354( self.team ) || maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 >= maps\mp\_utility::maxvehiclesallowed() )
        {
            if ( isdefined( level._ID22370 ) || maps\mp\_utility::_ID18610() )
                self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE_FOR_N_WHEN_EMP", level.emptimeremaining );
            else
                self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );

            carryremoteuav_delete( var_0 );
            break;
        }

        self._ID18582 = 0;
        var_0.carriedby = undefined;
        var_0 playsound( "sentry_gun_plant" );
        var_0 notify( "placed" );
        break;
    }
}

_ID20152( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( ( !isdefined( var_0 ) || var_0 != "death" ) && ( !isdefined( var_1 ) || var_1 != "death" ) && ( !isdefined( var_2 ) || var_2 != "death" ) && ( !isdefined( var_3 ) || var_3 != "death" ) && ( !isdefined( var_4 ) || var_4 != "death" ) )
        self endon( "death" );

    var_6 = spawnstruct();

    if ( isdefined( var_0 ) )
        thread common_scripts\utility::_ID35742( var_0, var_6 );

    if ( isdefined( var_1 ) )
        thread common_scripts\utility::_ID35742( var_1, var_6 );

    if ( isdefined( var_2 ) )
        thread common_scripts\utility::_ID35742( var_2, var_6 );

    if ( isdefined( var_3 ) )
        thread common_scripts\utility::_ID35742( var_3, var_6 );

    if ( isdefined( var_4 ) )
        thread common_scripts\utility::_ID35742( var_4, var_6 );

    if ( isdefined( var_5 ) )
        thread common_scripts\utility::_ID35742( var_5, var_6 );

    var_6 waittill( "returned",  var_7  );
    var_6 notify( "die" );
    return var_7;
}

carryremoteuav_setcarried( var_0 )
{
    self setcandamage( 0 );
    self setsentrycarrier( var_0 );
    self setcontents( 0 );
    self.carriedby = var_0;
    var_0._ID18582 = 1;
    var_0 thread _ID34515( self );
    self notify( "carried" );
}

carryremoteuav_delete( var_0 )
{
    self._ID18582 = 0;

    if ( isdefined( var_0 ) )
    {
        if ( isdefined( var_0._ID30494 ) )
            var_0._ID30494 delete();

        var_0 delete();
    }
}

_ID18660()
{
    if ( isdefined( level._ID25851 ) && level._ID25851.size )
    {
        foreach ( var_1 in level._ID25851 )
        {
            if ( self istouching( var_1 ) )
                return 1;
        }
    }

    return 0;
}

_ID34515( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "placed" );
    var_0 endon( "death" );
    var_0.canbeplaced = 1;
    var_1 = -1;
    common_scripts\utility::_enableusability();

    for (;;)
    {
        var_2 = 18;

        switch ( self getstance() )
        {
            case "stand":
                var_2 = 40;
                break;
            case "crouch":
                var_2 = 25;
                break;
            case "prone":
                var_2 = 10;
                break;
        }

        var_3 = self canplayerplacetank( 22, 22, 50, var_2, 0, 0 );
        var_0.origin = var_3["origin"] + anglestoup( self.angles ) * 27;
        var_0.angles = var_3["angles"];
        var_0.canbeplaced = self isonground() && var_3["result"] && var_0 _ID25845() && !var_0 _ID18660();

        if ( var_0.canbeplaced != var_1 )
        {
            if ( var_0.canbeplaced )
            {
                if ( self.team != "spectator" )
                    self forceusehinton( &"KILLSTREAKS_REMOTE_UAV_PLACE" );

                if ( self attackbuttonpressed() )
                    self notify( "place_carryRemoteUAV" );
            }
            else if ( self.team != "spectator" )
                self forceusehinton( &"KILLSTREAKS_REMOTE_UAV_CANNOT_PLACE" );
        }

        var_1 = var_0.canbeplaced;
        wait 0.05;
    }
}

_ID6752()
{
    level endon( "game_ended" );
    self.owner endon( "place_carryRemoteUAV" );
    self.owner endon( "cancel_carryRemoteUAV" );
    self.owner common_scripts\utility::_ID35626( "death", "disconnect", "joined_team", "joined_spectators" );

    if ( isdefined( self ) )
    {
        if ( isdefined( self._ID30494 ) )
            self._ID30494 delete();

        self delete();
    }
}

_ID26028()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    wait 0.7;
}

_ID31472( var_0, var_1, var_2, var_3 )
{
    _ID20199();
    maps\mp\_utility::_ID29199( var_1 );
    maps\mp\_utility::_giveweapon( "uav_remote_mp" );
    self switchtoweaponimmediate( "uav_remote_mp" );
    self visionsetnakedforplayer( "black_bw", 0.0 );
    var_4 = maps\mp\killstreaks\_killstreaks::_ID17993( "remote_uav" );

    if ( var_4 != "success" )
    {
        if ( var_4 != "disconnect" )
        {
            self notify( "remoteuav_unlock" );
            self takeweapon( "uav_remote_mp" );
            maps\mp\_utility::_ID7513();
        }

        return 0;
    }

    if ( _ID12354( self.team ) || maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        self notify( "remoteuav_unlock" );
        self takeweapon( "uav_remote_mp" );
        maps\mp\_utility::_ID7513();
        return 0;
    }

    self notify( "remoteuav_unlock" );
    var_5 = createremoteuav( var_0, self, var_1, var_2, var_3 );

    if ( isdefined( var_5 ) )
    {
        thread _ID25856( var_0, var_5, var_1 );
        return 1;
    }
    else
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        self takeweapon( "uav_remote_mp" );
        maps\mp\_utility::_ID7513();
        return 0;
    }
}

_ID20199()
{
    var_0 = spawn( "script_origin", self.origin );
    var_0 hide();
    self playerlinkto( var_0 );
    thread clearplayerlockfromremoteuavlaunch( var_0 );
}

clearplayerlockfromremoteuavlaunch( var_0 )
{
    level endon( "game_ended" );
    var_1 = common_scripts\utility::_ID35635( "disconnect", "death", "remoteuav_unlock" );

    if ( var_1 != "disconnect" )
        self unlink();

    var_0 delete();
}

createremoteuav( var_0, var_1, var_2, var_3, var_4 )
{
    if ( level.console )
        var_5 = spawnhelicopter( var_1, var_3, var_4, "remote_uav_mp", "vehicle_remote_uav" );
    else
        var_5 = spawnhelicopter( var_1, var_3, var_4, "remote_uav_mp_pc", "vehicle_remote_uav" );

    if ( !isdefined( var_5 ) )
        return undefined;

    var_5 maps\mp\killstreaks\_helicopter::addtolittlebirdlist();
    var_5 thread maps\mp\killstreaks\_helicopter::_ID26000();
    var_5 makevehiclesolidcapsule( 18, -9, 18 );
    var_5._ID19938 = var_0;
    var_5.team = var_1.team;
    var_5.pers["team"] = var_1.team;
    var_5.owner = var_1;
    var_5 setotherent( var_1 );
    var_5 common_scripts\utility::_ID20489( var_1.team );
    var_5.maxhealth = 250;
    var_5._ID27391 = spawn( "script_model", var_3 );
    var_5._ID27391 linkto( var_5, "tag_origin", ( 0, 0, -160 ), ( 0, 0, 0 ) );
    var_5._ID27391 makescrambler( var_1 );
    var_5._ID30272 = 0;
    var_5._ID17629 = 0;
    var_5._ID16760 = "remote_uav";
    var_5._ID20645 = [];
    var_5 thread _ID25849();
    var_5 thread remoteuav_explode_on_disconnect();
    var_5 thread _ID25836();
    var_5 thread _ID25837();
    var_5 thread _ID25829();
    var_5 thread _ID25848();
    var_5 thread _ID25862();
    var_5 thread _ID25863();
    var_5 thread _ID25842();
    var_5._ID22406 = 2;
    var_5._ID16404 = 0;
    var_5._ID17527 = [];
    var_5 thread _ID25830();
    var_5 thread _ID25844();
    var_5 thread _ID25843();
    level._ID25810[var_5.team] = var_5;
    return var_5;
}

_ID25856( var_0, var_1, var_2 )
{
    var_1._ID24519 = 1;
    self._ID26200 = self.angles;

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::_ID28902( 0 );

    self cameralinkto( var_1, "tag_origin" );
    self remotecontrolvehicle( var_1 );
    thread _ID25853( var_1 );
    thread _ID25859( var_1 );
    thread _ID25839( var_1 );
    self._ID25811 = var_0;
    self._ID25826 = var_1;
    thread _ID25833( var_1 );
    self visionsetnakedforplayer( "black_bw", 0.0 );
    maps\mp\_utility::_ID26201( 1 );
}

_ID25833( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );
    var_0 endon( "end_launch_dialog" );
    wait 3;
    _ID25834( "launch" );
}

_ID25835( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        var_0._ID24519 = 0;
        var_0 notify( "end_remote" );
        maps\mp\_utility::_ID7513();

        if ( getdvarint( "camera_thirdPerson" ) )
            maps\mp\_utility::_ID28902( 1 );

        self cameraunlink( var_0 );
        self remotecontrolvehicleoff( var_0 );
        self thermalvisionoff();
        self setplayerangles( self._ID26200 );
        var_1 = common_scripts\utility::_ID15114();

        if ( !self hasweapon( var_1 ) )
            var_1 = maps\mp\killstreaks\_killstreaks::_ID15018();

        self switchtoweapon( var_1 );
        self takeweapon( "uav_remote_mp" );
        thread _ID25840();
    }

    self._ID25826 = undefined;
}

_ID25840()
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    maps\mp\_utility::_ID13582( 1 );
    wait 0.5;
    maps\mp\_utility::_ID13582( 0 );
}

_ID25853( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );
    wait 2;

    for (;;)
    {
        var_1 = 0;

        while ( self usebuttonpressed() )
        {
            var_1 += 0.05;

            if ( var_1 > 0.75 )
            {
                var_0 thread remoteuav_leave();
                return;
            }

            wait 0.05;
        }

        wait 0.05;
    }
}

_ID25859( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "end_remote" );
    var_0._ID19659 = 0;
    self.lockedtarget = undefined;
    self weaponlockfree();
    wait 1;

    for (;;)
    {
        var_1 = var_0 gettagorigin( "tag_turret" );
        var_2 = anglestoforward( self getplayerangles() );
        var_3 = var_1 + var_2 * 1024;
        var_4 = bullettrace( var_1, var_3, 1, var_0 );

        if ( isdefined( var_4["position"] ) )
            var_5 = var_4["position"];
        else
        {
            var_5 = var_3;
            var_4["endpos"] = var_3;
        }

        var_0._ID33241 = var_4;
        var_6 = _ID25860( var_0, level.players, var_5 );
        var_7 = _ID25860( var_0, level._ID34099, var_5 );
        var_8 = undefined;

        if ( level.multiteambased )
        {
            var_9 = [];

            foreach ( var_11 in level._ID32668 )
            {
                if ( var_11 != self.team )
                {
                    foreach ( var_13 in level._ID34165[var_11] )
                        var_9[var_9.size] = var_13;
                }
            }

            var_8 = _ID25860( var_0, var_9, var_5 );
        }
        else if ( level._ID32653 )
            var_8 = _ID25860( var_0, level._ID34165[level._ID23070[self.team]], var_5 );
        else
            var_8 = _ID25860( var_0, level._ID34165, var_5 );

        var_16 = undefined;

        if ( isdefined( var_6 ) )
            var_16 = var_6;
        else if ( isdefined( var_7 ) )
            var_16 = var_7;
        else if ( isdefined( var_8 ) )
            var_16 = var_8;

        if ( isdefined( var_16 ) )
        {
            if ( !isdefined( self.lockedtarget ) || isdefined( self.lockedtarget ) && self.lockedtarget != var_16 )
            {
                self weaponlockfinalize( var_16 );
                self.lockedtarget = var_16;

                if ( isdefined( var_6 ) )
                {
                    var_0 notify( "end_launch_dialog" );
                    _ID25834( "track" );
                }
            }
        }
        else
        {
            self weaponlockfree();
            self.lockedtarget = undefined;
        }

        wait 0.05;
    }
}

_ID25860( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    var_3 = undefined;

    foreach ( var_5 in var_1 )
    {
        if ( level._ID32653 && ( !isdefined( var_5.team ) || var_5.team == self.team ) )
            continue;

        if ( isplayer( var_5 ) )
        {
            if ( !maps\mp\_utility::_ID18757( var_5 ) )
                continue;

            if ( var_5 == self )
                continue;

            var_6 = var_5._ID15851;
        }
        else
            var_6 = var_5.birthtime;

        if ( isdefined( var_5._ID28174 ) || isdefined( var_5._ID34107 ) )
        {
            var_7 = ( 0, 0, 32 );
            var_8 = "hud_fofbox_hostile_vehicle";
        }
        else if ( isdefined( var_5._ID34170 ) )
        {
            var_7 = ( 0, 0, -52 );
            var_8 = "hud_fofbox_hostile_vehicle";
        }
        else
        {
            var_7 = ( 0, 0, 26 );
            var_8 = "veh_hud_target_unmarked";
        }

        if ( isdefined( var_5._ID34166 ) )
        {
            if ( !isdefined( var_0._ID20645[var_6] ) )
            {
                var_0._ID20645[var_6] = [];
                var_0._ID20645[var_6]["player"] = var_5;
                var_0._ID20645[var_6]["icon"] = var_5 maps\mp\_entityheadicons::setheadicon( self, "veh_hud_target_marked", var_7, 10, 10, 0, 0.05, 0, 0, 0, 0 );
                var_0._ID20645[var_6]["icon"]._ID29625 = "veh_hud_target_marked";

                if ( !isdefined( var_5._ID28174 ) || !isdefined( var_5._ID34107 ) )
                    var_0._ID20645[var_6]["icon"] settargetent( var_5 );
            }
            else if ( isdefined( var_0._ID20645[var_6] ) && isdefined( var_0._ID20645[var_6]["icon"] ) && isdefined( var_0._ID20645[var_6]["icon"]._ID29625 ) && var_0._ID20645[var_6]["icon"]._ID29625 != "veh_hud_target_marked" )
            {
                var_0._ID20645[var_6]["icon"]._ID29625 = "veh_hud_target_marked";
                var_0._ID20645[var_6]["icon"] setshader( "veh_hud_target_marked", 10, 10 );
                var_0._ID20645[var_6]["icon"] setwaypoint( 0, 0, 0, 0 );
            }

            continue;
        }

        if ( isplayer( var_5 ) )
        {
            var_9 = isdefined( var_5._ID30916 ) && ( gettime() - var_5._ID30916 ) / 1000 <= 5;
            var_10 = var_5 maps\mp\_utility::_hasperk( "specialty_blindeye" );
            var_11 = 0;
            var_12 = 0;
        }
        else
        {
            var_9 = 0;
            var_10 = 0;
            var_11 = isdefined( var_5.carriedby );
            var_12 = isdefined( var_5._ID18690 ) && var_5._ID18690 == 1;
        }

        if ( !isdefined( var_0._ID20645[var_6] ) && !var_9 && !var_10 && !var_11 && !var_12 )
        {
            var_0._ID20645[var_6] = [];
            var_0._ID20645[var_6]["player"] = var_5;
            var_0._ID20645[var_6]["icon"] = var_5 maps\mp\_entityheadicons::setheadicon( self, var_8, var_7, 10, 10, 0, 0.05, 0, 0, 0, 0 );
            var_0._ID20645[var_6]["icon"]._ID29625 = var_8;

            if ( !isdefined( var_5._ID28174 ) || !isdefined( var_5._ID34107 ) )
                var_0._ID20645[var_6]["icon"] settargetent( var_5 );
        }

        if ( ( !isdefined( var_3 ) || var_3 != var_5 ) && ( isdefined( var_0._ID33241["entity"] ) && var_0._ID33241["entity"] == var_5 && !var_11 && !var_12 ) || distance( var_5.origin, var_2 ) < 200 * var_0._ID33241["fraction"] && !var_9 && !var_11 && !var_12 || !var_12 && _ID25827( var_0, var_5 ) )
        {
            var_13 = bullettrace( var_0.origin, var_5.origin + ( 0, 0, 32 ), 1, var_0 );

            if ( isdefined( var_13["entity"] ) && var_13["entity"] == var_5 || var_13["fraction"] == 1 )
            {
                self playlocalsound( "recondrone_lockon" );
                var_3 = var_5;
            }
        }
    }

    return var_3;
}

_ID25827( var_0, var_1 )
{
    if ( isdefined( var_1._ID34170 ) )
    {
        var_2 = anglestoforward( self getplayerangles() );
        var_3 = vectornormalize( var_1.origin - var_0 gettagorigin( "tag_turret" ) );
        var_4 = vectordot( var_2, var_3 );

        if ( var_4 > 0.985 )
            return 1;
    }

    return 0;
}

_ID25839( var_0 )
{
    self endon( "disconnect" );
    var_0 endon( "death" );
    level endon( "game_ended" );
    var_0 endon( "end_remote" );
    wait 1;
    self notifyonplayercommand( "remoteUAV_tag", "+attack" );
    self notifyonplayercommand( "remoteUAV_tag", "+attack_akimbo_accessible" );

    for (;;)
    {
        self waittill( "remoteUAV_tag" );

        if ( isdefined( self.lockedtarget ) )
        {
            self playlocalsound( "recondrone_tag" );
            maps\mp\gametypes\_damagefeedback::_ID34528( "" );
            thread remoteuav_markplayer( self.lockedtarget );
            thread remoteuav_rumble( var_0, 3 );
            wait 0.25;
            continue;
        }

        wait 0.05;
    }
}

remoteuav_rumble( var_0, var_1 )
{
    self endon( "disconnect" );
    var_0 endon( "death" );
    level endon( "game_ended" );
    var_0 endon( "end_remote" );
    var_0 notify( "end_rumble" );
    var_0 endon( "end_rumble" );

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        self playrumbleonentity( "damage_heavy" );
        wait 0.05;
    }
}

remoteuav_markplayer( var_0 )
{
    level endon( "game_ended" );
    var_0._ID34166 = self;

    if ( isplayer( var_0 ) && !var_0 maps\mp\_utility::_ID18837() )
    {
        var_0 playlocalsound( "player_hit_while_ads_hurt" );
        var_0 thread maps\mp\_flashgrenades::applyflash( 2.0, 1.0 );
        var_0 thread maps\mp\gametypes\_rank::_ID36462( "marked_by_remote_uav" );
    }
    else if ( isdefined( var_0._ID34170 ) )
        var_0.birth_time = var_0.birthtime;
    else if ( isdefined( var_0.owner ) && isalive( var_0.owner ) )
        var_0.owner thread maps\mp\gametypes\_rank::_ID36462( "turret_marked_by_remote_uav" );

    _ID25834( "tag" );
    thread maps\mp\gametypes\_rank::_ID36462( "remote_uav_marked" );

    if ( level._ID14086 != "dm" )
    {
        if ( isplayer( var_0 ) )
        {
            maps\mp\gametypes\_gamescore::_ID15616( "kill", self, undefined, 1 );
            thread maps\mp\gametypes\_rank::giverankxp( "kill" );
        }
    }

    if ( isplayer( var_0 ) )
        var_0 setperk( "specialty_radarblip", 1, 0 );
    else
    {
        if ( isdefined( var_0._ID34170 ) )
            var_1 = "compassping_enemy_uav";
        else
            var_1 = "compassping_sentry_enemy";

        if ( level._ID32653 )
        {
            var_2 = maps\mp\gametypes\_gameobjects::getnextobjid();
            objective_add( var_2, "invisible", ( 0, 0, 0 ) );
            objective_onentity( var_2, var_0 );
            objective_state( var_2, "active" );
            objective_team( var_2, self.team );
            objective_icon( var_2, var_1 );
            var_0._ID25864 = var_2;
        }
        else
        {
            var_2 = maps\mp\gametypes\_gameobjects::getnextobjid();
            objective_add( var_2, "invisible", ( 0, 0, 0 ) );
            objective_onentity( var_2, var_0 );
            objective_state( var_2, "active" );
            objective_team( var_2, level._ID23070[self.team] );
            objective_icon( var_2, var_1 );
            var_0._ID25865 = var_2;
            var_2 = maps\mp\gametypes\_gameobjects::getnextobjid();
            objective_add( var_2, "invisible", ( 0, 0, 0 ) );
            objective_onentity( var_2, var_0 );
            objective_state( var_2, "active" );
            objective_team( var_2, self.team );
            objective_icon( var_2, var_1 );
            var_0._ID25866 = var_2;
        }
    }

    var_0 thread _ID25861( self._ID25826 );
}

_ID25854( var_0 )
{
    _ID25834( "assist" );
    thread maps\mp\gametypes\_rank::_ID36462( "remote_uav_assist" );

    if ( level._ID14086 != "dm" )
    {
        self._ID32359 = 1;

        if ( isdefined( var_0 ) )
            thread maps\mp\gametypes\_gamescore::processassist( var_0 );
        else
        {
            maps\mp\gametypes\_gamescore::_ID15616( "assist", self, undefined, 1 );
            thread maps\mp\gametypes\_rank::giverankxp( "assist" );
        }
    }
}

_ID25861( var_0 )
{
    level endon( "game_ended" );
    var_1 = common_scripts\utility::_ID35635( "death", "disconnect", "carried", "leaving" );

    if ( var_1 == "leaving" || !isdefined( self._ID34170 ) )
        self._ID34166 = undefined;

    if ( isdefined( var_0 ) )
    {
        if ( isplayer( self ) )
            var_2 = self._ID15851;
        else if ( isdefined( self.birthtime ) )
            var_2 = self.birthtime;
        else
            var_2 = self.birth_time;

        if ( var_1 == "carried" || var_1 == "leaving" )
        {
            var_0._ID20645[var_2]["icon"] destroy();
            var_0._ID20645[var_2]["icon"] = undefined;
        }

        if ( isdefined( var_2 ) && isdefined( var_0._ID20645[var_2] ) )
        {
            var_0._ID20645[var_2] = undefined;
            var_0._ID20645 = common_scripts\utility::array_removeundefined( var_0._ID20645 );
        }
    }

    if ( isplayer( self ) )
        self unsetperk( "specialty_radarblip", 1 );
    else
    {
        if ( isdefined( self._ID25864 ) )
            maps\mp\_utility::_objective_delete( self._ID25864 );

        if ( isdefined( self._ID25865 ) )
            maps\mp\_utility::_objective_delete( self._ID25865 );

        if ( isdefined( self._ID25866 ) )
            maps\mp\_utility::_objective_delete( self._ID25866 );
    }
}

_ID25831()
{
    foreach ( var_1 in self._ID20645 )
    {
        if ( isdefined( var_1["icon"] ) )
        {
            var_1["icon"] destroy();
            var_1["icon"] = undefined;
        }
    }

    self._ID20645 = undefined;
}

_ID25852( var_0 )
{
    self endon( "disconnect" );
    var_0 endon( "death" );
    level endon( "game_ended" );
    var_0 endon( "end_remote" );

    for (;;)
    {
        self playrumbleonentity( "damage_light" );
        wait 0.5;
    }
}

_ID25862()
{
    self endon( "death" );
    self._ID25415 = getent( "remote_uav_range", "targetname" );

    if ( !isdefined( self._ID25415 ) )
    {
        var_0 = getent( "airstrikeheight", "targetname" );
        self._ID20741 = var_0.origin[2];
        self.maxdistance = 12800;
    }

    self.centerref = spawn( "script_model", level._ID20634 );
    var_1 = self.origin;
    self._ID25414 = 0;

    for (;;)
    {
        if ( !_ID25845() )
        {
            var_2 = 0;

            while ( !_ID25845() )
            {
                self.owner _ID25834( "out_of_range" );

                if ( !self._ID25414 )
                {
                    self._ID25414 = 1;
                    thread _ID25855();
                }

                if ( isdefined( self._ID16734 ) )
                {
                    var_3 = distance( self.origin, self._ID16734.origin );
                    var_2 = 1 - ( var_3 - 150 ) / 150;
                }
                else
                {
                    var_3 = distance( self.origin, var_1 );
                    var_2 = min( 1, var_3 / 200 );
                }

                self.owner setplayerdata( "reconDroneState", "staticAlpha", var_2 );
                wait 0.05;
            }

            self notify( "in_range" );
            self._ID25414 = 0;
            thread remoteuav_staticfade( var_2 );
        }

        var_1 = self.origin;
        wait 0.05;
    }
}

_ID25845()
{
    if ( isdefined( self._ID25415 ) )
    {
        if ( !self istouching( self._ID25415 ) && !self._ID17629 )
            return 1;
    }
    else if ( distance2d( self.origin, level._ID20634 ) < self.maxdistance && self.origin[2] < self._ID20741 && !self._ID17629 )
        return 1;

    return 0;
}

remoteuav_staticfade( var_0 )
{
    self endon( "death" );

    while ( _ID25845() )
    {
        var_0 -= 0.05;

        if ( var_0 < 0 )
        {
            self.owner setplayerdata( "reconDroneState", "staticAlpha", 0 );
            break;
        }

        self.owner setplayerdata( "reconDroneState", "staticAlpha", var_0 );
        wait 0.05;
    }
}

_ID25855()
{
    self endon( "death" );
    self endon( "in_range" );

    if ( isdefined( self._ID16734 ) )
        var_0 = 3;
    else
        var_0 = 6;

    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    self notify( "death" );
}

remoteuav_explode_on_disconnect()
{
    self endon( "death" );
    self.owner waittill( "disconnect" );
    self notify( "death" );
}

_ID25836()
{
    self endon( "death" );
    self.owner common_scripts\utility::_ID35626( "joined_team", "joined_spectators" );
    self notify( "death" );
}

_ID25829()
{
    self endon( "death" );
    level waittill( "game_ended" );
    _ID25831();
}

_ID25848()
{
    self endon( "death" );
    var_0 = 60.0;
    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    thread remoteuav_leave();
}

remoteuav_leave()
{
    level endon( "game_ended" );
    self endon( "death" );
    self notify( "leaving" );
    self.owner _ID25835( self );
    self notify( "death" );
}

_ID25837()
{
    level endon( "game_ended" );
    self waittill( "death" );
    self playsound( "recondrone_destroyed" );
    playfx( level._ID25841["explode"], self.origin );
    _ID25828();
}

_ID25828()
{
    if ( self._ID24519 == 1 && isdefined( self.owner ) )
        self.owner _ID25835( self );

    if ( isdefined( self._ID27391 ) )
        self._ID27391 delete();

    if ( isdefined( self.centerref ) )
        self.centerref delete();

    _ID25831();
    stopfxontag( level._ID25841["smoke"], self, "tag_origin" );
    level._ID25810[self.team] = undefined;
    maps\mp\_utility::decrementfauxvehiclecount();
    self delete();
}

_ID25849()
{
    playfxontag( level._ID7233["light"]["belly"], self, "tag_light_nose" );
    wait 0.05;
    playfxontag( level._ID7233["light"]["tail"], self, "tag_light_tail1" );
}

_ID25834( var_0 )
{
    if ( var_0 == "tag" )
        var_1 = 1000;
    else
        var_1 = 5000;

    if ( gettime() - level._ID25846 < var_1 )
        return;

    level._ID25846 = gettime();
    var_2 = randomint( level._ID25834[var_0].size );
    var_3 = level._ID25834[var_0][var_2];
    var_4 = maps\mp\gametypes\_teams::getteamvoiceprefix( self.team ) + var_3;
    self playlocalsound( var_4 );
}

_ID25844()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "end_remote" );

    for (;;)
    {
        level waittill( "stinger_fired",  var_0, var_1, var_2  );

        if ( !isdefined( var_1 ) || !isdefined( var_2 ) || var_2 != self )
            continue;

        self.owner playlocalsound( "javelin_clu_lock" );
        self.owner setplayerdata( "reconDroneState", "incomingMissile", 1 );
        self._ID16404 = 1;
        self._ID17527[self._ID17527.size] = var_1;
        var_1.owner = var_0;
        var_1 thread _ID36133( var_2 );
    }
}

_ID25843()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "end_remote" );

    for (;;)
    {
        level waittill( "sam_fired",  var_0, var_1, var_2  );

        if ( !isdefined( var_2 ) || var_2 != self )
            continue;

        var_3 = 0;

        foreach ( var_5 in var_1 )
        {
            if ( isdefined( var_5 ) )
            {
                self._ID17527[self._ID17527.size] = var_5;
                var_5.owner = var_0;
                var_3++;
            }
        }

        if ( var_3 )
        {
            self.owner playlocalsound( "javelin_clu_lock" );
            self.owner setplayerdata( "reconDroneState", "incomingMissile", 1 );
            self._ID16404 = 1;
            level thread _ID36122( var_2, var_1 );
        }
    }
}

_ID36133( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self missile_settargetent( var_0 );
    var_1 = vectornormalize( var_0.origin - self.origin );

    while ( isdefined( var_0 ) )
    {
        var_2 = var_0 getpointinbounds( 0, 0, 0 );
        var_3 = distance( self.origin, var_2 );

        if ( var_0._ID22406 > 0 && var_3 < 4000 )
        {
            var_4 = var_0 _ID9665();
            self missile_settargetent( var_4 );
            return;
        }
        else
        {
            var_5 = vectornormalize( var_0.origin - self.origin );

            if ( vectordot( var_5, var_1 ) < 0 )
            {
                self playsound( "exp_stinger_armor_destroy" );
                playfx( level._ID25841["missile_explode"], self.origin );

                if ( isdefined( self.owner ) )
                    radiusdamage( self.origin, 400, 1000, 1000, self.owner, "MOD_EXPLOSIVE", "stinger_mp" );
                else
                    radiusdamage( self.origin, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "stinger_mp" );

                self hide();
                wait 0.05;
                self delete();
            }
            else
                var_1 = var_5;
        }

        wait 0.05;
    }
}

_ID36122( var_0, var_1 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3 ) )
        {
            var_3 missile_settargetent( var_0 );
            var_3.lastvectotarget = vectornormalize( var_0.origin - var_3.origin );
        }
    }

    while ( var_1.size && isdefined( var_0 ) )
    {
        var_5 = var_0 getpointinbounds( 0, 0, 0 );

        foreach ( var_3 in var_1 )
        {
            if ( isdefined( var_3 ) )
            {
                if ( isdefined( self._ID20649 ) )
                {
                    self delete();
                    continue;
                }

                if ( var_0._ID22406 > 0 )
                {
                    var_7 = distance( var_3.origin, var_5 );

                    if ( var_7 < 4000 )
                    {
                        var_8 = var_0 _ID9665();

                        foreach ( var_10 in var_1 )
                        {
                            if ( isdefined( var_10 ) )
                                var_10 missile_settargetent( var_8 );
                        }

                        return;
                    }

                    continue;
                }

                var_12 = vectornormalize( var_0.origin - var_3.origin );

                if ( vectordot( var_12, var_3.lastvectotarget ) < 0 )
                {
                    var_3 playsound( "exp_stinger_armor_destroy" );
                    playfx( level._ID25841["missile_explode"], var_3.origin );

                    if ( isdefined( var_3.owner ) )
                        radiusdamage( var_3.origin, 400, 1000, 1000, var_3.owner, "MOD_EXPLOSIVE", "stinger_mp" );
                    else
                        radiusdamage( var_3.origin, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "stinger_mp" );

                    var_3 hide();
                    var_3._ID20649 = 1;
                }
                else
                    var_3.lastvectotarget = var_12;
            }
        }

        var_1 = common_scripts\utility::array_removeundefined( var_1 );
        wait 0.05;
    }
}

_ID9665()
{
    self._ID22406--;
    self.owner thread remoteuav_rumble( self, 6 );
    self playsound( "WEAP_SHOTGUNATTACH_FIRE_NPC" );
    thread _ID24582();
    var_0 = self.origin + ( 0, 0, -100 );
    var_1 = spawn( "script_origin", var_0 );
    var_1.angles = self.angles;
    var_1 movegravity( ( 0, 0, -1 ), 5.0 );
    var_1 thread _ID9603( 5.0 );
    return var_1;
}

_ID24582()
{
    for ( var_0 = 0; var_0 < 5; var_0++ )
    {
        if ( !isdefined( self ) )
            return;

        playfxontag( level._ID1644["vehicle_flares"], self, "TAG_FLARE" );
        wait 0.15;
    }
}

_ID9603( var_0 )
{
    wait(var_0);
    self delete();
}

_ID25830()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "end_remote" );

    for (;;)
    {
        var_0 = 0;

        for ( var_1 = 0; var_1 < self._ID17527.size; var_1++ )
        {
            if ( isdefined( self._ID17527[var_1] ) && _ID21153( self._ID17527[var_1], self ) )
                var_0++;
        }

        if ( self._ID16404 && !var_0 )
        {
            self._ID16404 = 0;
            self.owner setplayerdata( "reconDroneState", "incomingMissile", 0 );
        }

        self._ID17527 = common_scripts\utility::array_removeundefined( self._ID17527 );
        wait 0.05;
    }
}

_ID21153( var_0, var_1 )
{
    var_2 = vectornormalize( var_1.origin - var_0.origin );
    var_3 = anglestoforward( var_0.angles );
    return vectordot( var_2, var_3 ) > 0;
}

_ID25863()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "end_remote" );

    for (;;)
    {
        var_0 = 0;

        foreach ( var_2 in level._ID16755 )
        {
            if ( distance( var_2.origin, self.origin ) < 300 )
            {
                var_0 = 1;
                self._ID16734 = var_2;
            }
        }

        foreach ( var_5 in level._ID20086 )
        {
            if ( var_5 != self && ( !isdefined( var_5._ID16760 ) || var_5._ID16760 != "remote_uav" ) && distance( var_5.origin, self.origin ) < 300 )
            {
                var_0 = 1;
                self._ID16734 = var_5;
            }
        }

        if ( !self._ID17629 && var_0 )
            self._ID17629 = 1;
        else if ( self._ID17629 && !var_0 )
        {
            self._ID17629 = 0;
            self._ID16734 = undefined;
        }

        wait 0.05;
    }
}

_ID25842()
{
    self endon( "end_remote" );
    maps\mp\gametypes\_damage::_ID21371( self.maxhealth, "remote_uav", ::handledeathdamage, ::modifydamage, 1 );
}

modifydamage( var_0, var_1, var_2, var_3 )
{
    var_4 = var_3;
    var_4 = maps\mp\gametypes\_damage::handleempdamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::_ID16266( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleapdamage( var_1, var_2, var_4, var_0 );
    playfxontagforclients( level._ID25841["hit"], self, "tag_origin", self.owner );
    self playsound( "recondrone_damaged" );

    if ( self._ID30272 == 0 && self.damagetaken >= self.maxhealth / 2 )
    {
        self._ID30272 = 1;
        playfxontag( level._ID25841["smoke"], self, "tag_origin" );
    }

    return var_4;
}

handledeathdamage( var_0, var_1, var_2, var_3 )
{
    maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, "destroyed_remote_uav", undefined, "callout_destroyed_remote_uav" );
}
