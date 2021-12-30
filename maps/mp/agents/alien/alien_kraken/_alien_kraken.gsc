// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID24848()
{

}

_ID37353( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 2;

    var_2 = tablelookup( "mp/alien/alien_kraken_definition.csv", 0, var_0, var_1 );

    if ( !isstring( var_0 ) )
    {
        if ( !issubstr( var_2, "." ) )
            var_2 = int( var_2 );
        else
            var_2 = float( var_2 );
    }

    return var_2;
}

getarraydefinitionvalue( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 2;

    var_2 = strtok( tablelookup( "mp/alien/alien_kraken_definition.csv", 0, var_0, var_1 ), " ," );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        if ( !isstring( var_0 ) )
        {
            if ( !issubstr( var_2[var_3], "." ) )
            {
                var_2[var_3] = int( var_2[var_3] );
                continue;
            }

            var_2[var_3] = float( var_2[var_3] );
        }
    }

    return var_2;
}

getstagearraydefinitionvalues( var_0, var_1 )
{
    var_2 = "kraken";

    for ( var_3 = 0; var_3 < 4; var_3++ )
    {
        var_4 = "stage_" + ( var_3 + 1 );
        level._ID2829[var_2].attributes[var_4][var_0] = getarraydefinitionvalue( var_1, 2 + var_3 );
    }
}

_ID37368( var_0, var_1 )
{
    var_2 = "kraken";

    for ( var_3 = 0; var_3 < 4; var_3++ )
    {
        var_4 = "stage_" + ( var_3 + 1 );
        level._ID2829[var_2].attributes[var_4][var_0] = _ID37353( var_1, 2 + var_3 );
    }
}

gettentacledefinitionvalues( var_0, var_1 )
{
    var_2 = "kraken";
    var_3 = level._ID2829[var_2].attributes["tentacle_names"].size;

    for ( var_4 = 0; var_4 < var_3; var_4++ )
    {
        var_5 = level._ID2829[var_2].attributes["tentacle_names"][var_4];
        level._ID2829[var_2].attributes[var_5][var_0] = _ID37353( var_1, 2 + var_4 );
    }
}

loadkrakenattributes()
{
    var_0 = "kraken";
    level._ID2829[var_0] = spawnstruct();
    level._ID2829[var_0].attributes = [];

    if ( maps\mp\alien\_unk1464::_ID18745() )
        level.kraken_attribute_table = "mp/alien/alien_kraken_definition_solo.csv";
    else
        level.kraken_attribute_table = "mp/alien/alien_kraken_definition.csv";

    level._ID2829[var_0].attributes["emissive"] = _ID37353( 21.0 );
    level._ID2829[var_0].attributes["max_emissive"] = _ID37353( 22.0 );
    level._ID2829[var_0].attributes["view_height"] = _ID37353( 23 );
    level._ID2829[var_0].attributes["anim_scale"] = _ID37353( 20.0 );
    level._ID2829[var_0].attributes["model"] = _ID37353( "2" );
    level._ID2829[var_0].attributes["tentacle_model"] = _ID37353( "3" );
    level._ID2829[var_0].attributes["starting_health"] = _ID37353( 24 );
    level._ID2829[var_0].attributes["movement_radius"] = _ID37353( 25 );
    level._ID2829[var_0].attributes["reckless_health_threshold"] = _ID37353( 30.0 );
    level._ID2829[var_0].attributes["default_damage_multiplier"] = _ID37353( 70.0 );
    level._ID2829[var_0].attributes["vulnerable_multiplier_1p"] = _ID37353( 71.0 );
    level._ID2829[var_0].attributes["vulnerable_multiplier_2p"] = _ID37353( 72.0 );
    level._ID2829[var_0].attributes["vulnerable_multiplier_3p"] = _ID37353( 73.0 );
    level._ID2829[var_0].attributes["vulnerable_multiplier_4p"] = _ID37353( 74.0 );
    level._ID2829[var_0].attributes["health_scalar_1p"] = _ID37353( 75 );
    level._ID2829[var_0].attributes["health_scalar_2p"] = _ID37353( 76 );
    level._ID2829[var_0].attributes["health_scalar_3p"] = _ID37353( 77 );
    level._ID2829[var_0].attributes["posture_min_interval"] = _ID37353( 31 );
    level._ID2829[var_0].attributes["posture_max_interval"] = _ID37353( 32 );
    level._ID2829[var_0].attributes["tentacle_damage_multiplier"] = _ID37353( 78.0 );
    level._ID2829[var_0].attributes["heated_smash_volume"] = _ID37353( "90" );
    level._ID2829[var_0].attributes["tentacle_names"] = [ "L1", "L2", "R1", "R2" ];
    _ID37368( "spawn_phase_duration", 100.0 );
    _ID37368( "spawn_phase_health_limit", 101.0 );
    _ID37368( "charge_phase_duration", 102.0 );
    _ID37368( "charge_phase_health_limit", 103.0 );
    _ID37368( "heated_phase_health_threshold", 104.0 );
    _ID37368( "heated_phase_damage_per_second", 105.0 );
    _ID37368( "transition_submerge_time", 106.0 );
    _ID37368( "emerge_teleport_position", "107" );
    _ID37368( "ship_side", "108" );
    _ID37368( "emp_loop_duration", 109.0 );
    _ID37368( "smash_radius", 110 );
    _ID37368( "smash_inner_damage", 111 );
    _ID37368( "smash_outer_damage", 112 );
    _ID37368( "random_smash_min_interval", 113.0 );
    _ID37368( "random_smash_max_interval", 114.0 );
    getstagearraydefinitionvalues( "mass_smash_times", 115 );
    _ID37368( "mass_smash_interval", 116 );
    _ID37368( "emp_damage_location", "117" );
    _ID37368( "emp_damage", 118 );
    _ID37368( "emp_notify", "119" );
    _ID37368( "encounter_name", "120" );
    getstagearraydefinitionvalues( "spawn_times", "121" );
    _ID37368( "heated_smash_tentacle_name", "122" );
    _ID37368( "smash_trigger_cooldown", 123.0 );
    _ID37368( "smash_trigger_activation_time", 124.0 );
    _ID37368( "smash_trigger_deactivation_time", 125.0 );
    _ID37368( "emp_shock_duration", 126 );
    _ID37368( "emp_disable_duration", 127 );
    level.kraken_safe_spot_volumes = loadkrakenvariablenumberofstringentries( "50" );
    gettentacledefinitionvalues( "port_location", "200" );
    gettentacledefinitionvalues( "starboard_location", "201" );
    gettentacledefinitionvalues( "anim_index", 202 );
    gettentacledefinitionvalues( "port_melee_triggers", "203" );
    gettentacledefinitionvalues( "starboard_melee_triggers", "204" );
    loadspawnwaves();
}

