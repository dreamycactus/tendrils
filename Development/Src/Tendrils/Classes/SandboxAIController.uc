class SandboxAIController extends AIController;
 
var Actor target;
var Actor LastKnown;
var bool bTrackingPlayer;

simulated event PostBeginPlay()
{
	LastKnown = Spawn( class
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
        target = Seen;
		
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
        class'NavMeshPath_Toward'.static.TowardGoal( NavigationHandle,target );
        class'NavMeshGoal_At'.static.AtActor( NavigationHandle, target,32 );
 
        // Find path
        return NavigationHandle.FindPath();
    }
Begin:
    if ( CanSee( Pawn( target ) ) ) {
        Pawn.StartFire( 0 );
		LastKnown = target;
		bTrackingPlayer = true;
    } else {
        Pawn.StopFire( 0 );
		LastKnown = 
		bTrackingPlayer = false;
    }

    if( NavigationHandle.ActorReachable( target ) )
    {
        FlushPersistentDebugLines();
 
        //Direct move
        MoveToward( target, target );
    }
    else if( FindNavMeshPath() )
    {
        NavigationHandle.SetFinalDestination( LastKnownPos );
        FlushPersistentDebugLines();
        NavigationHandle.DrawPathCache(,TRUE);
 
        // move to the first node on the path
        if( NavigationHandle.GetNextMoveLocation( LastKnownPos, Pawn.GetCollisionRadius()) )
        {
            DrawDebugLine(Pawn.Location,LastKnownPos,255,0,0,true);
            DrawDebugSphere(LastKnownPos,16,20,255,0,0,true);
            MoveTo( LastKnownPos );
        }
    } else {
        //We can't follow, so get the hell out of this state, otherwise we'll enter an infinite loop.
        GotoState('Idle');
		target = none;
    }

    goto 'Begin';
}
 
DefaultProperties
{
}
//Yep, that's it for now.