// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

bot_killstreak_sentry( var_0, var_1, var_2, var_3 )
{
    self endon( "bot_sentry_exited" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait(randomintrange( 3, 5 ));

    while ( isdefined( self.sentry_place_delay ) && gettime() < self.sentry_place_delay )
        wait 1;

    if ( isdefined( self.enemy ) && self.enemy.health > 0 && self botcanseeentity( self.enemy ) )
        return 1;

    var_4 = self.origin;

    if ( var_3 != "hide_nonlethal" )
    {
        var_4 = bot_sentry_choose_target( var_3 );

        if ( !isdefined( var_4 ) )
            return 1;
    }

    bot_sentry_add_goal( var_0, var_4, var_3, var_1 );

    while ( maps\mp\bots\_bots_strategy::bot_has_tactical_goal( "sentry_placement" ) )
        wait 0.5;

    return 1;
}

bot_sentry_add_goal( var_0, var_1, var_2, var_3 )
{
    var_4 = bot_sentry_choose_placement( var_0, var_1, var_2, var_3 );

    if ( isdefined( var_4 ) )
    {
        maps\mp\bots\_bots_strategy::bot_abort_tactical_goal( "sentry_placement" );
        var_5 = spawnstruct();
        var_5._ID22470 = var_4;
        var_5._ID27625 = var_4._ID36481;
        var_5.script_goal_radius = 10;
        var_5._ID31408 = ::bot_sentry_path_start;
        var_5.end_thread = ::_ID5759;
        var_5._ID29800 = ::_ID5767;
        var_5.action_thread = ::bot_sentry_activate;
        self._ID23673 = var_0._ID31889;
        maps\mp\bots\_bots_strategy::bot_new_tactical_goal( "sentry_placement", var_4.node.origin, 0, var_5 );
    }
}

_ID5767( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( isdefined( self.enemy ) && self.enemy.health > 0 && self botcanseeentity( self.enemy ) )
        return 1;

    self.sentry_place_delay = gettime() + 1000;
    return 0;
}

bot_sentry_cancel_failsafe()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "bot_sentry_canceled" );
    self endon( "bot_sentry_ensure_exit" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( isdefined( self.enemy ) && self.enemy.health > 0 && self botcanseeentity( self.enemy ) )
            thread _ID5759();

        wait 0.05;
    }
}

bot_sentry_path_start( var_0 )
{
    thread bot_sentry_path_thread( var_0 );
}

