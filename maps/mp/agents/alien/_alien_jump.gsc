// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID18995( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    maps\mp\agents\alien\_alien_anim_utils::_ID33987( var_2 - var_0 );
    var_7 = self scragentgetmaxturnspeed();
    thread _ID19009( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
    self waittill( "jump_finished" );
    _ID19003( var_7, var_3 );
}

_ID19003( var_0, var_1 )
{
    self scragentsetanimscale( 1.0, 1.0 );
    self scragentsetmaxturnspeed( var_0 );

    if ( maps\mp\alien\_unk1464::is_normal_upright( anglestoup( var_1 ) ) )
    {
        self scragentsetphysicsmode( "gravity" );
        self.oriented = 0;
        self.ignoreme = 0;
        return;
    }

    self scragentsetphysicsmode( "noclip" );
    self.oriented = 1;
    self.ignoreme = 1;
    return;
}

_ID19009( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self endon( "death" );
    self endon( "killanimscript" );
    maps\mp\agents\alien\_alien_anim_utils::_ID33987( var_2 - var_0 );

    if ( isdefined( var_6 ) )
        maps\mp\agents\alien\_alien_anim_utils::resetscriptable( var_6, var_2 );

    self.trajectoryactive = 0;
    var_7 = spawnstruct();
    var_8 = getjumpinfo( var_0, var_1, var_2, var_3, var_4 );
    _ID15076( var_8, var_7 );

    if ( isdefined( var_5 ) && isdefined( var_5._ID13439 ) )
        self [[ var_5._ID13439 ]]( var_8, var_7 );

    var_9 = _ID15083( var_0, var_1, var_2 );
    self scragentsetphysicsmode( "noclip" );
    self scragentsetorientmode( "face angle abs", var_9 );
    var_10 = 0;
    var_11 = self getanimentry( var_7.launchanimstate, var_7.launchanimentry );
    var_12 = self getanimentry( var_7._ID19328, var_7._ID19327 );
    var_13 = getnotetracktimes( var_12, "finish" );

    if ( var_13.size > 0 )
        var_14 = var_13[0] * getanimlength( var_12 );
    else
        var_14 = getanimlength( var_12 );

    var_15 = var_14 / var_7.playbackrate;
    var_16 = floor( var_15 * 20.0 );
    var_17 = var_16 / 20.0 / var_15;
    var_18 = getnotetracktimes( var_12, "stop_teleport" );

    if ( var_18.size > 0 )
    {
        var_19 = var_18[0] * var_15;
        var_20 = ceil( var_19 * 20.0 );
        var_21 = var_20 / 20.0 / var_15;
        var_22 = getmovedelta( var_12, var_21, var_17 );
    }
    else
    {
        var_19 = 0.8 * var_15;
        var_20 = ceil( var_19 * 20.0 );
        var_21 = var_20 / 20.0 / var_15;
        var_22 = getmovedelta( var_12, var_21, var_17 );
    }

    var_3 = getjumpendangles( var_0, var_2, var_3 );
    var_23 = rotatevector( var_22, var_3 );
    var_24 = var_2 - var_23;
    self scragentsetanimmode( "anim deltas" );
    self playsoundonmovingent( get_jump_sfx_alias() );

    if ( animhasnotetrack( var_11, "start_teleport" ) )
        maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( var_7.launchanimstate, var_7.launchanimentry, var_7.playbackrate, "jump_launch", "start_teleport" );
    else
        maps\mp\agents\_scriptedagents::playanimnatratefortime( var_7.launchanimstate, var_7.launchanimentry, var_7._ID23868, 0.5 * getanimlength( var_11 ) / var_7.playbackrate );

    var_25 = gettime();
    var_10 = self scragentdotrajectory( self.origin, var_24, var_8._ID19017 );
    self.trajectoryactive = 1;
    self endon( "jump_pain_interrupt" );
    thread _ID19016( var_10, var_2 );
    self notify( "jump_launching" );
    var_26 = self scragentgetmaxturnspeed();
    thread jumporient( var_8, var_3, var_26, var_10 );
    maps\mp\agents\_scriptedagents::_ID35786( "jump_launch", "end" );
    var_27 = ( gettime() - var_25 ) / 1000;
    var_28 = var_10 - var_27 - var_19;

    if ( var_28 > 0 )
        maps\mp\agents\_scriptedagents::playanimnatratefortime( var_7._ID17497, var_7.inairanimentry, var_7.playbackrate, var_28 );

    if ( isdefined( var_5 ) && isdefined( var_5._ID13437 ) )
        self [[ var_5._ID13437 ]]( var_8, var_7 );

    self setanimstate( var_7._ID19328, var_7._ID19327, var_7.playbackrate );
    self waittill( "traverse_complete" );
    self.trajectoryactive = 0;

    if ( isdefined( var_6 ) )
        maps\mp\agents\alien\_alien_anim_utils::playanimonscriptable( var_6, var_2 );

    self scragentsetanimscale( 1.0, 0.0 );
    self scragentsetmaxturnspeed( 20.2832 );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", var_3 );
    thread _ID35559( "jump_land" );
    maps\mp\agents\_scriptedagents::_ID35786( "jump_land", "end" );
    self scragentsetanimscale( 1.0, 1.0 );
    self setorigin( var_2, 0 );
    self notify( "jump_finished" );
}

