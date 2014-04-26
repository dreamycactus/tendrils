// The game starts the levelgen process on load, performing initializations of level
// node values
class DrGame extends UDKGame;

var DrLevel Level;
var DrLevelGen LevelGen;
var array<DrSection> Sections;

event PostBeginPlay()
{
    //local array<DrSection> Sections;
    local DrSection Sec;
    local DrGraphStratSimple Strat;

    `log( " === Game === " );
    foreach AllActors( class'DrSection', Sec ) {
        Sec.Initialize();
        Sections.AddItem( Sec );
    }

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

function NavigationPoint FindPlayerStart( Controller Player, optional byte InTeam, optional string IncomingName )
{
	local DrPlayerStart PS;
	local NavigationPoint Start;

	Start = super.FindPlayerStart( Player, InTeam, IncomingName );

	foreach AllActors( class'DrPlayerStart', PS ) {
		return PS;
    }
    
	return Start;
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