// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    thread _ID20478();
}

_ID20478()
{
    common_scripts\utility::_ID13189( "teleport_setup_complete" );
    level._ID32746 = [];
    level._ID32716 = 1;
    level._ID32787 = 1;
    level._ID32786 = 1;
    level._ID32739 = 1;
    level._ID32731 = undefined;
    level._ID32769 = [];
    level._ID32768 = [];
    level._ID32707 = [];
    level._ID32708 = [];
    level._ID32747 = [];
    level.teleport_pathnode_zones = [];
    level._ID32754 = level._ID22905;
    level._ID22905 = ::_ID32754;
    level._ID32800 = ::_ID32732;
    level.teleportgetactivepathnodezonesfunc = ::teleport_get_active_pathnode_zones;
}

_ID32741()
{
    level._ID32782 = [];
    var_0 = common_scripts\utility::_ID15386( "teleport_world_origin", "targetname" );

    if ( !var_0.size )
        return;

    level._ID32797 = [];

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2.script_noteworthy ) )
            var_2.script_noteworthy = "zone_" + level._ID32797.size;

        var_2.name = var_2.script_noteworthy;
        _ID32763( var_2 );
        level._ID32747[var_2.name] = [];
        level.teleport_pathnode_zones[var_2.name] = [];
        level._ID32797[var_2.script_noteworthy] = var_2;
    }

    var_4 = getallnodes();

    foreach ( var_6 in var_4 )
    {
        var_2 = _ID32720( var_6.origin );
        level._ID32747[var_2.name][level._ID32747[var_2.name].size] = var_6;
    }

    for ( var_8 = 0; var_8 < getzonecount(); var_8++ )
    {
        var_2 = _ID32720( getzoneorigin( var_8 ) );
        level.teleport_pathnode_zones[var_2.name][level.teleport_pathnode_zones[var_2.name].size] = var_8;
    }

    if ( !isdefined( level.teleport_zone_current ) )
    {
        if ( isdefined( level._ID32797["start"] ) )
            _ID32778( "start" );
        else
        {
            foreach ( var_11, var_10 in level._ID32797 )
            {
                _ID32778( var_11 );
                break;
            }
        }
    }

    level.dynamicspawns = ::_ID32729;
}

_ID32754()
{
    _ID32741();
    var_0 = undefined;
    var_1 = undefined;

    switch ( level._ID14086 )
    {
        case "dom":
            var_1 = ::_ID32750;
            break;
        case "siege":
            var_1 = ::teleport_onstartgamesiege;
            break;
        case "conf":
            var_1 = ::_ID32749;
            break;
        case "sd":
            var_0 = ::_ID32771;
            break;
        case "sr":
            var_0 = ::_ID32773;
            break;
        case "blitz":
            var_0 = ::_ID32770;
            break;
        case "sotf":
        case "sotf_ffa":
            var_1 = ::_ID32753;
            break;
        case "grind":
            var_1 = ::_ID32751;
            break;
        case "horde":
            var_0 = ::_ID32752;
            break;
        case "infect":
        case "war":
        case "dm":
            break;
        default:
            break;
    }

    if ( isdefined( var_0 ) )
        level [[ var_0 ]]();

    level [[ level._ID32754 ]]();

    if ( isdefined( var_1 ) )
        level [[ var_1 ]]();

    common_scripts\utility::flag_set( "teleport_setup_complete" );
}

_ID32770()
{
    foreach ( var_1 in level._ID32797 )
        var_1._ID5351 = [];

    var_3 = getentarray( "axis_portal", "targetname" );

    foreach ( var_5 in var_3 )
    {
        var_6 = _ID32720( var_5.origin );

        if ( isdefined( var_6 ) )
        {
            var_6.blitz_axis_trigger_origin = var_5.origin;
            var_6._ID5351[var_6._ID5351.size] = var_5;
            _ID32719( var_5 );
        }
    }

    var_8 = getentarray( "allies_portal", "targetname" );

    foreach ( var_5 in var_8 )
    {
        var_6 = _ID32720( var_5.origin );

        if ( isdefined( var_6 ) )
        {
            var_6.blitz_allies_trigger_origin = var_5.origin;
            var_6._ID5351[var_6._ID5351.size] = var_5;
            _ID32719( var_5 );
        }
    }

    var_11 = level._ID32797[level.teleport_zone_current];
    _ID32774( var_11._ID5351 );
    level._ID32731 = ::_ID32755;
}

