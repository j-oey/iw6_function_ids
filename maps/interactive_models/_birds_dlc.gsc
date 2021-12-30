// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

birds( var_0 )
{
    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
        return;

    birds_finishbirdtypesetup( var_0 );

    if ( common_scripts\utility::_ID18787() )
        level waittill( "load_finished" );
    else
        level waittill( "interactive_start" );

    if ( !isdefined( level._interactive["birds_setup"] ) )
    {
        level._interactive["birds_setup"] = 1;
        level._interactive["bird_perches"] = [];
        var_1 = getentarray( "interactive_birds", "targetname" );

        foreach ( var_3 in var_1 )
            var_3 thread birds_setup();
    }
}

birds_setup()
{
    birds_setupconnectedperches();

    if ( isdefined( self._ID27870 ) )
    {
        var_0 = birds_savetostruct();
        level waittill( "start_" + self._ID27870 );
        var_0 birds_loadfromstruct();
    }
    else
    {
        birds_createents();
        thread birds_fly( self.target );
    }
}

birds_createents()
{
    var_0 = level._interactive[self._ID18081];

    if ( !isdefined( self.interactive_number ) )
        self.interactive_number = var_0._ID26294;

    self setmodel( var_0.rig_model );

    if ( common_scripts\utility::_ID18787() )
        self call [[ level.func["useanimtree"] ]]( var_0._ID26291 );

    self hideallparts();
    self.birds = [];
    self.birdexists = [];
    self._ID22394 = 0;

    for ( var_1 = 1; var_1 <= self.interactive_number; var_1++ )
    {
        self.birds[var_1] = spawn( "script_model", self gettagorigin( "tag_bird" + var_1 ) );
        self.birds[var_1] setmodel( var_0.bird_model["idle"] );
        self.birds[var_1].angles = self.angles;
        self.birds[var_1] linkto( self, "tag_bird" + var_1 );

        if ( common_scripts\utility::_ID18787() )
            self.birds[var_1] call [[ level.func["useanimtree"] ]]( var_0._ID5232 );

        var_2 = ( var_1 - randomfloat( 1 ) ) / self.interactive_number;
        self.birds[var_1] thread maps\interactive_models\_interactive_utility::_ID35508( var_2, "Stop initial model setup", ::bird_sit, self, "tag_bird" + var_1, var_0.bird_model["idle"], var_0.birdmodel_anims );
        self.birdexists[var_1] = 1;
        self._ID22394++;

        if ( isdefined( var_0._ID5236 ) )
            self.birds[var_1].health = var_0._ID5236;
        else
            self.birds[var_1].health = 20;

        self.birds[var_1] setcandamage( 1 );
        self.birds[var_1] thread bird_waitfordamage( self, var_1 );
    }

    if ( isdefined( self._ID27870 ) )
        thread _ID5265();
}

