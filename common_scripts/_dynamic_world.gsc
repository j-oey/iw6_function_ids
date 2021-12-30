// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    common_scripts\utility::_ID3867( getentarray( "com_wall_fan_blade_rotate_slow", "targetname" ), ::_ID12760, "veryslow" );
    common_scripts\utility::_ID3867( getentarray( "com_wall_fan_blade_rotate", "targetname" ), ::_ID12760, "slow" );
    common_scripts\utility::_ID3867( getentarray( "com_wall_fan_blade_rotate_fast", "targetname" ), ::_ID12760, "fast" );
    var_0 = [];
    var_0["trigger_multiple_dyn_metal_detector"] = ::metal_detector;
    var_0["trigger_multiple_dyn_creaky_board"] = ::creaky_board;
    var_0["trigger_multiple_dyn_photo_copier"] = ::photo_copier;
    var_0["trigger_multiple_dyn_copier_no_light"] = ::_ID23510;
    var_0["trigger_radius_motion_light"] = ::motion_light;
    var_0["trigger_radius_dyn_motion_dlight"] = ::_ID23077;
    var_0["trigger_multiple_dog_bark"] = ::dog_bark;
    var_0["trigger_radius_bird_startle"] = ::bird_startle;
    var_0["trigger_multiple_dyn_motion_light"] = ::motion_light;
    var_0["trigger_multiple_dyn_door"] = ::trigger_door;
    _ID24139();

    foreach ( var_4, var_2 in var_0 )
    {
        var_3 = getentarray( var_4, "classname" );
        common_scripts\utility::_ID3867( var_3, ::_ID33725 );
        common_scripts\utility::_ID3867( var_3, var_2 );
    }

    common_scripts\utility::_ID3867( getentarray( "vending_machine", "targetname" ), ::_ID35170 );
    common_scripts\utility::_ID3867( getentarray( "toggle", "targetname" ), ::_ID34719 );
    level thread _ID22877();
    var_5 = getent( "civilian_jet_origin", "targetname" );

    if ( isdefined( var_5 ) )
        var_5 thread civilian_jet_flyby();

    thread interactive_tv();
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connecting",  var_0  );
        var_0 thread _ID21642();
    }
}

_ID24139()
{
    if ( common_scripts\utility::_ID18787() )
    {
        foreach ( var_1 in level.players )
        {
            var_1._ID33168 = [];
            var_1 thread _ID21642();
        }
    }
}

ai_init()
{
    self._ID33168 = [];
    thread _ID21642();
}

civilian_jet_flyby()
{
    level endon( "game_ended" );
    _ID18952();
    level waittill( "prematch_over" );

    for (;;)
    {
        thread _ID18961();
        self waittill( "start_flyby" );
        thread _ID18949();
        self waittill( "flyby_done" );
        jet_reset();
    }
}

_ID18952()
{
    self._ID18953 = getentarray( self.target, "targetname" );
    self._ID18951 = getent( "civilian_jet_flyto", "targetname" );
    self.engine_fxs = getentarray( "engine_fx", "targetname" );
    self.flash_fxs = getentarray( "flash_fx", "targetname" );
    self._ID18942 = loadfx( "fx/fire/jet_afterburner" );
    self._ID18946 = loadfx( "fx/misc/aircraft_light_wingtip_red" );
    self._ID18945 = loadfx( "fx/misc/aircraft_light_wingtip_green" );
    self._ID18944 = loadfx( "fx/misc/aircraft_light_red_blink" );
    level.civilianjetflyby = undefined;
    var_0 = vectornormalize( self.origin - self._ID18951.origin ) * 20000;
    self._ID18951.origin = self._ID18951.origin - var_0;
    self.origin = self.origin + var_0;

    foreach ( var_2 in self._ID18953 )
    {
        var_2.origin = var_2.origin + var_0;
        var_2._ID22693 = var_2.origin;
        var_2 hide();
    }

    foreach ( var_5 in self.engine_fxs )
        var_5.origin = var_5.origin + var_0;

    foreach ( var_8 in self.flash_fxs )
        var_8.origin = var_8.origin + var_0;

    var_10 = self.origin;
    var_11 = self._ID18951.origin;
    self._ID18948 = var_11 - var_10;
    var_12 = 2000;
    var_13 = abs( distance( var_10, var_11 ) );
    self.jet_flight_time = var_13 / var_12;
}

jet_reset()
{
    foreach ( var_1 in self._ID18953 )
    {
        var_1.origin = var_1._ID22693;
        var_1 hide();
    }
}

_ID18961()
{
    level endon( "game_ended" );
    var_0 = gettimeinterval();
    var_1 = max( 10, var_0 );
    var_1 = min( var_1, 100 );

    if ( getdvar( "jet_flyby_timer" ) != "" )
        level.civilianjetflyby_timer = 5 + getdvarint( "jet_flyby_timer" );
    else
        level.civilianjetflyby_timer = ( 0.25 + randomfloatrange( 0.3, 0.7 ) ) * 60 * var_1;

    wait(level.civilianjetflyby_timer);

    while ( isdefined( level.airstrikeinprogress ) || isdefined( level.ac130player ) || isdefined( level.chopper ) || isdefined( level._ID25821 ) )
        wait 0.05;

    self notify( "start_flyby" );
    level.civilianjetflyby = 1;
    self waittill( "flyby_done" );
    level.civilianjetflyby = undefined;
}

