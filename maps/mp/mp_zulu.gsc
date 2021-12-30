// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_zulu_precache::_ID20445();
    maps\createart\mp_zulu_art::_ID20445();
    maps\mp\mp_zulu_fx::_ID20445();
    maps\mp\_breach::_ID20445();
    maps\mp\_load::_ID20445();
    maps\mp\_barrels_leak::_ID20445();
    level.nukedeathvisionfunc = ::nukedeathvision;
    maps\mp\_compass::_ID29184( "compass_map_mp_zulu" );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 2.5, 7.5 );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );

    if ( level._ID25139 )
    {
        setdvar( "sm_sunShadowScale", "0.45" );
        setdvar( "sm_sunsamplesizenear", ".35" );
    }
    else if ( level._ID36452 )
    {
        setdvar( "sm_sunShadowScale", "0.55" );
        setdvar( "sm_sunsamplesizenear", ".35" );
    }
    else
    {
        setdvar( "sm_sunShadowScale", "1.0" );
        setdvar( "sm_sunsamplesizenear", ".35" );
    }

    level._ID20636 = ::mariachicustomcratefunc;
    level.mapcustomkillstreakfunc = ::mariachicustomkillstreakfunc;
    level._ID20635 = ::mariachicustombotkillstreakfunc;
    maps\mp\killstreaks\_juggernaut::initlevelcustomjuggernaut( ::deathmariachicreatefunc, ::setjuggdeathmariachiclass, ::setjuggdeathmariachi, "callout_killed_death_mariachi" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "urban";
    game["axis_outfit"] = "woodland";
    thread zulu_breach_init();
    thread _ID36620::_ID37998( "alienEasterEgg" );
    thread precache_strings();
    thread nuke_custom_visionset();
    thread get_float_speaker_scriptables();
    thread setup_music_emitters();
}

precache_strings()
{
    precachestring( &"MP_ZULU_DEFAULT_TXT_01" );
    precachestring( &"MP_ZULU_DEFAULT_TXT_02" );
    precachestring( &"MP_ZULU_TESTREF" );
    precachestring( &"MP_ZULU_INSTRUCTION" );
}

setup_music_emitters()
{
    level.music_float_1 = common_scripts\utility::_ID23798( "zulu_emt_mariachi_float", ( 320, 702, 151 ) );
    level.float_music_enabled = 1;
    maps\mp\_utility::_ID9519( 2.0, maps\mp\gametypes\_music_and_dialog::disablemusic );
}

stop_ambient_music()
{
    level.music_float_1 stoploopsound();
}

start_ambient_music()
{
    if ( level.float_music_enabled == 1 )
        level.music_float_1 playloopsound( "zulu_emt_mariachi_float" );
}

zulu_killstreak()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );
    level.muerto_active = 1;

    for (;;)
    {
        self iprintlnbold( &"MP_ZULU_INSTRUCTION" );
        thread givespiritvision();
        thread createresurrectedsquadmate();
        thread stop_ambient_music();
        maps\mp\_utility::_ID15611( "specialty_spygame", 0 );
        maps\mp\_utility::_ID15611( "specialty_coldblooded", 0 );
        maps\mp\_utility::_ID15611( "specialty_noscopeoutline", 0 );
        maps\mp\_utility::_ID15611( "specialty_heartbreaker", 0 );
        maps\mp\_utility::_ID15611( "specialty_fastreload", 0 );
        maps\mp\_utility::_ID15611( "specialty_scavenger", 0 );
        maps\mp\_utility::_ID15611( "specialty_sprintreload", 0 );
        maps\mp\_utility::_ID15611( "specialty_fastsprintrecovery", 0 );
        maps\mp\_utility::_ID15611( "specialty_marathon", 0 );
        maps\mp\_utility::_ID15611( "specialty_empimmune", 0 );
        maps\mp\_utility::_ID15611( "specialty_blindeye", 0 );

        while ( maps\mp\_utility::_ID18757( self ) )
        {
            var_0 = self.pers["kills"];

            while ( var_0 == self.pers["kills"] )
            {
                wait 0.1;

                if ( !maps\mp\_utility::_ID18757( self ) )
                    break;
            }
        }
    }
}

play_mariachi_music_on_plr()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );

    for (;;)
    {
        self playlocalsound( "killstreak_mariachi_music_plr", "sounddone" );
        self waittill( "sounddone" );
    }
}

givespiritvision()
{
    self endon( "death" );

    while ( maps\mp\_utility::_ID18757( self ) )
    {
        thread _ID33802();
        wait(level._ID34168["uav_3dping"].timeout);
    }
}

