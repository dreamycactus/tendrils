class SandboxThirdPersonCamera extends GameCameraBase;

var float ThirdPersonCamOffsetX;
var float ThirdPersonCamOffsetY;
var float ThirdPersonCamOffsetZ;
var Rotator CurrentCamOrientation;
var Rotator DesiredCamOrientation;
var CameraShake shake;
function UpdateCamera(Pawn P, GamePlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    local float Radius, Height;
    local vector X,Y,Z;
 
    P.GetAxes(DesiredCamOrientation,X,Y,Z); // We will be working with coordinates in pawn space, but rotated according to the Desired Rotation.
 
    P.GetBoundingCylinder(Radius, Height); //Get the pawn's height as a base for the Z offset.
 
    OutVT.POV.Location = P.Location + ThirdPersonCamOffsetX * X + ThirdPersonCamOffsetY * Y + (Height+ThirdPersonCamOffsetZ) * Z;
 
    if (DesiredCamOrientation != CurrentCamOrientation)
    {
		CurrentCamOrientation = RInterpTo(CurrentCamOrientation,DesiredCamOrientation,DeltaTime,10);
    }
    OutVT.POV.Rotation = CurrentCamOrientation;

	CameraActor.PlayCameraShake( shake, 100.0 );
}
 
function ProcessViewRotation( float DeltaTime, Actor ViewTarget, out Rotator out_ViewRotation, out Rotator out_DeltaRot )
{
    DesiredCamOrientation = out_ViewRotation + out_DeltaRot;
}
 
DefaultProperties
{
    ThirdPersonCamOffsetX=-80.0
    ThirdPersonCamOffsetY=8.0
    ThirdPersonCamOffsetZ=-32.0
}
