// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

register_dlc3_challenges()
{
    level._ID37058 = ::dlc3_custom_onalienagentdamaged_func;
    level._ID36954 = ::_ID36955;
    maps\mp\alien\_challenge_function::_ID25676( "long_shot", undefined, 0, undefined, undefined, ::_ID36656, ::_ID37074, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "leaning_shot", undefined, 0, undefined, undefined, ::_ID37248, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "sliding_shot", undefined, 0, undefined, undefined, ::_ID37248, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "jump_shot", undefined, 0, undefined, undefined, ::_ID37248, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "focus_fire", undefined, 0, undefined, undefined, ::_ID37248, ::_ID37072, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "kill_marked", undefined, 0, undefined, undefined, ::_ID36653, ::_ID37073, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "barrel_kills", undefined, 0, undefined, undefined, ::_ID37248, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "healthy_kills", undefined, 0, undefined, undefined, ::_ID37248, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "minion_preexplode", undefined, 0, undefined, undefined, ::_ID37248, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "kill_nodamage", undefined, 0, undefined, undefined, ::_ID36654, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID38209 );
    maps\mp\alien\_challenge_function::_ID25676( "kill_phantom", undefined, 0, undefined, undefined, ::_ID37248, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "bomber_preexplode", undefined, 0, undefined, undefined, ::_ID37248, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "flying_aliens", undefined, 0, undefined, undefined, ::_ID37248, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "melee_gargoyles", undefined, 0, undefined, undefined, ::_ID37248, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "melee_mammoth", undefined, 0, undefined, undefined, ::_ID37248, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "higher_ground", undefined, 0, undefined, undefined, ::_ID37248, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "kill_rhinos", undefined, 0, undefined, undefined, ::activate_kill_rhinos, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "lower_ground", undefined, 0, undefined, undefined, ::_ID37248, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "new_weapon", undefined, 0, undefined, undefined, ::activate_new_weapons, ::deactivate_new_weapons, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "team_prone", undefined, 0, undefined, undefined, ::_ID37248, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "semi_autos_only", undefined, 0, undefined, undefined, maps\mp\alien\_challenge_function::activate_use_weapon_challenge, maps\mp\alien\_challenge_function::deactivate_weapon_challenge_waypoints, undefined, ::update_semi_autos_only );
    maps\mp\alien\_challenge_function::_ID25676( "2_weapons_only", undefined, 0, undefined, undefined, ::activate_2_weapons_only_challenge, ::deactivate_2_weapons_only, undefined, ::update_2_weapons_only );
    maps\mp\alien\_challenge_function::_ID25676( "melee_5_goons_dlc3", undefined, 0, undefined, undefined, maps\mp\alien\_challenge_function::activate_melee_goons, maps\mp\alien\_challenge_function::deactivate_melee_goons, undefined, maps\mp\alien\_challenge_function::_ID34439 );
}

_ID37248()
{
    maps\mp\alien\_challenge_function::default_resetsuccess();
    self._ID8660 = 0;
    maps\mp\alien\_challenge_function::_ID34408( 0, self.goal );
}

_ID37251( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID8660 = self._ID8660 + var_0;

    if ( self._ID8660 >= self.goal )
        self._ID32046 = 1;

    maps\mp\alien\_challenge_function::_ID34408( self._ID8660, self.goal );

    if ( self._ID32046 )
    {
        level notify( "current_challenge_ended" );
        maps\mp\alien\_unk1422::deactivate_current_challenge();
        return;
    }

    if ( maps\mp\alien\_unk1464::_ID18506( var_1 ) )
    {
        level notify( "current_challenge_ended" );
        self._ID32046 = 0;
        maps\mp\alien\_unk1422::deactivate_current_challenge();
        return;
    }

    return;
}

_ID36656()
{
    _ID37248();
    level thread _ID37641();
}