loadspawnwaves()
{
    level.kraken_spawn_waves = [];

    for ( var_0 = 300; var_0 <= 399; var_0++ )
    {
        var_1 = tablelookup( level.kraken_attribute_table, 0, var_0, 1 );

        if ( var_1 == "" )
            break;

        level.kraken_spawn_waves[var_1] = [];

        for ( var_2 = 2; var_2 < 10; var_2++ )
        {
            var_3 = tablelookup( level.kraken_attribute_table, 0, var_0, var_2 );

            if ( var_3 == "" )
                break;

            var_4 = level.kraken_spawn_waves[var_1].size;
            level.kraken_spawn_waves[var_1][var_4] = var_3;
        }
    }
}

loadkrakenvariablenumberofstringentries( var_0 )
{
    var_1 = [];
    var_2 = 0;
    var_3 = int( var_0 );

    for (;;)
    {
        var_4 = "" + ( var_3 + var_2 );
        var_5 = _ID37353( var_4 );

        if ( var_5 == "" )
            break;

        var_6 = getent( var_5, "targetname" );

        if ( !isdefined( var_6 ) )
            var_6 = common_scripts\utility::_ID15384( var_5, "targetname" );

        if ( isdefined( var_6 ) )
            var_1[var_1.size] = var_6;

        var_2++;
    }

    return var_1;
}

loadkrakenfx()
{
    level._ID1644["kraken_water_spray_emitter"] = loadfx( "vfx/gameplay/alien/vfx_alien_kraken_water_spray_emitter" );
    level._ID1644["kraken_rt_water_spray_emitter"] = loadfx( "vfx/gameplay/alien/vfx_alien_kraken_rt_water_spray_emitter" );
    level._ID1644["kraken_water_stream_emitter"] = loadfx( "vfx/ae/aln_krk_h2o_strm_e" );
    level._ID1644["kraken_water_sweep_rt_emitter"] = loadfx( "vfx/gameplay/alien/vfx_alien_kraken_water_sweep_rt_emitter" );
    level._ID1644["kraken_water_roar_emitter1"] = loadfx( "vfx/gameplay/alien/vfx_alien_kraken_water_roar_emitter1" );
    level._ID1644["kraken_water_stream_e_lite"] = loadfx( "vfx/gameplay/alien/vfx_alien_krak_water_stream_e_lite" );
    level._ID1644["kraken_water_drip"] = loadfx( "vfx/gameplay/alien/vfx_alien_kraken_water_drip_emitter" );
    level._ID1644["kraken_back_glow_01"] = loadfx( "vfx/gameplay/alien/vfx_alien_krkn_glow_back" );
    level._ID1644["kraken_water_stream_pincers"] = loadfx( "vfx/gameplay/alien/vfx_alien_kraken_water_stream_pincers" );
    level._ID1644["kraken_eye_glow_01"] = loadfx( "vfx/gameplay/alien/vfx_alien_kraken_eye_glow_01" );
    level._ID1644["kraken_blood_roar_emitter"] = loadfx( "vfx/gameplay/alien/vfx_alien_kraken_blood_roar_emitter" );
    level._ID1644["kraken_blood_roar_gurgle"] = loadfx( "vfx/gameplay/alien/vfx_alien_kraken_blood_roar_gurgle" );
}

