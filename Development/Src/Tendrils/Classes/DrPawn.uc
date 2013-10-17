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

var float WalkSpeed;
var float RunSpeed;

var float PainRegen;
var float Pain;
var float PainMax;

var float RecoilRegen;
var float RecoilShake;
var float RecoilMax;

DefaultProperties
{
    Health=100
    HealthMax=100
}
