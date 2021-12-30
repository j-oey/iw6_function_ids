// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19212 = maps\mp\gametypes\_tweakables::_ID15451( "game", "allowkillcam" );
}

_ID28673( var_0, var_1, var_2 )
{
    self setclientomnvar( "cam_scene_name", var_0 );
    self setclientomnvar( "cam_scene_lead", var_1 );
    self setclientomnvar( "cam_scene_support", var_2 );
}

_ID28766( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_5._ID6511 = "unknown";

    if ( isdefined( var_1 ) && isdefined( var_1.agent_type ) )
    {
        if ( var_1.agent_type == "dog" || var_1.agent_type == "wolf" )
        {
            _ID28673( "killcam_dog", var_0 getentitynumber(), var_3 getentitynumber() );
            var_5._ID6511 = "killcam_dog";
        }
        else if ( var_1.agent_type == "beastmen" )
        {
            _ID28673( "killcam_agent_firstperson", var_0 getentitynumber(), var_3 getentitynumber() );
            var_5._ID6511 = "killcam_agent_firstperson";
        }
        else
        {
            _ID28673( "killcam_agent", var_0 getentitynumber(), var_3 getentitynumber() );
            var_5._ID6511 = "killcam_agent";
        }

        return 1;
    }
    else if ( var_4 > 0 )
    {
        _ID28673( "unknown", -1, -1 );
        return 0;
    }
    else
    {
        _ID28673( "unknown", -1, -1 );
        return 0;
    }

    return 0;
}

_ID33730( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = var_5 + var_6;

    if ( isdefined( var_8 ) && var_9 > var_8 )
    {
        if ( var_8 < 2 )
            return;

        if ( var_8 - var_5 >= 1 )
            var_6 = var_8 - var_5;
        else
        {
            var_6 = 1;
            var_5 = var_8 - 1;
        }

        var_9 = var_5 + var_6;
    }

    var_10 = var_5 + var_7;

    if ( isdefined( var_1 ) && isdefined( var_1.lastspawntime ) )
        var_11 = var_1.lastspawntime;
    else
    {
        var_11 = var_2.lastspawntime;

        if ( isdefined( var_2._ID9101 ) )
        {
            if ( gettime() - var_2._ID9101 < var_6 * 1000.0 )
            {
                var_6 = 1.0;
                var_6 -= 0.05;
                var_9 = var_5 + var_6;
            }
        }
    }

    var_12 = ( gettime() - var_11 ) / 1000.0;

    if ( var_10 > var_12 && var_12 > var_7 )
    {
        var_13 = var_12 - var_7;

        if ( var_5 > var_13 )
        {
            var_5 = var_13;
            var_9 = var_5 + var_6;
            var_10 = var_5 + var_7;
        }
    }

    var_14 = spawnstruct();
    var_14.camtime = var_5;
    var_14._ID24788 = var_6;
    var_14._ID19216 = var_9;
    var_14._ID19217 = var_10;
    return var_14;
}

prekillcamnotify( var_0, var_1 )
{
    if ( isdefined( var_1 ) && !isagent( var_1 ) )
    {
        self loadcustomizationplayerview( var_1 );
        return;
    }
}