birds_setupconnectedperches( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = getent( self.target, "targetname" );

    var_2 = spawnstruct();
    var_2.targetname = var_0.targetname;
    var_2.target = var_0.target;
    var_2.origin = var_0.origin;
    var_2.angles = var_0.angles;
    var_2._ID18079 = var_0._ID18079;
    var_2._ID18077 = var_0._ID18077;
    var_2._ID27783 = var_0._ID27783;
    var_2.script_noteworthy = var_0.script_noteworthy;
    var_2._ID27870 = var_0._ID27870;

    if ( isdefined( var_1 ) )
        var_1[0] = var_2;

    if ( isdefined( var_0._ID17523 ) )
    {
        foreach ( var_4 in var_0._ID17523 )
            var_4._ID11748 = var_2;
    }

    var_0 delete();
    level._interactive["bird_perches"][var_2.targetname] = var_2;

    if ( !isdefined( var_2._ID18079 ) )
        var_2._ID18079 = "flying";

    if ( !isdefined( var_2._ID18077 ) )
        var_2._ID18077 = "flying";

    var_2.triggers = [];
    var_6 = getentarray( var_2.targetname, "target" );

    foreach ( var_8 in var_6 )
    {
        if ( var_8.classname == "trigger_multiple" )
            var_2.triggers[var_2.triggers.size] = var_8;
    }

    if ( isdefined( var_2.target ) )
    {
        var_6 = getentarray( var_2.target, "targetname" );

        foreach ( var_8 in var_6 )
        {
            if ( var_8.classname == "trigger_multiple" )
                var_2.triggers[var_2.triggers.size] = var_8;
        }
    }

    if ( isdefined( var_2._ID27870 ) )
    {
        var_6 = getentarray( var_2._ID27870, "target" );

        foreach ( var_8 in var_6 )
        {
            if ( var_8.classname == "trigger_multiple" )
                var_2.triggers[var_2.triggers.size] = var_8;
        }
    }

    if ( !isdefined( var_1 ) )
    {
        var_14 = getvehiclenodearray( var_2.target, "targetname" );

        foreach ( var_16 in var_14 )
        {
            var_17 = [];
            var_17[0] = var_2;
            var_17[1] = var_16;

            for ( var_18 = 1; !isdefined( var_17[var_18].script_noteworthy ) || var_17[var_18].script_noteworthy != "bird_perch"; var_18++ )
            {
                if ( !isdefined( var_17[var_18].target ) )
                    break;

                var_19 = var_17[var_18].target;
                var_20 = getvehiclenode( var_19, "targetname" );

                if ( !isdefined( var_20 ) )
                {
                    var_20 = getnode( var_19, "targetname" );

                    if ( !isdefined( var_20 ) )
                    {
                        var_20 = getent( var_19, "targetname" );

                        if ( isdefined( var_20 ) )
                            var_20 = birds_setupconnectedperches( var_20 );
                        else
                            var_20 = level._interactive["bird_perches"][var_19];
                    }
                }

                var_17[var_18 + 1] = var_20;
            }

            var_2 birds_perchsetuppath( var_17 );
        }
    }
    else
        var_2 birds_perchsetuppath( var_1 );

    return var_2;
}

birds_perchsetuppath( var_0 )
{
    if ( !isdefined( self._ID23084 ) )
        self._ID23084 = [];

    var_1 = common_scripts\_csplines::cspline_makepath( var_0 );
    var_2 = var_0[var_0.size - 1];

    if ( isdefined( var_2.classname ) )
    {
        if ( !isdefined( var_2._ID17523 ) )
            var_2._ID17523 = [];

        var_2._ID17523[var_2._ID17523.size] = var_1;
    }

    if ( isdefined( var_2.script_noteworthy ) && var_2.script_noteworthy == "bird_perch" )
    {
        var_1._ID11748 = var_2;
        var_1._ID19326 = var_2._ID18077;
    }

    var_1._ID31467 = self.origin;
    var_1._ID31426 = self.angles;
    var_1._ID32394 = self._ID18079;
    var_1._ID11747 = var_2.origin;
    var_1._ID11596 = var_2.angles;
    self._ID23084[self._ID23084.size] = var_1;
}

