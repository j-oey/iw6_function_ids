// IW6 PC GSC
// Decompiled by https://github.com/xensik/gsc-tool

_ID20445()
{
    level._ID36722 = [];
    level._ID36718 = [];
    _ID37842();
    _ID27689();
}

_ID37842()
{
    precachempanim( "byard_shuttle_takeoff_success" );
    precachempanim( "byard_rocket_exploding_01" );
    precachempanim( "byard_major_debris_01_falling" );
    precachempanim( "byard_major_debris_02_falling" );
    precachempanim( "byard_major_debris_03_falling" );
    precachempanim( "byard_major_debris_04_falling" );
    precachempanim( "byard_major_debris_05_falling" );
}
#using_animtree("animated_props_dlc1");

_ID27689()
{
    level._ID36722["rocket_success"] = [];
    level._ID36722["rocket_success"]["launch"] = %byard_shuttle_takeoff_success;
    level._ID36718["rocket_success"] = [];
    level._ID36718["rocket_success"]["launch"] = "byard_shuttle_takeoff_success";
    level._ID36722["rocket_explo"] = [];
    level._ID36722["rocket_explo"]["launch"] = %byard_rocket_exploding_01;
    level._ID36722["rocket_explo"]["crash_01"] = %byard_major_debris_01_falling;
    level._ID36722["rocket_explo"]["crash_02"] = %byard_major_debris_02_falling;
    level._ID36722["rocket_explo"]["crash_03a"] = %byard_major_debris_04_falling;
    level._ID36722["rocket_explo"]["crash_03b"] = %byard_major_debris_05_falling;
    level._ID36722["rocket_explo"]["crash_04"] = %byard_major_debris_03_falling;
    level._ID36718["rocket_explo"] = [];
    level._ID36718["rocket_explo"]["launch"] = "byard_rocket_exploding_01";
    level._ID36718["rocket_explo"]["crash_01"] = "byard_major_debris_01_falling";
    level._ID36718["rocket_explo"]["crash_02"] = "byard_major_debris_02_falling";
    level._ID36718["rocket_explo"]["crash_03a"] = "byard_major_debris_04_falling";
    level._ID36718["rocket_explo"]["crash_03b"] = "byard_major_debris_05_falling";
    level._ID36718["rocket_explo"]["crash_04"] = "byard_major_debris_03_falling";
}
