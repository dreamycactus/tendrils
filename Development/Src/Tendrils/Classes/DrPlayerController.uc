class DrPlayerController extends UTPlayerController;

//function CheckAutoObjective( bool b );

exec function StartFire( optional byte FireModeNum )
{
	if ( WorldInfo.Pauser == PlayerReplicationInfo ) {
		SetPause( false );
		return;
	}

	if ( Pawn != None && !bCinematicMode ) {
		Pawn.StartFire( FireModeNum );
	}
}


function NotifyChangedWeapon( Weapon PrevW, Weapon NewW ) 
{
	super.NotifyChangedWeapon( PrevW, NewW );
	
	NewW.SetHidden( true );
	PrevW.SetHidden( true );

	if ( Pawn == none ) {
		return;
	}
}

//simulated event PostBeginPlay()
//{
//    Super.PostBeginPlay();
//    PlayerCamera.SetFOV( 30.0 );
//    Pawn.CalcCamera( 
//}



//simulated event GetPlayerViewPoint( out vector out_Loc, out Rotator out_Rot )
//{
//	super.GetPlayerViewPoint( out_Loc, out_Rot );
	
//	if ( Pawn != none ) {
//		//out_Loc = CurrentCameraLocation;
//        /* TODO Align rotation to room */
//	    //out_Rot = 
//	}
//}


defaultproperties
{
}