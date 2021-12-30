// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    init_lights();
}

init_lights()
{
    common_scripts\utility::_ID3867( getentarray( "mp_dart_discoball_light", "targetname" ), ::_ID21732 );
    common_scripts\utility::_ID3867( getentarray( "mp_dart_discoball_light_reverse", "targetname" ), ::_ID21733 );
    var_0 = getentarray( "mp_dart_pulsing_light", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::_ID21741 );
    var_1 = getentarray( "mp_dart_tv_flicker", "targetname" );
    common_scripts\utility::_ID3867( var_1, ::mp_dart_tv_flicker );
}

_ID21732()
{
    var_0 = 3;
    var_1 = 150000;
    self rotatevelocity( ( 0, var_0, 0 ), var_1 );
}

_ID21733()
{
    var_0 = -3;
    var_1 = 150000;
    self rotatevelocity( ( 0, var_0, 0 ), var_1 );
}

mp_dart_restarteffect()
{
    common_scripts\_createfx::_ID26177();
}

ent_flag( var_0 )
{
    return self.ent_flag[var_0];
}

_ID21734( var_0 )
{
    if ( self.ent_flag[var_0] )
    {
        self.ent_flag[var_0] = 0;
        self notify( var_0 );
        return;
    }
}

_ID21736( var_0 )
{
    self.ent_flag[var_0] = 1;
    self notify( var_0 );
}

_ID21735( var_0 )
{
    if ( !isdefined( self.ent_flag ) )
    {
        self.ent_flag = [];
        self.ent_flags_lock = [];
    }

    self.ent_flag[var_0] = 0;
}

mp_dart_is_light_entity( var_0 )
{
    return var_0.classname == "light_spot" || var_0.classname == "light_omni" || var_0.classname == "light";
}

_ID21741()
{
    self endon( "stop_dynamic_light_behavior" );
    self._ID20024 = 0;
    self.lit_models = undefined;
    self._ID34224 = undefined;
    self._ID20023 = 0;
    self._ID20022 = [];
    self.linked_prefab_ents = undefined;
    self._ID20026 = [];

    if ( isdefined( self.script_linkto ) )
    {
        self.linked_prefab_ents = common_scripts\utility::get_linked_ents();

        foreach ( var_1 in self.linked_prefab_ents )
        {
            if ( isdefined( var_1.script_noteworthy ) && var_1.script_noteworthy == "on" )
            {
                if ( !isdefined( self.lit_models ) )
                    self.lit_models[0] = var_1;
                else
                    self.lit_models[self.lit_models.size] = var_1;

                continue;
            }

            if ( isdefined( var_1.script_noteworthy ) && var_1.script_noteworthy == "off" )
            {
                if ( !isdefined( self._ID34224 ) )
                    self._ID34224[0] = var_1;
                else
                    self._ID34224[self._ID34224.size] = var_1;

                self._ID34223 = var_1;
                continue;
            }

            if ( mp_dart_is_light_entity( var_1 ) )
            {
                self._ID20023 = 1;
                self._ID20022[self._ID20022.size] = var_1;
            }
        }

        self._ID20024 = 1;
    }

    thread _ID21738();
    thread _ID21737();
}

_ID21738()
{
    _ID21735( "flicker_on" );

    if ( isdefined( self._ID27663 ) && self._ID27663 != "nil" )
    {
        for (;;)
        {
            level waittill( self._ID27663 );
            _ID21736( "flicker_on" );

            if ( isdefined( self._ID27664 ) && self._ID27664 != "nil" )
            {
                level waittill( self._ID27664 );
                _ID21734( "flicker_on" );
            }
        }

        return;
    }

    _ID21736( "flicker_on" );
    return;
}

