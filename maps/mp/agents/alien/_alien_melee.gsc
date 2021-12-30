// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    self endon( "killanimscript" );
    self.enemy thread melee_clean_up( self );
    self scragentsetorientmode( "face enemy" );
    self._ID24606 = 0;
    self._ID20845 = 0;
    self.melee_jumping_to_wall = 0;
    self.melee_success = 0;
    self.melee_synch = 0;
    var_0 = gettime();
    self.lastattacktime = var_0;

    switch ( self._ID20883 )
    {
        case "swipe":
            _ID20877( self.enemy );
            break;
        case "leap":
            _ID20848( self.enemy );
            break;
        case "wall":
            _ID20888( self.enemy );
            break;
        case "synch":
            melee_synch_attack( self.enemy );
            break;
        case "swipe_static":
            _ID20878( self.enemy );
            break;
        case "badpath_jump":
            badpath_jump( self.enemy );
            break;
        case "spit":
            maps\mp\agents\alien\_alien_spitter::_ID31017( self.enemy );
            break;
        case "charge":
            maps\mp\agents\alien\_alien_elite::do_charge_attack( self.enemy );
            break;
        case "slam":
            maps\mp\agents\alien\_alien_elite::do_ground_slam( self.enemy );
            break;
        case "angered":
            maps\mp\agents\alien\_alien_elite::activate_angered_state();
            break;
        case "explode":
            maps\mp\agents\alien\_alien_minion::explode( self.enemy );
            break;
        default:
            if ( isdefined( level._ID37116 ) )
            {
                self [[ level._ID37116 ]]( self.enemy );
                jump loc_F0
            }

            break;
    }

    if ( self._ID24606 )
        self waittill( "pain_finished" );

    if ( var_0 == gettime() )
        wait 0.05;

    self notify( "melee_complete" );
}

end_script()
{
    self.allowpain = 1;
    self scragentsetanimscale( 1, 1 );
    self._ID24939 = "melee";
    self._ID20841 = 0;
    maps\mp\alien\_unk1464::_ID28197( 0.2 );
}

_ID20877( var_0 )
{
    self endon( "melee_pain_interrupt" );
    var_1 = common_scripts\utility::_ID25350( [ "swipe", "bite", "random" ] );
    var_2 = _ID33770( var_1, var_0, 56, 90 );

    if ( var_2 != 2 )
    {
        var_3 = _ID10312( var_1, 2, var_0, 0.8, 56, 90 );

        if ( !var_3 && var_2 == 0 )
            _ID33767( var_0 );
    }

    _ID21556( var_0 );
}

_ID33767( var_0 )
{
    var_1 = 10000;

    if ( !isdefined( var_0 ) )
        return;

    self._ID19777 = _ID14544( 1.0, 48, var_0 );
    self._ID19777 = maps\mp\agents\_scriptedagents::droppostoground( self._ID19777, 64 );

    if ( !isdefined( self._ID19777 ) )
        return;

    if ( distancesquared( self.origin, self._ID19777 ) < var_1 )
        return;

    if ( !trajectorycanattemptaccuratejump( self.origin, anglestoup( self.angles ), self._ID19777, anglestoup( var_0.angles ), level._ID2791, 1.01 * level.alien_jump_melee_speed ) )
        return;

    var_2 = getnodesinradiussorted( self._ID19777, 256, 0, 256 );

    if ( !var_2.size )
        return;

    var_3 = getpathdist( self._ID19777, var_2[0].origin, 512 );

    if ( var_3 < 0 )
        return;

    _ID20848( var_0 );
}

_ID33770( var_0, var_1, var_2, var_3 )
{
    var_4 = 0;

    if ( _ID10312( var_0, 0, var_1, 1.0, var_2, var_3 ) )
        var_4 = 1;

    if ( common_scripts\utility::_ID7657() )
        var_5 = _ID10312( var_0, 1, var_1, 1.0, var_2, var_3 );
    else
        var_5 = 0;

    if ( var_5 )
        var_4++;

    return var_4;
}

