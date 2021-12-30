// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID27361 = [];
    level._ID36474 = getdvarint( "scr_xpscale" );

    if ( level._ID36474 > 4 || level._ID36474 < 0 )
        exitlevel( 0 );

    level._ID36474 = min( level._ID36474, 4 );
    level._ID36474 = max( level._ID36474, 0 );
    level._ID32685["axis"] = 1;
    level._ID32685["allies"] = 1;
    level._ID25421 = [];
    level._ID36280 = [];
    level._ID20757 = int( tablelookup( "mp/rankTable.csv", 0, "maxrank", 1 ) );
    level._ID20755 = int( tablelookup( "mp/rankTable.csv", 0, "maxprestige", 1 ) );
    level.maxforbotmatch = getdvarint( "max_xp_per_match", 0 );
    var_0 = 0;
    var_1 = 0;

    for ( var_0 = 0; var_0 <= min( 10, level._ID20755 ); var_0++ )
    {
        for ( var_1 = 0; var_1 <= level._ID20757; var_1++ )
            precacheshader( tablelookup( "mp/rankIconTable.csv", 0, var_1, var_0 + 1 ) );
    }

    var_2 = 0;

    for ( var_3 = tablelookup( "mp/rankTable.csv", 0, var_2, 1 ); isdefined( var_3 ) && var_3 != ""; var_3 = tablelookup( "mp/rankTable.csv", 0, var_2, 1 ) )
    {
        level._ID25421[var_2][1] = tablelookup( "mp/rankTable.csv", 0, var_2, 1 );
        level._ID25421[var_2][2] = tablelookup( "mp/rankTable.csv", 0, var_2, 2 );
        level._ID25421[var_2][3] = tablelookup( "mp/rankTable.csv", 0, var_2, 3 );
        level._ID25421[var_2][7] = tablelookup( "mp/rankTable.csv", 0, var_2, 7 );
        precachestring( tablelookupistring( "mp/rankTable.csv", 0, var_2, 16 ) );
        var_2++;
    }

    var_4 = int( tablelookup( "mp/weaponRankTable.csv", 0, "maxrank", 1 ) );

    for ( var_5 = 0; var_5 < var_4 + 1; var_5++ )
    {
        level._ID36280[var_5][1] = tablelookup( "mp/weaponRankTable.csv", 0, var_5, 1 );
        level._ID36280[var_5][2] = tablelookup( "mp/weaponRankTable.csv", 0, var_5, 2 );
        level._ID36280[var_5][3] = tablelookup( "mp/weaponRankTable.csv", 0, var_5, 3 );
    }

    maps\mp\gametypes\_missions::_ID6231();
    level thread _ID23355();
    level thread _ID22877();
}

_ID23355()
{
    level endon( "game_ended" );

    while ( !isdefined( level.players ) || !level.players.size )
        wait 0.05;

    if ( !maps\mp\_utility::_ID20673() )
    {
        if ( getdvar( "mapname" ) == "mp_rust" && randomint( 1000 ) == 999 )
        {
            level._ID23354 = level.players[0].name;
            return;
        }

        return;
    }

    if ( getdvar( "scr_patientZero" ) != "" )
    {
        level._ID23354 = getdvar( "scr_patientZero" );
        return;
    }

    return;
}

_ID18758( var_0 )
{
    if ( isdefined( level._ID27361[var_0] ) )
    {
        return 1;
        return;
    }

    return 0;
    return;
}

registerscoreinfo( var_0, var_1 )
{
    level._ID27361[var_0]["value"] = var_1;

    if ( var_0 == "kill" )
    {
        setomnvar( "ui_game_type_kill_value", int( var_1 ) );
        return;
    }
}

_ID15328( var_0 )
{
    var_1 = "scr_" + level._ID14086 + "_score_" + var_0;

    if ( getdvar( var_1 ) != "" )
    {
        return getdvarint( var_1 );
        return;
    }

    return level._ID27361[var_0]["value"];
    return;
}

_ID15327( var_0 )
{
    return level._ID27361[var_0]["label"];
}

_ID15303( var_0 )
{
    return int( level._ID25421[var_0][2] );
}

getweaponrankinfominxp( var_0 )
{
    return int( level._ID36280[var_0][1] );
}

_ID15304( var_0 )
{
    return int( level._ID25421[var_0][3] );
}

getweaponrankinfoxpamt( var_0 )
{
    return int( level._ID36280[var_0][2] );
}

_ID15302( var_0 )
{
    return int( level._ID25421[var_0][7] );
}

getweaponrankinfomaxxp( var_0 )
{
    return int( level._ID36280[var_0][3] );
}

_ID15299( var_0 )
{
    return tablelookupistring( "mp/rankTable.csv", 0, var_0, 16 );
}

