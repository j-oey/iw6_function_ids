// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

attachmentgroup( var_0 )
{
    if ( maps\mp\_utility::_ID18363() )
    {
        return tablelookup( "mp/alien/alien_attachmentTable.csv", 4, var_0, 2 );
        return;
    }

    return tablelookup( "mp/attachmentTable.csv", 4, var_0, 2 );
    return;
}

_ID17631()
{
    level._ID27332 = 1;
    level._ID27333 = 1;
    level._ID20752 = max( maps\mp\_utility::_ID15069( "scr_maxPerPlayerExplosives", 2 ), 1 );
    level._ID26335 = maps\mp\_utility::_ID15069( "scr_riotShieldXPBullets", 15 );
    createthreatbiasgroup( "DogsDontAttack" );
    createthreatbiasgroup( "Dogs" );
    setignoremegroup( "DogsDontAttack", "Dogs" );

    switch ( maps\mp\_utility::_ID15069( "perk_scavengerMode", 0 ) )
    {
        case 1:
            level._ID27332 = 0;
            break;
        case 2:
            level._ID27333 = 0;
            break;
        case 3:
            level._ID27332 = 0;
            level._ID27333 = 0;
            break;
    }

    var_0 = getdvar( "g_gametype" );
    var_1 = maps\mp\_utility::getattachmentlistbasenames();
    var_1 = common_scripts\utility::alphabetize( var_1 );
    var_2 = 149;
    level._ID36267 = [];
    level.weaponattachments = [];
    var_3 = "mp/statstable.csv";

    if ( maps\mp\_utility::_ID18363() )
        var_3 = "mp/alien/mode_string_tables/alien_statstable.csv";

    for ( var_4 = 0; var_4 <= var_2; var_4++ )
    {
        var_5 = tablelookup( var_3, 0, var_4, 4 );

        if ( var_5 == "" )
            continue;

        if ( !issubstr( tablelookup( var_3, 0, var_4, 2 ), "weapon_" ) )
            continue;

        if ( issubstr( var_5, "iw5" ) || issubstr( var_5, "iw6" ) )
        {
            var_6 = strtok( var_5, "_" );
            var_5 = var_6[0] + "_" + var_6[1] + "_mp";
            level._ID36267[level._ID36267.size] = var_5;
            continue;
        }
        else
            level._ID36267[level._ID36267.size] = var_5 + "_mp";

        var_7 = [];

        for ( var_8 = 0; var_8 < 10; var_8++ )
        {
            if ( var_0 == "aliens" )
                var_9 = tablelookup( "mp/alien/mode_string_tables/alien_statstable.csv", 0, var_4, var_8 + 11 );
            else
                var_9 = maps\mp\_utility::getweaponattachmentfromstats( var_5, var_8 );

            if ( var_9 == "" )
                break;

            var_7[var_9] = 1;
        }

        var_10 = [];

        foreach ( var_9 in var_1 )
        {
            if ( !isdefined( var_7[var_9] ) )
                continue;

            level._ID36267[level._ID36267.size] = var_5 + "_" + var_9 + "_mp";
            var_10[var_10.size] = var_9;
        }

        var_13 = [];

        for ( var_14 = 0; var_14 < var_10.size - 1; var_14++ )
        {
            var_15 = tablelookuprownum( "mp/attachmentCombos.csv", 0, var_10[var_14] );

            for ( var_16 = var_14 + 1; var_16 < var_10.size; var_16++ )
            {
                if ( tablelookup( "mp/attachmentCombos.csv", 0, var_10[var_16], var_15 ) == "no" )
                    continue;

                var_13[var_13.size] = var_10[var_14] + "_" + var_10[var_16];
            }
        }

        foreach ( var_18 in var_13 )
            level._ID36267[level._ID36267.size] = var_5 + "_" + var_18 + "_mp";
    }

    foreach ( var_21 in level._ID36267 )
        precacheitem( var_21 );

    thread maps\mp\_flashgrenades::_ID20445();
    thread maps\mp\_entityheadicons::_ID17631();
    thread maps\mp\_empgrenade::_ID17631();
    initbombsquaddata();
    maps\mp\_utility::_ID6229();
    maps\mp\_utility::buildweaponperkmap();
    level._ID1644["weap_blink_friend"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_detonator_blink_cyan" );
    level._ID1644["weap_blink_enemy"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_detonator_blink_orange" );
    level._ID1644["emp_stun"] = loadfx( "vfx/gameplay/mp/equipment/vfx_emp_grenade" );
    level._ID1644["equipment_explode_big"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_ims_explosion" );
    level._ID1644["equipment_smoke"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_sg_damage_blacksmoke" );
    level._ID1644["equipment_sparks"] = loadfx( "vfx/gameplay/mp/killstreaks/vfx_sentry_gun_explosion" );
    level._ID36259 = [];

    if ( !isdefined( level._ID36261 ) )
        level._ID36261 = ::dropweaponfordeath;

    var_24 = 70;
    level._ID7335 = cos( var_24 );
    level._ID7337 = 20;
    level._ID7336 = 0.75;
    level.claymoredetonateradius = 192;
    level._ID21066 = 0.3;
    level.minedetectionradius = 100;
    level.minedetectionheight = 20;
    level.minedamageradius = 256;
    level.minedamagemin = 70;
    level._ID21061 = 210;
    level._ID21059 = 46;
    level.mineselfdestructtime = 120;
    level._ID21052 = loadfx( "fx/impacts/bouncing_betty_launch_dirt" );
    level.mine_explode = loadfx( "fx/explosions/bouncing_betty_explosion" );
    var_25 = spawnstruct();
    var_25.model = "projectile_bouncing_betty_grenade";
    var_25.bombsquadmodel = "projectile_bouncing_betty_grenade_bombsquad";
    var_25.mine_beacon["enemy"] = loadfx( "fx/misc/light_c4_blink" );
    var_25.mine_beacon["friendly"] = loadfx( "fx/misc/light_mine_blink_friendly" );
    var_25.mine_spin = loadfx( "fx/dust/bouncing_betty_swirl" );
    var_25.armtime = 2;
    var_25.ontriggeredsfx = "mine_betty_click";
    var_25._ID22859 = "mine_betty_spin";
    var_25._ID22837 = "grenade_explode_metal";
    var_25._ID19710 = 64;
    var_25.launchtime = 0.65;
    var_25._ID22914 = ::_ID21057;
    var_25._ID16454 = 20;
    level._ID36259["bouncingbetty_mp"] = var_25;
    level._ID36259["alienbetty_mp"] = var_25;
    var_25 = spawnstruct();
    var_25.model = "weapon_motion_sensor";
    var_25.bombsquadmodel = "weapon_motion_sensor_bombsquad";
    var_25.mine_beacon["enemy"] = common_scripts\utility::_ID15033( "weap_blink_enemy" );
    var_25.mine_beacon["friendly"] = common_scripts\utility::_ID15033( "weap_blink_friend" );
    var_25.mine_spin = loadfx( "fx/dust/bouncing_betty_swirl" );
    var_25.armtime = 2;
    var_25.ontriggeredsfx = "motion_click";
    var_25._ID22914 = ::_ID21080;
    var_25._ID22859 = "motion_spin";
    var_25._ID19717 = level._ID21052;
    var_25._ID19710 = 64;
    var_25.launchtime = 0.65;
    var_25._ID22837 = "motion_explode_default";
    var_25._ID22838 = loadfx( "vfx/gameplay/mp/equipment/vfx_motionsensor_exp" );
    var_25._ID16454 = 25;
    var_25.markedduration = 4.0;
    level._ID36259["motion_sensor_mp"] = var_25;
    var_25 = spawnstruct();
    var_25.armingdelay = 1.5;
    var_25.detectionradius = 232;
    var_25._ID9937 = 512;
    var_25.detectiongraceperiod = 1;
    var_25._ID16454 = 20;
    var_25._ID19217 = 12;
    level._ID36259["proximity_explosive_mp"] = var_25;
    var_25 = spawnstruct();
    var_26 = 800;
    var_27 = 200;
    var_25._ID25300 = var_26 * var_26;
    var_25.radius_min_sq = var_27 * var_27;
    var_25._ID22838 = loadfx( "vfx/gameplay/mp/equipment/vfx_flashbang" );
    var_25._ID22837 = "flashbang_explode_default";
    var_25._ID35228 = 72;
    level._ID36259["flash_grenade_mp"] = var_25;
    level._ID9515 = 3.0;
    level._ID28095 = loadfx( "fx/muzzleflashes/shotgunflash" );
    level.stingerfxid = loadfx( "fx/explosions/aerial_explosion_large" );
    level.primary_weapon_array = [];
    level.side_arm_array = [];
    level._ID15777 = [];
    level._ID21134 = [];
    level._ID18325 = [];
    level._ID21075 = [];
    level._ID1644["equipment_explode"] = loadfx( "fx/explosions/sparks_a" );
    level._ID1644["sniperDustLarge"] = loadfx( "fx/dust/sniper_dust_kickup" );
    level._ID1644["sniperDustSmall"] = loadfx( "fx/dust/sniper_dust_kickup_minimal" );
    level._ID1644["sniperDustLargeSuppress"] = loadfx( "fx/dust/sniper_dust_kickup_accum_suppress" );
    level._ID1644["sniperDustSmallSuppress"] = loadfx( "fx/dust/sniper_dust_kickup_accum_supress_minimal" );
    level thread _ID22877();
    level._ID6390 = 0;
    common_scripts\utility::_ID3867( getentarray( "misc_turret", "classname" ), ::_ID34034 );
}

dumpit()
{
    wait 5.0;
}

initbombsquaddata()
{
    level.bomb_squad = [];
    level.bomb_squad["c4_mp"] = spawnstruct();
    level.bomb_squad["c4_mp"].model = "weapon_c4_iw6_bombsquad";
    level.bomb_squad["c4_mp"].tag = "tag_origin";
    level.bomb_squad["claymore_mp"] = spawnstruct();
    level.bomb_squad["claymore_mp"].model = "weapon_claymore_bombsquad";
    level.bomb_squad["claymore_mp"].tag = "tag_origin";
    level.bomb_squad["frag_grenade_mp"] = spawnstruct();
    level.bomb_squad["frag_grenade_mp"].model = "projectile_m67fraggrenade_bombsquad";
    level.bomb_squad["frag_grenade_mp"].tag = "tag_weapon";
    level.bomb_squad["frag_grenade_short_mp"] = spawnstruct();
    level.bomb_squad["frag_grenade_short_mp"].model = "projectile_m67fraggrenade_bombsquad";
    level.bomb_squad["frag_grenade_short_mp"].tag = "tag_weapon";
    level.bomb_squad["semtex_mp"] = spawnstruct();
    level.bomb_squad["semtex_mp"].model = "weapon_semtex_grenade_iw6_bombsquad";
    level.bomb_squad["semtex_mp"].tag = "tag_origin";
    level.bomb_squad["mortar_shell_mp"] = spawnstruct();
    level.bomb_squad["mortar_shell_mp"].model = "weapon_canister_bomb_bombsquad";
    level.bomb_squad["mortar_shell_mp"].tag = "tag_weapon";
    level.bomb_squad["thermobaric_grenade_mp"] = spawnstruct();
    level.bomb_squad["thermobaric_grenade_mp"].model = "weapon_thermobaric_grenade_bombsquad";
    level.bomb_squad["thermobaric_grenade_mp"].tag = "tag_weapon";
    level.bomb_squad["proximity_explosive_mp"] = spawnstruct();
    level.bomb_squad["proximity_explosive_mp"].model = "mp_proximity_explosive_bombsquad";
    level.bomb_squad["proximity_explosive_mp"].tag = "tag_origin";
}

bombsquadwaiter_missilefire()
{
    self endon( "disconnect" );

    for (;;)
    {
        var_0 = maps\mp\_utility::_ID35695();

        if ( var_0._ID36249 == "iw6_mk32_mp" )
            var_0 thread createbombsquadmodel( "projectile_semtex_grenade_bombsquad", "tag_weapon", self );
    }
}

createbombsquadmodel( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_model", ( 0, 0, 0 ) );
    var_3 hide();
    wait 0.05;

    if ( !isdefined( self ) )
        return;

    self.bombsquadmodel = var_3;
    var_3 thread bombsquadvisibilityupdater( var_2 );
    var_3 setmodel( var_0 );
    var_3 linkto( self, var_1, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_3 setcontents( 0 );
    common_scripts\utility::_ID35626( "death", "trap_death" );

    if ( isdefined( self.trigger ) )
        self.trigger delete();

    var_3 delete();
}

disablevisibilitycullingforclient( var_0 )
{
    self hudoutlineenableforclient( var_0, 6, 1 );
}

enablevisibilitycullingforclient( var_0 )
{
    self hudoutlinedisableforclient( var_0 );
}

bombsquadvisibilityupdater( var_0 )
{
    self endon( "death" );
    self endon( "trap_death" );

    if ( !isdefined( var_0 ) )
        return;

    var_1 = var_0.team;

    for (;;)
    {
        self hide();

        foreach ( var_3 in level.players )
        {
            enablevisibilitycullingforclient( var_3 );

            if ( !var_3 maps\mp\_utility::_hasperk( "specialty_detectexplosive" ) )
                continue;

            if ( level._ID32653 )
            {
                if ( var_3.team == "spectator" || var_3.team == var_1 )
                    continue;
            }
            else if ( isdefined( var_0 ) && var_3 == var_0 )
                continue;

            self showtoplayer( var_3 );
            disablevisibilitycullingforclient( var_3 );
        }

        level common_scripts\utility::_ID35626( "joined_team", "player_spawned", "changed_kit", "update_bombsquad" );
    }
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0._ID17020 = 0;
        maps\mp\gametypes\_gamelogic::_ID28745( var_0, 0 );
        var_0 thread onplayerspawned();
        var_0 thread bombsquadwaiter_missilefire();
        var_0 thread _ID36102();
        var_0 thread _ID30317();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "spawned_player" );
        self._ID8715 = self getcurrentweapon();
        self._ID11395 = 0;
        self._ID7852 = 0;
        self._ID17020 = 0;
        maps\mp\gametypes\_gamelogic::_ID28745( self, 0 );

        if ( !isdefined( self._ID33308 ) )
        {
            self._ID33308 = "";
            self._ID33308 = "none";
            self._ID33309 = 0;
            self._ID33307 = 0;
            self._ID33306 = 0;
            self.trackingweaponheadshots = 0;
            self._ID33304 = 0;
        }

        if ( !maps\mp\_utility::_ID18363() )
        {
            thread _ID36151();
            thread _ID36147();
            thread watchweaponperkupdates();
            thread watchsniperboltactionkills();
        }

        thread _ID36087();
        thread _ID36124();

        if ( !maps\mp\_utility::_ID18363() )
            thread maps\mp\gametypes\_class::_ID33321();

        thread _ID31172();
        self._ID19564 = [];
        self.droppeddeathweapon = undefined;
        self._ID33115 = [];
        thread updatesavedlastweapon();
        thread monitormk32semtexlauncher();
        self._ID8715 = undefined;
        self._ID33743 = undefined;
    }
}

recordtogglescopestates()
{
    self.pers["toggleScopeStates"] = [];
    var_0 = self getweaponslistprimaries();

    foreach ( var_2 in var_0 )
    {
        if ( var_2 == self._ID24978 || var_2 == self._ID27984 )
        {
            var_3 = getweaponattachments( var_2 );

            foreach ( var_5 in var_3 )
            {
                if ( istogglescope( var_5 ) )
                {
                    self.pers["toggleScopeStates"][var_2] = self gethybridscopestate( var_2 );
                    break;
                }
            }
        }
    }
}

updatetogglescopestate( var_0 )
{
    if ( isdefined( self.pers["toggleScopeStates"] ) && isdefined( self.pers["toggleScopeStates"][var_0] ) )
    {
        self sethybridscopestate( var_0, self.pers["toggleScopeStates"][var_0] );
        return;
    }
}

istogglescope( var_0 )
{
    var_1 = undefined;

    if ( var_0 == "thermalsniper" )
        var_1 = 0;
    else if ( var_0 == "dlcweap02scope" )
        var_1 = 1;
    else
    {
        var_2 = maps\mp\_utility::attachmentmap_tobase( var_0 );

        switch ( var_2 )
        {
            case "hybrid":
            case "thermal":
            case "tracker":
                var_1 = 1;
                break;
            default:
                var_1 = 0;
                break;
        }
    }

    return var_1;
}

_ID30317()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 = undefined;

    for (;;)
    {
        self waittill( "weapon_fired" );

        if ( self getstance() != "prone" )
            continue;

        if ( maps\mp\_utility::getweaponclass( self getcurrentweapon() ) != "weapon_sniper" )
            continue;

        var_1 = anglestoforward( self.angles );

        if ( !isdefined( var_0 ) || gettime() - var_0 > 2000 )
        {
            playfx( level._ID1644["sniperDustLarge"], self.origin + ( 0, 0, 10 ) + var_1 * 50, var_1 );
            var_0 = gettime();
            continue;
        }

        playfx( level._ID1644["sniperDustLargeSuppress"], self.origin + ( 0, 0, 10 ) + var_1 * 50, var_1 );
    }
}

_ID36134()
{
    maps\mp\_stinger::_ID31746();
}

_ID36092()
{
    maps\mp\_javelin::_ID18915();
}

weaponperkudpate( var_0, var_1, var_2 )
{
    var_3 = undefined;

    if ( isdefined( var_0 ) && var_0 != "none" )
    {
        var_0 = maps\mp\_utility::_ID14903( var_0 );
        var_3 = maps\mp\_utility::weaponperkmap( var_0 );

        if ( isdefined( var_3 ) && !maps\mp\_utility::_hasperk( var_3 ) )
            maps\mp\_utility::_ID15611( var_3, 0 );
    }

    if ( isdefined( var_1 ) && var_1 != "none" )
    {
        var_1 = maps\mp\_utility::_ID14903( var_1 );
        var_4 = maps\mp\_utility::weaponperkmap( var_1 );

        if ( isdefined( var_4 ) && ( !isdefined( var_3 ) || var_4 != var_3 ) && maps\mp\_utility::_hasperk( var_4 ) && ( !isdefined( var_2 ) || !common_scripts\utility::array_contains( var_2, var_4 ) ) )
        {
            maps\mp\_utility::_unsetperk( var_4 );
            return;
        }

        return;
    }
}

_ID36256( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;

    if ( isdefined( var_0 ) && var_0 != "none" )
    {
        var_2 = getweaponattachments( var_0 );

        if ( isdefined( var_2 ) && var_2.size > 0 )
        {
            var_4 = [];

            foreach ( var_6 in var_2 )
            {
                var_7 = maps\mp\_utility::_ID4048( var_6 );

                if ( !isdefined( var_7 ) )
                    continue;

                var_4[var_4.size] = var_7;

                if ( !maps\mp\_utility::_hasperk( var_7 ) )
                    maps\mp\_utility::_ID15611( var_7, 0 );
            }
        }
    }

    if ( isdefined( var_1 ) && var_1 != "none" )
    {
        var_3 = getweaponattachments( var_1 );

        if ( isdefined( var_3 ) && var_3.size > 0 )
        {
            foreach ( var_10 in var_3 )
            {
                var_7 = maps\mp\_utility::_ID4048( var_10 );

                if ( !isdefined( var_7 ) )
                    continue;

                if ( ( !isdefined( var_4 ) || !common_scripts\utility::array_contains( var_4, var_7 ) ) && maps\mp\_utility::_hasperk( var_7 ) )
                    maps\mp\_utility::_unsetperk( var_7 );
            }
        }
    }

    return var_4;
}

watchweaponperkupdates()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    var_0 = undefined;
    var_1 = self getcurrentweapon();
    var_2 = _ID36256( var_1, var_0 );
    weaponperkudpate( var_1, var_0, var_2 );

    for (;;)
    {
        var_0 = var_1;
        common_scripts\utility::_ID35626( "weapon_change", "giveLoadout" );
        var_1 = self getcurrentweapon();
        var_2 = _ID36256( var_1, var_0 );
        weaponperkudpate( var_1, var_0, var_2 );
    }
}

lethalstowed_clear()
{
    self.loadoutperkequipmentstowedammo = undefined;
    self.loadoutperkequipmentstowed = undefined;
}

hasunderbarrelweapon()
{
    var_0 = 0;
    var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        if ( weaponaltweaponname( var_3 ) != "none" )
        {
            var_0 = 1;
            break;
        }
    }

    return var_0;
}

