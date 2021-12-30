// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

delete_on_notify( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "death" );
    common_scripts\utility::_ID35626( var_1, var_2, var_3 );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

_ID3856( var_0, var_1 )
{
    var_2 = [];
    var_2[0] = var_0[0];
    var_3 = [];
    var_3[0] = var_1[0];

    for ( var_4 = 1; var_4 < var_0.size; var_4++ )
    {
        var_5 = 0;

        for ( var_6 = 0; var_6 < var_2.size; var_6++ )
        {
            if ( var_1[var_4] < var_3[var_6] )
            {
                for ( var_7 = var_2.size - 1; var_7 >= var_6; var_7-- )
                {
                    var_2[var_7 + 1] = var_2[var_7];
                    var_3[var_7 + 1] = var_3[var_7];
                }

                var_2[var_6] = var_0[var_4];
                var_3[var_6] = var_1[var_4];
                var_5 = 1;
                break;
            }
        }

        if ( !var_5 )
        {
            var_2[var_4] = var_0[var_4];
            var_3[var_4] = var_1[var_4];
        }
    }

    return var_2;
}

array_sortbysorter( var_0 )
{
    var_1 = [];
    var_1[0] = var_0[0];

    for ( var_2 = 1; var_2 < var_0.size; var_2++ )
    {
        var_3 = 0;

        for ( var_4 = 0; var_4 < var_1.size; var_4++ )
        {
            if ( var_0[var_2].sorter < var_1[var_4].sorter )
            {
                for ( var_5 = var_1.size - 1; var_5 >= var_4; var_5-- )
                    var_1[var_5 + 1] = var_1[var_5];

                var_1[var_4] = var_0[var_2];
                var_3 = 1;
                break;
            }
        }

        if ( !var_3 )
            var_1[var_2] = var_0[var_2];
    }

    return var_1;
}

_ID35508( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self endon( "death" );

    if ( isdefined( var_1 ) )
    {
        if ( isarray( var_1 ) )
        {
            foreach ( var_8 in var_1 )
                self endon( var_8 );
        }
        else
            self endon( var_1 );
    }

    if ( isstring( var_0 ) )
        self waittill( var_0 );
    else
        wait(var_0);

    if ( isdefined( var_6 ) )
        self [[ var_2 ]]( var_3, var_4, var_5, var_6 );
    else if ( isdefined( var_5 ) )
        self [[ var_2 ]]( var_3, var_4, var_5 );
    else if ( isdefined( var_4 ) )
        self [[ var_2 ]]( var_3, var_4 );
    else if ( isdefined( var_3 ) )
        self [[ var_2 ]]( var_3 );
    else
        self [[ var_2 ]]();
}

_ID35705( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_4 ) )
        var_4 = 0;

    for ( var_5 = 1; var_5; var_5 = var_4 )
    {
        self endon( "death" );

        if ( isdefined( var_3 ) )
            self endon( var_3 );

        self waittill( var_0 );
        var_1 notify( var_2 );
    }
}

_ID20322( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );

    if ( isdefined( var_2 ) )
        self endon( var_2 );

    for (;;)
    {
        var_4 = _ID30041( var_0, var_1, "loop_anim", 0, var_3 );

        if ( common_scripts\utility::_ID18787() )
        {
            self waittillmatch( "loop_anim",  "end"  );
            continue;
        }

        wait(getanimlength( var_4 ));
    }
}

