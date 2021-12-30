// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    _ID37451();
    level.remaining_alien_weapons = 1;
}

_ID37451()
{
    level._ID1644["corrosive_blast"] = loadfx( "vfx/gameplay/mp/equipment/vfx_alien_dome_ns_gun_gas" );
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

        if ( var_0 == "venomxgun_mp" )
        {
            var_2 = self getweaponammoclip( "venomxgun_mp" );

            if ( var_2 == 0 )
                thread remove_alien_weapon( var_1 );

            var_1.health = 9999999;
            var_1 thread maps\mp\gametypes\_weapons::createbombsquadmodel( "weapon_semtex_grenade_iw6_bombsquad", "tag_origin", self );
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
    self endon( "alien_weapon_removed" );
    var_0 = 2;

    while ( !isdefined( self.no_more_detonate_hint ) )
    {
        self waittill( "grenade_fire",  var_1, var_2  );

        if ( var_2 == "venomxgun_mp" )
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
    level endon( "game_ended" );
    var_0 endon( "death" );
    self.adspressed = 0;
    thread ads_watcher();
    thread toggle_ads_watcher();
    var_2 = 100;
    var_3 = 0;
    var_4 = ( 0, 0, 0 );
    thread projectile_safety( var_0 );

    while ( self adsbuttonpressed() && var_3 < var_2 )
    {
        wait 0.05;
        var_3 += 1;
    }

    while ( var_3 < var_2 )
    {
        if ( isdefined( var_0 ) && self.adspressed && self getcurrentweapon() == "venomxgun_mp" && maps\mp\_utility::_ID18757( self ) )
        {
            var_0 notify( "projectile_detonate" );
            var_0 notify( "trap_death" );
            self.no_more_detonate_hint = 1;
            return;
        }
        else if ( !isdefined( var_0 ) )
        {
            thread cloud_monitor( self, var_4, var_1 );
            playsoundatpos( var_4, "aliendlc11_explode" );
            return;
        }

        var_4 = var_0.origin;
        wait 0.05;
        var_3 += 1;
    }

    var_0 notify( "projectile_detonate" );
    var_0 notify( "trap_death" );
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

projectile_safety( var_0 )
{
    var_0 endon( "projectile_detonate" );
    common_scripts\utility::_ID35626( "death", "disconnect" );
    wait 1;
    var_0 notify( "trap_death" );
    var_0 notify( "projectile_detonate" );
}

_ID37187( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 notify( "trap_death" );
    var_2 = 6;
    var_0 waittill( "projectile_detonate" );

    if ( isdefined( var_0 ) )
    {
        var_0 thread cloud_monitor( self, var_0.origin, var_1 );
        playsoundatpos( var_0.origin, "aliendlc11_explode" );
        var_0 hide();
        wait(var_2);
        var_0 delete();
    }
}

cloud_monitor( var_0, var_1, var_2 )
{
    var_3 = undefined;
    var_4 = 200;
    var_5 = 150;
    var_6 = 15;
    var_7 = 5;
    var_8 = 5;
    var_9 = 1;
    var_10 = 256;
    var_11 = 300;
    var_12 = 350;
    var_13 = var_0.team;
    var_3 = spawnfx( level._ID1644["corrosive_blast"], var_1 );
    var_14 = var_1 - ( 0, 0, var_5 );
    var_15 = var_5 + var_5;
    var_16 = spawn( "trigger_radius", var_14, 1, var_4, var_15 );
    var_16.owner = var_0;
    self radiusdamage( var_1, var_10, var_12, var_11, var_0, "MOD_EXPLOSIVE", var_2 );
    earthquake( 0.5, 1, var_1, 512 );
    playrumbleonposition( "grenade_rumble", var_1 );
    triggerfx( var_3 );
    var_17 = 0.0;
    var_18 = 1;
    var_19 = 0;
    wait(var_18);

    for ( var_17 += var_18; var_17 < var_7; var_17 += var_9 )
    {
        var_20 = [];
        var_21 = common_scripts\utility::array_combine( level.players, level.agentarray );

        foreach ( var_23 in var_21 )
        {
            if ( isdefined( var_23 ) && isalive( var_23 ) && var_23 istouching( var_16 ) )
                var_20[var_20.size] = var_23;
        }

        foreach ( var_23 in var_20 )
        {
            if ( !isdefined( var_0 ) )
            {
                if ( isdefined( var_23 ) && maps\mp\_utility::_ID18757( var_23 ) && var_23.team != var_13 )
                    var_23 thread cloud_do_damage( var_6, undefined, var_8, var_16, var_9, var_2, self, var_13 );
            }
            else if ( isdefined( var_23 ) && maps\mp\_utility::_ID18757( var_23 ) && ( var_23.team != var_13 || var_23 == var_0 ) )
                var_23 thread cloud_do_damage( var_6, var_0, var_8, var_16, var_9, var_2, self, var_13 );

            common_scripts\utility::_ID35582();
        }

        wait(var_9);
    }

    var_16 delete();
    var_3 delete();
}

cloud_do_damage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    self notify( "stasis_cloud_burning" );
    self endon( "stasis_cloud_burning" );
    self endon( "death" );

    if ( isdefined( var_1 ) )
        var_1 endon( "disconnect" );

    if ( !isdefined( var_2 ) )
        var_2 = 6;

    var_8 = 0;

    while ( var_8 < var_2 )
    {
        if ( self.team != var_7 )
        {
            if ( isdefined( var_3 ) )
            {
                if ( isbot( self ) )
                    var_6 radiusdamage( self.origin, 10, var_0, var_0, var_1, "MOD_PROJECTILE_SPLASH", var_5 );
                else
                    maps\mp\gametypes\_damage::_ID12959( var_3, var_1, var_0, 0, "MOD_PROJECTILE_SPLASH", var_5, self.origin, ( 0, 0, 1 ), "none", 0, 0 );
            }
        }
        else if ( self == var_1 && isdefined( var_3 ) )
            var_3 radiusdamage( self.origin, 10, var_0, var_0, var_1, "MOD_PROJECTILE_SPLASH", var_5 );

        var_8 += var_4;
        wait(var_4);
    }
}

give_alien_weapon( var_0 )
{
    if ( "iw6_maaws_mp" == self getcurrentweapon() || maps\mp\_utility::_ID18666() )
        return;

    if ( isbot( self ) )
        maps\mp\killstreaks\_deployablebox_gun::giverandomgun( self );
    else
    {
        if ( !self hasweapon( "venomxgun_mp" ) )
        {
            if ( !isdefined( var_0 ) || !var_0 )
                level.remaining_alien_weapons--;

            thread _ID38078();
            self giveweapon( "venomxgun_mp" );
            self setweaponammoclip( "venomxgun_mp", 10 );
            self switchtoweapon( "venomxgun_mp" );
            thread manage_alien_weapon_inventory();
            thread _ID38032();
            return;
        }

        self iprintlnbold( &"MP_DOME_NS_ALREADY_HAVE_ALIEN_GUN" );
    }
}

manage_alien_weapon_inventory()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "alien_weapon_removed" );

    for (;;)
    {
        if ( self getcurrentweapon() == "venomxgun_mp" )
            self disableweaponpickup();
        else
            self enableweaponpickup();

        wait 0.1;
    }
}

remove_alien_weapon( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    var_0 common_scripts\utility::_ID35626( "death", "projectile_detonate" );
    self switchtoweapon( self._ID24978 );
    self takeweapon( "venomxgun_mp" );
    self notify( "alien_weapon_removed" );
    self enableweaponpickup();
}

_ID38032()
{
    self endon( "disconnect" );
    self endon( "death" );
    wait 1;
    maps\mp\_utility::setlowermessage( "weapon_hint", &"MP_DOME_NS_ALIEN_GUN_HINT", 6 );
}

show_specialweapon_hint_repeat()
{
    self endon( "disconnect" );
    wait 1;
    self iprintlnbold( &"MP_DOME_NS_ALIEN_GUN_HINT" );
}
