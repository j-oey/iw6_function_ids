// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level.classmap["class0"] = 0;
    level.classmap["class1"] = 1;
    level.classmap["class2"] = 2;
    level.classmap["custom1"] = 0;
    level.classmap["custom2"] = 1;
    level.classmap["custom3"] = 2;
    level.classmap["custom4"] = 3;
    level.classmap["custom5"] = 4;
    level.classmap["custom6"] = 5;
    level.classmap["custom7"] = 6;
    level.classmap["custom8"] = 7;
    level.classmap["custom9"] = 8;
    level.classmap["custom10"] = 9;
    level.classmap["axis_recipe1"] = 0;
    level.classmap["axis_recipe2"] = 1;
    level.classmap["axis_recipe3"] = 2;
    level.classmap["axis_recipe4"] = 3;
    level.classmap["axis_recipe5"] = 4;
    level.classmap["axis_recipe6"] = 5;
    level.classmap["allies_recipe1"] = 0;
    level.classmap["allies_recipe2"] = 1;
    level.classmap["allies_recipe3"] = 2;
    level.classmap["allies_recipe4"] = 3;
    level.classmap["allies_recipe5"] = 4;
    level.classmap["allies_recipe6"] = 5;
    level.classmap["gamemode"] = 0;
    level.classmap["callback"] = 0;
    level.defaultclass = "CLASS_ASSAULT";
    level.classtablename = "mp/classTable.csv";
    level thread onplayerconnecting();
}

_ID14932( var_0 )
{
    return var_0;
}

getweaponchoice( var_0 )
{
    var_1 = strtok( var_0, "," );

    if ( var_1.size > 1 )
        return int( var_1[1] );
    else
        return 0;
}

_ID20246( var_0, var_1, var_2, var_3 )
{
    if ( var_0 == self.lastclass )
        return;

    self logstring( "choseclass: " + var_0 + " weapon: " + var_1 + " special: " + var_2 );

    for ( var_4 = 0; var_4 < var_3.size; var_4++ )
        self logstring( "perk" + var_4 + ": " + var_3[var_4] );

    self.lastclass = var_0;
}

cac_getweapon( var_0, var_1 )
{
    return self getcacplayerdata( "loadouts", var_0, "weaponSetups", var_1, "weapon" );
}

cac_getweaponattachment( var_0, var_1 )
{
    return self getcacplayerdata( "loadouts", var_0, "weaponSetups", var_1, "attachment", 0 );
}

cac_getweaponattachmenttwo( var_0, var_1 )
{
    return self getcacplayerdata( "loadouts", var_0, "weaponSetups", var_1, "attachment", 1 );
}

_ID6400( var_0, var_1 )
{
    return self getcacplayerdata( "loadouts", var_0, "weaponSetups", var_1, "attachment", 2 );
}

cac_getweaponbuff( var_0, var_1 )
{
    return self getcacplayerdata( "loadouts", var_0, "weaponSetups", var_1, "buff" );
}

cac_getweaponcamo( var_0, var_1 )
{
    return self getcacplayerdata( "loadouts", var_0, "weaponSetups", var_1, "camo" );
}

cac_getweaponreticle( var_0, var_1 )
{
    return self getcacplayerdata( "loadouts", var_0, "weaponSetups", var_1, "reticle" );
}

cac_getperk( var_0, var_1 )
{
    return self getcacplayerdata( "loadouts", var_0, "perks", var_1 );
}

cac_getkillstreak( var_0, var_1 )
{
    return self getcacplayerdata( "loadouts", var_0, "killstreaks", var_1 );
}

cac_getkillstreakwithtype( var_0, var_1, var_2 )
{
    var_3 = undefined;

    switch ( var_1 )
    {
        case "streaktype_support":
            var_3 = "supportStreaks";
            break;
        case "streaktype_specialist":
            var_3 = "specialistStreaks";
            break;
        default:
            var_3 = "assaultStreaks";
            break;
    }

    return self getcacplayerdata( "loadouts", var_0, var_3, var_2 );
}

_ID6392( var_0 )
{
    return self getcacplayerdata( "loadouts", var_0, "type" );
}

_ID6396( var_0 )
{
    return self getcacplayerdata( "loadouts", var_0, "perks", 0 );
}

cac_getsecondarygrenade( var_0 )
{
    return self getcacplayerdata( "loadouts", var_0, "perks", 1 );
}

recipe_getkillstreak( var_0, var_1, var_2, var_3 )
{
    var_4 = undefined;

    switch ( var_2 )
    {
        case "streaktype_support":
            var_4 = "supportStreaks";
            break;
        case "streaktype_specialist":
            var_4 = "specialistStreaks";
            break;
        default:
            var_4 = "assaultStreaks";
            break;
    }

    return getmatchrulesdata( "defaultClasses", var_0, var_1, "class", var_4, var_3 );
}

_ID32335( var_0, var_1, var_2 )
{
    if ( var_2 == 0 )
        return tablelookup( var_0, 0, "loadoutPrimary", var_1 + 1 );
    else
        return tablelookup( var_0, 0, "loadoutSecondary", var_1 + 1 );
}

_ID32336( var_0, var_1, var_2, var_3 )
{
    var_4 = "none";

    if ( var_2 == 0 )
    {
        if ( !isdefined( var_3 ) || var_3 == 0 )
            var_4 = tablelookup( var_0, 0, "loadoutPrimaryAttachment", var_1 + 1 );
        else if ( var_3 == 1 )
            var_4 = tablelookup( var_0, 0, "loadoutPrimaryAttachment2", var_1 + 1 );
        else if ( var_3 == 2 )
            var_4 = tablelookup( var_0, 0, "loadoutPrimaryAttachment3", var_1 + 1 );
    }
    else if ( !isdefined( var_3 ) || var_3 == 0 )
        var_4 = tablelookup( var_0, 0, "loadoutSecondaryAttachment", var_1 + 1 );
    else
        var_4 = tablelookup( var_0, 0, "loadoutSecondaryAttachment2", var_1 + 1 );

    if ( var_4 == "" || var_4 == "none" )
        return "none";
    else
        return var_4;
}

table_getweaponbuff( var_0, var_1, var_2 )
{
    if ( var_2 == 0 )
        return tablelookup( var_0, 0, "loadoutPrimaryBuff", var_1 + 1 );
    else
        return tablelookup( var_0, 0, "loadoutSecondaryBuff", var_1 + 1 );
}

_ID32338( var_0, var_1, var_2 )
{
    return "none";
}

table_getweaponreticle( var_0, var_1, var_2 )
{
    return "none";
}

_ID32330( var_0, var_1, var_2 )
{
    return tablelookup( var_0, 0, "loadoutEquipment", var_1 + 1 );
}

_ID32333( var_0, var_1, var_2 )
{
    return tablelookup( var_0, 0, "loadoutPerk" + var_2, var_1 + 1 );
}

_ID32334( var_0, var_1 )
{
    return tablelookup( var_0, 0, "loadoutTeamPerk", var_1 + 1 );
}

_ID32332( var_0, var_1 )
{
    return tablelookup( var_0, 0, "loadoutOffhand", var_1 + 1 );
}

_ID32331( var_0, var_1, var_2 )
{
    return tablelookup( var_0, 0, "loadoutStreak" + var_2, var_1 + 1 );
}

_ID32329( var_0, var_1 )
{
    return tablelookup( var_0, 0, "loadoutCharacterType", var_1 + 1 );
}

_ID20129( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "streaktype_support":
            self._ID31894 = "support";
            break;
        case "streaktype_specialist":
            self._ID31894 = "specialist";
            break;
        default:
            self._ID31894 = "assault";
    }
}

_ID15127( var_0 )
{
    if ( !isdefined( var_0 ) )
        return "streaktype_assault";

    switch ( var_0 )
    {
        case "support":
            return "streaktype_support";
        case "specialist":
            return "streaktype_specialist";
        case "assault":
            return "streaktype_assault";
        default:
            return "streaktype_assault";
    }
}

