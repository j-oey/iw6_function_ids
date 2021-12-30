// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID9894 = 50;
    level.destructiblespawnedents = [];
    level._ID8686 = 0;
    level.commonstarttime = gettime();

    if ( !isdefined( level.fast_destructible_explode ) )
        level.fast_destructible_explode = 0;

    if ( !isdefined( level.func ) )
        level.func = [];

    var_0 = 1;

    if ( var_0 )
        find_destructibles();

    var_1 = getentarray( "delete_on_load", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 delete();

    _ID17719();
    _ID17721();
}

debgugprintdestructiblelist()
{

}

find_destructibles()
{
    if ( !isdefined( level._ID9850 ) )
        level._ID9850 = [];

    var_0 = [];

    foreach ( var_2 in level.struct )
    {
        if ( isdefined( var_2.script_noteworthy ) && var_2.script_noteworthy == "destructible_dot" )
            var_0[var_0.size] = var_2;
    }

    var_4 = getentarray( "destructible_vehicle", "targetname" );

    foreach ( var_6 in var_4 )
        var_6 thread _ID28984( var_0 );

    var_8 = getentarray( "destructible_toy", "targetname" );

    foreach ( var_10 in var_8 )
        var_10 thread _ID28984( var_0 );

    debgugprintdestructiblelist();
}

_ID28984( var_0 )
{
    _ID28983();
    _ID28982( var_0 );
}

_ID28982( var_0 )
{
    var_1 = self._ID9891;

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( level.destructible_type[var_1].destructible_dots ) )
            return;

        if ( isdefined( var_3._ID27766 ) && issubstr( var_3._ID27766, "destructible_type" ) && issubstr( var_3._ID27766, self.destructible_type ) )
        {
            if ( distancesquared( self.origin, var_3.origin ) < 1 )
            {
                var_4 = getentarray( var_3.target, "targetname" );
                level.destructible_type[var_1].destructible_dots = [];

                foreach ( var_6 in var_4 )
                {
                    var_7 = var_6._ID27651;

                    if ( !isdefined( level.destructible_type[var_1].destructible_dots[var_7] ) )
                        level.destructible_type[var_1].destructible_dots[var_7] = [];

                    var_8 = level.destructible_type[var_1].destructible_dots[var_7].size;
                    level.destructible_type[var_1].destructible_dots[var_7][var_8]["classname"] = var_6.classname;
                    level.destructible_type[var_1].destructible_dots[var_7][var_8]["origin"] = var_6.origin;
                    var_9 = common_scripts\utility::_ID32831( isdefined( var_6.spawnflags ), var_6.spawnflags, 0 );
                    level.destructible_type[var_1].destructible_dots[var_7][var_8]["spawnflags"] = var_9;

                    switch ( var_6.classname )
                    {
                        case "trigger_radius":
                            level.destructible_type[var_1].destructible_dots[var_7][var_8]["radius"] = var_6.height;
                            level.destructible_type[var_1].destructible_dots[var_7][var_8]["height"] = var_6.height;
                            break;
                    }

                    endswitch( 2 )  case "trigger_radius" loc_2A3 default loc_2DC
                    var_6 delete();
                }

                break;
            }
        }
    }
}

_ID9854( var_0 )
{
    if ( !isdefined( level.destructible_type ) )
        return -1;

    if ( level.destructible_type.size == 0 )
        return -1;

    for ( var_1 = 0; var_1 < level.destructible_type.size; var_1++ )
    {
        if ( var_0 == level.destructible_type[var_1]._ID34830["type"] )
            return var_1;
    }

    return -1;
}

_ID9855( var_0 )
{
    var_1 = _ID9854( var_0 );

    if ( var_1 >= 0 )
        return var_1;

    if ( !isdefined( level._ID9850[var_0] ) )
    {

    }

    [[ level._ID9850[var_0] ]]();
    var_1 = _ID9854( var_0 );
    return var_1;
}

_ID28983()
{
    var_0 = undefined;
    self.modeldummyon = 0;
    add_damage_owner_recorder();
    self._ID9891 = _ID9855( self.destructible_type );

    if ( self._ID9891 < 0 )
        return;

    _ID24837();
    add_destructible_fx();

    if ( isdefined( level.destructible_transient ) && isdefined( level.destructible_transient[self.destructible_type] ) )
        common_scripts\utility::flag_wait( level.destructible_transient[self.destructible_type] + "_loaded" );

    if ( isdefined( level.destructible_type[self._ID9891].attachedmodels ) )
    {
        foreach ( var_3 in level.destructible_type[self._ID9891].attachedmodels )
        {
            if ( isdefined( var_3.tag ) )
                self attach( var_3.model, var_3.tag );
            else
                self attach( var_3.model );

            if ( self.modeldummyon )
            {
                if ( isdefined( var_3.tag ) )
                {
                    self._ID21272 attach( var_3.model, var_3.tag );
                    continue;
                }

                self._ID21272 attach( var_3.model );
            }
        }
    }

    if ( isdefined( level.destructible_type[self._ID9891]._ID23309 ) )
    {
        self.destructible_parts = [];

        for ( var_5 = 0; var_5 < level.destructible_type[self._ID9891]._ID23309.size; var_5++ )
        {
            self.destructible_parts[var_5] = spawnstruct();
            self.destructible_parts[var_5]._ID34830["currentState"] = 0;

            if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_5][0]._ID34830["health"] ) )
                self.destructible_parts[var_5]._ID34830["health"] = level.destructible_type[self._ID9891]._ID23309[var_5][0]._ID34830["health"];

            if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_5][0]._ID34830["random_dynamic_attachment_1"] ) )
            {
                var_6 = randomint( level.destructible_type[self._ID9891]._ID23309[var_5][0]._ID34830["random_dynamic_attachment_1"].size );
                var_7 = level.destructible_type[self._ID9891]._ID23309[var_5][0]._ID34830["random_dynamic_attachment_tag"][var_6];
                var_8 = level.destructible_type[self._ID9891]._ID23309[var_5][0]._ID34830["random_dynamic_attachment_1"][var_6];
                var_9 = level.destructible_type[self._ID9891]._ID23309[var_5][0]._ID34830["random_dynamic_attachment_2"][var_6];
                var_10 = level.destructible_type[self._ID9891]._ID23309[var_5][0]._ID34830["clipToRemove"][var_6];
                thread _ID10307( var_7, var_8, var_9, var_10 );
            }

            if ( var_5 == 0 )
                continue;

            var_11 = level.destructible_type[self._ID9891]._ID23309[var_5][0]._ID34830["modelName"];
            var_12 = level.destructible_type[self._ID9891]._ID23309[var_5][0]._ID34830["tagName"];

            for ( var_13 = 1; isdefined( level.destructible_type[self._ID9891]._ID23309[var_5][var_13] ); var_13++ )
            {
                var_14 = level.destructible_type[self._ID9891]._ID23309[var_5][var_13]._ID34830["tagName"];
                var_15 = level.destructible_type[self._ID9891]._ID23309[var_5][var_13]._ID34830["modelName"];

                if ( isdefined( var_14 ) && var_14 != var_12 )
                {
                    _ID16895( var_14 );

                    if ( self.modeldummyon )
                        self._ID21272 _ID16895( var_14 );
                }
            }
        }
    }

    if ( isdefined( self.target ) )
        thread destructible_handles_collision_brushes();

    if ( self.code_classname != "script_vehicle" )
        self setcandamage( 1 );

    if ( common_scripts\utility::_ID18787() )
        thread connecttraverses();

    thread _ID9885();
}

destructible_create( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( level.destructible_type ) )
        level.destructible_type = [];

    var_6 = level.destructible_type.size;
    var_6 = level.destructible_type.size;
    level.destructible_type[var_6] = spawnstruct();
    level.destructible_type[var_6]._ID34830["type"] = var_0;
    level.destructible_type[var_6]._ID23309 = [];
    level.destructible_type[var_6]._ID23309[0][0] = spawnstruct();
    level.destructible_type[var_6]._ID23309[0][0]._ID34830["modelName"] = self.model;
    level.destructible_type[var_6]._ID23309[0][0]._ID34830["tagName"] = var_1;
    level.destructible_type[var_6]._ID23309[0][0]._ID34830["health"] = var_2;
    level.destructible_type[var_6]._ID23309[0][0]._ID34830["validAttackers"] = var_3;
    level.destructible_type[var_6]._ID23309[0][0]._ID34830["validDamageZone"] = var_4;
    level.destructible_type[var_6]._ID23309[0][0]._ID34830["validDamageCause"] = var_5;
    level.destructible_type[var_6]._ID23309[0][0]._ID34830["godModeAllowed"] = 1;
    level.destructible_type[var_6]._ID23309[0][0]._ID34830["rotateTo"] = self.angles;
    level.destructible_type[var_6]._ID23309[0][0]._ID34830["vehicle_exclude_anim"] = 0;
}

_ID9867( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_10 = level.destructible_type.size - 1;
    var_11 = level.destructible_type[var_10]._ID23309.size;
    var_12 = 0;
    destructible_info( var_11, var_12, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, undefined, var_9 );
}

destructible_state( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = level.destructible_type.size - 1;
    var_9 = level.destructible_type[var_8]._ID23309.size - 1;
    var_10 = level.destructible_type[var_8]._ID23309[var_9].size;

    if ( !isdefined( var_0 ) && var_9 == 0 )
        var_0 = level.destructible_type[var_8]._ID23309[var_9][0]._ID34830["tagName"];

    destructible_info( var_9, var_10, var_0, var_1, var_2, var_3, var_4, var_5, undefined, undefined, var_6, var_7 );
}

_ID9851( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( !isdefined( var_4 ) )
        var_4 = 0;

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    var_6 = level.destructible_type.size - 1;
    var_7 = level.destructible_type[var_6]._ID23309.size - 1;
    var_8 = level.destructible_type[var_6]._ID23309[var_7].size - 1;
    var_9 = 0;

    if ( isdefined( level.destructible_type[var_6]._ID23309[var_7][var_8]._ID34830["fx_filename"] ) )
    {
        if ( isdefined( level.destructible_type[var_6]._ID23309[var_7][var_8]._ID34830["fx_filename"][var_4] ) )
            var_9 = level.destructible_type[var_6]._ID23309[var_7][var_8]._ID34830["fx_filename"][var_4].size;
    }

    if ( isdefined( var_3 ) )
        level.destructible_type[var_6]._ID23309[var_7][var_8]._ID34830["fx_valid_damagetype"][var_4][var_9] = var_3;

    level.destructible_type[var_6]._ID23309[var_7][var_8]._ID34830["fx_filename"][var_4][var_9] = var_1;
    level.destructible_type[var_6]._ID23309[var_7][var_8]._ID34830["fx_tag"][var_4][var_9] = var_0;
    level.destructible_type[var_6]._ID23309[var_7][var_8]._ID34830["fx_useTagAngles"][var_4][var_9] = var_2;
    level.destructible_type[var_6]._ID23309[var_7][var_8]._ID34830["fx_cost"][var_4][var_9] = var_5;
}

_ID9837( var_0 )
{
    var_1 = level.destructible_type.size - 1;
    var_2 = level.destructible_type[var_1]._ID23309.size - 1;
    var_3 = level.destructible_type[var_1]._ID23309[var_2].size - 1;

    if ( !isdefined( level.destructible_type[var_1]._ID23309[var_2][var_3]._ID34830["dot"] ) )
        level.destructible_type[var_1]._ID23309[var_2][var_3]._ID34830["dot"] = [];

    var_4 = level.destructible_type[var_1]._ID23309[var_2][var_3]._ID34830["dot"].size;
    var_5 = createdot();
    var_5.type = "predefined";
    var_5.index = var_0;
    level.destructible_type[var_1]._ID23309[var_2][var_3]._ID34830["dot"][var_4] = var_5;
}

destructible_createdot_radius( var_0, var_1, var_2, var_3 )
{
    var_4 = level.destructible_type.size - 1;
    var_5 = level.destructible_type[var_4]._ID23309.size - 1;
    var_6 = level.destructible_type[var_4]._ID23309[var_5].size - 1;

    if ( !isdefined( level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["dot"] ) )
        level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["dot"] = [];

    var_7 = level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["dot"].size;
    var_8 = createdot_radius( ( 0, 0, 0 ), var_1, var_2, var_3 );
    var_8.tag = var_0;
    level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["dot"][var_7] = var_8;
}

_ID9874( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = level.destructible_type.size - 1;
    var_9 = level.destructible_type[var_8]._ID23309.size - 1;
    var_10 = level.destructible_type[var_8]._ID23309[var_9].size - 1;
    var_11 = level.destructible_type[var_8]._ID23309[var_9][var_10]._ID34830["dot"].size - 1;
    var_12 = level.destructible_type[var_8]._ID23309[var_9][var_10]._ID34830["dot"][var_11];
    var_12 _ID28704( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 );
    initdot( var_6 );
}

destructible_setdot_ontickfunc( var_0, var_1, var_2 )
{
    var_3 = level.destructible_type.size - 1;
    var_4 = level.destructible_type[var_3]._ID23309.size - 1;
    var_5 = level.destructible_type[var_3]._ID23309[var_4].size - 1;
    var_6 = level.destructible_type[var_3]._ID23309[var_4][var_5]._ID34830["dot"].size - 1;
    var_7 = level.destructible_type[var_3]._ID23309[var_4][var_5]._ID34830["dot"][var_6];
    var_8 = var_7._ID32975.size;
    var_7._ID32975[var_8]._ID22825 = var_0;
    var_7._ID32975[var_8]._ID22836 = var_1;
    var_7._ID32975[var_8].ondeathfunc = var_2;
}

_ID9830( var_0, var_1 )
{
    var_2 = level.destructible_type.size - 1;
    var_3 = level.destructible_type[var_2]._ID23309.size - 1;
    var_4 = level.destructible_type[var_2]._ID23309[var_3].size - 1;
    var_5 = level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830["dot"].size - 1;
    var_6 = level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830["dot"][var_5];
    var_6 builddot_ontick( var_0, var_1 );
}

