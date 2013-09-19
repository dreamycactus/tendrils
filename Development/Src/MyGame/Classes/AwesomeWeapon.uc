class AwesomeWeapon extends UTWeapon;

var int CurrentWeaponLevel;

const MAXLEVEL = 5;
var float FireRates[MAXLEVEL];

function UpgradeWeapon()
{
	if ( CurrentWeaponLevel < MAXLEVEL ) {
		CurrentWeaponLevel++;
		FireInterval[0] = FireRates[CurrentWeaponLevel - 1];
	}
}

defaultproperties
{
	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'WP_RocketLauncher.Mesh.SK_WP_RocketLauncher_3P'
	End Object

	AttachMentClass=class'UTGameContent.UTAttachment_RocketLauncher'

	WeaponFireTypes(0)=EWFT_Projectile
	WeaponFireTypes(1)=EWFT_Projectile

	WeaponProjectiles(0)=class'UTProj_Rocket'
	WeaponProjectiles(1)=class'UTProj_Rocket'

	AmmoCount=30
	MaxAmmoCount=30

	FireRates(0)=1.5
	FireRates(1)=1.0
	FireRates(2)=0.5
	FireRates(3)=0.3
	FireRates(4)=0.1

}
