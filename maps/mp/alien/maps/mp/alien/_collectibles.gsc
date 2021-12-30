// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID24809()
{
    if ( !maps\mp\alien\_unk1464::alien_mode_has( "collectible" ) )
        return;

    if ( !isdefined( level.alien_collectibles_table ) )
        level.alien_collectibles_table = "mp/alien/collectibles.csv";

    collectibles_model_precache();
    level._ID1644["Fire_Cloud"] = loadfx( "vfx/gameplay/alien/vfx_alien_gas_fire" );
    level._ID1644["Propane_explosion"] = loadfx( "vfx/gameplay/alien/vfx_alien_propane_tank_explosion" );
    level._ID1644["Propane_explosion_cheap"] = loadfx( "vfx/gameplay/alien/vfx_alien_propane_tank_exp_cheaper" );
    level._ID1644["Propane_explosion_cheapest"] = loadfx( "vfx/gameplay/alien/vfx_alien_propane_tank_exp_cheapest" );
    level._ID7668 = [];
    _ID7672( 0, 99 );
    _ID7672( 100, 199 );
    var_0 = [[ level._ID37428 ]]();

    foreach ( var_2 in level._ID7668 )
    {
        foreach ( var_5, var_4 in var_0 )
        {
            if ( var_2.desc == var_5 )
            {
                var_2.desc = get_localized_hint( var_2, var_4 );
                break;
            }
        }
    }

    level.pistol_ammo_cost = 1500;
}

get_localized_hint( var_0, var_1 )
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() && var_0.isweapon )
        return &"ALIEN_CHAOS_WEAPON_PICKUP_HINT";

    return var_1;
}

collectibles_model_precache()
{
    precachemodel( "propane_tank_aliens_iw6" );
}

_ID24774()
{
    if ( !maps\mp\alien\_unk1464::alien_mode_has( "collectible" ) )
        return;

    _ID7673();
    level._ID7670 = 0;
    level.alien_loot_initialized = 1;
}

_ID24207()
{
    self endon( "death" );
    self endon( "disconnect" );

    if ( !maps\mp\alien\_unk1464::alien_mode_has( "loot" ) )
        return;

    self.lootbag = [];
    self.has_health_pack = 0;
    self notify( "loot_initialized" );
    level._ID13049 = getdvarint( "scr_fireCloudDuration", "9" );
    level._ID13055 = getdvarint( "scr_fireCloudRadius", "125" );
    level.firecloudheight = getdvarint( "scr_fireCloudHeight", "120" );
    level.firecloudtickdamage = getdvarint( "scr_fireCloudTickDamage", "100" );
    level._ID13051 = getdvarint( "scr_fireCloudHiveTickDamage", "100" );
    level._ID13054 = getdvarint( "scr_fireCloudPlayerTickDamage", "3" );
    level.firecloudlingertime = getdvarint( "scr_fireCloudLingerTime", "6" );
}

_ID7673()
{
    level.itemexplodethisframe = 0;
    level.collectibles_worldcount = [];
    var_0 = common_scripts\utility::_ID15386( "item", "targetname" );

    if ( isdefined( level.additional_boss_weapon ) )
    {
        var_1 = [[ level.additional_boss_weapon ]]();

        if ( isdefined( var_1 ) )
            var_0 = common_scripts\utility::array_add( var_0, var_1 );
    }

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        var_0 = maps\mp\alien\_chaos::swap_weapon_items( var_0 );

    level._ID36418 = var_0;

    foreach ( var_3 in level._ID36418 )
    {
        var_3.item_ref = var_3.script_noteworthy;
        var_3 setup_item_data();
        level.collectibles_worldcount[var_3.item_ref] = level._ID7668[var_3.item_ref].count;
    }

    _ID17854();
    var_5 = maps\mp\alien\_unk1464::_ID37267();

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        var_5 = maps\mp\alien\_unk1464::get_chaos_area();

    thread _ID30691( var_5 );

    if ( isdefined( level._ID37177 ) )
        [[ level._ID37177 ]]( var_5 );
}

_ID17854()
{
    level.thrown_entities = [];
    level._ID32939 = [];
    level._ID32939["alienpropanetank_mp"] = _ID17853( 10000, "propane_tank_aliens_iw6", 1, &"ALIEN_COLLECTIBLES_PICKUP_PROPANE_TANK", ::_ID25114 );
}

_ID17853( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = spawnstruct();
    var_5._ID13474 = var_0;
    var_5.model = var_1;
    var_5.canbepickedup = var_2;
    var_5._ID16999 = var_3;
    var_5.pickupfunc = var_4;
    return var_5;
}

_ID30691( var_0 )
{
    var_1 = common_scripts\utility::array_randomize( level._ID36418 );

    foreach ( var_3 in var_1 )
    {
        if ( !var_3.data["persist"] && var_0 != "all" && !common_scripts\utility::array_contains( var_3._ID3788, var_0 ) )
            continue;

        if ( level.collectibles_worldcount[var_3.item_ref] > 0 )
        {
            if ( isdefined( var_3.item_ent ) )
                continue;

            var_3 _ID30690();
            var_3 thread item_pickup_listener();
            level.collectibles_worldcount[var_3.item_ref]--;
        }
    }
}

_ID25914( var_0 )
{
    foreach ( var_2 in level._ID36418 )
    {
        if ( isdefined( var_2.item_ent ) )
        {
            if ( !var_2.data["persist"] && var_0 != "all" && !common_scripts\utility::array_contains( var_2._ID3788, var_0 ) )
                continue;

            var_2 _ID25961();
            level.collectibles_worldcount[var_2.item_ref]++;
        }
    }
}

