// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

bot_fireteam_setup_callbacks()
{

}

_ID5587()
{
    level.bots_fireteam_num_classes_loaded = [];
    level thread _ID5584();
}

_ID5584()
{
    self notify( "bot_connect_monitor" );
    self endon( "bot_connect_monitor" );
    level._ID5849 = [];

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            if ( !isbot( var_1 ) && !isdefined( var_1._ID25040 ) )
            {
                if ( isdefined( var_1.team ) && ( var_1.team == "allies" || var_1.team == "axis" ) )
                {
                    var_1._ID25040 = 1;
                    level._ID5849[var_1.team] = var_1;
                    level.bots_fireteam_num_classes_loaded[var_1.team] = 0;
                    var_2 = maps\mp\bots\_bots_util::bot_get_team_limit();

                    if ( level._ID5849.size == 2 )
                        maps\mp\bots\_bots::_ID11059( var_2 - 1, var_1.team );

                    maps\mp\bots\_bots::_ID30607( var_2 - 1, var_1.team, ::_ID5592 );

                    if ( level._ID5849.size == 1 )
                    {
                        var_3 = 0;

                        foreach ( var_5 in level.players )
                        {
                            if ( isdefined( var_5 ) && !isbot( var_5 ) )
                                var_3++;
                        }

                        if ( var_3 == 1 )
                            maps\mp\bots\_bots::_ID30607( var_2 - 1, common_scripts\utility::_ID14447( var_1.team ) );
                    }
                }
            }
        }

        wait 0.25;
    }
}

_ID5592()
{
    self.override_class_function = ::bot_fireteam_setup_callback_class;
    self._ID13079 = level._ID5849[self._ID5801];
    thread bot_fireteam_monitor_killstreak_earned();
}

bot_fireteam_setup_callback_class()
{
    self.classcallback = ::bot_fireteam_loadout_class_callback;
    return "callback";
}

bot_fireteam_loadout_class_callback()
{
    if ( isdefined( self.botlastloadout ) )
        return self.botlastloadout;

    self.class_num = level.bots_fireteam_num_classes_loaded[self.team];
    level.bots_fireteam_num_classes_loaded[self.team] = level.bots_fireteam_num_classes_loaded[self.team] + 1;

    if ( self.class_num == 5 )
        self.class_num = 0;

    var_0["loadoutPrimary"] = self._ID13079 bot_fireteam_cac_getweapon( self.class_num, 0 );
    var_0["loadoutPrimaryAttachment"] = self._ID13079 _ID5579( self.class_num, 0 );
    var_0["loadoutPrimaryAttachment2"] = self._ID13079 bot_fireteam_cac_getweaponattachmenttwo( self.class_num, 0 );
    var_0["loadoutPrimaryBuff"] = self._ID13079 bot_fireteam_cac_getweaponbuff( self.class_num, 0 );
    var_0["loadoutPrimaryCamo"] = self._ID13079 bot_fireteam_cac_getweaponcamo( self.class_num, 0 );
    var_0["loadoutPrimaryReticle"] = self._ID13079 bot_fireteam_cac_getweaponreticle( self.class_num, 0 );
    var_0["loadoutSecondary"] = self._ID13079 bot_fireteam_cac_getweapon( self.class_num, 1 );
    var_0["loadoutSecondaryAttachment"] = self._ID13079 _ID5579( self.class_num, 1 );
    var_0["loadoutSecondaryAttachment2"] = self._ID13079 bot_fireteam_cac_getweaponattachmenttwo( self.class_num, 1 );
    var_0["loadoutSecondaryBuff"] = self._ID13079 bot_fireteam_cac_getweaponbuff( self.class_num, 1 );
    var_0["loadoutSecondaryCamo"] = self._ID13079 bot_fireteam_cac_getweaponcamo( self.class_num, 1 );
    var_0["loadoutSecondaryReticle"] = self._ID13079 bot_fireteam_cac_getweaponreticle( self.class_num, 1 );
    var_0["loadoutEquipment"] = self._ID13079 bot_fireteam_cac_getprimarygrenade( self.class_num );
    var_0["loadoutOffhand"] = self._ID13079 bot_fireteam_cac_getsecondarygrenade( self.class_num );
    var_0["loadoutPerk1"] = self._ID13079 bot_fireteam_cac_getperk( self.class_num, 2 );
    var_0["loadoutPerk2"] = self._ID13079 bot_fireteam_cac_getperk( self.class_num, 3 );
    var_0["loadoutPerk3"] = self._ID13079 bot_fireteam_cac_getperk( self.class_num, 4 );
    var_0["loadoutStreakType"] = self._ID13079 bot_fireteam_cac_getperk( self.class_num, 5 );

    if ( var_0["loadoutStreakType"] != "specialty_null" )
    {
        var_1 = getsubstr( var_0["loadoutStreakType"], 11 ) + "Streaks";
        var_0["loadoutStreak1"] = self._ID13079 bot_fireteam_cac_getstreak( self.class_num, var_1, 0 );

        if ( var_0["loadoutStreak1"] == "none" )
            var_0["loadoutStreak1"] = undefined;

        var_0["loadoutStreak2"] = self._ID13079 bot_fireteam_cac_getstreak( self.class_num, var_1, 1 );

        if ( var_0["loadoutStreak2"] == "none" )
            var_0["loadoutStreak2"] = undefined;

        var_0["loadoutStreak3"] = self._ID13079 bot_fireteam_cac_getstreak( self.class_num, var_1, 2 );

        if ( var_0["loadoutStreak3"] == "none" )
            var_0["loadoutStreak3"] = undefined;
    }

    self.botlastloadout = var_0;
    return var_0;
}

