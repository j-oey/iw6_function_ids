// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    _ID28940();
    level thread _ID27047();
}

_ID28940()
{
    level._ID2507["player"]["onAIConnect"] = ::onaiconnect;
    level._ID2507["player"]["think"] = ::_ID12049;
    level._ID2507["player"]["on_killed"] = ::onagentkilled;
    level._ID2507["squadmate"]["onAIConnect"] = ::onaiconnect;
    level._ID2507["squadmate"]["think"] = ::allyagentthink;
    level._ID2507["dog"]["onAIConnect"] = ::onaiconnect;
    level._ID2507["dog"]["think"] = ::agentdogthink;
    level._ID2507["dog"]["on_killed"] = ::_ID22809;
}

onaiconnect()
{
    self._ID14072 = 1;
    self.agentname = &"HORDE_INFECTED";
    self._ID17064 = "";
}

_ID27047()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "start_round" );

        if ( maps\mp\gametypes\_horde_util::_ID18796() )
        {
            _ID27050();
            continue;
        }

        _ID27037();
    }
}

_ID27050()
{
    maps\mp\gametypes\_horde_crates::_ID27024();
}

_ID27037()
{
    level childthread _ID16922();

    while ( level.currentenemycount < level._ID20734 )
    {
        while ( level._ID8680 < level.maxaliveenemycount )
        {
            _ID8413();

            if ( level.currentenemycount == level._ID20734 )
                break;
        }

        level waittill( "enemy_death" );
    }
}

_ID8413()
{
    if ( maps\mp\gametypes\_horde_util::_ID18606() && randomintrange( 1, 101 ) < level.chancetospawndog )
    {
        createdogenemy();
        return;
    }

    createhumanoidenemy();
    return;
}

createhumanoidenemy()
{
    var_0 = undefined;

    while ( !isdefined( var_0 ) )
    {
        var_0 = maps\mp\agents\_agents::add_humanoid_agent( "player", level.enemyteam, "class1" );

        if ( isdefined( var_0 ) )
        {
            level.currentenemycount++;
            level._ID8680++;
        }

        common_scripts\utility::_ID35582();
    }
}

createdogenemy()
{
    var_0 = undefined;

    while ( !isdefined( var_0 ) )
    {
        var_0 = maps\mp\agents\_agent_common::_ID7870( "dog", level.enemyteam );

        if ( isdefined( var_0 ) )
        {
            var_0 thread [[ var_0 maps\mp\agents\_agent_utility::agentfunc( "spawn" ) ]]();
            level.currentenemycount++;
            level._ID8680++;
        }

        common_scripts\utility::_ID35582();
    }
}

_ID23871()
{
    playfx( level._ID1644["spawn_effect"], self.origin );
}

_ID16922()
{
    level endon( "round_ended" );

    for (;;)
    {
        level waittill( "enemy_death" );

        if ( level.currentenemycount != level._ID20734 )
            continue;

        if ( level._ID8680 < 3 )
        {
            foreach ( var_1 in level.characters )
            {
                if ( maps\mp\gametypes\_horde_util::isonhumanteam( var_1 ) )
                    continue;

                if ( maps\mp\_utility::_ID18757( var_1 ) )
                {
                    var_1 hudoutlineenable( level._ID12074, 0 );
                    var_1.outlinecolor = level._ID12074;
                }
            }

            break;
        }
    }
}

onagentkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !maps\mp\gametypes\_horde_util::isonhumanteam( self ) )
        _ID17073( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );

    self hudoutlinedisable();
    maps\mp\agents\_agents::_ID22757( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0 );
    maps\mp\agents\_agent_utility::_ID9023();
}

_ID22809( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !maps\mp\gametypes\_horde_util::isonhumanteam( self ) )
        _ID17073( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );

    self hudoutlinedisable();
    maps\mp\killstreaks\_dog_killstreak::_ID22741( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
}

_ID17073( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    level._ID8680--;
    _ID38161( var_4, var_3 );
    level thread maps\mp\gametypes\horde::chancetospawnpickup( self );
    level notify( "enemy_death" );

    if ( isplayer( var_1 ) )
    {
        maps\mp\gametypes\_horde_util::_ID36755( var_1 );

        if ( var_1 maps\mp\_utility::_hasperk( "specialty_triggerhappy" ) )
            var_1 thread maps\mp\perks\_perkfunctions::_ID28905();
    }

    if ( isdefined( var_1 ) && isdefined( var_1.owner ) && isplayer( var_1.owner ) && isdefined( var_1.owner._ID19283 ) )
    {
        maps\mp\gametypes\_horde_util::_ID36755( var_1.owner );
        return;
    }
}

_ID38161( var_0, var_1 )
{
    if ( level._ID18819 )
        return;

    if ( var_0 == "none" )
        return;

    if ( var_1 == "MOD_MELEE" )
        level.nummeleekillsintel++;

    if ( !maps\mp\_utility::_ID18679( var_0 ) && var_1 == "MOD_HEAD_SHOT" )
        level.numheadshotsintel++;

    if ( maps\mp\_utility::_ID18679( var_0 ) && var_0 != level.intelminigun )
        level.numkillstreakkillsintel++;

    if ( maps\mp\gametypes\_class::_ID18846( var_0, 0 ) || maps\mp\gametypes\_class::_ID18850( var_0, 0 ) )
    {
        level.numequipmentkillsintel++;
        return;
    }
}

_ID12049()
{
    self endon( "death" );
    level endon( "game_ended" );
    self botsetflag( "no_enemy_search", 1 );
    thread _ID21362();
    thread _ID20153();
}

