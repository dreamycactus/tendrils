// This is just a proxy class used in the editor to
// Indicate a position and orientation an enemy should be
// spawned

class DrEnemyProxy extends Actor
    placeable;

var string EnemyName;

DefaultProperties
{
    EnemyName="Bob"
    bCollideActors=false

    Begin Object Class=SpriteComponent Name=Sprite
        Sprite=Texture2D'EditorResources.Ambientcreatures'
        HiddenGame=True
		Scale=1.0
    End Object
    Components.Add(Sprite)

}
