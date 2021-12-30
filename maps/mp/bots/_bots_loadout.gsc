// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    _ID17851();
    _ID17702();
    _ID17795();
    _ID17694();
    init_bot_attachmenttable();
    init_bot_camotable();
    level._ID5678 = 1;
}

_ID17702()
{
    var_0 = "mp/botClassTable.csv";
    level._ID5844 = [];
    var_1 = bot_loadout_fields();
    var_2 = 0;

    for (;;)
    {
        var_2++;
        var_3 = tablelookup( var_0, 0, "botPersonalities", var_2 );
        var_4 = tablelookup( var_0, 0, "botDifficulties", var_2 );

        if ( !isdefined( var_3 ) || var_3 == "" )
            break;

        if ( !isdefined( var_4 ) || var_4 == "" )
            break;

        var_5 = [];

        foreach ( var_7 in var_1 )
            var_5[var_7] = tablelookup( var_0, 0, var_7, var_2 );

        var_9 = strtok( var_3, "| " );
        var_10 = strtok( var_4, "| " );

        foreach ( var_12 in var_9 )
        {
            foreach ( var_14 in var_10 )
            {
                var_15 = bot_loadout_set( var_12, var_14, 1 );
                var_16 = spawnstruct();
                var_16.loadoutvalues = var_5;
                var_15._ID20137[var_15._ID20137.size] = var_16;
            }
        }
    }
}

_ID17851()
{
    var_0 = "mp/botTemplateTable.csv";
    level._ID5845 = [];
    var_1 = bot_loadout_fields();
    var_2 = 0;

    for (;;)
    {
        var_2++;
        var_3 = tablelookup( var_0, 0, "template_", var_2 );

        if ( !isdefined( var_3 ) || var_3 == "" )
            break;

        var_4 = "template_" + var_3;
        level._ID5845[var_4] = [];

        foreach ( var_6 in var_1 )
        {
            var_7 = tablelookup( var_0, 0, var_6, var_2 );

            if ( isdefined( var_7 ) && var_7 != "" )
                level._ID5845[var_4][var_6] = var_7;
        }
    }
}

_ID36862( var_0, var_1, var_2 )
{
    if ( !isusingmatchrulesdata() )
        return 1;

    if ( !getmatchrulesdata( "commonOption", "allowCustomClasses" ) )
        return 1;

    if ( var_1 == "specialty_null" )
        return 1;

    if ( var_1 == "none" )
        return 1;

    if ( var_0 == "equipment" )
    {
        if ( getmatchrulesdata( "commonOption", "perkRestricted", var_1 ) )
            return 0;

        var_0 = "weapon";
    }

    var_3 = var_0 + "Restricted";
    var_4 = var_0 + "ClassRestricted";
    var_5 = "";

    switch ( var_0 )
    {
        case "weapon":
            var_5 = maps\mp\_utility::getweaponclass( var_1 );
            break;
        case "attachment":
            var_5 = maps\mp\_utility::getattachmenttype( var_1 );
            break;
        case "killstreak":
            var_5 = var_2;
            break;
        case "perk":
            var_5 = "ability_" + level._ID36867[var_1];
            break;
        default:
            return 0;
    }

    if ( getmatchrulesdata( "commonOption", var_3, var_1 ) )
        return 0;

    if ( getmatchrulesdata( "commonOption", var_4, var_5 ) )
        return 0;

    return 1;
}

_ID36861( var_0 )
{
    var_1 = "none";
    var_2 = [ "veteran", "hardened", "regular", "recruit" ];
    var_2 = common_scripts\utility::array_randomize( var_2 );

    foreach ( var_4 in var_2 )
    {
        var_1 = _ID5667( "weap_statstable", var_0, "loadoutPrimary", self._ID23475, var_4 );

        if ( var_1 != "none" )
            return var_1;
    }

    if ( isdefined( level._ID36868 ) )
    {
        var_6 = common_scripts\utility::array_randomize( level._ID36868 );

        foreach ( var_8 in var_6 )
        {
            foreach ( var_4 in var_2 )
            {
                var_1 = _ID5667( "weap_statstable", var_0, "loadoutPrimary", var_8, var_4 );

                if ( var_1 != "none" )
                {
                    self._ID36839 = var_8;
                    return var_1;
                }
            }
        }
    }

    if ( isusingmatchrulesdata() )
    {
        for ( var_12 = 0; var_12 < 6 && ( !isdefined( var_1 ) || var_1 == "none" || var_1 == "" ); var_12++ )
        {
            if ( getmatchrulesdata( "defaultClasses", self.team, var_12, "class", "inUse" ) )
            {
                var_1 = getmatchrulesdata( "defaultClasses", self.team, var_12, "class", "weaponSetups", 0, "weapon" );

                if ( var_1 != "none" )
                {
                    self._ID36839 = "weapon";
                    return var_1;
                }
            }
        }
    }

    self._ID36839 = "weapon";
    return level._ID36840;
}

_ID36869( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        var_1 = level.bot_weap_personality[var_0];

        if ( isdefined( var_1 ) )
        {
            var_2 = strtok( var_1, "| " );

            if ( var_2.size > 0 )
                maps\mp\bots\_bots_util::bot_set_personality( common_scripts\utility::_ID25350( var_2 ) );
        }
    }
}

bot_loadout_fields()
{
    var_0 = [];
    var_0[var_0.size] = "loadoutPrimary";
    var_0[var_0.size] = "loadoutPrimaryBuff";
    var_0[var_0.size] = "loadoutPrimaryAttachment";
    var_0[var_0.size] = "loadoutPrimaryAttachment2";
    var_0[var_0.size] = "loadoutPrimaryCamo";
    var_0[var_0.size] = "loadoutPrimaryReticle";
    var_0[var_0.size] = "loadoutSecondary";
    var_0[var_0.size] = "loadoutSecondaryBuff";
    var_0[var_0.size] = "loadoutSecondaryAttachment";
    var_0[var_0.size] = "loadoutSecondaryAttachment2";
    var_0[var_0.size] = "loadoutSecondaryCamo";
    var_0[var_0.size] = "loadoutSecondaryReticle";
    var_0[var_0.size] = "loadoutEquipment";
    var_0[var_0.size] = "loadoutOffhand";
    var_0[var_0.size] = "loadoutStreakType";
    var_0[var_0.size] = "loadoutStreak1";
    var_0[var_0.size] = "loadoutStreak2";
    var_0[var_0.size] = "loadoutStreak3";
    var_0[var_0.size] = "loadoutPerk1";
    var_0[var_0.size] = "loadoutPerk2";
    var_0[var_0.size] = "loadoutPerk3";
    var_0[var_0.size] = "loadoutPerk4";
    var_0[var_0.size] = "loadoutPerk5";
    var_0[var_0.size] = "loadoutPerk6";
    var_0[var_0.size] = "loadoutPerk7";
    var_0[var_0.size] = "loadoutPerk8";
    var_0[var_0.size] = "loadoutPerk9";
    var_0[var_0.size] = "loadoutPerk10";
    var_0[var_0.size] = "loadoutPerk11";
    var_0[var_0.size] = "loadoutPerk12";
    var_0[var_0.size] = "loadoutPerk13";
    var_0[var_0.size] = "loadoutPerk14";
    var_0[var_0.size] = "loadoutPerk15";
    var_0[var_0.size] = "loadoutPerk16";
    var_0[var_0.size] = "loadoutPerk17";
    var_0[var_0.size] = "loadoutPerk18";
    var_0[var_0.size] = "loadoutPerk19";
    var_0[var_0.size] = "loadoutPerk20";
    var_0[var_0.size] = "loadoutPerk21";
    var_0[var_0.size] = "loadoutPerk22";
    var_0[var_0.size] = "loadoutPerk23";
    return var_0;
}