destructible_builddot_startloop( var_0 )
{
    var_1 = level.destructible_type.size - 1;
    var_2 = level.destructible_type[var_1]._ID23309.size - 1;
    var_3 = level.destructible_type[var_1]._ID23309[var_2].size - 1;
    var_4 = level.destructible_type[var_1]._ID23309[var_2][var_3]._ID34830["dot"].size - 1;
    var_5 = level.destructible_type[var_1]._ID23309[var_2][var_3]._ID34830["dot"][var_4];
    var_5 _ID6235( var_0 );
}

_ID9829( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = level.destructible_type.size - 1;
    var_7 = level.destructible_type[var_6]._ID23309.size - 1;
    var_8 = level.destructible_type[var_6]._ID23309[var_7].size - 1;
    var_9 = level.destructible_type[var_6]._ID23309[var_7][var_8]._ID34830["dot"].size - 1;
    var_10 = level.destructible_type[var_6]._ID23309[var_7][var_8]._ID34830["dot"][var_9];
    var_10 builddot_damage( var_0, var_1, var_2, var_3, var_4, var_5 );
}

destructible_builddot_wait( var_0 )
{
    var_1 = level.destructible_type.size - 1;
    var_2 = level.destructible_type[var_1]._ID23309.size - 1;
    var_3 = level.destructible_type[var_1]._ID23309[var_2].size - 1;
    var_4 = level.destructible_type[var_1]._ID23309[var_2][var_3]._ID34830["dot"].size - 1;
    var_5 = level.destructible_type[var_1]._ID23309[var_2][var_3]._ID34830["dot"][var_4];
    var_5 builddot_wait( var_0 );
}

destructible_loopfx( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 0;

    var_4 = level.destructible_type.size - 1;
    var_5 = level.destructible_type[var_4]._ID23309.size - 1;
    var_6 = level.destructible_type[var_4]._ID23309[var_5].size - 1;
    var_7 = 0;

    if ( isdefined( level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["loopfx_filename"] ) )
        var_7 = level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["loopfx_filename"].size;

    level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["loopfx_filename"][var_7] = var_1;
    level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["loopfx_tag"][var_7] = var_0;
    level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["loopfx_rate"][var_7] = var_2;
    level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["loopfx_cost"][var_7] = var_3;
}

_ID9858( var_0, var_1, var_2, var_3 )
{
    var_4 = level.destructible_type.size - 1;
    var_5 = level.destructible_type[var_4]._ID23309.size - 1;
    var_6 = level.destructible_type[var_4]._ID23309[var_5].size - 1;
    level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["healthdrain_amount"] = var_0;
    level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["healthdrain_interval"] = var_1;
    level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["badplace_radius"] = var_2;
    level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["badplace_team"] = var_3;
}

_ID9877( var_0, var_1, var_2 )
{
    var_3 = level.destructible_type.size - 1;
    var_4 = level.destructible_type[var_3]._ID23309.size - 1;
    var_5 = level.destructible_type[var_3]._ID23309[var_4].size - 1;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( level.destructible_type[var_3]._ID23309[var_4][var_5]._ID34830["sound"] ) )
    {
        level.destructible_type[var_3]._ID23309[var_4][var_5]._ID34830["sound"] = [];
        level.destructible_type[var_3]._ID23309[var_4][var_5]._ID34830["soundCause"] = [];
    }

    if ( !isdefined( level.destructible_type[var_3]._ID23309[var_4][var_5]._ID34830["sound"][var_2] ) )
    {
        level.destructible_type[var_3]._ID23309[var_4][var_5]._ID34830["sound"][var_2] = [];
        level.destructible_type[var_3]._ID23309[var_4][var_5]._ID34830["soundCause"][var_2] = [];
    }

    var_6 = level.destructible_type[var_3]._ID23309[var_4][var_5]._ID34830["sound"][var_2].size;
    level.destructible_type[var_3]._ID23309[var_4][var_5]._ID34830["sound"][var_2][var_6] = var_0;
    level.destructible_type[var_3]._ID23309[var_4][var_5]._ID34830["soundCause"][var_2][var_6] = var_1;
}

_ID9862( var_0, var_1 )
{
    var_2 = level.destructible_type.size - 1;
    var_3 = level.destructible_type[var_2]._ID23309.size - 1;
    var_4 = level.destructible_type[var_2]._ID23309[var_3].size - 1;

    if ( !isdefined( level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830["loopsound"] ) )
    {
        level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830["loopsound"] = [];
        level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830["loopsoundCause"] = [];
    }

    var_5 = level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830["loopsound"].size;
    level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830["loopsound"][var_5] = var_0;
    level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830["loopsoundCause"][var_5] = var_1;
}

_ID9824( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_4 ) )
        var_4 = 0;

    var_9 = [];
    var_9["anim"] = var_0;
    var_9["animTree"] = var_1;
    var_9["animType"] = var_2;
    var_9["vehicle_exclude_anim"] = var_3;
    var_9["groupNum"] = var_4;
    var_9["mpAnim"] = var_5;
    var_9["maxStartDelay"] = var_6;
    var_9["animRateMin"] = var_7;
    var_9["animRateMax"] = var_8;
    add_array_to_destructible( "animation", var_9 );
}

destructible_spotlight( var_0 )
{
    var_1 = [];
    var_1["spotlight_tag"] = var_0;
    var_1["spotlight_fx"] = "spotlight_fx";
    var_1["spotlight_brightness"] = 0.85;
    var_1["randomly_flip"] = 1;
    add_keypairs_to_destructible( var_1 );
}

add_key_to_destructible( var_0, var_1 )
{
    var_2 = [];
    var_2[var_0] = var_1;
    add_keypairs_to_destructible( var_2 );
}

add_keypairs_to_destructible( var_0 )
{
    var_1 = level.destructible_type.size - 1;
    var_2 = level.destructible_type[var_1]._ID23309.size - 1;
    var_3 = level.destructible_type[var_1]._ID23309[var_2].size - 1;

    foreach ( var_6, var_5 in var_0 )
        level.destructible_type[var_1]._ID23309[var_2][var_3]._ID34830[var_6] = var_5;
}

add_array_to_destructible( var_0, var_1 )
{
    var_2 = level.destructible_type.size - 1;
    var_3 = level.destructible_type[var_2]._ID23309.size - 1;
    var_4 = level.destructible_type[var_2]._ID23309[var_3].size - 1;
    var_5 = level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830;

    if ( !isdefined( var_5[var_0] ) )
        var_5[var_0] = [];

    var_5[var_0][var_5[var_0].size] = var_1;
    level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830 = var_5;
}

destructible_car_alarm()
{
    var_0 = level.destructible_type.size - 1;
    var_1 = level.destructible_type[var_0]._ID23309.size - 1;
    var_2 = level.destructible_type[var_0]._ID23309[var_1].size - 1;
    level.destructible_type[var_0]._ID23309[var_1][var_2]._ID34830["triggerCarAlarm"] = 1;
}

destructible_lights_out( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 256;

    var_1 = level.destructible_type.size - 1;
    var_2 = level.destructible_type[var_1]._ID23309.size - 1;
    var_3 = level.destructible_type[var_1]._ID23309[var_2].size - 1;
    level.destructible_type[var_1]._ID23309[var_2][var_3]._ID34830["break_nearby_lights"] = var_0;
}

_ID25360( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = "";

    var_4 = level.destructible_type.size - 1;
    var_5 = level.destructible_type[var_4]._ID23309.size - 1;
    var_6 = 0;

    if ( !isdefined( level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["random_dynamic_attachment_1"] ) )
    {
        level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["random_dynamic_attachment_1"] = [];
        level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["random_dynamic_attachment_2"] = [];
        level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["random_dynamic_attachment_tag"] = [];
    }

    var_7 = level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["random_dynamic_attachment_1"].size;
    level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["random_dynamic_attachment_1"][var_7] = var_1;
    level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["random_dynamic_attachment_2"][var_7] = var_2;
    level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["random_dynamic_attachment_tag"][var_7] = var_0;
    level.destructible_type[var_4]._ID23309[var_5][var_6]._ID34830["clipToRemove"][var_7] = var_3;
}

destructible_physics( var_0, var_1 )
{
    var_2 = level.destructible_type.size - 1;
    var_3 = level.destructible_type[var_2]._ID23309.size - 1;
    var_4 = level.destructible_type[var_2]._ID23309[var_3].size - 1;

    if ( !isdefined( level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830["physics"] ) )
    {
        level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830["physics"] = [];
        level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830["physics_tagName"] = [];
        level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830["physics_velocity"] = [];
    }

    var_5 = level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830["physics"].size;
    level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830["physics"][var_5] = 1;
    level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830["physics_tagName"][var_5] = var_0;
    level.destructible_type[var_2]._ID23309[var_3][var_4]._ID34830["physics_velocity"][var_5] = var_1;
}

_ID9880( var_0 )
{
    var_1 = level.destructible_type.size - 1;
    var_2 = level.destructible_type[var_1]._ID23309.size - 1;
    var_3 = level.destructible_type[var_1]._ID23309[var_2].size - 1;
    level.destructible_type[var_1]._ID23309[var_2][var_3]._ID34830["splash_damage_scaler"] = var_0;
}

_ID9844( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    var_12 = level.destructible_type.size - 1;
    var_13 = level.destructible_type[var_12]._ID23309.size - 1;
    var_14 = level.destructible_type[var_12]._ID23309[var_13].size - 1;

    if ( common_scripts\utility::_ID18787() )
        level.destructible_type[var_12]._ID23309[var_13][var_14]._ID34830["explode_range"] = var_2;
    else
        level.destructible_type[var_12]._ID23309[var_13][var_14]._ID34830["explode_range"] = var_3;

    level.destructible_type[var_12]._ID23309[var_13][var_14]._ID34830["explode"] = 1;
    level.destructible_type[var_12]._ID23309[var_13][var_14]._ID34830["explode_force_min"] = var_0;
    level.destructible_type[var_12]._ID23309[var_13][var_14]._ID34830["explode_force_max"] = var_1;
    level.destructible_type[var_12]._ID23309[var_13][var_14]._ID34830["explode_mindamage"] = var_4;
    level.destructible_type[var_12]._ID23309[var_13][var_14]._ID34830["explode_maxdamage"] = var_5;
    level.destructible_type[var_12]._ID23309[var_13][var_14]._ID34830["continueDamage"] = var_6;
    level.destructible_type[var_12]._ID23309[var_13][var_14]._ID34830["originOffset"] = var_7;
    level.destructible_type[var_12]._ID23309[var_13][var_14]._ID34830["earthQuakeScale"] = var_8;
    level.destructible_type[var_12]._ID23309[var_13][var_14]._ID34830["earthQuakeRadius"] = var_9;
    level.destructible_type[var_12]._ID23309[var_13][var_14]._ID34830["originOffset3d"] = var_10;
    level.destructible_type[var_12]._ID23309[var_13][var_14]._ID34830["delaytime"] = var_11;
}

destructible_function( var_0 )
{
    var_1 = level.destructible_type.size - 1;
    var_2 = level.destructible_type[var_1]._ID23309.size - 1;
    var_3 = level.destructible_type[var_1]._ID23309[var_2].size - 1;
    level.destructible_type[var_1]._ID23309[var_2][var_3]._ID34830["function"] = var_0;
}

_ID9866( var_0 )
{
    var_1 = level.destructible_type.size - 1;
    var_2 = level.destructible_type[var_1]._ID23309.size - 1;
    var_3 = level.destructible_type[var_1]._ID23309[var_2].size - 1;
    level.destructible_type[var_1]._ID23309[var_2][var_3]._ID34830["functionNotify"] = var_0;
}

destructible_damage_threshold( var_0 )
{
    var_1 = level.destructible_type.size - 1;
    var_2 = level.destructible_type[var_1]._ID23309.size - 1;
    var_3 = level.destructible_type[var_1]._ID23309[var_2].size - 1;
    level.destructible_type[var_1]._ID23309[var_2][var_3]._ID34830["damage_threshold"] = var_0;
}

destructible_attachmodel( var_0, var_1 )
{
    var_1 = tolower( var_1 );
    var_2 = level.destructible_type.size - 1;

    if ( !isdefined( level.destructible_type[var_2].attachedmodels ) )
        level.destructible_type[var_2].attachedmodels = [];

    var_3 = spawnstruct();
    var_3.model = var_1;
    var_3.tag = var_0;
    level.destructible_type[var_2].attachedmodels[level.destructible_type[var_2].attachedmodels.size] = var_3;
}

destructible_info( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 )
{
    if ( isdefined( var_3 ) )
        var_3 = tolower( var_3 );

    var_13 = level.destructible_type.size - 1;
    level.destructible_type[var_13]._ID23309[var_0][var_1] = spawnstruct();
    level.destructible_type[var_13]._ID23309[var_0][var_1]._ID34830["modelName"] = var_3;
    level.destructible_type[var_13]._ID23309[var_0][var_1]._ID34830["tagName"] = var_2;
    level.destructible_type[var_13]._ID23309[var_0][var_1]._ID34830["health"] = var_4;
    level.destructible_type[var_13]._ID23309[var_0][var_1]._ID34830["validAttackers"] = var_5;
    level.destructible_type[var_13]._ID23309[var_0][var_1]._ID34830["validDamageZone"] = var_6;
    level.destructible_type[var_13]._ID23309[var_0][var_1]._ID34830["validDamageCause"] = var_7;
    level.destructible_type[var_13]._ID23309[var_0][var_1]._ID34830["alsoDamageParent"] = var_8;
    level.destructible_type[var_13]._ID23309[var_0][var_1]._ID34830["physicsOnExplosion"] = var_9;
    level.destructible_type[var_13]._ID23309[var_0][var_1]._ID34830["grenadeImpactDeath"] = var_10;
    level.destructible_type[var_13]._ID23309[var_0][var_1]._ID34830["godModeAllowed"] = 0;
    level.destructible_type[var_13]._ID23309[var_0][var_1]._ID34830["splashRotation"] = var_11;
    level.destructible_type[var_13]._ID23309[var_0][var_1]._ID34830["receiveDamageFromParent"] = var_12;
}

