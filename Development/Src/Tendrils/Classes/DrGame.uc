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
        Sec.Initialize();
        Sections.AddItem( Sec );
    }

    `log( Sections.Length @ " Sections detected." );

    if ( !VerifyLevel( Sections ) ) {
        `log( "Level errors. Aborting level generation..." );
    }

    Strat = new class'DrGraphStratSimple';
    Level = LevelGen.GenLevelGraph( Sections, Strat );
}

function bool VerifyLevel( array<DrSection> Sections ) {
    local int i, j;
    local bool bGood;
    bGood = true;
    
    /* Verify each section has rooms */
    for ( i = 0; i < Sections.Length; ++i ) {
        if ( Sections[i].Attached.Length < 1 ) {
            `log( "CRITICAL: Section " @ Sections[i] @ " has no rooms!");
            bGood = false;
        }
        /* Verify each room has a base */
        for ( j = 0; j < Sections[i].Rooms.Length; ++j ) {
            if ( Sections[i].Rooms[j].Attached.Length < 1 ) {
                `log( "Critical: Room " @ Sections[i].Rooms[j] @ " has no base!" );
                bGood = false;
            }
        }
    }

    return bGood;
}


event Tick( float DT )
{
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
