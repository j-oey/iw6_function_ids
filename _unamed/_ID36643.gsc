// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID37636()
{
    setdvar( "scr_alien_locker_pillage", 1 );
    level._ID37624 = ::_ID36919;
    level._ID37282 = ::_ID37283;
    level._ID37284 = ::_ID37291;
    level._ID37625 = ::_ID37126;

    if ( !isdefined( level._ID37057 ) )
        level._ID37057 = ::_ID37637;

    if ( !isdefined( level._ID37614 ) )
        level._ID37614 = ::_ID37080;

    level._ID37629 = ::_ID37628;
}

_ID37637()
{
    level.pillageinfo._ID37630 = "vehicle_pickup_keys";
    level.pillageinfo._ID37623 = 0;
    level.pillageinfo._ID37626 = 0;
    level.pillageinfo._ID37631 = 0;
    level.pillageinfo._ID37633 = 0;
    level.pillageinfo._ID37639 = 0;
    level.pillageinfo._ID37634 = 0;
    level.pillageinfo._ID37638 = 0;
    level.pillageinfo._ID37640 = 0;
    level.pillageinfo._ID37632 = 100;
    var_0 = common_scripts\utility::_ID15386( "pillage_area", "targetname" );

    foreach ( var_8, var_2 in var_0 )
    {
        if ( !isdefined( level._ID23564[var_8] ) )
            level._ID23564[var_8] = [];

        level._ID23564[var_8]["locker"] = [];
        var_3 = common_scripts\utility::_ID15386( var_2.target, "targetname" );

        foreach ( var_5 in var_3 )
        {
            if ( isdefined( var_5.script_noteworthy ) )
            {
                var_6 = strtok( var_5.script_noteworthy, "," );
                var_5._ID23569 = var_6[0];

                if ( isdefined( var_6[1] ) )
                    var_5.script_model = var_6[1];

                switch ( var_5._ID23569 )
                {
                    case "locker":
                        level._ID23564[var_8]["locker"][level._ID23564[var_8]["locker"].size] = var_5;
                        var_5._ID37534 = 1;
                        var_5._ID37127 = ::_ID37126;
                        break;
                }
            }
        }
    }

    foreach ( var_8, var_2 in level._ID23564 )
    {
        level maps\mp\alien\_pillage::_ID8357( level._ID23564[var_8]["locker"] );
        level _ID37950( level._ID23564[var_8]["locker"] );
    }

    maps\mp\alien\_pillage::build_pillageitem_arrays( "locker" );
    _ID37032();
}

debug_locker_weapons()
{
    wait 10;

    foreach ( var_1 in level._ID37664 )
    {

    }

    foreach ( var_1 in level.max_weapon_list_xmags )
    {

    }
}

_ID37950( var_0 )
{
    foreach ( var_3, var_2 in var_0 )
        var_2.pillage_trigger sethintstring( &"ALIEN_PILLAGE_LOCKER_OPEN_LOCKER" );
}