bot_fireteam_cac_getweapon( var_0, var_1 )
{
    return self getcacplayerdata( var_0, "weaponSetups", var_1, "weapon" );
}

_ID5579( var_0, var_1 )
{
    return self getcacplayerdata( var_0, "weaponSetups", var_1, "attachment", 0 );
}

bot_fireteam_cac_getweaponattachmenttwo( var_0, var_1 )
{
    return self getcacplayerdata( var_0, "weaponSetups", var_1, "attachment", 1 );
}

bot_fireteam_cac_getweaponbuff( var_0, var_1 )
{
    return self getcacplayerdata( var_0, "weaponSetups", var_1, "buff" );
}

bot_fireteam_cac_getweaponcamo( var_0, var_1 )
{
    return self getcacplayerdata( var_0, "weaponSetups", var_1, "camo" );
}

bot_fireteam_cac_getweaponreticle( var_0, var_1 )
{
    return self getcacplayerdata( var_0, "weaponSetups", var_1, "reticle" );
}

bot_fireteam_cac_getprimarygrenade( var_0 )
{
    return self getcacplayerdata( var_0, "perks", 0 );
}

bot_fireteam_cac_getsecondarygrenade( var_0 )
{
    return self getcacplayerdata( var_0, "perks", 1 );
}

bot_fireteam_cac_getperk( var_0, var_1 )
{
    return self getcacplayerdata( var_0, "perks", var_1 );
}

bot_fireteam_cac_getstreak( var_0, var_1, var_2 )
{
    return self getcacplayerdata( var_0, var_1, var_2 );
}

bot_fireteam_buddy_think()
{
    var_0 = 250;
    var_1 = var_0 * var_0;

    if ( !maps\mp\bots\_bots_util::bot_is_guarding_player( self.owner ) )
        maps\mp\bots\_bots_strategy::bot_guard_player( self.owner, var_0 );

    if ( distancesquared( self.origin, self.owner.origin ) > var_1 )
        self botsetflag( "force_sprint", 1 );
    else if ( self.owner issprinting() )
        self botsetflag( "force_sprint", 1 );
    else
        self botsetflag( "force_sprint", 0 );
}

