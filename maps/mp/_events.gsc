// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    var_0 = [];
    var_0["dm"] = 3;
    var_0["war"] = 4;
    var_0["sd"] = 5;
    var_0["dom"] = 6;
    var_0["conf"] = 7;
    var_0["sr"] = 8;
    var_0["bnty"] = 9;
    var_0["grind"] = 10;
    var_0["blitz"] = 11;
    var_0["cranked"] = 12;
    var_0["infect"] = 13;
    var_0["sotf"] = 14;
    var_0["sotf_ffa"] = 15;
    var_0["horde"] = 16;
    var_0["mugger"] = 17;
    var_0["aliens"] = 18;
    var_0["gun"] = 19;
    var_0["grnd"] = 20;
    var_0["siege"] = 21;
    var_1 = level._ID14086;

    if ( !isdefined( var_1 ) )
        var_1 = getdvar( "g_gametype" );

    var_2 = 0;

    for (;;)
    {
        var_3 = tablelookupbyrow( "mp/xp_event_table.csv", var_2, var_0[var_1] );

        if ( !isdefined( var_3 ) || var_3 == "" )
            break;

        var_4 = tablelookupbyrow( "mp/xp_event_table.csv", var_2, 0 );

        if ( var_4 == "win" || var_4 == "loss" || var_4 == "tie" )
            var_3 = float( var_3 );
        else
            var_3 = int( var_3 );

        if ( var_3 != -1 )
            maps\mp\gametypes\_rank::registerscoreinfo( var_4, var_3 );

        var_2++;
    }

    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "damage", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "heavy_damage", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "damaged", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "kill", 1 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "killed", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "healed", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "headshot", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "melee", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "backstab", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "longshot", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "pointblank", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "assistedsuicide", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "defender", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "avenger", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "execution", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "comeback", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "revenge", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "buzzkill", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "double", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "triple", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "multi", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "assist", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "firstBlood", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "capture", 1 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "assistedCapture", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "plant", 1 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "defuse", 1 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "vehicleDestroyed", 1 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "3streak", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "4streak", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "5streak", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "6streak", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "7streak", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "8streak", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "9streak", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "10streak", 0 );
    maps\mp\killstreaks\_killstreaks::registeradrenalineinfo( "regen", 0 );
    precacheshader( "crosshair_red" );
    level._ID1644["money"] = loadfx( "fx/props/cash_player_drop" );
    level._ID22412 = 0;
    level thread _ID22877();
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0._ID19228 = [];
        var_0.killedplayerscurrent = [];
        var_0.ch_extremecrueltycomplete = 0;
        var_0.ch_tangodowncomplete = 0;
        var_0._ID19224 = [];
        var_0.lastkilledby = undefined;
        var_0.greatestuniqueplayerkills = 0;
        var_0.recentkillcount = 0;
        var_0._ID19574 = 0;
        var_0.lastkilldogtime = 0;
        var_0._ID8965 = [];
        var_0 thread _ID21370();
        var_0 thread _ID21426();
        var_0 thread _ID21394();
    }
}

damagedplayer( var_0, var_1, var_2 )
{
    if ( var_1 < 50 && var_1 > 10 )
        maps\mp\killstreaks\_killstreaks::_ID15579( "damage" );
    else
        maps\mp\killstreaks\_killstreaks::_ID15579( "heavy_damage" );
}

killedplayernotifysys( var_0, var_1, var_2, var_3 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "killedPlayerNotify" );
    self endon( "killedPlayerNotify" );

    if ( !isdefined( self._ID19243 ) )
        self._ID19243 = 0;

    self._ID19243++;
    wait 0.05;

    if ( self._ID19243 > 1 )
        thread _ID22312( var_0, var_1, var_2, var_3, self._ID19243 );
    else
        self notify( "got_a_kill",  var_1, var_2, var_3  );

    self._ID19243 = 0;
}

_ID22312( var_0, var_1, var_2, var_3, var_4 )
{
    for ( var_5 = 0; var_5 < var_4; var_5++ )
    {
        self notify( "got_a_kill",  var_1, var_2, var_3  );
        wait 0.05;
    }
}

