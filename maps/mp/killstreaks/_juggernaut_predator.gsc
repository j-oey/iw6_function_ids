// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

juggpredatorinit()
{
    maps\mp\killstreaks\_juggernaut::initlevelcustomjuggernaut( ::juggpredatorcreate, ::setjuggpredatorclass, ::setjuggpredatormodel, "callout_killed_juggernaut_predator" );
    level._ID20636 = ::_ID8769;
    level.mapcustomkillstreakfunc = ::customkillstreakfunc;
    level._ID20635 = ::custombotkillstreakfunc;
    level._ID1644["predator_uncloak_sparks"] = loadfx( "vfx/_requests/pred/vfx_fade_distortion" );
    level._ID1644["predator_uncloak_chest"] = loadfx( "vfx/_requests/pred/vfx_fade_distortion_chest" );
    level._ID1644["predator_uncloak_limbs"] = loadfx( "vfx/_requests/pred/vfx_fade_distortion_long" );
    level._ID1644["predator_eyes"] = loadfx( "vfx/gameplay/mp/events/vfx_mp_battery3_glowing_eyes" );
    level._ID1644["predator_kill"] = loadfx( "vfx/gameplay/mp/events/vfx_mp_battery3_pred_kill" );
    level._ID1644["predator_self_destruct"] = loadfx( "vfx/_requests/pred/vfx_pred_self_dest" );
    level.previouslaststandcallback = level.callbackplayerlaststand;
    level.callbackplayerlaststand = ::callback_playerlaststandpredator;
}

juggpredatorcreate( var_0 )
{
    self.isjuggernautlevelcustom = 1;
    self.juggmovespeedscaler = 1.05;
    maps\mp\gametypes\_class::giveloadout( self.pers["team"], var_0, 0 );
    maps\mp\_utility::_ID15611( "specialty_spygame", 0 );
    maps\mp\_utility::_ID15611( "specialty_longersprint", 0 );
    maps\mp\_utility::_ID15611( "specialty_falldamage", 0 );
    maps\mp\_utility::_ID15611( "specialty_pistoldeath", 0 );
    maps\mp\_utility::_ID15611( "specialty_selectivehearing", 0 );
    maps\mp\_utility::_ID15611( "specialty_quieter", 0 );
    self._ID21667 = 1.05;
    self.healthregendisabled = 1;
    self._ID6089 = 0;
    self playsound( "scn_predator_spawn_whip" );
    thread juggturnonpredatoraudiozoneuponcreate();
    self setclientomnvar( "ui_predator_hud", 1 );
    thread watchjugghostmigrationfinishedinit();
    self setsurfacetype( "fruit" );
    thread juggpredatorondeath();
    thread juggpredatorondisconnect();
    thread juggpredatorongameended();
    thread predatorcannonupdate();
    thread predatoronenemykilled();
    thread _ID36063();
    thread watchempevent();
    thread predatorvocalclicks();
    thread predatorpaincry();
    thread maps\mp\_utility::_ID32672( "used_juggernaut_predator", self );

    if ( !isai( self ) )
        self notifyonplayercommand( "player_melee", "+melee_zoom" );

    inittimestamp( "victoryCry" );
    inittimestamp( "painCry" );
    self.canusekillstreakcallback = ::juggpredatorcanuseotherkillstreaks;
    self.killstreakerrormsg = ::juggpredatorkillsteakerrormsg;
    thread predatorbeginmusic();
    maps\mp\gametypes\_battlechatter_mp::disablebattlechatter( self );
    self playsound( "scn_predator_first_raise_shing_npc" );
    level notify( "update_bombsquad" );
    level.predatoruser = self;
    return 0;
}

juggturnonpredatoraudiozoneuponcreate()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self setclientomnvar( "enableCustomAudioZone", 1 );
}

juggpredatorongameended()
{
    self endon( "jugg_removed" );
    self endon( "disconnect" );
    level waittill( "game_ended" );
    juggpredatorcleanup();
}

juggpredatorondeath()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    common_scripts\utility::_ID35626( "death", "joined_team", "joined_spectators", "lost_juggernaut" );
    resetcannonlock();
    predatorunsetcloaked( 0 );
    juggpredatorcleanup();
}

juggpredatorondisconnect()
{
    self endon( "death" );
    self waittill( "disconnect" );
    thread predatorendmusic();
}