_ID37080( var_0, var_1, var_2 )
{
    switch ( var_1 )
    {
        case "searched":
            if ( isdefined( var_2 ) )
            {
                switch ( var_2.type )
                {
                    case "locker_key":
                        var_3 = maps\mp\alien\_pillage::get_hintstring_for_pillaged_item( var_2.type );
                        var_0 thread maps\mp\alien\_pillage::_ID29942( var_3 );
                        self.pillage_trigger setmodel( level.pillageinfo._ID37630 );
                        var_3 = maps\mp\alien\_pillage::get_hintstring_for_item_pickup( var_2.type );
                        self.pillage_trigger sethintstring( var_3 );
                        self.pillage_trigger makeusable();
                        self.pillageinfo.type = "locker_key";
                        self.pillageinfo.ammo = 1;
                        level thread maps\mp\alien\_music_and_dialog::_ID24684( var_0 );
                        break;
                    case "locker_weapon":
                        var_3 = maps\mp\alien\_pillage::get_hintstring_for_pillaged_item( var_2.type );
                        var_0 thread maps\mp\alien\_pillage::_ID29942( var_3 );

                        if ( var_0 maps\mp\alien\_persistence::is_upgrade_enabled( "master_scavenger_upgrade" ) )
                            var_4 = common_scripts\utility::array_combine( level._ID37664, level.max_weapon_list_xmags );
                        else
                            var_4 = level._ID37664;

                        var_5 = common_scripts\utility::_ID25350( var_4 );
                        var_6 = 0;

                        while ( isdefined( var_0.last_locker_weapon ) && var_0.last_locker_weapon == var_5.model )
                        {
                            var_5 = common_scripts\utility::_ID25350( var_4 );
                            var_6++;

                            if ( var_6 % 10 == 0 )
                                break;
                        }

                        var_0.last_locker_weapon = var_5.model;
                        self.pillage_trigger setmodel( var_5.model );
                        var_3 = maps\mp\alien\_pillage::get_hintstring_for_item_pickup( var_5.model );
                        self.pillage_trigger sethintstring( var_3 );
                        self.pillage_trigger makeusable();
                        self.pillageinfo.type = "locker_weapon";
                        self.pillageinfo.ammo = 1;
                        self.pillageinfo._ID38301 = var_5;
                        self.pillageinfo._ID38302 = var_5._ID38302;
                        maps\mp\_utility::_ID9519( 1.0, maps\mp\alien\_music_and_dialog::_ID24684, var_0 );
                        break;
                }
            }

            break;
        case "pick_up":
            if ( isdefined( self.pillageinfo ) )
            {
                switch ( self.pillageinfo.type )
                {
                    case "locker_key":
                        var_0 _ID38167( self.pillage_trigger );
                        break;
                    case "locker_weapon":
                        var_7 = var_0 _ID38166( self );

                        if ( var_7 )
                            maps\mp\alien\_pillage::_ID9586();

                        break;
                }
            }

            break;
    }
}

_ID38166( var_0 )
{
    var_1 = var_0.pillageinfo._ID38302;
    var_2 = spawnstruct();
    var_2.data["cost"] = 0;
    var_2.item_ref = "weapon_" + var_1;

    if ( maps\mp\alien\_collectibles::_ID6600( var_2 ) )
    {
        var_3 = 0;
        var_4 = 0;
        var_5 = 0;

        if ( maps\mp\alien\_collectibles::has_weapon_variation( var_1 ) )
        {
            var_6 = maps\mp\alien\_collectibles::_ID14842( var_1 );

            if ( isdefined( var_6 ) )
            {
                if ( isdefined( level.locker_ark_check_func ) )
                    var_2.item_ref = [[ level.locker_ark_check_func ]]( var_6, var_1 );

                var_4 = self getweaponammoclip( var_6 );
                var_5 = self getweaponammostock( var_6 );
                self takeweapon( var_6 );
                var_7 = maps\mp\alien\_unk1464::getrawbaseweaponname( var_6 );

                if ( maps\mp\alien\_unk1464::_ID24101( var_7 ) )
                {
                    if ( isdefined( self._ID31873[var_7] ) )
                        var_3 = 1;
                }
            }
        }

        self.locker_weapon = undefined;
        maps\mp\alien\_collectibles::_ID15575( var_2, 1 );
        thread give_player_max_ammo( var_3, var_4, var_5 );
        return 1;
    }

    return 0;
}

give_player_max_ammo( var_0, var_1, var_2 )
{
    self waittill( "weapon_change" );
    var_3 = self.locker_weapon;
    var_4 = weaponclipsize( var_3 );
    var_5 = maps\mp\alien\_unk1464::return_nerf_scaled_ammo( var_3 );

    if ( isdefined( var_3 ) && var_0 )
    {
        var_6 = maps\mp\alien\_unk1464::getrawbaseweaponname( var_3 );
        self._ID31873[var_6]._ID3346 = var_5;
        self._ID31873[var_6].clipammo = var_4;
        self setweaponammoclip( var_3, var_1 );
        self setweaponammostock( var_3, var_2 );
    }
    else
    {
        self setweaponammoclip( var_3, var_4 );
        self setweaponammostock( var_3, var_5 );
    }
}

