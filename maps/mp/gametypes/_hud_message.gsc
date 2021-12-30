// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    game["round_end"]["draw"] = 1;
    game["round_end"]["round_draw"] = 2;
    game["round_end"]["round_win"] = 3;
    game["round_end"]["round_loss"] = 4;
    game["round_end"]["victory"] = 5;
    game["round_end"]["defeat"] = 6;
    game["round_end"]["halftime"] = 7;
    game["round_end"]["overtime"] = 8;
    game["round_end"]["roundend"] = 9;
    game["round_end"]["intermission"] = 10;
    game["round_end"]["side_switch"] = 11;
    game["round_end"]["match_bonus"] = 12;
    game["round_end"]["tie"] = 13;
    game["round_end"]["spectator"] = 14;
    game["end_reason"]["score_limit_reached"] = 1;
    game["end_reason"]["time_limit_reached"] = 2;
    game["end_reason"]["players_forfeited"] = 3;
    game["end_reason"]["target_destroyed"] = 4;
    game["end_reason"]["bomb_defused"] = 5;
    game["end_reason"]["allies_eliminated"] = 6;
    game["end_reason"]["axis_eliminated"] = 7;
    game["end_reason"]["allies_forfeited"] = 8;
    game["end_reason"]["axis_forfeited"] = 9;
    game["end_reason"]["enemies_eliminated"] = 10;
    game["end_reason"]["tie"] = 11;
    game["end_reason"]["objective_completed"] = 12;
    game["end_reason"]["objective_failed"] = 13;
    game["end_reason"]["switching_sides"] = 14;
    game["end_reason"]["round_limit_reached"] = 15;
    game["end_reason"]["ended_game"] = 16;
    game["end_reason"]["host_ended_game"] = 17;
    game["strings"]["overtime"] = &"MP_OVERTIME";
    level thread _ID22877();
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread _ID16993();
        var_0 thread _ID20388();
        var_0 thread _ID17978();
    }
}

hintmessage( var_0 )
{
    var_1 = spawnstruct();
    var_1.notifytext = var_0;
    var_1.glowcolor = game["colors"]["cyan"];
    _ID22313( var_1 );
}

_ID17978()
{
    if ( level.splitscreen || self issplitscreenplayer() )
    {
        var_0 = 1.5;
        var_1 = 1.25;
        var_2 = 24;
        var_3 = "default";
        var_4 = "TOP";
        var_5 = "BOTTOM";
        var_6 = 0;
        var_7 = 0;
    }
    else
    {
        var_0 = 2.5;
        var_1 = 1.75;
        var_2 = 30;
        var_3 = "objective";
        var_4 = "TOP";
        var_5 = "BOTTOM";
        var_6 = 50;
        var_7 = 0;
    }

    self._ID22325 = maps\mp\gametypes\_hud_util::createfontstring( var_3, var_0 );
    self._ID22325 maps\mp\gametypes\_hud_util::_ID28836( var_4, undefined, var_7, var_6 );
    self._ID22325.glowcolor = game["colors"]["blue"];
    self._ID22325.glowalpha = 1;
    self._ID22325.hidewheninmenu = 1;
    self._ID22325.archived = 0;
    self._ID22325.alpha = 0;
    self.notifytext = maps\mp\gametypes\_hud_util::createfontstring( var_3, var_1 );
    self.notifytext maps\mp\gametypes\_hud_util::_ID28815( self._ID22325 );
    self.notifytext maps\mp\gametypes\_hud_util::_ID28836( var_4, var_5, 0, 0 );
    self.notifytext.glowcolor = game["colors"]["blue"];
    self.notifytext.glowalpha = 1;
    self.notifytext.hidewheninmenu = 1;
    self.notifytext.archived = 0;
    self.notifytext.alpha = 0;
    self._ID22324 = maps\mp\gametypes\_hud_util::createfontstring( var_3, var_1 );
    self._ID22324 maps\mp\gametypes\_hud_util::_ID28815( self._ID22325 );
    self._ID22324 maps\mp\gametypes\_hud_util::_ID28836( var_4, var_5, 0, 0 );
    self._ID22324.glowcolor = game["colors"]["blue"];
    self._ID22324.glowalpha = 1;
    self._ID22324.hidewheninmenu = 1;
    self._ID22324.archived = 0;
    self._ID22324.alpha = 0;
    self._ID22310 = maps\mp\gametypes\_hud_util::_ID8444( "white", var_2, var_2 );
    self._ID22310 maps\mp\gametypes\_hud_util::_ID28815( self._ID22324 );
    self._ID22310 maps\mp\gametypes\_hud_util::_ID28836( var_4, var_5, 0, 0 );
    self._ID22310.hidewheninmenu = 1;
    self._ID22310.archived = 0;
    self._ID22310.alpha = 0;
    self.notifyoverlay = maps\mp\gametypes\_hud_util::_ID8444( "white", var_2, var_2 );
    self.notifyoverlay maps\mp\gametypes\_hud_util::_ID28815( self._ID22310 );
    self.notifyoverlay maps\mp\gametypes\_hud_util::_ID28836( "CENTER", "CENTER", 0, 0 );
    self.notifyoverlay.hidewheninmenu = 1;
    self.notifyoverlay.archived = 0;
    self.notifyoverlay.alpha = 0;
    self.doingsplash = [];
    self.doingsplash[0] = undefined;
    self.doingsplash[1] = undefined;
    self.doingsplash[2] = undefined;
    self.doingsplash[3] = undefined;
    self.splashqueue = [];
    self.splashqueue[0] = [];
    self.splashqueue[1] = [];
    self.splashqueue[2] = [];
    self.splashqueue[3] = [];
}

