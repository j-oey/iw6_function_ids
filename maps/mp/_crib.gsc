// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    precacheshellshock( "frag_grenade_mp" );
    _ID25262();
    _ID25266();
    _ID35245();
    _ID24139();
}

_ID25262()
{
    _ID21965( "main", "player_view1_start", "player_view1_end" );
    var_0 = newradialbutton( "main", "Primary Weapon", "radial_weapons_primary", ::action_weapons_primary );
    var_1 = newradialbutton( "main", "Secondary Weapon", "radial_weapons_secondary", ::action_weapons_secondary );
    var_2 = newradialbutton( "main", "Gears", "radial_gears", ::action_gears );
    var_3 = newradialbutton( "main", "Kill Streaks", "radial_killstreaks", ::action_killstreak );
    var_4 = newradialbutton( "main", "Leaderboards", "radial_leaderboards", ::_ID2053 );
    _ID21965( "gears", "player_view2_start", "player_view2_end" );
    _ID21965( "weapons_primary", "player_view3_start", "player_view3_end" );
    _ID21965( "weapons_secondary", "player_view3_start", "player_view3_end" );
    _ID21965( "killstreak", "player_view4_start", "player_view4_end" );
    _ID21965( "leaderboards", "player_view5_start", "player_view5_end" );
}

_ID25266()
{
    foreach ( var_1 in level.radial_button_group )
    {
        _ID30443( var_1 );

        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            if ( isdefined( var_1[var_2 + 1] ) )
            {
                var_3 = _ID15149( var_1[var_2]._ID24746, var_1[var_2 + 1]._ID24746 );
                var_1[var_2]._ID11512 = var_3;
                var_1[var_2 + 1]._ID31217 = var_3;
                continue;
            }

            var_3 = _ID15149( var_1[var_2]._ID24746, var_1[0]._ID24746 ) + 180;

            if ( var_3 > 360 )
                var_3 -= 360;

            var_1[var_2]._ID11512 = var_3;
            var_1[0]._ID31217 = var_3;
        }
    }

    thread _ID34602();
    thread _ID36123();
    thread _ID36039();
    thread _ID9234();
}

_ID9234()
{
    level endon( "game_ended" );
    level._ID8509 = 1;

    for (;;)
    {
        if ( !isdefined( level._ID22509 ) )
        {
            wait 0.05;
            continue;
        }

        var_0 = 1;

        while ( !level._ID22509 buttonpressed( "BUTTON_Y" ) )
            wait 0.05;

        level._ID22509 playsound( "mouse_click" );

        if ( var_0 )
        {
            level._ID8509 = level._ID8509 * -1;
            var_0 = 0;
        }

        while ( level._ID22509 buttonpressed( "BUTTON_Y" ) )
            wait 0.05;
    }
}

_ID24139()
{
    level thread _ID22877();
    level thread _ID26239();
}

_ID26239()
{
    level waittill( "game_ended" );
    setdvar( "cg_draw2d", 1 );
}

_ID22877()
{
    level waittill( "connected",  var_0  );
    var_0 thread _ID25557();
    var_0 waittill( "spawned_player" );
    wait 1;
    var_0 takeallweapons();
    setdvar( "cg_draw2d", 0 );

    if ( !isdefined( var_0 ) )
        return;
    else
        level._ID22509 = var_0;

    var_0 thread _ID14729();
    _ID36597( "main" );
}

_ID25557()
{
    self endon( "disconnect" );
    var_0 = "autoassign";

    while ( !isdefined( self.pers["team"] ) )
        wait 0.05;

    self notify( "menuresponse",  game["menu_team"], var_0  );
    wait 0.5;
    var_1 = getarraykeys( level.classmap );
    var_2 = [];

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        if ( !issubstr( var_1[var_3], "custom" ) )
            var_2[var_2.size] = var_1[var_3];
    }

    for (;;)
    {
        var_4 = var_2[0];
        self notify( "menuresponse",  "changeclass", var_4  );
        self waittill( "spawned_player" );
        wait 0.1;
    }
}

_ID14729()
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    for (;;)
    {
        var_0 = self getnormalizedmovement();
        var_1 = vectortoangles( var_0 );
        level._ID26862 = int( var_1[1] );
        wait 0.05;
    }
}

