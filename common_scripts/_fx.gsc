// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17935()
{
    if ( !isdefined( level.func ) )
        level.func = [];

    if ( !isdefined( level.func["create_triggerfx"] ) )
        level.func["create_triggerfx"] = ::_ID8379;

    if ( !isdefined( level._fx ) )
        level._fx = spawnstruct();

    common_scripts\utility::create_lock( "createfx_looper", 20 );
    level.fxfireloopmod = 1;
    level._fx.exploderfunction = common_scripts\_exploder::_ID12467;
    waittillframeend;
    waittillframeend;
    level._fx.exploderfunction = common_scripts\_exploder::exploder_after_load;
    level._fx._ID28177 = 0;

    if ( getdvarint( "serverCulledSounds" ) == 1 )
        level._fx._ID28177 = 1;

    if ( level._ID8425 )
        level._fx._ID28177 = 0;

    if ( level._ID8425 )
        level waittill( "createfx_common_done" );

    for ( var_0 = 0; var_0 < level._ID8435.size; var_0++ )
    {
        var_1 = level._ID8435[var_0];
        var_1 common_scripts\_createfx::_ID28390();

        switch ( var_1._ID34830["type"] )
        {
            case "loopfx":
                var_1 thread _ID20348();
                continue;
            case "oneshotfx":
                var_1 thread _ID22829();
                continue;
            case "soundfx":
                var_1 thread create_loopsound();
                continue;
            case "soundfx_interval":
                var_1 thread _ID8340();
                continue;
            case "reactive_fx":
                var_1 add_reactive_fx();
                continue;
        }
    }

    _ID6991();
}

remove_dupes()
{

}

_ID6991()
{

}

_ID7030( var_0, var_1 )
{

}

_ID24989( var_0, var_1, var_2, var_3 )
{
    if ( getdvar( "debug" ) == "1" )
        return;
}

_ID22828( var_0, var_1, var_2, var_3 )
{

}

exploderfx( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17 )
{
    if ( 1 )
    {
        var_18 = common_scripts\utility::createexploder( var_1 );
        var_18._ID34830["origin"] = var_2;
        var_18._ID34830["angles"] = ( 0, 0, 0 );

        if ( isdefined( var_4 ) )
            var_18._ID34830["angles"] = vectortoangles( var_4 - var_2 );

        var_18._ID34830["delay"] = var_3;
        var_18._ID34830["exploder"] = var_0;

        if ( isdefined( level.createfxexploders ) )
        {
            var_19 = level.createfxexploders[var_18._ID34830["exploder"]];

            if ( !isdefined( var_19 ) )
                var_19 = [];

            var_19[var_19.size] = var_18;
            level.createfxexploders[var_18._ID34830["exploder"]] = var_19;
        }

        return;
    }

    var_20 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_20.origin = var_2;
    var_20.angles = vectortoangles( var_4 - var_2 );
    var_20._ID27562 = var_0;
    var_20._ID27611 = var_1;
    var_20.script_delay = var_3;
    var_20.script_firefx = var_5;
    var_20._ID27574 = var_6;
    var_20._ID27575 = var_7;
    var_20._ID27818 = var_8;
    var_20._ID27551 = var_9;
    var_20._ID27506 = var_10;
    var_20._ID27783 = var_15;
    var_20._ID27819 = var_11;
    var_20._ID27576 = var_16;
    var_20._ID27787 = var_12;
    var_20._ID27519 = var_13;
    var_20._ID27518 = var_14;
    var_20._ID27564 = var_17;
    var_21 = anglestoforward( var_20.angles );
    var_21 *= 150;
    var_20._ID32619 = var_2 + var_21;

    if ( !isdefined( level._script_exploders ) )
        level._script_exploders = [];

    level._script_exploders[level._script_exploders.size] = var_20;
}

_ID20341( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = common_scripts\utility::createloopeffect( var_0 );
    var_7._ID34830["origin"] = var_1;
    var_7._ID34830["angles"] = ( 0, 0, 0 );

    if ( isdefined( var_3 ) )
        var_7._ID34830["angles"] = vectortoangles( var_3 - var_1 );

    var_7._ID34830["delay"] = var_2;
}

create_looper()
{
    self._ID20339 = playloopedfx( level._ID1644[self._ID34830["fxid"]], self._ID34830["delay"], self._ID34830["origin"], 0, self._ID34830["forward"], self._ID34830["up"] );
    create_loopsound();
}

