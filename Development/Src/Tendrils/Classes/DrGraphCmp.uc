class DrGraphCmp extends ActorComponent
    hidecategories(Object);

var DrSection Current;
var array<DrSection> AdjSections;     // Adj nodes
var array<DrSectionLink> LinkNodes;    // Edges

static function bool TryConnectSection( DrGraphStrategy Strat, DrSectionLink ToAdd, DrSectionLink LevelLink )
{
    local int DeltaRot;
	local vector OriginalLoc, AboveSite, DestSite;
	local rotator OriginalRot;
    
	OriginalLoc = ToAdd.Src.Location;
	OriginalRot = ToAdd.Src.Rotation;

	/* Base Yaw + Dest Link Yaw - ( 180 + Src Link Yaw ) */
    DeltaRot = ToAdd.Src.Rotation.Yaw + 
        LevelLink.Rotation.Yaw - class'DrUtils'.const.MAXROT - ToAdd.Rotation.Yaw;

	/* Move section to right above where we want to place it */
	AboveSite = LevelLink.Location - ToAdd.Src.Location + ToAdd.Location;
	AboveSite.Z = 30000;
	ToAdd.Src.SetLocation( AboveSite );
	ToAdd.Src.SetRotation( MakeRotator( 0, DeltaRot, 0 ) );

	/* Lower section down into place, if a collision happens during this, Strat.bRoomCollisionFlag
	 * will be set by DrRoom...
	 */
	DestSite = vect( 0, 0, 0 );
	DestSite.Z = LevelLink.Location.Z - ToAdd.Location.Z;
    Strat.bRoomCollisionFlag = false; // Set flag before move

    /* Spawn a ghost version of room for detecting collision.. a bit hacky */
    ToAdd.Src.Rooms[0].SpawnDopple( Strat );
    ToAdd.Src.Rooms[0].Dopple.Move( DestSite );
    ToAdd.Src.Rooms[0].Dopple.Destroy();
    ToAdd.Src.Rooms[0].Dopple = none;
    
	`log( "Trying to place section\nRotating section by " @ UnrRotToDeg * DeltaRot );
	`log( "From" @ LevelLink.Location @ " to " @ ToAdd.Location );
    `log( "Moved Section by" @ ( LevelLink.Location - ToAdd.Location ) );

	if ( Strat.bRoomCollisionFlag ) {
		ToAdd.Src.SetLocation( OriginalLoc );
		ToAdd.Src.SetRotation( OriginalRot );
        return false;
	}
    
    ToAdd.Src.Move( DestSite );
    return true;
}

DefaultProperties
{
}
