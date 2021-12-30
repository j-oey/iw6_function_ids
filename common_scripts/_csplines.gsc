// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

cspline_calctangent( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = [];
    var_6 = [];

    for ( var_7 = 0; var_7 < 3; var_7++ )
    {
        var_5[var_7] = ( 1 - var_4 ) * ( var_1[var_7] - var_0[var_7] );
        var_6[var_7] = var_5[var_7];
        var_5[var_7] *= 2 * var_2 / ( var_2 + var_3 );
        var_6[var_7] *= 2 * var_3 / ( var_2 + var_3 );
    }

    var_8 = [];
    var_8["incoming"] = ( var_5[0], var_5[1], var_5[2] );
    var_8["outgoing"] = ( var_6[0], var_6[1], var_6[2] );
    return var_8;
}

_ID8562( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = [];
    var_9 = [];

    for ( var_10 = 0; var_10 < 3; var_10++ )
    {
        var_8[var_10] = ( 1 - var_5 ) * ( 1 - var_6 ) * ( 1 + var_7 ) * 0.5 * ( var_1[var_10] - var_0[var_10] );
        var_8[var_10] += ( 1 - var_5 ) * ( 1 + var_6 ) * ( 1 - var_7 ) * 0.5 * ( var_2[var_10] - var_1[var_10] );
        var_8[var_10] *= 2 * var_3 / ( var_3 + var_4 );
        var_9[var_10] = ( 1 - var_5 ) * ( 1 + var_6 ) * ( 1 + var_7 ) * 0.5 * ( var_1[var_10] - var_0[var_10] );
        var_9[var_10] += ( 1 - var_5 ) * ( 1 - var_6 ) * ( 1 - var_7 ) * 0.5 * ( var_2[var_10] - var_1[var_10] );
        var_9[var_10] *= 2 * var_4 / ( var_3 + var_4 );
    }

    var_11 = [];
    var_11["incoming"] = ( var_8[0], var_8[1], var_8[2] );
    var_11["outgoing"] = ( var_9[0], var_9[1], var_9[2] );
    return var_11;
}

_ID8561( var_0, var_1, var_2 )
{
    var_3 = 3;
    var_4 = [];
    var_5 = [];

    if ( isdefined( var_2 ) )
    {
        for ( var_6 = 0; var_6 < var_3; var_6++ )
        {
            var_4[var_6] = ( -3 * var_0[var_6] + 3 * var_1[var_6] - var_2[var_6] ) / 2;
            var_5[var_6] = var_4[var_6];
        }
    }
    else
    {
        for ( var_6 = 0; var_6 < var_3; var_6++ )
        {
            var_4[var_6] = var_1[var_6] - var_0[var_6];
            var_5[var_6] = var_1[var_6] - var_0[var_6];
        }
    }

    var_7 = [];
    var_7["incoming"] = ( var_4[0], var_4[1], var_4[2] );
    var_7["outgoing"] = ( var_5[0], var_5[1], var_5[2] );
    return var_7;
}

csplineseg_calccoeffs( var_0, var_1, var_2, var_3 )
{
    var_4 = 3;
    var_5 = spawnstruct();
    var_5._ID21843 = [];
    var_5._ID21842 = [];
    var_5._ID21841 = [];
    var_5.c = [];

    for ( var_6 = 0; var_6 < var_4; var_6++ )
    {
        var_5._ID21843[var_6] = 2 * var_0[var_6] - 2 * var_1[var_6] + var_2[var_6] + var_3[var_6];
        var_5._ID21842[var_6] = -3 * var_0[var_6] + 3 * var_1[var_6] - 2 * var_2[var_6] - var_3[var_6];
        var_5._ID21841[var_6] = var_2[var_6];
        var_5.c[var_6] = var_0[var_6];
    }

    return var_5;
}

csplineseg_calccoeffscapspeed( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = csplineseg_calccoeffs( var_0, var_1, var_2, var_3 );
    var_6 = csplineseg_calctopspeed( var_5, var_4 );

    if ( var_6 > 1 )
    {
        var_4 *= var_6;
        var_2 /= var_6;
        var_3 /= var_6;
        var_5 = csplineseg_calccoeffs( var_0, var_1, var_2, var_3 );
    }

    var_5._ID11597 = var_4;
    return var_5;
}

