// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID17631()
{
    level thread _ID22877();
}

_ID22877()
{
    for (;;)
    {
        level waittill( "connected",  var_0  );

        if ( !isai( var_0 ) )
        {
            var_0.playercardpatch = var_0 getcacplayerdata( "patch" );
            var_0.playercardpatchbacking = var_0 getcacplayerdata( "patchbacking" );
            var_0.playercardbackground = var_0 getcacplayerdata( "background" );
        }
    }
}
