// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level.radarviewtime = 23;
    level._ID34164 = 23;
    level._ID19256["uav_3dping"] = ::_ID33802;
    level._ID34168 = [];
    level._ID34168["uav_3dping"] = spawnstruct();
    level._ID34168["uav_3dping"].timeout = 63;
    level._ID34168["uav_3dping"]._ID31889 = "uav_3dping";
    level._ID34168["uav_3dping"]._ID16921 = 1.5;
    level._ID34168["uav_3dping"]._ID23589 = 10.0;
    level._ID34168["uav_3dping"]._ID14030 = loadfx( "vfx/gameplay/mp/killstreaks/vfx_3d_world_ping" );
    level._ID34168["uav_3dping"].sound_ping_plr = "oracle_radar_pulse_plr";
    level._ID34168["uav_3dping"]._ID30480 = "oracle_radar_pulse_npc";
    level._ID34168["uav_3dping"]._ID35408 = "oracle_gone";
    level._ID34168["uav_3dping"]._ID32680 = "used_uav_3dping";
    var_0 = getentarray( "minimap_corner", "targetname" );

    if ( var_0.size )
        var_1 = maps\mp\gametypes\_spawnlogic::findboxcenter( var_0[0].origin, var_0[1].origin );
    else
        var_1 = ( 0, 0, 0 );

    level._ID34167 = spawn( "script_model", var_1 );
    level._ID34167.angles = ( 0, 115, 0 );
    level._ID34167 hide();
    level._ID34167.targetname = "uavrig_script_model";
    level._ID34167 thread _ID26749();

    if ( level.multiteambased )
    {
        for ( var_2 = 0; var_2 < level._ID32668.size; var_2++ )
        {
            level.radarmode[level._ID32668[var_2]] = "normal_radar";
            level.activeuavs[level._ID32668[var_2]] = 0;
            level.activecounteruavs[level._ID32668[var_2]] = 0;
            level._ID34165[level._ID32668[var_2]] = [];
        }
    }
    else if ( level._ID32653 )
    {
        level.radarmode["allies"] = "normal_radar";
        level.radarmode["axis"] = "normal_radar";
        level.activeuavs["allies"] = 0;
        level.activeuavs["axis"] = 0;
        level.activecounteruavs["allies"] = 0;
        level.activecounteruavs["axis"] = 0;
        level._ID34165["allies"] = [];
        level._ID34165["axis"] = [];
    }
    else
    {
        level.radarmode = [];
        level.activeuavs = [];
        level.activecounteruavs = [];
        level._ID34165 = [];
        level thread _ID22877();
    }

    level thread _ID34169();
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        level.activeuavs[var_0._ID15851] = 0;
        level.activeuavs[var_0._ID15851 + "_radarStrength"] = 0;
        level.activecounteruavs[var_0._ID15851] = 0;
        level.radarmode[var_0._ID15851] = "normal_radar";
    }
}

_ID26749( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        self endon( var_1 );

    if ( !isdefined( var_0 ) )
        var_0 = 60;

    for (;;)
    {
        self rotateyaw( -360, var_0 );
        wait(var_0);
    }
}

_ID33882( var_0, var_1 )
{
    return _ID34782( var_1 );
}

_ID33802( var_0, var_1 )
{
    var_2 = "uav_3dping";
    thread _ID35919( var_2 );
    thread _ID35920( var_2 );
    level thread maps\mp\_utility::_ID32672( level._ID34168[var_2]._ID32680, self );
    return 1;
}

_ID34782( var_0 )
{
    maps\mp\_matchdata::_ID20253( var_0, self.origin );
    var_1 = self.pers["team"];
    var_2 = level._ID34168[var_0].timeout;
    level thread launchuav( self, var_2, var_0 );

    switch ( var_0 )
    {
        case "counter_uav":
            self notify( "used_counter_uav" );
            break;
        case "directional_uav":
            self.radarshowenemydirection = 1;

            if ( level._ID32653 )
            {
                foreach ( var_4 in level.players )
                {
                    if ( var_4.pers["team"] == var_1 )
                        var_4.radarshowenemydirection = 1;
                }
            }

            level thread maps\mp\_utility::_ID32672( level._ID34168[var_0]._ID32680, self, var_1 );
            self notify( "used_directional_uav" );
            break;
        default:
            self notify( "used_uav" );
            break;
    }

    return 1;
}

