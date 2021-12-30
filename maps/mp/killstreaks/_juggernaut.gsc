// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level.juggsettings = [];
    level.juggsettings["juggernaut"] = spawnstruct();
    level.juggsettings["juggernaut"]._ID31056 = "used_juggernaut";
    level.juggsettings["juggernaut_recon"] = spawnstruct();
    level.juggsettings["juggernaut_recon"]._ID31056 = "used_juggernaut_recon";
    level.juggsettings["juggernaut_maniac"] = spawnstruct();
    level.juggsettings["juggernaut_maniac"]._ID31056 = "used_juggernaut_maniac";
    level thread watchjugghostmigrationfinishedinit();
}

givejuggernaut( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    wait 0.05;

    if ( isdefined( self._ID19959 ) )
        maps\mp\perks\_perkfunctions::unsetlightarmor();

    maps\mp\gametypes\_weapons::disableplantedequipmentuse();

    if ( maps\mp\_utility::_hasperk( "specialty_explosivebullets" ) )
        maps\mp\_utility::_unsetperk( "specialty_explosivebullets" );

    self.health = self.maxhealth;
    var_1 = 1;

    switch ( var_0 )
    {
        case "juggernaut":
            self._ID18666 = 1;
            self.juggmovespeedscaler = 0.8;
            maps\mp\gametypes\_class::giveloadout( self.pers["team"], var_0, 0 );
            self._ID21667 = 0.8;
            maps\mp\_utility::_ID15611( "specialty_scavenger", 0 );
            maps\mp\_utility::_ID15611( "specialty_quickdraw", 0 );
            maps\mp\_utility::_ID15611( "specialty_detectexplosive", 0 );
            maps\mp\_utility::_ID15611( "specialty_sharp_focus", 0 );
            maps\mp\_utility::_ID15611( "specialty_radarjuggernaut", 0 );
            break;
        case "juggernaut_recon":
            self._ID18670 = 1;
            self.juggmovespeedscaler = 0.8;
            maps\mp\gametypes\_class::giveloadout( self.pers["team"], var_0, 0 );
            self._ID21667 = 0.8;
            maps\mp\_utility::_ID15611( "specialty_scavenger", 0 );
            maps\mp\_utility::_ID15611( "specialty_coldblooded", 0 );
            maps\mp\_utility::_ID15611( "specialty_noscopeoutline", 0 );
            maps\mp\_utility::_ID15611( "specialty_detectexplosive", 0 );
            maps\mp\_utility::_ID15611( "specialty_sharp_focus", 0 );
            maps\mp\_utility::_ID15611( "specialty_radarjuggernaut", 0 );

            if ( !isagent( self ) )
            {
                self makeportableradar( self );
                maps\mp\gametypes\_missions::_ID25038( "ch_airdrop_juggernaut_recon" );
            }

            break;
        case "juggernaut_maniac":
            self._ID18669 = 1;
            self.juggmovespeedscaler = 1.15;
            maps\mp\gametypes\_class::giveloadout( self.pers["team"], var_0, 0 );
            maps\mp\_utility::_ID15611( "specialty_blindeye", 0 );
            maps\mp\_utility::_ID15611( "specialty_coldblooded", 0 );
            maps\mp\_utility::_ID15611( "specialty_noscopeoutline", 0 );
            maps\mp\_utility::_ID15611( "specialty_detectexplosive", 0 );
            maps\mp\_utility::_ID15611( "specialty_marathon", 0 );
            maps\mp\_utility::_ID15611( "specialty_falldamage", 0 );
            self._ID21667 = 1.15;
            break;
        default:
            var_1 = self [[ level._ID37649 ]]( var_0 );
            break;
    }

    if ( perkcheck( "specialty_hardline" ) )
        maps\mp\_utility::_ID15611( "specialty_hardline", 0 );

    maps\mp\gametypes\_weapons::_ID34567();
    self disableweaponpickup();

    if ( !isagent( self ) )
    {
        if ( var_1 )
        {
            self setclientomnvar( "ui_juggernaut", 1 );
            thread maps\mp\_utility::_ID32672( level.juggsettings[var_0]._ID31056, self );
            thread _ID18986();
            thread _ID36057();
            thread _ID36064();
        }
    }

    if ( self._ID31894 == "specialist" )
        thread maps\mp\killstreaks\_killstreaks::clearkillstreaks();
    else
        thread maps\mp\killstreaks\_killstreaks::_ID34551( 1 );

    thread _ID18989();

    if ( isdefined( self.carryflag ) )
    {
        wait 0.05;
        self attach( self.carryflag, "J_spine4", 1 );
    }

    level notify( "juggernaut_equipped",  self  );
    maps\mp\_matchdata::_ID20253( var_0, self.origin );
}

