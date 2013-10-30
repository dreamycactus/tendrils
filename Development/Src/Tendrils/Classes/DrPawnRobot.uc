class DrPawnRobot extends DrPawnGunman
    placeable;

DefaultProperties
{
    Begin Object class=SkeletalMeshComponent Name=RookiePawnSkeletalMesh
		SkeletalMesh=SkeletalMesh'CH_LIAM_Cathode.Mesh.SK_CH_LIAM_Cathode'
		AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
		AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
        CollideActors=true
        bOverrideAttachmentOwnerVisibility=true
    End Object
    Components.Add(RookiePawnSkeletalMesh)
    Mesh=RookiePawnSkeletalMesh
}
