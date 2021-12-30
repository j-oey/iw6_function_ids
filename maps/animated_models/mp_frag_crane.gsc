// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool
#using_animtree("animated_props");

_ID20445()
{
    if ( !isdefined( level.anim_prop_models ) )
        level.anim_prop_models = [];

    var_0 = "mp_frag_crane_anim";

    if ( common_scripts\utility::_ID18787() )
        level.anim_prop_models[var_0]["idle"] = %mp_frag_crane_sway;
    else
        level.anim_prop_models[var_0]["idle"] = "mp_frag_crane_sway";
}