_ID10312( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = _ID14282( var_0 );
    var_7 = 0;

    if ( !isalive( var_2 ) )
        return 0;

    maps\mp\alien\_unk1464::_ID28196( 0.2, 1.0 );
    self playsoundonmovingent( "alien_attack" );
    var_8 = self getanimentry( var_6, var_1 );
    var_9 = getanimlength( var_8 );
    var_10 = _ID14588( var_9, var_4, var_2, var_3 );

    if ( isdefined( var_10 ) && _ID18521( var_10 ) )
    {
        var_8 = self getanimentry( var_6, var_1 );
        var_11 = getmovedelta( var_8 );
        var_12 = length2d( var_11 );
        var_13 = var_10 - self.origin;
        var_14 = var_2.origin - self.origin;

        if ( var_12 == 0 || vectordot( var_13, var_14 ) < 0 )
            var_15 = 0;
        else
        {
            var_16 = max( 0, length2d( var_13 ) );
            var_15 = var_16 / var_12;
        }

        var_7 = _ID23423( var_6, var_1, var_2, var_5, var_15 );
    }
    else
        var_7 = _ID23423( "attack_melee_swipe", var_1, var_2, 200, 0.0 );

    return var_7;
}

_ID23423( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = 0;
    self scragentsetphysicsmode( "gravity" );
    self scragentsetanimscale( var_4, 0.0 );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face enemy" );
    var_6 = randomfloatrange( 0.9, 1.0 );
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( var_0, var_1, var_6, "attack_melee", "start_melee" );
    maps\mp\alien\_unk1464::_ID28197( 0.2 );

    if ( isalive( var_2 ) )
    {
        var_7 = distancesquared( self.origin, var_2.origin );

        if ( distancesquared( self.origin, var_2.origin ) < var_3 * var_3 )
        {
            _ID20825( var_2, "swipe" );
            var_5 = 1;
        }
    }

    maps\mp\agents\_scriptedagents::_ID35786( "attack_melee", "end" );
    return var_5;
}

_ID14282( var_0 )
{
    var_1 = [ "attack_melee_swipe", "attack_melee_swipe", "attack_melee_bite", "attack_melee_bite_2" ];

    switch ( var_0 )
    {
        case "random":
            return common_scripts\utility::_ID25350( var_1 );
        case "swipe":
            return "attack_melee_swipe";
        case "bite":
            return common_scripts\utility::_ID25350( [ "attack_melee_bite", "attack_melee_bite_2" ] );
        default:
            break;
    }

    return undefined;
}

_ID18521( var_0 )
{
    var_1 = 90000.0;
    var_2 = 17.0;

    if ( distancesquared( self.origin, var_0 ) > var_1 )
        return 0;

    return maps\mp\agents\_scriptedagents::canmovepointtopoint( self.origin, var_0, var_2 );
}

_ID14544( var_0, var_1, var_2, var_3 )
{
    var_4 = self.origin - var_2.origin;
    var_4 *= ( 1, 1, 0 );
    var_4 = vectornormalize( var_4 ) * var_1;

    if ( !isdefined( var_3 ) )
        var_3 = 1.0;

    if ( isplayer( var_2 ) )
    {
        var_5 = var_2 getvelocity();
        var_6 = 200.0;

        if ( lengthsquared( var_5 ) > var_6 * var_6 )
        {
            var_5 = vectornormalize( var_5 );
            var_5 *= var_6;
        }

        var_5 *= var_3;
        var_5 *= var_0;
    }
    else
        var_5 = ( 0, 0, 0 );

    return var_2.origin + var_4 + var_5;
}

_ID14588( var_0, var_1, var_2, var_3 )
{
    var_4 = _ID14544( var_0, var_1, var_2, var_3 );

    if ( isdefined( self.bad_path_handled ) && self.bad_path_handled )
    {
        var_5 = 40.0;
        self.bad_path_handled = 0;
    }
    else
        var_5 = 18.0;

    var_6 = 0.57735;
    var_7 = 56.0;
    var_8 = clamp( var_6 * distance2d( self.origin, var_4 ), var_5, var_7 );
    var_4 = maps\mp\agents\_scriptedagents::droppostoground( var_4, var_8 );
    return var_4;
}