lethalstowed_updatelethalsonweaponchange()
{
    if ( self._ID20130 != "specialty_null" )
    {
        if ( hasunderbarrelweapon() )
        {
            self.loadoutperkequipmentstowedammo = self getweaponammoclip( self._ID20130 );
            self.loadoutperkequipmentstowed = self._ID20130;
            self takeweapon( self._ID20130 );
            self._ID20130 = "specialty_null";
            maps\mp\_utility::giveperkequipment( "specialty_null", 0 );
            return;
        }

        return;
    }

    if ( isdefined( self.loadoutperkequipmentstowed ) && !hasunderbarrelweapon() )
    {
        maps\mp\_utility::giveperkequipment( self.loadoutperkequipmentstowed, 1 );
        self setweaponammoclip( self.loadoutperkequipmentstowed, self.loadoutperkequipmentstowedammo );
        self._ID20130 = self.loadoutperkequipmentstowed;
        lethalstowed_clear();
        return;
    }

    return;
}

_ID36147()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    childthread watchstartweaponchange();
    self._ID19545 = self._ID8715;
    self._ID17023 = [];
    var_0 = self getcurrentweapon();

    if ( maps\mp\_utility::iscacprimaryweapon( var_0 ) && !isdefined( self._ID17023[var_0] ) )
        self._ID17023[var_0] = weaponclipsize( var_0 );

    for (;;)
    {
        self waittill( "weapon_change",  var_0  );

        if ( var_0 == "none" )
            continue;

        if ( var_0 == "briefcase_bomb_mp" || var_0 == "briefcase_bomb_defuse_mp" )
            continue;

        lethalstowed_updatelethalsonweaponchange();

        if ( maps\mp\_utility::_ID18679( var_0 ) )
        {
            if ( ( maps\mp\_utility::_ID18666() || maps\mp\killstreaks\_killstreaks::isminigun( var_0 ) || self getcurrentweapon() == "venomxgun_mp" ) && !maps\mp\killstreaks\_killstreaks::isairdropmarker( var_0 ) )
            {
                if ( isdefined( self.changingweapon ) )
                {
                    waittillframeend;
                    self.changingweapon = undefined;
                }
            }

            continue;
        }

        var_1 = strtok( var_0, "_" );

        if ( var_1[0] == "alt" )
        {
            var_2 = getsubstr( var_0, 4 );
            var_0 = var_2;
            var_1 = strtok( var_0, "_" );
        }
        else if ( var_1[0] != "iw5" && var_1[0] != "iw6" )
            var_0 = var_1[0];

        if ( var_0 != "none" && var_1[0] != "iw5" && var_1[0] != "iw6" )
        {
            if ( maps\mp\_utility::iscacprimaryweapon( var_0 ) && !isdefined( self._ID17023[var_0 + "_mp"] ) )
                self._ID17023[var_0 + "_mp"] = weaponclipsize( var_0 + "_mp" );
        }
        else if ( var_0 != "none" && ( var_1[0] == "iw5" || var_1[0] == "iw6" ) )
        {
            if ( maps\mp\_utility::iscacprimaryweapon( var_0 ) && !isdefined( self._ID17023[var_0] ) )
                self._ID17023[var_0] = weaponclipsize( var_0 );
        }

        self.changingweapon = undefined;

        if ( var_1[0] == "iw5" || var_1[0] == "iw6" )
        {
            self._ID19545 = var_0;
            continue;
        }

        if ( var_0 != "none" && _ID20772( var_0 + "_mp" ) )
            self._ID19545 = var_0 + "_mp";
    }
}

watchsniperboltactionkills()
{
    self endon( "death" );
    self endon( "disconnect" );
    thread watchsniperboltactionkills_ondeath();

    if ( !isdefined( self.pers["recoilReduceKills"] ) )
        self.pers["recoilReduceKills"] = 0;

    self setclientomnvar( "weap_sniper_display_state", self.pers["recoilReduceKills"] );

    for (;;)
    {
        self waittill( "got_a_kill",  var_0, var_1, var_2  );

        if ( isrecoilreducingweapon( var_1 ) )
        {
            var_3 = self.pers["recoilReduceKills"] + 1;
            self.pers["recoilReduceKills"] = int( min( var_3, 4 ) );
            self setclientomnvar( "weap_sniper_display_state", self.pers["recoilReduceKills"] );

            if ( var_3 <= 4 )
                stancerecoilupdate( self getstance() );
        }
    }
}

watchsniperboltactionkills_ondeath()
{
    self notify( "watchSniperBoltActionKills_onDeath" );
    self endon( "watchSniperBoltActionKills_onDeath" );
    self endon( "disconnect" );
    self waittill( "death" );
    self.pers["recoilReduceKills"] = 0;
}

isrecoilreducingweapon( var_0 )
{
    if ( !isdefined( var_0 ) || var_0 == "none" )
        return 0;

    var_1 = 0;

    if ( issubstr( var_0, "l115a3scope" ) || issubstr( var_0, "l115a3vzscope" ) || issubstr( var_0, "usrscope" ) || issubstr( var_0, "usrvzscope" ) )
        var_1 = 1;

    return var_1;
}

getrecoilreductionvalue()
{
    if ( !isdefined( self.pers["recoilReduceKills"] ) )
        self.pers["recoilReduceKills"] = 0;

    return self.pers["recoilReduceKills"] * 3;
}

watchstartweaponchange()
{
    self endon( "death" );
    self endon( "disconnect" );
    self.changingweapon = undefined;

    for (;;)
    {
        self waittill( "weapon_switch_started",  var_0  );
        thread _ID20512( self getcurrentweapon() );
        self.changingweapon = var_0;

        if ( var_0 == "none" && isdefined( self.iscapturingcrate ) && self.iscapturingcrate )
        {
            while ( self.iscapturingcrate )
                wait 0.05;

            self.changingweapon = undefined;
        }
    }
}

_ID20512( var_0 )
{
    self endon( "weapon_switch_started" );
    self endon( "weapon_change" );
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );

    if ( maps\mp\_utility::_ID18679( var_0 ) )
        return;

    wait 1.0;
    self.changingweapon = undefined;
}

ishackweapon( var_0 )
{
    if ( var_0 == "radar_mp" || var_0 == "airstrike_mp" || var_0 == "helicopter_mp" )
        return 1;

    if ( var_0 == "briefcase_bomb_mp" )
        return 1;

    return 0;
}

_ID20772( var_0 )
{
    if ( var_0 == "none" )
        return 0;

    if ( issubstr( var_0, "ac130" ) )
        return 0;

    if ( issubstr( var_0, "uav" ) )
        return 0;

    if ( issubstr( var_0, "killstreak" ) )
        return 0;

    var_1 = weaponinventorytype( var_0 );

    if ( var_1 != "primary" )
        return 0;

    return 1;
}

dropweaponfordeath( var_0, var_1 )
{
    if ( isdefined( level.blockweapondrops ) )
        return;

    if ( isdefined( self.droppeddeathweapon ) )
        return;

    if ( level._ID17628 )
        return;

    var_2 = self._ID19545;

    if ( !isdefined( var_2 ) )
        return;

    if ( var_2 == "none" )
        return;

    if ( !self hasweapon( var_2 ) )
        return;

    if ( maps\mp\_utility::_ID18666() )
        return;

    if ( isdefined( level.gamemodemaydropweapon ) && !self [[ level.gamemodemaydropweapon ]]( var_2 ) )
        return;

    var_3 = strtok( var_2, "_" );

    if ( var_3[0] == "alt" )
    {
        for ( var_4 = 1; var_4 < var_3.size; var_4++ )
        {
            if ( var_4 > 1 )
                var_2 += "_";

            var_2 += var_3[var_4];
        }
    }

    if ( var_2 != "iw6_riotshield_mp" )
    {
        if ( !self anyammoforweaponmodes( var_2 ) )
            return;

        var_5 = self getweaponammoclip( var_2, "right" );
        var_6 = self getweaponammoclip( var_2, "left" );

        if ( !var_5 && !var_6 )
            return;

        var_7 = self getweaponammostock( var_2 );
        var_8 = weaponmaxammo( var_2 );

        if ( var_7 > var_8 )
            var_7 = var_8;

        var_9 = self dropitem( var_2 );

        if ( !isdefined( var_9 ) )
            return;

        var_9 itemweaponsetammo( var_5, var_7, var_6 );
    }
    else
    {
        var_9 = self dropitem( var_2 );

        if ( !isdefined( var_9 ) )
            return;

        var_9 itemweaponsetammo( 1, 1, 0 );
    }

    self.droppeddeathweapon = 1;
    var_9.owner = self;
    var_9.ownersattacker = var_0;
    var_9.targetname = "dropped_weapon";
    var_9 thread _ID36110();
    var_9 thread deletepickupafterawhile();
}

detachifattached( var_0, var_1 )
{
    var_2 = self getattachsize();

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = self getattachmodelname( var_3 );

        if ( var_4 != var_0 )
            continue;

        var_5 = self getattachtagname( var_3 );
        self detach( var_0, var_5 );

        if ( var_5 != var_1 )
        {
            var_2 = self getattachsize();

            for ( var_3 = 0; var_3 < var_2; var_3++ )
            {
                var_5 = self getattachtagname( var_3 );

                if ( var_5 != var_1 )
                    continue;

                var_0 = self getattachmodelname( var_3 );
                self detach( var_0, var_5 );
                break;
            }
        }

        return 1;
    }

    return 0;
}

deletepickupafterawhile()
{
    self endon( "death" );
    wait 60;

    if ( !isdefined( self ) )
        return;

    self delete();
}

getitemweaponname()
{
    var_0 = self.classname;
    var_1 = getsubstr( var_0, 7 );
    return var_1;
}

_ID36110()
{
    self endon( "death" );
    var_0 = getitemweaponname();

    for (;;)
    {
        self waittill( "trigger",  var_1, var_2  );

        if ( isdefined( var_2 ) )
            break;
    }

    var_3 = var_2 getitemweaponname();

    if ( isdefined( var_1._ID24978 ) && var_1._ID24978 == var_3 )
        var_1._ID24978 = var_0;

    if ( isdefined( var_1._ID27984 ) && var_1._ID27984 == var_3 )
        var_1._ID27984 = var_0;

    if ( isdefined( var_1._ID33115[var_3] ) )
    {
        var_2.owner = var_1._ID33115[var_3];
        var_2.ownersattacker = var_1;
        var_1._ID33115[var_3] = undefined;
    }

    var_2.targetname = "dropped_weapon";
    var_2 thread _ID36110();

    if ( isdefined( self.ownersattacker ) && self.ownersattacker == var_1 )
    {
        var_1._ID33115[var_0] = self.owner;
        return;
    }

    var_1._ID33115[var_0] = undefined;
    return;
}

