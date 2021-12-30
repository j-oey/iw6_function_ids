// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool
#using_animtree("destructibles");

_ID20445()
{
    common_scripts\_destructible::destructible_create( "toy_light_ceiling_fluorescent", "tag_origin", 150, undefined, 32, "no_melee" );
    common_scripts\_destructible::_ID9880( 15 );
    common_scripts\_destructible::_ID9851( "tag_fx", "fx/misc/light_fluorescent_blowout_runner" );
    common_scripts\_destructible::_ID9851( "tag_swing_fx", "fx/misc/light_blowout_swinging_runner" );
    common_scripts\_destructible::destructible_lights_out( 16 );
    common_scripts\_destructible::_ID9844( 20, 2000, 64, 64, 40, 80 );
    common_scripts\_destructible::_ID9824( %light_fluorescent_swing, #animtree, "setanimknob", undefined, 0, "light_fluorescent_swing" );
    common_scripts\_destructible::_ID9877( "fluorescent_light_fall", undefined, 0 );
    common_scripts\_destructible::_ID9877( "fluorescent_light_bulb", undefined, 0 );
    common_scripts\_destructible::_ID9824( %light_fluorescent_swing_02, #animtree, "setanimknob", undefined, 1, "light_fluorescent_swing_02" );
    common_scripts\_destructible::_ID9877( "fluorescent_light_fall", undefined, 1 );
    common_scripts\_destructible::_ID9877( "fluorescent_light_bulb", undefined, 1 );
    common_scripts\_destructible::_ID9824( %light_fluorescent_null, #animtree, "setanimknob", undefined, 2, "light_fluorescent_null" );
    common_scripts\_destructible::destructible_state( undefined, "me_lightfluohang_double_destroyed", undefined, undefined, "no_melee" );
}
