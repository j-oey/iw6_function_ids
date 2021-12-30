// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool
#using_animtree("animated_props");

_ID20445()
{
    if ( !isdefined( level.anim_prop_models ) )
        level.anim_prop_models = [];

    var_0 = "foliage_pacific_bushtree01_animated";

    if ( common_scripts\utility::_ID18787() )
        level.anim_prop_models[var_0]["sway"] = %foliage_pacific_bushtree01_sway;
    else
        level.anim_prop_models[var_0]["sway"] = "foliage_pacific_bushtree01_sway";
}
