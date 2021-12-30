// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    if ( isdefined( level._ID17931 ) )
        return;

    level._ID17931 = 1;

    if ( level.multiteambased )
    {
        foreach ( var_1 in level._ID32668 )
        {
            var_2 = "entity_headicon_" + var_1;
            game[var_2] = maps\mp\gametypes\_teams::_ID21749( var_1 );
            precacheshader( game[var_2] );
        }
    }
    else
    {
        game["entity_headicon_allies"] = maps\mp\gametypes\_teams::_ID15416( "allies" );
        game["entity_headicon_axis"] = maps\mp\gametypes\_teams::_ID15416( "axis" );
        precacheshader( game["entity_headicon_allies"] );
        precacheshader( game["entity_headicon_axis"] );
    }
}

setheadicon( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    if ( maps\mp\_utility::_ID18638( var_0 ) && !isplayer( var_0 ) )
        return;

    if ( !isdefined( self._ID12149 ) )
        self._ID12149 = [];

    if ( !isdefined( var_5 ) )
        var_5 = 1;

    if ( !isdefined( var_6 ) )
        var_6 = 0.05;

    if ( !isdefined( var_7 ) )
        var_7 = 1;

    if ( !isdefined( var_8 ) )
        var_8 = 1;

    if ( !isdefined( var_9 ) )
        var_9 = 0;

    if ( !isdefined( var_10 ) )
        var_10 = 1;

    if ( !isplayer( var_0 ) && var_0 == "none" )
    {
        foreach ( var_13, var_12 in self._ID12149 )
        {
            if ( isdefined( var_12 ) )
                var_12 destroy();

            self._ID12149[var_13] = undefined;
        }
    }
    else
    {
        if ( isplayer( var_0 ) )
        {
            if ( isdefined( self._ID12149[var_0._ID15851] ) )
            {
                self._ID12149[var_0._ID15851] destroy();
                self._ID12149[var_0._ID15851] = undefined;
            }

            if ( var_1 == "" )
                return;

            if ( isdefined( var_0.team ) )
            {
                if ( isdefined( self._ID12149[var_0.team] ) )
                {
                    self._ID12149[var_0.team] destroy();
                    self._ID12149[var_0.team] = undefined;
                }
            }

            var_12 = newclienthudelem( var_0 );
            self._ID12149[var_0._ID15851] = var_12;
        }
        else
        {
            if ( isdefined( self._ID12149[var_0] ) )
            {
                self._ID12149[var_0] destroy();
                self._ID12149[var_0] = undefined;
            }

            if ( var_1 == "" )
                return;

            foreach ( var_13, var_15 in self._ID12149 )
            {
                if ( var_13 == "axis" || var_13 == "allies" )
                    continue;

                var_16 = maps\mp\_utility::_ID15254( var_13 );

                if ( var_16.team == var_0 )
                {
                    self._ID12149[var_13] destroy();
                    self._ID12149[var_13] = undefined;
                }
            }

            var_12 = newteamhudelem( var_0 );
            self._ID12149[var_0] = var_12;
        }

        if ( !isdefined( var_3 ) || !isdefined( var_4 ) )
        {
            var_3 = 10;
            var_4 = 10;
        }

        var_12.archived = var_5;
        var_12.x = self.origin[0] + var_2[0];
        var_12.y = self.origin[1] + var_2[1];
        var_12.z = self.origin[2] + var_2[2];
        var_12.alpha = 0.85;
        var_12 setshader( var_1, var_3, var_4 );
        var_12 setwaypoint( var_7, var_8, var_9, var_10 );
        var_12 thread _ID19105( self, var_2, var_6 );
        thread _ID9814();

        if ( isplayer( var_0 ) )
            var_12 thread _ID9815( var_0 );

        if ( isplayer( self ) )
            var_12 thread _ID9815( self );
    }
}

_ID9815( var_0 )
{
    self endon( "death" );
    var_0 waittill( "disconnect" );
    self destroy();
}