gettimeinterval()
{
    if ( common_scripts\utility::_ID18787() )
        return 10.0;

    if ( isdefined( game["status"] ) && game["status"] == "overtime" )
        return 1.0;
    else
        return getwatcheddvar( "timelimit" );
}

getwatcheddvar( var_0 )
{
    var_0 = "scr_" + level._ID14086 + "_" + var_0;

    if ( isdefined( level._ID23179 ) && isdefined( level._ID23179[var_0] ) )
        return level._ID23179[var_0];

    return level.watchdvars[var_0]._ID34844;
}

_ID18949()
{
    foreach ( var_1 in self._ID18953 )
        var_1 show();

    var_3 = [];
    var_4 = [];

    foreach ( var_6 in self.engine_fxs )
    {
        var_7 = spawn( "script_model", var_6.origin );
        var_7 setmodel( "tag_origin" );
        var_7.angles = var_6.angles;
        var_3[var_3.size] = var_7;
    }

    foreach ( var_10 in self.flash_fxs )
    {
        var_11 = spawn( "script_model", var_10.origin );
        var_11 setmodel( "tag_origin" );
        var_11.color = var_10.script_noteworthy;
        var_11.angles = var_10.angles;
        var_4[var_4.size] = var_11;
    }

    thread jet_planesound( self._ID18953[0], level._ID20634 );
    wait 0.05;

    foreach ( var_7 in var_3 )
        playfxontag( self._ID18942, var_7, "tag_origin" );

    foreach ( var_11 in var_4 )
    {
        if ( isdefined( var_11.color ) && var_11.color == "blink" )
        {
            playfxontag( self._ID18944, var_11, "tag_origin" );
            continue;
        }

        if ( isdefined( var_11.color ) && var_11.color == "red" )
        {
            playfxontag( self._ID18946, var_11, "tag_origin" );
            continue;
        }

        playfxontag( self._ID18945, var_11, "tag_origin" );
    }

    foreach ( var_1 in self._ID18953 )
        var_1 moveto( var_1.origin + self._ID18948, self.jet_flight_time );

    foreach ( var_7 in var_3 )
        var_7 moveto( var_7.origin + self._ID18948, self.jet_flight_time );

    foreach ( var_11 in var_4 )
        var_11 moveto( var_11.origin + self._ID18948, self.jet_flight_time );

    wait(self.jet_flight_time + 1);

    foreach ( var_7 in var_3 )
        var_7 delete();

    foreach ( var_11 in var_4 )
        var_11 delete();

    self notify( "flyby_done" );
}

jet_planesound( var_0, var_1 )
{
    var_0 thread _ID24640( "veh_mig29_dist_loop" );

    while ( !_ID32613( var_0, var_1 ) )
        wait 0.05;

    var_0 thread _ID24640( "veh_mig29_close_loop" );

    while ( _ID32614( var_0, var_1 ) )
        wait 0.05;

    wait 0.5;
    var_0 thread _ID24639( "veh_mig29_sonic_boom" );

    while ( _ID32613( var_0, var_1 ) )
        wait 0.05;

    var_0 notify( "stop soundveh_mig29_close_loop" );
    self waittill( "flyby_done" );
    var_0 notify( "stop soundveh_mig29_dist_loop" );
}

_ID24639( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_origin", ( 0, 0, 1 ) );
    var_3 hide();

    if ( !isdefined( var_1 ) )
        var_1 = self.origin;

    var_3.origin = var_1;

    if ( isdefined( var_2 ) && var_2 )
        var_3 playsoundasmaster( var_0 );
    else
        var_3 playsound( var_0 );

    wait 10.0;
    var_3 delete();
}

_ID24640( var_0, var_1 )
{
    var_2 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_2 hide();
    var_2 endon( "death" );
    thread common_scripts\utility::delete_on_death( var_2 );

    if ( isdefined( var_1 ) )
    {
        var_2.origin = self.origin + var_1;
        var_2.angles = self.angles;
        var_2 linkto( self );
    }
    else
    {
        var_2.origin = self.origin;
        var_2.angles = self.angles;
        var_2 linkto( self );
    }

    var_2 playloopsound( var_0 );
    self waittill( "stop sound" + var_0 );
    var_2 stoploopsound( var_0 );
    var_2 delete();
}

_ID32614( var_0, var_1 )
{
    var_2 = anglestoforward( common_scripts\utility::_ID13333( var_0.angles ) );
    var_3 = vectornormalize( common_scripts\utility::_ID13335( var_1 ) - var_0.origin );
    var_4 = vectordot( var_2, var_3 );

    if ( var_4 > 0 )
        return 1;
    else
        return 0;
}