_ID32755( var_0 )
{
    var_1 = level._ID32797[var_0];
    var_2 = level._ID32797[level.teleport_zone_current];
    var_3 = "axis";
    var_4 = "allies";

    if ( game["switchedsides"] )
    {
        var_3 = "allies";
        var_4 = "axis";
    }

    var_5 = var_1.blitz_axis_trigger_origin - var_2.blitz_axis_trigger_origin;
    level._ID24742[var_3].origin = level._ID24742[var_3].origin + var_5;
    level._ID24742[var_3].trigger.origin = level._ID24742[var_3].trigger.origin + var_5;
    objective_position( level._ID24742[var_3].ownerteamid, var_1.blitz_axis_trigger_origin + ( 0, 0, 72 ) );
    objective_position( level._ID24742[var_3].enemyteamid, var_1.blitz_axis_trigger_origin + ( 0, 0, 72 ) );
    var_6 = var_1.blitz_allies_trigger_origin - var_2.blitz_allies_trigger_origin;
    level._ID24742[var_4].origin = level._ID24742[var_4].origin + var_6;
    level._ID24742[var_4].trigger.origin = level._ID24742[var_4].trigger.origin + var_6;
    objective_position( level._ID24742[var_4].ownerteamid, var_1.blitz_allies_trigger_origin + ( 0, 0, 72 ) );
    objective_position( level._ID24742[var_4].enemyteamid, var_1.blitz_allies_trigger_origin + ( 0, 0, 72 ) );
    maps\mp\gametypes\blitz::assignteamspawns();

    foreach ( var_8 in level.players )
        var_8 maps\mp\gametypes\blitz::_ID29990();
}

_ID32773()
{
    teleport_pre_onstartgamesd_and_sr();
}

_ID32771()
{
    teleport_pre_onstartgamesd_and_sr();
}

teleport_pre_onstartgamesd_and_sr()
{
    foreach ( var_1 in level._ID32797 )
    {
        var_1.sd_triggers = [];
        var_1._ID27935 = [];
        var_1._ID27936 = [];
    }

    var_3 = getentarray( "sd_bomb_pickup_trig", "targetname" );

    foreach ( var_5 in var_3 )
    {
        var_6 = _ID32720( var_5.origin );

        if ( isdefined( var_6 ) )
        {
            var_6.sd_triggers[var_6.sd_triggers.size] = var_5;
            _ID32719( var_5, var_6.name );
        }
    }

    var_8 = getentarray( "sd_bomb", "targetname" );

    foreach ( var_10 in var_8 )
    {
        var_6 = _ID32720( var_10.origin );

        if ( isdefined( var_6 ) )
        {
            var_6._ID27935[var_6._ID27935.size] = var_10;
            _ID32719( var_10, var_6.name );
        }
    }

    var_12 = getentarray( "bombzone", "targetname" );

    foreach ( var_14 in var_12 )
    {
        var_6 = _ID32720( var_14.origin );

        if ( isdefined( var_6 ) )
        {
            var_6._ID27936[var_6._ID27936.size] = var_14;
            _ID32719( var_14, var_6.name );
        }
    }

    var_16 = [];

    if ( maps\mp\_utility::isanymlgmatch() )
        var_16[0] = "start";
    else
    {
        foreach ( var_1 in level._ID32797 )
        {
            if ( var_1.sd_triggers.size && var_1.sd_triggers.size && var_1.sd_triggers.size )
                var_16[var_16.size] = var_1.name;
        }
    }

    _ID32730( var_16 );
    var_19 = level._ID32797[level.teleport_zone_current];
    _ID32774( var_19.sd_triggers );
    _ID32774( var_19._ID27935 );
    _ID32774( var_19._ID27936 );
}

_ID32753()
{
    foreach ( var_1 in level._ID32797 )
        var_1._ID30461 = [];

    var_3 = common_scripts\utility::_ID15386( "sotf_chest_spawnpoint", "targetname" );

    foreach ( var_5 in var_3 )
    {
        var_6 = _ID32720( var_5.origin );

        if ( isdefined( var_6 ) )
            var_6._ID30461[var_6._ID30461.size] = var_5;
    }

    var_8 = [];

    foreach ( var_1 in level._ID32797 )
    {
        if ( var_1._ID30461.size )
            var_8[var_8.size] = var_1.name;
    }

    level._ID32731 = ::_ID32759;
    _ID32730( var_8 );
}

_ID32759( var_0 )
{
    var_1 = level._ID32797[var_0];
    level._ID31994["targetname"]["sotf_chest_spawnpoint"] = var_1._ID30461;
}

_ID32751()
{
    foreach ( var_1 in level._ID32797 )
        var_1._ID15810 = [];

    foreach ( var_4 in level._ID36589 )
    {
        var_5 = _ID32720( var_4.origin );

        if ( isdefined( var_5 ) )
        {
            var_4._ID32795 = var_5.name;
            var_5._ID15810[var_5._ID15810.size] = var_4;
        }
    }

    level._ID32731 = ::teleport_onteleportgrind;
    teleport_onteleportgrind( level.teleport_zone_current );
}

