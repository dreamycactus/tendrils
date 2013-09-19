class AwesomeSeqAct_GetWeaponLevel extends SequenceAction;

var int WeaponLevel;

event Activated()
{
	local PlayerController PC;

	PC = GetWorldInfo().GetALocalPlayerController();
	if ( PC != none && PC.Pawn != none && AwesomeWeapon( PC.Pawn.Weapon ) != none ) {
		WeaponLevel = AwesomeWeapon( PC.Pawn.Weapon ).CurrentWeaponLevel;
	}
}
defaultproperties
{
	ObjName="Get Weapon Level"
	ObjCategory="AwesomeGame"
	VariableLinks(0)=(ExpectedType=class'SeqVar_Int',LinkDesc="WeaponLevel",PropertyName=WeaponLevel,bWriteable=true)
}