_ID32613( var_0, var_1 )
{
    var_2 = _ID32614( var_0, var_1 );

    if ( var_2 )
        var_3 = 1;
    else
        var_3 = -1;

    var_4 = common_scripts\utility::_ID13335( var_0.origin );
    var_5 = var_4 + anglestoforward( common_scripts\utility::_ID13333( var_0.angles ) ) * ( var_3 * 100000 );
    var_6 = pointonsegmentnearesttopoint( var_4, var_5, var_1 );
    var_7 = distance( var_4, var_6 );

    if ( var_7 < 3000 )
        return 1;
    else
        return 0;
}

_ID35170()
{
    level endon( "game_ended" );
    self endon( "death" );
    self setcursorhint( "HINT_ACTIVATE" );
    self._ID35367 = getent( self.target, "targetname" );
    var_0 = getent( self._ID35367.target, "targetname" );
    var_1 = getent( var_0.target, "targetname" );
    var_2 = getent( var_1.target, "targetname" );
    self._ID35365 = var_2.origin;
    var_3 = getent( var_2.target, "targetname" );
    self._ID35366 = var_3.origin;

    if ( isdefined( var_3.target ) )
        self._ID35364 = getent( var_3.target, "targetname" ).origin;

    self._ID35367 setcandamage( 1 );
    self._ID35368 = self._ID35367.model;
    self._ID35363 = self._ID35367.script_noteworthy;
    self._ID35369 = var_0.model;
    self._ID35371 = var_0.origin;
    self._ID35370 = var_0.angles;
    self._ID35373 = var_1.origin;
    self._ID35372 = var_1.angles;
    precachemodel( self._ID35363 );
    var_0 delete();
    var_1 delete();
    var_2 delete();
    var_3 delete();
    self._ID30375 = [];
    self._ID30378 = 12;
    self._ID30379 = undefined;
    self.hp = 400;
    thread _ID35171( self._ID35367 );
    self playloopsound( "vending_machine_hum" );

    for (;;)
    {
        self waittill( "trigger",  var_4  );
        self playsound( "vending_machine_button_press" );

        if ( !self._ID30378 )
            continue;

        if ( isdefined( self._ID30379 ) )
            _ID30377();

        _ID30376( _ID30758() );
        wait 0.05;
    }
}

_ID35171( var_0 )
{
    level endon( "game_ended" );
    var_1 = "mod_grenade mod_projectile mod_explosive mod_grenade_splash mod_projectile_splash splash";
    var_2 = loadfx( "fx/explosions/tv_explosion" );

    for (;;)
    {
        var_3 = undefined;
        var_4 = undefined;
        var_5 = undefined;
        var_6 = undefined;
        var_7 = undefined;
        var_0 waittill( "damage",  var_3, var_4, var_5, var_6, var_7  );

        if ( isdefined( var_7 ) )
        {
            if ( issubstr( var_1, tolower( var_7 ) ) )
                var_3 *= 3;

            self.hp = self.hp - var_3;

            if ( self.hp > 0 )
                continue;

            self notify( "death" );
            self.origin = self.origin + ( 0, 0, 10000 );

            if ( !isdefined( self._ID35364 ) )
                var_8 = self._ID35367.origin + ( 37, -31, 52 );
            else
                var_8 = self._ID35364;

            playfx( var_2, var_8 );
            self._ID35367 setmodel( self._ID35363 );

            while ( self._ID30378 > 0 )
            {
                if ( isdefined( self._ID30379 ) )
                    _ID30377();

                _ID30376( _ID30758() );
                wait 0.05;
            }

            self stoploopsound( "vending_machine_hum" );
            return;
        }
    }
}

_ID30758()
{
    var_0 = spawn( "script_model", self._ID35371 );
    var_0 setmodel( self._ID35369 );
    var_0.origin = self._ID35371;
    var_0.angles = self._ID35370;
    return var_0;
}

_ID30376( var_0 )
{
    var_0 moveto( self._ID35373, 0.2 );
    var_0 playsound( "vending_machine_soda_drop" );
    wait 0.2;
    self._ID30379 = var_0;
    self._ID30378--;
}

_ID30377()
{
    self endon( "death" );

    if ( isdefined( self._ID30379.ejected ) && self._ID30379.ejected == 1 )
        return;

    var_0 = 1;
    var_1 = var_0 * -999;
    var_2 = int( 40000 );
    var_3 = ( int( var_2 / 2 ), int( var_2 / 2 ), 0 ) - ( randomint( var_2 ), randomint( var_2 ), 0 );
    var_4 = vectornormalize( self._ID35366 - self._ID35365 + var_3 );
    var_5 = var_4 * randomfloatrange( var_1, var_0 );
    self._ID30379 physicslaunchclient( self._ID35365, var_5 );
    self._ID30379.ejected = 1;
}

