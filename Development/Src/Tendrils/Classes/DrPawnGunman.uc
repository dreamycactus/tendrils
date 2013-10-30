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
}

exec function FIREFIRE()
{
	super.StartFire( 0 );
}

simulated function StartFire( byte FireModeNum )
{
    super.StartFire( FireModeNum );
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
        local array<UTWeapon> outWeapList;
        IM = DrInventoryManager( InvManager );

        `log( "Enter walk" );
        
        IM.GetWeaponList( outWeapList,,,false );
    	if ( outWeapList[IM.SelectedIndex] != none ) {
	    	IM.SetCurrentWeapon( outWeapList[IM.SelectedIndex] );
	    }
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
        InvManager.SetCurrentWeapon( DrInventoryManager( InvManager ).GetBestMeleeWeapon() );
	    //SetWeaponAttachmentVisibility( false );
        //WeaponAttachmentChanged();
    }
}

DefaultProperties
{
    WalkSpeed=00550.000000
    RunSpeed=00600.000000
    bWeaponAttachmentVisible=true
}