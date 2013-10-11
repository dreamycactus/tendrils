class DrWeaponShotty extends DrWeapon
    placeable
    ClassGroup(Tendrils);

var int Shells; // Amount of bullets to be shot!
var bool bIsShotgun; // Used as a detector if the weapon should fire as a shotgun or normally.

simulated function Projectile ProjectileFire() // Main function from UTWeapon
{
    local int s;

	if( bIsShotGun == true ) // Make the function check if our weapon actually is a shotgun.
	{
            for( s = 0; s < Shells; s++) // Spawn the wanted amount of projectiles.
            {
                super.ProjectileFire();
            }
        }
        else // If it isn't a shotgun then just do the normal ProjectileFire.
        {
           return super.ProjectileFire(); // Link to normal ProjectileFire().
        }
        return None;
}

DefaultProperties
{
    ShotCost(0)=0 // keep these for testing purpose!
	ShotCost(1)=0
	MaxAmmoCount=1
	
	/* CUSTOM CHECKS FOR SHOTGUN! */
	bIsShotgun=true // Tells BaseWeapon this is a shotgun!
	Shells=8 // We want 5 shells!
        
        /* WEAPON FIRING MODES! */
	FiringStatesArray(0)=WeaponFiring
	FiringStatesArray(1)=WeaponFiring
	WeaponFireTypes(0)=EWFT_Projectile // First fire mode is a projectile
	WeaponFireTypes(1)=EWFT_InstantHit // second is a instanthit!

	WeaponProjectiles(0)=class'UTProj_Rocket' // The projectile you want the gun to fire!
	FireInterval(0)=+0.3 // Fire speed!
	Spread(0)=0.22 // the spread of the bullets!

	// Weapon SkeletalMesh
	Begin Object class=AnimNodeSequence Name=MeshSequenceA
	End Object
        AttachmentClass=class'UTAttachment_ShockRifle'

	// Weapon SkeletalMesh
	Begin Object Name=FirstPersonMesh
		SkeletalMesh=SkeletalMesh'WP_ShockRifle.Mesh.SK_WP_ShockRifle_1P'
		AnimSets(0)=AnimSet'WP_ShockRifle.Anim.K_WP_ShockRifle_1P_Base'
		Animations=MeshSequenceA
		Rotation=(Yaw=-16384)
		FOV=60.0
	End Object

	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'WP_ShockRifle.Mesh.SK_WP_ShockRifle_3P' // either keep this or change to your 3rd person mesh.
	End Object

	FireOffset=(X=17,Y=0)
	PlayerViewOffset=(X=14,Y=0,Z=-10.0) // Correction for Shockrifle
}