launchuav( var_0, var_1, var_2 )
{
    var_3 = var_0.team;
    var_4 = spawn( "script_model", level._ID34167 gettagorigin( "tag_origin" ) );
    var_4 setmodel( level._ID34168[var_2].modelbase );
    var_4.team = var_3;
    var_4.owner = var_0;
    var_4._ID33080 = 0;
    var_4._ID34170 = var_2;
    var_4.health = level._ID34168[var_2].health;
    var_4.maxhealth = level._ID34168[var_2].maxhealth;

    if ( var_2 == "directional_uav" )
        var_4 thread _ID30883( level._ID34168[var_2]._ID14023, level._ID34168[var_2]._ID13805 );

    var_4 adduavmodel();
    var_4 thread _ID8985();
    var_4 thread _ID16259();
    var_4 thread removeuavmodelondeath();
    var_5 = randomintrange( 3000, 5000 );

    if ( isdefined( level.spawnpoints ) )
        var_6 = level.spawnpoints;
    else
        var_6 = level._ID31475;

    var_7 = var_6[0];

    foreach ( var_9 in var_6 )
    {
        if ( var_9.origin[2] < var_7.origin[2] )
            var_7 = var_9;
    }

    var_11 = var_7.origin[2];
    var_12 = level._ID34167.origin[2];

    if ( var_11 < 0 )
    {
        var_12 += var_11 * -1;
        var_11 = 0;
    }

    var_13 = var_12 - var_11;

    if ( var_13 + var_5 > 8100.0 )
        var_5 -= ( var_13 + var_5 - 8100.0 );

    var_14 = randomint( 360 );
    var_15 = randomint( 2000 ) + 5000;
    var_16 = cos( var_14 ) * var_15;
    var_17 = sin( var_14 ) * var_15;
    var_18 = vectornormalize( ( var_16, var_17, var_5 ) );
    var_18 *= randomintrange( 6000, 7000 );
    var_4 linkto( level._ID34167, "tag_origin", var_18, ( 0, var_14 - 90, 0 ) );
    var_4 thread _ID34637();
    var_4 [[ level._ID34168[var_2]._ID2329 ]]();

    if ( isdefined( level.activeuavs[var_3] ) )
    {
        foreach ( var_20 in level._ID34165[var_3] )
        {
            if ( var_20 == var_4 )
                continue;

            var_20._ID33080 = var_20._ID33080 + 5;
        }
    }

    level notify( "uav_update" );
    var_4 maps\mp\gametypes\_hostmigration::_ID35709( "death", var_1 );

    if ( var_4.damagetaken < var_4.maxhealth )
    {
        var_4 unlink();
        var_22 = var_4.origin + anglestoforward( var_4.angles ) * 20000;
        var_4 moveto( var_22, 60 );

        if ( isdefined( level._ID34168[var_2]._ID14025 ) && isdefined( level._ID34168[var_2]._ID13862 ) )
            playfxontag( level._ID34168[var_2]._ID14025, var_4, level._ID34168[var_2]._ID13862 );

        var_4 maps\mp\gametypes\_hostmigration::_ID35709( "death", 3 );

        if ( var_4.damagetaken < var_4.maxhealth )
        {
            var_4 notify( "leaving" );
            var_4._ID18690 = 1;
            var_4 moveto( var_22, 4, 4, 0.0 );
        }

        var_4 maps\mp\gametypes\_hostmigration::_ID35709( "death", 4 + var_4._ID33080 );
    }

    var_4 [[ level._ID34168[var_2]._ID26009 ]]();
    var_4 delete();
    var_4 _ID26039();

    if ( var_2 == "directional_uav" )
    {
        var_0.radarshowenemydirection = 0;

        if ( level._ID32653 )
        {
            foreach ( var_24 in level.players )
            {
                if ( var_24.pers["team"] == var_3 )
                    var_24.radarshowenemydirection = 0;
            }
        }
    }

    level notify( "uav_update" );
}

_ID34637()
{
    self endon( "death" );

    for (;;)
    {
        level common_scripts\utility::_ID35663( "joined_team", "uav_update" );
        self hide();

        foreach ( var_1 in level.players )
        {
            if ( level._ID32653 )
            {
                if ( var_1.team != self.team )
                    self showtoplayer( var_1 );

                continue;
            }

            if ( isdefined( self.owner ) && var_1 == self.owner )
                continue;

            self showtoplayer( var_1 );
        }
    }
}