_ID24837()
{
    if ( !isdefined( level.destructible_type[self._ID9891]._ID23309 ) )
        return;

    if ( isdefined( level.destructible_type[self._ID9891].attachedmodels ) )
    {
        foreach ( var_1 in level.destructible_type[self._ID9891].attachedmodels )
            precachemodel( var_1.model );
    }

    for ( var_3 = 0; var_3 < level.destructible_type[self._ID9891]._ID23309.size; var_3++ )
    {
        for ( var_4 = 0; var_4 < level.destructible_type[self._ID9891]._ID23309[var_3].size; var_4++ )
        {
            if ( level.destructible_type[self._ID9891]._ID23309[var_3].size <= var_4 )
                continue;

            if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_3][var_4]._ID34830["modelName"] ) )
                precachemodel( level.destructible_type[self._ID9891]._ID23309[var_3][var_4]._ID34830["modelName"] );

            if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_3][var_4]._ID34830["animation"] ) )
            {
                var_5 = level.destructible_type[self._ID9891]._ID23309[var_3][var_4]._ID34830["animation"];

                foreach ( var_7 in var_5 )
                {
                    if ( isdefined( var_7["mpAnim"] ) )
                        common_scripts\utility::_ID22149( "precacheMpAnim", var_7["mpAnim"] );
                }
            }

            if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_3][var_4]._ID34830["random_dynamic_attachment_1"] ) )
            {
                foreach ( var_10 in level.destructible_type[self._ID9891]._ID23309[var_3][var_4]._ID34830["random_dynamic_attachment_1"] )
                {
                    if ( isdefined( var_10 ) && var_10 != "" )
                    {
                        precachemodel( var_10 );
                        precachemodel( var_10 + "_destroy" );
                    }
                }

                foreach ( var_10 in level.destructible_type[self._ID9891]._ID23309[var_3][var_4]._ID34830["random_dynamic_attachment_2"] )
                {
                    if ( isdefined( var_10 ) && var_10 != "" )
                    {
                        precachemodel( var_10 );
                        precachemodel( var_10 + "_destroy" );
                    }
                }
            }
        }
    }
}

add_destructible_fx()
{
    if ( !isdefined( level.destructible_type[self._ID9891]._ID23309 ) )
        return;

    for ( var_0 = 0; var_0 < level.destructible_type[self._ID9891]._ID23309.size; var_0++ )
    {
        for ( var_1 = 0; var_1 < level.destructible_type[self._ID9891]._ID23309[var_0].size; var_1++ )
        {
            if ( level.destructible_type[self._ID9891]._ID23309[var_0].size <= var_1 )
                continue;

            var_2 = level.destructible_type[self._ID9891]._ID23309[var_0][var_1];

            if ( isdefined( var_2._ID34830["fx_filename"] ) )
            {
                for ( var_3 = 0; var_3 < var_2._ID34830["fx_filename"].size; var_3++ )
                {
                    var_4 = var_2._ID34830["fx_filename"][var_3];
                    var_5 = var_2._ID34830["fx_tag"][var_3];

                    if ( isdefined( var_4 ) )
                    {
                        if ( isdefined( var_2._ID34830["fx"] ) && isdefined( var_2._ID34830["fx"][var_3] ) && var_2._ID34830["fx"][var_3].size == var_4.size )
                            continue;

                        for ( var_6 = 0; var_6 < var_4.size; var_6++ )
                        {
                            var_7 = var_4[var_6];
                            var_8 = var_5[var_6];
                            level.destructible_type[self._ID9891]._ID23309[var_0][var_1]._ID34830["fx"][var_3][var_6] = loadfx( var_7, var_8 );
                        }
                    }
                }
            }

            var_9 = level.destructible_type[self._ID9891]._ID23309[var_0][var_1]._ID34830["loopfx_filename"];
            var_10 = level.destructible_type[self._ID9891]._ID23309[var_0][var_1]._ID34830["loopfx_tag"];

            if ( isdefined( var_9 ) )
            {
                if ( isdefined( var_2._ID34830["loopfx"] ) && var_2._ID34830["loopfx"].size == var_9.size )
                    continue;

                for ( var_6 = 0; var_6 < var_9.size; var_6++ )
                {
                    var_11 = var_9[var_6];
                    var_12 = var_10[var_6];
                    level.destructible_type[self._ID9891]._ID23309[var_0][var_1]._ID34830["loopfx"][var_6] = loadfx( var_11, var_12 );
                }
            }
        }
    }
}

_ID6576( var_0 )
{
    foreach ( var_2 in self.destructibles )
    {
        if ( var_2 == var_0 )
            return 1;
    }

    return 0;
}

_ID9885()
{
    var_0 = 0;
    var_1 = self.model;
    var_2 = undefined;
    var_3 = self.origin;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    destructible_update_part( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
    self endon( "stop_taking_damage" );

    for (;;)
    {
        var_0 = undefined;
        var_5 = undefined;
        var_4 = undefined;
        var_3 = undefined;
        var_7 = undefined;
        var_1 = undefined;
        var_2 = undefined;
        var_8 = undefined;
        var_9 = undefined;
        self waittill( "damage",  var_0, var_5, var_4, var_3, var_7, var_1, var_2, var_8, var_9  );

        if ( !isdefined( var_0 ) )
            continue;

        if ( isdefined( var_5 ) && isdefined( var_5.type ) && var_5.type == "soft_landing" && !var_5 _ID6576( self ) )
            continue;

        if ( common_scripts\utility::_ID18787() )
            var_0 *= 0.5;
        else
            var_0 *= 1.0;

        if ( var_0 <= 0 )
            continue;

        if ( common_scripts\utility::_ID18787() )
        {
            if ( isdefined( var_5 ) && isplayer( var_5 ) )
                self._ID8979 = var_5;
        }
        else if ( isdefined( var_5 ) && isplayer( var_5 ) )
            self._ID8979 = var_5;
        else if ( isdefined( var_5 ) && isdefined( var_5._ID15889 ) && isplayer( var_5._ID15889 ) )
            self._ID8979 = var_5._ID15889;

        var_7 = getdamagetype( var_7 );

        if ( _ID18491( var_5, var_7 ) )
        {
            if ( common_scripts\utility::_ID18787() )
                var_0 *= 8.0;
            else
                var_0 *= 4.0;
        }

        if ( !isdefined( var_1 ) || var_1 == "" )
            var_1 = self.model;

        if ( isdefined( var_2 ) && var_2 == "" )
        {
            if ( isdefined( var_8 ) && var_8 != "" && var_8 != "tag_body" && var_8 != "body_animate_jnt" )
                var_2 = var_8;
            else
                var_2 = undefined;

            var_10 = level.destructible_type[self._ID9891]._ID23309[0][0]._ID34830["tagName"];

            if ( isdefined( var_10 ) && isdefined( var_8 ) && var_10 == var_8 )
                var_2 = undefined;
        }

        if ( var_7 == "splash" )
        {
            if ( isdefined( level.destructible_type[self._ID9891]._ID23309[0][0]._ID34830["splash_damage_scaler"] ) )
                var_0 *= level.destructible_type[self._ID9891]._ID23309[0][0]._ID34830["splash_damage_scaler"];
            else if ( common_scripts\utility::_ID18787() )
                var_0 *= 9.0;
            else
                var_0 *= 13.0;

            _ID9879( int( var_0 ), var_3, var_4, var_5, var_7 );
            continue;
        }

        thread destructible_update_part( int( var_0 ), var_1, var_2, var_3, var_4, var_5, var_7 );
    }
}

_ID18491( var_0, var_1 )
{
    if ( var_1 != "bullet" )
        return 0;

    if ( !isdefined( var_0 ) )
        return 0;

    var_2 = undefined;

    if ( isplayer( var_0 ) )
        var_2 = var_0 getcurrentweapon();
    else if ( isdefined( level._ID11416 ) && level._ID11416 )
    {
        if ( isdefined( var_0.weapon ) )
            var_2 = var_0.weapon;
    }

    if ( !isdefined( var_2 ) )
        return 0;

    var_3 = weaponclass( var_2 );

    if ( isdefined( var_3 ) && var_3 == "spread" )
        return 1;

    return 0;
}

getpartandstateindex( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2._ID34830 = [];
    var_3 = -1;
    var_4 = -1;

    if ( tolower( var_0 ) == tolower( self.model ) && !isdefined( var_1 ) )
    {
        var_0 = self.model;
        var_1 = undefined;
        var_3 = 0;
        var_4 = 0;
    }

    for ( var_5 = 0; var_5 < level.destructible_type[self._ID9891]._ID23309.size; var_5++ )
    {
        var_4 = self.destructible_parts[var_5]._ID34830["currentState"];

        if ( level.destructible_type[self._ID9891]._ID23309[var_5].size <= var_4 )
            continue;

        if ( !isdefined( var_1 ) )
            continue;

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_5][var_4]._ID34830["tagName"] ) )
        {
            var_6 = level.destructible_type[self._ID9891]._ID23309[var_5][var_4]._ID34830["tagName"];

            if ( tolower( var_6 ) == tolower( var_1 ) )
            {
                var_3 = var_5;
                break;
            }
        }
    }

    var_2._ID34830["stateIndex"] = var_4;
    var_2._ID34830["partIndex"] = var_3;
    return var_2;
}

