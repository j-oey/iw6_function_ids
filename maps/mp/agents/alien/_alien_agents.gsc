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
    level._ID31031 = 0;
}

_ID28940()
{
    if ( !isdefined( level._ID2507 ) )
        level._ID2507 = [];

    level._ID2507["alien"] = [];
    level._ID2507["alien"]["spawn"] = ::alienagentspawn;
    level._ID2507["alien"]["think"] = ::alienagentthink;
    level._ID2507["alien"]["on_killed"] = maps\mp\alien\_death::onalienagentkilled;
    level._ID2507["alien"]["on_damaged"] = maps\mp\alien\_damage::_ID22770;
    level._ID2507["alien"]["on_damaged_finished"] = maps\mp\agents\alien\_alien_think::ondamagefinish;
    level.alien_funcs["goon"]["approach"] = maps\mp\agents\alien\_alien_think::_ID9354;
    level.alien_funcs["minion"]["approach"] = maps\mp\agents\alien\_alien_minion::minion_approach;
    level.alien_funcs["spitter"]["approach"] = maps\mp\agents\alien\_alien_think::_ID9354;
    level.alien_funcs["elite"]["approach"] = maps\mp\agents\alien\_alien_elite::elite_approach;
    level.alien_funcs["brute"]["approach"] = maps\mp\agents\alien\_alien_think::_ID9354;
    level.alien_funcs["locust"]["approach"] = maps\mp\agents\alien\_alien_think::_ID9354;
    level.alien_funcs["leper"]["approach"] = maps\mp\agents\alien\_alien_think::_ID9354;
    level.alien_funcs["goon"]["combat"] = maps\mp\agents\alien\_alien_think::_ID9353;
    level.alien_funcs["minion"]["combat"] = maps\mp\agents\alien\_alien_think::_ID9353;
    level.alien_funcs["spitter"]["combat"] = maps\mp\agents\alien\_alien_spitter::_ID31027;
    level.alien_funcs["elite"]["combat"] = maps\mp\agents\alien\_alien_think::_ID9353;
    level.alien_funcs["brute"]["combat"] = maps\mp\agents\alien\_alien_think::_ID9353;
    level.alien_funcs["locust"]["combat"] = maps\mp\agents\alien\_alien_think::_ID9353;
    level.alien_funcs["leper"]["combat"] = maps\mp\agents\alien\_alien_leper::leper_combat;
    level.alien_funcs["goon"]["badpath"] = maps\mp\agents\alien\_alien_think::_ID16033;
    level.alien_funcs["minion"]["badpath"] = maps\mp\agents\alien\_alien_think::_ID16033;
    level.alien_funcs["spitter"]["badpath"] = maps\mp\agents\alien\_alien_think::_ID16033;
    level.alien_funcs["elite"]["badpath"] = maps\mp\agents\alien\_alien_think::_ID16033;
    level.alien_funcs["brute"]["badpath"] = maps\mp\agents\alien\_alien_think::_ID16033;
    level.alien_funcs["locust"]["badpath"] = maps\mp\agents\alien\_alien_think::_ID16033;
    level.alien_funcs["leper"]["badpath"] = maps\mp\agents\alien\_alien_think::_ID16033;
    level._ID34734 = [];
    level._ID34736 = 20;
    level._ID34735 = 0;
    level.alien_jump_melee_speed = 1.05;
    level._ID2791 = 900;
}

alienagentthink()
{

}

