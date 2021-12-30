// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID37036()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        return;

    setdvar( "scr_alien_intel_pillage", 1 );
    level._ID37508 = ::_ID37510;
    level._ID37511 = ::_ID37034;
    level._ID37509 = ::_ID37509;
    level._ID37763 = [];
    level._ID37514 = [];
    level._ID37516 = [];
    _ID37033( "pillage_intel_section_hard" );
}

_ID37033( var_0 )
{
    var_1 = common_scripts\utility::_ID15386( var_0, "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_4 = common_scripts\utility::_ID15386( var_3.target, "targetname" );
        var_3 _ID37035( var_4 );
    }
}

_ID37035( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3.script_noteworthy ) )
        {
            var_4 = strtok( var_3.script_noteworthy, " " );

            if ( isdefined( var_4 ) && var_4.size > 1 )
            {
                var_5 = "";

                foreach ( var_7 in var_4 )
                    var_5 += var_7;

                iprintln( var_5 );
                var_4 = strtok( var_5, "," );
            }
            else
                var_4 = strtok( var_3.script_noteworthy, "," );

            var_3._ID37513 = var_4[0];

            if ( isdefined( var_4[1] ) )
                var_3.script_model = var_4[1];

            if ( isdefined( var_4[2] ) )
                var_3.location = var_4[2];

            var_3._ID37532 = 1;

            switch ( var_3._ID37513 )
            {
                case "intel_easy":
                    var_3.type = 1;
                    level._ID37514[level._ID37514.size] = var_3;
                    break;
                case "intel_hard":
                    var_3.type = 2;
                    level._ID37516[level._ID37516.size] = var_3;
                    break;
            }

            _ID36665( var_3 );
            var_3 thread _ID37505();
        }
    }
}

_ID37034( var_0 )
{
    var_1 = self;

    if ( isdefined( self.pillageinfo ) )
        self.pillageinfo = undefined;

    var_1.script_model = "cnd_cellphone_01_on";
    var_1._ID37513 = "intel_easy";
    var_1._ID37532 = 1;
    var_1.type = 1;
    level._ID37514[level._ID37514.size] = var_1;
    var_1._ID37127 = ::_ID37128;
    _ID36665( var_1 );
    var_1 thread _ID37505();
}

_ID37509()
{
    var_0 = 6;

    switch ( level.script )
    {
        case "mp_alien_armory":
            var_0 = 6;
            break;
        case "mp_alien_beacon":
            var_0 = 4;
            break;
        case "mp_alien_dlc3":
            var_0 = 3;
            break;
        case "mp_alien_last":
            var_0 = 4;
            break;
        default:
            break;
    }

    var_1 = "intel_episode_" + level._ID37190 + "_sequenced_count";

    if ( self getcoopplayerdatareservedint( var_1 ) < var_0 )
        return 1;
    else
        return 0;
}

init_player_intel_total()
{
    var_0 = "NO_INTEL_ACHIEVEMENT";
    var_1 = 0;
    var_2 = getdvar( "ui_mapname" );

    switch ( var_2 )
    {
        case "mp_alien_armory":
            var_0 = "FOUND_ALL_INTELS";
            var_1 = 2;
            break;
        case "mp_alien_beacon":
            var_0 = "FOUND_ALL_INTELS_MAYDAY";
            break;
        case "mp_alien_dlc3":
            var_0 = "AWAKENING_ALL_INTEL";
            break;
        case "mp_alien_last":
            var_0 = "LAST_ALL_INTEL";
            break;
        default:
            break;
    }

    var_3 = self.achievement_list[var_0];

    if ( isdefined( var_3 ) )
    {
        var_3._ID25048 = aliens_get_intel_num_collected( self ) - var_1;
        var_4 = self getcoopplayerdatareservedint( "intel_episode_4_location_4" );

        if ( var_4 && var_2 == "mp_alien_last" )
            var_3._ID25048 = var_3._ID25048 - 1;

        maps\mp\alien\_achievement::update_achievement( var_0, 0 );
    }
}

_ID37506()
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        return;

    thread init_player_intel_total();
    wait 1.0;

    foreach ( var_1 in level._ID37516 )
    {
        if ( _ID37418( var_1.location ) )
            _ID38177( var_1 );
    }
}

