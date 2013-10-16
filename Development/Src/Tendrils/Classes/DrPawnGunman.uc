class DrPawnGunman extends DrPawn;

simulated event PostBeginPlay()
{
    super.PostBeginPlay();

    foreach InvManager.InventoryActors( class'DrItem', DrInventoryManager( InvManager ).SelectedItem ) {
        break;
    }
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

    	if ( DrWeapon( IM.SelectedItem ) != none ) {
	    	IM.SetCurrentWeapon( IM.SelectedItem );
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
        InvManager.SetCurrentWeapon( none );
        GroundSpeed = RunSpeed;
    }
}

DefaultProperties
{
    WalkSpeed=00300.000000
    RunSpeed=00600.000000
}