_ID37641()
{
    level endon( "stop_longshot_logic" );

    for (;;)
    {
        foreach ( var_5, var_1 in maps\mp\alien\_spawnlogic::_ID14265() )
        {
            foreach ( var_3 in level.players )
            {
                if ( _ID37535( var_3, undefined, var_1 ) )
                {
                    var_1._ID37651 = 1;
                    maps\mp\alien\_outline_proto::enable_outline_for_player( var_1, var_3, 0, 1, "high" );
                    continue;
                }

                var_1._ID37651 = undefined;

                if ( isdefined( var_3.isferal ) && var_3.isferal )
                {
                    maps\mp\alien\_outline_proto::enable_outline_for_player( var_1, var_3, 4, 0, "high" );
                    continue;
                }

                maps\mp\alien\_outline_proto::disable_outline_for_player( var_1, var_3 );
            }

            if ( var_5 % 2 == 0 )
                wait 0.05;
        }

        wait 0.05;
    }
}

_ID37074()
{
    level notify( "stop_longshot_logic" );

    foreach ( var_1 in maps\mp\alien\_spawnlogic::_ID14265() )
    {
        if ( isdefined( var_1._ID37651 ) )
        {
            var_1._ID37651 = undefined;
            maps\mp\alien\_outline_proto::disable_outline( var_1 );
        }
    }

    maps\mp\alien\_challenge_function::default_resetsuccess();
}

_ID36653()
{
    _ID37248();
    level thread _ID38270( self );
}

_ID38270( var_0 )
{
    level endon( "current_challenge_ended" );
    var_1 = 0;

    while ( var_1 < var_0.goal )
    {
        var_2 = maps\mp\alien\_spawnlogic::_ID14265();

        foreach ( var_4 in var_2 )
        {
            if ( !isalive( var_4 ) || maps\mp\alien\_unk1464::_ID18506( var_4.pet ) )
                continue;

            if ( var_4.alien_type == "bomber" || maps\mp\alien\_unk1464::_ID18506( var_4._ID37651 ) )
                continue;

            var_4._ID37651 = 1;
            maps\mp\alien\_outline_proto::enable_outline( var_4, 0, 1 );
            var_4 thread _ID37889();
            var_1++;

            if ( var_1 >= var_0.goal )
                return;
        }

        wait 0.05;
    }
}

_ID37073()
{
    foreach ( var_1 in maps\mp\alien\_spawnlogic::_ID14265() )
    {
        if ( isdefined( var_1._ID37651 ) )
        {
            var_1._ID37651 = undefined;
            maps\mp\alien\_outline_proto::disable_outline( var_1 );
        }
    }

    maps\mp\alien\_challenge_function::default_resetsuccess();
}

_ID36654()
{
    _ID37248();
    level thread _ID37192( self );

    foreach ( var_1 in level.players )
        var_1 thread _ID37575();
}

_ID37192( var_0 )
{
    level endon( "kill_nodamage_complete" );
    level waittill( "kill_nodamage_failed" );
    var_0._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
    level notify( "kill_nodamage_complete" );
}

_ID37575()
{
    level endon( "kill_nodamage_complete" );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( maps\mp\alien\_unk1464::_ID18506( self.ability_invulnerable ) )
            continue;

        if ( isdefined( var_1 ) && isplayer( var_1 ) && maps\mp\alien\_unk1464::_ID18426() )
        {
            level notify( "kill_nodamage_failed" );
            return;
            continue;
        }

        if ( isdefined( var_1 ) && isagent( var_1 ) || var_5 == "alien_minion_explosion" )
        {
            level notify( "kill_nodamage_failed" );
            return;
        }
    }
}

_ID38209( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID8660 = self._ID8660 + var_0;

    if ( self._ID8660 >= self.goal )
        self._ID32046 = 1;

    maps\mp\alien\_challenge_function::_ID34408( self._ID8660, self.goal );

    if ( self._ID32046 )
    {
        level notify( "kill_nodamage_complete" );
        maps\mp\alien\_unk1422::deactivate_current_challenge();
        return;
    }
}

