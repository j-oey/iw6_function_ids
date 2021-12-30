// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    if ( level.multiteambased )
    {
        foreach ( var_1 in level._ID32668 )
        {
            level.isteamspeaking[var_1] = 0;
            level._ID30921[var_1] = [];
        }
    }
    else
    {
        level.isteamspeaking["allies"] = 0;
        level.isteamspeaking["axis"] = 0;
        level._ID30921["allies"] = [];
        level._ID30921["axis"] = [];
    }

    level.bcsounds = [];
    level.bcsounds["reload"] = "inform_reloading_generic";
    level.bcsounds["frag_out"] = "inform_attack_grenade";
    level.bcsounds["flash_out"] = "inform_attack_flashbang";
    level.bcsounds["smoke_out"] = "inform_attack_smoke";
    level.bcsounds["conc_out"] = "inform_attack_stun";
    level.bcsounds["c4_plant"] = "inform_attack_thwc4";
    level.bcsounds["claymore_plant"] = "inform_plant_claymore";
    level.bcsounds["semtex_out"] = "semtex_use";
    level.bcsounds["kill"] = "inform_killfirm_infantry";
    level.bcsounds["casualty"] = "reaction_casualty_generic";
    level.bcsounds["suppressing_fire"] = "cmd_suppressfire";
    level.bcsounds["moving"] = "order_move_combat";
    level.bcsounds["callout_generic"] = "threat_infantry_generic";
    level.bcsounds["callout_response_generic"] = "response_ack_yes";
    level.bcsounds["damage"] = "inform_taking_fire";
    level.bcsounds["semtex_incoming"] = "semtex_incoming";
    level.bcsounds["c4_incoming"] = "c4_incoming";
    level.bcsounds["flash_incoming"] = "flash_incoming";
    level.bcsounds["stun_incoming"] = "stun_incoming";
    level.bcsounds["grenade_incoming"] = "grenade_incoming";
    level.bcsounds["rpg_incoming"] = "rpg_incoming";
    level.bcinfo = [];
    level.bcinfo["timeout"]["suppressing_fire"] = 5000;
    level.bcinfo["timeout"]["moving"] = 45000;
    level.bcinfo["timeout"]["callout_generic"] = 15000;
    level.bcinfo["timeout"]["callout_location"] = 3000;
    level.bcinfo["timeout_player"]["suppressing_fire"] = 10000;
    level.bcinfo["timeout_player"]["moving"] = 120000;
    level.bcinfo["timeout_player"]["callout_generic"] = 5000;
    level.bcinfo["timeout_player"]["callout_location"] = 5000;

    foreach ( var_5, var_4 in level._ID30921 )
    {
        level.bcinfo["last_say_time"][var_5]["suppressing_fire"] = -99999;
        level.bcinfo["last_say_time"][var_5]["moving"] = -99999;
        level.bcinfo["last_say_time"][var_5]["callout_generic"] = -99999;
        level.bcinfo["last_say_time"][var_5]["callout_location"] = -99999;
        level.bcinfo["last_say_pos"][var_5]["suppressing_fire"] = ( 0, 0, -9000 );
        level.bcinfo["last_say_pos"][var_5]["moving"] = ( 0, 0, -9000 );
        level.bcinfo["last_say_pos"][var_5]["callout_generic"] = ( 0, 0, -9000 );
        level.bcinfo["last_say_pos"][var_5]["callout_location"] = ( 0, 0, -9000 );
        level._ID38262[var_5][""] = 0;
        level._ID38262[var_5]["w"] = 0;
    }

    common_scripts\_bcs_location_trigs::bcs_location_trigs_init();
    var_6 = getdvar( "g_gametype" );
    level._ID18811 = 1;

    if ( var_6 == "war" || var_6 == "kc" || var_6 == "dom" )
        level._ID18811 = 0;

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
        self.bcinfo = [];
        self.bcinfo["last_say_time"]["suppressing_fire"] = -99999;
        self.bcinfo["last_say_time"]["moving"] = -99999;
        self.bcinfo["last_say_time"]["callout_generic"] = -99999;
        self.bcinfo["last_say_time"]["callout_location"] = -99999;
        var_0 = maps\mp\gametypes\_teams::getteamvoiceprefix( self.team );
        var_1 = "";

        if ( !isagent( self ) && self hasfemalecustomizationmodel() )
            var_1 = "w";

        self.pers["voiceNum"] = level._ID38262[self.team][var_1];
        level._ID38262[self.team][var_1] = ( level._ID38262[self.team][var_1] + 1 ) % 3;
        self.pers["voicePrefix"] = var_0 + var_1 + self.pers["voiceNum"] + "_";

        if ( level.splitscreen )
            continue;

        if ( !level._ID32653 )
            continue;

        thread claymoretracking();
        thread _ID25743();
        thread grenadetracking();
        thread _ID15797();
        thread suppressingfiretracking();
        thread casualtytracking();
        thread _ID8986();
        thread _ID31108();
        thread threatcallouttracking();
    }
}

