// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    _ID37451();
    level._ID37271 = ::_ID36739;
    level thread _ID38033();
}

_ID37451()
{
    level._ID1644["corrosive_blast"] = loadfx( "vfx/gameplay/alien/vfx_alien_arm_gun_gas" );
}

_ID38078()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self notify( "gun_watcher_logic" );
    self endon( "gun_watcher_logic" );
    self notifyonplayercommand( "detonate_venom", "+toggleads_throw" );
    self notifyonplayercommand( "detonate_venom", "+ads_akimbo_accessible" );
    thread special_gun_detonate_hint_watcher();
    var_0 = "none";
    var_1 = undefined;

    for (;;)
    {
        self waittill( "grenade_fire",  var_1, var_0  );

        if ( var_0 == "iw6_aliendlc11_mp" )
        {
            var_1.health = 1;
            thread _ID38268( var_1, var_0 );
            thread _ID37187( var_1, var_0 );
        }

        wait 0.05;
    }
}

special_gun_detonate_hint_watcher()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "gun_watcher_logic" );
    var_0 = 2;

    while ( !isdefined( self.no_more_detonate_hint ) )
    {
        self waittill( "grenade_fire",  var_1, var_2  );

        if ( var_2 == "iw6_aliendlc11_mp" )
        {
            if ( !isdefined( self.projectile_time_out_num ) )
                self.projectile_time_out_num = 1;
            else if ( self.projectile_time_out_num > var_0 )
            {
                var_0 = 3;
                self.projectile_time_out_num = 0;
                thread show_specialweapon_hint_repeat();
            }
            else
                self.projectile_time_out_num++;
        }

        wait 0.1;
    }
}

_ID38268( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "detonated" );
    level endon( "game_ended" );
    self.adspressed = 0;
    thread ads_watcher();
    thread toggle_ads_watcher();
    var_2 = 100;
    var_3 = 0;
    var_4 = ( 0, 0, 0 );

    for ( var_5 = var_4; self adsbuttonpressed() && var_3 < var_2; var_3 += 1 )
        wait 0.05;

    while ( var_3 < var_2 )
    {
        if ( isdefined( var_0 ) && self.adspressed )
        {
            self notify( "projectile_detonate" );
            self.no_more_detonate_hint = 1;
            return;
        }
        else if ( !isdefined( var_0 ) )
        {
            thread _ID36982( self, var_5, var_1 );
            playsoundatpos( var_5, "aliendlc11_explode" );
            return;
        }

        var_4 = var_0.origin;
        var_5 = var_4;
        wait 0.05;
        var_3 += 1;
    }

    self notify( "projectile_detonate" );
}

toggle_ads_watcher()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "projectile_detonate" );
    self endon( "ads_pressed" );
    self waittill( "detonate_venom" );
    self.adspressed = 1;
    self notify( "ads_pressed" );
}

ads_watcher()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "projectile_detonate" );
    self endon( "ads_pressed" );

    for (;;)
    {
        if ( self adsbuttonpressed() )
        {
            self.adspressed = 1;
            self notify( "ads_pressed" );
        }

        wait 0.05;
    }
}

_ID37187( var_0, var_1 )
{
    self waittill( "projectile_detonate" );

    if ( isdefined( var_0 ) )
    {
        level thread _ID36982( self, var_0.origin, var_1 );
        playsoundatpos( var_0.origin, "aliendlc11_explode" );
        var_0 delete();
    }
}

