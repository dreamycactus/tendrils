class DrGraphStratSimple extends DrGraphStrategy;

var DrDoor DOORMAN;

function DrLevel GenLevelGraph( array<DrSection> inSections, delegate<LinkSelect> LinkSelector )
{
	local int iter;
	local DrLevel out_Level;
    local array<DrSectionDoppler> Dopplers;

    /* Sink all sections down low low low low */
    for ( iter = 0; iter < inSections.Length; ++iter ) {
        inSections[iter].SetRelativeLocation( vect( 0, 0, -50000 ) );
    }

	iter = 0;
	while ( iter++ < 1 ) {
        Dopplers = GenDopplers( inSections, vect( 0, 0, 0 ) );
		if ( GenIter( Dopplers, out_Level, LinkSelector ) ) {
			break;
		}
		//CleanLinks( inSections );
	}
	
	if ( out_Level == none ) {
		`warn( "CRITICAL ERROR, UNABLE TO GENERATE FEASIBLE LEVEL" );
	}

	return out_Level;
}

function array<DrSectionDoppler> GenDopplers( array<DrSection> inSections, vector Offset )
{
    local array<DrSectionDoppler> Ret;
    local DrSectionDoppler Dop;
    local int i;

    for ( i = 0; i < inSections.Length; ++i ) {
        Offset.X = inSections[i].Location.X;
        Offset.Y = inSections[i].Location.Y;

        Dop = inSections[i].SpawnDopple( Offset );
        Ret.AddItem( Dop );
    }

    return Ret;
}

function bool GenIter( array<DrSectionDoppler> inSections, out DrLevel out_Level, delegate<LinkSelect> LinkSelector )
{
	local int i, j, k, l;
    local DrGraphCmp CurGraph;
    local array<DrSectionLink> OpenLinks, ShuffledLinks;
	local InterpActor IA;

    if ( inSections.Length == 0 ) { return true; }

    SortSections( inSections );
	
    inSections[0].AllSetLocation( vect( 0, 0, 0 ) );
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
				if ( class'DrGraphCmp'.static.TryConnectSection( ShuffledLinks[j], OpenLinks[l]) ) {
					`log( "Placed" @ inSections[i] @ "with" @ OpenLinks[l] @ "in section " @ OpenLinks[l].Src );

                    //ShuffledLinks[j].Spawn( class'DrDoor',,, ShuffledLinks[j].Location, ShuffledLinks[j].Rotation, DOORMAN );
					/* Update link edges */
					inSections[i].Graph.LinkNodes[ inSections[i].Graph.LinkNodes.Find( ShuffledLinks[j] ) ].Dest = OpenLinks[l].Src;
				    ShuffledLinks[j].Dest = OpenLinks[l].Src;
					OpenLinks[l].Dest = ShuffledLinks[j].Src;
					
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
    DOORMAN=DrDoor'MyTendrils.MyDoor'
}
