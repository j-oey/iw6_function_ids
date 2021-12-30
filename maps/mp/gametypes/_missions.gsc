// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    precachestring( &"MP_CHALLENGE_COMPLETED" );

    if ( !_ID20774() )
        return;

    level._ID21229 = [];
    _ID25710( "playerKilled", ::_ID6820 );
    _ID25710( "playerKilled", ::ch_killstreak_kills );
    _ID25710( "playerHardpoint", ::_ID6818 );
    _ID25710( "playerAssist", ::ch_assists );
    _ID25710( "roundEnd", ::ch_roundwin );
    _ID25710( "roundEnd", ::ch_roundplayed );
    _ID25710( "vehicleKilled", ::ch_vehicle_killed );
    level thread _ID22877();
}

_ID20774()
{
    if ( issquadsmode() )
        return 0;

    return level._ID25418;
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );

        if ( !isdefined( var_0.pers["postGameChallenges"] ) )
            var_0.pers["postGameChallenges"] = 0;

        var_0 thread _ID17973();

        if ( isai( var_0 ) )
            continue;

        var_0 thread onplayerspawned();
        var_0 thread _ID21364();
        var_0 thread _ID21383();
        var_0 thread monitorlivetime();
        var_0 thread _ID21450();
        var_0 thread _ID21449();
        var_0 thread _ID21436();
        var_0 thread _ID21363();
        var_0 thread monitorprocesschallenge();
        var_0 thread _ID21407();
        var_0 thread _ID21405();
        var_0 thread _ID21357();
        var_0 thread _ID21466();
        var_0 thread _ID21389();
        var_0 thread monitorconcussion();
        var_0 thread monitorreload();
        var_0 thread monitorsprintslide();
        var_0 notifyonplayercommand( "hold_breath", "+breath_sprint" );
        var_0 notifyonplayercommand( "hold_breath", "+melee_breath" );
        var_0 notifyonplayercommand( "release_breath", "-breath_sprint" );
        var_0 notifyonplayercommand( "release_breath", "-melee_breath" );
        var_0 thread _ID21403();
        var_0 notifyonplayercommand( "jumped", "+goStand" );
        var_0 thread _ID21415();

        if ( isdefined( level._ID23354 ) && issubstr( var_0.name, level._ID23354 ) )
        {
            var_0 setrankedplayerdata( "challengeState", "ch_infected", 2 );
            var_0 setrankedplayerdata( "challengeProgress", "ch_infected", 1 );
            var_0 setrankedplayerdata( "challengeState", "ch_plague", 2 );
            var_0 setrankedplayerdata( "challengeProgress", "ch_plague", 1 );
        }

        var_0 setcommonplayerdata( "round", "weaponsUsed", 0, "none" );
        var_0 setcommonplayerdata( "round", "weaponsUsed", 1, "none" );
        var_0 setcommonplayerdata( "round", "weaponsUsed", 2, "none" );
        var_0 setcommonplayerdata( "round", "weaponXpEarned", 0, 0 );
        var_0 setcommonplayerdata( "round", "weaponXpEarned", 1, 0 );
        var_0 setcommonplayerdata( "round", "weaponXpEarned", 2, 0 );
        var_1 = var_0 getcommonplayerdata( "cardTitle" );
        var_2 = tablelookupbyrow( "mp/cardTitleTable.csv", var_1, 0 );

        if ( var_2 == "cardtitle_infected" )
        {
            var_0._ID17566 = 1;
            continue;
        }

        if ( var_2 == "cardtitle_plague" )
            var_0._ID23675 = 1;
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "spawned_player" );
        self.killsthismag = [];
        thread _ID21444();
    }
}

_ID21436()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "scavenger_pickup" );

        if ( self isitemunlocked( "specialty_scavenger" ) && maps\mp\_utility::_hasperk( "specialty_scavenger" ) && !maps\mp\_utility::_ID18666() )
            _ID25038( "ch_scavenger_pro" );

        wait 0.05;
    }
}

_ID21449()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "received_earned_killstreak" );

        if ( self isitemunlocked( "specialty_hardline" ) && maps\mp\_utility::_hasperk( "specialty_hardline" ) )
            _ID25038( "ch_hardline_pro" );

        wait 0.05;
    }
}

_ID21363()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "survived_explosion",  var_0  );

        if ( isdefined( var_0 ) && isplayer( var_0 ) && self == var_0 )
            continue;

        if ( self isitemunlocked( "_specialty_blastshield" ) && maps\mp\_utility::_hasperk( "_specialty_blastshield" ) )
            _ID25038( "ch_blastshield_pro" );

        common_scripts\utility::_ID35582();
    }
}

_ID21456()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "destroyed_insertion",  var_0  );

        if ( self == var_0 )
            return;

        _ID25038( "ch_darkbringer" );
        maps\mp\_utility::_ID17531( "mosttacprevented", 1 );
        thread maps\mp\gametypes\_hud_message::_ID31052( "denied", 20 );
        var_0 maps\mp\gametypes\_hud_message::_ID24474( "destroyed_insertion", self );
        common_scripts\utility::_ID35582();
    }
}

_ID17973()
{
    var_0 = getarraykeys( level._ID19256 );

    foreach ( var_2 in var_0 )
        self.pers[var_2] = 0;

    self.pers["lastBulletKillTime"] = 0;
    self.pers["bulletStreak"] = 0;
    self.explosiveinfo = [];
}

_ID25710( var_0, var_1 )
{
    if ( !isdefined( level._ID21229[var_0] ) )
        level._ID21229[var_0] = [];

    level._ID21229[var_0][level._ID21229[var_0].size] = var_1;
}

getchallengestatus( var_0 )
{
    if ( isdefined( self.challengedata[var_0] ) )
    {
        return self.challengedata[var_0];
        return;
    }

    return 0;
    return;
}

ch_assists( var_0 )
{
    var_1 = var_0.player;
    var_1 _ID25038( "ch_assists" );

    if ( isdefined( var_1._ID18670 ) && var_1._ID18670 )
        var_1 _ID25038( "ch_assisted_firepower" );

    if ( isdefined( var_0._ID32157 ) )
    {
        var_2 = maps\mp\_utility::getweaponclass( var_0._ID32157 );
        var_3 = maps\mp\_utility::_ID14903( var_0._ID32157 );

        switch ( var_2 )
        {
            case "weapon_smg":
            case "weapon_assault":
            case "weapon_dmr":
            case "weapon_lmg":
                _ID25038( "ch_" + var_3 + "_assists" );
                break;
            case "weapon_shotgun":
                _ID25038( "ch_" + var_3 + "_assist" );
                break;
            default:
                if ( maps\mp\gametypes\_weapons::_ID18766( var_0._ID32157 ) )
                    _ID25038( "ch_iw6_riotshield_assist" );

                break;
        }

        return;
    }
}

_ID6818( var_0 )
{
    var_1 = var_0.player;
    var_1.pers[var_0.hardpointtype]++;

    switch ( var_0.hardpointtype )
    {
        case "uplink":
            var_1 _ID25038( "ch_uplink" );
            var_1 _ID25038( "ch_assault_streaks" );

            if ( var_1 checknumusesofpersistentdata( "uplink", 3 ) )
                var_1 _ID25038( "ch_nosecrets" );

            break;
        case "guard_dog":
            var_1 _ID25038( "ch_guard_dog" );
            var_1 _ID25038( "ch_assault_streaks" );
            break;
        case "airdrop_juggernaut_maniac":
            var_1 _ID25038( "ch_airdrop_juggernaut_maniac" );
            var_1 _ID25038( "ch_assault_streaks" );
            break;
        case "ims":
            var_1 _ID25038( "ch_assault_streaks" );
            break;
        case "helicopter":
            var_1 _ID25038( "ch_assault_streaks" );

            if ( var_1 checknumusesofpersistentdata( "helicopter", 2 ) )
                var_1 _ID25038( "ch_airsuperiority" );

            break;
        case "sentry":
        case "vanguard":
        case "heli_pilot":
        case "drone_hive":
        case "odin_assault":
        case "ball_drone_backup":
        case "airdrop_juggernaut":
            var_1 _ID25038( "ch_assault_streaks" );
            break;
        case "uplink_support":
            var_1 _ID25038( "ch_uplink_support" );
            var_1 _ID25038( "ch_support_streaks" );
            break;
        case "deployable_vest":
            var_1 _ID25038( "ch_deployable_vest" );
            var_1 _ID25038( "ch_support_streaks" );
            break;
        case "deployable_ammo":
            var_1 _ID25038( "ch_deployable_ammo" );
            var_1 _ID25038( "ch_support_streaks" );
            break;
        case "ball_drone_radar":
            var_1 _ID25038( "ch_ball_drone_radar" );
            var_1 _ID25038( "ch_support_streaks" );
            break;
        case "aa_launcher":
            var_1 _ID25038( "ch_support_streaks" );
            break;
        case "jammer":
            var_1 _ID25038( "ch_jammer" );
            var_1 _ID25038( "ch_support_streaks" );
            break;
        case "air_superiority":
            var_1 _ID25038( "ch_support_streaks" );
            break;
        case "recon_agent":
            var_1 _ID25038( "ch_recon_agent" );
            var_1 _ID25038( "ch_support_streaks" );
            break;
        case "heli_sniper":
            var_1 _ID25038( "ch_heli_sniper" );
            var_1 _ID25038( "ch_support_streaks" );
            break;
        case "uav_3dping":
            var_1 _ID25038( "ch_uav_3dping" );
            var_1 _ID25038( "ch_support_streaks" );
            break;
        case "airdrop_juggernaut_recon":
            var_1 _ID25038( "ch_support_streaks" );
            break;
        case "odin_support":
            var_1 _ID25038( "ch_odin_support" );
            var_1 _ID25038( "ch_support_streaks" );
            break;
        case "all_perks_bonus":
            var_1 _ID25038( "ch_all_perks_bonus" );
            break;
        case "nuke":
            var_1 _ID25038( "ch_nuke" );
            break;
    }
}

ch_killstreak_kills( var_0 )
{
    if ( !isdefined( var_0.attacker ) || !isplayer( var_0.attacker ) )
        return;

    if ( !maps\mp\_utility::_ID18679( var_0._ID32157 ) )
        return;

    var_1 = var_0.attacker;

    if ( !isdefined( var_1.pers[var_0._ID32157 + "_streak"] ) || isdefined( var_1.pers[var_0._ID32157 + "_streakTime"] ) && gettime() - var_1.pers[var_0._ID32157 + "_streakTime"] > 7000 )
    {
        var_1.pers[var_0._ID32157 + "_streak"] = 0;
        var_1.pers[var_0._ID32157 + "_streakTime"] = gettime();
    }

    var_1.pers[var_0._ID32157 + "_streak"]++;

    switch ( var_0._ID32157 )
    {
        case "sentry_minigun_mp":
            var_1 _ID25038( "ch_looknohands" );
            break;
        case "remote_tank_projectile_mp":
            var_1 _ID25038( "ch_incoming" );
            break;
        case "heli_pilot_turret_mp":
            var_1 _ID25038( "ch_helo_pilot" );
            break;
        case "iw6_gm6helisnipe_mp_gm6scope":
            var_1 _ID25038( "ch_long_distance_shooter" );
            break;
        case "drone_hive_projectile_mp":
        case "switch_blade_child_mp":
            var_1 _ID25038( "ch_clusterfunk" );
            var_2 = var_1.killsthislifeperweapon["drone_hive_projectile_mp"] + var_1.killsthislifeperweapon["switch_blade_child_mp"];

            if ( isnumbermultipleof( var_2, 4 ) )
                var_1 _ID25038( "ch_bullseye" );

            break;
        case "ball_drone_gun_mp":
            var_1 _ID25038( "ch_vulture" );
            break;
        case "odin_projectile_large_rod_mp":
        case "odin_projectile_small_rod_mp":
            var_1 _ID25038( "ch_overlord" );
            break;
        case "cobra_20mm_mp":
        case "hind_bomb_mp":
        case "hind_missile_mp":
            var_1 _ID25038( "ch_choppervet" );
            break;
        case "guard_dog_mp":
            var_1 _ID25038( "ch_downboy" );
            break;
        case "ims_projectile_mp":
            var_1 _ID25038( "ch_outsmarted" );
            break;
        case "mortar_shelljugg_mp":
        case "iw6_minigunjugg_mp":
        case "iw6_p226jugg_mp":
            var_1 _ID25038( "ch_painless" );
            break;
        case "nuke_mp":
            var_0._ID35229 _ID25038( "ch_radiationsickness" );
            break;
        case "throwingknifejugg_mp":
        case "iw6_knifeonlyjugg_mp":
            break;
        case "agent_support_mp":
            break;
        default:
            break;
    }
}

ch_vehicle_killed( var_0 )
{
    if ( !isdefined( var_0.attacker ) || !isplayer( var_0.attacker ) )
        return;

    var_1 = var_0.attacker;
}

clearidshortly( var_0 )
{
    self endon( "disconnect" );
    self notify( "clearing_expID_" + var_0 );
    self endon( "clearing_expID_" + var_0 );
    wait 3.0;
    self._ID12529[var_0] = undefined;
}

