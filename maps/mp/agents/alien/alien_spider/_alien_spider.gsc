// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID24848()
{
    precachempanim( "alien_hive_spore_suckle" );
    precachempanim( "alien_hive_spore_back_to_ground" );
    precachempanim( "alien_hive_spore_idle" );
    precachempanim( "alien_hive_spore_ground_to_idle" );
    precachempanim( "alien_hive_spore_ground" );
    precachempanim( "alien_hive_spore_death" );
    precachempanim( "egg_drone_egg_scale_up" );
    precachempanim( "egg_drone_egg_hatch_01_dlc" );
}

_ID37353( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 2;

    var_2 = tablelookup( "mp/alien/alien_spider_definition.csv", 0, var_0, var_1 );

    if ( !isstring( var_0 ) )
    {
        if ( !issubstr( var_2, "." ) )
            var_2 = int( var_2 );
        else
            var_2 = float( var_2 );
    }

    return var_2;
}

_ID37368( var_0, var_1 )
{
    var_2 = 3;
    var_3 = "spider";

    for ( var_4 = 0; var_4 < var_2; var_4++ )
    {
        var_5 = "stage_" + ( var_4 + 1 );
        level._ID2829[var_3].attributes[var_5][var_0] = _ID37353( var_1, 2 + var_4 );
    }
}

_ID37620()
{
    var_0 = "spider";
    level._ID2829[var_0] = spawnstruct();
    level._ID2829[var_0].attributes = [];
    level._ID2829[var_0].attributes["emissive"] = _ID37353( 21.0 );
    level._ID2829[var_0].attributes["max_emissive"] = _ID37353( 22.0 );
    level._ID2829[var_0].attributes["view_height"] = _ID37353( 23 );
    level._ID2829[var_0].attributes["anim_scale"] = _ID37353( 20.0 );
    level._ID2829[var_0].attributes["model"] = _ID37353( "2" );
    level._ID2829[var_0].attributes["starting_health"] = _ID37353( 24 );
    level._ID2829[var_0].attributes["movement_radius"] = _ID37353( 25 );
    level._ID2829[var_0].attributes["swipe_min_damage"] = _ID37353( 30 );
    level._ID2829[var_0].attributes["swipe_max_damage"] = _ID37353( 31 );
    level._ID2829[var_0].attributes["swipe_max_distance"] = _ID37353( 32.0 );
    level._ID2829[var_0].attributes["elevated_attack_health_threshold"] = _ID37353( 40.0 );
    level._ID2829[var_0].attributes["elevated_attack_spawn_event"] = _ID37353( "41" );
    level._ID2829[var_0].attributes["elevated_attack_sequences"] = _ID37353( 42 );
    level._ID2829[var_0].attributes["elevated_attack_timeout"] = _ID37353( 43.0 );
    level._ID2829[var_0].attributes["egg_attack_far_distance"] = _ID37353( 50 );
    level._ID2829[var_0].attributes["fs_small_earthquake_scale"] = _ID37353( 60.0 );
    level._ID2829[var_0].attributes["fs_small_earthquake_duration"] = _ID37353( 61.0 );
    level._ID2829[var_0].attributes["fs_small_earthquake_radius"] = _ID37353( 62 );
    level._ID2829[var_0].attributes["fs_large_earthquake_scale"] = _ID37353( 63.0 );
    level._ID2829[var_0].attributes["fs_large_earthquake_duration"] = _ID37353( 64.0 );
    level._ID2829[var_0].attributes["fs_large_earthquake_radius"] = _ID37353( 65 );
    level._ID2829[var_0].attributes["fs_large_damage_radius"] = _ID37353( 66 );
    level._ID2829[var_0].attributes["fs_large_damage_amount"] = _ID37353( 67 );
    _ID37368( "health", 100 );
    _ID37368( "egg_min_interval", 101.0 );
    _ID37368( "egg_max_interval", 102.0 );
    _ID37368( "egg_initial_delay", 103.0 );
    _ID37368( "egg_health", 104 );
    _ID37368( "bomb_min_interval", 105.0 );
    _ID37368( "bomb_max_interval", 106.0 );
    _ID37368( "bomb_initial_delay", 107.0 );
    _ID37368( "beam_min_interval", 108.0 );
    _ID37368( "beam_max_interval", 109.0 );
    _ID37368( "beam_initial_delay", 110.0 );
    _ID37368( "beamsweep_min_interval", 124.0 );
    _ID37368( "beamsweep_max_interval", 125.0 );
    _ID37368( "beamsweep_initial_delay", 126.0 );
    _ID37368( "special_attack_interval", 111.0 );
    _ID37368( "posture_min_interval", 112.0 );
    _ID37368( "posture_max_interval", 113.0 );
    _ID37368( "posture_initial_delay", 114.0 );
    _ID37368( "egg_min_count", 115.0 );
    _ID37368( "egg_max_count", 116.0 );
    _ID37368( "portalspawn_min_interval", 117.0 );
    _ID37368( "portalspawn_max_interval", 118.0 );
    _ID37368( "portalspawn_initial_delay", 119.0 );
    _ID37368( "portalspawn_alien_type", "120" );
    _ID37368( "portalspawn_count", 121.0 );
    _ID37368( "event_id_start", 122 );
    _ID37368( "event_id_end", 123 );
    _ID37368( "cycle_delay", 135.0 );
    _ID37368( "regenpod_min_interval", 127.0 );
    _ID37368( "regenpod_max_interval", 128.0 );
    _ID37368( "regen_min_interval", 129.0 );
    _ID37368( "regen_max_interval", 130.0 );
    level._ID38095[1] = _ID37353( 131.0 );
    level._ID38095[2] = _ID37353( 132.0 );
    level._ID38095[3] = _ID37353( 133.0 );
    level._ID38095[4] = _ID37353( 134.0 );
}

