// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

bot_killstreak_setup()
{
    if ( !isdefined( level._ID19248 ) )
    {
        bot_register_killstreak_func( "ball_drone_backup", ::bot_killstreak_simple_use, ::bot_can_use_ball_drone );
        bot_register_killstreak_func( "ball_drone_radar", ::bot_killstreak_simple_use, ::bot_can_use_ball_drone );
        bot_register_killstreak_func( "guard_dog", ::bot_killstreak_simple_use );
        bot_register_killstreak_func( "recon_agent", ::bot_killstreak_simple_use );
        bot_register_killstreak_func( "agent", ::bot_killstreak_simple_use );
        bot_register_killstreak_func( "nuke", ::bot_killstreak_simple_use );
        bot_register_killstreak_func( "jammer", ::bot_killstreak_simple_use, ::_ID5514 );
        bot_register_killstreak_func( "air_superiority", ::bot_killstreak_simple_use, ::bot_can_use_air_superiority );
        bot_register_killstreak_func( "helicopter", ::bot_killstreak_simple_use, ::aerial_vehicle_allowed );
        bot_register_killstreak_func( "specialist", ::bot_killstreak_simple_use );
        bot_register_killstreak_func( "all_perks_bonus", ::bot_killstreak_simple_use );
        bot_register_killstreak_func( "airdrop_juggernaut", ::bot_killstreak_drop_outside );
        bot_register_killstreak_func( "airdrop_juggernaut_maniac", ::bot_killstreak_drop_outside );
        bot_register_killstreak_func( "airdrop_juggernaut_recon", ::bot_killstreak_drop_outside );
        bot_register_killstreak_func( "uav_3dping", ::bot_killstreak_drop_outside );
        bot_register_killstreak_func( "deployable_vest", ::_ID5640 );
        bot_register_killstreak_func( "deployable_ammo", ::_ID5640 );
        bot_register_killstreak_func( "odin_assault", maps\mp\bots\_bots_ks_remote_vehicle::bot_killstreak_remote_control, ::aerial_vehicle_allowed, maps\mp\bots\_bots_ks_remote_vehicle::_ID5530 );
        bot_register_killstreak_func( "odin_support", maps\mp\bots\_bots_ks_remote_vehicle::bot_killstreak_remote_control, ::aerial_vehicle_allowed, maps\mp\bots\_bots_ks_remote_vehicle::_ID5531 );
        bot_register_killstreak_func( "heli_pilot", maps\mp\bots\_bots_ks_remote_vehicle::bot_killstreak_remote_control, maps\mp\bots\_bots_ks_remote_vehicle::_ID16636, maps\mp\bots\_bots_ks_remote_vehicle::bot_control_heli_pilot );
        bot_register_killstreak_func( "heli_sniper", maps\mp\bots\_bots_ks_remote_vehicle::bot_killstreak_remote_control, maps\mp\bots\_bots_ks_remote_vehicle::_ID16652, maps\mp\bots\_bots_ks_remote_vehicle::bot_control_heli_sniper );
        bot_register_killstreak_func( "drone_hive", maps\mp\bots\_bots_ks_remote_vehicle::bot_killstreak_remote_control, undefined, maps\mp\bots\_bots_ks_remote_vehicle::_ID5532 );
        bot_register_killstreak_func( "vanguard", maps\mp\bots\_bots_ks_remote_vehicle::_ID5656, maps\mp\bots\_bots_ks_remote_vehicle::_ID34847, maps\mp\bots\_bots_ks_remote_vehicle::bot_control_vanguard );
        bot_register_killstreak_func( "ims", maps\mp\bots\_bots_sentry::bot_killstreak_sentry, undefined, "trap" );
        bot_register_killstreak_func( "sentry", maps\mp\bots\_bots_sentry::bot_killstreak_sentry, undefined, "turret" );
        bot_register_killstreak_func( "uplink", maps\mp\bots\_bots_sentry::bot_killstreak_sentry, undefined, "hide_nonlethal" );
        bot_register_killstreak_func( "uplink_support", maps\mp\bots\_bots_sentry::bot_killstreak_sentry, undefined, "hide_nonlethal" );
        bot_register_killstreak_func( "aa_launcher", ::bot_killstreak_never_use, ::bot_can_use_aa_launcher );
        bot_register_killstreak_func( "airdrop_assault", ::bot_killstreak_drop_outside );

        if ( isdefined( level._ID20635 ) )
            [[ level._ID20635 ]]();
    }

    thread maps\mp\bots\_bots_ks_remote_vehicle::_ID25812();
}

