class DrPawnZombie extends UTPawn
    placeable;
 
var AnimNodePlayCustomAnim SwingAnim;

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
	super.PostInitAnimTree(SkelComp);

	//SwingAnim = AnimNodePlayCustomAnim(SkelComp.FindAnimNode('claw_animation'));
    SwingAnim = AnimNodePlayCustomAnim(SkelComp.FindAnimNode('Fwalk_swing'));
}

function AddDefaultInventory()
{
    InvManager.CreateInventory( class'DrZombieClaw', true );
}

function SetDyingPhysics()
{
    Mesh.MinDistFactorForKinematicUpdate = 0.f;
    Mesh.SetRBChannel(RBCC_Pawn);
    Mesh.SetRBCollidesWithChannel(RBCC_Default, true);
    Mesh.SetRBCollidesWithChannel(RBCC_Pawn, false);
    Mesh.SetRBCollidesWithChannel(RBCC_Vehicle, false);
    Mesh.SetRBCollidesWithChannel(RBCC_Untitled3, true);
    Mesh.SetRBCollidesWithChannel(RBCC_BlockingVolume, true);
    Mesh.ForceSkelUpdate();
    Mesh.SetTickGroup(TG_PostAsyncWork);
    CollisionComponent = Mesh;
    CylinderComponent.SetActorCollision(true, true);
    Mesh.SetActorCollision(true, false);
    Mesh.SetTraceBlocking(true, true);
    Mesh.SetActorCollision(true, true, true);

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
		//ForceRagdoll();
        //SetPawnRBChannels(true);
	//}
}

simulated function SetPawnRBChannels(bool bRagdollMode)
{
	if(bRagdollMode)
	{
		Mesh.SetRBChannel(RBCC_Pawn);
		Mesh.SetRBCollidesWithChannel(RBCC_Default,TRUE);
		Mesh.SetRBCollidesWithChannel(RBCC_Pawn,TRUE);
		Mesh.SetRBCollidesWithChannel(RBCC_Vehicle,TRUE);
		Mesh.SetRBCollidesWithChannel(RBCC_Untitled3,FALSE);
		Mesh.SetRBCollidesWithChannel(RBCC_BlockingVolume,TRUE);
	}
	else
	{
		Mesh.SetRBChannel(RBCC_Untitled3);
		Mesh.SetRBCollidesWithChannel(RBCC_Default,FALSE);
		Mesh.SetRBCollidesWithChannel(RBCC_Pawn,FALSE);
		Mesh.SetRBCollidesWithChannel(RBCC_Vehicle,FALSE);
		Mesh.SetRBCollidesWithChannel(RBCC_Untitled3,TRUE);
		Mesh.SetRBCollidesWithChannel(RBCC_BlockingVolume,FALSE);
	}
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
        SkeletalMesh=SkeletalMesh'Bryan.zombie'
		bHasPhysicsAssetInstance=true
		bUpdateKinematicBonesFromAnimation=true
        AnimSets(0)=AnimSet'Bryan.Test_1_Anims'
        AnimTreeTemplate=AnimTree'Bryan.Test'
        PhysicsAsset=PhysicsAsset'Bryan.Test_1_Physics'
	End Object
 
    Mesh=SandboxPawnSkeletalMesh
 
    Components.Add(SandboxPawnSkeletalMesh)
    ControllerClass=class'SandboxAIController'
    InventoryManagerClass=class'UTInventoryManager'
 
    bJumpCapable=false
    bCanJump=false
 
    GroundSpeed=200.0 //Making the bot slower than the player
}
