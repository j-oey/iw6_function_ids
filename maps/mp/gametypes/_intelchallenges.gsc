// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID15587( var_0 )
{
    thread deathwatcher();
    var_1 = tablelookuprownum( "mp/intelChallenges.csv", 0, var_0 );
    self setclientomnvar( "ui_intel_active_index", var_1 );

    switch ( var_0 )
    {
        case "ch_intel_headshots":
            thread intelheadshotchallenge( var_0 );
            break;
        case "ch_intel_kills":
            thread _ID18056( var_0 );
            break;
        case "ch_intel_knifekill":
            thread intelknifekillchallenge( var_0 );
            break;
        case "ch_intel_explosivekill":
            thread _ID18044( var_0 );
            break;
        case "ch_intel_crouchkills":
            thread intelcrouchkillschallenge( var_0 );
            break;
        case "ch_intel_pronekills":
            thread _ID18059( var_0 );
            break;
        case "ch_intel_backshots":
            thread _ID18043( var_0 );
            break;
        case "ch_intel_jumpshot":
            thread _ID18055( var_0 );
            break;
        case "ch_intel_secondarykills":
            thread _ID18060( var_0 );
            break;
        case "ch_intel_foundshot":
            thread intelfoundshotkillschallenge( var_0 );
            break;
        case "ch_intel_tbag":
            thread _ID18063( var_0 );
            break;
    }

    endswitch( 12 )  case "ch_intel_explosivekill" loc_4B case "ch_intel_secondarykills" loc_87 case "ch_intel_tbag" loc_9F case "ch_intel_foundshot" loc_93 case "ch_intel_jumpshot" loc_7B case "ch_intel_backshots" loc_6F case "ch_intel_pronekills" loc_63 case "ch_intel_crouchkills" loc_57 case "ch_intel_knifekill" loc_3F case "ch_intel_kills" loc_33 case "ch_intel_headshots" loc_27 default loc_AB
}

_ID15634( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "ch_team_intel_melee":
            level thread intelteammelee( var_0, var_1 );
            break;
        case "ch_team_intel_headshot":
            level thread _ID18065( var_0, var_1 );
            break;
        case "ch_team_intel_killstreak":
            level thread _ID18066( var_0, var_1 );
            break;
        case "ch_team_intel_equipment":
            level thread _ID18064( var_0, var_1 );
            break;
    }

    endswitch( 5 )  case "ch_team_intel_equipment" loc_138 case "ch_team_intel_killstreak" loc_12A case "ch_team_intel_headshot" loc_11C case "ch_team_intel_melee" loc_10E default loc_146
}

intelteammelee( var_0, var_1 )
{
    level endon( "game_ended" );
    level endon( "giveTeamIntel" );
    level endon( "teamIntelFail" );
    level.nummeleekillsintel = 0;
    var_2 = level._ID18045[var_0].challengetarget;
    var_3 = tablelookuprownum( "mp/intelChallenges.csv", 0, var_0 );
    level thread _ID32662( var_0, var_1, var_3, var_2 );

    while ( level.nummeleekillsintel < var_2 )
    {
        level waittill( "enemy_death" );
        _ID37975( var_2 - level.nummeleekillsintel );
    }

    _ID32661( var_0, var_1 );
    level thread intelteamreward( var_1 );
}

_ID37975( var_0 )
{
    level.updateintelprogress = int( max( var_0, 0 ) );
    _ID34622( level.updateintelprogress );
}

_ID34622( var_0 )
{
    level.currentteamintelprogress = var_0;

    foreach ( var_2 in level.players )
        var_2 playerupdateteamintelprogress();
}

playerupdateteamintelprogress()
{
    self setclientomnvar( "ui_intel_progress_current", level.currentteamintelprogress );
}

playerupdateintelprogress( var_0 )
{
    self setclientomnvar( "ui_intel_progress_current", var_0 );
}

