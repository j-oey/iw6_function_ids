// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    if ( getdvar( "mapname" ) == "mp_background" )
        return;

    maps\mp\gametypes\_globallogic::_ID17631();
    maps\mp\gametypes\_callbacksetup::_ID29168();
    maps\mp\gametypes\_globallogic::_ID29168();

    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = ::initializematchrules;
        [[ level.initializematchrules ]]();
        level thread maps\mp\_utility::_ID25726();
    }
    else
    {
        maps\mp\_utility::_ID25717( level._ID14086, 65 );
        maps\mp\_utility::_ID25718( level._ID14086, 10 );
        maps\mp\_utility::_ID25714( level._ID14086, 1 );
        maps\mp\_utility::_ID25724( level._ID14086, 1 );
        maps\mp\_utility::_ID25712( level._ID14086, 0 );
        maps\mp\_utility::_ID25706( level._ID14086, 0 );
        level._ID20678 = 0;
        level._ID20676 = 0;
        level._ID20680 = 0;
    }

    _ID28827();
    level._ID32653 = 1;
    level.overridecrateusetime = 500;
    level._ID22892 = ::_ID22892;
    level._ID22905 = ::_ID22905;
    level.getspawnpoint = ::getspawnpoint;
    level._ID22902 = ::_ID22902;
    level._ID22869 = ::_ID22869;
    level._ID8769 = ::_ID30463;
    level.cratekill = ::cratekill;
    level._ID23556 = ::_ID23556;
    level.iconvisall = ::iconvisall;
    level._ID22508 = ::_ID22508;
    level._ID32097 = 0;
    level._ID32098 = 0;
    level._ID35160 = "littlebird_neutral_mp";
    level._ID34740 = [];
    level._ID11410 = 1;
    level.firstcratedrop = 1;

    if ( level._ID20676 || level._ID20680 )
        level._ID21286 = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    game["dialog"]["gametype"] = "hunted";

    if ( getdvarint( "g_hardcore" ) )
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];

    game["dialog"]["offense_obj"] = "sotf_hint";
    game["dialog"]["defense_obj"] = "sotf_hint";
}

initializematchrules()
{
    maps\mp\_utility::_ID28682();
    setdynamicdvar( "scr_sotf_crateamount", getmatchrulesdata( "sotfData", "crateAmount" ) );
    setdynamicdvar( "scr_sotf_crategunamount", getmatchrulesdata( "sotfData", "crateGunAmount" ) );
    setdynamicdvar( "scr_sotf_cratetimer", getmatchrulesdata( "sotfData", "crateDropTimer" ) );
    setdynamicdvar( "scr_sotf_roundlimit", 1 );
    maps\mp\_utility::_ID25714( "sotf", 1 );
    setdynamicdvar( "scr_sotf_winlimit", 1 );
    maps\mp\_utility::_ID25724( "sotf", 1 );
    setdynamicdvar( "scr_sotf_halftime", 0 );
    maps\mp\_utility::_ID25706( "sotf", 0 );
    setdynamicdvar( "scr_sotf_promode", 0 );
}

_ID22892()
{
    level._ID1644["signal_chest_drop"] = loadfx( "smoke/signal_smoke_airdrop" );
    level._ID1644["signal_chest_drop_mover"] = loadfx( "smoke/airdrop_flare_mp_effect_now" );
}

_ID22905()
{
    setclientnamemode( "auto_change" );

    if ( !isdefined( game["switchedsides"] ) )
        game["switchedsides"] = 0;

    if ( game["switchedsides"] )
    {
        var_0 = game["attackers"];
        var_1 = game["defenders"];
        game["attackers"] = var_1;
        game["defenders"] = var_0;
    }

    var_2 = &"OBJECTIVES_WAR";
    var_3 = &"OBJECTIVES_WAR_SCORE";
    var_4 = &"OBJECTIVES_WAR_HINT";
    maps\mp\_utility::_ID28804( "allies", var_2 );
    maps\mp\_utility::_ID28804( "axis", var_2 );

    if ( level.splitscreen )
    {
        maps\mp\_utility::_ID28803( "allies", var_2 );
        maps\mp\_utility::_ID28803( "axis", var_2 );
    }
    else
    {
        maps\mp\_utility::_ID28803( "allies", var_3 );
        maps\mp\_utility::_ID28803( "axis", var_3 );
    }

    maps\mp\_utility::setobjectivehinttext( "allies", var_4 );
    maps\mp\_utility::setobjectivehinttext( "axis", var_4 );
    initspawns();
    var_5 = [];
    maps\mp\gametypes\_gameobjects::_ID20445( var_5 );
    level thread _ID30460();
}