bot_register_killstreak_func( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( level._ID19248 ) )
        level._ID19248 = [];

    level._ID19248[var_0] = var_1;

    if ( !isdefined( level._ID19247 ) )
        level._ID19247 = [];

    level._ID19247[var_0] = var_2;

    if ( !isdefined( level.killstreak_botparm ) )
        level.killstreak_botparm = [];

    level.killstreak_botparm[var_0] = var_3;

    if ( !isdefined( level.bot_supported_killstreaks ) )
        level.bot_supported_killstreaks = [];

    level.bot_supported_killstreaks[level.bot_supported_killstreaks.size] = var_0;
}

bot_killstreak_valid_for_specific_streaktype( var_0, var_1, var_2 )
{
    if ( maps\mp\_utility::bot_is_fireteam_mode() )
        return 1;

    if ( bot_killstreak_is_valid_internal( var_0, "bots", undefined, var_1 ) )
        return 1;
    else if ( var_2 )
    {

    }

    return 0;
}

bot_killstreak_is_valid_internal( var_0, var_1, var_2, var_3 )
{
    var_4 = undefined;

    if ( var_0 == "specialist" )
        return 1;

    if ( !_ID5649( var_0, var_1 ) )
        return 0;

    if ( isdefined( var_3 ) )
    {
        var_4 = getsubstr( var_3, 11 );

        switch ( var_4 )
        {
            case "assault":
                if ( !maps\mp\_utility::isassaultkillstreak( var_0 ) )
                    return 0;

                break;
            case "support":
                if ( !maps\mp\_utility::issupportkillstreak( var_0 ) )
                    return 0;

                break;
            case "specialist":
                if ( !maps\mp\_utility::_ID18795( var_0 ) )
                    return 0;

                break;
        }
    }

    return 1;
}

_ID5649( var_0, var_1 )
{
    if ( var_1 == "humans" )
        return isdefined( level._ID19256[var_0] ) && maps\mp\_utility::_ID15099( var_0 ) != -1;
    else if ( var_1 == "bots" )
        return isdefined( level._ID19248[var_0] );
}

