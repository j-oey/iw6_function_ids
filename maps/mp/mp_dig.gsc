// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_dig_precache::_ID20445();
    maps\createart\mp_dig_art::_ID20445();
    maps\mp\mp_dig_fx::_ID20445();
    level._ID20636 = ::digcustomcratefunc;
    level.mapcustomkillstreakfunc = ::digcustomkillstreakfunc;
    level._ID20635 = ::digcustombotkillstreakfunc;
    level.allow_level_killstreak = 1;
    level.custom_death_sound = ::playcustomdeathsound;
    level.nukedeathvisionfunc = ::nukedeathvision;
    maps\mp\_load::_ID20445();
    maps\mp\_compass::_ID29184( "compass_map_mp_dig" );
    maps\mp\_utility::_ID28710( "r_specularColorScale", 2.5, 5 );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_outfit"] = "urban";
    game["axis_outfit"] = "woodland";
    var_0 = [];
    var_1 = 1;

    if ( level._ID14086 == "horde" || level._ID14086 == "infect" )
        var_1 = 0;

    if ( level._ID14086 == "gun" || level._ID14086 == "sotf" || level._ID14086 == "sotf_ffa" || maps\mp\_utility::isanymlgmatch() )
        var_0[var_0.size] = "treasure_event";

    setupevents( var_1, var_0 );
    setupshrineperks();
    thread _ID36620::_ID37998( "alienEasterEgg" );
    thread nuke_custom_visionset();
}

precacheitems()
{
    level._ID6083["scarabpot"]["break"] = loadfx( "vfx/moments/mp_dig/vfx_kstr_urnbreak_01" );
    level._ID6083["scarabpot"]["break_top"] = loadfx( "vfx/moments/mp_dig/vfx_pot_smk_wispy_damage" );
    level._ID6083["scarabpot"]["break_scarabs"] = loadfx( "vfx/moments/mp_dig/vfx_scarab_pot_explosion_r" );
    level._ID6083["scarab"]["player"] = loadfx( "vfx/moments/mp_dig/vfx_scarab_on_player_r" );
    level._ID6083["scarab"]["ground"] = loadfx( "vfx/moments/mp_dig/vfx_scarab_walk_up_r" );
    level._ID6083["scarab"]["screen"] = loadfx( "vfx/moments/mp_dig/vfx_scarab_screen_r" );
    level._ID6083["scarab"]["flyers"] = loadfx( "vfx/moments/mp_dig/vfx_scarab_groupwflyers" );
    level.dig_fx["torch"]["fire"] = loadfx( "vfx/moments/mp_dig/vfx_torch_fire_03" );
    level.dig_fx["torch"]["sand"] = loadfx( "vfx/moments/mp_dig/vfx_falling_sand_torch" );
    level.dig_fx["shrine"]["player"] = loadfx( "vfx/moments/mp_dig/vfx_kstr_loadedguy" );
    level.dig_fx["shrine"]["screen"] = loadfx( "vfx/moments/mp_dig/vfx_kstr_loadedguy_scr" );
    level.dig_fx["scarab"]["deathAnim"] = loadfx( "vfx/moments/mp_dig/vfx_scarab_death_r" );
    level.dig_fx["flametrap"]["player"] = loadfx( "vfx/moments/mp_dig/vfx_kstr_manflame" );
    level.dig_fx["flametrap"]["screen"] = loadfx( "vfx/moments/mp_dig/vfx_kstr_fireroom_scr" );
    level.dig_fx["flametrap"]["room"] = loadfx( "vfx/moments/mp_dig/vfx_kstr_flameroom_flame" );
}

setupevents( var_0, var_1 )
{
    precacheitems();

    if ( var_0 )
    {
        var_2 = 1;
        var_3 = 1;
        var_4 = 1;
        var_5 = 1;
        var_6 = 1;

        if ( isdefined( var_1 ) && var_1.size > 0 )
        {
            foreach ( var_8 in var_1 )
            {
                switch ( var_8 )
                {
                    case "obelisk_event":
                        var_2 = 0;
                        continue;
                    case "scarabs_event":
                        var_3 = 0;
                        continue;
                    case "treasure_event":
                        var_4 = 0;
                        continue;
                    case "snakes_event":
                        var_5 = 0;
                        continue;
                    case "shrine_event":
                        var_6 = 0;
                        continue;
                }
            }
        }

        if ( var_2 )
            level thread setupobelisk();

        if ( var_3 )
        {
            level.digscarabpots = [];
            level.digscarabpots = common_scripts\utility::_ID15386( "scarab_pot", "targetname" );

            foreach ( var_11 in level.digscarabpots )
                level thread setupscarabpot( var_11.origin );
        }

        if ( var_4 )
        {
            level thread setupradio();
            setuptreasureroom();
        }

        if ( var_5 )
        {
            var_13 = ( -362, 1982, 733 );
            level thread setupsnakes( var_13 );
        }

        if ( !var_6 )
        {
            level.allow_level_killstreak = 0;
            return;
        }

        return;
    }

    level thread setupobelisk( 1 );
    return;
}

getdomflagb()
{
    var_0 = getentarray( "flag_primary", "targetname" );
    var_1 = undefined;

    foreach ( var_3 in var_0 )
    {
        if ( var_3._ID27658 == "_b" )
        {
            var_1 = var_3;
            break;
        }
    }

    return var_1;
}

updatebflagpos( var_0 )
{
    level endon( "game_ended" );
    var_1 = getdomflagb();

    if ( !isdefined( level.dig_old_bflagpos ) )
        level.dig_old_bflagpos = var_1.origin;

    var_2 = common_scripts\utility::_ID15384( "flag_b_after", "targetname" );
    var_3 = vectortoangles( ( 0, 0, 1 ) );
    var_4 = var_2.origin;

    if ( isdefined( var_0 ) && var_0 )
    {
        var_4 = level.dig_old_bflagpos;
        var_5 = var_4 + ( 0, 0, 32 );
        var_6 = var_4 + ( 0, 0, -32 );
        var_7 = bullettrace( var_5, var_6, 0, undefined );
        var_3 = vectortoangles( var_7["normal"] );
    }

    var_1.origin = var_4;
    var_1._ID34757.curorigin = var_4;
    var_1._ID34757._ID35361[0].origin = var_4;
    var_1._ID34757.baseeffectpos = var_4;
    var_1._ID34757.baseeffectforward = anglestoforward( var_3 );

    if ( isdefined( var_1._ID34757.neutralflagfx ) )
        var_1._ID34757 maps\mp\gametypes\dom::_ID24581();

    foreach ( var_9 in level.players )
    {
        if ( isdefined( var_9._domflageffect ) && isdefined( var_9._domflageffect["_b"] ) )
            var_1._ID34757 maps\mp\gametypes\dom::showcapturedbaseeffecttoplayer( var_1._ID34757._ID23192, var_9 );
    }
}

updatebflagobjicon()
{
    var_0 = getdomflagb();
    var_1 = common_scripts\utility::_ID30774();
    var_1 show();
    var_1.origin = var_0.origin + ( 0, 0, 100 );
    var_1 linkto( var_0 );
    var_0._ID34757.objiconent = var_1;
    var_0._ID34757 maps\mp\gametypes\_gameobjects::updateworldicons();
}