_ID21362()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = gettime();

    for (;;)
    {
        wait 5.0;

        if ( !maps\mp\bots\_bots_util::bot_in_combat( 120000 ) )
        {
            _ID23123( self );

            if ( !maps\mp\bots\_bots_util::bot_in_combat( 240000 ) )
                break;
        }

        if ( checkexpiretime( var_0, 240, 480 ) )
            break;
    }

    maps\mp\agents\_agent_utility::_ID19211( self );
}

_ID21361()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = gettime();
    var_1 = self.origin;
    var_2 = var_0;

    for (;;)
    {
        wait 5.0;
        var_3 = distancesquared( self.origin, var_1 );
        var_4 = ( gettime() - var_2 ) / 1000;

        if ( var_3 > 16384 )
        {
            var_1 = self.origin;
            var_2 = gettime();
        }
        else if ( var_4 > 25 )
        {
            _ID23123( self );

            if ( var_4 > 55 )
                break;
        }

        if ( checkexpiretime( var_0, 120, 240 ) )
            break;
    }

    maps\mp\agents\_agent_utility::_ID19211( self );
}

checkexpiretime( var_0, var_1, var_2 )
{
    var_3 = ( gettime() - var_0 ) / 1000;

    if ( var_3 > var_1 )
    {
        _ID23123( self );

        if ( var_3 > var_2 )
            return 1;
    }

    return 0;
}

_ID23123( var_0 )
{
    var_0 hudoutlineenable( level._ID12074, 0 );
    var_0.outlinecolor = level._ID12074;
}

allyagentthink()
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "owner_disconnect" );
    self botsetflag( "force_sprint", 1 );
    var_0 = 0;
    var_1 = 0;

    for (;;)
    {
        if ( float( self.owner.health ) / self.owner.maxhealth < 0.5 && gettime() > var_1 )
        {
            var_2 = getnodesinradiussorted( self.owner.origin, 256, 0 );

            if ( var_2.size >= 2 )
            {
                self.defense_force_next_node_goal = var_2[1];
                self notify( "defend_force_node_recalculation" );
                var_1 = gettime() + 1000;
            }
        }
        else if ( float( self.health ) / self.maxhealth >= 0.6 )
            var_0 = 0;
        else if ( !var_0 )
        {
            var_3 = maps\mp\bots\_bots_util::bot_find_node_to_guard_player( self.owner.origin, 350, 1 );

            if ( isdefined( var_3 ) )
            {
                self.defense_force_next_node_goal = var_3;
                self notify( "defend_force_node_recalculation" );
                var_0 = 1;
            }
        }

        if ( !maps\mp\bots\_bots_util::bot_is_guarding_player( self.owner ) )
        {
            var_4["override_goal_type"] = "critical";
            var_4["min_goal_time"] = 20;
            var_4["max_goal_time"] = 30;
            maps\mp\bots\_bots_strategy::bot_guard_player( self.owner, 350, var_4 );
        }

        wait 0.05;
    }
}

hordesetupdogstate()
{
    maps\mp\_utility::_setnameplatematerial( "player_name_bg_green_dog", "player_name_bg_red_dog" );
    self.enableextendedkill = 0;
    self.agentname = &"HORDE_QUAD";
    self._ID17064 = "Quad";
    self._ID19425 = ( 0, 0, 0 );
    self.bhasnopath = 0;
    self.randompathstoptime = 0;
    maps\mp\gametypes\horde::_ID28714( self );
}

agentdogthink()
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "owner_disconnect" );
    maps\mp\agents\dog\_dog_think::_ID29173();
    hordesetupdogstate();
    thread _ID20153();
    self thread [[ self._ID36038 ]]();
    thread _ID35543();
    thread _ID21361();

    for (;;)
    {
        if ( self.aistate != "melee" && !self.statelocked && maps\mp\agents\dog\_dog_think::_ID25562() && !maps\mp\agents\dog\_dog_think::didpastmeleefail() )
            self scragentbeginmelee( self.curmeleetarget );

        if ( self.randompathstoptime > gettime() )
        {
            wait 0.05;
            continue;
        }

        if ( !isdefined( self.enemy ) || self.bhasnopath )
        {
            var_0 = getnodesinradiussorted( self.origin, 1024, 256, 128, "Path" );

            if ( var_0.size > 0 )
            {
                var_1 = randomintrange( int( var_0.size * 0.9 ), var_0.size );
                self scragentsetgoalpos( var_0[var_1].origin );
                self.bhasnopath = 0;
                self.randompathstoptime = gettime() + 2500;
            }
        }
        else
        {
            var_2 = maps\mp\agents\dog\_dog_think::getattackpoint( self.enemy );
            self.curmeleetarget = self.enemy;
            self.movemode = "sprint";
            self._ID4803 = 0;

            if ( distancesquared( var_2, self._ID19425 ) > 4096 )
            {
                self scragentsetgoalpos( var_2 );
                self._ID19425 = var_2;
            }
        }

        wait 0.05;
    }
}

_ID35543()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "bad_path",  var_0  );
        self.bhasnopath = 1;
    }
}

_ID20153()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        foreach ( var_1 in level._ID23303 )
        {
            if ( maps\mp\gametypes\_horde_util::isonhumanteam( var_1 ) )
                self getenemyinfo( var_1 );
        }

        wait 0.5;
    }
}

_ID12931()
{
    var_0 = undefined;
    var_1 = 1410065408;

    foreach ( var_3 in level.players )
    {
        if ( maps\mp\_utility::_ID18757( var_3 ) && maps\mp\gametypes\_horde_util::isonhumanteam( var_3 ) && !maps\mp\gametypes\_horde_util::_ID18740( var_3 ) )
        {
            var_4 = distancesquared( var_3.origin, self.origin );

            if ( var_4 < var_1 )
            {
                var_0 = var_3;
                var_1 = var_4;
            }
        }
    }

    return var_0;
}
