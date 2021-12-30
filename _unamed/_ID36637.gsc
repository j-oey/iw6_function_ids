// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID24809()
{
    level._ID9649 = [];
    level._ID9649[0] = 1000;
    level._ID9649[1] = 2000;
    level._ID9649[2] = 3000;
    level._ID9649[3] = 4000;
    level._ID9649[4] = 10000;
    precachestring( &"ALIEN_COLLECTIBLES_DEPLOYABLE_CURRENCY_PICKUP" );
    precachestring( &"ALIEN_COLLECTIBLES_DEPLOYABLE_CURRENCY_TAKING" );
    precachestring( &"ALIEN_COLLECTIBLES_DEPLOYABLE_CURRENCY_TAKEN" );
    level._ID25390 = [];
    _ID25391( 0, 99 );
}

_ID37100()
{
    var_0 = spawnstruct();
    var_0.weaponinfo = "aliendeployable_crate_marker_mp";
    var_0.modelbase = "mp_weapon_alien_crate";
    var_0._ID16999 = &"ALIEN_COLLECTIBLES_DEPLOYABLE_EXPLOSIVES_PICKUP";
    var_0.capturingstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_EXPLOSIVES_TAKING";
    var_0.eventstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_EXPLOSIVES_TAKEN";
    var_0._ID31889 = "deployable_explosives";
    var_0._ID10811 = "dpad_team_explosives";
    var_0._ID31051 = "used_deployable_explosives";
    var_0._ID29628 = "compass_objpoint_deploy_grenades_friendly";
    var_0._ID16454 = 25;
    var_0._ID19940 = 90.0;
    var_0._ID34785 = 0;
    var_0._ID35387 = "ballistic_vest_destroyed";
    var_0._ID9664 = "mp_vest_deployed_ui";
    var_0._ID22921 = "ammo_crate_use";
    var_0._ID22917 = ::_ID37756;
    var_0.canusecallback = maps\mp\alien\_deployablebox::_ID37078;
    var_0._ID34780 = 500;
    var_0.maxhealth = 150;
    var_0.damagefeedback = "deployable_bag";
    var_0._ID9104 = "deployable_grenades_mp";
    var_0._ID19282 = 0;
    var_0._ID2990 = 0;
    var_0.allowgrenadedamage = 0;
    var_0._ID20764 = 4;
    maps\mp\alien\_deployablebox::_ID37461( "deployable_explosives", var_0 );
    var_0 = spawnstruct();
    var_0.weaponinfo = "aliendeployable_crate_marker_mp";
    var_0.modelbase = "mp_weapon_alien_crate";
    var_0._ID16999 = &"KILLSTREAKS_HINTS_LIGHT_ARMOR_PICKUP";
    var_0.capturingstring = &"KILLSTREAKS_BOX_GETTING_VEST";
    var_0.eventstring = &"KILLSTREAKS_DEPLOYED_VEST";
    var_0._ID31889 = "deployable_vest";
    var_0._ID10811 = "dpad_team_armor";
    var_0._ID31051 = "used_deployable_vest";
    var_0._ID29628 = "compass_objpoint_deploy_friendly";
    var_0._ID16454 = 20;
    var_0._ID19940 = 90.0;
    var_0._ID34785 = 0;
    var_0._ID35387 = "ballistic_vest_destroyed";
    var_0._ID9664 = "mp_vest_deployed_ui";
    var_0._ID22921 = "ammo_crate_use";
    var_0._ID22917 = ::_ID37759;
    var_0.canusecallback = maps\mp\alien\_deployablebox::_ID37078;
    var_0._ID34780 = 500;
    var_0.maxhealth = 300;
    var_0.damagefeedback = "deployable_bag";
    var_0._ID19282 = 0;
    var_0._ID2990 = 0;
    var_0.allowgrenadedamage = 0;
    var_0._ID20764 = 3;
    maps\mp\alien\_deployablebox::_ID37461( "deployable_vest", var_0 );
    var_0 = spawnstruct();
    var_0.weaponinfo = "aliendeployable_crate_marker_mp";
    var_0.modelbase = "mp_weapon_alien_crate";
    var_0._ID16999 = &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_USE";
    var_0.capturingstring = &"KILLSTREAKS_DEPLOYABLE_AMMO_TAKING";
    var_0.eventstring = &"KILLSTREAKS_DEPLOYABLE_AMMO_TAKEN";
    var_0._ID31889 = "deployable_ammo";
    var_0._ID10811 = "dpad_team_ammo_reg";
    var_0._ID31051 = "used_deployable_ammo";
    var_0._ID29628 = "compass_objpoint_deploy_ammo_friendly";
    var_0._ID16454 = 25;
    var_0._ID19940 = 90.0;
    var_0._ID34785 = 0;
    var_0._ID35387 = "ballistic_vest_destroyed";
    var_0._ID9664 = "mp_vest_deployed_ui";
    var_0._ID22921 = "ammo_crate_use";
    var_0._ID22917 = ::_ID37754;
    var_0.canusecallback = maps\mp\alien\_deployablebox::_ID37078;
    var_0._ID34780 = 500;
    var_0.maxhealth = 150;
    var_0.damagefeedback = "deployable_bag";
    var_0._ID19282 = 0;
    var_0._ID2990 = 0;
    var_0.allowgrenadedamage = 0;
    var_0._ID20764 = 3;
    maps\mp\alien\_deployablebox::_ID37461( "deployable_ammo", var_0 );

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        level.randombox_table = "mp/alien/chaos_deployable_randombox.csv";

    if ( !isdefined( level.randombox_table ) )
        level.randombox_table = "mp/alien/deployable_randombox.csv";

    var_0 = spawnstruct();
    var_0.weaponinfo = "aliendeployable_crate_marker_mp";
    var_0.modelbase = "mp_weapon_alien_crate";
    var_0._ID16999 = &"ALIEN_COLLECTIBLES_DEPLOYABLE_RANDOM_PICKUP";
    var_0.capturingstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_RANDOM_TAKING";
    var_0._ID31889 = "deployable_randombox";
    var_0._ID10811 = "dpad_team_randombox";
    var_0._ID31051 = "used_deployable_randombox";
    var_0._ID29628 = "compass_objpoint_deploy_grenades_friendly";
    var_0._ID16454 = 25;
    var_0._ID19940 = 90.0;
    var_0._ID34785 = 0;
    var_0._ID35387 = "ballistic_vest_destroyed";
    var_0._ID9664 = "mp_vest_deployed_ui";
    var_0._ID22921 = "ammo_crate_use";
    var_0._ID22917 = ::_ID37758;
    var_0.canusecallback = maps\mp\alien\_deployablebox::_ID37078;
    var_0._ID34780 = 500;
    var_0.maxhealth = 150;
    var_0.damagefeedback = "deployable_bag";
    var_0._ID9104 = "deployable_grenades_mp";
    var_0._ID19282 = 0;
    var_0._ID2990 = 0;
    var_0.allowgrenadedamage = 0;
    var_0._ID20764 = 3;
    maps\mp\alien\_deployablebox::_ID37461( "deployable_randombox", var_0 );
    var_0 = spawnstruct();
    var_0.weaponinfo = "aliendeployable_crate_marker_mp";
    var_0.modelbase = "mp_weapon_alien_crate";
    var_0._ID16999 = &"ALIEN_COLLECTIBLES_DEPLOYABLE_CURRENCY_PICKUP";
    var_0.capturingstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_CURRENCY_TAKING";
    var_0.eventstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_CURRENCY_TAKEN";
    var_0._ID31889 = "deployable_currency";
    var_0._ID10811 = "dpad_team_currency";
    var_0._ID31051 = "used_deployable_currency";
    var_0._ID29628 = "compass_objpoint_deploy_friendly";
    var_0._ID16454 = 25;
    var_0._ID19940 = 90.0;
    var_0._ID34785 = 0;
    var_0._ID35387 = "ballistic_vest_destroyed";
    var_0._ID9664 = "mp_vest_deployed_ui";
    var_0._ID22921 = "ammo_crate_use";
    var_0._ID22917 = ::_ID37755;
    var_0.canusecallback = maps\mp\alien\_deployablebox::_ID37078;
    var_0._ID34780 = 500;
    var_0.maxhealth = 150;
    var_0.damagefeedback = "deployable_bag";
    var_0._ID9104 = "deployable_grenades_mp";
    var_0._ID19282 = 0;
    var_0._ID2990 = 0;
    var_0.allowgrenadedamage = 0;
    var_0._ID20764 = 4;
    var_0.icon_name = "alien_dpad_icon_team_money";
    maps\mp\alien\_deployablebox::_ID37461( "deployable_currency", var_0 );
    var_0 = spawnstruct();
    var_0.weaponinfo = "aliendeployable_crate_marker_mp";
    var_0.modelbase = "mp_weapon_alien_crate";
    var_0._ID16999 = &"ALIEN_COLLECTIBLES_DEPLOYABLE_ADRENALINE_PICKUP";
    var_0.capturingstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_BOOST_TAKING";
    var_0.eventstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_BOOST_TAKEN";
    var_0._ID31889 = "deployable_adrenalinebox";
    var_0._ID10811 = "dpad_team_adrenaline";
    var_0._ID31051 = "used_deployable_juicebox";
    var_0._ID29628 = "compass_objpoint_deploy_juiced_friendly";
    var_0._ID16454 = 25;
    var_0._ID19940 = 90.0;
    var_0._ID34785 = 0;
    var_0._ID35387 = "ballistic_vest_destroyed";
    var_0._ID9664 = "mp_vest_deployed_ui";
    var_0._ID22921 = "ammo_crate_use";
    var_0._ID22917 = ::_ID37753;
    var_0.canusecallback = maps\mp\alien\_deployablebox::_ID37078;
    var_0._ID34780 = 500;
    var_0.maxhealth = 300;
    var_0.damagefeedback = "deployable_bag";
    var_0._ID9104 = "deployable_ammo_mp";
    var_0._ID19282 = 0;
    var_0._ID2990 = 0;
    var_0.allowgrenadedamage = 0;
    var_0._ID20764 = 3;
    level._ID8719 = ::_ID8719;
    maps\mp\alien\_deployablebox::_ID37461( "deployable_adrenalinebox", var_0 );
    var_0 = spawnstruct();
    var_0.weaponinfo = "aliendeployable_crate_marker_mp";
    var_0.modelbase = "mp_weapon_alien_crate";
    var_0._ID16999 = &"KILLSTREAKS_HINTS_DEPLOYABLE_JUICEBOX_PICKUP";
    var_0.capturingstring = &"KILLSTREAKS_DEPLOYABLE_JUICEBOX_TAKING";
    var_0.eventstring = &"KILLSTREAKS_DEPLOYABLE_JUICEBOX_TAKEN";
    var_0._ID31889 = "deployable_juicebox";
    var_0._ID10811 = "dpad_team_boost";
    var_0._ID31051 = "used_deployable_juicebox";
    var_0._ID29628 = "compass_objpoint_deploy_juiced_friendly";
    var_0._ID16454 = 25;
    var_0._ID19940 = 90.0;
    var_0._ID34785 = 0;
    var_0._ID35387 = "ballistic_vest_destroyed";
    var_0._ID9664 = "mp_vest_deployed_ui";
    var_0._ID22921 = "ammo_crate_use";
    var_0._ID22917 = ::_ID37757;
    var_0.canusecallback = maps\mp\alien\_deployablebox::_ID37078;
    var_0._ID34780 = 500;
    var_0.maxhealth = 300;
    var_0.damagefeedback = "deployable_bag";
    var_0._ID9104 = "deployable_ammo_mp";
    var_0._ID19282 = 0;
    var_0._ID2990 = 0;
    var_0.allowgrenadedamage = 0;
    var_0._ID20764 = 3;
    level._ID8750 = ::_ID8750;
    maps\mp\alien\_deployablebox::_ID37461( "deployable_juicebox", var_0 );
}