_ID15300( var_0, var_1 )
{
    return tablelookup( "mp/rankIconTable.csv", 0, var_0, var_1 + 1 );
}

_ID15301( var_0 )
{
    return int( tablelookup( "mp/rankTable.csv", 0, var_0, 13 ) );
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );

        if ( !isai( var_0 ) )
        {
            if ( maps\mp\_utility::_ID20673() )
            {
                var_0.pers["activeSquadMember"] = var_0 getrankedplayerdata( "activeSquadMember" );
                var_0.pers["rankxp"] = var_0 getrankedplayerdata( "squadMembers", var_0.pers["activeSquadMember"], "squadMemXP" );
                var_1 = var_0 getrankedplayerdatareservedint( "prestigeLevel" );

                if ( !isdefined( var_0.pers["xpEarnedThisMatch"] ) )
                    var_0.pers["xpEarnedThisMatch"] = 0;
            }
            else
            {
                var_0.pers["activeSquadMember"] = var_0 getprivateplayerdata( "privateMatchActiveSquadMember" );
                var_1 = 0;
                var_0.pers["rankxp"] = 0;
            }
        }
        else
        {
            var_1 = 0;
            var_0.pers["rankxp"] = 0;
        }

        var_0.pers["prestige"] = var_1;

        if ( var_0.pers["rankxp"] < 0 )
            var_0.pers["rankxp"] = 0;

        var_2 = var_0 getrankforxp( var_0 _ID15305() );
        var_0.pers["rank"] = var_2;
        var_0 setrank( var_2, var_1 );

        if ( var_0.clientid < level._ID20746 )
        {
            setmatchdata( "players", var_0.clientid, "rank", var_2 );
            setmatchdata( "players", var_0.clientid, "Prestige", var_1 );

            if ( !isai( var_0 ) && ( maps\mp\_utility::_ID25017() || maps\mp\_utility::_ID20673() ) )
            {
                setmatchdata( "players", var_0.clientid, "isSplitscreen", var_0 issplitscreenplayer() );
                setmatchdata( "players", var_0.clientid, "activeSquadMember", var_0.pers["activeSquadMember"] );
            }
        }

        var_0.pers["participation"] = 0;
        var_0._ID36476 = 0;
        var_0._ID5481 = 0;
        var_0._ID24790 = 0;

        if ( !isdefined( var_0.pers["postGameChallenges"] ) )
            var_0 setclientdvars( "ui_challenge_1_ref", "", "ui_challenge_2_ref", "", "ui_challenge_3_ref", "", "ui_challenge_4_ref", "", "ui_challenge_5_ref", "", "ui_challenge_6_ref", "", "ui_challenge_7_ref", "" );

        var_0 setclientdvar( "ui_promotion", 0 );

        if ( !isdefined( var_0.pers["summary"] ) )
        {
            var_0.pers["summary"] = [];
            var_0.pers["summary"]["xp"] = 0;
            var_0.pers["summary"]["score"] = 0;
            var_0.pers["summary"]["operation"] = 0;
            var_0.pers["summary"]["challenge"] = 0;
            var_0.pers["summary"]["match"] = 0;
            var_0.pers["summary"]["misc"] = 0;
            var_0.pers["summary"]["entitlementXP"] = 0;
            var_0.pers["summary"]["clanWarsXP"] = 0;
        }

        var_0 setclientdvar( "ui_opensummary", 0 );
        var_0 thread maps\mp\gametypes\_missions::_ID34517();
        var_0._ID12529[0] = 0;
        var_0._ID36465 = [];
        var_0 thread onplayerspawned();
        var_0 thread _ID22884();

        if ( var_0 maps\mp\_utility::_ID25420() )
        {
            if ( issquadsmode() )
            {
                if ( var_0 getrankedplayerdata( "prestigeDoubleXp" ) )
                    var_0._ID24914 = 1;
                else
                    var_0._ID24914 = 0;
            }

            if ( var_0 getrankedplayerdata( "prestigeDoubleWeaponXp" ) )
            {
                var_0.prestigedoubleweaponxp = 1;
                continue;
            }

            var_0.prestigedoubleweaponxp = 0;
        }
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "spawned_player" );

        if ( isai( self ) )
            self.pers["rankxp"] = maps\mp\_utility::_ID14714();
        else if ( !level._ID25418 )
            self.pers["rankxp"] = 0;
        else
        {

        }

        playerupdaterank();
    }
}