juggpredatorcleanup()
{
    predatorvisiondisable();
    self setclientomnvar( "enableCustomAudioZone", 0 );
    self setclientomnvar( "ui_predator_hud", 0 );
    self setclientomnvar( "ui_predator_hud_scanline", 0 );
    self setsurfacetype( "flesh" );

    if ( !isai( self ) )
    {
        self notifyonplayercommand( "", "+speed_throw" );

        if ( !level.console )
            self notifyonplayercommand( "", "+toggleads_throw" );

        self notifyonplayercommand( "", "+melee" );
    }

    resettimestamps();
    self.cloaktimestamp = undefined;
    self.predatorvisionenabled = undefined;
    self.canusekillstreakcallback = undefined;
    self.killstreakerrormsg = undefined;
    self.predmoveslowtimestamp = undefined;
    self.predfastslowtimestamp = undefined;
    self.healthregendisabled = undefined;
    self._ID6089 = undefined;
    thread predatorendmusic();
    maps\mp\gametypes\_battlechatter_mp::_ID11489( self );
    level notify( "update_bombsquad" );
    self notify( "jugg_removed" );
}

setjuggpredatorclass( var_0 )
{
    var_1 = [];
    var_1["loadoutPrimary"] = "iw6_predatorcannon";
    var_1["loadoutPrimaryBuff"] = "specialty_null";
    var_1["loadoutSecondaryBuff"] = "specialty_null";
    var_1["loadoutEquipment"] = "specialty_null";
    return var_1;
}

setjuggpredatormodel()
{
    if ( isdefined( self._ID16458 ) )
    {
        self detach( self._ID16458, "" );
        self._ID16458 = undefined;
    }

    self setclothtype( "nylon" );
    self.predatorvisionenabled = 0;
    self.iscloaked = 1;
    predatorunsetcloaked( 0, 1 );
    thread setinitialcloak();
}

setinitialcloak()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait 3;
    thread predatorvisiontoggle();

    if ( !maps\mp\_utility::_ID18610() )
        predatorsetcloaked( 0 );

    thread predatorcloakmovementmonitor();
}

watchjugghostmigrationfinishedinit()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "host_migration_end" );

        if ( isdefined( self ) && isdefined( self.isjuggernautlevelcustom ) && self.isjuggernautlevelcustom )
        {
            self setclientomnvar( "enableCustomAudioZone", 1 );
            self setclientomnvar( "ui_predator_hud", 1 );
        }
    }
}

juggpredatorcanuseotherkillstreaks( var_0 )
{
    return 0;
}

juggpredatorkillsteakerrormsg()
{
    self iprintlnbold( &"MP_JUGG_PREDATOR_NO_KILLSTREAKS" );
}

tryusecustomjuggernaut( var_0, var_1 )
{
    maps\mp\killstreaks\_juggernaut::givejuggernaut( var_1 );
    game["player_holding_level_killstrek"] = 0;
    return 1;
}

enable_level_killstreak()
{
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "juggernaut_predator", 85 );
}

disable_level_killstreak()
{
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "juggernaut_predator", 0 );
}

_ID8769()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    if ( !maps\mp\_utility::allowlevelkillstreaks() || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "juggernaut_predator", 85, maps\mp\killstreaks\_airdrop::_ID18982, maps\mp\killstreaks\_airdrop::get_friendly_juggernaut_crate_model(), maps\mp\killstreaks\_airdrop::_ID14446(), &"MP_JUGG_PREDATOR_PICKUP" );
    level thread watch_for_jugg_crate();
}

watch_for_jugg_crate()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "juggernaut_predator" )
        {
            disable_level_killstreak();
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                enable_level_killstreak();
                continue;
            }

            game["player_holding_level_killstrek"] = 1;
            break;
        }
    }
}

_ID35446( var_0 )
{
    var_1 = _ID35948( var_0 );
    return !isdefined( var_1 );
}

_ID35948( var_0 )
{
    var_0 endon( "captured" );
    var_0 waittill( "death" );
    waittillframeend;
    return 1;
}

customkillstreakfunc()
{
    level._ID19256["juggernaut_predator"] = ::tryusecustomjuggernaut;
}

custombotkillstreakfunc()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "juggernaut_predator", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

predatorsetcloaked( var_0 )
{
    if ( !self.iscloaked )
    {
        self.iscloaked = 1;
        self.cloaktimestamp = gettime() + 500;

        if ( var_0 )
        {
            self playlocalsound( "scn_predator_plr_cloak_on" );
            self playsound( "scn_predator_npc_cloak_on" );
        }

        thread predatorplayunloakvfx();
        self setviewmodel( "viewhands_mp_predator_proto_cloaked" );
        self setmodel( "fullbody_mp_predator_a_cloaked" );
        maps\mp\_utility::_ID15611( "specialty_blindeye", 0 );
        maps\mp\_utility::_ID15611( "specialty_noscopeoutline", 0 );
        thread predatoreyeflashupdate();
    }
}

