// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    _ID28940();
    _ID28937();
}

_ID28940()
{
    level.bot_funcs["gametype_think"] = ::bot_war_think;
    level.bot_funcs["commander_gametype_tactics"] = ::bot_tdm_apply_commander_tactics;
}

_ID28937()
{
    if ( maps\mp\_utility::bot_is_fireteam_mode() )
    {
        level._ID5802 = "default";
        level.bot_fireteam_buddy_up = 0;
    }
}

bot_war_think()
{
    self notify( "bot_war_think" );
    self endon( "bot_war_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "owner_disconnect" );

    for (;;)
    {
        self [[ self._ID23477 ]]();
        wait 0.05;
    }
}

bot_tdm_apply_commander_tactics( var_0 )
{
    var_1 = 0;
    var_2 = level.bot_fireteam_buddy_up;
    var_3 = 0;
    level.bot_fireteam_buddy_up = 0;

    switch ( var_0 )
    {
        case "tactic_none":
            level._ID5802 = "revert";
            var_1 = 1;
            break;
        case "tactic_war_hp":
            level._ID5802 = "revert";
            level thread maps\mp\bots\_bots_fireteam::_ID13088( self.team );
            var_3 = 1;
            var_1 = 1;
            break;
        case "tactic_war_buddy":
            level._ID5802 = "revert";
            level.bot_fireteam_buddy_up = 1;
            var_1 = 1;
            break;
        case "tactic_war_hyg":
            level._ID5802 = "camper";
            var_1 = 1;
            break;
    }

    if ( !var_3 )
        level maps\mp\bots\_bots_fireteam::_ID13089( self.team );

    if ( var_1 )
    {
        foreach ( var_5 in level.players )
        {
            if ( !isdefined( var_5.team ) )
                continue;

            if ( isbot( var_5 ) && var_5.team == self.team )
            {
                var_5 botsetflag( "force_sprint", 0 );

                if ( level._ID5802 == "revert" )
                {
                    if ( isdefined( var_5.fireteam_personality_original ) )
                    {
                        var_5 notify( "stop_camping_tag" );
                        var_5 maps\mp\bots\_bots_personality::_ID7425();
                        var_5 maps\mp\bots\_bots_util::bot_set_personality( var_5.fireteam_personality_original );
                        var_5._ID6526 = undefined;
                        var_5.camping_needs_fallback_camp_location = undefined;
                    }

                    continue;
                }

                if ( !isdefined( var_5.fireteam_personality_original ) )
                    var_5.fireteam_personality_original = var_5 botgetpersonality();

                var_5 notify( "stop_camping_tag" );
                var_5 maps\mp\bots\_bots_personality::_ID7425();
                var_5 maps\mp\bots\_bots_util::bot_set_personality( level._ID5802 );

                if ( level._ID5802 == "camper" )
                {
                    var_5._ID6526 = 1;
                    var_5.camping_needs_fallback_camp_location = 1;
                }
            }
        }
    }

    if ( level.bot_fireteam_buddy_up )
    {
        foreach ( var_5 in level.players )
        {
            if ( !isdefined( var_5.team ) )
                continue;

            if ( var_5.team == self.team )
            {
                if ( isbot( var_5 ) )
                    var_5 thread maps\mp\bots\_bots_fireteam::bot_fireteam_buddy_search();
            }
        }
    }
    else if ( var_2 )
    {
        foreach ( var_5 in level.players )
        {
            if ( !isdefined( var_5.team ) )
                continue;

            if ( var_5.team == self.team )
            {
                if ( isbot( var_5 ) )
                {
                    var_5.owner = undefined;
                    var_5.bot_fireteam_follower = undefined;
                    var_5 notify( "buddy_cancel" );
                    var_5 maps\mp\bots\_bots_personality::_ID5500();
                }
            }
        }
    }
}
