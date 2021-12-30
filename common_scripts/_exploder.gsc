// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

setup_individual_exploder( var_0 )
{
    var_1 = var_0._ID27562;

    if ( !isdefined( level._ID12490[var_1] ) )
        level._ID12490[var_1] = [];

    var_2 = var_0.targetname;

    if ( !isdefined( var_2 ) )
        var_2 = "";

    level._ID12490[var_1][level._ID12490[var_1].size] = var_0;

    if ( _ID12479( var_0 ) )
    {
        var_0 hide();
        return;
    }

    if ( _ID12478( var_0 ) )
    {
        var_0 hide();
        var_0 notsolid();

        if ( isdefined( var_0.spawnflags ) && var_0.spawnflags & 1 )
        {
            if ( isdefined( var_0._ID27530 ) )
                var_0 connectpaths();
        }

        return;
    }

    if ( exploder_model_is_chunk( var_0 ) )
    {
        var_0 hide();
        var_0 notsolid();

        if ( isdefined( var_0.spawnflags ) && var_0.spawnflags & 1 )
            var_0 connectpaths();

        return;
    }
}

_ID29176()
{
    level._ID12490 = [];
    var_0 = getentarray( "script_brushmodel", "classname" );
    var_1 = getentarray( "script_model", "classname" );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        var_0[var_0.size] = var_1[var_2];

    foreach ( var_4 in var_0 )
    {
        if ( isdefined( var_4._ID27779 ) )
            var_4._ID27562 = var_4._ID27779;

        if ( isdefined( var_4._ID20658 ) )
            continue;

        if ( isdefined( var_4._ID27562 ) )
            setup_individual_exploder( var_4 );
    }

    var_6 = [];
    var_7 = getentarray( "script_brushmodel", "classname" );

    for ( var_2 = 0; var_2 < var_7.size; var_2++ )
    {
        if ( isdefined( var_7[var_2]._ID27779 ) )
            var_7[var_2]._ID27562 = var_7[var_2]._ID27779;

        if ( isdefined( var_7[var_2]._ID27562 ) )
            var_6[var_6.size] = var_7[var_2];
    }

    var_7 = getentarray( "script_model", "classname" );

    for ( var_2 = 0; var_2 < var_7.size; var_2++ )
    {
        if ( isdefined( var_7[var_2]._ID27779 ) )
            var_7[var_2]._ID27562 = var_7[var_2]._ID27779;

        if ( isdefined( var_7[var_2]._ID27562 ) )
            var_6[var_6.size] = var_7[var_2];
    }

    var_7 = getentarray( "item_health", "classname" );

    for ( var_2 = 0; var_2 < var_7.size; var_2++ )
    {
        if ( isdefined( var_7[var_2]._ID27779 ) )
            var_7[var_2]._ID27562 = var_7[var_2]._ID27779;

        if ( isdefined( var_7[var_2]._ID27562 ) )
            var_6[var_6.size] = var_7[var_2];
    }

    var_7 = level.struct;

    for ( var_2 = 0; var_2 < var_7.size; var_2++ )
    {
        if ( !isdefined( var_7[var_2] ) )
            continue;

        if ( isdefined( var_7[var_2]._ID27779 ) )
            var_7[var_2]._ID27562 = var_7[var_2]._ID27779;

        if ( isdefined( var_7[var_2]._ID27562 ) )
        {
            if ( !isdefined( var_7[var_2].angles ) )
                var_7[var_2].angles = ( 0, 0, 0 );

            var_6[var_6.size] = var_7[var_2];
        }
    }

    if ( !isdefined( level._ID8435 ) )
        level._ID8435 = [];

    var_8 = [];
    var_8["exploderchunk visible"] = 1;
    var_8["exploderchunk"] = 1;
    var_8["exploder"] = 1;
    thread _ID29010();

    for ( var_2 = 0; var_2 < var_6.size; var_2++ )
    {
        var_9 = var_6[var_2];
        var_4 = common_scripts\utility::createexploder( var_9._ID27611 );
        var_4._ID34830 = [];
        var_4._ID34830["origin"] = var_9.origin;
        var_4._ID34830["angles"] = var_9.angles;
        var_4._ID34830["delay"] = var_9.script_delay;
        var_4._ID34830["delay_post"] = var_9._ID27520;
        var_4._ID34830["firefx"] = var_9.script_firefx;
        var_4._ID34830["firefxdelay"] = var_9._ID27574;
        var_4._ID34830["firefxsound"] = var_9._ID27575;
        var_4._ID34830["earthquake"] = var_9._ID27551;
        var_4._ID34830["rumble"] = var_9.script_rumble;
        var_4._ID34830["damage"] = var_9._ID27506;
        var_4._ID34830["damage_radius"] = var_9._ID27783;
        var_4._ID34830["soundalias"] = var_9._ID27819;
        var_4._ID34830["repeat"] = var_9._ID27787;
        var_4._ID34830["delay_min"] = var_9._ID27519;
        var_4._ID34830["delay_max"] = var_9._ID27518;
        var_4._ID34830["target"] = var_9.target;
        var_4._ID34830["ender"] = var_9._ID27553;
        var_4._ID34830["physics"] = var_9.script_physics;
        var_4._ID34830["type"] = "exploder";

        if ( !isdefined( var_9._ID27611 ) )
            var_4._ID34830["fxid"] = "No FX";
        else
            var_4._ID34830["fxid"] = var_9._ID27611;

        var_4._ID34830["exploder"] = var_9._ID27562;

        if ( isdefined( level.createfxexploders ) )
        {
            var_10 = level.createfxexploders[var_4._ID34830["exploder"]];

            if ( !isdefined( var_10 ) )
                var_10 = [];

            var_10[var_10.size] = var_4;
            level.createfxexploders[var_4._ID34830["exploder"]] = var_10;
        }

        if ( !isdefined( var_4._ID34830["delay"] ) )
            var_4._ID34830["delay"] = 0;

        if ( isdefined( var_9.target ) )
        {
            var_11 = getentarray( var_4._ID34830["target"], "targetname" )[0];

            if ( isdefined( var_11 ) )
            {
                var_12 = var_11.origin;
                var_4._ID34830["angles"] = vectortoangles( var_12 - var_4._ID34830["origin"] );
            }
            else
            {
                var_11 = common_scripts\utility::_ID14781( var_4._ID34830["target"] );

                if ( isdefined( var_11 ) )
                {
                    var_12 = var_11.origin;
                    var_4._ID34830["angles"] = vectortoangles( var_12 - var_4._ID34830["origin"] );
                }
            }
        }

        if ( !isdefined( var_9.code_classname ) )
        {
            var_4.model = var_9;

            if ( isdefined( var_4.model._ID27693 ) )
                precachemodel( var_4.model._ID27693 );
        }
        else if ( var_9.code_classname == "script_brushmodel" || isdefined( var_9.model ) )
        {
            var_4.model = var_9;
            var_4.model.disconnect_paths = var_9._ID27530;
        }

        if ( isdefined( var_9.targetname ) && isdefined( var_8[var_9.targetname] ) )
            var_4._ID34830["exploder_type"] = var_9.targetname;
        else
            var_4._ID34830["exploder_type"] = "normal";

        if ( isdefined( var_9._ID20658 ) )
        {
            var_4._ID34830["masked_exploder"] = var_9.model;
            var_4._ID34830["masked_exploder_spawnflags"] = var_9.spawnflags;
            var_4._ID34830["masked_exploder_script_disconnectpaths"] = var_9._ID27530;
            var_9 delete();
        }

        var_4 common_scripts\_createfx::_ID24771();
    }
}

