class CustomAIController extends AiController;


var Pawn AIControlledPawn;
var int PossesedTeamNumber;
var Pawn player;
var Pawn Target;
var() float CombatDistance;
var Vector MovTarget; //for the "gotothisplace stuff"
var Pawn Shooter;
var rotator CheckAimRotation;
var array<CustomCoverMesh> CoverMesh; //<Thats a class of the cover object right there
var string Direction;


event Possess(Pawn inPawn, bool bVehicleTransition)
{
super.Possess(inPawn, bVehicleTransition);
inPawn.SetMovementPhysics();
AIControlledPawn=inPawn;
}


 Auto state idle
 {
 event HearNoise(float Loudness,Actor NoiseMaker,optional name NoiseType)
 {
 super.HearNoise(Loudness,NoiseMaker,NoiseType);
 WorldInfo.Game.broadcast(self,"I Hear Something");
 Shooter=Pawn(NoiseMaker);
 gotoState('CheckWhereTheShotCameFrom');
 }
 }



 state CheckWhereTheShotCameFrom
 {
 event HearNoise(float Loudness,Actor NoiseMaker,optional name NoiseType)
 {
 super.HearNoise(Loudness,NoiseMaker,NoiseType);

 Shooter=Pawn(NoiseMaker);
 CheckWhoShot();
 GotoState('GetCover');
 }

 Begin:

  WorldInfo.Game.Broadcast(self,"whoIsther");
  CheckWhoShot();
 }



function GetCoverFromEnemy()
{

 local Rotator ShooterDirection;
  local CustomCoverMesh CM;


 foreach DynamicActors(class'CustomCoverMesh',CM)
 {
 CoverMesh[CoverMesh.length] = CM;
 }

ShooterDirection=rotator(Shooter.Location-CoverMesh[0].Location);
ShooterDirection.Yaw=UnrRotToDeg*ShooterDirection.yaw;

WorldInfo.Game.Broadcast(self,CoverMesh[0].Location);
WorldInfo.Game.Broadcast(self,ShooterDirection.yaw);

if(ShooterDirection.yaw>=90)
{
Direction="Infront";

}
if(ShooterDirection.yaw<=1)
{
Direction="Back";

}

}

State takeCoverBack
{
local vector BackLocation;

 begin:
 BackLocation=CoverMesh[0].Location;
 BackLocation.X=BackLocation.X+20;

 MoveTo(BackLocation);
}

State TakeCoverFront
{
local vector FrontLocation;

 begin:
 FrontLocation=CoverMesh[0].Location;
  FrontLocation.X=FrontLocation.X-20;
 MoveTo(FrontLocation);

}

state GetCover
{
event HearNoise(float Loudness,Actor NoiseMaker,optional name NoiseType)
 {
 local Pawn Noiser;
 super.HearNoise(Loudness,NoiseMaker,NoiseType);

 Shooter=Pawn(NoiseMaker);
 GetCoverFromEnemy();
 if(Direction=="Back")
 {
 GotoState('takeCoverBack');
 }

 if(Direction=="Infront")
 {
 GotoState('TakeCoverFront');
 }
 }
Begin:

GetCoverFromEnemy();

}

 //CheckWhereIsThePawnWhoShotandgetthepostion
 Function CheckWhoShot()
{
CheckAimrotation =  rotator(Shooter.location - AIControlledPawn.Location);
AIControlledPawn.SetViewRotation(CheckAimRotation);
AIControlledPawn.SetRotation(CheckAimRotation);
CheckaimRotation.Yaw=UnrRotToDeg*CheckAimRotation.yaw;
WorldInfo.Game.Broadcast(self,CheckAimRotation.yaw);
}



DefaultProperties
{

}