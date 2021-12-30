// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID37117()
{
    if ( !isdefined( level._ID38237 ) )
    {
        level._ID38237 = 1;
        level thread _ID38260();
        level thread _ID36960();
        level thread _ID36959();
    }

    thread _ID38261();
    thread _ID36964();
    thread _ID36963();
    thread check_for_grenade_throw();
}

_ID38260()
{
    var_0 = [];
    var_0["drill_repair"] = ::_ID37815;
    var_0["drill_repaired"] = ::_ID37816;
    var_0["drill_planted"] = ::_ID37814;
    var_0["inform_explosives"] = ::_ID37818;
    var_0["inform_reloading_generic"] = ::_ID37824;
    var_0["inform_shield"] = ::_ID37825;
    var_0["online_mk32"] = ::_ID37822;
    var_0["online_vulture"] = ::_ID37826;
    var_0["ready_incendiaryrounds"] = ::_ID37819;
    var_0["ready_explosiverounds"] = ::_ID37817;
    var_0["inbound_brute"] = ::_ID37813;
    var_0["reaction_casualty_generic"] = ::_ID37794;
    var_0["direction_vo"] = ::_ID37791;
    var_0["to_gate"] = ::_ID37811;
    var_0["tesla_generator_basic"] = ::playvofortesla;
    var_0["tesla_generator_med"] = ::playvofortesla;
    var_0["tesla_generator_adv"] = ::playvofortesla;
    var_0["pipe_bomb"] = ::playvoforpipebomb;
    var_0["sticky_flare"] = ::playvoforstickyflare;
    var_0["pet_trap"] = ::playvoforhypnotrap;
    var_0["venom_basic"] = ::playvoforvenom;
    var_0["venom_basic_alt"] = ::playvoforvenom;
    var_0["venom_lightning"] = ::playvoforvenom;
    var_0["venom_fire"] = ::playvoforvenom;
    var_0["venom_turret"] = ::playvoforvenom;

    if ( level.script == "mp_alien_armory" )
    {
        var_0["spider_vo"] = ::_ID37810;
        var_0["spider_retreat"] = ::_ID37809;
    }

    if ( level.script == "mp_alien_beacon" )
    {
        var_0["open_door_move"] = ::playvofordooropen;
        var_0["inbound_seeder"] = ::playvoforseederspawn;
    }

    if ( level.script == "mp_alien_dlc3" )
    {
        var_0["inbound_mammoth"] = ::playvoformammothspawn;
        var_0["phantom_backup"] = ::playvoformammothpound;
        var_0["warn_dig"] = ::playvoformammothburrow;
        var_0["warn_underground"] = ::playvoformammothunderground;
        var_0["warn_emerge"] = ::playvoformammothemerge;
        var_0["inbound_gargoyle"] = ::playvoforgargoylespawn;
        var_0["inbound_bomber"] = ::playvoforbomberspawn;
        var_0["bomber_attack"] = ::playvoforbomberattack;
    }

    if ( level.script == "mp_alien_last" )
    {
        var_0["inbound_mammoth"] = ::playvoformammothspawn;
        var_0["phantom_backup"] = ::playvoformammothpound;
        var_0["warn_dig"] = ::playvoformammothburrow;
        var_0["warn_underground"] = ::playvoformammothunderground;
        var_0["warn_emerge"] = ::playvoformammothemerge;
        var_0["inbound_gargoyle"] = ::playvoforgargoylespawn;
        var_0["inbound_bomber"] = ::playvoforbomberspawn;
        var_0["bomber_attack"] = ::playvoforbomberattack;
    }

    if ( isdefined( level.level_specific_vo_callouts ) )
        var_0 = [[ level.level_specific_vo_callouts ]]( var_0 );

    for (;;)
    {
        level waittill( "dlc_vo_notify",  var_1, var_2  );

        if ( isdefined( var_0[var_1] ) )
        {
            if ( isdefined( var_2 ) )
            {
                level thread [[ var_0[var_1] ]]( var_2 );
                continue;
            }

            level thread [[ var_0[var_1] ]]();
        }
    }
}