_ID29010()
{
    waittillframeend;
    waittillframeend;
    waittillframeend;
    var_0 = [];

    foreach ( var_2 in level._ID8435 )
    {
        if ( var_2._ID34830["type"] != "exploder" )
            continue;

        var_3 = var_2._ID34830["flag"];

        if ( !isdefined( var_3 ) )
            continue;

        if ( var_3 == "nil" )
            var_2._ID34830["flag"] = undefined;

        var_0[var_3] = 1;
    }

    foreach ( var_7, var_6 in var_0 )
        thread exploder_flag_wait( var_7 );
}

exploder_flag_wait( var_0 )
{
    if ( !common_scripts\utility::flag_exist( var_0 ) )
        common_scripts\utility::_ID13189( var_0 );

    common_scripts\utility::flag_wait( var_0 );

    foreach ( var_2 in level._ID8435 )
    {
        if ( var_2._ID34830["type"] != "exploder" )
            continue;

        var_3 = var_2._ID34830["flag"];

        if ( !isdefined( var_3 ) )
            continue;

        if ( var_3 != var_0 )
            continue;

        var_2 common_scripts\utility::activate_individual_exploder();
    }
}

_ID12478( var_0 )
{
    return isdefined( var_0.targetname ) && var_0.targetname == "exploder";
}

