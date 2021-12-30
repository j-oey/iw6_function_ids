// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID37118 = [];
    level._ID37118["mp_boneyard_ns"] = 1;
    level._ID37118["mp_swamp"] = 2;
    level._ID37118["mp_ca_red_river"] = 4;
    level._ID37118["mp_ca_rumble"] = 8;
    level._ID37118["mp_dome_ns"] = 16;
    level._ID37118["mp_battery3"] = 32;
    level._ID37118["mp_ca_impact"] = 64;
    level._ID37118["mp_ca_behemoth"] = 128;
    level._ID37118["mp_dig"] = 256;
    level._ID37118["mp_favela_iw6"] = 512;
    level._ID37118["mp_pirate"] = 1024;
    level._ID37118["mp_zulu"] = 2048;
    level._ID37118["mp_conflict"] = 4096;
    level._ID37118["mp_mine"] = 8192;
    level._ID37118["mp_zerosub"] = 16384;
    level._ID37118["mp_shipment_ns"] = 32768;
    level._ID37119["mp_boneyard_ns"] = 0;
    level._ID37119["mp_swamp"] = 0;
    level._ID37119["mp_ca_red_river"] = 0;
    level._ID37119["mp_ca_rumble"] = 0;
    level._ID37119["mp_dome_ns"] = 1;
    level._ID37119["mp_battery3"] = 1;
    level._ID37119["mp_ca_impact"] = 1;
    level._ID37119["mp_ca_behemoth"] = 1;
    level._ID37119["mp_dig"] = 2;
    level._ID37119["mp_favela_iw6"] = 2;
    level._ID37119["mp_pirate"] = 2;
    level._ID37119["mp_zulu"] = 2;
    level._ID37119["mp_conflict"] = 3;
    level._ID37119["mp_mine"] = 3;
    level._ID37119["mp_zerosub"] = 3;
    level._ID37119["mp_shipment_ns"] = 3;
    level._ID36784 = [ 0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4 ];
    level._ID1644["vfx_alien_easter_egg_hit"] = loadfx( "vfx/gameplay/alien/vfx_alien_easter_egg_hit" );
}

_ID37998( var_0 )
{
    if ( level._ID25418 )
    {
        _ID17631();
        var_1 = level._ID37118[maps\mp\_utility::getmapname()];
        var_2 = getent( var_0, "targetname" );

        if ( isdefined( var_2 ) )
        {
            if ( var_2.classname == "script_model" )
                var_2 setcandamage( 1 );

            var_2 thread _ID37150();
        }
    }
}

_ID37150()
{
    level endon( "game_ended" );
    self.health = 99999;
    level._ID37146 = [];

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4  );
        playfx( common_scripts\utility::_ID15033( "vfx_alien_easter_egg_hit" ), var_3, anglestoforward( var_2 ), anglestoup( var_2 ) );

        if ( isplayer( var_1 ) && !isai( var_1 ) )
        {
            var_5 = var_1 maps\mp\_utility::getuniqueid();

            if ( !isdefined( level._ID37146[var_5] ) )
            {
                level._ID37146[var_5] = 1;
                _ID37147( var_0, var_1, var_2, var_3, var_4 );
            }
        }
    }
}

_ID37147( var_0, var_1, var_2, var_3, var_4 )
{
    self.health = self.health + var_0;

    if ( !var_1 _ID37145( maps\mp\_utility::getmapname() ) )
        var_1 _ID37148( maps\mp\_utility::getmapname() );
    else if ( var_1 eggallfound() && var_1 maps\mp\gametypes\_hud_util::ch_getstate( "ch_weekly_1" ) < 2 )
        var_1 eggawardpatch();
}

_ID37145( var_0 )
{
    var_1 = self getrankedplayerdatareservedint( "dlcEggStatus" );
    var_2 = level._ID37118[var_0];

    if ( isdefined( var_2 ) && ( var_1 & var_2 ) != 0 )
        return 1;

    return 0;
}

_ID37148( var_0 )
{
    var_1 = level._ID37118[var_0];

    if ( isdefined( var_1 ) )
    {
        var_2 = self getrankedplayerdatareservedint( "dlcEggStatus" );
        var_2 |= var_1;
        self setrankedplayerdatareservedint( "dlcEggStatus", var_2 );
        var_3 = level._ID37119[var_0];
        var_4 = _ID37144( var_3, var_2 );
        var_3++;

        if ( var_4 < 4 )
            maps\mp\gametypes\_hud_message::_ID24474( "dlc_eggFound_" + var_3, self, var_4 );
        else if ( eggallfound() && maps\mp\gametypes\_hud_util::ch_getstate( "ch_weekly_1" ) < 2 )
            eggawardpatch();
        else
        {
            maps\mp\gametypes\_hud_message::_ID24474( "dlc_eggAllFound_" + var_3, self );
            thread maps\mp\gametypes\_rank::giverankxp( "dlc_egg_hunt" );
        }

        self playlocalsound( "ui_extinction_egg_splash" );
    }
}

eggawardpatch()
{
    maps\mp\gametypes\_hud_message::_ID24474( "dlc_eggAllFound", self );
    thread maps\mp\gametypes\_rank::giverankxp( "dlc_egg_hunt_all" );
    maps\mp\gametypes\_hud_util::_ID6824( "ch_weekly_1", 2 );
}

_ID37144( var_0, var_1 )
{
    var_2 = var_1 >> var_0 * 4;
    var_2 &= 15;
    return level._ID36784[var_2];
}

_ID37143( var_0 )
{
    var_1 = self getrankedplayerdatareservedint( "dlcEggStatus" );
    var_2 = var_1 >> var_0 * 4 & 15;
    return var_2 != 0;
}

eggallfound()
{
    var_0 = self getrankedplayerdatareservedint( "dlcEggStatus" );
    return var_0 == 65535;
}
