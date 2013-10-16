class DrPlayerController extends PlayerController;

var vector MouseWorldOrg;
var vector MousePosWorldDir;
var vector MouseHitPos;

var float HeightHint;

var vector CamPos;
var int RotationOffset;

exec function StartIronsight()
{
	local DrInventoryManager IM;
	
	IM = DrInventoryManager( Pawn.InvManager );

	if ( Pawn.IsInState( 'Move' ) ) {
		Pawn.GroundSpeed = DrPawn( Pawn ).WalkSpeed;
		if ( DrWeapon( IM.SelectedItem ) != none ) {
			IM.SetCurrentWeapon( IM.SelectedItem );
		}
	}
	
}

exec function EndIronsight()
{
	Pawn.InvManager.SetCurrentWeapon( none );

	if ( Pawn.IsInState( 'Move' ) ) {
		Pawn.GroundSpeed = DrPawn( Pawn ).WalkSpeed;
	}
}

exec function StartFire( optional byte FireModeNum )
{
	if ( WorldInfo.Pauser == PlayerReplicationInfo ) {
		SetPause( false );
		return;
	}

	if ( Pawn != None && !bCinematicMode ) {
		Pawn.StartFire( FireModeNum );
	}
}


function AlignCameraToActor( Actor Act )
{
    DrCamera( PlayerCamera ).CurrentCamera.SetTargetYaw( Act.Rotation.Yaw );
}

state PlayerWalking
{
	function ProcessMove( float DeltaTime, vector newAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot )
	{
		local vector X, Y, Z, AltAccel;

		GetAxes( PlayerCamera.Rotation , X, Y, Z );
		AltAccel = PlayerInput.aForward * Z + PlayerInput.aStrafe * Y;
		//AltAccel.Z = 0;
		AltAccel = Pawn.AccelRate * Normal( AltAccel );
		super.ProcessMove( DeltaTime, AltAccel, DoubleClickMove, DeltaRot );
	}
}

exec function IncCamHeight()
{
    CamPos.Z += 500.0;
}

function PlayerTick( float DeltaTime )
{
	super.PlayerTick( DeltaTime );
	
	if ( Pawn != none ) {
		DrCamera( PlayerCamera ).CurrentCamera.SetTargetHeight( HeightHint + Pawn.Location.Z );
	}
}

function Rotator GetAdjustedAimFor( Weapon W, vector StartFireLoc ) 
{
	local Rotator rot;
	
	rot.Yaw = Pawn.Rotation.Yaw;

	return rot;
}

function NotifyChangedWeapon( Weapon PrevW, Weapon NewW ) 
{
	super.NotifyChangedWeapon( PrevW, NewW );
	
	NewW.SetHidden( true );
	PrevW.SetHidden( true );

	if ( Pawn == none ) {
		return;
	}
}

function UpdateRotation( float DeltaTime )
{
    local Rotator DeltaRot, NewRotation, ViewRotation;
	local Vector out_HitNorm, out_HitLoc;

    Trace( out_HitLoc, out_HitNorm, MouseWorldOrg + MousePosWorldDir * 65536.f, MouseWorldOrg, true,,, TRACEFLAG_Bullet );

    ViewRotation = Rotator( out_HitLoc - Pawn.Location );
    ViewRotation.Yaw += RotationOffset;

    if ( Pawn != none ) {
        Pawn.SetDesiredRotation( ViewRotation );
    }

    DeltaRot = rot( 0, 0, 0 );
    ProcessViewRotation( DeltaTime, ViewRotation, DeltaRot );
    SetRotation( ViewRotation );

    NewRotation = ViewRotation;
    NewRotation.Roll = Rotation.Roll;

    if ( Pawn != None )
        Pawn.FaceRotation( NewRotation, DeltaTime );
}

//simulated event PostBeginPlay()
//{
//    Super.PostBeginPlay();
//    PlayerCamera.SetFOV( 30.0 );
//    Pawn.CalcCamera( 
//}

simulated event GetPlayerViewPoint( out vector out_Loc, out Rotator out_Rot )
{
	super.GetPlayerViewPoint( out_Loc, out_Rot );
	
	if ( Pawn != none ) {
		//out_Loc = CurrentCameraLocation;
        /* TODO Align rotation to room */
	    //out_Rot = 
	}
}


defaultproperties
{
    InputClass=class'DrMouseInput'
    RotationOffset=0
    CameraClass=class'DrCamera'
    CamPos=(X=0.0,Y=0.0,Z=1024.0)
	HeightHint=700
}