predatorunsetcloaked( var_0, var_1 )
{
    if ( self.iscloaked )
    {
        self.iscloaked = 0;
        self.cloaktimestamp = gettime() + 1000;

        if ( var_0 )
        {
            self playlocalsound( "scn_predator_plr_cloak_off" );
            self playsound( "scn_predator_npc_cloak_off" );
        }
        else if ( isdefined( self._ID18349 ) && self._ID18349 )
        {
            self playlocalsound( "scn_predator_plr_cloak_off_waterfall" );
            self playsound( "scn_predator_npc_cloak_off_waterfall" );
        }

        thread predatorplayunloakvfx();
        self setviewmodel( "viewhands_mp_predator_proto" );

        if ( isalive( self ) && !isdefined( var_1 ) )
            wait 0.25;

        self setmodel( "fullbody_mp_predator_a" );
        maps\mp\_utility::_unsetperk( "specialty_blindeye" );
        maps\mp\_utility::_unsetperk( "specialty_noscopeoutline" );
    }
}

predatorplayunloakvfx()
{
    self endon( "death" );
    playfxontag( common_scripts\utility::_ID15033( "predator_uncloak_chest" ), self, "j_spineupper" );
    playfxontag( common_scripts\utility::_ID15033( "predator_uncloak_chest" ), self, "j_spinelower" );
    wait 0.05;
    playfxontag( common_scripts\utility::_ID15033( "predator_uncloak_sparks" ), self, "j_head" );
    playfxontag( common_scripts\utility::_ID15033( "predator_uncloak_limbs" ), self, "j_knee_ri" );
    playfxontag( common_scripts\utility::_ID15033( "predator_uncloak_limbs" ), self, "j_knee_le" );
    wait 0.05;
    playfxontag( common_scripts\utility::_ID15033( "predator_uncloak_limbs" ), self, "j_elbow_ri" );
    playfxontag( common_scripts\utility::_ID15033( "predator_uncloak_limbs" ), self, "j_elbow_le" );
    wait 0.05;
    playfxontag( common_scripts\utility::_ID15033( "predator_uncloak_sparks" ), self, "j_wrist_le" );
    playfxontag( common_scripts\utility::_ID15033( "predator_uncloak_sparks" ), self, "j_wrist_ri" );
    wait 0.05;
    playfxontag( common_scripts\utility::_ID15033( "predator_uncloak_limbs" ), self, "j_ankle_le" );
    playfxontag( common_scripts\utility::_ID15033( "predator_uncloak_limbs" ), self, "j_ankle_ri" );
}

predatorusewristcomputer()
{
    maps\mp\_utility::_giveweapon( "iw6_predatorwristcpu_mp" );
    self switchtoweapon( "iw6_predatorwristcpu_mp" );
    wait 1;
    self switchtoweapon( "iw6_predatorcannon_mp" );
    self takeweapon( "iw6_predatorwristcpu_mp" );
}

predatorcloakmovementmonitor()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "predator_lastStand" );
    level endon( "game_ended" );
    self.predmovefasttimestamp = 0;
    self.predmoveslowtimestamp = 0;
    self.predcloakdenieduntiltime = 0;
    childthread predatorcloakwaitforforceend();

    for (;;)
    {
        if ( self.iscloaked )
        {
            var_0 = common_scripts\utility::_ID35635( "sprint_begin", "predator_force_uncloak" );

            if ( var_0 == "sprint_begin" )
                thread predatorunsetcloaked( 1 );
        }
        else if ( isdefined( self._ID18349 ) && self._ID18349 || maps\mp\_utility::_ID18610() )
            self.predcloakdenieduntiltime = gettime() + 1000;
        else if ( self isonground() && !self ismantling() )
        {
            var_1 = lengthsquared( self getvelocity() );
            var_2 = gettime();

            if ( var_1 < 18225 && !self issprinting() )
            {
                if ( var_2 >= self.predcloakdenieduntiltime )
                {
                    predatorsetcloaked( 1 );
                    continue;
                }
            }
            else
                self.predcloakdenieduntiltime = var_2 + 1250;
        }

        wait 0.1;
    }
}

