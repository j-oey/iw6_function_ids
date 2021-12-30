// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    if ( isdefined( level._ID8425 ) && level._ID8425 )
        return;

    _ID28940();
    level.badplace_cylinder_func = ::badplace_cylinder;
    level._ID4645 = ::badplace_delete;
    level thread maps\mp\agents\_agent_common::_ID17631();
    level thread maps\mp\killstreaks\_agent_killstreak::_ID17631();
    level thread maps\mp\killstreaks\_dog_killstreak::_ID17631();
}

_ID28940()
{
    if ( !isdefined( level._ID2507 ) )
        level._ID2507 = [];

    level._ID2507["player"] = [];
    level._ID2507["player"]["spawn"] = ::_ID30565;
    level._ID2507["player"]["think"] = maps\mp\bots\_bots_gametype_war::bot_war_think;
    level._ID2507["player"]["on_killed"] = ::_ID22744;
    level._ID2507["player"]["on_damaged"] = ::_ID22743;
    level._ID2507["player"]["on_damaged_finished"] = ::agent_damage_finished;
    maps\mp\killstreaks\_agent_killstreak::_ID28940();
    maps\mp\killstreaks\_dog_killstreak::_ID28940();
}

_ID35509()
{
    while ( !isdefined( level._ID2507 ) )
        wait 0.05;
}

add_humanoid_agent( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = maps\mp\agents\_agent_common::_ID7870( var_0, var_1, var_2 );

    if ( isdefined( var_9 ) )
        var_9 thread [[ var_9 maps\mp\agents\_agent_utility::agentfunc( "spawn" ) ]]( var_3, var_4, var_5, var_6, var_7, var_8 );

    return var_9;
}

_ID30565( var_0, var_1, var_2, var_3, var_4, var_5 )
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

    if ( isdefined( var_3 ) && var_3 )
        maps\mp\bots\_bots_personality::_ID5500();
    else
        maps\mp\bots\_bots_util::bot_set_personality( "default" );

    if ( isdefined( var_5 ) )
        maps\mp\bots\_bots_util::bot_set_difficulty( var_5 );

    _ID17984();
    maps\mp\agents\_agent_common::_ID28188( 100 );

    if ( isdefined( var_4 ) && var_4 )
        self._ID26157 = 1;

    if ( isdefined( var_2 ) )
        maps\mp\agents\_agent_utility::_ID28189( var_2.team, var_2 );

    if ( isdefined( self.owner ) )
        thread _ID9815( self.owner );

    thread maps\mp\_flashgrenades::_ID21388();
    self enableanimstate( 0 );
    self [[ level._ID22902 ]]();
    maps\mp\gametypes\_class::giveloadout( self.team, self.class, 1 );
    thread maps\mp\bots\_bots::bot_think_watch_enemy( 1 );
    thread maps\mp\bots\_bots::bot_think_crate();

    if ( self.agent_type == "player" )
        thread maps\mp\bots\_bots::_ID5808();
    else if ( self.agent_type == "odin_juggernaut" )
        thread maps\mp\bots\_bots::_ID5808( 128 );

    thread maps\mp\bots\_bots_strategy::bot_think_tactical_goals();
    self thread [[ maps\mp\agents\_agent_utility::agentfunc( "think" ) ]]();

    if ( !self.hasdied )
        maps\mp\gametypes\_spawnlogic::addtoparticipantsarray();

    self.hasdied = 0;
    thread maps\mp\gametypes\_weapons::onplayerspawned();
    thread maps\mp\gametypes\_healthoverlay::_ID24499();
    thread maps\mp\gametypes\_battlechatter_mp::onplayerspawned();
    level notify( "spawned_agent_player",  self  );
    level notify( "spawned_agent",  self  );
    self notify( "spawned_player" );
}

_ID9815( var_0 )
{
    self endon( "death" );
    var_0 waittill( "killstreak_disowned" );
    self notify( "owner_disconnect" );

    if ( maps\mp\gametypes\_hostmigration::_ID35770() )
        wait 0.05;

    self suicide();
}

agent_damage_finished( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( isdefined( var_0 ) || isdefined( var_1 ) )
    {
        if ( !isdefined( var_0 ) )
            var_0 = var_1;

        if ( isdefined( self.allowvehicledamage ) && !self.allowvehicledamage )
        {
            if ( isdefined( var_0.classname ) && var_0.classname == "script_vehicle" )
                return 0;
        }

        if ( isdefined( var_0.classname ) && var_0.classname == "auto_turret" )
            var_1 = var_0;

        if ( isdefined( var_1 ) && var_4 != "MOD_FALLING" && var_4 != "MOD_SUICIDE" )
        {
            if ( level._ID32653 )
            {
                if ( isdefined( var_1.team ) && var_1.team != self.team )
                    self setagentattacker( var_1 );
            }
            else
                self setagentattacker( var_1 );
        }
    }

    self finishagentdamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0 );

    if ( !isdefined( self.isactive ) )
        self.waitingtodeactivate = 1;

    return 1;
}