giveloadout( var_0, var_1, var_2 )
{
    self.gettingloadout = 1;
    self takeallweapons();
    self.changingweapon = undefined;
    var_3 = "none";

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    var_4 = 0;
    self._ID30966 = [];
    var_5 = undefined;
    var_6 = 0;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
    var_10 = [];

    if ( issubstr( var_1, "axis" ) )
        var_3 = "axis";
    else if ( issubstr( var_1, "allies" ) )
        var_3 = "allies";

    if ( var_3 != "none" )
    {
        var_11 = maps\mp\_utility::_ID14933( var_1 );
        self.class_num = var_11;
        self.teamname = var_3;
        var_12 = "none";
        var_13 = "none";
        var_14 = "none";
        var_15 = getmatchrulesdata( "defaultClasses", var_3, var_11, "class", "weaponSetups", 0, "weapon" );

        if ( var_15 == "none" )
        {
            var_15 = "iw6_knifeonly";
            var_16 = "none";
            var_12 = "none";
            var_13 = "none";
        }
        else
        {
            var_16 = getmatchrulesdata( "defaultClasses", var_3, var_11, "class", "weaponSetups", 0, "attachment", 0 );
            var_12 = getmatchrulesdata( "defaultClasses", var_3, var_11, "class", "weaponSetups", 0, "attachment", 1 );
            var_13 = getmatchrulesdata( "defaultClasses", var_3, var_11, "class", "weaponSetups", 0, "attachment", 2 );
        }

        var_17 = getmatchrulesdata( "defaultClasses", var_3, var_11, "class", "weaponSetups", 0, "buff" );
        var_18 = getmatchrulesdata( "defaultClasses", var_3, var_11, "class", "weaponSetups", 0, "camo" );
        var_19 = getmatchrulesdata( "defaultClasses", var_3, var_11, "class", "weaponSetups", 0, "reticle" );
        var_20 = getmatchrulesdata( "defaultClasses", var_3, var_11, "class", "weaponSetups", 1, "weapon" );
        var_21 = getmatchrulesdata( "defaultClasses", var_3, var_11, "class", "weaponSetups", 1, "attachment", 0 );
        var_14 = getmatchrulesdata( "defaultClasses", var_3, var_11, "class", "weaponSetups", 1, "attachment", 1 );
        var_22 = getmatchrulesdata( "defaultClasses", var_3, var_11, "class", "weaponSetups", 1, "buff" );
        var_23 = getmatchrulesdata( "defaultClasses", var_3, var_11, "class", "weaponSetups", 1, "camo" );
        var_24 = getmatchrulesdata( "defaultClasses", var_3, var_11, "class", "weaponSetups", 1, "reticle" );

        if ( ( var_15 == "throwingknife" || var_15 == "none" ) && var_20 != "none" )
        {
            var_15 = var_20;
            var_16 = var_21;
            var_12 = var_14;
            var_17 = var_22;
            var_18 = var_23;
            var_19 = var_24;
            var_20 = "none";
            var_21 = "none";
            var_14 = "none";
            var_22 = "specialty_null";
            var_23 = "none";
            var_24 = "none";
        }
        else if ( ( var_15 == "throwingknife" || var_15 == "none" ) && var_20 == "none" )
        {
            var_6 = 1;
            var_15 = "iw6_p226";
            var_16 = "tactical";
        }

        var_25 = getmatchrulesdata( "defaultClasses", var_3, var_11, "class", "perks", 0 );
        var_26 = getmatchrulesdata( "defaultClasses", var_3, var_11, "class", "perks", 5 );

        if ( var_26 == "specialty_null" )
        {
            var_7 = "none";
            var_8 = "none";
            var_9 = "none";
        }
        else
        {
            var_7 = recipe_getkillstreak( var_3, var_11, var_26, 0 );
            var_8 = recipe_getkillstreak( var_3, var_11, var_26, 1 );
            var_9 = recipe_getkillstreak( var_3, var_11, var_26, 2 );
        }

        var_27 = getmatchrulesdata( "defaultClasses", var_3, var_11, "class", "perks", 1 );

        if ( var_27 == "specialty_null" )
            var_27 = "none";

        if ( getmatchrulesdata( "defaultClasses", var_3, var_11, "juggernaut" ) )
        {
            thread maps\mp\_utility::recipeclassapplyjuggernaut( maps\mp\_utility::_ID18666() );
            self._ID18666 = 1;
            self.juggmovespeedscaler = 0.7;
        }
        else if ( maps\mp\_utility::_ID18666() )
        {
            self notify( "lost_juggernaut" );
            self._ID18666 = 0;
            self._ID21667 = 1;
        }
    }
    else if ( issubstr( var_1, "custom" ) )
    {
        var_28 = maps\mp\_utility::_ID14933( var_1 );
        self.class_num = var_28;
        var_15 = cac_getweapon( var_28, 0 );
        var_16 = cac_getweaponattachment( var_28, 0 );
        var_12 = cac_getweaponattachmenttwo( var_28, 0 );
        var_13 = _ID6400( var_28, 0 );
        var_17 = cac_getweaponbuff( var_28, 0 );
        var_18 = cac_getweaponcamo( var_28, 0 );
        var_19 = cac_getweaponreticle( var_28, 0 );
        var_20 = cac_getweapon( var_28, 1 );
        var_21 = cac_getweaponattachment( var_28, 1 );
        var_14 = cac_getweaponattachmenttwo( var_28, 1 );
        var_22 = cac_getweaponbuff( var_28, 1 );
        var_23 = cac_getweaponcamo( var_28, 1 );
        var_24 = cac_getweaponreticle( var_28, 1 );
        var_25 = _ID6396( var_28 );
        var_27 = cac_getsecondarygrenade( var_28 );
        var_26 = cac_getperk( var_28, 5 );
        self.character_type = _ID6392( var_28 );
    }
    else if ( var_1 == "gamemode" )
    {
        var_28 = maps\mp\_utility::_ID14933( var_1 );
        self.class_num = var_28;
        var_29 = self.pers["gamemodeLoadout"];
        var_15 = common_scripts\utility::_ID32831( isdefined( var_29["loadoutPrimary"] ), var_29["loadoutPrimary"], "none" );
        var_16 = common_scripts\utility::_ID32831( isdefined( var_29["loadoutPrimaryAttachment"] ), var_29["loadoutPrimaryAttachment"], "none" );
        var_12 = common_scripts\utility::_ID32831( isdefined( var_29["loadoutPrimaryAttachment2"] ), var_29["loadoutPrimaryAttachment2"], "none" );
        var_13 = common_scripts\utility::_ID32831( isdefined( var_29["loadoutPrimaryAttachment3"] ), var_29["loadoutPrimaryAttachment3"], "none" );
        var_17 = common_scripts\utility::_ID32831( isdefined( var_29["loadoutPrimaryBuff"] ), var_29["loadoutPrimaryBuff"], "specialty_null" );
        var_18 = common_scripts\utility::_ID32831( isdefined( var_29["loadoutPrimaryCamo"] ), var_29["loadoutPrimaryCamo"], "none" );
        var_19 = common_scripts\utility::_ID32831( isdefined( var_29["loadoutPrimaryReticle"] ), var_29["loadoutPrimaryReticle"], "none" );
        var_20 = common_scripts\utility::_ID32831( isdefined( var_29["loadoutSecondary"] ), var_29["loadoutSecondary"], "none" );
        var_21 = common_scripts\utility::_ID32831( isdefined( var_29["loadoutSecondaryAttachment"] ), var_29["loadoutSecondaryAttachment"], "none" );
        var_14 = common_scripts\utility::_ID32831( isdefined( var_29["loadoutSecondaryAttachment2"] ), var_29["loadoutSecondaryAttachment2"], "none" );
        var_22 = common_scripts\utility::_ID32831( isdefined( var_29["loadoutSecondaryBuff"] ), var_29["loadoutSecondaryBuff"], "specialty_null" );
        var_23 = common_scripts\utility::_ID32831( isdefined( var_29["loadoutSecondaryCamo"] ), var_29["loadoutSecondaryCamo"], "none" );
        var_24 = common_scripts\utility::_ID32831( isdefined( var_29["loadoutSecondaryReticle"] ), var_29["loadoutSecondaryReticle"], "none" );
        var_10 = common_scripts\utility::_ID32831( isdefined( var_29["loadoutPerks"] ), var_29["loadoutPerks"], [] );

        if ( ( var_15 == "throwingknife" || var_15 == "none" ) && var_20 != "none" )
        {
            var_15 = var_20;
            var_16 = var_21;
            var_12 = var_14;
            var_17 = var_22;
            var_18 = var_23;
            var_19 = var_24;
            var_20 = "none";
            var_21 = "none";
            var_14 = "none";
            var_22 = "specialty_null";
            var_23 = "none";
            var_24 = "none";
        }
        else if ( ( var_15 == "throwingknife" || var_15 == "none" ) && var_20 == "none" )
        {
            var_6 = 1;
            var_15 = "iw6_p226";
            var_16 = "tactical";
        }

        var_25 = var_29["loadoutEquipment"];
        var_27 = var_29["loadoutOffhand"];

        if ( var_27 == "specialty_null" )
            var_27 = "none";

        if ( level._ID19262 && isdefined( var_29["loadoutStreakType"] ) && var_29["loadoutStreakType"] != "specialty_null" )
        {
            var_26 = var_29["loadoutStreakType"];
            var_7 = var_29["loadoutKillstreak1"];
            var_8 = var_29["loadoutKillstreak2"];
            var_9 = var_29["loadoutKillstreak3"];
        }
        else if ( level._ID19262 && isdefined( self._ID31894 ) )
            var_26 = _ID15127( self._ID31894 );
        else
        {
            var_26 = "streaktype_assault";
            var_7 = "none";
            var_8 = "none";
            var_9 = "none";
        }

        if ( var_29["loadoutJuggernaut"] )
        {
            self.health = self.maxhealth;
            thread maps\mp\_utility::recipeclassapplyjuggernaut( maps\mp\_utility::_ID18666() );
            self._ID18666 = 1;
            self.juggmovespeedscaler = 0.7;
        }
        else if ( maps\mp\_utility::_ID18666() )
        {
            self notify( "lost_juggernaut" );
            self._ID18666 = 0;
            self._ID21667 = 1;
        }
    }
    else if ( var_1 == "juggernaut" )
    {
        var_15 = "iw6_minigunjugg";
        var_16 = "none";
        var_12 = "none";
        var_13 = "none";
        var_17 = "specialty_null";
        var_18 = "none";
        var_19 = "none";
        var_20 = "iw6_p226jugg";
        var_21 = "none";
        var_14 = "none";
        var_22 = "specialty_null";
        var_23 = "none";
        var_24 = "none";
        var_25 = "mortar_shelljugg_mp";
        var_26 = _ID15127( self._ID31894 );
        var_27 = "none";
    }
    else if ( var_1 == "juggernaut_recon" )
    {
        var_15 = "iw6_riotshieldjugg";
        var_16 = "none";
        var_12 = "none";
        var_13 = "none";
        var_17 = "specialty_null";
        var_18 = "none";
        var_19 = "none";
        var_20 = "iw6_magnumjugg";
        var_21 = "none";
        var_14 = "none";
        var_22 = "specialty_null";
        var_23 = "none";
        var_24 = "none";
        var_25 = "specialty_null";
        var_26 = _ID15127( self._ID31894 );
        var_27 = "smoke_grenadejugg_mp";
    }
    else if ( var_1 == "juggernaut_maniac" )
    {
        var_15 = "iw6_knifeonlyjugg";
        var_16 = "none";
        var_12 = "none";
        var_13 = "none";
        var_17 = "specialty_null";
        var_18 = "none";
        var_19 = "none";
        var_20 = "none";
        var_21 = "none";
        var_14 = "none";
        var_22 = "specialty_null";
        var_23 = "none";
        var_24 = "none";
        var_25 = "throwingknifejugg_mp";
        var_26 = _ID15127( self._ID31894 );
        var_27 = "none";
    }
    else if ( maps\mp\_utility::_ID18801( var_1, "juggernaut_" ) )
    {
        var_30 = [[ level.mapcustomjuggsetclass ]]( var_1 );
        var_15 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutPrimary"] ), var_30["loadoutPrimary"], "none" );
        var_16 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutPrimaryAttachment"] ), var_30["loadoutPrimaryAttachment"], "none" );
        var_12 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutPrimaryAttachment2"] ), var_30["loadoutPrimaryAttachment2"], "none" );
        var_13 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutPrimaryAttachment3"] ), var_30["loadoutPrimaryAttachment3"], "none" );
        var_17 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutPrimaryBuff"] ), var_30["loadoutPrimaryBuff"], "specialty_null" );
        var_18 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutPrimaryCamo"] ), var_30["loadoutPrimaryCamo"], "none" );
        var_19 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutPrimaryReticle"] ), var_30["loadoutPrimaryReticle"], "none" );
        var_20 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutSecondary"] ), var_30["loadoutSecondary"], "none" );
        var_21 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutSecondaryAttachment"] ), var_30["loadoutSecondaryAttachment"], "none" );
        var_14 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutSecondaryAttachment2"] ), var_30["loadoutSecondaryAttachment2"], "none" );
        var_22 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutSecondaryBuff"] ), var_30["loadoutSecondaryBuff"], "specialty_null" );
        var_23 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutSecondaryCamo"] ), var_30["loadoutSecondaryCamo"], "none" );
        var_24 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutSecondaryReticle"] ), var_30["loadoutSecondaryReticle"], "none" );
        var_25 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutEquipment"] ), var_30["loadoutEquipment"], "none" );
        var_27 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutOffhand"] ), var_30["loadoutOffhand"], "none" );
        var_26 = _ID15127( self._ID31894 );
    }
    else if ( var_1 == "reconAgent" )
    {
        var_15 = "iw6_riotshield";
        var_16 = "none";
        var_12 = "none";
        var_13 = "none";
        var_17 = "specialty_null";
        var_18 = "none";
        var_19 = "none";
        var_20 = "iw6_mp443";
        var_21 = "none";
        var_14 = "none";
        var_22 = "specialty_null";
        var_23 = "none";
        var_24 = "none";
        var_25 = "specialty_null";
        var_26 = "streaktype_assault";
        var_27 = "none";
        var_7 = "none";
        var_8 = "none";
        var_9 = "none";
    }
    else if ( var_1 == "callback" )
    {
        if ( !isdefined( self.classcallback ) )
            common_scripts\utility::error( "self.classCallback function reference required for class 'callback'" );

        var_30 = [[ self.classcallback ]]();

        if ( !isdefined( var_30 ) )
            common_scripts\utility::error( "array required from self.classCallback for class 'callback'" );

        var_15 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutPrimary"] ), var_30["loadoutPrimary"], "none" );
        var_16 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutPrimaryAttachment"] ), var_30["loadoutPrimaryAttachment"], "none" );
        var_12 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutPrimaryAttachment2"] ), var_30["loadoutPrimaryAttachment2"], "none" );
        var_13 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutPrimaryAttachment3"] ), var_30["loadoutPrimaryAttachment3"], "none" );
        var_17 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutPrimaryBuff"] ), var_30["loadoutPrimaryBuff"], "specialty_null" );
        var_18 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutPrimaryCamo"] ), var_30["loadoutPrimaryCamo"], "none" );
        var_19 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutPrimaryReticle"] ), var_30["loadoutPrimaryReticle"], "none" );
        var_20 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutSecondary"] ), var_30["loadoutSecondary"], "none" );
        var_21 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutSecondaryAttachment"] ), var_30["loadoutSecondaryAttachment"], "none" );
        var_14 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutSecondaryAttachment2"] ), var_30["loadoutSecondaryAttachment2"], "none" );
        var_22 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutSecondaryBuff"] ), var_30["loadoutSecondaryBuff"], "specialty_null" );
        var_23 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutSecondaryCamo"] ), var_30["loadoutSecondaryCamo"], "none" );
        var_24 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutSecondaryReticle"] ), var_30["loadoutSecondaryReticle"], "none" );
        var_25 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutEquipment"] ), var_30["loadoutEquipment"], "none" );
        var_27 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutOffhand"] ), var_30["loadoutOffhand"], "none" );
        var_26 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutStreakType"] ), var_30["loadoutStreakType"], "none" );
        var_7 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutStreak1"] ), var_30["loadoutStreak1"], "none" );
        var_8 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutStreak2"] ), var_30["loadoutStreak2"], "none" );
        var_9 = common_scripts\utility::_ID32831( isdefined( var_30["loadoutStreak3"] ), var_30["loadoutStreak3"], "none" );
        self.character_type = var_30["loadoutCharacterType"];
    }
    else
    {
        var_28 = maps\mp\_utility::_ID14933( var_1 );
        self.class_num = var_28;
        var_15 = _ID32335( level.classtablename, var_28, 0 );
        var_16 = _ID32336( level.classtablename, var_28, 0, 0 );
        var_12 = _ID32336( level.classtablename, var_28, 0, 1 );
        var_13 = _ID32336( level.classtablename, var_28, 0, 2 );
        var_17 = table_getweaponbuff( level.classtablename, var_28, 0 );
        var_18 = _ID32338( level.classtablename, var_28, 0 );
        var_19 = table_getweaponreticle( level.classtablename, var_28, 0 );
        var_20 = _ID32335( level.classtablename, var_28, 1 );
        var_21 = _ID32336( level.classtablename, var_28, 1, 0 );
        var_14 = _ID32336( level.classtablename, var_28, 1, 1 );
        var_22 = table_getweaponbuff( level.classtablename, var_28, 1 );
        var_23 = _ID32338( level.classtablename, var_28, 1 );
        var_24 = table_getweaponreticle( level.classtablename, var_28, 1 );
        var_25 = _ID32330( level.classtablename, var_28, 0 );
        var_26 = "specialty_null";
        var_27 = "specialty_null";
        self.character_type = _ID32329( level.classtablename, var_28 );
    }

    var_15 = common_scripts\utility::_ID32831( var_15 == "uav", "iw6_knifeonlyfast", var_15 );
    var_20 = common_scripts\utility::_ID32831( var_20 == "uav", "iw6_knifeonlyfast", var_20 );
    var_20 = common_scripts\utility::_ID32831( var_20 == "laser_designator", "iw6_pdwauto", var_20 );
    _ID20129( var_26 );
    var_31 = issubstr( var_1, "custom" );
    var_32 = issubstr( var_1, "recipe" );
    var_33 = var_1 == "gamemode";
    var_34 = var_1 == "callback";

    if ( !var_33 && !var_32 && !var_34 )
    {
        if ( !_ID18854( var_15 ) || level._ID25418 && var_31 && !self isitemunlocked( var_15 ) )
            var_15 = _ID32335( level.classtablename, 10, 0 );

        if ( !isvalidattachment( var_16, var_15 ) || level._ID25418 && var_31 && !isattachmentunlocked( var_15, var_16 ) )
            var_16 = _ID32336( level.classtablename, 10, 0, 0 );

        if ( !isvalidattachment( var_12, var_15 ) || level._ID25418 && var_31 && !isattachmentunlocked( var_15, var_12 ) )
            var_12 = _ID32336( level.classtablename, 10, 0, 1 );

        if ( !isvalidattachment( var_13, var_15 ) || level._ID25418 && var_31 && !isattachmentunlocked( var_15, var_13 ) )
            var_13 = _ID32336( level.classtablename, 10, 0, 2 );

        if ( !_ID18862( var_17, var_15 ) || level._ID25418 && var_31 && !isweaponbuffunlocked( var_15, var_17 ) )
            var_17 = table_getweaponbuff( level.classtablename, 10, 0 );

        if ( !_ID18843( var_18 ) || level._ID25418 && var_31 && !_ID18580( var_15, var_18 ) )
            var_18 = _ID32338( level.classtablename, 10, 0 );

        if ( !_ID18855( var_19 ) )
            var_19 = table_getweaponreticle( level.classtablenum, 10, 0 );

        if ( !isvalidattachment( var_21, var_20 ) || level._ID25418 && var_31 && !isattachmentunlocked( var_20, var_21 ) )
            var_21 = _ID32336( level.classtablename, 10, 1, 0 );

        if ( !isvalidattachment( var_14, var_20 ) || level._ID25418 && var_31 && !isattachmentunlocked( var_20, var_14 ) )
            var_14 = _ID32336( level.classtablename, 10, 1, 1 );

        if ( !_ID18862( var_22, var_20 ) || level._ID25418 && var_31 && !self isitemunlocked( var_20 + " " + var_22 ) )
            var_22 = table_getweaponbuff( level.classtablename, 10, 1 );

        if ( !_ID18843( var_23 ) || level._ID25418 && var_31 && !_ID18580( var_20, var_23 ) )
            var_23 = _ID32338( level.classtablename, 10, 1 );

        if ( !_ID18855( var_24 ) )
            var_24 = table_getweaponreticle( level.classtablename, 10, 1 );

        if ( !_ID18846( var_25 ) || level._ID25418 && var_31 && !self isitemunlocked( var_25 ) )
            var_25 = _ID32330( level.classtablename, 10, 0 );

        if ( !_ID18850( var_27 ) )
            var_27 = _ID32332( level.classtablename, 10 );
    }

    maps\mp\_utility::_clearperks();
    _detachall();

    if ( level.diehardmode )
        maps\mp\_utility::_ID15611( "specialty_pistoldeath", 0 );

    if ( !maps\mp\_utility::_ID18363() )
        _ID20127( var_25, var_27, var_10, var_1 != "gamemode", var_1, var_3 );

    self._ID30899 = 0;

    if ( !maps\mp\_utility::_ID18666() && isdefined( self.avoidkillstreakonspawntimer ) && self.avoidkillstreakonspawntimer > 0 )
        thread maps\mp\perks\_perks::giveperksafterspawn();

    var_35 = !maps\mp\_utility::perksenabled() || !maps\mp\_utility::_hasperk( "specialty_twoprimaries" );

    if ( var_20 != "none" && !isvalidsecondary( var_20, 0, var_35 ) )
    {
        var_20 = "none";
        var_21 = "none";
        var_14 = "none";
        var_22 = "specialty_null";
        var_23 = "none";
        var_24 = "none";
    }

    self._ID20132 = var_15;

    if ( isdefined( var_18 ) )
        self.loadoutprimarycamo = int( tablelookup( "mp/camoTable.csv", 1, var_18, 4 ) );

    self._ID20138 = var_20;

    if ( isdefined( var_23 ) )
        self.loadoutsecondarycamo = int( tablelookup( "mp/camoTable.csv", 1, var_23, 4 ) );

    self._ID20133 = [];

    if ( isdefined( var_16 ) && var_16 != "none" )
        self._ID20133[self._ID20133.size] = var_16;

    if ( isdefined( var_12 ) && var_12 != "none" )
        self._ID20133[self._ID20133.size] = var_12;

    if ( isdefined( var_13 ) && var_13 != "none" )
        self._ID20133[self._ID20133.size] = var_13;

    self._ID20139 = [];

    if ( isdefined( var_21 ) && var_21 != "none" )
        self._ID20139[self._ID20139.size] = var_21;

    if ( isdefined( var_14 ) && var_14 != "none" )
        self._ID20139[self._ID20139.size] = var_14;

    if ( !issubstr( var_15, "iw5" ) && !issubstr( var_15, "iw6" ) )
        self.loadoutprimarycamo = 0;

    if ( !issubstr( var_20, "iw5" ) && !issubstr( var_20, "iw6" ) )
        self.loadoutsecondarycamo = 0;

    self.loadoutprimaryreticle = int( tablelookup( "mp/reticleTable.csv", 1, var_19, 5 ) );
    self._ID20142 = int( tablelookup( "mp/reticleTable.csv", 1, var_24, 5 ) );

    if ( !issubstr( var_15, "iw5" ) && !issubstr( var_15, "iw6" ) )
        self.loadoutprimaryreticle = 0;

    if ( !issubstr( var_20, "iw5" ) && !issubstr( var_20, "iw6" ) )
        self._ID20142 = 0;

    maps\mp\_utility::_setactionslot( 1, "" );
    maps\mp\_utility::_setactionslot( 2, "" );
    maps\mp\_utility::_setactionslot( 3, "altMode" );
    maps\mp\_utility::_setactionslot( 4, "" );

    if ( !level.console )
    {
        maps\mp\_utility::_setactionslot( 5, "" );
        maps\mp\_utility::_setactionslot( 6, "" );
        maps\mp\_utility::_setactionslot( 7, "" );
    }

    if ( level._ID19262 && !isdefined( var_7 ) && !isdefined( var_8 ) && !isdefined( var_9 ) )
    {
        var_36 = undefined;
        var_37 = undefined;
        var_38 = undefined;
        var_39 = undefined;

        switch ( self._ID31894 )
        {
            case "support":
                var_36 = _ID32331( level.classtablename, 2, 0 );
                var_37 = _ID32331( level.classtablename, 2, 1 );
                var_38 = _ID32331( level.classtablename, 2, 2 );
                var_39 = "supportStreaks";
                break;
            case "specialist":
                var_36 = _ID32331( level.classtablename, 1, 0 );
                var_37 = _ID32331( level.classtablename, 1, 1 );
                var_38 = _ID32331( level.classtablename, 1, 2 );
                var_39 = "specialistStreaks";
                break;
            default:
                var_36 = _ID32331( level.classtablename, 0, 0 );
                var_37 = _ID32331( level.classtablename, 0, 1 );
                var_38 = _ID32331( level.classtablename, 0, 2 );
                var_39 = "assaultStreaks";
                break;
        }

        var_7 = undefined;
        var_8 = undefined;
        var_9 = undefined;

        if ( issubstr( var_1, "custom" ) )
        {
            var_7 = self getcacplayerdata( "loadouts", self.class_num, var_39, 0 );
            var_8 = self getcacplayerdata( "loadouts", self.class_num, var_39, 1 );
            var_9 = self getcacplayerdata( "loadouts", self.class_num, var_39, 2 );
        }

        if ( issubstr( var_1, "juggernaut" ) || var_33 )
        {
            foreach ( var_41 in self.killstreaks )
            {
                if ( !isdefined( var_7 ) )
                {
                    var_7 = var_41;
                    continue;
                }

                if ( !isdefined( var_8 ) )
                {
                    var_8 = var_41;
                    continue;
                }

                if ( !isdefined( var_9 ) )
                    var_9 = var_41;
            }

            if ( var_33 && self._ID31894 == "specialist" )
            {
                self.pers["gamemodeLoadout"]["loadoutKillstreak1"] = var_7;
                self.pers["gamemodeLoadout"]["loadoutKillstreak2"] = var_8;
                self.pers["gamemodeLoadout"]["loadoutKillstreak3"] = var_9;
            }
        }

        if ( !issubstr( var_1, "custom" ) && !issubstr( var_1, "juggernaut" ) && !var_33 )
        {
            var_7 = var_36;
            var_8 = var_37;
            var_9 = var_38;
        }

        if ( !isdefined( var_7 ) || var_7 == "" )
            var_7 = "none";

        if ( !isdefined( var_8 ) || var_8 == "" )
            var_8 = "none";

        if ( !isdefined( var_9 ) || var_9 == "" )
            var_9 = "none";

        if ( !_ID18849( var_7, self._ID31894 ) || var_31 && !self isitemunlocked( var_7 ) || !_ID18849( var_8, self._ID31894 ) || var_31 && !self isitemunlocked( var_8 ) || !_ID18849( var_9, self._ID31894 ) || var_31 && !self isitemunlocked( var_9 ) )
        {
            var_7 = "none";
            var_8 = "none";
            var_9 = "none";
        }
    }
    else if ( !level._ID19262 )
    {
        var_7 = "none";
        var_8 = "none";
        var_9 = "none";
    }

    _ID28767( var_7, var_8, var_9 );

    if ( !isagent( self ) && ( _ID16386() || self.class == "callback" ) && !issubstr( self.class, "juggernaut" ) && !issubstr( self.lastclass, "juggernaut" ) && !issubstr( var_1, "juggernaut" ) )
    {
        if ( maps\mp\_utility::_ID35914() || self.lastclass != "" )
        {
            var_43 = [];
            var_44 = [];
            var_45 = 0;
            var_46 = self.pers["killstreaks"];

            if ( var_46.size > 5 )
            {
                for ( var_47 = 5; var_47 < var_46.size; var_47++ )
                {
                    var_43[var_45] = var_46[var_47]._ID31889;
                    var_44[var_45] = var_46[var_47]._ID19121;
                    var_45++;
                }
            }

            if ( var_46.size )
            {
                for ( var_47 = 1; var_47 < 4; var_47++ )
                {
                    if ( isdefined( var_46[var_47] ) && isdefined( var_46[var_47]._ID31889 ) && var_46[var_47].available && !var_46[var_47].isspecialist )
                    {
                        var_43[var_45] = var_46[var_47]._ID31889;
                        var_44[var_45] = var_46[var_47]._ID19121;
                        var_45++;
                    }
                }
            }

            self notify( "givingLoadout" );
            maps\mp\killstreaks\_killstreaks::clearkillstreaks();

            for ( var_47 = 0; var_47 < var_43.size; var_47++ )
                maps\mp\killstreaks\_killstreaks::_ID15602( var_43[var_47], undefined, undefined, undefined, undefined, var_44[var_47] );
        }
    }

    if ( !issubstr( var_1, "juggernaut" ) )
    {
        if ( _ID16386() )
        {
            maps\mp\_utility::_ID17531( "mostclasseschanged", 1 );
            self notify( "changed_class" );
        }

        self.pers["lastClass"] = self.class;
        self.lastclass = self.class;
    }

    if ( isdefined( self._ID14071 ) )
    {
        self.pers["class"] = self._ID14071;
        self.pers["lastClass"] = self._ID14071;
        self.class = self._ID14071;
        self.lastclass = self._ID14071;
        self._ID14071 = undefined;
    }

    var_48 = [ var_16, var_12 ];

    if ( maps\mp\_utility::perksenabled() && maps\mp\_utility::_hasperk( "specialty_extra_attachment" ) )
        var_48[var_48.size] = var_13;

    var_49 = 0;

    foreach ( var_51 in var_48 )
    {
        if ( maps\mp\_utility::getattachmenttype( var_51 ) == "rail" )
        {
            var_49 = 1;
            break;
        }
    }

    if ( !var_49 )
        self.loadoutprimaryreticle = 0;

    var_53 = buildweaponname( var_15, var_48, self.loadoutprimarycamo, self.loadoutprimaryreticle );
    maps\mp\_utility::_giveweapon( var_53 );

    if ( !isai( self ) )
    {
        self._ID27301 = undefined;
        self switchtoweapon( var_53 );
    }

    var_54 = maps\mp\_utility::_ID14903( var_53 );

    if ( maps\mp\gametypes\_weapons::_ID18766( var_53 ) && level._ID17628 )
        self notify( "weapon_change",  var_53  );

    if ( var_2 )
        self setspawnweapon( var_53 );

    if ( var_6 )
    {
        self setweaponammoclip( self._ID24978, 0 );
        self setweaponammostock( self._ID24978, 0 );
    }

    maps\mp\gametypes\_weapons::updatetogglescopestate( var_53 );

    if ( var_20 == "none" )
        var_55 = "none";
    else
    {
        var_48 = [ var_21 ];

        if ( maps\mp\_utility::perksenabled() && maps\mp\_utility::_hasperk( "specialty_extra_attachment" ) )
            var_48[var_48.size] = var_14;

        var_55 = buildweaponname( var_20, var_48, self.loadoutsecondarycamo, self._ID20142 );
        maps\mp\_utility::_giveweapon( var_55 );
        var_54 = maps\mp\_utility::_ID14903( var_55 );
        maps\mp\gametypes\_weapons::updatetogglescopestate( var_55 );
    }

    self._ID24978 = var_53;
    self._ID27984 = var_55;
    self.pers["primaryWeapon"] = var_53;
    self.pers["secondaryWeapon"] = var_55;
    maps\mp\gametypes\_teams::_ID29189();
    self._ID18785 = weaponclass( self._ID24978 ) == "sniper";
    maps\mp\gametypes\_weapons::_ID34567();
    maps\mp\perks\_perks::cac_selector();
    var_56 = isai( self ) && issquadsmode() && !maps\mp\_utility::_ID36859();

    if ( !maps\mp\_utility::_ID18666() && ( !isai( self ) || var_56 ) && !var_33 )
    {
        var_57 = 0;

        if ( var_25 == "specialty_null" )
            var_57 += 1;

        if ( var_27 == "specialty_null" || var_27 == "none" )
            var_57 += 1;

        if ( var_15 == "iw6_knifeonly" || var_15 == "iw6_knifeonlyfast" )
            var_57 += 1;

        if ( var_20 == "none" || var_20 == "iw6_knifeonlyfast" )
            var_57 += 1;

        if ( !isvalidperkweight( 8 + var_57, self.pers["loadoutPerks"], 1 ) )
        {
            maps\mp\_utility::_clearperks();
            self setclientomnvar( "ui_spawn_abilities1", 0 );
            self setclientomnvar( "ui_spawn_abilities2", 0 );
            self.pers["loadoutPerks"] = [];
        }
    }

    self.gettingloadout = 0;
    self notify( "changed_kit" );
    self notify( "giveLoadout" );
}

