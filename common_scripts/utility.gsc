// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID22149( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( level.func ) )
        return;

    if ( !isdefined( level.func[var_0] ) )
        return;

    if ( !isdefined( var_1 ) )
    {
        call [[ level.func[var_0] ]]();
        return;
    }

    if ( !isdefined( var_2 ) )
    {
        call [[ level.func[var_0] ]]( var_1 );
        return;
    }

    if ( !isdefined( var_3 ) )
    {
        call [[ level.func[var_0] ]]( var_1, var_2 );
        return;
    }

    if ( !isdefined( var_4 ) )
    {
        call [[ level.func[var_0] ]]( var_1, var_2, var_3 );
        return;
    }

    call [[ level.func[var_0] ]]( var_1, var_2, var_3, var_4 );
}

self_func( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( level.func[var_0] ) )
        return;

    if ( !isdefined( var_1 ) )
    {
        self call [[ level.func[var_0] ]]();
        return;
    }

    if ( !isdefined( var_2 ) )
    {
        self call [[ level.func[var_0] ]]( var_1 );
        return;
    }

    if ( !isdefined( var_3 ) )
    {
        self call [[ level.func[var_0] ]]( var_1, var_2 );
        return;
    }

    if ( !isdefined( var_4 ) )
    {
        self call [[ level.func[var_0] ]]( var_1, var_2, var_3 );
        return;
    }

    self call [[ level.func[var_0] ]]( var_1, var_2, var_3, var_4 );
}

randomvector( var_0 )
{
    return ( randomfloat( var_0 ) - var_0 * 0.5, randomfloat( var_0 ) - var_0 * 0.5, randomfloat( var_0 ) - var_0 * 0.5 );
}

randomvectorrange( var_0, var_1 )
{
    var_2 = randomfloatrange( var_0, var_1 );

    if ( randomint( 2 ) == 0 )
        var_2 *= -1;

    var_3 = randomfloatrange( var_0, var_1 );

    if ( randomint( 2 ) == 0 )
        var_3 *= -1;

    var_4 = randomfloatrange( var_0, var_1 );

    if ( randomint( 2 ) == 0 )
        var_4 *= -1;

    return ( var_2, var_3, var_4 );
}

sign( var_0 )
{
    if ( var_0 >= 0 )
        return 1;

    return -1;
}

mod( var_0, var_1 )
{
    var_2 = int( var_0 / var_1 );

    if ( var_0 * var_1 < 0 )
        var_2 -= 1;

    return var_0 - var_2 * var_1;
}

_ID33254( var_0 )
{
    if ( isdefined( self.current_target ) )
    {
        if ( var_0 == self.current_target )
            return;
    }

    self.current_target = var_0;
}

_ID14447( var_0 )
{
    var_1 = [];
    var_1["axis"] = "allies";
    var_1["allies"] = "axis";
    return var_1[var_0];
}

clear_exception( var_0 )
{
    self.exception[var_0] = anim.defaultexception;
}

_ID28339( var_0, var_1 )
{
    self.exception[var_0] = var_1;
}

set_all_exceptions( var_0 )
{
    var_1 = getarraykeys( self.exception );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        self.exception[var_1[var_2]] = var_0;
}

_ID7657()
{
    return randomint( 100 ) >= 50;
}

choose_from_weighted_array( var_0, var_1 )
{
    var_2 = randomint( var_1[var_1.size - 1] + 1 );

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        if ( var_2 <= var_1[var_3] )
            return var_0[var_3];
    }
}

get_cumulative_weights( var_0 )
{
    var_1 = [];
    var_2 = 0;

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        var_2 += var_0[var_3];
        var_1[var_3] = var_2;
    }

    return var_1;
}

_ID35742( var_0, var_1 )
{
    if ( var_0 != "death" )
        self endon( "death" );

    var_1 endon( "die" );
    self waittill( var_0 );
    var_1 notify( "returned",  var_0  );
}

_ID35743( var_0, var_1 )
{
    var_1 endon( "die" );
    self waittill( var_0 );
    var_1 notify( "returned",  var_0  );
}

_ID35699( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );
    var_5 = spawnstruct();
    var_5._ID32914 = 0;

    if ( isdefined( var_0 ) )
    {
        childthread _ID35742( var_0, var_5 );
        var_5._ID32914++;
    }

    if ( isdefined( var_1 ) )
    {
        childthread _ID35742( var_1, var_5 );
        var_5._ID32914++;
    }

    if ( isdefined( var_2 ) )
    {
        childthread _ID35742( var_2, var_5 );
        var_5._ID32914++;
    }

    if ( isdefined( var_3 ) )
    {
        childthread _ID35742( var_3, var_5 );
        var_5._ID32914++;
    }

    if ( isdefined( var_4 ) )
    {
        childthread _ID35742( var_4, var_5 );
        var_5._ID32914++;
    }

    while ( var_5._ID32914 )
    {
        var_5 waittill( "returned" );
        var_5._ID32914--;
    }

    var_5 notify( "die" );
}

_ID35700( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    self endon( "death" );
    var_8 = spawnstruct();
    var_8._ID32914 = 0;

    if ( isdefined( var_0 ) )
    {
        var_0 childthread _ID35742( var_1, var_8 );
        var_8._ID32914++;
    }

    if ( isdefined( var_2 ) )
    {
        var_2 childthread _ID35742( var_3, var_8 );
        var_8._ID32914++;
    }

    if ( isdefined( var_4 ) )
    {
        var_4 childthread _ID35742( var_5, var_8 );
        var_8._ID32914++;
    }

    if ( isdefined( var_6 ) )
    {
        var_6 childthread _ID35742( var_7, var_8 );
        var_8._ID32914++;
    }

    while ( var_8._ID32914 )
    {
        var_8 waittill( "returned" );
        var_8._ID32914--;
    }

    var_8 notify( "die" );
}

_ID35635( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( ( !isdefined( var_0 ) || var_0 != "death" ) && ( !isdefined( var_1 ) || var_1 != "death" ) && ( !isdefined( var_2 ) || var_2 != "death" ) && ( !isdefined( var_3 ) || var_3 != "death" ) && ( !isdefined( var_4 ) || var_4 != "death" ) && ( !isdefined( var_5 ) || var_5 != "death" ) )
        self endon( "death" );

    var_6 = spawnstruct();

    if ( isdefined( var_0 ) )
        childthread _ID35742( var_0, var_6 );

    if ( isdefined( var_1 ) )
        childthread _ID35742( var_1, var_6 );

    if ( isdefined( var_2 ) )
        childthread _ID35742( var_2, var_6 );

    if ( isdefined( var_3 ) )
        childthread _ID35742( var_3, var_6 );

    if ( isdefined( var_4 ) )
        childthread _ID35742( var_4, var_6 );

    if ( isdefined( var_5 ) )
        childthread _ID35742( var_5, var_6 );

    var_6 waittill( "returned",  var_7  );
    var_6 notify( "die" );
    return var_7;
}

waittill_any_return_no_endon_death( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = spawnstruct();

    if ( isdefined( var_0 ) )
        childthread _ID35743( var_0, var_6 );

    if ( isdefined( var_1 ) )
        childthread _ID35743( var_1, var_6 );

    if ( isdefined( var_2 ) )
        childthread _ID35743( var_2, var_6 );

    if ( isdefined( var_3 ) )
        childthread _ID35743( var_3, var_6 );

    if ( isdefined( var_4 ) )
        childthread _ID35743( var_4, var_6 );

    if ( isdefined( var_5 ) )
        childthread _ID35743( var_5, var_6 );

    var_6 waittill( "returned",  var_7  );
    var_6 notify( "die" );
    return var_7;
}

_ID35630( var_0 )
{
    var_1 = spawnstruct();
    var_2 = 0;

    foreach ( var_4 in var_0 )
    {
        childthread _ID35742( var_4, var_1 );

        if ( var_4 == "death" )
            var_2 = 1;
    }

    if ( !var_2 )
        self endon( "death" );

    var_1 waittill( "returned",  var_6  );
    var_1 notify( "die" );
    return var_6;
}