setupobelisk( var_0 )
{
    level endon( "game_ended" );
    level.obeliskbefore = getent( "obelisk_before", "targetname" );
    level.obeliskanimated = getent( "obelisk_anim", "targetname" );
    level.obeliskanimated2 = getent( "obelisk_anim_2", "targetname" );
    level.obeliskafter = getent( "obelisk_after", "targetname" );
    level.obeliskfloor = getent( "obelisk_floor", "targetname" );
    level.obeliskbeforeclip = getent( "obelisk_before_clip", "targetname" );
    level.obeliskafterclip = getent( "obelisk_after_clip", "targetname" );
    level.obeliskpathblocker = getent( "obelisk_path_blocker", "targetname" );
    level.obeliskpathholder = getent( "obelisk_path_holder", "targetname" );
    level.obeliskdamage = getent( "obelisk_damage_trigger", "targetname" );
    level.obeliskkilltrigger_ground = getent( "obelisk_kill_trigger", "targetname" );
    level.obeliskkilltrigger_air = getent( "obelisk_kill_trigger_2", "targetname" );

    if ( isdefined( level.obeliskanimated ) )
        hideent( level.obeliskanimated );

    if ( isdefined( level.obeliskanimated2 ) )
        hideent( level.obeliskanimated2 );

    if ( isdefined( level.obeliskfloor ) )
        hideent( level.obeliskfloor );

    if ( isdefined( level.obeliskafter ) )
        hideent( level.obeliskafter );

    if ( isdefined( level.obeliskafterclip ) )
    {
        if ( !isdefined( level.obeliskafterclip._ID19214 ) )
        {
            level.obeliskafterclip._ID19214 = spawn( "script_model", level.obeliskafterclip.origin + ( 400, -800, 400 ) );
            level.obeliskafterclip._ID19214 setmodel( "tag_origin" );
        }

        hideent( level.obeliskafterclip );
    }

    if ( isdefined( level.obeliskpathholder ) )
        hideent( level.obeliskpathholder );

    if ( isdefined( level.obeliskpathblocker ) )
    {
        showent( level.obeliskpathblocker );
        level.obeliskpathblocker disconnectpaths();
        level thread delayhide( level.obeliskpathblocker, 0.05 );
    }

    if ( isdefined( level.obeliskkilltrigger_ground ) )
    {
        level.obeliskkilltrigger_ground.dmg = 0;
        level.obeliskkilltrigger_ground thread killall( "obelisk_impact", 5000, "MOD_CRUSH" );
        level.obeliskkilltrigger_ground common_scripts\utility::_ID33657();
    }

    if ( isdefined( level.obeliskkilltrigger_air ) )
    {
        level.obeliskkilltrigger_air.dmg = 0;
        level.obeliskkilltrigger_air common_scripts\utility::_ID33657();
    }

    if ( isdefined( level.obeliskbefore ) )
        showent( level.obeliskbefore );

    if ( isdefined( level.obeliskbeforeclip ) )
        showent( level.obeliskbeforeclip );

    level.obeliskfallen = 0;

    if ( !isdefined( var_0 ) || !var_0 )
    {
        level childthread watchobeliskactivation();

        if ( isdefined( level.obeliskdamage ) )
        {
            level.obeliskdamage waittill( "trigger",  var_1  );
            level.obeliskowner = var_1;
            level notify( "obelisk_activated" );
            return;
        }

        return;
    }
}

watchobeliskactivation()
{
    level waittill( "obelisk_activated" );
    hideent( level.obeliskbefore );
    hideent( level.obeliskbeforeclip );
    level thread delayexploder( 0.24, 10 );
    level thread delayexploder( 0.9, 11 );
    level thread delayexploder( 1.5, 12 );
    level thread delayexploder( 1.7, 13 );
    level thread delayexploder( 1.8, 14 );
    level thread delayexploder( 2.1, 15 );
    level thread delayexploder( 2.25, 16 );
    level thread delayexploder( 2.9, 20 );
    level thread delayexploder( 2.95, 21 );
    level thread delayexploder( 3, 22 );
    showent( level.obeliskanimated );
    showent( level.obeliskanimated2 );
    level.obeliskanimated scriptmodelplayanimdeltamotion( "mp_dig_obelisk_dest_anim_01" );
    level.obeliskanimated2 scriptmodelplayanimdeltamotion( "mp_dig_obelisk_dest_anim_02" );
    level.obeliskkilltrigger_air thread delaytrigger( 1, "on" );
    level.obeliskkilltrigger_air thread delaytrigger( 2, "off" );
    level thread obeliskimpact();
    level thread obelisksounds();
    wait 7;
    hideent( level.obeliskanimated );
    hideent( level.obeliskanimated2 );
    showent( level.obeliskafter );
    level.obeliskfallen = 1;
}

resetobelisk()
{
    for (;;)
    {
        level waittill( "obelisk_reset" );

        if ( level.obeliskfallen )
        {
            level.obeliskafterclip connectpaths();

            if ( level._ID14086 == "dom" || level._ID14086 == "siege" )
            {
                updatebflagpos( 1 );
                updatebflagobjicon();
            }

            level thread setupobelisk();
        }
    }
}

obelisksounds()
{
    level endon( "game_ended" );
    var_0 = ( 0, 0, -300 );
    var_1 = ( 0, 0, 0 );
    var_2 = ( 0, 0, 400 );
    level.obelisksoundbaseobj = spawn( "script_model", level.obeliskanimated.origin + var_0 );
    level.obelisksoundmidobj = spawn( "script_model", level.obeliskanimated.origin + var_1 );
    level.obelisksoundtopobj = spawn( "script_model", level.obeliskanimated.origin + var_2 );
    level.obelisksoundbaseobj setmodel( "tag_origin" );
    level.obelisksoundmidobj setmodel( "tag_origin" );
    level.obelisksoundtopobj setmodel( "tag_origin" );
    level.obelisksoundmidobj linkto( level.obeliskanimated, "tag_mp_dig_obelisk_dyn_08" );
    level.obelisksoundtopobj linkto( level.obeliskanimated, "tag_mp_dig_obelisk_dyn_04" );
    common_scripts\utility::_ID35582();
    level.obelisksoundbaseobj playsound( "mp_dig_obelisk_fall_base" );
    level.obelisksoundmidobj playsoundonmovingent( "mp_dig_obelisk_fall_mid" );
    level.obelisksoundtopobj playsoundonmovingent( "mp_dig_obelisk_fall_top" );
}

obeliskimpact()
{
    level endon( "game_ended" );
    var_0 = ( -1140, -108, 712 );
    wait 3.1;
    earthquake( 0.4, 3, var_0, 2000 );
    showent( level.obeliskafterclip );
    level.obeliskafterclip disconnectpaths();
    showent( level.obeliskpathblocker );
    level.obeliskpathblocker connectpaths();
    level thread delayhide( level.obeliskpathblocker, 0.05 );

    if ( level._ID14086 == "dom" || level._ID14086 == "siege" )
    {
        updatebflagpos();
        updatebflagobjicon();
    }

    level notify( "obelisk_impact" );
}

