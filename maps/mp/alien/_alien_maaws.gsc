// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

alien_maaws_init()
{
    level.alternate_trinity_weapon_try_use = ::tryuse_dpad_maaws;
    level.alternate_trinity_weapon_use = ::use_dpad_maaws;
    level.alternate_trinity_weapon_cancel_use = ::canceluse_dpad_maaws;
    level._ID1644["maaws_burst"] = loadfx( "vfx/gameplay/alien/vfx_alien_maaws_burst" );
}

tryuse_dpad_maaws( var_0, var_1 )
{
    thread tryuse_dpad_maaws_internal( var_0, var_1 );
}

tryuse_dpad_maaws_internal( var_0, var_1 )
{
    waittillframeend;
    maps\mp\alien\_unk1464::store_weapons_status();
    self._ID19508 = self getcurrentweapon();
    var_2 = "iw6_alienmaaws_mp";

    if ( !isdefined( level.cosine ) )
    {
        level.cosine = [];
        level.cosine["90"] = cos( 90 );
        level.cosine["89"] = cos( 89 );
        level.cosine["45"] = cos( 45 );
        level.cosine["25"] = cos( 25 );
        level.cosine["15"] = cos( 15 );
        level.cosine["10"] = cos( 10 );
        level.cosine["5"] = cos( 5 );
    }

    maps\mp\_utility::_giveweapon( var_2 );
    wait 0.05;
    self switchtoweapon( var_2 );
    self disableweaponswitch();

    if ( var_1 > 3 )
        self setweaponammoclip( var_2, 3 );
    else if ( var_1 > 0 )
        self setweaponammoclip( var_2, 2 );

    thread handle_missile_logic( var_2, var_1 );
}

use_dpad_maaws( var_0, var_1 )
{
    if ( maps\mp\alien\_unk1464::_ID18437() )
        return;

    var_2 = "iw6_alienmaaws_mp";

    switch ( var_1 )
    {
        case 0:
            var_2 = "iw6_alienmaaws_mp";
            break;
        case 1:
            var_2 = "iw6_alienmaaws_mp";
            break;
        case 2:
            var_2 = "iw6_alienmaaws_mp";
            break;
        case 3:
            var_2 = "iw6_alienmaaws_mp";
            break;
        case 4:
            var_2 = "iw6_alienmaaws_mp";
            break;
    }

    thread maps\mp\alien\_combat_resources::_ID35926( var_2 );
    wait 0.1;
}

watch_rank_for_fof( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self notify( "fof_cancel" );
    self endon( "fof_cancel" );

    if ( var_1 > 0 )
    {
        while ( self getcurrentweapon() != var_0 )
            wait 0.05;

        self thermalvisionfofoverlayon();

        while ( self getcurrentweapon() == var_0 )
            wait 0.05;

        self thermalvisionfofoverlayoff();
    }
}

within_fov_set_dot( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = get_alien_origin( var_2 );

    if ( !isdefined( var_5 ) )
        return 0;

    var_6 = vectornormalize( var_5 - var_0 );

    if ( !isdefined( var_4 ) || var_4 == "forward" )
        var_7 = anglestoforward( var_1 );
    else
        var_7 = anglestoright( var_1 );

    var_8 = vectordot( var_7, var_6 );
    var_2._ID10775 = var_8;
    return var_8 >= var_3;
}

missile_bullet_trace( var_0, var_1, var_2, var_3 )
{
    var_4 = bullettrace( var_0, var_1, 1, level.player, 1, 0, 1 );

    if ( !isdefined( var_4["entity"] ) )
        return 0;

    if ( var_4["entity"] != var_2 )
        return 0;
    else
        return 1;
}

get_forward_point( var_0, var_1 )
{
    var_2 = anglestoforward( var_1 );
    var_2 = vectornormalize( var_2 );
    var_2 = ( var_2[0] * 2, var_2[1] * 2, var_2[2] * 2 );
    var_2 += var_0;
    return var_2;
}