_ID13576()
{
    level endon( "game_ended" );
    var_0 = "briefcase_bomb_mp";
    precacheitem( var_0 );

    for (;;)
    {
        self waittill( "trigger_enter",  var_1  );

        if ( !var_1 hasweapon( var_0 ) )
        {
            var_1 playsound( "freefall_death" );
            var_1 giveweapon( var_0 );
            var_1 setweaponammostock( var_0, 0 );
            var_1 setweaponammoclip( var_0, 0 );
            var_1 switchtoweapon( var_0 );
        }
    }
}

metal_detector()
{
    level endon( "game_ended" );
    var_0 = getent( self.target, "targetname" );
    var_0 enablegrenadetouchdamage();
    var_1 = getent( var_0.target, "targetname" );
    var_2 = getent( var_1.target, "targetname" );
    var_3 = getent( var_2.target, "targetname" );
    var_4 = getent( var_3.target, "targetname" );
    var_5 = [];
    var_6 = min( var_1.origin[0], var_2.origin[0] );
    var_5[0] = var_6;
    var_7 = max( var_1.origin[0], var_2.origin[0] );
    var_5[1] = var_7;
    var_8 = min( var_1.origin[1], var_2.origin[1] );
    var_5[2] = var_8;
    var_9 = max( var_1.origin[1], var_2.origin[1] );
    var_5[3] = var_9;
    var_10 = min( var_1.origin[2], var_2.origin[2] );
    var_5[4] = var_10;
    var_11 = max( var_1.origin[2], var_2.origin[2] );
    var_5[5] = var_11;
    var_1 delete();
    var_2 delete();

    if ( !common_scripts\utility::_ID18787() )
        self.alarm_interval = 7;
    else
        self.alarm_interval = 2;

    self.alarm_playing = 0;
    self.alarm_annoyance = 0;
    self._ID33110 = 0;
    thread metal_detector_dmg_monitor( var_0 );
    thread metal_detector_touch_monitor();
    thread metal_detector_weapons( var_5, "weapon_claymore", "weapon_c4" );
    var_12 = ( var_3.origin[0], var_3.origin[1], var_11 );
    var_13 = ( var_4.origin[0], var_4.origin[1], var_11 );
    var_14 = loadfx( "fx/props/metal_detector_light" );

    for (;;)
    {
        common_scripts\utility::_ID35626( "dmg_triggered", "touch_triggered", "weapon_triggered" );
        thread playsound_and_light( "alarm_metal_detector", var_14, var_12, var_13 );
    }
}

playsound_and_light( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );

    if ( !self.alarm_playing )
    {
        self.alarm_playing = 1;
        thread annoyance_tracker();

        if ( !self.alarm_annoyance )
            self playsound( var_0 );

        playfx( var_1, var_2 );
        playfx( var_1, var_3 );
        wait(self.alarm_interval);
        self.alarm_playing = 0;
    }
}

annoyance_tracker()
{
    level endon( "game_ended" );

    if ( !self._ID33110 )
        return;

    var_0 = self.alarm_interval + 0.15;

    if ( self._ID33110 )
        self._ID33110--;
    else
        self.alarm_annoyance = 1;

    var_1 = gettime();
    var_2 = 7;

    if ( common_scripts\utility::_ID18787() )
        var_2 = 2;

    _ID35633( "dmg_triggered", "touch_triggered", "weapon_triggered", var_2 + 2 );
    var_3 = gettime() - var_1;

    if ( var_3 > var_2 * 1000 + 1150 )
    {
        self.alarm_annoyance = 0;
        self._ID33110 = 0;
    }
}

_ID35633( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );
    self endon( var_0 );
    self endon( var_1 );
    self endon( var_2 );
    wait(var_3);
}

metal_detector_weapons( var_0, var_1, var_2 )
{
    level endon( "game_ended" );

    for (;;)
    {
        waittill_weapon_placed();
        var_3 = getentarray( "grenade", "classname" );

        foreach ( var_5 in var_3 )
        {
            if ( isdefined( var_5.model ) && ( var_5.model == var_1 || var_5.model == var_2 ) )
            {
                if ( _ID18651( var_5, var_0 ) )
                    thread weapon_notify_loop( var_5, var_0 );
            }
        }
    }
}

waittill_weapon_placed()
{
    level endon( "game_ended" );
    self endon( "dmg_triggered" );
    self waittill( "touch_triggered" );
}

weapon_notify_loop( var_0, var_1 )
{
    var_0 endon( "death" );

    while ( _ID18651( var_0, var_1 ) )
    {
        self notify( "weapon_triggered" );
        wait(self.alarm_interval);
    }
}

_ID18651( var_0, var_1 )
{
    var_2 = var_1[0];
    var_3 = var_1[1];
    var_4 = var_1[2];
    var_5 = var_1[3];
    var_6 = var_1[4];
    var_7 = var_1[5];
    var_8 = var_0.origin[0];
    var_9 = var_0.origin[1];
    var_10 = var_0.origin[2];

    if ( _ID18652( var_8, var_2, var_3 ) )
    {
        if ( _ID18652( var_9, var_4, var_5 ) )
        {
            if ( _ID18652( var_10, var_6, var_7 ) )
                return 1;
        }
    }

    return 0;
}

