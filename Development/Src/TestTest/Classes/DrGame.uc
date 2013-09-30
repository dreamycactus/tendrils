class DrGame extends UDKGame;

var DrLevel Level;
var DrLevelGen LevelGen;

event PostBeginPlay()
{
    local array<DrSection> Sections;
    local DrSection Sec;
    local DrGraphStratSimple Strat;

    `log( " === Game === " );
    foreach AllActors( class'DrSection', Sec ) {
        Sections.AddItem( Sec );
    }
    `log( Sections.Length @ " Levels detected." );

    //Sections[0].Graph.PlaceSection( Sections[1].Graph.LinkNodes[0], Sections[0].Graph.LinkNodes[0] ); 
    Strat = new class'DrGraphStratSimple';
    Level = LevelGen.GenLevelGraph( Sections, Strat );
    //LevelGen.ArrangeLevel( Level );

}

DefaultProperties
{
    bDelayedStart=false //We want to jump straight into the game

    Begin Object class=DrLevelGen name=Gen
    End Object
    LevelGen=Gen

    HUDType=class'DrHUD'
    PlayerControllerClass=class'DrPlayerController'
    DefaultPawnClass=class'DrRookiePawn'
}
