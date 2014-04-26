class DrWeapRocket extends UTWeap_LinkGun;

function class<Projectile> GetProjectileClass()
{
	return class'UTProj_Rocket';
}

DefaultProperties
{
    WeaponProjectiles(0)=class'UTProj_Rocket'
    FireInterval(0) = 0.5
}
