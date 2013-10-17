class DrInventoryManager extends UTInventoryManager;

var Inventory SelectedItem;

simulated function ClientWeaponSet(Weapon NewWeapon, bool bOptionalSet, optional bool bDoNotActivate)
{
	local Weapon OldWeapon;

	OldWeapon = Instigator.Weapon;

		// If no current weapon, then set this one
		if ( !bDoNotActivate && ( OldWeapon == None || OldWeapon.bDeleteMe || OldWeapon.IsInState('Inactive') ) )
		{
			SetCurrentWeapon(NewWeapon);
			return;
		}

		if ( OldWeapon == NewWeapon )
		{
			return;
		}

		if (!bOptionalSet)
		{
			SetCurrentWeapon(NewWeapon);
			return;
		}

		if (Instigator.IsHumanControlled() && PlayerController(Instigator.Controller).bNeverSwitchOnPickup)
		{
		NewWeapon.GotoState('Inactive');
		return;
	}
	
	if ( OldWeapon.IsFiring() || OldWeapon.DenyClientWeaponSet() && (UTWeapon(NewWeapon) != None) )
	{
		NewWeapon.GotoState('Inactive');
		RetrySwitchTo(UTWeapon(NewWeapon));
			return;
		}

		// Compare switch priority and decide if we should switch to new weapon
		if ( (PendingWeapon == None || !PendingWeapon.HasAnyAmmo() || PendingWeapon.GetWeaponRating() < NewWeapon.GetWeaponRating()) &&
			(!Instigator.Weapon.HasAnyAmmo() || Instigator.Weapon.GetWeaponRating() < NewWeapon.GetWeaponRating()) )
		{
			SetCurrentWeapon(NewWeapon);
			return;
		}

	NewWeapon.GotoState('Inactive');
}


DefaultProperties
{
}