birds_fly( var_0 )
{
    self endon( "death" );
    self._ID23419 = level._interactive["bird_perches"][var_0];
    var_1 = level._interactive[self._ID18081];
    var_2 = self._ID23419._ID23084[randomint( self._ID23419._ID23084.size )];
    var_3 = common_scripts\_csplines::_ID8565( var_2, 0 );
    self.origin = var_3["pos"];
    self.angles = var_2._ID31426;

    if ( common_scripts\utility::_ID18787() )
    {
        self call [[ level.func["setanimknob"] ]]( var_1.rigmodel_anims[var_2._ID32394], 1, 0, 0 );
        self call [[ level.func["setanimtime"] ]]( var_1.rigmodel_anims[var_2._ID32394], 0 );
    }
    else
        self call [[ level.func["scriptModelPlayAnim"] ]]( var_1.rigmodel_anims[self._ID23419._ID18077 + "mp"] );

    var_4 = 0;
    self.landed = 1;
    var_5 = var_1._ID27331;

    if ( isdefined( self._ID23419._ID27783 ) )
        var_5 = self._ID23419._ID27783;

    if ( var_5 > 0 )
        self._ID23419 thread birds_perchdangertrigger( var_5, "triggered", "leaving perch" );

    for (;;)
    {
        var_6 = 0;
        var_7 = var_1.rigmodel_anims[var_2._ID32394];
        var_8 = var_1.rigmodel_anims[var_2._ID32394 + "mp"];
        var_9 = var_1.rigmodel_anims["flying"];
        var_10 = var_1.rigmodel_anims["flyingmp"];

        if ( isdefined( var_2._ID19326 ) )
        {
            var_11 = var_1.rigmodel_anims[var_2._ID19326];
            var_12 = var_1.rigmodel_anims[var_2._ID19326 + "mp"];
        }
        else
        {
            var_11 = undefined;
            var_12 = undefined;
        }

        if ( isdefined( var_1._ID26309[var_2._ID32394] ) )
            var_13 = var_1._ID26309[var_2._ID32394];
        else
            var_13 = 0;

        var_14 = 0;

        if ( !self.landed )
        {
            if ( common_scripts\utility::_ID18787() )
            {
                if ( isdefined( var_11 ) && self._ID8682 == var_11 )
                {
                    var_6 = 1 - self call [[ level.func["getanimtime"] ]]( self._ID8682 );
                    var_14 = var_6 * getanimlength( var_7 );
                    var_13 -= var_14;
                    var_13 = max( 0, var_13 );
                }
                else
                {
                    var_7 = var_1.rigmodel_anims["flying"];
                    var_8 = var_1.rigmodel_anims["flyingmp"];
                    var_6 = self call [[ level.func["getanimtime"] ]]( self._ID8682 );
                    var_14 = var_6 * getanimlength( var_7 );
                    var_13 = 0;
                }
            }
            else
            {
                var_7 = var_1.rigmodel_anims["flying"];
                var_8 = var_1.rigmodel_anims["flyingmp"];
                var_6 = 0;
                var_14 = 0;
                var_13 = 0;
            }
        }

        if ( isdefined( var_11 ) && isdefined( var_1.rigmodel_pauseend[var_2._ID19326] ) )
            var_15 = var_1.rigmodel_pauseend[var_2._ID19326];
        else
            var_15 = 0;

        var_16 = var_1.accn / 400;
        var_17 = var_2.segments[var_2.segments.size - 1]._ID11597;
        var_18 = sqrt( var_16 * var_17 + var_4 * var_4 / 2 );
        var_19 = var_1._ID33122 / 20;

        if ( var_18 < var_19 )
            var_19 = var_18;

        var_20 = int( ( var_19 - var_4 ) / var_16 );
        var_21 = var_16 * var_20 / 2 * ( var_20 + 1 ) + var_4 * var_20;

        if ( isdefined( var_2._ID11748 ) )
        {
            var_22 = int( var_19 / var_16 );
            var_23 = var_16 * var_22 / 2 * ( var_22 + 1 );
        }
        else
        {
            var_22 = 0;
            var_23 = 0;
        }

        var_24 = ( var_17 - var_21 + var_23 ) / var_19;
        var_25 = ( var_24 + ( var_20 + var_22 ) ) / 20;
        var_26 = getanimlength( var_9 );

        if ( isdefined( var_11 ) )
            var_27 = getanimlength( var_7 ) + getanimlength( var_11 ) - var_13 + var_14 + var_15;
        else
            var_27 = getanimlength( var_7 ) - var_13 + var_14 + var_15;

        var_28 = int( ( var_25 - var_27 ) / var_26 + 0.5 );
        var_29 = ( var_28 * var_26 + var_27 ) / var_25;
        var_30 = var_2._ID11596 - var_2._ID31426;
        var_30 = ( angleclamp180( var_30[0] ), angleclamp180( var_30[1] ), angleclamp180( var_30[2] ) );

        if ( self.landed )
        {
            self._ID23419 waittill( "triggered" );
            self notify( "stop_path" );
            self.landed = 0;
            thread _ID13363( var_7, 0, var_9, var_11, var_29, var_28, var_8, var_10, var_12 );
            thread _ID13365( var_1, "takeoff" );
            var_31 = var_13 == 0;

            for ( var_32 = 1; var_32 <= self.interactive_number; var_32++ )
            {
                if ( self.birdexists[var_32] )
                    self.birds[var_32] thread _ID5234( self, "tag_bird" + var_32, var_1.bird_model["fly"], var_1.bird_model["idle"], var_1.birdmodel_anims, "land_" + var_32, "takeoff_" + var_32, var_31 );
            }
        }
        else
        {
            self notify( "stop_path" );
            thread _ID13363( var_7, var_6, var_9, var_11, var_29, var_28, var_8, var_10, var_12 );

            for ( var_32 = 1; var_32 <= self.interactive_number; var_32++ )
            {
                if ( self.birdexists[var_32] )
                {
                    if ( common_scripts\utility::_ID18787() )
                        var_33 = undefined;
                    else
                        var_33 = randomfloat( 0.5 );

                    self.birds[var_32] thread bird_fly( self, "tag_bird" + var_32, var_1.bird_model["fly"], var_1.bird_model["idle"], var_1.birdmodel_anims, "land_" + var_32, var_33 );
                }
            }
        }

        if ( isdefined( self._ID23419 ) )
        {
            self._ID23419 notify( "leaving perch" );
            self._ID23419 = undefined;
        }

        wait(var_13);
        var_34 = 0;

        while ( var_4 < var_19 - var_16 )
        {
            var_4 += var_16;
            var_34 += var_4;
            var_3 = flock_setflyingposandangles( var_2, var_34, var_17, var_4, var_30 );
            wait 0.05;
        }

        var_4 = var_19;

        while ( var_34 < var_17 - var_23 )
        {
            var_34 += var_4;
            var_3 = flock_setflyingposandangles( var_2, var_34, var_17, var_4, var_30 );
            wait 0.05;
        }

        if ( !isdefined( var_2._ID11748 ) )
            _ID5245();

        var_35 = var_17 - var_34;
        var_36 = var_35 / var_23;
        var_4 = var_16 * ( int( var_4 / var_16 ) + 1 );
        self._ID23419 = var_2._ID11748;
        self._ID23419 thread birds_perchdangertrigger( var_5, "triggered", "leaving perch" );

        while ( var_4 > var_19 * 0.75 || var_4 > 0 && birds_isperchsafe( self._ID23419 ) )
        {
            var_4 -= var_16;
            var_34 += var_4 * var_36;
            var_3 = flock_setflyingposandangles( var_2, var_34, var_17, var_4, var_30 );
            wait 0.05;
        }

        if ( var_4 <= 0 )
        {
            self.origin = self._ID23419.origin;
            self.angles = self._ID23419.angles;
            var_2 = self._ID23419._ID23084[randomint( self._ID23419._ID23084.size )];

            for ( var_32 = 0; var_32 < 20 * var_15 && birds_isperchsafe( self._ID23419 ); var_32++ )
                wait 0.05;

            if ( birds_isperchsafe( self._ID23419 ) )
                self.landed = 1;

            continue;
        }

        var_37 = self._ID23419._ID23084[randomint( self._ID23419._ID23084.size )];
        var_2 = birds_path_move_first_point( var_37, var_3["pos"], var_3["vel"] * var_4 / var_19 );
        var_2._ID31426 = self.angles;
        self._ID23419 notify( "leaving perch" );
        self._ID23419 = undefined;
    }
}

