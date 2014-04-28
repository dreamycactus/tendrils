class DrFinish extends Actor
        placeable;

event Touch (Actor Other, PrimitiveComponent OtherComp, Object.Vector HitLocation, Object.Vector HitNormal)
{

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

    bCollideActors=true
    CollisionType=COLLIDE_TouchAll
}
