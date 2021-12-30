// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    _ID38257();
    _ID38258();
}

_ID38258()
{
    thread _ID36815();
}

_ID38148()
{

}

_ID38257()
{
    precachemodel( "mp_body_us_rangers_assault_a_urban" );
    precachemodel( "head_mp_head_a" );
    precachemodel( "body_extinction_civ_female_a" );
    precachemodel( "head_extinction_civ_female_a" );
}

_ID37041()
{
    _ID37097( 20 );
    var_0 = getent( "crossarcher_lab_doors", "targetname" );
    thread _ID37588();
    var_1 = spawn( "script_model", ( -600, -1561, 720 ) );
    var_1 setmodel( "body_cross_a" );
    var_1.angles = ( 0, 0, 0 );
    var_2 = _ID30711( "head_cross_a", var_1, "J_spine4", ( 0, 0, 0 ) );
    wait 0.25;
    var_3 = spawn( "script_model", var_1 gettagorigin( "tag_weapon_right" ) );
    var_3.angles = var_1 gettagangles( "tag_weapon_right" );
    var_3 setmodel( "weapon_mp443" );
    var_3 linkto( var_1, "tag_weapon_right" );
    thread lab_doors_open();
    var_0 scriptmodelplayanim( "alien_armory_doors_roomvignette_init" );
    thread handle_vo_foley( var_1, "scn_female_glass_hit", 0.46 );
    thread handle_vo_foley( var_1, "scn_female_glass_hit", 1.33 );
    thread handle_vo_foley( var_1, "scn_female_glass_hit", 1.666 );
    thread handle_vo_foley( var_1, "scn_female_glass_hit", 2.2 );
    thread handle_vo_foley( var_1, "scn_female_glass_hit", 3.56 );
    thread handle_vo_foley( var_1, "scn_female_glass_hit", 4.93 );
    thread handle_vo_foley( var_1, "scn_female_glass_hit", 5.6 );
    thread handle_vo_foley( var_1, "scn_female_glass_hit", 6.33 );
    thread handle_vo_foley( var_1, "scn_female_glass_hit", 7.8 );
    thread handle_vo_foley( var_1, "scn_female_glass_hit", 9.06 );
    thread handle_vo_foley( var_1, "scn_female_glass_hit", 10 );
    thread handle_vo_foley( var_1, "scn_female_glass_hit", 11.133 );
    thread handle_vo_foley( var_1, "scn_female_foley_hand_slide", 2 );
    var_1 scriptmodelplayanimdeltamotion( "alien_armory_cross_roomvignette_init" );
    var_2 scriptmodelplayanim( "alien_armory_cross_roomvignette_init" );
    thread maps\mp\mp_alien_armory_fx::_ID37231();
    thread maps\mp\alien\_music_and_dialog::pause_vo_system( level.players );
    var_4 = getent( "stop_cross_idle", "targetname" );
    var_4 thread _ID37042( var_1 );
    wait 12.33;
    thread maps\mp\mp_alien_armory_fx::_ID37229();
    var_5 = spawn( "script_model", ( -425, -1860, 720 ) );
    var_5 setmodel( "body_archer_a" );
    var_5.angles = ( 0, 0, 0 );
    var_6 = _ID30711( "head_archer_a", var_5, "J_spine4", ( 0, 0, 0 ) );
    var_7 = spawn( "script_model", var_5 gettagorigin( "tag_weapon_right" ) );
    var_7.angles = var_5 gettagangles( "tag_weapon_right" );
    var_7 setmodel( "weapon_mp443" );
    var_7 linkto( var_5, "tag_weapon_right" );
    var_7 thread _ID37587();
    thread _ID37590( var_1, var_5 );
    thread _ID36695();
    thread _ID37586();
    var_1 scriptmodelplayanimdeltamotion( "alien_armory_cross_roomvignette" );
    var_2 scriptmodelplayanim( "alien_armory_cross_roomvignette" );
    thread handle_vo_foley( var_1, "scn_female_foley_hand_slide", 1.5666 );
    thread handle_vo_foley( var_1, "scn_female_foley_gun_pickup_raise", 8.2666 );
    thread handle_vo_foley( var_1, "scn_female_foley_getting_shot", 16.833 );
    thread handle_vo_foley( var_3, "scn_female_foley_gun_drop", 17.466 );
    thread handle_vo_foley( var_1, "scn_female_foley_getting_pickedup", 20.166 );
    thread handle_vo_foley( var_5, "scn_male_button_slam", 28.3 );
    var_5 scriptmodelplayanimdeltamotion( "alien_armory_archer_roomvignette" );
    var_6 scriptmodelplayanim( "alien_armory_archer_roomvignette" );
    thread handle_vo_foley( var_5, "scn_male_enter", 13.73 );
    thread handle_vo_foley( var_5, "scn_male_approach", 17.933 );
    thread handle_vo_foley( var_5, "scn_male_exit", 27.95 );
    thread handle_vo_foley( var_5, "scn_male_button_slam", 28.3 );
    thread handle_vo_foley( var_5, "scn_male_door_open", 13.2 );
    thread handle_vo_foley( var_5, "scn_male_post_lift", 24.06 );
    thread handle_vo_foley( var_5, "scn_male_slap", 21.133 );
    var_0 scriptmodelplayanim( "alien_armory_doors_roomvignette" );
    wait 35;
    var_3 delete();
    var_7 delete();
    var_1 delete();
    var_2 delete();
    var_5 delete();
    var_6 delete();
    thread maps\mp\alien\_music_and_dialog::unpause_vo_system( level.players );
}

