// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

register_last_challenges()
{
    level._ID37058 = ::last_custom_onalienagentdamaged_func;
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
    maps\mp\alien\_challenge_function::_ID25676( "melee_5_goons_last", undefined, 0, undefined, undefined, maps\mp\alien\_challenge_function::activate_melee_goons, maps\mp\alien\_challenge_function::deactivate_melee_goons, undefined, maps\mp\alien\_challenge_function::_ID34439 );
    maps\mp\alien\_challenge_function::_ID25676( "stay_within_area_1", 10, 0, undefined, ::last_pre_activate_stay_within_area, maps\mp\alien\_challenge_function::activate_stay_within_area, maps\mp\alien\_challenge_function::_ID9022, undefined, ::last_update_stay_within_area );
    maps\mp\alien\_challenge_function::_ID25676( "stay_within_area_2", 10, 0, undefined, ::last_pre_activate_stay_within_area, maps\mp\alien\_challenge_function::activate_stay_within_area, maps\mp\alien\_challenge_function::_ID9022, undefined, ::last_update_stay_within_area );
    maps\mp\alien\_challenge_function::_ID25676( "stay_within_area_3", 10, 0, undefined, ::last_pre_activate_stay_within_area, maps\mp\alien\_challenge_function::activate_stay_within_area, maps\mp\alien\_challenge_function::_ID9022, undefined, ::last_update_stay_within_area );
    maps\mp\alien\_challenge_function::_ID25676( "stay_within_area_4", 10, 0, undefined, ::last_pre_activate_stay_within_area, maps\mp\alien\_challenge_function::activate_stay_within_area, maps\mp\alien\_challenge_function::_ID9022, undefined, ::last_update_stay_within_area );
    maps\mp\alien\_challenge_function::_ID25676( "stay_within_area_5", 10, 0, undefined, ::last_pre_activate_stay_within_area, maps\mp\alien\_challenge_function::activate_stay_within_area, maps\mp\alien\_challenge_function::_ID9022, undefined, ::last_update_stay_within_area );
    maps\mp\alien\_challenge_function::_ID25676( "kill_ancestor", undefined, 0, undefined, undefined, ::activate_kill_ancestor, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "weakpoint_damage", undefined, 0, undefined, undefined, ::activate_weakpoint_damage, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "no_ancestor_damage", undefined, 0, undefined, undefined, ::activate_no_ancestor_damage, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
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
        foreach ( var_6, var_1 in maps\mp\alien\_spawnlogic::_ID14265() )
        {
            if ( !isalive( var_1 ) )
                continue;

            if ( isdefined( var_1.pet ) )
                continue;

            var_2 = undefined;

            foreach ( var_4 in level.players )
            {
                if ( _ID37535( var_4, undefined, var_1 ) )
                {
                    var_2 = 1;
                    maps\mp\alien\_outline_proto::enable_outline_for_player( var_1, var_4, 0, 1, "high" );
                    continue;
                }

                if ( isdefined( var_4.isferal ) && var_4.isferal )
                {
                    maps\mp\alien\_outline_proto::enable_outline_for_player( var_1, var_4, 4, 0, "high" );
                    continue;
                }

                maps\mp\alien\_outline_proto::disable_outline_for_player( var_1, var_4 );
            }

            var_1._ID37651 = var_2;

            if ( var_6 % 2 == 0 )
                wait 0.05;
        }

        wait 0.05;
    }
}