_ID9257( var_0 )
{

}

_ID5261( var_0, var_1, var_2 )
{
    var_3 = 0.2;

    for ( var_4 = 1; var_4 <= var_2.size; var_4++ )
    {
        if ( self.birdexists[var_4] )
        {
            var_5 = var_0 gettagangles( "tag_bird" + var_4 );
            var_6 = anglestoforward( var_5 ) / var_3;
            var_7 = var_6 + var_1;
            var_8 = vectortoangles( var_7 );
            var_9 = var_8 - var_5;
            var_9 = ( angleclamp180( var_9[0] ) / 3, angleclamp180( var_9[1] ), 0 );
            var_2[var_4] linkto( var_0, "tag_bird" + var_4, ( 0, 0, 0 ), var_9 );
        }
    }
}

flock_setflyingposandangles( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = common_scripts\_csplines::_ID8565( var_0, var_1 );
    self.origin = var_5["pos"];

    if ( common_scripts\utility::_ID18787() )
    {
        self.angles = var_0._ID31426 + var_4 * var_1 / var_2;
        _ID5261( self, var_5["vel"] * var_3, self.birds );
    }
    else
    {
        var_6 = 15;
        var_7 = var_1 + var_3 * var_6;

        if ( var_7 < var_2 )
        {
            var_8 = common_scripts\_csplines::_ID8565( var_0, var_7 );
            var_9 = vectortoangles( var_8["vel"] );
            var_4 = var_9 - self.angles;
            var_4 = anglessoftclamp( var_4, 2, 0.3, 8 );
        }
        else
        {
            var_4 = var_0._ID11596 - self.angles;
            var_4 = ( angleclamp180( var_4[0] ), angleclamp180( var_4[1] ), angleclamp180( var_4[2] ) );

            if ( var_3 > 0 )
            {
                var_10 = ( var_2 - var_1 ) / var_3;

                if ( var_10 > 1 )
                    var_4 /= var_10;
            }
        }

        self.angles = self.angles + var_4;
    }

    return var_5;
}

