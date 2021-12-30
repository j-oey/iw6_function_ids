// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

elite_approach( var_0, var_1 )
{
    if ( distancesquared( var_0.origin, self.origin ) > 250000 )
        maps\mp\agents\alien\_alien_think::run_near_enemy( 500, var_0 );

    for (;;)
    {
        if ( can_do_charge_attack( var_0 ) )
            return "charge";
        else if ( _ID27007( var_0 ) )
            return "slam";

        wait 0.05;
    }
}

_ID27007( var_0 )
{
    thread _ID21307( var_0 );
    thread _ID27005( var_0 );
    var_1 = common_scripts\utility::_ID35635( "run_to_slam_complete", "in_charge_range", "enemy", "bad_path" );

    if ( !self agentcanseesentient( var_0 ) )
        return 0;

    return var_1 == "run_to_slam_complete";
}

_ID27005( var_0 )
{
    var_0 endon( "death" );
    self endon( "enemy" );
    self endon( "bad_path" );
    var_1 = gettime();
    maps\mp\agents\alien\_alien_think::run_near_enemy( 175, var_0 );

    if ( var_1 == gettime() )
        wait 0.05;

    self notify( "run_to_slam_complete" );
}

_ID21307( var_0 )
{
    self endon( "goal_reached" );
    var_0 endon( "death" );
    self endon( "enemy" );
    self endon( "bad_path" );
    var_1 = 122500;
    wait 0.05;

    for (;;)
    {
        if ( distancesquared( self.origin, var_0.origin ) >= var_1 )
            break;

        wait 0.2;
    }

    self notify( "in_charge_range" );
}

can_do_charge_attack( var_0 )
{
    if ( gettime() < self.last_charge_time + 12000 )
        return 0;

    if ( distancesquared( self.origin, var_0.origin ) < 122500 )
        return 0;

    if ( !maps\mp\agents\_scriptedagents::canmovepointtopoint( self.origin, var_0.origin ) )
        return 0;

    return maps\mp\alien\_unk1464::is_normal_upright( anglestoup( self.angles ) );
}

_ID15818( var_0 )
{
    self._ID20883 = "slam";
    maps\mp\agents\alien\_alien_think::alien_melee( var_0 );
}

do_ground_slam( var_0 )
{
    self endon( "death" );
    maps\mp\agents\alien\_alien_anim_utils::_ID33986( var_0 );
    self scragentsetorientmode( "face enemy" );
    maps\mp\agents\alien\_alien_melee::_ID33770( "swipe", var_0, 125, 175 );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "attack_melee_swipe", 2, "attack_melee", "alien_slam_big" );
    var_1 = level._ID2829[self.alien_type].attributes["slam_min_damage"];
    var_2 = level._ID2829[self.alien_type].attributes["slam_max_damage"];

    if ( isdefined( self.elite_angered ) )
    {
        var_1 *= get_angered_damage_scalar();
        var_2 *= get_angered_damage_scalar();
    }

    area_damage_and_impulse( 250, var_1, var_2, 800 );
    maps\mp\agents\_scriptedagents::_ID35786( "attack_melee", "end" );

    if ( !isdefined( self.elite_angered ) )
        var_3 = maps\mp\agents\alien\_alien_melee::_ID21556( var_0, 1 );

    maps\mp\alien\_unk1464::_ID28197( 0.2 );
}

charge_attack( var_0 )
{
    if ( var_0 being_charged() )
    {
        wait 0.2;
        return;
    }

    self._ID20883 = "charge";
    maps\mp\agents\alien\_alien_think::alien_melee( var_0 );
    var_0.being_charged = 0;
}

angered( var_0 )
{
    self._ID20883 = "angered";
    maps\mp\agents\alien\_alien_think::alien_melee( var_0 );
}

do_charge_attack( var_0 )
{
    self endon( "death" );
    var_0.being_charged = 1;
    self.last_charge_time = gettime();
    maps\mp\alien\_unk1464::_ID28196( 0.2, 1.0 );
    maps\mp\agents\alien\_alien_anim_utils::_ID33986( var_0 );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetphysicsmode( "gravity" );
    self scragentsetorientmode( "face enemy" );
    var_1 = _ID14339();
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( "charge_attack_start", var_1, 1.15, "charge_attack_start", "end", ::_ID36958 );

    if ( isalive( var_0 ) && can_see_enemy( var_0 ) )
    {
        thread _ID33262( var_0 );
        self setanimstate( "charge_attack", var_1, 1.0 );
        var_2 = _ID35934( var_0, var_1 );
        self notify( "charge_complete" );
        self scragentsetorientmode( "face angle abs", self.angles );

        if ( !isdefined( var_2 ) )
            var_2 = "fail";

        switch ( var_2 )
        {
            case "success":
                maps\mp\agents\_scriptedagents::_ID27105( "charge_attack_bump", var_1, 1.0, "charge_attack_bump", "end", ::_ID36957 );
                break;
            case "fail":
                _ID23852( var_1 );
                break;
            default:
                break;
        }

        self scragentsetanimmode( "code_move" );
    }

    maps\mp\alien\_unk1464::_ID28197( 0.2 );
}

