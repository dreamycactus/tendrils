class DrPawnGunman extends DrPawn;

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
}

exec function StartIronsight()
{
}

exec function EndIronsight()
{
}

function Tick( float DT )
{
    `log( "====" @ GetStateName() );
}



state SWalk
{
    function EndIronsight()
    {
        GotoState( 'SRun' );
    }

    simulated function StartFire( byte FireModeNum )
    {
        super.StartFire(  FireModeNum );
    }

    event BeginState( name PrevName )
    {
        local DrInventoryManager IM;
        IM = DrInventoryManager( InvManager );

        `log( "Enter walk" );

    	if ( IM.SelectedItem != none ) {
	    	IM.SetCurrentWeapon( Weapon( IM.SelectedItem ) );
            //WeaponAttachmentChanged();
	    }
        GroundSpeed = WalkSpeed;
    }
}

auto state SRun
{
    function StartIronsight()
    {
        GotoState( 'SWalk' );
    }

    simulated function StartFire( byte FireModeNum )
    {
    }

    event BeginState( name PrevName )
    {
        `log( "Enter run" );
			SetPuttingDownWeapon( true ); 
        
        GroundSpeed = RunSpeed;
	    //SetWeaponAttachmentVisibility( false );
        //WeaponAttachmentChanged();
    }
}

DefaultProperties
{
    WalkSpeed=00300.000000
    RunSpeed=00600.000000
}
