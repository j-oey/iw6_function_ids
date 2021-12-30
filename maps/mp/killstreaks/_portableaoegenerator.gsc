// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    if ( !isdefined( level._ID24741 ) )
    {
        level._ID24741 = [];
        level._ID14211 = [];
    }
}

_ID29205( var_0 )
{
    var_1 = level._ID24741[var_0];
    self setoffhandsecondaryclass( "flash" );
    maps\mp\_utility::_giveweapon( var_1._ID36273, 0 );
    self givestartammo( var_1._ID36273 );

    if ( !isdefined( self._ID9663 ) )
        self._ID9663 = [];

    thread _ID21393( var_0 );
}

_ID34380( var_0 )
{
    self notify( "end_monitorUse_" + var_0 );
}

_ID9610( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    foreach ( var_3 in level.players )
    {
        if ( isdefined( var_3 ) && isdefined( var_3._ID17627 ) )
            var_3._ID17627[var_1] = undefined;
    }

    _ID25705( var_0, var_1, undefined );
    var_0 notify( "death" );
    var_0 delete();
}

_ID25705( var_0, var_1, var_2 )
{
    if ( isdefined( var_2 ) && var_2 )
        self._ID9663[var_1] = var_0;
    else
    {
        self._ID9663[var_1] = undefined;
        var_2 = undefined;
    }

    var_3 = level._ID14211[var_1];

    if ( !isdefined( var_3 ) )
    {
        level._ID14211[var_1] = [];
        var_3 = level._ID14211[var_1];
    }

    var_4 = _ID15057( var_0 );
    var_3[var_4] = var_2;
}

_ID21393( var_0 )
{
    self notify( "end_monitorUse_" + var_0 );
    self endon( "end_monitorUse_" + var_0 );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_1 = level._ID24741[var_0];

    for (;;)
    {
        self waittill( "grenade_fire",  var_2, var_3  );

        if ( var_3 == var_1._ID36273 || var_3 == var_0 )
        {
            if ( !isalive( self ) )
            {
                var_2 delete();
                return;
            }

            if ( checkgeneratorplacement( var_2, var_1._ID23670 ) )
            {
                var_4 = self._ID9663[var_0];

                if ( isdefined( var_4 ) )
                    _ID9610( var_4, var_0 );

                var_5 = _ID30897( var_0, var_2.origin );
                var_6 = var_2 getlinkedparent();

                if ( isdefined( var_6 ) )
                    var_5 linkto( var_6 );

                if ( isdefined( var_2 ) )
                    var_2 delete();

                continue;
            }

            self setweaponammostock( var_1._ID36273, self getweaponammostock( "trophy_mp" ) + 1 );
        }
    }
}

checkgeneratorplacement( var_0, var_1 )
{
    var_0 hide();
    var_0 waittill( "missile_stuck",  var_2  );

    if ( var_1 * var_1 < distancesquared( var_0.origin, self.origin ) )
    {
        var_3 = bullettrace( self.origin, self.origin - ( 0, 0, var_1 ), 0, self );

        if ( var_3["fraction"] == 1 )
        {
            var_0 delete();
            return 0;
        }

        var_0.origin = var_3["position"];
    }

    var_0 show();
    return 1;
}

_ID30897( var_0, var_1 )
{
    var_2 = level._ID24741[var_0];
    var_3 = spawn( "script_model", var_1 );
    var_3.health = var_2.health;
    var_3.team = self.team;
    var_3.owner = self;
    var_3 setcandamage( 1 );
    var_3 setmodel( var_2.placedmodel );

    if ( level._ID32653 )
        var_3 maps\mp\_entityheadicons::_ID28896( self.team, ( 0, 0, var_2._ID16453 ) );
    else
        var_3 maps\mp\_entityheadicons::_ID28825( self, ( 0, 0, var_2._ID16453 ) );

    var_3 thread _ID36104( self, var_0 );
    var_3 thread _ID36053( self, var_0 );
    var_3 thread _ID36143( self, var_0 );
    var_3 thread maps\mp\_utility::_ID22330( self );

    if ( isdefined( var_2._ID22803 ) )
        var_3 [[ var_2._ID22803 ]]( self, var_0 );

    var_3 thread maps\mp\gametypes\_weapons::createbombsquadmodel( var_2.bombsquadmodel, "tag_origin", self );
    _ID25705( var_3, var_0, 1 );
    self.changingweapon = undefined;
    wait 0.05;

    if ( isdefined( var_3 ) && var_3 maps\mp\_utility::_ID33165() )
        var_3 notify( "death" );

    return var_3;
}