setup_item_data()
{
    self._ID23162 = spawnstruct();

    if ( !isdefined( self.script_noteworthy ) )
        self.script_noteworthy = self.item_ref;

    self.isloot = _ID18379( self.item_ref );
    self.isweapon = _ID18380( self.item_ref );
    self.isitem = _ID18378( self.item_ref );
    self._ID3788 = _ID14530();

    if ( isdefined( self._ID27766 ) )
    {
        var_0 = strtok( self._ID27766, " " );

        foreach ( var_2 in var_0 )
        {
            var_3 = strtok( self._ID27766, "=" );

            if ( var_3.size == 0 )
                continue;

            var_4 = var_3[0];
            var_5 = var_3[1];

            switch ( var_4 )
            {
                case "respawn_max":
                    self._ID23162.respawn_max = int( var_5 );
                    continue;
                case "unlock":
                    self._ID23162._ID34238 = int( var_5 );
                    continue;
                default:
                    continue;
            }
        }
    }

    self.data = [];
    self.data["count"] = level._ID7668[self.item_ref].count;
    self.data["respawn_count"] = level._ID7668[self.item_ref].respawn_max;
    self.data["times_collected"] = 0;
    self.data["last_collector"] = undefined;
    self.data["vis"] = 1;
    self.data["unlock"] = 1;
    self.data["persist"] = level._ID7668[self.item_ref]._ID23466;
    self.data["cost"] = level._ID7668[self.item_ref].cost;

    if ( isdefined( self._ID23162 ) )
    {
        if ( isdefined( self._ID23162.respawn_max ) )
            self.data["respawn_count"] = self._ID23162.respawn_max;

        if ( isdefined( self._ID23162._ID34238 ) )
            self.data["unlock"] = self._ID23162._ID34238;
    }
}

_ID14530()
{
    if ( !isdefined( level._ID36415 ) )
        return;

    var_0 = [];

    foreach ( var_3, var_2 in level._ID36415 )
    {
        if ( ispointinvolume( self.origin, var_2 ) )
            var_0[var_0.size] = var_3;
    }

    return var_0;
}

_ID30809( var_0, var_1 )
{
    var_2 = self.item_ref;
    var_3 = spawn( "script_model", get_world_item_spawn_pos( var_0 ) );
    var_3 setmodel( level._ID7668[var_2].model );

    if ( maps\mp\alien\_unk1464::is_chaos_mode() && maps\mp\alien\_unk1464::_ID18506( self.isweapon ) )
        var_3.weapon_ref = getsubstr( var_2, 7 );

    if ( isdefined( self.angles ) )
        var_3.angles = self.angles;
    else
        var_3.angles = ( 0, 0, 0 );

    self.item_ent = var_3;

    if ( var_1 )
    {
        _ID20491( self.item_ent, get_item_desc( var_2 ) );
        self._ID34703 = self.item_ent;
    }
    else
        self._ID34703 = spawn( "trigger_radius", var_3.origin, 0, 32, 32 );

    if ( should_explode_on_damage( var_2 ) )
        self.item_ent thread explodeondamage( 0 );

    self notify( "spawned" );

    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
    {
        if ( getsubstr( var_2, 0, 6 ) == "weapon" )
            maps\mp\alien\_outline_proto::add_to_outline_weapon_watch_list( var_3, self.data["cost"] );
        else
            maps\mp\alien\_outline_proto::add_to_outline_watch_list( var_3, self.data["cost"] );
    }
}

get_world_item_spawn_pos( var_0 )
{
    var_1 = ( 0, 0, 16 );

    if ( var_0 )
        return common_scripts\utility::drop_to_ground( self.origin, 32, -32 ) + var_1;
    else
        return self.origin;
}

_ID20491( var_0, var_1 )
{
    var_0 setcursorhint( "HINT_NOICON" );
    var_0 sethintstring( var_1 );
    var_0 makeusable();
}

should_explode_on_damage( var_0 )
{
    switch ( var_0 )
    {
        case "item_alienpropanetank_mp":
            return 1;
        default:
            return 0;
    }
}

_ID30690()
{
    _ID30809( 0, 1 );
}

_ID30702( var_0 )
{
    _ID30809( 1, 0 );
    self.item_ent._ID20364 = var_0;
    level._ID7670++;
    thread loot_collection_timeout();
}

loot_collection_timeout()
{
    self endon( "death" );
    self endon( "deleted" );

    for ( self.loot_collection_timeout = 5; self.loot_collection_timeout; self.loot_collection_timeout-- )
        wait 1;
}

_ID7448()
{
    self endon( "disconnect" );
    wait 1;
    self._ID23541 = 0;
}

item_pickup_listener()
{
    self endon( "death" );
    self endon( "timedout" );
    level endon( "game_ended" );

    for (;;)
    {
        self._ID34703 waittill( "trigger",  var_0  );
        var_0 notify( "cancel_watch" );
        var_0 notify( "kill_spendhint" );
        var_0._ID23541 = 1;
        var_0 thread _ID7448();

        if ( var_0 [[ _ID14482( self.item_ref ) ]]( self ) )
        {
            switch ( self.item_ref )
            {
                case "item_alienpropanetank_mp":
                    var_0 playlocalsound( "weap_pickup_propanetank_plr" );
                    break;
                default:
                    var_0 playlocalsound( "extinction_item_pickup" );
            }

            var_0 [[ get_func_give( self.item_ref ) ]]( self );
            self.data["last_collector"] = var_0;
            self.data["times_collected"]++;
            level.collectibles_worldcount[self.item_ref]++;
            var_0 notify( "loot_pickup",  self  );
        }
        else
        {
            wait 0.05;
            continue;
        }

        if ( self.data["persist"] > 0 )
            continue;
        else
        {
            _ID25961();

            if ( self.data["respawn_count"] <= 0 )
                return;

            level waittill( "alien_cycle_ended" );
            self.data["respawn_count"]--;
        }

        return;
    }
}

