class DrPawn extends UTPawn;

enum EArmorType
{
    LIGHT,
    MEDIUM,
    HEAVY
};

var int ArmorAmt;
var int ArmorMax;
var EArmorType ArmorType;

var float CurSpeed;
var float WalkSpeed;
var float RunSpeed;
var float StunSpeed;

var float PainRegen;
var float Pain;
var float PainMax;

var float RecoilRegen;
var float RecoilShake;
var float RecoilMax;

state SRun
{
}

state SWalk
{
}

state SDead
{
}

simulated event BecomeViewTarget( PlayerController PC )
{
   local UTPlayerController UTPC;

   Super.BecomeViewTarget( PC );

   if (LocalPlayer( PC.Player ) != None)
   {
      UTPC = UTPlayerController(PC);
      if (UTPC != None)
      {
         //set player controller to behind view and make mesh visible
         UTPC.SetBehindView(true);
         SetMeshVisibility(UTPC.bBehindView); 
         UTPC.bNoCrosshair = true;
      }
   }
}


DefaultProperties
{
	bFollowPlayerRotation=false;
    Health=100
    HealthMax=100
}
