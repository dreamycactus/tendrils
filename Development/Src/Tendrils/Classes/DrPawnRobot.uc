class DrPawnRobot extends DrPawnGunman
    placeable;

function AddDefaultInventory()
{
    InvManager.CreateInventory( class'UTWeap_LinkGun', true );
}

DefaultProperties
{
    Begin Object class=SkeletalMeshComponent Name=RookiePawnSkeletalMesh
		SkeletalMesh=SkeletalMesh'Bryan.Test'
		AnimSets(0)=AnimSet'Bryan.AnimSet'
		AnimTreeTemplate=AnimTree'Bryan.Test'
        CollideActors=true
        bOverrideAttachmentOwnerVisibility=true
    End Object
    Components.Add(RookiePawnSkeletalMesh)
    Mesh=RookiePawnSkeletalMesh

    InventoryManagerClass=class'UTInventoryManager';
}
