// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

gas_station()
{
    gas_station_precache();
    common_scripts\utility::_ID13189( "gas_station_exploded" );
    common_scripts\utility::_ID13189( "breach_connect_nodes" );
    wait 0.05;
    var_0 = common_scripts\utility::_ID15386( "gas", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::_ID14156 );
}
#using_animtree("animated_props");

_ID14156()
{
    var_0 = getentarray( self.target, "targetname" );
    var_1 = common_scripts\utility::_ID15386( self.target, "targetname" );
    var_0 = common_scripts\utility::array_combine( var_0, var_1 );
    var_2 = maps\mp\_utility::getlinknamenodes();
    var_3 = common_scripts\utility::array_combine( var_0, var_2 );
    self.clip_up = [];
    self.clip_down = [];
    self._ID19682 = [];
    self.linked_ents = [];

    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
        return;

    foreach ( var_5 in var_3 )
    {
        if ( !isdefined( var_5.script_noteworthy ) )
            continue;

        if ( !isdefined( var_5._ID27766 ) )
            var_5._ID27766 = "corner1_hit";

        switch ( var_5.script_noteworthy )
        {
            case "clip_up":
                self.clip_up[self.clip_up.size] = var_5;
                self.linked_ents[self.linked_ents.size] = var_5;
                continue;
            case "clip_down_traverse":
                var_5.nodisconnect = 1;
            case "clip_down":
                self.clip_down[self.clip_down.size] = var_5;
                var_5 setaisightlinevisible( 0 );
                var_5 connectpaths();
                var_5 common_scripts\utility::_ID33657();
                continue;
            case "link_to_launch":
                thread gas_station_run_func_on_notify( var_5._ID27766, ::_ID14157, var_5 );
                self._ID19682[self._ID19682.size] = var_5;
            case "link_to":
                self.linked_ents[self.linked_ents.size] = var_5;
                continue;
            case "fx":
                thread gas_station_run_func_on_notify( var_5._ID27766, ::gas_station_play_fx, var_5 );
                continue;
            case "animated":
                self.animated_model = var_5;
                continue;
            case "earthquake":
                thread gas_station_run_func_on_notify( var_5._ID27766, ::gas_station_earthquake, var_5 );
                continue;
            case "sound":
                thread gas_station_run_func_on_notify( var_5._ID27766, ::_ID14159, var_5 );
                continue;
            case "connect_node":
                var_5 disconnectnode();
                thread gas_station_run_func_on_notify( var_5._ID27766, ::gas_station_connect_node, var_5 );
                continue;
            case "disconnect_node":
                thread gas_station_run_func_on_notify( var_5._ID27766, ::gas_station_disconnect_node, var_5 );
                continue;
            case "prone_kill_trigger":
                self.prone_kill_trigger = var_5;
                var_5 common_scripts\utility::_ID33657();
                continue;
            case "killcam":
                self._ID19214 = spawn( "script_model", var_5.origin );
                self._ID19214 setmodel( "tag_origin" );
                continue;
            default:
                continue;
        }
    }

    if ( isdefined( self.animated_model ) )
    {
        foreach ( var_8 in self.linked_ents )
            var_8 linkto( self.animated_model, "j_awning_main" );
    }

    thread care_package_watch();
    var_10 = getscriptablearray( "gaspump", "targetname" );
    level._ID19482 = undefined;
    level._ID24459 = undefined;

    foreach ( var_12 in var_10 )
    {
        var_12 thread _ID14149( self );
        var_12 thread _ID22280( self, var_10 );
    }

    self waittill( "gas_station_explode",  var_14  );
    common_scripts\utility::flag_set( "gas_station_exploded" );

    foreach ( var_16 in level.players )
        var_16._ID24897 = 1;

    foreach ( var_12 in var_10 )
    {
        if ( var_12 == var_14 )
            continue;

        if ( isdefined( level._ID24459 ) )
        {
            var_12.attacker = level._ID24459;

            if ( isdefined( level._ID24459.team ) )
                var_12.team = level._ID24459.team;
        }

        if ( isdefined( var_12.attacker ) )
            var_12 setscriptabledamageowner( var_12.attacker );

        var_12 setscriptablepartstate( 0, "destroyed" );
    }

    var_20 = getanimlength( %mp_dart_gas_awning_fall );
    self.gas_station_events = [];
    _ID14151( "start", 0.0 );
    _ID14151( "beam_break", 0.1 );
    _ID14151( "corner1_hit", 1.9 );
    _ID14151( "corner2_hit", 2.15 );
    _ID14151( "sign_hit", 2.5 );
    _ID14151( "end", var_20 );
    thread gas_station_run_func_on_notify( "corner1_hit", ::gas_station_update_clip );
    thread _ID14161();

    if ( isdefined( self.animated_model ) )
    {
        self.animated_model scriptmodelplayanimdeltamotion( "mp_dart_gas_awning_fall" );
        common_scripts\utility::exploder( 22 );
        var_21 = getentarray( "gas_pump_fire_sound_origin", "targetname" );

        foreach ( var_23 in var_21 )
            var_23 playloopsound( "emt_dart_fire_small_ext_lp" );

        return;
    }
}