teleport_onteleportgrind( var_0 )
{
    var_1 = level._ID32797[var_0];

    foreach ( var_3 in var_1._ID15810 )
    {
        if ( var_0 != level.teleport_zone_current )
        {
            objective_state( var_3.objid_axis, "active" );
            objective_state( var_3._ID22496, "active" );

            if ( isdefined( var_3._ID15808 ) && isdefined( var_3._ID15808.old_alpha ) )
                var_3._ID15808.alpha = var_3._ID15808.old_alpha;

            if ( isdefined( var_3._ID15809 ) && isdefined( var_3._ID15809.old_alpha ) )
                var_3._ID15809.alpha = var_3._ID15809.old_alpha;
        }
    }

    foreach ( var_9, var_6 in level._ID32797 )
    {
        foreach ( var_3 in var_6._ID15810 )
        {
            if ( var_9 != var_0 )
                thread _ID32738( var_3 );
        }
    }

    foreach ( var_11 in level.dogtags )
    {
        var_11._ID35358 hide();
        var_11.trigger hide();
        var_11 maps\mp\gametypes\_gameobjects::allowuse( "none" );
        var_11 notify( "reset" );
        var_11._ID19663 = 0;
    }
}

_ID32738( var_0 )
{
    objective_state( var_0.objid_axis, "invisible" );
    objective_state( var_0._ID22496, "invisible" );

    while ( !isdefined( var_0._ID15808 ) || !isdefined( var_0._ID15809 ) )
        common_scripts\utility::_ID35582();

    var_0._ID15808.old_alpha = var_0._ID15808.alpha;
    var_0._ID15808.alpha = 0;
    var_0._ID15809.old_alpha = var_0._ID15809.alpha;
    var_0._ID15809.alpha = 0;
}

_ID32752()
{
    foreach ( var_1 in level._ID32797 )
        var_1._ID17062 = [];

    var_3 = common_scripts\utility::_ID15386( "horde_drop", "targetname" );

    foreach ( var_5 in var_3 )
    {
        var_6 = _ID32720( var_5.origin );

        if ( isdefined( var_6 ) )
            var_6._ID17062[var_6._ID17062.size] = var_5;
    }

    var_8 = [];

    foreach ( var_1 in level._ID32797 )
    {
        if ( var_1._ID17062.size )
            var_8[var_8.size] = var_1.name;
    }

    _ID32730( var_8 );
    var_11 = level._ID32797[level.teleport_zone_current];
    level._ID31994["targetname"]["horde_drop"] = var_11._ID17062;
}

_ID32719( var_0, var_1 )
{
    if ( !isarray( var_0 ) )
        var_0 = [ var_0 ];

    if ( !isdefined( var_1 ) )
        var_1 = "hide_from_getEnt";

    foreach ( var_3 in var_0 )
    {
        var_3._ID27303 = var_3.targetname;
        var_3.targetname = var_3.targetname + "_" + var_1;
    }
}

_ID32730( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = getarraykeys( level._ID32797 );

    var_1 = game["teleport_zone_dom"];

    if ( !isdefined( var_1 ) )
    {
        var_1 = common_scripts\utility::_ID25350( var_0 );
        game["teleport_zone_dom"] = var_1;
    }

    _ID32789( var_1, 0 );
    level._ID32716 = 0;
}

_ID32774( var_0 )
{
    if ( !isarray( var_0 ) )
        var_0 = [ var_0 ];

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2._ID27303 ) )
            var_2.targetname = var_2._ID27303;
    }
}

_ID32750()
{
    foreach ( var_1 in level._ID32797 )
    {
        var_1._ID13222 = [];
        var_1._ID10614 = [];
    }

    level.all_dom_flags = level._ID13222;

    foreach ( var_4 in level._ID13222 )
    {
        var_5 = _ID32720( var_4.origin );

        if ( isdefined( var_5 ) )
        {
            var_4._ID32795 = var_5.name;
            var_5._ID13222[var_5._ID13222.size] = var_4;
            var_5._ID10614[var_5._ID10614.size] = var_4._ID34757;
        }
    }

    level._ID10604 = [];

    foreach ( var_1 in level._ID32797 )
    {
        foreach ( var_9 in var_1._ID13222 )
        {
            var_10 = spawnstruct();
            var_10._ID33662 = var_9.origin;
            var_10.visual_origin = var_9._ID34757._ID35361[0].origin;
            var_10.baseeffectpos = var_9._ID34757.baseeffectpos;
            var_10.baseeffectforward = var_9._ID34757.baseeffectforward;
            var_10.baseeffectright = var_9._ID34757.baseeffectright;
            var_10.obj_origin = var_9._ID34757.curorigin;
            var_10._ID22444 = [];

            foreach ( var_12 in level._ID32668 )
            {
                var_13 = "objpoint_" + var_12 + "_" + var_9._ID34757.entnum;
                var_14 = maps\mp\gametypes\_objpoints::getobjpointbyname( var_13 );

                if ( isdefined( var_14 ) )
                    var_10._ID22444[var_12] = ( var_14.x, var_14.y, var_14.z );
            }

            level._ID10604[var_1.name][var_9._ID34757.label] = var_10;
        }
    }

    level._ID13222 = level._ID32797[level.teleport_zone_current]._ID13222;
    level._ID10614 = level._ID32797[level.teleport_zone_current]._ID10614;

    foreach ( var_1 in level._ID32797 )
    {
        foreach ( var_4 in var_1._ID13222 )
        {
            if ( var_1.name == level.teleport_zone_current )
                continue;

            var_4._ID34757._ID35361[0] delete();
            var_4._ID34757 maps\mp\gametypes\_gameobjects::deleteuseobject();
        }
    }

    level._ID32731 = ::_ID32757;
    _ID32757( level.teleport_zone_current );
    level._ID32722 = 1;
    level thread _ID32723();
}