_ID8985()
{
    level endon( "game_ended" );
    self setcandamage( 1 );
    self.damagetaken = 0;

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( !isplayer( var_1 ) )
        {
            if ( !isdefined( self ) )
                return;

            continue;
        }

        if ( isdefined( var_8 ) && var_8 & level.idflags_penetration )
            self._ID35910 = 1;

        self._ID35908 = 1;
        var_10 = var_0;

        if ( isplayer( var_1 ) )
        {
            var_1 maps\mp\gametypes\_damagefeedback::_ID34528( "" );

            if ( var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET" )
            {
                if ( var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
                    var_10 += var_0 * level.armorpiercingmod;
            }
        }

        if ( isdefined( var_9 ) )
        {
            switch ( var_9 )
            {
                case "stinger_mp":
                case "javelin_mp":
                    self._ID19345 = 1;
                    var_10 = self.maxhealth + 1;
                    break;
                case "sam_projectile_mp":
                    self._ID19345 = 1;
                    var_11 = 0.25;

                    if ( self._ID34170 == "directional_uav" )
                        var_11 = 0.15;

                    var_10 = self.maxhealth * var_11;
                    break;
            }

            maps\mp\killstreaks\_killstreaks::_ID19257( var_1, var_9, self );
        }

        self.damagetaken = self.damagetaken + var_10;

        if ( self.damagetaken >= self.maxhealth )
        {
            if ( isplayer( var_1 ) && ( !isdefined( self.owner ) || var_1 != self.owner ) )
            {
                thread maps\mp\_utility::_ID32672( level._ID34168[self._ID34170].calloutdestroyed, var_1 );
                thread maps\mp\gametypes\_missions::vehiclekilled( self.owner, self, undefined, var_1, var_0, var_4, var_9 );
                var_1 thread maps\mp\gametypes\_rank::giverankxp( "kill", 50, var_9, var_4 );
                var_1 notify( "destroyed_killstreak" );

                if ( isdefined( self._ID34166 ) && self._ID34166 != var_1 )
                    self._ID34166 thread maps\mp\killstreaks\_remoteuav::_ID25854();
            }

            self hide();
            var_12 = anglestoright( self.angles ) * 200;
            playfx( level._ID34168[self._ID34170].fxid_explode, self.origin, var_12 );
            self notify( "death" );
            return;
        }
    }
}

_ID34169()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "uav_update" );

        if ( level.multiteambased )
        {
            for ( var_0 = 0; var_0 < level._ID32668.size; var_0++ )
                _ID34627( level._ID32668[var_0] );

            continue;
        }

        if ( level._ID32653 )
        {
            _ID34627( "allies" );
            _ID34627( "axis" );
            continue;
        }

        _ID34578();
    }
}

_getradarstrength( var_0 )
{
    var_1 = 0;
    var_2 = 0;

    foreach ( var_4 in level._ID34165[var_0] )
    {
        if ( var_4._ID34170 == "counter_uav" )
            continue;

        if ( var_4._ID34170 == "remote_mortar" )
            continue;

        var_1++;
    }

    if ( level.multiteambased )
    {
        foreach ( var_7 in level._ID32668 )
        {
            foreach ( var_4 in level._ID34165[var_7] )
            {
                if ( var_7 == var_0 )
                    continue;

                if ( var_4._ID34170 != "counter_uav" )
                    continue;

                var_2++;
            }
        }
    }
    else
    {
        foreach ( var_4 in level._ID34165[level._ID23070[var_0]] )
        {
            if ( var_4._ID34170 != "counter_uav" )
                continue;

            var_2++;
        }
    }

    if ( var_2 > 0 )
        var_13 = -3;
    else
        var_13 = var_1;

    var_14 = getuavstrengthmin();
    var_15 = getuavstrengthmax();

    if ( var_13 <= var_14 )
        var_13 = var_14;
    else if ( var_13 >= var_15 )
        var_13 = var_15;

    return var_13;
}

_ID34627( var_0 )
{
    var_1 = _getradarstrength( var_0 );
    setteamradarstrength( var_0, var_1 );

    if ( var_1 >= getuavstrengthlevelneutral() )
        unblockteamradar( var_0 );
    else
        blockteamradar( var_0 );

    if ( var_1 <= getuavstrengthlevelneutral() )
    {
        _ID28897( var_0, 0 );
        _ID34628( var_0 );
        return;
    }

    if ( var_1 >= getuavstrengthlevelshowenemyfastsweep() )
        level.radarmode[var_0] = "fast_radar";
    else
        level.radarmode[var_0] = "normal_radar";

    _ID34628( var_0 );
    _ID28897( var_0, 1 );
}

