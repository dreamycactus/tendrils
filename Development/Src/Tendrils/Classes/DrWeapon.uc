class DrWeapon extends UTWeapon
    abstract;

var float AP; // Armor piercing value 0 to 1, but values over 1 are ok
var float Acc; // Angle offset determining accuracy
var float RecoilMax;
var float RecoilPerShot;
var float Recoil;
var float StoppingPower;
//var float Weight;

DefaultProperties
{
}
