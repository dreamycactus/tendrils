/**
 * DrSection contains DrSectionRooms, but these chunks aren't needed for graph calc
 * They just contain extra info about cam yaw and height hints...
 */
class DrSectionRoom extends InterpActor
	placeable;

var(Tendrils) DrRoomInfoCmp RoomInfo;
var DrSectionDopple Dopple;

function SpawnDopple( DrGraphStrategy GraphStrat )
{
    local StaticMeshComponent SM;
    
	Dopple = Spawn( class'DrSectionDopple',,, Location, Rotation );
    Dopple.SetBase( self );
    Dopple.GraphStrat = GraphStrat;
    SM = new class'StaticMeshComponent' ( self.StaticMeshComponent );
	Dopple.AttachComponent( SM );
    Dopple.CollisionComponent = SM;
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
        Materials(0)=Material'EditorMaterials.WidgetMaterial_Z'
        Scale3D=(X=0.75,Y=0.75,Z=0.75)
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

    bCollideActors=true
	bBlockActors=false
	BlockRigidBody=true

    CollisionType=COLLIDE_BlockAll
}
