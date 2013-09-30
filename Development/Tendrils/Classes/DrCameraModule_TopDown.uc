class DrCameraModule_TopDown implements DrCameraModule;

var float CamHeight;
var float CamHeightTarget;
var float MaxCamHeight;
var float MinCamHeight;
var float CamYaw;
var float CamYawTarget;

function Initialize();
function OnBecomeActive( DrCameraModule Cam );
function OnBecomeInactive( DrCameraModule Cam );
function UpdateCamera( Pawn p, DrCamera CamActor, float DT, out TViewTarget out_VT )
{
    if ( CamHeight != CamHeightTarget ) {
        CamHeight += ( CamHeightTarget - CamHeight ) * DT * 3;
    }

    out_VT.POV.Location = out_VT.Target.Location;
    out_VT.POV.Location.Z += CamHeight;

    out_VT.POV.Rotation.Pitch = -class'DrUtils'.const.MAXROT;
    out_VT.POV.Rotation.Yaw = CamYaw;
    out_VT.POV.Rotation.Roll = 0;
}

simulated function BecomeViewTarget( DrPlayerController PC )
{
    if ( LocalPlayer( PC.Player ) != none ) {
        PC.SetBehindView( true );
        DrRookiePawn( PC.Pawn ).SetMeshVisibility( PC.bBehindView );
        PC.bNoCrosshair = true;
    }
}

exec function Zoom( float Amount ) {
    CamHeightTarget += Amount;
    CamHeightTarget = FClamp( CamHeightTarget, MinCamHeight, MaxCamHeight );
}

DefaultProperties
{
    CamHeight=1024.0
    CamHeightTarget=1024.0
    MaxCamHeight=2048.0
    MinCamHeight=300.0
}
