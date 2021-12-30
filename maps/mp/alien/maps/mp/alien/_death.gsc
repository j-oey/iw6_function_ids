// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID22886( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( level.gameended == 1 )
        return;

    if ( kill_trigger_event_was_processed() )
        return;

    set_kill_trigger_event_processed( self, 1 );
    maps\mp\alien\_laststand::callback_playerlaststandalien( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, _ID15109() );
}

kill_trigger_event_was_processed()
{
    return maps\mp\alien\_unk1464::_ID18506( self.kill_trigger_event_processed );
}

set_kill_trigger_event_processed( var_0, var_1 )
{
    self.kill_trigger_event_processed = var_1;
}

_ID22869( var_0, var_1, var_2 )
{
    if ( game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level._ID23070[var_1.team]] )
        var_1._ID12872 = 1;
}

onalienagentkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( isdefined( var_3 ) && var_3 == "MOD_SUICIDE" && isdefined( self._ID27335 ) && self._ID27335 )
        return;

    self.isactive = 0;
    self.hasdied = 0;
    self.owner = undefined;
    var_9 = self.alien_type;
    var_10 = 0;

    if ( !isdefined( var_5 ) )
        var_5 = anglestoforward( self.angles );

    maps\mp\alien\_alien_fx::disable_fx_on_death();

    if ( var_3 == "MOD_TRIGGER_HURT" )
        return;

    var_11 = 10;

    if ( maps\mp\alien\_unk1464::is_trap( var_0 ) )
        var_11 = 3;

    level thread maps\mp\alien\_unk1464::_ID20640( self.origin, 256, var_11 );
    var_12 = is_pettrap_kill( var_0 );

    if ( var_4 == "alienthrowingknife_mp" && var_3 == "MOD_IMPACT" || var_12 || maps\mp\alien\_unk1464::_ID18506( self.hypnoknifed ) )
    {
        if ( maps\mp\alien\_unk1464::can_hypno( var_1, var_12 ) )
        {
            thread maps\mp\gametypes\aliens::spawnallypet( var_9, 1, self.origin, var_1, self.angles, var_12 );
            var_10 = 1;

            if ( var_9 == "elite" && var_12 && isdefined( level.update_achievement_hypno_trap_func ) )
                var_1 [[ level.update_achievement_hypno_trap_func ]]();
        }

        if ( !var_12 )
            var_0 delete();
    }

    var_13 = 0;

    if ( isdefined( level.custom_alien_death_func ) )
        var_13 = self [[ level.custom_alien_death_func ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );

    if ( should_do_pipebomb_death( var_4 ) )
        thread do_pipebomb_death();
    else if ( _ID29829() && var_3 != "MOD_SUICIDE" && !var_10 && !var_13 )
        _ID23744( var_0, var_2, var_3, var_4, var_5, var_6 );

    on_alien_type_killed( var_10 );
    maps\mp\agents\alien\_alien_think::_ID22818( self.currentanimstate, "death" );
    var_1 notify( "dlc_vo_notify",  maps\mp\alien\_unk1464::_ID14264() + "_killed", var_1  );

    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "mammoth":
            self playsoundonmovingent( "queen_death" );
            break;
        case "elite":
            self playsoundonmovingent( "queen_death" );
            break;
        case "minion":
            self playsoundonmovingent( "alien_minion_explode" );
            break;
        case "spitter":
            self playsoundonmovingent( "spitter_death" );
            break;
        default:
            self playsoundonmovingent( "alien_death" );
            break;
    }

    if ( isdefined( level._ID4063 ) && var_1 == level._ID4063 )
    {
        var_14 = maps\mp\alien\_unk1443::_ID14726();
        var_15 = var_14 / var_1._ID26269.size;

        foreach ( var_17 in var_1._ID26269 )
        {
            if ( isdefined( var_17 ) )
                var_17.chopper_reward = 0;
        }

        foreach ( var_17 in var_1._ID26269 )
        {
            if ( isdefined( var_17 ) )
                var_17.chopper_reward = var_17.chopper_reward + var_15;
        }

        foreach ( var_17 in level.players )
        {
            if ( isdefined( var_17 ) && isdefined( var_17.chopper_reward ) )
                maps\mp\alien\_unk1443::givekillreward( var_17, int( var_17.chopper_reward ), "large" );
        }
    }
    else
    {
        if ( isdefined( var_1.pet ) && var_1.pet == 1 )
            maps\mp\alien\_unk1443::_ID15524( var_1.owner );
        else
            maps\mp\alien\_unk1443::_ID15524( var_1, var_6 );

        var_1 thread maps\mp\alien\_persistence::_ID34498( var_4, 1 );
    }

    maps\mp\alien\_challenge_function::_ID34395( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
    maps\mp\alien\_achievement::_ID34396( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
    maps\mp\alien\_persistence::update_alien_kill_sessionstats( var_0, var_1 );

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        maps\mp\alien\_chaos::update_alien_killed_event( maps\mp\alien\_unk1464::_ID14264(), self.origin, var_1 );

    blackbox_alienkilled( var_1 );
    var_23 = get_attacker_as_player( var_1 );

    if ( isdefined( var_23 ) )
    {
        record_player_kills( var_23 );
        check_award_token_for_kill( var_23 );
    }

    level notify( "alien_killed",  self.origin, var_3, var_1  );
}

get_attacker_as_player( var_0 )
{
    if ( isplayer( var_0 ) )
        return var_0;

    if ( isdefined( var_0.owner ) && isplayer( var_0.owner ) )
        return var_0.owner;

    return undefined;
}

record_player_kills( var_0 )
{
    var_0 maps\mp\alien\_persistence::_ID37957();
    var_0 maps\mp\alien\_persistence::eog_player_update_stat( "kills", 1 );
}

check_award_token_for_kill( var_0 )
{
    var_1 = var_0 maps\mp\alien\_persistence::_ID37309();

    if ( var_1 % 300 == 0 )
        var_0 maps\mp\alien\_persistence::give_player_tokens( 1, 1 );
}

on_alien_type_killed( var_0 )
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "minion":
            level thread maps\mp\agents\alien\_alien_minion::_ID21125( self.origin );
            break;
        case "spitter":
            maps\mp\agents\alien\_alien_spitter::_ID31028();
            break;
        default:
            if ( isdefined( level.dlc_alien_death_override_func ) )
                self [[ level.dlc_alien_death_override_func ]]( var_0 );

            break;
    }
}