gas_station_run_func_on_notify( var_0, var_1, var_2 )
{
    self waittill( var_0 );

    if ( isdefined( var_2 ) )
    {
        self thread [[ var_1 ]]( var_2 );
        return;
    }

    self thread [[ var_1 ]]();
    return;
}

gas_station_update_clip()
{
    var_0 = common_scripts\utility::_ID15384( "gas_station_killcam", "targetname" );

    foreach ( var_2 in self.clip_up )
    {
        var_2 setaisightlinevisible( 0 );
        var_2 delete();
    }

    foreach ( var_2 in self.clip_down )
    {
        var_2 setaisightlinevisible( 1 );
        var_2._ID34249 = maps\mp\_movers::_ID34255;
        var_2 common_scripts\utility::_ID33659();

        if ( !isdefined( var_2.nodisconnect ) || !var_2.nodisconnect )
            var_2 disconnectpaths();

        foreach ( var_6 in level.characters )
        {
            if ( var_6 istouching( var_2 ) && isalive( var_6 ) )
            {
                if ( isdefined( self.attacker ) && isdefined( self.attacker.team ) && self.attacker.team == var_6.team )
                {
                    var_6 maps\mp\_movers::mover_suicide();
                    continue;
                }

                var_2._ID19214 = self._ID19214;

                if ( isdefined( level._ID24459 ) )
                {
                    var_6 dodamage( var_6.health + 10000, var_6.origin, level._ID24459, var_2, "MOD_EXPLOSIVE" );
                    continue;
                }

                var_6 dodamage( var_6.health + 10000, var_6.origin, self.attacker, var_2, "MOD_EXPLOSIVE" );
            }
        }

        foreach ( var_9 in level._ID25810 )
        {
            if ( var_9 istouching( var_2 ) )
                var_9 notify( "death" );
        }
    }

    if ( isdefined( self.prone_kill_trigger ) )
    {
        self.prone_kill_trigger common_scripts\utility::_ID33659();

        foreach ( var_6 in level.characters )
        {
            if ( var_6 istouching( self.prone_kill_trigger ) && isalive( var_6 ) )
            {
                if ( isdefined( self.attacker ) && isdefined( self.attacker.team ) && self.attacker.team == var_6.team )
                {
                    var_6 maps\mp\_movers::mover_suicide();
                    continue;
                }

                self.prone_kill_trigger._ID19214 = self._ID19214;

                if ( isdefined( level._ID24459 ) )
                {
                    var_6 dodamage( var_6.health + 20, var_6.origin, level._ID24459, self.prone_kill_trigger, "MOD_EXPLOSIVE" );
                    continue;
                }

                var_6 dodamage( var_6.health + 20, var_6.origin, self.attacker, self.prone_kill_trigger, "MOD_EXPLOSIVE" );
            }
        }

        wait 10;
        self.prone_kill_trigger delete();
        return;
    }
}