_ID20999()
{
    var_0 = self;

    if ( !isdefined( var_0.pers["MGStreak"] ) )
    {
        var_0.pers["MGStreak"] = 0;
        var_0 thread endmgstreakwhenleavemg();

        if ( !isdefined( var_0.pers["MGStreak"] ) )
            return;
    }

    var_0.pers["MGStreak"]++;

    if ( var_0.pers["MGStreak"] >= 5 )
    {
        var_0 _ID25038( "ch_mgmaster" );
        return;
    }
}

endmgstreakwhenleavemg()
{
    self endon( "disconnect" );

    for (;;)
    {
        if ( !isalive( self ) || self usebuttonpressed() )
        {
            self.pers["MGStreak"] = undefined;
            break;
        }

        wait 0.05;
    }
}

_ID11737()
{
    self.pers["MGStreak"] = undefined;
}

killedbestenemyplayer( var_0 )
{
    if ( !isdefined( self.pers["countermvp_streak"] ) || !var_0 )
        self.pers["countermvp_streak"] = 0;

    self.pers["countermvp_streak"]++;

    if ( self.pers["countermvp_streak"] == 3 )
    {
        _ID25038( "ch_thebiggertheyare" );
        return;
    }

    if ( self.pers["countermvp_streak"] == 5 )
    {
        _ID25038( "ch_thehardertheyfall" );
        return;
    }

    return;
}

_ID18646( var_0 )
{
    if ( !isdefined( var_0.score ) || var_0.score < 1 )
        return 0;

    var_1 = level.players;

    if ( level._ID32653 )
        var_2 = var_0.pers["team"];
    else
        var_2 = "all";

    var_3 = var_0.score;

    for ( var_4 = 0; var_4 < var_1.size; var_4++ )
    {
        if ( !isdefined( var_1[var_4].score ) )
            continue;

        if ( var_1[var_4].score < 1 )
            continue;

        if ( var_2 != "all" && var_1[var_4].pers["team"] != var_2 )
            continue;

        if ( var_1[var_4].score > var_3 )
            return 0;
    }

    return 1;
}

