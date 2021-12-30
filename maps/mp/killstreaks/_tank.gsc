// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    return;
}

spawnarmor( var_0, var_1, var_2 )
{
    var_3 = self vehicle_dospawn( "tank", var_0 );
    var_3.health = 3000;
    var_3._ID32609 = 1;
    var_3.team = var_0.team;
    var_3.pers["team"] = var_3.team;
    var_3.owner = var_0;
    var_3 setcandamage( 1 );
    var_3.standardspeed = 12;
    var_3 thread _ID9619();
    var_3 addtotanklist();
    var_3.damagecallback = ::callback_vehicledamage;
    return var_3;
}

_ID9619()
{
    self endon( "death" );
    var_0 = self.origin[2];

    for (;;)
    {
        if ( var_0 - self.origin[2] > 2048 )
        {
            self.health = 0;
            self notify( "death" );
            return;
        }

        wait 1.0;
    }
}

_ID34776( var_0 )
{
    return _ID33879();
}

_ID33879()
{
    if ( isdefined( level._ID32557 ) && level._ID32557 )
    {
        self iprintlnbold( "Armor support unavailable." );
        return 0;
    }

    if ( !isdefined( getvehiclenode( "startnode", "targetname" ) ) )
    {
        self iprintlnbold( "Tank is currently not supported in this level, bug your friendly neighborhood LD." );
        return 0;
    }

    if ( !vehicle_getspawnerarray().size )
        return 0;

    if ( self.team == "allies" )
        var_0 = level._ID32564["allies"] spawnarmor( self, "vehicle_bradley" );
    else
        var_0 = level._ID32564["axis"] spawnarmor( self, "vehicle_bmp" );

    var_0 _ID31478();
    return 1;
}

_ID31478( var_0 )
{
    var_1 = getvehiclenode( "startnode", "targetname" );
    var_2 = getvehiclenode( "waitnode", "targetname" );
    self.nodes = getvehiclenodearray( "info_vehicle_node", "classname" );
    level._ID32557 = 1;
    thread tankupdate( var_1, var_2 );
    thread _ID32546();
    level._ID32426 = self;

    if ( level._ID32653 )
    {
        var_3 = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add( var_3, "invisible", ( 0, 0, 0 ) );
        objective_team( var_3, "allies" );
        level._ID32426._ID22495["allies"] = var_3;
        var_4 = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add( var_4, "invisible", ( 0, 0, 0 ) );
        objective_team( var_4, "axis" );
        level._ID32426._ID22495["axis"] = var_4;
        var_5 = self.team;
        level._ID32426.team = var_5;
        level._ID32426.pers["team"] = var_5;
    }

    var_6 = spawnturret( "misc_turret", self.origin, "abrams_minigun_mp" );
    var_6 linkto( self, "tag_engine_left", ( 0, 0, -20 ), ( 0, 0, 0 ) );
    var_6 setmodel( "sentry_minigun" );
    var_6.angles = self.angles;
    var_6.owner = self.owner;
    var_6 maketurretinoperable();
    self._ID21003 = var_6;
    self._ID21003 setdefaultdroppitch( 0 );
    var_7 = self.angles;
    self.angles = ( 0, 0, 0 );
    var_8 = self gettagorigin( "tag_flash" );
    self.angles = var_7;
    var_9 = var_8 - self.origin;
    thread waitforchangeteams();
    thread _ID35551();
    self._ID33053 = gettime();
    var_10 = spawn( "script_origin", self gettagorigin( "tag_flash" ) );
    var_10 linkto( self, "tag_origin", var_9, ( 0, 0, 0 ) );
    var_10 hide();
    self._ID21925 = var_10;
    thread _ID32556();
    thread _ID9818();
    thread _ID32554();
    thread _ID7066();
    thread _ID36081();
}

waitforchangeteams()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    self.owner waittill( "joined_team" );
    self.health = 0;
    self notify( "death" );
}

_ID35551()
{
    self endon( "death" );
    self.owner waittill( "disconnect" );
    self.health = 0;
    self notify( "death" );
}

setdirection( var_0 )
{
    if ( self.veh_pathdir != var_0 )
    {
        if ( var_0 == "forward" )
            _ID31860();
        else
            _ID31861();
    }
}

_ID28717()
{
    self endon( "death" );
    self notify( "path_abandoned" );

    while ( isdefined( self._ID6884 ) )
        wait 0.05;

    var_0 = 2;
    self vehicle_setspeed( var_0, 10, 10 );
    self._ID30985 = "engage";
}

_ID28784()
{
    self endon( "death" );
    self notify( "path_abandoned" );

    while ( isdefined( self._ID6884 ) )
        wait 0.05;

    var_0 = 2;
    self vehicle_setspeed( var_0, 10, 10 );
    self._ID30985 = "engage";
}

setstandardspeed()
{
    self endon( "death" );

    while ( isdefined( self._ID6884 ) )
        wait 0.05;

    self vehicle_setspeed( self.standardspeed, 10, 10 );
    self._ID30985 = "standard";
}

_ID28719()
{
    self endon( "death" );

    while ( isdefined( self._ID6884 ) )
        wait 0.05;

    self vehicle_setspeed( 15, 15, 15 );
    self._ID30985 = "evade";
    wait 1.5;
    self vehicle_setspeed( self.standardspeed, 10, 10 );
}

_ID28689()
{
    self endon( "death" );

    while ( isdefined( self._ID6884 ) )
        wait 0.05;

    self vehicle_setspeed( 5, 5, 5 );
    self._ID30985 = "danger";
}

_ID31861()
{
    debugprintln2( "tank changing direction at " + gettime() );
    self vehicle_setspeed( 0, 5, 6 );
    self._ID6884 = 1;

    while ( self.veh_speed > 0 )
        wait 0.05;

    wait 0.25;
    self._ID6884 = undefined;
    debugprintln2( "tank done changing direction" );
    self.veh_transmission = "reverse";
    self.veh_pathdir = "reverse";
    self vehicle_setspeed( self.standardspeed, 5, 6 );
}