_ID15797()
{
    self endon( "disconnect" );
    self endon( "death" );
    var_0 = self.origin;
    var_1 = 147456;

    for (;;)
    {
        var_2 = common_scripts\utility::_ID32831( isdefined( level.grenades ), level.grenades, [] );
        var_3 = common_scripts\utility::_ID32831( isdefined( level._ID21199 ), level._ID21199, [] );

        if ( var_2.size + var_3.size < 1 || !maps\mp\_utility::_ID18757( self ) )
        {
            wait 0.05;
            continue;
        }

        var_2 = common_scripts\utility::array_combine( var_2, var_3 );

        foreach ( var_5 in var_2 )
        {
            wait 0.05;

            if ( !isdefined( var_5 ) )
                continue;

            if ( isdefined( var_5._ID36249 ) )
            {
                switch ( var_5._ID36249 )
                {
                    case "throwingknife_mp":
                    case "trophy_mp":
                    case "motion_sensor_mp":
                    case "smoke_grenade_mp":
                    case "proximity_explosive_mp":
                        continue;
                }

                if ( weaponinventorytype( var_5._ID36249 ) != "offhand" && weaponclass( var_5._ID36249 ) == "grenade" )
                    continue;

                if ( !isdefined( var_5.owner ) )
                    var_5.owner = getmissileowner( var_5 );

                if ( isdefined( var_5.owner ) && level._ID32653 && var_5.owner.team == self.team )
                    continue;

                var_6 = distancesquared( var_5.origin, self.origin );

                if ( var_6 < var_1 )
                {
                    if ( common_scripts\utility::_ID7657() )
                    {
                        wait 5;
                        continue;
                    }

                    if ( bullettracepassed( var_5.origin, self.origin, 0, self ) )
                    {
                        if ( var_5._ID36249 == "concussion_grenade_mp" )
                        {
                            level thread _ID27315( self, "stun_incoming" );
                            wait 5;
                            continue;
                        }

                        if ( var_5._ID36249 == "flash_grenade_mp" )
                        {
                            level thread _ID27315( self, "flash_incoming" );
                            wait 5;
                            continue;
                        }

                        if ( weaponclass( var_5._ID36249 ) == "rocketlauncher" )
                        {
                            level thread _ID27315( self, "rpg_incoming" );
                            wait 5;
                            continue;
                        }

                        if ( var_5._ID36249 == "c4_mp" )
                        {
                            level thread _ID27315( self, "c4_incoming" );
                            wait 5;
                            continue;
                        }

                        if ( var_5._ID36249 == "semtex_mp" )
                        {
                            level thread _ID27315( self, "semtex_incoming" );
                            wait 5;
                            continue;
                        }

                        level thread _ID27315( self, "grenade_incoming" );
                        wait 5;
                    }
                }
            }
        }
    }
}

