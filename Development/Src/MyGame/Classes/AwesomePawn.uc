class AwesomePawn extends UTPawn;

var float CamOffsetDistance;
var bool bFollowPlayerRotation;
var float BumpDamage;
var bool bInvunerable;
var float InvunerableTime;


event Bump( Actor Other, PrimitiveComponent OtherComp, Vector HitNormal )
{
	if ( TestEnemy( Other ) != none && !bInvunerable ) {
		bInvunerable = true;
		SetTimer( InvunerableTime, false, 'EndInvunerable' );
		TakeDamage( TestEnemy( Other ).BumpDamage, none, Location, vect( 0, 0, 0 ), class'UTDmgType_LinkPlasma');
	}
}

function EndInvunerable()
{
	bInvunerable = false;
}
//simulated event BecomeViewTarget( PlayerController PC )
//{
//	local UTPlayerController UTPC;

//	super.BecomeViewTarget( PC );

//	if ( LocalPlayer( PC.Player ) != none ) {
//		UTPC = UTPlayerController( PC );
//		if ( UTPC != none ) {
//			UTPC.SetBehindView( true );
//			SetMeshVisibility( UTPC.bBehindView );
//			UTPC.bNoCrosshair = true;
//		}
//	}
//}

//simulated function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
//{
//   out_CamLoc = Location;
//   out_CamLoc.Z += CamOffsetDistance;

//   if(!bFollowPlayerRotation)
//   {
//      out_CamRot.Pitch = -16384;
//      out_CamRot.Yaw = 0;
//      out_CamRot.Roll = 0;
//   }
//   else
//   {
//      out_CamRot.Pitch = -16384;
//      out_CamRot.Yaw = Rotation.Yaw;
//      out_CamRot.Roll = 0;
//   }

//   return true;
//}

//simulated singular event Rotator GetBaseAimRotation()
//{
//   local rotator   POVRot, tempRot;

//   tempRot = Rotation;
//   tempRot.Pitch = 0;
//   SetRotation(tempRot);
//   POVRot = Rotation;
//   POVRot.Pitch = 0; 

//   return POVRot;
//}   


simulated function PostBeginPlay()
{
	super.PostBeginPlay();

	if ( ArmsMesh[0] != none ) {
		ArmsMesh[0].SetHidden( true );
	}
	if ( ArmsMesh[1] != none ) {
		ArmsMesh[1].SetHidden( true );
	}
}

simulated function SetMeshVisibility( bool bVisible )
{
	super.SetMeshVisibility( bVisible );
	Mesh.SetOwnerNoSee( false );
}


defaultproperties
{
	bCollideActors=true
	bFollowPlayerRotation=false
	bInvunerable=true
	BumpDamage=5.0
	InvunerableTime=0.6
	CamOffsetDistance=384.0
}