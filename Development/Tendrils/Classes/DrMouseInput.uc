class DrMouseInput extends PlayerInput;

var protectedwrite IntPoint MousePos;

event PlayerInput( float DeltaTime )
{
    if ( myHUD != none ) {
        MousePos.X = Clamp( MousePos.X + aMouseX, 0, myHUD.SizeX );
        MousePos.Y = Clamp( MousePos.Y - aMouseY, 0, myHUD.SizeY );
    }
    Super.PlayerInput( DeltaTime );
}

DefaultProperties
{
}
