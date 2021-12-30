// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    maps\mp\mp_prisonbreak_precache::_ID20445();
    maps\createart\mp_prisonbreak_art::_ID20445();
    maps\mp\mp_prisonbreak_fx::_ID20445();
    level thread _ID20238();
    maps\mp\_load::_ID20445();
    maps\mp\_compass::_ID29184( "compass_map_mp_prisonbreak" );
    setdvar( "r_reactiveMotionWindAmplitudeScale", 0.3 );
    setdvar( "r_reactiveMotionWindFrequencyScale", 0.5 );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    maps\mp\_utility::_ID28710( "r_diffusecolorscale", 1.5, 1.8 );
    maps\mp\_utility::_ID28710( "r_specularcolorscale", 3.0, 6.0 );
    setdvar( "r_ssaofadedepth", 1089 );
    setdvar( "r_ssaorejectdepth", 1200 );

    if ( level._ID25139 )
        setdvar( "sm_sunShadowScale", "0.6" );
    else if ( level._ID36452 )
        setdvar( "sm_sunShadowScale", "0.7" );

    game["attackers"] = "allies";
    game["defenders"] = "axis";

    if ( level._ID14086 == "sd" || level._ID14086 == "sr" )
        level thread _ID28806();

    level thread _ID33517();
    level thread falling_rocks();
}

_ID28806()
{
    level endon( "game_ended" );
    level._ID27942 = ::_ID22781;
    level waittill( "bomb_planted",  var_0  );

    if ( var_0 maps\mp\gametypes\_gameobjects::_ID15110() == "_b" )
        level._ID27942 = undefined;
}

_ID22781()
{
    var_0 = getent( "prisondoor1", "targetname" );
    var_1 = getent( "prisondoor2", "targetname" );
    var_0 rotateyaw( -70, 0.5 );
    var_0 playsound( "scn_prison_gate_right" );
    var_1 rotateyaw( 70, 0.5 );
    var_0 playsound( "scn_prison_gate_left" );
    wait 1;
    level notify( "sd_free_prisoners" );
}

_ID17991()
{
    initprisonerloadout();
    level.sd_prisonerobjective = getent( "sd_prisonerObjective", "targetname" );
    wait 3;
    level.bot_funcs["think"] = maps\mp\gametypes\_globallogic::blank;
    var_0 = getentarray( "mp_spawn", "classname" );

    foreach ( var_2 in var_0 )
        level thread createprisoner( var_2 );
}

createprisoner( var_0 )
{
    var_1 = addtestclient();
    var_1.pers["isBot"] = 1;
    var_1.equipment_enabled = 1;
    var_1._ID5801 = game["attackers"];

    while ( !isdefined( var_1.pers["team"] ) )
        wait 0.05;

    var_1 notify( "menuresponse",  game["menu_team"], game["attackers"]  );
    wait 0.5;
    var_1.pers["gamemodeLoadout"] = level.sd_loadouts["prisoner"];
    var_0._ID24539 = var_0.origin;
    var_0._ID22328 = 1;
    var_1.setspawnpoint = var_0;
    var_1 notify( "menuresponse",  "changeclass", "gamemode"  );
    var_1 thread _ID17052();
}

_ID17052()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self waittill( "spawned_player" );
    maps\mp\_utility::gameflagwait( "prematch_done" );
    common_scripts\utility::_disableweapon();
    var_0 = spawn( "script_origin", self.origin );
    self playerlinkto( var_0 );
    level waittill( "sd_free_prisoners" );
    self unlink();
    var_0 delete();

    for (;;)
    {
        self botclearscriptgoal();
        self botsetscriptgoal( level.sd_prisonerobjective.origin, 64, "critical" );
        var_1 = common_scripts\utility::_ID35635( "goal", "bad_path" );

        if ( var_1 == "goal" )
            break;

        wait 0.05;
    }
}

initprisonerloadout()
{
    level.sd_loadouts["prisoner"]["loadoutPrimary"] = "none";
    level.sd_loadouts["prisoner"]["loadoutPrimaryAttachment"] = "none";
    level.sd_loadouts["prisoner"]["loadoutPrimaryAttachment2"] = "none";
    level.sd_loadouts["prisoner"]["loadoutPrimaryBuff"] = "specialty_null";
    level.sd_loadouts["prisoner"]["loadoutPrimaryCamo"] = "none";
    level.sd_loadouts["prisoner"]["loadoutPrimaryReticle"] = "none";
    level.sd_loadouts["prisoner"]["loadoutSecondary"] = "none";
    level.sd_loadouts["prisoner"]["loadoutSecondaryAttachment"] = "none";
    level.sd_loadouts["prisoner"]["loadoutSecondaryAttachment2"] = "none";
    level.sd_loadouts["prisoner"]["loadoutSecondaryBuff"] = "specialty_null";
    level.sd_loadouts["prisoner"]["loadoutSecondaryCamo"] = "none";
    level.sd_loadouts["prisoner"]["loadoutSecondaryReticle"] = "none";
    level.sd_loadouts["prisoner"]["loadoutEquipment"] = "specialty_null";
    level.sd_loadouts["prisoner"]["loadoutOffhand"] = "none";
    level.sd_loadouts["prisoner"]["loadoutPerk1"] = "specialty_null";
    level.sd_loadouts["prisoner"]["loadoutPerk2"] = "specialty_null";
    level.sd_loadouts["prisoner"]["loadoutPerk3"] = "specialty_null";
    level.sd_loadouts["prisoner"]["loadoutStreakType"] = "assault";
    level.sd_loadouts["prisoner"]["loadoutKillstreak1"] = "none";
    level.sd_loadouts["prisoner"]["loadoutKillstreak2"] = "none";
    level.sd_loadouts["prisoner"]["loadoutKillstreak3"] = "none";
    level.sd_loadouts["prisoner"]["loadoutDeathstreak"] = "specialty_null";
    level.sd_loadouts["prisoner"]["loadoutJuggernaut"] = 0;
}

