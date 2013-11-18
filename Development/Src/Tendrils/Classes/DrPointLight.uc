class DrPointLight extends PointLightMovable;

var float SphereRadius;
var PointLightComponent PLC;

event simulated PostBeginPlay()
{
	local StaticMeshComponent Sphere;
	foreach ComponentList( class'PointLightComponent', PLC ) {
		break;
	}
    //CollisionComponent.SetActorCollision( true, false, true );
	if ( PLC != none ) {
		Spawn( class'DrSphereLight',,, Location );
		Sphere = new class'StaticMeshComponent';
		Sphere.SetActorCollision( true, false, true );
		Sphere.SetStaticMesh( StaticMesh'EngineMeshes.Sphere' );
		Sphere.SetScale( PLC.Radius / SphereRadius );
		CollisionComponent = Sphere;
		AttachComponent( Sphere );
	}
}

event Touch( Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal )
{
	`log( "LIGHT TOUCH" @ Other );
	if( DrPawnRookie( Other ) != None ) {
		`log("touched player");
	}
}

event UnTouch(Actor Other)
{
	//local NPlayer_Pawn P;
	
	//if( isInRange(Other) )
	//	return;
	//P = NPlayer_Pawn(Other);
	//if( P != None)
	//{
	//	`log("removeing"@self);
	//	P.removePointLight(self);	
	//}
	//`log("POINTlight"@self@"just UNtouched"@Other);

}

DefaultProperties
{
	Begin Object Name=PointLightComponent0
	    LightAffectsClassification=LAC_DYNAMIC_AND_STATIC_AFFECTING
	    CastShadows=TRUE
	    CastStaticShadows=false
	    CastDynamicShadows=TRUE
	    bForceDynamicLight=true
	    UseDirectLightMap=FALSE
	    LightingChannels=(BSP=false,Static=false,Dynamic=TRUE,bInitialized=TRUE)
	End Object

	//Begin Object class='StaticMeshComponent' name=SphereCollision
	//	HiddenGame = false
	//	CollideActors=true
	//	BlockActors=false
	//	BlockZeroExtent=true
	//	BlockNonZeroExtent=true
	//	BlockRigidBody=false
	//	StaticMesh=StaticMesh'EngineMeshes.Sphere'
	//End Object
	//CollisionComponent=SphereCollision
	//Components.Add(SphereCollision)
}