_ID32723()
{
    while ( !isdefined( level._ID5597 ) )
        wait 0.05;

    foreach ( var_1 in level._ID32797 )
    {
        foreach ( var_3 in var_1._ID13222 )
        {
            var_4 = level._ID10604[var_1.name][var_3._ID34757.label];
            var_4.nodes = var_3.nodes;

            if ( var_1.name != level.teleport_zone_current )
                var_3 delete();
        }
    }
}

teleport_onstartgamesiege()
{
    foreach ( var_1 in level._ID32797 )
    {
        var_1._ID13222 = [];
        var_1._ID10614 = [];
    }

    level.all_dom_flags = level._ID13222;

    foreach ( var_4 in level._ID13222 )
    {
        var_5 = _ID32720( var_4.origin );

        if ( isdefined( var_5 ) )
        {
            var_4._ID32795 = var_5.name;
            var_5._ID13222[var_5._ID13222.size] = var_4;
            var_5._ID10614[var_5._ID10614.size] = var_4._ID34757;
        }
    }

    level._ID10604 = [];

    foreach ( var_1 in level._ID32797 )
    {
        foreach ( var_9 in var_1._ID13222 )
        {
            var_10 = spawnstruct();
            var_10._ID33662 = var_9.origin;
            var_10.visual_origin = var_9._ID34757._ID35361[0].origin;
            var_10.baseeffectpos = var_9._ID34757.baseeffectpos;
            var_10.baseeffectforward = var_9._ID34757.baseeffectforward;
            var_10.baseeffectright = var_9._ID34757.baseeffectright;
            var_10.obj_origin = var_9._ID34757.curorigin;
            var_10._ID22444 = [];

            foreach ( var_12 in level._ID32668 )
            {
                var_13 = "objpoint_" + var_12 + "_" + var_9._ID34757.entnum;
                var_14 = maps\mp\gametypes\_objpoints::getobjpointbyname( var_13 );

                if ( isdefined( var_14 ) )
                    var_10._ID22444[var_12] = ( var_14.x, var_14.y, var_14.z );
            }

            level._ID10604[var_1.name][var_9._ID34757.label] = var_10;
        }
    }

    var_18 = "start";
    level._ID13222 = level._ID32797[var_18]._ID13222;
    level._ID10614 = level._ID32797[var_18]._ID10614;

    foreach ( var_1 in level._ID32797 )
    {
        foreach ( var_4 in var_1._ID13222 )
        {
            if ( var_1.name == var_18 )
                continue;

            var_4._ID34757._ID35361[0] delete();
            var_4._ID34757 maps\mp\gametypes\_gameobjects::deleteuseobject();
        }
    }

    game["teleport_zone_dom"] = var_18;
    _ID32730();
    teleport_onteleportsiege( var_18 );
}

_ID32749()
{
    level._ID32731 = ::_ID32756;
}

_ID32757( var_0 )
{
    var_1 = level._ID32797[level.teleport_zone_current];
    var_2 = level._ID32797[var_0];

    if ( var_0 == level.teleport_zone_current )
        return;

    foreach ( var_4 in level._ID13222 )
    {
        var_5 = level._ID10604[var_0][var_4._ID34757.label];
        var_4.origin = var_5._ID33662;
        var_4._ID34757._ID35361[0].origin = var_5.visual_origin;
        var_4._ID34757.baseeffectpos = var_5.baseeffectpos;
        var_4._ID34757.baseeffectforward = var_5.baseeffectforward;
        var_4._ID34757 maps\mp\gametypes\dom::_ID26122();
        var_4._ID32795 = var_0;
        var_4.nodes = var_5.nodes;

        foreach ( var_8, var_7 in var_4._ID34757._ID32670 )
            objective_position( var_7, var_5.obj_origin );

        foreach ( var_10 in level._ID32668 )
        {
            var_11 = "objpoint_" + var_10 + "_" + var_4._ID34757.entnum;
            var_12 = maps\mp\gametypes\_objpoints::getobjpointbyname( var_11 );
            var_12.x = var_5._ID22444[var_10][0];
            var_12.y = var_5._ID22444[var_10][1];
            var_12.z = var_5._ID22444[var_10][2];
        }
    }
}

