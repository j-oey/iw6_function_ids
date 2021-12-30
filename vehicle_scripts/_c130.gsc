// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "c130", var_0, var_1, var_2 );
    maps\_vehicle::_ID6200( ::_ID17769 );
    maps\_vehicle::build_deathmodel( "vehicle_ac130_low" );
    maps\_vehicle::build_deathfx( "fx/explosions/large_vehicle_explosion", undefined, "explo_metal_rand" );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::_ID6216( "allies" );
    maps\_vehicle::_ID6202();
    maps\_vehicle::_ID6198( var_2, "wingtip_green", "tag_light_L_wing", "fx/misc/aircraft_light_wingtip_green", "running", 0.0 );
    maps\_vehicle::_ID6198( var_2, "wingtip_red", "tag_light_R_wing", "fx/misc/aircraft_light_wingtip_red", "running", 0.05 );
    maps\_vehicle::_ID6198( var_2, "tail_red", "tag_light_tail", "fx/misc/aircraft_light_white_blink", "running", 0.05 );
    maps\_vehicle::_ID6198( var_2, "white_blink", "tag_light_belly", "fx/misc/aircraft_light_red_blink", "running", 1.0 );
}

_ID17769()
{
    maps\_vehicle::_ID35059( "running" );
    self hidepart( "tag_25mm" );
    self hidepart( "tag_40mm" );
    self hidepart( "tag_105mm" );
}

_ID28602( var_0 )
{
    return var_0;
}

_ID28639()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < 1; var_1++ )
        var_0[var_1] = spawnstruct();

    return var_0;
}
