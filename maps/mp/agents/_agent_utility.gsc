// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

agentfunc( var_0 )
{
    return level._ID2507[self.agent_type][var_0];
}

_ID28189( var_0, var_1 )
{
    self.team = var_0;
    self.agentteam = var_0;
    self.pers["team"] = var_0;
    self.owner = var_1;
    self setotherent( var_1 );
    self setentityowner( var_1 );
}

_ID17878()
{
    self.agent_type = "player";
    self.pers = [];
    self.hasdied = 0;
    self.isactive = 0;
    self.isagent = 1;
    self._ID35917 = 0;
    self._ID18785 = 0;
    self._ID30916 = 0;
    self.entity_number = self getentitynumber();
    self.agent_teamparticipant = 0;
    self.agent_gameparticipant = 0;
    self.canperformclienttraces = 0;
    self.agentname = undefined;
    self detachall();
    _ID17986( 0 );
}

_ID17986( var_0 )
{
    if ( !var_0 )
    {
        self.class = undefined;
        self.lastclass = undefined;
        self._ID21667 = undefined;
        self.avoidkillstreakonspawntimer = undefined;
        self._ID15851 = undefined;
        self.name = undefined;
        self._ID27299 = undefined;
        self._ID23452 = undefined;
        self._ID36267 = undefined;
        self._ID22739 = undefined;
        self.objectivescaler = undefined;
        self._ID33168 = undefined;
        self.carryobject = undefined;
        self.claimtrigger = undefined;
        self.canpickupobject = undefined;
        self.killedinuse = undefined;
        self.sessionteam = undefined;
        self.sessionstate = undefined;
        self.lastspawntime = undefined;
        self._ID19613 = undefined;
        self.disabledweapon = undefined;
        self._ID10155 = undefined;
        self.disabledoffhandweapons = undefined;
        self._ID10153 = undefined;
        self._ID29698 = undefined;
        self._ID29697 = undefined;
        self._ID25599 = undefined;
    }
    else
    {
        self._ID21667 = 1;
        self.avoidkillstreakonspawntimer = 5;
        self._ID15851 = maps\mp\_utility::getuniqueid();
        self.name = self._ID15851;
        self.sessionteam = self.team;
        self.sessionstate = "playing";
        self._ID29698 = 0;
        self._ID29697 = 0;
        self._ID25599 = 0;
        self.agent_gameparticipant = 1;
        maps\mp\gametypes\_playerlogic::_ID29192();
        thread maps\mp\perks\_perks::onplayerspawned();

        if ( maps\mp\_utility::_ID18638( self ) )
        {
            self.objectivescaler = 1;
            maps\mp\gametypes\_gameobjects::_ID17801();
            self.disabledweapon = 0;
            self._ID10155 = 0;
            self.disabledoffhandweapons = 0;
        }
    }

    self._ID10153 = 1;
}

getfreeagent( var_0 )
{
    var_1 = undefined;

    if ( isdefined( level.agentarray ) )
    {
        foreach ( var_3 in level.agentarray )
        {
            if ( !isdefined( var_3.isactive ) || !var_3.isactive )
            {
                if ( isdefined( var_3.waitingtodeactivate ) && var_3.waitingtodeactivate )
                    continue;

                var_1 = var_3;
                var_1 _ID17878();

                if ( isdefined( var_0 ) )
                    var_1.agent_type = var_0;

                break;
            }
        }
    }

    return var_1;
}

activateagent()
{
    self.isactive = 1;
}

_ID9023()
{
    thread _ID9024();
}

_ID9024()
{
    self notify( "deactivateAgentDelayed" );
    self endon( "deactivateAgentDelayed" );

    if ( maps\mp\_utility::_ID18638( self ) )
        maps\mp\gametypes\_spawnlogic::_ID26002();

    maps\mp\gametypes\_spawnlogic::_ID25996();
    wait 0.05;
    self.isactive = 0;
    self.hasdied = 0;
    self.owner = undefined;
    self.connecttime = undefined;
    self.waitingtodeactivate = undefined;

    foreach ( var_1 in level.characters )
    {
        if ( isdefined( var_1.attackers ) )
        {
            foreach ( var_4, var_3 in var_1.attackers )
            {
                if ( var_3 == self )
                    var_1.attackers[var_4] = undefined;
            }
        }
    }

    if ( isdefined( self._ID16458 ) )
    {
        self detach( self._ID16458 );
        self._ID16458 = undefined;
    }

    self notify( "disconnect" );
}