setupscarabpot( var_0 )
{
    level endon( "game_ended" );
    var_1 = spawn( "script_model", var_0 );
    var_1 setmodel( "dig_pottery_06" );
    var_1.origin = var_0;
    var_1.health = 300;
    var_1.damagetaken = 0;
    var_1._ID17381 = "mp_dig_scarab_pot_rattle";
    var_1.lidsound = "mp_dig_scarab_pot_hit_lid";
    var_1.smokesound = "mp_dig_scarab_pot_smoke_lp";
    var_1.breaksound = "mp_dig_scarab_pot_explode";
    var_1.hasscarabs = 1;
    var_1.broken = 0;
    var_1 setcandamage( 1 );
    var_1 solid( 1 );
    var_1 thread playpotrattle();
    var_2 = spawn( "script_model", var_0 + ( 0, 0, 33 ) );
    var_2 setmodel( "dig_pottery_06_lid" );

    for (;;)
    {
        var_1 waittill( "damage",  var_3, var_4, var_5, var_6, var_7  );
        var_1.damagetype = var_7;
        var_1._ID8979 = var_4;
        var_1.damagetaken = var_1.damagetaken + var_3;

        if ( var_1.damagetaken == var_3 )
            var_1 thread startpotbreaking( var_2 );
    }
}

resetscarabpot( var_0, var_1 )
{
    for (;;)
    {
        level waittill( "scarab_pot_reset" );

        if ( !isdefined( var_0 ) )
            setupscarabpot( var_1 );
    }
}

playpotrattle()
{
    self endon( "pot_lid_broken" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( isdefined( self ) )
            self playsound( self._ID17381 );

        maps\mp\gametypes\_hostmigration::_ID35597( randomintrange( 8, 15 ) );
    }
}

startpotbreaking( var_0 )
{
    var_1 = 0;
    var_2 = 0;
    var_3 = anglestoup( self.angles );
    var_4 = anglestoup( ( 0, 90, 0 ) );
    var_5 = vectordot( var_3, var_4 );
    var_6 = ( 0, 0, 0 );
    var_7 = ( 0, 0, 32 );

    if ( var_5 < 0.5 )
    {
        var_6 = var_3 * 22 - ( 0, 0, 30 );
        var_7 = var_3 * 22 + ( 0, 0, 14 );
    }

    if ( self.damagetype != "MOD_GRENADE_SPLASH" && self.damagetype != "MOD_GRENADE" )
    {
        while ( self.damagetaken < self.health )
        {
            if ( !var_2 )
            {
                var_0 hide();
                self playsound( self.lidsound );
                self notify( "pot_lid_broken" );
                thread playpotfx( var_7 );
                self playloopsound( self.smokesound );
                var_2 = 1;
            }

            if ( var_1 > 20 )
                var_1 = 0;

            if ( var_1 == 0 )
                self.damagetaken = self.damagetaken + ( 10 + randomfloat( 10 ) );

            var_1++;
            wait 0.05;
        }
    }

    breakpot( var_0 );
}

playpotfx( var_0 )
{
    level endon( "game_ended" );

    while ( isdefined( self ) && !self.broken )
    {
        playfx( level._ID6083["scarabpot"]["break_top"], self.origin + var_0 );
        wait 0.1;
    }
}

breakpot( var_0 )
{
    var_0 hide();
    self playsound( self.lidsound );
    self notify( "pot_lid_broken" );
    self stoploopsound( self.smokesound );
    self.broken = 1;
    self solid( 0 );
    self setcandamage( 0 );
    var_1 = anglestoup( self.angles );
    var_2 = anglestoup( ( 0, 90, 0 ) );
    var_3 = vectordot( var_1, var_2 );
    var_4 = ( 0, 0, 0 );

    if ( var_3 < 0.5 )
    {
        var_5 = self.origin + var_1 * 22;
        var_6 = physicstrace( var_5, var_5 + ( 0, 0, -64 ) );
        var_4 = var_6 - self.origin;
    }

    var_4 += ( 0, 0, 4 );
    self playsound( self.breaksound );
    playfx( level._ID6083["scarabpot"]["break"], self.origin + var_4 + ( 0, 0, 20 ) );
    playfx( level._ID6083["scarabpot"]["break_scarabs"], self.origin + var_4 + ( 0, 0, 30 ) );
    self hide();

    if ( self.hasscarabs )
    {
        setupdeathzone();
        return;
    }
}

setupdeathzone()
{
    var_0 = 65;
    var_1 = 10;
    var_2 = spawn( "trigger_radius", self.origin, 0, var_0, var_1 );
    var_2 thread setupscarab( self._ID8979 );
    self delete();
}

setupscarab( var_0 )
{
    level endon( "game_ended" );
    var_1 = 15;
    var_2 = spawn( "script_model", self.origin );
    var_2 setmodel( "tag_origin" );
    var_2._ID30465 = "mp_dig_scarab_swarm";
    var_2.owner = var_0;
    var_2._ID19214 = spawn( "script_model", var_2.origin + ( 0, 0, 100 ) );
    var_2._ID19214 setmodel( "tag_origin" );

    if ( !isdefined( level._ID33473 ) )
        level._ID33473 = [];

    level._ID33473[level._ID33473.size] = var_2;
    var_2 thread watchlifetime( "scarabs_death", "scarabs_attacked_player", var_1 );
    var_2 thread cleanupscarab( self );
    var_2 thread playscarabfx();
    var_2 playsound( var_2._ID30465 );
    wait 2;
    var_2 thread watchscarabtrigger( self );
}

cleanupscarab( var_0 )
{
    common_scripts\utility::_ID35626( "scarabs_killed_player", "scarabs_death" );
    level._ID33473 = common_scripts\utility::array_remove( level._ID33473, self );
    self delete();
    var_0 delete();
}

playscarabfx()
{
    level endon( "game_ended" );
    common_scripts\utility::_ID35582();
    playfxontag( level._ID6083["scarab"]["ground"], self, "tag_origin" );
    playfxontag( level._ID6083["scarab"]["flyers"], self, "tag_origin" );
}

delaystopsound( var_0 )
{
    level endon( "game_ended" );
    wait(var_0);
    self stopsounds();
}

watchscarabtrigger( var_0 )
{
    self endon( "scarabs_death" );

    for (;;)
    {
        var_0 waittill( "trigger",  var_1  );

        if ( level._ID32653 )
        {
            if ( isdefined( var_1 ) && isplayer( var_1 ) && ( var_1.team != self.owner.team || var_1 == self.owner ) )
            {
                thread delaystopsound( 0.5 );
                thread killnearbyvictim( var_1 );
                self notify( "scarabs_attacked_player" );
                break;
            }

            continue;
        }

        if ( isdefined( var_1 ) && isplayer( var_1 ) )
        {
            thread delaystopsound( 0.5 );
            thread killnearbyvictim( var_1 );
            self notify( "scarabs_attacked_player" );
            break;
        }
    }
}

killnearbyvictim( var_0 )
{
    self endon( "scarabs_killed_player" );
    self endon( "scarabs_death" );
    thread watchscarabkill( var_0 );

    if ( isdefined( var_0 ) && isalive( var_0 ) )
    {
        stopfxontag( level._ID6083["scarab"]["flyers"], self, "tag_origin" );
        self moveto( var_0.origin, 0.8 );
        return;
    }
}

