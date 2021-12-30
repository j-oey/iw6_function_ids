// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID33744( var_0 )
{
    self endon( "spawned_player" );
    self endon( "disconnect" );

    if ( !isalive( self ) )
    {
        var_0 delete();
        return;
    }

    if ( self isonladder() || !self isonground() )
    {
        _ID26184( var_0._ID36249 );
        var_0 delete();
        return;
    }

    if ( isdefined( self._ID22850 ) && self._ID22850 )
    {
        var_0 delete();
        self.helisniper thread _ID33737( self );
        return;
    }

    var_0 hide();
    var_1 = self canplayerplacesentry( 1, 12 );

    if ( var_1["result"] && is_normal_upright( anglestoup( var_1["angles"] ) ) )
    {
        var_0.origin = var_1["origin"];
        var_0.angles = var_1["angles"];
    }
    else
    {
        var_0.origin = self.origin;
        var_0.angles = self.angles;
    }

    var_0 show();
    self playlocalsound( "trophy_turret_plant_plr" );
    self playsoundtoteam( "trophy_turret_plant_npc", "allies", self );
    self playsoundtoteam( "trophy_turret_plant_npc", "axis", self );
    var_2 = spawn( "script_model", var_0.origin );
    var_2 setmodel( "mp_trophy_system_iw6" );
    var_2 thread maps\mp\gametypes\_weapons::createbombsquadmodel( "mp_trophy_system_iw6_bombsquad", "tag_origin", self );
    var_2.angles = var_0.angles;
    var_2.team = self.team;
    var_2.owner = self;
    var_2.istallforwaterchecks = 1;

    if ( isdefined( self._ID33743 ) && self._ID33743 > 0 )
        var_2.ammo = self._ID33743;
    else if ( maps\mp\_utility::_ID18363() )
        var_2.ammo = 5;
    else
        var_2.ammo = 2;

    var_3 = 16;
    var_4 = anglestoup( var_2.angles );
    var_4 = var_3 * var_4;
    var_5 = var_2.origin + var_4;
    var_2.trigger = spawn( "script_origin", var_5 );
    var_2.trigger linkto( var_2 );
    var_2 thread _ID33738( self );
    var_2 thread _ID33746();
    var_2 thread _ID33737( self );
    var_2 thread _ID33739( self );
    var_2 thread _ID33742( self );
    var_2 thread _ID33745( self );
    var_2 setotherent( self );
    var_2 maps\mp\gametypes\_weapons::_ID20501( 1 );
    var_2 maps\mp\gametypes\_weapons::explosivehandlemovers( var_1["entity"], 1 );

    if ( level._ID32653 )
        var_2 maps\mp\_entityheadicons::_ID28896( self.team, ( 0, 0, 65 ) );
    else
        var_2 maps\mp\_entityheadicons::_ID28825( self, ( 0, 0, 65 ) );

    maps\mp\gametypes\_weapons::_ID22908( var_2 );
    var_2 thread _ID23875();

    if ( isdefined( var_0 ) )
    {
        common_scripts\utility::_ID35582();
        var_0 delete();
    }

    if ( maps\mp\_utility::_ID18363() )
    {
        self takeweapon( "alientrophy_mp" );
        return;
    }
}

_ID33745( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 endon( "death" );
    self.trigger setcursorhint( "HINT_NOICON" );
    self.trigger sethintstring( &"MP_PICKUP_TROPHY" );
    self.trigger maps\mp\_utility::_ID28863( var_0 );
    self.trigger thread maps\mp\_utility::_ID22330( var_0 );

    for (;;)
    {
        self.trigger waittill( "trigger",  var_0  );
        self stoploopsound();

        if ( maps\mp\_utility::_ID18363() )
        {
            var_1 = var_0 getweaponslistoffhands();
            var_2 = undefined;

            foreach ( var_4 in var_1 )
            {
                if ( var_4 == "alienflare_mp" || var_4 == "alientrophy_mp" || var_4 == "alienthrowingknife_mp" || isdefined( level.trophy_use_pickupfunc ) && [[ level.trophy_use_pickupfunc ]]( var_4 ) )
                {
                    var_5 = var_0 getammocount( var_4 );

                    if ( var_5 > 0 )
                    {
                        var_0 maps\mp\_utility::setlowermessage( "slots_full", &"ALIEN_COLLECTIBLES_TACTICAL_FULL", 3 );
                        var_2 = 1;
                        break;
                    }
                }
            }

            if ( !isdefined( var_2 ) )
            {
                var_0 setoffhandsecondaryclass( "flash" );
                var_0 playlocalsound( "scavenger_pack_pickup" );
                var_0._ID33743 = self.ammo;
                var_0 takeweapon( "alientrophy_mp" );
                var_0 maps\mp\_utility::_giveweapon( "alientrophy_mp" );
                self scriptmodelclearanim();
                maps\mp\gametypes\_weapons::deleteexplosive();
                self notify( "death" );
            }

            continue;
        }

        if ( !var_0 maps\mp\_utility::_ID18666() )
        {
            var_0 _ID26184( "trophy_mp" );
            var_0._ID33743 = self.ammo;
            self scriptmodelclearanim();
            maps\mp\gametypes\_weapons::deleteexplosive();
            self notify( "death" );
        }
    }
}

