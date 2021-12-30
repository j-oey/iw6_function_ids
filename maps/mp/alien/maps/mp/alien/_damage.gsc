// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

callback_alienplayerdamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( common_scripts\utility::flag_exist( "player_using_vanguard" ) && common_scripts\utility::_ID13177( "player_using_vanguard" ) && isdefined( self._ID25826 ) )
        return;

    if ( isdefined( level.ancestor_projectile_solo_scalar ) && maps\mp\alien\_unk1464::_ID18745() && var_5 == "alien_ancestor_mp" )
        var_2 *= level.ancestor_projectile_solo_scalar;

    var_10 = 0;

    if ( maps\mp\alien\_perk_utility::_ID16358( "perk_rigger", [ 0, 1, 2, 3, 4 ] ) && maps\mp\alien\_unk1464::is_trap( var_0 ) )
        var_2 = 0;

    if ( isdefined( var_1 ) && ( var_5 == "alienspit_mp" || var_5 == "alienspit_gas_mp" ) )
    {
        if ( isdefined( var_1.team ) && self.team == var_1.team )
            return 0;
    }

    var_11 = self getcurrentprimaryweapon();
    var_12 = var_5 == "spider_beam_mp" || var_5 == "alienspit_mp" || var_5 == "alienspit_gas_mp" || var_5 == "spore_beam_mp" || var_5 == "gargoyle_beam_mp" || var_5 == "alien_ancestor_mp";

    if ( var_12 && var_8 == "shield" && !isdefined( self.spider_shield_block ) )
        thread riotshieldammodeplete();

    if ( var_5 == "spider_beam_mp" && maps\mp\alien\_unk1464::_ID18745() && isdefined( level._ID38082 ) && !isdefined( level._ID38082.has_fired_beam ) )
        var_2 = int( var_2 * 0.17 );

    if ( var_4 == "MOD_TRIGGER_HURT" )
        maps\mp\alien\_death::_ID22886( var_0, var_1, var_2, var_4, var_5, var_7, var_8, var_9 );
    else if ( _ID29903( var_1 ) )
    {
        var_13 = maps\mp\gametypes\_damage::_ID18633( self, var_1 );

        if ( !var_13 && isdefined( var_1 ) && var_1 != self )
            var_2 = int( var_2 * level._ID8862 );

        if ( isdefined( var_1 ) && var_1 == self )
        {
            switch ( var_5 )
            {
                case "alienbetty_mp":
                case "alienclaymore_mp":
                case "iw6_alienmk321_mp":
                case "iw6_alienmk322_mp":
                case "iw6_alienmk323_mp":
                case "iw6_alienmk324_mp":
                case "iw6_alienmaaws_mp":
                case "switchblade_rocket_mp":
                case "alienmortar_strike_mp":
                case "aliensoflam_missle_mp":
                case "alienims_projectile_mp":
                case "alienvulture_mp":
                case "alienims_projectileradius_mp":
                case "alienims_projectiledamage_mp":
                case "switchblade_baby_mp":
                case "switchblade_babyfast_mp":
                case "alien_semtex_turret_proj":
                case "turret_minigun_alien_shock":
                case "alienvanguard_projectile_mp":
                case "alienvanguard_projectile_mini_mp":
                case "iw6_alienrgm_mp":
                case "iw6_alienpanzerfaust3_mp":
                case "iw6_aliendlc41_mp":
                case "iw6_aliendlc42_mp":
                    var_2 = 0;
                    break;
                default:
                    if ( !maps\mp\alien\_unk1464::_ID18426() )
                        var_2 = int( min( 10, var_2 * 0.05 ) );
                    else
                        var_2 = int( min( level._ID37911, var_2 * 0.1 ) );

                    break;
            }
        }
        else if ( var_13 )
        {
            if ( maps\mp\alien\_unk1464::_ID18426() )
            {
                switch ( var_5 )
                {
                    case "switchblade_rocket_mp":
                    case "alienmortar_strike_mp":
                    case "alienims_projectile_mp":
                    case "alienvulture_mp":
                    case "alienims_projectileradius_mp":
                    case "alienims_projectiledamage_mp":
                    case "switchblade_baby_mp":
                    case "switchblade_babyfast_mp":
                    case "alienvanguard_projectile_mp":
                    case "alienvanguard_projectile_mini_mp":
                        var_2 = 0;
                        break;
                }

                if ( maps\mp\alien\_unk1464::_ID37537() )
                {
                    if ( isdefined( var_1 ) && isplayer( var_1 ) && isdefined( var_8 ) && var_8 != "shield" )
                    {
                        if ( isdefined( var_0 ) )
                            var_1 dodamage( var_2, var_1.origin - ( 0, 0, 50 ), var_1, var_0, var_4 );
                        else
                            var_1 dodamage( var_2, var_1.origin, var_1 );
                    }

                    var_2 = 0;
                }
            }
            else
                var_2 = 0;
        }
        else if ( isdefined( var_1 ) && isdefined( var_1.classname ) && var_1.classname == "scriptable" && isdefined( var_1.is_hive ) && var_1.is_hive )
            var_2 = 1;

        if ( isdefined( var_1 ) && isagent( var_1 ) )
        {
            if ( var_5 == "alienbetty_mp" || var_5 == "alienclaymore_mp" )
                var_2 = 0;
        }

        if ( var_4 == "MOD_EXPLOSIVE" && isdefined( var_0 ) && isdefined( var_0.targetname ) && ( var_0.targetname == "scriptable_destructible_barrel" || var_0.targetname == "armory_transformer" ) )
            var_2 = 3;

        if ( var_4 == "MOD_FALLING" )
        {
            if ( maps\mp\_utility::_hasperk( "specialty_falldamage" ) )
                var_2 = 0;
            else if ( var_2 > 10 )
            {
                if ( var_2 > self.health * 0.15 )
                    var_2 = int( self.health * 0.15 );
            }
            else
                var_2 = 0;
        }

        if ( isdefined( var_1 ) && var_1 maps\mp\alien\_unk1464::_ID29838( self ) )
            applyaliensnare();

        if ( var_4 == "MOD_EXPLOSIVE_BULLET" )
        {
            if ( !maps\mp\alien\_unk1464::_ID18426() || var_1 == self && var_8 == "none" )
                var_2 = 0;
        }

        if ( maps\mp\alien\_perk_utility::_ID16358( "perk_medic", [ 3, 4 ] ) && self._ID18764 == 1 )
            var_2 = int( var_2 * maps\mp\alien\_perk_utility::_ID23438() );

        if ( maps\mp\alien\_perk_utility::_ID16358( "perk_rigger", [ 3, 4 ] ) && self.isrepairing == 1 )
            var_2 = int( var_2 * maps\mp\alien\_perk_utility::_ID23437() );

        if ( ( !var_13 || var_1 == self && maps\mp\alien\_unk1464::_ID37537() ) && isdefined( self.bodyarmorhp ) && var_4 != "MOD_EXPLOSIVE_BULLET" && !isdefined( self.ability_invulnerable ) )
        {
            self.bodyarmorhp = self.bodyarmorhp - var_2 + var_10;

            if ( maps\mp\alien\_perk_utility::_ID16358( "perk_rigger", [ 0, 1, 2, 3, 4 ] ) && maps\mp\alien\_unk1464::is_trap( var_0 ) )
                var_2 = 0;
            else
                var_2 = 1;

            var_10 = 0;

            if ( self.bodyarmorhp <= 0 )
            {
                var_2 = abs( self.bodyarmorhp );
                var_10 = 0;
                _ID34313();
            }

            if ( isdefined( var_1 ) && var_1 != self && var_1 maps\mp\alien\_unk1464::is_alien_agent() && isdefined( self.bodyarmorhp ) && maps\mp\alien\_persistence::is_upgrade_enabled( "stun_armor_upgrade" ) && var_4 == "MOD_UNKNOWN" )
            {
                var_14 = randomintrange( 0, 100 );

                if ( var_14 <= 25 )
                    var_1 thread delayed_stun_damage( self );
            }
        }

        var_15 = 0.0;

        if ( isdefined( var_1 ) && var_5 == "alien_minion_explosion" )
        {
            if ( maps\mp\alien\_persistence::is_upgrade_enabled( "minion_protection_upgrade" ) )
                var_2 *= 0.8;
        }

        var_16 = maps\mp\alien\_prestige::_ID24907();
        var_2 *= var_16;
        var_2 = int( var_2 );
        var_17 = _ID34808( var_2 );

        if ( _ID29904( var_2, var_17 ) )
            _ID34753( var_2 );

        if ( isdefined( self.ability_invulnerable ) )
            var_2 = int( 0 );

        if ( var_2 > 0 )
            maps\mp\alien\_hud::playpainoverlay( var_1, var_5, var_7 );

        if ( !var_13 || maps\mp\alien\_unk1464::_ID18426() )
        {
            maps\mp\gametypes\_damage::_ID12959( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_15 );
            self notify( "player_damaged" );
        }

        maps\mp\alien\_unk1443::_ID38217( maps\mp\alien\_unk1443::get_personal_score_component_name(), "damage_taken", var_2 );

        if ( var_2 > 0 )
        {
            level.alienbbdata["damage_taken"] = level.alienbbdata["damage_taken"] + var_2;

            if ( isdefined( var_1 ) && isagent( var_1 ) )
            {
                if ( !isdefined( var_1.damage_done ) )
                    var_1.damage_done = 0;
                else
                    var_1.damage_done = var_1.damage_done + var_2;
            }

            self notify( "dlc_vo_notify",  "pain", self  );

            if ( !isdefined( level._ID38237 ) )
                thread maps\mp\alien\_music_and_dialog::player_pain_vo();
        }

        if ( var_2 > 0 && isdefined( var_1 ) && isdefined( level.current_challenge ) )
        {
            if ( level.current_challenge == "take_no_damage" )
                maps\mp\alien\_unk1422::_ID34406( "take_no_damage" );
            else if ( level.current_challenge == "no_ancestor_damage" && isagent( var_1 ) && isdefined( var_1.alien_type ) && var_1.alien_type == "ancestor" )
                level notify( "ancestor_damage_taken" );
            else if ( level.current_challenge == "avoid_minion_explosion" && isdefined( var_1.model ) && var_1.model != "alien_seeder" && isdefined( var_5 ) && var_5 == "alien_minion_explosion" )
                maps\mp\alien\_unk1422::_ID34406( "avoid_minion_explosion" );
        }
    }
}