bot_fireteam_buddy_search()
{
    self endon( "buddy_cancel" );
    self endon( "disconnect" );
    self notify( "buddy_search_start" );
    self endon( "buddy_search_start" );

    for (;;)
    {
        if ( isalive( self ) && !isdefined( self.bot_fireteam_follower ) )
        {
            if ( isdefined( self.owner ) )
            {
                if ( self.sessionstate == "playing" )
                {
                    if ( !self.owner._ID7864 )
                    {
                        self.owner.bot_fireteam_follower = undefined;
                        self.owner = undefined;
                    }
                    else if ( isdefined( level._ID13079[self.team] ) )
                    {
                        if ( isdefined( level._ID13079[self.team].commanding_bot ) && level._ID13079[self.team].commanding_bot == self )
                        {
                            self.owner.bot_fireteam_follower = undefined;
                            self.owner.owner = level._ID13079[self.team];
                            self.owner._ID23477 = ::bot_fireteam_buddy_think;
                            self.owner = undefined;
                        }
                        else if ( isdefined( level._ID13079[self.team].commanding_bot ) && level._ID13079[self.team].commanding_bot == self.owner )
                        {
                            self.owner.bot_fireteam_follower = undefined;
                            self.owner = level._ID13079[self.team];
                            self.owner.bot_fireteam_follower = self;
                        }
                        else if ( self.owner == level._ID13079[self.team] && !isdefined( self.owner.commanding_bot ) )
                        {
                            self.owner.bot_fireteam_follower = undefined;

                            if ( isdefined( self.owner.last_commanded_bot ) )
                            {
                                self.owner = self.owner.last_commanded_bot;
                                self.owner.bot_fireteam_follower = self;
                            }
                            else
                                self.owner = undefined;
                        }
                    }
                }
                else if ( isdefined( level._ID13079[self.team] ) )
                {
                    if ( isdefined( level._ID13079[self.team].commanding_bot ) && level._ID13079[self.team].commanding_bot == self )
                    {
                        self.owner.bot_fireteam_follower = undefined;
                        self.owner.owner = level._ID13079[self.team];
                        self.owner._ID23477 = ::bot_fireteam_buddy_think;
                        self.owner = undefined;
                    }
                }
            }

            if ( self.sessionstate == "playing" )
            {
                if ( !isdefined( self.owner ) )
                {
                    var_0 = [];

                    foreach ( var_2 in level.players )
                    {
                        if ( var_2 != self && var_2.team == self.team )
                        {
                            if ( isalive( var_2 ) && var_2.sessionstate == "playing" && !isdefined( var_2.bot_fireteam_follower ) && !isdefined( var_2.owner ) )
                                var_0[var_0.size] = var_2;
                        }
                    }

                    if ( var_0.size > 0 )
                    {
                        var_4 = common_scripts\utility::_ID14934( self.origin, var_0 );

                        if ( isdefined( var_4 ) )
                        {
                            self.owner = var_4;
                            self.owner.bot_fireteam_follower = self;
                        }
                    }
                }
            }

            if ( isdefined( self.owner ) )
                self._ID23477 = ::bot_fireteam_buddy_think;
            else
                maps\mp\bots\_bots_personality::_ID5500();
        }

        wait 0.5;
    }
}

fireteam_tdm_set_hunt_leader( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level.players )
    {
        if ( var_3.team == var_0 )
        {
            if ( var_3._ID7864 && isalive( var_3 ) && var_3.sessionstate == "playing" )
            {
                if ( !isbot( var_3 ) )
                {
                    level._ID13083[var_0] = var_3;
                    return 1;
                    continue;
                }

                var_1[var_1.size] = var_3;
            }
        }
    }

    if ( !isdefined( level._ID13083[var_0] ) )
    {
        if ( var_1.size > 0 )
        {
            if ( var_1.size == 1 )
                level._ID13083[var_0] = var_1[0];
            else
                level._ID13083[var_0] = var_1[randomint( var_1.size )];

            return 1;
        }
    }

    return 0;
}

