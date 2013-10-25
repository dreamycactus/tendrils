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

function SpawnDopple( DrSection Sec, vector Offset )
{
	local InterpActor IA;
	local DrSectionDopplite Dlite;
	Dopple = Spawn( class'DrSectionDoppler', none,, Location + Offset, Rotation );
    Dopple.Section = Sec;
    Dopple.StaticMeshComponent.SetStaticMesh( self.StaticMeshComponent.StaticMesh );
	foreach BasedActors( class'InterpActor', IA ) {
		if ( IA.StaticMeshComponent.StaticMesh == none ) {
			`log( IA @ "is an empty interpactor!!" );
			continue;
		}
		Dlite = Spawn( class'DrSectionDopplite',,, IA.Location + Offset, IA.Rotation );
		Dlite.StaticMeshComponent.SetStaticMesh( IA.StaticMeshComponent.StaticMesh );
		Dlite.Dop = Dopple;
		Dlite.SetBase( Dopple,,,'Attachy' );
		Dopple.Dopplites.AddItem( Dlite );
	}
    //Dopple.StaticMeshComponent.SetScale( 0.95 ); // Make doppler scale a little less than room's for robust collision
}

function DestroyDopple()
{
	local int i;
    Dopple.Destroy();
	for ( i = 0; i < Dopple.Dopplites.Length; ++i ) {
		Dopple.Dopplites[i].Destroy();
	}
	Dopple.Dopplites.Length = 0;
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
	bHardAttach=false
    CollisionType=COLLIDE_BlockAll
}