_ID34578()
{
    var_0 = getuavstrengthmin();
    var_1 = getuavstrengthmax();
    var_2 = getuavstrengthlevelshowenemydirectional();

    foreach ( var_4 in level.players )
    {
        var_5 = level.activeuavs[var_4._ID15851 + "_radarStrength"];

        foreach ( var_7 in level.players )
        {
            if ( var_7 == var_4 )
                continue;

            var_8 = level.activecounteruavs[var_7._ID15851];

            if ( var_8 > 0 )
            {
                var_5 = -3;
                break;
            }
        }

        if ( var_5 <= var_0 )
            var_5 = var_0;
        else if ( var_5 >= var_1 )
            var_5 = var_1;

        var_4.radarstrength = var_5;

        if ( var_5 >= getuavstrengthlevelneutral() )
            var_4.isradarblocked = 0;
        else
            var_4.isradarblocked = 1;

        if ( var_5 <= getuavstrengthlevelneutral() )
        {
            var_4.hasradar = 0;
            var_4.radarshowenemydirection = 0;
            continue;
        }

        if ( var_5 >= getuavstrengthlevelshowenemyfastsweep() )
            var_4.radarmode = "fast_radar";
        else
            var_4.radarmode = "normal_radar";

        var_4.radarshowenemydirection = var_5 >= var_2;
        var_4.hasradar = 1;
    }
}

blockplayeruav()
{
    self endon( "disconnect" );
    self notify( "blockPlayerUAV" );
    self endon( "blockPlayerUAV" );
    self.isradarblocked = 1;
    wait(level._ID34164);
    self.isradarblocked = 0;
}

_ID34628( var_0 )
{
    var_1 = _getradarstrength( var_0 ) >= getuavstrengthlevelshowenemydirectional();

    foreach ( var_3 in level.players )
    {
        if ( var_3.team == "spectator" )
            continue;

        var_3.radarmode = level.radarmode[var_3.team];

        if ( var_3.team == var_0 )
            var_3.radarshowenemydirection = var_1;
    }
}

_ID34763( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self notify( "usePlayerUAV" );
    self endon( "usePlayerUAV" );

    if ( var_0 )
        self.radarmode = "fast_radar";
    else
        self.radarmode = "normal_radar";

    self.hasradar = 1;
    wait(var_1);
    self.hasradar = 0;
}

_ID28897( var_0, var_1 )
{
    setteamradar( var_0, var_1 );
    level notify( "radar_status_change",  var_0  );
}

_ID16259()
{
    level endon( "game_ended" );
    self endon( "death" );

    for (;;)
    {
        level waittill( "stinger_fired",  var_0, var_1, var_2  );

        if ( !isdefined( var_2 ) || var_2 != self )
            continue;

        var_1 thread _ID31742( var_2, var_0 );
    }
}

_ID31742( var_0, var_1 )
{
    self endon( "death" );
    var_2 = distance( self.origin, var_0 getpointinbounds( 0, 0, 0 ) );
    var_3 = var_0 getpointinbounds( 0, 0, 0 );

    for (;;)
    {
        if ( !isdefined( var_0 ) )
            var_4 = var_3;
        else
            var_4 = var_0 getpointinbounds( 0, 0, 0 );

        var_3 = var_4;
        var_5 = distance( self.origin, var_4 );

        if ( var_5 < var_2 )
            var_2 = var_5;

        if ( var_5 > var_2 )
        {
            if ( var_5 > 1536 )
                return;

            radiusdamage( self.origin, 1536, 600, 600, var_1, "MOD_EXPLOSIVE", "stinger_mp" );
            playfx( level.stingerfxid, self.origin );
            self hide();
            self notify( "deleted" );
            wait 0.05;
            self delete();
            var_1 notify( "killstreak_destroyed" );
        }

        wait 0.05;
    }
}

adduavmodel()
{
    if ( level._ID32653 )
        level._ID34165[self.team][level._ID34165[self.team].size] = self;
    else
        level._ID34165[self.owner._ID15851 + "_" + gettime()] = self;
}

removeuavmodelondeath()
{
    self waittill( "death" );

    if ( isdefined( self._ID34167 ) )
        self._ID34167 delete();

    if ( isdefined( self ) )
        self delete();

    _ID26039();
}