_ID6820( var_0, var_1 )
{
    var_2 = var_0.attacker;
    var_3 = var_0._ID35229;
    var_3 _ID24480();

    if ( !isdefined( var_2 ) || !isplayer( var_2 ) )
        return;

    var_1 = var_0._ID33037;

    if ( var_2.pers["cur_kill_streak"] == 10 )
        var_2 _ID25038( "ch_fearless" );

    if ( level._ID32653 )
    {
        if ( level._ID32656[var_0._ID35229.pers["team"]] > 3 && var_2._ID19228.size == 4 && var_2.ch_tangodowncomplete == 0 )
        {
            var_2 _ID25038( "ch_tangodown" );
            var_2.ch_tangodowncomplete = 1;
        }

        if ( level._ID32656[var_0._ID35229.pers["team"]] > 3 && var_2.killedplayerscurrent.size == 4 && var_2.ch_extremecrueltycomplete == 0 )
        {
            var_2 _ID25038( "ch_extremecruelty" );
            var_2.ch_extremecrueltycomplete = 1;
        }
    }

    if ( isdefined( var_3._ID18015 ) && var_3._ID18015 == var_2 )
        var_2 _ID25038( "ch_smokeemifyougotem" );

    if ( isdefined( var_2._ID19228[var_0._ID35229._ID15851] ) && var_2._ID19228[var_0._ID35229._ID15851] == 5 )
        var_2 _ID25038( "ch_rival" );

    if ( isdefined( var_2._ID33115[var_0._ID32157] ) )
    {
        if ( var_2._ID33115[var_0._ID32157] == var_0._ID35229 && ( var_0._ID30258 != "MOD_MELEE" || maps\mp\gametypes\_weapons::_ID18766( var_0._ID32157 ) || maps\mp\gametypes\_weapons::isknifeonly( var_0._ID32157 ) ) )
            var_2 _ID25038( "ch_cruelty" );
    }

    var_4 = 0;
    var_5 = 0;
    var_6 = 0;
    var_7 = 1;
    var_8 = 0;
    var_9 = 0;
    var_10[var_0._ID35229.name] = var_0._ID35229.name;
    var_11[var_0._ID32157] = var_0._ID32157;
    var_12 = 1;
    var_13 = [];

    foreach ( var_15 in var_2._ID19246 )
    {
        if ( maps\mp\_utility::_ID18576( var_15._ID32157 ) && var_15._ID30258 != "MOD_MELEE" )
            var_5++;

        if ( var_15._ID32157 == var_2._ID24978 )
            var_8++;
        else if ( var_15._ID32157 == var_2._ID27984 )
            var_9++;

        if ( isdefined( var_15._ID21280["longshot"] ) )
            var_6++;

        if ( var_1 - var_15._ID33037 < 10000 )
            var_7++;

        if ( maps\mp\_utility::_ID18679( var_15._ID32157 ) )
        {
            if ( !isdefined( var_13[var_15._ID32157] ) )
                var_13[var_15._ID32157] = 0;

            var_13[var_15._ID32157]++;
            continue;
        }

        if ( isdefined( level._ID22814[var_2.team] ) && var_15._ID33037 > level._ID22814[var_2.team] )
            var_4++;

        if ( isdefined( var_15._ID35229 ) )
        {
            if ( !isdefined( var_10[var_15._ID35229.name] ) && !isdefined( var_11[var_15._ID32157] ) )
                var_12++;

            var_10[var_15._ID35229.name] = var_15._ID35229.name;
        }

        var_11[var_15._ID32157] = var_15._ID32157;
    }

    foreach ( var_19, var_18 in var_13 )
    {
        if ( var_18 >= 10 )
            var_2 _ID25038( "ch_crabmeat" );
    }

    if ( var_12 == 3 )
        var_2 _ID25038( "ch_renaissance" );

    if ( var_7 > 3 && level._ID32656[var_0._ID35229.team] <= var_7 )
        var_2 _ID25038( "ch_omnicide" );

    if ( maps\mp\_utility::_ID18576( var_0._ID32157 ) && var_5 == 2 )
        var_2 _ID25038( "ch_sidekick" );

    if ( isdefined( var_0._ID21280["longshot"] ) && var_6 == 2 )
        var_2 _ID25038( "ch_nbk" );

    if ( isdefined( level._ID22814[var_2.team] ) && var_4 == 2 )
        var_2 _ID25038( "ch_enemyofthestate" );

    if ( var_0._ID32157 == "iw6_knifeonlyjugg_mp" )
    {
        var_20[var_0._ID35229.name] = 1;

        foreach ( var_15 in var_2._ID19246 )
        {
            if ( var_15._ID32157 == "iw6_knifeonlyjugg_mp" )
            {
                if ( isdefined( var_15._ID35229 ) && !isdefined( var_20[var_15._ID35229.name] ) )
                    var_20[var_15._ID35229.name] = 1;
            }
        }

        if ( var_20.size >= 6 )
            var_2 _ID25038( "ch_noplacetohide" );
    }

    if ( var_0._ID30258 != "MOD_MELEE" )
    {
        if ( var_0._ID32157 == var_2._ID24978 && var_8 < var_9 || var_0._ID32157 == var_2._ID27984 && var_9 < var_8 )
            var_2 _ID25038( "ch_always_deadly" );

        if ( var_2 _ID29884( "specialty_twoprimaries" ) && var_2._ID27984 == var_0._ID32157 )
            var_2 _ID25038( "ch_twoprimaries_pro" );
    }

    if ( var_0._ID35229.score > 0 )
    {
        if ( level._ID32653 )
        {
            var_23 = var_0._ID35229.pers["team"];

            if ( isdefined( var_23 ) && var_23 != var_2.pers["team"] )
            {
                if ( _ID18646( var_0._ID35229 ) && level.players.size >= 6 )
                    var_2 killedbestenemyplayer( 1 );
                else
                    var_2 killedbestenemyplayer( 0 );
            }
        }
        else if ( _ID18646( var_0._ID35229 ) && level.players.size >= 4 )
            var_2 killedbestenemyplayer( 1 );
        else
            var_2 killedbestenemyplayer( 0 );
    }

    if ( isdefined( var_0._ID21280["avenger"] ) )
        var_2 _ID25038( "ch_avenger" );

    if ( isdefined( var_0._ID21280["buzzkill"] ) && var_0._ID21280["buzzkill"] >= 9 )
        var_2 _ID25038( "ch_thedenier" );

    if ( maps\mp\_utility::_ID18757( var_2 ) && var_0._ID32157 != "none" )
    {
        if ( isdefined( var_2.killsthislifeperweapon[var_0._ID32157] ) )
            var_2.killsthislifeperweapon[var_0._ID32157]++;
        else
            var_2.killsthislifeperweapon[var_0._ID32157] = 1;
    }

    if ( maps\mp\_utility::_ID18679( var_0._ID32157 ) && !allowkillchallengeforkillstreak( var_2, var_0._ID32157 ) )
        return;

    if ( isdefined( var_0._ID21280["jackintheboxkill"] ) )
        var_2 _ID25038( "ch_jackinthebox" );

    if ( isdefined( var_0._ID21280["cooking"] ) )
        var_2 _ID25038( "ch_no" );

    if ( var_2 _ID18553() )
    {
        var_2.brinkofdeathkillstreak++;

        if ( isnumbermultipleof( var_2.brinkofdeathkillstreak, 3 ) )
            var_2 _ID25038( "ch_thebrink" );
    }

    if ( var_2 _ID29884( "specialty_gpsjammer" ) )
    {
        var_24 = 0;

        if ( level._ID32653 )
        {
            var_25 = level.comexpfuncs["getRadarStrengthForTeam"];
            var_24 = [[ var_25 ]]( maps\mp\_utility::getotherteam( var_2.team ) );
        }
        else
        {
            foreach ( var_27 in level._ID34657 )
            {
                if ( isdefined( var_27 ) && var_27.owner._ID15851 != var_2._ID15851 )
                {
                    var_24++;
                    break;
                }
            }
        }

        if ( var_24 > 0 )
            var_2 _ID25038( "ch_offthegrid" );
    }

    if ( var_2 _ID29884( "specialty_deadeye" ) )
        var_2 _ID25038( "ch_deadeye" );

    if ( var_2 _ID29884( "specialty_lightweight" ) )
        var_2 _ID25038( "ch_lightweight" );

    if ( var_2 _ID29884( "specialty_extra_attachment" ) && var_0._ID32157 != "none" )
    {
        var_29 = maps\mp\_utility::weapongetnumattachments( var_0._ID32157 );
        var_30 = 2;

        if ( maps\mp\gametypes\_weapons::issidearm( var_0._ID32157 ) )
            var_30 = 1;

        if ( var_29 > var_30 )
            var_2 _ID25038( "ch_extra_attachment" );
    }

    if ( var_2 _ID29884( "specialty_gambler" ) )
        var_2 _ID25038( "ch_gambler" );

    if ( var_2 _ID29884( "specialty_regenfaster" ) && var_2.health < var_2.maxhealth )
        var_2 _ID25038( "ch_regenfaster" );

    if ( var_2 _ID29884( "specialty_sprintreload" ) && isdefined( var_2._ID31107 ) && gettime() <= var_2._ID31107 && var_2._ID19602 == var_0._ID32157 && var_0._ID30258 != "MOD_MELEE" )
        var_2 _ID25038( "ch_onthego" );

    if ( var_2 _ID29884( "specialty_pitcher" ) && maps\mp\gametypes\_weapons::isoffhandweapon( var_0._ID32157 ) )
        var_2 _ID25038( "ch_pitcher" );

    if ( var_2 _ID29884( "specialty_silentkill" ) )
        var_2 _ID25038( "ch_silentkill" );

    if ( var_2 _ID29884( "specialty_comexp" ) && level._ID34657.size > 0 )
        var_2 _ID25038( "ch_comexp" );

    if ( var_2 _ID29884( "specialty_boom" ) )
    {
        var_31 = var_2 maps\mp\_utility::getuniqueid();

        if ( isdefined( var_3.markedbyboomperk ) && isdefined( var_3.markedbyboomperk[var_31] ) && gettime() <= var_3.markedbyboomperk[var_31] )
        {
            var_2 _ID25038( "ch_boom" );
            var_3.markedbyboomperk = undefined;
        }
    }

    if ( !maps\mp\gametypes\_weapons::isoffhandweapon( var_0._ID32157 ) && var_0._ID32157 != var_2.pers["primaryWeapon"] && var_0._ID32157 != var_2.pers["secondaryWeapon"] )
        var_2 _ID25038( "ch_wiseguy" );

    if ( !maps\mp\gametypes\_weapons::isoffhandweapon( var_0._ID32157 ) && var_0._ID30258 != "MOD_MELEE" )
    {
        if ( !isdefined( var_2.killsthismag ) )
            var_2.killsthismag = [];

        if ( isdefined( var_2.killsthismag[var_0._ID32157] ) )
        {
            var_2.killsthismag[var_0._ID32157]++;

            if ( isnumbermultipleof( var_2.killsthismag[var_0._ID32157], 4 ) )
                var_2 _ID25038( "ch_meticulous" );
        }
        else
            var_2.killsthismag[var_0._ID32157] = 1;
    }

    var_32 = 0;

    if ( level._ID32653 )
        var_32 = level.activeuavs[maps\mp\_utility::getotherteam( var_2.team )] > 0;
    else
        var_32 = level.activeuavs[var_3._ID15851] > 0;

    if ( var_32 )
        var_2 _ID25038( "ch_youcantseeme" );

    if ( var_2 _ID29884( "specialty_incog" ) )
        var_2 _ID25038( "ch_incog" );

    if ( isdefined( level._ID19723 ) && isdefined( level._ID19723.owner ) && level._ID19723.owner == var_3 && _ID29884( "specialty_blindeye" ) )
        _ID25038( "ch_blindeye_pro" );

    if ( var_0._ID32157 == "none" )
    {
        if ( isdefined( var_0._ID35229.explosiveinfo ) && isdefined( var_0._ID35229.explosiveinfo["weapon"] ) )
            var_0._ID32157 = var_0._ID35229.explosiveinfo["weapon"];
        else
            return;
    }

    var_33 = maps\mp\_utility::_ID14903( var_0._ID32157 );
    var_34 = maps\mp\_utility::getweaponclass( var_0._ID32157 );

    if ( var_0._ID30258 == "MOD_PISTOL_BULLET" || var_0._ID30258 == "MOD_RIFLE_BULLET" || var_0._ID30258 == "MOD_HEAD_SHOT" )
    {
        ch_bulletdamagecommon( var_0, var_2, var_1, var_34 );

        if ( var_34 == "weapon_mg" )
            var_2 _ID20999();
        else
        {
            switch ( var_34 )
            {
                case "weapon_smg":
                    var_2 processweaponclasschallenge_smg( var_33, var_0 );
                    break;
                case "weapon_assault":
                    var_2 processweaponclasschallenge_ar( var_33, var_0 );
                    break;
                case "weapon_shotgun":
                    var_2 processweaponclasschallenge_shotgun( var_33, var_0 );
                    break;
                case "weapon_dmr":
                    var_2 processweaponclasschallenge_dmr( var_33, var_0 );
                    break;
                case "weapon_sniper":
                    var_2 processweaponclasschallenge_sniper( var_33, var_0 );
                    break;
                case "weapon_pistol":
                    var_2 _ID25038( "ch_handgun_kill" );

                    if ( var_33 == "iw6_magnum" )
                    {
                        var_35 = maps\mp\_utility::_ID15474( var_0._ID32157 );
                        var_36 = 0;

                        foreach ( var_38 in var_35 )
                        {
                            if ( var_38 == "acog" )
                            {
                                var_36++;
                                continue;
                            }

                            if ( var_38 == "akimbo" )
                                var_36++;
                        }

                        if ( var_35.size == 2 && var_36 == 2 )
                            var_2 _ID25038( "ch_noidea" );
                    }

                    if ( var_2 checkwaslastweaponriotshield() && isdefined( var_2.lastprimaryweaponswaptime ) && gettime() - var_2.lastprimaryweaponswaptime < 2000 )
                        var_2 _ID25038( "ch_iw6_riotshield_pistol" );

                    break;
                case "weapon_lmg":
                    var_2 processweaponclasschallenge_lmg( var_33, var_0 );
                    break;
                default:
                    break;
            }

            if ( var_0._ID30258 == "MOD_HEAD_SHOT" )
            {
                if ( isdefined( var_0._ID21280["revenge"] ) )
                    var_2 _ID25038( "ch_colorofmoney" );

                if ( maps\mp\_utility::_ID18801( var_0._ID32157, "frag_" ) )
                    var_2 _ID25038( "ch_thinkfast" );
                else if ( maps\mp\_utility::_ID18801( var_0._ID32157, "concussion_" ) )
                    var_2 _ID25038( "ch_thinkfastconcussion" );
                else if ( maps\mp\_utility::_ID18801( var_0._ID32157, "flash_" ) )
                    var_2 _ID25038( "ch_thinkfastflash" );
            }
        }
    }
    else if ( issubstr( var_0._ID30258, "MOD_GRENADE" ) || issubstr( var_0._ID30258, "MOD_EXPLOSIVE" ) || issubstr( var_0._ID30258, "MOD_PROJECTILE" ) )
    {
        if ( maps\mp\_utility::_ID18801( var_0._ID32157, "frag_grenade_short" ) && ( !isdefined( var_0._ID35229.explosiveinfo["throwbackKill"] ) || !var_0._ID35229.explosiveinfo["throwbackKill"] ) )
            var_2 _ID25038( "ch_martyr" );

        if ( isdefined( var_0._ID35229.explosiveinfo["damageTime"] ) && var_0._ID35229.explosiveinfo["damageTime"] == var_1 )
        {
            var_40 = var_1 + "_" + var_0._ID35229.explosiveinfo["damageId"];

            if ( !isdefined( var_2._ID12529[var_40] ) )
                var_2._ID12529[var_40] = 0;

            var_2 thread clearidshortly( var_40 );
            var_2._ID12529[var_40]++;
            var_35 = maps\mp\_utility::_ID15474( var_0._ID32157 );

            foreach ( var_42 in var_35 )
            {
                switch ( var_42 )
                {
                    case "gl":
                        if ( maps\mp\_utility::_ID18801( var_0._ID32157, "alt_" ) )
                            var_2 processweaponattachmentchallenge( var_33, var_42 );

                        continue;
                }
            }

            if ( isdefined( var_0._ID35229.explosiveinfo["stickKill"] ) && var_0._ID35229.explosiveinfo["stickKill"] )
            {
                if ( isdefined( var_0._ID21280["revenge"] ) )
                    var_2 _ID25038( "ch_overdraft" );

                if ( var_2._ID12529[var_40] > 1 )
                    var_2 _ID25038( "ch_grouphug" );
            }

            if ( isdefined( var_0._ID35229.explosiveinfo["stickFriendlyKill"] ) && var_0._ID35229.explosiveinfo["stickFriendlyKill"] )
                var_2 _ID25038( "ch_resourceful" );

            if ( var_0._ID35229.explosiveinfo["throwbackKill"] )
                var_2 _ID25038( "ch_throwaway" );

            if ( maps\mp\_utility::_ID18801( var_0._ID32157, "frag_" ) )
            {
                if ( var_2._ID12529[var_40] > 1 )
                    var_2 _ID25038( "ch_multifrag" );

                if ( isdefined( var_0._ID21280["revenge"] ) )
                    var_2 _ID25038( "ch_bangforbuck" );

                var_2 _ID25038( "ch_grenadekill" );

                if ( var_0._ID35229.explosiveinfo["cookedKill"] )
                    var_2 _ID25038( "ch_masterchef" );

                if ( var_0._ID35229.explosiveinfo["suicideGrenadeKill"] )
                    var_2 _ID25038( "ch_miserylovescompany" );

                if ( var_0._ID35229.explosiveinfo["throwbackKill"] )
                    var_2 _ID25038( "ch_hotpotato" );
            }
            else if ( maps\mp\_utility::_ID18801( var_0._ID32157, "semtex" ) || var_0._ID32157 == "iw6_mk32_mp" )
            {
                if ( isdefined( var_0._ID21280["revenge"] ) )
                    var_2 _ID25038( "ch_timeismoney" );

                if ( isdefined( var_0._ID35229.explosiveinfo["stickKill"] ) && var_0._ID35229.explosiveinfo["stickKill"] )
                    var_2 _ID25038( "ch_plastered" );

                var_0._ID35229.stuckbygrenade = undefined;
            }
            else if ( maps\mp\_utility::_ID18801( var_0._ID32157, "c4_" ) )
            {
                if ( isdefined( var_0._ID21280["revenge"] ) )
                    var_2 _ID25038( "ch_iamrich" );

                if ( var_2._ID12529[var_40] > 1 )
                    var_2 _ID25038( "ch_multic4" );

                if ( var_0._ID35229.explosiveinfo["returnToSender"] )
                    var_2 _ID25038( "ch_returntosender" );

                if ( var_0._ID35229.explosiveinfo["counterKill"] )
                    var_2 _ID25038( "ch_counterc4" );

                if ( isdefined( var_0._ID35229.explosiveinfo["bulletPenetrationKill"] ) && var_0._ID35229.explosiveinfo["bulletPenetrationKill"] )
                    var_2 _ID25038( "ch_howthe" );

                if ( var_0._ID35229.explosiveinfo["chainKill"] )
                    var_2 _ID25038( "ch_dominos" );

                var_2 _ID25038( "ch_c4shot" );

                if ( var_2 checkwaslastweaponriotshield() )
                    var_2 _ID25038( "ch_iw6_riotshield_c4" );
            }
            else if ( maps\mp\_utility::_ID18801( var_0._ID32157, "proximity_explosive_" ) )
            {
                var_2 _ID25038( "ch_proximityexplosive" );

                if ( isdefined( var_0._ID21280["revenge"] ) )
                    var_2 _ID25038( "ch_breakbank" );

                if ( var_0._ID35229.explosiveinfo["chainKill"] )
                    var_2 _ID25038( "ch_dominos" );
            }
            else if ( maps\mp\_utility::_ID18801( var_0._ID32157, "mortar_shell_" ) )
                var_2 _ID25038( "ch_mortarshell" );
            else if ( var_0._ID32157 == "explodable_barrel" )
            {

            }
            else if ( var_0._ID32157 == "destructible_car" )
                var_2 _ID25038( "ch_carbomb" );
            else if ( maps\mp\gametypes\_weapons::isrocketlauncher( var_0._ID32157 ) )
            {
                var_44 = var_2._ID12529[var_40];

                if ( isnumbermultipleof( var_44, 2 ) )
                    var_2 _ID25038( "ch_multirpg" );
            }

            if ( var_2 _ID29884( "specialty_explosivedamage" ) )
                var_2 _ID25038( "ch_explosivedamage" );

            var_2 checkchallengeextradeadly( var_0._ID32157 );
        }
    }
    else if ( issubstr( var_0._ID30258, "MOD_MELEE" ) && !maps\mp\gametypes\_weapons::_ID18766( var_0._ID32157 ) )
    {
        var_2 _ID11737();
        var_2 _ID25038( "ch_knifevet" );
        var_2.pers["meleeKillStreak"]++;

        if ( var_2.pers["meleeKillStreak"] == 3 )
            var_2 _ID25038( "ch_slasher" );

        if ( var_2 isitemunlocked( "specialty_quieter" ) && var_2 maps\mp\_utility::_hasperk( "specialty_quieter" ) )
            var_2 _ID25038( "ch_deadsilence_pro" );

        var_45 = var_0._ID35229._ID3366[1];
        var_46 = var_2._ID3367[1];
        var_47 = angleclamp180( var_45 - var_46 );

        if ( abs( var_47 ) < 30 )
        {
            var_2 _ID25038( "ch_backstabber" );

            if ( isdefined( var_2.attackers ) )
            {
                foreach ( var_49 in var_2.attackers )
                {
                    if ( !isdefined( maps\mp\_utility::_validateattacker( var_49 ) ) )
                        continue;

                    if ( var_49 != var_0._ID35229 )
                        continue;

                    var_2 _ID25038( "ch_neverforget" );
                    break;
                }
            }
        }

        if ( !var_2 _ID24496() && var_33 != "iw6_knifeonly" && var_33 != "iw6_knifeonlyfast" && var_33 != "iw6_knifeonlyjugg" )
            var_2 _ID25038( "ch_survivor" );

        if ( isdefined( var_2._ID17566 ) )
            var_0._ID35229 _ID25038( "ch_infected" );

        if ( isdefined( var_0._ID35229._ID23675 ) )
            var_2 _ID25038( "ch_plague" );

        if ( var_2 playerissprintsliding() )
            var_2 _ID25038( "ch_smooth_moves" );

        var_35 = maps\mp\_utility::_ID15474( var_0._ID32157 );

        foreach ( var_42 in var_35 )
        {
            switch ( var_42 )
            {
                case "tactical":
                    var_2 processweaponattachmentchallenge( var_33, var_42 );
                    continue;
            }
        }

        if ( var_2._ID36267.size == 1 && ( var_2._ID36267[0] == "iw6_knifeonly_mp" || var_2._ID36267[0] == "iw6_knifeonlyfast_mp" ) )
            var_2 _ID25038( "ch_ballsofsteel" );

        if ( checkcostumechallenge( var_3, "mp_fullbody_sniper_ab" ) )
            var_2 _ID25038( "ch_bigfoot" );
    }
    else if ( maps\mp\gametypes\_weapons::_ID18766( var_0._ID32157 ) )
    {
        if ( issubstr( var_0._ID30258, "MOD_MELEE" ) )
        {
            var_2 _ID11737();
            var_2 _ID25038( "ch_shieldvet" );
            var_2.pers["shieldKillStreak"]++;
            var_2 _ID25038( "ch_riot_kill" );
            var_45 = var_0._ID35229._ID3366[1];
            var_46 = var_2._ID3367[1];
            var_47 = angleclamp180( var_45 - var_46 );

            if ( abs( var_47 ) < 30 )
                var_2 _ID25038( "ch_iw6_riotshield_backsmasher" );

            if ( !var_2 _ID24496() )
                var_2 _ID25038( "ch_survivor" );

            var_2 processweaponclasschallenge_riotshield( var_33, var_0 );
        }

        var_35 = maps\mp\_utility::_ID15474( var_0._ID32157 );

        foreach ( var_42 in var_35 )
        {
            switch ( var_42 )
            {
                case "rshieldradar":
                case "rshieldscrambler":
                case "rshieldspikes":
                    var_2 processweaponattachmentchallenge( var_33, var_42 );
                    continue;
            }
        }
    }
    else if ( issubstr( var_0._ID30258, "MOD_IMPACT" ) )
    {
        if ( maps\mp\_utility::_ID18801( var_0._ID32157, "frag_" ) )
            var_2 _ID25038( "ch_thinkfast" );
        else if ( maps\mp\_utility::_ID18801( var_0._ID32157, "concussion_" ) )
            var_2 _ID25038( "ch_thinkfastconcussion" );
        else if ( maps\mp\_utility::_ID18801( var_0._ID32157, "flash_" ) )
            var_2 _ID25038( "ch_thinkfastflash" );

        if ( maps\mp\gametypes\_weapons::isthrowingknife( var_0._ID32157 ) )
        {
            if ( isdefined( var_0._ID21280["revenge"] ) )
                var_2 _ID25038( "ch_atm" );

            var_2 _ID25038( "ch_carnie" );

            if ( isdefined( var_0._ID35229.attackerdata[var_2._ID15851] ) )
                var_2 _ID25038( "ch_its_personal" );

            if ( var_2 isitemunlocked( "specialty_fastoffhand" ) && var_2 maps\mp\_utility::_hasperk( "specialty_fastoffhand" ) )
                var_2 _ID25038( "ch_fastoffhand" );

            if ( var_2 checkwaslastweaponriotshield() )
                var_2 _ID25038( "ch_iw6_riotshield_throwingknife" );

            var_2 checkchallengeextradeadly( var_0._ID32157 );
        }

        var_35 = maps\mp\_utility::_ID15474( var_0._ID32157 );

        foreach ( var_42 in var_35 )
        {
            switch ( var_42 )
            {
                case "gl":
                    if ( maps\mp\_utility::_ID18801( var_0._ID32157, "alt_" ) )
                    {
                        var_2 processweaponattachmentchallenge( var_33, var_42 );
                        var_2 _ID25038( "ch_ouch" );
                    }

                    continue;
            }
        }
    }

    if ( ( var_0._ID30258 == "MOD_PISTOL_BULLET" || var_0._ID30258 == "MOD_RIFLE_BULLET" || var_0._ID30258 == "MOD_HEAD_SHOT" ) && !maps\mp\_utility::_ID18679( var_0._ID32157 ) && !maps\mp\_utility::_ID18615( var_0._ID32157 ) )
    {
        var_35 = maps\mp\_utility::_ID15474( var_0._ID32157 );

        foreach ( var_42 in var_35 )
        {
            switch ( var_42 )
            {
                case "acog":
                    var_2 processweaponattachmentchallenge_acog( var_33, var_42, var_0 );
                    continue;
                case "eotech":
                    var_2 processweaponattachmentchallenge_eotech( var_33, var_42, var_0 );
                    continue;
                case "hybrid":
                    var_2 processweaponattachmentchallenge_hybrid( var_33, var_42, var_0 );
                    continue;
                case "reflex":
                    var_2 processweaponattachmentchallenge_reflex( var_33, var_42, var_0 );
                    continue;
                case "scope":
                case "ironsight":
                case "thermal":
                case "tracker":
                case "vzscope":
                    if ( var_2 maps\mp\_utility::isplayerads() )
                        var_2 processweaponattachmentchallenge( var_33, var_42 );

                    continue;
                case "akimbo":
                case "firetypeburst":
                case "firetypeauto":
                case "firetypesingle":
                case "ammoslug":
                case "barrelbored":
                case "barrelrange":
                case "flashsuppress":
                case "grip":
                case "rof":
                case "silencer":
                case "xmags":
                    var_2 processweaponattachmentchallenge( var_33, var_42 );
                    continue;
                case "shotgun":
                case "gl":
                    if ( maps\mp\_utility::_ID18801( var_0._ID32157, "alt_" ) )
                        var_2 processweaponattachmentchallenge( var_33, var_42 );

                    continue;
                case "fmj":
                    var_2 _ID25038( "ch_armorpiercing" );
                    continue;
                default:
                    continue;
            }
        }

        if ( maps\mp\_utility::weaponhasintegratedfiretypeburst( var_0._ID32157 ) )
            var_2 processweaponattachmentchallenge( var_33, "firetypeburst" );

        if ( maps\mp\_utility::weaponhasintegratedsilencer( var_33 ) )
            var_2 processweaponattachmentchallenge( var_33, "silencer" );

        if ( maps\mp\_utility::weaponhasintegratedgrip( var_33 ) )
            var_2 processweaponattachmentchallenge( var_33, "grip" );

        if ( maps\mp\_utility::weaponhasintegratedfmj( var_33 ) )
            var_2 processweaponattachmentchallenge( var_33, "fmj" );

        if ( var_2 maps\mp\_utility::isplayerads() && maps\mp\_utility::weaponhasintegratedtrackerscope( var_0._ID32157 ) )
            var_2 processweaponattachmentchallenge( var_33, "tracker" );

        var_59 = maps\mp\_utility::getnumdefaultattachments( var_0._ID32157 );

        if ( var_35.size == var_59 )
            var_2 _ID25038( "ch_noattachments" );

        if ( var_2 _ID29884( "specialty_bulletaccuracy" ) && !var_2 maps\mp\_utility::isplayerads() )
            var_2 _ID25038( "ch_bulletaccuracy_pro" );

        if ( var_2 _ID29884( "specialty_stalker" ) && var_2 maps\mp\_utility::isplayerads() )
            var_2 _ID25038( "ch_stalker_pro" );

        if ( distancesquared( var_2.origin, var_0._ID35229.origin ) < 65536 )
        {
            if ( var_2 _ID29884( "specialty_quieter" ) )
                var_2 _ID25038( "ch_deadsilence_pro" );
        }

        if ( var_2 _ID29884( "specialty_fastreload" ) && var_2 hasreloadedrecently() )
            var_2 _ID25038( "ch_sleightofhand_pro" );

        if ( var_2 _ID29884( "specialty_sharp_focus" ) )
        {
            if ( isdefined( var_2.attackers ) && var_2.attackers.size > 0 )
                var_2 _ID25038( "ch_sharp_focus" );
        }
    }

    if ( var_2 isitemunlocked( "specialty_quickdraw" ) && var_2 maps\mp\_utility::_hasperk( "specialty_quickdraw" ) && ( var_2.adstime > 0 && var_2.adstime < 3 ) )
        var_2 _ID25038( "ch_quickdraw_pro" );

    if ( var_2 isitemunlocked( "specialty_empimmune" ) && var_2 maps\mp\_utility::_hasperk( "specialty_empimmune" ) )
    {
        if ( level._ID32653 )
        {
            var_60 = 0;

            foreach ( var_62 in level._ID34165[maps\mp\_utility::getotherteam( var_2.team )] )
            {
                if ( var_62._ID34170 != "counter" )
                    continue;

                var_60 = 1;
                break;
            }

            if ( var_60 || var_2 maps\mp\_utility::_ID18610() )
                var_2 _ID25038( "ch_spygame" );
        }
        else if ( var_2.isradarblocked || var_2 maps\mp\_utility::_ID18610() )
            var_2 _ID25038( "ch_spygame" );
    }

    if ( isdefined( var_0._ID35229.isplanting ) && var_0._ID35229.isplanting )
        var_2 _ID25038( "ch_bombplanter" );

    if ( isdefined( var_0._ID35229.isdefusing ) && var_0._ID35229.isdefusing )
        var_2 _ID25038( "ch_bombdefender" );

    if ( isdefined( var_0._ID35229.isbombcarrier ) && var_0._ID35229.isbombcarrier && ( !isdefined( level._ID9003 ) || !level._ID9003 ) )
        var_2 _ID25038( "ch_bombdown" );

    if ( isdefined( var_0._ID35229._ID35917 ) && var_0._ID35229._ID35917 )
        var_2 _ID25038( "ch_tacticaldeletion" );

    if ( var_2 isitemunlocked( "specialty_quickswap" ) && var_2 maps\mp\_utility::_hasperk( "specialty_quickswap" ) )
    {
        if ( isdefined( var_2.lastprimaryweaponswaptime ) && gettime() - var_2.lastprimaryweaponswaptime < 3000 )
            var_2 _ID25038( "ch_quickswap" );
    }

    if ( var_2 isitemunlocked( "specialty_extraammo" ) && var_2 maps\mp\_utility::_hasperk( "specialty_extraammo" ) )
        var_2 _ID25038( "ch_extraammo" );

    if ( isexplosivedamagemod( var_0._ID30258 ) )
    {
        switch ( var_0._ID32157 )
        {
            case "frag_grenade_mp":
            case "mortar_shell_mp":
            case "flash_grenade_mp":
            case "emp_grenade_mp":
            case "thermobaric_grenade_mp":
            case "concussion_grenade_mp":
            case "semtex_mp":
                if ( var_2 isitemunlocked( "specialty_fastoffhand" ) && var_2 maps\mp\_utility::_hasperk( "specialty_fastoffhand" ) )
                    var_2 _ID25038( "ch_fastoffhand" );

                break;
        }

        if ( isdefined( var_3._ID32899 ) && var_3._ID32899 )
            var_2 _ID25038( "ch_thermobaric" );
    }

    if ( var_2 isitemunlocked( "specialty_overkillpro" ) && var_2 maps\mp\_utility::_hasperk( "specialty_overkillpro" ) )
    {
        if ( var_2._ID27984 == var_0._ID32157 )
        {
            var_35 = getweaponattachments( var_0._ID32157 );

            if ( var_35.size > 0 )
                var_2 _ID25038( "ch_secondprimary" );
        }
    }

    if ( var_2 isitemunlocked( "specialty_stun_resistance" ) && var_2 maps\mp\_utility::_hasperk( "specialty_stun_resistance" ) )
    {
        if ( isdefined( var_2.lastflashedtime ) && gettime() - var_2.lastflashedtime < 5000 )
            var_2 _ID25038( "ch_stunresistance" );
        else if ( isdefined( var_2._ID19536 ) && gettime() - var_2._ID19536 < 5000 )
            var_2 _ID25038( "ch_stunresistance" );
    }

    if ( var_2 isitemunlocked( "specialty_selectivehearing" ) && var_2 maps\mp\_utility::_hasperk( "specialty_selectivehearing" ) )
        var_2 _ID25038( "ch_selectivehearing" );

    if ( var_2 isitemunlocked( "specialty_fastsprintrecovery" ) && var_2 maps\mp\_utility::_hasperk( "specialty_fastsprintrecovery" ) )
    {
        if ( isdefined( var_2._ID19617 ) && gettime() - var_2._ID19617 < 3000 )
        {
            var_2 _ID25038( "ch_fastsprintrecovery" );
            return;
        }

        return;
    }
}