_ID38261()
{
    self endon( "disconnect" );
    self endon( "death" );
    var_0 = [];
    var_0["intel_recovered"] = ::_ID37820;
    var_0["elite_killed"] = ::_ID37823;
    var_0["spitter_killed"] = ::_ID37823;
    var_0["locust_killed"] = ::_ID37823;
    var_0["gargoyle_killed"] = ::playvoforkilledgargoyle;
    var_0["pain"] = ::_ID37795;
    var_0["bleeding_out"] = ::_ID37821;
    var_0["weapon"] = ::playvoforweaponcraftingpiece;
    var_0["grenade"] = ::playvoforcraftingpiece;
    var_0["tesla"] = ::playvoforcraftingpiece;
    var_0["trap"] = ::playvoforcraftingpiece;

    for (;;)
    {
        self waittill( "dlc_vo_notify",  var_1, var_2  );

        if ( isdefined( var_0[var_1] ) )
        {
            if ( isdefined( var_2 ) )
            {
                level thread [[ var_0[var_1] ]]( var_2 );
                continue;
            }

            level thread [[ var_0[var_1] ]]();
        }
    }
}

_ID37815( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        return;

    if ( !isdefined( var_0 ) || !isalive( var_0 ) || var_0 maps\mp\alien\_unk1464::_ID18437() )
        return;

    if ( level.script == "mp_alien_last" )
    {
        level notify( "dlc_vo_notify",  "last_vo", "conduit_repairing"  );
        return;
    }

    var_1 = var_0._ID35381 + "drill_repair";
    var_0 _ID23864( var_1, undefined, 2 );
}

_ID37816( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        return;

    if ( !isdefined( var_0 ) || !isalive( var_0 ) || var_0 maps\mp\alien\_unk1464::_ID18437() )
        return;

    if ( level.script == "mp_alien_last" )
    {
        level notify( "dlc_vo_notify",  "last_vo", "conduit_repaired"  );
        return;
    }

    var_1 = var_0._ID35381 + "drill_repaired";
    var_0 _ID23864( var_1, undefined, 2 );
}

_ID37814( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        return;

    if ( !isdefined( var_0 ) || !isalive( var_0 ) || var_0 maps\mp\alien\_unk1464::_ID18437() )
        return;

    if ( level.script == "mp_alien_last" )
    {
        level notify( "dlc_vo_notify",  "last_vo", "conduit_start"  );
        return;
    }

    var_1 = var_0._ID35381 + "online_drill";
    var_0 _ID23864( var_1, undefined, 5 );
}

_ID37818( var_0 )
{
    var_1 = var_0._ID35381 + "inform_explosives";

    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        if ( randomint( 100 ) > 50 )
            return;

        var_1 = var_0._ID35381 + "equip_ammo_solo";
    }

    var_0 thread _ID23864( var_1 );
}

_ID37824( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        return;

    var_1 = 60000;
    var_2 = gettime();

    if ( !isdefined( var_0._ID37728 ) )
        var_0._ID37728 = var_2 + randomintrange( var_1, var_1 + 2000 );
    else if ( var_2 < var_0._ID37728 )
        return;

    var_3 = var_0._ID35381 + "inform_reloading_generic";
    var_0 thread _ID23864( var_3, undefined, 1 );
    var_0._ID37728 = var_2 + randomintrange( var_1, var_1 + 1500 );
}

_ID36964()
{
    self endon( "disconnect" );
    self endon( "death" );

    for (;;)
    {
        self waittill( "reload_start" );
        var_0 = self getcurrentweapon();
        var_1 = weaponclipsize( var_0 );
        var_2 = self getcurrentweaponclipammo();

        if ( var_2 < var_1 / 3 )
            level notify( "dlc_vo_notify",  "inform_reloading_generic", self  );
    }
}

check_for_grenade_throw()
{
    self endon( "disconnect" );
    self endon( "death" );

    for (;;)
    {
        self waittill( "grenade_fire",  var_0, var_1  );

        if ( var_1 == "iw6_aliendlc21_mp" )
            level notify( "dlc_vo_notify",  "sticky_flare", self  );

        if ( var_1 == "iw6_aliendlc22_mp" )
            level notify( "dlc_vo_notify",  "pipe_bomb", self  );
    }
}

_ID37825( var_0 )
{
    var_1 = var_0._ID35381 + "inform_shield";

    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        if ( randomint( 100 ) > 50 )
            return;

        var_1 = var_0._ID35381 + "equip_ammo_solo";
    }

    var_0 thread _ID23864( var_1 );
}