predatorcloakwaitforinput()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "predator_lastStand" );
    level endon( "game_ended" );
    childthread predatorcloakwaitforforceend();

    for (;;)
    {
        self waittill( "predator_cloak_toggle" );

        if ( gettime() < self.cloaktimestamp )
            continue;

        if ( self ismantling() || self ismeleeing() || maps\mp\_utility::_ID18610() )
        {
            wait 0.05;
            continue;
        }

        if ( self.iscloaked )
        {
            thread predatorunsetcloaked( 1 );
            continue;
        }

        if ( isdefined( self._ID18349 ) && self._ID18349 )
        {
            thread predatorplayunloakvfx();
            wait 0.05;
            continue;
            continue;
        }

        predatorsetcloaked( 1 );
    }
}

predatorcloakwaitforforceend()
{
    for (;;)
    {
        self waittill( "predator_force_uncloak" );

        while ( self ismantling() )
            wait 0.05;

        if ( self.iscloaked )
            predatorunsetcloaked( 0 );
    }
}

predatorcloakforceend( var_0 )
{
    self.predcloakdenieduntiltime = gettime() + var_0;
    self notify( "predator_force_uncloak" );
}

predatorcannonupdate()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "predator_lastStand" );
    self.cannonstate = 0;

    for (;;)
    {
        if ( self.cannonstate == 0 )
        {
            var_0 = findtargetinreticle( 65, 80 );

            if ( isdefined( var_0 ) )
                startcannonlock( var_0 );
            else
                wait 0.5;

            continue;
        }

        if ( self.cannonstate == 1 )
        {
            var_1 = self.cannontarget;

            if ( isdefined( var_1 ) && maps\mp\_utility::_ID18757( var_1 ) && self worldpointinreticle_circle( var_1 geteye(), 65, 150 ) && !maps\mp\_utility::_ID18610() )
            {
                if ( gettime() >= self.cannonlockreadytime )
                {
                    finalizecannonlock( self.cannontarget );
                    childthread waittillcannonfire( self.cannontarget );
                }
            }
            else
                resetcannonlock( 1 );

            wait 0.05;
            continue;
        }

        if ( self.cannonstate == 2 )
        {
            if ( !isdefined( self.cannontarget ) || !maps\mp\_utility::_ID18757( self.cannontarget ) || distance2dsquared( self.origin, self.cannontarget.origin ) > 518400 || maps\mp\_utility::_ID18610() )
                resetcannonlock( 1 );

            wait 0.05;
            continue;
        }

        if ( self.cannonstate == -1 )
            reloadcannon();
    }
}

findtargetinreticle( var_0, var_1 )
{
    var_2 = findalltargetsinreticle( var_0, var_1 );
    return var_2[0];
}

findalltargetsinreticle( var_0, var_1 )
{
    var_2 = [];

    if ( !maps\mp\_utility::_ID18610() )
    {
        foreach ( var_4 in level.characters )
        {
            if ( isdefined( var_4 ) && maps\mp\_utility::_ID18757( var_4 ) && maps\mp\_utility::isenemy( var_4 ) && !var_4 maps\mp\_utility::_hasperk( "specialty_blindeye" ) && distance2dsquared( self.origin, var_4.origin ) <= 518400 )
            {
                var_5 = var_4 geteye();

                if ( self worldpointinreticle_circle( var_5, var_0, var_1 ) && sighttracepassed( self geteye(), var_5, 0, undefined, undefined ) )
                    var_2[var_2.size] = var_4;
            }
        }

        if ( var_2.size > 1 )
            return sortbydistance( var_2, self.origin );
    }

    return var_2;
}

startcannonlock( var_0 )
{
    self playlocalsound( "scn_predator_weap_plr_lock_01" );
    self.cannontarget = var_0;
    self.cannonlockreadytime = gettime() + 375.0;
    self.cannonstate = 1;
    self weaponlockstart( var_0 );
    self setclientomnvar( "ui_predator_target_ent", var_0 getentitynumber() );
    self setclientomnvar( "ui_predator_hud_reticle", 1 );
    self laseron();
    thread playcannonlocksound();
}

playcannonlocksound()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "predatorLockEnded" );
    wait 0.1875;
}

finalizecannonlock( var_0 )
{
    self.cannonstate = 2;
    var_1 = ( 0, 0, 0 );
    self weaponlockfinalize( var_0, var_1, 0 );
    self stoplocalsound( "scn_predator_weap_plr_lock_01" );
    self playlocalsound( "scn_predator_weap_plr_lock_03" );
    self setclientomnvar( "ui_predator_hud_reticle", 2 );
}

