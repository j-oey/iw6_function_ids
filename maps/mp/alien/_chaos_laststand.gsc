// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

chaos_playerlaststand( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = chaos_gameshouldend( self );

    if ( var_8 )
        maps\mp\alien\_chaos_utility::chaos_end_game();

    if ( maps\mp\alien\_laststand::_ID37533( var_7 ) )
        return process_killed_by_kill_trigger( var_7 );

    chaos_dropintolaststand( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
}

process_killed_by_kill_trigger( var_0 )
{
    self setorigin( var_0.origin );
    maps\mp\alien\_death::set_kill_trigger_event_processed( self, 0 );

    if ( !self._ID18011 )
        self dodamage( 1000, self.origin );

    return;
}

chaos_dropintolaststand( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "last_stand" );
    maps\mp\alien\_laststand::_ID12123();
    maps\mp\alien\_laststand::_ID12126();

    if ( maps\mp\alien\_laststand::_ID14542() > 0 )
        chaos_self_revive( var_8 );
    else
        maps\mp\alien\_laststand::_ID35517( self, self.origin, undefined, undefined, 1, 3000, ( 0.33, 0.75, 0.24 ), undefined, 0, var_8, 1 );

    self notify( "revive" );
    maps\mp\alien\_laststand::exit_laststand();
    maps\mp\alien\_laststand::exit_gamemodespecificaction();
}

chaos_self_revive( var_0 )
{
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );
    set_in_chaos_self_revive( self, 1 );
    maps\mp\alien\_laststand::_ID32384( self, 1 );
    maps\mp\alien\_laststand::register_laststand_ammo();
    return wait_for_chaos_self_revive( var_0, 15 );
}

wait_for_chaos_self_revive( var_0, var_1 )
{
    if ( var_0 )
    {
        level waittill( "forever" );
        return 0;
    }

    maps\mp\alien\_hud::set_last_stand_timer( self, var_1 );
    common_scripts\utility::_ID35637( var_1, "revive_success" );
    maps\mp\alien\_hud::clear_last_stand_timer( self );
    return 1;
}

chaos_gameshouldend( var_0 )
{
    return get_team_self_revive_count() == 0 && maps\mp\alien\_laststand::everyone_else_all_in_laststand( var_0 ) && no_one_else_in_chaos_self_revive( var_0 );
}

no_one_else_in_chaos_self_revive( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( var_2 == var_0 )
            continue;

        if ( is_in_chaos_self_revive( var_2 ) )
            return 0;
    }

    return 1;
}

get_team_self_revive_count()
{
    var_0 = 0;

    foreach ( var_2 in level.players )
        var_0 += var_2 maps\mp\alien\_laststand::_ID14542();

    return var_0;
}

chaos_player_init_laststand()
{
    if ( common_scripts\utility::_ID13177( "chaos_pre_game_is_over" ) )
        return;

    maps\mp\alien\_laststand::_ID28441( self, 3 );
    thread maps\mp\alien\_laststand::_ID37478( 3 );
}

chaos_exit_gamemodespecificaction( var_0 )
{
    var_0 maps\mp\alien\_damage::_ID28656( level._ID9659 );
    var_0 notify( "enable_armor" );
    var_0 set_in_chaos_self_revive( self, 0 );
    maps\mp\alien\_chaos::process_chaos_event( "refill_combo_meter" );
}

set_in_chaos_self_revive( var_0, var_1 )
{
    var_0.in_chaos_self_revive = var_1;
}

should_instant_revive( var_0 )
{
    return isdefined( var_0 ) && is_in_chaos_self_revive( var_0 );
}

is_in_chaos_self_revive( var_0 )
{
    return maps\mp\alien\_unk1464::_ID18506( var_0.in_chaos_self_revive );
}
