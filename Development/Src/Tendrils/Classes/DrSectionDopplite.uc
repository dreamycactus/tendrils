class DrSectionDopplite extends KActorSpawnable;

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
	if ( DrSectionDopplite( Other ) != none && DrSectionDopplite( Other ).Dop != Dop ) {
		Dop.UnTouch( Other );    
	}
}

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	if ( DrSectionDopplite( Other ) != none && DrSectionDopplite( Other ).Dop != Dop ) {
		Dop.Touch( Other, OtherComp, HitLocation, HitNormal );
	}
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
    //bBlockActors=false
    bMovable=true
    //bHardAttach=true
    //bStatic=false
    //bNoDelete=false
	bIgnoreBaseRotation=false

	Physics=PHYS_None
	//bCollideWhenPlacing=true
	//bCollideAsEncroacher=true
	//bIgnoreEncroachers=false
	//bAlwaysEncroachCheck=true
	//bCollideAsEncroacher=true
	//bSkipAttachedMoves=false
    
	CollisionType=COLLIDE_TouchAll

}

