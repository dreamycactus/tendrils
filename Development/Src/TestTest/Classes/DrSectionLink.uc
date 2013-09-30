class DrSectionLink extends Actor
    placeable;

//var DrDoor DoorRef;
var DrSection Src;
var DrSection Dest;

DefaultProperties
{
	Begin Object Class=StaticMeshComponent Name=HelperMesh
		StaticMesh=StaticMesh'MyTendrils.util.SectNodeFrame'
        Materials(0)=Material'EditorMaterials.WidgetMaterial_Y'
        Scale3D=(X=0.75,Y=0.75,Z=0.75)
        CollideActors=false
        BlockActors=false
        BlockRigidBody=false
	End Object
    Components.Add(HelperMesh)
}
