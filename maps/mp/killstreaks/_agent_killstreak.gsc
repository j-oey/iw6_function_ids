// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["agent"] = ::_ID33877;
    level._ID19256["recon_agent"] = ::_ID33864;
}

_ID28940()
{
    level._ID2507["squadmate"] = level._ID2507["player"];
    level._ID2507["squadmate"]["think"] = ::_ID31127;
    level._ID2507["squadmate"]["on_killed"] = ::on_agent_squadmate_killed;
    level._ID2507["squadmate"]["on_damaged"] = maps\mp\agents\_agents::_ID22743;
    level._ID2507["squadmate"]["gametype_update"] = ::_ID22047;
}

_ID22047()
{
    return 0;
}

_ID33877( var_0, var_1 )
{
    return _ID34771( "agent" );
}

_ID33864( var_0, var_1 )
{
    return _ID34771( "reconAgent" );
}

_ID34771( var_0 )
{
    if ( maps\mp\agents\_agent_utility::getnumactiveagents( "squadmate" ) >= 5 )
    {
        self iprintlnbold( &"KILLSTREAKS_AGENT_MAX" );
        return 0;
    }

    if ( maps\mp\agents\_agent_utility::getnumownedactiveagents( self ) >= 2 )
    {
        self iprintlnbold( &"KILLSTREAKS_AGENT_MAX" );
        return 0;
    }

    var_1 = maps\mp\agents\_agent_utility::getvalidspawnpathnodenearplayer( 0, 1 );

    if ( !isdefined( var_1 ) )
        return 0;

    if ( !maps\mp\_utility::_ID18757( self ) )
        return 0;

    var_2 = var_1.origin;
    var_3 = vectortoangles( self.origin - var_1.origin );
    var_4 = maps\mp\agents\_agents::add_humanoid_agent( "squadmate", self.team, undefined, var_2, var_3, self, 0, 0, "veteran" );

    if ( !isdefined( var_4 ) )
    {
        self iprintlnbold( &"KILLSTREAKS_AGENT_MAX" );
        return 0;
    }

    var_4._ID19272 = var_0;

    if ( var_4._ID19272 == "reconAgent" )
    {
        var_4 thread _ID28060( "iw6_riotshield_mp" );
        var_4 thread _ID12960();
        var_4 thread maps\mp\gametypes\_class::giveloadout( self.pers["team"], "reconAgent", 0 );
        var_4 maps\mp\agents\_agent_common::_ID28188( 250 );
        var_4 maps\mp\perks\_perkfunctions::_ID28771();
    }
    else
        var_4 maps\mp\perks\_perkfunctions::_ID28771();

    var_4 maps\mp\_utility::_setnameplatematerial( "player_name_bg_green_agent", "player_name_bg_red_agent" );
    maps\mp\_matchdata::_ID20253( var_4._ID19272, self.origin );
    return 1;
}

_ID12960()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "giveLoadout" );
    maps\mp\perks\_perkfunctions::_ID28771();
    maps\mp\_utility::_ID15611( "specialty_quickswap", 0 );
    maps\mp\_utility::_ID15611( "specialty_regenfaster", 0 );
    self botsetdifficultysetting( "minInaccuracy", 1.5 * self botgetdifficultysetting( "minInaccuracy" ) );
    self botsetdifficultysetting( "maxInaccuracy", 1.5 * self botgetdifficultysetting( "maxInaccuracy" ) );
    self botsetdifficultysetting( "minFireTime", 1.5 * self botgetdifficultysetting( "minFireTime" ) );
    self botsetdifficultysetting( "maxFireTime", 1.25 * self botgetdifficultysetting( "maxFireTime" ) );
}

_ID28060( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "giveLoadout" );

    if ( !isdefined( var_0 ) )
        var_0 = "iw6_riotshield_mp";

    self notify( "weapon_change",  var_0  );
}

_ID31127()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "owner_disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self botsetflag( "prefer_shield_out", 1 );
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

    if ( isplayer( var_1 ) && isdefined( self.owner ) && var_1 != self.owner )
    {
        self.owner maps\mp\_utility::_ID19765( "squad_killed" );
        maps\mp\gametypes\_damage::onkillstreakkilled( var_1, var_4, var_3, var_2, "destroyed_squad_mate" );
    }

    maps\mp\agents\_agent_utility::_ID9023();
}
