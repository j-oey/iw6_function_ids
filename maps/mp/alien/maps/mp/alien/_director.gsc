// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

alien_attribute_table_init()
{
    if ( !isdefined( level._ID37075 ) )
        level._ID37075 = "mp/alien/default_alien_definition.csv";

    var_0 = [];
    var_0["ref"] = "0";
    var_0["name"] = "1";
    var_0["model"] = "2";
    var_0["desc"] = "3";
    var_0["boss"] = 4;
    var_0["animclass"] = "5";
    var_0["health"] = 10;
    var_0["min_cumulative_pain_threshold"] = 11;
    var_0["min_cumulative_pain_buffer_time"] = 12.0;
    var_0["accuracy"] = 13.0;
    var_0["speed"] = 14.0;
    var_0["scale"] = 15.0;
    var_0["xp"] = 16;
    var_0["attacker_difficulty"] = 17.0;
    var_0["attacker_priority"] = 18;
    var_0["jump_cost"] = 19.0;
    var_0["traverse_cost"] = 20.0;
    var_0["run_cost"] = 21.0;
    var_0["wall_run_cost"] = 29.0;
    var_0["heavy_damage_threshold"] = 22.0;
    var_0["pain_interval"] = 23.0;
    var_0["emissive_default"] = 24.0;
    var_0["emissive_max"] = 25.0;
    var_0["weight_scale"] = 26.0;
    var_0["reward"] = 27.0;
    var_0["view_height"] = 28.0;
    var_0["behavior_cloak"] = 100;
    var_0["behavior_spit"] = 101;
    var_0["behavior_lead"] = 102;
    var_0["behavior_hives"] = 103;
    var_0["swipe_min_damage"] = 2000;
    var_0["swipe_max_damage"] = 2001;
    var_0["leap_min_damage"] = 2002;
    var_0["leap_max_damage"] = 2003;
    var_0["wall_min_damage"] = 2004;
    var_0["wall_max_damage"] = 2005;
    var_0["charge_min_damage"] = 2006;
    var_0["charge_max_damage"] = 2007;
    var_0["explode_min_damage"] = 2008;
    var_0["explode_max_damage"] = 2009;
    var_0["slam_min_damage"] = 2010;
    var_0["slam_max_damage"] = 2011;
    var_0["synch_min_damage_per_second"] = 2012;
    var_0["synch_max_damage_per_second"] = 2013;
    var_1 = 1000;
    var_2 = 1100;

    for ( var_3 = var_1; var_3 < var_2; var_3++ )
    {
        var_4 = tablelookup( level._ID37075, 0, var_3, 1 );

        if ( var_4 == "" )
            break;

        var_0[var_4] = var_3 * 1.0;
    }

    level._ID2829 = [];
    var_5 = 18;

    for ( var_6 = 2; var_6 < var_5; var_6++ )
        _ID28920( var_0, var_6 );

    if ( isdefined( level._ID37049 ) )
        [[ level._ID37049 ]]();
}

_ID28920( var_0, var_1 )
{
    var_2 = tablelookup( level._ID37075, 0, var_0["ref"], var_1 );

    if ( var_2 == "" )
        return;

    level._ID2829[var_2] = spawnstruct();
    level._ID2829[var_2].attributes = [];
    level._ID2829[var_2]._ID20373 = [];

    foreach ( var_6, var_4 in var_0 )
    {
        var_5 = tablelookup( level._ID37075, 0, var_4, var_1 );

        if ( !isstring( var_4 ) )
        {
            if ( !issubstr( var_5, "." ) )
                var_5 = int( var_5 );
            else
                var_5 = float( var_5 );
        }

        level._ID2829[var_2].attributes[var_6] = var_5;

        if ( issubstr( var_6, "loot_" ) && var_5 > 0.0 )
            level._ID2829[var_2]._ID20373[var_6] = var_5;
    }
}

alien_cloak()
{
    self endon( "death" );
    thread _ID21890();

    for (;;)
    {
        if ( maps\mp\alien\_unk1464::any_player_nearby( self.origin, 800 ) )
        {
            wait 0.05;
            continue;
        }

        self waittill( "jump_launching" );
        wait 0.2;
        var_0 = self.model;
        maps\mp\alien\_alien_fx::_ID36685();
        _ID36976();
        self setmodel( var_0 + "_cloak" );
        common_scripts\utility::_ID35637( 1, "jump_finished", "damage" );
        wait 0.2;
        maps\mp\alien\_alien_fx::_ID36684();
        _ID38184();
        self setmodel( var_0 );
    }
}

_ID21890()
{
    self endon( "death" );

    for (;;)
    {
        if ( maps\mp\alien\_unk1464::any_player_nearby( self.origin, 800 ) )
            self notify( "near_player" );

        wait 0.05;
    }
}

_ID36976()
{
    playfxontag( level._ID1644["alien_cloaking"], self, "j_neck" );
}

_ID38184()
{
    playfxontag( level._ID1644["alien_uncloaking"], self, "j_neck" );
}

_ID30264()
{
    playfxontag( level._ID1644["alien_teleport"], self, "tag_origin" );
    playfxontag( level._ID1644["alien_teleport_dist"], self, "tag_origin" );
}