build_intel_pillageitem_arrays( var_0 )
{
    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        return;

    while ( !isdefined( level.pillageinfo ) )
        wait 0.1;

    switch ( var_0 )
    {
        case "easy":
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "intel", level.pillageinfo.easy_intel );
            break;
        case "medium":
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "intel", level.pillageinfo.medium_intel );
            break;
        case "hard":
            maps\mp\alien\_pillage::build_pillageitem_array( var_0, "intel", level.pillageinfo.hard_intel );
            break;
    }
}

_ID37418( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        var_1 = "intel_episode_" + level._ID37190 + "_location_" + var_0;

        if ( self getcoopplayerdatareservedint( var_1 ) )
            return 1;
    }

    return 0;
}

_ID38177( var_0 )
{
    var_0.pillage_trigger disableplayeruse( self );

    if ( var_0.type == 2 )
    {
        if ( !isdefined( self._ID37764 ) )
            self._ID37764 = [];

        if ( !common_scripts\utility::array_contains( self._ID37764, var_0 ) )
        {
            self._ID37764[self._ID37764.size] = var_0;
            var_0 thread wait_then_add_player_to_intel_array( self, 3.0 );
        }
    }

    _ID37886( var_0 );
}

wait_then_add_player_to_intel_array( var_0, var_1 )
{
    var_2 = var_0.name;
    wait(var_1);

    if ( !isdefined( self.player_has_found_me ) )
        self.player_has_found_me = [];

    self.player_has_found_me[var_2] = 1;
}

_ID37505()
{
    self.pillage_trigger = spawn( "script_model", self.origin );

    if ( isdefined( self.script_model ) )
    {
        self.pillage_trigger setmodel( self.script_model );

        if ( isdefined( self.angles ) )
            self.pillage_trigger.angles = self.angles;
    }
    else
        self.pillage_trigger setmodel( "tag_origin" );

    thread _ID38158();
    self.pillage_trigger setcursorhint( "HINT_NOICON" );
    self.pillage_trigger makeusable();

    if ( self.type == 1 )
        self.pillage_trigger sethintstring( &"ALIEN_PILLAGE_INTEL_PICKUP_INTEL" );
    else
        self.pillage_trigger sethintstring( &"ALIEN_PILLAGE_INTEL_PICKUP_INTEL" );

    for (;;)
    {
        self.pillage_trigger waittill( "trigger",  var_0  );

        if ( self.type == 1 && var_0 _ID37509() )
            _ID37373( var_0 );

        if ( self.type == 2 && !var_0 _ID37418( self.location ) )
            _ID37373( var_0 );
    }
}

aliens_get_intel_num_possible()
{
    var_0 = 0;
    var_1 = 0;
    var_2 = 0;
    var_3 = getdvar( "ui_mapname" );

    switch ( var_3 )
    {
        case "mp_alien_armory":
            var_0 = 2;
            var_1 = 6;
            var_2 = 5;
            break;
        case "mp_alien_beacon":
            var_0 = 0;
            var_1 = 4;
            var_2 = 5;
            break;
        case "mp_alien_dlc3":
            var_0 = 0;
            var_1 = 3;
            var_2 = 3;
            break;
        case "mp_alien_last":
            var_0 = 0;
            var_1 = 4;
            var_2 = 4;
            break;
    }

    return var_0 + var_1 + var_2;
}

aliens_get_intel_num_collected( var_0 )
{
    var_1 = 0;
    var_2 = 5;
    var_3 = getdvar( "ui_mapname" );

    switch ( var_3 )
    {
        case "mp_alien_armory":
            var_1 = 2;
            var_2 = 5;
            break;
        case "mp_alien_beacon":
            var_1 = 0;
            var_2 = 5;
            break;
        case "mp_alien_dlc3":
            var_1 = 0;
            var_2 = 3;
            break;
        case "mp_alien_last":
            var_1 = 0;
            var_2 = 4;
            break;
    }

    var_4 = "intel_episode_" + level._ID37190 + "_sequenced_count";
    var_5 = var_0 getcoopplayerdatareservedint( var_4 );
    var_6 = 0;

    for ( var_7 = 0; var_7 < var_2; var_7++ )
    {
        var_8 = "intel_episode_" + level._ID37190 + "_location_" + ( var_7 + 1 );

        if ( var_0 getcoopplayerdatareservedint( var_8 ) )
            var_6++;
    }

    return var_1 + var_5 + var_6;
}

