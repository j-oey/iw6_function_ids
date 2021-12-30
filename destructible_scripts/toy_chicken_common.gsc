// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool
#using_animtree("destructibles");

toy_chicken_common( var_0 )
{
    common_scripts\_destructible::destructible_create( "toy_chicken" + var_0, "tag_origin", 0, undefined, 32 );
    common_scripts\_destructible::_ID9824( %chicken_cage_loop_01, #animtree, "setanimknob", undefined, 0, "chicken_cage_loop_01", 1.6 );
    common_scripts\_destructible::_ID9824( %chicken_cage_loop_02, #animtree, "setanimknob", undefined, 1, "chicken_cage_loop_02", 1.6 );
    common_scripts\_destructible::_ID9862( "animal_chicken_idle_loop" );
    common_scripts\_destructible::destructible_state( "tag_origin", "chicken" + var_0, 25 );
    common_scripts\_destructible::_ID9851( "tag_origin", "fx/props/chicken_exp" + var_0 );
    common_scripts\_destructible::_ID9824( %chicken_cage_death, #animtree, "setanimknob", undefined, 0, "chicken_cage_death" );
    common_scripts\_destructible::_ID9824( %chicken_cage_death_02, #animtree, "setanimknob", undefined, 1, "chicken_cage_death_02" );
    common_scripts\_destructible::_ID9877( "animal_chicken_death" );
    common_scripts\_destructible::destructible_state( undefined, "chicken" + var_0, undefined, undefined, "no_melee" );
}