perkcheck( var_0 )
{
    var_1 = self.pers["loadoutPerks"];

    foreach ( var_3 in var_1 )
    {
        if ( var_3 == var_0 )
            return 1;
    }

    return 0;
}

_ID18986()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );

    for (;;)
    {
        wait 3.0;
        maps\mp\_utility::playplayerandnpcsounds( self, "juggernaut_breathing_player", "juggernaut_breathing_sound" );
    }
}

watchjugghostmigrationfinishedinit()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "host_migration_end" );

        foreach ( var_1 in level.players )
        {
            if ( isai( var_1 ) )
            {
                continue;
                continue;
            }

            if ( var_1 maps\mp\_utility::_ID18666() && !( isdefined( var_1.isjuggernautlevelcustom ) && var_1.isjuggernautlevelcustom ) )
            {
                var_1 setclientomnvar( "ui_juggernaut", 1 );
                continue;
            }

            var_1 setclientomnvar( "ui_juggernaut", 0 );
        }
    }
}

_ID18989()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );
    thread _ID18988();
    common_scripts\utility::_ID35626( "death", "joined_team", "joined_spectators", "lost_juggernaut" );
    self enableweaponpickup();
    self._ID18666 = 0;
    self._ID18667 = 0;
    self._ID18668 = 0;
    self._ID18670 = 0;
    self._ID18669 = 0;
    self.isjuggernautlevelcustom = 0;

    if ( isplayer( self ) )
        self setclientomnvar( "ui_juggernaut", 0 );

    self unsetperk( "specialty_radarjuggernaut", 1 );
    self notify( "jugg_removed" );
}

_ID18988()
{
    self endon( "disconnect" );
    self endon( "jugg_removed" );
    level waittill( "game_ended" );

    if ( isplayer( self ) )
        self setclientomnvar( "ui_juggernaut", 0 );
}

setjugg()
{
    if ( isdefined( self._ID16458 ) )
    {
        self detach( self._ID16458, "" );
        self._ID16458 = undefined;
    }

    self setmodel( "mp_fullbody_juggernaut_heavy_black" );
    self setviewmodel( "viewhands_juggernaut_ally" );
    self setclothtype( "vestheavy" );
}

_ID28762()
{
    if ( isdefined( self._ID16458 ) )
    {
        self detach( self._ID16458, "" );
        self._ID16458 = undefined;
    }

    self setmodel( "mp_body_juggernaut_light_black" );
    self setviewmodel( "viewhands_juggernaut_ally" );
    self attach( "head_juggernaut_light_black", "", 1 );
    self._ID16458 = "head_juggernaut_light_black";
    self setclothtype( "nylon" );
}

_ID10161()
{
    if ( maps\mp\_utility::_ID18666() )
    {
        self._ID18981 = 1;
        self setclientomnvar( "ui_juggernaut", 0 );
    }
}

enablejuggernaut()
{
    if ( maps\mp\_utility::_ID18666() )
    {
        self._ID18981 = undefined;
        self setclientomnvar( "ui_juggernaut", 1 );
    }
}

_ID36057()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( !isdefined( self._ID18981 ) && maps\mp\_utility::_ID18837() )
        {
            self waittill( "black_out_done" );
            _ID10161();
        }

        wait 0.05;
    }
}

_ID36064()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( isdefined( self._ID18981 ) && !maps\mp\_utility::_ID18837() )
            enablejuggernaut();

        wait 0.05;
    }
}

initlevelcustomjuggernaut( var_0, var_1, var_2, var_3 )
{
    level._ID37649 = var_0;
    level.mapcustomjuggsetclass = var_1;
    level.mapcustomjuggkilledsplash = var_3;
    game["allies_model"]["JUGGERNAUT_CUSTOM"] = var_2;
    game["axis_model"]["JUGGERNAUT_CUSTOM"] = var_2;
}