bot_sentry_path_thread( var_0 )
{
    self endon( "stop_tactical_goal" );
    self endon( "stop_goal_aborted_watch" );
    self endon( "bot_sentry_canceled" );
    self endon( "bot_sentry_exited" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( isdefined( var_0._ID22470 ) && isdefined( var_0._ID22470.weapon ) )
    {
        if ( distance2d( self.origin, var_0._ID22470.node.origin ) < 400 )
        {
            thread maps\mp\bots\_bots_util::bot_force_stance_for_time( "stand", 5.0 );
            thread bot_sentry_cancel_failsafe();
            maps\mp\bots\_bots_ks::bot_switch_to_killstreak_weapon( var_0._ID22470.killstreak_info, var_0._ID22470.killstreaks_array, var_0._ID22470.weapon );
            return;
        }

        wait 0.05;
    }
}

bot_sentry_choose_target( var_0 )
{
    var_1 = maps\mp\bots\_bots_util::defend_valid_center();

    if ( isdefined( var_1 ) )
        return var_1;

    if ( isdefined( self._ID22077 ) )
        return self._ID22077.origin;

    var_2 = getnodesinradius( self.origin, 1000, 0, 512 );
    var_3 = 5;

    if ( var_0 != "turret" )
    {
        if ( self botgetdifficultysetting( "strategyLevel" ) == 1 )
            var_3 = 10;
        else if ( self botgetdifficultysetting( "strategyLevel" ) == 0 )
            var_3 = 15;
    }

    if ( var_0 == "turret_air" )
        var_4 = self botnodepick( var_2, var_3, "node_traffic", "ignore_no_sky" );
    else
        var_4 = self botnodepick( var_2, var_3, "node_traffic" );

    if ( isdefined( var_4 ) )
        return var_4.origin;
}

bot_sentry_choose_placement( var_0, var_1, var_2, var_3 )
{
    var_4 = undefined;
    var_5 = getnodesinradius( var_1, 1000, 0, 512 );
    var_6 = 5;

    if ( var_2 != "turret" )
    {
        if ( self botgetdifficultysetting( "strategyLevel" ) == 1 )
            var_6 = 10;
        else if ( self botgetdifficultysetting( "strategyLevel" ) == 0 )
            var_6 = 15;
    }

    if ( var_2 == "turret_air" )
        var_7 = self botnodepick( var_5, var_6, "node_sentry", var_1, "ignore_no_sky" );
    else if ( var_2 == "trap" )
        var_7 = self botnodepick( var_5, var_6, "node_traffic" );
    else if ( var_2 == "hide_nonlethal" )
        var_7 = self botnodepick( var_5, var_6, "node_hide" );
    else
        var_7 = self botnodepick( var_5, var_6, "node_sentry", var_1 );

    if ( isdefined( var_7 ) )
    {
        var_4 = spawnstruct();
        var_4.node = var_7;

        if ( var_1 != var_7.origin && var_2 != "hide_nonlethal" )
            var_4._ID36481 = vectortoyaw( var_1 - var_7.origin );
        else
            var_4._ID36481 = undefined;

        var_4.weapon = var_0.weapon;
        var_4.killstreak_info = var_0;
        var_4.killstreaks_array = var_3;
    }

    return var_4;
}

bot_sentry_carried_obj()
{
    if ( isdefined( self._ID6724 ) )
        return self._ID6724;

    if ( isdefined( self._ID6722 ) )
        return self._ID6722;

    if ( isdefined( self.carrieditem ) )
        return self.carrieditem;
}

bot_sentry_activate( var_0 )
{
    var_1 = 0;
    var_2 = bot_sentry_carried_obj();

    if ( isdefined( var_2 ) )
    {
        var_3 = 0;

        if ( !var_2.canbeplaced )
        {
            var_4 = 0.75;
            var_5 = gettime();
            var_6 = self.angles[1];

            if ( isdefined( var_0._ID22470._ID36481 ) )
                var_6 = var_0._ID22470._ID36481;

            var_7 = [];
            var_7[0] = var_6 + 180;
            var_7[1] = var_6 + 135;
            var_7[2] = var_6 - 135;
            var_8 = 1000;

            foreach ( var_10 in var_7 )
            {
                var_11 = playerphysicstrace( var_0._ID22470.node.origin, var_0._ID22470.node.origin + anglestoforward( ( 0, var_10 + 180, 0 ) ) * 100 );
                var_12 = distance2d( var_11, var_0._ID22470.node.origin );

                if ( var_12 < var_8 )
                {
                    var_8 = var_12;
                    self botsetscriptmove( var_10, var_4 );
                    self botlookatpoint( var_0._ID22470.node.origin, var_4, "script_forced" );
                }
            }

            while ( !var_3 && isdefined( var_2 ) && !var_2.canbeplaced )
            {
                var_14 = float( gettime() - var_5 ) / 1000.0;

                if ( !var_2.canbeplaced && var_14 > var_4 )
                {
                    var_3 = 1;
                    self.sentry_place_delay = gettime() + 30000;
                }

                wait 0.05;
            }
        }

        if ( isdefined( var_2 ) && var_2.canbeplaced )
        {
            _ID5756();
            var_1 = 1;
        }
    }

    wait 0.25;
    bot_sentry_ensure_exit();
    return var_1;
}

_ID5756()
{
    self notify( "place_sentry" );
    self notify( "place_ims" );
    self notify( "placePlaceable" );
}

bot_send_cancel_notify()
{
    self switchtoweapon( "none" );
    self enableweapons();
    self enableweaponswitch();
    self notify( "cancel_sentry" );
    self notify( "cancel_ims" );
    self notify( "cancelPlaceable" );
}

_ID5759( var_0 )
{
    self notify( "bot_sentry_canceled" );
    bot_send_cancel_notify();
    bot_sentry_ensure_exit();
}

bot_sentry_ensure_exit()
{
    self notify( "bot_sentry_abort_goal_think" );
    self notify( "bot_sentry_ensure_exit" );
    self endon( "bot_sentry_ensure_exit" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self switchtoweapon( "none" );
    self botclearscriptgoal();
    self botsetstance( "none" );
    self enableweapons();
    self enableweaponswitch();
    wait 0.25;
    var_0 = 0;

    while ( isdefined( bot_sentry_carried_obj() ) )
    {
        var_0++;
        bot_send_cancel_notify();
        wait 0.25;

        if ( var_0 > 2 )
            bot_sentry_force_cancel();
    }

    self notify( "bot_sentry_exited" );
}

bot_sentry_force_cancel()
{
    if ( isdefined( self._ID6724 ) )
        self._ID6724 maps\mp\killstreaks\_autosentry::_ID28138();

    if ( isdefined( self._ID6722 ) )
        self._ID6722 maps\mp\killstreaks\_ims::ims_setcancelled();

    if ( isdefined( self.carrieditem ) )
        self.carrieditem maps\mp\killstreaks\_unk1556::_ID22783( self._ID23673, 0 );

    self._ID6724 = undefined;
    self._ID6722 = undefined;
    self.carrieditem = undefined;
    self switchtoweapon( "none" );
    self enableweapons();
    self enableweaponswitch();
}
