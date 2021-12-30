// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    precachevehicle( "attack_littlebird_mp" );
    precachemodel( "vehicle_apache_mp" );
    precachemodel( "vehicle_apache_mg" );
    precacheturret( "apache_minigun_mp" );
    precachevehicle( "apache_strafe_mp" );
    level._ID19256["littlebird_flock"] = ::_ID33855;
    level.heli_flock = [];
}

_ID33855( var_0, var_1 )
{
    var_2 = 5;

    if ( _ID16729() || maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 + var_2 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        return 0;
    }

    maps\mp\_utility::_ID17543();
    maps\mp\_utility::_ID17543();
    maps\mp\_utility::_ID17543();
    maps\mp\_utility::_ID17543();
    maps\mp\_utility::_ID17543();
    var_3 = _ID28033( var_0, "littlebird_flock" );

    if ( !isdefined( var_3 ) || !var_3 )
    {
        maps\mp\_utility::decrementfauxvehiclecount();
        maps\mp\_utility::decrementfauxvehiclecount();
        maps\mp\_utility::decrementfauxvehiclecount();
        maps\mp\_utility::decrementfauxvehiclecount();
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    level thread maps\mp\_utility::_ID32672( "used_littlebird_flock", self, self.team );
    return 1;
}

_ID16729()
{
    var_0 = 0;

    for ( var_1 = 0; var_1 < level.heli_flock.size; var_1++ )
    {
        if ( isdefined( level.heli_flock[var_1] ) )
        {
            var_0 = 1;
            break;
        }
    }

    return var_0;
}

_ID28033( var_0, var_1 )
{
    self playlocalsound( game["voice"][self.team] + "KS_lbd_inposition" );
    maps\mp\_utility::_beginlocationselection( var_1, "map_artillery_selector", 1, 500 );
    self endon( "stop_location_selection" );
    self waittill( "confirm_location",  var_2, var_3  );

    if ( _ID16729() || maps\mp\_utility::_ID8679() >= maps\mp\_utility::maxvehiclesallowed() || level._ID12791 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_VEHICLES" );
        self notify( "cancel_location" );
        return 0;
    }

    level.heli_flock = [];
    level.heli_flock_victims = [];
    thread littlebirdmadeselectionvo();
    thread _ID12956( var_0, var_2, ::callstrike, var_3 );
    self setblurforplayer( 0, 0.3 );
    return 1;
}

littlebirdmadeselectionvo()
{
    self endon( "death" );
    self endon( "disconnect" );
    self playlocalsound( game["voice"][self.team] + "KS_hqr_littlebird" );
    wait 3.0;
    self playlocalsound( game["voice"][self.team] + "KS_lbd_inbound" );
}

_ID12956( var_0, var_1, var_2, var_3 )
{
    self notify( "used" );
    wait 0.05;
    thread maps\mp\_utility::stoplocationselection( 0 );

    if ( isdefined( self ) )
        self thread [[ var_2 ]]( var_0, var_1, var_3 );
}

callstrike( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    thread handleownerleft();
    var_3 = _ID15022( var_1, var_2, 0 );
    var_4 = _ID15022( var_1, var_2, -520 );
    var_5 = _ID15022( var_1, var_2, 520 );
    var_6 = _ID15022( var_1, var_2, -1040 );
    var_7 = _ID15022( var_1, var_2, 1040 );
    level thread dolbstrike( var_0, self, var_3, 0 );
    wait 0.3;
    level thread dolbstrike( var_0, self, var_4, 1 );
    level thread dolbstrike( var_0, self, var_5, 2 );
    wait 0.3;
    level thread dolbstrike( var_0, self, var_6, 3 );
    level thread dolbstrike( var_0, self, var_7, 4 );
    maps\mp\_matchdata::_ID20253( "littlebird_flock", var_1 );
}

_ID15022( var_0, var_1, var_2 )
{
    var_0 *= ( 1, 1, 0 );
    var_3 = ( 0, var_1, 0 );
    var_4 = 12000;
    var_5 = [];

    if ( isdefined( var_2 ) && var_2 != 0 )
        var_0 = var_0 + anglestoright( var_3 ) * var_2 + ( 0, 0, randomint( 300 ) );

    var_6 = var_0 + anglestoforward( var_3 ) * ( -1 * var_4 );
    var_7 = var_0 + anglestoforward( var_3 ) * var_4;
    var_8 = maps\mp\killstreaks\_airdrop::_ID15024( var_0 ) + 256;
    var_5["start"] = var_6 + ( 0, 0, var_8 );
    var_5["end"] = var_7 + ( 0, 0, var_8 );
    return var_5;
}

dolbstrike( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );

    if ( !isdefined( var_1 ) )
        return;

    var_4 = vectortoangles( var_2["end"] - var_2["start"] );
    var_5 = _ID30818( var_1, var_2["start"], var_4, var_3 );
    var_5._ID19938 = var_0;
    var_5._ID3210 = 0;
    var_5 thread _ID36142();
    var_5 thread _ID36054();
    var_5 thread flock_handledamage();
    var_5 thread _ID31455();
    var_5 thread monitorkills();
    var_5 endon( "death" );
    var_5 setmaxpitchroll( 120, 60 );
    var_5 vehicle_setspeed( 48, 48 );
    var_5 setvehgoalpos( var_2["end"], 0 );
    var_5 waittill( "goal" );
    var_5 setmaxpitchroll( 30, 40 );
    var_5 vehicle_setspeed( 32, 32 );
    var_5 setvehgoalpos( var_2["start"], 0 );
    wait 2;
    var_5 setmaxpitchroll( 100, 60 );
    var_5 vehicle_setspeed( 64, 64 );
    var_5 waittill( "goal" );
    var_5 notify( "gone" );
    var_5 maps\mp\killstreaks\_helicopter::_ID26014();
}

