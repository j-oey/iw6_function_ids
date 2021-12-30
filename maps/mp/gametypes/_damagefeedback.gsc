// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{

}

_ID34528( var_0 )
{
    var_1 = 0;

    if ( isdefined( level.damagefeedbacknosound ) && level.damagefeedbacknosound )
        var_1 = 1;

    if ( !isplayer( self ) )
        return;

    switch ( var_0 )
    {
        case "hitmotionsensor":
        case "thermodebuff_kill":
        case "thermobaric_debuff":
        case "hitkillblast":
        case "hitblastshield":
        case "hitlightarmor":
        case "hitkilljugg":
        case "hitjuggernaut":
        case "hitmorehealth":
        case "hitdeadeyekill":
        case "hitcritical":
        case "hitkill":
        case "hitalienarmor":
        case "hitaliensoft":
            if ( !var_1 )
                self playlocalsound( "MP_hit_alert" );

            self setclientomnvar( "damage_feedback", var_0 );
            break;
        case "none":
            break;
        case "meleestun":
            if ( !isdefined( self.meleestun ) )
            {
                if ( !var_1 )
                    self playlocalsound( "crate_impact" );

                self.meleestun = 1;
            }

            self setclientomnvar( "damage_feedback", "hitcritical" );
            wait 0.2;
            self.meleestun = undefined;
            break;
        default:
            if ( !var_1 )
                self playlocalsound( "MP_hit_alert" );

            self setclientomnvar( "damage_feedback", "standard" );
            break;
    }
}

hudicontype( var_0 )
{
    var_1 = 0;

    if ( isdefined( level.damagefeedbacknosound ) && level.damagefeedbacknosound )
        var_1 = 1;

    if ( !isplayer( self ) )
        return;

    switch ( var_0 )
    {
        case "throwingknife":
        case "scavenger":
            if ( !var_1 )
                self playlocalsound( "scavenger_pack_pickup" );

            if ( !level.hardcoremode )
                self setclientomnvar( "damage_feedback_other", var_0 );

            break;
        case "boxofguns":
            if ( !var_1 )
                self playlocalsound( "mp_box_guns_ammo" );

            if ( !level.hardcoremode )
                self setclientomnvar( "damage_feedback_other", var_0 );

            break;
        case "oracle":
            if ( !var_1 )
                self playlocalsound( "oracle_radar_pulse_plr" );

            if ( !level.hardcoremode )
                self setclientomnvar( "damage_feedback_other", var_0 );

            break;
    }
}