detachreticlevfxfromtarget( var_0, var_1 )
{
    self setclientomnvar( "ui_predator_hud_reticle", 0 );
    self stoplocalsound( "scn_predator_weap_plr_lock_03" );

    if ( isdefined( var_1 ) && var_1 )
    {
        self stoplocalsound( "scn_predator_weap_plr_lock_01" );
        self playlocalsound( "scn_predator_weap_plr_lose_lock" );
    }
}

waittillcannonfire( var_0 )
{
    self endon( "predatorLockEnded" );
    self waittill( "missile_fire",  var_1, var_2  );
    predatorcloakforceend( 3000 );
    childthread clearlockonprojectileimpact( var_1 );
    self setclientomnvar( "ui_predator_hud_reticle", 0 );
    self.cannonstate = -1;
}

reloadcannon()
{
    wait 7.15;
    self playlocalsound( "scn_predator_weap_plr_reload_done" );
    wait 0.85;
    self setweaponammoclip( "iw6_predatorcannon_mp", 1 );
    resetcannonlock();
}

resetcannonlock( var_0 )
{
    detachreticlevfxfromtarget( self.cannontarget, var_0 );
    self.cannontarget = undefined;
    self.cannonlockreadytime = undefined;
    self.cannonstate = 0;
    self weaponlockfree();
    self weaponlocktargettooclose( 0 );
    self weaponlocknoclearance( 0 );
    self laseroff();
    self notify( "predatorLockEnded" );
    self setclientomnvar( "ui_predator_target_ent", -1 );
}

islocking()
{
    return self playerads() > 0.95;
}

clearlockonprojectileimpact( var_0 )
{
    self endon( "predatorLockEnded" );
    var_0 waittill( "death" );
    detachreticlevfxfromtarget( self.cannontarget );
    self notify( "predatorLockEnded" );
}

predatorvisiontoggle()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "predator_lastStand" );
    level endon( "game_ended" );

    if ( !isai( self ) )
    {
        self notifyonplayercommand( "predator_vision", "+speed_throw" );

        if ( !level.console )
            self notifyonplayercommand( "predator_vision", "+toggleads_throw" );
    }

    if ( !maps\mp\_utility::_ID18610() )
        predatorvisionenable();

    for (;;)
    {
        self waittill( "predator_vision" );

        if ( !self isthrowinggrenade() && !maps\mp\_utility::_ID18610() )
        {
            if ( self.predatorvisionenabled )
                predatorvisiondisable();
            else
                predatorvisionenable();

            wait 0.5;
        }
    }
}

predatorvisionenable()
{
    if ( !self.predatorvisionenabled )
    {
        self.predatorvisionenabled = 1;
        self playlocalsound( "scn_predator_plr_switch_vision_to_predator" );
        self setclientomnvar( "ui_predator_hud_scanline", 1 );
        predatoroutlineson();
    }
}

predatorvisiondisable()
{
    if ( self.predatorvisionenabled )
    {
        self.predatorvisionenabled = 0;
        self playlocalsound( "scn_predator_plr_switch_vision_to_normal" );
        self visionsetnakedforplayer( "", 0.1 );
        self setclientomnvar( "ui_predator_vision", 0 );
        predatoroutlinesoff();
        self setclientomnvar( "ui_predator_hud_scanline", 1 );
    }
}

predatoroutlineson()
{
    self setclientomnvar( "ui_predator_vision", 1 );

    foreach ( var_1 in level.characters )
    {
        if ( maps\mp\_utility::_ID18757( var_1 ) && var_1 != self && ( isagent( var_1 ) || var_1.sessionstate == "playing" ) )
        {
            var_2 = "cyan";

            if ( maps\mp\_utility::isenemy( var_1 ) )
                var_2 = "red";

            if ( !var_1 maps\mp\_utility::_hasperk( "specialty_incog" ) )
                thread outlinepredatortarget( var_1, var_2 );
        }
    }

    thread _ID38297();
    thread watchagentsspawning();
    thread watchownerdisconnect();
}

_ID38295( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "endPredatorVision" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 waittill( "starting_perks_unset" );

    if ( maps\mp\_utility::isenemy( var_0 ) )
        thread outlinepredatortarget( var_0, "red" );
    else
        thread outlinepredatortarget( var_0, "cyan" );
}

outlinepredatortarget( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "endPredatorVision" );
    level endon( "game_ended" );
    var_2 = maps\mp\_utility::_ID23108( var_0, var_1, self, 1, "killstreak_personal" );
    var_3 = var_0 getentitynumber();
    level.predatortargetsents[var_3] = var_0;
    level.predatortargetsoutlines[var_3] = var_2;
    var_0 common_scripts\utility::_ID35626( "death", "disconnect" );

    if ( isdefined( var_0 ) )
        maps\mp\_utility::_ID23104( level.predatortargetsoutlines[var_3], var_0 );

    level.predatortargetsents[var_3] = undefined;
    level.predatortargetsoutlines[var_3] = undefined;
}

