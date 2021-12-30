// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID28809()
{

}

_ID34353()
{

}

_ID28711()
{

}

_ID34331()
{

}

_ID28647()
{
    if ( !isplayer( self ) )
        return;

    autospotadswatcher();
    autospotdeathwatcher();
}

autospotdeathwatcher()
{
    self waittill( "death" );
    self endon( "disconnect" );
    self endon( "endAutoSpotAdsWatcher" );
    level endon( "game_ended" );
    self autospotoverlayoff();
}

_ID34308()
{
    if ( !isplayer( self ) )
        return;

    self notify( "endAutoSpotAdsWatcher" );
    self autospotoverlayoff();
}

autospotadswatcher()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "endAutoSpotAdsWatcher" );
    level endon( "game_ended" );
    var_0 = 0;

    for (;;)
    {
        wait 0.05;

        if ( self isusingturret() )
        {
            self autospotoverlayoff();
            continue;
        }

        var_1 = self playerads();

        if ( var_1 < 1 && var_0 )
        {
            var_0 = 0;
            self autospotoverlayoff();
        }

        if ( var_1 < 1 && !var_0 )
            continue;

        if ( var_1 == 1 && !var_0 )
        {
            var_0 = 1;
            self autospotoverlayon();
        }
    }
}

_ID28852()
{

}

_ID34362()
{

}

timeoutregenfaster()
{
    self.hasregenfaster = undefined;
    maps\mp\_utility::_unsetperk( "specialty_regenfaster" );
    self setclientdvar( "ui_regen_faster_end_milliseconds", 0 );
    self notify( "timeOutRegenFaster" );
}

sethardshell()
{
    self._ID29695 = 0.25;
}

_ID34340()
{
    self._ID29695 = 0;
}

_ID28865()
{
    thread _ID37704();
}

_ID37704()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "stop_monitorSharpFocus" );

    if ( !isdefined( level._ID38046 ) )
    {
        level._ID38046 = [];
        level._ID38046["iw6_gm6_mp"] = 1;
        level._ID38046["iw6_l115a3_mp"] = 1;
        level._ID38046["iw6_usr_mp"] = 1;
        level._ID38046["iw6_vks_mp"] = 1;
        level._ID38046["iw6_dlcweap03_mp"] = 1;
    }

    var_0 = self getcurrentweapon();

    for (;;)
    {
        var_1 = undefined;

        if ( isdefined( var_0 ) && var_0 != "none" )
            var_1 = getweaponbasename( var_0 );

        if ( isdefined( var_1 ) && isdefined( level._ID38046[var_1] ) )
            self setviewkickscale( 0.5 );
        else
            self setviewkickscale( 0.25 );

        self waittill( "weapon_change",  var_0  );
    }
}

_ID34368()
{
    self notify( "stop_monitorSharpFocus" );
    self setviewkickscale( 1.0 );
}

_ID28707()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "endDoubleLoad" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "reload" );
        var_0 = self getweaponslist( "primary" );

        foreach ( var_2 in var_0 )
        {
            var_3 = self getweaponammoclip( var_2 );
            var_4 = weaponclipsize( var_2 );
            var_5 = var_4 - var_3;
            var_6 = self getweaponammostock( var_2 );

            if ( var_3 != var_4 && var_6 > 0 )
            {
                if ( var_3 + var_6 >= var_4 )
                {
                    self setweaponammoclip( var_2, var_4 );
                    self setweaponammostock( var_2, var_6 - var_5 );
                    continue;
                }

                self setweaponammoclip( var_2, var_3 + var_6 );

                if ( var_6 - var_5 > 0 )
                {
                    self setweaponammostock( var_2, var_6 - var_5 );
                    continue;
                }

                self setweaponammostock( var_2, 0 );
            }
        }
    }
}

_ID34330()
{
    self notify( "endDoubleLoad" );
}

_ID28777( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 10;
    else
        var_0 = int( var_0 ) * 2;

    maps\mp\_utility::_ID28849( var_0 );
    self._ID25605 = var_0;
}

_ID34351()
{
    maps\mp\_utility::_ID28849( 0 );
    self._ID25605 = 0;
}

_ID28856()
{
    self endon( "unsetRShieldRadar" );
    wait 0.75;
    self makeportableradar();
    thread _ID28857();
}

_ID28857()
{
    self endon( "unsetRShieldRadar" );
    common_scripts\utility::_ID35626( "disconnect", "death" );

    if ( isdefined( self ) )
        _ID34364();
}

_ID34364()
{
    self clearportableradar();
    self notify( "unsetRShieldRadar" );
}

_ID28858()
{
    self makescrambler();
    thread _ID28859();
}

_ID28859()
{
    self endon( "unsetRShieldScrambler" );
    common_scripts\utility::_ID35626( "disconnect", "death" );

    if ( isdefined( self ) )
        _ID34365();
}

_ID34365()
{
    self clearscrambler();
    self notify( "unsetRShieldScrambler" );
}

_ID28888( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 10;

    var_0 = int( var_0 );

    if ( var_0 == 10 )
        self._ID32029 = 0;
    else
        self._ID32029 = var_0 / 10;
}

_ID34373()
{
    self._ID32029 = 1;
}

applystunresistence( var_0 )
{
    if ( isdefined( self._ID32029 ) )
        return self._ID32029 * var_0;
    else
        return var_0;
}

_ID29206()
{
    if ( isagent( self ) )
        return;

    self endon( "unsetWeaponLaser" );
    wait 0.5;
    thread _ID29207();
}

_ID34381()
{
    self notify( "unsetWeaponLaser" );

    if ( isdefined( self._ID23462 ) && self._ID23462 )
        maps\mp\_utility::_ID10177();

    self._ID23462 = undefined;
    self.perkweaponlaseroffforswitchstart = undefined;
}

setweaponlaser_waitforlaserweapon( var_0 )
{
    for (;;)
    {
        var_0 = getweaponbasename( var_0 );

        if ( isdefined( var_0 ) && ( var_0 == "iw6_kac_mp" || var_0 == "iw6_arx160_mp" ) )
            break;

        self waittill( "weapon_change",  var_0  );
    }
}

_ID29207()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "unsetWeaponLaser" );
    self._ID23462 = 0;
    var_0 = self getcurrentweapon();

    for (;;)
    {
        setweaponlaser_waitforlaserweapon( var_0 );

        if ( self._ID23462 == 0 )
        {
            self._ID23462 = 1;
            maps\mp\_utility::enableweaponlaser();
        }

        childthread _ID29208();
        childthread setweaponlaser_monitorweaponswitchstart( 1.0 );
        self.perkweaponlaseroffforswitchstart = undefined;
        self waittill( "weapon_change",  var_0  );

        if ( self._ID23462 == 1 )
        {
            self._ID23462 = 0;
            maps\mp\_utility::_ID10177();
        }
    }
}

setweaponlaser_monitorweaponswitchstart( var_0 )
{
    self endon( "weapon_change" );

    for (;;)
    {
        self waittill( "weapon_switch_started" );
        childthread setweaponlaser_onweaponswitchstart( var_0 );
    }
}

setweaponlaser_onweaponswitchstart( var_0 )
{
    self notify( "setWeaponLaser_onWeaponSwitchStart" );
    self endon( "setWeaponLaser_onWeaponSwitchStart" );

    if ( self._ID23462 == 1 )
    {
        self.perkweaponlaseroffforswitchstart = 1;
        self._ID23462 = 0;
        maps\mp\_utility::_ID10177();
    }

    wait(var_0);
    self.perkweaponlaseroffforswitchstart = undefined;

    if ( self._ID23462 == 0 && self playerads() <= 0.6 )
    {
        self._ID23462 = 1;
        maps\mp\_utility::enableweaponlaser();
    }
}