initinsertionvehicles()
{
    level._ID27939 = [];
    var_0 = getentarray( "sd_vehStart", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = spawn( "script_model", var_2.origin );
        var_3.origin = var_2.origin;
        var_3.angles = var_2.angles;
        var_3 setmodel( "vehicle_hummer_open_top_noturret" );
        var_4 = [];
        var_5 = getent( var_2.target, "targetname" );

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

        level._ID27939[var_2.script_count] = spawnstruct();
        level._ID27939[var_2.script_count].index = var_2.script_count;
        level._ID27939[var_2.script_count]._ID34941 = var_3;
        level._ID27939[var_2.script_count]._ID31206 = var_2;
        level._ID27939[var_2.script_count]._ID23323 = var_4;
        level._ID27939[var_2.script_count]._ID10956 = 0;
        level._ID27939[var_2.script_count]._ID23313 = 0;
        level._ID27939[var_2.script_count].arrived = 0;
    }

    level._ID27938 = undefined;
}

_ID22774()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "player_spawned",  var_0  );

        if ( game["state"] != "postgame" && var_0.pers["team"] == game["attackers"] )
            var_0 thread attackerride();
    }
}

attackerride()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    common_scripts\utility::_disableweapon();

    if ( !isdefined( level._ID27938 ) )
    {
        level._ID27938 = 1;
        level thread _ID31452();
    }

    var_0 = -1;
    var_1 = 0;
    var_2 = "";
    var_3 = undefined;

    for ( var_4 = 0; var_4 < level._ID27939.size; var_4++ )
    {
        var_3 = level._ID27939[var_4]._ID34941;

        if ( !level._ID27939[var_4]._ID10956 )
        {
            var_0 = var_4;
            var_1 = 1;
            level._ID27939[var_4]._ID10956 = 1;
            self playerlinktodelta( var_3, "tag_driver", 1, 30, 30, 30, 30, 1 );
            self setstance( "crouch" );

            if ( var_4 == 2 )
                var_2 = "tag_walker3";
            else
                var_2 = "tag_walker0";

            break;
            continue;
        }

        if ( !level._ID27939[var_4]._ID23313 )
        {
            var_0 = var_4;
            level._ID27939[var_4]._ID23313 = 1;
            self playerlinktodelta( var_3, "tag_passenger", 1, 30, 30, 30, 30, 1 );
            self setstance( "crouch" );

            if ( var_4 == 2 )
                var_2 = "tag_walker1";
            else
                var_2 = "tag_walker2";

            break;
        }
    }

    if ( var_0 < 0 )
    {

    }

    wait 0.05;

    while ( !level._ID27939[var_0].arrived )
        wait 0.05;

    self unlink();
    self setstance( "stand" );
    var_5 = spawn( "script_model", self.origin );
    var_5.origin = self.origin;
    var_5.angles = self.angles;
    var_5 setmodel( "tag_player" );
    self playerlinktodelta( var_5, "tag_player", 1, 30, 30, 30, 30, 1 );
    var_6 = var_3 gettagorigin( var_2 );
    var_7 = var_3 gettagangles( var_2 );
    var_8 = distance( var_5.origin, var_6 ) / 100;
    var_5 moveto( var_6, var_8, var_8 / 2, var_8 / 2 );
    var_5 rotateto( var_7, var_8, var_8 / 2, var_8 / 2 );
    wait(var_8);
    self unlink();
    var_5 delete();
    common_scripts\utility::_enableweapon();

    if ( var_1 )
        level._ID27939[var_0]._ID10956 = 0;
    else
        level._ID27939[var_0]._ID23313 = 0;
}

_ID31452()
{
    level endon( "game_ended" );

    for ( var_0 = 0; var_0 < level._ID27939.size; var_0++ )
    {
        level thread _ID35159( var_0 );
        wait 0.3;
    }
}

_ID35159( var_0 )
{
    level endon( "game_ended" );
    maps\mp\_utility::gameflagwait( "prematch_done" );
    var_1 = level._ID27939[var_0]._ID34941;
    var_2 = level._ID27939[var_0]._ID23323;

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = distance( var_1.origin, var_2[var_3].origin ) / 550;
        var_5 = 0;
        var_6 = 0;

        if ( var_3 == 0 )
            var_5 = var_4 / 2;
        else if ( var_3 == var_2.size - 1 )
            var_6 = var_4 / 2;

        var_1 moveto( var_2[var_3].origin, var_4, var_5, var_6 );
        var_1 rotateto( var_2[var_3].angles, var_4 );
        wait(var_4);
    }

    level._ID27939[var_0].arrived = 1;
}

_ID22139( var_0 )
{
    return ( angle_180( var_0[0] ), angle_180( var_0[1] ), angle_180( var_0[2] ) );
}