destructible_update_part( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( !isdefined( self.destructible_parts ) )
        return;

    if ( self.destructible_parts.size == 0 )
        return;

    if ( level.fast_destructible_explode )
        self endon( "destroyed" );

    var_8 = getpartandstateindex( var_1, var_2 );
    var_9 = var_8._ID34830["stateIndex"];
    var_10 = var_8._ID34830["partIndex"];

    if ( var_10 < 0 )
        return;

    var_11 = var_9;
    var_12 = 0;
    var_13 = 0;

    for (;;)
    {
        var_9 = self.destructible_parts[var_10]._ID34830["currentState"];

        if ( !isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_9] ) )
            break;

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][0]._ID34830["alsoDamageParent"] ) )
        {
            if ( getdamagetype( var_6 ) != "splash" )
            {
                var_14 = level.destructible_type[self._ID9891]._ID23309[var_10][0]._ID34830["alsoDamageParent"];
                var_15 = int( var_0 * var_14 );
                thread notifydamageafterframe( var_15, var_5, var_4, var_3, var_6, "", "" );
            }
        }

        if ( getdamagetype( var_6 ) != "splash" )
        {
            foreach ( var_17 in level.destructible_type[self._ID9891]._ID23309 )
            {
                if ( !isdefined( var_17[0]._ID34830["receiveDamageFromParent"] ) )
                    continue;

                if ( !isdefined( var_17[0]._ID34830["tagName"] ) )
                    continue;

                var_14 = var_17[0]._ID34830["receiveDamageFromParent"];
                var_18 = int( var_0 * var_14 );
                var_19 = var_17[0]._ID34830["tagName"];
                thread notifydamageafterframe( var_18, var_5, var_4, var_3, var_6, "", var_19 );
            }
        }

        if ( !isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_9]._ID34830["health"] ) )
            break;

        if ( !isdefined( self.destructible_parts[var_10]._ID34830["health"] ) )
            break;

        if ( var_12 )
            self.destructible_parts[var_10]._ID34830["health"] = level.destructible_type[self._ID9891]._ID23309[var_10][var_9]._ID34830["health"];

        var_12 = 0;

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_9]._ID34830["grenadeImpactDeath"] ) && var_6 == "impact" )
            var_0 = 100000000;

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_9]._ID34830["damage_threshold"] ) && level.destructible_type[self._ID9891]._ID23309[var_10][var_9]._ID34830["damage_threshold"] > var_0 )
            var_0 = 0;

        var_21 = self.destructible_parts[var_10]._ID34830["health"];
        var_22 = _ID18561( var_10, var_9, var_5 );

        if ( var_22 )
        {
            var_23 = _ID18845( var_10, var_9, var_6 );

            if ( var_23 )
            {
                if ( isdefined( var_5 ) )
                {
                    if ( isplayer( var_5 ) )
                        self._ID23996 = self._ID23996 + var_0;
                    else if ( var_5 != self )
                        self._ID22125 = self._ID22125 + var_0;
                }

                if ( isdefined( var_6 ) )
                {
                    if ( var_6 == "melee" || var_6 == "impact" )
                        var_0 = 100000;
                }

                self.destructible_parts[var_10]._ID34830["health"] = self.destructible_parts[var_10]._ID34830["health"] - var_0;
            }
        }

        if ( self.destructible_parts[var_10]._ID34830["health"] > 0 )
            return;

        if ( isdefined( var_7 ) )
        {
            var_7._ID34830["fxcost"] = get_part_fx_cost_for_action_state( var_10, self.destructible_parts[var_10]._ID34830["currentState"] );
            add_destructible_to_frame_queue( self, var_7, var_0 );

            if ( !isdefined( self._ID35586 ) )
                self._ID35586 = 1;
            else
                self._ID35586++;

            self waittill( "queue_processed",  var_24  );
            self._ID35586--;

            if ( self._ID35586 == 0 )
                self._ID35586 = undefined;

            if ( !var_24 )
            {
                self.destructible_parts[var_10]._ID34830["health"] = var_21;
                return;
            }
        }

        var_0 = int( abs( self.destructible_parts[var_10]._ID34830["health"] ) );

        if ( var_0 < 0 )
            return;

        self.destructible_parts[var_10]._ID34830["currentState"]++;
        var_9 = self.destructible_parts[var_10]._ID34830["currentState"];
        var_25 = var_9 - 1;
        var_26 = undefined;

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_25] ) )
            var_26 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830;

        var_27 = undefined;

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_9] ) )
            var_27 = level.destructible_type[self._ID9891]._ID23309[var_10][var_9]._ID34830;

        if ( !isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_25] ) )
            return;

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["explode"] ) )
            self._ID12495 = 1;

        if ( isdefined( self._ID20352 ) && isdefined( self._ID20352[_ID33139( var_10 )] ) )
        {
            for ( var_28 = 0; var_28 < self._ID20352[_ID33139( var_10 )].size; var_28++ )
            {
                self notify( self._ID20352[_ID33139( var_10 )][var_28] );

                if ( common_scripts\utility::_ID18787() && self.modeldummyon )
                    self._ID21272 notify( self._ID20352[_ID33139( var_10 )][var_28] );
            }

            self._ID20352[_ID33139( var_10 )] = undefined;
        }

        if ( isdefined( var_26["break_nearby_lights"] ) )
            _ID9853( var_26["break_nearby_lights"] );

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_9] ) )
        {
            if ( var_10 == 0 )
            {
                var_29 = var_27["modelName"];

                if ( isdefined( var_29 ) && var_29 != self.model )
                {
                    self setmodel( var_29 );

                    if ( common_scripts\utility::_ID18787() && self.modeldummyon )
                        self._ID21272 setmodel( var_29 );

                    _ID9881( var_27 );
                }
            }
            else
            {
                _ID16895( var_2 );

                if ( common_scripts\utility::_ID18787() && self.modeldummyon )
                    self._ID21272 _ID16895( var_2 );

                var_2 = var_27["tagName"];

                if ( isdefined( var_2 ) )
                {
                    _ID29956( var_2 );

                    if ( common_scripts\utility::_ID18787() && self.modeldummyon )
                        self._ID21272 _ID29956( var_2 );
                }
            }
        }

        var_30 = _ID14435();

        if ( isdefined( self._ID12495 ) )
            _ID7414( var_30 );

        var_31 = _ID9825( var_26, var_30, var_6, var_10 );
        var_31 = destructible_fx_think( var_26, var_30, var_6, var_10, var_31 );
        var_31 = destructible_sound_think( var_26, var_30, var_6, var_31 );

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["loopfx"] ) )
        {
            var_32 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["loopfx_filename"].size;

            if ( var_32 > 0 )
                self notify( "FX_State_Change" + var_10 );

            for ( var_33 = 0; var_33 < var_32; var_33++ )
            {
                var_34 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["loopfx"][var_33];
                var_35 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["loopfx_tag"][var_33];
                var_36 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["loopfx_rate"][var_33];
                thread _ID20342( var_34, var_35, var_36, var_10 );
            }
        }

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["loopsound"] ) )
        {
            for ( var_28 = 0; var_28 < level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["loopsound"].size; var_28++ )
            {
                var_37 = isvalidsoundcause( "loopsoundCause", var_26, var_28, var_6 );

                if ( var_37 )
                {
                    var_38 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["loopsound"][var_28];
                    var_39 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["tagName"];
                    thread _ID23795( var_38, var_39 );

                    if ( !isdefined( self._ID20352 ) )
                        self._ID20352 = [];

                    if ( !isdefined( self._ID20352[_ID33139( var_10 )] ) )
                        self._ID20352[_ID33139( var_10 )] = [];

                    var_40 = self._ID20352[_ID33139( var_10 )].size;
                    self._ID20352[_ID33139( var_10 )][var_40] = "stop sound" + var_38;
                }
            }
        }

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["triggerCarAlarm"] ) )
            thread _ID10270();

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["break_nearby_lights"] ) )
            thread break_nearest_light();

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["healthdrain_amount"] ) )
        {
            self notify( "Health_Drain_State_Change" + var_10 );
            var_41 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["healthdrain_amount"];
            var_42 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["healthdrain_interval"];
            var_43 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["modelName"];
            var_44 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["tagName"];
            var_45 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["badplace_radius"];
            var_46 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["badplace_team"];

            if ( var_41 > 0 )
                thread health_drain( var_41, var_42, var_10, var_43, var_44, var_45, var_46 );
        }

        var_47 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["dot"];

        if ( isdefined( var_47 ) )
        {
            foreach ( var_49 in var_47 )
            {
                var_50 = var_49.index;

                if ( var_49.type == "predefined" && isdefined( var_50 ) )
                {
                    var_51 = [];

                    foreach ( var_53 in level.destructible_type[self._ID9891].destructible_dots[var_50] )
                    {
                        var_54 = var_53["classname"];
                        var_55 = undefined;

                        switch ( var_54 )
                        {
                            case "trigger_radius":
                                var_56 = var_53["origin"];
                                var_57 = var_53["spawnflags"];
                                var_58 = var_53["radius"];
                                var_59 = var_53["height"];
                                var_55 = createdot_radius( self.origin + var_56, var_57, var_58, var_59 );
                                var_55._ID32975 = var_49._ID32975;
                                var_51[var_51.size] = var_55;
                                continue;
                        }

                        endswitch( 2 )  case "trigger_radius" loc_2D72 default loc_2DBE
                    }

                    level thread _ID31432( var_51 );
                    continue;
                }

                if ( isdefined( var_49 ) )
                {
                    if ( isdefined( var_49.tag ) )
                        var_49 _ID28705( self gettagorigin( var_49.tag ) );

                    level thread _ID31432( [ var_49 ] );
                }
            }

            var_47 = undefined;
        }

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["explode"] ) )
        {
            var_13 = 1;
            var_62 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["explode_force_min"];
            var_63 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["explode_force_max"];
            var_64 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["explode_range"];
            var_65 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["explode_mindamage"];
            var_66 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["explode_maxdamage"];
            var_67 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["continueDamage"];
            var_68 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["originOffset"];
            var_69 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["earthQuakeScale"];
            var_70 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["earthQuakeRadius"];
            var_71 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["originOffset3d"];
            var_72 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["delaytime"];

            if ( isdefined( var_5 ) && var_5 != self )
            {
                self.attacker = var_5;

                if ( self.code_classname == "script_vehicle" )
                    self.damage_type = var_6;
            }

            thread explode( var_10, var_62, var_63, var_64, var_65, var_66, var_67, var_68, var_69, var_70, var_5, var_71, var_72 );
        }

        var_73 = undefined;

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["physics"] ) )
        {
            for ( var_28 = 0; var_28 < level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["physics"].size; var_28++ )
            {
                var_73 = undefined;
                var_74 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["physics_tagName"][var_28];
                var_75 = level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["physics_velocity"][var_28];
                var_76 = undefined;

                if ( isdefined( var_75 ) )
                {
                    var_77 = undefined;

                    if ( isdefined( var_74 ) )
                        var_77 = self gettagangles( var_74 );
                    else if ( isdefined( var_2 ) )
                        var_77 = self gettagangles( var_2 );

                    var_73 = undefined;

                    if ( isdefined( var_74 ) )
                        var_73 = self gettagorigin( var_74 );
                    else if ( isdefined( var_2 ) )
                        var_73 = self gettagorigin( var_2 );

                    var_78 = var_75[0] - 5 + randomfloat( 10 );
                    var_79 = var_75[1] - 5 + randomfloat( 10 );
                    var_80 = var_75[2] - 5 + randomfloat( 10 );
                    var_81 = anglestoforward( var_77 ) * var_78 * randomfloatrange( 80, 110 );
                    var_82 = anglestoright( var_77 ) * var_79 * randomfloatrange( 80, 110 );
                    var_83 = anglestoup( var_77 ) * var_80 * randomfloatrange( 80, 110 );
                    var_76 = var_81 + var_82 + var_83;
                }
                else
                {
                    var_76 = var_3;
                    var_84 = ( 0, 0, 0 );

                    if ( isdefined( var_5 ) )
                    {
                        var_84 = var_5.origin;
                        var_76 = vectornormalize( var_3 - var_84 );
                        var_76 *= 200;
                    }
                }

                if ( isdefined( var_74 ) )
                {
                    var_85 = undefined;

                    for ( var_86 = 0; var_86 < level.destructible_type[self._ID9891]._ID23309.size; var_86++ )
                    {
                        if ( !isdefined( level.destructible_type[self._ID9891]._ID23309[var_86][0]._ID34830["tagName"] ) )
                            continue;

                        if ( level.destructible_type[self._ID9891]._ID23309[var_86][0]._ID34830["tagName"] != var_74 )
                            continue;

                        var_85 = var_86;
                        break;
                    }

                    if ( isdefined( var_73 ) )
                        thread _ID23518( var_85, 0, var_73, var_76 );
                    else
                        thread _ID23518( var_85, 0, var_3, var_76 );

                    continue;
                }

                if ( isdefined( var_73 ) )
                    thread _ID23518( var_10, var_25, var_73, var_76 );
                else
                    thread _ID23518( var_10, var_25, var_3, var_76 );

                return;
            }
        }

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830 ) && isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["functionNotify"] ) )
            self notify( level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["functionNotify"] );

        if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["function"] ) )
            self thread [[ level.destructible_type[self._ID9891]._ID23309[var_10][var_25]._ID34830["function"] ]]();

        var_12 = 1;
    }
}

_ID9881( var_0 )
{
    var_1 = var_0["splashRotation"];
    var_2 = var_0["rotateTo"];

    if ( !isdefined( var_2 ) )
        return;

    if ( !isdefined( var_1 ) )
        return;

    if ( !var_1 )
        return;

    self.angles = ( self.angles[0], var_2[1], self.angles[2] );
}

damage_not( var_0 )
{
    var_1 = strtok( var_0, " " );
    var_2 = strtok( "splash melee bullet splash impact unknown", " " );
    var_3 = "";

    foreach ( var_6, var_5 in var_1 )
        var_2 = common_scripts\utility::array_remove( var_2, var_5 );

    foreach ( var_8 in var_2 )
        var_3 += ( var_8 + " " );

    return var_3;
}

_ID9879( var_0, var_1, var_2, var_3, var_4 )
{
    if ( var_0 <= 0 )
        return;

    if ( isdefined( self.exploded ) )
        return;

    if ( !isdefined( level.destructible_type[self._ID9891]._ID23309 ) )
        return;

    var_5 = getallactiveparts( var_2 );

    if ( var_5.size <= 0 )
        return;

    var_5 = _ID28701( var_5, var_1 );
    var_6 = _ID15135( var_5 );

    foreach ( var_8 in var_5 )
    {
        var_9 = var_8._ID34830["distance"] * 1.4;
        var_10 = var_0 - ( var_9 - var_6 );

        if ( var_10 <= 0 )
            continue;

        if ( isdefined( self.exploded ) )
            continue;

        thread destructible_update_part( var_10, var_8._ID34830["modelName"], var_8._ID34830["tagName"], var_1, var_2, var_3, var_4, var_8 );
    }
}

getallactiveparts( var_0 )
{
    var_1 = [];

    if ( !isdefined( level.destructible_type[self._ID9891]._ID23309 ) )
        return var_1;

    for ( var_2 = 0; var_2 < level.destructible_type[self._ID9891]._ID23309.size; var_2++ )
    {
        var_3 = var_2;
        var_4 = self.destructible_parts[var_3]._ID34830["currentState"];

        for ( var_5 = 0; var_5 < level.destructible_type[self._ID9891]._ID23309[var_3].size; var_5++ )
        {
            var_6 = level.destructible_type[self._ID9891]._ID23309[var_3][var_5]._ID34830["splashRotation"];

            if ( isdefined( var_6 ) && var_6 )
            {
                var_7 = vectortoangles( var_0 );
                var_8 = var_7[1] - 90;
                level.destructible_type[self._ID9891]._ID23309[var_3][var_5]._ID34830["rotateTo"] = ( 0, var_8, 0 );
            }
        }

        if ( !isdefined( level.destructible_type[self._ID9891]._ID23309[var_3][var_4] ) )
            continue;

        var_9 = level.destructible_type[self._ID9891]._ID23309[var_3][var_4]._ID34830["tagName"];

        if ( !isdefined( var_9 ) )
            var_9 = "";

        if ( var_9 == "" )
            continue;

        var_10 = level.destructible_type[self._ID9891]._ID23309[var_3][var_4]._ID34830["modelName"];

        if ( !isdefined( var_10 ) )
            var_10 = "";

        var_11 = var_1.size;
        var_1[var_11] = spawnstruct();
        var_1[var_11]._ID34830["modelName"] = var_10;
        var_1[var_11]._ID34830["tagName"] = var_9;
    }

    return var_1;
}

_ID28701( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        var_3 = distance( var_1, self gettagorigin( var_0[var_2]._ID34830["tagName"] ) );
        var_0[var_2]._ID34830["distance"] = var_3;
    }

    return var_0;
}

_ID15135( var_0 )
{
    var_1 = undefined;

    foreach ( var_3 in var_0 )
    {
        var_4 = var_3._ID34830["distance"];

        if ( !isdefined( var_1 ) )
            var_1 = var_4;

        if ( var_4 < var_1 )
            var_1 = var_4;
    }

    return var_1;
}

isvalidsoundcause( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_4 ) )
        var_5 = var_1[var_0][var_4][var_2];
    else
        var_5 = var_1[var_0][var_2];

    if ( !isdefined( var_5 ) )
        return 1;

    if ( var_5 == var_3 )
        return 1;

    return 0;
}

