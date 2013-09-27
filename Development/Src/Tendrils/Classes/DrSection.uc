/**
 * This class represents a level's room; 
 * contains info pertaining to how rooms are connected.
 */
class DrSection extends Actor
    placeable;

var(Tendrils) editconst DrGraphCmp Graph;
var(Tendrils) Actor BaseRef;    // Reference to the InterpActor which all the room actors are attached to

simulated function PreBeginPlay()
{
    local int i;

    Graph.Current = Self;
    for ( i = 0; i < Graph.LinkNodes.Length; ++i ) {
        Graph.LinkNodes[i].Src = Self;
    }
}

DefaultProperties
{
    Begin Object Class=DrGraphCmp Name=GG
    End Object
    Components.Add(GG)
    Graph=GG

    Begin Object Class=SpriteComponent Name=Sprite
        Sprite=Texture2D'EnvyEditorResources.DefensePoint'
        HiddenGame=True
    End Object
    Components.Add(Sprite)
}