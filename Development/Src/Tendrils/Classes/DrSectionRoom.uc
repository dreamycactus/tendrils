/**
 * DrSection contains DrSectionRooms, but these chunks aren't needed for graph calc
 * They just contain extra info about cam yaw and height hints...
 */
class DrSectionRoom extends InterpActor
	placeable;

var(Tendrils) DrRoomInfoCmp RoomInfo;
var(Tendrils) StaticMeshComponent StaticMesh;
var DrSectionDopple Dopple;

var DrGraphStrategy GraphStrat;

function SpawnDopple()
{
	local StaticMeshComponent SM;

	Dopple= Spawn( class'DrSectionDopple',,, Location + vect( 0, 0, 10 ), Rotation );
	Dopple.SetBase( self );
	Dopple.CollisionComponent = StaticMesh;
	Dopple.AttachComponent( StaticMesh );
}

event PreBeginPlay()
{
	CollisionComponent = StaticMesh;
}

simulated event PostBeginPlay()
{
}


event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
    `log( "Touch event" @ Other @ ", " @ self );
    if ( class'DrUtils'.static.GetRoomBase( Other ) != self ) {
        if ( DrSectionLink ( Other ) == none ) {
            `log( "Collision " @ self @ ", " @ Other );
            GraphStrat.bRoomCollisionFlag = true;
        }
    }
}

event Bump( Actor Other, PrimitiveComponent OtherComp, Vector HitNormal )
{
     `log( "Bump event" @ Other @ ", " @ self );
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
        BlockRigidBody=false
	End Object
    Components.Add(HelperMesh)
    StaticMesh=HelperMesh
	CollisionComponent=HelperMesh

	Begin Object Class=DrRoomInfoCmp Name=RI
    End Object
    Components.Add(RI)
	RoomInfo=RI

    bCollideActors=true
	bBlockActors=true
	BlockRigidBody=true
    CollisionType=COLLIDE_BlockAll
}