_ID29829()
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "minion":
        case "seeder":
        case "bomber":
            return 0;
        default:
            return 1;
    }
}

_ID23744( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = 24;
    var_7 = 30;

    if ( getdvarint( "alien_easter_egg" ) > 0 || isdefined( level._ID11234 ) && level._ID11234 )
        playfx( level._ID1644["arcade_death"], self.origin );
    else
    {
        var_8 = get_primary_death_anim_state();

        if ( !maps\mp\alien\_unk1464::is_normal_upright( anglestoup( self.angles ) ) )
            _ID21555( anglestoup( self.angles ), var_6 );

        if ( isdefined( self.apextraversaldeathvector ) )
            _ID21555( self.apextraversaldeathvector, var_7 );

        _ID23745( var_8, var_0, var_1, var_2, var_3, var_4, var_5 );
    }
}

should_do_immediate_ragdoll( var_0 )
{
    if ( isdefined( level.dlc_alien_should_immediate_ragdoll_on_death_override_func ) )
    {
        var_1 = [[ level.dlc_alien_should_immediate_ragdoll_on_death_override_func ]]( var_0 );

        if ( isdefined( var_1 ) )
            return var_1;
    }

    switch ( var_0 )
    {
        case "traverse":
        case "jump":
            return 1;
        default:
            return 0;
    }
}

_ID23745( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( _ID18495( var_0 ) )
    {
        var_7 = "special_death";
        var_8 = maps\mp\agents\alien\_alien_anim_utils::_ID15353( var_0 );
    }
    else
    {
        var_7 = maps\mp\agents\alien\_alien_anim_utils::_ID14966( var_0 + "_death", var_2 );
        var_8 = maps\mp\agents\alien\_alien_anim_utils::getdeathanimindex( var_0, var_5, var_6 );
    }

    var_9 = should_do_immediate_ragdoll( var_0 );
    self scragentsetphysicsmode( get_death_anim_physics_mode( var_7 ) );
    self setanimstate( var_7, var_8 );
    self._ID5433 = get_clone_agent( var_7, var_8 );
    thread _ID16181( self._ID5433, var_7, var_9 );
}