give_player_easter_egg_intel( var_0 )
{
    var_1 = "intel_episode_" + level._ID37190 + "_location_4";

    if ( var_0 getcoopplayerdatareservedint( var_1 ) )
        return;

    var_0 setclientomnvar( "ui_alien_intel_num_collected", aliens_get_intel_num_collected( var_0 ) + 1 );
    wait 0.5;
    var_0 notify( "dlc_vo_notify",  "intel_recovered", var_0  );
    var_2 = 8;
    var_3 = _ID14835( var_2 );
    var_0 thread _ID37780( var_3 );
    var_0 setclientomnvar( "ui_alien_intercept_pickup", var_2 );
    var_0 setcoopplayerdatareservedint( var_1, 1 );
}

_ID37373( var_0 )
{
    var_0 setclientomnvar( "ui_alien_intel_num_collected", aliens_get_intel_num_collected( var_0 ) + 1 );
    wait 0.5;
    var_1 = getdvar( "ui_mapname" );
    var_0 notify( "dlc_vo_notify",  "intel_recovered", var_0  );

    if ( isdefined( self.location ) && self.type == 2 )
    {
        var_2 = 0;

        switch ( var_1 )
        {
            case "mp_alien_armory":
                var_2 = 8;
                break;
            case "mp_alien_beacon":
                var_2 = 4;
                break;
            case "mp_alien_dlc3":
                var_2 = 3;
                break;
            case "mp_alien_last":
                var_2 = 4;
                break;
        }

        var_3 = int( self.location ) + var_2;
        var_4 = _ID14835( var_3 );
        var_0 thread _ID37780( var_4 );
        var_0 setclientomnvar( "ui_alien_intercept_pickup", var_3 );
        var_5 = "intel_episode_" + level._ID37190 + "_location_" + self.location;
        var_0 setcoopplayerdatareservedint( var_5, 1 );
        var_0 _ID38177( self );
        var_0 maps\mp\alien\_persistence::_ID15551( 500 );
        var_0 maps\mp\alien\_persistence::give_player_xp( 2500 );
        var_0 maps\mp\alien\_achievement::_ID38208();
    }
    else if ( self.type == 1 )
    {
        var_6 = 0;

        switch ( var_1 )
        {
            case "mp_alien_armory":
                var_6 = 3;
                break;
            case "mp_alien_beacon":
                var_6 = 1;
                break;
            case "mp_alien_dlc3":
                var_6 = 1;
                break;
            case "mp_alien_last":
                var_6 = 1;
                break;
        }

        var_7 = "intel_episode_" + level._ID37190 + "_sequenced_count";
        var_8 = var_0 getcoopplayerdatareservedint( var_7 );
        var_9 = var_8 + var_6;
        var_4 = _ID14835( var_9 );
        var_0 thread _ID37780( var_4 );
        var_0 setclientomnvar( "ui_alien_nightfall_pickup", var_9 );
        var_0 setcoopplayerdatareservedint( var_7, var_8 + 1 );
        var_0 maps\mp\alien\_achievement::_ID38208();
        maps\mp\alien\_outline_proto::remove_outline( self.pillage_trigger );
        self.pillageinfo = spawnstruct();
        self.pillageinfo.type = undefined;
        maps\mp\alien\_pillage::_ID9586();
        var_0 maps\mp\alien\_persistence::_ID15551( 500 );
        var_0 maps\mp\alien\_persistence::give_player_xp( 2500 );
    }
}

_ID37780( var_0 )
{
    wait 1.0;

    if ( soundexists( var_0 ) )
        self playsoundtoplayer( var_0, self );
}

_ID14835( var_0 )
{
    if ( !isdefined( level._ID37512 ) )
    {
        var_1 = getdvar( "ui_mapname" );

        switch ( var_1 )
        {
            case "mp_alien_armory":
                level._ID37512 = "mp/alien/alien_armory_intel.csv";
                break;
            case "mp_alien_beacon":
                level._ID37512 = "mp/alien/alien_beacon_intel.csv";
                break;
            case "mp_alien_dlc3":
                level._ID37512 = "mp/alien/alien_dlc3_intel.csv";
                break;
            case "mp_alien_last":
                level._ID37512 = "mp/alien/alien_last_intel.csv";
                break;
        }
    }

    var_2 = tablelookup( level._ID37512, 0, var_0, 15 );
    return var_2;
}

_ID37128( var_0 )
{
    if ( self.pillage_trigger.model != "tag_origin" )
    {
        var_1 = ( 0, 0, 20 );
        var_2 = ( 0, 0, 1 );
        var_3 = ( 0, 0, 0 );
        var_4 = ( 0, 0, 6 );
        var_5 = ( 0, 0, 0 );
        var_6 = getgroundposition( self.pillage_trigger.origin + var_1, 2 );

        switch ( self.pillage_trigger.model )
        {
            case "cnd_cellphone_01_on":
                var_4 = var_2;
                var_5 = ( 0, 0, -90 );
                break;
        }

        self.pillage_trigger.origin = var_6 + var_4;
        self.pillage_trigger.angles = var_5;
    }

    thread _ID38178();
}

