// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID28786( var_0 )
{
    self setmodel( var_0[randomint( var_0.size )] );
}

_ID24851( var_0 )
{
    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        precachemodel( var_0[var_1] );
}

attachhead( var_0, var_1 )
{
    if ( !isdefined( level._ID6918 ) )
        level._ID6918 = [];

    if ( !isdefined( level._ID6918[var_0] ) )
        level._ID6918[var_0] = randomint( var_1.size );

    var_2 = ( level._ID6918[var_0] + 1 ) % var_1.size;

    if ( isdefined( self._ID27489 ) )
        var_2 = self._ID27489 % var_1.size;

    level._ID6918[var_0] = var_2;
    self attach( var_1[var_2], "", 1 );
    self._ID16458 = var_1[var_2];
}

attachhat( var_0, var_1 )
{
    if ( !isdefined( level._ID6917 ) )
        level._ID6917 = [];

    if ( !isdefined( level._ID6917[var_0] ) )
        level._ID6917[var_0] = randomint( var_1.size );

    var_2 = ( level._ID6917[var_0] + 1 ) % var_1.size;
    level._ID6917[var_0] = var_2;
    self attach( var_1[var_2] );
    self._ID16430 = var_1[var_2];
}

_ID21931()
{
    self detachall();
    var_0 = self.anim_gunhand;

    if ( !isdefined( var_0 ) )
        return;

    self.anim_gunhand = "none";
    self [[ anim._ID25174 ]]( var_0 );
}

_ID27292()
{
    var_0["gunHand"] = self.anim_gunhand;
    var_0["gunInHand"] = self.anim_guninhand;
    var_0["model"] = self.model;
    var_0["hatModel"] = self._ID16430;

    if ( isdefined( self.name ) )
    {
        var_0["name"] = self.name;
        jump loc_13F
    }

    var_1 = self getattachsize();

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        var_0["attach"][var_2]["model"] = self getattachmodelname( var_2 );
        var_0["attach"][var_2]["tag"] = self getattachtagname( var_2 );
    }

    return var_0;
}

load( var_0 )
{
    self detachall();
    self.anim_gunhand = var_0["gunHand"];
    self.anim_guninhand = var_0["gunInHand"];
    self setmodel( var_0["model"] );
    self._ID16430 = var_0["hatModel"];

    if ( isdefined( var_0["name"] ) )
    {
        self.name = var_0["name"];
        jump loc_1CF
    }

    var_1 = var_0["attach"];
    var_2 = var_1.size;

    for ( var_3 = 0; var_3 < var_2; var_3++ )
        self attach( var_1[var_3]["model"], var_1[var_3]["tag"] );
}

_ID24833( var_0 )
{
    if ( isdefined( var_0["name"] ) )
        jump loc_218

    precachemodel( var_0["model"] );
    var_1 = var_0["attach"];
    var_2 = var_1.size;

    for ( var_3 = 0; var_3 < var_2; var_3++ )
        precachemodel( var_1[var_3]["model"] );
}

_ID14704( var_0 )
{
    var_1 = strtok( self.classname, "_" );

    if ( !common_scripts\utility::_ID18787() )
    {
        if ( isdefined( self.pers["modelIndex"] ) && self.pers["modelIndex"] < var_0 )
            return self.pers["modelIndex"];

        var_2 = randomint( var_0 );
        self.pers["modelIndex"] = var_2;
        return var_2;
    }
    else if ( var_1.size <= 2 )
        return randomint( var_0 );

    var_3 = "auto";
    var_2 = undefined;
    var_4 = var_1[2];

    if ( isdefined( self._ID27489 ) )
        var_2 = self._ID27489;

    if ( isdefined( self._ID27488 ) )
    {
        var_5 = "grouped";
        var_3 = "group_" + self._ID27488;
    }

    if ( !isdefined( level._ID6919 ) )
        level._ID6919 = [];

    if ( !isdefined( level._ID6919[var_4] ) )
        level._ID6919[var_4] = [];

    if ( !isdefined( level._ID6919[var_4][var_3] ) )
        _ID17955( var_4, var_3, var_0 );

    if ( !isdefined( var_2 ) )
    {
        var_2 = _ID14546( var_4, var_3 );

        if ( !isdefined( var_2 ) )
            var_2 = randomint( 5000 );
    }

    while ( var_2 >= var_0 )
        var_2 -= var_0;

    level._ID6919[var_4][var_3][var_2]++;
    return var_2;
}

_ID14546( var_0, var_1 )
{
    var_2 = [];
    var_3 = level._ID6919[var_0][var_1][0];
    var_2[0] = 0;

    for ( var_4 = 1; var_4 < level._ID6919[var_0][var_1].size; var_4++ )
    {
        if ( level._ID6919[var_0][var_1][var_4] > var_3 )
            continue;

        if ( level._ID6919[var_0][var_1][var_4] < var_3 )
        {
            var_2 = [];
            var_3 = level._ID6919[var_0][var_1][var_4];
        }

        var_2[var_2.size] = var_4;
    }

    return _ID25350( var_2 );
}

_ID17955( var_0, var_1, var_2 )
{
    for ( var_3 = 0; var_3 < var_2; var_3++ )
        level._ID6919[var_0][var_1][var_3] = 0;
}

_ID14712( var_0 )
{
    return randomint( var_0 );
}

_ID25350( var_0 )
{
    return var_0[randomint( var_0.size )];
}