_ID18888()
{
    var_0 = getitemweaponname();
    var_1 = weaponaltweaponname( var_0 );

    for ( var_2 = 1; var_1 != "none" && var_1 != var_0; var_2++ )
    {
        self itemweaponsetammo( 0, 0, 0, var_2 );
        var_1 = weaponaltweaponname( var_1 );
    }
}

handlescavengerbagpickup( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    self waittill( "scavenger",  var_1  );
    var_1 notify( "scavenger_pickup" );
    _ID27334( var_1 );
    var_1 maps\mp\gametypes\_damagefeedback::hudicontype( "scavenger" );
}

_ID27334( var_0 )
{
    var_1 = var_0 getweaponslistoffhands();

    foreach ( var_3 in var_1 )
    {
        if ( !isthrowingknife( var_3 ) )
            continue;

        var_4 = common_scripts\utility::_ID32831( var_0 maps\mp\_utility::_hasperk( "specialty_extra_deadly" ), 2, 1 );
        var_5 = var_0 getweaponammoclip( var_3 );

        if ( var_5 + 1 <= var_4 )
            var_0 setweaponammoclip( var_3, var_5 + 1 );
    }

    var_7 = var_0 getweaponslistprimaries();

    foreach ( var_9 in var_7 )
    {
        if ( !maps\mp\_utility::iscacprimaryweapon( var_9 ) && !level._ID27333 )
            continue;

        if ( issubstr( var_9, "alt_" ) && issubstr( var_9, "_gl" ) )
            continue;

        if ( maps\mp\_utility::getweaponclass( var_9 ) == "weapon_projectile" )
            continue;

        if ( var_9 == "venomxgun_mp" )
            continue;

        var_10 = var_0 getweaponammostock( var_9 );
        var_11 = weaponclipsize( var_9 );
        var_0 setweaponammostock( var_9, var_10 + var_11 );
    }
}

dropscavengerfordeath( var_0 )
{
    if ( level._ID17628 )
        return;

    if ( !isdefined( var_0 ) )
        return;

    if ( var_0 == self )
        return;

    var_1 = self dropscavengerbag( "scavenger_bag_mp" );
    var_1 thread handlescavengerbagpickup( self );

    if ( isdefined( level.bot_funcs["bots_add_scavenger_bag"] ) )
    {
        [[ level.bot_funcs["bots_add_scavenger_bag"] ]]( var_1 );
        return;
    }
}

_ID29209( var_0, var_1, var_2 )
{
    maps\mp\gametypes\_gamelogic::_ID29209( var_0, var_1, var_2 );
}

_ID36151( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    level endon( "game_ended" );

    if ( isai( self ) )
        return;

    for (;;)
    {
        self waittill( "weapon_fired",  var_1  );
        var_1 = self getcurrentweapon();
        maps\mp\gametypes\_gamelogic::_ID28745( self, 1 );
        self._ID19608 = gettime();

        if ( !maps\mp\_utility::iscacprimaryweapon( var_1 ) && !maps\mp\_utility::_ID18576( var_1 ) )
            continue;

        if ( isdefined( self._ID17023[var_1] ) )
            thread _ID34557( var_1 );

        var_2 = maps\mp\gametypes\_persistence::statgetbuffered( "totalShots" ) + 1;
        var_3 = maps\mp\gametypes\_persistence::statgetbuffered( "hits" );
        var_4 = clamp( float( var_3 ) / float( var_2 ), 0.0, 1.0 ) * 10000.0;

        if ( !issquadsmode() )
        {
            maps\mp\gametypes\_persistence::_ID31527( "totalShots", var_2 );
            maps\mp\gametypes\_persistence::_ID31527( "accuracy", int( var_4 ) );
            maps\mp\gametypes\_persistence::_ID31527( "misses", int( var_2 - var_3 ) );
        }

        if ( isdefined( self._ID19631 ) && self._ID19631._ID19635 == gettime() )
        {
            self._ID17020 = 0;
            return;
        }

        var_5 = 1;
        _ID29209( var_1, var_5, "shots" );
        _ID29209( var_1, self._ID17020, "hits" );
        self._ID17020 = 0;
    }
}

_ID34557( var_0 )
{
    if ( !maps\mp\_utility::_ID18363() )
    {
        _ID34558( var_0 );
        return;
    }
}

_ID34558( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "updateMagShots_" + var_0 );
    self._ID17023[var_0]--;
    wait 0.05;
    self._ID17023[var_0] = weaponclipsize( var_0 );
}

_ID7081( var_0 )
{
    if ( !maps\mp\_utility::_ID18363() )
    {
        checkhitsthismag_regularmp( var_0 );
        return;
    }
}

checkhitsthismag_regularmp( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self notify( "updateMagShots_" + var_0 );
    waittillframeend;

    if ( isdefined( self._ID17023[var_0] ) && self._ID17023[var_0] == 0 )
    {
        var_1 = maps\mp\_utility::getweaponclass( var_0 );
        maps\mp\gametypes\_missions::_ID14249( var_1 );
        self._ID17023[var_0] = weaponclipsize( var_0 );
        return;
    }
}

checkhit( var_0, var_1 )
{
    self endon( "disconnect" );

    if ( maps\mp\_utility::_ID18801( var_0, "alt_" ) )
    {
        var_2 = maps\mp\_utility::_ID15474( var_0 );

        if ( common_scripts\utility::array_contains( var_2, "shotgun" ) || common_scripts\utility::array_contains( var_2, "gl" ) )
            self._ID17020 = 1;
        else
            var_0 = getsubstr( var_0, 4 );
    }

    if ( !isprimaryweapon( var_0 ) && !issidearm( var_0 ) )
        return;

    if ( self meleebuttonpressed() && var_0 != "iw6_knifeonly_mp" && var_0 != "iw6_knifeonlyfast_mp" )
        return;

    switch ( weaponclass( var_0 ) )
    {
        case "sniper":
        case "rifle":
        case "pistol":
        case "mg":
        case "smg":
            self._ID17020++;
            break;
        case "spread":
            self._ID17020 = 1;
            break;
        default:
            break;
    }

    if ( _ID18766( var_0 ) || var_0 == "iw6_knifeonly_mp" || var_0 == "iw6_knifeonlyfast_mp" )
    {
        thread maps\mp\gametypes\_gamelogic::_ID32913( var_0, self._ID17020, "hits" );
        self._ID17020 = 0;
    }

    waittillframeend;

    if ( isdefined( self._ID17023[var_0] ) )
        thread _ID7081( var_0 );

    if ( !isdefined( self._ID19564[var_0] ) )
        self._ID19564[var_0] = 0;

    if ( self._ID19564[var_0] == gettime() )
        return;

    self._ID19564[var_0] = gettime();

    if ( !issquadsmode() )
    {
        var_3 = maps\mp\gametypes\_persistence::statgetbuffered( "totalShots" );
        var_4 = maps\mp\gametypes\_persistence::statgetbuffered( "hits" ) + 1;

        if ( var_4 <= var_3 )
        {
            maps\mp\gametypes\_persistence::_ID31527( "hits", var_4 );
            maps\mp\gametypes\_persistence::_ID31527( "misses", int( var_3 - var_4 ) );
            var_5 = clamp( float( var_4 ) / float( var_3 ), 0.0, 1.0 ) * 10000.0;
            maps\mp\gametypes\_persistence::_ID31527( "accuracy", int( var_5 ) );
            return;
        }

        return;
    }
}

attackercandamageitem( var_0, var_1 )
{
    return _ID13695( var_1, var_0 );
}

_ID13695( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) )
        return 1;

    if ( !level._ID32653 )
        return 1;

    var_3 = var_1.team;
    var_4 = level._ID13683;

    if ( isdefined( var_2 ) )
        var_4 = var_2;

    if ( var_4 != 0 )
        return 1;

    if ( var_1 == var_0 )
        return !maps\mp\_utility::_ID18363();

    if ( !isdefined( var_3 ) )
        return 1;

    if ( var_3 != var_0.team )
        return 1;

    return 0;
}

_ID36087()
{
    self notify( "watchGrenadeUsage" );
    self endon( "watchGrenadeUsage" );
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self._ID32944 = undefined;
    self._ID15756 = 0;

    if ( maps\mp\_utility::_ID15069( "scr_deleteexplosivesonspawn", 1 ) == 1 )
    {
        if ( isdefined( self._ID10650 ) )
            self._ID10650 = undefined;
        else
            delete_all_grenades();
    }
    else if ( !isdefined( self._ID23708 ) )
    {
        self._ID23708 = [];
        self._ID23709 = [];
    }

    thread watchforthrowbacks();

    for (;;)
    {
        self waittill( "grenade_pullback",  var_0  );

        if ( !maps\mp\_utility::_ID18363() )
            _ID29209( var_0, 1, "shots" );

        maps\mp\gametypes\_gamelogic::_ID28745( self, 1 );
        thread watchoffhandcancel();
        self._ID32944 = var_0;
        self._ID15756 = 1;

        if ( var_0 == "c4_mp" )
            thread _ID5106();

        begingrenadetracking();
        self._ID32944 = undefined;
    }
}

begingrenadetracking()
{
    self endon( "offhand_end" );
    self endon( "weapon_change" );
    var_0 = gettime();
    var_1 = maps\mp\_utility::_ID35688();

    if ( !isdefined( var_1 ) )
        return;

    if ( !isdefined( var_1._ID36249 ) )
        return;

    self.changingweapon = undefined;

    if ( isdefined( level.bomb_squad[var_1._ID36249] ) )
        var_1 thread createbombsquadmodel( level.bomb_squad[var_1._ID36249].model, level.bomb_squad[var_1._ID36249].tag, self );

    switch ( var_1._ID36249 )
    {
        case "frag_grenade_mp":
        case "thermobaric_grenade_mp":
            if ( gettime() - var_0 > 1000 )
                var_1._ID18591 = 1;

            var_1 thread maps\mp\gametypes\_shellshock::_ID15783();
            var_1._ID23036 = self;
            break;
        case "mortar_shell_mp":
        case "iw6_aliendlc22_mp":
        case "iw6_aliendlc43_mp":
            var_1 thread maps\mp\gametypes\_shellshock::_ID15783();
            var_1._ID23036 = self;
            break;
        case "semtex_mp":
        case "aliensemtex_mp":
            thread _ID28046( var_1 );
            break;
        case "c4_mp":
            thread c4used( var_1 );
            break;
        case "proximity_explosive_mp":
            thread _ID25127( var_1 );
            break;
        case "flash_grenade_mp":
            var_2 = gettime() - var_0;
            var_1._ID22031 = 1;

            if ( var_2 > 1000 )
            {
                var_1._ID18591 = 1;
                var_1._ID22031 = var_1._ID22031 + min( int( var_2 / 875 ), 5 );
            }

            var_1 thread ninebangexplodewaiter();
            break;
        case "smoke_grenade_mp":
        case "smoke_grenadejugg_mp":
            var_1 thread _ID36129();
            break;
        case "trophy_mp":
        case "alientrophy_mp":
            thread maps\mp\gametypes\_trophy_system::_ID33744( var_1 );
            break;
        case "claymore_mp":
        case "alienclaymore_mp":
            thread claymoreused( var_1 );
            break;
        case "bouncingbetty_mp":
        case "alienbetty_mp":
            thread _ID21083( var_1, ::_ID30894 );
            break;
        case "motion_sensor_mp":
            thread _ID21083( var_1, ::_ID30896 );
            break;
        case "throwingknife_mp":
        case "throwingknifejugg_mp":
            level thread throwingknifeused( self, var_1, var_1._ID36249 );
            break;
    }
}

throwingknifeused( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    var_1 waittill( "missile_stuck",  var_3  );
    var_1 endon( "death" );
    var_1 makeunusable();
    var_4 = spawn( "trigger_radius", var_1.origin, 0, 64, 64 );
    var_4 enablelinkto();
    var_4 linkto( var_1 );
    var_4.targetname = "dropped_knife";
    var_1._ID19292 = var_4;
    var_1 thread _ID36083();

    for (;;)
    {
        common_scripts\utility::_ID35582();

        if ( !isdefined( var_4 ) )
            return;

        var_4 waittill( "trigger",  var_5  );

        if ( !isplayer( var_5 ) || !maps\mp\_utility::_ID18757( var_5 ) )
            continue;

        if ( !var_5 hasweapon( var_2 ) )
            continue;

        var_6 = var_5 getweaponammoclip( var_2 );
        var_7 = var_5 maps\mp\_utility::_hasperk( "specialty_extra_deadly" );

        if ( var_7 && var_6 == 2 )
            continue;

        if ( !var_7 && var_6 == 1 )
            continue;

        var_5 setweaponammoclip( var_2, var_6 + 1 );
        var_5 thread maps\mp\gametypes\_damagefeedback::hudicontype( "throwingknife" );
        var_1 delete();
        break;
    }
}

_ID36083()
{
    self waittill( "death" );

    if ( isdefined( self._ID19292 ) )
    {
        self._ID19292 delete();
        return;
    }
}

watchoffhandcancel()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "grenade_fire" );
    self waittill( "offhand_end" );

    if ( isdefined( self.changingweapon ) && self.changingweapon != self getcurrentweapon() )
    {
        self.changingweapon = undefined;
        return;
    }
}

_ID36129()
{
    level endon( "smokeTimesUp" );
    var_0 = self.owner;
    var_0 endon( "disconnect" );
    self waittill( "explode",  var_1  );
    var_2 = 128;
    var_3 = 8;
    level thread _ID35610( var_3, var_2, var_1 );

    for (;;)
    {
        if ( !isdefined( var_0 ) )
            break;

        foreach ( var_5 in level.players )
        {
            if ( !isdefined( var_5 ) )
                continue;

            if ( level._ID32653 && var_5.team == var_0.team )
                continue;

            if ( distancesquared( var_5.origin, var_1 ) < var_2 * var_2 )
            {
                var_5._ID18015 = var_0;
                continue;
            }

            var_5._ID18015 = undefined;
        }

        wait 0.05;
    }
}

_ID35610( var_0, var_1, var_2 )
{
    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    level notify( "smokeTimesUp" );
    waittillframeend;

    foreach ( var_4 in level.players )
    {
        if ( isdefined( var_4 ) )
            var_4._ID18015 = undefined;
    }
}