_ID19212( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 )
{
    self endon( "disconnect" );
    self endon( "spawned" );
    level endon( "game_ended" );

    if ( var_2 < 0 || !isdefined( var_10 ) )
        return;

    level._ID22415++;

    if ( level._ID22415 > 1 )
        wait(0.05 * ( level._ID22415 - 1 ));

    wait 0.05;
    level._ID22415--;

    if ( getdvar( "scr_killcam_time" ) == "" )
    {
        if ( var_5 == "artillery_mp" || var_5 == "stealth_bomb_mp" || var_5 == "warhawk_mortar_mp" )
            var_13 = ( gettime() - var_4 ) / 1000 - var_6 - 0.1;
        else if ( var_5 == "remote_mortar_missile_mp" )
            var_13 = 6.5;
        else if ( level._ID29973 )
            var_13 = 4.0;
        else if ( var_5 == "apache_minigun_mp" )
            var_13 = 3.0;
        else if ( var_5 == "javelin_mp" )
            var_13 = 8;
        else if ( issubstr( var_5, "remotemissile_" ) )
            var_13 = 5;
        else if ( isdefined( var_0._ID28174 ) && var_0._ID28174 == "multiturret" )
            var_13 = 2.0;
        else if ( isdefined( var_0.carestrike ) )
            var_13 = 2.0;
        else if ( !var_8 || var_8 > 5.0 )
            var_13 = 5.0;
        else if ( var_5 == "frag_grenade_mp" || var_5 == "frag_grenade_short_mp" || var_5 == "semtex_mp" || var_5 == "semtexproj_mp" || var_5 == "thermobaric_grenade_mp" || var_5 == "mortar_shell__mp" )
            var_13 = 4.25;
        else
            var_13 = 2.5;
    }
    else
        var_13 = getdvarfloat( "scr_killcam_time" );

    if ( isdefined( var_9 ) )
    {
        if ( var_13 > var_9 )
            var_13 = var_9;

        if ( var_13 < 0.05 )
            var_13 = 0.05;
    }

    if ( getdvar( "scr_killcam_posttime" ) == "" )
        var_14 = 2;
    else
    {
        var_14 = getdvarfloat( "scr_killcam_posttime" );

        if ( var_14 < 0.05 )
            var_14 = 0.05;
    }

    if ( var_2 < 0 || !isdefined( var_10 ) )
        return;

    var_15 = _ID33730( var_0, var_1, var_10, var_11, var_3, var_13, var_14, var_6, var_9 );

    if ( !isdefined( var_15 ) )
        return;

    self setclientomnvar( "ui_killcam_end_milliseconds", 0 );

    if ( isplayer( var_10 ) )
    {
        self setclientomnvar( "ui_killcam_killedby_id", var_10 getentitynumber() );
        self setclientomnvar( "ui_killcam_victim_id", var_11 getentitynumber() );
        self loadcustomizationplayerview( var_10 );
    }

    if ( maps\mp\_utility::_ID18679( var_5 ) )
    {
        if ( var_12 == "MOD_MELEE" && maps\mp\killstreaks\_killstreaks::isairdropmarker( var_5 ) )
        {
            var_16 = tablelookuprownum( "mp/statsTable.csv", 4, "iw6_knifeonly" );
            self setclientomnvar( "ui_killcam_killedby_weapon", var_16 );
            self setclientomnvar( "ui_killcam_killedby_killstreak", -1 );
        }
        else
        {
            var_17 = maps\mp\_utility::getkillstreakrownum( level._ID19276[var_5] );
            self setclientomnvar( "ui_killcam_killedby_killstreak", var_17 );
            self setclientomnvar( "ui_killcam_killedby_weapon", -1 );
            self setclientomnvar( "ui_killcam_killedby_attachment1", -1 );
            self setclientomnvar( "ui_killcam_killedby_attachment2", -1 );
            self setclientomnvar( "ui_killcam_killedby_attachment3", -1 );
            self setclientomnvar( "ui_killcam_killedby_attachment4", -1 );
        }
    }
    else
    {
        var_18 = [];
        var_19 = getweaponbasename( var_5 );

        if ( isdefined( var_19 ) )
        {
            if ( var_12 == "MOD_MELEE" && !maps\mp\gametypes\_weapons::_ID18766( var_5 ) )
                var_19 = "iw6_knifeonly";
            else
            {
                var_19 = maps\mp\_utility::_ID36268( var_19 );
                var_19 = maps\mp\_utility::_ID31978( var_19, "_mp" );
            }

            var_16 = tablelookuprownum( "mp/statsTable.csv", 4, var_19 );
            self setclientomnvar( "ui_killcam_killedby_weapon", var_16 );
            self setclientomnvar( "ui_killcam_killedby_killstreak", -1 );

            if ( var_19 != "iw6_knifeonly" )
                var_18 = getweaponattachments( var_5 );
        }
        else
        {
            self setclientomnvar( "ui_killcam_killedby_weapon", -1 );
            self setclientomnvar( "ui_killcam_killedby_killstreak", -1 );
        }

        for ( var_20 = 0; var_20 < 4; var_20++ )
        {
            if ( isdefined( var_18[var_20] ) )
            {
                var_21 = tablelookuprownum( "mp/attachmentTable.csv", 4, maps\mp\_utility::attachmentmap_tobase( var_18[var_20] ) );
                self setclientomnvar( "ui_killcam_killedby_attachment" + ( var_20 + 1 ), var_21 );
                continue;
            }

            self setclientomnvar( "ui_killcam_killedby_attachment" + ( var_20 + 1 ), -1 );
        }

        var_22 = [ 0, 0 ];
        var_23 = var_10.pers["loadoutPerks"];

        for ( var_20 = 0; var_20 < var_23.size; var_20++ )
        {
            var_24 = int( tablelookup( "mp/killCamAbilitiesBitMaskTable.csv", 1, var_23[var_20], 0 ) );

            if ( var_24 == 0 )
                continue;

            var_25 = int( ( var_24 - 1 ) / 24 );
            var_26 = 1 << ( var_24 - 1 ) % 24;
            var_22[var_25] |= var_26;
        }

        self setclientomnvar( "ui_killcam_killedby_abilities1", var_22[0] );
        self setclientomnvar( "ui_killcam_killedby_abilities2", var_22[1] );
    }

    var_27 = getdvarint( "scr_player_forcerespawn" );

    if ( var_8 && !level.gameended || isdefined( self ) && isdefined( self.battlebuddy ) && !level.gameended || var_27 == 0 && !level.gameended )
        self setclientomnvar( "ui_killcam_text", "skip" );
    else if ( !level.gameended )
        self setclientomnvar( "ui_killcam_text", "respawn" );
    else
        self setclientomnvar( "ui_killcam_text", "none" );

    var_28 = gettime();
    self notify( "begin_killcam",  var_28  );

    if ( !isagent( var_10 ) && isdefined( var_10 ) )
        var_10 visionsyncwithplayer( var_11 );

    maps\mp\_utility::_ID34608( "spectator", "hud_status_dead" );
    self.spectatekillcam = 1;

    if ( isagent( var_10 ) || isagent( var_0 ) )
    {
        var_2 = var_11 getentitynumber();
        var_7 -= 25;
    }

    self.forcespectatorclient = var_2;
    self.killcamentity = -1;
    var_29 = _ID28766( var_0, var_1, var_2, var_11, var_3, var_15 );

    if ( !var_29 )
        thread _ID28765( var_3, var_15._ID19217, var_4 );

    self.archivetime = var_15._ID19217;
    self._ID19216 = var_15._ID19216;
    self.psoffsettime = var_7;
    self allowspectateteam( "allies", 1 );
    self allowspectateteam( "axis", 1 );
    self allowspectateteam( "freelook", 1 );
    self allowspectateteam( "none", 1 );

    if ( level.multiteambased )
    {
        foreach ( var_31 in level._ID32668 )
            self allowspectateteam( var_31, 1 );
    }

    thread endedkillcamcleanup();
    wait 0.05;

    if ( !isdefined( self ) )
        return;

    if ( self.archivetime < var_15._ID19217 )
    {
        var_33 = var_15._ID19217 - self.archivetime;

        if ( game["truncated_killcams"] < 32 )
        {
            setmatchdata( "killcam", game["truncated_killcams"], var_33 );
            game["truncated_killcams"]++;
        }
    }

    var_15.camtime = self.archivetime - 0.05 - var_6;
    var_15._ID19216 = var_15.camtime + var_15._ID24788;
    self._ID19216 = var_15._ID19216;

    if ( var_15.camtime <= 0 )
    {
        maps\mp\_utility::_ID34608( "dead" );
        maps\mp\_utility::clearkillcamstate();
        self notify( "killcam_ended" );
        return;
    }

    var_34 = level._ID29973;
    self setclientomnvar( "ui_killcam_end_milliseconds", int( var_15._ID19216 * 1000 ) + gettime() );

    if ( var_34 )
        self setclientomnvar( "ui_killcam_victim_or_attacker", 1 );

    if ( var_34 )
        thread dofinalkillcamfx( var_15, self.killcamentity, var_10, var_11, var_12 );

    self._ID19212 = 1;

    if ( isdefined( self.battlebuddy ) && !level.gameended )
        self.battlebuddyrespawntimestamp = gettime();

    thread _ID30828();

    if ( !level._ID29973 )
        thread waitskipkillcambutton( var_8 );
    else
        self notify( "showing_final_killcam" );

    thread endkillcamifnothingtoshow();
    _ID35772();

    if ( level._ID29973 )
    {
        thread maps\mp\gametypes\_playerlogic::spawnendofgame();
        return;
    }

    thread calculatekillcamtime( var_28 );
    thread killcamcleanup( 1 );
}

