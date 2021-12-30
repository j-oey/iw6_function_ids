// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_mine_precache::_ID20445();
    maps\createart\mp_mine_art::_ID20445();
    maps\mp\mp_mine_fx::_ID20445();
    maps\mp\_load::_ID20445();
    maps\mp\_compass::_ID29184( "compass_map_mp_mine" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    setdvar( "r_tessellationCutoffFalloffBase", 600 );
    setdvar( "r_tessellationCutoffDistanceBase", 2000 );
    setdvar( "r_tessellationCutoffFalloff", 600 );
    setdvar( "r_tessellationCutoffDistance", 2000 );
    setdvar( "r_reactiveMotionWindFrequencyScale", 0.1 );
    setdvar( "sm_sunSampleSizeNear", 0.43 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "urban";
    game["axis_outfit"] = "woodland";
    level.minecartwheelanims = [ "mp_cart_idle_anim", "mp_cart_spin_slow_anim", "mp_cart_spin_mid_anim", "mp_cart_spin_fast_anim" ];
    thread _ID29175();
    thread minecartsetup( "cart1", "cart1TrackStart", "cart1AttachedModels", "cart1dmg", "cart1_inside", "cart1_front" );
    thread minecartsetup( "cart2", "cart2TrackStart", "cart2AttachedModels", "cart2dmg", "cart2_interior", "cart2_front" );
    thread setupelevatorkilltrigger();
    initkillstreak();
    thread _ID36620::_ID37998( "alienEasterEgg" );
    wildlife();
    thread ambientanimations();
    level._ID1644["gear_blood"] = loadfx( "vfx/moments/mp_zerosub/vfx_blood_explosion" );
    thread setuppushtrigger( "pushTrigger01", ( 10, 90, 0 ) );
    thread setuppushtrigger( "pushTrigger02", ( 10, 180, 0 ) );
    thread setuppushtrigger( "pushTrigger04", ( 10, 270, 0 ) );
}

setupgametypeflags( var_0 )
{
    level.minebflag = undefined;
    var_1 = [];

    if ( level._ID14086 == "dom" || level._ID14086 == "siege" )
        var_1 = getentarray( "flag_primary", "targetname" );
    else
        return;

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3._ID27658 ) && var_3._ID27658 == "_b" )
        {
            level.minebflag = var_3;
            break;
        }
    }

    if ( isdefined( level.minebflag ) )
    {
        level thread updatebflagobjicon();
        var_5 = getdomflagb();
        var_5 enablelinkto();
        var_5 linkto( var_0 );

        while ( !isdefined( var_5._ID34757 ) )
            common_scripts\utility::_ID35582();

        foreach ( var_7 in var_5._ID34757._ID35361 )
            var_7 linkto( var_0 );
    }
}

getdomflagb()
{
    return level.minebflag;
}

updatebflagfxpos( var_0, var_1 )
{
    level endon( "mp_mine_elevator_stopped" );
    var_2 = getdomflagb();

    if ( !isdefined( var_2 ) )
        return;

    var_3 = common_scripts\utility::_ID32831( var_0, 16, 1.5 );

    for (;;)
    {
        var_4 = var_2.origin + ( 0, 0, var_3 );
        var_2._ID34757.baseeffectpos = var_4;

        if ( isdefined( var_2._ID34757.neutralflagfx ) )
        {
            var_2._ID34757.neutralflagfx.origin = var_4;
            triggerfx( var_2._ID34757.neutralflagfx );
        }

        foreach ( var_6 in level.players )
        {
            if ( isdefined( var_6._domflageffect ) && isdefined( var_6._domflageffect["_b"] ) )
            {
                var_6._domflageffect["_b"].origin = var_4;
                triggerfx( var_6._domflageffect["_b"] );
            }
        }

        if ( !var_1 )
            break;

        wait 0.25;
    }
}

updatebflagobjicon()
{
    var_0 = getdomflagb();

    while ( !isdefined( var_0._ID34757 ) )
        common_scripts\utility::_ID35582();

    var_1 = common_scripts\utility::_ID30774();
    var_1 show();
    var_1.origin = var_0.origin + ( 0, 0, 100 );
    var_1 linkto( var_0 );
    var_0._ID34757.objiconent = var_1;
    var_0._ID34757 maps\mp\gametypes\_gameobjects::updateworldicons();
}

