// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17773()
{
    level._ID1624.options = [];
    addoption( "string", "fxid", "FX id", "nil", "fx" );
    addoption( "float", "delay", "Repeat rate/start delay", 0.5, "fx" );
    addoption( "string", "flag", "Flag", "nil", "exploder" );

    if ( !level._ID21731 )
    {
        addoption( "string", "firefx", "2nd FX id", "nil", "exploder" );
        addoption( "float", "firefxdelay", "2nd FX id repeat rate", 0.5, "exploder" );
        addoption( "float", "firefxtimeout", "2nd FX timeout", 5, "exploder" );
        addoption( "string", "firefxsound", "2nd FX soundalias", "nil", "exploder" );
        addoption( "float", "damage", "Radius damage", 150, "exploder" );
        addoption( "float", "damage_radius", "Radius of radius damage", 250, "exploder" );
        addoption( "string", "earthquake", "Earthquake", "nil", "exploder" );
        addoption( "string", "ender", "Level notify for ending 2nd FX", "nil", "exploder" );
    }

    addoption( "float", "delay_min", "Minimimum time between repeats", 1, "soundfx_interval" );
    addoption( "float", "delay_max", "Maximum time between repeats", 2, "soundfx_interval" );
    addoption( "int", "repeat", "Number of times to repeat", 5, "exploder" );
    addoption( "string", "exploder", "Exploder", "1", "exploder" );
    addoption( "string", "soundalias", "Soundalias", "nil", "all" );
    addoption( "string", "loopsound", "Loopsound", "nil", "exploder" );
    addoption( "int", "reactive_radius", "Reactive Radius", 100, "reactive_fx", ::_ID18018 );

    if ( !level._ID21731 )
    {
        addoption( "string", "rumble", "Rumble", "nil", "exploder" );
        addoption( "int", "stoppable", "Can be stopped from script", "1", "all" );
    }

    level._ID11244 = 0;
    level._ID11245 = 10;
    level.createfxmasks = [];
    level.createfxmasks["all"] = [];
    level.createfxmasks["all"]["exploder"] = 1;
    level.createfxmasks["all"]["oneshotfx"] = 1;
    level.createfxmasks["all"]["loopfx"] = 1;
    level.createfxmasks["all"]["soundfx"] = 1;
    level.createfxmasks["all"]["soundfx_interval"] = 1;
    level.createfxmasks["all"]["reactive_fx"] = 1;
    level.createfxmasks["fx"] = [];
    level.createfxmasks["fx"]["exploder"] = 1;
    level.createfxmasks["fx"]["oneshotfx"] = 1;
    level.createfxmasks["fx"]["loopfx"] = 1;
    level.createfxmasks["exploder"] = [];
    level.createfxmasks["exploder"]["exploder"] = 1;
    level.createfxmasks["loopfx"] = [];
    level.createfxmasks["loopfx"]["loopfx"] = 1;
    level.createfxmasks["oneshotfx"] = [];
    level.createfxmasks["oneshotfx"]["oneshotfx"] = 1;
    level.createfxmasks["soundfx"] = [];
    level.createfxmasks["soundfx"]["soundalias"] = 1;
    level.createfxmasks["soundfx_interval"] = [];
    level.createfxmasks["soundfx_interval"]["soundfx_interval"] = 1;
    level.createfxmasks["reactive_fx"] = [];
    level.createfxmasks["reactive_fx"]["reactive_fx"] = 1;
    var_0 = [];
    var_0["creation"] = ::_ID20938;
    var_0["create_oneshot"] = ::menu_create;
    var_0["create_loopfx"] = ::menu_create;
    var_0["change_fxid"] = ::menu_create;
    var_0["none"] = ::menu_none;
    var_0["add_options"] = ::_ID20935;
    var_0["select_by_name"] = ::_ID20942;
    level._ID1624._ID20945 = var_0;
}

_ID20934( var_0 )
{
    return level.create_fx_menu == var_0;
}

_ID28782( var_0 )
{
    level.create_fx_menu = var_0;
}

