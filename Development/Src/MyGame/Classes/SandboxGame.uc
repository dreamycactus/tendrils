class SandboxGame extends UDKGame;

var SandboxRoomContainer Rooms;
var int test;
var vector V;
var int once;

event PostBeginPlay()
{
	local SandboxRoomContainer R;
    super.PostBeginPlay();
	
    foreach DynamicActors( class'SandboxRoomContainer', R ){
		Rooms = R;
		break;
	}
}

event Tick( float DeltaTime ) 
{
	if ( Rooms == none ) {
		`log( "======ROOMS NONE=====" );
	} else {
		`log( "Moving room============" );
		Rooms.Move( vect( 0.0, 5.0, 0.0 ) );
	}
}

DefaultProperties
{
	bDelayedStart=false //We want to jump straight into the game
    DefaultPawnClass = class'MyGame.SandboxPawn'
	PlayerControllerClass = class'MyGame.SandboxPlayerController'
	test = 100;
}
