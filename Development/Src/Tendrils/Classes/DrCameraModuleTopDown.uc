class DrCameraModuleTopDown extends Object implements(DrCameraModule);

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
    TotalTime += DT;
    CamYawTarget = class'DrUtils'.const.MAXROT * Sin( TotalTime / 20.0 );
    if ( CamHeight != CamHeightTarget ) {
        CamHeight += ( CamHeightTarget - CamHeight ) * DT * 3;
    }
    
    if ( CamYaw != CamYawTarget ) {
        CamYaw += ( CamYawTarget - CamYaw ) * DT * 3;
    }

    out_VT.POV.Location = out_VT.Target.Location;
    out_VT.POV.Location.Z += CamHeight;

    out_VT.POV.Rotation.Pitch = -class'DrUtils'.const.MAXROT / 2;
    out_VT.POV.Rotation.Yaw = 0;
    out_VT.POV.Rotation.Roll = 0;
}

function SetCamera( DrCamera C )
{
	PlayerCamera = c;
}

function DrCamera GetCamera()
{
	return PlayerCamera;
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
}
