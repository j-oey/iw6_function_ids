// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

createhordecrates( var_0, var_1 )
{
    level.getrandomcratetypeforgamemode = ::_ID15289;
    level._ID17074["ammo"] = "specialty_ammo_crate";
    level._ID17074["iw6_mts255_mp_barrelrange03_reflexshotgun"] = "hud_icon_mts255";
    level._ID17074["iw6_fp6_mp_barrelrange03_reflexshotgun"] = "hud_icon_fp6";
    level._ID17074["iw6_vepr_mp_grip"] = "hud_icon_vepr";
    level._ID17074["iw6_microtar_mp_eotechsmg"] = "hud_icon_microtar";
    level._ID17074["iw6_ak12_mp_flashsuppress_grip"] = "hud_icon_ak12";
    level._ID17074["iw6_arx160_mp_flashsuppress_hybrid"] = "hud_icon_arx160";
    level._ID17074["iw6_m27_mp_flashsuppress_hybrid"] = "hud_icon_m27";
    level._ID17074["iw6_kac_mp_flashsuppress"] = "hud_icon_kac";
    level._ID17074["iw6_usr_mp_usrvzscope_xmags"] = "hud_icon_usr";
    level._ID17074["iw6_magnumhorde_mp_fmj"] = "hud_icon_magnum";
    level._ID17074["throwingknife_mp"] = "throw_knife_sm";
    level._ID17074["specialty_lightweight"] = "icon_perks_agility";
    level._ID17074["specialty_fastreload"] = "icon_perks_sleight_of_hand";
    level._ID17074["specialty_quickdraw"] = "icon_perks_quickdraw";
    level._ID17074["specialty_marathon"] = "icon_perks_marathon";
    level._ID17074["specialty_quickswap"] = "icon_perks_reflex";
    level._ID17074["specialty_bulletaccuracy"] = "icon_perks_steady_aim";
    level._ID17074["specialty_fastsprintrecovery"] = "icon_perks_ready_up";
    level._ID17074["_specialty_blastshield"] = "icon_perks_blast_shield";
    level._ID17074["specialty_stalker"] = "icon_perks_stalker";
    level._ID17074["specialty_sharp_focus"] = "icon_perks_focus";
    level._ID17074["specialty_regenfaster"] = "icon_perks_icu";
    level._ID17074["specialty_sprintreload"] = "icon_perks_on_the_go";
    level._ID17074["specialty_triggerhappy"] = "icon_perks_triggerhappy";
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "iw6_mts255_mp_barrelrange03_reflexshotgun", 12, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_MTS" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "iw6_fp6_mp_barrelrange03_reflexshotgun", 12, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_FP6" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "iw6_vepr_mp_grip", 12, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_VEPR" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "iw6_microtar_mp_eotechsmg", 12, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_MICRO" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "iw6_ak12_mp_flashsuppress_grip", 0, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_AK" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "iw6_arx160_mp_flashsuppress_hybrid", 0, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_ARX" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "iw6_m27_mp_flashsuppress_hybrid", 0, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_M27" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "iw6_kac_mp_flashsuppress", 0, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_KAC" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "iw6_usr_mp_usrvzscope_xmags", 12, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_USR" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "iw6_magnumhorde_mp_fmj", 0, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_WEST" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "throwingknife_mp", 3, ::_ID17066, var_0, var_1, &"HORDE_DOUBLE_TAP_KNIFE" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "specialty_lightweight", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_LIGHT" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "specialty_fastreload", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_FAST" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "specialty_quickdraw", 10, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_QIUCK" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "specialty_marathon", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_MARA" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "specialty_quickswap", 10, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_SWAP" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "specialty_bulletaccuracy", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_AIM" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "specialty_fastsprintrecovery", 7, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_READY" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "_specialty_blastshield", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_BLAST" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "specialty_stalker", 10, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_STALK" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "specialty_sharp_focus", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_FOCUS" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "specialty_regenfaster", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_HEALTH" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "specialty_sprintreload", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_GO" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "specialty_triggerhappy", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_TRIGGER" );
    maps\mp\killstreaks\_airdrop::addcratetype( "a", "ammo", 0, ::_ID17065, var_0, var_1, &"HORDE_AMMO" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "iw6_mts255_mp_barrelrange03_reflexshotgun", 5, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_MTS" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "iw6_fp6_mp_barrelrange03_reflexshotgun", 5, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_FP6" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "iw6_vepr_mp_grip", 10, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_VEPR" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "iw6_microtar_mp_eotechsmg", 10, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_MICRO" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "iw6_ak12_mp_flashsuppress_grip", 10, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_AK" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "iw6_arx160_mp_flashsuppress_hybrid", 10, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_ARX" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "iw6_m27_mp_flashsuppress_hybrid", 0, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_M27" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "iw6_kac_mp_flashsuppress", 0, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_KAC" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "iw6_usr_mp_usrvzscope_xmags", 10, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_USR" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "iw6_magnumhorde_mp_fmj", 0, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_WEST" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "throwingknife_mp", 3, ::_ID17066, var_0, var_1, &"HORDE_DOUBLE_TAP_KNIFE" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "specialty_lightweight", 10, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_LIGHT" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "specialty_fastreload", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_FAST" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "specialty_quickdraw", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_QIUCK" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "specialty_marathon", 10, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_MARA" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "specialty_quickswap", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_SWAP" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "specialty_bulletaccuracy", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_AIM" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "specialty_fastsprintrecovery", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_READY" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "_specialty_blastshield", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_BLAST" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "specialty_stalker", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_STALK" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "specialty_sharp_focus", 7, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_FOCUS" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "specialty_regenfaster", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_HEALTH" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "specialty_sprintreload", 10, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_GO" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "specialty_triggerhappy", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_TRIGGER" );
    maps\mp\killstreaks\_airdrop::addcratetype( "b", "ammo", 0, ::_ID17065, var_0, var_1, &"HORDE_AMMO" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "iw6_mts255_mp_barrelrange03_reflexshotgun", 5, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_MTS" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "iw6_fp6_mp_barrelrange03_reflexshotgun", 5, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_FP6" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "iw6_vepr_mp_grip", 5, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_VEPR" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "iw6_microtar_mp_eotechsmg", 5, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_MICRO" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "iw6_ak12_mp_flashsuppress_grip", 12, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_AK" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "iw6_arx160_mp_flashsuppress_hybrid", 12, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_ARX" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "iw6_m27_mp_flashsuppress_hybrid", 0, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_M27" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "iw6_kac_mp_flashsuppress", 0, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_KAC" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "iw6_usr_mp_usrvzscope_xmags", 6, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_USR" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "iw6_magnumhorde_mp_fmj", 0, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_WEST" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "throwingknife_mp", 2, ::_ID17066, var_0, var_1, &"HORDE_DOUBLE_TAP_KNIFE" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "specialty_lightweight", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_LIGHT" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "specialty_fastreload", 12, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_FAST" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "specialty_quickdraw", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_QIUCK" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "specialty_marathon", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_MARA" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "specialty_quickswap", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_SWAP" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "specialty_bulletaccuracy", 12, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_AIM" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "specialty_fastsprintrecovery", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_READY" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "_specialty_blastshield", 12, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_BLAST" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "specialty_stalker", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_STALK" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "specialty_sharp_focus", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_FOCUS" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "specialty_regenfaster", 12, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_HEALTH" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "specialty_sprintreload", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_GO" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "specialty_triggerhappy", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_TRIGGER" );
    maps\mp\killstreaks\_airdrop::addcratetype( "c", "ammo", 0, ::_ID17065, var_0, var_1, &"HORDE_AMMO" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "iw6_mts255_mp_barrelrange03_reflexshotgun", 5, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_MTS" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "iw6_fp6_mp_barrelrange03_reflexshotgun", 5, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_FP6" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "iw6_vepr_mp_grip", 5, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_VEPR" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "iw6_microtar_mp_eotechsmg", 5, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_MICRO" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "iw6_ak12_mp_flashsuppress_grip", 5, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_AK" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "iw6_arx160_mp_flashsuppress_hybrid", 5, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_ARX" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "iw6_m27_mp_flashsuppress_hybrid", 10, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_M27" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "iw6_kac_mp_flashsuppress", 10, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_KAC" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "iw6_usr_mp_usrvzscope_xmags", 5, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_USR" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "iw6_magnumhorde_mp_fmj", 0, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_WEST" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "throwingknife_mp", 2, ::_ID17066, var_0, var_1, &"HORDE_DOUBLE_TAP_KNIFE" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "specialty_lightweight", 3, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_LIGHT" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "specialty_fastreload", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_FAST" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "specialty_quickdraw", 3, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_QIUCK" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "specialty_marathon", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_MARA" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "specialty_quickswap", 3, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_SWAP" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "specialty_bulletaccuracy", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_AIM" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "specialty_fastsprintrecovery", 3, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_READY" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "_specialty_blastshield", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_BLAST" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "specialty_stalker", 3, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_STALK" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "specialty_sharp_focus", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_FOCUS" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "specialty_regenfaster", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_HEALTH" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "specialty_sprintreload", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_GO" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "specialty_triggerhappy", 0, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_TRIGGER" );
    maps\mp\killstreaks\_airdrop::addcratetype( "d", "ammo", 0, ::_ID17065, var_0, var_1, &"HORDE_AMMO" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "iw6_mts255_mp_barrelrange03_reflexshotgun", 4, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_MTS" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "iw6_fp6_mp_barrelrange03_reflexshotgun", 4, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_FP6" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "iw6_vepr_mp_grip", 4, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_VEPR" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "iw6_microtar_mp_eotechsmg", 4, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_MICRO" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "iw6_ak12_mp_flashsuppress_grip", 4, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_AK" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "iw6_arx160_mp_flashsuppress_hybrid", 4, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_ARX" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "iw6_m27_mp_flashsuppress_hybrid", 9, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_M27" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "iw6_kac_mp_flashsuppress", 9, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_KAC" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "iw6_usr_mp_usrvzscope_xmags", 5, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_USR" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "iw6_magnumhorde_mp_fmj", 3, ::hordecrateweaponthink, var_0, var_1, &"HORDE_DOUBLE_TAP_WEST" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "throwingknife_mp", 2, ::_ID17066, var_0, var_1, &"HORDE_DOUBLE_TAP_KNIFE" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "specialty_lightweight", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_LIGHT" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "specialty_fastreload", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_FAST" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "specialty_quickdraw", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_QIUCK" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "specialty_marathon", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_MARA" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "specialty_quickswap", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_SWAP" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "specialty_bulletaccuracy", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_AIM" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "specialty_fastsprintrecovery", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_READY" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "_specialty_blastshield", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_BLAST" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "specialty_stalker", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_STALK" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "specialty_sharp_focus", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_FOCUS" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "specialty_regenfaster", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_HEALTH" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "specialty_sprintreload", 4, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_GO" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "specialty_triggerhappy", 3, ::hordecrateperkthink, var_0, var_1, &"HORDE_DOUBLE_TAP_TRIGGER" );
    maps\mp\killstreaks\_airdrop::addcratetype( "e", "ammo", 0, ::_ID17065, var_0, var_1, &"HORDE_AMMO" );
    _ID29182( var_0, var_1 );
}

_ID29182( var_0, var_1 )
{
    maps\mp\killstreaks\_airdrop::addcratetype( "loot", "ims", 15, ::_ID19254, var_0, var_1, &"KILLSTREAKS_HINTS_IMS_PICKUP" );
    maps\mp\killstreaks\_airdrop::addcratetype( "loot", "helicopter", 15, ::_ID19254, var_0, var_1, &"KILLSTREAKS_HINTS_HELICOPTER_PICKUP" );
    maps\mp\killstreaks\_airdrop::addcratetype( "loot", "drone_hive", 15, ::_ID19254, var_0, var_1, &"KILLSTREAKS_HINTS_DRONE_HIVE_PICKUP" );
    maps\mp\killstreaks\_airdrop::addcratetype( "loot", "sentry", 15, ::_ID19254, var_0, var_1, &"KILLSTREAKS_HINTS_SENTRY_PICKUP" );
    maps\mp\killstreaks\_airdrop::addcratetype( "loot", "heli_sniper", 15, ::_ID19254, var_0, var_1, &"KILLSTREAKS_HINTS_HELI_SNIPER_PICKUP" );
    maps\mp\killstreaks\_airdrop::addcratetype( "loot", "ball_drone_backup", 15, ::_ID19254, var_0, var_1, &"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP" );
}

hordecrateweaponthink( var_0 )
{
    self endon( "death" );
    self endon( "doubleTap" );
    self endon( "restarting_physics" );

    if ( !isdefined( self.doubletapcount ) )
        self.doubletapcount = 0;

    var_1 = game["strings"][self.cratetype + "_hint"];
    thread doubletapthink();
    maps\mp\killstreaks\_airdrop::cratesetupforuse( var_1, level._ID17074[self.cratetype] );
    thread _ID8249( 1000 );
    _ID28687( self );
    level thread _ID26019( self );

    for (;;)
    {
        self waittill( "captured",  var_2  );
        _ID33791( var_2, self.cratetype );
        maps\mp\killstreaks\_airdrop::deletecrate();
    }
}

_ID33791( var_0, var_1 )
{
    var_0 playlocalsound( "ammo_crate_use" );
    var_2 = [];
    var_3 = var_0 getweaponslistprimaries();
    var_4 = getweaponbasename( var_1 );

    foreach ( var_6 in var_3 )
    {
        if ( var_6 == level.intelminigun )
            continue;

        var_2[var_2.size] = var_6;
    }

    if ( var_2.size > 1 )
    {
        var_8 = 1;

        foreach ( var_10 in var_2 )
        {
            if ( var_1 == var_10 )
                var_8 = 0;
        }

        if ( var_8 )
        {
            var_12 = var_0 getcurrentprimaryweapon();

            if ( var_12 == "none" )
                var_12 = var_0 common_scripts\utility::_ID15114();

            if ( !var_0 hasweapon( var_12 ) || var_12 == level.intelminigun )
                var_12 = var_0 maps\mp\killstreaks\_killstreaks::_ID15018();

            var_0 takeweapon( var_12 );
        }
        else
        {
            var_0 givemaxammo( var_1 );
            var_13 = var_0._ID36291[var_4]["barSize"];
            var_0._ID36291[var_4]["vaule"] = var_13;
            var_0 notify( "weaponPointsEarned" );
        }
    }

    maps\mp\gametypes\horde::_ID8442( var_0, var_4, 1 );
    var_0 maps\mp\_utility::_giveweapon( var_1 );
    var_0 switchtoweaponimmediate( var_1 );
}

hordecrateperkthink( var_0 )
{
    self endon( "death" );
    self endon( "doubleTap" );
    self endon( "restarting_physics" );

    if ( !isdefined( self.doubletapcount ) )
        self.doubletapcount = 0;

    var_1 = game["strings"][self.cratetype + "_hint"];
    thread doubletapthink();
    maps\mp\killstreaks\_airdrop::cratesetupforuse( var_1, level._ID17074[self.cratetype] );
    thread _ID8249( 1000 );
    _ID28687( self );
    level thread _ID26019( self );

    for (;;)
    {
        self waittill( "captured",  var_2  );
        var_2 playlocalsound( "ammo_crate_use" );

        if ( !var_2 maps\mp\_utility::_hasperk( self.cratetype ) )
        {
            var_3 = self.cratetype;
            var_2 maps\mp\_utility::_ID15611( var_3, 0 );
            var_4 = tablelookup( "mp/hordeIcons.csv", 1, var_3, 0 );
            var_2 setclientomnvar( "ui_horde_update_perk", int( var_4 ) );
            var_5 = var_2._ID17063.size;
            var_2._ID17063[var_5]["name"] = var_3;
            var_2._ID17063[var_5]["index"] = int( var_4 );
        }

        maps\mp\killstreaks\_airdrop::deletecrate();
    }
}

_ID17066( var_0 )
{
    self endon( "death" );
    self endon( "doubleTap" );
    self endon( "restarting_physics" );

    if ( !isdefined( self.doubletapcount ) )
        self.doubletapcount = 0;

    var_1 = game["strings"][self.cratetype + "_hint"];
    thread doubletapthink();
    maps\mp\killstreaks\_airdrop::cratesetupforuse( var_1, level._ID17074[self.cratetype] );
    thread _ID8249( 1000 );
    _ID28687( self );
    level thread _ID26019( self );

    for (;;)
    {
        self waittill( "captured",  var_2  );
        var_2 playlocalsound( "ammo_crate_use" );

        if ( !var_2 hasweapon( self.cratetype ) )
        {
            var_3 = var_2 getcurrentoffhand();
            var_2 takeweapon( var_3 );
            var_2 maps\mp\_utility::giveperkequipment( self.cratetype, 1 );
        }
        else
            var_2 givemaxammo( self.cratetype );

        maps\mp\killstreaks\_airdrop::deletecrate();
    }
}

_ID17065( var_0 )
{
    self endon( "death" );
    self endon( "restarting_physics" );
    var_1 = game["strings"][self.cratetype + "_hint"];
    maps\mp\killstreaks\_airdrop::cratesetupforuse( var_1, level._ID17074[self.cratetype] );
    thread _ID8249( 2000 );
    self.friendlymodel hudoutlineenable( 5, 0 );
    self.outlinecolor = 5;
    level thread _ID26019( self );

    for (;;)
    {
        self waittill( "captured",  var_2  );
        var_2 playlocalsound( "ammo_crate_use" );
        level thread maps\mp\gametypes\_horde_util::_ID37864( var_2 );
        maps\mp\killstreaks\_airdrop::deletecrate();
    }
}

_ID19254( var_0 )
{
    self endon( "death" );
    self endon( "restarting_physics" );
    var_1 = game["strings"][self.cratetype + "_hint"];
    maps\mp\killstreaks\_airdrop::cratesetupforuse( var_1, maps\mp\_utility::getkillstreakoverheadicon( self.cratetype ) );
    thread _ID8249( 2000 );
    _ID28686( self, 3, ( 0.157, 0.784, 0.784 ) );

    for (;;)
    {
        self waittill( "captured",  var_2  );

        if ( !isplayer( var_2 ) )
            continue;

        var_3 = _ID15336( var_2 );

        if ( !isdefined( var_3 ) )
            continue;

        var_2 playlocalsound( "ammo_crate_use" );
        var_2 thread maps\mp\killstreaks\_killstreaks::_ID15602( self.cratetype, 0, 0, self.owner, var_3 );
        maps\mp\killstreaks\_airdrop::deletecrate();
    }
}

_ID15336( var_0 )
{
    var_1 = undefined;

    for ( var_2 = 1; var_2 < 4; var_2++ )
    {
        var_3 = var_0.pers["killstreaks"][var_2];

        if ( !isdefined( var_3 ) || !isdefined( var_3._ID31889 ) || var_3.available == 0 )
        {
            var_1 = var_2;
            break;
        }
    }

    return var_1;
}

_ID8249( var_0 )
{
    self endon( "doubleTap" );
    self endon( "restarting_physics" );

    if ( !isdefined( var_0 ) )
        var_0 = 500;

    while ( isdefined( self ) )
    {
        self makeusable();
        self waittill( "trigger",  var_1  );

        if ( _ID16235( var_1 ) )
            continue;

        if ( _ID16261( var_1 ) )
            continue;

        if ( !maps\mp\killstreaks\_airdrop::_ID34838( var_1 ) )
            continue;

        self makeunusable();
        var_1.iscapturingcrate = 1;

        if ( !maps\mp\killstreaks\_airdrop::_ID34751( var_1, var_0 ) )
        {
            var_1.iscapturingcrate = 0;
            continue;
        }

        var_1.iscapturingcrate = 0;
        maps\mp\gametypes\_horde_util::_ID36754( var_1 );
        self notify( "captured",  var_1  );
    }
}

_ID16261( var_0 )
{
    if ( self.droptype == "loot" && !isdefined( _ID15336( var_0 ) ) )
    {
        var_0 setclientomnvar( "ui_killstreak_limit", 1 );
        return 1;
    }

    return 0;
}

_ID16235( var_0 )
{
    if ( !isplayer( var_0 ) )
    {
        if ( isdefined( var_0._ID10169 ) )
            var_0._ID10169 enableplayeruse( var_0 );

        var_0._ID10169 = self;
        self disableplayeruse( var_0 );
        return 1;
    }

    return 0;
}

_ID21377( var_0 )
{
    var_0 endon( "disconnect" );
    var_1 = 0;

    for (;;)
    {
        if ( var_0 usebuttonpressed() )
        {
            var_1 = 0;

            while ( var_0 usebuttonpressed() )
            {
                var_1 += 0.05;
                wait 0.05;
            }

            if ( var_1 >= 0.5 )
                continue;

            var_1 = 0;

            while ( !var_0 usebuttonpressed() && var_1 < 0.5 )
            {
                var_1 += 0.05;
                wait 0.05;
            }

            if ( var_1 >= 0.5 )
                continue;

            level notify( "doubleTap",  var_0  );
        }

        wait 0.05;
    }
}

doubletapthink()
{
    self endon( "death" );
    self endon( "capture" );
    self endon( "restarting_physics" );
    var_0 = 16384;

    if ( self.doubletapcount > 0 )
        wait 1.0;

    for (;;)
    {
        level waittill( "doubleTap",  var_1  );

        if ( maps\mp\gametypes\_horde_util::_ID18740( var_1 ) )
            continue;

        if ( !maps\mp\_utility::_ID18757( var_1 ) )
            continue;

        if ( isdefined( self._ID18318 ) && self._ID18318 )
            continue;

        if ( distance2dsquared( var_1.origin, self.origin ) < var_0 )
        {
            self notify( "doubleTap" );
            newrandomcrate();
            break;
        }
    }
}

newrandomcrate()
{
    self.doubletapcount++;
    playsoundatpos( self.origin, "mp_killconfirm_tags_drop" );

    if ( self.doubletapcount > 1 )
        var_0 = "ammo";
    else
    {
        var_1 = level.cratetypes[self.droptype][self.cratetype]._ID25497;
        maps\mp\killstreaks\_airdrop::changecrateweight( self.droptype, self.cratetype, 0 );
        var_0 = _ID15289( self.droptype );
        maps\mp\killstreaks\_airdrop::changecrateweight( self.droptype, self.cratetype, var_1 );
    }

    self.cratetype = var_0;
    self thread [[ level.cratetypes[self.droptype][self.cratetype].func ]]( self.droptype );
}

_ID27024()
{
    var_0 = "loot";
    var_1 = 8;
    var_2 = randomint( level.cratetypes["loot"].size );
    var_3 = ( 0, 0, 75 );

    if ( !level._ID6711.size )
        maps\mp\gametypes\horde::_ID30456();

    for ( var_4 = 0; var_4 < var_1; var_4++ )
    {
        var_5 = level.hordedroplocations[level._ID11088];
        var_6 = _ID15017( var_5._ID33250 );

        if ( !isdefined( var_6 ) )
        {
            level._ID11088 = maps\mp\gametypes\horde::_ID15166( level._ID11088 );
            continue;
        }

        var_7 = var_6;
        var_8 = _ID14950( var_2 + var_4 );
        var_9 = level.players[0] maps\mp\killstreaks\_airdrop::createairdropcrate( level.players[0], var_0, var_8, var_7 + var_3, var_7, 3 );
        var_9.angles = ( 0, 0, 0 );
        var_9.droppingtoground = 1;
        var_9.friendlymodel hide();
        wait 0.05;
        var_9 thread maps\mp\killstreaks\_airdrop::_ID35554( var_9, ( randomint( 25 ), randomint( 25 ), randomint( 25 ) ), var_0, var_8, 800, 1 );
        level thread _ID25977( var_9 );
        level._ID11088 = maps\mp\gametypes\horde::_ID15166( level._ID11088 );
        wait 0.05;
        playfx( level._ID1644["crate_teleport"], var_9.origin, ( 0, 0, 1 ) );
        playsoundatpos( var_9.origin, "crate_teleport_safeguard" );
        var_9.friendlymodel show();
    }
}

_ID20372( var_0 )
{
    var_0 waittill( "physics_finished" );
    var_1 = spawnfx( level._ID1644["loot_crtae"], var_0.origin - ( 0, 0, 16 ) );
    triggerfx( var_1 );
    var_0 common_scripts\utility::_ID35638( level._ID30964, "death" );
    var_1 delete();
}

_ID15017( var_0 )
{
    if ( !_ID18741( var_0 ) )
        return var_0;

    var_1 = getnodesinradiussorted( var_0, 256, 64, 128, "Path" );

    foreach ( var_3 in var_1 )
    {
        if ( !_ID18741( var_3.origin ) )
            return var_3.origin;
    }

    return undefined;
}

_ID18741( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in level._ID23303 )
    {
        var_4 = distance2dsquared( var_3.origin, var_0 );

        if ( var_4 < 4096 )
        {
            var_1 = 1;
            break;
        }
    }

    return var_1;
}

_ID14950( var_0 )
{
    while ( var_0 >= level.cratetypes["loot"].size )
        var_0 -= level.cratetypes["loot"].size;

    var_1 = getarraykeys( level.cratetypes["loot"] );
    var_2 = level.cratetypes["loot"][var_1[var_0]].type;
    return var_2;
}

_ID26019( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "doubleTap" );
    var_0 endon( "restarting_physics" );
    level waittill( "airSupport" );

    while ( isdefined( var_0._ID18318 ) && var_0._ID18318 )
        common_scripts\utility::_ID35582();

    var_0 maps\mp\killstreaks\_airdrop::deletecrate();
}

_ID25977( var_0 )
{
    var_0 endon( "death" );
    level waittill( "round_ended" );

    while ( isdefined( var_0._ID18318 ) && var_0._ID18318 )
        common_scripts\utility::_ID35582();

    var_0 maps\mp\killstreaks\_airdrop::deletecrate();
}

_ID15289( var_0 )
{
    var_1 = _ID15196();
    var_2 = randomint( level._ID8252[var_0] );
    var_3 = undefined;

    foreach ( var_5 in level.cratetypes[var_0] )
    {
        var_6 = var_5.type;

        if ( !level.cratetypes[var_0][var_6]._ID36301 )
            continue;

        if ( !canpickcrate( var_6, var_1 ) )
            continue;

        var_3 = var_6;

        if ( level.cratetypes[var_0][var_6]._ID36301 > var_2 )
            break;
    }

    return var_3;
}

_ID15196()
{
    var_0 = 0;

    foreach ( var_2 in level.players )
    {
        if ( !maps\mp\gametypes\_horde_util::isonhumanteam( var_2 ) )
            continue;

        if ( var_2 hasweapon( "iw6_magnumhorde_mp_fmj" ) )
            var_0++;

        if ( var_2 maps\mp\_utility::_hasperk( "specialty_triggerhappy" ) )
            var_0++;
    }

    var_4 = getentarray( "care_package", "targetname" );

    foreach ( var_6 in var_4 )
    {
        if ( var_6.cratetype == "iw6_magnumhorde_mp_fmj" )
            var_0++;

        if ( var_6.cratetype == "specialty_triggerhappy" )
            var_0++;
    }

    return var_0;
}

_ID18746( var_0 )
{
    return var_0 == "iw6_magnumhorde_mp_fmj" || var_0 == "specialty_triggerhappy";
}

canpickcrate( var_0, var_1 )
{
    if ( _ID18746( var_0 ) && var_1 >= 2 )
        return 0;

    return 1;
}

_ID28686( var_0, var_1, var_2 )
{
    var_0.friendlymodel hudoutlineenable( var_1, 0 );
    var_0.outlinecolor = var_1;

    foreach ( var_4 in var_0._ID12149 )
        var_4.color = var_2;
}

_ID28687( var_0 )
{
    if ( var_0.doubletapcount == 0 )
    {
        _ID28686( var_0, 2, ( 0.431, 0.745, 0.235 ) );
        return;
    }

    _ID28686( var_0, 5, ( 0.804, 0.804, 0.035 ) );
    return;
}