cspline_getnodes( var_0 )
{
    var_1 = [];
    var_2 = var_0.segments[0]._ID11597;
    var_1[0] = csplineseg_getpoint( var_0.segments[0], 0, var_2, var_0.segments[0]._ID30984 );
    var_1[0]["time"] = 0;
    var_3 = 0;

    for ( var_4 = 0; var_4 < var_0.segments.size; var_4++ )
    {
        var_2 = var_0.segments[var_4]._ID11597 - var_3;
        var_1[var_4 + 1] = csplineseg_getpoint( var_0.segments[var_4], 1, var_2, var_0.segments[var_4]._ID30979 );
        var_5 = csplineseg_getpoint( var_0.segments[var_4], 0, var_2, var_0.segments[var_4]._ID30984 );
        var_1[var_4]["acc_out"] = var_5["acc"];
        var_1[var_4 + 1]["time"] = var_0.segments[var_4].endtime;
        var_3 = var_0.segments[var_4]._ID11597;
    }

    var_1[var_0.segments.size]["acc_out"] = var_1[var_0.segments.size]["acc"];
    return var_1;
}

csplineseg_getpoint( var_0, var_1, var_2, var_3 )
{
    var_4 = 3;
    var_5 = [];
    var_6 = [];
    var_7 = [];
    var_8 = [];

    for ( var_9 = 0; var_9 < var_4; var_9++ )
    {
        var_5[var_9] = var_0._ID21843[var_9] * var_1 * var_1 * var_1 + var_0._ID21842[var_9] * var_1 * var_1 + var_0._ID21841[var_9] * var_1 + var_0.c[var_9];
        var_6[var_9] = 3 * var_0._ID21843[var_9] * var_1 * var_1 + 2 * var_0._ID21842[var_9] * var_1 + var_0._ID21841[var_9];
        var_7[var_9] = 6 * var_0._ID21843[var_9] * var_1 + 2 * var_0._ID21842[var_9];
    }

    var_8["pos"] = ( var_5[0], var_5[1], var_5[2] );
    var_8["vel"] = ( var_6[0], var_6[1], var_6[2] );
    var_8["acc"] = ( var_7[0], var_7[1], var_7[2] );

    if ( isdefined( var_2 ) )
    {
        var_8["vel"] /= var_2;
        var_8["acc"] /= var_2 * var_2;
    }

    if ( isdefined( var_3 ) )
    {
        var_8["vel"] *= var_3;
        var_8["acc"] *= ( var_3 * var_3 );
    }

    var_8["speed"] = var_3;
    return var_8;
}

csplineseg_calctopspeed( var_0, var_1 )
{
    var_2 = _ID8584( var_0, var_1 );
    return var_2;
}

_ID8584( var_0, var_1 )
{
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;
    var_5 = 0;
    var_6 = 0;
    var_7 = 0;

    for ( var_8 = 0; var_8 < 3; var_8++ )
    {
        var_2 += var_0._ID21843[var_8] * var_0._ID21843[var_8];
        var_3 += var_0._ID21843[var_8] * var_0._ID21842[var_8];
        var_4 += var_0._ID21843[var_8] * var_0._ID21841[var_8];
        var_5 += var_0._ID21842[var_8] * var_0._ID21842[var_8];
        var_6 += var_0._ID21842[var_8] * var_0._ID21841[var_8];
        var_7 += var_0._ID21841[var_8] * var_0._ID21841[var_8];
    }

    var_9 = 36 * var_2;
    var_10 = 36 * var_3;
    var_11 = 12 * var_4 + 8 * var_5;
    var_12 = 4 * var_6;
    var_13 = [];
    var_13[0] = 0;

    if ( var_9 == 0 )
    {
        if ( var_10 == 0 && var_11 == 0 && var_12 == 0 )
            return sqrt( var_7 ) / var_1;

        var_14 = maps\interactive_models\_interactive_utility::rootsofquadratic( var_10, var_11, var_12 );

        if ( isdefined( var_14[0] ) && var_14[0] > 0 && var_14[0] < 1 )
        {
            var_15 = 2 * var_10 * var_14[0] + var_11;

            if ( var_15 < 0 )
                var_13[var_13.size] = var_14[0];
        }

        if ( isdefined( var_14[1] ) && var_14[1] > 0 && var_14[1] < 1 )
        {
            var_15 = 2 * var_10 * var_14[0] + var_11;

            if ( var_15 < 0 )
                var_13[var_13.size] = var_14[1];
        }
    }
    else
    {
        var_16 = maps\interactive_models\_interactive_utility::rootsofquadratic( 3 * var_9, 2 * var_10, var_11 );
        var_17 = 0;
        var_18[0] = 0;

        for ( var_17 = 0; var_17 < var_16.size; var_17++ )
        {
            if ( var_16[var_17] > 0 && var_16[var_17] < 1 )
                var_18[var_18.size] = var_16[var_17];
        }

        var_18[var_18.size] = 1;

        for ( var_17 = 1; var_17 < var_18.size; var_17++ )
        {
            var_19 = var_18[var_17 - 1];
            var_20 = var_18[var_17];
            var_21 = var_9 * var_19 * var_19 * var_19 + var_10 * var_19 * var_19 + var_11 * var_19 + var_12;
            var_22 = var_9 * var_20 * var_20 * var_20 + var_10 * var_20 * var_20 + var_11 * var_20 + var_12;

            if ( var_21 > 0 && var_22 < 0 )
                var_13[var_13.size] = maps\interactive_models\_interactive_utility::_ID21967( var_19, var_20, var_9, var_10, var_11, var_12, 0.02 );
        }
    }

    var_13[var_13.size] = 1;
    var_9 = 9 * var_2;
    var_10 = 12 * var_3;
    var_11 = 6 * var_4 + 4 * var_5;
    var_12 = 4 * var_6;
    var_23 = var_7;
    var_24 = 0;

    foreach ( var_26 in var_13 )
    {
        var_27 = var_9 * var_26 * var_26 * var_26 * var_26 + var_10 * var_26 * var_26 * var_26 + var_11 * var_26 * var_26 + var_12 * var_26 + var_23;

        if ( var_27 > var_24 )
            var_24 = var_27;
    }

    return sqrt( var_24 ) / var_1;
}