create_fx_menu()
{
    if ( common_scripts\_createfx::button_is_clicked( "escape", "x" ) )
    {
        _exit_menu();
        return;
    }

    if ( isdefined( level._ID1624._ID20945[level.create_fx_menu] ) )
        [[ level._ID1624._ID20945[level.create_fx_menu] ]]();
}

_ID20938()
{
    if ( common_scripts\_createfx::button_is_clicked( "1" ) )
    {
        _ID28782( "create_oneshot" );
        draw_effects_list();
        return;
    }
    else if ( common_scripts\_createfx::button_is_clicked( "2" ) )
    {
        _ID28782( "create_loopsound" );
        var_0 = common_scripts\_createfx::createloopsound();
        _ID12947( var_0 );
        return;
    }
    else if ( common_scripts\_createfx::button_is_clicked( "3" ) )
    {
        _ID28782( "create_exploder" );
        var_0 = common_scripts\_createfx::createnewexploder();
        _ID12947( var_0 );
        return;
    }
    else if ( common_scripts\_createfx::button_is_clicked( "4" ) )
    {
        _ID28782( "create_interval_sound" );
        var_0 = common_scripts\_createfx::createintervalsound();
        _ID12947( var_0 );
        return;
    }
    else if ( common_scripts\_createfx::button_is_clicked( "5" ) )
    {
        var_0 = common_scripts\_createfx::_ID8471();
        _ID12947( var_0 );
        return;
    }
}

menu_create()
{
    if ( _ID21970() )
    {
        _ID17539();
        draw_effects_list();
    }
    else if ( _ID24935() )
    {
        decrement_list_offset();
        draw_effects_list();
    }

    menu_fx_creation();
}

menu_none()
{
    if ( common_scripts\_createfx::button_is_clicked( "m" ) )
        _ID17539();

    _ID20936();

    if ( entities_are_selected() )
    {
        var_0 = get_last_selected_ent();

        if ( !isdefined( level._ID19444 ) || var_0 != level._ID19444 )
        {
            _ID10205( var_0 );
            level._ID19444 = var_0;
        }

        if ( common_scripts\_createfx::button_is_clicked( "a" ) )
        {
            common_scripts\_createfx::clear_settable_fx();
            _ID28782( "add_options" );
            return;
        }
    }
    else
        level._ID19444 = undefined;
}

_ID20935()
{
    if ( !entities_are_selected() )
    {
        common_scripts\_createfx::_ID7440();
        _ID28782( "none" );
        return;
    }

    display_fx_add_options( get_last_selected_ent() );

    if ( _ID21970() )
        _ID17539();
}

_ID20942()
{
    if ( _ID21970() )
    {
        _ID17539();
        draw_effects_list( "Select by name" );
    }
    else if ( _ID24935() )
    {
        decrement_list_offset();
        draw_effects_list( "Select by name" );
    }

    _ID28009();
}

_ID21970()
{
    return common_scripts\_createfx::button_is_clicked( "rightarrow" );
}

_ID24935()
{
    return common_scripts\_createfx::button_is_clicked( "leftarrow" );
}

_exit_menu()
{
    common_scripts\_createfx::_ID7440();
    common_scripts\_createfx::clear_entity_selection();
    common_scripts\_createfx::_ID34473();
    _ID28782( "none" );
}

menu_fx_creation()
{
    var_0 = 0;
    var_1 = undefined;
    var_2 = common_scripts\_createfx::func_get_level_fx();

    for ( var_3 = level._ID11244; var_3 < var_2.size; var_3++ )
    {
        var_0 += 1;
        var_4 = var_0;

        if ( var_4 == 10 )
            var_4 = 0;

        if ( common_scripts\_createfx::button_is_clicked( var_4 + "" ) )
        {
            var_1 = var_2[var_3];
            break;
        }

        if ( var_0 > level._ID11245 )
            break;
    }

    if ( !isdefined( var_1 ) )
        return;

    if ( _ID20934( "change_fxid" ) )
    {
        _ID3745( _ID14623( "fxid" ), var_1 );
        level._ID11244 = 0;
        common_scripts\_createfx::_ID7440();
        _ID28782( "none" );
        return;
    }

    var_5 = undefined;

    if ( _ID20934( "create_loopfx" ) )
        var_5 = common_scripts\utility::createloopeffect( var_1 );

    if ( _ID20934( "create_oneshot" ) )
        var_5 = common_scripts\utility::createoneshoteffect( var_1 );

    _ID12947( var_5 );
}

