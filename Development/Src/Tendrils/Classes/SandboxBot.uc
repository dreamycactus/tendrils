class SandboxBot extends UTPawn
    placeable;
 
function AddDefaultInventory()
{
    //InvManager.CreateInventory(class'MyGame.SandboxPaintballGun');
    //For those in the back who don't follow, SandboxPaintballGun is a custom weapon
    //I've made in an earlier article, don't look for it in  your UDK build.
}
 
event PostBeginPlay()
{
    super.PostBeginPlay();
    AddDefaultInventory(); //GameInfo calls it only for players, so we have to do it ourselves for AI.
}
 
DefaultProperties
{
    Begin Object Name=CollisionCylinder
        CollisionHeight=+44.000000
    End Object
 
    Begin Object Class=SkeletalMeshComponent Name=SandboxPawnSkeletalMesh
        SkeletalMesh=SkeletalMesh'CH_IronGuard_Male.Mesh.SK_CH_IronGuard_MaleA'
        AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
        AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
        HiddenGame=FALSE
        HiddenEditor=FALSE
    End Object
 
    Mesh=SandboxPawnSkeletalMesh
 
    Components.Add(SandboxPawnSkeletalMesh)
    ControllerClass=class'SandboxAIController'
    InventoryManagerClass=class'MyGame.SandboxInventoryManager'
 
    bJumpCapable=false
    bCanJump=false
 
    GroundSpeed=200.0 //Making the bot slower than the player
}