// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    level._ID1644["vfx_breach_metal"] = loadfx( "vfx/gameplay/mp/equipment/vfx_breach_metal_02" );
    level._ID1644["vfx_breach_wood"] = loadfx( "vfx/moments/mp_zulu/vfx_breach_wood_zulu" );
    level._ID1644["vfx_breach_concrete"] = loadfx( "fx/breakables/toy_concrete_barrier_02" );
    level._ID1644["vfx_death_smoke_runner"] = loadfx( "vfx/_requests/mp_zulu/vfx_death_smoke_runner" );
    level._ID1644["vfx_squadmate_spawn_burst"] = loadfx( "vfx/_requests/mp_zulu/vfx_squadmate_spawn_burst" );
    level._ID1644["vfx_mariachi_player_death"] = loadfx( "vfx/moments/mp_zulu/vfx_mariachi_player_death" );
    level._ID1644["vfx_scrnfx_spirit_vision"] = loadfx( "vfx/gameplay/screen_effects/vfx_scrnfx_spirit_vision" );
    level._ID1644["vfx_scrnfx_spirit_vision_split"] = loadfx( "vfx/gameplay/screen_effects/vfx_scrnfx_spirit_vision_split" );
    level._ID1644["vfx_zulu_paper_blow_runner"] = loadfx( "vfx/moments/mp_zulu/vfx_zulu_paper_blow_runner" );
    level._ID1644["vfx_godray_boneyard_ns"] = loadfx( "vfx/moments/mp_dome_ns/vfx_godray_boneyard_ns" );
    level._ID1644["vfx_bird_perch"] = loadfx( "vfx/ambient/animals/vfx_bird_flock_sparse_runner" );
    level._ID1644["vfx_godray_rr"] = loadfx( "vfx/moments/mp_redriver/vfx_godray_rr_02" );
    level._ID1644["vfx_leafs_fall_main"] = loadfx( "vfx/moments/nml/vfx_leafs_fall_main" );
    level._ID1644["insects_carcass_flies_sm"] = loadfx( "fx/misc/insects_carcass_flies_sm_02" );
    level._ID1644["vfx_dust_motes"] = loadfx( "vfx/ambient/atmospheric/vfx_dust_motes" );
    level._ID1644["vfx_smk_hanging_lrg"] = loadfx( "vfx/ambient/smoke/vfx_smk_hanging_lrg" );
    level._ID1644["vfx_trash_vortex_02"] = loadfx( "vfx/ambient/atmospheric/vfx_trash_vortex_02" );
    level._ID1644["vfx_chicken_feathers_float"] = loadfx( "vfx/ambient/animals/vfx_chicken_feathers_float" );
    level._ID1644["vfx_smk_hanging_sml"] = loadfx( "vfx/ambient/smoke/vfx_smk_hanging_sml" );
    level._ID1644["vfx_fire_candle"] = loadfx( "vfx/ambient/fire/vfx_fire_candle" );
    level._ID1644["vfx_crematorium_door_smk"] = loadfx( "vfx/moments/mp_zulu/vfx_crematorium_door_smk" );
    level._ID1644["vfx_tubebulb_glow"] = loadfx( "vfx/moments/mp_zulu/vfx_smoky_fluorescent_light_zulu" );
    level._ID1644["vfx_dimbulb_glow"] = loadfx( "vfx/moments/mp_zulu/vfx_white_light_cone_zulu" );
    level._ID1644["vfx_chimney_small"] = loadfx( "vfx/ambient/smoke/vfx_chimney_small" );
    level._ID1644["vfx_crematorium_innerglow"] = loadfx( "vfx/moments/mp_zulu/vfx_crematorium_innerglow" );
    level._ID1644["vfx_water_spout_splashes"] = loadfx( "vfx/ambient/water/vfx_water_spout_splashes" );
    level._ID1644["water_fountain_spout_02"] = loadfx( "fx/water/water_fountain_spout_02" );
    level._ID1644["flowers_blowing_petals"] = loadfx( "fx/misc/flowers_blowing_petals" );
    level._ID1644["heat_haze_mirage_02"] = loadfx( "fx/distortion/heat_haze_mirage_02" );
    level._ID1644["flowers_blowing_petals_dense"] = loadfx( "fx/misc/flowers_blowing_petals_dense" );
    thread load_custom_kem_fx();
}

load_custom_kem_fx()
{
    wait 2;
    level._ID1644["nuke_player"] = loadfx( "fx/explosions/player_death_nuke_bright" );
    level._ID1644["nuke_flash"] = loadfx( "fx/explosions/player_death_nuke_flash_bright" );
}
