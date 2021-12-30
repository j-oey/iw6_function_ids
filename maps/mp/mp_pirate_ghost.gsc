// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID1644["ghost_spawn"] = loadfx( "vfx/moments/mp_pirate/vfx_pirate_ghost_vapor" );
    level._ID1644["ghost_trail"] = loadfx( "vfx/moments/mp_pirate/vfx_pirate_ghost_vapor_trail" );
    level._ID1644["ghost_blink"] = loadfx( "vfx/moments/mp_pirate/vfx_ghost_power_drain" );
}

_ID29168()
{
    level._ID2507["pirate"] = level._ID2507["squadmate"];
    level._ID2507["pirate"]["spawn"] = ::spawn_agent_ghost;
    level._ID2507["pirate"]["think"] = ::_ID31127;
    level._ID2507["pirate"]["on_killed"] = ::on_agent_squadmate_killed;
}

_ID8769()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    if ( !maps\mp\_utility::allowlevelkillstreaks() || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "pirate_ghostcrew", 85, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"MP_PIRATE_GHOSTCREW_USE" );
    level thread watchforcrateuse();
}

watchforcrateuse()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "pirate_ghostcrew" )
        {
            maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "pirate_ghostcrew", 0 );
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "pirate_ghostcrew", 85 );
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
    level._ID19256["pirate_ghostcrew"] = ::tryuseagentkillstreak;
    level._ID19276["pirate_agent_mp"] = "pirate_ghostcrew";
}

cusombotkillstreakfunc()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "pirate_ghostcrew", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

tryuseagentkillstreak( var_0, var_1 )
{
    _ID29168();
    self.ghostcount = 0;

    if ( spawnghost() )
    {
        thread playghostmusic();
        thread delayedspawnghost();
        thread maps\mp\_utility::_ID32672( "used_" + var_1, self );
        return 1;
    }
    else
        return 0;
}

createsquadmate( var_0 )
{
    if ( maps\mp\agents\_agent_utility::getnumactiveagents( "squadmate" ) >= 5 )
    {
        self iprintlnbold( &"KILLSTREAKS_AGENT_MAX" );
        return undefined;
    }

    if ( maps\mp\agents\_agent_utility::getnumownedactiveagents( self ) >= 2 )
    {
        self iprintlnbold( &"KILLSTREAKS_AGENT_MAX" );
        return undefined;
    }

    var_1 = maps\mp\agents\_agent_utility::getvalidspawnpathnodenearplayer( 0, 1 );

    if ( !isdefined( var_1 ) )
        return undefined;

    var_2 = var_1.origin;
    var_3 = vectortoangles( self.origin - var_1.origin );
    var_4 = maps\mp\agents\_agents::add_humanoid_agent( "pirate", self.team, "reconAgent", var_2, var_3, self, 0, 0, "veteran" );

    if ( !isdefined( var_4 ) )
    {
        self iprintlnbold( &"KILLSTREAKS_AGENT_MAX" );
        return 0;
    }

    var_4._ID19272 = "agent";
    return var_4;
}

