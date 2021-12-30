// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{

}

_ID29168()
{
    level._ID2507["beastmen"] = level._ID2507["squadmate"];
    level._ID2507["beastmen"]["spawn"] = ::spawn_agent_beast;
    level._ID2507["beastmen"]["think"] = ::_ID31127;
    level._ID2507["beastmen"]["on_killed"] = ::on_agent_squadmate_killed;
}

tryuseagentkillstreak( var_0, var_1 )
{
    _ID29168();
    self.beastcount = 0;
    thread delayedspawnbeast( 5 );
    return 1;
}

spawnbeast()
{
    var_0 = createsquadmate();

    if ( isdefined( var_0 ) )
    {
        self.beastcount++;

        if ( self.beastcount < 3 )
            thread delayedspawnbeast( 0.5 );

        return 1;
    }

    return 0;
}

delayedspawnbeast( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait(var_0);
    spawnbeast();
}

createsquadmate( var_0 )
{
    var_1 = findspawnlocation();

    if ( isdefined( var_0 ) )
        var_1 = var_0;

    var_2 = vectortoangles( self.origin - var_1 );
    var_3 = maps\mp\agents\_agents::add_humanoid_agent( "beastmen", self.team, "reconAgent", var_1, var_2, self, 0, 0, "veteran" );

    if ( !isdefined( var_3 ) )
    {
        self iprintlnbold( &"KILLSTREAKS_AGENT_MAX" );
        return 0;
    }

    var_3._ID19272 = "agent";
    return var_3;
}

spawn_agent_beast( var_0, var_1, var_2, var_3, var_4, var_5 )
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
    maps\mp\agents\_agent_common::_ID28188( 500 );

    if ( isdefined( var_4 ) && var_4 )
        self._ID26157 = 1;

    if ( isdefined( var_2 ) )
        maps\mp\agents\_agent_utility::_ID28189( var_2.team, var_2 );

    if ( isdefined( self.owner ) )
        thread maps\mp\agents\_agents::_ID9815( self.owner );

    thread maps\mp\_flashgrenades::_ID21388();
    self enableanimstate( 0 );
    self [[ level._ID22902 ]]();
    maps\mp\gametypes\_class::giveloadout( self.team, self.class, 1 );
    customizesquadmate();
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
    self.environmentstate = "outdoors";
    thread delaysoundfx( "zerosub_monster_breath_only_lp", 0.05 );
    thread delaysoundfx( "zerosub_monster_steps_only_ext_lp", 0.1 );
    thread delayplayfxontag( level._ID1644["vfx_yeti_snowcover_upflip"], "tag_origin", 0.05, 0.5 );
    playeyefx();
    thread watchbeastmovement();
    thread watchkillstreakend();
}

_ID31127()
{
    self endon( "death" );
    level endon( "game_ended" );

    if ( isdefined( self.owner ) )
        self endon( "owner_disconnect" );

    self botsetflag( "force_sprint", 1 );
}

on_agent_squadmate_killed( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    maps\mp\agents\_agents::_ID22757( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0 );
    var_9 = self getcorpseentity();
    playfx( level._ID1644["vfx_yeti_snowcover_dissolve"], self.origin );
    self playsound( "mp_zerosub_monster_death" );

    if ( var_3 == "MOD_MELEE" )
        wait 0.75;
    else
        wait 0.5;

    maps\mp\agents\_agent_utility::_ID9023();

    if ( isplayer( var_1 ) && isdefined( self.owner ) && var_1 != self.owner )
        maps\mp\gametypes\_damage::onkillstreakkilled( var_1, var_4, var_3, var_2, "destroyed_ks_beast_man" );

    var_9 delete();
}

customizesquadmate()
{
    self setmodel( "mp_fullbody_beast_man" );

    if ( isdefined( self._ID16458 ) )
    {
        self detach( self._ID16458, "" );
        self._ID16458 = undefined;
    }

    playfx( level._ID1644["vfx_yeti_snowcover_upflip"], self.origin );
    var_0 = "iw6_knifeonlybeast_mp";
    self takeallweapons();
    self giveweapon( var_0 );
    self switchtoweapon( var_0 );
    self botsetflag( "prefer_melee", 1 );
    maps\mp\_utility::_ID15611( "specialty_spygame", 0 );
    maps\mp\_utility::_ID15611( "specialty_coldblooded", 0 );
    maps\mp\_utility::_ID15611( "specialty_noscopeoutline", 0 );
    maps\mp\_utility::_ID15611( "specialty_heartbreaker", 0 );
    maps\mp\_utility::_ID15611( "specialty_quieter", 0 );
    thread watchremoveperks();
    self.health = 500;
    self.custommeleedamagetaken = 100;
    self setsurfacetype( "snow" );
    maps\mp\gametypes\_battlechatter_mp::disablebattlechatter( self );
}

