class DrGraphStratSimple extends DrGraphStrategy;

function DrLevel GenLevelGraph( array<DrSection> inSections, delegate<LinkSelect> LinkSelector )
{
	local int iter;
	local DrLevel out_Level;

	iter = 0;
	while ( iter++ < 20 ) {
		if ( GenIter( inSections, out_Level, LinkSelector ) ) {
			break;
		}
		CleanLinks( inSections );
	}
	
	if ( out_Level == none ) {
		`warn( "CRITICAL ERROR, UNABLE TO GENERATE FEASIBLE LEVEL" );
	}

	return out_Level;
}

function bool GenIter( array<DrSection> inSections, out DrLevel out_Level, delegate<LinkSelect> LinkSelector )
{
	local int i, j, k, l;
    local DrGraphCmp CurGraph;
    local array<DrSectionLink> OpenLinks, ShuffledLinks;

    if ( inSections.Length == 0 ) { return true; }

    SortSections( inSections );
	
	inSections[0].SetLocation( vect( 0, 0, 0 ) );
	OpenLinks = LinksConcat( OpenLinks, ShuffleLinks( inSections[0].Graph.LinkNodes ) );

    for ( i = 1; i < inSections.Length; ++i ) {
        `log( "Looking at " @ inSections[i] );
        CurGraph = inSections[i].Graph;
		ShuffledLinks = ShuffleLinks( CurGraph.LinkNodes );
        for ( j = 0; j < ShuffledLinks.Length; ++j ) {
			/* Allow different selection strategies for picking which nodes on open list
			 * to examine. Limit the number of tries to the number of openlinks */
			k = -1;
			while ( OpenLinks.Length != 0 && k++ < Max( OpenLinks.Length, 10 ) ) {
				l = LinkSelector( OpenLinks, l );
				if ( class'DrGraphCmp'.static.TryConnectSection( self, ShuffledLinks[j], OpenLinks[k]) ) {
					`log( "Placed" @ inSections[i] @ "with" @ OpenLinks[k] @ "in section " @ OpenLinks[k].Src );
					/* Update link edges */
					inSections[i].Graph.LinkNodes[ inSections[i].Graph.LinkNodes.Find( ShuffledLinks[j] ) ].Dest = OpenLinks[k].Src;
				    ShuffledLinks[j].Dest = OpenLinks[k].Src;
					OpenLinks[k].Dest = ShuffledLinks[j].Src;
					
					/* add current node links to open list; remove connection link */
					ShuffledLinks.Remove( j, 1 );
					OpenLinks.Remove( l, 1 );
					OpenLinks = LinksConcat( OpenLinks, ShuffledLinks );
					goto SUCCESS;
				}
			}
        }
		/* Failed to find any node to attach section. Need to restart */
		CleanLinks( inSections );
		out_Level = none;
		return false;
SUCCESS:

    }

    out_Level = new class'DrLevel';
    out_Level.Head = inSections[0];
    out_Level.AllSections = inSections;

    return true;
}

DefaultProperties
{
}
