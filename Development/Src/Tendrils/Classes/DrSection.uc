/**
 * This class represents a level's room; 
 * contains info pertaining to how rooms are connected.
 */
class DrSection extends Actor
    placeable
    ClassGroup(Tendrils);

var(Tendrils) editconst DrGraphCmp Graph;
var array<DrSectionRoom> Rooms;
var DrSectionDoppler Dopple;

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

function DrSectionDoppler SpawnDopple( vector NewLoc )
{
	local InterpActor IA;
	local DrSectionLink Link;
	local DrSectionDopplite Dlite;
    local vector ItemOffset;
	local int i;

	Dopple = Spawn( class'DrSectionDoppler',,, Location + NewLoc, Rotation );
    Dopple.Section = self;

	foreach Rooms[0].BasedActors( class'InterpActor', IA ) {
		if ( IA.StaticMeshComponent.StaticMesh == none ) {
			`log( IA @ "is an empty interpactor!!" );
			continue;
		}
        ItemOffset = IA.Location - Location;
		Dlite = Spawn(  class'DrSectionDopplite', 
						Dopple,, 
						Dopple.Location + ItemOffset, 
						IA.Rotation );
		Dlite.SetBase( Dopple );
		Dlite.StaticMeshComponent.SetStaticMesh( IA.StaticMeshComponent.StaticMesh );
		Dlite.Dop = Dopple;
		Dopple.Dopplites.AddItem( Dlite );
	}

	Dopple.Graph = new class'DrGraphCmp';
	Dopple.Graph.Current = Dopple;

	for ( i = 0; i < Graph.LinkNodes.Length; ++i ) {
		ItemOffset = Graph.LinkNodes[i].Location - Location;
		Link = Spawn(	class'DrSectionLink',,,
						Dopple.Location + ItemOffset,
						Graph.LinkNodes[i].Rotation );
		Link.Src = Dopple;
		Link.SetBase( Dopple );
		Dopple.Graph.LinkNodes.AddItem( Link );
	}

    return Dopple;
    //Dopple.StaticMeshComponent.SetScale( 0.95 ); // Make doppler scale a little less than room's for robust collision
}

function DestroyDopple()
{
	local int i;
    Dopple.Destroy();
	for ( i = 0; i < Dopple.Dopplites.Length; ++i ) {
		Dopple.Dopplites[i].Destroy();
	}
	Dopple.Dopplites.Length = 0;
    Dopple = none;
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