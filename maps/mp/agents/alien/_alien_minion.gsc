// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID21126()
{
    thread _ID21124();
}

_ID21124()
{
    self endon( "death" );

    for (;;)
    {
        var_0 = randomfloatrange( 8.0, 15.0 );
        wait(var_0);
        self playsoundonmovingent( "alien_minion_idle" );
    }
}

minion_approach( var_0, var_1 )
{
    self.attacking_player = 1;
    self.bypass_max_attacker_counter = 0;
    var_2 = 0.0;
    var_3 = randomfloat( 1.0 ) < var_2;

    if ( var_3 )
        return maps\mp\agents\alien\_alien_think::_ID15696( var_0 );

    self playsoundonmovingent( "alien_minion_alert" );
    var_4 = maps\mp\agents\alien\_alien_think::approach_enemy( 80, var_0, 3 );
    return "explode";
}

_ID12456( var_0 )
{
    self._ID20883 = "explode";
    maps\mp\agents\alien\_alien_think::alien_melee( var_0 );
}

explode( var_0 )
{
    maps\mp\alien\_unk1464::_ID28196( 0.2, 1.0 );
    self playsoundonmovingent( "alien_minion_attack" );
    playfxontag( level._ID1644["alien_minion_preexplode"], self, "tag_origin" );
    self scragentsetanimmode( "anim deltas" );
    var_1 = 1.25;
    self setanimstate( "minion_explode", 0, var_1 );
    wait(getanimlength( self getanimentry( "minion_explode", 0 ) ) * 1 / var_1);
    self suicide();
}

_ID20105()
{
    level._ID1644["alien_minion_explode"] = loadfx( "vfx/gameplay/alien/vfx_alien_minion_explode" );
    level._ID1644["alien_minion_preexplode"] = loadfx( "vfx/gameplay/alien/vfx_alien_minion_preexplosion" );
}

_ID21125( var_0 )
{
    common_scripts\utility::_ID35582();
    playfx( level._ID1644["alien_minion_explode"], var_0 + ( 0, 0, 32 ) );
    playsoundatpos( var_0, "alien_minion_explode" );
    radiusdamage( var_0, 200, level._ID2829["minion"].attributes["explode_max_damage"], level._ID2829["minion"].attributes["explode_min_damage"], undefined, "MOD_EXPLOSIVE", "alien_minion_explosion" );
}