_ID14157( var_0 )
{
    var_1 = self.animated_model gettagangles( "j_awning_main" );
    var_2 = anglestoup( var_1 );
    var_0 unlink();
    var_3 = ( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), 0 );
    var_0 physicslaunchclient( var_0.origin + var_3, var_2 * 15000 );
}

gas_station_play_fx( var_0 )
{
    if ( !isdefined( var_0._ID27611 ) || !isdefined( level._ID1644[var_0._ID27611] ) )
        return;

    playfx( level._ID1644[var_0._ID27611], var_0.origin, anglestoforward( var_0.angles ) );
}

gas_station_earthquake( var_0 )
{
    earthquake( 0.3, 0.5, var_0.origin, 800 );
}

_ID14159( var_0 )
{
    if ( !isdefined( var_0._ID27818 ) )
        return;

    playsoundatpos( var_0.origin, var_0._ID27818 );
}

gas_station_connect_node( var_0 )
{
    var_0 connectnode();
}

gas_station_disconnect_node( var_0 )
{
    var_0 disconnectnode();
}

_ID14161()
{
    var_0 = gettime();

    for (;;)
    {
        foreach ( var_2 in self.gas_station_events )
        {
            if ( var_2.done )
                continue;

            if ( ( gettime() - var_0 ) / 1000 >= var_2._ID33037 )
            {
                self notify( var_2._ID22159 );
                var_2.done = 1;

                if ( var_2._ID22159 == "end" )
                    return;
            }
        }

        wait 0.05;
    }
}

_ID14151( var_0, var_1 )
{
    if ( !isdefined( self.gas_station_events ) )
        self.gas_station_events = [];

    var_2 = spawnstruct();
    var_2._ID33037 = var_1;
    var_2._ID22159 = var_0;
    var_2.done = 0;
    self.gas_station_events[self.gas_station_events.size] = var_2;
}

gas_station_precache()
{
    precachempanim( "mp_dart_gas_awning_fall" );
}

_ID14149( var_0 )
{
    var_0 endon( "gas_station_explode" );
    self._ID19214 = var_0._ID19214;

    for (;;)
    {
        self waittill( "damage",  var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10  );

        if ( isplayer( var_2 ) || isagent( var_2 ) )
        {
            if ( isagent( var_2 ) && isdefined( var_2.owner ) )
                var_2 = var_2.owner;

            level._ID19482 = var_2;
            self setscriptabledamageowner( var_2 );
        }
    }
}

_ID22280( var_0, var_1 )
{
    self waittill( "death",  var_2, var_3, var_4  );

    if ( !isdefined( level._ID24459 ) )
    {
        if ( isplayer( var_2 ) || isagent( var_2 ) )
        {
            if ( isagent( var_2 ) && isdefined( var_2.owner ) )
                var_2 = var_2.owner;

            level._ID24459 = var_2;
        }
        else if ( isdefined( level._ID19482 ) )
            level._ID24459 = level._ID19482;

        self setscriptabledamageowner( level._ID24459 );
    }

    self.attacker = level._ID24459;
    var_0.attacker = level._ID24459;

    if ( isdefined( level._ID24459.team ) )
    {
        self.team = level._ID24459.team;
        var_0.team = level._ID24459.team;
    }

    var_0 notify( "gas_station_explode",  self  );
}

broken_walls()
{
    var_0 = common_scripts\utility::_ID15386( "broken_wall", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::broken_wall_init );
}

broken_wall_init( var_0 )
{
    self._ID33686 = [];
    self.delete_ents = [];
    self._ID29919 = [];
    self.trigger_damage = [];
    var_1 = getentarray( self.target, "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3.script_noteworthy ) )
            var_3.script_noteworthy = var_3.classname;

        switch ( var_3.script_noteworthy )
        {
            case "delete":
                self.delete_ents[self.delete_ents.size] = var_3;
                continue;
            case "trigger_damage":
                self.trigger_damage[self.trigger_damage.size] = var_3;
                thread _ID6128( var_3 );
                continue;
            case "show":
                var_3 hide();
                self._ID29919[self._ID29919.size] = var_3;
                continue;
            case "trigger_show":
                var_3 common_scripts\utility::_ID33657();
                self._ID33686[self._ID33686.size] = var_3;
                continue;
            case "trigger_use_touch":
                var_3 usetriggerrequirelookat();
                var_3.script_noteworthy = "trigger_use";
                continue;
            default:
                continue;
        }
    }
}