_ID37072()
{
    foreach ( var_1 in maps\mp\alien\_spawnlogic::_ID14265() )
    {
        if ( isdefined( var_1._ID37068 ) )
        {
            maps\mp\alien\_outline_proto::disable_outline( var_1 );
            var_1._ID37068 = [];
        }
    }

    maps\mp\alien\_challenge_function::default_resetsuccess();
}

activate_kill_rhinos()
{
    maps\mp\alien\_challenge_function::default_resetsuccess();
    level thread watch_rhino_deaths( self );
}

watch_rhino_deaths( var_0 )
{
    level endon( "rhino_challenge_complete" );
    level endon( "end_cycle" );
    level._ID8632 = 0;
    level thread fail_rhino_challenge();

    for (;;)
    {
        level waittill( "rhino_killed" );

        if ( level._ID8632 <= 0 )
        {
            var_1 = int( gettime() + 20000 );

            foreach ( var_3 in level.players )
                var_3 setclientomnvar( "ui_intel_timer", var_1 );

            level._ID8632 = 20;
            level thread maps\mp\alien\_challenge_function::_ID34410();
            continue;
        }

        level notify( "rhinos_killed" );
        var_0._ID32046 = 1;
        maps\mp\alien\_unk1422::deactivate_current_challenge();
        return;
    }
}

fail_rhino_challenge( var_0 )
{
    level endon( "game_ended" );
    level endon( "rhinos_killed" );
    level waittill( "current_challenge_ended" );
    var_0._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
    level notify( "rhino_challenge_complete" );
}

activate_new_weapons()
{
    maps\mp\alien\_challenge_function::default_resetsuccess();
    level thread watch_players_new_weapons( self );
}

watch_players_new_weapons( var_0 )
{
    level endon( "stop_newweapon_challenge_monitor" );

    for (;;)
    {
        level waittill( "new_weapon_purchased",  var_1  );
        var_1.new_weapon_purchased = 1;
        level thread check_for_new_weapon_complete( var_0 );
    }
}

check_for_new_weapon_complete( var_0 )
{
    var_1 = 1;

    foreach ( var_3 in level.players )
    {
        if ( !maps\mp\alien\_unk1464::_ID18506( var_3.new_weapon_purchased ) )
            var_1 = 0;
    }

    if ( var_1 )
    {
        var_0._ID32046 = 1;
        level notify( "stop_newweapon_challenge_monitor" );
        maps\mp\alien\_unk1422::deactivate_current_challenge();
        return;
    }
}

deactivate_new_weapons()
{
    level notify( "stop_newweapon_challenge_monitor" );
    maps\mp\alien\_challenge_function::default_resetsuccess();
}

dlc3_challenge_scalar_func( var_0 )
{
    var_1 = maps\mp\alien\_challenge_function::_ID9356( var_0 );

    if ( !isdefined( var_1 ) )
        var_1 = _ID37319( var_0 );

    if ( isdefined( var_1 ) )
    {

    }

    return var_1;
}

_ID37319( var_0 )
{
    var_1 = level.alien_challenge_table;
    var_2 = 0;
    var_3 = 1;
    var_4 = 99;
    var_5 = 1;
    var_6 = 9;

    for ( var_7 = var_3; var_7 <= var_4; var_7++ )
    {
        var_8 = tablelookup( var_1, var_2, var_7, var_5 );

        if ( var_8 == "" )
            return undefined;

        if ( var_8 != var_0 )
            continue;

        var_9 = tablelookup( var_1, var_2, var_7, var_6 );

        if ( isdefined( var_9 ) )
        {
            var_9 = strtok( var_9, " " );

            if ( var_9.size > 0 )
                return int( var_9[level.players.size - 1] );
        }
    }
}