csplineseg_calclengthbystepping( var_0, var_1 )
{
    var_2 = csplineseg_getpoint( var_0, 0 );
    var_3 = 0;

    for ( var_4 = 1; var_4 <= var_1; var_4++ )
    {
        var_5 = var_4 / var_1;
        var_6 = csplineseg_getpoint( var_0, var_5 );
        var_3 += length( var_2["pos"] - var_6["pos"] );
        var_2 = var_6;
    }

    return var_3;
}

csplineseg_calctopspeedbystepping( var_0, var_1, var_2 )
{
    var_3 = csplineseg_getpoint( var_0, 0 );
    var_4 = 0;

    for ( var_5 = 1; var_5 <= var_1; var_5++ )
    {
        var_6 = var_5 / var_1;
        var_7 = csplineseg_getpoint( var_0, var_6 );
        var_8 = length( var_3["pos"] - var_7["pos"] );

        if ( var_8 > var_4 )
            var_4 = var_8;

        var_3 = var_7;
    }

    var_4 *= var_1 / var_2;
    return var_4;
}

cspline_findpathnodes( var_0 )
{
    var_1 = var_0;
    var_2 = [];

    for ( var_3 = 0; isdefined( var_1.target ); var_3++ )
    {
        var_2[var_3] = var_1;
        var_4 = var_1.target;
        var_1 = getnode( var_4, "targetname" );

        if ( !isdefined( var_1 ) )
        {
            var_1 = getvehiclenode( var_4, "targetname" );

            if ( !isdefined( var_1 ) )
            {
                var_1 = getent( var_4, "targetname" );

                if ( !isdefined( var_1 ) )
                    var_1 = common_scripts\utility::_ID15384( var_4, "targetname" );
            }
        }
    }

    var_2[var_3] = var_1;
    return var_2;
}

cspline_makepath1seg( var_0, var_1, var_2, var_3 )
{
    var_4 = [];
    var_4[0] = spawnstruct();
    var_4[0].origin = var_0;

    if ( isdefined( var_2 ) )
    {
        var_4[0].speed = length( var_2 );
        var_2 /= var_4[0].speed;
        var_4[0].speed = var_4[0].speed * 20;
    }
    else
        var_4[0].speed = 20;

    var_4[1] = spawnstruct();
    var_4[1].origin = var_1;

    if ( isdefined( var_3 ) )
    {
        var_4[1].speed = length( var_3 );
        var_3 /= var_4[1].speed;
        var_4[1].speed = var_4[1].speed * 20;
    }
    else
        var_4[1].speed = 20;

    return cspline_makepath( var_4, 1, var_2, var_3 );
}

