// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

createeffect( var_0, var_1 )
{
    var_2 = spawnstruct();

    if ( !isdefined( level._ID8435 ) )
        level._ID8435 = [];

    level._ID8435[level._ID8435.size] = var_2;
    var_2._ID34830 = [];
    var_2._ID34830["type"] = var_0;
    var_2._ID34830["fxid"] = var_1;
    var_2._ID34830["angles"] = ( 0, 0, 0 );
    var_2._ID34830["origin"] = ( 0, 0, 0 );
    var_2._ID10882 = 1;

    if ( isdefined( var_1 ) && isdefined( level.createfxbyfxid ) )
    {
        var_3 = level.createfxbyfxid[var_1];

        if ( !isdefined( var_3 ) )
            var_3 = [];

        var_3[var_3.size] = var_2;
        level.createfxbyfxid[var_1] = var_3;
    }

    return var_2;
}

_ID15131()
{
    return 0.5;
}

_ID15204()
{
    return -15;
}

_ID15012()
{
    return 0;
}

_ID15068()
{
    return 0.75;
}

getintervalsounddelaymaxdefault()
{
    return 2;
}

createloopsound()
{
    var_0 = spawnstruct();

    if ( !isdefined( level._ID8435 ) )
        level._ID8435 = [];

    level._ID8435[level._ID8435.size] = var_0;
    var_0._ID34830 = [];
    var_0._ID34830["type"] = "soundfx";
    var_0._ID34830["fxid"] = "No FX";
    var_0._ID34830["soundalias"] = "nil";
    var_0._ID34830["angles"] = ( 0, 0, 0 );
    var_0._ID34830["origin"] = ( 0, 0, 0 );
    var_0._ID34830["server_culled"] = 1;

    if ( getdvar( "serverCulledSounds" ) != "1" )
        var_0._ID34830["server_culled"] = 0;

    var_0._ID10882 = 1;
    return var_0;
}

createintervalsound()
{
    var_0 = createloopsound();
    var_0._ID34830["type"] = "soundfx_interval";
    var_0._ID34830["delay_min"] = _ID15068();
    var_0._ID34830["delay_max"] = getintervalsounddelaymaxdefault();
    return var_0;
}

createnewexploder()
{
    var_0 = spawnstruct();

    if ( !isdefined( level._ID8435 ) )
        level._ID8435 = [];

    level._ID8435[level._ID8435.size] = var_0;
    var_0._ID34830 = [];
    var_0._ID34830["type"] = "exploder";
    var_0._ID34830["fxid"] = "No FX";
    var_0._ID34830["soundalias"] = "nil";
    var_0._ID34830["loopsound"] = "nil";
    var_0._ID34830["angles"] = ( 0, 0, 0 );
    var_0._ID34830["origin"] = ( 0, 0, 0 );
    var_0._ID34830["exploder"] = 1;
    var_0._ID34830["flag"] = "nil";
    var_0._ID34830["exploder_type"] = "normal";
    var_0._ID10882 = 1;
    return var_0;
}

createexploderex( var_0, var_1 )
{
    var_2 = common_scripts\utility::createexploder( var_0 );
    var_2._ID34830["exploder"] = var_1;
    return var_2;
}

_ID8471()
{
    var_0 = spawnstruct();
    level._ID8435[level._ID8435.size] = var_0;
    var_0._ID34830 = [];
    var_0._ID34830["origin"] = ( 0, 0, 0 );
    var_0._ID34830["reactive_radius"] = 200;
    var_0._ID34830["fxid"] = "No FX";
    var_0._ID34830["type"] = "reactive_fx";
    var_0._ID34830["soundalias"] = "nil";
    return var_0;
}

_ID28476( var_0, var_1 )
{
    if ( isdefined( level.createfx_offset ) )
        var_0 += level.createfx_offset;

    self._ID34830["origin"] = var_0;
    self._ID34830["angles"] = var_1;
}

_ID28390()
{
    self._ID34830["up"] = anglestoup( self._ID34830["angles"] );
    self._ID34830["forward"] = anglestoforward( self._ID34830["angles"] );
}

_ID8423()
{
    precacheshader( "black" );
    level._ID1624 = spawnstruct();
    level._ID1624.grenade = spawn( "script_origin", ( 0, 0, 0 ) );
    level._ID1624.grenade._ID13765 = loadfx( "fx/explosions/grenadeexp_default" );
    level._ID1624.grenade._ID30465 = "grenade_explode_default";
    level._ID1624.grenade.radius = 256;

    if ( level._ID21731 )
        _ID15978( "painter_mp" );
    else
        _ID15978( "painter" );

    common_scripts\utility::_ID13189( "createfx_saving" );
    common_scripts\utility::_ID13189( "createfx_started" );

    if ( !isdefined( level._ID8418 ) )
        level._ID8418 = [];

    level.createfx_loopcounter = 0;
    level notify( "createfx_common_done" );
}

_ID17762()
{
    level._ID1624._ID28026 = 0;
    level._ID1624._ID28024 = 0;
    level._ID1624._ID28025 = 0;
    level._ID1624._ID28027 = 0;
    level._ID1624._ID28028 = 0;
    level._ID1624._ID28029 = 0;
    level._ID1624._ID28020 = [];
    level._ID1624.selected_fx_ents = [];
    level._ID1624._ID25492 = 1;
    level._ID1624._ID30291 = 0;
    level._ID1624.axismode = 0;
    level._ID1624._ID28009 = 0;
    level._ID1624._ID24345 = getdvarfloat( "g_speed" );
    _ID28540();
}

_ID17771()
{
    level._ID1624._ID20183 = [];
    level._ID1624._ID20183["escape"] = 1;
    level._ID1624._ID20183["BUTTON_LSHLDR"] = 1;
    level._ID1624._ID20183["BUTTON_RSHLDR"] = 1;
    level._ID1624._ID20183["mouse1"] = 1;
    level._ID1624._ID20183["ctrl"] = 1;
}

init_colors()
{
    var_0 = [];
    var_0["loopfx"]["selected"] = ( 1, 1, 0.2 );
    var_0["loopfx"]["highlighted"] = ( 0.4, 0.95, 1 );
    var_0["loopfx"]["default"] = ( 0.3, 0.8, 1 );
    var_0["oneshotfx"]["selected"] = ( 1, 1, 0.2 );
    var_0["oneshotfx"]["highlighted"] = ( 0.4, 0.95, 1 );
    var_0["oneshotfx"]["default"] = ( 0.3, 0.8, 1 );
    var_0["exploder"]["selected"] = ( 1, 1, 0.2 );
    var_0["exploder"]["highlighted"] = ( 1, 0.2, 0.2 );
    var_0["exploder"]["default"] = ( 1, 0.1, 0.1 );
    var_0["rainfx"]["selected"] = ( 1, 1, 0.2 );
    var_0["rainfx"]["highlighted"] = ( 0.95, 0.4, 0.95 );
    var_0["rainfx"]["default"] = ( 0.78, 0, 0.73 );
    var_0["soundfx"]["selected"] = ( 1, 1, 0.2 );
    var_0["soundfx"]["highlighted"] = ( 0.5, 1, 0.75 );
    var_0["soundfx"]["default"] = ( 0.2, 0.9, 0.2 );
    var_0["soundfx_interval"]["selected"] = ( 1, 1, 0.2 );
    var_0["soundfx_interval"]["highlighted"] = ( 0.5, 1, 0.75 );
    var_0["soundfx_interval"]["default"] = ( 0.2, 0.9, 0.2 );
    var_0["reactive_fx"]["selected"] = ( 1, 1, 0.2 );
    var_0["reactive_fx"]["highlighted"] = ( 0.5, 1, 0.75 );
    var_0["reactive_fx"]["default"] = ( 0.2, 0.9, 0.2 );
    level._ID1624.colors = var_0;
}