_ID18065( var_0, var_1 )
{
    level endon( "game_ended" );
    level endon( "giveTeamIntel" );
    level endon( "teamIntelFail" );
    level.numheadshotsintel = 0;
    var_2 = level._ID18045[var_0].challengetarget;
    var_3 = tablelookuprownum( "mp/intelChallenges.csv", 0, var_0 );
    level thread _ID32662( var_0, var_1, var_3, var_2 );

    while ( level.numheadshotsintel < var_2 )
    {
        level waittill( "enemy_death" );
        _ID37975( var_2 - level.numheadshotsintel );
    }

    _ID32661( var_0, var_1 );
    level thread intelteamreward( var_1 );
}

_ID18066( var_0, var_1 )
{
    level endon( "game_ended" );
    level endon( "giveTeamIntel" );
    level endon( "teamIntelFail" );
    level.numkillstreakkillsintel = 0;
    var_2 = level._ID18045[var_0].challengetarget;
    var_3 = tablelookuprownum( "mp/intelChallenges.csv", 0, var_0 );
    level thread _ID32662( var_0, var_1, var_3, var_2 );

    while ( level.numkillstreakkillsintel < var_2 )
    {
        level waittill( "enemy_death" );
        _ID37975( var_2 - level.numkillstreakkillsintel );
    }

    _ID32661( var_0, var_1 );
    level thread intelteamreward( var_1 );
}

_ID18064( var_0, var_1 )
{
    level endon( "game_ended" );
    level endon( "giveTeamIntel" );
    level endon( "teamIntelFail" );
    level.numequipmentkillsintel = 0;
    var_2 = level._ID18045[var_0].challengetarget;
    var_3 = tablelookuprownum( "mp/intelChallenges.csv", 0, var_0 );
    level thread _ID32662( var_0, var_1, var_3, var_2 );

    while ( level.numequipmentkillsintel < var_2 )
    {
        level waittill( "enemy_death" );
        _ID37975( var_2 - level.numequipmentkillsintel );
    }

    _ID32661( var_0, var_1 );
    level thread intelteamreward( var_1 );
}

_ID32662( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );
    level endon( "giveTeamIntel" );
    level endon( "teamIntelFail" );
    level endon( "teamIntelComplete" );
    level._ID18819 = 0;
    level._ID8707 = var_0;
    level.currentteamintelprogress = var_3;

    foreach ( var_5 in level.players )
        var_5 playerteamintelstarthud( var_0, var_1, var_2, var_3 );

    for (;;)
    {
        level waittill( "player_spawned",  var_5  );
        var_5 playerteamintelstarthud( var_0, var_1, var_2, var_3 );
    }
}

playerteamintelstarthud( var_0, var_1, var_2, var_3 )
{
    if ( self.team != var_1 )
        return;

    self setclientomnvar( "ui_intel_active_index", var_2 );
    playerupdateteamintelprogress();

    if ( maps\mp\_utility::_ID18757( self ) )
    {
        thread maps\mp\gametypes\_hud_message::_ID31052( var_0 + "_received" );
        return;
    }
}

_ID32661( var_0, var_1 )
{
    level notify( "teamIntelComplete" );

    foreach ( var_3 in level.players )
    {
        if ( var_3.team != var_1 )
            continue;

        var_3 setclientomnvar( "ui_intel_active_index", -1 );
        var_3 setclientomnvar( "ui_intel_progress_current", -1 );

        if ( maps\mp\_utility::_ID18757( var_3 ) )
            var_3 thread maps\mp\gametypes\_hud_message::_ID31052( var_0 );
    }
}

intelteamreward( var_0 )
{
    level endon( "game_ended" );
    level notify( "intelTeamReward" );

    foreach ( var_2 in level.players )
    {
        if ( var_2.team != var_0 )
            continue;

        if ( !maps\mp\_utility::_ID18757( var_2 ) )
            continue;

        var_2 thread intelteamrewardplayer();
    }

    level._ID18819 = 1;
}