_ID37621()
{
    level._ID1644["projectile_spit_trail"] = loadfx( "vfx/gameplay/alien/vfx_alien_spider_bomb_trail_01" );
    level._ID1644["bomb_airburst"] = loadfx( "vfx/gameplay/alien/vfx_alien_spider_bomb_burst" );
    level._ID1644["proj_spit_AOE"] = loadfx( "vfx/gameplay/alien/vfx_alien_spider_gas_cloud_impact_01" );
    level._ID1644["beam_attack_precursor"] = loadfx( "vfx/gameplay/alien/vfx_alien_spider_darts_precursor" );
    level._ID1644["beam_attack_charge"] = loadfx( "vfx/gameplay/alien/vfx_alien_spider_darts_charge" );
    level._ID1644["beam_fire_flash"] = loadfx( "vfx/gameplay/alien/vfx_alien_spider_darts_flash" );
    level._ID1644["darts_fire_1"] = loadfx( "vfx/gameplay/alien/vfx_alien_spider_darts_01" );
    level._ID1644["spider_regen_pod"] = loadfx( "vfx/gameplay/alien/vfx_alien_pod_healthreg_01" );
    level._ID1644["spider_regen_spider"] = loadfx( "vfx/gameplay/alien/vfx_alien_queen_healthreg_01" );
    level._ID1644["egg_explosion"] = loadfx( "vfx/gameplay/alien/vfx_spider_egg_explosion_01" );
    level._ID1644["egg_glow"] = loadfx( "vfx/gameplay/alien/vfx_spider_egg_glow_01" );
    level._ID1644["egg_launch"] = loadfx( "vfx/gameplay/alien/vfx_alien_spider_egg_launch_01" );
    level._ID1644["egg_launch_trail"] = loadfx( "vfx/gameplay/alien/vfx_alien_egg_launch_01" );
    level._ID1644["spider_vuln"] = loadfx( "vfx/gameplay/alien/vfx_alien_spider_vuln_01" );
    level._ID1644["spider_vuln_joint"] = loadfx( "vfx/gameplay/alien/vfx_alien_spider_vuln_02" );
    level._ID1644["spider_eye_glow"] = loadfx( "vfx/gameplay/alien/vfx_alien_spider_eye_glow_01" );
    level._ID1644["spider_sac_glow"] = loadfx( "vfx/gameplay/alien/vfx_alien_spider_sac_glow_01" );
    level._ID1644["spider_sac_burst"] = loadfx( "vfx/gameplay/alien/vfx_alien_spider_sac_burst" );
    level._ID1644["spider_footstep_snow_vlg"] = loadfx( "vfx/ae/aln_spdr_stp_snow_vl" );
    level._ID1644["spider_footstep_snow_lg"] = loadfx( "vfx/ae/aln_spdr_stp_snow_l" );
    level._ID1644["spider_footstep_snow_m"] = loadfx( "vfx/ae/aln_spdr_stp_snow_m" );
    level._ID1644["spider_claw_snow_lg"] = loadfx( "vfx/ae/aln_spdr_stp_attk_snow_l" );
    level._ID1644["spider_vomit_01"] = loadfx( "vfx/gameplay/alien/vfx_alien_spider_vomit_01" );
    level._ID1644["easter_egg_trl"] = loadfx( "vfx/_requests/mp_alien_armory/vfx_alien_egg_trl" );
    level._ID1644["easter_egg_spitter_trail"] = loadfx( "vfx/_requests/mp_alien_armory/vfx_alien_spitter_egg_trail" );
    level._ID1644["easter_egg_explode"] = loadfx( "vfx/_requests/mp_alien_armory/vfx_easter_egg_explosion" );
}

_ID37503()
{
    level._ID2507["customAlien1"] = [];
    level._ID2507["customAlien1"]["spawn"] = ::_ID36701;
    level._ID2507["customAlien1"]["on_killed"] = ::_ID36698;
    level._ID2507["customAlien1"]["on_damaged"] = ::_ID36696;
    level._ID2507["customAlien1"]["on_damaged_finished"] = ::_ID36697;
    level._ID37049 = ::_ID37620;
    _ID37620();
    _ID37621();
    _ID38001();
    _ID37999();
    _ID38002();
    level._ID38089 = 20000;
    level._ID37868 = 0;
}