initkraken()
{
    level._ID2507["kraken"] = [];
    level._ID2507["kraken"]["spawn"] = ::alienkrakenspawn;
    level._ID2507["kraken"]["on_killed"] = ::alienkrakenkilled;
    level._ID2507["kraken"]["on_damaged"] = ::alienkrakendamaged;
    level._ID2507["kraken"]["on_damaged_finished"] = ::alienkrakendamagefinished;
    level._ID37049 = ::loadkrakenattributes;
    common_scripts\utility::_ID13189( "fx_kraken_water" );
    loadkrakenattributes();
    loadkrakenfx();
    common_scripts\utility::_ID13189( "fx_kraken_water" );
    level.kraken_health_padding = 100000;
}

alienkrakenspawn( var_0, var_1 )
{
    var_2 = 100;
    var_3 = 250;
    var_4 = maps\mp\agents\_agent_common::_ID7870( "kraken", "axis" );

    if ( !isdefined( var_0 ) || !isdefined( var_1 ) )
    {

    }

    var_4 setkrakenmodel();
    var_4._ID22818 = ::onenterstate;
    var_4 spawnagent( var_0, var_1, "alien_kraken_animclass", var_2, var_3 );
    level notify( "spawned_agent",  var_4  );
    var_4 assignkrakenattributes();
    var_4 setkrakenscriptfields( var_0 );
    var_4 scragentsetclipmode( "agent" );
    var_4 scragentsetphysicsmode( "noclip" );
    var_4 takeallweapons();
    var_5 = getkrakenhealthscalar();
    var_4.health = int( level._ID2829["kraken"].attributes["starting_health"] * var_5 + 100000 );
    var_4.maxhealth = int( level._ID2829["kraken"].attributes["starting_health"] * var_5 + 100000 );
    var_4 scragentusemodelcollisionbounds();
    var_4.alien_type = "kraken";
    var_4._ID38300 = [];
    var_4.ignoreme = 1;
    var_4._ID38117 = "stage_1";
    var_4.damage_multiplier = level._ID2829["kraken"].attributes["default_damage_multiplier"];
    var_4.posturing = 0;
    var_4.smashing = 0;
    var_4.masssmashattackavailable = 0;
    var_4 hide();
    return var_4;
}

attachtentacles()
{
    foreach ( var_1 in level._ID2829["kraken"].attributes["tentacle_names"] )
    {
        self.tentacles[var_1] = maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::alienkrakententaclespawn( var_1 );
        self.tentacles[var_1] hide();
    }
}

getkrakenhealthscalar()
{
    switch ( level.players.size )
    {
        case 1:
            return level._ID2829["kraken"].attributes["health_scalar_1p"];
        case 2:
            return level._ID2829["kraken"].attributes["health_scalar_2p"];
        case 3:
            return level._ID2829["kraken"].attributes["health_scalar_3p"];
    }

    return 1.0;
}

getkrakendamagemultiplier()
{
    switch ( level.players.size )
    {
        case 1:
            return level._ID2829["kraken"].attributes["vulnerable_multiplier_1p"];
        case 2:
            return level._ID2829["kraken"].attributes["vulnerable_multiplier_2p"];
        case 3:
            return level._ID2829["kraken"].attributes["vulnerable_multiplier_3p"];
        case 4:
            return level._ID2829["kraken"].attributes["vulnerable_multiplier_4p"];
    }
}

setkrakenmodel()
{
    var_0 = level._ID2829["kraken"].attributes["model"];
    self setmodel( var_0 );
    self show();
    self motionblurhqenable();
}

setkrakenscriptfields( var_0 )
{
    self.species = "alien";
    self.enablestop = 1;
    maps\mp\agents\_agent_utility::activateagent();
    self._ID30916 = gettime();
    self.attacking_player = 0;
    self.spawnorigin = var_0;
}

assignkrakenattributes()
{
    self.alien_type = "kraken";
    self.moveplaybackrate = 1.0;
    self.defaultmoveplaybackrate = self.moveplaybackrate;
    self.animplaybackrate = self.moveplaybackrate;
    self._ID36479 = level._ID2829[self.alien_type].attributes["anim_scale"];
    self.defaultemissive = level._ID2829[self.alien_type].attributes["emissive"];
    self.maxemissive = level._ID2829[self.alien_type].attributes["max_emissive"];
    thread _ID37968();
    self scragentsetviewheight( level._ID2829[self.alien_type].attributes["view_height"] );
}