waittill_any_in_array_return_no_endon_death( var_0 )
{
    var_1 = spawnstruct();

    foreach ( var_3 in var_0 )
        childthread _ID35743( var_3, var_1 );

    var_1 waittill( "returned",  var_5  );
    var_1 notify( "die" );
    return var_5;
}

_ID35628( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_3 = 0;

    foreach ( var_5 in var_0 )
    {
        childthread _ID35742( var_5, var_2 );

        if ( var_5 == "death" )
            var_3 = 1;
    }

    if ( !var_3 )
        self endon( "death" );

    var_2 childthread _timeout( var_1 );
    var_2 waittill( "returned",  var_7  );
    var_2 notify( "die" );
    return var_7;
}

waittill_any_in_array_or_timeout_no_endon_death( var_0, var_1 )
{
    var_2 = spawnstruct();

    foreach ( var_4 in var_0 )
        childthread _ID35743( var_4, var_2 );

    var_2 thread _timeout( var_1 );
    var_2 waittill( "returned",  var_6  );
    var_2 notify( "die" );
    return var_6;
}

_ID35637( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( ( !isdefined( var_1 ) || var_1 != "death" ) && ( !isdefined( var_2 ) || var_2 != "death" ) && ( !isdefined( var_3 ) || var_3 != "death" ) && ( !isdefined( var_4 ) || var_4 != "death" ) && ( !isdefined( var_5 ) || var_5 != "death" ) && ( !isdefined( var_6 ) || var_6 != "death" ) )
        self endon( "death" );

    var_7 = spawnstruct();

    if ( isdefined( var_1 ) )
        childthread _ID35742( var_1, var_7 );

    if ( isdefined( var_2 ) )
        childthread _ID35742( var_2, var_7 );

    if ( isdefined( var_3 ) )
        childthread _ID35742( var_3, var_7 );

    if ( isdefined( var_4 ) )
        childthread _ID35742( var_4, var_7 );

    if ( isdefined( var_5 ) )
        childthread _ID35742( var_5, var_7 );

    if ( isdefined( var_6 ) )
        childthread _ID35742( var_6, var_7 );

    var_7 childthread _timeout( var_0 );
    var_7 waittill( "returned",  var_8  );
    var_7 notify( "die" );
    return var_8;
}

_timeout( var_0 )
{
    self endon( "die" );
    wait(var_0);
    self notify( "returned",  "timeout"  );
}

_ID35638( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = spawnstruct();

    if ( isdefined( var_1 ) )
        childthread _ID35743( var_1, var_6 );

    if ( isdefined( var_2 ) )
        childthread _ID35743( var_2, var_6 );

    if ( isdefined( var_3 ) )
        childthread _ID35743( var_3, var_6 );

    if ( isdefined( var_4 ) )
        childthread _ID35743( var_4, var_6 );

    if ( isdefined( var_5 ) )
        childthread _ID35743( var_5, var_6 );

    var_6 childthread _timeout( var_0 );
    var_6 waittill( "returned",  var_7  );
    var_6 notify( "die" );
    return var_7;
}

_ID35626( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( isdefined( var_1 ) )
        self endon( var_1 );

    if ( isdefined( var_2 ) )
        self endon( var_2 );

    if ( isdefined( var_3 ) )
        self endon( var_3 );

    if ( isdefined( var_4 ) )
        self endon( var_4 );

    if ( isdefined( var_5 ) )
        self endon( var_5 );

    if ( isdefined( var_6 ) )
        self endon( var_6 );

    if ( isdefined( var_7 ) )
        self endon( var_7 );

    self waittill( var_0 );
}

_ID35627( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13 )
{
    if ( isdefined( var_2 ) && isdefined( var_3 ) )
        var_2 endon( var_3 );

    if ( isdefined( var_4 ) && isdefined( var_5 ) )
        var_4 endon( var_5 );

    if ( isdefined( var_6 ) && isdefined( var_7 ) )
        var_6 endon( var_7 );

    if ( isdefined( var_8 ) && isdefined( var_9 ) )
        var_8 endon( var_9 );

    if ( isdefined( var_10 ) && isdefined( var_11 ) )
        var_10 endon( var_11 );

    if ( isdefined( var_12 ) && isdefined( var_13 ) )
        var_12 endon( var_13 );

    var_0 waittill( var_1 );
}

isflashed()
{
    if ( !isdefined( self.flashendtime ) )
        return 0;

    return gettime() < self.flashendtime;
}

flag_exist( var_0 )
{
    return isdefined( level._ID13177[var_0] );
}

_ID13177( var_0 )
{
    return level._ID13177[var_0];
}

_ID17737()
{
    level._ID13177 = [];
    level._ID13223 = [];
    level.generic_index = 0;

    if ( !isdefined( level._ID30507 ) )
        level._ID30507 = ::empty_init_func;

    level._ID13197 = spawnstruct();
    level._ID13197 assign_unique_id();
}

_ID13189( var_0 )
{
    if ( !isdefined( level._ID13177 ) )
        _ID17737();

    level._ID13177[var_0] = 0;

    if ( !isdefined( level._ID33610 ) )
    {
        _ID17858();
        level._ID33610[var_0] = [];
    }
    else if ( !isdefined( level._ID33610[var_0] ) )
        level._ID33610[var_0] = [];

    if ( issuffix( var_0, "aa_" ) )
        thread [[ level._ID30507 ]]( var_0 );
}

empty_init_func( var_0 )
{

}

issuffix( var_0, var_1 )
{
    if ( var_1.size > var_0.size )
        return 0;

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( var_0[var_2] != var_1[var_2] )
            return 0;
    }

    return 1;
}

flag_set( var_0, var_1 )
{
    level._ID13177[var_0] = 1;
    _ID28591( var_0 );

    if ( isdefined( var_1 ) )
        level notify( var_0,  var_1  );
    else
        level notify( var_0 );
}

assign_unique_id()
{
    self._ID34212 = "generic" + level.generic_index;
    level.generic_index++;
}

flag_wait( var_0 )
{
    var_1 = undefined;

    while ( !_ID13177( var_0 ) )
    {
        var_1 = undefined;
        level waittill( var_0,  var_1  );
    }

    if ( isdefined( var_1 ) )
        return var_1;
}

_ID13180( var_0 )
{
    if ( !_ID13177( var_0 ) )
        return;

    level._ID13177[var_0] = 0;
    _ID28591( var_0 );
    level notify( var_0 );
}

_ID13216( var_0 )
{
    while ( _ID13177( var_0 ) )
        level waittill( var_0 );
}

_ID35663( var_0, var_1 )
{
    self endon( var_0 );
    self waittill( var_1 );
}

