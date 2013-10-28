class DrGraphCmp extends ActorComponent
    hidecategories(Object);

var DrSection Current;
var array<DrSection> AdjSections;     // Adj nodes
var array<DrSectionLink> LinkNodes;    // Edges

static function bool TryConnectSection( DrSectionLink ToAdd, DrSectionLink LevelLink )
{
    local int DeltaRot;
	local vector AboveSite, DestDelta, OriginalLoc, DoppleOffset, Doff;
    local Rotator OriginalRot;
    local int i;
    local InterpActor IA;
    
	OriginalRot = ToAdd.Src.Rotation;
    OriginalLoc = ToAdd.Src.Location;

	/* Base Yaw + Dest Link Yaw - ( 180 + Src Link Yaw ) */
    DeltaRot = ToAdd.Src.Rotation.Yaw + 
        LevelLink.Rotation.Yaw - class'DrUtils'.const.MAXROT - ToAdd.Rotation.Yaw;

    ToAdd.Move( vect( 0, 0, -10000 ) );
    DrSectionDoppler( ToAdd.Src ).AllSetRotation( MakeRotator( 0, DeltaRot, 0 ) );
    
	/* Move section to right above where we want to place it */
	AboveSite = LevelLink.Location + ToAdd.Src.Location - ToAdd.Location;
	AboveSite.Z = 30000;

    DrSectionDoppler( ToAdd.Src ).SetLocation( AboveSite );

	/* Lower section down into place, if a collision happens during this, Strat.bRoomCollisionFlag
	 * will be set by DrRoom...
	 */
	DestDelta = vect( 0, 0, 0 );
	DestDelta.Z = LevelLink.Location.Z - ToAdd.Location.Z;
    DrSectionDoppler( ToAdd.Src ).Move( DestDelta );
    /* Spawn a ghost version of room for detecting collision.. a bit hacky */
    //for ( i = 0; i < ToAdd.Src.Rooms.Length; ++i ) {
    //    if ( ToAdd.Src.Rooms[i].Dopple.bRoomCollisionFlag ) {
    //        ToAdd.Src.SetLocation( OriginalLoc );
    //        ToAdd.Src.SetRotation( OriginalRot );
    //        ToAdd.Src.Rooms[i].DestroyDopple();
    //        return false;
	   // }
    //    //ToAdd.Src.Rooms[0].DestroyDopple();
    //}
	//LevelLink.Src.Rooms[0].DestroyDopple();
    return true;
}

/* Assume adj sections are empty */
function DrGraphCmp CloneFor( DrSection Sec )
{
    local DrGraphCmp Graph;
    local DrSectionLink Link;
    local vector LinkOffset;
    local int i;
    local Actor Act;

    Graph = new class'DrGraphCmp';
    Graph.Current = Sec;

    for ( i = 0; i < LinkNodes.Length; ++i ) {
        LinkOffset = LinkNodes[i].Src.Location - LinkNodes[i].Location;
        Link = LinkNodes[i].Spawn( class'DrSectionLink',,, 
                                   Sec.Location + LinkOffset, 
                                   LinkNodes[i].Rotation );
        Link.Src = Sec;
        Link.SetBase( Sec,,, 'LinkAttach' );
        Graph.LinkNodes.AddItem( Link );
    }
   
    return Graph;
    
}

DefaultProperties
{
}
