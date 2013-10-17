class DrCamera extends Camera
    config(Camera);

var DrPlayerController PlayerOwner;
var DrCameraModule CurrentCamera;

function PostBeginPlay()
{
    Super.PostBeginPlay();

    CurrentCamera = CreateCamera();
}

function InitializeFor( PlayerController PC )
{
    Super.InitializeFor( PC );
    PlayerOwner = DrPlayerController( PC );
}

function DrCameraModule CreateCamera()
{
    local DrCameraModule NewCam;

    NewCam = new(Outer) class'DrCameraModuleTopDown';
    NewCam.SetCamera( self );
    NewCam.Initialize();

    if ( CurrentCamera != none ) {
        CurrentCamera.OnBecomeInactive( NewCam );
        NewCam.OnBecomeActive( CurrentCamera );
    } else {
        NewCam.OnBecomeActive( none );
    }

    CurrentCamera = NewCam;
    return NewCam;
}

function UpdateViewTarget( out TViewTarget OutVT, float DeltaTime )
{
   local CameraActor   CamActor;
   local TPOV OrigPOV;
   local Vector Loc, Pos, HitLocation, HitNormal;
   local Rotator Rot;
   local Actor HitActor;

   // Don't update outgoing viewtarget during an interpolation
   if( PendingViewTarget.Target != None && OutVT == ViewTarget && BlendParams.bLockOutgoing ) {
      return;
   }

   OrigPOV = OutVT.POV;

   // Default FOV on viewtarget
   OutVT.POV.FOV = DefaultFOV;

   // Viewing through a camera actor.
   CamActor = CameraActor( OutVT.Target );
   if( CamActor != None ) {
      CamActor.GetCameraView(DeltaTime, OutVT.POV);

      // Grab aspect ratio from the CameraActor.
      bConstrainAspectRatio   = bConstrainAspectRatio || CamActor.bConstrainAspectRatio;
      OutVT.AspectRatio      = CamActor.AspectRatio;

      // See if the CameraActor wants to override the PostProcess settings used.
      CamOverridePostProcessAlpha = CamActor.CamOverridePostProcessAlpha;
      CamPostProcessSettings = CamActor.CamOverridePostProcess;
   }
   else
   {
      // Give Pawn Viewtarget a chance to dictate the camera position.
      // If Pawn doesn't override the camera view, then we proceed with our own defaults
      if( Pawn(OutVT.Target) == None || true )
      {
         //Pawn didn't want control and we have a custom mode
         if( CurrentCamera != none ) {
            //allow mode to handle camera update
            CurrentCamera.UpdateCamera( Pawn( OutVT.Target ), self, DeltaTime, OutVT );
         } else {
            switch( CameraStyle ) {
               case 'Fixed'      :   // do not update, keep previous camera position by restoring
                                 // saved POV, in case CalcCamera changes it but still returns false
                                 OutVT.POV = OrigPOV;
                                 break;
   
               case 'ThirdPerson'   : // Simple third person view implementation
               case 'FreeCam'      :
               case 'FreeCam_Default':
                 Loc = OutVT.Target.Location;
                 Rot = OutVT.Target.Rotation;

                 //OutVT.Target.GetActorEyesViewPoint(Loc, Rot);
                 if( CameraStyle == 'FreeCam' || CameraStyle == 'FreeCam_Default' )
                 {
                    Rot = PCOwner.Rotation;
                 }
                 Loc += FreeCamOffset >> Rot;

                 Pos = Loc - Vector(Rot) * FreeCamDistance;
                 // @fixme, respect BlockingVolume.bBlockCamera=false
                 HitActor = Trace(HitLocation, HitNormal, Pos, Loc, FALSE, vect(12,12,12));
                 OutVT.POV.Location = (HitActor == None) ? Pos : HitLocation;
                 OutVT.POV.Rotation = Rot;
                 break;
   
               case 'FirstPerson'   : // Simple first person, view through viewtarget's 'eyes'
               default            :   OutVT.Target.GetActorEyesViewPoint(OutVT.POV.Location, OutVT.POV.Rotation);
                                 break;
            }
         }
      }
   }

   ApplyCameraModifiers( DeltaTime, OutVT.POV );

   // set camera's location and rotation, to handle cases where we are not locked to view target
   SetRotation( OutVT.POV.Rotation );
   SetLocation( OutVT.POV.Location );
}

//pass view target initialization through to camera mode
simulated function BecomeViewTarget( PlayerController PC )
{
   CurrentCamera.BecomeViewTarget( DrPlayerController( PC ) );
}

//pass zoom in through to camera mode
function Zoom( float Amount )
{
   CurrentCamera.Zoom( Amount );
}

DefaultProperties
{
    CameraStyle=Fixed
}