array_thread_amortized( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    if ( !isdefined( var_3 ) )
    {
        foreach ( var_13 in var_0 )
        {
            var_13 thread [[ var_1 ]]();
            wait(var_2);
        }
    }
    else
    {
        if ( !isdefined( var_4 ) )
        {
            foreach ( var_13 in var_0 )
            {
                var_13 thread [[ var_1 ]]( var_3 );
                wait(var_2);
            }

            return;
        }

        if ( !isdefined( var_5 ) )
        {
            foreach ( var_13 in var_0 )
            {
                var_13 thread [[ var_1 ]]( var_3, var_4 );
                wait(var_2);
            }

            return;
        }

        if ( !isdefined( var_6 ) )
        {
            foreach ( var_13 in var_0 )
            {
                var_13 thread [[ var_1 ]]( var_3, var_4, var_5 );
                wait(var_2);
            }

            return;
        }

        if ( !isdefined( var_7 ) )
        {
            foreach ( var_13 in var_0 )
            {
                var_13 thread [[ var_1 ]]( var_3, var_4, var_5, var_6 );
                wait(var_2);
            }

            return;
        }

        if ( !isdefined( var_8 ) )
        {
            foreach ( var_13 in var_0 )
            {
                var_13 thread [[ var_1 ]]( var_3, var_4, var_5, var_6, var_7 );
                wait(var_2);
            }

            return;
        }

        if ( !isdefined( var_9 ) )
        {
            foreach ( var_13 in var_0 )
            {
                var_13 thread [[ var_1 ]]( var_3, var_4, var_5, var_6, var_7, var_8 );
                wait(var_2);
            }

            return;
        }

        if ( !isdefined( var_10 ) )
        {
            foreach ( var_13 in var_0 )
            {
                var_13 thread [[ var_1 ]]( var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
                wait(var_2);
            }

            return;
        }

        if ( !isdefined( var_11 ) )
        {
            foreach ( var_13 in var_0 )
            {
                var_13 thread [[ var_1 ]]( var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );
                wait(var_2);
            }

            return;
        }

        foreach ( var_13 in var_0 )
        {
            var_13 thread [[ var_1 ]]( var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );
            wait(var_2);
        }
    }
}

_ID3867( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    if ( !isdefined( var_2 ) )
    {
        foreach ( var_12 in var_0 )
            var_12 thread [[ var_1 ]]();
    }
    else
    {
        if ( !isdefined( var_3 ) )
        {
            foreach ( var_12 in var_0 )
                var_12 thread [[ var_1 ]]( var_2 );

            return;
        }

        if ( !isdefined( var_4 ) )
        {
            foreach ( var_12 in var_0 )
                var_12 thread [[ var_1 ]]( var_2, var_3 );

            return;
        }

        if ( !isdefined( var_5 ) )
        {
            foreach ( var_12 in var_0 )
                var_12 thread [[ var_1 ]]( var_2, var_3, var_4 );

            return;
        }

        if ( !isdefined( var_6 ) )
        {
            foreach ( var_12 in var_0 )
                var_12 thread [[ var_1 ]]( var_2, var_3, var_4, var_5 );

            return;
        }

        if ( !isdefined( var_7 ) )
        {
            foreach ( var_12 in var_0 )
                var_12 thread [[ var_1 ]]( var_2, var_3, var_4, var_5, var_6 );

            return;
        }

        if ( !isdefined( var_8 ) )
        {
            foreach ( var_12 in var_0 )
                var_12 thread [[ var_1 ]]( var_2, var_3, var_4, var_5, var_6, var_7 );

            return;
        }

        if ( !isdefined( var_9 ) )
        {
            foreach ( var_12 in var_0 )
                var_12 thread [[ var_1 ]]( var_2, var_3, var_4, var_5, var_6, var_7, var_8 );

            return;
        }

        if ( !isdefined( var_10 ) )
        {
            foreach ( var_12 in var_0 )
                var_12 thread [[ var_1 ]]( var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

            return;
        }

        foreach ( var_12 in var_0 )
            var_12 thread [[ var_1 ]]( var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );
    }
}

array_call( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_4 ) )
    {
        foreach ( var_6 in var_0 )
            var_6 call [[ var_1 ]]( var_2, var_3, var_4 );

        return;
    }

    if ( isdefined( var_3 ) )
    {
        foreach ( var_6 in var_0 )
            var_6 call [[ var_1 ]]( var_2, var_3 );

        return;
    }

    if ( isdefined( var_2 ) )
    {
        foreach ( var_6 in var_0 )
            var_6 call [[ var_1 ]]( var_2 );

        return;
    }

    foreach ( var_6 in var_0 )
        var_6 call [[ var_1 ]]();
}

_ID22146( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_4 ) )
    {
        foreach ( var_6 in var_0 )
            call [[ var_1 ]]( var_6, var_2, var_3, var_4 );

        return;
    }

    if ( isdefined( var_3 ) )
    {
        foreach ( var_6 in var_0 )
            call [[ var_1 ]]( var_6, var_2, var_3 );

        return;
    }

    if ( isdefined( var_2 ) )
    {
        foreach ( var_6 in var_0 )
            call [[ var_1 ]]( var_6, var_2 );

        return;
    }

    foreach ( var_6 in var_0 )
        call [[ var_1 ]]( var_6 );
}

_ID3868( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    _ID3867( var_0, var_1, var_2, var_3, var_4, var_5 );
}

array_thread5( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    _ID3867( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
}

_ID33659( var_0, var_1 )
{
    if ( isdefined( var_0 ) && isdefined( var_1 ) )
    {
        var_2 = getentarray( var_0, var_1 );
        _ID3867( var_2, ::_ID33661 );
    }
    else
        _ID33661();
}

_ID33661()
{
    if ( isdefined( self.realorigin ) )
        self.origin = self.realorigin;

    self._ID33657 = undefined;
}

_ID33657( var_0, var_1 )
{
    if ( isdefined( var_0 ) && isdefined( var_1 ) )
    {
        var_2 = getentarray( var_0, var_1 );
        _ID3867( var_2, ::_ID33658 );
    }
    else
        _ID33658();
}

_ID33658()
{
    if ( !isdefined( self.realorigin ) )
        self.realorigin = self.origin;

    if ( self.origin == self.realorigin )
        self.origin = self.origin + ( 0, 0, -10000 );

    self._ID33657 = 1;
}

_ID28591( var_0 )
{
    if ( !isdefined( level._ID33610 ) )
        return;

    level._ID33610[var_0] = array_removeundefined( level._ID33610[var_0] );
    _ID3867( level._ID33610[var_0], ::_ID34489 );
}

_ID34489()
{
    var_0 = 1;

    if ( isdefined( self._ID27587 ) )
    {
        var_0 = 0;
        var_1 = _ID8313( self._ID27587 );

        foreach ( var_3 in var_1 )
        {
            if ( _ID13177( var_3 ) )
            {
                var_0 = 1;
                break;
            }
        }
    }

    var_5 = 1;

    if ( isdefined( self._ID27583 ) )
    {
        var_1 = _ID8313( self._ID27583 );

        foreach ( var_3 in var_1 )
        {
            if ( _ID13177( var_3 ) )
            {
                var_5 = 0;
                break;
            }
        }
    }

    [[ level._ID33614[var_0 && var_5] ]]();
}

_ID8313( var_0 )
{
    var_1 = strtok( var_0, " " );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( !isdefined( level._ID13177[var_1[var_2]] ) )
            _ID13189( var_1[var_2] );
    }

    return var_1;
}

_ID17858()
{
    level._ID33610 = [];
    level._ID33614[1] = ::_ID33659;
    level._ID33614[0] = ::_ID33657;
}

_ID15384( var_0, var_1 )
{
    var_2 = level._ID31994[var_1][var_0];

    if ( !isdefined( var_2 ) )
        return undefined;

    if ( var_2.size > 1 )
        return undefined;

    return var_2[0];
}

_ID15386( var_0, var_1 )
{
    var_2 = level._ID31994[var_1][var_0];

    if ( !isdefined( var_2 ) )
        return [];

    return var_2;
}

_ID31993()
{
    level._ID31994 = [];
    level._ID31994["target"] = [];
    level._ID31994["targetname"] = [];
    level._ID31994["script_noteworthy"] = [];
    level._ID31994["script_linkname"] = [];

    foreach ( var_1 in level.struct )
    {
        if ( isdefined( var_1.targetname ) )
        {
            if ( !isdefined( level._ID31994["targetname"][var_1.targetname] ) )
                level._ID31994["targetname"][var_1.targetname] = [];

            var_2 = level._ID31994["targetname"][var_1.targetname].size;
            level._ID31994["targetname"][var_1.targetname][var_2] = var_1;
        }

        if ( isdefined( var_1.target ) )
        {
            if ( !isdefined( level._ID31994["target"][var_1.target] ) )
                level._ID31994["target"][var_1.target] = [];

            var_2 = level._ID31994["target"][var_1.target].size;
            level._ID31994["target"][var_1.target][var_2] = var_1;
        }

        if ( isdefined( var_1.script_noteworthy ) )
        {
            if ( !isdefined( level._ID31994["script_noteworthy"][var_1.script_noteworthy] ) )
                level._ID31994["script_noteworthy"][var_1.script_noteworthy] = [];

            var_2 = level._ID31994["script_noteworthy"][var_1.script_noteworthy].size;
            level._ID31994["script_noteworthy"][var_1.script_noteworthy][var_2] = var_1;
        }

        if ( isdefined( var_1.script_linkname ) )
        {
            if ( !isdefined( level._ID31994["script_linkname"][var_1.script_linkname] ) )
                level._ID31994["script_linkname"][var_1.script_linkname] = [];

            var_2 = level._ID31994["script_linkname"][var_1.script_linkname].size;
            level._ID31994["script_linkname"][var_1.script_linkname][0] = var_1;
        }
    }
}