can_see_enemy( var_0 )
{
    return sighttracepassed( self geteye(), var_0 geteye(), 0, self );
}

_ID33262( var_0 )
{
    self endon( "death" );
    self endon( "charge_complete" );
    var_1 = 105625;
    self.charge_tracking_enemy = 1;

    for (;;)
    {
        if ( distancesquared( self.origin, var_0.origin ) < var_1 )
            break;

        wait 0.05;
    }

    self scragentsetorientmode( "face angle abs", self.angles );
    self.charge_tracking_enemy = 0;
}

_ID23852( var_0 )
{
    var_1 = 120;

    if ( _ID17005( var_1 ) )
        go_hit_geo();
    else
        maps\mp\agents\_scriptedagents::_ID27105( "charge_attack_stop", var_0, 1.0, "charge_attack_stop", "end", ::_ID36957 );
}

go_hit_geo()
{
    var_0 = _ID14500();
    var_1 = self getanimentry( "charge_hit_geo", var_0 );
    var_2 = getnotetracktimes( var_1, "forward_end" );
    var_3 = length( getmovedelta( var_1, 0.0, var_2[0] ) );

    for (;;)
    {
        if ( _ID17005( var_3 ) )
            break;

        common_scripts\utility::_ID35582();
    }

    maps\mp\agents\_scriptedagents::_ID27105( "charge_hit_geo", var_0, 1.0, "charge_hit_geo", "end", ::_ID36957 );
}

_ID35934( var_0, var_1 )
{
    self endon( "death" );
    var_0 endon( "death" );
    var_2 = 3.0;
    var_3 = 6.0;
    var_4 = 0.05;
    var_5 = self getanimentry( "charge_attack_stop", var_1 );
    var_6 = int( randomfloatrange( var_2, var_3 ) / var_4 );
    var_7 = length( getmovedelta( var_5 ) );
    var_8 = getanimlength( var_5 );
    var_9 = var_7 / var_8 * var_4 * 3;

    for ( var_10 = 0; var_10 < var_6; var_10++ )
    {
        if ( hit_player() )
            return "success";

        if ( self.charge_tracking_enemy )
            var_11 = distance( var_0.origin, self.origin );
        else
            var_11 = var_9;

        if ( _ID17005( var_11 ) )
            return "fail";

        if ( !self.charge_tracking_enemy && missed_enemy( var_0 ) )
            return "fail";

        common_scripts\utility::_ID35582();
    }

    return "fail";
}

hit_player()
{
    var_0 = 140;

    foreach ( var_2 in level.players )
    {
        if ( distancesquared( self.origin, var_2.origin ) < var_0 * var_0 && _ID21032( var_2 ) )
        {
            maps\mp\agents\alien\_alien_melee::_ID20825( var_2, "charge" );
            var_2 _ID24061( 1200, vectornormalize( var_2.origin - self.origin ) );
            return 1;
        }
    }

    return 0;
}

_ID17005( var_0 )
{
    var_1 = 18.0;
    var_2 = 0.866;
    var_3 = self.origin + ( 0, 0, var_1 );
    var_4 = var_3 + anglestoforward( self.angles ) * var_0;
    var_5 = self aiphysicstrace( var_3, var_4, self.radius, self.height - var_1, 1, 1 );
    return var_5["fraction"] < 1.0 && var_5["normal"][2] < var_2;
}

_ID24061( var_0, var_1 )
{
    var_2 = 600.0;
    var_3 = self getvelocity();
    var_4 = var_1 * var_0;
    var_5 = ( var_3 + var_4 ) * ( 1, 1, 0 );
    var_6 = length( var_5 );

    if ( var_6 >= 400.0 )
        var_5 = vectornormalize( var_5 ) * 400.0;

    self setvelocity( var_5 );
}

_ID21032( var_0 )
{
    var_1 = 0.866;
    var_2 = can_see_enemy( var_0 );
    var_3 = vectornormalize( var_0.origin - self.origin );
    var_4 = anglestoforward( self.angles );
    var_5 = vectordot( var_3, var_4 ) > var_1;
    return var_2 && var_5;
}

missed_enemy( var_0 )
{
    var_1 = -256;
    var_2 = can_see_enemy( var_0 );

    if ( !var_2 )
        return 1;

    var_3 = var_0.origin - self.origin;
    var_4 = anglestoforward( self.angles );
    var_5 = vectordot( var_3, var_4 );

    if ( var_5 > 0 )
        return 0;

    return var_5 < var_1;
}

being_charged()
{
    return isdefined( self.being_charged ) && self.being_charged;
}

_ID14339()
{
    var_0 = [ 40, 30, 30 ];
    return _ID14845( "charge_attack_start", var_0 );
}

_ID14500()
{
    var_0 = [ 15, 25, 60 ];
    return _ID14845( "charge_hit_geo", var_0 );
}

