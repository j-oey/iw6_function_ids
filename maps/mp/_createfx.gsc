// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID8418()
{
    level.func_position_player = common_scripts\utility::_ID35394;
    level.func_position_player_get = ::func_position_player_get;
    level._ID13743 = common_scripts\_fx::_ID20348;
    level._ID13744 = common_scripts\_fx::_ID22829;
    level._ID13736 = common_scripts\_fx::create_loopsound;
    level._ID13749 = common_scripts\_createfx::_ID26177;
    level._ID13748 = common_scripts\_createfx::_ID25029;
    level._ID13745 = ::_ID13745;
    level._ID21731 = 1;
    level.callbackstartgametype = common_scripts\utility::_ID35394;
    level._ID6484 = common_scripts\utility::_ID35394;
    level.callbackplayerdisconnect = common_scripts\utility::_ID35394;
    level.callbackplayerdamage = common_scripts\utility::_ID35394;
    level.callbackplayerkilled = common_scripts\utility::_ID35394;
    level._ID6482 = common_scripts\utility::_ID35394;
    level.callbackplayerlaststand = common_scripts\utility::_ID35394;
    level._ID6484 = ::callback_playerconnect;
    level.callbackplayermigrated = common_scripts\utility::_ID35394;
    thread common_scripts\_createfx::func_get_level_fx();
    common_scripts\_createfx::_ID8423();
    level waittill( "eternity" );
}

func_position_player_get( var_0 )
{
    return level.player.origin;
}

callback_playerconnect()
{
    self waittill( "begin" );

    if ( !isdefined( level.player ) )
    {
        var_0 = getentarray( "mp_global_intermission", "classname" );
        self spawn( var_0[0].origin, var_0[0].angles );
        maps\mp\_utility::_ID34608( "playing", "" );
        self.maxhealth = 10000000;
        self.health = 10000000;
        level.player = self;
        thread common_scripts\_createfx::createfxlogic();
    }
    else
        kick( self getentitynumber() );
}

_ID13745()
{
    var_0 = level._ID1624._ID24345 / 190;
    level.player setmovespeedscale( var_0 );
}