_ID12844( var_0 )
{

}

_ID12842()
{

}

_ID12840( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;
}

_ID12841( var_0, var_1 )
{

}

fileprint_map_entity_start()
{

}

fileprint_map_entity_end()
{

}

_ID12843( var_0 )
{

}

array_remove( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        if ( var_4 != var_1 )
            var_2[var_2.size] = var_4;
    }

    return var_2;
}

array_remove_array( var_0, var_1 )
{
    foreach ( var_3 in var_1 )
        var_0 = array_remove( var_0, var_3 );

    return var_0;
}

array_removeundefined( var_0 )
{
    var_1 = [];

    foreach ( var_4, var_3 in var_0 )
    {
        if ( !isdefined( var_3 ) )
            continue;

        var_1[var_1.size] = var_3;
    }

    return var_1;
}

array_remove_duplicates( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3 ) )
            continue;

        var_4 = 1;

        foreach ( var_6 in var_1 )
        {
            if ( var_3 == var_6 )
            {
                var_4 = 0;
                break;
            }
        }

        if ( var_4 )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

array_levelthread( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_4 ) )
    {
        foreach ( var_6 in var_0 )
            thread [[ var_1 ]]( var_6, var_2, var_3, var_4 );

        return;
    }

    if ( isdefined( var_3 ) )
    {
        foreach ( var_6 in var_0 )
            thread [[ var_1 ]]( var_6, var_2, var_3 );

        return;
    }

    if ( isdefined( var_2 ) )
    {
        foreach ( var_6 in var_0 )
            thread [[ var_1 ]]( var_6, var_2 );

        return;
    }

    foreach ( var_6 in var_0 )
        thread [[ var_1 ]]( var_6 );
}

array_levelcall( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_4 ) )
    {
        foreach ( var_6 in var_0 )
            call [[ var_1 ]]( var_6, var_2, var_3, var_4 );

        return;
    }

    if ( isdefined( var_3 ) )
    {
        foreach ( var_6 in var_0 )
            call [[ var_1 ]]( var_6, var_2, var_3 );

        return;
    }

    if ( isdefined( var_2 ) )
    {
        foreach ( var_6 in var_0 )
            call [[ var_1 ]]( var_6, var_2 );

        return;
    }

    foreach ( var_6 in var_0 )
        call [[ var_1 ]]( var_6 );
}

add_to_array( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        return var_0;

    if ( !isdefined( var_0 ) )
        var_0[0] = var_1;
    else
        var_0[var_0.size] = var_1;

    return var_0;
}

_ID13178( var_0 )
{

}

_ID13211( var_0, var_1 )
{
    for (;;)
    {
        if ( _ID13177( var_0 ) )
            return;

        if ( _ID13177( var_1 ) )
            return;

        level _ID35663( var_0, var_1 );
    }
}

flag_wait_either_return( var_0, var_1 )
{
    for (;;)
    {
        if ( _ID13177( var_0 ) )
            return var_0;

        if ( _ID13177( var_1 ) )
            return var_1;

        var_2 = level _ID35635( var_0, var_1 );
        return var_2;
    }
}

flag_wait_any( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = [];

    if ( isdefined( var_5 ) )
    {
        var_6[var_6.size] = var_0;
        var_6[var_6.size] = var_1;
        var_6[var_6.size] = var_2;
        var_6[var_6.size] = var_3;
        var_6[var_6.size] = var_4;
        var_6[var_6.size] = var_5;
    }
    else if ( isdefined( var_4 ) )
    {
        var_6[var_6.size] = var_0;
        var_6[var_6.size] = var_1;
        var_6[var_6.size] = var_2;
        var_6[var_6.size] = var_3;
        var_6[var_6.size] = var_4;
    }
    else if ( isdefined( var_3 ) )
    {
        var_6[var_6.size] = var_0;
        var_6[var_6.size] = var_1;
        var_6[var_6.size] = var_2;
        var_6[var_6.size] = var_3;
    }
    else if ( isdefined( var_2 ) )
    {
        var_6[var_6.size] = var_0;
        var_6[var_6.size] = var_1;
        var_6[var_6.size] = var_2;
    }
    else if ( isdefined( var_1 ) )
    {
        _ID13211( var_0, var_1 );
        return;
    }
    else
        return;

    for (;;)
    {
        for ( var_7 = 0; var_7 < var_6.size; var_7++ )
        {
            if ( _ID13177( var_6[var_7] ) )
                return;
        }

        level _ID35626( var_0, var_1, var_2, var_3, var_4, var_5 );
    }
}

_ID13208( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = [];

    if ( isdefined( var_4 ) )
    {
        var_5[var_5.size] = var_0;
        var_5[var_5.size] = var_1;
        var_5[var_5.size] = var_2;
        var_5[var_5.size] = var_3;
        var_5[var_5.size] = var_4;
    }
    else if ( isdefined( var_3 ) )
    {
        var_5[var_5.size] = var_0;
        var_5[var_5.size] = var_1;
        var_5[var_5.size] = var_2;
        var_5[var_5.size] = var_3;
    }
    else if ( isdefined( var_2 ) )
    {
        var_5[var_5.size] = var_0;
        var_5[var_5.size] = var_1;
        var_5[var_5.size] = var_2;
    }
    else if ( isdefined( var_1 ) )
    {
        var_6 = flag_wait_either_return( var_0, var_1 );
        return var_6;
    }
    else
        return;

    for (;;)
    {
        for ( var_7 = 0; var_7 < var_5.size; var_7++ )
        {
            if ( _ID13177( var_5[var_7] ) )
                return var_5[var_7];
        }

        var_6 = level _ID35635( var_0, var_1, var_2, var_3, var_4 );
        return var_6;
    }
}

flag_wait_all( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_0 ) )
        flag_wait( var_0 );

    if ( isdefined( var_1 ) )
        flag_wait( var_1 );

    if ( isdefined( var_2 ) )
        flag_wait( var_2 );

    if ( isdefined( var_3 ) )
        flag_wait( var_3 );
}

flag_wait_or_timeout( var_0, var_1 )
{
    var_2 = var_1 * 1000;
    var_3 = gettime();

    for (;;)
    {
        if ( _ID13177( var_0 ) )
            break;

        if ( gettime() >= var_3 + var_2 )
            break;

        var_4 = var_2 - ( gettime() - var_3 );
        var_5 = var_4 / 1000;
        _ID35457( var_0, var_5 );
    }
}

_ID13218( var_0, var_1 )
{
    var_2 = gettime();

    for (;;)
    {
        if ( !_ID13177( var_0 ) )
            break;

        if ( gettime() >= var_2 + var_1 * 1000 )
            break;

        _ID35457( var_0, var_1 );
    }
}

_ID35457( var_0, var_1 )
{
    level endon( var_0 );
    wait(var_1);
}

