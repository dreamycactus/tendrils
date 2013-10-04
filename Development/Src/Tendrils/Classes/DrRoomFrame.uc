class DrRoomFrame extends Actor
    placeable;

var(Tendrils) bool bDisableCameraWork; // Check if don't want to rotate camera and change height in this room
var DrRoomInfoCmp RoomInfo;                         // TRICKY. Only RoomInfo.HeightHint is used

event Touch (Actor Other, PrimitiveComponent OtherComp, Object.Vector HitLocation, Object.Vector HitNormal)
{
	if ( !bDisableCameraWork ) {
		DrCamera ( DrPlayerController( DrRookiePawn( Other ).Controller ).PlayerCamera ).CurrentCamera.SetTargetYaw( Rotation.Yaw );
		if ( RoomInfo != none ) {
			DrPlayerController( DrRookiePawn( Other ).Controller ).HeightHint = RoomInfo.HeightHint;
		}
	}
}

DefaultProperties
{
	Begin Object Class=StaticMeshComponent Name=HelperMesh
		StaticMesh=StaticMesh'MyTendrils.frame'
        Materials(0)=Material'EditorMaterials.WidgetMaterial_Z'
        Scale3D=(X=0.75,Y=0.75,Z=0.75)
        CollideActors=true
        BlockActors=false
        BlockRigidBody=false
	End Object
    Components.Add(HelperMesh)

	bDisableCameraWork=false

    bCollideActors=true
    CollisionType=COLLIDE_TouchAll
}
