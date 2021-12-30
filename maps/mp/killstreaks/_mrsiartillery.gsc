// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level._ID19256["mrsiartillery"] = ::_ID33878;
    var_0 = spawnstruct();
    var_0._ID36273 = "airdrop_marker_mp";
    var_0._ID25058 = "mrsiartillery_projectile_mp";
    var_0._ID22421 = 6;
    var_0.initialdelay = 1.0;
    var_0._ID21087 = 0.375;
    var_0._ID20736 = 0.5;
    var_0._ID31959 = 150;

    if ( !isdefined( level._ID19252 ) )
        level._ID19252 = [];

    level._ID19252["mrsiartillery"] = var_0;
}

_ID33878( var_0, var_1 )
{
    var_2 = level._ID19252["mrsiartillery"];
    var_3 = maps\mp\killstreaks\_designator_grenade::designator_start( "mrsiartillery", var_2._ID36273, ::_ID22910 );

    if ( !isdefined( var_3 ) || !var_3 )
        return 0;
    else
        return 1;
}

_ID22910( var_0, var_1 )
{
    var_2 = level._ID19252[var_0];
    var_3 = var_1.owner;
    var_4 = var_1.origin;
    var_1 detonate();
    dostrike( var_3, var_0, var_3.origin, var_4 );
}

dostrike( var_0, var_1, var_2, var_3 )
{
    var_4 = level._ID19252[var_1];
    var_5 = var_3 - var_2;
    var_6 = ( var_5[0], var_5[1], 0 );
    var_5 = vectornormalize( var_5 );
    var_7 = var_3;
    var_8 = maps\mp\killstreaks\_killstreaks::findunobstructedfiringpoint( var_0, var_3 + ( 0, 0, 10 ), 10000 );

    if ( isdefined( var_8 ) )
    {
        iprintln( "Firing Motar!" );
        wait(var_4.initialdelay);
        wait(randomfloatrange( var_4._ID21087, var_4._ID20736 ));
        var_9 = magicbullet( var_4._ID25058, var_8, var_7, var_0 );

        for ( var_10 = 1; var_10 < var_4._ID22421; var_10++ )
        {
            wait(randomfloatrange( var_4._ID21087, var_4._ID20736 ));
            var_11 = _ID23542( var_7, var_4._ID31959 );
            var_9 = magicbullet( var_4._ID25058, var_8, var_11, var_0 );
        }
    }
    else
        iprintln( "Mortar LOS blocked!" );
}

_ID23542( var_0, var_1 )
{
    var_2 = randomfloatrange( -1 * var_1, var_1 );
    var_3 = randomfloatrange( -1 * var_1, var_1 );
    return var_0 + ( var_2, var_3, 0 );
}