_ID22731( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = spawnstruct();
    var_6._ID33092 = var_0;
    var_6.notifytext = var_1;
    var_6._ID17331 = var_2;
    var_6.glowcolor = var_3;
    var_6._ID30465 = var_4;
    var_6._ID11157 = var_5;
    _ID22313( var_6 );
}

_ID22313( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );

    if ( !isdefined( var_0._ID30205 ) )
        var_0._ID30205 = 0;

    var_1 = var_0._ID30205;

    if ( !isdefined( var_0.type ) )
        var_0.type = "";

    if ( !isdefined( self.doingsplash[var_1] ) )
    {
        thread _ID29983( var_0 );
        return;
    }

    self.splashqueue[var_1][self.splashqueue[var_1].size] = var_0;
}

dispatchnotify( var_0 )
{
    var_1 = self.splashqueue[var_0][0];

    for ( var_2 = 1; var_2 < self.splashqueue[var_0].size; var_2++ )
        self.splashqueue[var_0][var_2 - 1] = self.splashqueue[var_0][var_2];

    self.splashqueue[var_0][var_2 - 1] = undefined;

    if ( isdefined( var_1.name ) )
    {
        actionnotify( var_1 );
        return;
    }

    _ID29983( var_1 );
    return;
}

_ID25071()
{
    if ( !isplayer( self ) )
        return;

    self endon( "disconnect" );
    var_0 = spawnstruct();
    var_1 = "promotion";
    var_0.name = var_1;
    var_0.type = tablelookup( _ID14778(), 0, var_1, 11 );
    var_0._ID30465 = tablelookup( _ID14778(), 0, var_1, 9 );
    var_0._ID30205 = 0;
    thread actionnotify( var_0 );
}

_ID36279()
{
    if ( !isplayer( self ) )
        return;

    self endon( "disconnect" );
    var_0 = spawnstruct();
    var_1 = "promotion_weapon";
    var_0.name = var_1;
    var_0.type = tablelookup( _ID14778(), 0, var_1, 11 );
    var_0._ID30465 = tablelookup( _ID14778(), 0, var_1, 9 );
    var_0._ID30205 = 0;
    thread actionnotify( var_0 );
}

