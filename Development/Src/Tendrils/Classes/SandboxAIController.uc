class SandboxAIController extends AIController;

var Actor Rookie;
var Actor target;
var Actor LastKnown;
var Vector TempDest;
var Vector tempV;
var bool bTrackingPlayer;

simulated event PostBeginPlay()
{
	local vector V;

	super.PostBeginPlay();
	v.Z = Location.Z;
	LastKnown = Spawn( class'DrPawnRookieLastKnown',,, V );
}

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition); Pawn.SetMovementPhysics();
    bAdvancedTactics = true;
    bForceStrafe = true;
} //I'm adding an default idle state so the Pawn doesn't try to follow a player that doesn' exist yet.

auto state Idle
{
    event SeePlayer (Pawn Seen)
    {
        super.SeePlayer(Seen);
        Rookie = Seen;
		
        GotoState('Searching');
    }
Begin:
}

state Searching
{
    ignores SeePlayer;
    function bool FindNavMeshPath()
    {
        // Clear cache and constraints (ignore recycling for the moment)
        NavigationHandle.PathConstraintList = none;
        NavigationHandle.PathGoalList = none;
 
        // Create constraints
        class'NavMeshPath_Toward'.static.TowardGoal( NavigationHandle, target );
        class'NavMeshGoal_At'.static.AtActor( NavigationHandle, target, 32 );
 
        // Find path
        return NavigationHandle.FindPath();
    }
Begin:
    if ( CanSee( Pawn( Rookie ) ) && VSize(Rookie.Location - Pawn.Location ) < 1200 ) {
        Pawn.StartFire( 0 );
		if ( !bTrackingPlayer ) {
			bTrackingPlayer = true;
			target = Rookie;
			tempV = Location;
			tempV.Z = 10000;
			LastKnown.SetLocation( tempV );
		}
    } else {
        Pawn.StopFire( 0 );
		if ( bTrackingPlayer ) {
			bTrackingPlayer = false;
			LastKnown.SetLocation( Rookie.Location );
			target = LastKnown;
		}
    }

    if( NavigationHandle.ActorReachable( target ) )
    {
        FlushPersistentDebugLines();
 
        //Direct move
        MoveToward( target, target );
    }
    else if( FindNavMeshPath() )
    {
        NavigationHandle.SetFinalDestination( target.Location );
        //FlushPersistentDebugLines();
        //NavigationHandle.DrawPathCache(,TRUE);
 
        // move to the first node on the path
        if( NavigationHandle.GetNextMoveLocation( TempDest, Pawn.GetCollisionRadius()) )
        {
            //DrawDebugLine( Pawn.Location, TempDest, 255, 0, 0, true );
            //DrawDebugSphere( TempDest,16,20,255,0,0,true);
            MoveTo( TempDest );
        }
    } else {
        //We can't follow, so get the hell out of this state, otherwise we'll enter an infinite loop.
        GotoState('Idle');
		Rookie = none;
    }

    goto 'Begin';
}
 
DefaultProperties
{
}
//Yep, that's it for now.