_ID18561( var_0, var_1, var_2 )
{
    if ( isdefined( self._ID13524 ) )
        return 1;

    if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_0][var_1]._ID34830["explode"] ) )
    {
        if ( isdefined( self.dontallowexplode ) )
            return 0;
    }

    if ( !isdefined( var_2 ) )
        return 1;

    if ( var_2 == self )
        return 1;

    var_3 = level.destructible_type[self._ID9891]._ID23309[var_0][var_1]._ID34830["validAttackers"];

    if ( !isdefined( var_3 ) )
        return 1;

    if ( var_3 == "no_player" )
    {
        if ( !isplayer( var_2 ) )
            return 1;

        if ( !isdefined( var_2._ID8973 ) )
            return 1;

        if ( var_2._ID8973 == 0 )
            return 1;
    }
    else if ( var_3 == "player_only" )
    {
        if ( isplayer( var_2 ) )
            return 1;

        if ( isdefined( var_2._ID8973 ) && var_2._ID8973 )
            return 1;
    }
    else if ( var_3 == "no_ai" && isdefined( level.isaifunc ) )
    {
        if ( ![[ level.isaifunc ]]( var_2 ) )
            return 1;
    }
    else if ( var_3 == "ai_only" && isdefined( level.isaifunc ) )
    {
        if ( [[ level.isaifunc ]]( var_2 ) )
            return 1;
    }
    else
    {

    }

    return 0;
}

_ID18845( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        return 1;

    var_3 = level.destructible_type[self._ID9891]._ID23309[var_0][var_1]._ID34830["godModeAllowed"];

    if ( var_3 && ( isdefined( self.godmode ) && self.godmode || isdefined( self._ID27482 ) && self._ID27482 && var_2 == "bullet" ) )
        return 0;

    var_4 = level.destructible_type[self._ID9891]._ID23309[var_0][var_1]._ID34830["validDamageCause"];

    if ( !isdefined( var_4 ) )
        return 1;

    if ( var_4 == "splash" && var_2 != "splash" )
        return 0;

    if ( var_4 == "no_splash" && var_2 == "splash" )
        return 0;

    if ( var_4 == "no_melee" && var_2 == "melee" || var_2 == "impact" )
        return 0;

    return 1;
}

getdamagetype( var_0 )
{
    if ( !isdefined( var_0 ) )
        return "unknown";

    var_0 = tolower( var_0 );

    switch ( var_0 )
    {
        case "melee":
        case "mod_melee":
        case "mod_crush":
            return "melee";
        case "bullet":
        case "mod_pistol_bullet":
        case "mod_rifle_bullet":
            return "bullet";
        case "splash":
        case "mod_grenade":
        case "mod_grenade_splash":
        case "mod_projectile":
        case "mod_projectile_splash":
        case "mod_explosive":
            return "splash";
        case "mod_impact":
            return "impact";
        case "unknown":
            return "unknown";
        default:
            return "unknown";
    }
}

_ID8921( var_0, var_1, var_2 )
{
    self notify( "stop_damage_mirror" );
    self endon( "stop_damage_mirror" );
    var_0 endon( "stop_taking_damage" );
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage",  var_3, var_4, var_5, var_6, var_7  );
        var_0 notify( "damage",  var_3, var_4, var_5, var_6, var_7, var_1, var_2  );
        var_3 = undefined;
        var_4 = undefined;
        var_5 = undefined;
        var_6 = undefined;
        var_7 = undefined;
    }
}

add_damage_owner_recorder()
{
    self._ID23996 = 0;
    self._ID22125 = 0;
    self.car_damage_owner_recorder = 1;
}

_ID20342( var_0, var_1, var_2, var_3 )
{
    self endon( "FX_State_Change" + var_3 );
    self endon( "delete_destructible" );
    level endon( "putout_fires" );

    while ( isdefined( self ) )
    {
        var_4 = _ID14435();
        playfxontag( var_0, var_4, var_1 );
        wait(var_2);
    }
}

health_drain( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self endon( "Health_Drain_State_Change" + var_2 );
    level endon( "putout_fires" );
    self endon( "destroyed" );

    if ( isdefined( var_5 ) && isdefined( level._ID9828 ) )
        var_5 *= level._ID9828;

    if ( isdefined( var_0 ) && isdefined( level.destructible_health_drain_amount_multiplier ) )
        var_0 *= level.destructible_health_drain_amount_multiplier;

    wait(var_1);
    self._ID16468 = 1;
    var_7 = undefined;

    if ( isdefined( level._ID10075 ) && level._ID10075 )
        var_5 = undefined;

    if ( isdefined( var_5 ) && isdefined( level.badplace_cylinder_func ) )
    {
        var_7 = "" + gettime();

        if ( !isdefined( self._ID10139 ) )
        {
            if ( isdefined( self._ID27783 ) )
                var_5 = self._ID27783;

            if ( common_scripts\utility::_ID18787() && isdefined( var_6 ) )
            {
                if ( var_6 == "both" )
                    call [[ level.badplace_cylinder_func ]]( var_7, 0, self.origin, var_5, 128, "allies", "bad_guys" );
                else
                    call [[ level.badplace_cylinder_func ]]( var_7, 0, self.origin, var_5, 128, var_6 );

                thread _ID4647( var_7 );
            }
            else
            {
                call [[ level.badplace_cylinder_func ]]( var_7, 0, self.origin, var_5, 128 );
                thread _ID4647( var_7 );
            }
        }
    }

    while ( isdefined( self ) && self.destructible_parts[var_2]._ID34830["health"] > 0 )
    {
        self notify( "damage",  var_0, self, ( 0, 0, 0 ), ( 0, 0, 0 ), "MOD_UNKNOWN", var_3, var_4  );
        wait(var_1);
    }

    self notify( "remove_badplace" );
}

_ID4647( var_0 )
{
    common_scripts\utility::_ID35626( "destroyed", "remove_badplace" );
    call [[ level._ID4645 ]]( var_0 );
}

_ID23518( var_0, var_1, var_2, var_3 )
{
    var_4 = level.destructible_type[self._ID9891]._ID23309[var_0][var_1]._ID34830["modelName"];
    var_5 = level.destructible_type[self._ID9891]._ID23309[var_0][var_1]._ID34830["tagName"];
    _ID16895( var_5 );

    if ( level.destructiblespawnedents.size >= level._ID9894 )
        _ID23519( level.destructiblespawnedents[0] );

    var_6 = spawn( "script_model", self gettagorigin( var_5 ) );
    var_6.angles = self gettagangles( var_5 );
    var_6 setmodel( var_4 );
    level.destructiblespawnedents[level.destructiblespawnedents.size] = var_6;
    var_6 physicslaunchclient( var_2, var_3 );
}

_ID23519( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < level.destructiblespawnedents.size; var_2++ )
    {
        if ( level.destructiblespawnedents[var_2] == var_0 )
            continue;

        var_1[var_1.size] = level.destructiblespawnedents[var_2];
    }

    level.destructiblespawnedents = var_1;

    if ( isdefined( var_0 ) )
        var_0 delete();
}

explode( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 )
{
    if ( isdefined( var_3 ) && isdefined( level._ID9845 ) )
        var_3 *= level._ID9845;

    if ( !isdefined( var_7 ) )
        var_7 = 80;

    if ( !isdefined( var_11 ) )
        var_11 = ( 0, 0, 0 );

    if ( !isdefined( var_6 ) || isdefined( var_6 ) && !var_6 )
    {
        if ( isdefined( self.exploded ) )
            return;

        self.exploded = 1;
    }

    if ( !isdefined( var_12 ) )
        var_12 = 0;

    self notify( "exploded",  var_10  );
    level notify( "destructible_exploded",  self, var_10  );

    if ( self.code_classname == "script_vehicle" )
        self notify( "death",  var_10, self.damage_type  );

    if ( common_scripts\utility::_ID18787() )
        thread disconnecttraverses();

    if ( !level.fast_destructible_explode )
        wait 0.05;

    if ( !isdefined( self ) )
        return;

    var_13 = self.destructible_parts[var_0]._ID34830["currentState"];
    var_14 = undefined;

    if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_0][var_13] ) )
        var_14 = level.destructible_type[self._ID9891]._ID23309[var_0][var_13]._ID34830["tagName"];

    if ( isdefined( var_14 ) )
        var_15 = self gettagorigin( var_14 );
    else
        var_15 = self.origin;

    self notify( "damage",  var_5, self, ( 0, 0, 0 ), var_15, "MOD_EXPLOSIVE", "", ""  );
    self notify( "stop_car_alarm" );
    waittillframeend;

    if ( isdefined( level.destructible_type[self._ID9891]._ID23309 ) )
    {
        for ( var_16 = level.destructible_type[self._ID9891]._ID23309.size - 1; var_16 >= 0; var_16-- )
        {
            if ( var_16 == var_0 )
                continue;

            var_17 = self.destructible_parts[var_16]._ID34830["currentState"];

            if ( var_17 >= level.destructible_type[self._ID9891]._ID23309[var_16].size )
                var_17 = level.destructible_type[self._ID9891]._ID23309[var_16].size - 1;

            var_18 = level.destructible_type[self._ID9891]._ID23309[var_16][var_17]._ID34830["modelName"];
            var_14 = level.destructible_type[self._ID9891]._ID23309[var_16][var_17]._ID34830["tagName"];

            if ( !isdefined( var_18 ) )
                continue;

            if ( !isdefined( var_14 ) )
                continue;

            if ( isdefined( level.destructible_type[self._ID9891]._ID23309[var_16][0]._ID34830["physicsOnExplosion"] ) )
            {
                if ( level.destructible_type[self._ID9891]._ID23309[var_16][0]._ID34830["physicsOnExplosion"] > 0 )
                {
                    var_19 = level.destructible_type[self._ID9891]._ID23309[var_16][0]._ID34830["physicsOnExplosion"];
                    var_20 = self gettagorigin( var_14 );
                    var_21 = vectornormalize( var_20 - var_15 );
                    var_21 *= ( randomfloatrange( var_1, var_2 ) * var_19 );
                    thread _ID23518( var_16, var_17, var_20, var_21 );
                    continue;
                }
            }
        }
    }

    var_22 = !isdefined( var_6 ) || isdefined( var_6 ) && !var_6;

    if ( var_22 )
        self notify( "stop_taking_damage" );

    if ( !level.fast_destructible_explode )
        wait 0.05;

    if ( !isdefined( self ) )
        return;

    var_23 = var_15 + ( 0, 0, var_7 ) + var_11;
    var_24 = getsubstr( level.destructible_type[self._ID9891]._ID34830["type"], 0, 7 ) == "vehicle";

    if ( var_24 )
    {
        anim._ID19531 = gettime();
        anim._ID19528 = var_23;
        anim._ID19529 = var_15;
        anim.lastcarexplosionrange = var_3;
    }

    level thread _ID28297( 1 );

    if ( var_12 > 0 )
        wait(var_12);

    if ( isdefined( level.destructible_protection_func ) )
        thread [[ level.destructible_protection_func ]]();

    if ( common_scripts\utility::_ID18787() )
    {
        if ( level.gameskill == 0 && !player_touching_post_clip() )
            self radiusdamage( var_23, var_3, var_5, var_4, self, "MOD_RIFLE_BULLET" );
        else
            self radiusdamage( var_23, var_3, var_5, var_4, self );

        if ( isdefined( self._ID8979 ) && var_24 )
        {
            self._ID8979 notify( "destroyed_car" );
            level notify( "player_destroyed_car",  self._ID8979, var_23  );
        }
    }
    else
    {
        var_25 = "destructible_toy";

        if ( var_24 )
            var_25 = "destructible_car";

        if ( !isdefined( self._ID8979 ) )
            self radiusdamage( var_23, var_3, var_5, var_4, self, "MOD_EXPLOSIVE", var_25 );
        else
        {
            self radiusdamage( var_23, var_3, var_5, var_4, self._ID8979, "MOD_EXPLOSIVE", var_25 );

            if ( var_24 )
            {
                self._ID8979 notify( "destroyed_car" );
                level notify( "player_destroyed_car",  self._ID8979, var_23  );
            }
        }
    }

    if ( isdefined( var_8 ) && isdefined( var_9 ) )
        earthquake( var_8, 2.0, var_23, var_9 );

    level thread _ID28297( 0, 0.05 );
    var_26 = 0.01;
    var_27 = var_3 * var_26;
    var_3 *= 0.99;
    physicsexplosionsphere( var_23, var_3, 0, var_27 );

    if ( var_22 )
    {
        self setcandamage( 0 );
        thread _ID7409();
    }

    self notify( "destroyed" );
}

_ID7409()
{
    wait 0.05;

    while ( isdefined( self ) && isdefined( self._ID35586 ) )
    {
        self waittill( "queue_processed" );
        wait 0.05;
    }

    if ( !isdefined( self ) )
        return;

    self.animsapplied = undefined;
    self.attacker = undefined;
    self.car_damage_owner_recorder = undefined;
    self._ID6705 = undefined;
    self._ID8979 = undefined;
    self.destructible_parts = undefined;
    self.destructible_type = undefined;
    self._ID9891 = undefined;
    self._ID16468 = undefined;
    self._ID22125 = undefined;
    self._ID23996 = undefined;

    if ( !isdefined( level.destructible_cleans_up_more ) )
        return;

    self._ID27741 = undefined;
    self._ID12495 = undefined;
    self._ID20352 = undefined;
    self.car_alarm_org = undefined;
}

_ID28297( var_0, var_1 )
{
    level notify( "set_disable_friendlyfire_value_delayed" );
    level endon( "set_disable_friendlyfire_value_delayed" );

    if ( isdefined( var_1 ) )
        wait(var_1);

    level.friendlyfiredisabledfordestructible = var_0;
}

connecttraverses()
{
    var_0 = _ID14803();

    if ( !isdefined( var_0 ) )
        return;

    var_0 call [[ level._ID7872 ]]();
    var_0.origin = var_0.origin - ( 0, 0, 10000 );
}

disconnecttraverses()
{
    var_0 = _ID14803();

    if ( !isdefined( var_0 ) )
        return;

    var_0.origin = var_0.origin + ( 0, 0, 10000 );
    var_0 call [[ level._ID10188 ]]();
    var_0.origin = var_0.origin - ( 0, 0, 10000 );
}

_ID14803()
{
    if ( !isdefined( self.target ) )
        return undefined;

    var_0 = getentarray( self.target, "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( isspawner( var_2 ) )
            continue;

        if ( isdefined( var_2.script_destruct_collision ) )
            continue;

        if ( var_2.code_classname == "light" )
            continue;

        if ( !var_2.spawnflags & 1 )
            continue;

        return var_2;
    }
}