_ID9814()
{
    self notify( "destroyIconsOnDeath" );
    self endon( "destroyIconsOnDeath" );
    self waittill( "death" );

    if ( !isdefined( self._ID12149 ) )
        return;

    foreach ( var_2, var_1 in self._ID12149 )
    {
        if ( !isdefined( var_1 ) )
            continue;

        var_1 destroy();
    }
}

_ID19105( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_3 = isdefined( var_0.classname ) && !_ID18724( var_0 );

    if ( var_3 )
        self linkwaypointtotargetwithoffset( var_0, var_1 );

    for (;;)
    {
        if ( !isdefined( var_0 ) )
            return;

        if ( !var_3 )
        {
            var_4 = var_0.origin;
            self.x = var_4[0] + var_1[0];
            self.y = var_4[1] + var_1[1];
            self.z = var_4[2] + var_1[2];
        }

        if ( var_2 > 0.05 )
        {
            self.alpha = 0.85;
            self fadeovertime( var_2 );
            self.alpha = 0;
        }

        wait(var_2);
    }
}

_ID18724( var_0 )
{
    return isdefined( var_0.targetname ) && var_0.targetname == "care_package";
}

_ID28896( var_0, var_1 )
{
    if ( !level._ID32653 )
        return;

    if ( !isdefined( self.entityheadiconteam ) )
    {
        self.entityheadiconteam = "none";
        self._ID12146 = undefined;
    }

    var_2 = game["entity_headicon_" + var_0];
    self.entityheadiconteam = var_0;

    if ( isdefined( var_1 ) )
        self.entityheadiconoffset = var_1;
    else
        self.entityheadiconoffset = ( 0, 0, 0 );

    self notify( "kill_entity_headicon_thread" );

    if ( var_0 == "none" )
    {
        if ( isdefined( self._ID12146 ) )
            self._ID12146 destroy();

        return;
    }

    var_3 = newteamhudelem( var_0 );
    var_3.archived = 1;
    var_3.x = self.origin[0] + self.entityheadiconoffset[0];
    var_3.y = self.origin[1] + self.entityheadiconoffset[1];
    var_3.z = self.origin[2] + self.entityheadiconoffset[2];
    var_3.alpha = 0.8;
    var_3 setshader( var_2, 10, 10 );
    var_3 setwaypoint( 0, 0, 0, 1 );
    self._ID12146 = var_3;
    thread _ID19103();
    thread destroyheadiconsondeath();
}

_ID28825( var_0, var_1 )
{
    if ( level._ID32653 )
        return;

    if ( !isdefined( self.entityheadiconteam ) )
    {
        self.entityheadiconteam = "none";
        self._ID12146 = undefined;
    }

    self notify( "kill_entity_headicon_thread" );

    if ( !isdefined( var_0 ) )
    {
        if ( isdefined( self._ID12146 ) )
            self._ID12146 destroy();

        return;
    }

    var_2 = var_0.team;
    self.entityheadiconteam = var_2;

    if ( isdefined( var_1 ) )
        self.entityheadiconoffset = var_1;
    else
        self.entityheadiconoffset = ( 0, 0, 0 );

    var_3 = game["entity_headicon_" + var_2];
    var_4 = newclienthudelem( var_0 );
    var_4.archived = 1;
    var_4.x = self.origin[0] + self.entityheadiconoffset[0];
    var_4.y = self.origin[1] + self.entityheadiconoffset[1];
    var_4.z = self.origin[2] + self.entityheadiconoffset[2];
    var_4.alpha = 0.8;
    var_4 setshader( var_3, 10, 10 );
    var_4 setwaypoint( 0, 0, 0, 1 );
    self._ID12146 = var_4;
    thread _ID19103();
    thread destroyheadiconsondeath();
}

_ID19103()
{
    self._ID12146 linkwaypointtotargetwithoffset( self, self.entityheadiconoffset );
}

destroyheadiconsondeath()
{
    self endon( "kill_entity_headicon_thread" );
    self waittill( "death" );

    if ( !isdefined( self._ID12146 ) )
        return;

    self._ID12146 destroy();
}