_ID38167( var_0 )
{
    if ( isdefined( self._ID37627 ) )
        maps\mp\_utility::setlowermessage( "max_leash", &"ALIEN_PILLAGE_LOCKER_LOCKER_KEY_MAX", 3 );
    else
    {
        self._ID37627 = 1;
        self playlocalsound( "plr_keys_pckup" );
        self setclientomnvar( "ui_alien_locker_key", 1 );

        if ( maps\mp\alien\_unk1464::alien_mode_has( "outline" ) )
            maps\mp\alien\_outline_proto::_ID25901( var_0 );

        var_0 delete();
    }
}

_ID36919( var_0 )
{
    if ( !isdefined( level._ID23581 ) )
        level._ID23581 = [];

    if ( !isdefined( level._ID23581[var_0] ) )
        level._ID23581[var_0] = [];

    switch ( var_0 )
    {
        case "easy":
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "locker_key", level.pillageinfo._ID37137 );
            break;
        case "medium":
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "locker_key", level.pillageinfo._ID37672 );
            break;
        case "hard":
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "locker_key", level.pillageinfo._ID37402 );
            break;
        case "locker":
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "crafting", level.pillageinfo._ID37004 );
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "attachment", level.pillageinfo._ID37623 );
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "soflam", level.pillageinfo._ID37638 );
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "explosive", level.pillageinfo._ID37626 );
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "maxammo", level.pillageinfo._ID37633 );
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "money", level.pillageinfo._ID37634 );
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "pet_leash", level.pillageinfo._ID37631 );
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "trophy", level.pillageinfo._ID37640 );
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "specialammo", level.pillageinfo._ID37639 );
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "locker_weapon", level.pillageinfo._ID37632 );
            break;
    }
}

_ID37628( var_0 )
{
    if ( isdefined( self._ID37534 ) && self._ID37534 && ( !isdefined( var_0._ID37627 ) || !var_0._ID37627 ) )
    {
        var_0 maps\mp\_utility::setlowermessage( "need_key", &"ALIEN_PILLAGE_LOCKER_NEED_LOCKER_KEY", 3 );
        return 1;
    }

    return 0;
}

_ID37291( var_0 )
{
    var_0 = "" + var_0;

    switch ( var_0 )
    {
        case "locker_key":
            return &"ALIEN_PILLAGE_LOCKER_FOUND_LOCKER_KEY";
        case "locker_weapon":
            return &"ALIEN_PILLAGE_LOCKER_FOUND_LOCKER_WEAPON";
    }
}

_ID37283( var_0 )
{
    var_0 = "" + var_0;

    switch ( var_0 )
    {
        case "locker_key":
            return &"ALIEN_PILLAGE_LOCKER_PICKUP_LOCKER_KEY";
        case "locker_weapon":
            return &"ALIEN_PILLAGE_LOCKER_PICKUP_LOCKER_WEAPON";
    }

    if ( isdefined( level.level_locker_weapon_pickup_string_func ) )
        return [[ level.level_locker_weapon_pickup_string_func ]]( var_0 );
}

_ID37126( var_0 )
{
    if ( !isdefined( self._ID37760 ) )
    {
        var_1 = spawn( "script_model", self.origin );
        var_1.angles = self.angles;

        if ( level.script == "mp_alien_dlc3" )
        {
            var_1 setmodel( "com_plasticcase_bomb_open" );
            var_0 playlocalsound( "ammo_crate_use" );
        }
        else if ( level.script == "mp_alien_last" )
        {
            var_1 setmodel( "dct_crate_locker_open" );
            var_0 playlocalsound( "ammo_crate_use" );
        }
        else
        {
            var_1 setmodel( "armory_weapon_chest_open" );
            var_0 playlocalsound( "plr_locker_open" );
        }

        self._ID37760 = var_1;
        self._ID37635 = self.pillage_trigger.origin;
        self._ID37622 = self.pillage_trigger.angles;
    }

    if ( self.pillage_trigger.model != "tag_origin" )
    {
        if ( isdefined( level.pillage_locker_offset_override_func ) )
            self [[ level.pillage_locker_offset_override_func ]]();
        else
            offset_locker_trigger_model();
    }

    var_0._ID37627 = undefined;
    self.pillage_trigger._ID37534 = undefined;
    var_0 setclientomnvar( "ui_alien_locker_key", 0 );
}

