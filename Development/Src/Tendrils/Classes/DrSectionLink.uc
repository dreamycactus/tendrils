class DrSectionLink extends Actor
    placeable
    ClassGroup(Tendrils);

var DrSection Src;
var DrSection Dest;
var StaticMeshComponent StaticMeshComponent;

DefaultProperties
{
	Begin Object Class=StaticMeshComponent Name=HelperMesh
		StaticMesh=StaticMesh'MyTendrils.frame'
        Materials(0)=Material'EditorMaterials.WidgetMaterial_Y'
        Scale=0.3
        CollideActors=false
        BlockActors=false
        BlockRigidBody=false
	End Object
    Components.Add(HelperMesh)
    StaticMeshComponent=HelperMesh

	bIgnoreBaseRotation=false
}