_ID12479( var_0 )
{
    return var_0.model == "fx" && ( !isdefined( var_0.targetname ) || var_0.targetname != "exploderchunk" );
}

exploder_model_is_chunk( var_0 )
{
    return isdefined( var_0.targetname ) && var_0.targetname == "exploderchunk";
}

_ID29921( var_0 )
{
    var_0 += "";

    if ( isdefined( level.createfxexploders ) )
    {
        var_1 = level.createfxexploders[var_0];

        if ( isdefined( var_1 ) )
        {
            foreach ( var_3 in var_1 )
            {
                if ( !_ID12479( var_3.model ) && !_ID12478( var_3.model ) && !exploder_model_is_chunk( var_3.model ) )
                    var_3.model show();

                if ( isdefined( var_3._ID6135 ) )
                    var_3.model show();
            }

            return;
        }
    }
    else
    {
        for ( var_5 = 0; var_5 < level._ID8435.size; var_5++ )
        {
            var_3 = level._ID8435[var_5];

            if ( !isdefined( var_3 ) )
                continue;

            if ( var_3._ID34830["type"] != "exploder" )
                continue;

            if ( !isdefined( var_3._ID34830["exploder"] ) )
                continue;

            if ( var_3._ID34830["exploder"] + "" != var_0 )
                continue;

            if ( isdefined( var_3.model ) )
            {
                if ( !_ID12479( var_3.model ) && !_ID12478( var_3.model ) && !exploder_model_is_chunk( var_3.model ) )
                    var_3.model show();

                if ( isdefined( var_3._ID6135 ) )
                    var_3.model show();
            }
        }
    }
}

_ID31779( var_0 )
{
    var_0 += "";

    if ( isdefined( level.createfxexploders ) )
    {
        var_1 = level.createfxexploders[var_0];

        if ( isdefined( var_1 ) )
        {
            foreach ( var_3 in var_1 )
            {
                if ( !isdefined( var_3._ID20339 ) )
                    continue;

                var_3._ID20339 delete();
            }

            return;
        }
    }
    else
    {
        for ( var_5 = 0; var_5 < level._ID8435.size; var_5++ )
        {
            var_3 = level._ID8435[var_5];

            if ( !isdefined( var_3 ) )
                continue;

            if ( var_3._ID34830["type"] != "exploder" )
                continue;

            if ( !isdefined( var_3._ID34830["exploder"] ) )
                continue;

            if ( var_3._ID34830["exploder"] + "" != var_0 )
                continue;

            if ( !isdefined( var_3._ID20339 ) )
                continue;

            var_3._ID20339 delete();
        }
    }
}

_ID14454( var_0 )
{
    var_0 += "";
    var_1 = [];

    if ( isdefined( level.createfxexploders ) )
    {
        var_2 = level.createfxexploders[var_0];

        if ( isdefined( var_2 ) )
            var_1 = var_2;
    }
    else
    {
        foreach ( var_4 in level._ID8435 )
        {
            if ( var_4._ID34830["type"] != "exploder" )
                continue;

            if ( !isdefined( var_4._ID34830["exploder"] ) )
                continue;

            if ( var_4._ID34830["exploder"] + "" != var_0 )
                continue;

            var_1[var_1.size] = var_4;
        }
    }

    return var_1;
}

_ID16862( var_0 )
{
    var_0 += "";

    if ( isdefined( level.createfxexploders ) )
    {
        var_1 = level.createfxexploders[var_0];

        if ( isdefined( var_1 ) )
        {
            foreach ( var_3 in var_1 )
            {
                if ( isdefined( var_3.model ) )
                    var_3.model hide();
            }

            return;
        }
    }
    else
    {
        for ( var_5 = 0; var_5 < level._ID8435.size; var_5++ )
        {
            var_3 = level._ID8435[var_5];

            if ( !isdefined( var_3 ) )
                continue;

            if ( var_3._ID34830["type"] != "exploder" )
                continue;

            if ( !isdefined( var_3._ID34830["exploder"] ) )
                continue;

            if ( var_3._ID34830["exploder"] + "" != var_0 )
                continue;

            if ( isdefined( var_3.model ) )
                var_3.model hide();
        }
    }
}

