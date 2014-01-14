class SandboxBot extends UTPawn
    placeable;
 
function AddDefaultInventory()
{
    InvManager.CreateInventory( class'UTWeap_LinkGun', true );
}

simulated function bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation)
{
  if (Super.Died(Killer, DamageType, HitLocation))
  {
    Mesh.MinDistFactorForKinematicUpdate = 0.f;
    Mesh.SetRBChannel(RBCC_Pawn);
    Mesh.SetRBCollidesWithChannel(RBCC_Default, true);
    Mesh.SetRBCollidesWithChannel(RBCC_Pawn, false);
    Mesh.SetRBCollidesWithChannel(RBCC_Vehicle, false);
    Mesh.SetRBCollidesWithChannel(RBCC_Untitled3, false);
    Mesh.SetRBCollidesWithChannel(RBCC_BlockingVolume, true);
    Mesh.ForceSkelUpdate();
    Mesh.SetTickGroup(TG_PostAsyncWork);
    CollisionComponent = Mesh;
    CylinderComponent.SetActorCollision(false, false);
    Mesh.SetActorCollision(true, false);
    Mesh.SetTraceBlocking(true, true);
    SetPhysics(PHYS_RigidBody);
    Mesh.PhysicsWeight = 1.0;

    if (Mesh.bNotUpdatingKinematicDueToDistance)
    {
      Mesh.UpdateRBBonesFromSpaceBases(true, true);
    }

    Mesh.PhysicsAssetInstance.SetAllBodiesFixed(false);
    Mesh.bUpdateKinematicBonesFromAnimation = false;
    Mesh.SetRBLinearVelocity(Velocity, false);
    Mesh.ScriptRigidBodyCollisionThreshold = MaxFallSpeed;
    Mesh.SetNotifyRigidBodyCollision(true);
    Mesh.WakeRigidBody();

    return true;
  }

  return false;
}
 
event PostBeginPlay()
{
    super.PostBeginPlay();
    AddDefaultInventory(); //GameInfo calls it only for players, so we have to do it ourselves for AI.
}

auto state Idle
{
	event BeginState( name PreviousStateName )
	{

	}
}
 
DefaultProperties
{
    Begin Object Name=CollisionCylinder
        CollisionHeight=+44.000000
    End Object
 
    Begin Object Class=SkeletalMeshComponent Name=SandboxPawnSkeletalMesh
        SkeletalMesh=SkeletalMesh'CH_LIAM_Cathode.Mesh.SK_CH_LIAM_Cathode'
		bHasPhysicsAssetInstance=true
		bUpdateKinematicBonesFromAnimation=true
        AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
        AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
        HiddenGame=FALSE
        HiddenEditor=FALSE
    End Object
 
    Mesh=SandboxPawnSkeletalMesh
 
    Components.Add(SandboxPawnSkeletalMesh)
    ControllerClass=class'SandboxAIController'
    InventoryManagerClass=class'UTInventoryManager'
 
    bJumpCapable=false
    bCanJump=false
 
    GroundSpeed=200.0 //Making the bot slower than the player
}