class DrZombieClaw extends Weapon;

function TraceSwing()
{
	local Actor HitActor;
	local Vector HitLoc, HitNorm, LeftSock, RightSock, Momentum;
	local int DamageAmount;

	LeftSock = GetSock(Name("DualWeaponPoint"));
	RightSock = GetSock(Name("WeaponPoint"));

	DamageAmount = 10;

	foreach TraceActors(class'Actor', HitActor, HitLoc, HitNorm, LeftSock, RightSock)
	{
		if (HitActor != self)
		{
			Momentum = Normal(LeftSock - RightSock);
			HitActor.TakeDamage(DamageAmount, Instigator.Controller, HitLoc, Momentum, class'DamageType');
			//PlaySound(SwordClank);
		}
	}
}

function Vector GetSock(Name SocketName)
{
    local Vector SocketLocation;
    local Rotator SocketRotation;
    local SkeletalMeshComponent SMC;

    SMC = Instigator.Mesh;

    if ( SMC != none && SMC.GetSocketByName(SocketName) != none ) {
        SMC.GetSocketWorldLocationAndRotation(SocketName, SocketLocation, SocketRotation );
    }
    return SocketLocation;
}

simulated state Swinging extends WeaponFiring
{
    event BeginState(Name PrevState) 
    {
        DrPawnZombie(Instigator).Mesh.PlayAnim('claw_animation', 1.0, true, false);
    }
    simulated event Tick(float DeltaTime)
	{
		super.Tick(DeltaTime);
		TraceSwing();
	}

    event EndState(Name NewSt)
    {
        //DrPawnZombie(Instigator).Mesh.PlayAnim('SwingOne', 1.0);
    }
}
DefaultProperties
{
    bMeleeWeapon=true;
	bInstantHit=true;
	bCanThrow=false;

	FiringStatesArray(0)="Swinging"

	WeaponFireTypes(0)=EWFT_Custom

}