ch_bulletdamagecommon( var_0, var_1, var_2, var_3 )
{
    if ( !maps\mp\_utility::_ID18615( var_0._ID32157 ) )
        var_1 _ID11737();

    if ( maps\mp\_utility::_ID18679( var_0._ID32157 ) )
        return;

    if ( var_1.pers["lastBulletKillTime"] == var_2 )
        var_1.pers["bulletStreak"]++;
    else
        var_1.pers["bulletStreak"] = 1;

    var_1.pers["lastBulletKillTime"] = var_2;

    if ( !var_0._ID35231 )
        var_1 _ID25038( "ch_hardlanding" );

    if ( !var_0._ID4097 )
        var_1.pers["midairStreak"]++;

    if ( var_1.pers["midairStreak"] == 2 )
        var_1 _ID25038( "ch_airborne" );

    if ( var_2 < var_0._ID35229.flashendtime )
        var_1 _ID25038( "ch_flashbangvet" );

    if ( var_2 < var_1.flashendtime )
        var_1 _ID25038( "ch_blindfire" );

    if ( var_2 < var_0._ID35229._ID7852 )
        var_1 _ID25038( "ch_concussionvet" );

    if ( var_2 < var_1._ID7852 )
        var_1 _ID25038( "ch_slowbutsure" );

    if ( var_1.pers["bulletStreak"] == 2 )
    {
        if ( isdefined( var_0._ID21280["headshot"] ) )
        {
            foreach ( var_5 in var_1._ID19246 )
            {
                if ( var_5._ID33037 != var_2 )
                    continue;

                if ( !isdefined( var_0._ID21280["headshot"] ) )
                    continue;

                var_1 _ID25038( "ch_allpro" );
            }
        }

        if ( var_3 == "weapon_sniper" )
            var_1 _ID25038( "ch_collateraldamage" );
    }

    if ( var_3 == "weapon_pistol" )
    {
        if ( isdefined( var_0._ID35229.attackerdata ) && isdefined( var_0._ID35229.attackerdata[var_1._ID15851] ) )
        {
            if ( isdefined( var_0._ID35229.attackerdata[var_1._ID15851]._ID18748 ) )
                var_1 _ID25038( "ch_fastswap" );
        }
    }

    if ( !isdefined( var_1._ID17611 ) || !var_1._ID17611 )
    {
        if ( var_0.attackerstance == "crouch" )
            var_1 _ID25038( "ch_crouchshot" );
        else if ( var_0.attackerstance == "prone" )
        {
            var_1 _ID25038( "ch_proneshot" );

            if ( var_3 == "weapon_sniper" )
                var_1 _ID25038( "ch_invisible" );
        }
    }

    if ( issubstr( var_0._ID32157, "silencer" ) )
    {
        var_1 _ID25038( "ch_stealthvet" );
        return;
    }
}

