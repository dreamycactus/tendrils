class SandboxExplodingCylinder extends Actor placeable;
 
var float Health;
var float MaxHealth;
 
var StaticMeshComponent ColorMesh;
 
var MaterialInstanceConstant mat;
 
simulated function PostBeginPlay()
{
    mat = ColorMesh.CreateAndSetMaterialInstanceConstant(0);
}
 
event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    super.TakeDamage(DamageAmount,EventInstigator, HitLocation,Momentum,DamageType,HitInfo,DamageCauser);
    Health = FMax(Health-DamageAmount,0);
    WorldInfo.Game.Broadcast(self,Name$": Health:"@Health);
 
    mat.SetScalarParameterValue('Damage',(MaxHealth - Health)/100);
 
    if (Health == 0)
    {
        HurtRadius ( 75, 128, DamageType, 0, Location, None, EventInstigator, false );
        GotoState('Dead');
    }
}
 
auto state Alive
{
}
 
state Dead
{
    ignores TakeDamage,TakeRadiusDamage;
 
begin:
    ColorMesh.SetHidden(true); //Note that it's only hidden, it's still there and colliding.
}
 
DefaultProperties
{
    Begin Object class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
        bEnabled=TRUE
    End Object
 
    LightEnvironment=MyLightEnvironment
    Components.Add(MyLightEnvironment)
 
    begin object class=StaticMeshComponent Name=BaseMesh
        StaticMesh=StaticMesh'UN_SimpleMeshes.TexPropCube_Dup'
        LightEnvironment=MyLightEnvironment
    end object
 
    ColorMesh=BaseMesh
    Components.Add(BaseMesh)
    CollisionComponent=BaseMesh
 
    bCanBeDamaged=true
    bCollideActors=true
    bBlockActors=true
    Health=100
    MaxHealth=100
}