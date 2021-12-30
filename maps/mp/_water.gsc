// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID36208()
{
    level._ID1644["water_kick"] = loadfx( "vfx/moments/flood/flood_db_foam_allie_ch_fast_cheap" );
    level._ID1644["water_splash_emerge"] = loadfx( "vfx/moments/flood/flood_db_foam_allie_vertical_splash_sml" );
    level._ID1644["water_splash_large"] = loadfx( "vfx/moments/flood/flood_db_foam_allie_vertical_splash_lrg" );
}

_ID36209( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
        level.waterdeletez = var_0;

    level.trigunderwater = getent( "trigger_underwater", "targetname" );
    level.trigabovewater = getent( "trigger_abovewater", "targetname" );
    level.trigunderwater thread _ID36111( level.trigabovewater, var_1 );
    level thread clearwatervarsonspawn( level.trigunderwater );

    if ( isdefined( var_0 ) )
    {
        level thread watchentsindeepwater( level.trigunderwater, var_0 );
        return;
    }
}

watchentsindeepwater( var_0, var_1 )
{
    level childthread watchentsindeepwater_mines( var_0, var_1 );
    level childthread watchentsindeepwater_ks( var_0, var_1 );
}

watchentsindeepwater_ks( var_0, var_1 )
{
    level endon( "game_ended" );

    for (;;)
    {
        wait 0.05;
        var_2 = level.placedims;
        var_2 = common_scripts\utility::array_combine( var_2, level._ID34657 );
        var_2 = common_scripts\utility::array_combine( var_2, level._ID34099 );

        foreach ( var_4 in var_2 )
        {
            if ( !isdefined( var_4 ) )
                continue;

            var_5 = common_scripts\utility::_ID32831( isdefined( var_4._ID28174 ) && var_4._ID28174 == "sentry_minigun", var_1 - 35, var_1 );

            if ( var_4.origin[2] <= var_5 && var_4 istouching( var_0 ) )
                var_4 notify( "death" );
        }

        wait 0.05;

        foreach ( var_8 in level.characters )
        {
            if ( isdefined( var_8 ) && isalive( var_8 ) && isai( var_8 ) && var_8.origin[2] <= var_1 - 35 && var_8 istouching( var_0 ) )
            {
                if ( isagent( var_8 ) && isdefined( var_8.agent_type ) && var_8.agent_type == "dog" )
                {
                    if ( !isdefined( var_8._ID30916 ) || gettime() - var_8._ID30916 > 2000 )
                        var_8 [[ var_8 maps\mp\agents\_agent_utility::agentfunc( "on_damaged" ) ]]( level, undefined, int( ceil( var_8.maxhealth * 0.08 ) ), 0, "MOD_CRUSH", "none", ( 0, 0, 0 ), ( 0, 0, 0 ), "none", 0 );

                    continue;
                }

                var_8 dodamage( int( ceil( var_8.maxhealth * 0.08 ) ), var_8.origin );
            }
        }
    }
}

watchentsindeepwater_mines( var_0, var_1 )
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "mine_planted" );
        waittillframeend;
        var_2 = level._ID21075;

        foreach ( var_6, var_4 in var_2 )
        {
            if ( !isdefined( var_4 ) )
                continue;

            var_5 = 0;

            if ( isdefined( var_4.istallforwaterchecks ) )
                var_5 = 28;

            if ( var_4.origin[2] <= var_1 - var_5 && var_4 istouching( var_0 ) )
                var_4 maps\mp\gametypes\_weapons::deleteexplosive();
        }
    }
}

clearwatervarsonspawn( var_0 )
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "player_spawned",  var_1  );

        if ( !var_1 istouching( var_0 ) )
        {
            var_1._ID18349 = undefined;
            var_1.underwater = undefined;
            var_1 notify( "out_of_water" );
        }
    }
}

_ID36111( var_0, var_1 )
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger",  var_2  );

        if ( !isplayer( var_2 ) && !isagent( var_2 ) )
            continue;

        if ( !isalive( var_2 ) || isagent( var_2 ) && isdefined( var_2.agent_type ) && var_2.agent_type == "dog" )
            continue;

        if ( !isdefined( var_2._ID18349 ) )
        {
            var_2._ID18349 = 1;
            var_2 thread _ID24507( self, var_0, var_1 );
        }
    }
}

playersplash()
{
    self endon( "out_of_water" );
    self endon( "death" );
    self endon( "disconnect" );
    var_0 = self getvelocity();

    if ( var_0[2] > -100 )
        return;

    wait 0.2;
    var_0 = self getvelocity();

    if ( var_0[2] <= -100 )
    {
        self playsound( "watersplash_lrg" );
        playfx( level._ID1644["water_splash_large"], self.origin + ( 0, 0, 36 ), ( 0, 0, 1 ), anglestoforward( ( 0, self.angles[1], 0 ) ) );
        return;
    }
}

