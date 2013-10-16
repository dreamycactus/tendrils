class DrCameraModuleTopDown extends Object implements(DrCameraModule);

const YawRotRate = 3;
const PanRate = 0.7;

var float Height;
var float HeightTarget;
var float MaxHeight;
var float MinHeight;
var float Yaw;
var float YawTarget;
var DrCamera PlayerCamera;
var float TotalTime;

function Initialize();
function OnBecomeActive( DrCameraModule Cam );
function OnBecomeInactive( DrCameraModule Cam );

simulated function UpdateCamera( Pawn p, DrCamera CamActor, float DT, out TViewTarget out_VT )
{
	local int DeltaRot;

    if ( Height != HeightTarget ) {
        Height += ( HeightTarget - Height ) * DT * PanRate;
    }
    
    YawTarget = YawTarget % class'DrUtils'.const.MAXROT;
   
    if ( Yaw != YawTarget ) {
		DeltaRot = ( YawTarget - Yaw );
        Yaw +=  ( Abs( DeltaRot ) > class'DrUtils'.const.MAXROT  ?  -DeltaRot : DeltaRot ) * DT * YawRotRate;
		Yaw = Yaw % ( class'DrUtils'.const.MAXROT );
    }

    out_VT.POV.Location = out_VT.Target.Location;
    out_VT.POV.Location.Z = Height;

    out_VT.POV.Rotation.Pitch = -class'DrUtils'.const.MAXROT / 2;
    out_VT.POV.Rotation.Yaw = Yaw;
    out_VT.POV.Rotation.Roll = 0;
}

function DrCamera GetCamera() { return PlayerCamera; }
function SetCamera( DrCamera C ){ PlayerCamera = c; }
function SetTargetYaw( int newYaw ) 
{
    newYaw = newYaw % (2 * class'DrUtils'.const.MAXROT);

    if ( newYaw > class'DrUtils'.const.MAXROT ) {
        newYaw -= 2 * class'DrUtils'.const.MAXROT;
    } else if ( newYaw < -class'DrUtils'.const.MAXROT ){
        newYaw += 2 * class'DrUtils'.const.MAXROT;
    }
    YawTarget = newYaw;
    `log( "Set YawTarget to " @ newYaw );
}

function SetTargetHeight( int newHeight ) { HeightTarget = newHeight; }


simulated function BecomeViewTarget( DrPlayerController PC )
{
    if ( LocalPlayer( PC.Player ) != none ) {
        //PC.SetBehindView( true );
        //DrPawnRookie( PC.Pawn ).SetHidden( PC.bBehindView );
        //PC.bNoCrosshair = true;
    }
}

exec function Zoom( float Amount ) {
    HeightTarget += Amount;
    HeightTarget = FClamp( HeightTarget, MinHeight, MaxHeight );
}

DefaultProperties
{
    Height=2024.0
    HeightTarget=2024.0
    MaxHeight=2048.0
    MinHeight=300.0
	YawTarget=12000
}
