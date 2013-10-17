class DrWeaponFlashlight extends DrWeapon;

simulated event PostBeginPlay()
{
	`log( "HELLO WEAPON" );
}

DefaultProperties
{
	Begin Object class=SpotLightComponent Name=MyLightComponent
		InnerConeAngle=10
		OuterConeAngle=26.2
		Radius=92000
		Brightness=2.00000
		LightShaftConeAngle=89
		//bRenderLightShafts=true
		LightColor=(R=141,G=247,B=155)
		CastShadows=true
		CastStaticShadows=False
		CastDynamicShadows=True
		bCastCompositeShadow=False
		bAffectCompositeShadowDirection=False
	End Object
	Components.Add(MyLightComponent)

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
}