_ID38079()
{
    var_0 = "";
    var_1 = "dpad_team_ammo_in";
    var_2 = spawnstruct();
    var_2.weaponinfo = "aliendeployable_crate_marker_mp";
    var_2.modelbase = "mp_weapon_alien_crate";
    var_2._ID16999 = &"ALIEN_COLLECTIBLES_DEPLOYABLE_INCENDIARYAMMO_PICKUP";
    var_2.capturingstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKING";
    var_2.eventstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN";
    var_2._ID31889 = "deployable_specialammo_in";
    var_2._ID10811 = "dpad_team_ammo_in";
    var_2._ID31051 = "used_deployable_in_ammo";
    var_2._ID29628 = "compass_objpoint_deploy_grenades_friendly";
    var_2._ID16454 = 25;
    var_2._ID19940 = 90.0;
    var_2._ID34785 = 0;
    var_2._ID35387 = "ballistic_vest_destroyed";
    var_2._ID9664 = "mp_vest_deployed_ui";
    var_2._ID22921 = "ammo_crate_use";
    var_2._ID22917 = ::_ID37084;
    var_2.canusecallback = maps\mp\alien\_deployablebox::_ID37078;
    var_2._ID34780 = 500;
    var_2.maxhealth = 150;
    var_2.damagefeedback = "deployable_bag";
    var_2._ID9104 = "deployable_specialammo_mp";
    var_2._ID19282 = 0;
    var_2._ID2990 = 0;
    var_2.allowgrenadedamage = 0;
    var_2._ID20764 = 3;

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        var_2._ID20764 = 1;

    maps\mp\alien\_deployablebox::_ID37461( "deployable_specialammo_in", var_2 );
    var_2 = spawnstruct();
    var_2.weaponinfo = "aliendeployable_crate_marker_mp";
    var_2.modelbase = "mp_weapon_alien_crate";
    var_2._ID16999 = &"ALIEN_COLLECTIBLES_DEPLOYABLE_EXPLOSIVEAMMO_PICKUP";
    var_2.capturingstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKING";
    var_2.eventstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN";
    var_2._ID31889 = "deployable_specialammo_explo";
    var_2._ID10811 = "dpad_team_ammo_explo";
    var_2._ID31051 = "used_deployable_exp_ammo";
    var_2._ID29628 = "compass_objpoint_deploy_grenades_friendly";
    var_2._ID16454 = 25;
    var_2._ID19940 = 90.0;
    var_2._ID34785 = 0;
    var_2._ID35387 = "ballistic_vest_destroyed";
    var_2._ID9664 = "mp_vest_deployed_ui";
    var_2._ID22921 = "ammo_crate_use";
    var_2._ID22917 = ::_ID37084;
    var_2.canusecallback = maps\mp\alien\_deployablebox::_ID37078;
    var_2._ID34780 = 500;
    var_2.maxhealth = 150;
    var_2.damagefeedback = "deployable_bag";
    var_2._ID9104 = "deployable_specialammo_mp";
    var_2._ID19282 = 0;
    var_2._ID2990 = 0;
    var_2.allowgrenadedamage = 0;
    var_2._ID20764 = 3;

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        var_2._ID20764 = 1;

    maps\mp\alien\_deployablebox::_ID37461( "deployable_specialammo_explo", var_2 );
    var_2 = spawnstruct();
    var_2.weaponinfo = "aliendeployable_crate_marker_mp";
    var_2.modelbase = "mp_weapon_alien_crate";
    var_2._ID16999 = &"ALIEN_COLLECTIBLES_DEPLOYABLE_STUNAMMO_PICKUP";
    var_2.capturingstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKING";
    var_2.eventstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN";
    var_2._ID31889 = "deployable_specialammo";
    var_2._ID10811 = "dpad_team_ammo_stun";
    var_2._ID31051 = "used_deployable_stun_ammo";
    var_2._ID29628 = "compass_objpoint_deploy_grenades_friendly";
    var_2._ID16454 = 25;
    var_2._ID19940 = 90.0;
    var_2._ID34785 = 0;
    var_2._ID35387 = "ballistic_vest_destroyed";
    var_2._ID9664 = "mp_vest_deployed_ui";
    var_2._ID22921 = "ammo_crate_use";
    var_2._ID22917 = ::_ID37084;
    var_2.canusecallback = maps\mp\alien\_deployablebox::_ID37078;
    var_2._ID34780 = 500;
    var_2.maxhealth = 150;
    var_2.damagefeedback = "deployable_bag";
    var_2._ID9104 = "deployable_specialammo_mp";
    var_2._ID19282 = 0;
    var_2._ID2990 = 0;
    var_2.allowgrenadedamage = 0;
    var_2._ID20764 = 3;

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        var_2._ID20764 = 1;

    maps\mp\alien\_deployablebox::_ID37461( "deployable_specialammo", var_2 );
    var_2 = spawnstruct();
    var_2.weaponinfo = "aliendeployable_crate_marker_mp";
    var_2.modelbase = "mp_weapon_alien_crate";
    var_2._ID16999 = &"ALIEN_COLLECTIBLES_DEPLOYABLE_APAMMO_PICKUP";
    var_2.capturingstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKING";
    var_2.eventstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN";
    var_2._ID31889 = "deployable_specialammo_ap";
    var_2._ID10811 = "dpad_team_ammo_ap";
    var_2._ID31051 = "used_deployable_ap_ammo";
    var_2._ID29628 = "compass_objpoint_deploy_grenades_friendly";
    var_2._ID16454 = 25;
    var_2._ID19940 = 90.0;
    var_2._ID34785 = 0;
    var_2._ID35387 = "ballistic_vest_destroyed";
    var_2._ID9664 = "mp_vest_deployed_ui";
    var_2._ID22921 = "ammo_crate_use";
    var_2._ID22917 = ::_ID37084;
    var_2.canusecallback = maps\mp\alien\_deployablebox::_ID37078;
    var_2._ID34780 = 500;
    var_2.maxhealth = 150;
    var_2.damagefeedback = "deployable_bag";
    var_2._ID9104 = "deployable_specialammo_mp";
    var_2._ID19282 = 0;
    var_2._ID2990 = 0;
    var_2.allowgrenadedamage = 0;
    var_2._ID20764 = 3;

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
        var_2._ID20764 = 1;

    maps\mp\alien\_deployablebox::_ID37461( "deployable_specialammo_ap", var_2 );
    var_2 = spawnstruct();
    var_2.weaponinfo = "aliendeployable_crate_marker_mp";
    var_2.modelbase = "mp_weapon_alien_crate";
    var_2._ID16999 = &"ALIENS_PATCH_COMBINED_AMMO_PICKUP";
    var_2.capturingstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKING";
    var_2.eventstring = &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN";
    var_2._ID31889 = "deployable_specialammo_comb";
    var_2._ID10811 = "dpad_placeholder_ammo_2";
    var_2._ID31051 = "used_deployable_ammo";
    var_2._ID29628 = "compass_objpoint_deploy_ammo_friendly";
    var_2._ID16454 = 25;
    var_2._ID19940 = 90.0;
    var_2._ID34785 = 0;
    var_2._ID35387 = "ballistic_vest_destroyed";
    var_2._ID9664 = "mp_vest_deployed_ui";
    var_2._ID22921 = "ammo_crate_use";
    var_2._ID22917 = ::_ID37084;
    var_2.canusecallback = maps\mp\alien\_deployablebox::_ID37078;
    var_2._ID34780 = 500;
    var_2.maxhealth = 150;
    var_2.damagefeedback = "deployable_bag";
    var_2._ID19282 = 0;
    var_2._ID2990 = 0;
    var_2.allowgrenadedamage = 0;
    var_2._ID20764 = 3;
    maps\mp\alien\_deployablebox::_ID37461( "deployable_specialammo_comb", var_2 );
}

