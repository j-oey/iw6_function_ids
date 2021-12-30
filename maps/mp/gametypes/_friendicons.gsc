// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level.drawfriend = 0;
    game["headicon_allies"] = maps\mp\gametypes\_teams::_ID15416( "allies" );
    game["headicon_axis"] = maps\mp\gametypes\_teams::_ID15416( "axis" );
    precacheheadicon( game["headicon_allies"] );
    precacheheadicon( game["headicon_axis"] );
    precacheshader( "waypoint_revive" );
    level thread _ID22877();

    for (;;)
    {
        _ID34540();
        wait 5;
    }
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );
        var_0 thread onplayerspawned();
        var_0 thread _ID22886();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "spawned_player" );
        thread _ID29968();
    }
}

_ID22886()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "killed_player" );
        self.headicon = "";
    }
}

_ID29968()
{
    if ( level.drawfriend )
    {
        if ( self.pers["team"] == "allies" )
        {
            self.headicon = game["headicon_allies"];
            self.headiconteam = "allies";
            return;
        }

        self.headicon = game["headicon_axis"];
        self.headiconteam = "axis";
        return;
        return;
    }
}

_ID34540()
{
    var_0 = maps\mp\_utility::_ID15069( "scr_drawfriend", level.drawfriend );

    if ( level.drawfriend != var_0 )
    {
        level.drawfriend = var_0;
        _ID34539();
        return;
    }
}

_ID34539()
{
    var_0 = level.players;

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_2 = var_0[var_1];

        if ( isdefined( var_2.pers["team"] ) && var_2.pers["team"] != "spectator" && var_2.sessionstate == "playing" )
        {
            if ( level.drawfriend )
            {
                if ( var_2.pers["team"] == "allies" )
                {
                    var_2.headicon = game["headicon_allies"];
                    var_2.headiconteam = "allies";
                }
                else
                {
                    var_2.headicon = game["headicon_axis"];
                    var_2.headiconteam = "axis";
                }

                continue;
            }

            var_0 = level.players;

            for ( var_1 = 0; var_1 < var_0.size; var_1++ )
            {
                var_2 = var_0[var_1];

                if ( isdefined( var_2.pers["team"] ) && var_2.pers["team"] != "spectator" && var_2.sessionstate == "playing" )
                    var_2.headicon = "";
            }
        }
    }
}
