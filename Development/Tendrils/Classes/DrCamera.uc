class DrCamera extends Camera
    config(Camera);

var DrPlayerController PlayerOwner;
var DrCameraModule CurrentCamera;
var config string DefaultCameraClass;

function PostBeginPlay()
{
    local class<DrCameraModule> NewClass;

    Super.PostBeginPlay();

    if ( CurrentCamera == none && DefaultCameraClass != "" ) {
        NewClass = class<DrCameraModule>( DynamicLoadObject( DefaultCameraClass, class'Class' ) );
        CurrentCamera = CreateCamera( NewClass );
    }
}

function InitializeFor( PlayerController PC )
{
    Super.InitializeFor( PC );
    PlayerOwner = DrPlayerController( PC );
}

function DrCameraModule CreateCamera( class<DrCameraModule> CameraClass )
{
    local DrCameraModule NewCam;

    NewCam = new(Outer) CameraClass;
    NewCam.SetPlayerCamera( self );
    NewCam.Init();

    if ( CurrentCamera != none ) {
        CurrentCamera.OnBecomeInactive( NewCam );
        NewCam.OnBecomeActive( CurrentCamera );
    } else {
        NewCam.OnBecomeActive( none );
    }

    CurrentCamera = NewCam;
    return NewCam;
}

DefaultProperties
{
}