intelteamrewardplayerwaittillcomplete( var_0 )
{
    level endon( "intelTeamReward" );

    while ( var_0 )
    {
        wait 1.0;
        maps\mp\gametypes\_hostmigration::_ID35770();

        if ( ( !isdefined( self._ID18582 ) || self._ID18582 == 0 ) && !isdefined( self._ID34183 ) )
            var_0 = max( 0, var_0 - 1.0 );

        if ( var_0 == 8 )
            childthread _ID13318();
    }
}

intelteamrewardplayer()
{
    level endon( "game_ended" );
    var_0 = self;
    var_0 maps\mp\_utility::_ID15611( "specialty_explosivebullets", 0 );
    var_0 setclientomnvar( "ui_horde_update_explosive", 1 );
    var_0 maps\mp\_utility::_giveweapon( level.intelminigun );
    var_0 givestartammo( level.intelminigun );

    if ( var_0 common_scripts\utility::_ID18870() && var_0 common_scripts\utility::_ID18834() && !var_0 maps\mp\_utility::_ID18837() && !var_0 maps\mp\killstreaks\_killstreaks::_ID18836() )
        var_0 switchtoweaponimmediate( level.intelminigun );

    var_0 intelteamrewardplayerwaittillcomplete( 60 );
    var_0 maps\mp\_utility::_unsetperk( "specialty_explosivebullets" );
    var_0 setclientomnvar( "ui_horde_update_explosive", 0 );
    var_1 = var_0 getcurrentprimaryweapon();
    var_0 takeweapon( level.intelminigun );

    if ( var_1 == level.intelminigun )
    {
        var_2 = var_0 maps\mp\killstreaks\_killstreaks::_ID15018();
        var_0 switchtoweaponimmediate( var_2 );
        return;
    }
}

_ID13318()
{
    self endon( "death" );
    self endon( "disconnect" );
    self setclientomnvar( "ui_horde_update_explosive", 1 );
    wait 8;
    self setclientomnvar( "ui_horde_update_explosive", 0 );
}

_ID18061()
{

}

deathwatcher()
{
    self endon( "disconnect" );
    self endon( "intel_cleanup" );
    self waittill( "death" );
    self setclientomnvar( "ui_intel_active_index", -1 );
    thread maps\mp\gametypes\_hud_message::_ID31053( "ch_intel_failed" );
}

intelheadshotchallenge( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = 0;
    var_2 = level._ID18045[var_0].challengetarget;
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received", var_2 );
    playerupdateintelprogress( var_2 );

    while ( var_1 < var_2 )
    {
        self waittill( "got_a_kill",  var_3, var_4, var_5  );

        if ( maps\mp\_utility::_ID18679( var_4 ) )
            continue;

        if ( var_5 == "MOD_HEAD_SHOT" )
        {
            var_1++;
            var_6 = var_2 - var_1;
            playerupdateintelprogress( var_6 );
        }
    }

    maps\mp\gametypes\_intel::_ID4597( var_0 );
}

_ID18056( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = 0;
    var_2 = level._ID18045[var_0].challengetarget;
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received", var_2 );
    playerupdateintelprogress( var_2 );

    while ( var_1 < var_2 )
    {
        self waittill( "got_a_kill",  var_3, var_4  );

        if ( maps\mp\_utility::_ID18679( var_4 ) )
            continue;

        var_1++;
        var_5 = var_2 - var_1;
        playerupdateintelprogress( var_5 );
    }

    maps\mp\gametypes\_intel::_ID4597( var_0 );
}

intelcrouchkillschallenge( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = 0;
    var_2 = level._ID18045[var_0].challengetarget;
    playerupdateintelprogress( var_2 );
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received", var_2 );

    while ( var_1 < var_2 )
    {
        self waittill( "got_a_kill",  var_3, var_4  );

        if ( self getstance() == "crouch" )
        {
            if ( maps\mp\_utility::_ID18679( var_4 ) )
                continue;

            var_1++;
            var_5 = var_2 - var_1;
            playerupdateintelprogress( var_5 );
        }
    }

    maps\mp\gametypes\_intel::_ID4597( var_0 );
}

