// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID37874()
{
    maps\mp\alien\_achievement::register_achievement( "REACH_COMPOUND", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal );
    maps\mp\alien\_achievement::register_achievement( "REACH_FACILITY", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal );
    maps\mp\alien\_achievement::register_achievement( "KILLBOSS_1ST_TIME", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal );
    maps\mp\alien\_achievement::register_achievement( "KILLBOSS_IN_TIME", 300000, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, ::_ID37613 );
    maps\mp\alien\_achievement::register_achievement( "KILL_WITH_SWEAPON", 50, maps\mp\alien\_achievement::default_init, ::_ID38024, maps\mp\alien\_achievement::equal_to_goal );
    maps\mp\alien\_achievement::register_achievement( "COMPLETE_ALL_CHALLENGE", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::_ID38022, maps\mp\alien\_achievement::at_least_goal );
    maps\mp\alien\_achievement::register_achievement( "KILLBOSS_WITH_RELIC", 1, maps\mp\alien\_achievement::default_init, ::_ID37542, maps\mp\alien\_achievement::at_least_goal );
    maps\mp\alien\_achievement::register_achievement( "KILL_PHANTOMS", 5, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::equal_to_goal );
    maps\mp\alien\_achievement::register_achievement( "KILL_RHINO_PISTOL", 1, maps\mp\alien\_achievement::default_init, ::_ID38023, maps\mp\alien\_achievement::equal_to_goal );
    maps\mp\alien\_achievement::register_achievement( "FOUND_ALL_INTELS", 11, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal, 1 );
    maps\mp\alien\_achievement::register_achievement( "GOT_THEEGGSTRA_XP", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal, 1 );
    thread _ID36642::init_player_intel_total();
}

_ID37613()
{
    return self._ID25048 <= self.goal;
}

_ID38191( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isdefined( var_1 ) || !isplayer( var_1 ) )
        return;

    var_1 maps\mp\alien\_achievement::update_achievement( "KILL_WITH_SWEAPON", 1, var_4 );

    if ( isdefined( self.alien_type ) && self.alien_type == "locust" )
        var_1 maps\mp\alien\_achievement::update_achievement( "KILL_PHANTOMS", 1 );

    if ( isdefined( var_4 ) && maps\mp\_utility::getweaponclass( var_4 ) == "weapon_pistol" && isdefined( self._ID38012 ) )
        var_1 maps\mp\alien\_achievement::update_achievement( "KILL_RHINO_PISTOL", 1, self.alien_type, self._ID38012 );
}

_ID38023( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( isdefined( var_0 ) && var_0 == "elite" && isdefined( var_1 ) && var_1 )
        return 1;

    return 0;
}

_ID38024( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( var_0 == "iw6_aliendlc11_mp" )
        return 1;

    return 0;
}

_ID37542( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    return var_0 maps\mp\alien\_prestige::_ID14611() != 0;
}

_ID38195( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "compound":
            maps\mp\alien\_achievement::update_achievement_all_players( "REACH_COMPOUND", 1 );
            break;
        case "facility":
            maps\mp\alien\_achievement::update_achievement_all_players( "REACH_FACILITY", 1 );
            break;
        case "final":
            maps\mp\alien\_achievement::update_achievement_all_players( "KILLBOSS_1ST_TIME", 1 );
            maps\mp\alien\_achievement::update_achievement_all_players( "KILLBOSS_IN_TIME", var_1 );
            maps\mp\alien\_achievement::update_achievement_all_players( "COMPLETE_ALL_CHALLENGE", 1 );

            foreach ( var_3 in level.players )
                var_3 maps\mp\alien\_achievement::update_achievement( "KILLBOSS_WITH_RELIC", 1, var_3 );

            break;
        default:
            break;
    }
}

_ID38189( var_0 )
{
    if ( maps\mp\_utility::getweaponclass( var_0 ) != "weapon_pistol" )
        self._ID38012 = 0;

    if ( ( !isdefined( self._ID38012 ) || self._ID38012 ) && maps\mp\_utility::getweaponclass( var_0 ) == "weapon_pistol" )
        self._ID38012 = 1;
}
