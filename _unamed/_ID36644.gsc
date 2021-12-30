// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID37875()
{
    level._ID37058 = ::_ID36732;
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
    maps\mp\alien\_challenge_function::_ID25676( "kill_eggs", undefined, 0, undefined, undefined, ::_ID36657, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
    maps\mp\alien\_challenge_function::_ID25676( "kill_spider", undefined, 0, undefined, undefined, ::_ID36655, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
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
    }
    else if ( maps\mp\alien\_unk1464::_ID18506( var_1 ) )
    {
        level notify( "current_challenge_ended" );
        self._ID32046 = 0;
        maps\mp\alien\_unk1422::deactivate_current_challenge();
    }
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
            if ( !isalive( var_4 ) || isdefined( var_4.pet ) )
                continue;

            if ( var_4.alien_type == "spider" || maps\mp\alien\_unk1464::_ID18506( var_4._ID37651 ) )
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

_ID36655()
{
    maps\mp\alien\_challenge_function::default_resetsuccess();
    var_0 = int( gettime() + self.goal * 1000 );

    foreach ( var_2 in level.players )
        var_2 setclientomnvar( "ui_intel_timer", var_0 );

    level._ID8632 = self.goal;
    level thread maps\mp\alien\_challenge_function::_ID34410();
    level thread _ID37576( self );
    thread _ID38210();
}

_ID37576( var_0 )
{
    level endon( "game_ended" );
    level endon( "spider_battle_end" );
    wait(var_0.goal);
    var_0._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
    level notify( "spider_challenge_failed" );
}

_ID38210()
{
    level endon( "spider_challenge_failed" );
    level waittill( "spider_battle_end" );
    self._ID32046 = 1;

    if ( self._ID32046 )
        maps\mp\alien\_unk1422::deactivate_current_challenge();
}

_ID36657()
{
    _ID37248();
    level thread _ID37193( self );
    level thread _ID36781( self );
}

_ID36781( var_0 )
{
    level endon( "spider_battle_end" );

    for (;;)
    {
        level waittill( "egg_destroyed" );
        maps\mp\alien\_unk1422::_ID34406( "kill_eggs", 1 );
    }
}

_ID37193( var_0 )
{
    level endon( "current_challenge_ended" );
    level waittill( "spider_battle_end" );
    var_0._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
}

_ID36731( var_0 )
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

_ID36733( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
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

_ID36734( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isdefined( level.current_challenge ) )
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
                maps\mp\alien\_unk1422::_ID34406( "air_shot", 1 );

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
            else if ( var_3 != "MOD_SUICIDE" )
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
        case "kill_phantom":
            if ( isdefined( var_1 ) && isplayer( var_1 ) && maps\mp\alien\_unk1464::_ID14264() == "locust" && maps\mp\alien\_unk1464::_ID18506( self._ID37524 ) )
                maps\mp\alien\_unk1422::_ID34406( "kill_phantom", 1 );

            return 0;
        case "kill_nodamage":
            if ( isdefined( var_1 ) && isplayer( var_1 ) )
                maps\mp\alien\_unk1422::_ID34406( "kill_nodamage", 1 );

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

_ID37889()
{
    level endon( "game_ended" );
    self waittill( "death" );

    if ( isdefined( self._ID36951 ) )
        maps\mp\alien\_outline_proto::disable_outline( self );
}

_ID36732( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( isdefined( var_0 ) && isdefined( var_0.targetname ) && var_0.targetname == "scriptable_destructible_barrel" )
        var_2 += 750;

    return var_2;
}

_ID36955( var_0 )
{
    var_1 = [];

    if ( isdefined( level.drill ) )
        var_1[var_1.size] = level.drill.origin + ( 0, 0, 15 );

    switch ( var_0 )
    {
        case "checkpoint_hive_01":
            var_1[var_1.size] = ( -3904, -6944, 656 );
            var_1[var_1.size] = ( -3296, -6688, 800 );
            break;
        case "checkpoint_hive_02":
            var_1[var_1.size] = ( -2304, -6848, 620 );
            var_1[var_1.size] = ( -2384, -5472, 620 );
            var_1[var_1.size] = ( -1824, -6592, 796 );
            break;
        case "checkpoint_hive_03":
            var_1[var_1.size] = ( -2656, -6336, 796 );
            break;
        case "checkpoint_hive_04":
            var_1[var_1.size] = ( -2754.5, -5745.5, 818.545 );
            var_1[var_1.size] = ( -1775.5, -6317, 818.545 );
            break;
        case "checkpoint_hive_05":
            var_1[var_1.size] = ( -3619.5, -5835.5, 598.5 );
            var_1[var_1.size] = ( -3907, -6235.5, 636.956 );
            var_1[var_1.size] = ( -3088.5, -5738, 804.456 );
            break;
        case "compound_hive_01":
            var_1[var_1.size] = ( -2716, -5047, 847.545 );
            var_1[var_1.size] = ( -2716, -4492.5, 847.545 );
            var_1[var_1.size] = ( -3600.5, -4886.5, 755.545 );
            break;
        case "compound_hive_02":
            var_1[var_1.size] = ( -3875.5, -4079, 721.045 );
            var_1[var_1.size] = ( -3025.5, -3949.5, 645.545 );
            var_1[var_1.size] = ( -3180, -4674.5, 607.545 );
            break;
        case "compound_hive_03":
            var_1[var_1.size] = ( -3872, -3136, 877.045 );
            var_1[var_1.size] = ( -3962.5, -3717, 639.045 );
            var_1[var_1.size] = ( -5127, -2992, 619.045 );
            var_1[var_1.size] = ( -4479.5, -3756, 844.545 );
            break;
        case "compound_hive_04":
            var_1[var_1.size] = ( -2954.78, -3323.5, 677.996 );
            var_1[var_1.size] = ( -2287.28, -3195, 677.996 );
            break;
        case "compound_hive_05":
            var_1[var_1.size] = ( -1269.28, -3383, 693.996 );
            var_1[var_1.size] = ( -1965.28, -3104, 711.996 );
            break;
        case "compound_hive_06":
            var_1[var_1.size] = ( -2138.28, -3246.5, 684.811 );
            var_1[var_1.size] = ( -1927.78, -3632, 817.811 );
            var_1[var_1.size] = ( -1770.78, -3315, 688.199 );
            break;
        case "compound_hive_07":
            var_1[var_1.size] = ( -3056.78, -2784, 851.996 );
            var_1[var_1.size] = ( -3381.28, -3157.5, 681.496 );
            var_1[var_1.size] = ( -3601.28, -3111.5, 878.496 );
            break;
        case "compound_hive_08":
            var_1[var_1.size] = ( -4069, -3665, 607.545 );
            var_1[var_1.size] = ( -3875.5, -4079, 721.045 );
            var_1[var_1.size] = ( -3180, -4674.5, 607.545 );
            break;
        case "facility_hive_01":
            var_1[var_1.size] = ( -2039.78, -1898, 684 );
            var_1[var_1.size] = ( -1550.78, -1185, 865.5 );
            var_1[var_1.size] = ( -2227.28, -1288, 684 );
            break;
        case "facility_hive_02":
            var_1[var_1.size] = ( -2927.28, -912.495, 681 );
            var_1[var_1.size] = ( -2816.78, -235.995, 818.5 );
            var_1[var_1.size] = ( -1671.78, -589.495, 862.5 );
            break;
        case "facility_hive_03":
            var_1[var_1.size] = ( -2852.78, -222.495, 845.5 );
            var_1[var_1.size] = ( -3284.28, -237.495, 812 );
            var_1[var_1.size] = ( -2559.28, -843.495, 1023 );
            var_1[var_1.size] = ( -3191.78, -1478, 812 );
            break;
        case "facility_hive_04":
            var_1[var_1.size] = ( -2527.28, -1754.5, 688.199 );
            var_1[var_1.size] = ( -3186.28, -1577.5, 810.699 );
        case "facility_hive_05":
            var_1[var_1.size] = ( -1666.28, -897.995, 860 );
            var_1[var_1.size] = ( -1322.28, -856.995, 1006 );
            var_1[var_1.size] = ( -2249.28, -1273.5, 1005.5 );
        case "facility_hive_07":
            var_1[var_1.size] = ( -1332.78, -871.995, 996.5 );
            var_1[var_1.size] = ( -2225.78, -1288, 990.5 );
            var_1[var_1.size] = ( -2631.28, -861.995, 990.5 );
            break;
    }

    return common_scripts\utility::_ID25350( var_1 );
}
