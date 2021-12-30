// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    precachelocationselector( "map_artillery_selector" );
    var_0 = spawnstruct();
    var_0._ID21275 = [];
    var_0._ID21275["allies"] = "vehicle_mig29_desert";
    var_0._ID21275["axis"] = "vehicle_mig29_desert";
    var_0.inboundsfx = "veh_mig29_dist_loop";
    var_0.compassiconfriendly = "compass_objpoint_airstrike_friendly";
    var_0.compassiconenemy = "compass_objpoint_airstrike_busy";
    var_0.speed = 5000;
    var_0._ID15984 = 15000;
    var_0.heightrange = 500;
    var_0._ID23072 = "airstrike_mp_roll";
    var_0._ID22773 = ::dropbombs;
    var_0._ID22844 = ::cleanupflyby;
    var_0.choosedirection = 1;
    var_0._ID28034 = "KS_hqr_airstrike";
    var_0._ID17499 = "KS_ast_inbound";
    var_0._ID5461 = "projectile_cbu97_clusterbomb";
    var_0.numbombs = 3;
    var_0._ID10243 = 350;
    var_0.effectradius = 200;
    var_0.effectheight = 120;
    var_0._ID11256 = loadfx( "fx/smoke/poisonous_gas_linger_medium_thick_killer_instant" );
    var_0._ID11254 = 0.25;
    var_0.effectmaxdelay = 0.5;
    var_0.effectlifespan = 13;
    var_0.effectcheckfrequency = 1.0;
    var_0._ID11250 = 10;
    var_0._ID22442 = "gas_strike_mp";
    var_0._ID19217 = ( 0, 0, 60 );
    level._ID23699["gas_airstrike"] = var_0;
    level._ID19256["gas_airstrike"] = ::_ID22916;
}

_ID22916( var_0, var_1 )
{
    var_2 = maps\mp\_utility::getotherteam( self.team );

    if ( isdefined( level.numgasstrikeactive ) )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }
    else
    {
        var_3 = maps\mp\killstreaks\_plane::_ID28015( var_0, "gas_airstrike", ::dostrike );
        return isdefined( var_3 ) && var_3;
    }
}

dostrike( var_0, var_1, var_2, var_3 )
{
    level.numgasstrikeactive = 0;
    wait 1;
    var_4 = maps\mp\killstreaks\_plane::_ID15250();
    var_5 = anglestoforward( ( 0, var_2, 0 ) );
    dooneflyby( var_3, var_0, var_1, var_5, var_4 );
    self waittill( "gas_airstrike_flyby_complete" );
}

dooneflyby( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = level._ID23699[var_0];
    var_6 = maps\mp\killstreaks\_plane::_ID15022( var_2, var_3, var_5._ID15984, 1, var_4, var_5.speed, 0, var_0 );
    level thread maps\mp\killstreaks\_plane::_ID10390( var_1, self, var_1, var_6["startPoint"] + ( 0, 0, randomint( var_5.heightrange ) ), var_6["endPoint"] + ( 0, 0, randomint( var_5.heightrange ) ), var_6["attackTime"], var_6["flyTime"], var_3, var_0 );
}

cleanupflyby( var_0, var_1, var_2 )
{
    var_0 notify( "gas_airstrike_flyby_complete" );
}

dropbombs( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );
    wait(var_2);
    var_5 = level._ID23699[var_4];
    var_6 = var_5.numbombs;
    var_7 = var_5._ID10243 / var_5.speed;

    while ( var_6 > 0 )
    {
        thread droponebomb( var_3, var_4 );
        var_6--;
        wait(var_7);
    }
}

droponebomb( var_0, var_1 )
{
    level.numgasstrikeactive++;
    var_2 = self;
    var_3 = level._ID23699[var_1];
    var_4 = anglestoforward( var_2.angles );
    var_5 = _ID30819( var_3._ID5461, var_2.origin, var_2.angles );
    var_5 movegravity( var_4 * var_3.speed / 1.5, 3.0 );
    var_6 = spawn( "script_model", var_5.origin );
    var_6 setmodel( "tag_origin" );
    var_6.origin = var_5.origin;
    var_6.angles = var_5.angles;
    var_5 setmodel( "tag_origin" );
    wait 0.1;
    var_7 = var_6.origin;
    var_8 = var_6.angles;

    if ( level.splitscreen )
        playfxontag( level.airstrikessfx, var_6, "tag_origin" );
    else
        playfxontag( level._ID2725, var_6, "tag_origin" );

    wait 1.0;
    var_9 = bullettrace( var_6.origin, var_6.origin + ( 0, 0, -1e+06 ), 0, undefined );
    var_10 = var_9["position"];
    var_5 _ID22780( var_0, var_10, var_1 );
    var_6 delete();
    var_5 delete();
    level.numgasstrikeactive--;

    if ( level.numgasstrikeactive == 0 )
        level.numgasstrikeactive = undefined;
}

_ID30819( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_model", var_1 );
    var_3.angles = var_2;
    var_3 setmodel( var_0 );
    return var_3;
}

_ID22780( var_0, var_1, var_2 )
{
    var_3 = level._ID23699[var_2];
    var_4 = spawn( "trigger_radius", var_1, 0, var_3.effectradius, var_3.effectheight );
    var_4.owner = var_0;
    var_5 = var_3.effectradius;
    var_6 = spawnfx( var_3._ID11256, var_1 );
    triggerfx( var_6 );
    wait(randomfloatrange( var_3._ID11254, var_3.effectmaxdelay ));
    var_7 = var_3.effectlifespan;
    var_8 = spawn( "script_model", var_1 + var_3._ID19217 );
    var_8 linkto( var_4 );

    for ( self._ID19214 = var_8; var_7 > 0.0; var_7 -= var_3.effectcheckfrequency )
    {
        foreach ( var_10 in level.characters )
            var_10 applygaseffect( var_0, var_1, var_4, self, var_3._ID11250 );

        wait(var_3.effectcheckfrequency);
    }

    self._ID19214 delete();
    var_4 delete();
    var_6 delete();
}

applygaseffect( var_0, var_1, var_2, var_3, var_4 )
{
    if ( var_0 maps\mp\_utility::isenemy( self ) && isalive( self ) && self istouching( var_2 ) )
    {
        var_3 radiusdamage( self.origin, 1, var_4, var_4, var_0, "MOD_RIFLE_BULLET", "gas_strike_mp" );

        if ( !maps\mp\_utility::_ID18837() )
        {
            var_5 = maps\mp\perks\_perkfunctions::applystunresistence( 2.0 );
            self shellshock( "default", var_5 );
        }
    }
}