dofinalkillcamfx( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "killcam_ended" );

    if ( isdefined( level._ID10589 ) )
        return;

    level._ID10589 = 1;
    var_5 = var_0.camtime;
    var_6 = 0;
    var_7 = var_3 getentitynumber();

    if ( !isdefined( var_0.attackernum ) )
        var_0.attackernum = var_2 getentitynumber();

    var_8 = var_5;

    if ( var_8 > 1.0 )
    {
        var_8 = 1.0;
        var_6 += 1.0;
        wait(var_5 - var_6);
    }

    setslowmotion( 1.0, 0.25, var_8 );
    wait(var_8 + 0.5);
    setslowmotion( 0.25, 1, 1 );
    level._ID10589 = undefined;
}

calculatekillcamtime( var_0 )
{
    var_1 = int( gettime() - var_0 );
    maps\mp\_utility::_ID17531( "killcamtimewatched", var_1 );
}

_ID35772()
{
    self endon( "abort_killcam" );
    wait(self._ID19216 - 0.05);
}

_ID28765( var_0, var_1, var_2 )
{
    self endon( "disconnect" );
    self endon( "killcam_ended" );
    var_3 = gettime() - var_1 * 1000;

    if ( var_2 > var_3 )
    {
        wait 0.05;
        var_1 = self.archivetime;
        var_3 = gettime() - var_1 * 1000;

        if ( var_2 > var_3 )
            wait(( var_2 - var_3 ) / 1000);
    }

    self.killcamentity = var_0;
}