cspline_makepathtopoint( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = [];

    if ( !isdefined( var_4 ) )
        var_4 = 0;

    if ( isdefined( var_2 ) )
    {
        var_6 = length( var_2 );
        var_5[0] = var_2 / var_6;
        var_6 *= 20;
    }
    else
        var_6 = 20;

    if ( isdefined( var_3 ) )
    {
        var_7 = length( var_3 );
        var_5[1] = var_3 / var_7;
        var_7 *= 20;
    }
    else
        var_7 = 20;

    if ( var_6 / var_7 > 1.2 || var_7 / var_6 > 1.2 || var_4 )
    {
        if ( !isdefined( var_5[0] ) )
            var_5[0] = ( 0, 0, 0 );

        if ( !isdefined( var_5[1] ) )
            var_5[1] = ( 0, 0, 0 );
    }

    var_8 = var_1 - var_0;
    var_9 = length( var_8 );
    var_10 = var_8 / var_9;
    var_11 = [];
    var_11[0] = spawnstruct();
    var_11[0].origin = var_0;
    var_11[0].speed = var_6;
    var_12 = [];
    var_13 = max( var_6, var_7 );

    if ( isdefined( var_5[0] ) )
        var_12[0] = ( var_6 + var_13 ) / 40;

    if ( isdefined( var_5[1] ) )
        var_12[1] = ( var_7 + var_13 ) / 40;

    for ( var_14 = 0; var_14 < 2; var_14++ )
    {
        if ( isdefined( var_5[var_14] ) )
        {
            var_15 = ( 0.5 - var_14 ) * 2;
            var_16 = var_5[var_14];
            var_16 *= var_15;
            var_17 = vectordot( var_16, var_10 );

            if ( var_17 * var_15 < 0.3 || var_6 / var_7 > 1.2 || var_7 / var_6 > 1.2 || var_4 )
            {
                if ( var_17 * var_15 < 0 )
                {
                    var_18 = var_17 * var_10;
                    var_16 -= var_18;
                    var_16 = vectornormalize( var_16 );
                    var_16 += var_18;
                }

                var_16 += var_10 * var_15;
                var_16 *= var_12[var_14];
                var_16 *= ( sqrt( var_9 ) * 2 );
                var_11[var_11.size] = spawnstruct();

                if ( var_14 == 0 )
                    var_11[var_11.size - 1].origin = var_0 + var_16;
                else
                    var_11[var_11.size - 1].origin = var_1 + var_16;

                var_11[var_11.size - 1].speed = var_13;
            }
        }
    }

    var_19 = var_11.size;
    var_11[var_19] = spawnstruct();
    var_11[var_19].origin = var_1;
    var_11[var_19].speed = var_7;
    return cspline_makepath( var_11, 1, var_5[0], var_5[1] );
}

