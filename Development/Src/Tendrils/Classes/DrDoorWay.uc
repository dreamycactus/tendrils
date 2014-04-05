// Doors comprise of two parts, a door frame and a door.
// This class shares responsibility with Door to make an automatic door
class DrDoorWay extends Actor
	placeable;

var StaticMeshComponent DoorMesh;
var vector StartLocRel;
var vector EndLocRel;
var vector StartLocWorld;
var vector EndLocWorld;

var DrTouchTrigger TriggerVol;

var float TransitionTime;
var float OpenTimer;
var float PercentDone;

var array<Actor> TouchingActors;

state SOpen
{
    event Tick( float DT ) {
        OpenTimer -= DT;
        if ( TouchingActors.Length <= 0 && OpenTimer <= 0.0 ) {
            GotoState( 'SClosing' );
        }
        if ( OpenTimer <= -20.0 ) {
            TouchingActors.Length = 0;
        }
    }

	event Touch( Actor Other, PrimitiveComponent OtherComp, Vector HitLoc, Vector HitNorm )
	{
        TouchingActors.AddItem( Other );
        OpenTimer = 2.0;
	}
    event UnTouch( Actor Other )
    {
        TouchingActors.RemoveItem( Other );        
    }
}

state SOpening extends SOpen
{
	event Tick( float DT )
	{
        super.Tick( DT );

		PercentDone += DT / TransitionTime;
		SetLocation( VLerp( StartLocWorld, EndLocWorld, PercentDone ) );
        if ( PercentDone >= 1.0 ) {
            GotoState( 'SOpen' );
        }
	}
}

auto state SClose
{
	event Touch( Actor Other, PrimitiveComponent OtherComp, Vector HitLoc, Vector HitNorm )
	{
        TouchingActors.AddItem( Other );
        OpenTimer = 2.0;
		GotoState( 'SOpening',, true );
	}
}

state SClosing extends SClose
{
    event Tick( float DT )
	{
		PercentDone -= DT / TransitionTime;
		SetLocation( VLerp( StartLocWorld, EndLocWorld, PercentDone ) );
        if ( PercentDone <= 0.0 ) {
            GotoState( 'SClose' );
        }
	}
}

simulated event PostBeginPlay()
{
    local vector oX, oY, oZ;
	StartLocWorld = Location;
    GetAxes( Rotation, oX, oY, oZ );
	EndLocWorld = Location + EndLocRel.X * oX + EndLocRel.Y * oY + EndLocRel.Z * oZ;
}


DefaultProperties
{
	TransitionTime=1.0
	EndLocRel=(X=200.0,Y=0.0,Z=0.0)

	bBlockActors=true
	bCollideActors=true
	bPathColliding=false
	bBlocksNavigation=false
	CollisionType=COLLIDE_BlockAll
	Begin Object class='StaticMeshComponent' name=Doorway
		CollideActors=true
		BlockZeroExtent=true
		BlockNonZeroExtent=true
	End Object
	Components.Add(Doorway)
	DoorMesh=Doorway
}
