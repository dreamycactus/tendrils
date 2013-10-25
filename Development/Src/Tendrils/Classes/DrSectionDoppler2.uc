class DrSectionDoppler2 extends Actor
	placeable;

event UnTouch( Actor Other ) {
    local Actor OtherSec;
	`log( "DOPPY2 UNTOUCH" @ self @ ", " @ Other );
    
}

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
    local Actor OtherSec;

	`log( "DOPPY2 TOUCH" @ self @ ", " @ Other );
}

event Bump( Actor Other, PrimitiveComponent OtherComp, vector HitNormal )
{
	`log( "DOPPY2 DUMP" @ self @ ", " @ Other );
}

DefaultProperties
{
    Begin Object class='StaticMeshComponent' Name=Mesha
        BlockNonZeroExtent=true
        BlockZeroExtent=true
        CollideActors=true
    End Object
    Components.Add(Mesha)
    StaticMeshComponent=Mesha
    CollisionComponent=Mesha
    
    bCollideComplex=true
    bCollideActors=true
	bBlockActors=true
	BlockRigidBody=true
    CollisionType=COLLIDE_BlockAll
	bMovable=true

}