_ID21965( var_0, var_1, var_2 )
{
    if ( isdefined( level.radial_button_group ) && level.radial_button_group.size )
    {

    }

    var_3 = getent( var_2, "targetname" );
    var_4 = vectornormalize( anglestoforward( var_3.angles ) ) * 40;
    level.radial_button_group[var_0] = [];
    level._ID25264[var_0]["view_start"] = var_1;
    level._ID25264[var_0]["view_pos"] = var_3.origin + var_4;
    level._ID25264[var_0]["player_view_pos"] = var_3.origin;
    level._ID25264[var_0]["view_angles"] = var_3.angles;
}

newradialbutton( var_0, var_1, var_2, var_3 )
{
    var_4 = getent( var_2, "targetname" );
    var_5 = getradialanglefroment( var_0, var_4 );
    var_6 = spawnstruct();
    var_6._ID24745 = var_4.origin;
    var_6.label = var_1;
    var_6.font_size = 1;
    var_6.font_color = ( 0.5, 0.5, 1 );
    var_6._ID24746 = var_5;
    var_6.action_func = var_3;
    var_6._ID25302 = 8;
    level.radial_button_group[var_0][level.radial_button_group[var_0].size] = var_6;
    return var_6;
}

_ID34602()
{
    level endon( "game_ended" );

    for (;;)
    {
        if ( !isdefined( level._ID25261 ) )
        {
            wait 0.05;
            continue;
        }

        var_0 = level._ID2121;

        foreach ( var_2 in level.radial_button_group[level._ID25261] )
        {
            if ( _ID18659( var_2._ID31217, var_2._ID11512 ) )
            {
                level._ID2121 = var_2;
                continue;
            }

            var_2.font_color = ( 0.5, 0.5, 1 );
        }

        if ( isdefined( level._ID2121 ) )
        {
            level._ID2121.font_color = ( 1, 1, 0.5 );

            if ( isdefined( var_0 ) && var_0 != level._ID2121 )
                level._ID22509 playsound( "mouse_over" );
        }

        wait 0.05;
    }
}

_ID36123()
{
    level endon( "game_ended" );

    for (;;)
    {
        if ( !isdefined( level._ID22509 ) )
        {
            wait 0.05;
            continue;
        }

        var_0 = 1;

        while ( !level._ID22509 buttonpressed( "BUTTON_A" ) )
            wait 0.05;

        level._ID22509 playsound( "mouse_click" );

        if ( isdefined( level._ID2121 ) && var_0 )
        {
            level._ID2121 notify( "select_button_pressed" );
            [[ level._ID2121.action_func ]]();
            var_0 = 0;
        }

        while ( level._ID22509 buttonpressed( "BUTTON_A" ) )
            wait 0.05;
    }
}

_ID36039()
{
    level endon( "game_ended" );

    for (;;)
    {
        if ( !isdefined( level._ID22509 ) )
        {
            wait 0.05;
            continue;
        }

        var_0 = 1;

        while ( !level._ID22509 buttonpressed( "BUTTON_X" ) )
            wait 0.05;

        level._ID22509 playsound( "mouse_click" );

        if ( var_0 )
        {
            action_back();
            var_0 = 0;
        }

        while ( level._ID22509 buttonpressed( "BUTTON_X" ) )
            wait 0.05;
    }
}

_ID30443( var_0 )
{
    for ( var_1 = 0; var_1 < var_0.size - 1; var_1++ )
    {
        for ( var_2 = 0; var_2 < var_0.size - 1 - var_1; var_2++ )
        {
            if ( var_0[var_2 + 1]._ID24746 < var_0[var_2]._ID24746 )
                button_switch( var_0[var_2], var_0[var_2 + 1] );
        }
    }
}

button_switch( var_0, var_1 )
{
    var_2 = var_0._ID24745;
    var_3 = var_0.label;
    var_4 = var_0._ID24746;
    var_5 = var_0.action_func;
    var_6 = var_0._ID25302;
    var_0._ID24745 = var_1._ID24745;
    var_0.label = var_1.label;
    var_0._ID24746 = var_1._ID24746;
    var_0.action_func = var_1.action_func;
    var_0._ID25302 = var_1._ID25302;
    var_1._ID24745 = var_2;
    var_1.label = var_3;
    var_1._ID24746 = var_4;
    var_1.action_func = var_5;
    var_1._ID25302 = var_6;
}