playerupdaterank()
{
    if ( self.pers["rankxp"] < 0 )
        self.pers["rankxp"] = 0;

    var_0 = getrankforxp( _ID15305() );
    self.pers["rank"] = var_0;

    if ( isai( self ) || !isdefined( self.pers["prestige"] ) )
    {
        if ( level._ID25418 && isdefined( self.bufferedstats ) )
            var_1 = _ID15269();
        else
            var_1 = 0;

        self setrank( var_0, var_1 );
        self.pers["prestige"] = var_1;
    }

    if ( isdefined( self.clientid ) && self.clientid < level._ID20746 )
    {
        setmatchdata( "players", self.clientid, "rank", var_0 );
        setmatchdata( "players", self.clientid, "Prestige", self.pers["prestige"] );
        return;
    }
}

_ID22884()
{
    self endon( "disconnect" );

    for (;;)
    {
        common_scripts\utility::_ID35626( "giveLoadout", "changed_kit" );

        if ( issubstr( self.class, "custom" ) )
        {
            if ( !level._ID25418 )
            {
                self.pers["rankxp"] = 0;
                continue;
            }

            if ( isai( self ) )
            {
                self.pers["rankxp"] = 0;
                continue;
            }
        }
    }
}

roundup( var_0 )
{
    if ( int( var_0 ) != var_0 )
    {
        return int( var_0 + 1 );
        return;
    }

    return int( var_0 );
    return;
}

giverankxp( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( maps\mp\_utility::_ID18363() )
    {
        return;
        return;
    }

    giverankxp_regularmp( var_0, var_1, var_2, var_3, var_4, var_5 );
    return;
}