_ID13365( var_0, var_1 )
{
    if ( isdefined( var_0.sounds ) && isdefined( var_0.sounds[var_1] ) )
        self playsound( var_0.sounds[var_1] );
}

_ID13363( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self endon( "death" );
    self endon( "stop_path" );

    if ( common_scripts\utility::_ID18787() )
    {
        var_9 = 0;

        if ( getanimlength( var_0 ) == 0 )
        {

        }
        else
        {
            var_10 = var_4 / getanimlength( var_0 ) * 20;
            var_1 -= 2 * var_10;

            if ( var_1 > var_10 )
                var_9 = 0.3;

            self call [[ level.func["setflaggedanimknob"] ]]( "bird_rig_takeoff_anim", var_0, 1, var_9, var_4 );
            self._ID8682 = var_0;

            if ( var_1 > var_10 )
            {
                common_scripts\utility::_ID35582();
                self call [[ level.func["setanimtime"] ]]( var_0, var_1 );
                self waittillmatch( "bird_rig_takeoff_anim",  "end"  );
            }
            else
                self waittillmatch( "bird_rig_takeoff_anim",  "end"  );
        }

        self call [[ level.func["setflaggedanimknobrestart"] ]]( "bird_rig_loop_anim", var_2, 1, 0, var_4 );
        self._ID8682 = var_2;

        for ( var_11 = 0; var_11 < var_5; var_11++ )
            self waittillmatch( "bird_rig_loop_anim",  "end"  );

        if ( isdefined( var_3 ) )
        {
            self call [[ level.func["setflaggedanimknobrestart"] ]]( "bird_rig_land_anim", var_3, 1, 0.05, var_4 );
            self._ID8682 = var_3;
            self waittillmatch( "bird_rig_land_anim",  "end"  );
            return;
        }
    }
    else
    {
        if ( getanimlength( var_0 ) == 0 )
        {

        }
        else if ( var_1 < 0.2 )
        {
            self call [[ level.func["scriptModelPlayAnim"] ]]( var_6 );
            self._ID8682 = var_0;
            wait(getanimlength( var_0 ));
        }

        self call [[ level.func["scriptModelPlayAnim"] ]]( var_7 );
        self._ID8682 = var_2;

        for ( var_11 = 0; var_11 < var_5; var_11++ )
            wait(getanimlength( var_2 ));

        if ( isdefined( var_3 ) )
        {
            self call [[ level.func["scriptModelPlayAnim"] ]]( var_8 );
            self._ID8682 = var_3;
            wait(getanimlength( var_3 ));

            for ( var_11 = 1; var_11 <= self.birds.size; var_11++ )
                self notify( "bird_rig_land_anim",  "land_" + var_11  );
        }
    }
}