initspawns()
{
    level._ID30895 = ( 0, 0, 0 );
    level._ID30893 = ( 0, 0, 0 );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_tdm_spawn_allies_start" );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_tdm_spawn_axis_start" );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", "mp_tdm_spawn" );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", "mp_tdm_spawn" );
    level._ID20634 = maps\mp\gametypes\_spawnlogic::findboxcenter( level._ID30895, level._ID30893 );
    setmapcenter( level._ID20634 );
}

_ID28827()
{
    definechestweapons();
    var_0 = _ID15295( level._ID23638 );
    var_1 = maps\mp\_utility::_ID14903( var_0["name"] );
    var_2 = tablelookup( "mp/sotfWeapons.csv", 2, var_1, 0 );
    setomnvar( "ui_sotf_pistol", int( var_2 ) );
    level._ID30462["axis"]["loadoutPrimary"] = "none";
    level._ID30462["axis"]["loadoutPrimaryAttachment"] = "none";
    level._ID30462["axis"]["loadoutPrimaryAttachment2"] = "none";
    level._ID30462["axis"]["loadoutPrimaryBuff"] = "specialty_null";
    level._ID30462["axis"]["loadoutPrimaryCamo"] = "none";
    level._ID30462["axis"]["loadoutPrimaryReticle"] = "none";
    level._ID30462["axis"]["loadoutSecondary"] = var_0["name"];
    level._ID30462["axis"]["loadoutSecondaryAttachment"] = "none";
    level._ID30462["axis"]["loadoutSecondaryAttachment2"] = "none";
    level._ID30462["axis"]["loadoutSecondaryBuff"] = "specialty_null";
    level._ID30462["axis"]["loadoutSecondaryCamo"] = "none";
    level._ID30462["axis"]["loadoutSecondaryReticle"] = "none";
    level._ID30462["axis"]["loadoutEquipment"] = "throwingknife_mp";
    level._ID30462["axis"]["loadoutOffhand"] = "flash_grenade_mp";
    level._ID30462["axis"]["loadoutStreakType"] = "assault";
    level._ID30462["axis"]["loadoutKillstreak1"] = "none";
    level._ID30462["axis"]["loadoutKillstreak2"] = "none";
    level._ID30462["axis"]["loadoutKillstreak3"] = "none";
    level._ID30462["axis"]["loadoutJuggernaut"] = 0;
    level._ID30462["axis"]["loadoutPerks"] = [ "specialty_longersprint", "specialty_extra_deadly" ];
    level._ID30462["allies"] = level._ID30462["axis"];
}

getspawnpoint()
{
    var_0 = self.pers["team"];

    if ( game["switchedsides"] )
        var_0 = maps\mp\_utility::getotherteam( var_0 );

    if ( maps\mp\gametypes\_spawnlogic::_ID38029() )
    {
        var_1 = maps\mp\gametypes\_spawnlogic::_ID15350( "mp_tdm_spawn_" + var_0 + "_start" );
        var_2 = maps\mp\gametypes\_spawnlogic::_ID15349( var_1 );
    }
    else
    {
        var_1 = maps\mp\gametypes\_spawnlogic::_ID15425( var_0 );
        var_2 = maps\mp\gametypes\_spawnscoring::_ID15345( var_1 );
    }

    return var_2;
}

_ID22902()
{
    self.pers["class"] = "gamemode";
    self.pers["lastClass"] = "";
    self.class = self.pers["class"];
    self.lastclass = self.pers["lastClass"];
    self.pers["gamemodeLoadout"] = level._ID30462[self.pers["team"]];
    level notify( "sotf_player_spawned",  self  );
    self.oldprimarygun = undefined;
    self._ID21963 = undefined;
    thread waitloadoutdone();
}

waitloadoutdone()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self waittill( "giveLoadout" );
    var_0 = self getcurrentweapon();
    self setweaponammostock( var_0, 0 );
    self.oldprimarygun = var_0;
    thread _ID23556();
}