_ID31860()
{
    debugprintln2( "tank changing direction at " + gettime() );
    self vehicle_setspeed( 0, 5, 6 );
    self._ID6884 = 1;

    while ( self.veh_speed > 0 )
        wait 0.05;

    wait 0.25;
    self._ID6884 = undefined;
    debugprintln2( "tank done changing direction" );
    self.veh_transmission = "forward";
    self.veh_pathdir = "forward";
    self vehicle_setspeed( self.standardspeed, 5, 6 );
}

_ID7066()
{
    self endon( "death" );
    var_0 = [];
    var_1 = level.players;
    self.numenemiesclose = 0;

    for (;;)
    {
        foreach ( var_3 in var_1 )
        {
            if ( !isdefined( var_3 ) )
                continue;

            if ( var_3.team == self.team )
            {
                wait 0.05;
                continue;
            }

            var_4 = distance2d( var_3.origin, self.origin );

            if ( var_4 < 2048 )
                self.numenemiesclose++;

            wait 0.05;
        }

        if ( isdefined( self._ID30985 ) && ( self._ID30985 == "evade" || self._ID30985 == "engage" ) )
        {
            self.numenemiesclose = 0;
            continue;
        }

        if ( self.numenemiesclose > 1 )
            thread _ID28689();
        else
            thread setstandardspeed();

        self.numenemiesclose = 0;
        wait 0.05;
    }
}

tankupdate( var_0, var_1 )
{
    self endon( "tankDestroyed" );
    self endon( "death" );

    if ( !isdefined( level._ID15764 ) )
    {
        self startpath( var_0 );
        return;
    }

    self attachpath( var_0 );
    self startpath( var_0 );
    var_0 notify( "trigger",  self, 1  );
    wait 0.05;

    for (;;)
    {
        while ( isdefined( self._ID6884 ) )
            wait 0.05;

        var_2 = _ID15183();

        if ( isdefined( var_2 ) )
            self._ID11740 = var_2;
        else
            self._ID11740 = undefined;

        wait 0.65;
    }
}

callback_vehicledamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    if ( ( var_1 == self || var_1 == self._ID21003 || isdefined( var_1.pers ) && var_1.pers["team"] == self.team ) && ( var_1 != self.owner || var_4 == "MOD_MELEE" ) )
        return;

    var_12 = modifydamage( var_4, var_2, var_1 );
    self vehicle_finishdamage( var_0, var_1, var_12, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );
}