_ID36104( var_0, var_1 )
{
    self endon( "death" );
    level endon( "game_ended" );

    if ( maps\mp\_utility::bot_is_fireteam_mode() )
        var_0 waittill( "killstreak_disowned" );
    else
        var_0 common_scripts\utility::_ID35663( "killstreak_disowned", "death" );

    var_0 thread _ID9610( self, var_1 );
}

_ID36053( var_0, var_1 )
{
    self.generatortype = var_1;
    var_2 = level._ID24741[var_1];
    maps\mp\gametypes\_damage::_ID21371( var_2.health, var_2.damagefeedback, ::handledeathdamage, ::modifydamage, 0 );
}

modifydamage( var_0, var_1, var_2, var_3 )
{
    var_4 = var_3;
    var_4 = maps\mp\gametypes\_damage::handlemeleedamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleempdamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::_ID16266( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handlegrenadedamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleapdamage( var_1, var_2, var_4, var_0 );
    return var_4;
}

handledeathdamage( var_0, var_1, var_2 )
{
    var_3 = self.owner;
    var_4 = level._ID24741[self.generatortype];

    if ( isdefined( var_3 ) && var_0 != var_3 )
        var_0 notify( "destroyed_equipment" );

    if ( isdefined( var_4.ondestroycallback ) )
        var_3 [[ var_4.ondestroycallback ]]( self, self.generatortype );

    var_3 thread _ID9610( self, self.generatortype );
}

_ID36143( var_0, var_1 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_2 = level._ID24741[var_1];
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( var_2.usehintstring );
    maps\mp\_utility::_ID28863( var_0 );

    for (;;)
    {
        self waittill( "trigger",  var_3  );
        var_3 playlocalsound( var_2._ID34770 );

        if ( var_3 getammocount( var_2._ID36273 ) == 0 && !var_3 maps\mp\_utility::_ID18666() )
            var_3 _ID29205( var_1 );

        var_3 thread _ID9610( self, var_1 );
    }
}

_ID14210()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    level endon( "game_ended" );
    var_0 = randomfloat( 0.5 );
    wait(var_0);
    self._ID17627 = [];

    for (;;)
    {
        wait 0.05;

        if ( level._ID14211.size > 0 || self._ID17627.size > 0 )
        {
            foreach ( var_2 in level._ID24741 )
                checkallgeneratorsofthistype( var_2.generatortype );
        }
    }
}

checkallgeneratorsofthistype( var_0 )
{
    var_1 = level._ID14211[var_0];

    if ( isdefined( var_1 ) )
    {
        var_2 = level._ID24741[var_0];
        var_3 = var_2.aoeradius * var_2.aoeradius;
        var_4 = undefined;

        foreach ( var_6 in var_1 )
        {
            if ( isdefined( var_6 ) && maps\mp\_utility::_ID18757( var_6 ) )
            {
                if ( level._ID32653 && matchestargetteam( var_6.team, self.team, var_2._ID32626 ) || !level._ID32653 && _ID20666( var_6.owner, self, var_2._ID32626 ) )
                {
                    var_7 = distancesquared( var_6.origin, self.origin );

                    if ( var_7 < var_3 )
                    {
                        var_4 = var_6;
                        break;
                    }
                }
            }
        }

        var_9 = isdefined( var_4 );
        var_10 = isdefined( self._ID17627[var_0] );

        if ( var_9 && !var_10 )
            self [[ var_2.onentercallback ]]();
        else if ( !var_9 && var_10 )
            self [[ var_2._ID22832 ]]();

        self._ID17627[var_0] = var_4;
    }
}

matchestargetteam( var_0, var_1, var_2 )
{
    return var_2 == "all" || var_2 == "friendly" && var_0 == var_1 || var_2 == "enemy" && var_0 != var_1;
}

_ID20666( var_0, var_1, var_2 )
{
    return var_2 == "all" || var_2 == "friendly" && var_0 == var_1 || var_2 == "enemy" && var_0 != var_1;
}

_ID15057( var_0 )
{
    return var_0.owner._ID15851 + var_0.birthtime;
}