_ID16895( var_0 )
{
    self hidepart( var_0 );
}

_ID29956( var_0 )
{
    self showpart( var_0 );
}

_ID10086()
{
    self.dontallowexplode = 1;
}

_ID13487()
{
    self.dontallowexplode = undefined;
    self._ID13524 = 1;
    self notify( "damage",  100000, self, self.origin, self.origin, "MOD_EXPLOSIVE", "", ""  );
}

_ID14435()
{
    if ( !common_scripts\utility::_ID18787() )
        return self;

    if ( self.modeldummyon )
        var_0 = self._ID21272;
    else
        var_0 = self;

    return var_0;
}

_ID23795( var_0, var_1 )
{
    var_2 = _ID14435();
    var_3 = spawn( "script_origin", ( 0, 0, 0 ) );

    if ( isdefined( var_1 ) )
        var_3.origin = var_2 gettagorigin( var_1 );
    else
        var_3.origin = var_2.origin;

    var_3 playloopsound( var_0 );
    var_2 thread force_stop_sound( var_0 );
    var_2 waittill( "stop sound" + var_0 );

    if ( !isdefined( var_3 ) )
        return;

    var_3 stoploopsound( var_0 );
    var_3 delete();
}

force_stop_sound( var_0 )
{
    self endon( "stop sound" + var_0 );
    level waittill( "putout_fires" );
    self notify( "stop sound" + var_0 );
}

notifydamageafterframe( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( level.notifydamageafterframe ) )
        return;

    level.notifydamageafterframe = 1;
    waittillframeend;

    if ( isdefined( self.exploded ) )
    {
        level.notifydamageafterframe = undefined;
        return;
    }

    if ( common_scripts\utility::_ID18787() )
        var_0 /= 0.5;
    else
        var_0 /= 1.0;

    self notify( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6  );
    level.notifydamageafterframe = undefined;
}

_ID23837( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
    {
        var_2 = spawn( "script_origin", self gettagorigin( var_1 ) );
        var_2 hide();
        var_2 linkto( self, var_1, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    else
    {
        var_2 = spawn( "script_origin", ( 0, 0, 0 ) );
        var_2 hide();
        var_2.origin = self.origin;
        var_2.angles = self.angles;
        var_2 linkto( self );
    }

    var_2 playsound( var_0 );
    wait 5.0;

    if ( isdefined( var_2 ) )
        var_2 delete();
}

_ID33139( var_0 )
{
    return "" + var_0;
}

_ID10270()
{
    if ( isdefined( self._ID6705 ) )
        return;

    self._ID6705 = 1;

    if ( !_ID29808() )
        return;

    self.car_alarm_org = spawn( "script_model", self.origin );
    self.car_alarm_org hide();
    self.car_alarm_org playloopsound( "car_alarm" );
    level._ID8686++;
    thread car_alarm_timeout();
    self waittill( "stop_car_alarm" );
    level.lastcaralarmtime = gettime();
    level._ID8686--;
    self.car_alarm_org stoploopsound( "car_alarm" );
    self.car_alarm_org delete();
}

car_alarm_timeout()
{
    self endon( "stop_car_alarm" );
    wait 25;

    if ( !isdefined( self ) )
        return;

    thread _ID23837( "car_alarm_off" );
    self notify( "stop_car_alarm" );
}

_ID29808()
{
    if ( level._ID8686 >= 2 )
        return 0;

    var_0 = undefined;

    if ( !isdefined( level.lastcaralarmtime ) )
    {
        if ( common_scripts\utility::_ID7657() )
            return 1;

        var_0 = gettime() - level.commonstarttime;
    }
    else
        var_0 = gettime() - level.lastcaralarmtime;

    if ( level._ID8686 == 0 && var_0 >= 120 )
        return 1;

    if ( randomint( 100 ) <= 33 )
        return 1;

    return 0;
}

_ID10307( var_0, var_1, var_2, var_3 )
{
    var_4 = [];

    if ( common_scripts\utility::_ID18787() )
    {
        self attach( var_1, var_0, 0 );

        if ( isdefined( var_2 ) && var_2 != "" )
            self attach( var_2, var_0, 0 );
    }
    else
    {
        var_4[0] = spawn( "script_model", self gettagorigin( var_0 ) );
        var_4[0].angles = self gettagangles( var_0 );
        var_4[0] setmodel( var_1 );
        var_4[0] linkto( self, var_0 );

        if ( isdefined( var_2 ) && var_2 != "" )
        {
            var_4[1] = spawn( "script_model", self gettagorigin( var_0 ) );
            var_4[1].angles = self gettagangles( var_0 );
            var_4[1] setmodel( var_2 );
            var_4[1] linkto( self, var_0 );
        }
    }

    if ( isdefined( var_3 ) )
    {
        var_5 = self gettagorigin( var_0 );
        var_6 = get_closest_with_targetname( var_5, var_3 );

        if ( isdefined( var_6 ) )
            var_6 delete();
    }

    self waittill( "exploded" );

    if ( common_scripts\utility::_ID18787() )
    {
        self detach( var_1, var_0 );
        self attach( var_1 + "_destroy", var_0, 0 );

        if ( isdefined( var_2 ) && var_2 != "" )
        {
            self detach( var_2, var_0 );
            self attach( var_2 + "_destroy", var_0, 0 );
        }
    }
    else
    {
        var_4[0] setmodel( var_1 + "_destroy" );

        if ( isdefined( var_2 ) && var_2 != "" )
            var_4[1] setmodel( var_2 + "_destroy" );
    }
}

get_closest_with_targetname( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = undefined;
    var_4 = getentarray( var_1, "targetname" );

    foreach ( var_6 in var_4 )
    {
        var_7 = distancesquared( var_0, var_6.origin );

        if ( !isdefined( var_2 ) || var_7 < var_2 )
        {
            var_2 = var_7;
            var_3 = var_6;
        }
    }

    return var_3;
}

player_touching_post_clip()
{
    var_0 = undefined;

    if ( !isdefined( self.target ) )
        return 0;

    var_1 = getentarray( self.target, "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3.script_destruct_collision ) && var_3.script_destruct_collision == "post" )
        {
            var_0 = var_3;
            break;
        }
    }

    if ( !isdefined( var_0 ) )
        return 0;

    var_5 = _ID14674( var_0 );

    if ( isdefined( var_5 ) )
        return 1;

    return 0;
}

_ID14674( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( !isalive( var_2 ) )
            continue;

        if ( var_0 istouching( var_2 ) )
            return var_2;
    }

    return undefined;
}

_ID18493()
{
    return getdvar( "specialops" ) == "1";
}

destructible_handles_collision_brushes()
{
    var_0 = getentarray( self.target, "targetname" );
    var_1 = [];
    var_1["pre"] = ::collision_brush_pre_explosion;
    var_1["post"] = ::collision_brush_post_explosion;

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.script_destruct_collision ) )
            continue;

        self thread [[ var_1[var_3.script_destruct_collision] ]]( var_3 );
    }
}

collision_brush_pre_explosion( var_0 )
{
    waittillframeend;

    if ( common_scripts\utility::_ID18787() && var_0.spawnflags & 1 )
        var_0 call [[ level._ID10188 ]]();

    self waittill( "exploded" );

    if ( common_scripts\utility::_ID18787() && var_0.spawnflags & 1 )
        var_0 call [[ level._ID7872 ]]();

    var_0 delete();
}

collision_brush_post_explosion( var_0 )
{
    var_0 notsolid();

    if ( common_scripts\utility::_ID18787() && var_0.spawnflags & 1 )
        var_0 call [[ level._ID7872 ]]();

    self waittill( "exploded" );
    waittillframeend;

    if ( common_scripts\utility::_ID18787() )
    {
        if ( var_0.spawnflags & 1 )
            var_0 call [[ level._ID10188 ]]();

        if ( _ID18493() )
        {
            var_1 = _ID14674( var_0 );

            if ( isdefined( var_1 ) )
                self thread [[ level._ID13737 ]]( var_1 );
        }
        else
        {

        }
    }

    var_0 solid();
}

debug_player_in_post_clip( var_0 )
{

}

_ID9853( var_0 )
{
    var_1 = getentarray( "light_destructible", "targetname" );

    if ( common_scripts\utility::_ID18787() )
    {
        var_2 = getentarray( "light_destructible", "script_noteworthy" );
        var_1 = common_scripts\utility::array_combine( var_1, var_2 );
    }

    if ( !var_1.size )
        return;

    var_3 = var_0 * var_0;
    var_4 = undefined;

    foreach ( var_6 in var_1 )
    {
        var_7 = distancesquared( self.origin, var_6.origin );

        if ( var_7 < var_3 )
        {
            var_4 = var_6;
            var_3 = var_7;
        }
    }

    if ( !isdefined( var_4 ) )
        return;

    self.breakable_light = var_4;
}

break_nearest_light( var_0 )
{
    if ( !isdefined( self.breakable_light ) )
        return;

    self.breakable_light setlightintensity( 0 );
}

debug_radiusdamage_circle( var_0, var_1, var_2, var_3 )
{
    var_4 = 16;
    var_5 = 360 / var_4;
    var_6 = [];

    for ( var_7 = 0; var_7 < var_4; var_7++ )
    {
        var_8 = var_5 * var_7;
        var_9 = cos( var_8 ) * var_1;
        var_10 = sin( var_8 ) * var_1;
        var_11 = var_0[0] + var_9;
        var_12 = var_0[1] + var_10;
        var_13 = var_0[2];
        var_6[var_6.size] = ( var_11, var_12, var_13 );
    }

    thread _ID9171( var_6, 5.0, ( 1, 0, 0 ), var_0 );
    var_6 = [];

    for ( var_7 = 0; var_7 < var_4; var_7++ )
    {
        var_8 = var_5 * var_7;
        var_9 = cos( var_8 ) * var_1;
        var_10 = sin( var_8 ) * var_1;
        var_11 = var_0[0];
        var_12 = var_0[1] + var_9;
        var_13 = var_0[2] + var_10;
        var_6[var_6.size] = ( var_11, var_12, var_13 );
    }

    thread _ID9171( var_6, 5.0, ( 1, 0, 0 ), var_0 );
    var_6 = [];

    for ( var_7 = 0; var_7 < var_4; var_7++ )
    {
        var_8 = var_5 * var_7;
        var_9 = cos( var_8 ) * var_1;
        var_10 = sin( var_8 ) * var_1;
        var_11 = var_0[0] + var_10;
        var_12 = var_0[1];
        var_13 = var_0[2] + var_9;
        var_6[var_6.size] = ( var_11, var_12, var_13 );
    }

    thread _ID9171( var_6, 5.0, ( 1, 0, 0 ), var_0 );
}

_ID9171( var_0, var_1, var_2, var_3 )
{
    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        var_5 = var_0[var_4];

        if ( var_4 + 1 >= var_0.size )
            var_6 = var_0[0];
        else
            var_6 = var_0[var_4 + 1];

        thread debug_line( var_5, var_6, var_1, var_2 );
        thread debug_line( var_3, var_5, var_1, var_2 );
    }
}

debug_line( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = ( 1, 1, 1 );

    for ( var_4 = 0; var_4 < var_2 * 20; var_4++ )
        wait 0.05;
}

spotlight_tag_origin_cleanup( var_0 )
{
    var_0 endon( "death" );
    level waittill( "new_destructible_spotlight" );
    var_0 delete();
}

_ID31084( var_0, var_1, var_2, var_3, var_4 )
{
    level endon( "new_destructible_spotlight" );
    thread spotlight_tag_origin_cleanup( var_4 );
    var_5 = var_0["spotlight_brightness"];
    wait(randomfloatrange( 2, 5 ));
    destructible_fx_think( var_0, var_1, var_2, var_3 );
    level.destructible_spotlight delete();
    var_4 delete();
}

destructible_spotlight_think( var_0, var_1, var_2, var_3 )
{
    if ( !common_scripts\utility::_ID18787() )
        return;

    if ( !isdefined( self.breakable_light ) )
        return;

    var_1 common_scripts\utility::self_func( "startignoringspotLight" );

    if ( !isdefined( level.destructible_spotlight ) )
    {
        level.destructible_spotlight = common_scripts\utility::_ID30774();
        var_4 = common_scripts\utility::_ID15033( var_0["spotlight_fx"] );
        playfxontag( var_4, level.destructible_spotlight, "tag_origin" );
    }

    level notify( "new_destructible_spotlight" );
    level.destructible_spotlight unlink();
    var_5 = common_scripts\utility::_ID30774();
    var_5 linkto( self, var_0["spotlight_tag"], ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.destructible_spotlight.origin = self.breakable_light.origin;
    level.destructible_spotlight.angles = self.breakable_light.angles;
    level.destructible_spotlight thread _ID31084( var_0, var_1, var_2, var_3, var_5 );
    wait 0.05;

    if ( isdefined( var_5 ) )
        level.destructible_spotlight linkto( var_5 );
}

_ID18515( var_0, var_1, var_2, var_3 )
{
    var_4 = undefined;

    if ( isdefined( var_1["fx_valid_damagetype"] ) )
        var_4 = var_1["fx_valid_damagetype"][var_3][var_2];

    if ( !isdefined( var_4 ) )
        return 1;

    return issubstr( var_4, var_0 );
}

destructible_sound_think( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self.exploded ) )
        return undefined;

    if ( !isdefined( var_0["sound"] ) )
        return undefined;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_0["sound"][var_3] ) )
        return undefined;

    for ( var_4 = 0; var_4 < var_0["sound"][var_3].size; var_4++ )
    {
        var_5 = isvalidsoundcause( "soundCause", var_0, var_4, var_2, var_3 );

        if ( !var_5 )
            continue;

        var_6 = var_0["sound"][var_3][var_4];
        var_7 = var_0["tagName"];
        var_1 thread _ID23837( var_6, var_7 );
    }

    return var_3;
}

