class DrLevel extends Object;
//PerObjectConfig?

var DrSection Head; // Player starting section
var array<DrSection> AllSections;

function DrSection FindSectionOfBase( Actor Base )
{
    local int i;
    
    for ( i = 0; i < AllSections.Length; ++i ) {
        if ( AllSections[i].Attached[0] == Base ) {
            return AllSections[i];
        }
    }

    return none;
}

DefaultProperties
{
}