_ID20848( var_0 )
{
    _ID20849( var_0, "leap" );
}

_ID20849( var_0, var_1 )
{
    _ID23788( var_1 );
    var_2 = spawnstruct();
    var_2._ID13439 = ::melee_setjumpanimstates;
    var_2._ID13437 = ::_ID20814;
    var_3 = self._ID19777;

    if ( isdefined( var_3 ) )
    {
        var_4 = maps\mp\alien\_unk1464::_ID29814();

        if ( !var_4 )
            thread _ID20850( var_0, var_1 );

        self._ID20845 = 1;
        maps\mp\alien\_unk1464::_ID28196( 0.2, 1.0 );
        maps\mp\agents\alien\_alien_jump::_ID18995( self.origin, self.angles, var_3, var_0.angles, undefined, var_2 );
        maps\mp\alien\_unk1464::_ID28197( 0.2 );
        self._ID20845 = 0;

        if ( var_4 )
        {
            maps\mp\agents\alien\_alien_minion::explode( self.enemy );
            return;
        }

        _ID21556( var_0 );
        return;
        return;
    }

    wait 0.05;
    return;
}

_ID23788( var_0 )
{
    switch ( var_0 )
    {
        case "leap":
            self playsoundonmovingent( "alien_jump" );
            break;
        case "wall":
            self playsoundonmovingent( "alien_attack" );
            break;
        default:
            break;
    }
}

_ID20850( var_0, var_1 )
{
    self endon( "killanimscript" );
    self endon( "melee_pain_interrupt" );
    self endon( "jump_pain_interrupt" );
    var_2 = 6400;

    for (;;)
    {
        if ( !isdefined( var_0 ) || !isalive( var_0 ) )
            break;

        if ( distance2dsquared( self.origin, var_0.origin ) <= var_2 )
        {
            _ID20825( var_0, var_1 );
            break;
        }

        wait 0.1;
    }
}

melee_setjumpanimstates( var_0, var_1 )
{
    var_1._ID19328 = "attack_leap_swipe";
    var_1._ID19327 = maps\mp\agents\_scriptedagents::getrandomanimentry( "attack_leap_swipe" );
}

_ID20814( var_0, var_1 )
{
    var_2 = 0.707;

    if ( isalive( self.enemy ) )
    {
        var_3 = vectornormalize( self.enemy.origin - var_0._ID19332 );
        var_4 = anglestoforward( var_0._ID11596 );
        var_5 = vectordot( var_3, var_4 );

        if ( var_5 > var_2 )
            return;

        var_6 = anglestoright( var_0._ID11596 );
        var_7 = vectordot( var_3, var_6 );

        if ( var_7 > var_2 )
        {
            var_1._ID19328 = "attack_leap_swipe_right";
            var_1._ID19327 = maps\mp\agents\_scriptedagents::getrandomanimentry( "attack_leap_swipe_right" );
            return;
        }

        if ( var_7 < var_2 * -1 )
        {
            var_1._ID19328 = "attack_leap_swipe_left";
            var_1._ID19327 = maps\mp\agents\_scriptedagents::getrandomanimentry( "attack_leap_swipe_left" );
            return;
        }

        return;
        return;
    }
}

_ID20878( var_0 )
{
    self endon( "melee_pain_interrupt" );

    if ( !_ID10312( "swipe", 2, var_0, 1.0, 56, 90 ) )
    {
        wait 0.05;
        return;
    }
}