_ID6128( var_0, var_1 )
{
    self endon( "break_wall" );
    var_0 waittill( "trigger" );
    common_scripts\utility::_ID3867( self._ID29919, ::broken_wall_show );
    common_scripts\utility::array_call( self.trigger_damage, ::delete );
    common_scripts\utility::_ID3867( self.delete_ents, ::broken_wall_delete );
    common_scripts\utility::_ID3867( self._ID33686, common_scripts\utility::_ID33659 );
    self notify( "break_wall" );
}

broken_wall_delete()
{
    if ( isdefined( self._ID27651 ) )
        common_scripts\utility::exploder( self._ID27651 );

    self setaisightlinevisible( 0 );
    self delete();
}

broken_wall_show()
{
    self setaisightlinevisible( 1 );
    self show();
}

_ID5917()
{
    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
        return;

    maps\mp\_breach::breach_precache();
    dart_breach_precache();
    _ID8994();
    common_scripts\utility::_ID35582();
    var_0 = common_scripts\utility::_ID15386( "breach", "targetname" );
    var_1 = common_scripts\utility::_ID15386( "breach_proxy", "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3.target ) )
            continue;

        var_4 = common_scripts\utility::_ID15384( var_3.target, "targetname" );

        if ( !isdefined( var_4 ) )
            continue;

        var_4 = setextrabreachexceptions( var_4 );
        var_0[var_0.size] = var_4;
    }

    common_scripts\utility::_ID3867( var_0, ::breach_init );
    common_scripts\utility::_ID3867( var_0, maps\mp\_breach::breach_init );
}

setextrabreachexceptions( var_0 )
{
    if ( !isdefined( var_0.script_noteworthy ) )
        return var_0;

    if ( level._ID14086 == "siege" )
        var_0.script_noteworthy = var_0.script_noteworthy + "," + "not_in_siege";

    return var_0;
}

dart_breach_precache()
{
    precachempanim( "mp_dart_container_breach_side1" );
    precachempanim( "mp_dart_container_breach_side2" );
    precachempanim( "mp_dart_container_breach_top" );
    precachempanim( "mp_dart_container_idle_side1" );
    precachempanim( "mp_dart_container_idle_side2" );
    precachempanim( "mp_dart_container_idle_top" );
}

_ID8994()
{
    level._ID5927 = [];
    level._ID5927["mp_dart_container_breach_side1"] = "mp_dart_container_breach_side1";
    level._ID5927["mp_dart_container_breach_side1_idle"] = "mp_dart_container_idle_side1";
    level._ID5927["mp_dart_container_breach_side2"] = "mp_dart_container_breach_side2";
    level._ID5927["mp_dart_container_breach_side2_idle"] = "mp_dart_container_idle_side2";
    level._ID5927["mp_dart_container_breach_top"] = "mp_dart_container_breach_top";
    level._ID5927["mp_dart_container_breach_top_idle"] = "mp_dart_container_idle_top";
}