_ID19226( var_0, var_1, var_2, var_3 )
{
    var_4 = var_1._ID15851;
    var_5 = self._ID15851;
    var_6 = gettime();
    thread killedplayernotifysys( var_0, var_1, var_2, var_3 );
    thread _ID34596( var_0 );
    self._ID19574 = gettime();
    self._ID19569 = var_1;
    self._ID21280 = [];
    level._ID22412++;
    self._ID8965[var_4] = undefined;

    if ( !maps\mp\_utility::_ID18679( var_2 ) && !maps\mp\_utility::_ID18666() && !maps\mp\_utility::_hasperk( "specialty_explosivebullets" ) )
    {
        if ( var_2 == "none" )
            return 0;

        if ( var_1.attackers.size == 1 && !isdefined( var_1.attackers[var_1._ID15851] ) )
        {
            var_11 = maps\mp\_utility::getweaponclass( var_2 );

            if ( var_11 == "weapon_sniper" && var_3 != "MOD_MELEE" && gettime() == var_1.attackerdata[self._ID15851]._ID13167 )
            {
                self._ID21280["oneshotkill"] = 1;
                thread maps\mp\gametypes\_rank::_ID36462( "one_shot_kill" );
            }
        }

        if ( isdefined( var_1._ID32944 ) && var_1._ID32944 == "frag_grenade_mp" )
            self._ID21280["cooking"] = 1;

        if ( isdefined( self.assistedsuicide ) && self.assistedsuicide )
            assistedsuicide( var_0, var_2, var_3 );

        if ( level._ID22412 == 1 )
            firstblood( var_0, var_2, var_3 );

        if ( self.pers["cur_death_streak"] > 3 )
            comeback( var_0, var_2, var_3 );

        if ( var_3 == "MOD_HEAD_SHOT" )
        {
            if ( isdefined( var_1.laststand ) )
                execution( var_0, var_2, var_3 );
            else
                _ID16460( var_0, var_2, var_3 );
        }

        if ( isdefined( self._ID35917 ) && self._ID35917 && gettime() - self._ID30916 <= 5000 )
            self._ID21280["jackintheboxkill"] = 1;

        if ( !isalive( self ) && self._ID9101 + 800 < gettime() )
            _ID24787( var_0 );

        if ( level._ID32653 && var_6 - var_1._ID19574 < 500 )
        {
            if ( var_1._ID19569 != self )
                avengedplayer( var_0, var_2, var_3 );
        }

        if ( isdefined( var_1.lastkilldogtime ) && var_6 - var_1.lastkilldogtime < 2000 )
            avengeddog( var_0, var_2, var_3 );

        foreach ( var_14, var_13 in var_1._ID8965 )
        {
            if ( var_14 == self._ID15851 )
                continue;

            if ( level._ID32653 && var_6 - var_13 < 500 )
                defendedplayer( var_0, var_2, var_3 );
        }

        if ( isdefined( var_1.attackerposition ) )
            var_15 = var_1.attackerposition;
        else
            var_15 = self.origin;

        if ( ispointblank( self, var_2, var_3, var_15, var_1 ) )
            thread pointblank( var_0, var_2, var_3 );
        else if ( _ID18696( self, var_2, var_3, var_15, var_1 ) )
            thread _ID20288( var_0, var_2, var_3 );

        var_16 = var_1.pers["cur_kill_streak"];

        if ( var_16 > 0 && isdefined( var_1.killstreaks[var_16 + 1] ) )
            buzzkill( var_0, var_1, var_2, var_3 );

        thread _ID7087( var_0, var_1, var_2, var_3 );
    }
    else if ( var_2 == "guard_dog_mp" )
    {
        if ( !isalive( self ) && self._ID9101 < gettime() )
            _ID24786();
    }

    if ( !isdefined( self._ID19228[var_4] ) )
        self._ID19228[var_4] = 0;

    if ( !isdefined( self.killedplayerscurrent[var_4] ) )
        self.killedplayerscurrent[var_4] = 0;

    if ( !isdefined( var_1._ID19224[var_5] ) )
        var_1._ID19224[var_5] = 0;

    self._ID19228[var_4]++;

    if ( self._ID19228[var_4] > self.greatestuniqueplayerkills )
        maps\mp\_utility::_ID28832( "killedsameplayer", self._ID19228[var_4] );

    self.killedplayerscurrent[var_4]++;
    var_1._ID19224[var_5]++;
    var_1.lastkilledby = self;
}