_ID18652( var_0, var_1, var_2 )
{
    if ( var_0 > var_1 && var_0 < var_2 )
        return 1;

    return 0;
}

metal_detector_dmg_monitor( var_0 )
{
    level endon( "game_ended" );

    for (;;)
    {
        var_0 waittill( "damage",  var_1, var_2, var_3, var_4, var_5  );

        if ( isdefined( var_5 ) && alarm_validate_damage( var_5 ) )
            self notify( "dmg_triggered" );
    }
}

metal_detector_touch_monitor()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger_enter" );

        while ( anythingtouchingtrigger( self ) )
        {
            self notify( "touch_triggered" );
            wait(self.alarm_interval);
        }
    }
}

alarm_validate_damage( var_0 )
{
    var_1 = "mod_melee melee mod_grenade mod_projectile mod_explosive mod_impact";
    var_2 = strtok( var_1, " " );

    foreach ( var_4 in var_2 )
    {
        if ( tolower( var_4 ) == tolower( var_0 ) )
            return 1;
    }

    return 0;
}

creaky_board()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger_enter",  var_0  );
        var_0 thread do_creak( self );
    }
}

do_creak( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self playsound( "step_walk_plr_woodcreak_on" );

    for (;;)
    {
        self waittill( "trigger_leave",  var_1  );

        if ( var_0 != var_1 )
            continue;

        self playsound( "step_walk_plr_woodcreak_off" );
        return;
    }
}

motion_light()
{
    level endon( "game_ended" );
    self._ID21697 = 1;
    self._ID19983 = 0;
    var_0 = getentarray( self.target, "targetname" );
    common_scripts\utility::_ID22146( [ "com_two_light_fixture_off", "com_two_light_fixture_on" ], ::precachemodel );

    foreach ( var_2 in var_0 )
    {
        var_2._ID19974 = [];
        var_3 = getent( var_2.target, "targetname" );

        if ( !isdefined( var_3.target ) )
            continue;

        var_2._ID19974 = getentarray( var_3.target, "targetname" );
    }

    for (;;)
    {
        self waittill( "trigger_enter" );

        while ( anythingtouchingtrigger( self ) )
        {
            var_5 = 0;

            foreach ( var_7 in self._ID33167 )
            {
                if ( isdefined( var_7._ID10247 ) && var_7._ID10247 > 5.0 )
                    var_5 = 1;
            }

            if ( var_5 )
            {
                if ( !self._ID19983 )
                {
                    self._ID19983 = 1;
                    var_0[0] playsound( "switch_auto_lights_on" );

                    foreach ( var_2 in var_0 )
                    {
                        var_2 setlightintensity( 1.0 );

                        if ( isdefined( var_2._ID19974 ) )
                        {
                            foreach ( var_11 in var_2._ID19974 )
                                var_11 setmodel( "com_two_light_fixture_on" );
                        }
                    }
                }

                thread _ID21507( var_0, 10.0 );
            }

            wait 0.05;
        }
    }
}

_ID21507( var_0, var_1 )
{
    self notify( "motion_light_timeout" );
    self endon( "motion_light_timeout" );
    wait(var_1);

    foreach ( var_3 in var_0 )
    {
        var_3 setlightintensity( 0 );

        if ( isdefined( var_3._ID19974 ) )
        {
            foreach ( var_5 in var_3._ID19974 )
                var_5 setmodel( "com_two_light_fixture_off" );
        }
    }

    var_0[0] playsound( "switch_auto_lights_off" );
    self._ID19983 = 0;
}

_ID23077()
{
    if ( !isdefined( level._ID23079 ) )
        level._ID23079 = loadfx( "fx/misc/outdoor_motion_light" );

    level endon( "game_ended" );
    self._ID21697 = 1;
    self._ID19983 = 0;
    var_0 = getent( self.target, "targetname" );
    var_1 = getentarray( var_0.target, "targetname" );
    common_scripts\utility::_ID22146( [ "com_two_light_fixture_off", "com_two_light_fixture_on" ], ::precachemodel );

    for (;;)
    {
        self waittill( "trigger_enter" );

        while ( anythingtouchingtrigger( self ) )
        {
            var_2 = 0;

            foreach ( var_4 in self._ID33167 )
            {
                if ( isdefined( var_4._ID10247 ) && var_4._ID10247 > 5.0 )
                    var_2 = 1;
            }

            if ( var_2 )
            {
                if ( !self._ID19983 )
                {
                    self._ID19983 = 1;
                    var_0 playsound( "switch_auto_lights_on" );
                    var_0 setmodel( "com_two_light_fixture_on" );

                    foreach ( var_7 in var_1 )
                    {
                        var_7._ID19960 = spawn( "script_model", var_7.origin );
                        var_7._ID19960 setmodel( "tag_origin" );
                        playfxontag( level._ID23079, var_7._ID19960, "tag_origin" );
                    }
                }

                thread _ID23078( var_0, var_1, 10.0 );
            }

            wait 0.05;
        }
    }
}

