// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID37459()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        return;

    if ( !isdefined( level._ID36993 ) )
        return;

    if ( !isdefined( level._ID37653 ) )
        level._ID37653 = 3;

    level._ID37743 = 0;
    _ID37487();
}

_ID36650( var_0 )
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        return;

    var_1 = _ID37936( var_0 );

    foreach ( var_3 in var_1 )
    {
        var_4 = var_3.script_noteworthy;

        if ( _ID38013( var_3, var_4 ) )
            var_3 thread _ID36647( var_3, var_4 );
    }
}

_ID36649( var_0 )
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        return;

    var_1 = common_scripts\utility::_ID15386( "container_spawn", "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( _ID36712( var_3 ) )
            continue;

        var_4 = var_3.script_noteworthy;

        if ( var_4 == var_0 )
            var_3 thread _ID36647( var_3, var_4 );
    }
}

_ID36647( var_0, var_1 )
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        return;

    var_0 endon( "death" );
    level endon( "game_ended" );
    var_0.activated = 1;
    var_2 = _ID37253( var_1 );

    switch ( var_2 )
    {
        case "proximity":
            _ID38274( var_0, var_1 );
            break;
        case "damage":
            _ID38267( var_0, var_1 );
            break;
        case "notify":
            _ID38272( var_1 );
            break;
    }

    _ID38063( var_0, var_1 );
    _ID37070( var_0 );
}

_ID38063( var_0, var_1 )
{
    var_2 = 0.2;
    var_3 = 10;
    var_4 = common_scripts\utility::_ID15386( var_0.target, "targetname" );
    var_4 = _ID38050( var_4, var_1 );
    var_5 = _ID37324( var_1, var_4.size );
    var_6 = _ID37320( var_1 );
    var_7 = var_5.size;

    if ( var_6 )
    {
        for ( var_7 = maps\mp\alien\_spawn_director::_ID37893( var_7, 0 ); var_7 <= 0; var_7 = maps\mp\alien\_spawn_director::_ID37893( var_7, 0 ) )
            common_scripts\utility::_ID35582();
    }
    else
        var_7 = maps\mp\alien\_spawn_director::_ID37893( var_7, 1 );

    if ( var_7 > 0 )
    {
        maps\mp\alien\_spawn_director::pause_cycle( var_3 );
        play_warning_sfx( var_4, var_5, var_1 );
    }

    for ( var_8 = 0; var_8 < var_7; var_8++ )
    {
        var_9 = var_4[var_8];
        var_10 = var_5[var_8];
        var_11 = maps\mp\alien\_spawn_director::_ID37846( var_10 );
        var_12 = level.cycle_data.spawn_node_info[var_9.script_noteworthy]._ID35292[var_11];
        var_13 = maps\mp\alien\_spawn_director::_ID37845( var_10, var_9, var_12 );

        if ( isdefined( var_13 ) )
            _ID37650( var_13, var_0 );

        wait(var_2);
    }
}

play_warning_sfx( var_0, var_1, var_2 )
{
    var_3 = var_0[0].origin;
    var_4 = spawn( "script_origin", var_3 );
    var_5 = level._ID36994[var_1[0]];
    var_6 = "emt_aln_arm_crate_alarm_lp";

    if ( isdefined( var_5 ) && _ID37322( var_2 ) )
    {
        var_7 = lookupsoundlength( var_5 ) / 1000;
        var_4 playsound( var_5 );
        wait(var_7);
        var_4 stopsounds();
    }

    var_7 = 5;
    var_4 common_scripts\utility::delaycall( var_7 + 1, ::delete );

    if ( isdefined( var_6 ) && _ID37321( var_2 ) )
    {
        var_4 common_scripts\utility::delaycall( var_7, ::stoploopsound );
        var_4 playloopsound( var_6 );
    }
}

_ID37487()
{
    if ( !isdefined( level._ID36994 ) )
    {
        level._ID36994["elite"] = "scn_arm_crate_queen";
        level._ID36994["spitter"] = "scn_arm_crate_spitter";
        level._ID36994["brute"] = "scn_arm_crate_brute";
        level._ID36994["locust"] = "scn_arm_crate_brute";
    }
}

