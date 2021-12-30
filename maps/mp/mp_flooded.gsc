// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_flooded_precache::_ID20445();
    maps\createart\mp_flooded_art::_ID20445();
    maps\mp\mp_flooded_fx::_ID20445();
    maps\mp\_water::_ID36208();
    maps\mp\_load::_ID20445();
    maps\mp\_compass::_ID29184( "compass_map_mp_flooded" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );

    if ( !maps\mp\_utility::_ID18422() )
        setdvar( "r_texFilterProbeBilinear", 1 );

    if ( level._ID25139 )
    {
        setdvar( "sm_sunShadowScale", "0.55" );
        setdvar( "sm_sunsamplesizenear", ".15" );
    }
    else if ( level._ID36452 )
    {
        setdvar( "sm_sunShadowScale", "0.85" );
        setdvar( "sm_sunsamplesizenear", ".22" );
    }
    else
    {
        setdvar( "sm_sunShadowScale", "0.9" );
        setdvar( "sm_sunsamplesizenear", ".27" );
    }

    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    setdvar( "r_reactiveMotionWindAmplitudeScale", 1 );
    setdvar( "r_reactiveMotionWindAreaScale", 10 );
    setdvar( "r_reactiveMotionWindDir", ( 0.3, -1, -0.5 ) );
    setdvar( "r_reactiveMotionWindFrequencyScale", 0.25 );
    setdvar( "r_reactiveMotionWindStrength", 1 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    maps\mp\_water::_ID36209( 205, 212 );
    var_0 = getentarray( "vehicle_movers", "targetname" );

    foreach ( var_2 in var_0 )
        _ID30054( var_2, 12, 12 );

    level thread _ID37490();
}

_ID37490()
{
    var_0 = getent( "clip128x128x8", "targetname" );
    var_1 = spawn( "script_model", ( 1392, -584, 386 ) );
    var_1.angles = ( 336, 0, 90 );
    var_1 clonebrushmodeltoscriptmodel( var_0 );
}

_ID30054( var_0, var_1, var_2 )
{
    var_3 = getent( var_0.target, "targetname" );

    if ( !isdefined( var_3 ) )
        return;

    var_4 = var_3.target;
    var_5 = getent( var_4, "targetname" );

    if ( !isdefined( var_5 ) )
        return;

    var_5._ID7525 = var_3;
    var_5.trigger = var_0;
    var_5._ID7525._ID34249 = ::handleunreslovedcollision;
    var_3 linkto( var_5 );
    var_6 = getent( var_5.script_noteworthy, "targetname" );
    var_5.pathblock = var_6;
    var_5 thread sinkingplatformenablepathsonstart();
    var_7 = common_scripts\utility::_ID15384( var_5.target, "targetname" );

    if ( !isdefined( var_7 ) )
        return;

    var_5._ID31469 = var_5.origin;
    var_5._ID31473 = var_5.angles;
    var_5.endpos = var_7.origin;
    var_5._ID11755 = var_7.angles;
    var_8 = distance( var_5.endpos, var_5._ID31469 );

    if ( isdefined( var_7._ID27550 ) )
        var_1 = var_7._ID27550;

    if ( isdefined( var_0._ID27550 ) )
        var_2 = var_0._ID27550;

    var_5._ID30061 = var_1 / var_8;
    var_5._ID26338 = var_2 / var_8;
    var_5._ID12168 = [];
    var_5 thread _ID30057();
    return var_5;
}

_ID30057()
{
    level endon( "game_ended" );

    for (;;)
    {
        self.trigger waittill( "trigger",  var_0  );

        if ( canenttriggerplatform( var_0 ) && maps\mp\_utility::_ID18757( var_0 ) )
        {
            self._ID12168[var_0 getentitynumber()] = var_0;
            var_1 = self._ID12168.size;

            if ( var_1 == 1 )
                sinkingplatform_start();
            else if ( !isdefined( self._ID25513 ) )
                _ID34609( var_1 );
        }
    }
}

sinkingplatform_start()
{
    self notify( "platform_sink" );
    var_0 = distance( self.endpos, self.origin ) * self._ID30061;
    var_1 = min( 0.5 * var_0, 0.5 );
    self moveto( self.endpos, var_0, var_1, var_1 );
    self rotateto( self._ID11755, var_0, var_1, var_1 );
    thread _ID30060( "scn_car_sinking_down_start", "scn_car_sinking_down_loop", "scn_car_sinking_down_end", 1, 0.25, var_0 );
    thread _ID30058();
    thread _ID30059();
}

_ID30058()
{
    level endon( "game_ended" );

    while ( self._ID12168.size > 0 )
    {
        wait 0.1;
        var_0 = self._ID12168.size;

        foreach ( var_3, var_2 in self._ID12168 )
        {
            if ( !isdefined( var_2 ) || !var_2 istouching( self.trigger ) || !maps\mp\_utility::_ID18757( var_2 ) )
                self._ID12168[var_3] = undefined;
        }

        if ( !isdefined( self._ID25513 ) )
        {
            var_4 = self._ID12168.size;

            if ( var_4 > 0 && var_4 != var_0 )
                _ID34609( var_4 );
        }
    }

    _ID30055();
}

