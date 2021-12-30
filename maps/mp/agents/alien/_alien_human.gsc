// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID37491( var_0 )
{
    level._ID2507["alienHuman"] = [];
    level._ID2507["alienHuman"]["spawn"] = ::_ID36694;
    level._ID2507["alienHuman"]["on_killed"] = ::_ID36693;
    level._ID2507["alienHuman"]["on_damaged"] = ::_ID36691;
    level._ID2507["alienHuman"]["on_damaged_finished"] = ::_ID36692;
    level._ID37431 = var_0;
}

_ID36694( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = maps\mp\agents\_agent_common::_ID7870( "alienHuman", "allies" );

    if ( !isdefined( var_0 ) || !isdefined( var_1 ) )
    {
        var_6 = var_5 [[ level.getspawnpoint ]]();
        var_0 = var_6.origin;
        var_1 = var_6.angles;
    }

    var_5 setmodel( var_2 );
    var_5 show();
    var_5 spawnagent( var_0, var_1, level._ID37431 );
    var_5 scragentsetphysicsmode( "noclip" );
    var_5 attach( var_3, "J_spine4" );
    var_5.moveplaybackrate = 1.0;
    var_5.defaultmoveplaybackrate = 1.0;
    var_5._ID36479 = 1.0;
    var_5 maps\mp\agents\_agent_utility::activateagent();
    var_5._ID30916 = gettime();
    var_5._ID38065 = var_0;
    var_5 scragentsetclipmode( "agent" );
    var_5.maxhealth = 100;
    var_5.health = 100;
    var_5.ignoreme = !isdefined( var_4 ) || !var_4;
    return var_5;
}

_ID36965()
{
    var_0 = self.origin;

    for (;;)
    {
        var_1 = self.origin;
        var_2 = undefined;
        var_3 = 0.0;

        if ( isdefined( self._ID38119 ) && length( var_1 - var_0 ) > 0.1 )
        {
            var_2 = self getanimentryname();
            var_3 = ( gettime() - self._ID38119 ) / 1000.0;
        }

        wait 0.05;
        var_0 = var_1;
    }
}

_ID37790( var_0, var_1, var_2, var_3 )
{
    self._ID38119 = gettime();

    if ( !isdefined( var_2 ) )
        var_2 = "end";

    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_0, var_1, var_0, var_2, var_3 );
}

_ID36691( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    return self [[ maps\mp\agents\_agent_utility::agentfunc( "on_damaged_finished" ) ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

_ID36692( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    self finishagentdamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, 0 );
}

_ID36693( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{

}