_ID37585()
{
    playsoundatpos( ( -291, -1665, 846 ), "scn_arm_mtl_roll_door_alarm" );
}

lab_doors_open()
{
    playsoundatpos( ( -668, -1434, 816 ), "scn_arm_mtl_door_roll_open_l" );
    playsoundatpos( ( -668, -1723, 816 ), "scn_arm_mtl_door_roll_open_r" );
}

_ID37586()
{
    wait 28.6333;
    playsoundatpos( ( -668, -1434, 816 ), "scn_arm_mtl_roll_door_l" );
    playsoundatpos( ( -668, -1723, 816 ), "scn_arm_mtl_roll_door_r" );
}

_ID37587()
{
    wait 17.33;
    thread maps\mp\mp_alien_armory_fx::_ID37228();
    self playsound( "scn_cross_gunshot" );
}

_ID36695()
{
    var_0 = maps\mp\gametypes\aliens::addalienagent( "axis", ( -420, -1867, 594 ), ( 0, 0, 0 ), "wave brute", undefined );
    var_0 maps\mp\alien\_unk1464::_ID11418();
    var_0 scragentsetscripted( 1 );
    var_0.no_outline_on_alien = 1;
    var_0 scragentsetphysicsmode( "noclip" );
    var_0 scragentsetorientmode( "face angle abs", var_0.angles );
    var_0 thread _ID36720( 0 );
    thread _ID37784( 33.3666, "scn_cross_left_alien_vocals", var_0.origin, var_0 );
    thread _ID37784( 30.966, "scn_cross_left_alien_door_burst", ( -475, -1332, 780 ), undefined );
    var_1 = maps\mp\gametypes\aliens::addalienagent( "axis", ( -464, -1270, 720 ), ( 0, 0, 0 ), "wave brute", undefined );
    var_1 maps\mp\alien\_unk1464::_ID11418();
    var_1 scragentsetscripted( 1 );
    var_1.no_outline_on_alien = 1;
    var_1 scragentsetphysicsmode( "noclip" );
    var_1 scragentsetorientmode( "face angle abs", var_1.angles );
    var_1 thread _ID36720( 1 );
    thread _ID37784( 31.8333, "scn_cross_right_alien_door_burst", ( -428, -1806, 780 ), undefined );
    thread _ID37784( 33.1666, "scn_cross_right_alien_vocals", var_1.origin, var_1 );
}

_ID37784( var_0, var_1, var_2, var_3 )
{
    wait(var_0);

    if ( !isdefined( var_3 ) )
        playsoundatpos( var_2, var_1 );
    else
        var_3 playsoundonmovingent( var_1 );
}

_ID36720( var_0 )
{
    self scragentsetanimmode( "anim deltas" );
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "armory_vignettes", var_0, "armory_vignettes", "end" );
    wait 5;
    self hide();
    self suicide();
}

