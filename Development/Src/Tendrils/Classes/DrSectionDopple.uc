class DrSectionDopple extends Actor
	placeable;

var DrGraphStrategy GraphStrat;

simulated event PostBeginPlay()
{
}

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
    //`log( "Touch event" @ Other @ ", " @ self );
    if ( class'DrUtils'.static.GetRoomBase( Other ) != self.Base ) {
        /* Don't collide against links */
        if ( DrSectionLink ( Other ) == none && Pawn( Other ) == none ) {
            `log( "Room Collision " @ self @ ", " @ Other );
            GraphStrat.bRoomCollisionFlag = true;
        }
    }
}

event Bump( Actor Other, PrimitiveComponent OtherComp, Vector HitNormal )
{
    `log( "Bump event" @ Other @ ", " @ self );
    if ( class'DrUtils'.static.GetRoomBase( Other ) != self.Base ) {
        /* Don't collide against links */
        if ( DrSectionLink ( Other ) == none && Pawn( Other ) == none ) {
            `log( "Room Collision " @ self @ ", " @ Other );
            GraphStrat.bRoomCollisionFlag = true;
        }
    }
}

DefaultProperties
{
	bCollideActors=true
    bCollideWorld=true
    bBlockActors=false
    BlockRigidBody=false
	CollisionType=COLLIDE_TouchAll

}