bot_think_killstreak()
{
    self notify( "bot_think_killstreak" );
    self endon( "bot_think_killstreak" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( !isdefined( level._ID19248 ) )
        wait 0.05;

    childthread bot_start_aa_launcher_tracking();

    for (;;)
    {
        if ( maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks() )
        {
            var_0 = self.pers["killstreaks"];

            if ( isdefined( var_0 ) )
            {
                var_1 = 0;

                for ( var_2 = 0; var_2 < var_0.size && !var_1; var_2++ )
                {
                    var_3 = var_0[var_2];

                    if ( isdefined( var_3._ID31889 ) && isdefined( self._ID5657 ) && isdefined( self._ID5657[var_3._ID31889] ) && gettime() < self._ID5657[var_3._ID31889] )
                        continue;

                    if ( var_3.available )
                    {
                        var_4 = var_3._ID31889;

                        if ( var_3._ID31889 == "all_perks_bonus" )
                            continue;

                        if ( maps\mp\_utility::_ID18795( var_3._ID31889 ) )
                        {
                            if ( !var_3._ID11210 )
                                var_4 = "specialist";
                            else
                                continue;
                        }

                        var_3.weapon = maps\mp\_utility::getkillstreakweapon( var_3._ID31889 );
                        var_5 = level._ID19247[var_4];

                        if ( isdefined( var_5 ) && !self [[ var_5 ]]() )
                            continue;

                        if ( !maps\mp\_utility::_ID34840( var_3._ID31889, 1 ) )
                            continue;

                        var_6 = level._ID19248[var_4];

                        if ( isdefined( var_6 ) )
                        {
                            var_7 = self [[ var_6 ]]( var_3, var_0, var_5, level.killstreak_botparm[var_3._ID31889] );

                            if ( !isdefined( var_7 ) || var_7 == 0 )
                            {
                                if ( !isdefined( self._ID5657 ) )
                                    self._ID5657 = [];

                                self._ID5657[var_3._ID31889] = gettime() + 5000;
                            }
                        }
                        else
                        {
                            var_3.available = 0;
                            maps\mp\killstreaks\_killstreaks::_ID34551( 0 );
                        }

                        var_1 = 1;
                    }
                }
            }
        }

        wait(randomfloatrange( 1.0, 2.0 ));
    }
}

bot_can_use_aa_launcher()
{
    return 0;
}

bot_start_aa_launcher_tracking()
{
    var_0 = maps\mp\killstreaks\_unk1513::_ID14856();

    for (;;)
    {
        self waittill( "aa_launcher_fire" );
        var_1 = self getammocount( var_0 );

        if ( var_1 == 0 )
        {
            self switchtoweapon( var_0 );
            var_2 = common_scripts\utility::_ID35635( "LGM_player_allMissilesDestroyed", "enemy" );
            wait 0.5;
            self switchtoweapon( "none" );
        }
    }
}

bot_killstreak_never_use()
{

}

bot_can_use_air_superiority()
{
    if ( !aerial_vehicle_allowed() )
        return 0;

    var_0 = maps\mp\killstreaks\_air_superiority::findalltargets( self, self.team );
    var_1 = gettime();

    foreach ( var_3 in var_0 )
    {
        if ( var_1 - var_3.birthtime > 5000 )
            return 1;
    }

    return 0;
}

aerial_vehicle_allowed()
{
    if ( maps\mp\_utility::isairdenied() )
        return 0;

    if ( _ID35147() )
        return 0;

    return 1;
}

_ID35147()
{
    return maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 + 1 >= maps\mp\_utility::maxvehiclesallowed();
}

_ID5514()
{
    if ( isdefined( level._ID11399 ) )
        return 0;

    var_0 = level._ID23070[self.team];

    if ( isdefined( level._ID32657 ) && isdefined( level._ID32657[var_0] ) && level._ID32657[var_0] )
        return 0;

    return 1;
}

bot_can_use_ball_drone()
{
    if ( maps\mp\_utility::_ID18837() )
        return 0;

    if ( maps\mp\killstreaks\_unk1523::exceededmaxballdrones() )
        return 0;

    if ( _ID35147() )
        return 0;

    if ( isdefined( self.balldrone ) )
        return 0;

    return 1;
}

bot_killstreak_simple_use( var_0, var_1, var_2, var_3 )
{
    self endon( "commander_took_over" );
    wait(randomintrange( 3, 5 ));

    if ( !maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks() )
        return 1;

    if ( isdefined( var_2 ) && !self [[ var_2 ]]() )
        return 0;

    bot_switch_to_killstreak_weapon( var_0, var_1, var_0.weapon );
    return 1;
}

_ID5640( var_0, var_1, var_2, var_3 )
{
    bot_killstreak_drop( var_0, var_1, var_2, var_3, "anywhere" );
}

bot_killstreak_drop_outside( var_0, var_1, var_2, var_3 )
{
    bot_killstreak_drop( var_0, var_1, var_2, var_3, "outside" );
}

bot_killstreak_drop_hidden( var_0, var_1, var_2, var_3 )
{
    bot_killstreak_drop( var_0, var_1, var_2, var_3, "hidden" );
}

bot_killstreak_drop( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "commander_took_over" );
    wait(randomintrange( 2, 4 ));

    if ( !isdefined( var_4 ) )
        var_4 = "anywhere";

    if ( !maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks() )
        return 1;

    if ( isdefined( var_2 ) && !self [[ var_2 ]]() )
        return 0;

    var_5 = self getweaponammoclip( var_0.weapon ) + self getweaponammostock( var_0.weapon );

    if ( var_5 == 0 )
    {
        foreach ( var_7 in var_1 )
        {
            if ( isdefined( var_7._ID31889 ) && var_7._ID31889 == var_0._ID31889 )
                var_7.available = 0;
        }

        maps\mp\killstreaks\_killstreaks::_ID34551( 0 );
        return 1;
    }

    var_9 = undefined;

    if ( var_4 == "outside" )
    {
        var_10 = [];
        var_11 = maps\mp\bots\_bots_util::bot_get_nodes_in_cone( 750, 0.6, 1 );

        foreach ( var_13 in var_11 )
        {
            if ( nodeexposedtosky( var_13 ) )
                var_10 = common_scripts\utility::array_add( var_10, var_13 );
        }

        if ( var_11.size > 5 && var_10.size > var_11.size * 0.6 )
        {
            var_15 = common_scripts\utility::_ID14293( self.origin, var_10, undefined, undefined, undefined, 150 );

            if ( var_15.size > 0 )
                var_9 = common_scripts\utility::_ID25350( var_15 );
            else
                var_9 = common_scripts\utility::_ID25350( var_10 );
        }
    }
    else if ( var_4 == "hidden" )
    {
        var_16 = getnodesinradius( self.origin, 256, 0, 40 );
        var_17 = self getnearestnode();

        if ( isdefined( var_17 ) )
        {
            var_18 = [];

            foreach ( var_13 in var_16 )
            {
                if ( nodesvisible( var_17, var_13, 1 ) )
                    var_18 = common_scripts\utility::array_add( var_18, var_13 );
            }

            var_9 = self botnodepick( var_18, 1, "node_hide" );
        }
    }

    if ( isdefined( var_9 ) || var_4 == "anywhere" )
    {
        self botsetflag( "disable_movement", 1 );

        if ( isdefined( var_9 ) )
            self botlookatpoint( var_9.origin, 2.45, "script_forced" );

        bot_switch_to_killstreak_weapon( var_0, var_1, var_0.weapon );
        wait 2.0;
        self botpressbutton( "attack" );
        wait 1.5;
        self switchtoweapon( "none" );
        self botsetflag( "disable_movement", 0 );
    }

    return 1;
}

