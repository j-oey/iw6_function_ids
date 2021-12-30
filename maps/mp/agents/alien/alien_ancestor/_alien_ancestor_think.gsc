// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    self endon( "death" );
    common_scripts\utility::_ID35582();
    thread _ID35951();
    thread health_monitor();
    initialize_path();
    initialize_attacks();
    self.ancestor_scripted_active = 0;

    for (;;)
        main_loop();
}

initialize_path()
{
    var_0 = getnodearray( "ancestor_path_start", "script_noteworthy" );
    self.pathnode = common_scripts\utility::_ID14934( self.origin, var_0, 512 );
    self.following_path = 0;
}

initialize_attacks()
{
    var_0 = gettime();
    self.last_spawn_time = var_0;
    self.last_blast_time = var_0;
    self.last_attack_time = var_0;
    self.last_grab_time = var_0;
    self.grab_lift_entities = [];
    self.current_grab_victims = [];
    self.grab_target_disabled = 0;
}

has_died()
{
    return maps\mp\agents\alien\alien_ancestor\_alien_ancestor::getrealhealth() < 0;
}

health_monitor()
{
    self endon( "death" );

    for (;;)
    {
        if ( has_died() )
            break;

        wait 0.05;
    }

    death_attack( self.enemy );
}

main_loop()
{
    for (;;)
    {
        self.looktarget = undefined;
        var_0 = self.enemy;

        if ( isdefined( self.alien_scripted ) && self.alien_scripted == 1 )
        {
            self.ancestor_scripted_active = 1;
            self.following_path = 0;
        }
        else
        {
            self.ancestor_scripted_active = 0;

            if ( self._ID4637 )
                _ID4637( var_0 );
            else
                update_loop();
        }

        wait 0.05;
    }
}

_ID4637( var_0 )
{
    self.badpathcount = 0;
    self._ID4637 = 0;
}

update_loop()
{
    if ( has_died() )
        return;

    self.looktarget = self.enemy;
    var_0 = _ID29818( self.enemy );

    if ( isdefined( var_0 ) )
        ancestor_attack( var_0, self.enemy );
    else if ( !self.following_path )
        thread follow_path();
}

_ID29818( var_0 )
{
    if ( self.statelocked )
        return undefined;

    if ( should_force_blast() )
        return "forced_blast";

    if ( should_force_grab() )
        return "forced_grab";

    if ( gettime() - self.last_attack_time < 2000 )
        return undefined;

    if ( should_shield( var_0 ) )
        return "shield";
    else if ( should_grab( var_0 ) )
        return "grab";
    else if ( should_blast( var_0 ) )
        return "blast";

    if ( should_spawn( var_0 ) )
        return "spawn";
    else if ( should_direct( var_0 ) )
        return "direct";

    return undefined;
}

follow_path()
{
    if ( !isdefined( self.pathnode ) )
        return;

    if ( distancesquared( self.origin, self.pathnode.origin ) < 1024.0 )
    {
        if ( isdefined( self.pathnode.target ) )
            self.pathnode = getnode( self.pathnode.target, "targetname" );
        else
            self.pathnode = undefined;
    }

    if ( !isdefined( self.pathnode ) )
    {
        self notify( "Path ended" );
        return;
    }

    self.following_path = 1;
    self scragentsetgoalradius( 32.0 );
    self scragentsetgoalnode( self.pathnode );

    if ( self.currentanimstate == "move" )
    {
        var_0 = vectornormalize( self.pathnode.origin - self.origin );
        self notify( "path_dir_change",  var_0  );
    }

    self waittill( "goal_reached" );

    if ( isdefined( self.pathnode.script_noteworthy ) )
        self notify( self.pathnode.script_noteworthy );

    self.following_path = 0;
}

assign_path_node( var_0 )
{
    self.pathnode = var_0;
    self.following_path = 0;
}

should_shield( var_0 )
{
    return 0;
}

should_spawn( var_0 )
{
    if ( gettime() - self.last_spawn_time < 30000 )
        return 0;

    if ( maps\mp\alien\_spawn_director::can_spawn_type( "brute" ) )
        return 1;

    return maps\mp\alien\_spawn_director::can_spawn_type( "goon" );
}

should_direct( var_0 )
{
    return 0;
}

should_blast( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( var_0.classname == "script_model" && !bullettracepassed( self gettagorigin( "TAG_EYE" ), var_0.origin, 0, self.shield ) )
        return 0;
    else if ( !bullettracepassed( self gettagorigin( "TAG_EYE" ), var_0 gettagorigin( "TAG_EYE" ), 0, self.shield ) )
        return 0;

    return gettime() - self.last_blast_time > 6000;
}

should_force_blast()
{
    return isdefined( self.forced_blast_position );
}

should_force_grab()
{
    return isdefined( self.forced_grab_position );
}