_ID22742( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_10 = isdefined( var_1 ) && isdefined( self.owner ) && self.owner == var_1;
    var_11 = maps\mp\_utility::attackerishittingteam( self.owner, var_1 ) || var_10;

    if ( level._ID32653 && var_11 && !level._ID13683 )
        return 0;

    if ( !level._ID32653 && var_10 )
        return 0;

    if ( isdefined( var_4 ) && var_4 == "MOD_CRUSH" && isdefined( var_0 ) && isdefined( var_0.classname ) && var_0.classname == "script_vehicle" )
        return 0;

    if ( !isdefined( self ) || !maps\mp\_utility::_ID18757( self ) )
        return 0;

    if ( isdefined( var_1 ) && var_1.classname == "script_origin" && isdefined( var_1.type ) && var_1.type == "soft_landing" )
        return 0;

    if ( var_5 == "killstreak_emp_mp" )
        return 0;

    if ( var_5 == "bouncingbetty_mp" && !maps\mp\gametypes\_weapons::_ID21060( var_0, self ) )
        return 0;

    if ( ( var_5 == "throwingknife_mp" || var_5 == "throwingknifejugg_mp" ) && var_4 == "MOD_IMPACT" )
        var_2 = self.health + 1;

    if ( isdefined( var_0 ) && isdefined( var_0.stuckenemyentity ) && var_0.stuckenemyentity == self )
        var_2 = self.health + 1;

    if ( var_2 <= 0 )
        return 0;

    if ( isdefined( var_1 ) && var_1 != self && var_2 > 0 && ( !isdefined( var_8 ) || var_8 != "shield" ) )
    {
        if ( var_3 & level._ID17348 )
            var_12 = "stun";
        else if ( !maps\mp\gametypes\_damage::_ID29906( var_5 ) )
            var_12 = "none";
        else
            var_12 = common_scripts\utility::_ID32831( var_2 >= self.health, "hitkill", "standard" );

        var_1 thread maps\mp\gametypes\_damagefeedback::_ID34528( var_12 );
    }

    if ( isdefined( level._ID21286 ) )
        var_2 = [[ level._ID21286 ]]( self, var_1, var_2, var_4, var_5, var_6, var_7, var_8 );

    return self [[ maps\mp\agents\_agent_utility::agentfunc( "on_damaged_finished" ) ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

_ID22743( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_10 = isdefined( var_1 ) && isdefined( self.owner ) && self.owner == var_1;

    if ( !level._ID32653 && var_10 )
        return 0;

    maps\mp\gametypes\_damage::callback_playerdamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

_ID22744( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    _ID22757( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 1 );

    if ( isplayer( var_1 ) && ( !isdefined( self.owner ) || var_1 != self.owner ) )
        maps\mp\gametypes\_damage::onkillstreakkilled( var_1, var_4, var_3, var_2, "destroyed_squad_mate" );

    maps\mp\gametypes\_weapons::dropscavengerfordeath( var_1 );

    if ( self.isactive )
    {
        self.hasdied = 1;

        if ( maps\mp\_utility::_ID15035() != 1 && ( isdefined( self._ID26157 ) && self._ID26157 ) )
        {
            self thread [[ maps\mp\agents\_agent_utility::agentfunc( "spawn" ) ]]();
            return;
        }

        maps\mp\agents\_agent_utility::_ID9023();
        return;
        return;
    }
}

_ID22757( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( self._ID16417 )
    {
        maps\mp\gametypes\_damage::_ID19712( var_2, var_3 );

        if ( !var_9 )
        {
            var_10 = self dropitem( self getcurrentweapon() );

            if ( isdefined( var_10 ) )
            {
                var_10 thread maps\mp\gametypes\_weapons::deletepickupafterawhile();
                var_10.owner = self;
                var_10.ownersattacker = var_1;
                var_10 makeunusable();
            }
        }
    }

    if ( var_9 )
        self [[ level._ID36261 ]]( var_1, var_3 );

    self._ID5433 = self cloneagent( var_8 );
    thread maps\mp\gametypes\_damage::_ID9517( self._ID5433, var_6, var_5, var_4, var_0, var_3 );
    maps\mp\_utility::_ID26321();
}

_ID17984()
{
    if ( isdefined( self._ID7324 ) )
    {
        self.class = self._ID7324;
        return;
    }

    if ( maps\mp\bots\_bots_loadout::_ID5777() )
    {
        self.class = "callback";
        return;
    }

    self.class = "class1";
    return;
    return;
}
