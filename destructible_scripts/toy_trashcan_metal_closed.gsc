// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    common_scripts\_destructible::destructible_create( "toy_trashcan_metal_closed", "tag_origin", 120, undefined, 32, "no_melee" );
    common_scripts\_destructible::_ID9851( "tag_fx", "fx/props/garbage_spew_des", 1, "splash" );
    common_scripts\_destructible::_ID9851( "tag_fx", "fx/props/garbage_spew", 1, common_scripts\_destructible::damage_not( "splash" ) );
    common_scripts\_destructible::_ID9877( "exp_trashcan_sweet" );
    common_scripts\_destructible::_ID9844( 600, 651, 1, 1, 10, 20 );
    common_scripts\_destructible::destructible_state( undefined, "com_trashcan_metal_with_trash", undefined, undefined, undefined, undefined, undefined, 0 );
    common_scripts\_destructible::_ID9867( "tag_fx", "com_trashcan_metalLID", undefined, undefined, undefined, undefined, 1.0, 1.0 );
}
