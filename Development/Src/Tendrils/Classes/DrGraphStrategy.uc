/*
 * Per level object used to determine level graph generation methods
 */
class DrGraphStrategy extends Object
    abstract;

var bool bRoomCollisionFlag;

function DrLevel GenLevelGraph( array<DrSection> Sections );

DefaultProperties
{
}