_ID38297()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "endPredatorVision" );

    for (;;)
    {
        level waittill( "player_spawned",  var_0  );

        if ( var_0.sessionstate == "playing" && !var_0 maps\mp\_utility::_hasperk( "specialty_incog" ) )
            thread _ID38295( var_0 );
    }
}

watchagentsspawning()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "endPredatorVision" );

    for (;;)
    {
        level waittill( "spawned_agent",  var_0  );

        if ( maps\mp\_utility::isenemy( var_0 ) )
        {
            thread outlinepredatortarget( var_0, "red" );
            continue;
        }

        thread outlinepredatortarget( var_0, "cyan" );
    }
}

watchownerdisconnect()
{
    self endon( "death" );
    level endon( "game_ended" );
    self waittill( "disconnect" );
    predatoroutlinesoff();
}

predatoroutlinesoff()
{
    self notify( "endPredatorVision" );

    if ( isdefined( level.predatortargetsents ) )
    {
        foreach ( var_2, var_1 in level.predatortargetsents )
        {
            if ( isalive( var_1 ) )
                maps\mp\_utility::_ID23104( level.predatortargetsoutlines[var_2], var_1 );
        }

        level.predatortargetsents = undefined;
        level.predatortargetsoutlines = undefined;
    }

    if ( isdefined( self ) )
        self setclientomnvar( "ui_predator_vision", 0 );
}

callback_playerlaststandpredator( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( isdefined( self.isjuggernautlevelcustom ) && self.isjuggernautlevelcustom )
    {
        resetcannonlock();
        predatorunsetcloaked( 0 );
        predatorvisiondisable();
        var_9 = spawnstruct();
        var_9.einflictor = var_0;
        var_9.attacker = var_1;
        var_9._ID17335 = var_2;
        var_9.attackerposition = var_1.origin;

        if ( var_1 == self )
            var_9._ID30258 = "MOD_SUICIDE";
        else
            var_9._ID30258 = var_3;

        var_9._ID32157 = var_4;

        if ( isdefined( var_1 ) && isplayer( var_1 ) && var_1 getcurrentprimaryweapon() != "none" )
            var_9._ID31095 = var_1 getcurrentprimaryweapon();
        else
            var_9._ID31095 = undefined;

        var_9._ID34931 = var_5;
        var_9._ID29709 = var_6;
        var_9._ID19635 = gettime() + 8000;
        var_10 = maydolaststand( var_4, var_9._ID30258, var_6 );

        if ( isdefined( self.endgame ) )
            var_10 = 0;

        if ( !var_10 )
        {
            var_9._ID19635 = gettime();
            self._ID19631 = var_9;
            self._ID34755 = 1;
            maps\mp\_utility::_suicide();
            return;
        }

        self._ID18011 = 1;
        self.health = 9999;

        foreach ( var_12 in level.players )
        {
            if ( isdefined( var_12 ) && !isai( var_12 ) )
                var_12 playlocalsound( "scn_predator_plr_vocal_laugh" );
        }

        if ( isdefined( level.ac130player ) && isdefined( var_1 ) && level.ac130player == var_1 )
            level notify( "ai_crawling",  self  );

        self._ID24942 = self._ID19545;
        self._ID19631 = var_9;
        self takeallweapons();
        self giveweapon( "iw6_predatorsuicide_mp", 0, 0 );
        self switchtoweapon( "iw6_predatorsuicide_mp" );
        common_scripts\utility::_disableusability();
        self.inc4death = 1;
        thread activatepredatorcountdown();
        thread clearpredatorbombtimer();
        thread _ID19636( 8 );
        self notify( "predator_lastStand" );
    }
    else if ( isdefined( level.previouslaststandcallback ) )
        [[ level.previouslaststandcallback ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
}

maydolaststand( var_0, var_1, var_2 )
{
    if ( var_1 == "MOD_TRIGGER_HURT" )
        return 0;

    if ( var_1 == "MOD_SUICIDE" )
        return 0;

    return 1;
}

activatepredatorcountdown()
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "predator_detonate" );
    level endon( "game_ended" );
    var_0 = 3;
    var_1 = 8 - var_0;
    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    setomnvar( "ui_bomb_timer", 4 );
    childthread update_pred_ui_timer( var_1 );
}