suppressingfiretracking()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    var_0 = undefined;

    for (;;)
    {
        self waittill( "begin_firing" );
        thread _ID32109();
        thread _ID32108();
        self waittill( "stoppedFiring" );
    }
}

_ID32108()
{
    thread _ID35613();
    self endon( "begin_firing" );
    self waittill( "end_firing" );
    wait 0.3;
    self notify( "stoppedFiring" );
}

_ID35613()
{
    self endon( "stoppedFiring" );
    self waittill( "begin_firing" );
    thread _ID32108();
}

_ID32109()
{
    self notify( "suppressWaiter" );
    self endon( "suppressWaiter" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "stoppedFiring" );
    wait 1;

    if ( _ID6642( "suppressing_fire" ) )
        level thread _ID27315( self, "suppressing_fire" );
}

claymoretracking()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );

    for (;;)
    {
        self waittill( "begin_firing" );
        var_0 = self getcurrentweapon();

        if ( var_0 == "claymore_mp" )
            level thread _ID27315( self, "claymore_plant" );
    }
}

_ID25743()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );

    for (;;)
    {
        self waittill( "reload_start" );
        level thread _ID27315( self, "reload" );
    }
}

grenadetracking()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );

    for (;;)
    {
        self waittill( "grenade_fire",  var_0, var_1  );

        if ( var_1 == "frag_grenade_mp" )
        {
            level thread _ID27315( self, "frag_out" );
            continue;
        }

        if ( var_1 == "semtex_mp" )
        {
            level thread _ID27315( self, "semtex_out" );
            continue;
        }

        if ( var_1 == "flash_grenade_mp" )
        {
            level thread _ID27315( self, "flash_out" );
            continue;
        }

        if ( var_1 == "concussion_grenade_mp" )
        {
            level thread _ID27315( self, "conc_out" );
            continue;
        }

        if ( var_1 == "smoke_grenade_mp" )
        {
            level thread _ID27315( self, "smoke_out" );
            continue;
        }

        if ( var_1 == "c4_mp" )
            level thread _ID27315( self, "c4_plant" );
    }
}

_ID31108()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );

    for (;;)
    {
        self waittill( "sprint_begin" );

        if ( _ID6642( "moving" ) )
            level thread _ID27315( self, "moving", 0, 0 );
    }
}

_ID8986()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1  );

        if ( !isdefined( var_1 ) )
            continue;

        if ( !isdefined( var_1.classname ) )
            continue;

        if ( var_1 != self && var_1.classname != "worldspawn" )
        {
            wait 1.5;
            level thread _ID27315( self, "damage" );
            wait 3;
        }
    }
}

casualtytracking()
{
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self waittill( "death" );

    foreach ( var_1 in level._ID23303 )
    {
        if ( !isdefined( var_1 ) )
            continue;

        if ( var_1 == self )
            continue;

        if ( !maps\mp\_utility::_ID18757( var_1 ) )
            continue;

        if ( var_1.team != self.team )
            continue;

        if ( distancesquared( self.origin, var_1.origin ) <= 262144 )
        {
            level thread saylocalsounddelayed( var_1, "casualty", 0.75 );
            break;
        }
    }
}

threatcallouttracking()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );

    for (;;)
    {
        self waittill( "enemy_sighted" );

        if ( getomnvar( "ui_prematch_period" ) )
        {
            level waittill( "prematch_over" );
            continue;
        }

        if ( !_ID6642( "callout_location" ) && !_ID6642( "callout_generic" ) )
            continue;

        var_0 = self getsightedplayers();

        if ( !isdefined( var_0 ) )
            continue;

        var_1 = 0;
        var_2 = 4000000;

        if ( self playerads() > 0.7 )
            var_2 = 6250000;

        foreach ( var_4 in var_0 )
        {
            if ( isdefined( var_4 ) && maps\mp\_utility::_ID18757( var_4 ) && !var_4 maps\mp\_utility::_hasperk( "specialty_coldblooded" ) && distancesquared( self.origin, var_4.origin ) < var_2 )
            {
                var_5 = var_4 _ID15458( self );
                var_1 = 1;

                if ( isdefined( var_5 ) && _ID6642( "callout_location" ) && friendly_nearby( 4840000 ) )
                {
                    if ( maps\mp\_utility::_hasperk( "specialty_quieter" ) || !friendly_nearby( 262144 ) )
                        level thread _ID27315( self, var_5._ID20161[0], 0 );
                    else
                        level thread _ID27315( self, var_5._ID20161[0], 1 );

                    break;
                }
            }
        }

        if ( var_1 && _ID6642( "callout_generic" ) )
            level thread _ID27315( self, "callout_generic" );
    }
}

