// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool
#using_animtree("destructibles");

_ID20445()
{
    common_scripts\_destructible::destructible_create( "toy_wall_fan", "tag_swivel", 0, undefined, 32 );
    common_scripts\_destructible::_ID9824( %wall_fan_rotate, #animtree, "setanimknob", undefined, undefined, "wall_fan_rotate" );
    common_scripts\_destructible::_ID9862( "wall_fan_fanning" );
    common_scripts\_destructible::destructible_state( "tag_wobble", "cs_wallfan1", 150 );
    common_scripts\_destructible::_ID9824( %wall_fan_stop, #animtree, "setanimknob", undefined, undefined, "wall_fan_wobble" );
    common_scripts\_destructible::_ID9851( "tag_fx", "fx/explosions/wallfan_explosion_dmg" );
    common_scripts\_destructible::_ID9877( "wall_fan_sparks" );
    common_scripts\_destructible::destructible_state( "tag_wobble", "cs_wallfan1", 150, undefined, "no_melee" );
    common_scripts\_destructible::_ID9851( "tag_fx", "fx/explosions/wallfan_explosion_des" );
    common_scripts\_destructible::_ID9877( "wall_fan_break" );
    common_scripts\_destructible::destructible_state( undefined, "cs_wallfan1_dmg", undefined, undefined, "no_melee" );
}