update_pred_ui_timer( var_0 )
{
    var_1 = var_0 * 1000 + gettime();
    setomnvar( "ui_nuke_end_milliseconds", var_1 );
    level waittill( "host_migration_begin" );
    var_2 = maps\mp\gametypes\_hostmigration::_ID35770();

    if ( var_2 > 0 )
        setomnvar( "ui_nuke_end_milliseconds", var_1 + var_2 );
}

clearpredatorbombtimer()
{
    level endon( "game_ended" );
    common_scripts\utility::_ID35626( "predator_detonate", "joined_team", "disconnect" );
    setomnvar( "ui_bomb_timer", 0 );
}

_ID19636( var_0 )
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    level endon( "game_ended" );
    common_scripts\utility::_ID35637( var_0, "death", "detonate" );
    predatorsuicidenuke();
}

detonateonuse()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    level endon( "game_ended" );
    self waittill( "detonate" );
    predatorsuicidenuke();
}

_ID9952()
{
    self endon( "detonate" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    level endon( "game_ended" );
    self waittill( "death" );
    predatorsuicidenuke();
}

predatorsuicidenuke()
{
    self._ID34755 = 1;
    self playsound( "predator_explosion" );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1 ) && !isai( var_1 ) )
            var_1 playlocalsound( "predator_explosion_boom_local" );
    }

    self visionsetnakedforplayer( "coup_sunblind", 0.1 );
    wait 0.2;
    playfx( common_scripts\utility::_ID15033( "predator_self_destruct" ), self.origin, anglestoup( self.angles ), anglestoforward( self.angles ) );
    radiusdamage( self.origin, 800, 100, 100, self );
    earthquake( 0.1, 3.0, self.origin, 800 );
    playpredatorexpvisionsequence();
    level notify( "jugg_predator_killed",  self  );
    self notify( "predator_detonate" );

    if ( isalive( self ) )
        maps\mp\_utility::_suicide();
}

predatoreyeflashupdate()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "player_melee" );

        if ( self.iscloaked )
        {
            predatorcloakforceend( 1000 );
            continue;
        }

        break;
    }
}

predatoronenemykilled()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "predator_lastStand" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "killed_enemy",  var_0, var_1, var_2  );

        if ( var_1 == "iw6_predatorcannon_mp" )
        {
            if ( isdefined( var_2 ) && var_2 == "MOD_MELEE" )
                predatormeleekilleffect( var_0 );
        }
    }
}

predatormeleekilleffect( var_0 )
{
    var_1 = var_0.origin + ( 0, 0, 50 );
    self playlocalsound( "scn_predator_melee_swing_plr" );
    var_2 = self.origin - var_0.origin;
    var_3 = var_0 gettagorigin( "j_neck" );
    playfx( level._ID1644["predator_kill"], var_3, vectornormalize( var_2 ), anglestoup( var_0 gettagangles( "j_neck" ) ) );

    if ( checktimestamp( "victoryCry" ) && checktimestamp( "painCry" ) )
    {
        settimestamp( "victoryCry", 10000 );
        predatorplayvo( "scn_predator_plr_vocal_victory_cry", "scn_predator_npc_vocal_victory_cry" );
    }
}

_ID36063()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "predator_lastStand" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "emp_damage",  var_0, var_1  );
        common_scripts\utility::_ID35582();

        if ( maps\mp\_utility::_ID18610() )
        {
            predatorvisiondisable();
            predatorcloakforceend( 1000 );
        }
    }
}

watchempevent()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "predator_lastStand" );
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "emp_update" );

        if ( maps\mp\_utility::_ID18610() )
        {
            predatorvisiondisable();
            predatorcloakforceend( 1000 );
        }
    }
}

predatorvocalclicks()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "predator_lastStand" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = randomfloatrange( 10, 15 );
        wait(var_0);

        if ( checktimestamp( "victoryCry" ) && checktimestamp( "painCry" ) )
            predatorplayvo( "scn_predator_plr_vocal_clicks", "scn_predator_npc_vocal_clicks" );
    }
}

predatorpaincry()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "predator_lastStand" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4  );

        if ( isdefined( var_1 ) && var_1 != self && var_0 > 10 && checktimestamp( "painCry", 1000 ) )
            predatorplayvo( "scn_predator_plr_vocal_pain", "scn_predator_npc_vocal_pain" );
    }
}

predatorplayvo( var_0, var_1 )
{
    self playlocalsound( var_0 );
    self playsoundonmovingent( var_1 );
}