_ID22888( var_0, var_1, var_2 )
{
    if ( var_0 == "kill" )
    {
        var_3 = maps\mp\gametypes\_rank::_ID15328( "score_increment" );
        return var_3;
    }

    return 0;
}

_ID22869( var_0, var_1, var_2 )
{
    var_1 _ID23461();
    var_3 = maps\mp\gametypes\_rank::_ID15328( "score_increment" );
    level maps\mp\gametypes\_gamescore::giveteamscoreforobjective( var_1.pers["team"], var_3 );

    if ( game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level._ID23070[var_1.team]] )
        var_1._ID12872 = 1;
}

_ID30460()
{
    level thread _ID31474();
}

_ID31474()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 = getdvarint( "scr_sotf_crateamount", 1 );
    var_1 = getdvarint( "scr_sotf_cratetimer", 30 );
    level waittill( "sotf_player_spawned",  var_2  );

    for (;;)
    {
        if ( !isalive( var_2 ) )
        {
            var_2 = findnewowner( level.players );

            if ( !isdefined( var_2 ) )
                continue;

            continue;
        }

        while ( isalive( var_2 ) )
        {
            if ( level._ID11410 )
            {
                for ( var_3 = 0; var_3 < var_0; var_3++ )
                    level thread _ID30821( var_2 );

                level thread showcratesplash( "sotf_crate_incoming" );
                wait(var_1);
                continue;
            }

            wait 0.05;
        }
    }
}

showcratesplash( var_0 )
{
    foreach ( var_2 in level.players )
        var_2 thread maps\mp\gametypes\_hud_message::_ID31052( var_0 );
}

findnewowner( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( isalive( var_2 ) )
            return var_2;
    }

    level waittill( "sotf_player_spawned",  var_4  );
    return var_4;
}

_ID30821( var_0 )
{
    var_1 = common_scripts\utility::_ID15386( "sotf_chest_spawnpoint", "targetname" );

    if ( level.firstcratedrop )
    {
        var_2 = _ID14923( var_1 );
        level.firstcratedrop = 0;
    }
    else
        var_2 = _ID15293( var_1 );

    if ( isdefined( var_2 ) )
    {
        playfxatpoint( var_2 );
        level thread maps\mp\killstreaks\_airdrop::_ID10390( var_0, var_2, randomfloat( 360 ), "airdrop_sotf" );
    }
}

playfxatpoint( var_0 )
{
    var_1 = var_0 + ( 0, 0, 30 );
    var_2 = var_0 + ( 0, 0, -1000 );
    var_3 = bullettrace( var_1, var_2, 0, undefined );
    var_4 = var_3["position"] + ( 0, 0, 1 );
    var_5 = var_3["entity"];

    if ( isdefined( var_5 ) )
    {
        for ( var_6 = var_5 getlinkedparent(); isdefined( var_6 ); var_6 = var_5 getlinkedparent() )
            var_5 = var_6;
    }

    if ( isdefined( var_5 ) )
    {
        var_7 = spawn( "script_model", var_4 );
        var_7 setmodel( "tag_origin" );
        var_7.angles = ( 90, randomintrange( -180, 179 ), 0 );
        var_7 linkto( var_5 );
        thread playlinkedsmokeeffect( common_scripts\utility::_ID15033( "signal_chest_drop_mover" ), var_7 );
    }
    else
        playfx( common_scripts\utility::_ID15033( "signal_chest_drop" ), var_4 );
}

playlinkedsmokeeffect( var_0, var_1 )
{
    level endon( "game_ended" );
    wait 0.05;
    playfxontag( var_0, var_1, "tag_origin" );
    wait 6;
    stopfxontag( var_0, var_1, "tag_origin" );
    wait 0.05;
    var_1 delete();
}

_ID14923( var_0 )
{
    var_1 = undefined;
    var_2 = undefined;

    foreach ( var_4 in var_0 )
    {
        var_5 = distance2dsquared( level._ID20634, var_4.origin );

        if ( !isdefined( var_1 ) || var_5 < var_2 )
        {
            var_1 = var_4;
            var_2 = var_5;
        }
    }

    level._ID34740[level._ID34740.size] = var_1.origin;
    return var_1.origin;
}