_ID29983( var_0 )
{
    self endon( "disconnect" );
    var_1 = var_0._ID30205;

    if ( level.gameended )
    {
        if ( isdefined( var_0.type ) && var_0.type == "rank" )
        {
            self setclientdvar( "ui_promotion", 1 );
            self._ID24790 = 1;
        }

        if ( self.splashqueue[var_1].size )
            thread dispatchnotify( var_1 );

        return;
    }

    self.doingsplash[var_1] = var_0;
    _ID35600( 0 );

    if ( isdefined( var_0._ID11157 ) )
        var_2 = var_0._ID11157;
    else if ( level.gameended )
        var_2 = 2.0;
    else
        var_2 = 4.0;

    thread resetoncancel();

    if ( isdefined( var_0._ID30465 ) )
        self playlocalsound( var_0._ID30465 );

    if ( isdefined( var_0.leadersound ) )
        maps\mp\_utility::_ID19765( var_0.leadersound );

    if ( isdefined( var_0.glowcolor ) )
        var_3 = var_0.glowcolor;
    else
        var_3 = game["colors"]["cyan"];

    var_4 = self._ID22325;

    if ( isdefined( var_0._ID33092 ) )
    {
        if ( isdefined( var_0._ID33091 ) )
            self._ID22325.label = var_0._ID33091;
        else
            self._ID22325.label = &"";

        if ( isdefined( var_0._ID33091 ) && !isdefined( var_0._ID33090 ) )
            self._ID22325 setvalue( var_0._ID33092 );
        else
            self._ID22325 settext( var_0._ID33092 );

        self._ID22325 setpulsefx( int( 25 * var_2 ), int( var_2 * 1000 ), 1000 );
        self._ID22325.glowcolor = var_3;
        self._ID22325.alpha = 1;
    }

    if ( isdefined( var_0._ID32874 ) )
        var_3 = var_0._ID32874;

    if ( isdefined( var_0.notifytext ) )
    {
        if ( isdefined( var_0._ID32876 ) )
            self.notifytext.label = var_0._ID32876;
        else
            self.notifytext.label = &"";

        if ( isdefined( var_0._ID32876 ) && !isdefined( var_0._ID32875 ) )
            self.notifytext setvalue( var_0.notifytext );
        else
            self.notifytext settext( var_0.notifytext );

        self.notifytext setpulsefx( 100, int( var_2 * 1000 ), 1000 );
        self.notifytext.glowcolor = var_3;
        self.notifytext.alpha = 1;
        var_4 = self.notifytext;
    }

    if ( isdefined( var_0._ID22324 ) )
    {
        self._ID22324 maps\mp\gametypes\_hud_util::_ID28815( var_4 );

        if ( isdefined( var_0._ID32860 ) )
            self._ID22324.label = var_0._ID32860;
        else
            self._ID22324.label = &"";

        self._ID22324 settext( var_0._ID22324 );
        self._ID22324 setpulsefx( 100, int( var_2 * 1000 ), 1000 );
        self._ID22324.glowcolor = var_3;
        self._ID22324.alpha = 1;
        var_4 = self._ID22324;
    }

    if ( isdefined( var_0._ID17331 ) )
    {
        self._ID22310 maps\mp\gametypes\_hud_util::_ID28815( var_4 );

        if ( level.splitscreen || self issplitscreenplayer() )
            self._ID22310 setshader( var_0._ID17331, 30, 30 );
        else
            self._ID22310 setshader( var_0._ID17331, 60, 60 );

        self._ID22310.alpha = 0;

        if ( isdefined( var_0._ID17332 ) )
        {
            self._ID22310 fadeovertime( 0.15 );
            self._ID22310.alpha = 1;
            var_0._ID23156 = 0;
            self.notifyoverlay maps\mp\gametypes\_hud_util::_ID28815( self._ID22310 );
            self.notifyoverlay maps\mp\gametypes\_hud_util::_ID28836( "CENTER", "CENTER", 0, var_0._ID23156 );
            self.notifyoverlay setshader( var_0._ID17332, 511, 511 );
            self.notifyoverlay.alpha = 0;
            self.notifyoverlay.color = game["colors"]["orange"];
            self.notifyoverlay fadeovertime( 0.4 );
            self.notifyoverlay.alpha = 0.85;
            self.notifyoverlay scaleovertime( 0.4, 32, 32 );
            _ID35600( var_2 );
            self._ID22310 fadeovertime( 0.75 );
            self._ID22310.alpha = 0;
            self.notifyoverlay fadeovertime( 0.75 );
            self.notifyoverlay.alpha = 0;
        }
        else
        {
            self._ID22310 fadeovertime( 1.0 );
            self._ID22310.alpha = 1;
            _ID35600( var_2 );
            self._ID22310 fadeovertime( 0.75 );
            self._ID22310.alpha = 0;
        }
    }
    else
        _ID35600( var_2 );

    self notify( "notifyMessageDone" );
    self.doingsplash[var_1] = undefined;

    if ( self.splashqueue[var_1].size )
    {
        thread dispatchnotify( var_1 );
        return;
    }
}

