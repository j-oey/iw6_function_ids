// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    self endon( "killanimscript" );
    self scragentsetphysicsmode( "noclip" );
    var_0 = gettime();
    self scragentsetorientmode( "face angle abs", self.angles );
    self.looktarget = self.enemy;
    thread _ID38269();
    level.spider_regen_sfx = 0;

    switch ( self._ID20883 )
    {
        case "egg_attack":
            _ID37149( self.enemy );
            break;
        case "close_melee":
            _ID36979();
            break;
        case "bomb_attack":
            _ID37849();
            break;
        case "beam_attack":
            _ID36771();
            self.has_fired_beam = 1;
            break;
        case "beamsweep_attack":
            _ID36778();
            break;
        case "posture_attack":
            _ID37834();
            break;
        case "traverse":
            _ID38162();
            break;
        case "regenpod_attack":
            _ID38074();
            break;
        case "regen_attack":
            _ID37869();
            break;
        case "elevated_retreat_attack":
            _ID37155();
            break;
        case "elevated_return_attack":
            _ID37157();
            break;
        default:
            break;
    }

    if ( var_0 == gettime() )
        wait 0.05;

    while ( self._ID38263 )
        wait 0.05;

    self notify( "melee_complete" );
}

_ID38073( var_0 )
{
    self.spawned = 1;

    if ( isdefined( self._ID37827 ) )
        self._ID37827 delete();

    self._ID37827 = spawn( "script_model", self.origin );
    self._ID37827 setmodel( "armory_alien_hive_spore_coll" );
    self._ID37827.angles = self.angles;
    self._ID37827.maxhealth = 102000;
    self._ID37827.health = 102000;
    self._ID37827 setcandamage( 1 );
    self._ID37827 setcanradiusdamage( 1 );
    self setscriptablepartstate( 0, "start_active" );
    thread _ID37871();
    wait 3;
    self setscriptablepartstate( 0, "loop_active" );
    playfx( level._ID1644["spider_regen_pod"], self.origin + ( 0, 0, 40 ) );
    var_1 = 0;

    while ( var_0 > 0 )
    {
        if ( !isdefined( self._ID37827 ) && !self._ID37125 && !self.spawned )
        {
            var_1 = 1;
            break;
        }

        var_0 -= 0.05;
        wait 0.05;
    }

    var_2 = undefined;

    if ( !var_1 )
    {
        self._ID37125 = 1;
        self waittill( "destroyed",  var_3  );
    }
    else
        var_3 = "killed";

    if ( var_3 == "drained" )
        self setscriptablepartstate( 0, "not_killed" );
    else if ( var_3 == "killed" )
    {
        self setscriptablepartstate( 0, "killed" );

        if ( !isdefined( var_2 ) && isdefined( self.final_attacker ) )
            var_2 = self.final_attacker;

        if ( isdefined( var_2 ) && isplayer( var_2 ) )
        {
            var_4 = int( level._ID2829["brute"].attributes["reward"] * 2 );
            maps\mp\alien\_unk1443::givekillreward( var_2, var_4, "large", "soft" );
        }
    }

    wait 3;
    self setscriptablepartstate( 0, "inactive" );

    if ( isdefined( self._ID37827 ) )
    {
        self._ID37827 setcandamage( 0 );
        self._ID37827 setcanradiusdamage( 0 );
        self._ID37827 delete();
    }

    self.spawned = 0;
}

_ID37871()
{
    self endon( "destroyed" );
    var_0 = undefined;
    self.final_attacker = undefined;

    while ( isdefined( self._ID37827 ) && self._ID37827.health > 100000 )
    {
        self._ID37827 waittill( "damage",  var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10  );

        if ( isdefined( var_2 ) && isplayer( var_2 ) )
        {
            var_2 thread maps\mp\gametypes\_damagefeedback::_ID34528( "standard" );
            var_0 = var_2;
        }

        if ( var_1 > 2000 )
            self._ID37827.health = self._ID37827.health + int( ( var_1 - 2000 ) * 1.1 );
    }

    self._ID37827 setcandamage( 0 );
    self._ID37827 delete();
    self._ID37125 = 0;
    self.spawned = 0;
    self.final_attacker = var_0;
    self notify( "destroyed",  "killed", var_0  );
}

_ID37364()
{
    var_0 = [];

    foreach ( var_2 in level._ID38097 )
    {
        if ( distance( var_2.origin, self.origin ) > 2000 )
            continue;

        if ( isdefined( var_2 ) && isdefined( var_2.spawned ) && var_2.spawned )
            var_0[var_0.size] = var_2;
    }

    return var_0;
}

_ID37349()
{
    var_0 = _ID37364();
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3 ) && isdefined( var_3._ID37125 ) && var_3._ID37125 == 1 )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

_ID37544()
{
    return maps\mp\agents\alien\alien_spider\_alien_spider::_ID37357() < 0.5;
}

_ID38074()
{
    self endon( "regen_interrupted" );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "attack_melee_swipe", 1, "attack_melee", "end", maps\mp\agents\alien\alien_spider\_alien_spider::_ID37398 );
    thread _ID38075();
}

getregenpodscaledspawncount()
{
    switch ( level.players.size )
    {
        case 1:
            return 2;
        case 2:
            return 2;
        case 3:
            return 3;
        default:
            return 3;
    }
}

_ID38075()
{
    var_0 = maps\mp\agents\alien\alien_spider\_alien_spider::_ID37357();

    if ( var_0 <= 1 && var_0 > 0.66 )
        var_1 = 18;
    else if ( var_0 <= 0.66 && var_0 > 0.33 )
        var_1 = 15;
    else
        var_1 = 12;

    var_2 = 0;
    var_3 = _ID37349();

    if ( var_3.size < 3 )
        var_2 = 3 - var_3.size;

    var_4 = getregenpodscaledspawncount();
    var_2 = min( var_4, var_2 );
    level notify( "dlc_vo_notify",  "spider_vo", "spider_pods"  );
    var_5 = common_scripts\utility::array_randomize( level._ID38097 );

    for ( var_6 = 0; var_6 < var_2; var_6++ )
        var_5[var_6] thread _ID38073( var_1 );
}

_ID37869()
{
    self endon( "death" );
    self endon( "spider_stage_end" );
    self endon( "regen_interrupted" );
    var_0 = _ID37349();
    var_1 = var_0[0];
    thread _ID37906( var_1 );
    maps\mp\agents\alien\_alien_anim_utils::_ID33986( var_1 );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "attack_regen", 0, "attack_regen", "end", maps\mp\agents\alien\alien_spider\_alien_spider::_ID37398 );
    var_1 setscriptablepartstate( 0, "healing" );
    _ID37872( var_1 );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "attack_regen", 1, "attack_regen", "end", maps\mp\agents\alien\alien_spider\_alien_spider::_ID37398 );
}

_ID37906( var_0 )
{
    self endon( "death" );
    self endon( "regen_complete" );
    var_0 endon( "destroyed" );
    self waittill( "regen_interrupted" );
    var_0 setscriptablepartstate( 0, "loop_active" );
}

_ID37872( var_0 )
{
    self endon( "death" );
    self endon( "spider_stage_end" );
    self endon( "regen_interrupted" );
    var_0 endon( "destroyed" );

    if ( !isdefined( var_0 ) )
        return;

    thread _ID37870( var_0 );
    var_1 = self getanimentry( "attack_regen", 1 );
    var_2 = getanimlength( var_1 );
    var_3 = 5;
    var_4 = 0.12 * ( self.maxhealth - level._ID38089 );
    var_5 = int( var_4 / 2 );
    var_6 = max( 1, var_4 - var_5 );
    self.health = self.health + var_5;
    var_7 = int( var_3 / var_2 ) + 1;

    for ( var_8 = 0; var_8 < var_7; var_8++ )
    {
        self.health = self.health + int( var_6 / var_7 );

        if ( self.health > self.maxhealth )
            self.health = self.maxhealth;

        self notify( "hp_update" );
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "attack_regen", 2, "attack_regen", "end", maps\mp\agents\alien\alien_spider\_alien_spider::_ID37398 );
    }

    self notify( "regen_complete",  var_0  );
    var_0._ID37125 = 0;
    var_0 notify( "destroyed",  "drained"  );
}

