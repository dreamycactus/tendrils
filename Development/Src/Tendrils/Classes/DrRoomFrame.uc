class DrRoomFrame extends Actor
    placeable;

var(Tendrils) bool bDisableCameraWork; // Check if don't want to rotate camera and change height in this room
var DrRoomInfoCmp RoomInfo;                         // TRICKY. Only RoomInfo.HeightHint is used

event Touch (Actor Other, PrimitiveComponent OtherComp, Object.Vector HitLocation, Object.Vector HitNormal)
{
	if ( !bDisableCameraWork && DrPawnRookie( Other ) != none ) {
		DrCamera ( DrPCRookie( DrPawnRookie( Other ).Controller ).PlayerCamera ).CurrentCamera.SetTargetYaw( Rotation.Yaw );
		if ( RoomInfo != none ) {
			DrPCRookie( DrPawnRookie( Other ).Controller ).HeightHint = RoomInfo.HeightHint;
		}
	}
}

DefaultProperties
{
	Begin Object Class=StaticMeshComponent Name=HelperMesh
		StaticMesh=StaticMesh'MyTendrils.frame'
        Materials(0)=Material'EditorMaterials.WidgetMaterial_Z'
        Scale=0.4
        CollideActors=true
        BlockActors=false
        BlockRigidBody=false
	End Object
    Components.Add(HelperMesh)

	bDisableCameraWork=false

    bCollideActors=true
    CollisionType=COLLIDE_TouchAll
}
