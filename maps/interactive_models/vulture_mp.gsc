// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

vulture_circling( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( !isdefined( level._interactive ) )
        level._interactive = [];

    if ( !isdefined( level._interactive["vultures"] ) )
    {
        level._interactive["vultures"]["count"] = 0;
        level._interactive["vultures"]["anims"][0] = "vulture_rig_circle";
        level._interactive["vultures"]["anims"][1] = "vulture_rig_circle2";
        level._interactive["vultures"]["anims"][2] = "vulture_rig_circle3";
        level._interactive["vultures"]["rigs"] = [];
        level._interactive["vultures"]["vultures"] = [];
    }

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        var_3 = var_0 + ( 0, 0, 50 ) * var_2;

        if ( var_2 > 0 )
            var_3 += ( 0, 0, randomintrange( -20, 20 ) );

        thread vulture_circling_internal( var_3 );
    }
}

vulture_circling_internal( var_0 )
{
    var_1 = level._interactive["vultures"]["rigs"].size;
    var_2 = randomint( 360 );
    var_3 = spawn( "script_model", var_0 );
    var_3.angles = ( 0, var_2, 0 );
    var_3 setmodel( "vulture_circle_rig" );
    var_4 = spawn( "script_model", var_3.origin );
    var_4.angles = ( 0, var_2, 0 );
    var_4 setmodel( "ng_vulture" );
    var_4 linkto( var_3, "tag_attach" );
    var_5 = level._interactive["vultures"]["anims"][common_scripts\utility::mod( var_1, 3 )];
    var_3 scriptmodelplayanim( var_5 );
    level._interactive["vultures"]["vultures"][var_1] = var_4;
    level._interactive["vultures"]["rigs"][var_1] = var_3;
    var_4 endon( "death" );
    wait(randomfloat( 5 ));
    var_4 scriptmodelplayanim( "vulture_fly_loop_all" );
}
