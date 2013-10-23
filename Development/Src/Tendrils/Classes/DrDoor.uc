class DrDoor extends Actor
	placeable;

var(tendrils) StaticMeshComponent DoorWay;
var(tendrils) StaticMeshComponent Doorframe0;
var(tendrils) StaticMeshComponent Doorframe2;
var(tendrils) StaticMeshComponent Doorframe1;

var DrDoorWay RealDoor;
var DrTouchTrigger TriggerVol;

simulated event PostBeginPlay()
{
	RealDoor = Spawn( class'DrDoorWay',,, Location, Rotation, none );
	RealDoor.DoorMesh.SetActorCollision( true, true );
	RealDoor.DoorMesh.SetStaticMesh( Doorway.StaticMesh );

	if ( Doorframe0 != none ) {
		Doorframe0.SetActorCollision( true, true );
		self.AttachComponent( Doorframe0 );
	}
	if ( Doorframe1 != none ) {
		Doorframe1.SetActorCollision( true, true );
		self.AttachComponent( Doorframe1 );
	}
	if ( Doorframe2 != none ) {
		Doorframe2.SetActorCollision( true, true );
		self.AttachComponent( Doorframe2 );
	}

	TriggerVol = Spawn( class'DrTouchTrigger',,,Location, Rotation, none );
	TriggerVol.onTouch = self.onTouch;
}

function onTouch( Actor Other, PrimitiveComponent OtherComp, Vector HitLoc, Vector HitNorm )
{
	if ( !DoorWay.IsInState( 'SOpen' ) ) {
		DoorWay.GotoState( 'SOpen' );
	}
}

DefaultProperties
{
	bBlockActors=true
	bCollideActors=true
	CollisionType=COLLIDE_BlockAll

	Begin Object Class=SpriteComponent Name=Sprite
        Sprite=Texture2D'EnvyEditorResources.BlueDefense'
        HiddenGame=True
		Scale=5.0
    End Object
    Components.Add(Sprite)
}
