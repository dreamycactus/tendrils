class DrSectionDopplite extends Actor;

var DrSectionDoppler Dop;
var StaticMeshComponent StaticMeshComponent;

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

event BaseChange()
{
    `log( "BASE CHANGE" );
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
    bBlockActors=false
    bMovable=true
    bHardAttach=true
    bStatic=false
    bNoDelete=false

    bRoomCollisionFlag=false
	Physics=PHYS_Interpolating
	bCollideWhenPlacing=true
	bCollideAsEncroacher=true
	bIgnoreEncroachers=false
	bAlwaysEncroachCheck=true
	bCollideAsEncroacher=true
    
	CollisionType=COLLIDE_TouchAll

}

