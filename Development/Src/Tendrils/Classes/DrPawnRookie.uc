class DrPawnRookie extends DrPawnGunman;

var Actor CurrentRoom;

//simulated function bool CalcCamera( float fDT, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
//{
//    super.CalcCamera( fDT, out_CamLoc, out_CamRot, out_FOV );
//    //return false;
//}

function AddDefaultInventory()
{
    local Inventory Inv;
    Inv = InvManager.CreateInventory( class'DrWeaponShotty', true );
    Inv = InvManager.CreateInventory( class'DrWeaponKnife', true );
    DrInventoryManager( InvManager ).SelectedIndex = 0;
}

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
}

simulated event BecomeViewTarget( PlayerController PC )
{
    local DrPlayerController DPC;

    DPC = DrPlayerController( PC );

	//super.BecomeViewTarget( PC ;)

    if ( DPC != none && DrCamera( DPC.PlayerCamera ) != none ) {
        DrCamera( DPC.PlayerCamera ).BecomeViewTarget( DPC );
        DPC.SetBehindView(false);
        SetMeshVisibility(true); 
        DPC.bNoCrosshair = true;
    } else {
        
    }
}

simulated singular function Rotator GetBaseAimRotation()
{
    local rotator POVRot;

    POVRot = Rotation;
    POVRot.Pitch = 0;
    return POVRot;
}

event Tick( float DT )
{
    //`log( Location );
}
DefaultProperties
{
    Begin Object class=SkeletalMeshComponent Name=RookiePawnSkeletalMesh
		SkeletalMesh=SkeletalMesh'CH_IronGuard_Male.Mesh.SK_CH_IronGuard_MaleA'
		AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
		AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
        CollideActors=true
        //bOverrideAttachmentOwnerVisibility=true
    End Object
    Components.Add(RookiePawnSkeletalMesh)
    Mesh=RookiePawnSkeletalMesh

    InventoryManagerClass=class'Tendrils.DrInventoryManagerRookie'
}
