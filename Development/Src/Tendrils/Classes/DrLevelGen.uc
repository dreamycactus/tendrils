// Top level level gen object. Calls the level gen strategy, spawns enemies
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
	local DrSectionLink link;
    local DrPlayerStart PS;
    local DrPawnRookie Rookie;
    local InterpActor IA;

    Level = Strat.GenLevelGraph( Sections, Strat.MostRecentLS );
    Level.AllSections = Sections;

    SpawnEnemies( Level );

    foreach Level.Head.AllActors( class'DrSectionLink', link ) {
		link.CollisionComponent=link.StaticMeshComponent;
		link.SetCollisionType(COLLIDE_BlockAll);
		link.SetCollision( true, true, true );
    }

    foreach Level.Head.AllActors( class'InterpActor', IA ) {
        IA.SetCollisionType(COLLIDE_BlockAll);
        IA.SetCollision(true, true, true );
    }
    return Level;
}

function SpawnEnemies( DrLevel Level )
{
    local DrEnemyProxy proxy;
    local int enemyType;

    foreach Level.Head.AllActors( class'DrEnemyProxy', proxy ) {
        enemyType = proxy.EnemyType == -1 ? Rand (2) : proxy.EnemyType;
        switch(enemyType) {
        case 0:
            Level.Head.Spawn( class'DrPawnZombie',,, proxy.Location, proxy.Rotation );
            break;
        case 1:
            Level.Head.Spawn( class'SandboxBot',,, proxy.Location, proxy.Rotation );
            break;
        case 4:
            Level.Head.Spawn( class'DrPawnDrone',,, proxy.Location, proxy.Rotation );
            break;
        }
    }
}

function int Compare( DrSection a, DrSection b )
{
    return 1;
}

DefaultProperties
{
}
