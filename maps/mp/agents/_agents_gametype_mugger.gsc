// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    _ID28940();
}

_ID28940()
{
    level._ID2507["squadmate"]["gametype_update"] = ::_ID36675;
    level._ID2507["player"]["think"] = ::_ID36671;
}

_ID36671()
{
    thread maps\mp\bots\_bots_gametype_mugger::_ID36866();
}

_ID36675()
{
    if ( !isdefined( self._ID38140 ) )
        self._ID38140 = [];

    if ( !isdefined( self._ID37732 ) )
        self._ID37732 = gettime() + 500;

    if ( gettime() > self._ID37732 )
    {
        self._ID37732 = gettime() + 500;
        var_0 = 0.78;

        if ( isbot( self.owner ) )
            var_0 = self botgetfovdot();

        var_1 = self.owner getnearestnode();

        if ( isdefined( var_1 ) )
        {
            var_2 = self.owner maps\mp\bots\_bots_gametype_mugger::_ID36844( var_1, var_0 );
            self._ID38140 = maps\mp\bots\_bots_gametype_conf::_ID36829( var_2, self._ID38140 );
        }
    }

    self._ID38140 = maps\mp\bots\_bots_gametype_conf::_ID36872( self._ID38140 );
    var_3 = maps\mp\bots\_bots_gametype_conf::_ID36841( self._ID38140, 0 );

    if ( isdefined( var_3 ) )
    {
        if ( !isdefined( self._ID38136 ) || distancesquared( var_3.curorigin, self._ID38136.curorigin ) > 1 )
        {
            self._ID38136 = var_3;
            maps\mp\bots\_bots_strategy::bot_defend_stop();
            self botsetscriptgoal( self._ID38136.curorigin, 0, "objective", undefined, level._ID36884 );
        }

        return 1;
    }
    else if ( isdefined( self._ID38136 ) )
    {
        self botclearscriptgoal();
        self._ID38136 = undefined;
    }

    return 0;
}