_ID37040()
{
    var_0 = [];
    var_1 = getent( "archer_escape", "targetname" );
    var_1 waittill( "trigger" );
    var_2 = maps\mp\agents\alien\_alien_human::_ID36694( ( -2903.6, 1437, 663.2 ), ( 0, 107.554, 0 ), "body_cross_a", "head_cross_a" );
    var_2 scragentsetscripted( 1 );
    var_2 scragentsetphysicsmode( "noclip" );
    var_2 scragentsetorientmode( "face angle abs", var_2.angles );
    var_3 = maps\mp\agents\alien\_alien_human::_ID36694( ( -2904.4, 1442.5, 663.2 ), ( 0, -12.343, 0 ), "body_archer_a", "head_archer_a" );
    var_3 scragentsetscripted( 1 );
    var_3 scragentsetphysicsmode( "noclip" );
    var_3 scragentsetorientmode( "face angle abs", var_3.angles );
    var_4 = spawn( "script_model", ( -2700.3, 1514.7, 663.5 ) );
    var_4 setmodel( "vehicle_gaz71_iw6_dlc" );
    var_4.angles = ( 0, 33.871, 0 );
    thread _ID37198();
    var_4 thread archer_exfil_sfx_spawn();
    var_4 scriptmodelplayanimdeltamotion( "alien_armory_gaz71_exit_facility" );
    thread gate_close();
    var_2 thread _ID36721( 2 );
    var_3 _ID36721( 3 );
    var_4 delete();
}

archer_exfil_sfx_spawn()
{
    wait 0.02;
    self playsoundonmovingent( "scn_archer_exfil" );
}

gate_close()
{
    wait 12;
    var_0 = getent( "rolling_gate", "targetname" );

    if ( isdefined( var_0 ) )
    {
        var_0 thread archer_exfil_gate_close_sfx_spawn();
        var_0 moveto( ( -648, 1956, 592 ), 2, 0, 1 );
    }
}

archer_exfil_gate_close_sfx_spawn()
{
    wait 0.02;
    self playsoundonmovingent( "scn_archer_exfil_gate_close" );
}

_ID36721( var_0, var_1 )
{
    self scragentsetanimmode( "anim deltas" );
    maps\mp\agents\alien\_alien_human::_ID37790( "idle", var_0 );
    self hide();

    if ( isdefined( var_1 ) && var_1 == 1 )
        return;

    self suicide();
    return;
}

_ID36815()
{
    thread intro_music();
    wait 2;
    var_0 = getentarray( "intro_fence", "targetname" );
    var_1 = getscriptablearray( "intro_fence_script", "targetname" );
    _ID18292();
    var_2 = spawn( "script_model", ( -2160, -7364.86, 607.431 ) );
    var_2 setmodel( "mp_body_us_rangers_assault_a_urban" );
    var_2.angles = ( 0, -90, 0 );
    var_3 = spawn( "script_model", var_2 gettagorigin( "J_spine4" ) );
    var_3.angles = var_2 gettagangles( "J_spine4" );
    var_3 setmodel( "head_mp_head_a" );
    var_3 linkto( var_2, "J_spine4" );
    var_4 = spawn( "script_model", var_2 gettagorigin( "tag_weapon_right" ) );
    var_4.angles = var_2 gettagangles( "tag_weapon_right" );
    var_4 setmodel( "weapon_rm_22" );
    var_4 hidepart( "tag_barrel_sniper", "weapon_rm_22" );
    var_4 linkto( var_2, "tag_weapon_right" );
    thread _ID37863();
    thread _ID38100();
    var_4 thread _ID37393();
    var_2 thread _ID36661();
    var_2 scriptmodelplayanimdeltamotion( "alien_redshirt_intro_tunnel" );
    var_3 scriptmodelplayanim( "alien_redshirt_intro_tunnel" );
    var_1[0] setscriptablepartstate( 0, 2 );
    level._ID37247 = 1;
    thread _ID38009();
    wait 15.8333;
    thread _ID37578( var_2 );

    foreach ( var_6 in var_0 )
    {
        if ( isdefined( var_6 ) )
            var_6 delete();
    }

    wait 2.93;
    thread pre_set_scriptables();
    var_1[0] setscriptablepartstate( 0, 3 );
    _ID37384();
}