_ID37968()
{
    self endon( "death" );
    wait 1;
    maps\mp\alien\_unk1464::_ID28196( 0.2, 0.85 );
}

alienkrakenthink()
{
    self.smash_allowed = 0;
    setkrakenhealth();
    self.phases = buildphases();

    for ( self.current_stage_num = 1; self.current_stage_num <= 4; self.current_stage_num++ )
    {
        self._ID38117 = "stage_" + self.current_stage_num;
        common_scripts\utility::flag_set( "fx_kraken_water" );
        self.current_phase = 0;
        runphases();
    }

    thread thin_alien_herd();
    playdeathanims();
    self suicide();
}

thin_alien_herd()
{
    var_0 = common_scripts\utility::array_combine( level.seeder_active_turrets, level.agentarray );
    var_1 = getnodesinradius( ( 129, 5985, 1408 ), 300, 50, 128, "path" );

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3 ) && var_3 != level.kraken )
        {
            if ( isalive( var_3 ) || var_3.model == "alien_spore" )
            {
                if ( var_3.team == "axis" && isdefined( var_3.alien_type ) && var_3.model != "alien_spore" )
                    var_3 thread waittil_goal_and_suicide( var_1[randomint( var_1.size )] );
                else if ( var_3.model == "alien_spore" )
                    var_3 notify( "death" );
            }
        }

        wait(randomfloatrange( 1, 2 ));
    }
}

waittil_goal_and_suicide( var_0 )
{
    self.alien_scripted = 1;
    self notify( "alien_main_loop_restart" );
    common_scripts\utility::_ID35582();
    self scragentsetgoalnode( var_0 );
    self scragentsetgoalradius( 128 );
    common_scripts\utility::_ID35637( 20, "goal_reached" );
    self suicide();
}

runphases()
{
    while ( self.current_phase != self.phases.size )
    {
        var_0 = self.phases[self.current_phase];
        self.current_phase++;

        if ( var_0["in_final_stage"] || self.current_stage_num != 4 )
            runphase( var_0["name"], var_0["func"], var_0["melee_allowed"], var_0["run_cycle"], var_0["min_health_percentage"] );
    }
}

buildphases()
{
    var_0 = [];
    var_0[0] = setupphase( "emerge", ::runemergephase, 0, 0, "spawn_phase_health_limit", 1 );
    var_0[1] = setupphase( "spawn", ::runspawnphase, 1, 1, "spawn_phase_health_limit", 1 );
    var_0[2] = setupphase( "charge", ::runchargephase, 0, 0, "charge_phase_health_limit", 1 );
    var_0[3] = setupphase( "heat", ::runheatedphase, 1, 1, "heated_phase_health_threshold", 1 );
    var_0[4] = setupphase( "transition", ::runsubmergephase, 0, 0, "heated_phase_health_threshold", 0 );
    return var_0;
}

setupphase( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = [];
    var_6["name"] = var_0;
    var_6["func"] = var_1;
    var_6["melee_allowed"] = var_2;
    var_6["run_cycle"] = var_3;
    var_6["min_health_percentage"] = var_4;
    var_6["in_final_stage"] = var_5;
    return var_6;
}

setkrakenhealth( var_0 )
{
    if ( isdefined( level.players ) && level.players.size > 0 )
    {
        var_1 = getkrakenhealthscalar();
        self.health = int( level._ID2829["kraken"].attributes["starting_health"] * var_1 + 100000 );
    }
    else
        self.health = level._ID2829["kraken"].attributes["starting_health"];

    self.maxhealth = self.health;
    thread _ID37037();
}

posturemonitor()
{
    self endon( "death" );
    self endon( "spawn_phase_complete" );
    level endon( "game_ended" );
    var_0 = gettime() + randomfloatrange( level._ID2829["kraken"].attributes["posture_min_interval"], level._ID2829["kraken"].attributes["posture_max_interval"] ) * 1000.0;

    for (;;)
    {
        if ( gettime() > var_0 && !self.smashing && !self.posturing )
        {
            self._ID20883 = "posture";
            _ID37770( self.enemy );

            while ( self.posturing )
                wait 0.05;

            var_0 = gettime() + randomfloatrange( level._ID2829["kraken"].attributes["posture_min_interval"], level._ID2829["kraken"].attributes["posture_max_interval"] ) * 1000.0;
        }

        wait 0.05;
    }
}

masssmashattacktimer()
{
    self endon( "death" );
    self endon( "spawn_phase_complete" );
    var_0 = gettime() * 0.001;

    for ( var_1 = 0; var_1 < level._ID2829[self.alien_type].attributes[self._ID38117]["mass_smash_times"].size; var_1++ )
    {
        var_2 = gettime() * 0.001;
        var_3 = level._ID2829[self.alien_type].attributes[self._ID38117]["mass_smash_times"][var_1] + var_0 - var_2;

        if ( var_3 > 0 )
            wait(var_3);

        masssmashattack();
    }
}

