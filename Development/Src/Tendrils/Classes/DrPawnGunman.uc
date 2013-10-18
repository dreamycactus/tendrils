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
        local array<UTWeapon> outWeapList;
        IM = DrInventoryManager( InvManager );

        `log( "Enter walk" );
        
        IM.GetWeaponList( outWeapList,,,false );
    	if ( outWeapList[IM.SelectedIndex] != none ) {
	    	IM.SetCurrentWeapon( outWeapList[IM.SelectedIndex] );
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
        InvManager.SetCurrentWeapon( DrInventoryManager( InvManager ).GetBestMeleeWeapon() );
        GroundSpeed = RunSpeed;
    }
}

DefaultProperties
{
    WalkSpeed=00300.000000
    RunSpeed=00600.000000
    bWeaponAttachmentVisible=true
}
