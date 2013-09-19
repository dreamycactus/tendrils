class SandboxPaintBallGun extends UDKWeapon;

simulated function ProcessInstantHit(byte FiringMode, ImpactInfo Impact, optional int NumHits)
{
	//`log( CollidingActors( class'StaticMes
    WorldInfo.MyDecalManager.SpawnDecal (   DecalMaterial'HU_Deck.Decals.M_Decal_GooLeak', // UMaterialInstance used for this decal.
                        Impact.HitLocation, // Decal spawned at the hit location.
                        rotator(-Impact.HitNormal), // Orient decal into the surface.
                        128, 128, // Decal size in tangent/binormal directions.
                        256, // Decal size in normal direction.
                        false, // If TRUE, use "NoClip" codepath.
                        FRand() * 360, // random rotation
                        Impact.HitInfo.HitComponent // If non-NULL, consider this component only.
    );
}

simulated function TimeWeaponEquipping()
{
    AttachWeaponTo( Instigator.Mesh,'WeaponPoint' );
    super.TimeWeaponEquipping();
}
 
simulated function AttachWeaponTo( SkeletalMeshComponent MeshCpnt, optional Name SocketName )
{
    MeshCpnt.AttachComponentToSocket(Mesh,SocketName);
}

simulated event SetPosition(UDKPawn Holder)
{
    local vector FinalLocation;
    local vector X,Y,Z;
 
    Holder.GetAxes(Holder.Controller.Rotation,X,Y,Z);
 
    FinalLocation= Holder.GetPawnViewLocation(); //this is in world space.
    FinalLocation= FinalLocation- Y * 12 - Z * 32; // Rough position adjustment
    SetHidden(False);
    SetLocation(FinalLocation);
    SetBase(Holder);
    SetRotation(Holder.Controller.Rotation);
}

DefaultProperties
{
	FiringStatesArray(1)=WeaponFiring
    WeaponFireTypes(1)=EWFT_Projectile
    WeaponProjectiles(1)=class'MyGame.SandboxProjectile'
    FireInterval(1)=0.01
    Spread(1) = 0

	Begin Object Class=SkeletalMeshComponent Name=GunMesh
        SkeletalMesh=SkeletalMesh'WP_LinkGun.Mesh.SK_WP_Linkgun_3P'
        HiddenGame=FALSE
        HiddenEditor=FALSE
    end object
    Mesh=GunMesh
    Components.Add(GunMesh)
}