_ID36982( var_0, var_1, var_2 )
{
    var_3 = undefined;
    var_4 = 200;
    var_5 = 150;
    var_6 = 250;
    var_7 = 5;
    var_8 = 5;
    var_9 = 0.5;
    var_10 = 200;
    var_11 = 1000;
    var_12 = 1500;

    switch ( var_2 )
    {
        case "iw6_aliendlc11_mp":
            var_3 = spawnfx( level._ID1644["corrosive_blast"], var_1 );
            var_4 = 200;
            var_5 = 150;
            var_6 = 250;
            var_7 = 5;
            var_8 = 5;
            break;
    }

    var_13 = var_1 - ( 0, 0, var_5 );
    var_14 = var_5 + var_5;
    var_15 = spawn( "trigger_radius", var_13, 1, var_4, var_14 );
    var_15.owner = var_0;
    radiusdamage( var_1, var_10, var_12, var_11, var_0, "MOD_EXPLOSIVE" );
    earthquake( 0.5, 1, var_1, 512 );
    playrumbleonposition( "grenade_rumble", var_1 );
    triggerfx( var_3 );

    if ( var_2 == "iw6_aliendlc11_mp" )
        var_16 = missile_createattractorent( var_15, 20000, 8000 );

    var_17 = 0.0;
    var_18 = 0.25;
    var_19 = 1;
    var_20 = 0;
    wait(var_19);

    for ( var_17 += var_19; var_17 < var_7; var_17 += var_18 )
    {
        var_21 = [];

        foreach ( var_23 in level.agentarray )
        {
            if ( isdefined( var_23 ) && isalive( var_23 ) && var_23 istouching( var_15 ) && !isdefined( var_23._ID37683 ) )
                var_21[var_21.size] = var_23;
        }

        foreach ( var_23 in var_21 )
        {
            if ( isdefined( var_23 ) && isalive( var_23 ) )
            {
                var_23 thread _ID36981( var_6, var_0, var_8, var_15, var_9, var_2 );
                common_scripts\utility::_ID35582();
            }
        }

        wait(var_18);
    }

    var_15 delete();
    var_3 delete();
}

_ID36687()
{
    if ( !isdefined( self._ID37525 ) )
        self._ID37525 = 0;

    self._ID37525++;

    if ( self._ID37525 == 1 )
        self setscriptablepartstate( "body", "corrosive" );
}

_ID36686()
{
    self._ID37525--;

    if ( self._ID37525 > 0 )
        return;

    self._ID37525 = undefined;
    self notify( "corrosive_off" );
    self setscriptablepartstate( "body", "normal" );
}

_ID36981( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self notify( "stasis_cloud_burning" );
    self endon( "stasis_cloud_burning" );
    self endon( "death" );

    if ( !isdefined( var_2 ) )
        var_2 = 6;

    self._ID37683 = 1;

    if ( !isdefined( level._ID38082 ) || isdefined( level._ID38082 ) && self != level._ID38082 )
        _ID36687();

    var_6 = 0;

    while ( var_6 < var_2 )
    {
        if ( isdefined( var_3 ) )
            self dodamage( var_0, self.origin, var_1, var_1, "MOD_UNKNOWN" );
        else
            self dodamage( var_0, self.origin, var_1 );

        var_6 += var_4;
        wait(var_4);
    }

    if ( !isdefined( level._ID38082 ) || isdefined( level._ID38082 ) && self != level._ID38082 )
        _ID36686();

    self._ID37683 = undefined;
}

_ID37377()
{
    self makeusable();
    self sethintstring( &"MP_ALIEN_ARMORY_SPECIAL_WEAPON_PICKUP" );
    maps\mp\alien\_outline_proto::add_to_outline_weapon_watch_list( self, 0 );

    for (;;)
    {
        self waittill( "trigger",  var_0  );

        if ( var_0.has_special_weapon || var_0._ID18431 )
        {
            var_0 maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HOLDING", 3 );
            continue;
        }

        if ( !var_0 hasweapon( "iw6_aliendlc11_mp" ) )
        {
            if ( var_0 maps\mp\alien\_prestige::prestige_getpistolsonly() == 1 )
            {
                var_0 maps\mp\_utility::setlowermessage( "cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_NERFED", 3 );
                continue;
            }

            var_0 giveweapon( "iw6_aliendlc11_mp" );
            var_1 = 2;

            if ( var_0 maps\mp\alien\_prestige::prestige_getminammo() != 1 )
                var_1 = 1;

            var_0 setweaponammoclip( "iw6_aliendlc11_mp", var_1 );
            var_0 setweaponammostock( "iw6_aliendlc11_mp", var_1 );
            var_0 switchtoweapon( "iw6_aliendlc11_mp" );
            var_0 thread _ID38032();
            level notify( "scorpion_gun_pickedup" );
            var_0 maps\mp\alien\_unk1464::_ID36645();
            var_0 thread _ID37111();
            var_0._ID36646 = 1;
        }
    }
}

