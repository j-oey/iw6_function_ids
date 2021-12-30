// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID28815( var_0 )
{
    if ( isdefined( self._ID23270 ) && self._ID23270 == var_0 )
        return;

    if ( isdefined( self._ID23270 ) )
        self._ID23270 removechild( self );

    self._ID23270 = var_0;
    self._ID23270 addchild( self );

    if ( isdefined( self._ID24710 ) )
    {
        _ID28836( self._ID24710, self._ID25731, self._ID36455, self._ID36503 );
        return;
    }

    _ID28836( "TOPLEFT" );
    return;
}

getparent()
{
    return self._ID23270;
}

_ID25990()
{
    if ( isdefined( self._ID7138 ) && self._ID7138 == gettime() )
        return;

    self._ID7138 = gettime();
    var_0 = [];

    foreach ( var_3, var_2 in self._ID7139 )
    {
        if ( !isdefined( var_2 ) )
            continue;

        var_2.index = var_0.size;
        var_0[var_0.size] = var_2;
    }

    self._ID7139 = var_0;
}

addchild( var_0 )
{
    var_0.index = self._ID7139.size;
    self._ID7139[self._ID7139.size] = var_0;
    _ID25990();
}

removechild( var_0 )
{
    var_0._ID23270 = undefined;

    if ( self._ID7139[self._ID7139.size - 1] != var_0 )
    {
        self._ID7139[var_0.index] = self._ID7139[self._ID7139.size - 1];
        self._ID7139[var_0.index].index = var_0.index;
    }

    self._ID7139[self._ID7139.size - 1] = undefined;
    var_0.index = undefined;
}

_ID28836( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_4 ) )
        var_4 = 0;

    var_5 = getparent();

    if ( var_4 )
        self moveovertime( var_4 );

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    self._ID36455 = var_2;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    self._ID36503 = var_3;
    self._ID24710 = var_0;
    self.alignx = "center";
    self.aligny = "middle";

    if ( issubstr( var_0, "TOP" ) )
        self.aligny = "top";

    if ( issubstr( var_0, "BOTTOM" ) )
        self.aligny = "bottom";

    if ( issubstr( var_0, "LEFT" ) )
        self.alignx = "left";

    if ( issubstr( var_0, "RIGHT" ) )
        self.alignx = "right";

    if ( !isdefined( var_1 ) )
        var_1 = var_0;

    self._ID25731 = var_1;
    var_6 = "center_adjustable";
    var_7 = "middle";

    if ( issubstr( var_1, "TOP" ) )
        var_7 = "top_adjustable";

    if ( issubstr( var_1, "BOTTOM" ) )
        var_7 = "bottom_adjustable";

    if ( issubstr( var_1, "LEFT" ) )
        var_6 = "left_adjustable";

    if ( issubstr( var_1, "RIGHT" ) )
        var_6 = "right_adjustable";

    if ( var_5 == level._ID34184 )
    {
        self.horzalign = var_6;
        self.vertalign = var_7;
    }
    else
    {
        self.horzalign = var_5.horzalign;
        self.vertalign = var_5.vertalign;
    }

    if ( maps\mp\_utility::_ID31978( var_6, "_adjustable" ) == var_5.alignx )
    {
        var_8 = 0;
        var_9 = 0;
    }
    else if ( var_6 == "center" || var_5.alignx == "center" )
    {
        var_8 = int( var_5.width / 2 );

        if ( var_6 == "left_adjustable" || var_5.alignx == "right" )
            var_9 = -1;
        else
            var_9 = 1;
    }
    else
    {
        var_8 = var_5.width;

        if ( var_6 == "left_adjustable" )
            var_9 = -1;
        else
            var_9 = 1;
    }

    self.x = var_5.x + var_8 * var_9;

    if ( maps\mp\_utility::_ID31978( var_7, "_adjustable" ) == var_5.aligny )
    {
        var_10 = 0;
        var_11 = 0;
    }
    else if ( var_7 == "middle" || var_5.aligny == "middle" )
    {
        var_10 = int( var_5.height / 2 );

        if ( var_7 == "top_adjustable" || var_5.aligny == "bottom" )
            var_11 = -1;
        else
            var_11 = 1;
    }
    else
    {
        var_10 = var_5.height;

        if ( var_7 == "top_adjustable" )
            var_11 = -1;
        else
            var_11 = 1;
    }

    self.y = var_5.y + var_10 * var_11;
    self.x = self.x + self._ID36455;
    self.y = self.y + self._ID36503;

    switch ( self._ID11272 )
    {
        case "bar":
            _ID28837( var_0, var_1, var_2, var_3 );
            break;
    }

    _ID34520();
}