_ID29208()
{
    self endon( "weapon_change" );

    for (;;)
    {
        if ( !isdefined( self.perkweaponlaseroffforswitchstart ) || self.perkweaponlaseroffforswitchstart == 0 )
        {
            if ( self playerads() > 0.6 )
            {
                if ( self._ID23462 == 1 )
                {
                    self._ID23462 = 0;
                    maps\mp\_utility::_ID10177();
                }
            }
            else if ( self._ID23462 == 0 )
            {
                self._ID23462 = 1;
                maps\mp\_utility::enableweaponlaser();
            }
        }

        common_scripts\utility::_ID35582();
    }
}

_ID28883()
{
    self setaimspreadmovementscale( 0.5 );
}

_ID34370()
{
    self notify( "end_SteadyAimPro" );
    self setaimspreadmovementscale( 1.0 );
}

blastshieldusetracker( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "end_perkUseTracker" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "empty_offhand" );

        if ( !common_scripts\utility::isoffhandweaponenabled() )
            continue;

        self [[ var_1 ]]( maps\mp\_utility::_hasperk( "_specialty_blastshield" ) );
    }
}

_ID23460()
{
    self endon( "disconnect" );
    self waittill( "death" );
    self._useperkenabled = undefined;
}

_ID28848()
{

}

_ID34359()
{
    self notify( "end_perkUseTracker" );
}

_ID28713()
{
    if ( isdefined( self.endgame ) )
        return;

    self.maxhealth = maps\mp\gametypes\_tweakables::_ID15451( "player", "maxhealth" ) * 4;
    self.health = self.maxhealth;
    self.endgame = 1;
    self.attackertable[0] = "";
    self visionsetnakedforplayer( "end_game", 5 );
    thread _ID11607( 7 );
    maps\mp\gametypes\_gamelogic::_ID28745( self, 1 );
}

_ID34332()
{
    self notify( "stopEndGame" );
    self.endgame = undefined;
    maps\mp\_utility::_ID26201( 1 );

    if ( !isdefined( self._ID11613 ) )
        return;

    self._ID11613 maps\mp\gametypes\_hud_util::destroyelem();
    self._ID11609 maps\mp\gametypes\_hud_util::destroyelem();
}

_ID11607( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    level endon( "game_ended" );
    self endon( "stopEndGame" );
    wait(var_0 + 1);
    maps\mp\_utility::_suicide();
}

_ID28671()
{
    if ( !level.hardcoremode )
    {
        self.maxhealth = maps\mp\gametypes\_tweakables::_ID15451( "player", "maxhealth" );

        if ( isdefined( self._ID36475 ) && self._ID36475 == 1 && self.maxhealth > 30 )
            self._ID36475 = 2;
    }
}

_ID34317()
{
    self._ID36475 = 1;
}

_ID28860()
{
    self.objectivescaler = 1.2;
}

_ID34366()
{
    self.objectivescaler = 1;
}

_ID28678()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "unsetCombatSpeed" );
    self._ID17522 = 0;
    _ID34322();

    for (;;)
    {
        self waittill( "damage",  var_0, var_1  );

        if ( !isdefined( var_1.team ) )
            continue;

        if ( level._ID32653 && var_1.team == self.team )
            continue;

        if ( self._ID17522 )
            continue;

        _ID28679();
        self._ID17522 = 1;
        thread endofspeedwatcher();
    }
}

endofspeedwatcher()
{
    self notify( "endOfSpeedWatcher" );
    self endon( "endOfSpeedWatcher" );
    self endon( "death" );
    self endon( "disconnect" );
    self waittill( "healed" );
    _ID34322();
    self._ID17522 = 0;
}

_ID28679()
{
    if ( isdefined( self._ID18666 ) && self._ID18666 )
        return;

    if ( self.weaponspeed <= 0.8 )
        self.combatspeedscalar = 1.4;
    else if ( self.weaponspeed <= 0.9 )
        self.combatspeedscalar = 1.3;
    else
        self.combatspeedscalar = 1.2;

    maps\mp\gametypes\_weapons::_ID34567();
}

_ID34322()
{
    self.combatspeedscalar = 1;
    maps\mp\gametypes\_weapons::_ID34567();
}

_ID34321()
{
    _ID34322();
    self notify( "unsetCombatSpeed" );
}

setlightweight()
{
    if ( !isdefined( self.cranked ) )
    {
        self._ID21667 = maps\mp\_utility::_ID19986();
        maps\mp\gametypes\_weapons::_ID34567();
    }
}

_ID34348()
{
    self._ID21667 = 1;
    maps\mp\gametypes\_weapons::_ID34567();
}

_ID28649()
{
    self._ID19266 = 1.5;
}

_ID34309()
{
    self._ID19266 = 1;
}

_ID28884()
{
    maps\mp\_utility::_ID15611( "specialty_bulletaccuracy", 1 );
    maps\mp\_utility::_ID15611( "specialty_holdbreath", 0 );
}

_ID34371()
{
    maps\mp\_utility::_unsetperk( "specialty_bulletaccuracy" );
    maps\mp\_utility::_unsetperk( "specialty_holdbreath" );
}

setdelaymine()
{

}

_ID34329()
{

}

_ID28774()
{
    if ( !maps\mp\_utility::_ID18610() )
        self makescrambler();
}

_ID34350()
{
    self clearscrambler();
}

setac130()
{
    thread killstreakthink( "ac130", 7, "end_ac130Think" );
}

_ID34306()
{
    self notify( "end_ac130Think" );
}

_ID28864()
{
    thread killstreakthink( "airdrop_sentry_minigun", 2, "end_sentry_minigunThink" );
}

_ID34367()
{
    self notify( "end_sentry_minigunThink" );
}

_ID28894()
{
    thread killstreakthink( "tank", 6, "end_tankThink" );
}

_ID34376()
{
    self notify( "end_tankThink" );
}

_ID28842()
{
    thread killstreakthink( "precision_airstrike", 6, "end_precision_airstrike" );
}

_ID34356()
{
    self notify( "end_precision_airstrike" );
}

_ID28843()
{
    thread killstreakthink( "predator_missile", 4, "end_predator_missileThink" );
}

_ID34357()
{
    self notify( "end_predator_missileThink" );
}

_ID28749()
{
    thread killstreakthink( "helicopter_minigun", 5, "end_helicopter_minigunThink" );
}

_ID34341()
{
    self notify( "end_helicopter_minigunThink" );
}

killstreakthink( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( var_2 );

    for (;;)
    {
        self waittill( "killed_enemy" );

        if ( self.pers["cur_kill_streak"] != var_1 )
            continue;

        thread maps\mp\killstreaks\_killstreaks::_ID15602( var_0 );
        thread maps\mp\gametypes\_hud_message::_ID19270( var_0, var_1 );
        return;
    }
}

_ID28901()
{
    self thermalvisionon();
}

_ID34377()
{
    self thermalvisionoff();
}

_ID28807()
{
    thread onemanarmyweaponchangetracker();
}

_ID34352()
{
    self notify( "stop_oneManArmyTracker" );
}

onemanarmyweaponchangetracker()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "stop_oneManArmyTracker" );

    for (;;)
    {
        self waittill( "weapon_change",  var_0  );

        if ( var_0 != "onemanarmy_mp" )
            continue;

        thread _ID28035();
    }
}

isonemanarmymenu( var_0 )
{
    if ( var_0 == game["menu_onemanarmy"] )
        return 1;

    if ( isdefined( game["menu_onemanarmy_defaults_splitscreen"] ) && var_0 == game["menu_onemanarmy_defaults_splitscreen"] )
        return 1;

    if ( isdefined( game["menu_onemanarmy_custom_splitscreen"] ) && var_0 == game["menu_onemanarmy_custom_splitscreen"] )
        return 1;

    return 0;
}