_ID37084( var_0, var_1, var_2, var_3 )
{
    self endon( "disconnect" );

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( var_1 )
    {
        thread maps\mp\alien\_persistence::_ID9658( var_0 );
        maps\mp\alien\_unk1464::deployable_box_onuse_message( var_0 );
    }

    while ( maps\mp\_utility::_ID18585() )
        wait 0.05;

    if ( !isdefined( var_3 ) )
        var_3 = var_0.boxtype;

    var_4 = undefined;
    var_5 = undefined;
    var_6 = 0;

    switch ( var_3 )
    {
        case "deployable_specialammo_ap":
            if ( !isdefined( self._ID30932 ) )
                self._ID30932 = [];

            var_5 = "piercing";
            break;
        case "deployable_specialammo_in":
            if ( !isdefined( self._ID30936 ) )
                self._ID30936 = [];

            var_5 = "incendiary";
            break;
        case "deployable_specialammo":
            if ( !isdefined( self.special_ammocount ) )
                self.special_ammocount = [];

            var_5 = "stun";
            break;
        case "deployable_specialammo_explo":
            if ( !isdefined( self._ID30934 ) )
                self._ID30934 = [];

            var_5 = "explosive";
            break;
        case "deployable_specialammo_comb":
            if ( !isdefined( self.special_ammocount_comb ) )
                self.special_ammocount_comb = [];

            var_5 = "combined";
            break;
    }

    var_7 = self getweaponslistprimaries();

    foreach ( var_9 in var_7 )
    {
        if ( !weapon_can_use_specialammo( var_9 ) && !maps\mp\alien\_unk1464::is_chaos_mode() )
            continue;

        var_10 = maps\mp\alien\_unk1464::_ID15570( var_0, var_9, var_2 );

        if ( var_10 == 0 )
            continue;

        var_11 = maps\mp\alien\_unk1464::getrawbaseweaponname( var_9 );
        maps\mp\alien\_unk1464::handle_existing_ammo( var_11, var_9, var_5 );

        switch ( var_3 )
        {
            case "deployable_specialammo_ap":
                if ( !isdefined( self._ID30932[var_11] ) )
                    self._ID30932[var_11] = 0;

                if ( self._ID30932[var_11] + var_10 > weaponmaxammo( var_9 ) + weaponclipsize( var_9 ) )
                    self._ID30932[var_11] = weaponmaxammo( var_9 );

                if ( self._ID30932[var_11] > 0 )
                    var_6 = 1;

                self._ID30932[var_11] = self._ID30932[var_11] + var_10;
                self setweaponammostock( var_9, self._ID30932[var_11] );
                break;
            case "deployable_specialammo_in":
                if ( !isdefined( self._ID30936[var_11] ) )
                    self._ID30936[var_11] = 0;

                if ( self._ID30936[var_11] + var_10 > weaponmaxammo( var_9 ) + weaponclipsize( var_9 ) )
                    self._ID30936[var_11] = weaponmaxammo( var_9 );

                if ( self._ID30936[var_11] > 0 )
                    var_6 = 1;

                self._ID30936[var_11] = self._ID30936[var_11] + var_10;
                self setweaponammostock( var_9, self._ID30936[var_11] );
                break;
            case "deployable_specialammo":
                if ( !isdefined( self.special_ammocount[var_11] ) )
                    self.special_ammocount[var_11] = 0;

                if ( self.special_ammocount[var_11] + var_10 > weaponmaxammo( var_9 ) + weaponclipsize( var_9 ) )
                    self.special_ammocount[var_11] = weaponmaxammo( var_9 );

                if ( self.special_ammocount[var_11] > 0 )
                    var_6 = 1;

                self.special_ammocount[var_11] = self.special_ammocount[var_11] + var_10;
                self setweaponammostock( var_9, self.special_ammocount[var_11] );
                break;
            case "deployable_specialammo_explo":
                if ( !isdefined( self._ID30934[var_11] ) )
                    self._ID30934[var_11] = 0;

                if ( self._ID30934[var_11] + var_10 > weaponmaxammo( var_9 ) + weaponclipsize( var_9 ) )
                    self._ID30934[var_11] = weaponmaxammo( var_9 );

                if ( self._ID30934[var_11] > 0 )
                    var_6 = 1;

                self._ID30934[var_11] = self._ID30934[var_11] + var_10;
                self setweaponammostock( var_9, self._ID30934[var_11] );
                break;
            case "deployable_specialammo_comb":
                if ( !isdefined( self.special_ammocount_comb[var_11] ) )
                    self.special_ammocount_comb[var_11] = 0;

                if ( self.special_ammocount_comb[var_11] + var_10 > weaponmaxammo( var_9 ) + weaponclipsize( var_9 ) )
                    self.special_ammocount_comb[var_11] = weaponmaxammo( var_9 );

                if ( self.special_ammocount_comb[var_11] > 0 )
                    var_6 = 1;

                self.special_ammocount_comb[var_11] = self.special_ammocount_comb[var_11] + var_10;
                self setweaponammostock( var_9, self.special_ammocount_comb[var_11] );
        }

        if ( !var_6 && !maps\mp\alien\_unk1464::is_chaos_mode() )
            maps\mp\alien\_unk1464::_ID36515( var_9 );
    }

    var_13 = self getcurrentprimaryweapon();

    if ( weapon_can_use_specialammo( var_13 ) && maps\mp\alien\_unk1464::_ID15570( var_0, var_13, var_2 ) > 0 || maps\mp\alien\_unk1464::is_chaos_mode() )
    {
        switch ( var_5 )
        {
            case "incendiary":
                self._ID16351 = 1;
                self setclientomnvar( "ui_alien_specialammo", 2 );
                break;
            case "explosive":
                if ( !maps\mp\_utility::_hasperk( "specialty_explosivebullets" ) )
                    maps\mp\_utility::_ID15611( "specialty_explosivebullets", 0 );

                self setclientomnvar( "ui_alien_specialammo", 3 );
                break;
            case "stun":
                if ( !maps\mp\_utility::_hasperk( "specialty_bulletdamage" ) )
                    maps\mp\_utility::_ID15611( "specialty_bulletdamage", 0 );

                self setclientomnvar( "ui_alien_specialammo", 1 );
                break;
            case "piercing":
                if ( !maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
                    maps\mp\_utility::_ID15611( "specialty_armorpiercing", 0 );

                self setclientomnvar( "ui_alien_specialammo", 4 );
                break;
            case "combined":
                if ( !maps\mp\_utility::_hasperk( "specialty_explosivebullets" ) )
                    maps\mp\_utility::_ID15611( "specialty_explosivebullets", 0 );

                if ( !maps\mp\_utility::_hasperk( "specialty_bulletdamage" ) )
                    maps\mp\_utility::_ID15611( "specialty_bulletdamage", 0 );

                if ( !maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
                    maps\mp\_utility::_ID15611( "specialty_armorpiercing", 0 );

                self._ID16351 = 1;
                self setclientomnvar( "ui_alien_specialammo", 5 );
                break;
        }
    }

    if ( maps\mp\alien\_unk1464::is_chaos_mode() )
    {
        var_14 = undefined;

        if ( var_5 != "incendiary" )
            self._ID16351 = undefined;
        else if ( var_5 != "stun" )
            var_14 = "specialty_bulletdamage";
        else if ( var_5 != "piercing" )
            var_14 = "specialty_armorpiercing";
        else if ( var_5 != "explosive" )
            var_14 = "specialty_explosivebullets";

        if ( isdefined( var_14 ) )
        {
            if ( maps\mp\_utility::_hasperk( var_14 ) )
            {
                maps\mp\_utility::_unsetperk( var_14 );
                return;
            }

            return;
        }
    }
    else
    {
        thread maps\mp\alien\_unk1464::_ID30929( var_5 );
        thread maps\mp\alien\_unk1464::_ID30930( var_5 );
    }
}

addratiomaxstockcombinedtoallweapons( var_0 )
{
    var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        if ( maps\mp\alien\_unk1464::is_incompatible_weapon( var_3 ) )
            continue;

        if ( maps\mp\gametypes\_weapons::isbulletweapon( var_3 ) )
        {
            if ( var_3 != "iw6_alienminigun_mp" && var_3 != "iw6_alienminigun1_mp" && var_3 != "iw6_alienminigun2_mp" && var_3 != "iw6_alienminigun3_mp" && var_3 != "iw6_alienminigun4_mp" && weapontype( var_3 ) != "riotshield" )
            {
                var_4 = maps\mp\alien\_unk1464::getrawbaseweaponname( var_3 );
                var_5 = self getweaponammostock( var_3 );
                var_6 = weaponmaxammo( var_3 );
                var_7 = var_5 + var_6 * var_0;
                self setweaponammostock( var_3, int( min( var_7, var_6 ) ) );
            }
        }
    }
}

addfullcombinedcliptoallweapons()
{
    var_0 = self getweaponslistprimaries();

    foreach ( var_2 in var_0 )
    {
        if ( maps\mp\alien\_unk1464::is_incompatible_weapon( var_2 ) )
            continue;

        if ( maps\mp\gametypes\_weapons::isbulletweapon( var_2 ) )
        {
            if ( var_2 != "iw6_alienminigun_mp" && var_2 != "iw6_alienminigun1_mp" && var_2 != "iw6_alienminigun2_mp" && var_2 != "iw6_alienminigun3_mp" && var_2 != "iw6_alienminigun4_mp" && weapontype( var_2 ) != "riotshield" )
            {
                var_3 = maps\mp\alien\_unk1464::getrawbaseweaponname( var_2 );
                var_4 = weaponclipsize( var_2 );

                if ( maps\mp\alien\_unk1464::_ID18361( var_2 ) )
                {
                    self setweaponammoclip( var_2, var_4, "left" );
                    self setweaponammoclip( var_2, var_4, "right" );
                }
                else
                    self setweaponammoclip( var_2, var_4 );
            }
        }
    }
}

weapon_can_use_specialammo( var_0 )
{
    if ( maps\mp\gametypes\_weapons::isbulletweapon( var_0 ) && !maps\mp\alien\_unk1464::is_incompatible_weapon( var_0 ) )
        return 1;

    return 0;
}

_ID37758( var_0 )
{
    thread maps\mp\alien\_persistence::_ID9658( var_0 );
    giverandomdeployable( var_0 );
}

giverandomdeployable( var_0 )
{
    _ID7149( var_0 );
}

_ID7149( var_0 )
{
    var_1 = [];
    var_2 = 0;
    var_3 = var_0._ID34651;

    foreach ( var_7, var_5 in level._ID25390 )
    {
        if ( var_3 == 0 )
            var_2 = var_5._ID19868;
        else if ( var_3 == 1 )
            var_2 = var_5._ID19869;
        else if ( var_3 == 2 )
            var_2 = var_5.level_2_weight;
        else if ( var_3 == 3 )
            var_2 = var_5._ID19871;
        else if ( var_3 == 4 )
            var_2 = var_5._ID19872;

        for ( var_6 = 0; var_6 < var_2; var_6++ )
            var_1[var_1.size] = var_5;
    }

    var_8 = var_1[randomintrange( 0, var_1.size )];
    _ID15564( var_8, var_0 );
}

_ID15564( var_0, var_1 )
{
    switch ( var_0._ID25633 )
    {
        case "ammo":
            _ID15522( var_1 );
            break;
        case "soflam":
            _ID15568( var_1 );
            break;
        case "flare":
            _ID15533( var_1 );
            break;
        case "leash":
            _ID15542( var_1 );
            break;
        case "armor":
            _ID15523( var_1 );
            break;
        case "boost":
            give_boost_item( var_1 );
            break;
        case "explosives":
            _ID15531( var_1 );
            break;
        case "trophy":
            give_trophy_item( var_1 );
            break;
        case "feral":
            _ID15532( var_1 );
            break;
        case "specialammo":
            _ID15569( var_1 );
            break;
    }
}

_ID15522( var_0 )
{
    addalienweaponammo( var_0 );
    maps\mp\_utility::setlowermessage( "ammo_message", &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN", 3 );
}

_ID15568( var_0 )
{
    maps\mp\_utility::_giveweapon( "aliensoflam_mp" );
    maps\mp\_utility::setlowermessage( "soflam_messgae", &"ALIEN_COLLECTIBLES_FOUND_SOFLAM", 3 );
}

_ID15533( var_0 )
{
    if ( self hasweapon( "alienthrowingknife_mp" ) )
        self takeweapon( "alienthrowingknife_mp" );

    if ( self hasweapon( "alientrophy_mp" ) )
        self takeweapon( "alientrophy_mp" );

    if ( isdefined( level.give_randombox_item_check ) )
        self [[ level.give_randombox_item_check ]]( "flare" );

    self setoffhandsecondaryclass( "flash" );
    maps\mp\_utility::_giveweapon( "alienflare_mp" );
    self setweaponammoclip( "alienflare_mp", 1 );
    maps\mp\_utility::setlowermessage( "flare_message", &"ALIEN_COLLECTIBLES_FOUND_FLARE", 3 );
}

_ID15542( var_0 )
{
    self setoffhandsecondaryclass( "throwingknife" );
    maps\mp\_utility::_giveweapon( "alienthrowingknife_mp" );
    maps\mp\_utility::setlowermessage( "pet_leash_message", &"ALIEN_COLLECTIBLES_FOUND_PET_LEASH", 3 );
}

_ID15523( var_0 )
{
    if ( !maps\mp\_utility::_ID18666() )
    {
        var_0.boxtype = "deployable_vest";
        _ID37759( var_0 );
        maps\mp\_utility::setlowermessage( "armor_mesage", &"ALIEN_COLLECTIBLES_DEPLOYED_VEST", 3 );
    }
}

_ID15531( var_0 )
{
    var_0.boxtype = "deployable_explosives";
    _ID37756( var_0 );
    maps\mp\_utility::setlowermessage( "explosives_message", &"ALIEN_COLLECTIBLES_DEPLOYABLE_EXPLOSIVES_TAKEN", 3 );
}

give_boost_item( var_0 )
{
    _ID37757( var_0 );
    maps\mp\_utility::setlowermessage( "mortar_shell_message", &"ALIEN_COLLECTIBLES_DEPLOYABLE_BOOST_TAKEN", 3 );
}

_ID15532( var_0 )
{
    _ID37753( var_0 );
    maps\mp\_utility::setlowermessage( "feral_message", &"ALIEN_COLLECTIBLES_DEPLOYABLE_ADRENALINE_TAKEN", 3 );
}

give_trophy_item( var_0 )
{
    if ( self hasweapon( "alienthrowingknife_mp" ) )
        self takeweapon( "alienthrowingknife_mp" );

    if ( self hasweapon( "alienflare_mp" ) )
        self takeweapon( "alienflare_mp" );

    if ( isdefined( level.give_randombox_item_check ) )
        self [[ level.give_randombox_item_check ]]( "trophy" );

    self setoffhandsecondaryclass( "flash" );
    self giveweapon( "alientrophy_mp", 0 );
    self setweaponammoclip( "alientrophy_mp", 1 );
    maps\mp\_utility::setlowermessage( "trophy_message", &"ALIEN_COLLECTIBLES_FOUND_TROPHY", 3 );
}

_ID15569( var_0 )
{
    var_1 = maps\mp\alien\_unk1464::_ID14760();

    if ( var_1 == "none" )
        var_1 = common_scripts\utility::_ID25350( [ "stun_ammo", "incendiary_ammo", "ap_ammo", "explosive_ammo" ] );

    switch ( var_1 )
    {
        case "stun_ammo":
            _ID37084( var_0, 0, 0, "deployable_specialammo" );
            maps\mp\_utility::setlowermessage( "sp_ammo", &"ALIENS_PATCH_STUN_AMMO_TAKEN", 3 );
            break;
        case "incendiary_ammo":
            _ID37084( var_0, 0, 0, "deployable_specialammo_in" );
            maps\mp\_utility::setlowermessage( "sp_ammo", &"ALIEN_COLLECTIBLES_INCENDIARY_AMMO_TAKEN", 3 );
            break;
        case "ap_ammo":
            _ID37084( var_0, 0, 0, "deployable_specialammo_ap" );
            maps\mp\_utility::setlowermessage( "sp_ammo", &"ALIEN_COLLECTIBLES_AP_AMMO_TAKEN", 3 );
            break;
        case "explosive_ammo":
            _ID37084( var_0, 0, 0, "deployable_specialammo_explo" );
            maps\mp\_utility::setlowermessage( "sp_ammo", &"ALIEN_COLLECTIBLES_EXPLOSIVE_AMMO_TAKEN", 3 );
            break;
        case "combined_ammo":
            _ID37084( var_0, 0, 0, "deployable_specialammo_comb" );
            maps\mp\_utility::setlowermessage( "sp_ammo", &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN", 3 );
            break;
    }
}

_ID25391( var_0, var_1 )
{
    for ( var_2 = var_0; var_2 < var_1; var_2++ )
    {
        var_3 = spawnstruct();
        var_3._ID25633 = tablelookup( level.randombox_table, 0, var_2, 1 );

        if ( var_3._ID25633 == "" )
            break;

        var_3._ID19868 = int( tablelookup( level.randombox_table, 0, var_2, 2 ) );
        var_3._ID19869 = int( tablelookup( level.randombox_table, 0, var_2, 3 ) );
        var_3.level_2_weight = int( tablelookup( level.randombox_table, 0, var_2, 4 ) );
        var_3._ID19871 = int( tablelookup( level.randombox_table, 0, var_2, 5 ) );
        var_3._ID19872 = int( tablelookup( level.randombox_table, 0, var_2, 6 ) );
        level._ID25390[var_3._ID25633] = var_3;
    }
}

_ID37755( var_0 )
{
    maps\mp\alien\_deployablebox::_ID37082( var_0 );
    _ID15591( var_0 );
}

_ID15591( var_0 )
{
    if ( isdefined( var_0._ID34651 ) && var_0._ID34651 == 0 )
        maps\mp\alien\_persistence::_ID15551( level._ID9649[0] );

    if ( isdefined( var_0._ID34651 ) && var_0._ID34651 == 1 )
        maps\mp\alien\_persistence::_ID15551( level._ID9649[1] );

    if ( isdefined( var_0._ID34651 ) && var_0._ID34651 == 2 )
        maps\mp\alien\_persistence::_ID15551( level._ID9649[2] );

    if ( isdefined( var_0._ID34651 ) && var_0._ID34651 == 3 )
        maps\mp\alien\_persistence::_ID15551( level._ID9649[3] );

    if ( isdefined( var_0._ID34651 ) && var_0._ID34651 == 4 )
        maps\mp\alien\_persistence::_ID15551( level._ID9649[4] );
}

_ID37753( var_0 )
{
    thread maps\mp\alien\_persistence::_ID9658( var_0 );

    if ( isdefined( level._ID8719 ) )
        self thread [[ level._ID8719 ]]( level.deployablebox_adrenalinebox_rank[var_0._ID34651], var_0._ID34651 );
}

_ID8719( var_0, var_1 )
{
    self endon( "death" );
    self endon( "faux_spawn" );
    self endon( "disconnect" );
    self endon( "unset_adrenaline" );
    level endon( "game_ended" );

    if ( isdefined( self.adrenalinetime ) )
        self.adrenalinetime = self.adrenalinetime + var_0;
    else
        self.adrenalinetime = var_0;

    if ( isdefined( self.adrenalinetime ) && self.adrenalinetime > level.deployablebox_adrenalinebox_max )
        self.adrenalinetime = level.deployablebox_adrenalinebox_max;

    if ( isdefined( self.isferal ) && self.isferal )
        return;

    self.isferal = 1;
    self._ID21667 = 1.1;
    maps\mp\_utility::_ID15611( "specialty_selectivehearing", 0 );
    maps\mp\alien\_unk1464::restore_client_fog( 0 );
    self playlocalsound( "alien_feral_instinct_bed" );
    thread maps\mp\alien\_outline_proto::_ID28200();
    thread _ID38186();
    var_2 = var_0 * 1000 + gettime();

    if ( var_1 == 1 )
        self._ID21667 = 1.2;

    if ( var_1 == 2 )
    {
        self._ID21667 = 1.2;
        activateregenfaster();
    }

    if ( var_1 == 3 )
    {
        self._ID21667 = 1.2;
        activateregenfaster();
    }

    if ( var_1 == 4 )
    {
        maps\mp\_utility::_ID15611( "specialty_longersprint", 0 );
        activateregenfaster();
        self._ID21667 = 1.2;
    }

    maps\mp\alien\_perkfunctions::_ID34522();

    while ( isdefined( self.adrenalinetime ) )
    {
        wait 1;
        self.adrenalinetime--;

        if ( self.adrenalinetime < 0 )
        {
            self.adrenalinetime = undefined;
            self setclientdvar( "ui_juiced_end_milliseconds", 0 );
            break;
        }

        var_2 = self.adrenalinetime * 1000 + gettime();
    }

    _ID37063();
}

activateregenfaster()
{
    self._ID25671 = level._ID25669;
    self._ID18643 = 1;
}

_ID38186()
{
    self endon( "disconnect" );
    self endon( "unset_adrenaline" );
    common_scripts\utility::_ID35626( "death", "faux_spawn", "last_stand" );
    thread _ID37063( 1 );
}

_ID37063( var_0 )
{
    maps\mp\_utility::_unsetperk( "specialty_longersprint" );
    maps\mp\_utility::_unsetperk( "specialty_selectivehearing" );
    self._ID18643 = undefined;
    self._ID25671 = 1;

    if ( maps\mp\alien\_perk_utility::_ID16358( "perk_medic" ) )
    {
        self._ID21667 = maps\mp\alien\_perk_utility::_ID23434();

        if ( maps\mp\alien\_perk_utility::_ID16358( "perk_medic", [ 2, 3, 4 ] ) )
            maps\mp\_utility::_ID15611( "specialty_longersprint", 0 );
    }
    else
        self._ID21667 = maps\mp\alien\_prestige::prestige_getmoveslowscalar();

    maps\mp\gametypes\_weapons::_ID34567();

    if ( !maps\mp\alien\_unk1464::_ID18506( level._ID11234 ) )
        thread maps\mp\alien\_outline_proto::_ID34257();

    maps\mp\alien\_unk1464::restore_client_fog( 0 );
    self.isferal = undefined;

    if ( !maps\mp\alien\_unk1464::_ID18506( level._ID11234 ) )
        self notify( "unset_adrenaline" );
}

_ID37757( var_0 )
{
    thread maps\mp\alien\_persistence::_ID9658( var_0 );

    if ( isdefined( level._ID8750 ) )
        self thread [[ level._ID8750 ]]( level.deployablebox_juicebox_rank[var_0._ID34651], var_0._ID34651 );
}

_ID8750( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "faux_spawn" );
    self endon( "disconnect" );
    self endon( "unset_juiced" );
    level endon( "game_ended" );

    if ( isdefined( self.juicetime ) )
        self.juicetime = self.juicetime + var_0;
    else
        self.juicetime = var_0;

    if ( isdefined( self.juicetime ) && self.juicetime > level._ID9656 )
        self.juicetime = level._ID9656;

    if ( maps\mp\alien\_unk1464::_ID18506( var_2 ) )
        self.juicetime = var_0;

    if ( isdefined( self._ID18673 ) && self._ID18673 )
        return;

    self._ID18673 = 1;
    maps\mp\_utility::_ID15611( "specialty_fastreload", 0 );
    maps\mp\_utility::_ID15611( "specialty_quickdraw", 0 );
    maps\mp\_utility::_ID15611( "specialty_stalker", 0 );
    maps\mp\_utility::_ID15611( "specialty_fastoffhand", 0 );
    maps\mp\_utility::_ID15611( "specialty_fastsprintrecovery", 0 );
    maps\mp\_utility::_ID15611( "specialty_quickswap", 0 );
    maps\mp\_utility::_ID15611( "specialty_fastermelee", 0 );

    if ( var_1 == 2 || var_1 == 3 || var_1 == 4 )
        self._ID10945 = 0.75;
    else
        self._ID10945 = 1.0;

    thread _ID38187();
    var_3 = var_0 * 1000 + gettime();

    if ( !isai( self ) )
        self setclientdvar( "ui_juiced_end_milliseconds", var_3 );

    while ( isdefined( self.juicetime ) )
    {
        wait 1;
        self.juicetime--;

        if ( self.juicetime < 0 )
        {
            self.juicetime = undefined;
            self setclientdvar( "ui_juiced_end_milliseconds", 0 );
            break;
        }

        var_3 = self.juicetime * 1000 + gettime();
        self setclientdvar( "ui_juiced_end_milliseconds", var_3 );
    }

    _ID37064();
}

_ID38187()
{
    self endon( "disconnect" );
    self endon( "unset_juiced" );
    common_scripts\utility::_ID35626( "death", "faux_spawn", "last_stand" );
    thread _ID37064( 1 );
}

_ID37064( var_0 )
{
    var_1 = maps\mp\alien\_persistence::_ID14645();

    if ( maps\mp\_utility::_ID18666() )
    {
        if ( isdefined( self.juggmovespeedscaler ) )
            self._ID21667 = self.juggmovespeedscaler;
        else
            self._ID21667 = 0.7;
    }

    if ( maps\mp\alien\_perk_utility::_ID16358( "perk_medic", [ 2, 3, 4 ] ) )
        maps\mp\_utility::_ID15611( "specialty_longersprint", 0 );

    maps\mp\_utility::_unsetperk( "specialty_fastreload" );
    self._ID10945 = 1.0;
    maps\mp\_utility::_unsetperk( "specialty_quickdraw" );
    maps\mp\_utility::_unsetperk( "specialty_stalker" );
    maps\mp\_utility::_unsetperk( "specialty_fastoffhand" );
    maps\mp\_utility::_unsetperk( "specialty_fastsprintrecovery" );
    maps\mp\_utility::_unsetperk( "specialty_quickswap" );
    maps\mp\_utility::_unsetperk( "specialty_fastermelee" );

    if ( maps\mp\alien\_perk_utility::_ID16358( "perk_bullet_damage" ) )
    {
        switch ( var_1 )
        {
            case 0:
                maps\mp\alien\_perkfunctions::_ID28485();
                break;
            case 1:
                maps\mp\alien\_perkfunctions::set_perk_bullet_damage_1();
                break;
            case 2:
                maps\mp\alien\_perkfunctions::_ID28487();
                break;
            case 3:
                maps\mp\alien\_perkfunctions::_ID28488();
                break;
            case 4:
                maps\mp\alien\_perkfunctions::set_perk_bullet_damage_4();
                break;
        }
    }

    self._ID18673 = undefined;

    if ( !isai( self ) )
        self setclientdvar( "ui_juiced_end_milliseconds", 0 );

    self notify( "unset_juiced" );
}

_ID37754( var_0 )
{
    maps\mp\alien\_deployablebox::_ID37082( var_0 );
    addalienweaponammo( var_0 );
}

addratiomaxstocktoallweapons( var_0 )
{
    var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        if ( maps\mp\alien\_unk1464::is_incompatible_weapon( var_3 ) )
            continue;

        if ( maps\mp\gametypes\_weapons::isbulletweapon( var_3 ) )
        {
            if ( var_3 != "iw6_alienminigun_mp" && var_3 != "iw6_alienminigun1_mp" && var_3 != "iw6_alienminigun2_mp" && var_3 != "iw6_alienminigun3_mp" && var_3 != "iw6_alienminigun4_mp" && weapontype( var_3 ) != "riotshield" )
            {
                var_4 = maps\mp\alien\_unk1464::getrawbaseweaponname( var_3 );

                if ( maps\mp\alien\_unk1464::_ID24101( var_4 ) )
                {
                    if ( isdefined( self._ID31873[var_4] ) )
                    {
                        if ( self._ID31873[var_4]._ID3346 < weaponmaxammo( var_3 ) )
                        {
                            var_5 = weaponmaxammo( var_3 );
                            var_6 = self._ID31873[var_4]._ID3346 + var_5 * var_0;
                            self._ID31873[var_4]._ID3346 = int( floor( var_6 ) );
                        }
                    }
                }
                else
                {
                    var_7 = self getweaponammostock( var_3 );
                    var_5 = weaponmaxammo( var_3 );
                    var_6 = var_7 + var_5 * var_0;
                    self setweaponammostock( var_3, int( min( var_6, var_5 ) ) );
                }
            }
        }
    }
}

addfullcliptoallweapons( var_0 )
{
    var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        if ( maps\mp\alien\_unk1464::is_incompatible_weapon( var_3 ) )
            continue;

        if ( maps\mp\gametypes\_weapons::isbulletweapon( var_3 ) )
        {
            if ( var_3 != "iw6_alienminigun_mp" && var_3 != "iw6_alienminigun1_mp" && var_3 != "iw6_alienminigun2_mp" && var_3 != "iw6_alienminigun3_mp" && var_3 != "iw6_alienminigun4_mp" && weapontype( var_3 ) != "riotshield" )
            {
                var_4 = maps\mp\alien\_unk1464::getrawbaseweaponname( var_3 );

                if ( maps\mp\alien\_unk1464::_ID24101( var_4 ) )
                    continue;
                else
                {
                    var_5 = weaponclipsize( var_3 );

                    if ( isdefined( var_0 ) )
                        var_5 = int( self getweaponammoclip( var_3 ) + var_5 * var_0 );

                    if ( maps\mp\alien\_unk1464::_ID18361( var_3 ) )
                    {
                        var_6 = var_5;
                        var_7 = var_5;

                        if ( isdefined( var_0 ) )
                        {
                            var_6 = int( self getweaponammoclip( var_3, "left" ) + var_5 * var_0 );
                            var_7 = int( self getweaponammoclip( var_3, "right" ) + var_5 * var_0 );
                        }

                        self setweaponammoclip( var_3, var_6, "left" );
                        self setweaponammoclip( var_3, var_7, "right" );
                    }
                    else
                        self setweaponammoclip( var_3, var_5 );
                }
            }
        }
    }
}