masssmashattack()
{
    self.masssmashattackavailable = 1;
    waitforidletentacles();
    var_0 = common_scripts\utility::array_randomize( level._ID2829[self.alien_type].attributes["tentacle_names"] );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_2 = var_0[var_1];
        thread attemptsmashattack( self.current_smash_triggers[var_2], var_2 );
        wait(level._ID2829[self.alien_type].attributes[self._ID38117]["mass_smash_interval"]);
    }

    waitforidletentacles();
    self.masssmashattackavailable = 0;
}

_ID31265()
{
    level._ID37166 = level._ID2829[self.alien_type].attributes[self._ID38117]["encounter_name"];
    maps\mp\alien\_spawn_director::_ID31265( level.cycle_count );
    level.cycle_count++;
}

playdeathanims()
{
    self._ID20883 = "death";
    common_scripts\utility::exploder( 104 );
    common_scripts\utility::exploder( 105 );
    _ID37770( self.enemy );
}

runphase( var_0, var_1, var_2, var_3, var_4 )
{
    self.phase = var_0;
    self.smash_allowed = var_2;
    self.min_health_percentage = level._ID2829[self.alien_type].attributes[self._ID38117][var_4];

    if ( var_3 )
        _ID31265();

    [[ var_1 ]]();

    if ( var_3 )
        maps\mp\alien\_spawn_director::_ID11539();
}

runemergephase()
{
    if ( self._ID38117 == "stage_1" )
        thread run_intro_emissive();
    else
        maps\mp\alien\_unk1464::_ID28197( 2.0 );

    if ( level._ID2829["kraken"].attributes[self._ID38117]["ship_side"] == "port" )
        common_scripts\utility::exploder( 102 );
    else
        common_scripts\utility::exploder( 106 );

    self._ID20883 = "emerge";
    _ID37770( self.enemy );
    waitforextendedtentacles();
}

run_intro_emissive()
{
    self endon( "death" );
    var_0 = 0.85;
    var_1 = 2.0;
    maps\mp\alien\_unk1464::_ID28196( var_1, var_0 );
    wait 15;
    maps\mp\alien\_unk1464::_ID28197( var_1 );
}

runspawnphase()
{
    var_0 = 0.5;
    var_1 = 0.2;
    maps\mp\alien\_unk1464::_ID28197( 2.0 );
    thread posturemonitor();

    if ( level._ID2829[self.alien_type].attributes[self._ID38117]["mass_smash_times"].size > 0 )
        thread masssmashattacktimer();

    thread smashattackmonitor();
    thread timedsmashattackmonitor();
    initializeattacktriggers();
    thread runspawnmonitor();
    level notify( "dlc_vo_notify",  "kraken_vo", "warn_horde"  );
    wait(level._ID2829[self.alien_type].attributes[self._ID38117]["spawn_phase_duration"]);
    self notify( "spawn_phase_complete" );
    self.smash_allowed = 0;
    self.masssmashattackavailable = 0;
    waitforidletentacles();
    waitforposturetofinish();
    common_scripts\utility::_ID13180( "fx_kraken_water" );
    wait 0.1;
}

runspawnmonitor()
{
    self endon( "spawn_phase_complete" );
    var_0 = gettime() * 0.001;

    for ( var_1 = 0; var_1 < level._ID2829[self.alien_type].attributes[self._ID38117]["spawn_times"].size; var_1++ )
    {
        var_2 = gettime() * 0.001;
        var_3 = strtok( level._ID2829[self.alien_type].attributes[self._ID38117]["spawn_times"][var_1], "-" );
        var_4 = int( var_3[0] ) + var_0 - var_2;

        if ( var_4 > 0 )
            wait(var_4);

        for (;;)
        {
            var_5 = findavailabletentacle();

            if ( isdefined( var_5 ) )
                break;

            wait 0.05;
        }

        var_5 thread maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::spawnattack( var_3[1] );
    }
}

waitforidletentacles()
{
    var_0 = 0;

    while ( !var_0 )
    {
        var_0 = 1;

        foreach ( var_2 in self.tentacles )
        {
            if ( istentaclespawning( var_2.tentacle_name ) || istentaclesmashing( var_2.tentacle_name ) )
            {
                var_0 = 0;
                break;
            }
        }

        wait 0.05;
    }
}

waitforposturetofinish()
{
    while ( self.posturing )
        wait 0.05;
}

waitforextendedtentacles()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = 1;

        foreach ( var_2 in self.tentacles )
        {
            if ( !var_2 maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::isextended() )
            {
                var_0 = 0;
                break;
            }
        }

        if ( var_0 )
            return;

        wait 0.05;
    }
}