_ID20194()
{
    var_0 = [];

    if ( level._ID32653 )
    {
        if ( isdefined( level.chopper ) && ( level.chopper.team != self.team || isdefined( level.chopper.owner ) && level.chopper.owner == self ) )
            var_0[var_0.size] = level.chopper;

        if ( isdefined( level._ID20086 ) )
        {
            foreach ( var_2 in level._ID20086 )
            {
                if ( isdefined( var_2 ) && ( var_2.team != self.team || isdefined( var_2.owner ) && var_2.owner == self ) )
                    var_0[var_0.size] = var_2;
            }
        }

        if ( isdefined( level.balldrones ) )
        {
            foreach ( var_5 in level.balldrones )
            {
                if ( isdefined( var_5 ) && ( var_5.team != self.team || isdefined( var_5.owner ) && var_5.owner == self ) )
                    var_0[var_0.size] = var_5;
            }
        }

        if ( isdefined( level.harriers ) )
        {
            foreach ( var_8 in level.harriers )
            {
                if ( isdefined( var_8 ) && ( var_8.team != self.team || isdefined( var_8.owner ) && var_8.owner == self ) )
                    var_0[var_0.size] = var_8;
            }
        }
    }
    else
    {
        if ( isdefined( level.chopper ) )
            var_0[var_0.size] = level.chopper;

        if ( isdefined( level._ID20086 ) )
        {
            foreach ( var_2 in level._ID20086 )
            {
                if ( !isdefined( var_2 ) )
                    continue;

                var_0[var_0.size] = var_2;
            }
        }

        if ( isdefined( level.balldrones ) )
        {
            foreach ( var_5 in level.balldrones )
            {
                if ( !isdefined( var_5 ) )
                    continue;

                var_0[var_0.size] = var_5;
            }
        }

        if ( isdefined( level.harriers ) )
        {
            foreach ( var_8 in level.harriers )
            {
                if ( !isdefined( var_8 ) )
                    continue;

                var_0[var_0.size] = var_8;
            }
        }
    }

    return var_0;
}

_ID36102()
{
    self endon( "disconnect" );

    for (;;)
    {
        var_0 = maps\mp\_utility::_ID35695();

        if ( issubstr( var_0._ID36249, "gl_" ) )
        {
            var_0._ID24978 = self getcurrentprimaryweapon();
            var_0 thread maps\mp\gametypes\_shellshock::_ID15783();
        }

        switch ( var_0._ID36249 )
        {
            case "at4_mp":
            case "iw5_smaw_mp":
            case "stinger_mp":
                level notify( "stinger_fired",  self, var_0, self._ID31744  );
                break;
            case "remote_mortar_missile_mp":
            case "lasedStrike_missile_mp":
            case "javelin_mp":
                level notify( "stinger_fired",  self, var_0, self._ID18911  );
                break;
            default:
                break;
        }

        switch ( var_0._ID36249 )
        {
            case "iw6_maaws_mp":
            case "iw6_panzerfaust3_mp":
            case "remote_mortar_missile_mp":
            case "lasedStrike_missile_mp":
            case "ac130_105mm_mp":
            case "ac130_40mm_mp":
            case "remotemissile_projectile_mp":
                var_0 thread maps\mp\gametypes\_shellshock::_ID15783();
            default:
                continue;
        }
    }
}

_ID36089()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "hit_by_missile",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7  );

        if ( !isdefined( var_0 ) || !isdefined( var_1 ) )
            continue;

        if ( level._ID32653 && self.team == var_0.team )
        {
            self cancelrocketcorpse( var_1, var_3, var_4, var_5, var_6, var_7 );
            continue;
        }

        if ( var_2 != "rpg_mp" )
        {
            self cancelrocketcorpse( var_1, var_3, var_4, var_5, var_6, var_7 );
            continue;
        }

        if ( randomintrange( 0, 100 ) < 99 )
        {
            self cancelrocketcorpse( var_1, var_3, var_4, var_5, var_6, var_7 );
            continue;
        }

        var_8 = getdvarfloat( "rocket_corpse_max_air_time", 0.5 );
        var_9 = getdvarfloat( "rocket_corpse_view_offset_up", 100 );
        var_10 = getdvarfloat( "rocket_corpse_view_offset_forward", 35 );
        self._ID18767 = 1;
        self setcontents( 0 );
        var_11 = self setrocketcorpse( 1 );
        var_12 = var_11 / 1000.0;
        self._ID19214 = spawn( "script_model", var_1.origin );
        self._ID19214.angles = var_1.angles;
        self._ID19214 linkto( var_1 );
        self._ID19214 setscriptmoverkillcam( "rocket_corpse" );
        self._ID19214 setcontents( 0 );
        self dodamage( 1000, self.origin, var_0, var_1 );
        self._ID5433 = self cloneplayer( var_11 );
        self._ID5433.origin = var_1.origin;
        self._ID5433.angles = var_1.angles;
        self._ID5433.targetname = "player_corpse";
        self._ID5433 setcorpsefalling( 0 );
        self._ID5433 enablelinkto();
        self._ID5433 linkto( var_1 );
        self._ID5433 setcontents( 0 );

        if ( !isdefined( self._ID32285 ) )
            thread maps\mp\gametypes\_deathicons::adddeathicon( self._ID5433, self, self.team, 5.0 );

        self playerhide();
        var_13 = vectornormalize( anglestoup( var_1.angles ) );
        var_14 = vectornormalize( anglestoforward( var_1.angles ) );
        var_15 = var_14 * var_9 + var_13 * var_10;
        var_16 = var_1.origin + var_15;
        var_17 = spawn( "script_model", var_16 );
        var_17 setmodel( "tag_origin" );
        var_17.angles = vectortoangles( var_1.origin - var_17.origin );
        var_17 linkto( var_1 );
        var_17 setcontents( 0 );
        self cameralinkto( var_17, "tag_origin" );

        if ( var_8 > var_12 )
            var_8 = var_12;

        var_18 = var_1 common_scripts\utility::_ID35710( "death", var_8 );

        if ( isdefined( var_18 ) && var_18 == "timeout" && isdefined( var_1 ) )
            var_1 detonate();

        self notify( "final_rocket_corpse_death" );
        self._ID5433 unlink();
        self._ID5433 setcorpsefalling( 1 );
        self._ID5433 startragdoll();
        var_17 linkto( self._ID5433 );
        self._ID18767 = undefined;
        self waittill( "death_delay_finished" );
        self cameraunlink();
        self._ID19214 delete();
        var_17 delete();
    }
}

_ID36124()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );

    for (;;)
    {
        self waittill( "sentry_placement_finished",  var_0  );
        thread maps\mp\_utility::_ID28636( var_0, "tag_flash", 65 );
    }
}

ninebangexplodewaiter()
{
    thread maps\mp\gametypes\_shellshock::_ID11744();
    self endon( "end_explode" );
    self waittill( "explode",  var_0  );
    thread _ID10627( var_0, self.owner, self._ID22031 );
    _ID22028( var_0, self.owner, self._ID22031 );
}

_ID22028( var_0, var_1, var_2 )
{
    if ( var_2 >= 5 || pitchercheck( var_1, var_2 ) )
    {
        playsoundatpos( var_0, "weap_emp_explode" );
        var_3 = getempdamageents( var_0, 512, 0 );

        foreach ( var_5 in var_3 )
        {
            if ( isdefined( var_5.owner ) && !_ID13695( var_1, var_5.owner ) )
                continue;

            var_5 notify( "emp_damage",  self.owner, 8.0  );
        }

        return;
    }
}

pitchercheck( var_0, var_1 )
{
    if ( var_0 maps\mp\_utility::_hasperk( "specialty_pitcher" ) )
    {
        if ( var_1 >= 4 )
            return 1;
    }

    return 0;
}

_ID10627( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    var_3 = level._ID36259[self._ID36249];
    wait(randomfloatrange( 0.25, 0.5 ));

    for ( var_4 = 1; var_4 < var_2; var_4++ )
    {
        var_5 = _ID15176( var_0, var_3._ID35228 );
        playsoundatpos( var_5, var_3._ID22837 );
        playfx( var_3._ID22838, var_5 );

        foreach ( var_7 in level.players )
        {
            if ( !maps\mp\_utility::_ID18757( var_7 ) || var_7.sessionstate != "playing" )
                continue;

            var_8 = var_7 geteye();
            var_9 = distancesquared( var_0, var_8 );

            if ( var_9 > var_3._ID25300 )
                continue;

            if ( !bullettracepassed( var_0, var_8, 0, var_7 ) )
                continue;

            if ( var_9 <= var_3.radius_min_sq )
                var_10 = 1.0;
            else
                var_10 = 1.0 - ( var_9 - var_3.radius_min_sq ) / ( var_3._ID25300 - var_3.radius_min_sq );

            var_11 = anglestoforward( var_7 getplayerangles() );
            var_12 = var_0 - var_8;
            var_12 = vectornormalize( var_12 );
            var_13 = 0.5 * ( 1.0 + vectordot( var_11, var_12 ) );
            var_14 = 1;
            var_7 notify( "flashbang",  var_0, var_10, var_13, var_1, var_14  );
        }

        wait(randomfloatrange( 0.25, 0.5 ));
    }
}

_ID15176( var_0, var_1 )
{
    var_2 = ( randomfloatrange( -1.0 * var_1, var_1 ), randomfloatrange( -1.0 * var_1, var_1 ), 0 );
    var_3 = var_0 + var_2;
    var_4 = bullettrace( var_0, var_3, 0, self, 0, 0, 0, 0, 0 );

    if ( var_4["fraction"] < 1 )
        var_3 = var_0 + var_4["fraction"] * var_2;

    return var_3;
}

_ID5106()
{
    self notify( "beginC4Tracking" );
    self endon( "beginC4Tracking" );
    self endon( "death" );
    self endon( "disconnect" );
    common_scripts\utility::_ID35626( "grenade_fire", "weapon_change", "offhand_end" );
    self.changingweapon = undefined;
}

watchforthrowbacks()
{
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "grenade_fire",  var_0, var_1  );

        if ( self._ID15756 )
        {
            self._ID15756 = 0;
            continue;
        }

        if ( !issubstr( var_1, "frag_" ) && !issubstr( var_1, "mortar_shell" ) )
            continue;

        var_0._ID32933 = 1;
        thread maps\mp\_utility::_ID17531( "throwbacks", 1 );
        var_0 thread maps\mp\gametypes\_shellshock::_ID15783();
        var_0._ID23036 = self;
    }
}

c4used( var_0 )
{
    if ( !maps\mp\_utility::_ID18757( self ) )
    {
        var_0 delete();
        return;
    }

    var_0 thread ondetonateexplosive();
    thread _ID36047();
    thread _ID36046();

    if ( !self._ID23708.size )
        thread _ID36045();

    var_0 setotherent( self );
    var_0.activated = 0;
    _ID22860( var_0 );
    var_0 thread maps\mp\gametypes\_shellshock::c4_earthquake();
    var_0 thread c4activate();
    var_0 thread c4damage();
    var_0 thread c4empdamage();
    var_0 thread _ID36048();
    level thread monitordisownedequipment( self, var_0 );
}

_ID21728( var_0 )
{
    if ( !isdefined( var_0.lasttouchedplatform ) || !isdefined( var_0.lasttouchedplatform.destroyexplosiveoncollision ) || var_0.lasttouchedplatform.destroyexplosiveoncollision )
    {
        self notify( "detonateExplosive" );
        return;
    }
}

_ID36048()
{
    self endon( "death" );
    self waittill( "missile_stuck",  var_0  );
    _ID20502();
    _ID20501();
    explosivehandlemovers( var_0 );
}

c4empdamage()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "emp_damage",  var_0, var_1  );
        equipmentempstunvfx();
        self._ID10146 = 1;
        self notify( "disabled" );
        wait(var_1);
        self._ID10146 = undefined;
        self notify( "enabled" );
    }
}

_ID25127( var_0 )
{
    if ( !maps\mp\_utility::_ID18757( self ) )
    {
        var_0 delete();
        return;
    }

    var_0 waittill( "missile_stuck",  var_1  );

    if ( !maps\mp\_utility::_ID18757( self ) )
    {
        var_0 delete();
        return;
    }

    if ( !isdefined( var_0.owner.team ) )
    {
        var_0 delete();
        return;
    }

    var_2 = anglestoup( var_0.angles );
    var_0.origin = var_0.origin - var_2;
    var_3 = level._ID36259[var_0._ID36249];
    var_4 = spawn( "script_model", var_0.origin + var_3._ID19217 * var_2 );
    var_4 setscriptmoverkillcam( "explosive" );
    var_4 linkto( var_0 );
    var_0._ID19214 = var_4;
    var_0 explosivehandlemovers( var_1 );
    var_0 _ID20502();
    var_0 _ID20501();
    _ID22860( var_0 );
    var_0 thread ondetonateexplosive();
    var_0 thread c4damage();
    var_0 thread proximityexplosiveempstun();
    var_0 thread _ID25126( var_1 );

    if ( !maps\mp\_utility::_ID18363() )
        var_0 thread _ID28676( self.team, 20 );

    level thread monitordisownedequipment( self, var_0 );
}

_ID25126( var_0 )
{
    self endon( "death" );
    self endon( "disabled" );
    var_1 = level._ID36259[self._ID36249];
    wait(var_1.armingdelay);
    self playloopsound( "ied_explo_beeps" );
    thread doblinkinglight( "tag_fx" );
    var_2 = self.origin * ( 1, 1, 0 );
    var_3 = var_1._ID9937 / 2;
    var_4 = self.origin[2] - var_3;
    var_2 += ( 0, 0, var_4 );
    var_5 = spawn( "trigger_radius", var_2, 0, var_1.detectionradius, var_1._ID9937 );
    var_5.owner = self;

    if ( isdefined( var_0 ) )
    {
        var_5 enablelinkto();
        var_5 linkto( self );
    }

    self.damagearea = var_5;
    thread deleteondeath( var_5 );
    var_6 = undefined;

    for (;;)
    {
        var_5 waittill( "trigger",  var_6  );

        if ( !isdefined( var_6 ) )
            continue;

        if ( getdvarint( "scr_minesKillOwner" ) != 1 )
        {
            if ( isdefined( self.owner ) )
            {
                if ( var_6 == self.owner )
                    continue;

                if ( isdefined( var_6.owner ) && var_6.owner == self.owner )
                    continue;
            }

            if ( !_ID13695( self.owner, var_6, 0 ) )
                continue;
        }

        if ( lengthsquared( var_6 getentityvelocity() ) < 10 )
            continue;

        if ( var_6 damageconetrace( self.origin, self ) > 0 )
            break;
    }

    self stoploopsound( "ied_explo_beeps" );
    self playsound( "ied_warning" );
    explosivetrigger( var_6, var_1.detectiongraceperiod, "proxExplosive" );
    self notify( "detonateExplosive" );
}

proximityexplosiveempstun()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "emp_damage",  var_0, var_1  );
        equipmentempstunvfx();
        self._ID10146 = 1;
        self notify( "disabled" );
        proximityexplosivecleanup();
        wait(var_1);

        if ( isdefined( self ) )
        {
            self._ID10146 = undefined;
            self notify( "enabled" );
            var_2 = self getlinkedparent();
            thread _ID25126( var_2 );
        }
    }
}

proximityexplosivecleanup()
{
    _ID31835();

    if ( isdefined( self.damagearea ) )
    {
        self.damagearea delete();
        return;
    }
}

_ID28676( var_0, var_1 )
{
    self endon( "death" );
    wait 0.05;

    if ( level._ID32653 )
    {
        maps\mp\_entityheadicons::_ID28896( var_0, ( 0, 0, var_1 ) );
        return;
    }

    if ( isdefined( self.owner ) )
    {
        maps\mp\_entityheadicons::_ID28825( self.owner, ( 0, 0, var_1 ) );
        return;
    }

    return;
}