loot_pickup_listener( var_0, var_1 )
{
    self endon( "death" );
    self endon( "timedout" );
    level endon( "game_ended" );
    var_2 = _ID18379( self.item_ref );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !var_1 )
        _ID20491( self.item_ent, get_item_desc( self.item_ref ) );

    for (;;)
    {
        self._ID34703 waittill( "trigger",  var_3  );

        if ( !isdefined( var_3 ) || !isplayer( var_3 ) )
        {
            wait 0.05;
            continue;
        }

        if ( var_3 [[ _ID14482( self.item_ref ) ]]( self ) )
        {
            var_3 playlocalsound( "extinction_item_pickup" );
            var_3 thread [[ get_func_give( self.item_ref ) ]]( self );
            var_3 notify( "loot_pickup",  self  );
        }
        else
        {
            wait 0.05;
            continue;
        }

        if ( self.data["persist"] > 0 )
            continue;
        else
            _ID25920();

        return;
    }
}

_ID20366( var_0, var_1 )
{
    self endon( "death" );
    level endon( "game_ended" );

    for ( var_2 = var_1; var_2; var_2-- )
        wait 1;

    if ( self.data["persist"] > 0 )
    {
        self notify( "timedout" );
        _ID25961();
    }
}

_ID25920()
{
    _ID25961();
    level._ID7670--;
}

_ID25961()
{
    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
        maps\mp\alien\_outline_proto::_ID25902( self.item_ent );

    self.item_ent delete();

    if ( isdefined( self._ID34703 ) )
        self._ID34703 delete();
}

item_min_distance_from_players()
{
    return !maps\mp\alien\_unk1464::any_player_nearby( self.origin, 1.04858e+06.0 );
}

_ID18442( var_0 )
{
    return issubstr( var_0, "item" );
}

_ID7672( var_0, var_1 )
{
    for ( var_2 = var_0; var_2 < var_1; var_2++ )
    {
        var_3 = tablelookup( level.alien_collectibles_table, 0, var_2, 1 );

        if ( var_3 == "" )
            break;

        var_4 = spawnstruct();
        var_4.index = var_2;
        var_4._ID25633 = var_3;
        var_4.model = tablelookup( level.alien_collectibles_table, 0, var_2, 2 );
        var_4.name = tablelookup( level.alien_collectibles_table, 0, var_2, 3 );
        var_4.desc = tablelookup( level.alien_collectibles_table, 0, var_2, 4 );
        var_4.count = int( tablelookup( level.alien_collectibles_table, 0, var_2, 5 ) );
        var_4._ID23190 = tablelookup( level.alien_collectibles_table, 0, var_2, 7 );
        var_4._ID26151 = float( tablelookup( level.alien_collectibles_table, 0, var_2, 8 ) );
        var_4.respawn_max = int( tablelookup( level.alien_collectibles_table, 0, var_2, 9 ) );
        var_4._ID35313 = int( tablelookup( level.alien_collectibles_table, 0, var_2, 10 ) );
        var_4._ID34238 = int( tablelookup( level.alien_collectibles_table, 0, var_2, 11 ) );
        var_4.player_max = int( tablelookup( level.alien_collectibles_table, 0, var_2, 12 ) );
        var_4._ID23466 = int( tablelookup( level.alien_collectibles_table, 0, var_2, 13 ) );
        var_4.cost = int( tablelookup( level.alien_collectibles_table, 0, var_2, 15 ) );
        var_4.cost_display = tablelookup( level.alien_collectibles_table, 0, var_2, 15 );
        var_4.func_give = get_func_give( var_4._ID25633 );
        var_4._ID13735 = _ID14482( var_4._ID25633 );
        var_4.isloot = _ID18379( var_4._ID25633 );
        var_4.isweapon = _ID18380( var_4._ID25633 );
        var_4.isitem = _ID18378( var_4._ID25633 );

        if ( maps\mp\alien\_unk1464::is_chaos_mode() )
            var_4.cost = 0;

        level._ID7668[var_4._ID25633] = var_4;
    }
}

_ID18379( var_0 )
{
    if ( isdefined( level._ID7668 ) && isdefined( level._ID7668[var_0] ) && isdefined( level._ID7668[var_0].isloot ) )
        return level._ID7668[var_0].isloot;
    else
        return getsubstr( var_0, 0, 5 ) == "loot_";
}

_ID18380( var_0 )
{
    if ( isdefined( level._ID7668 ) && isdefined( level._ID7668[var_0] ) && isdefined( level._ID7668[var_0].isweapon ) )
        return level._ID7668[var_0].isweapon;
    else
        return getsubstr( var_0, 0, 7 ) == "weapon_";
}

_ID18378( var_0 )
{
    if ( isdefined( level._ID7668 ) && isdefined( level._ID7668[var_0] ) && isdefined( level._ID7668[var_0].isitem ) )
        return level._ID7668[var_0].isitem;
    else
        return getsubstr( var_0, 0, 5 ) == "item_";
}

item_exist( var_0 )
{
    return isdefined( level._ID7668[var_0] );
}

get_item_desc( var_0 )
{
    return level._ID7668[var_0].desc;
}

get_item_name( var_0 )
{
    return level._ID7668[var_0].name;
}

_ID14585( var_0 )
{
    return level._ID7668[var_0].player_max;
}

give_default( var_0 )
{
    return;
}

_ID6589( var_0 )
{
    return 0;
}

