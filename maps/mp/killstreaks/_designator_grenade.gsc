// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

designator_start( var_0, var_1, var_2 )
{
    self endon( "death" );
    self._ID20647 = undefined;

    if ( self getcurrentweapon() == var_1 )
    {
        thread designator_disableusabilityduringgrenadepullback( var_1 );
        thread designator_waitforgrenadefire( var_0, var_1, var_2 );
        _ID9747( var_1 );
        return !( self getammocount( var_1 ) && self hasweapon( var_1 ) );
    }

    return 0;
}

designator_disableusabilityduringgrenadepullback( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_1 = "";

    while ( var_1 != var_0 )
        self waittill( "grenade_pullback",  var_1  );

    common_scripts\utility::_disableusability();
    designator_enableusabilitywhendesignatorfinishes();
}

designator_enableusabilitywhendesignatorfinishes()
{
    self endon( "death" );
    self endon( "disconnect" );
    common_scripts\utility::_ID35626( "grenade_fire", "weapon_change" );
    common_scripts\utility::_enableusability();
}

designator_waitforgrenadefire( var_0, var_1, var_2 )
{
    self endon( "designator_finished" );
    self endon( "spawned_player" );
    self endon( "disconnect" );
    var_3 = undefined;
    var_4 = "";

    while ( var_4 != var_1 )
        self waittill( "grenade_fire",  var_3, var_4  );

    if ( isalive( self ) )
    {
        var_3.owner = self;
        var_3._ID36273 = var_1;
        self._ID20647 = var_3;
        thread designator_ontargetacquired( var_0, var_3, var_2 );
    }
    else
        var_3 delete();

    self notify( "designator_finished" );
}

_ID9747( var_0 )
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    var_1 = self getcurrentweapon();

    while ( var_1 == var_0 )
        self waittill( "weapon_change",  var_1  );

    if ( self getammocount( var_0 ) == 0 )
        _ID9744( var_0 );

    self notify( "designator_finished" );
}

_ID9744( var_0 )
{
    if ( self hasweapon( var_0 ) )
        self takeweapon( var_0 );
}

designator_ontargetacquired( var_0, var_1, var_2 )
{
    var_1 waittill( "missile_stuck",  var_3  );

    if ( isdefined( var_1.owner ) )
        self thread [[ var_2 ]]( var_0, var_1 );

    if ( isdefined( var_1 ) )
        var_1 delete();
}
