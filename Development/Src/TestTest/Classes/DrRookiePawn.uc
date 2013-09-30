class DrRookiePawn extends UDKPawn;

simulated function bool CalcCamera( float fDT, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
{
    return false;
}

DefaultProperties
{
    Begin Object class=SkeletalMeshComponent Name=RookiePawnSkeletalMesh
		SkeletalMesh=SkeletalMesh'CH_IronGuard_Male.Mesh.SK_CH_IronGuard_MaleA'
		AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
		AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
		HiddenGame=FALSE
		HiddenEditor=FALSE
    End Object
    Components.Add(RookiePawnSkeletalMesh)
}
