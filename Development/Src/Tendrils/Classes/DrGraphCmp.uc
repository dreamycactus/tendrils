class DrGraphCmp extends ActorComponent
    hidecategories(Object);

var DrSection Current;
var array<DrSection> AdjSections;     // Adj nodes
var array<DrSectionLink> LinkNodes;    // Edges


static function bool AddToSections( DrSectionLink ToAdd, DrSectionLink FromLink )
{
    local int DeltaRot;
    
    DeltaRot = ToAdd.Src.Attached[0].Rotation.Yaw + 
        FromLink.Rotation.Yaw - class'DrUtils'.const.MAXROT - ToAdd.Rotation.Yaw ;
    
	`log( "Rotated Section " @ UnrRotToDeg * DeltaRot );
	`log( "From" @ FromLink.Location @ " to " @ ToAdd.Location );
    `log( "Moved Section by" @ ( FromLink.Location - ToAdd.Location ) );

    ToAdd.Src.Attached[0].SetRotation( MakeRotator( 0, DeltaRot, 0 ) ); 
    ToAdd.Src.Attached[0].Move( FromLink.Location - ToAdd.Location );

    FromLink.Dest = ToAdd.Src;
    ToAdd.Dest = FromLink.Src;

    return true;
}

DefaultProperties
{
}
