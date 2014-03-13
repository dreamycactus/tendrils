class DrGraphCmp extends ActorComponent
    hidecategories(Object);

var DrSection Current;
var array<DrSection> AdjSections;     // Adj nodes
var array<DrSectionLink> LinkNodes;    // Edges

static function bool TryConnectSection( DrSectionLink ToAdd, DrSectionLink LevelLink )
{
    local int DeltaRot;
	local vector DestLoc, OriginalLoc;
    local Rotator OriginalRot;
    local DrSectionDoppler SrcDoppler;

	SrcDoppler = DrSectionDoppler( ToAdd.Src );
	SrcDoppler.bRoomCollisionFlag = false;

	OriginalRot = SrcDoppler.Rotation;
    OriginalLoc = SrcDoppler.Location;

	/* Base Yaw + Dest Link Yaw - ( 180 + Src Link Yaw ) */
    DeltaRot = SrcDoppler.Rotation.Yaw + 
        LevelLink.Rotation.Yaw - class'DrUtils'.const.MAXROT - ToAdd.Rotation.Yaw;
    ToAdd.Src.SetRotation( MakeRotator( 0, DeltaRot, 0 ) );

	DestLoc = LevelLink.Location + SrcDoppler.Location - ToAdd.Location;
    SrcDoppler.SetLocation( DestLoc );

    if ( SrcDoppler.bRoomCollisionFlag ) {
	    `log( "Overlapping section detected " @ DrSectionDoppler( LevelLink.Src ).Section @ ", and " @ SrcDoppler.Section );
        SrcDoppler.SetLocation( OriginalLoc );
        SrcDoppler.SetRotation( OriginalRot );
        return false;
    }

    return true;
}

DefaultProperties
{
}