_ID37870( var_0 )
{
    self endon( "death" );
    self endon( "spider_stage_end" );
    self endon( "regen_interrupted" );
    self endon( "regen_complete" );
    var_0 endon( "destroyed" );
    var_1 = vectornormalize( self gettagorigin( "tag_belly_f" ) - var_0.origin ) * 300;
    var_2 = var_1 * -1;
    var_3 = 0.25;

    for ( var_4 = 10; var_4 > 0 && isdefined( var_0 ) && isdefined( var_0 ); var_4 -= var_3 )
    {
        thread regen_sfx( var_4, var_3 );
        playfx( level._ID1644["spider_regen_spider"], self gettagorigin( "tag_belly_f" ), var_2 );
        playfx( level._ID1644["spider_regen_pod"], var_0.origin, var_1 );
        wait(var_3);
    }
}

regen_sfx( var_0, var_1 )
{
    if ( level.spider_regen_sfx == 0 )
    {
        self playloopsound( "spdr_rchrg_lp" );

        for ( level.spider_regen_sfx = 1; var_0 > 0; var_0 -= var_1 )
            wait(var_1);

        self stoploopsound( "spdr_rchrg_lp" );
        self playsoundonmovingent( "spdr_rchrg_end" );
        level.spider_regen_sfx = 0;
    }
}

_ID36776()
{
    self endon( "death" );
    self endon( "spider_stage_end" );
    self endon( "beam_interrupted" );
    playfx( level._ID1644["beam_attack_charge"], self gettagorigin( "tag_belly_f" ) + ( 0, 0, 40 ) );
    wait 0.6;
    wait 1.15;
}

_ID36775()
{
    self endon( "death" );
    self endon( "spider_stage_end" );
    self endon( "beam_interrupted" );
    self setanimstate( "attack_satellite", 0, 1.0 );
    var_0 = self getanimentry( "attack_satellite", 0 );
    var_1 = getanimlength( var_0 );
    wait(var_1 * 0.35);
    var_2 = int( var_1 * 0.65 / 0.1 );

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        playfxontag( level._ID1644["beam_fire_flash"], self, "tag_back_laser_l" );
        playfxontag( level._ID1644["beam_fire_flash"], self, "tag_back_laser_r" );
        wait 0.1;
    }
}

_ID36778()
{
    self endon( "death" );
    self endon( "spider_stage_end" );
    self endon( "beam_interrupted" );
    _ID36776();
    _ID36775();
    var_0 = _ID37294( self._ID36770["left"].origin, self._ID36770["right"].origin );
    var_1 = var_0[2] + -64;
    var_2 = _ID36767();

    if ( !isdefined( var_2 ) )
        var_2 = sortbydistance( level.players, self.origin )[0];

    var_3 = 1;

    if ( common_scripts\utility::_ID7657() )
        var_3 = -1;

    var_4 = ( var_2.origin[0], var_2.origin[1], var_1 );
    var_5 = var_4 - var_0;
    var_6 = vectortoangles( var_5 ) - var_3 * ( 0, 25, 0 );
    var_7 = anglestoforward( var_6 ) * max( distance2d( var_0, var_2.origin ), 1250 ) + var_0;
    var_8 = var_6 + var_3 * ( 0, 100, 0 );
    var_9 = anglestoforward( var_8 ) * max( distance2d( var_0, var_2.origin ), 1250 ) + var_0;

    if ( !isdefined( self._ID38134 ) )
        self._ID38134 = spawn( "script_origin", var_7 );
    else
    {
        self._ID38134 unlink();
        self._ID38134.origin = var_7;
    }

    if ( !isdefined( self._ID36768 ) )
        self._ID36768 = spawn( "script_origin", self.origin );
    else
        self._ID36768.origin = self.origin;

    self._ID36768.angles = self.angles;
    self._ID38134 linkto( self._ID36768 );
    self._ID36770["left"] settargetentity( self._ID38134 );
    self._ID36770["right"] settargetentity( self._ID38134 );
    thread _ID36765( self._ID38134, self._ID38134, 10 );
    thread _ID36766( self._ID36770["left"] );
    thread _ID36766( self._ID36770["right"] );
    var_10 = 0.25;
    var_11 = 4;
    var_12 = var_11 / var_10;
    var_13 = var_3 * 100 / var_12;

    for ( var_14 = 2; var_14 > 0; var_13 = -1 * var_13 )
    {
        thread _ID36774( self._ID38134, "left", var_11, undefined );
        thread _ID36774( self._ID38134, "right", var_11, 0.1 );

        for ( var_15 = 0; var_15 < var_12; var_15++ )
        {
            self._ID36768 rotateyaw( var_13, var_10 );
            wait(var_10);
        }

        var_14--;
    }

    self notify( "beam_stop" );
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( "attack_satellite", 1, 1.0, "attack_satellite", "end", maps\mp\agents\alien\alien_spider\_alien_spider::_ID37398 );
}

_ID36766( var_0 )
{
    self endon( "beam_stop" );
    self endon( "death" );
    self endon( "spider_stage_end" );
    self endon( "beam_interrupted" );
    wait 0.2;

    for (;;)
    {
        var_1 = var_0 gettagangles( "tag_flash" );
        var_2 = vectornormalize( anglestoforward( var_1 ) );
        var_3 = var_0 gettagorigin( "tag_flash" );

        foreach ( var_5 in level.players )
        {
            if ( !self agentcanseesentient( var_5 ) || !isalive( var_5 ) || isdefined( var_5.laststand ) && var_5.laststand )
                continue;

            var_6 = vectordot( var_2, vectornormalize( var_5.origin - var_3 ) );

            if ( var_6 >= 0.995 )
                var_5 dodamage( 3, var_5.origin, self, var_0 );
        }

        wait 0.05;
    }
}

_ID36771()
{
    self endon( "death" );
    self endon( "spider_stage_end" );
    self endon( "beam_interrupted" );
    var_0 = _ID36767();

    if ( !isdefined( var_0 ) )
        return;

    var_0 _ID36769( self );
    level notify( "dlc_vo_notify",  "spider_vo", "spider_before_lasers"  );
    maps\mp\agents\alien\_alien_anim_utils::_ID33986( var_0 );
    _ID36776();

    if ( isdefined( var_0 ) && isdefined( var_0._ID38145 ) )
    {
        self._ID36770["left"] settargetentity( var_0._ID38145 );
        self._ID36770["right"] settargetentity( var_0._ID38145 );
    }

    _ID36775();
    playsoundatpos( self.origin, "alien_fence_shock" );
    level notify( "dlc_vo_notify",  "spider_vo", "spider_lasers"  );

    if ( !maps\mp\alien\_unk1464::_ID18745() )
        var_1 = 4.5;
    else if ( isdefined( self.has_fired_beam ) )
        var_1 = 3.5;
    else
        var_1 = 1.75;

    var_2 = 0;

    if ( isdefined( var_0 ) && isdefined( var_0._ID38145 ) )
    {
        var_0 thread _ID38221( self, self._ID36770 );
        thread _ID36765( var_0._ID38145, var_0 );
        var_2 = _ID36777( var_0, var_1 );
    }

    if ( !isdefined( var_2 ) || !var_2 )
    {
        var_3 = var_0.origin;
        var_0 = _ID36767();

        if ( isdefined( var_0 ) )
        {
            var_0 _ID36769( self, var_3 );

            if ( isdefined( var_0 ) && isdefined( var_0._ID38145 ) )
            {
                self._ID36770["left"] settargetentity( var_0._ID38145 );
                self._ID36770["right"] settargetentity( var_0._ID38145 );
                var_0 thread _ID38221( self, self._ID36770, 1 );
                thread _ID36765( var_0._ID38145, var_0 );
                _ID36777( var_0, var_1 );
            }
        }
    }

    if ( isdefined( var_0 ) && isdefined( var_0._ID38145 ) )
        var_0._ID38145 delete();

    self notify( "beam_stop" );
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( "attack_satellite", 1, 1.0, "attack_satellite", "end", maps\mp\agents\alien\alien_spider\_alien_spider::_ID37398 );
}