_ID12947( var_0 )
{
    var_0._ID34830["angles"] = vectortoangles( var_0._ID34830["origin"] + ( 0, 0, 100 ) - var_0._ID34830["origin"] );
    var_0 common_scripts\_createfx::_ID24771();
    common_scripts\_createfx::clear_entity_selection();
    common_scripts\_createfx::select_last_entity();
    common_scripts\_createfx::_ID21583();
    common_scripts\_createfx::_ID34473();
    _ID28782( "none" );
}

entities_are_selected()
{
    return level._ID1624.selected_fx_ents.size > 0;
}

_ID20936()
{
    if ( !level._ID1624.selected_fx_ents.size )
        return;

    var_0 = 0;
    var_1 = 0;
    var_2 = get_last_selected_ent();

    for ( var_3 = 0; var_3 < level._ID1624.options.size; var_3++ )
    {
        var_4 = level._ID1624.options[var_3];

        if ( !isdefined( var_2._ID34830[var_4["name"]] ) )
            continue;

        var_0++;

        if ( var_0 < level._ID11244 )
            continue;

        var_1++;
        var_5 = var_1;

        if ( var_5 == 10 )
            var_5 = 0;

        if ( common_scripts\_createfx::button_is_clicked( var_5 + "" ) )
        {
            _ID24890( var_4, var_1 );
            break;
        }

        if ( var_1 > level._ID11245 )
        {
            var_6 = 1;
            break;
        }
    }
}

_ID24890( var_0, var_1 )
{
    if ( var_0["name"] == "fxid" )
    {
        _ID28782( "change_fxid" );
        draw_effects_list();
        return;
    }

    level.createfx_inputlocked = 1;
    level._ID1624.hudelems[var_1 + 3][0].color = ( 1, 1, 0 );

    if ( isdefined( var_0["input_func"] ) )
        thread [[ var_0["input_func"] ]]( var_1 + 3 );
    else
        common_scripts\_createfx::createfx_centerprint( "To change " + var_0["description"] + " on selected entities, type /fx newvalue" );

    _ID28475( var_0["name"] );
    setdvar( "fx", "nil" );
}

menu_fx_option_set()
{
    if ( getdvar( "fx" ) == "nil" )
        return;

    var_0 = _ID14746();
    var_1 = undefined;

    if ( var_0["type"] == "string" )
        var_1 = getdvar( "fx" );

    if ( var_0["type"] == "int" )
        var_1 = getdvarint( "fx" );

    if ( var_0["type"] == "float" )
        var_1 = getdvarfloat( "fx" );

    _ID3745( var_0, var_1 );
}

_ID3745( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < level._ID1624.selected_fx_ents.size; var_2++ )
    {
        var_3 = level._ID1624.selected_fx_ents[var_2];

        if ( _ID20652( var_0["mask"], var_3._ID34830["type"] ) )
            var_3._ID34830[var_0["name"]] = var_1;
    }

    level._ID19444 = undefined;
    common_scripts\_createfx::_ID34473();
    common_scripts\_createfx::clear_settable_fx();
}

_ID28475( var_0 )
{
    for ( var_1 = 0; var_1 < level._ID1624.options.size; var_1++ )
    {
        if ( level._ID1624.options[var_1]["name"] != var_0 )
            continue;

        level._ID1624._ID28022 = var_1;
        return;
    }
}

_ID14746()
{
    return level._ID1624.options[level._ID1624._ID28022];
}

_ID20652( var_0, var_1 )
{
    return isdefined( level.createfxmasks[var_0][var_1] );
}

addoption( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = [];
    var_6["type"] = var_0;
    var_6["name"] = var_1;
    var_6["description"] = var_2;
    var_6["default"] = var_3;
    var_6["mask"] = var_4;

    if ( isdefined( var_5 ) )
        var_6["input_func"] = var_5;

    level._ID1624.options[level._ID1624.options.size] = var_6;
}