_ID29175()
{
    var_0 = getent( "elevator", "targetname" );
    var_1 = getent( "elevatorGears", "targetname" );
    var_2 = getent( "elevatorPathNodeHolders", "targetname" );
    var_3 = getent( "elevatorPathNodeTop", "targetname" );
    var_4 = getent( "elevatorPathNodeMid", "targetname" );
    var_5 = getent( "elevatorPathNodeBot", "targetname" );
    var_6 = 6;
    var_7 = 20;
    var_8 = common_scripts\utility::_ID15384( "elevatorTop", "targetname" );
    var_9 = common_scripts\utility::_ID15384( "elevatorBot", "targetname" );
    var_10 = getentarray( "elevatorAttachedModels", "targetname" );

    foreach ( var_12 in var_10 )
        var_12 linkto( var_0 );

    var_14 = getent( "elevatorDamage", "targetname" );
    var_14 enablelinkto();
    var_14 linkto( var_0 );
    var_15 = var_0 linktrigger( "elevatorGearCrushTrigger" );
    var_16 = getent( "elevatorSquish", "targetname" );
    var_16.dmg = 0;
    var_0 connectpaths();
    var_2 hide();
    var_2 notsolid();
    var_3 hide();
    var_3 notsolid();
    setupgametypeflags( var_0 );
    blockerconnect( var_3 );
    var_17 = getent( "elevatorWheelLeft", "targetname" );
    var_17 linkto( var_1 );
    var_18 = getent( "elevatorWheelRight", "targetname" );
    var_18 linkto( var_1 );
    wait 10;

    for (;;)
    {
        var_1 rotatepitch( -256.1, var_6, 1, 1 );
        var_1 moveto( ( -59, 256, 287 ), var_6, 1, 1 );
        var_0 moveto( var_9.origin, var_6, 1, 1 );
        var_14.dmg = 1000;
        var_0.destroydroneoncollision = 1;
        var_0.destroyairdroponcollision = 1;
        level thread updatebflagfxpos( 0, 1 );
        var_17 playsoundonmovingent( "mine_elev_big_01" );
        var_18 playsoundonmovingent( "mine_elev_big_02" );
        blockerconnect( var_4 );
        wait 2;
        wait 2;
        blockerdisconnect( var_3 );
        blockerconnect( var_5 );
        wait 2;
        blockerdisconnect( var_4 );
        level notify( "mp_mine_elevator_stopped" );
        level updatebflagfxpos( 0, 0 );
        wait(var_7);
        var_1 rotatepitch( 256.1, var_6, 1, 1 );
        var_1 moveto( ( -59, 256, 543 ), var_6, 1, 1 );
        var_0 moveto( var_8.origin, var_6, 1, 1 );
        var_14.dmg = 0;
        var_0.destroydroneoncollision = 0;
        var_0.destroyairdroponcollision = 0;
        level thread updatebflagfxpos( 1, 1 );
        var_17 playsoundonmovingent( "mine_elev_big_01" );
        var_18 playsoundonmovingent( "mine_elev_big_02" );
        blockerconnect( var_4 );
        wait 2;
        var_15 thread crushplayerintrigger();
        var_16.dmg = 1000;
        blockerdisconnect( var_5 );
        blockerconnect( var_3 );
        wait 2;
        wait 2;
        blockerdisconnect( var_4 );
        var_15 notify( "stopCrushing" );
        var_16.dmg = 0;
        level notify( "mp_mine_elevator_stopped" );
        level updatebflagfxpos( 0, 0 );
        wait(var_7);
    }
}

blockerconnect( var_0 )
{
    var_0 show();
    var_0 solid();
    var_0 connectpaths();
    var_0 hide();
    var_0 notsolid();
}

blockerdisconnect( var_0 )
{
    var_0 show();
    var_0 solid();
    var_0 disconnectpaths();
}

elevatorstartgears( var_0 )
{
    var_1 = getentarray( "elevatorGears", "targetname" );

    if ( var_0 == self.destinationnames[0] )
    {
        foreach ( var_3 in var_1 )
        {
            var_3 rotatepitch( 360, self._ID21687, 0, 0 );
            var_3 moveto( ( -59, 256, 543 ), self._ID21687, 0, 0 );
        }

        maps\mp\_elevator_v2::elevatorclearpath( "elevatorMid" );
        wait 5;
        maps\mp\_elevator_v2::elevatorblockpath( "elevatorMid" );
    }
    else
    {
        foreach ( var_3 in var_1 )
        {
            var_3 rotatepitch( -360, self._ID21687, 0, 0 );
            var_3 moveto( ( -59, 256, 287 ), self._ID21687, 0, 0 );
        }

        maps\mp\_elevator_v2::elevatorclearpath( "elevatorMid" );
        wait 5;
        maps\mp\_elevator_v2::elevatorblockpath( "elevatorMid" );
    }
}