_ID37393()
{
    wait 15.866;
    self unlink();
    var_0 = common_scripts\utility::_ID15386( "item", "targetname" );
    var_1 = undefined;

    foreach ( var_3 in var_0 )
    {
        if ( var_3.script_noteworthy == "weapon_iw6_aliendlc15_mp" )
        {
            var_1 = var_3._ID34703;
            break;
        }
    }

    var_1.origin = self.origin + ( 0, 0, 5 );
    var_1.angles = self.angles;
    var_1 hidepart( "tag_barrel_sniper", "weapon_rm_22" );
    self delete();
}

_ID36661()
{
    wait 18;
    var_0 = spawn( "script_origin", self.origin );
    var_1 = -50;
    var_2 = 50;
    var_3 = var_0.origin;
    var_0.origin = var_3 + ( var_1 + randomint( 40 ), var_2 + randomint( 40 ), 0 );
    var_0 thread maps\mp\mp_alien_armory::_ID37031( "clip", level.pillageinfo._ID36975, 1 );
    var_0.origin = var_3 + ( var_1 + randomint( 40 ), var_2 + randomint( 40 ), 0 );
    var_0 thread maps\mp\mp_alien_armory::_ID37031( "clip", level.pillageinfo._ID36975, 1 );
    var_0.origin = var_3 + ( var_1 + randomint( 40 ), var_2 + randomint( 40 ), 0 );
    var_0 thread maps\mp\mp_alien_armory::_ID37031( "explosive", "tag_origin", 1, "aliensemtex_mp", 2 );
    var_0.origin = var_3 + ( var_1 + randomint( 40 ), var_2 + randomint( 40 ), 0 );
    var_0 thread maps\mp\mp_alien_armory::_ID37031( "explosive", "tag_origin", 1, "aliensemtex_mp", 2 );
}

_ID38100()
{
    var_0 = maps\mp\agents\alien\alien_spider\_alien_spider::_ID36701( ( -2375, -7784.86, 977.432 ), ( 0, 0, 0 ) );
    var_0 maps\mp\alien\_unk1464::_ID28196( 0.2, 1 );
    var_0 maps\mp\alien\_unk1464::_ID11418();
    var_0 scragentsetscripted( 1 );
    var_0 scragentsetphysicsmode( "noclip" );
    var_0 scragentsetorientmode( "face angle abs", var_0.angles );
    var_0 scragentsetanimmode( "anim deltas" );
    var_0 thread maps\mp\mp_alien_armory_fx::_ID37233();
    var_0 maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "tunnel_intro", 0, "tunnel_intro", "end" );
    var_0 maps\mp\alien\_unk1464::_ID28196( 0.2, 0 );
    var_0 hide();
    var_0._ID38256 = 1;
    var_0 maps\mp\agents\alien\alien_spider\_alien_spider::_ID36698();
    var_0 suicide();
}

_ID38009()
{
    wait 4;
    level._ID38010 = spawn( "script_origin", ( -2290, -7778, 664 ) );
    level._ID38010 playsound( "scn_intro_guard" );
    wait 3.3;

    foreach ( var_1 in level.players )
        var_1 playsound( "scn_intro_spider" );

    wait 15;
    level._ID38010 delete();
}

_ID37213()
{
    var_0 = getscriptablearray( "fence_blocker_01", "targetname" );
    var_0[0] setscriptablepartstate( 0, 1 );
}

_ID37578( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( distance( var_2.origin, var_0.origin ) <= 128 )
        {
            var_2 setvelocity( vectornormalize( var_2.origin - var_0.origin ) * 800 );
            var_2 dodamage( var_2.maxhealth / 3, var_0.origin );
        }
    }
}

_ID38087()
{
    var_0 = getscriptablearray( "armory_alien_rail_a", "targetname" );
    var_0[0] setscriptablepartstate( 0, 1 );
    var_1 = getscriptablearray( "antenna_retreat_event_a", "targetname" );
    var_1[0] setscriptablepartstate( 0, 1 );
}