addalienweaponammo( var_0 )
{
    var_1 = self getweaponslistprimaries();
    var_2 = check_for_nerf_min_ammo();

    if ( var_2 != 1.0 )
    {
        addratiomaxstocktoallweapons( var_2 );

        if ( var_0._ID34651 == 3 || var_0._ID34651 == 4 )
            addfullcliptoallweapons( var_2 );

        return;
    }

    switch ( var_0._ID34651 )
    {
        case 0:
            addratiomaxstocktoallweapons( 0.4 );
            break;
        case 1:
            addratiomaxstocktoallweapons( 0.7 );
            break;
        case 2:
            addratiomaxstocktoallweapons( 1.0 );
            break;
        case 3:
            addratiomaxstocktoallweapons( 1.0 );
            addfullcliptoallweapons();
            break;
        case 4:
            addratiomaxstocktoallweapons( 1.0 );
            addfullcliptoallweapons();
            break;
    }
}

check_for_nerf_min_ammo()
{
    return maps\mp\alien\_prestige::prestige_getminammo();
}

_ID37759( var_0 )
{
    maps\mp\alien\_deployablebox::_ID37082( var_0 );
    var_1 = 0;

    if ( isdefined( self.bodyarmorhp ) )
        var_1 = self.bodyarmorhp;

    var_2 = get_adjusted_armor( var_1, var_0._ID34651 );
    maps\mp\alien\_damage::_ID28656( var_2 );
    self notify( "enable_armor" );
}

