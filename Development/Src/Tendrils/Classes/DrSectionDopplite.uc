class DrSectionDopplite extends InterpActor;

var DrSectionDoppler Dop;
var StaticMeshComponent StaticMeshComponent;

//exec function MoveDown( float Z )
//{
//	local vector Off;
//	Off.Z =- Z;
//	SetLocation( Off );
//}

function SetDoppler( DrSectionDoppler Doppler )
{
	Dop = Doppler;
	SetBase( Doppler );
}

event Attach( Actor Other )
{
	super.Attach( Other );
}

event UnTouch( Actor Other ) 
{
	Dop.UnTouch( Other );    
}

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	Dop.Touch( Other, OtherComp, HitLocation, HitNormal );
}

event Bump( Actor Other, PrimitiveComponent OtherComp, vector HitNormal )
{
	Dop.Bump( Other, OtherComp, HitNormal );
}

event HitWall(Vector HitNormal, Actor Wall, PrimitiveComponent WallComp)
{
	SetLocation( Location );
}

DefaultProperties
{
    Begin Object class='StaticMeshComponent' Name=Mesha
        BlockNonZeroExtent=true
        BlockZeroExtent=true
        CollideActors=true
		BlockActors=false
    End Object
    Components.Add(Mesha)
    StaticMeshComponent=Mesha
    CollisionComponent=Mesha

	bCollideActors=true
    bCollideWorld=true
    bBlockActors=false

    bRoomCollisionFlag=false
	bWorldGeometry=true
	Physics=PHYS_None
	bStatic=false
	bNoDelete=false
	bCollideWhenPlacing=true
	bCollideAsEncroacher=true
	bIgnoreEncroachers=false
	bAlwaysEncroachCheck=true
	bCollideAsEncroacher=true
    
	CollisionType=COLLIDE_TouchAll

}