_ID36769( var_0, var_1 )
{
    if ( isdefined( self ) && isdefined( self._ID38145 ) )
        self._ID38145 delete();

    if ( !isdefined( var_1 ) )
        var_1 = self.origin;

    self._ID38145 = spawn( "script_origin", var_1 );
}

_ID36767()
{
    var_0 = undefined;
    var_1 = sortbydistance( level.players, self.origin );
    var_2 = [];

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        var_4 = var_1[var_3];

        if ( !isalive( var_4 ) || isdefined( var_4.laststand ) && var_4.laststand )
            continue;

        var_2[var_2.size] = var_4;
    }

    if ( isdefined( var_2 ) && var_2.size )
    {
        var_0 = var_2[0];

        for ( var_3 = 0; var_3 < var_2.size; var_3++ )
        {
            if ( _ID37554( var_2[var_3] ) )
            {
                var_0 = var_2[var_3];
                break;
            }
        }
    }

    return var_0;
}

_ID36765( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "spider_stage_end" );
    self endon( "beam_stop" );
    self endon( "beam_interrupted" );

    if ( !isdefined( var_0 ) )
        return;
    else
        var_0 endon( "death" );

    if ( !isdefined( var_2 ) )
        var_2 = 35;

    if ( isdefined( var_1 ) )
    {
        var_1 endon( "death" );
        var_1 endon( "last_stand" );
    }

    for (;;)
    {
        var_3 = vectornormalize( var_1.origin - self.origin );
        var_4 = maps\mp\agents\alien\_alien_anim_utils::getprojectiondata( anglestoforward( self.angles ), var_3, anglestoup( self.angles ) );

        if ( var_4._ID26742 > var_2 )
        {
            if ( var_4._ID25062 > 0 )
                var_5 = 1;
            else
                var_5 = 0;

            self._ID38135 = 1;
            maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( "attack_satellite_turn", var_5, 1.0, "attack_satellite_turn", "end", maps\mp\agents\alien\alien_spider\_alien_spider::_ID37398 );
            self._ID38135 = 0;
            continue;
        }

        self._ID38135 = 0;
        wait 0.05;
    }
}

_ID37294( var_0, var_1 )
{
    return ( ( var_0[0] + var_1[0] ) / 2, ( var_0[1] + var_1[1] ) / 2, ( var_0[2] + var_1[2] ) / 2 );
}

_ID38221( var_0, var_1, var_2 )
{
    var_0 endon( "death" );
    var_0 endon( "beam_stop" );
    var_0 endon( "spider_stage_end" );
    var_0 endon( "beam_interrupted" );
    self endon( "death" );
    self endon( "last_stand" );
    thread _ID37884( var_0 );
    self._ID38145 endon( "death" );
    var_3 = 1.5;

    if ( isdefined( var_2 ) && var_2 )
    {
        var_4 = self.origin;

        if ( !is_target_in_attack_cone( var_0, var_4, 0.85 ) )
            var_4 = get_edge_of_cone( var_0, var_4, 0.85 );

        self._ID38145 moveto( var_4, var_3 );
        wait(var_3);
    }

    var_5 = 0;

    for (;;)
    {
        var_6 = _ID37294( var_1["left"].origin, var_1["right"].origin );

        if ( self.origin[2] <= var_6[2] )
            var_7 = ( 0, 0, 0 );
        else
        {
            var_8 = distance( var_6, self.origin );

            if ( var_8 <= 0.001 && var_8 >= -0.001 )
                var_8 = 0.001;

            var_9 = self.origin[2] - var_6[2];
            var_10 = min( 15, asin( var_9 / var_8 ) );
            var_7 = var_10 / 15 * ( 0, 0, 64 );
        }

        var_4 = self.origin + var_7;

        if ( !is_target_in_attack_cone( var_0, var_4, 0.85 ) )
            var_4 = get_edge_of_cone( var_0, var_4, 0.85 );

        var_11 = anglestoforward( var_0.angles );
        var_12 = self.origin - var_0.origin;
        var_13 = abs( vectortoangles( var_11 )[1] - vectortoangles( var_12 )[1] );
        var_14 = abs( var_5 - var_13 );
        var_5 = var_13;
        var_15 = 3;
        var_16 = vectornormalize( self._ID38145.origin - var_4 ) * ( var_14 * var_15 ) + var_4;
        self._ID38145 moveto( var_16, 0.1 );
        wait 0.1;
    }
}

get_edge_of_cone( var_0, var_1, var_2 )
{
    var_3 = distance( var_0.origin, var_1 );
    var_4 = var_1[2];
    var_5 = var_0.angles + ( 0, acos( var_2 ), 0 );
    var_6 = var_0.angles - ( 0, acos( var_2 ), 0 );
    var_7 = var_0.origin + vectornormalize( anglestoforward( var_5 ) ) * var_3;
    var_8 = var_0.origin + vectornormalize( anglestoforward( var_6 ) ) * var_3;
    var_7 = ( var_7[0], var_7[1], var_4 );
    var_8 = ( var_8[0], var_8[1], var_4 );

    if ( distance( var_7, var_1 ) <= distance( var_8, var_1 ) )
        return var_7;
    else
        return var_8;
}

is_target_in_attack_cone( var_0, var_1, var_2 )
{
    var_3 = vectornormalize( var_1 - var_0.origin );
    var_3 = ( var_3[0], var_3[1], 0 );
    var_4 = ( anglestoforward( var_0.angles )[0], anglestoforward( var_0.angles )[1], 0 );
    var_5 = vectordot( var_3, var_4 );

    if ( var_5 > var_2 )
        return 1;

    return 0;
}

_ID37884( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "beam_stop" );
    var_0 endon( "beam_interrupted" );
    var_0 endon( "spider_stage_end" );
    common_scripts\utility::_ID35626( "death", "last_stand" );

    if ( isdefined( self ) && isdefined( self._ID38145 ) )
        self._ID38145 delete();
}

_ID37554( var_0 )
{
    if ( !isalive( var_0 ) || isdefined( var_0.laststand ) && var_0.laststand )
        return 0;

    var_1 = distance( self.origin, var_0.origin );

    if ( var_1 < 4000 && var_1 > 10 && self agentcanseesentient( var_0 ) )
        return 1;

    return 0;
}

_ID36777( var_0, var_1 )
{
    var_0 endon( "last_stand" );
    var_0 endon( "death" );
    self endon( "target_lost" );
    thread _ID37705( var_0 );
    thread _ID36774( var_0._ID38145, "left", var_1, undefined );
    thread _ID36774( var_0._ID38145, "right", var_1, 0.1 );
    wait(var_1);
    return 1;
}

_ID37705( var_0 )
{
    self endon( "death" );
    self endon( "spider_stage_end" );
    self endon( "beam_stop" );
    self notify( "monitorTargetVisibility" );
    self endon( "monitorTargetVisibility" );

    if ( !issentient( var_0 ) )
        return;

    var_0 endon( "death" );
    var_0 endon( "last_stand" );

    for (;;)
    {
        if ( !self agentcanseesentient( var_0 ) )
        {
            wait 0.75;

            if ( !self agentcanseesentient( var_0 ) )
            {
                self notify( "target_lost" );
                break;
            }
        }

        wait 0.05;
    }
}