delaycall( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    thread delaycall_proc( var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

delaycall_proc( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( _ID18787() )
    {
        self endon( "death" );
        self endon( "stop_delay_call" );
    }

    wait(var_1);

    if ( isdefined( var_9 ) )
        self call [[ var_0 ]]( var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
    else if ( isdefined( var_8 ) )
        self call [[ var_0 ]]( var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
    else if ( isdefined( var_7 ) )
        self call [[ var_0 ]]( var_2, var_3, var_4, var_5, var_6, var_7 );
    else if ( isdefined( var_6 ) )
        self call [[ var_0 ]]( var_2, var_3, var_4, var_5, var_6 );
    else if ( isdefined( var_5 ) )
        self call [[ var_0 ]]( var_2, var_3, var_4, var_5 );
    else if ( isdefined( var_4 ) )
        self call [[ var_0 ]]( var_2, var_3, var_4 );
    else if ( isdefined( var_3 ) )
        self call [[ var_0 ]]( var_2, var_3 );
    else if ( isdefined( var_2 ) )
        self call [[ var_0 ]]( var_2 );
    else
        self call [[ var_0 ]]();
}

_ID22147( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    thread _ID22148( var_1, var_0, var_2, var_3, var_4, var_5 );
}

_ID22148( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    wait(var_1);

    if ( isdefined( var_5 ) )
        call [[ var_0 ]]( var_2, var_3, var_4, var_5 );
    else if ( isdefined( var_4 ) )
        call [[ var_0 ]]( var_2, var_3, var_4 );
    else if ( isdefined( var_3 ) )
        call [[ var_0 ]]( var_2, var_3 );
    else if ( isdefined( var_2 ) )
        call [[ var_0 ]]( var_2 );
    else
        call [[ var_0 ]]();
}

_ID18787()
{
    if ( !isdefined( level._ID18787 ) )
        level._ID18787 = !string_starts_with( getdvar( "mapname" ), "mp_" );

    return level._ID18787;
}

issp_towerdefense()
{
    if ( !isdefined( level.issp_towerdefense ) )
        level.issp_towerdefense = string_starts_with( getdvar( "mapname" ), "so_td_" );

    return level.issp_towerdefense;
}

string_starts_with( var_0, var_1 )
{
    if ( var_0.size < var_1.size )
        return 0;

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( tolower( var_0[var_2] ) != tolower( var_1[var_2] ) )
            return 0;
    }

    return 1;
}

plot_points( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = var_0[0];

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( !isdefined( var_3 ) )
        var_3 = 1;

    if ( !isdefined( var_4 ) )
        var_4 = 0.05;

    for ( var_6 = 1; var_6 < var_0.size; var_6++ )
    {
        thread _ID10844( var_5, var_0[var_6], var_1, var_2, var_3, var_4 );
        var_5 = var_0[var_6];
    }
}

_ID10844( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_5 = gettime() + var_5 * 1000;

    while ( gettime() < var_5 )
        wait 0.05;
}

_ID32328( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_5, var_4 in var_0 )
        var_2[var_5] = var_4;

    foreach ( var_5, var_4 in var_1 )
        var_2[var_5] = var_4;

    return var_2;
}

array_combine( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in var_0 )
        var_2[var_2.size] = var_4;

    foreach ( var_4 in var_1 )
        var_2[var_2.size] = var_4;

    return var_2;
}

array_combine_non_integer_indices( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_5, var_4 in var_0 )
        var_2[var_5] = var_4;

    foreach ( var_5, var_4 in var_1 )
        var_2[var_5] = var_4;

    return var_2;
}

array_randomize( var_0 )
{
    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_2 = randomint( var_0.size );
        var_3 = var_0[var_1];
        var_0[var_1] = var_0[var_2];
        var_0[var_2] = var_3;
    }

    return var_0;
}

array_add( var_0, var_1 )
{
    var_0[var_0.size] = var_1;
    return var_0;
}

array_insert( var_0, var_1, var_2 )
{
    if ( var_2 == var_0.size )
    {
        var_3 = var_0;
        var_3[var_3.size] = var_1;
        return var_3;
    }

    var_3 = [];
    var_4 = 0;

    for ( var_5 = 0; var_5 < var_0.size; var_5++ )
    {
        if ( var_5 == var_2 )
        {
            var_3[var_5] = var_1;
            var_4 = 1;
        }

        var_3[var_5 + var_4] = var_0[var_5];
    }

    return var_3;
}

array_contains( var_0, var_1 )
{
    if ( var_0.size <= 0 )
        return 0;

    foreach ( var_3 in var_0 )
    {
        if ( var_3 == var_1 )
            return 1;
    }

    return 0;
}

array_find( var_0, var_1 )
{
    foreach ( var_4, var_3 in var_0 )
    {
        if ( var_3 == var_1 )
            return var_4;
    }

    return undefined;
}

_ID13333( var_0 )
{
    var_1 = ( 0, var_0[1], 0 );
    return var_1;
}

_ID13335( var_0 )
{
    var_1 = ( var_0[0], var_0[1], 0 );
    return var_1;
}

draw_arrow_time( var_0, var_1, var_2, var_3 )
{
    level endon( "newpath" );
    var_4 = [];
    var_5 = vectortoangles( var_0 - var_1 );
    var_6 = anglestoright( var_5 );
    var_7 = anglestoforward( var_5 );
    var_8 = anglestoup( var_5 );
    var_9 = distance( var_0, var_1 );
    var_10 = [];
    var_11 = 0.1;
    var_10[0] = var_0;
    var_10[1] = var_0 + var_6 * ( var_9 * var_11 ) + var_7 * ( var_9 * -0.1 );
    var_10[2] = var_1;
    var_10[3] = var_0 + var_6 * ( var_9 * ( -1 * var_11 ) ) + var_7 * ( var_9 * -0.1 );
    var_10[4] = var_0;
    var_10[5] = var_0 + var_8 * ( var_9 * var_11 ) + var_7 * ( var_9 * -0.1 );
    var_10[6] = var_1;
    var_10[7] = var_0 + var_8 * ( var_9 * ( -1 * var_11 ) ) + var_7 * ( var_9 * -0.1 );
    var_10[8] = var_0;
    var_12 = var_2[0];
    var_13 = var_2[1];
    var_14 = var_2[2];
    plot_points( var_10, var_12, var_13, var_14, var_3 );
}

get_linked_ents()
{
    var_0 = [];

    if ( isdefined( self.script_linkto ) )
    {
        var_1 = get_links();

        foreach ( var_3 in var_1 )
        {
            var_4 = getentarray( var_3, "script_linkname" );

            if ( var_4.size > 0 )
                var_0 = array_combine( var_0, var_4 );
        }
    }

    return var_0;
}

get_linked_vehicle_nodes()
{
    var_0 = [];

    if ( isdefined( self.script_linkto ) )
    {
        var_1 = get_links();

        foreach ( var_3 in var_1 )
        {
            var_4 = getvehiclenodearray( var_3, "script_linkname" );

            if ( var_4.size > 0 )
                var_0 = array_combine( var_0, var_4 );
        }
    }

    return var_0;
}

_ID14551()
{
    var_0 = get_linked_ents();
    return var_0[0];
}

get_linked_vehicle_node()
{
    var_0 = get_linked_vehicle_nodes();
    return var_0[0];
}

get_links()
{
    return strtok( self.script_linkto, " " );
}

_ID27002( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = getentarray( var_0, "targetname" );
    _ID3867( var_5, var_1, var_2, var_3, var_4 );
    var_5 = _ID15386( var_0, "targetname" );
    _ID3867( var_5, var_1, var_2, var_3, var_4 );
    var_5 = call [[ level._ID15177 ]]( var_0, "targetname" );
    _ID3867( var_5, var_1, var_2, var_3, var_4 );
    var_5 = getvehiclenodearray( var_0, "targetname" );
    _ID3867( var_5, var_1, var_2, var_3, var_4 );
}

_ID27001( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = getentarray( var_0, "script_noteworthy" );
    _ID3867( var_5, var_1, var_2, var_3, var_4 );
    var_5 = _ID15386( var_0, "script_noteworthy" );
    _ID3867( var_5, var_1, var_2, var_3, var_4 );
    var_5 = call [[ level._ID15177 ]]( var_0, "script_noteworthy" );
    _ID3867( var_5, var_1, var_2, var_3, var_4 );
    var_5 = getvehiclenodearray( var_0, "script_noteworthy" );
    _ID3867( var_5, var_1, var_2, var_3, var_4 );
}