_ID19270( var_0, var_1, var_2 )
{
    if ( !isplayer( self ) )
        return;

    self endon( "disconnect" );
    waittillframeend;

    if ( level.gameended )
        return;

    var_3 = spawnstruct();

    if ( isdefined( var_2 ) )
        var_0 += ( "_" + var_2 );

    var_3.name = var_0;
    var_3.type = tablelookup( _ID14778(), 0, var_0, 11 );
    var_3._ID22991 = var_1;
    var_3._ID30465 = maps\mp\_utility::_ID15106( var_0 );
    var_3.leadersound = var_0;
    var_3._ID19770 = "killstreak_earned";
    var_3._ID30205 = 0;
    thread actionnotify( var_3 );
}

defconsplashnotify( var_0, var_1 )
{

}

_ID6858( var_0 )
{
    if ( !isplayer( self ) )
        return;

    self endon( "disconnect" );
    waittillframeend;
    wait 0.05;
    var_1 = maps\mp\gametypes\_hud_util::ch_getstate( var_0 ) - 1;
    var_2 = maps\mp\gametypes\_hud_util::ch_gettarget( var_0, var_1 );

    if ( var_2 == 0 )
        var_2 = 1;

    if ( var_0 == "ch_longersprint_pro" || var_0 == "ch_longersprint_pro_daily" || var_0 == "ch_longersprint_pro_weekly" )
        var_2 = int( var_2 / 528 );

    var_3 = spawnstruct();
    var_3.name = var_0;
    var_3.type = tablelookup( _ID14778(), 0, var_0, 11 );
    var_3._ID22991 = var_2;
    var_3._ID30465 = tablelookup( _ID14778(), 0, var_0, 9 );
    var_3._ID30205 = 1;
    thread actionnotify( var_3 );
}

_ID31052( var_0, var_1 )
{
    if ( !isplayer( self ) )
        return;

    self endon( "disconnect" );
    wait 0.05;
    var_2 = spawnstruct();
    var_2.name = var_0;
    var_2.type = tablelookup( _ID14778(), 0, var_0, 11 );
    var_2._ID22991 = var_1;
    var_2._ID30465 = tablelookup( _ID14778(), 0, var_2.name, 9 );
    var_2._ID30205 = 0;
    thread actionnotify( var_2 );
}

_ID31054( var_0, var_1 )
{
    if ( !isplayer( self ) )
        return;

    self endon( "disconnect" );
    wait 0.05;
    var_2 = spawnstruct();
    var_2.name = var_0;
    var_2.type = tablelookup( _ID14778(), 0, var_0, 11 );
    var_2._ID22991 = var_1;
    var_2._ID30465 = tablelookup( _ID14778(), 0, var_0, 9 );
    var_2._ID30205 = 0;
    thread actionnotify( var_2 );
}

_ID31053( var_0, var_1 )
{
    if ( !isplayer( self ) )
        return;

    self endon( "disconnect" );
    waittillframeend;

    if ( level.gameended )
        return;

    var_2 = spawnstruct();
    var_2.name = var_0;
    var_2.type = tablelookup( _ID14778(), 0, var_0, 11 );
    var_2._ID22991 = var_1;
    var_2._ID30465 = tablelookup( _ID14778(), 0, var_0, 9 );
    var_2._ID30205 = 0;
    thread actionnotify( var_2 );
}