_ID37074()
{
    level notify( "stop_longshot_logic" );
    wait 1;

    foreach ( var_1 in maps\mp\alien\_spawnlogic::_ID14265() )
    {
        foreach ( var_3 in level.players )
        {
            if ( isdefined( var_1._ID37651 ) )
                maps\mp\alien\_outline_proto::disable_outline_for_player( var_1, var_3 );
        }

        var_1._ID37651 = undefined;
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
            if ( !isalive( var_4 ) || isdefined( var_4.pet ) )
                continue;

            if ( var_4.alien_type == "bomber" || maps\mp\alien\_unk1464::_ID18506( var_4._ID37651 ) || var_4.alien_type == "ancestor" )
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

        if ( isdefined( var_1 ) && isagent( var_1 ) )
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

last_challenge_scalar_func( var_0 )
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

last_damage_challenge_func( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isdefined( level.current_challenge ) )
        return;

    switch ( level.current_challenge )
    {
        case "weakpoint_damage":
            if ( !isdefined( var_8 ) )
                return 0;

            if ( isdefined( var_6 ) && ( var_6 == "head" || var_6 == "neck" ) && var_2 > 0 && isdefined( var_8.alien_type ) && var_8.alien_type == "ancestor" )
                maps\mp\alien\_unk1422::_ID34406( "weakpoint_damage", var_2 );

            return 0;
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

last_death_challenge_func( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
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
                else if ( maps\mp\alien\_unk1464::_ID14264() == "ancestor" && var_3 != "MOD_SUICIDE" )
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
                    if ( var_1.origin[2] - self.origin[2] > 55 )
                        maps\mp\alien\_unk1422::_ID34406( "higher_ground", 1 );
                }
            }

            return 0;
        case "lower_ground":
            if ( isdefined( var_1 ) && isplayer( var_1 ) )
            {
                if ( !isdefined( var_0 ) || isdefined( var_0 ) && !maps\mp\alien\_unk1464::is_trap( var_0 ) )
                {
                    if ( self.origin[2] - var_1.origin[2] > 55 )
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
        case "semi_autos_only":
        case "2_weapons_only":
            maps\mp\alien\_unk1422::_ID34406( level.current_challenge, var_4, var_3 );
            return 0;
        case "melee_5_goons_last":
            if ( isdefined( self.alien_type ) && self.alien_type == "goon" && isdefined( var_1 ) && isplayer( var_1 ) && var_3 == "MOD_MELEE" )
                maps\mp\alien\_unk1422::_ID34406( "melee_5_goons_last", 1 );

            return 0;
        case "stay_within_area_1":
        case "stay_within_area_2":
        case "stay_within_area_3":
        case "stay_within_area_4":
        case "stay_within_area_5":
            if ( isdefined( var_1 ) && isplayer( var_1 ) )
                maps\mp\alien\_unk1422::_ID34406( level.current_challenge, self.origin, var_1.origin );

            break;
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

activate_weakpoint_damage()
{
    maps\mp\alien\_challenge_function::default_resetsuccess();
    self._ID8660 = 0;
    self.goal = self.goal * 1000;
    maps\mp\alien\_challenge_function::_ID34408( 0, self.goal );
}

activate_no_ancestor_damage()
{
    self._ID8660 = 0;
    var_0 = int( gettime() + self.goal * 1000 );

    foreach ( var_2 in level.players )
        var_2 setclientomnvar( "ui_intel_timer", var_0 );

    level._ID8632 = self.goal;
    level thread maps\mp\alien\_challenge_function::_ID34410();
    level thread wait_for_ancestor_player_damage( self );
    level thread complete_ancestor_damage_challenge( self );
}

wait_for_ancestor_player_damage( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "success" );
    level endon( "ancestor_damage_challenge_complete" );
    level waittill( "ancestor_damage_taken" );
    var_0._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
}

complete_ancestor_damage_challenge( var_0 )
{
    level endon( "game_ended" );
    level endon( "ancestor_damage_taken" );
    wait(var_0.goal);
    var_0._ID32046 = 1;
    level notify( "ancestor_damage_challenge_complete" );
    maps\mp\alien\_unk1422::deactivate_current_challenge();
}

activate_kill_ancestor()
{
    maps\mp\alien\_challenge_function::default_resetsuccess();
    self._ID8660 = 0;
    var_0 = int( gettime() + self.goal * 1000 );

    foreach ( var_2 in level.players )
        var_2 setclientomnvar( "ui_intel_timer", var_0 );

    level._ID8632 = self.goal;
    level thread maps\mp\alien\_challenge_function::_ID34410();
    level thread wait_for_ancestor_death( self );
    level thread fail_ancestor_challenge( self );
}

wait_for_ancestor_death( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "success" );
    level endon( "ancestor_challenge_failed" );
    level waittill( "ancestor_died" );
    var_0._ID32046 = 1;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
}

fail_ancestor_challenge( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "success" );
    level endon( "ancestor_died" );
    wait(var_0.goal);
    level notify( "ancestor_challenge_failed" );
    var_0._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
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

last_custom_onalienagentdamaged_func( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( isdefined( var_5 ) && var_5 == "turret_dlc4_alien_shock" )
    {
        last_shock_turret_hit_marker_override( var_1, "standard" );

        if ( isdefined( level.shock_turret_bullet_damage_scalar ) )
            var_2 *= level.shock_turret_bullet_damage_scalar;
    }

    if ( isdefined( var_0 ) && isdefined( var_0.targetname ) && var_0.targetname == "scriptable_destructible_barrel" )
        var_2 += 750;

    return var_2;
}

last_shock_turret_hit_marker_override( var_0, var_1 )
{
    if ( isdefined( var_0.owner ) )
    {
        var_0.owner thread maps\mp\gametypes\_damagefeedback::_ID34528( var_1 );
        return;
    }

    var_0 thread maps\mp\gametypes\_damagefeedback::_ID34528( var_1 );
    return;
}

_ID36955( var_0, var_1 )
{
    var_2 = [];

    switch ( var_0 )
    {
        case "transition_middle":
            var_2[var_2.size] = ( 1772, 1335, 25 );
            var_2[var_2.size] = ( 973, 1414, 19 );
            var_2[var_2.size] = ( 525, 1991, 15 );
            break;
        case "transition_right":
            var_2[var_2.size] = ( 1897, 775, 11 );
            var_2[var_2.size] = ( 2068, 253, 23 );
            var_2[var_2.size] = ( 2547, 1524, 19 );
            break;
        case "transition_left":
            var_2[var_2.size] = ( -886, 933, 11 );
            var_2[var_2.size] = ( -1442, 994, 19 );
            var_2[var_2.size] = ( -2130, 1786, 203 );
            break;
        case "transition_upper_left":
            var_2[var_2.size] = ( -996, 3690, 11 );
            break;
        case "transition_upper_right":
            var_2[var_2.size] = ( 1771, 3236, 11 );
            break;
    }

    if ( maps\mp\alien\_unk1464::_ID18506( var_1 ) )
    {
        return var_2;
        return;
    }

    return common_scripts\utility::_ID25350( var_2 );
    return;
}

last_pre_activate_stay_within_area()
{
    var_0 = get_all_ring_locations( level.current_hive_name );

    if ( isdefined( level._ID37046 ) && isdefined( level._ID37046.use_trigger ) && isdefined( level._ID37046.use_trigger.script_noteworthy ) && level._ID37046.use_trigger.script_noteworthy == "reverse_open" )
        var_0 = common_scripts\utility::array_reverse( var_0 );

    var_1 = var_0[0];
    var_2 = bullettrace( var_1 + ( 0, 0, 20 ), var_1 - ( 0, 0, 20 ), 0, undefined, 1, 0, 1, 1 );
    self._ID26314 = spawn( "script_model", var_2["position"] );
    self._ID26314 setmodel( "tag_origin" );
    wait 0.1;
    self.ring_fx = playfxontag( level._ID1644["challenge_ring"], self._ID26314, "tag_origin" );
    playsoundatpos( self._ID26314.origin, "plr_challenge_ring" );

    if ( !isdefined( level.waypoint_icon ) )
    {
        if ( isdefined( level.ring_waypoint_icon ) )
            level.ring_waypoint_icon destroy();

        var_3 = "waypoint_alien_blocker";
        var_4 = 14;
        var_5 = 14;
        var_6 = 0.75;
        var_7 = self._ID26314.origin + ( 0, 0, 32 );
        level.ring_waypoint_icon = maps\mp\alien\_hud::_ID37645( var_3, var_4, var_5, var_6, var_7 );
    }

    level thread move_challenge_ring( var_0, var_1, self, 0 );
    return 1;
}

get_all_ring_locations( var_0 )
{
    return _ID36955( var_0, 1 );
}

move_challenge_ring( var_0, var_1, var_2, var_3 )
{
    level endon( "ring_challenge_ended" );
    var_4 = 0;

    while ( !isdefined( var_2._ID8660 ) )
        wait 0.05;

    var_5 = var_2._ID8660;

    for (;;)
    {
        while ( var_5 == var_2._ID8660 )
            wait 0.05;

        common_scripts\utility::_ID35582();
        var_6 = var_2._ID8660 - var_5;
        var_5 = var_2._ID8660;
        var_4 += var_6;

        if ( var_4 < 5 )
            continue;
        else
            var_4 = 0;

        var_3++;

        if ( var_3 >= var_0.size )
            var_3 = 0;

        var_7 = var_0[var_3];
        var_8 = bullettrace( var_7 + ( 0, 0, 20 ), var_7 - ( 0, 0, 20 ), 0, undefined, 1, 0, 1, 1 );

        if ( isdefined( level.ring_waypoint_icon ) )
            level.ring_waypoint_icon.alpha = 0;

        var_2._ID26314 moveto( var_8["position"], 2 );
        playsoundatpos( var_2._ID26314.origin, "plr_challenge_ring" );
        wait 2.0;

        if ( isdefined( level.ring_waypoint_icon ) )
        {
            level.ring_waypoint_icon.alpha = 1.0;
            level.ring_waypoint_icon.x = var_8["position"][0];
            level.ring_waypoint_icon.y = var_8["position"][1];
            level.ring_waypoint_icon.z = var_8["position"][2] + 32;
        }
    }
}

last_update_stay_within_area( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( abs( var_1[2] - self._ID26314.origin[2] ) > 75 )
        return;

    var_9 = distancesquared( var_1, self._ID26314.origin );

    if ( var_9 > self._ID10239 )
        return;

    self._ID8660++;

    if ( self._ID8660 >= self.goal )
        self._ID32046 = 1;

    var_10 = self.goal - self._ID8660;
    maps\mp\alien\_challenge_function::_ID34408( self._ID8660, self.goal );

    if ( self._ID32046 )
    {
        maps\mp\alien\_unk1422::deactivate_current_challenge();
        return;
    }
}
