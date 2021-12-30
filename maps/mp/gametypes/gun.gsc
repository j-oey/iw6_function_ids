// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\gametypes\_globallogic::_ID17631();
    maps\mp\gametypes\_callbacksetup::_ID29168();
    maps\mp\gametypes\_globallogic::_ID29168();
    _ID37966();

    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = ::initializematchrules;
        [[ level.initializematchrules ]]();
        level thread maps\mp\_utility::_ID25726();
    }
    else
    {
        maps\mp\_utility::_ID25718( level._ID14086, 10 );
        var_0 = level._ID37387.size;
        setdynamicdvar( "scr_gun_scorelimit", var_0 );
        maps\mp\_utility::_ID25717( level._ID14086, var_0 );
        maps\mp\_utility::_ID25714( level._ID14086, 1 );
        maps\mp\_utility::_ID25724( level._ID14086, 0 );
        maps\mp\_utility::_ID25712( level._ID14086, 0 );
        maps\mp\_utility::_ID25706( level._ID14086, 0 );
        level._ID20678 = 0;
        level._ID20676 = 0;
        level._ID20680 = 0;
    }

    _ID28878();
    setteammode( "ffa" );
    level._ID32653 = 0;
    level._ID37122 = 1;
    level._ID19262 = 0;
    level._ID32097 = 0;
    level._ID32098 = 0;
    level._ID3995 = 1;
    level._ID22892 = ::_ID22892;
    level._ID22905 = ::_ID22905;
    level._ID22902 = ::_ID22902;
    level.getspawnpoint = ::getspawnpoint;
    level._ID22886 = ::_ID22886;
    level._ID22913 = ::_ID22913;
    level._ID22888 = ::_ID22888;

    if ( level._ID20676 || level._ID20680 )
        level._ID21286 = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
}

initializematchrules()
{
    maps\mp\_utility::_ID28682( 1 );
    level._ID20678 = getmatchrulesdata( "gunData", "randomize" );
    var_0 = level._ID37387.size;
    setdynamicdvar( "scr_gun_scorelimit", var_0 );
    maps\mp\_utility::_ID25717( level._ID14086, var_0 );
    setdynamicdvar( "scr_gun_winlimit", 1 );
    maps\mp\_utility::_ID25724( "gun", 1 );
    setdynamicdvar( "scr_gun_roundlimit", 1 );
    maps\mp\_utility::_ID25714( "gun", 1 );
    setdynamicdvar( "scr_gun_halftime", 0 );
    maps\mp\_utility::_ID25706( "gun", 0 );
    setdynamicdvar( "scr_gun_playerrespawndelay", 0 );
    setdynamicdvar( "scr_gun_waverespawndelay", 0 );
    setdynamicdvar( "scr_player_forcerespawn", 1 );
    setdynamicdvar( "scr_gun_promode", 0 );
}

_ID22892()
{

}

_ID22905()
{
    var_0 = maps\mp\gametypes\_rank::_ID15328( "gained_gun_score" );
    maps\mp\gametypes\_rank::registerscoreinfo( "dropped_gun_score", -1 * var_0 );
    _ID37967();
    setclientnamemode( "auto_change" );
    maps\mp\_utility::_ID28804( "allies", &"OBJECTIVES_DM" );
    maps\mp\_utility::_ID28804( "axis", &"OBJECTIVES_DM" );

    if ( level.splitscreen )
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_DM" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_DM" );
    }
    else
    {
        maps\mp\_utility::_ID28803( "allies", &"OBJECTIVES_DM_SCORE" );
        maps\mp\_utility::_ID28803( "axis", &"OBJECTIVES_DM_SCORE" );
    }

    maps\mp\_utility::setobjectivehinttext( "allies", &"OBJECTIVES_DM_HINT" );
    maps\mp\_utility::setobjectivehinttext( "axis", &"OBJECTIVES_DM_HINT" );
    level._ID30895 = ( 0, 0, 0 );
    level._ID30893 = ( 0, 0, 0 );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", "mp_dm_spawn" );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", "mp_dm_spawn" );
    level._ID20634 = maps\mp\gametypes\_spawnlogic::findboxcenter( level._ID30895, level._ID30893 );
    setmapcenter( level._ID20634 );
    var_1 = [];
    maps\mp\gametypes\_gameobjects::_ID20445( var_1 );
    level._ID25248 = 1;
    level.blockweapondrops = 1;
    level thread _ID22877();
    level._ID19262 = 0;
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0._ID37386 = 1;
        var_0._ID37391 = 0;
        var_0._ID37392 = 0;

        if ( level._ID20678 )
        {
            var_0._ID37389 = level._ID37387;
            var_0._ID37390 = [];
        }

        var_0 thread _ID25641();
        var_0 thread _ID37865();
        var_0 maps\mp\_utility::setfakeloadoutweaponslot( level._ID37387[0], 1 );
    }
}