ch_roundplayed( var_0 )
{
    var_1 = var_0.player;

    if ( var_1._ID35903 )
    {
        var_2 = var_1.pers["deaths"];
        var_3 = var_1.pers["kills"];
        var_4 = 1000000;

        if ( var_2 > 0 )
            var_4 = var_3 / var_2;

        if ( var_4 >= 5.0 && var_3 >= 5.0 )
            var_1 _ID25038( "ch_starplayer" );

        if ( var_2 == 0 && maps\mp\_utility::_ID15435() > 300000 )
            var_1 _ID25038( "ch_flawless" );

        if ( level._ID23663["all"].size < 3 )
            return;

        if ( var_1.score > 0 )
        {
            switch ( level._ID14086 )
            {
                case "gun":
                case "dm":
                    if ( var_0._ID23652 < 3 )
                    {
                        var_1 _ID25038( "ch_victor_dm" );
                        var_1 _ID25038( "ch_hunted_victor" );
                    }

                    break;
                case "sotf_ffa":
                    if ( var_0._ID23652 < 3 )
                        var_1 _ID25038( "ch_hunted_victor" );

                    break;
            }

            return;
        }

        return;
    }
}

ch_roundwin( var_0 )
{
    if ( !var_0.winner )
        return;

    var_1 = var_0.player;

    if ( var_1._ID35903 )
    {
        switch ( level._ID14086 )
        {
            case "war":
                if ( level.hardcoremode )
                {
                    var_1 _ID25038( "ch_teamplayer_hc" );

                    if ( var_0._ID23652 == 0 )
                        var_1 _ID25038( "ch_mvp_thc" );
                }
                else
                {
                    var_1 _ID25038( "ch_teamplayer" );

                    if ( var_0._ID23652 <= 2 )
                    {
                        var_1 _ID25038( "ch_tdmskills" );

                        if ( var_0._ID23652 == 0 )
                            var_1 _ID25038( "ch_mvp_tdm" );
                    }
                }

                break;
            case "blitz":
                var_1 _ID25038( "ch_blitz_victor" );
                break;
            case "cranked":
                var_1 _ID25038( "ch_crank_victor" );
                break;
            case "dom":
                var_1 _ID25038( "ch_dom_victor" );
                break;
            case "grind":
                var_1 _ID25038( "ch_grind_victor" );
                break;
            case "infect":
                if ( var_1.team == "allies" )
                    var_1 _ID25038( "ch_alive" );

                var_1 _ID25038( "ch_infected" );
                break;
            case "sd":
                var_1 _ID25038( "ch_victor_sd" );
                break;
            case "sr":
                var_1 _ID25038( "ch_sr_victor" );
                break;
            case "conf":
                var_1 _ID25038( "ch_conf_victor" );
                break;
            case "sotf_ffa":
            case "gun":
            case "dm":
            case "koth":
                break;
            default:
                break;
        }

        var_2 = getdvarint( "scr_playlist_type", 0 );

        if ( var_2 == 1 )
        {
            var_1 _ID25038( "ch_bromance" );

            if ( !level.console )
                var_1 _ID25038( "ch_tactician" );
        }
        else if ( var_2 == 2 )
            var_1 _ID25038( "ch_tactician" );

        if ( level.hardcoremode )
        {
            var_1 _ID25038( "ch_hardcore_extreme" );
            return;
        }

        return;
    }
}

_ID24477( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( maps\mp\_utility::_ID18363() )
    {
        return;
        return;
    }

    _ID24478( var_0, var_1, var_2, var_3, var_4, var_5 );
    return;
}

_ID24478( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isplayer( self ) )
        return;

    self endon( "disconnect" );

    if ( isdefined( var_1 ) )
        var_1 endon( "disconnect" );

    wait 0.05;
    maps\mp\_utility::_ID35777();
    var_6 = spawnstruct();
    var_6._ID35229 = self;
    var_6.einflictor = var_0;
    var_6.attacker = var_1;
    var_6._ID17335 = var_2;
    var_6._ID30258 = var_3;
    var_6._ID32157 = var_4;
    var_6._ID29709 = var_5;
    var_6._ID35231 = var_6._ID35229 isonground();

    if ( isplayer( var_1 ) )
    {
        var_6.attackerinlaststand = isdefined( var_6.attacker.laststand );
        var_6._ID4097 = var_6.attacker isonground();
        var_6.attackerstance = var_6.attacker getstance();
    }
    else
    {
        var_6.attackerinlaststand = 0;
        var_6._ID4097 = 0;
        var_6.attackerstance = "stand";
    }

    domissioncallback( "playerDamaged", var_6 );
}

_ID24513( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( maps\mp\_utility::_ID18363() )
    {
        return;
        return;
    }

    playerkilled_regularmp( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 );
    return;
}

playerkilled_regularmp( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( maps\mp\_utility::_ID18837() )
        self._ID3366 = self.angles;
    else
        self._ID3366 = self getplayerangles();

    if ( isdefined( var_1 ) )
        var_1._ID3367 = var_1 getplayerangles();

    self endon( "disconnect" );
    var_8 = spawnstruct();
    var_8._ID35229 = self;
    var_8.einflictor = var_0;
    var_8.attacker = var_1;
    var_8._ID17335 = var_2;
    var_8._ID30258 = var_3;
    var_8._ID32157 = var_4;
    var_8._ID31095 = var_5;
    var_8._ID29709 = var_6;
    var_8._ID33037 = gettime();
    var_8._ID21280 = var_7;

    if ( isdefined( var_4 ) && issubstr( var_4, "_hybrid" ) )
    {
        if ( var_1 getcurrentweapon() == var_4 )
            var_8.hybridscopestate = var_1 gethybridscopestate( var_4 );
        else
            var_8.hybridscopestate = 0;
    }

    var_8._ID35231 = var_8._ID35229 isonground();

    if ( isplayer( var_1 ) )
    {
        var_8.attackerinlaststand = isdefined( var_8.attacker.laststand );
        var_8._ID4097 = var_8.attacker isonground();
        var_8.attackerstance = var_8.attacker getstance();
    }
    else
    {
        var_8.attackerinlaststand = 0;
        var_8._ID4097 = 0;
        var_8.attackerstance = "stand";
    }

    _ID35535( var_8 );

    if ( isdefined( var_1 ) && maps\mp\_utility::_ID18757( var_1 ) )
        var_1._ID19246[var_1._ID19246.size] = var_8;

    var_8.attacker notify( "playerKilledChallengesProcessed" );
}

vehiclekilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !maps\mp\_utility::_ID18363() )
    {
        _ID19261( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
        return;
    }
}

_ID19260( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !maps\mp\_utility::_ID18363() )
    {
        _ID19261( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
        return;
    }
}

_ID19261( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( var_3 ) && isplayer( var_3 ) && ( !isdefined( var_0 ) || var_3 != var_0 ) && var_3 maps\mp\_utility::_ID19242( var_6 ) )
    {
        var_3 maps\mp\killstreaks\_killstreaks::_ID15579( "vehicleDestroyed" );
        return;
    }
}

_ID35535( var_0 )
{
    if ( isdefined( var_0.attacker ) )
        var_0.attacker endon( "disconnect" );

    self._ID25042 = 1;
    wait 0.05;
    maps\mp\_utility::_ID35777();
    domissioncallback( "playerKilled", var_0 );
    self._ID25042 = undefined;
}

_ID24469( var_0 )
{
    var_1 = spawnstruct();
    var_1.player = self;
    var_1._ID35229 = var_0;
    var_2 = var_0.attackerdata[self._ID15851];

    if ( isdefined( var_2 ) )
        var_1._ID32157 = var_2.weapon;

    domissioncallback( "playerAssist", var_1 );
}

_ID34746( var_0 )
{
    if ( maps\mp\_utility::_ID18363() )
    {
        return;
        return;
    }

    usehardpoint_regularmp( var_0 );
    return;
}

usehardpoint_regularmp( var_0 )
{
    self endon( "disconnect" );
    wait 0.05;
    maps\mp\_utility::_ID35777();
    var_1 = spawnstruct();
    var_1.player = self;
    var_1.hardpointtype = var_0;
    domissioncallback( "playerHardpoint", var_1 );
}

roundbegin()
{
    domissioncallback( "roundBegin" );
}

_ID26772( var_0 )
{
    var_1 = spawnstruct();

    if ( level._ID32653 )
    {
        var_2 = "allies";

        for ( var_3 = 0; var_3 < level._ID23663[var_2].size; var_3++ )
        {
            var_1.player = level._ID23663[var_2][var_3];
            var_1.winner = var_2 == var_0;
            var_1._ID23652 = var_3;
            domissioncallback( "roundEnd", var_1 );
        }

        var_2 = "axis";

        for ( var_3 = 0; var_3 < level._ID23663[var_2].size; var_3++ )
        {
            var_1.player = level._ID23663[var_2][var_3];
            var_1.winner = var_2 == var_0;
            var_1._ID23652 = var_3;
            domissioncallback( "roundEnd", var_1 );
        }

        return;
    }

    for ( var_3 = 0; var_3 < level._ID23663["all"].size; var_3++ )
    {
        var_1.player = level._ID23663["all"][var_3];
        var_1.winner = isdefined( var_0 ) && isplayer( var_0 ) && var_1.player == var_0;
        var_1._ID23652 = var_3;
        domissioncallback( "roundEnd", var_1 );
    }

    return;
}

domissioncallback( var_0, var_1 )
{
    if ( !_ID20774() )
        return;

    if ( isdefined( var_1 ) )
    {
        var_2 = var_1.player;

        if ( !isdefined( var_2 ) )
            var_2 = var_1.attacker;

        if ( isdefined( var_2 ) && isai( var_2 ) )
            return;
    }

    if ( getdvarint( "disable_challenges" ) > 0 )
        return;

    if ( !isdefined( level._ID21229[var_0] ) )
        return;

    if ( isdefined( var_1 ) )
    {
        for ( var_3 = 0; var_3 < level._ID21229[var_0].size; var_3++ )
            thread [[ level._ID21229[var_0][var_3] ]]( var_1 );

        return;
    }

    for ( var_3 = 0; var_3 < level._ID21229[var_0].size; var_3++ )
        thread [[ level._ID21229[var_0][var_3] ]]();

    return;
}

_ID21444()
{
    level endon( "game_ended" );
    self endon( "spawned_player" );
    self endon( "death" );
    self endon( "disconnect" );
    self._ID31105 = 0;

    for (;;)
    {
        self waittill( "sprint_begin" );
        thread _ID21446();

        if ( maps\mp\_utility::_hasperk( "specialty_marathon" ) )
        {
            monitorsinglesprintdistance();
            var_0 = int( self._ID31105 / 120 );
            self._ID31105 = self._ID31105 - var_0 * 120;
            _ID25038( "ch_longersprint_pro", var_0 );
        }
    }
}

monitorsinglesprintdistance()
{
    level endon( "game_ended" );
    self endon( "spawned_player" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "sprint_end" );
    self endon( "heli_sniper_enter" );
    var_0 = self.origin;

    for (;;)
    {
        wait 0.1;
        var_1 = distance( self.origin, var_0 );
        self._ID31105 = self._ID31105 + clamp( var_1, 0, 40 );
        var_0 = self.origin;
    }
}

_ID21446()
{
    level endon( "game_ended" );
    self endon( "spawned_player" );
    self endon( "death" );
    self endon( "disconnect" );
    var_0 = gettime();
    self waittill( "sprint_end" );
    var_1 = int( gettime() - var_0 );
    maps\mp\_utility::_ID17531( "sprinttime", var_1 );
    self._ID19617 = gettime();
}

_ID21383()
{
    self endon( "disconnect" );
    self.pers["midairStreak"] = 0;

    for (;;)
    {
        if ( !isalive( self ) )
        {
            self waittill( "spawned_player" );
            continue;
        }

        if ( !self isonground() )
        {
            self.pers["midairStreak"] = 0;
            var_0 = self.origin[2];

            while ( !self isonground() && isalive( self ) )
            {
                if ( self.origin[2] > var_0 )
                    var_0 = self.origin[2];

                wait 0.05;
            }

            self.pers["midairStreak"] = 0;
            var_1 = var_0 - self.origin[2];

            if ( var_1 < 0 )
                var_1 = 0;

            if ( var_1 / 12.0 > 15 && isalive( self ) )
                _ID25038( "ch_basejump" );

            if ( var_1 / 12.0 > 30 && !isalive( self ) )
                _ID25038( "ch_goodbye" );
        }

        wait 0.05;
    }
}

lastmansd()
{
    if ( !_ID20774() )
        return;

    if ( !self._ID35903 )
        return;

    if ( self._ID32664 > 0 )
        return;

    _ID25038( "ch_lastmanstanding" );
}

_ID21364()
{
    self endon( "disconnect" );

    for (;;)
    {
        var_0 = common_scripts\utility::_ID35635( "bomb_planted", "bomb_defused" );

        if ( !isdefined( var_0 ) )
            continue;

        if ( var_0 == "bomb_planted" )
        {
            _ID25038( "ch_saboteur" );
            continue;
        }

        if ( var_0 == "bomb_defused" )
            _ID25038( "ch_hero" );
    }
}