_ID38085()
{
    wait 3;
    level._ID38082 = maps\mp\agents\alien\alien_spider\_alien_spider::_ID36701( ( -1138.05, -2542.5, 565.487 ), ( 0, 0, 0 ) );
    level._ID38082 maps\mp\alien\_unk1464::_ID28196( 0.2, 1 );
    level._ID38082 maps\mp\alien\_unk1464::_ID11418();
    level._ID38082 scragentsetscripted( 1 );
    level._ID38082 scragentsetphysicsmode( "noclip" );
    level._ID38082 scragentsetorientmode( "face angle abs", level._ID38082.angles );
    level thread maps\mp\mp_alien_armory_fx::_ID37237();
    level._ID38082 scragentsetanimmode( "anim deltas" );
    var_0 = getscriptablearray( "antenna_event_02", "targetname" );
    var_0[0] setscriptablepartstate( 0, 2 );
    var_1 = getscriptablearray( "armory_alien_rail_b", "targetname" );
    var_1[0] setscriptablepartstate( 0, 2 );
    level._ID38082 maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "retreat", 1, "retreat", "end" );
}

_ID38096()
{

}

_ID38088()
{
    level._ID38082 maps\mp\alien\_unk1464::_ID11418();
    level._ID38082 scragentsetscripted( 1 );
    level._ID38082 scragentsetphysicsmode( "noclip" );
    level._ID38082 scragentsetorientmode( "face angle abs", level._ID38082.angles );
    var_0 = getscriptablearray( "antenna_event_02", "targetname" );
    var_0[0] setscriptablepartstate( 0, 3 );
    var_1 = getscriptablearray( "armory_alien_rail_b", "targetname" );
    var_1[0] setscriptablepartstate( 0, 3 );
    level thread maps\mp\mp_alien_armory_fx::_ID37238();
    level._ID38082 scragentsetanimmode( "anim deltas" );
    level._ID38082 maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "retreat", 2, "retreat", "end" );
    level._ID38082._ID38256 = 1;
    level._ID38082 suicide();
}

_ID38086()
{
    if ( !isdefined( level._ID37572 ) || level._ID37572 == 0 )
    {
        thread _ID37040();
        common_scripts\utility::flag_wait( "start_spider_encounter" );
    }

    wait 10;
    level._ID38082 = maps\mp\agents\alien\alien_spider\_alien_spider::_ID36701( ( -300, 3140, 967 ), ( 0, 0, 0 ) );
    level._ID38082 maps\mp\alien\_unk1464::_ID28196( 0.2, 1 );
    level._ID38082 maps\mp\alien\_unk1464::_ID11418();
    level._ID38082 scragentsetscripted( 1 );
    level._ID38082 scragentsetphysicsmode( "noclip" );
    level._ID38082 scragentsetorientmode( "face angle abs", level._ID38082.angles );
    thread maps\mp\mp_alien_armory_fx::_ID37240();
    level._ID38082 scragentsetanimmode( "anim deltas" );
    wait 0.1;
    level._ID38082 maps\mp\agents\_scriptedagents::playanimnuntilnotetrack( "retreat", 3, "retreat", "end" );
    level._ID38082 maps\mp\alien\_unk1464::_ID10053();
    level._ID38082 scragentsetscripted( 0 );
    level._ID38082 maps\mp\alien\_unk1464::_ID28196( 0.2, 0 );
}

intro_music()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread intro_music_play();
    }
}

intro_music_play()
{
    self waittill( "spawned_player" );

    foreach ( var_1 in level.players )
    {
        if ( common_scripts\utility::_ID13177( "alien_music_playing" ) )
        {
            var_1 stoplocalsound( "mp_suspense_01" );
            var_1 stoplocalsound( "mp_suspense_02" );
            var_1 stoplocalsound( "mp_suspense_03" );
            var_1 stoplocalsound( "mp_suspense_04" );
            var_1 stoplocalsound( "mp_suspense_05" );
            var_1 stoplocalsound( "mp_suspense_06" );
            var_1 stoplocalsound( "us_spawn_music" );
            var_1 stoplocalsound( "mus_alien_newwave" );
            common_scripts\utility::_ID13180( "alien_music_playing" );
        }

        if ( !common_scripts\utility::_ID13177( "exfil_music_playing" ) )
            wait 0.01;

        level thread maps\mp\alien\_music_and_dialog::play_alien_music( "mus_alien_dlc1_armory_intro" );
        wait 0.1;
    }
}

