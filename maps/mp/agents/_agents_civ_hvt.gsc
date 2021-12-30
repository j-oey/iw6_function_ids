// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    _ID28940();
}

_ID28940()
{
    level._ID2507["civ_hvt"] = [];
    level._ID2507["civ_hvt"]["spawn"] = ::_ID37751;
    level._ID2507["civ_hvt"]["think"] = ::_ID36676;
    level._ID2507["civ_hvt"]["on_killed"] = ::onagentkilled;
    level._ID2507["civ_hvt"]["on_damaged"] = maps\mp\agents\_agents::_ID22743;
    level._ID2507["civ_hvt"]["on_damaged_finished"] = maps\mp\agents\_agents::agent_damage_finished;
}

_ID37751( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self._ID37435 = 0;
    maps\mp\agents\_agents::_ID30565( var_0, var_1, var_2, var_3, var_4, var_5 );
    thread _ID37397();
}

onagentkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self._ID37094 = undefined;
    self._ID37436 makeunusable();
    self._ID37436 = undefined;
    self._ID5433 = self cloneagent( var_8 );
    thread maps\mp\gametypes\_damage::_ID9517( self._ID5433, var_6, var_5, var_4, var_0, var_3 );

    if ( isdefined( self._ID37750 ) )
        self [[ self._ID37750 ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );

    maps\mp\agents\_agent_utility::_ID9023();
    self.owner notify( "hvt_killed" );
}

_ID36676()
{
    self notify( "agent_think" );
    self endon( "agent_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "owner_disconnect" );

    for (;;)
    {
        if ( self._ID37435 )
        {
            _ID37223();
            continue;
        }

        _ID38279( 150 );
    }
}

_ID38279( var_0 )
{
    self botsetstance( "none" );
    self botclearscriptgoal();
    maps\mp\bots\_bots_strategy::bot_disable_tactical_goals();
    var_1 = self.owner maps\mp\agents\_agent_utility::getvalidspawnpathnodenearplayer();
    self._ID8595 = undefined;
    self.bot_defending = 1;
    self.bot_defending_center = var_1.origin;
    self.bot_defending_radius = var_0;
    self.cur_defend_stance = "crouch";
    self.bot_defending_type = "protect";

    for ( var_2 = ""; var_2 != "goal"; self._ID8595 = undefined )
    {
        self._ID8595 = var_1;
        self botsetscriptgoalnode( self._ID8595, "tactical" );
        var_2 = common_scripts\utility::_ID35635( "goal", "bad_path" );
        self._ID22081 = var_1;
    }

    childthread maps\mp\bots\_bots_strategy::_ID9470();
    self waittill( "hvt_toggle" );
}

_ID37223()
{
    self botclearscriptgoal();
    maps\mp\bots\_bots_strategy::bot_disable_tactical_goals();

    if ( !maps\mp\bots\_bots_util::bot_is_guarding_player( self.owner ) )
        maps\mp\bots\_bots_strategy::bot_guard_player( self.owner, 250 );

    self waittill( "hvt_toggle" );
}

_ID37397()
{
    level endon( "game_ended" );
    self endon( "death" );

    if ( !isdefined( self._ID37436 ) )
    {
        self._ID37436 = spawn( "script_model", self.origin );
        self._ID37436 linkto( self );
    }

    self._ID37436 makeusable();

    foreach ( var_1 in level.players )
    {
        if ( var_1 != self.owner )
        {
            self._ID37436 disableplayeruse( var_1 );
            continue;
        }

        self._ID37436 enableplayeruse( var_1 );
    }

    thread _ID38277();

    for (;;)
    {
        _ID37965();
        self._ID37436 waittill( "trigger",  var_1  );
        self._ID37435 = !self._ID37435;
        self notify( "hvt_toggle" );
    }
}

_ID37965()
{
    var_0 = &"MP_HVT_FOLLOW";

    if ( self._ID37435 )
        var_0 = &"MP_HVT_WAIT";

    self._ID37436 sethintstring( var_0 );
}

_ID38277()
{
    level endon( "game_ended" );
    self endon( "death" );

    for (;;)
    {
        level waittill( "connected",  var_0  );
        self._ID37436 disableplayeruse( var_0 );
    }
}