_ID21739()
{
    var_0 = self getlightintensity();

    if ( !ent_flag( "flicker_on" ) )
    {
        if ( self._ID20024 )
        {
            if ( isdefined( self.lit_models ) )
            {
                foreach ( var_2 in self.lit_models )
                {
                    if ( isdefined( var_2._ID11242 ) )
                    {
                        var_2._ID11242 delete();
                        var_2._ID11242 = undefined;
                    }

                    var_2 hide();
                }
            }

            if ( isdefined( self._ID34224 ) )
            {
                foreach ( var_5 in self._ID34224 )
                    var_5 show();
            }
        }

        self setlightintensity( 0 );

        if ( self._ID20023 )
        {
            for ( var_7 = 0; var_7 < self._ID20022.size; var_7++ )
                self._ID20022[var_7] setlightintensity( 0 );
        }

        self waittill( "flicker_on" );
        self setlightintensity( var_0 );

        if ( self._ID20023 )
        {
            for ( var_7 = 0; var_7 < self._ID20022.size; var_7++ )
                self._ID20022[var_7] setlightintensity( var_0 );
        }

        if ( self._ID20024 )
        {
            if ( isdefined( self.lit_models ) )
            {
                foreach ( var_2 in self.lit_models )
                {
                    var_2 show();

                    if ( !isdefined( var_2._ID11242 ) )
                    {
                        var_2._ID11242 = spawnfx( level._ID1644["vfx_bulb_single"], var_2.origin );
                        triggerfx( var_2._ID11242 );
                        common_scripts\utility::_ID35582();
                    }
                }
            }

            if ( isdefined( self._ID34224 ) )
            {
                foreach ( var_5 in self._ID34224 )
                    var_5 hide();

                return;
            }

            return;
        }

        return;
    }
}

_ID21737()
{
    self endon( "stop_dynamic_light_behavior" );
    self endon( "death" );
    var_0 = 0.2;
    var_1 = 1.0;
    var_2 = self getlightintensity();
    var_3 = 0;
    var_4 = var_2;
    var_5 = 0;

    while ( isdefined( self ) )
    {
        _ID21739();

        for ( var_5 = randomintrange( 1, 10 ); var_5; var_5-- )
        {
            _ID21739();
            wait(randomfloatrange( 0.05, 0.1 ));

            if ( var_4 > 0.2 )
            {
                var_4 = randomfloatrange( 0, 0.3 );

                if ( self._ID20024 )
                {
                    foreach ( var_7 in self.lit_models )
                    {
                        if ( isdefined( var_7._ID11242 ) )
                        {
                            var_7._ID11242 delete();
                            var_7._ID11242 = undefined;
                            common_scripts\utility::_ID35582();
                        }

                        var_7 hide();
                    }
                }

                if ( isdefined( self._ID34224 ) )
                {
                    foreach ( var_10 in self._ID34224 )
                        var_10 show();
                }
            }
            else
            {
                var_4 = var_2;

                if ( self._ID20024 )
                {
                    if ( isdefined( self.lit_models ) )
                    {
                        foreach ( var_7 in self.lit_models )
                        {
                            var_7 show();

                            if ( !isdefined( var_7._ID11242 ) )
                            {
                                var_7._ID11242 = spawnfx( level._ID1644["vfx_bulb_single"], var_7.origin );
                                triggerfx( var_7._ID11242 );
                                common_scripts\utility::_ID35582();
                            }
                        }
                    }

                    if ( isdefined( self._ID34224 ) )
                    {
                        foreach ( var_10 in self._ID34224 )
                            var_10 hide();
                    }
                }
            }

            self setlightintensity( var_4 );

            if ( self._ID20023 )
            {
                for ( var_16 = 0; var_16 < self._ID20022.size; var_16++ )
                    self._ID20022[var_16] setlightintensity( var_4 );
            }
        }

        _ID21739();
        self setlightintensity( var_2 );

        if ( self._ID20023 )
        {
            for ( var_16 = 0; var_16 < self._ID20022.size; var_16++ )
                self._ID20022[var_16] setlightintensity( var_2 );
        }

        if ( self._ID20024 )
        {
            if ( isdefined( self.lit_models ) )
            {
                foreach ( var_7 in self.lit_models )
                {
                    var_7 show();

                    if ( !isdefined( var_7._ID11242 ) )
                    {
                        var_7._ID11242 = spawnfx( level._ID1644["vfx_bulb_single"], var_7.origin );
                        triggerfx( var_7._ID11242 );
                        common_scripts\utility::_ID35582();
                    }
                }
            }

            if ( isdefined( self._ID34224 ) )
            {
                foreach ( var_10 in self._ID34224 )
                    var_10 hide();
            }
        }

        wait(randomfloatrange( var_0, var_1 ));
    }
}

mp_dart_tv_flicker()
{
    var_0 = self getlightintensity();
    var_1 = var_0;

    for (;;)
    {
        var_2 = randomfloatrange( var_0 * 0.3, var_0 * 0.9 );
        var_3 = randomfloatrange( 0.05, 0.1 );
        var_3 *= 15;

        for ( var_4 = 0; var_4 < var_3; var_4++ )
        {
            var_5 = var_2 * var_4 / var_3 + var_1 * ( var_3 - var_4 ) / var_3;
            self setlightintensity( var_5 );
            wait 0.05;
        }

        var_1 = var_2;
    }
}
