// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool
#using_animtree("animated_props");

_ID20445()
{
    if ( !isdefined( level.anim_prop_models ) )
        level.anim_prop_models = [];

    var_0 = "clothes_line_tank_iw6";

    if ( common_scripts\utility::_ID18787() )
        level.anim_prop_models[var_0]["wind_medium"] = %hanging_clothes_apron_wind_medium;
    else
        level.anim_prop_models[var_0]["wind_medium"] = "hanging_clothes_apron_wind_medium";
}
