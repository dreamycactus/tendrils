class DrCameraModuleTopDown extends Object implements(DrCameraModule);

const YawRotRate = 3;
const PanRate = 1.0;

var float CamHeight;
var float CamHeightTarget;
var float MaxCamHeight;
var float MinCamHeight;
var float CamYaw;
var float CamYawTarget;
var DrCamera PlayerCamera;
var float TotalTime;

function Initialize();
function OnBecomeActive( DrCameraModule Cam );
function OnBecomeInactive( DrCameraModule Cam );

simulated function UpdateCamera( Pawn p, DrCamera CamActor, float DT, out TViewTarget out_VT )
{
	local int DeltaRot;

    if ( CamHeight != CamHeightTarget ) {
        CamHeight += ( CamHeightTarget - CamHeight ) * DT * PanRate;
    }
    
    CamYawTarget = CamYawTarget % class'DrUtils'.const.MAXROT;
   
    if ( CamYaw != CamYawTarget ) {
		DeltaRot = ( CamYawTarget - CamYaw );
        CamYaw +=  ( Abs( DeltaRot ) > class'DrUtils'.const.MAXROT  ?  -DeltaRot : DeltaRot ) * DT * YawRotRate;
		CamYaw = CamYaw % ( 2 * class'DrUtils'.const.MAXROT );
    }

    out_VT.POV.Location = out_VT.Target.Location;
    out_VT.POV.Location.Z += CamHeight;

    out_VT.POV.Rotation.Pitch = -class'DrUtils'.const.MAXROT / 2;
    out_VT.POV.Rotation.Yaw = CamYaw;
    out_VT.POV.Rotation.Roll = 0;
}

function DrCamera GetCamera() { return PlayerCamera; }
function SetCamera( DrCamera C ){ PlayerCamera = c; }
function SetTargetYaw( int Yaw ) 
{
    Yaw = Yaw % (2 * class'DrUtils'.const.MAXROT);

    if ( Yaw > class'DrUtils'.const.MAXROT ) {
        Yaw -= 2 * class'DrUtils'.const.MAXROT;
    } else if ( Yaw < -class'DrUtils'.const.MAXROT ){
        Yaw += 2 * class'DrUtils'.const.MAXROT;
    }
    CamYawTarget = Yaw;
    `log( "Set Yaw to " @ Yaw );
}


simulated function BecomeViewTarget( DrPlayerController PC )
{
    if ( LocalPlayer( PC.Player ) != none ) {
        //PC.SetBehindView( true );
        //DrRookiePawn( PC.Pawn ).SetHidden( PC.bBehindView );
        //PC.bNoCrosshair = true;
    }
}

exec function Zoom( float Amount ) {
    CamHeightTarget += Amount;
    CamHeightTarget = FClamp( CamHeightTarget, MinCamHeight, MaxCamHeight );
}

DefaultProperties
{
    CamHeight=2024.0
    CamHeightTarget=2024.0
    MaxCamHeight=2048.0
    MinCamHeight=300.0
	CamYawTarget=12000
}