_ID24474( var_0, var_1, var_2 )
{
    if ( !isplayer( self ) )
        return;

    self endon( "disconnect" );
    waittillframeend;

    if ( level.gameended )
        return;

    var_3 = spawnstruct();
    var_3.name = var_0;
    var_3.type = tablelookup( _ID14778(), 0, var_0, 11 );
    var_3._ID22991 = var_2;
    var_3._ID30465 = tablelookup( _ID14778(), 0, var_0, 9 );
    var_3._ID24473 = var_1;
    var_3._ID30205 = 1;
    thread actionnotify( var_3 );
}

actionnotify( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_1 = var_0._ID30205;

    if ( !isdefined( var_0.type ) )
        var_0.type = "";

    if ( !isdefined( self.doingsplash[var_1] ) )
    {
        thread actionnotifymessage( var_0 );
        return;
    }
    else
    {
        switch ( var_0.type )
        {
            case "mp_dig_all_perks_splash":
            case "urgent_splash":
                self.notifytext.alpha = 0;
                self._ID22324.alpha = 0;
                self._ID22310.alpha = 0;
                self setclientomnvar( "ui_splash_idx", -1 );
                self setclientomnvar( "ui_splash_killstreak_idx", -1 );
                self setclientomnvar( "ui_dig_killstreak_show", -1 );
                thread actionnotifymessage( var_0 );
                return;
            case "splash":
            case "killstreak_splash":
                if ( self.doingsplash[var_1].type != "splash" && self.doingsplash[var_1].type != "urgent_splash" && self.doingsplash[var_1].type != "killstreak_splash" && self.doingsplash[var_1].type != "challenge_splash" && self.doingsplash[var_1].type != "promotion_splash" && self.doingsplash[var_1].type != "intel_splash" )
                {
                    self.notifytext.alpha = 0;
                    self._ID22324.alpha = 0;
                    self._ID22310.alpha = 0;
                    thread actionnotifymessage( var_0 );
                    return;
                }

                break;
        }
    }

    if ( var_0.type == "challenge_splash" || var_0.type == "killstreak_splash" )
    {
        if ( var_0.type == "killstreak_splash" )
            removetypefromqueue( "killstreak_splash", var_1 );

        for ( var_2 = self.splashqueue[var_1].size; var_2 > 0; var_2-- )
            self.splashqueue[var_1][var_2] = self.splashqueue[var_1][var_2 - 1];

        self.splashqueue[var_1][0] = var_0;
        return;
    }

    self.splashqueue[var_1][self.splashqueue[var_1].size] = var_0;
    return;
}

removetypefromqueue( var_0, var_1 )
{
    var_2 = [];

    for ( var_3 = 0; var_3 < self.splashqueue[var_1].size; var_3++ )
    {
        if ( self.splashqueue[var_1][var_3].type != "killstreak_splash" )
            var_2[var_2.size] = self.splashqueue[var_1][var_3];
    }

    self.splashqueue[var_1] = var_2;
}

