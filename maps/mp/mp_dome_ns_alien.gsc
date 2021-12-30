// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID28940()
{
    level._ID2507["alien"]["spawn"] = ::_ID30572;
    level._ID2507["alien"]["on_killed"] = ::on_agent_alien_killed;
    level._ID2507["alien"]["on_damaged"] = maps\mp\agents\_agents::_ID22742;
    level._ID2507["alien"]["on_damaged_finished"] = ::on_damaged_finished;
    level._ID2507["alien"]["think"] = maps\mp\mp_dome_ns_alien_think::_ID20445;
}

usealien( var_0, var_1 )
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    _ID28940();
    var_2 = maps\mp\agents\_agent_utility::getvalidspawnpathnodenearplayer( 1 );

    if ( !isdefined( var_2 ) )
        return 0;

    thread sfx_seeker_quake( var_0 );

    for ( var_3 = 0; var_3 < var_1; var_3++ )
    {
        var_4 = maps\mp\agents\_agent_common::_ID7870( "alien", self.team );

        if ( !isdefined( var_4 ) )
            return 0;

        var_4 maps\mp\agents\_agent_utility::_ID28189( self.team, self );

        if ( var_3 == 0 )
            var_5 = common_scripts\utility::_ID15386( "seeker_path_01", "script_noteworthy" );
        else if ( var_3 == 1 )
            var_5 = common_scripts\utility::_ID15386( "seeker_path_02", "script_noteworthy" );
        else
            var_5 = common_scripts\utility::_ID15386( "seeker_path_03", "script_noteworthy" );

        var_4 thread _ID30572( var_0.origin, var_0.angles, self, var_5 );

        if ( getdvarint( "scr_alienDebugMode" ) != 1 )
            var_4 thread alien_timeout( 60 );

        wait 0.5;
    }

    return 1;
}

alien_timeout( var_0 )
{
    self endon( "death" );
    wait(var_0);
    maps\mp\mp_dome_ns_alien_think::mp_dome_ns_alien_explode();
}

on_agent_alien_killed( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self.isactive = 0;
    self.hasdied = 0;

    if ( isdefined( self.animcbs._ID22830[self.aistate] ) )
        self [[ self.animcbs._ID22830[self.aistate] ]]();

    if ( isplayer( var_1 ) && isdefined( self.owner ) && var_1 != self.owner )
    {
        self setanimstate( "explode", 0, 1 );
        self._ID5433 = self cloneagent( var_8 );
        maps\mp\mp_dome_ns_alien_think::mp_dome_ns_alien_explode( undefined, 150, 128, var_1 );
        maps\mp\gametypes\_damage::onkillstreakkilled( var_1, var_4, var_3, var_2 );
        wait(var_8);
        var_9 = self getcorpseentity();
        var_9 delete();
    }

    maps\mp\agents\_agent_utility::_ID9023();
}

on_damaged_finished( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isdefined( self._ID24607 ) )
        thread play_pain_sound( 2.5 );

    var_10 = var_2;

    if ( isdefined( var_8 ) && var_8 == "head" && level._ID14086 != "horde" )
    {
        var_10 = int( var_10 * 0.6 );

        if ( var_2 > 0 && var_10 <= 0 )
            var_10 = 1;
    }

    if ( self.health - var_10 > 0 )
        maps\mp\mp_dome_ns_alien_think::_ID22790( var_0, var_1, var_10, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

    if ( isplayer( var_1 ) )
    {
        if ( isdefined( self.attackstate ) && self.attackstate != "attacking" )
        {
            if ( distancesquared( self.origin, var_1.origin ) <= self.dogdamagedradiussq )
            {
                self.favoriteenemy = var_1;
                self._ID13507 = 1;
                thread maps\mp\mp_dome_ns_alien_think::_ID36068();
            }
        }
    }

    maps\mp\agents\_agents::agent_damage_finished( var_0, var_1, var_10, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

play_pain_sound( var_0 )
{
    self endon( "death" );
    self._ID24607 = 1;
    wait(var_0);
    self._ID24607 = undefined;
}

_ID30572( var_0, var_1, var_2, var_3 )
{
    self setmodel( "alien_minion" );
    thread mp_dome_ns_alien_glow();
    thread mp_dome_ns_alien_vfx();
    self.species = "alien";
    self._ID22818 = maps\mp\mp_dome_ns_alien_think::_ID22818;
    var_4 = var_0;
    var_5 = var_1;

    if ( isdefined( var_0 ) && isdefined( var_1 ) )
    {
        var_4 = var_0;
        var_5 = var_1;
    }
    else
    {
        var_6 = self [[ level.getspawnpoint ]]();
        var_4 = var_6.origin;
        var_5 = var_6.angles;
    }

    maps\mp\agents\_agent_utility::activateagent();
    self._ID30916 = gettime();
    self.lastspawntime = gettime();
    maps\mp\mp_dome_ns_alien_think::_ID17631();
    self spawnagent( var_4, var_5, "mp_dome_ns_alien_animclass", 15, 40, var_2 );
    level notify( "spawned_agent",  self  );
    maps\mp\agents\_agent_common::_ID28188( 350 );

    if ( isdefined( var_2 ) )
        maps\mp\agents\_agent_utility::_ID28189( var_2.team, var_2 );

    self setthreatbiasgroup( "Dogs" );
    self takeallweapons();
    self playsound( "alien_seeker_spawn" );
    playfx( level._ID1644["vfx_alien_minion_spawn_dome"], self.origin );
    self.pathnodearray = var_3;
    thread maps\mp\mp_dome_ns_alien_think::_ID20445();
}

mp_dome_ns_alien_glow()
{
    wait 2.0;
    self emissiveblend( 0.5, 1.0 );
}

mp_dome_alien_light( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        playfx( level._ID1644["vfx_alien_minion_preexplosion"], self.origin + var_0 );
        wait 1.0;
    }
}

mp_dome_ns_alien_vfx()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = ( 0, 0, 16 );
    thread mp_dome_alien_light( var_0 );

    for (;;)
    {
        playfx( level._ID1644["vfx_alien_minion_glow_trail_noloop"], self.origin + var_0 );
        wait(randomfloatrange( 0.05, 0.2 ));
    }
}

sfx_seeker_quake( var_0 )
{
    if ( !isdefined( level.rumble_sfx ) )
    {
        level.rumble_sfx = spawn( "script_origin", var_0.origin );
        level.rumble_sfx playsound( "alien_seeker_quake" );
        wait 6.5;
        level.rumble_sfx delete();
        return;
    }
}
