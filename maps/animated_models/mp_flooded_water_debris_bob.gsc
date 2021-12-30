// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool
#using_animtree("animated_props");

_ID20445()
{
    if ( !isdefined( level.anim_prop_models ) )
        level.anim_prop_models = [];

    var_0 = tolower( getdvar( "mapname" ) );
    var_1 = 1;

    if ( common_scripts\utility::string_starts_with( var_0, "mp_" ) )
        var_1 = 0;

    var_2 = "debris_water_trash";

    if ( var_1 )
        level.anim_prop_models[var_2]["debris_water_trash"] = %debris_water_trash_bob_anim;
    else
        level.anim_prop_models[var_2]["debris_water_trash"] = "debris_water_trash_bob_anim";
}