get_func_give( var_0 )
{
    if ( item_exist( var_0 ) )
        return level._ID7668[var_0].func_give;

    var_1 = ::give_default;

    switch ( var_0 )
    {
        case "item_alienpropanetank_mp":
            var_1 = ::_ID15571;
            break;
        default:
            break;
    }

    if ( strtok( var_0, "_" )[0] == "weapon" )
        var_1 = ::_ID15575;

    return var_1;
}

_ID14482( var_0 )
{
    if ( item_exist( var_0 ) )
        return level._ID7668[var_0]._ID13735;

    var_1 = ::_ID6589;

    switch ( var_0 )
    {
        case "item_alienpropanetank_mp":
            var_1 = ::cangive_throwable_weapon;
            break;
        default:
            break;
    }

    if ( strtok( var_0, "_" )[0] == "weapon" )
        var_1 = ::_ID6600;

    return var_1;
}

_ID15575( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = var_0.item_ref;
    var_4 = getsubstr( var_3, 7 );
    var_5 = var_0.data["cost"];

    if ( maps\mp\alien\_perk_utility::perk_getpistoloverkill() == 0 )
        var_6 = 2;
    else
        var_6 = 3;

    if ( isdefined( self._ID37744 ) )
        var_6 += self._ID37744;

    var_7 = maps\mp\alien\_unk1464::getrawbaseweaponname( var_4 );
    var_8 = maps\mp\alien\_unk1464::_ID24101( var_7 );
    var_9 = [];

    if ( !has_weapon_variation( var_4 ) && !maps\mp\alien\_unk1464::has_pistols_only_relic_and_no_deployables() )
    {
        var_10 = _ID14719();

        if ( isdefined( var_10 ) )
        {
            var_11 = self getweaponammoclip( var_10 );
            var_12 = self getweaponammostock( var_10 );
            var_2 = 1;

            if ( maps\mp\alien\_unk1464::is_chaos_mode() )
            {
                var_13 = var_10;
                self takeweapon( var_13 );
            }

            if ( !self._ID16417 && var_10 != "aliensoflam_mp" )
            {
                if ( ( self hasweapon( "aliensoflam_mp" ) || self.hasriotshield || maps\mp\alien\_unk1464::has_special_weapon() ) && self getweaponslistprimaries().size < var_6 + 1 )
                    var_2 = 0;

                if ( self hasweapon( "aliensoflam_mp" ) && self.hasriotshield && self getweaponslistprimaries().size < var_6 + 2 )
                    var_2 = 0;

                if ( isdefined( level._ID37055 ) )
                {
                    var_14 = [[ level._ID37055 ]]( var_6 );

                    if ( isdefined( var_14 ) )
                        var_2 = var_14;
                }

                if ( var_2 )
                    self takeweapon( var_10 );
            }
        }

        if ( isdefined( var_10 ) && maps\mp\_utility::getweaponclass( var_10 ) != "weapon_pistol" && var_2 == 1 )
            var_9 = getweaponattachments( var_10 );

        maps\mp\alien\_persistence::_ID32387( var_5, 0, "weapon", var_4 );

        if ( maps\mp\alien\_unk1464::is_chaos_mode() )
            maps\mp\alien\_chaos::update_weapon_pickup( self, var_4 );
        else if ( !maps\mp\alien\_unk1464::_ID18506( var_1 ) && isdefined( var_10 ) )
            var_4 = maps\mp\alien\_unk1464::return_weapon_with_like_attachments( var_4, var_9 );
        else if ( maps\mp\alien\_unk1464::_ID18506( var_1 ) )
            var_4 = maps\mp\alien\_unk1464::ark_attachment_transfer_to_locker_weapon( var_4, var_9, var_2 );

        self giveweapon( var_4 );
        self switchtoweapon( var_4 );

        if ( !maps\mp\alien\_unk1464::_ID18506( var_1 ) )
            scale_ammo_based_on_nerf( var_4 );

        give_pistol_ammo_if_nerf_active();
        level notify( "new_weapon_purchased",  self  );
    }
    else
    {
        if ( !self hasweapon( var_4 ) )
            var_4 = _ID14842( var_4 );

        if ( maps\mp\alien\_unk1464::has_pistols_only_relic_and_no_deployables() )
            var_4 = maps\mp\alien\_unk1464::get_current_pistol();

        var_15 = weaponmaxammo( var_4 );
        var_16 = maps\mp\alien\_prestige::prestige_getminammo();
        var_17 = int( var_16 * var_15 );
        var_18 = self getammocount( var_4 );

        if ( var_18 < var_17 )
        {
            if ( var_8 )
                return;

            self givemaxammo( var_4 );
            self switchtoweapon( var_4 );
            self setweaponammostock( var_4, var_17 );

            if ( !maps\mp\alien\_unk1464::has_pistols_only_relic_and_no_deployables() )
                give_pistol_ammo_if_nerf_active();
            else
                var_5 = level.pistol_ammo_cost;

            maps\mp\_utility::_ID7495( "ammo_warn" );
            maps\mp\_utility::setlowermessage( "ammo_taken", &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN", 3 );
            maps\mp\alien\_persistence::_ID32387( var_5, 0, "weapon", var_4 );
        }
        else if ( !var_8 )
        {
            maps\mp\_utility::_ID7495( "ammo_warn" );
            maps\mp\_utility::setlowermessage( "ammo_taken", &"ALIEN_COLLECTIBLES_AMMO_MAX", 3 );
        }
    }
}

scale_ammo_based_on_nerf( var_0 )
{
    var_1 = _ID36637::check_for_nerf_min_ammo();

    if ( var_1 != 1.0 )
    {
        var_2 = weaponmaxammo( var_0 );
        self setweaponammostock( var_0, int( var_2 * var_1 ) );
    }
}

give_pistol_ammo_if_nerf_active()
{
    if ( maps\mp\alien\_prestige::prestige_getnodeployables() == 1 )
    {
        var_0 = self getweaponslistprimaries();

        foreach ( var_2 in var_0 )
        {
            var_3 = maps\mp\_utility::getweaponclass( var_2 );

            if ( var_3 == "weapon_pistol" )
            {
                var_4 = weaponmaxammo( var_2 );
                var_5 = int( var_4 * 0.25 );
                var_6 = self getammocount( var_2 );

                if ( var_5 > var_6 )
                    self setweaponammostock( var_2, var_5 );
            }
        }
    }
}

_ID14719()
{
    var_0 = self getweaponslistprimaries();

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
    {
        foreach ( var_2 in var_0 )
        {
            var_3 = maps\mp\_utility::getweaponclass( var_2 );

            switch ( var_3 )
            {
                case "weapon_smg":
                case "weapon_assault":
                case "weapon_sniper":
                case "weapon_dmr":
                case "weapon_lmg":
                case "weapon_shotgun":
                case "weapon_projectile":
                    return var_2;
            }
        }
    }

    if ( maps\mp\alien\_perk_utility::perk_getpistoloverkill() == 0 )
        var_5 = 2;
    else
        var_5 = 3;

    if ( isdefined( self._ID37744 ) )
        var_5 += self._ID37744;

    if ( var_0.size >= var_5 )
    {
        var_6 = self getcurrentweapon();

        if ( weaponinventorytype( var_6 ) == "altmode" )
            var_6 = _ID14840( var_6 );

        if ( isdefined( var_6 ) && weaponinventorytype( var_6 ) == "primary" )
            return var_6;
        else
        {
            var_7 = self getweaponslist( "primary" );

            foreach ( var_2 in var_7 )
            {
                if ( weaponclass( var_2 ) != "item" && weaponclass( var_2 ) != "pistol" && weapontype( var_2 ) != "riotshield" )
                    return var_2;
            }
        }
    }

    return undefined;
}

_ID14840( var_0 )
{
    if ( weaponinventorytype( var_0 ) != "altmode" )
        return var_0;

    return getsubstr( var_0, 4 );
}

_ID6600( var_0 )
{
    var_1 = var_0.item_ref;
    var_2 = getsubstr( var_1, 7 );
    var_3 = self getweaponslistprimaries();
    var_4 = self getcurrentweapon();
    var_5 = maps\mp\_utility::getweaponclass( var_4 );

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
    {
        if ( maps\mp\alien\_chaos::is_weapon_recently_picked_up( self, var_2 ) || maps\mp\alien\_unk1464::has_special_weapon() )
        {
            maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HAS_SPECIALWEAPON", 3 );
            return 0;
        }
        else
            return 1;
    }

    if ( maps\mp\alien\_perk_utility::perk_getpistoloverkill() == 0 )
        var_6 = 2;
    else
        var_6 = 3;

    if ( isdefined( self._ID37744 ) )
        var_6 += self._ID37744;

    if ( maps\mp\alien\_prestige::prestige_getpistolsonly() == 1 )
    {
        if ( maps\mp\alien\_prestige::prestige_getnodeployables() != 1 )
        {
            maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_NERFED", 3 );
            return 0;
        }
    }

    if ( self isswitchingweapon() )
        return 0;

    if ( var_4 == "none" )
    {
        maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HOLDING", 3 );
        return 0;
    }

    if ( isdefined( level._ID37052 ) )
    {
        if ( ![[ level._ID37052 ]]( var_3, var_4, var_5, var_6 ) )
        {
            maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HAS_SPECIALWEAPON", 3 );
            return 0;
        }
    }

    if ( maps\mp\alien\_unk1464::has_special_weapon() )
    {
        maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HAS_SPECIALWEAPON", 3 );
        return 0;
    }

    if ( var_5 == "weapon_pistol" && var_3.size >= var_6 && !self.hasriotshield && !self hasweapon( "aliensoflam_mp" ) )
    {
        maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HAS_SPECIALWEAPON", 3 );
        return 0;
    }

    if ( var_5 == "weapon_pistol" && var_3.size >= var_6 + 1 && self.hasriotshield && !self hasweapon( "aliensoflam_mp" ) )
    {
        maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HAS_SPECIALWEAPON", 3 );
        return 0;
    }

    if ( var_5 == "weapon_pistol" && var_3.size >= var_6 + 1 && self hasweapon( "aliensoflam_mp" ) && !self.hasriotshield )
    {
        maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HAS_SPECIALWEAPON", 3 );
        return 0;
    }

    if ( var_5 == "weapon_pistol" && var_3.size >= var_6 + 2 && self.hasriotshield && self hasweapon( "aliensoflam_mp" ) )
    {
        maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HAS_SPECIALWEAPON", 3 );
        return 0;
    }

    if ( var_4 == "aliensoflam_mp" && var_3.size >= var_6 + 1 && !self._ID16417 )
    {
        maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HAS_SPECIALWEAPON", 3 );
        return 0;
    }

    if ( var_4 == "aliensoflam_mp" && var_3.size >= var_6 + 2 && self._ID16417 )
    {
        maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HAS_SPECIALWEAPON", 3 );
        return 0;
    }

    if ( self._ID16417 && var_3.size >= var_6 + 1 && !self hasweapon( "aliensoflam_mp" ) )
    {
        maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HAS_SPECIALWEAPON", 3 );
        return 0;
    }

    if ( self._ID16417 && var_3.size >= var_6 + 1 && self hasweapon( "aliensoflam_mp" ) )
    {
        maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HAS_SPECIALWEAPON", 3 );
        return 0;
    }

    if ( !maps\mp\alien\_unk1464::_ID18431() )
    {
        if ( maps\mp\alien\_unk1464::has_pistols_only_relic_and_no_deployables() )
            var_7 = maps\mp\alien\_persistence::player_has_enough_currency( level.pistol_ammo_cost );
        else
            var_7 = maps\mp\alien\_persistence::player_has_enough_currency( var_0.data["cost"] );

        if ( !var_7 )
        {
            maps\mp\_utility::_ID7495( "ammo_warn" );
            maps\mp\_utility::setlowermessage( "no_money", &"ALIEN_COLLECTIBLES_NO_MONEY", 3 );
            return 0;
        }

        return 1;
    }
    else
    {
        maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HOLDING", 3 );
        return 0;
    }

    return 0;
}

_ID15571( var_0 )
{
    var_1 = var_0.item_ref;
    var_2 = getsubstr( var_1, 5 );
    maps\mp\_utility::_giveweapon( var_2 );
    self switchtoweapon( var_2 );
    self disableweaponswitch();
    displaythrowmessage();
}

cangive_throwable_weapon( var_0 )
{
    var_1 = var_0.item_ref;
    var_2 = getsubstr( var_1, 5 );

    if ( maps\mp\_utility::_ID18585() || maps\mp\alien\_unk1464::_ID18431() || maps\mp\alien\_unk1464::has_special_weapon() || self getcurrentprimaryweapon() == "aliensoflam_mp" )
    {
        maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HOLDING", 3 );
        return 0;
    }

    if ( !self hasweapon( var_2 ) && !maps\mp\alien\_unk1464::_ID18431() && !maps\mp\alien\_unk1464::has_special_weapon() )
        return 1;
    else
        return 0;
}

_ID36140()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    var_0 = self.pers["team"];

    for (;;)
    {
        self waittill( "grenade_fire",  var_1, var_2  );

        if ( _ID18640( var_2 ) )
            continue;

        var_3 = anglestoforward( self getplayerangles() );
        var_4 = bullettrace( self geteye(), self geteye() + var_3 * 64, 1, self, 0, 0, 1 );
        var_4["position"] = self geteye() + var_3 * 30;

        if ( var_4["fraction"] < 1 )
        {
            if ( var_2 == "alienpropanetank_mp" )
                var_4["position"] = self geteye() + var_3;
        }

        if ( isthrowableitem( var_2 ) )
        {
            self takeweapon( var_2 );
            self enableweaponswitch();
            var_1 delete();
            level thread _ID36141( var_2, var_0, self geteye(), self getplayerangles(), self, var_4 );
        }
    }
}