create_loopsound()
{
    self notify( "stop_loop" );

    if ( !isdefined( self._ID34830["soundalias"] ) )
        return;

    if ( self._ID34830["soundalias"] == "nil" )
        return;

    var_0 = 0;
    var_1 = undefined;

    if ( isdefined( self._ID34830["stopable"] ) && self._ID34830["stopable"] )
    {
        if ( isdefined( self._ID20339 ) )
            var_1 = "death";
        else
            var_1 = "stop_loop";
    }
    else if ( level._fx._ID28177 && isdefined( self._ID34830["server_culled"] ) )
        var_0 = self._ID34830["server_culled"];

    var_2 = self;

    if ( isdefined( self._ID20339 ) )
        var_2 = self._ID20339;

    var_3 = undefined;

    if ( level._ID8425 )
        var_3 = self;

    var_2 common_scripts\utility::_ID20331( self._ID34830["soundalias"], self._ID34830["origin"], self._ID34830["angles"], var_0, var_1, var_3 );
}

_ID8340()
{
    self notify( "stop_loop" );

    if ( !isdefined( self._ID34830["soundalias"] ) )
        return;

    if ( self._ID34830["soundalias"] == "nil" )
        return;

    var_0 = undefined;
    var_1 = self;

    if ( isdefined( self._ID34830["stopable"] ) && self._ID34830["stopable"] || level._ID8425 )
    {
        if ( isdefined( self._ID20339 ) )
        {
            var_1 = self._ID20339;
            var_0 = "death";
        }
        else
            var_0 = "stop_loop";
    }

    var_1 thread common_scripts\utility::_ID20330( self._ID34830["soundalias"], self._ID34830["origin"], self._ID34830["angles"], var_0, undefined, self._ID34830["delay_min"], self._ID34830["delay_max"] );
}

_ID20348()
{
    common_scripts\utility::_ID35582();

    if ( isdefined( self._ID14034 ) )
        level waittill( "start fx" + self._ID14034 );

    for (;;)
    {
        create_looper();

        if ( isdefined( self.timeout ) )
            thread _ID20347( self.timeout );

        if ( isdefined( self.fxstop ) )
            level waittill( "stop fx" + self.fxstop );
        else
            return;

        if ( isdefined( self._ID20339 ) )
            self._ID20339 delete();

        if ( isdefined( self._ID14034 ) )
        {
            level waittill( "start fx" + self._ID14034 );
            continue;
        }

        return;
    }
}

_ID20344( var_0 )
{
    self endon( "death" );
    var_0 waittill( "effect id changed",  var_1  );
}

_ID20345( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        var_0 waittill( "effect org changed",  var_1  );
        self.origin = var_1;
    }
}

_ID20343( var_0 )
{
    self endon( "death" );
    var_0 waittill( "effect delay changed",  var_1  );
}

_ID20346( var_0 )
{
    self endon( "death" );
    var_0 waittill( "effect deleted" );
    self delete();
}

_ID20347( var_0 )
{
    self endon( "death" );
    wait(var_0);
    self._ID20339 delete();
}

_ID20356( var_0, var_1, var_2 )
{
    level thread _ID20358( var_0, var_1, var_2 );
}

_ID20358( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_origin", var_1 );
    var_3.origin = var_1;
    var_3 playloopsound( var_0 );
}

_ID15884( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    thread _ID15885( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 );
}

_ID15885( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    level endon( "stop all gunfireloopfx" );
    common_scripts\utility::_ID35582();

    if ( var_7 < var_6 )
    {
        var_8 = var_7;
        var_7 = var_6;
        var_6 = var_8;
    }

    var_9 = var_6;
    var_10 = var_7 - var_6;

    if ( var_5 < var_4 )
    {
        var_8 = var_5;
        var_5 = var_4;
        var_4 = var_8;
    }

    var_11 = var_4;
    var_12 = var_5 - var_4;

    if ( var_3 < var_2 )
    {
        var_8 = var_3;
        var_3 = var_2;
        var_2 = var_8;
    }

    var_13 = var_2;
    var_14 = var_3 - var_2;
    var_15 = spawnfx( level._ID1644[var_0], var_1 );

    if ( !level._ID8425 )
        var_15 willneverchange();

    for (;;)
    {
        var_16 = var_13 + randomint( var_14 );

        for ( var_17 = 0; var_17 < var_16; var_17++ )
        {
            triggerfx( var_15 );
            wait(var_11 + randomfloat( var_12 ));
        }

        wait(var_9 + randomfloat( var_10 ));
    }
}