_ID32546()
{
    self endon( "death" );
    self.damagetaken = 0;
    var_0 = self vehicle_getspeed();
    var_1 = self.health;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;

    for (;;)
    {
        self waittill( "damage",  var_5, var_6, var_7, var_8, var_9  );

        if ( isdefined( var_6.classname ) && var_6.classname == "script_vehicle" )
        {
            if ( isdefined( self._ID5126 ) && self._ID5126 != var_6 )
            {
                self.forcedtarget = var_6;
                thread explicitabandontarget();
            }
        }
        else if ( isplayer( var_6 ) )
        {
            var_6 maps\mp\gametypes\_damagefeedback::_ID34528( "hitHelicopter" );

            if ( var_6 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
            {
                var_10 = var_5 * level.armorpiercingmod;
                self.health = self.health - int( var_10 );
            }
        }

        if ( self.health <= 0 )
        {
            self notify( "death" );
            return;
        }
        else if ( self.health < var_1 / 4 && var_4 == 0 )
            var_4 = 1;
        else if ( self.health < var_1 / 2 && var_3 == 0 )
            var_3 = 1;
        else if ( self.health < var_1 / 1.5 && var_2 == 0 )
            var_2 = 1;

        if ( var_5 > 1000 )
            _ID16284( var_6 );
    }
}

_ID16284( var_0 )
{
    self endon( "death" );
    var_1 = randomint( 100 );

    if ( isdefined( self._ID5126 ) && self._ID5126 != var_0 && var_1 > 30 )
    {
        var_2 = [];
        var_2[0] = self._ID5126;
        explicitabandontarget( 1, self._ID5126 );
        thread acquiretarget( var_2 );
    }
    else if ( !isdefined( self._ID5126 ) && var_1 > 30 )
    {
        var_2 = [];
        var_2[0] = var_0;
        thread acquiretarget( var_2 );
    }
    else if ( var_1 < 30 )
    {
        playfx( level._ID32545, self.origin );
        thread _ID28719();
    }
    else
    {
        self fireweapon();
        self playsound( "bmp_fire" );
    }
}

_ID16274( var_0 )
{
    self endon( "death" );
    var_1 = _ID25730( var_0 );
    var_2 = distance( self.origin, var_0.origin );

    if ( randomint( 4 ) < 3 )
        return;

    if ( var_1 == "front" && var_2 < 768 )
        thread _ID28719();
    else if ( var_1 == "rear_side" || var_1 == "rear" && var_2 >= 768 )
    {
        playfx( level._ID32545, self.origin );
        thread _ID28719();
    }
    else if ( var_1 == "rear" && var_2 < 768 )
    {
        _ID31861();
        _ID28719();
        wait 4;
        _ID31860();
    }
    else if ( var_1 == "front_side" || var_1 == "front" )
    {
        playfx( level._ID32545, self.origin );
        _ID31861();
        _ID28719();
        wait 8;
        _ID31860();
    }
}

_ID25730( var_0 )
{
    self endon( "death" );
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_1 = anglestoforward( self.angles );
    var_2 = var_0.origin - self.origin;
    var_1 *= ( 1, 1, 0 );
    var_2 *= ( 1, 1, 0 );
    var_2 = vectornormalize( var_2 );
    var_1 = vectornormalize( var_1 );
    var_3 = vectordot( var_2, var_1 );

    if ( var_3 > 0 )
    {
        if ( var_3 > 0.9 )
            return "front";
        else
            return "front_side";
    }
    else if ( var_3 < -0.9 )
        return "rear";
    else
        return "rear_side";

    var_0 iprintlnbold( var_3 );
}

_ID36081()
{
    self endon( "death" );

    for (;;)
    {
        var_0 = [];
        var_1 = level.players;

        foreach ( var_3 in var_1 )
        {
            if ( !isdefined( var_3 ) )
            {
                wait 0.05;
                continue;
            }

            if ( !_ID18814( var_3 ) )
            {
                wait 0.05;
                continue;
            }

            var_4 = var_3 getcurrentweapon();

            if ( issubstr( var_4, "at4" ) || issubstr( var_4, "stinger" ) || issubstr( var_4, "javelin" ) )
            {
                thread _ID16274( var_3 );
                wait 8;
            }

            wait 0.15;
        }
    }
}

checkowner()
{
    if ( !isdefined( self.owner ) || !isdefined( self.owner.pers["team"] ) || self.owner.pers["team"] != self.team )
    {
        self notify( "abandoned" );
        return 0;
    }

    return 1;
}

modifydamage( var_0, var_1, var_2 )
{
    if ( var_0 == "MOD_RIFLE_BULLET" )
        return var_1;
    else if ( var_0 == "MOD_PISTOL_BULLET" )
        return var_1;
    else if ( var_0 == "MOD_IMPACT" )
        return var_1;
    else if ( var_0 == "MOD_MELEE" )
        return 0;
    else if ( var_0 == "MOD_EXPLOSIVE_BULLET" )
        return var_1;
    else if ( var_0 == "MOD_GRENADE" )
        return var_1 * 5;
    else if ( var_0 == "MOD_GRENADE_SPLASH" )
        return var_1 * 5;
    else
        return var_1 * 10;
}

_ID9818()
{
    self waittill( "death" );

    if ( level._ID32653 )
    {
        var_0 = level._ID32426.team;
        objective_state( level._ID32426._ID22495[var_0], "invisible" );
        objective_state( level._ID32426._ID22495[level._ID23070[var_0]], "invisible" );
    }

    self notify( "tankDestroyed" );
    self vehicle_setspeed( 0, 10, 10 );
    level._ID32557 = 0;
    playfx( level._ID30843, self.origin );
    playfx( level._ID32550, self.origin );
    removefromtanklist();
    var_1 = spawn( "script_model", self.origin );
    var_1 setmodel( "vehicle_m1a1_abrams_d_static" );
    var_1.angles = self.angles;
    self._ID21003 delete();
    self delete();
    wait 4;
    var_1 delete();
}

onhitpitchclamp()
{
    self notify( "onTargOrTimeOut" );
    self endon( "onTargOrTimeOut" );
    self endon( "turret_on_target" );
    self waittill( "turret_pitch_clamped" );
    thread explicitabandontarget( 0, self._ID5126 );
}

fireontarget()
{
    self endon( "abandonedTarget" );
    self endon( "killedTarget" );
    self endon( "death" );
    self endon( "targetRemoved" );
    self endon( "lostLOS" );

    for (;;)
    {
        onhitpitchclamp();

        if ( !isdefined( self._ID5126 ) )
            continue;

        var_0 = self gettagorigin( "tag_flash" );
        var_1 = bullettrace( self.origin, var_0, 0, self );

        if ( var_1["position"] != var_0 )
            thread explicitabandontarget( 0, self._ID5126 );

        var_1 = bullettrace( var_0, self._ID5126.origin, 1, self );
        var_2 = distance( self.origin, var_1["position"] );
        var_3 = distance( self._ID5126.origin, self.origin );

        if ( var_2 < 384 || var_2 + 256 < var_3 )
        {
            wait 0.5;

            if ( var_2 > 384 )
            {
                _ID35581();
                self fireweapon();
                self playsound( "bmp_fire" );
                self._ID33053 = gettime();
            }

            var_4 = _ID25730( self._ID5126 );
            thread explicitabandontarget( 0, self._ID5126 );
            return;
        }

        _ID35581();
        self fireweapon();
        self playsound( "bmp_fire" );
        self._ID33053 = gettime();
    }
}

_ID35581()
{
    self endon( "abandonedTarget" );
    self endon( "killedTarget" );
    self endon( "death" );
    self endon( "targetRemoved" );
    self endon( "lostLOS" );
    var_0 = gettime() - self._ID33053;

    if ( var_0 < 1499 )
        wait(1.5 - var_0 / 1000);
}

_ID32556( var_0 )
{
    self endon( "death" );
    self endon( "leaving" );
    var_1 = [];

    for (;;)
    {
        var_1 = [];
        var_2 = level.players;

        if ( isdefined( self.forcedtarget ) )
        {
            var_1 = [];
            var_1[0] = self.forcedtarget;
            acquiretarget( var_1 );
            self.forcedtarget = undefined;
        }

        if ( isdefined( level._ID16320 ) && level._ID16320.team != self.team && isalive( level._ID16320 ) )
        {
            if ( _ID18865( level._ID32426 ) )
                var_1[var_1.size] = level._ID32426;
        }

        if ( isdefined( level.chopper ) && level.chopper.team != self.team && isalive( level.chopper ) )
        {
            if ( _ID18865( level.chopper ) )
                var_1[var_1.size] = level.chopper;
        }

        foreach ( var_4 in var_2 )
        {
            if ( !isdefined( var_4 ) )
            {
                wait 0.05;
                continue;
            }

            if ( isdefined( var_0 ) && var_4 == var_0 )
                continue;

            if ( _ID18814( var_4 ) )
            {
                if ( isdefined( var_4 ) )
                    var_1[var_1.size] = var_4;

                continue;
            }

            continue;
        }

        if ( var_1.size > 0 )
        {
            acquiretarget( var_1 );
            continue;
        }

        wait 1;
    }
}

acquiretarget( var_0 )
{
    self endon( "death" );

    if ( var_0.size == 1 )
        self._ID5126 = var_0[0];
    else
        self._ID5126 = getbesttarget( var_0 );

    thread _ID28717();
    thread _ID36138( var_0 );
    self setturrettargetent( self._ID5126 );
    fireontarget();
    thread _ID28797();
}

_ID28797()
{
    self endon( "death" );
    setstandardspeed();
    _ID26034();
    self setturrettargetent( self._ID21925 );
}

getbesttarget( var_0 )
{
    self endon( "death" );
    var_1 = self gettagorigin( "tag_flash" );
    var_2 = self.origin;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = 0;

    foreach ( var_7 in var_0 )
    {
        var_8 = abs( vectortoangles( var_7.origin - self.origin )[1] );
        var_9 = abs( self gettagangles( "tag_flash" )[1] );
        var_8 = abs( var_8 - var_9 );

        if ( isdefined( level.chopper ) && var_7 == level.chopper )
            return var_7;

        if ( isdefined( level._ID16320 ) && var_7 == level._ID16320 )
            return var_7;

        var_10 = var_7 getweaponslistitems();

        foreach ( var_12 in var_10 )
        {
            if ( issubstr( var_12, "at4" ) || issubstr( var_12, "jav" ) || issubstr( var_12, "c4" ) )
                var_8 -= 40;
        }

        if ( !isdefined( var_3 ) )
        {
            var_3 = var_8;
            var_4 = var_7;
            continue;
        }

        if ( var_3 > var_8 )
        {
            var_3 = var_8;
            var_4 = var_7;
        }
    }

    return var_4;
}

_ID36138( var_0 )
{
    self endon( "abandonedTarget" );
    self endon( "lostLOS" );
    self endon( "death" );
    self endon( "targetRemoved" );
    var_1 = self._ID5126;
    var_1 endon( "disconnect" );
    var_1 waittill( "death" );
    self notify( "killedTarget" );
    _ID26034();
    setstandardspeed();
    thread _ID28797();
}

explicitabandontarget( var_0, var_1 )
{
    self endon( "death" );
    self notify( "abandonedTarget" );
    setstandardspeed();
    thread _ID28797();
    _ID26034();

    if ( isdefined( var_1 ) )
    {
        self.badtarget = var_1;
        badtargetreset();
    }

    if ( isdefined( var_0 ) && var_0 )
        return;

    return;
}

badtargetreset()
{
    self endon( "death" );
    wait 1.5;
    self.badtarget = undefined;
}

_ID26034()
{
    self notify( "targetRemoved" );
    self._ID5126 = undefined;
    self._ID19578 = undefined;
}

_ID18865( var_0 )
{
    if ( distance2d( var_0.origin, self.origin ) > 4096 )
        return 0;

    if ( distance( var_0.origin, self.origin ) < 512 )
        return 0;

    return _ID34101( var_0, 0 );
}

_ID18814( var_0 )
{
    self endon( "death" );
    var_1 = distancesquared( var_0.origin, self.origin );

    if ( !level._ID32653 && isdefined( self.owner ) && var_0 == self.owner )
        return 0;

    if ( !isalive( var_0 ) || var_0.sessionstate != "playing" )
        return 0;

    if ( var_1 > 16777216 )
        return 0;

    if ( var_1 < 262144 )
        return 0;

    if ( !isdefined( var_0.pers["team"] ) )
        return 0;

    if ( var_0 == self.owner )
        return 0;

    if ( level._ID32653 && var_0.pers["team"] == self.team )
        return 0;

    if ( var_0.pers["team"] == "spectator" )
        return 0;

    if ( isdefined( var_0._ID30916 ) && ( gettime() - var_0._ID30916 ) / 1000 <= 5 )
        return 0;

    if ( var_0 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
        return 0;

    return self vehicle_canturrettargetpoint( var_0.origin, 1, self );
}

_ID34101( var_0, var_1 )
{
    var_2 = var_0 sightconetrace( self gettagorigin( "tag_turret" ), self );

    if ( var_2 < 0.7 )
        return 0;

    if ( isdefined( var_1 ) && var_1 )
        thread maps\mp\_utility::_ID10878( var_0.origin, self gettagorigin( "tag_turret" ), 10, ( 1, 0, 0 ) );

    return 1;
}

isminitarget( var_0 )
{
    self endon( "death" );

    if ( !isalive( var_0 ) || var_0.sessionstate != "playing" )
        return 0;

    if ( !isdefined( var_0.pers["team"] ) )
        return 0;

    if ( var_0 == self.owner )
        return 0;

    if ( distancesquared( var_0.origin, self.origin ) > 1048576 )
        return 0;

    if ( level._ID32653 && var_0.pers["team"] == self.team )
        return 0;

    if ( var_0.pers["team"] == "spectator" )
        return 0;

    if ( isdefined( var_0._ID30916 ) && ( gettime() - var_0._ID30916 ) / 1000 <= 5 )
        return 0;

    if ( isdefined( self ) )
    {
        var_1 = self._ID21003.origin + ( 0, 0, 64 );
        var_2 = var_0 sightconetrace( var_1, self );

        if ( var_2 < 1 )
            return 0;
    }

    return 1;
}

_ID32554()
{
    self endon( "death" );
    self endon( "leaving" );
    var_0 = [];

    for (;;)
    {
        var_0 = [];
        var_1 = level.players;

        for ( var_2 = 0; var_2 <= var_1.size; var_2++ )
        {
            if ( isminitarget( var_1[var_2] ) )
            {
                if ( isdefined( var_1[var_2] ) )
                    var_0[var_0.size] = var_1[var_2];
            }
            else
                continue;

            wait 0.05;
        }

        if ( var_0.size > 0 )
        {
            acquireminitarget( var_0 );
            return;
            continue;
        }

        wait 0.5;
    }
}

getbestminitarget( var_0 )
{
    self endon( "death" );
    var_1 = self.origin;
    var_2 = undefined;
    var_3 = undefined;

    foreach ( var_5 in var_0 )
    {
        var_6 = distance( self.origin, var_5.origin );
        var_7 = var_5 getcurrentweapon();

        if ( issubstr( var_7, "at4" ) || issubstr( var_7, "jav" ) || issubstr( var_7, "c4" ) || issubstr( var_7, "smart" ) || issubstr( var_7, "grenade" ) )
            var_6 -= 200;

        if ( !isdefined( var_2 ) )
        {
            var_2 = var_6;
            var_3 = var_5;
            continue;
        }

        if ( var_2 > var_6 )
        {
            var_2 = var_6;
            var_3 = var_5;
        }
    }

    return var_3;
}

acquireminitarget( var_0 )
{
    self endon( "death" );

    if ( var_0.size == 1 )
        self.bestminitarget = var_0[0];
    else
        self.bestminitarget = getbestminitarget( var_0 );

    if ( distance2d( self.origin, self.bestminitarget.origin ) > 768 )
        thread _ID28784();

    self notify( "acquiringMiniTarget" );
    self._ID21003 settargetentity( self.bestminitarget, ( 0, 0, 64 ) );
    wait 0.15;
    thread _ID13068();
    thread _ID36099( var_0 );
    thread _ID36100( var_0 );
    thread _ID36101( self.bestminitarget );
}

_ID13068()
{
    self endon( "death" );
    self endon( "abandonedMiniTarget" );
    self endon( "killedMiniTarget" );
    var_0 = undefined;
    var_1 = gettime();

    if ( !isdefined( self.bestminitarget ) )
        return;

    for (;;)
    {
        if ( !isdefined( self._ID21003 getturrettarget( 1 ) ) )
        {
            if ( !isdefined( var_0 ) )
                var_0 = gettime();

            var_2 = gettime();

            if ( var_0 - var_2 > 1 )
            {
                var_0 = undefined;
                thread explicitabandonminitarget();
                return;
            }

            wait 0.5;
            continue;
        }

        if ( gettime() > var_1 + 1000 && !isdefined( self._ID5126 ) )
        {
            if ( distance2d( self.origin, self.bestminitarget.origin ) > 768 )
            {
                var_3[0] = self.bestminitarget;
                acquiretarget( var_3 );
            }
        }

        var_4 = randomintrange( 10, 16 );

        for ( var_5 = 0; var_5 < var_4; var_5++ )
        {
            self._ID21003 shootturret();
            wait 0.1;
        }

        wait(randomfloatrange( 0.5, 3.0 ));
    }
}

_ID36099( var_0 )
{
    self endon( "abandonedMiniTarget" );
    self endon( "death" );

    if ( !isdefined( self.bestminitarget ) )
        return;

    self.bestminitarget waittill( "death" );
    self notify( "killedMiniTarget" );
    self.bestminitarget = undefined;
    self._ID21003 cleartargetentity();
    _ID32554();
}

_ID36100( var_0 )
{
    self endon( "abandonedMiniTarget" );
    self endon( "death" );

    for (;;)
    {
        if ( !isdefined( self.bestminitarget ) )
            return;

        var_1 = bullettrace( self._ID21003.origin, self.bestminitarget.origin, 0, self );
        var_2 = distance( self.origin, var_1["position"] );

        if ( var_2 > 1024 )
        {
            thread explicitabandonminitarget();
            return;
        }

        wait 2;
    }
}

_ID36101( var_0 )
{
    self endon( "abandonedMiniTarget" );
    self endon( "death" );
    self endon( "killedMiniTarget" );

    for (;;)
    {
        var_1 = [];
        var_2 = level.players;

        for ( var_3 = 0; var_3 <= var_2.size; var_3++ )
        {
            if ( isminitarget( var_2[var_3] ) )
            {
                if ( !isdefined( var_2[var_3] ) )
                    continue;

                if ( !isdefined( var_0 ) )
                    return;

                var_4 = distance( self.origin, var_0.origin );
                var_5 = distance( self.origin, var_2[var_3].origin );

                if ( var_5 < var_4 )
                {
                    thread explicitabandonminitarget();
                    return;
                }
            }

            wait 0.05;
        }

        wait 0.25;
    }
}

explicitabandonminitarget( var_0 )
{
    self notify( "abandonedMiniTarget" );
    self.bestminitarget = undefined;
    self._ID21003 cleartargetentity();

    if ( isdefined( var_0 ) && var_0 )
        return;

    thread _ID32554();
    return;
}

addtotanklist()
{
    level._ID32558[self getentitynumber()] = self;
}

removefromtanklist()
{
    level._ID32558[self getentitynumber()] = undefined;
}

_ID15183()
{
    var_0 = [];

    foreach ( var_2 in level.players )
    {
        if ( var_2.team == "spectator" )
            continue;

        if ( var_2.team == self.team )
            continue;

        if ( !isalive( var_2 ) )
            continue;

        var_2._ID10230 = 0;
        var_0[var_0.size] = var_2;
    }

    if ( !var_0.size )
        return undefined;

    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        for ( var_5 = var_4 + 1; var_5 < var_0.size; var_5++ )
        {
            var_6 = distancesquared( var_0[var_4].origin, var_0[var_5].origin );
            var_0[var_4]._ID10230 = var_0[var_4]._ID10230 + var_6;
            var_0[var_5]._ID10230 = var_0[var_5]._ID10230 + var_6;
        }
    }

    var_7 = var_0[0];

    foreach ( var_2 in var_0 )
    {
        if ( var_2._ID10230 < var_7._ID10230 )
            var_7 = var_2;
    }

    var_10 = var_7.origin;
    var_11 = sortbydistance( level._ID15764, var_10 );
    return var_11[0];
}

setuppaths()
{
    var_0 = [];
    var_1 = [];
    var_2 = [];
    var_3 = [];
    var_4 = getvehiclenode( "startnode", "targetname" );
    var_0[var_0.size] = var_4;
    var_1[var_1.size] = var_4;

    while ( isdefined( var_4.target ) )
    {
        var_5 = var_4;
        var_4 = getvehiclenode( var_4.target, "targetname" );
        var_4._ID24916 = var_5;

        if ( var_4 == var_0[0] )
            break;

        var_0[var_0.size] = var_4;

        if ( !isdefined( var_4.target ) )
            return;
    }

    var_0[0].branchnodes = [];
    var_0[0] thread handlebranchnode( "forward" );
    var_3[var_3.size] = var_0[0];
    var_6 = getvehiclenodearray( "branchnode", "targetname" );

    foreach ( var_8 in var_6 )
    {
        var_4 = var_8;
        var_0[var_0.size] = var_4;
        var_1[var_1.size] = var_4;

        while ( isdefined( var_4.target ) )
        {
            var_5 = var_4;
            var_4 = getvehiclenode( var_4.target, "targetname" );
            var_0[var_0.size] = var_4;
            var_4._ID24916 = var_5;

            if ( !isdefined( var_4.target ) )
                var_2[var_2.size] = var_4;
        }
    }

    foreach ( var_4 in var_0 )
    {
        var_11 = 0;

        foreach ( var_13 in var_1 )
        {
            if ( var_13 == var_4 )
                continue;

            if ( var_13.target == var_4.targetname )
                continue;

            if ( isdefined( var_4.target ) && var_4.target == var_13.targetname )
                continue;

            if ( distance2d( var_4.origin, var_13.origin ) > 80 )
                continue;

            var_13 thread _ID16242( var_4, "reverse" );
            var_13._ID24916 = var_4;

            if ( !isdefined( var_4.branchnodes ) )
                var_4.branchnodes = [];

            var_4.branchnodes[var_4.branchnodes.size] = var_13;
            var_11 = 1;
        }

        if ( var_11 )
            var_4 thread handlebranchnode( "forward" );

        var_15 = 0;

        foreach ( var_17 in var_2 )
        {
            if ( var_17 == var_4 )
                continue;

            if ( !isdefined( var_4.target ) )
                continue;

            if ( var_4.target == var_17.targetname )
                continue;

            if ( isdefined( var_17.target ) && var_17.target == var_4.targetname )
                continue;

            if ( distance2d( var_4.origin, var_17.origin ) > 80 )
                continue;

            var_17 thread _ID16242( var_4, "forward" );
            var_17.next = getvehiclenode( var_4.targetname, "targetname" );
            var_17.length = distance( var_17.origin, var_4.origin );

            if ( !isdefined( var_4.branchnodes ) )
                var_4.branchnodes = [];

            var_4.branchnodes[var_4.branchnodes.size] = var_17;
            var_15 = 1;
        }

        if ( var_15 )
            var_4 thread handlebranchnode( "reverse" );

        if ( var_15 || var_11 )
            var_3[var_3.size] = var_4;
    }

    if ( var_3.size < 3 )
    {
        level notify( "end_tankPathHandling" );
        return;
    }

    var_20 = [];

    foreach ( var_4 in var_0 )
    {
        if ( !isdefined( var_4.branchnodes ) )
            continue;

        var_20[var_20.size] = var_4;
    }

    foreach ( var_24 in var_20 )
    {
        var_4 = var_24;
        var_25 = 0;

        while ( isdefined( var_4.target ) )
        {
            var_26 = var_4;
            var_4 = getvehiclenode( var_4.target, "targetname" );
            var_25 += distance( var_4.origin, var_26.origin );

            if ( var_4 == var_24 )
                break;

            if ( isdefined( var_4.branchnodes ) )
                break;
        }

        if ( var_25 > 1000 )
        {
            var_4 = var_24;
            var_27 = 0;

            while ( isdefined( var_4.target ) )
            {
                var_26 = var_4;
                var_4 = getvehiclenode( var_4.target, "targetname" );
                var_27 += distance( var_4.origin, var_26.origin );

                if ( var_27 < var_25 / 2 )
                    continue;

                var_4.branchnodes = [];
                var_4 thread handlebranchnode( "forward" );
                var_3[var_3.size] = var_4;
                break;
            }
        }
    }

    level._ID15764 = _ID17977( var_3 );

    foreach ( var_4 in var_0 )
    {
        if ( !isdefined( var_4._ID15763 ) )
            var_4 thread _ID22106();
    }
}

_ID15285( var_0 )
{
    var_1 = [];

    foreach ( var_4, var_3 in self.links )
    {
        if ( self._ID20017[var_4] != var_0 )
            continue;

        var_1[var_1.size] = var_3;
    }

    return var_1[randomint( var_1.size )];
}

_ID15171( var_0, var_1 )
{
    var_2 = level._ID15764[self._ID15763];
    var_3 = _ID14207( var_2, var_0, undefined, var_1 );
    var_4 = var_3[0]._ID14039;
    var_5 = _ID14207( var_2, var_0, undefined, level.otherdir[var_1] );
    var_6 = var_5[0]._ID14039;

    if ( !getdvarint( "tankDebug" ) )
        var_6 = 9999999;

    if ( var_4 <= var_6 )
        return var_3[1];
}

handlebranchnode( var_0 )
{
    level endon( "end_tankPathHandling" );

    for (;;)
    {
        self waittill( "trigger",  var_1, var_2  );
        var_3 = level._ID15764[self._ID15763];
        var_1.node = self;
        var_4 = undefined;

        if ( isdefined( var_1._ID11740 ) && var_1._ID11740 != var_3 )
        {
            var_4 = _ID15171( var_1._ID11740, var_1.veh_pathdir );

            if ( !isdefined( var_4 ) )
                var_1 thread setdirection( level.otherdir[var_1.veh_pathdir] );
        }

        if ( !isdefined( var_4 ) || var_4 == var_3 )
            var_4 = var_3 _ID15285( var_1.veh_pathdir );

        var_5 = var_3.linkstartnodes[var_4._ID15763];

        if ( var_1.veh_pathdir == "forward" )
            var_6 = _ID15170();
        else
            var_6 = _ID15270();

        if ( var_6 != var_5 )
            var_1 startpath( var_5 );
    }
}

_ID16242( var_0, var_1 )
{
    for (;;)
    {
        self waittill( "trigger",  var_2  );

        if ( var_2.veh_pathdir != var_1 )
            continue;

        debugprintln2( "tank starting path at join node: " + var_0._ID15763 );
        var_2 startpath( var_0 );
    }
}

_ID22106()
{
    self.forwardgraphid = _ID15027()._ID15763;
    self._ID26256 = getreversegraphnode()._ID15763;

    for (;;)
    {
        self waittill( "trigger",  var_0, var_1  );
        var_0.node = self;
        var_0.forwardgraphid = self.forwardgraphid;
        var_0._ID26256 = self._ID26256;

        if ( !isdefined( self.target ) || self.targetname == "branchnode" )
            var_2 = "TRANS";
        else
            var_2 = "NODE";

        if ( isdefined( var_1 ) )
        {
            debugprint3d( self.origin, var_2, ( 1, 0.5, 0 ), 1, 2, 100 );
            continue;
        }

        debugprint3d( self.origin, var_2, ( 0, 1, 0 ), 1, 2, 100 );
    }
}

forcetrigger( var_0, var_1, var_2 )
{
    var_1 endon( "trigger" );
    var_0 endon( "trigger" );
    var_2 endon( "death" );
    var_3 = distancesquared( var_2.origin, var_1.origin );
    var_4 = var_2.veh_pathdir;
    debugprint3d( var_0.origin + ( 0, 0, 30 ), "LAST", ( 0, 0, 1 ), 0.5, 1, 100 );
    debugprint3d( var_1.origin + ( 0, 0, 60 ), "NEXT", ( 0, 1, 0 ), 0.5, 1, 100 );
    var_5 = 0;

    for (;;)
    {
        wait 0.05;

        if ( var_4 != var_2.veh_pathdir )
        {
            debugprintln2( "tank missed node: reversing direction" );
            var_2 thread forcetrigger( var_1, var_0, var_2 );
            return;
        }

        if ( var_5 )
        {
            debugprintln2( "... sending notify." );
            var_1 notify( "trigger",  var_2, 1  );
            return;
        }

        var_6 = distancesquared( var_2.origin, var_1.origin );

        if ( var_6 > var_3 )
        {
            var_5 = 1;
            debugprintln2( "tank missed node: forcing notify in one frame..." );
        }

        var_3 = var_6;
    }
}

_ID15027()
{
    for ( var_0 = self; !isdefined( var_0._ID15763 ); var_0 = var_0 _ID15170() )
    {

    }

    return var_0;
}

getreversegraphnode()
{
    for ( var_0 = self; !isdefined( var_0._ID15763 ); var_0 = var_0 _ID15270() )
    {

    }

    return var_0;
}

_ID15170()
{
    if ( isdefined( self.target ) )
        return getvehiclenode( self.target, "targetname" );
    else
        return self.next;
}

_ID15270()
{
    return self._ID24916;
}

_ID17977( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        var_4 = spawnstruct();
        var_4._ID20032 = [];
        var_4.links = [];
        var_4._ID20033 = [];
        var_4._ID20017 = [];
        var_4.linkstartnodes = [];
        var_4.node = var_3;
        var_4.origin = var_3.origin;
        var_4._ID15763 = var_1.size;
        var_3._ID15763 = var_1.size;
        debugprint3d( var_4.origin + ( 0, 0, 80 ), var_4._ID15763, ( 1, 1, 1 ), 0.65, 2, 100000 );
        var_1[var_1.size] = var_4;
    }

    foreach ( var_3 in var_0 )
    {
        var_7 = var_3._ID15763;
        var_8 = getvehiclenode( var_3.target, "targetname" );
        var_9 = distance( var_3.origin, var_8.origin );
        var_10 = var_8;

        while ( !isdefined( var_8._ID15763 ) )
        {
            var_9 += distance( var_8.origin, var_8._ID24916.origin );

            if ( isdefined( var_8.target ) )
            {
                var_8 = getvehiclenode( var_8.target, "targetname" );
                continue;
            }

            var_8 = var_8.next;
        }

        var_1[var_7] addlinknode( var_1[var_8._ID15763], var_9, "forward", var_10 );
        var_8 = var_3._ID24916;
        var_9 = distance( var_3.origin, var_8.origin );

        for ( var_10 = var_8; !isdefined( var_8._ID15763 ); var_8 = var_8._ID24916 )
            var_9 += distance( var_8.origin, var_8._ID24916.origin );

        var_1[var_7] addlinknode( var_1[var_8._ID15763], var_9, "reverse", var_10 );

        foreach ( var_12 in var_3.branchnodes )
        {
            var_8 = var_12;
            var_9 = distance( var_3.origin, var_8.origin );
            var_10 = var_8;

            if ( var_8.targetname == "branchnode" )
            {
                while ( !isdefined( var_8._ID15763 ) )
                {
                    if ( isdefined( var_8.target ) )
                        var_13 = getvehiclenode( var_8.target, "targetname" );
                    else
                        var_13 = var_8.next;

                    var_9 += distance( var_8.origin, var_13.origin );
                    var_8 = var_13;
                }

                var_1[var_7] addlinknode( var_1[var_8._ID15763], var_9, "forward", var_10 );
                continue;
            }

            while ( !isdefined( var_8._ID15763 ) )
            {
                var_9 += distance( var_8.origin, var_8._ID24916.origin );
                var_8 = var_8._ID24916;
            }

            var_1[var_7] addlinknode( var_1[var_8._ID15763], var_9, "reverse", var_10 );
        }
    }

    return var_1;
}