handle_missile_logic( var_0, var_1 )
{
    self endon( "cancel_maaws" );
    self endon( "death" );
    self endon( "disconnect" );
    var_2 = "iw6_alienmaawschild_mp";
    self.maaws_done = 0;

    if ( !isdefined( self.trace_available ) )
        thread manage_bullet_trace_queue( var_0 );

    while ( self getammocount( var_0 ) )
    {
        level.alien_on_drill = undefined;
        self waittill( "missile_fire",  var_3, var_4  );

        if ( !isdefined( level.outlined_aliens ) )
            level.outlined_aliens = [];

        level.outlined_aliens common_scripts\utility::array_removeundefined( level.outlined_aliens );
        var_5 = 10000;
        var_6 = 0;
        var_7 = var_3.origin;

        while ( isdefined( var_3 ) && var_6 < var_5 )
        {
            var_8 = var_3.origin;
            var_6 = distancesquared( var_8, var_7 );
            wait 0.1;
        }

        if ( isdefined( var_3 ) )
        {
            var_3 thread alien_maaws_initial_projectile_death_fx();
            var_9 = var_3.origin;
            var_10 = var_3.angles;
            var_11 = 45;
            thread fire_missile_at_angles( var_9, var_10, var_2, 0, ( 1, 0, 0 ) );
            common_scripts\utility::_ID35582();
            var_12 = ( var_10[0] - var_11 / 10, var_10[1] - var_11 / 4, var_10[2] );

            if ( isdefined( var_3 ) )
                thread fire_missile_at_angles( var_9, var_12, var_2, var_1, ( 0, 1, 0 ) );

            common_scripts\utility::_ID35582();
            var_13 = ( var_10[0] - var_11 / 10, var_10[1] + var_11 / 4, var_10[2] );

            if ( isdefined( var_3 ) )
                thread fire_missile_at_angles( var_9, var_13, var_2, var_1, ( 0, 0, 1 ) );

            common_scripts\utility::_ID35582();

            if ( var_1 > 2 )
            {
                var_13 = ( var_10[0], var_10[1] + var_11 / 2, var_10[2] );

                if ( isdefined( var_3 ) )
                    thread fire_missile_at_angles( var_9, var_13, var_2, var_1, ( 1, 1, 0 ) );

                common_scripts\utility::_ID35582();
                var_14 = ( var_10[0], var_10[1] - var_11 / 2, var_10[2] );

                if ( isdefined( var_3 ) )
                    thread fire_missile_at_angles( var_9, var_14, var_2, var_1, ( 1, 0, 1 ) );

                common_scripts\utility::_ID35582();
            }
        }

        if ( isdefined( var_3 ) )
            var_3 delete();
    }

    self.maaws_done = 1;
}

fire_missile_at_angles( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_5 = get_forward_point( var_0, var_1 );
    var_6 = magicbullet( var_2, var_0, var_5, self );
    var_6 endon( "death" );
    self.player_missiles[self.player_missiles.size] = var_6;
    thread damage_alien_on_drill( var_6 );

    if ( isdefined( var_3 ) && var_3 > 1 )
    {
        var_7 = maps\mp\alien\_spawnlogic::_ID14265();

        if ( level.script == "mp_alien_last" && isdefined( level.active_ancestors ) )
            var_7 = common_scripts\utility::array_combine( var_7, level.active_ancestors );

        if ( isdefined( level.seeder_active_turrets ) )
            var_7 = common_scripts\utility::array_combine( var_7, level.seeder_active_turrets );

        var_7 = get_alien_targets_in_fov( self.origin, self.angles, "10" );
        var_8 = get_missile_target( var_6, var_7, var_4 );

        if ( isdefined( var_8 ) )
        {
            var_6._ID32581 = var_8;
            var_9 = ( 0, 0, 10 );

            if ( isalive( var_6._ID32581 ) && isdefined( var_6._ID32581.alien_type ) && var_6._ID32581.alien_type == "ancestor" )
                var_9 = ( 0, 0, 110 );

            var_6 missile_settargetent( var_8, var_9 );
        }
        else
        {
            wait 0.1;
            thread scan_for_targets( var_6, var_4 );
        }
    }
}