_ID18292()
{
    wait 4;
}

_ID37384()
{
    wait 2;
    thread maps\mp\alien\_music_and_dialog::pause_vo_system( level.players );
    play_sound_on_player( "armory_god_2_1_1" );
    wait 12;
    play_sound_on_player( "armory_god_2_1_2" );
    wait 9;
    thread maps\mp\alien\_music_and_dialog::unpause_vo_system( level.players );
}

_ID37382()
{
    _ID37097();
    thread maps\mp\alien\_music_and_dialog::pause_vo_system( level.players );
    play_sound_on_player( "armory_god_2_2_1" );
    wait 10;
    play_sound_on_player( "armory_god_2_2_2" );
    wait 4;
    thread maps\mp\alien\_music_and_dialog::unpause_vo_system( level.players );
    thread _ID37935();
}

_ID37383()
{

}

_ID36727()
{
    var_0 = distance( level.drill.origin, ( -3653, -6322, 859 ) );

    if ( var_0 >= 256 )
    {
        _ID37097( 10 );
        thread maps\mp\alien\_music_and_dialog::pause_vo_system( level.players );
        play_sound_on_player( "armory_god_2_3_1" );
        wait 7.75;
        play_sound_on_player( "armory_god_2_3_2" );
        wait 2.75;
        play_sound_on_player( "armory_god_2_3_3" );
        wait 5;
        thread maps\mp\alien\_music_and_dialog::unpause_vo_system( level.players );
    }
}

_ID37832()
{
    _ID37097();
    wait 5;
    thread maps\mp\alien\_music_and_dialog::pause_vo_system( level.players );
    play_sound_on_player( "armory_god_5_1" );
    wait 11.25;
    thread maps\mp\alien\_music_and_dialog::unpause_vo_system( level.players );
}

_ID37841()
{
    _ID37097();
    thread maps\mp\alien\_music_and_dialog::pause_vo_system( level.players );
    play_sound_on_player( "armory_cross_5_3" );
    wait 6.8;
    play_sound_on_player( "armory_cross_5_5" );
    wait 2.5;
    play_sound_on_player( "armory_cross_5_6" );
    wait 5.2;
    play_sound_on_player( "armory_cross_5_6_1" );
    wait 2;
    thread _ID37043();
    thread maps\mp\alien\_music_and_dialog::unpause_vo_system( level.players );
}

_ID37043()
{
    var_0 = getent( "cross_office_VO", "targetname" );
    var_0 waittill( "trigger" );
    thread maps\mp\alien\_music_and_dialog::pause_vo_system( level.players );
    play_sound_on_player( "armory_cross_6_2" );
    wait 5.5;
    play_sound_on_player( "armory_cross_6_3" );
    wait 2.25;
    play_sound_on_player( "armory_cross_6_4" );
    wait 2.5;
    play_sound_on_player( "armory_cross_6_8" );
    wait 3.5;
    var_0 delete();
    thread maps\mp\alien\_music_and_dialog::unpause_vo_system( level.players );
}

_ID37590( var_0, var_1 )
{
    wait 0.8;
    var_0 playsound( "armory_cross_7_6" );
    thread _ID37589();
    wait 1.2;
    var_0 playsound( "armory_cross_7_7" );
    wait 6.46;
    var_0 playsound( "armory_cross_7_8" );
    wait 9.4;
    var_0 playsound( "armory_cross_7_9" );
    wait 3.3;
    var_1 playsound( "armory_arc_7_10" );
    wait 5;
}

_ID37589()
{
    wait 1.2;

    foreach ( var_1 in level.players )
    {
        if ( common_scripts\utility::_ID13177( "alien_music_playing" ) )
        {
            var_1 stoplocalsound( "mp_suspense_01" );
            var_1 stoplocalsound( "mp_suspense_02" );
            var_1 stoplocalsound( "mp_suspense_03" );
            var_1 stoplocalsound( "mp_suspense_04" );
            var_1 stoplocalsound( "mp_suspense_05" );
            var_1 stoplocalsound( "mp_suspense_06" );
            var_1 stoplocalsound( "mus_alien_newwave" );
            common_scripts\utility::_ID13180( "alien_music_playing" );
        }

        level thread maps\mp\alien\_music_and_dialog::play_alien_music( "mus_alien_dlc1_scn_cross" );
    }
}