giverankxp_regularmp( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "disconnect" );
    var_6 = "none";

    if ( isdefined( self.owner ) && !isbot( self ) )
    {
        self.owner giverankxp( var_0, var_1, var_2, var_3, var_4, var_5 );
        return;
    }

    if ( !isbot( self ) )
    {
        if ( isdefined( self.commanding_bot ) )
            self.commanding_bot giverankxp( var_0, var_1, var_2, var_3, var_4, var_5 );
    }

    if ( isai( self ) )
        return;

    if ( !isplayer( self ) )
        return;

    if ( !maps\mp\_utility::_ID25420() )
    {
        if ( var_0 == "assist" )
        {
            if ( isdefined( self._ID32359 ) )
                self._ID32359 = undefined;
            else
            {
                var_7 = "assist";

                if ( level._ID14086 == "cranked" )
                {
                    if ( isdefined( self.cranked ) )
                        var_7 = "assist_cranked";
                }

                if ( maps\mp\_utility::_hasperk( "specialty_assists" ) )
                {
                    if ( !( self.pers["assistsToKill"] % 2 ) )
                        var_7 = "assist_to_kill";
                }

                thread _ID36462( var_7 );
            }
        }

        return;
    }

    if ( !isdefined( level._ID13531 ) || !level._ID13531 )
    {
        if ( level._ID32653 && ( !level._ID32656["allies"] || !level._ID32656["axis"] ) )
            return;
        else if ( !level._ID32653 && level._ID32656["allies"] + level._ID32656["axis"] < 2 )
            return;
    }

    if ( !isdefined( var_1 ) )
        var_1 = _ID15328( var_0 );

    if ( !isdefined( self._ID36465[var_0] ) )
        self._ID36465[var_0] = 0;

    var_8 = var_1;
    var_9 = 0;
    var_10 = 0;

    if ( isdefined( var_5 ) && maps\mp\_utility::_ID15435() > 90000.0 )
    {
        var_11 = self;

        if ( level._ID32653 )
        {
            var_12 = common_scripts\utility::_ID3855( level._ID32666[maps\mp\_utility::getotherteam( var_11.team )], ::_ID18488 );
            var_13 = common_scripts\utility::_ID3855( level._ID32666[var_11.team], ::_ID18488 );

            if ( isdefined( var_12[0] ) && var_5 == var_12[0] )
            {
                if ( isdefined( var_13[1] ) && var_11.score < var_13[1].score )
                {
                    var_8 *= 2.0;
                    var_11 thread _ID36462( "first_place_kill" );
                }
            }
            else if ( isdefined( var_12[1] ) && var_5 == var_12[1] )
            {
                if ( isdefined( var_13[2] ) && var_11.score < var_13[2].score )
                {
                    var_8 *= 1.5;
                    var_11 thread _ID36462( "second_place_kill" );
                }
            }
        }
        else
        {
            var_12 = common_scripts\utility::_ID3855( level.players, ::_ID18488 );

            if ( isdefined( var_12[0] ) && var_5 == var_12[0] )
            {
                if ( isdefined( var_12[1] ) && var_11.score < var_12[1].score )
                {
                    var_8 *= 2.0;
                    var_11 thread _ID36462( "first_place_kill" );
                }
            }
            else if ( isdefined( var_12[1] ) && var_5 == var_12[1] )
            {
                if ( isdefined( var_12[2] ) && var_11.score < var_12[2].score )
                {
                    var_8 *= 1.5;
                    var_11 thread _ID36462( "second_place_kill" );
                }
            }
            else if ( isdefined( var_12[2] ) && var_5 == var_12[2] )
            {
                if ( isdefined( var_12[2] ) && var_11.score < var_12[2].score )
                {
                    var_8 *= 1.5;
                    var_11 thread _ID36462( "third_place_kill" );
                }
            }
        }

        var_14 = var_11._ID19246.size + 1;

        if ( var_14 > 2 )
        {
            if ( !( var_14 % 5 ) )
            {
                if ( !isdefined( var_11.lastkillsplash ) || var_14 != var_11.lastkillsplash )
                {
                    var_11 thread maps\mp\_utility::_ID32672( "callout_kill_streaking", var_11, undefined, var_14 );
                    var_11.lastkillsplash = var_14;
                }
            }
        }
    }

    var_15 = 0;
    var_16 = 0;

    switch ( var_0 )
    {
        case "kill":
        case "headshot":
        case "shield_damage":
            var_8 *= self._ID36475;
        case "destroy":
        case "suicide":
        case "assault":
        case "teamkill":
        case "capture":
        case "defend":
        case "obj_return":
        case "pickup":
        case "plant":
        case "save":
        case "defuse":
        case "kill_confirmed":
        case "kill_denied":
        case "tags_retrieved":
        case "team_assist":
        case "kill_bonus":
        case "kill_carrier":
        case "draft_rogue":
        case "survivor":
        case "final_rogue":
        case "gained_gun_rank":
        case "dropped_enemy_gun_rank":
        case "got_juggernaut":
        case "kill_as_juggernaut":
        case "kill_juggernaut":
        case "jugg_on_jugg":
        case "damage_body":
        case "damage_head":
        case "kill_normal":
        case "kill_melee":
        case "kill_head":
        case "assist":
            if ( maps\mp\_utility::_ID15035() > 0 && var_0 != "shield_damage" )
            {
                if ( !isdefined( level.skiplivesxpscalar ) || !level.skiplivesxpscalar )
                {
                    if ( level._ID14086 == "sd" )
                        var_17 = max( 1, int( 10 / maps\mp\_utility::_ID15035() ) );
                    else
                        var_17 = max( 1, int( 5 / maps\mp\_utility::_ID15035() ) );

                    var_8 = int( var_8 * var_17 );
                }
            }

            var_18 = 0;

            if ( issquadsmode() )
            {
                if ( self._ID24914 )
                {
                    var_19 = self getrankedplayerdata( "prestigeDoubleXpTimePlayed" );

                    if ( var_19 >= self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"] )
                    {
                        self setrankedplayerdata( "prestigeDoubleXp", 0 );
                        self setrankedplayerdata( "prestigeDoubleXpTimePlayed", 0 );
                        self setrankedplayerdata( "prestigeDoubleXpMaxTimePlayed", 0 );
                        self._ID24914 = 0;
                    }
                    else
                        var_18 = 1.1;
                }
            }

            var_9 = getxpmultiplier();
            var_10 = self getclanwarsbonus();

            if ( var_18 > 0 )
                var_8 = int( var_8 * var_18 );

            var_20 = 1;

            if ( level._ID32653 )
                var_20 = level._ID32685[self.team];
            else if ( isdefined( level._ID32685[self getentitynumber()] ) )
                var_20 = level._ID32685[self getentitynumber()];

            var_8 = int( var_8 * level._ID36474 * var_20 );

            if ( isdefined( level.nukedetonated ) && level.nukedetonated )
            {
                if ( level._ID32653 && level._ID22371.team == self.team )
                    var_8 *= level._ID22371._ID36473;
                else if ( !level._ID32653 && level._ID22371.player == self )
                    var_8 *= level._ID22371._ID36473;

                var_8 = int( var_8 );
            }

            var_21 = _ID15317( var_8 );
            var_8 += var_21;

            if ( var_21 > 0 )
            {
                if ( _ID18688( var_8 ) )
                    thread maps\mp\gametypes\_hud_message::_ID31052( "rested_done" );

                var_16 = 1;
            }

            break;
        case "challenge":
            var_10 = self getclanwarsbonus();
            var_9 = getxpmultiplier();
            break;
        case "operation":
            var_9 = 0;

            if ( self getrankedplayerdata( "challengeXPMultiplierTimePlayed", 0 ) < self._ID6162["challengeXPMaxMultiplierTimePlayed"][0] )
                var_9 += int( self getrankedplayerdata( "challengeXPMultiplier", 0 ) );

            break;
        default:
            var_10 = self getclanwarsbonus();
            var_9 = getxpmultiplier();
            break;
    }

    if ( level.maxforbotmatch && self.pers["xpEarnedThisMatch"] > level.maxforbotmatch )
    {
        if ( !isdefined( level.skippointdisplayxp ) )
            thread _ID36471( var_8, var_15 );

        var_8 = 0;

        if ( self.pers["xpEarnedThisMatch"] != 999790 )
        {
            thread maps\mp\gametypes\_hud_message::_ID31053( "max_xp_for_match" );
            thread maps\mp\killstreaks\_killstreaks::_ID15602( "airdrop_assault", 0, 0, self );
            self thread [[ level._ID19766 ]]( "achieve_carepackage", undefined, undefined, self.origin );
            self.pers["xpEarnedThisMatch"] = 999790;
        }
    }

    var_22 = int( max( var_8 * var_9 - var_8, 0 ) );
    var_23 = int( var_8 * var_10 );
    var_24 = _ID15305();
    _ID17533( var_8 + var_22 + var_23 );

    if ( maps\mp\_utility::_ID25420() && _ID34594( var_24 ) )
    {
        thread _ID34595();
        var_25 = getrank();

        if ( var_25 < 5 )
            giveunlockpoints( 5, 0 );
        else
            giveunlockpoints( 2, 0 );
    }

    _ID32306();
    var_26 = maps\mp\gametypes\_missions::isweaponchallenge( var_4 );

    if ( var_26 )
        var_2 = self getcurrentweapon();

    if ( var_0 == "shield_damage" )
    {
        var_2 = self getcurrentweapon();
        var_3 = "MOD_MELEE";
    }

    if ( !level.hardcoremode )
    {
        if ( !isdefined( level.skippointdisplayxp ) )
            thread _ID36471( var_8, var_15 );

        if ( var_0 == "assist" )
        {
            if ( isdefined( self._ID32359 ) )
                self._ID32359 = undefined;
            else
            {
                var_7 = "assist";

                if ( level._ID14086 == "cranked" )
                {
                    if ( isdefined( self.cranked ) )
                        var_7 = "assist_cranked";
                }

                if ( maps\mp\_utility::_hasperk( "specialty_assists" ) )
                {
                    if ( !( self.pers["assistsToKill"] % 2 ) )
                        var_7 = "assist_to_kill";
                }

                thread _ID36462( var_7 );
            }
        }
    }

    switch ( var_0 )
    {
        case "suicide":
        case "assault":
        case "kill":
        case "headshot":
        case "teamkill":
        case "capture":
        case "defend":
        case "obj_return":
        case "pickup":
        case "plant":
        case "defuse":
        case "kill_confirmed":
        case "kill_denied":
        case "tags_retrieved":
        case "team_assist":
        case "kill_bonus":
        case "kill_carrier":
        case "draft_rogue":
        case "survivor":
        case "final_rogue":
        case "gained_gun_rank":
        case "dropped_enemy_gun_rank":
        case "got_juggernaut":
        case "kill_as_juggernaut":
        case "kill_juggernaut":
        case "jugg_on_jugg":
        case "damage_body":
        case "damage_head":
        case "kill_normal":
        case "kill_melee":
        case "kill_head":
        case "assist":
            self.pers["summary"]["score"] = self.pers["summary"]["score"] + var_8;
            self.pers["summary"]["entitlementXP"] = self.pers["summary"]["entitlementXP"] + var_22;
            self.pers["summary"]["clanWarsXP"] = self.pers["summary"]["clanWarsXP"] + var_23;
            self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + ( var_8 + var_22 + var_23 );
            break;
        case "tie":
        case "win":
        case "loss":
            self.pers["summary"]["match"] = self.pers["summary"]["match"] + var_8;
            self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_8;
            break;
        case "challenge":
            self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + var_8;
            self.pers["summary"]["entitlementXP"] = self.pers["summary"]["entitlementXP"] + var_22;
            self.pers["summary"]["clanWarsXP"] = self.pers["summary"]["clanWarsXP"] + var_23;
            self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + ( var_8 + var_22 + var_23 );
            break;
        case "operation":
            self.pers["summary"]["entitlementXP"] = self.pers["summary"]["entitlementXP"] + var_22;
            self.pers["summary"]["operation"] = self.pers["summary"]["operation"] + var_8;
            self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + ( var_8 + var_22 );
            break;
        default:
            self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + var_8;
            self.pers["summary"]["entitlementXP"] = self.pers["summary"]["entitlementXP"] + var_22;
            self.pers["summary"]["clanWarsXP"] = self.pers["summary"]["clanWarsXP"] + var_23;
            self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + ( var_8 + var_22 + var_23 );
            break;
    }
}

