/**
 * DrSection contains DrSectionRooms, but these chunks aren't needed for graph calc
 * They just contain extra info about cam yaw and height hints...
 */
class DrSectionRoom extends Actor
	placeable;

var(Tendrils) DrRoomInfoCmp RoomInfo;
var(Tendrils) StaticMeshComponent StaticMesh;

var DrGraphStrategy GraphStrat;

simulated function PostBeginPlay()
{
	CollisionComponent = StaticMesh;
	//for ( i = 0; i < BaseRef.Attached.Length; ++i ) {
	//	if ( DrSectionLink( self.BaseRef.Attached[i] ) != none ) {
	//		Links.AddItem( DrSectionLink( self.BaseRef.Attached[i] ) );
	//	}
	//}
}

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
    if ( class'DrUtils'.static.GetRoomBase( Other ) != self ) {
        `log( "Collision " @ self @ ", " @ Other );
        GraphStrat.bRoomCollisionFlag = true;
    }
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
        BlockActors=true
        BlockRigidBody=true
	End Object
    Components.Add(HelperMesh)
    StaticMesh=HelperMesh

	Begin Object Class=DrRoomInfoCmp Name=RI
    End Object
    Components.Add(RI)
	RoomInfo=RI

    bCollideActors=true
	bBlockActors=true
	BlockRigidBody=true
    CollisionType=ECollisionType.COLLIDE_BlockAll
}