_ID36774( var_0, var_1, var_2, var_3 )
{
    self endon( "beam_stop" );
    self endon( "death" );
    self endon( "spider_stage_end" );
    self endon( "beam_interrupted" );
    var_4 = self._ID36770[var_1];
    var_5 = weaponfiretime( "spider_beam_mp" );
    var_6 = 10;

    if ( isdefined( var_2 ) && var_2 < var_6 )
        var_6 = var_2;

    thread _ID36773( var_4, var_6, var_3 );
    thread _ID36772( var_0 );

    while ( var_6 > 0 && isdefined( var_0 ) )
    {
        var_7 = var_4 gettagangles( "tag_flash" );
        var_8 = vectornormalize( anglestoforward( var_7 ) );
        var_9 = vectornormalize( var_0.origin - var_4.origin );
        var_10 = vectordot( var_8, var_9 );

        if ( var_10 > 0.95 )
            var_4 shootturret();

        var_6 -= var_5;
        wait(var_5);
    }

    self notify( "internal_beamAttackTarget_ended" );
}

_ID36772( var_0 )
{
    self endon( "beam_stop" );
    self endon( "death" );
    self endon( "spider_stage_end" );
    self endon( "beam_interrupted" );
    self endon( "internal_beamAttackTarget_ended" );
    var_1 = self getanimentry( "attack_satellite", 2 );
    var_2 = getanimlength( var_1 );

    if ( !isdefined( self._ID38135 ) )
        self._ID38135 = 0;

    while ( isdefined( var_0 ) )
    {
        if ( !self._ID38135 )
        {
            self setanimstate( "attack_satellite", 2, 1.0 );
            wait(var_2);
        }

        wait 0.05;
    }
}

_ID36773( var_0, var_1, var_2 )
{
    if ( isdefined( var_2 ) )
        wait(var_2);

    if ( !isdefined( self ) || !isdefined( var_0 ) )
        return;

    playfxontag( level._ID1644["darts_fire_1"], var_0, "tag_flash" );
    thread _ID36967( var_0 );
    var_1 = max( 0, var_1 - 0.5 );
    common_scripts\utility::_ID35637( var_1, "beam_stop", "death", "weapon_death", "beam_interrupted" );
    stopfxontag( level._ID1644["darts_fire_1"], var_0, "tag_flash" );
}

_ID36967( var_0 )
{
    self endon( "death" );
    self endon( "spider_stage_end" );
    var_0 notify( "CleanUpBeamFireFx" );
    var_0 endon( "CleanUpBeamFireFx" );
    var_0 waittill( "death" );
    self notify( "weapon_death" );
}

_ID37997()
{
    _ID37996( "tag_back_laser_l", "left", "axis" );
    _ID37996( "tag_back_laser_r", "right", "axis" );
}

_ID37996( var_0, var_1, var_2 )
{
    if ( !isdefined( self._ID36770 ) )
        self._ID36770 = [];

    if ( isdefined( self._ID36770[var_1] ) )
        return;

    self._ID36770[var_1] = spawnturret( "misc_turret", self gettagorigin( var_0 ), "spider_beam_mp" );
    self._ID36770[var_1] linkto( self, var_0 );
    self._ID36770[var_1] setmodel( "spider_beam_gun" );
    self._ID36770[var_1].angles = self gettagangles( var_0 );
    self._ID36770[var_1].team = var_2;
    self._ID36770[var_1] maketurretinoperable();
    self._ID36770[var_1] makeunusable();
    self._ID36770[var_1].health = 1000000;
    self._ID36770[var_1].maxhealth = 1000000;
    self._ID36770[var_1] setmode( "manual" );
    self._ID36770[var_1] setturretteam( var_2 );
}

_ID37849()
{
    self endon( "projectile_spit_interrupted" );
    self endon( "killanimscript" );
    self endon( "spider_stage_end" );
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( "attack_bomb", 0, 1.0, "attack_bomb", "end" );
    var_0 = _ID37361( 3 );
    var_1 = _ID37352( 3 );
    var_2 = [];

    if ( var_0.size == 0 )
        var_2 = var_1;
    else
    {
        var_2[0] = var_0[0];

        for ( var_3 = 0; var_3 < 2; var_3++ )
            var_2[var_2.size] = var_1[var_3];
    }

    foreach ( var_5 in var_2 )
    {
        var_6 = var_5.origin;
        maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( "attack_bomb", 2, 1.0, "attack_bomb", "start_attack" );

        if ( isdefined( var_5._ID37604 ) )
            var_5._ID37604 = gettime();

        thread _ID38104( var_6 );
        maps\mp\agents\_scriptedagents::_ID35786( "attack_bomb", "end" );
    }

    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( "attack_bomb", 1, 1.0, "attack_bomb", "end" );
}

_ID37352( var_0 )
{
    var_1 = [];
    var_2 = _ID37350( 35.0 );
    var_3 = "Not enough 'available' spit choke nodes in range, has " + var_2.size + ", need " + max( var_0, 4 );
    var_4 = [];

    foreach ( var_6 in level.players )
    {
        if ( !isalive( var_6 ) )
            continue;

        var_4[var_4.size] = var_6;
    }

    var_4 = common_scripts\utility::array_randomize( var_4 );

    if ( var_4.size == 0 )
        return var_1;

    var_8 = max( 0, var_0 - var_4.size );
    var_9 = [];

    foreach ( var_6 in var_4 )
    {
        for ( var_11 = 0; var_11 < var_8 + 1; var_11++ )
            var_9[var_9.size] = sortbydistance( var_2, var_6.origin )[var_11];

        var_8 = 0;
    }

    var_1 = sortbydistance( var_9, self.origin );
    return var_1;
}

_ID37350( var_0 )
{
    var_1 = [];
    var_2 = gettime();

    foreach ( var_4 in level._ID38098 )
    {
        var_5 = distance2d( self.origin, var_4.origin );

        if ( var_5 > 2500 && var_5 < 256 )
            continue;

        if ( var_2 - var_4._ID37604 > var_0 * 1000 )
            var_1[var_1.size] = var_4;
    }

    return var_1;
}

_ID37361( var_0 )
{
    var_1 = [];
    var_2 = common_scripts\utility::array_randomize( level.players );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = var_2[var_3];

        if ( !isalive( var_4 ) )
            continue;

        if ( player_in_spit_exclusion_volume( var_4 ) )
            continue;

        var_5 = distance2d( self.origin, var_4.origin );

        if ( var_5 < 2500 && var_5 > 256 && var_1.size < var_0 )
            var_1[var_1.size] = var_4;
    }

    return var_1;
}

player_in_spit_exclusion_volume( var_0 )
{
    var_1 = getent( "spit_exclusion", "targetname" );

    if ( var_0 istouching( var_1 ) )
        return 1;

    return 0;
}