waitskipkillcambutton( var_0 )
{
    self endon( "disconnect" );
    self endon( "killcam_ended" );

    if ( !isai( self ) )
    {
        self notifyonplayercommand( "kc_respawn", "+usereload" );
        self notifyonplayercommand( "kc_respawn", "+activate" );
        self waittill( "kc_respawn" );
        self._ID6560 = 1;

        if ( !maps\mp\_utility::_ID20673() )
            maps\mp\_utility::_ID17531( "killcamskipped", 1 );

        if ( var_0 <= 0 )
            maps\mp\_utility::_ID7495( "kc_info" );

        self notify( "abort_killcam" );
        return;
    }
}

endkillcamifnothingtoshow()
{
    self endon( "disconnect" );
    self endon( "killcam_ended" );

    for (;;)
    {
        if ( self.archivetime <= 0 )
            break;

        wait 0.05;
    }

    self notify( "abort_killcam" );
}

_ID30828()
{
    self endon( "disconnect" );
    self endon( "killcam_ended" );
    self waittill( "spawned" );
    thread killcamcleanup( 0 );
}

endedkillcamcleanup()
{
    self endon( "disconnect" );
    self endon( "killcam_ended" );
    level waittill( "game_ended" );
    thread killcamcleanup( 1 );
}

killcamcleanup( var_0 )
{
    self setclientomnvar( "ui_killcam_end_milliseconds", 0 );
    self._ID19212 = undefined;
    var_1 = level._ID29973;

    if ( !var_1 )
        _ID28673( "unknown", -1, -1 );

    if ( !level.gameended )
        maps\mp\_utility::_ID7495( "kc_info" );

    thread maps\mp\gametypes\_spectating::_ID28880();
    self notify( "killcam_ended" );

    if ( !var_0 )
        return;

    maps\mp\_utility::_ID34608( "dead" );
    maps\mp\_utility::clearkillcamstate();
}