_ID36141( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    level endon( "game_ended" );
    common_scripts\utility::_ID35582();
    var_6 = level._ID32939[var_0];
    var_7 = anglestoforward( var_3 );
    var_8 = anglestoup( var_3 );
    var_9 = spawn( "script_model", var_5["position"] );
    var_9.angles = vectortoangles( var_8 );
    var_9 setmodel( var_6.model );
    var_9.owner = var_4;
    var_9 endon( "death" );
    add_to_thrown_entity_list( var_9 );
    var_9 thread clean_up_on_death();
    common_scripts\utility::_ID35582();
    var_10 = var_6._ID13474;

    if ( var_5["fraction"] < 1 )
        var_10 = 5;

    var_9 physicslaunchserver( ( 0, 0, 0 ), var_7 * var_10 );
    wait 0.5;
    var_9 thread explodeondamage( 1 );

    if ( var_6.canbepickedup )
    {
        _ID20491( var_9, var_6._ID16999 );
        var_9 thread [[ var_6.pickupfunc ]]( var_0 );
    }

    if ( !isdefined( level.placedims ) || level.placedims.size < 1 )
        return;

    var_11 = 576;

    foreach ( var_13 in level.placedims )
    {
        if ( distancesquared( var_9.origin, var_13.origin ) < var_11 )
            var_9 notify( "damage",  100, var_9.owner  );
    }
}

