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
	AboveSite= LevelLink.Location - ToAdd.Location;
	AboveSite.Z = 30000;
	ToAdd.Src.SetLocation( AboveSite );
	ToAdd.Src.SetRotation( MakeRotator( 0, DeltaRot, 0 ) );

	/* Lower section down into place, if a collision happens during this, Strat.bRoomCollisionFlag
	 * will be set by DrRoom...
	 */
	DestSite = AboveSite;
	DestSite.Z = LevelLink.Location.Z - ToAdd.Location.Z;
	ToAdd.Src.Move( DestSite );
    
	`log( "Trying to place section\nRotating section by " @ UnrRotToDeg * DeltaRot );
	`log( "From" @ LevelLink.Location @ " to " @ ToAdd.Location );
    `log( "Moved Section by" @ ( LevelLink.Location - ToAdd.Location ) );

	if ( Strat.bRoomCollisionFlag ) {
		ToAdd.Src.SetLocation( OriginalLoc );
		ToAdd.Src.SetRotation( OriginalRot );
	}

    return true;
}

DefaultProperties
{
}
