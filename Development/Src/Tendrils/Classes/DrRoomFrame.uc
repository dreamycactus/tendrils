class DrRoomFrame extends Actor
    placeable;

var(Tendrils) bool bLockCamAlign;           // Rotate camera when entering room
var(Tendrils) bool bOverrideCamAlign;
var(Tendrils) float OverrideCamYaw;    // Set only if bLockCamAlign && bOverrideCamAlign is true; forces rotation to certain degree

event Touch (Actor Other, PrimitiveComponent OtherComp, Object.Vector HitLocation, Object.Vector HitNormal)
{
    `log( "Touched RoomFrameA" @ self );
    if ( bLockCamAlign && DrRookiePawn( Other ) != none && DrRookiePawn( Other ).CurrentRoom != self.Base ) {
        `log( "Touched RoomFrameB" @ self );
		DrCamera ( DrPlayerController( DrRookiePawn( Other ).Controller ).PlayerCamera ).CurrentCamera.SetTargetYaw( Rotation.Yaw );
	}
}

event RanInto ( Actor Other )
{
    `log( "Touched RoomFrameAA" @ self );
	if ( bLockCamAlign && DrRookiePawn( Other ) != none && DrRookiePawn( Other ).CurrentRoom != self.Base ) {
        `log( "Touched RoomFrameBB" @ self );
		DrCamera ( DrPlayerController( DrRookiePawn( Other ).Controller ).PlayerCamera ).CurrentCamera.SetTargetYaw( Rotation.Yaw );
	}
}

DefaultProperties
{
	Begin Object Class=StaticMeshComponent Name=HelperMesh
		StaticMesh=StaticMesh'MyTendrils.util.SectNodeFrame'
        Materials(0)=Material'EditorMaterials.WidgetMaterial_Z'
        Scale3D=(X=0.75,Y=0.75,Z=0.75)
        CollideActors=true
        BlockActors=false
        BlockRigidBody=false
	End Object
    Components.Add(HelperMesh)

	bLockCamAlign=true
	bOverrideCamAlign=false
    bCollideActors=true

}