intelfoundshotkillschallenge( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = 0;
    var_2 = level._ID18045[var_0].challengetarget;
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received", var_2 );
    playerupdateintelprogress( var_2 );

    while ( var_1 < var_2 )
    {
        self waittill( "got_a_kill",  var_3, var_4, var_5  );

        if ( var_5 == "MOD_MELEE" && !maps\mp\gametypes\_weapons::isknifeonly( var_4 ) && !maps\mp\gametypes\_weapons::_ID18766( var_4 ) )
            continue;

        if ( maps\mp\gametypes\_weapons::isoffhandweapon( var_4 ) || maps\mp\_utility::_ID18679( var_4 ) || maps\mp\_utility::_ID18615( var_4 ) )
            continue;

        var_4 = maps\mp\_utility::_ID36268( var_4 );

        if ( var_4 != self.pers["primaryWeapon"] && var_4 != self.pers["secondaryWeapon"] )
        {
            var_1++;
            var_6 = var_2 - var_1;
            playerupdateintelprogress( var_6 );
        }
    }

    maps\mp\gametypes\_intel::_ID4597( var_0 );
}

_ID18060( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = 0;
    var_2 = level._ID18045[var_0].challengetarget;
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received", var_2 );
    playerupdateintelprogress( var_2 );

    while ( var_1 < var_2 )
    {
        self waittill( "got_a_kill",  var_3, var_4, var_5  );
        var_4 = maps\mp\_utility::_ID36268( var_4 );

        if ( maps\mp\_utility::_ID18576( var_4 ) )
        {
            if ( var_5 == "MOD_MELEE" && !issubstr( var_4, "tactical" ) )
                continue;

            var_1++;
            var_6 = var_2 - var_1;
            playerupdateintelprogress( var_6 );
        }
    }

    maps\mp\gametypes\_intel::_ID4597( var_0 );
}

_ID18043( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = 0;
    var_2 = level._ID18045[var_0].challengetarget;
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received", var_2 );
    playerupdateintelprogress( var_2 );

    while ( var_1 < var_2 )
    {
        self waittill( "got_a_kill",  var_3, var_4, var_5  );

        if ( maps\mp\_utility::_ID18679( var_4 ) )
            continue;

        var_6 = var_3._ID3366[1];
        var_7 = self._ID3367[1];
        var_8 = angleclamp180( var_6 - var_7 );

        if ( abs( var_8 ) < 65 )
        {
            var_1++;
            var_9 = var_2 - var_1;
            playerupdateintelprogress( var_9 );
        }
    }

    maps\mp\gametypes\_intel::_ID4597( var_0 );
}

_ID18055( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = 0;
    var_2 = int( level._ID18045[var_0].challengetarget );
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received", var_2 );
    playerupdateintelprogress( var_2 );

    while ( var_1 < var_2 )
    {
        self waittill( "got_a_kill",  var_3, var_4, var_5  );

        if ( maps\mp\_utility::_ID18679( var_4 ) )
            continue;

        if ( !self isonground() )
        {
            var_1++;
            var_6 = var_2 - var_1;
            playerupdateintelprogress( var_6 );
        }
    }

    maps\mp\gametypes\_intel::_ID4597( var_0 );
}

intelknifekillchallenge( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = 0;
    var_2 = level._ID18045[var_0].challengetarget;
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received", var_2 );
    playerupdateintelprogress( var_2 );

    while ( var_1 < var_2 )
    {
        self waittill( "got_a_kill",  var_3, var_4, var_5  );

        if ( var_5 == "MOD_MELEE" )
        {
            var_1++;
            var_6 = var_2 - var_1;
            playerupdateintelprogress( var_6 );
        }
    }

    maps\mp\gametypes\_intel::_ID4597( var_0 );
}