_ID28837( var_0, var_1, var_2, var_3 )
{
    self.bar.horzalign = self.horzalign;
    self.bar.vertalign = self.vertalign;
    self.bar.alignx = "left";
    self.bar.aligny = self.aligny;
    self.bar.y = self.y;

    if ( self.alignx == "left" )
        self.bar.x = self.x;
    else if ( self.alignx == "right" )
        self.bar.x = self.x - self.width;
    else
        self.bar.x = self.x - int( self.width / 2 );

    if ( self.aligny == "top" )
        self.bar.y = self.y;
    else if ( self.aligny == "bottom" )
        self.bar.y = self.y;

    _ID34509( self.bar.frac );
}

_ID34509( var_0, var_1 )
{
    if ( self._ID11272 == "bar" )
    {
        _ID34510( var_0, var_1 );
        return;
    }
}

_ID34510( var_0, var_1 )
{
    var_2 = int( self.width * var_0 + 0.5 );

    if ( !var_2 )
        var_2 = 1;

    self.bar.frac = var_0;
    self.bar setshader( self.bar._ID29625, var_2, self.height );

    if ( isdefined( var_1 ) && var_2 < self.width )
    {
        if ( var_1 > 0 )
            self.bar scaleovertime( ( 1 - var_0 ) / var_1, self.width, self.height );
        else if ( var_1 < 0 )
            self.bar scaleovertime( var_0 / -1 * var_1, 1, self.height );
    }

    self.bar._ID25493 = var_1;
    self.bar.lastupdatetime = gettime();
}

createfontstring( var_0, var_1 )
{
    var_2 = newclienthudelem( self );
    var_2._ID11272 = "font";
    var_2.font = var_0;
    var_2.fontscale = var_1;
    var_2.basefontscale = var_1;
    var_2.x = 0;
    var_2.y = 0;
    var_2.width = 0;
    var_2.height = int( level._ID13468 * var_1 );
    var_2._ID36455 = 0;
    var_2._ID36503 = 0;
    var_2._ID7139 = [];
    var_2 _ID28815( level._ID34184 );
    var_2._ID16844 = 0;
    return var_2;
}

createserverfontstring( var_0, var_1, var_2 )
{
    if ( isdefined( var_2 ) )
        var_3 = newteamhudelem( var_2 );
    else
        var_3 = newhudelem();

    var_3._ID11272 = "font";
    var_3.font = var_0;
    var_3.fontscale = var_1;
    var_3.basefontscale = var_1;
    var_3.x = 0;
    var_3.y = 0;
    var_3.width = 0;
    var_3.height = int( level._ID13468 * var_1 );
    var_3._ID36455 = 0;
    var_3._ID36503 = 0;
    var_3._ID7139 = [];
    var_3 _ID28815( level._ID34184 );
    var_3._ID16844 = 0;
    return var_3;
}

createservertimer( var_0, var_1, var_2 )
{
    if ( isdefined( var_2 ) )
        var_3 = newteamhudelem( var_2 );
    else
        var_3 = newhudelem();

    var_3._ID11272 = "timer";
    var_3.font = var_0;
    var_3.fontscale = var_1;
    var_3.basefontscale = var_1;
    var_3.x = 0;
    var_3.y = 0;
    var_3.width = 0;
    var_3.height = int( level._ID13468 * var_1 );
    var_3._ID36455 = 0;
    var_3._ID36503 = 0;
    var_3._ID7139 = [];
    var_3 _ID28815( level._ID34184 );
    var_3._ID16844 = 0;
    return var_3;
}