actionnotifymessage( var_0 )
{
    self endon( "disconnect" );
    var_1 = var_0._ID30205;

    if ( level.gameended )
    {
        if ( isdefined( var_0.type ) && ( var_0.type == "promotion_splash" || var_0.type == "promotion_weapon_splash" ) )
        {
            self setclientdvar( "ui_promotion", 1 );
            self._ID24790 = 1;
        }
        else if ( isdefined( var_0.type ) && var_0.type == "challenge_splash" )
        {
            self.pers["postGameChallenges"]++;
            self setclientdvar( "ui_challenge_" + self.pers["postGameChallenges"] + "_ref", var_0.name );
        }

        if ( self.splashqueue[var_1].size )
            thread dispatchnotify( var_1 );

        return;
    }

    if ( tablelookup( _ID14778(), 0, var_0.name, 0 ) != "" )
    {
        var_2 = tablelookuprownum( _ID14778(), 0, var_0.name );
        var_3 = maps\mp\_utility::_ID31977( tablelookupbyrow( _ID14778(), var_2, 4 ) );

        switch ( var_0.type )
        {
            case "killstreak_splash":
                self setclientomnvar( "ui_splash_killstreak_idx", var_2 );

                if ( isdefined( var_0._ID24473 ) && var_0._ID24473 != self )
                    self setclientomnvar( "ui_splash_killstreak_clientnum", var_0._ID24473 getentitynumber() );
                else
                    self setclientomnvar( "ui_splash_killstreak_clientnum", -1 );

                if ( isdefined( var_0._ID22991 ) )
                    self setclientomnvar( "ui_splash_killstreak_optional_number", var_0._ID22991 );
                else
                    self setclientomnvar( "ui_splash_killstreak_optional_number", 0 );

                break;
            case "playercard_splash":
                if ( isdefined( var_0._ID24473 ) )
                {
                    self setclientomnvar( "ui_splash_playercard_idx", var_2 );
                    self setclientomnvar( "ui_splash_playercard_clientnum", var_0._ID24473 getentitynumber() );

                    if ( isdefined( var_0._ID22991 ) )
                        self setclientomnvar( "ui_splash_playercard_optional_number", var_0._ID22991 );
                }

                break;
            case "splash":
            case "urgent_splash":
            case "intel_splash":
                self setclientomnvar( "ui_splash_idx", var_2 );

                if ( isdefined( var_0._ID22991 ) )
                    self setclientomnvar( "ui_splash_optional_number", var_0._ID22991 );

                break;
            case "challenge_splash":
            case "perk_challenge_splash":
                self setclientomnvar( "ui_challenge_splash_idx", var_2 );

                if ( isdefined( var_0._ID22991 ) )
                    self setclientomnvar( "ui_challenge_splash_optional_number", var_0._ID22991 );

                break;
            case "mp_dig_all_perks_splash":
                self setclientomnvar( "ui_dig_killstreak_show", 1 );
                break;
            default:
                break;
        }

        self.doingsplash[var_1] = var_0;

        if ( isdefined( var_0._ID30465 ) )
            self playlocalsound( var_0._ID30465 );

        if ( isdefined( var_0.leadersound ) )
        {
            if ( isdefined( var_0._ID19770 ) )
                maps\mp\_utility::_ID19765( var_0.leadersound, var_0._ID19770, 1 );
            else
                maps\mp\_utility::_ID19765( var_0.leadersound );
        }

        self notify( "actionNotifyMessage" + var_1 );
        self endon( "actionNotifyMessage" + var_1 );
        wait(var_3 + 0.5);
        self.doingsplash[var_1] = undefined;
    }

    if ( self.splashqueue[var_1].size )
    {
        thread dispatchnotify( var_1 );
        return;
    }
}

_ID35600( var_0 )
{
    var_1 = 0.05;

    while ( !canreadtext() )
        wait(var_1);

    while ( var_0 > 0 )
    {
        wait(var_1);

        if ( canreadtext() )
            var_0 -= var_1;
    }
}

canreadtext()
{
    if ( maps\mp\_flashgrenades::_ID18627() )
        return 0;

    return 1;
}

_ID26132()
{
    self endon( "notifyMessageDone" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "death" );
    _ID26129();
}

resetoncancel()
{
    self notify( "resetOnCancel" );
    self endon( "resetOnCancel" );
    self endon( "notifyMessageDone" );
    self endon( "disconnect" );
    level waittill( "cancel_notify" );
    _ID26129();
}

_ID26129()
{
    self._ID22325.alpha = 0;
    self.notifytext.alpha = 0;
    self._ID22310.alpha = 0;
    self.notifyoverlay.alpha = 0;
    self.doingsplash[0] = undefined;
    self.doingsplash[1] = undefined;
    self.doingsplash[2] = undefined;
    self.doingsplash[3] = undefined;
}

_ID16993()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "death" );

        if ( isdefined( self.hintmessage ) )
            self.hintmessage maps\mp\gametypes\_hud_util::destroyelem();
    }
}

