class SandboxProjectile extends UDKProjectile;
 
simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
    if ( Other != Instigator )
    {
        WorldInfo.MyDecalManager.SpawnDecal ( DecalMaterial'SandboxContent.Materials.DM_Paintball_Splash', HitLocation, rotator(-HitNormal), 128, 128, 256, false, FRand() * 360, none );
        Other.TakeDamage( Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
        Destroy();
    }
}
 
simulated event HitWall(vector HitNormal, actor Wall, PrimitiveComponent WallComp)
{
    Velocity = MirrorVectorByNormal(Velocity,HitNormal); //That's the bounce
    SetRotation(Rotator(Velocity));
    TriggerEventClass(class'SeqEvent_HitWall', Wall);
}
 
DefaultProperties
{
    Begin Object Name=CollisionCylinder
        CollisionRadius=8
        CollisionHeight=16
    End Object
 
    Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
        bEnabled=TRUE
    End Object
 
    Components.Add(MyLightEnvironment)
 
    begin object class=StaticMeshComponent Name=BaseMesh
        StaticMesh=StaticMesh'WP_BioRifle.Mesh.S_Bio_Blob_01'
        LightEnvironment=MyLightEnvironment
    end object
 
    Components.Add(BaseMesh)
 
    Damage=25
    MomentumTransfer=10
}