draw_arrow( var_0, var_1, var_2 )
{
    level endon( "newpath" );
    var_3 = [];
    var_4 = vectortoangles( var_0 - var_1 );
    var_5 = anglestoright( var_4 );
    var_6 = anglestoforward( var_4 );
    var_7 = distance( var_0, var_1 );
    var_8 = [];
    var_9 = 0.05;
    var_8[0] = var_0;
    var_8[1] = var_0 + var_5 * ( var_7 * var_9 ) + var_6 * ( var_7 * -0.2 );
    var_8[2] = var_1;
    var_8[3] = var_0 + var_5 * ( var_7 * ( -1 * var_9 ) ) + var_6 * ( var_7 * -0.2 );

    for ( var_10 = 0; var_10 < 4; var_10++ )
    {
        var_11 = var_10 + 1;

        if ( var_11 >= 4 )
            var_11 = 0;
    }
}

draw_entity_bounds( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_2 ) )
        var_2 = ( 0, 1, 0 );

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_4 ) )
        var_4 = 0.05;

    if ( var_3 )
        var_5 = int( var_4 / 0.05 );
    else
        var_5 = int( var_1 / 0.05 );

    var_6 = [];
    var_7 = [];
    var_8 = gettime();

    for ( var_9 = var_8 + var_1 * 1000; var_8 < var_9 && isdefined( var_0 ); var_8 = gettime() )
    {
        var_6[0] = var_0 getpointinbounds( 1, 1, 1 );
        var_6[1] = var_0 getpointinbounds( 1, 1, -1 );
        var_6[2] = var_0 getpointinbounds( -1, 1, -1 );
        var_6[3] = var_0 getpointinbounds( -1, 1, 1 );
        var_7[0] = var_0 getpointinbounds( 1, -1, 1 );
        var_7[1] = var_0 getpointinbounds( 1, -1, -1 );
        var_7[2] = var_0 getpointinbounds( -1, -1, -1 );
        var_7[3] = var_0 getpointinbounds( -1, -1, 1 );

        for ( var_10 = 0; var_10 < 4; var_10++ )
        {
            var_11 = var_10 + 1;

            if ( var_11 == 4 )
                var_11 = 0;
        }

        if ( !var_3 )
            return;

        wait(var_4);
    }
}

draw_volume( var_0, var_1, var_2, var_3, var_4 )
{
    draw_entity_bounds( var_0, var_1, var_2, var_3, var_4 );
}

draw_trigger( var_0, var_1, var_2, var_3, var_4 )
{
    draw_entity_bounds( var_0, var_1, var_2, var_3, var_4 );
}

_ID15033( var_0 )
{
    return level._ID1644[var_0];
}

_ID14019( var_0 )
{
    return isdefined( level._ID1644[var_0] );
}

_ID24986( var_0, var_1 )
{
    var_2 = var_1 + "," + var_0;

    if ( isdefined( level.csv_lines[var_2] ) )
        return;

    level.csv_lines[var_2] = 1;
}

_ID12834( var_0 )
{

}

_ID15114()
{
    return self._ID27300;
}

_ID24555()
{

}

_ID18834()
{
    return !self._ID10153;
}

_disableusability()
{
    if ( !isdefined( self._ID10153 ) )
        self._ID10153 = 0;

    self._ID10153++;
    self disableusability();
}

_enableusability()
{
    if ( !isdefined( self._ID10153 ) )
        self._ID10153 = 0;
    else if ( self._ID10153 > 0 )
    {
        self._ID10153--;

        if ( self._ID10153 == 0 )
            self enableusability();
    }
}

_ID26147()
{
    self._ID10153 = 0;
    self enableusability();
}

_disableweapon()
{
    if ( !isdefined( self.disabledweapon ) )
        self.disabledweapon = 0;

    self.disabledweapon++;
    self disableweapons();
}

_enableweapon()
{
    if ( !isdefined( self.disabledweapon ) )
        self.disabledweapon = 0;

    self.disabledweapon--;

    if ( !self.disabledweapon )
        self enableweapons();
}

_ID18870()
{
    return !self.disabledweapon;
}

_disableweaponswitch()
{
    if ( !isdefined( self._ID10155 ) )
        self._ID10155 = 0;

    self._ID10155++;
    self disableweaponswitch();
}

_enableweaponswitch()
{
    if ( !isdefined( self._ID10155 ) )
        self._ID10155 = 0;

    self._ID10155--;

    if ( !self._ID10155 )
        self enableweaponswitch();
}

isweaponswitchenabled()
{
    return !self._ID10155;
}

_disableoffhandweapons()
{
    if ( !isdefined( self.disabledoffhandweapons ) )
        self.disabledoffhandweapons = 0;

    self.disabledoffhandweapons++;
    self disableoffhandweapons();
}

_ID1647()
{
    if ( !isdefined( self.disabledoffhandweapons ) )
        self.disabledoffhandweapons = 0;

    self.disabledoffhandweapons--;

    if ( !self.disabledoffhandweapons )
        self enableoffhandweapons();
}

isoffhandweaponenabled()
{
    return !self.disabledoffhandweapons;
}

_ID25350( var_0 )
{
    var_1 = [];

    foreach ( var_4, var_3 in var_0 )
        var_1[var_1.size] = var_3;

    if ( !var_1.size )
        return undefined;

    return var_1[randomint( var_1.size )];
}

random_weight_sorted( var_0 )
{
    var_1 = [];

    foreach ( var_4, var_3 in var_0 )
        var_1[var_1.size] = var_3;

    if ( !var_1.size )
        return undefined;

    var_5 = randomint( var_1.size * var_1.size );
    return var_1[var_1.size - 1 - int( sqrt( var_5 ) )];
}

_ID30774()
{
    var_0 = spawn( "script_model", ( 0, 0, 0 ) );
    var_0 setmodel( "tag_origin" );
    var_0 hide();

    if ( isdefined( self.origin ) )
        var_0.origin = self.origin;

    if ( isdefined( self.angles ) )
        var_0.angles = self.angles;

    return var_0;
}

waittill_notify_or_timeout( var_0, var_1 )
{
    self endon( var_0 );
    wait(var_1);
}

_ID35710( var_0, var_1 )
{
    self endon( var_0 );
    wait(var_1);
    return "timeout";
}

fileprint_launcher_start_file()
{
    level.fileprintlauncher_linecount = 0;
    level._ID12835 = 1;
    _ID12835( "GAMEPRINTSTARTFILE:" );
}

_ID12835( var_0 )
{
    level.fileprintlauncher_linecount++;

    if ( level.fileprintlauncher_linecount > 200 )
    {
        wait 0.05;
        level.fileprintlauncher_linecount = 0;
    }
}