_ID30818( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnhelicopter( var_0, var_1, var_2, "apache_strafe_mp", "vehicle_apache_mp" );

    if ( !isdefined( var_4 ) )
        return;

    var_4 maps\mp\killstreaks\_helicopter::addtolittlebirdlist();
    var_4 thread maps\mp\killstreaks\_helicopter::_ID26000();
    var_4.health = 999999;
    var_4.maxhealth = 2000;
    var_4.damagetaken = 0;
    var_4 setcandamage( 1 );
    var_4.owner = var_0;
    var_4.team = var_0.team;
    var_4._ID19219 = 0;
    var_4._ID31889 = "littlebird_flock";
    var_4._ID16760 = "littlebird";
    var_4._ID30953 = ::callback_vehicledamage;
    var_5 = spawnturret( "misc_turret", var_4.origin, "apache_minigun_mp" );
    var_5 linkto( var_4, "tag_turret", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_5 setmodel( "vehicle_apache_mg" );
    var_5.angles = var_4.angles;
    var_5.owner = var_4.owner;
    var_5.team = var_5.owner.team;
    var_5 maketurretinoperable();
    var_5._ID34941 = var_4;
    var_6 = var_4.origin + ( anglestoforward( var_4.angles ) * -200 + anglestoright( var_4.angles ) * -200 ) + ( 0, 0, 50 );
    var_5._ID19214 = spawn( "script_model", var_6 );
    var_5._ID19214 setscriptmoverkillcam( "explosive" );
    var_5._ID19214 linkto( var_4, "tag_origin" );
    var_4._ID21004 = var_5;
    var_4._ID21004 setdefaultdroppitch( 0 );
    var_4._ID21004 setmode( "auto_nonai" );
    var_4._ID21004 setsentryowner( var_4.owner );

    if ( level._ID32653 )
        var_4._ID21004 setturretteam( var_4.owner.team );

    level.heli_flock[var_3] = var_4;
    return var_4;
}

_ID36142()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self endon( "death" );
    maps\mp\gametypes\_hostmigration::_ID35597( 60.0 );
    self notify( "death" );
}

monitorkills()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self endon( "death" );
    self endon( "stopFiring" );

    for (;;)
    {
        self waittill( "killedPlayer",  var_0  );
        self._ID19219++;
        level.heli_flock_victims[level.heli_flock_victims.size] = var_0;
    }
}