claymoreused( var_0 )
{
    if ( !isalive( self ) )
    {
        var_0 delete();
        return;
    }

    var_0 hide();
    var_0 common_scripts\utility::_ID35637( 0.05, "missile_stuck" );

    if ( !isdefined( self ) || !isalive( self ) )
    {
        var_0 delete();
        return;
    }

    var_1 = 60;
    var_2 = ( 0, 0, 4 );
    var_3 = distancesquared( self.origin, var_0.origin );
    var_4 = distancesquared( self geteye(), var_0.origin );
    var_3 += 600;
    var_5 = var_0 getlinkedparent();

    if ( isdefined( var_5 ) )
        var_0 unlink();

    if ( var_3 < var_4 )
    {
        if ( var_1 * var_1 < distancesquared( var_0.origin, self.origin ) )
        {
            var_6 = bullettrace( self.origin, self.origin - ( 0, 0, var_1 ), 0, self );

            if ( var_6["fraction"] == 1 )
            {
                var_0 delete();
                self setweaponammostock( var_0._ID36249, self getweaponammostock( var_0._ID36249 ) + 1 );
                return;
            }
            else
            {
                var_0.origin = var_6["position"];
                var_5 = var_6["entity"];
            }
        }
        else
        {

        }
    }
    else if ( var_1 * var_1 < distancesquared( var_0.origin, self geteye() ) )
    {
        var_6 = bullettrace( self.origin, self.origin - ( 0, 0, var_1 ), 0, self );

        if ( var_6["fraction"] == 1 )
        {
            var_0 delete();
            self setweaponammostock( var_0._ID36249, self getweaponammostock( var_0._ID36249 ) + 1 );
            return;
        }
        else
        {
            var_0.origin = var_6["position"];
            var_5 = var_6["entity"];
        }
    }
    else
    {
        var_2 = ( 0, 0, -5 );
        var_0.angles = var_0.angles + ( 0, 180, 0 );
    }

    var_0.angles = var_0.angles * ( 0, 1, 1 );
    var_0.origin = var_0.origin + var_2;
    var_0 explosivehandlemovers( var_5 );
    var_0 show();
    var_0 _ID20502();
    var_0 _ID20501();
    _ID22860( var_0 );
    var_0 thread ondetonateexplosive();
    var_0 thread c4damage();
    var_0 thread c4empdamage();
    var_0 thread claymoredetonation( var_5 );

    if ( !maps\mp\_utility::_ID18363() )
        var_0 thread _ID28676( self.pers["team"], 20 );

    self.changingweapon = undefined;
    level thread monitordisownedequipment( self, var_0 );
}

_ID12183( var_0, var_1 )
{
    if ( !maps\mp\_utility::_ID18363() )
    {
        self notify( "equipmentWatchUse" );
        self endon( "spawned_player" );
        self endon( "disconnect" );
        self endon( "equipmentWatchUse" );
        self.trigger setcursorhint( "HINT_NOICON" );

        switch ( self._ID36249 )
        {
            case "c4_mp":
                self.trigger sethintstring( &"MP_PICKUP_C4" );
                break;
            case "claymore_mp":
                self.trigger sethintstring( &"MP_PICKUP_CLAYMORE" );
                break;
            case "bouncingbetty_mp":
                self.trigger sethintstring( &"MP_PICKUP_BOUNCING_BETTY" );
                break;
            case "motion_sensor_mp":
                self.trigger sethintstring( &"MP_PICKUP_MOTION_SENSOR" );
                break;
            case "proximity_explosive_mp":
                self.trigger sethintstring( &"MP_PICKUP_PROXIMITY_EXPLOSIVE" );
                break;
        }

        self.trigger maps\mp\_utility::_ID28863( var_0 );
        self.trigger thread maps\mp\_utility::_ID22330( var_0 );

        if ( isdefined( var_1 ) && var_1 )
            thread _ID34635();

        for (;;)
        {
            self.trigger waittill( "trigger",  var_0  );
            var_0 playlocalsound( "scavenger_pack_pickup" );

            if ( isdefined( var_0.loadoutperkequipmentstowed ) && var_0.loadoutperkequipmentstowed == self._ID36249 )
                var_0.loadoutperkequipmentstowedammo++;
            else
                var_0 setweaponammostock( self._ID36249, var_0 getweaponammostock( self._ID36249 ) + 1 );

            deleteexplosive();
            self notify( "death" );
        }

        return;
    }
}

_ID34635()
{
    self endon( "death" );

    for (;;)
    {
        if ( isdefined( self ) && isdefined( self.trigger ) )
        {
            self.trigger.origin = self.origin + _ID15013();

            if ( isdefined( self.bombsquadmodel ) )
                self.bombsquadmodel.origin = self.origin;
        }
        else
            return;

        wait 0.05;
    }
}

claymoredetonation( var_0 )
{
    self endon( "death" );
    var_1 = spawn( "trigger_radius", self.origin + ( 0, 0, 0 - level.claymoredetonateradius ), 0, level.claymoredetonateradius, level.claymoredetonateradius * 2 );

    if ( isdefined( var_0 ) )
    {
        var_1 enablelinkto();
        var_1 linkto( var_0 );
    }

    thread deleteondeath( var_1 );

    for (;;)
    {
        var_1 waittill( "trigger",  var_2  );

        if ( getdvarint( "scr_claymoredebug" ) != 1 )
        {
            if ( isdefined( self.owner ) )
            {
                if ( var_2 == self.owner )
                    continue;

                if ( isdefined( var_2.owner ) && var_2.owner == self.owner )
                    continue;
            }

            if ( !_ID13695( self.owner, var_2, 0 ) )
                continue;
        }

        if ( lengthsquared( var_2 getentityvelocity() ) < 10 )
            continue;

        var_3 = abs( var_2.origin[2] - self.origin[2] );

        if ( var_3 > 128 )
            continue;

        if ( !var_2 _ID29852( self ) )
            continue;

        if ( var_2 damageconetrace( self.origin, self ) > 0 )
            break;
    }

    self playsound( "claymore_activated" );
    explosivetrigger( var_2, level._ID7336, "claymore" );

    if ( isdefined( self.owner ) && isdefined( level._ID19766 ) )
        self.owner thread [[ level._ID19766 ]]( "claymore_destroyed", undefined, undefined, self.origin );

    self notify( "detonateExplosive" );
}

_ID29852( var_0 )
{
    if ( isdefined( var_0._ID10146 ) )
        return 0;

    var_1 = self.origin + ( 0, 0, 32 );
    var_2 = var_1 - var_0.origin;
    var_3 = anglestoforward( var_0.angles );
    var_4 = vectordot( var_2, var_3 );

    if ( var_4 < level._ID7337 )
        return 0;

    var_2 = vectornormalize( var_2 );
    var_5 = vectordot( var_2, var_3 );
    return var_5 > level._ID7335;
}

deleteondeath( var_0 )
{
    self waittill( "death" );
    wait 0.05;

    if ( isdefined( var_0 ) )
    {
        if ( isdefined( var_0.trigger ) )
            var_0.trigger delete();

        var_0 delete();
        return;
    }
}

c4activate()
{
    self endon( "death" );
    self waittill( "missile_stuck",  var_0  );
    wait 0.05;
    self notify( "activated" );
    self.activated = 1;
}

_ID36045()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "detonated" );
    level endon( "game_ended" );
    var_0 = 0;

    for (;;)
    {
        if ( self usebuttonpressed() )
        {
            var_0 = 0;

            while ( self usebuttonpressed() )
            {
                var_0 += 0.05;
                wait 0.05;
            }

            if ( var_0 >= 0.5 )
                continue;

            var_0 = 0;

            while ( !self usebuttonpressed() && var_0 < 0.5 )
            {
                var_0 += 0.05;
                wait 0.05;
            }

            if ( var_0 >= 0.5 )
                continue;

            if ( !self._ID23708.size )
                return;

            self notify( "alt_detonate" );
        }

        wait 0.05;
    }
}

_ID36047()
{
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittillmatch( "detonate",  "c4_mp"  );
        _ID6387();
    }
}

_ID36046()
{
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "alt_detonate" );
        var_0 = self getcurrentweapon();

        if ( var_0 != "c4_mp" )
            _ID6387();
    }
}

_ID6387()
{
    foreach ( var_1 in self._ID23708 )
    {
        if ( isdefined( var_1 ) )
            var_1 thread _ID35534( 0.1 );
    }

    self._ID23708 = [];
    self notify( "detonated" );
}

_ID35534( var_0 )
{
    self endon( "death" );
    wait(var_0);
    _ID35765();
    self notify( "detonateExplosive" );
}

c4damage()
{
    self endon( "death" );
    self setcandamage( 1 );
    self.maxhealth = 100000;
    self.health = self.maxhealth;
    var_0 = undefined;

    for (;;)
    {
        self waittill( "damage",  var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( !isplayer( var_0 ) && !isagent( var_0 ) )
            continue;

        if ( !_ID13695( self.owner, var_0 ) )
            continue;

        if ( isdefined( var_9 ) )
        {
            switch ( var_9 )
            {
                case "flash_grenade_mp":
                case "smoke_grenade_mp":
                case "concussion_grenade_mp":
                    continue;
            }
        }

        break;
    }

    if ( level._ID6390 )
        wait(0.1 + randomfloat( 0.4 ));
    else
        wait 0.05;

    if ( !isdefined( self ) )
        return;

    level._ID6390 = 1;
    thread _ID26120();

    if ( isdefined( var_4 ) && ( issubstr( var_4, "MOD_GRENADE" ) || issubstr( var_4, "MOD_EXPLOSIVE" ) ) )
        self._ID35905 = 1;

    if ( isdefined( var_8 ) && var_8 & level.idflags_penetration )
        self._ID35910 = 1;

    self._ID35908 = 1;

    if ( isdefined( var_0 ) )
        self.damagedby = var_0;

    if ( isplayer( var_0 ) )
        var_0 maps\mp\gametypes\_damagefeedback::_ID34528( "c4" );

    if ( level._ID32653 )
    {
        if ( isdefined( var_0 ) && isdefined( self.owner ) )
        {
            var_10 = var_0.pers["team"];
            var_11 = self.owner.pers["team"];

            if ( isdefined( var_10 ) && isdefined( var_11 ) && var_10 != var_11 )
                var_0 notify( "destroyed_equipment" );
        }
    }
    else if ( isdefined( self.owner ) && isdefined( var_0 ) && var_0 != self.owner )
        var_0 notify( "destroyed_equipment" );

    self notify( "detonateExplosive",  var_0  );
}

_ID26120()
{
    wait 0.05;
    level._ID6390 = 0;
}

_ID27313( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < 60; var_2++ )
        wait 0.05;
}

_ID35765()
{
    if ( !isdefined( self._ID10146 ) )
        return;

    self waittill( "enabled" );
}

c4detectiontrigger( var_0 )
{
    self waittill( "activated" );
    var_1 = spawn( "trigger_radius", self.origin - ( 0, 0, 128 ), 0, 512, 256 );
    var_1.detectid = "trigger" + gettime() + randomint( 1000000 );
    var_1.owner = self;
    var_1 thread _ID9932( level._ID23070[var_0] );
    self waittill( "death" );
    var_1 notify( "end_detection" );

    if ( isdefined( var_1.bombsquadicon ) )
        var_1.bombsquadicon destroy();

    var_1 delete();
}

claymoredetectiontrigger( var_0 )
{
    var_1 = spawn( "trigger_radius", self.origin - ( 0, 0, 128 ), 0, 512, 256 );
    var_1.detectid = "trigger" + gettime() + randomint( 1000000 );
    var_1.owner = self;
    var_1 thread _ID9932( level._ID23070[var_0] );
    self waittill( "death" );
    var_1 notify( "end_detection" );

    if ( isdefined( var_1.bombsquadicon ) )
        var_1.bombsquadicon destroy();

    var_1 delete();
}

_ID9932( var_0 )
{
    self endon( "end_detection" );
    level endon( "game_ended" );

    while ( !level.gameended )
    {
        self waittill( "trigger",  var_1  );

        if ( !var_1.detectexplosives )
            continue;

        if ( level._ID32653 && var_1.team != var_0 )
            continue;
        else if ( !level._ID32653 && var_1 == self.owner.owner )
            continue;

        if ( isdefined( var_1._ID5468[self.detectid] ) )
            continue;

        var_1 thread _ID29970( self );
    }
}

monitordisownedequipment( var_0, var_1 )
{
    level endon( "game_ended" );
    var_1 endon( "death" );
    var_0 common_scripts\utility::_ID35626( "joined_team", "joined_spectators", "disconnect" );
    var_1 deleteexplosive();
}

_ID22860( var_0 )
{
    if ( self._ID23708.size )
    {
        self._ID23708 = common_scripts\utility::array_removeundefined( self._ID23708 );

        if ( self._ID23708.size >= level._ID20752 )
            self._ID23708[0] notify( "detonateExplosive" );
    }

    self._ID23708[self._ID23708.size] = var_0;
    var_1 = var_0 getentitynumber();
    level._ID21075[var_1] = var_0;
    level notify( "mine_planted" );
}

_ID22908( var_0 )
{
    if ( self._ID23709.size )
    {
        self._ID23709 = common_scripts\utility::array_removeundefined( self._ID23709 );

        if ( self._ID23709.size >= level._ID20752 )
            self._ID23709[0] notify( "detonateExplosive" );
    }

    self._ID23709[self._ID23709.size] = var_0;
    var_1 = var_0 getentitynumber();
    level._ID21075[var_1] = var_0;
    level notify( "mine_planted" );
}

disableplantedequipmentuse()
{
    if ( isdefined( self._ID23708 ) && self._ID23708.size > 0 )
    {
        foreach ( var_1 in self._ID23708 )
        {
            if ( isdefined( var_1.trigger ) && isdefined( var_1.owner ) )
                var_1.trigger disableplayeruse( var_1.owner );
        }
    }

    if ( isdefined( self._ID23709 ) && self._ID23709.size > 0 )
    {
        foreach ( var_1 in self._ID23709 )
        {
            if ( isdefined( var_1.trigger ) && isdefined( var_1.owner ) )
                var_1.trigger disableplayeruse( var_1.owner );
        }

        return;
    }
}

cleanupequipment( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_0 ) )
        level._ID21075[var_0] = undefined;

    if ( isdefined( var_1 ) )
        var_1 delete();

    if ( isdefined( var_2 ) )
        var_2 delete();

    if ( isdefined( var_3 ) )
    {
        var_3 delete();
        return;
    }
}

deleteexplosive()
{
    if ( isdefined( self ) )
    {
        var_0 = self getentitynumber();
        var_1 = self._ID19214;
        var_2 = self.trigger;
        var_3 = self.sensor;
        cleanupequipment( var_0, var_1, var_2, var_3 );
        self notify( "deleted_equipment" );
        self delete();
        return;
    }
}

ondetonateexplosive()
{
    self endon( "death" );
    level endon( "game_ended" );
    thread cleanupexplosivesondeath();
    self waittill( "detonateExplosive" );
    self detonate( self.owner );
}

cleanupexplosivesondeath()
{
    self endon( "deleted_equipment" );
    level endon( "game_ended" );
    var_0 = self getentitynumber();
    var_1 = self._ID19214;
    var_2 = self.trigger;
    var_3 = self.sensor;
    self waittill( "death" );
    cleanupequipment( var_0, var_1, var_2, var_3 );
}