_ID38104( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_1 = self gettagorigin( "tag_tail_laser_r" ) + ( self gettagorigin( "tag_tail_laser_l" ) - self gettagorigin( "tag_tail_laser_r" ) ) * 0.5;
    var_2 = var_0;
    var_3 = trajectorycalculateinitialvelocity( var_1, var_2, ( 0, 0, -1500 ), 3 );
    var_4 = spawn( "script_model", var_1 );
    var_4.angles = self.angles;
    var_4 setmodel( "mp_ext_alien_hive_physics" );
    var_4.owner = self;
    common_scripts\utility::_ID35582();

    if ( maps\mp\alien\_unk1464::_ID18506( level._ID38083 ) )
        playfxontag( level._ID1644["easter_egg_spitter_trail"], var_4, "tag_origin" );
    else
        playfxontag( level._ID1644["projectile_spit_trail"], var_4, "tag_origin" );

    var_4 physicslaunchserver( ( 5, 0, 0 ), var_3 * 22, 1500 );
    wait 2.25;
    var_5 = var_4.origin;
    playfx( level._ID1644["bomb_airburst"], var_5 );

    if ( maps\mp\alien\_unk1464::_ID18506( level._ID38083 ) )
        stopfxontag( level._ID1644["easter_egg_spitter_trail"], var_4, "tag_origin" );
    else
        stopfxontag( level._ID1644["projectile_spit_trail"], var_4, "tag_origin" );

    var_4 delete();
    var_6 = 175;

    for ( var_7 = 0; var_7 < 2; var_7++ )
    {
        wait(randomfloatrange( 0.25, 0.45 ));
        var_0 += ( var_6 / 2 - var_7 * var_6, var_6 / 2 - var_7 * var_6, 0 );
        var_8 = magicbullet( "spider_gas_mp", var_5, var_0, self );
        var_8.owner = self;

        if ( isdefined( var_8 ) )
            var_8 thread _ID37245();
    }
}

_ID37245()
{
    self waittill( "explode",  var_0  );

    if ( !isdefined( var_0 ) )
        return;

    var_1 = spawn( "trigger_radius", var_0, 0, 150, 128 );

    if ( !isdefined( var_1 ) )
        return;

    var_1._ID22876 = 1;
    playfx( level._ID1644["proj_spit_AOE"], var_0 + ( 0, 0, 8 ), ( 0, 0, 1 ), ( 1, 0, 0 ) );
    thread _ID31015( var_0, var_1 );
    wait 35.0;
    var_1 delete();
}

_ID31015( var_0, var_1 )
{
    var_1 endon( "death" );
    var_2 = 2.0;
    wait(var_2);

    for (;;)
    {
        var_1 waittill( "trigger",  var_3  );

        if ( !isplayer( var_3 ) )
            continue;

        if ( !isalive( var_3 ) )
            continue;

        damage_player( var_3, var_1 );
    }
}

damage_player( var_0, var_1 )
{
    var_0 shellshock( "alien_spitter_gas_cloud", 0.5 );
    var_2 = 0.5;
    var_3 = 12.0;
    var_4 = 9.0;
    var_5 = gettime();

    if ( !isdefined( var_0._ID19497 ) )
        var_6 = var_2;
    else if ( var_0._ID19497 + var_2 * 1000.0 > var_5 )
        return;
    else
        var_6 = min( var_2, ( var_5 - var_0._ID19497 ) * 0.001 );

    if ( !maps\mp\alien\_unk1464::_ID18745() )
        var_7 = int( var_3 * var_6 );
    else
        var_7 = int( var_4 * var_6 );

    if ( var_7 > 0 )
        var_0 thread [[ level.callbackplayerdamage ]]( var_1, var_1, var_7, 0, "MOD_SUICIDE", "spider_gas_mp", var_1.origin, ( 0, 0, 0 ), "none", 0 );

    var_0._ID19497 = var_5;
}

_ID36979()
{
    self endon( "vulnerable" );

    if ( isdefined( self._ID36977 ) )
    {
        var_0 = anglestoforward( self.angles );
        var_1 = vectornormalize( self._ID36977.origin - self.origin );
        var_2 = angleclamp180( vectortoyaw( var_1 ) - self.angles[1] );
        var_3 = maps\mp\agents\_scriptedagents::getangleindex( var_2 );
    }
    else
        var_3 = randomint( self getanimentrycount( "attack_melee_swipe" ) );

    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "attack_melee_directional", var_3, "attack_melee", "start_melee" );
    handlemeleedamage();
    maps\mp\agents\_scriptedagents::_ID35786( "attack_melee", "end" );
}

handlemeleedamage()
{
    var_0 = level._ID2829[self.alien_type].attributes["swipe_max_distance"] * level._ID2829[self.alien_type].attributes["swipe_max_distance"] * 1.25;
    earthquake( 0.5, 0.25, self.origin, var_0 + 200 );

    if ( isalive( self._ID36977 ) )
    {
        var_1 = distance2dsquared( self.origin, self._ID36977.origin );

        if ( distancesquared( self.origin, self._ID36977.origin ) < var_0 )
        {
            maps\mp\agents\alien\_alien_melee::_ID20825( self._ID36977, "swipe" );
            self._ID36977 _ID37796( 800, vectornormalize( self._ID36977.origin - self.origin ) );
        }
    }
}

_ID37796( var_0, var_1 )
{
    var_2 = 600.0;
    var_3 = self getvelocity();
    var_4 = var_1 * var_0;
    var_5 = ( var_3 + var_4 ) * ( 1, 1, 0 );
    var_6 = length( var_5 );

    if ( var_6 >= 400.0 )
        var_5 = vectornormalize( var_5 ) * 400.0;

    self setvelocity( var_5 );
}

_ID37830()
{
    self endon( "portal_spawn_failed" );
    var_0 = 4000.0;
    var_1 = gettime() + var_0;
    var_2 = _ID37362();

    for (;;)
    {
        if ( maps\mp\alien\_spawn_director::_ID37893( var_2, 0 ) >= var_2 )
            break;

        if ( gettime() >= var_1 )
            self notify( "portal_spawn_failed" );

        wait 0.05;
    }

    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( "attack_satellite", 0, 1, "attack_satellite", "end", maps\mp\agents\alien\alien_spider\_alien_spider::_ID37398 );
    var_3 = _ID37294( self gettagorigin( "tag_back_laser_l" ), self gettagorigin( "tag_back_laser_r" ) );
    var_3 += ( 0, 0, -50 );

    if ( isdefined( self._ID37829 ) )
        self._ID37829 delete();

    self._ID37829 = spawn( "script_model", var_3 );
    self._ID37829 setmodel( "tag_origin" );
    self._ID37829.angles = self.angles;
    common_scripts\utility::_ID35582();
    playsoundatpos( self._ID37829.origin, "alien_fence_shock" );
    playfxontag( level._ID1644["beam_vortex"], self._ID37829, "tag_origin" );
    thread _ID37807( 2, "tag_back_laser_l", "tag_back_laser_r" );
    wait 2;

    for ( var_4 = 0; var_4 < var_2; var_4++ )
    {
        _ID38076( self._ID37829 );
        wait 1;
    }

    stopfxontag( level._ID1644["beam_vortex"], self._ID37829, "tag_origin" );
    self notify( "stopFlashFxOnSpider" );
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( "attack_satellite", 1, 1.0, "attack_satellite", "end", maps\mp\agents\alien\alien_spider\_alien_spider::_ID37398 );
    self._ID37829 delete();
}

_ID37362()
{
    var_0 = level._ID2829[self.alien_type].attributes[self._ID38117]["portalspawn_count"];
    var_1 = maps\mp\alien\_spawn_director::_ID14393();
    var_0 *= var_1;

    if ( var_0 > 0 && var_0 < 1.0 )
        var_0 = 1;

    return int( var_0 );
}

_ID37807( var_0, var_1, var_2 )
{
    self endon( "stopFlashFxOnSpider" );
    self endon( "portal_spawn_failed" );
    self endon( "death" );
    self endon( "spider_stage_end" );
    var_3 = int( var_0 / 0.1 );

    for ( var_4 = 0; var_4 < var_3; var_4++ )
    {
        playfxontag( level._ID1644["beam_fire_flash"], self, var_1 );
        playfxontag( level._ID1644["beam_fire_flash"], self, var_2 );
        wait 0.1;
    }
}

