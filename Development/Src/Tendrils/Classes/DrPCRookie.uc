class DrPCRookie extends DrPlayerController;

reliable client function ClientSetHUD(class<HUD> newHUDType)
{
    super.ClientSetHUD( newHUDType );
    DrHUD( myHUD ).InvMgr = DrInventoryManagerRookie( Pawn.InvManager );
}

DefaultProperties
{

}