bot_loadout_set( var_0, var_1, var_2 )
{
    var_3 = var_1 + "_" + var_0;

    if ( !isdefined( level._ID5844 ) )
        level._ID5844 = [];

    if ( !isdefined( level._ID5844[var_3] ) && var_2 )
    {
        level._ID5844[var_3] = spawnstruct();
        level._ID5844[var_3]._ID20137 = [];
    }

    if ( isdefined( level._ID5844[var_3] ) )
        return level._ID5844[var_3];
}

bot_loadout_pick( var_0, var_1 )
{
    var_2 = bot_loadout_set( var_0, var_1, 0 );

    if ( isdefined( var_2 ) && isdefined( var_2._ID20137 ) && var_2._ID20137.size > 0 )
    {
        var_3 = randomint( var_2._ID20137.size );
        return var_2._ID20137[var_3].loadoutvalues;
    }
}

bot_validate_weapon( var_0, var_1, var_2, var_3 )
{
    var_4 = maps\mp\_utility::_ID15471( var_0 );

    if ( isdefined( var_1 ) && var_1 != "none" && !_ID36862( "attachment", var_1 ) )
        return 0;

    if ( isdefined( var_2 ) && var_2 != "none" && !_ID36862( "attachment", var_2 ) )
        return 0;

    if ( isdefined( var_3 ) && var_3 != "none" && !_ID36862( "attachment", var_3 ) )
        return 0;

    if ( var_1 != "none" && !common_scripts\utility::array_contains( var_4, var_1 ) )
        return 0;

    if ( var_2 != "none" && !common_scripts\utility::array_contains( var_4, var_2 ) )
        return 0;

    if ( isdefined( var_3 ) && var_3 != "none" && !common_scripts\utility::array_contains( var_4, var_3 ) )
        return 0;

    if ( ( var_1 == "none" || var_2 == "none" ) && ( !isdefined( var_3 ) || var_3 == "none" ) )
        return 1;

    if ( !isdefined( level.bot_invalid_attachment_combos ) )
    {
        level.bot_invalid_attachment_combos = [];
        level.allowable_double_attachments = [];
        var_5 = "mp/attachmentcombos.csv";
        var_6 = 0;

        for (;;)
        {
            var_6++;
            var_7 = tablelookupbyrow( var_5, 0, var_6 );

            if ( var_7 == "" )
                break;

            var_8 = 0;

            for (;;)
            {
                var_8++;
                var_9 = tablelookupbyrow( var_5, var_8, 0 );

                if ( var_9 == "" )
                    break;

                if ( var_9 == var_7 )
                {
                    if ( tablelookupbyrow( var_5, var_8, var_6 ) != "no" )
                        level.allowable_double_attachments[var_9] = 1;

                    continue;
                }

                if ( tablelookupbyrow( var_5, var_8, var_6 ) == "no" )
                    level.bot_invalid_attachment_combos[var_7][var_9] = 1;
            }
        }
    }

    if ( var_1 == var_2 && !isdefined( level.allowable_double_attachments[var_1] ) )
        return 0;

    if ( isdefined( var_3 ) )
    {
        if ( var_2 == var_3 && !isdefined( level.allowable_double_attachments[var_2] ) )
            return 0;

        if ( var_1 == var_3 && !isdefined( level.allowable_double_attachments[var_1] ) )
            return 0;

        if ( var_3 != "none" && var_1 == var_3 && var_2 == var_3 )
            return 0;

        if ( isdefined( level.bot_invalid_attachment_combos[var_2] ) && isdefined( level.bot_invalid_attachment_combos[var_2][var_3] ) )
            return 0;

        if ( isdefined( level.bot_invalid_attachment_combos[var_1] ) && isdefined( level.bot_invalid_attachment_combos[var_1][var_3] ) )
            return 0;
    }

    return !( isdefined( level.bot_invalid_attachment_combos[var_1] ) && isdefined( level.bot_invalid_attachment_combos[var_1][var_2] ) );
}

bot_validate_reticle( var_0, var_1, var_2 )
{
    if ( isdefined( var_1[var_0 + "Attachment"] ) && isdefined( level.bot_attachment_reticle[var_1[var_0 + "Attachment"]] ) )
        return 1;

    if ( isdefined( var_1[var_0 + "Attachment2"] ) && isdefined( level.bot_attachment_reticle[var_1[var_0 + "Attachment2"]] ) )
        return 1;

    if ( isdefined( var_1[var_0 + "Attachment3"] ) && isdefined( level.bot_attachment_reticle[var_1[var_0 + "Attachment3"]] ) )
        return 1;

    return 0;
}

bot_perk_cost( var_0 )
{
    return level._ID23458[var_0];
}

_ID23457( var_0, var_1 )
{
    if ( bot_perk_cost( var_0 ) > 0 )
    {
        var_2 = [];
        var_2["type"] = var_1;
        var_2["name"] = var_0;
        level.bot_perktable[level.bot_perktable.size] = var_2;
        level._ID36867[var_0] = var_1;
    }
}