dlc3_damage_challenge_func( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isdefined( level.current_challenge ) )
        return;

    switch ( level.current_challenge )
    {
        case "focus_fire":
            if ( !isdefined( var_8 ) )
                return 0;

            if ( isdefined( var_1 ) && isplayer( var_1 ) )
            {
                if ( !isdefined( var_8._ID37068 ) )
                    var_8._ID37068 = [];

                if ( !common_scripts\utility::array_contains( var_8._ID37068, var_1 ) )
                {
                    var_8._ID37068[var_8._ID37068.size] = var_1;
                    var_8 maps\mp\alien\_challenge_function::focus_fire_update_alien_outline( var_1 );
                }
            }

            return 0;
    }

    return 1;
}

dlc3_death_challenge_func( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isdefined( level.current_challenge ) )
        return 0;

    if ( level.current_challenge == "kill_marked" && !isdefined( self._ID37651 ) && var_3 == "MOD_SUICIDE" )
        return 0;

    switch ( level.current_challenge )
    {
        case "long_shot":
            if ( _ID37535( var_1, var_4, self ) )
                maps\mp\alien\_unk1422::_ID34406( "long_shot", 1 );

            return 0;
        case "leaning_shot":
            if ( isdefined( var_1 ) && isplayer( var_1 ) && isdefined( var_4 ) && var_4 == var_1 getcurrentweapon() && var_1 isleaning() )
                maps\mp\alien\_unk1422::_ID34406( "leaning_shot", 1 );

            return 0;
        case "jump_shot":
            if ( isdefined( var_1 ) && isplayer( var_1 ) && isdefined( var_4 ) && var_4 == var_1 getcurrentweapon() && !var_1 isonground() )
                maps\mp\alien\_unk1422::_ID34406( "jump_shot", 1 );

            return 0;
        case "sliding_shot":
            if ( isdefined( var_1 ) && isplayer( var_1 ) && var_3 == "MOD_MELEE" && var_1 _ID37538() )
                maps\mp\alien\_unk1422::_ID34406( "sliding_shot", 1 );

            return 0;
        case "focus_fire":
            if ( isdefined( self._ID37068 ) && self._ID37068.size >= level.players.size )
            {
                maps\mp\alien\_unk1422::_ID34406( "focus_fire", 1 );
                maps\mp\alien\_outline_proto::disable_outline_for_players( self, level.players );
            }

            return 0;
        case "kill_marked":
            if ( isdefined( self._ID37651 ) )
                maps\mp\alien\_unk1422::_ID34406( "kill_marked", 1 );
            else
                maps\mp\alien\_unk1422::_ID34406( "kill_marked", 0, 1 );

            return 0;
        case "barrel_kills":
            if ( isdefined( var_1 ) && isplayer( var_1 ) && isdefined( var_0 ) && isdefined( var_0.targetname ) && var_0.targetname == "scriptable_destructible_barrel" )
                maps\mp\alien\_unk1422::_ID34406( "barrel_kills", 1 );

            return 0;
        case "healthy_kills":
            if ( isdefined( var_1 ) && isplayer( var_1 ) && var_1.health >= var_1.maxhealth )
                maps\mp\alien\_unk1422::_ID34406( "healthy_kills", 1 );

            return 0;
        case "minion_preexplode":
            if ( isdefined( var_1 ) && isplayer( var_1 ) && maps\mp\alien\_unk1464::_ID14264() == "minion" && var_3 != "MOD_SUICIDE" )
                maps\mp\alien\_unk1422::_ID34406( "minion_preexplode", 1 );

            return 0;
        case "bomber_preexplode":
            if ( isdefined( var_1 ) && isplayer( var_1 ) && maps\mp\alien\_unk1464::_ID14264() == "bomber" && var_3 != "MOD_SUICIDE" )
                maps\mp\alien\_unk1422::_ID34406( "bomber_preexplode", 1 );

            return 0;
        case "kill_phantom":
            if ( isdefined( var_1 ) && isplayer( var_1 ) && maps\mp\alien\_unk1464::_ID14264() == "locust" && maps\mp\alien\_unk1464::_ID18506( self._ID37524 ) )
                maps\mp\alien\_unk1422::_ID34406( "kill_phantom", 1 );

            return 0;
        case "kill_nodamage":
            if ( isdefined( var_1 ) && isplayer( var_1 ) )
                maps\mp\alien\_unk1422::_ID34406( "kill_nodamage", 1 );

            return 0;
        case "flying_aliens":
            if ( isdefined( var_1 ) && isplayer( var_1 ) )
            {
                if ( maps\mp\alien\_unk1464::_ID14264() == "bomber" && var_3 != "MOD_SUICIDE" )
                    maps\mp\alien\_unk1422::_ID34406( "flying_aliens", 1 );
                else if ( maps\mp\alien\_unk1464::_ID14264() == "gargoyle" && maps\mp\alien\_unk1464::_ID18506( self.in_air ) )
                    maps\mp\alien\_unk1422::_ID34406( "flying_aliens", 1 );
            }

            return 0;
        case "melee_gargoyles":
            if ( isdefined( var_1 ) && isplayer( var_1 ) && maps\mp\alien\_unk1464::_ID14264() == "gargoyle" && var_3 == "MOD_MELEE" )
                maps\mp\alien\_unk1422::_ID34406( "melee_gargoyles", 1 );

            return 0;
        case "melee_mammoth":
            if ( isdefined( var_1 ) && isplayer( var_1 ) && maps\mp\alien\_unk1464::_ID14264() == "mammoth" && var_3 == "MOD_MELEE" )
                maps\mp\alien\_unk1422::_ID34406( "melee_mammoth", 1 );

            return 0;
        case "higher_ground":
            if ( isdefined( var_1 ) && isplayer( var_1 ) )
            {
                if ( !isdefined( var_0 ) || isdefined( var_0 ) && !maps\mp\alien\_unk1464::is_trap( var_0 ) )
                {
                    if ( var_1.origin[2] - self.origin[2] > 100 )
                        maps\mp\alien\_unk1422::_ID34406( "higher_ground", 1 );
                }
            }

            return 0;
        case "lower_ground":
            if ( isdefined( var_1 ) && isplayer( var_1 ) )
            {
                if ( !isdefined( var_0 ) || isdefined( var_0 ) && !maps\mp\alien\_unk1464::is_trap( var_0 ) )
                {
                    if ( self.origin[2] - var_1.origin[2] > 100 )
                        maps\mp\alien\_unk1422::_ID34406( "lower_ground", 1 );
                }
            }

            return 0;
        case "kill_rhinos":
            if ( isdefined( self.alien_type ) && self.alien_type == "elite" )
                level notify( "rhino_killed" );

            return 0;
        case "team_prone":
            if ( isdefined( var_1 ) && isplayer( var_1 ) && isdefined( var_4 ) && var_4 == var_1 getcurrentweapon() )
            {
                var_9 = 1;

                foreach ( var_11 in level.players )
                {
                    if ( var_11 getstance() != "prone" )
                        var_9 = 0;
                }

                if ( var_9 )
                    maps\mp\alien\_unk1422::_ID34406( "team_prone", 1 );
            }

            return 0;
        case "2_weapons_only":
        case "semi_autos_only":
            maps\mp\alien\_unk1422::_ID34406( level.current_challenge, var_4, var_3 );
            return 0;
        case "melee_5_goons_dlc3":
            if ( isdefined( self.alien_type ) && self.alien_type == "goon" && isdefined( var_1 ) && isplayer( var_1 ) && var_3 == "MOD_MELEE" )
                maps\mp\alien\_unk1422::_ID34406( "melee_5_goons_dlc3", 1 );

            return 0;
    }

    return 1;
}