_ID28035()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    common_scripts\utility::_disableweaponswitch();
    common_scripts\utility::_disableoffhandweapons();
    common_scripts\utility::_disableusability();
    self openpopupmenu( game["menu_onemanarmy"] );
    thread closeomamenuondeath();
    self waittill( "menuresponse",  var_0, var_1  );
    common_scripts\utility::_enableweaponswitch();
    common_scripts\utility::_ID1647();
    common_scripts\utility::_enableusability();

    if ( var_1 == "back" || !isonemanarmymenu( var_0 ) || maps\mp\_utility::_ID18837() )
    {
        if ( self getcurrentweapon() == "onemanarmy_mp" )
        {
            common_scripts\utility::_disableweaponswitch();
            common_scripts\utility::_disableoffhandweapons();
            common_scripts\utility::_disableusability();
            self switchtoweapon( common_scripts\utility::_ID15114() );
            self waittill( "weapon_change" );
            common_scripts\utility::_enableweaponswitch();
            common_scripts\utility::_ID1647();
            common_scripts\utility::_enableusability();
        }

        return;
    }

    thread _ID15609( var_1 );
}

closeomamenuondeath()
{
    self endon( "menuresponse" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "death" );
    common_scripts\utility::_enableweaponswitch();
    common_scripts\utility::_ID1647();
    common_scripts\utility::_enableusability();
}

_ID15609( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( maps\mp\_utility::_hasperk( "specialty_omaquickchange" ) )
    {
        var_1 = 3.0;
        maps\mp\_utility::playplayerandnpcsounds( self, "foly_onemanarmy_bag3_plr", "foly_onemanarmy_bag3_npc" );
    }
    else
    {
        var_1 = 6.0;
        maps\mp\_utility::playplayerandnpcsounds( self, "foly_onemanarmy_bag6_plr", "foly_onemanarmy_bag6_npc" );
    }

    thread _ID22740( var_1 );
    common_scripts\utility::_disableweapon();
    common_scripts\utility::_disableoffhandweapons();
    common_scripts\utility::_disableusability();
    wait(var_1);
    common_scripts\utility::_enableweapon();
    common_scripts\utility::_ID1647();
    common_scripts\utility::_enableusability();
    self._ID22739 = 1;
    maps\mp\gametypes\_class::giveloadout( self.pers["team"], var_0 );

    if ( isdefined( self.carryflag ) )
        self attach( self.carryflag, "J_spine4", 1 );

    self notify( "changed_kit" );
    level notify( "changed_kit" );
}

_ID22740( var_0 )
{
    self endon( "disconnect" );
    var_1 = maps\mp\gametypes\_hud_util::createprimaryprogressbar();
    var_2 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
    var_2 settext( &"MPUI_CHANGING_KIT" );
    var_1 maps\mp\gametypes\_hud_util::_ID34509( 0, 1 / var_0 );

    for ( var_3 = 0; var_3 < var_0 && isalive( self ) && !level.gameended; var_3 += 0.05 )
        wait 0.05;

    var_1 maps\mp\gametypes\_hud_util::destroyelem();
    var_2 maps\mp\gametypes\_hud_util::destroyelem();
}

_ID28651()
{
    self setweaponhudiconoverride( "primaryoffhand", "specialty_blastshield" );
}

_ID34310()
{
    self setweaponhudiconoverride( "primaryoffhand", "none" );
}

_ID28731()
{

}

_ID34336()
{

}

_ID28890()
{
    self setoffhandsecondaryclass( "flash" );
    maps\mp\_utility::_giveweapon( "flare_mp", 0 );
    self givestartammo( "flare_mp" );
    thread _ID21459();
}

_ID34374()
{
    self notify( "end_monitorTIUse" );
}

clearprevioustispawnpoint()
{
    common_scripts\utility::_ID35626( "disconnect", "joined_team", "joined_spectators" );

    if ( isdefined( self.setspawnpoint ) )
        deleteti( self.setspawnpoint );
}

_ID34633()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "end_monitorTIUse" );

    while ( maps\mp\_utility::_ID18757( self ) )
    {
        if ( _ID18860() )
            self._ID33087 = self.origin;

        wait 0.05;
    }
}

_ID18860()
{
    if ( canspawn( self.origin ) && self isonground() )
        return 1;
    else
        return 0;
}

_ID32972( var_0 )
{
    if ( maps\mp\_utility::_ID18757( var_0.owner ) )
        var_0.owner deleteti( self );
}

_ID21459()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "end_monitorTIUse" );
    thread _ID34633();
    thread clearprevioustispawnpoint();

    for (;;)
    {
        self waittill( "grenade_fire",  var_0, var_1  );

        if ( var_1 != "flare_mp" )
            continue;

        if ( isdefined( self.setspawnpoint ) )
            deleteti( self.setspawnpoint );

        if ( !isdefined( self._ID33087 ) )
            continue;

        if ( maps\mp\_utility::_ID33165() )
            continue;

        var_2 = self._ID33087 + ( 0, 0, 16 );
        var_3 = self._ID33087 - ( 0, 0, 2048 );
        var_4 = playerphysicstrace( var_2, var_3 ) + ( 0, 0, 1 );
        var_5 = bullettrace( var_2, var_3, 0 );
        var_6 = spawn( "script_model", var_4 );
        var_6.angles = self.angles;
        var_6.team = self.team;
        var_6.owner = self;
        var_6.enemytrigger = spawn( "script_origin", var_4 );
        var_6 thread _ID15689( self );
        var_6._ID24539 = self._ID33087;
        var_6 setotherent( self );
        var_6 common_scripts\utility::_ID20489( self.team, 1 );
        var_6 thread maps\mp\gametypes\_weapons::createbombsquadmodel( "weapon_light_stick_tactical_bombsquad", "tag_fire_fx", self );
        var_6 maps\mp\gametypes\_weapons::explosivehandlemovers( var_5["entity"] );
        maps\mp\gametypes\_weapons::_ID22908( var_6 );
        self.setspawnpoint = var_6;
        return;
    }
}

_ID15689( var_0 )
{
    self setmodel( level._ID30885["enemy"] );

    if ( level._ID32653 )
        maps\mp\_entityheadicons::_ID28896( self.team, ( 0, 0, 20 ) );
    else
        maps\mp\_entityheadicons::_ID28825( var_0, ( 0, 0, 20 ) );

    thread _ID15684( var_0 );
    thread glowstickenemyuselistener( var_0 );
    thread glowstickuselistener( var_0 );
    thread glowstickwaitforownerdisconnect( var_0 );
    var_1 = spawn( "script_model", self.origin + ( 0, 0, 0 ) );
    var_1.angles = self.angles;
    var_1 setmodel( level._ID30885["friendly"] );
    var_1 setcontents( 0 );
    var_1 linkto( self );
    var_1 playloopsound( "emt_road_flare_burn" );
    thread _ID15690( self, var_1, var_0 );
    self waittill( "death" );
    var_1 stoploopsound();
    var_1 delete();
}

_ID15690( var_0, var_1, var_2 )
{
    var_0 endon( "death" );
    wait 0.05;
    var_3 = [];
    var_3["enemy"] = var_0;
    var_3["friendly"] = var_1;

    for (;;)
    {
        foreach ( var_5 in var_3 )
            var_5 hide();

        foreach ( var_8 in level.players )
        {
            var_9 = "friendly";

            if ( var_2 maps\mp\_utility::isenemy( var_8 ) )
                var_9 = "enemy";

            var_5 = var_3[var_9];
            var_5 show();
            playfxontagforclients( level._ID30884[var_9], var_5, "tag_fire_fx", var_8 );
            common_scripts\utility::_ID35582();
        }

        level waittill( "joined_team" );

        foreach ( var_9, var_5 in var_3 )
            stopfxontag( level._ID30884[var_9], var_5, "tag_fire_fx" );

        common_scripts\utility::_ID35582();
    }
}

deleteondeath( var_0 )
{
    self waittill( "death" );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

_ID15684( var_0 )
{
    maps\mp\gametypes\_damage::_ID21371( 100, "tactical_insertion", ::_ID15687, ::glowstickhandledeathdamage, 1 );
}

_ID15687( var_0, var_1, var_2, var_3 )
{
    return maps\mp\gametypes\_damage::handlemeleedamage( var_1, var_2 );
}

glowstickhandledeathdamage( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self.owner ) && var_0 != self.owner )
    {
        var_0 notify( "destroyed_insertion",  self.owner  );
        var_0 notify( "destroyed_equipment" );
        self.owner thread maps\mp\_utility::_ID19765( "ti_destroyed", undefined, undefined, self.origin );
    }

    var_0 thread deleteti( self );
}

