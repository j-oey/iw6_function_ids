// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

codecallback_agentadded()
{
    maps\mp\agents\_agent_utility::_ID17878();
    var_0 = "axis";

    if ( level.numagents % 2 == 0 )
        var_0 = "allies";

    level.numagents++;
    maps\mp\agents\_agent_utility::_ID28189( var_0 );
    level.agentarray[level.agentarray.size] = self;
}

codecallback_agentdamaged( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_1 = maps\mp\_utility::_validateattacker( var_1 );
    self [[ maps\mp\agents\_agent_utility::agentfunc( "on_damaged" ) ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

codecallback_agentkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_1 = maps\mp\_utility::_validateattacker( var_1 );
    self thread [[ maps\mp\agents\_agent_utility::agentfunc( "on_killed" ) ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
}

_ID17631()
{
    _ID17877();
    level thread _ID2149();
}

_ID7870( var_0, var_1, var_2 )
{
    var_3 = maps\mp\agents\_agent_utility::getfreeagent( var_0 );

    if ( isdefined( var_3 ) )
    {
        var_3.connecttime = gettime();

        if ( isdefined( var_1 ) )
            var_3 maps\mp\agents\_agent_utility::_ID28189( var_1 );
        else
            var_3 maps\mp\agents\_agent_utility::_ID28189( var_3.team );

        if ( isdefined( var_2 ) )
            var_3._ID7324 = var_2;

        if ( isdefined( level._ID2507[var_0]["onAIConnect"] ) )
            var_3 [[ var_3 maps\mp\agents\_agent_utility::agentfunc( "onAIConnect" ) ]]();

        var_3 maps\mp\gametypes\_spawnlogic::addtocharactersarray();
    }

    return var_3;
}

_ID17877()
{
    level.agentarray = [];
    level.numagents = 0;
}

_ID2149()
{
    level endon( "game_ended" );
    level waittill( "connected",  var_0  );
    var_1 = getmaxagents();

    while ( level.agentarray.size < var_1 )
    {
        var_2 = addagent();

        if ( !isdefined( var_2 ) )
        {
            common_scripts\utility::_ID35582();
            continue;
        }
    }
}

_ID28188( var_0 )
{
    self.agenthealth = var_0;
    self.health = var_0;
    self.maxhealth = var_0;
}