playvofortesla( var_0 )
{
    var_1 = var_0._ID35381 + "tesla_live";
    var_0 thread _ID23864( var_1 );
}

playvoforpipebomb( var_0 )
{
    var_1 = var_0._ID35381 + "pipebomb_live";

    if ( randomint( 100 ) > 20 )
        return;

    var_0 thread _ID23864( var_1 );
}

playvoforstickyflare( var_0 )
{
    var_1 = var_0._ID35381 + "sticky_live";

    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        if ( randomint( 100 ) > 50 )
            return;
    }

    var_0 thread _ID23864( var_1 );
}

playvoforhypnotrap( var_0 )
{
    var_1 = var_0._ID35381 + "hypno_live";
    var_0 thread _ID23864( var_1 );
}

playvoforvenom( var_0 )
{
    var_1 = var_0._ID35381 + "venom_live";

    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        if ( randomint( 100 ) > 50 )
            return;
    }

    var_0 thread _ID23864( var_1 );
}

playvoforcraftingpiece( var_0 )
{
    var_1 = var_0._ID35381 + "pickup_crafting";
    var_2 = 30000;
    var_3 = gettime();

    if ( !isdefined( var_0.next_crafting_vo_time ) )
        var_0.next_crafting_vo_time = var_3 + randomintrange( var_2, var_2 + 2000 );
    else if ( var_3 < var_0.next_crafting_vo_time )
        return;

    var_0 _ID23864( var_1, undefined, undefined, undefined, undefined, 1 );
    var_0.next_crafting_vo_time = var_3 + randomintrange( var_2, var_2 + 1500 );
}

playvoforweaponcraftingpiece( var_0 )
{
    var_1 = var_0._ID35381 + "pickup_weapon";
    var_2 = 30000;
    var_3 = gettime();

    if ( !isdefined( var_0.next_crafting_vo_time ) )
        var_0.next_crafting_vo_time = var_3 + randomintrange( var_2, var_2 + 2000 );
    else if ( var_3 < var_0.next_crafting_vo_time )
        return;

    var_0 _ID23864( var_1, undefined, undefined, undefined, undefined, 1 );
    var_0.next_crafting_vo_time = var_3 + randomintrange( var_2, var_2 + 1500 );
}

_ID37820( var_0 )
{
    wait 0.25;

    if ( maps\mp\alien\_unk1464::_ID18745() )
        return;

    if ( !isdefined( var_0 ) || !isalive( var_0 ) )
        return;

    var_1 = var_0._ID35381 + "intel_recovered";
    var_0 _ID23864( var_1 );
}

_ID37822( var_0 )
{
    var_1 = var_0._ID35381 + "online_mk32";
    var_0 _ID23864( var_1 );
}

_ID37826( var_0 )
{
    var_1 = var_0._ID35381 + "online_vulture";
    var_0 _ID23864( var_1 );
}

_ID37819( var_0 )
{
    var_1 = var_0._ID35381 + "ready_incendiaryrounds";

    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        if ( randomint( 100 ) > 50 )
            return;

        var_1 = var_0._ID35381 + "equip_ammo_solo";
    }

    var_0 thread _ID23864( var_1 );
}

_ID37817( var_0 )
{
    var_1 = var_0._ID35381 + "ready_explosiverounds";

    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        if ( randomint( 100 ) > 50 )
            return;

        var_1 = var_0._ID35381 + "equip_ammo_solo";
    }

    var_0 thread _ID23864( var_1 );
}

_ID37813( var_0 )
{
    wait 3;

    if ( !isdefined( var_0 ) )
        return;

    if ( randomint( 100 ) > 10 )
        return;

    var_1 = maps\mp\alien\_unk1464::_ID14295( 1, var_0.origin );

    if ( var_1.size < 1 )
        return;

    var_2 = var_1[0];
    var_3 = var_2._ID35381 + "inbound_brute";
    var_2 _ID23864( var_3 );
}

playvoforseederspawn( var_0 )
{
    wait 3;

    if ( !isdefined( var_0 ) )
        return;

    if ( randomint( 100 ) > 50 )
        return;

    var_1 = maps\mp\alien\_unk1464::_ID14295( 1, var_0.origin );

    if ( var_1.size < 1 )
        return;

    var_2 = var_1[0];
    var_3 = var_2._ID35381 + "warn_seeder";
    var_2 _ID23864( var_3 );
}