alienagentspawn( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = "wave goon";

    var_4 = _ID25943( var_2 );

    if ( !isdefined( var_0 ) || !isdefined( var_1 ) )
    {
        var_5 = self [[ level.getspawnpoint ]]();
        var_0 = var_5.origin;
        var_1 = var_5.angles;
    }

    _ID28198( var_4 );

    if ( common_scripts\utility::flag_exist( "hives_cleared" ) && common_scripts\utility::_ID13177( "hives_cleared" ) && self.agentteam == "axis" )
    {
        if ( !common_scripts\utility::flag_exist( "nuke_went_off" ) || !common_scripts\utility::_ID13177( "nuke_went_off" ) )
        {
            self._ID22326 = 1;
            var_6 = 0;
            var_7 = strtok( var_2, " " );
            var_8 = var_7[0];

            if ( var_7.size > 1 )
                var_8 = var_7[1];

            if ( var_4 == "spitter" && isdefined( level._ID12244 ) )
                var_0 = maps\mp\alien\_spawnlogic::port_to_escape_spitter_location();
            else
            {
                var_9 = maps\mp\alien\_spawnlogic::_ID24737( var_8 );

                if ( !isdefined( var_9 ) )
                    var_6 = 1;
                else
                {
                    var_0 = var_9[0];
                    var_1 = var_9[1];
                }
            }

            if ( !var_6 )
            {
                var_0 = getgroundposition( var_0, 16 );
                var_0 -= ( 0, 0, 90 );
                var_3 = level.cycle_data.spawn_node_info["queen_test"]._ID35292[var_8];
            }
        }
    }

    _ID30573( var_0, var_1, var_4 );
    level notify( "spawned_agent",  self  );
    _ID28195( var_2 );
    _ID28257( var_4 );
    _ID28558( var_0 );
    _ID28586( var_4 );
    _ID34137();
    _ID29155();
    _ID21129();

    if ( isdefined( var_3 ) )
        dointrovignetteanim( var_3 );

    if ( isdefined( self._ID22326 ) )
        self._ID22326 = undefined;

    _ID36638::_ID37752();
    thread maps\mp\agents\alien\_alien_think::_ID20445();
}

_ID28257( var_0 )
{
    self.allowjump = 1;
    self.allowladders = 1;
    self.movemode = get_default_movemode();
    self.radius = 15;
    self.height = 72;
    self.turnrate = 0.3;
    self.sharpturnnotifydist = 48;
    self.traversesoonnotifydist = level.alienanimdata._ID19011;
    self.stopsoonnotifydist = level.alienanimdata._ID31858;
    self.jumpcost = level._ID2829[var_0].attributes["jump_cost"];

    if ( common_scripts\utility::flag_exist( "hives_cleared" ) && common_scripts\utility::_ID13177( "hives_cleared" ) )
        self.jumpcost = max( 0.85, self.jumpcost * 0.66 );

    self.traversecost = level._ID2829[var_0].attributes["traverse_cost"];
    self.runcost = level._ID2829[var_0].attributes["run_cost"];

    if ( isdefined( level._ID2829[var_0].attributes["wall_run_cost"] ) )
        self scragentsetwallruncost( level._ID2829[var_0].attributes["wall_run_cost"] );
}

get_default_movemode()
{
    var_0 = maps\mp\alien\_unk1464::_ID14264();

    switch ( var_0 )
    {
        case "minion":
            return "walk";
        default:
            return "run";
    }
}

_ID28586( var_0 )
{
    if ( !can_attack_drill( var_0 ) )
    {
        self setthreatbiasgroup( "dontattackdrill" );
        return;
    }

    self setthreatbiasgroup( "other_aliens" );
}

can_attack_drill( var_0 )
{
    if ( isdefined( level.dlc_alien_can_attack_drill_override_func ) )
    {
        var_1 = [[ level.dlc_alien_can_attack_drill_override_func ]]( var_0 );

        if ( isdefined( var_1 ) )
            return var_1;
    }

    switch ( var_0 )
    {
        case "elite":
        case "minion":
        case "locust":
        case "gargoyle":
        case "mammoth":
            return 0;
        default:
            return 1;
    }
}

_ID28558( var_0 )
{
    self.species = "alien";
    self.enablestop = 1;
    maps\mp\agents\_agent_utility::activateagent();
    self._ID30916 = gettime();
    self.attacking_player = 0;
    self.spawnorigin = var_0;
    self.recentdamages = [];
    self._ID8974 = 0;
    self._ID32265 = 0.5;
    self._ID19777 = undefined;
    self.trajectoryactive = 0;
    self._ID20841 = 0;
    self.melee_in_posture = 0;
}

_ID25943( var_0 )
{
    var_1 = strtok( var_0, " " );

    if ( isdefined( var_1 ) && var_1.size == 2 )
        return var_1[1];
    else
        return var_0;
}

_ID28198( var_0 )
{
    if ( isdefined( level.get_alien_model_func ) )
        var_1 = [[ level.get_alien_model_func ]]( var_0 );
    else
        var_1 = level._ID2829[var_0].attributes["model"];

    self setmodel( var_1 );
    self show();
    self motionblurhqenable();
}

_ID30573( var_0, var_1, var_2 )
{
    self._ID22818 = maps\mp\agents\alien\_alien_think::_ID22818;
    var_3 = get_anim_class( var_2 );
    self spawnagent( var_0, var_1, var_3, 15, 50 );
}