glowstickuselistener( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( &"MP_PATCH_PICKUP_TI" );
    thread updateenemyuse( var_0 );

    for (;;)
    {
        self waittill( "trigger",  var_1  );
        var_1 playsound( "tactical_insert_flare_pu" );

        if ( !var_1 maps\mp\_utility::_ID18666() )
            var_1 thread _ID28890();

        var_1 thread deleteti( self );
    }
}

updateenemyuse( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        maps\mp\_utility::_ID28863( var_0 );
        level common_scripts\utility::_ID35663( "joined_team", "player_spawned" );
    }
}

glowstickwaitforownerdisconnect( var_0 )
{
    self endon( "death" );
    var_0 waittill( "disconnect" );
    thread deleteti( self );
}

deleteti( var_0 )
{
    if ( isdefined( var_0.enemytrigger ) )
        var_0.enemytrigger delete();

    var_1 = var_0.origin;
    var_2 = var_0.angles;
    var_3 = var_0 getlinkedparent();
    var_0 delete();
    var_4 = spawn( "script_model", var_1 );
    var_4.angles = var_2;
    var_4 setmodel( level._ID30885["friendly"] );
    var_4 setcontents( 0 );

    if ( isdefined( var_3 ) )
        var_4 linkto( var_3 );

    thread _ID11150( var_4 );
}

_ID11150( var_0 )
{
    wait 2.5;
    var_0 delete();
}

glowstickenemyuselistener( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    self.enemytrigger setcursorhint( "HINT_NOICON" );
    self.enemytrigger sethintstring( &"MP_PATCH_DESTROY_TI" );
    self.enemytrigger maps\mp\_utility::_ID20499( var_0 );

    for (;;)
    {
        self.enemytrigger waittill( "trigger",  var_1  );
        var_1 notify( "destroyed_insertion",  var_0  );
        var_1 notify( "destroyed_equipment" );

        if ( isdefined( var_0 ) && var_1 != var_0 )
            var_0 thread maps\mp\_utility::_ID19765( "ti_destroyed", undefined, undefined, self.origin );

        var_1 thread deleteti( self );
    }
}

_ID28773()
{
    thread killstreakthink( "littlebird_support", 2, "end_littlebird_support_think" );
}

_ID34349()
{
    self notify( "end_littlebird_support_think" );
}

_ID28814( var_0 )
{
    if ( isplayer( self ) )
    {
        var_1 = 1;

        if ( !maps\mp\_utility::_hasperk( "specialty_incog" ) )
        {
            self._ID23222 = 1;

            if ( level._ID32653 )
            {
                var_2 = maps\mp\_utility::_ID23109( self, "orange", var_0.team, 0, "perk" );
                thread watchpainted( var_2, var_1 );
                thread watchpaintedagain( var_2 );
            }
            else
            {
                var_2 = maps\mp\_utility::_ID23108( self, "orange", var_0, 0, "perk" );
                thread watchpainted( var_2, var_1 );
                thread watchpaintedagain( var_2 );
            }
        }
    }
}

watchpainted( var_0, var_1 )
{
    self notify( "painted_again" );
    self endon( "painted_again" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    common_scripts\utility::_ID35637( var_1, "death" );
    self._ID23222 = 0;
    maps\mp\_utility::_ID23104( var_0, self );
    self notify( "painted_end" );
}

watchpaintedagain( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    common_scripts\utility::_ID35626( "painted_again", "painted_end" );
    maps\mp\_utility::_ID23104( var_0, self );
}

ispainted()
{
    return isdefined( self._ID23222 ) && self._ID23222;
}

_ID28646()
{

}

_ID34307()
{

}

_ID28851()
{
    if ( isdefined( self._ID24968 ) )
        self givemaxammo( self._ID24968 );

    if ( isdefined( self._ID27981 ) )
        self givemaxammo( self._ID27981 );
}

unsetrefillgrenades()
{

}

_ID28850()
{
    if ( isdefined( self._ID24978 ) )
        self givemaxammo( self._ID24978 );

    if ( isdefined( self._ID27984 ) )
        self givemaxammo( self._ID27984 );
}

_ID34360()
{

}

_ID28741()
{
    thread setgunsmithinternal();
}

setgunsmithinternal()
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "unsetGunsmith" );
    self waittill( "giveLoadout" );

    if ( self._ID20133.size == 0 && self._ID20139.size == 0 )
        return;

    for (;;)
    {
        self waittill( "weapon_change",  var_0  );

        if ( var_0 == "none" )
            continue;

        if ( maps\mp\_utility::_ID18679( var_0 ) )
            continue;

        if ( !maps\mp\_utility::_ID18801( var_0, "iw5_" ) && !maps\mp\_utility::_ID18801( var_0, "iw6_" ) )
            continue;

        var_1 = undefined;

        if ( maps\mp\_utility::getweaponclass( var_0 ) == "weapon_pistol" )
        {
            if ( self._ID20139.size > 0 )
                var_1 = self._ID20139;
        }
        else if ( self._ID20133.size > 0 )
            var_1 = self._ID20133;

        if ( !isdefined( var_1 ) )
            continue;

        var_2 = 0;
        var_3 = maps\mp\_utility::_ID15474( var_0 );

        if ( var_3.size == 0 )
            var_2 = 1;
        else
        {
            foreach ( var_5 in var_1 )
            {
                if ( !common_scripts\utility::array_contains( var_3, var_5 ) )
                {
                    var_2 = 1;
                    break;
                }
            }
        }

        if ( !var_2 )
            continue;

        var_7 = [];
        var_8 = maps\mp\_utility::_ID15471( var_0 );

        foreach ( var_5 in var_1 )
        {
            if ( common_scripts\utility::array_contains( var_8, var_5 ) )
                var_7[var_7.size] = var_5;
        }

        var_1 = var_7;
        var_11 = [];

        foreach ( var_13 in var_3 )
        {
            var_14 = 1;

            foreach ( var_16 in var_1 )
            {
                if ( !maps\mp\_utility::attachmentscompatible( var_16, var_13 ) )
                {
                    var_14 = 0;
                    break;
                }
            }

            if ( var_14 )
                var_11[var_11.size] = var_13;
        }

        var_3 = var_11;
        var_19 = var_1.size + var_3.size;

        if ( var_19 > 4 )
            var_3 = common_scripts\utility::array_randomize( var_3 );

        for ( var_20 = 0; var_1.size < 4 && var_20 < var_3.size; var_20++ )
            var_1[var_1.size] = var_3[var_20];

        var_21 = getweaponbasename( var_0 );
        var_22 = var_21;

        foreach ( var_20, var_5 in var_1 )
        {
            var_24 = maps\mp\_utility::attachmentmap_tounique( var_5, var_0 );
            var_1[var_20] = var_24;
        }

        var_1 = common_scripts\utility::alphabetize( var_1 );

        foreach ( var_5 in var_1 )
            var_22 += ( "_" + var_5 );

        if ( var_22 != var_21 )
        {
            var_27 = self getweaponammoclip( var_0 );
            var_28 = self getweaponammostock( var_0 );
            self takeweapon( var_0 );
            self giveweapon( var_22 );
            self setweaponammoclip( var_22, var_27 );
            self setweaponammostock( var_22, var_28 );
            self switchtoweapon( var_22 );
        }
    }
}

_ID34339()
{
    self notify( "unsetGunsmith" );
}

_ID28734()
{
    self setclientomnvar( "ui_gambler_show", -1 );
    setgamblerinternal();
}

