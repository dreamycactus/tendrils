class AwesomeUpgrade extends AwesomeActor
	placeable;

var StaticMeshComponent MyMesh;
var Material BigMaterial;

event Touch( Actor Other, PrimitiveComponent OtherCmp, vector HitLoc,
	vector HitNorm )
{
	local Pawn cother;
	`log( "Touching" );
	
	cother= Pawn( Other );
	if ( cother == none )
		`log( "hello foo" );

	if ( cother != none && AwesomeWeapon( cother.Weapon ) != none ) {
		`log( "Destroy" );
		AwesomeWeapon( cother.Weapon ).UpgradeWeapon();
		Destroy();
	}

}

function OnToggle(SeqAct_Toggle Action)
{
	if( Action.InputLinks[0].bHasImpulse )
	{
		MyMesh.SetScale(2.0);
		MyMesh.SetMaterial(0, BigMaterial);
	}
	else if(Action.InputLinks[1].bHasImpulse)
	{
		MyMesh.SetScale(MyMesh.default.Scale);
		MyMesh.SetMaterial(0, MyMesh.default.Materials[0]);
	}
}

defaultproperties
{
	bCollideActors=true
	Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
		bEnabled=true
	End Object
	Components.Add(MyLightEnvironment)

	Begin Object Class=CylinderComponent Name=CollisionCylinder
		CollisionRadius=16.0
		CollisionHeight=16.0
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		CollideActors=true
	End Object
	CollisionComponent=CollisionCylinder
	Components.Add(CollisionCylinder)

	Begin Object Class=StaticMeshComponent Name=PickupMesh
		StaticMesh=StaticMesh'UN_SimpleMeshes.TexPropCube_Dup'
		Materials(0)=Material'EditorMaterials.WidgetMaterial_Y'
		LightEnvironment=MyLightEnvironment
		Scale3D=(X=0.125,Y=0.125,Z=0.125)
	End Object
	Components.Add(PickupMesh)
	MyMesh=PickupMesh

	BigMaterial=Material'EditorMaterials.WidgetMaterial_Z'

}
