class DrSectionDoppler extends Actor
	placeable;

var StaticMeshComponent StaticMeshComponent;
var bool bRoomCollisionFlag;
var DrSection Section;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
}

event UnTouch( Actor Other ) {
    local Actor OtherSec;

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

    OtherSec = class'DrUtils'.static.GetBaseSection( Other );
    if (  DrSectionRoom( Other ) != none && OtherSec != none && 
        OtherSec != Section ) {

        /* Don't collide against links */
        if ( DrSectionLink ( Other ) == none && Pawn( Other ) == none ) {
            `log( "Room Collision " @ self @ ", " @ Other );
            bRoomCollisionFlag = true;
        }
    }
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
    bCollideWorld=true
    bBlockActors=false

    bRoomCollisionFlag=false
    
	CollisionType=COLLIDE_TouchAll

}
