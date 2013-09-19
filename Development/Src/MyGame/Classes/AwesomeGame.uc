class AwesomeGame extends UTDeathMatch;

var array<AwesomeEnemySpawner> EnemySpawners;
var Int EnemiesLeft;

simulated function PostBeginPlay()
{
	local AwesomeEnemySpawner ES;

	super.PostBeginPlay();

	GoalScore = 10;

	foreach DynamicActors( class'AwesomeEnemySpawner', ES ){
		EnemySpawners[EnemySpawners.Length] = ES;
	}
}

function ScoreObjective( PlayerReplicationInfo Scorer, Int Score )
{
	local int i;

	EnemiesLeft--;
	super.ScoreObjective( Scorer, Score );

	if ( EnemiesLeft == 0 ) {
		for ( i=0; i<EnemySpawners.Length; ++i ) {
			EnemySpawners[i].FreezeEnemy();
		}
	}
}

function ActivateSpawners()
{
	local int i;

	for ( i=0; i<EnemySpawners.Length; ++i ) {
		EnemySpawners[i].SpawnEnemy();
	}
}


defaultproperties
{
	bScoreDeaths=false
	PlayerControllerClass=class'MyGame.AwesomePlayerController'
	DefaultPawnClass=class'MyGame.AwesomePawn'
}