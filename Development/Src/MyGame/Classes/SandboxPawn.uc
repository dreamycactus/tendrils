class SandboxPawn extends UDKPawn;

function AddDefaultInventory()
{
    InvManager.CreateInventory(class'MyGame.SandboxPaintballGun'); //InvManager is the pawn's InventoryManager
}

DefaultProperties
{
	Begin Object class=SkeletalMeshComponent Name=SandboxPawnSkeletalMesh
		SkeletalMesh=SkeletalMesh'CH_IronGuard_Male.Mesh.SK_CH_IronGuard_MaleA'
		AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
		AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
		HiddenGame=FALSE
		HiddenEditor=FALSE
    End Object
    Mesh=SandboxPawnSkeletalMesh
    Components.Add(SandboxPawnSkeletalMesh)

	InventoryManagerClass=class'MyGame.SandboxInventoryManager'
}