breach_init()
{
    self.animated_doors = [];
    self._ID6707 = [];
    self.delete_ents = [];
    self._ID10745 = [];
    self.notsolid_ents = [];
    self._ID30395 = [];
    var_0 = getentarray( self.target, "targetname" );
    var_1 = common_scripts\utility::_ID15386( self.target, "targetname" );
    var_2 = common_scripts\utility::array_combine( var_1, var_0 );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4.classname ) && var_4.classname == "trigger_use_touch" )
            maps\mp\_utility::add_to_bot_use_targets( var_4, 1.5 );

        if ( !isdefined( var_4.script_noteworthy ) )
            continue;

        switch ( var_4.script_noteworthy )
        {
            case "door":
                self._ID10745[self._ID10745.size] = var_4;
                breach_door_init( var_4 );
                continue;
            case "triggers_with":
                if ( isdefined( var_4.target ) )
                {
                    var_5 = common_scripts\utility::_ID15384( var_4.target, "targetname" );

                    if ( isdefined( var_5 ) )
                        thread breach_other_watch( var_5 );
                }

                continue;
            case "care_package":
                self._ID6707[self._ID6707.size] = var_4;
                continue;
            case "animated_door":
                var_6 = getent( var_4.target, "targetname" );
                self.animated_doors[self.animated_doors.size] = var_6;
                breach_animated_door_init( var_6 );
                continue;
            default:
                continue;
        }
    }

    foreach ( var_6 in self._ID10745 )
        thread _ID5935( var_6 );

    thread breach_open_watch();
}

add_care_package( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_5 ) )
    {
        var_5 = "airdrop_assault";

        if ( isdefined( var_4 ) )
        {
            var_6 = [ "airdrop_assault", "airdrop_support" ];

            foreach ( var_8 in var_6 )
            {
                if ( _ID18514( var_8, var_4 ) )
                {
                    var_5 = var_8;
                    break;
                }
            }
        }
    }

    if ( !_ID18516( var_5 ) )
        return;

    if ( !isdefined( var_4 ) )
        var_4 = common_scripts\utility::_ID25350( getarraykeys( level.cratetypes[var_5] ) );

    if ( !_ID18514( var_5, var_4 ) )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = ( 0, 0, 0 );

    var_10 = spawn( "script_model", var_0 );
    var_10 setmodel( maps\mp\killstreaks\_airdrop::get_friendly_crate_model() );
    var_10.angles = var_1;
    var_10.cratetype = var_4;
    var_10.owner = var_2;

    if ( isdefined( var_3 ) )
        var_10.team = var_3;
    else
        var_10.team = var_2.team;

    var_10.targetname = "care_package";
    var_10.droppingtoground = 0;
    var_10._ID17334 = "care_package";
    var_10 clonebrushmodeltoscriptmodel( level.airdropcratecollision );
    var_10 thread common_scripts\utility::entity_path_disconnect_thread( 1.0 );
    var_10 physicslaunchserver( ( 0, 0, 0 ), ( 0, 0, 1 ) );
    var_10 thread [[ level.cratetypes[var_5][var_4].func ]]( var_5 );

    if ( isbot( var_2 ) )
    {
        wait 0.1;
        var_2 notify( "new_crate_to_take" );
        return;
    }
}

_ID18516( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    foreach ( var_3, var_2 in level.cratetypes )
    {
        if ( var_3 == var_0 )
            return 1;
    }

    return 0;
}

_ID18514( var_0, var_1 )
{
    if ( !_ID18516( var_0 ) )
        return 0;

    if ( !isdefined( var_1 ) )
        return 0;

    foreach ( var_4, var_3 in level.cratetypes[var_0] )
    {
        if ( var_4 == var_1 )
            return 1;
    }

    return 0;
}

breach_animated_door_init( var_0 )
{
    var_1 = self;

    if ( isdefined( level._ID5927[var_0.script_noteworthy + "_idle"] ) )
        var_0 scriptmodelplayanimdeltamotion( level._ID5927[var_0.script_noteworthy + "_idle"] );

    var_0 thread clear_attached_items( var_1 );
}

clear_attached_items( var_0 )
{
    var_0 waittill( "breach_activated" );
    maps\mp\_movers::notify_moving_platform_invalid();
}