teleport_onteleportsiege( var_0 )
{
    foreach ( var_2 in level._ID13222 )
    {
        var_3 = level._ID10604[var_0][var_2._ID34757.label];
        var_2.origin = var_3._ID33662;
        var_2._ID34757._ID35361[0].origin = var_3.visual_origin;
        var_2._ID34757.baseeffectpos = var_3.baseeffectpos;
        var_2._ID34757.baseeffectforward = var_3.baseeffectforward;
        var_2._ID34757 maps\mp\gametypes\dom::_ID26122();
        var_2._ID32795 = var_0;
        var_2.nodes = var_3.nodes;

        foreach ( var_6, var_5 in var_2._ID34757._ID32670 )
            objective_position( var_5, var_3.obj_origin );

        foreach ( var_8 in level._ID32668 )
        {
            var_9 = "objpoint_" + var_8 + "_" + var_2._ID34757.entnum;
            var_10 = maps\mp\gametypes\_objpoints::getobjpointbyname( var_9 );
            var_10.x = var_3._ID22444[var_8][0];
            var_10.y = var_3._ID22444[var_8][1];
            var_10.z = var_3._ID22444[var_8][2];
        }
    }
}

_ID32735( var_0, var_1 )
{
    foreach ( var_3 in level._ID32797[var_1]._ID13222 )
    {
        if ( var_0._ID34757.label == var_3._ID34757.label )
            return var_3;
    }

    return undefined;
}

_ID32756( var_0 )
{
    var_1 = _ID14792( var_0 );

    foreach ( var_3 in level.dogtags )
    {
        var_4 = var_3.curorigin + var_1;
        var_5 = teleport_get_safe_node_near( var_4 );

        if ( isdefined( var_5 ) )
        {
            var_5.last_teleport_time = gettime();
            var_6 = var_5.origin - var_3.curorigin;
            var_3.curorigin = var_3.curorigin + var_6;
            var_3.trigger.origin = var_3.trigger.origin + var_6;
            var_3._ID35361[0].origin = var_3._ID35361[0].origin + var_6;
            var_3._ID35361[1].origin = var_3._ID35361[1].origin + var_6;
            continue;
        }

        var_3 maps\mp\gametypes\conf::_ID26142();
    }
}

teleport_get_safe_node_near( var_0 )
{
    var_1 = gettime();
    var_2 = getnodesinradiussorted( var_0, 300, 0, 200, "Path" );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = var_2[var_3];

        if ( isdefined( var_4.last_teleport_time ) && var_4.last_teleport_time == var_1 )
            continue;

        return var_4;
    }

    return undefined;
}

_ID32720( var_0 )
{
    var_1 = undefined;
    var_2 = undefined;

    foreach ( var_4 in level._ID32797 )
    {
        var_5 = distancesquared( var_4.origin, var_0 );

        if ( !isdefined( var_1 ) || var_5 < var_1 )
        {
            var_1 = var_5;
            var_2 = var_4;
        }
    }

    return var_2;
}

_ID32760( var_0 )
{
    level._ID32786 = var_0;
}

_ID32761( var_0 )
{
    level._ID32787 = var_0;
}

teleport_include_killstreaks( var_0 )
{
    level._ID32739 = var_0;
}

_ID32779( var_0, var_1 )
{
    level._ID32746[var_0] = var_1;
}

_ID32781( var_0, var_1 )
{
    level._ID32769[var_1] = var_0;
}

_ID32780( var_0, var_1 )
{
    level._ID32768[var_1] = var_0;
}

_ID32777( var_0, var_1, var_2 )
{
    level._ID32707[var_0] = var_1;
    level._ID32708[var_0] = var_2;
}