hasvalidationinfraction()
{
    return isdefined( self.pers ) && isdefined( self.pers["validationInfractions"] ) && self.pers["validationInfractions"] > 0;
}

recordvalidationinfraction()
{
    if ( isdefined( self.pers ) && isdefined( self.pers["validationInfractions"] ) )
        self.pers["validationInfractions"] = self.pers["validationInfractions"] + 1;
}

isvalidperkweight( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1;

    var_3 = 0;

    foreach ( var_5 in var_1 )
    {
        switch ( var_5 )
        {
            case "specialty_null":
                var_3 += 0;
                continue;
            case "specialty_fastsprintrecovery":
            case "specialty_pitcher":
            case "specialty_sprintreload":
            case "specialty_silentkill":
            case "specialty_paint":
            case "specialty_falldamage":
            case "specialty_extra_equipment":
            case "specialty_gambler":
                var_3 += 1;
                continue;
            case "specialty_stun_resistance":
            case "specialty_hardline":
            case "specialty_blindeye":
            case "specialty_sharp_focus":
            case "specialty_quickswap":
            case "specialty_bulletaccuracy":
            case "specialty_fastreload":
            case "specialty_lightweight":
            case "specialty_marathon":
            case "specialty_quieter":
            case "specialty_scavenger":
            case "specialty_detectexplosive":
            case "specialty_selectivehearing":
            case "specialty_regenfaster":
            case "_specialty_blastshield":
            case "specialty_extra_deadly":
            case "specialty_extraammo":
            case "specialty_boom":
                var_3 += 2;
                continue;
            case "specialty_incog":
            case "specialty_twoprimaries":
            case "specialty_extra_attachment":
            case "specialty_stalker":
            case "specialty_quickdraw":
            case "specialty_gpsjammer":
            case "specialty_comexp":
                var_3 += 3;
                continue;
            case "specialty_explosivedamage":
                var_3 += 4;
                continue;
            case "specialty_deadeye":
                var_3 += 5;
                continue;
            default:
                if ( var_2 )
                {

                }

                continue;
        }
    }

    if ( var_3 > var_0 && var_2 )
        recordvalidationinfraction();

    return var_3 <= var_0;
}