spawn_agent_ghost( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "disconnect" );

    while ( !isdefined( level.getspawnpoint ) )
        common_scripts\utility::_ID35582();

    if ( self.hasdied )
        wait(randomintrange( 6, 10 ));

    maps\mp\agents\_agent_utility::_ID17986( 1 );

    if ( isdefined( var_0 ) && isdefined( var_1 ) )
    {
        var_6 = var_0;
        var_7 = var_1;
        self._ID19613 = spawnstruct();
        self._ID19613.origin = var_6;
        self._ID19613.angles = var_7;
    }
    else
    {
        var_8 = self [[ level.getspawnpoint ]]();
        var_6 = var_8.origin;
        var_7 = var_8.angles;
        self._ID19613 = var_8;
    }

    maps\mp\agents\_agent_utility::activateagent();
    self.lastspawntime = gettime();
    self._ID30916 = gettime();
    var_9 = var_6 + ( 0, 0, 25 );
    var_10 = var_6;
    var_11 = playerphysicstrace( var_9, var_10 );

    if ( distancesquared( var_11, var_9 ) > 1 )
        var_6 = var_11;

    self spawnagent( var_6, var_7 );
    maps\mp\bots\_bots_util::bot_set_personality( "cqb" );

    if ( isdefined( var_5 ) )
        maps\mp\bots\_bots_util::bot_set_difficulty( var_5 );

    maps\mp\agents\_agents::_ID17984();
    maps\mp\agents\_agent_common::_ID28188( 200 );

    if ( isdefined( var_4 ) && var_4 )
        self._ID26157 = 1;

    if ( isdefined( var_2 ) )
        maps\mp\agents\_agent_utility::_ID28189( var_2.team, var_2 );

    if ( isdefined( self.owner ) )
        thread maps\mp\agents\_agents::_ID9815( self.owner );

    thread maps\mp\_flashgrenades::_ID21388();
    self enableanimstate( 0 );
    self [[ level._ID22902 ]]();
    maps\mp\_utility::_ID15611( "specialty_blindeye", 0 );
    maps\mp\gametypes\_class::giveloadout( self.team, self.class, 1 );
    var_12 = isdefined( self.owner ) && isdefined( self.owner.ghostcount ) && self.owner.ghostcount % 2 != 0;
    customizesquadmate( var_12 );
    thread maps\mp\bots\_bots::bot_think_watch_enemy( 1 );
    thread maps\mp\bots\_bots_strategy::bot_think_tactical_goals();
    self thread [[ maps\mp\agents\_agent_utility::agentfunc( "think" ) ]]();

    if ( !self.hasdied )
        maps\mp\gametypes\_spawnlogic::addtoparticipantsarray();

    self.hasdied = 0;
    thread maps\mp\gametypes\_weapons::onplayerspawned();
    thread maps\mp\gametypes\_healthoverlay::_ID24499();
    level notify( "spawned_agent_player",  self  );
    level notify( "spawned_agent",  self  );
    self notify( "spawned_player" );
}

_ID31127()
{
    self endon( "death" );
    level endon( "game_ended" );

    if ( isdefined( self.owner ) )
        self endon( "owner_disconnect" );

    for (;;)
    {
        self botsetflag( "cautious", 1 );
        var_0 = self [[ maps\mp\agents\_agent_utility::agentfunc( "gametype_update" ) ]]();

        if ( !var_0 )
        {
            if ( !maps\mp\bots\_bots_util::bot_is_guarding_player( self.owner ) )
                maps\mp\bots\_bots_strategy::bot_guard_player( self.owner, 350 );
        }

        wait 0.05;
    }
}

on_agent_squadmate_killed( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    maps\mp\agents\_agents::_ID22757( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0 );
    var_9 = self gettagorigin( "j_mainroot" );
    var_10 = anglestoforward( self.angles );
    var_11 = self getcorpseentity();

    if ( var_3 == "MOD_MELEE" )
        wait 0.75;
    else
        wait 0.5;

    maps\mp\agents\_agent_utility::_ID9023();

    if ( isplayer( var_1 ) && isdefined( self.owner ) && var_1 != self.owner )
        maps\mp\gametypes\_damage::onkillstreakkilled( var_1, var_4, var_3, var_2 );

    if ( isdefined( self.hat ) )
        self.hat delete();

    playfx( common_scripts\utility::_ID15033( "ghost_spawn" ), var_9, var_10 );
    var_11 playsound( "pir_ghost_death" );
    var_11 delete();
}