_ID15013()
{
    var_0 = anglestoup( self.angles );
    return 10 * var_0;
}

_ID20502()
{
    if ( maps\mp\_utility::_ID18757( self.owner ) )
    {
        self setotherent( self.owner );
        self.trigger = spawn( "script_origin", self.origin + _ID15013() );
        self.trigger.owner = self;
        thread _ID12183( self.owner, 1 );
        return;
    }
}

_ID20501( var_0 )
{
    common_scripts\utility::_ID20489( self.owner.team );

    if ( !isdefined( var_0 ) || !var_0 )
        self makeentitynomeleetarget();

    if ( issentient( self ) )
    {
        self setthreatbiasgroup( "DogsDontAttack" );
        return;
    }
}

explosivehandlemovers( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2.linkparent = var_0;
    var_2.deathoverridecallback = ::_ID21728;
    var_2.endonstring = "death";

    if ( !isdefined( var_1 ) || !var_1 )
        var_2._ID18321 = maps\mp\_movers::moving_platform_empty_func;

    thread maps\mp\_movers::_ID16165( var_2 );
}

explosivetrigger( var_0, var_1, var_2 )
{
    if ( isplayer( var_0 ) && var_0 maps\mp\_utility::_hasperk( "specialty_delaymine" ) )
    {
        var_0 notify( "triggeredExpl",  var_2  );
        var_1 = level._ID9515;
    }

    wait(var_1);
}

_ID29164()
{
    self._ID5468 = [];

    if ( self.detectexplosives && !self.bombsquadicons.size )
    {
        for ( var_0 = 0; var_0 < 4; var_0++ )
        {
            self.bombsquadicons[var_0] = newclienthudelem( self );
            self.bombsquadicons[var_0].x = 0;
            self.bombsquadicons[var_0].y = 0;
            self.bombsquadicons[var_0].z = 0;
            self.bombsquadicons[var_0].alpha = 0;
            self.bombsquadicons[var_0].archived = 1;
            self.bombsquadicons[var_0] setshader( "waypoint_bombsquad", 14, 14 );
            self.bombsquadicons[var_0] setwaypoint( 0, 0 );
            self.bombsquadicons[var_0].detectid = "";
        }

        return;
    }

    if ( !self.detectexplosives )
    {
        for ( var_0 = 0; var_0 < self.bombsquadicons.size; var_0++ )
            self.bombsquadicons[var_0] destroy();

        self.bombsquadicons = [];
        return;
    }

    return;
}

_ID29970( var_0 )
{
    var_1 = var_0.detectid;
    var_2 = -1;

    for ( var_3 = 0; var_3 < 4; var_3++ )
    {
        var_4 = self.bombsquadicons[var_3].detectid;

        if ( var_4 == var_1 )
            return;

        if ( var_4 == "" )
            var_2 = var_3;
    }

    if ( var_2 < 0 )
        return;

    self._ID5468[var_1] = 1;
    self.bombsquadicons[var_2].x = var_0.origin[0];
    self.bombsquadicons[var_2].y = var_0.origin[1];
    self.bombsquadicons[var_2].z = var_0.origin[2] + 24 + 128;
    self.bombsquadicons[var_2] fadeovertime( 0.25 );
    self.bombsquadicons[var_2].alpha = 1;
    self.bombsquadicons[var_2].detectid = var_0.detectid;

    while ( isalive( self ) && isdefined( var_0 ) && self istouching( var_0 ) )
        wait 0.05;

    if ( !isdefined( self ) )
        return;

    self.bombsquadicons[var_2].detectid = "";
    self.bombsquadicons[var_2] fadeovertime( 0.25 );
    self.bombsquadicons[var_2].alpha = 0;
    self._ID5468[var_1] = undefined;
}

_ID14960( var_0, var_1, var_2, var_3 )
{
    var_4 = [];

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    var_5 = var_1 * var_1;
    var_6 = level.players;

    for ( var_7 = 0; var_7 < var_6.size; var_7++ )
    {
        if ( !isalive( var_6[var_7] ) || var_6[var_7].sessionstate != "playing" )
            continue;

        var_8 = maps\mp\_utility::_ID14407( var_6[var_7] );
        var_9 = distancesquared( var_0, var_8 );

        if ( var_9 < var_5 && ( !var_2 || _ID36260( var_0, var_8, var_3, var_6[var_7] ) ) )
            var_4[var_4.size] = maps\mp\_utility::get_damageable_player( var_6[var_7], var_8 );
    }

    var_10 = getentarray( "grenade", "classname" );

    for ( var_7 = 0; var_7 < var_10.size; var_7++ )
    {
        var_11 = maps\mp\_utility::_ID14404( var_10[var_7] );
        var_9 = distancesquared( var_0, var_11 );

        if ( var_9 < var_5 && ( !var_2 || _ID36260( var_0, var_11, var_3, var_10[var_7] ) ) )
            var_4[var_4.size] = maps\mp\_utility::_ID14403( var_10[var_7], var_11 );
    }

    var_12 = getentarray( "destructible", "targetname" );

    for ( var_7 = 0; var_7 < var_12.size; var_7++ )
    {
        var_11 = var_12[var_7].origin;
        var_9 = distancesquared( var_0, var_11 );

        if ( var_9 < var_5 && ( !var_2 || _ID36260( var_0, var_11, var_3, var_12[var_7] ) ) )
        {
            var_13 = spawnstruct();
            var_13._ID18738 = 0;
            var_13._ID18531 = 0;
            var_13.entity = var_12[var_7];
            var_13._ID8961 = var_11;
            var_4[var_4.size] = var_13;
        }
    }

    var_14 = getentarray( "destructable", "targetname" );

    for ( var_7 = 0; var_7 < var_14.size; var_7++ )
    {
        var_11 = var_14[var_7].origin;
        var_9 = distancesquared( var_0, var_11 );

        if ( var_9 < var_5 && ( !var_2 || _ID36260( var_0, var_11, var_3, var_14[var_7] ) ) )
        {
            var_13 = spawnstruct();
            var_13._ID18738 = 0;
            var_13._ID18531 = 1;
            var_13.entity = var_14[var_7];
            var_13._ID8961 = var_11;
            var_4[var_4.size] = var_13;
        }
    }

    var_15 = getentarray( "misc_turret", "classname" );

    foreach ( var_17 in var_15 )
    {
        var_11 = var_17.origin + ( 0, 0, 32 );
        var_9 = distancesquared( var_0, var_11 );

        if ( var_9 < var_5 && ( !var_2 || _ID36260( var_0, var_11, var_3, var_17 ) ) )
        {
            switch ( var_17.model )
            {
                case "sentry_minigun_weak":
                case "mp_sam_turret":
                case "mp_scramble_turret":
                case "mp_remote_turret":
                case "vehicle_ugv_talon_gun_mp":
                    var_4[var_4.size] = maps\mp\_utility::_ID14408( var_17, var_11 );
                    continue;
            }
        }
    }

    var_19 = getentarray( "script_model", "classname" );

    foreach ( var_21 in var_19 )
    {
        if ( var_21.model != "projectile_bouncing_betty_grenade" && var_21.model != "ims_scorpion_body" )
            continue;

        var_11 = var_21.origin + ( 0, 0, 32 );
        var_9 = distancesquared( var_0, var_11 );

        if ( var_9 < var_5 && ( !var_2 || _ID36260( var_0, var_11, var_3, var_21 ) ) )
            var_4[var_4.size] = maps\mp\_utility::get_damageable_mine( var_21, var_11 );
    }

    return var_4;
}

getempdamageents( var_0, var_1, var_2, var_3 )
{
    var_4 = [];

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    var_5 = var_1 * var_1;
    level._ID21075 = common_scripts\utility::array_removeundefined( level._ID21075 );

    foreach ( var_7 in level._ID21075 )
    {
        if ( empcandamage( var_7, var_0, var_5, var_2, var_3 ) )
            var_4[var_4.size] = var_7;
    }

    var_9 = getentarray( "misc_turret", "classname" );

    foreach ( var_7 in var_9 )
    {
        if ( empcandamage( var_7, var_0, var_5, var_2, var_3 ) )
            var_4[var_4.size] = var_7;
    }

    foreach ( var_7 in level._ID34657 )
    {
        if ( empcandamage( var_7, var_0, var_5, var_2, var_3 ) )
            var_4[var_4.size] = var_7;
    }

    foreach ( var_7 in level._ID25810 )
    {
        if ( empcandamage( var_7, var_0, var_5, var_2, var_3 ) )
            var_4[var_4.size] = var_7;
    }

    foreach ( var_7 in level.balldrones )
    {
        if ( empcandamage( var_7, var_0, var_5, var_2, var_3 ) )
            var_4[var_4.size] = var_7;
    }

    foreach ( var_7 in level.placedims )
    {
        if ( empcandamage( var_7, var_0, var_5, var_2, var_3 ) )
            var_4[var_4.size] = var_7;
    }

    foreach ( var_7 in level.players )
    {
        if ( empcandamage( var_7, var_0, var_5, var_2, var_3 ) )
            var_4[var_4.size] = var_7;
    }

    return var_4;
}

empcandamage( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = var_0.origin;
    var_6 = distancesquared( var_1, var_5 );
    return var_6 < var_2 && ( !var_3 || _ID36260( var_1, var_5, var_4, var_0 ) );
}

_ID36260( var_0, var_1, var_2, var_3 )
{
    var_4 = undefined;
    var_5 = var_1 - var_0;

    if ( lengthsquared( var_5 ) < var_2 * var_2 )
        return 1;

    var_6 = vectornormalize( var_5 );
    var_4 = var_0 + ( var_6[0] * var_2, var_6[1] * var_2, var_6[2] * var_2 );
    var_7 = bullettrace( var_4, var_1, 0, var_3 );

    if ( getdvarint( "scr_damage_debug" ) != 0 || getdvarint( "scr_debugMines" ) != 0 )
    {
        thread _ID9257( var_0, ".dmg" );

        if ( isdefined( var_3 ) )
            thread _ID9257( var_1, "." + var_3.classname );
        else
            thread _ID9257( var_1, ".undefined" );

        if ( var_7["fraction"] == 1 )
            thread _ID9250( var_4, var_1, ( 1, 1, 1 ) );
        else
        {
            thread _ID9250( var_4, var_7["position"], ( 1, 0.9, 0.8 ) );
            thread _ID9250( var_7["position"], var_1, ( 1, 0.4, 0.3 ) );
        }
    }

    return var_7["fraction"] == 1;
}

_ID8966( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( self._ID18738 )
    {
        self.damageorigin = var_5;
        self.entity thread [[ level.callbackplayerdamage ]]( var_0, var_1, var_2, 0, var_3, var_4, var_5, var_6, "none", 0 );
        return;
    }

    if ( self._ID18531 && ( var_4 == "artillery_mp" || var_4 == "claymore_mp" || var_4 == "stealth_bomb_mp" || var_4 == "alienclaymore_mp" ) )
        return;

    self.entity notify( "damage",  var_2, var_1, ( 0, 0, 0 ), ( 0, 0, 0 ), "MOD_EXPLOSIVE", "", "", "", undefined, var_4  );
    return;
}

_ID9250( var_0, var_1, var_2 )
{
    for ( var_3 = 0; var_3 < 600; var_3++ )
        wait 0.05;
}

debugcircle( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 16;

    var_4 = 360 / var_3;
    var_5 = [];

    for ( var_6 = 0; var_6 < var_3; var_6++ )
    {
        var_7 = var_4 * var_6;
        var_8 = cos( var_7 ) * var_1;
        var_9 = sin( var_7 ) * var_1;
        var_10 = var_0[0] + var_8;
        var_11 = var_0[1] + var_9;
        var_12 = var_0[2];
        var_5[var_5.size] = ( var_10, var_11, var_12 );
    }

    for ( var_6 = 0; var_6 < var_5.size; var_6++ )
    {
        var_13 = var_5[var_6];

        if ( var_6 + 1 >= var_5.size )
            var_14 = var_5[0];
        else
            var_14 = var_5[var_6 + 1];

        thread _ID9250( var_13, var_14, var_2 );
    }
}

_ID9257( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < 600; var_2++ )
        wait 0.05;
}

onweapondamage( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );
    self endon( "disconnect" );

    switch ( var_1 )
    {
        case "concussion_grenade_mp":
            if ( !isdefined( var_0 ) )
                return;
            else if ( var_2 == "MOD_IMPACT" )
                return;

            var_5 = 1;

            if ( isdefined( var_0.owner ) && var_0.owner == var_4 )
                var_5 = 0;

            var_6 = 512;
            var_7 = 1 - distance( self.origin, var_0.origin ) / var_6;

            if ( var_7 < 0 )
                var_7 = 0;

            var_8 = 2 + 4 * var_7;
            var_8 = maps\mp\perks\_perkfunctions::applystunresistence( var_8 );
            wait 0.05;
            var_4 notify( "stun_hit" );
            self notify( "concussed",  var_4  );

            if ( var_4 != self )
                var_4 maps\mp\gametypes\_missions::_ID25038( "ch_alittleconcussed" );

            self shellshock( "concussion_grenade_mp", var_8 );
            self._ID7852 = gettime() + var_8 * 1000;

            if ( var_5 )
                var_4 thread maps\mp\gametypes\_damagefeedback::_ID34528( "stun" );

            break;
        case "weapon_cobra_mk19_mp":
            break;
        default:
            maps\mp\gametypes\_shellshock::_ID29694( var_2, var_3 );
            break;
    }
}

isprimaryweapon( var_0 )
{
    if ( var_0 == "none" )
        return 0;

    if ( weaponinventorytype( var_0 ) != "primary" )
        return 0;

    switch ( weaponclass( var_0 ) )
    {
        case "spread":
        case "rocketlauncher":
        case "sniper":
        case "rifle":
        case "pistol":
        case "mg":
        case "smg":
            return 1;
        default:
            return 0;
    }
}

isbulletweapon( var_0 )
{
    if ( var_0 == "none" || _ID18766( var_0 ) || isknifeonly( var_0 ) )
        return 0;

    switch ( weaponclass( var_0 ) )
    {
        case "spread":
        case "sniper":
        case "rifle":
        case "pistol":
        case "mg":
        case "smg":
            return 1;
        default:
            return 0;
    }
}

isknifeonly( var_0 )
{
    return issubstr( var_0, "knifeonly" );
}

_ID18545( var_0 )
{
    if ( var_0 == "none" )
        return 0;

    return weaponinventorytype( var_0 ) == "altmode";
}

_ID18663( var_0 )
{
    if ( var_0 == "none" )
        return 0;

    return weaponinventorytype( var_0 ) == "item";
}

_ID18766( var_0 )
{
    if ( var_0 == "none" )
        return 0;

    return weapontype( var_0 ) == "riotshield";
}

isoffhandweapon( var_0 )
{
    if ( var_0 == "none" )
        return 0;

    return weaponinventorytype( var_0 ) == "offhand";
}

