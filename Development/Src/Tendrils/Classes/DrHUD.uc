class DrHUD extends HUD;

var const Texture2D CursorTexture;
var const Color     CursorColor;
var bool bDrawAimline;
const Logging = false;

event PostRender()
{
    local DrMouseInput  MouseInput;
    local Vector HitLoc;
    local Color LineCol;

    if ( PlayerOwner != none && CursorTexture != none ) {
        MouseInput = DrMouseInput( PlayerOwner.PlayerInput );

        if ( MouseInput != none ) {
            Canvas.SetPos( MouseInput.MousePos.X, MouseInput.MousePos.Y );
            Canvas.DrawColor = CursorColor;
            Canvas.DrawTile( CursorTexture, CursorTexture.SizeX, CursorTexture.SizeY, 0.0f, 0.0f, CursorTexture.SizeX, CursorTexture.SizeY,,true );
        }
    }
    
    Super.PostRender();

    HitLoc = GetMouseWorldLoc();

	if ( bDrawAimline ) {
		LineCol.A = 200;
		LineCol.R = 100;
		Draw2DLine( self.SizeX/2, self.SizeY/2, MouseInput.MousePos.X, MouseInput.MousePos.Y, LineCol );
	}

}

function Vector GetMouseWorldLoc()
{
    local DrMouseInput  MouseInput;
    local Vector2d      MousePosition;
    local Vector        MouseWorldOrg, MouseWorldDir, HitLoc, HitNorm;

    /* Error checking */
    if ( Canvas == none || PlayerOwner == none ) { return vect( 0.0, 0.0, 0.0 ); }

    MouseInput = DrMouseInput( PlayerOwner.PlayerInput );
    if ( MouseInput == none ) { return vect( 0.0, 0.0, 0.0 );}

    /* Deproject */
    MousePosition.X = MouseInput.MousePos.X;
    MousePosition.Y = MouseInput.MousePos.Y;
    Canvas.DeProject( MousePosition, MouseWorldOrg, MouseWorldDir );
    DrPlayerController( PlayerOwner ).MouseWorldOrg = MouseWorldOrg;
    DrPlayerController( PlayerOwner ).MousePosWorldDir = MouseWorldDir;

    Trace( HitLoc, HitNorm, MouseWorldOrg + MouseWorldDir * 65536.f, MouseWorldOrg, true,,, TRACEFLAG_Bullet );
    return HitLoc;
}

DefaultProperties
{
    CursorColor=(R=255,G=255,B=255,A=255)
    CursorTexture=Texture2D'EngineResources.Cursors.Arrow'
    bDrawAimline=true
}