add_to_thrown_entity_list( var_0 )
{
    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
        maps\mp\alien\_outline_proto::add_to_outline_watch_list( var_0, 0 );

    level.thrown_entities[level.thrown_entities.size] = var_0;
}

clean_up_on_death()
{
    level endon( "game_ended" );
    self waittill( "death" );

    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
        maps\mp\alien\_outline_proto::_ID25902( self );

    level.thrown_entities = common_scripts\utility::array_remove( level.thrown_entities, self );
}

_ID25114( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );

    for (;;)
    {
        self waittill( "trigger",  var_1  );
        var_1 notify( "cancel_watch" );
        var_1 notify( "kill_spendhint" );
        var_1._ID23541 = 1;
        var_1 thread _ID7448();

        if ( !isplayer( var_1 ) || var_1 hasweapon( var_0 ) )
            continue;

        if ( var_1 maps\mp\alien\_unk1464::_ID18431() || var_1 maps\mp\alien\_unk1464::has_special_weapon() )
        {
            var_1 maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HOLDING", 3 );
            continue;
        }

        if ( var_1 maps\mp\_utility::_ID18585() || var_1 getcurrentprimaryweapon() == "aliensoflam_mp" )
        {
            var_1 maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HOLDING", 3 );
            continue;
        }

        break;
    }

    var_1 playlocalsound( "weap_pickup_propanetank_plr" );
    var_1 maps\mp\_utility::_giveweapon( var_0 );
    var_1 switchtoweapon( var_0 );
    var_1 disableweaponswitch();
    var_1 displaythrowmessage();
    self delete();
}