playvoformammothspawn( var_0 )
{
    wait 3;

    if ( !isdefined( var_0 ) )
        return;

    var_1 = maps\mp\alien\_unk1464::_ID14295( 1, var_0.origin );

    if ( var_1.size < 1 )
        return;

    var_2 = var_1[0];
    var_3 = var_2._ID35381 + "warn_mammoth";
    var_2 _ID23864( var_3, undefined, 5 );
}

playvoformammothpound( var_0 )
{
    playvoformammoth( "phantom_backup", var_0 );
}

playvoformammothburrow( var_0 )
{
    playvoformammoth( "warn_dig", var_0 );
}

playvoformammothunderground( var_0 )
{
    playvoformammoth( "warn_underground", var_0 );
}

playvoformammothemerge( var_0 )
{
    playvoformammoth( "warn_emerge", var_0 );
}

playvoformammoth( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        return;

    if ( !isdefined( var_0 ) )
        return;

    var_2 = 15000;
    var_3 = gettime();

    if ( !isdefined( level.next_mammoth_vo_time ) )
        level.next_mammoth_vo_time = var_3 + randomintrange( var_2, var_2 + 2000 );
    else if ( var_3 < level.next_mammoth_vo_time )
        return;

    if ( var_0 == "warn_dig" && randomint( 2 ) == 0 )
        return;

    var_4 = maps\mp\alien\_unk1464::_ID14295();

    if ( var_4.size < 1 )
        return;

    var_5 = var_4[0];

    if ( !soundexists( var_5._ID35381 + var_0 ) )
    {
        iprintln( "mammoth vo: " + var_5._ID35381 + var_0 );
        return;
    }

    var_6 = var_5._ID35381 + var_0;
    level.next_mammoth_vo_time = var_3 + randomintrange( var_2, var_2 + 1500 );
    var_5 _ID23864( var_6, undefined, 3 );
}

playvoforgargoylespawn( var_0 )
{
    wait 3;

    if ( !isdefined( var_0 ) )
        return;

    if ( randomint( 100 ) > 50 )
        return;

    var_1 = maps\mp\alien\_unk1464::_ID14295( 1, var_0.origin );

    if ( var_1.size < 1 )
        return;

    var_2 = var_1[0];
    var_3 = var_2._ID35381 + "spawn_gargoyle";
    var_2 _ID23864( var_3 );
}

playvoforbomberspawn( var_0 )
{
    wait 3;

    if ( !isdefined( var_0 ) )
        return;

    var_1 = 5000;
    var_2 = gettime();

    if ( !isdefined( level.next_bomber_spawn_vo_time ) )
        level.next_bomber_spawn_vo_time = var_2 + randomintrange( var_1, var_1 + 2000 );
    else if ( var_2 < level.next_bomber_spawn_vo_time )
        return;

    var_3 = maps\mp\alien\_unk1464::_ID14295( 1, var_0.origin );

    if ( var_3.size < 1 )
        return;

    var_4 = var_3[0];
    var_5 = [ "spotted_bats", "spawn_bats" ];
    var_6 = var_4._ID35381 + common_scripts\utility::_ID25350( var_5 );
    level.next_bomber_spawn_vo_time = var_2 + randomintrange( var_1, var_1 + 1500 );
    var_4 _ID23864( var_6 );
}

playvoforbomberattack( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_1 = 15000;
    var_2 = gettime();

    if ( !isdefined( level.next_bomber_vo_time ) )
        level.next_bomber_vo_time = var_2 + randomintrange( var_1, var_1 + 2000 );
    else if ( var_2 < level.next_bomber_vo_time )
        return;

    if ( randomint( 100 ) > 50 )
        return;

    var_3 = maps\mp\alien\_unk1464::_ID14295( 1, var_0.origin );

    if ( var_3.size < 1 )
        return;

    var_4 = var_3[0];
    var_5 = var_4._ID35381 + "warn_bats";
    level.next_bomber_vo_time = var_2 + randomintrange( var_1, var_1 + 1500 );
    var_4 _ID23864( var_5, undefined, 1 );
}

_ID37823( var_0 )
{
    var_1 = var_0._ID35381 + "neutralized_alien";

    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        if ( randomint( 100 ) > 50 )
            return;
    }

    var_0 thread _ID23864( var_1, undefined, 3 );
}

