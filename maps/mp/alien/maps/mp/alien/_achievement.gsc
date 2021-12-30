// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17800()
{
    self.achievement_list = [];

    if ( isdefined( level.achievement_registration_func ) )
        [[ level.achievement_registration_func ]]();

    if ( maps\mp\alien\_unk1464::_ID18506( level._ID17519 ) )
        register_default_achievements();
}

register_default_achievements()
{
    register_achievement( "KILL_WITH_TRAP", 50, ::default_init, ::_ID29849, ::equal_to_goal );
    register_achievement( "ESCAPE_ALL_PLAYERS", 4, ::default_init, ::default_should_update, ::at_least_goal );
    register_achievement( "ESCAPE_IN_TIME", 90000, ::default_init, ::default_should_update, ::at_least_goal );
    register_achievement( "ESCAPE_1ST_TIME", 1, ::default_init, ::default_should_update, ::at_least_goal );
    register_achievement( "ESCAPE_ALL_CHALLENGE", 1, ::default_init, ::_ID38022, ::at_least_goal );
    register_achievement( "ESCAPE_WITH_NERF_ON", 1, ::default_init, ::default_should_update, ::at_least_goal );
    register_achievement( "REACH_CITY", 1, ::default_init, ::default_should_update, ::at_least_goal );
    register_achievement( "REACH_CABIN", 1, ::default_init, ::default_should_update, ::at_least_goal );
    register_achievement( "SCAVENGE_ITEM", 40, ::default_init, ::default_should_update, ::equal_to_goal );
}

register_achievement( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = spawnstruct();
    var_6 [[ var_2 ]]( var_1, var_3, var_4, var_5 );
    self.achievement_list[var_0] = var_6;
}

default_init( var_0, var_1, var_2, var_3 )
{
    self._ID25048 = 0;
    self.goal = var_0;
    self._ID29848 = var_1;
    self._ID18424 = var_2;
    self.achievement_completed = 0;

    if ( isdefined( var_3 ) )
        self.complete_in_casual = var_3;
}

default_should_update( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    return 1;
}

_ID34464( var_0 )
{
    self._ID25048 = self._ID25048 + var_0;
}

at_least_goal()
{
    return self._ID25048 >= self.goal;
}

equal_to_goal()
{
    return self._ID25048 == self.goal;
}

_ID18382()
{
    return self.achievement_completed;
}

can_complete_in_causal()
{
    return maps\mp\alien\_unk1464::_ID18506( self.complete_in_casual );
}

mark_completed()
{
    self.achievement_completed = 1;
}

_ID18512( var_0 )
{
    return isdefined( var_0 );
}

update_achievement( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    var_12 = self.achievement_list[var_0];

    if ( !_ID18512( var_12 ) )
        return;

    if ( var_12 _ID18382() )
        return;

    if ( maps\mp\alien\_unk1464::is_casual_mode() && !var_12 can_complete_in_causal() )
        return;

    if ( var_12 [[ var_12._ID29848 ]]( var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 ) )
    {
        var_12 _ID34464( var_1 );

        if ( var_12 [[ var_12._ID18424 ]]() )
        {
            self giveachievement( var_0 );
            var_12 mark_completed();
        }
    }
}