_ID5234( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    self endon( "death" );
    var_0 endon( "stop_path" );

    if ( common_scripts\utility::_ID18787() )
    {
        if ( isdefined( var_6 ) && !var_7 )
            var_0 waittillmatch( "bird_rig_takeoff_anim",  var_6  );
    }
    else
        wait(randomfloat( 0.3 ));

    self notify( "Stop initial model setup" );
    self setmodel( var_2 );
    self notify( "stop_loop" );

    if ( var_7 )
    {
        var_8 = maps\interactive_models\_interactive_utility::_ID30041( var_4, "flying", undefined, 0 );

        if ( common_scripts\utility::_ID18787() )
        {
            common_scripts\utility::_ID35582();
            self call [[ level.func["setanimtime"] ]]( var_8, randomfloat( 1 ) );
        }
    }
    else if ( isdefined( var_4["takeoff"] ) )
    {
        var_9 = maps\interactive_models\_interactive_utility::_ID30041( var_4, "takeoff", "takeoff_anim", 1 );

        if ( common_scripts\utility::_ID18787() )
            self waittillmatch( "takeoff_anim",  "end"  );
        else
            wait(getanimlength( var_9 ));
    }

    bird_fly( var_0, var_1, var_2, var_3, var_4, var_5 );
}

bird_fly( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self endon( "death" );
    var_0 endon( "stop_path" );

    if ( isdefined( var_6 ) )
        wait(var_6);

    self setmodel( var_2 );
    self notify( "stop_loop" );
    thread maps\interactive_models\_interactive_utility::_ID20322( var_4, "flying", "stop_loop" );
    var_0 waittillmatch( "bird_rig_land_anim",  var_5  );

    if ( !common_scripts\utility::_ID18787() )
        wait(randomfloat( 1 ) * randomfloat( 1 ));

    if ( isdefined( var_4["land"] ) )
    {
        self notify( "stop_loop" );
        self endon( "stop_loop" );
        maps\interactive_models\_interactive_utility::_ID30041( var_4, "land", undefined, 1 );
    }

    thread bird_sit( var_0, var_1, var_3, var_4 );
}

bird_sit( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    self setmodel( var_2 );
    self notify( "stop_loop" );
    maps\interactive_models\_interactive_utility::_ID20322( var_3, "idle", "stop_loop" );
}

bird_waitfordamage( var_0, var_1 )
{
    for (;;)
    {
        self waittill( "damage",  var_2, var_3, var_4, var_5, var_6  );

        if ( isdefined( var_0._ID23419 ) )
        {
            var_0._ID23419 notify( "triggered" );
            var_0._ID23419.lastaieventtrigger = gettime();
        }

        if ( isdefined( self.origin ) )
        {
            if ( var_6 == "MOD_GRENADE_SPLASH" )
                var_5 = self.origin + ( 0, 0, 5 );

            playfx( level._interactive[var_0._ID18081].death_effect, var_5 );

            if ( self.health <= 0 )
            {
                var_0.birdexists[var_1] = 0;
                var_0._ID22394--;

                if ( var_0._ID22394 == 0 )
                    var_0 delete();

                self delete();
            }
        }
    }
}

birds_finishbirdtypesetup( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    var_0._ID27308 = ::birds_savetostruct;
    var_0._ID20119 = ::birds_loadfromstruct;
    var_0._ID26309 = [];
    var_0.rigmodel_pauseend = [];
    var_2 = getarraykeys( var_0.rigmodel_anims );

    foreach ( var_4 in var_2 )
    {
        if ( !isendstr( var_4, "mp" ) )
        {
            if ( common_scripts\utility::string_starts_with( var_4, "takeoff_" ) )
            {
                if ( getanimlength( var_0.rigmodel_anims[var_4] ) == 0 )
                {
                    var_0.rigmodel_anims[var_4] = var_0.rigmodel_anims["fly"];
                    var_0._ID26309[var_4] = 0;
                }
                else
                    var_0._ID26309[var_4] = birds_get_last_takeoff( var_0, var_4, var_0._ID26294 ) + var_1;

                continue;
            }

            if ( common_scripts\utility::string_starts_with( var_4, "land_" ) )
            {
                if ( getanimlength( var_0.rigmodel_anims[var_4] ) == 0 )
                {
                    var_0.rigmodel_anims[var_4] = var_0.rigmodel_anims["fly"];
                    var_0.rigmodel_pauseend[var_4] = 0;
                    continue;
                }

                var_0.rigmodel_pauseend[var_4] = _ID5249( var_0, var_4, var_0._ID26294 );
            }
        }
    }
}

