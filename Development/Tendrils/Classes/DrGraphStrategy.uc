/*
 * Per level object used to determine level graph generation methods
 */
class DrGraphStrategy extends Object
    abstract;

function DrLevel GenLevelGraph( array<DrSection> Sections )
{
    return none;
}

DefaultProperties
{
}
