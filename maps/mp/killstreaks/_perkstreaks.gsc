// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["specialty_fastsprintrecovery_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_fastreload_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_lightweight_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_marathon_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_stalker_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_reducedsway_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_quickswap_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_pitcher_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_bulletaccuracy_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_quickdraw_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_sprintreload_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_silentkill_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_blindeye_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_gpsjammer_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_quieter_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_incog_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_paint_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_scavenger_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_detectexplosive_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_selectivehearing_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_comexp_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_falldamage_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_regenfaster_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_sharp_focus_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_stun_resistance_ks"] = ::tryuseperkstreak;
    level._ID19256["_specialty_blastshield_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_gunsmith_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_extraammo_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_extra_equipment_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_extra_deadly_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_extra_attachment_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_explosivedamage_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_gambler_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_hardline_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_twoprimaries_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_boom_ks"] = ::tryuseperkstreak;
    level._ID19256["specialty_deadeye_ks"] = ::tryuseperkstreak;
    level._ID19256["all_perks_bonus"] = ::_ID33833;
    level._ID19256["speed_boost"] = ::_ID33876;
    level._ID19256["refill_grenades"] = ::_ID33866;
    level._ID19256["refill_ammo"] = ::tryuserefillammo;
    level._ID19256["regen_faster"] = ::_ID33867;
}

_ID33876( var_0, var_1 )
{
    _ID10594( "specialty_juiced", "speed_boost" );
    return 1;
}

_ID33866( var_0, var_1 )
{
    _ID10594( "specialty_refill_grenades", "refill_grenades" );
    return 1;
}

tryuserefillammo( var_0, var_1 )
{
    _ID10594( "specialty_refill_ammo", "refill_ammo" );
    return 1;
}

_ID33867( var_0, var_1 )
{
    _ID10594( "specialty_regenfaster", "regen_faster" );
    return 1;
}

_ID33833( var_0, var_1 )
{
    return 1;
}

tryuseperkstreak( var_0, var_1 )
{
    var_2 = maps\mp\_utility::_ID31978( var_1, "_ks" );
    _ID10756( var_2 );
    return 1;
}

_ID10756( var_0 )
{
    maps\mp\_utility::_ID15611( var_0, 0 );
    thread _ID36054( var_0 );
    thread checkforperkupgrade( var_0 );

    if ( var_0 == "specialty_hardline" )
        maps\mp\killstreaks\_killstreaks::setstreakcounttonext();

    maps\mp\_matchdata::_ID20253( var_0 + "_ks", self.origin );
}

_ID10594( var_0, var_1 )
{
    maps\mp\_utility::_ID15611( var_0, 0 );

    if ( isdefined( var_1 ) )
        maps\mp\_matchdata::_ID20253( var_1, self.origin );
}

_ID36054( var_0 )
{
    self endon( "disconnect" );
    self waittill( "death" );
    maps\mp\_utility::_unsetperk( var_0 );
}

checkforperkupgrade( var_0 )
{
    var_1 = maps\mp\gametypes\_class::getperkupgrade( var_0 );

    if ( var_1 != "specialty_null" )
    {
        maps\mp\_utility::_ID15611( var_1, 0 );
        thread _ID36054( var_1 );
    }
}

isperkstreakon( var_0 )
{
    for ( var_1 = 1; var_1 < 4; var_1++ )
    {
        if ( isdefined( self.pers["killstreaks"][var_1]._ID31889 ) && self.pers["killstreaks"][var_1]._ID31889 == var_0 )
        {
            if ( self.pers["killstreaks"][var_1].available )
                return 1;
        }
    }

    return 0;
}
