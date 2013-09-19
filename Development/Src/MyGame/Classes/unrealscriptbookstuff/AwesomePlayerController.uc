class AwesomePlayerController extends UTPlayerController;

var vector PlayerViewOffset;
var AwesomeActor MyAwesomeActor;
var vector CurrentCameraLocation, DesiredCameraLocation;
var rotator CurrentCameraRotation;

exec function Upgrade()
{
	if(Pawn != none && AwesomeWeapon(Pawn.Weapon) != none)
		AwesomeWeapon(Pawn.Weapon).UpgradeWeapon();
}

exec function StartFire( optional byte FireModeNum )
{
	super.StartFire( FireModeNum );
}
simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	bNoCrosshair = true;
}

simulated event GetPlayerViewPoint( out vector oLocation, out Rotator oRotation )
{
	super.GetPlayerViewPoint( oLocation, oRotation );
	
	if ( Pawn != none ) {
		oLocation = CurrentCameraLocation;
		oRotation = rotator( (oLocation * vect( 1, 1, 0 )) - oLocation );
	}

	CurrentCameraRotation = oRotation;
}

reliable client function ClientSetHUD( class<HUD> newHUDType )
{
	if ( myHUD != none ) {
		myHUD.Destroy();
	}
	myHUD = spawn( class'AwesomeHud', self );
}

state PlayerWalking
{
	function ProcessMove( float DeltaTime, vector newAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot )
	{
		local vector X, Y, Z, AltAccel;

		GetAxes( CurrentCameraRotation, X, Y, Z );
		AltAccel = PlayerInput.aForward * Z + PlayerInput.aStrafe * Y;
		AltAccel.Z = 0;
		AltAccel = Pawn.AccelRate * Normal( AltAccel );

		super.ProcessMove( DeltaTime, AltAccel, DoubleClickMove, DeltaRot );
	}
}

function PlayerTick( float DeltaTime )
{
	super.PlayerTick( DeltaTime );
	
	if ( Pawn != none ) {
		DesiredCameraLocation = Pawn.Location + ( PlayerViewOffset >> Pawn.Rotation );
		CurrentCameraLocation += ( DesiredCameraLocation - CurrentCameraLocation ) * DeltaTime * 3;
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

//function UpdateRotation( float DeltaTime )
//{
//   local Rotator   DeltaRot, newRotation, ViewRotation;

//   ViewRotation = Rotation;
//   if (Pawn!=none)
//   {
//      Pawn.SetDesiredRotation(ViewRotation);
//   }

//   // Calculate Delta to be applied on ViewRotation
//   DeltaRot.Yaw   = PlayerInput.aTurn;
//   DeltaRot.Pitch   = 0;

//   ProcessViewRotation( DeltaTime, ViewRotation, DeltaRot );
//   SetRotation(ViewRotation);

//   NewRotation = ViewRotation;
//   NewRotation.Roll = Rotation.Roll;

//   if ( Pawn != None )
//      Pawn.FaceRotation(NewRotation, deltatime);
//}   

defaultproperties
{
	PlayerViewOffset=(X=0,Y=0,Z=1024)
}