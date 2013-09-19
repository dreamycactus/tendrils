class TestEnemy extends AwesomeActor;

var Pawn Enemy;
var float FollowDistance;
var float BumpDamage;
var bool bFreeze;

auto state Seeking
{
	function Tick( float DeltaTime )
	{
		local AwesomePlayerController PC;

		if ( Enemy == none ) {
			foreach LocalPlayerControllers( class'AwesomePlayerController', PC ) {
				if ( PC.Pawn != none ) {
					Enemy = PC.Pawn;
					`log( "enemy is " @ Enemy );
				}
			}
		} else if ( VSize( Location - Enemy.Location ) < FollowDistance ) {
			GoToState( 'Attacking' );
		}
	}
}

state Attacking
{
	function Tick( float DeltaTime )
	{
		local vector NewLocation;

		if ( Enemy == none ) {
			GetEnemy();
		}

		if ( Enemy != none ) {
			NewLocation = Location + ( Enemy.Location - Location ) * DeltaTime;
			SetLocation( NewLocation );

			Enemy.Bump( self, CollisionComponent, vect( 0, 0, 0 ) );

			if ( VSize( Location - Enemy.Location ) > FollowDistance ) {
				GoToState( 'Seeking' );
			}
		}
	}
}

state Frozen
{
	function Tick( float DeltaTime )
	{
	}
}

function GetEnemy()
{
	local AwesomePlayerController PC;

	foreach LocalPlayerControllers( class'AwesomePlayerController', PC ) {
		if ( PC.Pawn != none ) {
			Enemy = PC.Pawn;
		}
	}
}

function Freeze()
{
	GoToState( 'Frozen' );
}

event TakeDamage( int DamageAmount, Controller EventInstigator,
	vector HitLocation, vector Momentum, class<DamageType> DamageType,
	optional TraceHitInfo HitInfo, optional Actor DamageCauser )
{
	if( EventInstigator != none && EventInstigator.PlayerReplicationInfo != none ) {
		WorldInfo.Game.ScoreObjective( EventInstigator.PlayerReplicationInfo, 1 );
	}
	if ( AwesomeEnemySpawner( Owner ) != none ) {
		AwesomeEnemySpawner( Owner ).EnemyDied();
	}
	Destroy();

}


defaultproperties
{
	bBlockActors=true
	BumpDamage=5.0
	bCollideActors=true
	FollowDistance=512.0
	Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
		bEnabled=true
	End Object
	Components.Add(MyLightEnvironment)

	Begin Object Class=StaticMeshComponent Name=PickupMesh
		StaticMesh=StaticMesh'UN_SimpleMeshes.TexPropCube_Dup'
		Materials(0)=Material'EditorMaterials.WidgetMaterial_X'
		LightEnvironment=MyLightEnvironment
		Scale3D=(X=0.25,Y=0.25,Z=0.25)
	End Object
	Components.Add(PickupMesh)

	Begin Object Class=CylinderComponent Name=CollisionCylinder
		CollisionRadius=32.0
		CollisionHeight=64.0
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
	End Object
	CollisionComponent=CollisionCylinder
	Components.Add(CollisionCylinder)
}