_ID12836( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( var_1 )
        _ID12835( "GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + var_0 );
    else
        _ID12835( "GAMEPRINTENDFILE:" + var_0 );

    var_2 = gettime() + 4000;

    while ( getdvarint( "LAUNCHER_PRINT_SUCCESS" ) == 0 && getdvar( "LAUNCHER_PRINT_FAIL" ) == "0" && gettime() < var_2 )
        wait 0.05;

    if ( !( gettime() < var_2 ) )
    {
        iprintlnbold( "LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? " );
        level._ID12835 = undefined;
        return 0;
    }

    var_3 = getdvar( "LAUNCHER_PRINT_FAIL" );

    if ( var_3 != "0" )
    {
        iprintlnbold( "LAUNCHER_PRINT_FAIL:( " + var_3 + " ): launcherconflict? restart launcher and try again? " );
        level._ID12835 = undefined;
        return 0;
    }

    level._ID12835 = undefined;
    return 1;
}

_ID19708( var_0 )
{
    level.fileprintlauncher_linecount = 0;
    _ID12835( "LAUNCHER_CLIP:" + var_0 );
}

_ID18604()
{
    if ( !isdefined( self ) )
        return 0;

    return isdefined( self.destructible_type );
}

_ID23385()
{
    common_scripts\_createfx::_ID31786();
}

activate_individual_exploder()
{
    common_scripts\_exploder::activate_individual_exploder_proc();
}

_ID35582()
{
    wait 0.05;
}

_ID14781( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = self.target;

    var_1 = getent( var_0, "targetname" );

    if ( isdefined( var_1 ) )
        return var_1;

    if ( _ID18787() )
    {
        var_1 = call [[ level.getnodefunction ]]( var_0, "targetname" );

        if ( isdefined( var_1 ) )
            return var_1;
    }

    var_1 = _ID15384( var_0, "targetname" );

    if ( isdefined( var_1 ) )
        return var_1;

    var_1 = getvehiclenode( var_0, "targetname" );

    if ( isdefined( var_1 ) )
        return var_1;
}

get_noteworthy_ent( var_0 )
{
    var_1 = getent( var_0, "script_noteworthy" );

    if ( isdefined( var_1 ) )
        return var_1;

    if ( _ID18787() )
    {
        var_1 = call [[ level.getnodefunction ]]( var_0, "script_noteworthy" );

        if ( isdefined( var_1 ) )
            return var_1;
    }

    var_1 = _ID15384( var_0, "script_noteworthy" );

    if ( isdefined( var_1 ) )
        return var_1;

    var_1 = getvehiclenode( var_0, "script_noteworthy" );

    if ( isdefined( var_1 ) )
        return var_1;
}

do_earthquake( var_0, var_1 )
{
    var_2 = level.earthquake[var_0];
    earthquake( var_2["magnitude"], var_2["duration"], var_1, var_2["radius"] );
}

_ID23798( var_0, var_1 )
{
    var_2 = spawn( "script_origin", ( 0, 0, 0 ) );

    if ( !isdefined( var_1 ) )
        var_1 = self.origin;

    var_2.origin = var_1;
    var_2 playloopsound( var_0 );
    return var_2;
}

_ID23840( var_0, var_1, var_2, var_3 )
{
    var_4 = spawn( "script_origin", ( 0, 0, 1 ) );

    if ( !isdefined( var_1 ) )
        var_1 = self.origin;

    var_4.origin = var_1;
    var_4.angles = var_2;

    if ( _ID18787() )
    {
        if ( isdefined( var_3 ) && var_3 )
            var_4 playsoundasmaster( var_0, "sounddone" );
        else
            var_4 playsound( var_0, "sounddone" );

        var_4 waittill( "sounddone" );
    }
    else if ( isdefined( var_3 ) && var_3 )
        var_4 playsoundasmaster( var_0 );
    else
        var_4 playsound( var_0 );

    var_4 delete();
}

_ID23839( var_0, var_1, var_2 )
{
    _ID23840( var_0, var_1, ( 0, 0, 0 ), var_2 );
}

_ID20328( var_0, var_1, var_2, var_3, var_4 )
{
    _ID20331( var_0, var_1, ( 0, 0, 0 ), var_2, var_3, var_4 );
}

_ID20331( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( var_3 ) && var_3 )
    {
        if ( !isdefined( level.first_frame ) || level.first_frame == 1 )
            spawnloopingsound( var_0, var_1, var_2 );
    }
    else
    {
        if ( level._ID8425 && isdefined( var_5._ID20357 ) )
            var_7 = var_5._ID20357;
        else
            var_7 = spawn( "script_origin", ( 0, 0, 0 ) );

        if ( isdefined( var_4 ) )
        {
            thread _ID20335( var_4, var_7 );
            self endon( var_4 );
        }

        var_7.origin = var_1;
        var_7.angles = var_2;
        var_7 playloopsound( var_0 );

        if ( level._ID8425 )
            var_5._ID20357 = var_7;
        else
            var_7 willneverchange();
    }
}

_ID20329( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    _ID20330( var_0, var_1, ( 0, 0, 0 ), var_2, var_3, var_4, var_5 );
}

_ID20330( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = spawn( "script_origin", ( 0, 0, 0 ) );

    if ( isdefined( var_3 ) )
    {
        thread _ID20335( var_3, var_7 );
        self endon( var_3 );
    }

    var_7.origin = var_1;
    var_7.angles = var_2;

    if ( var_5 >= var_6 )
    {
        for (;;)
            wait 0.05;
    }

    if ( !soundexists( var_0 ) )
    {
        for (;;)
            wait 0.05;
    }

    for (;;)
    {
        wait(randomfloatrange( var_5, var_6 ));
        _ID20167( "createfx_looper" );
        thread _ID23840( var_0, var_7.origin, var_7.angles, undefined );
        _ID34238( "createfx_looper" );
    }
}

_ID20335( var_0, var_1 )
{
    var_1 endon( "death" );
    self waittill( var_0 );
    var_1 delete();
}

createloopeffect( var_0 )
{
    var_1 = common_scripts\_createfx::createeffect( "loopfx", var_0 );
    var_1._ID34830["delay"] = common_scripts\_createfx::_ID15131();
    return var_1;
}

createoneshoteffect( var_0 )
{
    var_1 = common_scripts\_createfx::createeffect( "oneshotfx", var_0 );
    var_1._ID34830["delay"] = common_scripts\_createfx::_ID15204();
    return var_1;
}

createexploder( var_0 )
{
    var_1 = common_scripts\_createfx::createeffect( "exploder", var_0 );
    var_1._ID34830["delay"] = common_scripts\_createfx::_ID15012();
    var_1._ID34830["exploder_type"] = "normal";
    return var_1;
}

alphabetize( var_0 )
{
    if ( var_0.size <= 1 )
        return var_0;

    var_1 = 0;

    for ( var_2 = var_0.size - 1; var_2 >= 1; var_2-- )
    {
        var_3 = var_0[var_2];
        var_4 = var_2;

        for ( var_5 = 0; var_5 < var_2; var_5++ )
        {
            var_6 = var_0[var_5];

            if ( stricmp( var_6, var_3 ) > 0 )
            {
                var_3 = var_6;
                var_4 = var_5;
            }
        }

        if ( var_4 != var_2 )
        {
            var_0[var_4] = var_0[var_2];
            var_0[var_2] = var_3;
        }
    }

    return var_0;
}

is_later_in_alphabet( var_0, var_1 )
{
    return stricmp( var_0, var_1 ) > 0;
}

_ID23796( var_0, var_1 )
{
    var_2 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_2 endon( "death" );
    thread delete_on_death( var_2 );

    if ( isdefined( var_1 ) )
    {
        var_2.origin = self.origin + var_1;
        var_2.angles = self.angles;
        var_2 linkto( self );
    }
    else
    {
        var_2.origin = self.origin;
        var_2.angles = self.angles;
        var_2 linkto( self );
    }

    var_2 playloopsound( var_0 );
    self waittill( "stop sound" + var_0 );
    var_2 stoploopsound( var_0 );
    var_2 delete();
}

_ID31795( var_0 )
{
    self notify( "stop sound" + var_0 );
}