melee_synch_attack( var_0 )
{
    if ( isdefined( self._ID36479 ) )
        self scragentsetanimscale( self._ID36479, 1.0 );

    self.melee_synch = 1;
    var_1 = self getanimentry( self._ID32296, 0 );
    var_2 = var_0 maps\mp\alien\_unk1464::_ID14774( self );
    var_3 = anglestoup( var_0.angles );
    var_4 = vectornormalize( var_0.origin - self._ID32299 );
    var_5 = vectorcross( var_4, var_3 );
    var_6 = axistoangles( var_4, var_5, var_3 );
    maps\mp\agents\alien\_alien_anim_utils::_ID33987( anglestoforward( var_6 ) );

    if ( !isdefined( var_0 ) )
        return;

    self setplayerangles( var_6 );
    self scragentsetorientmode( "face angle abs", var_6 );
    thread _ID32297( var_1, self._ID32299, var_6 );
    var_7 = var_2[self._ID32298]["attackerAnimLabel"];
    play_synch_attack( self._ID32298, self._ID32296, var_0, var_7, var_2 );

    if ( isdefined( var_0 ) )
        var_0 notify( "synched_attack_over" );

    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( self._ID32296, 2, var_7, "end" );
    self.melee_synch = 0;
}

play_synch_attack( var_0, var_1, var_2, var_3, var_4 )
{
    level endon( "game_ended" );

    foreach ( var_6 in var_2._ID32300.end_notifies )
        var_2 endon( var_6 );

    var_8 = self getanimentry( var_1, 2 );
    var_9 = getanimlength( var_8 );
    var_2 thread enemy_process_synch_attack( self, var_0, var_9, var_4 );
    var_10 = self getanimentry( var_1, 0 );
    var_11 = var_4[var_0]["enterAnim"];
    var_2 [[ var_2._ID32300._ID5048 ]]( var_11 );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_1, 0, var_3, "end" );

    if ( !isdefined( var_2 ) )
        return;

    var_11 = var_4[var_0]["loopAnim"];
    thread apply_synch_attack_damage( var_2 );

    while ( isdefined( var_2 ) )
    {
        var_2 [[ var_2._ID32300._ID20325 ]]( var_11 );
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_1, 1, var_3, "end" );
    }
}

apply_synch_attack_damage( var_0 )
{
    self endon( "death" );
    self endon( "enemy" );
    var_0 endon( "enemy_synch_end_notify" );
    var_0 endon( "synched_attack_over" );
    var_0 endon( "death" );

    foreach ( var_2 in var_0._ID32300.end_notifies )
        var_0 endon( var_2 );

    var_4 = 1.0;

    if ( isdefined( self.alien_type ) )
    {
        var_5 = level._ID2829[self.alien_type].attributes["synch_min_damage_per_second"] * level._ID8862;
        var_6 = level._ID2829[self.alien_type].attributes["synch_max_damage_per_second"] * level._ID8862;
        var_4 = randomfloatrange( var_5, var_6 );
    }

    var_7 = gettime();

    for (;;)
    {
        var_8 = gettime();
        var_9 = ( var_8 - var_7 ) * 0.001;
        var_10 = var_4 * var_9;
        var_0 dodamage( var_10, self.origin, self, self );
        wait 0.1;
        var_7 = var_8;
    }
}

_ID32297( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_3 = getanimlength( var_0 );
    var_4 = min( 0.2, var_3 );
    var_5 = getmovedelta( var_0, 0, var_4 / var_3 );

    if ( isdefined( self._ID36479 ) )
        var_5 *= self._ID36479;

    var_6 = rotatevector( var_5, var_2 );
    self scragentdoanimlerp( self.origin, var_1 + var_6, var_4 );
    wait(var_4);
    self scragentsetanimmode( "anim deltas" );
}

enemy_process_synch_attack( var_0, var_1, var_2, var_3 )
{
    var_4 = enemy_wait_for_synch_attack_end( var_0, var_1 );

    if ( !isdefined( self ) )
        return;

    var_5 = undefined;

    if ( var_4 )
        var_5 = var_3[var_1]["exitAnim"];

    self [[ self._ID32300._ID11514 ]]( var_5, var_2 );

    if ( isdefined( self ) )
    {
        self._ID32300.primary_attacker = undefined;
        return;
    }
}