angle_180( var_0 )
{
    while ( var_0 > 180 )
        var_0 -= 360;

    while ( var_0 < -180 )
        var_0 += 360;

    return var_0;
}

_ID18413( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    var_0 = tolower( var_0 );

    switch ( var_0 )
    {
        case "mod_grenade_splash":
        case "mod_projectile_splash":
        case "mod_explosive":
        case "splash":
            return 1;
        default:
            return 0;
    }

    return 0;
}

_ID33427( var_0 )
{
    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
        return;

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    var_1 = getentarray( self.target, "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3.script_noteworthy ) )
            continue;

        switch ( var_3.script_noteworthy )
        {
            case "activate_trigger":
                if ( var_0 )
                    var_3 delete();
                else
                    self.activate_trigger = var_3;

                continue;
            case "use_model":
                if ( var_0 )
                    var_3 delete();
                else
                    self._ID34708 = var_3;

                continue;
            case "use_trigger":
                if ( var_0 )
                    var_3 delete();
                else
                    self.use_trigger = var_3;

                continue;
            default:
                continue;
        }
    }

    if ( isdefined( self.activate_trigger ) && isdefined( self._ID34708 ) && isdefined( self.use_trigger ) )
    {
        thread _ID33470();
        thread _ID33411();
    }
}

_ID33411()
{
    self waittill( "trap_activated" );

    foreach ( var_1 in self._ID34758._ID35361 )
        var_1 delete();

    self._ID34758._ID35361 = [];
    trap_set_can_use( 0 );
}

_ID33470()
{
    wait 0.05;
    self._ID34758 = maps\mp\gametypes\_gameobjects::_ID8493( "neutral", self.use_trigger, [ self._ID34708 ], ( 0, 0, 0 ) );
    self._ID34758._ID23270 = self;
    trap_set_can_use( 1 );
    self._ID34758 maps\mp\gametypes\_gameobjects::_ID29198( 2.5 );
    self._ID34758 maps\mp\gametypes\_gameobjects::_ID29197( &"MP_SETTING_TRAP" );
    self._ID34758 maps\mp\gametypes\_gameobjects::_ID29196( &"MP_SET_TRAP" );
    self._ID34758 maps\mp\gametypes\_gameobjects::_ID29202( "any" );
    self._ID34758._ID22916 = ::_ID33439;
}

trap_set_can_use( var_0 )
{
    if ( var_0 )
    {
        if ( isdefined( self._ID34705 ) && isdefined( self._ID34706 ) )
            thread hand_icon( "use", self._ID34706, self._ID34705, "trap_triggered" );

        if ( isdefined( self._ID34758 ) && isdefined( self._ID34758._ID35361 ) )
        {
            foreach ( var_2 in self._ID34758._ID35361 )
                var_2 hide();

            self._ID34758 maps\mp\gametypes\_gameobjects::allowuse( "any" );
        }
    }
    else if ( isdefined( self._ID34758 ) && isdefined( self._ID34758._ID35361 ) )
    {
        foreach ( var_2 in self._ID34758._ID35361 )
        {
            var_2 show();
            var_2 setmodel( "mil_semtex_belt" );
        }

        self._ID34758 maps\mp\gametypes\_gameobjects::allowuse( "none" );
    }
}

_ID33439( var_0 )
{
    self._ID23270 trap_set_can_use( 0 );
    self._ID23270 notify( "trap_triggered" );
    self._ID23270.owner = var_0;
    self._ID23270 thread _ID33442();
    self._ID23270 thread _ID33401();
}

_ID33442()
{
    self endon( "trap_activated" );
    self.owner waittill( "death" );
    trap_set_can_use( 1 );
}

_ID33401()
{
    self endon( "trap_activated" );
    self.owner endon( "death" );

    for (;;)
    {
        self.activate_trigger waittill( "trigger",  var_0  );

        if ( trap_can_player_trigger( var_0 ) )
            break;
    }

    self notify( "trap_activated" );
}

trap_can_player_trigger( var_0 )
{
    if ( !isdefined( self.owner ) )
        return 0;

    if ( isagent( var_0 ) && isdefined( var_0.owner ) && isdefined( self.owner ) && var_0.owner == self.owner )
        return 0;

    if ( !level._ID32653 )
        return var_0 != self.owner;

    if ( var_0.team != self.owner.team )
        return 1;

    return 0;
}

_ID33517()
{
    precachempanim( "mp_prisonbreak_tree_fall" );
    var_0 = common_scripts\utility::_ID15386( "tree_bridge", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::_ID33515 );
}

