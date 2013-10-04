/*
 * Per level object used to determine level graph generation methods
 */
class DrGraphStrategy extends Object
    abstract;

var bool bRoomCollisionFlag;

function DrLevel GenLevelGraph( array<DrSection> Sections );

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

function array<DrSectionLink> LinksConcat( array<DrSectionLink> All, array<DrSectionLink> ToAdd )
{
	local int i;

	for ( i = 0; i < ToAdd.Length; ++i ) { 
		All.AddItem( ToAdd[i] );
	}

	return All;
}

DefaultProperties
{
}