_ID35559( var_0 )
{
    var_1 = maps\mp\alien\_unk1464::_ID14264();

    switch ( var_1 )
    {
        case "elite":
            maps\mp\agents\_scriptedagents::_ID35786( var_0, "jump_land_impact" );
            maps\mp\agents\alien\_alien_elite::_ID22758();
            break;
        default:
            break;
    }
}

jumporient( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    var_4 = ( 0, 0, 1 );
    var_5 = 0.85;
    var_6 = maps\mp\alien\_unk1464::is_normal_upright( var_0._ID31484 );
    var_7 = maps\mp\alien\_unk1464::is_normal_upright( var_0.endupvector );

    if ( var_6 && !var_7 )
    {
        var_8 = 0.5;
        var_9 = 1.0;
    }
    else if ( !var_6 && var_7 )
    {
        var_8 = 0.0;
        var_9 = 0.5;
    }
    else
    {
        var_8 = 0.0;
        var_9 = 1.0;
    }

    var_10 = var_9 - var_8;

    if ( var_8 > 0 )
        wait(var_3 * var_8);

    var_11 = 1.0;

    if ( distancesquared( self.angles, var_1 ) > var_11 )
    {
        var_12 = anglesdelta( self.angles, var_1 );
        var_13 = var_12 / var_3 * var_10;
        var_13 = var_13 * 3.14159 / 180.0;
        var_13 /= 20;
        self scragentsetmaxturnspeed( var_13 );
    }

    self scragentsetorientmode( "face angle abs", var_1 );
}

getjumpinfo( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = spawnstruct();
    var_6 = var_2 - var_0;
    var_7 = var_6 * ( 1, 1, 0 );
    var_7 = vectornormalize( var_7 );
    var_5._ID19711 = var_0 + var_7 * level.alienanimdata._ID19013;
    var_5._ID19332 = var_2;
    var_5._ID19019 = var_5._ID19332 - var_5._ID19711;
    var_5._ID19020 = var_5._ID19019 * ( 1, 1, 0 );
    var_5._ID19006 = length( var_5._ID19020 );
    var_5._ID19005 = var_5._ID19020 / var_5._ID19006;

    if ( isdefined( var_4 ) )
        var_5._ID19333 = var_4 - var_2;
    else if ( isdefined( self.enemy ) )
        var_5._ID19333 = self.enemy.origin - var_2;
    else
        var_5._ID19333 = anglestoforward( self.angles );

    var_5._ID31426 = _ID15075( var_5._ID19019, anglestoup( var_1 ) );
    var_5._ID11596 = _ID15075( var_5._ID19019, anglestoup( var_3 ) );
    var_5._ID31484 = anglestoup( var_5._ID31426 );
    var_5.endupvector = anglestoup( var_5._ID11596 );
    getjumpvelocity( var_5 );
    return var_5;
}