enemy_wait_for_synch_attack_end( var_0, var_1 )
{
    thread enemy_wait_for_synch_invalid_enemy( var_0 );

    foreach ( var_3 in self._ID32300.end_notifies )
        thread enemy_wait_for_synch_end_notify( var_3 );

    var_5 = common_scripts\utility::_ID35635( "enemy_synch_end_notify", "synched_attack_over", "enemy_synch_invalid_enemy" );
    return isdefined( var_5 ) && var_5 != "enemy_synch_end_notify";
}

enemy_wait_for_synch_end_notify( var_0 )
{
    self endon( "enemy_synch_end_notify" );
    self endon( "synched_attack_over" );
    self endon( "enemy_synch_invalid_enemy" );
    self waittill( var_0 );
    self notify( "enemy_synch_end_notify" );
}

enemy_wait_for_synch_invalid_enemy( var_0 )
{
    self endon( "synched_attack_over" );
    self endon( "enemy_synch_end_notify" );
    self endon( "death" );
    level endon( "game_ended" );
    wait 0.05;

    for (;;)
    {
        if ( !isalive( var_0 ) )
            break;

        if ( !isdefined( var_0.enemy ) || var_0.enemy != self )
            break;

        wait 0.05;
    }

    self notify( "enemy_synch_invalid_enemy" );
}

_ID20888( var_0 )
{
    var_1 = 800;
    var_2 = 168;
    var_3 = self._ID35832;
    self.melee_jumping_to_wall = 1;
    maps\mp\agents\alien\_alien_jump::_ID18995( self.origin, self.angles, var_3.origin, var_3.angles, var_0.origin );
    self.melee_jumping_to_wall = 0;

    if ( !isalive( var_0 ) )
        return;

    if ( maps\mp\agents\alien\_alien_think::can_leap_melee( var_0, var_1, var_2 ) )
    {
        _ID20849( var_0, "wall" );
        return;
    }
}

badpath_jump( var_0 )
{
    self._ID20845 = 1;
    maps\mp\agents\alien\_alien_jump::_ID18995( self.origin, self.angles, self._ID19777, self._ID19776, undefined );
    self._ID20845 = 0;
}

_ID20825( var_0, var_1 )
{
    if ( !isalive( var_0 ) )
        return;

    self.melee_success = 1;
    var_2 = 1;

    if ( isdefined( self.alien_type ) )
    {
        var_3 = level._ID2829[self.alien_type].attributes[var_1 + "_min_damage"];
        var_4 = level._ID2829[self.alien_type].attributes[var_1 + "_max_damage"];

        if ( maps\mp\alien\_unk1464::_ID14264() == "elite" && isdefined( self.elite_angered ) )
        {
            var_3 *= maps\mp\agents\alien\_alien_elite::get_angered_damage_scalar();
            var_4 *= maps\mp\agents\alien\_alien_elite::get_angered_damage_scalar();
        }

        var_2 = randomfloatrange( var_3, var_4 );
    }

    if ( isdefined( self.pet ) && self.pet )
    {
        if ( maps\mp\alien\_unk1464::_ID18506( self.upgraded ) )
            var_2 *= 10;
        else
            var_2 *= 6;
    }

    if ( isplayer( var_0 ) )
    {
        var_5 = check_for_block( var_0 );
        var_6 = check_for_player_meleeing( var_0 );

        if ( var_5 || var_6 )
            return;
        else
        {
            if ( isdefined( var_0._ID18666 ) && var_0._ID18666 )
            {
                var_2 *= 0.65;
                earthquake( 0.25, 0.25, var_0.origin, 100 );
            }

            var_0 _ID28276( var_2 );
            var_0 playlocalsound( "Player_hit_sfx_alien" );
        }
    }

    if ( var_0.model == "mp_laser_drill" && level.script == "mp_alien_dlc3" )
        var_2 *= 2;

    var_0 dodamage( var_2, self.origin, self, self );
}