birds_get_last_takeoff( var_0, var_1, var_2 )
{
    var_3 = var_0.rigmodel_anims[var_1];
    var_4 = 0;

    for ( var_5 = 1; var_5 <= var_2; var_5++ )
    {
        var_6 = getnotetracktimes( var_3, "takeoff_" + var_5 );

        if ( var_6.size <= 0 )
            continue;

        if ( var_6.size > 1 )
            continue;

        if ( var_6[0] > var_4 )
            var_4 = var_6[0];
    }

    return getanimlength( var_0.rigmodel_anims[var_1] ) * var_4;
}

_ID5249( var_0, var_1, var_2 )
{
    var_3 = var_0.rigmodel_anims[var_1];
    var_4 = 1;

    for ( var_5 = 1; var_5 <= var_2; var_5++ )
    {
        var_6 = getnotetracktimes( var_3, "land_" + var_5 );

        if ( var_6.size <= 0 )
            continue;

        if ( var_6.size > 1 )
            continue;

        if ( var_6[0] < var_4 )
            var_4 = var_6[0];
    }

    return getanimlength( var_0.rigmodel_anims[var_1] ) * ( 1 - var_4 );
}

birds_perchdangertrigger( var_0, var_1, var_2 )
{
    self.trigger = spawn( "trigger_radius", self.origin - ( 0, 0, var_0 ), 23, var_0, 2 * var_0 );
    thread maps\interactive_models\_interactive_utility::delete_on_notify( self.trigger, "death", var_2 );
    thread _ID5258( self.trigger, var_1, var_2 );
    thread _ID5256( var_0, var_1, var_2 );

    foreach ( var_4 in self.triggers )
        thread _ID5258( var_4, var_1, var_2 );
}

_ID5258( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( var_2 );

    for (;;)
    {
        var_0.anythingtouchingtrigger = 0;
        var_0 waittill( "trigger" );
        self notify( var_1 );
        var_0.anythingtouchingtrigger = 1;
        wait 1;
    }
}

_ID5256( var_0, var_1, var_2 )
{
    self.lastaieventtrigger = gettime() - 500;

    if ( common_scripts\utility::_ID18787() )
    {
        self endon( "death" );
        self endon( var_2 );
        self.sentient = spawn( "script_origin", self.origin );
        self.sentient call [[ level._ID20500 ]]( "neutral" );
        thread maps\interactive_models\_interactive_utility::_ID35508( var_2, "death", ::_ID5246 );
        self.sentient call [[ level.addaieventlistener_func ]]( "projectile_impact" );
        self.sentient call [[ level.addaieventlistener_func ]]( "bulletwhizby" );
        self.sentient call [[ level.addaieventlistener_func ]]( "explode" );

        for (;;)
        {
            self.sentient waittill( "ai_event",  var_3, var_4, var_5  );

            if ( var_3 != "explode" && var_3 != "gunshot" || distancesquared( self.origin, var_5 ) < 2 * var_0 )
            {
                self notify( var_1 );
                self.lastaieventtrigger = gettime();
            }
        }
    }
}

_ID5246()
{
    self.sentient delete();
}

birds_isperchsafe( var_0 )
{
    var_1 = 1;
    var_2 = !var_0.trigger.anythingtouchingtrigger;

    if ( var_2 )
    {
        foreach ( var_4 in var_0.triggers )
        {
            if ( var_4.anythingtouchingtrigger )
            {
                var_2 = 0;
                continue;
            }
        }

        if ( var_0.lastaieventtrigger > gettime() )
            var_0.lastaieventtrigger = gettime() - 500;

        if ( gettime() - var_0.lastaieventtrigger < 500 )
            var_1 = 0;
    }

    return var_2 && var_1;
}