_ID37198()
{
    thread maps\mp\alien\_music_and_dialog::pause_vo_system( level.players );
    play_sound_on_player( "armory_god_8_1" );
    thread _ID37787();
    wait 4.75;
    play_sound_on_player( "armory_god_8_2" );
    wait 4;
    thread maps\mp\alien\_music_and_dialog::unpause_vo_system( level.players );
}

_ID37787()
{
    wait 3;

    foreach ( var_1 in level.players )
    {
        if ( common_scripts\utility::_ID13177( "alien_music_playing" ) )
        {
            var_1 stoplocalsound( "mp_suspense_01" );
            var_1 stoplocalsound( "mp_suspense_02" );
            var_1 stoplocalsound( "mp_suspense_03" );
            var_1 stoplocalsound( "mp_suspense_04" );
            var_1 stoplocalsound( "mp_suspense_05" );
            var_1 stoplocalsound( "mp_suspense_06" );
            var_1 stoplocalsound( "mus_alien_newwave" );
            common_scripts\utility::_ID13180( "alien_music_playing" );
        }

        if ( !common_scripts\utility::_ID13177( "exfil_music_playing" ) )
            level thread maps\mp\alien\_music_and_dialog::play_alien_music( "mus_alien_dlc1_archer_exfil" );
    }
}

_ID37863()
{
    var_0 = spawn( "script_origin", ( -2304, -7666, 652 ) );
    wait 3.9;
    level notify( "spawn_intro_drill" );
    var_0 playsound( "armory_grd_1_1" );
    wait 2.63;
    var_0 playsound( "armory_grd_1_2" );
    wait 4.47;
    var_0 playsound( "armory_grd_1_3" );
    thread _ID38092( var_0 );
    wait 2.56;
    var_0 playsound( "armory_grd_1_4" );
    common_scripts\utility::flag_set( "intro_sequence_complete" );
    wait 4;
    _ID38093( var_0 );
    var_0 delete();
}

_ID38092( var_0 )
{
    var_1 = 0.1;

    for ( var_2 = 0; var_2 < 6; var_2++ )
    {
        earthquake( var_1, 0.4, var_0.origin, 768 );
        playrumbleonposition( "grenade_rumble", var_0.origin );
        var_1 += 0.05;

        if ( var_2 > 1 )
            common_scripts\utility::exploder( 120 );

        wait 0.6;
    }
}

_ID38093( var_0 )
{
    var_1 = 0.4;

    for ( var_2 = 0; var_2 < 6; var_2++ )
    {
        earthquake( var_1, 0.4, var_0.origin, 768 );
        playrumbleonposition( "grenade_rumble", var_0.origin );
        var_1 -= 0.05;

        if ( var_2 < 3 )
            common_scripts\utility::exploder( 120 );

        wait 0.6;
    }
}

_ID37831()
{
    thread maps\mp\alien\_music_and_dialog::pause_vo_system( level.players );
    wait 11.75;
    play_sound_on_player( "armory_god_9_1" );
    wait 5;
    thread maps\mp\alien\_music_and_dialog::unpause_vo_system( level.players );
}

_ID37042( var_0 )
{
    self endon( "stop_nags" );
    wait 0.7;
    var_0 playsound( "armory_cross_7_1" );
    wait 3.26;
    var_0 playsound( "armory_cross_7_2" );
    wait 2;
    var_0 playsound( "armory_cross_7_3" );
    wait 1.57;
    var_0 playsound( "armory_cross_7_4" );
    wait 1.23;
    var_0 playsound( "armory_cross_7_5" );
}