_ID17795()
{
    level._ID23458 = [];
    var_0 = 1;

    for (;;)
    {
        var_1 = tablelookupbyrow( "mp/perktable.csv", var_0, 1 );

        if ( var_1 == "" )
            break;

        level._ID23458[var_1] = int( tablelookupbyrow( "mp/perktable.csv", var_0, 10 ) );
        var_0++;
    }

    level._ID23458["none"] = 0;
    level._ID23458["specialty_null"] = 0;
    level.bot_perktable = [];
    level._ID36867 = [];
    var_0 = 1;

    for ( var_2 = "ability_null"; isdefined( var_2 ) && var_2 != ""; var_2 = tablelookupbyrow( "mp/cacabilitytable.csv", var_0, 1 ) )
    {
        var_2 = getsubstr( var_2, 8 );

        for ( var_3 = 4; var_3 <= 13; var_3++ )
        {
            var_1 = tablelookupbyrow( "mp/cacabilitytable.csv", var_0, var_3 );

            if ( var_1 != "" )
                _ID23457( var_1, var_2 );
        }

        var_0++;
    }
}

_ID17694()
{
    var_0 = "mp/statstable.csv";
    var_1 = 4;
    var_2 = 37;
    var_3 = 38;
    level.bot_weap_statstable = [];
    level.bot_weap_personality = [];
    var_4 = 1;

    for (;;)
    {
        var_5 = tablelookupbyrow( var_0, var_4, var_1 );

        if ( var_5 == "specialty_null" )
            break;

        var_6 = tablelookupbyrow( var_0, var_4, var_3 );
        var_7 = tablelookupbyrow( var_0, var_4, var_2 );

        if ( var_5 != "" && var_7 != "" )
            level.bot_weap_personality[var_5] = var_7;

        if ( var_6 != "" && var_5 != "" && var_7 != "" )
        {
            var_8 = "loadoutPrimary";

            if ( maps\mp\gametypes\_class::isvalidsecondary( var_5, 0 ) )
                var_8 = "loadoutSecondary";
            else if ( !maps\mp\gametypes\_class::_ID18854( var_5, 0 ) )
            {
                var_4++;
                continue;
            }

            if ( !isdefined( level.bot_weap_statstable[var_8] ) )
                level.bot_weap_statstable[var_8] = [];

            var_9 = strtok( var_7, "| " );
            var_10 = strtok( var_6, "| " );

            foreach ( var_12 in var_9 )
            {
                if ( !isdefined( level.bot_weap_statstable[var_8][var_12] ) )
                    level.bot_weap_statstable[var_8][var_12] = [];

                foreach ( var_14 in var_10 )
                {
                    if ( !isdefined( level.bot_weap_statstable[var_8][var_12][var_14] ) )
                        level.bot_weap_statstable[var_8][var_12][var_14] = [];

                    var_15 = level.bot_weap_statstable[var_8][var_12][var_14].size;
                    level.bot_weap_statstable[var_8][var_12][var_14][var_15] = var_5;
                }
            }
        }

        var_4++;
    }
}

_ID5667( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = "specialty_null";

    if ( var_2 == "loadoutPrimary" )
        var_5 = "iw6_honeybadger";
    else if ( var_2 == "loadoutSecondary" )
        var_5 = "iw6_p226";

    if ( var_3 == "default" )
        var_3 = "run_and_gun";

    if ( var_2 == "loadoutSecondary" && common_scripts\utility::array_contains( var_1, "specialty_twoprimaries" ) )
        var_2 = "loadoutPrimary";

    if ( !isdefined( level.bot_weap_statstable ) )
        return var_5;

    if ( !isdefined( level.bot_weap_statstable[var_2] ) )
        return var_5;

    if ( !isdefined( level.bot_weap_statstable[var_2][var_3] ) )
        return var_5;

    if ( !isdefined( level.bot_weap_statstable[var_2][var_3][var_4] ) )
        return var_5;

    var_5 = bot_loadout_choose_from_set( level.bot_weap_statstable[var_2][var_3][var_4], var_0, var_1, var_2 );
    return var_5;
}

bot_loadout_choose_from_perktable( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = "specialty_null";

    if ( !isdefined( level.bot_perktable ) )
        return var_6;

    if ( !isdefined( level._ID5720 ) )
        level._ID5720 = [];

    if ( !isdefined( level._ID5720[var_0] ) )
    {
        var_7 = strtok( var_0, "_" );
        var_7[0] = "";
        var_8 = 0;

        if ( common_scripts\utility::array_contains( var_7, "any" ) )
            var_8 = 1;

        var_9 = [];

        foreach ( var_11 in level.bot_perktable )
        {
            if ( var_8 || common_scripts\utility::array_contains( var_7, var_11["type"] ) )
                var_9[var_9.size] = var_11["name"];
        }

        level._ID5720[var_0] = var_9;
    }

    if ( level._ID5720[var_0].size > 0 )
        var_6 = bot_loadout_choose_from_set( level._ID5720[var_0], var_1, var_2, var_3 );

    return var_6;
}

bot_validate_perk( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = var_4 - var_3 + 1;

    if ( isdefined( var_5 ) )
        var_6 = var_5;

    var_7 = 0;
    var_8 = int( getsubstr( var_1, 11 ) );

    if ( var_0 == "specialty_twoprimaries" )
        return 0;

    if ( var_0 == "specialty_extra_attachment" )
        return 0;

    if ( !_ID36862( "perk", var_0 ) )
        return 0;

    for ( var_9 = var_8 - 1; var_9 > 0; var_9-- )
    {
        var_10 = "loadoutPerk" + var_9;

        if ( var_2[var_10] == "none" || var_2[var_10] == "specialty_null" )
            continue;

        if ( var_0 == var_2[var_10] )
            return 0;

        if ( var_9 >= var_3 && var_9 <= var_4 )
            var_7 += bot_perk_cost( var_2[var_10] );
    }

    if ( var_7 + bot_perk_cost( var_0 ) > var_6 )
        return 0;

    return 1;
}

