class DrSectionVolume extends Actor
    placeable
    ClassGroup(Tendrils);

var(Tendrils) array<InterpActor> Bases;

DefaultProperties
{
    Begin Object Class=SpriteComponent Name=Sprite
        Sprite=Texture2D'UI_HUD.Materials.MapRing_Mat_Flattened'
        HiddenGame=True
		Scale=1.0
    End Object
    Components.Add(Sprite)
}
