class DrRookiePawn extends UDKPawn;

var Actor CurrentRoom;

//simulated function bool CalcCamera( float fDT, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
//{
//    super.CalcCamera( fDT, out_CamLoc, out_CamRot, out_FOV );
//    //return false;
//}

simulated event BecomeViewTarget( PlayerController PC )
{
    local DrPlayerController DPC;

    DPC = DrPlayerController( PC );

    if ( DPC != none && DrCamera( DPC.PlayerCamera ) != none ) {
        DrCamera( DPC.PlayerCamera ).BecomeViewTarget( DPC );
    } else {
        super.BecomeViewTarget( PC );
    }
}

simulated singular function Rotator GetBaseAimRotation()
{
    local rotator POVRot;

    POVRot = Rotation;
    POVRot.Pitch = 0;

    return POVRot;
}

DefaultProperties
{
    Begin Object class=SkeletalMeshComponent Name=RookiePawnSkeletalMesh
		SkeletalMesh=SkeletalMesh'CH_IronGuard_Male.Mesh.SK_CH_IronGuard_MaleA'
		AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
		AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
		HiddenGame=FALSE
		HiddenEditor=FALSE
        CollideActors=true
    End Object
    Components.Add(RookiePawnSkeletalMesh)
}