delete_on_death( var_0 )
{
    var_0 endon( "death" );
    self waittill( "death" );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

error( var_0 )
{
    _ID35582();
}

exploder( var_0, var_1, var_2 )
{
    [[ level._fx.exploderfunction ]]( var_0, var_1, var_2 );
}

create_dvar( var_0, var_1 )
{
    setdvarifuninitialized( var_0, var_1 );
}

_ID35394()
{

}

_ID32352( var_0, var_1 )
{
    var_2 = self gettagorigin( var_0 );
    var_3 = self gettagangles( var_0 );
    var_4 = anglestoforward( var_3 );
    var_4 = vectornormalize( var_4 ) * var_1;
    return var_2 + var_4;
}

_ID32831( var_0, var_1, var_2 )
{
    if ( var_0 )
        return var_1;

    return var_2;
}

create_lock( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( !isdefined( level._ID20167 ) )
        level._ID20167 = [];

    var_2 = spawnstruct();
    var_2.max_count = var_1;
    var_2.count = 0;
    level._ID20167[var_0] = var_2;
}

_ID20173( var_0 )
{
    if ( !isdefined( level._ID20167 ) )
        return 0;

    return isdefined( level._ID20167[var_0] );
}

_ID20167( var_0 )
{
    var_1 = level._ID20167[var_0];

    while ( var_1.count >= var_1.max_count )
        var_1 waittill( "unlocked" );

    var_1.count++;
}

is_locked( var_0 )
{
    var_1 = level._ID20167[var_0];
    return var_1.count > var_1.max_count;
}

_ID34244( var_0 )
{
    thread _ID34243( var_0 );
    wait 0.05;
}

_ID34238( var_0 )
{
    thread _ID34243( var_0 );
}

_ID34243( var_0 )
{
    wait 0.05;
    var_1 = level._ID20167[var_0];
    var_1.count--;
    var_1 notify( "unlocked" );
}

_ID14794()
{
    var_0 = level.script;

    if ( isdefined( level._ID32826 ) )
        var_0 = level._ID32826;

    return var_0;
}

_ID18472()
{
    if ( !level.console )
    {
        var_0 = self usinggamepad();

        if ( isdefined( var_0 ) )
            return var_0;
        else
            return 0;
    }

    return 1;
}

array_reverse( var_0 )
{
    var_1 = [];

    for ( var_2 = var_0.size - 1; var_2 >= 0; var_2-- )
        var_1[var_1.size] = var_0[var_2];

    return var_1;
}

_ID10238( var_0, var_1 )
{
    return length2dsquared( var_0 - var_1 );
}

get_array_of_farthest( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = _ID14293( var_0, var_1, var_2, var_3, var_4, var_5 );
    var_6 = array_reverse( var_6 );
    return var_6;
}

_ID14293( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_3 ) )
        var_3 = var_1.size;

    if ( !isdefined( var_2 ) )
        var_2 = [];

    var_6 = undefined;

    if ( isdefined( var_4 ) )
        var_6 = var_4 * var_4;

    var_7 = 0;

    if ( isdefined( var_5 ) )
        var_7 = var_5 * var_5;

    if ( var_2.size == 0 && var_3 >= var_1.size && var_7 == 0 && !isdefined( var_6 ) )
        return sortbydistance( var_1, var_0 );

    var_8 = [];

    foreach ( var_10 in var_1 )
    {
        var_11 = 0;

        foreach ( var_13 in var_2 )
        {
            if ( var_10 == var_13 )
            {
                var_11 = 1;
                break;
            }
        }

        if ( var_11 )
            continue;

        var_15 = distancesquared( var_0, var_10.origin );

        if ( isdefined( var_6 ) && var_15 > var_6 )
            continue;

        if ( var_15 < var_7 )
            continue;

        var_8[var_8.size] = var_10;
    }

    var_8 = sortbydistance( var_8, var_0 );

    if ( var_3 >= var_8.size )
        return var_8;

    var_17 = [];

    for ( var_18 = 0; var_18 < var_3; var_18++ )
        var_17[var_18] = var_8[var_18];

    return var_17;
}

drop_to_ground( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1500;

    if ( !isdefined( var_2 ) )
        var_2 = -12000;

    return physicstrace( var_0 + ( 0, 0, var_1 ), var_0 + ( 0, 0, var_2 ) );
}

add_destructible_type_function( var_0, var_1 )
{
    if ( !isdefined( level._ID9850 ) )
        level._ID9850 = [];

    level._ID9850[var_0] = var_1;
}

_ID2187( var_0, var_1 )
{
    if ( !isdefined( level.destructible_transient ) )
        level.destructible_transient = [];

    level.destructible_transient[var_0] = var_1;
}

_ID36376( var_0, var_1, var_2, var_3 )
{
    var_4 = vectornormalize( var_2 - var_0 );
    var_5 = anglestoforward( var_1 );
    var_6 = vectordot( var_5, var_4 );
    return var_6 >= var_3;
}

entity_path_disconnect_thread( var_0 )
{
    self notify( "entity_path_disconnect_thread" );
    self endon( "entity_path_disconnect_thread" );
    self endon( "death" );
    level endon( "game_ended" );
    var_1 = 0;
    self._ID13519 = 0;

    for (;;)
    {
        var_2 = self.origin;
        var_3 = _ID35637( var_0, "path_disconnect" );
        var_4 = 0;
        var_5 = distancesquared( self.origin, var_2 ) > 0;

        if ( var_5 )
            var_4 = 1;

        if ( isdefined( var_3 ) && var_3 == "path_disconnect" )
            var_4 = 1;

        if ( gettime() < self._ID13519 )
            var_4 = 1;

        foreach ( var_7 in level.characters )
        {
            if ( isai( var_7 ) && distancesquared( self.origin, var_7.origin ) < 250000 )
            {
                var_4 = 1;
                self._ID13519 = max( gettime() + 30000, self._ID13519 );
            }
        }

        if ( var_4 != var_1 || var_5 )
        {
            if ( var_4 )
                self disconnectpaths();
            else
                self connectpaths();

            var_1 = var_4;
        }
    }
}

_ID20489( var_0, var_1 )
{
    if ( level._ID14086 == "aliens" && isdefined( level.aliens_make_entity_sentient_func ) )
        return self [[ level.aliens_make_entity_sentient_func ]]( var_0, var_1 );

    if ( isdefined( level.bot_funcs ) && isdefined( level.bot_funcs["bots_make_entity_sentient"] ) )
        return self [[ level.bot_funcs["bots_make_entity_sentient"] ]]( var_0, var_1 );
}

ai_3d_sighting_model( var_0 )
{
    if ( isdefined( level.bot_funcs ) && isdefined( level.bot_funcs["ai_3d_sighting_model"] ) )
        return self [[ level.bot_funcs["ai_3d_sighting_model"] ]]( var_0 );
}

_ID28243( var_0, var_1, var_2 )
{
    if ( !isdefined( level.anim_prop_models ) )
        level.anim_prop_models = [];

    var_3 = tolower( getdvar( "mapname" ) );
    var_4 = 1;

    if ( string_starts_with( var_3, "mp_" ) )
        var_4 = 0;

    if ( var_4 )
        level.anim_prop_models[var_0]["basic"] = var_1;
    else
        level.anim_prop_models[var_0]["basic"] = var_2;
}

_ID14934( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 500000;

    var_3 = undefined;

    foreach ( var_5 in var_1 )
    {
        var_6 = distance( var_5.origin, var_0 );

        if ( var_6 >= var_2 )
            continue;

        var_2 = var_6;
        var_3 = var_5;
    }

    return var_3;
}

_ID15016( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 500000;

    var_3 = 0;
    var_4 = undefined;

    foreach ( var_6 in var_1 )
    {
        var_7 = distance( var_6.origin, var_0 );

        if ( var_7 <= var_3 || var_7 >= var_2 )
            continue;

        var_3 = var_7;
        var_4 = var_6;
    }

    return var_4;
}

_ID21170( var_0, var_1, var_2 )
{
    var_2 = _ID32831( isdefined( var_2 ), var_2, ( 0, 0, 0 ) );
    self missile_settargetent( var_0, var_2 );

    switch ( var_1 )
    {
        case "direct":
            self missile_setflightmodedirect();
            break;
        case "top":
            self missile_setflightmodetop();
            break;
    }
}

add_fx( var_0, var_1 )
{
    if ( !isdefined( level._ID1644 ) )
        level._ID1644 = [];

    level._ID1644[var_0] = loadfx( var_1 );
}

array_sort_by_handler( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_0.size - 1; var_2++ )
    {
        for ( var_3 = var_2 + 1; var_3 < var_0.size; var_3++ )
        {
            if ( var_0[var_3] [[ var_1 ]]() < var_0[var_2] [[ var_1 ]]() )
            {
                var_4 = var_0[var_3];
                var_0[var_3] = var_0[var_2];
                var_0[var_2] = var_4;
            }
        }
    }

    return var_0;
}

_ID3855( var_0, var_1 )
{
    for ( var_2 = 1; var_2 < var_0.size; var_2++ )
    {
        var_3 = var_0[var_2];

        for ( var_4 = var_2 - 1; var_4 >= 0 && ![[ var_1 ]]( var_0[var_4], var_3 ); var_4-- )
            var_0[var_4 + 1] = var_0[var_4];

        var_0[var_4 + 1] = var_3;
    }

    return var_0;
}