playvoforkilledgargoyle( var_0 )
{
    var_1 = var_0._ID35381 + "defeat_gargoyle";

    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        if ( randomint( 100 ) > 50 )
            return;
    }

    var_0 thread _ID23864( var_1, undefined, 3 );
}

playvofordooropen( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        return;

    if ( randomint( 100 ) > 50 )
        return;

    var_1 = 0;
    var_2 = 10;

    while ( maps\mp\agents\_agent_utility::getactiveagentsoftype( "alien" ).size > 0 )
    {
        wait 1;
        var_1++;

        if ( var_1 > var_2 )
            return;
    }

    var_3 = maps\mp\alien\_unk1464::_ID14295( 1, var_0.origin );

    if ( var_3.size < 1 )
        return;

    var_4 = var_3[0];
    var_5 = var_4._ID35381 + "open_door_move";
    var_4 _ID23864( var_5, undefined, 5 );
}

_ID37795( var_0 )
{
    var_1 = 1500;
    var_2 = gettime();

    if ( level.script == "mp_alien_last" && maps\mp\alien\_unk1464::_ID18506( var_0.vo_system_playing_vo ) )
        return;

    if ( !isdefined( var_0._ID21979 ) )
        var_0._ID21979 = var_2 + randomintrange( var_1, var_1 + 2000 );
    else if ( var_2 < var_0._ID21979 )
        return;

    var_3 = var_0._ID35381 + "pain";

    if ( soundexists( var_0._ID35381 + "plr_" + "pain" ) )
        var_0 playlocalsound( var_0._ID35381 + "plr_" + "pain" );
    else
        var_0 playlocalsound( var_3 );

    var_0._ID21979 = var_2 + randomintrange( var_1, var_1 + 1500 );
}

_ID18526()
{
    foreach ( var_1 in level.players )
    {
        if ( maps\mp\alien\_unk1464::_ID18506( var_1.vo_system_playing_vo ) )
            return 1;
    }

    return 0;
}

remove_drill_vo_once_repaired()
{
    for (;;)
    {
        while ( !isdefined( level.drill ) )
            wait 0.1;

        level.drill waittill( "drill_repaired" );

        foreach ( var_1 in level.players )
        {
            var_1 thread remove_drill_vo_on_player( "drill_hot" );
            var_1 thread remove_drill_vo_on_player( "drill_repair" );
        }
    }
}

remove_drill_vo_once_complete()
{
    for (;;)
    {
        level waittill( "drill_planted" );
        level.drill waittill( "drill_complete" );

        foreach ( var_1 in level.players )
        {
            var_1 thread remove_drill_vo_on_player( "drill_attacked" );
            var_1 thread remove_drill_vo_on_player( "drill_repaired" );
            var_1 thread remove_drill_vo_on_player( "drill_halfway" );
        }
    }
}

remove_drill_vo_on_player( var_0 )
{
    foreach ( var_3, var_2 in level.alien_vo_priority_level )
        maps\mp\alien\_music_and_dialog::remove_vo_data( var_0, var_2 );
}

_ID37794( var_0 )
{
    var_1 = maps\mp\alien\_unk1464::_ID14295();
    var_1 = common_scripts\utility::array_remove( var_1, var_0 );

    if ( var_1.size < 1 )
        return;

    var_0 = var_1[0];
    var_2 = var_0._ID35381 + "reaction_casualty_generic";
    var_0 _ID23864( var_2, undefined, 1 );
}

_ID37811()
{
    level endon( "stop_dlc_vo_notify_to_gate" );
    wait 20;
    var_0 = maps\mp\alien\_unk1464::_ID14295();

    if ( var_0.size < 1 )
        return;

    var_1 = var_0[0];
    var_2 = var_1._ID35381 + "to_gate";
    var_1 _ID23864( var_2 );
}

_ID37821( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        return;

    var_1 = var_0._ID35381 + "last_stand";
    var_0 thread _ID23864( var_1, undefined, 1 );
}

_ID23864( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    maps\mp\alien\_music_and_dialog::_ID23864( var_0, var_1, var_2, var_3, var_4, var_5 );
}

_ID36963()
{
    self endon( "disconnect" );
    self endon( "death" );

    for (;;)
    {
        self waittill( "last_stand" );
        _ID37123();
    }
}