breach_door_init( var_0 )
{
    var_1 = getentarray( var_0.target, "targetname" );
    var_2 = common_scripts\utility::_ID15386( var_0.target, "targetname" );
    var_3 = common_scripts\utility::array_combine( var_2, var_1 );
    var_4 = [];
    var_5 = undefined;

    foreach ( var_7 in var_3 )
    {
        if ( !isdefined( var_7.script_noteworthy ) )
            continue;

        switch ( var_7.script_noteworthy )
        {
            case "open":
                var_0._ID22944 = var_7;
                continue;
            case "closed":
                var_0.closed_pos = var_7;
                continue;
            case "door_part":
                var_4[var_4.size] = var_7;
                continue;
            case "pivot":
                var_5 = var_7;
                continue;
            default:
                continue;
        }
    }

    if ( !isdefined( var_0._ID22944 ) || !isdefined( var_0.closed_pos ) || !isdefined( var_5 ) || var_4.size == 0 )
        return 0;

    var_0.closed_pos.move_angles = _ID14732( var_0._ID22944.angles, var_0.closed_pos.angles, var_5.angles );
    var_0._ID22944.move_angles = -1 * var_0.closed_pos.move_angles;
    var_9 = spawn( "script_model", var_5.origin );
    var_9 setmodel( "tag_origin" );
    var_9.angles = var_5.angles;

    foreach ( var_11 in var_4 )
        var_11 linkto( var_9 );

    var_0._ID20009 = var_9;
    return 1;
}

breach_other_watch( var_0 )
{
    var_0 waittill( "breach_activated",  var_1, var_2, var_3  );
    self notify( "breach_activated",  var_1, var_2, var_3  );
}

breach_open_watch()
{
    self waittill( "breach_activated",  var_0, var_1, var_2  );
    var_3 = getentarray( self.target, "targetname" );

    foreach ( var_5 in var_3 )
    {
        if ( isdefined( var_5.classname ) && var_5.classname == "trigger_use_touch" )
            maps\mp\_utility::_ID25898( var_5 );
    }

    if ( isdefined( var_0 ) && !maps\mp\_utility::_ID37547() )
    {
        foreach ( var_8 in self._ID6707 )
        {
            var_9 = common_scripts\utility::_ID25350( [ "uplink_support", "deployable_vest", "deployable_ammo", "ball_drone_radar", "aa_launcher", "jammer", "ims" ] );
            add_care_package( var_8.origin, var_8.angles, var_0, var_2, var_9 );
        }
    }

    var_11 = 0.2;

    foreach ( var_13 in self._ID10745 )
        thread breach_open_door( var_13, var_11 );

    foreach ( var_16 in self.animated_doors )
    {
        var_16 scriptmodelplayanimdeltamotion( level._ID5927[var_16.script_noteworthy] );

        switch ( var_16.script_noteworthy )
        {
            case "mp_dart_container_breach_side1":
                playsoundatpos( var_16.origin, "scn_dart_trailer_breach_side" );
                continue;
            case "mp_dart_container_breach_side2":
                playsoundatpos( var_16.origin, "scn_dart_trailer_breach_side" );
                continue;
            case "mp_dart_container_breach_top":
                playsoundatpos( var_16.origin, "scn_dart_trailer_breach_top" );
                continue;
            default:
                continue;
        }
    }

    wait(var_11);
    common_scripts\utility::array_call( self.notsolid_ents, ::notsolid );
    common_scripts\utility::array_call( self.delete_ents, ::delete );
    common_scripts\utility::array_call( self._ID30395, ::solid );

    foreach ( var_19 in self._ID30395 )
    {
        var_19 solid();

        if ( isdefined( level.players ) )
        {
            foreach ( var_0 in level.players )
            {
                if ( var_0 istouching( var_19 ) )
                    thread _ID6000( var_0 );
            }
        }
    }

    common_scripts\utility::flag_set( "breach_connect_nodes" );
}

_ID6000( var_0 )
{
    radiusdamage( var_0.origin, 8, 1000, 1000, self.owner, "MOD_CRUSH" );
}

breach_open_door( var_0, var_1 )
{
    _ID6003( var_0, var_0._ID22944, var_1 );
}

_ID5935( var_0, var_1 )
{
    _ID6003( var_0, var_0.closed_pos, var_1 );
}

