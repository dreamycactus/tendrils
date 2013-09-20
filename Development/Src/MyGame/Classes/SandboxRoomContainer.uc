class SandboxRoomContainer extends Actor
	placeable;

var() array<Object> objs;

DefaultProperties
{
	Begin Object Class=SpriteComponent Name=Sprite
		Sprite=Texture2D'EditorResources.S_NavP'
		HiddenGame=True
	End Object
	Components.Add(Sprite)
}