draw_radial_buttons( var_0 )
{
    foreach ( var_2 in level.radial_button_group[var_0] )
        var_2 thread _ID10856( var_0 );
}

_ID10856( var_0 )
{
    level endon( "game_ended" );
    self endon( "remove_button" );
    var_1 = level._ID25264[var_0]["view_pos"];
    var_2 = var_1 + _ID25260( self._ID24746, 4 );

    for (;;)
    {
        var_3 = ( 1, 0, 0 );

        if ( _ID18659( self._ID31217, self._ID11512 ) )
            var_3 = ( 1, 1, 0 );

        if ( isdefined( level._ID8509 ) && level._ID8509 > 0 )
            var_4 = var_1 + _ID25260( level._ID26862, 2 );

        wait 0.05;
    }
}

_ID36597( var_0, var_1 )
{
    level._ID2121 = undefined;

    if ( isdefined( level._ID25261 ) && level._ID25261 != "" )
        level.radial_button_previous_group = level._ID25261;
    else
    {
        level.radial_button_previous_group = "main";
        level._ID25261 = "main";
    }

    foreach ( var_3 in level.radial_button_group[level.radial_button_previous_group] )
        var_3 notify( "remove_button" );

    if ( isdefined( var_1 ) && var_1 )
        level._ID22509 _ID15699( level._ID25264[level.radial_button_previous_group]["view_start"], var_0 );
    else
        level._ID22509 go_path_by_targetname( level._ID25264[var_0]["view_start"] );

    level thread draw_radial_buttons( var_0 );
    level._ID25261 = var_0;
}

getradialanglefroment( var_0, var_1 )
{
    var_2 = level._ID25264[var_0]["view_angles"];
    var_3 = level._ID25264[var_0]["view_pos"];
    var_3 += vectornormalize( anglestoforward( var_2 ) ) * 40;
    var_4 = anglestoforward( var_2 );
    var_5 = vectornormalize( anglestoup( var_2 ) );
    var_6 = var_1.angles;
    var_7 = var_1.origin;
    var_8 = vectornormalize( vectorfromlinetopoint( var_3, var_3 + var_4, var_7 ) );
    var_9 = acos( vectordot( var_8, var_5 ) );

    if ( vectordot( anglestoright( var_2 ), var_8 ) < 0 )
        var_9 = 360 - var_9;

    return var_9;
}

_ID25260( var_0, var_1 )
{
    var_2 = ( 270 - var_0, 0, 0 );
    var_3 = anglestoforward( var_2 );
    var_4 = vectornormalize( var_3 );
    var_5 = var_4 * var_1;
    return var_5;
}

_ID15149( var_0, var_1 )
{
    var_2 = ( var_0 + var_1 + 720 ) / 2 - 360;
    return var_2;
}

_ID18659( var_0, var_1 )
{
    var_2 = level._ID26862 > var_0 && level._ID26862 < 360;
    var_3 = level._ID26862 > 0 && level._ID26862 < var_1;

    if ( var_0 > var_1 )
        var_4 = var_2 || var_3;
    else
        var_4 = level._ID26862 > var_0 && level._ID26862 < var_1;

    return var_4;
}

action_back()
{
    if ( isdefined( level._ID25261 ) && level._ID25261 != "main" )
        _ID36597( "main", 1 );
    else
        return;
}

action_weapons_primary()
{
    iprintlnbold( "action_weapons_primary" );
    _ID36597( "weapons_primary" );
}

action_weapons_secondary()
{
    iprintlnbold( "action_weapons_secondary" );
    _ID36597( "weapons_secondary" );
}

action_gears()
{
    iprintlnbold( "action_gears" );
    _ID36597( "gears" );
}

action_killstreak()
{
    iprintlnbold( "action_killstreak" );
    _ID36597( "killstreak" );
}

