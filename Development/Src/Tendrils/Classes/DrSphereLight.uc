class DrSphereLight extends Actor;

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	`log( "LIGHT" );
}

event Bump( Actor O, PrimitiveComponent OC, Vector HT )
{
	super.Bump( O, OC, HT );
	`log ( "BUM" );
}

DefaultProperties
{	
	bCollideActors=true
	bBlockActors=false
	CollisionType=COLLIDE_BlockAll

	Begin Object class='StaticMeshComponent' name=SphereCollision
		StaticMesh=StaticMesh'EngineMeshes.Sphere'
		BlockNonZeroExtent=true
        BlockZeroExtent=true
        CollideActors=true
		BlockActors=false
	End Object
	CollisionComponent=SphereCollision
	Components.Add(SphereCollision)


}
