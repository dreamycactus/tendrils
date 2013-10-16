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

DefaultProperties
{
    Health=100
    HealthMax=100
}