watchscarabkill( var_0, var_1 )
{
    var_0 endon( "death" );
    self endon( "scarabs_killed_player" );
    self endon( "scarabs_death" );

    if ( !isdefined( var_1 ) || var_1 == 0 )
    {
        while ( distancesquared( var_0.origin, self.origin ) > 4000 )
            wait 0.05;

        stopfxontag( level._ID6083["scarab"]["ground"], self, "tag_origin" );
    }

    var_2 = undefined;

    if ( !var_0 maps\mp\_utility::_ID18837() )
    {
        var_2 = spawnfxforclient( level._ID6083["scarab"]["screen"], var_0 geteye(), var_0 );
        triggerfx( var_2 );
        var_2 setfxkilldefondelete();
        var_0 playlocalsound( "mp_dig_scarab_plr_overtaken" );
    }

    var_0 playsoundonmovingent( "mp_dig_scarab_npc_overtaken" );
    var_0 thread killfxonplayerdeath( var_2 );
    var_0 thread doperiodicdamage( var_2, 20, 0.5, "MOD_SCARAB", self, "scarabs_killed_player", self.owner, self );
}

playcustomdeathsound( var_0, var_1, var_2 )
{
    if ( var_1 == "MOD_SCARAB" )
        return;

    var_0 maps\mp\_utility::_ID23899();
    return;
}
#using_animtree("multiplayer");

playdeathanimscarabs()
{
    level endon( "game_ended" );
    self waittill( "death_delay_start" );
    var_0 = self._ID5433 getcorpseanim();
    var_1 = spawn( "script_model", self._ID5433.origin );
    var_1 setmodel( "scarab_fullbody_bone_fx" );
    var_1.origin = self._ID5433.origin;
    var_1.angles = self._ID5433.angles;
    var_1 linkto( self._ID5433, "tag_origin", ( 0, 50, 0 ), var_1.angles );

    if ( var_0 == %mp_scarab_death_stand_1 )
        var_1 scriptmodelplayanim( "scarab_fullbody_bone_fx_stand_anim" );
    else if ( var_0 == %mp_scarab_death_crouch_1 )
        var_1 scriptmodelplayanim( "scarab_fullbody_bone_fx_crouch_anim" );
    else
        var_1 scriptmodelplayanim( "scarab_fullbody_bone_fx_prone_anim" );

    for ( var_2 = 0; var_2 < 32; var_2++ )
    {
        if ( var_2 < 2 )
            continue;
        else if ( var_2 < 10 )
            playfxontag( level.dig_fx["scarab"]["deathAnim"], var_1, "Point00" + var_2 );
        else
            playfxontag( level.dig_fx["scarab"]["deathAnim"], var_1, "Point0" + var_2 );

        common_scripts\utility::_ID35582();
    }

    thread stopfxonplayerspawn( var_1 );
}

stopfxonplayerspawn( var_0 )
{
    level endon( "game_ended" );
    maps\mp\gametypes\_hostmigration::_ID35597( 10 );

    for ( var_1 = 0; var_1 < 32; var_1++ )
    {
        if ( var_1 < 2 )
            continue;
        else if ( var_1 < 10 )
            stopfxontag( level.dig_fx["scarab"]["deathAnim"], var_0, "Point00" + var_1 );
        else
            stopfxontag( level.dig_fx["scarab"]["deathAnim"], var_0, "Point0" + var_1 );

        common_scripts\utility::_ID35582();
    }

    var_0 delete();
}

setupradio()
{
    level endon( "game_ended" );
    level.treasure_room_jackpot = 0;
    level.radioarray = getentarray( "secret_room_radio", "targetname" );
    var_0 = randomintrange( 2, 5 );
    var_1 = randomintrange( 30, 60 );
    level thread jackpotwatcher( var_0, var_1 );
}

jackpotwatcher( var_0, var_1 )
{
    level endon( "game_ended" );

    for (;;)
    {
        if ( maps\mp\_utility::_ID15150() > var_0 && ( isdefined( level.treasure_room_jackpot ) && !level.treasure_room_jackpot ) )
        {
            foreach ( var_3 in level.radioarray )
            {
                if ( isdefined( var_3 ) )
                    var_3 playsound( "mp_dig_uk_tomb_special" );
            }

            level thread jackpottimeout( 30 );
            level.treasure_room_jackpot = 1;
        }
        else
        {
            foreach ( var_3 in level.radioarray )
            {
                if ( isdefined( var_3 ) )
                    var_3 playsound( "mp_dig_uk_tomb1" );
            }
        }

        maps\mp\gametypes\_hostmigration::_ID35597( var_1 );
    }
}

jackpottimeout( var_0 )
{
    level endon( "game_ended" );
    level endon( "chest_raided" );
    maps\mp\gametypes\_hostmigration::_ID35597( var_0 );
    level.treasure_room_jackpot = undefined;
}

setuptreasureroom()
{
    level.treasure_room_open = 0;
    level.treasuredoor = getent( "secret_room_door_model", "targetname" );
    level.treasuredoorclip = getent( "secret_room_door", "targetname" );

    if ( isdefined( level.treasuredoor ) && isdefined( level.treasuredoorclip ) )
        level.treasuredoorclip linkto( level.treasuredoor );

    level.flamedeathzone = getent( "secret_room_kill", "targetname" );

    if ( isdefined( level.flamedeathzone ) )
    {
        level.flamedeathzone.dmg = 0;
        level.flamedeathzone thread killall( "flame_ended", 5000, "MOD_CRUSH" );
        level.flamedeathzone common_scripts\utility::_ID33657();
    }

    level thread watchtorchesused();
    level.key_torches = getentarray( "torch_trigs", "targetname" );

    foreach ( var_1 in level.key_torches )
    {
        var_1 sethintstring( &"MP_DIG_ACTIVATE_TORCH" );
        var_1 thread watchtorchuse();
        var_1._ID34731 = 0;
    }
}

watchtorchuse()
{
    level endon( "game_ended" );
    self waittill( "trigger",  var_0  );
    activatetorch( var_0 );
}

activatetorch( var_0 )
{
    self makeunusable();
    var_1 = getent( self.target, "targetname" );
    var_1 rotatepitch( -45, 4 );
    var_1 playsound( "mp_dig_torch_rotate" );
    var_2 = spawnfx( level.dig_fx["torch"]["sand"], var_1.origin );
    triggerfx( var_2 );
    self._ID34731 = 1;
    level notify( "torch_used",  var_0  );
}

watchtorchesused()
{
    level endon( "game_ended" );
    var_0 = 0;

    for (;;)
    {
        level waittill( "torch_used",  var_1  );
        var_0 += 1;

        if ( var_0 == 3 )
        {
            level.dig_hidden_door_owner = var_1;
            level thread opentreasureroom();
            var_0 = 0;
        }
    }
}

opentreasureroom()
{
    level endon( "game_ended" );
    var_0 = ( -5, -105, 0 );

    if ( !isdefined( level.doorsoundobj ) )
    {
        level.doorsoundobj = spawn( "script_model", level.treasuredoor.origin + var_0 );
        level.doorsoundobj setmodel( "tag_origin" );
        level.doorsoundobj linkto( level.treasuredoor );
    }

    level thread doorsounds();
    level.treasuredoor rotateyaw( 75, 15 );
    earthquake( 0.1, 15, level.treasuredoor.origin, 500 );
    common_scripts\utility::exploder( 59 );
    wait 15;
    level.treasuredoorclip connectpaths();
    level.treasure_room_open = 1;
    spawnkillstreakchest();
}

