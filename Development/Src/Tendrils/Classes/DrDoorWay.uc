class DrDoorWay extends Actor
	placeable;

var StaticMeshComponent DoorMesh;
var vector StartLocRel;
var vector EndLocRel;
var vector StartLocWorld;
var vector EndLocWorld;

var float OpenTime;
var float PercentDone;

state SOpen
{
	event Tick( float DT )
	{
		PercentDone += DT / OpenTime;
		SetLocation( VLerp( StartLocWorld, EndLocWorld, PercentDone ) );
	}
	event BeginState( name PrevName )
	{
		PercentDone = 0.0;
	}
}

auto state SIdle
{
	ignores Tick;
}

simulated event PostBeginPlay()
{
	StartLocWorld = Location + StartLocRel;
	EndLocWorld = Location + EndLocRel;
}


DefaultProperties
{
	OpenTime=2.0
	EndLocRel=(X=0.0,Y=0.0,Z=10.0)

	bBlockActors=true
	bCollideActors=true
	CollisionType=COLLIDE_BlockAll
	Begin Object class='StaticMeshComponent' name=Doorway
		CollideActors=true
		BlockZeroExtent=true
		BlockNonZeroExtent=true
	End Object
	Components.Add(Doorway)
	DoorMesh=Doorway
}
