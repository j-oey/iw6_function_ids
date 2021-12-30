// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID16471 = 0.55;
    var_0 = 5;
    var_0 = maps\mp\gametypes\_tweakables::_ID15451( "player", "healthregentime" );
    level._ID24498 = var_0;
    level.healthregendisabled = level._ID24498 <= 0;
    level thread _ID22877();
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "spawned_player" );
        thread _ID24499();
        self visionsetthermalforplayer( game["thermal_vision"] );
    }
}

_ID24499()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    self endon( "faux_spawn" );
    level endon( "game_ended" );

    if ( self.health <= 0 )
        return;

    var_0 = 0;
    var_1 = 0;
    thread playerpainbreathingsound( self.maxhealth * 0.55 );

    for (;;)
    {
        self waittill( "damage" );

        if ( self.health <= 0 )
            return;

        if ( maps\mp\_utility::_ID18666() )
            continue;

        var_1 = gettime();
        var_2 = self.health / self.maxhealth;
        self._ID25671 = 1;

        if ( maps\mp\_utility::_hasperk( "specialty_regenfaster" ) )
            self._ID25671 = self._ID25671 * level.regenfastermod;
        else if ( maps\mp\_utility::_hasperk( "specialty_bloodrush" ) )
            self._ID25671 = self._ID25671 * self.bloodrushregenspeedmod;

        if ( var_2 <= level._ID16471 )
            self.atbrinkofdeath = 1;

        thread _ID16477( var_1, var_2 );
        thread breathingmanager( var_1, var_2 );
    }
}

breathingmanager( var_0, var_1 )
{
    self notify( "breathingManager" );
    self endon( "breathingManager" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    level endon( "game_ended" );

    if ( maps\mp\_utility::_ID18837() )
        return;

    if ( !isplayer( self ) )
        return;

    self._ID6089 = var_0 + 6000 * self._ID25671;
    wait(6 * self._ID25671);

    if ( !level.gameended )
    {
        if ( self hasfemalecustomizationmodel() )
        {
            self playlocalsound( "Fem_breathing_better" );
            return;
        }

        self playlocalsound( "breathing_better" );
        return;
        return;
    }
}

_ID16477( var_0, var_1 )
{
    self notify( "healthRegeneration" );
    self endon( "healthRegeneration" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    level endon( "game_ended" );
    var_2 = level.healthregendisabled || isdefined( self.healthregendisabled ) && self.healthregendisabled;

    if ( var_2 )
        return;

    childthread maps\mp\perks\_perkfunctions::regenspeedwatcher();
    wait(level._ID24498 * self._ID25671);

    if ( var_1 < 0.55 )
        var_3 = 1;
    else
        var_3 = 0;

    for (;;)
    {
        if ( !isdefined( self._ID25671 ) || self._ID25671 == 1 )
        {
            wait 0.05;

            if ( self.health < self.maxhealth )
            {
                self.health = self.health + 1;
                var_1 = self.health / self.maxhealth;
            }
            else
                break;
        }
        else
        {
            wait 0.05;

            if ( self.health < self.maxhealth )
            {
                if ( maps\mp\_utility::_hasperk( "specialty_regenfaster" ) )
                    self.health = self.health + level._ID25667;
                else if ( maps\mp\_utility::_hasperk( "specialty_bloodrush" ) )
                    self.health = self.health + self.bloodrushregenhealthmod;
            }
            else
                break;
        }

        if ( self.health > self.maxhealth )
            self.health = self.maxhealth;
    }

    self notify( "healed" );
    maps\mp\gametypes\_damage::_ID26118();

    if ( var_3 )
    {
        maps\mp\gametypes\_missions::_ID16475();
        return;
    }
}

_ID35463()
{
    self notify( "waiting_to_stop_remote" );
    self endon( "waiting_to_stop_remote" );
    self endon( "death" );
    level endon( "game_ended" );
    self waittill( "stopped_using_remote" );
    maps\mp\_utility::_ID26201( 0 );
}

playerpainbreathingsound( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );

    if ( !isplayer( self ) )
        return;

    wait 2;

    for (;;)
    {
        wait 0.2;

        if ( self.health <= 0 )
            return;

        if ( self.health >= var_0 )
            continue;

        var_1 = level.healthregendisabled || isdefined( self.healthregendisabled ) && self.healthregendisabled;

        if ( var_1 && isdefined( self._ID6089 ) && gettime() > self._ID6089 )
            continue;

        if ( maps\mp\_utility::_ID18837() )
            continue;

        if ( self hasfemalecustomizationmodel() )
            self playlocalsound( "Fem_breathing_hurt" );
        else
            self playlocalsound( "breathing_hurt" );

        wait 0.784;
        wait(0.1 + randomfloat( 0.8 ));
    }
}