_ID20388()
{
    self endon( "disconnect" );
    self._ID20387 = [];
    var_0 = "default";

    if ( isdefined( level._ID20386 ) )
        var_0 = level._ID20386;

    var_1 = level._ID20390;
    var_2 = level.lowertextfontsize;
    var_3 = 1.25;

    if ( level.splitscreen || self issplitscreenplayer() && !isai( self ) )
    {
        var_1 -= 40;
        var_2 = level.lowertextfontsize * 1.3;
        var_3 *= 1.5;
    }

    self._ID20385 = maps\mp\gametypes\_hud_util::createfontstring( var_0, var_2 );
    self._ID20385 settext( "" );
    self._ID20385.archived = 0;
    self._ID20385.sort = 10;
    self._ID20385.showinkillcam = 0;
    self._ID20385 maps\mp\gametypes\_hud_util::_ID28836( "CENTER", level._ID20391, 0, var_1 );
    self._ID20392 = maps\mp\gametypes\_hud_util::createfontstring( "default", var_3 );
    self._ID20392 maps\mp\gametypes\_hud_util::_ID28815( self._ID20385 );
    self._ID20392 maps\mp\gametypes\_hud_util::_ID28836( "TOP", "BOTTOM", 0, 0 );
    self._ID20392 settext( "" );
    self._ID20392.archived = 0;
    self._ID20392.sort = 10;
    self._ID20392.showinkillcam = 0;
}

_ID23076( var_0 )
{
    if ( level._ID32653 )
    {
        if ( var_0 == "tie" )
        {
            matchoutcomenotify( "draw" );
            return;
        }

        if ( var_0 == self.team )
        {
            matchoutcomenotify( "victory" );
            return;
        }

        matchoutcomenotify( "defeat" );
        return;
        return;
        return;
    }

    if ( var_0 == self )
    {
        matchoutcomenotify( "victory" );
        return;
    }

    matchoutcomenotify( "defeat" );
    return;
    return;
}

matchoutcomenotify( var_0 )
{
    var_1 = self.team;
    var_2 = maps\mp\gametypes\_hud_util::createfontstring( "bigfixed", 1.0 );
    var_2 maps\mp\gametypes\_hud_util::_ID28836( "TOP", undefined, 0, 50 );
    var_2.foreground = 1;
    var_2.glowalpha = 1;
    var_2.hidewheninmenu = 0;
    var_2.archived = 0;
    var_2 settext( game["strings"][var_0] );
    var_2.alpha = 0;
    var_2 fadeovertime( 0.5 );
    var_2.alpha = 1;

    switch ( var_0 )
    {
        case "victory":
            var_2.glowcolor = game["colors"]["cyan"];
            break;
        default:
            var_2.glowcolor = game["colors"]["orange"];
            break;
    }

    var_3 = maps\mp\gametypes\_hud_util::_ID8444( game["icons"][var_1], 64, 64 );
    var_3 maps\mp\gametypes\_hud_util::_ID28815( var_2 );
    var_3 maps\mp\gametypes\_hud_util::_ID28836( "TOP", "BOTTOM", 0, 30 );
    var_3.foreground = 1;
    var_3.hidewheninmenu = 0;
    var_3.archived = 0;
    var_3.alpha = 0;
    var_3 fadeovertime( 0.5 );
    var_3.alpha = 1;
    wait 3.0;
    var_2 maps\mp\gametypes\_hud_util::destroyelem();
    var_3 maps\mp\gametypes\_hud_util::destroyelem();
}

_ID18607()
{
    if ( isdefined( self.doingsplash[0] ) )
        return 1;

    if ( isdefined( self.doingsplash[1] ) )
        return 1;

    if ( isdefined( self.doingsplash[2] ) )
        return 1;

    if ( isdefined( self.doingsplash[3] ) )
        return 1;

    return 0;
}