_ID33515()
{
    self._ID33513 = undefined;
    self.clip_up = undefined;
    self.clip_down = undefined;
    self._ID7532 = undefined;
    self.linked_ents = [];
    var_0 = getentarray( self.target, "targetname" );
    var_1 = common_scripts\utility::_ID15386( self.target, "targetname" );
    var_0 = common_scripts\utility::array_combine( var_0, var_1 );

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.script_noteworthy ) )
            continue;

        switch ( var_3.script_noteworthy )
        {
            case "the_tree":
                self._ID33513 = var_3;
                thread _ID33514( var_3, 0 );
                continue;
            case "clip_up_delete":
                self._ID7532 = var_3;
                continue;
            case "clip_up":
                self.clip_up = var_3;
                self.linked_ents[self.linked_ents.size] = var_3;
                continue;
            case "clip_down":
                self.clip_down = var_3;
                self.clip_down common_scripts\utility::_ID33657();
                continue;
            case "link":
                self.linked_ents[self.linked_ents.size] = var_3;
                continue;
            case "delete":
                self.decal = var_3;
                continue;
            case "killcam":
                self._ID19214 = spawn( "script_model", var_3.origin );
                self._ID19214 setmodel( "tag_origin" );
                continue;
            default:
                continue;
        }
    }

    self.animated_prop = spawn( "script_model", self._ID33513.origin );
    self.animated_prop setmodel( "generic_prop_raven" );
    self.animated_prop.angles = self._ID33513.angles;
    self._ID33513 linkto( self.animated_prop, "j_prop_2" );

    foreach ( var_6 in self.linked_ents )
        var_6 linkto( self._ID33513 );

    thread _ID33516();
}

_ID33514( var_0, var_1 )
{
    self endon( "tree_down" );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    var_2 = 1000000;
    var_3 = 100;
    var_0.health = var_2;
    var_0 setcandamage( 1 );

    for (;;)
    {
        var_0 waittill( "damage",  var_4, var_5, var_6, var_7, var_8  );
        var_5 thread maps\mp\gametypes\_damagefeedback::_ID34528( "tree" );

        if ( var_0.health < var_2 - var_3 )
            break;
    }

    var_0 setcandamage( 0 );

    if ( isdefined( self._ID33513 ) )
        self._ID33513 playsound( "scn_prison_tree_fall" );

    if ( var_1 )
        var_0 delete();

    self.attacker = var_5;
    self notify( "tree_down" );
}
#using_animtree("animated_props");

_ID33516()
{
    self waittill( "tree_down" );

    if ( isdefined( self.decal ) )
        self.decal delete();

    if ( isdefined( self._ID7532 ) )
        self._ID7532 delete();

    self.clip_up connectpaths();
    self._ID33513 maps\mp\_movers::notify_moving_platform_invalid();
    self.animated_prop scriptmodelplayanimdeltamotion( "mp_prisonbreak_tree_fall" );
    var_0 = getanimlength( %mp_prisonbreak_tree_fall );
    var_1 = var_0 - 0.3;
    var_2 = getent( "tree_impact_sound_origin", "targetname" );
    var_2 maps\mp\_utility::_ID9519( var_1, ::playsound_wrapper, "scn_prison_tree_impact" );
    wait(var_1);
    self.clip_down common_scripts\utility::_ID33659();
    self.clip_down dontinterpolate();
    self.clip_up maps\mp\_movers::notify_moving_platform_invalid();
    self.clip_up delete();

    foreach ( var_4 in level.characters )
    {
        if ( var_4 istouching( self.clip_down ) && isalive( var_4 ) )
        {
            if ( isdefined( self.attacker ) && isdefined( self.attacker.team ) && self.attacker.team == var_4.team )
            {
                var_4 maps\mp\_movers::mover_suicide();
                continue;
            }

            self.clip_down._ID19214 = self._ID19214;
            var_4 dodamage( var_4.health + 500, var_4.origin, self.attacker, self.clip_down, "MOD_CRUSH" );
        }
    }

    foreach ( var_7 in level._ID25810 )
    {
        if ( var_7 istouching( self.clip_down ) )
            var_7 notify( "death" );
    }

    var_9 = getent( "tree_base_clip", "targetname" );

    if ( isdefined( var_9 ) )
        var_9 delete();
}

playsound_wrapper( var_0 )
{
    self playsound( var_0 );
}

_ID20238()
{
    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
        return;

    _ID20239();
    wait 0.05;
    var_0 = common_scripts\utility::_ID15386( "logpile", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::_ID20233 );
}

_ID20239()
{
    level.log_visual_link_joints = [];
    level.log_visual_link_joints["ten_log_roll"] = "j_log_5";
    level.log_anim_lengths = [];
    level.log_anim_lengths["ten_log_roll"] = getanimlength( %mp_prisonbreak_log_roll );
    level._ID20231 = [];
    level._ID20231["ten_log_roll"] = "mp_prisonbreak_log_roll";

    foreach ( var_2, var_1 in level._ID20231 )
        precachempanim( var_1 );
}

