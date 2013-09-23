class DrGame extends UDKGame;

var DrLevel Level;
var DrLevelGen LevelGen;

event PostBeginPlay()
{
	local array<DrSection> Sections;
	local DrSection Sec;

	`log( " === Game === " );
	foreach AllActors( class'DrSection', Sec ) {
		Sections.AddItem( Sec );
	}
	`log( Sections.Length @ " Levels detected." );

	Level = LevelGen.GenLevelGraph( Sections );
	LevelGen.ArrangeLevel( Level );
}

DefaultProperties
{
	Begin Object class=DrLevelGen name=Gen
	End Object
	LevelGen=Gen

	bDelayedStart=false //We want to jump straight into the game

}