_ID31455()
{
    self endon( "gone" );
    self endon( "death" );
    self endon( "stopFiring" );

    for (;;)
    {
        self._ID21004 waittill( "turret_on_target" );
        var_0 = 1;
        var_1 = self._ID21004 getturrettarget( 0 );

        foreach ( var_3 in level.heli_flock_victims )
        {
            if ( var_1 == var_3 )
            {
                self._ID21004 cleartargetentity();
                var_0 = 0;
                break;
            }
        }

        if ( var_0 )
            self._ID21004 shootturret();
    }
}

handleownerleft()
{
    level endon( "game_ended" );
    self endon( "flock_done" );
    thread _ID22315();
    self waittill( "killstreak_disowned" );

    for ( var_0 = 0; var_0 < level.heli_flock.size; var_0++ )
    {
        if ( isdefined( level.heli_flock[var_0] ) )
            level.heli_flock[var_0] notify( "stopFiring" );
    }

    for ( var_0 = 0; var_0 < level.heli_flock.size; var_0++ )
    {
        if ( isdefined( level.heli_flock[var_0] ) )
        {
            level.heli_flock[var_0] notify( "death" );
            wait 0.1;
        }
    }
}

_ID22315()
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    if ( !maps\mp\_utility::bot_is_fireteam_mode() )
    {
        self endon( "joined_team" );
        self endon( "joined_spectators" );
    }

    while ( _ID16729() )
        wait 0.5;

    self notify( "flock_done" );
}

flock_handledamage()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9  );

        if ( isdefined( self._ID30953 ) )
            self [[ self._ID30953 ]]( undefined, var_1, var_0, var_8, var_4, var_9, var_3, var_2, undefined, undefined, var_5, var_7 );
    }
}

callback_vehicledamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    if ( isdefined( self._ID3210 ) && self._ID3210 )
        return;

    if ( !isdefined( var_1 ) || var_1 == self )
        return;

    if ( !maps\mp\gametypes\_weapons::_ID13695( self.owner, var_1 ) )
        return;

    if ( isdefined( var_3 ) && var_3 & level.idflags_penetration )
        self._ID35910 = 1;

    self._ID35908 = 1;
    var_12 = var_2;

    if ( isplayer( var_1 ) )
    {
        var_1 maps\mp\gametypes\_damagefeedback::_ID34528( "helicopter" );

        if ( var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET" )
        {
            if ( var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
                var_12 += var_2 * level.armorpiercingmod;
        }
    }

    if ( isdefined( var_1.owner ) && isplayer( var_1.owner ) )
        var_1.owner maps\mp\gametypes\_damagefeedback::_ID34528( "helicopter" );

    if ( isdefined( var_5 ) )
    {
        switch ( var_5 )
        {
            case "stinger_mp":
            case "remote_mortar_missile_mp":
            case "javelin_mp":
            case "ac130_105mm_mp":
            case "ac130_40mm_mp":
            case "remotemissile_projectile_mp":
                self._ID19345 = 1;
                var_12 = self.maxhealth + 1;
                break;
            case "sam_projectile_mp":
                self._ID19345 = 1;
                var_12 = self.maxhealth * 0.25;
                break;
            case "emp_grenade_mp":
                self._ID19345 = 0;
                var_12 = self.maxhealth + 1;
                break;
        }

        maps\mp\killstreaks\_killstreaks::_ID19257( var_1, var_5, self );
    }

    self.damagetaken = self.damagetaken + var_12;

    if ( self.damagetaken >= self.maxhealth )
    {
        if ( isplayer( var_1 ) && ( !isdefined( self.owner ) || var_1 != self.owner ) )
        {
            self._ID3210 = 1;
            var_1 notify( "destroyed_helicopter" );
            var_1 notify( "destroyed_killstreak",  var_5  );
            thread maps\mp\_utility::_ID32672( "callout_destroyed_helicopter", var_1 );
            var_1 thread maps\mp\gametypes\_rank::giverankxp( "kill", 300, var_5, var_4 );
            var_1 thread maps\mp\gametypes\_rank::_ID36462( "destroyed_helicopter" );
            thread maps\mp\gametypes\_missions::vehiclekilled( self.owner, self, undefined, var_1, var_2, var_4, var_5 );
        }

        self notify( "death" );
    }
}

_ID36054()
{
    self endon( "gone" );
    self waittill( "death" );
    thread maps\mp\killstreaks\_helicopter::_ID19722();
}