createtimer( var_0, var_1 )
{
    var_2 = newclienthudelem( self );
    var_2._ID11272 = "timer";
    var_2.font = var_0;
    var_2.fontscale = var_1;
    var_2.basefontscale = var_1;
    var_2.x = 0;
    var_2.y = 0;
    var_2.width = 0;
    var_2.height = int( level._ID13468 * var_1 );
    var_2._ID36455 = 0;
    var_2._ID36503 = 0;
    var_2._ID7139 = [];
    var_2 _ID28815( level._ID34184 );
    var_2._ID16844 = 0;
    return var_2;
}

_ID8444( var_0, var_1, var_2 )
{
    var_3 = newclienthudelem( self );
    var_3._ID11272 = "icon";
    var_3.x = 0;
    var_3.y = 0;
    var_3.width = var_1;
    var_3.height = var_2;
    var_3.basewidth = var_3.width;
    var_3.baseheight = var_3.height;
    var_3._ID36455 = 0;
    var_3._ID36503 = 0;
    var_3._ID7139 = [];
    var_3 _ID28815( level._ID34184 );
    var_3._ID16844 = 0;

    if ( isdefined( var_0 ) )
    {
        var_3 setshader( var_0, var_1, var_2 );
        var_3._ID29625 = var_0;
    }

    return var_3;
}

_ID8478( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_3 ) )
        var_4 = newteamhudelem( var_3 );
    else
        var_4 = newhudelem();

    var_4._ID11272 = "icon";
    var_4.x = 0;
    var_4.y = 0;
    var_4.width = var_1;
    var_4.height = var_2;
    var_4.basewidth = var_4.width;
    var_4.baseheight = var_4.height;
    var_4._ID36455 = 0;
    var_4._ID36503 = 0;
    var_4._ID7139 = [];
    var_4 _ID28815( level._ID34184 );
    var_4._ID16844 = 0;

    if ( isdefined( var_0 ) )
    {
        var_4 setshader( var_0, var_1, var_2 );
        var_4._ID29625 = var_0;
    }

    return var_4;
}

_ID8476( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( isdefined( var_4 ) )
        var_6 = newteamhudelem( var_4 );
    else
        var_6 = newhudelem();

    var_6.x = 0;
    var_6.y = 0;
    var_6.frac = 0;
    var_6.color = var_0;
    var_6.sort = -2;
    var_6._ID29625 = "progress_bar_fill";
    var_6 setshader( "progress_bar_fill", var_1, var_2 );
    var_6._ID16844 = 0;

    if ( isdefined( var_3 ) )
        var_6._ID13316 = var_3;

    if ( isdefined( var_4 ) )
        var_7 = newteamhudelem( var_4 );
    else
        var_7 = newhudelem();

    var_7._ID11272 = "bar";
    var_7.x = 0;
    var_7.y = 0;
    var_7.width = var_1;
    var_7.height = var_2;
    var_7._ID36455 = 0;
    var_7._ID36503 = 0;
    var_7.bar = var_6;
    var_7._ID7139 = [];
    var_7.sort = -3;
    var_7.color = ( 0, 0, 0 );
    var_7.alpha = 0.5;
    var_7 _ID28815( level._ID34184 );
    var_7 setshader( "progress_bar_bg", var_1, var_2 );
    var_7._ID16844 = 0;
    return var_7;
}

createbar( var_0, var_1, var_2, var_3 )
{
    var_4 = newclienthudelem( self );
    var_4.x = 0;
    var_4.y = 0;
    var_4.frac = 0;
    var_4.color = var_0;
    var_4.sort = -2;
    var_4._ID29625 = "progress_bar_fill";
    var_4 setshader( "progress_bar_fill", var_1, var_2 );
    var_4._ID16844 = 0;

    if ( isdefined( var_3 ) )
        var_4._ID13316 = var_3;

    var_5 = newclienthudelem( self );
    var_5._ID11272 = "bar";
    var_5.width = var_1;
    var_5.height = var_2;
    var_5._ID36455 = 0;
    var_5._ID36503 = 0;
    var_5.bar = var_4;
    var_5._ID7139 = [];
    var_5.sort = -3;
    var_5.color = ( 0, 0, 0 );
    var_5.alpha = 0.5;
    var_5 _ID28815( level._ID34184 );
    var_5 setshader( "progress_bar_bg", var_1 + 4, var_2 + 4 );
    var_5._ID16844 = 0;
    return var_5;
}