_ID14845( var_0, var_1 )
{
    var_2 = self getanimentrycount( var_0 );
    return maps\mp\alien\_unk1464::getrandomindex( var_1 );
}

_ID20107()
{
    level._ID1644["queen_shield_impact"] = loadfx( "fx/impacts/large_metalhit_1" );
    level._ID1644["queen_ground_spawn"] = loadfx( "vfx/gameplay/alien/vfx_alien_elite_ground_spawn" );
}

_ID11380()
{
    self._ID21974 = gettime();
    self.last_charge_time = gettime();

    if ( !maps\mp\alien\_unk1464::_ID18745() )
    {
        self.elite_angered = 1;
        self.moveplaybackrate = 1.2;
    }
}

activate_angered_state()
{
    prepare_to_regenerate();
    var_0 = 10.0;
    var_1 = 60000;
    self.elite_angered = 1;
    self.moveplaybackrate = 1.2;
    _ID2075();
}

activate_health_regen()
{
    level endon( "game_ended" );
    self endon( "death" );
    prepare_to_regenerate();
    var_0 = 10.0;
    var_1 = 60000;
    self._ID21974 = gettime() + var_1;
    thread play_health_regen_anim();
    _ID2075();
    thread _ID25233( var_0 );
    common_scripts\utility::_ID35637( var_0, "stop_queen_health_regen" );
    disable_health_regen_shield();
}

prepare_to_regenerate()
{
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( "prepare_to_regen", 0, 2.0, "prepare_to_regen", "end" );
    var_0 = level._ID2829[self.alien_type].attributes["explode_min_damage"];
    var_1 = level._ID2829[self.alien_type].attributes["explode_max_damage"];

    if ( isdefined( self.elite_angered ) )
    {
        var_0 *= get_angered_damage_scalar();
        var_1 *= get_angered_damage_scalar();
    }

    area_damage_and_impulse( 200, var_0, var_1, 800 );
}

play_health_regen_anim()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "stop_queen_health_regen" );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    var_0 = "regen";

    for (;;)
        maps\mp\agents\_scriptedagents::_ID23883( var_0, var_0, "end" );
}

_ID25233( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "stop_queen_health_regen" );
    var_1 = 1.0;
    var_2 = int( var_0 / var_1 );
    var_3 = ( self.maxhealth - self.health ) / 2;
    var_4 = int( var_3 / var_2 );

    for ( var_5 = 0; var_5 < var_2; var_5++ )
    {
        wait(var_1);
        self.health = self.health + var_4;
    }
}

_ID2075()
{

}

disable_health_regen_shield()
{
    self setscriptablepartstate( "body", "normal" );
}

clean_up_on_owner_death( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    var_0 endon( "stop_queen_health_regen" );
    var_0 waittill( "death" );
    self delete();
}

deploy_health_regen_shield()
{
    var_0 = spawn( "script_model", self.origin );
    var_0 setmodel( "alien_shield_bubble_distortion" );
    var_0 linkto( self, "tag_origin" );
    var_0 setcandamage( 1 );
    return var_0;
}

_ID23834( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        var_2 = var_1 * -1;
    else
        var_2 = anglestoforward( self.angles );

    var_3 = anglestoup( vectortoangles( var_2 ) );
    playfx( level._ID1644["queen_shield_impact"], var_0, var_2, var_3 );
}

elitedamageprocessing( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    switch ( var_4 )
    {
        case "MOD_EXPLOSIVE":
        case "MOD_GRENADE":
        case "MOD_PROJECTILE":
        case "MOD_GRENADE_SPLASH":
        case "MOD_PROJECTILE_SPLASH":
            var_2 *= 0.5;
        default:
            break;
    }

    return var_2;
}

_ID22758()
{
    var_0 = 256;
    var_1 = 30;
    var_2 = 10;
    var_3 = anglestoup( self.angles );

    if ( !maps\mp\alien\_unk1464::is_normal_upright( var_3 ) )
        return;

    area_damage_and_impulse( var_0, var_2, var_1, 500 );
}

area_damage_and_impulse( var_0, var_1, var_2, var_3 )
{
    radiusdamage( self.origin, var_0, var_2, var_1, self, "MOD_EXPLOSIVE", "alienrhinoslam_mp" );
    var_4 = var_0 * var_0;

    foreach ( var_6 in level.players )
    {
        if ( distancesquared( self.origin, var_6.origin ) > var_4 )
            continue;

        var_7 = vectornormalize( var_6.origin - self.origin );
        var_6 _ID24061( var_3, var_7 );
    }
}

get_angered_damage_scalar()
{
    return 1.25;
}

_ID36958( var_0, var_1, var_2, var_3 )
{
    switch ( var_0 )
    {
        case "queen_roll_start":
            self playloopsound( "queen_roll" );
            break;
        default:
            break;
    }
}

_ID36957( var_0, var_1, var_2, var_3 )
{
    switch ( var_0 )
    {
        case "queen_roll_stop":
            self stoploopsound( "queen_roll" );
            break;
        default:
            break;
    }
}