get_adjusted_armor( var_0, var_1 )
{
    if ( var_0 + level._ID9660[var_1] > level._ID9659 )
        return level._ID9659;

    return var_0 + level._ID9660[var_1];
}

_ID37756( var_0 )
{
    maps\mp\alien\_deployablebox::_ID37082( var_0 );
    fillteamexplosives( var_0 );
}

fillteamexplosives( var_0 )
{
    if ( isdefined( var_0._ID34651 ) && var_0._ID34651 == 0 )
    {
        self setoffhandprimaryclass( "other" );
        _ID12847( "aliensemtex_mp", 2 );
        _ID12846( var_0, 4 );
    }

    if ( isdefined( var_0._ID34651 ) && var_0._ID34651 == 1 )
    {
        self setoffhandprimaryclass( "other" );
        _ID12847( "alienmortar_shell_mp", 2 );
        _ID12846( var_0, 6 );
    }

    if ( isdefined( var_0._ID34651 ) && var_0._ID34651 == 2 )
    {
        self setoffhandprimaryclass( "other" );
        _ID12847( "alienbetty_mp", 2 );
        _ID12846( var_0, 8 );
    }

    if ( isdefined( var_0._ID34651 ) && var_0._ID34651 == 3 )
    {
        self setoffhandprimaryclass( "other" );
        _ID12847( "alienclaymore_mp", 4 );
        _ID12846( var_0, 10 );
    }

    if ( isdefined( var_0._ID34651 ) && var_0._ID34651 == 4 )
    {
        self setoffhandprimaryclass( "other" );
        _ID12847( "alienbetty_mp", 5 );
        _ID12846( var_0, 12 );
    }
}