getnumactiveagents( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "all";

    var_1 = getactiveagentsoftype( var_0 );
    return var_1.size;
}

getactiveagentsoftype( var_0 )
{
    var_1 = [];

    if ( !isdefined( level.agentarray ) )
        return var_1;

    foreach ( var_3 in level.agentarray )
    {
        if ( isdefined( var_3.isactive ) && var_3.isactive )
        {
            if ( var_0 == "all" || var_3.agent_type == var_0 )
                var_1[var_1.size] = var_3;
        }
    }

    return var_1;
}

getnumownedactiveagents( var_0 )
{
    return _ID15194( var_0, "all" );
}

_ID15194( var_0, var_1 )
{
    var_2 = 0;

    if ( !isdefined( level.agentarray ) )
        return var_2;

    foreach ( var_4 in level.agentarray )
    {
        if ( isdefined( var_4.isactive ) && var_4.isactive )
        {
            if ( isdefined( var_4.owner ) && var_4.owner == var_0 )
            {
                if ( var_1 == "all" && var_4.agent_type != "alien" || var_4.agent_type == var_1 )
                    var_2++;
            }
        }
    }

    return var_2;
}

getvalidspawnpathnodenearplayer( var_0, var_1 )
{
    var_2 = getnodesinradius( self.origin, 350, 64, 128, "Path" );

    if ( !isdefined( var_2 ) || var_2.size == 0 )
        return undefined;

    if ( isdefined( level.waterdeletez ) && isdefined( level.trigunderwater ) )
    {
        var_3 = var_2;
        var_2 = [];

        foreach ( var_5 in var_3 )
        {
            if ( var_5.origin[2] > level.waterdeletez || !ispointinvolume( var_5.origin, level.trigunderwater ) )
                var_2[var_2.size] = var_5;
        }
    }

    var_7 = anglestoforward( self.angles );
    var_8 = -10;
    var_9 = maps\mp\gametypes\_spawnlogic::getplayertraceheight( self );
    var_10 = ( 0, 0, var_9 );

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    var_11 = [];
    var_12 = [];

    foreach ( var_14 in var_2 )
    {
        if ( !var_14 doesnodeallowstance( "stand" ) || isdefined( var_14.no_agent_spawn ) )
            continue;

        var_15 = vectornormalize( var_14.origin - self.origin );
        var_16 = vectordot( var_7, var_15 );

        for ( var_17 = 0; var_17 < var_12.size; var_17++ )
        {
            if ( var_16 > var_12[var_17] )
            {
                for ( var_18 = var_12.size; var_18 > var_17; var_18-- )
                {
                    var_12[var_18] = var_12[var_18 - 1];
                    var_11[var_18] = var_11[var_18 - 1];
                }

                break;
            }
        }

        var_11[var_17] = var_14;
        var_12[var_17] = var_16;
    }

    for ( var_17 = 0; var_17 < var_11.size; var_17++ )
    {
        var_14 = var_11[var_17];
        var_20 = self.origin + var_10;
        var_21 = var_14.origin + var_10;

        if ( var_17 > 0 )
            wait 0.05;

        if ( !sighttracepassed( var_20, var_21, 0, self ) )
            continue;

        if ( var_1 )
        {
            if ( var_17 > 0 )
                wait 0.05;

            var_22 = playerphysicstrace( var_14.origin + var_10, var_14.origin );

            if ( distancesquared( var_22, var_14.origin ) > 1 )
                continue;
        }

        if ( var_0 )
        {
            if ( var_17 > 0 )
                wait 0.05;

            var_22 = physicstrace( var_20, var_21 );

            if ( distancesquared( var_22, var_21 ) > 1 )
                continue;
        }

        return var_14;
    }

    if ( var_11.size > 0 && isdefined( level.ishorde ) )
    {
        return var_11[0];
        return;
    }
}

_ID19211( var_0 )
{
    var_0 dodamage( var_0.health + 500000, var_0.origin );
}

_ID19221()
{
    self [[ agentfunc( "on_damaged" ) ]]( level, undefined, self.health + 1, 0, "MOD_CRUSH", "none", ( 0, 0, 0 ), ( 0, 0, 0 ), "none", 0 );
}