_ID24507( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    thread _ID18350( var_2 );
    thread _ID24573();
    thread playersplash();

    for (;;)
    {
        if ( !self istouching( var_0 ) )
        {
            self._ID18349 = undefined;
            self.underwater = undefined;
            self notify( "out_of_water" );
            _ID31867();
            break;
        }

        if ( !isdefined( self.underwater ) && !self istouching( var_1 ) )
        {
            if ( self.classname == "script_vehicle" )
                self notify( "death" );
            else
            {
                self.underwater = 1;
                thread _ID24554();
            }
        }

        if ( isdefined( self.underwater ) && self istouching( var_1 ) )
        {
            self.underwater = undefined;
            self notify( "above_water" );
            _ID31867();

            if ( isplayer( self ) )
            {
                if ( self hasfemalecustomizationmodel() )
                    self playlocalsound( "Fem_breathing_better" );
                else
                    self playlocalsound( "breathing_better" );
            }

            playfx( level._ID1644["water_splash_emerge"], self.origin + ( 0, 0, 24 ) );
        }

        wait 0.05;
    }
}

_ID18529( var_0 )
{
    if ( isdefined( var_0._ID19258 ) )
    {
        var_1 = self.pers["killstreaks"][self._ID19258]._ID31889;

        if ( isdefined( var_1 ) )
        {
            switch ( var_1 )
            {
                case "remote_uav":
                case "remote_mg_turret":
                case "minigun_turret":
                case "ims":
                case "sentry":
                case "remote_tank":
                case "sam_turret":
                    return 1;
            }
        }
    }

    return 0;
}

_ID24573()
{
    common_scripts\utility::_ID35626( "death", "disconnect", "out_of_water" );

    if ( !isdefined( self ) )
        return;

    self._ID18349 = undefined;
    self.underwater = undefined;
}

_ID18350( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "out_of_water" );
    var_1 = common_scripts\utility::_ID32831( isdefined( var_0 ), var_0, self.origin[2] );
    var_2 = 0;

    for (;;)
    {
        if ( var_2 )
            wait 0.05;
        else
            wait 0.3;

        if ( !isdefined( level.waterkicktimenext ) )
            level.waterkicktimenext = gettime() + 200;
        else
        {
            var_3 = gettime();

            if ( gettime() < level.waterkicktimenext )
            {
                var_2 = 1;
                continue;
            }
            else
                level.waterkicktimenext = var_3 + 200;
        }

        var_2 = 0;
        var_4 = self getvelocity();

        if ( !isdefined( var_0 ) )
        {
            if ( abs( var_4[2] ) <= 1 )
                var_1 = self.origin[2];
        }

        if ( abs( var_4[2] ) > 30 )
        {
            playfx( level._ID1644["water_kick"], ( self.origin[0], self.origin[1], min( var_1, self.origin[2] ) ) );
            continue;
        }

        if ( length2dsquared( var_4 ) > 3600 )
        {
            var_5 = vectornormalize( ( var_4[0], var_4[1], 0 ) );
            playfx( level._ID1644["water_kick"], ( self.origin[0], self.origin[1], min( var_1, self.origin[2] ) ) + var_5 * 36, var_5, ( 0, 0, 1 ) );
        }
    }
}

_ID24554()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "above_water" );
    self endon( "out_of_water" );

    if ( !maps\mp\_utility::_ID18837() )
    {
        startwatervisuals();
        thread _ID31868();
    }

    playfx( level._ID1644["water_splash_emerge"], self geteye() - ( 0, 0, 24 ) );
    wait 2;
    thread _ID22883();

    for (;;)
    {
        self dodamage( 20, self.origin );
        wait 1;
    }
}

_ID22883()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "above_water" );
    self endon( "out_of_water" );
    self waittill( "death" );
    self._ID18349 = undefined;
    self.underwater = undefined;
}

_ID34202()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "using_remote" );
    self endon( "disconnect" );
    self endon( "above_water" );
    self endon( "out_of_water" );

    for (;;)
    {
        playfx( level._ID1644["water_bubbles"], self geteye() + anglestoup( self.angles ) * -13 + anglestoforward( self.angles ) * 25 );
        wait 0.75;
    }
}

startwatervisuals()
{
    self shellshock( "mp_flooded_water", 8 );

    if ( isplayer( self ) )
    {
        self setblurforplayer( 10, 0.0 );
        return;
    }
}

_ID31867()
{
    self stopshellshock();

    if ( isplayer( self ) )
    {
        self setblurforplayer( 0, 0.85 );
        return;
    }
}

_ID31868()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "above_water" );
    self endon( "out_of_water" );
    self waittill( "using_remote" );
    _ID31867();
}