_ID6003( var_0, var_1, var_2 )
{
    var_3 = var_1.angles;
    var_4 = var_1.origin;

    if ( isdefined( var_2 ) && var_2 > 0 )
    {
        if ( isdefined( var_3 ) && var_3 != var_0._ID20009.angles )
            var_0._ID20009 rotateby( var_1.move_angles, var_2, var_2 );

        if ( isdefined( var_4 ) && var_4 != var_0._ID20009.origin )
        {
            var_0._ID20009 moveto( var_4, var_2 );
            return;
        }

        return;
    }

    if ( isdefined( var_3 ) )
        var_0._ID20009.angles = var_3;

    if ( isdefined( var_4 ) )
    {
        var_0._ID20009.origin = var_4;
        return;
    }

    return;
}

_ID18413( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    var_0 = tolower( var_0 );

    switch ( var_0 )
    {
        case "splash":
        case "mod_grenade_splash":
        case "mod_projectile_splash":
        case "mod_explosive":
            return 1;
        default:
            return 0;
    }

    return 0;
}

_ID22139( var_0 )
{
    return ( angleclamp180( var_0[0] ), angleclamp180( var_0[1] ), angleclamp180( var_0[2] ) );
}

_ID14732( var_0, var_1, var_2 )
{
    var_3 = var_1 - var_0;
    var_3 = _ID22139( var_3 );

    if ( isdefined( var_2 ) )
    {
        var_4 = var_2 - var_0;
        var_4 = _ID22139( var_4 );

        for ( var_5 = 0; var_5 < 3; var_5++ )
        {
            if ( var_4[var_5] * var_3[var_5] < 0 )
            {
                var_6 = 360;

                if ( var_4[var_5] < 0 )
                    var_6 = -360;

                var_3 = ( var_3[0] + var_6 * ( var_5 == 0 ), var_3[1] + var_6 * ( var_5 == 1 ), var_3[2] + var_6 * ( var_5 == 2 ) );
            }
        }
    }

    return var_3;
}

ceiling_rubble()
{
    level thread ceiling_rubble_onplayerconnect();
    wait 0.05;

    if ( !isdefined( level._ID13971 ) )
        level._ID13971 = common_scripts\utility::_ID30774();

    var_0 = [];
    var_1 = getentarray( "fx_building_impact", "targetname" );
    level thread do_rubble( var_1 );
}

_ID35430()
{
    wait(randomfloatrange( 0.0, 0.4 ));
    triggerfx( self );
}

do_rubble( var_0 )
{
    for (;;)
    {
        level waittill( "do_rubble",  var_1  );

        foreach ( var_3 in var_0 )
        {
            if ( isdefined( var_3._ID27651 ) )
            {
                level._ID13971.origin = var_1;

                if ( level._ID13971 istouching( var_3 ) )
                {
                    if ( isdefined( var_3._ID27651 ) )
                    {
                        if ( !isdefined( var_3.playing_effect ) )
                            var_3.playing_effect = 0;

                        if ( var_3.playing_effect == 0 )
                        {
                            var_3.playing_effect = 1;
                            common_scripts\utility::exploder( var_3._ID27651 );
                            var_3 thread clear_volume_flag();
                        }
                    }
                }
            }
        }
    }
}

clear_volume_flag()
{
    wait 1.5;
    self.playing_effect = 0;
}

ceiling_rubble_onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread ceiling_rubble_watchusage( "missile_fire" );
        var_0 thread ceiling_rubble_watchusage( "grenade_fire" );
    }
}

ceiling_rubble_watchusage( var_0 )
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( var_0,  var_1, var_2  );

        if ( isdefined( var_2 ) )
        {
            switch ( var_2 )
            {
                case "flash_grenade_mp":
                case "smoke_grenade_mp":
                case "smoke_grenadejugg_mp":
                case "concussion_grenade_mp":
                case "ac130_25mm_mp":
                    continue;
                default:
                    break;
            }
        }

        var_1 thread ceiling_rubble_missile_explode_watch();
    }
}

_ID11744()
{
    self waittill( "death" );
    waittillframeend;
    self notify( "end_of_frame_death" );
}

ceiling_rubble_missile_explode_watch()
{
    thread _ID11744();
    self endon( "end_of_frame_death" );
    self waittill( "explode",  var_0  );
    level notify( "do_rubble",  var_0  );
}

