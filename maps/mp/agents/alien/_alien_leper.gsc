// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

leper_init()
{
    self.leperdespawntime = gettime() + 35000;
    thread _ID16104();
}

leper_combat( var_0 )
{
    self endon( "death" );
    var_0 endon( "death" );
    leper_retreat( var_0 );
}

leper_retreat( var_0 )
{
    for (;;)
    {
        _ID19823( var_0 );
        _ID19830( var_0 );
    }
}

_ID19825( var_0 )
{
    self endon( "leper_despawn" );
    self endon( "death" );
    wait(var_0);
    leper_despawn();
}

_ID16104()
{
    self endon( "death" );

    for (;;)
    {
        self.favoriteenemy = maps\mp\alien\_unk1464::_ID14352();
        wait 5;
    }
}

leper_despawn()
{
    self endon( "death" );
    self.health = 30000;
    self.maxhealth = 30000;
    self scragentsetgoalpos( self.origin );
    self scragentsetgoalradius( 2048 );
    playfxontag( level._ID1644["alien_teleport"], self, "tag_origin" );
    wait 1.0;
    self suicide();
}

_ID19823( var_0 )
{
    var_1 = get_leper_retreat_node( var_0 );

    if ( !isdefined( var_1 ) )
    {
        wait 1;
        return;
    }

    self scragentsetgoalnode( var_1 );
    self scragentsetgoalradius( 64 );
    self waittill( "goal_reached" );
}

leave_node_on_distance_breach( var_0 )
{
    var_0 endon( "death" );
    self endon( "death" );
    self endon( "enemy" );
    self endon( "alien_main_loop_restart" );
    self endon( "leave_node " );

    for (;;)
    {
        if ( distancesquared( var_0.origin, self.origin ) < 1048576 )
            self notify( "leave_node" );

        wait 1;
    }
}

leave_node_on_attacked( var_0 )
{
    var_0 endon( "death" );
    self endon( "death" );
    self endon( "enemy" );
    self endon( "alien_main_loop_restart" );
    self endon( "leave_node " );
    self waittill( "damage" );
    wait 1.5;
    self notify( "leave_node" );
}

_ID19830( var_0 )
{
    self endon( "leave_node" );
    thread leave_node_on_attacked( var_0 );
    thread leave_node_on_distance_breach( var_0 );
    wait 5.0;
}

get_leper_retreat_node( var_0 )
{
    var_1 = get_named_retreat_nodes();

    if ( !isdefined( var_1 ) )
        var_1 = _ID14691();

    var_2 = [];
    var_2["direction"] = "override";
    var_2["direction_override"] = get_direction_away_from_players();
    var_2["direction_weight"] = 2.0;
    var_2["min_height"] = 64.0;
    var_2["max_height"] = 500.0;
    var_2["height_weight"] = 2.0;
    var_2["enemy_los"] = 0;
    var_2["enemy_los_weight"] = 2.0;
    var_2["min_dist_from_enemy"] = 500.0;
    var_2["max_dist_from_enemy"] = 2048.0;
    var_2["desired_dist_from_enemy"] = 1500.0;
    var_2["dist_from_enemy_weight"] = 3.0;
    var_2["min_dist_from_all_enemies"] = 800.0;
    var_2["min_dist_from_all_enemies_weight"] = 5.0;
    var_2["not_recently_used_weight"] = 4.0;
    var_2["random_weight"] = 1.5;
    var_3 = maps\mp\agents\alien\_alien_think::get_retreat_node_rated( var_0, var_2, var_1 );
    return var_3;
}

_ID14691()
{
    var_0 = getnodesinradius( self.origin, 1024, 400, 500, "jump" );
    return var_0;
}

get_direction_away_from_players()
{
    if ( level.players.size == 0 )
        return self.origin + anglestoforward( self.angles ) * 100;

    var_0 = ( 0, 0, 0 );

    foreach ( var_2 in level.players )
        var_0 += var_2.origin;

    var_0 /= level.players.size;
    return self.origin - var_0;
}

_ID19824()
{
    return;
}

get_named_retreat_nodes()
{
    var_0 = maps\mp\alien\_unk1464::_ID37267();
    var_1 = getnodearray( var_0 + "_leper_location", "targetname" );

    if ( isdefined( var_1 ) && var_1.size > 0 )
        return var_1;

    return undefined;
}