_ID30041( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_2 ) )
        var_2 = "single_anim";

    if ( !isdefined( var_4 ) )
        var_4 = 1;

    if ( isarray( var_0[var_1] ) )
    {
        if ( !isdefined( var_0[var_1 + "weight"] ) )
        {
            var_0[var_1 + "weight"] = [];
            var_5 = getarraykeys( var_0[var_1] );

            foreach ( var_7 in var_5 )
                var_0[var_1 + "weight"][var_7] = 1;
        }

        var_9 = var_0[var_1].size;
        var_10 = 0;

        for ( var_11 = 0; var_11 < var_9; var_11++ )
            var_10 += var_0[var_1 + "weight"][var_11];

        var_12 = randomfloat( var_10 );
        var_13 = 0;

        for ( var_14 = -1; var_13 <= var_12; var_13 += var_0[var_1 + "weight"][var_14] )
            var_14++;

        var_15 = var_0[var_1][var_14];

        if ( isdefined( var_0[var_1 + "mp"] ) )
            var_16 = var_0[var_1 + "mp"][var_14];
        else
            var_16 = undefined;
    }
    else
    {
        var_15 = var_0[var_1];
        var_16 = var_0[var_1 + "mp"];
    }

    if ( common_scripts\utility::_ID18787() )
    {
        if ( isdefined( var_3 ) && var_3 )
            self call [[ level.func["setflaggedanimknobrestart"] ]]( var_2, var_15, 1, 0.1, var_4 );
        else
            self call [[ level.func["setflaggedanimknob"] ]]( var_2, var_15, 1, 0.1, var_4 );
    }
    else
        self call [[ level.func["scriptModelPlayAnim"] ]]( var_16 );

    return var_15;
}

_ID5340( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_4 ) )
        var_4 = 0.1;

    var_0 = clamp( var_0, var_2[0], var_2[var_2.size - 1] );

    for ( var_5 = 0; var_0 > var_2[var_5 + 1]; var_5++ )
    {

    }

    var_6 = var_0 - var_2[var_5];
    var_6 /= ( var_2[var_5 + 1] - var_2[var_5] );

    if ( common_scripts\utility::_ID18787() )
    {
        var_6 = clamp( var_6, 0.01, 0.99 );
        var_7 = var_3[var_5 + 1] / var_3[var_5];
        var_8 = var_6 + ( 1 - var_6 ) * var_7;
        self call [[ level.func["setanimlimited"] ]]( var_1[var_5], 1 - var_6, var_4, var_8 / var_7 );
        self call [[ level.func["setanimlimited"] ]]( var_1[var_5 + 1], var_6, var_4, var_8 );

        for ( var_9 = 0; var_9 < var_5; var_9++ )
        {
            var_7 = var_3[var_5 + 1] / var_3[var_9];
            self call [[ level.func["setanimlimited"] ]]( var_1[var_9], 0.01, var_4, var_8 / var_7 );
        }

        for ( var_9 = var_5 + 2; var_9 < var_2.size; var_9++ )
        {
            var_7 = var_3[var_5 + 1] / var_3[var_9];
            self call [[ level.func["setanimlimited"] ]]( var_1[var_9], 0.01, var_4, var_8 / var_7 );
        }
    }
    else if ( var_6 > 0.5 )
        self call [[ level.func["scriptModelPlayAnim"] ]]( var_1[var_5 + 1] );
    else
        self call [[ level.func["scriptModelPlayAnim"] ]]( var_1[var_5] );
}

_ID9920( var_0 )
{
    if ( common_scripts\utility::_ID18787() )
    {
        self endon( "death" );
        self endon( "damage" );
        self call [[ level._ID20500 ]]( "neutral" );
        self call [[ level.addaieventlistener_func ]]( "projectile_impact" );
        self call [[ level.addaieventlistener_func ]]( "bulletwhizby" );
        self call [[ level.addaieventlistener_func ]]( "gunshot" );
        self call [[ level.addaieventlistener_func ]]( "explode" );

        for (;;)
        {
            self waittill( "ai_event",  var_1  );
            self notify( var_0 );
            self._ID18106 = 1;
            waittillframeend;
            self._ID18106 = 0;
        }
    }
}

detect_people( var_0, var_1, var_2 )
{
    if ( !isarray( var_2 ) )
    {
        var_3 = var_2;
        var_2 = [];
        var_2[0] = var_3;
    }

    foreach ( var_5 in var_2 )
        self endon( var_5 );

    self.detect_people_trigger[var_1] = spawn( "trigger_radius", self.origin, 23, var_0, var_0 );

    for ( var_7 = var_2.size; var_7 < 3; var_7++ )
        var_2[var_7] = undefined;

    thread delete_on_notify( self.detect_people_trigger[var_1], var_2[0], var_2[1], var_2[2] );

    for (;;)
    {
        self.detect_people_trigger[var_1] waittill( "trigger",  var_8  );
        self._ID18108 = var_8;
        self notify( var_1 );
        self._ID18106 = 1;
        waittillframeend;
        self._ID18106 = 0;
    }
}