_ID13089( var_0 )
{
    level notify( "hunting_party_end_" + var_0 );
    level._ID13083[var_0] = undefined;
    level.fireteam_hunt_target_zone[var_0] = undefined;
    level.bot_random_path_function[var_0] = maps\mp\bots\_bots_personality::bot_random_path_default;
}

_ID13090( var_0, var_1 )
{
    var_2 = 0;
    var_3 = undefined;
    var_4 = -1;

    if ( level._ID36588 > 0 )
    {
        for ( var_5 = 0; var_5 < level._ID36588; var_5++ )
        {
            var_6 = botzonegetcount( var_5, var_1, "enemy_predict" );

            if ( var_6 < var_2 )
                continue;

            var_7 = undefined;

            if ( var_6 == var_2 )
            {
                var_7 = getzonepath( var_0, var_5 );

                if ( !isdefined( var_7 ) )
                    continue;

                if ( var_4 >= 0 && var_7.size > var_4 )
                    continue;
            }

            var_2 = var_6;
            var_3 = var_5;

            if ( isdefined( var_7 ) )
            {
                var_4 = var_7.size;
                continue;
            }

            var_4 = -1;
        }
    }

    return var_3;
}

_ID13088( var_0 )
{
    level endon( "hunting_party_end_" + var_0 );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( level._ID36588 <= 0 )
        return;

    level.bot_random_path_function[var_0] = ::_ID5586;

    for (;;)
    {
        var_1 = 3;

        if ( !isdefined( level._ID13083[var_0] ) || isbot( level._ID13083[var_0] ) || isdefined( level._ID13083[var_0].commanding_bot ) )
            fireteam_tdm_set_hunt_leader( var_0 );

        if ( isdefined( level._ID13083[var_0] ) )
        {
            var_2 = getzonenearest( level._ID13083[var_0].origin );

            if ( !isdefined( var_2 ) )
            {
                wait(var_1);
                continue;
            }

            if ( !isbot( level._ID13083[var_0] ) )
            {
                if ( isalive( level._ID13083[var_0] ) && level._ID13083[var_0].sessionstate == "playing" && ( !isdefined( level._ID13083[var_0]._ID9101 ) || level._ID13083[var_0]._ID9101 + 5000 < gettime() ) )
                {
                    level.fireteam_hunt_target_zone[var_0] = var_2;
                    level.fireteam_hunt_next_zone_search_time[var_0] = gettime() + 1000;
                    var_1 = 0.5;
                }
                else
                    var_1 = 1;
            }
            else
            {
                var_3 = 0;
                var_4 = 0;
                var_5 = undefined;

                if ( isdefined( level.fireteam_hunt_target_zone[var_0] ) )
                    var_5 = level.fireteam_hunt_target_zone[var_0];
                else
                {
                    var_3 = 1;
                    var_4 = 1;
                    var_5 = var_2;
                }

                var_6 = undefined;

                if ( isdefined( var_5 ) )
                {
                    var_6 = _ID13090( var_2, var_0 );

                    if ( !var_3 )
                    {
                        if ( !isdefined( var_6 ) || var_6 != var_5 )
                        {
                            if ( var_5 == var_2 )
                                var_4 = 1;
                            else if ( gettime() > level.fireteam_hunt_next_zone_search_time[var_0] )
                                var_4 = 1;
                        }
                    }

                    if ( var_4 )
                    {
                        if ( !isdefined( var_6 ) )
                        {
                            var_7 = 0;
                            var_8 = -1;

                            for ( var_9 = 0; var_9 < level._ID36588; var_9++ )
                            {
                                var_10 = distance2d( getzoneorigin( var_9 ), level._ID13083[var_0].origin );

                                if ( var_10 > var_7 )
                                {
                                    var_7 = var_10;
                                    var_8 = var_9;
                                }
                            }

                            var_6 = var_8;
                        }

                        if ( isdefined( var_6 ) )
                        {
                            if ( !isdefined( level.fireteam_hunt_target_zone[var_0] ) || level.fireteam_hunt_target_zone[var_0] != var_6 )
                            {
                                foreach ( var_12 in level.players )
                                {
                                    if ( isbot( var_12 ) && var_12.team == var_0 )
                                    {
                                        var_12 botclearscriptgoal();
                                        var_12._ID13082 = undefined;
                                        var_12 thread _ID5586();
                                    }
                                }
                            }

                            level.fireteam_hunt_target_zone[var_0] = var_6;
                            level.fireteam_hunt_next_zone_search_time[var_0] = gettime() + 12000;
                        }
                    }
                }
            }
        }

        wait(var_1);
    }
}