_ID33742( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    var_0 waittill( "spawned" );
    self notify( "detonateExplosive" );
}

_ID33739( var_0 )
{
    self endon( "death" );
    var_0 waittill( "disconnect" );
    self notify( "detonateExplosive" );
}

_ID33737( var_0 )
{
    var_0 endon( "disconnect" );
    self endon( "death" );

    if ( maps\mp\_utility::_ID18363() && self.model == "mp_weapon_alien_crate" )
        var_1 = self.origin;
    else
        var_1 = self gettagorigin( "camera_jnt" );

    if ( isdefined( self.cameraoffset ) )
        self.cameraoffsetvector = ( 0, 0, self.cameraoffset );
    else
        self.cameraoffsetvector = var_1 - self.origin;

    var_2 = 65536;
    var_3 = 147456;
    self._ID19214 = spawn( "script_model", var_1 + ( 0, 0, 5 ) );
    self._ID19214 linkto( self );

    if ( !isdefined( level.grenades ) )
        level.grenades = [];

    if ( !isdefined( level._ID21199 ) )
        level._ID21199 = [];

    for (;;)
    {
        if ( isdefined( self._ID10146 ) || level.grenades.size < 1 && level._ID21199.size < 1 )
        {
            wait 0.05;
            continue;
        }

        var_4 = common_scripts\utility::array_combine( level.grenades, level._ID21199 );

        foreach ( var_6 in var_4 )
        {
            if ( !isdefined( var_6 ) )
                continue;

            if ( var_6 == self )
                continue;

            if ( isdefined( var_6._ID12495 ) )
                continue;

            if ( isdefined( var_6._ID36249 ) )
            {
                switch ( var_6._ID36249 )
                {
                    case "claymore_mp":
                    case "throwingknife_mp":
                    case "throwingknifejugg_mp":
                    case "trophy_mp":
                    case "airdrop_marker_mp":
                    case "deployable_vest_marker_mp":
                    case "deployable_weapon_crate_marker_mp":
                    case "odin_projectile_large_rod_mp":
                    case "odin_projectile_small_rod_mp":
                    case "odin_projectile_marking_mp":
                    case "odin_projectile_smoke_mp":
                    case "odin_projectile_airdrop_mp":
                        continue;
                }
            }

            if ( !isdefined( var_6.owner ) )
                var_6.owner = getmissileowner( var_6 );

            if ( isdefined( var_6.owner ) && !var_0 maps\mp\_utility::isenemy( var_6.owner ) )
                continue;

            if ( isdefined( self.cameraoffsetvector ) )
                var_1 = self.origin + self.cameraoffsetvector;

            var_7 = distancesquared( var_6.origin, var_1 );
            var_8 = _ID33734( var_6 );

            if ( var_7 < var_8 )
            {
                var_9 = bullettrace( var_1, var_6.origin, 0, self );

                if ( var_9["fraction"] == 1 || isdefined( var_9["entity"] ) && var_9["entity"] == var_6 )
                {
                    playfx( level._ID28095, var_1, var_6.origin - var_1, anglestoup( self.angles ) );
                    self playsound( "trophy_detect_projectile" );

                    if ( _ID33735( var_6 ) )
                    {
                        if ( isdefined( var_6.type ) && var_6.type == "remote" )
                        {
                            level thread maps\mp\gametypes\_missions::_ID19260( var_6.owner, var_0, undefined, var_0, undefined, "MOD_EXPLOSIVE", "trophy_mp" );
                            level thread maps\mp\_utility::_ID32672( "callout_destroyed_predator_missile", var_0 );
                            var_0 thread maps\mp\gametypes\_rank::giverankxp( "kill", 100, "trophy_mp", "MOD_EXPLOSIVE" );
                            var_0 notify( "destroyed_killstreak",  "trophy_mp"  );
                        }

                        if ( isdefined( level._ID7233["explode"]["medium"] ) )
                            playfx( level._ID7233["explode"]["medium"], var_6.origin );

                        if ( isdefined( level._ID4801 ) )
                            var_6 playsound( level._ID4801 );
                    }

                    var_0 thread projectileexplode( var_6, self );
                    var_0 maps\mp\gametypes\_missions::_ID25038( "ch_noboomforyou" );

                    if ( !maps\mp\_utility::_ID18363() )
                        var_0 thread maps\mp\gametypes\_gamelogic::_ID32913( "trophy_mp", 1, "hits" );

                    self.ammo--;

                    if ( self.ammo <= 0 )
                    {
                        var_0._ID33743 = undefined;
                        self notify( "detonateExplosive" );
                    }
                }
            }
        }

        wait 0.05;
    }
}