_ID32763( var_0 )
{
    if ( isdefined( var_0._ID23041 ) && var_0._ID23041 )
        return;

    var_0._ID32762 = [];
    var_0._ID32762["none"] = [];
    var_0._ID32762["allies"] = [];
    var_0._ID32762["axis"] = [];
    var_1 = common_scripts\utility::_ID15386( "teleport_zone_" + var_0.name, "targetname" );

    if ( isdefined( var_0.target ) )
    {
        var_2 = common_scripts\utility::_ID15386( var_0.target, "targetname" );
        var_1 = common_scripts\utility::array_combine( var_2, var_1 );
    }

    foreach ( var_4 in var_1 )
    {
        if ( !isdefined( var_4.script_noteworthy ) )
            var_4.script_noteworthy = "teleport_origin";

        switch ( var_4.script_noteworthy )
        {
            case "teleport_origin":
                var_5 = var_4.origin + ( 0, 0, 1 );
                var_6 = var_4.origin - ( 0, 0, 250 );
                var_7 = bullettrace( var_5, var_6, 0 );

                if ( var_7["fraction"] == 1.0 )
                    continue;

                var_4.origin = var_7["position"];
            case "telport_origin_nodrop":
                if ( !isdefined( var_4._ID27766 ) )
                    var_4._ID27766 = "none,axis,allies";

                var_8 = strtok( var_4._ID27766, ", " );

                foreach ( var_10 in var_8 )
                {
                    if ( !isdefined( var_0._ID32762[var_10] ) )
                        continue;

                    if ( !isdefined( var_4.angles ) )
                        var_4.angles = ( 0, 0, 0 );

                    var_11 = var_0._ID32762[var_10].size;
                    var_0._ID32762[var_10][var_11] = var_4;
                }

                continue;
            default:
                continue;
        }
    }

    var_0._ID23041 = 1;
}

_ID32778( var_0 )
{
    level.teleport_zone_current = var_0;

    if ( isdefined( level._ID32746[var_0] ) )
    {
        maps\mp\_compass::_ID29184( level._ID32746[var_0] );
        return;
    }
}

_ID32729( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = level.teleport_zone_current;

    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        if ( !isdefined( var_4.index ) )
            var_4.index = "ent_" + var_4 getentitynumber();

        if ( !isdefined( level._ID32782[var_4.index] ) )
            _ID32742( var_4 );

        if ( level._ID32782[var_4.index].zone == var_1 )
            var_2[var_2.size] = var_4;
    }

    return var_2;
}

_ID32742( var_0 )
{
    if ( isdefined( level._ID32782[var_0.index] ) )
        return;

    var_1 = spawnstruct();
    var_1.spawner = var_0;
    var_2 = undefined;

    foreach ( var_4 in level._ID32797 )
    {
        var_5 = distance( var_4.origin, var_0.origin );

        if ( !isdefined( var_2 ) || var_5 < var_2 )
        {
            var_2 = var_5;
            var_1.zone = var_4.name;
        }
    }

    level._ID32782[var_0.index] = var_1;
}

teleport_is_valid_zone( var_0 )
{
    foreach ( var_3, var_2 in level._ID32797 )
    {
        if ( var_3 == var_0 )
            return 1;
    }

    return 0;
}

_ID32789( var_0, var_1 )
{
    if ( !level._ID32716 )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_2 = level._ID32769[var_0];

    if ( isdefined( var_2 ) && var_1 )
        [[ var_2 ]]();

    var_3 = level._ID32797[level.teleport_zone_current];
    var_4 = level._ID32797[var_0];

    if ( !isdefined( var_3 ) || !isdefined( var_4 ) )
        return;

    _ID32793( var_0 );
    teleport_to_zone_agents( var_0 );

    if ( level._ID32739 )
        _ID32792( var_0 );

    if ( isdefined( level._ID32731 ) )
        [[ level._ID32731 ]]( var_0 );

    _ID32778( var_0 );
    level notify( "teleport_to_zone",  var_0  );
    var_5 = level._ID32768[var_0];

    if ( isdefined( var_5 ) && var_1 )
        [[ var_5 ]]();

    if ( isdefined( level.bot_funcs ) && isdefined( level.bot_funcs["post_teleport"] ) )
    {
        [[ level.bot_funcs["post_teleport"] ]]();
        return;
    }
}

teleport_to_zone_agents( var_0 )
{
    var_1 = maps\mp\agents\_agent_utility::getactiveagentsoftype( "all" );

    foreach ( var_3 in var_1 )
        teleport_to_zone_character( var_0, var_3 );
}

_ID32793( var_0 )
{
    foreach ( var_2 in level.players )
        teleport_to_zone_character( var_0, var_2 );
}