_ID38076( var_0 )
{
    var_1 = level._ID2829[self.alien_type].attributes[self._ID38117]["portalspawn_alien_type"];
    var_2 = maps\mp\alien\_spawn_director::_ID37847( var_1, var_0, undefined );
    level._ID37768--;
    var_3 = anglestoforward( var_0.angles );
    var_4 = 1;
    var_5 = "ground_slam";

    if ( var_1 != "elite" )
        var_5 = "posture";

    var_2 thread _ID37121( var_5, var_4, var_3 );
}

_ID37121( var_0, var_1, var_2 )
{
    self endon( "death" );

    for ( var_3 = 0; var_3 < var_1; var_3++ )
    {
        if ( var_0 == "posture" )
        {
            self scragentsetscripted( 1 );
            maps\mp\alien\_unk1464::_ID28196( 0.2, 1 );
            self scragentsetorientmode( "face angle abs", self.angles );
            maps\mp\agents\_scriptedagents::_ID23883( "posture", "posture", "end", maps\mp\agents\alien\alien_spider\_alien_spider::_ID37398 );
            maps\mp\alien\_unk1464::_ID28197( 0.2 );
            self scragentsetscripted( 0 );
        }

        if ( var_0 == "ground_slam" )
        {
            self scragentsetscripted( 1 );
            maps\mp\alien\_unk1464::_ID28196( 0.2, 1 );
            self scragentsetorientmode( "face angle abs", self.angles );
            maps\mp\agents\_scriptedagents::_ID23883( "attack_melee_swipe", "attack_melee", "end", maps\mp\agents\alien\alien_spider\_alien_spider::_ID37398 );
            maps\mp\alien\_unk1464::_ID28197( 0.2 );
            self scragentsetscripted( 0 );
        }

        wait(randomfloatrange( 0.5, 1.0 ));
    }
}

_ID37149( var_0 )
{
    self endon( "death" );
    self endon( "spider_stage_end" );
    self endon( "egg_interrupted" );
    self endon( "egg_spawn_failed" );
    var_1 = 4000.0;
    var_2 = gettime() + var_1;
    var_3 = _ID37356();

    for (;;)
    {
        if ( int( maps\mp\alien\_spawn_director::_ID37893( var_3, 0 ) ) >= var_3 )
            break;

        if ( gettime() >= var_2 )
        {
            var_3 = int( maps\mp\alien\_spawn_director::_ID37893( var_3, 1 ) );
            break;
        }

        wait 0.05;
    }

    self._ID37142 = var_3;

    if ( var_3 == 0 )
    {
        self notify( "egg_spawn_failed" );
        return;
    }
    else
        thread _ID37883();

    var_4 = _ID37202( var_0 );
    var_5 = common_scripts\utility::array_randomize( var_4._ID30723 );
    var_6 = _ID37355( var_4.origin );
    maps\mp\agents\alien\_alien_anim_utils::_ID33986( var_4 );
    _ID37792( "egg_spawn_enter", var_6 );
    _ID37793( var_5[0], 0 );

    if ( var_3 > 1 )
    {
        for ( var_7 = 0; var_7 < var_3 - 1; var_7++ )
        {
            common_scripts\utility::_ID35582();
            _ID37793( var_5[var_7 + 1], var_7 + 1 );

            if ( _ID37545( var_7 ) || var_7 == var_3 - 1 )
                _ID37792( "egg_spawn_fire", var_6 );
        }
    }
    else
        _ID37792( "egg_spawn_fire", var_6 );

    level notify( "dlc_vo_notify",  "spider_vo", "spider_eggs"  );
    maps\mp\agents\_scriptedagents::_ID35786( "egg_spawn_fire", "end" );
    _ID37792( "egg_spawn_exit", var_6 );
}

_ID37883()
{
    self endon( "death" );
    self endon( "melee_complete" );
    self waittill( "egg_interrupted" );
    var_0 = max( 0, self._ID37142 );
    maps\mp\alien\_spawn_director::_ID37882( var_0 );
}

_ID37545( var_0 )
{
    if ( common_scripts\utility::mod( var_0, 2 ) == 0 )
        return 1;

    return 0;
}

_ID37355( var_0 )
{
    var_1 = level._ID2829[self.alien_type].attributes["egg_attack_far_distance"] * level._ID2829[self.alien_type].attributes["egg_attack_far_distance"];

    if ( distancesquared( var_0, self.origin ) < var_1 )
        return 0;
    else
        return 1;
}

_ID37793( var_0, var_1 )
{
    self._ID37142--;
    thread _ID38154( var_0, var_1 );
}

_ID37792( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = "end";

    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( var_0, var_1, 1.0, var_0, var_2, maps\mp\agents\alien\alien_spider\_alien_spider::_ID37398 );
}

_ID37356()
{
    var_0 = level._ID2829[self.alien_type].attributes[self._ID38117]["egg_min_count"];
    var_1 = level._ID2829[self.alien_type].attributes[self._ID38117]["egg_max_count"];
    var_2 = randomfloatrange( var_0, var_1 );

    switch ( level.players.size )
    {
        case 1:
            var_3 = 0.75;
            break;
        case 2:
            var_3 = 1;
            break;
        case 3:
            var_3 = 1;
            break;
        default:
            var_3 = 1.0;
            break;
    }

    return int( max( var_3 * var_2, 1 ) );
}

handle_egg_custom_spawn_cleanup( var_0 )
{
    self endon( var_0 );
    common_scripts\utility::_ID35635( "death", "spider_stage_end" );
    maps\mp\alien\_spawn_director::_ID37882( 1 );
}

_ID38154( var_0, var_1 )
{
    var_2 = "egg_hatch" + var_1;
    thread handle_egg_custom_spawn_cleanup( var_2 );
    self endon( "death" );
    self endon( "spider_stage_end" );

    if ( !isdefined( var_0 ) )
        return;

    var_3 = self gettagorigin( "tag_tail_laser_r" ) + ( self gettagorigin( "tag_tail_laser_l" ) - self gettagorigin( "tag_tail_laser_r" ) ) * 0.5;
    var_4 = 2;

    if ( abs( self gettagorigin( "tag_tail_laser_r" )[2] - var_0.origin[2] ) >= 128 )
        var_4 = 2.5;

    var_5 = trajectorycalculateinitialvelocity( var_3, var_0.origin, ( 0, 0, -1500 ), var_4 );
    var_6 = spawn( "script_model", var_3 );
    var_6.angles = self.angles;
    var_6 setmodel( "alien_spider_egg" );
    var_6.owner = self;
    var_6.targetname = "alien_spider_egg";

    if ( _ID37545( var_1 ) )
        var_6 linkto( self, "tag_tail_laser_r" );
    else
        var_6 linkto( self, "tag_tail_laser_l" );

    wait 0.45;
    thread _ID37242();
    var_6 unlink();
    common_scripts\utility::_ID35582();

    if ( maps\mp\alien\_unk1464::_ID18506( level._ID38083 ) )
        playfxontag( level._ID1644["easter_egg_trl"], var_6, "tag_origin" );
    else
        playfxontag( level._ID1644["egg_launch_trail"], var_6, "tag_origin" );

    var_6 thread _ID37734( var_6, var_5, var_4 );
    thread _ID38275( var_6, var_0, var_2 );
    self waittill( var_2,  var_7, var_8, var_9, var_10  );

    if ( !isdefined( var_8 ) )
        return;

    var_11 = !isdefined( var_7 );
    thread _ID37141( var_11, var_8 );

    if ( isdefined( var_7 ) )
    {
        level notify( "egg_" + var_7 + "_hatched" );

        if ( !var_9 )
            var_0 = spawn( "script_origin", var_8.origin );

        var_12 = maps\mp\alien\_spawn_director::_ID37845( var_7, var_0, undefined );

        if ( !isdefined( var_12 ) )
            return;

        if ( var_7 == "brute" )
        {
            var_13 = "egg_hatch";
            var_14 = getanimlength( var_12 getanimentry( var_13, 0 ) );
        }
        else
        {
            var_13 = undefined;
            var_14 = 0.1;
        }

        var_12 thread _ID36923( var_8, var_0.origin, var_13, var_14 );

        if ( !var_9 )
        {
            var_0 delete();
            return;
        }
    }
    else
    {
        if ( isdefined( var_10 ) && isplayer( var_10 ) )
        {
            var_15 = level._ID2829["brute"].attributes["reward"];
            maps\mp\alien\_unk1443::givekillreward( var_10, var_15, "large", "soft" );
        }

        maps\mp\alien\_spawn_director::_ID37882( 1 );
    }
}