getcurrentfraction()
{
    var_0 = self.bar.frac;

    if ( isdefined( self.bar._ID25493 ) )
    {
        var_0 += ( gettime() - self.bar.lastupdatetime ) * self.bar._ID25493;

        if ( var_0 > 1 )
            var_0 = 1;

        if ( var_0 < 0 )
            var_0 = 0;
    }

    return var_0;
}

createprimaryprogressbar( var_0, var_1 )
{
    if ( isagent( self ) )
        return undefined;

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = -25;

    if ( self issplitscreenplayer() )
        var_1 += 20;

    var_2 = createbar( ( 1, 1, 1 ), level._ID24973, level._ID24970 );
    var_2 _ID28836( "CENTER", undefined, level._ID24974 + var_0, level._ID24975 + var_1 );
    return var_2;
}

createprimaryprogressbartext( var_0, var_1, var_2, var_3 )
{
    if ( isagent( self ) )
        return undefined;

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = -25;

    if ( self issplitscreenplayer() )
        var_1 += 20;

    var_4 = level.primaryprogressbarfontsize;
    var_5 = "default";

    if ( isdefined( var_2 ) )
        var_4 = var_2;

    if ( isdefined( var_3 ) )
        var_5 = var_3;

    var_6 = createfontstring( var_5, var_4 );
    var_6 _ID28836( "CENTER", undefined, level._ID24971 + var_0, level.primaryprogressbartexty + var_1 );
    var_6.sort = -1;
    return var_6;
}

_ID8487( var_0 )
{
    var_1 = _ID8476( ( 1, 0, 0 ), level.teamprogressbarwidth, level._ID32674, undefined, var_0 );
    var_1 _ID28836( "TOP", undefined, 0, level._ID32677 );
    return var_1;
}

createteamprogressbartext( var_0 )
{
    var_1 = createserverfontstring( "default", level._ID32673, var_0 );
    var_1 _ID28836( "TOP", undefined, 0, level.teamprogressbartexty );
    return var_1;
}

_ID28727( var_0 )
{
    self.bar._ID13316 = var_0;
}

_ID16899()
{
    if ( self._ID16844 )
        return;

    self._ID16844 = 1;

    if ( self.alpha != 0 )
        self.alpha = 0;

    if ( self._ID11272 == "bar" || self._ID11272 == "bar_shader" )
    {
        self.bar._ID16844 = 1;

        if ( self.bar.alpha != 0 )
        {
            self.bar.alpha = 0;
            return;
        }

        return;
    }
}

_ID29966()
{
    if ( !self._ID16844 )
        return;

    self._ID16844 = 0;

    if ( self._ID11272 == "bar" || self._ID11272 == "bar_shader" )
    {
        if ( self.alpha != 0.5 )
            self.alpha = 0.5;

        self.bar._ID16844 = 0;

        if ( self.bar.alpha != 1 )
        {
            self.bar.alpha = 1;
            return;
        }

        return;
    }

    if ( self.alpha != 1 )
    {
        self.alpha = 1;
        return;
    }

    return;
}

_ID13331()
{
    self endon( "death" );

    if ( !self._ID16844 )
        self.alpha = 1;

    for (;;)
    {
        if ( self.frac >= self._ID13316 )
        {
            if ( !self._ID16844 )
            {
                self fadeovertime( 0.3 );
                self.alpha = 0.2;
                wait 0.35;
                self fadeovertime( 0.3 );
                self.alpha = 1;
            }

            wait 0.7;
            continue;
        }

        if ( !self._ID16844 && self.alpha != 1 )
            self.alpha = 1;

        wait 0.05;
    }
}

destroyelem()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < self._ID7139.size; var_1++ )
    {
        if ( isdefined( self._ID7139[var_1] ) )
            var_0[var_0.size] = self._ID7139[var_1];
    }

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        var_0[var_1] _ID28815( getparent() );

    if ( self._ID11272 == "bar" || self._ID11272 == "bar_shader" )
        self.bar destroy();

    self destroy();
}

