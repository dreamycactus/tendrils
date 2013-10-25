class DebugCon extends Pawn;

var DrSectionDoppler Dop;

exec function MoveDown()
{
	local vector Off;
	Off.Z = -10;
	Dop.SetLocation( Location + Off );
}

DefaultProperties
{
}