_ID37935()
{
    var_0 = getent( "security_room_vo_trigger", "targetname" );
    var_0 waittill( "trigger" );
    thread maps\mp\alien\_music_and_dialog::pause_vo_system( level.players );
    var_1 = spawn( "script_origin", ( -3354, -6616, 808 ) );
    var_1 playsound( "armory_arc_3_1" );
    wait 6.5;
    var_1 playsound( "armory_god_3_2" );
    wait 1.5;
    var_1 playsound( "armory_arc_3_3" );
    wait 4.5;
    var_1 playsound( "armory_god_3_4" );
    wait 4.5;
    var_1 playsound( "armory_arc_3_5" );
    wait 5;
    level notify( "cinematic_end" );
    var_1 delete();
    thread maps\mp\alien\_music_and_dialog::unpause_vo_system( level.players );
}

_ID37097( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 30;

    var_1 = gettime();
    var_2 = var_1 - var_0 * 1000;

    while ( var_2 <= var_1 )
    {
        var_2 = var_1 - var_0 * 1000;
        var_3 = 0;

        foreach ( var_5 in level.agentarray )
        {
            if ( isdefined( var_5 ) )
            {
                if ( isalive( var_5 ) )
                {
                    if ( var_5.team == "axis" && isdefined( var_5.alien_type ) && var_5.alien_type != "spider" )
                    {
                        var_3 = 1;
                        break;
                    }
                }
            }
        }

        if ( var_3 == 0 )
            return;

        wait 0.5;
    }
}

_ID37789( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "high";

    if ( !isdefined( var_2 ) )
        var_2 = 30;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_4 ) )
        var_4 = 0.25;

    foreach ( var_6 in level.players )
    {
        var_6 maps\mp\alien\_music_and_dialog::_ID23864( var_0, var_1, var_2, var_3, var_4 );
        break;
    }
}

_ID37246()
{

}

_ID30711( var_0, var_1, var_2, var_3 )
{
    var_4 = spawn( "script_model", ( 0, 0, 0 ) );
    var_4 setmodel( var_0 );
    var_4.origin = var_1 gettagorigin( var_2 );
    var_4.angles = var_1 gettagangles( var_2 ) + var_3;
    var_4 linkto( var_1, var_2 );
    return var_4;
}

_ID37588()
{
    var_0 = "waypoint_alien_blocker";
    var_1 = 14;
    var_2 = 14;
    var_3 = 0.5;
    var_4 = ( -906, -1570, 780 );
    var_5 = 49;
    var_6 = 256;
    var_7 = 100;
    var_8 = maps\mp\alien\_hud::_ID37645( var_0, var_1, var_2, var_3, var_4 );
    var_9 = spawn( "trigger_radius", var_4, 0, var_6, var_7 );
    var_9 thread _ID38290();
    var_9 common_scripts\utility::_ID35637( var_5, "trigger_by_player" );
    var_9 delete();
    var_8 destroy();
}

_ID38290()
{
    self endon( "death" );
    level endon( "game_ended" );
    common_scripts\utility::_ID35582();

    for (;;)
    {
        self waittill( "trigger",  var_0  );

        if ( isplayer( var_0 ) )
            break;
    }

    self notify( "trigger_by_player" );
}

handle_vo_foley( var_0, var_1, var_2 )
{
    wait(var_2);
    var_0 playsound( var_1 );
}

pre_set_scriptables()
{
    var_0 = getscriptablearray( "armory_alien_rail_a", "targetname" );
    var_0[0] setscriptablepartstate( 0, 4 );
    var_1 = getscriptablearray( "antenna_retreat_event_a", "targetname" );
    var_1[0] setscriptablepartstate( 0, 4 );
}

queen_hole_marker()
{
    var_0 = "waypoint_alien_blocker";
    var_1 = 14;
    var_2 = 14;
    var_3 = 0.5;
    var_4 = ( -3271, 135, 841 );
    var_5 = 49;
    var_6 = 256;
    var_7 = 100;
    var_8 = maps\mp\alien\_hud::_ID37645( var_0, var_1, var_2, var_3, var_4 );
    var_9 = spawn( "trigger_radius", var_4, 0, var_6, var_7 );
    var_9 thread _ID38290();
    var_9 common_scripts\utility::_ID35637( var_5, "trigger_by_player" );
    var_9 delete();
    var_8 destroy();
}

play_sound_on_player( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( isdefined( var_2 ) )
        {
            var_2 playsound( var_0 );
            break;
        }
    }
}