cspline_makepath( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = spawnstruct();
    var_5.segments = [];

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( var_4 ) )
        var_4 = 1;

    var_6 = 0;
    var_7 = [];

    for ( var_8 = distance( var_0[0].origin, var_0[1].origin ); isdefined( var_0[var_5.segments.size + 2] ); var_5.segments[var_9]._ID11597 = var_6 )
    {
        var_9 = var_5.segments.size;
        var_10 = var_0[var_9].origin;
        var_11 = var_0[var_9 + 1].origin;
        var_12 = var_0[var_9 + 2].origin;
        var_13 = var_8;
        var_8 = distance( var_0[var_9 + 1].origin, var_0[var_9 + 2].origin );
        var_14 = var_7;
        var_7 = cspline_calctangent( var_10, var_12, var_13, var_8, 0.5 );

        if ( var_9 == 0 )
        {
            if ( isdefined( var_2 ) )
                var_14["outgoing"] = var_2 * var_13;
            else
                var_14 = _ID8561( var_10, var_11, var_7["incoming"] );
        }

        if ( var_4 )
        {
            var_5.segments[var_9] = csplineseg_calccoeffscapspeed( var_10, var_11, var_14["outgoing"], var_7["incoming"], var_13 );
            var_6 += var_5.segments[var_9]._ID11597;
            continue;
        }

        var_5.segments[var_9] = csplineseg_calccoeffs( var_10, var_11, var_14["outgoing"], var_7["incoming"] );
        var_6 += var_13;
    }

    var_9 = var_5.segments.size;
    var_10 = var_0[var_9].origin;
    var_11 = var_0[var_9 + 1].origin;
    var_13 = var_8;
    var_14 = var_7;

    if ( var_9 == 0 && isdefined( var_2 ) )
        var_14["outgoing"] = var_2 * var_13;

    if ( isdefined( var_3 ) )
        var_7["incoming"] = var_3 * var_13;
    else
        var_7 = _ID8561( var_10, var_11, var_14["outgoing"] );

    if ( var_9 == 0 && !isdefined( var_2 ) )
        var_14 = _ID8561( var_10, var_11, var_7["incoming"] );

    if ( var_4 )
    {
        var_5.segments[var_9] = csplineseg_calccoeffscapspeed( var_10, var_11, var_14["outgoing"], var_7["incoming"], var_13 );
        var_6 += var_5.segments[var_9]._ID11597;
    }
    else
    {
        var_5.segments[var_9] = csplineseg_calccoeffs( var_10, var_11, var_14["outgoing"], var_7["incoming"] );
        var_6 += var_13;
    }

    var_5.segments[var_9]._ID11597 = var_6;

    if ( var_1 )
    {
        var_15 = 0;
        var_16 = 0;

        for ( var_9 = 0; var_9 < var_5.segments.size; var_9++ )
        {
            if ( !isdefined( var_0[var_9 + 1].speed ) )
                var_0[var_9 + 1].speed = var_0[var_9].speed;

            var_13 = var_5.segments[var_9]._ID11597 - var_16;
            var_17 = 2 * var_13 / ( ( var_0[var_9].speed + var_0[var_9 + 1].speed ) / 20 );
            var_15 += var_17;
            var_5.segments[var_9].endtime = var_15;
            var_16 = var_5.segments[var_9]._ID11597;
            var_5.segments[var_9]._ID30984 = var_0[var_9].speed / 20;
            var_5.segments[var_9]._ID30979 = var_0[var_9 + 1].speed / 20;
        }
    }
    else
    {
        for ( var_9 = 0; var_9 < var_5.segments.size; var_9++ )
        {
            var_5.segments[var_9].endtime = var_5.segments[var_9]._ID11597;
            var_5.segments[var_9]._ID30984 = 1;
            var_5.segments[var_9]._ID30979 = 1;
        }
    }

    return var_5;
}

_ID8574( var_0, var_1, var_2 )
{
    var_3 = spawnstruct();
    var_3.segments = [];
    var_4 = csplineseg_getpoint( var_0.segments[0], 1 );
    var_5 = var_4["pos"] - var_1;
    var_6 = length( var_5 );
    var_3.segments[0] = csplineseg_calccoeffs( var_1, var_4["pos"], var_2 * var_6, var_4["vel"] );
    var_3.segments[0].endtime = var_0.segments[0].endtime * var_6 / var_0.segments[0]._ID11597;
    var_3.segments[0]._ID11597 = var_6;
    var_7 = var_6 - var_0.segments[0]._ID11597;
    var_8 = var_3.segments[0].endtime - var_0.segments[0].endtime;

    for ( var_9 = 1; var_9 < var_0.segments.size; var_9++ )
    {
        var_3.segments[var_9] = _ID8586( var_0.segments[var_9] );
        var_3.segments[var_9]._ID11597 = var_3.segments[var_9]._ID11597 + var_7;
        var_3.segments[var_9].endtime = var_3.segments[var_9].endtime + var_8;
    }

    return var_3;
}

_ID8565( var_0, var_1, var_2 )
{
    if ( var_1 <= 0 )
    {
        var_3 = var_0.segments[0]._ID11597;
        var_4 = csplineseg_getpoint( var_0.segments[0], 0, var_3, var_0.segments[0]._ID30984 );
        return var_4;
    }
    else if ( var_1 >= var_0.segments[var_0.segments.size - 1]._ID11597 )
    {
        if ( var_0.segments.size > 1 )
            var_3 = var_0.segments[var_0.segments.size - 1]._ID11597 - var_0.segments[var_0.segments.size - 2]._ID11597;
        else
            var_3 = var_0.segments[var_0.segments.size - 1]._ID11597;

        var_4 = csplineseg_getpoint( var_0.segments[var_0.segments.size - 1], 1, var_3, var_0.segments[var_0.segments.size - 1]._ID30979 );
        return var_4;
    }
    else
    {
        for ( var_5 = 0; var_0.segments[var_5]._ID11597 < var_1; var_5++ )
        {

        }

        if ( var_5 > 0 )
            var_6 = var_0.segments[var_5 - 1]._ID11597;
        else
            var_6 = 0;

        var_3 = var_0.segments[var_5]._ID11597 - var_6;
        var_7 = ( var_1 - var_6 ) / var_3;
        var_8 = undefined;

        if ( isdefined( var_2 ) && var_2 )
            var_8 = cspline_speedfromdistance( var_0.segments[var_5]._ID30984, var_0.segments[var_5]._ID30979, var_7 );

        var_4 = csplineseg_getpoint( var_0.segments[var_5], var_7, var_3, var_8 );
        return var_4;
    }
}