doorsounds()
{
    level endon( "game_ended" );
    common_scripts\utility::_ID35582();
    level.doorsoundobj playsoundonmovingent( "mp_dig_treasure_door_open" );
}

spawnkillstreakchest()
{
    level.chest_rewardtype = common_scripts\utility::_ID25350( [ "uplink_support", "deployable_vest", "deployable_ammo", "ball_drone_radar", "aa_launcher", "jammer", "ims" ] );

    if ( isdefined( level.treasure_room_jackpot ) && level.treasure_room_jackpot )
        level.chest_rewardtype = "odin_assault";

    level.chest_rewardhint = game["strings"][level.chest_rewardtype + "_hint"];

    if ( !isdefined( level.chest_trigger ) )
        level.chest_trigger = getent( "secret_room_chest", "targetname" );

    if ( isdefined( level.chest_trigger ) )
    {
        if ( !isdefined( level.chest_useobj ) )
        {
            level.chest_useobj = maps\mp\gametypes\_gameobjects::_ID8493( "neutral", level.chest_trigger, [ level.chest_trigger ], ( 0, 0, 0 ) );
            level.chest_useobj._ID17334 = "care_package";
        }
        else
            level.chest_useobj maps\mp\gametypes\_gameobjects::_ID11498();

        level.chest_useobj maps\mp\gametypes\_gameobjects::_ID29198( 4 );
        level.chest_useobj maps\mp\gametypes\_gameobjects::_ID29196( level.chest_rewardhint );
        level.chest_useobj maps\mp\gametypes\_gameobjects::_ID29202( "any" );
        level.chest_useobj maps\mp\gametypes\_gameobjects::allowuse( "any" );
        level.chest_useobj._ID22916 = ::chestonuse;
        level.chest_useobj._ID22779 = ::chestonbeginuse;
        level.chest_useobj._ID22816 = ::chestonenduse;

        if ( !isdefined( level.chest_display ) )
            level.chest_display = common_scripts\utility::_ID15384( level.chest_trigger.target, "targetname" );

        level.chest_display maps\mp\_entityheadicons::setheadicon( level.dig_hidden_door_owner, maps\mp\_utility::getkillstreakoverheadicon( level.chest_rewardtype ), ( 0, 0, 0 ), 14, 14, 0, undefined, undefined, undefined, undefined, 0 );
        return;
    }
}

chestonuse( var_0 )
{
    var_0 chestupdate();
    maps\mp\gametypes\_gameobjects::_ID10167();
}

chestonbeginuse( var_0 )
{

}

chestonenduse( var_0, var_1, var_2 )
{
    if ( isplayer( var_1 ) )
    {
        var_1 maps\mp\gametypes\_gameobjects::_ID34638( self, 0 );
        return;
    }
}

chestupdate()
{
    level.chest_display maps\mp\_entityheadicons::setheadicon( level.dig_hidden_door_owner, "", ( 0, 0, 10 ), 14, 14, 0, undefined, undefined, undefined, undefined, 0 );
    common_scripts\utility::exploder( 56 );
    level.chest_trigger playsound( "mp_dig_treasure_smoke" );
    var_0 = ( 120, 70, -50 );
    var_1 = spawn( "script_origin", level.chest_trigger.origin + var_0 );
    var_1 hide();
    earthquake( 0.2, 16, var_1.origin, 400 );
    var_1 playsound( "mp_dig_door_rumble" );
    thread maps\mp\killstreaks\_killstreaks::_ID15602( level.chest_rewardtype, 0, 0, self );

    if ( isdefined( level.treasure_room_jackpot ) && level.treasure_room_jackpot )
    {
        level.treasure_room_jackpot = undefined;
        level notify( "chest_raided" );
    }

    level thread notifydeadplayers();
    level thread closetreasureroom();
}

resettreasureroom()
{
    level endon( "game_ended" );
    level waittill( "treasure_room_reset" );

    if ( level.treasure_room_open )
        level thread closetreasureroom();

    level.chest_display maps\mp\_entityheadicons::setheadicon( level.dig_hidden_door_owner, "", ( 0, 0, 10 ), 14, 14, 0, undefined, undefined, undefined, undefined, 0 );

    if ( isdefined( level.chest_useobj ) )
        level.chest_useobj maps\mp\gametypes\_gameobjects::_ID10167();

    foreach ( var_1 in level.key_torches )
    {
        if ( var_1._ID34731 )
        {
            var_2 = getent( var_1.target, "targetname" );
            var_2 rotatepitch( 45, 0.1 );
            var_1 makeusable();
            var_1 sethintstring( &"MP_DIG_ACTIVATE_TORCH" );
            var_1 thread watchtorchuse();
            var_1._ID34731 = 0;
        }
    }

    level.treasure_room_jackpot = 0;
}

notifydeadplayers()
{
    level endon( "game_ended" );
    maps\mp\gametypes\_hostmigration::_ID35597( 11 );
    level.flamedeathzone common_scripts\utility::_ID33659();

    foreach ( var_1 in level.players )
    {
        if ( var_1 istouching( level.flamedeathzone ) )
            var_1 playlocalsound( "mp_dig_tomb_die1" );
    }
}

closetreasureroom()
{
    level endon( "game_ended" );

    if ( isdefined( level.doorsoundobj ) )
        level.doorsoundobj playsoundonmovingent( "mp_dig_treasure_door_close" );

    level.treasuredoor rotateyaw( -75, 15 );
    earthquake( 0.1, 15, level.treasuredoor.origin, 500 );
    maps\mp\gametypes\_hostmigration::_ID35597( 15 );
    level.treasuredoorclip disconnectpaths();
    level.treasure_room_open = 0;
    level thread triggerflametrap();
}

triggerflametrap()
{
    common_scripts\utility::exploder( 57 );
    var_0 = common_scripts\utility::_ID15386( "secret_room_fire_mid", "targetname" );

    foreach ( var_4, var_2 in var_0 )
    {
        var_3 = spawn( "script_origin", var_2.origin );
        var_3 hide();
        var_3 playsound( "mp_dig_fire_wall" + ( var_4 + 1 ) );
    }

    foreach ( var_6 in level._ID23303 )
    {
        if ( isplayer( var_6 ) && maps\mp\_utility::_ID18757( var_6 ) && var_6 istouching( level.flamedeathzone ) )
        {
            playfxontag( level.dig_fx["flametrap"]["player"], var_6, "j_spineupper" );
            var_7 = spawnfxforclient( level.dig_fx["flametrap"]["screen"], var_6 geteye(), var_6 );
            triggerfx( var_7 );
            var_7 setfxkilldefondelete();
            var_6 thread killfxonplayerdeath( var_7 );
            var_6 thread stopfxonspawn( level.dig_fx["flametrap"]["player"], "j_spineupper" );
            var_6 thread doperiodicdamage( var_7, 20, 0.5, "MOD_SCARAB" );
        }
    }

    level thread delaynotify( "flame_ended", 4 );
}