_ID33802( var_0, var_1 )
{
    var_2 = "uav_3dping";
    thread watch3dping_spiritvision( var_2 );
    return 1;
}

watch3dping_spiritvision( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        var_1 endon( "death" );

    self endon( "leave" );
    self endon( "killstreak_disowned" );
    self endon( "death" );
    level endon( "game_ended" );
    var_2 = 2.0;

    if ( level._ID32653 )
        level.activeuavs[self.team]++;
    else
        level.activeuavs[self._ID15851]++;

    for (;;)
    {
        foreach ( var_4 in level._ID23303 )
        {
            if ( !maps\mp\_utility::_ID18757( var_4 ) )
                continue;

            if ( !maps\mp\_utility::isenemy( var_4 ) )
                continue;

            if ( var_4 maps\mp\_utility::_hasperk( "specialty_noplayertarget" ) || var_4 maps\mp\_utility::_hasperk( "specialty_incog" ) )
                continue;

            if ( maps\mp\agents\_agent_utility::getnumownedactiveagents( self ) < 2 )
            {
                var_5 = maps\mp\_utility::_ID23108( var_4, "red", self, 0, "killstreak" );
                var_6 = 2.0;
                thread _ID36088( var_5, var_4, var_6, var_1 );
            }
        }

        maps\mp\gametypes\_hostmigration::_ID35597( var_2 );
    }
}

_ID36088( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_3 ) )
        var_3 endon( "death" );

    self endon( "disconnect" );
    level endon( "game_ended" );
    common_scripts\utility::_ID35638( var_2, "leave" );

    if ( isdefined( var_1 ) )
        maps\mp\_utility::_ID23104( var_0, var_1 );
}

createresurrectedsquadmate()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "killed_enemy",  var_0, var_1  );

        if ( var_1 != "agent_support_mp" && var_1 == "iw6_mariachimagnum_mp_akimbo" )
        {
            var_2 = _ID34771( var_0 );

            if ( isagent( var_2 ) )
                var_2 customizesquadmate( var_0 );
        }
    }
}

customizesquadmate( var_0 )
{
    self.agent_is_mariachi = 1;

    if ( isdefined( self._ID16458 ) )
    {
        self detach( self._ID16458, "" );
        self._ID16458 = undefined;
    }

    self setmodel( "mp_mariachi" );
    playsoundatpos( self.origin, "zulu_mariachi_spawn" );
    thread deathmariachibotsounds();
    playfx( level._ID1644["vfx_squadmate_spawn_burst"], self.origin );
    wait 0.05;
    playfxontag( level._ID1644["vfx_death_smoke_runner"], self, "tag_origin" );
    self takeallweapons();
    self giveweapon( "iw6_mariachimagnum_mp_akimbo" );
    self switchtoweapon( "iw6_mariachimagnum_mp_akimbo" );
    maps\mp\_utility::_ID15611( "specialty_spygame", 0 );
    maps\mp\_utility::_ID15611( "specialty_coldblooded", 0 );
    maps\mp\_utility::_ID15611( "specialty_noscopeoutline", 0 );
    maps\mp\_utility::_ID15611( "specialty_heartbreaker", 0 );
    maps\mp\_utility::_ID15611( "specialty_scavenger", 0 );
    maps\mp\_utility::_ID15611( "specialty_sprintreload", 0 );
    maps\mp\_utility::_ID15611( "specialty_marathon", 0 );
    maps\mp\_utility::_ID15611( "specialty_empimmune", 0 );
    thread post_killcam_perks();
    self.health = 25;
    thread agentdeathevents();
}

post_killcam_perks()
{
    wait 5.0;
    maps\mp\_utility::_ID15611( "specialty_noplayertarget", 0 );
    maps\mp\_utility::_ID15611( "specialty_blindeye", 0 );
}

_ID34771( var_0 )
{
    level._ID2507["pirate"] = level._ID2507["squadmate"];

    if ( maps\mp\agents\_agent_utility::getnumactiveagents( "squadmate" ) >= 5 )
    {
        self iprintlnbold( &"KILLSTREAKS_AGENT_MAX" );
        return 0;
    }

    if ( maps\mp\agents\_agent_utility::getnumownedactiveagents( self ) >= 2 )
        return 0;

    var_1 = maps\mp\agents\_agent_utility::getvalidspawnpathnodenearplayer( 1 );

    if ( !isdefined( var_1 ) )
        return 0;

    var_2 = var_1.origin;
    var_3 = var_1.angles;
    var_4 = maps\mp\agents\_agents::add_humanoid_agent( "pirate", self.team, "reconAgent", var_2, var_3, self, 0, 0, "veteran" );

    if ( !isdefined( var_4 ) )
        return 0;

    var_4 maps\mp\_utility::_ID15611( "specialty_blindeye", 0 );
    var_4._ID19272 = "agent";
    return var_4;
}