_ID28276( var_0 )
{
    var_1 = 10;
    var_2 = 2;
    var_3 = 50;

    if ( maps\mp\alien\_persistence::is_upgrade_enabled( "less_flinch_upgrade" ) )
        var_1 = 0;

    var_4 = min( 1, var_0 / var_3 );
    var_5 = ( var_1 - var_2 ) * var_4;
    var_6 = var_2 + var_5;

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
    {
        if ( maps\mp\alien\_unk1464::_ID18745() )
            var_6 /= 1.6;
        else
            var_6 /= 2.2;
    }

    self setviewkickscale( var_6 );
}

_ID21556( var_0, var_1 )
{
    self endon( "melee_pain_interrupt" );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( var_1 || _ID29826( var_0 ) )
    {
        var_2 = getmovebackstate();
        var_3 = getmovebackentry( var_2 );
        var_4 = self getanimentry( var_2, var_3 );
        var_5 = maps\mp\agents\_scriptedagents::_ID15326( var_4 );

        if ( _ID16361( var_5 ) )
        {
            self._ID20841 = 1;
            self scragentsetanimmode( "anim deltas" );
            self scragentsetphysicsmode( "gravity" );
            self scragentsetanimscale( var_5, 1.0 );
            self setanimstate( var_2, var_3, 1.0 );
            maps\mp\agents\_scriptedagents::_ID35786( "move_back", "finish" );
            self._ID20841 = 0;
        }

        if ( var_1 || _ID29831( var_0 ) )
        {
            self.melee_in_posture = 1;
            maps\mp\alien\_unk1464::_ID28196( 0.2, 0.8 );
            var_6 = maps\mp\agents\_scriptedagents::getrandomanimentry( "posture" );
            self setanimstate( "posture", var_6, 1.0 );
            self scragentsetorientmode( "face angle abs", self.angles );
            maps\mp\agents\_scriptedagents::_ID35786( "posture", "end" );
            maps\mp\alien\_unk1464::_ID28197( 0.2 );
            self.melee_in_posture = 0;
            return;
        }

        if ( _ID29827( var_0 ) )
        {
            move_side();
            return;
        }

        return;
        return;
    }
}

move_side()
{
    self endon( "melee_pain_interrupt" );

    if ( common_scripts\utility::_ID7657() )
    {
        if ( !_ID33768( "melee_move_side_left" ) )
        {
            _ID33768( "melee_move_side_right" );
            return;
        }

        return;
    }

    if ( !_ID33768( "melee_move_side_right" ) )
    {
        _ID33768( "melee_move_side_left" );
        return;
    }

    return;
}

_ID33768( var_0 )
{
    var_1 = maps\mp\agents\_scriptedagents::getrandomanimentry( var_0 );
    var_2 = self getanimentry( var_0, var_1 );
    var_3 = maps\mp\agents\_scriptedagents::_ID15326( var_2 );
    var_3 = min( var_3, self._ID36479 );

    if ( var_3 > 0.5 )
    {
        self scragentsetanimmode( "anim deltas" );
        self scragentsetphysicsmode( "gravity" );
        self scragentsetanimscale( var_3, 1.0 );
        self setanimstate( var_0, var_1, 1.0 );
        maps\mp\agents\_scriptedagents::_ID35786( "move_side", "finish" );
        return 1;
    }

    return 0;
}

_ID29826( var_0 )
{
    var_1 = 10000.0;

    if ( isalive( var_0 ) && distancesquared( self.origin, var_0.origin ) > var_1 )
        return 0;

    return 1;
}

_ID29831( var_0 )
{
    return isalive( var_0 ) && randomint( 100 ) < 20;
}

_ID29827( var_0 )
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "elite":
        case "spitter":
        case "mammoth":
        case "seeder":
            return 0;
        default:
            return isalive( var_0 ) && randomint( 100 ) < 60;
    }
}

_ID16361( var_0 )
{
    var_1 = 0.5;
    return var_0 >= var_1;
}

getmovebackstate()
{
    return "melee_move_back";
}