findavailabletentacle()
{
    var_0 = randomint( self.tentacles.size );

    while ( self.masssmashattackavailable )
        wait 0.05;

    for ( var_1 = 0; var_1 < self.tentacles.size; var_1++ )
    {
        var_2 = level._ID2829["kraken"].attributes["tentacle_names"][var_0];
        var_3 = istentaclespawning( var_2 );

        if ( !istentaclespawning( var_2 ) && !istentaclesmashing( var_2 ) )
            return self.tentacles[var_2];

        var_0++;

        if ( var_0 >= self.tentacles.size )
            var_0 = 0;
    }

    return undefined;
}

runchargephase()
{
    common_scripts\utility::_ID13180( "fx_kraken_water" );
    self._ID20883 = "charge";
    _ID37770( self.enemy );
}

runheatedphase()
{
    self notify( "smash_attack_reset" );
    self notify( "heat_phase_started",  self._ID38117  );
    self setscriptablepartstate( "body", "heat_discharge_body_fx_01" );
    var_0 = 0.2;
    var_1 = 1.0;
    maps\mp\alien\_unk1464::_ID28196( var_0, var_1 );
    self._ID20883 = "heat";
    _ID37770( self.enemy );
    self.damage_multiplier = level._ID2829["kraken"].attributes["default_damage_multiplier"];
    self.kraken_heated = 0;
    self.smash_allowed = 0;
}

setupheatedsmashvolume()
{
    var_0 = level._ID2829["kraken"].attributes["heated_smash_volume"];
    var_1 = getent( var_0, "targetname" );
    var_2 = level._ID2829["kraken"].attributes[self._ID38117]["heated_smash_tentacle_name"];
    thread attacktriggerwait( var_1, var_2 );
}

runsubmergephase()
{
    maps\mp\alien\_unk1464::_ID28197( 2.0 );

    if ( level._ID2829["kraken"].attributes[self._ID38117]["ship_side"] == "port" )
        common_scripts\utility::exploder( 103 );
    else
        common_scripts\utility::exploder( 107 );

    self._ID20883 = "submerge";
    _ID37770( self.enemy );
    level thread do_kraken_tilt();
    self playsound( "scn_kraken_reemerge" );
}

do_kraken_tilt()
{
    foreach ( var_1 in level.players )
    {
        if ( isalive( var_1 ) )
            earthquake( 0.75, 3, var_1.origin, 100 );
    }

    wait 3;
}

attemptsmashattack( var_0, var_1 )
{
    self endon( "death" );
    self.last_smash_attack_time = gettime();
    self._ID20883 = "smash";
    self.smash_tentacle_name = var_1;
    self.smash_trigger = var_0;
    _ID37770( self.enemy );
    self.smash_tentacle_name = undefined;
    self.smash_trigger = undefined;

    if ( self.phase == "heat" )
        self.tentacles[var_1] thread maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::heat();
}

timedsmashattackmonitor()
{
    self endon( "death" );
    self endon( "smash_attack_reset" );
    var_0 = randomfloatrange( level._ID2829["kraken"].attributes[self._ID38117]["random_smash_min_interval"], level._ID2829["kraken"].attributes[self._ID38117]["random_smash_max_interval"] ) * 1000.0;

    for (;;)
    {
        if ( canperformmelee() && gettime() - var_0 > self.last_smash_attack_time )
        {
            if ( attemptrandomsmashattack() )
                var_0 = randomfloatrange( level._ID2829["kraken"].attributes[self._ID38117]["random_smash_min_interval"], level._ID2829["kraken"].attributes[self._ID38117]["random_smash_max_interval"] ) * 1000.0;
        }

        wait 0.05;
    }
}

attemptrandomsmashattack()
{
    var_0 = findavailabletentacle();

    if ( !isdefined( var_0 ) )
        return 0;

    attemptsmashattack( self.current_smash_triggers[var_0.tentacle_name], var_0.tentacle_name );
    return 1;
}

smashattackmonitor()
{
    self endon( "death" );
    self notify( "smash_attack_reset" );
    self endon( "smash_attack_reset" );
    self.last_smash_attack_time = gettime();

    for (;;)
    {
        self waittill( "smash_trigger_hit",  var_0, var_1  );
        attemptsmashattack( var_0, var_1 );
    }
}

initializeattacktriggers()
{
    var_0 = level._ID2829["kraken"].attributes[self._ID38117]["ship_side"] + "_melee_triggers";

    foreach ( var_2 in level._ID2829["kraken"].attributes["tentacle_names"] )
    {
        var_3 = level._ID2829["kraken"].attributes[var_2][var_0];
        var_4 = getent( var_3, "targetname" );
        self.current_smash_triggers[var_2] = var_4;
        thread attacktriggerwait( var_4, var_2 );
    }
}