_ID20233()
{
    self._ID20265 = [];
    self.animated_logs = [];
    self._ID20240 = [];
    self._ID20241 = [];
    self.clip_delete = [];
    self._ID7530 = [];
    self.clip_move = [];
    self.kill_trigger = undefined;
    self.kill_trigger_linked = [];
    var_0 = undefined;
    var_1 = undefined;

    if ( !isdefined( self.angles ) )
        self.angles = ( 0, 0, 0 );

    var_2 = getentarray( self.target, "targetname" );
    var_2 = common_scripts\utility::array_combine( var_2, common_scripts\utility::_ID15386( self.target, "targetname" ) );

    foreach ( var_4 in var_2 )
    {
        if ( !isdefined( var_4.script_noteworthy ) )
            continue;

        switch ( var_4.script_noteworthy )
        {
            case "log_with_use_visuals":
                var_0 = var_4;
            case "log":
                self._ID20265[self._ID20265.size] = var_4;

                if ( isdefined( var_4.target ) )
                    var_4.endpos = common_scripts\utility::_ID15384( var_4.target, "targetname" );

                continue;
            case "animated_log_use_visuals":
                var_0 = var_4;

                if ( isdefined( var_4._ID27443 ) )
                    var_1 = level.log_visual_link_joints[var_4._ID27443];

                thread log_pile_support_damage_watch( var_4 );
            case "animated_log":
                if ( isdefined( var_4._ID27443 ) && isdefined( level._ID20231[var_4._ID27443] ) )
                    self.animated_logs[self.animated_logs.size] = var_4;

                continue;
            case "log_support":
                self._ID20240[self._ID20240.size] = var_4;
                thread log_pile_support_damage_watch( var_4 );
                continue;
            case "log_support_broken":
                self._ID20241[self._ID20241.size] = var_4;
                var_4 hide();
                continue;
            case "clip_delete":
                self.clip_delete[self.clip_delete.size] = var_4;
                continue;
            case "clip_move":
                if ( isdefined( var_4.target ) )
                {
                    var_4._ID11571 = common_scripts\utility::_ID15384( var_4.target, "targetname" );

                    if ( isdefined( var_4._ID11571 ) && isdefined( var_4._ID11571.target ) )
                    {
                        var_4._ID31356 = common_scripts\utility::_ID15384( var_4._ID11571.target, "targetname" );

                        if ( isdefined( var_4._ID31356 ) )
                        {
                            var_4._ID21565 = var_4._ID11571.origin - var_4._ID31356.origin;

                            if ( var_4 is_dynamic_path() )
                                var_4 connectpaths();

                            var_4.origin = var_4.origin - var_4._ID21565;
                            self.clip_move[self.clip_move.size] = var_4;
                        }
                    }
                }

                continue;
            case "clip_show":
                self._ID7530[self._ID7530.size] = var_4;
                var_4 hide();
                var_4 notsolid();
                continue;
            case "kill_trigger":
                self.kill_trigger = var_4;

                if ( isdefined( self.kill_trigger.target ) )
                {
                    self.kill_trigger._ID31356 = common_scripts\utility::_ID15384( self.kill_trigger.target, "targetname" );

                    if ( isdefined( self.kill_trigger._ID31356 ) && isdefined( self.kill_trigger._ID31356.target ) )
                    {
                        self.kill_trigger._ID11571 = common_scripts\utility::_ID15384( self.kill_trigger._ID31356.target, "targetname" );

                        if ( isdefined( self.kill_trigger._ID11571 ) )
                        {
                            self.kill_trigger.script_mover = spawn( "script_model", self.kill_trigger._ID31356.origin );
                            self.kill_trigger.script_mover setmodel( "tag_origin" );
                            self.kill_trigger enablelinkto();
                            self.kill_trigger linkto( self.kill_trigger.script_mover, "tag_origin" );
                        }
                    }
                }

                continue;
            case "kill_trigger_link":
                self.kill_trigger_linked[self.kill_trigger_linked.size] = var_4;
                continue;
            case "use_icon":
                self._ID34706 = var_4.origin;
                self._ID34705 = var_4.angles;
                continue;
            case "killcam":
                self._ID19214 = spawn( "script_model", var_4.origin );
                self._ID19214 setmodel( "tag_origin" );
            default:
                continue;
        }
    }

    if ( isdefined( self.kill_trigger ) && isdefined( self.kill_trigger.script_mover ) )
    {
        if ( isdefined( self._ID19214 ) )
            self.kill_trigger.script_mover._ID19214 = self._ID19214;
        else
            self.kill_trigger.script_mover._ID19214 = self.kill_trigger.script_mover;
    }

    if ( isdefined( var_0 ) )
    {
        foreach ( var_7 in self.kill_trigger_linked )
        {
            var_7._ID19214 = self._ID19214;
            var_7 enablelinkto();
            var_7.no_moving_platfrom_unlink = 1;
            var_7 linkto( var_0, var_7._ID27766 );
        }
    }

    self.nodes = getnodearray( self.target, "targetname" );

    foreach ( var_10 in self.nodes )
        var_10 disconnectnode();

    if ( ( self._ID20265.size || self.animated_logs.size ) && self._ID20240.size > 0 )
    {
        thread _ID20236();
        thread _ID33427();
    }

    if ( isdefined( var_0 ) && isdefined( self._ID34708 ) )
    {
        if ( isdefined( var_1 ) )
            self._ID34708 linkto( var_0, var_1 );
        else
            self._ID34708 linkto( var_0 );
    }
}

log_pile_support_damage_watch( var_0 )
{
    self endon( "trap_activated" );
    var_1 = 1000000;
    var_0.health = var_1;
    var_0 setcandamage( 1 );

    for (;;)
    {
        var_0 waittill( "damage",  var_2, var_3, var_4, var_5, var_6  );
        var_0.health = var_1;

        if ( _ID18413( var_6 ) && var_2 >= 10 )
        {
            self.owner = var_3;
            break;
        }
    }

    var_0 setcandamage( 0 );
    self notify( "trap_activated" );
}