_ID5664( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = int( getsubstr( var_0, 5, 6 ) ) - 1;

    switch ( var_3 )
    {
        case "loadoutPrimary":
            return maps\mp\gametypes\_class::_ID32335( level.classtablename, var_6, 0 );
        case "loadoutPrimaryAttachment":
            return maps\mp\gametypes\_class::_ID32336( level.classtablename, var_6, 0, 0 );
        case "loadoutPrimaryAttachment2":
            return maps\mp\gametypes\_class::_ID32336( level.classtablename, var_6, 0, 1 );
        case "loadoutPrimaryBuff":
            return maps\mp\gametypes\_class::table_getweaponbuff( level.classtablename, var_6, 0 );
        case "loadoutPrimaryCamo":
            return maps\mp\gametypes\_class::_ID32338( level.classtablename, var_6, 0 );
        case "loadoutPrimaryReticle":
            return maps\mp\gametypes\_class::table_getweaponreticle( level.classtablename, var_6, 0 );
        case "loadoutSecondary":
            return maps\mp\gametypes\_class::_ID32335( level.classtablename, var_6, 1 );
        case "loadoutSecondaryAttachment":
            return maps\mp\gametypes\_class::_ID32336( level.classtablename, var_6, 1, 0 );
        case "loadoutSecondaryAttachment2":
            return maps\mp\gametypes\_class::_ID32336( level.classtablename, var_6, 1, 1 );
        case "loadoutSecondaryBuff":
            return maps\mp\gametypes\_class::table_getweaponbuff( level.classtablename, var_6, 1 );
        case "loadoutSecondaryCamo":
            return maps\mp\gametypes\_class::_ID32338( level.classtablename, var_6, 1 );
        case "loadoutSecondaryReticle":
            return maps\mp\gametypes\_class::table_getweaponreticle( level.classtablename, var_6, 1 );
        case "loadoutEquipment":
            return maps\mp\gametypes\_class::_ID32330( level.classtablename, var_6, 0 );
        case "loadoutOffhand":
            return maps\mp\gametypes\_class::_ID32332( level.classtablename, var_6, 0 );
        case "loadoutStreak1":
            return maps\mp\gametypes\_class::_ID32331( level.classtablename, var_6, 0 );
        case "loadoutStreak2":
            return maps\mp\gametypes\_class::_ID32331( level.classtablename, var_6, 1 );
        case "loadoutStreak3":
            return maps\mp\gametypes\_class::_ID32331( level.classtablename, var_6, 2 );
        case "loadoutPerk1":
        case "loadoutPerk2":
        case "loadoutPerk3":
        case "loadoutPerk4":
        case "loadoutPerk5":
        case "loadoutPerk6":
            var_7 = int( getsubstr( var_3, 11 ) );
            var_8 = maps\mp\gametypes\_class::_ID32333( level.classtablename, var_6, var_7 );

            if ( var_8 == "" )
                return "specialty_null";

            var_9 = int( getsubstr( var_8, 0, 1 ) );
            var_10 = int( getsubstr( var_8, 1, 2 ) );
            var_11 = tablelookupbyrow( "mp/cacabilitytable.csv", var_9 + 1, var_10 + 3 );
            return var_11;
    }

    return var_0;
}

init_bot_attachmenttable()
{
    var_0 = "mp/attachmenttable.csv";
    var_1 = 5;
    var_2 = 19;
    var_3 = 11;
    level.bot_attachmenttable = [];
    level.bot_attachment_reticle = [];
    var_4 = 1;

    for (;;)
    {
        var_5 = tablelookupbyrow( var_0, var_4, var_1 );

        if ( var_5 == "done" )
            break;

        var_6 = tablelookupbyrow( var_0, var_4, var_2 );

        if ( var_5 != "" && var_6 != "" )
        {
            var_7 = tablelookupbyrow( var_0, var_4, var_3 );

            if ( var_7 == "TRUE" )
                level.bot_attachment_reticle[var_5] = 1;

            var_8 = strtok( var_6, "| " );

            foreach ( var_10 in var_8 )
            {
                if ( !isdefined( level.bot_attachmenttable[var_10] ) )
                    level.bot_attachmenttable[var_10] = [];

                if ( !common_scripts\utility::array_contains( level.bot_attachmenttable[var_10], var_5 ) )
                {
                    var_11 = level.bot_attachmenttable[var_10].size;
                    level.bot_attachmenttable[var_10][var_11] = var_5;
                }
            }
        }

        var_4++;
    }
}

bot_loadout_choose_from_attachmenttable( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = "none";

    if ( !isdefined( level.bot_attachmenttable ) )
        return var_5;

    if ( !isdefined( level.bot_attachmenttable[var_4] ) )
        return var_5;

    var_5 = bot_loadout_choose_from_set( level.bot_attachmenttable[var_4], var_0, var_1, var_2 );
    return var_5;
}

init_bot_camotable()
{
    var_0 = "mp/camotable.csv";
    var_1 = 1;
    var_2 = 5;
    level.bot_camotable = [];
    var_3 = 0;

    for (;;)
    {
        var_4 = tablelookupbyrow( var_0, var_3, var_1 );

        if ( !isdefined( var_4 ) || var_4 == "" )
            break;

        var_5 = tablelookupbyrow( var_0, var_3, var_2 );

        if ( isdefined( var_5 ) && int( var_5 ) )
            level.bot_camotable[level.bot_camotable.size] = var_4;

        var_3++;
    }
}

bot_loadout_choose_from_camotable( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = "none";

    if ( !isdefined( level.bot_camotable ) )
        return var_5;

    var_5 = bot_loadout_choose_from_set( level.bot_camotable, var_0, var_1, var_2 );
    return var_5;
}

_ID5672( var_0 )
{
    var_1 = 8;

    if ( isdefined( var_0["loadoutPrimary"] ) && var_0["loadoutPrimary"] == "none" )
        var_1 += 1;

    if ( isdefined( var_0["loadoutSecondary"] ) && var_0["loadoutSecondary"] == "none" )
        var_1 += 1;

    if ( isdefined( var_0["loadoutEquipment"] ) && var_0["loadoutEquipment"] == "none" )
        var_1 += 1;

    if ( isdefined( var_0["loadoutOffhand"] ) && var_0["loadoutOffhand"] == "none" )
        var_1 += 1;

    return var_1;
}