addlinknode( var_0, var_1, var_2, var_3 )
{
    self.links[var_0._ID15763] = var_0;
    self._ID20033[var_0._ID15763] = var_1;
    self._ID20017[var_0._ID15763] = var_2;
    self.linkstartnodes[var_0._ID15763] = var_3;
    var_4 = spawnstruct();
    var_4._ID33109 = var_0;
    var_4._ID33108 = var_0._ID15763;
    var_4.length = var_1;
    var_4.direction = var_2;
    var_4.startnode = var_3;
    self._ID20032[var_0._ID15763] = var_4;
}

_ID14207( var_0, var_1, var_2, var_3 )
{
    level._ID22960 = [];
    level.closedlist = [];
    var_4 = 0;
    var_5 = [];

    if ( !isdefined( var_2 ) )
        var_2 = [];

    var_1._ID14039 = 0;
    var_1._ID15977 = gethvalue( var_1, var_0 );
    var_1._ID12561 = var_1._ID14039 + var_1._ID15977;
    addtoclosedlist( var_1 );
    var_6 = var_1;

    for (;;)
    {
        foreach ( var_9, var_8 in var_6.links )
        {
            if ( _ID18435( var_2, var_8 ) )
                continue;

            if ( _ID18435( level.closedlist, var_8 ) )
                continue;

            if ( isdefined( var_3 ) && var_8._ID20017[var_6._ID15763] != var_3 )
                continue;

            if ( !_ID18435( level._ID22960, var_8 ) )
            {
                addtoopenlist( var_8 );
                var_8._ID23272 = var_6;
                var_8._ID14039 = getgvalue( var_8, var_6 );
                var_8._ID15977 = gethvalue( var_8, var_0 );
                var_8._ID12561 = var_8._ID14039 + var_8._ID15977;

                if ( var_8 == var_0 )
                    var_4 = 1;

                continue;
            }

            if ( var_8._ID14039 < getgvalue( var_6, var_8 ) )
                continue;

            var_8._ID23272 = var_6;
            var_8._ID14039 = getgvalue( var_8, var_6 );
            var_8._ID12561 = var_8._ID14039 + var_8._ID15977;
        }

        if ( var_4 )
            break;

        addtoclosedlist( var_6 );
        var_10 = level._ID22960[0];

        foreach ( var_12 in level._ID22960 )
        {
            if ( var_12._ID12561 > var_10._ID12561 )
                continue;

            var_10 = var_12;
        }

        addtoclosedlist( var_10 );
        var_6 = var_10;
    }

    for ( var_6 = var_0; var_6 != var_1; var_6 = var_6._ID23272 )
        var_5[var_5.size] = var_6;

    var_5[var_5.size] = var_6;
    return var_5;
}

