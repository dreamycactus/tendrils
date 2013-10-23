class DrTouchTrigger extends DynamicTriggerVolume
	placeable;

delegate onTouch( Actor Other, PrimitiveComponent OtherComp, Vector HitLoc, Vector HitNorm );

event Touch( Actor Other, PrimitiveComponent OtherComp, Vector HitLoc, Vector HitNorm )
{
	`log( "HI" );
	onTouch( Other, OtherComp, HitLoc, HitNorm );
}

DefaultProperties
{
	bStatic=false
	bNoDelete=false
	bCollideActors=true
    bCollideWorld=true
    bBlockActors=false
    bNoEncroachCheck=false
	CollisionType=COLLIDE_TouchAll

	Begin Object Class=StaticMeshComponent Name=TouchProxy
        StaticMesh=StaticMesh'UN_SimpleMeshes.TexPropCube_Dup'
		CollideActors=true
		BlockZeroExtent=true
		BlockNonZeroExtent=true
		HiddenGame=false
		Translation=(X=0.0,Y=0.0,Z=0.0)		
        //Scale3D=(X=0.3,Y=0.02,Z=0.4)
    End Object
	CollisionComponent=TouchProxy
    Components.Add(TouchProxy)
}