_ID15075( var_0, var_1 )
{
    var_2 = maps\mp\agents\alien\_alien_anim_utils::_ID25061( var_0, var_1 );
    var_3 = vectorcross( var_2, var_1 );
    var_4 = axistoangles( var_2, var_3, var_1 );
    return var_4;
}

getjumpvelocity( var_0 )
{
    var_1 = var_0._ID19006;
    var_2 = var_0._ID19019[2];
    var_3 = !maps\mp\alien\_unk1464::is_normal_upright( var_0.endupvector );
    var_4 = getjumpgravity( var_3 );
    var_5 = 1.01;
    var_6 = trajectorycalculateminimumvelocity( var_0._ID19711, var_0._ID19332, var_4 );
    var_7 = getjumpspeedmultiplier( var_3 );
    var_8 = var_6 * var_5 * var_7;
    var_9 = trajectorycalculateexitangle( var_8, var_4, var_1, var_2 );
    var_10 = cos( var_9 );
    var_0._ID19018 = var_0._ID19006 / var_8 * var_10;
    var_11 = var_4 * ( 0, 0, -1 );
    var_0.launchvelocity = trajectorycalculateinitialvelocity( var_0._ID19711, var_0._ID19332, var_11, var_0._ID19018 );
    var_0.launchvelocity2d = var_0.launchvelocity * ( 1, 1, 0 );
    var_0._ID19017 = length( var_0.launchvelocity2d );
}

getjumpspeedmultiplier( var_0 )
{
    if ( isdefined( self._ID20845 ) && self._ID20845 )
    {
        return level.alien_jump_melee_speed;
        return;
    }

    if ( var_0 )
    {
        return getdvarfloat( "agent_jumpWallSpeed" );
        return;
    }

    return getdvarfloat( "agent_jumpSpeed" );
    return;
    return;
}

getjumpgravity( var_0 )
{
    if ( isdefined( self._ID20845 ) && self._ID20845 )
    {
        return level._ID2791;
        return;
    }

    if ( var_0 )
    {
        return getdvarfloat( "agent_jumpWallGravity" );
        return;
    }

    return getdvarfloat( "agent_jumpGravity" );
    return;
    return;
}

getjumpplaybackrate( var_0, var_1 )
{
    var_2 = self getanimentry( var_1.launchanimstate, var_1.launchanimentry );
    var_3 = self getanimentry( var_1._ID17497, var_1.inairanimentry );
    var_4 = self getanimentry( var_1._ID19328, var_1._ID19327 );
    var_5 = getanimlength( var_2 );
    var_6 = var_5 * 0.5;
    var_7 = getnotetracktimes( var_2, "start_teleport" );

    if ( isdefined( var_7 ) && var_7.size > 0 )
        var_6 = var_5 - var_7[0] * var_5;

    var_8 = getanimlength( var_4 );
    var_9 = var_8 * 0.5;
    var_10 = getnotetracktimes( var_4, "stop_teleport" );

    if ( isdefined( var_10 ) && var_10.size > 0 )
        var_9 = var_10[0] * var_8;

    var_11 = getanimlength( var_3 );
    var_12 = ceil( var_0._ID19018 * 20.0 );
    var_13 = var_12 / 20.0;
    var_14 = var_11 + var_6 + var_9;
    var_15 = var_14 / var_13;
    var_16 = var_11 / var_15 + 0.1;
    var_17 = var_11 / var_16;
    return var_17;
}

_ID15076( var_0, var_1 )
{
    var_1.launchanimstate = _ID15116( var_0 );
    var_1.launchanimentry = getlaunchanimentry( var_0, var_1.launchanimstate );
    var_1._ID19328 = _ID15112( var_0 );
    var_1._ID19327 = _ID15111( var_0, var_1._ID19328 );
    var_1._ID17497 = _ID15064( var_0, var_1.launchanimstate, var_1._ID19328 );
    var_1.inairanimentry = _ID15063( var_0, var_1.launchanimstate, var_1._ID19328 );
    var_1.playbackrate = getjumpplaybackrate( var_0, var_1 );
}

