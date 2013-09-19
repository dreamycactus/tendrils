class AwesomeSeqAct_SpawnerActivation extends SequenceAction;

DefaultProperties
{
	ObjName="Spawner Activation"
	ObjCategory="AwesomeGame"
	VariableLinks.Empty
}

event Activated()
{
	if ( AwesomeGame( GetWorldInfo().Game ) != none ) {
		AwesomeGame( GetWorldInfo().Game ).ActivateSpawners();
	}
}