bot_switch_to_killstreak_weapon( var_0, var_1, var_2 )
{
    bot_notify_streak_used( var_0, var_1 );
    wait 0.05;
    self switchtoweapon( var_2 );
}

bot_notify_streak_used( var_0, var_1 )
{
    if ( isdefined( var_0._ID18639 ) && var_0._ID18639 )
        self notify( "streakUsed1" );
    else
    {
        for ( var_2 = 0; var_2 < 3; var_2++ )
        {
            if ( isdefined( var_1[var_2]._ID31889 ) )
            {
                if ( var_1[var_2]._ID31889 == var_0._ID31889 )
                    break;
            }
        }

        self notify( "streakUsed" + ( var_2 + 1 ) );
    }
}

bot_killstreak_choose_loc_enemies( var_0, var_1, var_2, var_3 )
{
    self endon( "commander_took_over" );
    wait(randomintrange( 3, 5 ));

    if ( !maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks() )
        return;

    var_4 = getzonenearest( self.origin );

    if ( !isdefined( var_4 ) )
        return;

    self botsetflag( "disable_movement", 1 );
    bot_switch_to_killstreak_weapon( var_0, var_1, var_0.weapon );
    wait 2;
    var_5 = level._ID36588;
    var_6 = -1;
    var_7 = 0;
    var_8 = [];
    var_9 = randomfloat( 100 ) > 50;

    for ( var_10 = 0; var_10 < var_5; var_10++ )
    {
        if ( var_9 )
            var_11 = var_5 - 1 - var_10;
        else
            var_11 = var_10;

        if ( var_11 != var_4 && botzonegetindoorpercent( var_11 ) < 0.25 )
        {
            var_12 = botzonegetcount( var_11, self.team, "enemy_predict" );

            if ( var_12 > var_7 )
            {
                var_6 = var_11;
                var_7 = var_12;
            }

            var_8 = common_scripts\utility::array_add( var_8, var_11 );
        }
    }

    if ( var_6 >= 0 )
        var_13 = getzoneorigin( var_6 );
    else if ( var_8.size > 0 )
        var_13 = getzoneorigin( common_scripts\utility::_ID25350( var_8 ) );
    else
        var_13 = getzoneorigin( randomint( level._ID36588 ) );

    var_14 = ( randomfloatrange( -500, 500 ), randomfloatrange( -500, 500 ), 0 );
    self notify( "confirm_location",  var_13 + var_14, randomintrange( 0, 360 )  );
    wait 1.0;
    self botsetflag( "disable_movement", 0 );
}