minecartsetup( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = getent( var_0, "targetname" );
    var_7 = 0.004;
    var_8 = common_scripts\utility::_ID15384( var_1, "targetname" );
    var_9 = var_6 linktrigger( var_4 );
    var_6 thread setupminecartinsidetrigger( var_9 );
    var_10 = var_6 linktrigger( var_5 );
    var_6 thread setupminecartfronttrigger( var_10 );
    var_11 = getentarray( var_2, "targetname" );

    foreach ( var_13 in var_11 )
    {
        var_13 linkto( var_6 );
        var_13.destroydroneoncollision = 0;
        var_13.destroyairdroponcollision = 1;
    }

    var_6.destroydroneoncollision = 0;
    var_6.destroyairdroponcollision = 1;
    var_15 = spawn( "script_model", var_6.origin + ( 0, 0, 60 ) );
    var_15 linkto( var_6 );
    var_6._ID19214 = var_15;
    var_6._ID19214 setscriptmoverkillcam( "explosive" );
    var_6._ID34249 = ::cart_unresolved_collision_func;
    var_6._ID34253 = 6;
    var_6 minecartsetupsparks();
    var_6 moveto( var_8.origin, 0.1, 0, 0 );
    var_6 rotateto( var_8.angles, 0.1, 0, 0 );
    var_6.cartmodel = var_11[0];
    var_6 minecarthandleevents( var_8.script_noteworthy );
    var_6.speed = 0;
    wait 0.5;
    var_16 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_16, "active", var_6.origin, "mine_cart_icon" );
    objective_onentitywithrotation( var_16, var_6 );
    var_6.curobjid = var_16;

    for (;;)
    {
        if ( isdefined( var_8._ID27658 ) )
        {
            var_17 = float( var_8._ID27658 );
            var_7 = 1.0 / var_17;
            var_6.speed = var_17;
            var_6 minecartplaysparksonspeedchange( int( var_8._ID27658 ) );
        }

        if ( var_8.targetname == "cart2TrackStart" )
            thread minecartelevatormove( var_7 );

        var_8 = minecartmove( var_6, var_8, var_7 );
    }
}

minecartmove( var_0, var_1, var_2 )
{
    var_0 endon( "death" );
    var_3 = common_scripts\utility::_ID15384( var_1.target, "targetname" );
    var_4 = abs( distance( var_0.origin, var_3.origin ) * var_2 );
    var_0 moveto( var_3.origin, var_4, 0, 0 );
    var_0 rotateto( var_3.angles, var_4, 0, 0 );
    wait(var_4);
    var_0 minecarthandleevents( var_3.script_noteworthy );
    return var_3;
}

minecartelevatormove( var_0 )
{
    var_1 = getent( "cart2Elevator", "targetname" );
    var_2 = common_scripts\utility::_ID15384( "cart2TrackStart", "targetname" );
    var_3 = common_scripts\utility::_ID15384( "cart2ElevatorTop", "targetname" );
    var_4 = getent( "cartElevatorPathNodeTop", "targetname" );
    var_5 = getent( "cartElevatorPathNodeBot", "targetname" );
    var_6 = abs( distance( var_2.origin, var_3.origin ) * var_0 );
    var_1.unresolved_collision_kill = 1;
    var_1.destroydroneoncollision = 0;
    var_1 playsoundonmovingent( "minecart2_elevator_up" );
    var_1 moveto( var_3.origin, var_6, 0, 0 );
    blockerdisconnect( var_5 );
    wait(var_6);
    blockerconnect( var_4 );
    wait 5;
    blockerdisconnect( var_4 );
    var_1.destroydroneoncollision = 1;
    var_1 playsoundonmovingent( "minecart2_elevator_down" );
    var_1 moveto( var_2.origin, var_6, 0, 0 );
    wait(var_6 - 2);
    common_scripts\utility::_ID33659( "cart2ElevatorKill", "targetname" );
    wait 2;
    common_scripts\utility::_ID33657( "cart2ElevatorKill", "targetname" );
    blockerconnect( var_5 );
}

setupelevatorkilltrigger()
{
    common_scripts\utility::_ID33657( "cart2ElevatorKill", "targetname" );
}

linktrigger( var_0 )
{
    var_1 = getent( var_0, "targetname" );

    if ( isdefined( var_1 ) )
    {
        var_1 enablelinkto();
        var_1 linkto( self );
    }

    return var_1;
}

