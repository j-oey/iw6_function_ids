// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID15614( var_0, var_1 )
{
    var_1 = common_scripts\utility::_ID32831( isdefined( var_1 ), var_1, 1 );

    foreach ( var_3 in var_0 )
    {
        if ( var_1 )
            var_3 = maps\mp\perks\_perks::_ID34839( var_3 );

        maps\mp\_utility::_ID15611( var_3, 0 );
    }
}

_ID15630( var_0 )
{
    var_1 = [];

    switch ( var_0 )
    {
        case 0:
            break;
        case 1:
            var_1[var_1.size] = "specialty_lightweight_3";
            break;
        case 2:
            var_1[var_1.size] = "specialty_lightweight_3";
            var_1[var_1.size] = "specialty_fastreload";
            break;
        case 3:
            var_1[var_1.size] = "specialty_lightweight_4";
            var_1[var_1.size] = "specialty_marathon";
            var_1[var_1.size] = "specialty_fastreload";
            break;
        case 4:
            var_1[var_1.size] = "specialty_lightweight_7";
            var_1[var_1.size] = "specialty_marathon";
            var_1[var_1.size] = "specialty_fastreload";
            break;
        case 5:
            var_1[var_1.size] = "specialty_lightweight_7";
            var_1[var_1.size] = "specialty_marathon";
            var_1[var_1.size] = "specialty_stalker";
            var_1[var_1.size] = "specialty_fastreload";
            break;
    }

    self.pers["loadoutPerks"] = var_1;
    _ID15614( var_1 );
}

_ID15597( var_0 )
{
    var_1 = [];

    switch ( var_0 )
    {
        case 0:
            break;
        case 1:
            var_1[var_1.size] = "specialty_bulletaccuracy_10";
            break;
        case 2:
            var_1[var_1.size] = "specialty_bulletaccuracy_10";
            var_1[var_1.size] = "specialty_reducedsway";
            break;
        case 3:
            var_1[var_1.size] = "specialty_bulletaccuracy_10";
            var_1[var_1.size] = "specialty_reducedsway";
            var_1[var_1.size] = "specialty_quickswap";
            break;
        case 4:
            var_1[var_1.size] = "specialty_bulletaccuracy_10";
            var_1[var_1.size] = "specialty_reducedsway";
            var_1[var_1.size] = "specialty_quickswap";
            var_1[var_1.size] = "specialty_marksman_10";
            break;
        case 5:
            var_1[var_1.size] = "specialty_bulletaccuracy_10";
            var_1[var_1.size] = "specialty_reducedsway";
            var_1[var_1.size] = "specialty_quickswap";
            var_1[var_1.size] = "specialty_marksman_10";
            var_1[var_1.size] = "specialty_quickdraw";
            break;
    }

    var_2 = common_scripts\utility::array_combine( var_1, self.pers["loadoutPerks"] );
    self.pers["loadoutPerks"] = var_2;
    _ID15614( var_1 );
}

_ID15631( var_0 )
{
    var_1 = [];

    switch ( var_0 )
    {
        case 0:
            break;
        case 1:
            var_1[var_1.size] = "specialty_spygame";
            break;
        case 2:
            var_1[var_1.size] = "specialty_blindeye";
            var_1[var_1.size] = "specialty_spygame";
            break;
        case 3:
            var_1[var_1.size] = "specialty_spygame";
            var_1[var_1.size] = "specialty_blindeye";
            var_1[var_1.size] = "specialty_coldblooded";
            break;
        case 4:
            var_1[var_1.size] = "specialty_spygame";
            var_1[var_1.size] = "specialty_quieter";
            var_1[var_1.size] = "specialty_blindeye";
            var_1[var_1.size] = "specialty_coldblooded";
            var_1[var_1.size] = "specialty_heartbreaker";
            break;
        case 5:
            var_1[var_1.size] = "specialty_spygame";
            var_1[var_1.size] = "specialty_quieter";
            var_1[var_1.size] = "specialty_blindeye";
            var_1[var_1.size] = "specialty_coldblooded";
            var_1[var_1.size] = "specialty_heartbreaker";
            var_1[var_1.size] = "specialty_quieter";
            break;
    }

    var_2 = common_scripts\utility::array_combine( var_1, self.pers["loadoutPerks"] );
    self.pers["loadoutPerks"] = var_2;
    _ID15614( var_1 );
}