_ID37111()
{
    var_0 = getentarray( "anti_alien_gun", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 disableplayeruse( self );
}

_ID38032()
{
    self endon( "disconnect" );
    wait 1;
    maps\mp\_utility::setlowermessage( "weapon_hint", &"MP_ALIEN_ARMORY_SPECIAL_WEAPON_HINT", 6 );
}

show_specialweapon_hint_repeat()
{
    self endon( "disconnect" );
    wait 1;
    self iprintlnbold( &"MP_ALIEN_ARMORY_SPECIAL_WEAPON_HINT" );
}

_ID38033()
{
    level waittill( "scorpion_gun_pickedup" );
    level thread _ID38108();
}

_ID38108()
{
    var_0 = 25;
    var_1 = 45;
    level._ID38105 = 0;
    level endon( "game_ended" );
    var_2 = gettime() + var_0 * 1000;
    var_3 = gettime() + var_1 * 1000;

    for (;;)
    {
        level waittill( "alien_killed",  var_4  );
        var_5 = gettime();
        var_6 = 0;

        if ( var_5 > var_2 && level._ID38105 < 4 )
        {
            if ( gettime() < var_3 )
            {
                if ( randomintrange( 0, 100 ) > 92 )
                    var_6 = 1;
            }
            else
                var_6 = 1;
        }

        if ( var_6 && isdefined( var_4 ) )
        {
            var_2 = gettime() + var_0 * 1000;
            var_3 = gettime() + var_1 * 1000;
            level thread _ID38107( var_4 );
        }

        wait 0.05;
    }
}

_ID38107( var_0 )
{
    var_1 = getgroundposition( var_0 + ( 0, 0, 10 ), 16 );
    var_2 = spawn( "script_model", var_1 );
    var_2 setmodel( "alien_spider_egg_ammo" );
    wait 1;
    playfxontag( level._ID1644["spitter_ammo"], var_2, "j_egg_center" );
    var_2 thread _ID38110();
    var_2 thread _ID38109();
    level._ID38105++;
}

_ID38110()
{
    level endon( "game_ended" );
    self endon( "death" );
    var_0 = 30;
    self makeusable();
    self sethintstring( &"MP_ALIEN_ARMORY_SPITTER_AMMO_PICKUP" );
    thread _ID38106( var_0 );

    for (;;)
    {
        self waittill( "trigger",  var_1  );

        if ( var_1 hasweapon( "iw6_aliendlc11_mp" ) )
        {
            var_2 = var_1 getweaponammoclip( "iw6_aliendlc11_mp" );
            var_3 = var_1 getweaponammostock( "iw6_aliendlc11_mp" );

            if ( var_2 + var_3 >= weaponmaxammo( "iw6_aliendlc11_mp" ) + weaponclipsize( "iw6_aliendlc11_mp" ) )
            {
                var_1 maps\mp\_utility::setlowermessage( "ammo_taken", &"ALIEN_COLLECTIBLES_AMMO_MAX", 3 );
                continue;
            }

            var_4 = 2;

            if ( var_1 maps\mp\alien\_prestige::prestige_getminammo() != 1 )
                var_4 = 1;

            var_1 setweaponammoclip( "iw6_aliendlc11_mp", var_2 + var_4 );
            var_1 setweaponammostock( "iw6_aliendlc11_mp", var_3 + var_4 );
            var_1 playsound( "extinction_item_pickup" );
            playfx( level._ID1644["alien_teleport"], self.origin );
            level._ID38105--;
            self delete();
            return;
        }
    }
}

_ID38109()
{
    self endon( "death" );

    for (;;)
    {
        self rotateyaw( 360, 5 );
        wait 5;
    }
}

_ID38106( var_0 )
{
    self endon( "death" );
    wait(var_0);
    level._ID38105--;
    self delete();
}

_ID36739( var_0 )
{
    if ( isdefined( var_0.targetname ) && var_0.targetname == "anti_alien_gun" )
        return isdefined( self._ID36646 );

    return 0;
}