createfxlogic()
{
    waittillframeend;
    wait 0.05;

    if ( !isdefined( level._ID1644 ) )
        level._ID1644 = [];

    if ( getdvar( "createfx_map" ) == "" )
    {

    }
    else if ( getdvar( "createfx_map" ) == common_scripts\utility::_ID14794() )
        [[ level.func_position_player ]]();

    _ID17714();
    common_scripts\_createfxmenu::_ID17773();
    _ID17757();
    _ID17856();
    _ID17714();
    _ID17762();
    _ID17771();
    init_colors();

    if ( getdvar( "createfx_use_f4" ) == "" )
    {

    }

    if ( getdvar( "createfx_no_autosave" ) == "" )
    {

    }

    level.createfx_draw_enabled = 1;
    level._ID19444 = undefined;
    level.buttonisheld = [];
    var_0 = ( 0, 0, 0 );
    common_scripts\utility::flag_set( "createfx_started" );

    if ( !level._ID21731 )
        var_0 = level.player.origin;

    var_1 = undefined;
    level.fx_rotating = 0;
    common_scripts\_createfxmenu::_ID28782( "none" );
    level.createfx_selecting = 0;
    var_2 = newhudelem();
    var_2.x = -120;
    var_2.y = 200;
    var_2.foreground = 0;
    var_2 setshader( "black", 250, 160 );
    var_2.alpha = 0;
    level.createfx_inputlocked = 0;

    foreach ( var_4 in level._ID8435 )
        var_4 _ID24771();

    thread _ID10838();
    var_6 = undefined;
    thread _ID8420();

    for (;;)
    {
        var_7 = 0;
        var_8 = anglestoright( level.player getplayerangles() );
        var_9 = anglestoforward( level.player getplayerangles() );
        var_10 = anglestoup( level.player getplayerangles() );
        var_11 = 0.85;
        var_12 = var_9 * 750;
        level.createfxcursor = bullettrace( level.player geteye(), level.player geteye() + var_12, 0, undefined );
        var_13 = undefined;
        level.buttonclick = [];
        level._ID6348 = [];
        _ID25022();
        var_14 = button_is_held( "ctrl", "BUTTON_LSHLDR" );
        var_15 = button_is_clicked( "mouse1", "BUTTON_A" );
        var_16 = button_is_held( "mouse1", "BUTTON_A" );
        common_scripts\_createfxmenu::create_fx_menu();
        var_17 = "F5";

        if ( getdvarint( "createfx_use_f4" ) )
            var_17 = "F4";

        if ( button_is_clicked( var_17 ) )
        {

        }

        if ( getdvarint( "scr_createfx_dump" ) )
            _ID14205();

        if ( button_is_clicked( "F2" ) )
            _ID33099();

        if ( button_is_clicked( "ins" ) )
            _ID18020();

        if ( button_is_clicked( "del" ) )
            _ID9587();

        if ( button_is_clicked( "escape" ) )
            clear_settable_fx();

        if ( button_is_clicked( "space" ) )
            set_off_exploders();

        if ( button_is_clicked( "u" ) )
            _ID28010();

        modify_player_speed();

        if ( !var_14 && button_is_clicked( "g" ) )
        {
            _ID28006( "exploder" );
            _ID28006( "flag" );
        }

        if ( button_is_held( "h", "F1" ) )
        {
            _ID29926();
            wait 0.05;
            continue;
        }

        if ( button_is_clicked( "BUTTON_LSTICK" ) )
            copy_ents();

        if ( button_is_clicked( "BUTTON_RSTICK" ) )
            _ID23321();

        if ( var_14 )
        {
            if ( button_is_clicked( "c" ) )
                copy_ents();

            if ( button_is_clicked( "v" ) )
                _ID23321();

            if ( button_is_clicked( "g" ) )
                spawn_grenade();
        }

        if ( isdefined( level._ID1624._ID28022 ) )
            common_scripts\_createfxmenu::menu_fx_option_set();

        for ( var_18 = 0; var_18 < level._ID8435.size; var_18++ )
        {
            var_4 = level._ID8435[var_18];
            var_19 = vectornormalize( var_4._ID34830["origin"] - level.player.origin + ( 0, 0, 55 ) );
            var_20 = vectordot( var_9, var_19 );

            if ( var_20 < var_11 )
                continue;

            var_11 = var_20;
            var_13 = var_4;
        }

        level._ID13851 = var_13;

        if ( isdefined( var_13 ) )
        {
            if ( isdefined( var_1 ) )
            {
                if ( var_1 != var_13 )
                {
                    if ( !_ID12114( var_1 ) )
                        var_1 thread entity_highlight_disable();

                    if ( !_ID12114( var_13 ) )
                        var_13 thread entity_highlight_enable();
                }
            }
            else if ( !_ID12114( var_13 ) )
                var_13 thread entity_highlight_enable();
        }

        _ID20600( var_13, var_15, var_16, var_14, var_8 );
        var_7 = _ID16195( var_7 );
        wait 0.05;

        if ( var_7 )
            _ID34473();

        if ( !level._ID21731 )
            var_0 = [[ level.func_position_player_get ]]( var_0 );

        var_1 = var_13;

        if ( _ID19487( var_6 ) )
        {
            level._ID11244 = 0;
            clear_settable_fx();
            common_scripts\_createfxmenu::_ID28782( "none" );
        }

        if ( level._ID1624.selected_fx_ents.size )
        {
            var_6 = level._ID1624.selected_fx_ents[level._ID1624.selected_fx_ents.size - 1];
            continue;
        }

        var_6 = undefined;
    }
}

modify_player_speed()
{
    var_0 = 0;
    var_1 = button_is_held( "ctrl" );

    if ( button_is_held( "." ) )
    {
        if ( var_1 )
        {
            if ( level._ID1624._ID24345 < 190 )
                level._ID1624._ID24345 = 190;
            else
                level._ID1624._ID24345 = level._ID1624._ID24345 + 10;
        }
        else
            level._ID1624._ID24345 = level._ID1624._ID24345 + 5;

        var_0 = 1;
    }
    else if ( button_is_held( "," ) )
    {
        if ( var_1 )
        {
            if ( level._ID1624._ID24345 > 190 )
                level._ID1624._ID24345 = 190;
            else
                level._ID1624._ID24345 = level._ID1624._ID24345 - 10;
        }
        else
            level._ID1624._ID24345 = level._ID1624._ID24345 - 5;

        var_0 = 1;
    }

    if ( var_0 )
    {
        level._ID1624._ID24345 = clamp( level._ID1624._ID24345, 5, 500 );
        [[ level._ID13745 ]]();
        _ID28540();
    }
}

_ID28540()
{
    if ( !isdefined( level._ID1624._ID24348 ) )
    {
        var_0 = newhudelem();
        var_0.alignx = "right";
        var_0.foreground = 1;
        var_0.fontscale = 1.2;
        var_0.alpha = 0.2;
        var_0.x = 320;
        var_0.y = 420;
        var_1 = newhudelem();
        var_1.alignx = "left";
        var_1.foreground = 1;
        var_1.fontscale = 1.2;
        var_1.alpha = 0.2;
        var_1.x = 320;
        var_1.y = 420;
        var_0._ID17241 = var_1;
        level._ID1624._ID24348 = var_0;
    }

    level._ID1624._ID24348._ID17241 setvalue( level._ID1624._ID24345 );
}

_ID33099()
{
    level.createfx_draw_enabled = !level.createfx_draw_enabled;
}