detect_player_event( var_0, var_1, var_2, var_3 )
{
    if ( !isarray( var_2 ) )
    {
        var_4 = var_2;
        var_2 = [];
        var_2[0] = var_4;
    }

    foreach ( var_6 in var_2 )
        self endon( var_6 );

    for (;;)
    {
        level.player waittill( var_3 );

        if ( distancesquared( level.player.origin, self.origin ) < var_0 * var_0 )
        {
            self notify( var_1 );
            self._ID18108 = level.player;
            self notify( var_1 );
            self._ID18106 = 1;
            waittillframeend;
            self._ID18106 = 0;
        }
    }
}

_ID36429( var_0, var_1 )
{
    var_2 = int( var_0 / var_1 );
    var_3 = var_0 - var_1 * var_2;

    if ( var_0 < 0 )
        var_3 += var_1;

    if ( var_3 == var_1 )
        var_3 = 0;

    return var_3;
}

_ID18085( var_0, var_1, var_2, var_3, var_4, var_5 )
{

}

_ID10873( var_0, var_1, var_2, var_3 )
{
    thread common_scripts\utility::_ID10844( var_0 - ( var_1, 0, 0 ), var_0 + ( var_1, 0, 0 ), var_2[0], var_2[1], var_2[2], var_3 );
    thread common_scripts\utility::_ID10844( var_0 - ( 0, var_1, 0 ), var_0 + ( 0, var_1, 0 ), var_2[0], var_2[1], var_2[2], var_3 );
    thread common_scripts\utility::_ID10844( var_0 - ( 0, 0, var_1 ), var_0 + ( 0, 0, var_1 ), var_2[0], var_2[1], var_2[2], var_3 );
}

_ID10870( var_0, var_1, var_2, var_3 )
{
    var_4 = 16;

    for ( var_5 = 0; var_5 < 360; var_5 += 360 / var_4 )
    {
        var_6 = var_5 + 360 / var_4;
        thread common_scripts\utility::_ID10844( var_0 + ( var_1 * cos( var_5 ), var_1 * sin( var_5 ), 0 ), var_0 + ( var_1 * cos( var_6 ), var_1 * sin( var_6 ), 0 ), var_2[0], var_2[1], var_2[2], var_3 );
    }
}

_ID10872( var_0, var_1, var_2, var_3, var_4 )
{
    if ( var_4 == 0 )
        return;

    var_5 = 16;
    var_6 = int( 1 + var_5 * abs( var_4 ) / 360 );

    for ( var_7 = 0; var_7 < var_6; var_7++ )
    {
        var_8 = var_7 * var_4 / var_6;
        var_9 = var_8 + var_4 / var_6;
        thread common_scripts\utility::_ID10844( var_0 + ( var_1 * cos( var_8 ), var_1 * sin( var_8 ), 0 ), var_0 + ( var_1 * cos( var_9 ), var_1 * sin( var_9 ), 0 ), var_2[0], var_2[1], var_2[2], var_3 );
    }

    var_8 = var_4;
    var_9 = var_4 - common_scripts\utility::sign( var_4 ) * 20;
    thread common_scripts\utility::_ID10844( var_0 + ( var_1 * cos( var_8 ), var_1 * sin( var_8 ), 0 ), var_0 + ( var_1 * 0.8 * cos( var_9 ), var_1 * 0.8 * sin( var_9 ), 0 ), var_2[0], var_2[1], var_2[2], var_3 );
    thread common_scripts\utility::_ID10844( var_0 + ( var_1 * cos( var_8 ), var_1 * sin( var_8 ), 0 ), var_0 + ( var_1 * 1.2 * cos( var_9 ), var_1 * 1.2 * sin( var_9 ), 0 ), var_2[0], var_2[1], var_2[2], var_3 );
}

_ID18650( var_0, var_1 )
{
    foreach ( var_3 in var_1 )
    {
        if ( var_0 == var_3 )
            return 1;
    }

    return 0;
}