_detachall()
{
    if ( isdefined( self._ID26332 ) )
        maps\mp\_utility::riotshield_detach( 1 );

    if ( isdefined( self._ID26333 ) )
        maps\mp\_utility::riotshield_detach( 0 );

    self._ID16417 = 0;
    self detachall();
}

_ID18734( var_0 )
{
    var_1 = tablelookup( "mp/perktable.csv", 1, var_0, 8 );

    if ( var_1 == "" || var_1 == "specialty_null" )
        return 0;

    if ( !self isitemunlocked( var_1 ) )
        return 0;

    return 1;
}

getperkupgrade( var_0 )
{
    var_1 = tablelookup( "mp/perktable.csv", 1, var_0, 8 );

    if ( var_1 == "" || var_1 == "specialty_null" )
        return "specialty_null";

    if ( !self isitemunlocked( var_1 ) )
        return "specialty_null";

    return var_1;
}

_ID20127( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = self;

    if ( maps\mp\_utility::bot_is_fireteam_mode() && isbot( self ) )
    {
        if ( !isdefined( self._ID13079 ) )
            return;

        var_6 = self._ID13079;
    }
    else if ( isai( self ) )
    {
        if ( var_3 )
        {
            var_0 = maps\mp\perks\_perks::validateequipment( var_0, 1 );
            var_1 = maps\mp\perks\_perks::validateequipment( var_1, 0 );
        }

        maps\mp\gametypes\_weapons::lethalstowed_clear();
        self._ID20130 = var_0;
        self.loadoutperkoffhand = var_1;
        maps\mp\_utility::giveperkequipment( var_0, 1 );
        maps\mp\_utility::_ID15613( var_1, 0 );

        if ( !isdefined( self.pers["loadoutPerks"] ) )
            self.pers["loadoutPerks"] = [];

        if ( isdefined( var_2 ) && var_2.size > 0 )
        {
            self.pers["loadoutPerks"] = var_2;
            maps\mp\perks\_abilities::_ID15614( var_2, 0 );
        }
        else if ( maps\mp\_utility::perksenabled() )
        {
            var_7 = self.pers["loadoutPerks"];

            if ( isdefined( var_7 ) && var_7.size > 0 && !maps\mp\_utility::_ID18666() )
                maps\mp\perks\_abilities::_ID15614( var_7, 1 );
        }

        return;
    }

    if ( !isdefined( self.class_num ) )
        return;

    if ( !maps\mp\_utility::_ID18666() )
    {
        var_8 = [];

        if ( isdefined( var_2 ) && var_2.size > 0 )
        {
            var_8 = var_2;
            self.pers["loadoutPerks"] = var_8;
            maps\mp\perks\_abilities::_ID15614( var_8, 0 );
        }
        else if ( !maps\mp\_utility::perksenabled() )
            self.pers["loadoutPerks"] = var_8;
        else
        {
            if ( _ID16386() )
            {
                for ( var_9 = 0; var_9 < 7; var_9++ )
                {
                    for ( var_10 = 0; var_10 < 5; var_10++ )
                    {
                        var_11 = 0;

                        if ( var_5 != "none" )
                        {
                            var_12 = maps\mp\_utility::_ID14933( var_4 );
                            var_11 = getmatchrulesdata( "defaultClasses", var_5, var_12, "class", "abilitiesPicked", var_9, var_10 );
                        }
                        else
                            var_11 = self getcacplayerdata( "loadouts", self.class_num, "abilitiesPicked", var_9, var_10 );

                        if ( isdefined( var_11 ) && var_11 )
                        {
                            var_13 = tablelookup( "mp/cacAbilityTable.csv", 0, var_9 + 1, 4 + var_10 );
                            var_8[var_8.size] = var_13;
                        }
                    }
                }

                self.pers["loadoutPerks"] = var_8;
            }
            else
                var_8 = self.pers["loadoutPerks"];

            maps\mp\perks\_abilities::_ID15614( var_8, 1 );
        }

        var_14 = [ 0, 0 ];
        var_15 = self.pers["loadoutPerks"];

        for ( var_16 = 0; var_16 < var_15.size; var_16++ )
        {
            var_17 = int( tablelookup( "mp/killCamAbilitiesBitMaskTable.csv", 1, var_15[var_16], 0 ) );

            if ( var_17 == 0 )
                continue;

            var_18 = int( ( var_17 - 1 ) / 24 );
            var_19 = 1 << ( var_17 - 1 ) % 24;
            var_14[var_18] |= var_19;
        }

        self setclientomnvar( "ui_spawn_abilities1", var_14[0] );
        self setclientomnvar( "ui_spawn_abilities2", var_14[1] );
        self.abilityflags = var_14;
    }

    if ( var_3 )
    {
        var_0 = maps\mp\perks\_perks::validateequipment( var_0, 1 );
        var_1 = maps\mp\perks\_perks::validateequipment( var_1, 0 );
    }

    maps\mp\gametypes\_weapons::lethalstowed_clear();
    self._ID20130 = var_0;
    self.loadoutperkoffhand = var_1;
    maps\mp\_utility::giveperkequipment( var_0, 1 );
    maps\mp\_utility::_ID15613( var_1, 0 );
}