should_grab( var_0 )
{
    if ( gettime() - self.last_grab_time < 4000 )
        return 0;

    self.grab_target = undefined;
    var_1 = 0;
    var_2 = anglestoforward( self.angles );
    var_3 = 0.707;
    var_4 = gettime();

    foreach ( var_6 in level.players )
    {
        if ( var_6._ID18011 )
            continue;

        if ( var_6.ignoreme )
            continue;

        if ( isdefined( var_6.next_valid_grab_time ) && var_6.next_valid_grab_time > var_4 )
            continue;

        var_7 = vectornormalize( var_6.origin - self.origin );

        if ( vectordot( var_2, var_7 ) < var_3 )
            continue;

        var_8 = distancesquared( var_6.origin, self.origin );

        if ( var_8 > 589824 )
            continue;

        if ( !bullettracepassed( self gettagorigin( "TAG_EYE" ), var_6 gettagorigin( "TAG_EYE" ), 0, self.shield ) )
            continue;

        if ( !isdefined( self.grab_target ) || var_8 < var_1 )
        {
            self.grab_target = var_6;
            var_1 = var_8;
        }
    }

    return isdefined( self.grab_target );
}

blast( var_0 )
{
    self.blast_target = var_0;
    attack_enemy( "blast", var_0 );
}

forced_blast( var_0 )
{
    attack_enemy( "forced_blast", var_0 );
}

forced_grab( var_0 )
{
    attack_enemy( "forced_grab", var_0 );
}

grab( var_0 )
{
    attack_enemy( "grab", var_0 );
}

spawn_attack( var_0 )
{
    attack_enemy( "spawn", var_0 );
}

death_attack( var_0 )
{
    attack_enemy( "death", var_0 );
}

ancestor_attack( var_0, var_1 )
{
    self notify( "start_attack" );

    switch ( var_0 )
    {
        case "blast":
            blast( var_1 );
            break;
        case "forced_blast":
            forced_blast( var_1 );
            break;
        case "forced_grab":
            forced_grab( var_1 );
            break;
        case "grab":
            grab( var_1 );
            break;
        case "spawn":
            spawn_attack( var_1 );
            break;
        case "death":
            death_attack( var_1 );
            break;
        default:
            wait 1;
            break;
    }
}

attack_enemy( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
    {
        foreach ( var_3 in level.players )
        {
            if ( isdefined( var_3 ) )
            {
                var_1 = var_3;
                break;
            }
        }
    }

    if ( isdefined( var_1 ) )
    {
        self._ID20883 = var_0;
        self scragentbeginmelee( var_1 );
        self scragentsetgoalpos( self.origin );
        self scragentsetgoalradius( 4096.0 );
        self waittill( "melee_complete" );
        self.last_attack_time = gettime();
    }
    else
        wait 0.2;
}

force_blast_attack( var_0 )
{
    self.forced_blast_position = var_0;
}

force_grab_attack( var_0 )
{
    self.forced_grab_position = var_0;
}

noncombat()
{

}

_ID35951()
{
    self endon( "death" );
    self._ID4637 = 0;

    for (;;)
    {
        self waittill( "bad_path",  var_0, var_1  );
        self._ID4637 = 1;

        if ( !isdefined( self.badpathcount ) || isdefined( self.badpathtime ) && gettime() > self.badpathtime + 2000 )
            self.badpathcount = 0;

        self.badpathtime = gettime();
        self.badpathcount++;
        _ID4637( undefined );
        wait 0.05;
    }
}

ancestor_enter_scripted()
{
    maps\mp\alien\_unk1464::_ID11418();

    while ( !maps\mp\alien\_unk1464::_ID18506( self.ancestor_scripted_active ) )
        wait 0.2;
}

ancestor_path_to_node( var_0 )
{
    var_1 = getnode( var_0, "targetname" );

    if ( !isdefined( var_1 ) )
        return;

    self.pathnode = var_1;
    self scragentsetgoalradius( 28 );
    self scragentsetgoalnode( self.pathnode );
    self waittill( "goal_reached" );
}

ancestor_do_forced_grab( var_0 )
{
    var_0 = getent( var_0, "targetname" );
    self scragentsetorientmode( "face angle abs", var_0.angles );
    force_grab_attack( var_0.origin );
    self scragentsetgoalradius( 64 );
    self scragentsetgoalnode( self.pathnode );
    maps\mp\alien\_unk1464::_ID10053();
    self waittill( "forced_grab_damage_start" );
    ancestor_enter_scripted();
    wait 0.2;
}

ancestor_play_traversal( var_0, var_1 )
{
    self scragentsetscripted( 1 );
    maps\mp\agents\alien\_alien_anim_utils::_ID33987( anglestoforward( var_0 ) );
    wait 0.5;
    self scragentsetphysicsmode( "noclip" );
    self scragentsetorientmode( "face angle abs", var_0 );
    self scragentsetanimmode( "anim deltas" );
    maps\mp\agents\_scriptedagents::_ID23883( var_1, "traverse", "end" );
    self scragentsetgoalpos( self.origin );
    self scragentsetgoalradius( 28.0 );
    self scragentsetscripted( 0 );
}

ancestor_align_to_angles( var_0 )
{
    var_1 = 0;

    for (;;)
    {
        var_2 = vectordot( anglestoforward( self.angles ), anglestoforward( var_0 ) );

        if ( var_2 < 0.95 )
        {
            var_1++;
            maps\mp\agents\alien\_alien_anim_utils::_ID33987( anglestoforward( var_0 ) );
        }
        else
            return;

        if ( var_1 >= 5 )
            return;
    }
}