_ID37734( var_0, var_1, var_2 )
{
    var_0 endon( "death" );
    var_3 = var_0.origin;
    var_0 rotatevelocity( ( 360, 360, 360 ), var_2 );
    var_4 = 0;
    var_5 = 0.05;

    for ( var_6 = var_3; var_4 <= var_2; var_4 += var_5 )
    {
        var_7 = var_1[0] * var_4;
        var_8 = var_1[1] * var_4;
        var_9 = var_1[2] * var_4 - 750.0 * var_4 * var_4;
        var_0.origin = var_3 + ( var_7, var_8, var_9 );
        var_6 = var_0.origin;
        wait(var_5);
    }
}

_ID36923( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    maps\mp\alien\_unk1464::_ID11418();
    self scragentsetgoalradius( 4000 );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self.angles );
    self scragentsetphysicsmode( "noclip" );
    self setorigin( var_1 );
    var_4 = 1.5;
    var_3 /= var_4;

    if ( isdefined( var_2 ) )
        self setanimstate( var_2, 0, var_4 );

    var_5 = var_0.origin;
    var_6 = 0.4;
    wait(var_3 * var_6);

    if ( maps\mp\alien\_unk1464::_ID18506( level._ID38083 ) )
        playfx( level._ID1644["easter_egg_explode"], common_scripts\utility::drop_to_ground( var_5, 32, -500 ) );
    else
        playfx( level._ID1644["egg_explosion"], common_scripts\utility::drop_to_ground( var_5, 32, -500 ) );

    wait 0.1;

    if ( isdefined( var_0 ) )
        var_0 delete();

    wait(var_3 * ( 1.0 - var_6 ));
    self scragentsetphysicsmode( "gravity" );
    _ID7445();
}

_ID37141( var_0, var_1 )
{
    if ( !var_0 )
        var_1 common_scripts\utility::_ID35637( 10, "death", "destroyed" );

    if ( isdefined( var_1 ) )
        var_1 delete();
}

_ID7445()
{
    maps\mp\alien\_unk1464::_ID10053();

    foreach ( var_1 in maps\mp\alien\_unk1464::get_players() )
        self getenemyinfo( var_1 );
}

_ID21693( var_0, var_1, var_2, var_3 )
{
    var_4 = 2;
    var_5 = 60;
    var_6 = 32;
    var_7 = self getanimentry( var_0, var_1 );
    var_8 = getanimlength( var_7 );
    var_9 = getmovedelta( var_7, 0, 1 );
    var_10 = rotatevector( var_9, self.angles );
    var_11 = self.origin + ( var_10[0], var_10[1], var_5 );
    var_12 = var_11 - ( 0, 0, 2 * var_5 );
    var_13 = self aiphysicstrace( var_11, var_12, var_6, 65 );
    var_14 = var_13 - var_10 + ( 0, 0, var_4 );
    self setorigin( var_14 );
}

_ID37702( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_3 = 18000;

    while ( isdefined( var_0 ) )
    {
        var_4 = var_0.classname;
        var_5 = var_0.origin;
        var_6 = "unknown";

        if ( isdefined( var_0.model ) )
            var_6 = var_0.model;

        var_7 = "(" + var_6 + ")(" + var_4 + ")(origin:" + var_5 + ")(initialVelocity:" + var_1 + ")(startPos:" + var_2 + ")";

        if ( _ID37550( var_0, var_3 ) )
        {
            var_0 notify( "out_of_bound" );
            var_0 delete();
        }

        common_scripts\utility::_ID35582();
    }
}

_ID37550( var_0, var_1 )
{
    var_2 = abs( var_0.origin[0] ) >= var_1;
    var_3 = abs( var_0.origin[1] ) >= var_1;
    var_4 = abs( var_0.origin[2] ) >= var_1;
    return var_2 || var_3 || var_4;
}

_ID37242()
{
    wait 0.3;
    playfxontag( level._ID1644["egg_launch"], self, "j_tail_3" );
}

_ID38275( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( var_2 );
    var_3 = _ID37612( var_0, var_1, var_2 );
    var_3 playsound( "egg_land" );
    var_3 endon( "death" );
    var_3 endon( "destroyed" );
    thread _ID37848( var_3, var_2, 1 );
    var_4 = 4;

    if ( level.players.size == 1 || maps\mp\alien\_unk1464::_ID18745() )
        var_4 = 6;

    wait(var_4);
    var_5 = "brute";

    if ( maps\mp\alien\_unk1464::_ID18745() )
    {
        if ( !isdefined( self.gooncount ) )
            self.gooncount = 0;

        if ( self.gooncount < 2 )
        {
            var_5 = "goon";
            self.gooncount++;
        }
        else
            self.gooncount = 0;
    }

    self notify( var_2,  var_5, var_3, 1  );
}

_ID37612( var_0, var_1, var_2 )
{
    var_3 = common_scripts\utility::drop_to_ground( var_1.origin, 32, -500 ) - ( 0, 0, 3 );
    var_4 = 40000;
    var_5 = 5;

    while ( distancesquared( var_3, var_0.origin ) > var_4 && var_5 > 0 )
    {
        var_5 -= 0.05;
        wait 0.05;
    }

    var_6 = var_0.origin;
    var_7 = var_0.angles;
    var_8 = ( 0.0, var_1.angles[1], 0.0 );
    var_9 = 0.2;
    var_10 = spawn( "script_model", var_6 );
    var_10.angles = var_0.angles;
    var_10 setmodel( "alien_spider_egg" );
    var_10.owner = self;
    playfxontag( level._ID1644["egg_glow"], var_10, "tag_origin" );
    var_0 delete();
    var_10 scriptmodelplayanim( "egg_drone_egg_scale_up" );

    while ( var_9 <= 1.0 )
    {
        wait 0.05;
        var_10.origin = vectorlerp( var_6, var_3, var_9 );
        var_10.angles = vectorlerp( var_7, var_8, var_9 );
        var_9 += 0.2;
    }

    var_10.origin = var_3;
    var_10.angles = var_8;
    return var_10;
}

_ID37848( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_0 endon( "destroyed" );
    self endon( var_1 );
    var_0 setcandamage( 1 );
    var_0 thread process_damage_feedback();
    var_0.maxhealth = level._ID2829[self.alien_type].attributes[self._ID38117]["egg_health"];
    var_0.health = var_0.maxhealth;
    var_0 waittill( "death",  var_3  );

    if ( maps\mp\alien\_unk1464::_ID18506( level._ID38083 ) )
        playfx( level._ID1644["easter_egg_explode"], common_scripts\utility::drop_to_ground( var_0.origin, 32, -500 ) );
    else
        playfx( level._ID1644["egg_explosion"], common_scripts\utility::drop_to_ground( var_0.origin, 32, -500 ) );

    level notify( "egg_destroyed" );
    var_0 playsound( "egg_destroy" );
    self notify( var_1,  undefined, var_0, var_2, var_3  );
}

process_damage_feedback()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "damage",  var_0, var_1, var_2, var_3, var_4  );

        if ( isdefined( var_1 ) && isplayer( var_1 ) )
            var_1 thread maps\mp\gametypes\_damagefeedback::_ID34528( "standard" );
    }
}