_ID18044( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = 0;
    var_2 = level._ID18045[var_0].challengetarget;
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received", var_2 );
    playerupdateintelprogress( var_2 );

    while ( var_1 < var_2 )
    {
        self waittill( "got_a_kill",  var_3, var_4, var_5  );

        if ( maps\mp\_utility::_ID18679( var_4 ) )
            continue;

        if ( var_4 == "throwingknife_mp" )
            continue;

        if ( isexplosivedamagemod( var_5 ) || var_5 == "MOD_IMPACT" )
        {
            var_1++;
            var_6 = var_2 - var_1;
            playerupdateintelprogress( var_6 );
        }
    }

    maps\mp\gametypes\_intel::_ID4597( var_0 );
}

_ID18059( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = 0;
    var_2 = int( level._ID18045[var_0].challengetarget );
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received", var_2 );
    playerupdateintelprogress( var_2 );

    while ( var_1 < var_2 )
    {
        self waittill( "got_a_kill",  var_3, var_4, var_5  );

        if ( maps\mp\_utility::_ID18679( var_4 ) )
            continue;

        if ( self getstance() == "prone" )
        {
            var_1++;
            var_6 = var_2 - var_1;
            playerupdateintelprogress( var_6 );
        }
    }

    maps\mp\gametypes\_intel::_ID4597( var_0 );
}

_ID18063( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = level._ID18045[var_0].challengetarget;
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received" );

    for (;;)
    {
        self waittill( "got_a_kill",  var_2, var_3, var_4  );

        if ( maps\mp\_utility::_ID18679( var_3 ) )
            continue;

        thread _ID36079( var_2.origin, var_0 );
    }
}

_ID36079( var_0, var_1 )
{
    self notify( "watchForTbag" );
    self endon( "watchForTbag" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "intel_cleanup" );
    var_2 = 0;
    self notifyonplayercommand( "Tbag_adjustedStance", "+stance" );
    self notifyonplayercommand( "Tbag_adjustedStance", "+goStand" );

    if ( !level.console && !isai( self ) )
    {
        self notifyonplayercommand( "Tbag_adjustedStance", "+togglecrouch" );
        self notifyonplayercommand( "Tbag_adjustedStance", "+movedown" );
    }

    for (;;)
    {
        while ( self getstance() != "stand" )
            wait 0.05;

        self waittill( "Tbag_adjustedStance" );

        while ( self getstance() != "crouch" )
            wait 0.05;

        if ( distance2d( self.origin, var_0 ) < 128 )
        {
            self waittill( "Tbag_adjustedStance" );

            while ( self getstance() != "stand" )
                wait 0.05;

            if ( distance2d( self.origin, var_0 ) < 128 )
                var_2++;
        }

        if ( var_2 )
        {
            thread maps\mp\gametypes\_intel::_ID4597( var_1 );
            return;
        }
    }
}

givejuggernautchallenge( var_0 )
{
    thread deathwatcher();
    var_1 = tablelookuprownum( "mp/intelChallenges.csv", 0, var_0 );
    self setclientomnvar( "ui_intel_active_index", var_1 );

    switch ( var_0 )
    {
        case "ch_intel_jugg_maniac_knife":
            thread inteljuggmaniacknifechallenge( var_0 );
            break;
        case "ch_intel_jugg_maniac_throwingknife":
            thread inteljuggmaniacthrowingknifechallenge( var_0 );
            break;
        case "ch_intel_jugg_maniac_backknife":
            thread inteljuggmaniacbackknifechallenge( var_0 );
            break;
        case "ch_intel_jugg_assault_kills":
            thread inteljuggassaultkillschallenge( var_0 );
            break;
        case "ch_intel_jugg_recon_shieldkills":
            thread inteljuggreconshieldkillschallenge( var_0 );
            break;
        case "ch_intel_jugg_recon_pistolkills":
            thread inteljuggreconpistolkillschallenge( var_0 );
            break;
    }

    endswitch( 7 )  case "ch_intel_jugg_recon_pistolkills" loc_E1D case "ch_intel_jugg_recon_shieldkills" loc_E11 case "ch_intel_jugg_assault_kills" loc_E05 case "ch_intel_jugg_maniac_backknife" loc_DF9 case "ch_intel_jugg_maniac_throwingknife" loc_DED case "ch_intel_jugg_maniac_knife" loc_DE1 default loc_E29
}

