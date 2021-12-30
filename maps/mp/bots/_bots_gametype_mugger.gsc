// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    level._ID36884 = 200;
    _ID28940();
}

_ID28940()
{
    level.bot_funcs["gametype_think"] = ::_ID36866;
    level.bot_funcs["gametype_loadout_modify"] = ::_ID36865;
}

_ID36866()
{
    self notify( "bot_mugger_think" );
    self endon( "bot_mugger_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self._ID37597 = ( 0, 0, 0 );
    self._ID38136 = undefined;
    self._ID37421 = 0;
    self._ID37427 = 0;
    self._ID37081 = self botgetdifficultysetting( "meleeChargeDist" );
    childthread _ID38138();

    if ( self botgetdifficultysetting( "strategyLevel" ) > 0 )
        childthread _ID38137();

    if ( self botgetdifficultysetting( "strategyLevel" ) > 0 )
        childthread _ID37176();

    for (;;)
    {
        if ( self botgetdifficultysetting( "strategyLevel" ) > 1 )
        {
            if ( isdefined( self._ID32365 ) && level.mugger_bank_limit <= self._ID32365 )
            {
                if ( !self._ID37427 )
                {
                    var_0 = getnodesinradius( self.origin, 1000, 0, 500, "node_hide" );
                    var_1 = self botnodepick( var_0, 3, "node_hide" );

                    if ( isdefined( var_1 ) )
                    {
                        self botsetscriptgoalnode( var_1, "critical" );
                        self._ID37427 = 1;
                    }
                }
            }
            else if ( self._ID37427 )
            {
                self botclearscriptgoal();
                self._ID37427 = 0;
            }
        }

        if ( !self._ID37427 )
        {
            if ( !isdefined( self._ID38136 ) && !self._ID37421 )
                self [[ self._ID23477 ]]();
        }

        wait 0.05;
    }
}

_ID37176()
{
    for (;;)
    {
        if ( self botgetdifficultysetting( "strategyLevel" ) < 2 )
            wait 0.5;
        else
            wait 0.2;

        if ( isdefined( self.enemy ) && isplayer( self.enemy ) && isdefined( self.enemy._ID32365 ) && self.enemy._ID32365 >= 3 && self botcanseeentity( self.enemy ) && distance( self.origin, self.enemy.origin ) <= 500 )
        {
            self botsetdifficultysetting( "meleeChargeDist", 500 );
            self botsetflag( "prefer_melee", 1 );
            self botsetflag( "throw_knife_melee", level._ID21793 > 0 );
            continue;
        }

        self botsetdifficultysetting( "meleeChargeDist", self._ID37081 );
        self botsetflag( "prefer_melee", 0 );
        self botsetflag( "throw_knife_melee", 0 );
    }
}

_ID38137()
{
    for (;;)
    {
        level waittill( "mugger_tag_pile",  var_0  );

        if ( self.health <= 0 )
            continue;

        if ( self._ID37427 )
            continue;

        if ( !isdefined( self._ID37602 ) || gettime() - self._ID37602 > 7500 )
        {
            self._ID37602 = undefined;
            self._ID37601 = undefined;
            self._ID37421 = 0;
        }

        if ( !isdefined( self._ID37601 ) || distancesquared( self.origin, self._ID37601 ) > distancesquared( self.origin, var_0 ) )
        {
            self._ID37602 = gettime();
            self._ID37601 = var_0;
        }
    }
}

_ID36842()
{
    var_0 = self getnearestnode();
    var_1 = undefined;

    if ( isdefined( var_0 ) )
    {
        var_2 = 1000000;
        var_3 = common_scripts\utility::array_combine( level.dogtags, level._ID21759 );

        foreach ( var_5 in var_3 )
        {
            if ( var_5 maps\mp\gametypes\_gameobjects::_ID6602( self.team ) )
            {
                var_6 = distancesquared( self.origin, var_5.curorigin );

                if ( !isdefined( var_1 ) || var_6 < var_2 )
                {
                    if ( self botgetdifficultysetting( "strategyLevel" ) > 0 && var_6 < 122500 || var_6 < 1000000 && maps\mp\bots\_bots_gametype_conf::_ID36858( var_5, var_0, self botgetfovdot() ) )
                    {
                        var_2 = var_6;
                        var_1 = var_5;
                    }
                }
            }
        }
    }

    return var_1;
}

_ID36844( var_0, var_1 )
{
    var_2 = [];

    if ( isdefined( var_0 ) )
    {
        var_3 = common_scripts\utility::array_combine( level.dogtags, level._ID21759 );

        foreach ( var_5 in var_3 )
        {
            if ( var_5 maps\mp\gametypes\_gameobjects::_ID6602( self.team ) )
            {
                if ( isplayer( self ) || distancesquared( self.origin, var_5.curorigin ) < 1000000 )
                {
                    if ( maps\mp\bots\_bots_gametype_conf::_ID36858( var_5, var_0, var_1 ) )
                    {
                        var_6 = spawnstruct();
                        var_6.origin = var_5.curorigin;
                        var_6.tag = var_5;
                        var_2[var_2.size] = var_6;
                    }
                }
            }
        }
    }

    return var_2;
}

_ID38138()
{
    wait(randomfloatrange( 0, 0.5 ));

    for (;;)
    {
        if ( self botgetdifficultysetting( "strategyLevel" ) == 0 )
            wait 3.0;
        else if ( self botgetdifficultysetting( "strategyLevel" ) == 1 )
            wait 1.5;
        else
            wait 0.5;

        if ( self.health <= 0 )
            continue;

        if ( self._ID37427 )
            continue;

        if ( isdefined( self.enemy ) && isplayer( self.enemy ) && self botcanseeentity( self.enemy ) )
            continue;

        var_0 = _ID36842();

        if ( isdefined( var_0 ) )
        {
            _ID37724( var_0 );
            continue;
        }

        if ( !self._ID37421 )
        {
            if ( isdefined( self._ID37601 ) && isdefined( self._ID37602 ) && gettime() - self._ID37602 <= 7500 )
                thread _ID37723( self._ID37601 );
        }
    }
}

_ID37723( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self._ID37421 = 1;
    var_1 = spawnstruct();
    var_1._ID27624 = "objective";
    var_1._ID22485 = level._ID36884;
    maps\mp\bots\_bots_strategy::bot_new_tactical_goal( "kill_tag_pile", var_0, 25, var_1 );
    var_2 = common_scripts\utility::_ID35635( "death", "tag_spotted" );
    self botclearscriptgoal();
    self._ID37421 = 0;
    maps\mp\bots\_bots_strategy::bot_abort_tactical_goal( "kill_tag_pile" );
}

_ID37724( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self._ID38136 = var_0;
    self notify( "tag_spotted" );
    childthread _ID37739( var_0, "tag_picked_up" );
    maps\mp\bots\_bots_strategy::bot_abort_tactical_goal( "kill_tag" );
    var_1 = var_0.curorigin;

    if ( maps\mp\bots\_bots_util::_ID5824( self._ID37597, var_0.curorigin ) )
    {
        var_2 = var_0._ID21893;

        if ( isdefined( var_2 ) )
        {
            var_3 = var_2.origin - var_1;
            var_1 += vectornormalize( var_3 ) * length( var_3 ) * 0.5;
        }
    }

    self._ID37597 = var_0.curorigin;
    var_4 = spawnstruct();
    var_4._ID27624 = "objective";
    var_4._ID22485 = level._ID36884;
    maps\mp\bots\_bots_strategy::bot_new_tactical_goal( "kill_tag", var_1, 25, var_4 );
    thread _ID37738( "tag_aborted" );
    var_5 = common_scripts\utility::_ID35635( "death", "tag_picked_up" );
    self notify( "tag_watch_stop" );
    self._ID38136 = undefined;
    self botclearscriptgoal();
    maps\mp\bots\_bots_strategy::bot_abort_tactical_goal( "kill_tag" );
}

_ID37738( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "tag_watch_stop" );

    while ( maps\mp\bots\_bots_strategy::bot_has_tactical_goal( "kill_tag" ) )
        wait 0.05;

    self notify( var_0 );
}