seticonshader( var_0 )
{
    self setshader( var_0, self.width, self.height );
    self._ID29625 = var_0;
}

geticonshader( var_0 )
{
    return self._ID29625;
}

_ID28753( var_0, var_1 )
{
    self setshader( self._ID29625, var_0, var_1 );
}

_ID29210( var_0 )
{
    self.width = var_0;
}

_ID28748( var_0 )
{
    self.height = var_0;
}

setsize( var_0, var_1 )
{
    self.width = var_0;
    self.height = var_1;
}

_ID34520()
{
    for ( var_0 = 0; var_0 < self._ID7139.size; var_0++ )
    {
        var_1 = self._ID7139[var_0];
        var_1 _ID28836( var_1._ID24710, var_1._ID25731, var_1._ID36455, var_1._ID36503 );
    }
}

_ID33386()
{
    self.x = self._ID36455;
    self.y = self._ID36503;

    if ( self._ID11272 == "font" )
    {
        self.fontscale = self.basefontscale;
        self.label = &"";
    }
    else if ( self._ID11272 == "icon" )
        self setshader( self._ID29625, self.width, self.height );

    self.alpha = 0;
}

_ID33395( var_0 )
{
    switch ( self._ID11272 )
    {
        case "font":
        case "timer":
            self.fontscale = 6.3;
            self changefontscaleovertime( var_0 );
            self.fontscale = self.basefontscale;
            break;
        case "icon":
            self setshader( self._ID29625, self.width * 6, self.height * 6 );
            self scaleovertime( var_0, self.width, self.height );
            break;
    }
}

_ID33385( var_0, var_1 )
{
    var_2 = int( var_0 ) * 1000;
    var_3 = int( var_1 ) * 1000;

    switch ( self._ID11272 )
    {
        case "font":
        case "timer":
            self setpulsefx( var_2 + 250, var_3 + var_2, var_2 + 250 );
            break;
        default:
            break;
    }
}

_ID33388( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "left";

    switch ( var_1 )
    {
        case "left":
            self.x = self.x + 1000;
            break;
        case "right":
            self.x = self.x - 1000;
            break;
        case "up":
            self.y = self.y - 1000;
            break;
        case "down":
            self.y = self.y + 1000;
            break;
    }

    self moveovertime( var_0 );
    self.x = self._ID36455;
    self.y = self._ID36503;
}

_ID33389( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "left";

    var_2 = self._ID36455;
    var_3 = self._ID36503;

    switch ( var_1 )
    {
        case "left":
            var_2 += 1000;
            break;
        case "right":
            var_2 -= 1000;
            break;
        case "up":
            var_3 -= 1000;
            break;
        case "down":
            var_3 += 1000;
            break;
    }

    self.alpha = 1;
    self moveovertime( var_0 );
    self.x = var_2;
    self.y = var_3;
}

_ID33396( var_0 )
{
    switch ( self._ID11272 )
    {
        case "font":
        case "timer":
            self changefontscaleovertime( var_0 );
            self.fontscale = 6.3;
        case "icon":
            self scaleovertime( var_0, self.width * 6, self.height * 6 );
            break;
    }
}

_ID33382( var_0 )
{
    self fadeovertime( var_0 );

    if ( isdefined( self._ID20717 ) )
    {
        self.alpha = self._ID20717;
        return;
    }

    self.alpha = 1;
    return;
}

_ID33383( var_0 )
{
    self fadeovertime( 0.15 );
    self.alpha = 0;
}

getweeklyref( var_0 )
{
    for ( var_1 = 0; var_1 < 3; var_1++ )
    {
        var_2 = self getrankedplayerdata( "weeklyChallengeId", var_1 );
        var_3 = tablelookupbyrow( "mp/weeklyChallengesTable.csv", var_2, 0 );

        if ( var_3 == var_0 )
            return "ch_weekly_" + var_1;
    }

    return "";
}