_ID18488( var_0, var_1 )
{
    return var_0.score > var_1.score;
}

getxpmultiplier()
{
    var_0 = 0;

    for ( var_1 = 0; var_1 < 3; var_1++ )
    {
        var_2 = self getrankedplayerdata( "xpMultiplierTimePlayed", var_1 );
        var_3 = self._ID6162["xpMaxMultiplierTimePlayed"][var_1];

        if ( var_2 < var_3 )
            var_0 += int( self getrankedplayerdata( "xpMultiplier", var_1 ) );
    }

    return var_0;
}

_ID36287( var_0, var_1 )
{
    if ( self isitemunlocked( "cac" ) && !maps\mp\_utility::_ID18666() && isdefined( var_0 ) && isdefined( var_1 ) && !maps\mp\_utility::_ID18679( var_0 ) )
    {
        if ( maps\mp\_utility::_ID18573( var_1 ) )
            return 1;

        if ( isexplosivedamagemod( var_1 ) || var_1 == "MOD_IMPACT" )
        {
            if ( maps\mp\_utility::getweaponclass( var_0 ) == "weapon_projectile" || maps\mp\_utility::getweaponclass( var_0 ) == "weapon_assault" )
                return 1;
        }

        if ( var_1 == "MOD_MELEE" )
        {
            if ( maps\mp\_utility::getweaponclass( var_0 ) == "weapon_riot" )
                return 1;
        }
    }

    return 0;
}

