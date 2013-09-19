class MovingPlatform extends Actor 
	placeable;

var() const editconst DynamicLightEnvironmentComponent LightEnvironment;

var() float MovementSpeed;
 
event Tick(float DeltaTime)
{
    local float delta_distance;
    local vector d;
 
    delta_distance = DeltaTime * MovementSpeed;
    d = vect(0,0,0);
    d.Z = delta_distance;
    Move(d);
}

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation,
	vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo,
	optional Actor DamageCauser)
{
    GotoState('Moving');
}

auto state Idle
{
	ignores Tick;
Begin:
	WorldInfo.Game.Broadcast(self, "Idle" );
}

state Moving
{
	ignores TakeDamage;
Begin:
	WorldInfo.Game.Broadcast(self, "Moving" );
	Sleep( 5.0 );
	GotoState( 'Idle' );
}

DefaultProperties
{
    Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
        bEnabled=TRUE
    End Object
 
    LightEnvironment=MyLightEnvironment
    Components.Add(MyLightEnvironment)
 
    Begin Object Class=StaticMeshComponent Name=BaseMesh
        StaticMesh=StaticMesh'HU_Trim2.SM.Mesh.S_HU_Trim_SM_LowProfileE_long'
        LightEnvironment=MyLightEnvironment
    End Object
    Components.Add(BaseMesh)

	CollisionComponent=BaseMesh
	bCollideActors=true
    bBlockActors=true
 
    MovementSpeed=16
}