_ID36960()
{
    for (;;)
    {
        level waittill( "drill_planted",  var_0  );
        level notify( "dlc_vo_notify",  "drill_planted", var_0  );
    }
}

_ID37123()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "revive" );
    wait 4.0;
    level notify( "dlc_vo_notify",  "reaction_casualty_generic", self  );
    wait 10.0;

    while ( self._ID5118 )
        wait 0.1;

    self notify( "dlc_vo_notify",  "bleeding_out", self  );
    wait 8.0;

    while ( self._ID5118 )
        wait 0.1;

    self notify( "dlc_vo_notify",  "bleeding_out", self  );
}

_ID37791( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        return;

    if ( !isdefined( var_0 ) )
        return;

    var_1 = maps\mp\alien\_unk1464::_ID14295();

    if ( var_1.size < 1 )
        return;

    var_2 = var_1[0];
    var_3 = 10000;
    var_4 = gettime();
    var_5 = 0;

    if ( !isdefined( level._ID37727 ) )
        level._ID37727 = var_4 + randomintrange( var_3, var_3 + 2000 );
    else if ( var_4 < level._ID37727 )
        return;

    if ( !isdefined( level._ID37593 ) || level._ID37593 != var_0 )
    {
        level._ID37593 = var_0;
        var_5 = 0;
    }
    else if ( level._ID37593 == var_0 )
    {
        level._ID37727 = var_4 + randomintrange( var_3, var_3 + 1500 );
        var_5++;

        if ( var_5 > 5 )
            level._ID37593 = undefined;

        return;
    }

    level._ID37727 = var_4 + randomintrange( var_3, var_3 + 1500 );

    if ( var_0 == "rooftop" )
        var_0 = "roof";

    if ( var_0 == "security_gate" )
        var_0 = "gate";

    var_6 = var_2._ID35381 + "from_" + var_0;

    if ( var_0 == "spawn_vent" || var_0 == "spawn_grate" )
        var_6 = var_2._ID35381 + var_0;

    if ( var_0 == "above" || var_0 == "walls" || var_0 == "spores" )
        var_6 = var_2._ID35381 + "spawn_" + var_0;

    var_2 _ID23864( var_6, undefined, 1 );
}

_ID36959()
{
    var_0 = getentarray( "vo_direction_trigger", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread _ID37741( var_2.script_noteworthy );
}

_ID37741( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "trigger",  var_1  );

        if ( isagent( var_1 ) && isdefined( var_1.team ) && var_1.team == "axis" && isdefined( var_1.alien_type ) && var_1.alien_type != "spider" )
        {
            if ( isdefined( level._ID37045 ) )
            {
                if ( !_ID18435( level._ID37045, var_0 ) )
                    continue;
            }

            level notify( "dlc_vo_notify",  "direction_vo", var_0  );
        }

        wait 0.25;
    }
}

_ID37810( var_0 )
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        return;

    if ( !isdefined( var_0 ) )
        return;

    var_1 = maps\mp\alien\_unk1464::_ID14295();

    if ( var_1.size < 1 )
        return;

    var_2 = var_1[0];

    if ( !soundexists( var_2._ID35381 + var_0 ) )
        return;

    var_3 = 10000;
    var_4 = gettime();
    var_5 = 0;

    if ( !isdefined( level._ID37729 ) )
        level._ID37729 = var_4 + randomintrange( var_3, var_3 + 2000 );
    else if ( var_4 < level._ID37729 )
        return;

    if ( !isdefined( level._ID37600 ) || level._ID37600 != var_0 )
    {
        level._ID37600 = var_0;
        var_5 = 0;
    }
    else if ( level._ID37600 == var_0 )
    {
        level._ID37729 = var_4 + randomintrange( var_3, var_3 + 1500 );
        var_5++;

        if ( var_5 > 5 )
            level._ID37600 = undefined;

        return;
    }

    level._ID37727 = var_4 + randomintrange( var_3, var_3 + 1500 );
    var_6 = var_2._ID35381 + var_0;
    var_2 _ID23864( var_6 );
}

_ID37809()
{
    if ( maps\mp\alien\_unk1464::_ID18745() )
        return;

    var_0 = maps\mp\alien\_unk1464::_ID14295();

    if ( var_0.size < 1 )
        return;

    var_1 = var_0[0];
    var_2 = var_1._ID35381 + "spider_retreat";
    var_1 _ID23864( var_2 );
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
