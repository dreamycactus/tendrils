class DrLevelGen extends Object
	config(Test);

// Takes a generated level graph and arranges the rooms according to
// the nodes and edges. Generates the halls during process
function ArrangeLevel( DrLevel Level )
{
	local DrSection Node;
	local DrHall HallNode;

	Node = Level.Head;

	while ( Node != none ) {
		HallNode = DrHall( Node );
		
		// If is Hall and static meshes have not been generated
		if ( HallNode != none && HallNode.Attached.Length == 0 ) {
			HallNode = GenHall( 0, HallNode );
		}


	}
}

function DrHall GenHall( int Type, DrHall Hall ) 
{
}

// Generates the level graph which contains info relating the sections, and edges
function DrLevel GenSectionGraph( array<DrSection> Sections )
{
	local DrLevel Level;

	Sections.Sort( Compare );


	Level.Head = Sections[0];
	return Level;
}

function int Compare( DrSection a, DrSection b )
{
	return 1;
}

DefaultProperties
{
}