_ID20236()
{
    self waittill( "trap_activated" );
    trap_set_can_use( 0 );
    var_0 = 2.3;
    thread _ID20234( self.kill_trigger );

    foreach ( var_2 in self.kill_trigger_linked )
        thread _ID20234( var_2 );

    thread _ID20235( var_0 );
    common_scripts\utility::_ID3867( self._ID20240, maps\mp\_movers::notify_moving_platform_invalid );
    common_scripts\utility::array_call( self._ID20240, ::delete );
    common_scripts\utility::array_call( self._ID20241, ::show );
    common_scripts\utility::_ID3867( self.clip_delete, maps\mp\_movers::notify_moving_platform_invalid );
    common_scripts\utility::array_call( self.clip_delete, ::delete );
    common_scripts\utility::array_call( self._ID7530, ::show );
    common_scripts\utility::array_call( self._ID7530, ::solid );

    foreach ( var_5 in self.clip_move )
    {
        if ( var_5 is_dynamic_path() )
            var_5 common_scripts\utility::delaycall( var_0, ::disconnectpaths );

        var_5 thread log_pile_clip_move( 1.5, 0.5 );
    }

    if ( isdefined( self.kill_trigger ) && isdefined( self.kill_trigger.script_mover ) )
        self.kill_trigger.script_mover moveto( self.kill_trigger._ID11571.origin, var_0, var_0 * 0.5, 0 );

    foreach ( var_8 in self._ID20265 )
    {
        if ( isdefined( var_8.endpos ) )
        {
            var_8 moveto( var_8.endpos.origin, var_0, var_0 * 0.5, 0 );
            var_9 = var_8.endpos.angles - var_8.angles;
            var_9 = _ID22139( var_9 );
            var_9 += ( 1440, 0, 0 );
            var_10 = var_9 / var_0;
            var_8 rotatevelocity( var_10, var_0, var_0 * 0.5, 0 );
        }
    }

    foreach ( var_13 in self.animated_logs )
    {
        var_13 maps\mp\_movers::notify_moving_platform_invalid();
        var_13 scriptmodelplayanimdeltamotion( level._ID20231[var_13._ID27443] );
        var_14 = ( -20000, 0, 9000 );
        var_15 = ( 0, 0, 50 );
        var_16 = getent( "care_package_delete_volume", "targetname" );
        maps\mp\killstreaks\_airdrop::_ID32935( var_13, var_15, var_14, var_16 );
        var_17 = level.log_anim_lengths[var_13._ID27443];

        if ( isdefined( var_17 ) && var_17 > var_0 )
            var_0 = var_17;
    }

    if ( isdefined( self.animated_logs ) && self.animated_logs.size > 0 )
        self.animated_logs[0] playsoundonmovingent( "scn_prison_logtrap_logs_roll" );

    wait(var_0);
    self notify( "log_roll_done" );
    wait 0.05;

    foreach ( var_20 in self.nodes )
        var_20 connectnode();
}

log_pile_clip_move( var_0, var_1 )
{
    wait(var_0);
    self moveto( self.origin + self._ID21565, var_1 );
}

_ID20234( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    self endon( "log_roll_end_kill_trigger" );

    for (;;)
    {
        var_0 waittill( "trigger",  var_1  );

        if ( !_ID20232( var_1 ) )
            continue;

        var_2 = var_0;

        if ( isdefined( var_0.script_mover ) )
            var_2 = var_0.script_mover;

        var_3 = self.owner;

        if ( isagent( var_1 ) && isdefined( var_1.owner ) && isdefined( var_3 ) && var_1.owner == var_3 )
        {
            var_1 maps\mp\_movers::mover_suicide();
            continue;
        }

        var_2._ID19214 = self._ID19214;
        var_2 radiusdamage( var_1.origin, 8, 1000, 1000, var_3, "MOD_CRUSH", "none" );
    }
}

_ID20235( var_0 )
{
    wait(var_0);
    self notify( "log_roll_end_kill_trigger" );
}

_ID20232( var_0 )
{
    return 1;
}

falling_rocks()
{
    var_0 = getentarray( "falling_rock", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::falling_rock_init );
}

falling_rock_init()
{
    self.fall_to = [];
    self.clip_move = [];
    var_0 = getentarray( self.target, "targetname" );
    var_1 = common_scripts\utility::_ID15386( self.target, "targetname" );
    var_0 = common_scripts\utility::array_combine( var_0, var_1 );

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.script_noteworthy ) )
            continue;

        switch ( var_3.script_noteworthy )
        {
            case "kill_trigger":
                var_3 enablelinkto();
                var_3 linkto( self );
                self.kill_trigger = var_3;
                continue;
            case "rock_clip":
                var_3 linkto( self );
                self._ID7525 = var_3;
                continue;
            case "fall_to":
                self.fall_to[self.fall_to.size] = var_3;
                var_3._ID12691 = distance( self.origin, var_3.origin );

                for ( self._ID12691 = var_3._ID12691; isdefined( var_3.target ); self._ID12691 = self._ID12691 + var_3._ID12691 )
                {
                    var_4 = var_3;
                    var_3 = common_scripts\utility::_ID15384( var_3.target, "targetname" );

                    if ( !isdefined( var_3 ) )
                        break;

                    self.fall_to[self.fall_to.size] = var_3;
                    var_3._ID12691 = distance( var_4.origin, var_3.origin );
                }

                continue;
            case "clip_move":
                if ( isdefined( var_3.target ) )
                {
                    var_3._ID11571 = common_scripts\utility::_ID15384( var_3.target, "targetname" );

                    if ( isdefined( var_3._ID11571 ) && isdefined( var_3._ID11571.target ) )
                    {
                        var_3._ID31356 = common_scripts\utility::_ID15384( var_3._ID11571.target, "targetname" );

                        if ( isdefined( var_3._ID31356 ) )
                        {
                            var_3._ID21565 = var_3._ID11571.origin - var_3._ID31356.origin;
                            var_3.origin = var_3.origin - var_3._ID21565;

                            if ( var_3 is_dynamic_path() )
                                var_3 connectpaths();

                            self.clip_move[self.clip_move.size] = var_3;
                        }
                    }
                }

                continue;
            default:
                continue;
        }
    }

    thread _ID12751();
    thread falling_rock_run();
}