setupminecartfronttrigger( var_0 )
{
    level endon( "game_ended" );

    if ( !isdefined( var_0 ) )
        return;

    for (;;)
    {
        var_0 waittill( "trigger",  var_1  );

        if ( isplayer( var_1 ) || isagent( var_1 ) )
        {
            if ( maps\mp\_utility::_ID18757( var_1 ) && self.speed >= 250 )
            {
                if ( var_1 ismantling() )
                    continue;

                var_2 = undefined;

                if ( self.playersincart.size > 0 )
                {
                    foreach ( var_4 in self.playersincart )
                    {
                        if ( maps\mp\_utility::_ID18757( var_4 ) && var_1 maps\mp\_utility::isenemy( var_4 ) )
                        {
                            var_2 = var_4;
                            break;
                        }
                    }
                }

                var_6 = var_1.origin - self.origin;
                var_7 = undefined;
                var_8 = undefined;
                var_9 = 20;

                if ( isdefined( var_2 ) )
                {
                    var_9 = 100;
                    var_7 = var_2;
                    var_8 = self._ID19214;
                }
                else if ( level.hardcoremode )
                    var_9 = 100;
                else if ( isagent( var_1 ) )
                    var_9 = 50;

                var_10 = level.callbackplayerdamage;

                if ( isagent( var_1 ) )
                    var_10 = maps\mp\agents\_agent_common::codecallback_agentdamaged;

                var_1 thread [[ var_10 ]]( var_8, var_7, var_9, 0, "MOD_EXPLOSIVE", "iw6_minecart_mp", self.origin, var_6, "none", 0 );
                wait 0.2;
            }
        }

        wait 0.05;
    }
}

setupminecartinsidetrigger( var_0 )
{
    level endon( "game_ended" );
    self.playersincart = [];

    if ( !isdefined( var_0 ) )
        return;

    for (;;)
    {
        var_0 waittill( "trigger",  var_1  );

        if ( isplayer( var_1 ) && maps\mp\_utility::_ID18757( var_1 ) )
        {
            var_2 = var_1 getentitynumber();

            if ( !isdefined( self.playersincart[var_2] ) )
            {
                self.playersincart[var_2] = var_1;

                if ( self.playersincart.size == 1 )
                    thread waitforriderexit( var_0 );
            }
        }

        wait 0.05;
    }
}

waitforriderexit( var_0 )
{
    level endon( "game_ended" );

    while ( self.playersincart.size > 0 )
    {
        foreach ( var_3, var_2 in self.playersincart )
        {
            if ( !isdefined( var_2 ) || !maps\mp\_utility::_ID18757( var_2 ) || !var_2 istouching( var_0 ) )
                self.playersincart[var_3] = undefined;
        }

        wait 0.05;
    }
}

minecartsetupsparks()
{
    level._ID1644["cart_sparks"] = loadfx( "vfx/moments/mp_mine/vfx_track_sparks_child" );
    level._ID1644["cart_sparks_loop"] = loadfx( "vfx/moments/mp_mine/vfx_track_sparks_loop" );
    self._ID19616 = 10;
    self.sparktimestamp = 0;
}

minecartplaysparksonspeedchange( var_0 )
{
    if ( isdefined( var_0 ) && gettime() > self.sparktimestamp && abs( var_0 - self._ID19616 ) > 20 )
    {
        self._ID19616 = var_0;
        self.sparktimestamp = gettime() + 3500;
        thread minecartplaysparks( "cart_sparks" );
    }
}

minecartplaysparks( var_0 )
{
    playfxontag( common_scripts\utility::_ID15033( var_0 ), self.cartmodel, "tag_wheelL" );
    playfxontag( common_scripts\utility::_ID15033( var_0 ), self.cartmodel, "tag_wheelR" );
}

minecartstopsparks( var_0 )
{
    stopfxontag( common_scripts\utility::_ID15033( var_0 ), self.cartmodel, "tag_wheelL" );
    stopfxontag( common_scripts\utility::_ID15033( var_0 ), self.cartmodel, "tag_wheelR" );
}

minecarthandleevents( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_1 = strtok( var_0, "," );

    foreach ( var_3 in var_1 )
    {
        if ( maps\mp\_utility::_ID18801( var_3, "sfx=" ) )
        {
            var_4 = getsubstr( var_3, 4, var_3.size );
            self playsoundonmovingent( var_4 );
            continue;
        }

        if ( maps\mp\_utility::_ID18801( var_3, "loop=" ) )
        {
            var_4 = getsubstr( var_3, 5, var_3.size );
            self playloopsound( var_4 );
            continue;
        }

        if ( var_3 == "loopstop" )
        {
            self stoploopsound();
            continue;
        }

        if ( var_3 == "vfx" )
        {
            thread minecartplaysparks( "cart_sparks" );
            continue;
        }

        if ( var_3 == "vfxStart" )
        {
            thread minecartplaysparks( "cart_sparks_loop" );
            continue;
        }

        if ( var_3 == "vfxStop" )
        {
            minecartstopsparks( "cart_sparks_loop" );
            continue;
        }

        if ( maps\mp\_utility::_ID18801( var_3, "wheelSpeed=" ) )
        {
            var_5 = int( getsubstr( var_3, 11, var_3.size ) );

            if ( var_5 < level.minecartwheelanims.size )
                self.cartmodel scriptmodelplayanim( level.minecartwheelanims[var_5] );
        }
    }
}

