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
