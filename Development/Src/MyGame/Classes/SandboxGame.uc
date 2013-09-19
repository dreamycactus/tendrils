class SandboxGame extends UDKGame;

event PostBeginPlay()
{
    super.PostBeginPlay();
}

DefaultProperties
{
	bDelayedStart=false //We want to jump straight into the game
    DefaultPawnClass = class'MyGame.SandboxPawn'
	PlayerControllerClass = class'MyGame.SandboxPlayerController'
}
