class DrSectionDoppler extends DrSection
	placeable;

var bool bRoomCollisionFlag;
var DrSection Section;
var DebugCon Con;
var array<DrSectionDopplite> Dopplites;

//event UnTouch( Actor Other ) {
//    local Actor OtherSec;
//	`log( "DOPPY UNTOUCH" @ self @ ", " @ Other );
//    OtherSec = class'DrUtils'.static.GetBaseSection( Other );
//    if ( DrSectionRoom( Other ) != none && OtherSec != none &&
//        OtherSec != Section ) {

//        /* Don't collide against links */
//        if ( DrSectionLink ( Other ) == none && Pawn( Other ) == none ) {
//            `log( "UNDO Room Collision " @ self @ ", " @ Other );
//            bRoomCollisionFlag = false;
//        }
//    }
    
//}

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	`log( "Overlapping section detected" @ self @ ", " @ Other );
    bRoomCollisionFlag = true;
}

function DrSectionDoppler SpawnDopple( vector Offset );
function DestroyDopple();

function DeleteAll()
{
	local int i;

	for ( i = 0; i < Attached.Length; ++i ) {
		Attached[i].Destroy();
	}
	Destroy();
}

DefaultProperties
{
    
	//bCollideActors=true
 //   bCollideWorld=true
 //   bBlockActors=false
	//bHardAttach=true

    bRoomCollisionFlag=false
	bIgnoreBaseRotation=false

	////bWorldGeometry=true
	//Physics=PHYS_None
	//bStatic=false
	//bNoDelete=false
	//bCollideWhenPlacing=true
	//bCollideAsEncroacher=true
	//bIgnoreEncroachers=false
	//bAlwaysEncroachCheck=true
	//bCollideAsEncroacher=true
	//bSkipAttachedMoves=false
    
	//CollisionType=COLLIDE_TouchAll

}