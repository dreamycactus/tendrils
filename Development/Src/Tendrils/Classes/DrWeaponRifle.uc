class DrWeaponRifle extends DrWeapon
    placeable;

simulated event SetInitialState()
{
    GotoState( 'Inactive' );
}

simulated function bool ShouldRefire()
{
	if ( CurrentFireMode == 0 ) {
        EndFire( CurrentFireMode );
        return false;
    }
}

DefaultProperties
{
    GameName="Rifle"
	SpeedPenalty=100

    ShotCost(0)=0 // keep these for testing purpose!
	ShotCost(1)=0
	MaxAmmoCount=1
	EquipTime=0.1
        
        /* WEAPON FIRING MODES! */
	FiringStatesArray(0)=WeaponFiring
	FiringStatesArray(1)=WeaponFiring
	WeaponFireTypes(0)=EWFT_Projectile // First fire mode is a projectile
	WeaponFireTypes(1)=EWFT_InstantHit // second is a instanthit!


	WeaponProjectiles(0)=class'UTProj_LinkPlasma' // The projectile you want the gun to fire!
	FireInterval(0)=+0.3 // Fire speed!
	Spread(0)=0.5 // the spread of the bullets!
	
	// Weapon SkeletalMesh
	Begin Object class=AnimNodeSequence Name=MeshSequenceA
	End Object
    AttachmentClass=class'UTGameContent.UTAttachment_LinkGun'

	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'WP_ShockRifle.Mesh.SK_WP_ShockRifle_3P' // either keep this or change to your 3rd person mesh.
	End Object

	FireOffset=(X=17,Y=0)
	PlayerViewOffset=(X=14,Y=0,Z=-10.0) // Correction for Shockrifle
}