bot_loadout_valid_choice( var_0, var_1, var_2, var_3 )
{
    var_4 = 1;

    switch ( var_2 )
    {
        case "loadoutPrimary":
            var_4 = _ID36862( "weapon", var_3 );
            break;
        case "loadoutEquipment":
        case "loadoutOffhand":
            var_4 = _ID36862( "equipment", var_3 );
            break;
        case "loadoutPrimaryBuff":
            var_4 = maps\mp\gametypes\_class::_ID18862( var_3, var_1["loadoutPrimary"] );
            break;
        case "loadoutPrimaryAttachment":
            var_4 = bot_validate_weapon( var_1["loadoutPrimary"], var_3, "none" );
            break;
        case "loadoutPrimaryAttachment2":
            var_4 = bot_validate_weapon( var_1["loadoutPrimary"], var_1["loadoutPrimaryAttachment"], var_3 );
            break;
        case "loadoutPrimaryAttachment3":
            var_4 = bot_validate_weapon( var_1["loadoutPrimary"], var_1["loadoutPrimaryAttachment"], var_1["loadoutPrimaryAttachment2"], var_3 );
            break;
        case "loadoutPrimaryReticle":
            var_4 = bot_validate_reticle( "loadoutPrimary", var_1, var_3 );
            break;
        case "loadoutPrimaryCamo":
            var_4 = !isdefined( self.botloadoutfavoritecamo ) || var_3 == self.botloadoutfavoritecamo;
            break;
        case "loadoutSecondary":
            var_4 = var_3 != var_1["loadoutPrimary"];
            var_4 = var_4 && _ID36862( "weapon", var_3 );
            break;
        case "loadoutSecondaryBuff":
            var_4 = maps\mp\gametypes\_class::_ID18862( var_3, var_1["loadoutSecondary"] );
            break;
        case "loadoutSecondaryAttachment":
            var_4 = bot_validate_weapon( var_1["loadoutSecondary"], var_3, "none" );
            break;
        case "loadoutSecondaryAttachment2":
            var_4 = bot_validate_weapon( var_1["loadoutSecondary"], var_1["loadoutSecondaryAttachment"], var_3 );
            break;
        case "loadoutSecondaryAttachment3":
            var_4 = bot_validate_weapon( var_1["loadoutSecondary"], var_1["loadoutSecondaryAttachment"], var_1["loadoutSecondaryAttachment2"], var_3 );
            break;
        case "loadoutSecondaryReticle":
            var_4 = bot_validate_reticle( "loadoutSecondary", var_1, var_3 );
            break;
        case "loadoutSecondaryCamo":
            var_4 = !isdefined( self.botloadoutfavoritecamo ) || var_3 == self.botloadoutfavoritecamo;
            break;
        case "loadoutStreak1":
        case "loadoutStreak2":
        case "loadoutStreak3":
            var_4 = maps\mp\bots\_bots_ks::bot_killstreak_is_valid_internal( var_3, "bots", undefined, var_1["loadoutStreakType"] );
            var_4 = var_4 && _ID36862( "killstreak", var_3, var_1["loadoutStreakType"] );
            break;
        case "loadoutPerk1":
        case "loadoutPerk2":
        case "loadoutPerk3":
        case "loadoutPerk4":
        case "loadoutPerk5":
        case "loadoutPerk6":
        case "loadoutPerk7":
        case "loadoutPerk8":
        case "loadoutPerk9":
        case "loadoutPerk10":
        case "loadoutPerk11":
        case "loadoutPerk12":
            var_4 = bot_validate_perk( var_3, var_2, var_1, 1, 12, _ID5672( var_1 ) );
            break;
        case "loadoutPerk13":
        case "loadoutPerk14":
        case "loadoutPerk15":
            if ( var_1["loadoutStreakType"] != "streaktype_specialist" )
                var_4 = 0;
            else
                var_4 = bot_validate_perk( var_3, var_2, var_1, -1, -1 );

            break;
        case "loadoutPerk16":
        case "loadoutPerk17":
        case "loadoutPerk18":
        case "loadoutPerk19":
        case "loadoutPerk20":
        case "loadoutPerk21":
        case "loadoutPerk22":
        case "loadoutPerk23":
            if ( var_1["loadoutStreakType"] != "streaktype_specialist" )
                var_4 = 0;
            else
                var_4 = bot_validate_perk( var_3, var_2, var_1, 16, 23, 8 );

            break;
    }

    return var_4;
}

bot_loadout_choose_from_set( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = "none";
    var_6 = undefined;
    var_7 = 0.0;

    if ( common_scripts\utility::array_contains( var_0, "specialty_null" ) )
        var_5 = "specialty_null";

    foreach ( var_9 in var_0 )
    {
        var_10 = undefined;

        if ( getsubstr( var_9, 0, 9 ) == "template_" )
        {
            var_10 = var_9;
            var_11 = level._ID5845[var_9][var_3];
            var_9 = bot_loadout_choose_from_set( strtok( var_11, "| " ), var_1, var_2, var_3, 1 );

            if ( isdefined( var_10 ) && isdefined( self.chosentemplates[var_10] ) )
                return var_9;
        }

        if ( var_9 == "attachmenttable" )
            return bot_loadout_choose_from_attachmenttable( var_1, var_2, var_3, self._ID23475, self._ID10028 );

        if ( var_9 == "weap_statstable" )
            return _ID5667( var_1, var_2, var_3, self._ID23475, self._ID10028 );

        if ( var_9 == "camotable" )
            return bot_loadout_choose_from_camotable( var_1, var_2, var_3, self._ID23475, self._ID10028 );

        if ( getsubstr( var_9, 0, 5 ) == "class" && int( getsubstr( var_9, 5, 6 ) ) > 0 )
            var_9 = _ID5664( var_9, var_1, var_2, var_3, self._ID23475, self._ID10028 );

        if ( isdefined( level.bot_perktable ) && getsubstr( var_9, 0, 10 ) == "perktable_" )
            return bot_loadout_choose_from_perktable( var_9, var_1, var_2, var_3, self._ID23475, self._ID10028 );

        if ( bot_loadout_valid_choice( var_1, var_2, var_3, var_9 ) )
        {
            var_7 += 1.0;

            if ( randomfloat( 1.0 ) <= 1.0 / var_7 )
            {
                var_5 = var_9;
                var_6 = var_10;
            }
        }
    }

    if ( isdefined( var_6 ) )
        self.chosentemplates[var_6] = 1;

    return var_5;
}

_ID5668( var_0 )
{
    self.chosentemplates = [];

    foreach ( var_6, var_2 in var_0 )
    {
        var_3 = strtok( var_2, "| " );
        var_4 = bot_loadout_choose_from_set( var_3, var_2, var_0, var_6 );
        var_0[var_6] = var_4;
    }

    return var_0;
}

_ID5662( var_0 )
{
    var_1 = "recruit";

    for ( var_2 = 18; var_2 >= 0; var_2-- )
    {
        var_3 = int( tablelookupbyrow( "mp/squadEloTable.csv", var_2, 0 ) );

        if ( var_0 >= var_3 || var_2 == 0 )
            return tablelookupbyrow( "mp/squadEloTable.csv", var_2, self.pers["squadSlot"] + 1 );
    }

    return var_1;
}

bot_loadout_get_difficulty()
{
    var_0 = "regular";

    if ( getdvar( "squad_match" ) == "1" )
        var_0 = _ID5662( getsquadassaultelo() );
    else
    {
        var_0 = self botgetdifficulty();

        if ( var_0 == "default" )
        {
            maps\mp\bots\_bots_util::bot_set_difficulty( "default" );
            var_0 = self botgetdifficulty();
        }
    }

    return var_0;
}

