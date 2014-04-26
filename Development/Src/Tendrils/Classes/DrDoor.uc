// DrDoor opens and closes automatically and uses states to keep track of "motion"
// in front of a door
class DrDoor extends Actor
	placeable;

var(tendrils) StaticMeshComponent DoorWay;
var(tendrils) StaticMeshComponent Doorframe0;
var(tendrils) StaticMeshComponent Doorframe2;
var(tendrils) StaticMeshComponent Doorframe1;

var DrDoorWay RealDoor;
var DrTouchTrigger TriggerVol;
var int RotationOffset;

simulated event PostBeginPlay()
{
    local rotator NewRot;
    NewRot.Yaw = RotationOffset;
    SetRotation( Rotation + NewRot );

	TriggerVol = Spawn( class'DrTouchTrigger', self,,Location, Rotation, none );
	TriggerVol.onTouch = self.onTouch;
    TriggerVol.onUntouch = self.onUntouch;

	RealDoor = Spawn( class'DrDoorWay', self,, Location, Rotation, none );
	RealDoor.DoorMesh.SetActorCollision( true, true );
	RealDoor.DoorMesh.SetStaticMesh( Doorway.StaticMesh );
    RealDoor.TriggerVol = TriggerVol;

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
}

function onTouch( Actor Other, PrimitiveComponent OtherComp, Vector HitLoc, Vector HitNorm )
{
	RealDoor.Touch( Other, OtherComp, HitLoc, HitNorm );
}

function onUntouch( Actor Other )
{
    RealDoor.UnTouch( Other );
}

DefaultProperties
{
	bBlockActors=true
	bCollideActors=true
	bPathColliding=false
	CollisionType=COLLIDE_BlockAll
	bBlocksNavigation=false

    RotationOffset=16384

    Begin Object class='StaticMeshComponent' name=Doorway
        StaticMesh=StaticMesh'LT_Doors.SM.Mesh.S_LT_Doors_SM_Door04'
		CollideActors=true
		BlockZeroExtent=true
		BlockNonZeroExtent=true
	End Object

	Begin Object Class=SpriteComponent Name=Sprite
        Sprite=Texture2D'EnvyEditorResources.BlueDefense'
        HiddenGame=True
		Scale=5.0
    End Object
    Components.Add(Sprite)
}
