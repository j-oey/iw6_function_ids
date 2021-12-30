// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_zebra_precache::_ID20445();
    maps\createart\mp_zebra_art::_ID20445();
    maps\mp\mp_zebra_fx::_ID20445();
    maps\mp\_load::_ID20445();
    maps\mp\_compass::_ID29184( "compass_map_mp_zebra" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 1.7, 10 );
    setdvar( "r_reactiveMotionWindAmplitudeScale", 1 );
    setdvar( "r_reactiveMotionWindAreaScale", 10 );
    setdvar( "r_reactiveMotionWindDir", ( 0.3, -1, 0.3 ) );
    setdvar( "r_reactiveMotionWindFrequencyScale", 1 );
    setdvar( "r_reactiveMotionWindStrength", 20 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    _ID38175();
    maps\mp\gametypes\_door::_ID10725( "door_switch" );
}

_ID38175()
{
    var_0 = [ "slide_door", "garage_door" ];

    foreach ( var_2 in var_0 )
    {
        var_3 = getentarray( var_2, "targetname" );

        foreach ( var_5 in var_3 )
        {
            if ( isdefined( var_5.classname ) && var_5.classname == "trigger_multiple" )
            {
                if ( isdefined( var_5._ID27766 ) && issubstr( var_5._ID27766, "prone_only=true" ) )
                    continue;

                if ( var_2 == "slide_door" )
                {
                    var_5.origin = ( var_5.origin[0] + 4, var_5.origin[1], var_5.origin[2] );
                    continue;
                }

                if ( var_2 == "garage_door" )
                    var_5.origin = ( var_5.origin[0] - 8.5, var_5.origin[1], var_5.origin[2] );
            }
        }
    }
}