_ID15083( var_0, var_1, var_2 )
{
    var_3 = anglestoup( var_1 );
    var_4 = vectornormalize( var_2 - var_0 );

    if ( vectordot( var_3, var_4 ) > 0.98 )
        var_4 = ( 0, 0, 1 );

    var_5 = vectorcross( var_3, var_4 );
    var_4 = vectorcross( var_5, var_3 );
    return axistoangles( var_4, -1 * var_5, var_3 );
}

_ID15116( var_0 )
{
    var_1 = 20;
    var_2 = cos( 90 - var_1 );
    var_3 = vectornormalize( var_0._ID19019 );
    var_4 = vectordot( var_3, var_0._ID31484 );

    if ( abs( var_4 ) <= var_2 )
    {
        return "jump_launch_level";
        return;
    }

    if ( var_4 > 0 )
    {
        return "jump_launch_up";
        return;
    }

    if ( var_4 < 0 )
    {
        return "jump_launch_down";
        return;
    }

    return;
    return;
}

getlaunchanimentry( var_0, var_1 )
{
    var_2 = vectornormalize( var_0.launchvelocity );
    var_2 = rotatevector( var_2, var_0._ID31426 );
    var_3 = self getanimentrycount( var_1 );
    var_4 = 0;
    var_5 = vectordot( level.alienanimdata._ID19012[var_1][var_4], var_2 );

    for ( var_6 = 1; var_6 < var_3; var_6++ )
    {
        var_7 = vectordot( level.alienanimdata._ID19012[var_1][var_6], var_2 );

        if ( var_7 > var_5 )
        {
            var_4 = var_6;
            var_5 = var_7;
        }
    }

    return var_4;
}

_ID15064( var_0, var_1, var_2 )
{
    return "jump_in_air";
}

_ID15063( var_0, var_1, var_2 )
{
    return level.alienanimdata.inairanimentry[var_1][var_2];
}

getjumpendangles( var_0, var_1, var_2 )
{
    var_3 = anglestoup( var_2 );
    var_4 = vectornormalize( var_1 - var_0 );

    if ( vectordot( var_3, var_4 ) > 0.98 )
        var_4 = ( 0, 0, 1 );

    var_5 = vectorcross( var_3, var_4 );
    var_4 = vectorcross( var_5, var_3 );
    return axistoangles( var_4, -1 * var_5, var_3 );
}

_ID15112( var_0 )
{
    var_1 = length( var_0._ID19019 );
    var_2 = 0.342;

    if ( !maps\mp\alien\_unk1464::is_normal_upright( var_0.endupvector ) )
    {
        var_3 = ( 0, 0, 1 );
        var_4 = vectordot( var_0._ID19019, var_3 ) / var_1;

        if ( var_4 > var_2 )
            return "jump_land_sidewall_low";
        else
            return "jump_land_sidewall_high";
    }

    var_4 = vectordot( var_0._ID19019, var_0.endupvector ) / var_1;

    if ( var_4 > var_2 )
    {
        return "jump_land_down";
        return;
    }

    if ( var_4 < var_2 * -1 )
    {
        return "jump_land_up";
        return;
    }

    return "jump_land_level";
    return;
    return;
}

