// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID19910( var_0, var_1 )
{
    level._ID1644["laser_guided_launcher_missile_split"] = loadfx( var_0 );
    level._ID1644["laser_guided_launcher_missile_spawn_homing"] = loadfx( var_1 );
}

lgm_update_launcherusage( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    thread _ID19918();
    var_2 = self getcurrentweapon();

    for (;;)
    {
        while ( var_2 != var_0 )
            self waittill( "weapon_change",  var_2  );

        childthread lgm_firing_monitormissilefire( var_2, var_1 );
        self waittill( "weapon_change",  var_2  );
        _ID19906();
    }
}

_ID19918()
{
    self endon( "LGM_player_endMonitorFire" );
    common_scripts\utility::_ID35626( "death", "disconnect" );

    if ( isdefined( self ) )
        _ID19903();
}

_ID19906()
{
    _ID19903();
    self notify( "LGM_player_endMonitorFire" );
}

lgm_firing_monitormissilefire( var_0, var_1, var_2 )
{
    self endon( "LGM_player_endMonitorFire" );
    _ID19904();
    var_3 = undefined;

    for (;;)
    {
        var_4 = undefined;
        self waittill( "missile_fire",  var_4, var_5  );

        if ( isdefined( var_4._ID18700 ) && var_4._ID18700 )
            continue;

        if ( var_5 != var_0 )
            continue;

        if ( !isdefined( var_3 ) )
            var_3 = _ID19922( self );

        thread _ID19905( var_0, var_1, var_2, 0.35, 0.1, var_4, var_3 );
    }
}

_ID19905( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self notify( "monitor_laserGuidedMissile_delaySpawnChildren" );
    self endon( "monitor_laserGuidedMissile_delaySpawnChildren" );
    self endon( "death" );
    self endon( "LGM_player_endMonitorFire" );
    lgm_missilesnotifyandrelease( var_6 );
    wait(var_3);

    if ( !isvalidmissile( var_5 ) )
        return;

    var_7 = var_5.origin;
    var_8 = anglestoforward( var_5.angles );
    var_9 = anglestoup( var_5.angles );
    var_10 = anglestoright( var_5.angles );
    var_5 delete();
    playfx( level._ID1644["laser_guided_launcher_missile_split"], var_7, var_8, var_9 );
    var_11 = [];

    for ( var_12 = 0; var_12 < 2; var_12++ )
    {
        var_13 = 20;
        var_14 = 0;

        if ( var_12 == 0 )
            var_14 = 20;
        else if ( var_12 == 1 )
            var_14 = -20;
        else if ( var_12 == 2 )
        {

        }

        var_15 = rotatepointaroundvector( var_10, var_8, var_13 );
        var_15 = rotatepointaroundvector( var_9, var_15, var_14 );
        var_16 = magicbullet( var_1, var_7, var_7 + var_15 * 180, self );
        var_16._ID18700 = 1;
        var_11[var_11.size] = var_16;
        common_scripts\utility::_ID35582();
    }

    wait(var_4);
    var_11 = _ID19921( var_11 );

    if ( var_11.size > 0 )
    {
        foreach ( var_18 in var_11 )
        {
            var_6._ID21203[var_6._ID21203.size] = var_18;
            var_18 missile_settargetent( var_6 );
            thread lgm_onmissilenotifies( var_6, var_18 );
        }

        thread _ID19908( var_6, var_2 );
    }
}

lgm_onmissilenotifies( var_0, var_1 )
{
    var_1 common_scripts\utility::_ID35626( "death", "missile_pairedWithFlare", "LGM_missile_abandoned" );

    if ( isdefined( var_0._ID21203 ) && var_0._ID21203.size > 0 )
    {
        var_0._ID21203 = common_scripts\utility::array_remove( var_0._ID21203, var_1 );
        var_0._ID21203 = _ID19921( var_0._ID21203 );
    }

    if ( !isdefined( var_0._ID21203 ) || var_0._ID21203.size == 0 )
        self notify( "LGM_player_allMissilesDestroyed" );
}

