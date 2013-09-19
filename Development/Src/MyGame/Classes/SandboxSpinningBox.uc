class SandboxSpinningBox extends Actor 
	placeable;

var float RotatingSpeed;
var float MaxSpeed;
var float SpeedFade;
var() const editconst DynamicLightEnvironmentComponent LightEnvironment;
 
auto state Spinning
{
    event TakeDamage(int DamageAmount, Controller EventInstigator,
    	vector HitLocation, vector Momentum, class<DamageType> DamageType,
    	optional TraceHitInfo HitInfo, optional Actor DamageCauser)

    {
        super.TakeDamage(DamageAmount,EventInstigator, HitLocation,Momentum,DamageType,HitInfo,DamageCauser);
 
        WorldInfo.Game.Broadcast(self,"Damage Taken:"@DamageAmount); RotatingSpeed += DamageAmount*100;
    }
 
    event Tick(float DeltaTime)
    {
        local Rotator final_rot;
        final_rot = Rotation;
 
        RotatingSpeed = FMax(RotatingSpeed - SpeedFade* DeltaTime,0);
        final_rot.Yaw = final_rot.Yaw + RotatingSpeed*DeltaTime;
        SetRotation(final_rot);
    }
}
 
DefaultProperties
{
    Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
        bEnabled=TRUE
    End Object
 
    LightEnvironment=MyLightEnvironment
 
    Components.Add(MyLightEnvironment)
 
    begin object Class=StaticMeshComponent Name=BaseMesh
        StaticMesh=StaticMesh'EngineMeshes.Cube'
        LightEnvironment=MyLightEnvironment
    end object
    Components.Add(BaseMesh)
    CollisionComponent=BaseMesh
 
    bCollideActors=true
    bBlockActors=true
 
    RotatingSpeed=0.0
    SpeedFade=5000.0
    MaxSpeed= 10000
}