is_dynamic_path()
{
    return isdefined( self.spawnflags ) && self.spawnflags & 1;
}

_ID12751()
{
    var_0 = 1000000;
    self.health = var_0;
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage",  var_1, var_2, var_3, var_4, var_5  );
        self.health = var_0;

        if ( _ID18413( var_5 ) )
        {
            self.attacker = var_2;
            break;
        }
    }

    self setcandamage( 0 );
    self notify( "rock_fall" );
}

falling_rock_run()
{
    self waittill( "rock_fall" );
    var_0 = 1.0;
    thread falling_rock_kill_trigger();
    var_1 = 1;

    for ( var_2 = 0; var_2 < self.fall_to.size; var_2++ )
    {
        var_3 = self.fall_to[var_2];
        var_4 = var_3._ID12691 / self._ID12691 * var_0;
        self moveto( var_3.origin, var_4, var_4 * var_1, 0 );
        self rotateto( var_3.angles, var_4, var_4 * var_1, 0 );

        if ( var_2 == self.fall_to.size - 1 )
        {
            foreach ( var_6 in self.clip_move )
            {
                if ( var_6 is_dynamic_path() )
                    var_6 common_scripts\utility::delaycall( var_4, ::disconnectpaths );

                var_6 moveto( var_6.origin + var_6._ID21565, var_4 );
            }
        }

        self waittill( "movedone" );
        var_1 = 0;
    }

    self notify( "rock_move_done" );
    self._ID7525 delete();
    self.kill_trigger delete();
}

falling_rock_kill_trigger()
{
    self endon( "death" );
    self endon( "rock_move_done" );

    for (;;)
    {
        self.kill_trigger waittill( "trigger",  var_0  );
        radiusdamage( var_0.origin, 8, 1000, 1000, self.attacker, "MOD_CRUSH" );
    }
}

_ID26351()
{
    _ID26353();
    wait 0.05;
    var_0 = common_scripts\utility::_ID15386( "rock_slide", "targetname" );
    common_scripts\utility::_ID3867( var_0, ::_ID26352 );
}

_ID26353()
{

}

_ID26352()
{
    self._ID15813 = [];
    self._ID26362 = [];
    var_0 = getentarray( self.target, "targetname" );
    var_1 = 1;

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.script_noteworthy ) )
            continue;

        switch ( var_3.script_noteworthy )
        {
            case "ground":
                if ( isdefined( var_3.target ) && !var_1 )
                {
                    var_3._ID31356 = common_scripts\utility::_ID15384( var_3.target, "targetname" );

                    if ( isdefined( var_3._ID31356 ) && isdefined( var_3._ID31356.target ) )
                    {
                        var_3._ID11571 = common_scripts\utility::_ID15384( var_3._ID31356.target, "targetname" );

                        if ( isdefined( var_3._ID11571 ) )
                        {
                            var_3._ID21567 = spawn( "script_model", var_3._ID31356.origin );
                            var_3._ID21567 setmodel( "tag_origin" );
                            var_3._ID21567.angles = var_3._ID31356.angles;
                            var_3 linkto( var_3._ID21567 );
                            self._ID15813[self._ID15813.size] = var_3;
                            var_3._ID21564 = isdefined( var_3._ID11571.script_noteworthy ) && var_3._ID11571.script_noteworthy == "delete";
                        }
                    }
                }

                continue;
            case "rock":
                if ( var_1 )
                    var_3 delete();
                else
                {
                    var_3._ID11571 = common_scripts\utility::_ID15384( var_3.target, "targetname" );

                    if ( isdefined( var_3._ID11571 ) )
                    {
                        self._ID26362[self._ID26362.size] = var_3;
                        var_3._ID21564 = isdefined( var_3._ID11571.script_noteworthy ) && var_3._ID11571.script_noteworthy == "delete";
                    }
                }

                continue;
            default:
                continue;
        }
    }

    if ( !var_1 )
    {
        common_scripts\utility::_ID3867( self._ID15813, ::_ID26349, self );
        thread _ID26350();
    }

    thread _ID33427( var_1 );
}

_ID26349( var_0 )
{
    var_0 endon( "trap_activated" );
    var_1 = 1000000;
    self.health = var_1;
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage",  var_2, var_3, var_4, var_5, var_6  );
        self.health = var_1;

        if ( _ID18413( var_6 ) )
        {
            self.attacker = var_3;
            break;
        }
    }

    self setcandamage( 0 );
    var_0 notify( "trap_activated" );
}