getmovebackentry( var_0 )
{
    var_1 = randomintrange( 0, 101 );
    var_2 = 0;
    var_3 = undefined;

    for ( var_4 = 0; var_4 < level.alienanimdata.alienmovebackanimchance.size; var_4++ )
    {
        var_2 += level.alienanimdata.alienmovebackanimchance[var_4];

        if ( var_1 <= var_2 )
        {
            var_3 = var_4;
            break;
        }
    }

    return var_3;
}

_ID22790( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( candopain( var_4, var_1 ) )
    {
        dopain( var_3, var_2, var_4, var_7, var_8 );
        return;
    }
}

candopain( var_0, var_1 )
{
    if ( isdefined( level.dlc_can_do_pain_override_func ) )
    {
        var_2 = [[ level.dlc_can_do_pain_override_func ]]( "melee" );

        if ( !var_2 )
            return 0;
    }

    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "elite":
        case "mammoth":
            return 0;
        default:
            var_3 = maps\mp\alien\_unk1464::_ID18462( var_1, var_0 );
            return var_3 && !self._ID20845 && !self.melee_jumping_to_wall && !self._ID24606 && !self.statelocked && !self.melee_synch;
    }
}

dopain( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "killanimscript" );
    self._ID24606 = 1;
    self notify( "melee_pain_interrupt" );

    if ( isdefined( self.oriented ) && self.oriented )
        self scragentsetanimmode( "code_move" );
    else
    {
        self scragentsetorientmode( "face angle abs", self.angles );
        self scragentsetanimmode( "anim deltas" );
    }

    var_5 = var_0 & level._ID17348;
    var_6 = get_melee_painstate_info( var_1, var_2, var_5 );
    var_7 = getmeleepainanimindex( var_6["anim_state"], var_3, var_4 );
    var_8 = self getanimentry( var_6["anim_state"], var_7 );
    maps\mp\alien\_unk1464::always_play_pain_sound( var_8 );
    maps\mp\alien\_unk1464::_ID25692( var_8 );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( var_6["anim_state"], var_7, var_6["anim_label"] );
    self._ID24606 = 0;
    self notify( "pain_finished" );
}

getmeleepainanimindex( var_0, var_1, var_2 )
{
    switch ( var_0 )
    {
        case "pain_pushback":
            return maps\mp\agents\alien\_alien_anim_utils::_ID15226( "push_back", var_1 );
        case "idle_pain_light":
        case "idle_pain_heavy":
            return maps\mp\agents\alien\_alien_anim_utils::_ID15226( "idle", var_1, var_2 );
        case "move_back_pain_light":
        case "move_back_pain_heavy":
            return maps\mp\agents\alien\_alien_anim_utils::_ID15226( "move_back", var_1 );
        case "melee_pain_light":
        case "melee_pain_heavy":
            return maps\mp\agents\alien\_alien_anim_utils::_ID15226( "melee", var_1 );
    }

    endswitch( 8 )  case "melee_pain_heavy" loc_1285 case "melee_pain_light" loc_1285 case "move_back_pain_heavy" loc_1279 case "move_back_pain_light" loc_1279 case "idle_pain_heavy" loc_126C case "idle_pain_light" loc_126C case "pain_pushback" loc_1260 default loc_1291
}

check_for_player_meleeing( var_0 )
{
    var_1 = anglestoforward( var_0.angles );
    var_2 = vectornormalize( self.origin - var_0.origin );
    var_3 = vectordot( var_2, var_1 );

    if ( var_0 meleebuttonpressed() && isdefined( var_0.meleestrength ) && var_0.meleestrength == 1 && var_3 > 0.5 )
    {
        return 1;
        return;
    }

    return 0;
    return;
}