_ID33735( var_0 )
{
    return isdefined( var_0.classname ) && var_0.classname == "rocket" && ( isdefined( var_0.type ) && ( var_0.type == "remote" || var_0.type == "remote_mortar" ) );
}

_ID33734( var_0 )
{
    if ( isdefined( var_0._ID36249 ) && var_0._ID36249 == "switch_blade_child_mp" )
    {
        return 1048576;
        return;
    }

    if ( _ID33735( var_0 ) )
    {
        return 147456;
        return;
    }

    if ( isdefined( var_0._ID36249 ) && ( var_0._ID36249 == "hind_missile_mp" || var_0._ID36249 == "hind_bomb_mp" ) )
    {
        return 147456;
        return;
    }

    return 65536;
    return;
    return;
    return;
}

projectileexplode( var_0, var_1 )
{
    self endon( "death" );
    var_2 = var_0.origin;
    var_3 = var_0.model;
    var_4 = var_0.angles;
    var_0 stopsounds();
    var_0._ID12495 = 1;

    if ( var_3 == "weapon_light_marker" )
    {
        playfx( level._ID11398, var_2, anglestoforward( var_4 ), anglestoup( var_4 ) );
        var_1 notify( "detonateExplosive" );
        common_scripts\utility::_ID35582();
        var_0 delete();
        return;
    }

    var_1 playsound( "trophy_fire" );
    playfx( level.mine_explode, var_2, anglestoforward( var_4 ), anglestoup( var_4 ) );

    if ( maps\mp\_utility::_ID18363() )
        var_1 radiusdamage( var_2, 128, 105, 10, self, "MOD_EXPLOSIVE", "alientrophy_mp" );
    else
        var_1 radiusdamage( var_2, 128, 105, 10, self, "MOD_EXPLOSIVE", "trophy_mp" );

    common_scripts\utility::_ID35582();

    if ( isdefined( var_0 ) )
    {
        var_0 delete();
        return;
    }
}

_ID33738( var_0 )
{
    maps\mp\gametypes\_damage::_ID21371( 100, "trophy", ::_ID33740, ::_ID33741, 0 );
}

_ID33741( var_0, var_1, var_2, var_3 )
{
    var_4 = var_3;
    var_4 = maps\mp\gametypes\_damage::handlemeleedamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleempdamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleapdamage( var_1, var_2, var_4, var_0 );
    return var_4;
}

_ID33740( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self.owner ) && var_0 != self.owner )
        var_0 notify( "destroyed_equipment" );

    self notify( "detonateExplosive" );
}

_ID33746()
{
    level endon( "game_ended" );
    self waittill( "detonateExplosive" );
    self scriptmodelclearanim();
    self stoploopsound();
    maps\mp\gametypes\_weapons::equipmentdeathvfx();
    self notify( "death" );
    var_0 = self.origin;
    self.trigger makeunusable();
    self freeentitysentient();
    wait 3;

    if ( isdefined( self ) )
    {
        if ( isdefined( self._ID19214 ) )
            self._ID19214 delete();

        maps\mp\gametypes\_weapons::equipmentdeletevfx();
        maps\mp\gametypes\_weapons::deleteexplosive();
        return;
    }
}
#using_animtree("animated_props");

_ID23875()
{
    self endon( "emp_damage" );
    self endon( "death" );
    self scriptmodelplayanim( "trophy_system_deploy" );
    var_0 = getanimlength( %trophy_system_deploy );
    wait(var_0);
    self scriptmodelplayanim( "trophy_system_idle" );
    self playloopsound( "trophy_turret_rotate_lp" );
}

_ID26184( var_0 )
{
    self playlocalsound( "scavenger_pack_pickup" );
    self setweaponammostock( var_0, self getweaponammostock( var_0 ) + 1 );
}

is_normal_upright( var_0 )
{
    var_1 = ( 0, 0, 1 );
    var_2 = 0.85;
    return vectordot( var_0, var_1 ) > var_2;
}