_ID36701( var_0, var_1 )
{
    var_2 = 100;
    var_3 = 250;
    var_4 = maps\mp\agents\_agent_common::_ID7870( "customAlien1", "axis" );

    if ( !isdefined( var_0 ) || !isdefined( var_1 ) )
    {
        var_5 = var_4 [[ level.getspawnpoint ]]();
        var_0 = var_5.origin;
        var_1 = var_5.angles;
    }

    var_4 _ID37973();
    var_4._ID22818 = ::onenterstate;
    var_4 spawnagent( var_0, var_1, "alien_spider_animclass", var_2, var_3 );
    level notify( "spawned_agent",  var_4  );
    var_4 _ID36742();
    var_4 _ID37974( var_0 );
    var_4 _ID38000();
    var_4 scragentsetclipmode( "agent" );
    var_4 takeallweapons();
    var_6 = _ID37367();
    var_4.health = int( level._ID2829["spider"].attributes["starting_health"] * var_6 + 20000 );
    var_4.maxhealth = int( level._ID2829["spider"].attributes["starting_health"] * var_6 + 20000 );
    var_4 scragentusemodelcollisionbounds();
    var_4._ID38300 = [];
    var_7 = _ID37344();

    foreach ( var_9 in var_7 )
    {
        var_4._ID38300[var_9] = spawnstruct();
        var_4._ID38300[var_9].state = 0;
        var_4._ID38300[var_9].health = int( _ID37367() * 15000 );
    }

    var_4._ID38263 = 0;
    var_4._ID37834 = 0;
    var_4._ID37837 = 0;
    var_4._ID38264 = 0;
    var_4.ignoreme = 1;
    return var_4;
}

_ID37366()
{
    switch ( level.players.size )
    {
        case 1:
            return 0.5;
        case 2:
            return 0.65;
        case 3:
            return 0.8;
    }

    return 1.0;
}

_ID37367()
{
    switch ( level.players.size )
    {
        case 1:
            return 0.4;
        case 2:
            return 0.66;
        case 3:
            return 0.85;
    }

    return 1.0;
}

_ID37973()
{
    var_0 = level._ID2829["spider"].attributes["model"];
    self setmodel( var_0 );
    self show();
    self motionblurhqenable();
    var_1 = _ID37344();
    self._ID38299 = [];

    foreach ( var_3 in var_1 )
        _ID37964( var_3, 0 );
}

_ID37974( var_0 )
{
    self.species = "alien";
    self.enablestop = 1;
    maps\mp\agents\_agent_utility::activateagent();
    self._ID30916 = gettime();
    self.attacking_player = 0;
    self.spawnorigin = var_0;
}

_ID36742()
{
    self.alien_type = "spider";
    self.moveplaybackrate = 1.0;
    self.defaultmoveplaybackrate = self.moveplaybackrate;
    self.animplaybackrate = self.moveplaybackrate;
    self._ID36479 = level._ID2829[self.alien_type].attributes["anim_scale"];
    self.defaultemissive = level._ID2829[self.alien_type].attributes["emissive"];
    self.maxemissive = level._ID2829[self.alien_type].attributes["max_emissive"];
    thread _ID37968();
    self scragentsetviewheight( level._ID2829[self.alien_type].attributes["view_height"] );
}

_ID38000()
{
    maps\mp\agents\alien\alien_spider\_alien_spider_melee::_ID37997();
}

_ID37968()
{
    self endon( "death" );
    wait 1;
    maps\mp\alien\_unk1464::_ID28197( 0.2 );
}

_ID36700( var_0 )
{
    switch ( var_0 )
    {
        case "test":
            _ID38151();
            break;
        case 1:
            _ID37924();
            break;
        case 2:
            _ID37925();
            break;
    }

    endswitch( 4 )  case 2 loc_AC9 case 1 loc_ABF case "test" loc_AB5 default loc_AD3
}

_ID37501( var_0 )
{
    self._ID38077 = [];

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2["type"];
        self._ID38077[var_3] = 0;
    }
}

_ID37972( var_0 )
{
    if ( isdefined( level.players ) && level.players.size > 0 )
    {
        var_1 = _ID37367();
        self.health = int( level._ID2829[self.alien_type].attributes[self._ID38117]["health"] * var_1 + 20000 );
    }
    else
        self.health = level._ID2829[self.alien_type].attributes[self._ID38117]["health"];

    self.maxhealth = self.health;
    thread _ID37037();
}

_ID38151()
{
    var_0[0]["type"] = "posture";
    var_0[1]["type"] = "portalspawn";
    _ID37926( var_0, 1, ::_ID38152 );
}

_ID38152( var_0 )
{
    self endon( "spider_stage_end" );
    self endon( "death" );

    for (;;)
    {
        var_1 = _ID37359();

        if ( self.health < 20000 )
            _ID37812( "retreat", 0 );
        else if ( isdefined( var_1 ) )
            _ID36980( var_1 );
        else
            _ID38169( var_0 );

        wait 0.05;
    }
}