trackriotshield_ontrophystow()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );

    for (;;)
    {
        self waittill( "grenade_pullback",  var_0  );

        if ( var_0 != "trophy_mp" )
            continue;

        if ( !isdefined( self._ID26332 ) )
            continue;

        maps\mp\_utility::_ID26327( 1 );
        self waittill( "offhand_end" );

        if ( maps\mp\gametypes\_weapons::_ID18766( self getcurrentweapon() ) && isdefined( self._ID26333 ) )
            maps\mp\_utility::_ID26327( 0 );
    }
}

_ID33321()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self.hasriotshield = maps\mp\_utility::_ID26325();
    self._ID16417 = maps\mp\gametypes\_weapons::_ID18766( self._ID8715 );

    if ( self.hasriotshield )
    {
        if ( self._ID16417 )
            maps\mp\_utility::riotshield_attach( 1, maps\mp\_utility::riotshield_getmodel() );
        else
            maps\mp\_utility::riotshield_attach( 0, maps\mp\_utility::riotshield_getmodel() );
    }

    thread trackriotshield_ontrophystow();

    for (;;)
    {
        self waittill( "weapon_change",  var_0  );

        if ( var_0 == "none" )
            continue;

        var_1 = maps\mp\gametypes\_weapons::_ID18766( var_0 );
        var_2 = !var_1 && maps\mp\_utility::_ID26325();

        if ( var_1 )
        {
            if ( !isdefined( self._ID26332 ) )
            {
                if ( isdefined( self._ID26333 ) )
                    maps\mp\_utility::_ID26327( 0 );
                else
                    maps\mp\_utility::riotshield_attach( 1, maps\mp\_utility::riotshield_getmodel() );
            }
        }
        else if ( var_2 )
        {
            if ( !isdefined( self._ID26333 ) )
            {
                if ( isdefined( self._ID26332 ) )
                    maps\mp\_utility::_ID26327( 1 );
                else
                    maps\mp\_utility::riotshield_attach( 0, maps\mp\_utility::riotshield_getmodel() );
            }
        }
        else
        {
            if ( isdefined( self._ID26332 ) )
                maps\mp\_utility::riotshield_detach( 1 );

            if ( isdefined( self._ID26333 ) )
                maps\mp\_utility::riotshield_detach( 0 );
        }

        self.hasriotshield = var_1 || var_2;
        self._ID16417 = var_1;
    }
}

