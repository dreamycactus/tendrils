class DrInventoryManager extends UTInventoryManager;

var int SelectedIndex;
var int MaxSlots;
var int ItemCount;
var float LastItemAdjust;

function bool HandlePickupQuery( class<Inventory> ItemClass, Actor Pickup )
{
    if ( ItemCount >= MaxSlots ) {
        return false;
    }
    return true;
}

reliable client function SetCurrentWeapon( Weapon DesiredWeapon )
{
    if ( DrWeapon( DesiredWeapon ) == none || DrPawn( Instigator ) == none ) {
		`warn( "In SetCurrentWeapon of InvMgr of " @ Instigator @ " Weapon and Pawn " @ DesiredWeapon @ Instigator );
    }
    super.SetCurrentWeapon( DesiredWeapon );
	Instigator.GroundSpeed = DrPawn( Instigator ).WalkSpeed - DrWeapon( DesiredWeapon ).SpeedPenalty;

}

simulated function DrWeapon GetBestMeleeWeapon()
{
    local DrWeapon W, BestW;

    foreach InventoryActors( class'DrWeapon', W ) {
        if ( !W.bMeleeWeapon ) {
            continue;
        }
        BestW = W;
    }

    return BestW;
}

simulated function ClientWeaponSet(Weapon NewWeapon, bool bOptionalSet, optional bool bDoNotActivate)
{
	if ( bDoNotActivate ) {
		NewWeapon.GotoState('Inactive');
		return;
	}
	
	super.ClientWeaponSet( NewWeapon, bOptionalSet,  );
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

function int GetNumItems()
{
	local Inventory Item;
	local int Sum;

	Sum = 0;
	foreach InventoryActors( class'Inventory', Item ) {
		++Sum;
	}

	return Sum;
}

simulated function AdjustItem( int NewOffset )
{
	local array<UTWeapon> WeaponList;

	// don't allow multiple weapon switches very close to one another (seems to happen with some mouse wheels)
	if ( WorldInfo.TimeSeconds - LastItemAdjust < 0.05 ) {
		return;
	}
	LastItemAdjust = WorldInfo.TimeSeconds;


   	GetWeaponList( WeaponList,,, false );
   	if ( WeaponList.length == 0 ){
   		return;
   	}

	SelectedIndex += NewOffset;
	if ( SelectedIndex < 0 ) {
		SelectedIndex += WeaponList.Length;
	} else if ( SelectedIndex >= WeaponList.Length ) {
		SelectedIndex -= WeaponList.Length;
	}

	if ( DrWeapon( WeaponList[SelectedIndex] ) != none ) {
		SetCurrentWeapon( WeaponList[SelectedIndex] );
	}

}

DefaultProperties
{
}