setupsnakes( var_0 )
{
    level endon( "game_ended" );

    if ( !isdefined( level.dig_snake ) )
    {
        level.dig_snake = spawn( "script_model", var_0 );
        level.dig_snake setmodel( "snake_many_mp_dig_secretroom" );
        level.dig_snake.origin = var_0;
    }

    for (;;)
    {
        level.dig_snake scriptmodelplayanim( "snake_many_mp_dig_secretroom_anim" );
        maps\mp\gametypes\_hostmigration::_ID35597( 66.7 );
    }
}

setupshrineperks()
{
    level.shrineperks = [];
    level.abilitycategories = maps\mp\gametypes\_class::getnumabilitycategories();
    level.abilitypercategory = maps\mp\gametypes\_class::getnumsubability();

    for ( var_0 = 0; var_0 < level.abilitycategories; var_0++ )
    {
        for ( var_1 = 0; var_1 < level.abilitypercategory; var_1++ )
        {
            var_2 = tablelookup( "mp/cacAbilityTable.csv", 0, var_0 + 1, 4 + var_1 );

            if ( validshrineperk( var_2 ) )
                level.shrineperks[level.shrineperks.size] = var_2;
        }
    }
}

validshrineperk( var_0 )
{
    var_1 = 1;

    switch ( var_0 )
    {
        case "specialty_extra_equipment":
        case "specialty_extra_deadly":
        case "specialty_extraammo":
        case "specialty_extra_attachment":
        case "specialty_gambler":
        case "specialty_hardline":
        case "specialty_twoprimaries":
            var_1 = 0;
            break;
    }

    return var_1;
}

digcustomcratefunc()
{
    if ( !isdefined( game["player_holding_level_killstrek"] ) )
        game["player_holding_level_killstrek"] = 0;

    if ( !maps\mp\_utility::allowlevelkillstreaks() || game["player_holding_level_killstrek"] || !level.allow_level_killstreak )
        return;

    maps\mp\killstreaks\_airdrop::addcratetype( "airdrop_assault", "dig_level_killstreak", 85, ::digcratethink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::_ID14444(), &"MP_DIG_ACTIVATE_SHRINE" );
    maps\mp\killstreaks\_airdrop::generatemaxweightedcratevalue();
    level thread watch_for_dig_killstreak();
}

digcratethink( var_0 )
{
    self endon( "death" );
    self endon( "restarting_physics" );
    level endon( "game_ended" );

    if ( isdefined( game["strings"][self.cratetype + "_hint"] ) )
        var_1 = game["strings"][self.cratetype + "_hint"];
    else
        var_1 = &"PLATFORM_GET_KILLSTREAK";

    maps\mp\killstreaks\_airdrop::cratesetupforuse( var_1, maps\mp\_utility::getkillstreakoverheadicon( self.cratetype ) );
    thread crateothercapturethink();
    thread crateownercapturethink();

    for (;;)
    {
        self waittill( "captured",  var_2  );
        level.dig_killstreak_user = var_2;

        if ( isplayer( var_2 ) )
        {
            var_2 setclientomnvar( "ui_securing", 0 );
            var_2._ID34183 = undefined;
        }

        tryusedigkillstreak();
        maps\mp\killstreaks\_airdrop::deletecrate();
    }
}

crateothercapturethink( var_0 )
{
    self endon( "restarting_physics" );

    while ( isdefined( self ) )
    {
        self waittill( "trigger",  var_1  );

        if ( isdefined( self.owner ) && var_1 == self.owner )
            continue;

        if ( !maps\mp\killstreaks\_airdrop::_ID34838( var_1 ) )
            continue;

        if ( var_1 maps\mp\_utility::_ID18666() )
        {
            var_1 iprintlnbold( &"MP_DIG_LEVEL_KILLSTREAK_REJECT" );
            continue;
        }

        if ( isdefined( level.overridecrateusetime ) )
            var_2 = level.overridecrateusetime;
        else
            var_2 = undefined;

        var_1.iscapturingcrate = 1;
        var_3 = maps\mp\killstreaks\_airdrop::_ID8492();
        var_4 = var_3 maps\mp\killstreaks\_airdrop::_ID34751( var_1, var_2, var_0 );

        if ( isdefined( var_3 ) )
            var_3 delete();

        if ( !isdefined( var_1 ) )
            return;

        if ( !var_4 )
        {
            var_1.iscapturingcrate = 0;
            continue;
        }

        var_1.iscapturingcrate = 0;
        self notify( "captured",  var_1  );
    }
}

crateownercapturethink( var_0 )
{
    self endon( "restarting_physics" );

    while ( isdefined( self ) )
    {
        self waittill( "trigger",  var_1  );

        if ( isdefined( self.owner ) && var_1 != self.owner )
            continue;

        if ( !maps\mp\killstreaks\_airdrop::_ID34838( var_1 ) )
            continue;

        if ( var_1 maps\mp\_utility::_ID18666() )
        {
            var_1 iprintlnbold( &"MP_DIG_LEVEL_KILLSTREAK_REJECT" );
            continue;
        }

        var_1.iscapturingcrate = 1;

        if ( !maps\mp\killstreaks\_airdrop::_ID34751( var_1, 500, var_0 ) )
        {
            var_1.iscapturingcrate = 0;
            continue;
        }

        var_1.iscapturingcrate = 0;
        self notify( "captured",  var_1  );
    }
}

watch_for_dig_killstreak()
{
    for (;;)
    {
        level waittill( "createAirDropCrate",  var_0  );

        if ( isdefined( var_0 ) && isdefined( var_0.cratetype ) && var_0.cratetype == "dig_level_killstreak" )
        {
            disable_level_killstreak();
            var_1 = _ID35446( var_0 );

            if ( !var_1 )
            {
                enable_level_killstreak();
                continue;
            }

            break;
        }
    }
}

_ID35446( var_0 )
{
    var_1 = _ID35948( var_0 );
    return !isdefined( var_1 );
}

_ID35948( var_0 )
{
    var_0 endon( "captured" );
    var_0 waittill( "death" );
    waittillframeend;
    return 1;
}

enable_level_killstreak()
{
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "dig_level_killstreak", 85 );
    level.intelrewardoverride = "dig_level_killstreak";
}

disable_level_killstreak()
{
    maps\mp\killstreaks\_airdrop::changecrateweight( "airdrop_assault", "dig_level_killstreak", 0 );
    level.intelrewardoverride = undefined;
}

digcustomkillstreakfunc()
{
    level._ID19256["dig_level_killstreak"] = ::tryusedigkillstreak;
}