saylocalsounddelayed( var_0, var_1, var_2, var_3, var_4 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    wait(var_2);
    _ID27315( var_0, var_1, var_3, var_4 );
}

_ID27315( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );

    if ( isdefined( var_0.bcdisabled ) && var_0.bcdisabled == 1 )
        return;

    if ( isspeakerinrange( var_0 ) )
        return;

    if ( var_0.team != "spectator" )
    {
        var_4 = var_0.pers["voicePrefix"];

        if ( isdefined( level.bcsounds[var_1] ) )
            var_5 = var_4 + level.bcsounds[var_1];
        else
        {
            location_add_last_callout_time( var_1 );
            var_5 = var_4 + "co_loc_" + var_1;
            var_0 thread _ID10781( var_5, var_1 );
            var_1 = "callout_location";
        }

        var_0 _ID34518( var_1 );
        var_0 thread _ID10767( var_5, var_2, var_3 );
    }
}

_ID10767( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1;

    var_3 = self.pers["team"];
    level addspeaker( self, var_3 );
    var_4 = !level._ID18811 || !maps\mp\_utility::_hasperk( "specialty_coldblooded" ) && ( isagent( self ) || self issighted() );

    if ( var_2 && var_4 )
    {
        if ( isagent( self ) || level.alivecount[var_3] > 3 )
            thread dosounddistant( var_0, var_3 );
    }

    if ( isagent( self ) || isdefined( var_1 ) && var_1 )
        self playsoundtoteam( var_0, var_3 );
    else
        self playsoundtoteam( var_0, var_3, self );

    thread _ID33052( var_0 );
    common_scripts\utility::_ID35626( var_0, "death", "disconnect" );
    level _ID26033( self, var_3 );
}

dosounddistant( var_0, var_1 )
{
    var_2 = spawn( "script_origin", self.origin + ( 0, 0, 256 ) );
    var_3 = var_0 + "_n";

    if ( soundexists( var_3 ) )
    {
        foreach ( var_5 in level._ID32668 )
        {
            if ( var_5 != var_1 )
                var_2 playsoundtoteam( var_3, var_5 );
        }
    }

    wait 3;
    var_2 delete();
}

_ID10781( var_0, var_1 )
{
    var_2 = common_scripts\utility::_ID35635( var_0, "death", "disconnect" );

    if ( var_2 == var_0 )
    {
        var_3 = self.team;

        if ( !isagent( self ) )
            var_4 = self hasfemalecustomizationmodel();
        else
            var_4 = 0;

        var_5 = self.pers["voiceNum"];
        var_6 = self.origin;
        wait 0.5;

        foreach ( var_8 in level._ID23303 )
        {
            if ( !isdefined( var_8 ) )
                continue;

            if ( var_8 == self )
                continue;

            if ( !maps\mp\_utility::_ID18757( var_8 ) )
                continue;

            if ( var_8.team != var_3 )
                continue;

            if ( !isagent( var_8 ) )
                var_9 = var_8 hasfemalecustomizationmodel();
            else
                var_9 = 0;

            if ( isdefined( var_8.pers["voiceNum"] ) && ( var_5 != var_8.pers["voiceNum"] || var_4 != var_9 ) && distancesquared( var_6, var_8.origin ) <= 262144 && !isspeakerinrange( var_8 ) )
            {
                var_10 = var_8.pers["voicePrefix"];
                var_11 = var_10 + "co_loc_" + var_1 + "_echo";

                if ( soundexists( var_11 ) && common_scripts\utility::_ID7657() )
                    var_12 = var_11;
                else
                    var_12 = var_10 + level.bcsounds["callout_response_generic"];

                var_8 thread _ID10767( var_12, 0, 1 );
                break;
            }
        }
    }
}