offset_locker_trigger_model()
{
    if ( isdefined( self._ID37635 ) )
        self.pillage_trigger.origin = self._ID37635;

    if ( isdefined( self._ID37622 ) )
        self.pillage_trigger.angles = self._ID37622;

    var_0 = ( 0, 0, 20 );
    var_1 = ( 0, 0, 6 );
    var_2 = ( 0, 0, 0 );
    var_3 = ( 0, 0, 6 );
    var_4 = ( 0, 0, 0 );
    var_5 = getgroundposition( self.pillage_trigger.origin + var_0, 2 );

    switch ( self.pillage_trigger.model )
    {
        case "weapon_baseweapon_clip":
            var_3 = ( 0, 0, 4 );
            break;
        case "mp_trophy_system_folded_iw6":
            var_3 = ( 3, -21, 38 );
            var_4 = ( 277.5, 180, -144 );
            break;
        case "weapon_scavenger_grenadebag":
            var_3 = ( 0, 0, 6 );
            break;
        case "weapon_soflam":
            var_3 = ( 8, -6, 8 );
            break;
        case "mil_ammo_case_1_open":
            var_3 = ( 0, -16, 0 );
            break;
        case "weapon_rm_22":
            self.pillage_trigger hidepart( "tag_barrel_sniper", "weapon_rm_22" );
        case "weapon_kac_chainsaw":
        case "weapon_tar21":
        case "weapon_dragunov_svu":
        case "weapon_g28":
        case "weapon_ak12":
        case "weapon_kriss_v":
        case "weapon_vepr":
        case "weapon_mts_255":
        case "weapon_vks":
        case "weapon_usr":
        case "weapon_l115a3":
        case "weapon_m27":
        case "weapon_cz_805_bren":
        case "weapon_imbel_ia2":
        case "weapon_world_axe":
        case "weapon_fabarm_fp6":
        case "weapon_pp19_bizon_iw6":
            var_3 = ( -5, 0, 24 );
            var_4 = ( 277.5, 180, -144 );
            break;
        case "weapon_maul":
            var_3 = ( -5, 0, 25 );
            var_4 = ( 277.5, 180, -144 );
            break;
        case "weapon_honeybadger":
            var_3 = ( -5, 0, 21 );
            var_4 = ( 277.5, 180, -144 );
            break;
        case "weapon_arx_160":
        case "weapon_lsat_iw6":
        case "weapon_cbj_ms_iw6":
        case "weapon_evopro":
            var_3 = ( -5, 0, 22 );
            var_4 = ( 277.5, 180, -144 );
            break;
        case "weapon_canister_bomb":
        case "weapon_knife_iw6":
        case "mil_emergency_flare_mp":
            var_3 = var_1;
            var_4 = var_2;
            break;
    }

    var_6 = self.pillage_trigger.origin;
    var_7 = self.pillage_trigger.angles;
    var_8 = self.pillage_trigger.origin;
    var_9 = ( 0, 0, 0 );
    var_10 = self.pillage_trigger.origin + var_3;
    var_11 = var_4;
    var_12 = transformmove( var_6, var_7, var_8, var_9, var_10, var_11 );
    var_13 = var_12["origin"] - var_5;
    var_4 = var_12["angles"];
    self.pillage_trigger.origin = var_5 + var_13;
    self.pillage_trigger.angles = var_4;
}