delayed_stun_damage( var_0 )
{
    self endon( "death" );
    var_0 endon( "death" );
    wait 0.05;
    self dodamage( 2, self.origin, var_0, undefined, "MOD_MELEE" );
}

_ID29904( var_0, var_1 )
{
    var_2 = 20;

    if ( var_0 == 0 )
        return 0;

    if ( var_1 )
        return 1;
    else
        return self._ID16433 && var_0 > self.health && var_0 < self.health + var_2;
}

_ID34808( var_0 )
{
    var_1 = 0.2;
    var_2 = self.maxhealth * var_1;
    return maps\mp\_utility::_ID18837() && ( var_0 > self.health || self.health - var_0 <= var_2 );
}

_ID31864()
{
    self notify( "stop_using_remote" );
}

_ID34753( var_0 )
{
    self.health = var_0 + 1;
    self._ID16433 = 0;
}

_ID29903( var_0 )
{
    if ( isdefined( self._ID18011 ) && self._ID18011 )
        return 0;

    if ( gettime() < self._ID8983 )
        return 0;

    return 1;
}

_ID37521( var_0, var_1, var_2, var_3 )
{
    if ( level.gameended )
        return 0;

    if ( _ID37129() )
        return 0;

    if ( !isdefined( self ) || !maps\mp\_utility::_ID18757( self ) )
        return 0;

    var_4 = isdefined( var_2 ) && var_2 == "spider_beam_mp";

    if ( !var_4 && isdefined( var_1 ) && isdefined( var_1.team ) && self.team == var_1.team && !alientypecandofriendlydamage( var_1, var_2 ) )
        return 0;

    if ( isdefined( var_3 ) && var_3 == "MOD_CRUSH" && isdefined( var_0 ) && isdefined( var_0.classname ) && var_0.classname == "script_vehicle" )
        return 0;

    if ( isdefined( var_3 ) && var_3 == "MOD_FALLING" )
        return 0;

    if ( isdefined( self._ID22326 ) && self._ID22326 && isdefined( var_3 ) && var_3 == "MOD_TRIGGER_HURT" )
        return 0;

    if ( isdefined( var_1 ) && isdefined( var_1.classname ) && var_1.classname == "script_origin" && isdefined( var_1.type ) && var_1.type == "soft_landing" )
        return 0;

    if ( var_2 == "killstreak_emp_mp" )
        return 0;

    return 1;
}