_ID9550( var_0 )
{
    var_0 += "";

    if ( isdefined( level.createfxexploders ) )
    {
        var_1 = level.createfxexploders[var_0];

        if ( isdefined( var_1 ) )
        {
            foreach ( var_3 in var_1 )
            {
                if ( isdefined( var_3.model ) )
                    var_3.model delete();
            }
        }
    }
    else
    {
        for ( var_5 = 0; var_5 < level._ID8435.size; var_5++ )
        {
            var_3 = level._ID8435[var_5];

            if ( !isdefined( var_3 ) )
                continue;

            if ( var_3._ID34830["type"] != "exploder" )
                continue;

            if ( !isdefined( var_3._ID34830["exploder"] ) )
                continue;

            if ( var_3._ID34830["exploder"] + "" != var_0 )
                continue;

            if ( isdefined( var_3.model ) )
                var_3.model delete();
        }
    }

    level notify( "killexplodertridgers" + var_0 );
}

exploder_damage()
{
    if ( isdefined( self._ID34830["delay"] ) )
        var_0 = self._ID34830["delay"];
    else
        var_0 = 0;

    if ( isdefined( self._ID34830["damage_radius"] ) )
        var_1 = self._ID34830["damage_radius"];
    else
        var_1 = 128;

    var_2 = self._ID34830["damage"];
    var_3 = self._ID34830["origin"];
    wait(var_0);

    if ( isdefined( level.custom_radius_damage_for_exploders ) )
        [[ level.custom_radius_damage_for_exploders ]]( var_3, var_1, var_2 );
    else
        radiusdamage( var_3, var_1, var_2, var_2 );
}

activate_individual_exploder_proc()
{
    if ( isdefined( self._ID34830["firefx"] ) )
        thread _ID12981();

    if ( isdefined( self._ID34830["fxid"] ) && self._ID34830["fxid"] != "No FX" )
        thread _ID6610();
    else if ( isdefined( self._ID34830["soundalias"] ) && self._ID34830["soundalias"] != "nil" )
        thread sound_effect();

    if ( isdefined( self._ID34830["loopsound"] ) && self._ID34830["loopsound"] != "nil" )
        thread _ID11246();

    if ( isdefined( self._ID34830["damage"] ) )
        thread exploder_damage();

    if ( isdefined( self._ID34830["earthquake"] ) )
        thread exploder_earthquake();

    if ( isdefined( self._ID34830["rumble"] ) )
        thread _ID12482();

    if ( self._ID34830["exploder_type"] == "exploder" )
        thread _ID6134();
    else if ( self._ID34830["exploder_type"] == "exploderchunk" || self._ID34830["exploder_type"] == "exploderchunk visible" )
        thread _ID6136();
    else
        thread _ID6133();
}

_ID6133()
{
    var_0 = self._ID34830["exploder"];

    if ( isdefined( self._ID34830["delay"] ) )
        wait(self._ID34830["delay"]);
    else
        wait 0.05;

    if ( !isdefined( self.model ) )
        return;

    if ( isdefined( self.model.classname ) )
    {
        if ( common_scripts\utility::_ID18787() && self.model.spawnflags & 1 )
            self.model call [[ level._ID7872 ]]();
    }

    if ( level._ID8425 )
    {
        if ( isdefined( self.exploded ) )
            return;

        self.exploded = 1;
        self.model hide();
        self.model notsolid();
        wait 3;
        self.exploded = undefined;
        self.model show();
        self.model solid();
        return;
    }

    if ( !isdefined( self._ID34830["fxid"] ) || self._ID34830["fxid"] == "No FX" )
        self._ID34830["exploder"] = undefined;

    waittillframeend;

    if ( isdefined( self.model ) && isdefined( self.model.classname ) )
        self.model delete();
}

