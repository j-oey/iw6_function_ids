// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID38250( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_4 ) )
        var_4 = 0;

    level endon( "game_ended" );
    var_5 = getent( var_0, "targetname" );

    if ( isdefined( var_5 ) )
    {
        var_5 childthread _ID38249( var_1, var_2, var_3 );
        var_5 childthread vfxbatcavewatchforempty( var_4 );

        for (;;)
        {
            var_5 waittill( "trigger",  var_6  );
            var_5 thread _ID38251( var_6 );
        }
    }
}

_ID38251( var_0 )
{
    self endon( "batCaveTrigger" );
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_0 notify( "batCaveExit" );
    var_0 endon( "batCaveExit" );
    childthread _ID38252( var_0 );

    while ( var_0 istouching( self ) )
    {
        common_scripts\utility::_ID35582();
        self.lasttouchedtime = gettime();
    }

    var_0 notify( "batCaveExit" );
}

_ID38252( var_0 )
{
    var_0 waittill( "weapon_fired" );
    self notify( "batCaveTrigger" );
}

vfxbatcavewatchforempty( var_0 )
{
    self.lasttouchedtime = gettime();
    self.batcavereset = 1;

    for (;;)
    {
        common_scripts\utility::_ID35582();

        if ( self.lasttouchedtime + var_0 <= gettime() )
            self.batcavereset = 1;
    }
}

_ID38249( var_0, var_1, var_2 )
{
    for (;;)
    {
        self waittill( "batCaveTrigger" );

        if ( self.batcavereset )
        {
            vfxbatsfly( var_0, var_1, var_2 );
            self.batcavereset = 0;
            var_3 = 60;
            wait(var_3);
        }
    }
}

vfxbatsfly( var_0, var_1, var_2 )
{
    common_scripts\utility::exploder( var_0 );

    if ( isdefined( var_1 ) && isdefined( var_2 ) )
    {
        var_3 = spawn( "script_model", var_2 );
        var_3 setmodel( "vulture_circle_rig" );
        var_3 scriptmodelplayanim( var_1 );
        var_4 = spawn( "script_model", var_3 gettagorigin( "tag_attach" ) );
        var_4 linkto( var_3, "tag_attach" );
        wait 0.1;
        var_4 playsoundonmovingent( "scn_mp_swamp_bat_cave_big" );
    }
}