destructible_fx_think( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_0["fx"] ) )
        return undefined;

    if ( !isdefined( var_4 ) )
        var_4 = randomint( var_0["fx_filename"].size );

    if ( !isdefined( var_0["fx"][var_4] ) )
        var_4 = randomint( var_0["fx_filename"].size );

    var_5 = var_0["fx_filename"][var_4].size;

    for ( var_6 = 0; var_6 < var_5; var_6++ )
    {
        if ( !_ID18515( var_2, var_0, var_6, var_4 ) )
            continue;

        var_7 = var_0["fx"][var_4][var_6];

        if ( isdefined( var_0["fx_tag"][var_4][var_6] ) )
        {
            var_8 = var_0["fx_tag"][var_4][var_6];
            self notify( "FX_State_Change" + var_3 );

            if ( var_0["fx_useTagAngles"][var_4][var_6] )
                playfxontag( var_7, var_1, var_8 );
            else
            {
                var_9 = var_1 gettagorigin( var_8 );
                var_10 = var_9 + ( 0, 0, 100 ) - var_9;
                playfx( var_7, var_9, var_10 );
            }

            continue;
        }

        var_9 = var_1.origin;
        var_10 = var_9 + ( 0, 0, 100 ) - var_9;
        playfx( var_7, var_9, var_10 );
    }

    return var_4;
}

_ID9825( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self.exploded ) )
        return undefined;

    if ( !isdefined( var_0["animation"] ) )
        return undefined;

    if ( isdefined( self._ID22042 ) )
        return undefined;

    if ( isdefined( var_0["randomly_flip"] ) && !isdefined( self._ID27741 ) )
    {
        if ( common_scripts\utility::_ID7657() )
            self.angles = self.angles + ( 0, 180, 0 );
    }

    if ( isdefined( var_0["spotlight_tag"] ) )
    {
        thread destructible_spotlight_think( var_0, var_1, var_2, var_3 );
        wait 0.05;
    }

    var_4 = common_scripts\utility::_ID25350( var_0["animation"] );
    var_5 = var_4["anim"];
    var_6 = var_4["animTree"];
    var_7 = var_4["groupNum"];
    var_8 = var_4["mpAnim"];
    var_9 = var_4["maxStartDelay"];
    var_10 = var_4["animRateMin"];
    var_11 = var_4["animRateMax"];

    if ( !isdefined( var_10 ) )
        var_10 = 1.0;

    if ( !isdefined( var_11 ) )
        var_11 = 1.0;

    if ( var_10 == var_11 )
        var_12 = var_10;
    else
        var_12 = randomfloatrange( var_10, var_11 );

    var_13 = var_4["vehicle_exclude_anim"];

    if ( self.code_classname == "script_vehicle" && var_13 )
        return undefined;

    var_1 common_scripts\utility::self_func( "useanimtree", var_6 );
    var_14 = var_4["animType"];

    if ( !isdefined( self.animsapplied ) )
        self.animsapplied = [];

    self.animsapplied[self.animsapplied.size] = var_5;

    if ( isdefined( self._ID12495 ) )
        _ID7414( var_1 );

    if ( isdefined( var_9 ) && var_9 > 0 )
        wait(randomfloat( var_9 ));

    if ( !common_scripts\utility::_ID18787() )
    {
        if ( isdefined( var_8 ) )
            common_scripts\utility::self_func( "scriptModelPlayAnim", var_8 );

        return var_7;
    }

    if ( var_14 == "setanim" )
    {
        var_1 common_scripts\utility::self_func( "setanim", var_5, 1.0, 1.0, var_12 );
        return var_7;
    }

    if ( var_14 == "setanimknob" )
    {
        var_1 common_scripts\utility::self_func( "setanimknob", var_5, 1.0, 0, var_12 );
        return var_7;
    }

    return undefined;
}

_ID7414( var_0 )
{
    if ( isdefined( self.animsapplied ) )
    {
        foreach ( var_2 in self.animsapplied )
        {
            if ( common_scripts\utility::_ID18787() )
            {
                var_0 common_scripts\utility::self_func( "clearanim", var_2, 0 );
                continue;
            }

            var_0 common_scripts\utility::self_func( "scriptModelClearAnim" );
        }
    }
}

_ID17719()
{
    level._ID9798 = 0;
    level.destroyedcounttimeout = 0.5;

    if ( common_scripts\utility::_ID18787() )
        level.maxdestructions = 20;
    else
        level.maxdestructions = 2;
}

add_to_destroyed_count()
{
    level._ID9798++;
    wait(level.destroyedcounttimeout);
    level._ID9798--;
}

_ID14415()
{
    return level._ID9798;
}

_ID14580()
{
    return level.maxdestructions;
}

_ID17721()
{
    level._ID9890 = [];
}

add_destructible_to_frame_queue( var_0, var_1, var_2 )
{
    var_3 = self getentitynumber();

    if ( !isdefined( level._ID9890[var_3] ) )
    {
        level._ID9890[var_3] = spawnstruct();
        level._ID9890[var_3].entnum = var_3;
        level._ID9890[var_3].destructible = var_0;
        level._ID9890[var_3]._ID33154 = 0;
        level._ID9890[var_3].neardistance = 9999999;
        level._ID9890[var_3].fxcost = 0;
    }

    level._ID9890[var_3].fxcost = level._ID9890[var_3].fxcost + var_1._ID34830["fxcost"];
    level._ID9890[var_3]._ID33154 = level._ID9890[var_3]._ID33154 + var_2;

    if ( var_1._ID34830["distance"] < level._ID9890[var_3].neardistance )
        level._ID9890[var_3].neardistance = var_1._ID34830["distance"];

    thread _ID16071();
}

_ID16071()
{
    level notify( "handle_destructible_frame_queue" );
    level endon( "handle_destructible_frame_queue" );
    wait 0.05;
    var_0 = level._ID9890;
    level._ID9890 = [];
    var_1 = _ID30448( var_0 );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( _ID14415() < _ID14580() )
        {
            if ( var_1[var_2].fxcost )
                thread add_to_destroyed_count();

            var_1[var_2].destructible notify( "queue_processed",  1  );
            continue;
        }

        var_1[var_2].destructible notify( "queue_processed",  0  );
    }
}

_ID30448( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
        var_1[var_1.size] = var_3;

    for ( var_5 = 1; var_5 < var_1.size; var_5++ )
    {
        var_6 = var_1[var_5];

        for ( var_7 = var_5 - 1; var_7 >= 0 && _ID14316( var_6, var_1[var_7] ) == var_6; var_7-- )
            var_1[var_7 + 1] = var_1[var_7];

        var_1[var_7 + 1] = var_6;
    }

    return var_1;
}

_ID14316( var_0, var_1 )
{
    if ( var_0._ID33154 > var_1._ID33154 )
        return var_0;
    else
        return var_1;
}

get_part_fx_cost_for_action_state( var_0, var_1 )
{
    var_2 = 0;

    if ( !isdefined( level.destructible_type[self._ID9891]._ID23309[var_0][var_1] ) )
        return var_2;

    var_3 = level.destructible_type[self._ID9891]._ID23309[var_0][var_1]._ID34830;

    if ( isdefined( var_3["fx"] ) )
    {
        foreach ( var_5 in var_3["fx_cost"] )
        {
            foreach ( var_7 in var_5 )
                var_2 += var_7;
        }
    }

    return var_2;
}

initdot( var_0 )
{
    if ( !common_scripts\utility::flag_exist( "FLAG_DOT_init" ) )
    {
        common_scripts\utility::_ID13189( "FLAG_DOT_init" );
        common_scripts\utility::flag_set( "FLAG_DOT_init" );
    }

    var_0 = tolower( var_0 );

    switch ( var_0 )
    {
        case "poison":
            if ( !common_scripts\utility::flag_exist( "FLAG_DOT_poison_init" ) )
            {
                common_scripts\utility::_ID13189( "FLAG_DOT_poison_init" );
                common_scripts\utility::flag_set( "FLAG_DOT_poison_init" );
            }

            break;
    }

    endswitch( 2 )  case "poison" loc_5384 default loc_53AC
}

createdot()
{
    var_0 = spawnstruct();
    var_0._ID32975 = [];
    return var_0;
}

createdot_radius( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4.type = "trigger_radius";
    var_4.origin = var_0;
    var_4.spawnflags = var_1;
    var_4.radius = var_2;
    var_4.minradius = var_2;
    var_4.maxradius = var_2;
    var_4.height = var_3;
    var_4._ID32975 = [];
    return var_4;
}

_ID28705( var_0 )
{
    self.origin = var_0;
}

_ID28706( var_0, var_1 )
{
    if ( isdefined( self.classname ) && self.classname != "trigger_radius" )
    {

    }

    if ( !isdefined( var_1 ) )
        var_1 = var_0;

    self.minradius = var_0;
    self.maxradius = var_1;
}

_ID28703( var_0, var_1 )
{
    if ( isdefined( self.classname ) && issubstr( self.classname, "trigger" ) )
        return;
}

_ID28704( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( isdefined( var_0 ) )
    {

    }
    else
        var_0 = 0;

    var_6 = tolower( var_6 );
    var_7 = tolower( var_7 );
    var_8 = self._ID32975.size;
    self._ID32975[var_8] = spawnstruct();
    self._ID32975[var_8].enable = 0;
    self._ID32975[var_8].delay = var_0;
    self._ID32975[var_8].interval = var_1;
    self._ID32975[var_8]._ID11157 = var_2;
    self._ID32975[var_8]._ID21043 = var_3;
    self._ID32975[var_8]._ID20725 = var_4;

    switch ( var_5 )
    {
        case 0:
        case 1:
            break;
    }

    endswitch( 3 )  case 1 loc_54F5 case 0 loc_54F5 default loc_54FA
    self._ID32975[var_8].falloff = var_5;
    self._ID32975[var_8]._ID31480 = 0;

    switch ( var_6 )
    {
        case "normal":
            break;
        case "poison":
            switch ( var_7 )
            {
                case "player":
                    self._ID32975[var_8].type = var_6;
                    self._ID32975[var_8].affected = var_7;
                    self._ID32975[var_8]._ID22825 = ::_ID22824;
                    self._ID32975[var_8]._ID22836 = ::_ID22835;
                    self._ID32975[var_8].ondeathfunc = ::_ID22800;
                    break;
            }

            endswitch( 2 )  case "player" loc_5539 default loc_557E
            break;
    }

    endswitch( 3 )  case "poison" loc_5533 case "normal" loc_552E default loc_5594
}

builddot_ontick( var_0, var_1 )
{
    var_1 = tolower( var_1 );
    var_2 = self._ID32975.size;
    self._ID32975[var_2] = spawnstruct();
    self._ID32975[var_2]._ID11157 = var_0;
    self._ID32975[var_2].delay = 0;
    self._ID32975[var_2]._ID22825 = ::_ID22820;
    self._ID32975[var_2]._ID22836 = ::_ID22833;
    self._ID32975[var_2].ondeathfunc = ::_ID22799;

    switch ( var_1 )
    {
        case "player":
            self._ID32975[var_2].affected = var_1;
            break;
    }

    endswitch( 2 )  case "player" loc_560C default loc_561C
}

_ID6235( var_0 )
{
    var_1 = self._ID32975.size - 1;

    if ( !isdefined( self._ID32975[var_1]._ID31507 ) )
        self._ID32975[var_1]._ID31507 = [];

    var_2 = self._ID32975[var_1]._ID31507.size;
    self._ID32975[var_1]._ID31507 = [];
    self._ID32975[var_1]._ID31507["vars"] = [];
    self._ID32975[var_1]._ID31507["vars"]["count"] = var_0;
}

builddot_damage( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = self._ID32975.size - 1;

    if ( !isdefined( self._ID32975[var_6]._ID31507["actions"] ) )
        self._ID32975[var_6]._ID31507["actions"] = [];

    var_7 = self._ID32975[var_6]._ID31507["actions"].size;
    self._ID32975[var_6]._ID31507["actions"][var_7] = [];
    self._ID32975[var_6]._ID31507["actions"][var_7]["vars"] = [ var_0, var_1, var_2, var_3, var_4, var_5 ];
    self._ID32975[var_6]._ID31507["actions"][var_7]["func"] = ::_ID10334;
}

builddot_wait( var_0 )
{
    var_1 = self._ID32975.size - 1;

    if ( !isdefined( self._ID32975[var_1]._ID31507["actions"] ) )
        self._ID32975[var_1]._ID31507["actions"] = [];

    var_2 = self._ID32975[var_1]._ID31507["actions"].size;
    self._ID32975[var_1]._ID31507["actions"][var_2] = [];
    self._ID32975[var_1]._ID31507["actions"][var_2]["vars"] = [ var_0 ];
    self._ID32975[var_1]._ID31507["actions"][var_2]["func"] = ::dobuilddot_wait;
}

_ID22820( var_0, var_1 )
{
    var_2 = var_1 getentitynumber();
    var_1 endon( "death" );
    var_1 endon( "LISTEN_kill_tick_" + var_0 + "_" + var_2 );
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "death" );
    self endon( "LISTEN_exit_dot_" + var_2 );
    var_2 = undefined;
    var_3 = var_1._ID32975[var_0]._ID31507;

    if ( !isdefined( var_3 ) || !isdefined( var_3["vars"] ) || !isdefined( var_3["vars"]["count"] ) || !isdefined( var_3["actions"] ) )
        return;

    var_4 = var_3["vars"]["count"];
    var_5 = var_3["actions"];
    var_3 = undefined;

    for ( var_6 = 1; var_6 <= var_4 || var_4 == 0; var_6-- )
    {
        foreach ( var_8 in var_5 )
        {
            var_9 = var_8["vars"];
            var_10 = var_8["func"];
            self [[ var_10 ]]( var_0, var_1, var_9 );
        }
    }
}

