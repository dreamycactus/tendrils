class DrInventoryManager extends UTInventoryManager;

var Inventory SelectedItem;

simulated function ClientWeaponSet(Weapon NewWeapon, bool bOptionalSet, optional bool bDoNotActivate)
{
	local Weapon OldWeapon;

	OldWeapon = Instigator.Weapon;

	if ( bDoNotActivate ) {
		NewWeapon.GotoState('Inactive');
		return;
	}

	// If no current weapon, then set this one
	if (  ( OldWeapon == None || OldWeapon.bDeleteMe || OldWeapon.IsInState('Inactive') ) )
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

simulated function SetPendingWeapon( Weapon DesiredWeapon )
{
	local UTWeapon PrevWeapon, CurrentPending;
	local UTPawn UTP;

	if (Instigator == None)
	{
		return;
	}

	PrevWeapon = UTWeapon( Instigator.Weapon );
	CurrentPending = UTWeapon(PendingWeapon);

	if ( (PrevWeapon == None || PrevWeapon.AllowSwitchTo(DesiredWeapon)) &&
		(CurrentPending == None || CurrentPending.AllowSwitchTo(DesiredWeapon)) )
	{
		// We only work with UTWeapons
		// Detect that a weapon is being reselected.  If so, notify that weapon.
		if ( DesiredWeapon != None && DesiredWeapon == Instigator.Weapon )
		{
			if (PendingWeapon != None)
			{
				PendingWeapon = None;
			}
			else
			{
				PrevWeapon.ServerReselectWeapon();
			}

			// If this weapon is ready to fire, there is no reason to perform the whole switch logic.
			if (!PrevWeapon.bReadyToFire())
			{
				PrevWeapon.Activate();
			}
			else
			{
				PrevWeapon.bWeaponPutDown = false;
			}
		}
		else
		{
			if ( Instigator.IsHumanControlled() && Instigator.IsLocallyControlled() )
			{
				// preload pending weapon textures, clear any other preloads
				if ( UTWeapon(Instigator.Weapon) != None )
				{
					UTWeapon(Instigator.Weapon).PreloadTextures(false);
				}
				if ( PendingWeapon != None )
				{
					UTWeapon(PendingWeapon).PreloadTextures(false);
				}
				if ( DesiredWeapon != none ) {
	 				UTWeapon(DesiredWeapon).PreloadTextures( true );
				}
			}
			PendingWeapon = DesiredWeapon;

			// if there is an old weapon handle it first.
			if( PrevWeapon != None && !PrevWeapon.bDeleteMe && !PrevWeapon.IsInState('Inactive') )
			{
				PrevWeapon.TryPutDown();
			}
			else
			{
				// We don't have a weapon, force the call to ChangedWeapon
				ChangedWeapon();
			}
		}
	}
	
	UTP = UTPawn(Instigator);
	if (UTP != None)
	{
		UTP.SetPuttingDownWeapon((PendingWeapon != None));
		//if ( DesiredWeapon == none ) {
		//	UTP.CurrentWeaponAttachmentClass = none;
		//}
	}
}


DefaultProperties
{
}