class DrLevelGen extends Object
    config(Test);

// Takes a generated level graph and arranges the rooms according to
// the nodes and edges. Generates the halls during process
function ArrangeLevel( DrLevel Level )
{

}

function DrHall GenHall( int Type, DrHall Hall ) 
{
}

// Generates the level graph which contains info relating the sections, and edges
function DrLevel GenLevelGraph( array<DrSection> Sections, DrGraphStrategy Strat )
{
    local DrLevel Level;
    local int i, j;

    /* Must initialize rooms with strat to register touch events...*/
    for ( i = 0; i < Sections.Length; ++i ) {
        for ( j = 0; j < Sections[i].Rooms.Length; ++j ) {
            Sections[i].Rooms[j].GraphStrat = Strat;
        }
    }

    Level = Strat.GenLevelGraph( Sections );
    Level.AllSections = Sections;

    return Level;
}

function int Compare( DrSection a, DrSection b )
{
    return 1;
}

DefaultProperties
{
}