setgamblerinternal()
{
    level.abilitymaxval = [];
    var_0 = maps\mp\gametypes\_class::getnumabilitycategories();
    var_1 = maps\mp\gametypes\_class::getnumsubability();
    var_2 = [];
    var_3 = 0;
    var_4 = undefined;

    if ( isai( self ) )
        var_4 = self.pers["loadoutPerks"];

    if ( !isdefined( level._ID23448 ) )
    {
        level._ID23448 = [];
        level._ID23444 = [];
        level._ID23451 = [];

        for ( var_5 = 0; var_5 < var_0; var_5++ )
        {
            for ( var_6 = 0; var_6 < var_1; var_6++ )
            {
                var_7 = tablelookup( "mp/cacAbilityTable.csv", 0, var_5 + 1, 4 + var_6 );
                level._ID23448[var_5][var_6] = var_7;

                for ( var_8 = 0; tablelookupbyrow( "mp/perktable.csv", var_8, 0 ) != ""; var_8++ )
                {
                    if ( var_7 == tablelookupbyrow( "mp/perktable.csv", var_8, 1 ) )
                    {
                        level._ID23444[var_5][var_6] = int( tablelookupbyrow( "mp/perktable.csv", var_8, 10 ) );
                        level._ID23451[var_5][var_6] = var_8;
                        break;
                    }
                }
            }
        }
    }

    var_9 = gamblercommonchecker();
    var_10 = 0;

    if ( level._ID14086 == "infect" )
        var_9 = 0;

    if ( isdefined( self.teamname ) )
        var_10 = getmatchrulesdata( "defaultClasses", self.teamname, self.class_num, "class", "abilitiesPicked", 6, 0 );

    for ( var_5 = 0; var_5 < var_0; var_5++ )
    {
        for ( var_6 = 0; var_6 < var_1; var_6++ )
        {
            var_11 = level._ID23448[var_5][var_6];
            var_12 = perkpickedchecker( var_11, var_5, var_6 );

            if ( var_12 && ( self._ID31894 == "specialist" || !self.perkpickedspecialist ) )
                continue;

            if ( !isdefined( var_11 ) )
                continue;

            if ( var_11 == "" )
                continue;

            if ( var_11 == "specialty_extra_attachment" || var_11 == "specialty_twoprimaries" )
                continue;

            if ( isdefined( var_9 ) && !var_9 && !var_10 )
            {
                if ( var_11 == "specialty_extraammo" || var_11 == "specialty_extra_equipment" || var_11 == "specialty_extra_deadly" )
                    continue;
            }

            if ( self._ID31894 == "support" )
            {
                if ( var_11 == "specialty_hardline" )
                    continue;
            }

            if ( isai( self ) && isdefined( var_4 ) && common_scripts\utility::array_contains( var_4, var_11 ) )
                continue;

            var_13 = level._ID23444[var_5][var_6];
            var_8 = level._ID23451[var_5][var_6];

            switch ( var_13 )
            {
                case 1:
                    var_3 = 150;
                    break;
                case 2:
                    var_3 = 40;
                    break;
                case 3:
                    var_3 = 60;
                    break;
                case 4:
                    var_3 = 20;
                    break;
                case 5:
                    var_3 = 20;
                    break;
                default:
                    break;
            }

            var_2[var_2.size] = spawnstruct();
            var_2[var_2.size - 1]._ID26783 = var_8;
            var_2[var_2.size - 1]._ID17334 = var_11;
            var_2[var_2.size - 1]._ID36301 = var_3;
        }
    }

    self.perkpickedspecialist = undefined;

    if ( var_2.size > 0 )
        thread _ID15595( var_2 );
}

gamblercommonchecker()
{
    if ( !isai( self ) )
        return self getcacplayerdata( "loadouts", self.class_num, "abilitiesPicked", 6, 0 );
    else
    {
        var_0 = [];

        if ( isdefined( self.pers["loadoutPerks"] ) )
            var_0 = common_scripts\utility::array_combine( var_0, self.pers["loadoutPerks"] );

        foreach ( var_2 in var_0 )
        {
            if ( maps\mp\_utility::getbaseperkname( var_2 ) == "specialty_gambler" )
                return 1;
        }
    }

    return 0;
}

perkpickedchecker( var_0, var_1, var_2 )
{
    self.perkpickedspecialist = 0;

    if ( !isdefined( var_0 ) )
        return 0;

    if ( var_0 == "" )
        return 0;

    if ( !isai( self ) )
    {
        var_3 = maps\mp\gametypes\_class::getnumabilitycategories();
        var_4 = maps\mp\gametypes\_class::getnumsubability();

        if ( self getcacplayerdata( "loadouts", self.class_num, "abilitiesPicked", var_1, var_2 ) )
            return 1;

        for ( var_5 = 0; var_5 < 3; var_5++ )
        {
            var_6 = self getcacplayerdata( "loadouts", self.class_num, "specialistStreaks", var_5 );

            if ( isdefined( var_6 ) && var_6 != "none" )
            {
                var_7 = maps\mp\_utility::getbaseperkname( var_6 );

                if ( var_7 == var_0 )
                {
                    self.perkpickedspecialist = 1;
                    return 1;
                }
            }
        }

        var_8 = self getcacplayerdata( "loadouts", self.class_num, "specialistBonusStreaks", var_1, var_2 );

        if ( isdefined( var_8 ) && var_8 )
        {
            var_9 = level._ID23448[var_1][var_2];

            if ( var_9 == var_0 )
            {
                self.perkpickedspecialist = 1;
                return 1;
            }
        }
    }
    else
    {
        var_10 = [];

        if ( isdefined( self.pers["loadoutPerks"] ) )
            var_10 = common_scripts\utility::array_combine( var_10, self.pers["loadoutPerks"] );

        foreach ( var_12 in var_10 )
        {
            if ( maps\mp\_utility::getbaseperkname( var_12 ) == var_0 )
                return 1;
        }

        var_10 = [];

        if ( isdefined( self.pers["specialistStreaks"] ) )
            var_10 = common_scripts\utility::array_combine( var_10, self.pers["specialistStreaks"] );

        if ( isdefined( self.pers["specialistBonusStreaks"] ) )
            var_10 = common_scripts\utility::array_combine( var_10, self.pers["specialistBonusStreaks"] );

        foreach ( var_12 in var_10 )
        {
            if ( maps\mp\_utility::getbaseperkname( var_12 ) == var_0 )
            {
                self.perkpickedspecialist = 1;
                return 1;
            }
        }
    }

    return 0;
}

_ID15595( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "unsetGambler" );
    level endon( "game_ended" );

    if ( !maps\mp\_utility::_ID14065( "prematch_done" ) )
        maps\mp\_utility::gameflagwait( "prematch_done" );
    else if ( maps\mp\_utility::_ID14065( "prematch_done" ) && self._ID31894 != "specialist" )
        self waittill( "giveLoadout" );

    if ( !isdefined( self.abilitychosen ) )
        self.abilitychosen = 0;

    if ( !self.abilitychosen )
    {
        var_1 = getrandomability( var_0 );
        self.gamblerability = var_1;
    }
    else
        var_1 = self.gamblerability;

    maps\mp\_utility::_ID15611( var_1._ID17334, 0 );

    if ( var_1._ID17334 == "specialty_hardline" )
        maps\mp\killstreaks\_killstreaks::setstreakcounttonext();

    if ( showgambler() )
    {
        self playlocalsound( "mp_suitcase_pickup" );
        self setclientomnvar( "ui_gambler_show", var_1._ID26783 );
        thread gambleranimwatcher();
    }

    if ( level._ID14086 != "infect" )
        self.abilitychosen = 1;
}

showgambler()
{
    var_0 = 1;

    if ( !level._ID17628 && self.abilitychosen )
        var_0 = 0;

    if ( !maps\mp\_utility::allowclasschoice() && level._ID14086 != "infect" )
        var_0 = 0;

    return var_0;
}

gambleranimwatcher()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "unsetGambler" );
    level endon( "game_ended" );
    self waittill( "luinotifyserver",  var_0, var_1  );

    if ( var_0 == "gambler_anim_complete" )
        self setclientomnvar( "ui_gambler_show", -1 );
}