charactertypebonusxp( var_0, var_1 )
{
    var_2 = 1.2;

    if ( isdefined( var_0 ) && isdefined( self.character_type ) )
    {
        switch ( maps\mp\_utility::getweaponclass( var_0 ) )
        {
            case "weapon_smg":
                if ( self.character_type == "charactertype_smg" )
                    var_1 *= var_2;

                break;
            case "weapon_assault":
                if ( self.character_type == "charactertype_assault" )
                    var_1 *= var_2;

                break;
            case "weapon_shotgun":
                if ( self.character_type == "charactertype_shotgun" )
                    var_1 *= var_2;

                break;
            case "weapon_dmr":
                if ( self.character_type == "charactertype_dmr" )
                    var_1 *= var_2;

                break;
            case "weapon_sniper":
                if ( self.character_type == "charactertype_sniper" )
                    var_1 *= var_2;

                break;
            case "weapon_lmg":
                if ( self.character_type == "charactertype_lmg" )
                    var_1 *= var_2;

                break;
            default:
                break;
        }
    }

    return int( var_1 );
}

_ID34594( var_0 )
{
    var_1 = getrank();

    if ( var_1 == self.pers["rank"] || self.pers["rank"] == level._ID20757 )
        return 0;

    var_2 = self.pers["rank"];
    self.pers["rank"] = var_1;
    self setrank( var_1 );
    return 1;
}

_ID34595()
{
    self endon( "disconnect" );
    self notify( "update_rank" );
    self endon( "update_rank" );
    var_0 = self.pers["team"];

    if ( !isdefined( var_0 ) )
        return;

    if ( !maps\mp\_utility::levelflag( "game_over" ) )
        level common_scripts\utility::waittill_notify_or_timeout( "game_over", 0.25 );

    var_1 = _ID15299( self.pers["rank"] );
    var_2 = level._ID25421[self.pers["rank"]][1];
    var_3 = int( var_2[var_2.size - 1] );
    thread maps\mp\gametypes\_hud_message::_ID31054( "ranked_up", self.pers["rank"] );

    if ( var_3 > 1 )
        return;

    for ( var_4 = 0; var_4 < level.players.size; var_4++ )
    {
        var_5 = level.players[var_4];
        var_6 = var_5.pers["team"];

        if ( isdefined( var_6 ) && var_5 != self )
        {
            if ( var_6 == var_0 )
                var_5 iprintln( &"RANK_PLAYER_WAS_PROMOTED", self, var_1 );
        }
    }
}

endgameupdate()
{
    var_0 = self;
}

_ID36471( var_0, var_1 )
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );

    if ( var_0 == 0 )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    self notify( "xpPointsPopup" );
    self endon( "xpPointsPopup" );
    self._ID36476 = self._ID36476 + var_0;
    self._ID5481 = self._ID5481 + var_1;
    self setclientomnvar( "ui_points_popup", self._ID36476 );
    var_2 = max( int( self._ID5481 / 20 ), 1 );

    if ( self._ID5481 )
    {
        while ( self._ID5481 > 0 )
        {
            self._ID36476 = self._ID36476 + min( self._ID5481, var_2 );
            self._ID5481 = self._ID5481 - min( self._ID5481, var_2 );
            wait 0.05;
        }
    }
    else
        wait 1.0;

    self._ID36476 = 0;
}

