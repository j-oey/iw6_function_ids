// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID33238( var_0, var_1, var_2 )
{
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "blackice_tv" )
    {
        common_scripts\_destructible::destructible_create( "toy_tv_flatscreen_" + var_1 + var_0, "tag_origin", 1, undefined, 32 );
        common_scripts\_destructible::_ID9880( 1 );
        common_scripts\_destructible::_ID9851( "tag_fx", "fx/explosions/tv_flatscreen_explosion_quick" );
        common_scripts\_destructible::_ID9877( "tv_shot_burst" );
        common_scripts\_destructible::_ID9844( 20, 2000, 10, 10, 3, 3, undefined, 15 );
        common_scripts\_destructible::destructible_state( undefined, "ma_flatscreen_tv_" + var_1 + "broken_" + var_0, 200, undefined, "no_melee" );
    }
    else
    {
        common_scripts\_destructible::destructible_create( "toy_tv_flatscreen_" + var_1 + var_0, "tag_origin", 1, undefined, 32 );
        common_scripts\_destructible::_ID9880( 1 );
        common_scripts\_destructible::_ID9851( "tag_fx", "fx/explosions/tv_flatscreen_explosion" );
        common_scripts\_destructible::_ID9877( "tv_shot_burst" );
        common_scripts\_destructible::_ID9844( 20, 2000, 10, 10, 3, 3, undefined, 15 );
        common_scripts\_destructible::destructible_state( undefined, "ma_flatscreen_tv_" + var_1 + "broken_" + var_0, 200, undefined, "no_melee" );
    }
}

toy_tvs_flatscreen_sturdy( var_0, var_1, var_2 )
{
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "blackice_tv" )
    {
        common_scripts\_destructible::destructible_create( "toy_tv_flatscreen_" + var_1 + var_0 + "_sturdy", "tag_origin", 1, undefined, 1280 );
        common_scripts\_destructible::_ID9880( 0.5 );
        common_scripts\_destructible::_ID9851( "tag_fx", "fx/explosions/tv_flatscreen_explosion_quick" );
        common_scripts\_destructible::_ID9877( "tv_shot_burst" );
        common_scripts\_destructible::_ID9844( 20, 2000, 10, 10, 3, 3, undefined, 15 );
        common_scripts\_destructible::destructible_state( undefined, "ma_flatscreen_tv_" + var_1 + "broken_" + var_0, 200, undefined, "no_melee" );
    }
    else
    {
        common_scripts\_destructible::destructible_create( "toy_tv_flatscreen_" + var_1 + var_0 + "_sturdy", "tag_origin", 1, undefined, 1280 );
        common_scripts\_destructible::_ID9880( 0.5 );
        common_scripts\_destructible::_ID9851( "tag_fx", "fx/explosions/tv_flatscreen_explosion_cheap" );
        common_scripts\_destructible::_ID9877( "tv_shot_burst" );
        common_scripts\_destructible::_ID9844( 20, 2000, 10, 10, 3, 3, undefined, 15 );
        common_scripts\_destructible::destructible_state( undefined, "ma_flatscreen_tv_" + var_1 + "broken_" + var_0, 200, undefined, "no_melee" );
    }
}

_ID33239( var_0, var_1 )
{
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "blackice_tv" )
    {
        common_scripts\_destructible::destructible_create( "toy_" + var_0, "tag_origin", 1, undefined, 32 );
        common_scripts\_destructible::_ID9880( 1 );
        common_scripts\_destructible::_ID9851( "tag_fx", "fx/explosions/tv_flatscreen_explosion_quick" );
        common_scripts\_destructible::_ID9877( "tv_shot_burst" );
        common_scripts\_destructible::_ID9844( 20, 2000, 10, 10, 3, 3, undefined, 15 );
        common_scripts\_destructible::destructible_function( var_1 );
        common_scripts\_destructible::destructible_state( undefined, var_0 + "_d", 200, undefined, "no_melee" );
    }
    else
    {
        common_scripts\_destructible::destructible_create( "toy_" + var_0, "tag_origin", 1, undefined, 32 );
        common_scripts\_destructible::_ID9880( 1 );
        common_scripts\_destructible::_ID9851( "tag_fx", "fx/explosions/tv_flatscreen_explosion" );
        common_scripts\_destructible::_ID9877( "tv_shot_burst" );
        common_scripts\_destructible::_ID9844( 20, 2000, 10, 10, 3, 3, undefined, 15 );
        common_scripts\_destructible::destructible_function( var_1 );
        common_scripts\_destructible::destructible_state( undefined, var_0 + "_d", 200, undefined, "no_melee" );
    }
}

_ID26035()
{
    if ( isdefined( self.target ) )
    {
        var_0 = getentarray( self.target, "targetname" );

        if ( isdefined( var_0 ) )
        {
            foreach ( var_2 in var_0 )
            {
                if ( var_2.classname == "light_omni" || var_2.classname == "light_spot" )
                {
                    var_2 setlightintensity( 0 );
                    continue;
                }

                var_2 delete();
            }
        }
    }
}
