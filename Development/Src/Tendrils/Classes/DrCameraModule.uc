interface DrCameraModule;

function DrCamera GetCamera();
function SetCamera( DrCamera C );

function Initialize();
function OnBecomeActive( DrCameraModule Cam );
function OnBecomeInactive( DrCameraModule Cam );
function UpdateCamera( Pawn P, DrCamera Cam, float DT, out TViewTarget out_VT );
function BecomeViewTarget( DrPlayerController PC );
function Zoom( float Something );