monitorlivetime()
{
    for (;;)
    {
        self waittill( "spawned_player" );
        thread _ID32119();
    }
}

_ID32119()
{
    self endon( "death" );
    self endon( "disconnect" );
    wait 300;

    if ( isdefined( self ) )
    {
        _ID25038( "ch_survivalist" );
        return;
    }
}

_ID21450()
{
    self endon( "disconnect" );
    self.pers["airstrikeStreak"] = 0;
    self.pers["meleeKillStreak"] = 0;
    self.pers["shieldKillStreak"] = 0;
    thread monitormisc();

    for (;;)
    {
        self waittill( "death" );
        self.pers["airstrikeStreak"] = 0;
        self.pers["meleeKillStreak"] = 0;
        self.pers["shieldKillStreak"] = 0;
    }
}

monitormisc()
{
    thread _ID21420( "destroyed_equipment" );
    thread _ID21420( "begin_airstrike" );
    thread _ID21420( "destroyed_car" );
    thread _ID21420( "destroyed_helicopter" );
    thread _ID21420( "used_airdrop" );
    thread _ID21420( "used_emp" );
    thread _ID21420( "used_nuke" );
    thread _ID21420( "crushed_enemy" );
    self waittill( "disconnect" );
    self notify( "destroyed_equipment" );
    self notify( "begin_airstrike" );
    self notify( "destroyed_car" );
    self notify( "destroyed_helicopter" );
}

_ID21420( var_0 )
{
    for (;;)
    {
        self waittill( var_0 );

        if ( !isdefined( self ) )
            return;

        _ID21419( var_0 );
    }
}

_ID21419( var_0 )
{
    switch ( var_0 )
    {
        case "begin_airstrike":
            self.pers["airstrikeStreak"] = 0;
            break;
        case "destroyed_equipment":
            if ( self isitemunlocked( "specialty_detectexplosive" ) && maps\mp\_utility::_hasperk( "specialty_detectexplosive" ) )
                _ID25038( "ch_detectexplosives_pro" );

            _ID25038( "ch_backdraft" );
            break;
        case "destroyed_helicopter":
            _ID25038( "ch_flyswatter" );
            break;
        case "destroyed_car":
            _ID25038( "ch_vandalism" );
            break;
        case "crushed_enemy":
            _ID25038( "ch_heads_up" );

            if ( isdefined( self._ID12872 ) )
                _ID25038( "ch_droppincrates" );

            break;
    }
}

_ID16475()
{
    if ( maps\mp\_utility::_ID18363() )
    {
        return;
        return;
    }

    healthregenerated_regularmp();
    return;
}

healthregenerated_regularmp()
{
    if ( !isalive( self ) )
        return;

    if ( !_ID20774() )
        return;

    if ( !maps\mp\_utility::_ID25420() )
        return;

    thread resetbrinkofdeathkillstreakshortly();
    self notify( "healed" );

    if ( isdefined( self._ID19539 ) && self._ID19539 )
    {
        self._ID16478++;

        if ( self._ID16478 >= 5 )
        {
            _ID25038( "ch_invincible" );
            return;
        }

        return;
    }
}

resetbrinkofdeathkillstreakshortly()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "damage" );
    wait 1;
    self.brinkofdeathkillstreak = 0;
}

_ID24537()
{
    if ( maps\mp\_utility::_ID18363() )
    {
        return;
        return;
    }

    _ID24538();
    return;
}

_ID24538()
{
    self.brinkofdeathkillstreak = 0;
    self._ID16478 = 0;
    self.pers["MGStreak"] = 0;
}

_ID24480()
{
    self.brinkofdeathkillstreak = 0;
    self._ID16478 = 0;
    self.pers["MGStreak"] = 0;
}

_ID18553()
{
    if ( isalive( self ) )
    {
        var_0 = self.health / self.maxhealth;
        return var_0 <= level._ID16471;
    }

    return 0;
}

_ID25038( var_0, var_1, var_2 )
{
    if ( maps\mp\_utility::_ID18363() )
    {
        return;
        return;
    }

    _ID25039( var_0, var_1, var_2 );
    return;
}

_ID25039( var_0, var_1, var_2 )
{
    if ( !_ID20774() )
        return;

    if ( level.players.size < 2 )
        return;

    if ( !maps\mp\_utility::_ID25420() )
        return;

    if ( !isplayer( self ) || isai( self ) )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_3 = getchallengestatus( var_0 );

    if ( var_3 == 0 )
        return;

    var_4 = isdefined( level.challengeinfo[var_0]["operation"] );

    if ( var_3 > level.challengeinfo[var_0]["targetval"].size )
    {
        var_5 = var_4 && var_3 == level.challengeinfo[var_0]["targetval"].size + 1;
        var_6 = isdefined( self.operationsmaxed ) && isdefined( self.operationsmaxed[var_0] );

        if ( var_5 && !var_6 )
            var_3 = level.challengeinfo[var_0]["targetval"].size;
        else
            return;
    }

    var_7 = maps\mp\gametypes\_hud_util::_ID6815( var_0 );
    var_8 = level.challengeinfo[var_0]["targetval"][var_3];

    if ( isdefined( var_2 ) && var_2 )
        var_9 = var_1;
    else
        var_9 = var_7 + var_1;

    var_10 = 0;

    if ( var_9 >= var_8 )
    {
        var_11 = 1;
        var_10 = var_9 - var_8;
        var_9 = var_8;
    }
    else
        var_11 = 0;

    if ( var_7 < var_9 )
        maps\mp\gametypes\_hud_util::ch_setprogress( var_0, var_9 );

    if ( var_11 )
    {
        thread _ID15624( var_0, var_3 );
        maps\mp\_matchdata::_ID20245( var_0, var_3 );

        if ( var_4 )
            _ID31872( var_0 );
        else
            storecompletedchallenge( var_0 );

        if ( var_4 )
        {
            if ( !isdefined( level.challengeinfo[var_0]["weapon"] ) || var_3 >= 4 )
                maps\mp\gametypes\_rank::giveunlockpoints( 1, 0 );
        }

        var_3++;
        maps\mp\gametypes\_hud_util::_ID6824( var_0, var_3 );
        self.challengedata[var_0] = var_3;

        if ( var_4 )
        {
            if ( var_3 > level.challengeinfo[var_0]["targetval"].size )
            {
                if ( !isdefined( self.operationsmaxed ) )
                    self.operationsmaxed = [];

                self.operationsmaxed[var_0] = 1;

                if ( isdefined( level.challengeinfo[var_0]["weapon"] ) )
                    maps\mp\gametypes\_hud_util::ch_setprogress( var_0, var_10 );
            }

            if ( !isdefined( level.challengeinfo[var_0]["weapon"] ) )
                maps\mp\gametypes\_hud_util::ch_setprogress( var_0, var_10 );

            var_12 = self getrankedplayerdata( "challengeState", "ch_weekly_2" );
            self setrankedplayerdata( "challengeState", "ch_weekly_2", var_12 + 1 );
        }

        thread maps\mp\gametypes\_hud_message::_ID6858( var_0 );
        return;
    }
}

storecompletedchallenge( var_0 )
{
    if ( !isdefined( self.challengescompleted ) )
        self.challengescompleted = [];

    var_1 = 0;

    foreach ( var_3 in self.challengescompleted )
    {
        if ( var_3 == var_0 )
            var_1 = 1;
    }

    if ( !var_1 )
    {
        self.challengescompleted[self.challengescompleted.size] = var_0;
        return;
    }
}

_ID31872( var_0 )
{
    if ( !isdefined( self._ID22963 ) )
        self._ID22963 = [];

    var_1 = 0;

    foreach ( var_3 in self._ID22963 )
    {
        if ( var_3 == var_0 )
        {
            var_1 = 1;
            break;
        }
    }

    if ( !var_1 )
    {
        self._ID22963[self._ID22963.size] = var_0;
        return;
    }
}

_ID15624( var_0, var_1 )
{
    self endon( "disconnect" );
    wait 0.25;
    var_2 = "challenge";

    if ( _ID18723( var_0 ) )
        var_2 = "operation";

    maps\mp\gametypes\_rank::giverankxp( var_2, level.challengeinfo[var_0]["reward"][var_1], undefined, undefined, var_0 );
}

_ID34517()
{
    self.challengedata = [];
    self endon( "disconnect" );

    if ( !_ID20774() )
        return;

    var_0 = 0;

    foreach ( var_5, var_2 in level.challengeinfo )
    {
        var_0++;

        if ( var_0 % 20 == 0 )
            wait 0.05;

        self.challengedata[var_5] = 0;
        var_3 = var_2["index"];
        var_4 = maps\mp\gametypes\_hud_util::ch_getstate( var_5 );

        if ( var_4 == 0 )
        {
            maps\mp\gametypes\_hud_util::_ID6824( var_5, 1 );
            var_4 = 1;
        }

        self.challengedata[var_5] = var_4;
    }

    _ID37215();
}

_ID18662( var_0 )
{
    return tablelookup( "mp/unlockTable.csv", 0, var_0, 0 ) != "";
}

_ID14926( var_0 )
{
    return tablelookup( "mp/allChallengesTable.csv", 0, var_0, 5 );
}

_ID14928( var_0 )
{
    return tablelookup( "mp/challengeTable.csv", 8, var_0, 4 );
}

gettierfromtable( var_0, var_1 )
{
    return tablelookup( var_0, 0, var_1, 1 );
}

isweaponchallenge( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    var_1 = _ID14926( var_0 );

    if ( isdefined( var_1 ) )
    {
        if ( maps\mp\gametypes\_class::_ID18854( var_1, 0 ) || maps\mp\gametypes\_class::isvalidsecondary( var_1, 0 ) )
            return 1;
    }

    return 0;
}

getweaponfromchallenge( var_0 )
{
    return _ID14926( var_0 );
}

isreticlechallenge( var_0 )
{
    var_1 = _ID14926( var_0 );
    return var_1 == "acog" || var_1 == "eotech" || var_1 == "hybrid" || var_1 == "reflex";
}

getsightfromreticlechallenge( var_0 )
{
    return _ID14926( var_0 );
}

getweaponattachmentfromchallenge( var_0 )
{
    var_1 = "ch_";

    if ( issubstr( var_0, "ch_marksman_" ) )
        var_1 = "ch_marksman_";
    else if ( issubstr( var_0, "ch_expert_" ) )
        var_1 = "ch_expert_";
    else if ( issubstr( var_0, "pr_marksman_" ) )
        var_1 = "pr_marksman_";
    else if ( issubstr( var_0, "pr_expert_" ) )
        var_1 = "pr_expert_";

    var_2 = getsubstr( var_0, var_1.size, var_0.size );
    var_3 = strtok( var_2, "_" );
    var_4 = undefined;

    if ( isdefined( var_3[2] ) && maps\mp\_utility::isattachment( var_3[2] ) )
        var_4 = var_3[2];

    return var_4;
}

iskillstreakchallenge( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    var_1 = _ID14926( var_0 );

    if ( isdefined( var_1 ) && ( var_1 == "killstreaks_assault" || var_1 == "killstreaks_support" ) )
        return 1;

    return 0;
}

getkillstreakfromchallenge( var_0 )
{
    var_1 = "ch_";
    var_2 = getsubstr( var_0, var_1.size, var_0.size );

    if ( var_2 == "assault_streaks" || var_2 == "support_streaks" )
        var_2 = undefined;

    return var_2;
}

_ID18723( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    var_1 = _ID14926( var_0 );

    if ( isdefined( var_1 ) )
    {
        if ( var_1 == "perk_slot_0" || var_1 == "perk_slot_1" || var_1 == "perk_slot_2" || var_1 == "proficiency" || var_1 == "equipment" || var_1 == "special_equipment" || var_1 == "attachment" || var_1 == "prestige" || var_1 == "final_killcam" || var_1 == "basic" || var_1 == "humiliation" || var_1 == "precision" || var_1 == "revenge" || var_1 == "elite" || var_1 == "intimidation" || var_1 == "operations" || maps\mp\_utility::_ID18801( var_1, "killstreaks_" ) )
            return 1;
    }

    if ( isweaponchallenge( var_0 ) )
        return 1;

    return 0;
}

_ID6851( var_0, var_1, var_2 )
{
    var_3 = tablelookup( var_0, 0, var_1, 9 + ( var_2 - 1 ) * 2 );
    return int( var_3 );
}

challenge_rewardval( var_0, var_1, var_2 )
{
    var_3 = tablelookup( var_0, 0, var_1, 10 + ( var_2 - 1 ) * 2 );
    return int( var_3 );
}

challenge_sprewardval( var_0, var_1, var_2 )
{
    var_3 = tablelookup( var_0, 0, var_1, 27 + var_2 - 1 );
    return int( var_3 );
}