agentdeathevents()
{
    self waittill( "death" );
    var_0 = self.origin;
    playsoundatpos( var_0, "zulu_mariachi_death" );
    playfx( level._ID1644["vfx_squadmate_spawn_burst"], var_0 );
}

deathmariachicreatefunc( var_0 )
{
    self.isjuggernautlevelcustom = 1;
    thread deathmariachisounds();
    maps\mp\gametypes\_class::giveloadout( self.pers["team"], var_0, 0 );
    thread deathmariachibeginmusic();
    thread onjuggdeathmariachienemykilled();
    thread onjuggdeathmariachideath();
    thread reaperspiritwalking();
    self.canusekillstreakcallback = ::juggdeathmariachicanusekillstreak;
    self.killstreakerrormsg = ::juggdeathmariachikillsteakerrormsg;
    self._ID21667 = 1.05;
    self.healthregendisabled = 1;
    self._ID6089 = 0;
    thread maps\mp\_utility::_ID32672( "used_juggernaut_death_mariachi", self );
    return 0;
}

setjuggdeathmariachiclass( var_0 )
{
    var_1 = [];
    var_1["loadoutPrimary"] = "iw6_mariachimagnum";
    var_1["loadoutPrimaryBuff"] = "specialty_null";
    var_1["loadoutPrimaryAttachment"] = "akimbo";
    var_1["loadoutSecondary"] = "none";
    var_1["loadoutEquipment"] = "specialty_null";
    return var_1;
}

setjuggdeathmariachi()
{
    if ( isdefined( self._ID16458 ) )
    {
        self detach( self._ID16458, "" );
        self._ID16458 = undefined;
    }

    self setmodel( "mp_mariachi" );
    self setviewmodel( "viewhands_mp_mariachi" );
    self setclothtype( "nylon" );
}

juggdeathmariachicanusekillstreak( var_0 )
{
    return 0;
}

juggdeathmariachikillsteakerrormsg()
{
    self iprintlnbold( &"MP_ZULU_NO_KILLSTREAKS" );
}

reaperspiritwalking()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );

    if ( self.isjuggernautlevelcustom )
    {
        thread zulu_killstreak();
        self.spiritwalking = 1;
        self setmodel( "mp_mariachi" );
        self setviewmodel( "viewhands_mp_mariachi" );

        if ( isdefined( self._ID16458 ) )
        {
            self detach( self._ID16458, "" );
            self._ID16458 = undefined;
        }

        playfxontag( level._ID1644["vfx_death_smoke_runner"], self, "tag_origin" );

        if ( issplitscreen() )
        {
            var_0 = ( 235.004, 521.706, 1.95469 );
            var_1 = ( 270, 0, 0 );
            var_2 = anglestoup( var_1 );
            var_3 = anglestoforward( var_1 );
            level.scrnfxss = spawnfxforclient( level._ID1644["vfx_scrnfx_spirit_vision_split"], var_0, self, var_3, var_2 );
            triggerfx( level.scrnfxss );
        }
        else
        {
            var_4 = ( 235.004, 521.706, 1.95469 );
            var_5 = ( 270, 0, 0 );
            var_6 = anglestoup( var_5 );
            var_7 = anglestoforward( var_5 );
            level.scrnfx = spawnfxforclient( level._ID1644["vfx_scrnfx_spirit_vision"], var_4, self, var_7, var_6 );
            triggerfx( level.scrnfx );
        }

        self visionsetnakedforplayer( "mp_zulu_spiritwalk", 0.1 );
        thread visionset_watcher_for_mariachi();
        thread visionset_watcher_for_spectate();
        thread visionset_watcher_for_game_end();
    }
}

visionset_watcher_for_mariachi()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "emp_used" );
        wait 1.0;
        self visionsetnakedforplayer( "mp_zulu_spiritwalk", 0.1 );
    }
}

visionset_watcher_for_spectate()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        maps\mp\_utility::set_visionset_for_watching_players( "mp_zulu_spiritwalk", 0.1, 5 );
        wait 0.2;
    }
}