_ID18696( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isalive( var_0 ) && !var_0 maps\mp\_utility::_ID18837() && ( var_2 == "MOD_RIFLE_BULLET" || var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_HEAD_SHOT" ) && !maps\mp\_utility::_ID18679( var_1 ) && !isdefined( var_0.assistedsuicide ) )
    {
        var_5 = maps\mp\_utility::getweaponclass( var_1 );

        switch ( var_5 )
        {
            case "weapon_pistol":
                var_6 = 800;
                break;
            case "weapon_smg":
                var_6 = 1200;
                break;
            case "weapon_assault":
            case "weapon_dmr":
            case "weapon_lmg":
                var_6 = 1500;
                break;
            case "weapon_sniper":
                var_6 = 2000;
                break;
            case "weapon_shotgun":
                var_6 = 500;
                break;
            case "weapon_projectile":
            default:
                var_6 = 1536;
                break;
        }

        var_7 = var_6 * var_6;

        if ( distancesquared( var_3, var_4.origin ) > var_7 )
        {
            if ( var_0 isitemunlocked( "specialty_holdbreath" ) && var_0 maps\mp\_utility::_hasperk( "specialty_holdbreath" ) )
                var_0 maps\mp\gametypes\_missions::_ID25038( "ch_longdistance" );

            return 1;
        }
    }

    return 0;
}

ispointblank( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isalive( var_0 ) && !var_0 maps\mp\_utility::_ID18837() && ( var_2 == "MOD_RIFLE_BULLET" || var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_HEAD_SHOT" ) && !maps\mp\_utility::_ID18679( var_1 ) && !isdefined( var_0.assistedsuicide ) )
    {
        var_5 = 9216;

        if ( distancesquared( var_3, var_4.origin ) < var_5 )
            return 1;
    }

    return 0;
}

_ID7087( var_0, var_1, var_2, var_3 )
{
    var_4 = maps\mp\_utility::getweaponclass( var_2 );
    var_5 = 0;
    thread _ID6519();

    if ( isdefined( self.lastkilledby ) && self.lastkilledby == var_1 )
    {
        self.lastkilledby = undefined;
        _ID26251( var_0 );
    }

    if ( var_1.idflags & level.idflags_penetration )
        maps\mp\_utility::_ID17531( "bulletpenkills", 1 );

    var_6 = self.pers["rank"];
    var_7 = var_1.pers["rank"];

    if ( var_6 < var_7 )
        maps\mp\_utility::_ID17531( "higherrankkills", 1 );

    if ( var_6 > var_7 )
        maps\mp\_utility::_ID17531( "lowerrankkills", 1 );

    if ( isdefined( self._ID17611 ) && self._ID17611 )
        maps\mp\_utility::_ID17531( "laststandkills", 1 );

    if ( isdefined( var_1._ID17611 ) && var_1._ID17611 )
        maps\mp\_utility::_ID17531( "laststanderkills", 1 );

    if ( self getcurrentweapon() != self._ID24978 && self getcurrentweapon() != self._ID27984 )
        maps\mp\_utility::_ID17531( "otherweaponkills", 1 );

    var_8 = gettime() - var_1._ID30916;

    if ( !maps\mp\_utility::_ID20673() )
        var_1 maps\mp\_utility::_ID28834( "shortestlife", var_8 );

    var_1 maps\mp\_utility::_ID28833( "longestlife", var_8 );

    if ( var_3 != "MOD_MELEE" )
    {
        switch ( var_4 )
        {
            case "weapon_smg":
            case "weapon_assault":
            case "weapon_sniper":
            case "weapon_dmr":
            case "weapon_lmg":
            case "weapon_shotgun":
            case "weapon_projectile":
            case "weapon_pistol":
                _ID7088( var_1, var_2, var_3, var_4 );
                break;
            case "weapon_grenade":
            case "weapon_explosive":
                checkmatchdataequipmentkills( var_1, var_2, var_3 );
                break;
            default:
                break;
        }
    }
}

_ID7088( var_0, var_1, var_2, var_3 )
{
    var_4 = self;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = undefined;

    switch ( var_3 )
    {
        case "weapon_pistol":
            var_5 = "pistolkills";
            var_6 = "pistolheadshots";
            break;
        case "weapon_smg":
            var_5 = "smgkills";
            var_6 = "smgheadshots";
            break;
        case "weapon_assault":
            var_5 = "arkills";
            var_6 = "arheadshots";
            break;
        case "weapon_projectile":
            if ( weaponclass( var_1 ) == "rocketlauncher" )
                var_5 = "rocketkills";

            break;
        case "weapon_dmr":
            var_5 = "dmrkills";
            var_6 = "dmrheadshots";
            break;
        case "weapon_sniper":
            var_5 = "sniperkills";
            var_6 = "sniperheadshots";
            break;
        case "weapon_shotgun":
            var_5 = "shotgunkills";
            var_6 = "shotgunheadshots";
            var_7 = "shotgundeaths";
            break;
        case "weapon_lmg":
            var_5 = "lmgkills";
            var_6 = "lmgheadshots";
            break;
        default:
            break;
    }

    if ( isdefined( var_5 ) )
        var_4 maps\mp\_utility::_ID17531( var_5, 1 );

    if ( isdefined( var_6 ) && var_2 == "MOD_HEAD_SHOT" )
        var_4 maps\mp\_utility::_ID17531( var_6, 1 );

    if ( isdefined( var_7 ) && !maps\mp\_utility::_ID20673() )
        var_0 maps\mp\_utility::_ID17531( var_7, 1 );

    if ( var_4 maps\mp\_utility::isplayerads() )
    {
        var_4 maps\mp\_utility::_ID17531( "adskills", 1 );
        var_8 = issubstr( var_1, "thermal" );

        if ( var_8 || issubstr( var_1, "acog" ) || issubstr( var_1, "scope" ) )
            var_4 maps\mp\_utility::_ID17531( "scopedkills", 1 );

        if ( var_8 )
        {
            var_4 maps\mp\_utility::_ID17531( "thermalkills", 1 );
            return;
        }
    }
    else
        var_4 maps\mp\_utility::_ID17531( "hipfirekills", 1 );
}

checkmatchdataequipmentkills( var_0, var_1, var_2 )
{
    var_3 = self;

    switch ( var_1 )
    {
        case "frag_grenade_mp":
            var_3 maps\mp\_utility::_ID17531( "fragkills", 1 );
            var_3 maps\mp\_utility::_ID17531( "grenadekills", 1 );
            var_4 = 1;
            break;
        case "c4_mp":
            var_3 maps\mp\_utility::_ID17531( "c4kills", 1 );
            var_4 = 1;
            break;
        case "semtex_mp":
            var_3 maps\mp\_utility::_ID17531( "semtexkills", 1 );
            var_3 maps\mp\_utility::_ID17531( "grenadekills", 1 );
            var_4 = 1;
            break;
        case "claymore_mp":
            var_3 maps\mp\_utility::_ID17531( "claymorekills", 1 );
            var_4 = 1;
            break;
        case "throwingknife_mp":
            var_3 maps\mp\_utility::_ID17531( "throwingknifekills", 1 );
            thread maps\mp\gametypes\_rank::_ID36462( "knifethrow" );
            var_4 = 1;
            break;
        default:
            var_4 = 0;
            break;
    }

    if ( var_4 )
        var_3 maps\mp\_utility::_ID17531( "equipmentkills", 1 );
}

_ID6519()
{
    self._ID19575 = 0;

    if ( !isdefined( self.lastkilllocation ) )
    {
        self.lastkilllocation = self.origin;
        self.lastcampkilltime = gettime();
        return;
    }

    if ( distance( self.lastkilllocation, self.origin ) < 512 && gettime() - self.lastcampkilltime > 5000 )
    {
        maps\mp\_utility::_ID17531( "mostcamperkills", 1 );
        self._ID19575 = 1;
    }

    self.lastkilllocation = self.origin;
    self.lastcampkilltime = gettime();
}

consolation( var_0 )
{

}

_ID25125( var_0 )
{
    self._ID21280["proximityAssist"] = 1;
    thread maps\mp\gametypes\_rank::_ID36462( "proximityassist" );
    thread maps\mp\gametypes\_rank::giverankxp( "proximityassist" );
}

proximitykill( var_0 )
{
    self._ID21280["proximityKill"] = 1;
    thread maps\mp\gametypes\_rank::_ID36462( "proximitykill" );
    thread maps\mp\gametypes\_rank::giverankxp( "proximitykill" );
}

_ID20288( var_0, var_1, var_2 )
{
    self._ID21280["longshot"] = 1;
    thread maps\mp\gametypes\_rank::_ID36462( "longshot" );
    thread maps\mp\gametypes\_rank::giverankxp( "longshot", undefined, var_1, var_2 );
    maps\mp\killstreaks\_killstreaks::_ID15579( "longshot" );
    maps\mp\_utility::_ID17531( "longshots", 1 );
    thread maps\mp\_matchdata::_ID20250( var_0, "longshot" );
}

pointblank( var_0, var_1, var_2 )
{
    self._ID21280["pointblank"] = 1;
    thread maps\mp\gametypes\_rank::_ID36462( "pointblank" );
    thread maps\mp\gametypes\_rank::giverankxp( "pointblank", undefined, var_1, var_2 );
    maps\mp\killstreaks\_killstreaks::_ID15579( "pointblank" );
    thread maps\mp\_matchdata::_ID20250( var_0, "pointblank" );
}

execution( var_0, var_1, var_2 )
{
    self._ID21280["execution"] = 1;
    thread maps\mp\gametypes\_rank::_ID36462( "execution" );
    thread maps\mp\gametypes\_rank::giverankxp( "execution", undefined, var_1, var_2 );
    maps\mp\killstreaks\_killstreaks::_ID15579( "execution" );
    thread maps\mp\_matchdata::_ID20250( var_0, "execution" );
}

_ID16460( var_0, var_1, var_2 )
{
    self._ID21280["headshot"] = 1;
    thread maps\mp\gametypes\_rank::_ID36462( "headshot" );
    thread maps\mp\gametypes\_rank::giverankxp( "headshot", undefined, var_1, var_2 );
    maps\mp\killstreaks\_killstreaks::_ID15579( "headshot" );
    thread maps\mp\_matchdata::_ID20250( var_0, "headshot" );
}

avengedplayer( var_0, var_1, var_2 )
{
    self._ID21280["avenger"] = 1;
    thread maps\mp\gametypes\_rank::_ID36462( "avenger" );
    thread maps\mp\gametypes\_rank::giverankxp( "avenger", undefined, var_1, var_2 );
    maps\mp\killstreaks\_killstreaks::_ID15579( "avenger" );
    thread maps\mp\_matchdata::_ID20250( var_0, "avenger" );
    maps\mp\_utility::_ID17531( "avengekills", 1 );
}

avengeddog( var_0, var_1, var_2 )
{
    thread maps\mp\gametypes\_rank::_ID36462( "dog_avenger" );
    thread maps\mp\gametypes\_rank::giverankxp( "dog_avenger", undefined, var_1, var_2 );
}

assistedsuicide( var_0, var_1, var_2 )
{
    self._ID21280["assistedsuicide"] = 1;
    thread maps\mp\gametypes\_rank::_ID36462( "assistedsuicide" );
    thread maps\mp\gametypes\_rank::giverankxp( "assistedsuicide", undefined, var_1, var_2 );
    maps\mp\killstreaks\_killstreaks::_ID15579( "assistedsuicide" );
    thread maps\mp\_matchdata::_ID20250( var_0, "assistedsuicide" );
}

defendedplayer( var_0, var_1, var_2 )
{
    self._ID21280["defender"] = 1;
    thread maps\mp\gametypes\_rank::_ID36462( "defender" );
    thread maps\mp\gametypes\_rank::giverankxp( "defender", undefined, var_1, var_2 );
    maps\mp\killstreaks\_killstreaks::_ID15579( "defender" );
    thread maps\mp\_matchdata::_ID20250( var_0, "defender" );
    maps\mp\_utility::_ID17531( "rescues", 1 );
}

_ID24787( var_0 )
{
    self._ID21280["posthumous"] = 1;
    thread maps\mp\gametypes\_rank::_ID36462( "posthumous" );
    thread maps\mp\gametypes\_rank::giverankxp( "posthumous" );
    thread maps\mp\_matchdata::_ID20250( var_0, "posthumous" );
}

_ID24786()
{
    thread maps\mp\gametypes\_rank::_ID36462( "martyrdog" );
    thread maps\mp\gametypes\_rank::giverankxp( "martyrdog" );
}

backstab( var_0 )
{
    self iprintlnbold( "backstab" );
}

_ID26251( var_0 )
{
    self._ID21280["revenge"] = 1;
    thread maps\mp\gametypes\_rank::_ID36462( "revenge" );
    thread maps\mp\gametypes\_rank::giverankxp( "revenge" );
    maps\mp\killstreaks\_killstreaks::_ID15579( "revenge" );
    thread maps\mp\_matchdata::_ID20250( var_0, "revenge" );
    maps\mp\_utility::_ID17531( "revengekills", 1 );
}

multikill( var_0, var_1 )
{
    if ( var_1 == 2 )
    {
        thread maps\mp\gametypes\_rank::_ID36462( "double" );
        maps\mp\killstreaks\_killstreaks::_ID15579( "double" );
    }
    else if ( var_1 == 3 )
    {
        thread maps\mp\gametypes\_rank::_ID36462( "triple" );
        maps\mp\killstreaks\_killstreaks::_ID15579( "triple" );
        thread maps\mp\_utility::_ID32672( "callout_3xkill", self );
    }
    else
    {
        thread maps\mp\gametypes\_rank::_ID36462( "multi" );
        maps\mp\killstreaks\_killstreaks::_ID15579( "multi" );
        thread maps\mp\_utility::_ID32672( "callout_3xpluskill", self );
    }

    thread maps\mp\_matchdata::_ID20254( var_0, var_1 );
    maps\mp\_utility::_ID28833( "multikill", var_1 );
    maps\mp\_utility::_ID17531( "mostmultikills", 1 );
}

firstblood( var_0, var_1, var_2 )
{
    self._ID21280["firstblood"] = 1;
    thread maps\mp\gametypes\_rank::_ID36462( "firstblood" );
    thread maps\mp\gametypes\_rank::giverankxp( "firstblood", undefined, var_1, var_2 );
    thread maps\mp\_matchdata::_ID20250( var_0, "firstblood" );
    maps\mp\killstreaks\_killstreaks::_ID15579( "firstBlood" );
    thread maps\mp\_utility::_ID32672( "callout_firstblood", self );
    maps\mp\gametypes\_missions::_ID25038( "ch_bornready" );
}

_ID36371( var_0 )
{

}

buzzkill( var_0, var_1, var_2, var_3 )
{
    self._ID21280["buzzkill"] = var_1.pers["cur_kill_streak"];
    thread maps\mp\gametypes\_rank::_ID36462( "buzzkill" );
    thread maps\mp\gametypes\_rank::giverankxp( "buzzkill", undefined, var_2, var_3 );
    maps\mp\killstreaks\_killstreaks::_ID15579( "buzzkill" );
    thread maps\mp\_matchdata::_ID20250( var_0, "buzzkill" );
}

comeback( var_0, var_1, var_2 )
{
    self._ID21280["comeback"] = 1;
    thread maps\mp\gametypes\_rank::_ID36462( "comeback" );
    thread maps\mp\gametypes\_rank::giverankxp( "comeback", undefined, var_1, var_2 );
    maps\mp\killstreaks\_killstreaks::_ID15579( "comeback" );
    thread maps\mp\_matchdata::_ID20250( var_0, "comeback" );
    maps\mp\_utility::_ID17531( "comebacks", 1 );
}

_ID10186()
{
    var_0 = self._ID15851;

    for ( var_1 = 0; var_1 < level.players.size; var_1++ )
    {
        if ( isdefined( level.players[var_1]._ID19228[var_0] ) )
            level.players[var_1]._ID19228[var_0] = undefined;

        if ( isdefined( level.players[var_1].killedplayerscurrent[var_0] ) )
            level.players[var_1].killedplayerscurrent[var_0] = undefined;

        if ( isdefined( level.players[var_1]._ID19224[var_0] ) )
            level.players[var_1]._ID19224[var_0] = undefined;
    }
}

_ID21394()
{
    level endon( "end_game" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "healed" );
        maps\mp\killstreaks\_killstreaks::_ID15579( "healed" );
    }
}

_ID34596( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "updateRecentKills" );
    self endon( "updateRecentKills" );
    self.recentkillcount++;
    wait 1.0;

    if ( self.recentkillcount > 1 )
        multikill( var_0, self.recentkillcount );

    self.recentkillcount = 0;
}