_ID18020()
{
    common_scripts\_createfxmenu::_ID28782( "creation" );
    level._ID11244 = 0;
    _ID7440();
    _ID28394( "Pick effect type to create:" );
    _ID28394( "1. One Shot FX" );
    _ID28394( "2. Looping sound" );
    _ID28394( "3. Exploder" );
    _ID28394( "4. One Shot Sound" );
    _ID28394( "5. Reactive Sound" );
    _ID28394( "(c) Cancel >" );
    _ID28394( "(x) Exit >" );
}

_ID20600( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !level.createfx_draw_enabled )
        return;

    if ( level._ID1624._ID28009 )
    {
        level._ID1624._ID28009 = 0;
        var_0 = undefined;
    }
    else if ( select_by_substring() )
        var_0 = undefined;

    for ( var_5 = 0; var_5 < level._ID8435.size; var_5++ )
    {
        var_6 = level._ID8435[var_5];

        if ( !var_6._ID10882 )
            continue;

        var_7 = getdvarfloat( "createfx_scaleid" );

        if ( isdefined( var_0 ) && var_6 == var_0 )
        {
            if ( !common_scripts\_createfxmenu::entities_are_selected() )
                common_scripts\_createfxmenu::_ID10205( var_6 );

            if ( var_1 )
            {
                var_8 = index_is_selected( var_5 );
                level.createfx_selecting = !var_8;

                if ( !var_3 )
                {
                    var_9 = level._ID1624.selected_fx_ents.size;
                    clear_entity_selection();

                    if ( var_8 && var_9 == 1 )
                        _ID28012( var_5, var_6 );
                }

                _ID33100( var_5, var_6 );
            }
            else if ( var_2 )
            {
                if ( var_3 )
                {
                    if ( level.createfx_selecting )
                        _ID28012( var_5, var_6 );

                    if ( !level.createfx_selecting )
                        deselect_entity( var_5, var_6 );
                }
            }

            var_10 = "highlighted";
        }
        else
            var_10 = "default";

        if ( index_is_selected( var_5 ) )
            var_10 = "selected";

        var_6 createfx_print3d( var_10, var_7, var_4 );
    }
}

createfx_print3d( var_0, var_1, var_2 )
{
    if ( self._ID32873 > 0 )
    {
        var_3 = _ID14698();
        var_4 = var_2 * ( var_3.size * -2.93 );
        var_5 = level._ID1624.colors[self._ID34830["type"]][var_0];

        if ( isdefined( self._ID18476 ) )
            var_5 = ( 1, 0.5, 0 );

        if ( isdefined( self._ID34830["reactive_radius"] ) )
            return;
    }
}

_ID14698()
{
    switch ( self._ID34830["type"] )
    {
        case "reactive_fx":
            return "reactive: " + self._ID34830["soundalias"];
        default:
            return self._ID34830["fxid"];
    }
}

_ID28010()
{
    level._ID11244 = 0;
    _ID7440();
    common_scripts\_createfxmenu::_ID28782( "select_by_name" );
    common_scripts\_createfxmenu::draw_effects_list();
}

_ID16195( var_0 )
{
    if ( level._ID1624.selected_fx_ents.size > 0 )
    {
        var_0 = _ID28019( var_0 );

        if ( !current_mode_hud( "selected_ents" ) )
        {
            _ID21953( "selected_ents" );
            _ID28589( "Selected Ent Mode" );
            _ID28589( "Mode:", "move" );
            _ID28589( "Rate:", level._ID1624._ID25492 );
            _ID28589( "Snap2Normal:", level._ID1624._ID30291 );
        }

        if ( level._ID1624.axismode && level._ID1624.selected_fx_ents.size > 0 )
        {
            _ID28589( "Mode:", "rotate" );
            thread [[ level._ID13748 ]]();

            if ( button_is_clicked( "enter", "p" ) )
                _ID26079();

            if ( button_is_clicked( "v" ) )
                _ID7993();

            for ( var_1 = 0; var_1 < level._ID1624.selected_fx_ents.size; var_1++ )
                level._ID1624.selected_fx_ents[var_1] _ID10826();

            if ( level._ID28027 != 0 || level._ID28029 != 0 || level._ID28028 != 0 )
                var_0 = 1;
        }
        else
        {
            _ID28589( "Mode:", "move" );
            var_2 = get_selected_move_vector();

            for ( var_1 = 0; var_1 < level._ID1624.selected_fx_ents.size; var_1++ )
            {
                var_3 = level._ID1624.selected_fx_ents[var_1];

                if ( isdefined( var_3.model ) )
                    continue;

                var_3 _ID10836();
                var_3._ID34830["origin"] = var_3._ID34830["origin"] + var_2;
            }

            if ( distance( ( 0, 0, 0 ), var_2 ) > 0 )
                var_0 = 1;
        }
    }
    else
        clear_tool_hud();

    return var_0;
}

_ID28019( var_0 )
{
    if ( button_is_clicked( "shift", "BUTTON_X" ) )
        _ID33098();

    _ID21283();

    if ( button_is_clicked( "s" ) )
        _ID33103();

    if ( button_is_clicked( "end", "l" ) )
    {
        drop_selection_to_ground();
        var_0 = 1;
    }

    if ( button_is_clicked( "tab", "BUTTON_RSHLDR" ) )
    {
        _ID21583();
        var_0 = 1;
    }

    return var_0;
}

_ID21283()
{
    var_0 = button_is_held( "shift" );
    var_1 = button_is_held( "ctrl" );

    if ( button_is_clicked( "=" ) )
    {
        if ( var_0 )
            level._ID1624._ID25492 = level._ID1624._ID25492 + 1;
        else if ( var_1 )
        {
            if ( level._ID1624._ID25492 < 1 )
                level._ID1624._ID25492 = 1;
            else
                level._ID1624._ID25492 = level._ID1624._ID25492 + 10;
        }
        else
            level._ID1624._ID25492 = level._ID1624._ID25492 + 0.1;
    }
    else if ( button_is_clicked( "-" ) )
    {
        if ( var_0 )
            level._ID1624._ID25492 = level._ID1624._ID25492 - 1;
        else if ( var_1 )
        {
            if ( level._ID1624._ID25492 > 1 )
                level._ID1624._ID25492 = 1;
            else
                level._ID1624._ID25492 = 0.1;
        }
        else
            level._ID1624._ID25492 = level._ID1624._ID25492 - 0.1;
    }

    level._ID1624._ID25492 = clamp( level._ID1624._ID25492, 0.1, 100 );
    _ID28589( "Rate:", level._ID1624._ID25492 );
}

_ID33098()
{
    level._ID1624.axismode = !level._ID1624.axismode;
}

_ID33103()
{
    level._ID1624._ID30291 = !level._ID1624._ID30291;
    _ID28589( "Snap2Normal:", level._ID1624._ID30291 );
}

_ID7993()
{
    level notify( "new_ent_selection" );

    for ( var_0 = 0; var_0 < level._ID1624.selected_fx_ents.size; var_0++ )
    {
        var_1 = level._ID1624.selected_fx_ents[var_0];
        var_1._ID34830["angles"] = level._ID1624.selected_fx_ents[level._ID1624.selected_fx_ents.size - 1]._ID34830["angles"];
        var_1 _ID28390();
    }

    _ID34473();
}

_ID26079()
{
    level notify( "new_ent_selection" );

    for ( var_0 = 0; var_0 < level._ID1624.selected_fx_ents.size; var_0++ )
    {
        var_1 = level._ID1624.selected_fx_ents[var_0];
        var_1._ID34830["angles"] = ( 0, 0, 0 );
        var_1 _ID28390();
    }

    _ID34473();
}

