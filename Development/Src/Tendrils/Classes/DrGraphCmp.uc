class DrGraphCmp extends ActorComponent
    hidecategories(Object);

var DrSection Current;
var array<DrSection> AdjSections;     // Adj nodes
var() array<DrSectionLink> LinkNodes;    // Edges


static function bool AddToSections( DrSectionLink ToAdd, DrSectionLink FromLink )
{
    local int DeltaRot;
    
    DeltaRot = ToAdd.Src.BaseRef.Rotation.Yaw + 
        FromLink.Rotation.Yaw - 180 * DegToUnrRot - ToAdd.Rotation.Yaw ;
    
    ToAdd.Src.BaseRef.SetRotation( MakeRotator( 0, DeltaRot, 0 ) ); 
    ToAdd.Src.BaseRef.Move( FromLink.Location - ToAdd.Location );

    `log( "Rotated Section " @ UnrRotToDeg * DeltaRot );
    `log( "Moved Section by" @ ( FromLink.Location - ToAdd.Location ) );

    FromLink.Dest = ToAdd.Src;
    ToAdd.Dest = FromLink.Src;

    return true;
}

DefaultProperties
{
}
