class DrGame extends UDKGame;

var DrLevel Level;
var DrLevelGen LevelGen;
var array<DrSection> Sections;

event PostBeginPlay()
{
    //local array<DrSection> Sections;
    local DrSection Sec;
    local DrGraphStratSimple Strat;
	local InterpActor IA;

    `log( " === Game === " );
    foreach AllActors( class'DrSection', Sec ) {
        Sec.Initialize();
        Sections.AddItem( Sec );
    }

	//foreach AllActors( class'InterpActor', IA ) {
	//	IA.SetPhysics( PHYS_None );
	//}
	
    `log( Sections.Length @ " Sections detected." );

    Strat = new class'DrGraphStratSimple';
	if ( !Strat.VerifyLevel( Sections ) ) {
		`warn( "CRITICAL: Illegal level format, not generating sections" );
		return;
	}

    Level = LevelGen.GenLevelGraph( Sections, Strat );

	if ( !Strat.VerifyLevel( Sections ) ) {
		`warn( "CRITICAL: Something went wrong with level generation" );
		return;
	}
}

event Tick( float DT )
{
    local int i;

    i = 5;
		
}


DefaultProperties
{
    bDelayedStart=false //We want to jump straight into the game

    Begin Object class=DrLevelGen name=Gen
    End Object
    LevelGen=Gen

    HUDType=class'DrHUD'
    PlayerControllerClass=class'DrPCRookie'
    DefaultPawnClass=class'DrPawnRookie'
}
