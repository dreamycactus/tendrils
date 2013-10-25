class DrSectionDoppler extends InterpActor
	placeable;

var() StaticMeshComponent StaticMeshComponent;
var bool bRoomCollisionFlag;
var DrSection Section;
var DebugCon Con;
var array<DrSectionDopplite> Dopplites;

event bool EncroachingOn(Actor Other)
{
	super.EncroachingOn( Other );
}


event UnTouch( Actor Other ) {
    local Actor OtherSec;
	`log( "DOPPY UNTOUCH" @ self @ ", " @ Other );
    OtherSec = class'DrUtils'.static.GetBaseSection( Other );
    if ( DrSectionRoom( Other ) != none && OtherSec != none &&
        OtherSec != Section ) {

        /* Don't collide against links */
        if ( DrSectionLink ( Other ) == none && Pawn( Other ) == none ) {
            `log( "UNDO Room Collision " @ self @ ", " @ Other );
            bRoomCollisionFlag = false;
        }
    }
    
}

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
    local Actor OtherSec;

	`log( "DOPPY TOUCH" @ self @ ", " @ Other );
    OtherSec = class'DrUtils'.static.GetBaseSection( Other );
    if ( OtherSec != none && OtherSec != Section ) {
        /* Don't collide against links */
        if ( DrSectionLink ( Other ) == none && Pawn( Other ) == none ) {
            `log( "Room Collision " @ self @ ", " @ Other );
            bRoomCollisionFlag = true;
        }
    }
}

event Bump( Actor Other, PrimitiveComponent OtherComp, vector HitNormal )
{
	`log( "DOPPY DUMP" @ self @ ", " @ Other );
}

function AllMove( vector D )
{
	local int i;

	SetLocation( D );
	for ( i = 0; i < Dopplites.Length; ++i ) {
		Dopplites[i].Move( D );
	}
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