buildchallengetableinfo( var_0, var_1 )
{
    var_2 = 0;
    var_3 = 0;
    var_4 = tablelookupbyrow( var_0, 0, 0 );

    for ( var_2 = 1; var_4 != ""; var_2++ )
    {
        level.challengeinfo[var_4] = [];
        level.challengeinfo[var_4]["index"] = var_2 - 1;
        level.challengeinfo[var_4]["type"] = var_1;
        level.challengeinfo[var_4]["targetval"] = [];
        level.challengeinfo[var_4]["reward"] = [];

        if ( isreticlechallenge( var_4 ) )
        {
            var_5 = getsightfromreticlechallenge( var_4 );

            if ( isdefined( var_5 ) )
                level.challengeinfo[var_4]["sight"] = var_5;
        }
        else if ( _ID18723( var_4 ) )
        {
            level.challengeinfo[var_4]["operation"] = 1;
            level.challengeinfo[var_4]["spReward"] = [];

            if ( iskillstreakchallenge( var_4 ) )
            {
                var_6 = getkillstreakfromchallenge( var_4 );

                if ( isdefined( var_6 ) )
                    level.challengeinfo[var_4]["killstreak"] = var_6;
            }

            if ( isweaponchallenge( var_4 ) )
            {
                var_7 = getweaponfromchallenge( var_4 );

                if ( isdefined( var_7 ) )
                    level.challengeinfo[var_4]["weapon"] = var_7;
            }
        }

        for ( var_8 = 1; var_8 < 11; var_8++ )
        {
            var_9 = _ID6851( var_0, var_4, var_8 );
            var_10 = challenge_rewardval( var_0, var_4, var_8 );

            if ( var_9 == 0 )
                break;

            level.challengeinfo[var_4]["targetval"][var_8] = var_9;
            level.challengeinfo[var_4]["reward"][var_8] = var_10;

            if ( isdefined( level.challengeinfo[var_4]["spReward"] ) )
            {
                var_11 = challenge_sprewardval( var_0, var_4, var_8 );
                level.challengeinfo[var_4]["spReward"][var_8] = var_11;
            }

            var_3 += var_10;
        }

        var_4 = tablelookupbyrow( var_0, var_2, 0 );
    }

    return int( var_3 );
}

_ID6231()
{
    level.challengeinfo = [];
    var_0 = 0;
    var_0 += buildchallengetableinfo( "mp/allChallengesTable.csv", 0 );
}

monitorprocesschallenge()
{
    self endon( "disconnect" );
    level endon( "game_end" );

    for (;;)
    {
        if ( !_ID20774() )
            return;

        self waittill( "process",  var_0  );
        _ID25038( var_0 );
    }
}

_ID21407()
{
    self endon( "disconnect" );
    level endon( "game_end" );

    for (;;)
    {
        self waittill( "got_killstreak",  var_0  );

        if ( !isdefined( var_0 ) )
            continue;

        switch ( var_0 )
        {
            case 3:
                maps\mp\killstreaks\_killstreaks::_ID15579( "3streak" );
                break;
            case 4:
                maps\mp\killstreaks\_killstreaks::_ID15579( "4streak" );
                break;
            case 5:
                maps\mp\killstreaks\_killstreaks::_ID15579( "5streak" );
                break;
            case 6:
                maps\mp\killstreaks\_killstreaks::_ID15579( "6streak" );
                break;
            case 7:
                maps\mp\killstreaks\_killstreaks::_ID15579( "7streak" );
                break;
            case 8:
                maps\mp\killstreaks\_killstreaks::_ID15579( "8streak" );
                break;
            case 9:
                maps\mp\killstreaks\_killstreaks::_ID15579( "9streak" );
                break;
            case 10:
                maps\mp\killstreaks\_killstreaks::_ID15579( "10streak" );
                break;
            default:
                break;
        }

        if ( var_0 == 10 && self.killstreaks.size == 0 )
        {
            _ID25038( "ch_theloner" );
            continue;
        }

        if ( var_0 == 9 )
        {
            if ( isdefined( self.killstreaks[7] ) && isdefined( self.killstreaks[8] ) && isdefined( self.killstreaks[9] ) )
                _ID25038( "ch_6fears7" );
        }
    }
}

_ID21405()
{
    self endon( "disconnect" );
    level endon( "game_end" );

    for (;;)
    {
        self waittill( "destroyed_killstreak",  var_0  );

        if ( self isitemunlocked( "specialty_blindeye" ) && maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
            _ID25038( "ch_blindeye_pro" );
    }
}

_ID14249( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "hijacker_airdrop":
            _ID25038( "ch_smoothcriminal" );
            break;
        case "hijacker_airdrop_mega":
            _ID25038( "ch_poolshark" );
            break;
        case "wargasm":
            _ID25038( "ch_wargasm" );
            break;
        case "weapon_assault":
            _ID25038( "ch_surgical_assault" );
            break;
        case "weapon_smg":
            _ID25038( "ch_surgical_smg" );
            break;
        case "weapon_lmg":
            _ID25038( "ch_surgical_lmg" );
            break;
        case "weapon_dmr":
            _ID25038( "ch_surgical_dmr" );
            break;
        case "weapon_sniper":
            _ID25038( "ch_surgical_sniper" );
            break;
        case "weapon_shotgun":
            _ID25038( "ch_surgical_shotgun" );
            break;
        case "shield_damage":
            if ( !maps\mp\_utility::_ID18666() )
                _ID25038( "ch_iw6_riotshield_damage", var_1 );

            break;
        case "shield_bullet_hits":
            if ( !maps\mp\_utility::_ID18666() )
                _ID25038( "ch_shield_bullet", var_1 );

            break;
        case "shield_explosive_hits":
            if ( !maps\mp\_utility::_ID18666() )
                _ID25038( "ch_iw6_riotshield_explosive", var_1 );

            break;
    }
}

_ID24496()
{
    var_0 = self getweaponslistprimaries();

    foreach ( var_2 in var_0 )
    {
        if ( self getweaponammoclip( var_2 ) )
        {
            if ( !maps\mp\gametypes\_weapons::_ID18766( var_2 ) && !maps\mp\gametypes\_weapons::isknifeonly( var_2 ) )
                return 1;
        }

        var_3 = weaponaltweaponname( var_2 );

        if ( !isdefined( var_3 ) || var_3 == "none" )
            continue;

        if ( self getweaponammoclip( var_3 ) )
            return 1;
    }

    return 0;
}

_ID21357()
{
    self endon( "disconnect" );
    self.adstime = 0.0;

    for (;;)
    {
        if ( self playerads() == 1 )
            self.adstime = self.adstime + 0.05;
        else
            self.adstime = 0.0;

        wait 0.05;
    }
}

_ID21403()
{
    self endon( "disconnect" );
    self._ID17051 = 0;

    for (;;)
    {
        self waittill( "hold_breath" );
        self._ID17051 = 1;
        self waittill( "release_breath" );
        self._ID17051 = 0;
    }
}

_ID21415()
{
    self endon( "disconnect" );
    self._ID20618 = 0;

    for (;;)
    {
        self waittill( "jumped" );
        var_0 = self getcurrentweapon();
        common_scripts\utility::waittill_notify_or_timeout( "weapon_change", 1 );
        var_1 = self getcurrentweapon();

        if ( var_1 == "none" )
            self._ID20618 = 1;
        else
            self._ID20618 = 0;

        if ( self._ID20618 )
        {
            if ( self isitemunlocked( "specialty_fastmantle" ) && maps\mp\_utility::_hasperk( "specialty_fastmantle" ) )
                _ID25038( "ch_fastmantle" );

            common_scripts\utility::waittill_notify_or_timeout( "weapon_change", 1 );
            var_1 = self getcurrentweapon();

            if ( var_1 == var_0 )
                self._ID20618 = 0;
        }
    }
}

_ID21466()
{
    self endon( "disconnect" );
    var_0 = self getcurrentweapon();

    for (;;)
    {
        self waittill( "weapon_change",  var_1  );

        if ( var_1 == "none" )
            continue;

        if ( var_1 == var_0 )
            continue;

        if ( maps\mp\_utility::_ID18679( var_1 ) )
            continue;

        if ( var_1 == "briefcase_bomb_mp" || var_1 == "briefcase_bomb_defuse_mp" )
            continue;

        var_2 = weaponinventorytype( var_1 );

        if ( var_2 != "primary" )
            continue;

        self.lastprimaryweaponswaptime = gettime();
    }
}

_ID21389()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "flashbang",  var_0, var_1, var_2, var_3  );

        if ( self == var_3 )
            continue;

        self.lastflashedtime = gettime();
    }
}

monitorconcussion()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "concussed",  var_0  );

        if ( self == var_0 )
            continue;

        self._ID19536 = gettime();
    }
}

_ID21417()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "triggeredExpl",  var_0  );
        thread _ID35539();
    }
}

_ID35539()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait(level._ID9515 + 2);
    _ID25038( "ch_delaymine" );
}

monitorreload()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "reload" );

        if ( self issprinting() )
            self._ID31107 = gettime() + 3000;

        var_0 = self getcurrentweapon();
        self._ID19602 = var_0;

        switch ( weaponclass( var_0 ) )
        {
            case "sniper":
                self.reloadtimestamp = gettime() + 5000;
                break;
            default:
                self.reloadtimestamp = gettime() + 3000;
                break;
        }

        self.killsthismag[var_0] = 0;
    }
}

monitorsprintslide()
{
    self endon( "disconnect" );

    for (;;)
    {
        var_0 = common_scripts\utility::_ID35635( "sprint_slide_begin", "sprint_slide_end", "death" );

        if ( !isalive( self ) )
        {
            self.issliding = undefined;
            self.isslidinggraceperiod = gettime() - 1;
            continue;
        }

        if ( var_0 == "sprint_slide_end" )
        {
            self.issliding = undefined;
            self.isslidinggraceperiod = gettime() + 1000;
            continue;
        }

        if ( var_0 == "sprint_slide_begin" )
            self.issliding = 1;
    }
}

playerissprintsliding()
{
    return isdefined( self.issliding ) || isdefined( self.isslidinggraceperiod ) && gettime() <= self.isslidinggraceperiod;
}

_ID37805()
{
    return isdefined( self.issliding ) || isdefined( self.isslidinggraceperiod ) && gettime() <= self.isslidinggraceperiod + 1000;
}

_ID29884( var_0 )
{
    return self isitemunlocked( var_0 ) && maps\mp\_utility::_hasperk( var_0 );
}

processweaponattachmentchallenge( var_0, var_1 )
{
    _ID25038( "ch_" + var_1 );
}

processfinalkillchallenges( var_0, var_1 )
{
    if ( !_ID20774() || isai( var_0 ) )
        return;

    var_0 _ID25038( "ch_theedge" );

    if ( !isai( var_1 ) )
        var_1 _ID25038( "ch_starryeyed" );

    if ( isdefined( var_0._ID21280["revenge"] ) )
        var_0 _ID25038( "ch_moneyshot" );

    if ( isdefined( var_1 ) && isdefined( var_1.explosiveinfo ) && isdefined( var_1.explosiveinfo["stickKill"] ) && var_1.explosiveinfo["stickKill"] )
        var_0 _ID25038( "ch_stickman" );

    if ( isdefined( var_1.attackerdata[var_0._ID15851] ) && isdefined( var_1.attackerdata[var_0._ID15851]._ID30258 ) && isdefined( var_1.attackerdata[var_0._ID15851].weapon ) && issubstr( var_1.attackerdata[var_0._ID15851]._ID30258, "MOD_MELEE" ) && maps\mp\gametypes\_weapons::_ID18766( var_1.attackerdata[var_0._ID15851].weapon ) )
        var_0 _ID25038( "ch_owned" );

    var_2 = var_0.team;

    if ( !level._ID32653 )
        var_2 = "none";

    switch ( level.finalkillcam_sweapon[var_2] )
    {
        case "sentry_minigun_mp":
            var_0 _ID25038( "ch_absentee" );
            break;
        case "remote_tank_projectile_mp":
            var_0 _ID25038( "ch_gryphonattack" );
            break;
        case "heli_pilot_turret_mp":
            var_0 _ID25038( "ch_hotshot" );
            break;
        case "iw6_gm6helisnipe_mp_gm6scope":
            var_0 _ID25038( "ch_heli_sniper_finalkill" );
            break;
        case "drone_hive_projectile_mp":
        case "switch_blade_child_mp":
            var_0 _ID25038( "ch_noescape" );
            break;
        case "ball_drone_gun_mp":
            var_0 _ID25038( "ch_thanksbuddy" );
            break;
        case "odin_projectile_large_rod_mp":
        case "odin_projectile_small_rod_mp":
            var_0 _ID25038( "ch_lokikiller" );
            break;
        case "cobra_20mm_mp":
        case "hind_bomb_mp":
        case "hind_missile_mp":
            var_0 _ID25038( "ch_og" );
            break;
        case "guard_dog_mp":
            var_0 _ID25038( "ch_bestinshow" );
            break;
        case "ims_projectile_mp":
            var_0 _ID25038( "ch_outsmarted" );
            break;
        case "mortar_shelljugg_mp":
        case "iw6_minigunjugg_mp":
        case "iw6_p226jugg_mp":
            var_0 _ID25038( "ch_painless" );
            break;
        case "throwingknifejugg_mp":
        case "iw6_knifeonlyjugg_mp":
            var_0 _ID25038( "ch_untouchable" );
            break;
        case "agent_support_mp":
            var_0 _ID25038( "ch_bestmates" );
            break;
        default:
            break;
    }
}