_ID33052( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    wait 2.0;
    self notify( var_0 );
}

isspeakerinrange( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );

    if ( !isdefined( var_1 ) )
        var_1 = 1000;

    var_2 = var_1 * var_1;

    if ( isdefined( var_0 ) && isdefined( var_0.team ) && var_0.team != "spectator" )
    {
        for ( var_3 = 0; var_3 < level._ID30921[var_0.team].size; var_3++ )
        {
            var_4 = level._ID30921[var_0.team][var_3];

            if ( var_4 == var_0 )
                return 1;

            if ( !isdefined( var_4 ) )
                continue;

            if ( distancesquared( var_4.origin, var_0.origin ) < var_2 )
                return 1;
        }
    }

    return 0;
}

addspeaker( var_0, var_1 )
{
    level._ID30921[var_1][level._ID30921[var_1].size] = var_0;
}

_ID26033( var_0, var_1 )
{
    var_2 = [];

    for ( var_3 = 0; var_3 < level._ID30921[var_1].size; var_3++ )
    {
        if ( level._ID30921[var_1][var_3] == var_0 )
            continue;

        var_2[var_2.size] = level._ID30921[var_1][var_3];
    }

    level._ID30921[var_1] = var_2;
}

disablebattlechatter( var_0 )
{
    var_0.bcdisabled = 1;
}

_ID11489( var_0 )
{
    var_0.bcdisabled = undefined;
}

_ID6642( var_0 )
{
    var_1 = self.pers["team"];

    if ( var_1 == "spectator" )
        return 0;

    var_2 = level.bcinfo["timeout_player"][var_0];
    var_3 = gettime() - self.bcinfo["last_say_time"][var_0];

    if ( var_2 > var_3 )
        return 0;

    var_2 = level.bcinfo["timeout"][var_0];
    var_3 = gettime() - level.bcinfo["last_say_time"][var_1][var_0];

    if ( var_2 < var_3 )
        return 1;

    return 0;
}

_ID34518( var_0 )
{
    var_1 = self.pers["team"];
    self.bcinfo["last_say_time"][var_0] = gettime();
    level.bcinfo["last_say_time"][var_1][var_0] = gettime();
    level.bcinfo["last_say_pos"][var_1][var_0] = self.origin;
}

_ID34554( var_0 )
{

}

getlocation()
{
    var_0 = _ID14271();
    var_0 = common_scripts\utility::array_randomize( var_0 );

    if ( var_0.size )
    {
        foreach ( var_2 in var_0 )
        {
            if ( !_ID20156( var_2 ) )
                return var_2;
        }

        foreach ( var_2 in var_0 )
        {
            if ( !_ID20157( var_2 ) )
                return var_2;
        }
    }

    return undefined;
}

_ID15458( var_0 )
{
    var_1 = _ID14271();
    var_1 = common_scripts\utility::array_randomize( var_1 );

    if ( var_1.size )
    {
        foreach ( var_3 in var_1 )
        {
            if ( !_ID20156( var_3 ) && var_0 cancalloutlocation( var_3 ) )
                return var_3;
        }

        foreach ( var_3 in var_1 )
        {
            if ( !_ID20157( var_3 ) && var_0 cancalloutlocation( var_3 ) )
                return var_3;
        }
    }

    return undefined;
}

