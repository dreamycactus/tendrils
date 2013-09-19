class AwesomeHud extends UTGFxHudWrapper;

event DrawHUD()
{
	super.DrawHUD();

	if ( PlayerOwner.Pawn != none && AwesomeWeapon( PlayerOwner.Pawn.Weapon ) != none ) {
		Canvas.DrawColor = WhiteColor;
		Canvas.Font = class'Engine'.static.GetLargeFont();
		Canvas.SetPos( Canvas.ClipX * 0.1, Canvas.ClipY * 0.9 );
		Canvas.DrawText( "Weapon Level" @ AwesomeWeapon( PlayerOwner.Pawn.Weapon ).CurrentWeaponLevel );
	}
}

defaultproperties
{
}
