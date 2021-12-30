// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    _ID28940();
    _ID37982();
}

_ID28940()
{
    level.bot_funcs["dropped_weapon_think"] = ::_ID38052;
    level.bot_funcs["dropped_weapon_cancel"] = ::_ID38058;
    level.bot_funcs["crate_low_ammo_check"] = ::_ID38055;
    level.bot_funcs["crate_should_claim"] = ::_ID38056;
    level.bot_funcs["crate_wait_use"] = ::_ID38057;
    level.bot_funcs["crate_in_range"] = ::_ID38054;
    level.bot_funcs["crate_can_use"] = ::_ID38053;
}

_ID37982()
{
    level.bots_gametype_handles_class_choice = 1;
}

_ID38058( var_0 )
{
    if ( maps\mp\bots\_bots_util::bot_get_total_gun_ammo() > 0 )
    {
        var_1 = maps\mp\_utility::getweaponclass( self getcurrentweapon() );

        if ( isdefined( var_0._ID22470 ) )
        {
            var_2 = var_0._ID22470.classname;

            if ( common_scripts\utility::string_starts_with( var_2, "weapon_" ) )
                var_2 = getsubstr( var_2, 7 );

            var_3 = maps\mp\_utility::getweaponclass( var_2 );

            if ( !_ID36887( var_1, var_3 ) )
                return 1;
        }
    }

    if ( !isdefined( var_0._ID22470 ) )
        return 1;

    return 0;
}

_ID38052()
{
    self notify( "bot_think_seek_dropped_weapons" );
    self endon( "bot_think_seek_dropped_weapons" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = 0;

        if ( self [[ level.bot_funcs["should_pickup_weapons"] ]]() && !maps\mp\bots\_bots_util::bot_is_remote_or_linked() )
        {
            if ( maps\mp\bots\_bots_util::bot_out_of_ammo() )
            {
                var_1 = getentarray( "dropped_weapon", "targetname" );
                var_2 = common_scripts\utility::_ID14293( self.origin, var_1 );

                if ( var_2.size > 0 )
                {
                    var_3 = var_2[0];
                    maps\mp\bots\_bots::bot_seek_dropped_weapon( var_3 );
                }
            }
            else
            {
                var_1 = getentarray( "dropped_weapon", "targetname" );
                var_2 = common_scripts\utility::_ID14293( self.origin, var_1 );

                if ( var_2.size > 0 )
                {
                    var_4 = self getnearestnode();

                    if ( isdefined( var_4 ) )
                    {
                        var_5 = maps\mp\_utility::getweaponclass( self getcurrentweapon() );

                        foreach ( var_3 in var_2 )
                        {
                            var_7 = var_3.classname;

                            if ( common_scripts\utility::string_starts_with( var_7, "weapon_" ) )
                                var_7 = getsubstr( var_7, 7 );

                            var_8 = maps\mp\_utility::getweaponclass( var_7 );

                            if ( _ID36887( var_5, var_8 ) )
                            {
                                if ( !isdefined( var_3.calculated_nearest_node ) || !var_3.calculated_nearest_node )
                                {
                                    var_3._ID21893 = getclosestnodeinsight( var_3.origin );
                                    var_3.calculated_nearest_node = 1;
                                }

                                if ( isdefined( var_3._ID21893 ) && nodesvisible( var_4, var_3._ID21893, 1 ) )
                                {
                                    maps\mp\bots\_bots::bot_seek_dropped_weapon( var_3 );
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }

        wait(randomfloatrange( 0.25, 0.75 ));
    }
}

_ID36871( var_0 )
{
    var_1 = 0;

    switch ( var_0 )
    {
        case "weapon_projectile":
        case "weapon_grenade":
        case "weapon_explosive":
        case "weapon_other":
            break;
        case "weapon_pistol":
            var_1 = 1;
            break;
        case "weapon_sniper":
        case "weapon_dmr":
            var_1 = 2;
            break;
        case "weapon_smg":
        case "weapon_assault":
        case "weapon_lmg":
        case "weapon_shotgun":
            var_1 = 3;
            break;
    }

    return var_1;
}

_ID36887( var_0, var_1 )
{
    var_2 = _ID36871( var_0 );
    var_3 = _ID36871( var_1 );
    return var_3 > var_2;
}

_ID38055()
{
    var_0 = self getcurrentweapon();
    var_1 = self getweaponammoclip( var_0 );
    var_2 = self getweaponammostock( var_0 );
    var_3 = weaponclipsize( var_0 );
    return var_1 + var_2 < var_3 * 0.25;
}

_ID38056()
{
    return 0;
}

_ID38057()
{
    maps\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time( 5000 );
}

_ID38054( var_0 )
{
    return 1;
}

_ID38053( var_0 )
{
    if ( maps\mp\bots\_bots::crate_can_use_always( var_0 ) )
    {
        if ( isdefined( var_0 ) && isdefined( var_0.bots_used ) && common_scripts\utility::array_contains( var_0.bots_used, self ) )
        {
            if ( maps\mp\bots\_bots_util::bot_out_of_ammo() )
                return 1;
            else
                return 0;
        }

        var_1 = maps\mp\_utility::getweaponclass( self getcurrentweapon() );

        if ( _ID36871( var_1 ) <= 1 )
            return 1;

        if ( _ID38055() )
            return 1;

        return 0;
    }

    return 0;
}
