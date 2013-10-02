/**
 * This class represents a level's room; 
 * contains info pertaining to how rooms are connected.
 */
class DrSection extends Actor
    placeable;

var(Tendrils) editconst DrGraphCmp Graph;
var(Tendrils) Actor BaseRef;    // Reference to the InterpActor which all the room actors are attached to
var array<DrSectionChunk> SectionChunks;

var DrLevel Level;
simulated function PreBeginPlay()
{
    local int j;
	local DrSectionChunk Chunk;

	Graph.Current = self;

	foreach AllActors(class'DrSectionChunk', Chunk ) {
		if ( BaseRef.Attached.Find( Chunk.BaseRef ) != -1 ) {
			SectionChunks.AddItem( Chunk );
			Chunk.Section = self;
			for ( j = 0; j < Chunk.BaseRef.Attached.Length; ++j ) {
				if ( DrSectionLink( Chunk.BaseRef.Attached[j] ) != none ) {
					Graph.LinkNodes.AddItem( DrSectionLink( Chunk.BaseRef.Attached[j] ) );
					Graph.LinkNodes[Graph.LinkNodes.Length - 1].Src = self;
				}
			}
		}
	}
	Graph.Current = self;
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
		Scale=10.0
    End Object
    Components.Add(Sprite)
}