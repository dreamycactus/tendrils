/**
 * DrSection contains DrSectionRooms, but these chunks aren't needed for graph calc
 * They just contain extra info about cam yaw and height hints...
 */
class DrSectionRoom extends Actor
	placeable
	ClassGroup(Tendrils);

var(Tendrils) DrRoomInfoCmp RoomInfo;
var DrSectionDoppler Dopple;
var StaticMeshComponent StaticMeshComponent;

function SpawnDopple( DrSection Sec )
{
	Dopple = Spawn( class'DrSectionDoppler', none,, Location, Rotation );
    Dopple.Section = Sec;
    Dopple.StaticMeshComponent.SetStaticMesh( self.StaticMeshComponent.StaticMesh );
    //Dopple.StaticMeshComponent.SetScale( 0.95 ); // Make doppler scale a little less than room's for robust collision
}

function DestroyDopple()
{
    Dopple.Destroy();
    Dopple = none;
}

simulated event PostBeginPlay()
{
}

DefaultProperties
{
	Begin Object Class=SpriteComponent Name=Sprite
        Sprite=Texture2D'EnvyEditorResources.BlueDefense'
        HiddenGame=True
		Scale=5.0
    End Object
    Components.Add(Sprite)

    Begin Object Class=StaticMeshComponent Name=HelperMesh
        CollideActors=true
        BlockRigidBody=true
	End Object
    Components.Add(HelperMesh)
    StaticMeshComponent=HelperMesh
    CollisionComponent=HelperMesh

	Begin Object Class=DrRoomInfoCmp Name=RI
    End Object
    Components.Add(RI)
	RoomInfo=RI

    bCollideComplex=true
    bCollideActors=true
	bBlockActors=true
	BlockRigidBody=true
    CollisionType=COLLIDE_BlockAll
}