_ID19487( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        if ( !common_scripts\_createfxmenu::entities_are_selected() )
            return 1;
    }
    else
        return common_scripts\_createfxmenu::entities_are_selected();

    return var_0 != level._ID1624.selected_fx_ents[level._ID1624.selected_fx_ents.size - 1];
}

drop_selection_to_ground()
{
    for ( var_0 = 0; var_0 < level._ID1624.selected_fx_ents.size; var_0++ )
    {
        var_1 = level._ID1624.selected_fx_ents[var_0];
        var_2 = bullettrace( var_1._ID34830["origin"], var_1._ID34830["origin"] + ( 0, 0, -2048 ), 0, undefined );
        var_1._ID34830["origin"] = var_2["position"];
    }
}

set_off_exploders()
{
    level notify( "createfx_exploder_reset" );
    var_0 = [];

    for ( var_1 = 0; var_1 < level._ID1624.selected_fx_ents.size; var_1++ )
    {
        var_2 = level._ID1624.selected_fx_ents[var_1];

        if ( isdefined( var_2._ID34830["exploder"] ) )
            var_0[var_2._ID34830["exploder"]] = 1;
    }

    var_3 = getarraykeys( var_0 );

    for ( var_1 = 0; var_1 < var_3.size; var_1++ )
        common_scripts\utility::exploder( var_3[var_1] );
}

_ID10838()
{
    var_0 = 0;

    if ( getdvarint( "createfx_drawdist" ) == 0 )
    {

    }

    for (;;)
    {
        var_1 = getdvarint( "createfx_drawdist" );
        var_1 *= var_1;

        for ( var_2 = 0; var_2 < level._ID8435.size; var_2++ )
        {
            var_3 = level._ID8435[var_2];
            var_3._ID10882 = distancesquared( level.player.origin, var_3._ID34830["origin"] ) <= var_1;
            var_0++;

            if ( var_0 > 100 )
            {
                var_0 = 0;
                wait 0.05;
            }
        }

        if ( level._ID8435.size == 0 )
            wait 0.05;
    }
}

_ID8420()
{
    setdvarifuninitialized( "createfx_autosave_time", "300" );

    for (;;)
    {
        wait(getdvarint( "createfx_autosave_time" ));
        common_scripts\utility::_ID13216( "createfx_saving" );

        if ( getdvarint( "createfx_no_autosave" ) )
            continue;

        _ID14205( 1 );
    }
}

_ID26732( var_0, var_1 )
{
    level endon( "new_ent_selection" );
    var_2 = 0.1;

    for ( var_3 = 0; var_3 < var_2 * 20; var_3++ )
    {
        if ( level._ID28027 != 0 )
            var_0 addpitch( level._ID28027 );
        else if ( level._ID28029 != 0 )
            var_0 addyaw( level._ID28029 );
        else
            var_0 addroll( level._ID28028 );

        wait 0.05;
        var_0 _ID10826();

        for ( var_4 = 0; var_4 < level._ID1624.selected_fx_ents.size; var_4++ )
        {
            var_5 = level._ID1624.selected_fx_ents[var_4];

            if ( isdefined( var_5.model ) )
                continue;

            var_5._ID34830["origin"] = var_1[var_4].origin;
            var_5._ID34830["angles"] = var_1[var_4].angles;
        }
    }
}

_ID9587()
{
    if ( level.createfx_inputlocked )
    {
        _ID25939();
        return;
    }

    _ID9590();
}

_ID25939()
{
    if ( !isdefined( level._ID1624._ID28022 ) )
        return;

    var_0 = level._ID1624.options[level._ID1624._ID28022]["name"];

    for ( var_1 = 0; var_1 < level._ID8435.size; var_1++ )
    {
        var_2 = level._ID8435[var_1];

        if ( !_ID12114( var_2 ) )
            continue;

        var_2 _ID25926( var_0 );
    }

    _ID34473();
    clear_settable_fx();
}

_ID25926( var_0 )
{
    self._ID34830[var_0] = undefined;
}

_ID9590()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < level._ID8435.size; var_1++ )
    {
        var_2 = level._ID8435[var_1];

        if ( _ID12114( var_2 ) )
        {
            if ( isdefined( var_2._ID20339 ) )
                var_2._ID20339 delete();

            var_2 notify( "stop_loop" );
            continue;
        }

        var_0[var_0.size] = var_2;
    }

    level._ID8435 = var_0;
    level._ID1624._ID28020 = [];
    level._ID1624.selected_fx_ents = [];
    _ID7440();
}

_ID21583()
{
    var_0 = level.createfxcursor["position"];

    if ( level._ID1624.selected_fx_ents.size <= 0 )
        return;

    var_1 = _ID14333( level._ID1624.selected_fx_ents );
    var_2 = var_1 - var_0;

    for ( var_3 = 0; var_3 < level._ID1624.selected_fx_ents.size; var_3++ )
    {
        var_4 = level._ID1624.selected_fx_ents[var_3];

        if ( isdefined( var_4.model ) )
            continue;

        var_4._ID34830["origin"] = var_4._ID34830["origin"] - var_2;

        if ( level._ID1624._ID30291 )
        {
            if ( isdefined( level.createfxcursor["normal"] ) )
                var_4._ID34830["angles"] = vectortoangles( level.createfxcursor["normal"] );
        }
    }
}

select_last_entity()
{
    _ID28012( level._ID8435.size - 1, level._ID8435[level._ID8435.size - 1] );
}

_ID28006( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level._ID1624.selected_fx_ents )
    {
        if ( !isdefined( var_3._ID34830[var_0] ) )
            continue;

        var_4 = var_3._ID34830[var_0];
        var_1[var_4] = 1;
    }

    foreach ( var_4, var_7 in var_1 )
    {
        foreach ( var_9, var_3 in level._ID8435 )
        {
            if ( index_is_selected( var_9 ) )
                continue;

            if ( !isdefined( var_3._ID34830[var_0] ) )
                continue;

            if ( var_3._ID34830[var_0] != var_4 )
                continue;

            _ID28012( var_9, var_3 );
        }
    }

    _ID34473();
}

copy_ents()
{
    if ( level._ID1624.selected_fx_ents.size <= 0 )
        return;

    var_0 = [];

    for ( var_1 = 0; var_1 < level._ID1624.selected_fx_ents.size; var_1++ )
    {
        var_2 = level._ID1624.selected_fx_ents[var_1];
        var_3 = spawnstruct();
        var_3._ID34830 = var_2._ID34830;
        var_3 _ID24771();
        var_0[var_0.size] = var_3;
    }

    level._ID31874 = var_0;
}

_ID24771()
{
    self._ID32873 = 0;
    self._ID10882 = 1;
}

_ID23321()
{
    if ( !isdefined( level._ID31874 ) )
        return;

    clear_entity_selection();

    for ( var_0 = 0; var_0 < level._ID31874.size; var_0++ )
        add_and_select_entity( level._ID31874[var_0] );

    _ID21583();
    _ID34473();
    level._ID31874 = [];
    copy_ents();
}

add_and_select_entity( var_0 )
{
    level._ID8435[level._ID8435.size] = var_0;
    select_last_entity();
}

_ID14333( var_0 )
{
    var_1 = ( 0, 0, 0 );

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
        var_1 = ( var_1[0] + var_0[var_2]._ID34830["origin"][0], var_1[1] + var_0[var_2]._ID34830["origin"][1], var_1[2] + var_0[var_2]._ID34830["origin"][2] );

    return ( var_1[0] / var_0.size, var_1[1] / var_0.size, var_1[2] / var_0.size );
}

_ID12097()
{
    self endon( "death" );

    for (;;)
    {
        _ID10826();
        wait 0.05;
    }
}

