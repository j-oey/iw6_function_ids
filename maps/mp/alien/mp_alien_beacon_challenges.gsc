// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

register_beacon_challenges()
{
    level._ID37058 = ::beacon_custom_onalienagentdamaged_func;
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
    maps\mp\alien\_challenge_function::_ID25676( "kill_tentacle", undefined, 0, undefined, undefined, ::activate_kill_tentacle, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::_ID37251 );
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
    {
        maps\mp\alien\_unk1422::deactivate_current_challenge();
        return;
    }
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

activate_kill_tentacle()
{
    maps\mp\alien\_challenge_function::default_resetsuccess();
    level thread fail_tentacle_challenge( self );
    level thread beat_tentacle_challenge( self );
}

beat_tentacle_challenge( var_0 )
{
    level endon( "drill_detonated" );
    level waittill( "miniboss_beaten" );
    var_0._ID32046 = 1;

    if ( var_0._ID32046 )
    {
        maps\mp\alien\_unk1422::deactivate_current_challenge();
        return;
    }
}

fail_tentacle_challenge( var_0 )
{
    level endon( "miniboss_beaten" );
    level waittill( "drill_detonated" );
    var_0._ID32046 = 0;
    maps\mp\alien\_unk1422::deactivate_current_challenge();
}

beacon_challenge_scalar_func( var_0 )
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

beacon_damage_challenge_func( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
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

beacon_death_challenge_func( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
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
    {
        maps\mp\alien\_outline_proto::disable_outline( self );
        return;
    }
}

beacon_custom_onalienagentdamaged_func( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( isdefined( var_5 ) && var_5 == "turret_minigun_alien_shock" )
    {
        beacon_shock_turret_hit_marker_override( var_1, "standard" );

        if ( isdefined( level.shock_turret_bullet_damage_scalar ) )
            var_2 *= level.shock_turret_bullet_damage_scalar;
    }

    if ( isdefined( var_0 ) && isdefined( var_0.targetname ) && var_0.targetname == "scriptable_destructible_barrel" )
        var_2 += 750;

    return var_2;
}

beacon_shock_turret_hit_marker_override( var_0, var_1 )
{
    if ( isdefined( var_0.owner ) )
    {
        var_0.owner thread maps\mp\gametypes\_damagefeedback::_ID34528( var_1 );
        return;
    }

    var_0 thread maps\mp\gametypes\_damagefeedback::_ID34528( var_1 );
    return;
}

_ID36955( var_0 )
{
    var_1 = [];

    if ( isdefined( level.drill ) )
        var_1[var_1.size] = level.drill.origin + ( 0, 0, 15 );

    switch ( var_0 )
    {
        case "mini_lung_00":
            var_1[var_1.size] = ( -673, -697, 196 );
            var_1[var_1.size] = ( 220, -2735, 188 );
            var_1[var_1.size] = ( -620, -2940, 60 );
            break;
        case "well_deck_2":
            var_1[var_1.size] = ( -186, -1823, 60 );
            var_1[var_1.size] = ( 197, -1936, 188 );
            break;
        case "well_deck_3":
            var_1[var_1.size] = ( -1092, 87, -68 );
            break;
        case "cargo_area_mini_1":
            var_1[var_1.size] = ( 521, 3238, 388 );
            break;
        case "cargo_area_mini_2":
            var_1[var_1.size] = ( 40, 2564, 304 );
            var_1[var_1.size] = ( -577, 2159, 196 );
            break;
        case "cargo_area_mini_3":
            break;
        case "cargo_area_mini_4":
            var_1[var_1.size] = ( 843, 2369, 244 );
            var_1[var_1.size] = ( -577, 2159, 196 );
            break;
        case "cargo_area_main":
            break;
        case "top_deck_mini_1":
            var_1[var_1.size] = ( -146, 3486, 1212 );
            var_1[var_1.size] = ( -46, 2461, 1212 );
            break;
        case "top_deck_mini_2":
            var_1[var_1.size] = ( 218, 2991, 1348 );
            var_1[var_1.size] = ( -440, 3379, 1212 );
            var_1[var_1.size] = ( 697, 2224, 1212 );
            break;
        case "top_deck_mini_3":
            var_1[var_1.size] = ( -10, 2756, 1348 );
            var_1[var_1.size] = ( -436, 2915, 1212 );
            break;
        case "lab_mini_1":
            var_1[var_1.size] = ( 229, 5094, 1338 );
            var_1[var_1.size] = ( -768, 5276, 1338 );
            var_1[var_1.size] = ( 159, 5307, 1468 );
            break;
        case "lab_mini_2":
            var_1[var_1.size] = ( -911, 5707, 1216 );
            var_1[var_1.size] = ( -277, 4604, 1468 );
            var_1[var_1.size] = ( -565, 5674, 1468 );
            var_1[var_1.size] = ( 188, 5720, 1212 );
            break;
        case "lab_mini_3":
            var_1[var_1.size] = ( 98, 4543, 1468 );
            var_1[var_1.size] = ( -741, 4914, 1468 );
            var_1[var_1.size] = ( -365, 4865, 1380 );
            var_1[var_1.size] = ( -909, 5309, 1216 );
            break;
        case "lab_mini_4":
            var_1[var_1.size] = ( -762, 4181, 1340 );
            var_1[var_1.size] = ( -210, 4854, 1380 );
            var_1[var_1.size] = ( 224, 4710, 1338 );
            break;
        case "lab_area_main":
            break;
    }

    return common_scripts\utility::_ID25350( var_1 );
}