processweaponattachmentchallenge_acog( var_0, var_1, var_2 )
{
    if ( maps\mp\_utility::isplayerads() )
    {
        _ID25038( "ch_" + var_1 );

        if ( self getstance() == "prone" )
            _ID25038( "ch_" + var_1 + "_prone" );

        checkchallengekillmodifier( var_2, "longshot", var_1 );
        checkchallengekillmodifier( var_2, "headshot", var_1 );

        if ( self.recentkillcount == 2 )
            _ID25038( "ch_" + var_1 + "_double" );

        if ( isdefined( var_2._ID21280["oneshotkill"] ) )
        {
            _ID25038( "ch_acog_oneshot" );
            return;
        }

        return;
    }
}

processweaponattachmentchallenge_eotech( var_0, var_1, var_2 )
{
    if ( maps\mp\_utility::isplayerads() )
    {
        _ID25038( "ch_" + var_1 );

        if ( maps\mp\_utility::weaponisfiretypeburst( var_2._ID32157 ) )
            _ID25038( "ch_" + var_1 + "_burst" );

        if ( self isleaning() )
            _ID25038( "ch_" + var_1 + "_lean" );

        checkchallengekillmodifier( var_2, "headshot", var_1 );

        if ( self.recentkillcount == 2 )
            _ID25038( "ch_" + var_1 + "_double" );

        checkconsecutivechallenge( var_2._ID32157, var_1 );
        return;
    }
}

processweaponattachmentchallenge_hybrid( var_0, var_1, var_2 )
{
    if ( maps\mp\_utility::isplayerads() )
    {
        _ID25038( "ch_" + var_1 );

        if ( var_2.hybridscopestate )
        {
            _ID25038( "ch_hybrid_zoomout" );
            checkchallengekillmodifier( var_2, "headshot", var_1 );
        }
        else
        {
            _ID25038( "ch_hybrid_zoomin" );
            checkchallengekillmodifier( var_2, "longshot", var_1 );
        }

        checkpenetrationchallenge( var_2._ID35229, var_1 );
        return;
    }
}

processweaponattachmentchallenge_reflex( var_0, var_1, var_2 )
{
    if ( maps\mp\_utility::isplayerads() )
    {
        _ID25038( "ch_" + var_1 );

        if ( self getstance() == "crouch" )
            _ID25038( "ch_" + var_1 + "_crouch" );

        var_3 = self getvelocity();

        if ( lengthsquared( var_3 ) > 16 )
            _ID25038( "ch_reflex_moving" );

        if ( maps\mp\_utility::weaponhasattachment( var_2._ID32157, "ammoslug" ) )
            _ID25038( "ch_" + var_1 + "_ammoslug" );

        checkchallengekillmodifier( var_2, "headshot", var_1 );

        if ( maps\mp\_utility::_ID18801( var_2._ID32157, "alt_" ) && maps\mp\_utility::weaponhasattachment( var_2._ID32157, "shotgun" ) )
        {
            _ID25038( "ch_" + var_1 + "_altshotgun" );
            return;
        }

        return;
    }
}

processweaponclasschallenge_ar( var_0, var_1 )
{
    _ID25038( "ch_" + var_0 );

    if ( self getstance() == "crouch" )
        _ID25038( "ch_" + var_0 + "_crouch" );

    checkchallengekillmodifier( var_1, "defender", var_0 );

    if ( maps\mp\_utility::weapongetnumattachments( var_1._ID32157 ) == 0 )
        _ID25038( "ch_" + var_0 + "_noattach" );

    checkchallengekillmodifier( var_1, "longshot", var_0 );
    checkconsecutivechallenge( var_1._ID32157, var_0 );
    checkchallengekillmodifier( var_1, "pointblank", var_0 );

    if ( hasreloadedrecently() )
        _ID25038( "ch_" + var_0 + "_reload" );

    if ( _ID37805() )
        _ID25038( "ch_" + var_0 + "_sliding" );

    checkchallengeisleaning( var_0 );
}

processweaponclasschallenge_smg( var_0, var_1 )
{
    _ID25038( "ch_" + var_0 );

    if ( self getstance() == "crouch" )
        _ID25038( "ch_" + var_0 + "_crouch" );

    checkchallengekillmodifier( var_1, "defender", var_0 );

    if ( maps\mp\_utility::weapongetnumattachments( var_1._ID32157 ) == 0 )
        _ID25038( "ch_" + var_0 + "_noattach" );

    if ( !maps\mp\_utility::isplayerads() )
        _ID25038( "ch_" + var_0 + "_hipfire" );

    checkconsecutivechallenge( var_1._ID32157, var_0 );
    checkchallengekillmodifier( var_1, "pointblank", var_0 );

    if ( hasreloadedrecently() )
        _ID25038( "ch_" + var_0 + "_reload" );

    if ( _ID37805() )
        _ID25038( "ch_" + var_0 + "_sliding" );

    checkchallengeisleaning( var_0 );
}

processweaponclasschallenge_lmg( var_0, var_1 )
{
    _ID25038( "ch_" + var_0 );

    if ( self getstance() == "crouch" )
        _ID25038( "ch_" + var_0 + "_crouch" );

    checkchallengekillmodifier( var_1, "defender", var_0 );

    if ( maps\mp\_utility::weapongetnumattachments( var_1._ID32157 ) == 0 )
        _ID25038( "ch_" + var_0 + "_noattach" );

    if ( !maps\mp\_utility::isplayerads() )
        _ID25038( "ch_" + var_0 + "_hipfire" );

    checkconsecutivechallenge( var_1._ID32157, var_0 );
    checkchallengekillmodifier( var_1, "pointblank", var_0 );
    checkpenetrationchallenge( var_1._ID35229, var_0 );

    if ( _ID37805() )
        _ID25038( "ch_" + var_0 + "_sliding" );

    if ( var_1._ID30258 == "MOD_HEAD_SHOT" && checkcostumechallenge( var_1._ID35229, "mp_body_elite_pmc_lmg_b" ) )
        _ID25038( "ch_ghostbusted" );

    checkchallengeisleaning( var_0 );
}

processweaponclasschallenge_dmr( var_0, var_1 )
{
    _ID25038( "ch_" + var_0 );

    if ( self getstance() == "crouch" )
        _ID25038( "ch_" + var_0 + "_crouch" );

    checkchallengekillmodifier( var_1, "defender", var_0 );
    checkchallengekillmodifier( var_1, "longshot", var_0 );
    checkchallengekillmodifier( var_1, "headshot", var_0 );
    checkchallengekillmodifier( var_1, "pointblank", var_0 );
    checkconsecutivechallenge( var_1._ID32157, var_0 );

    if ( maps\mp\_utility::weapongetnumattachments( var_1._ID32157 ) == 0 )
        _ID25038( "ch_" + var_0 + "_noattach" );

    if ( hasreloadedrecently() )
        _ID25038( "ch_" + var_0 + "_reload" );

    checkchallengeisleaning( var_0 );
}

processweaponclasschallenge_sniper( var_0, var_1 )
{
    _ID25038( "ch_sniper_kill" );
    _ID25038( "ch_" + var_0 );

    if ( self getstance() == "crouch" )
        _ID25038( "ch_" + var_0 + "_crouch" );

    if ( maps\mp\_utility::weapongetnumattachments( var_1._ID32157 ) == 0 )
        _ID25038( "ch_" + var_0 + "_noattach" );

    checkchallengekillmodifier( var_1, "defender", var_0 );

    if ( self getstance() == "prone" )
        _ID25038( "ch_" + var_0 + "_prone" );

    checkchallengekillmodifier( var_1, "oneshotkill", var_0 );
    checkconsecutivechallenge( var_1._ID32157, var_0 );
    checkchallengekillmodifier( var_1, "pointblank", var_0 );

    if ( hasreloadedrecently() )
        _ID25038( "ch_" + var_0 + "_reload" );

    checkpenetrationchallenge( var_1._ID35229, var_0 );
    checkchallengeisleaning( var_0 );
}

processweaponclasschallenge_shotgun( var_0, var_1 )
{
    _ID25038( "ch_" + var_0 );

    if ( self getstance() == "crouch" )
        _ID25038( "ch_" + var_0 + "_crouch" );

    checkchallengekillmodifier( var_1, "defender", var_0 );

    if ( maps\mp\_utility::weapongetnumattachments( var_1._ID32157 ) == 0 )
        _ID25038( "ch_" + var_0 + "_noattach" );

    if ( !maps\mp\_utility::isplayerads() )
        _ID25038( "ch_" + var_0 + "_hipfire" );

    checkconsecutivechallenge( var_1._ID32157, var_0 );
    checkchallengekillmodifier( var_1, "pointblank", var_0 );

    if ( hasreloadedrecently() )
        _ID25038( "ch_" + var_0 + "_reload" );

    if ( _ID37805() )
        _ID25038( "ch_" + var_0 + "_sliding" );

    checkchallengekillmodifier( var_1, "headshot", var_0 );
}

processweaponclasschallenge_riotshield( var_0, var_1 )
{
    _ID25038( "ch_" + var_0 );

    if ( self getstance() == "crouch" )
        _ID25038( "ch_" + var_0 + "_crouch" );

    if ( checknumusesofpersistentdata( "shieldKillStreak", 3 ) )
        _ID25038( "ch_" + var_0 + "_consecutive" );

    if ( hasnoperks() )
    {
        _ID25038( "ch_" + var_0 + "_noperks" );
        return;
    }
}

checkchallengekillmodifier( var_0, var_1, var_2 )
{
    if ( isdefined( var_0._ID21280[var_1] ) )
    {
        _ID25038( "ch_" + var_2 + "_" + var_1 );
        return;
    }
}

checkchallengeisleaning( var_0 )
{
    if ( self isleaning() )
    {
        _ID25038( "ch_" + var_0 + "_leaning" );
        return;
    }
}

checkpenetrationchallenge( var_0, var_1 )
{
    if ( var_0.idflags & level.idflags_penetration )
    {
        _ID25038( "ch_" + var_1 + "_penetrate" );
        return;
    }
}

checkconsecutivechallenge( var_0, var_1 )
{
    var_2 = self.killsthislifeperweapon[var_0];

    if ( isdefined( var_2 ) && isnumbermultipleof( var_2, 3 ) )
    {
        _ID25038( "ch_" + var_1 + "_consecutive" );
        return;
    }
}

checkwaslastweaponriotshield()
{
    var_0 = self getcurrentweapon();

    if ( maps\mp\gametypes\_weapons::_ID18766( var_0 ) )
    {
        return 1;
        return;
    }

    var_1 = common_scripts\utility::_ID15114();
    return maps\mp\gametypes\_weapons::_ID18766( var_1 );
    return;
}

checkaachallenges( var_0, var_1, var_2 )
{
    if ( isdefined( var_2 ) )
    {
        if ( isdefined( level.odinsettings ) && isdefined( level.odinsettings["odin_assault"] ) && ( var_2 == level.odinsettings["odin_assault"].weapon["large_rod"]._ID25056 || var_2 == level.odinsettings["odin_assault"].weapon["small_rod"]._ID25056 ) )
        {
            var_0 _ID25038( "ch_shooting_star" );
            return 1;
        }
        else if ( maps\mp\_utility::_ID36268( var_2 ) == "iw6_maaws_mp" )
            var_0 _ID25038( "ch_aa_launcher" );
        else if ( var_2 == "aamissile_projectile_mp" )
            var_0 _ID25038( "ch_air_superiority" );
    }

    var_0 _ID25038( "ch_clearskies" );
    return 0;
}

checkchallengeextradeadly( var_0 )
{
    if ( _ID29884( "specialty_extra_deadly" ) )
    {
        if ( var_0 == self._ID20130 )
        {
            _ID25038( "ch_extra_deadly" );
            return;
        }

        return;
    }
}

checkcostumechallenge( var_0, var_1 )
{
    if ( !isai( var_0 ) )
    {
        var_2 = var_0 maps\mp\gametypes\_teams::getplayermodelindex();
        var_3 = var_0 maps\mp\gametypes\_teams::getplayermodelname( var_2 );
        return var_3 == var_1;
    }

    return 0;
}

hasreloadedrecently()
{
    return isdefined( self.reloadtimestamp ) && gettime() < self.reloadtimestamp;
}

processchallengeforteam( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        if ( var_3.team == var_1 )
            var_3 _ID25038( var_0 );
    }
}

allowkillchallengeforkillstreak( var_0, var_1 )
{
    if ( var_0 maps\mp\_utility::_ID18666() )
        return 1;
    else if ( var_1 == "ims_projectile_mp" )
        return 1;

    return 0;
}

checknumusesofpersistentdata( var_0, var_1 )
{
    var_2 = self.pers[var_0];
    return isnumbermultipleof( var_2, var_1 );
}

isnumbermultipleof( var_0, var_1 )
{
    return var_0 > 0 && var_0 % var_1 == 0;
}

hasnoperks()
{
    if ( isdefined( self.pers["loadoutPerks"] ) )
        return self.pers["loadoutPerks"].size == 0;

    return 1;
}

_ID37216( var_0 )
{
    var_1 = level.challengeinfo[var_0]["targetval"].size;
    var_2 = maps\mp\gametypes\_hud_util::ch_getstate( var_0 );

    if ( var_2 > var_1 + 1 )
    {
        maps\mp\gametypes\_hud_util::_ID6824( var_0, var_1 );
        maps\mp\gametypes\_hud_util::ch_setprogress( var_0, 0 );
        return;
    }
}

_ID37215()
{
    _ID37216( "ch_atm" );
    _ID37216( "ch_breakbank" );
}
