// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    common_scripts\_destructible::destructible_create( "toy_filecabinet", "tag_origin", 120 );
    common_scripts\_destructible::_ID9851( "tag_drawer_lower", "fx/props/filecabinet_dam", 1, common_scripts\_destructible::damage_not( "splash" ) );
    common_scripts\_destructible::_ID9877( "exp_filecabinet" );
    common_scripts\_destructible::destructible_state( undefined, "com_filecabinetblackclosed_dam", 20, undefined, undefined, "splash" );
    common_scripts\_destructible::_ID9851( "tag_drawer_upper", "fx/props/filecabinet_des", 1, "splash" );
    common_scripts\_destructible::_ID9877( "exp_filecabinet" );
    common_scripts\_destructible::destructible_physics( "tag_drawer_upper", ( 50, -10, 5 ) );
    common_scripts\_destructible::destructible_state( undefined, "com_filecabinetblackclosed_des", undefined, undefined, undefined, undefined, undefined, 0 );
    common_scripts\_destructible::_ID9867( "tag_drawer_upper", "com_filecabinetblackclosed_drawer", undefined, undefined, undefined, undefined, 1.0, 1.0 );
}