_ID37535( var_0, var_1, var_2 )
{
    if ( isplayer( var_0 ) && isalive( var_0 ) && !var_0 maps\mp\_utility::_ID18837() )
    {
        if ( distancesquared( var_0.origin, var_2.origin ) >= 608400 )
            return 1;
    }

    return 0;
}

_ID37538()
{
    return isdefined( self.issliding ) || isdefined( self.isslidinggraceperiod ) && gettime() <= self.isslidinggraceperiod;
}

update_semi_autos_only( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = maps\mp\_utility::getweaponclass( var_0 );

    if ( var_9 == "weapon_sniper" || var_9 == "weapon_dmr" )
        self._ID8660++;

    maps\mp\alien\_challenge_function::_ID34408( self._ID8660, self.goal );

    if ( self._ID8660 >= self.goal )
    {
        self._ID32046 = 1;
        maps\mp\alien\_unk1422::deactivate_current_challenge();
        return;
    }
}

update_2_weapons_only( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = maps\mp\_utility::_ID14903( var_0 );

    if ( issubstr( self.weapon1choice, var_9 ) || issubstr( self.weapon2choice, var_9 ) )
        self._ID8660++;

    maps\mp\alien\_challenge_function::_ID34408( self._ID8660, self.goal );

    if ( self._ID8660 >= self.goal )
    {
        self._ID32046 = 1;
        maps\mp\alien\_unk1422::deactivate_current_challenge();
        return;
    }
}