teleport_to_zone_character( var_0, var_1 )
{
    var_2 = level._ID32797[level.teleport_zone_current];
    var_3 = level._ID32797[var_0];
    var_4 = gettime();

    if ( isplayer( var_1 ) && ( var_1.sessionstate == "intermission" || var_1.sessionstate == "spectator" ) )
    {
        var_5 = getentarray( "mp_global_intermission", "classname" );
        var_5 = _ID32729( var_5, var_0 );
        var_6 = var_5[0];
        var_1 dontinterpolate();
        var_1 setorigin( var_6.origin );
        var_1 setplayerangles( var_6.angles );
        return;
    }

    var_7 = undefined;
    var_8 = var_1.angles;

    if ( isplayer( var_1 ) )
        var_8 = var_1 getplayerangles();

    foreach ( var_14, var_10 in var_3._ID32762 )
    {
        var_3._ID32762[var_14] = common_scripts\utility::array_randomize( var_10 );

        foreach ( var_12 in var_10 )
            var_12._ID7314 = 0;
    }

    var_15 = [];

    if ( level._ID32653 )
    {
        if ( isdefined( var_1.team ) && isdefined( var_3._ID32762[var_1.team] ) )
            var_15 = var_3._ID32762[var_1.team];
    }
    else
        var_15 = var_3._ID32762["none"];

    foreach ( var_12 in var_15 )
    {
        if ( !var_12._ID7314 )
        {
            var_7 = var_12.origin;
            var_8 = var_12.angles;
            var_12._ID7314 = 1;
            break;
        }
    }

    var_18 = var_3.origin - var_2.origin;
    var_19 = var_1.origin + var_18;

    if ( !isdefined( var_7 ) && level._ID32787 )
    {
        if ( canspawn( var_19 ) && !positionwouldtelefrag( var_19 ) )
            var_7 = var_19;
    }

    if ( !isdefined( var_7 ) && level._ID32786 )
    {
        var_20 = getnodesinradiussorted( var_19, 300, 0, 200, "Path" );

        for ( var_21 = 0; var_21 < var_20.size; var_21++ )
        {
            var_22 = var_20[var_21];

            if ( isdefined( var_22.last_teleport_time ) && var_22.last_teleport_time == var_4 )
                continue;

            var_12 = var_22.origin;

            if ( canspawn( var_12 ) && !positionwouldtelefrag( var_12 ) )
            {
                var_22.last_teleport_time = var_4;
                var_7 = var_12;
                break;
            }
        }
    }

    if ( !isdefined( var_7 ) )
    {
        var_1 maps\mp\_utility::_suicide();
        return;
    }

    var_1 cancelmantle();
    var_1 dontinterpolate();
    var_1 setorigin( var_7 );
    var_1 setplayerangles( var_8 );
    thread _ID32794( var_1 );
    return;
}

_ID32794( var_0 )
{
    level waittill( "teleport_to_zone" );

    if ( isdefined( var_0 ) )
    {
        var_1 = _ID32720( var_0.origin );

        if ( var_1.name != level.teleport_zone_current )
        {
            var_0 maps\mp\_utility::_suicide();
            return;
        }

        return;
    }
}

_ID14792( var_0 )
{
    var_1 = level._ID32797[var_0];
    var_2 = level._ID32797[level.teleport_zone_current];
    var_3 = var_1.origin - var_2.origin;
    return var_3;
}