_ID14271()
{
    var_0 = anim.bcs_locations;
    var_1 = self getistouchingentities( var_0 );
    var_2 = [];

    foreach ( var_4 in var_1 )
    {
        if ( isdefined( var_4._ID20161 ) )
            var_2[var_2.size] = var_4;
    }

    return var_2;
}

_ID34402()
{
    if ( isdefined( anim.bcs_locations ) )
        anim.bcs_locations = common_scripts\utility::array_removeundefined( anim.bcs_locations );
}

_ID18436()
{
    var_0 = _ID14271();

    foreach ( var_2 in var_0 )
    {
        if ( !_ID20157( var_2 ) )
            return 1;
    }

    return 0;
}

_ID20156( var_0 )
{
    var_1 = _ID20159( var_0._ID20161[0] );

    if ( !isdefined( var_1 ) )
        return 0;

    return 1;
}

_ID20157( var_0 )
{
    var_1 = _ID20159( var_0._ID20161[0] );

    if ( !isdefined( var_1 ) )
        return 0;

    var_2 = var_1 + 25000;

    if ( gettime() < var_2 )
        return 1;

    return 0;
}

location_add_last_callout_time( var_0 )
{
    anim._ID20162[var_0] = gettime();
}

_ID20159( var_0 )
{
    if ( isdefined( anim._ID20162[var_0] ) )
        return anim._ID20162[var_0];

    return undefined;
}

cancalloutlocation( var_0 )
{
    foreach ( var_2 in var_0._ID20161 )
    {
        var_3 = getloccalloutalias( "co_loc_" + var_2 );
        var_4 = _ID15275( var_2, 0 );
        var_5 = getloccalloutalias( "concat_loc_" + var_2 );
        var_6 = soundexists( var_3 ) || soundexists( var_4 ) || soundexists( var_5 );

        if ( var_6 )
            return var_6;
    }

    return 0;
}

_ID6575( var_0 )
{
    var_1 = var_0._ID20161;

    foreach ( var_3 in var_1 )
    {
        if ( _ID18577( var_3, self ) )
            return 1;
    }

    return 0;
}

_ID14921( var_0 )
{
    var_1 = undefined;
    var_2 = self._ID20161;

    foreach ( var_4 in var_2 )
    {
        if ( _ID18578( var_4, var_0 ) && !isdefined( self._ID25180 ) )
        {
            var_1 = var_4;
            break;
        }

        if ( iscallouttypereport( var_4 ) )
            var_1 = var_4;
    }

    return var_1;
}

iscallouttypereport( var_0 )
{
    return issubstr( var_0, "_report" );
}

_ID18577( var_0, var_1 )
{
    var_2 = var_1 getloccalloutalias( "concat_loc_" + var_0 );

    if ( soundexists( var_2 ) )
        return 1;

    return 0;
}

_ID18578( var_0, var_1 )
{
    if ( issubstr( var_0, "_qa" ) && soundexists( var_0 ) )
        return 1;

    var_2 = var_1 _ID15275( var_0, 0 );

    if ( soundexists( var_2 ) )
        return 1;

    return 0;
}

getloccalloutalias( var_0 )
{
    var_1 = self.pers["voicePrefix"] + var_0;
    return var_1;
}

_ID15275( var_0, var_1 )
{
    var_2 = getloccalloutalias( var_0 );
    var_2 += ( "_qa" + var_1 );
    return var_2;
}

battlechatter_canprint()
{
    return 0;
}

_ID4876()
{
    return 0;
}

battlechatter_print( var_0 )
{

}

_ID4883( var_0 )
{

}

battlechatter_debugprint( var_0 )
{

}

getaliastypefromsoundalias( var_0 )
{

}

battlechatter_printdumpline( var_0, var_1, var_2 )
{

}

friendly_nearby( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 262144;

    foreach ( var_2 in level.players )
    {
        if ( var_2.team == self.pers["team"] )
        {
            if ( var_2 != self && distancesquared( var_2.origin, self.origin ) <= var_0 )
                return 1;
        }
    }

    return 0;
}
