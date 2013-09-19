class CustomCoverMesh extends Actor placeable;

var() const editconst DynamicLightEnvironmentComponent LightEnvironment;

DefaultProperties
{

    Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
        bEnabled=TRUE
    End Object
 
    LightEnvironment=MyLightEnvironment
    Components.Add(MyLightEnvironment)

Begin object class=StaticMeshComponent Name=CoverStatComp
	StaticMesh=StaticMesh'HU_Trim2.SM.Mesh.S_HU_Trim_SM_LowProfileE_long'
    LightEnvironment=MyLightEnvironment
End Object

CollisionComponent=CoverStatComp
Components.Add(CoverStatComp)

}