activate_2_weapons_only_challenge()
{
    descent_activate_use_weapon_challenge();
    var_0 = maps\mp\alien\_unk1464::_ID37267();
    var_1 = [];
    var_2 = [];
    var_3 = 0;
    var_4 = common_scripts\utility::array_randomize( level._ID36418 );

    foreach ( var_6 in var_4 )
    {
        if ( isdefined( var_6._ID3788 ) && var_6._ID3788[0] == var_0 )
        {
            if ( !isdefined( var_6.script_noteworthy ) )
                continue;

            if ( common_scripts\utility::array_contains( var_1, var_6.script_noteworthy ) )
                continue;

            var_1[var_1.size] = var_6.script_noteworthy;
            var_7 = maps\mp\alien\_challenge_function::create_challenge_waypoints( var_6 );
            var_2[var_2.size] = var_7;
            var_3++;

            if ( var_3 >= 2 )
                break;
        }
    }

    self.weapon1choice = maps\mp\_utility::_ID14903( var_1[0] );
    self.weapon2choice = maps\mp\_utility::_ID14903( var_1[1] );
    self.waypoints = var_2;
}

deactivate_2_weapons_only()
{
    if ( isdefined( self ) && isdefined( self.waypoints ) )
    {
        foreach ( var_1 in self.waypoints )
            var_1 destroy();
    }

    maps\mp\alien\_challenge_function::default_resetsuccess();
}

descent_activate_use_weapon_challenge()
{
    maps\mp\alien\_challenge_function::default_resetsuccess();
    self._ID8660 = 0;
    maps\mp\alien\_challenge_function::_ID34408( 0, self.goal );
}

_ID37889()
{
    level endon( "game_ended" );
    self waittill( "death" );

    if ( isdefined( self._ID36951 ) )
    {
        maps\mp\alien\_outline_proto::disable_outline( self );
        return;
    }
}

dlc3_custom_onalienagentdamaged_func( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( isdefined( var_0 ) && isdefined( var_0.targetname ) && var_0.targetname == "scriptable_destructible_barrel" )
        var_2 += 750;

    return var_2;
}