_ID38178()
{
    foreach ( var_1 in level.players )
    {
        if ( !var_1 _ID37509() )
            var_1 thread _ID38177( self );
    }
}

_ID38158()
{
    self endon( "death" );
    self.pillage_trigger endon( "death" );
    var_0 = 1;
    var_1 = 2;
    var_2 = 1024;
    var_3 = 4900;

    if ( self.type == var_0 )
        var_3 = 27225;

    while ( !isdefined( level.players ) )
        wait 0.1;

    for (;;)
    {
        foreach ( var_5 in level.players )
        {
            if ( !isdefined( var_5 ) || !isalive( var_5 ) )
                continue;

            var_6 = 1;

            if ( distancesquared( var_5.origin, self.pillage_trigger.origin ) > var_3 )
                var_6 = 0;

            if ( distancesquared( var_5.origin, self.pillage_trigger.origin ) < var_2 && should_display_already_found_message( var_5 ) )
            {
                var_5 maps\mp\_utility::setlowermessage( "already_have_intel", &"ALIEN_PILLAGE_INTEL_ALREADY_HAVE_INTEL", 2 );
                common_scripts\utility::_ID35582();
                continue;
            }

            if ( self.type == var_1 && var_5 _ID37418( self.location ) )
            {
                var_5 _ID38177( self );
                var_6 = 0;
            }
            else if ( self.type == var_0 && !var_5 _ID37509() )
            {
                var_5 _ID38177( self );
                var_6 = 0;
            }

            if ( isdefined( var_5._ID37764 ) && common_scripts\utility::array_contains( var_5._ID37764, self ) )
                var_6 = 0;

            if ( var_6 )
                _ID37159( var_5 );
            else
                _ID37112( var_5 );

            common_scripts\utility::_ID35582();
        }

        wait 0.1;
    }
}

should_display_already_found_message( var_0 )
{
    if ( isdefined( self.player_has_found_me ) && isdefined( self.player_has_found_me[var_0.name] ) && self.player_has_found_me[var_0.name] )
        return 1;

    return 0;
}

_ID37159( var_0 )
{
    self.pillage_trigger enableplayeruse( var_0 );
}

_ID37112( var_0 )
{
    self.pillage_trigger disableplayeruse( var_0 );
}

_ID37510()
{
    self endon( "refresh_outline" );

    foreach ( var_3, var_1 in level._ID37763 )
    {
        if ( !isdefined( var_1 ) || !isdefined( var_1.pillage_trigger ) )
            continue;

        var_2 = _ID37287( var_1 );

        if ( var_2 == 3 )
            maps\mp\alien\_outline_proto::enable_outline_for_player( var_1.pillage_trigger, self, 3, 0, "high" );
        else if ( var_2 == 4 )
            maps\mp\alien\_outline_proto::enable_outline_for_player( var_1.pillage_trigger, self, 1, 0, "high" );
        else
            maps\mp\alien\_outline_proto::disable_outline_for_player( var_1.pillage_trigger, self );

        if ( var_3 % 10 == 0 )
            common_scripts\utility::_ID35582();
    }
}

_ID37287( var_0 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_0.pillage_trigger ) )
        return 0;

    if ( isdefined( self._ID37764 ) && common_scripts\utility::array_contains( self._ID37764, var_0 ) )
        return 0;

    if ( var_0.type == 1 )
        var_1 = 27225;
    else
        var_1 = 4900;

    var_2 = distancesquared( self.origin, var_0.origin ) < var_1;

    if ( !var_2 )
        return 0;

    if ( maps\mp\alien\_unk1464::_ID18431() || maps\mp\alien\_unk1464::has_special_weapon() )
        return 4;

    return 3;
}

_ID36665( var_0 )
{
    if ( !common_scripts\utility::array_contains( level._ID37763, var_0 ) )
        level._ID37763[level._ID37763.size] = var_0;
}

_ID37886( var_0 )
{
    _ID37888( self, var_0.pillage_trigger );
}

_ID37888( var_0, var_1 )
{
    if ( !isdefined( var_1 ) || !isdefined( var_0 ) )
        return;

    maps\mp\alien\_outline_proto::disable_outline_for_player( var_1, var_0 );
}