get_anim_class( var_0 )
{
    return level._ID2829[var_0].attributes["animclass"];
}

_ID28195( var_0 )
{
    maps\mp\alien\_spawnlogic::assign_alien_attributes( var_0 );
}

_ID34137()
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "elite":
            maps\mp\agents\alien\_alien_elite::_ID11380();
            break;
        case "minion":
            maps\mp\agents\alien\_alien_minion::_ID21126();
            break;
        case "spitter":
            maps\mp\agents\alien\_alien_spitter::_ID31030();
            break;
        case "leper":
            maps\mp\agents\alien\_alien_leper::leper_init();
            break;
        default:
            if ( isdefined( level.dlc_alien_init_override_func ) )
                [[ level.dlc_alien_init_override_func ]]();

            break;
    }
}

_ID21129()
{
    self scragentsetclipmode( "agent" );
    self takeallweapons();
}

_ID29155()
{
    thread maps\mp\agents\alien\_alien_think::_ID35969();
    thread maps\mp\agents\alien\_alien_think::_ID35951();
    thread maps\mp\agents\alien\_alien_think::_ID35958();
    thread maps\mp\_flashgrenades::_ID21388();
    thread maps\mp\agents\alien\_alien_think::_ID21388();
}

dointrovignetteanim( var_0 )
{
    var_1 = 0;
    var_2 = 1;
    var_3 = 2;
    var_4 = 3;
    var_5 = 4;
    var_6 = 5;
    var_7 = 6;
    var_8 = 7;
    self scragentsetscripted( 1 );
    self scragentsetphysicsmode( "noclip" );
    self scragentsetanimmode( "anim deltas" );
    var_0 = strtok( var_0, ";" );
    self._ID35291 = [];
    self._ID35291["FX"] = replacenonewithemptystring( var_0[var_5] );
    self._ID35291["scriptableName"] = strtok( replacenonewithemptystring( var_0[var_6] ), "," );
    self._ID35291["scriptableState"] = strtok( replacenonewithemptystring( var_0[var_7] ), "," );
    self._ID35291["spawnNodeID"] = replacenonewithemptystring( var_0[var_8] );
    var_9 = replacenonewithemptystring( var_0[var_1] );
    var_10 = strtok( replacenonewithemptystring( var_0[var_2] ), "," );
    var_11 = int( var_10[randomint( var_10.size )] );
    var_12 = replacenonewithemptystring( var_0[var_3] );
    var_13 = replacenonewithemptystring( var_0[var_4] );
    var_14 = self getanimentry( var_9, var_11 );

    if ( shoulddogroundlerp( var_14 ) )
        _ID10600( var_9, var_11 );

    if ( willplayscriptables( var_14 ) )
        resetallscriptables( self._ID35291["scriptableName"], self.origin );

    var_15 = maps\mp\agents\alien\_alien_traverse::needflexibleheightsupport( var_14 );

    if ( var_15._ID21900 )
        dospawnvignettewithflexibleheight( var_9, var_11, var_12, var_14, var_15._ID31335, var_15._ID11565, ::_ID35293 );
    else
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_9, var_11, var_12, var_13, ::_ID35293 );

    self scragentsetscripted( 0 );
}

shoulddogroundlerp( var_0 )
{
    return !animhasnotetrack( var_0, "skip_ground_lerp" );
}

willplayscriptables( var_0 )
{
    return animhasnotetrack( var_0, "play_scriptable" ) && can_play_scriptable( self._ID35291["spawnNodeID"], self._ID35291["scriptableName"] );
}

dospawnvignettewithflexibleheight( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_0, var_1, var_2, var_4, var_6 );
    var_7 = getendloconground( var_3 );
    maps\mp\agents\alien\_alien_traverse::dotraversalwithflexibleheight_internal( var_0, var_1, var_2, var_3, var_4, var_5, var_7, 1, ::_ID35293 );
}

getendloconground( var_0 )
{
    var_1 = 32;
    var_2 = -300;
    var_3 = maps\mp\agents\alien\_alien_anim_utils::_ID15263( var_0, self.origin, self.angles, getanimlength( var_0 ) );
    return common_scripts\utility::drop_to_ground( var_3, var_1, var_2 );
}

replacenonewithemptystring( var_0 )
{
    if ( var_0 == "NONE" )
        return "";

    return var_0;
}