_ID36955( var_0 )
{
    var_1 = [];

    if ( isdefined( level.drill ) )
        var_1[var_1.size] = level.drill.origin + ( 0, 0, 20 );

    switch ( var_0 )
    {
        case "area_01_hive_00":
            var_1[var_1.size] = ( 1539, -4996, 1260 );
            var_1[var_1.size] = ( 315, -5325, 1013 );
            break;
        case "area_01_hive_01":
            var_1[var_1.size] = ( 497, -4222, 1304 );
            var_1[var_1.size] = ( 321, -4348, 1146 );
            break;
        case "area_01_hive_02":
            var_1[var_1.size] = ( 1095, -4661, 957 );
            var_1[var_1.size] = ( 1098, -4100, 1190 );
            var_1[var_1.size] = ( 1539, -4996, 1260 );
            break;
        case "area_01_hive_03":
            var_1[var_1.size] = ( 418, -3938, 1094 );
            var_1[var_1.size] = ( 1372, -4020, 992 );
            var_1[var_1.size] = ( 497, -4222, 1304 );
            break;
        case "area_01_hive_04":
            var_1[var_1.size] = ( 1372, -4020, 992 );
            var_1[var_1.size] = ( 1015, -4168, 1194 );
            break;
        case "area_01_hive_05":
            var_1[var_1.size] = ( 754, -5036, 1389 );
            var_1[var_1.size] = ( 1481, -4999, 1445 );
            break;
        case "area_01_hive_06":
            var_1[var_1.size] = ( 882, -3373, 1500 );
            var_1[var_1.size] = ( 497, -4222, 1304 );
            break;
        case "area_01_hive_07":
            var_1[var_1.size] = ( 1450, -3124, 1404 );
            var_1[var_1.size] = ( 865, -3329, 1524 );
            break;
        case "area_01_hive_08":
            var_1[var_1.size] = ( 679, -2343, 1247 );
            var_1[var_1.size] = ( 678, -3088, 1339 );
            var_1[var_1.size] = ( 1074, -3053, 1147 );
            break;
        case "area_01_hive_09":
            var_1[var_1.size] = ( 1450, -3124, 1404 );
            var_1[var_1.size] = ( 1074, -3053, 1147 );
            var_1[var_1.size] = ( 709, -2164, 1314 );
            break;
        case "area_02_hive_01":
            var_1[var_1.size] = ( -877, -1258, 1106 );
            var_1[var_1.size] = ( -922, -1395, 1259 );
            var_1[var_1.size] = ( -1227, -1813, 974 );
            break;
        case "area_02_hive_02":
            var_1[var_1.size] = ( -1227, -1813, 974 );
            var_1[var_1.size] = ( -2101, -1632, 1171 );
            var_1[var_1.size] = ( -1784, -1552, 1351 );
            var_1[var_1.size] = ( -2128, -1834, 1474 );
            break;
        case "area_02_hive_03":
            var_1[var_1.size] = ( -1579, -1258, 1277 );
            var_1[var_1.size] = ( -750, -213, 1299 );
            break;
        case "area_02_hive_04":
            var_1[var_1.size] = ( -2923, -2251, 956 );
            break;
        case "area_02_hive_05":
            var_1[var_1.size] = ( -3681, -2756, 1110 );
            var_1[var_1.size] = ( -3161, -2351, 1258 );
            break;
        case "area_02_hive_06":
            var_1[var_1.size] = ( -3758, -1862, 936 );
            var_1[var_1.size] = ( -2743, -2226, 1305 );
            break;
        case "area_02_hive_07":
            var_1[var_1.size] = ( -2640, -544, 1402 );
            break;
        case "area_03_hive_01":
            var_1[var_1.size] = ( -1433, 1450, 1158 );
            var_1[var_1.size] = ( -1654, 808, 1105 );
            var_1[var_1.size] = ( -1477, 1491, 951 );
            var_1[var_1.size] = ( -909, 827, 934 );
            break;
        case "area_03_hive_02":
            var_1[var_1.size] = ( -1433, 1450, 1158 );
            var_1[var_1.size] = ( -1477, 1491, 951 );
            var_1[var_1.size] = ( -2193, 1388, 998 );
            var_1[var_1.size] = ( -1759, 2007, 985 );
            break;
        case "area_03_hive_03":
            var_1[var_1.size] = ( -1580, 2449, 659 );
            var_1[var_1.size] = ( -1893, 3418, 719 );
            var_1[var_1.size] = ( -2525, 2805, 713 );
            var_1[var_1.size] = ( -1445, 2042, 941 );
            break;
    }

    return common_scripts\utility::_ID25350( var_1 );
}