_ID21555( var_0, var_1 )
{
    var_2 = self.origin + var_0 * var_1;
    self setorigin( var_2 );
}

get_primary_death_anim_state()
{
    if ( isdefined( self._ID29718 ) && self._ID29718 )
        return "electric_shock_death";

    switch ( self.currentanimstate )
    {
        case "scripted":
            return "idle";
        case "move":
            if ( self.trajectoryactive )
                return "jump";
            else
                return "run";
        case "idle":
            return "idle";
        case "melee":
            if ( self.trajectoryactive )
                return "jump";

            if ( self._ID20841 || self.melee_in_posture )
                return "idle";
            else
                return "run";
        case "traverse":
            if ( self.trajectoryactive )
                return "jump";
            else
                return "traverse";
    }

    endswitch( 6 )  case "scripted" loc_6BC case "traverse" loc_709 case "idle" loc_6D9 case "melee" loc_6DF case "move" loc_6C2 default loc_720
}

_ID18495( var_0 )
{
    switch ( var_0 )
    {
        case "traverse":
        case "electric_shock_death":
            return 1;
        default:
            return 0;
    }
}

get_death_anim_physics_mode( var_0 )
{
    switch ( var_0 )
    {
        case "electric_shock":
            return "noclip";
        default:
            return "gravity";
    }
}

get_clone_agent( var_0, var_1 )
{
    var_2 = self getanimentry( var_0, var_1 );
    var_3 = getanimlength( var_2 );

    if ( animhasnotetrack( var_2, "start_ragdoll" ) )
    {
        var_4 = getnotetracktimes( var_2, "start_ragdoll" );
        var_3 *= var_4[0];
    }

    var_5 = int( var_3 * 1000 );
    return self cloneagent( var_5 );
}

_ID16181( var_0, var_1, var_2 )
{
    var_3 = var_0 getcorpseanim();

    if ( !_ID29811( var_0, var_3 ) )
        return;

    if ( var_2 )
    {
        var_0 startragdoll();

        if ( var_0 isragdoll() )
            return;
    }

    _ID9517( var_0, var_3 );

    if ( !isdefined( var_0 ) )
        return;

    if ( var_1 == "shock_death" )
        self notify( "in_ragdoll",  var_0.origin  );
}

_ID9517( var_0, var_1 )
{
    var_2 = getanimlength( var_1 );

    if ( animhasnotetrack( var_1, "start_ragdoll" ) )
    {
        var_3 = getnotetracktimes( var_1, "start_ragdoll" );
        var_4 = var_3[0];
        var_5 = var_4 * var_2;
    }
    else
        var_5 = 0.2;

    wait(var_5);

    if ( !isdefined( var_0 ) )
        return;
    else
    {
        var_0 startragdoll();

        if ( var_0 isragdoll() )
            return;
    }

    if ( var_5 < var_2 )
    {
        wait(var_2 - var_5);

        if ( !isdefined( var_0 ) )
            return;
        else
        {
            var_0 startragdoll();

            if ( var_0 isragdoll() )
                return;
        }
    }

    if ( isdefined( var_0 ) )
        var_0 delete();
}

_ID29811( var_0, var_1 )
{
    if ( var_0 isragdoll() )
        return 0;

    if ( animhasnotetrack( var_1, "ignore_ragdoll" ) )
        return 0;

    if ( isdefined( level.noragdollents ) && level.noragdollents.size )
    {
        foreach ( var_3 in level.noragdollents )
        {
            if ( distancesquared( var_0.origin, var_3.origin ) < 65536 )
                return 0;
        }
    }

    return 1;
}