_ID26350()
{
    self waittill( "trap_activated" );
    earthquake( 0.4, 3, self.origin, 800 );
    var_0 = 1.5;

    foreach ( var_2 in self._ID26362 )
    {
        var_2 moveto( var_2._ID11571.origin, var_0, var_0, 0 );
        var_2 rotateto( var_2._ID11571.angles, var_0, var_0, 0 );

        if ( var_2._ID21564 )
            var_2 common_scripts\utility::delaycall( var_0, ::delete );
    }

    wait 0.5;
    var_4 = 1;

    foreach ( var_6 in self._ID15813 )
    {
        var_6._ID21567 moveto( var_6._ID11571.origin, var_4, var_4, 0 );
        var_6._ID21567 rotateto( var_6._ID11571.angles, var_4, var_4, 0 );

        if ( var_6._ID21564 )
            var_6 common_scripts\utility::delaycall( var_0, ::delete );
    }
}

hand_icon( var_0, var_1, var_2, var_3 )
{
    if ( level._ID8425 )
        return;

    if ( !isdefined( level.hand_icon_count ) )
        level.hand_icon_count = 0;

    level.hand_icon_count++;
    var_4 = "hand_icon_" + level.hand_icon_count;
    _ID16015( var_0, var_1, var_2, var_4, var_3 );

    foreach ( var_6 in level.players )
    {
        if ( isdefined( var_6.hand_icons ) && isdefined( var_6.hand_icons[var_4] ) )
            var_6.hand_icons[var_4] thread _ID16014();
    }
}

_ID16015( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_4 ) )
    {
        if ( isstring( var_4 ) )
            var_4 = [ var_4 ];

        foreach ( var_6 in var_4 )
            self endon( var_6 );
    }

    while ( !isdefined( level.players ) )
        wait 0.05;

    var_8 = 200;
    var_9 = "hint_usable";
    var_10 = 0;

    switch ( var_0 )
    {
        default:
            break;
    }

    var_11 = undefined;

    if ( isdefined( var_2 ) )
        var_11 = anglestoforward( var_2 );

    var_12 = var_8 * var_8;

    for (;;)
    {
        foreach ( var_14 in level.players )
        {
            if ( !isdefined( var_14.hand_icons ) )
                var_14.hand_icons = [];

            var_15 = var_14.origin + ( 0, 0, 50 );
            var_16 = distancesquared( var_15, var_1 );
            var_17 = 1;

            if ( isdefined( var_11 ) )
            {
                var_18 = vectornormalize( var_15 - var_1 );
                var_17 = vectordot( var_11, var_18 ) > 0.2;
            }

            if ( var_16 <= var_12 && var_17 && ( !isdefined( self._ID17490 ) || !self._ID17490 ) && !var_14 maps\mp\_utility::_ID18837() )
            {
                if ( !isdefined( var_14.hand_icons[var_3] ) )
                {
                    var_14.hand_icons[var_3] = _ID16012( var_14, var_9, var_1, var_10 );
                    var_14.hand_icons[var_3].alpha = 0;
                }

                var_14.hand_icons[var_3] notify( "stop_fade" );
                var_14.hand_icons[var_3] thread _ID16013();
                continue;
            }

            if ( isdefined( var_14.hand_icons[var_3] ) )
                var_14.hand_icons[var_3] thread _ID16014();
        }

        wait 0.05;
    }
}

_ID16012( var_0, var_1, var_2, var_3 )
{
    var_1 = var_0 maps\mp\gametypes\_hud_util::_ID8444( var_1, 16, 16 );
    var_1 setwaypoint( 1, var_3 );
    var_1.x = var_2[0];
    var_1.y = var_2[1];
    var_1.z = var_2[2];
    return var_1;
}

_ID16013()
{
    self endon( "death" );

    if ( self.alpha == 1 )
        return;

    self fadeovertime( 0.5 );
    self.alpha = 1;
}

_ID16014()
{
    self endon( "death" );
    self endon( "stop_fade" );

    if ( self.alpha == 0 )
        return;

    var_0 = 0.5;
    self fadeovertime( var_0 );
    self.alpha = 0;
    wait(var_0);
    self destroy();
}

tower_radio()
{
    var_0 = getent( "tower_radio", "targetname" );
    var_0._ID33312 = [];
    var_0._ID33312[0] = "mus_emt_portable_radio_01";
    var_0._ID33312[1] = "mus_emt_portable_radio_02";
    var_0._ID33312[2] = "mus_emt_portable_radio_03";
    maps\mp\_utility::gameflagwait( "prematch_done" );
    var_0 thread _ID33216();
    var_0 endon( "death" );

    for (;;)
    {
        level waittill( "connected",  var_1  );
        var_0 thread _ID33217( var_1 );
    }
}

_ID33216()
{
    self.health = 10000;
    self setcandamage( 1 );
    self waittill( "damage",  var_0, var_1, var_2, var_3, var_4  );
    self playsound( "radio_destroyed_static" );
    self physicslaunchclient( var_3, var_2 );
}

_ID33217( var_0 )
{
    self endon( "damage" );
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_0 waittill( "spawned_player" );
    common_scripts\utility::_ID35582();
    var_1 = "";

    for (;;)
    {
        for ( var_2 = var_1; var_2 == var_1; var_2 = common_scripts\utility::_ID25350( self._ID33312 ) )
        {

        }

        var_3 = lookupsoundlength( var_2 ) / 1000;

        if ( var_3 < 0.1 )
            wait 5.0;
        else
            self playsoundtoplayer( var_2, var_0 );

        wait(var_3);
        var_1 = var_2;
    }
}