visionset_watcher_for_game_end()
{
    self endon( "death" );
    self endon( "disconnect" );
    level waittill( "game_ended" );
    self visionsetnakedforplayer( "mp_zulu", 0.1 );

    if ( issplitscreen() )
    {
        if ( isdefined( level.scrnfxss ) )
            level.scrnfxss delete();
    }
    else if ( isdefined( level.scrnfx ) )
        level.scrnfx delete();
}

tryusejuggernautdeathmariachi( var_0, var_1 )
{
    maps\mp\killstreaks\_juggernaut::givejuggernaut( var_1 );
    game["player_holding_level_killstrek"] = 0;
    return 1;
}

enable_level_killstreak()
{
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "juggernaut_death_mariachi", 85 );
}

disable_level_killstreak()
{
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "juggernaut_death_mariachi", 0 );
}

mariachicustomcratefunc()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    if ( !maps\mp\_utility::allowlevelkillstreaks() || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "juggernaut_death_mariachi", 85, maps\mp\killstreaks\_airdrop::_ID18982, maps\mp\killstreaks\_airdrop::get_friendly_juggernaut_crate_model(), maps\mp\killstreaks\_airdrop::_ID14446(), &"MP_ZULU_JUGGERNAUT_DEATH_PICKUP" );
    level thread watch_for_death_mariachi_crate();
}

watch_for_death_mariachi_crate()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "juggernaut_death_mariachi" )
        {
            disable_level_killstreak();
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
                enable_level_killstreak();
            else
            {
                game["player_holding_level_killstrek"] = 1;
                wait_for_killstreak_availability();
            }
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

wait_for_killstreak_availability()
{
    level endon( "game_ended" );

    for (;;)
    {
        if ( isdefined( game["player_holding_level_killstrek"] ) && !game["player_holding_level_killstrek"] && !level.muerto_active )
        {
            enable_level_killstreak();
            break;
        }

        wait 5.0;
    }
}

killstreak_lottery()
{
    level endon( "game_ended" );

    while ( !isdefined( level.players ) )
        wait 0.05;

    while ( level.players.size < 1 )
        wait 0.05;

    for (;;)
    {
        wait 10;

        if ( !isdefined( game["player_holding_level_killstrek"] ) )
            game["player_holding_level_killstrek"] = 0;

        var_0 = common_scripts\utility::_ID25350( level.players );

        if ( var_0.hasdonecombat )
        {
            var_0 maps\mp\killstreaks\_juggernaut::givejuggernaut( "juggernaut_death_mariachi" );

            while ( isalive( var_0 ) )
                wait 5.0;
        }
    }
}

mariachicustomkillstreakfunc()
{
    level._ID19256["juggernaut_death_mariachi"] = ::tryusejuggernautdeathmariachi;
    level._ID19276["pirate_agent_mp"] = "juggernaut_death_mariachi";
}

mariachicustombotkillstreakfunc()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "juggernaut_death_mariachi", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

deathmariachisounds()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );
    self playlocalsound( "zulu_mariachi_activate" );

    for (;;)
    {
        wait(randomintrange( 7, 10 ));
        maps\mp\_utility::playplayerandnpcsounds( self, "zulu_ghost_voice_plr", "zulu_ghost_voice_npc" );
    }
}

deathmariachibotsounds()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );

    for (;;)
    {
        wait(randomintrange( 7, 10 ));
        self playsoundonmovingent( "zulu_ghost_voice_npc" );
    }
}

onjuggdeathmariachienemykilled()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "killed_enemy",  var_0, var_1  );

        if ( var_1 == "iw6_mariachimagnum_mp_akimbo" )
            thread deathmariachikilleffect( var_0 );
    }
}

deathmariachikilleffect( var_0 )
{
    var_1 = var_0.origin + ( 0, 0, 50 );
    wait 0.05;
    playfx( level._ID1644["vfx_squadmate_spawn_burst"], var_1 );
}