watchremoveperks()
{
    self endon( "death" );
    level endon( "game_over" );
    self waittill( "starting_perks_unset" );
    maps\mp\_utility::_ID15611( "specialty_blindeye", 0 );
}

delaysoundfx( var_0, var_1 )
{
    self endon( "death" );
    level endon( "game_ended" );
    wait(var_1);
    self playloopsound( var_0 );
}

delayplayfxontag( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    level endon( "game_ended" );
    wait(var_2);

    for (;;)
    {
        playfxontag( var_0, self, var_1 );

        if ( isdefined( var_3 ) )
        {
            wait(var_3);
            continue;
        }

        break;
    }
}

playeyefx()
{
    var_0 = anglestoforward( self.angles ) * 30;
    var_1 = anglestoright( self.angles ) * 7;
    var_2 = ( 0, 0, 65 );
    thread createeyefx( "left", self.origin + var_0 + var_1 + var_2 );
    thread createeyefx( "right", self.origin + var_0 - var_1 + var_2 );
}

createeyefx( var_0, var_1 )
{
    self endon( "death" );
    level endon( "game_ended" );

    if ( var_0 == "left" )
    {
        self.lefteyeobj = spawn( "script_model", var_1 );
        self.lefteyeobj setmodel( "tag_origin" );
        self.lefteyeobj linkto( self );
        self.lefteyeobj delayplayfxontag( level.zerosub_fx["beast"]["eyeglow"], "tag_origin", 0.05, 0.5 );
    }
    else
    {
        self.righteyeobj = spawn( "script_model", var_1 );
        self.righteyeobj setmodel( "tag_origin" );
        self.righteyeobj linkto( self );
        self.righteyeobj delayplayfxontag( level.zerosub_fx["beast"]["eyeglow"], "tag_origin", 0.05, 0.5 );
    }
}

watchbeastmovement()
{
    level endon( "game_ended" );
    level endon( "frost_clear" );

    for (;;)
    {
        if ( !maps\mp\mp_zerosub::isoutside() )
        {
            if ( !level.beastallowedindoors )
            {
                var_0 = findspawnlocation( self.origin );

                if ( isdefined( var_0 ) )
                {
                    self dodamage( 10000, self.origin );
                    wait 1;
                    level.zerosub_killstreak_user createsquadmate( var_0 );
                    break;
                }
            }

            if ( self.environmentstate != "indoors" )
            {
                self.environmentstate = "indoors";
                self stopsounds();
                wait 0.3;
                thread delaysoundfx( "zerosub_monster_breath_only_lp", 0.05 );
                thread delaysoundfx( "zerosub_monster_steps_only_int_lp", 0.1 );
            }
        }
        else if ( self.environmentstate != "outdoors" )
        {
            self.environmentstate = "outdoors";
            self stopsounds();
            wait 0.3;
            thread delaysoundfx( "zerosub_monster_breath_only_lp", 0.05 );
            thread delaysoundfx( "zerosub_monster_steps_only_ext_lp", 0.1 );
        }

        common_scripts\utility::_ID35582();
    }
}

findspawnlocation( var_0 )
{
    var_1 = undefined;
    var_2 = common_scripts\utility::_ID15386( "zerosub_beast_spawn", "targetname" );

    if ( !isdefined( var_2 ) || var_2.size == 0 )
        return undefined;

    if ( isdefined( var_0 ) )
    {
        var_3 = undefined;

        foreach ( var_5 in var_2 )
        {
            var_6 = distance2dsquared( var_0, var_5.origin );

            if ( !isdefined( var_3 ) || var_3 < var_6 )
            {
                var_3 = var_6;
                var_1 = var_5.origin;
            }
        }
    }
    else
    {
        var_8 = randomint( var_2.size );
        var_1 = var_2[var_8].origin;
    }

    return var_1;
}

watchkillstreakend()
{
    self endon( "death" );
    level endon( "game_ended" );
    level waittill( "frost_clear" );
    self dodamage( 10000, self.origin );
    self.lefteyeobj delete();
    self.righteyeobj delete();
}