getrandomability( var_0 )
{
    var_1 = [];
    var_1 = thread _ID30455( var_0 );
    var_1 = thread _ID28659( var_1 );
    var_2 = randomint( level.abilitymaxval["sum"] );
    var_3 = undefined;

    foreach ( var_5 in var_1 )
    {
        if ( !var_5._ID36301 || var_5._ID17334 == "specialty_gambler" )
            continue;

        if ( var_5._ID36301 > var_2 )
        {
            var_3 = var_5;
            break;
        }
    }

    return var_3;
}

_ID30455( var_0 )
{
    var_1 = [];
    var_2 = [];

    for ( var_3 = 1; var_3 < var_0.size; var_3++ )
    {
        var_4 = var_0[var_3]._ID36301;
        var_1 = var_0[var_3];

        for ( var_5 = var_3 - 1; var_5 >= 0 && _ID18527( var_0[var_5]._ID36301, var_4 ); var_5-- )
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

_ID28659( var_0 )
{
    level.abilitymaxval["sum"] = 0;

    foreach ( var_2 in var_0 )
    {
        if ( !var_2._ID36301 )
            continue;

        level.abilitymaxval["sum"] = level.abilitymaxval["sum"] + var_2._ID36301;
        var_2._ID36301 = level.abilitymaxval["sum"];
    }

    return var_0;
}

_ID34338()
{
    self notify( "unsetGambler" );
}

setcomexp()
{
    var_0 = level.comexpfuncs["giveComExpBenefits"];
    self [[ var_0 ]]();
}

_ID34323()
{
    var_0 = level.comexpfuncs["removeComExpBenefits"];
    self [[ var_0 ]]();
}

_ID28891()
{
    thread _ID28892();
}

_ID28892()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "unsetTagger" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "eyesOn" );
        var_0 = self getplayerssightingme();

        foreach ( var_2 in var_0 )
        {
            if ( level._ID32653 && var_2.team == self.team )
                continue;

            if ( isalive( var_2 ) && var_2.sessionstate == "playing" )
            {
                if ( !isdefined( var_2._ID23449 ) )
                    var_2._ID23449 = 0;

                if ( !var_2._ID23449 )
                    var_2._ID23449 = 1;

                var_2 thread _ID23124( self );
            }
        }
    }
}

_ID23124( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "eyesOff" );
    level endon( "game_ended" );

    for (;;)
    {
        var_1 = 1;
        var_2 = var_0 getplayerssightingme();

        foreach ( var_4 in var_2 )
        {
            if ( var_4 == self )
            {
                var_1 = 0;
                break;
            }
        }

        if ( var_1 )
        {
            self._ID23449 = 0;
            self notify( "eyesOff" );
        }

        wait 0.5;
    }
}

_ID34375()
{
    self notify( "unsetTagger" );
}

_ID28821()
{
    thread _ID28822();
}

_ID28822()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "unsetPitcher" );
    level endon( "game_ended" );
    maps\mp\_utility::_setperk( "specialty_throwback", 0 );
    self setgrenadecookscale( 1.5 );

    for (;;)
    {
        self setgrenadethrowscale( 1.25 );
        self waittill( "grenade_pullback",  var_0  );

        if ( var_0 == "airdrop_marker_mp" || var_0 == "killstreak_uplink_mp" || var_0 == "deployable_vest_marker_mp" || var_0 == "deployable_weapon_crate_marker_mp" || var_0 == "airdrop_juggernaut_mp" )
            self setgrenadethrowscale( 1 );

        self waittill( "grenade_fire",  var_1, var_2  );
    }
}

_ID34355()
{
    self setgrenadecookscale( 1 );
    self setgrenadethrowscale( 1 );
    maps\mp\_utility::_unsetperk( "specialty_throwback" );
    self notify( "unsetPitcher" );
}

_ID28657()
{

}

_ID28658( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "unsetBoom" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    common_scripts\utility::_ID35582();
    triggerportableradarping( self.origin, var_0 );
    var_0 boomtrackplayers( self.origin );
}

boomtrackplayers( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( maps\mp\_utility::isenemy( var_2 ) && isalive( var_2 ) && !var_2 maps\mp\_utility::_hasperk( "specialty_gpsjammer" ) && distancesquared( var_0, var_2.origin ) <= 490000 )
            var_2.markedbyboomperk[maps\mp\_utility::getuniqueid()] = gettime() + 2000;
    }
}

_ID34314()
{
    self notify( "unsetBoom" );
}

_ID28871()
{

}

_ID34369()
{

}

_ID28653()
{
    self.bloodrushregenspeedmod = 1;
    self.bloodrushregenhealthmod = 1;
}

setbloodrushinternal()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "unsetBloodrush" );
    level endon( "game_ended" );

    if ( !isdefined( self._ID18673 ) || !self._ID18673 )
    {
        self.rushtime = 5;
        thread customjuiced( self.rushtime );
        self.bloodrushregenspeedmod = 0.25;
        self.bloodrushregenhealthmod = 5;
        self notify( "bloodrush_active" );
    }

    self waittill( "unset_custom_juiced" );
    _ID34312();
}

customjuiced( var_0 )
{
    self endon( "death" );
    self endon( "faux_spawn" );
    self endon( "disconnect" );
    self endon( "unset_custom_juiced" );
    level endon( "game_ended" );
    self._ID18673 = 1;
    self._ID21667 = 1.1;
    maps\mp\gametypes\_weapons::_ID34567();
    maps\mp\_utility::_ID15611( "specialty_fastreload", 0 );
    maps\mp\_utility::_ID15611( "specialty_quickdraw", 0 );
    maps\mp\_utility::_ID15611( "specialty_stalker", 0 );
    maps\mp\_utility::_ID15611( "specialty_fastoffhand", 0 );
    maps\mp\_utility::_ID15611( "specialty_fastsprintrecovery", 0 );
    maps\mp\_utility::_ID15611( "specialty_quickswap", 0 );
    thread _ID34325();
    thread _ID34327();
    thread _ID34326();
    var_1 = var_0 * 1000 + gettime();

    if ( !isai( self ) )
        self setclientdvar( "ui_juiced_end_milliseconds", var_1 );

    wait(var_0);
    _ID34324();
}

_ID34324( var_0 )
{
    if ( !isdefined( var_0 ) )
    {
        if ( maps\mp\_utility::_ID18666() )
        {
            if ( isdefined( self.juggmovespeedscaler ) )
                self._ID21667 = self.juggmovespeedscaler;
            else
                self._ID21667 = 0.7;
        }
        else
        {
            self._ID21667 = 1;

            if ( maps\mp\_utility::_hasperk( "specialty_lightweight" ) )
                self._ID21667 = maps\mp\_utility::_ID19986();
        }

        maps\mp\gametypes\_weapons::_ID34567();
    }

    maps\mp\_utility::_unsetperk( "specialty_fastreload" );
    maps\mp\_utility::_unsetperk( "specialty_quickdraw" );
    maps\mp\_utility::_unsetperk( "specialty_stalker" );
    maps\mp\_utility::_unsetperk( "specialty_fastoffhand" );
    maps\mp\_utility::_unsetperk( "specialty_fastsprintrecovery" );
    maps\mp\_utility::_unsetperk( "specialty_quickswap" );

    if ( isdefined( self.pers["loadoutPerks"] ) )
        maps\mp\perks\_abilities::_ID15614( self.pers["loadoutPerks"] );

    self._ID18673 = undefined;

    if ( !isai( self ) )
        self setclientdvar( "ui_juiced_end_milliseconds", 0 );

    self notify( "unset_custom_juiced" );
}

_ID34327()
{
    self endon( "disconnect" );
    self endon( "unset_custom_juiced" );

    for (;;)
    {
        wait 0.05;

        if ( maps\mp\_utility::_ID18837() )
        {
            thread _ID34324();
            break;
        }
    }
}

_ID34325()
{
    self endon( "disconnect" );
    self endon( "unset_custom_juiced" );
    common_scripts\utility::_ID35626( "death", "faux_spawn" );
    thread _ID34324( 1 );
}

_ID34326()
{
    self endon( "disconnect" );
    self endon( "unset_custom_juiced" );
    level common_scripts\utility::_ID35626( "round_end_finished", "game_ended" );
    thread _ID34324();
}

