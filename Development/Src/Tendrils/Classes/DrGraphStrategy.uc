/*
 * Per level object used to determine level graph generation methods
 */
class DrGraphStrategy extends Object
    abstract;

var bool bRoomCollisionFlag;
delegate int LinkSelect( array<DrSectionLink> inLinks, int iter );

function DrLevel GenLevelGraph( array<DrSection> inSections, delegate<LinkSelect> LinkSelector );

static function CleanLinks( array<DrSection> inSections ) 
{
	local int i, j;

	for ( i = 0; i < inSections.Length; ++i ) {
		for ( j = 0; j < inSections[i].Graph.LinkNodes.Length; ++j ) {
			inSections[i].Graph.LinkNodes[j].Dest = none;
		}
	}
}


/* Too bad unrealscript has no generics.. Fisher Yates*/
static function array<DrSectionLink> ShuffleLinks( array<DrSectionLink> inLinks )
{
	local DrSectionLink L;
	local int i, k;

	for ( i = inLinks.Length - 1; i >= 0 ; --i ) {
		k = Rand( i + 1 );
		L = inLinks[k];
		inLinks[k] = inLinks[i];
		inLinks[i] = L;
	}

	return inLinks;
}

static function array<int> ShuffleInt( array<int> inLinks )
{
	local int L;
	local int i, k;

	for ( i = inLinks.Length - 1; i >= 0 ; --i ) {
		k = Rand( i + 1 );
		L = inLinks[k];
		inLinks[k] = inLinks[i];
		inLinks[i] = L;
	}

	return inLinks;
}

function bool VerifyLevel( array<DrSection> Sections ) {
    local int i, j;
    local bool bGood;
	local DrSectionLink SL;
    bGood = true;
    
    /* Verify each section has rooms */
    for ( i = 0; i < Sections.Length; ++i ) {
        if ( Sections[i].Attached.Length < 1 ) {
            `warn( "CRITICAL: Section " @ Sections[i] @ " has no rooms!");
            bGood = false;
        }
		if ( Sections[i].Base != none ) {
			`warn( "Section " @ Sections[i] @ " has a base... " );
		}
        if ( Sections[i].VolumeHint == none ) {
            `warn( "Section " @ Sections[i] @ " has no volume hint!" );
            bGood = false;
        }
    }

    return bGood;
}

function array<DrSectionLink> LinksConcat( array<DrSectionLink> All, array<DrSectionLink> ToAdd )
{
	local int i;

	for ( i = 0; i < ToAdd.Length; ++i ) { 
		All.AddItem( ToAdd[i] );
	}

	return All;
}

function array<DrSection> SortSections( array<DrSection> Sections )
{
    return Sections;
}

/* Depth first */
function int MostRecentLS( array<DrSectionLink> inLinks, int iter )
{
	return Max( inLinks.Length - 1 - iter, 0 );
}

/* Breadth first */
function int FirstLS( array<DrSectionLink> inLinks, int iter )
{
	return Min( iter, inLinks.Length - 1 );
}

/* Random */
function int RandomLS( array<DrSectionLink> inLinks, int iter )
{
	return Clamp( Rand( inLinks.Length ), 0, inLinks.Length - 1 );
}

DefaultProperties
{
}