_ID19908( var_0, var_1 )
{
    self notify( "LGM_player_newMissilesFired" );
    self endon( "LGM_player_newMissilesFired" );
    self endon( "LGM_player_allMissilesDestroyed" );
    self endon( "LGM_player_endMonitorFire" );
    self endon( "death" );
    self endon( "disconnect" );
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = 0;
    var_6 = gettime() + 400;

    while ( isdefined( var_0._ID21203 ) && var_0._ID21203.size > 0 )
    {
        var_7 = _ID19923();

        if ( !isdefined( var_7 ) )
        {
            if ( isdefined( var_3 ) )
            {
                self notify( "LGM_player_targetLost" );
                var_3 = undefined;

                foreach ( var_9 in var_0._ID21203 )
                    var_9 notify( "missile_targetChanged" );
            }

            var_4 = undefined;
            var_5 = 0;
            var_11 = common_scripts\utility::_ID32831( gettime() > var_6, 8000, 800 );
            var_12 = anglestoforward( self getplayerangles() );
            var_13 = self geteye() + var_12 * 12;
            var_14 = bullettrace( var_13, var_13 + var_12 * var_11, 1, self, 0, 0, 0 );
            var_2 = var_14["position"];
        }
        else
        {
            var_2 = var_7.origin;
            var_15 = !isdefined( var_3 ) || var_7 != var_3;
            var_3 = var_7;

            if ( var_15 || !isdefined( var_4 ) )
            {
                var_4 = gettime() + 1500;
                level thread lgm_locking_think( var_3, self );
            }
            else if ( gettime() >= var_4 )
            {
                var_5 = 1;
                self notify( "LGM_player_lockedOn" );
            }

            if ( var_5 )
            {
                waittillframeend;

                if ( var_0._ID21203.size > 0 )
                {
                    var_16 = [];

                    foreach ( var_9 in var_0._ID21203 )
                    {
                        if ( !isvalidmissile( var_9 ) )
                            continue;

                        var_16[var_16.size] = var_9.origin;
                        var_9 notify( "missile_targetChanged" );
                        var_9 notify( "LGM_missile_abandoned" );
                        var_9 delete();
                    }

                    if ( var_16.size > 0 )
                        level thread _ID19913( var_3, self, var_1, var_16 );

                    var_0._ID21203 = [];
                }
                else
                    break;
            }
            else if ( var_15 )
                _ID19924( var_3, self, var_0._ID21203 );
        }

        var_0.origin = var_2;
        common_scripts\utility::_ID35582();
    }
}

_ID19922( var_0 )
{
    if ( !isdefined( level.laserguidedmissileents_inuse ) )
        level.laserguidedmissileents_inuse = [];

    if ( !isdefined( level._ID19421 ) )
        level._ID19421 = [];

    var_1 = undefined;

    if ( level._ID19421.size )
    {
        var_1 = level._ID19421[0];
        level._ID19421 = common_scripts\utility::array_remove( level._ID19421, var_1 );
    }
    else
        var_1 = spawn( "script_origin", var_0.origin );

    level.laserguidedmissileents_inuse[level.laserguidedmissileents_inuse.size] = var_1;
    level thread _ID19919( var_1, var_0 );
    var_1._ID21203 = [];
    return var_1;
}

_ID19919( var_0, var_1 )
{
    var_1 common_scripts\utility::_ID35626( "death", "disconnect", "LGM_player_endMonitorFire" );

    foreach ( var_3 in var_0._ID21203 )
    {
        if ( isvalidmissile( var_3 ) )
            var_3 missile_cleartarget();
    }

    var_0._ID21203 = undefined;
    level.laserguidedmissileents_inuse = common_scripts\utility::array_remove( level.laserguidedmissileents_inuse, var_0 );

    if ( level._ID19421.size + level.laserguidedmissileents_inuse.size < 4 )
        level._ID19421[level._ID19421.size] = var_0;
    else
        var_0 delete();
}

lgm_locking_think( var_0, var_1 )
{
    var_2 = maps\mp\_utility::_ID23108( var_0, "orange", var_1, 1, "killstreak_personal" );
    level thread lgm_locking_loopsound( var_1, "maaws_reticle_tracking", 1.5, "LGM_player_lockingDone" );
    level thread _ID19915( var_0, var_1 );
    var_1 common_scripts\utility::_ID35626( "death", "disconnect", "LGM_player_endMonitorFire", "LGM_player_newMissilesFired", "LGM_player_targetLost", "LGM_player_lockedOn", "LGM_player_allMissilesDestroyed", "LGM_player_targetDied" );

    if ( isdefined( var_0 ) )
        maps\mp\_utility::_ID23104( var_2, var_0 );

    if ( isdefined( var_1 ) )
    {
        var_1 notify( "LGM_player_lockingDone" );
        var_1 stoplocalsound( "maaws_reticle_tracking" );
    }
}

lgm_locked_missileondeath( var_0, var_1, var_2 )
{
    var_1 endon( "death" );
    var_0 waittill( "death" );
    var_1.lg_missileslocked[var_2] = common_scripts\utility::array_remove( var_1.lg_missileslocked[var_2], var_0 );

    if ( var_1.lg_missileslocked[var_2].size == 0 )
    {
        var_1.lg_missileslocked[var_2] = undefined;
        var_1 notify( "LGM_target_lockedMissilesDestroyed" );
    }
}

_ID19915( var_0, var_1 )
{
    var_1 endon( "death" );
    var_1 endon( "disconnect" );
    var_1 endon( "LGM_player_lockingDone" );
    var_0 waittill( "death" );
    var_1 notify( "LGM_player_targetDied" );
}