check_for_block( var_0 )
{
    if ( !isplayer( var_0 ) )
        return 0;

    if ( !var_0.hasriotshield )
        return 0;

    var_1 = 0;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;
    var_5 = var_0 maps\mp\alien\_unk1464::_ID26334();

    if ( !isdefined( var_5 ) )
        return 0;

    var_6 = var_0 getweaponammoclip( var_5 );
    var_7 = anglestoforward( var_0.angles );
    var_8 = vectornormalize( self.origin - var_0.origin );
    var_9 = vectordot( var_8, var_7 );

    if ( var_9 > 0.5 )
        var_1 = 1;

    if ( var_9 < -0.5 )
        var_2 = 1;

    if ( var_0._ID16417 && var_1 && var_6 > 0 )
        var_3 = 1;
    else if ( !var_0._ID16417 && var_2 && var_6 > 0 )
    {
        var_4 = 1;
        var_10 = should_catch_fire( var_0 );

        if ( var_10 )
            thread maps\mp\alien\_damage::catch_alien_on_fire( var_0, 1, 75 );
    }

    if ( var_3 || var_4 )
    {
        var_0 setweaponammoclip( var_5, var_6 - 1 );
        var_0 notify( "riotshield_block" );
        var_0 setclientomnvar( "ui_alien_stowed_riotshield_ammo", var_6 - 1 );
        var_0 playsound( "melee_riotshield_impact" );
        earthquake( 0.75, 0.5, var_0.origin, 100 );

        if ( maps\mp\alien\_unk1464::_ID29838( var_0 ) )
            var_0 maps\mp\alien\_damage::applyaliensnare();

        if ( var_0 getweaponammoclip( var_5 ) == 0 )
        {
            if ( var_0 hasweapon( var_5 ) )
            {
                var_0 takeweapon( var_5 );
                var_0.hasriotshield = 0;
                var_0._ID16417 = 0;

                if ( var_3 )
                {
                    var_0 detachshieldmodel( "weapon_riot_shield_iw6", "tag_weapon_right" );
                    var_0 playsound( "melee_riotshield_impact" );
                    var_0 iprintlnbold( &"ALIENS_HANDY_RIOT_DESTROYED" );
                }

                if ( var_4 )
                {
                    var_0 detachshieldmodel( "weapon_riot_shield_iw6", "tag_shield_back" );
                    var_0 playsound( "melee_riotshield_impact" );
                    var_0 iprintlnbold( &"ALIENS_STOWED_RIOT_DESTROYED" );
                }

                var_0 setclientomnvar( "ui_alien_riotshield_equipped", -1 );
            }

            var_11 = var_0 getweaponslist( "primary" );

            if ( var_11.size > 0 && var_3 )
                var_0 switchtoweapon( var_11[0] );
        }

        return 1;
    }

    return 0;
}

should_catch_fire( var_0 )
{
    if ( var_0 maps\mp\alien\_persistence::is_upgrade_enabled( "riotshield_back_upgrade" ) && self.alien_type != "spider" && self.alien_type != "kraken_tentacle" && self.alien_type != "kraken" )
    {
        return 1;
        return;
    }

    return 0;
    return;
}

melee_clean_up( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_1 = var_0 maps\mp\alien\_unk1464::_ID14264();
    var_0 waittill( "killanimscript" );

    if ( var_1 == "elite" || var_1 == "mammoth" )
    {
        self.being_charged = 0;
        return;
    }
}

get_melee_painstate_info( var_0, var_1, var_2 )
{
    var_3 = [];

    if ( var_1 == "MOD_MELEE" )
    {
        var_3["anim_label"] = "pain_pushback";
        var_3["anim_state"] = "pain_pushback";
        return var_3;
    }

    switch ( self._ID20883 )
    {
        case "spit":
            var_3["anim_state"] = "idle_pain_light";
            var_3["anim_label"] = "idle_pain";
            break;
        default:
            if ( self._ID20841 )
            {
                var_4 = "move_back_pain";
                var_3["anim_label"] = "move_back_pain";
            }
            else if ( self.melee_in_posture )
            {
                var_4 = "idle_pain";
                var_3["anim_label"] = "idle_pain";
            }
            else
            {
                var_4 = "melee_pain";
                var_3["anim_label"] = "melee_pain";
            }

            var_3["anim_state"] = maps\mp\agents\alien\_alien_anim_utils::_ID15227( var_4, var_0, var_2 );
            break;
    }

    return var_3;
}