_ID23078( var_0, var_1, var_2 )
{
    self notify( "motion_light_timeout" );
    self endon( "motion_light_timeout" );
    wait(var_2);

    foreach ( var_4 in var_1 )
        var_4._ID19960 delete();

    var_0 playsound( "switch_auto_lights_off" );
    var_0 setmodel( "com_two_light_fixture_off" );
    self._ID19983 = 0;
}

dog_bark()
{
    level endon( "game_ended" );
    self._ID21697 = 1;
    var_0 = getent( self.target, "targetname" );

    for (;;)
    {
        self waittill( "trigger_enter",  var_1  );

        while ( anythingtouchingtrigger( self ) )
        {
            var_2 = 0;

            foreach ( var_4 in self._ID33167 )
            {
                if ( isdefined( var_4._ID10247 ) && var_4._ID10247 > var_2 )
                    var_2 = var_4._ID10247;
            }

            if ( var_2 > 6.0 )
            {
                var_0 playsound( "dyn_anml_dog_bark" );
                wait(randomfloatrange( 16 / var_2, 16 / var_2 + randomfloat( 1.0 ) ));
                continue;
            }

            wait 0.05;
        }
    }
}

trigger_door()
{
    var_0 = getent( self.target, "targetname" );
    self._ID10732 = var_0;
    self.doorangle = _ID15462( vectornormalize( self getorigin() - var_0 getorigin() ) );
    var_0.baseyaw = var_0.angles[1];
    var_1 = 1.0;

    for (;;)
    {
        self waittill( "trigger_enter",  var_2  );
        var_0 thread _ID10743( var_1, getdoorside( var_2 ) );

        if ( anythingtouchingtrigger( self ) )
            self waittill( "trigger_empty" );

        wait 3.0;

        if ( anythingtouchingtrigger( self ) )
            self waittill( "trigger_empty" );

        var_0 thread doorclose( var_1 );
    }
}

_ID10743( var_0, var_1 )
{
    if ( var_1 )
        self rotateto( ( 0, self.baseyaw + 90, 1 ), var_0, 0.1, 0.75 );
    else
        self rotateto( ( 0, self.baseyaw - 90, 1 ), var_0, 0.1, 0.75 );

    self playsound( "door_generic_house_open" );
    wait(var_0 + 0.05);
}

doorclose( var_0 )
{
    self rotateto( ( 0, self.baseyaw, 1 ), var_0 );
    self playsound( "door_generic_house_close" );
    wait(var_0 + 0.05);
}

getdoorside( var_0 )
{
    return vectordot( self.doorangle, vectornormalize( var_0.origin - self._ID10732 getorigin() ) ) > 0;
}

_ID15462( var_0 )
{
    return ( var_0[1], 0 - var_0[0], var_0[2] );
}

_ID34719()
{
    if ( self.classname != "trigger_use_touch" )
        return;

    var_0 = getentarray( self.target, "targetname" );
    self._ID19983 = 1;

    foreach ( var_2 in var_0 )
        var_2 setlightintensity( 1.5 * self._ID19983 );

    for (;;)
    {
        self waittill( "trigger" );
        self._ID19983 = !self._ID19983;

        if ( self._ID19983 )
        {
            foreach ( var_2 in var_0 )
                var_2 setlightintensity( 1.5 );

            self playsound( "switch_auto_lights_on" );
            continue;
        }

        foreach ( var_2 in var_0 )
            var_2 setlightintensity( 0 );

        self playsound( "switch_auto_lights_off" );
    }
}

bird_startle()
{

}

photo_copier_init( var_0 )
{
    self.copier = get_photo_copier( var_0 );
    var_1 = getent( self.copier.target, "targetname" );
    var_2 = getent( var_1.target, "targetname" );
    var_2.intensity = var_2 getlightintensity();
    var_2 setlightintensity( 0 );
    var_0.copy_bar = var_1;
    var_0._ID31356 = var_1.origin;
    var_0.light = var_2;
    var_3 = self.copier.angles + ( 0, 90, 0 );
    var_4 = anglestoforward( var_3 );
    var_0._ID11571 = var_0._ID31356 + var_4 * 30;
}

get_photo_copier( var_0 )
{
    if ( !isdefined( var_0.target ) )
    {
        var_1 = getentarray( "destructible_toy", "targetname" );
        var_2 = var_1[0];

        foreach ( var_4 in var_1 )
        {
            if ( isdefined( var_4.destructible_type ) && var_4.destructible_type == "toy_copier" )
            {
                if ( distance( var_0.origin, var_2.origin ) > distance( var_0.origin, var_4.origin ) )
                    var_2 = var_4;
            }
        }
    }
    else
    {
        var_2 = getent( var_0.target, "targetname" );
        var_2 setcandamage( 1 );
    }

    return var_2;
}

_ID35649()
{
    self.copier endon( "FX_State_Change0" );
    self.copier endon( "death" );
    self waittill( "trigger_enter" );
}