regenspeedwatcher()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "unsetBloodrush" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "bloodrush_active" );
        self._ID25671 = self.bloodrushregenspeedmod;
        break;
    }
}

_ID34312()
{
    self.bloodrushregenspeedmod = 1;
    self._ID25671 = 1;
    self notify( "unsetBloodrush" );
}

_ID28904()
{

}

_ID28905()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "unsetTriggerHappy" );
    level endon( "game_ended" );
    var_0 = self._ID19545;
    var_1 = self getweaponammostock( var_0 );
    var_2 = self getweaponammoclip( var_0 );
    self givestartammo( var_0 );
    var_3 = self getweaponammoclip( var_0 );
    var_4 = var_3 - var_2;
    var_5 = var_1 - var_4;

    if ( var_4 > var_1 )
    {
        self setweaponammoclip( var_0, var_2 + var_1 );
        var_5 = 0;
    }

    self setweaponammostock( var_0, var_5 );
    self playlocalsound( "ammo_crate_use" );
    self setclientomnvar( "ui_trigger_happy", 1 );
    wait 0.2;
    self setclientomnvar( "ui_trigger_happy", 0 );
}

_ID34378()
{
    self setclientomnvar( "ui_trigger_happy", 0 );
    self notify( "unsetTriggerHappy" );
}

_ID28690()
{
    self.critchance = 10;
    self.deadeyekillcount = 0;
}

_ID28691()
{
    if ( self.critchance < 50 )
        self.critchance = ( self.deadeyekillcount + 1 ) * 10;
    else
        self.critchance = 50;

    var_0 = randomint( 100 );

    if ( var_0 <= self.critchance )
        maps\mp\_utility::_ID15611( "specialty_moredamage", 0 );
}

_ID34328()
{
    if ( maps\mp\_utility::_hasperk( "specialty_moredamage" ) )
        maps\mp\_utility::_unsetperk( "specialty_moredamage" );
}

_ID28756()
{

}

_ID34342()
{

}

_ID28652()
{

}

_ID34311()
{
    maps\mp\_utility::_unsetperk( "specialty_noplayertarget" );
    self notify( "removed_specialty_noplayertarget" );
}

_ID28844()
{

}

_ID34358()
{
    maps\mp\_utility::_unsetperk( "specialty_fastoffhand" );
}

setextraammo()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "unset_extraammo" );
    level endon( "game_ended" );

    if ( self.gettingloadout )
        self waittill( "giveLoadout" );

    var_0 = maps\mp\_utility::getvalidextraammoweapons();

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && var_2 != "none" )
            self givemaxammo( var_2 );
    }
}

unsetextraammo()
{
    self notify( "unset_extraammo" );
}

setextraequipment()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "unset_extraequipment" );
    level endon( "game_ended" );

    if ( self.gettingloadout )
        self waittill( "giveLoadout" );

    var_0 = self.loadoutperkoffhand;

    if ( isdefined( var_0 ) && var_0 != "specialty_null" )
    {
        if ( var_0 != "specialty_tacticalinsertion" )
            self setweaponammoclip( var_0, 2 );
    }
}

unsetextraequipment()
{
    self notify( "unset_extraequipment" );
}

setextradeadly()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "unset_extradeadly" );
    level endon( "game_ended" );

    if ( self.gettingloadout )
        self waittill( "giveLoadout" );

    var_0 = self._ID20130;

    if ( isdefined( var_0 ) && var_0 != "specialty_null" )
        self setweaponammoclip( var_0, 2 );
}

unsetextradeadly()
{
    self notify( "unset_extradeadly" );
}

_ID28721()
{
    maps\mp\_utility::_ID15611( "specialty_pistoldeath", 0 );
}

_ID34333()
{
    maps\mp\_utility::_unsetperk( "specialty_pistoldeath" );
}

_ID28662()
{
    thread maps\mp\killstreaks\_killstreaks::_ID15602( "airdrop_assault", 0, 0, self );
}

_ID34316()
{

}

_ID28910()
{
    thread maps\mp\killstreaks\_killstreaks::_ID15602( "uav", 0, 0, self );
}

_ID34379()
{

}

_ID28885()
{
    maps\mp\_utility::_ID15611( "specialty_bulletdamage", 0 );
    thread _ID36135();
}

_ID36135()
{
    self notify( "watchStoppingPowerKill" );
    self endon( "watchStoppingPowerKill" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "killed_enemy" );
    _ID34372();
}

_ID34372()
{
    maps\mp\_utility::_unsetperk( "specialty_bulletdamage" );
    self notify( "watchStoppingPowerKill" );
}

_ID28660()
{
    if ( !maps\mp\_utility::_hasperk( "specialty_pistoldeath" ) )
        maps\mp\_utility::_ID15611( "specialty_pistoldeath", 0 );
}

_ID34315()
{
    if ( maps\mp\_utility::_hasperk( "specialty_pistoldeath" ) )
        maps\mp\_utility::_unsetperk( "specialty_pistoldeath" );
}

_ID28763( var_0 )
{
    self endon( "death" );
    self endon( "faux_spawn" );
    self endon( "disconnect" );
    self endon( "unset_juiced" );
    level endon( "game_ended" );
    self._ID18673 = 1;
    self._ID21667 = 1.25;
    maps\mp\gametypes\_weapons::_ID34567();
    maps\mp\_utility::_ID15611( "specialty_fastreload", 0 );
    maps\mp\_utility::_ID15611( "specialty_quickdraw", 0 );
    maps\mp\_utility::_ID15611( "specialty_stalker", 0 );
    maps\mp\_utility::_ID15611( "specialty_fastoffhand", 0 );
    maps\mp\_utility::_ID15611( "specialty_fastsprintrecovery", 0 );
    maps\mp\_utility::_ID15611( "specialty_quickswap", 0 );
    thread _ID34344();
    thread _ID34346();
    thread _ID34345();

    if ( !isdefined( var_0 ) )
        var_0 = 10;

    var_1 = var_0 * 1000 + gettime();

    if ( !isai( self ) )
        self setclientdvar( "ui_juiced_end_milliseconds", var_1 );

    wait(var_0);
    _ID34343();
}

_ID34343( var_0 )
{
    if ( !isdefined( var_0 ) )
    {
        if ( !maps\mp\_utility::_ID18363() )
        {

        }

        if ( maps\mp\_utility::_ID18666() )
        {
            if ( isdefined( self.juggmovespeedscaler ) )
                self._ID21667 = self.juggmovespeedscaler;
            else
                self._ID21667 = 0.7;
        }
        else
        {
            self._ID21667 = 1;

            if ( maps\mp\_utility::_hasperk( "specialty_lightweight" ) )
                self._ID21667 = maps\mp\_utility::_ID19986();
        }

        maps\mp\gametypes\_weapons::_ID34567();
    }

    maps\mp\_utility::_unsetperk( "specialty_fastreload" );
    maps\mp\_utility::_unsetperk( "specialty_quickdraw" );
    maps\mp\_utility::_unsetperk( "specialty_stalker" );
    maps\mp\_utility::_unsetperk( "specialty_fastoffhand" );
    maps\mp\_utility::_unsetperk( "specialty_fastsprintrecovery" );
    maps\mp\_utility::_unsetperk( "specialty_quickswap" );

    if ( isdefined( self.pers["loadoutPerks"] ) )
        maps\mp\perks\_abilities::_ID15614( self.pers["loadoutPerks"] );

    self._ID18673 = undefined;

    if ( !isai( self ) )
        self setclientdvar( "ui_juiced_end_milliseconds", 0 );

    self notify( "unset_juiced" );
}

_ID34346()
{
    self endon( "disconnect" );
    self endon( "unset_juiced" );

    for (;;)
    {
        wait 0.05;

        if ( maps\mp\_utility::_ID18837() )
        {
            thread _ID34343();
            break;
        }
    }
}

_ID34344()
{
    self endon( "disconnect" );
    self endon( "unset_juiced" );
    common_scripts\utility::_ID35626( "death", "faux_spawn" );
    thread _ID34343( 1 );
}

