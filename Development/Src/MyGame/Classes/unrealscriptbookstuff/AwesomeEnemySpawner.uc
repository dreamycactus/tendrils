class AwesomeEnemySpawner extends AwesomeActor
	placeable;

var TestEnemy MySpawnedEnemy;

function SpawnEnemy()
{
	MySpawnedEnemy = spawn( class'TestEnemy', self,, Location );
	`log( "Spawned" );
}

function FreezeEnemy()
{
	if ( MySpawnedEnemy != none ) {
		MySpawnedEnemy.Freeze();
	}
}
function EnemyDied()
{
	SpawnEnemy();
}

DefaultProperties
{
	Begin Object Class=SpriteComponent Name=Sprite
		Sprite=Texture2D'EditorResources.S_NavP'
		HiddenGame=True
	End Object
	Components.Add(Sprite)
}