getspawnpoint()
{
    if ( self._ID37386 )
    {
        self._ID37386 = 0;
        self.pers["class"] = "gamemode";
        self.pers["lastClass"] = "";
        self.class = self.pers["class"];
        self.lastclass = self.pers["lastClass"];

        if ( common_scripts\utility::_ID7657() )
            maps\mp\gametypes\_menus::addtoteam( "axis", 1 );
        else
            maps\mp\gametypes\_menus::addtoteam( "allies", 1 );
    }

    var_0 = maps\mp\gametypes\_spawnlogic::_ID15425( self.pers["team"] );
    var_1 = maps\mp\gametypes\_spawnscoring::_ID15344( var_0 );
    return var_1;
}

_ID22902()
{
    self.pers["gamemodeLoadout"] = level._ID37388[self.pers["team"]];
    thread waitloadoutdone();
    level notify( "spawned_player" );
}

waitloadoutdone()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self waittill( "spawned_player" );
    maps\mp\_utility::_ID15611( "specialty_bling", 0 );
    _ID37378( 1 );
}

_ID22886( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( var_3 == "MOD_FALLING" || isdefined( var_1 ) && isplayer( var_1 ) )
    {
        var_10 = maps\mp\gametypes\_weapons::_ID18766( var_4 );

        if ( var_3 == "MOD_FALLING" || var_1 == self || var_3 == "MOD_MELEE" && !var_10 )
        {
            self playlocalsound( "mp_war_objective_lost" );
            self._ID37392 = self._ID37391;
            self._ID37391 = int( max( 0, self._ID37391 - 1 ) );

            if ( self._ID37392 > self._ID37391 )
            {
                thread maps\mp\gametypes\_rank::_ID36462( "dropped_gun_rank" );
                maps\mp\gametypes\_gamescore::_ID15616( "dropped_gun_score", self, undefined, 1, 1 );
                maps\mp\_utility::setfakeloadoutweaponslot( level._ID37387[self._ID37391], 1 );
            }

            if ( var_3 == "MOD_MELEE" )
            {
                if ( self._ID37392 )
                {
                    var_1 thread maps\mp\gametypes\_rank::_ID36462( "dropped_enemy_gun_rank" );
                    var_1 thread maps\mp\gametypes\_rank::giverankxp( "dropped_enemy_gun_rank" );
                }

                var_1.assists++;
                var_1 maps\mp\gametypes\_persistence::_ID31528( "round", "sguardWave", var_1.assists );
            }
        }
        else if ( var_3 == "MOD_PISTOL_BULLET" || var_3 == "MOD_RIFLE_BULLET" || var_3 == "MOD_HEAD_SHOT" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH" || var_3 == "MOD_IMPACT" || var_3 == "MOD_GRENADE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_MELEE" && var_10 )
        {
            if ( var_4 != var_1._ID24978 && !var_1 _ID37555( var_4 ) )
                return;

            var_1._ID37392 = var_1._ID37391;
            var_1._ID37391++;
            var_1 thread maps\mp\gametypes\_rank::giverankxp( "gained_gun_rank" );
            maps\mp\gametypes\_gamescore::_ID15616( "gained_gun_score", var_1, self, 1, 1 );

            if ( var_1._ID37391 == level._ID37387.size - 1 )
            {
                maps\mp\_utility::_ID24645( "mp_enemy_obj_captured" );
                level thread maps\mp\_utility::_ID32672( "callout_top_gun_rank", var_1 );
            }

            if ( var_1._ID37391 < level._ID37387.size )
            {
                var_1 thread maps\mp\gametypes\_rank::_ID36462( "gained_gun_rank" );
                var_1 playlocalsound( "mp_war_objective_taken" );
                var_1 _ID37378();
                var_1 maps\mp\_utility::setfakeloadoutweaponslot( level._ID37387[var_1._ID37391], 1 );
            }
        }
    }
}

_ID37378( var_0 )
{
    var_1 = _ID37360();
    self takeallweapons();
    maps\mp\_utility::_giveweapon( var_1 );

    if ( isdefined( var_0 ) )
        self setspawnweapon( var_1 );

    self.pers["primaryWeapon"] = var_1;
    self._ID24978 = var_1;
    self givestartammo( var_1 );
    self switchtoweapon( var_1 );
    _ID37379( var_1 );
    maps\mp\gametypes\_weapons::updatetogglescopestate( var_1 );

    if ( self._ID37392 > self._ID37391 )
        thread maps\mp\gametypes\_rank::_ID36462( "dropped_gun_rank" );
    else if ( self._ID37392 < self._ID37391 )
        thread maps\mp\gametypes\_rank::_ID36462( "gained_gun_rank" );

    self._ID37392 = self._ID37391;
}

_ID37360()
{
    var_0 = level._ID37387[self._ID37391];
    return var_0;
}

_ID22913()
{
    level.finalkillcam_winner = "none";
    var_0 = _ID37358();

    if ( !isdefined( var_0 ) || !var_0.size )
        thread maps\mp\gametypes\_gamelogic::endgame( "tie", game["end_reason"]["time_limit_reached"] );
    else if ( var_0.size == 1 )
        thread maps\mp\gametypes\_gamelogic::endgame( var_0[0], game["end_reason"]["time_limit_reached"] );
    else if ( var_0[var_0.size - 1]._ID37391 > var_0[var_0.size - 2]._ID37391 )
        thread maps\mp\gametypes\_gamelogic::endgame( var_0[var_0.size - 1], game["end_reason"]["time_limit_reached"] );
    else
        thread maps\mp\gametypes\_gamelogic::endgame( "tie", game["end_reason"]["time_limit_reached"] );
}

_ID37358()
{
    var_0 = -1;
    var_1 = [];

    foreach ( var_3 in level.players )
    {
        if ( isdefined( var_3._ID37391 ) && var_3._ID37391 >= var_0 )
        {
            var_0 = var_3._ID37391;
            var_1[var_1.size] = var_3;
        }
    }

    return var_1;
}

_ID25641()
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "reload" );
        self givestartammo( self._ID24978 );
    }
}