_ID37926( var_0, var_1, var_2 )
{
    self._ID38080 = 1;
    _ID38003( 0.0 );
    self._ID38117 = "stage_" + var_1;
    self._ID36816 = "boss_spawners_0" + var_1;
    _ID37972();
    _ID37501( var_0 );
    _ID36660( var_0 );
    thread _ID37422();
    self [[ var_2 ]]( var_0 );
}

_ID37422()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "damage" );

        if ( self.health <= 20000 )
            break;
    }

    self notify( "spider_stage_end" );
}

_ID38169( var_0 )
{
    if ( !self._ID38080 )
        return 0;

    foreach ( var_2 in var_0 )
    {
        if ( _ID37553( var_2 ) )
        {
            var_3 = var_2["type"];
            _ID37771( var_3 );
            return 1;
        }
    }

    return 0;
}

_ID36660( var_0 )
{
    self notify( "attack_timer_initialize" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2["type"];
        thread _ID38081( var_3 );
    }
}

_ID36946()
{
    var_0 = maps\mp\alien\_spawn_director::_ID14384( "brute" );
    var_1 = int( 6 * _ID37366() );
    return var_0 < var_1;
}

_ID37924()
{
    var_0[0]["type"] = "posture";
    var_0[1]["type"] = "bomb";
    var_0[2]["type"] = "egg";
    var_0[2]["validateFunc"] = ::_ID36946;
    var_0[3]["type"] = "beam";
    _ID37926( var_0, 1, ::_ID38102 );
    _ID37812( "retreat", 0 );
}

_ID38102( var_0 )
{
    self endon( "death" );
    self endon( "spider_stage_end" );

    for (;;)
    {
        var_1 = _ID37359();

        if ( isdefined( self._ID37437 ) && self._ID37437 )
        {

        }
        else if ( isdefined( var_1 ) )
            _ID36980( var_1 );
        else
            _ID38169( var_0 );

        wait 0.05;
    }
}

_ID37925()
{
    maps\mp\agents\alien\alien_spider\_alien_spider_idle::_ID37475();
    var_0[0]["type"] = "regenpod";
    var_0[0]["validateFunc"] = ::_ID38025;
    var_0[1]["type"] = "regen";
    var_0[1]["validateFunc"] = ::_ID38027;
    var_0[2]["type"] = "bomb";
    var_0[3]["type"] = "egg";
    var_0[3]["validateFunc"] = ::_ID36946;
    var_0[4]["type"] = "beam";
    var_0[5]["type"] = "beamsweep";
    var_0[6]["type"] = "posture";
    thread _ID37153();
    _ID37926( var_0, 2, ::_ID38103 );
    var_1 = 1;
}

_ID38103( var_0 )
{
    self endon( "spider_stage_end" );
    self endon( "death" );

    for (;;)
    {
        var_1 = _ID37359();

        if ( isdefined( self._ID37437 ) && self._ID37437 )
        {

        }
        else if ( _ID37551() )
            _ID38276();
        else if ( isdefined( var_1 ) )
            _ID36980( var_1 );
        else if ( _ID36944() )
            _ID37154( var_0 );
        else
            _ID38169( var_0 );

        wait 0.05;
    }
}

_ID37153()
{
    self endon( "death" );
    self._ID37152 = 0;
    wait 10.0;

    for (;;)
    {
        if ( _ID37357() <= level._ID2829[self.alien_type].attributes["elevated_attack_health_threshold"] )
            break;

        wait 0.05;
    }

    self._ID37152 = 1;
}

_ID36944()
{
    return self._ID37152;
}

_ID37154( var_0 )
{
    var_1 = 10;
    self._ID20883 = "elevated_retreat_attack";
    _ID37770( self.enemy );
    common_scripts\utility::_ID13189( "elevated_attack_wave_complete" );
    thread _ID38071();
    var_2 = level._ID2829[self.alien_type].attributes["elevated_attack_sequences"];

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        wait(var_1);
        _ID37771( "egg" );
    }

    var_4 = level._ID2829[self.alien_type].attributes["elevated_attack_timeout"];
    common_scripts\utility::flag_wait_or_timeout( "elevated_attack_wave_complete", var_4 );
    self._ID20883 = "elevated_return_attack";
    _ID37770( self.enemy );
    self._ID37109 = undefined;
    _ID38003( 0.0 );
    self._ID37152 = 0;
    self._ID38117 = "stage_3";
    _ID36660( var_0 );
}

_ID38071()
{
    var_0 = level._ID2829[self.alien_type].attributes["elevated_attack_spawn_event"];
    maps\mp\alien\_spawn_director::activate_spawn_event( var_0, 1 );
    common_scripts\utility::flag_set( "elevated_attack_wave_complete" );
}

_ID37551()
{
    return maps\mp\agents\alien\alien_spider\_alien_spider_idle::is_moving();
}