_ID22770( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( self.health < 0 )
    {
        self suicide();
        return 0;
    }

    if ( isdefined( var_1 ) && isplayer( var_1 ) && var_4 != "MOD_MELEE" && var_1 maps\mp\alien\_persistence::is_upgrade_enabled( "sniper_soft_upgrade" ) && maps\mp\_utility::getweaponclass( var_5 ) == "weapon_sniper" )
        var_8 = "soft";

    if ( !_ID37521( var_0, var_1, var_5, var_4 ) )
        return 0;

    var_2 = scale_alien_damage_func( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

    if ( isdefined( level._ID37062 ) )
        var_2 = [[ level._ID37062 ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

    if ( isdefined( level._ID37058 ) )
        var_2 = [[ level._ID37058 ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

    if ( var_4 == "MOD_MELEE" && level.players.size == 1 )
        var_2 = int( var_2 * 0.9 );

    var_10 = 0;

    if ( isdefined( var_1 ) && isdefined( var_1.burning_victim ) && var_1.burning_victim )
    {
        var_10 = var_1.burning_victim;
        var_1.burning_victim = undefined;
    }

    if ( isdefined( var_1 ) && isplayer( var_1 ) )
    {
        if ( var_4 == "MOD_MELEE" )
        {
            if ( var_1 maps\mp\alien\_persistence::is_upgrade_enabled( "shock_melee_upgrade" ) && maps\mp\alien\_unk1464::_ID18506( var_1.meleestrength ) && weapontype( var_5 ) != "riotshield" )
                var_1 thread stun_zap_aliens( self.origin, self, var_2, var_4 );
        }
        else if ( var_1 maps\mp\alien\_unk1464::has_stun_ammo( var_5 ) && var_1 maps\mp\alien\_persistence::is_upgrade_enabled( "stun_ammo_upgrade" ) && var_4 != "MOD_UNKNOWN" )
            var_1 thread stun_zap_aliens( self.origin, self, var_2, var_4 );
    }

    if ( isdefined( var_5 ) && var_5 != "alien_ims_projectile_mp" && isplayer( var_1 ) && var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) && isdefined( var_8 ) && var_8 == "armor" )
    {
        if ( var_1 maps\mp\alien\_persistence::is_upgrade_enabled( "armor_piercing_upgrade" ) )
            var_2 = int( var_2 * 2.0 * 1.1 );
        else
            var_2 = int( var_2 * 2.0 );
    }

    if ( var_5 == "alienspit_mp" || var_5 == "alienspit_gas_mp" )
        var_2 = int( var_2 * 5 );

    if ( isdefined( var_1 ) && isdefined( self.pet ) && isdefined( var_1.team ) && self.team == var_1.team )
        return 0;

    maps\mp\alien\_chaos::update_alien_damaged_event( var_5 );
    var_2 = _ID37939( var_4, var_5, var_2, var_1, var_3, var_6, var_7, var_8, var_9, var_0 );

    if ( isplayer( var_1 ) && !maps\mp\alien\_unk1464::is_trap( var_0 ) )
    {
        var_2 = _ID37927( var_1, var_2, var_4, var_5 );
        var_2 = _ID37929( var_1, var_2, var_4, var_5, var_8 );

        if ( isdefined( var_5 ) )
            thread maps\mp\alien\_achievement::_ID38188( var_5 );
    }

    var_2 = _ID34142( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

    if ( var_2 <= 0 )
        return 0;

    if ( isdefined( var_1 ) && var_1 != self && var_2 > 0 && ( !isdefined( var_8 ) || var_8 != "shield" ) )
    {
        if ( var_10 )
            var_11 = "standard";
        else if ( isdefined( var_0 ) && var_0 != var_1 )
        {
            if ( means_of_explosive_damage( var_4 ) )
                var_11 = "standard";
            else
                var_11 = "none";
        }
        else if ( isdefined( var_0 ) && isdefined( var_0.damagefeedback ) && var_0.damagefeedback == 0 )
            var_11 = "none";
        else if ( !maps\mp\gametypes\_damage::_ID29906( var_5 ) )
            var_11 = "none";
        else if ( var_3 & level._ID17348 )
            var_11 = "stun";
        else if ( !var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) && var_8 == "armor" )
            var_11 = "hitalienarmor";
        else if ( var_8 == "soft" )
            var_11 = "hitaliensoft";
        else if ( var_4 == "MOD_MELEE" && var_5 == "meleestun_mp" )
            var_11 = "meleestun";
        else
            var_11 = "standard";

        if ( isdefined( level._ID4063 ) && var_1 == level._ID4063 )
            var_2 = int( var_2 * 0.6 );
        else if ( isdefined( var_1.owner ) )
            var_1.owner thread maps\mp\gametypes\_damagefeedback::_ID34528( var_11 );
        else
            var_1 thread maps\mp\gametypes\_damagefeedback::_ID34528( var_11 );
    }

    var_2 = _ID37928( var_1, var_2 );
    _ID38199( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
    return self [[ maps\mp\agents\_agent_utility::agentfunc( "on_damaged_finished" ) ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

_ID37939( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( isdefined( var_1 ) )
    {
        if ( var_1 == "xm25_mp" && var_0 == "MOD_IMPACT" )
            var_2 = 95;

        if ( var_1 == "spider_beam_mp" )
            var_2 *= 15;

        if ( var_1 == "alienthrowingknife_mp" && var_0 == "MOD_IMPACT" )
        {
            if ( maps\mp\alien\_unk1464::can_hypno( var_3, 0, var_4, var_0, var_1, var_5, var_6, var_7, var_8, var_9 ) )
                var_2 = 20000;
            else if ( self.alien_type != "elite" )
                var_2 = 500;
        }

        if ( var_1 == "iw6_alienminigun_mp" || var_1 == "iw6_alienminigun1_mp" || var_1 == "iw6_alienminigun2_mp" || var_1 == "iw6_alienminigun3_mp" )
            var_2 = 55;

        if ( var_1 == "iw6_alienminigun4_mp" )
            var_2 = 75;
    }

    return var_2;
}

_ID38199( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isdefined( level._ID4063 ) || var_1 != level._ID4063 )
    {
        if ( isdefined( var_1 ) && isdefined( var_1.owner ) )
            maps\mp\alien\_unk1443::giveassistbonus( var_1.owner, var_2 * 0.75 );
        else if ( isdefined( var_1 ) && isdefined( var_1.pet ) && var_1.pet == 1 )
            maps\mp\alien\_unk1443::giveassistbonus( var_1.owner, var_2 );
        else
            maps\mp\alien\_unk1443::giveassistbonus( var_1, var_2 );

        if ( isdefined( var_1 ) && isdefined( var_5 ) )
        {
            var_1 thread maps\mp\alien\_persistence::update_weaponstats_hits( var_5, 1, var_4 );
            level thread maps\mp\alien\_challenge_function::_ID34394( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self );
        }
    }

    maps\mp\alien\_unk1443::_ID34451( var_1, var_2, var_4 );
}

_ID37929( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_4 ) && var_4 != "none" )
        var_1 = check_for_explosive_shotgun_damage( self, var_1, var_0, var_3, var_2 );

    if ( isdefined( var_2 ) && var_2 == "MOD_EXPLOSIVE_BULLET" && var_4 != "none" )
    {
        if ( maps\mp\_utility::getweaponclass( var_3 ) == "weapon_shotgun" )
            var_1 += int( var_1 * level._ID29789 );
        else
            var_1 += int( var_1 * level._ID12498 );
    }

    return var_1;
}

_ID37927( var_0, var_1, var_2, var_3 )
{
    var_4 = 1.05;

    if ( maps\mp\_utility::_ID18573( var_2 ) && !_ID18542( var_3 ) )
    {
        if ( !_ID18542( var_3 ) )
            var_1 = int( var_1 * var_0 maps\mp\alien\_perk_utility::_ID23426() );
        else if ( _ID18541( var_3 ) )
            var_1 = int( var_1 * var_0 maps\mp\alien\_perk_utility::_ID23441() );

        if ( isdefined( var_0.ability_scalar_bullet ) )
            var_1 = int( var_1 * var_0.ability_scalar_bullet );
    }

    if ( var_2 == "MOD_EXPLOSIVE" )
        var_1 = int( var_1 * var_0 maps\mp\alien\_perk_utility::_ID23430() );

    if ( var_2 == "MOD_MELEE" )
    {
        if ( weapontype( var_3 ) == "riotshield" )
            var_0 _ID26330();

        playfxontag( level._ID1644["melee_blood"], var_0, "tag_weapon_right" );
        var_1 = int( var_1 * var_0 maps\mp\alien\_perk_utility::_ID23433() );

        if ( isdefined( var_0.ability_scalar_melee ) )
            var_1 = int( var_1 * var_0.ability_scalar_melee );
    }

    if ( var_0 maps\mp\alien\_persistence::is_upgrade_enabled( "damage_booster_upgrade" ) )
        var_1 = int( var_1 * var_4 );

    return var_1;
}

_ID37928( var_0, var_1 )
{
    if ( isplayer( var_0 ) )
    {
        var_2 = var_0 maps\mp\alien\_prestige::prestige_getweapondamagescalar();
        var_1 *= var_2;
        var_1 = int( var_1 );
    }

    return var_1;
}

_ID37129()
{
    return isdefined( level.hostmigrationtimer );
}

means_of_explosive_damage( var_0 )
{
    return var_0 == "MOD_EXPLOSIVE" || var_0 == "MOD_GRENADE_SPLASH" || var_0 == "MOD_GRENADE" || var_0 == "MOD_PROJECTILE" || var_0 == "MOD_PROJECTILE_SPLASH";
}

check_for_explosive_shotgun_damage( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = 500;

    if ( !isdefined( var_0 ) || !maps\mp\_utility::_ID18757( var_0 ) )
        return var_1;

    if ( !isdefined( var_2 ) || !isplayer( var_2 ) || var_4 != "MOD_EXPLOSIVE_BULLET" )
        return var_1;

    if ( maps\mp\_utility::getweaponclass( var_3 ) == "weapon_shotgun" )
    {
        var_6 = distance( var_2.origin, var_0.origin );
        var_7 = max( 1, var_6 / var_5 );
        var_8 = var_1 * 8;
        var_9 = var_8 * var_7;

        if ( var_6 > var_5 )
            return var_1;

        return int( var_9 );
    }

    return var_1;
}

_ID34142( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "elite":
            var_2 = maps\mp\agents\alien\_alien_elite::elitedamageprocessing( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
            break;
        default:
            break;
    }

    return int( var_2 );
}

_ID37543( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    switch ( var_0 )
    {
        case "alien_sentry_minigun_1_mp":
        case "alien_sentry_minigun_2_mp":
        case "alien_sentry_minigun_3_mp":
        case "alien_sentry_minigun_4_mp":
        case "alien_ball_drone_gun_mp":
        case "alien_ball_drone_gun1_mp":
        case "alien_ball_drone_gun2_mp":
        case "alien_ball_drone_gun3_mp":
        case "alien_ball_drone_gun4_mp":
        case "alienvulture_mp":
            return 1;
        default:
            return 0;
    }

    return 0;
}

_ID18542( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    switch ( var_0 )
    {
        case "sentry_minigun_mp":
        case "turret_minigun_alien":
        case "alien_manned_gl_turret_mp":
        case "alien_manned_gl_turret1_mp":
        case "alien_manned_gl_turret2_mp":
        case "alien_manned_gl_turret3_mp":
        case "alien_manned_gl_turret4_mp":
        case "alien_manned_minigun_turret_mp":
        case "alien_manned_minigun_turret1_mp":
        case "alien_manned_minigun_turret2_mp":
        case "alien_manned_minigun_turret3_mp":
        case "alien_manned_minigun_turret4_mp":
        case "alien_sentry_minigun_1_mp":
        case "alien_sentry_minigun_2_mp":
        case "alien_sentry_minigun_3_mp":
        case "alien_sentry_minigun_4_mp":
        case "alien_ball_drone_gun_mp":
        case "alien_ball_drone_gun1_mp":
        case "alien_ball_drone_gun2_mp":
        case "alien_ball_drone_gun3_mp":
        case "alien_ball_drone_gun4_mp":
        case "alienvulture_mp":
        case "turret_minigun_alien_railgun":
        case "turret_minigun_alien_grenade":
        case "alientank_turret_mp":
        case "alientank_rigger_turret_mp":
            return 1;
        default:
            return 0;
    }

    return 0;
}

_ID18541( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    switch ( var_0 )
    {
        case "turret_minigun_alien":
        case "turret_minigun_alien_railgun":
        case "turret_minigun_alien_grenade":
        case "alientank_turret_mp":
        case "alientank_rigger_turret_mp":
            return 1;
        default:
            return 0;
    }

    return 0;
}

armormitigation( var_0, var_1, var_2 )
{
    if ( maps\mp\alien\_unk1464::_ID34129( maps\mp\alien\_unk1464::_ID14264() ) )
        return maps\mp\agents\alien\_alien_think::armormitigation( var_0, var_1, var_2 );

    return 1.0;
}

alientypecandofriendlydamage( var_0, var_1 )
{
    if ( !isdefined( var_0.alien_type ) )
        return 1;

    if ( isdefined( var_1 ) && var_1 == "spider_beam_mp" )
        return 1;

    switch ( var_0 maps\mp\alien\_unk1464::_ID14264() )
    {
        case "minion":
            return 1;
        default:
            return 0;
    }
}

_ID26330()
{
    if ( !isdefined( self ) || !isalive( self ) )
        return;

    var_0 = maps\mp\alien\_unk1464::_ID26334();

    if ( !isdefined( var_0 ) || !self hasweapon( var_0 ) )
        return;

    var_1 = self getweaponammoclip( var_0 );
    self setweaponammoclip( var_0, var_1 - 1 );
    self notify( "riotshield_melee" );
    self setclientomnvar( "ui_alien_stowed_riotshield_ammo", var_1 - 1 );
    self playsound( "crate_impact" );
    earthquake( 0.75, 0.5, self.origin, 100 );

    if ( self getweaponammoclip( var_0 ) <= 0 )
    {
        var_2 = 1;

        if ( self.hasriotshield && !self._ID16417 )
            var_2 = 0;

        self takeweapon( var_0 );
        self.hasriotshield = 0;
        self._ID16417 = 0;

        if ( var_2 )
        {
            self detachshieldmodel( "weapon_riot_shield_iw6", "tag_weapon_right" );
            self iprintlnbold( &"ALIENS_HANDY_RIOT_DESTROYED" );
            var_3 = self getweaponslist( "primary" );

            if ( var_3.size > 0 )
                self switchtoweapon( var_3[0] );
        }
        else
        {
            self detachshieldmodel( "weapon_riot_shield_iw6", "tag_shield_back" );
            self iprintlnbold( &"ALIENS_STOWED_RIOT_DESTROYED" );
        }

        self setclientomnvar( "ui_alien_riotshield_equipped", -1 );
    }
}

riotshieldammodeplete()
{
    self.spider_shield_block = 1;
    _ID26330();
    wait 0.4;
    self.spider_shield_block = undefined;
}

check_for_special_damage( var_0, var_1, var_2 )
{
    if ( var_2 == "MOD_MELEE" && weapontype( var_1 ) != "riotshield" )
        return;

    if ( isdefined( var_1 ) && var_1 == "alienims_projectile_mp" )
        return;

    if ( !isdefined( var_0.is_burning ) && isalive( var_0 ) )
    {
        if ( isdefined( self._ID16351 ) && self._ID16351 && var_2 != "MOD_UNKNOWN" )
            var_0 thread catch_alien_on_fire( self, undefined, undefined, 1 );

        if ( var_1 == "iw5_alienriotshield4_mp" && self.fireshield == 1.0 )
            var_0 thread catch_alien_on_fire( self );

        switch ( var_1 )
        {
            case "iw6_alienminigun3_mp":
            case "iw6_alienminigun4_mp":
            case "iw6_alienmk323_mp":
            case "iw6_alienmk324_mp":
            case "alien_manned_gl_turret4_mp":
            case "alienvulture_mp":
                var_0 thread catch_alien_on_fire( self );
                break;
        }
    }
    else
    {
        var_3 = maps\mp\alien\_unk1464::getrawbaseweaponname( var_1 );

        if ( isdefined( self.special_ammocount ) && isdefined( self.special_ammocount[var_3] ) && self.special_ammocount[var_3] > 0 )
            return;
    }
}

catch_alien_on_fire( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    maps\mp\alien\_alien_fx::alien_fire_on();
    damage_alien_over_time( var_0, var_1, var_2, var_3 );
    maps\mp\alien\_alien_fx::alien_fire_off();
}

damage_alien_over_time( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );

    if ( !isdefined( var_1 ) && !isdefined( var_2 ) )
    {
        if ( self.alien_type == "goon" )
        {
            var_2 = 150;
            var_1 = 3;
        }
        else if ( self.alien_type == "brute" )
        {
            var_2 = 250;
            var_1 = 4;
        }
        else if ( self.alien_type == "spitter" )
        {
            var_2 = 200;
            var_1 = 4;
        }
        else if ( self.alien_type == "elite" )
        {
            var_2 = 500;
            var_1 = 4;
        }
        else if ( self.alien_type == "minion" )
        {
            var_2 = 100;
            var_1 = 2;
        }
        else
        {
            var_2 = 150;
            var_1 = 3;
        }
    }
    else
    {
        if ( !isdefined( var_2 ) )
            var_2 = 150;

        if ( !isdefined( var_1 ) )
            var_1 = 3;
    }

    if ( isdefined( var_0 ) && isdefined( var_3 ) && var_0 maps\mp\alien\_persistence::is_upgrade_enabled( "incendiary_ammo_upgrade" ) && isdefined( var_3 ) )
        var_2 *= 1.2;

    var_2 *= level.alien_health_per_player_scalar[level.players.size];
    var_4 = 0;
    var_5 = 6;
    var_6 = var_1 / var_5;
    var_7 = var_2 / var_5;

    for ( var_8 = 0; var_8 < var_5; var_8++ )
    {
        wait(var_6);

        if ( isalive( self ) )
            self dodamage( var_7, self.origin, var_0, var_0, "MOD_UNKNOWN" );
    }
}

_ID28656( var_0 )
{
    self notify( "give_light_armor" );

    if ( isdefined( self.bodyarmorhp ) )
        _ID34313();

    thread removebodyarmorondeath();
    thread _ID25980();
    self.bodyarmorhp = 150;

    if ( isdefined( var_0 ) )
        self.bodyarmorhp = var_0;
}

removebodyarmorondeath()
{
    self endon( "disconnect" );
    self endon( "give_light_armor" );
    self endon( "remove_light_armor" );
    self waittill( "death" );
    _ID34313();
}

_ID34313()
{
    self.bodyarmorhp = undefined;
    self notify( "remove_light_armor" );
}

_ID25980()
{
    self endon( "disconnect" );
    self endon( "remove_light_armor" );
    level common_scripts\utility::_ID35626( "round_end_finished", "game_ended" );
    thread _ID34313();
}

_ID16384()
{
    return isdefined( self.bodyarmorhp ) && self.bodyarmorhp > 0;
}

_ID16397( var_0 )
{
    return isdefined( var_0.heavyarmorhp ) && var_0.heavyarmorhp > 0;
}

_ID28747( var_0 )
{
    if ( isdefined( var_0 ) )
        self.heavyarmorhp = var_0;
}

applyaliensnare()
{
    thread applyaliensnareinternal();
}

applyaliensnareinternal()
{
    self notify( "stop_applyAlienSnare" );
    self endon( "stop_applyAlienSnare" );
    self endon( "disconnect" );
    self endon( "death" );
    self.aliensnarecount++;
    self._ID2862 = pow( 0.68, ( self.aliensnarecount + 1 ) * 0.35 );
    self._ID2862 = max( 0.58, self._ID2862 );
    maps\mp\alien\_perkfunctions::_ID34522();
    wait 0.8;
    self.aliensnarecount = 0;
    self._ID2862 = 1.0;
    maps\mp\alien\_perkfunctions::_ID34522();
}

scale_alien_damage_func( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( maps\mp\alien\_unk1464::_ID14264() == "mammoth" )
        var_2 = adjust_mammoth_damage( var_2 );

    var_10 = maps\mp\_utility::getweaponclass( var_5 );

    if ( level.script == "mp_alien_dlc3" && var_10 != "weapon_pistol" )
    {
        var_11 = 1.25;

        if ( maps\mp\_utility::_ID18573( var_4 ) && !_ID18542( var_5 ) )
        {
            if ( isdefined( var_1 ) && isplayer( var_1 ) && isdefined( var_5 ) && maps\mp\alien\_unk1464::weapon_has_alien_attachment( var_5 ) )
            {
                if ( var_1 maps\mp\alien\_perk_utility::_ID16358( "perk_bullet_damage", [ 0, 1, 2, 3, 4 ] ) )
                    var_11 = 1.15;

                var_12 = int( var_2 * var_11 );
                return var_12;
            }
        }
    }

    return var_2;
}

adjust_mammoth_damage( var_0 )
{
    if ( isdefined( self.burrowing ) && self.burrowing )
        return 0;

    return var_0;
}

stun_zap_aliens( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self.stun_struct ) )
        return;

    var_4 = 62500;
    var_5 = maps\mp\alien\_spawnlogic::_ID14265();

    if ( isdefined( level.seeder_active_turrets ) )
        var_5 = common_scripts\utility::array_combine( var_5, level.seeder_active_turrets );

    var_6 = [];

    foreach ( var_8 in var_5 )
    {
        if ( distancesquared( var_0, var_8.origin ) < var_4 )
            var_6[var_6.size] = var_8;
    }

    if ( var_6.size < 1 )
        return;

    var_10 = 0;
    var_11 = 1;

    if ( !isdefined( self.stun_struct ) )
    {
        self.stun_struct = spawnstruct();
        self.stun_struct.attack_bolt = spawn( "script_model", var_0 );
        self.stun_struct.attack_bolt setmodel( "tag_origin" );
        common_scripts\utility::_ID35582();
    }

    self.stun_struct.attack_bolt.origin = var_0;
    var_12 = maps\mp\alien\_persistence::_ID14428();

    if ( isdefined( var_3 ) && var_3 != "MOD_MELEE" )
        var_11 += var_12;
    else
    {
        var_11 = 4;
        var_2 /= 4;
    }

    foreach ( var_8 in var_6 )
    {
        if ( isdefined( var_8 ) && var_8 != var_1 && isalive( var_8 ) )
        {
            var_8 stun_bolt_death( self, var_2, var_3 );
            var_10++;

            if ( var_10 >= var_11 )
                break;

            wait 0.1;
        }
    }

    wait 0.05;
    killfxontag( level._ID1644["stun_attack"], self.stun_struct.attack_bolt, "TAG_ORIGIN" );
    killfxontag( level._ID1644["stun_shock"], self.stun_struct.attack_bolt, "TAG_ORIGIN" );
    self.stun_struct.attack_bolt delete();
    self.stun_struct = undefined;
}

stun_bolt_death( var_0, var_1, var_2 )
{
    common_scripts\utility::_ID35582();
    playfxontag( level._ID1644["stun_attack"], var_0.stun_struct.attack_bolt, "TAG_ORIGIN" );
    playfxontag( level._ID1644["stun_shock"], var_0.stun_struct.attack_bolt, "TAG_ORIGIN" );
    var_3 = undefined;

    if ( isdefined( self.alien_type ) && self.alien_type == "seeder_spore" )
        var_3 = self gettagorigin( "J_Spore_46" );
    else if ( isdefined( self ) && isalive( self ) && maps\mp\alien\_unk1464::has_tag( self.model, "J_SpineUpper" ) )
        var_3 = self gettagorigin( "J_SpineUpper" );

    if ( isdefined( var_3 ) )
    {
        var_0.stun_struct.attack_bolt moveto( var_3, 0.05 );
        wait 0.05;

        if ( isdefined( self ) && var_2 == "MOD_MELEE" )
            self playsound( "alien_fence_shock" );

        wait 0.05;
        var_4 = int( var_1 / 2 );

        if ( isdefined( self ) )
        {
            var_5 = self;

            if ( isdefined( self.alien_type ) && self.alien_type == "seeder_spore" )
                var_5 = self.coll_model;

            if ( isdefined( var_5 ) )
                var_5 dodamage( var_4, self.origin, var_0, var_0.stun_struct.attack_bolt, var_2 );
        }
    }

    stopfxontag( level._ID1644["stun_attack"], var_0.stun_struct.attack_bolt, "TAG_ORIGIN" );
}