blackbox_alienkilled( var_0 )
{
    if ( isplayer( var_0 ) || isdefined( var_0.pet ) && var_0.pet == 1 && isplayer( var_0._ID23492 ) || isdefined( var_0.owner ) && isplayer( var_0.owner ) )
        level.alienbbdata["aliens_killed"]++;

    self notify( "alien_killed" );
    var_1 = isagent( var_0 );

    if ( var_1 )
    {
        var_2 = ( gettime() - var_0.birthtime ) / 1000;
        var_3 = "unknown agent";
        var_4 = "none";

        if ( isdefined( var_0.agent_type ) )
        {
            var_3 = var_0.agent_type;

            if ( isdefined( var_0.alien_type ) )
                var_3 = var_0.alien_type;
        }
    }
    else
    {
        var_2 = 0;
        var_4 = "none";

        if ( isplayer( var_0 ) )
        {
            var_3 = "player";

            if ( isdefined( var_0.name ) )
                var_4 = var_0.name;
        }
        else
            var_3 = "nonagent";
    }

    var_5 = 0.0;
    var_6 = 0.0;
    var_7 = 0.0;

    if ( isdefined( var_0 ) && ( isagent( var_0 ) || isplayer( var_0 ) ) )
    {
        var_5 = var_0.origin[0];
        var_6 = var_0.origin[1];
        var_7 = var_0.origin[2];
    }

    var_8 = 0;

    if ( isdefined( self.birthtime ) )
        var_8 = ( gettime() - self.birthtime ) / 1000;

    var_9 = ( 0, 0, 0 );

    if ( isdefined( self.spawnorigin ) )
        var_9 = self.spawnorigin;

    var_10 = 0;

    if ( isdefined( self.spawnorigin ) )
        var_10 = distance( self.origin, self.spawnorigin );

    var_11 = 0;

    if ( isdefined( self.damage_done ) )
        var_11 = self.damage_done;

    var_12 = "unknown agent";

    if ( isdefined( self.agent_type ) )
    {
        var_12 = self.agent_type;

        if ( isdefined( self.alien_type ) )
            var_12 = self.alien_type;
    }

    var_13 = 0;

    foreach ( var_15 in level.agentarray )
    {
        if ( !isdefined( var_15.isactive ) || !var_15.isactive )
            continue;

        if ( isdefined( var_15.team ) && var_15.team == "axis" )
            var_13++;
    }

    var_17 = 0;

    if ( isdefined( level.players ) )
        var_17 = level.players.size;

    bbprint( "alienkilled", "attackerisagent %i attackeralivetime %f attackeragenttype %s attackername %s attackerx %f attackery %f attackerz %f victimalivetime %f victimspawnoriginx %f victimspawnoriginy %f victimspawnoriginz %f victimdistfromspawn %i victimdamagedone %i victimagenttype %s currentenemypopulation %i currentplayerpopulation %i ", var_1, var_2, var_3, var_4, var_0.origin[0], var_0.origin[1], var_0.origin[2], var_8, var_9[0], var_9[1], var_9[2], var_10, var_11, var_12, var_13, var_17 );
}

_ID19206()
{
    level._ID19280 = common_scripts\utility::_ID15386( "respawn_edge", "targetname" );
}

_ID15109()
{
    return common_scripts\utility::_ID14934( self.origin, level._ID19280 );
}

should_do_pipebomb_death( var_0 )
{
    var_1 = maps\mp\alien\_unk1464::_ID14264();

    if ( var_1 == "minion" || var_1 == "elite" || var_1 == "mammoth" )
        return 0;

    return isdefined( var_0 ) && var_0 == "iw6_aliendlc22_mp";
}

do_pipebomb_death()
{
    playfx( level._ID1644["alien_gib"], self.origin + ( 0, 0, 32 ) );
}

is_pettrap_kill( var_0 )
{
    return isdefined( var_0 ) && isdefined( var_0.is_pet_trap );
}

general_alien_custom_death( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = isdefined( var_1 ) && isplayer( var_1 );

    if ( var_7 && isdefined( var_4 ) && maps\mp\alien\_unk1464::weapon_has_alien_attachment( var_4 ) && var_3 != "MOD_MELEE" && !maps\mp\alien\_unk1464::_ID18506( level._ID11234 ) )
    {
        playfx( level._ID1644["alien_ark_gib"], self.origin + ( 0, 0, 32 ) );
        return 1;
    }
    else
        return 0;
}