_ID38276()
{
    while ( _ID37551() )
        wait 0.05;

    _ID38003( 0.0 );
}

_ID38003( var_0 )
{
    self._ID36479 = var_0;
    self scragentsetanimscale( self._ID36479, 1.0 );
}

_ID37553( var_0 )
{
    var_1 = var_0["type"];

    if ( !self._ID38077[var_1] )
        return 0;

    if ( !isdefined( var_0["validateFunc"] ) )
        return 1;

    return [[ var_0["validateFunc"] ]]();
}

_ID38081( var_0 )
{
    self endon( "attack_timer_initialize" );
    var_1 = var_0 + "_min_interval";
    var_2 = var_0 + "_max_interval";
    var_3 = level._ID38095[level.players.size];
    var_4 = level._ID2829[self.alien_type].attributes[self._ID38117][var_1] * var_3;
    var_5 = level._ID2829[self.alien_type].attributes[self._ID38117][var_2] * var_3;
    var_6 = var_0 + "_initial_delay";
    var_7 = level._ID2829[self.alien_type].attributes[self._ID38117][var_6];
    self._ID38077[var_0] = 0;

    if ( isdefined( var_7 ) && var_7 > 0.0 )
        wait(var_7);

    for (;;)
    {
        self._ID38077[var_0] = 1;
        var_8 = var_0 + "_attack_complete";
        self waittill( var_8 );
        self._ID38077[var_0] = 0;
        wait(randomfloatrange( var_4, var_5 ));
    }
}

_ID37359()
{
    var_0 = level._ID2829[self.alien_type].attributes["swipe_max_distance"] * level._ID2829[self.alien_type].attributes["swipe_max_distance"];
    var_1 = undefined;
    var_2 = undefined;

    foreach ( var_4 in level.players )
    {
        var_5 = distancesquared( self.origin, var_4.origin );

        if ( var_5 > var_0 )
            continue;

        if ( !isdefined( var_2 ) || var_5 < var_2 )
        {
            var_1 = var_4;
            var_2 = var_5;
        }
    }

    return var_1;
}

_ID36980( var_0 )
{
    self._ID20883 = "close_melee";
    self._ID36977 = var_0;
    _ID37770( self.enemy );
}

_ID37771( var_0 )
{
    self._ID20883 = var_0 + "_attack";
    _ID37770( self.enemy );

    if ( strtok( var_0, "_" )[0] != "regen" )
        thread _ID37855();

    var_1 = self._ID20883 + "_complete";
    self notify( var_1 );
}

_ID37855()
{
    var_0 = level._ID2829[self.alien_type].attributes[self._ID38117]["special_attack_interval"];
    self._ID38080 = 0;
    wait(var_0);
    self._ID38080 = 1;
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
    self scragentsetgoalradius( 64 );
    self scragentbeginmelee( var_0 );
    self waittill( "melee_complete" );
}

_ID36698( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( isdefined( self._ID38117 ) && self._ID38117 == "stage_1" )
        return;

    if ( isdefined( self._ID38256 ) && self._ID38256 == 1 )
        return;

    self scragentsetphysicsmode( "noclip" );
    self setanimstate( "death", 0 );
    self._ID5433 = maps\mp\alien\_death::get_clone_agent( "death", 0 );
    thread maps\mp\alien\_death::_ID16181( self._ID5433, "death", 0 );
    maps\mp\agents\alien\_alien_think::_ID22818( self.currentanimstate, "death" );
    self._ID5433 thread _ID37236();
}

_ID37370( var_0 )
{
    var_1 = [ "TAG_BREATH", "TAG_Target_Belly_L", "TAG_Target_Belly_F", "TAG_Target_Belly_R" ];
    var_2 = [ "mouth", "left", "front", "right" ];

    foreach ( var_5, var_4 in var_2 )
    {
        if ( var_0 == var_4 )
            return var_1[var_5];
    }
}

_ID36699( var_0, var_1, var_2 )
{
    var_3 = !isdefined( self._ID38117 ) || isdefined( self._ID37152 ) && self._ID37152;

    if ( var_3 )
        return "invulnerable";

    var_4 = isexplosivedamagemod( var_2 ) && var_2 != "MOD_EXPLOSIVE_BULLET";

    if ( !var_4 && var_1 != "soft" )
        return "armor";

    var_5 = [ "TAG_BREATH", "TAG_Target_Belly_L", "TAG_Target_Belly_F", "TAG_Target_Belly_R" ];
    var_6 = [ "mouth", "left", "front", "right" ];
    var_7 = "none";
    var_8 = 9999999;

    foreach ( var_13, var_10 in var_5 )
    {
        var_11 = self gettagorigin( var_10 );
        var_12 = distancesquared( var_0, var_11 );

        if ( var_12 < var_8 )
        {
            var_7 = var_6[var_13];
            var_8 = var_12;
        }
    }

    if ( var_4 && var_8 > 4096 )
        return "armor";

    return var_7;
}

