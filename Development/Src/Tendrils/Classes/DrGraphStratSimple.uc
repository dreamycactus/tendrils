class DrGraphStratSimple extends DrGraphStrategy;

function DrLevel GenLevelGraph( array<DrSection> Sections )
{
    local int i, j;
    local DrGraphCmp CurGraph;
    local DrSection PrevSec;
    local DrLevel Level;

    if ( Sections.Length == 0 ) { return none; }

    PrevSec = Sections[0];
    for ( i = 1; i < Sections.Length; ++i ) {
        `log( "Looking at " @ Sections[i] );
        CurGraph = Sections[i].Graph;
        for ( j = 0; j < PrevSec.Graph.LinkNodes.Length; ++j ) {
            if ( PrevSec.Graph.LinkNodes[j].Dest == none
                && class'DrGraphCmp'.static.AddToSections( CurGraph.LinkNodes[0], PrevSec.Graph.LinkNodes[j] ) ) {

                PrevSec = Sections[i];
                `log( "Placed" @ Sections[i] @ "with" @ PrevSec.Graph.LinkNodes[j].Dest );
                break;
            }
        }
    }

    Level = new class'DrLevel';
    Level.Head = Sections[0];
    Level.AllSections = Sections;

    return Level;
}

DefaultProperties
{
}