_ID26039()
{
    var_0 = [];

    if ( level._ID32653 )
    {
        var_1 = self.team;

        foreach ( var_3 in level._ID34165[var_1] )
        {
            if ( !isdefined( var_3 ) )
                continue;

            var_0[var_0.size] = var_3;
        }

        level._ID34165[var_1] = var_0;
    }
    else
    {
        foreach ( var_3 in level._ID34165 )
        {
            if ( !isdefined( var_3 ) )
                continue;

            var_0[var_0.size] = var_3;
        }

        level._ID34165 = var_0;
    }
}

addactiveuav()
{
    if ( level._ID32653 )
        level.activeuavs[self.team]++;
    else
    {
        level.activeuavs[self.owner._ID15851]++;
        level.activeuavs[self.owner._ID15851 + "_radarStrength"]++;
    }
}

addactivecounteruav()
{
    if ( level._ID32653 )
        level.activecounteruavs[self.team]++;
    else
        level.activecounteruavs[self.owner._ID15851]++;
}

_ID25974()
{
    if ( level._ID32653 )
        level.activeuavs[self.team]--;
    else if ( isdefined( self.owner ) )
    {
        level.activeuavs[self.owner._ID15851]--;
        level.activeuavs[self.owner._ID15851 + "_radarStrength"]--;
    }
}

_ID25972()
{
    if ( level._ID32653 )
        level.activecounteruavs[self.team]--;
    else if ( isdefined( self.owner ) )
        level.activecounteruavs[self.owner._ID15851]--;
}

_ID30883( var_0, var_1 )
{
    self endon( "death" );
    level endon( "game_ended" );
    wait 0.5;
    playfxontag( var_0, self, var_1 );
}

_ID35919( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        var_1 endon( "death" );

    self endon( "leave" );
    self endon( "killstreak_disowned" );
    level endon( "game_ended" );
    var_2 = level._ID34168[var_0];
    var_3 = var_2._ID23589;

    if ( level._ID32653 )
        level.activeuavs[self.team]++;
    else
        level.activeuavs[self._ID15851]++;

    for (;;)
    {
        playfx( var_2._ID14030, self.origin );
        self playlocalsound( var_2.sound_ping_plr );
        playsoundatpos( self.origin + ( 0, 0, 5 ), var_2._ID30480 );

        foreach ( var_5 in level._ID23303 )
        {
            if ( !maps\mp\_utility::_ID18757( var_5 ) )
                continue;

            if ( !maps\mp\_utility::isenemy( var_5 ) )
                continue;

            if ( var_5 maps\mp\_utility::_hasperk( "specialty_noplayertarget" ) )
                continue;

            var_5 maps\mp\gametypes\_damagefeedback::hudicontype( "oracle" );

            foreach ( var_7 in level._ID23303 )
            {
                if ( !maps\mp\_utility::_ID18757( var_7 ) )
                    continue;

                if ( maps\mp\_utility::isenemy( var_7 ) )
                    continue;

                if ( isai( var_7 ) )
                {
                    var_7 common_scripts\utility::ai_3d_sighting_model( var_5 );
                    continue;
                }

                var_8 = maps\mp\_utility::_ID23108( var_5, "orange", var_7, 0, "killstreak" );
                var_9 = var_2._ID16921;
                var_7 thread _ID36088( var_8, var_5, var_9, var_1 );
            }
        }

        maps\mp\gametypes\_hostmigration::_ID35597( var_3 );
    }
}

_ID35920( var_0 )
{
    self endon( "killstreak_disowned" );
    level endon( "game_ended" );
    var_1 = level._ID34168[var_0];
    var_2 = var_1.timeout;
    var_3 = self._ID15851;

    if ( level._ID32653 )
        var_3 = self.team;

    thread watch_3dping_killstreakdisowned( var_3 );
    maps\mp\gametypes\_hostmigration::_ID35597( var_2 );
    maps\mp\_utility::_ID19765( var_1._ID35408 );
    self notify( "leave" );
    cleanup3dping( var_3 );
}

watch_3dping_killstreakdisowned( var_0 )
{
    self endon( "leave" );
    self waittill( "killstreak_disowned" );
    cleanup3dping( var_0 );
}

cleanup3dping( var_0 )
{
    level.activeuavs[var_0]--;

    if ( level.activeuavs[var_0] < 0 )
        level.activeuavs[var_0] = 0;
}

_ID36088( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_3 ) )
        var_3 endon( "death" );

    self endon( "disconnect" );
    level endon( "game_ended" );
    common_scripts\utility::_ID35638( var_2, "leave" );

    if ( isdefined( var_1 ) )
        maps\mp\_utility::_ID23104( var_0, var_1 );
}