_ID27955()
{
    while ( !isdefined( level.players ) || level.players.size == 0 )
        wait 0.05;

    var_0 = getallnodes();
    var_1 = common_scripts\utility::_ID25350( var_0 );
    var_2 = level.players[0];
    var_3 = spawn( "script_model", var_1.origin );
    var_3 setmodel( "com_deploy_ballistic_vest_friend_world" );

    for (;;)
    {
        var_4 = getnodesonpath( var_1.origin, var_2.origin );

        if ( !isdefined( var_4 ) || var_4.size == 0 )
        {
            wait 0.1;
            continue;
        }

        var_5 = var_4[0];

        if ( distance( var_3.origin, var_4[0].origin ) < 6 )
        {
            if ( var_4.size <= 1 )
            {
                wait 0.1;
                continue;
            }

            var_5 = var_4[1];
        }

        var_6 = var_5.origin - var_1.origin;
        var_7 = vectortoangles( var_6 );
        var_8 = 180;
        var_9 = length( var_6 );
        var_10 = var_9 / var_8;

        if ( var_10 <= 0 )
        {
            wait 0.1;
            continue;
        }

        var_3 rotateto( var_7, min( 0.5, var_10 ) );
        var_3 moveto( var_5.origin, var_10 );
        var_3 waittill( "movedone" );
        var_1 = var_5;
    }
}

_ID23981()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );

        if ( common_scripts\utility::_ID13177( "gas_station_exploded" ) )
            _ID16866();
    }
}

_ID16866()
{
    var_0 = common_scripts\utility::_ID15386( "gas", "targetname" );

    foreach ( var_2 in var_0 )
    {
        foreach ( var_4 in var_2._ID19682 )
        {
            var_4 hide();

            foreach ( var_6 in level.players )
            {
                if ( isdefined( var_6._ID24897 ) && var_6._ID24897 == 1 )
                    var_4 showtoplayer( var_6 );
            }
        }
    }
}

care_package_watch()
{
    self endon( "end" );
    var_0 = getent( "care_package_volume", "targetname" );
    common_scripts\utility::flag_wait( "gas_station_exploded" );
    var_1 = level._ID6711;

    if ( isdefined( var_1 ) )
    {
        foreach ( var_3 in var_1 )
        {
            if ( isdefined( var_3._ID18318 ) && var_3._ID18318 )
                continue;

            if ( isdefined( var_3.droppingtoground ) && !var_3.droppingtoground && ( isdefined( var_3.friendlymodel ) && var_3.friendlymodel istouching( var_0 ) ) )
            {
                var_4 = var_3.owner;
                var_5 = var_3.droptype;
                var_6 = var_3.cratetype;
                var_7 = var_3.origin;
                var_3 maps\mp\killstreaks\_airdrop::deletecrate();
                var_8 = var_4 maps\mp\killstreaks\_airdrop::createairdropcrate( var_4, var_5, var_6, var_7 + ( 0, 0, 250 ), var_7 + ( 0, 0, 250 ) );
                var_8.droppingtoground = 1;
                var_8 thread [[ level.cratetypes[var_8.droptype][var_8.cratetype].func ]]( var_8.droptype );
                common_scripts\utility::_ID35582();
                var_8 clonebrushmodeltoscriptmodel( level.airdropcratecollision );
                var_8 thread common_scripts\utility::entity_path_disconnect_thread( 1.0 );
                var_8 physicslaunchserver( var_8.origin, ( 0, -20000, 20000 ) );

                if ( isbot( var_8.owner ) )
                {
                    wait 0.1;
                    var_8.owner notify( "new_crate_to_take" );
                }
            }
        }

        return;
    }
}

_ID9617( var_0 )
{
    wait 0.25;
    self linkto( var_0, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_0 waittill( "death" );
    self delete();
}

container_pathnode_watch()
{
    var_0 = getnodearray( "disconnect_until_container_opens", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 disconnectnode();

    common_scripts\utility::flag_wait( "breach_connect_nodes" );

    foreach ( var_2 in var_0 )
        var_2 connectnode();
}