digcustombotkillstreakfunc()
{
    maps\mp\bots\_bots_ks::bot_register_killstreak_func( "dig_level_killstreak", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

tryusedigkillstreak( var_0, var_1 )
{
    level.dig_killstreak_user giveperkbonus();
    level.dig_killstreak_user thread watchperkblessing();
    level.dig_killstreak_user thread watchjugguse();
    level.dig_killstreak_user thread watchremoteuse( "using_remote" );
    level.dig_killstreak_user thread watchremoteuse( "stopped_using_remote" );

    if ( level._ID14086 == "blitz" )
        level.dig_killstreak_user thread watchblitzteleport();

    level thread watchplayersconnect( level.dig_killstreak_user );
    level thread watchblessingend( level.dig_killstreak_user );
    level thread maps\mp\_utility::_ID32672( "used_dig_level_killstreak", level.dig_killstreak_user );
}

giveperkbonus()
{
    if ( !isdefined( level.player_life_counter ) )
        level.player_life_counter = 0;

    foreach ( var_1 in level.shrineperks )
    {
        if ( !maps\mp\_utility::_hasperk( var_1 ) )
            maps\mp\_utility::_ID15611( var_1, 0 );
    }

    thread maps\mp\gametypes\_hud_message::_ID31052( "mp_dig_all_perks" );
    level thread showblessingfx( self );
    thread stopfxonspawn( level.dig_fx["shrine"]["player"], "tag_origin" );

    if ( !isdefined( self.shrine_effect_ent ) )
    {
        self.shrine_effect_ent = spawnfxforclient( level.dig_fx["shrine"]["screen"], self geteye(), self );
        triggerfx( self.shrine_effect_ent );
        self.shrine_effect_ent setfxkilldefondelete();
        thread killfxonplayerdeath( self.shrine_effect_ent, "reset_perk_bonus", "user_juggernaut", "user_remotekillstreak" );
    }

    self playlocalsound( "mp_dig_plr_spawn_with_powers" );
    self playloopsound( "mp_dig_magic_powers_flame_lp" );
    level notify( "update_bombsquad" );
    level.player_life_counter = level.player_life_counter + 1;
}

resetperkbonus()
{
    level.player_life_counter = 0;
    self setclientomnvar( "ui_dig_killstreak_show", -1 );
    stopfxontag( level.dig_fx["shrine"]["player"], self, "tag_origin" );

    if ( isdefined( self.shrine_effect_ent ) )
        self.shrine_effect_ent delete();

    level notify( "reset_perk_bonus" );
}

watchperkblessing()
{
    self endon( "disconnect" );
    self endon( "blessing_ended" );
    self endon( "joined_team" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "spawned_player" );
        self setclientomnvar( "ui_dig_killstreak_show", -1 );
        common_scripts\utility::_ID35582();

        if ( level.player_life_counter < 4 && !maps\mp\_utility::_ID18666() )
        {
            giveperkbonus();

            if ( !hasperkinloadout( "specialty_blindeye" ) || !hasperkinloadout( "specialty_gpsjammer" ) )
                childthread regivespawnperks();

            continue;
        }

        if ( level.player_life_counter == 4 )
            self notify( "blessing_ended" );
    }
}

hasperkinloadout( var_0 )
{
    var_1 = 0;

    if ( isdefined( self.pers["loadoutPerks"] ) && self.pers["loadoutPerks"].size > 0 )
    {
        foreach ( var_3 in self.pers["loadoutPerks"] )
        {
            if ( var_0 == var_3 )
            {
                var_1 = 1;
                break;
            }
        }
    }

    return var_1;
}

regivespawnperks()
{
    self waittill( "starting_perks_unset" );

    if ( !maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
        maps\mp\_utility::_ID15611( "specialty_blindeye", 0 );

    if ( !maps\mp\_utility::_hasperk( "specialty_gpsjammer" ) )
    {
        maps\mp\_utility::_ID15611( "specialty_gpsjammer", 0 );
        return;
    }
}

watchjugguse()
{
    self endon( "disconnect" );
    self endon( "blessing_ended" );
    self endon( "joined_team" );
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "juggernaut_equipped",  var_0  );

        if ( self == var_0 )
        {
            self.shrine_effect_ent delete();
            stopfxontag( level.dig_fx["shrine"]["player"], self, "tag_origin" );
            level notify( "user_juggernaut" );
        }
    }
}

watchremoteuse( var_0 )
{
    self endon( "disconnect" );
    self endon( "blessing_ended" );
    self endon( "joined_team" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( var_0 );

        if ( var_0 == "using_remote" )
        {
            if ( isdefined( self.shrine_effect_ent ) )
            {
                self.shrine_effect_ent delete();
                level notify( "user_remotekillstreak" );
            }

            continue;
        }

        if ( var_0 == "stopped_using_remote" )
        {
            if ( !isdefined( self.shrine_effect_ent ) )
            {
                self.shrine_effect_ent = spawnfxforclient( level.dig_fx["shrine"]["screen"], self geteye(), self );
                triggerfx( self.shrine_effect_ent );
                self.shrine_effect_ent setfxkilldefondelete();
                thread killfxonplayerdeath( self.shrine_effect_ent, "reset_perk_bonus", "user_juggernaut", "user_remotekillstreak" );
            }
        }
    }
}

watchblitzteleport()
{
    self endon( "disconnect" );
    self endon( "blessing_ended" );
    self endon( "joined_team" );
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "portal_used",  var_0  );
        common_scripts\utility::_ID35582();

        if ( var_0 != self.team && ( isdefined( self._ID32801 ) && self._ID32801 ) )
            level thread showblessingfx( self );
    }
}

watchplayersconnect( var_0 )
{
    var_0 endon( "disconnect" );
    var_0 endon( "blessing_ended" );
    var_0 endon( "joined_team" );
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected",  var_1  );
        var_1 thread playfxonplayerspawn( var_0 );
    }
}

watchblessingend( var_0 )
{
    level endon( "game_ended" );
    var_0 common_scripts\utility::_ID35626( "disconnect", "joined_team", "blessing_ended" );
    level.player_life_counter = 0;
}

showblessingfx( var_0 )
{
    var_0 endon( "disconnect" );
    var_0 endon( "blessing_ended" );
    var_0 endon( "joined_team" );
    level endon( "game_ended" );

    foreach ( var_2 in level.players )
    {
        if ( isdefined( var_2 ) && isdefined( var_0 ) && maps\mp\_utility::_ID18757( var_0 ) )
            playfxontagforclients( level.dig_fx["shrine"]["player"], var_0, "tag_origin", var_2 );

        common_scripts\utility::_ID35582();
    }
}

playfxonplayerspawn( var_0 )
{
    var_0 endon( "disconnect" );
    var_0 endon( "blessing_ended" );
    var_0 endon( "joined_team" );
    level endon( "game_ended" );
    self waittill( "spawned_player" );

    if ( isdefined( self ) && isdefined( var_0 ) && maps\mp\_utility::_ID18757( var_0 ) )
    {
        playfxontagforclients( level.dig_fx["shrine"]["player"], var_0, "tag_origin", self );
        return;
    }
}

watchlifetime( var_0, var_1, var_2 )
{
    self endon( var_1 );

    while ( var_2 > 0 )
    {
        var_2 -= 1;
        wait 1;
    }

    self notify( var_0 );
}

doperiodicdamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    level endon( "game_ended" );

    if ( !isdefined( var_3 ) )
        var_3 = "MOD_CRUSH";

    var_8 = 0;
    var_9 = undefined;
    var_10 = undefined;

    if ( isdefined( var_6 ) && isdefined( var_7 ) )
    {
        var_9 = var_6;
        var_10 = var_7;
    }

    while ( maps\mp\_utility::_ID18757( self ) )
    {
        self dodamage( var_1, self.origin, var_9, var_10, var_3 );

        if ( var_3 == "MOD_SCARAB" )
        {
            if ( self.health <= 30 && !var_8 )
            {
                var_11 = randomintrange( 1, 8 );
                var_12 = "male";

                if ( self hasfemalecustomizationmodel() )
                    var_12 = "female";

                if ( self.team == "axis" )
                    self playsound( var_12 + "_scarab_death_russian" + var_11 );
                else
                    self playsound( var_12 + "_scarab_death_american" + var_11 );

                var_8 = 1;
            }
        }

        wait(var_2);
    }

    if ( isdefined( var_4 ) && isdefined( var_5 ) )
    {
        var_4 notify( var_5 );
        return;
    }
}