_ID15293( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        var_3 = 0;

        if ( isdefined( level._ID34740 ) && level._ID34740.size > 0 )
        {
            foreach ( var_5 in level._ID34740 )
            {
                if ( var_0[var_2].origin == var_5 )
                {
                    var_3 = 1;
                    break;
                }
            }

            if ( var_3 )
                continue;

            var_1[var_1.size] = var_0[var_2].origin;
            continue;
        }

        var_1[var_1.size] = var_0[var_2].origin;
    }

    if ( var_1.size > 0 )
    {
        var_7 = randomint( var_1.size );
        var_8 = var_1[var_7];
        level._ID34740[level._ID34740.size] = var_8;
        return var_8;
    }

    level._ID11410 = 0;
    return undefined;
}

definechestweapons()
{
    var_0 = [];
    var_1 = [];

    for ( var_2 = 0; tablelookupbyrow( "mp/sotfWeapons.csv", var_2, 0 ) != ""; var_2++ )
    {
        var_3 = tablelookupistringbyrow( "mp/sotfWeapons.csv", var_2, 2 );
        var_4 = tablelookupistringbyrow( "mp/sotfWeapons.csv", var_2, 1 );
        var_5 = _ID18774( var_3 );

        if ( isdefined( var_4 ) && var_5 && var_4 == "weapon_pistol" )
        {
            var_6 = 30;
            var_0[var_0.size]["name"] = var_3;
            var_0[var_0.size - 1]["weight"] = var_6;
            continue;
        }

        if ( isdefined( var_4 ) && var_5 && ( var_4 == "weapon_shotgun" || var_4 == "weapon_smg" || var_4 == "weapon_assault" || var_4 == "weapon_sniper" || var_4 == "weapon_dmr" || var_4 == "weapon_lmg" || var_4 == "weapon_projectile" ) )
        {
            var_6 = 0;

            switch ( var_4 )
            {
                case "weapon_shotgun":
                    var_6 = 35;
                    break;
                case "weapon_smg":
                case "weapon_assault":
                    var_6 = 25;
                    break;
                case "weapon_sniper":
                case "weapon_dmr":
                    var_6 = 15;
                    break;
                case "weapon_lmg":
                    var_6 = 10;
                    break;
                case "weapon_projectile":
                    var_6 = 30;
                    break;
            }

            var_1[var_1.size]["name"] = var_3 + "_mp";
            var_1[var_1.size - 1]["group"] = var_4;
            var_1[var_1.size - 1]["weight"] = var_6;
            continue;
        }

        continue;
    }

    var_1 = _ID30455( var_1 );
    level._ID23638 = var_0;
    level._ID36255 = var_1;
}

_ID30463( var_0, var_1 )
{
    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_sotf", "sotf_weapon", 100, ::_ID30464, var_0, var_0, &"KILLSTREAKS_HINTS_WEAPON_PICKUP" );
}

_ID30464( var_0 )
{
    self endon( "death" );
    self endon( "restarting_physics" );
    level endon( "game_ended" );

    if ( isdefined( game["strings"][self.cratetype + "_hint"] ) )
        var_1 = game["strings"][self.cratetype + "_hint"];
    else
        var_1 = &"PLATFORM_GET_KILLSTREAK";

    var_2 = "icon_hunted";
    maps\mp\killstreaks\_airdrop::cratesetupforuse( var_1, var_2 );
    thread maps\mp\killstreaks\_airdrop::crateallcapturethink();
    childthread _ID8272( 60 );
    childthread _ID24512();
    var_3 = 0;
    var_4 = getdvarint( "scr_sotf_crategunamount", 6 );

    for (;;)
    {
        self waittill( "captured",  var_5  );
        var_5 playlocalsound( "ammo_crate_use" );
        var_6 = _ID15295( level._ID36255 );
        var_6 = getrandomattachments( var_6 );
        var_7 = var_5._ID19545;
        var_8 = var_5 getammocount( var_7 );

        if ( var_6 == var_7 )
        {
            var_5 givestartammo( var_6 );
            var_5 setweaponammostock( var_6, var_8 );
        }
        else
        {
            if ( isdefined( var_7 ) && var_7 != "none" )
            {
                var_9 = var_5 dropitem( var_7 );

                if ( isdefined( var_9 ) && var_8 > 0 )
                    var_9.targetname = "dropped_weapon";
            }

            var_5 giveweapon( var_6, 0, 0, 0, 1 );
            var_5 setweaponammostock( var_6, 0 );
            var_5 switchtoweaponimmediate( var_6 );

            if ( var_5 getweaponammoclip( var_6 ) == 1 )
                var_5 setweaponammostock( var_6, 1 );

            var_5.oldprimarygun = var_6;
        }

        var_3++;
        var_4 -= 1;

        if ( var_4 > 0 )
        {
            foreach ( var_5 in level.players )
            {
                maps\mp\_entityheadicons::setheadicon( var_5, "blitz_time_0" + var_4 + "_blue", ( 0, 0, 24 ), 14, 14, undefined, undefined, undefined, undefined, undefined, 0 );
                self._ID8250 = "blitz_time_0" + var_4 + "_blue";
            }
        }

        if ( self.cratetype == "sotf_weapon" && var_3 == getdvarint( "scr_sotf_crategunamount", 6 ) )
            maps\mp\killstreaks\_airdrop::deletecrate();
    }
}

