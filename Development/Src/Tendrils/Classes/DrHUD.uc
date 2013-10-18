class DrHUD extends HUD;

var DrInventoryManagerRookie  InvMgr;
var const   Texture2D   CursorTexture;
var const   Color       CursorColor;
var         bool        bDrawAimline;

event PostRender()
{
    local DrMouseInput  MouseInput;
    local Vector HitLoc;
    local Color LineCol;
    local Vector2D v2d, fscale;
    local Color col;
    local float XL, YL;
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

    LineCol.A = 200;
    LineCol.R = 100;
    Draw2DLine( self.SizeX/2, self.SizeY/2, MouseInput.MousePos.X, MouseInput.MousePos.Y, LineCol );

    v2d.X = 0.0;
    v2d.Y = 0.0;
    fscale.X = 6.0;
    fscale.Y = 6.0;
    col.A = 256;
    col.R = 256;
    col.G = 256;
    Canvas.SetPos( 0.0, 0.0, );
    Canvas.Font = Font'UI_Fonts.Fonts.UI_Fonts_AmbexHeavy18';
    RenderInventory();
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

function RenderInventory()
{
    local DrItem Inv;
	local int i;
    local float outX, outY;

    Canvas.SetPos( 0.0, 0.0, );
    Canvas.Font = Font'UI_Fonts.Fonts.UI_Fonts_AmbexHeavy18';
    
    i = 0;

	for( Inv = DrItem( InvMgr.InventoryChain ); Inv != none; Inv = DrItem( Inv.Inventory ) ) {
        Canvas.StrLen( Inv, outX, outY );
        Canvas.SetPos( 0.0, outY * i );
        Canvas.DrawText( Inv.GameName,, 1.0, 1.0 );    
        ++i;
	}
}

DefaultProperties
{
    CursorColor=(R=255,G=255,B=255,A=255)
    CursorTexture=Texture2D'EngineResources.Cursors.Arrow'
    bDrawAimline=true
}