_ID6136()
{
    if ( isdefined( self._ID34830["delay"] ) )
        wait(self._ID34830["delay"]);

    var_0 = undefined;

    if ( isdefined( self._ID34830["target"] ) )
        var_0 = common_scripts\utility::_ID14781( self._ID34830["target"] );

    if ( !isdefined( var_0 ) )
    {
        self.model delete();
        return;
    }

    self.model show();

    if ( isdefined( self._ID34830["delay_post"] ) )
        wait(self._ID34830["delay_post"]);

    var_1 = self._ID34830["origin"];
    var_2 = self._ID34830["angles"];
    var_3 = var_0.origin;
    var_4 = var_3 - self._ID34830["origin"];
    var_5 = var_4[0];
    var_6 = var_4[1];
    var_7 = var_4[2];
    var_8 = isdefined( self._ID34830["physics"] );

    if ( var_8 )
    {
        var_9 = undefined;

        if ( isdefined( var_0.target ) )
            var_9 = var_0 common_scripts\utility::_ID14781();

        if ( !isdefined( var_9 ) )
        {
            var_10 = var_1;
            var_11 = var_0.origin;
        }
        else
        {
            var_10 = var_0.origin;
            var_11 = ( var_9.origin - var_0.origin ) * self._ID34830["physics"];
        }

        self.model physicslaunchclient( var_10, var_11 );
        return;
    }
    else
    {
        self.model rotatevelocity( ( var_5, var_6, var_7 ), 12 );
        self.model movegravity( ( var_5, var_6, var_7 ), 12 );
    }

    if ( level._ID8425 )
    {
        if ( isdefined( self.exploded ) )
            return;

        self.exploded = 1;
        wait 3;
        self.exploded = undefined;
        self._ID34830["origin"] = var_1;
        self._ID34830["angles"] = var_2;
        self.model hide();
        return;
    }

    self._ID34830["exploder"] = undefined;
    wait 6;
    self.model delete();
}

_ID6134()
{
    if ( isdefined( self._ID34830["delay"] ) )
        wait(self._ID34830["delay"]);

    if ( !isdefined( self.model._ID27693 ) )
    {
        self.model show();
        self.model solid();
    }
    else
    {
        var_0 = self.model common_scripts\utility::_ID30774();

        if ( isdefined( self.model.script_linkname ) )
            var_0.script_linkname = self.model.script_linkname;

        var_0 setmodel( self.model._ID27693 );
        var_0 show();
    }

    self._ID6135 = 1;

    if ( common_scripts\utility::_ID18787() && !isdefined( self.model._ID27693 ) && self.model.spawnflags & 1 )
    {
        if ( !isdefined( self.model.disconnect_paths ) )
            self.model call [[ level._ID7872 ]]();
        else
            self.model call [[ level._ID10188 ]]();
    }

    if ( level._ID8425 )
    {
        if ( isdefined( self.exploded ) )
            return;

        self.exploded = 1;
        wait 3;
        self.exploded = undefined;

        if ( !isdefined( self.model._ID27693 ) )
        {
            self.model hide();
            self.model notsolid();
        }
    }
}

_ID12482()
{
    if ( !common_scripts\utility::_ID18787() )
        return;

    _ID12472();
    level.player playrumbleonentity( self._ID34830["rumble"] );
}

_ID12472()
{
    if ( !isdefined( self._ID34830["delay"] ) )
        self._ID34830["delay"] = 0;

    var_0 = self._ID34830["delay"];
    var_1 = self._ID34830["delay"] + 0.001;

    if ( isdefined( self._ID34830["delay_min"] ) )
        var_0 = self._ID34830["delay_min"];

    if ( isdefined( self._ID34830["delay_max"] ) )
        var_1 = self._ID34830["delay_max"];

    if ( var_0 > 0 )
        wait(randomfloatrange( var_0, var_1 ));
}

_ID11246()
{
    if ( isdefined( self._ID20357 ) )
        self._ID20357 delete();

    var_0 = self._ID34830["origin"];
    var_1 = self._ID34830["loopsound"];
    _ID12472();
    self._ID20357 = common_scripts\utility::_ID23798( var_1, var_0 );
}

sound_effect()
{
    effect_soundalias();
}

effect_soundalias()
{
    var_0 = self._ID34830["origin"];
    var_1 = self._ID34830["soundalias"];
    _ID12472();
    common_scripts\utility::_ID23839( var_1, var_0 );
}

