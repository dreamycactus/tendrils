class DrAttachFlashlight extends UTAttachment_ShockRifle;

var SpotLightComponent SpotLight;

simulated event PostBeginPlay()
{
	Mesh.AttachComponentToSocket( SpotLight, 'MuzzleFlashSocket' );
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
	SpotLight=MyLightComponent
	//Components.Add(MyLightComponent)
}