_ID5537()
{
    self notify( "bot_debug_script_goal" );
    level endon( "hunting_party_end_" + self.team );
    self endon( "bot_debug_script_goal" );
    var_0 = 48;

    for (;;)
    {
        if ( self bothasscriptgoal() )
        {
            var_1 = self botgetscriptgoal();

            if ( !isdefined( self._ID13082 ) )
            {

            }
            else if ( self._ID13082 != var_1 )
            {

            }
            else
            {

            }
        }
        else if ( isdefined( self._ID13082 ) )
        {

        }

        wait 0.05;
    }
}

_ID5586()
{
    var_0 = 0;
    var_1 = undefined;

    if ( isdefined( level.fireteam_hunt_target_zone[self.team] ) )
    {
        var_2 = getzonenodes( level.fireteam_hunt_target_zone[self.team], 0 );

        if ( var_2.size <= 18 )
        {
            var_2 = getzonenodes( level.fireteam_hunt_target_zone[self.team], 1 );

            if ( var_2.size <= 18 )
            {
                var_2 = getzonenodes( level.fireteam_hunt_target_zone[self.team], 2 );

                if ( var_2.size <= 18 )
                    var_2 = getzonenodes( level.fireteam_hunt_target_zone[self.team], 3 );
            }
        }

        if ( var_2.size <= 0 )
            return maps\mp\bots\_bots_personality::bot_random_path_default();

        var_1 = self botnodepick( var_2, var_2.size, "node_hide" );

        for ( var_3 = 0; !isdefined( var_1 ) || !self botnodeavailable( var_1 ); var_1 = var_2[randomint( var_2.size )] )
        {
            var_3++;

            if ( var_3 >= 10 )
                return maps\mp\bots\_bots_personality::bot_random_path_default();
        }

        var_4 = var_1.origin;

        if ( isdefined( var_4 ) )
        {
            var_5 = "guard";
            var_6 = getzonenearest( self.origin );

            if ( isdefined( var_6 ) && var_6 == level.fireteam_hunt_target_zone[self.team] )
                self botsetflag( "force_sprint", 0 );
            else
                self botsetflag( "force_sprint", 1 );

            var_0 = self botsetscriptgoal( var_4, 128, var_5 );
            self._ID13082 = var_4;
        }
    }

    if ( !var_0 )
        return maps\mp\bots\_bots_personality::bot_random_path_default();

    return var_0;
}

bot_fireteam_monitor_killstreak_earned()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self notify( "bot_fireteam_monitor_killstreak_earned" );
    self endon( "bot_fireteam_monitor_killstreak_earned" );

    for (;;)
    {
        self waittill( "bot_killstreak_earned",  var_0, var_1  );

        if ( maps\mp\_utility::bot_is_fireteam_mode() )
        {
            if ( isdefined( self ) && isbot( self ) )
            {
                if ( isdefined( self._ID13079 ) )
                {
                    var_2 = undefined;

                    if ( isdefined( self._ID13079.commanding_bot ) )
                        var_2 = self._ID13079.commanding_bot;
                    else
                        var_2 = self._ID13079 getspectatingplayer();

                    if ( !isdefined( var_2 ) || var_2 != self )
                        self._ID13079 thread maps\mp\gametypes\_hud_message::_ID24474( var_0, self, var_1 );
                }
            }
        }
    }
}
