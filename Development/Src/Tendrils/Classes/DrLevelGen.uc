class DrLevelGen extends Object
	config(Test);

// Takes a generated level graph and arranges the rooms according to
// the nodes and edges. Generates the halls during process
function ArrangeLevel( DrLevel Level )
{
	local DrSection Node;
	local Actor SectionBase;
	local DrHall HallNode;
	local float SideLen;
	local vector NewPos;
	local box BBox;
	local int i;

	Node = Level.Head;
	SideLen = 0.0;

	//while ( Node != none ) {
	for ( i = 0; i < Level.AllSections.Length; ++i ) {
		Node = Level.AllSections[i];
		SectionBase = Node.ParentRef;

		// If is Hall and static meshes have not been generated
		HallNode = DrHall( Node );
		if ( HallNode != none && HallNode.Attached.Length == 0 ) {
			HallNode = GenHall( 0, HallNode );
		}
		
		if ( SectionBase.Attached.Length == 0 ) {
			continue;
		}

		NewPos = vect( 0, 0, 0 );
		NewPos.Y = SideLen;
		SectionBase.SetLocation( NewPos );
		SectionBase.SetRotation( MakeRotator( 0, 90 * DegToUnrRot, 0 ) );
		
		SectionBase.GetComponentsBoundingBox( BBox );
		SideLen += BBox.Max.Y - BBox.Min.Y;
		`log( BBox.Max @ ", " @ BBox.Min );
		`log( "Moved level " @ i @ " here: " @ NewPos );
	}
}

function DrHall GenHall( int Type, DrHall Hall ) 
{
}

// Generates the level graph which contains info relating the sections, and edges
function DrLevel GenLevelGraph( array<DrSection> Sections, DrGraphStrategy Strat )
{
	//local DrLevel Level;
	//Level = new class'DrLevel';

	//Sections.Sort( Compare );

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