_ID37032()
{
    level._ID37664 = [];
    level.max_weapon_list_xmags = [];
    var_0 = [];
    var_1 = level._ID7668;

    foreach ( var_4, var_3 in var_1 )
    {
        if ( var_3.isweapon )
            var_0[var_4] = var_3;
    }

    var_5 = [];

    foreach ( var_3 in var_0 )
    {
        var_7 = var_3._ID25633;

        if ( issubstr( var_3._ID25633, "honey" ) )
            continue;

        if ( level.script == "mp_alien_beacon" )
        {
            if ( issubstr( var_3._ID25633, "g28" ) || issubstr( var_3._ID25633, "svu" ) )
                continue;
        }

        var_7 = getsubstr( var_7, 7 );

        if ( _ID37526( var_3._ID25633 ) )
            var_8 = var_7;
        else
            var_8 = getweaponbasename( var_7 );

        var_9 = maps\mp\_utility::getweaponclass( var_8 );
        var_10 = [];
        var_11 = [];
        var_12 = [];
        var_13 = [];
        var_14 = maps\mp\alien\_pillage::get_possible_attachments_by_weaponclass( var_9, var_8 );

        if ( !isdefined( var_14 ) || var_14.size < 3 )
            continue;

        if ( issubstr( var_3._ID25633, "aliendlc23" ) )
        {
            if ( level.script == "mp_alien_dlc3" || level.script == "mp_alien_last" )
                var_8 = "iw6_arkaliendlc23_mp";
            else
                var_8 = "iw6_aliendlc23_mp";

            var_14 = common_scripts\utility::add_to_array( var_14, "dlcweap02scope" );
        }

        foreach ( var_16 in var_14 )
        {
            switch ( var_16 )
            {
                case "dlcweap02scope":
                case "reflex":
                case "eotech":
                case "acog":
                    var_10[var_10.size] = var_16;
                    continue;
                case "grip":
                    var_11[var_11.size] = var_16;
                    continue;
                case "barrelrange":
                    var_12[var_12.size] = var_16;
                    continue;
                case "rof":
                case "xmags":
                    var_13[var_13.size] = var_16;
                    continue;
                default:
                    continue;
            }
        }

        var_18 = [];

        if ( var_10.size > 0 )
            var_18[0] = var_10;
        else
            var_18[var_18.size] = [ "none" ];

        if ( var_11.size > 0 )
            var_18[1] = var_11;
        else
            var_18[var_18.size] = [ "none" ];

        if ( var_12.size > 0 )
            var_18[2] = var_12;
        else
            var_18[var_18.size] = [ "none" ];

        if ( var_13.size > 0 )
            var_18[3] = var_13;
        else
            var_18[var_18.size] = [ "none" ];

        var_3 get_rest_of_attachments_brute_force( var_8, var_18 );
    }
}

_ID37646( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = self;
    var_6 = maps\mp\_utility::_ID31978( var_0, "_mp" );
    var_7 = maps\mp\alien\_unk1464::buildalienweaponname( var_6, var_1, var_2, var_3, var_4 );

    if ( isdefined( var_7 ) )
    {
        var_8 = spawnstruct();
        var_8._ID38302 = var_7;
        var_8.model = var_5.model;

        if ( !isdefined( var_4 ) || var_4 != "xmags" )
            level._ID37664[level._ID37664.size] = var_8;
        else
            level.max_weapon_list_xmags[level.max_weapon_list_xmags.size] = var_8;
    }
}

get_rest_of_attachments_brute_force( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in var_1[0] )
    {
        var_2[0] = var_4;

        foreach ( var_4 in var_1[1] )
        {
            var_2[1] = var_4;

            foreach ( var_4 in var_1[2] )
            {
                var_2[2] = var_4;

                foreach ( var_4 in var_1[3] )
                {
                    var_2[3] = var_4;
                    _ID37646( var_0, var_2[0], var_2[1], var_2[2], var_2[3] );
                }
            }
        }
    }
}

_ID37292()
{
    var_0 = common_scripts\utility::_ID25350( level._ID37664 );
    return var_0;
}

_ID37526( var_0 )
{
    if ( issubstr( var_0, "aliendlc" ) )
        return 1;

    if ( issubstr( var_0, "alienDLC" ) )
        return 1;

    return 0;
}

_ID37522( var_0 )
{
    switch ( var_0 )
    {
        case "weapon_iw6_aliendlc12_mp":
        case "iw6_aliendlc12_mp":
        case "weapon_iw6_alienDLC12_mp":
        case "iw6_alienDLC12_mp":
        case "weapon_alienaxe_mp":
        case "alienaxe_mp":
        case "weapon_iw6_aliendlc13_mp":
        case "iw6_aliendlc13_mp":
        case "weapon_iw6_alienDLC13_mp":
        case "iw6_alienDLC13_mp":
            return 1;
        default:
            break;
    }

    return 0;
}