_ID38274( var_0, var_1 )
{
    var_2 = 1.0;
    var_3 = _ID37254( var_0 );
    var_3 endon( "death" );
    var_3 endon( "timed_out" );
    var_4 = _ID37340( var_1 );
    var_5 = _ID37339( var_1 );
    var_3 thread _ID37736( "timed_out", var_5 );

    for (;;)
    {
        var_3 waittill( "trigger",  var_6  );

        if ( !isplayer( var_6 ) )
        {
            common_scripts\utility::_ID35582();
            continue;
        }

        if ( randomintrange( 0, 100 ) <= var_4 )
        {
            return;
            continue;
        }

        wait(var_2);
    }
}

_ID37736( var_0, var_1 )
{
    if ( var_1[0] >= 0 )
    {
        var_2 = randomintrange( var_1[0], var_1[1] );
        wait(var_2);
        self notify( var_0 );
    }
}

_ID38267( var_0, var_1 )
{
    var_2 = _ID37258( var_0, var_1 );
    var_2 endon( "death" );

    for (;;)
    {
        var_2 waittill( "damage",  var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12  );

        if ( isagent( var_4 ) )
        {
            var_2._ID12656 = var_2._ID12656 - var_3;

            if ( var_2._ID12656 <= 0 )
                break;
        }
    }
}

_ID38272( var_0 )
{
    var_1 = _ID37297( var_0 );
    level waittill( var_1 );
}

_ID37258( var_0, var_1 )
{
    level._ID37743++;
    var_2 = spawn( "script_model", var_0.origin );
    var_2.health = 999999;
    var_2._ID12656 = _ID37263( var_1 );
    var_2 setcandamage( 1 );
    var_2 setcanradiusdamage( 1 );
    var_2 makeentitysentient( "allies", 1 );
    var_2.threatbias = _ID37338( var_1 );
    var_0.attackable_ent = var_2;
    return var_2;
}

_ID37071( var_0 )
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        return;

    var_1 = _ID37936( var_0 );

    foreach ( var_3 in var_1 )
        _ID37070( var_3 );
}

_ID37070( var_0 )
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        return;

    var_1 = getentarray( var_0.target, "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( _ID37523( var_3 ) )
            continue;

        var_3 delete();
    }

    if ( isdefined( var_0.attackable_ent ) )
    {
        var_0.attackable_ent freeentitysentient();
        var_0.attackable_ent delete();
        level._ID37743--;
    }

    var_0 notify( "death" );
}

_ID37253( var_0 )
{
    var_1 = [ "damage", "proximity", "notify" ];
    var_2 = _ID37315( var_0 );
    var_3 = _ID37298( var_0 );

    if ( _ID36744() )
        var_4 = 0;
    else
        var_4 = _ID37273( var_0 );

    var_5 = [ var_4, var_2, var_3 ];
    var_6 = maps\mp\alien\_unk1464::getrandomindex( var_5 );
    return var_1[var_6];
}

_ID37936( var_0 )
{
    var_1 = getent( var_0, "targetname" );
    var_2 = [];
    var_3 = common_scripts\utility::_ID15386( "container_spawn", "targetname" );

    foreach ( var_5 in var_3 )
    {
        if ( ispointinvolume( var_5.origin, var_1 ) )
            var_2[var_2.size] = var_5;
    }

    return var_2;
}

_ID37254( var_0 )
{
    var_1 = getentarray( var_0.target, "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( var_3.classname == "trigger_multiple" )
            return var_3;
    }
}

_ID38013( var_0, var_1 )
{
    if ( _ID38017( var_1 ) || _ID36712( var_0 ) )
        return 0;

    return _ID38014( var_1 );
}

_ID38017( var_0 )
{
    if ( !isdefined( level._ID38018 ) )
        return 0;

    return [[ level._ID38018 ]]( var_0 );
}

_ID36712( var_0 )
{
    return maps\mp\alien\_unk1464::_ID18506( var_0.activated );
}

_ID38014( var_0 )
{
    var_1 = _ID37252( var_0 );
    var_2 = randomintrange( 0, 100 );
    return var_2 < var_1;
}