initkillstreak()
{
    level.mapcustomkillstreakfunc = ::customkillstreakfunc;
    level._ID20636 = ::_ID8769;
    level._ID20635 = ::custombotkillstreakfunc;
}

_ID8769()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    if ( !maps\mp\_utility::allowlevelkillstreaks() || game["player_holding_level_killstrek"] )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "mine_level_killstreak", 90, maps\mp\killstreaks\_airdrop::killstreakcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"MP_MINE_LEVEL_KILLSTREAK_PICKUP" );
    level thread watchforcrateuse();
}

watchforcrateuse()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "mine_level_killstreak" )
        {
            maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "mine_level_killstreak", 0 );
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "mine_level_killstreak", 90 );
                continue;
            }

            game["player_holding_level_killstrek"] = 1;
            break;
        }
    }
}

_ID35446( var_0 )
{
    var_1 = _ID35948( var_0 );
    return !isdefined( var_1 );
}

_ID35948( var_0 )
{
    var_0 endon( "captured" );
    var_0 waittill( "death" );
    waittillframeend;
    return 1;
}

customkillstreakfunc()
{
    maps\mp\killstreaks\mp_wolfpack_killstreak::_ID17631();
    level._ID19276["iw6_minecart_mp"] = "iw6_minecart_mp";
}

custombotkillstreakfunc()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "mine_level_killstreak", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

ambientanimations()
{
    wait 3;
    var_0 = getent( "spinny_wheels", "targetname" );

    if ( isdefined( var_0 ) )
        var_0 scriptmodelplayanim( "mp_mine_spinning_wheels" );
}

wildlife()
{
    thread maps\interactive_models\vulture_mp::vulture_circling( ( 565, -1870, 1500 ), 3 );
    thread maps\interactive_models\vulture_mp::vulture_circling( ( -300, 1210, 1650 ), 2 );
    thread maps\interactive_models\batcave::_ID38250( "bats_flyaway_1", 1, "vfx_bats_flyaway_1", ( -2028.06, 464.427, 413.921 ) );
    thread maps\interactive_models\batcave::_ID38250( "bats_flyaway_2", 2, "vfx_bats_flyaway_2", ( -264.3, 927.7, 397.8 ), 2 );
}

crushplayerintrigger()
{
    level endon( "game_ended" );
    self endon( "stopCrushing" );

    for (;;)
    {
        self waittill( "trigger",  var_0  );

        if ( maps\mp\_utility::_ID18757( var_0 ) )
        {
            var_0 dodamage( 1000, var_0.origin, undefined, undefined, "MOD_CRUSH" );
            var_0 notify( "notify_moving_platform_invalid" );

            if ( isplayer( var_0 ) || isagent( var_0 ) )
                thread cleanupcrushedbody( var_0 getcorpseentity() );
        }
    }
}

cleanupcrushedbody( var_0 )
{
    playfx( common_scripts\utility::_ID15033( "gear_blood" ), var_0.origin, -1 * anglestoforward( var_0.angles ), anglestoup( var_0.angles ) );
    wait 0.7;

    if ( isdefined( var_0 ) )
    {
        playfx( common_scripts\utility::_ID15033( "gear_blood" ), var_0.origin, -1 * anglestoforward( var_0.angles ), anglestoup( var_0.angles ) );
        var_0 hide();
    }
}

cart_unresolved_collision_func( var_0, var_1 )
{
    if ( isplayer( var_0 ) && var_0 islinked() )
        var_0 unlink();

    maps\mp\_movers::_ID34254( var_0 );
}

setuppushtrigger( var_0, var_1 )
{
    level endon( "game_ended" );
    var_2 = getent( var_0, "targetname" );

    if ( !isdefined( var_2 ) )
        return;

    for (;;)
    {
        var_2 waittill( "trigger",  var_3  );

        if ( isplayer( var_3 ) || isagent( var_3 ) )
        {
            if ( var_3 islinked() )
            {
                var_3 unlink();
                var_3.startusemover = undefined;
            }

            var_4 = 100 * anglestoforward( var_1 );
            var_3 setvelocity( var_4 );
        }

        wait 0.1;
    }
}