_ID5812()
{
    self notify( "bot_think_watch_aerial_killstreak" );
    self endon( "bot_think_watch_aerial_killstreak" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( !isdefined( level._ID19456 ) )
        level._ID19456 = -10000;

    level._ID19250["allies"] = [];
    level._ID19250["axis"] = [];
    var_0 = 0;
    var_1 = randomfloatrange( 0.05, 4.0 );

    for (;;)
    {
        wait(var_1);
        var_1 = randomfloatrange( 0.05, 4.0 );

        if ( maps\mp\bots\_bots_util::bot_is_remote_or_linked() )
            continue;

        if ( self botgetdifficultysetting( "strategyLevel" ) == 0 )
            continue;

        var_2 = 0;

        if ( isdefined( level.chopper ) && level.chopper.team != self.team )
            var_2 = 1;

        if ( isdefined( level._ID19723 ) && level._ID19723.team != self.team )
            var_2 = 1;

        if ( isdefined( level.heli_pilot[common_scripts\utility::_ID14447( self.team )] ) )
            var_2 = 1;

        if ( enemy_mortar_strike_exists( self.team ) )
        {
            var_2 = 1;
            _ID33769( "mortar_strike", ::enemy_mortar_strike_exists );
        }

        if ( enemy_switchblade_exists( self.team ) )
        {
            var_2 = 1;
            _ID33769( "switchblade", ::enemy_switchblade_exists );
        }

        if ( enemy_odin_assault_exists( self.team ) )
        {
            var_2 = 1;
            _ID33769( "odin_assault", ::enemy_odin_assault_exists );
        }

        var_3 = _ID14448();

        if ( isdefined( var_3 ) )
        {
            var_4 = self geteye();

            if ( common_scripts\utility::_ID36376( var_4, self getplayerangles(), var_3._ID4081.origin, self botgetfovdot() ) )
            {
                if ( sighttracepassed( var_4, var_3._ID4081.origin, 0, self, var_3._ID4081 ) )
                    badplace_cylinder( "vanguard_" + var_3 getentitynumber(), var_1 + 0.5, var_3._ID4081.origin, 200, 100, self.team );
            }
        }

        if ( !var_0 && var_2 )
        {
            var_0 = 1;
            self botsetflag( "hide_indoors", 1 );
        }

        if ( var_0 && !var_2 )
        {
            var_0 = 0;
            self botsetflag( "hide_indoors", 0 );
        }
    }
}

_ID33769( var_0, var_1 )
{
    if ( !isdefined( level._ID19250[self.team][var_0] ) )
        level._ID19250[self.team][var_0] = 0;

    if ( !level._ID19250[self.team][var_0] )
    {
        level._ID19250[self.team][var_0] = 1;
        level thread _ID21316( self.team, var_0, var_1 );
    }
}

_ID21316( var_0, var_1, var_2 )
{
    var_3 = 0.5;

    while ( [[ var_2 ]]( var_0 ) )
    {
        if ( gettime() > level._ID19456 + 4000 )
        {
            badplace_global( "", 5.0, var_0, "only_sky" );
            level._ID19456 = gettime();
        }

        wait(var_3);
    }

    level._ID19250[var_0][var_1] = 0;
}

enemy_mortar_strike_exists( var_0 )
{
    if ( isdefined( level._ID2653 ) && level._ID2653 )
    {
        if ( var_0 != level.air_raid_team_called )
            return 1;
    }

    return 0;
}

enemy_switchblade_exists( var_0 )
{
    if ( isdefined( level._ID25821 ) )
    {
        foreach ( var_2 in level._ID26359 )
        {
            if ( isdefined( var_2.type ) && var_2.type == "remote" && var_2.team != var_0 )
                return 1;
        }
    }

    return 0;
}

enemy_odin_assault_exists( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( !level._ID32653 || isdefined( var_2.team ) && var_0 != var_2.team )
        {
            if ( isdefined( var_2._ID22520 ) && var_2._ID22520._ID22598 == "odin_assault" && gettime() - var_2._ID22520.birthtime > 3000 )
                return 1;
        }
    }

    return 0;
}

_ID14448()
{
    foreach ( var_1 in level.players )
    {
        if ( !level._ID32653 || isdefined( var_1.team ) && self.team != var_1.team )
        {
            if ( isdefined( var_1._ID25826 ) && var_1._ID25826._ID16760 == "remote_uav" )
                return var_1._ID25826;
        }
    }

    return undefined;
}

iskillstreakblockedforbots( var_0 )
{
    return isdefined( level.botblockedkillstreaks ) && isdefined( level.botblockedkillstreaks[var_0] ) && level.botblockedkillstreaks[var_0];
}

blockkillstreakforbots( var_0 )
{
    level.botblockedkillstreaks[var_0] = 1;
}