birds_path_move_first_point( var_0, var_1, var_2 )
{
    var_3 = common_scripts\_csplines::_ID8574( var_0, var_1, var_2 );
    var_3._ID31467 = var_1;

    if ( isdefined( var_0._ID31426 ) )
        var_3._ID31426 = var_0._ID31426;

    if ( isdefined( var_0._ID11747 ) )
        var_3._ID11747 = var_0._ID11747;

    if ( isdefined( var_0._ID11596 ) )
        var_3._ID11596 = var_0._ID11596;

    if ( isdefined( var_0._ID11748 ) )
        var_3._ID11748 = var_0._ID11748;

    if ( isdefined( var_0._ID32394 ) )
        var_3._ID32394 = var_0._ID32394;

    if ( isdefined( var_0._ID19326 ) )
        var_3._ID19326 = var_0._ID19326;

    return var_3;
}

_ID5264( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( level._interactive["scriptSpawnedCount"] ) )
        level._interactive["scriptSpawnedCount"] = 0;

    level._interactive["scriptSpawnedCount"]++;
    var_4 = spawn( "script_model", var_1 );
    var_4.angles = vectortoangles( var_2 );
    var_4.targetname = "scriptSpawned_" + level._interactive["scriptSpawnedCount"];
    var_4.script_noteworthy = "bird_perch";
    var_5 = [];
    var_5[0] = var_4;
    var_5[1] = spawnstruct();
    var_5[1].origin = var_1 + var_2;
    var_5[1].angles = var_4.angles;
    var_4 = birds_setupconnectedperches( var_4, var_5 );
    var_6 = spawnstruct();
    var_6._ID18081 = var_0;
    var_6.target = var_4.targetname;
    var_6.origin = var_1;
    var_6.interactive_number = var_3;
    var_6 birds_loadfromstruct();
    var_4 notify( "triggered" );
    common_scripts\utility::_ID35582();
    level._interactive["bird_perches"][var_4.targetname] = undefined;
}

_ID5265()
{
    self endon( "death" );
    level waittill( "stop_" + self._ID27870 );
    thread birds_savetostructandwaitfortriggerstart();
}

birds_savetostructandwaitfortriggerstart()
{
    var_0 = birds_savetostruct();
    level waittill( "start_" + self._ID27870 );
    var_0 birds_loadfromstruct();
}

birds_savetostruct()
{
    var_0 = spawnstruct();
    var_0._ID18081 = self._ID18081;
    var_0.target = self.target;
    var_0.origin = self.origin;
    var_0.targetname = self.targetname;

    if ( isdefined( self.interactive_number ) )
        var_0.interactive_number = self.interactive_number;

    var_0._ID27870 = self._ID27870;
    _ID5245();
    return var_0;
}

birds_loadfromstruct()
{
    var_0 = spawn( "script_model", self.origin );
    var_0._ID18081 = self._ID18081;
    var_0.target = self.target;
    var_0.origin = self.origin;

    if ( isdefined( self.interactive_number ) )
        var_0.interactive_number = self.interactive_number;

    var_0._ID27870 = self._ID27870;
    var_0.targetname = "interactive_birds";

    if ( !isdefined( level._interactive["bird_perches"][self.target] ) )
        var_0 birds_setupconnectedperches();

    var_0 birds_createents();
    var_0 thread birds_fly( var_0.target );
}

_ID5245()
{
    if ( isdefined( self.birds ) )
    {
        for ( var_0 = 1; var_0 <= self.birds.size; var_0++ )
        {
            if ( self.birdexists[var_0] )
                self.birds[var_0] delete();
        }
    }

    if ( isdefined( self._ID23419 ) )
        self._ID23419 notify( "leaving perch" );

    self delete();
}

anglesoftclamp( var_0, var_1, var_2, var_3 )
{
    var_0 = angleclamp180( var_0 );
    var_4 = abs( var_0 );

    if ( var_4 <= var_1 )
        return var_0;
    else
    {
        var_5 = var_0 / var_4;
        var_4 = ( var_4 - var_1 ) * var_2 + var_1;
        var_4 = clamp( var_4, 0, var_3 );
        return var_4 * var_5;
    }
}

anglessoftclamp( var_0, var_1, var_2, var_3 )
{
    return ( anglesoftclamp( var_0[0], var_1, var_2, var_3 ), anglesoftclamp( var_0[1], var_1, var_2, var_3 ), anglesoftclamp( var_0[2], var_1, var_2, var_3 ) );
}
