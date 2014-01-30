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

    Level = Strat.GenLevelGraph( Sections, Strat.MostRecentLS );
    Level.AllSections = Sections;

    SpawnEnemies( Level );
    return Level;
}

function SpawnEnemies( DrLevel Level )
{
    local DrEnemyProxy proxy;

    foreach Level.Head.AllActors( class'DrEnemyProxy', proxy ) {
        Level.Head.Spawn( class'SandboxBot',,, proxy.Location, proxy.Rotation );
    }
}

function int Compare( DrSection a, DrSection b )
{
    return 1;
}

DefaultProperties
{
}
