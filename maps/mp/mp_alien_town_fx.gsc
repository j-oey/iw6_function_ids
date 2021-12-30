// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    level._ID1644["pipe_sludge_far_lrg_splashes"] = loadfx( "vfx/moments/alien/pipe_sludge_far_lrg_splashes" );
    level._ID1644["pipe_sludge_far_lrg"] = loadfx( "vfx/moments/alien/pipe_sludge_far_lrg" );
    level._ID1644["fog_fall_mp_crater"] = loadfx( "fx/weather/fog_fall_mp_crater" );
    level._ID1644["vfx_alien_car_fire"] = loadfx( "vfx/ambient/fire/vfx_alien_car_fire" );
    level._ID1644["barrel_fire"] = loadfx( "fx/fire/firelp_barrel_pm_cheap" );
    level._ID1644["embers_burst_runner_cheap"] = loadfx( "vfx/moments/mp_warhawk/embers_burst_runner_cheap" );
    level._ID1644["ground_lodge_mist"] = loadfx( "fx/weather/ground_fog_mp_alien" );
    level._ID1644["ground_directional_mist"] = loadfx( "fx/weather/ground_fog_mp_alien_directional" );
    level._ID1644["light_insects"] = loadfx( "fx/misc/insects_light_complex_sparse" );
    level._ID1644["insects_ground"] = loadfx( "fx/misc/insects_firefly_a" );
    level._ID1644["lightning_storm"] = loadfx( "fx/weather/lightning_mp_alien" );
    level._ID1644["dust_falling"] = loadfx( "fx/misc/falling_dust_small_runner_mp" );
    level._ID1644["drip"] = loadfx( "fx/misc/drips_slow_10x10" );
    level._ID1644["leaves_falling_100"] = loadfx( "fx/misc/leaves_fall_gentlewind_green_100_mp" );
    level._ID1644["vfx_alien_mist_crater_idle"] = loadfx( "vfx/gameplay/alien/vfx_alien_mist_crater_idle" );
    level._ID1644["vfx/moments/alien/nuke_fail_screen_flash"] = loadfx( "vfx/moments/alien/nuke_fail_screen_flash" );
    thread _ID13766();
}

_ID13766()
{
    wait 1;
    var_0 = ( -9910, 6857, -2825 );
    level.fx_crater_plume = spawnfx( level._ID1644["vfx_alien_mist_crater_idle"], var_0, ( 0, 0, 1 ), ( 1, 0, 0 ) );
    triggerfx( level.fx_crater_plume, -15 );
}