_ID36464( var_0 )
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    self notify( "xpEventPopup" );
    self endon( "xpEventPopup" );

    if ( level.hardcoremode )
        return;

    if ( !isdefined( self ) )
        return;

    var_1 = tablelookuprownum( "mp/xp_event_table.csv", 0, var_0 );

    if ( !isdefined( var_1 ) || isdefined( var_1 ) && var_1 == -1 )
        return;

    self setclientomnvar( "ui_points_popup_desc", var_1 );
    wait 1.0;

    if ( !isdefined( self ) )
        return;

    self notify( "PopComplete" );
}

_ID36462( var_0 )
{
    if ( maps\mp\_utility::_ID18363() )
    {
        return;
        return;
    }

    _ID36463( var_0 );
    return;
}

_ID36463( var_0 )
{
    if ( isdefined( self.owner ) )
        self.owner _ID36462( var_0 );

    if ( !isplayer( self ) )
        return;

    thread _ID36464( var_0 );
}

getrank()
{
    var_0 = self.pers["rankxp"];
    var_1 = self.pers["rank"];

    if ( var_0 < _ID15303( var_1 ) + _ID15304( var_1 ) )
    {
        return var_1;
        return;
    }

    return getrankforxp( var_0 );
    return;
}

_ID15485( var_0 )
{
    var_1 = self getrankedplayerdata( "weaponXP", var_0 );
    return getweaponrankforxp( var_1, var_0 );
}

_ID19898( var_0 )
{
    return getrankforxp( var_0 );
}

_ID36266( var_0 )
{
    return getweaponrankforxp( var_0 );
}

getcurrentweaponxp()
{
    var_0 = self getcurrentweapon();

    if ( isdefined( var_0 ) )
        return self getrankedplayerdata( "weaponXP", var_0 );

    return 0;
}

getrankforxp( var_0 )
{
    var_1 = 0;
    var_2 = level._ID25421[var_1][1];

    while ( isdefined( var_2 ) && var_2 != "" )
    {
        if ( var_0 < _ID15303( var_1 ) + _ID15304( var_1 ) )
            return var_1;

        var_1++;

        if ( isdefined( level._ID25421[var_1] ) )
        {
            var_2 = level._ID25421[var_1][1];
            continue;
        }

        var_2 = undefined;
    }

    var_1--;
    return var_1;
}

getweaponrankforxp( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    var_2 = tablelookup( "mp/statsTable.csv", 4, var_1, 2 );
    var_3 = int( tablelookup( "mp/weaponRankTable.csv", 0, var_2, 1 ) );

    for ( var_4 = 0; var_4 < var_3 + 1; var_4++ )
    {
        if ( var_0 < getweaponrankinfominxp( var_4 ) + getweaponrankinfoxpamt( var_4 ) )
            return var_4;
    }

    return var_4 - 1;
}

_ID15357()
{
    var_0 = getrank() + 1;
    return ( 3 + var_0 * 0.5 ) * 10;
}

_ID15269()
{
    if ( isai( self ) && isdefined( self.pers["prestige_fake"] ) )
    {
        return self.pers["prestige_fake"];
        return;
    }

    return maps\mp\gametypes\_persistence::_ID31510( "prestige" );
    return;
}

_ID15305()
{
    return self.pers["rankxp"];
}

getweaponrankxp( var_0 )
{
    return self getrankedplayerdata( "weaponXP", var_0 );
}

getweaponmaxrankxp( var_0 )
{
    var_1 = tablelookup( "mp/statsTable.csv", 4, var_0, 2 );
    var_2 = int( tablelookup( "mp/weaponRankTable.csv", 0, var_1, 1 ) );
    var_3 = getweaponrankinfomaxxp( var_2 );
    return var_3;
}

_ID18872( var_0 )
{
    var_1 = self getrankedplayerdata( "weaponXP", var_0 );
    var_2 = getweaponmaxrankxp( var_0 );
    return var_1 >= var_2;
}

giveunlockpoints( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_2 = 1;

    var_3 = self.pers["activeSquadMember"];
    var_4 = self getrankedplayerdata( "squadMembers", var_3, "commendationsEarned" );
    var_4 += var_0;
    self setrankedplayerdata( "squadMembers", var_3, "commendationsEarned", var_4 );

    if ( var_1 )
        thread maps\mp\gametypes\_hud_message::_ID24474( "earned_unlock", self );

    var_5 = self getrankedplayerdata( "unlockPoints" );
    var_6 = var_5 + var_0;
    self setrankedplayerdata( "unlockPoints", var_6 );
}