_ID15111( var_0, var_1 )
{
    var_2 = maps\mp\agents\alien\_alien_anim_utils::_ID25061( var_0._ID19019, var_0.endupvector );
    var_3 = maps\mp\agents\alien\_alien_anim_utils::_ID25061( var_0._ID19333, var_0.endupvector );
    var_4 = var_2 - var_3;
    var_5 = vectorcross( var_3, var_0.endupvector );
    var_6 = vectornormalize( maps\mp\agents\alien\_alien_anim_utils::_ID25061( var_5, var_0.endupvector ) ) * 100;
    var_7 = vectordot( var_2 * -1, var_6 );
    var_8 = length( var_2 );
    var_9 = length( var_3 );
    var_10 = length( var_4 );
    var_11 = 0.001;

    if ( var_8 < var_11 || var_9 < var_11 )
        return 1;

    var_12 = ( var_8 * var_8 + var_9 * var_9 - var_10 * var_10 ) / 2 * var_8 * var_9;

    if ( var_12 <= -1 )
    {
        return 6;
        return;
    }

    if ( var_12 >= 1 )
    {
        return 1;
        return;
    }

    var_13 = acos( var_12 );

    if ( var_7 > 0 )
    {
        if ( 0 <= var_13 && var_13 < 22.5 )
        {
            return 1;
            return;
        }

        if ( 22.5 <= var_13 && var_13 < 67.5 )
        {
            return 2;
            return;
        }

        if ( 67.5 <= var_13 && var_13 < 112.5 )
        {
            return 4;
            return;
        }

        if ( 112.5 <= var_13 && var_13 < 157.5 )
        {
            return 7;
            return;
        }

        return 6;
        return;
        return;
        return;
        return;
        return;
    }

    if ( 0 <= var_13 && var_13 < 22.5 )
    {
        return 1;
        return;
    }

    if ( 22.5 <= var_13 && var_13 < 67.5 )
    {
        return 0;
        return;
    }

    if ( 67.5 <= var_13 && var_13 < 112.5 )
    {
        return 3;
        return;
    }

    if ( 112.5 <= var_13 && var_13 < 157.5 )
    {
        return 5;
        return;
    }

    return 6;
    return;
    return;
    return;
    return;
    return;
    return;
    return;
}

_ID19016( var_0, var_1 )
{
    self endon( "death" );
    self endon( "killanimscript" );
    self endon( "jump_finished" );
    var_2 = gettime();
    var_3 = var_0 * 1000;
    self waittill( "jump_pain",  var_4, var_5, var_6, var_7  );

    if ( !self.trajectoryactive )
        return;

    self notify( "jump_pain_interrupt" );
    var_8 = maps\mp\agents\alien\_alien_anim_utils::_ID15227( "jump_pain", var_6, var_7 );
    var_9 = maps\mp\agents\alien\_alien_anim_utils::_ID15226( "jump", var_4, var_5 );
    var_10 = maps\mp\agents\alien\_alien_anim_utils::_ID14961( var_6, var_7 );
    var_11 = var_2 * 0.001 + var_0;
    playinairjumppainanims( var_8, var_9, var_11, var_10 );
    self scragentsetanimscale( 1.0, 0.0 );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    var_12 = getimpactpainanimstate( var_10 );
    var_13 = maps\mp\agents\alien\_alien_anim_utils::getimpactpainanimindex( var_9 );
    self setanimstate( var_12, var_13, 1.0 );
    maps\mp\agents\_scriptedagents::_ID35786( var_12, "code_move" );
    self notify( "jump_finished" );
}

playinairjumppainanims( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    self endon( "killanimscript" );
    self endon( "jump_finished" );
    self setanimstate( var_0, var_1, 1.0 );
    var_4 = common_scripts\utility::_ID35635( "jump_pain", "traverse_complete" );

    if ( var_4 == "traverse_complete" )
        return;

    var_5 = var_2 - gettime() * 0.001;

    if ( var_5 > 0 )
    {
        var_6 = 2.0;
        var_7 = _ID15080( var_3 );
        var_8 = self getanimentry( var_7, var_1 );
        var_9 = getanimlength( var_8 );
        var_10 = min( var_6, var_9 / var_5 );
        self setanimstate( var_7, var_1, var_10 );
    }

    self waittill( "traverse_complete" );
}

_ID15080( var_0 )
{
    return "jump_pain_idle_" + var_0;
}

getimpactpainanimstate( var_0 )
{
    return "jump_impact_pain_" + var_0;
}

get_jump_sfx_alias()
{
    switch ( maps\mp\alien\_unk1464::_ID14264() )
    {
        case "elite":
            return "null";
        case "spitter":
            return "spitter_jump";
        case "seeder":
            return "seed_jump";
        case "gargoyle":
            return "gg_jump";
        default:
            return "alien_jump";
    }
}