photo_copier()
{
    level endon( "game_ended" );
    photo_copier_init( self );
    self.copier endon( "FX_State_Change0" );
    thread _ID23511();

    for (;;)
    {
        _ID35649();
        self playsound( "mach_copier_run" );

        if ( isdefined( self.copy_bar ) )
        {
            _ID26082( self );
            thread _ID23507();
            thread _ID23509();
        }

        wait 3;
    }
}

_ID23510()
{
    level endon( "game_ended" );
    self endon( "death" );

    if ( common_scripts\utility::_ID14794() == "hamburg" )
        return;

    self.copier = get_photo_copier( self );
    self.copier endon( "FX_State_Change0" );

    for (;;)
    {
        _ID35649();
        self playsound( "mach_copier_run" );
        wait 3;
    }
}

_ID26082( var_0 )
{
    var_0.copy_bar moveto( var_0._ID31356, 0.2 );
    var_0.light setlightintensity( 0 );
}

_ID23507()
{
    self.copier notify( "bar_goes" );
    self.copier endon( "bar_goes" );
    self.copier endon( "FX_State_Change0" );
    self.copier endon( "death" );
    var_0 = self.copy_bar;
    wait 2.0;
    var_0 moveto( self._ID11571, 1.6 );
    wait 1.8;
    var_0 moveto( self._ID31356, 1.6 );
    wait 1.6;
    var_1 = self.light;
    var_2 = 0.2;
    var_3 = var_2 / 0.05;

    for ( var_4 = 0; var_4 < var_3; var_4++ )
    {
        var_5 = var_4 * 0.05;
        var_5 /= var_2;
        var_5 = 1 - var_5 * var_1.intensity;

        if ( var_5 > 0 )
            var_1 setlightintensity( var_5 );

        wait 0.05;
    }
}

_ID23509()
{
    self.copier notify( "light_on" );
    self.copier endon( "light_on" );
    self.copier endon( "FX_State_Change0" );
    self.copier endon( "death" );
    var_0 = self.light;
    var_1 = 0.2;
    var_2 = var_1 / 0.05;

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = var_3 * 0.05;
        var_4 /= var_1;
        var_0 setlightintensity( var_4 * var_0.intensity );
        wait 0.05;
    }

    photo_light_flicker( var_0 );
}

_ID23511()
{
    self.copier waittill( "FX_State_Change0" );
    self.copier endon( "death" );
    _ID26082( self );
}

photo_light_flicker( var_0 )
{
    var_0 setlightintensity( 1 );
    wait 0.05;
    var_0 setlightintensity( 0 );
    wait 0.1;
    var_0 setlightintensity( 1 );
    wait 0.05;
    var_0 setlightintensity( 0 );
    wait 0.1;
    var_0 setlightintensity( 1 );
}

_ID12760( var_0 )
{
    var_1 = 0;
    var_2 = 20000;
    var_3 = 1.0;

    if ( isdefined( self.speed ) )
        var_3 = self.speed;

    if ( var_0 == "slow" )
    {
        if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "lockedspeed" )
            var_1 = 180;
        else
            var_1 = randomfloatrange( 100 * var_3, 360 * var_3 );
    }
    else if ( var_0 == "fast" )
        var_1 = randomfloatrange( 720 * var_3, 1000 * var_3 );
    else if ( var_0 == "veryslow" )
        var_1 = randomfloatrange( 1 * var_3, 2 * var_3 );
    else
    {

    }

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "lockedspeed" )
        wait 0;
    else
        wait(randomfloatrange( 0, 1 ));

    var_4 = self.angles;
    var_5 = anglestoright( self.angles ) * 100;
    var_5 = vectornormalize( var_5 );

    for (;;)
    {
        var_6 = abs( vectordot( var_5, ( 1, 0, 0 ) ) );
        var_7 = abs( vectordot( var_5, ( 0, 1, 0 ) ) );
        var_8 = abs( vectordot( var_5, ( 0, 0, 1 ) ) );

        if ( var_6 > 0.9 )
            self rotatevelocity( ( var_1, 0, 0 ), var_2 );
        else if ( var_7 > 0.9 )
            self rotatevelocity( ( var_1, 0, 0 ), var_2 );
        else if ( var_8 > 0.9 )
            self rotatevelocity( ( 0, var_1, 0 ), var_2 );
        else
            self rotatevelocity( ( 0, var_1, 0 ), var_2 );

        wait(var_2);
    }
}

_ID33725( var_0, var_1 )
{
    level endon( "game_ended" );
    self.entnum = self getentitynumber();

    for (;;)
    {
        self waittill( "trigger",  var_2  );

        if ( !isplayer( var_2 ) && !isdefined( var_2.finished_spawning ) )
            continue;

        if ( !isalive( var_2 ) )
            continue;

        if ( !isdefined( var_2._ID33168[self.entnum] ) )
            var_2 thread _ID24551( self, var_0, var_1 );
    }
}