_ID22833( var_0, var_1 )
{
    var_2 = var_1 getentitynumber();
    var_3 = self getentitynumber();
    var_1 notify( "LISTEN_kill_tick_" + var_0 + "_" + var_2 + "_" + var_3 );
}

_ID22799( var_0, var_1 )
{

}

_ID10334( var_0, var_1, var_2 )
{
    var_3 = var_2[0];
    var_4 = var_2[1];
    var_5 = var_2[2];
    var_6 = var_2[3];
    var_7 = var_2[4];
    var_8 = var_2[5];
    self thread [[ level.callbackplayerdamage ]]( var_1, var_1, var_4, var_6, var_7, var_8, var_1.origin, ( 0, 0, 0 ) - var_1.origin, "none", 0 );
}

dobuilddot_wait( var_0, var_1, var_2 )
{
    var_3 = var_1 getentitynumber();
    var_4 = self getentitynumber();
    var_1 endon( "death" );
    var_1 endon( "LISTEN_kill_tick_" + var_0 + "_" + var_3 );
    var_1 notify( "LISTEN_kill_tick_" + var_0 + "_" + var_3 + "_" + var_4 );
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "death" );
    self endon( "LISTEN_exit_dot_" + var_3 );
    var_3 = undefined;
    var_4 = undefined;
    wait(var_2[0]);
}

_ID31432( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        var_4 = undefined;

        switch ( var_3.type )
        {
            case "trigger_radius":
                var_4 = spawn( "trigger_radius", var_3.origin, var_3.spawnflags, var_3.radius, var_3.height );
                var_4.minradius = var_3.minradius;
                var_4.maxradius = var_3.maxradius;
                var_4._ID32975 = var_3._ID32975;
                var_1[var_1.size] = var_4;
                break;
        }

        endswitch( 2 )  case "trigger_radius" loc_5A04 default loc_5A50

        if ( isdefined( var_3._ID23270 ) )
        {
            var_4 linkto( var_3._ID23270 );
            var_3._ID23270._ID10775 = var_4;
        }

        var_5 = var_4._ID32975;

        foreach ( var_7 in var_5 )
            var_7._ID31480 = gettime();

        foreach ( var_7 in var_5 )
        {
            if ( !var_7.delay )
                var_7.enable = 1;
        }

        foreach ( var_7 in var_5 )
        {
            if ( issubstr( var_7.affected, "player" ) )
            {
                var_4._ID22876 = 1;
                break;
            }
        }
    }

    foreach ( var_4 in var_1 )
    {
        var_4._ID10777 = [];

        foreach ( var_16 in var_1 )
        {
            if ( var_4 == var_16 )
                continue;

            var_4._ID10777[var_4._ID10777.size] = var_16;
        }
    }

    foreach ( var_4 in var_1 )
    {
        if ( var_4._ID22876 )
            var_4 thread _ID31433();
    }

    foreach ( var_4 in var_1 )
        var_4 thread _ID21376();
}

_ID31433()
{
    thread _ID33725( ::onenterdot_player, ::_ID22834 );
}

_ID21376()
{
    var_0 = gettime();

    while ( isdefined( self ) )
    {
        foreach ( var_4, var_2 in self._ID32975 )
        {
            if ( isdefined( var_2 ) && gettime() - var_0 >= var_2._ID11157 * 1000 )
            {
                var_3 = self getentitynumber();
                self notify( "LISTEN_kill_tick_" + var_4 + "_" + var_3 );
                self._ID32975[var_4] = undefined;
            }
        }

        if ( !self._ID32975.size )
            break;

        wait 0.05;
    }

    if ( isdefined( self ) )
    {
        foreach ( var_2 in self._ID32975 )
            self [[ var_2.ondeathfunc ]]();

        self notify( "death" );
        self delete();
    }
}

onenterdot_player( var_0 )
{
    var_1 = var_0 getentitynumber();
    self notify( "LISTEN_enter_dot_" + var_1 );

    foreach ( var_4, var_3 in var_0._ID32975 )
    {
        if ( !var_3.enable )
            thread dodot_delayfunc( var_4, var_0, var_3.delay, var_3._ID22825 );
    }

    foreach ( var_4, var_3 in var_0._ID32975 )
    {
        if ( var_3.enable && var_3.affected == "player" )
            self thread [[ var_3._ID22825 ]]( var_4, var_0 );
    }
}

_ID22834( var_0 )
{
    var_1 = var_0 getentitynumber();
    self notify( "LISTEN_exit_dot_" + var_1 );

    foreach ( var_4, var_3 in var_0._ID32975 )
    {
        if ( var_3.enable && var_3.affected == "player" )
            self thread [[ var_3._ID22836 ]]( var_4, var_0 );
    }
}

dodot_delayfunc( var_0, var_1, var_2, var_3 )
{
    var_4 = var_1 getentitynumber();
    var_5 = self getentitynumber();
    var_1 endon( "LISTEN_kill_tick_" + var_0 + "_" + var_4 + "_" + var_5 );
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "death" );
    self notify( "LISTEN_exit_dot_" + var_4 );
    var_4 = undefined;
    var_5 = undefined;
    wait(var_2);
    self thread [[ var_3 ]]( var_0, var_1 );
}

_ID22824( var_0, var_1 )
{
    var_2 = var_1 getentitynumber();
    var_3 = self getentitynumber();
    var_1 endon( "death" );
    var_1 endon( "LISTEN_kill_tick_" + var_0 + "_" + var_2 );
    var_1 endon( "LISTEN_kill_tick_" + var_0 + "_" + var_2 + "_" + var_3 );
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "death" );
    self endon( "LISTEN_exit_dot_" + var_2 );

    if ( !isdefined( self._ID22822 ) )
        self._ID22822 = [];

    if ( !isdefined( self._ID22822[var_0] ) )
        self._ID22822[var_0] = [];

    self._ID22822[var_0][var_2] = 0;
    var_4 = common_scripts\utility::_ID32831( common_scripts\utility::_ID18787(), 1.5, 1 );

    while ( isdefined( var_1 ) && isdefined( var_1._ID32975[var_0] ) )
    {
        self._ID22822[var_0][var_2]++;

        switch ( self._ID22822[var_0][var_2] )
        {
            case 1:
                self viewkick( 1, self.origin );
                break;
            case 3:
                self shellshock( "mp_radiation_low", 4 );
                _ID10355( var_1, var_4 * 2 );
                break;
            case 4:
                self shellshock( "mp_radiation_med", 5 );
                thread _ID10354( var_0, var_1 );
                _ID10355( var_1, var_4 * 2 );
                break;
            case 6:
                self shellshock( "mp_radiation_high", 5 );
                _ID10355( var_1, var_4 * 2 );
                break;
            case 8:
                self shellshock( "mp_radiation_high", 5 );
                _ID10355( var_1, var_4 * 500 );
                break;
        }

        wait(var_1._ID32975[var_0].interval);
    }
}

_ID22835( var_0, var_1 )
{
    var_2 = var_1 getentitynumber();
    var_3 = self getentitynumber();
    var_4 = self.onenterdot_poisondamageoverlay;

    if ( isdefined( var_4 ) )
    {
        foreach ( var_7, var_6 in var_4 )
        {
            if ( isdefined( var_4[var_7] ) && isdefined( var_4[var_7][var_2] ) )
                var_4[var_7][var_2] thread _ID10352( 0.1, 0 );
        }
    }

    var_1 notify( "LISTEN_kill_tick_" + var_0 + "_" + var_2 + "_" + var_3 );
}

_ID22800()
{
    var_0 = self getentitynumber();

    foreach ( var_2 in level.players )
    {
        var_3 = var_2.onenterdot_poisondamageoverlay;

        if ( isdefined( var_3 ) )
        {
            foreach ( var_6, var_5 in var_3 )
            {
                if ( isdefined( var_3[var_6] ) && isdefined( var_3[var_6][var_0] ) )
                    var_3[var_6][var_0] thread _ID10353();
            }
        }
    }
}

_ID10355( var_0, var_1 )
{
    if ( common_scripts\utility::_ID18787() )
        return;

    self thread [[ level.callbackplayerdamage ]]( var_0, var_0, var_1, 0, "MOD_SUICIDE", "claymore_mp", var_0.origin, ( 0, 0, 0 ) - var_0.origin, "none", 0 );
    return;
}

_ID10354( var_0, var_1 )
{
    var_2 = var_1 getentitynumber();
    var_3 = self getentitynumber();
    var_1 endon( "death" );
    var_1 endon( "LISTEN_kill_tick_" + var_0 + "_" + var_2 );
    var_1 endon( "LISTEN_kill_tick_" + var_0 + "_" + var_2 + "_" + var_3 );
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "death" );
    self endon( "LISTEN_exit_dot_" + var_2 );

    if ( !isdefined( self.onenterdot_poisondamageoverlay ) )
        self.onenterdot_poisondamageoverlay = [];

    if ( !isdefined( self.onenterdot_poisondamageoverlay[var_0] ) )
        self.onenterdot_poisondamageoverlay[var_0] = [];

    if ( !isdefined( self.onenterdot_poisondamageoverlay[var_0][var_2] ) )
    {
        var_4 = newclienthudelem( self );
        var_4.x = 0;
        var_4.y = 0;
        var_4.alignx = "left";
        var_4.aligny = "top";
        var_4.horzalign = "fullscreen";
        var_4.vertalign = "fullscreen";
        var_4.alpha = 0;
        var_4 setshader( "black", 640, 480 );
        self.onenterdot_poisondamageoverlay[var_0][var_2] = var_4;
    }

    var_4 = self.onenterdot_poisondamageoverlay[var_0][var_2];
    var_5 = 1;
    var_6 = 2;
    var_7 = 0.25;
    var_8 = 1;
    var_9 = 5;
    var_10 = 100;
    var_11 = 0;

    for (;;)
    {
        while ( self._ID22822[var_0][var_2] > 1 )
        {
            var_12 = var_10 - var_9;
            var_11 = ( self._ID22822[var_0][var_2] - var_9 ) / var_12;

            if ( var_11 < 0 )
                var_11 = 0;
            else if ( var_11 > 1 )
                var_11 = 1;

            var_13 = var_6 - var_5;
            var_14 = var_5 + var_13 * ( 1 - var_11 );
            var_15 = var_8 - var_7;
            var_16 = var_7 + var_15 * var_11;
            var_17 = var_11 * 0.5;

            if ( var_11 == 1 )
                break;

            var_18 = var_14 / 2;
            var_4 dodot_fadeinblackout( var_18, var_16 );
            var_4 _ID10352( var_18, var_17 );
            wait(var_11 * 0.5);
        }

        if ( var_11 == 1 )
            break;

        if ( var_4.alpha != 0 )
            var_4 _ID10352( 1, 0 );

        wait 0.05;
    }

    var_4 dodot_fadeinblackout( 2, 0 );
}

dodot_fadeinblackout( var_0, var_1 )
{
    self fadeovertime( var_0 );
    self.alpha = var_1;
    var_1 = undefined;
    wait(var_0);
}

_ID10352( var_0, var_1 )
{
    self fadeovertime( var_0 );
    self.alpha = var_1;
    var_1 = undefined;
    wait(var_0);
}

_ID10353( var_0, var_1 )
{
    self fadeovertime( var_0 );
    self.alpha = var_1;
    var_1 = undefined;
    wait(var_0);
    self destroy();
}

_ID33725( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self.entnum = self getentitynumber();

    for (;;)
    {
        self waittill( "trigger",  var_2  );

        if ( !isplayer( var_2 ) && !isdefined( var_2.finished_spawning ) )
            continue;

        if ( !isalive( var_2 ) )
            continue;

        if ( !isdefined( var_2._ID33168[self.entnum] ) )
            var_2 thread _ID24551( self, var_0, var_1 );
    }
}

_ID24551( var_0, var_1, var_2 )
{
    var_0 endon( "death" );

    if ( !isplayer( self ) )
        self endon( "death" );

    if ( !common_scripts\utility::_ID18787() )
        var_3 = self._ID15851;
    else
        var_3 = "player" + gettime();

    var_0._ID33167[var_3] = self;

    if ( isdefined( var_0._ID21697 ) )
        self._ID21698++;

    var_0 notify( "trigger_enter",  self  );
    self notify( "trigger_enter",  var_0  );
    var_4 = 1;

    foreach ( var_6 in var_0._ID10777 )
    {
        foreach ( var_8 in self._ID33168 )
        {
            if ( var_6 == var_8 )
                var_4 = 0;
        }
    }

    if ( var_4 && isdefined( var_1 ) )
        self thread [[ var_1 ]]( var_0 );

    self._ID33168[var_0.entnum] = var_0;

    while ( isalive( self ) && ( common_scripts\utility::_ID18787() || !level.gameended ) )
    {
        var_11 = 1;

        if ( self istouching( var_0 ) )
            wait 0.05;
        else
        {
            if ( !var_0._ID10777.size )
                var_11 = 0;

            foreach ( var_6 in var_0._ID10777 )
            {
                if ( self istouching( var_6 ) )
                {
                    wait 0.05;
                    break;
                    continue;
                }

                var_11 = 0;
            }
        }

        if ( !var_11 )
            break;
    }

    if ( isdefined( self ) )
    {
        self._ID33168[var_0.entnum] = undefined;

        if ( isdefined( var_0._ID21697 ) )
            self._ID21698--;

        self notify( "trigger_leave",  var_0  );

        if ( var_4 && isdefined( var_2 ) )
            self thread [[ var_2 ]]( var_0 );
    }

    if ( !common_scripts\utility::_ID18787() && level.gameended )
        return;

    var_0._ID33167[var_3] = undefined;
    var_0 notify( "trigger_leave",  self  );

    if ( !anythingtouchingtrigger( var_0 ) )
        var_0 notify( "trigger_empty" );
}

anythingtouchingtrigger( var_0 )
{
    return var_0._ID33167.size;
}

_ID14693( var_0 )
{
    return level._destructible_preanims[var_0];
}

_ID14694( var_0 )
{
    return level._destructible_preanimtree[var_0];
}