_ID8566( var_0, var_1 )
{
    if ( var_1 <= 0 )
    {
        var_2 = var_0.segments[0]._ID11597;
        var_3 = csplineseg_getpoint( var_0.segments[0], 0, var_2, var_0.segments[0]._ID30984 );
        return var_3;
    }
    else if ( var_1 >= var_0.segments[var_0.segments.size - 1].endtime )
    {
        if ( var_0.segments.size > 1 )
            var_2 = var_0.segments[var_0.segments.size - 1]._ID11597 - var_0.segments[var_0.segments.size - 2]._ID11597;
        else
            var_2 = var_0.segments[var_0.segments.size - 1]._ID11597;

        var_3 = csplineseg_getpoint( var_0.segments[var_0.segments.size - 1], 1, var_2, var_0.segments[var_0.segments.size - 1]._ID30979 );
        return var_3;
    }
    else
    {
        for ( var_4 = 0; var_0.segments[var_4].endtime < var_1; var_4++ )
        {

        }

        if ( var_4 > 0 )
        {
            var_5 = var_0.segments[var_4 - 1].endtime;
            var_2 = var_0.segments[var_4]._ID11597 - var_0.segments[var_4 - 1]._ID11597;
        }
        else
        {
            var_5 = 0;
            var_2 = var_0.segments[0]._ID11597;
        }

        var_6 = var_0.segments[var_4].endtime - var_5;
        var_7 = ( var_1 - var_5 ) / var_6;
        var_8 = var_0.segments[var_4]._ID30984 + var_7 * ( var_0.segments[var_4]._ID30979 - var_0.segments[var_4]._ID30984 );
        var_9 = ( var_1 - var_5 ) * ( var_0.segments[var_4]._ID30984 + var_8 ) / 2;
        var_10 = var_9 / var_2;
        var_3 = csplineseg_getpoint( var_0.segments[var_4], var_10, var_2, var_8 );
        return var_3;
    }
}

cspline_speedfromdistance( var_0, var_1, var_2 )
{
    var_3 = var_2;
    var_4 = ( var_1 - var_0 ) * ( var_1 + var_0 ) / 2;
    return sqrt( 2 * var_4 * var_3 + var_0 * var_0 );
}

cspline_adjusttime( var_0, var_1 )
{
    var_2 = cspline_time( var_0 );
    var_3 = var_0.segments[0].endtime;
    var_4 = var_0.segments[var_0.segments.size - 2].endtime - var_3;
    var_5 = var_0.segments[var_0.segments.size - 1].endtime - var_0.segments[var_0.segments.size - 2].endtime;
    var_6 = 2 * var_3 + var_4 + 2 * var_5 - var_1;
    var_7 = ( sqrt( var_6 * var_6 + 4 * var_4 * var_1 ) + var_6 ) / 2 * var_1;
    var_9 = undefined;
    var_10 = undefined;
    var_0.segments[0]._ID30979 = var_0.segments[0]._ID30979 * var_7;
    var_11 = var_0.segments[0].endtime * ( 1 / var_7 - 2 / ( 1 + var_7 ) );
    var_0.segments[0].endtime = var_0.segments[0].endtime / ( ( 1 + var_7 ) / 2 );

    for ( var_12 = 1; var_12 < var_0.segments.size - 1; var_12++ )
    {
        var_13 = undefined;
        var_0.segments[var_12]._ID30984 = var_0.segments[var_12]._ID30984 * var_7;
        var_0.segments[var_12]._ID30979 = var_0.segments[var_12]._ID30979 * var_7;
        var_0.segments[var_12].endtime = var_0.segments[var_12].endtime / var_7;
        var_0.segments[var_12].endtime = var_0.segments[var_12].endtime - var_11;
    }

    var_12 = var_0.segments.size - 1;
    var_0.segments[var_12]._ID30984 = var_0.segments[var_12]._ID30984 * var_7;
    var_0.segments[var_12].endtime = var_1;
}