exploder_earthquake()
{
    _ID12472();
    common_scripts\utility::do_earthquake( self._ID34830["earthquake"], self._ID34830["origin"] );
}

_ID12480()
{
    if ( !isdefined( self._ID34830["soundalias"] ) || self._ID34830["soundalias"] == "nil" )
        return;

    common_scripts\utility::_ID23839( self._ID34830["soundalias"], self._ID34830["origin"] );
}

_ID12981()
{
    var_0 = self._ID34830["forward"];
    var_1 = self._ID34830["up"];
    var_2 = undefined;
    var_3 = self._ID34830["firefxsound"];
    var_4 = self._ID34830["origin"];
    var_5 = self._ID34830["firefx"];
    var_6 = self._ID34830["ender"];

    if ( !isdefined( var_6 ) )
        var_6 = "createfx_effectStopper";

    var_7 = 0.5;

    if ( isdefined( self._ID34830["firefxdelay"] ) )
        var_7 = self._ID34830["firefxdelay"];

    _ID12472();

    if ( isdefined( var_3 ) )
        common_scripts\utility::_ID20328( var_3, var_4, 1, var_6 );

    playfx( level._ID1644[var_5], self._ID34830["origin"], var_0, var_1 );
}

_ID6610()
{
    if ( isdefined( self._ID34830["repeat"] ) )
    {
        thread _ID12480();

        for ( var_0 = 0; var_0 < self._ID34830["repeat"]; var_0++ )
        {
            playfx( level._ID1644[self._ID34830["fxid"]], self._ID34830["origin"], self._ID34830["forward"], self._ID34830["up"] );
            _ID12472();
        }

        return;
    }

    _ID12472();

    if ( isdefined( self._ID20339 ) )
        self._ID20339 delete();

    self._ID20339 = spawnfx( common_scripts\utility::_ID15033( self._ID34830["fxid"] ), self._ID34830["origin"], self._ID34830["forward"], self._ID34830["up"] );
    triggerfx( self._ID20339 );
    _ID12480();
}

activate_exploder( var_0, var_1, var_2 )
{
    var_0 += "";
    level notify( "exploding_" + var_0 );
    var_3 = 0;

    if ( isdefined( level.createfxexploders ) && !level._ID8425 )
    {
        var_4 = level.createfxexploders[var_0];

        if ( isdefined( var_4 ) )
        {
            foreach ( var_6 in var_4 )
            {
                var_6 common_scripts\utility::activate_individual_exploder();
                var_3 = 1;
            }
        }
    }
    else
    {
        for ( var_8 = 0; var_8 < level._ID8435.size; var_8++ )
        {
            var_6 = level._ID8435[var_8];

            if ( !isdefined( var_6 ) )
                continue;

            if ( var_6._ID34830["type"] != "exploder" )
                continue;

            if ( !isdefined( var_6._ID34830["exploder"] ) )
                continue;

            if ( var_6._ID34830["exploder"] + "" != var_0 )
                continue;

            var_6 common_scripts\utility::activate_individual_exploder();
            var_3 = 1;
        }
    }

    if ( !_ID29887() && !var_3 )
        activate_clientside_exploder( var_0, var_1, var_2 );
}

activate_clientside_exploder( var_0, var_1, var_2 )
{
    if ( !_ID18513( var_0 ) )
        return;

    var_3 = int( var_0 );
    activateclientexploder( var_3, var_1, var_2 );
}

_ID18513( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    var_1 = var_0;

    if ( isstring( var_0 ) )
    {
        var_1 = int( var_0 );

        if ( var_1 == 0 && var_0 != "0" )
            return 0;
    }

    return var_1 >= 0;
}

_ID29887()
{
    if ( common_scripts\utility::_ID18787() )
        return 1;

    if ( !isdefined( level._ID8425 ) )
        level._ID8425 = getdvar( "createfx" ) != "";

    if ( level._ID8425 )
        return 1;
    else
        return getdvar( "clientSideEffects" ) != "1";
}

_ID12467( var_0, var_1, var_2 )
{
    waittillframeend;
    waittillframeend;
    activate_exploder( var_0, var_1, var_2 );
}

exploder_after_load( var_0, var_1, var_2 )
{
    activate_exploder( var_0, var_1, var_2 );
}
