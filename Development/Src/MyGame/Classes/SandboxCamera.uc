class SandboxCamera extends GamePlayerCamera;

protected function GameCameraBase FindBestCameraType(Actor CameraTarget)
{
    //Add here the code that will figure out which cam to use.
    return ThirdPersonCam; // We only have this camera
}

DefaultProperties
{
	ThirdPersonCameraClass=class'MyGame.SandboxThirdPersonCamera'
}