_ID37202( var_0 )
{
    var_1 = 2200;
    var_2 = [];
    var_3 = sortbydistance( level._ID38084, self.origin );

    for ( var_4 = 1; var_4 < var_3.size; var_4++ )
    {
        var_5 = var_3[var_4];

        if ( distance( var_5.origin, self.origin ) > var_1 )
            break;

        var_2[var_2.size] = var_5;
    }

    var_3 = sortbydistance( var_2, var_0.origin );
    var_6 = 1;
    var_7 = [];
    var_8 = 1.0;

    for ( var_9 = 0; var_9 < var_3.size; var_9++ )
    {
        for ( var_4 = 0; var_4 < int( var_8 ); var_4++ )
            var_7[var_7.size] = var_9;

        var_8 += var_6;
    }

    var_10 = var_7[randomint( var_7.size )];
    var_11 = var_3[var_10];
    return var_11;
}

_ID37834()
{
    self endon( "vulnerable" );

    if ( isdefined( self.enemy ) )
        maps\mp\agents\alien\_alien_anim_utils::_ID33986( self.enemy );

    self._ID37834 = 1;
    thread _ID37836();
    thread _ID37835();
    thread _ID37243();
    level notify( "dlc_vo_notify",  "spider_vo", "spider_hurt"  );
    self waittill( "end_posture" );
    self._ID37834 = 0;
    self notify( "posture_finished" );
}

_ID37243()
{
    self setscriptablepartstate( "body", "vulnerable" );
    self waittill( "posture_finished" );
    self setscriptablepartstate( "body", "normal" );
}

_ID37835()
{
    self endon( "death" );
    self endon( "spider_stage_end" );
    self endon( "killanimscript" );
    self endon( "downed" );
    var_0 = self getanimentrycount( "posture" );
    var_1 = randomint( var_0 );
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack( "posture", var_1, 1.5, "posture", "end", ::_ID37395 );
    self notify( "end_posture" );
}

_ID37395( var_0, var_1, var_2, var_3 )
{
    switch ( var_0 )
    {
        case "mouth_open":
            maps\mp\alien\_unk1464::_ID28196( 0.1, 1.0 );
            return;
        case "mouth_close":
            maps\mp\alien\_unk1464::_ID28197( 0.1 );
            return;
    }
}

_ID37314()
{
    var_0 = self._ID37837;
    self._ID37837++;
    var_1 = level._ID2829[self.alien_type].attributes[self._ID38117]["event_id_start"];
    var_2 = level._ID2829[self.alien_type].attributes[self._ID38117]["event_id_end"];

    if ( var_2 > var_1 )
        var_0 %= ( var_2 - var_1 );
    else
        var_0 = 0;

    return "posture_" + ( var_0 + var_1 );
}

_ID37836()
{
    wait 0.3;
    var_0 = _ID37314();
    maps\mp\alien\_spawn_director::activate_spawn_event( var_0 );
}

_ID38288()
{
    self endon( "death" );
    self endon( "spider_stage_end" );
    self endon( "killanimscript" );
    self endon( "end_posture" );
    var_0 = 0;

    for ( var_1 = 1000; var_0 < var_1 && self.health > level._ID38089; var_0 += var_2 )
        self waittill( "damage",  var_2, var_3  );

    self notify( "end_posture",  1  );
}

_ID38265( var_0 )
{
    self endon( "death" );
    self endon( "spider_stage_end" );
    self endon( "killanimscript" );
    self endon( "end_vulnerable" );
    wait(var_0);
    self notify( "end_vulnerable",  0  );
}

_ID38162()
{
    _ID37783();
}

_ID37783()
{
    level notify( "dlc_vo_notify",  "spider_retreat"  );
    var_0 = common_scripts\utility::_ID15384( "spider_blocker_01", "targetname" );
    var_1 = anglestoforward( var_0.angles );
    maps\mp\agents\alien\alien_spider\_alien_spider::_ID38003( 1.0 );
    self scragentsetphysicsmode( "noclip" );
    maps\mp\agents\alien\_alien_anim_utils::_ID33987( var_1 );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", var_0.angles );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( self._ID37908, self._ID37907, self._ID37908, "end" );
    self._ID37908 = undefined;
    self._ID37907 = undefined;
    self suicide();
}

_ID37155()
{
    maps\mp\agents\alien\alien_spider\_alien_spider_idle::_ID37769( 1 );
    maps\mp\agents\alien\alien_spider\_alien_spider::_ID38003( 1.0 );
    self._ID37109 = 1;
    var_0 = anglestoforward( self._ID37909.angles );
    self scragentsetphysicsmode( "noclip" );
    maps\mp\agents\alien\_alien_anim_utils::_ID33987( var_0 );
    var_1 = self getanimentry( "elevated_retreat", 0 );
    self setplayerangles( self._ID37909.angles );
    self scragentsetorientmode( "face angle abs", self._ID37909.angles );
    thread maps\mp\agents\alien\_alien_melee::_ID32297( var_1, self._ID37909.origin, self._ID37909.angles );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "elevated_retreat", 0, "elevated_retreat", "end" );
    self setorigin( self._ID37156.origin );
    self setplayerangles( self._ID37156.angles );
}

_ID37157()
{
    maps\mp\agents\alien\alien_spider\_alien_spider::_ID38003( 1.0 );
    var_0 = anglestoforward( self._ID37156.angles );
    self scragentsetphysicsmode( "noclip" );
    maps\mp\agents\alien\_alien_anim_utils::_ID33987( var_0 );
    self scragentsetanimmode( "anim deltas" );
    self scragentsetorientmode( "face angle abs", self._ID37156.angles );
    self setplayerangles( self._ID37156.angles );
    self scragentsetorientmode( "face angle abs", self._ID37156.angles );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "elevated_retreat", 1, "elevated_retreat", "end" );
}

_ID38269()
{
    self endon( "killanimscript" );
    thread _ID36974();
    self waittill( "vulnerable" );
    self notify( "egg_interrupted" );
    self notify( "regen_interrupted" );
    self notify( "beam_interrupted" );
    self notify( "projectile_spit_interrupted" );
    _ID37124();
}

_ID37124()
{
    maps\mp\agents\alien\alien_spider\_alien_spider::_ID36658();
    maps\mp\alien\_unk1464::_ID28196( 2.0, 0.0 );
    var_0 = get_random_anim_index( "pain_enter" );
    var_1 = self getanimentry( "pain_enter", var_0 );
    var_2 = getanimlength( var_1 );
    thread downed_enter( var_0 );
    thread _ID38265( 7.0 + var_2 );
    level notify( "dlc_vo_notify",  "spider_vo", "spider_chest"  );
    self waittill( "end_vulnerable",  var_3  );
    maps\mp\agents\alien\alien_spider\_alien_spider::_ID37113();
    maps\mp\alien\_unk1464::_ID28197( 2.0 );

    if ( !var_3 )
        maps\mp\agents\_scriptedagents::_ID23883( "pain_exit", "pain_exit", "end" );
    else
        maps\mp\agents\_scriptedagents::_ID23883( "pain_wounded", "pain_wounded", "end" );

    self._ID38263 = 0;
    self notify( "downed_state_over" );
}

get_random_anim_index( var_0 )
{
    var_1 = self getanimentrycount( var_0 );
    return randomint( var_1 );
}

downed_enter( var_0 )
{
    self endon( "end_vulnerable" );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "pain_enter", var_0, "pain_enter", "end" );
    var_1 = get_random_anim_index( "pain_idle" );
    self setanimstate( "pain_idle", var_1 );
}

_ID36974()
{
    self endon( "downed_state_over" );
    self waittill( "killanimscript" );
    self._ID38263 = 0;
}