issidearm( var_0 )
{
    if ( var_0 == "none" )
        return 0;

    if ( weaponinventorytype( var_0 ) != "primary" )
        return 0;

    return weaponclass( var_0 ) == "pistol";
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

isthrowingknife( var_0 )
{
    if ( var_0 == "none" )
        return 0;

    return issubstr( var_0, "throwingknife" );
}

isrocketlauncher( var_0 )
{
    return var_0 == "iw6_panzerfaust3_mp" || var_0 == "iw6_maaws_mp";
}

updatesavedlastweapon()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    var_0 = self._ID8715;

    if ( isdefined( self._ID27301 ) )
        var_0 = self._ID27301;

    self._ID27300 = var_0;

    for (;;)
    {
        self waittill( "weapon_change",  var_1  );

        if ( var_1 == "none" )
        {
            self._ID27300 = var_0;
            continue;
        }

        var_2 = weaponinventorytype( var_1 );

        if ( var_2 != "primary" && var_2 != "altmode" )
        {
            self._ID27300 = var_0;
            continue;
        }

        _ID34567();
        self._ID27300 = var_0;
        var_0 = var_1;
    }
}

_ID11399( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    thread clearempondeath();
}

clearempondeath()
{
    self endon( "disconnect" );
    self waittill( "death" );
}

_ID15483()
{
    var_0 = 1000;
    self._ID36267 = self getweaponslistprimaries();

    if ( self._ID36267.size )
    {
        foreach ( var_2 in self._ID36267 )
        {
            var_3 = _ID15491( var_2 );

            if ( var_3 == 0 )
                continue;

            if ( var_3 < var_0 )
                var_0 = var_3;
        }
    }
    else
        var_0 = 8;

    var_0 = _ID7321( var_0 );
    return var_0;
}

_ID15491( var_0 )
{
    var_1 = undefined;
    var_2 = maps\mp\_utility::_ID14903( var_0 );

    if ( maps\mp\_utility::_ID18363() )
        var_1 = float( tablelookup( "mp/alien/mode_string_tables/alien_statstable.csv", 4, var_2, 8 ) );
    else
        var_1 = float( tablelookup( "mp/statstable.csv", 4, var_2, 8 ) );

    return var_1;
}

_ID7321( var_0 )
{
    return clamp( var_0, 0.0, 11.0 );
}

_ID34567()
{
    var_0 = undefined;
    self._ID36267 = self getweaponslistprimaries();

    if ( !self._ID36267.size )
        var_0 = 8;
    else
    {
        var_1 = self getcurrentweapon();
        var_2 = weaponinventorytype( var_1 );

        if ( var_2 != "primary" && var_2 != "altmode" )
        {
            if ( isdefined( self._ID27300 ) )
                var_1 = self._ID27300;
            else
                var_1 = undefined;
        }

        if ( !isdefined( var_1 ) || !self hasweapon( var_1 ) )
            var_0 = _ID15483();
        else
        {
            var_0 = _ID15491( var_1 );
            var_0 = _ID7321( var_0 );
        }
    }

    var_3 = var_0 / 10;
    self.weaponspeed = var_3;

    if ( !isdefined( self.combatspeedscalar ) )
        self.combatspeedscalar = 1;

    self setmovespeedscale( var_3 * self._ID21667 * self.combatspeedscalar );
}

_ID31172()
{
    if ( !isplayer( self ) )
        return;

    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self notifyonplayercommand( "adjustedStance", "+stance" );
    self notifyonplayercommand( "adjustedStance", "+goStand" );

    if ( !level.console && !isai( self ) )
    {
        self notifyonplayercommand( "adjustedStance", "+togglecrouch" );
        self notifyonplayercommand( "adjustedStance", "toggleprone" );
        self notifyonplayercommand( "adjustedStance", "+movedown" );
        self notifyonplayercommand( "adjustedStance", "-movedown" );
        self notifyonplayercommand( "adjustedStance", "+prone" );
        self notifyonplayercommand( "adjustedStance", "-prone" );
    }

    for (;;)
    {
        common_scripts\utility::_ID35626( "adjustedStance", "sprint_begin", "weapon_change" );
        wait 0.5;

        if ( isdefined( self._ID22850 ) && self._ID22850 )
            continue;

        var_0 = self getstance();
        stancerecoilupdate( var_0 );
    }
}

stancerecoilupdate( var_0 )
{
    var_1 = self getcurrentprimaryweapon();
    var_2 = 0;

    if ( isrecoilreducingweapon( var_1 ) )
        var_2 = getrecoilreductionvalue();

    if ( var_0 == "prone" )
    {
        var_3 = maps\mp\_utility::getweaponclass( var_1 );

        if ( var_3 == "weapon_lmg" )
        {
            maps\mp\_utility::_ID28849( 0, 40 );
            return;
        }

        if ( var_3 == "weapon_sniper" )
        {
            if ( issubstr( var_1, "barrelbored" ) )
            {
                maps\mp\_utility::_ID28849( 0, 20 + var_2 );
                return;
            }

            maps\mp\_utility::_ID28849( 0, 40 + var_2 );
            return;
            return;
        }

        maps\mp\_utility::_ID28849();
        return;
        return;
        return;
    }

    if ( var_0 == "crouch" )
    {
        var_3 = maps\mp\_utility::getweaponclass( var_1 );

        if ( var_3 == "weapon_lmg" )
        {
            maps\mp\_utility::_ID28849( 0, 10 );
            return;
        }

        if ( var_3 == "weapon_sniper" )
        {
            if ( issubstr( var_1, "barrelbored" ) )
            {
                maps\mp\_utility::_ID28849( 0, 10 + var_2 );
                return;
            }

            maps\mp\_utility::_ID28849( 0, 20 + var_2 );
            return;
            return;
        }

        maps\mp\_utility::_ID28849();
        return;
        return;
        return;
    }

    if ( var_2 > 0 )
    {
        maps\mp\_utility::_ID28849( 0, var_2 );
        return;
    }

    maps\mp\_utility::_ID28849();
    return;
    return;
    return;
}

_ID6252( var_0 )
{
    var_1 = maps\mp\_utility::getattachmentlistbasenames();
    var_1 = common_scripts\utility::alphabetize( var_1 );
    var_2 = 149;
    var_3 = [];
    var_4 = "mp/statstable.csv";
    var_5 = getdvar( "g_gametype" );

    if ( var_5 == "aliens" )
        var_4 = "mp/alien/mode_string_tables/alien_statstable.csv";

    for ( var_6 = 0; var_6 <= var_2; var_6++ )
    {
        var_7 = tablelookup( var_4, 0, var_6, 4 );

        if ( var_7 == "" )
            continue;

        var_8 = var_7 + "_mp";

        if ( !issubstr( tablelookup( var_4, 0, var_6, 2 ), "weapon_" ) )
            continue;

        if ( weaponinventorytype( var_8 ) != "primary" )
            continue;

        var_9 = spawnstruct();
        var_9.basename = var_7;
        var_9.assetname = var_8;
        var_9._ID34905 = [];
        var_9._ID34905[0] = var_8;
        var_10 = [];

        for ( var_11 = 0; var_11 < 6; var_11++ )
        {
            var_12 = tablelookup( var_4, 0, var_6, var_11 + 11 );

            if ( var_0 )
            {
                switch ( var_12 )
                {
                    case "fmj":
                    case "rof":
                    case "xmags":
                        continue;
                }
            }

            if ( var_12 == "" )
                break;

            var_10[var_12] = 1;
        }

        var_13 = [];

        foreach ( var_12 in var_1 )
        {
            if ( !isdefined( var_10[var_12] ) )
                continue;

            var_9._ID34905[var_9._ID34905.size] = var_7 + "_" + var_12 + "_mp";
            var_13[var_13.size] = var_12;
        }

        for ( var_16 = 0; var_16 < var_13.size - 1; var_16++ )
        {
            var_17 = tablelookuprownum( "mp/attachmentCombos.csv", 0, var_13[var_16] );

            for ( var_18 = var_16 + 1; var_18 < var_13.size; var_18++ )
            {
                if ( tablelookup( "mp/attachmentCombos.csv", 0, var_13[var_18], var_17 ) == "no" )
                    continue;

                var_9._ID34905[var_9._ID34905.size] = var_7 + "_" + var_13[var_16] + "_" + var_13[var_18] + "_mp";
            }
        }

        var_3[var_7] = var_9;
    }

    return var_3;
}

monitormk32semtexlauncher()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "faux_spawn" );

    for (;;)
    {
        var_0 = maps\mp\_utility::_ID35688();

        if ( isdefined( var_0._ID36249 ) && var_0._ID36249 == "iw6_mk32_mp" )
            _ID28046( var_0 );
    }
}

_ID28046( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_0._ID36249 ) )
        return;

    if ( !issubstr( var_0._ID36249, "semtex" ) && var_0._ID36249 != "iw6_mk32_mp" )
        return;

    var_0._ID23036 = self;
    var_0 waittill( "missile_stuck",  var_1  );
    var_0 thread maps\mp\gametypes\_shellshock::_ID15783();

    if ( isplayer( var_1 ) || isagent( var_1 ) )
    {
        if ( !isdefined( self ) )
        {
            var_0.stuckenemyentity = var_1;
            var_1.stuckbygrenade = var_0;
        }
        else if ( level._ID32653 && isdefined( var_1.team ) && var_1.team == self.team )
            var_0._ID18802 = "friendly";
        else
        {
            var_0._ID18802 = "enemy";
            var_0.stuckenemyentity = var_1;

            if ( isplayer( var_1 ) )
                var_1 maps\mp\gametypes\_hud_message::_ID24474( "semtex_stuck", self );

            thread maps\mp\gametypes\_hud_message::_ID31052( "stuck_semtex", 100 );
            var_1.stuckbygrenade = var_0;
        }
    }

    var_0 explosivehandlemovers( undefined );
}

_ID34034()
{
    for (;;)
    {
        self waittill( "trigger",  var_0  );
        thread _ID34044( var_0 );
    }
}

_ID34044( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_0 notify( "weapon_change",  "none"  );
    self waittill( "turret_deactivate" );
    var_0 notify( "weapon_change",  var_0 getcurrentweapon()  );
}

_ID30894( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = ( 0, randomfloat( 360 ), 0 );

    var_4 = level._ID36259[var_2];
    var_5 = spawn( "script_model", var_0 );
    var_5.angles = var_3;
    var_5 setmodel( var_4.model );
    var_5.owner = var_1;
    var_5 setotherent( var_1 );
    var_5._ID36249 = var_2;
    var_5.config = var_4;
    var_5._ID19217 = ( 0, 0, 4 );
    var_5._ID19214 = spawn( "script_model", var_5.origin + var_5._ID19217 );
    var_5._ID19214 setscriptmoverkillcam( "explosive" );
    var_1 _ID22860( var_5 );
    var_5 thread createbombsquadmodel( var_4.bombsquadmodel, "tag_origin", var_1 );

    if ( isdefined( var_4.mine_beacon ) )
        var_5 thread doblinkinglight( "tag_fx", var_4.mine_beacon["friendly"], var_4.mine_beacon["enemy"] );

    if ( !maps\mp\_utility::_ID18363() )
        var_5 thread _ID28676( var_1.pers["team"], var_4._ID16454 );

    var_6 = undefined;

    if ( self != level )
        var_6 = self getlinkedparent();

    var_5 explosivehandlemovers( var_6 );
    var_5 thread mineproximitytrigger( var_6 );
    var_5 thread maps\mp\gametypes\_shellshock::_ID15783();
    var_5 _ID20501( 1 );

    if ( maps\mp\_utility::_ID18363() && issentient( var_5 ) )
    {
        var_5 setthreatbiasgroup( "deployable_ammo" );
        var_5.threatbias = -10000;
    }

    var_5 thread _ID21069();
    level thread monitordisownedequipment( var_1, var_5 );
    return var_5;
}

_ID30896( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = ( 0, randomfloat( 360 ), 0 );

    var_4 = level._ID36259[var_2];
    var_5 = spawn( "script_model", var_0 );
    var_5.angles = var_3;
    var_5 setmodel( var_4.model );
    var_5.owner = var_1;
    var_5 setotherent( var_1 );
    var_5._ID36249 = var_2;
    var_5.config = var_4;
    var_1 _ID22908( var_5 );
    var_5 thread createbombsquadmodel( var_4.bombsquadmodel, "tag_origin", var_1 );
    var_5 thread _ID28676( var_1.pers["team"], var_4._ID16454 );
    var_6 = undefined;

    if ( self != level )
        var_6 = self getlinkedparent();

    var_5 explosivehandlemovers( var_6, 1 );
    var_5 thread mineproximitytrigger( var_6 );
    var_5 thread maps\mp\gametypes\_shellshock::_ID15783();
    var_5 thread motionsensorempdamage();
    var_5 _ID20501( 0 );
    var_5 thread _ID21081();
    level thread monitordisownedequipment( var_1, var_5 );
    return var_5;
}

minedamagemonitor()
{
    self endon( "mine_triggered" );
    self endon( "mine_selfdestruct" );
    self endon( "death" );
    self setcandamage( 1 );
    self.maxhealth = 100000;
    self.health = self.maxhealth;
    var_0 = undefined;

    for (;;)
    {
        self waittill( "damage",  var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( maps\mp\_utility::_ID18363() && is_hive_explosion( var_0, var_4 ) )
            break;

        if ( !isplayer( var_0 ) && !isagent( var_0 ) )
            continue;

        if ( isdefined( var_9 ) && isendstr( var_9, "betty_mp" ) )
            continue;

        if ( !_ID13695( self.owner, var_0 ) )
            continue;

        if ( isdefined( var_9 ) )
        {
            switch ( var_9 )
            {
                case "flash_grenade_mp":
                case "smoke_grenade_mp":
                case "smoke_grenadejugg_mp":
                case "concussion_grenade_mp":
                    continue;
            }
        }

        break;
    }

    self notify( "mine_destroyed" );

    if ( isdefined( var_4 ) && ( issubstr( var_4, "MOD_GRENADE" ) || issubstr( var_4, "MOD_EXPLOSIVE" ) ) )
        self._ID35905 = 1;

    if ( isdefined( var_8 ) && var_8 & level.idflags_penetration )
        self._ID35910 = 1;

    self._ID35908 = 1;

    if ( isdefined( var_0 ) )
        self.damagedby = var_0;

    if ( isplayer( var_0 ) )
        var_0 maps\mp\gametypes\_damagefeedback::_ID34528( "bouncing_betty" );

    if ( !maps\mp\_utility::_ID18363() )
    {
        if ( level._ID32653 )
        {
            if ( isdefined( var_0 ) && isdefined( var_0.pers["team"] ) && isdefined( self.owner ) && isdefined( self.owner.pers["team"] ) )
            {
                if ( var_0.pers["team"] != self.owner.pers["team"] )
                    var_0 notify( "destroyed_equipment" );
            }
        }
        else if ( isdefined( self.owner ) && isdefined( var_0 ) && var_0 != self.owner )
            var_0 notify( "destroyed_equipment" );
    }

    self notify( "detonateExplosive",  var_0  );
}

is_hive_explosion( var_0, var_1 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_0.classname ) )
        return 0;

    return var_0.classname == "scriptable" && var_1 == "MOD_EXPLOSIVE";
}