_ID15886( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    thread gunfireloopfxvecthread( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
}

gunfireloopfxvecthread( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    level endon( "stop all gunfireloopfx" );
    common_scripts\utility::_ID35582();

    if ( var_8 < var_7 )
    {
        var_9 = var_8;
        var_8 = var_7;
        var_7 = var_9;
    }

    var_10 = var_7;
    var_11 = var_8 - var_7;

    if ( var_6 < var_5 )
    {
        var_9 = var_6;
        var_6 = var_5;
        var_5 = var_9;
    }

    var_12 = var_5;
    var_13 = var_6 - var_5;

    if ( var_4 < var_3 )
    {
        var_9 = var_4;
        var_4 = var_3;
        var_3 = var_9;
    }

    var_14 = var_3;
    var_15 = var_4 - var_3;
    var_2 = vectornormalize( var_2 - var_1 );
    var_16 = spawnfx( level._ID1644[var_0], var_1, var_2 );

    if ( !level._ID8425 )
        var_16 willneverchange();

    for (;;)
    {
        var_17 = var_14 + randomint( var_15 );

        for ( var_18 = 0; var_18 < int( var_17 / level.fxfireloopmod ); var_18++ )
        {
            triggerfx( var_16 );
            var_19 = ( var_12 + randomfloat( var_13 ) ) * level.fxfireloopmod;

            if ( var_19 < 0.05 )
                var_19 = 0.05;

            wait(var_19);
        }

        wait(var_12 + randomfloat( var_13 ));
        wait(var_10 + randomfloat( var_11 ));
    }
}

_ID28722( var_0 )
{
    level.fxfireloopmod = 1 / var_0;
}

_ID29018()
{
    if ( !isdefined( self._ID27611 ) || !isdefined( self._ID27610 ) || !isdefined( self.script_delay ) )
        return;

    if ( isdefined( self.model ) )
    {
        if ( self.model == "toilet" )
        {
            thread _ID6318();
            return;
        }
    }

    var_0 = undefined;

    if ( isdefined( self.target ) )
    {
        var_1 = getent( self.target, "targetname" );

        if ( isdefined( var_1 ) )
            var_0 = var_1.origin;
    }

    var_2 = undefined;

    if ( isdefined( self._ID27612 ) )
        var_2 = self._ID27612;

    var_3 = undefined;

    if ( isdefined( self._ID27613 ) )
        var_3 = self._ID27613;

    if ( self._ID27610 == "OneShotfx" )
        _ID22828( self._ID27611, self.origin, self.script_delay, var_0 );

    if ( self._ID27610 == "loopfx" )
        _ID20341( self._ID27611, self.origin, self.script_delay, var_0, var_2, var_3 );

    if ( self._ID27610 == "loopsound" )
        _ID20356( self._ID27611, self.origin, self.script_delay );

    self delete();
}

_ID6318()
{
    var_0 = ( 0, 0, self.angles[1] );
    var_1 = level._ID1644[self._ID27611];
    var_2 = self.origin;
    wait 1;
    level thread burnville_paratrooper_hack_loop( var_0, var_2, var_1 );
    self delete();
}

burnville_paratrooper_hack_loop( var_0, var_1, var_2 )
{
    for (;;)
    {
        playfx( var_2, var_1 );
        wait(30 + randomfloat( 40 ));
    }
}

_ID8379()
{
    if ( !_ID35172( self._ID34830["fxid"] ) )
        return;

    self._ID20339 = spawnfx( level._ID1644[self._ID34830["fxid"]], self._ID34830["origin"], self._ID34830["forward"], self._ID34830["up"] );
    triggerfx( self._ID20339, self._ID34830["delay"] );

    if ( !level._ID8425 )
        self._ID20339 willneverchange();

    create_loopsound();
}

_ID35172( var_0 )
{
    if ( isdefined( level._ID1644[var_0] ) )
        return 1;

    if ( !isdefined( level._ID1736 ) )
        level._ID1736 = [];

    level._ID1736[self._ID34830["fxid"]] = var_0;
    _ID35173( var_0 );
    return 0;
}

_ID35173( var_0 )
{
    level notify( "verify_effects_assignment_print" );
    level endon( "verify_effects_assignment_print" );
    wait 0.05;
    var_1 = getarraykeys( level._ID1736 );

    foreach ( var_3 in var_1 )
    {

    }
}

_ID22829()
{
    wait 0.05;

    if ( self._ID34830["delay"] > 0 )
        wait(self._ID34830["delay"]);

    [[ level.func["create_triggerfx"] ]]();
}

add_reactive_fx()
{
    if ( !common_scripts\utility::_ID18787() && getdvar( "createfx" ) == "" )
        return;

    if ( !isdefined( level._fx._ID25543 ) )
    {
        level._fx._ID25543 = 1;
        level thread _ID25539();
    }

    if ( !isdefined( level._fx.reactive_fx_ents ) )
        level._fx.reactive_fx_ents = [];

    level._fx.reactive_fx_ents[level._fx.reactive_fx_ents.size] = self;
    self.next_reactive_time = 3000;
}

_ID25539()
{
    if ( !common_scripts\utility::_ID18787() )
    {
        if ( getdvar( "createfx" ) == "on" )
            common_scripts\utility::flag_wait( "createfx_started" );
    }

    level._fx.reactive_sound_ents = [];
    var_0 = 256;

    for (;;)
    {
        level waittill( "code_damageradius",  var_1, var_0, var_2, var_3  );
        var_4 = _ID30452( var_2, var_0 );

        foreach ( var_7, var_6 in var_4 )
            var_6 thread _ID23823( var_7 );
    }
}

_ID34934( var_0 )
{
    return ( var_0[0], var_0[1], 0 );
}

_ID30452( var_0, var_1 )
{
    var_2 = [];
    var_3 = gettime();

    foreach ( var_5 in level._fx.reactive_fx_ents )
    {
        if ( var_5.next_reactive_time > var_3 )
            continue;

        var_6 = var_5._ID34830["reactive_radius"] + var_1;
        var_6 *= var_6;

        if ( distancesquared( var_0, var_5._ID34830["origin"] ) < var_6 )
            var_2[var_2.size] = var_5;
    }

    foreach ( var_5 in var_2 )
    {
        var_9 = _ID34934( var_5._ID34830["origin"] - level.player.origin );
        var_10 = _ID34934( var_0 - level.player.origin );
        var_11 = vectornormalize( var_9 );
        var_12 = vectornormalize( var_10 );
        var_5._ID10775 = vectordot( var_11, var_12 );
    }

    for ( var_14 = 0; var_14 < var_2.size - 1; var_14++ )
    {
        for ( var_15 = var_14 + 1; var_15 < var_2.size; var_15++ )
        {
            if ( var_2[var_14]._ID10775 > var_2[var_15]._ID10775 )
            {
                var_16 = var_2[var_14];
                var_2[var_14] = var_2[var_15];
                var_2[var_15] = var_16;
            }
        }
    }

    foreach ( var_5 in var_2 )
    {
        var_5.origin = undefined;
        var_5._ID10775 = undefined;
    }

    for ( var_14 = 4; var_14 < var_2.size; var_14++ )
        var_2[var_14] = undefined;

    return var_2;
}

_ID23823( var_0 )
{
    var_1 = _ID14716();

    if ( !isdefined( var_1 ) )
        return;

    self.next_reactive_time = gettime() + 3000;
    var_1.origin = self._ID34830["origin"];
    var_1._ID18476 = 1;
    wait(var_0 * randomfloatrange( 0.05, 0.1 ));

    if ( common_scripts\utility::_ID18787() )
    {
        var_1 playsound( self._ID34830["soundalias"], "sounddone" );
        var_1 waittill( "sounddone" );
    }
    else
    {
        var_1 playsound( self._ID34830["soundalias"] );
        wait 2;
    }

    wait 0.1;
    var_1._ID18476 = 0;
}

_ID14716()
{
    foreach ( var_1 in level._fx.reactive_sound_ents )
    {
        if ( !var_1._ID18476 )
            return var_1;
    }

    if ( level._fx.reactive_sound_ents.size < 4 )
    {
        var_1 = spawn( "script_origin", ( 0, 0, 0 ) );
        var_1._ID18476 = 0;
        level._fx.reactive_sound_ents[level._fx.reactive_sound_ents.size] = var_1;
        return var_1;
    }

    return undefined;
}