_ID12847( var_0, var_1 )
{
    var_2 = self getweaponslistoffhands();
    var_3 = 0;
    var_4 = undefined;
    var_5 = 0;

    foreach ( var_7 in var_2 )
    {
        if ( var_7 != var_0 )
        {
            if ( var_7 != "none" && var_7 != "alienthrowingknife_mp" && var_7 != "alienflare_mp" && var_7 != "alientrophy_mp" && var_7 != "iw6_aliendlc21_mp" )
                self takeweapon( var_7 );

            continue;
        }

        if ( isdefined( var_7 ) && var_7 != "none" )
        {
            var_5 = self getammocount( var_7 );
            self setweaponammostock( var_7, var_5 + var_1 );
            var_3 = 1;
            break;
        }
    }

    if ( var_3 == 0 )
    {
        maps\mp\_utility::_giveweapon( var_0 );
        self setweaponammostock( var_0, var_1 );
    }
}

_ID12846( var_0, var_1 )
{
    var_2 = self getweaponslistall();

    if ( isdefined( var_2 ) )
    {
        foreach ( var_4 in var_2 )
        {
            if ( maps\mp\alien\_unk1464::is_incompatible_weapon( var_4 ) )
                continue;

            var_5 = weaponclass( var_4 );
            var_6 = weaponinventorytype( var_4 );

            if ( var_4 != "iw6_alienmk32_mp" && var_4 != "iw6_alienmk321_mp" && var_4 != "iw6_alienmk322_mp" && var_4 != "iw6_alienmk323_mp" && var_4 != "iw6_alienmk324_mp" && var_4 != "aliensoflam_mp" )
            {
                if ( var_5 == "rocketlauncher" || var_5 == "grenade" )
                {
                    if ( var_6 == "primary" || var_6 == "altmode" )
                    {
                        var_7 = weaponclipsize( var_4 );
                        var_8 = check_for_nerf_min_ammo();
                        var_1 = int( var_1 * var_8 );
                        var_9 = self getweaponammostock( var_4 );
                        var_10 = var_9 + var_1;
                        var_11 = weaponmaxammo( var_4 );

                        if ( var_10 > var_11 )
                            var_10 = var_11;

                        self setweaponammostock( var_4, var_10 );
                    }
                }
            }
        }
    }
}
