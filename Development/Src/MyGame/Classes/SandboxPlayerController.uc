class SandboxPlayerController extends UDKPlayerController;

var array<Vector> Nav;
var Actor GoalActor;

state PlayerWalking
{
    function PlayerMove(float DeltaTime)
    {
        //local Vector arrow_loc, arrow_dir;
        super.PlayerMove(DeltaTime);

  //      class'NavmeshPath_Toward'.static.TowardGoal(NavigationHandle, GoalActor );
  //      class'NavMeshGoal_At'.static.AtLocation(NavigationHandle, GoalActor.Location );
		//`log( GoalActor.Location );
  //      if (!NavigationHandle.FindPath())
  //      {
  //      }

  //      if (NavigationHandle.GetNextMoveLocation(arrow_dir,64.0))
  //      {
  //          DrawDebugLine(Pawn.Location,arrow_dir,255,0,0,false);
  //      }
		//`log( arrow_dir );
    }
}

simulated event PostBeginPlay()
{
	local UTArmorPickup_BaseArmor Act1;
    super.PostBeginPlay();
 
    NavigationHandle = new(self) class'NavigationHandle';
	foreach AllActors( class'UTArmorPickup_BaseArmor', Act1 ) {
		GoalActor = Act1;
	}
	class'NavMeshGoal_At'.static.AtActor( NavigationHandle, GoalActor );
	class'NavmeshPath_Toward'.static.TowardGoal( NavigationHandle, GoalActor );
}

DefaultProperties
{
	//CameraClass=class'MyGame.SandboxCamera'
}