_ID5669()
{
    while ( !isdefined( level._ID5678 ) )
        wait 0.05;

    while ( !isdefined( self._ID23475 ) )
        wait 0.05;

    var_0 = [];
    var_1 = bot_loadout_get_difficulty();
    self._ID10028 = var_1;
    var_2 = self botgetpersonality();

    if ( getdvar( "squad_match" ) == "1" )
    {
        var_0 = bot_loadout_setup_squad_match( var_0 );
        var_2 = self botgetpersonality();
    }
    else if ( getdvar( "squad_vs_squad" ) == "1" )
    {
        var_0 = _ID36863( var_0 );
        var_2 = self botgetpersonality();
    }
    else if ( getdvar( "squad_use_hosts_squad" ) == "1" && level.wargame_client.team == self.team )
    {
        var_0 = _ID36864( var_0 );
        var_2 = self botgetpersonality();
    }
    else
    {
        if ( isdefined( self.botlastloadout ) )
        {
            var_3 = self.botlastloadoutdifficulty == var_1;
            var_4 = self.botlastloadoutpersonality == var_2;

            if ( var_3 && var_4 && ( !isdefined( self.hasdied ) || self.hasdied ) && !isdefined( self.respawn_with_launcher ) )
                return self.botlastloadout;
        }

        var_0 = bot_loadout_pick( var_2, var_1 );
        var_0 = _ID5668( var_0 );

        if ( isdefined( level.bot_funcs["gametype_loadout_modify"] ) )
            var_0 = self [[ level.bot_funcs["gametype_loadout_modify"] ]]( var_0 );

        if ( var_0["loadoutPrimary"] == "none" )
        {
            self._ID36839 = undefined;
            var_0["loadoutPrimary"] = _ID36861( var_0 );
            var_0["loadoutPrimaryCamo"] = "none";
            var_0["loadoutPrimaryAttachment"] = "none";
            var_0["loadoutPrimaryAttachment2"] = "none";
            var_0["loadoutPrimaryAttachment3"] = "none";
            var_0["loadoutPrimaryReticle"] = "none";

            if ( isdefined( self._ID36839 ) )
            {
                if ( self._ID36839 == "weapon" )
                    _ID36869( var_0["loadoutPrimary"] );
                else
                    maps\mp\bots\_bots_util::bot_set_personality( self._ID36839 );

                var_2 = self._ID23475;
                self._ID36839 = undefined;
            }
        }

        self.botlastloadout = var_0;
        self.botlastloadoutdifficulty = var_1;
        self.botlastloadoutpersonality = var_2;

        if ( isdefined( var_0["loadoutPrimaryCamo"] ) && var_0["loadoutPrimaryCamo"] != "none" )
            self.botloadoutfavoritecamo = var_0["loadoutPrimaryCamo"];

        if ( isdefined( self.respawn_with_launcher ) )
        {
            if ( isdefined( level.bot_respawn_launcher_name ) && _ID36862( "weapon", level.bot_respawn_launcher_name ) )
            {
                var_0["loadoutSecondary"] = level.bot_respawn_launcher_name;
                var_0["loadoutSecondaryAttachment"] = "none";
                var_0["loadoutSecondaryAttachment2"] = "none";
                self.botlastloadout = undefined;
            }

            self.respawn_with_launcher = undefined;
        }
    }

    var_0 = bot_loadout_setup_perks( var_0 );
    maps\mp\gametypes\_class::_ID18849( var_0["loadoutStreak1"] );
    maps\mp\gametypes\_class::_ID18849( var_0["loadoutStreak2"] );
    maps\mp\gametypes\_class::_ID18849( var_0["loadoutStreak3"] );

    if ( maps\mp\_utility::_ID36859() )
    {
        if ( common_scripts\utility::array_contains( self.pers["loadoutPerks"], "specialty_twoprimaries" ) )
        {
            var_5 = bot_loadout_pick( "cqb", var_1 );
            var_0["loadoutSecondary"] = var_5["loadoutPrimary"];
            var_0["loadoutSecondaryAttachment"] = var_5["loadoutPrimaryAttachment"];
            var_0["loadoutSecondaryAttachment2"] = var_5["loadoutPrimaryAttachment2"];
            var_0 = _ID5668( var_0 );
            var_0 = bot_loadout_setup_perks( var_0 );
        }

        if ( common_scripts\utility::array_contains( self.pers["loadoutPerks"], "specialty_extra_attachment" ) )
        {
            var_6 = bot_loadout_pick( var_2, var_1 );
            var_0["loadoutPrimaryAttachment3"] = var_6["loadoutPrimaryAttachment2"];

            if ( common_scripts\utility::array_contains( self.pers["loadoutPerks"], "specialty_twoprimaries" ) )
                var_0["loadoutSecondaryAttachment2"] = var_6["loadoutPrimaryAttachment2"];
            else
                var_0["loadoutSecondaryAttachment2"] = var_6["loadoutSecondaryAttachment2"];

            var_0 = _ID5668( var_0 );
            var_0 = bot_loadout_setup_perks( var_0 );
        }
        else
        {
            var_0["loadoutSecondaryAttachment2"] = "none";

            if ( !bot_validate_reticle( "loadoutSecondary", var_0, var_0["loadoutSecondaryReticle"] ) )
                var_0["loadoutSecondaryReticle"] = "none";
        }
    }

    return var_0;
}