_ID17533( var_0 )
{
    if ( !maps\mp\_utility::_ID25420() )
        return;

    if ( isai( self ) )
        return;

    var_1 = self getrankedplayerdata( "points" );
    var_2 = var_1 + var_0;
    var_2 = int( clamp( var_2, 0, 5999 ) );

    if ( var_2 >= 3000 )
    {
        var_2 %= 3000;
        self setrankedplayerdata( "points", var_2 );
        giveunlockpoints( 1, 1 );
    }
    else
        self setrankedplayerdata( "points", var_2 );

    var_3 = _ID15305();
    var_4 = int( min( var_3, _ID15302( level._ID20757 ) ) ) + var_0;

    if ( self.pers["rank"] == level._ID20757 && var_4 >= _ID15302( level._ID20757 ) )
        var_4 = _ID15302( level._ID20757 );

    self.pers["xpEarnedThisMatch"] = self.pers["xpEarnedThisMatch"] + var_0;
    self.pers["rankxp"] = var_4;
}

_ID15317( var_0 )
{
    if ( !getdvarint( "scr_restxp_enable" ) )
        return 0;

    var_1 = getdvarfloat( "scr_restxp_restedAwardScale" );
    var_2 = int( var_0 * var_1 );
    var_3 = self getrankedplayerdata( "restXPGoal" ) - _ID15305();

    if ( var_3 <= 0 )
        return 0;

    return var_2;
}

_ID18688( var_0 )
{
    if ( !getdvarint( "scr_restxp_enable" ) )
        return 0;

    var_1 = getdvarfloat( "scr_restxp_restedAwardScale" );
    var_2 = int( var_0 * var_1 );
    var_3 = self getrankedplayerdata( "restXPGoal" ) - _ID15305();

    if ( var_3 <= 0 )
        return 0;

    if ( var_2 >= var_3 )
        return 1;

    return 0;
}

_ID32306()
{
    if ( level._ID36474 > 4 || level._ID36474 <= 0 )
        exitlevel( 0 );

    var_0 = _ID15305();
    var_1 = self.pers["activeSquadMember"];
    self setrankedplayerdata( "squadMembers", var_1, "squadMemXP", var_0 );
    self setrankedplayerdata( "experience", var_0 );

    if ( var_0 >= _ID15302( level._ID20757 ) )
    {
        var_3 = self getrankedplayerdata( "characterXP", var_1 );

        if ( var_3 == 0 )
        {
            var_4 = getsystemtime();
            self setrankedplayerdata( "characterXP", var_1, var_4 );
            var_5 = self getrankedplayerdatareservedint( "prestigeLevel" );
            var_6 = var_5 + 1;
            self setrankedplayerdatareservedint( "prestigeLevel", var_6 );
            self setrank( level._ID20757, var_6 );
            thread maps\mp\gametypes\_hud_message::_ID31054( "prestige" + var_6 );
            var_7 = self.pers["team"];

            for ( var_8 = 0; var_8 < level.players.size; var_8++ )
            {
                var_9 = level.players[var_8];
                var_10 = var_9.pers["team"];

                if ( isdefined( var_10 ) && var_9 != self )
                {
                    if ( var_10 == var_7 )
                        var_9 iprintln( &"RANK_PLAYER_WAS_PROMOTED", self, &"MPUI_PRESTIGE" );
                }
            }

            return;
        }

        return;
    }
}

createmultipliertext()
{
    var_0 = newclienthudelem( self );
    var_0.horzalign = "center";
    var_0.vertalign = "bottom";
    var_0.alignx = "center";
    var_0.aligny = "middle";
    var_0.x = 70;

    if ( level.splitscreen )
        var_0.y = -55;
    else
        var_0.y = -10;

    var_0.font = "default";
    var_0.fontscale = 1.3;
    var_0.archived = 0;
    var_0.color = ( 1, 1, 1 );
    var_0.sort = 10000;
    var_0 maps\mp\gametypes\_hud::_ID13470( 1.5 );
    return var_0;
}

_ID21803( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    self endon( "death" );
    self notify( "multiplierTextPopup" );
    self endon( "multiplierTextPopup" );

    if ( !isdefined( self._ID17213 ) )
        self._ID17213 = createmultipliertext();

    wait 0.05;
    thread _ID21804();
    thread _ID21805();
    self._ID17213 settext( var_0 );

    for (;;)
    {
        self._ID17213.alpha = 0.85;
        self._ID17213 thread maps\mp\gametypes\_hud::fontpulse( self );
        wait 1.0;
        self._ID17213 fadeovertime( 0.75 );
        self._ID17213.alpha = 0.25;
        wait 1.0;
    }
}

_ID21804()
{
    self waittill( "death" );

    if ( isdefined( self._ID17213 ) )
    {
        self._ID17213.alpha = 0;
        return;
    }
}

_ID21805()
{
    level waittill( "game_ended" );

    if ( isdefined( self._ID17213 ) )
    {
        self._ID17213.alpha = 0;
        return;
    }
}
