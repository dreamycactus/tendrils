/**
 * This class represents a level's room; 
 * contains info pertaining to how rooms are connected.
 */
class DrSection extends Actor
	placeable;

var DrGraphCmp Graph;
var(Tendrils) Actor ParentRef;    // Reference to the InterpActor which all the room actors are attached to

DefaultProperties
{
	Begin Object Class=SpriteComponent Name=Sprite
		Sprite=Texture2D'EnvyEditorResources.DefensePoint'
		HiddenGame=True
	End Object
	Components.Add(Sprite)
}