_ID21967( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = 5;
    var_8 = ( var_0 + var_1 ) / 2;

    for ( var_9 = var_6 + 1; abs( var_9 ) > var_6 && var_7 > 0; var_7-- )
    {
        var_10 = var_2 * var_8 * var_8 * var_8 + var_3 * var_8 * var_8 + var_4 * var_8 + var_5;
        var_11 = 3 * var_2 * var_8 * var_8 + 2 * var_3 * var_8 + var_4;
        var_9 = -1 * var_10 / var_11;
        var_12 = var_8;
        var_8 += var_9;

        if ( var_8 > var_1 )
        {
            var_8 = ( var_12 + 3 * var_1 ) / 4;
            continue;
        }

        if ( var_8 < var_0 )
            var_8 = ( var_12 + 3 * var_0 ) / 4;
    }

    return var_8;
}

_ID26677( var_0, var_1, var_2, var_3 )
{
    if ( var_0 == 0 )
        return rootsofquadratic( var_1, var_2, var_3 );

    var_4 = 2 * var_1 * var_1 * var_1 - 9 * var_0 * var_1 * var_2 + 27 * var_0 * var_0 * var_3;
    var_5 = var_1 * var_1 - 3 * var_0 * var_2;

    if ( var_5 == 0 )
    {

    }

    if ( var_4 == 0 && var_5 == 0 )
        var_6[0] = -1 * var_1 / 3 * var_0;
    else if ( var_4 == 0 && var_5 != 0 )
        var_6[0] = ( 9 * var_0 * var_0 * var_3 - 4 * var_0 * var_1 * var_2 + var_1 * var_1 * var_1 ) / var_0 * ( 3 * var_0 * var_2 - var_1 * var_1 );
    else
    {

    }
}

rootsofquadratic( var_0, var_1, var_2 )
{
    while ( abs( var_0 ) > 65536 || abs( var_1 ) > 65536 || abs( var_2 ) > 65536 )
    {
        var_0 /= 10;
        var_1 /= 10;
        var_2 /= 10;
    }

    var_3 = [];

    if ( var_0 == 0 )
    {
        if ( var_1 != 0 )
            var_3[0] = -1 * var_2 / var_1;
    }
    else
    {
        var_4 = var_1 * var_1 - 4 * var_0 * var_2;

        if ( var_4 > 0 )
        {
            var_3[0] = ( -1 * var_1 - sqrt( var_4 ) ) / 2 * var_0;
            var_3[1] = ( -1 * var_1 + sqrt( var_4 ) ) / 2 * var_0;
        }
        else if ( var_4 == 0 )
            var_3[0] = -1 * var_1 / 2 * var_0;
    }

    return var_3;
}

_ID22129( var_0, var_1 )
{
    var_2 = 0;

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        var_4 = var_0[var_3];

        if ( isdefined( var_1 ) )
            var_4 -= var_1[var_3];

        var_2 += var_4 * var_4;
    }

    return sqrt( var_2 );
}

clampandnormalize( var_0, var_1, var_2 )
{
    if ( var_1 < var_2 )
        var_0 = clamp( var_0, var_1, var_2 );
    else
        var_0 = clamp( var_0, var_2, var_1 );

    return ( var_0 - var_1 ) / ( var_2 - var_1 );
}

pointoncircle( var_0, var_1, var_2 )
{
    var_3 = cos( var_2 );
    var_3 *= var_1;
    var_3 += var_0[0];
    var_4 = sin( var_2 );
    var_4 *= var_1;
    var_4 += var_0[1];
    var_5 = var_0[2];
    return ( var_3, var_4, var_5 );
}

_ID36516( var_0, var_1 )
{
    return ( var_0[0] * ( var_1 != 0 ), var_0[1] * ( var_1 != 1 ), var_0[2] * ( var_1 != 2 ) );
}

_ID26721( var_0, var_1 )
{
    if ( var_1 == 0 )
        return ( var_0[0], var_0[2], -1 * var_0[1] );
    else if ( var_1 == 1 )
        return ( -1 * var_0[2], var_0[1], var_0[0] );
    else
        return ( var_0[1], -1 * var_0[0], var_0[2] );
}