_ID14623( var_0 )
{
    for ( var_1 = 0; var_1 < level._ID1624.options.size; var_1++ )
    {
        if ( level._ID1624.options[var_1]["name"] == var_0 )
            return level._ID1624.options[var_1];
    }
}

_ID18018( var_0 )
{
    for (;;)
    {
        wait 0.05;

        if ( level.player buttonpressed( "escape" ) || level.player buttonpressed( "x" ) )
            break;

        var_1 = 0;

        if ( level.player buttonpressed( "-" ) )
            var_1 = -10;
        else if ( level.player buttonpressed( "=" ) )
            var_1 = 10;

        if ( var_1 != 0 )
        {
            foreach ( var_3 in level._ID1624.selected_fx_ents )
            {
                if ( isdefined( var_3._ID34830["reactive_radius"] ) )
                {
                    var_3._ID34830["reactive_radius"] = var_3._ID34830["reactive_radius"] + var_1;
                    var_3._ID34830["reactive_radius"] = clamp( var_3._ID34830["reactive_radius"], 10, 1000 );
                }
            }
        }
    }

    level._ID19444 = undefined;
    common_scripts\_createfx::_ID34473();
    common_scripts\_createfx::clear_settable_fx();
}

display_fx_add_options( var_0 )
{
    common_scripts\_createfx::_ID7440();
    common_scripts\_createfx::_ID28394( "Name: " + var_0._ID34830["fxid"] );
    common_scripts\_createfx::_ID28394( "Type: " + var_0._ID34830["type"] );
    common_scripts\_createfx::_ID28394( "Origin: " + var_0._ID34830["origin"] );
    common_scripts\_createfx::_ID28394( "Angles: " + var_0._ID34830["angles"] );
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;

    if ( level._ID11244 >= level._ID1624.options.size )
        level._ID11244 = 0;

    for ( var_4 = 0; var_4 < level._ID1624.options.size; var_4++ )
    {
        var_5 = level._ID1624.options[var_4];

        if ( isdefined( var_0._ID34830[var_5["name"]] ) )
            continue;

        if ( !_ID20652( var_5["mask"], var_0._ID34830["type"] ) )
            continue;

        var_1++;

        if ( var_1 < level._ID11244 )
            continue;

        if ( var_2 >= level._ID11245 )
            continue;

        var_2++;
        var_6 = var_2;

        if ( var_6 == 10 )
            var_6 = 0;

        if ( common_scripts\_createfx::button_is_clicked( var_6 + "" ) )
        {
            add_option_to_selected_entities( var_5 );
            _ID20944();
            level._ID19444 = undefined;
            return;
        }

        common_scripts\_createfx::_ID28394( var_6 + ". " + var_5["description"] );
    }

    if ( var_1 > level._ID11245 )
        common_scripts\_createfx::_ID28394( "(->) More >" );

    common_scripts\_createfx::_ID28394( "(x) Exit >" );
}

add_option_to_selected_entities( var_0 )
{
    var_1 = undefined;

    for ( var_2 = 0; var_2 < level._ID1624.selected_fx_ents.size; var_2++ )
    {
        var_3 = level._ID1624.selected_fx_ents[var_2];

        if ( _ID20652( var_0["mask"], var_3._ID34830["type"] ) )
            var_3._ID34830[var_0["name"]] = var_0["default"];
    }
}

_ID20944()
{
    level._ID11244 = 0;
    common_scripts\_createfx::_ID7440();
    _ID28782( "none" );
}