rotation_is_occuring()
{
    if ( level._ID28028 != 0 )
        return 1;

    if ( level._ID28027 != 0 )
        return 1;

    return level._ID28029 != 0;
}

_ID24987( var_0, var_1, var_2 )
{
    for ( var_3 = 0; var_3 < level._ID1624.options.size; var_3++ )
    {
        var_4 = level._ID1624.options[var_3];
        var_5 = var_4["name"];

        if ( !isdefined( var_0._ID34830[var_5] ) )
            continue;

        if ( !common_scripts\_createfxmenu::_ID20652( var_4["mask"], var_0._ID34830["type"] ) )
            continue;

        if ( !level._ID21731 )
        {
            if ( common_scripts\_createfxmenu::_ID20652( "fx", var_0._ID34830["type"] ) && var_5 == "fxid" )
                continue;

            if ( var_0._ID34830["type"] == "exploder" && var_5 == "exploder" )
                continue;

            var_6 = var_0._ID34830["type"] + "/" + var_5;

            if ( isdefined( level._ID1624.defaults[var_6] ) && level._ID1624.defaults[var_6] == var_0._ID34830[var_5] )
                continue;
        }

        if ( var_4["type"] == "string" )
        {
            var_7 = var_0._ID34830[var_5] + "";

            if ( var_7 == "nil" )
                continue;

            cfxprintln( var_1 + "ent.v[ \"" + var_5 + "\" ] = \"" + var_0._ID34830[var_5] + "\";" );
            continue;
        }

        cfxprintln( var_1 + "ent.v[ \"" + var_5 + "\" ] = " + var_0._ID34830[var_5] + ";" );
    }
}

entity_highlight_disable()
{
    self notify( "highlight change" );
    self endon( "highlight change" );

    for (;;)
    {
        self._ID32873 = self._ID32873 * 0.85;
        self._ID32873 = self._ID32873 - 0.05;

        if ( self._ID32873 < 0 )
            break;

        wait 0.05;
    }

    self._ID32873 = 0;
}

entity_highlight_enable()
{
    self notify( "highlight change" );
    self endon( "highlight change" );

    for (;;)
    {
        self._ID32873 = self._ID32873 + 0.05;
        self._ID32873 = self._ID32873 * 1.25;

        if ( self._ID32873 > 1 )
            break;

        wait 0.05;
    }

    self._ID32873 = 1;
}

clear_settable_fx()
{
    level.createfx_inputlocked = 0;
    level._ID1624._ID28022 = undefined;
    _ID26085();
}

_ID26085()
{
    for ( var_0 = 0; var_0 < level._ID1624.hudelem_count; var_0++ )
        level._ID1624.hudelems[var_0][0].color = ( 1, 1, 1 );
}

_ID33100( var_0, var_1 )
{
    if ( isdefined( level._ID1624._ID28020[var_0] ) )
        deselect_entity( var_0, var_1 );
    else
        _ID28012( var_0, var_1 );
}

_ID28012( var_0, var_1 )
{
    if ( isdefined( level._ID1624._ID28020[var_0] ) )
        return;

    clear_settable_fx();
    level notify( "new_ent_selection" );
    var_1 thread entity_highlight_enable();
    level._ID1624._ID28020[var_0] = 1;
    level._ID1624.selected_fx_ents[level._ID1624.selected_fx_ents.size] = var_1;
}

ent_is_highlighted( var_0 )
{
    if ( !isdefined( level._ID13851 ) )
        return 0;

    return var_0 == level._ID13851;
}

deselect_entity( var_0, var_1 )
{
    if ( !isdefined( level._ID1624._ID28020[var_0] ) )
        return;

    clear_settable_fx();
    level notify( "new_ent_selection" );
    level._ID1624._ID28020[var_0] = undefined;

    if ( !ent_is_highlighted( var_1 ) )
        var_1 thread entity_highlight_disable();

    var_2 = [];

    for ( var_3 = 0; var_3 < level._ID1624.selected_fx_ents.size; var_3++ )
    {
        if ( level._ID1624.selected_fx_ents[var_3] != var_1 )
            var_2[var_2.size] = level._ID1624.selected_fx_ents[var_3];
    }

    level._ID1624.selected_fx_ents = var_2;
}

index_is_selected( var_0 )
{
    return isdefined( level._ID1624._ID28020[var_0] );
}

_ID12114( var_0 )
{
    for ( var_1 = 0; var_1 < level._ID1624.selected_fx_ents.size; var_1++ )
    {
        if ( level._ID1624.selected_fx_ents[var_1] == var_0 )
            return 1;
    }

    return 0;
}

clear_entity_selection()
{
    for ( var_0 = 0; var_0 < level._ID1624.selected_fx_ents.size; var_0++ )
    {
        if ( !ent_is_highlighted( level._ID1624.selected_fx_ents[var_0] ) )
            level._ID1624.selected_fx_ents[var_0] thread entity_highlight_disable();
    }

    level._ID1624._ID28020 = [];
    level._ID1624.selected_fx_ents = [];
}

_ID10826()
{

}

_ID10836()
{

}

createfx_centerprint( var_0 )
{
    thread createfx_centerprint_thread( var_0 );
}

createfx_centerprint_thread( var_0 )
{
    level notify( "new_createfx_centerprint" );
    level endon( "new_createfx_centerprint" );

    for ( var_1 = 0; var_1 < 5; var_1++ )
    {

    }

    wait 4.5;

    for ( var_1 = 0; var_1 < 5; var_1++ )
    {

    }
}

get_selected_move_vector()
{
    var_0 = level.player getplayerangles()[1];
    var_1 = ( 0, var_0, 0 );
    var_2 = anglestoright( var_1 );
    var_3 = anglestoforward( var_1 );
    var_4 = anglestoup( var_1 );
    var_5 = 0;
    var_6 = level._ID1624._ID25492;

    if ( _ID6356( "kp_uparrow", "DPAD_UP" ) )
    {
        if ( level._ID28024 < 0 )
            level._ID28024 = 0;

        level._ID28024 = level._ID28024 + var_6;
    }
    else if ( _ID6356( "kp_downarrow", "DPAD_DOWN" ) )
    {
        if ( level._ID28024 > 0 )
            level._ID28024 = 0;

        level._ID28024 = level._ID28024 - var_6;
    }
    else
        level._ID28024 = 0;

    if ( _ID6356( "kp_rightarrow", "DPAD_RIGHT" ) )
    {
        if ( level._ID28025 < 0 )
            level._ID28025 = 0;

        level._ID28025 = level._ID28025 + var_6;
    }
    else if ( _ID6356( "kp_leftarrow", "DPAD_LEFT" ) )
    {
        if ( level._ID28025 > 0 )
            level._ID28025 = 0;

        level._ID28025 = level._ID28025 - var_6;
    }
    else
        level._ID28025 = 0;

    if ( _ID6356( "BUTTON_Y" ) )
    {
        if ( level._ID28026 < 0 )
            level._ID28026 = 0;

        level._ID28026 = level._ID28026 + var_6;
    }
    else if ( _ID6356( "BUTTON_B" ) )
    {
        if ( level._ID28026 > 0 )
            level._ID28026 = 0;

        level._ID28026 = level._ID28026 - var_6;
    }
    else
        level._ID28026 = 0;

    var_7 = ( 0, 0, 0 );
    var_7 += var_3 * level._ID28024;
    var_7 += var_2 * level._ID28025;
    var_7 += var_4 * level._ID28026;
    return var_7;
}