mineproximitytrigger( var_0 )
{
    self endon( "mine_destroyed" );
    self endon( "mine_selfdestruct" );
    self endon( "death" );
    self endon( "disabled" );
    var_1 = self.config;
    wait(var_1.armtime);

    if ( isdefined( var_1.mine_beacon ) )
        thread doblinkinglight( "tag_fx", var_1.mine_beacon["friendly"], var_1.mine_beacon["enemy"] );

    var_2 = spawn( "trigger_radius", self.origin, 0, level.minedetectionradius, level.minedetectionheight );
    var_2.owner = self;
    thread _ID21065( var_2 );

    if ( isdefined( var_0 ) )
    {
        var_2 enablelinkto();
        var_2 linkto( var_0 );
    }

    self.damagearea = var_2;
    var_3 = undefined;

    for (;;)
    {
        var_2 waittill( "trigger",  var_3  );

        if ( !isdefined( var_3 ) )
            continue;

        if ( getdvarint( "scr_minesKillOwner" ) != 1 )
        {
            if ( isdefined( self.owner ) )
            {
                if ( var_3 == self.owner )
                    continue;

                if ( isdefined( var_3.owner ) && var_3.owner == self.owner )
                    continue;
            }

            if ( !_ID13695( self.owner, var_3, 0 ) )
                continue;
        }

        if ( lengthsquared( var_3 getentityvelocity() ) < 10 )
            continue;

        if ( var_3 damageconetrace( self.origin, self ) > 0 )
            break;
    }

    self notify( "mine_triggered" );
    self playsound( self.config.ontriggeredsfx );
    explosivetrigger( var_3, level._ID21066, "mine" );
    self thread [[ self.config._ID22914 ]]();
}

_ID21065( var_0 )
{
    common_scripts\utility::_ID35626( "mine_triggered", "mine_destroyed", "mine_selfdestruct", "death" );

    if ( isdefined( var_0 ) )
    {
        var_0 delete();
        return;
    }
}

motionsensorempdamage()
{
    self endon( "mine_triggered" );
    self endon( "death" );

    for (;;)
    {
        self waittill( "emp_damage",  var_0, var_1  );
        equipmentempstunvfx();
        _ID31835();

        if ( isdefined( self.damagearea ) )
            self.damagearea delete();

        self._ID10146 = 1;
        self notify( "disabled" );
        wait(var_1);

        if ( isdefined( self ) )
        {
            self._ID10146 = undefined;
            self notify( "enabled" );
            var_2 = self getlinkedparent();
            thread mineproximitytrigger( var_2 );
        }
    }
}

_ID21078()
{
    self endon( "mine_triggered" );
    self endon( "mine_destroyed" );
    self endon( "death" );
    wait(level.mineselfdestructtime + randomfloat( 0.4 ));
    self notify( "mine_selfdestruct" );
    self notify( "detonateExplosive" );
}

_ID21057()
{
    self playsound( self.config._ID22859 );
    playfx( level._ID21052, self.origin );

    if ( isdefined( self.trigger ) )
        self.trigger delete();

    var_0 = self.origin + ( 0, 0, 64 );
    self moveto( var_0, 0.7, 0, 0.65 );
    self._ID19214 moveto( var_0 + self._ID19217, 0.7, 0, 0.65 );
    self rotatevelocity( ( 0, 750, 32 ), 0.7, 0, 0.65 );
    thread _ID24649();
    wait 0.65;
    self notify( "detonateExplosive" );
}

_ID21069()
{
    self endon( "death" );
    level endon( "game_ended" );
    self waittill( "detonateExplosive",  var_0  );

    if ( !isdefined( self ) || !isdefined( self.owner ) )
        return;

    if ( !isdefined( var_0 ) )
        var_0 = self.owner;

    self playsound( self.config._ID22837 );
    var_1 = self gettagorigin( "tag_fx" );
    playfx( level.mine_explode, var_1 );
    self notify( "explode",  var_1  );
    wait 0.05;

    if ( !isdefined( self ) || !isdefined( self.owner ) )
        return;

    self hide();
    self radiusdamage( self.origin, level.minedamageradius, level._ID21061, level.minedamagemin, var_0, "MOD_EXPLOSIVE", self._ID36249 );

    if ( isdefined( self.owner ) && isdefined( level._ID19766 ) )
        self.owner thread [[ level._ID19766 ]]( "mine_destroyed", undefined, undefined, self.origin );

    wait 0.2;
    deleteexplosive();
}

_ID21080()
{
    self playsound( self.config._ID22859 );
    playfx( self.config._ID19717, self.origin );

    if ( isdefined( self.trigger ) )
        self.trigger delete();

    self hidepart( "tag_sensor" );
    _ID31835();
    var_0 = spawn( "script_model", self.origin );
    var_0.angles = self.angles;
    var_0 setmodel( self.config.model );
    var_0 hidepart( "tag_base" );
    var_0.config = self.config;
    self.sensor = var_0;
    var_1 = self.origin + ( 0, 0, self.config._ID19710 );
    var_2 = self.config.launchtime;
    var_3 = self.config.launchtime + 0.1;
    var_0 moveto( var_1, var_3, 0, var_2 );
    var_0 rotatevelocity( ( 0, 1100, 32 ), var_3, 0, var_2 );
    var_0 thread _ID24649();
    wait(var_2);
    self notify( "detonateExplosive" );
}

_ID21081()
{
    self endon( "death" );
    level endon( "game_ended" );
    self waittill( "detonateExplosive",  var_0  );

    if ( !isdefined( self ) || !isdefined( self.owner ) )
        return;

    if ( !isdefined( var_0 ) )
        var_0 = self.owner;

    self playsound( self.config._ID22837 );
    var_1 = undefined;

    if ( isdefined( self.sensor ) )
        var_1 = self.sensor gettagorigin( "tag_sensor" );
    else
        var_1 = self gettagorigin( "tag_origin" );

    playfx( self.config._ID22838, var_1 );
    common_scripts\utility::_ID35582();

    if ( !isdefined( self ) || !isdefined( self.owner ) )
        return;

    if ( isdefined( self.sensor ) )
        self.sensor delete();
    else
        self hidepart( "tag_sensor" );

    self.owner thread maps\mp\gametypes\_damagefeedback::_ID34528( "hitmotionsensor" );
    var_2 = [];

    foreach ( var_4 in level.characters )
    {
        if ( var_4.team == self.owner.team )
            continue;

        if ( !maps\mp\_utility::_ID18757( var_4 ) )
            continue;

        if ( var_4 maps\mp\_utility::_hasperk( "specialty_heartbreaker" ) )
            continue;

        if ( distance2d( self.origin, var_4.origin ) < 300 )
            var_2[var_2.size] = var_4;
    }

    foreach ( var_7 in var_2 )
    {
        thread markplayer( var_7, self.owner );
        level thread sensorscreeneffects( var_7, self.owner );
    }

    if ( var_2.size > 0 )
    {
        self.owner maps\mp\gametypes\_missions::_ID25038( "ch_motiondetected", var_2.size );
        self.owner thread maps\mp\gametypes\_gamelogic::_ID32913( "motion_sensor", 1, "hits" );
    }

    if ( isdefined( self.owner ) && isdefined( level._ID19766 ) )
        self.owner thread [[ level._ID19766 ]]( "mine_destroyed", undefined, undefined, self.origin );

    wait 0.2;
    deleteexplosive();
}

markplayer( var_0, var_1 )
{
    if ( var_0 == var_1 )
        return;

    var_0 endon( "disconnect" );
    var_2 = undefined;

    if ( level._ID32653 )
        var_2 = maps\mp\_utility::_ID23109( var_0, "orange", var_1.team, 0, "equipment" );
    else
        var_2 = maps\mp\_utility::_ID23108( var_0, "orange", var_1, 0, "equipment" );

    var_0 thread maps\mp\gametypes\_damagefeedback::_ID34528( "hitmotionsensor" );
    var_0.motionsensormarkedby = var_1;
    var_0 common_scripts\utility::_ID35637( self.config.markedduration, "death" );
    var_0.motionsensormarkedby = undefined;
    maps\mp\_utility::_ID23104( var_2, var_0 );
}

sensorscreeneffects( var_0, var_1 )
{
    if ( var_0 == var_1 )
        return;

    if ( isai( var_0 ) )
        return;

    var_2 = "coup_sunblind";
    var_0 setclientomnvar( "ui_hud_shake", 1 );
    var_0 visionsetnakedforplayer( var_2, 0.05 );
    wait 0.05;
    var_0 visionsetnakedforplayer( var_2, 0 );
    var_0 visionsetnakedforplayer( "", 0.5 );
}

_ID21512( var_0 )
{
    if ( isdefined( level._ID3995 ) )
        return;

    self._ID32359 = 1;

    if ( isdefined( var_0 ) )
    {
        thread maps\mp\gametypes\_gamescore::processassist( var_0 );
        return;
    }

    maps\mp\gametypes\_gamescore::_ID15616( "assist", self, undefined, 1 );
    thread maps\mp\gametypes\_rank::giverankxp( "assist" );
    return;
}

_ID24649()
{
    if ( isdefined( self.config.mine_spin ) )
    {
        self endon( "death" );
        var_0 = gettime() + 1000;

        while ( gettime() < var_0 )
        {
            wait 0.05;
            playfxontag( self.config.mine_spin, self, "tag_fx_spin1" );
            playfxontag( self.config.mine_spin, self, "tag_fx_spin3" );
            wait 0.05;
            playfxontag( self.config.mine_spin, self, "tag_fx_spin2" );
            playfxontag( self.config.mine_spin, self, "tag_fx_spin4" );
        }

        return;
    }
}

_ID21058( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6[0] = ( 1, 0, 0 );
    var_6[1] = ( 0, 1, 0 );

    if ( var_1[2] < var_5 )
        var_7 = 0;
    else
        var_7 = 1;

    var_8 = ( var_0[0], var_0[1], var_5 );
    var_9 = ( var_1[0], var_1[1], var_5 );
    thread debugcircle( var_8, level.minedamageradius, var_6[var_7], 32 );
    var_10 = distancesquared( var_0, var_1 );

    if ( var_10 > var_2 )
        var_7 = 0;
    else
        var_7 = 1;

    thread _ID9250( var_8, var_9, var_6[var_7] );
}

_ID21060( var_0, var_1 )
{
    if ( isplayer( var_1 ) && isalive( var_1 ) && var_1.sessionstate == "playing" )
        var_2 = var_1 maps\mp\_utility::_ID15362();
    else if ( var_1.classname == "misc_turret" )
        var_2 = var_1.origin + ( 0, 0, 32 );
    else
        var_2 = var_1.origin;

    var_3 = 0;
    var_4 = var_0.origin[2] + var_3 + level._ID21059;
    var_5 = var_0.origin[2] + var_3 - level._ID21059;

    if ( var_2[2] > var_4 || var_2[2] < var_5 )
        return 0;

    return 1;
}

_ID21083( var_0, var_1 )
{
    if ( !isalive( self ) )
    {
        var_0 delete();
        return;
    }

    maps\mp\gametypes\_gamelogic::_ID28745( self, 1 );
    var_0 thread minethrown( self, var_0._ID36249, var_1 );
}

minethrown( var_0, var_1, var_2 )
{
    self.owner = var_0;
    self waittill( "missile_stuck",  var_3  );

    if ( !isdefined( var_0 ) )
        return;

    var_4 = bullettrace( self.origin + ( 0, 0, 4 ), self.origin - ( 0, 0, 4 ), 0, self );
    var_5 = var_4["position"];

    if ( var_4["fraction"] == 1 )
    {
        var_5 = getgroundposition( self.origin, 12, 0, 32 );
        var_4["normal"] *= -1;
    }

    var_6 = vectornormalize( var_4["normal"] );
    var_7 = vectortoangles( var_6 );
    var_7 += ( 90, 0, 0 );
    var_8 = [[ var_2 ]]( var_5, var_0, var_1, var_7 );
    var_8 _ID20502();
    var_8 thread minedamagemonitor();
    self delete();
}

delete_all_grenades()
{
    if ( isdefined( self._ID23708 ) )
    {
        foreach ( var_1 in self._ID23708 )
            var_1 deleteexplosive();
    }

    if ( isdefined( self._ID23709 ) )
    {
        foreach ( var_1 in self._ID23709 )
            var_1 deleteexplosive();
    }

    if ( isdefined( self ) )
    {
        self._ID23708 = [];
        self._ID23709 = [];
        return;
    }
}

_ID33365( var_0 )
{
    var_0 delete_all_grenades();

    if ( isdefined( self._ID23708 ) )
        var_0._ID23708 = common_scripts\utility::array_removeundefined( self._ID23708 );

    if ( isdefined( self._ID23709 ) )
        var_0._ID23709 = common_scripts\utility::array_removeundefined( self._ID23709 );

    if ( isdefined( var_0._ID23708 ) )
    {
        foreach ( var_2 in var_0._ID23708 )
        {
            var_2.owner = var_0;
            var_2 thread _ID12183( var_0 );
        }
    }

    if ( isdefined( var_0._ID23709 ) )
    {
        foreach ( var_2 in var_0._ID23709 )
        {
            var_2.owner = var_0;
            var_2 thread _ID12183( var_0 );
        }
    }

    self._ID23708 = [];
    self._ID23709 = [];
    self._ID10650 = 1;
    self.dont_delete_mines_on_next_spawn = 1;
}

doblinkinglight( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = common_scripts\utility::_ID15033( "weap_blink_friend" );

    if ( !isdefined( var_2 ) )
        var_2 = common_scripts\utility::_ID15033( "weap_blink_enemy" );

    self.blinkinglightfx["friendly"] = var_1;
    self.blinkinglightfx["enemy"] = var_2;
    self._ID5350 = var_0;
    thread _ID34511( var_1, var_2, var_0 );
    self waittill( "death" );
    _ID31835();
}

_ID34511( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "carried" );
    self endon( "emp_damage" );
    var_3 = ::checkteam;

    if ( !level._ID32653 )
        var_3 = ::checkplayer;

    var_4 = randomfloatrange( 0.05, 0.25 );
    wait(var_4);
    childthread _ID22854( var_0, var_1, var_2, var_3 );

    foreach ( var_6 in level.players )
    {
        if ( isdefined( var_6 ) )
        {
            if ( self.owner [[ var_3 ]]( var_6 ) )
                playfxontagforclients( var_0, self, var_2, var_6 );
            else
                playfxontagforclients( var_1, self, var_2, var_6 );

            wait 0.05;
        }
    }
}

_ID22854( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "emp_damage" );

    for (;;)
    {
        level waittill( "joined_team",  var_4  );

        if ( self.owner [[ var_3 ]]( var_4 ) )
        {
            playfxontagforclients( var_0, self, var_2, var_4 );
            continue;
        }

        playfxontagforclients( var_1, self, var_2, var_4 );
    }
}

_ID31835()
{
    if ( isalive( self ) && isdefined( self.blinkinglightfx ) )
    {
        stopfxontag( self.blinkinglightfx["friendly"], self, self._ID5350 );
        stopfxontag( self.blinkinglightfx["enemy"], self, self._ID5350 );
        self.blinkinglightfx = undefined;
        self._ID5350 = undefined;
        return;
    }
}

checkteam( var_0 )
{
    return self.team == var_0.team;
}

checkplayer( var_0 )
{
    return self == var_0;
}

equipmentdeathvfx()
{
    playfx( common_scripts\utility::_ID15033( "equipment_sparks" ), self.origin );
    self playsound( "sentry_explode" );
}

equipmentdeletevfx()
{
    playfx( common_scripts\utility::_ID15033( "equipment_explode_big" ), self.origin );
    playfx( common_scripts\utility::_ID15033( "equipment_smoke" ), self.origin );
    self playsound( "mp_killstreak_disappear" );
}

equipmentempstunvfx()
{
    playfxontag( common_scripts\utility::_ID15033( "emp_stun" ), self, "tag_origin" );
}