_ID36922( var_0, var_1, var_2 )
{
    if ( isplayer( var_2 ) )
        var_2 thread maps\mp\gametypes\_damagefeedback::_ID34528( "hitalienarmor" );
}

weaponcanpenetratespiderarmor( var_0 )
{
    switch ( var_0 )
    {
        case "switchblade_rocket_mp":
        case "alienmortar_strike_mp":
        case "aliensoflam_missle_mp":
        case "switchblade_baby_mp":
        case "switchblade_babyfast_mp":
        case "iw6_aliendlc11_mp":
            return 1;
        default:
            return 0;
    }
}

_ID36696( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !maps\mp\alien\_damage::_ID37521( var_0, var_1, var_5, var_4 ) )
        return 0;

    _ID36961( var_5, var_6, var_8 );
    var_8 = _ID36699( var_6, var_8, var_4 );
    var_10 = var_5 == "iw6_aliendlc11_mp";
    var_11 = weaponcanpenetratespiderarmor( var_5 );
    var_12 = var_5 == "iw6_alienminigun_mp" || var_5 == "iw6_alienminigun1_mp" || var_5 == "iw6_alienminigun2_mp" || var_5 == "iw6_alienminigun3_mp";
    var_13 = var_5 == "iw6_alienminigun4_mp";

    if ( var_8 == "invulnerable" || var_8 == "armor" && !var_11 )
    {
        _ID36922( var_6, var_7 );
        return 0;
    }

    if ( var_10 )
    {
        var_2 *= 1.0;

        if ( var_8 != "armor" )
            var_2 *= 1.0;
    }
    else if ( var_11 )
        var_2 *= 0.5;

    if ( var_12 )
        var_2 = 41.25;
    else if ( var_13 )
        var_2 = 56.25;

    if ( isexplosivedamagemod( var_4 ) && var_4 != "MOD_EXPLOSIVE_BULLET" )
        var_2 = int( 0.5 * var_2 );

    if ( isdefined( level._ID37062 ) )
        var_2 = [[ level._ID37062 ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

    var_2 = maps\mp\alien\_damage::_ID37939( var_4, var_5, var_2 );

    if ( isplayer( var_1 ) && !maps\mp\alien\_unk1464::is_trap( var_0 ) )
    {
        var_2 = maps\mp\alien\_damage::_ID37927( var_1, var_2, var_4, var_5 );
        var_2 = maps\mp\alien\_damage::_ID37929( var_1, var_2, var_4, var_5, var_8 );
    }

    var_2 = maps\mp\alien\_damage::_ID37928( var_1, var_2 );

    if ( var_2 <= 0 )
        return 0;

    if ( var_8 != "mouth" && var_8 != "armor" )
    {
        if ( self._ID38300[var_8].state == 0 || self._ID38300[var_8].health == 0 )
        {
            _ID36922( var_6, var_7 );
            return 0;
        }

        self._ID38300[var_8].health = max( 0, self._ID38300[var_8].health - var_2 );
        var_2 = 1;

        if ( self._ID38300[var_8].health == 0 )
        {
            self notify( "end_vulnerable",  1  );
            _ID37101( var_8 );
            var_2 = int( 10000 * _ID37367() );
        }
    }
    else
    {
        var_2 = int( 0.75 * var_2 );

        if ( !self._ID38263 )
        {
            self._ID38264 = self._ID38264 + var_2;

            if ( self._ID38264 >= _ID37367() * 10000 * 0.75 && ( !isdefined( self._ID38117 ) || self._ID38117 != "stage_1" ) )
            {
                self._ID38263 = 1;
                self._ID38264 = 0;
                self notify( "vulnerable" );
                level notify( "dlc_vo_notify",  "spider_down"  );
            }
        }
    }

    var_1 thread maps\mp\gametypes\_damagefeedback::_ID34528( "hitaliensoft" );
    return self [[ maps\mp\agents\_agent_utility::agentfunc( "on_damaged_finished" ) ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

_ID36697( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( isdefined( var_7 ) )
        playfx( level._ID1644["melee_blood"], var_6, var_7 );

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
            maps\mp\agents\alien\alien_spider\_alien_spider_idle::_ID20445();
            break;
        case "melee":
            maps\mp\agents\alien\alien_spider\_alien_spider_melee::_ID20445();
            break;
    }
}

_ID22831( var_0, var_1 )
{
    self notify( "killanimscript" );
}

_ID37398( var_0, var_1, var_2, var_3 )
{
    switch ( var_0 )
    {
        case "fs_lg_fl":
            _ID37396( "TAG_Foot_F_L", 1 );
            break;
        case "fs_lg_fr":
            _ID37396( "TAG_Foot_F_R", 1 );
            break;
        case "fs_lg_rl":
            _ID37396( "TAG_Foot_B_L", 1 );
            break;
        case "fs_lg_rr":
            _ID37396( "TAG_Foot_B_R", 1 );
            break;
        case "fs_sm_fl":
            _ID37396( "TAG_Foot_F_L", 0 );
            break;
        case "fs_sm_fr":
            _ID37396( "TAG_Foot_F_R", 0 );
            break;
        case "fs_sm_rl":
            _ID37396( "TAG_Foot_B_L", 0 );
            break;
        case "fs_sm_rr":
            _ID37396( "TAG_Foot_B_R", 0 );
            break;
        case "mouth_open":
            maps\mp\agents\alien\alien_spider\_alien_spider_melee::_ID37395( var_0, var_1, var_2, var_3 );
            break;
        case "mouth_closed":
            maps\mp\agents\alien\alien_spider\_alien_spider_melee::_ID37395( var_0, var_1, var_2, var_3 );
            break;
    }
}

_ID37396( var_0, var_1 )
{
    var_2 = self gettagorigin( var_0 );
    earthquake( level._ID2829["spider"].attributes["fs_large_earthquake_scale"], level._ID2829["spider"].attributes["fs_large_earthquake_duration"], var_2, level._ID2829["spider"].attributes["fs_large_earthquake_radius"] );

    if ( var_1 )
        radiusdamage( var_2, level._ID2829["spider"].attributes["fs_large_damage_radius"], level._ID2829["spider"].attributes["fs_large_damage_amount"], level._ID2829["spider"].attributes["fs_large_damage_amount"], self, "MOD_MELEE", "alienrhinoslam_mp" );
}

_ID37037()
{
    var_0 = 1;
    var_1 = 2;
    var_2 = 0;
    var_3 = 0;

    if ( isdefined( level._ID37166 ) && level._ID37166 == "first_spider_fight" )
        setomnvar( "ui_alien_boss_status", var_0 );
    else if ( isdefined( level._ID37166 ) )
        setomnvar( "ui_alien_boss_status", var_1 );

    common_scripts\utility::_ID35582();
    setomnvar( "ui_alien_boss_progression", var_3 );
    var_4 = 100000;

    while ( self.health > 20000 )
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

    setomnvar( "ui_alien_boss_status", var_2 );
}

_ID37812( var_0, var_1 )
{
    if ( !isdefined( self._ID37908 ) )
    {
        self._ID37908 = var_0;
        self._ID37907 = var_1;
    }

    var_2 = findanenemy();
    self._ID20883 = "traverse";
    _ID37770( var_2 );
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

_ID37357()
{
    return max( ( self.health - level._ID38089 ) / ( self.maxhealth - level._ID38089 ), 0.0 );
}

_ID38001()
{
    level._ID38097 = getscriptablearray( "boss_regen_pod", "targetname" );

    foreach ( var_1 in level._ID38097 )
    {
        var_1._ID37125 = 0;
        var_1.spawned = 0;
        var_1 thread _ID37873();
    }
}

_ID37873()
{
    wait 0.5;
    self setscriptablepartstate( 0, "inactive" );
}

_ID38025()
{
    var_0 = maps\mp\agents\alien\alien_spider\_alien_spider_melee::_ID37364();

    if ( isdefined( var_0 ) && var_0.size )
        return 0;

    return maps\mp\agents\alien\alien_spider\_alien_spider_melee::_ID37544();
}

_ID38027()
{
    var_0 = maps\mp\agents\alien\alien_spider\_alien_spider_melee::_ID37349();

    if ( !isdefined( var_0 ) || var_0.size < 1 )
        return 0;

    if ( _ID37357() >= 1 )
        return 0;

    if ( level._ID37868 > 0 )
        return 0;

    return 1;
}

_ID37344()
{
    return [ "left", "front", "right" ];
}

_ID37348()
{
    return [ "alien_spider_stomach_egg_l", "alien_spider_stomach_egg_f", "alien_spider_stomach_egg_r" ];
}

_ID37347()
{
    return [ "alien_spider_stomach_egg_l_glow", "alien_spider_stomach_egg_f_glow", "alien_spider_stomach_egg_r_glow" ];
}

_ID37345( var_0 )
{
    var_1 = _ID37344();

    foreach ( var_4, var_3 in var_1 )
    {
        if ( var_3 == var_0 )
            return var_4;
    }
}

_ID37346( var_0, var_1 )
{
    if ( var_1 )
        return _ID37347()[var_0];

    return _ID37348()[var_0];
}

_ID37964( var_0, var_1 )
{
    var_2 = _ID37345( var_0 );
    var_3 = _ID37346( var_2, var_1 );

    if ( isdefined( self._ID38299[var_2] ) )
        self detach( self._ID38299[var_2] );

    self attach( var_3 );
    self._ID38299[var_2] = var_3;
}

_ID37113()
{
    var_0 = _ID37344();

    foreach ( var_2 in var_0 )
    {
        if ( self._ID38300[var_2].state == 1 )
        {
            _ID37964( var_2, 0 );
            self._ID38300[var_2].state = 0;
        }

        var_3 = _ID37370( var_2 );
        stopfxontag( level._ID1644["spider_sac_glow"], self, var_3 );
    }
}

_ID36658()
{
    var_0 = _ID37344();
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( self._ID38300[var_3].health > 0 )
            var_1[var_1.size] = var_3;
    }

    if ( var_1.size > 0 )
    {
        var_3 = var_1[randomint( var_1.size )];
        self._ID38300[var_3].state = 1;
        _ID37964( var_3, 1 );
        var_5 = _ID37370( var_3 );
        playfxontag( level._ID1644["spider_sac_glow"], self, var_5 );
    }
}

_ID37101( var_0 )
{
    self._ID38300[var_0].state = 0;
    var_1 = _ID37345( var_0 );
    self detach( self._ID38299[var_1] );
    self._ID38299[var_1] = undefined;
    var_2 = _ID37370( var_0 );
    playfxontag( level._ID1644["spider_sac_burst"], self, var_2 );
    stopfxontag( level._ID1644["spider_sac_glow"], self, var_2 );
}

_ID37999()
{
    level._ID38084 = common_scripts\utility::_ID15386( "boss_egg_spawn_struct", "targetname" );

    if ( !isdefined( level._ID38084 ) || level._ID38084.size == 0 )
        return;

    foreach ( var_1 in level._ID38084 )
        var_1._ID30723 = getnodearray( var_1.target, "targetname" );
}

_ID38002()
{
    level._ID38098 = common_scripts\utility::_ID15386( "boss_spit_choke_struct", "targetname" );

    if ( !isdefined( level._ID38098 ) || level._ID38098.size == 0 )
        return;

    foreach ( var_1 in level._ID38098 )
        var_1._ID37604 = 0;
}

_ID38101()
{
    self endon( "death" );
    level endon( "host_migration_begin" );
    setdvar( "debug_boss_vulnerable", "off" );

    for (;;)
    {
        if ( getdvar( "debug_boss_vulnerable" ) != "off" )
        {
            self._ID38263 = 1;
            self._ID38264 = 0;
            self notify( "vulnerable" );
            level notify( "dlc_vo_notify",  "spider_down"  );
            iprintln( "debug: vulnerable state" );
            wait 0.05;
            setdvar( "debug_boss_vulnerable", "off" );
        }

        wait 0.2;
    }
}

_ID36961( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) || isdefined( var_0 ) && var_0 != "alienthrowingknife_mp" )
        return;

    var_3 = [ "TAG_BREATH", "TAG_Target_Belly_L", "TAG_Target_Belly_F", "TAG_Target_Belly_R" ];
    var_4 = [ "mouth", "left", "front", "right" ];
    var_5 = "none";
    var_6 = 9999999;

    foreach ( var_11, var_8 in var_3 )
    {
        var_9 = self gettagorigin( var_8 );
        var_10 = distancesquared( var_1, var_9 );

        if ( var_10 < var_6 )
        {
            var_5 = var_4[var_11];
            var_6 = var_10;
        }
    }

    if ( var_5 == "mouth" )
        level._ID38083 = 1;
}

_ID37236()
{
    self setscriptablepartstate( "body", "vulnerable" );
    thread _ID37235();
    thread _ID37239();
    thread _ID37241();
}

_ID37235()
{
    self endon( "death" );
    playfxontag( level._ID1644["spider_vomit_01"], self, "TAG_BREATH" );
    wait 2.0;
    stopfxontag( level._ID1644["spider_vomit_01"], self, "TAG_BREATH" );
    wait 1.0;
    playfxontag( level._ID1644["spider_vomit_01"], self, "TAG_BREATH" );
    wait 2.0;
    stopfxontag( level._ID1644["spider_vomit_01"], self, "TAG_BREATH" );
    wait 1.0;
    playfxontag( level._ID1644["spider_vomit_01"], self, "TAG_BREATH" );
    wait 2.0;
    stopfxontag( level._ID1644["spider_vomit_01"], self, "TAG_BREATH" );
    wait 1.0;
    playfxontag( level._ID1644["spider_vomit_01"], self, "TAG_BREATH" );
    wait 2.0;
    stopfxontag( level._ID1644["spider_vomit_01"], self, "TAG_BREATH" );
}

_ID37239()
{
    self endon( "death" );
    wait 2.55;
    playfxontag( level._ID1644["spider_footstep_snow_vlg"], self, "J_Jaw" );
    wait 2.78;
    playfxontag( level._ID1644["spider_footstep_snow_vlg"], self, "J_Jaw" );
    wait 3.37;
    playfxontag( level._ID1644["spider_footstep_snow_vlg"], self, "J_Jaw" );
}

_ID37241()
{
    self endon( "death" );
    wait 3.7;
    playfxontag( level._ID1644["spider_footstep_snow_vlg"], self, "j_knee_04_f_r" );
    wait 2.05;
    playfxontag( level._ID1644["spider_footstep_snow_vlg"], self, "j_knee_04_b_l" );
    wait 2.41;
    playfxontag( level._ID1644["spider_footstep_snow_vlg"], self, "j_Hip" );
}