predatorbeginmusic()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "predator_lastStand" );
    level endon( "game_ended" );
    maps\mp\gametypes\_music_and_dialog::disablemusic();
    level.predatormusicent = spawn( "script_origin", ( 0, 0, 0 ) );
    level.predatormusicent playsound( "mus_predator_music_spawn" );
    childthread predatortensionmusic();
}

predatortensionmusic()
{
    var_0 = [ "mus_predator_music_tension_01", "mus_predator_music_tension_02" ];
    var_1 = randomint( var_0.size );

    for (;;)
    {
        wait 50;
        level.predatormusicent playsound( var_0[var_1] );
        var_1++;

        if ( var_1 >= var_0.size )
            var_1 = 0;
    }
}

predatorendmusic()
{
    level.predatormusicent stopsounds();
    thread maps\mp\gametypes\_music_and_dialog::enablemusic();
    common_scripts\utility::_ID35582();
    level.predatormusicent delete();
    level.predatormusicent = undefined;
}

playpredatorexpvisionsequence()
{
    level.predatorexptimer = 0;
    level thread delaythread_predatorexp( level.predatorexptimer, ::predatorexpslowmo );
    level thread delaythread_predatorexp( level.predatorexptimer, ::predatorexpvision );
    level thread delaythread_predatorexp( level.predatorexptimer + 0.5, ::predatorexpdeath );
}

delaythread_predatorexp( var_0, var_1 )
{
    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    thread [[ var_1 ]]();
}

predatorexpvision()
{
    if ( maps\mp\_utility::_ID18422() )
    {
        visionsetpostapply( "mpnuke", 0.2 );
        maps\mp\gametypes\_hostmigration::_ID35597( 0.2 );
        visionsetpostapply( "nuke_global_flash", 0.5 );
        maps\mp\gametypes\_hostmigration::_ID35597( 0.3 );
        visionsetpostapply( "", 1 );
    }
    else
    {
        visionsetpostapply( "mpnuke", 0.7 );
        maps\mp\gametypes\_hostmigration::_ID35597( 0.5 );
        visionsetpostapply( "nuke_global_flash", 0.5 );
        maps\mp\gametypes\_hostmigration::_ID35597( 0.5 );
        visionsetpostapply( "", 0.5 );
    }
}

predatorexpslowmo()
{
    setslowmotion( 1.0, 0.25, 0.5 );
    maps\mp\gametypes\_hostmigration::_ID35597( 1 );
    setslowmotion( 0.25, 1, 2.0 );
}

predatorexpdeath()
{
    maps\mp\gametypes\_hostmigration::_ID35770();

    if ( isdefined( level.predatoruser ) )
    {
        foreach ( var_1 in level.characters )
        {
            if ( predatorexpcankill( var_1 ) )
            {
                if ( isplayer( var_1 ) )
                {
                    if ( maps\mp\_utility::_ID18757( var_1 ) )
                        var_1 thread maps\mp\gametypes\_damage::_ID12959( level.predatoruser, level.predatoruser, 999999, 0, "MOD_EXPLOSIVE", "iw6_predatorsuicide_mp", var_1.origin, ( 0, 0, 1 ), "none", 0, 0 );

                    continue;
                }

                var_1 maps\mp\agents\_agents::agent_damage_finished( level.predatoruser, level.predatoruser, 999999, 0, "MOD_EXPLOSIVE", "iw6_predatorsuicide_mp", var_1.origin, ( 0, 0, 1 ), "none", 0 );
            }
        }
    }

    var_3 = maps\mp\_utility::getotherteam( level.predatoruser.team );
    level maps\mp\killstreaks\_jammer::_ID9812( level.predatoruser, var_3 );
    level maps\mp\killstreaks\_air_superiority::_ID9792( level.predatoruser, var_3 );
}

predatorexpcankill( var_0 )
{
    if ( level._ID32653 )
    {
        if ( var_0.team == level.predatoruser.team )
            return 0;
    }
    else
    {
        var_1 = var_0 == level.predatoruser;
        var_2 = isdefined( var_0.owner ) && var_0.owner == level.predatoruser;

        if ( var_1 || var_2 )
            return 0;
    }

    return 1;
}

inittimestamp( var_0 )
{
    self._eventtimestamps[var_0] = 0;
}

checktimestamp( var_0, var_1 )
{
    return gettime() >= self._eventtimestamps[var_0];
}

settimestamp( var_0, var_1 )
{
    self._eventtimestamps[var_0] = gettime() + var_1;
}

resettimestamps()
{
    self._eventtimestamps = undefined;
}