_ID8272( var_0 )
{
    wait(var_0);

    while ( isdefined( self._ID18318 ) && self._ID18318 )
        common_scripts\utility::_ID35582();

    maps\mp\killstreaks\_airdrop::deletecrate();
}

_ID24512()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );

        if ( !isdefined( var_0 ) )
            continue;

        maps\mp\_entityheadicons::setheadicon( var_0, self._ID8250, ( 0, 0, 24 ), 14, 14, undefined, undefined, undefined, undefined, undefined, 0 );
    }
}

cratekill( var_0 )
{
    for ( var_1 = 0; var_1 < level._ID34740.size; var_1++ )
    {
        if ( var_0 != level._ID34740[var_1] )
            continue;

        level._ID34740 = common_scripts\utility::array_remove( level._ID34740, var_0 );
    }

    level._ID11410 = 1;
}

_ID18774( var_0 )
{
    var_1 = tablelookup( "mp/sotfWeapons.csv", 2, var_0, 3 );
    var_2 = tablelookup( "mp/sotfWeapons.csv", 2, var_0, 4 );

    if ( var_1 == "TRUE" && ( var_2 == "" || getdvarint( var_2, 0 ) == 1 ) )
        return 1;

    return 0;
}

_ID15295( var_0 )
{
    var_1 = _ID28659( var_0 );
    var_2 = randomint( level._ID36269["sum"] );
    var_3 = undefined;

    for ( var_4 = 0; var_4 < var_1.size; var_4++ )
    {
        if ( !var_1[var_4]["weight"] )
            continue;

        if ( var_1[var_4]["weight"] > var_2 )
        {
            var_3 = var_1[var_4];
            break;
        }
    }

    return var_3;
}

getrandomattachments( var_0 )
{
    var_1 = [];
    var_2 = [];
    var_3 = [];
    var_4 = maps\mp\_utility::_ID14903( var_0["name"] );
    var_5 = maps\mp\_utility::_ID15471( var_4 );

    if ( var_5.size > 0 )
    {
        var_6 = randomint( 5 );

        for ( var_7 = 0; var_7 < var_6; var_7++ )
        {
            var_1 = _ID15457( var_0, var_2, var_5 );

            if ( var_1.size == 0 )
                break;

            var_8 = randomint( var_1.size );
            var_2[var_2.size] = var_1[var_8];
            var_9 = maps\mp\_utility::attachmentmap_tounique( var_1[var_8], var_4 );
            var_3[var_3.size] = var_9;
        }

        var_10 = maps\mp\_utility::getweaponclass( var_0["name"] );

        if ( var_10 == "weapon_dmr" || var_10 == "weapon_sniper" || var_4 == "iw6_dlcweap02" )
        {
            var_11 = 0;

            foreach ( var_13 in var_2 )
            {
                if ( maps\mp\_utility::getattachmenttype( var_13 ) == "rail" )
                {
                    var_11 = 1;
                    break;
                }
            }

            if ( !var_11 )
            {
                var_15 = strtok( var_4, "_" )[1];
                var_3[var_3.size] = var_15 + "scope";
            }
        }

        if ( var_3.size > 0 )
        {
            var_3 = common_scripts\utility::alphabetize( var_3 );

            foreach ( var_17 in var_3 )
                var_0["name"] = var_0["name"] + "_" + var_17;
        }
    }

    return var_0["name"];
}