_ID37865()
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    for (;;)
    {
        if ( maps\mp\_utility::_ID18757( self ) && self.team != "spectator" && isdefined( self._ID24978 ) && self getammocount( self._ID24978 ) == 0 )
        {
            wait 2;
            self notify( "reload" );
            wait 1;
            continue;
        }

        wait 0.05;
    }
}

_ID37966()
{
    level._ID37387 = [];
    level._ID37938 = [];
    var_0 = 0;

    if ( isusingmatchrulesdata() )
        var_0 = getmatchrulesdata( "gunData", "numGuns" );

    if ( var_0 > 20 )
        var_0 = 20;

    if ( var_0 )
    {
        for ( var_1 = 0; var_1 < var_0; var_1++ )
            level._ID37387[var_1] = getmatchrulesdata( "gunData", "guns", var_1 );
    }
    else
    {
        level._ID37387[0] = "rand_pistol";
        level._ID37387[1] = "rand_shotgun";
        level._ID37387[2] = "rand_smg";
        level._ID37387[3] = "rand_assault";
        level._ID37387[4] = "rand_lmg";
        level._ID37387[5] = "rand_dmr";
        level._ID37387[6] = "rand_smg";
        level._ID37387[7] = "rand_assault";
        level._ID37387[8] = "rand_lmg2";
        level._ID37387[9] = "rand_launcher";
        level._ID37387[10] = "rand_sniper";
        level._ID37387[11] = "rand_smg";
        level._ID37387[12] = "rand_assault2";
        level._ID37387[13] = "rand_shotgun2";
        level._ID37387[14] = "rand_dmr";
        level._ID37387[15] = "rand_sniper2";
        level._ID37387[16] = "iw6_magnum_mp_acogpistol_akimbo";
        level._ID37387[17] = "iw6_knifeonly_mp";
    }
}