killfxonplayerdeath( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );

    if ( isdefined( var_1 ) )
        level endon( var_1 );

    if ( isdefined( var_2 ) )
        level endon( var_2 );

    if ( isdefined( var_3 ) )
        level endon( var_3 );

    common_scripts\utility::_ID35626( "killed_player", "disconnect" );

    if ( isdefined( var_0 ) )
    {
        if ( isarray( var_0 ) )
        {
            foreach ( var_5 in var_0 )
                var_5 delete();

            return;
        }

        var_0 delete();
        return;
        return;
    }
}

stopfxonspawn( var_0, var_1 )
{
    level endon( "game_ended" );
    self waittill( "spawned_player" );
    stopfxontag( var_0, self, var_1 );
}

drawlinkedsphere( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    var_3 = ( 0, 0, 0 );

    for (;;)
    {
        if ( var_3 != self.origin )
        {
            var_3 = self.origin;

            if ( isdefined( var_2 ) && var_2 )
                break;
        }

        common_scripts\utility::_ID35582();
    }
}

getfirstaliveplayer()
{
    foreach ( var_1 in level._ID23303 )
    {
        if ( isdefined( var_1 ) && maps\mp\_utility::_ID18757( var_1 ) )
            return var_1;
    }
}

delayhide( var_0, var_1 )
{
    level endon( "game_ended" );
    wait(var_1);
    var_0 hide();
    var_0 notsolid();
}

killall( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    level waittill( var_0 );

    if ( isdefined( self._ID33657 ) )
        common_scripts\utility::_ID33659();

    common_scripts\utility::_ID35582();
    var_3 = getattacker( var_0 );
    var_4 = getinflictor( var_0 );
    killalltouchingtrigger( level.characters, "CHARACTERS", var_1, var_2, var_3, var_4 );
    killalltouchingtrigger( level._ID34099, "KILLSTREAKS", var_1, var_2, var_3, var_4 );
    killalltouchingtrigger( level.placedims, "KILLSTREAKS", var_1, var_2, var_3, var_4 );
    killalltouchingtrigger( level.balldrones, "KILLSTREAKS", var_1, var_2, var_3, var_4 );
    killalltouchingtrigger( level._ID34657, "KILLSTREAKS", var_1, var_2, var_3, var_4 );
    killalltouchingtrigger( level._ID25810, "KILLSTREAKS", var_1, var_2, var_3, var_4 );
    var_5 = [];
    var_6 = getentarray( "script_model", "classname" );

    foreach ( var_8 in var_6 )
    {
        if ( isdefined( var_8.boxtype ) )
            var_5[var_5.size] = var_8;
    }

    killalltouchingtrigger( var_5, "KILLSTREAKS", var_1, var_2, var_3, var_4 );
    killalltouchingtrigger( level._ID21075, "EQUIPMENT", var_1, var_2, var_3, var_4 );

    if ( level._ID14086 == "sd" || level._ID14086 == "sr" )
    {
        if ( isdefined( level.sdbomb ) && level.sdbomb._ID35361[0] istouching( self ) )
        {
            level.sdbomb notify( "stop_pickup_timeout" );
            level.sdbomb maps\mp\gametypes\_gameobjects::_ID26246();
        }
    }

    foreach ( var_11 in level._ID6711 )
    {
        if ( var_11.friendlymodel istouching( self ) || var_11._ID12071 istouching( self ) )
            var_11 maps\mp\killstreaks\_airdrop::deletecrate();
    }

    if ( isdefined( level._ID18050 ) )
    {
        if ( level._ID18050["visuals"] istouching( self ) )
            level._ID18050["dropped_time"] = -60000;
    }

    level thread activatekilltrigger( self, var_1 );
}

killalltouchingtrigger( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    foreach ( var_7 in var_0 )
    {
        if ( isdefined( var_7 ) && var_7 istouching( self ) )
        {
            switch ( var_1 )
            {
                case "CHARACTERS":
                    if ( isagent( var_7 ) && isdefined( var_7.team ) && var_7.team == var_4.team )
                        var_7 dodamage( var_2, var_7.origin, undefined, var_5, var_3 );
                    else
                        var_7 dodamage( var_2, var_7.origin, var_4, var_5, var_3 );

                    continue;
                case "KILLSTREAKS":
                case "EQUIPMENT":
                    var_7 destroykillstreak( var_2, var_3, var_4 );
                    continue;
            }
        }
    }
}

destroykillstreak( var_0, var_1, var_2 )
{
    var_3 = ( 0, 0, 0 );
    var_4 = ( 0, 0, 0 );
    var_5 = "";
    var_6 = "";
    var_7 = "";
    var_8 = undefined;
    var_9 = "killstreak_emp_mp";
    self notify( "damage",  var_0, var_2, var_3, var_4, var_1, var_5, var_6, var_7, var_8, var_9  );
}

activatekilltrigger( var_0, var_1 )
{
    level endon( "game_ended" );

    if ( isdefined( var_0 ) )
    {
        var_0.dmg = var_1;
        common_scripts\utility::_ID35582();
        var_0.dmg = 0;
        var_0 common_scripts\utility::_ID33657();
        return;
    }
}

delaynotify( var_0, var_1 )
{
    level endon( "game_ended" );
    wait(var_1);
    level notify( var_0 );
}

showent( var_0 )
{
    var_0 show();
    var_0 solid();
}

hideent( var_0 )
{
    var_0 hide();
    var_0 notsolid();
}

getattacker( var_0 )
{
    var_1 = undefined;

    switch ( var_0 )
    {
        case "obelisk_impact":
            var_1 = level.obeliskowner;
            break;
        case "flame_ended":
            var_1 = level.dig_hidden_door_owner;
            break;
    }

    return var_1;
}

getinflictor( var_0 )
{
    var_1 = undefined;

    switch ( var_0 )
    {
        case "obelisk_impact":
            var_1 = level.obeliskafterclip;
            break;
        case "flame_ended":
            var_1 = level.treasuredoorclip;
            break;
    }

    return var_1;
}

nuke_custom_visionset()
{
    level waittill( "nuke_death" );
    wait 1.3;
    level notify( "nuke_death" );
    thread nuke_custom_visionset();
}

nukedeathvision()
{
    level._ID22379 = "aftermath_mp_dig";
    setexpfog( 512, 2048, 0.578828, 0.802656, 1, 0.5, 0.75, 5, 0.382813, 0.350569, 0.293091, 0.5, ( 1, -0.109979, 0.267867 ), 0, 80, 1, 0.179688, 26, 180 );
    visionsetnaked( level._ID22379, 5 );
    visionsetpain( level._ID22379 );
}

delayexploder( var_0, var_1 )
{
    level endon( "game_ended" );
    wait(var_0);
    common_scripts\utility::exploder( var_1 );
}

delaytrigger( var_0, var_1 )
{
    level endon( "game_ended" );
    wait(var_0);

    if ( var_1 == "on" )
    {
        common_scripts\utility::_ID33659();
        return;
    }

    common_scripts\utility::_ID33657();
    return;
}