bot_loadout_setup_perks( var_0 )
{
    self.pers["loadoutPerks"] = [];
    self.pers["specialistBonusStreaks"] = [];
    self.pers["specialistStreaks"] = [];
    self.pers["specialistStreakKills"] = [];
    var_1 = 0;
    var_2 = isdefined( var_0["loadoutStreakType"] ) && var_0["loadoutStreakType"] == "streaktype_specialist";

    if ( var_2 )
    {
        var_0["loadoutStreak1"] = "none";
        var_0["loadoutStreak2"] = "none";
        var_0["loadoutStreak3"] = "none";
    }

    foreach ( var_8, var_4 in var_0 )
    {
        if ( var_4 == "specialty_null" || var_4 == "none" )
            continue;

        if ( getsubstr( var_8, 0, 11 ) == "loadoutPerk" )
        {
            var_5 = int( getsubstr( var_8, 11 ) );

            if ( !var_2 && var_5 > 12 )
                continue;

            var_6 = maps\mp\_utility::getbaseperkname( var_4 );

            if ( var_5 <= 12 )
                self.pers["loadoutPerks"][self.pers["loadoutPerks"].size] = var_6;
            else if ( var_5 <= 15 )
            {
                var_0["loadoutStreak" + ( var_1 + 1 )] = var_6 + "_ks";
                self.pers["specialistStreaks"][self.pers["specialistStreaks"].size] = var_6 + "_ks";
                var_7 = 0;

                if ( var_1 > 0 )
                    var_7 = self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size - 1];

                self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size] = var_7 + bot_perk_cost( var_6 ) + 2;
                var_1++;
            }
            else
                self.pers["specialistBonusStreaks"][self.pers["specialistBonusStreaks"].size] = var_6;
        }
    }

    if ( var_2 && !isdefined( self.pers["specialistStreakKills"][0] ) )
    {
        self.pers["specialistStreakKills"][0] = 0;
        self.pers["specialistStreaks"][0] = "specialty_null";
    }

    if ( var_2 && !isdefined( self.pers["specialistStreakKills"][1] ) )
    {
        self.pers["specialistStreakKills"][1] = self.pers["specialistStreakKills"][0];
        self.pers["specialistStreaks"][1] = "specialty_null";
    }

    if ( var_2 && !isdefined( self.pers["specialistStreakKills"][2] ) )
    {
        self.pers["specialistStreakKills"][2] = self.pers["specialistStreakKills"][1];
        self.pers["specialistStreaks"][2] = "specialty_null";
    }

    return var_0;
}

_ID5777()
{
    var_0 = self botgetpersonality();
    var_1 = bot_loadout_get_difficulty();
    var_2 = bot_loadout_set( var_0, var_1, 0 );

    if ( isdefined( var_2 ) && isdefined( var_2._ID20137 ) && var_2._ID20137.size > 0 )
    {
        self.classcallback = ::_ID5669;
        return 1;
    }

    var_3 = getsubstr( self.name, 0, self.name.size - 10 );
    self.classcallback = undefined;
    return 0;
}

_ID5791( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( var_6 ) )
        return var_0 getprivateplayerdata( "privateMatchSquadMembers", var_1, "loadouts", var_2, var_3, var_4, var_5, var_6 );
    else if ( isdefined( var_5 ) )
        return var_0 getprivateplayerdata( "privateMatchSquadMembers", var_1, "loadouts", var_2, var_3, var_4, var_5 );
    else if ( isdefined( var_4 ) )
        return var_0 getprivateplayerdata( "privateMatchSquadMembers", var_1, "loadouts", var_2, var_3, var_4 );
    else
        return var_0 getprivateplayerdata( "privateMatchSquadMembers", var_1, "loadouts", var_2, var_3 );
}

bot_squad_lookup_ranked( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( var_6 ) )
        return var_0 getrankedplayerdata( "squadMembers", var_1, "loadouts", var_2, var_3, var_4, var_5, var_6 );
    else if ( isdefined( var_5 ) )
        return var_0 getrankedplayerdata( "squadMembers", var_1, "loadouts", var_2, var_3, var_4, var_5 );
    else if ( isdefined( var_4 ) )
        return var_0 getrankedplayerdata( "squadMembers", var_1, "loadouts", var_2, var_3, var_4 );
    else
        return var_0 getrankedplayerdata( "squadMembers", var_1, "loadouts", var_2, var_3 );
}

bot_squad_lookup_enemy( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( var_6 ) )
        return getenemysquaddata( "squadMembers", var_1, "loadouts", var_2, var_3, var_4, var_5, var_6 );
    else if ( isdefined( var_5 ) )
        return getenemysquaddata( "squadMembers", var_1, "loadouts", var_2, var_3, var_4, var_5 );
    else if ( isdefined( var_4 ) )
        return getenemysquaddata( "squadMembers", var_1, "loadouts", var_2, var_3, var_4 );
    else
        return getenemysquaddata( "squadMembers", var_1, "loadouts", var_2, var_3 );
}

