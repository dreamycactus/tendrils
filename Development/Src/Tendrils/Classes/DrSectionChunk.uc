/**
 * DrSection contains DrSectionChunks, but these chunks aren't needed for graph calc
 * They just contain extra info about cam yaw and height hints...
 */
class DrSectionChunk extends Actor
	placeable;

var(Tendrils) DrRoomInfoCmp RoomInfo;
var(Tendrils) Actor BaseRef;
var DrSection Section;

simulated function PostBeginPlay()
{
	local int i;

	//for ( i = 0; i < BaseRef.Attached.Length; ++i ) {
	//	if ( DrSectionLink( self.BaseRef.Attached[i] ) != none ) {
	//		Links.AddItem( DrSectionLink( self.BaseRef.Attached[i] ) );
	//	}
	//}
}

DefaultProperties
{
	Begin Object Class=SpriteComponent Name=Sprite
        Sprite=Texture2D'EnvyEditorResources.BlueDefense'
        HiddenGame=True
		Scale=5.0
    End Object
    Components.Add(Sprite)

	Begin Object Class=DrRoomInfoCmp Name=RI
    End Object
    Components.Add(RI)
	RoomInfo=RI
}
