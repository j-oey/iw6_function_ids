// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    common_scripts\_destructible::destructible_create( "toy_transformer_small01", "tag_origin", 75, undefined, 32, "no_melee" );
    common_scripts\_destructible::_ID9880( 15 );
    common_scripts\_destructible::destructible_loopfx( "tag_fx", "fx/smoke/car_damage_whitesmoke", 0.4 );
    common_scripts\_destructible::destructible_state( undefined, undefined, 75, undefined, 32, "no_melee" );
    common_scripts\_destructible::destructible_loopfx( "tag_fx", "fx/smoke/car_damage_blacksmoke", 0.4 );
    common_scripts\_destructible::destructible_state( undefined, undefined, 150, undefined, 32, "no_melee" );
    common_scripts\_destructible::destructible_loopfx( "tag_fx", "fx/explosions/transformer_spark_runner", 0.5 );
    common_scripts\_destructible::_ID9862( "transformer_spark_loop" );
    common_scripts\_destructible::_ID9858( 24, 0.2 );
    common_scripts\_destructible::destructible_state( undefined, undefined, 250, undefined, 32, "no_melee" );
    common_scripts\_destructible::destructible_loopfx( "tag_fx", "fx/explosions/transformer_spark_runner", 0.5 );
    common_scripts\_destructible::destructible_loopfx( "tag_fx", "fx/fire/transformer_small_blacksmoke_fire", 0.4 );
    common_scripts\_destructible::_ID9877( "transformer01_flareup_med" );
    common_scripts\_destructible::_ID9862( "transformer_spark_loop" );
    common_scripts\_destructible::_ID9858( 24, 0.2, 150, "allies" );
    common_scripts\_destructible::destructible_state( undefined, undefined, 400, undefined, 5, "no_melee" );
    common_scripts\_destructible::_ID9851( "tag_fx", "fx/explosions/transformer_explosion", 0 );
    common_scripts\_destructible::_ID9851( "tag_fx", "fx/fire/firelp_small_pm" );
    common_scripts\_destructible::_ID9877( "transformer01_explode" );
    common_scripts\_destructible::_ID9844( 7000, 8000, 150, 256, 16, 100, undefined, 0 );
    common_scripts\_destructible::destructible_state( undefined, "utility_transformer_small01_dest", undefined, undefined, "no_melee" );
}