_ID24551( var_0, var_1, var_2 )
{
    if ( !isplayer( self ) )
        self endon( "death" );

    if ( !common_scripts\utility::_ID18787() )
        var_3 = self._ID15851;
    else
        var_3 = "player" + gettime();

    var_0._ID33167[var_3] = self;

    if ( isdefined( var_0._ID21697 ) )
        self._ID21698++;

    var_0 notify( "trigger_enter",  self  );
    self notify( "trigger_enter",  var_0  );

    if ( isdefined( var_1 ) )
        self thread [[ var_1 ]]( var_0 );

    self._ID33168[var_0.entnum] = var_0;

    while ( isalive( self ) && self istouching( var_0 ) && ( common_scripts\utility::_ID18787() || !level.gameended ) )
        wait 0.05;

    if ( isdefined( self ) )
    {
        self._ID33168[var_0.entnum] = undefined;

        if ( isdefined( var_0._ID21697 ) )
            self._ID21698--;

        self notify( "trigger_leave",  var_0  );

        if ( isdefined( var_2 ) )
            self thread [[ var_2 ]]( var_0 );
    }

    if ( !common_scripts\utility::_ID18787() && level.gameended )
        return;

    var_0._ID33167[var_3] = undefined;
    var_0 notify( "trigger_leave",  self  );

    if ( !anythingtouchingtrigger( var_0 ) )
        var_0 notify( "trigger_empty" );
}

_ID21642()
{
    if ( isdefined( level.disablemovementtracker ) )
        return;

    self endon( "disconnect" );

    if ( !isplayer( self ) )
        self endon( "death" );

    self._ID21698 = 0;
    self._ID10247 = 0;

    for (;;)
    {
        self waittill( "trigger_enter" );
        var_0 = self.origin;

        while ( self._ID21698 )
        {
            self._ID10247 = distance( var_0, self.origin );
            var_0 = self.origin;
            wait 0.05;
        }

        self._ID10247 = 0;
    }
}

anythingtouchingtrigger( var_0 )
{
    return var_0._ID33167.size;
}

_ID24550( var_0, var_1 )
{
    return isdefined( var_0._ID33168[var_1.entnum] );
}

interactive_tv()
{
    var_0 = getentarray( "interactive_tv", "targetname" );

    if ( var_0.size )
    {
        common_scripts\utility::_ID22146( [ "com_tv2_d", "com_tv1_d", "com_tv1", "com_tv2", "com_tv1_testpattern", "com_tv2_testpattern" ], ::precachemodel );
        level._ID6083["tv_explode"] = loadfx( "fx/explosions/tv_explosion" );
    }

    level._ID34113 = getentarray( "interactive_tv_light", "targetname" );
    common_scripts\utility::_ID3867( getentarray( "interactive_tv", "targetname" ), ::_ID34114 );
}

_ID34114()
{
    self setcandamage( 1 );
    self._ID8977 = undefined;
    self._ID22627 = undefined;
    self._ID8977 = "com_tv2_d";
    self._ID22627 = "com_tv2";
    self._ID22867 = "com_tv2_testpattern";

    if ( issubstr( self.model, "1" ) )
    {
        self._ID22627 = "com_tv1";
        self._ID22867 = "com_tv1_testpattern";
    }

    if ( isdefined( self.target ) )
    {
        if ( isdefined( level._ID10094 ) )
        {
            var_0 = getent( self.target, "targetname" );

            if ( isdefined( var_0 ) )
                var_0 delete();
        }
        else
        {
            self._ID34781 = getent( self.target, "targetname" );
            self._ID34781 usetriggerrequirelookat();
            self._ID34781 setcursorhint( "HINT_NOICON" );
        }
    }

    var_1 = common_scripts\utility::_ID14293( self.origin, level._ID34113, undefined, undefined, 64 );

    if ( var_1.size )
    {
        self._ID20072 = var_1[0];
        level._ID34113 = common_scripts\utility::array_remove( level._ID34113, self._ID20072 );
        self._ID20073 = self._ID20072 getlightintensity();
    }

    thread _ID34112();

    if ( isdefined( self._ID34781 ) )
        thread _ID34115();
}

_ID34115()
{
    self._ID34781 endon( "death" );

    for (;;)
    {
        wait 0.2;
        self._ID34781 waittill( "trigger" );
        self notify( "off" );

        if ( self.model == self._ID22627 )
        {
            self setmodel( self._ID22867 );

            if ( isdefined( self._ID20072 ) )
                self._ID20072 setlightintensity( self._ID20073 );

            continue;
        }

        self setmodel( self._ID22627 );

        if ( isdefined( self._ID20072 ) )
            self._ID20072 setlightintensity( 0 );
    }
}

_ID34112()
{
    self waittill( "damage",  var_0, var_1, var_2, var_3, var_4  );
    self notify( "off" );

    if ( isdefined( self._ID34781 ) )
        self._ID34781 notify( "death" );

    self setmodel( self._ID8977 );

    if ( isdefined( self._ID20072 ) )
        self._ID20072 setlightintensity( 0 );

    playfxontag( level._ID6083["tv_explode"], self, "tag_fx" );
    self playsound( "tv_shot_burst" );

    if ( isdefined( self._ID34781 ) )
        self._ID34781 delete();
}