_ID10205( var_0 )
{
    if ( !_ID20934( "none" ) )
        return;

    common_scripts\_createfx::_ID7440();
    common_scripts\_createfx::_ID28394( "Name: " + var_0._ID34830["fxid"] );
    common_scripts\_createfx::_ID28394( "Type: " + var_0._ID34830["type"] );
    common_scripts\_createfx::_ID28394( "Origin: " + var_0._ID34830["origin"] );
    common_scripts\_createfx::_ID28394( "Angles: " + var_0._ID34830["angles"] );

    if ( entities_are_selected() )
    {
        var_1 = 0;
        var_2 = 0;
        var_3 = 0;

        for ( var_4 = 0; var_4 < level._ID1624.options.size; var_4++ )
        {
            var_5 = level._ID1624.options[var_4];

            if ( !isdefined( var_0._ID34830[var_5["name"]] ) )
                continue;

            var_1++;

            if ( var_1 < level._ID11244 )
                continue;

            var_2++;
            common_scripts\_createfx::_ID28394( var_2 + ". " + var_5["description"] + ": " + var_0._ID34830[var_5["name"]] );

            if ( var_2 > level._ID11245 )
            {
                var_3 = 1;
                break;
            }
        }

        if ( var_1 > level._ID11245 )
            common_scripts\_createfx::_ID28394( "(->) More >" );

        common_scripts\_createfx::_ID28394( "(a) Add >" );
        common_scripts\_createfx::_ID28394( "(x) Exit >" );
    }
    else
    {
        var_1 = 0;
        var_3 = 0;

        for ( var_4 = 0; var_4 < level._ID1624.options.size; var_4++ )
        {
            var_5 = level._ID1624.options[var_4];

            if ( !isdefined( var_0._ID34830[var_5["name"]] ) )
                continue;

            var_1++;
            common_scripts\_createfx::_ID28394( var_5["description"] + ": " + var_0._ID34830[var_5["name"]] );

            if ( var_1 > level._ID1624.hudelem_count )
                break;
        }
    }
}

draw_effects_list( var_0 )
{
    common_scripts\_createfx::_ID7440();
    var_1 = 0;
    var_2 = 0;
    var_3 = common_scripts\_createfx::func_get_level_fx();

    if ( !isdefined( var_0 ) )
        var_0 = "Pick an effect";

    common_scripts\_createfx::_ID28394( var_0 + " [" + level._ID11244 + " - " + var_3.size + "]:" );

    for ( var_4 = level._ID11244; var_4 < var_3.size; var_4++ )
    {
        var_1 += 1;
        common_scripts\_createfx::_ID28394( var_1 + ". " + var_3[var_4] );

        if ( var_1 >= level._ID11245 )
        {
            var_2 = 1;
            break;
        }
    }

    if ( var_3.size > level._ID11245 )
    {
        common_scripts\_createfx::_ID28394( "(->) More >" );
        common_scripts\_createfx::_ID28394( "(<-) Previous >" );
    }
}

_ID17539()
{
    var_0 = common_scripts\_createfx::func_get_level_fx();

    if ( level._ID11244 >= var_0.size - level._ID11245 )
        level._ID11244 = 0;
    else
        level._ID11244 = level._ID11244 + level._ID11245;
}

decrement_list_offset()
{
    level._ID11244 = level._ID11244 - level._ID11245;

    if ( level._ID11244 < 0 )
    {
        var_0 = common_scripts\_createfx::func_get_level_fx();
        level._ID11244 = var_0.size - level._ID11245;
    }
}

_ID28009()
{
    var_0 = 0;
    var_1 = undefined;
    var_2 = common_scripts\_createfx::func_get_level_fx();

    for ( var_3 = level._ID11244; var_3 < var_2.size; var_3++ )
    {
        var_0 += 1;
        var_4 = var_0;

        if ( var_4 == 10 )
            var_4 = 0;

        if ( common_scripts\_createfx::button_is_clicked( var_4 + "" ) )
        {
            var_1 = var_2[var_3];
            break;
        }

        if ( var_0 > level._ID11245 )
            break;
    }

    if ( !isdefined( var_1 ) )
        return;

    var_5 = [];

    foreach ( var_3, var_7 in level._ID8435 )
    {
        if ( issubstr( var_7._ID34830["fxid"], var_1 ) )
            var_5[var_5.size] = var_3;
    }

    common_scripts\_createfx::_ID9739();
    common_scripts\_createfx::_ID28013( var_5 );
    level._ID1624._ID28009 = 1;
}

get_last_selected_ent()
{
    return level._ID1624.selected_fx_ents[level._ID1624.selected_fx_ents.size - 1];
}