_ID37967()
{
    level._ID37938 = [];
    _ID36921();

    for ( var_0 = 0; var_0 < level._ID37387.size; var_0++ )
    {
        var_1 = level._ID37387[var_0];

        if ( maps\mp\_utility::_ID18801( var_1, "rand_" ) )
        {
            level._ID37387[var_0] = _ID37363( var_1 );
            continue;
        }

        var_2 = maps\mp\_utility::_ID14903( level._ID37387[var_0] );
        level._ID37938[var_2] = 1;
    }

    level._ID37938 = undefined;
}

_ID28878()
{
    level._ID37388["axis"]["loadoutPrimary"] = "iw6_sc2010";
    level._ID37388["axis"]["loadoutPrimaryAttachment"] = "none";
    level._ID37388["axis"]["loadoutPrimaryAttachment2"] = "none";
    level._ID37388["axis"]["loadoutPrimaryBuff"] = "specialty_null";
    level._ID37388["axis"]["loadoutPrimaryCamo"] = "none";
    level._ID37388["axis"]["loadoutPrimaryReticle"] = "none";
    level._ID37388["axis"]["loadoutSecondary"] = "none";
    level._ID37388["axis"]["loadoutSecondaryAttachment"] = "none";
    level._ID37388["axis"]["loadoutSecondaryAttachment2"] = "none";
    level._ID37388["axis"]["loadoutSecondaryBuff"] = "specialty_null";
    level._ID37388["axis"]["loadoutSecondaryCamo"] = "none";
    level._ID37388["axis"]["loadoutSecondaryReticle"] = "none";
    level._ID37388["axis"]["loadoutEquipment"] = "specialty_null";
    level._ID37388["axis"]["loadoutOffhand"] = "none";
    level._ID37388["axis"]["loadoutStreakType"] = "assault";
    level._ID37388["axis"]["loadoutKillstreak1"] = "none";
    level._ID37388["axis"]["loadoutKillstreak2"] = "none";
    level._ID37388["axis"]["loadoutKillstreak3"] = "none";
    level._ID37388["axis"]["loadoutPerks"] = [ "specialty_quickswap", "specialty_marathon" ];
    level._ID37388["axis"]["loadoutJuggernaut"] = 0;
    level._ID37388["allies"] = level._ID37388["axis"];
}

_ID36921()
{
    level._ID38303 = [];
    var_0 = 0;

    for (;;)
    {
        var_1 = tablelookupbyrow( "mp/gunGameWeapons.csv", var_0, 0 );

        if ( var_1 == "" )
            break;

        if ( !isdefined( level._ID38303[var_1] ) )
            level._ID38303[var_1] = [];

        var_2 = tablelookupbyrow( "mp/gunGameWeapons.csv", var_0, 5 );

        if ( var_2 == "" || getdvarint( var_2, 0 ) == 1 )
        {
            var_3 = [];
            var_3["weapon"] = tablelookupbyrow( "mp/gunGameWeapons.csv", var_0, 1 );
            var_3["min"] = int( tablelookupbyrow( "mp/gunGameWeapons.csv", var_0, 2 ) );
            var_3["max"] = int( tablelookupbyrow( "mp/gunGameWeapons.csv", var_0, 3 ) );
            var_3["perk"] = tablelookupbyrow( "mp/gunGameWeapons.csv", var_0, 4 );
            level._ID38303[var_1][level._ID38303[var_1].size] = var_3;
        }

        var_0++;
    }
}