bot_squad_lookup( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = ::bot_squad_lookup_ranked;

    if ( getdvar( "squad_match" ) == "1" && self.team == "axis" )
        var_7 = ::bot_squad_lookup_enemy;
    else if ( !maps\mp\_utility::_ID20673() )
        var_7 = ::_ID5791;

    return self [[ var_7 ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
}

bot_squadmember_lookup( var_0, var_1, var_2 )
{
    if ( getdvar( "squad_match" ) == "1" && self.team == "axis" )
        return getenemysquaddata( "squadMembers", var_1, var_2 );
    else if ( !maps\mp\_utility::_ID20673() )
        return var_0 getprivateplayerdata( "privateMatchSquadMembers", var_1, var_2 );
    else
        return var_0 getrankedplayerdata( "squadMembers", var_1, var_2 );
}

bot_loadout_copy_from_client( var_0, var_1, var_2, var_3 )
{
    var_0["loadoutPrimary"] = bot_squad_lookup( var_1, var_2, var_3, "weaponSetups", 0, "weapon" );
    var_0["loadoutPrimaryAttachment"] = bot_squad_lookup( var_1, var_2, var_3, "weaponSetups", 0, "attachment", 0 );
    var_0["loadoutPrimaryAttachment2"] = bot_squad_lookup( var_1, var_2, var_3, "weaponSetups", 0, "attachment", 1 );
    var_0["loadoutPrimaryAttachment3"] = bot_squad_lookup( var_1, var_2, var_3, "weaponSetups", 0, "attachment", 2 );
    var_0["loadoutPrimaryBuff"] = bot_squad_lookup( var_1, var_2, var_3, "weaponSetups", 0, "buff" );
    var_0["loadoutPrimaryCamo"] = bot_squad_lookup( var_1, var_2, var_3, "weaponSetups", 0, "camo" );
    var_0["loadoutPrimaryReticle"] = bot_squad_lookup( var_1, var_2, var_3, "weaponSetups", 0, "reticle" );
    var_0["loadoutSecondary"] = bot_squad_lookup( var_1, var_2, var_3, "weaponSetups", 1, "weapon" );
    var_0["loadoutSecondaryAttachment"] = bot_squad_lookup( var_1, var_2, var_3, "weaponSetups", 1, "attachment", 0 );
    var_0["loadoutSecondaryAttachment2"] = bot_squad_lookup( var_1, var_2, var_3, "weaponSetups", 1, "attachment", 1 );
    var_0["loadoutSecondaryBuff"] = bot_squad_lookup( var_1, var_2, var_3, "weaponSetups", 1, "buff" );
    var_0["loadoutSecondaryCamo"] = bot_squad_lookup( var_1, var_2, var_3, "weaponSetups", 1, "camo" );
    var_0["loadoutSecondaryReticle"] = bot_squad_lookup( var_1, var_2, var_3, "weaponSetups", 1, "reticle" );
    var_0["loadoutEquipment"] = bot_squad_lookup( var_1, var_2, var_3, "perks", 0 );
    var_0["loadoutOffhand"] = bot_squad_lookup( var_1, var_2, var_3, "perks", 1 );
    var_0["loadoutStreak1"] = "none";
    var_0["loadoutStreak2"] = "none";
    var_0["loadoutStreak3"] = "none";
    var_4 = bot_squad_lookup( var_1, var_2, var_3, "perks", 5 );

    if ( isdefined( var_4 ) )
    {
        var_0["loadoutStreakType"] = var_4;

        if ( var_4 == "streaktype_assault" )
        {
            var_0["loadoutStreak1"] = bot_squad_lookup( var_1, var_2, var_3, "assaultStreaks", 0 );
            var_0["loadoutStreak2"] = bot_squad_lookup( var_1, var_2, var_3, "assaultStreaks", 1 );
            var_0["loadoutStreak3"] = bot_squad_lookup( var_1, var_2, var_3, "assaultStreaks", 2 );
        }
        else if ( var_4 == "streaktype_support" )
        {
            var_0["loadoutStreak1"] = bot_squad_lookup( var_1, var_2, var_3, "supportStreaks", 0 );
            var_0["loadoutStreak2"] = bot_squad_lookup( var_1, var_2, var_3, "supportStreaks", 1 );
            var_0["loadoutStreak3"] = bot_squad_lookup( var_1, var_2, var_3, "supportStreaks", 2 );
        }
        else if ( var_4 == "streaktype_specialist" )
        {
            var_0["loadoutPerk13"] = bot_squad_lookup( var_1, var_2, var_3, "specialistStreaks", 0 );
            var_0["loadoutPerk14"] = bot_squad_lookup( var_1, var_2, var_3, "specialistStreaks", 1 );
            var_0["loadoutPerk15"] = bot_squad_lookup( var_1, var_2, var_3, "specialistStreaks", 2 );
        }
    }

    var_5 = 1;
    var_6 = maps\mp\gametypes\_class::getnumabilitycategories();
    var_7 = maps\mp\gametypes\_class::getnumsubability();

    for ( var_8 = 0; var_8 < var_6; var_8++ )
    {
        for ( var_9 = 0; var_9 < var_7; var_9++ )
        {
            var_10 = bot_squad_lookup( var_1, var_2, var_3, "abilitiesPicked", var_8, var_9 );

            if ( isdefined( var_10 ) && var_10 )
            {
                var_11 = tablelookup( "mp/cacAbilityTable.csv", 0, var_8 + 1, 4 + var_9 );
                var_0["loadoutPerk" + var_5] = var_11;
                var_5++;
                continue;
            }

            var_0["loadoutPerk" + var_5] = "specialty_null";
        }
    }

    var_5 = 16;

    for ( var_8 = 0; var_8 < var_6; var_8++ )
    {
        for ( var_9 = 0; var_9 < var_7; var_9++ )
        {
            var_10 = bot_squad_lookup( var_1, var_2, var_3, "specialistBonusStreaks", var_8, var_9 );

            if ( isdefined( var_10 ) && var_10 )
            {
                var_11 = tablelookup( "mp/cacAbilityTable.csv", 0, var_8 + 1, 4 + var_9 );
                var_0["loadoutPerk" + var_5] = var_11;
                var_5++;
                continue;
            }

            var_0["loadoutPerk" + var_5] = "specialty_null";
        }
    }

    var_0["loadoutCharacterType"] = bot_squad_lookup( var_1, var_2, var_3, "type" );
    _ID36869( var_0["loadoutPrimary"] );
    self.playercardpatch = bot_squadmember_lookup( var_1, var_2, "patch" );
    self.playercardbackground = bot_squadmember_lookup( var_1, var_2, "background" );

    if ( getdvar( "squad_match" ) == "1" && self.team == "axis" )
        self._ID38111 = getenemysquaddogtype();
    else
        self._ID38111 = var_1 getcommonplayerdatareservedint( "mp_dog_type" );

    return var_0;
}

bot_loadout_setup_squad_match( var_0 )
{
    var_1 = level.players[0];

    foreach ( var_3 in level.players )
    {
        if ( !isai( var_3 ) && isplayer( var_3 ) )
        {
            var_1 = var_3;
            break;
        }
    }

    var_5 = self.pers["squadSlot"];
    var_6 = bot_squadmember_lookup( var_1, var_5, "ai_loadout" );
    self.pers["rankxp"] = bot_squadmember_lookup( var_1, var_5, "squadMemXP" );

    if ( self.team == "allies" )
    {
        if ( isdefined( var_1 ) )
        {
            var_7 = var_1 getrankedplayerdatareservedint( "prestigeLevel" );
            self.pers["prestige_fake"] = var_7;
        }
    }
    else if ( self.team == "axis" )
        self.pers["prestige_fake"] = getsquadassaultenemyprestige();

    var_0 = bot_loadout_copy_from_client( var_0, var_1, var_5, var_6 );
    return var_0;
}

_ID36863( var_0 )
{
    var_1 = level.squad_vs_squad_allies_client;

    if ( self.team == "axis" )
        var_1 = level.squad_vs_squad_axis_client;

    var_2 = self.pers["squadSlot"];
    var_3 = bot_squadmember_lookup( var_1, var_2, "ai_loadout" );
    self.pers["rankxp"] = bot_squadmember_lookup( var_1, var_2, "squadMemXP" );

    if ( isdefined( var_1 ) )
    {
        var_4 = var_1 getrankedplayerdatareservedint( "prestigeLevel" );
        self.pers["prestige_fake"] = var_4;
    }

    var_0 = bot_loadout_copy_from_client( var_0, var_1, var_2, var_3 );
    return var_0;
}

_ID36864( var_0 )
{
    var_1 = level.wargame_client;
    var_2 = self.pers["squadSlot"];
    var_3 = bot_squadmember_lookup( var_1, var_2, "ai_loadout" );
    self.pers["rankxp"] = bot_squadmember_lookup( var_1, var_2, "squadMemXP" );

    if ( isdefined( var_1 ) )
    {
        var_4 = var_1 getrankedplayerdatareservedint( "prestigeLevel" );
        self.pers["prestige_fake"] = var_4;
    }

    var_0 = bot_loadout_copy_from_client( var_0, var_1, var_2, var_3 );
    return var_0;
}