_ID32792( var_0 )
{
    var_1 = _ID14792( var_0 );
    teleport_add_delta( level.ac130, var_1 );
    array_levelthread_safe( level._ID16675, ::_ID32710, var_1 );
    array_levelthread_safe( level.heli_loop_nodes, ::_ID32710, var_1 );
    array_levelthread_safe( level._ID16621, ::_ID32710, var_1 );
    array_levelthread_safe( level._ID31881, ::_ID32710, var_1 );
    array_levelthread_safe( level._ID16611, ::_ID32710, var_1 );
    array_levelthread_safe( level._ID16546, ::_ID32710, var_1 );

    if ( isdefined( level.chopper ) )
    {
        level.chopper._ID19345 = 1;
        level.chopper notify( "death" );
    }

    teleport_add_delta( level._ID34167, var_1 );
    teleport_add_delta( level._ID25747, var_1 );
    teleport_add_delta( level._ID16638, var_1 );
    array_thread_safe( level.air_start_nodes, ::teleport_self_add_delta, var_1 );

    foreach ( var_3 in level.air_start_nodes )
        array_thread_safe( var_3._ID21919, ::teleport_self_add_delta, var_1 );

    array_thread_safe( level.air_node_mesh, ::teleport_self_add_delta, var_1 );

    foreach ( var_3 in level.air_node_mesh )
        array_thread_safe( var_3._ID21919, ::teleport_self_add_delta, var_1 );

    array_thread_safe( level._ID20086, ::teleport_notify_death );
    teleport_add_delta( level._ID19723, var_1 );
    var_7 = getent( "airstrikeheight", "targetname" );
    teleport_add_delta( var_7, var_1 );
    var_8 = getentarray( "mp_airsupport", "classname" );
    array_thread_safe( var_8, ::teleport_self_add_delta, var_1 );
    var_9 = getentarray( "heli_attack_area", "targetname" );
    array_thread_safe( var_9, ::teleport_self_add_delta, var_1 );
    array_thread_safe( level._ID19401, ::teleport_self_add_delta, var_1 );
    var_10 = getent( "remote_uav_range", "targetname" );
    teleport_add_delta( var_10, var_1 );

    foreach ( var_12 in level._ID23303 )
    {
        if ( isdefined( var_12.balldrone ) )
            var_12.balldrone teleport_notify_death();
    }

    if ( isdefined( level._ID34657 ) )
    {
        foreach ( var_15 in level._ID34657 )
            var_15 notify( "death" );
    }

    var_17 = getentarray( "remoteMissileSpawn", "targetname" );
    array_thread_safe( var_17, ::teleport_self_add_delta, var_1 );

    foreach ( var_19 in var_17 )
    {
        if ( isdefined( var_19.target ) )
            var_19._ID32605 = getent( var_19.target, "targetname" );

        if ( isdefined( var_19._ID32605 ) )
            teleport_add_delta( var_19._ID32605, var_1 );
    }

    foreach ( var_22 in level._ID17442 )
    {
        var_22 notify( "death" );
        teleport_add_delta( var_22, var_1 );

        if ( !_ID32764( var_22 ) )
            var_22 delete();
    }

    foreach ( var_25 in level._ID34099 )
    {
        var_25 notify( "death" );
        teleport_add_delta( var_25, var_1 );

        if ( !_ID32764( var_25 ) )
            var_25 delete();
    }

    var_27 = teleport_get_care_packages();

    foreach ( var_29 in var_27 )
        var_29 maps\mp\killstreaks\_airdrop::deletecrate();

    var_31 = _ID32734();

    foreach ( var_33 in var_31 )
        var_33 teleport_notify_death();

    foreach ( var_36 in level._ID25810 )
        var_36 teleport_notify_death();

    var_38 = vehicle_getarray();

    foreach ( var_40 in var_38 )
    {
        if ( isdefined( var_40.model ) && var_40.model == "vehicle_odin_mp" )
            var_40 teleport_notify_death();
    }

    if ( isdefined( level._ID32707[var_0] ) )
        level._ID1946 = level._ID32707[var_0];

    if ( isdefined( level._ID32708[var_0] ) )
        level.a10splinesout = level._ID32708[var_0];

    if ( isdefined( level._ID18050 ) )
    {
        level._ID18050["dropped_time"] = -60000;
        return;
    }
}

teleport_notify_death()
{
    if ( isdefined( self ) )
    {
        self notify( "death" );
        return;
    }
}

array_thread_safe( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    if ( !isdefined( var_0 ) )
        return;

    common_scripts\utility::_ID3867( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );
}

array_levelthread_safe( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_0 ) )
        return;

    common_scripts\utility::array_levelthread( var_0, var_1, var_2, var_3, var_4 );
}

teleport_get_care_packages()
{
    return getentarray( "care_package", "targetname" );
}

_ID32734()
{
    var_0 = [];
    var_1 = getentarray( "script_model", "classname" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3.boxtype ) )
            var_0[var_0.size] = var_3;
    }

    return var_0;
}

_ID32764( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = 300;

    var_2 = var_0.origin;
    var_3 = var_0.origin - ( 0, 0, var_1 );
    var_4 = bullettrace( var_2, var_3, 0, var_0 );

    if ( var_4["fraction"] < 1 )
    {
        var_0.origin = var_4["position"];
        return 1;
        return;
    }

    return 0;
    return;
}

_ID32710( var_0, var_1 )
{
    if ( _ID32721( var_0 ) )
        return;

    teleport_add_delta( var_0, var_1 );

    if ( isdefined( var_0.target ) )
    {
        var_2 = getentarray( var_0.target, "targetname" );
        var_3 = common_scripts\utility::_ID15386( var_0.target, "targetname" );
        var_4 = common_scripts\utility::array_combine( var_2, var_3 );
        common_scripts\utility::array_levelthread( var_4, ::_ID32710, var_1 );
        return;
    }
}

_ID32776( var_0 )
{
    _ID32710( self, var_0 );
}

teleport_self_add_delta( var_0 )
{
    teleport_add_delta( self, var_0 );
}

teleport_add_delta( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
    {
        if ( !_ID32721( var_0 ) )
        {
            var_0.origin = var_0.origin + var_1;
            var_0.last_teleport_time = gettime();
            return;
        }

        return;
    }
}

_ID32721( var_0 )
{
    return isdefined( var_0.last_teleport_time ) && var_0.last_teleport_time == gettime();
}

_ID32732()
{
    return level._ID32747[level.teleport_zone_current];
}

teleport_get_active_pathnode_zones()
{
    return level.teleport_pathnode_zones[level.teleport_zone_current];
}