_ID21370()
{
    level endon( "end_game" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "hijacker",  var_0, var_1  );
        thread maps\mp\gametypes\_rank::_ID36462( "hijacker" );
        thread maps\mp\gametypes\_rank::giverankxp( "hijacker" );
        var_2 = "hijacked_airdrop";
        var_3 = "ch_hijacker";

        switch ( var_0 )
        {
            case "sentry":
                var_2 = "hijacked_sentry";
                break;
            case "juggernaut":
                var_2 = "hijacked_juggernaut";
                break;
            case "maniac":
                var_2 = "hijacked_maniac";
                break;
            case "juggernaut_swamp_slasher":
                var_2 = "hijacked_juggernaut_swamp_slasher";
                break;
            case "juggernaut_predator":
                var_2 = "hijacked_juggernaut_predator";
                break;
            case "juggernaut_death_mariachi":
                var_2 = "hijacked_juggernaut_death_mariachi";
                break;
            case "remote_tank":
                var_2 = "hijacked_remote_tank";
                break;
            case "mega":
            case "emergency_airdrop":
                var_2 = "hijacked_emergency_airdrop";
                var_3 = "ch_newjack";
                break;
            default:
                break;
        }

        if ( isdefined( var_1 ) )
            var_1 maps\mp\gametypes\_hud_message::_ID24474( var_2, self );

        self notify( "process",  var_3  );
    }
}

_ID21426()
{
    level endon( "end_game" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "objective",  var_0  );

        switch ( var_0 )
        {
            case "captured":
                maps\mp\killstreaks\_killstreaks::_ID15579( "capture" );

                if ( isdefined( self.laststand ) && self.laststand )
                {
                    thread maps\mp\gametypes\_hud_message::_ID31053( "heroic", maps\mp\gametypes\_rank::_ID15328( "reviver" ) );
                    thread maps\mp\gametypes\_rank::giverankxp( "reviver" );
                }

                continue;
            case "plant":
                maps\mp\killstreaks\_killstreaks::_ID15579( "plant" );
                continue;
            case "defuse":
                maps\mp\killstreaks\_killstreaks::_ID15579( "defuse" );
                continue;
        }
    }
}

giveobjectivepointstreaks()
{
    var_0 = 1;

    if ( var_0 )
    {
        if ( !isagent( self ) )
        {
            self.pers["objectivePointStreak"]++;
            var_1 = self.pers["objectivePointStreak"] % 2 == 0;

            if ( var_1 )
                maps\mp\killstreaks\_killstreaks::_ID15579( "kill" );

            self setclientomnvar( "ui_half_tick", !var_1 );
        }
    }
}