_ID14959( var_0 )
{
    for ( var_1 = 0; var_1 < 3; var_1++ )
    {
        var_2 = self getrankedplayerdata( "dailyChallengeId", var_1 );
        var_3 = tablelookupbyrow( "mp/dailyChallengesTable.csv", var_2, 0 );

        if ( var_3 == var_0 )
            return "ch_daily_" + var_1;
    }

    return "";
}

_ID6815( var_0 )
{
    if ( level.challengeinfo[var_0]["type"] == 0 )
    {
        return self getrankedplayerdata( "challengeProgress", var_0 );
        return;
    }

    if ( level.challengeinfo[var_0]["type"] == 1 )
    {
        return self getrankedplayerdata( "challengeProgress", _ID14959( var_0 ) );
        return;
    }

    if ( level.challengeinfo[var_0]["type"] == 2 )
    {
        return self getrankedplayerdata( "challengeProgress", getweeklyref( var_0 ) );
        return;
    }

    return;
    return;
}

ch_getstate( var_0 )
{
    if ( level.challengeinfo[var_0]["type"] == 0 )
    {
        return self getrankedplayerdata( "challengeState", var_0 );
        return;
    }

    if ( level.challengeinfo[var_0]["type"] == 1 )
    {
        return self getrankedplayerdata( "challengeState", _ID14959( var_0 ) );
        return;
    }

    if ( level.challengeinfo[var_0]["type"] == 2 )
    {
        return self getrankedplayerdata( "challengeState", getweeklyref( var_0 ) );
        return;
    }

    return;
    return;
}

ch_setprogress( var_0, var_1 )
{
    if ( level.challengeinfo[var_0]["type"] == 0 )
    {
        return self setrankedplayerdata( "challengeProgress", var_0, var_1 );
        return;
    }

    if ( level.challengeinfo[var_0]["type"] == 1 )
    {
        return self setrankedplayerdata( "challengeProgress", _ID14959( var_0 ), var_1 );
        return;
    }

    if ( level.challengeinfo[var_0]["type"] == 2 )
    {
        return self setrankedplayerdata( "challengeProgress", getweeklyref( var_0 ), var_1 );
        return;
    }

    return;
    return;
}

_ID6824( var_0, var_1 )
{
    if ( level.challengeinfo[var_0]["type"] == 0 )
    {
        return self setrankedplayerdata( "challengeState", var_0, var_1 );
        return;
    }

    if ( level.challengeinfo[var_0]["type"] == 1 )
    {
        return self setrankedplayerdata( "challengeState", _ID14959( var_0 ), var_1 );
        return;
    }

    if ( level.challengeinfo[var_0]["type"] == 2 )
    {
        return self setrankedplayerdata( "challengeState", getweeklyref( var_0 ), var_1 );
        return;
    }

    return;
    return;
}

ch_gettarget( var_0, var_1 )
{
    if ( level.challengeinfo[var_0]["type"] == 0 )
    {
        return int( tablelookup( "mp/allChallengesTable.csv", 0, var_0, 9 + ( var_1 - 1 ) * 2 ) );
        return;
    }

    if ( level.challengeinfo[var_0]["type"] == 1 )
    {
        return int( tablelookup( "mp/dailyChallengesTable.csv", 0, var_0, 9 + ( var_1 - 1 ) * 2 ) );
        return;
    }

    if ( level.challengeinfo[var_0]["type"] == 2 )
    {
        return int( tablelookup( "mp/weeklyChallengesTable.csv", 0, var_0, 9 + ( var_1 - 1 ) * 2 ) );
        return;
    }

    return;
    return;
}

ch_isactivechallenge( var_0 )
{
    var_1 = 5;

    if ( level.challengeinfo[var_0]["type"] == 0 )
    {
        for ( var_2 = 0; var_2 < var_1; var_2++ )
        {
            var_3 = self getrankedplayerdata( "activeChallenges", var_2 );

            if ( var_3 == var_0 )
                return 1;
        }
    }
    else if ( level.challengeinfo[var_0]["type"] == 1 )
        return 1;
    else if ( level.challengeinfo[var_0]["type"] == 2 )
        return 1;

    return 0;
}