onjuggdeathmariachideath()
{
    level endon( "game_ended" );
    thread deathmariachimusicendoflevel();
    common_scripts\utility::_ID35626( "death", "disconnect" );

    if ( isdefined( self ) )
    {
        playfx( level._ID1644["vfx_mariachi_player_death"], self.origin );

        if ( issplitscreen() )
        {
            if ( isdefined( level.scrnfxss ) )
                level.scrnfxss delete();
        }
        else if ( isdefined( level.scrnfx ) )
            level.scrnfx delete();

        maps\mp\_utility::playplayerandnpcsounds( self, "zulu_mariachi_death_plr", "zulu_mariachi_death" );
        self.spiritwalking = 0;
        self visionsetnakedforplayer( "mp_zulu", 0.1 );
        self.healthregendisabled = 0;
    }

    game["player_holding_level_killstrek"] = 0;
    level.muerto_active = 0;

    foreach ( var_1 in level.agentarray )
    {
        if ( !isdefined( var_1 ) )
            continue;

        if ( var_1.agent_type == "pirate" && isdefined( var_1.agent_is_mariachi ) )
            var_1 suicide();
    }

    thread deathmariachiendmusic();
}

deathmariachimusicendoflevel()
{
    self endon( "death" );
    self endon( "disconnect" );
    level waittill( "game_ended" );
    thread deathmariachiendmusic();
}

deathmariachibeginmusic()
{
    wait 1.2;
    level.mariachimusicent = spawn( "script_origin", ( 0, 0, 0 ) );
    level.mariachimusicent playloopsound( "killstreak_death_mariachi_music" );
    level.mariachidroneent = spawn( "script_origin", ( 0, 0, 0 ) );
    level.mariachidroneent playloopsound( "zulu_ghost_drone" );
}

deathmariachiendmusic()
{
    level.mariachidroneent stoploopsound();
    level.mariachimusicent stoploopsound();
    maps\mp\_utility::_ID24645( "killstreak_death_mariachi_music_end" );
    thread start_ambient_music();
    thread maps\mp\gametypes\_music_and_dialog::enablemusic();
    common_scripts\utility::_ID35582();
    level.mariachidroneent delete();
    level.mariachidroneent = undefined;
    level.mariachimusicent delete();
    level.mariachimusicent = undefined;
}

zulu_breach_init()
{
    wait 0.5;
    var_0 = common_scripts\utility::_ID15386( "breach", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = getnodearray( var_2.target, "targetname" );

        foreach ( var_5 in var_3 )
            var_5 disconnectnode();
    }

    var_8 = common_scripts\utility::_ID15386( "breach_proxy", "targetname" );

    foreach ( var_5 in var_8 )
    {
        if ( !isdefined( var_5.target ) )
            continue;

        var_2 = common_scripts\utility::_ID15384( var_5.target, "targetname" );

        if ( !isdefined( var_2 ) )
            continue;

        var_0[var_0.size] = var_2;
    }

    common_scripts\utility::_ID3867( var_0, ::zulu_breach_update );
}

zulu_breach_update()
{
    if ( !( level._ID14086 == "gun" ) && !( level._ID14086 == "sotf_ffa" ) && !( level._ID14086 == "horde" ) && !( level._ID14086 == "sotf" ) && !( level._ID14086 == "infect" ) )
    {
        self waittill( "breach_activated" );
        var_0 = 0.5;
        var_1 = 0.5;
        var_2 = 200;

        if ( isdefined( self._ID27542 ) )
            var_0 = self._ID27542;

        if ( isdefined( self._ID27906 ) )
            var_1 = self._ID27906;

        if ( isdefined( self.radius ) )
            var_2 = self.radius;

        earthquake( var_0, var_1, self.origin, var_2 );
    }

    var_3 = getnodearray( self.target, "targetname" );

    foreach ( var_5 in var_3 )
        var_5 connectnode();
}

nuke_custom_visionset()
{
    level waittill( "nuke_death" );
    wait 1.3;
    level notify( "nuke_death" );
    thread nuke_custom_visionset();
}

nukedeathvision()
{
    level._ID22379 = "aftermath_mp_zulu";
    setexpfog( 512, 4097, 0.578828, 0.802656, 1, 0.75, 0.75, 5, 0.382813, 0.350569, 0.293091, 3, ( 1, -0.109979, 0.267867 ), 0, 80, 1, 0.179688, 26, 180 );
    visionsetnaked( level._ID22379, 5 );
    visionsetpain( level._ID22379 );
}

get_float_speaker_scriptables()
{
    wait 3;
    level.speakercount = 0;
    var_0 = getscriptablearray( "speakers", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::wait_for_speaker_deaths );
}

wait_for_speaker_deaths()
{
    self waittill( "death" );
    level.speakercount++;

    if ( level.speakercount >= 6 )
        thread stop_float_audio();
}

stop_float_audio()
{
    level.float_music_enabled = 0;
    thread common_scripts\utility::_ID23839( "zulu_speaker_power_down", ( 304, 707, 103 ) );
    stop_ambient_music();
}