_ID37324( var_0, var_1 )
{
    var_2 = _ID37328( var_0 );
    var_3 = _ID37327( var_0 );
    var_4 = _ID37326( var_0 );
    var_5 = maps\mp\alien\_unk1464::getrandomindex( var_3 );
    var_2 = strtok( var_2[var_5], "-" );
    var_4 = strtok( var_4[var_5], "-" );
    var_6 = [];

    for ( var_7 = 0; var_7 < var_2.size; var_7++ )
    {
        var_8 = int( var_4[var_7] );

        if ( var_8 > 1 )
            var_8 = 1 + randomintrange( 0, var_8 );

        for ( var_9 = 0; var_9 < var_8; var_9++ )
            var_6[var_6.size] = var_2[var_7];
    }

    return var_6;
}

_ID38050( var_0, var_1 )
{
    var_2 = _ID37329( var_1 );
    var_3 = _ID37330( var_1 );
    var_0 = _ID36740( var_0, var_2, var_3 );
    var_0 = common_scripts\utility::_ID3855( var_0, ::_ID37530 );
    return var_0;
}

_ID37530( var_0, var_1 )
{
    return var_0._ID25014 > var_1._ID25014;
}

_ID36740( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_0 )
        var_4._ID25014 = _ID37325( var_4, var_1, var_2 );

    return var_0;
}

_ID37325( var_0, var_1, var_2 )
{
    foreach ( var_5, var_4 in var_1 )
    {
        if ( var_0.script_noteworthy == var_4 )
            return var_2[var_5];
    }
}

_ID36744()
{
    return level._ID37743 >= level._ID37653;
}

_ID37252( var_0 )
{
    return _ID37265( var_0, 1, 1 );
}

_ID37315( var_0 )
{
    return _ID37265( var_0, 2, 1 );
}

_ID37273( var_0 )
{
    return _ID37265( var_0, 3, 1 );
}

_ID37298( var_0 )
{
    return _ID37265( var_0, 4, 1 );
}

_ID37340( var_0 )
{
    return _ID37265( var_0, 5, 1 );
}

_ID37263( var_0 )
{
    return _ID37265( var_0, 6, 1 );
}

_ID37338( var_0 )
{
    return _ID37265( var_0, 7, 1 );
}

_ID37297( var_0 )
{
    return _ID37265( var_0, 8, 0 );
}

_ID37328( var_0 )
{
    return _ID37266( var_0, 9, 0 );
}

_ID37327( var_0 )
{
    return _ID37266( var_0, 10, 1 );
}

_ID37326( var_0 )
{
    return _ID37266( var_0, 11, 0 );
}

_ID37320( var_0 )
{
    return _ID37265( var_0, 12, 0 ) == "true";
}

_ID37329( var_0 )
{
    return _ID37266( var_0, 13, 0 );
}

_ID37330( var_0 )
{
    return _ID37266( var_0, 14, 1 );
}

_ID37321( var_0 )
{
    return _ID37265( var_0, 15, 0 ) == "true";
}

_ID37322( var_0 )
{
    return _ID37265( var_0, 16, 0 ) == "true";
}

_ID37339( var_0 )
{
    return _ID37266( var_0, 17, 1 );
}

_ID37265( var_0, var_1, var_2 )
{
    var_3 = tablelookup( level._ID36993, 0, var_0, var_1 );

    if ( var_2 )
        var_3 = int( var_3 );

    return var_3;
}

_ID37266( var_0, var_1, var_2 )
{
    var_3 = tablelookup( level._ID36993, 0, var_0, var_1 );
    var_3 = strtok( var_3, " " );

    if ( var_2 )
    {
        foreach ( var_6, var_5 in var_3 )
            var_3[var_6] = int( var_5 );
    }

    return var_3;
}

_ID37650( var_0, var_1 )
{
    var_2 = getentarray( var_1.target, "targetname" );
    var_3 = [];

    foreach ( var_5 in var_2 )
    {
        if ( _ID37523( var_5 ) )
            var_3[var_3.size] = var_5;
    }

    var_0._ID37519 = var_3;
}

_ID37523( var_0 )
{
    return var_0.classname == "script_brushmodel";
}

_ID36992( var_0 )
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "drill_planted" );
        _ID36648( level.current_hive_name, var_0 );
    }
}

_ID36648( var_0, var_1 )
{
    var_2 = _ID37264( var_0, var_1 );

    foreach ( var_4 in var_2 )
        _ID36649( var_4 );
}

_ID37264( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_5, var_4 in var_1 )
    {
        if ( common_scripts\utility::array_contains( var_4, var_0 ) )
            var_2[var_2.size] = var_5;
    }

    return var_2;
}