damage_alien_on_drill( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    var_1 = undefined;
    var_0 waittill( "death" );
    var_1 = var_0.origin;

    if ( isdefined( var_1 ) && isdefined( level.alien_on_drill ) && isalive( level.alien_on_drill ) )
    {
        if ( distancesquared( level.alien_on_drill.origin, var_1 ) < 10000 )
            level.alien_on_drill dodamage( 275, var_1, self, var_0, "MOD_PROJECTILE" );
        else if ( distancesquared( level.alien_on_drill.origin, var_1 ) < 62500 )
            level.alien_on_drill dodamage( 125, var_1, self, var_0, "MOD_PROJECTILE" );
    }
}

scan_for_targets( var_0, var_1 )
{
    var_0 endon( "death" );
    self endon( "death" );
    self endon( "disconnect" );
    var_2 = undefined;

    while ( !isdefined( var_2 ) )
    {
        var_2 = get_missile_target( var_0, undefined, var_1 );

        if ( isdefined( var_2 ) )
        {
            var_0._ID32581 = var_2;
            var_3 = ( 0, 0, 10 );

            if ( isalive( var_0._ID32581 ) && isdefined( var_0._ID32581.alien_type ) && var_0._ID32581.alien_type == "ancestor" )
                var_3 = ( 0, 0, 110 );

            var_0 missile_settargetent( var_2, var_3 );
            break;
        }

        wait 0.25;
    }
}

get_missile_target( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "disconnect" );

    if ( !isdefined( var_0 ) )
        return undefined;

    var_3 = get_array_of_targets( var_0, "5", var_1, var_2 );

    if ( var_3.size == 0 )
    {
        var_3 = get_array_of_targets( var_0, "45", var_1, var_2 );

        if ( var_3.size == 0 )
            var_3 = get_array_of_targets( var_0, "89", var_1, var_2 );
    }

    if ( var_3.size > 0 )
    {
        var_4 = var_3[0];

        foreach ( var_6 in var_3 )
        {
            if ( isdefined( var_6.alien_type ) && ( var_6.alien_type == "gargoyle" || var_6.alien_type == "bomber" ) )
            {
                var_4 = var_6;
                break;
            }
        }

        if ( !_ID18435( level.outlined_aliens, var_4 ) )
            level.outlined_aliens[level.outlined_aliens.size] = var_4;

        return var_4;
    }

    return undefined;
}

get_array_of_targets( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "death" );
    self endon( "death" );
    self endon( "disconnect" );

    if ( !isdefined( var_0 ) )
        return undefined;

    var_4 = 0;
    var_5 = [];
    var_6 = [];

    if ( isdefined( var_2 ) )
        var_6 = get_alien_targets_in_fov( self.origin, self.angles, var_1, var_2 );
    else
        var_6 = get_alien_targets_in_fov( var_0.origin, var_0.angles, var_1 );

    if ( var_6.size > 0 )
    {
        var_6 = common_scripts\utility::_ID14293( var_0.origin, var_6 );

        foreach ( var_8 in var_6 )
        {
            if ( !isdefined( var_0 ) )
                break;

            if ( !isdefined( var_8 ) )
                continue;

            var_9 = get_alien_origin( var_8 );

            if ( !isdefined( var_9 ) )
                continue;

            if ( var_8 alien_is_on_drill() )
            {
                var_5[var_5.size] = var_8;
                level.alien_on_drill = var_8;
                continue;
            }

            self.trace_available[self.trace_available.size] = var_0;
            var_0 waittill( "my_turn_to_trace" );

            if ( !isdefined( var_0 ) )
                break;

            if ( !isdefined( var_8 ) )
                continue;

            var_9 = get_alien_origin( var_8 );

            if ( !isdefined( var_9 ) )
                continue;

            if ( isdefined( var_8.coll_model ) )
                var_8 = var_8.coll_model;

            if ( missile_bullet_trace( var_0.origin, var_9, var_8, var_3 ) )
            {
                var_5[var_5.size] = var_8;
                break;
            }

            common_scripts\utility::_ID35582();
        }
    }

    return var_5;
}

