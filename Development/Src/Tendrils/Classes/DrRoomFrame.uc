class DrRoomFrame extends Actor;

var(Tendrils) bool bLockCamAlign;           // Rotate camera when entering room
var(Tendrils) bool bOverrideCamAlign;
var(Tendrils) float OverrideCamYaw;    // Set only if bLockCamAlign && bOverrideCamAlign is true; forces rotation to certain degree

event RanInto ( Actor Other )
{
	if ( bLockCamAlign && DrRookiePawn( Other ) != none && DrRookiePawn( Other ).CurrentRoom != self.Base ) {
		DrCamera ( DrPlayerController( DrRookiePawn( Other ).Controller ).PlayerCamera ).CurrentCamera.SetTargetYaw( Rotation.Yaw );
	}
}

DefaultProperties
{
	Begin Object Class=StaticMeshComponent Name=HelperMesh
		StaticMesh=StaticMesh'MyTendrils.util.SectNodeFrame'
        Materials(0)=Material'EditorMaterials.WidgetMaterial_Z'
        Scale3D=(X=0.75,Y=0.75,Z=0.75)
        CollideActors=false
        BlockActors=false
        BlockRigidBody=false
	End Object
    Components.Add(HelperMesh)

	bLockCamAlign=true
	bOverrideCamAlign=false
}