_ID28208()
{
    var_0 = level._ID1624._ID25492;

    if ( _ID6356( "kp_uparrow", "DPAD_UP" ) )
    {
        if ( level._ID28027 < 0 )
            level._ID28027 = 0;

        level._ID28027 = level._ID28027 + var_0;
    }
    else if ( _ID6356( "kp_downarrow", "DPAD_DOWN" ) )
    {
        if ( level._ID28027 > 0 )
            level._ID28027 = 0;

        level._ID28027 = level._ID28027 - var_0;
    }
    else
        level._ID28027 = 0;

    if ( _ID6356( "kp_leftarrow", "DPAD_LEFT" ) )
    {
        if ( level._ID28029 < 0 )
            level._ID28029 = 0;

        level._ID28029 = level._ID28029 + var_0;
    }
    else if ( _ID6356( "kp_rightarrow", "DPAD_RIGHT" ) )
    {
        if ( level._ID28029 > 0 )
            level._ID28029 = 0;

        level._ID28029 = level._ID28029 - var_0;
    }
    else
        level._ID28029 = 0;

    if ( _ID6356( "BUTTON_Y" ) )
    {
        if ( level._ID28028 < 0 )
            level._ID28028 = 0;

        level._ID28028 = level._ID28028 + var_0;
    }
    else if ( _ID6356( "BUTTON_B" ) )
    {
        if ( level._ID28028 > 0 )
            level._ID28028 = 0;

        level._ID28028 = level._ID28028 - var_0;
    }
    else
        level._ID28028 = 0;
}

_ID34473()
{
    var_0 = 0;

    foreach ( var_2 in level._ID1624.selected_fx_ents )
    {
        if ( var_2._ID34830["type"] == "reactive_fx" )
            var_0 = 1;

        var_2 [[ level._ID13749 ]]();
    }

    if ( var_0 )
        refresh_reactive_fx_ents();
}

_ID15978( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "painter_mp";

    precachemenu( var_0 );
    wait 0.05;

    if ( var_0 == "painter_mp" )
        return;

    level.player openpopupmenu( var_0 );
    level.player closepopupmenu( var_0 );
}

_ID31786()
{
    if ( isdefined( self._ID20339 ) )
        self._ID20339 delete();

    stop_loopsound();
}

stop_loopsound()
{
    self notify( "stop_loop" );
}

func_get_level_fx()
{
    if ( !isdefined( level._effect_keys ) )
        var_0 = getarraykeys( level._ID1644 );
    else
    {
        var_0 = getarraykeys( level._ID1644 );

        if ( var_0.size == level._effect_keys.size )
            return level._effect_keys;
    }

    var_0 = common_scripts\utility::alphabetize( var_0 );
    level._effect_keys = var_0;
    return var_0;
}

_ID26177()
{
    _ID31786();
    _ID28390();

    switch ( self._ID34830["type"] )
    {
        case "oneshotfx":
            common_scripts\_fx::_ID8379();
            break;
        case "soundfx":
            common_scripts\_fx::create_loopsound();
            break;
        case "soundfx_interval":
            common_scripts\_fx::_ID8340();
            break;
    }
}

refresh_reactive_fx_ents()
{
    level._fx.reactive_fx_ents = undefined;

    foreach ( var_1 in level._ID8435 )
    {
        if ( var_1._ID34830["type"] == "reactive_fx" )
        {
            var_1 _ID28390();
            var_1 common_scripts\_fx::add_reactive_fx();
        }
    }
}

_ID25029()
{
    if ( level.fx_rotating )
        return;

    _ID28208();

    if ( !rotation_is_occuring() )
        return;

    level.fx_rotating = 1;

    if ( level._ID1624.selected_fx_ents.size > 1 )
    {
        var_0 = _ID14333( level._ID1624.selected_fx_ents );
        var_1 = spawn( "script_origin", var_0 );
        var_1._ID34830["angles"] = level._ID1624.selected_fx_ents[0]._ID34830["angles"];
        var_1._ID34830["origin"] = var_0;
        var_2 = [];

        for ( var_3 = 0; var_3 < level._ID1624.selected_fx_ents.size; var_3++ )
        {
            var_2[var_3] = spawn( "script_origin", level._ID1624.selected_fx_ents[var_3]._ID34830["origin"] );
            var_2[var_3].angles = level._ID1624.selected_fx_ents[var_3]._ID34830["angles"];
            var_2[var_3] linkto( var_1 );
        }

        _ID26732( var_1, var_2 );
        var_1 delete();

        for ( var_3 = 0; var_3 < var_2.size; var_3++ )
            var_2[var_3] delete();
    }
    else if ( level._ID1624.selected_fx_ents.size == 1 )
    {
        var_4 = level._ID1624.selected_fx_ents[0];
        var_2 = spawn( "script_origin", ( 0, 0, 0 ) );
        var_2.angles = var_4._ID34830["angles"];

        if ( level._ID28027 != 0 )
            var_2 addpitch( level._ID28027 );
        else if ( level._ID28029 != 0 )
            var_2 addyaw( level._ID28029 );
        else
            var_2 addroll( level._ID28028 );

        var_4._ID34830["angles"] = var_2.angles;
        var_2 delete();
        wait 0.05;
    }

    level.fx_rotating = 0;
}

spawn_grenade()
{
    playfx( level._ID1624.grenade._ID13765, level.createfxcursor["position"] );
    level._ID1624.grenade playsound( level._ID1624.grenade._ID30465 );
    radiusdamage( level.createfxcursor["position"], level._ID1624.grenade.radius, 50, 5, undefined, "MOD_EXPLOSIVE" );
    level notify( "code_damageradius",  undefined, level._ID1624.grenade.radius, level.createfxcursor["position"]  );
}

_ID29926()
{
    _ID7440();
    _ID28394( "Help:" );
    _ID28394( "Insert          Insert entity" );
    _ID28394( "L               Drop selected entities to the ground" );
    _ID28394( "A               Add option to the selected entities" );
    _ID28394( "P               Reset the rotation of the selected entities" );
    _ID28394( "V               Copy the angles from the most recently selected fx onto all selected fx." );
    _ID28394( "Delete          Kill the selected entities" );
    _ID28394( "ESCAPE          Cancel out of option-modify-mode, must have console open" );
    _ID28394( "Ctrl-C          Copy" );
    _ID28394( "Ctrl-V          Paste" );
    _ID28394( "F2              Toggle createfx dot and text drawing" );
    _ID28394( "F5              SAVES your work" );
    _ID28394( "Dpad            Move selected entitise on X/Y or rotate pitch/yaw" );
    _ID28394( "A button        Toggle the selection of the current entity" );
    _ID28394( "X button        Toggle entity rotation mode" );
    _ID28394( "Y button        Move selected entites up or rotate roll" );
    _ID28394( "B button        Move selected entites down or rotate roll" );
    _ID28394( "R Shoulder      Move selected entities to the cursor" );
    _ID28394( "L Shoulder      Hold to select multiple entites" );
    _ID28394( "L JoyClick      Copy" );
    _ID28394( "R JoyClick      Paste" );
    _ID28394( "N               UFO" );
    _ID28394( "T               Toggle Timescale FAST" );
    _ID28394( "Y               Toggle Timescale SLOW" );
    _ID28394( "[               Toggle FX Visibility" );
    _ID28394( "]               Toggle ShowTris" );
    _ID28394( "F11             Toggle FX Profile" );
}

_ID14205( var_0 )
{

}