inteljuggassaultkillschallenge( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = 0;
    var_2 = int( level._ID18045[var_0].challengetarget );
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received", var_2 );
    playerupdateintelprogress( var_2 );

    while ( var_1 < var_2 )
    {
        self waittill( "got_a_kill",  var_3, var_4, var_5  );

        if ( maps\mp\_utility::_ID18671( var_4 ) )
        {
            var_1++;
            var_6 = var_2 - var_1;
            playerupdateintelprogress( var_6 );
        }
    }

    maps\mp\gametypes\_intel::_ID4597( var_0 );
}

inteljuggmaniacknifechallenge( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = 0;
    var_2 = int( level._ID18045[var_0].challengetarget );
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received", var_2 );
    playerupdateintelprogress( var_2 );

    while ( var_1 < var_2 )
    {
        self waittill( "got_a_kill",  var_3, var_4, var_5  );

        if ( var_4 == "iw6_knifeonlyjugg_mp" )
        {
            var_1++;
            var_6 = var_2 - var_1;
            playerupdateintelprogress( var_6 );
        }
    }

    maps\mp\gametypes\_intel::_ID4597( var_0 );
}

inteljuggmaniacthrowingknifechallenge( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = 0;
    var_2 = int( level._ID18045[var_0].challengetarget );
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received", var_2 );
    playerupdateintelprogress( var_2 );

    while ( var_1 < var_2 )
    {
        self waittill( "got_a_kill",  var_3, var_4, var_5  );

        if ( var_4 == "throwingknifejugg_mp" )
        {
            var_1++;
            var_6 = var_2 - var_1;
            playerupdateintelprogress( var_6 );
        }
    }

    maps\mp\gametypes\_intel::_ID4597( var_0 );
}

inteljuggmaniacbackknifechallenge( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = 0;
    var_2 = level._ID18045[var_0].challengetarget;
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received", var_2 );
    playerupdateintelprogress( var_2 );

    while ( var_1 < var_2 )
    {
        self waittill( "got_a_kill",  var_3, var_4, var_5  );

        if ( maps\mp\_utility::_ID18671( var_4 ) )
        {
            var_6 = var_3._ID3366[1];
            var_7 = self._ID3367[1];
            var_8 = angleclamp180( var_6 - var_7 );

            if ( abs( var_8 ) < 90 )
            {
                var_1++;
                var_9 = var_2 - var_1;
                playerupdateintelprogress( var_9 );
            }
        }
    }

    maps\mp\gametypes\_intel::_ID4597( var_0 );
}

inteljuggreconshieldkillschallenge( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = 0;
    var_2 = int( level._ID18045[var_0].challengetarget );
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received", var_2 );
    playerupdateintelprogress( var_2 );

    while ( var_1 < var_2 )
    {
        self waittill( "got_a_kill",  var_3, var_4, var_5  );

        if ( var_4 == "iw6_riotshieldjugg_mp" )
        {
            var_1++;
            var_6 = var_2 - var_1;
            playerupdateintelprogress( var_6 );
        }
    }

    maps\mp\gametypes\_intel::_ID4597( var_0 );
}

inteljuggreconpistolkillschallenge( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "intel_cleanup" );
    var_1 = 0;
    var_2 = int( level._ID18045[var_0].challengetarget );
    thread maps\mp\gametypes\_hud_message::_ID31053( var_0 + "_received", var_2 );
    playerupdateintelprogress( var_2 );

    while ( var_1 < var_2 )
    {
        self waittill( "got_a_kill",  var_3, var_4, var_5  );

        if ( var_4 == "iw6_magnumjugg_mp" && var_5 != "MOD_MELEE" )
        {
            var_1++;
            var_6 = var_2 - var_1;
            playerupdateintelprogress( var_6 );
        }
    }

    maps\mp\gametypes\_intel::_ID4597( var_0 );
}
