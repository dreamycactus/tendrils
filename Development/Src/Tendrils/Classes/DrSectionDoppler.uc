class DrSectionDoppler extends DrSection
	placeable;

var bool bRoomCollisionFlag;
var DrSection Section;
var DebugCon Con;
var array<DrSectionDopplite> Dopplites;

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
    bRoomCollisionFlag = true;
}

function DestroyDopple();

static function DrSectionDoppler SpawnDopple( DrSection Section, vector NewLoc )
{
	local DrSectionDoppler Dopple;
    local InterpActor IA;
	local DrSectionLink Link;
	local DrSectionDopplite Dlite;
    local vector ItemOffset;
	local int i;

	Dopple = Section.Spawn( class'DrSectionDoppler',,, Section.Location + NewLoc, Section.Rotation );
    Dopple.Section = Section;

    for ( i = 0; i < Section.VolumeHint.Bases.Length; ++i ) {
        IA = Section.VolumeHint.Bases[i];
		if ( IA.StaticMeshComponent.StaticMesh == none ) {
			`log( IA @ "is an empty interpactor!!" );
			continue;
		}
        ItemOffset = IA.Location - Section.Location;
		Dlite = Section.Spawn(  class'DrSectionDopplite',
						Dopple,,
						Dopple.Location + ItemOffset, 
						IA.Rotation );
		Dlite.SetBase( Dopple );
		Dlite.StaticMeshComponent.SetStaticMesh( IA.StaticMeshComponent.StaticMesh );
		Dlite.Dop = Dopple;
		Dopple.Dopplites.AddItem( Dlite );
	}

	Dopple.Graph = new class'DrGraphCmp';
	Dopple.Graph.Current = Dopple;

	for ( i = 0; i < Section.Graph.LinkNodes.Length; ++i ) {
		ItemOffset = Section.Graph.LinkNodes[i].Location - Section.Location;
		Link = Section.Spawn(	class'DrSectionLink',,,
						Dopple.Location + ItemOffset,
						Section.Graph.LinkNodes[i].Rotation );
		Link.Src = Dopple;
		Link.SetBase( Dopple );
		Dopple.Graph.LinkNodes.AddItem( Link );
	}

    return Dopple;
    //Dopple.StaticMeshComponent.SetScale( 0.95 ); // Make doppler scale a little less than room's for robust collision
}

static function DeleteDopple( DrSection Section )
{
	local int i;
    local Actor Dop;

    while ( Section.Dopple.Attached.Length != 0 ) {
        Dop = Section.Dopple.Attached[0];
        Dop.SetBase( none );
        Dop.Destroy();
    }

    Section.Dopple.Dopplites.Length = 0;
	Section.Dopple.Destroy();
    Section.Dopple = none;
}

DefaultProperties
{
    
	//bCollideActors=true
 //   bCollideWorld=true
 //   bBlockActors=false
	//bHardAttach=true

    bRoomCollisionFlag=false
	bIgnoreBaseRotation=false

	////bWorldGeometry=true
	//Physics=PHYS_None
	//bStatic=false
	//bNoDelete=false
	//bCollideWhenPlacing=true
	//bCollideAsEncroacher=true
	//bIgnoreEncroachers=false
	//bAlwaysEncroachCheck=true
	//bCollideAsEncroacher=true
	//bSkipAttachedMoves=false
    
	//CollisionType=COLLIDE_TouchAll

}