write_log( var_0, var_1, var_2, var_3 )
{
    var_4 = "\t";
    cfxprintlnstart();
    cfxprintln( "//_createfx generated. Do not touch!!" );
    cfxprintln( "#include common_scripts\utility;" );
    cfxprintln( "#include common_scripts\_createfx;\n" );
    cfxprintln( "" );
    cfxprintln( "main()" );
    cfxprintln( "{" );
    cfxprintln( var_4 + "// CreateFX " + var_1 + " entities placed: " + var_0.size );

    foreach ( var_6 in var_0 )
    {
        if ( level.createfx_loopcounter > 16 )
        {
            level.createfx_loopcounter = 0;
            wait 0.1;
        }

        level.createfx_loopcounter++;

        if ( getdvarint( "scr_map_exploder_dump" ) )
        {
            if ( !isdefined( var_6.model ) )
                continue;
        }
        else if ( isdefined( var_6.model ) )
            continue;

        if ( var_6._ID34830["type"] == "oneshotfx" )
            cfxprintln( var_4 + "ent = createOneshotEffect( \"" + var_6._ID34830["fxid"] + "\" );" );

        if ( var_6._ID34830["type"] == "exploder" )
        {
            if ( isdefined( var_6._ID34830["exploder"] ) && !level._ID21731 )
                cfxprintln( var_4 + "ent = createExploderEx( \"" + var_6._ID34830["fxid"] + "\", \"" + var_6._ID34830["exploder"] + "\" );" );
            else
                cfxprintln( var_4 + "ent = createExploder( \"" + var_6._ID34830["fxid"] + "\" );" );
        }

        if ( var_6._ID34830["type"] == "soundfx" )
            cfxprintln( var_4 + "ent = createLoopSound();" );

        if ( var_6._ID34830["type"] == "soundfx_interval" )
            cfxprintln( var_4 + "ent = createIntervalSound();" );

        if ( var_6._ID34830["type"] == "reactive_fx" )
            cfxprintln( var_4 + "ent = createReactiveEnt();" );

        cfxprintln( var_4 + "ent set_origin_and_angles( " + var_6._ID34830["origin"] + ", " + var_6._ID34830["angles"] + " );" );
        _ID24987( var_6, var_4, var_2 );
        cfxprintln( "" );
    }

    cfxprintln( "}" );
    cfxprintln( " " );
    cfxprintlnend( var_2, var_3, var_1 );
}

_ID8419()
{
    var_0 = 0.1;

    foreach ( var_2 in level._ID8435 )
    {
        var_3 = [];
        var_4 = [];

        for ( var_5 = 0; var_5 < 3; var_5++ )
        {
            var_3[var_5] = var_2._ID34830["origin"][var_5];
            var_4[var_5] = var_2._ID34830["angles"][var_5];

            if ( var_3[var_5] < var_0 && var_3[var_5] > var_0 * -1 )
                var_3[var_5] = 0;

            if ( var_4[var_5] < var_0 && var_4[var_5] > var_0 * -1 )
                var_4[var_5] = 0;
        }

        var_2._ID34830["origin"] = ( var_3[0], var_3[1], var_3[2] );
        var_2._ID34830["angles"] = ( var_4[0], var_4[1], var_4[2] );
    }
}

_ID14378( var_0 )
{
    var_1 = _ID14379( var_0 );
    var_2 = [];

    foreach ( var_5, var_4 in var_1 )
        var_2[var_5] = [];

    foreach ( var_7 in level._ID8435 )
    {
        var_8 = 0;

        foreach ( var_5, var_0 in var_1 )
        {
            if ( var_7._ID34830["type"] != var_0 )
                continue;

            var_8 = 1;
            var_2[var_5][var_2[var_5].size] = var_7;
            break;
        }
    }

    var_11 = [];

    for ( var_12 = 0; var_12 < var_1.size; var_12++ )
    {
        foreach ( var_7 in var_2[var_12] )
            var_11[var_11.size] = var_7;
    }

    return var_11;
}

_ID14379( var_0 )
{
    var_1 = [];

    if ( var_0 == "fx" )
    {
        var_1[0] = "oneshotfx";
        var_1[1] = "exploder";
    }
    else
    {
        var_1[0] = "soundfx";
        var_1[1] = "soundfx_interval";
        var_1[2] = "reactive_fx";
    }

    return var_1;
}

_ID18387( var_0, var_1 )
{
    var_2 = _ID14379( var_1 );

    foreach ( var_4 in var_2 )
    {
        if ( var_0._ID34830["type"] == var_4 )
            return 1;
    }

    return 0;
}

_ID8426()
{
    var_0 = [];
    var_0[0] = "soundfx";
    var_0[1] = "oneshotfx";
    var_0[2] = "exploder";
    var_0[3] = "soundfx_interval";
    var_0[4] = "reactive_fx";
    var_1 = [];

    foreach ( var_4, var_3 in var_0 )
        var_1[var_4] = [];

    foreach ( var_6 in level._ID8435 )
    {
        var_7 = 0;

        foreach ( var_4, var_9 in var_0 )
        {
            if ( var_6._ID34830["type"] != var_9 )
                continue;

            var_7 = 1;
            var_1[var_4][var_1[var_4].size] = var_6;
            break;
        }
    }

    var_11 = [];

    for ( var_12 = 0; var_12 < var_0.size; var_12++ )
    {
        foreach ( var_6 in var_1[var_12] )
            var_11[var_11.size] = var_6;
    }

    level._ID8435 = var_11;
}

cfxprintlnstart()
{
    common_scripts\utility::fileprint_launcher_start_file();
}

cfxprintln( var_0 )
{
    common_scripts\utility::_ID12835( var_0 );
}

cfxprintlnend( var_0, var_1, var_2 )
{
    var_3 = 1;

    if ( var_1 != "" || var_0 )
        var_3 = 0;

    if ( common_scripts\utility::_ID18787() )
    {
        var_4 = common_scripts\utility::_ID14794() + var_1 + "_" + var_2 + ".gsc";

        if ( var_0 )
            var_4 = "backup_" + var_2 + ".gsc";
    }
    else
    {
        var_4 = common_scripts\utility::_ID14794() + var_1 + "_" + var_2 + ".gsc";

        if ( var_0 )
            var_4 = "backup.gsc";
    }

    common_scripts\utility::_ID12836( "/share/raw/maps/createfx/" + var_4, var_3 );
}

_ID25022()
{
    add_button( "mouse1" );
    add_button( "BUTTON_RSHLDR" );
    add_button( "BUTTON_LSHLDR" );
    add_button( "BUTTON_RSTICK" );
    add_button( "BUTTON_LSTICK" );
    add_button( "BUTTON_A" );
    add_button( "BUTTON_B" );
    add_button( "BUTTON_X" );
    add_button( "BUTTON_Y" );
    add_button( "DPAD_UP" );
    add_button( "DPAD_LEFT" );
    add_button( "DPAD_RIGHT" );
    add_button( "DPAD_DOWN" );
    add_kb_button( "shift" );
    add_kb_button( "ctrl" );
    add_kb_button( "escape" );
    add_kb_button( "F1" );
    add_kb_button( "F5" );
    add_kb_button( "F4" );
    add_kb_button( "F2" );
    add_kb_button( "a" );
    add_kb_button( "g" );
    add_kb_button( "c" );
    add_kb_button( "h" );
    add_kb_button( "i" );
    add_kb_button( "k" );
    add_kb_button( "l" );
    add_kb_button( "m" );
    add_kb_button( "p" );
    add_kb_button( "s" );
    add_kb_button( "u" );
    add_kb_button( "v" );
    add_kb_button( "x" );
    add_kb_button( "del" );
    add_kb_button( "end" );
    add_kb_button( "tab" );
    add_kb_button( "ins" );
    add_kb_button( "add" );
    add_kb_button( "space" );
    add_kb_button( "enter" );
    add_kb_button( "1" );
    add_kb_button( "2" );
    add_kb_button( "3" );
    add_kb_button( "4" );
    add_kb_button( "5" );
    add_kb_button( "6" );
    add_kb_button( "7" );
    add_kb_button( "8" );
    add_kb_button( "9" );
    add_kb_button( "0" );
    add_kb_button( "-" );
    add_kb_button( "=" );
    add_kb_button( "," );
    add_kb_button( "." );
    add_kb_button( "[" );
    add_kb_button( "]" );
    add_kb_button( "leftarrow" );
    add_kb_button( "rightarrow" );
    add_kb_button( "uparrow" );
    add_kb_button( "downarrow" );
}