_ID34396( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( isdefined( level._ID38192 ) )
        [[ level._ID38192 ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );

    if ( !isdefined( var_1 ) || !isplayer( var_1 ) )
        return;

    var_1 update_achievement( "KILL_WITH_TRAP", 1, var_0 );
}

_ID29849( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( maps\mp\alien\_unk1464::is_trap( var_0 ) )
        return 1;

    return 0;
}

_ID34422( var_0, var_1 )
{
    var_2 = var_0.size;

    foreach ( var_4 in var_0 )
    {
        var_5 = var_4 maps\mp\alien\_persistence::get_player_escaped();
        var_6 = var_4 maps\mp\alien\_prestige::_ID14611();
        var_4 _ID34453( var_2, var_1, var_5, var_6 );
    }
}

_ID34453( var_0, var_1, var_2, var_3 )
{
    update_achievement( "ESCAPE_ALL_PLAYERS", var_0 );
    update_achievement( "ESCAPE_IN_TIME", var_1 );
    update_achievement( "ESCAPE_1ST_TIME", var_2 );
    update_achievement( "ESCAPE_ALL_CHALLENGE", 1 );
    update_achievement( "ESCAPE_WITH_NERF_ON", var_3 );
}

_ID38022( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    return level.all_challenge_completed;
}

_ID34404( var_0 )
{
    switch ( var_0 )
    {
        case "lodge_lung_3":
            update_achievement_all_players( "REACH_CITY", 1 );
            break;
        case "city_lung_5":
            update_achievement_all_players( "REACH_CABIN", 1 );
            break;
        default:
            break;
    }
}

update_achievement_all_players( var_0, var_1 )
{
    foreach ( var_3 in level.players )
        var_3 update_achievement( var_0, var_1 );
}

_ID34471()
{
    update_achievement( "SCAVENGE_ITEM", 1 );
}

_ID38188( var_0 )
{
    if ( isdefined( level._ID38190 ) )
        self [[ level._ID38190 ]]( var_0 );
}

_ID37143( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    level common_scripts\utility::_ID35626( "regular_hive_destroyed", "obelisk_destroyed", "outpost_encounter_completed" );
    var_1 = self getcoopplayerdata( "alienPlayerStats", "deaths" );
    var_2 = self getcoopplayerdatareservedint( "eggstra_state_flags" );
    var_3 = var_2 >> var_0 * 4 & 15;

    if ( var_3 == 15 )
    {
        var_4 = self getcoopplayerdatareservedint( "eggstra_award_flags" );
        var_5 = 0;

        if ( var_1 == 1015 && ( var_4 & 1 ) != 1 )
        {
            var_4 |= 1;
            var_5 = 1;
        }

        if ( ( var_4 & 1 << var_0 ) == 0 )
        {
            var_4 |= 1 << var_0;
            var_5 = 1;
            self setclientomnvar( "ui_alien_eggstra_xp", 1 );
            thread maps\mp\alien\_persistence::wait_and_give_player_xp( 10000, 5.0 );
        }

        if ( var_5 == 1 )
            self setcoopplayerdatareservedint( "eggstra_award_flags", var_4 );

        _ID38216( var_0 );
    }
}

_ID38216( var_0 )
{
    switch ( var_0 )
    {
        case 0:
            update_achievement( "GOT_THEEGGSTRA_XP", 1 );
            break;
        case 1:
            update_achievement( "GOT_THEEGGSTRA_XP_DLC2", 1 );
            break;
        case 2:
            update_achievement( "GOT_THEEGGSTRA_XP_DLC3", 1 );
            break;
        case 3:
            update_achievement( "GOT_THEEGGSTRA_XP_DLC4", 1 );
            break;
        default:
            break;
    }
}

_ID38208( var_0 )
{
    var_0 = 0;
    var_1 = getdvar( "ui_mapname" );

    if ( var_1 == "mp_alien_armory" )
        var_0 = 1;

    if ( var_1 == "mp_alien_beacon" )
        var_0 = 2;

    if ( var_1 == "mp_alien_dlc3" )
        var_0 = 3;

    if ( var_1 == "mp_alien_last" )
        var_0 = 4;

    switch ( var_0 )
    {
        case 1:
            update_achievement( "FOUND_ALL_INTELS", 1 );
            break;
        case 2:
            update_achievement( "FOUND_ALL_INTELS_MAYDAY", 1 );
            break;
        case 3:
            update_achievement( "AWAKENING_ALL_INTEL", 1 );
            break;
        case 4:
            update_achievement( "LAST_ALL_INTEL", 1 );
        default:
            break;
    }
}