_ID35293( var_0, var_1, var_2, var_3 )
{
    switch ( var_0 )
    {
        case "alien_drone_spawn_underground":
        case "play_fx":
            if ( !is_empty_string( self._ID35291["FX"] ) )
                _ID24648( self._ID35291["FX"] );

            break;
        case "play_scriptable":
            if ( can_play_scriptable( self._ID35291["spawnNodeID"], self._ID35291["scriptableName"] ) )
            {
                _ID23881( self._ID35291["scriptableName"], self.origin, self._ID35291["scriptableState"] );

                if ( is_one_off_scriptable( self._ID35291["spawnNodeID"] ) )
                    inactivate_scriptable_for_node( self._ID35291["spawnNodeID"] );
            }

            break;
        case "play_earthquake":
            earthquake( 0.5, 1.5, self.origin, 800 );
            break;
        case "delete_spawn_clip":
            if ( isdefined( self._ID37519 ) )
                _ID37099( self._ID37519 );

            break;
        case "frontal_cone_knock_player_back":
            frontal_cone_knock_player_back();
            break;
        case "apply_physics":
            self scragentsetphysicsmode( "gravity" );
            break;
        default:
            break;
    }
}

can_play_scriptable( var_0, var_1 )
{
    return ( is_scriptable_status( var_0, "always_on" ) || is_scriptable_status( var_0, "one_off" ) ) && var_1.size > 0;
}

is_scriptable_status( var_0, var_1 )
{
    return level.cycle_data.spawn_node_info[var_0].scriptablestatus == var_1;
}

is_one_off_scriptable( var_0 )
{
    return is_scriptable_status( var_0, "one_off" );
}

inactivate_scriptable_for_node( var_0 )
{
    level.cycle_data.spawn_node_info[var_0].scriptablestatus = "inactive";
}

_ID37099( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
            var_2 delete();
    }
}

frontal_cone_knock_player_back()
{
    var_0 = 22500;
    var_1 = 650;
    var_2 = 0.2588;
    var_3 = anglestoforward( self.angles );

    foreach ( var_5 in level.players )
    {
        var_6 = vectornormalize( var_5.origin - self.origin );

        if ( vectordot( var_6, var_3 ) > var_2 && distancesquared( var_5.origin, self.origin ) <= var_0 )
        {
            var_5 setvelocity( vectornormalize( var_5.origin - self.origin ) * var_1 );
            var_5 dodamage( var_5.health / 10, self.origin );
        }
    }
}

resetallscriptables( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
        maps\mp\agents\alien\_alien_anim_utils::resetscriptable( var_0[var_2], var_1 );
}

_ID23881( var_0, var_1, var_2 )
{
    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
        maps\mp\agents\alien\_alien_anim_utils::playanimonscriptable( var_0[var_3], var_1, int( var_2[var_3] ) );
}

is_empty_string( var_0 )
{
    return var_0 == "";
}

_ID24648( var_0 )
{
    var_1 = level._ID1644[var_0];
    var_2 = getgroundposition( self.origin + ( 0, 0, 100 ), 16 );
    playfx( var_1, var_2, ( 0, 0, 1 ) );
}

_ID10600( var_0, var_1 )
{
    var_2 = 2;
    var_3 = self getanimentry( var_0, var_1 );
    var_4 = maps\mp\agents\alien\_alien_anim_utils::getlerptime( var_3 );
    var_5 = maps\mp\agents\alien\_alien_anim_utils::_ID15263( var_3, self.origin, self.angles, var_4 );
    var_6 = _ID15467( var_3 );
    var_5 += ( 0, 0, var_6 + var_2 );
    thread maps\mp\agents\alien\_alien_anim_utils::dolerp( var_5, var_4 );
}

_ID15467( var_0 )
{
    var_1 = 100;
    var_2 = 32;
    var_3 = 72;
    var_4 = getmovedelta( var_0, 0, 1 );
    var_4 = rotatevector( var_4, self.angles );
    var_5 = var_4[2];
    var_6 = self.origin + var_4;
    var_7 = var_6 + ( 0, 0, var_1 );
    var_8 = var_6 - ( 0, 0, var_1 );
    var_9 = self aiphysicstrace( var_7, var_8, var_2, var_3 );
    var_10 = var_9 - self.origin[2];
    return var_10 - var_5;
}