buildweaponname( var_0, var_1, var_2, var_3 )
{
    var_1 = common_scripts\utility::array_remove( var_1, "none" );

    for ( var_4 = 0; var_4 < var_1.size; var_4++ )
        var_1[var_4] = maps\mp\_utility::attachmentmap_tounique( var_1[var_4], var_0 );

    var_5 = "";

    if ( issubstr( var_0, "iw5" ) || issubstr( var_0, "iw6" ) )
    {
        var_6 = var_0 + "_mp";
        var_7 = var_0.size;
        var_5 = getsubstr( var_0, 4, var_7 );
    }
    else
        var_6 = var_0;

    var_8 = maps\mp\_utility::getweaponclass( var_0 );
    var_9 = var_8 == "weapon_sniper" || var_8 == "weapon_dmr" || var_0 == "iw6_dlcweap02";
    var_10 = 0;
    var_11 = 0;

    foreach ( var_13 in var_1 )
    {
        if ( maps\mp\_utility::getattachmenttype( var_13 ) == "rail" )
        {
            var_11 = 1;
            var_10 = 1;
            break;
        }
    }

    if ( var_9 && !var_11 )
        var_1[var_1.size] = var_5 + "scope";

    if ( !var_10 && isdefined( var_3 ) )
        var_3 = 0;

    if ( isdefined( var_1.size ) && var_1.size )
        var_1 = common_scripts\utility::alphabetize( var_1 );

    foreach ( var_13 in var_1 )
        var_6 += ( "_" + var_13 );

    if ( issubstr( var_6, "iw5" ) || issubstr( var_6, "iw6" ) )
    {
        var_6 = _ID6254( var_6, var_2 );
        var_6 = buildweaponnamereticle( var_6, var_3 );
    }
    else if ( !_ID18861( var_6 + "_mp", 0 ) )
        var_6 = var_0 + "_mp";
    else
    {
        var_6 = _ID6254( var_6, var_2 );
        var_6 = buildweaponnamereticle( var_6, var_3 );
        var_6 += "_mp";
    }

    return var_6;
}