_ID32671( var_0, var_1, var_2 )
{
    self endon( "disconnect" );
    self notify( "reset_outcome" );
    self setclientomnvar( "ui_round_end_update_data", 0 );
    self setclientomnvar( "ui_round_end", 1 );
    wait 0.5;
    var_3 = self.pers["team"];

    if ( self ismlgspectator() )
        var_3 = self getmlgspectatorteam();

    if ( !isdefined( var_3 ) || var_3 != "allies" && var_3 != "axis" )
        var_3 = "allies";

    while ( _ID18607() )
        wait 0.05;

    self endon( "reset_outcome" );

    if ( var_0 == "halftime" )
    {
        self setclientomnvar( "ui_round_end_title", game["round_end"]["halftime"] );
        var_0 = "allies";
    }
    else if ( var_0 == "intermission" )
    {
        self setclientomnvar( "ui_round_end_title", game["round_end"]["intermission"] );
        var_0 = "allies";
    }
    else if ( var_0 == "roundend" )
    {
        self setclientomnvar( "ui_round_end_title", game["round_end"]["roundend"] );
        var_0 = "allies";
    }
    else if ( var_0 == "overtime" )
    {
        self setclientomnvar( "ui_round_end_title", game["round_end"]["overtime"] );
        var_0 = "allies";
    }
    else if ( var_0 == "tie" )
    {
        if ( var_1 )
            self setclientomnvar( "ui_round_end_title", game["round_end"]["round_draw"] );
        else
            self setclientomnvar( "ui_round_end_title", game["round_end"]["draw"] );

        var_0 = "allies";
    }
    else if ( self ismlgspectator() )
        self setclientomnvar( "ui_round_end_title", game["round_end"]["spectator"] );
    else if ( isdefined( self.pers["team"] ) && var_0 == var_3 )
    {
        if ( var_1 )
            self setclientomnvar( "ui_round_end_title", game["round_end"]["round_win"] );
        else
            self setclientomnvar( "ui_round_end_title", game["round_end"]["victory"] );
    }
    else if ( var_1 )
        self setclientomnvar( "ui_round_end_title", game["round_end"]["round_loss"] );
    else
        self setclientomnvar( "ui_round_end_title", game["round_end"]["defeat"] );

    self setclientomnvar( "ui_round_end_reason", var_2 );

    if ( !maps\mp\_utility::_ID18768() || !maps\mp\_utility::_ID18716() || level._ID14086 == "Blitz" )
    {
        self setclientomnvar( "ui_round_end_friendly_score", maps\mp\gametypes\_gamescore::_ID1699( var_3 ) );
        self setclientomnvar( "ui_round_end_enemy_score", maps\mp\gametypes\_gamescore::_ID1699( level._ID23070[var_3] ) );
    }
    else
    {
        self setclientomnvar( "ui_round_end_friendly_score", game["roundsWon"][var_3] );
        self setclientomnvar( "ui_round_end_enemy_score", game["roundsWon"][level._ID23070[var_3]] );
    }

    if ( isdefined( self._ID20665 ) )
        self setclientomnvar( "ui_round_end_match_bonus", self._ID20665 );

    self setclientomnvar( "ui_round_end_update_data", 1 );
}

_ID23075( var_0, var_1 )
{
    self endon( "disconnect" );
    self notify( "reset_outcome" );
    self setclientomnvar( "ui_round_end_update_data", 0 );
    self setclientomnvar( "ui_round_end", 1 );
    wait 0.5;

    while ( _ID18607() )
        wait 0.05;

    self endon( "reset_outcome" );
    var_2 = level._ID23663["all"];
    var_3 = var_2[0];
    var_4 = var_2[1];
    var_5 = var_2[2];
    var_6 = 0;

    if ( isdefined( var_3 ) && self.score == var_3.score && self.deaths == var_3.deaths )
    {
        if ( self != var_3 )
            var_6 = 1;
        else if ( isdefined( var_4 ) && var_4.score == var_3.score && var_4.deaths == var_3.deaths )
            var_6 = 1;
    }

    if ( var_6 )
        self setclientomnvar( "ui_round_end_title", game["round_end"]["tie"] );
    else if ( isdefined( var_3 ) && self == var_3 )
        self setclientomnvar( "ui_round_end_title", game["round_end"]["victory"] );
    else
        self setclientomnvar( "ui_round_end_title", game["round_end"]["defeat"] );

    self setclientomnvar( "ui_round_end_reason", var_1 );

    if ( isdefined( self._ID20665 ) )
        self setclientomnvar( "ui_round_end_match_bonus", self._ID20665 );

    self setclientomnvar( "ui_round_end_update_data", 1 );
    self waittill( "update_outcome" );
}

_ID6653( var_0 )
{

}

_ID14778()
{
    if ( maps\mp\_utility::_ID18363() )
        return "mp/alien/splashTable.csv";

    return "mp/splashTable.csv";
}