_ID37739( var_0, var_1 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "tag_watch_stop" );

    while ( var_0 maps\mp\gametypes\_gameobjects::_ID6602( self.team ) )
        wait 0.05;

    self notify( var_1 );
}

_ID36865( var_0 )
{
    var_1 = 0;
    var_2 = self botgetdifficulty();

    if ( var_2 == "recruit" )
        var_1 = 0.1;
    else if ( var_2 == "regular" )
        var_1 = 0.25;
    else if ( var_2 == "hardened" )
        var_1 = 0.6;
    else if ( var_2 == "veteran" )
        var_1 = 0.9;

    var_3 = var_0["loadoutEquipment"] == "throwingknife_mp";

    if ( !var_3 )
    {
        if ( var_1 >= randomfloat( 1 ) )
        {
            var_0["loadoutEquipment"] = "throwingknife_mp";
            var_3 = 1;
        }
    }

    if ( var_1 >= randomfloat( 1 ) )
    {
        if ( var_0["loadoutOffhand"] != "concussion_grenade_mp" )
            var_0["loadoutOffhand"] = "concussion_grenade_mp";
    }

    if ( var_1 >= randomfloat( 1 ) )
    {
        if ( var_0["loadoutPrimaryAttachment"] != "tactical" && var_0["loadoutPrimaryAttachment2"] != "tactical" )
        {
            var_4 = maps\mp\bots\_bots_loadout::bot_validate_weapon( var_0["loadoutPrimary"], var_0["loadoutPrimaryAttachment"], "tactical" );

            if ( var_4 )
                var_0["loadoutPrimaryAttachment2"] = "tactical";
            else
            {
                var_4 = maps\mp\bots\_bots_loadout::bot_validate_weapon( var_0["loadoutPrimary"], "tactical", var_0["loadoutPrimaryAttachment2"] );

                if ( var_4 )
                    var_0["loadoutPrimaryAttachment"] = "tactical";
            }
        }
    }

    if ( var_1 >= randomfloat( 1 ) )
    {
        if ( var_0["loadoutSecondaryAttachment"] != "tactical" && var_0["loadoutSecondaryAttachment2"] != "tactical" )
        {
            var_4 = maps\mp\bots\_bots_loadout::bot_validate_weapon( var_0["loadoutSecondary"], var_0["loadoutSecondaryAttachment"], "tactical" );

            if ( var_4 )
                var_0["loadoutSecondaryAttachment2"] = "tactical";
            else
            {
                var_4 = maps\mp\bots\_bots_loadout::bot_validate_weapon( var_0["loadoutSecondary"], "tactical", var_0["loadoutSecondaryAttachment2"] );

                if ( var_4 )
                    var_0["loadoutSecondaryAttachment"] = "tactical";
            }
        }
    }

    var_5 = [];
    var_6 = [];
    var_7 = [];
    var_8 = [];

    if ( var_3 )
        var_8[var_8.size] = "specialty_extra_deadly";

    var_8[var_8.size] = "specialty_lightweight";
    var_8[var_8.size] = "specialty_marathon";
    var_8[var_8.size] = "specialty_fastsprintrecovery";
    var_8[var_8.size] = "specialty_stun_resistance";

    for ( var_9 = 1; var_9 < 9; var_9++ )
    {
        if ( isdefined( var_0["loadoutPerk" + var_9] ) )
        {
            if ( var_0["loadoutPerk" + var_9] != "none" )
            {
                var_5[var_5.size] = var_0["loadoutPerk" + var_9];
                var_6[var_6.size] = var_9;
                continue;
            }

            var_7[var_7.size] = var_9;
        }
    }

    foreach ( var_11 in var_8 )
    {
        if ( var_1 >= randomfloat( 1 ) )
        {
            if ( !common_scripts\utility::array_contains( var_5, var_11 ) )
            {
                var_12 = -1;

                if ( var_7.size )
                {
                    var_12 = var_7[0];
                    var_7 = common_scripts\utility::array_remove( var_7, var_12 );
                }
                else if ( var_6.size )
                {
                    var_12 = common_scripts\utility::_ID25350( var_6 );
                    var_6 = common_scripts\utility::array_remove( var_6, var_12 );
                }

                if ( var_12 != -1 )
                    var_0["loadoutPerk" + var_12] = var_11;
            }
        }
    }

    if ( var_1 >= randomfloat( 1 ) )
    {
        if ( var_0["loadoutStreakType"] == "streaktype_assault" && var_0["loadoutStreak1"] != "airdrop_juggernaut_maniac" && var_0["loadoutStreak2"] != "airdrop_juggernaut_maniac" && var_0["loadoutStreak3"] != "airdrop_juggernaut_maniac" )
            var_0["loadoutStreak3"] = "airdrop_juggernaut_maniac";
    }

    return var_0;
}
