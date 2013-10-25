class DrPCRookie extends DrPlayerController;

var vector MouseWorldOrg;
var vector MousePosWorldDir;
var vector MouseHitPos;

var float HeightHint;

var vector CamPos;
var int RotationOffset;

var DrSectionDoppler Dop;

exec function MoveUp( float Z )
{
	local vector Off;
	Off.Z = Z;
	Dop.Move( Off );
}

exec function MoveRight( float Z )
{
	local vector Off;
	Off.X = Z;
	Dop.Move( Off );
}

exec function MoveForward( float Z )
{
	local vector Off;
	Off.Y = Z;
	Dop.Move( Off );
}

simulated event PostBeginPlay()
{
	foreach AllActors( class'DrSectionDoppler', Dop ) {
		break;
	}
}

exec function StartIronsight()
{
    DrPawnGunman( Pawn ).StartIronsight();
    DrHUD( myHUD ).bDrawAimline = true;
}

exec function EndIronsight()
{
    DrPawnGunman( Pawn ).EndIronsight();
	DrHUD( myHUD ).bDrawAimline = false;
}

exec function PrevItem()
{
	DrInventoryManager( Pawn.InvManager ).AdjustItem( 1 );
}

exec function NextItem()
{
	DrInventoryManager( Pawn.InvManager ).AdjustItem( -1 );
}

function AlignCameraToActor( Actor Act )
{
    DrCamera( PlayerCamera ).CurrentCamera.SetTargetYaw( Act.Rotation.Yaw );
}

exec function IncCamHeight()
{
    CamPos.Z += 500.0;
}

function Tick( float DT ) { `log( "===" @ GetStateName() ); }

function PlayerTick( float DeltaTime )
{
	super.PlayerTick( DeltaTime );
	
	if ( Pawn != none ) {
		DrCamera( PlayerCamera ).CurrentCamera.SetTargetHeight( HeightHint + Pawn.Location.Z );
	}
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

simulated event GetPlayerViewPoint( out vector out_Location, out Rotator out_Rotation )
{
	local Actor TheViewTarget;

	// sometimes the PlayerCamera can be none and we probably do not want this
	// so we will check to see if we have a CameraClass.  Having a CameraClass is
	// saying:  we want a camera so make certain one exists by spawning one
	if( PlayerCamera == None )
	{
		if( CameraClass != None )
		{
			// Associate Camera with PlayerController
			PlayerCamera = Spawn(CameraClass, Self);
			if( PlayerCamera != None )
			{
				PlayerCamera.InitializeFor( Self );
			}
			else
			{
				`log("Couldn't Spawn Camera Actor for Player!!");
			}
		}
	}

	if( PlayerCamera != None )
	{
		PlayerCamera.GetCameraViewPoint(out_Location, out_Rotation);
	}
	else
	{
		TheViewTarget = GetViewTarget();

		if( TheViewTarget != None )
		{
			out_Location = TheViewTarget.Location;
			out_Rotation = TheViewTarget.Rotation;
		}
		else
		{
			super.GetPlayerViewPoint(out_Location, out_Rotation);
		}
	}
}

event Possess(Pawn inPawn, bool bVehicleTransition)
{
	Super.Possess(inPawn, bVehicleTransition);
    DrHUD( myHUD ).InvMgr = DrInventoryManagerRookie( Pawn.InvManager );
}

function Rotator GetAdjustedAimFor( Weapon W, vector StartFireLoc ) 
{
	local Rotator rot;
	
	rot.Yaw = Pawn.Rotation.Yaw;

	return rot;
}


function UpdateRotation( float DeltaTime )
{
    local Rotator DeltaRot, NewRotation, ViewRotation;
	local Vector out_HitNorm, out_HitLoc;
    if ( Pawn == none ) {
		return;
	}
    Trace( out_HitLoc, out_HitNorm, MouseWorldOrg + MousePosWorldDir * 65536.f, MouseWorldOrg, true,,, TRACEFLAG_Bullet );

    ViewRotation = Rotator( out_HitLoc - Pawn.Location );
    ViewRotation.Yaw += RotationOffset;

	Pawn.SetDesiredRotation( ViewRotation );

    DeltaRot = rot( 0, 0, 0 );
    ProcessViewRotation( DeltaTime, ViewRotation, DeltaRot );
    SetRotation( ViewRotation );

    NewRotation = ViewRotation;
    NewRotation.Roll = Rotation.Roll;

    if ( Pawn != None )
        Pawn.FaceRotation( NewRotation, DeltaTime );

}

DefaultProperties
{
	bBehindView=true
    InputClass=class'DrMouseInput'
    RotationOffset=0
    CameraClass=class'DrCamera'
    CamPos=(X=0.0,Y=0.0,Z=1024.0)
	HeightHint=700
}