_ID8569( var_0, var_1, var_2, var_3 )
{
    var_4 = cspline_makenoisepathnodes( var_0, var_1, var_2 );

    if ( isdefined( var_3 ) )
        var_4[1].origin = var_3;

    var_5 = spawnstruct();
    var_5.origin = var_4[0].origin;
    var_4[var_4.size] = var_5;
    var_5 = spawnstruct();
    var_5.origin = var_4[1].origin;
    var_4[var_4.size] = var_5;
    var_5 = spawnstruct();
    var_5.origin = var_4[2].origin;
    var_4[var_4.size] = var_5;
    var_6 = cspline_makepath( var_4 );
    var_7 = spawnstruct();
    var_7.segments = [];

    for ( var_8 = 0; var_8 < var_6.segments.size - 2; var_8++ )
    {
        var_7.segments[var_8] = _ID8586( var_6.segments[var_8 + 1] );
        var_7.segments[var_8]._ID11597 = var_8 + 1;
    }

    return var_7;
}

cspline_makenoisepathnodes( var_0, var_1, var_2 )
{
    var_3 = [];

    for ( var_4 = 0; var_4 < var_0; var_4++ )
    {
        var_3[var_4] = spawnstruct();
        var_5 = randomfloatrange( var_1[0], var_2[0] );
        var_6 = randomfloatrange( var_1[1], var_2[1] );
        var_7 = randomfloatrange( var_1[2], var_2[2] );
        var_3[var_4].origin = ( var_5, var_6, var_7 );
    }

    return var_3;
}

cspline_test( var_0, var_1 )
{

}

cspline_testnodes( var_0, var_1 )
{
    var_2 = 20;
    var_3 = undefined;

    foreach ( var_5 in var_0 )
    {
        if ( isdefined( var_3 ) )
            thread common_scripts\utility::draw_arrow_time( var_3.origin, var_5.origin, ( 0, 1, 0 ), var_1 );

        var_3 = var_5;
    }

    foreach ( var_5 in var_0 )
    {
        thread common_scripts\utility::_ID10844( var_5.origin - ( var_2, 0, 0 ), var_5.origin + ( var_2, 0, 0 ), 1, 1, 0, var_1 );
        thread common_scripts\utility::_ID10844( var_5.origin - ( 0, var_2, 0 ), var_5.origin + ( 0, var_2, 0 ), 1, 1, 0, var_1 );
        thread common_scripts\utility::_ID10844( var_5.origin - ( 0, 0, var_2 ), var_5.origin + ( 0, 0, var_2 ), 1, 1, 0, var_1 );
    }
}

_ID8586( var_0 )
{
    var_1 = spawnstruct();
    var_2 = 3;

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_1._ID21843[var_3] = var_0._ID21843[var_3];
        var_1._ID21842[var_3] = var_0._ID21842[var_3];
        var_1._ID21841[var_3] = var_0._ID21841[var_3];
        var_1.c[var_3] = var_0.c[var_3];
    }

    var_1._ID11597 = var_0._ID11597;
    var_1.endtime = var_0.endtime;
    return var_1;
}

_ID8568( var_0 )
{
    return var_0.segments[var_0.segments.size - 1]._ID11597;
}

cspline_time( var_0 )
{
    return var_0.segments[var_0.segments.size - 1].endtime;
}

cspline_initnoise( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_5 = var_1;
    var_4._ID19347 = var_2;
    var_6 = ( var_0[0] - var_5, var_0[1] - var_5, var_0[2] - var_5 );
    var_7 = ( var_0[0] + var_5, var_0[1] + var_5, var_0[2] + var_5 );
    var_3 = ( var_0[0], var_0[1], var_0[2] - var_5 );
    var_4.largescale = _ID8569( 10, var_6, var_7, var_3 );
    var_4.largescale.length = var_4.largescale.segments[var_4.largescale.segments.size - 1]._ID11597;
    thread cspline_test( var_4.largescale, 20 );
    return var_4;
}

cspline_noise( var_0, var_1 )
{
    var_2 = common_scripts\utility::mod( var_1 / var_0._ID19347, var_0.largescale.length );
    var_3 = _ID8565( var_0.largescale, var_2 );
    return var_3["pos"];
}
