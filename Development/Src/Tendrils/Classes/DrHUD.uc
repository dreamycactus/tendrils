class DrHUD extends HUD;

var const Texture2D CursorTexture;
var const Color     CursorColor;

event PostRender()
{
    local DrMouseInput MouseInput;

    if ( PlayerOwner != none && CursorTexture != none ) {
        MouseInput = DrMouseInput( PlayerOwner.PlayerInput );

        if ( MouseInput != none ) {
            Canvas.SetPos( MouseInput.MousePos.X, MouseInput.MousePos.Y );
            Canvas.DrawColor = CursorColor;
            Canvas.DrawTile( CursorTexture, CursorTexture.SizeX, CursorTexture.SizeY, 0.0f, 0.0f, CursorTexture.SizeX, CursorTexture.SizeY,,true );
        }
    }
    Super.PostRender();
}

DefaultProperties
{
    CursorColor=(R=255,G=255,B=255,A=255)
    CursorTexture=Texture2D'EngineResources.Cursors.Arrow'
}