isthrowableitem( var_0 )
{
    return isdefined( level._ID32939[var_0] );
}

displaythrowmessage()
{
    maps\mp\_utility::setlowermessage( "throw_item", &"ALIEN_COLLECTIBLES_THROW_ITEM", 3 );
}

explodeondamage( var_0 )
{
    self endon( "death" );
    self setcandamage( 1 );
    self.maxhealth = 100000;
    self.health = self.maxhealth;
    var_1 = 0;

    for (;;)
    {
        self waittill( "damage",  var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11  );

        if ( var_0 && is_hive_explosion( var_3, var_6 ) )
        {
            var_1 = 1;
            break;
        }

        if ( !isplayer( var_3 ) && !isplayer( var_3.owner ) )
            continue;

        if ( isdefined( var_6 ) && var_6 == "MOD_MELEE" )
            continue;

        break;
    }

    if ( isdefined( var_3 ) && isplayer( var_3 ) )
        self.owner = var_3;
    else if ( isdefined( var_3.owner ) && isplayer( var_3.owner ) )
        self.owner = var_3.owner;

    if ( isdefined( level.recent_propane_explosions ) && level.recent_propane_explosions > 4 )
        playfx( level._ID1644["Propane_explosion_cheapest"], common_scripts\utility::drop_to_ground( self.origin, 32, -500 ) );
    else if ( isdefined( level.recent_propane_explosions ) && level.recent_propane_explosions > 2 )
        playfx( level._ID1644["Propane_explosion_cheap"], common_scripts\utility::drop_to_ground( self.origin, 32, -500 ) );
    else
        playfx( level._ID1644["Propane_explosion"], common_scripts\utility::drop_to_ground( self.origin, 32, -500 ) );

    var_12 = 1000 * self.owner maps\mp\alien\_perk_utility::_ID23441();
    var_13 = 1000 * self.owner maps\mp\alien\_perk_utility::_ID23441();
    var_14 = self.origin + ( 0, 0, 22 );
    var_15 = 256;

    if ( var_1 )
        radiusdamage( var_14, var_15, var_12, var_13, var_3, "MOD_EXPLOSIVE", "alienpropanetank_mp" );
    else
        radiusdamage( var_14, var_15, var_12, var_13, self.owner, "MOD_EXPLOSIVE", "alienpropanetank_mp" );

    self playsound( "grenade_explode_metal" );
    level thread _ID13053( self.owner, level._ID13049, self.origin );
    level thread firecloudsfx( level._ID13049, self.origin );

    if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
        maps\mp\alien\_outline_proto::_ID25902( self );

    self delete();
}

is_hive_explosion( var_0, var_1 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_0.classname ) )
        return 0;

    return var_0.classname == "scriptable" && var_1 == "MOD_EXPLOSIVE";
}

firecloudsfx( var_0, var_1 )
{
    var_2 = spawn( "script_origin", var_1 );
    var_3 = spawn( "script_origin", var_1 );
    wait 0.01;
    var_2 playloopsound( "fire_trap_fire_lp" );
    wait(var_0);
    var_3 playsound( "fire_trap_fire_end_lp" );
    wait 0.5;
    var_2 stoploopsound();
    wait 5;
    var_2 delete();
    var_3 delete();
}

_ID13053( var_0, var_1, var_2 )
{
    var_3 = level._ID13055;
    var_4 = level.firecloudheight;
    var_5 = level.firecloudtickdamage * var_0 _ID13729();
    var_6 = level.firecloudlingertime;
    var_7 = level._ID13054;
    var_8 = level._ID13051 * var_0 _ID13729();

    if ( !isdefined( level.recent_propane_explosions ) )
        level.recent_propane_explosions = 0;

    level.recent_propane_explosions++;
    var_9 = spawn( "trigger_radius", var_2, 0, var_3, var_4 );
    var_9.owner = var_0;
    var_10 = spawnfx( level._ID1644["Fire_Cloud"], var_2 );
    triggerfx( var_10 );
    var_11 = 0.0;
    var_12 = 0.25;
    var_13 = 1;
    var_14 = 0;
    wait(var_13);
    var_11 += var_13;
    var_1 *= var_0 maps\mp\alien\_perk_utility::_ID23442();
    level thread maps\mp\alien\_unk1464::_ID20640( var_2, var_3, var_1 );

    while ( var_11 < var_1 )
    {
        foreach ( var_16 in level.agentarray )
        {
            if ( isdefined( var_16.isactive ) && var_16.isactive && isalive( var_16 ) && var_16 istouching( var_9 ) && ( !isdefined( var_16.burning ) || !var_16.burning ) )
                var_16 thread fire_cloud_burn_alien( var_5, var_0, var_6, var_9 );
        }

        foreach ( var_19 in level.players )
        {
            if ( isalive( var_19 ) && var_19 istouching( var_9 ) && ( !isdefined( var_19.burning ) || !var_19.burning ) )
                var_19 thread fire_cloud_burn_player( var_7 );
        }

        if ( isdefined( level.thrown_entities ) )
        {
            foreach ( var_22 in level.thrown_entities )
            {
                if ( isdefined( var_22 ) && var_22 istouching( var_9 ) )
                    var_22 dodamage( var_7, var_2, var_0 );
            }
        }

        if ( isdefined( level._ID5372 ) )
        {
            foreach ( var_25 in level._ID5372 )
            {
                var_26 = maps\mp\alien\_spawnlogic::_ID14322( var_25 );

                if ( !isdefined( var_26 ) )
                    continue;

                var_27 = var_26.attackable_ent;

                if ( isdefined( var_27 ) && distance( var_27.origin, var_2 ) <= var_3 * 0.8 )
                {
                    if ( isdefined( var_27.health ) && var_27.health > 0 && ( !isdefined( var_27.burn_mitigation ) || !var_27.burn_mitigation ) )
                    {
                        var_27 thread burn_mitigation( 0.2 );
                        var_27 dodamage( var_8, var_2, var_0 );
                    }
                }
            }
        }

        wait(var_12);
        var_11 += var_12;
        var_14 += 1;
    }

    level.recent_propane_explosions = int( max( 0, level.recent_propane_explosions - 1 ) );
    var_9 delete();
    var_10 delete();
}