_ID37363( var_0 )
{
    var_1 = level._ID38303[var_0];

    if ( isdefined( var_1 ) && var_1.size > 0 )
    {
        var_2 = "";
        var_3 = undefined;
        var_4 = 0;

        for (;;)
        {
            var_5 = randomintrange( 0, var_1.size );
            var_3 = var_1[var_5];
            var_6 = maps\mp\_utility::_ID14903( var_3["weapon"] );

            if ( !isdefined( level._ID37938[var_6] ) || var_4 > var_1.size )
            {
                level._ID37938[var_6] = 1;
                var_2 = var_3["weapon"];
                break;
            }

            var_4++;
        }

        if ( var_2 == var_6 )
        {
            var_7 = randomintrange( var_3["min"], var_3["max"] + 1 );
            var_2 = _ID37690( var_2, var_7 );
        }

        return var_2;
    }
    else
        return "none";
}

_ID37690( var_0, var_1 )
{
    var_2 = [];
    var_3 = 0;

    if ( var_1 > 0 )
    {
        var_4 = maps\mp\_utility::_ID15471( var_0 );

        if ( var_4.size > 0 )
        {
            var_5 = _ID15457( var_4 );
            var_6 = var_5.size;

            for ( var_7 = 0; var_7 < var_1; var_7++ )
            {
                var_8 = "";

                while ( var_8 == "" && var_6 > 0 )
                {
                    var_6--;
                    var_9 = randomint( var_5.size );

                    if ( maps\mp\gametypes\sotf::attachmentcheck( var_5[var_9], var_2 ) )
                    {
                        var_8 = maps\mp\_utility::attachmentmap_tounique( var_5[var_9], var_0 );
                        var_2[var_2.size] = var_8;

                        if ( maps\mp\_utility::getattachmenttype( var_8 ) == "rail" )
                            var_3 = 1;
                    }
                }
            }
        }
    }

    var_10 = 0;
    var_11 = 0;
    var_12 = maps\mp\gametypes\_class::buildweaponname( var_0, var_2, var_10, var_11 );
    return var_12;
}

_ID15457( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        switch ( var_3 )
        {
            case "firetypeburst":
            case "firetypeauto":
            case "firetypesingle":
            case "shotgun":
            case "gl":
            case "ammoslug":
            case "silencer":
                continue;
            default:
                var_1[var_1.size] = var_3;
        }
    }

    return var_1;
}

_ID37379( var_0 )
{
    if ( maps\mp\gametypes\_weapons::isknifeonly( var_0 ) )
    {
        maps\mp\_utility::giveperkequipment( "throwingknife_mp", 1 );
        self._ID20130 = "throwingknife_mp";
        maps\mp\_utility::_ID15611( "specialty_extra_deadly", 0 );
        maps\mp\_utility::_ID15611( "specialty_scavenger", 0 );
    }
    else
    {
        self takeweapon( "throwingknife_mp" );
        maps\mp\_utility::giveperkequipment( "specialty_null", 1 );
    }
}

_ID37555( var_0 )
{
    return var_0 == "throwingknife_mp" && isdefined( self._ID20130 ) && self._ID20130 == "throwingknife_mp";
}

_ID22888( var_0, var_1, var_2 )
{
    var_3 = 0;

    if ( var_0 == "gained_gun_score" || var_0 == "dropped_gun_score" )
        var_3 = maps\mp\gametypes\_rank::_ID15328( var_0 );

    return var_3;
}