_ID6254( var_0, var_1 )
{
    if ( !isdefined( var_1 ) || var_1 <= 0 )
        return var_0;

    return var_0 + "_camo" + common_scripts\utility::_ID32831( var_1 < 10, "0", "" ) + var_1;
}

buildweaponnamereticle( var_0, var_1 )
{
    if ( !isdefined( var_1 ) || var_1 == 0 )
        return var_0;

    var_0 += ( "_scope" + var_1 );
    return var_0;
}

_ID28767( var_0, var_1, var_2 )
{
    self.killstreaks = [];
    var_3 = [];

    if ( isdefined( var_0 ) && var_0 != "none" )
    {
        var_4 = maps\mp\killstreaks\_killstreaks::_ID15382( var_0 );
        var_3[var_4] = var_0;
    }

    if ( isdefined( var_1 ) && var_1 != "none" )
    {
        var_4 = maps\mp\killstreaks\_killstreaks::_ID15382( var_1 );
        var_3[var_4] = var_1;
    }

    if ( isdefined( var_2 ) && var_2 != "none" )
    {
        var_4 = maps\mp\killstreaks\_killstreaks::_ID15382( var_2 );
        var_3[var_4] = var_2;
    }

    var_5 = 0;

    foreach ( var_4, var_7 in var_3 )
    {
        if ( var_4 > var_5 )
            var_5 = var_4;
    }

    for ( var_8 = 0; var_8 <= var_5; var_8++ )
    {
        if ( !isdefined( var_3[var_8] ) )
            continue;

        var_7 = var_3[var_8];
        self.killstreaks[var_8] = var_3[var_8];
    }
}

replenishloadout()
{
    var_0 = self.pers["team"];
    var_1 = self.pers["class"];
    var_2 = self getweaponslistall();

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = var_2[var_3];
        self givemaxammo( var_4 );
        self setweaponammoclip( var_4, 9999 );

        if ( var_4 == "claymore_mp" || var_4 == "claymore_detonator_mp" )
            self setweaponammostock( var_4, 2 );
    }

    if ( self getammocount( level._ID7326[var_1]["primary"]["type"] ) < level._ID7326[var_1]["primary"]["count"] )
        self setweaponammoclip( level._ID7326[var_1]["primary"]["type"], level._ID7326[var_1]["primary"]["count"] );

    if ( self getammocount( level._ID7326[var_1]["secondary"]["type"] ) < level._ID7326[var_1]["secondary"]["count"] )
        self setweaponammoclip( level._ID7326[var_1]["secondary"]["type"], level._ID7326[var_1]["secondary"]["count"] );
}

onplayerconnecting()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );

        if ( !isdefined( var_0.pers["class"] ) )
            var_0.pers["class"] = "";

        if ( !isdefined( var_0.pers["lastClass"] ) )
            var_0.pers["lastClass"] = "";

        var_0.class = var_0.pers["class"];
        var_0.lastclass = var_0.pers["lastClass"];
        var_0.detectexplosives = 0;
        var_0.bombsquadicons = [];
        var_0._ID5468 = [];

        if ( !isdefined( var_0.pers["validationInfractions"] ) )
            var_0.pers["validationInfractions"] = 0;
    }
}

fadeaway( var_0, var_1 )
{
    wait(var_0);
    self fadeovertime( var_1 );
    self.alpha = 0;
}

_ID28675( var_0 )
{
    self.curclass = var_0;
}

getperkforclass( var_0, var_1 )
{
    var_2 = maps\mp\_utility::_ID14933( var_1 );

    if ( issubstr( var_1, "custom" ) )
        return cac_getperk( var_2, var_0 );
    else
        return _ID32333( level.classtablename, var_2, var_0 );
}

classhasperk( var_0, var_1 )
{
    return getperkforclass( 0, var_0 ) == var_1 || getperkforclass( 1, var_0 ) == var_1 || getperkforclass( 2, var_0 ) == var_1;
}

_ID18854( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_2 = 0;

    switch ( var_0 )
    {
        case "iw6_riotshield":
        case "iw6_dlcweap02":
        case "iw6_vks":
        case "iw6_k7":
        case "iw6_honeybadger":
        case "iw6_msbs":
        case "iw6_g28":
        case "iw6_cbjms":
        case "iw6_dlcweap03":
        case "iw6_knifeonly":
        case "iw6_knifeonlyfast":
        case "iw6_kriss":
        case "iw6_microtar":
        case "iw6_pp19":
        case "iw6_vepr":
        case "iw6_ak12":
        case "iw6_arx160":
        case "iw6_bren":
        case "iw6_fads":
        case "iw6_r5rgp":
        case "iw6_sc2010":
        case "iw6_gm6":
        case "iw6_l115a3":
        case "iw6_usr":
        case "iw6_imbel":
        case "iw6_mk14":
        case "iw6_svu":
        case "iw6_fp6":
        case "iw6_maul":
        case "iw6_mts255":
        case "iw6_uts15":
        case "iw6_ameli":
        case "iw6_kac":
        case "iw6_lsat":
        case "iw6_m27":
        case "iw6_dlcweap01":
            var_2 = 1;
            break;
        case "iw6_minigunjugg":
        case "iw6_riotshieldjugg":
        case "iw6_knifeonlyjugg":
        case "iw6_axe":
        case "iw6_predatorcannon":
        case "iw6_mariachimagnum":
            if ( maps\mp\_utility::_ID18666() )
                var_2 = 1;
            else
                var_2 = 0;

            break;
        default:
            var_2 = 0;
            break;
    }

    if ( !var_2 && var_1 )
        recordvalidationinfraction();

    return var_2;
}

isvalidsecondary( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    var_3 = 0;

    switch ( var_0 )
    {
        case "none":
        case "iw6_pdwauto":
        case "iw6_p226":
        case "iw6_p226jugg":
        case "iw6_magnumjugg":
        case "iw6_mp443":
        case "iw6_pdw":
        case "iw6_magnum":
        case "iw6_m9a1":
        case "iw6_mk32":
        case "iw6_rgm":
        case "iw6_panzerfaust3":
            var_3 = 1;
            break;
        default:
            if ( var_2 == 0 )
                var_3 = _ID18854( var_0, 0 );

            break;
    }

    if ( !var_3 && var_1 )
        recordvalidationinfraction();

    return var_3;
}

isvalidattachment( var_0, var_1, var_2 )
{
    var_3 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    switch ( var_0 )
    {
        case "none":
        case "akimbo":
        case "shotgun":
        case "gl":
        case "tactical":
        case "firetypeburst":
        case "firetypeauto":
        case "firetypesingle":
        case "acog":
        case "ammoslug":
        case "barrelbored":
        case "barrelrange":
        case "eotech":
        case "flashsuppress":
        case "fmj":
        case "grip":
        case "heartbeat":
        case "hybrid":
        case "ironsight":
        case "reflex":
        case "rof":
        case "rshieldradar":
        case "rshieldscrambler":
        case "rshieldspikes":
        case "silencer":
        case "thermal":
        case "tracker":
        case "vzscope":
        case "xmags":
            var_3 = 1;
            break;
        default:
            var_3 = 0;
            break;
    }

    if ( var_3 && var_0 != "none" )
    {
        var_4 = maps\mp\_utility::_ID15471( var_1 );
        var_3 = common_scripts\utility::array_contains( var_4, var_0 );
    }

    if ( !var_3 && var_2 )
        recordvalidationinfraction();

    return var_3;
}

isattachmentunlocked( var_0, var_1 )
{
    if ( maps\mp\_utility::_ID37547() )
        return 1;

    if ( 1 )
        return 1;

    var_2 = 0;
    var_3 = 2;
    var_4 = 4;
    var_5 = self getrankedplayerdata( "weaponRank", var_0 );
    var_6 = int( tablelookup( "mp/weaponRankTable.csv", var_2, maps\mp\_utility::getweaponclass( var_0 ), var_3 ) );
    var_7 = int( tablelookup( "mp/weaponRankTable.csv", var_6, var_1, var_4 ) );

    if ( var_5 >= var_7 )
        return 1;

    return 0;
}