_ID34345()
{
    self endon( "disconnect" );
    self endon( "unset_juiced" );
    level common_scripts\utility::_ID35626( "round_end_finished", "game_ended" );
    thread _ID34343();
}

_ID16406()
{
    return isdefined( self._ID18673 );
}

_ID28677()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "unset_combathigh" );
    level endon( "end_game" );
    self._ID8959 = 0;

    if ( level.splitscreen )
    {
        var_0 = 56;
        var_1 = 21;
    }
    else
    {
        var_0 = 112;
        var_1 = 32;
    }

    if ( isdefined( self._ID18993 ) )
        self._ID18993 destroy();

    if ( isdefined( self._ID18992 ) )
        self._ID18992 destroy();

    self.combathighoverlay = newclienthudelem( self );
    self.combathighoverlay.x = 0;
    self.combathighoverlay.y = 0;
    self.combathighoverlay.alignx = "left";
    self.combathighoverlay.aligny = "top";
    self.combathighoverlay.horzalign = "fullscreen";
    self.combathighoverlay.vertalign = "fullscreen";
    self.combathighoverlay setshader( "combathigh_overlay", 640, 480 );
    self.combathighoverlay.sort = -10;
    self.combathighoverlay.archived = 1;
    self._ID7770 = maps\mp\gametypes\_hud_util::createtimer( "hudsmall", 1.0 );
    self._ID7770 maps\mp\gametypes\_hud_util::_ID28836( "CENTER", "CENTER", 0, var_0 );
    self._ID7770 settimer( 10.0 );
    self._ID7770.color = ( 0.8, 0.8, 0 );
    self._ID7770.archived = 0;
    self._ID7770.foreground = 1;
    self.combathighicon = maps\mp\gametypes\_hud_util::_ID8444( "specialty_painkiller", var_1, var_1 );
    self.combathighicon.alpha = 0;
    self.combathighicon maps\mp\gametypes\_hud_util::_ID28815( self._ID7770 );
    self.combathighicon maps\mp\gametypes\_hud_util::_ID28836( "BOTTOM", "TOP" );
    self.combathighicon.archived = 1;
    self.combathighicon.sort = 1;
    self.combathighicon.foreground = 1;
    self.combathighoverlay.alpha = 0.0;
    self.combathighoverlay fadeovertime( 1.0 );
    self.combathighicon fadeovertime( 1.0 );
    self.combathighoverlay.alpha = 1.0;
    self.combathighicon.alpha = 0.85;
    thread _ID34319();
    thread _ID34320();
    wait 8;
    self.combathighicon fadeovertime( 2.0 );
    self.combathighicon.alpha = 0.0;
    self.combathighoverlay fadeovertime( 2.0 );
    self.combathighoverlay.alpha = 0.0;
    self._ID7770 fadeovertime( 2.0 );
    self._ID7770.alpha = 0.0;
    wait 2;
    self._ID8959 = undefined;
    maps\mp\_utility::_unsetperk( "specialty_combathigh" );
}

_ID34319()
{
    self endon( "disconnect" );
    self endon( "unset_combathigh" );
    self waittill( "death" );
    thread maps\mp\_utility::_unsetperk( "specialty_combathigh" );
}

_ID34320()
{
    self endon( "disconnect" );
    self endon( "unset_combathigh" );

    for (;;)
    {
        wait 0.05;

        if ( maps\mp\_utility::_ID18837() )
        {
            thread maps\mp\_utility::_unsetperk( "specialty_combathigh" );
            break;
        }
    }
}

_ID34318()
{
    self notify( "unset_combathigh" );
    self.combathighoverlay destroy();
    self.combathighicon destroy();
    self._ID7770 destroy();
}

_ID28771( var_0 )
{
    self notify( "give_light_armor" );

    if ( isdefined( self._ID19959 ) )
        unsetlightarmor();

    thread _ID26012();
    thread _ID26013();
    self._ID19959 = 150;

    if ( isdefined( var_0 ) )
        self._ID19959 = var_0;

    if ( isplayer( self ) )
    {
        self setclientomnvar( "ui_light_armor", 1 );
        maps\mp\_utility::_setnameplatematerial( "player_name_bg_green_vest", "player_name_bg_red_vest" );
    }
}

_ID26012()
{
    self endon( "disconnect" );
    self endon( "give_light_armor" );
    self endon( "remove_light_armor" );
    self waittill( "death" );
    unsetlightarmor();
}

unsetlightarmor()
{
    self._ID19959 = undefined;

    if ( isplayer( self ) )
    {
        self setclientomnvar( "ui_light_armor", 0 );
        maps\mp\_utility::_restorepreviousnameplatematerial();
    }

    self notify( "remove_light_armor" );
}

_ID26013()
{
    self endon( "disconnect" );
    self endon( "remove_light_armor" );
    level common_scripts\utility::_ID35626( "round_end_finished", "game_ended" );
    thread unsetlightarmor();
}

haslightarmor()
{
    return isdefined( self._ID19959 ) && self._ID19959 > 0;
}

_ID16397( var_0 )
{
    return isdefined( var_0.heavyarmorhp ) && var_0.heavyarmorhp > 0;
}

_ID28747( var_0 )
{
    if ( isdefined( var_0 ) )
        self.heavyarmorhp = var_0;
}

_ID28854()
{
    self notify( "stopRevenge" );
    wait 0.05;

    if ( !isdefined( self.lastkilledby ) )
        return;

    if ( level._ID32653 && self.team == self.lastkilledby.team )
        return;

    var_0 = spawnstruct();
    var_0._ID29993 = self;
    var_0._ID17321 = "compassping_revenge";
    var_0.offset = ( 0, 0, 64 );
    var_0.width = 10;
    var_0.height = 10;
    var_0.archived = 0;
    var_0.delay = 1.5;
    var_0._ID7887 = 0;
    var_0._ID23590 = 1;
    var_0._ID12626 = 0;
    var_0.is3d = 0;
    self._ID26252 = var_0;
    self.lastkilledby maps\mp\_entityheadicons::setheadicon( var_0._ID29993, var_0._ID17321, var_0.offset, var_0.width, var_0.height, var_0.archived, var_0.delay, var_0._ID7887, var_0._ID23590, var_0._ID12626, var_0.is3d );
    thread _ID36117();
    thread _ID36119();
    thread _ID36118();
    thread _ID36120();
    thread watchstoprevenge();
}

_ID36117()
{
    self endon( "stopRevenge" );
    self endon( "disconnect" );
    var_0 = self.lastkilledby;

    for (;;)
    {
        var_0 waittill( "spawned_player" );
        var_0 maps\mp\_entityheadicons::setheadicon( self._ID26252._ID29993, self._ID26252._ID17321, self._ID26252.offset, self._ID26252.width, self._ID26252.height, self._ID26252.archived, self._ID26252.delay, self._ID26252._ID7887, self._ID26252._ID23590, self._ID26252._ID12626, self._ID26252.is3d );
    }
}

_ID36119()
{
    self endon( "stopRevenge" );
    self waittill( "killed_enemy" );
    self notify( "stopRevenge" );
}

_ID36118()
{
    self endon( "stopRevenge" );
    self.lastkilledby waittill( "disconnect" );
    self notify( "stopRevenge" );
}

watchstoprevenge()
{
    var_0 = self.lastkilledby;
    self waittill( "stopRevenge" );

    if ( !isdefined( var_0 ) )
        return;

    foreach ( var_3, var_2 in var_0._ID12149 )
    {
        if ( !isdefined( var_2 ) )
            continue;

        var_2 destroy();
    }
}

_ID36120()
{
    var_0 = self._ID22499;
    var_1 = self.lastkilledby;
    var_1 endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "stopRevenge" );
    self waittill( "disconnect" );

    if ( !isdefined( var_1 ) )
        return;

    foreach ( var_4, var_3 in var_1._ID12149 )
    {
        if ( !isdefined( var_3 ) )
            continue;

        var_3 destroy();
    }
}

_ID34363()
{
    self notify( "stopRevenge" );
}