customizesquadmate( var_0 )
{
    if ( var_0 )
        self setmodel( "pirate_ghost_2" );
    else
        self setmodel( "pirate_ghost_1" );

    if ( isdefined( self._ID16458 ) )
    {
        self detach( self._ID16458, "" );
        self._ID16458 = undefined;
    }

    self playsound( "pir_ghost_reappear" );
    var_1 = self gettagorigin( "j_mainroot" );
    playfx( common_scripts\utility::_ID15033( "ghost_spawn" ), var_1, anglestoforward( self.angles ) );
    thread playtrailfx();
    self takeallweapons();

    if ( var_0 )
    {
        self giveweapon( "iw6_piratehook_mp" );
        self switchtoweapon( "iw6_piratehook_mp" );
        self botsetflag( "prefer_melee", 1 );
    }
    else
    {
        self giveweapon( "iw6_pirategun_mp_akimbo" );
        self switchtoweapon( "iw6_pirategun_mp_akimbo" );
    }

    maps\mp\_utility::_ID15611( "specialty_spygame", 0 );
    maps\mp\_utility::_ID15611( "specialty_coldblooded", 0 );
    maps\mp\_utility::_ID15611( "specialty_noscopeoutline", 0 );
    maps\mp\_utility::_ID15611( "specialty_heartbreaker", 0 );
    maps\mp\_utility::_ID15611( "specialty_quieter", 0 );
    givehat();
    self.health = 300;
    self setsurfacetype( "snow" );
    maps\mp\gametypes\_battlechatter_mp::disablebattlechatter( self );
    thread watchblink2();
    thread ghostplayvo( self.owner.ghostcount );
}

givehat()
{
    var_0 = spawn( "script_model", self.origin );
    var_0 setmodel( "pirate_hat_iw6_ghost" );
    var_0 linkto( self, "j_head", ( 4, 0, 0 ), ( 90, 0, 0 ) );
    self.hat = var_0;
}

playtrailfx()
{
    self endon( "death" );
    level endon( "game_ended" );
    wait 0.25;
    playfxontag( common_scripts\utility::_ID15033( "ghost_trail" ), self, "j_mainroot" );
}

playghostmusic()
{
    playsoundatpos( ( 878.641, 1408.98, 203 ), "mus_drunk_sailor" );
}

spawnghost()
{
    var_0 = createsquadmate( self );

    if ( isdefined( var_0 ) )
    {
        self.ghostcount++;

        if ( self.ghostcount >= 10 )
            level notify( "ghost_end" );

        return 1;
    }

    return 0;
}

delayedspawnghost()
{
    wait 0.5;
    spawnghost();
}

ghostcloak()
{
    self.iscloaked = 1;
    var_0 = self gettagorigin( "j_mainroot" );
    playfx( common_scripts\utility::_ID15033( "ghost_blink" ), var_0, anglestoforward( self.angles ) );
    self playsound( "pir_ghost_disappear" );
    self.oldmodel = self.model;
    self setmodel( self.oldmodel + "_cloak" );
    self.hat setmodel( "pirate_hat_iw6_ghost_cloak" );
}

ghostuncloak()
{
    var_0 = self gettagorigin( "j_mainroot" );
    playfx( common_scripts\utility::_ID15033( "ghost_blink" ), var_0, anglestoforward( self.angles ) );
    self playsound( "pir_ghost_reappear" );
    self setmodel( self.oldmodel );
    self.hat setmodel( "pirate_hat_iw6_ghost" );
    self.iscloaked = undefined;
}

watchblink2()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "damage" );

        if ( !isdefined( self.iscloaked ) )
            ghostcloak();

        thread ghostwaitforuncloak();
    }
}

ghostwaitforuncloak()
{
    self notify( "ghostDamageTimer" );
    self endon( "ghostDamageTimer" );
    self endon( "death" );
    wait 4.0;
    ghostuncloak();
}

ghostplayvo( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_1 = [ "mp_pirate_prt1_ghost", "mp_pirate_prt2_ghost", "mp_pirate_cpt_ghost" ];

    if ( !isdefined( var_0 ) )
        var_0 = randomint( 0, var_1.size );
    else
        var_0 %= var_1.size;

    var_2 = var_1[var_0];
    self.owner.ghostvotimestamp = gettime() + 1000;

    while ( isdefined( self.owner ) )
    {
        self.owner waittill( "killed_enemy",  var_3, var_4, var_5  );

        if ( var_4 == "pirate_agent_mp" && gettime() > self.owner.ghostvotimestamp )
        {
            self.owner.ghostvotimestamp = gettime() + 2000;
            self playsound( var_2 );
        }
    }
}