addtoopenlist( var_0 )
{
    var_0._ID22961 = level._ID22960.size;
    level._ID22960[level._ID22960.size] = var_0;
    var_0._ID7573 = undefined;
}

addtoclosedlist( var_0 )
{
    if ( isdefined( var_0._ID7573 ) )
        return;

    var_0._ID7573 = level.closedlist.size;
    level.closedlist[level.closedlist.size] = var_0;

    if ( !_ID18435( level._ID22960, var_0 ) )
        return;

    level._ID22960[var_0._ID22961] = level._ID22960[level._ID22960.size - 1];
    level._ID22960[var_0._ID22961]._ID22961 = var_0._ID22961;
    level._ID22960[level._ID22960.size - 1] = undefined;
    var_0._ID22961 = undefined;
}

gethvalue( var_0, var_1 )
{
    return distance( var_0.node.origin, var_1.node.origin );
}

getgvalue( var_0, var_1 )
{
    return var_0._ID23272._ID14039 + var_0._ID20033[var_1._ID15763];
}

_ID18435( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        if ( var_0[var_2] == var_1 )
            return 1;
    }

    return 0;
}

drawpath( var_0 )
{
    for ( var_1 = 1; var_1 < var_0.size; var_1++ )
    {
        var_2 = var_0[var_1 - 1];
        var_3 = var_0[var_1];

        if ( var_2._ID20017[var_3._ID15763] == "reverse" )
            level thread _ID10879( var_2.node.origin, var_3.node.origin, ( 1, 0, 0 ) );
        else
            level thread _ID10879( var_2.node.origin, var_3.node.origin, ( 0, 1, 0 ) );

        var_4 = var_2.linkstartnodes[var_3._ID15763];
        level thread _ID10879( var_2.node.origin + ( 0, 0, 4 ), var_4.origin + ( 0, 0, 4 ), ( 0, 0, 1 ) );

        if ( var_2._ID20017[var_3._ID15763] == "reverse" )
        {
            while ( !isdefined( var_4._ID15763 ) )
            {
                var_5 = var_4;
                var_4 = var_4._ID24916;
                level thread _ID10879( var_5.origin + ( 0, 0, 4 ), var_4.origin + ( 0, 0, 4 ), ( 0, 1, 1 ) );
            }

            continue;
        }

        while ( !isdefined( var_4._ID15763 ) )
        {
            var_5 = var_4;

            if ( isdefined( var_4.target ) )
                var_4 = getvehiclenode( var_4.target, "targetname" );
            else
                var_4 = var_4.next;

            level thread _ID10879( var_5.origin + ( 0, 0, 4 ), var_4.origin + ( 0, 0, 4 ), ( 0, 1, 1 ) );
        }
    }
}

drawgraph( var_0 )
{

}

_ID10879( var_0, var_1, var_2 )
{
    level endon( "endpath" );

    for (;;)
        wait 0.05;
}

debugprintln2( var_0 )
{

}

_ID9257( var_0 )
{

}

debugprint3d( var_0, var_1, var_2, var_3, var_4, var_5 )
{

}

_ID10894()
{

}