lgm_locking_loopsound( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_0 endon( var_3 );

    for (;;)
    {
        var_0 playlocalsound( var_1 );
        wait(var_2);
    }
}

lgm_locked_spawnmissiles( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "death" );
    var_1 endon( "death" );
    var_1 endon( "disconnect" );
    var_4 = [];

    for ( var_5 = 0; var_5 < var_3.size; var_5++ )
    {
        var_6 = magicbullet( var_2, var_3[var_5], var_0.origin, var_1 );
        var_6._ID18700 = 1;
        var_4[var_4.size] = var_6;
        playfx( level._ID1644["laser_guided_launcher_missile_spawn_homing"], var_6.origin, anglestoforward( var_6.angles ), anglestoup( var_6.angles ) );
        common_scripts\utility::_ID35582();
    }

    return var_4;
}

_ID19913( var_0, var_1, var_2, var_3 )
{
    if ( var_3.size == 0 )
        return;

    var_4 = lgm_locked_spawnmissiles( var_0, var_1, var_2, var_3 );

    if ( !isdefined( var_4 ) )
        return;

    var_4 = _ID19921( var_4 );

    if ( var_4.size == 0 )
        return;

    var_1 playlocalsound( "maaws_reticle_locked" );
    var_5 = maps\mp\_utility::_ID23108( var_0, "red", var_1, 0, "killstreak_personal" );
    var_6 = _ID19909( var_0 );

    foreach ( var_8 in var_4 )
    {
        var_8 common_scripts\utility::_ID21170( var_0, "direct", var_6 );
        _ID19924( var_0, var_1, var_4 );
    }

    if ( !isdefined( var_0.lg_missileslocked ) )
        var_0.lg_missileslocked = [];

    var_0.lg_missileslocked[var_5] = var_4;

    foreach ( var_11 in var_4 )
        level thread lgm_locked_missileondeath( var_11, var_0, var_5 );

    var_13 = 1;

    while ( var_13 )
    {
        var_14 = var_0 common_scripts\utility::_ID35635( "death", "LGM_target_lockedMissilesDestroyed" );

        if ( var_14 == "death" )
        {
            var_13 = 0;

            if ( isdefined( var_0 ) )
                var_0.lg_missileslocked[var_5] = undefined;

            continue;
        }

        if ( var_14 == "LGM_target_lockedMissilesDestroyed" )
        {
            waittillframeend;

            if ( !isdefined( var_0.lg_missileslocked[var_5] ) || var_0.lg_missileslocked[var_5].size == 0 )
                var_13 = 0;
        }
    }

    if ( isdefined( var_0 ) )
        maps\mp\_utility::_ID23104( var_5, var_0 );
}

_ID19923()
{
    var_0 = maps\mp\gametypes\_weapons::_ID20194();
    var_0 = sortbydistance( var_0, self.origin );
    var_1 = undefined;

    foreach ( var_3 in var_0 )
    {
        if ( self worldpointinreticle_circle( var_3.origin, 65, 75 ) )
        {
            var_1 = var_3;
            break;
        }
    }

    return var_1;
}

_ID19904()
{
    if ( !isdefined( self._ID19419 ) || self._ID19419 == 0 )
    {
        self._ID19419 = 1;
        maps\mp\_utility::enableweaponlaser();
    }
}

_ID19903()
{
    if ( isdefined( self._ID19419 ) && self._ID19419 == 1 )
        maps\mp\_utility::_ID10177();

    self._ID19419 = undefined;
}

_ID19921( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( isvalidmissile( var_3 ) )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

_ID19924( var_0, var_1, var_2 )
{
    level notify( "laserGuidedMissiles_incoming",  var_1, var_2, var_0  );
    var_0 notify( "targeted_by_incoming_missile",  var_2  );
}

_ID19909( var_0 )
{
    var_1 = undefined;

    if ( var_0.model != "vehicle_av8b_harrier_jet_mp" )
        var_1 = var_0 gettagorigin( "tag_missile_target" );
    else
        var_1 = var_0 gettagorigin( "tag_body" );

    if ( !isdefined( var_1 ) )
        var_1 = var_0 getpointinbounds( 0, 0, 0 );

    return var_1 - var_0.origin;
}

lgm_missilesnotifyandrelease( var_0 )
{
    if ( isdefined( var_0._ID21203 ) && var_0._ID21203.size > 0 )
    {
        foreach ( var_2 in var_0._ID21203 )
        {
            if ( isvalidmissile( var_2 ) )
            {
                var_2 notify( "missile_targetChanged" );
                var_2 notify( "LGM_missile_abandoned" );
                var_2 missile_cleartarget();
            }
        }
    }

    var_0._ID21203 = [];
}