_ID30059()
{
    level endon( "game_ended" );
    self endon( "platform_return" );
    self waittill( "movedone" );
    self._ID25513 = 1;
}

sinkingplatform_waitforreachedtop()
{
    level endon( "game_ended" );
    self endon( "platform_sink" );
    self waittill( "movedone" );
}

_ID30055()
{
    self notify( "platform_return" );
    self._ID25513 = undefined;
    var_0 = distance( self._ID31469, self.origin ) * self._ID26338;
    var_1 = min( 0.5 * var_0, 0.5 );
    self moveto( self._ID31469, var_0, var_1, var_1 );
    self rotateto( self._ID31473, var_0, var_1, var_1 );
    thread _ID30060( "scn_car_floating_up_start", "scn_car_floating_up_loop", "scn_car_floating_up_end", 0.5, 0.25, var_0 );
    thread sinkingplatform_waitforreachedtop();
}

canenttriggerplatform( var_0 )
{
    return ( isplayer( var_0 ) || isagent( var_0 ) && isdefined( var_0.agent_type ) && var_0.agent_type != "dog" ) && !isdefined( self._ID12168[var_0 getentitynumber()] );
}

_ID34609( var_0 )
{
    var_1 = distance( self.endpos, self.origin ) * self._ID30061;
    var_1 /= var_0;

    if ( var_1 > 0 )
    {
        var_2 = min( 0.5 * var_1, 0.5 );
        self._ID7525 moveto( self.endpos, var_1, var_2, var_2 );
        self._ID7525 rotateto( self._ID11755, var_1, var_2, var_2 );
    }
    else
    {

    }
}

_ID30060( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self notify( "stopSinkingSfx" );
    self stopsounds();
    self stoploopsound();
    self endon( "stopSinkingSfx" );
    self playsound( var_0 );
    wait(var_3);
    var_6 = var_5 - var_3 - var_4;

    if ( var_6 > 0 )
    {
        self playloopsound( var_1 );
        wait(var_6);
        self stoploopsound();
    }

    self playsound( var_2 );
}

sinkingplatformenablepathsonstart()
{
    wait 0.1;
    sinkingplatformenablepaths();
}

sinkingplatformenablepaths()
{
    if ( isdefined( self.pathblock ) )
    {
        self.pathblock connectpaths();
        self.pathblock hide();
    }
}

sinkingplatformdisablepaths()
{
    if ( isdefined( self.pathblock ) )
    {
        self.pathblock show();
        self.pathblock disconnectpaths();
    }
}

movercreate( var_0 )
{
    var_1 = getent( var_0, "targetname" );

    if ( !isdefined( var_1 ) )
        return;

    var_2 = getent( var_1.target, "targetname" );

    if ( !isdefined( var_2 ) )
        return;

    var_3 = getent( var_2.target, "targetname" );

    if ( !isdefined( var_3 ) )
        return;

    var_3.trigger = var_1;
    var_3._ID7525 = var_2;
    var_2 linkto( var_3 );
    var_3._ID19112 = [];
    var_4 = var_3.target;
    var_5 = 0;

    while ( isdefined( var_4 ) )
    {
        var_6 = common_scripts\utility::_ID15384( var_4, "targetname" );

        if ( isdefined( var_6 ) )
        {
            if ( !isdefined( var_6._ID27550 ) )
                var_6._ID27550 = 6;

            if ( !isdefined( var_6._ID27417 ) )
                var_6._ID27417 = 0.5 * var_6._ID27550;

            if ( !isdefined( var_6._ID27516 ) )
                var_6._ID27516 = 0.25 * var_6._ID27550;

            var_6._ID7536 = var_6.angles - var_3.angles + var_2.angles;
            var_3._ID19112[var_5] = var_6;
            var_5++;
            var_4 = var_6.target;
            continue;
        }

        break;
    }

    var_3.trigger sethintstring( &"PLATFORM_HOLD_TO_USE" );
    var_3.trigger makeusable();
    var_3 thread moverwaitforuse();
    return var_3;
}

moverwaitforuse()
{
    level endon( "game_ended" );
    self.trigger waittill( "trigger" );
    self.trigger makeunusable();
    _ID21655();
}

_ID21655()
{
    level endon( "game_ended" );

    for ( var_0 = 0; var_0 < self._ID19112.size; var_0++ )
    {
        var_1 = self._ID19112[var_0];
        self moveto( var_1.origin, var_1._ID27550, var_1._ID27417, var_1._ID27516 );
        self rotateto( var_1.angles, var_1._ID27550, var_1._ID27417, var_1._ID27516 );
        self waittill( "movedone" );

        if ( isdefined( var_1.script_delay ) )
            wait(var_1.script_delay);
    }
}

handleunreslovedcollision( var_0 )
{

}
