// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    var_0 = [];
    var_1 = getentarray( "zipline", "targetname" );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_3 = maps\mp\gametypes\_gameobjects::_ID8493( "neutral", var_1[var_2], var_0, ( 0, 0, 0 ) );
        var_3 maps\mp\gametypes\_gameobjects::allowuse( "any" );
        var_3 maps\mp\gametypes\_gameobjects::_ID29198( 0.25 );
        var_3 maps\mp\gametypes\_gameobjects::_ID29197( &"MP_ZIPLINE_USE" );
        var_3 maps\mp\gametypes\_gameobjects::_ID29196( &"MP_ZIPLINE_USE" );
        var_3 maps\mp\gametypes\_gameobjects::_ID29202( "any" );
        var_3._ID22779 = ::_ID22779;
        var_3._ID22916 = ::_ID22916;
        var_4 = [];
        var_5 = getent( var_1[var_2].target, "targetname" );

        if ( !isdefined( var_5 ) )
        {

        }

        while ( isdefined( var_5 ) )
        {
            var_4[var_4.size] = var_5;

            if ( isdefined( var_5.target ) )
            {
                var_5 = getent( var_5.target, "targetname" );
                continue;
            }

            break;
        }

        var_3._ID32620 = var_4;
    }

    precachemodel( "tag_player" );
}

_ID22779( var_0 )
{
    var_0 playsound( "scrambler_pullout_lift_plr" );
}

_ID22916( var_0 )
{
    var_0 thread _ID36519( self );
}

_ID36519( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "zipline_drop" );
    level endon( "game_ended" );
    var_1 = spawn( "script_origin", var_0.trigger.origin );
    var_1.origin = var_0.trigger.origin;
    var_1.angles = self.angles;
    var_1 setmodel( "tag_player" );
    self playerlinktodelta( var_1, "tag_player", 1, 180, 180, 180, 180 );
    thread _ID36054( var_1 );
    thread _ID36060( var_1 );
    var_2 = var_0._ID32620;

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = distance( var_1.origin, var_2[var_3].origin ) / 600;
        var_5 = 0.0;

        if ( var_3 == 0 )
            var_5 = var_4 * 0.2;

        var_1 moveto( var_2[var_3].origin, var_4, var_5 );

        if ( var_1.angles != var_2[var_3].angles )
            var_1 rotateto( var_2[var_3].angles, var_4 * 0.8 );

        wait(var_4);
    }

    self notify( "destination" );
    self unlink();
    var_1 delete();
}

_ID36060( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "destination" );
    level endon( "game_ended" );
    self notifyonplayercommand( "zipline_drop", "+gostand" );
    self waittill( "zipline_drop" );
    self unlink();
    var_0 delete();
}

_ID36054( var_0 )
{
    self endon( "disconnect" );
    self endon( "destination" );
    self endon( "zipline_drop" );
    level endon( "game_ended" );
    self waittill( "death" );
    self unlink();
    var_0 delete();
}