attacktriggerwait( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "smash_attack_reset" );
    var_2 = level._ID2829["kraken"].attributes[self._ID38117]["smash_trigger_cooldown"];

    for (;;)
    {
        var_0 waittill( "touch",  var_3  );

        if ( !isplayer( var_3 ) )
            continue;

        if ( !canperformmelee() || istentaclespawning( var_1 ) )
            continue;

        if ( !isdefined( var_0.has_occupant ) )
        {
            monitortargetintrigger( var_0, var_1 );
            var_4 = self.tentacles[var_1] maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::getsmashanimlength();
            wait(var_4);
        }

        wait(var_2);
    }
}

istentaclespawning( var_0 )
{
    return self.tentacles[var_0] maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::isspawning();
}

istentaclesmashing( var_0 )
{
    return self.tentacles[var_0] maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::issmashing();
}

monitortargetintrigger( var_0, var_1 )
{
    self endon( "death" );
    self endon( "melee_attack_reset" );
    var_2 = level._ID2829["kraken"].attributes[self._ID38117]["smash_trigger_activation_time"] * 1000.0;
    var_3 = level._ID2829["kraken"].attributes[self._ID38117]["smash_trigger_deactivation_time"] * 1000.0;
    var_0.has_occupant = 1;
    var_4 = gettime();
    var_5 = var_4 + var_2;
    var_6 = 0;

    for (;;)
    {
        var_7 = gettime();

        if ( var_7 >= var_5 )
        {
            var_6 = 1;
            break;
        }

        if ( !canperformmelee() || istentaclespawning( var_1 ) )
            break;

        var_8 = var_0 getistouchingentities( level.players );

        if ( var_8.size != 0 )
            var_4 = var_7;
        else
            var_9 = 1;

        if ( var_4 + var_3 < var_7 )
            break;

        wait 0.05;
    }

    var_0.has_occupant = undefined;

    if ( var_6 )
        self notify( "smash_trigger_hit",  var_0, var_1  );
}

canperformmelee()
{
    return self.smash_allowed && !self.masssmashattackavailable;
}

_ID37770( var_0 )
{
    if ( !isdefined( var_0 ) )
    {
        var_0 = findanenemy();

        if ( !isdefined( var_0 ) )
            return;
    }

    self scragentsetgoalpos( self.origin );
    self scragentsetgoalradius( 20000 );
    self scragentbeginmelee( var_0 );
    self waittill( "melee_complete" );
}

findanenemy()
{
    if ( isdefined( self.enemy ) )
        return self.enemy;

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1 ) )
            return var_1;
    }

    return undefined;
}

alienkrakenkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{

}

alienkrakenprocesshitloc( var_0, var_1 )
{
    if ( var_1 != "soft" )
        return "armor";

    return var_1;
}

_ID36922( var_0, var_1, var_2 )
{
    if ( isplayer( var_2 ) )
        var_2 thread maps\mp\gametypes\_damagefeedback::_ID34528( "hitalienarmor" );
}