burn_mitigation( var_0 )
{
    self notify( "burn_mitigating" );
    self endon( "burn_mitigating" );
    self endon( "death" );
    self.burn_mitigation = 1;
    wait(var_0);
    self.burn_mitigation = 0;
}

_ID13729()
{
    return maps\mp\alien\_perk_utility::_ID23441() * level.alien_health_per_player_scalar[level.players.size];
}

fire_cloud_burn_player( var_0 )
{
    self notify( "fire_cloud_burning" );
    self endon( "fire_cloud_burning" );
    self endon( "last_stand" );
    self.burning = 1;
    thread _ID26080();

    if ( !maps\mp\alien\_perk_utility::_ID16358( "perk_rigger", [ 0, 1, 2, 3, 4 ] ) )
        self dodamage( var_0, self.origin );

    wait 1;
    self.burning = undefined;
}

fire_cloud_burn_alien( var_0, var_1, var_2, var_3 )
{
    self notify( "fire_cloud_burning" );
    self endon( "fire_cloud_burning" );
    self endon( "death" );

    if ( !isdefined( var_2 ) )
        var_2 = 6;

    self.burning = 1;
    thread _ID26080();
    maps\mp\alien\_alien_fx::alien_fire_on();
    var_4 = 0;

    while ( var_4 < var_2 )
    {
        var_1.burning_victim = 1;

        if ( isdefined( var_3 ) )
            self dodamage( var_0, self.origin, var_1, var_3 );
        else
            self dodamage( var_0, self.origin, var_1 );

        var_4 += 1;
        wait 1;
    }

    maps\mp\alien\_alien_fx::alien_fire_off();
    self.burning = undefined;
}

_ID26080()
{
    common_scripts\utility::_ID35626( "death", "last_stand" );
    self.burning = undefined;
}

_ID36668()
{
    var_0 = maps\mp\alien\_unk1464::_ID37267();
    _ID25914( var_0 );
    _ID25953( var_0 );

    if ( isdefined( level._ID37611 ) )
        [[ level._ID37611 ]]( var_0 );

    maps\mp\alien\_unk1464::_ID37441();
    var_1 = maps\mp\alien\_unk1464::_ID37267();
    _ID30691( var_1 );

    if ( isdefined( level._ID37177 ) )
        [[ level._ID37177 ]]( var_1 );
}

_ID25953( var_0 )
{
    foreach ( var_2 in level.thrown_entities )
    {
        var_3 = var_2 _ID14530();

        if ( common_scripts\utility::array_contains( var_3, var_0 ) )
        {
            level.thrown_entities = common_scripts\utility::array_remove( level.thrown_entities, var_2 );

            if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
                maps\mp\alien\_outline_proto::_ID25902( var_2 );

            var_2 delete();
        }
    }
}

_ID18640( var_0 )
{
    var_1 = weaponclass( var_0 );
    var_2 = weaponinventorytype( var_0 );

    if ( var_1 != "grenade" )
        return 0;

    if ( var_2 != "offhand" )
        return 0;

    return 1;
}

has_weapon_variation( var_0 )
{
    var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        var_4 = maps\mp\alien\_persistence::_ID14308( var_3 );

        if ( issubstr( var_0, var_4 ) )
            return 1;
    }

    return 0;
}

_ID14842( var_0 )
{
    var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        var_4 = maps\mp\alien\_persistence::_ID14308( var_3 );

        if ( issubstr( var_0, var_4 ) )
            return var_3;
    }

    return undefined;
}

check_for_player_near_weapon()
{
    self endon( "disconnect" );
    var_0 = 21025;

    for (;;)
    {
        if ( isdefined( self._ID18011 ) && self._ID18011 || isdefined( self.usingremote ) || maps\mp\alien\_unk1464::_ID18506( self._ID18582 ) )
        {
            wait 0.25;
            continue;
        }

        foreach ( var_3, var_2 in level._ID23099 )
        {
            if ( isdefined( var_2 ) && distancesquared( var_2.origin, self.origin ) < var_0 )
            {
                if ( !isdefined( var_2.targetname ) )
                    maps\mp\_utility::setlowermessage( "ammo_warn", &"ALIENS_PRESTIGE_PISTOLS_ONLY_AMMO_DIST", undefined, 10 );

                while ( player_should_see_ammo_message( var_2, var_0, 0 ) )
                    wait 0.25;
            }

            maps\mp\_utility::_ID7495( "ammo_warn" );
        }

        wait 1;
    }
}

player_should_see_ammo_message( var_0, var_1, var_2 )
{
    if ( distancesquared( var_0.origin, self.origin ) > var_1 )
        return 0;

    if ( self._ID18011 )
        return 0;

    if ( isdefined( self.usingremote ) )
        return 0;

    if ( maps\mp\alien\_unk1464::_ID18506( var_2 ) )
        return 1;
    else if ( maps\mp\alien\_unk1464::_ID18506( self._ID18582 ) )
        return 0;

    return 1;
}