_ID20181( var_0 )
{
    if ( isdefined( level._ID1624._ID20183[var_0] ) )
        return 0;

    return _ID19057( var_0 );
}

_ID19057( var_0 )
{
    return level.createfx_inputlocked && isdefined( level._ID6348[var_0] );
}

add_button( var_0 )
{
    if ( _ID20181( var_0 ) )
        return;

    if ( !isdefined( level.buttonisheld[var_0] ) )
    {
        if ( level.player buttonpressed( var_0 ) )
        {
            level.buttonisheld[var_0] = 1;
            level.buttonclick[var_0] = 1;
        }
    }
    else if ( !level.player buttonpressed( var_0 ) )
        level.buttonisheld[var_0] = undefined;
}

add_kb_button( var_0 )
{
    level._ID6348[var_0] = 1;
    add_button( var_0 );
}

_ID6356( var_0, var_1 )
{
    return buttonpressed_internal( var_0 ) || buttonpressed_internal( var_1 );
}

buttonpressed_internal( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( _ID19057( var_0 ) )
        return 0;

    return level.player buttonpressed( var_0 );
}

button_is_held( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
    {
        if ( isdefined( level.buttonisheld[var_1] ) )
            return 1;
    }

    return isdefined( level.buttonisheld[var_0] );
}

button_is_clicked( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
    {
        if ( isdefined( level.buttonclick[var_1] ) )
            return 1;
    }

    return isdefined( level.buttonclick[var_0] );
}

_ID17757()
{
    level._ID1624.hudelems = [];
    level._ID1624.hudelem_count = 30;
    var_0 = [];
    var_1 = [];
    var_0[0] = 0;
    var_1[0] = 0;
    var_0[1] = 1;
    var_1[1] = 1;
    var_0[2] = -2;
    var_1[2] = 1;
    var_0[3] = 1;
    var_1[3] = -1;
    var_0[4] = -2;
    var_1[4] = -1;
    level._ID7511 = newhudelem();
    level._ID7511.alpha = 0;

    for ( var_2 = 0; var_2 < level._ID1624.hudelem_count; var_2++ )
    {
        var_3 = [];

        for ( var_4 = 0; var_4 < 1; var_4++ )
        {
            var_5 = newhudelem();
            var_5.alignx = "left";
            var_5.location = 0;
            var_5.foreground = 1;
            var_5.fontscale = 1.4;
            var_5.sort = 20 - var_4;
            var_5.alpha = 1;
            var_5.x = 0 + var_0[var_4];
            var_5.y = 60 + var_1[var_4] + var_2 * 15;

            if ( var_4 > 0 )
                var_5.color = ( 0, 0, 0 );

            var_3[var_3.size] = var_5;
        }

        level._ID1624.hudelems[var_2] = var_3;
    }

    var_3 = [];

    for ( var_4 = 0; var_4 < 5; var_4++ )
    {
        var_5 = newhudelem();
        var_5.alignx = "center";
        var_5.location = 0;
        var_5.foreground = 1;
        var_5.fontscale = 1.4;
        var_5.sort = 20 - var_4;
        var_5.alpha = 1;
        var_5.x = 320 + var_0[var_4];
        var_5.y = 80 + var_1[var_4];

        if ( var_4 > 0 )
            var_5.color = ( 0, 0, 0 );

        var_3[var_3.size] = var_5;
    }

    level.createfx_centerprint = var_3;
}

_ID17714()
{
    var_0 = newhudelem();
    var_0.location = 0;
    var_0.alignx = "center";
    var_0.aligny = "middle";
    var_0.foreground = 1;
    var_0.fontscale = 2;
    var_0.sort = 20;
    var_0.alpha = 1;
    var_0.x = 320;
    var_0.y = 233;
}

_ID7440()
{
    level._ID7511 clearalltextafterhudelem();

    for ( var_0 = 0; var_0 < level._ID1624.hudelem_count; var_0++ )
    {
        for ( var_1 = 0; var_1 < 1; var_1++ )
        {

        }
    }

    level.fxhudelements = 0;
}

_ID28394( var_0 )
{
    for ( var_1 = 0; var_1 < 1; var_1++ )
    {

    }

    level.fxhudelements++;
}

_ID17856()
{
    if ( !isdefined( level._ID1624._ID33118 ) )
        level._ID1624._ID33118 = [];

    if ( !isdefined( level._ID1624._ID33117 ) )
        level._ID1624._ID33117 = 1;

    if ( !isdefined( level._ID1624._ID33116 ) )
        level._ID1624._ID33116 = "";
}

_ID21953( var_0 )
{
    foreach ( var_3, var_2 in level._ID1624._ID33118 )
    {
        if ( isdefined( var_2._ID34845 ) )
            var_2._ID34845 destroy();

        var_2 destroy();
        level._ID1624._ID33118[var_3] = undefined;
    }

    level._ID1624._ID33116 = var_0;
}

current_mode_hud( var_0 )
{
    return level._ID1624._ID33116 == var_0;
}

clear_tool_hud()
{
    _ID21953( "" );
}

_ID21954( var_0 )
{
    var_1 = newhudelem();
    var_1.alignx = "left";
    var_1.location = 0;
    var_1.foreground = 1;
    var_1.fontscale = 1.2;
    var_1.alpha = 1;
    var_1.x = 0;
    var_1.y = 320 + var_0 * 15;
    return var_1;
}

get_tool_hudelem( var_0 )
{
    if ( isdefined( level._ID1624._ID33118[var_0] ) )
        return level._ID1624._ID33118[var_0];

    return undefined;
}

_ID28589( var_0, var_1 )
{
    var_2 = get_tool_hudelem( var_0 );

    if ( !isdefined( var_2 ) )
    {
        var_2 = _ID21954( level._ID1624._ID33118.size );
        level._ID1624._ID33118[var_0] = var_2;
        var_2._ID32858 = var_0;
    }

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_2._ID34845 ) )
            var_3 = var_2._ID34845;
        else
        {
            var_3 = _ID21954( level._ID1624._ID33118.size );
            var_3.x = var_3.x + 80;
            var_3.y = var_2.y;
            var_2._ID34845 = var_3;
        }

        if ( isdefined( var_3._ID32858 ) && var_3._ID32858 == var_1 )
            return;

        var_3._ID32858 = var_1;
    }
}

select_by_substring()
{
    var_0 = getdvar( "select_by_substring" );

    if ( var_0 == "" )
        return 0;

    setdvar( "select_by_substring", "" );
    var_1 = [];

    foreach ( var_4, var_3 in level._ID8435 )
    {
        if ( issubstr( var_3._ID34830["fxid"], var_0 ) )
            var_1[var_1.size] = var_4;
    }

    if ( var_1.size == 0 )
        return 0;

    _ID9739();
    _ID28013( var_1 );

    foreach ( var_6 in var_1 )
    {
        var_3 = level._ID8435[var_6];
        _ID28012( var_6, var_3 );
    }

    return 1;
}

_ID28013( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        var_3 = level._ID8435[var_2];
        _ID28012( var_2, var_3 );
    }
}

_ID9739()
{
    foreach ( var_2, var_1 in level._ID1624.selected_fx_ents )
        deselect_entity( var_2, var_1 );
}