alienkrakendamaged( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !maps\mp\alien\_damage::_ID37521( var_0, var_1, var_5, var_4 ) )
        return 0;

    if ( var_4 == "MOD_TRIGGER_HURT" )
        return 0;

    if ( _ID37357() < self.min_health_percentage )
        var_2 = 0;

    var_8 = alienkrakenprocesshitloc( var_6, var_8 );
    var_10 = "hitalienarmor";
    var_11 = 1.0;

    if ( isdefined( self.damage_multiplier ) )
        var_11 = self.damage_multiplier;

    if ( isdefined( self.kraken_heated ) && self.kraken_heated )
    {
        if ( maps\mp\alien\_unk1464::_ID18506( level.zap_multiplier_active ) )
        {
            var_11 += 0.4;
            var_10 = "hitaliensoft";
        }
        else if ( var_8 == "soft" )
        {
            var_11 += 0.4;
            var_10 = "hitaliensoft";
        }
        else
            var_10 = "standard";
    }
    else if ( maps\mp\alien\_unk1464::_ID18506( level.zap_multiplier_active ) )
    {
        var_11 += 0.3;
        var_10 = "hitaliensoft";
    }
    else if ( var_8 == "soft" )
    {
        var_11 += 0.4;
        var_10 = "standard";
    }

    var_2 *= var_11;
    var_12 = var_5 == "iw6_alienminigun_mp" || var_5 == "iw6_alienminigun1_mp" || var_5 == "iw6_alienminigun2_mp" || var_5 == "iw6_alienminigun3_mp";
    var_13 = var_5 == "iw6_alienminigun4_mp";

    if ( var_12 || var_13 )
        var_2 *= 0.45;

    var_14 = var_5 == "iw6_alienmk32_mp" || var_5 == "iw6_alienmk321_mp" || var_5 == "iw6_alienmk322_mp" || var_5 == "iw6_alienmk323_mp" || var_5 == "iw6_alienmk324_mp";

    if ( var_14 )
        var_2 *= 0.5;

    var_15 = var_5 == "alien_manned_minigun_turret_mp" || var_5 == "alien_manned_minigun_turret1_mp" || var_5 == "alien_manned_minigun_turret2_mp" || var_5 == "alien_manned_minigun_turret3_mp" || var_5 == "alien_manned_minigun_turret4_mp";

    if ( var_15 )
        var_2 *= 0.5;

    var_16 = var_5 == "alien_manned_gl_turret_mp" || var_5 == "alien_manned_gl_turret1_mp" || var_5 == "alien_manned_gl_turret2_mp" || var_5 == "alien_manned_gl_turret3_mp" || var_5 == "alien_manned_gl_turret4_mp";

    if ( var_16 )
        var_2 *= 0.5;

    if ( isdefined( level._ID37062 ) )
        var_2 = [[ level._ID37062 ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

    if ( var_5 == "alienthrowingknife_mp" )
    {
        var_2 = 0;
        var_0 delete();
    }
    else if ( !var_12 && !var_13 )
        var_2 = maps\mp\alien\_damage::_ID37939( var_4, var_5, var_2 );

    if ( isplayer( var_1 ) && !maps\mp\alien\_unk1464::is_trap( var_0 ) )
    {
        var_2 = maps\mp\alien\_damage::_ID37927( var_1, var_2, var_4, var_5 );
        var_2 = maps\mp\alien\_damage::_ID37929( var_1, var_2, var_4, var_5, var_8 );
    }

    var_2 = maps\mp\alien\_damage::_ID37928( var_1, var_2 );
    var_2 = int( var_2 );

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_1.owner ) && isplayer( var_1.owner ) )
            var_1.owner thread maps\mp\gametypes\_damagefeedback::_ID34528( var_10 );
        else
            var_1 thread maps\mp\gametypes\_damagefeedback::_ID34528( var_10 );
    }

    if ( var_2 <= 0 )
        return 0;

    return self [[ maps\mp\agents\_agent_utility::agentfunc( "on_damaged_finished" ) ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

alienkrakendamagefinished( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_3 |= level.idflags_no_knockback;
    self finishagentdamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, 0 );
}

onenterstate( var_0, var_1 )
{
    _ID22831( var_0, var_1 );
    self.currentanimstate = var_1;

    switch ( var_1 )
    {
        case "idle":
            maps\mp\agents\alien\alien_kraken\_alien_kraken_idle::_ID20445();
            break;
        case "melee":
            maps\mp\agents\alien\alien_kraken\_alien_kraken_melee::_ID20445();
            break;
    }
}

_ID22831( var_0, var_1 )
{
    self notify( "killanimscript" );

    switch ( var_0 )
    {
        case "melee":
            maps\mp\agents\alien\alien_kraken\_alien_kraken_melee::endscript();
            break;
    }
}

_ID37037()
{
    var_0 = 2;
    var_1 = 0;
    var_2 = 0;
    var_3 = 2;
    setomnvar( "ui_alien_boss_icon", var_3 );
    setomnvar( "ui_alien_boss_status", var_0 );
    common_scripts\utility::_ID35582();
    setomnvar( "ui_alien_boss_progression", var_2 );
    var_4 = 100000;

    while ( self.health > 100000 )
    {
        common_scripts\utility::_ID35626( "damage", "hp_update" );

        if ( !isdefined( self ) || self.health <= 0 )
            break;

        var_5 = _ID37357();
        var_6 = 100 - var_5 * 100;
        var_7 = 0.5;

        if ( abs( abs( var_4 ) - abs( var_6 ) ) > var_7 )
        {
            setomnvar( "ui_alien_boss_progression", var_6 );
            var_4 = var_6;
        }
    }

    setomnvar( "ui_alien_boss_status", var_1 );
}

_ID37357()
{
    return max( ( self.health - level.kraken_health_padding ) / ( self.maxhealth - level.kraken_health_padding ), 0.0 );
}

play_kraken_eyeglow1_fx()
{
    wait 3.0;
    playfxontag( level._ID1644["kraken_eye_glow_01"], level.kraken, "tag_eye" );
    wait 5.0;
    playfxontag( level._ID1644["kraken_back_glow_01"], level.kraken, "j_spineback_up" );
}

stop_kraken_eyeglow1_fx()
{
    stopfxontag( level._ID1644["kraken_eye_glow_01"], level.kraken, "tag_eye" );
    wait 1.0;
    stopfxontag( level._ID1644["kraken_back_glow_01"], level.kraken, "j_spineback_up" );
}