get_alien_targets_in_fov( var_0, var_1, var_2, var_3 )
{
    var_4 = [];

    if ( !isdefined( var_3 ) )
    {
        var_5 = maps\mp\alien\_spawnlogic::_ID14265();

        if ( level.script == "mp_alien_last" && isdefined( level.active_ancestors ) )
            var_5 = common_scripts\utility::array_combine( var_5, level.active_ancestors );

        if ( isdefined( level.seeder_active_turrets ) )
            var_5 = common_scripts\utility::array_combine( var_5, level.seeder_active_turrets );
    }
    else
        var_5 = var_3;

    foreach ( var_7 in var_5 )
    {
        if ( maps\mp\alien\_unk1464::_ID18506( var_7.pet ) )
            continue;

        if ( isdefined( var_7.agent_type ) && ( var_7.agent_type == "kraken" || var_7.agent_type == "kraken_tentacle" ) )
            continue;

        if ( within_fov_set_dot( var_0, var_1, var_7, level.cosine[var_2] ) )
            var_4[var_4.size] = var_7;
    }

    return var_4;
}

manage_bullet_trace_queue( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self.trace_available = [];
    self.player_missiles = [];

    for (;;)
    {
        self.player_missiles = common_scripts\utility::array_removeundefined( self.player_missiles );

        if ( self.maaws_done && self.player_missiles.size == 0 )
            break;

        if ( self.trace_available.size > 0 )
        {
            while ( !isdefined( self.trace_available[0] ) )
                self.trace_available = common_scripts\utility::array_remove( self.trace_available, self.trace_available[0] );

            self.trace_available[0] notify( "my_turn_to_trace" );
            self.trace_available = common_scripts\utility::array_remove( self.trace_available, self.trace_available[0] );
        }

        common_scripts\utility::_ID35582();
    }

    self.trace_available = undefined;
}

get_alien_origin( var_0 )
{
    if ( isalive( var_0 ) && isdefined( var_0.alien_type ) && ( var_0.alien_type == "seeder" || var_0.alien_type == "elite" ) )
        var_1 = var_0 gettagorigin( "TAG_ORIGIN" );
    else if ( isdefined( var_0.alien_type ) && var_0.alien_type == "seeder_spore" )
    {
        if ( !isdefined( var_0.coll_model ) )
            return undefined;

        var_1 = var_0 gettagorigin( "J_Spore_46" );
        var_0 = var_0.coll_model;
    }
    else if ( isalive( var_0 ) && isdefined( var_0.alien_type ) && var_0.alien_type == "ancestor" )
        var_1 = var_0.origin + ( 0, 0, 110 );
    else if ( isalive( var_0 ) && isdefined( var_0.model ) && maps\mp\alien\_unk1464::has_tag( var_0.model, "J_SpineUpper" ) )
        var_1 = var_0 gettagorigin( "J_SpineUpper" );
    else
        var_1 = var_0.origin + ( 0, 0, 10 );

    return var_1;
}

alien_is_on_drill()
{
    if ( isdefined( self._ID20883 ) && self._ID20883 == "synch" && ( isdefined( self._ID32296 ) && issubstr( self._ID32296, "attack_drill" ) ) )
        return 1;

    return 0;
}

alien_maaws_initial_projectile_death_fx()
{
    playfx( level._ID1644["maaws_burst"], self.origin );
}

_ID18435( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        if ( var_0[var_2] == var_1 )
            return 1;
    }

    return 0;
}

canceluse_dpad_maaws( var_0, var_1 )
{
    self endon( "disconnect" );
    maps\mp\alien\_combat_resources::wait_to_cancel_dpad_weapon();
    self notify( "cancel_maaws" );
    self takeweapon( "iw6_alienmaaws_mp" );
    self.maaws_done = 1;

    if ( isdefined( self._ID19508 ) && player_not_carrying_drill_or_cortex() )
    {
        self switchtoweapon( self._ID19508 );
        self enableweaponswitch();
    }

    return 1;
}

player_not_carrying_drill_or_cortex()
{
    if ( !isdefined( level.drill_carrier ) || isdefined( level.drill_carrier ) && self != level.drill_carrier )
        return 1;
    else if ( !isdefined( level.cortex_carrier ) || isdefined( level.cortex_carrier ) && self != level.cortex_carrier )
        return 1;

    return 0;
}
