class DrGraphCmp extends ActorComponent
    hidecategories(Object);

var DrSection Current;
var array<DrSection> AdjSections;     // Adj nodes
var array<DrSectionLink> LinkNodes;    // Edges

static function bool TryConnectSection( DrGraphStrategy Strat, DrSectionLink ToAdd, DrSectionLink LevelLink )
{
    local int DeltaRot;
	local vector AboveSite, DestDelta, OriginalLoc;
    local Rotator OriginalRot;
    local int i;
    
	OriginalRot = ToAdd.Src.Rotation;
    OriginalLoc = ToAdd.Src.Location;

	/* Base Yaw + Dest Link Yaw - ( 180 + Src Link Yaw ) */
    DeltaRot = ToAdd.Src.Rotation.Yaw + 
        LevelLink.Rotation.Yaw - class'DrUtils'.const.MAXROT - ToAdd.Rotation.Yaw;

    ToAdd.Src.SetRotation( MakeRotator( 0, DeltaRot, 0 ) );
    
	/* Move section to right above where we want to place it */
	AboveSite = LevelLink.Location + ToAdd.Src.Location - ToAdd.Location;
	AboveSite.Z = 30000;

    ToAdd.Src.SetLocation( AboveSite );

	/* Lower section down into place, if a collision happens during this, Strat.bRoomCollisionFlag
	 * will be set by DrRoom...
	 */
	DestDelta = vect( 0, 0, 0 );
	DestDelta.Z = LevelLink.Location.Z - ToAdd.Location.Z;

    /* Spawn a ghost version of room for detecting collision.. a bit hacky */
    for ( i = 0; i < ToAdd.Src.Rooms.Length; ++i ) {
        ToAdd.Src.Rooms[i].SpawnDopple( ToAdd.Src );
        ToAdd.Src.Rooms[i].Dopple.Move( DestDelta );
        if ( ToAdd.Src.Rooms[i].Dopple.bRoomCollisionFlag ) {
            ToAdd.Src.SetLocation( OriginalLoc );
            ToAdd.Src.SetRotation( OriginalRot );
            ToAdd.Src.Rooms[i].DestroyDopple();
            return false;
	    }
        ToAdd.Src.Rooms[0].DestroyDopple();
    }
      
    ToAdd.Src.SetLocation( AboveSite + DestDelta );
    return true;
}

DefaultProperties
{
}
