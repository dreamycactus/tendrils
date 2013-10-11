/**
 * This class represents a level's room; 
 * contains info pertaining to how rooms are connected.
 */
class DrSection extends Actor
    placeable
    ClassGroup(Tendrils);

var(Tendrils) editconst DrGraphCmp Graph;
var array<DrSectionRoom> Rooms;

var DrLevel Level;
simulated function Initialize()
{
	local DrSectionRoom Ro;
    local DrSectionLink Link;

    if ( Attached.Length == 0 ) { `log( "No attachment to section " @ self,,'CRITICAL' ); return; }

	Graph.Current = self;

	foreach BasedActors( class'DrSectionRoom', Ro ) {
        Rooms.AddItem( Ro );
        foreach Ro.BasedActors( class'DrSectionLink', Link ) {
		    Link.Src = self;
            Graph.LinkNodes.AddItem( Link );
        }
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
		Scale=10.0
    End Object
    Components.Add(Sprite)
}