_ID18862( var_0, var_1 )
{
    var_2 = maps\mp\_utility::getweaponclass( var_1 );

    if ( var_2 == "weapon_assault" )
    {
        switch ( var_0 )
        {
            case "specialty_sharp_focus":
            case "specialty_reducedsway":
            case "specialty_bulletpenetration":
            case "specialty_marksman":
            case "specialty_bling":
            case "specialty_holdbreathwhileads":
                return 1;
            default:
                self._ID9929 = 250;
                return 0;
        }
    }
    else if ( var_2 == "weapon_smg" )
    {
        switch ( var_0 )
        {
            case "specialty_sharp_focus":
            case "specialty_reducedsway":
            case "specialty_marksman":
            case "specialty_bling":
            case "specialty_longerrange":
            case "specialty_fastermelee":
                return 1;
            default:
                self._ID9929 = 250;
                return 0;
        }
    }
    else if ( var_2 == "weapon_lmg" )
    {
        switch ( var_0 )
        {
            case "specialty_sharp_focus":
            case "specialty_reducedsway":
            case "specialty_bulletpenetration":
            case "specialty_lightweight":
            case "specialty_marksman":
            case "specialty_bling":
                return 1;
            default:
                self._ID9929 = 250;
                return 0;
        }
    }
    else if ( var_2 == "weapon_sniper" )
    {
        switch ( var_0 )
        {
            case "specialty_sharp_focus":
            case "specialty_reducedsway":
            case "specialty_bulletpenetration":
            case "specialty_lightweight":
            case "specialty_marksman":
            case "specialty_bling":
                return 1;
            default:
                self._ID9929 = 250;
                return 0;
        }
    }
    else if ( var_2 == "weapon_shotgun" )
    {
        switch ( var_0 )
        {
            case "specialty_sharp_focus":
            case "specialty_marksman":
            case "specialty_bling":
            case "specialty_longerrange":
            case "specialty_fastermelee":
            case "specialty_moredamage":
                return 1;
            default:
                self._ID9929 = 250;
                return 0;
        }
    }
    else if ( var_2 == "weapon_riot" )
    {
        switch ( var_0 )
        {
            case "specialty_lightweight":
            case "specialty_fastermelee":
                return 1;
            default:
                self._ID9929 = 250;
                return 0;
        }
    }
    else
    {
        self._ID9929 = 250;
        return 0;
    }
}

isweaponbuffunlocked( var_0, var_1 )
{
    if ( maps\mp\_utility::_ID37547() )
        return 1;

    var_2 = 0;
    var_3 = 4;
    var_4 = 4;
    var_5 = self getrankedplayerdata( "weaponRank", var_0 );
    var_6 = int( tablelookup( "mp/weaponRankTable.csv", var_2, maps\mp\_utility::getweaponclass( var_0 ), var_3 ) );
    var_7 = int( tablelookup( "mp/weaponRankTable.csv", var_6, var_1, var_4 ) );

    if ( var_5 >= var_7 )
        return 1;

    return 0;
}

_ID18843( var_0 )
{
    switch ( var_0 )
    {
        case "none":
        case "red":
        case "snow":
        case "brush":
        case "autumn":
        case "ocean":
        case "tan":
        case "caustic":
        case "dark":
        case "green":
        case "net":
        case "trail":
        case "winter":
        case "gold":
        case "clan01":
        case "clan02":
        case "camo03":
        case "camo04":
        case "camo05":
        case "camo06":
        case "camo07":
        case "camo08":
        case "camo09":
        case "camo10":
        case "camo11":
        case "camo12":
        case "camo13":
        case "camo14":
        case "camo15":
        case "camo16":
        case "camo17":
        case "camo18":
        case "camo19":
        case "camo20":
        case "camo21":
        case "camo22":
        case "camo23":
        case "camo24":
        case "camo25":
        case "camo26":
        case "camo27":
        case "camo28":
        case "camo29":
        case "camo30":
        case "camo31":
        case "camo32":
        case "camo33":
            return 1;
        default:
            recordvalidationinfraction();
            return 0;
    }
}

_ID18855( var_0 )
{
    switch ( var_0 )
    {
        case "none":
        case "ret01":
        case "ret02":
        case "ret03":
        case "ret04":
        case "ret05":
        case "acogdef":
        case "acog01":
        case "acog02":
        case "acog03":
        case "acog04":
        case "acog05":
        case "eotechdef":
        case "eotech01":
        case "eotech02":
        case "eotech03":
        case "eotech04":
        case "eotech05":
        case "hybriddef":
        case "hybrid01":
        case "hybrid02":
        case "hybrid03":
        case "hybrid04":
        case "hybrid05":
        case "reflexdef":
        case "reflex01":
        case "reflex02":
        case "reflex03":
        case "reflex04":
        case "reflex05":
        case "retclan01":
        case "retdlc01":
        case "retdlc02":
        case "retdlc03":
        case "retdlc04":
        case "retdlc05":
        case "retdlc06":
        case "retdlc07":
        case "retdlc08":
        case "retdlc09":
        case "retdlc10":
        case "retdlc11":
        case "retdlc12":
        case "retdlc13":
        case "retdlc14":
        case "retdlc15":
        case "retdlc16":
        case "retdlc17":
        case "retdlc18":
        case "retdlc19":
        case "retdlc20":
        case "retdlc21":
        case "retdlc22":
        case "retdlc23":
        case "retdlc24":
        case "retdlc25":
        case "retdlc26":
        case "retdlc27":
        case "retdlc28":
        case "retdlc29":
        case "retdlc30":
        case "retdlc31":
            return 1;
        default:
            recordvalidationinfraction();
            return 0;
    }
}

_ID18580( var_0, var_1 )
{
    if ( maps\mp\_utility::_ID37547() )
        return 1;

    if ( !isdefined( level.challengeinfo["ch_" + var_0 + "_" + var_1] ) )
        return 1;

    return 1;
}

_ID18846( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_2 = 1;
    var_0 = common_scripts\utility::_ID32831( var_0 == "none", "specialty_null", var_0 );

    if ( maps\mp\perks\_perks::validateequipment( var_0, 1, var_1 ) != var_0 )
    {
        var_2 = 0;

        if ( var_1 )
            recordvalidationinfraction();
    }

    return var_2;
}

_ID18850( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_2 = 1;
    var_0 = common_scripts\utility::_ID32831( var_0 == "none", "specialty_null", var_0 );

    if ( maps\mp\perks\_perks::validateequipment( var_0, 0, var_1 ) != var_0 )
    {
        if ( var_1 )
            recordvalidationinfraction();
    }

    return var_2;
}

isperk( var_0 )
{
    return int( tablelookup( "mp/perktable.csv", 1, var_0, 0 ) );
}

_ID18674( var_0 )
{
    return maps\mp\_utility::_ID15099( var_0 ) != -1;
}

isvalidperk1( var_0 )
{
    switch ( var_0 )
    {
        case "specialty_blindeye":
        case "specialty_paint":
        case "specialty_fastreload":
        case "specialty_scavenger":
        case "specialty_longersprint":
            return 1;
        default:
            return 1;
    }
}

isvalidperk2( var_0, var_1 )
{
    if ( !isdefined( var_1 ) || var_1 != "specialty_anytwo" )
    {
        switch ( var_0 )
        {
            case "specialty_hardline":
            case "specialty_assists":
            case "specialty_coldblooded":
            case "specialty_twoprimaries":
            case "_specialty_blastshield":
            case "specialty_quickdraw":
                return 1;
            default:
                return 1;
        }
    }

    return 1;
}

isvalidperk3( var_0, var_1 )
{
    if ( !isdefined( var_1 ) || var_1 != "specialty_anytwo" )
    {
        switch ( var_0 )
        {
            case "specialty_bulletaccuracy":
            case "specialty_paint":
            case "specialty_quieter":
            case "specialty_detectexplosive":
            case "specialty_stalker":
                return 1;
            default:
                return 1;
        }
    }

    return 1;
}

_ID18861( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( !isdefined( level._ID36281 ) )
    {
        level._ID36281 = [];

        foreach ( var_3 in level._ID36267 )
            level._ID36281[var_3] = 1;
    }

    if ( isdefined( level._ID36281[var_0] ) )
        return 1;

    if ( var_1 )
        recordvalidationinfraction();

    return 0;
}

_ID18849( var_0, var_1 )
{
    var_2 = maps\mp\_utility::isassaultkillstreak( var_0 ) || maps\mp\_utility::issupportkillstreak( var_0 ) || maps\mp\_utility::_ID18795( var_0 ) || var_0 == "none";

    if ( isdefined( var_1 ) )
    {
        if ( var_1 == "assault" )
            var_2 = maps\mp\_utility::isassaultkillstreak( var_0 ) || var_0 == "none";
        else if ( var_1 == "support" )
            var_2 = maps\mp\_utility::issupportkillstreak( var_0 ) || var_0 == "none";
        else if ( var_1 == "specialist" )
            var_2 = maps\mp\_utility::_ID18795( var_0 ) || var_0 == "none";
    }

    if ( !var_2 )
        recordvalidationinfraction();

    return var_2;
}

_ID16386()
{
    var_0 = 0;

    if ( isdefined( self.lastclass ) && self.lastclass != self.class || !isdefined( self.lastclass ) )
        var_0 = 1;

    if ( level._ID14086 == "infect" && ( !isdefined( self.last_infected_class ) || self.last_infected_class != self.infected_class ) )
        var_0 = 1;

    return var_0;
}

getnumabilitycategories()
{
    return 7;
}

getnumsubability()
{
    return 5;
}