_ID2053()
{
    iprintlnbold( "action_leaderboards" );
    _ID36597( "leaderboards" );
}

_ID35245()
{
    level._ID35246 = [];
    _ID6203( "player_view1_start" );
    _ID6203( "player_view2_start" );
    _ID6203( "player_view3_start" );
    _ID6203( "player_view4_start" );
    _ID6203( "player_view5_start" );
}

_ID6203( var_0 )
{
    level._ID35246[var_0] = [];
    var_1 = getent( var_0, "targetname" );

    for ( level._ID35246[var_0][level._ID35246[var_0].size] = var_1; isdefined( var_1 ) && isdefined( var_1.target ); var_1 = var_2 )
    {
        var_2 = getent( var_1.target, "targetname" );
        level._ID35246[var_0][level._ID35246[var_0].size] = var_2;
    }
}

go_path_by_targetname( var_0 )
{
    if ( !isdefined( level._ID11148 ) )
    {
        var_1 = level._ID35246[var_0][0];
        level._ID11148 = spawn( "script_model", var_1.origin );
        level._ID11148.angles = var_1.angles;
        self setorigin( level._ID11148.origin - ( 0, 0, 65 ) );
        self linkto( level._ID11148 );
        wait 0.05;
        self setplayerangles( level._ID11148.angles );
        thread _ID13498();
    }

    var_2 = 1;
    var_3 = abs( distance( level._ID11148.origin, level._ID35246[var_0][level._ID35246[var_0].size - 1].origin ) );
    var_2 *= var_3 / 1200;
    var_2 = max( var_2, 0.1 );
    var_4 = var_2;

    if ( !1 )
        var_4 *= ( var_2 * ( level._ID35246[var_0].size + 1 ) );

    thread blur_sine( 3, var_4 );

    foreach ( var_7, var_6 in level._ID35246[var_0] )
    {
        if ( 1 )
        {
            if ( var_7 != level._ID35246[var_0].size - 1 )
                continue;
        }

        level._ID11148 moveto( var_6.origin, var_2, var_2 * 0.5, 0 );
        level._ID11148 rotateto( var_6.angles, var_2, var_2 * 0.5, 0 );
        wait(var_2);
    }
}

_ID15699( var_0, var_1 )
{
    var_2 = 1;
    var_3 = abs( distance( level._ID11148.origin, level._ID25264[var_1]["player_view_pos"] ) );
    var_2 *= var_3 / 1200;
    var_2 = max( var_2, 0.1 );
    var_4 = var_2;

    if ( !1 )
        var_4 *= ( var_2 * ( level._ID35246[var_0].size + 1 ) );

    thread blur_sine( 3, var_4 );

    if ( !1 )
    {
        for ( var_5 = level._ID35246[var_0].size - 1; var_5 >= 0; var_5-- )
        {
            var_6 = level._ID35246[var_0][var_5];
            level._ID11148 moveto( var_6.origin, var_2 );
            level._ID11148 rotateto( var_6.angles, var_2 );
            wait(var_2);
        }
    }

    thread blur_sine( 3, var_2 );
    var_7 = level._ID25264[var_1]["player_view_pos"];
    var_8 = level._ID25264[var_1]["view_angles"];
    level._ID11148 moveto( var_7, var_2, var_2 * 0.5, 0 );
    level._ID11148 rotateto( var_8, var_2, var_2 * 0.5, 0 );
    wait(var_2);
}

travel_view_fx( var_0 )
{
    self setblurforplayer( 20, ( var_0 + 0.2 ) / 2 );
    self setblurforplayer( 0, ( var_0 + 0.2 ) / 2 );
    self shellshock( "frag_grenade_mp", var_0 + 0.2 );
}

blur_sine( var_0, var_1 )
{
    var_2 = int( var_1 / 0.05 );

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = var_3 / var_2;
        var_5 = sin( 180 * var_4 );
        var_6 = var_0 * var_5;
        setdvar( "r_blur", var_6 );
        wait 0.05;
    }

    setdvar( "r_blur", 0 );
}

_ID13498()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    level._ID11148 endon( "remove_dummy" );

    for (;;)
    {
        self setplayerangles( level._ID11148.angles );
        wait 0.05;
    }
}
