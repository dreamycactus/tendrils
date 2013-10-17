class DrWeaponFlashlight extends DrWeapon;

simulated event PostBeginPlay()
{
	`log( "HELLO WEAPON" );
	
}

DefaultProperties
{
	Begin Object class=AnimNodeSequence Name=MeshSequenceA
	End Object
    AttachmentClass=class'UTAttachment_ShockRifle'
	//Components.Add(MeshSequenceA)

	// Weapon SkeletalMesh
	Begin Object Name=FirstPersonMesh
		SkeletalMesh=SkeletalMesh'WP_ShockRifle.Mesh.SK_WP_ShockRifle_1P'
		AnimSets(0)=AnimSet'WP_ShockRifle.Anim.K_WP_ShockRifle_1P_Base'
		Animations=MeshSequenceA
		Rotation=(Yaw=-16384)
		FOV=60.0
	End Object
	//Components.Add(ThirdPersonMesh)

	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'WP_ShockRifle.Mesh.SK_WP_ShockRifle_3P' // either keep this or change to your 3rd person mesh.
	End Object
}