_ID15582( var_0 )
{
    var_1 = [];

    switch ( var_0 )
    {
        case 0:
            break;
        case 1:
            var_1[var_1.size] = "specialty_paint";
            var_1[var_1.size] = "specialty_paint_pro";
            break;
        case 2:
            var_1[var_1.size] = "specialty_paint";
            var_1[var_1.size] = "specialty_paint_pro";
            var_1[var_1.size] = "specialty_scavenger";
            break;
        case 3:
            var_1[var_1.size] = "specialty_paint";
            var_1[var_1.size] = "specialty_paint_pro";
            var_1[var_1.size] = "specialty_scavenger";
            var_1[var_1.size] = "specialty_detectexplosive";
            break;
        case 4:
            var_1[var_1.size] = "specialty_selectivehearing";
            var_1[var_1.size] = "specialty_paint";
            var_1[var_1.size] = "specialty_paint_pro";
            var_1[var_1.size] = "specialty_scavenger";
            var_1[var_1.size] = "specialty_detectexplosive";
            break;
        case 5:
            var_1[var_1.size] = "specialty_autospot";
            var_1[var_1.size] = "specialty_selectivehearing";
            var_1[var_1.size] = "specialty_paint";
            var_1[var_1.size] = "specialty_paint_pro";
            var_1[var_1.size] = "specialty_scavenger";
            var_1[var_1.size] = "specialty_detectexplosive";
            break;
    }

    var_2 = common_scripts\utility::array_combine( var_1, self.pers["loadoutPerks"] );
    self.pers["loadoutPerks"] = var_2;
    _ID15614( var_1 );
}

giveresistanceperks( var_0 )
{
    var_1 = [];

    switch ( var_0 )
    {
        case 0:
            break;
        case 1:
            var_1[var_1.size] = "specialty_stun_resistance_6";
            break;
        case 2:
            var_1[var_1.size] = "specialty_stun_resistance_6";
            var_1[var_1.size] = "_specialty_blastshield";
            self.blastshieldmod = 0.65;
            break;
        case 3:
            var_1[var_1.size] = "specialty_stun_resistance_6";
            var_1[var_1.size] = "_specialty_blastshield";
            var_1[var_1.size] = "specialty_delaymine";
            self.blastshieldmod = 0.65;
            break;
        case 4:
            var_1[var_1.size] = "specialty_stun_resistance_6";
            var_1[var_1.size] = "_specialty_blastshield";
            var_1[var_1.size] = "specialty_delaymine";
            var_1[var_1.size] = "specialty_sharp_focus";
            self.blastshieldmod = 0.65;
            break;
        case 5:
            var_1[var_1.size] = "specialty_stun_resistance_10";
            var_1[var_1.size] = "_specialty_blastshield";
            var_1[var_1.size] = "specialty_delaymine";
            var_1[var_1.size] = "specialty_sharp_focus";
            self.blastshieldmod = 0.85;
            break;
    }

    var_2 = common_scripts\utility::array_combine( var_1, self.pers["loadoutPerks"] );
    self.pers["loadoutPerks"] = var_2;
    _ID15614( var_1 );
}

_ID15593( var_0 )
{
    var_1 = [];

    switch ( var_0 )
    {
        case 0:
            break;
        case 1:
            var_1[var_1.size] = "specialty_extraammo";
            break;
        case 2:
            var_1[var_1.size] = "specialty_extraammo";
            var_1[var_1.size] = "specialty_extra_equipment";
            break;
        case 3:
            var_1[var_1.size] = "specialty_extraammo";
            var_1[var_1.size] = "specialty_extra_equipment";
            var_1[var_1.size] = "specialty_fastsprintrecovery";
            break;
        case 4:
            var_1[var_1.size] = "specialty_extraammo";
            var_1[var_1.size] = "specialty_extra_equipment";
            var_1[var_1.size] = "specialty_extra_deadly";
            var_1[var_1.size] = "specialty_fastsprintrecovery";
            break;
        case 5:
            var_1[var_1.size] = "specialty_extraammo";
            var_1[var_1.size] = "specialty_extra_equipment";
            var_1[var_1.size] = "specialty_extra_deadly";
            var_1[var_1.size] = "specialty_fastsprintrecovery";
            var_1[var_1.size] = "specialty_hardline";
            break;
    }

    var_2 = common_scripts\utility::array_combine( var_1, self.pers["loadoutPerks"] );
    self.pers["loadoutPerks"] = var_2;
    _ID15614( var_1 );
}