_ID15457( var_0, var_1, var_2 )
{
    var_3 = [];

    foreach ( var_5 in var_2 )
    {
        if ( var_5 == "gl" || var_5 == "shotgun" )
            continue;

        var_6 = attachmentcheck( var_5, var_1 );

        if ( !var_6 )
            continue;

        var_3[var_3.size] = var_5;
    }

    return var_3;
}

attachmentcheck( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( var_0 == var_1[var_2] || !maps\mp\_utility::attachmentscompatible( var_0, var_1[var_2] ) )
            return 0;
    }

    return 1;
}

_ID7126( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( var_2 == "thermal" || var_2 == "vzscope" || var_2 == "acog" || var_2 == "ironsight" )
            return 1;
    }

    return 0;
}

_ID23556()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        common_scripts\utility::_ID35582();
        var_0 = self getweaponslistprimaries();

        if ( var_0.size > 1 )
        {
            foreach ( var_2 in var_0 )
            {
                if ( var_2 == self.oldprimarygun )
                {
                    var_3 = self getammocount( var_2 );
                    var_4 = self dropitem( var_2 );

                    if ( isdefined( var_4 ) && var_3 > 0 )
                        var_4.targetname = "dropped_weapon";

                    break;
                }
            }

            var_0 = common_scripts\utility::array_remove( var_0, self.oldprimarygun );
            self.oldprimarygun = var_0[0];
        }
    }
}

_ID20249()
{
    self.pers["killChains"]++;
    maps\mp\gametypes\_persistence::_ID31528( "round", "killChains", self.pers["killChains"] );
}

_ID23461()
{
    if ( getdvarint( "scr_game_perks" ) )
    {
        switch ( self.adrenaline )
        {
            case 2:
                maps\mp\_utility::_ID15611( "specialty_fastsprintrecovery", 0 );
                thread maps\mp\gametypes\_hud_message::_ID31052( "specialty_fastsprintrecovery_sotf", self.adrenaline );
                thread _ID20249();
                break;
            case 3:
                maps\mp\_utility::_ID15611( "specialty_lightweight", 0 );
                thread maps\mp\gametypes\_hud_message::_ID31052( "specialty_lightweight_sotf", self.adrenaline );
                thread _ID20249();
                break;
            case 4:
                maps\mp\_utility::_ID15611( "specialty_stalker", 0 );
                thread maps\mp\gametypes\_hud_message::_ID31052( "specialty_stalker_sotf", self.adrenaline );
                thread _ID20249();
                break;
            case 5:
                maps\mp\_utility::_ID15611( "specialty_regenfaster", 0 );
                thread maps\mp\gametypes\_hud_message::_ID31052( "specialty_regenfaster_sotf", self.adrenaline );
                thread _ID20249();
                break;
            case 6:
                maps\mp\_utility::_ID15611( "specialty_deadeye", 0 );
                thread maps\mp\gametypes\_hud_message::_ID31052( "specialty_deadeye_sotf", self.adrenaline );
                thread _ID20249();
                break;
        }
    }
}

iconvisall( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        var_0 maps\mp\_entityheadicons::setheadicon( var_3, var_1, ( 0, 0, 24 ), 14, 14, undefined, undefined, undefined, undefined, undefined, 0 );
        self._ID8250 = var_1;
    }
}

_ID22508( var_0 )
{
    objective_playermask_showtoall( var_0 );
}

_ID28659( var_0 )
{
    level._ID36269["sum"] = 0;
    var_1 = var_0;

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( !var_1[var_2]["weight"] )
            continue;

        level._ID36269["sum"] = level._ID36269["sum"] + var_1[var_2]["weight"];
        var_1[var_2]["weight"] = level._ID36269["sum"];
    }

    return var_1;
}

_ID30455( var_0 )
{
    var_1 = [];
    var_2 = [];

    for ( var_3 = 1; var_3 < var_0.size; var_3++ )
    {
        var_4 = var_0[var_3]["weight"];
        var_1 = var_0[var_3];

        for ( var_5 = var_3 - 1; var_5 >= 0 && _ID18527( var_0[var_5]["weight"], var_4 ); var_5-- )
        {
            var_2 = var_0[var_5];
            var_0[var_5] = var_1;
            var_0[var_5 + 1] = var_2;
        }
    }

    return var_0;
}

_ID18527( var_0, var_1 )
{
    return var_0 < var_1;
}
